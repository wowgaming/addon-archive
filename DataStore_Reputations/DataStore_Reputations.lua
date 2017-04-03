--[[	*** DataStore_Reputations ***
Written by : Thaoky, EU-Marécages de Zangar
June 22st, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Reputations"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"

local AddonDB_Defaults = {
	global = {
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				Factions = {},
			}
		}
	}
}

local BottomLevels = {
	[-42000] = FACTION_STANDING_LABEL1,	 -- "Hated"
	[-6000] = FACTION_STANDING_LABEL2,	 -- "Hostile"
	[-3000] = FACTION_STANDING_LABEL3,	 -- "Unfriendly"
	[0] = FACTION_STANDING_LABEL4,		 -- "Neutral"
	[3000] = FACTION_STANDING_LABEL5,	 -- "Friendly"
	[9000] = FACTION_STANDING_LABEL6,	 -- "Honored"
	[21000] = FACTION_STANDING_LABEL7,	 -- "Revered"
	[42000] = FACTION_STANDING_LABEL8,	 -- "Exalted"
}

-- ** Mixins **
local function _GetReputationInfo(character, faction)
	local reputationData = character.Factions[faction]		-- Ex "3000|9000|7680"
	if not reputationData then return end

	local bottom, top, earned = strsplit("|", reputationData)
	bottom = tonumber(bottom)
	top = tonumber(top)
	earned = tonumber(earned)
	local rate = (earned - bottom) / (top - bottom) * 100

	-- ex: "Revered", 15400, 21000, 73%
	return BottomLevels[bottom], (earned - bottom), (top - bottom), rate 
end

local function _GetRawReputationInfo(character, faction)
	-- same as GetReputationInfo, but returns raw values
	local reputationData = character.Factions[faction]		-- Ex "3000|9000|7680"
	if not reputationData then return end

	local bottom, top, earned = strsplit("|", reputationData)
	return tonumber(bottom), tonumber(top), tonumber(earned)
end

local function _GetReputations(character)
	return character.Factions
end

local PublicMethods = {
	GetReputationInfo = _GetReputationInfo,
	GetRawReputationInfo = _GetRawReputationInfo,
	GetReputations = _GetReputations,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetReputationInfo")
	DataStore:SetCharacterBasedMethod("GetRawReputationInfo")
	DataStore:SetCharacterBasedMethod("GetReputations")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE")
	addon:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
end

-- *** Utility functions ***

-- *** Scanning functions ***
local headersState = {}

local function SaveHeaders()
	local headerCount = 0		-- use a counter to avoid being bound to header names, which might not be unique.
	
	for i = GetNumFactions(), 1, -1 do		-- 1st pass, expand all categories
		local _, _, _, _, _, _, _,	_, isHeader, isCollapsed = GetFactionInfo(i)
		if isHeader then
			headerCount = headerCount + 1
			if isCollapsed then
				ExpandFactionHeader(i)
				headersState[headerCount] = true
			end
		end
	end
end

local function RestoreHeaders()
	local headerCount = 0
	for i = GetNumFactions(), 1, -1 do
		local _, _, _, _, _, _, _,	_, isHeader = GetFactionInfo(i)
		if isHeader then
			headerCount = headerCount + 1
			if headersState[headerCount] then
				CollapseFactionHeader(i)
			end
		end
	end
	wipe(headersState)
end

local function ScanReputations()
	SaveHeaders()

	local factions = addon.ThisCharacter.Factions
	wipe(factions)
	
	for i = 1, GetNumFactions() do		-- 2nd pass, data collection
		local name, _, _, bottom, top, earned, _,	_, isHeader, _, hasRep = GetFactionInfo(i)
		if (not isHeader) or (isHeader and hasRep) then
			-- new in 3.0.2, headers may have rep, ex: alliance vanguard + horde expedition
			factions[name] = bottom .. "|" .. top .. "|" .. earned
		end
	end

	RestoreHeaders()
	
	addon.ThisCharacter.lastUpdate = time()
end

local PT = LibStub("LibPeriodicTable-3.1")
local BF = LibStub("LibBabble-Faction-3.0"):GetUnstrictLookupTable()

function addon:GetSource(searchedID)
	-- returns the faction where a given item ID can be obtained, as well as the level
	local level, repData = PT:ItemInSet(searchedID, "Reputation.Reward")
	if level and repData then
		local _, _, faction = strsplit(".", repData)		-- ex: "Reputation.Reward.Sporeggar"
		faction = BF[faction] or faction		-- localize faction name if possible
	
		-- level = 7,  29150:7 where 7 means revered
		return faction, _G["FACTION_STANDING_LABEL"..level]
	end
end

-- *** EVENT HANDLERS ***
function addon:PLAYER_ALIVE()
	ScanReputations()
end

-- this turns
--	"Reputation with %s increased by %d."
-- into
--	"Reputation with (.+) increased by (%d+)."
local repUpMsg = gsub(FACTION_STANDING_INCREASED, "%%s", "(.+)")
repUpMsg = gsub(repUpMsg, "%%d", "(%%d+)")

function addon:CHAT_MSG_COMBAT_FACTION_CHANGE(event, text)
	-- This code is a bit more complex than calling ScanReputations again.
	-- The purpose is to avoid triggering UPDATE_FACTION, as this may result in heavy processing in other addons
	if not text then return end
	
	local faction, value = text:match(repUpMsg)
	if faction and value then
		local bottom, top, earned = DataStore:GetRawReputationInfo(DataStore:GetCharacter(), faction)
		
		if earned then
			local newValue = earned + tonumber(value)
			if newValue >= top then	-- rep status increases (to revered, etc..)
				ScanReputations()					-- so scan all
			else
				addon.ThisCharacter.Factions[faction] = bottom .. "|" .. top .. "|" .. newValue
				addon.ThisCharacter.lastUpdate = time()
			end
		else	-- faction not in the db, scan all
			ScanReputations()	
		end
	end
end
