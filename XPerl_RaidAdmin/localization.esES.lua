--[[
Translation by Hastings
]]

if (GetLocale() == "esES") then

XPERL_ADMIN_TITLE	= "X-Perl Administración de banda"

XPERL_MSG_PREFIX	= "|c00C05050X-Perl|r "
XPERL_COMMS_PREFIX	= "X-Perl"

-- Raid Admin
XPERL_BUTTON_ADMIN_PIN		= "Clavar ventana"
XPERL_BUTTON_ADMIN_LOCKOPEN	= "Bloquear ventana abierta"
XPERL_BUTTON_ADMIN_SAVE1	= "Guardar plantilla"
XPERL_BUTTON_ADMIN_SAVE2	= "Guarda el diseño de la plantilla actual con el nombre especificado. Si no se indica ninguno, se utilizará la hora actual"
XPERL_BUTTON_ADMIN_LOAD1	= "Cargar plantilla"
XPERL_BUTTON_ADMIN_LOAD2	= "Cargar la plantilla seleccionada. Cualquier miembro de la banda, que estuviera en la plantilla, y no esté ahora, será reemplazado por un miembro de la misma clase que no esté guardado en la plantilla"
XPERL_BUTTON_ADMIN_DELETE1	= "Borrar plantilla"
XPERL_BUTTON_ADMIN_DELETE2	= "Borrar la plantilla seleccionada"
XPERL_BUTTON_ADMIN_STOPLOAD1	= "Detener carga"
XPERL_BUTTON_ADMIN_STOPLOAD2	= "Aborta el proceso de carga de la plantilla"

XPERL_LOAD			= "Cargar"

XPERL_SAVED_ROSTER		= "Plantilla guardada llamada '%s'"
XPERL_ADMIN_DIFFERENCES		= "%d diferencias con la plantilla actual"
XPERL_NO_ROSTER_NAME_GIVEN	= "No se ha dado nombre para la plantilla"
XPERL_NO_ROSTER_CALLED		= "No hay ninguna plantilla guardad con el nombre '%s'"

-- Item Checker
XPERL_CHECK_TITLE		= "X-Perl Comprobador de objetos"

XPERL_RAID_TOOLTIP_NOCTRA	= "No se ha encontrado CTRA"
XPERL_CHECK_NAME		= "Nombre"

XPERL_CHECK_DROPITEMTIP1	= "Arrastrar objetos"
XPERL_CHECK_DROPITEMTIP2	= "Los objetos pueden ser arrastrados a este marco para añadirlos a la lista de objetos a comprobar.\rTambién puede usar el comando /raitem normalmente y los objetos se añadirán aquí y se usarán en el futuro."
XPERL_CHECK_QUERY_DESC1		= "Comprobar"
XPERL_CHECK_QUERY_DESC2		= "Ejecuta la comprobación de objetos (/raitem) en todos los objetos seleccionados\rLa comprobación siempre obtiene la durabilidad actual, resistencia e información de ingredientes"
XPERL_CHECK_LAST_DESC1		= "Último"
XPERL_CHECK_LAST_DESC2		= "Re-marcar los objetos de la última búsqueda"
XPERL_CHECK_ALL_DESC1		= ALL
XPERL_CHECK_ALL_DESC2		= "Marcar todos los objetos"
XPERL_CHECK_NONE_DESC1		= NONE
XPERL_CHECK_NONE_DESC2		= "Desmarcar todos los objetos"
XPERL_CHECK_DELETE_DESC1	= DELETE
XPERL_CHECK_DELETE_DESC2	= "Eliminar permanentemente todos los objetos seleccionados de la lista"
XPERL_CHECK_REPORT_DESC1	= "Reporte"
XPERL_CHECK_REPORT_DESC2	= "Mostrar reporte de los resultados seleccionados en el chat de banda"
XPERL_CHECK_REPORT_WITH_DESC1	= "Con"
XPERL_CHECK_REPORT_WITH_DESC2	= "Reportar gente con el objeto (o que no lo tengan equipado) al chat de banda. Si se ha hecho un escaneo de equipo, se mostrarán estos resultados en su lugar."
XPERL_CHECK_REPORT_WITHOUT_DESC1= "Sin"
XPERL_CHECK_REPORT_WITHOUT_DESC2= "Reportar gente sin el objeto (o que lo tengan equipado) al chat de banda."
XPERL_CHECK_SCAN_DESC1		= "Escanear"
XPERL_CHECK_SCAN_DESC2		= "Comprobará a todos en el rango de inspección, para ver si llevan el objeto seleccionado equipado, e indicarlo en la lista de jugadores. Moverse más cerca (10 metros) de la gente fuera de rango hasta que toda la banda haya sido comprobada."
XPERL_CHECK_SCANSTOP_DESC1	= "Detener escaneo"
XPERL_CHECK_SCANSTOP_DESC2	= "Detener el escaneo del equipo de los jugadores para el objeto seleccionado"
XPERL_CHECK_REPORTPLAYER_DESC1	= "Reportar jugador"
XPERL_CHECK_REPORTPLAYER_DESC2	= "Reportar detalles de los jugadores seleccionados sobre este objeto o estado al chat de banda"

XPERL_CHECK_BROKEN		= "Rotos"
XPERL_CHECK_REPORT_DURABILITY	= "Durabilidad media de la banda: %d%% y %d personas con un total de de %d objetos rotos"
XPERL_CHECK_REPORT_PDURABILITY	= "Durabilidad de %s: %d%% con %d objetos rotos"
XPERL_CHECK_REPORT_RESISTS	= "Resistencias medias de la banda: %d "..SPELL_SCHOOL2_CAP..", %d "..SPELL_SCHOOL3_CAP..", %d "..SPELL_SCHOOL4_CAP..", %d "..SPELL_SCHOOL5_CAP..", %d "..SPELL_SCHOOL6_CAP
XPERL_CHECK_REPORT_PRESISTS	= "Resistencias de %s: %d "..SPELL_SCHOOL2_CAP..", %d "..SPELL_SCHOOL3_CAP..", %d "..SPELL_SCHOOL4_CAP..", %d "..SPELL_SCHOOL5_CAP..", %d "..SPELL_SCHOOL6_CAP
XPERL_CHECK_REPORT_WITH		= " - con: "
XPERL_CHECK_REPORT_WITHOUT	= " - sin: "
XPERL_CHECK_REPORT_WITH_EQ	= " - con (o no equipado): "
XPERL_CHECK_REPORT_WITHOUT_EQ	= " - sin (o equipado): "
XPERL_CHECK_REPORT_EQUIPED	= " : equipado: "
XPERL_CHECK_REPORT_NOTEQUIPED	= " : NO equipado: "
XPERL_CHECK_REPORT_ALLEQUIPED	= "Todos tienen %s equipado/a"
XPERL_CHECK_REPORT_ALLEQUIPEDOFF= "Todos tienen %s equipado/a, pero %d miembro(s) está(n) desconectado(s)"
XPERL_CHECK_REPORT_PITEM	= "%s tiene %d %s en el inventario"
XPERL_CHECK_REPORT_PEQUIPED	= "%s tiene %s equipado/a"
XPERL_CHECK_REPORT_PNOTEQUIPED	= "%s NO tiene %s equipado/a"
XPERL_CHECK_REPORT_DROPDOWN	= "Canal de salida"
XPERL_CHECK_REPORT_DROPDOWN_DESC= "Seleccionar el canal de salida para el comprobador de objetos"

XPERL_CHECK_REPORT_WITHSHORT	= " : %d con"
XPERL_CHECK_REPORT_WITHOUTSHORT	= " : %d sin"
XPERL_CHECK_REPORT_EQUIPEDSHORT	= " : %d equipado/a"
XPERL_CHECK_REPORT_NOTEQUIPEDSHORT	= " : %d NO equipado/a"
XPERL_CHECK_REPORT_OFFLINE	= " : %d desconectado(s)"
XPERL_CHECK_REPORT_TOTAL	= " : %d Objeto(s) Total(es)"
XPERL_CHECK_REPORT_NOTSCANNED	= " : %d deseleccionado(s)"

XPERL_CHECK_LASTINFO		= "Últimos datos recibidos %sago"

XPERL_CHECK_AVERAGE		= "Media"
XPERL_CHECK_TOTALS		= "Total"
XPERL_CHECK_EQUIPED		= "Equipado"

XPERL_CHECK_SCAN_MISSING	= "Escaneando jugadores en rango para el objeto. (%d no escaneados)"

XPERL_REAGENTS			= {PRIEST = "Vela sacra", MAGE = "Partículas Arcanas", DRUID = "Raíz de espina salvaje",
					SHAMAN = "Ankh", WARLOCK = "Fragmento de alma", PALADIN = "Símbolo de Divinidad",
					ROGUE = "Partículas explosivas"}

XPERL_CHECK_REAGENTS		= "Componentes"

-- Roster Text
XPERL_ROSTERTEXT_TITLE		= XPerl_ShortProductName.." Texto Lista"
XPERL_ROSTERTEXT_GROUP		= "Grupo %d"
XPERL_ROSTERTEXT_GROUP_DESC	= "Utilizar nombres del grupo %d"
XPERL_ROSTERTEXT_SAMEZONE	= "Solo Misma Zona"
XPERL_ROSTERTEXT_SAMEZONE_DESC	= "Solo incluir nombres de jugadores que estén en la misma zona que tú"
XPERL_ROSTERTEXT_HELP		= "Pulsa Ctrl-C para copiar el texto en el portapapeles"
XPERL_ROSTERTEXT_TOTAL		= "Total: %d"
XPERL_ROSTERTEXT_SETN		= "%d Hombres"
XPERL_ROSTERTEXT_SETN_DESC	= "Auto-selecciona los grupos para banda de  %d hombres"
XPERL_ROSTERTEXT_TOGGLE		= "Alternar"
XPERL_ROSTERTEXT_TOGGLE_DESC	= "Alternar grupos seleccionados"
XPERL_ROSTERTEXT_SORT		= "Ordenar"
XPERL_ROSTERTEXT_SORT_DESC	= "Ordenar por nombre en lugar de grupo+nombre"
end
