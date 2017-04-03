local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local ORANGE	= "|cFFFF7F00"

-- Class constants, for readability, these values match the ones in Altoholic.Classes (altoholic.lua)
local CLASS_MAGE			= "MAGE"
local CLASS_WARRIOR		= "WARRIOR"
local CLASS_HUNTER		= "HUNTER"
local CLASS_ROGUE			= "ROGUE"
local CLASS_WARLOCK		= "WARLOCK"
local CLASS_DRUID			= "DRUID"
local CLASS_SHAMAN		= "SHAMAN"
local CLASS_PALADIN		= "PALADIN"
local CLASS_PRIEST		= "PRIEST"
local CLASS_DEATHKNIGHT	= "DEATHKNIGHT"

--[[

a few constants to increase readability in the tables below, 
some stats are taken from WoWUI's GlobalStrings.lua, but not all of them are suitable

SPELL_STAT1_NAME = "Strength";
SPELL_STAT2_NAME = "Agility";
SPELL_STAT3_NAME = "Stamina";
SPELL_STAT4_NAME = "Intellect";
SPELL_STAT5_NAME = "Spirit";

COMBAT_RATING_NAME1 = "Weapon Skill";
COMBAT_RATING_NAME10 = "Crit Rating"; -- Ranged crit rating
COMBAT_RATING_NAME11 = "Crit Rating"; -- Spell Crit Rating
COMBAT_RATING_NAME15 = "Resilience";
COMBAT_RATING_NAME2 = "Defense Rating";
COMBAT_RATING_NAME24 = "Expertise";
COMBAT_RATING_NAME3 = "Dodge Rating";
COMBAT_RATING_NAME4 = "Parry Rating";
COMBAT_RATING_NAME5 = "Block Rating";
COMBAT_RATING_NAME6 = "Hit Rating";
COMBAT_RATING_NAME7 = "Hit Rating"; -- Ranged hit rating
COMBAT_RATING_NAME8 = "Hit Rating"; -- Spell hit rating
COMBAT_RATING_NAME9 = "Crit Rating"; -- Melee crit rating

ATTACK_POWER_TOOLTIP = "Attack Power";
SPELLS = "Spells"; -- Generic "spells"  		note: replace this with a spell power constant in wotlk
MANA_REGEN = "Mana Regen";
BONUS_HEALING = "Bonus Healing";

ITEM_MOD_CRIT_RATING = "Improves critical strike rating by %d.";
 ITEM_MOD_CRIT_SPELL_RATING= "Improves spell critical strike rating by %d.";
ITEM_MOD_HIT_RATING = "Improves hit rating by %d.";
ITEM_MOD_HIT_SPELL_RATING = "Improves spell hit rating by %d.";
local STAT_HEALING = L["Increases healing done by up to %d+"]
local STAT_SPELLDMG = L["Increases damage and healing done by magical spells and effects by up to %d+"]
ITEM_MOD_DEFENSE_SKILL_RATING = "Increases defense rating by %d."; -- Increases defense rating by %d
ITEM_MOD_DODGE_RATING = "Increases your dodge rating by %d.";
ITEM_MOD_BLOCK_RATING = "Increases your shield block rating by %d.";
ITEM_MOD_SPELL_POWER = "Increases spell power by %d.";
ITEM_MOD_RESILIENCE_RATING = "Improves your resilience rating by %d.";
--]]

local STAT_AP = L["Increases attack power by %d+"]
local STAT_MP5 = L["Restores %d+ mana per"]
local STAT_SHAMAN_ONLY = L["Classes: Shaman"] .. "$"
local STAT_MAGE_ONLY = L["Classes: Mage"] .. "$"
local STAT_ROGUE_ONLY = L["Classes: Rogue"] .. "$"
local STAT_HUNTER_ONLY = L["Classes: Hunter"] .. "$"
local STAT_WARRIOR_ONLY = L["Classes: Warrior"] .. "$"
local STAT_PALADIN_ONLY = L["Classes: Paladin"] .. "$"
local STAT_WARLOCK_ONLY = L["Classes: Warlock"] .. "$"
local STAT_PRIEST_ONLY = L["Classes: Priest"] .. "$"
local STAT_DK_ONLY = L["Classes: Death Knight"] .. "$"
local STAT_RESIST = L["Resistance"]


addon.Equipment = {}

local ns = addon.Equipment		-- ns = namespace

-- When processing item stats, exclude an item if one of these strings is encountered, then discard the item
-- ex: if you're searching an update for the shoulder slot of your warrior, then the items listed will be of type "Armor" & subtype "Plate",
-- 	so parsing each line of stat is necessary to determine if a warrior can use the item.. therefore, the algorithm tries to find one of the words
--	that will help filtering out the item (if plate has +intel or +mana, it's obviously not for a warrior ..)
ns.ExcludeStats = {
	[CLASS_MAGE.."DPS"] = { 
		STAT_RESIST, 
		SPELL_STAT1_NAME, 
		SPELL_STAT2_NAME, 
		STAT_AP, 
		ITEM_MOD_DEFENSE_SKILL_RATING, 
		ITEM_MOD_DODGE_RATING, 
		ITEM_MOD_BLOCK_RATING, 
		STAT_PRIEST_ONLY, 
		STAT_WARLOCK_ONLY
	},
	[CLASS_WARRIOR.."Tank"]	= { 
		STAT_RESIST, 
		SPELL_STAT4_NAME, 
		SPELL_STAT5_NAME, 
		STAT_MP5, 
		ITEM_MOD_SPELL_POWER, 
		ITEM_MOD_RESILIENCE_RATING, 
		STAT_AP, 
		STAT_PALADIN_ONLY
	},
	[CLASS_WARRIOR.."DPS"] = { 
		STAT_RESIST, 
		SPELL_STAT4_NAME, 
		SPELL_STAT5_NAME, 
		STAT_MP5, 
		ITEM_MOD_SPELL_POWER, 
		ITEM_MOD_DEFENSE_SKILL_RATING, 
		STAT_PALADIN_ONLY
	},
	[CLASS_HUNTER.."DPS"] = { 
		STAT_RESIST, 
		SPELL_STAT1_NAME, 
		ITEM_MOD_SPELL_POWER, 
		ITEM_MOD_DODGE_RATING, 
		ITEM_MOD_DEFENSE_SKILL_RATING, 
		ITEM_MOD_BLOCK_RATING, 
		STAT_SHAMAN_ONLY
	},
	[CLASS_ROGUE.."DPS"] = { 
		STAT_RESIST, 
		SPELL_STAT4_NAME, 
		STAT_MP5, 
		ITEM_MOD_SPELL_POWER, 
		ITEM_MOD_BLOCK_RATING, 
		ITEM_MOD_DEFENSE_SKILL_RATING
	},
	[CLASS_WARLOCK.."DPS"] = { 
		STAT_RESIST, 
		SPELL_STAT1_NAME, 
		SPELL_STAT2_NAME, 
		STAT_AP, 
		ITEM_MOD_DEFENSE_SKILL_RATING, 
		ITEM_MOD_DODGE_RATING, 
		ITEM_MOD_BLOCK_RATING, 
		STAT_MAGE_ONLY, 
		STAT_PRIEST_ONLY
	},
	[CLASS_DRUID.."Tank"] = { 
		STAT_RESIST, 
		ITEM_MOD_SPELL_POWER, 
		STAT_ROGUE_ONLY, 
		ITEM_MOD_RESILIENCE_RATING
	},
	[CLASS_DRUID.."Heal"] = { 
		STAT_RESIST, 
		SPELL_STAT1_NAME, 
		SPELL_STAT2_NAME, 
		ITEM_MOD_DODGE_RATING, 
		ITEM_MOD_DEFENSE_SKILL_RATING, 
		ITEM_MOD_BLOCK_RATING, 
		ITEM_MOD_RESILIENCE_RATING, 
		STAT_AP
	},
	[CLASS_DRUID.."DPS"] = { 
		STAT_RESIST, 
		SPELL_STAT4_NAME, 
		ITEM_MOD_SPELL_POWER, 
		ITEM_MOD_DEFENSE_SKILL_RATING, 
		ITEM_MOD_BLOCK_RATING, 
		STAT_ROGUE_ONLY
	},
	[CLASS_DRUID.."Balance"] = { 
		STAT_RESIST, 
		SPELL_STAT1_NAME, 
		SPELL_STAT2_NAME, 
		ITEM_MOD_DODGE_RATING, 
		ITEM_MOD_DEFENSE_SKILL_RATING, 
		ITEM_MOD_BLOCK_RATING, 
		STAT_AP
	},
	[CLASS_SHAMAN.."Heal"] = { 
		STAT_RESIST, 
		ITEM_MOD_CRIT_RATING, 
		SPELL_STAT2_NAME, 
		ITEM_MOD_DODGE_RATING, 
		ITEM_MOD_DEFENSE_SKILL_RATING, 
		ITEM_MOD_BLOCK_RATING, 
		ITEM_MOD_RESILIENCE_RATING, 
		STAT_AP
	},
	[CLASS_SHAMAN.."DPS"] = { 
		STAT_RESIST, 
		ITEM_MOD_SPELL_POWER, 
		ITEM_MOD_DODGE_RATING, 
		ITEM_MOD_DEFENSE_SKILL_RATING, 
		ITEM_MOD_BLOCK_RATING, 
		STAT_HUNTER_ONLY
	},
	[CLASS_SHAMAN.."Elemental"] = { 
		STAT_RESIST, 
		SPELL_STAT1_NAME, 
		SPELL_STAT2_NAME, 
		ITEM_MOD_HIT_RATING, 
		ITEM_MOD_DEFENSE_SKILL_RATING, 
		ITEM_MOD_DODGE_RATING, 
		ITEM_MOD_BLOCK_RATING, 
		STAT_AP, 
		ITEM_MOD_CRIT_RATING
	},
	[CLASS_PALADIN.."Tank"]	= { 
		STAT_RESIST, 
		SPELL_STAT2_NAME, 
		STAT_AP, 
		ITEM_MOD_SPELL_POWER, 
		ITEM_MOD_RESILIENCE_RATING, 
		ITEM_MOD_CRIT_RATING, 
		STAT_WARRIOR_ONLY
	},
	[CLASS_PALADIN.."Heal"]	= { 
		STAT_RESIST, 
		SPELL_STAT2_NAME, 
		ITEM_MOD_CRIT_RATING, 
		STAT_AP, 
		ITEM_MOD_DODGE_RATING, 
		ITEM_MOD_BLOCK_RATING, 
		ITEM_MOD_DEFENSE_SKILL_RATING, 
		ITEM_MOD_HIT_RATING, 
		ITEM_MOD_RESILIENCE_RATING
	},
	[CLASS_PALADIN.."DPS"] = { 
		STAT_RESIST, 
		ITEM_MOD_SPELL_POWER, 
		ITEM_MOD_DODGE_RATING, 
		ITEM_MOD_BLOCK_RATING, 
		ITEM_MOD_DEFENSE_SKILL_RATING, 
		STAT_WARRIOR_ONLY },
	[CLASS_PRIEST.."Heal"] = { 
		STAT_RESIST, 
		SPELL_STAT1_NAME, 
		SPELL_STAT2_NAME, 
		ITEM_MOD_RESILIENCE_RATING, 
		STAT_AP, 
		ITEM_MOD_DEFENSE_SKILL_RATING, 
		ITEM_MOD_DODGE_RATING, 
		ITEM_MOD_BLOCK_RATING
	},
	[CLASS_PRIEST.."DPS"] = { 
		STAT_RESIST, 
		SPELL_STAT1_NAME, 
		SPELL_STAT2_NAME, 
		STAT_AP, 
		ITEM_MOD_DEFENSE_SKILL_RATING, 
		ITEM_MOD_DODGE_RATING, 
		ITEM_MOD_BLOCK_RATING, 
		STAT_MAGE_ONLY, 
		STAT_WARLOCK_ONLY
	},
	[CLASS_DEATHKNIGHT.."Tank"] = { 
		STAT_RESIST, 
		SPELL_STAT4_NAME, 
		SPELL_STAT5_NAME, 
		STAT_MP5, 
		ITEM_MOD_SPELL_POWER, 
		ITEM_MOD_RESILIENCE_RATING, 
		STAT_WARRIOR_ONLY,
		STAT_PALADIN_ONLY
	},
	[CLASS_DEATHKNIGHT.."DPS"] = { 
		STAT_RESIST, 
		SPELL_STAT4_NAME, 
		SPELL_STAT5_NAME, 
		STAT_MP5, 
		ITEM_MOD_DEFENSE_SKILL_RATING, 
		ITEM_MOD_DODGE_RATING, 
		ITEM_MOD_BLOCK_RATING, 
		ITEM_MOD_SPELL_POWER, 
		ITEM_MOD_RESILIENCE_RATING,
		STAT_WARRIOR_ONLY,
		STAT_PALADIN_ONLY
	}
}

ns.BaseStats = {	-- the order of these strings should match the "-s" in the associated entry of the FormatStats table
	[CLASS_MAGE.."DPS"]		= { SPELL_STAT3_NAME, SPELL_STAT4_NAME, SPELL_STAT5_NAME, ITEM_MOD_CRIT_RATING, ITEM_MOD_HIT_RATING, ITEM_MOD_SPELL_POWER },
	[CLASS_WARRIOR.."Tank"]	= { SPELL_STAT3_NAME, SPELL_STAT1_NAME, ITEM_MOD_DEFENSE_SKILL_RATING, ITEM_MOD_DODGE_RATING, ITEM_MOD_HIT_RATING },
	[CLASS_WARRIOR.."DPS"]	= { SPELL_STAT3_NAME, SPELL_STAT1_NAME, SPELL_STAT2_NAME, ITEM_MOD_CRIT_RATING, ITEM_MOD_HIT_RATING, STAT_AP },
	[CLASS_HUNTER.."DPS"]	= { SPELL_STAT3_NAME, SPELL_STAT2_NAME, SPELL_STAT4_NAME, ITEM_MOD_CRIT_RATING, ITEM_MOD_HIT_RATING, STAT_AP },
	[CLASS_ROGUE.."DPS"]		= { SPELL_STAT3_NAME, SPELL_STAT2_NAME, ITEM_MOD_CRIT_RATING, ITEM_MOD_HIT_RATING, STAT_AP },
	[CLASS_WARLOCK.."DPS"]	= { SPELL_STAT3_NAME, SPELL_STAT4_NAME, ITEM_MOD_CRIT_RATING, ITEM_MOD_HIT_RATING, ITEM_MOD_SPELL_POWER },
	[CLASS_DRUID.."Tank"]	= { SPELL_STAT3_NAME, SPELL_STAT1_NAME, SPELL_STAT2_NAME, ITEM_MOD_DEFENSE_SKILL_RATING, ITEM_MOD_DODGE_RATING, ITEM_MOD_HIT_RATING },
	[CLASS_DRUID.."Heal"]	= { SPELL_STAT3_NAME, SPELL_STAT4_NAME, SPELL_STAT5_NAME, ITEM_MOD_CRIT_RATING, STAT_MP5, ITEM_MOD_SPELL_POWER },
	[CLASS_DRUID.."DPS"]		= { SPELL_STAT3_NAME, SPELL_STAT1_NAME, SPELL_STAT2_NAME, ITEM_MOD_CRIT_RATING, ITEM_MOD_HIT_RATING, STAT_AP },
	[CLASS_DRUID.."Balance"]	= { SPELL_STAT3_NAME, SPELL_STAT4_NAME, STAT_MP5, ITEM_MOD_CRIT_RATING, ITEM_MOD_HIT_RATING, ITEM_MOD_SPELL_POWER },
	[CLASS_SHAMAN.."Heal"]	= { SPELL_STAT3_NAME, SPELL_STAT4_NAME, ITEM_MOD_CRIT_RATING, STAT_MP5, ITEM_MOD_SPELL_POWER },
	[CLASS_SHAMAN.."DPS"]	= { SPELL_STAT3_NAME, SPELL_STAT1_NAME, SPELL_STAT2_NAME, ITEM_MOD_CRIT_RATING, ITEM_MOD_HIT_RATING, STAT_AP },
	[CLASS_SHAMAN.."Elemental"]	= { SPELL_STAT3_NAME, SPELL_STAT4_NAME, STAT_MP5, ITEM_MOD_CRIT_RATING, ITEM_MOD_HIT_RATING, ITEM_MOD_SPELL_POWER },
	[CLASS_PALADIN.."Tank"]	= { SPELL_STAT3_NAME, SPELL_STAT4_NAME, ITEM_MOD_DEFENSE_SKILL_RATING, ITEM_MOD_DODGE_RATING, ITEM_MOD_HIT_RATING, ITEM_MOD_SPELL_POWER },
	[CLASS_PALADIN.."Heal"]	= { SPELL_STAT3_NAME, SPELL_STAT4_NAME, ITEM_MOD_CRIT_RATING, STAT_MP5, ITEM_MOD_SPELL_POWER },
	[CLASS_PALADIN.."DPS"]	= { SPELL_STAT3_NAME, SPELL_STAT1_NAME, SPELL_STAT4_NAME, ITEM_MOD_CRIT_RATING, ITEM_MOD_HIT_RATING, STAT_AP },
	[CLASS_PRIEST.."Heal"]	= { SPELL_STAT3_NAME, SPELL_STAT4_NAME, SPELL_STAT5_NAME, ITEM_MOD_CRIT_RATING, STAT_MP5, ITEM_MOD_SPELL_POWER },
	[CLASS_PRIEST.."DPS"]	= { SPELL_STAT3_NAME, SPELL_STAT4_NAME, SPELL_STAT5_NAME, ITEM_MOD_CRIT_RATING, ITEM_MOD_HIT_RATING, ITEM_MOD_SPELL_POWER },
	[CLASS_DEATHKNIGHT.."Tank"]	= { SPELL_STAT3_NAME, SPELL_STAT1_NAME, ITEM_MOD_DEFENSE_SKILL_RATING, ITEM_MOD_DODGE_RATING, ITEM_MOD_HIT_RATING },
	[CLASS_DEATHKNIGHT.."DPS"]	= { SPELL_STAT3_NAME, SPELL_STAT1_NAME, SPELL_STAT2_NAME, ITEM_MOD_CRIT_RATING, ITEM_MOD_HIT_RATING, STAT_AP }
}

ns.FormatStats = {
	[CLASS_MAGE.."DPS"]		= SPELL_STAT3_NAME .."|".. SPELL_STAT4_NAME .."|".. SPELL_STAT5_NAME .."|".. COMBAT_RATING_NAME11 .."|".. COMBAT_RATING_NAME8 .."|".. SPELLS,
	[CLASS_WARRIOR.."Tank"]	= SPELL_STAT3_NAME .."|".. SPELL_STAT1_NAME .."|".. COMBAT_RATING_NAME2 .."|".. COMBAT_RATING_NAME3 .."|".. COMBAT_RATING_NAME6,
	[CLASS_WARRIOR.."DPS"]	= SPELL_STAT3_NAME .."|".. SPELL_STAT1_NAME .."|".. SPELL_STAT2_NAME .."|".. COMBAT_RATING_NAME9 .."|".. COMBAT_RATING_NAME6 .."|" .. ATTACK_POWER_TOOLTIP,
	[CLASS_HUNTER.."DPS"]	= SPELL_STAT3_NAME .."|".. SPELL_STAT2_NAME .."|".. SPELL_STAT4_NAME .."|".. COMBAT_RATING_NAME10 .."|".. COMBAT_RATING_NAME7 .."|".. ATTACK_POWER_TOOLTIP,
	[CLASS_ROGUE.."DPS"]		= SPELL_STAT3_NAME .."|".. SPELL_STAT2_NAME .."|".. COMBAT_RATING_NAME9 .."|".. COMBAT_RATING_NAME6 .."|".. ATTACK_POWER_TOOLTIP,
	[CLASS_WARLOCK.."DPS"]	= SPELL_STAT3_NAME .."|".. SPELL_STAT4_NAME .."|".. COMBAT_RATING_NAME11 .."|".. COMBAT_RATING_NAME8 .."|".. SPELLS,
	[CLASS_DRUID.."Tank"]	= SPELL_STAT3_NAME .."|".. SPELL_STAT1_NAME .."|".. SPELL_STAT2_NAME .."|".. COMBAT_RATING_NAME2 .."|".. COMBAT_RATING_NAME3 .."|".. COMBAT_RATING_NAME6,
	[CLASS_DRUID.."Heal"]	= SPELL_STAT3_NAME .."|".. SPELL_STAT4_NAME .."|".. SPELL_STAT5_NAME .."|".. COMBAT_RATING_NAME11 .."|".. MANA_REGEN .."|".. BONUS_HEALING,
	[CLASS_DRUID.."DPS"]		= SPELL_STAT3_NAME .."|".. SPELL_STAT1_NAME .."|".. SPELL_STAT2_NAME .."|".. COMBAT_RATING_NAME9 .."|".. COMBAT_RATING_NAME6 .."|".. ATTACK_POWER_TOOLTIP,
	[CLASS_DRUID.."Balance"]	= SPELL_STAT3_NAME .."|".. SPELL_STAT4_NAME .."|".. MANA_REGEN .."|".. COMBAT_RATING_NAME11 .."|".. COMBAT_RATING_NAME8 .."|".. SPELLS,
	[CLASS_SHAMAN.."Heal"]	= SPELL_STAT3_NAME .."|".. SPELL_STAT4_NAME .."|".. COMBAT_RATING_NAME11 .."|".. MANA_REGEN .."|".. BONUS_HEALING,
	[CLASS_SHAMAN.."DPS"]	=  SPELL_STAT3_NAME .."|".. SPELL_STAT1_NAME .."|".. SPELL_STAT2_NAME .."|".. COMBAT_RATING_NAME9 .."|".. COMBAT_RATING_NAME6 .."|".. ATTACK_POWER_TOOLTIP,
	[CLASS_SHAMAN.."Elemental"]	= SPELL_STAT3_NAME .."|".. SPELL_STAT4_NAME .."|".. MANA_REGEN .."|".. COMBAT_RATING_NAME11 .."|".. COMBAT_RATING_NAME8 .."|".. SPELLS,
	[CLASS_PALADIN.."Tank"]	= SPELL_STAT3_NAME .."|".. SPELL_STAT4_NAME .."|".. COMBAT_RATING_NAME2 .."|".. COMBAT_RATING_NAME3 .."|".. COMBAT_RATING_NAME6 .."|".. SPELLS,
	[CLASS_PALADIN.."Heal"]	= SPELL_STAT3_NAME .."|".. SPELL_STAT4_NAME .."|".. COMBAT_RATING_NAME11 .."|".. MANA_REGEN .."|".. BONUS_HEALING,
	[CLASS_PALADIN.."DPS"]	= SPELL_STAT3_NAME .."|".. SPELL_STAT1_NAME .."|".. SPELL_STAT4_NAME .."|".. COMBAT_RATING_NAME9 .."|".. COMBAT_RATING_NAME6 .."|".. ATTACK_POWER_TOOLTIP,
	[CLASS_PRIEST.."Heal"]	= SPELL_STAT3_NAME .."|".. SPELL_STAT4_NAME .."|".. SPELL_STAT5_NAME .."|".. COMBAT_RATING_NAME11 .."|".. MANA_REGEN .."|".. BONUS_HEALING,
	[CLASS_PRIEST.."DPS"]	= SPELL_STAT3_NAME .."|".. SPELL_STAT4_NAME .."|".. SPELL_STAT5_NAME .."|".. COMBAT_RATING_NAME11 .."|".. COMBAT_RATING_NAME8 .."|".. SPELLS,
	[CLASS_DEATHKNIGHT.."Tank"]	= SPELL_STAT3_NAME .."|".. SPELL_STAT1_NAME .."|".. COMBAT_RATING_NAME2 .."|".. COMBAT_RATING_NAME3 .."|".. COMBAT_RATING_NAME6,
	[CLASS_DEATHKNIGHT.."DPS"]	= SPELL_STAT3_NAME .."|".. SPELL_STAT1_NAME .."|".. SPELL_STAT2_NAME .."|".. COMBAT_RATING_NAME9 .."|".. COMBAT_RATING_NAME6 .."|" .. ATTACK_POWER_TOOLTIP
}

-- These two tables are necessary to find equivalences between INVTYPEs returned by GetItemInfo and the actual equipment slots.
-- For instance, the "ranged" slot can contain bows/guns/wans/relics/thrown weapons.
local inventoryTypes = {
	["INVTYPE_HEAD"] = 1,		-- 1 means first entry in the EquipmentSlots table (just below this one)
	["INVTYPE_SHOULDER"] = 2,
	["INVTYPE_CHEST"] = 3,
	["INVTYPE_ROBE"] = 3,
	["INVTYPE_WRIST"] = 4,
	["INVTYPE_HAND"] = 5,
	["INVTYPE_WAIST"] = 6,
	["INVTYPE_LEGS"] = 7,
	["INVTYPE_FEET"] = 8,
	
	["INVTYPE_NECK"] = 9,
	["INVTYPE_CLOAK"] = 10,
	["INVTYPE_FINGER"] = 11,
	["INVTYPE_TRINKET"] = 12,
	["INVTYPE_WEAPON"] = 13,
	["INVTYPE_2HWEAPON"] = 14,
	["INVTYPE_WEAPONMAINHAND"] = 15,
	["INVTYPE_WEAPONOFFHAND"] = 16,
	["INVTYPE_HOLDABLE"] = 16,
	["INVTYPE_SHIELD"] = 17,
	["INVTYPE_RANGED"] = 18,
	["INVTYPE_THROWN"] = 18,
	["INVTYPE_RANGEDRIGHT"] = 18,
	["INVTYPE_RELIC"] = 18
}

local slotNames = {
	[1] = BI["Head"],			-- "INVTYPE_HEAD" 
	[2] = BI["Shoulder"],	-- "INVTYPE_SHOULDER"
	[3] = BI["Chest"],		-- "INVTYPE_CHEST",  "INVTYPE_ROBE"
	[4] = BI["Wrist"],		-- "INVTYPE_WRIST"
	[5] = BI["Hands"],		-- "INVTYPE_HAND"
	[6] = BI["Waist"],		-- "INVTYPE_WAIST"
	[7] = BI["Legs"],			-- "INVTYPE_LEGS"
	[8] = BI["Feet"],			-- "INVTYPE_FEET"
	
	[9] = BI["Neck"],			-- "INVTYPE_NECK"
	[10] = BI["Back"],		-- "INVTYPE_CLOAK"
	[11] = BI["Ring"],		-- "INVTYPE_FINGER"
	[12] = BI["Trinket"],	-- "INVTYPE_TRINKET"
	[13] = BI["One-Hand"],	-- "INVTYPE_WEAPON"
	[14] = BI["Two-Hand"],	-- "INVTYPE_2HWEAPON"
	[15] = BI["Main Hand"],	-- "INVTYPE_WEAPONMAINHAND"
	[16] = BI["Off Hand"],	-- "INVTYPE_WEAPONOFFHAND", "INVTYPE_HOLDABLE"
	[17] = BI["Shield"],		-- "INVTYPE_SHIELD"
	[18] = BI["Ranged"]		-- "INVTYPE_RANGED",  "INVTYPE_THROWN", "INVTYPE_RANGEDRIGHT", "INVTYPE_RELIC"
}

local slotTypeInfo = {
	{ color = "|cFF69CCF0", name = BI["Head"], icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Head"},
	{ color = "|cFFABD473", name = BI["Neck"], icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Neck"},
	{ color = "|cFF69CCF0", name = BI["Shoulder"], icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Shoulder"},
	{ color = WHITE, name = BI["Shirt"], icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Shirt"},
	{ color = "|cFF69CCF0", name = BI["Chest"], icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Chest"},
	{ color = "|cFF69CCF0", name = BI["Waist"], icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Waist"},
	{ color = "|cFF69CCF0", name = BI["Legs"], icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Legs"},
	{ color = "|cFF69CCF0", name = BI["Feet"], icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Feet"},
	{ color = "|cFF69CCF0", name = BI["Wrist"], icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Wrists"},
	{ color = "|cFF69CCF0", name = BI["Hands"], icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Hands"},
	{ color = ORANGE, name = BI["Ring"] .. " 1", icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Finger"},
	{ color = ORANGE, name = BI["Ring"] .. " 2", icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Finger"},
	{ color = ORANGE, name = BI["Trinket"] .. " 1", icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Trinket"},
	{ color = ORANGE, name = BI["Trinket"] .. " 2", icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Trinket"},
	{ color = "|cFFABD473", name = BI["Back"], icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Chest"},
	{ color = "|cFFFFFF00", name = BI["Main Hand"], icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-MainHand"},
	{ color = "|cFFFFFF00", name = BI["Off Hand"], icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-SecondaryHand"},
	{ color = "|cFFABD473", name = BI["Ranged"], icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Ranged"},
	{ color = WHITE, name = BI["Tabard"], icon = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Tabard"}
}

function ns:GetSlotTexture(slot)
	return slotTypeInfo[slot].icon
end

function ns:GetSlotName(slot)
	return slotNames[slot]
end

function ns:GetInventoryTypeIndex(inv)
	return inventoryTypes[inv]
end

function ns:GetInventoryTypeName(inv)
	return slotNames[ inventoryTypes[inv] ]
end

function ns:Update()
	local VisibleLines = 7
	local frame = "AltoholicFrameEquipment"
	local entry = frame.."Entry"
	
	AltoholicTabCharactersStatus:SetText("")
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local realm, account = addon:GetCurrentRealm()
	local character
	local DS = DataStore
	
	for i=1, VisibleLines do
		local line = i + offset
		local e = slotTypeInfo[line]

		_G[ entry..i.."Name" ]:SetText(e.color .. e.name)

		for j = 1, 10 do
			local itemName = entry.. i .. "Item" .. j;
			local itemButton = _G[itemName]
			itemButton:SetScript("OnEnter", ns.OnEnter)
			itemButton:SetScript("OnClick", ns.OnClick)			
			
			local itemCount = _G[itemName .. "Count"]
			itemCount:Hide();
			
			addon:CreateButtonBorder(itemButton)
			itemButton.border:Hide()
			
			local classButton = _G["AltoholicFrameClassesItem" .. j]
			if classButton.CharName then
				character = DS:GetCharacter(classButton.CharName, realm, account)
				
				local item = DS:GetInventoryItem(character, line)
				if item then
					itemButton.CharName = classButton.CharName
					addon:SetItemButtonTexture(itemName, GetItemIcon(item));
					
					-- display the coloured border
					local _, _, itemRarity, itemLevel = GetItemInfo(item)
					if itemRarity and itemRarity >= 2 then
						local r, g, b = GetItemQualityColor(itemRarity)
						itemButton.border:SetVertexColor(r, g, b, 0.5)
						itemButton.border:Show()
					end
					
					itemCount:SetText(itemLevel);
					itemCount:Show();
				else
					itemButton.CharName = nil
					addon:SetItemButtonTexture(itemName, e.icon);
				end
				
				itemButton:Show()
			else
				itemButton:Hide()
				itemButton.CharName = nil
			end
		end
		
		_G[ entry..i ]:Show()
		_G[ entry..i ]:SetID(line)
	end

	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], 19, VisibleLines, 41);
end

function ns:OnEnter()
	if not self.CharName then return end
	
	local DS = DataStore
	local realm, account = addon:GetCurrentRealm()
	local character = DS:GetCharacter(self.CharName, realm, account)
	local item = DS:GetInventoryItem(character, self:GetParent():GetID())
	if not item then return end

	GameTooltip:SetOwner(self, "ANCHOR_LEFT");
	local link
	if type(item) == "number" then
		link = select(2, GetItemInfo(item))
	else
		link = item
	end
	
	if not link then
		GameTooltip:AddLine(L["Unknown link, please relog this character"],1,1,1);
		GameTooltip:Show();
		return
	end
	
	GameTooltip:SetHyperlink(link);
	GameTooltip:AddLine(" ");
	GameTooltip:AddLine(GREEN .. L["Right-Click to find an upgrade"]);
	GameTooltip:Show();
end

function ns:OnClick(button)
	if not self.CharName then return end
	
	local slotID = self:GetParent():GetID()
	if slotID == 0 then return end		-- class icon

	local DS = DataStore
	local realm, account = addon:GetCurrentRealm()
	local character = DS:GetCharacter(self.CharName, realm, account)
	local item = DS:GetInventoryItem(character, slotID)
	if not item then return end
	
	local link
	if type(item) == "number" then
		link = select(2, GetItemInfo(item))
	else
		link = item
	end
	
	if not link then return end
	
	if button == "RightButton" then
		Altoholic.Search:SetCurrentItem( addon:GetIDFromLink(link) ) 		-- item ID of the item to find an upgrade for
		local _, class = DS:GetCharacterClass(character)
		Altoholic.Search:SetClass(class)
		
		ToggleDropDownMenu(1, nil, AltoholicFrameEquipmentRightClickMenu, self:GetName(), 0, -5);
		return
	end
	
	if ( button == "LeftButton" ) and ( IsControlKeyDown() ) then
		DressUpItemLink(link);
	elseif ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		local chat = ChatEdit_GetLastActiveWindow()
		if chat:IsShown() then
			chat:Insert(link);
		else
			AltoholicFrame_SearchEditBox:SetText(GetItemInfo(link))
		end
	end
end

function Equipment_RightClickMenu_OnLoad()
	local info = UIDropDownMenu_CreateInfo(); 

	info.text		= format("%s %s", L["Find Upgrade"], GREEN .. L["(based on iLvl)"])
	info.value		= -1
	info.func		= Altoholic.Search.FindEquipmentUpgrade
	UIDropDownMenu_AddButton(info, 1); 
	
	local class = Altoholic.Search:GetClass()

	-- Tank upgrade
	if (class == CLASS_WARRIOR) or
		(class == CLASS_DRUID) or
		(class == CLASS_DEATHKNIGHT) or
		(class == CLASS_PALADIN) then
		
		info.text		= format("%s %s(%s)", L["Find Upgrade"], GREEN, L["Tank"])
		info.value		= class .. "Tank"
		info.func		= Altoholic.Search.FindEquipmentUpgrade
		UIDropDownMenu_AddButton(info, 1); 	
	end
	
	-- DPS upgrade
	if class then
		info.text		= format("%s %s(%s)", L["Find Upgrade"], GREEN, L["DPS"])
		info.value		= class .. "DPS"
		info.func		= Altoholic.Search.FindEquipmentUpgrade
		UIDropDownMenu_AddButton(info, 1); 
	end
		
	if class == CLASS_DRUID then
		info.text		= format("%s %s(%s)", L["Find Upgrade"], GREEN, L["Balance"])
		info.value		= class .. "Balance"
		info.func		= Altoholic.Search.FindEquipmentUpgrade
		UIDropDownMenu_AddButton(info, 1); 
	elseif class == CLASS_SHAMAN then
		info.text		= format("%s %s(%s)", L["Find Upgrade"], GREEN, L["Elemental Shaman"])
		info.value		= class .. "Elemental"
		info.func		= Altoholic.Search.FindEquipmentUpgrade
		UIDropDownMenu_AddButton(info, 1); 
	end
		
	-- Heal upgrade
	if (class == CLASS_PRIEST) or
		(class == CLASS_SHAMAN) or
		(class == CLASS_DRUID) or
		(class == CLASS_PALADIN) then
		
		info.text		= format("%s %s(%s)", L["Find Upgrade"], GREEN, L["Heal"])
		info.value		= class .. "Heal"
		info.func		= Altoholic.Search.FindEquipmentUpgrade
		UIDropDownMenu_AddButton(info, 1); 
	end
	
	-- Close menu item
	info.text = CLOSE
	info.func = function() CloseDropDownMenus() end
	info.checked = nil
	info.icon = nil
	info.notCheckable = 1
	UIDropDownMenu_AddButton(info, 1)
end
