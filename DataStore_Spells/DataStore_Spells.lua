--[[	*** DataStore_Spells ***
Written by : Thaoky, EU-Marécages de Zangar
July 6th, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Spells"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"

local AddonDB_Defaults = {
	global = {
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				Spells = {
					['*'] = {		-- "General", "Arcane", "Fire", etc...
						['*'] = nil
					}
				},
			}
		}
	}
}

-- ** Mixins **
local function _GetNumSpells(character, school)
	return #character.Spells[school]
end
	
local function _GetSpellInfo(character, school, index)
	local spellID, rank = strsplit("|", character.Spells[school][index])
	return tonumber(spellID), rank
end

local function _IsSpellKnown(character, spellID)
	for schoolName, _ in pairs(character.Spells) do
		for i = 1, _GetNumSpells(character, schoolName) do
			local id = _GetSpellInfo(character, schoolName, i)
			if id == spellID then
				return true
			end
		end
	end
end

local PublicMethods = {
	GetNumSpells = _GetNumSpells,
	GetSpellInfo = _GetSpellInfo,
	IsSpellKnown = _IsSpellKnown,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetNumSpells")
	DataStore:SetCharacterBasedMethod("GetSpellInfo")
	DataStore:SetCharacterBasedMethod("IsSpellKnown")
end
	
function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE")
	addon:RegisterEvent("LEARNED_SPELL_IN_TAB")
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("LEARNED_SPELL_IN_TAB")
end

-- *** Scanning functions ***
local function ScanSpellTab(tabID)
	local tabName, _, offset, numSpells = GetSpellTabInfo(tabID);
	if not tabName then return end
	
	local spells = addon.ThisCharacter.Spells
	wipe(spells[tabName])
	
	local spell, rank, link, spellID
	
	for s = offset + 1, offset + numSpells do
		spell, rank = GetSpellName(s, BOOKTYPE_SPELL);
		if spell and rank then
			link = GetSpellLink(spell, rank)
			if link then
				spellID = tonumber(link:match("spell:(%d+)"))
				table.insert(spells[tabName], spellID .. "|" .. rank)		-- ex: "43017|Rank 1",
			end
		end
	end
end

local function ScanSpells()
	for tabID = 1, GetNumSpellTabs() do
		ScanSpellTab(tabID)
	end
	addon.ThisCharacter.lastUpdate = time()
end

-- *** EVENT HANDLERS ***
function addon:PLAYER_ALIVE()
	ScanSpells()
end

function addon:LEARNED_SPELL_IN_TAB()
	ScanSpells()
end
