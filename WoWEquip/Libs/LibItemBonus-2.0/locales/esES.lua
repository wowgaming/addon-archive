if GetLocale() ~= "esES" then return end

local lib = LibStub("LibItemBonus-2.0")

if not lib._LOADING then return end

local ALL_RESISTS = {"ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}
local ALL_STATS = {"STR", "AGI", "STA", "INT", "SPI"}
local HEAL_AND_DMG = {"HEAL", "DMG"}

lib.patterns = {
	NAMES = {
		STR = "Fuerza",
		AGI = "Agilidad",
		STA = "Aguante",
		INT = "Inteligencia",
		SPI = "Esp\195\173ritu",
		ARMOR = "Armadura",
		BASE_ARMOR = "Armadura Base",
		ARMOR_BONUS = "Bonus de Armadura",

		ARCANERES = "Resistencia Arcana",
		FIRERES = "Resistencia al Fuego",
		NATURERES = "Resistencia a la Naturaleza",
		FROSTRES = "Resistencia a la Escarcha",
		SHADOWRES = "Resistencia a las Sombras",

		FISHING = "Pesca",
		MINING = "Miner\195\173a",
		HERBALISM = "Bot\195\161nica",
		SKINNING = "Desuello",
		DEFENSE = "Defensa",

		BLOCK = "Probabilidad de bloqueo",
		BLOCKVALUE = "Valor de bloqueo",
		DODGE = "Esquivar",
		PARRY = "Parar",
		ATTACKPOWER = "Poder de Ataque",
		ATTACKPOWERUNDEAD = "Poder de Ataque contra no-muertos",
		ATTACKPOWERBEAST = "Poder de Ataque contra bestias",
		ATTACKPOWERFERAL = "Poder de Ataque en forma feral",
		CRIT = "Golpes Cr\195\173ticos",
		RANGEDATTACKPOWER = "Poder de Ataque a distancia",
		RANGEDCRIT = "Disparos Cr\195\173ticos",
		TOHIT = "Probabilidad de Golpear",
		IGNOREARMOR = "Ignorar Armadura",
		THREATREDUCTION = "Reducci\195\179n de Armadura",

		DMG = "Da\195\177o de Hechizo",
		DMGUNDEAD = "Da\195\177o de Hechizo contra no-muertos",
		ARCANEDMG = "Da\195\177o Arcano",
		FIREDMG = "Da\195\177o de Fuego",
		FROSTDMG = "Da\195\177o de Escarcha",
		HOLYDMG = "Da\195\177o Sagrado",
		NATUREDMG = "Da\195\177o de Naturaleza",
		SHADOWDMG = "Da\195\177o de Sombras",
		SPELLCRIT = "Cr\195\173ticos de Hechizo",
		SPELLTOHIT = "Probabilidad de golpear con hechizos",
		SPELLPEN = "Penetraci\195\179n de Hechizoa",
		HEAL = "Sanaci\195\179n",
		HOLYCRIT = "Cr?tico de Sanaci\195\179n",

		HEALTHREG = "Regeneraci\195\179n de Salud",
		MANAREG = "Regeneraci\195\179n de Man\195\161",
		HEALTH = "Puntos de Salud",
		MANA = "Puntos de Man\195\161",

		CR_WEAPON = "Puntos de arma",
		CR_DEFENSE = "Puntos de defensa",
		CR_DODGE = "Puntos de esquivar",
		CR_PARRY = "Puntos de parar",
		CR_BLOCK = "Puntos de bloquear",
		CR_HIT = "\195\173ndice de golpe",
		CR_CRIT = "Puntos de golpe cr\195\173tico",
		CR_HASTE = "Puntos de celeridad",
		CR_SPELLHIT = "Puntos de golpe con hechizo",
		CR_SPELLCRIT = "Puntos de golpe cr\195\173tico con hechizo",
		CR_SPELLHASTE = "Puntos de celeridad con hechizos",
		CR_RESILIENCE = "Temple",
		CR_WEAPON_AXE = "Habilidad con hachas",
		CR_WEAPON_DAGGER = "Habilidad con dagas",
		CR_WEAPON_MACE = "Habilidad con mazas",
		CR_WEAPON_SWORD = "Habilidad con espadas",
		CR_WEAPON_SWORD_2H = "Habilidad con espadas a dos manos",
		SNARERES = "Resistencia a raices e inmovilizaci\195\179n",
	},

	PATTERNS_SKILL_RATING = {
		{ pattern = "Aumenta tu \195\173ndice de (.*) en (%d+) p" },
		{ pattern = "Aumenta tu \195\173ndice de (.*) en (%d+)" },
		{ pattern = "Mejora tu \195\173ndice de (.*) en (%d+) p" },
		{ pattern = "Aumenta el \195\173ndice de (.*) en (%d+) p" },
		{ pattern = "Aumenta el \195\173ndice de (.*) en (%d+)" },
		{ pattern = "?ndice de (.*) aumentado en (%d+)" },
		{ pattern = "Aumenta en (%d+) el ?ndice de (.*)", invert = true },
	},

	SKILL_NAMES = {
		["golpe"] = "CR_HIT",
		["golpe cr\195\173tico"] = "CR_CRIT",
		["golpe cr\195\173tico a distancia"] = "CR_RANGEDCRIT",
		["defensa"] = "CR_DEFENSE",
		["golpe cr\195\173tico con hechizos"] = "CR_SPELLCRIT",
		["temple"] = "CR_RESILIENCE",
		["golpe con hechizos"] = "CR_SPELLHIT",
		["esquivar"] = "CR_DODGE",
		["bloqueo"] = "CR_BLOCK",
		["parada"] = "CR_PARRY",
		["habilidad con hachas"] = "CR_WEAPON_AXE",
		["habilidad con dagas"] = "CR_WEAPON_DAGGER",
		["habilidad con mazas"] = "CR_WEAPON_MACE",
		["habilidad con espadas"] = "CR_WEAPON_SWORD",
		["habilidad con espadas a dos manos"] = "CR_WEAPON_SWORD_2H",
		["habilidad en combate feral"] = "CR_WEAPON_FERAL",
		["bloqueo con escudo"] = "CR_BLOCK",
		["celeridad"] = "CR_HASTE",
		["celeridad con hechizos"] = "CR_SPELLHASTE",
		["habilidad sin armas"] = "CR_WEAPON_FIST",
		["habilidad con armas de pu\195\177o"] = "CR_WEAPON_FIST",
		["habilidad con ballestas"] = "CR_WEAPON_CROSSBOW",
		["habilidad con armas de fuego"] = "CR_WEAPON_GUN",
		["habilidad con arcos"] = "CR_WEAPON_BOW",
		["habilidad con bastones"] = "CR_WEAPON_STAFF",
		["habilidad con mazas a dos manos"] = "CR_WEAPON_MACE_2H",
		["habilidad con hachas a dos manos"] = "CR_WEAPON_AXE_2H",
		["pericia"] = "CR_EXPERTISE",
	},


	PATTERNS_PASSIVE = {
		{ pattern = "Aumenta el poder de ataque a distancia en (%d+)%.", effect = "RANGEDATTACKPOWER" },
		{ pattern = "Aumenta el valor de bloqueo de tu escudo en (%d+)%.", effect = "BLOCKVALUE" },
		{ pattern = "Aumenta el da\195\177o de tus hechizos arcanos y los efectos hasta en (%d+)%.", effect = "ARCANEDMG" },
		{ pattern = "Aumenta el da\195\177o de tus hechizos de fuego y los efectos hasta en (%d+)%.", effect = "FIREDMG" },
		{ pattern = "Aumenta el da\195\177o de tus hechizos de escarcha y los efectos hasta en (%d+)%.", effect = "FROSTDMG" },
		{ pattern = "Aumenta el da\195\177o de tus hechizos sagrados y los efectos hasta en (%d+)%.", effect = "HOLYDMG" },
		{ pattern = "Aumenta el da\195\177o de tus hechizos de naturaleza y los efectos hasta en (%d+)%.", effect = "NATUREDMG" },
		{ pattern = "Aumenta el da\195\177o de tus hechizos de sombras y los efectos hasta en (%d+)%.", effect = "SHADOWDMG" },
		{ pattern = "Aumenta la sanaci\195\179n con hechizos y los efectos hasta en (%d+)%.", effect = "HEAL" },
		{ pattern = "Aumenta el da\195\177o y la sanaci\195\179n de tus hechizos hasta en (%d+)%.", effect = HEAL_AND_DMG },
		{ pattern = "Aumenta el da\195\177o a no-muertos con hechizos y los efectos hasta en (%d+)%.", effect = "DMGUNDEAD", nofinish = true },
		{ pattern = "Aumenta el da\195\177o a demonios con hechizos y los efectos hasta en (%d+)%.", effect = "DMGDEMON" },
		{ pattern = "Aumenta el da\195\177o a no-muertos y demonios con hechizos y los efectos hasta en (%d+)%.", effect = {"DMGUNDEAD", "DMGDEMON"}, nofinish = true },
		{ pattern = "Aumenta el poder de ataque en (%d+) al pelear contra no-muertos%.", effect = "ATTACKPOWERUNDEAD", nofinish = true },
		{ pattern = "Aumenta el poder de ataque en (%d+) al pelear contra bestias%.", effect = "ATTACKPOWERBEAST" },
		{ pattern = "Aumenta el poder de ataque en (%d+) al pelear contra demonios%.", effect = "ATTACKPOWERDEMON" },
		{ pattern = "Aumenta el poder de ataque en (%d+) al pelear contra elementales%.", effect = "ATTACKPOWERELEMENTAL" }, -- 18310
		{ pattern = "Aumenta el poder de ataque en (%d+) al pelear contra dragonantes%.", effect = "ATTACKPOWERDRAGON" }, -- 19961
		{ pattern = "Aumenta el poder de ataque en (%d+) al pelear contra no-muertos y demonios%.", effect = {"ATTACKPOWERUNDEAD", "ATTACKPOWERDEMON"}, nofinish = true }, -- 23206
		{ pattern = "Restaura (%d+) salud cada 5 seg%.", effect = "HEALTHREG" },
		{ pattern = "Restaura (%d+) salud cada 5 seg%.", effect = "HEALTHREG" }, -- 833, 17743
		{ pattern = "Restaura (%d+) man\195\161 cada 5 seg%.", effect = "MANAREG" },
		{ pattern = "Tus ataques ignoran (%d+) de la armadura de tu oponente.", effect = "IGNOREARMOR" },

		-- Atiesh related patterns
		{ pattern = "Aumenta el da\195\177o con hechizos hasta en (%d+) y la sanaci\195\179n hasta en (%d+)%.", effect = {"DMG", "HEAL"} },
		{ pattern = "Increases healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%.", effect = "HEAL" },
		{ pattern = "Increases damage and healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%.", effect = HEAL_AND_DMG },
		{ pattern = "Restores (%d+) mana per 5 seconds to all party members within %d+ yards%.", effect = "MANAREG" },
		{ pattern = "Increases the spell critical chance of all party members within %d+ yards by (%d+)%%%.", effect = "SPELLCRIT" },

		-- Added for HealPoints
		{ pattern = "Allow (%d+)%% of your Mana regeneration to continue while casting%.", effect = "CASTINGREG"},
		{ pattern = "Reduces the casting time of your Regrowth spell by 0%.(%d+) sec%.", effect = "CASTINGREGROWTH"},
		{ pattern = "Reduces the casting time of your Holy Light spell by 0%.(%d+) sec%.", effect = "CASTINGHOLYLIGHT"},
		{ pattern = "Reduces the casting time of your Healing Touch spell by 0%.(%d+) sec%.", effect = "CASTINGHEALINGTOUCH"},
		{ pattern = "%-0%.(%d+) sec to the casting time of your Flash Heal spell%.", effect = "CASTINGFLASHHEAL"},
		{ pattern = "%-0%.(%d+) seconds on the casting time of your Chain Heal spell%.", effect = "CASTINGCHAINHEAL"},
		{ pattern = "Increases the duration of your Rejuvenation spell by (%d+) sec%.", effect = "DURATIONREJUV"},
		{ pattern = "Increases the duration of your Renew spell by (%d+) sec%.", effect = "DURATIONRENEW"},
		{ pattern = "Increases your normal health and mana regeneration by (%d+)%.", effect = "MANAREGNORMAL"},
		{ pattern = "Increases the amount healed by Chain Heal to targets beyond the first by (%d+)%%%.", effect = "IMPCHAINHEAL"},
		{ pattern = "Increases healing done by Rejuvenation by up to (%d+)%.", effect = "IMPREJUVENATION"},
		{ pattern = "Increases healing done by Lesser Healing Wave by up to (%d+)%.", effect = "IMPLESSERHEALINGWAVE"},
		{ pattern = "Increases healing done by Flash of Light by up to (%d+)%.", effect = "IMPFLASHOFLIGHT"},
		{ pattern = "After casting your Healing Wave or Lesser Healing Wave spell%, gives you a 25%% chance to gain Mana equal to (%d+)%% of the base cost of the spell%.", effect = "REFUNDHEALINGWAVE"},
		{ pattern = "Your Healing Wave will now jump to additional nearby targets%. Each jump reduces the effectiveness of the heal by (%d+)%%%, and the spell will jump to up to two additional targets%.", effect = "JUMPHEALINGWAVE"},
		{ pattern = "Reduces the mana cost of your Healing Touch%, Regrowth%, Rejuvenation and Tranquility spells by (%d+)%%%.", effect = "CHEAPERDRUID"},
		{ pattern = "On Healing Touch critical hits%, you regain (%d+)%% of the mana cost of the spell%.", effect = "REFUNDHTCRIT"},
		{ pattern = "Reduces the mana cost of your Renew spell by (%d+)%%%.", effect = "CHEAPERRENEW"},

		{ pattern = "Increases your spell penetration by (%d+)%.", effect = "SPELLPEN" },
		{ pattern = "Aumenta el poder de ataque en (%d+)% p.", effect = "ATTACKPOWER" },
		{ pattern = "Aumenta en +(%d+) p. el poder de ataque bajo formas felinas, de oso, de oso temible y de lech\195\186cico lunar.%.", effect = "ATTACKPOWERFERAL" },
		{ pattern = "Restores (%d+) health every 4 sec%.", effect = "HEALTHREG" }, -- 6461 (typo ?)
		{ pattern = "Increases your effective stealth level by (%d+)%.", effect = "STEALTH" },
		{ pattern = "Increases ranged attack speed by (%d+)%%%.", effect = "RANGED_SPEED_BONUS" }, -- bags are not scanned
		{ pattern = "Gives (%d+) additional stamina to party members within %d+ yards%.", effect = "STA" }, -- 4248
		{ pattern = "Increases swim speed by (%d+)%%%.", effect = "SWIMSPEED" }, -- 7052
		{ pattern = "Increases mount speed by (%d+)%%%.", effect = "MOUNTSPEED" }, -- 11122
		{ pattern = "Increases run speed by (%d+)%%%.", effect = "RUNSPEED" }, -- 13388
		{ pattern = "Decreases your chance to parry an attack by (%d+)%%%.", effect = "NEGPARRY" }, -- 7348
		{ pattern = "Increases your chance to resist Stun and Fear effects by (%d+)%%%.", effect = {"STUNRESIST", "FEARRESIST"} }, -- 17759
		{ pattern = "Increases your chance to resist Fear effects by (%d+)%%%.", effect = "FEARRESIST" }, -- 28428, 28429, 28430
		{ pattern = "Increases your chance to resist Stun and Disorient effects by (%d+)%%%.", effect = {"STUNRESIST", "DISORIENTRESIST"} }, -- 23839
		{ pattern = "Increases mount speed by (%d+)%%%.", effect = "MOUNTSPEED" }, -- 25653
		{ pattern = "Reduces melee damage taken by (%d+)%.", effect = "MELEETAKEN" }, -- 31154
		{ pattern = "Spell Damage received is reduced by (%d+)%.", effect = "DMGTAKEN" }, -- 22191
		{ pattern = "Scope %(%+(%d+) Critical Strike Rating%)", effect = "CR_RANGEDCRIT" },
	},

	SEPARATORS = { "/", ",", "&", " y " },

	GENERIC_PATTERNS = {
		["^%+?(%d+)%%?(.*)$"]	= true,
		["^(.*)%+ ?(%d+)%%?$"]	= false,
		["^(.*): ?(%d+)$"]		= false
	},

	PATTERNS_GENERIC_LOOKUP = {
		["todas las caracter\195\173sticas"] = ALL_STATS,
		["fuerza"] = "STR",
		["agilidad"] = "AGI",
		["aguante"] = "STA",
		["intelecto"] = "INT",
		["esp\195\173ritu"] = "SPI",

		["todas las resistencias"] = ALL_RESISTS,

		["Pesca"] = "FISHING",
		["Fishing Lure"] = "FISHING",
		["Increased Fishing"] = "FISHING",
		["Miner\195\173a"] = "MINING",
		["Bot\195\161nica"] = "HERBALISM",
		["Desuello"] = "SKINNING",
		["Defensa"] = "CR_DEFENSE",
		["Increased Defense"] = "DEFENSE",

		["Poder de Ataque"] = "ATTACKPOWER",
		["Attack Power when fighting Undead"] = "ATTACKPOWERUNDEAD",

		["Esquivar"] = "DODGE",
		["Bloqueo"] = "BLOCKVALUE",
		["Block Value"] = "BLOCKVALUE",
		["Golpe"] = "TOHIT",
		["Golpe con Hechizo"] = "SPELLTOHIT",
		["Blocking"] = "BLOCK",
		["Ranged Attack Power"] = "RANGEDATTACKPOWER",
		["health every 5 sec"] = "HEALTHREG",
		["Healing Spells"] = "HEAL",
		["Increases Healing"] = "HEAL",
		["Healing"] = "HEAL",
		["healing Spells"] = "HEAL",
		["Healing and Spell Damage"] = HEAL_AND_DMG,
		["Damage and Healing Spells"] = HEAL_AND_DMG,
		["Spell Damage and Healing"] = HEAL_AND_DMG,
		["Spell Power"] = HEAL_AND_DMG,
		["Spell Damage"] = HEAL_AND_DMG,
		["Critical"] = "CRIT",
		["Critical Hit"] = "CRIT",
		["Health"] = "HEALTH",
		["HP"] = "HEALTH",
		["Mana"] = "MANA",
		["Armadura"] = "BASE_ARMOR",
		["Reinforced Armor"] = "ARMOR_BONUS",
		["Resilience"] = "CR_RESILIENCE",
		["Spell Critical strike rating"] = "CR_SPELLCRIT",
		["Spell Penetration"] = "SPELLPEN",
		["\195\173ndice de golpes"] = "CR_HIT",
		["\195\173ndice de defensa"] = "CR_DEFENSE",
		["Resilience Rating"] = "CR_RESILIENCE",
		["\195\173ndice de golpe cr\195\173tico"] = "CR_CRIT",
		["Critical Rating"] = "CR_CRIT",
		["Critical Strike Rating"] = "CR_CRIT",
		["\195\173ndice de esquivar"] = "CR_DODGE",
		["Parry Rating"] = "CR_PARRY",
		["Spell Critical Strike Rating"] = "CR_SPELLCRIT",
		["Spell Critical Rating"] = "CR_SPELLCRIT",
		["Spell Crit Rating"] = "CR_SPELLCRIT",
		["Spell Hit Rating"] = "CR_SPELLHIT",
		["Mana every 5 Sec"] = "MANAREG",
		["Mana per 5 Seconds"] = "MANAREG",
		["Mana every 5 seconds"] = "MANAREG",
		["Mana Per 5 sec"] = "MANAREG",
		["mana per 5 sec"] = "MANAREG",
		["mana every 5 sec"] = "MANAREG",
		["Mana Regen"] = "MANAREG",
		["Melee Damage"] = "MELEEDMG",
		["Weapon Damage"] = "MELEEDMG",
		["Resist All"] = ALL_RESISTS,
		["Reduced Threat"] = "THREATREDUCTION",
		["Two-Handed Axe Skill Rating"] = "CR_WEAPON_AXE_2H",
		["Stun Resistance"] = "STUNRESIST",
	},

	PATTERNS_GENERIC_STAGE1 = {
		{ pattern = "Arcano", 		effect = "ARCANE" },
		{ pattern = "Fuego", 		effect = "FIRE" },
		{ pattern = "Escarcha", 	effect = "FROST" },
		{ pattern = "Sagrado", 		effect = "HOLY" },
		{ pattern = "Sombras",		effect = "SHADOW" },
		{ pattern = "Naturaleza", 	effect = "NATURE" }
	},

	PATTERNS_GENERIC_STAGE2 = {
		{ pattern = "Resistencia", 	effect = "RES" },
		{ pattern = "Da\195\177o", 	effect = "DMG" },
		{ pattern = "Efectos", 		effect = "DMG" },
	},

	PATTERNS_OTHER = {
		{ pattern = "Reinforced %(%+(%d+) Armor%)", effect = "ARMOR_BONUS" },
		{ pattern = "Mana Regen (%d+) per 5 sec%.", effect = "MANAREG" },

		{ pattern = "Minor Wizard Oil", effect = HEAL_AND_DMG, value = 8 },
		{ pattern = "Lesser Wizard Oil", effect = HEAL_AND_DMG, value = 16 },
		{ pattern = "Wizard Oil", effect = HEAL_AND_DMG, value = 24 },
		{ pattern = "Brilliant Wizard Oil", effect = {"DMG", "HEAL", "SPELLCRIT"}, value = {36, 36, 1} },

		{ pattern = "Minor Mana Oil", effect = "MANAREG", value = 4 },
		{ pattern = "Lesser Mana Oil", effect = "MANAREG", value = 8 },
		{ pattern = "Brilliant Mana Oil", effect = { "MANAREG", "HEAL"}, value = {12, 25} },

		{ pattern = "Eternium Line", effect = "FISHING", value = 5 },
		{ pattern = "Vitality", effect = {"MANAREG", "HEALTHREG"}, value = {4, 4} },
		{ pattern = "Soulfrost", effect = {"FROSTDMG", "SHADOWDMG"}, value = {54, 54} },
		{ pattern = "Sunfire", effect = {"ARCANEDMG", "FIREDMG"}, value = {50, 50} },
		{ pattern = "Savagery", effect = "ATTACKPOWER", value = 70 },
		{ pattern = "Surefooted", effect = {"CR_HIT", "SNARERES"}, value = {10, 5} },
		{ pattern = "Increases defense rating by 5, Shadow resistance by 10 and your normal health regeneration by 3%.", effect = {"CR_DEFENSE", "SHADOWRES", "HEALTHREG_P"}, value = {5, 10, 3} },
		{ pattern = "%+2%% Threat", effect = "THREATREDUCTION", value = -2 },
		{ pattern = "Subtlety", effect = "THREATREDUCTION", value = 2 },

		{ pattern = "Allows underwater breathing%.", effect = "UNDERWATER", value = 1 }, -- 10506
		{ pattern = "Increases your lockpicking skill slightly%.", effect = "LOCKPICK", value = 1 },
		{ pattern = "Moderately increases your stealth detection%.", effect = "STEALTHDETECT", value = 18 }, -- 10501
		{ pattern = "Slightly increases your stealth detection%.", effect = "STEALTHDETECT", value = 10 }, -- 22863, 23280, 31333
		{ pattern = "Immune to Disarm%.", effect = "DISARMIMMUNE", value = 1 }, -- 12639
		{ pattern = "Minor increase to running and swimming speed%.", effect = {"RUNSPEED", "SWIMSPEED"}, value = {8,8} }, -- 19685
		{ pattern = "Reduces damage from falling%.", effect = "SLOWFALL", value = 1 }, -- 19982
		{ pattern = "Increases movement speed and life regeneration rate%.", effect = {"RUNSPEED", "HEALTHREG"}, value = {8,20} }, -- 13505
		{ pattern = "Run speed increased slightly%.", effect = "RUNSPEED", value = 8 }, -- 20048, 25835, 29512
		{ pattern = "Increases your stealth slightly%.", effect = "STEALTH", value = 3 }, -- 21758
		{ pattern = "Increases your effective stealth level%.", effect = "STEALTH", value = 8 }, -- 22003, 23073
		{ pattern = "Increases damage and healing done by magical spells and effects slightly%.", effect = HEAL_AND_DMG, value = 6 }, -- 30804

--		{ pattern = "Impress others with your fashion sense%.", effect = "IMPRESS", value = 1 }, -- 10036
--		{ pattern = "Increases your Mojo%.", effect = "MOJO", value = 1 }, -- 23717
	},
}
