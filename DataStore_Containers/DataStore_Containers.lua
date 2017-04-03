--[[	*** DataStore_Containers ***
Written by : Thaoky, EU-Marécages de Zangar
June 21st, 2009

This modules takes care of scanning & storing player bags, bank, & guild banks

Extended services: 
	- guild communication: at logon, sends guild bank tab info (last visit) to guildmates
	- triggers events to manage transfers of guild bank tabs
--]]
if not DataStore then return end

local addonName = "DataStore_Containers"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0", "AceSerializer-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"
local commPrefix = "DS_Cont"		-- let's keep it a bit shorter than the addon name, this goes on a comm channel, a byte is a byte ffs :p
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()

local guildMembers = {} 	-- hash table containing guild member info (tab timestamps)

-- Message types
local MSG_SEND_BANK_TIMESTAMPS				= 1	-- broacast at login
local MSG_BANK_TIMESTAMPS_REPLY				= 2	-- reply to someone else's login
local MSG_BANKTAB_REQUEST						= 3	-- request bank tab data ..
local MSG_BANKTAB_REQUEST_ACK					= 4	-- .. ack the request, tell the requester to wait
local MSG_BANKTAB_REQUEST_REJECTED			= 5	-- .. refuse the request
local MSG_BANKTAB_TRANSFER						= 6	-- .. or send the data

local AddonDB_Defaults = {
	global = {
		Guilds = {
			['*'] = {			-- ["Account.Realm.Name"] 
				money = nil,
				faction = nil,
				Tabs = {
					['*'] = {		-- tabID = table index [1] to [6]
						name = nil,
						icon = nil,
						visitedBy = "",
						ClientTime = 0,				-- since epoch
						ClientDate = nil,
						ClientHour = nil,
						ClientMinute = nil,
						ServerHour = nil,
						ServerMinute = nil,
						ids = {},
						links = {},
						counts = {}
					}
				},
			}
		},
		Characters = {
			['*'] = {					-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				numBagSlots = 0,
				numFreeBagSlots = 0,
				numBankSlots = 0,
				numFreeBankSlots = 0,
				Containers = {
					['*'] = {					-- Containers["Bag0"]
						icon = nil,				-- Containers's texture
						link = nil,				-- Containers's itemlink
						size = 0,
						freeslots = 0,
						bagtype = 0,
						ids = {},
						links = {},
						counts = {},
						cooldowns = {}
					}
				}
			}
		}
	}
}

local function GetDBVersion()
	return addon.db.global.Version or 0
end

local function SetDBVersion(version)
	addon.db.global.Version = version
end

local DBUpdaters = {
	-- Table of functions, each one updates to its index's version
	--	ex: [3] = the function that upgrades from v2 to v3
	[1] = function(self)
	
			local function CopyTable(src, dest)
				for k, v in pairs (src) do
					if type(v) == "table" then
						dest[k] = {}
						CopyTable(v, dest[k])
					else
						dest[k] = v
					end
				end
			end
		
			-- This function moves guild bank tabs from the "Guilds/Guildkey" level to the "Guilds/Guildkey/Tabs" sub-table
			for guildKey, guildTable in pairs(addon.db.global.Guilds) do
				for tabID = 1, 6 do		-- convert the 6 tabs
					if type(guildTable[tabID]) == "table" then
						CopyTable(guildTable[tabID], guildTable.Tabs[tabID])
						wipe(guildTable[tabID])
						guildTable[tabID] = nil						
					end
				end
				guildTable.money = 0
			end
		end,
}

local function UpdateDB()
	local version = GetDBVersion()
	
	for i = (version+1), #DBUpdaters do		-- start from latest version +1 to the very last
		DBUpdaters[i]()
		SetDBVersion(i)
	end
	
	DBUpdaters = nil
	GetDBVersion = nil
	SetDBVersion = nil
end

-- *** Utility functions ***
local function GetThisGuild()
	local guild = GetGuildInfo("player")
	if guild then 
		local key = format("%s.%s.%s", THIS_ACCOUNT, GetRealmName(), guild)
		return addon.db.global.Guilds[key]
	end
end

local function GetBankTimestamps(guild)
	-- returns a | delimited string containing the list of alts in the same guild
	guild = guild or GetGuildInfo("player")
	if not guild then	return end
		
	local thisGuild = GetThisGuild()
	if not thisGuild then return end
	
	local out = {}
	for tabID, tab in pairs(thisGuild.Tabs) do
		if tab.name then
			table.insert(out, format("%d:%s:%d:%d:%d", tabID, tab.name, tab.ClientTime, tab.ServerHour, tab.ServerMinute))
		end
	end
	
	return table.concat(out, "|")
end

local function SaveBankTimestamps(sender, timestamps)
	if strlen(timestamps) == 0 then return end	-- sender has no tabs
	
	guildMembers[sender] = guildMembers[sender] or {}
	wipe(guildMembers[sender])

	for _, v in pairs( { strsplit("|", timestamps) }) do	
		local id, name, clientTime, serverHour, serverMinute = strsplit(":", v)

		-- ex: guildMembers["Thaoky"]["RaidFood"] = {	clientTime = 123, serverHour = ... }
		guildMembers[sender][name] = {}
		local tab = guildMembers[sender][name]
		tab.id = tonumber(id)
		tab.clientTime = tonumber(clientTime)
		tab.serverHour = tonumber(serverHour)
		tab.serverMinute = tonumber(serverMinute)
	end
	addon:SendMessage("DATASTORE_GUILD_BANKTABS_UPDATED", sender)
end

local function GuildBroadcast(messageType, ...)
	local serializedData = addon:Serialize(messageType, ...)
	addon:SendCommMessage(commPrefix, serializedData, "GUILD")
end

local function GuildWhisper(player, messageType, ...)
	if DataStore:IsGuildMemberOnline(player) then
		local serializedData = addon:Serialize(messageType, ...)
		addon:SendCommMessage(commPrefix, serializedData, "WHISPER", player)
	end
end

local function IsEnchanted(link)
	if not link then return end
	
	if not string.find(link, "0:0:0:0:0:0:0") then
		-- enchants/jewels store values instead of zeroes in the link, if this string can't be found, there's at least one enchant/jewel
		return true
	end
end

local BAGS			= 1		-- All bags, 0 to 11, and keyring ( id -2 )
local BANK			= 2		-- 28 main slots
local GUILDBANK	= 3		-- 98 main slots

local ContainerTypes = {
	[BAGS] = {
		GetSize = function(self, bagID)
				return GetContainerNumSlots(bagID)
			end,
		GetFreeSlots = function(self, bagID)
				local freeSlots, bagType = GetContainerNumFreeSlots(bagID)
				return freeSlots, bagType
			end,
		GetLink = function(self, slotID, bagID)
				return GetContainerItemLink(bagID, slotID)
			end,
		GetCount = function(self, slotID, bagID)
				local _, count = GetContainerItemInfo(bagID, slotID)
				return count
			end,
		GetCooldown = function(self, slotID, bagID)
				local startTime, duration, isEnabled = GetContainerItemCooldown(bagID, slotID)
				return startTime, duration, isEnabled
			end,
	},
	[BANK] = {
		GetSize = function(self)
				return NUM_BANKGENERIC_SLOTS or 28		-- hardcoded in case the constant is not set
			end,
		GetFreeSlots = function(self)
				local freeSlots, bagType = GetContainerNumFreeSlots(-1)		-- -1 = player bank
				return freeSlots, bagType
			end,
		GetLink = function(self, slotID)
				return GetInventoryItemLink("player", slotID)
			end,
		GetCount = function(self, slotID)
				return GetInventoryItemCount("player", slotID)
			end,
		GetCooldown = function(self, slotID)
				local startTime, duration, isEnabled = GetInventoryItemCooldown("player", slotID)
				return startTime, duration, isEnabled
			end,
	},
	[GUILDBANK] = {
		GetSize = function(self)
				return MAX_GUILDBANK_SLOTS_PER_TAB or 98		-- hardcoded in case the constant is not set
			end,
		GetFreeSlots = function(self)
				return nil, nil
			end,
		GetLink = function(self, slotID, tabID)
				return GetGuildBankItemLink(tabID, slotID)
			end,
		GetCount = function(self, slotID, tabID)
				local _, count = GetGuildBankItemInfo(tabID, slotID)
				return count
			end,
		GetCooldown = function(self, slotID)
				return nil
			end,
	}
}

-- *** Scanning functions ***
local function ScanContainer(bagID, containerType)
	local Container = ContainerTypes[containerType]
	
	local bag
	if containerType == GUILDBANK then
		local thisGuild = GetThisGuild()
		if not thisGuild then return end
	
		bag = thisGuild.Tabs[bagID]	-- bag is actually the current tab
	else
		bag = addon.ThisCharacter.Containers["Bag" .. bagID]
		wipe(bag.cooldowns)		-- does not exist for a guild bank
	end

	wipe(bag.ids)				-- clean existing bag data
	wipe(bag.counts)
	wipe(bag.links)
	
	local link, count
	local startTime, duration, isEnabled
	
	bag.size = Container:GetSize(bagID)
	bag.freeslots, bag.bagtype = Container:GetFreeSlots(bagID)
	
	-- Scan from 1 to bagsize for normal bags or guild bank tabs, but from 40 to 67 for main bank slots
	local baseIndex = (containerType == BANK) and 39 or 0
	local index
	
	for slotID = baseIndex + 1, baseIndex + bag.size do
		index = slotID - baseIndex
		link = Container:GetLink(slotID, bagID)
		if link then
			bag.ids[index] = tonumber(link:match("item:(%d+)"))

			if IsEnchanted(link) then
				bag.links[index] = link
			end
		
			count = Container:GetCount(slotID, bagID)
			if count and count > 1  then
				bag.counts[index] = count	-- only save the count if it's > 1 (to save some space since a count of 1 is extremely redundant)
			end
		end
		
		startTime, duration, isEnabled = Container:GetCooldown(slotID, bagID)
		if startTime and startTime > 0 then
			bag.cooldowns[index] = startTime .."|".. duration .. "|" .. 1
		end
	end
	
	addon.ThisCharacter.lastUpdate = time()
end

local function ScanBagSlotsInfo()
	local char = addon.ThisCharacter

	local numBagSlots = 0
	local numFreeBagSlots = 0

	for bagID = 0, NUM_BAG_SLOTS do
		local bag = char.Containers["Bag" .. bagID]
		numBagSlots = numBagSlots + bag.size
		numFreeBagSlots = numFreeBagSlots + bag.freeslots
	end
	
	char.numBagSlots = numBagSlots
	char.numFreeBagSlots = numFreeBagSlots
end

local function ScanBankSlotsInfo()
	local char = addon.ThisCharacter
	
	local numBankSlots = NUM_BANKGENERIC_SLOTS
	local numFreeBankSlots = char.Containers["Bag100"].freeslots

	for bagID = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do		-- 5 to 11
		local bag = char.Containers["Bag" .. bagID]
		
		numBankSlots = numBankSlots + bag.size
		numFreeBankSlots = numFreeBankSlots + bag.freeslots
	end
	
	char.numBankSlots = numBankSlots
	char.numFreeBankSlots = numFreeBankSlots
end

local function ScanGuildBankInfo()
	-- only the current tab can be updated
	local thisGuild = GetThisGuild()
	local tabID = GetCurrentGuildBankTab()
	local t = thisGuild.Tabs[tabID]	-- t = current tab

	t.name, t.icon = GetGuildBankTabInfo(tabID)
	t.visitedBy = UnitName("player")
	t.ClientTime = time()
	if GetLocale() == "enUS" then				-- adjust this test if there's demand
		t.ClientDate = date("%m/%d/%Y")
	else
		t.ClientDate = date("%d/%m/%Y")
	end
	t.ClientHour = tonumber(date("%H"))
	t.ClientMinute = tonumber(date("%M"))
	t.ServerHour, t.ServerMinute = GetGameTime()
end

local function ScanBag(bagID)
	if bagID < 0 then return end

	local char = addon.ThisCharacter
	local bag = char.Containers["Bag" .. bagID]
	
	if bagID == 0 then	-- Bag 0	
		bag.icon = "Interface\\Buttons\\Button-Backpack-Up";
		bag.link = nil;
	else						-- Bags 1 through 11
		bag.icon = GetInventoryItemTexture("player", ContainerIDToInventoryID(bagID))
		bag.link = GetInventoryItemLink("player", ContainerIDToInventoryID(bagID))
	end
	ScanContainer(bagID, BAGS)
	ScanBagSlotsInfo()
end

local function ScanKeyRing()
	local char = addon.ThisCharacter
	local bag = char.Containers["Bag" .. KEYRING_CONTAINER]

	bag.icon = "Interface\\Icons\\INV_Misc_Key_14";
	bag.link = nil
	ScanContainer(KEYRING_CONTAINER, BAGS)
end

-- *** Event Handlers ***
local function OnBagUpdate(event, bag)
	if bag < 0 then
		return
	end
	
	if (bag >= 5) and (bag <= 11) and not addon.isBankOpen then
		return
	end
	
	if bag == 0 then					-- bag is 0 for both the keyring and the original backpack
		ScanKeyRing()
	end
	ScanBag(bag)
end

local function OnBankFrameClosed()
	addon.isBankOpen = nil
	addon:UnregisterEvent("BANKFRAME_CLOSED")
	addon:UnregisterEvent("PLAYERBANKSLOTS_CHANGED")
end

local function OnPlayerBankSlotsChanged(event, slotID)
	-- from top left to bottom right, slotID = 1 to 28for main slots, and 29 to 35 for the additional bags
	if (slotID >= 29) and (slotID <= 35) then
		ScanBag(slotID - 24)		-- bagID for bank bags goes from 5 to 11, so slotID - 24
	else
		ScanContainer(100, BANK)
		ScanBankSlotsInfo()
	end
end

local function OnBankFrameOpened()
	addon.isBankOpen = true
	for bagID = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do		-- 5 to 11
		ScanBag(bagID)
	end
	ScanContainer(100, BANK)
	ScanBankSlotsInfo()
	addon:RegisterEvent("BANKFRAME_CLOSED", OnBankFrameClosed)
	addon:RegisterEvent("PLAYERBANKSLOTS_CHANGED", OnPlayerBankSlotsChanged)
end

local function OnGuildBankFrameClosed()
	addon:UnregisterEvent("GUILDBANKFRAME_CLOSED")
	addon:UnregisterEvent("GUILDBANKBAGSLOTS_CHANGED")
	
	local guildName = GetGuildInfo("player")
	if guildName then
		GuildBroadcast(MSG_SEND_BANK_TIMESTAMPS, GetBankTimestamps(guildName))
	end
end

local function OnGuildBankBagSlotsChanged()
	ScanContainer(GetCurrentGuildBankTab(), GUILDBANK)
	ScanGuildBankInfo()
end

local function OnGuildBankFrameOpened()
	addon:RegisterEvent("GUILDBANKFRAME_CLOSED", OnGuildBankFrameClosed)
	addon:RegisterEvent("GUILDBANKBAGSLOTS_CHANGED", OnGuildBankBagSlotsChanged)
	
	local thisGuild = GetThisGuild()
	if thisGuild then
		thisGuild.money = GetGuildBankMoney()
		thisGuild.faction = UnitFactionGroup("player")
	end
end

-- ** Mixins **
local function _GetContainer(character, containerID)
	-- containerID can be number or string
	return character.Containers["Bag" .. containerID]
end

local function _GetContainers(character)
	return character.Containers
end

local BagTypeStrings = {
	[1] = BI["Quiver"],
	[2] = BI["Ammo Pouch"],
	[4] = BI["Soul Bag"],
	[8] = BI["Leatherworking Bag"],
	[16] = BI["Inscription Bag"],
	[32] = BI["Herb Bag"],
	[64] = BI["Enchanting Bag"],
	[128] = BI["Engineering Bag"],
	[512] = BI["Gem Bag"],
	[1024] = BI["Mining Bag"],
}

local function _GetContainerInfo(character, containerID)
	local bag = _GetContainer(character, containerID)
	return bag.icon, bag.link, bag.size, bag.freeslots, BagTypeStrings[bag.bagtype]
end

local function _GetContainerSize(character, containerID)
	-- containerID can be number or string
	return character.Containers["Bag" .. containerID].size
end

local function _GetSlotInfo(bag, slotID)
	assert(type(bag) == "table")		-- this is the pointer to a bag table, obtained through addon:GetContainer()
	assert(type(slotID) == "number")

	-- return itemID, itemLink, itemCount
	return bag.ids[slotID], bag.links[slotID], bag.counts[slotID] or 1
end

local function _GetContainerCooldownInfo(bag, slotID)
	assert(type(bag) == "table")		-- this is the pointer to a bag table, obtained through addon:GetContainer()
	assert(type(slotID) == "number")

	local cd = bag.cooldowns[slotID]
	if cd then
		local startTime, duration, isEnabled = strsplit("|", bag.cooldowns[slotID])
		local remaining = duration - (GetTime() - startTime)
		
		if remaining > 0 then		-- valid cd ? return it
			return tonumber(startTime), tonumber(duration), tonumber(isEnabled)
		end
		-- cooldown expired ? clean it from the db
		bag.cooldowns[slotID] = nil
	end
end

local function _GetContainerItemCount(character, searchedID)
	local bagCount = 0
	local bankCount = 0
	local id
	
	for containerName, container in pairs(character.Containers) do
		for slotID=1, container.size do
			id = container.ids[slotID]
			
			if (id) and (id == searchedID) then
				local itemCount = container.counts[slotID] or 1
				
				if (containerName == "Bag100") then
					bankCount = bankCount + itemCount
				elseif (containerName == "Bag-2") then
					bagCount = bagCount + itemCount
				else
					local bagNum = tonumber(string.sub(containerName, 4))
					if (bagNum >= 0) and (bagNum <= 4) then
						bagCount = bagCount + itemCount
					else
						bankCount = bankCount + itemCount
					end
				end
			end
		end
	end

	return bagCount, bankCount
end

local function _GetNumBagSlots(character)
	return character.numBagSlots
end

local function _GetNumFreeBagSlots(character)
	return character.numFreeBagSlots
end

local function _GetNumBankSlots(character)
	return character.numBankSlots
end

local function _GetNumFreeBankSlots(character)
	return character.numFreeBankSlots
end
	
local function _DeleteGuild(name, realm, account)
	realm = realm or GetRealmName()
	account = account or THIS_ACCOUNT
	
	local key = format("%s.%s.%s", account, realm, name)
	addon.db.global.Guilds[key] = nil
end

local function _GetGuildBankItemCount(guild, searchedID)
	local count = 0
	for _, container in pairs(guild.Tabs) do
	   for slotID, id in pairs(container.ids) do
	      if (id == searchedID) then
	         count = count + (container.counts[slotID] or 1)
	      end
	   end
	end
	return count
end
	
local function _GetGuildBankTab(guild, tabID)
	return guild.Tabs[tabID]
end
	
local function _GetGuildBankTabName(guild, tabID)
	return guild.Tabs[tabID].name
end

local function _GetGuildBankTabIcon(guild, tabID)
	return guild.Tabs[tabID].icon
end

local function _GetGuildBankTabItemCount(guild, tabID, searchedID)
	local count = 0
	local container = guild.Tabs[tabID]
	
	for slotID, id in pairs(container.ids) do
		if (id == searchedID) then
			count = count + (container.counts[slotID] or 1)
		end
	end
	return count
end

local function _GetGuildBankTabLastUpdate(guild, tabID)
	return guild.Tabs[tabID].ClientTime
end

local function _GetGuildBankMoney(guild)
	return guild.money
end

local function _GetGuildBankFaction(guild)
	return guild.faction
end

local function _ImportGuildBankTab(guild, tabID, data)
	wipe(guild.Tabs[tabID])							-- clear existing data
	guild.Tabs[tabID] = data
end

local function _GetGuildBankTabSuppliers()
	return guildMembers
end

local function _GetGuildMemberBankTabInfo(member, tabName)
	-- for the current guild, return the guild member's data about a given tab
	if guildMembers[member] then
		if guildMembers[member][tabName] then
			local tab = guildMembers[member][tabName]
			return tab.clientTime, tab.serverHour, tab.serverMinute
		end
	end
end

local function _RequestGuildMemberBankTab(member, tabName)
	GuildWhisper(member, MSG_BANKTAB_REQUEST, tabName)
end

local function _RejectBankTabRequest(member)
	GuildWhisper(member, MSG_BANKTAB_REQUEST_REJECTED)
end

local function _SendBankTabToGuildMember(member, tabName)
	-- send the actual content of a bank tab to a guild member
	local thisGuild = GetThisGuild()
	if thisGuild then
		local tabID
		if guildMembers[member] then
			if guildMembers[member][tabName] then
				tabID = guildMembers[member][tabName].id
			end
		end	
	
		if tabID then
			GuildWhisper(member, MSG_BANKTAB_TRANSFER, thisGuild.Tabs[tabID])
		end
	end
end

local PublicMethods = {
	GetContainer = _GetContainer,
	GetContainers = _GetContainers,
	GetContainerInfo = _GetContainerInfo,
	GetContainerSize = _GetContainerSize,
	GetSlotInfo = _GetSlotInfo,
	GetContainerCooldownInfo = _GetContainerCooldownInfo,
	GetContainerItemCount = _GetContainerItemCount,
	GetNumBagSlots = _GetNumBagSlots,
	GetNumFreeBagSlots = _GetNumFreeBagSlots,
	GetNumBankSlots = _GetNumBankSlots,
	GetNumFreeBankSlots = _GetNumFreeBankSlots,
	DeleteGuild = _DeleteGuild,
	GetGuildBankItemCount = _GetGuildBankItemCount,
	GetGuildBankTab = _GetGuildBankTab,
	GetGuildBankTabName = _GetGuildBankTabName,
	GetGuildBankTabIcon = _GetGuildBankTabIcon,
	GetGuildBankTabItemCount = _GetGuildBankTabItemCount,
	GetGuildBankTabLastUpdate = _GetGuildBankTabLastUpdate,
	GetGuildBankMoney = _GetGuildBankMoney,
	GetGuildBankFaction = _GetGuildBankFaction,
	ImportGuildBankTab = _ImportGuildBankTab,
	GetGuildMemberBankTabInfo = _GetGuildMemberBankTabInfo,
	RequestGuildMemberBankTab = _RequestGuildMemberBankTab,
	RejectBankTabRequest = _RejectBankTabRequest,
	SendBankTabToGuildMember = _SendBankTabToGuildMember,
	GetGuildBankTabSuppliers = _GetGuildBankTabSuppliers,
}

-- *** Guild Comm ***
--[[	*** Protocol ***

At login: 
	Broadcast of guild bank timers on the guild channel
After the guild bank frame is closed:
	Broadcast of guild bank timers on the guild channel

Client addon calls: DataStore:RequestGuildMemberBankTab()
	Client				Server

	==> MSG_BANKTAB_REQUEST 
	<== MSG_BANKTAB_REQUEST_ACK (immediate ack)   

	<== MSG_BANKTAB_REQUEST_REJECTED (stop)   
	or 
	<== MSG_BANKTAB_TRANSFER (actual data transfer)
--]]

local function OnAnnounceLogin(self, guildName)
	-- when the main DataStore module sends its login info, share the guild bank last visit time across guild members
	local timestamps = GetBankTimestamps(guildName)
	if timestamps then	-- nil if guild bank hasn't been visited yet, so don't broadcast anything
		GuildBroadcast(MSG_SEND_BANK_TIMESTAMPS, timestamps)
	end
end

local function OnGuildMemberOffline(self, member)
	guildMembers[member] = nil
	addon:SendMessage("DATASTORE_GUILD_BANKTABS_UPDATED", member)
end

local GuildCommCallbacks = {
	[MSG_SEND_BANK_TIMESTAMPS] = function(sender, timestamps)
			if sender ~= UnitName("player") then						-- don't send back to self
				local timestamps = GetBankTimestamps()
				if timestamps then
					GuildWhisper(sender, MSG_BANK_TIMESTAMPS_REPLY, timestamps)		-- reply by sending my own data..
				end
			end
			SaveBankTimestamps(sender, timestamps)
		end,
	[MSG_BANK_TIMESTAMPS_REPLY] = function(sender, timestamps)
			SaveBankTimestamps(sender, timestamps)
		end,
	[MSG_BANKTAB_REQUEST] = function(sender, tabName)
			-- trigger the event only, actual response (ack or not) must be handled by client addons
			GuildWhisper(sender, MSG_BANKTAB_REQUEST_ACK)		-- confirm that the request has been received
			addon:SendMessage("DATASTORE_BANKTAB_REQUESTED", sender, tabName)
		end,
	[MSG_BANKTAB_REQUEST_ACK] = function(sender)
			addon:SendMessage("DATASTORE_BANKTAB_REQUEST_ACK", sender)
		end,
	[MSG_BANKTAB_REQUEST_REJECTED] = function(sender)
			addon:SendMessage("DATASTORE_BANKTAB_REQUEST_REJECTED", sender)
		end,
	[MSG_BANKTAB_TRANSFER] = function(sender, data)
			local guildName = GetGuildInfo("player")
			local guild	= GetThisGuild()
			
			for tabID, tab in pairs(guild.Tabs) do
				if tab.name == data.name then	-- this is the tab being updated
					_ImportGuildBankTab(guild, tabID, data)
					addon:SendMessage("DATASTORE_BANKTAB_UPDATE_SUCCESS", sender, guildName, data.name, tabID)
					GuildBroadcast(MSG_SEND_BANK_TIMESTAMPS, GetBankTimestamps(guildName))
				end
			end
		end,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)
	UpdateDB()

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetGuildCommCallbacks(commPrefix, GuildCommCallbacks)
	
	DataStore:SetCharacterBasedMethod("GetContainer")
	DataStore:SetCharacterBasedMethod("GetContainers")
	DataStore:SetCharacterBasedMethod("GetContainerInfo")
	DataStore:SetCharacterBasedMethod("GetContainerSize")
	DataStore:SetCharacterBasedMethod("GetContainerItemCount")
	DataStore:SetCharacterBasedMethod("GetNumBagSlots")
	DataStore:SetCharacterBasedMethod("GetNumFreeBagSlots")
	DataStore:SetCharacterBasedMethod("GetNumBankSlots")
	DataStore:SetCharacterBasedMethod("GetNumFreeBankSlots")
	
	DataStore:SetGuildBasedMethod("GetGuildBankItemCount")
	DataStore:SetGuildBasedMethod("GetGuildBankTab")
	DataStore:SetGuildBasedMethod("GetGuildBankTabName")
	DataStore:SetGuildBasedMethod("GetGuildBankTabIcon")
	DataStore:SetGuildBasedMethod("GetGuildBankTabItemCount")
	DataStore:SetGuildBasedMethod("GetGuildBankTabLastUpdate")
	DataStore:SetGuildBasedMethod("GetGuildBankMoney")
	DataStore:SetGuildBasedMethod("GetGuildBankFaction")
	DataStore:SetGuildBasedMethod("ImportGuildBankTab")
	
	addon:RegisterMessage("DATASTORE_ANNOUNCELOGIN", OnAnnounceLogin)
	addon:RegisterMessage("DATASTORE_GUILD_MEMBER_OFFLINE", OnGuildMemberOffline)
	addon:RegisterComm(commPrefix, DataStore:GetGuildCommHandler())
end

function addon:OnEnable()
	-- manually update bags 0 to 4, then register the event, this avoids reacting to the flood of BAG_UPDATE events at login
	for bagID = 0, NUM_BAG_SLOTS do
		ScanBag(bagID)
	end
	ScanKeyRing()
	
	addon:RegisterEvent("BAG_UPDATE", OnBagUpdate)
	addon:RegisterEvent("BANKFRAME_OPENED", OnBankFrameOpened)
	addon:RegisterEvent("GUILDBANKFRAME_OPENED", OnGuildBankFrameOpened)
end

function addon:OnDisable()
	addon:UnregisterEvent("BAG_UPDATE")
	addon:UnregisterEvent("BANKFRAME_OPENED")
	addon:UnregisterEvent("GUILDBANKFRAME_OPENED")
end
