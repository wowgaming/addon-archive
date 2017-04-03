-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

if (GetLocale() == "esES" or GetLocale() == "esMX") then

	-- Thanks Hastings for translations
	XPerl_LongDescription	= "Reemplazo para los marcos de unidades, con nuevo aspecto para Jugador, Mascota, Grupo, Objetivo, Objetivo del Objetivo, Foco y Banda"

	XPERL_MINIMAP_HELP1 = "|c00FFFFFFClick izquierdo|r para Opciones (y para |c0000FF00desbloquear los marcos|r)"
	XPERL_MINIMAP_HELP2 = "|c00FFFFFFClick derecho|r para mover este icono"
	XPERL_MINIMAP_HELP3 = "\rMiembros de la Banda: |c00FFFF80%d|r\rMiembros del Grupo: |c00FFFF80%d|r"
	XPERL_MINIMAP_HELP4 = "\rEres el lider del grupo/raid"
	XPERL_MINIMAP_HELP5 = "|c00FFFFFFAlt|r para ver el uso de memoria de X-Perl"
	XPERL_MINIMAP_HELP6 = "|c00FFFFFF+Shift|r para ver el uso de memoria de X-Perl desde el inicio"

	XPERL_MINIMENU_OPTIONS	= "Opciones"
	XPERL_MINIMENU_ASSIST	= "Mostrar el Asistente de Marco"
	XPERL_MINIMENU_CASTMON	= "Mostrar Monitor de Casteo"
	XPERL_MINIMENU_RAIDAD	= "Mostrar Admin Banda"
	XPERL_MINIMENU_ITEMCHK	= "Mostrar Comprobador Elementos"
	XPERL_MINIMENU_RAIDBUFF = "Buffs Banda"
	XPERL_MINIMENU_ROSTERTEXT="Lista Texto"
	XPERL_MINIMENU_RAIDSORT = "Orden Banda"
	XPERL_MINIMENU_RAIDSORT_GROUP = "Ordenar por Grupo"
	XPERL_MINIMENU_RAIDSORT_CLASS = "Ordenar por Clase"

	XPERL_TYPE_NOT_SPECIFIED = "No indicado"
	XPERL_TYPE_PET		= "Mascota"
	XPERL_TYPE_BOSS 	= "Jefe"
	XPERL_TYPE_RAREPLUS 	= "Raro+"
	XPERL_TYPE_ELITE	= "\195\137lite"
	XPERL_TYPE_RARE 	= "Raro"

	XPERL_LOC_ZONE_SERPENTSHRINE_CAVERN = "Caverna Santuario Serpiente"
	XPERL_LOC_ZONE_BLACK_TEMPLE = "El Templo Oscuro"
	XPERL_LOC_ZONE_HYJAL_SUMMIT = "Cima Hyjal"
	XPERL_LOC_ZONE_KARAZHAN = "Karazhan"
	XPERL_LOC_ZONE_SUNWELL_PLATEAU = "Meseta de la Fuente del Sol"
	XPERL_LOC_ZONE_ULDUAR = "Ulduar"
	XPERL_LOC_ZONE_TRIAL_OF_THE_CRUSADER = "Prueba del Cruzado"
	XPERL_LOC_ZONE_ICECROWN_CITADEL = "Ciudadela de la Corona de Hielo"
	XPERL_LOC_ZONE_RUBY_SANCTUM = "El Sagrario Rubí"

	-- Status
	XPERL_LOC_DEAD		= "Muerto"
	XPERL_LOC_GHOST 	= "Fantasma"
	XPERL_LOC_FEIGNDEATH	= "Fingir muerte"
	XPERL_LOC_OFFLINE	= "Desconectado"
	XPERL_LOC_RESURRECTED	= "Resucitado"
	XPERL_LOC_SS_AVAILABLE	= "PA disponible"
	XPERL_LOC_UPDATING	= "Actualizando"
	XPERL_LOC_ACCEPTEDRES	= "Aceptado"	-- Res accepted
	XPERL_RAID_GROUP	= "Grupo %d"
	XPERL_RAID_GROUPSHORT	= "G%d"

	XPERL_LOC_NONEWATCHED	= "Ninguno mirado"

	XPERL_LOC_STATUSTIP = "Condici\195\179n Destacados: " 	-- Tooltip explanation of status highlight on unit
	XPERL_LOC_STATUSTIPLIST = {
		HOT = "Sanaci\195\179n en el Tiempo",
		AGGRO = "Agresivo",
		MISSING = "Perdiendo tus buffs de clase",
		HEAL = "Siendo sanado",
		SHIELD = "Blindado"
	}

	XPERL_OK	= "Vale"
	XPERL_CANCEL	= "Cancelar"

	XPERL_LOC_LARGENUMDIV	= 1000
	XPERL_LOC_LARGENUMTAG	= "K"

	BINDING_HEADER_XPERL = "X-Perl enlaces de teclas"
	BINDING_NAME_TOGGLERAID = "Mostrar ventanas de bandas"
	BINDING_NAME_TOGGLERAIDSORT = "Mostrar orden de banda por Clase/Grupo"
	BINDING_NAME_TOGGLERAIDPETS = "Alternar Mascotas de Banda"
	BINDING_NAME_TOGGLEOPTIONS = "Mostrar ventana de opciones"
	BINDING_NAME_TOGGLEBUFFTYPE = "Mostrar Ventajas/Desventajas/Nada"
	BINDING_NAME_TOGGLEBUFFCASTABLE = "Mostrar Disponibles/Curables"
	BINDING_NAME_TEAMSPEAKMONITOR = "Monitor de Teamspeak"
	BINDING_NAME_TOGGLERANGEFINDER = "Alternar Buscador Rango"

	XPERL_KEY_NOTICE_RAID_BUFFANY = "Mostrar ventajas/desventajas"
	XPERL_KEY_NOTICE_RAID_BUFFCURECAST = "Mostrar s\195\179lo ventajas/desventajas disponibles/curables"
	XPERL_KEY_NOTICE_RAID_BUFFS = "Las ventajas de la banda se muestran"
	XPERL_KEY_NOTICE_RAID_DEBUFFS = "Las desventajas de la banda est\195\161n ocultas"
	XPERL_KEY_NOTICE_RAID_NOBUFFS = "No se muestran ventajas de banda"

	XPERL_DRAGHINT1	= "|c00FFFFFFClick|r para escalar ventana"
	XPERL_DRAGHINT2	= "|c00FFFFFFShift+Click|r para redimensionar ventana"

	-- Usage
	XPerlUsageNameList	= {XPerl = "N\195\186cleo", XPerl_Player = "Jugador", XPerl_PlayerPet = "Mascota", XPerl_Target = "Objetivo", XPerl_TargetTarget = "Objetivo de Objetivo", XPerl_Party = "Grupo", XPerl_PartyPet = "Mascotas Grupo", XPerl_RaidFrames = "Marcos Banda", XPerl_RaidHelper = "Ayudante Banda", XPerl_RaidAdmin = "Admin Banda", XPerl_TeamSpeak = "Monitor TS", XPerl_RaidMonitor = "Monitor Banda", XPerl_RaidPets = "Mascotas Banda", XPerl_ArcaneBar = "Barra Arcana", XPerl_PlayerBuffs = "Buffs Jugador", XPerl_GrimReaper = "Grim Reaper"}
	XPERL_USAGE_MEMMAX	= "UI Mem Max: %d"
	XPERL_USAGE_MODULES 	= "M\195\179dulos: "
	XPERL_USAGE_NEWVERSION	= "*Nueva versi\195\179n"
	XPERL_USAGE_AVAILABLE	= "%s |c00FFFFFF%s|r est\195\161 disponible para descarga"

	XPERL_CMD_MENU		= "men\195\186"
	XPERL_CMD_OPTIONS	= "opciones"
	XPERL_CMD_LOCK		= "bloquear"
	XPERL_CMD_UNLOCK	= "desbloquear"
	XPERL_CMD_CONFIG	= "configurar"
	XPERL_CMD_LIST		= "listar"
	XPERL_CMD_DELETE	= "eliminar"
	XPERL_CMD_HELP		= "|c00FFFF80Usar: |c00FFFFFF/xperl menu | lock | unlock | config list | config delete <realm> <name>"
	XPERL_CANNOT_DELETE_CURRENT 	= "No puedes eliminar tu configuraci\195\179n actual"
	XPERL_CONFIG_DELETED		= "Eliminada configuraci\195\179n para %s/%s"
	XPERL_CANNOT_FIND_DELETE_TARGET = "No puedo encontrar configuraci\195\179n a borrar (%s/%s)"
	XPERL_CANNOT_DELETE_BADARGS 	= "Por favor dame un nombre de realm y otro de jugador"
	XPERL_CONFIG_LIST		= "Lista Configuraci\195\179n:"
	XPERL_CONFIG_CURRENT		= " (Actual)"

	XPERL_RAID_TOOLTIP_WITHBUFF	= "Con ventaja: (%s)"
	XPERL_RAID_TOOLTIP_WITHOUTBUFF	= "Sin ventaja: (%s)"
	XPERL_RAID_TOOLTIP_BUFFEXPIRING	= "%s ha usado la %s que expira en %s"	-- Name, buff name, time to expire
end
