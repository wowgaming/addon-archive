local L = LibStub("AceLocale-3.0"):NewLocale("BonusScanner","esES")
if not L then return end
-- bonus names
L["BONUSSCANNER_NAMES"] = {
	--Base Stats
	STR 		= "Fuerza",
	AGI 		= "Agilidad",
	STA 		= "Aguante",
	INT 		= "Intelecto",
	SPI 		= "Espíritu",
	ARMOR 	= "Armadura",

	--Resistances
	ARCANERES = "Resistencia a lo Arcano",	
	FIRERES 	= "Resistencia al Fuego",
	NATURERES = "Resistencia a la Naturaleza",
	FROSTRES 	= "Resistencia a la Escarcha",
	SHADOWRES = "Resistencia a las Sombras",

	--Skills
	FISHING 	= "Pesca",
	MINING 		= "Minería",
	HERBALISM = "Herboristería",
	SKINNING 	= "Desuello",
	DEFENSE 	= "Índice de Defensa",
	EXPERTISE = "Índice de Pericia",
	
	--Abilities
	BLOCK		= "Índice de Bloqueo",
	BLOCKVALUE	= "Valor de Bloqueo",
	DODGE 		= "Índice de Esquivar",
	PARRY 		= "Índice de Parar",
	RESILIENCE = "Índice de Temple", 
	DMGWPN = "Daño cuerpo a cuerpo incrementado", 
	RANGEDDMG = "Daño a distancia incrementado",
	ARMORPEN = "Índice de Penetración de armadura",

	-- DPS
	DPSMAIN = "DPS Arma principal",
	DPSRANGED = "DPS Arma a distancia",
	DPSTHROWN = "DPS Arma arrojadiza",

	--Attack Power
	ATTACKPOWER	= "Poder de ataque",
	ATTACKPOWERUNDEAD	= "Poder de ataque contra No-muertos",
	ATTACKPOWERFERAL	= "Poder de ataque en forma feral",
	RANGEDATTACKPOWER = "Poder de ataque a distancia",
	
	--Critical
	CRIT 		= "Índice de golpe crítico",	
	RANGEDCRIT 	= "Índice de golpe crítico a distancia",

	--Hit
	TOHIT 		= "Índice de Golpe",
	RANGEDHIT	= "Índice de Golpe a distancia",	
  
	--Haste
	HASTE = "Índice de Celeridad",

	--Spell Damage/healing
	DMGUNDEAD	= "Daño de Hechizos contra No-muertos",
	ARCANEDMG 	= "Daño Arcano",
	FIREDMG 	= "Daño de Fuego",
	FROSTDMG 	= "Daño de Escarcha",
	HOLYDMG 	= "Daño Sagrado",
	NATUREDMG 	= "Daño de Naturaleza",
	SHADOWDMG 	= "Daño de Sombras",
	SPELLPEN 	= "Penetración de Hechizos",
  SPELLPOW = "Poder con hechizos", 

	--Regen
	HEALTHREG 	= "Regeneración de Vida",
	MANAREG 	= "Regeneración de Maná",

	--Health/mana
	HEALTH = "Puntos de Vida",
	MANA = "Puntos de Maná",
	
	--Extra bonuses
  THREATREDUCTION = "% Reducción de Amenaza",
  THREATINCREASE = "% Incremento de Amenaza",
  INCRCRITDMG = "% Incremento de Daño Crítico",
  SPELLREFLECT = "% Reflejo de Hechizos",
  STUNRESIST = "% Resistencia a Aturdir",
  PERCINT = "% Intelecto",
  PERCBLOCKVALUE = "% Valor de Bloqueo con Escudo",
 
	-- WOTLK Metagems
  PERCARMOR = "% Incremento de Valor de Armadura",
  PERCMANA ="% Maná",
  PERCREDSPELLDMG = "% Reducción de Daño de Hechizos recibido",
  PERCSNARE = "% Reducción de la duración de Enraizar/Aturdir",
  PERCSILENCE = "% Reducción de la duración de Silenciar",
  PERCFEAR = "% Reducción de la duración de Miedo",
  PERCSTUN = "% Reducción de la duración de Aturdir",
  PERCCRITHEALING = "% Incremento de Curación crítica",  
};

-- equip and set bonus prefixes:
--L["BONUSSCANNER_PREFIX_EQUIP"] = "Equipar: "; --no longer used but kept in case Blizzard decides to alter its own global string referring to this
L["BONUSSCANNER_PREFIX_SET"] = "Conjunto: ";
L["BONUSSCANNER_PREFIX_SOCKET"] = "Bonus ranura: ";
L["BONUSSCANNER_WEAPON_SPEED"] = "Speed";
L["BONUSCANNER_GEM_STRINGS"] = {
	-- red
	["Encaja en una ranura de color rojo."] = { red = 1, yellow = 0, blue = 0, prismatic = 0},
	-- blue
	["Encaja en una ranura de color azul."] = { red = 0, yellow = 0, blue = 1, prismatic = 0},
	-- yellow
	["Encaja en una ranura de color amarillo."] = { red = 0, yellow = 1, blue = 0, prismatic = 0},
	-- purple
	["Encaja en una ranura de color rojo o azul."] = { red = 1, yellow = 0, blue = 1, prismatic = 0},
	["Encaja en una ranura de color azul o rojo."] = { red = 1, yellow = 0, blue = 1, prismatic = 0},
	-- green
	["Encaja en una ranura de color azul o amarillo."] = { red = 0, yellow = 1, blue = 1, prismatic = 0},
	["Encaja en una ranura de color amarillo o azul."] = { red = 0, yellow = 1, blue = 1, prismatic = 0},
	-- orange
	["Encaja en una ranura de color rojo o amarillo."] = { red = 1, yellow = 1, blue = 0, prismatic = 0},
	["Encaja en una ranura de color amarillo o rojo."] = { red = 1, yellow = 1, blue = 0, prismatic = 0},
	-- prismatic
	["Encaja en cualquier ranura."] = { red = 0, yellow = 0, blue = 0, prismatic = 1},
	["Encaja en una ranura de color rojo, amarillo o azul."] = { red = 0, yellow = 0, blue = 0, prismatic = 1}
}

-- Enchant separators
L["BONUSSCANNER_GLOBAL_SEP"] = " +";
L["BONUSSCANNER_SEPARATORS"] = { "/", ", ", " & ", " y " };

-- passive bonus patterns. checked against lines which start with above prefixes
L["BONUSSCANNER_PATTERNS_PASSIVE"] = {
	--Skills
	{ pattern = "+(%d+)% p. de armadura%)", effect = "ARMOR" },
	{ pattern = "+(%d+)% p. de índice de temple", effect = "RESILIENCE" }, 
	{ pattern = "Aumenta tu índice de defensa (%d+)% p.", effect = "DEFENSE" },
	{ pattern = "Aumenta tu índice de pericia (%d+)% p.", effect = "EXPERTISE" }, 
	{ pattern = "Aumenta tu índice de temple (%d+)% p.", effect = "RESILIENCE" }, 
	{ pattern = "Pesca aumentada %+(%d+)% p.", effect = "FISHING" },

	-- Abilities
	{ pattern = "%+(%d+) daño de arma", effect = "DMGWPN" },
	{ pattern = "Aumenta tu índice de bloqueo (%d+)% p.", effect = "BLOCK" },
	{ pattern = "Aumenta tu índice de esquivar (%d+)% p.", effect = "DODGE" }, 
	{ pattern = "Aumenta tu índice de parada (%d+)% p.", effect = "PARRY" }, 
	{ pattern = "Aumenta el valor de bloqueo de tu escudo (%d+)% p.", effect = "BLOCKVALUE" }, 
	{ pattern = "Aumenta tu índice de bloqueo con escudo (%d+)% p.", effect = "BLOCKVALUE" }, 

	--Crit
	{ pattern = "Mejora tu índice de golpe crítico (%d+)% p.", effect = "CRIT" },
	{ pattern = "Mejora tu índice de golpe crítico a distancia (%d+)% p.", effect = "RANGEDCRIT" },
	
	--Damage/Heal/Spell Power
	{ pattern = "Aumenta el poder con hechizos (%d+)% p.", effect = "SPELLPOW" },
	{ pattern = "Increases spell power by (%d+)%.", effect = "SPELLPOW" }, 
	{ pattern = "Increases your spell power by (%d+)%.", effect = "SPELLPOW" }, 
	{ pattern = "Increases shadow spell power by (%d+)%.", effect = "SHADOWDMG" }, 
	{ pattern = "Increases arcane spell power by (%d+)%.", effect = "ARCANEDMG" }, 
	{ pattern = "Increases fire spell power by (%d+)%.", effect = "FIREDMG" }, 
	{ pattern = "Increases frost spell power by (%d+)%.", effect = "FROSTDMG" }, 
	{ pattern = "Increases holy spell power by (%d+)%.", effect = "HOLYDMG" }, 
	{ pattern = "Increases nature spell power by (%d+)%.", effect = "NATUREDMG" },
	{ pattern = "Increases spell power slightly%.", effect = "SPELLPOW", value = 6 },
	{ pattern = "Increases damage done to Undead by magical spells and effects by up to (%d+)", effect = "DMGUNDEAD" },
	
	-- Multibonus Equip patterns
	{ pattern = "(%d+) aguante y reducción de duración de aturdir un (%d+)%", effect = {"STA","PERCSTUN"} },	
	{ pattern = "(%d+) resistencia a las sombras y (%d+) aguante", effect = {"SHADOWRES","STA"} },	
	{ pattern = "Increases spell power of all party members within %d+ yards by up to (%d+)%.", effect = "SPELLPOW" },	
	{ pattern = "Increases your pet's resistances by 130 and increases your spell power by (%d+)%.", effect = "SPELLPOW" }, -- Void Star Talisman
	{ pattern = "Restores (%d+) mana per 5 seconds to all party members within %d+ yards%.", effect = "MANAREG" },
	{ pattern = "Increases the spell critical strike rating of all party members within %d+ yards by (%d+)%.", effect = "CRIT" }, --SPELLCRIT
	{ pattern = "Increases defense rating by (%d+), Shadow resistance by (%d+) and your normal health regeneration by (%d+)%.", effect = {"DEFENSE", "SHADOWRES", "HEALTHREG"} },
	
	--Attack power
	{ pattern = "Aumenta el poder de ataque (%d+) p.", effect = "ATTACKPOWER" },
	{ pattern = "Aumenta tu poder de ataque (%d+) p.", effect = "ATTACKPOWER" },
	{ pattern = "Increases melee and ranged attack power by (%d+)%.", effect = {"ATTACKPOWER","RANGEDATTACKPOWER"} },
	{ pattern = "+(%d+) ranged Attack Power%.", effect = "RANGEDATTACKPOWER" },
	{ pattern = "Increases ranged attack power by (%d+)%.", effect = "RANGEDATTACKPOWER" },
	{ pattern = "Increases attack power by (%d+) in Cat, Bear, Dire Bear, and Moonkin forms only%.", effect = "ATTACKPOWERFERAL" },
	{ pattern = "Increases attack power by (%d+) when fighting Undead%.", effect = "ATTACKPOWERUNDEAD" },
	{ pattern = "+(%d+) Attack Power when fighting Undead%.", effect = "ATTACKPOWERUNDEAD" },
  
	--Regen
	{ pattern = "Restaura (%d+)% p. de maná cada 5 s.", effect = "MANAREG" },
	{ pattern = "Restaura (%d+)% p. de maná cada 9 s.", effect = "MANAREG" },
	{ pattern = "Restaura (%d+)% p. de maná cada 16 s.", effect = "MANAREG" },
	{ pattern = "Restaura (%d+)% p. de salud cada 5 s.", effect = "HEALTHREG" },
	
	--Hit
	{ pattern = "Mejora tu índice de golpe (%d+)% p.", effect = "TOHIT" },
	
	--Haste
	{ pattern = "Mejora tu índice de celeridad (%d+)% p.", effect = "HASTE" },
		
	--Penetration
	{ pattern = "Aumenta tu índice de penetración de armadura (%d+)% p.", effect = "ARMORPEN" },
	{ pattern = "Aumenta el índice de penetración de armadura (%d+)% p.", effect = "ARMORPEN" },
	{ pattern = "Decreases the magical resistances of your spell targets by (%d+).", effect = "SPELLPEN" },
	{ pattern = "Increases your spell penetration by (%d+)%.", effect = "SPELLPEN" },	
};

-- generic patterns have the form "+xx bonus" or "bonus +xx" or even "xx bonus" with an optional % sign after the value.

-- first the generic bonus string is looked up in the following table
L["BONUSSCANNER_PATTERNS_GENERIC_LOOKUP"] = {
	["todas las estadísticas"] 			= {"STR", "AGI", "STA", "INT", "SPI"},
	["agilidad"]			= "AGI",
	["Agilidad"]			= "AGI",
	["aguante"]			= "STA",
	["Aguante"]			= "STA",
	["espíritu"] 			= "SPI",
	["Espíritu"] 			= "SPI",
	["fuerza"]			= "STR",
	["Fuerza"]			= "STR",
	["intelecto"]			= "INT",
	["Intelecto"]			= "INT",

	["todas las resistencias"] 	= { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}, -- obsidian items

	["Defensa"]		= "DEFENSE",
	["defensa"]		= "DEFENSE",
	["Defensa aumentada"]	= "DEFENSE",
	["Desuello"]		= "SKINNING",
	["Herboristería"]		= "HERBALISM",
	["Minería"]		= "MINING",
	["pesca"]		= "FISHING",
	["Pesca"]		= "FISHING",
	["Pesca aumentada"]	= "FISHING",

	["daño de arma"] = "DMGWPN",
	["poder de ataque"] 	= "ATTACKPOWER",
	["Attack Power when fighting Undead"] 		= "ATTACKPOWERUNDEAD",
	["Attack Power in Cat, Bear, Dire Bear, and Moonkin forms only"] = "ATTACKPOWERFERAL",
	
	-- TBC/Wotlk Patterns Generic/Gems/Sockets
	["golpe crítico a distancia"] = "RANGEDCRIT",
	["índice de celeridad"] = "HASTE",
	["índice de defensa"] = "DEFENSE",
	["índice de esquivar"] 		= "DODGE",
	["índice de golpe crítico"] = "CRIT",
	["índice de parada"] 		= "PARRY",
	["índice de penetración de armadura"] = "ARMORPEN",	
	["índice de pericia"] = "EXPERTISE",
	["índice de temple"] = "RESILIENCE",
	["maná cada 5 s."] = "MANAREG",
	["maná por 5 s."] = "MANAREG",
	["penetración del hechizo"] = "SPELLPEN",
	["poder con hechizos"] = "SPELLPOW",
	["Melee Damage"] = "DMGWPN",
	
	-- End TBC Patterns
	["amenaza"]		= "THREATINCREASE",
	["armadura"]		= "ARMOR",
	["HP"]			= "HEALTH",
	["índice de bloqueo"]		= "BLOCK",
	["índice de golpe"] 		= "TOHIT",
	["Reforzado"]	= "ARMOR",
	["salud"]		= "HEALTH",
	["Temple"]			= "RESILIENCE",
	["Dodge"] 		= "DODGE",
	["Block"]		= "BLOCKVALUE",
	["Hit Rating"] = "TOHIT",	
	["Ranged Hit Rating"] = "RANGEDHIT",
	["Ranged Attack Power"]	= "RANGEDATTACKPOWER",
	["Health per 5 sec"]	= "HEALTHREG",
	["Healing"] = "HEAL",
	["Healing Spells"] 	= "HEAL",
	["Increased Healing"] 	= "HEAL",
	["Mana"]		= "MANA",
	["mana every 5 sec"] 	= "MANAREG",
	
	-- Patterns for color coded/special lines
	["de daño crítico aumentado"] = "INCRCRITDMG",
	["reducción de duración de aturdir un"] = "PERCSTUN",
	["valor de bloqueo de escudo"]	=	"PERCBLOCKVALUE",
	["Reduced Threat"] = "THREATREDUCTION",
	["Spell Reflect"] = "SPELLREFLECT",
	["Stun Resistance"] = "STUNRESIST",
	["Stun Resist"] = "STUNRESIST",
	["Increased Armor Value from Items"] = "PERCARMOR",
	["Reduce Spell Damage Taken by"] = "PERCREDSPELLDMG",	
	["Silence Duration Reduced by"] = "PERCSILENCE",
	["Fear Duration Reduced by"] = "PERCFEAR",
	["Root Duration by"] = "PERCSNARE",
	["Increased Critical Healing Effect"] = "PERCCRITHEALING",
};	

-- next we try to match against one pattern of stage 1 and one pattern of stage 2 and concatenate the effect strings
L["BONUSSCANNER_PATTERNS_GENERIC_STAGE1"] = {
	{ pattern = "Arcano", 	effect = "ARCANE" },	
	{ pattern = "Escarcha", 	effect = "FROST" },	
	{ pattern = "Fuego", 	effect = "FIRE" },	
	{ pattern = "Naturaleza", 	effect = "NATURE" },
	{ pattern = "Sagrado", 	effect = "HOLY" },
	{ pattern = "Sombras",	effect = "SHADOW" }
}; 	

L["BONUSSCANNER_PATTERNS_GENERIC_STAGE2"] = {
	{ pattern = "resistencia", 	effect = "RES" },	
	{ pattern = "daño", 	effect = "DMG" },
	{ pattern = "Effects", 	effect = "DMG" }
}; 	

-- finally if we got no match, we match against some special enchantment patterns.
L["BONUSSCANNER_PATTERNS_OTHER"] = {
	-- Infused Amethyst
	{ pattern = "Spell Power %+(%d+) and Stamina %+(%d+)", effect = {"SPELLPOW", "STA"} },
	
	-- special patterns that cannot be handled any other way	
	{ pattern = "%+14 poder con hechizos y %+2%% intelecto", effect = {"SPELLPOW", "PERCINT"}, value = {14, 2} },
	{ pattern = "%+25 poder con hechizos y %+2%% intelecto", effect = {"SPELLPOW", "PERCINT"}, value = {25, 2} },
	{ pattern = "%+21 Critical Strike Rating and %+2%% Mana", effect = {"CRIT", "PERCMANA"}, value = {21, 2} },
	{ pattern = "%+12 Critical Strike Rating and Reduces Snare/Root Duration by 15%%", effect = {"CRIT", "PERCSNARE"}, value = {12, 15} },
	{ pattern = "%+21 Critical Strike Rating and Reduces Snare/Root Duration by 15%%", effect = {"CRIT", "PERCSNARE"}, value = {21, 15} },
	{ pattern = "%+18 Stamina and  Stun Duration Reduced by 15%% Stun Resist", effect = {"STA", "PERCSTUN"}, value = {18, 15} },
	{ pattern = "%+18 Spell Power and %+4 Mana/5 seconds", effect = {"SPELLPOW", "MANAREG"}, value = {18, 4} },
	{ pattern = "%+24 Spell Power and %+6 Mana/5 seconds", effect = {"SPELLPOW", "MANAREG"}, value = {24, 6} },
	{ pattern = "%+61 Spell Power and %+6 Mana/5 seconds", effect = {"SPELLPOW", "MANAREG"}, value = {61, 6} },
	{ pattern = "%+(%d+)%% amenaza y (%d+) índice de parada", effect = {"THREATINCREASE","PARRY"} },

	-- rest of custom patterns
	{ pattern = "%+(%d+) aguante y aumenta (%d+)%% de valor de armadura de objetos", effect = {"STA", "PERCARMOR"} },
	{ pattern = "%+(%d+) índice de defensa %+(%d+)%% valor de bloqueo de escudo", effect = {"DEFENSE", "PERCBLOCKVALUE"} },
	{ pattern = "Sigilo y agilidad aumentados en (%d+) p.", effect = "AGI" },
	{ pattern = "Afilado (%+(%d+) daño)", effect = "DMGWPN" },
	{ pattern = "Reforzado %(%+(%d+) armadura%)", effect = "ARMOR" },
	{ pattern = "Increases attack power by (%d+) in Cat, Bear, Dire Bear, and Moonkin forms only%.", effect = "ATTACKPOWERFERAL" },
	{ pattern = "Mana Regen (%d+) per 5 sec", effect = "MANAREG" },
	{ pattern = "%+(%d+)%% Threat", effect = "THREATINCREASE" },
	{ pattern = "Scope %(%+(%d+) Critical Strike Rating%)", effect = "CRIT" },
	{ pattern = "Scope %(%+(%d+) Damage%)", effect = "RANGEDDMG" },
};

-- localized strings
L["BONUSSCANNER_BONUSSUM_LABEL"] = "Resumen de mejoras de objetos";
L["BONUSSCANNER_TOOLTIP_STRING"] = "Tooltip resumen de mejoras de BonusScanner";
L["BONUSSCANNER_TOOLTIPGEMS_STRING"] = "Número de gemas ";
L["BONUSSCANNER_BASICLINKID_STRING"] = "IDs Itemlink básicos ";
L["BONUSSCANNER_EXTENDEDLINKID_STRING"] = "IDs Itemlink extendidos ";
L["BONUSSCANNER_TOOLTIP_ENABLED"] = "Activado";
L["BONUSSCANNER_TOOLTIP_DISABLED"] = "Desactivado";
L["BONUSSCANNER_IBONUS_LABEL"] = "Mejoras de objetos ";
L["BONUSSCANNER_NOBONUS_LABEL"] = "No se han detectado Mejoras.";
L["BONUSSCANNER_CUREQ_LABEL"] = "Mejoras del equipo actual";
L["BONUSSCANNER_CUREQDET_LABEL"] = "Detalles de mejoras del equipo actual";
L["BONUSSCANNER_OOR_LABEL"] = " está fuera de alcance.";
L["BONUSSCANNER_GEMCOUNT_LABEL"] = "De color ";
L["BONUSSCANNER_INVALIDTAR_LABEL"] = "Objetivo para escanear no válido.";
L["BONUSSCANNER_SELTAR_LABEL"] = "Por favor elije un objetivo primero.";
L["BONUSSCANNER_SLOT_LABEL"] = "hueco";
L["BONUSSCANNER_FAILEDPARSE_LABEL"] = "El objeto no está en la caché o no ha sido validado en el servidor.";
L["BONUSSCANNER_CACHESUMMARY_LABEL"] = "Objetos cacheados por BonusScanner: ";
L["BONUSSCANNER_CACHECLEAR_LABEL"] = "La caché de BonusScanner ha sido limpiada.";
L["BONUSSCANNER_SPECIAL1_LABEL"] = " posibilidad de crítico";
L["BONUSSCANNER_SPECIAL2_LABEL"] = " esquivado/parado";
L["BONUSSCANNER_SPECIAL3_LABEL"] = " cuerpo a cuerpo";
L["BONUSSCANNER_SPECIAL4_LABEL"] = " hechizos";
L["BONUSSCANNER_SPECIAL5_LABEL"] = " ranged/spells";
L["BONUSSCANNER_ITEMID_LABEL"] = "ID de objeto: |cffffffff";
L["BONUSSCANNER_ILVL_LABEL"] = "Nivel de objeto: |cffffffff";
L["BONUSSCANNER_ENCHANTID_LABEL"] = "ID de encantamiento: |cffffffff";
L["BONUSSCANNER_GEM1ID_LABEL"] = "ID de gema 1: |cffffffff";
L["BONUSSCANNER_GEM2ID_LABEL"] = "ID de gema 2: |cffffffff";
L["BONUSSCANNER_GEM3ID_LABEL"] = "ID de gema 3: |cffffffff";
L["BONUSSCANNER_GEMRED_LABEL"] = "Rojo";
L["BONUSSCANNER_GEMBLUE_LABEL"] = "Azul";
L["BONUSSCANNER_GEMYELLOW_LABEL"] = "Amarillo";
L["BONUSSCANNER_GEMPRISM_LABEL"] = "Prismático";
L["BONUSSCANNER_AVERAGE_ILVL_LABEL"] = "Nivel medio de objetos";
L["BONUSSCANNER_NEEDS_RELOADUI_LABEL"] = "Los cambios tendrán efecto cuando el interface se vuelva a cargar.";
L["BONUSSCANNER_LDB_PLUGIN_LABEL"] = "BonusScanner LDB Plugin ";
--bonus categories
L["BONUSSCANNER_CAT_ATT"] = "Atributos";
L["BONUSSCANNER_CAT_RES"] = "Resistencias";
L["BONUSSCANNER_CAT_SKILL"] = "Habilidades";
L["BONUSSCANNER_CAT_BON"] = "Combate cuerpo a cuerpo y a distancia";
L["BONUSSCANNER_CAT_SBON"] = "Hechizos";
L["BONUSSCANNER_CAT_OBON"] = "Vida y Maná";
L["BONUSSCANNER_CAT_EBON"] = "Bonificaciones especiales";
L["BONUSSCANNER_CAT_GEMS"] = "Gemas en ranuras";
--slash command text
L["BONUSSCANNER_SLASH_STRING1"] = GREEN_FONT_COLOR_CODE.."BonusScanner ";
L["BONUSSCANNER_SLASH_STRING1a"] = "|cffffffff por Crowley, Archarodim, jmsteele, Tristanian";
L["BONUSSCANNER_SLASH_STRING2"] = LIGHTYELLOW_FONT_COLOR_CODE.."Uso: |cffffffff/bscan {show | details | tooltip | tooltip gems | itembasic | itemextend | broker | clearcache | target | target <player> | <itemlink> | <itemlink> <player> | <slotname>}";
L["BONUSSCANNER_SLASH_STRING3"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."show: |cffffffffMuestra todas las mejoras del equipo actual.";
L["BONUSSCANNER_SLASH_STRING4"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."details: |cffffffffMuestra mejoras en detalle.";
L["BONUSSCANNER_SLASH_STRING5"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."tooltip: [";
L["BONUSSCANNER_SLASH_STRING5a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffAñade el resumen de mejoras al tooltip de un objeto.";
L["BONUSSCANNER_SLASH_STRING14"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."tooltip gems: [";
L["BONUSSCANNER_SLASH_STRING14a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffAñade el recuento de gemas de color a los tooltips (requiere activar los tooltips).";
L["BONUSSCANNER_SLASH_STRING12"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."itembasic: [";
L["BONUSSCANNER_SLASH_STRING12a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffAñade nivel y propiedades de un objeto a los tooltips (requiere activar los tooltips).";
L["BONUSSCANNER_SLASH_STRING13"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."itemextend: [";
L["BONUSSCANNER_SLASH_STRING13a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffAñade información sobre gemas y encantamientos a los tooltips (requiere activar los tooltips).";
L["BONUSSCANNER_SLASH_STRING15"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."broker: [";
L["BONUSSCANNER_SLASH_STRING15a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffCambia el estado del origen LDB, usado para mostrar las mejoras de objetos para el personaje actual.";
L["BONUSSCANNER_SLASH_STRING11"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."clearcache: |cffffffffLimpia la cache de objetos y fuerza una recolección de basura.";
L["BONUSSCANNER_SLASH_STRING6"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."target: |cffffffffMuestra las mejoras del equipo del objetivo seleccionado (ha de estar en rango de inspección).";
L["BONUSSCANNER_SLASH_STRING7"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."target <jugador>: |cffffffffSusurra las mejoras del equipo del objetivo seleccionado al jugador especificado.";
L["BONUSSCANNER_SLASH_STRING8"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<itemlink>: |cffffffffMuestra las mejoras del objeto enlazado (inserta el enlace con Shift-Click).";
L["BONUSSCANNER_SLASH_STRING9"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<itemlink> <player>: |cffffffffSusurra las mejoras del objeto enlazado al jugador especificado.";
L["BONUSSCANNER_SLASH_STRING10"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<slotname>: |cffffffffMuestra las mejoras del objeto en la ubicación dada.";
