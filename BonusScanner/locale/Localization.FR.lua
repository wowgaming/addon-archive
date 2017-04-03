local L = LibStub("AceLocale-3.0"):NewLocale("BonusScanner","frFR")
if not L then return end
-- bonus names
L["BONUSSCANNER_NAMES"] = {
--Base Stats
	STR 			= "Force ",
	AGI 			= "Agilit\195\169 ",
	STA 			= "Endurance ",
	INT 			= "Intelligence ",
	SPI 			= "Esprit ",
	ARMOR 			= "Armure ",

--Resistances
	ARCANERES 		= "R\195\169sistance Arcane ",	
	FIRERES 		= "R\195\169sistance Feu ",
	NATURERES 		= "R\195\169sistance Nature ",
	FROSTRES 		= "R\195\169sistance Givre ",
	SHADOWRES 		= "R\195\169sistance Ombre ",

--Skills
	FISHING 		= "P\195\170che ",
	MINING 			= "Minage ",
	HERBALISM 		= "Herborisme ",
	SKINNING 		= "D\195\169pe\195\167age ",
	DEFENSE 		= "Score de d\195\169fense ",
	EXPERTISE 		= "Score d'expertise ",

--Abilities
	BLOCK			= "Blocage ",
	BLOCKVALUE		= "Valeur de Blocage ",
	DODGE 			= "Esquive ",
	PARRY 			= "Score de parade ",
	RESILIENCE 		= "Score de r\195\169silience ", 
	DMGWPN 			= "Augmentation de d\195\169\g\195\162ts en m\195\170l\195\169e ", -- Might of Cenarius etc.
	RANGEDDMG 		= "D\195\169\g\195\162ts de l'arme \195\160 distance ",
	ARMORPEN 		= "P\195\169n\195\169tration d'armure ",
	
-- DPS
	DPSMAIN = "Main Weapon(s) DPS",
	DPSRANGED = "Ranged Weapon DPS",
	DPSTHROWN = "Thrown Weapon DPS",

--Attack Power
	ATTACKPOWER		= "Puissance d'attaque ",
	ATTACKPOWERUNDEAD	= "Puissance d'attaque contre les morts-vivants ",
	ATTACKPOWERFERAL	= "Puissance d'attaque en forme animale ",
	RANGEDATTACKPOWER	= "Puissance d'attaque \195\160 distance ",
	
--Critical
	CRIT 			= "Score de coup critique ",
	RANGEDCRIT 		= "Score de tirs critiques ",
	--HOLYCRIT 		= "Score de coup critique des sorts du Sacr\195\169 ",

--Hit
	TOHIT 			= "Score de toucher ",
	RANGEDHIT		= "Score de toucher \195\160 distance ",

--Haste
	HASTE 			= "Score de h\195\162te ",

--Spell Damage/healing
	DMGUNDEAD		= "D\195\169\g\195\162ts des Sorts contre les morts-vivants ",
	ARCANEDMG 		= "D\195\169\g\195\162ts d'Arcane ",
	FIREDMG 		= "D\195\169\g\195\162ts de Feu ",
	FROSTDMG 		= "D\195\169\g\195\162ts de Givre ",
	HOLYDMG 		= "D\195\169\g\195\162ts du Sacr\195\169 ",
	NATUREDMG 		= "D\195\169\g\195\162ts de Nature ",
	SHADOWDMG 		= "D\195\169\g\195\162ts d'Ombre ",
	SPELLPEN 		= "P\195\169n\195\169tration des sorts ",
	SPELLPOW 		= "Puissance des sorts",

--Regen
	HEALTHREG 		= "R\195\169g\195\169n\195\169ration de vie ",
	MANAREG 		= "R\195\169g\195\169n\195\169ration de mana ",

--Health/mana
	HEALTH = "Points de vie ",
	MANA = "Points de mana ",
	
--Extra bonuses
	THREATREDUCTION = "% de r\195\169duction de menace ",
	THREATINCREASE = "% d'augmentation de menace ",
	INCRCRITDMG = "% d'augmentation des dommages critiques ",
	SPELLREFLECT = "% de r\195\169flexion des sorts ",
	STUNRESIST = "% de r\195\169sistance aux effets d'\195\169tourdissement ",
	PERCINT = "% d'intelligence ",
	PERCBLOCKVALUE = "% de valeur de blocage ",

	-- WOTLK Metagems--
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
--L["BONUSSCANNER_PREFIX_EQUIP"] 	= "\195\137quip\195\169 : "; --no longer used but kept in case Blizzard decides to alter its own global string referring to this
L["BONUSSCANNER_PREFIX_SET"] 	= "Complet : "; -- Attention le blanc après complet cache un caractère de controle
L["BONUSSCANNER_PREFIX_SOCKET"] 	= "Bonus de sertissage : ";
L["BONUSSCANNER_WEAPON_SPEED"] 	= "Vitesse";
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
L["BONUSSCANNER_GLOBAL_SEP"] 	= " +";
L["BONUSSCANNER_SEPARATORS"] 	= { "/", ", ", " & ", " et " };

-- passive bonus patterns. checked against lines which start with above prefixes
L["BONUSSCANNER_PATTERNS_PASSIVE"] = {
--Skills
	{ pattern = "Augmente le score de d\195\169fense de (%d+)%.", effect = "DEFENSE" },
	{ pattern = "Augmente de (%d+) le score de r\195\169silience%.", effect = "RESILIENCE" }, -- old way : "Augmente le score de r\195\169silience de (%d+)%."
	{ pattern = "Augmente le score d'expertise de (%d+)%.", effect = "EXPERTISE" },
	{ pattern = "P\195\170che augment\195\169e de (%d+)%.", effect = "FISHING" }, -- fishing poles

-- Abilities
	{ pattern = "Augmente votre score de blocage de (%d+)%.", effect = "BLOCK" }, -- Gardien resplendissant
	{ pattern = "Augmente de (%d+) le score de blocage%.", effect = "BLOCK" },
	{ pattern = "Augmente la valeur de blocage de votre bouclier de (%d+)%.", effect = "BLOCKVALUE" },
	{ pattern = "Augmente le score d'esquive de (%d+)%.", effect = "DODGE" }, -- Cape de maître des loups (Armurerie)
	{ pattern = "Augmente de (%d+) le score d'esquive%.", effect = "DODGE" }, -- Cape de maître des loups
	{ pattern = "Augmente de (%d+) le score de parade%.", effect = "PARRY" },
	{ pattern = "%+(%d+) aux d\195\169g\195\162ts des armes%.", effect = "DMGWPN" }, -- Might of Cenarius...
	{ pattern = "%+(%d+) aux d\195\169g\195\162ts de l'arme%.", effect = "DMGWPN" }, -- Might of Cenarius...

--Crit
	{ pattern = "Augmente le score de coup critique de (%d+)%.", effect = "CRIT" }, -- Bague de jade lourde (Armurerie)
	{ pattern = "Augmente de (%d+) le score de coup critique%.", effect = "CRIT" }, -- Bague de jade lourde
	{ pattern = "Augmente de (%d+) le score de coup critique en m\195\170l\195\169e%.", effect = "CRIT" },
	{ pattern = "Increases your ranged critical strike rating by (%d+)%.", effect = "RANGEDCRIT" },
	
--Damage/Heal
	{ pattern = "Augmente les d\195\169g\195\162ts et les soins produits par les sorts et effets magiques de (%d+) au maximum%.", effect = "SPELLPOW" },
	{ pattern = "Increases your spell power by (%d+)%.", effect = "SPELLPOW" },
	{ pattern = "Augmente les d\195\169g\195\162ts inflig\195\169s par les sorts et effets d'Ombre de (%d+) au maximum%.", effect = "SHADOWDMG" },
	{ pattern = "Augmente les d\195\169g\195\162ts inflig\195\169s par les sorts et effets des Arcanes de (%d+) au maximum%.", effect = "ARCANEDMG" },
	{ pattern = "Augmente les d\195\169g\195\162ts inflig\195\169s par les sorts et effets de Feu de (%d+) au maximum%.", effect = "FIREDMG" },
	{ pattern = "Augmente les d\195\169g\195\162ts inflig\195\169s par les sorts et effets de Givre de (%d+) au maximum%.", effect = "FROSTDMG" },
	{ pattern = "Augmente les d\195\169g\195\162ts inflig\195\169s par les sorts et effets du Sacr\195\169 de (%d+) au maximum%.", effect = "HOLYDMG" },
	{ pattern = "Augmente les d\195\169g\195\162ts inflig\195\169s par les sorts et effets de Nature de (%d+) au maximum%.", effect = "NATUREDMG" },
	-- { pattern = "Increases damage and healing done by magical spells and effects slightly%.", effect = {"HEAL", "DMG"}, value = {6, 6} },
	{ pattern = "Increases damage done to Undead by magical spells and effects by up to (%d+)", effect = "DMGUNDEAD" },
	
-- Multibonus Equip patterns
	{ pattern = "Increases spell power of all party members within %d+ yards by up to (%d+)%.", effect = "SPELLPOW" },
	--{ pattern = "Augmente les soins prodigu\195\169s d'un maximum de (%d+) et les d\195\169\g\195\162ts d'un maximum de (%d+) pour tous les sorts et effets magiques%.", effect = {"HEAL","DMG"} },
	--{ pattern = "Increases your pet's resistances by 130 and increases your spell damage by up to (%d+)%.", effect = "DMG" }, -- Void Star Talisman
	--{ pattern = "Increases your spell damage by up to (%d+) and your healing by up to (%d+)%.", effect = {"DMG","HEAL"} },
	--{ pattern = "Increases healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%. ", effect = "HEAL" },
	--{ pattern = "Increases damage and healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%.", effect = {"HEAL", "DMG"} },
	{ pattern = "Restores (%d+) mana per 5 seconds to all party members within %d+ yards%.", effect = "MANAREG" },
	--{ pattern = "Increases the spell critical strike rating of all party members within %d+ yards by (%d+)%.", effect = "SPELLCRIT" },
	{ pattern = "Increases defense rating by (%d+), Shadow resistance by (%d+) and your normal health regeneration by (%d+)%.", effect = {"DEFENSE", "SHADOWRES", "HEALTHREG"} },

--Attack power
	{ pattern = "Augmente de (%d+) la puissance d'attaque%.", effect = "ATTACKPOWER" },
	{ pattern = "Augmente de (%d+) la puissance d'attaque en m\195\170l\195\169e et \195\160 distance%.", effect = {"ATTACKPOWER","RANGEDATTACKPOWER"} }, -- Andonisus, Reaper of Souls pattern
	{ pattern = "+(%d+) ranged Attack Power%.", effect = "RANGEDATTACKPOWER" },
	{ pattern = "Increases ranged attack power by (%d+)%.", effect = "RANGEDATTACKPOWER" },
	{ pattern = "Augmente de (%d+) la puissance d'attaque pour les formes de f\195\169lin, d'ours, d'ours redoutable et de s\195\169l\195\169nien uniquement%.", effect = "ATTACKPOWERFERAL" },
	{ pattern = "Augmente de (%d+) la puissance d'attaque lorsque vous combattez les morts-vivants%.", effect = "ATTACKPOWERUNDEAD" },
	{ pattern = "+(%d+) Attack Power when fighting Undead%.", effect = "ATTACKPOWERUNDEAD" },

--Regen
	{ pattern = "Restores (%d+) health per 5 sec%.", effect = "HEALTHREG" },
	{ pattern = "Rend (%d+) points de vie toutes les 5 sec%.", effect = "HEALTHREG" }, -- both versions ('per' and 'every') seem to be used
	{ pattern = "Restores (%d+) mana per 5 sec%.", effect = "MANAREG" },
	{ pattern = "Rend (%d+) points de mana toutes les 5 sec%.", effect = "MANAREG" },

--Hit
	{ pattern = "Augmente le score de toucher de (%d+)%.", effect = "TOHIT" },
	{ pattern = "Augmente votre score de toucher de (%d+)%.", effect = "TOHIT" }, -- Rune de capitaine de la garde

--Haste
	{ pattern = "Augmente le score de h\195\162te de (%d+)%.", effect = "HASTE" },

--Penetration
	{ pattern = "Decreases the magical resistances of your spell targets by (%d+).", effect = "SPELLPEN" },
	{ pattern = "Augmente la p\195\169n\195\169tration de vos sorts de (%d+)%.", effect = "SPELLPEN" },
	{ pattern = "Vos attaques ignorent (%d+) points de l'armure de votre adversaire%.", effect = "ARMORPEN" }
	
};

-- generic patterns have the form "+xx bonus" or "bonus +xx" or even "xx bonus" with an optional % sign after the value.

-- first the generic bonus string is looked up in the following table
L["BONUSSCANNER_PATTERNS_GENERIC_LOOKUP"] = {
	["\195\160 toutes les caract\195\169ristiques"] = {"STR", "AGI", "STA", "INT", "SPI"}, -- enchantement
	["Force"] = "STR",
	["Agilit\195\169"] = "AGI",
	["Endurance"] = "STA",
	["Intelligence"] = "INT",
	["Esprit"] = "SPI",

	["\195\160 toutes les r\195\169sistances"] = { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}, -- obsidian items
	--["Resist All"] = { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}, -- prismatic gems (same localization in french as obsidian items)

	["P\195\170che"] = "FISHING",
	["App\195\162t"] = "FISHING",
	["P\195\170che augment\195\169e"] = "FISHING",
	["Minage"] = "MINING",
	["Herborisme"] = "HERBALISM",
	["D\195\169pe\195\167age"] = "SKINNING",
	["D\195\169fense"] = "DEFENSE",
	["D\195\169fense augment\195\169e"] = "DEFENSE",

	["la puissance d'attaque"] = "ATTACKPOWER",
	["la puissance d'attaque lorsque vous combattez les morts-vivants"] = "ATTACKPOWERUNDEAD",
	["la puissance d'attaque pour les formes de f\195\169lin, d'ours, d'ours redoutable et de s\195\169l\195\169nien uniquement"] = "ATTACKPOWERFERAL",
	["aux d\195\169\g\195\162ts des armes"] = "DMGWPN",
	["aux d\195\169\g\195\162ts de l'arme"] = "DMGWPN", -- bonus enchantement arme 1M

	-- TBC Patterns Generic/Gems/Sockets

	["\195\160 la puissance des sorts"] = "SPELLPOW",
	["au score de coup critique"] = "CRIT",
	["au score de critique"] = "CRIT",
	["Crit Rating"] = "CRIT",
	["\195\160 la p\195\169n\195\169tration des sorts"] = "SPELLPEN",
	["au score de d\195\169fense"] = "DEFENSE",
	["au score de h\195\162te"] = "HASTE",
	["point de mana toutes les 5 sec"] = "MANAREG",
	["points de mana toutes les 5 sec"] = "MANAREG",
	["point de mana toutes les 5 secondes"] = "MANAREG",
	["points de mana toutes les 5 secondes"] = "MANAREG",
	["Mana restored per 5 seconds"] = "MANAREG",
	["au score d'esquive"] = "DODGE",
	["au score de parade"] = "PARRY",
	["au score de r\195\169silience"] = "RESILIENCE",
	["d\195\169\g\195\162ts subis en m\195\169l\195\169e"] = "DMGWPN",
	["au score d'expertise"] = "EXPERTISE",

	-- End TBC Patterns
 
	["Esquive"] = "DODGE",
	["Block"] = "BLOCKVALUE",
	["Block Value"] = "BLOCKVALUE",
	["Block Rating"] = "BLOCK",
	["Bloquer"] = "BLOCK",
	["Toucher"] = "TOHIT",
	["au score de toucher"] = "TOHIT",
	["au score de toucher \195\160 distance"] = "RANGEDHIT",
	["Puissance d'attaque \195\160 distance"] = "RANGEDATTACKPOWER",
	["puissance d'attaque \195\160 distance"] = "RANGEDATTACKPOWER", -- Experimental for TBC
	["Health per 5 sec"] = "HEALTHREG",
	["health every 5 sec"] = "HEALTHREG",
	["aux soins"] = "HEAL",
	["aux sorts de soins"] = "HEAL",
	["Increased Healing"] = "HEAL",
	["mana every 5 sec"] = "MANAREG",
	["\195\160 la r\195\169g\195\169n. de mana"] = "MANAREG",
	["Critical"] = "CRIT",
	["Critical Hit"] = "CRIT",
	["Health"] = "HEALTH",
	["HP"] = "HEALTH",
	["points de mana"] = "MANA",
	["Armure"] = "ARMOR",
	["Renforc\195\169"] = "ARMOR",
	["R\195\169silience"] = "RESILIENCE",

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
	["Increased Critical Healing Effect"] = "PERCCRITHEALING",
};

-- next we try to match against one pattern of stage 1 and one pattern of stage 2 and concatenate the effect strings
L["BONUSSCANNER_PATTERNS_GENERIC_STAGE1"] = {
	{ pattern = "Arcane", 	effect = "ARCANE" },	
	{ pattern = "Feu", 	effect = "FIRE" },	
	{ pattern = "Givre", 	effect = "FROST" },	
	{ pattern = "Sacr\195\169", 	effect = "HOLY" },	
	{ pattern = "Ombre",	effect = "SHADOW" },	
	{ pattern = "Nature", 	effect = "NATURE" }
}; 	

L["BONUSSCANNER_PATTERNS_GENERIC_STAGE2"] = {
	{ pattern = "\195\160 la r\195\169sistance", 	effect = "RES" },	
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

-- rest of custom patterns
	{ pattern = "Augmente de (%d+) la puissance d'attaque pour les formes de f\195\169lin, d'ours, d'ours redoutable et de s\195\169l\195\169nien uniquement%.", effect = "ATTACKPOWERFERAL" },
	{ pattern = "Mana Regen (%d+) per 5 sec", effect = "MANAREG" },
	{ pattern = "Renforc\195\169 %(%+(%d+) Armure%)", effect = "ARMOR" }, -- bonus des Renforts d'armure
	{ pattern = "%+(%d+)%% Threat", effect = "THREATINCREASE" },
	{ pattern = "Scope %(%+(%d+) Critical Strike Rating%)", effect = "CRIT" },
	{ pattern = "Scope %(%+(%d+) Damage%)", effect = "RANGEDDMG" },
};

-- localized strings
L["BONUSSCANNER_BONUSSUM_LABEL"] 		= "Liste des bonus";
L["BONUSSCANNER_TOOLTIP_STRING"] 		= "BonusScanner Tooltip Bonus Summary ";
L["BONUSSCANNER_TOOLTIPGEMS_STRING"] 	= "Compteur de gemmes ";
L["BONUSSCANNER_BASICLINKID_STRING"] 	= "Basic Itemlink ID's ";
L["BONUSSCANNER_EXTENDEDLINKID_STRING"] 	= "Extended Itemlink ID's ";
L["BONUSSCANNER_TOOLTIP_ENABLED"] 		= "Activ\195\169";
L["BONUSSCANNER_TOOLTIP_DISABLED"] 		= "D\195\169sactiv\195\169";
L["BONUSSCANNER_IBONUS_LABEL"] 		= "Bonus de l'objet ";
L["BONUSSCANNER_NOBONUS_LABEL"] 		= "Aucun bonus d\195\169tect\195\169.";
L["BONUSSCANNER_CUREQ_LABEL"] 		= "Bonus de l'\195\169quipement en cours";
L["BONUSSCANNER_CUREQDET_LABEL"] 		= "D\195\169tail des bonus de l'\195\169quipement en cours";
L["BONUSSCANNER_OOR_LABEL"] 			= " est hors de port\195\169e.";
L["BONUSSCANNER_GEMCOUNT_LABEL"] 		= "Correspond \195\160 ";
L["BONUSSCANNER_INVALIDTAR_LABEL"] 		="Cible invalide \195\160 scanner.";
L["BONUSSCANNER_SELTAR_LABEL"] 		= "Veuillez s\195\169lectionner la cible d'abord.";
L["BONUSSCANNER_SLOT_LABEL"] 		= "emplacement";
L["BONUSSCANNER_FAILEDPARSE_LABEL"] 		= "L'item n'est pas dans le cache ou n'a pas \195\169t\195\169 valid\195\169 sur le serveur.";
L["BONUSSCANNER_CACHESUMMARY_LABEL"] 	= "Objets dans le cache de BonusScanner : ";
L["BONUSSCANNER_CACHECLEAR_LABEL"] 		= "Le cache a \195\169t\195\169 nettoy\195\169.";
L["BONUSSCANNER_SPECIAL1_LABEL"] 		= " chance de crit";
L["BONUSSCANNER_SPECIAL2_LABEL"] 		= " esquiv\195\169/par\195\169";
L["BONUSSCANNER_SPECIAL3_LABEL"] 	= " m\195\170l\195\169e";
L["BONUSSCANNER_SPECIAL4_LABEL"] 	= " sorts";
L["BONUSSCANNER_SPECIAL5_LABEL"] = " ranged/spells";
L["BONUSSCANNER_ITEMID_LABEL"] 		= "ID de l'objet: |cffffffff";
L["BONUSSCANNER_ILVL_LABEL"] 		= "Niveau de l'objet: |cffffffff";
L["BONUSSCANNER_ENCHANTID_LABEL"] 		= "ID de l'enchant: |cffffffff";
L["BONUSSCANNER_GEM1ID_LABEL"] 		= "ID de la gemme 1: |cffffffff";
L["BONUSSCANNER_GEM2ID_LABEL"] 		= "ID de la gemme 2: |cffffffff";
L["BONUSSCANNER_GEM3ID_LABEL"] 		= "ID de la gemme 3: |cffffffff";
L["BONUSSCANNER_GEMRED_LABEL"] 		= "Rouge";
L["BONUSSCANNER_GEMBLUE_LABEL"] 		= "Bleu";
L["BONUSSCANNER_GEMYELLOW_LABEL"] 		= "Jaune";
L["BONUSSCANNER_GEMPRISM_LABEL"] = "Prismatique";
L["BONUSSCANNER_AVERAGE_ILVL_LABEL"] = "Average item Level";
L["BONUSSCANNER_NEEDS_RELOADUI_LABEL"] = "Les changements prendront effet apr\195\168s rechargement de l'UI.";
L["BONUSSCANNER_LDB_PLUGIN_LABEL"] = "Plugin LDB BonusScanner ";
--bonus categories
L["BONUSSCANNER_CAT_ATT"] 			= "Attributs";
L["BONUSSCANNER_CAT_RES"] 			= "R\195\169sistance";
L["BONUSSCANNER_CAT_SKILL"] 			= "Comp\195\169tences";
L["BONUSSCANNER_CAT_BON"] 			= "Combat en m\195\170l\195\169e et \195\160 distance";
L["BONUSSCANNER_CAT_SBON"] 			= "Sortil\195\168ges";
L["BONUSSCANNER_CAT_OBON"] 			= "Vie et mana";
L["BONUSSCANNER_CAT_EBON"] 			= "Bonus Sp\195\169ciaux";
L["BONUSSCANNER_CAT_GEMS"] 			= "Gemmes";
--slash command text
L["BONUSSCANNER_SLASH_STRING1"] 		= GREEN_FONT_COLOR_CODE.."BonusScanner ";
L["BONUSSCANNER_SLASH_STRING1a"] 		= "|cffffffff by Crowley, Archarodim, jmsteele, Tristanian";
L["BONUSSCANNER_SLASH_STRING2"] 		= LIGHTYELLOW_FONT_COLOR_CODE.."Utilisation: |cffffffff/bscan {show | details | tooltip | tooltip gems | itembasic | itemextend | broker | clearcache | target | target <player> | <itemlink> | <itemlink> <player> | <slotname>}";
L["BONUSSCANNER_SLASH_STRING3"] 		= " - "..LIGHTYELLOW_FONT_COLOR_CODE.."show: |cffffffffAffiche les bonus de l'\195\169quipement actuel.";
L["BONUSSCANNER_SLASH_STRING4"] 		= " - "..LIGHTYELLOW_FONT_COLOR_CODE.."details: |cffffffffAffiche les bonus tri\195\169 par emplacement.";
L["BONUSSCANNER_SLASH_STRING5"] 		= " - "..LIGHTYELLOW_FONT_COLOR_CODE.."tooltip: [";
L["BONUSSCANNER_SLASH_STRING5a"] 		= LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffAffiche les bonus dans les tooltips.";
L["BONUSSCANNER_SLASH_STRING14"] 		= " - "..LIGHTYELLOW_FONT_COLOR_CODE.."tooltip gems: [";
L["BONUSSCANNER_SLASH_STRING14a"] 		= LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffAffiche le nombre de gemmes dans les tooltips (les tooltips doivent \195\170tre activ\195\169s).";
L["BONUSSCANNER_SLASH_STRING12"] 		= " - "..LIGHTYELLOW_FONT_COLOR_CODE.."itembasic: [";
L["BONUSSCANNER_SLASH_STRING12a"] 		= LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffAffiche l'ID et le niveau de l'objet dans les tooltips (les tooltips doivent \195\170tre activ\195\169s).";
L["BONUSSCANNER_SLASH_STRING13"] 		= " - "..LIGHTYELLOW_FONT_COLOR_CODE.."itemextend: [";
L["BONUSSCANNER_SLASH_STRING13a"] 		= LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffAffiche l'ID de l'enchantement et l'ID des gemmes dans les tooltips (les tooltips doivent \195\170tre activ\195\169s).";
L["BONUSSCANNER_SLASH_STRING15"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."broker: [";
L["BONUSSCANNER_SLASH_STRING15a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffChange l'\195\169tat du plugin LDB, pour afficher les bonus d' \195\169quipement pour le personnage courant.";
L["BONUSSCANNER_SLASH_STRING11"] 		= " - "..LIGHTYELLOW_FONT_COLOR_CODE.."clearcache: |cffffffffNettoyer le cache et vider la poubelle.";
L["BONUSSCANNER_SLASH_STRING6"] 		= " - "..LIGHTYELLOW_FONT_COLOR_CODE.."target: |cffffffffAffiche les bonus du personnage cibl\195\169 (doit \195\170tre \195\160 port\195\169e).";
L["BONUSSCANNER_SLASH_STRING7"] 		= " - "..LIGHTYELLOW_FONT_COLOR_CODE.."target <player>: |cffffffffChuchote les bonus de votre \195\169quipement en cours au joueur s\195\169lectionn\195\169.";
L["BONUSSCANNER_SLASH_STRING8"] 		= " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<itemlink>: |cffffffffAffiche les bonus de l'objet en lien (ins\195\169rez le lien avec Shift-Clic).";
L["BONUSSCANNER_SLASH_STRING9"] 		= " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<itemlink> <player>: |cffffffffChuchote les bonus de l'objet montr\195\169 au joueur indiqu\195\169.";
L["BONUSSCANNER_SLASH_STRING10"]		= " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<slotname>: |cffffffffAffiche les bonus de l'emplacement indiqu\195\169.";
