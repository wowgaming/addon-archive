
if (GetLocale() == "esES") then

---------------------------------------------
-- SPANISH
-- TRADUCIDO POR Kâs (Stress - EU-Exodar)
-- 3.3.3.1
-- á = \195\161
-- é = \195\169    
-- í = \195\173
-- ó = \195\179
-- ú = \195\186
-- ñ = \195\177
-- (http://www.wowwiki.com/Localizing_an_addon)
-------------

-------------------
-- Compatibility --
-------------------

HEALBOT_DRUID   = "Druida";
HEALBOT_HUNTER  = "Cazador";
HEALBOT_MAGE    = "Mago";
HEALBOT_PALADIN = "Palad\195\173n";
HEALBOT_PRIEST  = "Sacerdote";
HEALBOT_ROGUE   = "P\195\173caro";
HEALBOT_SHAMAN  = "Cham\195\161n";
HEALBOT_WARLOCK = "Brujo";
HEALBOT_WARRIOR = "Guerrero";
HEALBOT_DEATHKNIGHT = "Caballero de la Muerte";

HEALBOT_HEAVY_NETHERWEAVE_BANDAGE = GetItemInfo(21991);
HEALBOT_HEAVY_RUNECLOTH_BANDAGE = "Venda de pa\195\177o r\195\186nico gruesa";
HEALBOT_MAJOR_HEALING_POTION    = "Poci\195\179n de sanaci\195\179n sublime";
HEALBOT_PURIFICATION_POTION     = "Poci\195\179n de purificaci\195\179n";
HEALBOT_ANTI_VENOM              = "Contraveneno";
HEALBOT_POWERFUL_ANTI_VENOM     = "Contraveneno fuerte";
HEALBOT_ELIXIR_OF_POISON_RES    = "Elixir de resistencia al veneno";
HEALBOT_STONEFORM		= GetSpellInfo(20594);

HEALBOT_GIFT_OF_THE_NAARU   = "Ofrenda de los naaru";

HEALBOT_FLASH_HEAL          = "Sanaci\195\179n rel\195\161mpago";
HEALBOT_FLASH_OF_LIGHT      = "Destello de Luz";
HEALBOT_GLYPH_OF_FLASH_OF_LIGHT = "Glifo de Destello de Luz";
HEALBOT_GREATER_HEAL        = "Sanaci\195\179n superior";
HEALBOT_BINDING_HEAL        = "Sanaci\195\179n conjunta"
HEALBOT_PRAYER_OF_MENDING   = "Rezo de alivio";
HEALBOT_PENANCE             = "Penitencia";
HEALBOT_HEALING_TOUCH       = "Toque de sanaci\195\179n";
HEALBOT_HEAL                = "Sanar";
HEALBOT_HEALING_WAVE        = "Ola de sanaci\195\179n";
HEALBOT_RIPTIDE             = "Mareas Vivas";
HEALBOT_HEALING_WAY         = "Camino de sanaci\195\179n";
HEALBOT_HOLY_LIGHT          = "Luz Sagrada";
HEALBOT_LESSER_HEAL         = "Sanaci\195\179n inferior";
HEALBOT_LESSER_HEALING_WAVE = "Ola de sanaci\195\179n inferior";
HEALBOT_REGROWTH            = "Recrecimiento";
HEALBOT_RENEW               = "Renovar";
HEALBOT_REJUVENATION        = "Rejuvenecimiento";
HEALBOT_LIFEBLOOM           = "Flor de vida";
HEALBOT_WILD_GROWTH         = "Crecimiento salvaje";
HEALBOT_REVIVE              = "Revivir";
HEALBOT_TRANQUILITY         = "Tranquilidad";
HEALBOT_SWIFTMEND           = "Alivio presto";
HEALBOT_PRAYER_OF_HEALING   = "Rezo de sanaci\195\179n";
HEALBOT_CHAIN_HEAL          = "Sanaci\195\179n en cadena";

HEALBOT_PAIN_SUPPRESSION        = "Supresi\195\179n de dolor";
HEALBOT_POWER_INFUSION          = "Infusi\195\179n de poder";
HEALBOT_POWER_WORD_FORTITUDE    = "Palabra de poder: entereza";
HEALBOT_PRAYER_OF_FORTITUDE     = "Rezo de entereza";
HEALBOT_DIVINE_SPIRIT           = "Esp\195\173ritu divino";
HEALBOT_GUARDIAN_SPIRIT		= GetSpellInfo(47788);
HEALBOT_PRAYER_OF_SPIRIT        = "Rezo de esp\195\173ritu";
HEALBOT_SHADOW_PROTECTION       = "Protecci\195\179n contra las Sombras";
HEALBOT_PRAYER_OF_SHADOW_PROTECTION = "Rezo de Protecci\195\179n contra las Sombras";
HEALBOT_INNER_FIRE            = "Fuego interno";
HEALBOT_INNER_FOCUS           = "Enfoque interno";
HEALBOT_TWIN_DISCIPLINES      = "Disciplinas gemelas";
HEALBOT_SPIRITAL_HEALING      = "Sanaci\195\179n espiritual";
HEALBOT_EMPOWERED_HEALING     = "Sanaci\195\179n empoderada";
HEALBOT_DIVINE_PROVIDENCE     = "Divina providencia";
HEALBOT_IMPROVED_RENEW        = "Renovar mejorado";
HEALBOT_FOCUSED_POWER         = "Poder enfocado";
HEALBOT_GENESIS               = "G\195\169nesis";
HEALBOT_NURTURING_INSTINCT    = "Instinto de nutrici\195\179n";
HEALBOT_IMPROVED_REJUVENATION = "Rejuvenecimiento mejorado";
HEALBOT_GIFT_OF_NATURE        = "Don de la Naturaleza";
HEALBOT_EMPOWERED_TOUCH       = "Toque potenciado";
HEALBOT_EMPOWERED_REJUVENATION = "Rejuvenecimiento potenciado";
HEALBOT_HEALING_LIGHT         = "Luz de sanaci\195\179n";
HEALBOT_PURIFICATION          = "Purificaci\195\179n";
HEALBOT_IMPROVED_CHAIN_HEAL   = "Sanaci\195\179n en cadena mejorada";
HEALBOT_NATURES_BLESSING      = "Bendici\195\179n de la Naturaleza";
HEALBOT_FEAR_WARD             = "Resguardo de miedo";
HEALBOT_TOUCH_OF_WEAKNESS     = "Toque de Debilidad";
HEALBOT_ARCANE_INTELLECT      = "Intelecto Arcano";
HEALBOT_ARCANE_BRILLIANCE     = "Luminosidad Arcana";
HEALBOT_DALARAN_INTELLECT     = "Intelecto de Dalaran"
HEALBOT_DALARAN_BRILLIANCE    = "Luminosidad de Dalaran"
HEALBOT_FROST_ARMOR           = "Armadura de Escarcha";
HEALBOT_ICE_ARMOR             = "Armadura de hielo";
HEALBOT_MAGE_ARMOR            = "Armadura de mago";
HEALBOT_MOLTEN_ARMOR          = "Armadura de arrabio";
HEALBOT_DEMON_ARMOR           = "Armadura demon\195\173aca";
HEALBOT_DEMON_SKIN            = "Piel de demonio";
HEALBOT_FEL_ARMOR             = "Armadura vil";
HEALBOT_DAMPEN_MAGIC          = "Atenuar magia";
HEALBOT_AMPLIFY_MAGIC         = "Amplificar magia";
HEALBOT_SHADOW_GUARD          = "Guardasombras";
HEALBOT_DETECT_INV            = "Detectar invisibilidad";
HEALBOT_FOCUS_MAGIC           = "Enfocar magia";

HEALBOT_LIGHTNING_SHIELD      = "Escudo de rel\195\161mpagos";
HEALBOT_ROCKBITER_WEAPON      = "Arma Muerdepiedras";
HEALBOT_FLAMETONGUE_WEAPON    = "Arma Lengua de Fuego";
HEALBOT_EARTHLIVING_WEAPON    = "Arma de Vida terrestre";
HEALBOT_WINDFURY_WEAPON       = "Arma Viento Furioso";
HEALBOT_FROSTBRAND_WEAPON     = "Arma Estigma de Escarcha";
HEALBOT_EARTH_SHIELD          = "Escudo de tierra";
HEALBOT_WATER_SHIELD          = "Escudo de agua";
HEALBOT_WIND_FURY             = "Arma Viento Furioso";

HEALBOT_MARK_OF_THE_WILD      = "Marca de lo Salvaje";
HEALBOT_GIFT_OF_THE_WILD      = "Don de lo Salvaje";
HEALBOT_THORNS                = "Espinas";
HEALBOT_OMEN_OF_CLARITY       = "Augurio de claridad";

HEALBOT_BEACON_OF_LIGHT         = "Se\195\177al de la Luz";
HEALBOT_SACRED_SHIELD           = "Escudo sacro";
HEALBOT_SHEATH_OF_LIGHT         = "Vaina de Luz"
HEALBOT_BLESSING_OF_MIGHT       = "Bendici\195\179n de poder\195\173o";
HEALBOT_BLESSING_OF_WISDOM      = "Bendici\195\179n de sabidur\195\173a";
HEALBOT_BLESSING_OF_SALVATION   = "Bendici\195\179n de salvaci\195\179n";
HEALBOT_BLESSING_OF_SANCTUARY   = "Bendici\195\179n de salvaguardia";
HEALBOT_BLESSING_OF_LIGHT       = "Bendici\195\179n de Luz";
HEALBOT_BLESSING_OF_PROTECTION  = "Bendici\195\179n de protecci\195\179n";
HEALBOT_BLESSING_OF_FREEDOM     = "Bendici\195\179n de libertad";
HEALBOT_BLESSING_OF_SACRIFICE   = "Bendici\195\179n de sacrificio";
HEALBOT_BLESSING_OF_KINGS       = "Bendici\195\179n de reyes";
HEALBOT_HAND_OF_SALVATION       = "Mano de salvaci\195\179n";
HEALBOT_GREATER_BLESSING_OF_MIGHT     = "Bendici\195\179n de poder\195\173o superior";
HEALBOT_GREATER_BLESSING_OF_WISDOM    = "Bendici\195\179n de sabidur\195\173a superior";
HEALBOT_GREATER_BLESSING_OF_KINGS     = "Bendici\195\179n de reyes superior";
HEALBOT_GREATER_BLESSING_OF_LIGHT     = "Bendici\195\179n de Luz superior";
HEALBOT_GREATER_BLESSING_OF_SALVATION = "Bendici\195\179n de salvaci\195\179n superior";
HEALBOT_GREATER_BLESSING_OF_SANCTUARY = "Bendici\195\179n de salvaguardia superior";
HEALBOT_SEAL_OF_RIGHTEOUSNESS   = "Sello de rectitud"
HEALBOT_SEAL_OF_BLOOD           = "Sello de sangre"
HEALBOT_SEAL_OF_CORRUPTION      = "Sello de corrupci\195\179n"
HEALBOT_SEAL_OF_JUSTICE         = "Sello de justicia"
HEALBOT_SEAL_OF_LIGHT           = "Sello de Luz"
HEALBOT_SEAL_OF_VENGEANCE       = "Sello de venganza"
HEALBOT_SEAL_OF_WISDOM          = "Sello de sabidur\195\173a"
HEALBOT_SEAL_OF_COMMAND         = "Sello de orden"
HEALBOT_SEAL_OF_THE_MARTYR      = "Sello del m\195\161rtir"
HEALBOT_RIGHTEOUS_FURY          = "Furia recta"
HEALBOT_HAND_OF_FREEDOM 	= "Mano de libertad"
HEALBOT_HAND_OF_PROTECTION 	= "Mano de protecci\195\179n"
HEALBOT_HAND_OF_SACRIFICE 	= "Mano de sacrificio"
HEALBOT_HAND_OF_SALVATION 	= "Mano de salvaci\195\179n"
HEALBOT_DEVOTION_AURA           = "Aura de devoci\195\179n"
HEALBOT_RETRIBUTION_AURA        = "Aura de reprensi\195\179n"
HEALBOT_CONCENTRATION_AURA      = "Aura de concentraci\195\179n"
HEALBOT_SHR_AURA                = "Aura de Resistencia a las Sombras"
HEALBOT_FRR_AURA                = "Aura de Resistencia a la Escarcha"
HEALBOT_FIR_AURA                = "Aura de Resistencia al Fuego"
HEALBOT_CRUSADER_AURA           = "Aura de cruzado"
HEALBOT_SANCTITY_AURA           = "Aura de santidad"

HEALBOT_BONE_SHIELD		=	GetSpellInfo(49222);

HEALBOT_INTERVENE		= GetSpellInfo(3411);
HEALBOT_VIGILANCE           = "Vigilancia"

HEALBOT_A_MONKEY            = "Aspecto del mono"
HEALBOT_A_HAWK              = "Aspecto del halc\195\179n"
HEALBOT_A_CHEETAH           = "Aspecto del guepardo"
HEALBOT_A_BEAST             = "Aspecto de la bestia"
HEALBOT_A_PACK              = "Aspecto de la manada"
HEALBOT_A_WILD              = "Aspecto salvaje"
HEALBOT_A_VIPER             = "Aspecto de la v\195\173bora"
HEALBOT_A_DRAGONHAWK        = "Aspecto del dracohalc\195\179n"
HEALBOT_MENDPET             = "Aliviar mascota"

HEALBOT_UNENDING_BREATH     = "Aliento inagotable"
HEALBOT_HEALTH_FUNNEL       = "Cauce de salud"

HEALBOT_RESURRECTION       = "Resurrecci\195\179n";
HEALBOT_REDEMPTION         = "Redenci\195\179n";
HEALBOT_REBIRTH            = "Renacer";
HEALBOT_ANCESTRALSPIRIT    = "Esp\195\173ritu ancestral";

HEALBOT_PURIFY             = "Purificar";
HEALBOT_CLEANSE            = "Limpiar";
HEALBOT_CURE_POISON        = "Curar envenenamiento";
HEALBOT_REMOVE_CURSE       = "Eliminar maldici\195\179n";
HEALBOT_ABOLISH_POISON     = "Suprimir veneno";
HEALBOT_CURE_DISEASE       = "Curar enfermedad";
HEALBOT_ABOLISH_DISEASE    = "Suprimir enfermedad";
HEALBOT_DISPEL_MAGIC       = "Disipar magia";
HEALBOT_REMOVE_LESSER_CURSE = "Eliminar maldici\195\179n";
HEALBOT_CLEANSE_SPIRIT	   = "Limpiar esp\195\173ritu";
HEALBOT_CURE_TOXINS        = "Curar toxinas"
HEALBOT_DISEASE            = "Enfermedad";
HEALBOT_MAGIC              = "Magia";
HEALBOT_CURSE              = "Maldici\195\179n";
HEALBOT_POISON             = "Veneno";
HEALBOT_DISEASE_en         = "Disease";  -- Do NOT localize this value.
HEALBOT_MAGIC_en           = "Magic";  -- Do NOT localize this value.
HEALBOT_CURSE_en           = "Curse";  -- Do NOT localize this value.
HEALBOT_POISON_en          = "Poison";  -- Do NOT localize this value.
HEALBOT_CUSTOM_en          = "Custom";  -- Do NOT localize this value. 

HEALBOT_DEBUFF_ANCIENT_HYSTERIA = "Histeria ancestral";
HEALBOT_DEBUFF_IGNITE_MANA      = "Ignici\195\179n de man\195\161";
HEALBOT_DEBUFF_TAINTED_MIND     = "Mente m\195\161cula";
HEALBOT_DEBUFF_VIPER_STING      = "Picadura de v\195\173bora";
HEALBOT_DEBUFF_SILENCE          = "Silencio";
HEALBOT_DEBUFF_MAGMA_SHACKLES   = "Grilletes de magma";
HEALBOT_DEBUFF_FROSTBOLT        = "Descarga de Escarcha";
HEALBOT_DEBUFF_HUNTERS_MARK     = "Marca del cazador";
HEALBOT_DEBUFF_SLOW             = "Slow";
HEALBOT_DEBUFF_ARCANE_BLAST     = "Explosi\195\179n Arcana";
HEALBOT_DEBUFF_IMPOTENCE        = "Maldici\195\179n de impotencia";
HEALBOT_DEBUFF_DECAYED_STR      = "Fuerza deteriorada";
HEALBOT_DEBUFF_DECAYED_INT      = "Intelecto deteriorado";
HEALBOT_DEBUFF_CRIPPLE          = "Cripple";
HEALBOT_DEBUFF_CHILLED          = "Chilled";
HEALBOT_DEBUFF_CONEOFCOLD       = "Cono de fr\195\173o";
HEALBOT_DEBUFF_CONCUSSIVESHOT   = "Disparo de conmoci\195\179n";
HEALBOT_DEBUFF_THUNDERCLAP      = "Atronar";
HEALBOT_DEBUFF_HOWLINGSCREECH   = "Chirrido aullante";
HEALBOT_DEBUFF_DAZED            = "Atontado";
HEALBOT_DEBUFF_UNSTABLE_AFFL    = "Aflicci\195\179n inestable";
HEALBOT_DEBUFF_DREAMLESS_SLEEP  = "Letargo sin sue\195\177os";
HEALBOT_DEBUFF_GREATER_DREAMLESS = "Letargo sin sue\195\177or superior";
HEALBOT_DEBUFF_MAJOR_DREAMLESS  = "Letargo sin sue\195\177os sublime";
HEALBOT_DEBUFF_FROST_SHOCK      = "Choque de Escarcha"
HEALBOT_DEBUFF_WEAKENED_SOUL    = GetSpellInfo(6788)

HEALBOT_RANK_1              = "(Rango 1)";
HEALBOT_RANK_2              = "(Rango 2)";
HEALBOT_RANK_3              = "(Rango 3)";
HEALBOT_RANK_4              = "(Rango 4)";
HEALBOT_RANK_5              = "(Rango 5)";
HEALBOT_RANK_6              = "(Rango 6)";
HEALBOT_RANK_7              = "(Rango 7)";
HEALBOT_RANK_8              = "(Rango 8)";
HEALBOT_RANK_9              = "(Rango 9)";
HEALBOT_RANK_10             = "(Rango 10)";
HEALBOT_RANK_11             = "(Rango 11)";
HEALBOT_RANK_12             = "(Rango 12)";
HEALBOT_RANK_13             = "(Rango 13)";
HEALBOT_RANK_14             = "(Rango 14)";
HEALBOT_RANK_15             = "(Rango 15)";
HEALBOT_RANK_16             = "(Rango 16)";
HEALBOT_RANK_17             = "(Rango 17)";
HEALBOT_RANK_18             = "(Rango 18)";


HB_SPELL_PATTERN_LESSER_HEAL         = "Sana tu objetivo de (%d+) a (%d+)";
HB_SPELL_PATTERN_HEAL                = "Sana tu objetivo de (%d+) a (%d+)";
HB_SPELL_PATTERN_GREATER_HEAL        = "Un hechizo de lanzamiento lento que sana a un \195\186nico objetivo de (%d+) a (%d+)";
HB_SPELL_PATTERN_FLASH_HEAL          = "Sana un objetivo amistoso de (%d+) a (%d+)";
HB_SPELL_PATTERN_RENEW               = "Sana al objetivo de (%d+) a (%d+) durante (%d+) s.";
HB_SPELL_PATTERN_RENEW1              = "Sana al objetivo en (%d+) durante (%d+) s.";
HB_SPELL_PATTERN_RENEW2              = "no se necesita";
HB_SPELL_PATTERN_RENEW3              = "no se necesita";
HB_SPELL_PATTERN_SHIELD              = "amortiguando (%d+) de da\195\177o. Dura (%d+) s.";
HB_SPELL_PATTERN_HEALING_TOUCH       = "Sana un objetivo amistoso de (%d+) a (%d+)";
HB_SPELL_PATTERN_REGROWTH            = "Sana un objetivo amistoso de (%d+) a (%d+) y otros en (%d+) durante (%d+) s.";
HB_SPELL_PATTERN_REGROWTH1           = "Sana un objetivo amistoso de (%d+) a (%d+) y otros en (%d+) a (%d+) durante (%d+) s.";
HB_SPELL_PATTERN_HOLY_LIGHT          = "Sana un objetivo amistoso de (%d+) a (%d+)";
HB_SPELL_PATTERN_FLASH_OF_LIGHT      = "Sana un objetivo amistoso de (%d+) a (%d+)";
HB_SPELL_PATTERN_HEALING_WAVE        = "Sana un objetivo amistoso de (%d+) a (%d+)";
HB_SPELL_PATTERN_LESSER_HEALING_WAVE = "Sana un objetivo amistoso de (%d+) a (%d+)";
HB_SPELL_PATTERN_REJUVENATION        = "Sana un objetivo en (%d+) durante (%d+) s.";
HB_SPELL_PATTERN_REJUVENATION1       = "Sana un objetivo de (%d+) a (%d+) durante (%d+) s.";
HB_SPELL_PATTERN_REJUVENATION2       = "no se necesita";
HB_SPELL_PATTERN_MEND_PET            = "Sana a tu mascota en (%d+) p. de salud durante (%d+) s.";


HB_TOOLTIP_MANA           = "^(%d+) de man\195\161$";
HB_TOOLTIP_RANGE          = "Alcance de (%d+) m";
HB_TOOLTIP_INSTANT_CAST   = "Hechizo instant\195\161neo";
HB_TOOLTIP_CAST_TIME      = "(%d+.?%d*) s para lanzar";
HB_TOOLTIP_CHANNELED      = "Canalizado";
HB_TOOLTIP_OFFLINE        = "desconectado";
HB_OFFLINE                = "desconectado"; -- has gone offline msg
HB_ONLINE                 = "conectado"; -- has come online msg


-----------------
-- Translation --
-----------------

HEALBOT_ADDON = "HealBot " .. HEALBOT_VERSION;
HEALBOT_LOADED = " cargado.";

HEALBOT_ACTION_OPTIONS    = "Opciones";

HEALBOT_OPTIONS_TITLE         = HEALBOT_ADDON;
HEALBOT_OPTIONS_DEFAULTS      = "Defecto";
HEALBOT_OPTIONS_CLOSE         = "Cerrar";
HEALBOT_OPTIONS_HARDRESET     = "RecargarUI"
HEALBOT_OPTIONS_SOFTRESET     = "ResetHB"
HEALBOT_OPTIONS_INFO          = "Info"
HEALBOT_OPTIONS_TAB_GENERAL   = "General";
HEALBOT_OPTIONS_TAB_SPELLS    = "Habilidades";
HEALBOT_OPTIONS_TAB_HEALING   = "Sanaci\195\179n";
HEALBOT_OPTIONS_TAB_CDC       = "Debuffs";
HEALBOT_OPTIONS_TAB_SKIN      = "Skin";
HEALBOT_OPTIONS_TAB_TIPS      = "Info";
HEALBOT_OPTIONS_TAB_BUFFS     = "Buffs"

HEALBOT_OPTIONS_PANEL_TEXT    = "Opciones del panel"
HEALBOT_OPTIONS_BARALPHA      = "Opacidad barra habilitada";
HEALBOT_OPTIONS_BARALPHAINHEAL= "Opacidad de curas entrantes";
HEALBOT_OPTIONS_BARALPHAEOR   = "Opacidad fuera de rango";
HEALBOT_OPTIONS_ACTIONLOCKED  = "Bloquear posici\195\179n";
HEALBOT_OPTIONS_AUTOSHOW      = "Cerrar autom\195\161ticamente";
HEALBOT_OPTIONS_PANELSOUNDS   = "Reproducir sonido al entrar";
HEALBOT_OPTIONS_HIDEOPTIONS   = "Ocultar bot\195\179n Opciones";
HEALBOT_OPTIONS_PROTECTPVP    = "Evitar ser marcado accidentalmente con PvP";
HEALBOT_OPTIONS_HEAL_CHATOPT  = "Opciones de Chat";

HEALBOT_OPTIONS_SKINTEXT      = "Usar skin"
HEALBOT_SKINS_STD             = "Est\195\161ndar"
HEALBOT_OPTIONS_SKINTEXTURE   = "Textura"
HEALBOT_OPTIONS_SKINHEIGHT    = "Alto"
HEALBOT_OPTIONS_SKINWIDTH     = "Ancho"
HEALBOT_OPTIONS_SKINNUMCOLS   = "No. columnas"
HEALBOT_OPTIONS_SKINNUMHCOLS  = "No. cabeceras por columna"
HEALBOT_OPTIONS_SKINBRSPACE   = "Espacio entre filas"
HEALBOT_OPTIONS_SKINBCSPACE   = "Espacio entre columnas"
HEALBOT_OPTIONS_EXTRASORT     = "Orden de barras"
HEALBOT_SORTBY_NAME           = "Nombre"
HEALBOT_SORTBY_CLASS          = "Clase"
HEALBOT_SORTBY_GROUP          = "Grupo"
HEALBOT_SORTBY_MAXHEALTH      = "Salud m\195\161x"
HEALBOT_OPTIONS_NEWDEBUFFTEXT = "Nuevo debuff"
HEALBOT_OPTIONS_DELSKIN       = "Borrar"
HEALBOT_OPTIONS_NEWSKINTEXT   = "Nueva skin"
HEALBOT_OPTIONS_SAVESKIN      = "Guardar"
HEALBOT_OPTIONS_SKINBARS      = "Opciones de barras"
HEALBOT_OPTIONS_SKINPANEL     = "Colores del panel"
HEALBOT_SKIN_ENTEXT           = "Habilitado"
HEALBOT_SKIN_DISTEXT          = "Deshabilitado"
HEALBOT_SKIN_DEBTEXT          = "Debuff"
HEALBOT_SKIN_BACKTEXT         = "Fondo"
HEALBOT_SKIN_BORDERTEXT       = "Borde"
HEALBOT_OPTIONS_SKINFONT      = "Fuente"
HEALBOT_OPTIONS_SKINFHEIGHT   = "Tama\195\177o de la fuente"
HEALBOT_OPTIONS_BARALPHADIS   = "Opacidad barra deshabilitada"
HEALBOT_OPTIONS_SHOWHEADERS   = "Mostrar cabeceras"

HEALBOT_OPTIONS_ITEMS  = "Items";
HEALBOT_OPTIONS_SPELLS = "Habilidades";

HEALBOT_OPTIONS_COMBOCLASS    = "Combos para";
HEALBOT_OPTIONS_CLICK         = "Clic";
HEALBOT_OPTIONS_SHIFT         = "Mayus";
HEALBOT_OPTIONS_CTRL          = "Ctrl";
HEALBOT_OPTIONS_ENABLEHEALTHY = "Siempre usar configuraci\195\179n habilitada";

HEALBOT_OPTIONS_CASTNOTIFY1   = "Sin mensajes";
HEALBOT_OPTIONS_CASTNOTIFY2   = "Notificarme a mi";
HEALBOT_OPTIONS_CASTNOTIFY3   = "Notificar objetivo";
HEALBOT_OPTIONS_CASTNOTIFY4   = "Notificar grupo";
HEALBOT_OPTIONS_CASTNOTIFY5   = "Notificar raid";
HEALBOT_OPTIONS_CASTNOTIFY6   = "Notificar canal";
HEALBOT_OPTIONS_CASTNOTIFYRESONLY = "Notificar s\195\179lo resurrecci\195\179n";
HEALBOT_OPTIONS_TARGETWHISPER = "susurrar al objetivo al curar";

HEALBOT_OPTIONS_CDCBARS       = "Colores";
HEALBOT_OPTIONS_CDCSHOWHBARS  = "Cambiar color barra de salud";
HEALBOT_OPTIONS_CDCSHOWABARS  = "Cambiar color barra de aggro";
HEALBOT_OPTIONS_CDCCLASS      = "Monitorizar clases";
HEALBOT_OPTIONS_CDCWARNINGS   = "Alertas de debuffs";
HEALBOT_OPTIONS_SHOWDEBUFFICON = "Ver icono debuff";
HEALBOT_OPTIONS_SHOWDEBUFFWARNING = "Mostrar alerta de debuffs";
HEALBOT_OPTIONS_SOUNDDEBUFFWARNING = "Reproducir sonido";
HEALBOT_OPTIONS_SOUND	      = "Sonido"
HEALBOT_OPTIONS_SOUND1        = "Sonido 1"
HEALBOT_OPTIONS_SOUND2        = "Sonido 2"
HEALBOT_OPTIONS_SOUND3        = "Sonido 3"

HEALBOT_OPTIONS_HEAL_BUTTONS  = "Barras de curaci\195\179n:";
HEALBOT_OPTIONS_SELFHEALS     = "Yo"
HEALBOT_OPTIONS_PETHEALS      = "Mascotas"
HEALBOT_OPTIONS_GROUPHEALS    = "Grupo";
HEALBOT_OPTIONS_TANKHEALS     = "Main tanks";
HEALBOT_OPTIONS_TARGETHEALS   = "Objetivos";
HEALBOT_OPTIONS_EMERGENCYHEALS= "Raid";
HEALBOT_OPTIONS_ALERTLEVEL    = "Nivel de Alerta";
HEALBOT_OPTIONS_EMERGFILTER   = "Mostrar barras para";
HEALBOT_OPTIONS_EMERGFCLASS   = "Configurar clases para";
HEALBOT_OPTIONS_COMBOBUTTON   = "Bot\195\179n";
HEALBOT_OPTIONS_BUTTONLEFT    = "Izqdo";
HEALBOT_OPTIONS_BUTTONMIDDLE  = "Central";
HEALBOT_OPTIONS_BUTTONRIGHT   = "Dcho";
HEALBOT_OPTIONS_BUTTON4       = "Bot\195\179n4";
HEALBOT_OPTIONS_BUTTON5       = "Bot\195\179n5";
HEALBOT_OPTIONS_BUTTON6       = "Bot\195\179n6";
HEALBOT_OPTIONS_BUTTON7       = "Bot\195\179n7";
HEALBOT_OPTIONS_BUTTON8       = "Bot\195\179n8";
HEALBOT_OPTIONS_BUTTON9       = "Bot\195\179n9";
HEALBOT_OPTIONS_BUTTON10      = "Bot\195\179n10";
HEALBOT_OPTIONS_BUTTON11      = "Bot\195\179n11";
HEALBOT_OPTIONS_BUTTON12      = "Bot\195\179n12";
HEALBOT_OPTIONS_BUTTON13      = "Bot\195\179n13";
HEALBOT_OPTIONS_BUTTON14      = "Bot\195\179n14";
HEALBOT_OPTIONS_BUTTON15      = "Bot\195\179n15";

HEALBOT_CLASSES_ALL     = "Todas las clases";
HEALBOT_CLASSES_MELEE   = "Melee";
HEALBOT_CLASSES_RANGES  = "Ranged";
HEALBOT_CLASSES_HEALERS = "Healers";
HEALBOT_CLASSES_CUSTOM  = "Personalizado";

HEALBOT_OPTIONS_SHOWTOOLTIP     = "Ver tooltips";
HEALBOT_OPTIONS_SHOWDETTOOLTIP  = "Ver informaci\195\179n detallada de habilidades";
HEALBOT_OPTIONS_SHOWUNITTOOLTIP = "Ver informaci\195\179n del objetivo";
HEALBOT_OPTIONS_SHOWRECTOOLTIP  = "Ver recomendaci\195\179n de HoT";
HEALBOT_OPTIONS_SHOWPDCTOOLTIP  = "Ver combos predefinidos";
HEALBOT_TOOLTIP_POSDEFAULT      = "Localizaci\195\179n por defecto";
HEALBOT_TOOLTIP_POSLEFT         = "Izqda de Healbot";
HEALBOT_TOOLTIP_POSRIGHT        = "Dcha de Healbot";
HEALBOT_TOOLTIP_POSABOVE        = "Sobre Healbot";
HEALBOT_TOOLTIP_POSBELOW        = "Debajo de Healbot";
HEALBOT_TOOLTIP_POSCURSOR       = "Junto al Cursor";
HEALBOT_TOOLTIP_RECOMMENDTEXT   = "Recomendaci\195\179n HoT";
HEALBOT_TOOLTIP_NONE            = "nada disponible";
HEALBOT_TOOLTIP_ITEMBONUS       = "Poder con hechizo";
HEALBOT_TOOLTIP_ACTUALBONUS     = "El bonus actual es";
HEALBOT_TOOLTIP_SHIELD          = "Escudo";
HEALBOT_TOOLTIP_LOCATION        = "Location";
HEALBOT_TOOLTIP_CORPSE          = "Cuerpo de ";
HEALBOT_WORDS_OVER              = "en";
HEALBOT_WORDS_SEC               = "seg";
HEALBOT_WORDS_TO                = "a";
HEALBOT_WORDS_CAST              = "Lanzar";
HEALBOT_WORDS_FOR               = "para";
HEALBOT_WORDS_UNKNOWN           = "Desconocido";
HEALBOT_WORDS_YES               = "S\195\173";
HEALBOT_WORDS_NO                = "No";

HEALBOT_WORDS_NONE              = "Ninguno";
HEALBOT_OPTIONS_ALT             = "Alt";
HEALBOT_DISABLED_TARGET         = "Target";
HEALBOT_OPTIONS_SHOWCLASSONBAR  = "Ver clase en barra";
HEALBOT_OPTIONS_SHOWHEALTHONBAR = "Ver vida en la barra";
HEALBOT_OPTIONS_BARHEALTHINCHEALS = "Ver sanaci\195\179n entrante";
HEALBOT_OPTIONS_BARHEALTHSEPHEALS = "Separar sanaci\195\179n entrante";
HEALBOT_OPTIONS_BARHEALTH1      = "delta";
HEALBOT_OPTIONS_BARHEALTH2      = "porcentaje";
HEALBOT_OPTIONS_TIPTEXT         = "Informaci\195\179n Emergente";
HEALBOT_OPTIONS_BARINFOTEXT     = "Informaci\195\179n de Barra";
HEALBOT_OPTIONS_POSTOOLTIP      = "Posici\195\179n";
HEALBOT_OPTIONS_SHOWNAMEONBAR   = "Ver nombre en la barra";
HEALBOT_OPTIONS_BARCLASSCOLOUR	= "Colorear barras por clase";
HEALBOT_SKIN_BARCLASSCUSTOMCOLOUR    = "Color de barra por";
HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1 = "Colorear texto por clase";
HEALBOT_OPTIONS_EMERGFILTERGROUPS   = "Incluir grupo";

HEALBOT_ONE   = "1";
HEALBOT_TWO   = "2";
HEALBOT_THREE = "3";
HEALBOT_FOUR  = "4";
HEALBOT_FIVE  = "5";
HEALBOT_SIX   = "6";
HEALBOT_SEVEN = "7";
HEALBOT_EIGHT = "8";

HEALBOT_OPTIONS_SETDEFAULTS    = "Establecer por defecto";
HEALBOT_OPTIONS_SETDEFAULTSMSG = "Volver todas las opciones a valores por defecto";
HEALBOT_OPTIONS_RIGHTBOPTIONS  = "Clic dcho para abrir Opciones";

HEALBOT_OPTIONS_HEADEROPTTEXT  = "Cabeceras";
HEALBOT_OPTIONS_ICONOPTTEXT    = "Iconos";
HEALBOT_SKIN_HEADERBARCOL      = "Color de barra";
HEALBOT_SKIN_HEADERTEXTCOL     = "Color de texto";
HEALBOT_OPTIONS_BUFFSTEXT1      = "Buff";
HEALBOT_OPTIONS_BUFFSTEXT2      = "comprobar";
HEALBOT_OPTIONS_BUFFSTEXT3      = "Color de barra";
HEALBOT_OPTIONS_BUFF           = "Buff ";
HEALBOT_OPTIONS_BUFFSELF       = "yo";
HEALBOT_OPTIONS_BUFFPARTY      = "grupo";
HEALBOT_OPTIONS_BUFFRAID       = "raid";
HEALBOT_OPTIONS_MONITORBUFFS   = "Monitorizar buffs perdidos";
HEALBOT_OPTIONS_MONITORBUFFSC  = "tambi\195\169n en combate";
HEALBOT_OPTIONS_ENABLESMARTCAST  = "SmartCast fuera de combate";
HEALBOT_OPTIONS_SMARTCASTSPELLS  = "Incluir";
HEALBOT_OPTIONS_SMARTCASTDISPELL = "Quitar debuffs";
HEALBOT_OPTIONS_SMARTCASTBUFF    = "Poner buffs";
HEALBOT_OPTIONS_SMARTCASTHEAL    = "Curaciones";
HEALBOT_OPTIONS_BAR2SIZE         = "Tama\195\177o barra de man\195\161";
HEALBOT_OPTIONS_SETSPELLS        = "Habilidades para ";
HEALBOT_OPTIONS_ENABLEDBARS     = "Barras habilitadas";
HEALBOT_OPTIONS_DISABLEDBARS    = "Barras deshabilitadas";
HEALBOT_OPTIONS_MONITORDEBUFFS  = "Monitorizar debuffs";
HEALBOT_OPTIONS_DEBUFFTEXT1     = "Habilidades para debuffs";

HEALBOT_OPTIONS_IGNOREDEBUFF         = "Ignorar debuffs:";
HEALBOT_OPTIONS_IGNOREDEBUFFCLASS    = "Seg\195\186n clase";
HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT = "Ralentizadores";
HEALBOT_OPTIONS_IGNOREDEBUFFDURATION = "Corta duraci\195\179n";
HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM   = "No da\195\177inos";

HEALBOT_OPTIONS_RANGECHECKFREQ       = "Frec. de chequeo del rango";
HEALBOT_OPTIONS_RANGECHECKUNITS      = "Max. minor wounded targets per range check"

HEALBOT_OPTIONS_HIDEPARTYFRAMES      = "Ocultar grupo";
HEALBOT_OPTIONS_HIDEPLAYERTARGET     = "Incluir jugador y objetivo";
HEALBOT_OPTIONS_DISABLEHEALBOT       = "Deshabilitar HealBot";

HEALBOT_OPTIONS_CHECKEDTARGET        = "Comprobado";

HEALBOT_ASSIST  = "Assist";
HEALBOT_FOCUS   = "Focus";
HEALBOT_MENU        = "Menu";
HEALBOT_MAINTANK    = "MainTank";
HEALBOT_MAINASSIST  = "MainAssist";

HEALBOT_TITAN_SMARTCAST      = "SmartCast";
HEALBOT_TITAN_MONITORBUFFS   = "Monitor de buffs";
HEALBOT_TITAN_MONITORDEBUFFS = "Monitor de debuffs"
HEALBOT_TITAN_SHOWBARS       = "Mostrar barras para";
HEALBOT_TITAN_EXTRABARS      = "Barras Extra";
HEALBOT_BUTTON_TOOLTIP       = "Clic izqdo para ver Opciones de HealBot\nClic dcho para mover este icono";
HEALBOT_TITAN_TOOLTIP        = "Clic izqdo para ver Opciones de HealBot";
HEALBOT_OPTIONS_SHOWMINIMAPBUTTON = "Ver icono en el minimapa";
HEALBOT_OPTIONS_BARBUTTONSHOWHOT  = "Ver iconos HoT";
HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON = "Ver iconos de raid";
HEALBOT_OPTIONS_HOTONBAR     = "En barras";
HEALBOT_OPTIONS_HOTOFFBAR    = "Fuera de barras";
HEALBOT_OPTIONS_HOTBARRIGHT  = "Lado dcho";
HEALBOT_OPTIONS_HOTBARLEFT   = "Lado izqdo";

HEALBOT_OPTIONS_ENABLETARGETSTATUS = "Usar barras habilitadas en combate";

HEALBOT_ZONE_AB = "Cuenca de Arathi";
HEALBOT_ZONE_AV = "Valle de Alterac";
HEALBOT_ZONE_ES = "Ojo de la Tormenta";
HEALBOT_ZONE_WG = "Garganta Grito de Guerra";

HEALBOT_OPTION_AGGROTRACK = "Monitorizar Aggro"
HEALBOT_OPTION_AGGROBAR = "Parpadear"
HEALBOT_OPTION_AGGROTXT = ">> Mostrar texto <<"
HEALBOT_OPTION_BARUPDFREQ = "Frecuencia refresco"
HEALBOT_OPTION_USEFLUIDBARS = "Usar barras fluidas"
HEALBOT_OPTION_CPUPROFILE  = "Usar CPU profiler (Informaci\195\179n de uso de CPU)"
HEALBOT_OPTIONS_RELOADUIMSG = "Esta opci\195\179n requiere recargar la UI, recargar?"

HEALBOT_SELF_PVP              = "Auto PvP";
HEALBOT_OPTIONS_ANCHOR        = "Anclar";
HEALBOT_OPTIONS_TOPLEFT       = "Arriba Izqda";
HEALBOT_OPTIONS_BOTTOMLEFT    = "Abajo Izqda";
HEALBOT_OPTIONS_TOPRIGHT      = "Arriba Dcha";
HEALBOT_OPTIONS_BOTTOMRIGHT   = "Abajo Dcha";
HEALBOT_OPTIONS_TOP = "Arriba"
HEALBOT_OPTIONS_BOTTOM = "Abajo"

HEALBOT_PANEL_BLACKLIST       = "Lista negra";

HEALBOT_WORDS_REMOVEFROM      = "Eliminar de ";
HEALBOT_WORDS_ADDTO           = "A\195\177adir a ";
HEALBOT_WORDS_INCLUDE         = "Incluir";

HEALBOT_OPTIONS_TTALPHA       = "Opacidad";
HEALBOT_TOOLTIP_TARGETBAR     = "Barra Objetivo";
HEALBOT_OPTIONS_MYTARGET      = "Mis Objetivos";

HEALBOT_DISCONNECTED_TEXT	= "<DESC>"
HEALBOT_OPTIONS_SHOWUNITBUFFTIME    = "Ver mis buffs";
HEALBOT_OPTIONS_TOOLTIPUPDATE       = "Actualizar continuamente";
HEALBOT_OPTIONS_BUFFSTEXTTIMER      = "Avisar de buff antes de terminar";
HEALBOT_OPTIONS_SHORTBUFFTIMER      = "Buffs cortos";
HEALBOT_OPTIONS_LONGBUFFTIMER       = "Buffs largos";

HEALBOT_BALANCE       = "Equilibrio";
HEALBOT_FERAL         = "Combate feral";
HEALBOT_RESTORATION   = "Restauraci\195\179n";
HEALBOT_SHAMAN_RESTORATION = "Restauraci\195\179n";
HEALBOT_ARCANE        = "Arcano";
HEALBOT_FIRE          = "Fuego";
HEALBOT_FROST         = "Escarcha";
HEALBOT_DISCIPLINE    = "Disciplina";
HEALBOT_HOLY          = "Sagrado";
HEALBOT_SHADOW        = "Sombras";
HEALBOT_ASSASSINATION = "Asesinato";
HEALBOT_COMBAT        = "Combate";
HEALBOT_SUBTLETY      = "Sutileza";
HEALBOT_ARMS          = "Armas";
HEALBOT_FURY          = "Furia";
HEALBOT_PROTECTION    = "Protecci\195\179n";
HEALBOT_BEASTMASTERY  = "Dominio de bestias";
HEALBOT_MARKSMANSHIP  = "Punteria";
HEALBOT_SURVIVAL      = "Supervivencia";
HEALBOT_RETRIBUTION   = "Reprensi\195\179n";
HEALBOT_ELEMENTAL     = "Elemental";
HEALBOT_ENHANCEMENT   = "Mejora";
HEALBOT_AFFLICTION    = "Aflicci\195\179n";
HEALBOT_DEMONOLOGY    = "Demonolog\195\173a";
HEALBOT_DESTRUCTION   = "Destrucci\195\179n";
HEALBOT_BLOOD         = "Sangre";
HEALBOT_UNHOLY        = "Profano";

HEALBOT_OPTIONS_VISIBLERANGE = "Deshabilitar barra cuando el rango pase de 100 m";
HEALBOT_OPTIONS_NOTIFY_HEAL_MSG  = "Sanaci\195\179n";
HEALBOT_OPTIONS_NOTIFY_OTHER_MSG = "Otros";
HEALBOT_WORDS_YOU                = "t\195\186";
HEALBOT_NOTIFYHEALMSG            = "Lanzando #s para curar a #n por #h";
HEALBOT_NOTIFYOTHERMSG           = "Lanzando #s en #n";

HEALBOT_OPTIONS_HOTPOSITION     = "Posicinar icono";
HEALBOT_OPTIONS_HOTSHOWTEXT     = "Texto del icono";
HEALBOT_OPTIONS_HOTTEXTCOUNT    = "Cargas";
HEALBOT_OPTIONS_HOTTEXTDURATION = "Duraci\195\179n";
HEALBOT_OPTIONS_ICONSCALE       = "Escala de icono";
HEALBOT_OPTIONS_ICONTEXTSCALE   = "Escala de texto";

HEALBOT_SKIN_FLUID              = "Fluid";
HEALBOT_SKIN_VIVID              = "Vivid";
HEALBOT_SKIN_LIGHT              = "Light";
HEALBOT_SKIN_SQUARE             = "Square";
HEALBOT_OPTIONS_AGGROBARSIZE    = "Tama\195\177o barra de aggro";
HEALBOT_OPTIONS_TARGETBARMODE   = "Restringir Barra Objetivo a configuraci\195\179n predefinida";
HEALBOT_OPTIONS_DOUBLETEXTLINES = "L\195\173neas de doble texto";
HEALBOT_OPTIONS_TEXTALIGNMENT   = "Alineaci\195\179n del texto";
HEALBOT_OPTIONS_ENABLELIBQH     = "Habilitar libQuickHealth";
HEALBOT_VEHICLE 		= "Veh\195\173culo"
HEALBOT_OPTIONS_UNIQUESPEC      = "Guardar una lista distinta por cada spec"
HEALBOT_WORDS_ERROR		= "Error"
HEALBOT_SPELL_NOT_FOUND		= "Hechizo no encontrado"
HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT = "Ocultar tooltip en combate"

HEALBOT_OPTIONS_BUFFNAMED       = "Nombre de los jugadores a vigilar para"
HEALBOT_OPTIONS_INHEALS         = "Use HealBot for heals comm"
HEALBOT_WORD_ALWAYS             = "Siempre";
HEALBOT_WORD_SOLO               = "Solo";
HEALBOT_WORD_NEVER              = "Nunca";
HEALBOT_SHOW_CLASS_AS_ICON      = "como icono";
HEALBOT_SHOW_CLASS_AS_TEXT      = "como texto";

HEALBOT_SHOW_INCHEALS           = "Ver sanaci\195\179n entrante";
HEALBOT_D_DURATION              = "Duraci\195\179n directa";
HEALBOT_H_DURATION              = "Duraci\195\179n Hots";
HEALBOT_C_DURATION              = "Duraci\195\179n canalizaci\195\179n";

HEALBOT_HELP={ [1] = "[HealBot] /hb h -- Mostrar ayuda",
               [2] = "[HealBot] /hb o -- Cambiar opciones",
               [3] = "[HealBot] /hb d -- Restaurar opciones por defecto",
               [4] = "[HealBot] /hb ui -- Recargar UI",
               [5] = "[HealBot] /hb ri -- Restablecer HealBot",
               [6] = "[HealBot] /hb rc -- Restablecer debuffs personalizados",
               [7] = "[HealBot] /hb rs -- Restablecer skins",
               [8] = "[HealBot] /hb cb -- Borrar Lista negra",
               [9] = "[HealBot] /hb t -- Alternar Healbot entre habilitado y deshabilitado",
               [10] = "[HealBot] /hb disable -- Deshabilitar Healbot",
               [11] = "[HealBot] /hb enable -- Habilitar Healbot",
               [12] = "[HealBot] /hb skin <nombre de la skin> -- Cambiar skins",
               [13] = "[HealBot] /hb ss <nombre de la skin> <jugador> - Comparte una skin con otro jugador",
               [14] = "[HealBot] /hb as -- Activa/Desactiva aceptar skins de otros jugadores",
               [15] = "[HealBot] /hb cspells -- Copia los hechizos actuales a todas las spec",
               [16] = "[HealBot] /hb rspells -- Reinicia las habilidades a valores por defecto",
               [17] = "[HealBot] /hb rcures -- Reinicia debuffs a valores por defecto",
               [18] = "[HealBot] /hb rbuffs -- Reinicia los buffs a valores por defecto",
               [19] = "[HealBot] /hb info -- Muestra informaci\195\179n de HealBot y uso de CPU",
               [20] = "[HealBot] /hb show -- Reinicia la posici\195\179n de las barras al centro",
               [21] = "[HealBot] /hb tt -- Activa/Desactiva mostrar las curas junto al icono del Titan",
               [22] = "[HealBot] /hb suppress sound -- Activa/Desactiva la supresi\195\179n del sonido al usar Auto trinkets",
               [23] = "[HealBot] /hb suppress error -- Activa/Desactiva errores al usar Auto trinkets",
               [24] = "[HealBot] /hb tr <Rol> -- Establece el rol con m\195\161s prioridad para SubOrdenar por Rol. Los roles son 'TANK', 'HEALER' o 'DPS'",
              }

HEALBOT_OPTION_HIGHLIGHTACTIVEBAR   = "Destacar barra activa"
HEALBOT_OPTIONS_TESTBARS            = "Prueba de barras"
HEALBOT_OPTION_NUMBARS              = "N\195\186mero de barras"
HEALBOT_OPTION_NUMTANKS             = "N\195\186mero de tankes"
HEALBOT_OPTION_NUMMYTARGETS         = "N\195\186mero de Objetivos"
HEALBOT_OPTION_NUMPETS              = "N\195\186mero de mascotas"
HEALBOT_WORD_TEST                   = "Probar";
HEALBOT_WORD_OFF                    = "Off";
HEALBOT_WORD_ON                     = "On";

HEALBOT_OPTIONS_TAB_INCHEALS        = "Inc. sanaciones"
HEALBOT_OPTIONS_TAB_CHAT            = "Chat"
HEALBOT_OPTIONS_TAB_HEADERS         = "Cabeceras"
HEALBOT_OPTIONS_TAB_BARS            = "Barras"
HEALBOT_OPTIONS_TAB_TEXT            = "Texto"
HEALBOT_OPTIONS_TAB_ICONS           = "Iconos"
HEALBOT_OPTIONS_SKINDEFAULTFOR      = "Skin para"
HEALBOT_OPTIONS_INCHEAL             = "Sanaci\195\179n entrante"
HEALBOT_WORD_ARENA                  = "Arena"
HEALBOT_WORD_BATTLEGROUND           = "BG"
HEALBOT_OPTIONS_TEXTOPTIONS         = "Opciones de texto"
HEALBOT_WORD_PARTY                  = "Grupo"
HEALBOT_OPTIONS_COMBOAUTOTARGET     = "Auto Target"
HEALBOT_OPTIONS_COMBOAUTOTRINKET    = "Auto Trinket"
HEALBOT_OPTIONS_GROUPSPERCOLUMN     = "Grupos por Columna"

HEALBOT_OPTIONS_MAINSORT = "Ordenar por"
HEALBOT_OPTIONS_SUBSORT = "Subordenar por"
HEALBOT_OPTIONS_SUBSORTINC = "Ordenar:"

HEALBOT_OPTIONS_HEALCOMMMETHOD      = "M\195\169todo HealComm:"
HEALBOT_OPTIONS_HEALCOMMUSELHC      = "Enable libHealComm"
HEALBOT_OPTIONS_HEALCOMMLHCNOTFOUND = "libHealComm not installed"
HEALBOT_OPTIONS_HEALCOMMINTERNAL1   = "Internal no verify (No Comms)"
HEALBOT_OPTIONS_HEALCOMMINTERNAL2   = "Internal verify cast (No Comms)"
HEALBOT_OPTIONS_HEALCOMMNOLHC       = "libHealComm is not embedded\n\nSome Incoming Heal sliders on this tab are not used"
HEALBOT_OPTIONS_HEALCOMMNOLHC2      = "libHealComm is not enabled but still embedded\nThe library is still sending Addon comms spam\n\nTo disable see disable_libHealComm.html in the Docs directory"


HEALBOT_OPTIONS_BUTTONCASTMETHOD = "Castear si el bot\195\179n se"
HEALBOT_OPTIONS_BUTTONCASTPRESSED = "Presiona"
HEALBOT_OPTIONS_BUTTONCASTRELEASED = "Libera"

HEALBOT_INFO_INCHEALINFO            = "== Informaci\195\179n de Sanaci\195\179n Entrante =="
HEALBOT_INFO_ADDONCPUUSAGE          = "== Uso de CPU del Addon en segundos =="
HEALBOT_INFO_ADDONCOMMUSAGE         = "== Uso de Comms del Addon =="
HEALBOT_WORD_HEALER                 = "Healer"
HEALBOT_WORD_VERSION                = "Version"
HEALBOT_WORD_CLIENT                 = "Cliente"
HEALBOT_WORD_ADDON                  = "Addon"
HEALBOT_INFO_CPUSECS                = "CPU Segs"
HEALBOT_INFO_MEMORYKB               = "Memoria KB"
HEALBOT_INFO_COMMS 		    = "Comms KB"

HEALBOT_OPTIONS_HEALCOMMINTERNAL3   = "Ultra low comms - no verify"
HEALBOT_OPTIONS_HEALCOMMINTERNAL4   = "Ultra low comms - verify cast"

HEALBOT_WORD_STAR                   = "Estrella"
HEALBOT_WORD_CIRCLE                 = "C\195\173rculo"
HEALBOT_WORD_DIAMOND                = "Diamante"
HEALBOT_WORD_TRIANGLE               = "Tri\195\161ngulo"
HEALBOT_WORD_MOON                   = "Luna"
HEALBOT_WORD_SQUARE                 = "Cuadrado"
HEALBOT_WORD_CROSS                  = "Cruz"
HEALBOT_WORD_SKULL                  = "Calavera"

HEALBOT_OPTIONS_ACCEPTSKINMSG       = "Aceptar skin [de HealBot]: "
HEALBOT_OPTIONS_ACCEPTSKINMSGFROM   = " de "
HEALBOT_OPTIONS_BUTTONSHARESKIN     = "Compartir con"

HEALBOT_CHAT_ADDONID                = "[HealBot]  "
HEALBOT_CHAT_NEWVERSION1            = "Hay disponible nueva versi\195\179n"
HEALBOT_CHAT_NEWVERSION2            = "en http://healbot.alturl.com"
HEALBOT_CHAT_SHARESKINERR1          = " Skin no encontrada para Compartir"
HEALBOT_CHAT_SHARESKINERR2          = " su versi\195\179n de HealBot es antigua para Compartir"
HEALBOT_CHAT_SHARESKINERR3          = " no encontrado para compartir Skin"
HEALBOT_CHAT_SHARESKINACPT          = "Compartir Skin aceptado de "
HEALBOT_CHAT_CONFIRMSKINDEFAULTS    = "Skins establecidas por defecto"
HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS  = "Debuffs personalizados restablecidos"
HEALBOT_CHAT_CHANGESKINERR1         = "Skin desconocida: /hb skin "
HEALBOT_CHAT_CHANGESKINERR2         = "Skins v\195\161lidas:  "
HEALBOT_CHAT_CONFIRMSPELLCOPY       = "Habilidades actuales copiadas en todas las spec"
HEALBOT_CHAT_UNKNOWNCMD             = "Comando desconocido: /hb "
HEALBOT_CHAT_ENABLED                = "Entrando en estado Habilitado"
HEALBOT_CHAT_DISABLED               = "Entrando en estado Deshabilitado"
HEALBOT_CHAT_SOFTRELOAD             = "Petici\195\179n de recarga de Healbot"
HEALBOT_CHAT_HARDRELOAD             = "Recarga de UI completada"
HEALBOT_CHAT_CONFIRMSPELLRESET      = "Habilidades restablecidas"
HEALBOT_CHAT_CONFIRMCURESRESET      = "Debuffs restablecidos"
HEALBOT_CHAT_CONFIRMBUFFSRESET      = "Buffs restablecidos"
HEALBOT_CHAT_POSSIBLEMISSINGMEDIA = "Imposible recibir todos los datos de la skin - Posiblemente falte SharedMedia Unable to receive all Skin settings - Possibly missing SharedMedia, see HealBot/Docs/readme.html for links"
HEALBOT_CHAT_MACROSOUNDON           = "Sonido no suprimido al usar auto trinkets"
HEALBOT_CHAT_MACROSOUNDOFF          = "Sonido suprimido al usar auto trinkets"
HEALBOT_CHAT_MACROERRORON           = "Errores no suprimidos al usar auto trinkets"
HEALBOT_CHAT_MACROERROROFF          = "Errores suprimidos al usar auto trinkets"
HEALBOT_CHAT_TITANON                = "Titan panel - actualizaciones on"
HEALBOT_CHAT_TITANOFF               = "Titan panel - actualizaciones off"
HEALBOT_CHAT_ACCEPTSKINON           = "Compartir skin - Se muestra un popup cuando alguien comparte una skin contigo"
HEALBOT_CHAT_ACCEPTSKINOFF          = "Compartir skin - Siempre se ignoran a los jugadores que comparten skins contigo"
HEALBOT_CHAT_USE10ON                = "Auto Trinket - Use10 on - Debes habilitar un auto trinkwt para que Use10 funcione"
HEALBOT_CHAT_USE10OFF               = "Auto Trinket - Use10 off"

HEALBOT_OPTIONS_SELFCASTS           = "S\195\179lo mis casteos"
HEALBOT_OPTIONS_HOTSHOWICON         = "Ver iconos"
HEALBOT_OPTIONS_ALLSPELLS           = "Todos los hechizos"
HEALBOT_OPTIONS_DOUBLEROW           = "Doble fila"
HEALBOT_OPTIONS_HOTBELOWBAR         = "Bajo la barra"
HEALBOT_OPTIONS_OTHERSPELLS         = "Otros hechizos"
HEALBOT_WORD_MACROS                 = "Macros"
HEALBOT_WORD_SELECT                 = "Seleccionar"
HEALBOT_OPTIONS_QUESTION            = "?"
HEALBOT_WORD_CANCEL                 = "Cancelar"
HEALBOT_WORD_COMMANDS               = "Comandos"
HEALBOT_OPTIONS_BARHEALTH3          = "como salud";
HEALBOT_SORTBY_ROLE                 = "Rol"
HEALBOT_WORD_DPS                    = "DPS"
HEALBOT_CHAT_TOPROLEERR             = " rol no v\195\161lido en este contexto - usa 'TANK', 'DPS' o 'HEALER'"
HEALBOT_CHAT_NEWTOPROLE             = "El top m\195\161s alto es "
HEALBOT_CHAT_SUBSORTPLAYER1         = "El jugador ser\195\161 el primero en el SubOrden"
HEALBOT_CHAT_SUBSORTPLAYER2         = "El jugador ser\195\161 ordenado normalmente en el SubOrden"
HEALBOT_OPTIONS_SHOWREADYCHECK      = "Ver Ready Check";
HEALBOT_OPTIONS_SUBSORTSELFFIRST    = "Yo primero"
HEALBOT_WORD_FILTER                 = "Filtro"
HEALBOT_OPTION_AGGROPCTBAR          = "Mover barra"
HEALBOT_OPTION_AGGROPCTTXT          = "Ver texto"
HEALBOT_OPTION_AGGROPCTTRACK        = "Ver porcentaje" 
HEALBOT_OPTIONS_ALERTAGGROLEVEL0    = "0 - baja amenaza y no tankea nada"
HEALBOT_OPTIONS_ALERTAGGROLEVEL1    = "1 - alta amenaza pero no tankea nada"
HEALBOT_OPTIONS_ALERTAGGROLEVEL2    = "2 - casi tankeando, segundo en amenaza"
HEALBOT_OPTIONS_ALERTAGGROLEVEL3    = "3 - primero en amenaza. tankeando"
HEALBOT_OPTIONS_AGGROALERT          = "Nivel de alerta de aggro"
HEALBOT_OPTIONS_SETAGGROERROR1      = " Par\195\161metros no v\195\161lidos para establecer Aggro ..."
HEALBOT_OPTIONS_SETAGGRORESET       = " Reseteadas opciones de barra de Aggro"
HEALBOT_OPTIONS_SETAGGROERROR2      = " Establecer Aggro: fallo de opacidad min. Valores v\195\161lidos de 0 a 0.8"
HEALBOT_OPTIONS_SETAGGROERROR3      = " Establecer Aggro: fallo de opacidad min. El valor min es superior al max"
HEALBOT_OPTIONS_SETAGGROERROR4      = " Establecer Aggro: fallo de opacidad max. Valores v\195\161lidos de 0.2 a 1"
HEALBOT_OPTIONS_SETAGGROERROR5      = " Establecer Aggro: fallo de opacidad max. El valor max es menor que el min"
HEALBOT_OPTIONS_SETAGGROMIN         = " Opacidad min de aggro establecido a "
HEALBOT_OPTIONS_SETAGGROMAX         = " Opacidad max de aggro establecido a "
HEALBOT_OPTIONS_SETAGGROERROR6      = " Establecer aggro: fallo de frecuencia de parpadeo. Valores v\195\161lidos de 0.005 a 0.2"
HEALBOT_OPTIONS_SETAGGROFLASH       = " Frecuencia de parpadeo de aggro establecido en "
HEALBOT_OPTIONS_SETAGGROERROR7      = " Establecer Aggro: fallo de opacidad. Usa 'Min' o 'Max'"
HEALBOT_OPTIONS_SETAGGROERROR8      = " Estado de aggro no v\195\161lido - Use 'Low', 'High' o 'Has'"
HEALBOT_OPTIONS_SETAGGROERROR9      = " Fallo en columnas de aggro - Azul no entre 0 y 1"
HEALBOT_OPTIONS_SETAGGROERROR10     = " Fallo en columnas de aggro - Verde no entre 0 y 1"
HEALBOT_OPTIONS_SETAGGROERROR11     = " Fallo en columnas de aggro - Rojo no entre 0 y 1"
HEALBOT_OPTIONS_SETAGGROCOL         = " Columnas de Aggro establecidas a "
HEALBOT_OPTIONS_TOOLTIPSHOWHOT      = "Mostrar detalles de HOT activos monitorizados"
HEALBOT_OPTIONS_SETAGGROFLASHCUR    = " Frecuencia de parpadeo de aggro="
HEALBOT_OPTIONS_SETAGGROALPHACUR    = " Opacidad de aggro "
HEALBOT_OPTIONS_SETAGGROCOLLOW      = " Columnas de aggro baja amenaza (1) "
HEALBOT_OPTIONS_SETAGGROCOLHIGH     = " Columnas de aggro alta amenaza (2) "
HEALBOT_OPTIONS_SETAGGROCOLHAS      = " Columnas de aggro tiene aggro (3) "
HEALBOT_WORDS_MIN                   = "min"
HEALBOT_WORDS_MAX                   = "max"
HEALBOT_WORDS_R                     = "R"
HEALBOT_WORDS_G                     = "G"
HEALBOT_WORDS_B                     = "B"
HEALBOT_CHAT_SELFPETSON             = "AutoMascota activado"
HEALBOT_CHAT_SELFPETSOFF             = "AutoMascota desactivado"

HEALBOT_OPTIONS_TAB_WARNING = "Aviso"
HEALBOT_WORD_PRIORITY = "Prioridad"
HEALBOT_VISIBLE_RANGE = "Dentro de 100 metros"
HEALBOT_SPELL_RANGE = "Dentro del rango del hechizo"

end


