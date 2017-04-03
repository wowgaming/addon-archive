--[[

LibPossessions: A library for accessing inventory information from other mods
Copyright (c) 2007 Robert Clark <nogudnik@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

]]--

local MAJOR_VERSION = "LibPossessions"
local MINOR_VERSION = tonumber(("$Revision: 160 $"):match("(%d+)"))
local COMMON_API    = "Common API" -- do not localize

-- Ace addons will store realm data under "realm - faction"
local playerrealm = GetRealmName():trim()
local _,race = UnitRace("player")
local faction
if race == "Orc" or race == "Scourge" or race == "Troll" or race == "Tauren" or race == "BloodElf" then
	faction = FACTION_HORDE
else
	faction = FACTION_ALLIANCE
end

-- ========================================================================
--                              Utility Code
-- ========================================================================
--
-- Prints a message to the chat window.
--
local function print(message)
	local s = "|cffffff7f" .. MAJOR_VERSION .. "-" .. tostring(MINOR_VERSION) .. "|r: "
	DEFAULT_CHAT_FRAME:AddMessage(s .. message)
end

--
-- Prints the provided message to the chat window if debugging is enabled
--
local debug_on = false
local function debug(message)
	if debug_on then print(message) end
end

-- ========================================================================
--                            Sanity2 Methods
-- ========================================================================

-- Returns the total count of the provided item id across all characters
-- for which Sanity2 has data.
local function sanity_GetItemCount(item)
	local name = GetItemInfo(item)

	local owners = Sanity:GetOwnersFor(name)
	if not owners then return 0 end

	local count = 0
	for char,v in pairs(owners) do
		local i = 0
		for loc, ct in pairs(v) do
			count = count + ct
		end
	 end

	 return count
end

-- ========================================================================
--                            Bagnon_Forever Methods
-- ========================================================================

-- Returns the total count of the provided item id across all characters
-- for which Bagnon_Forever has data.
local function bagnondb_GetItemCount(item)
	local itemLink = select(2, GetItemInfo(item))
	local count = 0
	for playerName in BagnonDB:GetPlayers() do
		for bag=0,NUM_BAG_SLOTS do
			count = count + BagnonDB:GetItemCount(itemLink, bag, playerName)
		end
	end

	return count
end

-- ========================================================================
--                   Character Info Storage Methods
-- ========================================================================

-- Returns the total count of the provided item id across all characters
-- for which Character Info Storage has data.
local function characterinfostorage_GetItemCount(itemid)
	local count = 0
	local characters = CharacterInfoStorage:GetCharacters()

	for _,name in pairs(characters) do
		local has = CharacterInfoStorage:GetNumItems(name, itemid)
		count = count + CharacterInfoStorage:GetNumItems(name, itemid)
	end

	return count
end

-- ========================================================================
--                        BankItems Methods
-- ========================================================================
local function bankitems_GetItemCount(itemid)
	local count = 0

	-- List of bag numbers used internally by BankItems
	-- Don't include bag 103 (contains items on AH)
	local BAGNUMBERS = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 100, 101, 102, -2}

	-- kind of icky, this requires way too much knowledge about the
	-- internal structure of the BankItems data storage. This is extracted
	-- from the BankItems_Search method

	playerrealm = strtrim(playerrealm)

	for key, bankPlayer in pairs(BankItems_Save) do
		local player, realm = strsplit("|", key)
		if type(bankPlayer) == "table" and realm == playerrealm then
			for num = 1, 28 do
				if bankPlayer[num] then
					local id = select(3, string.find(bankPlayer[num].link, "|Hitem:(%d+):"))
					if tonumber(id) == itemid then
						count = count + (bankPlayer[num].count or 1)
					end
				end
			end
			for _, bagNum in ipairs(BAGNUMBERS) do
				local theBag = bankPlayer["Bag"..bagNum]
				if theBag then
					local realSize = theBag.size
					if bagNum == 101 or bagNum == 103 then
						realSize = #theBag
					end
					for bagItem = 1, realSize do
						if theBag[bagItem] then
							local id = select(3, string.find(theBag[bagItem].link, "|Hitem:(%d+):"))
							if tonumber(id) == itemid then
								count = count + (theBag[bagItem].count or 1)
							end
						end
					end
				end
			end
		end
	end

	return count
end

-- ========================================================================
--                        Possessions Methods
-- ========================================================================
local function possessions_GetItemCount(itemid)
	local count = 0

	if not PossessionsData or not PossessionsData[playerrealm] then
		-- error message here?
		return 0
	end

	for charName, charData in pairs(PossessionsData[playerrealm]) do
		for _, bag in pairs(charData.items) do
			for _, item in pairs(bag) do
				local id = item[0]
				if id then
					_,_,id = string.find(id, "^(%d+):?")
					id = tonumber(id)
					if itemid == id then
						count = count + (item[3] or 0)
					end
				 end
			end
		end
	end

	return count
end

-- ========================================================================
--                        BankList Methods
-- ========================================================================
local function banklist_GetItemCount(itemid)
	local count = 0

	if not BankList.db or not BankList.db.realm or not BankList.db.realm.chars then
		-- error here?
		return
	end

	for charName, charData in pairs(BankList.db.realm.chars) do
		for _, bag in pairs(charData.bags) do
			for _, itemData in pairs(bag) do
				local id = itemData.id:match('item:(%d+)')
				if id then
					id = tonumber(id)
					if id == itemid then
						count = count + (itemData.count or 0)
					end
				end
			end
		end
	end

	return count
end

-- ========================================================================
--                        OneView (OneBag) Methods
-- ========================================================================
local function oneview_GetItemCount(itemid)
	local count = 0

	local list = OneView.storage:GetCharListByServerId()
	for serverId, v in pairs(list) do
		local fact = v.faction
		for k, v2 in ipairs(v) do
			local _, _, charName, charId = string.find(v2, "([^%-]+) . (.+)")
			for bag = -1, 11 do
				local itemId, size, isAmmo, isSoul, isProf = OneView.storage:BagInfo(fact, charId, bag)
				for slot = 1, (tonumber(size) or 0) do
					local bag_itemId, qty = OneView.storage:SlotInfo(fact, charId, bag, slot)
					if bag_itemId then
						local id = bag_itemId:match('item:(%d+)')
						if id then id = tonumber(id) else id = -1 end
						if id == itemid then
							if type(qty) == "string" then qty = tonumber(qty) end
							count = count + qty
						end
					end
				end
			end
		end
	end

	return count
end

-- ========================================================================
--                         Library Initialization
-- ========================================================================

local LibPossessions, oldMinor = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not LibPossessions then
	-- A copy of this particular library has already been loaded
	return
end

local oldLib
if oldMinor then
	-- Another (older) version of LibPossessions has been loaded,
	-- stuff all our methods and data into that library.
	oldLib = {}
	for k, v in pairs(LibPossessions) do
		oldLib[k] = v
		LibPossessions[k] = nil
	end
	setmetatable(oldLib, getmetatable(LibPossessions))
	setmetatable(LibPossessions, nil)
end

-- And put the newly created/discovered library into the global namespace
_G.LibPossessions = LibPossessions

-- Need a frame to register event handler's with
LibPossessions.frame = (oldLib and oldLib.frame) or (_G.CreateFrame("Frame"))
local frame = LibPossessions.frame

-- And a place to cache item lookups, for speed.
LibPossessions.cache = (oldLib and oldLib.cache) or ( {n = 0} )
local cache = LibPossessions.cache

-- And the version of the library
LibPossessions.version = (oldLib and oldLib.version) or (MAJOR_VERSION .. "-" .. MINOR_VERSION)

-- @table supportedAddons
-- @brief A list of the inventory addons supported by this library
LibPossessions.supportedAddons = (oldLib and oldLib.supportedAddons) or {
	-- GetInventoryCount might be nil and that would remove the entry
	-- [COMMON_API]                = (GetInventoryCount or ""),
	["CharacterInfoStorage"]    = characterinfostorage_GetItemCount,
	["Sanity2"]                 = sanity_GetItemCount,
	["BankItems"]               = bankitems_GetItemCount,
	["Possessions"]             = possessions_GetItemCount,
	["BankList"]                = banklist_GetItemCount,
	["Bagnon_Forever"]          = bagnondb_GetItemCount,
	["OneView"]                 = oneview_GetItemCount, -- Requires OneBag and OneBank as well.
}

-- Currently selected inventory addon
LibPossessions.inventoryAddon = oldLib and oldLib.inventoryAddon or nil

-- Tracks when the number of items on hand changes. This invalidates our local cache
frame:RegisterEvent("BAG_UPDATE")
frame:RegisterEvent("TRADE_CLOSED")
frame:RegisterEvent("UNIT_INVENTORY_CHANGED")

--
-- Searches for a supported addon. Does nothing is an addon has
-- already been found
--
local function find_supported_addon(lib)
	if not lib.inventoryAddon then
		-- Always check for the common API first
		if GetInventoryCount then
			debug("Using common API")
			lib.inventoryAddon = COMMON_API
		else
			for i=1, GetNumAddOns() do
				local name = GetAddOnInfo(i)
				for k, v in pairs(lib.supportedAddons) do
					if k == name and IsAddOnLoaded(name) then
						-- found one!
						lib:SetInventoryAddon(k)
						return
					end
				end
				-- debug("Skipped: " .. name)
			end
		end
	end
end

frame:SetScript("OnEvent", function(this, event, ...)
	if cache.n > 0 then
		-- All other events are ones that invalidate the cache

		-- I'd love to be smart enough to save at least some of
		-- the cache, but that is just too risky.
		for k in pairs(cache) do
			cache[k] = nil
		end
		cache.n = 0
	end
end)

-- ========================================================================
--                              Public API
-- ========================================================================

--
-- @method      SetInventoryAddon
-- @brief       Sets the name of the add on to be used for collecting
--              inventory information. This must be one of the addons
--              supported by this library.
-- @param addon Name of the addon to use.
-- @return      true if the addon is usable and false if it is not.
--
function LibPossessions:SetInventoryAddon(addon)
	if IsAddOnLoaded(addon) and self.supportedAddons[addon] then
		self.inventoryAddon = addon
		debug("Using " .. addon .. " as the inventory addon")
		return true
	else
		error(MAJOR_VERSION .. ": Cannot use " .. addon .. " as an inventory addon as it is not supported")
		return false
	end
end

--
-- @method      IsAvailable
-- @brief       Checks to see whether or not a support
--              inventory mod is available
-- @return      true is a supported mod was found or false otherwise
--
function LibPossessions:IsAvailable()
	find_supported_addon(self)
	return self.inventoryAddon ~= nil
end

--
-- @method      GetVersion
-- @brief       Gets the version of the current library
-- @return      The vesion of the LibPossessions library currently in use.
--
function LibPossessions:GetVersion()
	return self.version
end

--
-- @method      GetSupportedAddons
-- @brief       Lists the addon supported by this library. Addons in the
--              list may or may not be loaded
-- @return      The list of supported inventory addon names
--
function LibPossessions:GetSupportedAddons()
	local addons = {}

	for name,_ in pairs(self.supportedAddons) do
		table.insert(addons, name)
	end

	return addons
end

--
-- @method      GetSelectedAddon
-- @brief       The name of the addon currently selected to provide
--              inventory information or nil if no addon is selected
-- @return      The name of the inventory addon currently being used
--
function LibPossessions:GetSelectedAddon()
	find_supported_addon(self)
	return self.inventoryAddon
end

--
-- @method      GetItemCount
-- @brief       Returns the number of items across all alts (including
--              the current character)
-- @param item  The itemID of the item your are interested
-- @return      The count of the specified it across all characters, or 0
--
function LibPossessions:GetItemCount(item)

	if type(item) ~= "number" then item = tonumber(item) end

	if cache[item] then
		return cache[item]
	end

	find_supported_addon(self)

	local count

	if not self:IsAvailable() then
		count = 0
	else
		local method = self.supportedAddons[self.inventoryAddon]
		local ok,count = pcall(method, item)
		if not ok then
			print("Unable to obtain items counts using " .. self.inventoryAddon .. ": " .. count .. ". Will no longer use that addon")
			self.supportedAddons[self.inventoryAddon] = nil -- remove it from the list
			self.inventoryAddon = nil
			count = 0
		else
			count = tonumber(count)
			cache[item] = count
			cache.n = cache.n + 1
		end
	end

	return count
end
