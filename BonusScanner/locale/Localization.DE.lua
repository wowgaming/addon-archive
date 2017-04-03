-- German localization for 3.3 by Tristanian (work in progress)
local L = LibStub("AceLocale-3.0"):NewLocale("BonusScanner","deDE")
if not L then return end
-- bonus names
L["BONUSSCANNER_NAMES"] = {
--Base Stats
	STR 		= "Stärke",
	AGI 		= "Beweglichkeit",
	STA 		= "Ausdauer",
	INT 		= "Intelligenz",
	SPI 		= "Willenskraft",
	ARMOR 	= "Rüstung",

--Resistances
	ARCANERES = "Arkanwiderstand",	
	FIRERES 	= "Feuerwiderstand",
	NATURERES = "Naturwiderstand",
	FROSTRES 	= "Frostwiderstand",
	SHADOWRES = "Schattenwiderstand",

--Skills
	FISHING 	= "Angeln",
	MINING 		= "Bergbau",
	HERBALISM = "Kräuterkunde",
	SKINNING 	= "Kürschnerei",
	DEFENSE 	= "Verteidigungswertung",
	EXPERTISE = "Waffenkundewertung",

--Abilities
	BLOCK		= "Blockwertung",
	BLOCKVALUE	= "Blockwert des Schildes",
	DODGE 		= "Ausweichwertung",
	PARRY 		= "Parrierwertung",
	RESILIENCE = "Abhärtungswertung", 
	DMGWPN = "Waffenschaden", 
	RANGEDDMG = "Distanzschaden", 
	ARMORPEN = "Rüstungsdurchschlagwertung",
	
-- DPS
	DPSMAIN = "Main Weapon(s) DPS",
	DPSRANGED = "Ranged Weapon DPS",
	DPSTHROWN = "Thrown Weapon DPS",

--Attack Power
	ATTACKPOWER	= "Angriffskraft",
	ATTACKPOWERUNDEAD	= "Angriffskraft gegen Untote",
	ATTACKPOWERFERAL	= "Angriffskraft in Tierform",
	RANGEDATTACKPOWER = "Distanzangriffskraft",
	
--Critical
	CRIT 		= "Kritische Trefferwertung",
	RANGEDCRIT 	= "Krit. Schuss",
	--HOLYCRIT 	= "Krit. Heiligzauber",

--Hit
	TOHIT 		= "Trefferwertung",
	RANGEDHIT	= "Distanztrefferwertung",
  
--Haste
	HASTE = "Tempowertung",

--Spell Damage/healing
	DMGUNDEAD	= "Zauberschaden gegen Untote",
	ARCANEDMG 	= "Arkanschaden",
	FIREDMG 	= "Feuerschaden",
	FROSTDMG 	= "Frostschaden",
	HOLYDMG 	= "Heiligschaden",
	NATUREDMG 	= "Naturschaden",
	SHADOWDMG 	= "Schattenschaden",
	SPELLPEN 	= "Zauberdurchschlagskraft",
	SPELLPOW = "Zaubermacht", 

--Regen
	HEALTHREG 	= "Lebensregeneration",
	MANAREG 	= "Manaregeneration",

--Health/mana
	HEALTH = "Lebenspunkte",
	MANA = "Manapunkte",
	
--Extra bonuses
  THREATREDUCTION = "% Verringerte Bedrohung",
  THREATINCREASE = "% Erhöhte Bedrohung",
  INCRCRITDMG = "% Erhöhter Kritischer Schaden",
  SPELLREFLECT = "% Zauberreflexion",
  STUNRESIST = "% Betäubungswiderstand",
  PERCINT = "% Intelligenz",
  PERCBLOCKVALUE = "% Blockwert des Schildes",
  
--WOTLK Metagems
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
--L["BONUSSCANNER_PREFIX_EQUIP"] = "Anlegen: ";
L["BONUSSCANNER_PREFIX_SET"] = "Set: ";
L["BONUSSCANNER_PREFIX_SOCKET"] = "Sockelbonus: ";
L["BONUSSCANNER_WEAPON_SPEED"] = "Tempo";
-- translation needed !
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
L["BONUSSCANNER_SEPARATORS"] = { "/", " & ", " und ", ", " };

-- passive bonus patterns. checked against lines which start with above prefixes
L["BONUSSCANNER_PATTERNS_PASSIVE"] = {
--Skills
	{ pattern = "Erhöht Verteidigungswertung um (%d+)%.", effect = "DEFENSE" }, 
	{ pattern = "Erhöht die Verteidigungswertung um (%d+)%.", effect = "DEFENSE" }, 
  { pattern = "Erhöht Eure Abhärtungswertung um (%d+)%.", effect = "RESILIENCE" }, 
  { pattern = "Erhöht Eure Waffenkundewertung um (%d+)%.", effect = "EXPERTISE" },
  { pattern = "Angeln %+(%d+)%.", effect = "FISHING" },

-- Abilities
	{ pattern = "Erhöht Eure Blockwertung um (%d+)%.", effect = "BLOCK" },
	{ pattern = "Erhöht den Blockwert Eures Schildes um (%d+)%.", effect = "BLOCKVALUE" },
	{ pattern = "Erhöht Eure Ausweichwertung um (%d+)%.", effect = "DODGE" },
	{ pattern = "Erhöht Eure Parrierwertung um (%d+)%.", effect = "PARRY" },
	{ pattern = "%+(%d+) Waffenschaden%.", effect = "DMGWPN" },

--Crit
	{ pattern = "Erhöht Eure kritische Trefferwertung um (%d+)%.", effect = "CRIT" },
	{ pattern = "Erhöht kritische Trefferwertung um (%d+)%.", effect = "CRIT" }, 
	{ pattern = "Erhöht kritische Nahkampftrefferwertung um (%d+)%.", effect = "CRIT" },	
	{ pattern = "Erhöht Eure kritische Distanztrefferwertung um (%d+)%.", effect = "RANGEDCRIT" },

--Damage/Heal/Spell Power
	{ pattern = "Erhöht die Zaubermacht um (%d+)%.", effect = "SPELLPOW" },
	{ pattern = "Erhöht Zaubermacht um (%d+)%.", effect = "SPELLPOW" }, 
	{ pattern = "Erhöht durch Arkanzauber und Arkaneffekte zugefügten Schaden um bis zu (%d+)%.", effect = "ARCANEDMG" },
	{ pattern = "Erhöht durch Feuerzauber und Feuereffekte zugefügten Schaden um bis zu (%d+)%.", effect = "FIREDMG" },
	{ pattern = "Erhöht durch Frostzauber und Frosteffekte zugefügten Schaden um bis zu (%d+)%.", effect = "FROSTDMG" },
	{ pattern = "Erhöht durch Heiligzauber und Heiligeffekte zugefügten Schaden um bis zu (%d+)%.", effect = "HOLYDMG" },
	{ pattern = "Erhöht durch Naturzauber und Natureffekte zugefügten Schaden um bis zu (%d+)%.", effect = "NATUREDMG" },
	{ pattern = "Erhöht durch Schattenzauber und Schatteneffekte zugefügten Schaden um bis zu (%d+)%.", effect = "SHADOWDMG" },	
	{ pattern = "Erhöht den durch magische Zauber und magische Effekte zugefügten Schaden gegen Untote um bis zu (%d+)%.", effect = "DMGUNDEAD" },
	
-- Multibonus Equip patterns
  { pattern = "Erhöht durch sämtliche Zauber und magische Effekte verursachte Heilung um bis zu (%d+) und den verursachten Schaden um bis zu (%d+)%.", effect = {"HEAL","DMG"} },
	{ pattern = "Erhöht die Widerstände Eures Begleiters um 130 und Euren Zaubermacht um bis zu (%d+)%.", effect = "SPELLPOW" }, -- Void Star Talisman
	{ pattern = "Erhöht Euren Zauberschaden um bis zu (%d+) und Eure Heilung um bis zu (%d+)%.", effect = {"DMG","HEAL"} },
	{ pattern = "Erhöht durch Zauber und magische Effekte verursachte Heilung aller Gruppenmitglieder, die sich im Umkreis von %d+ Metern befinden, um bis zu (%d+)%.", effect = "HEAL" },
	{ pattern = "Erhöht durch Zauber und magische Effekte verursachte Schaden und Heilung aller Gruppenmitglieder, die sich im Umkreis von %d+ Metern befinden, um bis zu (%d+)%.", effect = {"HEAL", "DMG"} },
	{ pattern = "Stellt alle 5 Sek. (%d+) Mana bei allen Gruppenmitgliedern, die sich im Umkreis von %d+ Metern befinden, wieder her.", effect = "MANAREG" },
	{ pattern = "Erhöht die kritische Trefferwertung aller Gruppenmitglieder innerhalb von %d+ Metern um (%d+)%.", effect = "CRIT" },
	{ pattern = "Verbessert Verteidigungswertung um (%d+), Schattenwiderstand um (%d+) sowie Eure normale Gesundheitsregeneration um (%d+)%.", effect = {"DEFENSE", "SHADOWRES", "HEALTHREG"} },
	
	
--Attack power
	{ pattern = "Erhöht die Angriffskraft um (%d+)%.", effect = "ATTACKPOWER" },
	{ pattern = "Erhöht Angriffskraft um (%d+)%.", effect = "ATTACKPOWER" },
	{ pattern = "Verbessert Eure Angriffskraft um (%d+)%.", effect = "ATTACKPOWER" },
	{ pattern = "Erhöht die Nahkampf- und Distanzangriffskraft um (%d+)%.", effect = {"ATTACKPOWER","RANGEDATTACKPOWER"} }, -- Andonisus, Reaper of Souls pattern
	{ pattern = "+(%d+) Distanzangriffskraft.", effect = "RANGEDATTACKPOWER" },
	{ pattern = "Erhöht die Distanzangriffskraft um (%d+)%.", effect = "RANGEDATTACKPOWER" },
  { pattern = "Erhöht die Angriffskraft in Katzengestalt, Bärengestalt, Terrorbärengestalt oder Mondkingestalt um (%d+)", effect = "ATTACKPOWERFERAL" },
  { pattern = "Erhöht die Angriffskraft im Kampf gegen Untote um (%d+)%.", effect = "ATTACKPOWERUNDEAD" },
  { pattern = "Erhöht die Angriffskraft im Kampf gegen Untote um (%d+)%. Ermöglicht das Einsammeln von Geißelsteinen im Namen der Agentumdämmerung.", effect = "ATTACKPOWERUNDEAD" },
  
--Regen
	{ pattern = "Stellt alle 5 Sek%. (%d+) Gesundheit wieder her%.", effect = "HEALTHREG" }, 
	{ pattern = "Stellt alle 5 Sek%. (%d+) Mana wieder her%.", effect = "MANAREG" },
	
	
--Hit
	{ pattern = "Erhöht Eure Trefferwertung um (%d+)%.", effect = "TOHIT" },
	{ pattern = "Erhöht Trefferwertung um (%d+)%.", effect = "TOHIT" }, 	
	
--Haste
	{ pattern = "Erhöht Tempowertung um (%d+)%.", effect = "HASTE" },	
	
--Penetration
	{ pattern = "Reduziert die Magiewiderstände der Ziele Eurer Zauber um (%d+)%.", effect = "SPELLPEN" },
	{ pattern = "Erhöht Eure Zauberdurchschlagskraft um (%d+)%.", effect = "SPELLPEN" },
	{ pattern = "Eure Angriffe ignorieren (%d+) Rüstung Eures Gegners%.", effect = "ARMORPEN" },
	{ pattern = "Erhöht Eure Rüstungsdurchschlagwertung um (%d+)%.", effect = "ARMORPEN" },
	
};

-- generic patterns have the form "+xx bonus" or "bonus +xx" or even "xx bonus" with an optional % sign after the value.

-- first the generic bonus string is looked up in the following table
L["BONUSSCANNER_PATTERNS_GENERIC_LOOKUP"] = {
	["Alle Werte"] 	= {"STR", "AGI", "STA", "INT", "SPI"},
	["Stärke"]			= "STR",
	["Beweglichkeit"]	= "AGI",
	["Ausdauer"]			= "STA",
	["Intelligenz"]		= "INT",
	["Willenskraft"] 	= "SPI",

	["Alle Widerstandsarten"] 	= { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"},
	

	["Angeln"]		= "FISHING",
	["Angelköder"]	= "FISHING",
	["Bergbau"]		= "MINING",
	["Kräuterkunde"]	= "HERBALISM",
	["Kürschnerei"]		= "SKINNING",
	["Verteidigung"]	= "DEFENSE",
	["Verteidigungsfertigkeit"]	= "DEFENSE",

	["Angriffskraft"] 	= "ATTACKPOWER",
  ["Angriffskraft gegen Untote"] 		= "ATTACKPOWERUNDEAD",
	["Angriffskraft in Katzengestalt, Bärengestalt, Terrorbärengestalt oder Mondkingestalt"] = "ATTACKPOWERFERAL",
	["Waffenschaden"] = "DMGWPN",
	
	-- TBC Patterns Generic/Gems/Sockets
				
	["Kritische Trefferwertung"] = "CRIT",
	["kritische Trefferwertung"] = "CRIT",
	["Zauberdurchschlagskraft"] = "SPELLPEN",
	["Verteidigungswertung"] = "DEFENSE",
	["Tempowertung"] = "HASTE",	
	["Mana Per 5 sec"] = "MANAREG",
	["mana per 5 sec"] = "MANAREG",
	["Mana per 5 Sec"] = "MANAREG",
	["Mana per 5 sec"] = "MANAREG", 
	["Mana per 5 Sek"] = "MANAREG",
	["Mana alle 5 Sekunden"] = "MANAREG",
	["Mana alle 5 Sek"] = "MANAREG",
	["Ausweichwertung"] 		= "DODGE",
	["Parierwertung"] = "PARRY",
	["Abhärtungswertung"] = "RESILIENCE",
	["Nahkampfschaden"] = "DMGWPN",	
	["Waffenkundewertung"] = "EXPERTISE",
	
	-- End TBC Patterns

	["Ausweichen"] 		= "DODGE",
	["Blocken"]		= "BLOCKVALUE",
	["Blockwert"]		= "BLOCKVALUE",
	["Blockwertung"]		= "BLOCK",
	["Trefferchance"] 		= "TOHIT",
	["Trefferwertung"] = "TOHIT",	
	["Distanzangriffskraft"]	= "RANGEDATTACKPOWER",
	["distanzangriffskraft"]	= "RANGEDATTACKPOWER", -- Experimental for TBC
	["Gesundheit alle 5 Sek"]	= "HEALTHREG",
	["Gesundheit in 5 Sek"]	= "HEALTHREG",
	["Heilung"] = "HEAL",
	["Heilzauber"] 	= "HEAL",
	["Erhöht Heilung"] 	= "HEAL",
	["Mana Regen"] = "MANAREG",
	["Manaregeneration"] = "MANAREG",
	--multivalue	
	["Zaubermacht"]	= "SPELLPOW",
	--/multivalue
	["Kritischer Treffer"]	= "CRIT",	
	["Gesundheit"]		= "HEALTH",
	["HP"]			= "HEALTH",
	["GP"]			= "HEALTH",
	["Mana"]		= "MANA",
	["Rüstung"]		= "ARMOR",
	["Verstärkte Rüstung"]	= "ARMOR",
	["Abhärtung"]	= "RESILIENCE",
	["Distanztrefferwertung"] = "RANGEDHIT",
	
	-- Patterns for color coded/special lines
	["erhöhter kritischer Schaden"] = "INCRCRITDMG",
};	

-- next we try to match against one pattern of stage 1 and one pattern of stage 2 and concatenate the effect strings
L["BONUSSCANNER_PATTERNS_GENERIC_STAGE1"] = {
	{ pattern = "Arkan", 	effect = "ARCANE" },	
	{ pattern = "Feuer", 	effect = "FIRE" },	
	{ pattern = "Frost", 	effect = "FROST" },	
	{ pattern = "Heilig", 	effect = "HOLY" },	
	{ pattern = "Schatten",	effect = "SHADOW" },	
	{ pattern = "Natur", 	effect = "NATURE" }
}; 	

L["BONUSSCANNER_PATTERNS_GENERIC_STAGE2"] = {
	{ pattern = "widerstand", 	effect = "RES" },	
	{ pattern = "schaden", 	effect = "DMG" },
	{ pattern = "zauber", 	effect = "DMG" },
	{ pattern = "effekte", 	effect = "DMG" }
}; 	

-- finally if we got no match, we match against some special enchantment patterns.
L["BONUSSCANNER_PATTERNS_OTHER"] = {

-- mage/warlock ZG patterns
-- Aldor/Scryer enchants that cannot be handled any other way	
	{ pattern = "%+15 Ausweichwertung und Verteidigungswertung %+10", effect = {"DODGE", "DEFENSE"}, value = {15, 10} },
	
	
-- special patterns that cannot be handled any other way	
  { pattern = "+12 Beweglichkeit und um 3%% erhöhter kritischer Schaden", effect = {"AGI","INCRCRITDMG"}, value = {12, 3} },
  { pattern = "+21 Beweglichkeit und um 3%% erhöhter kritischer Schaden", effect = {"AGI","INCRCRITDMG"}, value = {21, 3} },
  { pattern = "+12 Kritische Trefferwertung und um 3%% erhöhter kritischer Schaden", effect = {"CRIT", "INCRCRITDMG"}, value = {12, 3} },
  { pattern = "+21 Kritische Trefferwertung und um 3%% erhöhter kritischer Schaden", effect = {"CRIT", "INCRCRITDMG"}, value = {21, 3} },
  { pattern = "+14 Kritische Trefferwertung und 1%% Zauberreflexion", effect = {"CRIT", "SPELLREFLECT"}, value = {14, 1} },
  { pattern = "+14 Zauberschaden und 5%% Betäubungswiderstand", effect = {"DMG", "STUNRESIST"}, value = {14, 5} },
  { pattern = "+24 Angriffskraft und 5%% Betäubungswiderstand", effect = {"ATTACKPOWER", "STUNRESIST"}, value = {24, 5} },
  { pattern = "+18 Ausdauer und 5%% Betäubungswiderstand", effect = {"STA", "STUNRESIST"}, value = {18, 5} },
  { pattern = "%+14 Zaubermacht und %+2%% Intelligenz", effect = {"SPELLPOW", "PERCINT"}, value = {14, 2} },
  { pattern = "%+12 Verteidigungswertung und %+10%% Blockwert des Schildes", effect = {"DEFENSE", "PERCBLOCKVALUE"}, value = {12, 10} },

--rest of custom patterns
  { pattern = "Erhöht die Angriffskraft um (%d+) nur in Katzen%-, Bären%-, Terrorbären%- und Mondkingestalt%.", effect = "ATTACKPOWERFERAL" },
	{ pattern = "Manaregeneration (%d+) pro 5 Sek", effect = "MANAREG" },
	{ pattern = "Manaregeneration (%d+) per 5 Sek", effect = "MANAREG" },
	{ pattern = "alle 5 Sek%. (%d+) Mana", effect = "MANAREG" },
	{ pattern = "Alle 5 Sek%. (%d+) Mana", effect = "MANAREG" },
	{ pattern = "Verstärkt %(%+(%d+) Rüstung%)", effect = "ARMOR" },
	{ pattern = "%+(%d+)%% Bedrohung", effect = "THREATINCREASE" },
	{ pattern = "Zielfernrohr %(%+(%d+) Schaden%)", effect = "RANGEDDMG" },
};

-- localized strings
L["BONUSSCANNER_BONUSSUM_LABEL"] = "Item Bonus Zusammenfassung";
L["BONUSSCANNER_TOOLTIP_STRING"] = "BonusScanner Tooltip Bonus Zusammenfassung ";
L["BONUSSCANNER_TOOLTIPGEMS_STRING"] = "Edelsteinfarben ";
L["BONUSSCANNER_BASICLINKID_STRING"] = "Basis Itemlink ID's ";
L["BONUSSCANNER_EXTENDEDLINKID_STRING"] = "Erweiterte Itemlink ID's "; -- SENSITY
L["BONUSSCANNER_TOOLTIP_ENABLED"] = "Aktiviert";
L["BONUSSCANNER_TOOLTIP_DISABLED"] = "Deaktiviert";
L["BONUSSCANNER_IBONUS_LABEL"] = "Boni für ";
L["BONUSSCANNER_NOBONUS_LABEL"] = "Keine Boni.";
L["BONUSSCANNER_CUREQ_LABEL"] = "Derzeitige Ausrüstungs-Boni";
L["BONUSSCANNER_CUREQDET_LABEL"] = "Derzeitige Ausrüstungs-Boni Details";
L["BONUSSCANNER_OOR_LABEL"] = " ist ausserhalb der Reichweite."; -- SENSITY
L["BONUSSCANNER_GEMCOUNT_LABEL"] = "Gelten als ";
L["BONUSSCANNER_INVALIDTAR_LABEL"] ="Ungültiges Ziel zum Scannen."; -- SENSITY
L["BONUSSCANNER_SELTAR_LABEL"] = "Wählen Sie bitte zuerst ein Ziel."; -- SENSITY
L["BONUSSCANNER_SLOT_LABEL"] = "slot";
L["BONUSSCANNER_FAILEDPARSE_LABEL"] = "Gegenstand ist nicht gespeichert oder konnte nicht auf dem Server verglichen werden."; -- SENSITY
L["BONUSSCANNER_CACHESUMMARY_LABEL"] = "gespeicherte Bonusscanner-Items: "; -- SENSITY
L["BONUSSCANNER_CACHECLEAR_LABEL"] = "Bonusscanner-Itemcache gelöscht."; -- SENSITY
L["BONUSSCANNER_SPECIAL1_LABEL"] = " kritische Trefferchance"; -- SENSITY
L["BONUSSCANNER_SPECIAL2_LABEL"] = " ausgewichen/abgewehrt";
L["BONUSSCANNER_SPECIAL3_LABEL"] = " melee";
L["BONUSSCANNER_SPECIAL4_LABEL"] = " spells";
L["BONUSSCANNER_SPECIAL5_LABEL"] = " ranged/spells";
L["BONUSSCANNER_ITEMID_LABEL"] = "Gegenstands-ID: |cffffffff";
L["BONUSSCANNER_ILVL_LABEL"] = "Gegenstandslevel: |cffffffff";
L["BONUSSCANNER_ENCHANTID_LABEL"] = "Verzauberungs-ID: |cffffffff";
L["BONUSSCANNER_GEM1ID_LABEL"] = "Edelstein1 ID: |cffffffff";
L["BONUSSCANNER_GEM2ID_LABEL"] = "Edelstein2 ID: |cffffffff";
L["BONUSSCANNER_GEM3ID_LABEL"] = "Edelstein3 ID: |cffffffff";
L["BONUSSCANNER_GEMRED_LABEL"] = "Rot";
L["BONUSSCANNER_GEMBLUE_LABEL"] = "Blau";
L["BONUSSCANNER_GEMYELLOW_LABEL"] = "Gelb";
L["BONUSSCANNER_GEMPRISM_LABEL"] = "Prismatic";
L["BONUSSCANNER_AVERAGE_ILVL_LABEL"] = "Average item Level";
L["BONUSSCANNER_NEEDS_RELOADUI_LABEL"] = "Changes will take effect after the UI has been reloaded.";
L["BONUSSCANNER_LDB_PLUGIN_LABEL"] = "BonusScanner LDB Plugin ";
--bonus categories
L["BONUSSCANNER_CAT_ATT"] = "Attribute";
L["BONUSSCANNER_CAT_RES"] = "Widerstand";
L["BONUSSCANNER_CAT_SKILL"] = "Fertigkeiten";
L["BONUSSCANNER_CAT_BON"] = "Nah- und Fernkampf";
L["BONUSSCANNER_CAT_SBON"] = "Zauber";
L["BONUSSCANNER_CAT_OBON"] = "Leben und Mana";
L["BONUSSCANNER_CAT_EBON"] = "Spezielle Fähigkeiten";
L["BONUSSCANNER_CAT_GEMS"] = "Edelsteine";
--slash command text
L["BONUSSCANNER_SLASH_STRING1"] = GREEN_FONT_COLOR_CODE.."BonusScanner ";
L["BONUSSCANNER_SLASH_STRING1a"] = "|cffffffff by Crowley, Archarodim, jmsteele, Tristanian";
L["BONUSSCANNER_SLASH_STRING2"] = LIGHTYELLOW_FONT_COLOR_CODE.."Usage: |cffffffff/bs {show | details | tooltip | tooltip gems | itembasic | itemextend | broker | clearcache | target | target <player> | <itemlink> | <itemlink> <player> | <slotname>}";
L["BONUSSCANNER_SLASH_STRING3"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."show: |cffffffffZeige alle Boni der aktuellen Ausrüstung.";
L["BONUSSCANNER_SLASH_STRING4"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."details: |cffffffffZeige Boni nach Slot-Verteilung.";
L["BONUSSCANNER_SLASH_STRING5"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."tooltip: [";
L["BONUSSCANNER_SLASH_STRING5a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffErgänzt Tooltip mit Item-Zusammenfassung."; -- SENSITY
L["BONUSSCANNER_SLASH_STRING14"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."tooltip gems: [";
L["BONUSSCANNER_SLASH_STRING14a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffErgänzt Tooltip mit Edelsteinfarben (erfordert aktivierte Tooltips)."; -- SENSITY
L["BONUSSCANNER_SLASH_STRING12"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."itembasic: [";
L["BONUSSCANNER_SLASH_STRING12a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffErgänzt Tooltip mit Gegenstandslevel und -ID."; -- SENSITY
L["BONUSSCANNER_SLASH_STRING13"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."itemextend: [";
L["BONUSSCANNER_SLASH_STRING13a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffErgänzt Tooltip mit Verzauberungs- u. Edelstein-ID."; -- SENSITY
L["BONUSSCANNER_SLASH_STRING15"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."broker: [";
L["BONUSSCANNER_SLASH_STRING15a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffToggles the state of the LDB plugin, used to display gear bonuses for the current character.";
L["BONUSSCANNER_SLASH_STRING11"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."clearcache: |cffffffffLöscht den Item-Cache."; -- SENSITY
L["BONUSSCANNER_SLASH_STRING6"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."target: |cffffffffZeige Boni der Ausrüstung eines anderen Spielers.";
L["BONUSSCANNER_SLASH_STRING7"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."target <player>: |cffffffffSendet Ausrüstungsboni des Ziels (muss in Reichweite sein) an einen ausgewählten Spieler."; -- SENSITY
L["BONUSSCANNER_SLASH_STRING8"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<itemlink>: |cffffffffZeige Boni eines gelinkten Gegenstands."; -- SENSITY
L["BONUSSCANNER_SLASH_STRING9"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<itemlink> <player>: |cffffffffSendet Gegenstandsboni an einen ausgewählten Spieler."; -- SENSITY
L["BONUSSCANNER_SLASH_STRING10"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<slotname>: |cffffffffZeige Boni für bestimten Slot.";