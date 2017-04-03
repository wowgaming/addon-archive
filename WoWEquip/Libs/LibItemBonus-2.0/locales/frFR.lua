if GetLocale() ~= "frFR" then return end

local lib = LibStub("LibItemBonus-2.0")

if not lib._LOADING then return end

local ALL_RESISTS = {"ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}
local ALL_STATS = {"STR", "AGI", "STA", "INT", "SPI"}

lib.patterns = {
	NAMES = {
		STR = "Force",
		AGI = "Agilité",
		STA = "Endurance",
		INT = "Intelligence",
		SPI = "Esprit",
		ARMOR = "Armure",

		ARCANERES = "Arcane",
		FIRERES = "Feu",
		NATURERES = "Nature",
		FROSTRES = "Givre",
		SHADOWRES = "Ombre",

		FISHING = "Pêche",
		MINING = "Minage",
		HERBALISM = "Herborisme",
		SKINNING = "Dépeçage",
		DEFENSE = "Défense",

		BLOCK = "Chance de Bloquer",
		BLOCKVALUE = "Valeur de blocage",
		DODGE = "Esquive",
		PARRY = "Parade",
		ATTACKPOWER = "Puissance d'attaque",
		ATTACKPOWERUNDEAD = "Puissance d'attaque contre les morts-vivants",
		ATTACKPOWERFERAL = "Puissance d'attaque en forme férale",
		CRIT = "Coups Critiques",
		RANGEDATTACKPOWER = "Puissance d'attaque à distance",
		RANGEDCRIT = "Tirs Critiques",
		TOHIT = "Chances de toucher",

		SPELLCRIT = "Chance de Coups Critiques des sorts",
		HOLYCRIT = "Chance de Coups Critiques des sorts du sacré",
		SPELLTOHIT = "Chance de toucher des sorts",
		SPELLPEN = "Diminue les résistances",

		HEALTHREG = "Régeneration Vie",
		MANAREG = "Régeneration Mana",
		HEALTH = "Points de Vie",
		MANA = "Points de Mana",

		CR_WEAPON = "Score d'arme",
		CR_DEFENSE = "Score de défense",
		CR_DODGE = "Score d'esquive",
		CR_PARRY = "Score de parade",
		CR_BLOCK = "Score de blocage",
		CR_HIT = "Score de toucher",
		CR_CRIT = "Score de coups critiques",
		CR_HASTE = "Score de hâte",
		CR_RESILIENCE = "Résilience",
		CR_EXPERTISE = "Score d'expertise",

	},

	PATTERNS_SKILL_RATING = {
		{ pattern = "Augmente le score d[e'] ?(.*) de (%d+)" },
		{ pattern = "Score d[e'] ?(.*) augmenté de (%d+)" },
		{ pattern = "Augmente votre score d[e'] ?(.*) de (%d+)" },
		{ pattern = "Augmente de (%d+) le score d[e'] ?(.*)", invert = true },
		{ pattern = "%+(%d+) au score d[e'] ?(.*)", invert = true },
	},
	SKILL_NAMES = {
		["toucher"] = "CR_HIT",
		["coup critique"] = "CR_CRIT",
		["coup critique à distance"] = "CR_RANGEDCRIT",
		["défense"] = "CR_DEFENSE",
		["résilience"] = "CR_RESILIENCE",
		["esquive"] = "CR_DODGE",
		["blocage"] = "CR_BLOCK",
		["parade"] = "CR_PARRY",
		["la compétence Mains nues"] = "CR_WEAPON_FIST",
		["la compétence Haches à deux mains"] = "CR_WEAPON_AXE_2H",
		["la compétence Arbalètes"] = "CR_WEAPON_CROSSBOW",
		["la compétence Armes à feu"] = "CR_WEAPON_GUN",
		["la compétence Arcs"] = "CR_WEAPON_BOW",
		["la compétence Bâton"] = "CR_WEAPON_STAFF",
		["la compétence Armes de pugilat"] = "CR_WEAPON_FIST",
		["la compétence Epées"] = "CR_WEAPON_SWORD",
		["la compétence Masses"] = "CR_WEAPON_MACE",
		["la compétence Dagues"] = "CR_WEAPON_DAGGER",
		["la compétence Haches"] = "CR_WEAPON_AXE",
		["la compétence Epées à deux mains"] = "CR_WEAPON_SWORD_2H",
		["la compétence Masses à deux mains"] = "CR_WEAPON_MACE_2H",
		["compétence Combat farouche"] = "CR_WEAPON_FERAL",
		["hâte"] = "CR_HASTE",
		["expertise"] = "CR_EXPERTISE",
		["pénétration d'armure"] = "CR_ARMOR_PENETRATION",
	},

	PATTERNS_PASSIVE = {
		{ pattern = "Augmente la puissance des sorts de (%d+)%.", effect = "SPELLPOWER" },
		{ pattern = "Augmente de (%d+) la puissance d'attaque%.", effect = "ATTACKPOWER" },
		{ pattern = "Augmente de (%d+) la puissance d'attaque lorsque vous combattez [dl]es morts%-vivants%.", effect = "ATTACKPOWERUNDEAD", nofinish = true },
		{ pattern = "Augmente de (%d+) la puissance d'attaque lorsque vous combattez des bêtes%.", effect = "ATTACKPOWERBEAST" },
		{ pattern = "Augmente de (%d+) la puissance d'attaque lorsque vous combattez des démons%.", effect = "ATTACKPOWERDEMON" },
		{ pattern = "Augmente de (%d+) la puissance d'attaque lorsque vous combattez des élémentaires%.", effect = "ATTACKPOWERELEMENTAL" },
		{ pattern = "Augmente de (%d+) la puissance d'attaque lorsque vous combattez des draconiens%.", effect = "ATTACKPOWERDRAGON" },
		{ pattern = "Augmente la puissance des attaques à distance de (%d+)%.", effect = "RANGEDATTACKPOWER" },
		{ pattern = "Augmente la valeur de blocage de votre bouclier de (%d+)%.", effect = "BLOCKVALUE" },
		{ pattern = "Augmente les dégâts infligés par les sorts et effets des Arcanes de (%d+) au maximum%.", effect = "ARCANEDMG" },
		{ pattern = "Augmente les dégâts infligés par les sorts et effets de Feu de (%d+) au maximum%.", effect = "FIREDMG" },
		{ pattern = "Augmente les dégâts infligés par les sorts et effets de Givre de (%d+) au maximum%.", effect = "FROSTDMG" },
		{ pattern = "Augmente les dégâts infligés par les sorts et effets de Nature de (%d+) au maximum%.", effect = "NATUREDMG" },
		{ pattern = "Augmente les dégâts infligés par les sorts et effets d'Ombre de (%d+) au maximum%.", effect = "SHADOWDMG" },
		{ pattern = "Augmente les dégâts infligés par les sorts et effets du Sacré de (%d+) au maximum%.", effect = "HOLYDMG" },
		{ pattern = "Augmente de (%d+) au maximum les dégâts infligés par les sorts et effets du Sacré%.", effect = "HOLYDMG" },
		{ pattern = "(%d+)% aux dégâts des sorts d'ombres%.", effect = "SHADOWDMG" },
		{ pattern = "Augmente les dégâts infligés aux morts%-vivants par les sorts et effets magiques de (%d+) au maximum%.", effect = "DMGUNDEAD" },
		{ pattern = "Augmente les dégâts infligés aux morts%-vivants par les sorts et effets magiques d'un maximum de (%d+)%.", effect = "DMGUNDEAD", nofinish = true },
		{ pattern = "Augmente les dégâts infligés aux démons par les sorts et effets magiques d'un maximum de (%d+)%.", effect = "DMGDEMON" },
		{ pattern = "Augmente les dégâts infligés aux morts%-vivants et aux démons par les sorts et effets magiques d'un maximum de (%d+)%.", effect = {"DMGUNDEAD", "DMGDEMON"}, nofinish = true },
		{ pattern = "Rend (%d+) points de vie toutes les 5 sec%.", effect = "HEALTHREG" },
		{ pattern = "Rend (%d+) points de vie toutes les 4 sec%.", effect = "HEALTHREG" },
		{ pattern = "Rend (%d+) points de mana toutes les 5 secondes%.", effect = "MANAREG" },
		{ pattern = "Rend (%d+) points de mana toutes les 5 sec%.", effect = "MANAREG" },
		{ pattern = "Pêche augmentée de (%d+).", effect = "FISHING" },
		{ pattern = "Augmente de +(%d+) la puissance d'attaque pour les formes de félin, d'ours, d'ours redoutable et de sélénien uniquement%.", effect = "ATTACKPOWERFERAL"},
--~ 		{ pattern = "Augmente de (%d+) au maximum les soins prodigués par les sorts et effets magiques de tous les membres du groupe situés à moins de %d+ mètres%.", effect = "HEAL" },
--~ 		{ pattern = "Augmente de (%d+) au maximum les dégâts et les soins produits par les sorts et effets magiques de tous les membres du groupe situés à moins de %d+ mètres%.", effect = HEAL_AND_DMG },
		{ pattern = "Rend (%d+) points de mana toutes les 5 secondes à tous les membres du groupe situés à moins de %d+ mètres.", effect = "MANAREG" },
		{ pattern = "Augmente de (%d+) le score de critique des sorts de tous les membres du groupe se trouvant à moins de %d+ mètres%.", effect = "CR_SPELLCRIT" },

		-- Added
		{ pattern = "Vous confère (%d+)%% de votre vitesse de récupération du mana normale pendant l'incantation%.", effect = "CASTINGREG"},
		{ pattern = "Augmente vos chances d'infliger un coup critique avec les sorts de Nature de (%d+)%%%.", effect = "NATURECRIT"},
		{ pattern = "Réduit le temps d'incantation de votre sort Rétablissement de 0.(%d+) sec%.", effect = "CASTINGREGROWTH"},
		{ pattern = "Réduit le temps d'incantation de votre sort Lumière sacrée de 0.(%d+) sec%.", effect = "CASTINGHOLYLIGHT"},
		{ pattern = "-0.(%d+) sec. au temps d'incantation de votre sort Soins rapides%.", effect = "CASTINGFLASHHEAL"},
		{ pattern = "-0.(%d+) secondes au temps d'incantation de votre sort Salve de guérison%.", effect = "CASTINGCHAINHEAL"},
		{ pattern = "Réduit le temps de lancement de Toucher Guérisseur de 0.(%d+) secondes%.", effect = "CASTINGHEALINGTOUCH"},
		{ pattern = "Augmente la durée de votre sort Récupération de (%d+) sec%.", effect = "DURATIONREJUV"},
		{ pattern = "Augmente la durée de votre sort Rénovation de (%d+) sec%.", effect = "DURATIONRENEW"},
		{ pattern = "Augmente la régénération des points de vie et de mana de (%d+)%.", effect = "MANAREGNORMAL"},
		{ pattern = "Augmente de (%d+)%% le montant de points de vie rendus par Salve de guérison aux cibles qui suivent la première%.", effect = "IMPCHAINHEAL"},
		{ pattern = "Augmente les soins prodigués par Récupération de (%d+) au maximum%.", effect = "IMPREJUVENATION"},
		{ pattern = "Augmente les soins prodigués par votre Vague de Soins Inférieurs de (%d+)%.", effect = "IMPLESSERHEALINGWAVE"},
		{ pattern = "Augmente les soins prodigués par votre Eclair lumineux de (%d+)%.", effect = "IMPFLASHOFLIGHT"},
		{ pattern = "Après avoir lancé un sort de Vague de soins ou de Vague de soins inférieurs, vous avez 25%% de chances de gagner un nombre de points de mana égal à (%d+)%% du coût de base du sort%.", effect = "REFUNDHEALINGWAVE"},
		{ pattern = "Votre Vague de soins soigne aussi des cibles proches supplémentaires. Chaque nouveau soin perd (%d+)%% d'efficacité, et le sort soigne jusqu'à deux cibles supplémentaires%.", effect = "JUMPHEALINGWAVE"},
		{ pattern = "Réduit de (%d+)%% le coût en mana de vos sorts Toucher guérisseur% Rétablissement% Récupération et Tranquillité%.", effect = "CHEAPERDRUID"},
		{ pattern = "En cas de réussite critique sur un Toucher guérisseur, vous récupérez (%d+)%% du coût en mana du sort%.", effect = "REFUNDHTCRIT"},
		{ pattern = "Reduit le coût en mana de votre sort Rénovation de (%d+)%%%.", effect = "CHEAPERRENEW"},

		{ pattern = "Augmente la pénétration de vos sorts de (%d+)%.", effect = "SPELLPEN" },
		{ pattern = "Augmente de (%d+) la puissance d'attaque%.", effect = "ATTACKPOWER" },
		{ pattern = "Augmente la vitesse des attaques à distance de (%d+)%%%.", effect = "RANGED_SPEED_BONUS" },
		{ pattern = "Réduit vos chances de parer une attaque de (%d+)%%%.", effect = "NEGPARRY" }, -- 7348
		{ pattern = "Augmente la vitesse de nage de (%d+)%%%.", effect = "SWIMSPEED" }, -- 7052
		{ pattern = "Augmente la vitesse de course de (%d+)%%%.", effect = "RUNSPEED" }, -- 13388
		{ pattern = "Augmente de (%d+) votre niveau de Camouflage actuel%.", effect = "STEALTH" },
		{ pattern = "Vitesse de monture augmentée de (%d+)%%%.", effect = "MOUNTSPEED" }, -- 11122
		{ pattern = "Les dégâts des sorts subis sont diminués de (%d+)%.", effect = "DMGTAKEN" }, -- 22191
		{ pattern = "Augmente vos chances de résister aux effets de peur de (%d+)%%%.", effect = "FEARRESIST" }, -- 28428, 28429, 28430
		{ pattern = "Augmente de (%d+)%% vos chances de résister aux effets d'étourdissement et de désorientation%.", effect = {"STUNRESIST", "DISORIENTRESIST"} }, -- 23839
		{ pattern = "Augmente vos chances de résister aux effets d'étourdissement et de peur de (%d+)%%%.", effect = {"STUNRESIST", "FEARRESIST"} }, -- 23839
		{ pattern = "Vos attaques ignorent (%d+) points de l'armure de votre adversaire%.", effect = "IGNOREARMOR" },
		{ pattern = "Réduit les dégâts subis en mêlée de (%d+)%.", effect = "MELEETAKEN" }, -- 31154
		{ pattern = "Lunette %(%+(%d+) au score de coup critique%)", effect = "CR_RANGEDCRIT" },
	},

	SEPARATORS = { "/", ",", "&", " et " },

	GENERIC_PATTERNS = {
		["^%+?(%d+) (.*)$"]	= true,
		["^%+(%d+)%% (.*)$"]	= true,
		["^(.*)%+ ?(%d+)%%?$"]	= false,
		["^(.*): ?(%d+)$"]		= false
	},

	PATTERNS_GENERIC_LOOKUP = {
		["Toutes les caractéristiques"] = ALL_STATS,
		["Force"] = "STR",
		["en Force"] = "STR",
		["Agilité"] = "AGI",
		["en Agilité"] = "AGI",
		["Endurance"] = "STA",
		["en Endurance"] = "STA",
		["Intelligence"] = "INT",
		["en Intelligence"] = "INT",
		["Esprit"] = "SPI",
		["à toutes les résistances"] = ALL_RESISTS,
		["Pêche"] = "FISHING",
		["Minage"] = "MINING",
		["Herborisme"] = "HERBALISM",
		["Herboristerie"] = "HERBALISM",
		["Dépeçage"] = "SKINNING",
		["Défense"] = "DEFENSE",
		["puissance d'Attaque"] = "ATTACKPOWER",
		["à la puissance d'attaque"] = "ATTACKPOWER",
		["Puissance d'attaque contre les morts%-vivants"] = "ATTACKPOWERUNDEAD",
		["Esquive"] = "DODGE",
		["Blocage"] = "BLOCK",
		["Score de blocage"] = "BLOCKVALUE",
		["à la puissance d'attaque à distance"] = "RANGEDATTACKPOWER",
		["Puissance d'Attaque à distance"] = "RANGEDATTACKPOWER",
		["Soins chaque 5 sec."] = "HEALTHREG",
		["Mana chaque 5 sec."] = "MANAREG",
		["points de mana toutes les 5 sec"] = "MANAREG",
		["Armure"] = "BASE_ARMOR",
		["Bloquer"] = "BLOCKVALUE",
		["Coup Critique"] = "CRIT",
		["points de vie"] = "HEALTH",
		["points de mana"] = "MANA",
		["Mana"] = "MANA",
		["à l'Armure"] = "ARMOR_BONUS",
		["à la résilience"] = "RESILIENCE",
		["Armure renforcée"] = "ARMOR_BONUS",
		["aux dégâts des armes"] = "MELEEDMG",
		["à la résistance aux étourdissements"] = "STUNRESIST",
		["à la puissance des sorts"] = "SPELLPOWER",
	},

	PATTERNS_GENERIC_STAGE1 = {
		{ pattern = "Arcane", effect = "ARCANE" },
		{ pattern = "Feu", effect = "FIRE" },
		{ pattern = "Givre", effect = "FROST" },
		{ pattern = "Sacré", effect = "HOLY" },
		{ pattern = "Ombre", effect = "SHADOW" },
		{ pattern = "Nature", effect = "NATURE" },
		{ pattern = "arcanes", effect = "ARCANE" },
		{ pattern = "Arcanes", effect = "ARCANE" },
		{ pattern = "feu", effect = "FIRE" },
		{ pattern = "givre", effect = "FROST" },
		{ pattern = "ombre", effect = "SHADOW" },
		{ pattern = "nature", effect = "NATURE" }
	},

	PATTERNS_GENERIC_STAGE2 = {
		{ pattern = "résistance", effect = "RES" },
	},

	PATTERNS_OTHER = {
		{ pattern = "Renforcé %(%+(%d+) Armure%)", effect = "ARMOR_BONUS" },
		{ pattern = "(%d+) Mana chaque 5 sec%.", effect = "MANAREG" },
		{ pattern = "Récup. mana (%d+)/5 sec%.", effect = "MANAREG" },
--~ 		{ pattern = "Cachet de mojo zandalar", effect = "HEAL", value = 18 },
--~ 		{ pattern = "Cachet de sérénité zandalar", effect = "HEAL", value = 33 },

--~ 		{ pattern = "Huile de sorcier mineure", effect = "HEAL", value = 8 },
--~ 		{ pattern = "Huile de sorcier inférieure", effect = "HEAL", value = 16 },
--~ 		{ pattern = "Huile de sorcier", effect = "HEAL", value = 24 },
--~ 		{ pattern = "Huile de sorcier brillante", effect = {"HEAL", "SPELLCRIT"}, value = {36, 1} },

		{ pattern = "Huile de mana mineure", effect = "MANAREG", value = 4 },
		{ pattern = "Huile de mana inférieure", effect = "MANAREG", value = 8 },
--~ 		{ pattern = "Huile de mana brillante", effect = { "MANAREG", "HEAL"}, value = {12, 25} },
		{ pattern = "Vitalité", effect = {"MANAREG", "HEALTHREG"}, value = {4, 4} },
		{ pattern = "Âme de givre", effect = {"FROSTDMG", "SHADOWDMG"}, value = {54, 54} },
		{ pattern = "Feu solaire", effect = {"ARCANEDMG", "FIREDMG"}, value = {50, 50} },
		{ pattern = "Sauvagerie", effect = "ATTACKPOWER", value = 70 },
		{ pattern = "Pied sûr", effect = {"CR_HIT", "SNARERES"}, value = {10, 5} },
		{ pattern = "Augmente le score de défense de 5, la résistance à l'Ombre de 10 et votre régénération des points de vie normale de 3%.", effect = {"CR_DEFENSE", "SHADOWRES", "HEALTHREG_P"}, value = {5, 10, 3} },
		{ pattern = "%+2%% Menace", effect = "THREATREDUCTION", value = -2 },
		{ pattern = "Subtilité", effect = "THREATREDUCTION", value = 2 },
		{ pattern = "Augmente légèrement votre compétence de Crochetage%.", effect = "LOCKPICK", value = 1 },
		{ pattern = "Augmente modérément votre détection du camouflage%.", effect = "STEALTHDETECT", value = 18 }, -- 10501
		{ pattern = "Permet de respirer sous l'eau%.", effect = "UNDERWATER", value = 1 }, -- 10506
		{ pattern = "Insensible au désarmement%.", effect = "DISARMIMMUNE", value = 1 }, -- 12639
		{ pattern = "Augmente la vitesse de déplacement et de récupération des points de vie%.", effect = {"RUNSPEED", "HEALTHREG"}, value = {8,20} }, -- 13505
		{ pattern = "Augmente légèrement votre détection du camouflage%.", effect = "STEALTHDETECT", value = 10 }, -- 22863, 23280, 31333
		{ pattern = "Légère augmentation de la vitesse de course et de nage%.", effect = {"RUNSPEED", "SWIMSPEED"}, value = {8,8} }, -- 19685
		{ pattern = "Réduit les dégâts dus aux chutes%.", effect = "SLOWFALL", value = 1 }, -- 19982
		{ pattern = "Augmente légèrement votre camouflage%.", effect = "STEALTH", value = 3 }, -- 21758
		{ pattern = "Augmente votre niveau de Camouflage actuel%.", effect = "STEALTH", value = 8 }, -- 22003, 23073
		{ pattern = "La vitesse de course augmente légèrement%.", effect = "RUNSPEED", value = 8 }, -- 20048, 25835, 29512
		{ pattern = "Augmente légèrement la puissance des sorts%.", effect = "SPELLPOWER", value = 6 }, -- 30804

--		{ pattern = "Votre goût prononcé pour la mode impressionne les autres%.", effect = "IMPRESS", value = 1 }, -- 10036
	}
}
