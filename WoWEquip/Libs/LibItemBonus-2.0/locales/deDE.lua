if GetLocale() ~= "deDE" then return end

local lib = LibStub("LibItemBonus-2.0")

if not lib._LOADING then return end

local ALL_RESISTS = {"ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}
local ALL_STATS = {"STR", "AGI", "STA", "INT", "SPI"}
local HEAL_AND_DMG = {"HEAL", "DMG"}

lib.patterns = {
	NAMES = {
		STR = "Stärke",
		AGI = "Beweglichkeit",
		STA = "Ausdauer",
		INT = "Intelligenz",
		SPI = "Willenskraft",
		ARMOR = "R\195\188stung",
		BASE_ARMOR = "R\195\188stung",
		ARMOR_BONUS = "Verstärkte R\195\188stung",

		ARCANERES = "Arkanwiderstand",
		FIRERES = "Feuerwiderstand",
		NATURERES = "Naturwiderstand",
		FROSTRES = "Frostwiderstand",
		SHADOWRES = "Schattenwiderstand",

		FISHING = "Angeln",
		MINING = "Bergbau",
		HERBALISM = "Kräuterkunde",
		SKINNING = "K\195\188rschnerei",
		DEFENSE = "Verteidigung",

		BLOCK = "Blockchance",
		BLOCKVALUE = "Blockwert Eures Schildes",
		DODGE = "Ausweichen",
		PARRY = "Parieren",
		ATTACKPOWER = "Angriffskraft",
		ATTACKPOWERUNDEAD = "Angriffskraft gegen Untote",
		ATTACKPOWERFERAL = "Angriffskraft in Tierform",
		CRIT = "krit. Treffer",
		RANGEDATTACKPOWER = "Distanzangriffskraft",
		RANGEDCRIT = "krit. Schuss",
		TOHIT = "Trefferchance",
		IGNOREARMOR = "Ignorierte R\195\188stung",
		THREATREDUCTION = "Reduzierte Bedrohung",

        SPELLPOWER = "Zaubermacht",
		SPELLCRIT = "krit. Zauber",
		SPELLTOHIT = "Zaubertrefferchance",
		SPELLPEN = "Zauberdurchschlag",
		HOLYCRIT = "krit. Heiligzauber",

		HEALTHREG = "Lebensregeneration",
		MANAREG = "Manaregeneration",
		HEALTH = "Lebenspunkte",
		MANA = "Manapunkte",

		CR_WEAPON = "Waffenwertung",
		CR_DEFENSE = "Verteidigungswertung",
		CR_DODGE = "Ausweichwertung",
		CR_PARRY = "Parierwertung", -- Parieren hat kein Doppel-R
		CR_BLOCK = "Blockwertung",
		CR_HIT = "Trefferwertung",
		CR_RANGEDHIT = "Distanztrefferwertung",
		CR_CRIT = "kritische Trefferwertung",
		CR_HASTE = "Tempowertung",
		CR_RESILIENCE = "Abh\195\164rtungswertung",
        CR_ARMOR_PENETRATION = "R\195\188stungsdurchschlagwertung",
    },

	PATTERNS_SKILL_RATING = {
		{ pattern = "Erh\195\182ht Eure (.*) um (%d+)" },
		{ pattern = "Erh\195\182ht die (.*) um (%d+)" },
        { pattern = "Erh\195\182ht den (.*) um (%d+)" },
		{ pattern = "Erh\195\182ht (.*) um (%d+)" },
	},
	SKILL_NAMES = {
		["Trefferwertung"] = "CR_HIT",
		["kritische Trefferwertung"] = "CR_CRIT",
		--["ranged critical strike"] = "CR_RANGEDCRIT",
		["Verteidigungswertung"] = "CR_DEFENSE",
		["Abhärtungswertung"] = "CR_RESILIENCE",
		["Ausweichwertung"] = "CR_DODGE",
		["Blockwertung"] = "CR_BLOCK",
		["Parierwertung"] = "CR_PARRY",
		--["axe skill"] = "CR_WEAPON_AXE",
		--["dagger skill"] = "CR_WEAPON_DAGGER",
		--["mace skill"] = "CR_WEAPON_MACE",
		--["sword skill"] = "CR_WEAPON_SWORD",
		--["two-handed sword skill"] = "CR_WEAPON_SWORD_2H",
		--["feral combat skill"] = "CR_WEAPON_FERAL",
		["Tempowertung"] = "CR_HASTE",
		--["unarmed skill"] = "CR_WEAPON_FIST",
		--["fist skill"] = "CR_WEAPON_FIST",
		--["crossbow skill"] = "CR_WEAPON_CROSSBOW",
		--["gun skill"] = "CR_WEAPON_GUN",
		--["bow skill"] = "CR_WEAPON_BOW",
		--["staff skill"] = "CR_WEAPON_STAFF",
		--["two-handed maces skill"] = "CR_WEAPON_MACE_2H",
		--["two-handed axes skill"] = "CR_WEAPON_AXE_2H",
		["Waffenkundewertung"] = "CR_EXPERTISE",
		["R\195\188stungsdurchschlagwert"] = "CR_ARMOR_PENETRATION",
        ["R\195\188stungsdurchschlagwertung"] = "CR_ARMOR_PENETRATION",
    },

	PATTERNS_PASSIVE = {
		{ pattern = "%+(%d+) bei allen Widerstandsarten%.", effect = ALL_RESISTS },
		{ pattern = "+(%d+) Distanzangriffskraft.", effect = "RANGEDATTACKPOWER" },
		{ pattern = "Erh\195\182ht Eure Chance, Angriffe mit einem Schild zu blocken, um (%d+)%%%.", effect = "BLOCK" },
		{ pattern = "Erh\195\182ht den Blockwert Eures Schildes um (%d+)%.", effect = "BLOCKVALUE" },
		{ pattern = "Erh\195\182ht Eure Chance, einem Angriff auszuweichen, um (%d+)%%%.", effect = "DODGE" },
		{ pattern = "Erh\195\182ht Eure Chance, einen Angriff zu parieren, um (%d+)%%%.", effect = "PARRY" },
		{ pattern = "Erh\195\182ht Eure Chance, einen kritischen Treffer durch Zauber zu erzielen, um (%d+)%%%.", effect = "SPELLCRIT" },
		{ pattern = "Erh\195\182ht Eure Chance, einen kritischen Treffer durch Heiligzauber zu erzielen, um (%d+)%%%.", effect = "HOLYCRIT" },
		{ pattern = "Erh\195\182ht Eure Chance, einen kritischen Treffer zu erzielen, um (%d+)%%%.", effect = "CRIT" },
		{ pattern = "Erh\195\182ht Eure Chance, mit Fernkampfwaffen einen kritischen Treffer zu erzielen, um (%d+)%.", effect = "RANGEDCRIT" },
		{ pattern = "Erh\195\182ht durch Arkanzauber und Arkaneffekte zugef\195\188gten Schaden um bis zu (%d+)%.", effect = "ARCANEDMG" },
		{ pattern = "Erh\195\182ht durch Feuerzauber und Feuereffekte zugef\195\188gten Schaden um bis zu (%d+)%.", effect = "FIREDMG" },
		{ pattern = "Erh\195\182ht durch Frostzauber und Frosteffekte zugef\195\188gten Schaden um bis zu (%d+)%.", effect = "FROSTDMG" },
		{ pattern = "Erh\195\182ht durch Heiligzauber und Heiligeffekte zugef\195\188gten Schaden um bis zu (%d+)%.", effect = "HOLYDMG" },
		{ pattern = "Erh\195\182ht durch Naturzauber und Natureffekte zugef\195\188gten Schaden um bis zu (%d+)%.", effect = "NATUREDMG" },
		{ pattern = "Erh\195\182ht durch Schattenzauber und Schatteneffekte zugef\195\188gten Schaden um bis zu (%d+)%.", effect = "SHADOWDMG" },
		{ pattern = "Erh\195\182ht durch Zauber und Effekte verursachte Heilung um bis zu (%d+)%.", effect = "HEAL" },
		{ pattern = "Erh\195\182ht durch sämtliche Zauber und magische Effekte verursachte Heilung um bis zu (%d+) und den verursachten Schaden um bis zu (%d+)%.", effect = HEAL_AND_DMG },
		{ pattern = "Erh\195\182ht durch Zauber und magische Effekte zugef\195\188gten Schaden und Heilung um bis zu (%d+)%.", effect = HEAL_AND_DMG },
		{ pattern = "Erh\195\182ht durch Zauber und magische Effekte verursachten Schaden und Heilung um bis zu (%d+)%.", effect = HEAL_AND_DMG },
		{ pattern = "Erh\195\182ht den durch magische Zauber und magische Effekte zugef\195\188gten Schaden gegen Untote um bis zu (%d+)%.", effect = "DMGUNDEAD", nofinish = true },
		{ pattern = "Erh\195\182ht die Angriffskraft im Kampf gegen Untote um (%d+)%.", effect = "ATTACKPOWERUNDEAD", nofinish = true },
		{ pattern = "Erh\195\182ht die Angriffskraft im Kampf gegen Untote um (%d+)%. Erm\195\182glicht das Einsammeln von Geißelsteinen im Namen der Agentumdämmerung", effect = "ATTACKPOWERUNDEAD" },
		{ pattern = "Stellt alle 5 Sek%. (%d+) Gesundheit wieder her%.", effect = "HEALTHREG" },
		{ pattern = "Stellt alle 5 Sek%. (%d+) Mana wieder her%.", effect = "MANAREG" },
		{ pattern = "Verbessert Eure Trefferchance um (%d+)%%%.", effect = "TOHIT" },
		{ pattern = "Reduziert die Magiewiderstände der Ziele Eurer Zauber um (%d+)%.", effect = "SPELLPEN" },

		{ pattern = ".+ Angriffstempowertung um (%d+)", effect = "CR_HASTE"},
		{ pattern = "Erh\195\182ht Eure Angriffstempowertung %d Sek%. lang um (%d+)%.", effect = "CR_HASTE"},
		{ pattern = ".+ Zaubertempowertung um (%d+)", effect = "CR_SPELLHASTE"},
		{ pattern = ".+ Distanztempowertung um (%d+)%.", effect = "CR_RANGEDHASTE"},
		{ pattern = "Eure Angriffe ignorieren (%d+) R\195\188stung Eures Gegners%.", effect = "IGNOREARMOR"},
		{ pattern = "Erh\195\182ht Tempowertung um (%d+)%.", effect = "CR_HASTE"},

		-- Atiesh related patterns
		{ pattern = "Erh\195\182ht Euren Zauberschaden um bis zu (%d+) und Eure Heilung um bis zu (%d+)%.", effect = {"DMG","HEAL"} },
		{ pattern = "Erh\195\182ht durch Zauber und magische Effekte verursachte Heilung aller Gruppenmitglieder, die sich im Umkreis von %d+ Metern befinden, um bis zu (%d+)%.", effect = "HEAL" },
		{ pattern = "Erh\195\182ht durch Zauber und magische Effekte verursachte Schaden und Heilung aller Gruppenmitglieder, die sich im Umkreis von %d+ Metern befinden, um bis zu (%d+)%.", effect = HEAL_AND_DMG },
		{ pattern = "Stellt alle 5 Sek. (%d+) Mana bei allen Gruppenmitgliedern, die sich im Umkreis von %d+ Metern befinden, wieder her.", effect = "MANAREG" },
		{ pattern = "Erh\195\182ht die kritische Zaubertrefferwertung aller Gruppenmitglieder innerhalb von %d+ Metern um (%d+)%.", effect = "SPELLCRIT" },

		-- Added for HealPoints
		--{ pattern = "Allow (%d+)%% of your Mana regeneration to continue while casting%.", effect = "CASTINGREG"},
		--{ pattern = "Reduces the casting time of your Regrowth spell by 0%.(%d+) sec%.", effect = "CASTINGREGROWTH"},
		--{ pattern = "Reduces the casting time of your Holy Light spell by 0%.(%d+) sec%.", effect = "CASTINGHOLYLIGHT"},
		--{ pattern = "Reduces the casting time of your Healing Touch spell by 0%.(%d+) sec%.", effect = "CASTINGHEALINGTOUCH"},
		--{ pattern = "%-0%.(%d+) sec to the casting time of your Flash Heal spell%.", effect = "CASTINGFLASHHEAL"},
		--{ pattern = "%-0%.(%d+) seconds on the casting time of your Chain Heal spell%.", effect = "CASTINGCHAINHEAL"},
		--{{ pattern = "Increases the duration of your Rejuvenation spell by (%d+) sec%.", effect = "DURATIONREJUV"},
		--{{ pattern = "Increases the duration of your Renew spell by (%d+) sec%.", effect = "DURATIONRENEW"},
		--{{ pattern = "Increases your normal health and mana regeneration by (%d+)%.", effect = "MANAREGNORMAL"},
		--{{ pattern = "Increases the amount healed by Chain Heal to targets beyond the first by (%d+)%%%.", effect = "IMPCHAINHEAL"},
		--{{ pattern = "Increases healing done by Rejuvenation by up to (%d+)%.", effect = "IMPREJUVENATION"},
		--{{ pattern = "Increases healing done by Lesser Healing Wave by up to (%d+)%.", effect = "IMPLESSERHEALINGWAVE"},
		--{{ pattern = "Increases healing done by Flash of Light by up to (%d+)%.", effect = "IMPFLASHOFLIGHT"},
		--{{ pattern = "After casting your Healing Wave or Lesser Healing Wave spell%, gives you a 25%% chance to gain Mana equal to (%d+)%% of the base cost of the spell%.", effect = "REFUNDHEALINGWAVE"},
		--{{ pattern = "Your Healing Wave will now jump to additional nearby targets%. Each jump reduces the effectiveness of the heal by (%d+)%%%, and the spell will jump to up to two additional targets%.", effect = "JUMPHEALINGWAVE"},
		--{{ pattern = "Reduces the mana cost of your Healing Touch%, Regrowth%, Rejuvenation and Tranquility spells by (%d+)%%%.", effect = "CHEAPERDRUID"},
		--{{ pattern = "On Healing Touch critical hits%, you regain (%d+)%% of the mana cost of the spell%.", effect = "REFUNDHTCRIT"},
		--{{ pattern = "Reduces the mana cost of your Renew spell by (%d+)%%%.", effect = "CHEAPERRENEW"},

		--{ pattern = "Increases your spell penetration by (%d+)%.", effect = "SPELLPEN" },
		{ pattern = "Erh\195\182ht die Zaubermacht um (%d+)%.", effect = "SPELLPOWER" },
        { pattern = "Erh\195\182ht Zaubermacht um (%d+)%.", effect = "SPELLPOWER" },
		{ pattern = "Erh\195\182ht die Angriffskraft um (%d+)%.", effect = "ATTACKPOWER" },
		--{{ pattern = "Increases attack power by (%d+) in Cat, Bear, Dire Bear, and Moonkin forms only%.", effect = "ATTACKPOWERFERAL" },
		--{{ pattern = "Restores (%d+) health every 4 sec%.", effect = "HEALTHREG" }, -- 6461 (typo ?)
		--{{ pattern = "Increases your effective stealth level by (%d+)%.", effect = "STEALTH" },
		--{ pattern = "Increases ranged attack speed by (%d+)%%%.", effect = "RANGED_SPEED_BONUS" }, -- bags are not scanned
		--{{ pattern = "Gives (%d+) additional stamina to party members within %d+ yards%.", effect = "STA" }, -- 4248
		--{{ pattern = "Increases swim speed by (%d+)%%%.", effect = "SWIMSPEED" }, -- 7052
		--{{ pattern = "Increases mount speed by (%d+)%%%.", effect = "MOUNTSPEED" }, -- 11122
		--{{ pattern = "Increases run speed by (%d+)%%%.", effect = "RUNSPEED" }, -- 13388
		--{{ pattern = "Decreases your chance to parry an attack by (%d+)%%%.", effect = "NEGPARRY" }, -- 7348
		--{{ pattern = "Increases your chance to resist Stun and Fear effects by (%d+)%%%.", effect = {"STUNRESIST", "FEARRESIST"} }, -- 17759
		--{{ pattern = "Increases your chance to resist Fear effects by (%d+)%%%.", effect = "FEARRESIST" }, -- 28428, 28429, 28430
		--{{ pattern = "Increases your chance to resist Stun and Disorient effects by (%d+)%%%.", effect = {"STUNRESIST", "DISORIENTRESIST"} }, -- 23839
		--{{ pattern = "Increases mount speed by (%d+)%%%.", effect = "MOUNTSPEED" }, -- 25653
		--{{ pattern = "Reduces melee damage taken by (%d+)%.", effect = "MELEETAKEN" }, -- 31154
		--{{ pattern = "Spell Damage received is reduced by (%d+)%.", effect = "DMGTAKEN" }, -- 22191
		--{{ pattern = "Scope %(%+(%d+) Critical Strike Rating%)", effect = "CR_RANGEDCRIT" },

		-- metagem bonuses (thanks Lerkur)
--~ 		{ pattern = "%+(%d+) Agility & (%d+)%% Increased Critical Damage", effect = {"AGI", "CRITDMG"} },
--~ 		{ pattern = "%+(%d+) Defense Rating & %+(%d+)%% Shield Block Value", effect = {"CR_DEFENSE", "MOD_BLOCKVALUE"} },
	},

	SEPARATORS = { "/", ",", "&", " und " },

	GENERIC_PATTERNS = {
		["^%+?(%d+)%%?(.*)$"]	= true,
		["^(.*)%+ ?(%d+)%%?$"]	= false,
		["^(.*): ?(%d+)$"]		= false
	},

	PATTERNS_GENERIC_LOOKUP = {
		["Alle Werte"] = ALL_STATS,
		["Stärke"] = "STR",
		["Beweglichkeit"] = "AGI",
		["Ausdauer"] = "STA",
		["Intelligenz"] = "INT",
		["Willenskraft"] = "SPI",

		["Alle Widerstandsarten"] = ALL_RESISTS,

		["Angeln"] = "FISHING",
		["Angelk\195\182der"] = "FISHING",
		["Bergbau"] = "MINING",
		["Kräuterkunde"] = "HERBALISM",
		["K\195\188rschnerei"] = "SKINNING",
		["Verteidigung"] = "DEFENSE",
		["Verteidigungsfertigkeit"] = "DEFENSE",

		["Angriffskraft"] = "ATTACKPOWER",
		["Angriffskraft gegen Untote"] = "ATTACKPOWERUNDEAD",
		["Angriffskraft in Katzengestalt, Bärengestalt oder Terrorbärengestalt"] = "ATTACKPOWERFERAL",

		["Ausweichen"] = "DODGE",
		["Blocken"] = "BLOCK",
		["Blockwert"] = "BLOCKVALUE",
		["Trefferchance"] = "TOHIT",
		["Distanzangriffskraft"] = "RANGEDATTACKPOWER",
		["Gesundheit alle 5 Sek"] = "HEALTHREG",
		["Heilzauber"] = "HEAL",
		["Erh\195\182ht Heilung"] = "HEAL",
		["Mana alle 5 Sek"] = "MANAREG",
		["Manaregeneration"] = "MANAREG",
		["Zauberschaden erh\195\182hen"]= "DMG",
		["Kritischer Treffer"] = "CRIT",
		["Gesundheit"] = "HEALTH",
		["HP"] = "HEALTH",
		["Mana"] = "MANA",
		["R\195\188stung"] = "BASE_ARMOR",
		["Verstärkte R\195\188stung"]= "ARMOR_BONUS",
		["Reduzierte Bedrohung"] = "THREATREDUCTION",
        ["Zaubermacht"] = "SPELLPOWER",
    },

	PATTERNS_GENERIC_STAGE1 = {
		{ pattern = "Arkan", effect = "ARCANE" },
		{ pattern = "Feuer", effect = "FIRE" },
		{ pattern = "Frost", effect = "FROST" },
		{ pattern = "Heilig", effect = "HOLY" },
		{ pattern = "Schatten", effect = "SHADOW" },
		{ pattern = "Natur", effect = "NATURE" },
	},

	PATTERNS_GENERIC_STAGE2 = {
		{ pattern = "widerst", effect = "RES" },
		{ pattern = "schaden", effect = "SPELLPOWER" },
		{ pattern = "effekte", effect = "SPELLPOWER" },
	},

	PATTERNS_OTHER = {
		{ pattern = "Manaregeneration (%d+) pro 5 Sek%.", effect = "MANAREG" },

		{ pattern = "Zandalarianisches Siegel der Macht", effect = "ATTACKPOWER", value = 30 },
		{ pattern = "Zandalarianisches Siegel des Mojo", effect = HEAL_AND_DMG, value = 18 },
		{ pattern = "Zandalarianisches Siegel der Inneren Ruhe", effect = "HEAL", value = 33 },

		{ pattern = "Schwaches Zauber\195\182l", effect = HEAL_AND_DMG, value = 8 },
		{ pattern = "Geringes Zauber\195\182l", effect = HEAL_AND_DMG, value = 16 },
		{ pattern = "Zauber\195\182l", effect = HEAL_AND_DMG, value = 24 },
		{ pattern = "Hervorragendes Zauber\195\182l", effect = {"DMG", "HEAL", "CR_SPELLCRIT"}, value = {36, 36, 14} },
		{ pattern = "Überragendes Zauber\195\182l", effect = HEAL_AND_DMG, value = 42 },

		{ pattern = "Schwaches Mana\195\182l", effect = "MANAREG", value = 4 },
		{ pattern = "Geringes Mana\195\182l", effect = "MANAREG", value = 8 },
		{ pattern = "Hervorragendes Mana\195\182l", effect = { "MANAREG", "HEAL"}, value = {12, 25} },
		{ pattern = "Überragendes Mana\195\182l", effect = "MANAREG", value = 14 },

		{ pattern = "Eterniumangelschnur", effect = "FISHING", value = 5 },
		{ pattern = "%+30 Distanztrefferwertung", effect = "CR_RANGEDHIT", value = 30 }, --Biznicks 247x128 Accurascope
		{ pattern = "Vitalität", effect = {"MANAREG", "HEALTHREG"}, value = {4, 4} },
		{ pattern = "Seelenfrost", effect = {"FROSTDMG", "SHADOWDMG"}, value = {54, 54} },
		{ pattern = "Sonnenfeuer", effect = {"ARCANEDMG", "FIREDMG"}, value = {50, 50} },
		{ pattern = "Unbändigkeit", effect = "ATTACKPOWER", value = 70 },
		{ pattern = "Sicherer Stand", effect = {"CR_HIT", "SNARERES"}, value = {10, 5} },
		{ pattern = "%+2%% Bedrohung", effect = "THREATREDUCTION", value = -2 },
		{ pattern = "Feingef\195\188hl", effect = "THREATREDUCTION", value = 2 },

	}
}
