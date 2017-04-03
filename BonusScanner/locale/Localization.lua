local L = LibStub("AceLocale-3.0"):NewLocale("BonusScanner","enUS",true)
-- bonus names
L["BONUSSCANNER_NAMES"] = {
--Base Stats
	STR 		= "Strength",
	AGI 		= "Agility",
	STA 		= "Stamina",
	INT 		= "Intellect",
	SPI 		= "Spirit",
	ARMOR 	= "Armor",

--Resistances
	ARCANERES = "Arcane Resistance",	
	FIRERES 	= "Fire Resistance",
	NATURERES = "Nature Resistance",
	FROSTRES 	= "Frost Resistance",
	SHADOWRES = "Shadow Resistance",

--Skills
	FISHING 	= "Fishing",
	MINING 		= "Mining",
	HERBALISM = "Herbalism",
	SKINNING 	= "Skinning",
	DEFENSE 	= "Defense Rating",
	EXPERTISE = "Expertise Rating",
	
--Abilities
	BLOCK		= "Block Rating",
	BLOCKVALUE	= "Block Value",
	DODGE 		= "Dodge Rating",
	PARRY 		= "Parry Rating",
	RESILIENCE = "Resilience Rating", 
	DMGWPN = "Increased Melee Damage", 
	RANGEDDMG = "Ranged Weapon Damage",
	ARMORPEN = "Armor Penetration Rating",
	MASTERY = "Mastery",
-- DPS
	DPSMAIN = "Main Weapon(s) DPS",
	DPSRANGED = "Ranged Weapon DPS",
	DPSTHROWN = "Thrown Weapon DPS",

--Attack Power
	ATTACKPOWER	= "Attack Power",
	ATTACKPOWERUNDEAD	= "Attack Power against Undead",
	ATTACKPOWERFERAL	= "Attack Power in feral form",
	RANGEDATTACKPOWER = "Ranged Attack Power",
	
--Critical
	CRIT 		= "Critical Strike Rating",	
	RANGEDCRIT 	= "Ranged Critical Strike",
	--HOLYCRIT 	= "Crit. Holy Spell", -- Investigation

--Hit
	TOHIT 		= "Hit Rating",
	RANGEDHIT	= "Ranged Hit Rating",	
  
--Haste
	HASTE = "Haste Rating",
	MASTERY = "Mastery Rating",

--Spell Damage/healing
	DMGUNDEAD	= "Spell Damage against Undead",
	ARCANEDMG 	= "Arcane Damage",
	FIREDMG 	= "Fire Damage",
	FROSTDMG 	= "Frost Damage",
	HOLYDMG 	= "Holy Damage",
	NATUREDMG 	= "Nature Damage",
	SHADOWDMG 	= "Shadow Damage",
	SPELLPEN 	= "Spell Penetration",
  SPELLPOW = "Spell Power", 

--Regen
	HEALTHREG 	= "Life Regeneration",
	MANAREG 	= "Mana Regeneration",

--Health/mana
	HEALTH = "Life Points",
	MANA = "Mana Points",
	
--Extra bonuses
  THREATREDUCTION = "% Reduced Threat",
  THREATINCREASE = "% Increased Threat",
  INCRCRITDMG = "% Increased Critical Damage",
  SPELLREFLECT = "% Spell Reflect",
  STUNRESIST = "% Stun Resistance",
  PERCINT = "% Intellect",
  PERCBLOCKVALUE = "% Shield Block Value",
 
-- WOTLK Metagems
  PERCARMOR = "% Increased Armor Value",
  PERCMANA ="% Mana",
  PERCREDSPELLDMG = "% Reduced Spell Damage Taken",
  PERCSNARE = "% Reduced Snare/Root Duration",
  PERCSILENCE = "% Reduced Silence Duration",
  PERCFEAR = "% Reduced Fear Duration",
  PERCSTUN = "% Reduced Stun Duration",
  PERCCRITHEALING = "% Increased Critical Healing",  
};

-- equip and set bonus prefixes:
--L["BONUSSCANNER_PREFIX_EQUIP"] = "Equip: "; --no longer used but kept in case Blizzard decides to alter its own global string referring to this
L["BONUSSCANNER_PREFIX_SET"] = "Set: ";
L["BONUSSCANNER_PREFIX_SOCKET"] = "Socket Bonus: ";
L["BONUSSCANNER_WEAPON_SPEED"] = "Speed";
L["BONUSCANNER_GEM_STRINGS"] = {
	-- red
	["matches a red socket"] = { red = 1, yellow = 0, blue = 0, prismatic = 0},
	-- blue
	["matches a blue socket"] = { red = 0, yellow = 0, blue = 1, prismatic = 0},
	-- yellow
	["matches a yellow socket"] = { red = 0, yellow = 1, blue = 0, prismatic = 0},
	-- purple
	["matches a red or blue socket"] = { red = 1, yellow = 0, blue = 1, prismatic = 0},
	["matches a blue or red socket"] = { red = 1, yellow = 0, blue = 1, prismatic = 0},
	-- green
	["matches a blue or yellow socket"] = { red = 0, yellow = 1, blue = 1, prismatic = 0},
	["matches a yellow or blue socket"] = { red = 0, yellow = 1, blue = 1, prismatic = 0},
	-- orange
	["matches a red or yellow socket"] = { red = 1, yellow = 1, blue = 0, prismatic = 0},
	["matches a yellow or red socket"] = { red = 1, yellow = 1, blue = 0, prismatic = 0},
	-- prismatic
	["matches any socket"] = { red = 0, yellow = 0, blue = 0, prismatic = 1},
	["matches a red, yellow or blue socket"] = { red = 0, yellow = 0, blue = 0, prismatic = 1}
}

-- Enchant separators
L["BONUSSCANNER_GLOBAL_SEP"] = " +";
L["BONUSSCANNER_SEPARATORS"] = { "/", ", ", " & ", " and " };

-- passive bonus patterns. checked against lines which start with above prefixes
L["BONUSSCANNER_PATTERNS_PASSIVE"] = {
--Skills
	{ pattern = "Increases defense rating by (%d+)%.", effect = "DEFENSE" }, --jmlsteele
  { pattern = "Improves your resilience rating by (%d+)%.", effect = "RESILIENCE" }, 
  { pattern = "Increases your expertise rating by (%d+)%.", effect = "EXPERTISE" },

  { pattern = "Increased Fishing %+(%d+)%.", effect = "FISHING" }, -- fishing poles

-- Abilities
	{ pattern = "Increases your block rating by (%d+)%.", effect = "BLOCK" },
	{ pattern = "Increases your shield block rating by (%d+)%.", effect = "BLOCK" },
	{ pattern = "Increases the block value of your shield by (%d+)%.", effect = "BLOCKVALUE" },
	{ pattern = "Increases your dodge rating by (%d+)%.", effect = "DODGE" },
	{ pattern = "Increases your parry rating by (%d+)%.", effect = "PARRY" },
	{ pattern = "%+(%d+) Weapon Damage%.", effect = "DMGWPN" }, -- Might of Cenarius...

--Crit
	{ pattern = "Increases your critical strike rating by (%d+)%.", effect = "CRIT" },
	{ pattern = "Improves critical strike rating by (%d+)%.", effect = "CRIT" }, 
	{ pattern = "Improves melee critical strike rating by (%d+)%.", effect = "CRIT" },
	{ pattern = "Increases your ranged critical strike rating by (%d+)%.", effect = "RANGEDCRIT" },
	
--Damage/Heal/Spell Power
  { pattern = "Increases spell power by (%d+)%.", effect = "SPELLPOW" }, 
  { pattern = "Increases your spell power by (%d+)%.", effect = "SPELLPOW" },
  { pattern = "Increases damage done by magical spells and effects by up to (%d+)%.", effect = "SPELLPOW" },
  { pattern = "Increases shadow spell power by (%d+)%.", effect = "SHADOWDMG" }, 
  { pattern = "Increases arcane spell power by (%d+)%.", effect = "ARCANEDMG" }, 
  { pattern = "Increases fire spell power by (%d+)%.", effect = "FIREDMG" }, 
  { pattern = "Increases frost spell power by (%d+)%.", effect = "FROSTDMG" }, 
  { pattern = "Increases holy spell power by (%d+)%.", effect = "HOLYDMG" }, 
  { pattern = "Increases nature spell power by (%d+)%.", effect = "NATUREDMG" },
	{ pattern = "Increases spell power slightly%.", effect = "SPELLPOW", value = 6 },
	{ pattern = "Increases damage done to Undead by magical spells and effects by up to (%d+)", effect = "DMGUNDEAD" },
	
	-- Multibonus Equip patterns
	{ pattern = "Increases spell power of all party members within %d+ yards by up to (%d+)%.", effect = "SPELLPOW" },	
	{ pattern = "Increases your pet's resistances by 130 and increases your spell power by (%d+)%.", effect = "SPELLPOW" }, -- Void Star Talisman
	--{ pattern = "Increases healing done by up to (%d+) and damage done by up to (%d+) for all magical spells and effects%.", effect = {"HEAL","DMG"} },
	--{ pattern = "Increases your spell damage by up to (%d+) and your healing by up to (%d+)%.", effect = {"DMG","HEAL"} },
	--{ pattern = "Increases healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%. ", effect = "HEAL" },
	--{ pattern = "Increases damage and healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%.", effect = {"HEAL", "DMG"} },
	{ pattern = "Restores (%d+) mana per 5 seconds to all party members within %d+ yards%.", effect = "MANAREG" },
	{ pattern = "Increases the spell critical strike rating of all party members within %d+ yards by (%d+)%.", effect = "CRIT" }, --SPELLCRIT
	{ pattern = "Increases defense rating by (%d+), Shadow resistance by (%d+) and your normal health regeneration by (%d+)%.", effect = {"DEFENSE", "SHADOWRES", "HEALTHREG"} },
	
--Attack power
	{ pattern = "Increases attack power by (%d+)%.", effect = "ATTACKPOWER" },
	{ pattern = "Increases melee and ranged attack power by (%d+)%.", effect = {"ATTACKPOWER","RANGEDATTACKPOWER"} }, -- Andonisus, Reaper of Souls pattern
	{ pattern = "+(%d+) ranged Attack Power%.", effect = "RANGEDATTACKPOWER" },
	{ pattern = "Increases ranged attack power by (%d+)%.", effect = "RANGEDATTACKPOWER" },
  { pattern = "Increases attack power by (%d+) in Cat, Bear, Dire Bear, and Moonkin forms only%.", effect = "ATTACKPOWERFERAL" },
  { pattern = "Increases attack power by (%d+) when fighting Undead%.", effect = "ATTACKPOWERUNDEAD" },
  { pattern = "+(%d+) Attack Power when fighting Undead%.", effect = "ATTACKPOWERUNDEAD" },
  
--Regen
	{ pattern = "Restores (%d+) health per 5 sec%.", effect = "HEALTHREG" }, 
	{ pattern = "Restores (%d+) health every 5 sec%.", effect = "HEALTHREG" },  -- both versions ('per' and 'every') seem to be used
	{ pattern = "Restores (%d+) mana per 5 sec%.", effect = "MANAREG" },
	{ pattern = "Restores (%d+) mana every 5 sec%.", effect = "MANAREG" },
	
--Hit
	{ pattern = "Increases your hit rating by (%d+)%.", effect = "TOHIT" },
	{ pattern = "Improves hit rating by (%d+)%.", effect = "TOHIT" }, 	
	
--Haste
	--{ pattern = "Improves haste rating by (%d+)%.", effect = "HASTE" },
	
--MASTERY 
	--This version attempts to work on all locals at once.	
	{ pattern = string.gsub(ITEM_MOD_MASTERY_RATING, "%%d", "(%%d+)%%"), effect = "MASTERY"}, -- Mastery
	--{ pattern = "Increases your mastery rating by (%d+)%.+", effect = "MASTERY"}, -- Mastery
--Penetration
	{ pattern = "Decreases the magical resistances of your spell targets by (%d+).", effect = "SPELLPEN" },
	{ pattern = "Increases your spell penetration by (%d+)%.", effect = "SPELLPEN" },	
	{ pattern = "Increases your armor penetration rating by (%d+)%.", effect = "ARMORPEN" },
	{ pattern = "Increases armor penetration rating by (%d+)%.", effect = "ARMORPEN" }	
};

-- generic patterns have the form "+xx bonus" or "bonus +xx" or even "xx bonus" with an optional % sign after the value.

-- first the generic bonus string is looked up in the following table
L["BONUSSCANNER_PATTERNS_GENERIC_LOOKUP"] = {
	["All Stats"] 			= {"STR", "AGI", "STA", "INT", "SPI"},
	["to All Stats"] 			= {"STR", "AGI", "STA", "INT", "SPI"},
	["Strength"]			= "STR",
	["Agility"]			= "AGI",
	["Stamina"]			= "STA",
	["Intellect"]			= "INT",
	["Spirit"] 			= "SPI",

	["All Resistances"] 	= { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}, -- obsidian items
	["Resist All"] 	= { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}, -- prismatic gems

	["Fishing"]		= "FISHING",
	["Fishing Lure"]	= "FISHING",
	["Increased Fishing"]	= "FISHING",
	["Mining"]		= "MINING",
	["Herbalism"]		= "HERBALISM",
	["Skinning"]		= "SKINNING",
	["Defense"]		= "DEFENSE",
	["Increased Defense"]	= "DEFENSE",

	["Attack Power"] 	= "ATTACKPOWER",
  ["Attack Power when fighting Undead"] = "ATTACKPOWERUNDEAD",
  ["Attack Power versus Undead"] = "ATTACKPOWERUNDEAD",
	["Attack Power in Cat, Bear, Dire Bear, and Moonkin forms only"] = "ATTACKPOWERFERAL",
	["Weapon Damage"] = "DMGWPN",
	
	-- TBC/Wotlk Patterns Generic/Gems/Sockets
	
	["Spell Power"] = "SPELLPOW",
	["Critical Strike Rating"] = "CRIT",
	["Critical strike rating"] = "CRIT",
	["Critical Rating"] = "CRIT",
	["Crit Rating"] = "CRIT",
	["Ranged Critical Strike"] = "RANGEDCRIT",
	["Spell Penetration"] = "SPELLPEN",
	["Armor Penetration Rating"] = "ARMORPEN",	
	["Defense Rating"] = "DEFENSE",
	["Haste Rating"] = "HASTE",
	["Mastery Rating"] = "MASTERY",
	["Mana per 5 Seconds"] = "MANAREG",
	["mana per 5 seconds"] = "MANAREG",
	["Mana every 5 Sec"] = "MANAREG",
	["Mana every 5 seconds"] = "MANAREG",
	["Mana restored per 5 seconds"] = "MANAREG",
	["Mana Per 5 sec"] = "MANAREG",
	["mana per 5 sec"] = "MANAREG",
	["Mana per 5 Sec"] = "MANAREG",
	["Mana per 5 sec"] = "MANAREG",
	["Dodge Rating"] 		= "DODGE",
	["Parry Rating"] 		= "PARRY",
	["Resilience Rating"] = "RESILIENCE",
	["Melee Damage"] = "DMGWPN",
	["Expertise Rating"] = "EXPERTISE",
	
	-- End TBC Patterns
	
	["Dodge"] 		= "DODGE",
	["Block"]		= "BLOCKVALUE",
	["Block Value"]		= "BLOCKVALUE",
	["Block Rating"]		= "BLOCK",
	["Blocking"]		= "BLOCK",
	["Hit"] 		= "TOHIT",
	["Hit Rating"] = "TOHIT",	
	["Ranged Hit Rating"] = "RANGEDHIT",
	["Ranged Attack Power"]	= "RANGEDATTACKPOWER",
	["ranged Attack Power"]	= "RANGEDATTACKPOWER", -- Experimental for TBC
	["Health per 5 sec"]	= "HEALTHREG",
	["health every 5 sec"]	= "HEALTHREG",
	["Healing"] = "HEAL",
	["Healing Spells"] 	= "HEAL",
	["Increased Healing"] 	= "HEAL",
	["mana every 5 sec"] 	= "MANAREG",
	["Mana Regen"]		= "MANAREG",
	["Critical"]		= "CRIT",
	["Critical Hit"]	= "CRIT",
	["Health"]		= "HEALTH",
	["HP"]			= "HEALTH",
	["Mana"]		= "MANA",
	["Armor"]		= "ARMOR",
	["Reinforced"]	= "ARMOR",
	["Resilience"]			= "RESILIENCE",
	
	-- Patterns for color coded/special lines
	
	["Reduced Threat"] = "THREATREDUCTION",
	["Increased Critical Damage"] = "INCRCRITDMG",
	["Spell Reflect"] = "SPELLREFLECT",
	["Stun Resistance"] = "STUNRESIST",
	["Stun Resist"] = "STUNRESIST",
	["Shield Block Value"] = "PERCBLOCKVALUE",
	["Increased Armor Value from Items"] = "PERCARMOR",
	["Reduce Spell Damage Taken by"] = "PERCREDSPELLDMG",	
	["Silence Duration Reduced by"] = "PERCSILENCE",
	["Fear Duration Reduced by"] = "PERCFEAR",
	["Stun Duration Reduced by"] = "PERCSTUN",
	["Root Duration by"] = "PERCSNARE",
	["Increased Critical Healing Effect"] = "PERCCRITHEALING",
};	

-- next we try to match against one pattern of stage 1 and one pattern of stage 2 and concatenate the effect strings
L["BONUSSCANNER_PATTERNS_GENERIC_STAGE1"] = {
	{ pattern = "Arcane", 	effect = "ARCANE" },	
	{ pattern = "Fire", 	effect = "FIRE" },	
	{ pattern = "Frost", 	effect = "FROST" },	
	{ pattern = "Holy", 	effect = "HOLY" },	
	{ pattern = "Shadow",	effect = "SHADOW" },	
	{ pattern = "Nature", 	effect = "NATURE" }
}; 	

L["BONUSSCANNER_PATTERNS_GENERIC_STAGE2"] = {
	{ pattern = "Resist", 	effect = "RES" },	
	{ pattern = "Damage", 	effect = "DMG" },
	{ pattern = "Effects", 	effect = "DMG" }
}; 	

-- finally if we got no match, we match against some special enchantment patterns.
L["BONUSSCANNER_PATTERNS_OTHER"] = {
-- Infused Amethyst
	{ pattern = "Spell Power %+(%d+) and Stamina %+(%d+)", effect = {"SPELLPOW", "STA"} },
	
-- special patterns that cannot be handled any other way
	{ pattern = "%+21 Critical Strike Rating and %+2%% Mana", effect = {"CRIT", "PERCMANA"}, value = {21, 2} },
	{ pattern = "%+12 Critical Strike Rating and Reduces Snare/Root Duration by 15%%", effect = {"CRIT", "PERCSNARE"}, value = {12, 15} },
	{ pattern = "%+21 Critical Strike Rating and Reduces Snare/Root Duration by 15%%", effect = {"CRIT", "PERCSNARE"}, value = {21, 15} },
	{ pattern = "%+14 Spell Power and %+2%% Intellect", effect = {"SPELLPOW", "PERCINT"}, value = {14, 2} },
	{ pattern = "%+25 Spell Power and %+2%% Intellect", effect = {"SPELLPOW", "PERCINT"}, value = {25, 2} },	
	{ pattern = "%+18 Stamina and  Stun Duration Reduced by 15%% Stun Resist", effect = {"STA", "PERCSTUN"}, value = {18, 15} },
	{ pattern = "%+18 Spell Power and %+4 Mana/5 seconds", effect = {"SPELLPOW", "MANAREG"}, value = {18, 4} },
	{ pattern = "%+24 Spell Power and %+6 Mana/5 seconds", effect = {"SPELLPOW", "MANAREG"}, value = {24, 6} },
	{ pattern = "%+61 Spell Power and %+6 Mana/5 seconds", effect = {"SPELLPOW", "MANAREG"}, value = {61, 6} },
	{ pattern = "%+2%% Threat and 10 Parry Rating", effect = {"THREATINCREASE","PARRY"}, value = {2 , 10} },

-- rest of custom patterns
  { pattern = "Increases attack power by (%d+) in Cat, Bear, Dire Bear, and Moonkin forms only%.", effect = "ATTACKPOWERFERAL" },
	{ pattern = "Mana Regen (%d+) per 5 sec", effect = "MANAREG" },
	{ pattern = "%+(%d+)% Health and Mana every 5 sec", effect = {"MANAREG", "HEALTHREG"} },
	{ pattern = "%+(%d+)% Mana and Health every 5 sec", effect = {"MANAREG", "HEALTHREG"} },
	{ pattern = "Reinforced %(%+(%d+) Armor%)", effect = "ARMOR" },
	{ pattern = "%+(%d+)%% Threat", effect = "THREATINCREASE" },
	{ pattern = "Scope %(%+(%d+) Critical Strike Rating%)", effect = "CRIT" },
	{ pattern = "Scope %(%+(%d+) Damage%)", effect = "RANGEDDMG" },
};

-- localized strings
L["BONUSSCANNER_BONUSSUM_LABEL"] = "Item Bonus Summary";
L["BONUSSCANNER_TOOLTIP_STRING"] = "BonusScanner Tooltip Bonus Summary ";
L["BONUSSCANNER_TOOLTIPGEMS_STRING"] = "Gem color count ";
L["BONUSSCANNER_BASICLINKID_STRING"] = "Basic Itemlink ID's ";
L["BONUSSCANNER_EXTENDEDLINKID_STRING"] = "Extended Itemlink ID's ";
L["BONUSSCANNER_TOOLTIP_ENABLED"] = "Enabled";
L["BONUSSCANNER_TOOLTIP_DISABLED"] = "Disabled";
L["BONUSSCANNER_IBONUS_LABEL"] = "Item bonuses of ";
L["BONUSSCANNER_NOBONUS_LABEL"] = "No bonuses detected.";
L["BONUSSCANNER_CUREQ_LABEL"] = "Current equipment bonuses";
L["BONUSSCANNER_CUREQDET_LABEL"] = "Current equipment bonus details";
L["BONUSSCANNER_OOR_LABEL"] = " is out of range.";
L["BONUSSCANNER_GEMCOUNT_LABEL"] = "Counts as ";
L["BONUSSCANNER_INVALIDTAR_LABEL"] = "Invalid target to scan.";
L["BONUSSCANNER_SELTAR_LABEL"] = "Please select a target first.";
L["BONUSSCANNER_SLOT_LABEL"] = "slot";
L["BONUSSCANNER_FAILEDPARSE_LABEL"] = "Item is either not cached or hasn't been validated on the server.";
L["BONUSSCANNER_CACHESUMMARY_LABEL"] = "BonusScanner items cached: ";
L["BONUSSCANNER_CACHECLEAR_LABEL"] = "BonusScanner item cache has been cleared.";
L["BONUSSCANNER_SPECIAL1_LABEL"] = " crit chance";
L["BONUSSCANNER_SPECIAL2_LABEL"] = " dodged/parried";
L["BONUSSCANNER_SPECIAL3_LABEL"] = " melee";
L["BONUSSCANNER_SPECIAL4_LABEL"] = " spells";
L["BONUSSCANNER_SPECIAL5_LABEL"] = " ranged/spells";
L["BONUSSCANNER_ITEMID_LABEL"] = "Item ID: |cffffffff";
L["BONUSSCANNER_ILVL_LABEL"] = "Item Level: |cffffffff";
L["BONUSSCANNER_ENCHANTID_LABEL"] = "Enchant ID: |cffffffff";
L["BONUSSCANNER_GEM1ID_LABEL"] = "Gem1 ID: |cffffffff";
L["BONUSSCANNER_GEM2ID_LABEL"] = "Gem2 ID: |cffffffff";
L["BONUSSCANNER_GEM3ID_LABEL"] = "Gem3 ID: |cffffffff";
L["BONUSSCANNER_GEMRED_LABEL"] = "Red";
L["BONUSSCANNER_GEMBLUE_LABEL"] = "Blue";
L["BONUSSCANNER_GEMYELLOW_LABEL"] = "Yellow";
L["BONUSSCANNER_GEMPRISM_LABEL"] = "Prismatic";
L["BONUSSCANNER_AVERAGE_ILVL_LABEL"] = "Average item Level";
L["BONUSSCANNER_NEEDS_RELOADUI_LABEL"] = "Changes will take effect after the UI has been reloaded.";
L["BONUSSCANNER_LDB_PLUGIN_LABEL"] = "BonusScanner LDB Plugin ";
--bonus categories
L["BONUSSCANNER_CAT_ATT"] = "Attributes";
L["BONUSSCANNER_CAT_RES"] = "Resistance";
L["BONUSSCANNER_CAT_SKILL"] = "Skills";
L["BONUSSCANNER_CAT_BON"] = "Melee and ranged combat";
L["BONUSSCANNER_CAT_SBON"] = "Spells";
L["BONUSSCANNER_CAT_OBON"] = "Life and mana";
L["BONUSSCANNER_CAT_EBON"] = "Special Bonuses";
L["BONUSSCANNER_CAT_GEMS"] = "Socketed Gems";
--slash command text
L["BONUSSCANNER_SLASH_STRING1"] = GREEN_FONT_COLOR_CODE.."BonusScanner ";
L["BONUSSCANNER_SLASH_STRING1a"] = "|cffffffff by Crowley, Archarodim, jmsteele, Tristanian";
L["BONUSSCANNER_SLASH_STRING2"] = LIGHTYELLOW_FONT_COLOR_CODE.."Usage: |cffffffff/bscan {show | details | tooltip | tooltip gems | itembasic | itemextend | broker | clearcache | target | target <player> | <itemlink> | <itemlink> <player> | <slotname>}";
L["BONUSSCANNER_SLASH_STRING3"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."show: |cffffffffShows all the bonuses of the current equipment.";
L["BONUSSCANNER_SLASH_STRING4"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."details: |cffffffffShows bonuses with slot distribution.";
L["BONUSSCANNER_SLASH_STRING5"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."tooltip: [";
L["BONUSSCANNER_SLASH_STRING5a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffAttaches item bonus summary on tooltips.";
L["BONUSSCANNER_SLASH_STRING14"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."tooltip gems: [";
L["BONUSSCANNER_SLASH_STRING14a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffAttaches gem color count on tooltips (requires tooltips enabled).";
L["BONUSSCANNER_SLASH_STRING12"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."itembasic: [";
L["BONUSSCANNER_SLASH_STRING12a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffAttaches item level and item ID properties on tooltips (requires tooltips enabled).";
L["BONUSSCANNER_SLASH_STRING13"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."itemextend: [";
L["BONUSSCANNER_SLASH_STRING13a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffAttaches enchant and gem ID properties on tooltips (requires tooltips enabled).";
L["BONUSSCANNER_SLASH_STRING15"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."broker: [";
L["BONUSSCANNER_SLASH_STRING15a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffToggles the state of the LDB feed, used to display gear bonuses for the current character.";
L["BONUSSCANNER_SLASH_STRING11"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."clearcache: |cffffffffClears the item cache and forces a garbage collection.";
L["BONUSSCANNER_SLASH_STRING6"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."target: |cffffffffShows bonuses for your target's equipped gear (must be in inspect range).";
L["BONUSSCANNER_SLASH_STRING7"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."target <player>: |cffffffffWhispers bonuses for your target's equipped gear to the player specified.";
L["BONUSSCANNER_SLASH_STRING8"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<itemlink>: |cffffffffShows bonuses of linked item (insert link with Shift-Click).";
L["BONUSSCANNER_SLASH_STRING9"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<itemlink> <player>: |cffffffffWhispers bonuses of linked item to the player specified.";
L["BONUSSCANNER_SLASH_STRING10"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<slotname>: |cffffffffShows bonuses of given equipment slot.";