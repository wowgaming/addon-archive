--[[	*** DataStore_Talents ***
Written by : Thaoky, EU-Marécages de Zangar
June 23rd, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Talents"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"

-- TODO: 
	-- add support for hunter pets' talent trees

local NUM_GLYPH_SLOTS = 6

local AddonDB_Defaults = {
	global = {
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				ActiveTalents = nil,		-- 1 for primary, 2 for secondary
				Class = nil,				-- englishClass
				PointsSpent = nil,		-- "51,5,15 ...	" 	3 numbers for primary spec, 3 for secondary, comma separated
				TalentTrees = {
					['*'] = {		-- "Fire|2"	= Mage Fire tree, secondary
						['*'] = 0
					}
				},
				Glyphs = {},
			}
		}
	}
}

-- This table saved reference data required to rebuild a talent tree for a class when logged in under another class.
-- The API does not provide that ability, but saving and reusing is fine
local ReferenceDB_Defaults = {
	global = {
		['*'] = {							-- "englishClass" like "MAGE", "DRUID" etc..
			Order = nil,
			Version = nil,					-- build number under which this class ref was saved
			Locale = nil,					-- locale under which this class ref was saved
			Trees = {
				['*'] = {					-- tree name
					icon = nil,
					background = nil,
					talents = {},			-- name, icon, max rank etc..for talent x in this tree
					prereqs = {}			-- prerequisites
				},
			}
		},
	}
}

local TALENT_ICON_PATH = "Interface\\Icons\\"
local BACKGROUND_PATH = "Interface\\TalentFrame\\"

-- *** Utility functions ***
local function GetVersion()
	local _, version = GetBuildInfo()
	return tonumber(version)
end

-- *** Scanning functions ***
local LocaleExceptions = {}		--- see ScanTalentReference() for an explanation on the purpose of this table
	
if GetLocale() == "enUS" then
	LocaleExceptions["Elemental Combat"] = "Elemental"
	LocaleExceptions["Shadow Magic"] = "Shadow"
elseif GetLocale() == "frFR" then
	LocaleExceptions["Combat élémentaire"] = "Elémentaire"
	LocaleExceptions["Arcanes"] = "Arcane"
	LocaleExceptions["Magie de l'ombre"] = "Ombre"
elseif GetLocale() == "deDE" then 
	LocaleExceptions["Wiederherstellung"] = "Wiederherst." 
	LocaleExceptions["Elementarkampf"] = "Elementar" 
	LocaleExceptions["Verstärkung"] = "Verstärk." 
	LocaleExceptions["Schattenmagie"] = "Schatten" 
elseif GetLocale() == "zhTW" then 
	LocaleExceptions["生存技能"] = "生存"
	LocaleExceptions["暗影魔法"] = "暗影"
	LocaleExceptions["元素戰鬥"] = "元素"
end

local function ScanTalents()

	local level = UnitLevel("player")
	if not level or level < 10 then return end		-- don't scan anything for low level characters

	local char = addon.ThisCharacter
	local _, englishClass = UnitClass("player")
	
	char.ActiveTalents = GetActiveTalentGroup()		-- returns 1 or 2
	char.Class = englishClass
	
	wipe(char.TalentTrees)
	
	local points = {}
	
	for specNum = 1, 2 do												-- primary and secondary specs
		for tabNum = 1, GetNumTalentTabs() do						-- all tabs
			local name, _, pointsSpent = GetTalentTabInfo( tabNum, nil, nil, specNum );
			table.insert(points, pointsSpent)
			
			for talentNum = 1, GetNumTalents(tabNum) do			-- all talents
				local _, _, _, _, currentRank = GetTalentInfo( tabNum, talentNum, nil, nil, specNum )

				char.TalentTrees[name .."|" .. specNum][talentNum] = currentRank
			end
		end
	end
	
	char.PointsSpent = table.concat(points, ",")
	char.lastUpdate = time()
end

local function ScanTalentReference()

	local level = UnitLevel("player")
	if not level or level < 10 then return end		-- don't scan anything for low level characters

	local _, class = UnitClass("player")		-- we need the englishClass
	local ref = addon.ref.global[class]
	
	-- see if we already have data for this version
	if ref.Version then									-- if we already have a version ..
		if ref.Version == GetVersion() then		-- .. and it's the current build ..
			return													-- ..then exit
		end
	end
	
	ref.Version = GetVersion()
	ref.Locale = GetLocale()
	local order = {}									-- order of the talent tabs
	
	-- first talent tree, gather reference + user specific
	for tabNum = 1, GetNumTalentTabs() do
		local talentTabName, _, _, fileName = GetTalentTabInfo( tabNum, nil, nil, 1 );
		order[tabNum] = talentTabName
		
		local ti = ref.Trees[talentTabName]		-- ti for talent info

		ti.background = fileName
			
		for talentNum = 1, GetNumTalents(tabNum) do
			local nameTalent, iconPath, tier, column, _, maximumRank = GetTalentInfo(tabNum, talentNum, nil, nil, 1 )

			-- all paths start with this prefix, let's hope blue does not change this :)
			-- saves a lot of memory not to keep the full path for each talent (about 16k in total for all classes)
			iconPath = string.gsub(iconPath, TALENT_ICON_PATH, "")
			
			local link = GetTalentLink(tabNum, talentNum)
			local id = tonumber(link:match("talent:(%d+)"))
			
			ti.talents[talentNum] = id .. "|" .. nameTalent .. "|" .. iconPath .. "|" .. tier .. "|" ..  column .. "|" .. maximumRank
			
			prereqTier, prereqColumn = GetTalentPrereqs(tabNum, talentNum)		-- talent prerequisites
			if prereqTier and prereqColumn then
				ti.prereqs[talentNum] = prereqTier .. "|" .. prereqColumn
			end
		end
	end
	
	-- save the order of talent tabs, this is necessary because the order of talent tabs is not the same as that of spell tabs in all languages/classes
	-- it is fine in enUS, but not in frFR (druid at least did not match)
	ref["Order"] = table.concat(order, ",")
	
	for i = 2, 4 do
		local name, icon = GetSpellTabInfo(i)		-- skip spell tab 1, it's the general tab
		
		-- the icon may be nil on a low level char. 
		-- Example : rogue lv 2
			-- GetSpellTabInfo(1) returns the General tab
			-- GetSpellTabInfo(2) returns the Assassination tab
			-- GetSpellTabInfo(3) returns the Combat tab
			-- GetSpellTabInfo(4) returns nil, instead of Subtelty
		if name and icon then
			-- in addition to having different order between spell tabs & talent tabs, the names may not match. Most of the time they do, but in case they don't, use the excpetion table
			name = LocaleExceptions[name] or name
		
		
			local ti = ref.Trees[name]		-- ti for talent info
			ti.icon = string.gsub(icon, TALENT_ICON_PATH, "")
		end
	end
end

local function ScanGlyphs()
	-- GLYPHTYPE_MAJOR = 1;
	-- GLYPHTYPE_MINOR = 2;

	--		1
	--	3		5
	--	6		4
	--		2

	local glyphs = addon.ThisCharacter.Glyphs
	wipe(glyphs)
	
	local enabled, glyphType, spell, icon, glyphID
	local link, index
	
	for specNum = 1, 2 do
		for i = 1, NUM_GLYPH_SLOTS do
			index = ((specNum - 1) * NUM_GLYPH_SLOTS) + i
	      
		   enabled, glyphType, spell, icon = GetGlyphSocketInfo(i, specNum)
			link = GetGlyphLink(i, specNum)
			if link then
				_, glyphID = link:match("glyph:(%d+):(%d+)")
			end
			
			glyphID = glyphID or 0
			glyphType = glyphType or 0
			enabled = enabled or 0
			spell = spell or ""
			icon = icon or ""
			
			glyphs[index] = enabled .."|" .. glyphType .. "|" .. spell .. "|" .. icon .. "|" .. glyphID
		end
	end
	
	addon.ThisCharacter.lastUpdate = time()
end


-- ** Mixins **
local function _GetReferenceTable()
	return addon.ref.global
end

local function	_GetClassReference(class)
	assert(type(class) == "string")
	return addon.ref.global[class]
end

local function _GetTreeReference(class, tree)
	assert(type(class) == "string")
	assert(type(tree) == "string")
	return addon.ref.global[class].Trees[tree]
end

local function _IsClassKnown(class)
	class = class or ""	-- if by any chance nil is passed, trap it to make sure the function does not fail, but returns nil anyway
	
	local ref = _GetClassReference(class)
	if ref.Order then		-- if the Order field is not nil, we have data for this class
		return true
	end
end

local function _ImportClassReference(class, data)
	assert(type(class) == "string")
	assert(type(data) == "table")
	
	addon.ref.global[class] = data
end

local function _GetClassTrees(class)
	assert(type(class) == "string")
	
	local ref = _GetClassReference(class)
	local order = ref.Order
	if order then
		return order:gmatch("([^,]+)")
	end
	-- to do, add a return value that does not require validity testing by the caller
end

local function _GetTreeInfo(class, tree)
	local t = _GetTreeReference(class, tree)
	
	if t then
		return TALENT_ICON_PATH..t.icon, BACKGROUND_PATH .. t.background
	end
end

local function _GetTreeNameByID(class, id)
	-- returns the name of tree "id" for a given class
	assert(type(class) == "string")
	
	local index = 1
	for name in _GetClassTrees(class) do
		if index == id then
			return name
		end
		index = index + 1
	end
end

local function _GetTalentLink(id, rank, name)
	return format("|cff4e96f7|Htalent:%s:%s|h[%s]|h|r", id, (rank-1), name)
end

local function _GetNumTalents(class, tree)
	-- returns the number of talents in a given tree
	local t = _GetTreeReference(class, tree)

	if t then
		return #t.talents
	end
end

local function _GetTalentInfo(class, tree, index)
	local t = _GetTreeReference(class, tree)
	local talentInfo = t.talents[index]
	
	if not talentInfo then return end
	
	local id, name, icon, tier, column, maximumRank	= strsplit("|", talentInfo)
	
	return tonumber(id), name, TALENT_ICON_PATH..icon, tonumber(tier), tonumber(column), tonumber(maximumRank)
end

local function _GetTalentRank(character, tree, specNum, index)
	return character.TalentTrees[tree .. "|" .. specNum][index]
end

local function _GetActiveTalents(character)
	return character.ActiveTalents
end

local function _GetNumPointsSpent(character, tree, specNum)
	local index = 1
	for treeName in _GetClassTrees(character.Class) do
		if treeName == tree then
			break
		end
		index = index + 1
	end
	
	if index == 4 then return end				-- = 4 means tree was not found
	
	index = index + ((specNum-1) * 3)
	
	return select(index, strsplit(",", character.PointsSpent)) or 0
end
	
local function _GetTalentPrereqs(class, tree, index)
	local t = _GetTreeReference(class, tree)
	local prereq = t.prereqs[index]
		
	if prereq then
		local prereqTier, prereqColumn = strsplit("|", prereq)
		return tonumber(prereqTier), tonumber(prereqColumn)
	end
end

local function _GetGlyphInfo(character, specNum, index)
	index = ((specNum - 1) * NUM_GLYPH_SLOTS) + index		-- 4th glyph = 4 for spec 1, 10 for spec 2
	local glyph = character.Glyphs[index]
	if glyph then
		local enabled, glyphType, spell, icon, glyphID = strsplit("|", glyph)
		return tonumber(enabled), tonumber(glyphType), tonumber(spell), icon, tonumber(glyphID)	
	end
end
	
local function _GetGlyphLink(id, spell, glyphID)
	local name = GetSpellInfo(spell)
	return format("|cff66bbff|Hglyph:2%s:%s|h[%s]|h|r", id, glyphID, name)
end

local PublicMethods = {
	GetReferenceTable = _GetReferenceTable,
	GetClassReference = _GetClassReference,
	GetTreeReference = _GetTreeReference,
	IsClassKnown = _IsClassKnown,
	ImportClassReference = _ImportClassReference,
	GetClassTrees = _GetClassTrees,
	GetTreeInfo = _GetTreeInfo,
	GetTreeNameByID = _GetTreeNameByID,
	GetTalentLink = _GetTalentLink,
	GetNumTalents = _GetNumTalents,
	GetTalentInfo = _GetTalentInfo,
	GetTalentRank = _GetTalentRank,
	GetActiveTalents = _GetActiveTalents,
	GetNumPointsSpent = _GetNumPointsSpent,
	GetTalentPrereqs = _GetTalentPrereqs,
	GetGlyphInfo = _GetGlyphInfo,
	GetGlyphLink = _GetGlyphLink,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)
	addon.ref = LibStub("AceDB-3.0"):New(addonName .. "RefDB", ReferenceDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetTalentRank")
	DataStore:SetCharacterBasedMethod("GetActiveTalents")
	DataStore:SetCharacterBasedMethod("GetNumPointsSpent")
	DataStore:SetCharacterBasedMethod("GetGlyphInfo")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE")
	addon:RegisterEvent("PLAYER_TALENT_UPDATE", ScanTalents)
	addon:RegisterEvent("GLYPH_ADDED", ScanGlyphs)
	addon:RegisterEvent("GLYPH_REMOVED", ScanGlyphs)
	addon:RegisterEvent("GLYPH_UPDATED", ScanGlyphs)
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("PLAYER_TALENT_UPDATE")
	addon:UnregisterEvent("GLYPH_ADDED")
	addon:UnregisterEvent("GLYPH_REMOVED")
	addon:UnregisterEvent("GLYPH_UPDATED")
end

-- *** EVENT HANDLERS ***
function addon:PLAYER_ALIVE()
	ScanTalents()
	ScanTalentReference()
	ScanGlyphs()
end
