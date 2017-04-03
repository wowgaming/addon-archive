--[[
	Database.lua
		BagnonForever's implementation of BagnonDB
--]]

BagnonDB = CreateFrame('GameTooltip', 'BagnonDB', nil, 'GameTooltipTemplate')
BagnonDB:SetScript('OnEvent', function(self, event, arg1)
	if arg1 == 'Bagnon_Forever' then
		self:UnregisterEvent('ADDON_LOADED')
		self:Initialize()
	end
end)
BagnonDB:RegisterEvent('ADDON_LOADED')

--constants
local L = BAGNON_FOREVER_LOCALS
local CURRENT_VERSION = GetAddOnMetadata('Bagnon_Forever', 'Version')
local NUM_EQUIPMENT_SLOTS = 19

--locals
local currentPlayer = UnitName('player') --the name of the current player that's logged on
local currentRealm = GetRealmName() --what currentRealm we're on
local playerList --a sorted list of players


--[[ Local Functions ]]--

local function ToIndex(bag, slot)
	if tonumber(bag) then
		return (bag < 0 and bag*100 - slot) or bag*100 + slot
	end
	return bag .. slot
end

local function ToBagIndex(bag)
	return (tonumber(bag) and bag*100) or bag
end

--returns the full item link only for items that have enchants/suffixes, otherwise returns the item's ID
local function ToShortLink(link)
	if link then
		local a,b,c,d,e,f,g,h = link:match('(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+)')
		if(b == '0' and b == c and c == d and d == e and e == f and f == g) then
			return a
		end
		return format('item:%s:%s:%s:%s:%s:%s:%s:%s', a, b, c, d, e, f, g, h)
	end
end

local function GetBagSize(bag)
	if bag == KEYRING_CONTAINER then
		return GetKeyRingSize()
	end
	if bag == 'e' then
		return NUM_EQUIPMENT_SLOTS
	end
	return GetContainerNumSlots(bag)
end


--[[ Addon Loading ]]--

function BagnonDB:Initialize()
	self:LoadSettings()

	self:SetScript('OnEvent', function(self, event, ...)
		if self[event] then
			self[event](self, event, ...)
		end
	end)

	if IsLoggedIn() then
		self:PLAYER_LOGIN()
	else
		self:RegisterEvent('PLAYER_LOGIN')
	end
end

function BagnonDB:LoadSettings()
	if not(BagnonForeverDB and BagnonForeverDB.version) then
		BagnonForeverDB = {version = CURRENT_VERSION}
	else
		local cMajor, cMinor = CURRENT_VERSION:match('(%d+)%.(%d+)')
		local major, minor = BagnonForeverDB.version:match('(%d+)%.(%d+)')

		if major ~= cMajor then
			BagnonForeverDB = {version = cVersion}
		elseif minor ~= cMinor then
			self:UpdateSettings()
		end

		if BagnonForeverDB.version ~= CURRENT_VERSION then
			self:UpdateVersion()
		end
	end

	self.db = BagnonForeverDB
	if not self.db[currentRealm] then
		self.db[currentRealm] = {}
	end
	self.rdb = self.db[currentRealm]

	if not self.rdb[currentPlayer] then
		self.rdb[currentPlayer] = {}
	end
	self.pdb = self.rdb[currentPlayer]
end

function BagnonDB:UpdateSettings()
end

function BagnonDB:UpdateVersion()
	BagnonForeverDB.version = CURRENT_VERSION
	print(format('BagnonForever: Updated to v%s', BagnonForeverDB.version))
end


--[[  Events ]]--

function BagnonDB:PLAYER_LOGIN()
	self:SaveMoney()
	self:UpdateBag(BACKPACK_CONTAINER)
	self:UpdateBag(KEYRING_CONTAINER)
	self:SaveEquipment()
	self:SaveNumBankSlots()

	self:RegisterEvent('BANKFRAME_OPENED')
	self:RegisterEvent('BANKFRAME_CLOSED')
	self:RegisterEvent('PLAYER_MONEY')
	self:RegisterEvent('BAG_UPDATE')
	self:RegisterEvent('PLAYERBANKSLOTS_CHANGED')
	self:RegisterEvent('UNIT_INVENTORY_CHANGED')
	self:RegisterEvent('PLAYERBANKBAGSLOTS_CHANGED')
end

function BagnonDB:PLAYER_MONEY()
	self:SaveMoney()
end

function BagnonDB:BAG_UPDATE(event, bag)
	if not(bag == BANK_CONTAINER or bag > NUM_BAG_SLOTS) or self.atBank then
		self:OnBagUpdate(bag)
	end
end

function BagnonDB:PLAYERBANKSLOTS_CHANGED()
	self:UpdateBag(BANK_CONTAINER)
end

function BagnonDB:PLAYERBANKBAGSLOTS_CHANGED()
	self:SaveNumBankSlots()
end

function BagnonDB:BANKFRAME_OPENED()
	self.atBank = true

	self:UpdateBag(BANK_CONTAINER)
	for i = 1, GetNumBankSlots() do
		self:UpdateBag(i + 4)
	end
end

function BagnonDB:BANKFRAME_CLOSED()
	self.atBank = nil
end

function BagnonDB:UNIT_INVENTORY_CHANGED(event, unit)
	if unit == 'player' then
		self:SaveEquipment()
	end
end


--[[
	Access  Functions
		Bagnon requires all of these functions to be present when attempting to view cached data
--]]

--[[
	BagnonDB:GetPlayerList()
		returns:
			iterator of all players on this realm with data
		usage:
			for playerName, data in BagnonDB:GetPlayers()
--]]
function BagnonDB:GetPlayerList()
	if(not playerList) then
		playerList = {}

		for player in self:GetPlayers() do
			table.insert(playerList, player)
		end

		--sort by currentPlayer first, then alphabetically
		table.sort(playerList, function(a, b)
			if(a == currentPlayer) then
				return true
			elseif(b == currentPlayer) then
				return false
			end
			return a < b
		end)
	end
	return playerList
end

function BagnonDB:GetPlayers()
	return pairs(self.rdb)
end


--[[
	BagnonDB:GetMoney(player)
		args:
			player (string)
				the name of the player we're looking at.  This is specific to the current realm we're on

		returns:
			(number) How much money, in copper, the given player has
--]]
function BagnonDB:GetMoney(player)
	local playerData = self.rdb[player]
	if playerData then
		return playerData.g or 0
	end
	return 0
end



--[[
	BagnonDB:GetNumBankSlots(player)
		args:
			player (string)
				the name of the player we're looking at.  This is specific to the current realm we're on

		returns:
			(number or nil) How many bank slots the current player has purchased
--]]
function BagnonDB:GetNumBankSlots(player)
	local playerData = self.rdb[player]
	if playerData then
		return playerData.numBankSlots
	end
end


--[[
	BagnonDB:GetBagData(bag, player)
		args:
			player (string)
				the name of the player we're looking at.  This is specific to the current realm we're on
			bag (number)
				the number of the bag we're looking at.

		returns:
			size (number)
				How many items the bag can hold (number)
			hyperlink (string)
				The hyperlink of the bag
			count (number)
				How many items are in the bag.  This is used by ammo and soul shard bags
--]]
function BagnonDB:GetBagData(bag, player)
	local playerDB = self.rdb[player]
	if playerDB then
		local bagInfo = playerDB[ToBagIndex(bag)]
		if bagInfo then
			local size, link, count = strsplit(',', bagInfo)
			local hyperLink = (link and select(2, GetItemInfo(link))) or nil
			return tonumber(size), hyperLink, tonumber(count) or 1, GetItemIcon(link)
		end
	end
end

--[[
	BagnonDB:GetItemData(bag, slot, player)
		args:
			player (string)
				the name of the player we're looking at.  This is specific to the current realm we're on
			bag (number)
				the number of the bag we're looking at.
			itemSlot (number)
				the specific item slot we're looking at

		returns:
			hyperLink (string)
				The hyperLink of the item
			count (number)
				How many of there are of the specific item
			texture (string)
				The filepath of the item's texture
			quality (number)
				The numeric representaiton of the item's quality: from 0 (poor) to 7 (artifcat)
--]]
function BagnonDB:GetItemData(bag, slot, player)
	local playerDB = self.rdb[player]
	if playerDB then
		local itemInfo = playerDB[ToIndex(bag, slot)]
		if itemInfo then
			local link, count = strsplit(',', itemInfo)
			if link then
				local hyperLink, quality = select(2, GetItemInfo(link))
				return hyperLink, tonumber(count) or 1, GetItemIcon(link), tonumber(quality)
			end
		end
	end
end

--[[
	Returns how many of the specific item id the given player has in the given bag
--]]
function BagnonDB:GetItemCount(itemLink, bag, player)
	local total = 0
	local itemLink = select(2, GetItemInfo(ToShortLink(itemLink)))
	local size = (self:GetBagData(bag, player)) or 0
	for slot = 1, size do
		local link, count = self:GetItemData(bag, slot, player)
		if link == itemLink then
			total = total + (count or 1)
		end
	end

	return total
end

--[[
	Storage Functions
		How we store the data (duh)
--]]


--[[  Storage Functions ]]--

function BagnonDB:SaveMoney()
	self.pdb.g = GetMoney()
end

function BagnonDB:SaveNumBankSlots()
	self.pdb.numBankSlots = GetNumBankSlots()
end

--saves all the player's equipment data information
function BagnonDB:SaveEquipment()
	for slot = 0, NUM_EQUIPMENT_SLOTS do
		local link = GetInventoryItemLink('player', slot)
		local index = ToIndex('e', slot)

		if link then
			local link = ToShortLink(link)
			local count =  GetInventoryItemCount('player', slot)
			count = count > 1 and count or nil

			if(link and count) then
				self.pdb[index] = format('%s,%d', link, count)
			else
				self.pdb[index] = link
			end
		else
			self.pdb[index] = nil
		end
	end
end

--saves data about a specific item the current player has
function BagnonDB:SaveItem(bag, slot)
	local texture, count = GetContainerItemInfo(bag, slot)

	local index = ToIndex(bag, slot)

	if texture then
		local link = ToShortLink(GetContainerItemLink(bag, slot))
		count = count > 1 and count or nil

		if(link and count) then
			self.pdb[index] = format('%s,%d', link, count)
		else
			self.pdb[index] = link
		end
	else
		self.pdb[index] = nil
	end
end

--saves all information about the given bag, EXCEPT the bag's contents
function BagnonDB:SaveBag(bag)
	local data = self.pdb
	local size = GetBagSize(bag)
	local index = ToBagIndex(bag)

	if size > 0 then
		local equipSlot = bag > 0 and ContainerIDToInventoryID(bag)
		local link = ToShortLink(GetInventoryItemLink('player', equipSlot))
		local count =  GetInventoryItemCount('player', equipSlot)
		if count < 1 then
			count = nil
		end

		if(size and link and count) then
			self.pdb[index] = format('%d,%s,%d', size, link, count)
		elseif(size and link) then
			self.pdb[index] = format('%d,%s', size, link)
		else
			self.pdb[index] = size
		end
	else
		self.pdb[index] = nil
	end
end

--saves both relevant information about the given bag, and all information about items in the given bag
function BagnonDB:UpdateBag(bag)
	self:SaveBag(bag)
	for slot = 1, GetBagSize(bag) do
		self:SaveItem(bag, slot)
	end
end

function BagnonDB:OnBagUpdate(bag)
	if self.atBank then
		for i = 1, (NUM_BAG_SLOTS + GetNumBankSlots()) do
			self:SaveBag(i)
		end
	else
		for i = 1, NUM_BAG_SLOTS do
			self:SaveBag(i)
		end
	end

	for slot = 1, GetBagSize(bag) do
		self:SaveItem(bag, slot)
	end
end


--[[ Removal Functions ]]--

--removes all saved data about the given player
function BagnonDB:RemovePlayer(player, realm)
	local realm = realm or currentRealm
	local rdb = self.db[realm]
	if rdb then
		rdb[player] = nil
	end

	if realm == currentRealm and playerList then
		for i,character in pairs(playerList) do
			if(character == player) then
				table.remove(playerList, i)
				break
			end
		end
	end
end