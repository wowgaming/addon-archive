--[[	*** DataStore_Currencies ***
Written by : Thaoky, EU-Marécages de Zangar
July 6th, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Currencies"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"

local AddonDB_Defaults = {
	global = {
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				Currencies = {},
			}
		}
	}
}

-- *** Utility functions ***
local headersState = {}
local headerCount

local function SaveHeaders()
	headerCount = 0		-- use a counter to avoid being bound to header names, which might not be unique.
	
	for i = GetCurrencyListSize(), 1, -1 do		-- 1st pass, expand all categories
		local _, isHeader, isExpanded = GetCurrencyListInfo(i)
		if isHeader then
			headerCount = headerCount + 1
			if not isExpanded then
				ExpandCurrencyList(i, 1)
				headersState[headerCount] = true
			end
		end
	end
end

local function RestoreHeaders()
	headerCount = 0
	for i = GetCurrencyListSize(), 1, -1 do
		local _, isHeader = GetCurrencyListInfo(i)
		if isHeader then
			headerCount = headerCount + 1
			if headersState[headerCount] then
				ExpandCurrencyList(i, 0)		-- collapses the header
			end
		end
	end
	wipe(headersState)
end

-- *** Scanning functions ***
local function ScanCurrencies()
	SaveHeaders()
	
	local currencies = addon.ThisCharacter.Currencies
	wipe(currencies)
	
	for i = 1, GetCurrencyListSize() do
		local name, isHeader, _, _, _, count, _, _, itemID = GetCurrencyListInfo(i);

		name = name or ""
		if isHeader then
			currencies[i] = "0|" .. name
		else
			currencies[i] = "1|" .. name .. "|" .. (count or 0) .. "|" .. (itemID or 0)
		end
	end
	
	RestoreHeaders()
	
	addon.ThisCharacter.lastUpdate = time()
end

-- *** Event Handlers ***
local function OnCurrencyDisplayUpdate()
	ScanCurrencies()
end

-- ** Mixins **
local function _GetNumCurrencies(character)
	return #character.Currencies
end

local function _GetCurrencyInfo(character, index)
	local currency = character.Currencies[index]
	local isHeader, name, count, itemID = strsplit("|", currency)
	
	isHeader = (isHeader == "0" and true or nil)
	
	return isHeader, name, tonumber(count), tonumber(itemID)
end

local function _GetCurrencyInfoByName(character, token)
	local name, count, itemID
	
	for i = 1, #character.Currencies do
		_, name, count, itemID = strsplit("|", character.Currencies[i])
	
		if name == token then	-- if it's the token we're looking for, return
			return tonumber(count), tonumber(itemID)
		end
	end
end

local currencyIDs = {
	-- source : http://www.wowhead.com/?items=10
	
	-- epic
	[29434] = true,		-- badge of justice
	[45624] = true,		-- emblem of conquest
	[40752] = true,		-- emblem of heroism
	[47241] = true,		-- emblem of triumph
	[40753] = true,		-- emblem of valor
	[49426] = true,		-- emblem of frost (3.3)
	
	-- blue
	[43228] = true,		-- stone keeper's shard
	
	-- green
	[20560] = true,		-- alterac mark of honor
	[20559] = true,		-- arathi basin mark of honor
	[43016] = true,		-- dalaran cooking award
	[41596] = true,		-- dalaran jewelcrafting token
	[29024] = true,		-- eots mark of honor
	[47395] = true,		-- isle of conquest mark of honor
	[42425] = true,		-- strand of the ancients mark of honor
	[20558] = true,		-- warsong gulch mark of honor
	[43589] = true,		-- wintergrasp mark of honor
	
	-- white
	[43307] = true,		-- arena points
	[44990] = true,		-- champion's seal
	[43308] = true,		-- honor points
	[37836] = true,		-- venture coin
}

local function _GetCurrencyItemCount(character, searchedID)
	if currencyIDs[searchedID] then
		local isHeader, currencyCount, itemID
		
		for i = 1, #character.Currencies do
			isHeader, _, currencyCount, itemID = strsplit("|", character.Currencies[i])
		
			if isHeader == "1" then
				if tonumber(itemID) == searchedID then
					return tonumber(currencyCount)
				end
			end
		end
	end
	
	return 0
end

local PublicMethods = {
	GetNumCurrencies = _GetNumCurrencies,
	GetCurrencyInfo = _GetCurrencyInfo,
	GetCurrencyInfoByName = _GetCurrencyInfoByName,
	GetCurrencyItemCount = _GetCurrencyItemCount,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetNumCurrencies")
	DataStore:SetCharacterBasedMethod("GetCurrencyInfo")
	DataStore:SetCharacterBasedMethod("GetCurrencyInfoByName")
	DataStore:SetCharacterBasedMethod("GetCurrencyItemCount")
end

function addon:OnEnable()
	addon:RegisterEvent("CURRENCY_DISPLAY_UPDATE", OnCurrencyDisplayUpdate)
end

function addon:OnDisable()
	addon:UnregisterEvent("CURRENCY_DISPLAY_UPDATE")
end
