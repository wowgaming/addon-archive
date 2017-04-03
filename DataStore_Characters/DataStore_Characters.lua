--[[	*** DataStore_Characters ***
Written by : Thaoky, EU-Marécages de Zangar
July 18th, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Characters"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"

local AddonDB_Defaults = {
	global = {
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				-- ** General Stuff **
				lastUpdate = nil,		-- last time this char was updated. Set at logon & logout
				name = nil,				-- to simplify processing a bit, the name is saved in the table too, in addition to being part of the key
				level = nil,
				race = nil,
				englishRace = nil,
				class = nil,
				englishClass = nil,	-- "WARRIOR", "DRUID" .. english & caps, regardless of locale
				faction = nil,
				gender = nil,			-- UnitSex
				lastLogoutTimestamp = nil,
				money = nil,
				played = 0,				-- /played, in seconds
				zone = nil,				-- character location
				subZone = nil,
				
				-- ** XP **
				XP = nil,				-- current level xp
				XPMax = nil,			-- max xp at current level 
				RestXP = nil,
				isResting = nil,		-- nil = out of an inn
				
				-- ** Guild  **
				guildName = nil,		-- nil = not in a guild, as returned by GetGuildInfo("player")
				guildRankName = nil,
				guildRankIndex = nil,
			}
		}
	}
}

-- *** Scanning functions ***
local function ScanPlayerLocation()
	local character = addon.ThisCharacter
	character.zone = GetRealZoneText()
	character.subZone = GetSubZoneText()
end

-- *** Event Handlers ***
local function OnPlayerGuildUpdate()
	-- at login this event is called between OnEnable and PLAYER_ALIVE, where GetGuildInfo returns a wrong value
	-- however, the value returned here is correct
	if IsInGuild() then
		-- find a way to improve this, it's minor, but it's called too often at login
		local name, rank, index = GetGuildInfo("player")
		if name and rank and index then
			local character = addon.ThisCharacter
			character.guildName = name
			character.guildRankName = rank
			character.guildRankIndex = index
		end
	end
end

local function OnPlayerUpdateResting()
	addon.ThisCharacter.isResting = IsResting();
end

local function OnPlayerXPUpdate()
	local character = addon.ThisCharacter
	
	character.XP = UnitXP("player")
	character.XPMax = UnitXPMax("player")
	character.RestXP = GetXPExhaustion() or 0
end

local function OnPlayerMoney()
	addon.ThisCharacter.money = GetMoney();
end

local function OnPlayerAlive()
	local character = addon.ThisCharacter

	character.name = UnitName("player")		-- to simplify processing a bit, the name is saved in the table too, in addition to being part of the key
	character.level = UnitLevel("player")
	character.race, character.englishRace = UnitRace("player")
	character.class, character.englishClass = UnitClass("player")
	character.gender = UnitSex("player")
	character.faction = UnitFactionGroup("player")
	character.lastLogoutTimestamp = 0
	character.lastUpdate = time()
	
	OnPlayerMoney()
	OnPlayerXPUpdate()
	OnPlayerUpdateResting()
	OnPlayerGuildUpdate()
end

local function OnPlayerLogout()
	addon.ThisCharacter.lastLogoutTimestamp = time()
	addon.ThisCharacter.lastUpdate = time()
end

-- ** Mixins **
local function _GetCharacterName(character)
	return character.name
end

local function _GetCharacterLevel(character)
	return character.level or 0
end

local function _GetCharacterRace(character)
	return character.race or "", character.englishRace or ""
end

local function _GetCharacterClass(character)
	return character.class or "", character.englishClass or ""
end

local ClassColors = {
	["MAGE"] = "|cFF69CCF0",
	["WARRIOR"] = "|cFFC79C6E",
	["HUNTER"] = "|cFFABD473",
	["ROGUE"] = "|cFFFFF569",
	["WARLOCK"] = "|cFF9482CA", 
	["DRUID"] = "|cFFFF7D0A", 
	["SHAMAN"] = "|cFF2459FF",
	["PALADIN"] = "|cFFF58CBA", 
	["PRIEST"] = "|cFFFFFFFF",
	["DEATHKNIGHT"] = "|cFFC41F3B"
}

local function _GetColoredCharacterName(character)
	return ClassColors[character.englishClass] .. character.name
end
	
local function _GetClassColor(character)
	-- return just the color of this character's class
	return ClassColors[character.englishClass]
end

local function _GetCharacterFaction(character)
	return character.faction or ""
end
	
local function _GetColoredCharacterFaction(character)
	if character.faction == "Alliance" then
		return "|cFF2459FF" .. FACTION_ALLIANCE
	else
		return "|cFFFF0000" .. FACTION_HORDE
	end
end

local function _GetCharacterGender(character)
	return character.gender or ""
end

local function _GetLastLogout(character)
	return character.lastLogoutTimestamp or 0
end

local function _GetMoney(character)
	return character.money or 0
end

local function _GetXP(character)
	return character.XP or 0
end

local function _GetXPRate(character)
	return floor((character.XP / character.XPMax) * 100)
end

local function _GetXPMax(character)
	return character.XPMax or 0
end

local function _GetRestXP(character)
	return character.RestXP or 0
end

local function _GetRestXPRate(character)
	-- after extensive tests, it seems that the known formula to calculate rest xp is incorrect.
	-- I believed that the maximum rest xp was exactly 1.5 level, and since 8 hours of rest = 5% of a level
	-- being 100% rested would mean having 150% xp .. but there's a trick...
	-- One would expect that 150% of rest xp would be split over the following levels, and that calculating the exact amount of rest
	-- would require taking into account that 30% are over the current level, 100% over lv+1, and the remaining 20% over lv+2 ..
	
	-- .. But that is not the case.Blizzard only takes into account 150% of rest xp AT THE CURRENT LEVEL RATE.
	-- ex: at level 15, it takes 13600 xp to go to 16, therefore the maximum attainable rest xp is:
	--	136 (1% of the level) * 150 = 20400 

	-- thus, to calculate the exact rate (ex at level 15): 
		-- divide xptonext by 100 : 		13600 / 100 = 136	==> 1% of the level
		-- multiply by 1.5				136 * 1.5 = 204
		-- divide rest xp by this value	20400 / 204 = 100	==> rest xp rate
	
	local rate = 0
	if character.RestXP then
		rate = (character.RestXP / ((character.XPMax / 100) * 1.5))
	end
	
	-- get the known rate of rest xp (the one saved at last logout) + the rate represented by the elapsed time since last logout
	-- (elapsed time / 3600) * 0.625 * (2/3)  simplifies to elapsed time / 8640
	-- 0.625 comes from 8 hours rested = 5% of a level, *2/3 because 100% rested = 150% of xp (1.5 level)

	if character.lastLogoutTimestamp ~= 0 then		-- time since last logout, 0 for current char, <> for all others
		if character.isResting then
			rate = rate + ((time() - character.lastLogoutTimestamp) / 8640)
		else
			rate = rate + ((time() - character.lastLogoutTimestamp) / 34560)	-- 4 times less if not at an inn
		end
	end
	return rate
end

local function _IsResting(character)
	return character.isResting
end
	
local function _GetGuildInfo(character)
	return character.guildName, character.guildRankName, character.guildRankIndex
end

local function _GetPlayTime(character)
	return character.played
end

local function _GetLocation(character)
	return character.zone, character.subZone
end

local PublicMethods = {
	GetCharacterName = _GetCharacterName,
	GetCharacterLevel = _GetCharacterLevel,
	GetCharacterRace = _GetCharacterRace,
	GetCharacterClass = _GetCharacterClass,
	GetColoredCharacterName = _GetColoredCharacterName,
	GetClassColor = _GetClassColor,
	GetCharacterFaction = _GetCharacterFaction,
	GetColoredCharacterFaction = _GetColoredCharacterFaction,
	GetCharacterGender = _GetCharacterGender,
	GetLastLogout = _GetLastLogout,
	GetMoney = _GetMoney,
	GetXP = _GetXP,
	GetXPRate = _GetXPRate,
	GetXPMax = _GetXPMax,
	GetRestXP = _GetRestXP,
	GetRestXPRate = _GetRestXPRate,
	IsResting = _IsResting,
	GetGuildInfo = _GetGuildInfo,
	GetPlayTime = _GetPlayTime,
	GetLocation = _GetLocation,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetCharacterName")
	DataStore:SetCharacterBasedMethod("GetCharacterLevel")
	DataStore:SetCharacterBasedMethod("GetCharacterRace")
	DataStore:SetCharacterBasedMethod("GetCharacterClass")
	DataStore:SetCharacterBasedMethod("GetColoredCharacterName")
	DataStore:SetCharacterBasedMethod("GetClassColor")
	DataStore:SetCharacterBasedMethod("GetCharacterFaction")
	DataStore:SetCharacterBasedMethod("GetColoredCharacterFaction")
	DataStore:SetCharacterBasedMethod("GetCharacterGender")
	DataStore:SetCharacterBasedMethod("GetLastLogout")
	DataStore:SetCharacterBasedMethod("GetMoney")
	DataStore:SetCharacterBasedMethod("GetXP")
	DataStore:SetCharacterBasedMethod("GetXPRate")
	DataStore:SetCharacterBasedMethod("GetXPMax")
	DataStore:SetCharacterBasedMethod("GetRestXP")
	DataStore:SetCharacterBasedMethod("GetRestXPRate")
	DataStore:SetCharacterBasedMethod("IsResting")
	DataStore:SetCharacterBasedMethod("GetGuildInfo")
	DataStore:SetCharacterBasedMethod("GetPlayTime")
	DataStore:SetCharacterBasedMethod("GetLocation")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("PLAYER_LOGOUT", OnPlayerLogout)
	addon:RegisterEvent("PLAYER_LEVEL_UP")
	addon:RegisterEvent("PLAYER_MONEY", OnPlayerMoney)
	addon:RegisterEvent("PLAYER_XP_UPDATE", OnPlayerXPUpdate)
	addon:RegisterEvent("PLAYER_UPDATE_RESTING", OnPlayerUpdateResting)
	addon:RegisterEvent("PLAYER_GUILD_UPDATE", OnPlayerGuildUpdate)				-- for gkick, gquit, etc..
	addon:RegisterEvent("ZONE_CHANGED", ScanPlayerLocation)
	addon:RegisterEvent("ZONE_CHANGED_NEW_AREA", ScanPlayerLocation)
	addon:RegisterEvent("ZONE_CHANGED_INDOORS", ScanPlayerLocation)
	addon:RegisterEvent("TIME_PLAYED_MSG")
	
	RequestTimePlayed()	-- trigger a TIME_PLAYED_MSG event
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("PLAYER_LOGOUT")
	addon:UnregisterEvent("PLAYER_LEVEL_UP")
	addon:UnregisterEvent("PLAYER_MONEY")
	addon:UnregisterEvent("PLAYER_XP_UPDATE")
	addon:UnregisterEvent("PLAYER_UPDATE_RESTING")
	addon:UnregisterEvent("PLAYER_GUILD_UPDATE")
	addon:UnregisterEvent("ZONE_CHANGED")
	addon:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
	addon:UnregisterEvent("ZONE_CHANGED_INDOORS")
	addon:UnregisterEvent("TIME_PLAYED_MSG")
end

-- *** EVENT HANDLERS ***

function addon:PLAYER_LEVEL_UP(event, newLevel)
	addon.ThisCharacter.level = newLevel
end

function addon:TIME_PLAYED_MSG(event, TotalTime, CurrentLevelTime)
	addon.ThisCharacter.played = TotalTime
end
