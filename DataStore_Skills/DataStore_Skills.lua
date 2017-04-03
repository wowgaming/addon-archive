--[[	*** DataStore_Skills ***
Written by : Thaoky, EU-Marécages de Zangar
July 6th, 2009
--]]

if not DataStore then return end

local addonName = "DataStore_Skills"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("DataStore_Skills")

local AddonDB_Defaults = {
	global = {
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				Skills = {
					['*'] = {		-- "Professions", "Secondary Skills", "Class Skills", etc...
						['*'] = nil
					}
				},
			}
		}
	}
}

-- ** Mixins **
local function _GetPrimaryProfessions(character)
	return character.Skills[L["Professions"]]
end

local function _GetSecondaryProfessions(character)
		return character.Skills[L["Secondary Skills"]]
end

local function _GetSkillInfo(character, name)
	for categoryName, category in pairs(character.Skills) do
		for skillName, skill in pairs(category) do
			if skillName == name then
				local skillRank, skillMaxRank = strsplit("|", skill)
				return tonumber(skillRank) or 0, tonumber(skillMaxRank) or 0
			end
		end
	end
	return 0, 0
end

local function _GetSkillInfoByCategory(character, category, name)
	local skillRank, skillMaxRank
	local skill = character.Skills[category][name]
	if skill then
		skillRank, skillMaxRank = strsplit("|", skill)
	end
	return tonumber(skillRank) or 0, tonumber(skillMaxRank) or 0
end

	-- a few shortcuts for commonly used skills
local function _GetFirstAidRank(character)
	return _GetSkillInfoByCategory(character, L["Secondary Skills"], BI["First Aid"])
end

local function _GetCookingRank(character)
	return _GetSkillInfoByCategory(character, L["Secondary Skills"], BI["Cooking"])
end

local function _GetFishingRank(character)
	return _GetSkillInfoByCategory(character, L["Secondary Skills"], BI["Fishing"])
end
	
local function _GetRidingRank(character)
	return _GetSkillInfoByCategory(character, L["Secondary Skills"], L["Riding"])
end

local PublicMethods = {
	GetPrimaryProfessions = _GetPrimaryProfessions,
	GetSecondaryProfessions = _GetSecondaryProfessions,
	GetSkillInfo = _GetSkillInfo,
	GetSkillInfoByCategory = _GetSkillInfoByCategory,
	GetFirstAidRank = _GetFirstAidRank,
	GetCookingRank = _GetCookingRank,
	GetFishingRank = _GetFishingRank,
	GetRidingRank = _GetRidingRank,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetPrimaryProfessions")
	DataStore:SetCharacterBasedMethod("GetSecondaryProfessions")
	DataStore:SetCharacterBasedMethod("GetSkillInfo")
	DataStore:SetCharacterBasedMethod("GetSkillInfoByCategory")
	DataStore:SetCharacterBasedMethod("GetFirstAidRank")
	DataStore:SetCharacterBasedMethod("GetCookingRank")
	DataStore:SetCharacterBasedMethod("GetFishingRank")
	DataStore:SetCharacterBasedMethod("GetRidingRank")
end
	
function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE")
	addon:RegisterEvent("CHAT_MSG_SKILL")
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("CHAT_MSG_SKILL")
end

-- *** Scanning functions ***
local headersState = {}
local headerCount

local function SaveHeaders()
	headerCount = 0		-- use a counter to avoid being bound to header names, which might not be unique.
	
	for i = GetNumSkillLines(), 1, -1 do		-- 1st pass, expand all categories
		local _, isHeader, isExpanded = GetSkillLineInfo(i)
		if isHeader then
			headerCount = headerCount + 1
			if not isExpanded then
				ExpandSkillHeader(i)
				headersState[headerCount] = true
			end
		end
	end
end

local function RestoreHeaders()
	headerCount = 0
	for i = GetNumSkillLines(), 1, -1 do
		local _, isHeader = GetSkillLineInfo(i)
		if isHeader then
			headerCount = headerCount + 1
			if headersState[headerCount] then
				CollapseSkillHeader(i)
			end
		end
	end
	wipe(headersState)
end

local function ScanSkills()
	local skills = addon.ThisCharacter.Skills
	wipe(skills)
	
	SaveHeaders()

	local category
	for i = 1, GetNumSkillLines() do
		local skillName, isHeader, _, skillRank, _, _, skillMaxRank = GetSkillLineInfo(i)
		if isHeader then
			category = skillName
		else
			if category and skillName then
				skills[category][skillName] = skillRank .. "|" .. skillMaxRank
			end
		end
	end
	
	RestoreHeaders()
	
	addon.ThisCharacter.lastUpdate = time()
end

-- *** EVENT HANDLERS ***
function addon:PLAYER_ALIVE()
	ScanSkills()
end

-- this turns
--	"Your skill in %s has increased to %d."
-- into
--	"Your skill in (.+)  has increased to (%d+)."

local arg1pattern, arg2pattern
if GetLocale() == "deDE" then		
	-- ERR_SKILL_UP_SI = "Eure Fertigkeit '%1$s' hat sich auf %2$d erhöht.";
	arg1pattern = "'%%1%$s'"
	arg2pattern = "%%2%$d"
else
	arg1pattern = "%%s"
	arg2pattern = "%%d"
end

local skillUpMsg = gsub(ERR_SKILL_UP_SI, arg1pattern, "(.+)")
skillUpMsg = gsub(skillUpMsg, arg2pattern, "(%%d+)")


function addon:CHAT_MSG_SKILL(self, msg)
	-- This code is a bit more complex than calling ScanSkills again.
	-- The purpose is to avoid triggering events when expanding/collapsing headers, as this may result in heavy processing in other addons
	if not msg then return end
	
	local updatedSkill, value = msg:match(skillUpMsg)
	
	if updatedSkill and value then
		for _, category in pairs(addon.ThisCharacter.Skills) do
			for skillName, skillData in pairs(category) do
				if skillName == updatedSkill then
					local _, skillMaxRank = strsplit("|", skillData)
					category[skillName] = tonumber(value) .. "|" .. skillMaxRank
					addon.ThisCharacter.lastUpdate = time()
				end
			end
		end
	end
end
