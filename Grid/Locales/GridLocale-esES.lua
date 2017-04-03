--[[--------------------------------------------------------------------
	GridLocale-esES.lua
	Spanish (Español - EU) localization for Grid.
----------------------------------------------------------------------]]

if GetLocale() ~= "esES" then return end
local _, ns = ...
ns.L = {

--{{{ GridCore
	["Debugging"] = "Debugging",
	["Module debugging menu."] = "Menú de debugging del módulo",
	["Debug"] = "Debug",
	["Toggle debugging for %s."] = "Activar debugging para %s",
	["Configure"] = "Configurar",
	["Configure Grid"] = "Configurar Grid",
	["Hide minimap icon"] = "Ocultar icono del minimapa",
	["Grid is disabled: use '/grid standby' to enable."] = "Grid está desactivado: usa '/grid standby' para activarlo.",
--	["Enable dual profile"] = "",
--	["Automatically swap profiles when switching talent specs."] = "",
--	["Dual profile"] = "",
--	["Select the profile to swap with the current profile when switching talent specs."] = "",
--}}}

--{{{ GridFrame
	["Frame"] = "Celda",
	["Options for GridFrame."] = "Opciones para celdas de Grid",

	["Show Tooltip"] = "Mostrar tooltip",
	["Show unit tooltip.  Choose 'Always', 'Never', or 'OOC'."] = "Mostrar tooltip de unidad. Elige 'Siempre', 'Nunca' o 'FDC'.",
	["Always"] = "Siempre",
	["Never"] = "Nunca",
	["OOC"] = "FDC",
	["Center Text Length"] = "Longitud de texto central",
	["Number of characters to show on Center Text indicator."] = "Número de caracteres para mostrar en el indicador de texto central",
	["Invert Bar Color"] = "Invertir el color de la barra",
	["Swap foreground/background colors on bars."] = "Cambia los colores de primer plano y fondo",
	["Healing Bar Opacity"] = "Opacidad de la barra de sanación",
	["Sets the opacity of the healing bar."] = "Establece la opacidad de la barra de sanación.",

	["Indicators"] = "Indicadores",
	["Border"] = "Borde",
	["Health Bar"] = "Barra de salud",
	["Health Bar Color"] = "Color de la barra de salud",
	["Healing Bar"] = "Barra de sanación",
	["Center Text"] = "Texto central",
	["Center Text 2"] = "Texto central 2",
	["Center Icon"] = "Icono central",
	["Top Left Corner"] = "Esquina superior izquierda",
	["Top Right Corner"] = "Esquina superior derecha",
	["Bottom Left Corner"] = "Esquina inferior izquierda",
	["Bottom Right Corner"] = "Esquina inferior derecha",
	["Frame Alpha"] = "Transparencia de celda",

	["Options for %s indicator."] = "Opciones para el indicador %s",
	["Statuses"] = "Estados",
	["Toggle status display."] = "Activar visualización de estado",

	-- Advanced options
	["Advanced"] = "Avanzado",
	["Advanced options."] = "Opciones avanzadas.",
	["Enable %s indicator"] = "Activar indicador %s",
	["Toggle the %s indicator."] = "Activa/desactiva el indicador %s",
	["Frame Width"] = "Ancho de celda",
	["Adjust the width of each unit's frame."] = "Ajusta el ancho de cada celda de unidad",
	["Frame Height"] = "Altura de celda",
	["Adjust the height of each unit's frame."] = "Ajusta la altura de cada celdad de unidad",
	["Frame Texture"] = "Textura de celda",
	["Adjust the texture of each unit's frame."] = "Ajusta la textura de cada celda de unidad",
	["Border Size"] = "Tamaño en borde",
	["Adjust the size of the border indicators."] = "Ajusta el tamaño de los indicadores del borde.",
	["Corner Size"] = "Tamaño en esquina",
	["Adjust the size of the corner indicators."] = "Ajusta el tamaño de los indicadores de la esquina.",
	["Enable Mouseover Highlight"] = "Activar resaltar con ratón",
	["Toggle mouseover highlight."] = "Activa/desactiva resaltado con ratón",
	["Font"] = "Fuente",
	["Adjust the font settings"] = "Ajusta la configuración de fuente",
	["Font Size"] = "Tamaño de fuente",
	["Adjust the font size."] = "Ajusta el tamaño de la fuente.",
	["Font Outline"] = "Perfil de fuente",
	["Adjust the font outline."] = "Ajusta el perfil de fuente.",
	["None"] = "Ninguno",
	["Thin"] = "Fino",
	["Thick"] = "Grueso",
	["Orientation of Frame"] = "Orientación de la fuente",
	["Set frame orientation."] = "Establece la orientación de la fuente.",
	["Orientation of Text"] = "Orientación del texto",
	["Set frame text orientation."] = "Establece la orientación del texto.",
	["Vertical"] = "Vertical",
	["Horziontal"] = "Horizontal",
	["Icon Size"] = "Tamaño de icono",
	["Adjust the size of the center icon."] = "Ajusta el tamaño del icono central.",
	["Icon Border Size"] = "Tamaño del borde del icono",
	["Adjust the size of the center icon's border."] = "Ajusta el tamaño del borde del icono central.",
	["Icon Stack Text"] = "Texto de dosis en icono",
	["Toggle center icon's stack count text."] = "Activa/desactiva el texto de contador del icono central.",
	["Icon Cooldown Frame"] = "Cooldown en icono central",
	["Toggle center icon's cooldown frame."] = "Activa/desactiva el cooldown en el icono central.",
--}}}

--{{{ GridLayout
	["Layout"] = "Diseño",
	["Options for GridLayout."] = "Opciones de Diseño de Grid.",

	["Drag this tab to move Grid."] = "Arrastra esta pestaña para mover Grid.",
	["Lock Grid to hide this tab."] = "Bloquea Grid para ocultar esta pestaña.",
	["Alt-Click to permanantly hide this tab."] = "Alt-Click para ocultar permanentemente esta ventana.",

	-- Layout options
	["Show Frame"] = "Mostrar celda",

	["Solo Layout"] = "Diseño - Solo",
	["Select which layout to use when not in a party."] = "Selecciona qué diseño quieres usar cuando no estás en grupo.",
	["Party Layout"] = "Diseño - Grupo",
	["Select which layout to use when in a party."] = "Selecciona qué diseño quieres usar cuando estás en grupo.",
	["25 Player Raid Layout"] = "Diseño - Banda 25 jugadores",
	["Select which layout to use when in a 25 player raid."] = "Selecciona qué diseño quieres usar cuando estás en banda de 25 jugadores.",
	["10 Player Raid Layout"] = "Diseño - Banda 10 jugadores",
	["Select which layout to use when in a 10 player raid."] = "Selecciona qué diseño quieres usar cuando estás en banda de 10 jugadores.",
	["Battleground Layout"] = "Diseño - Campo de Batalla",
	["Select which layout to use when in a battleground."] = "Selecciona qué diseño quieres usar cuando estás en campo de batalla.",
	["Arena Layout"] = "Diseño - Arena",
	["Select which layout to use when in an arena."] = "Selecciona qué diseño quieres usar cuando estás en arena.",
	["Horizontal groups"] = "Grupos horizontales",
	["Switch between horzontal/vertical groups."] = "Cambia entre grupos horizontales/verticales",
	["Clamped to screen"] = "Bloqueado a la pantalla",
	["Toggle whether to permit movement out of screen."] = "Permite o no, moverlo fuera de la pantalla.",
	["Frame lock"] = "Bloquear celdas",
	["Locks/unlocks the grid for movement."] = "Bloquea/desbloquea el movimiento de Grid.",
	["Click through the Grid Frame"] = "Click a través de Grid",
	["Allows mouse click through the Grid Frame."] = "Permite hacer click a través de la ventana de Grid.",

	["Center"] = "Centro",
	["Top"] = "Arriba",
	["Bottom"] = "Abajo",
	["Left"] = "Izquierda",
	["Right"] = "Derecha",
	["Top Left"] = "Superior-Izquierda",
	["Top Right"] = "Superior-Derecha",
	["Bottom Left"] = "Inferior-Izquierda",
	["Bottom Right"] = "Inferior-Derecha",

	-- Display options
	["Padding"] = "Relleno",
	["Adjust frame padding."] = "Ajusta el relleno de celdas.",
	["Spacing"] = "Espaciamiento",
	["Adjust frame spacing."] = "Ajusta el espaciamiento de celdas.",
	["Scale"] = "Escala",
	["Adjust Grid scale."] = "Ajusta la escala de Grid.",
	["Border"] = "Borde",
	["Adjust border color and alpha."] = "Ajusta el color de borde y la transparencia.",
	["Border Texture"] = "Textura del borde",
	["Choose the layout border texture."] = "Escoge el diseño de textura del borde.",
	["Background"] = "Fondo",
	["Adjust background color and alpha."] = "Ajusta el color de fondo y el Alfa",
	["Pet color"] = "Color de mascota",
	["Set the color of pet units."] = "Establece el color de las celdas de mascota.",
	["Pet coloring"] = "Coloreado de mascotas",
	["Set the coloring strategy of pet units."] = "Establece la regla de coloreado de mascotas:",
	["By Owner Class"] = "Por clase del propietario",
	["By Creature Type"] = "Por tipo de criatura",
	["Using Fallback color"] = "Usando el color alternativo",
	["Beast"] = "Bestia",
	["Demon"] = "Demonio",
	["Humanoid"] = "Humanoide",
	["Undead"] = "No muerto",
	["Dragonkin"] = "Dragonante",
	["Elemental"] = "Elemental",
	["Not specified"] = "No especificado",
	["Colors"] = "Colores",
	["Color options for class and pets."] = "Opciones de color para clases y mascotas.",
	["Fallback colors"] = "Colores alternativos",
	["Color of unknown units or pets."] = "Color de mascotas o unidades desconocidas.",
	["Unknown Unit"] = "Unidad desconocida",
	["The color of unknown units."] = "El color de unidades desconocidas.",
	["Unknown Pet"] = "Mascota desconocida",
	["The color of unknown pets."] = "El color de mascotas desconocidas.",
	["Class colors"] = "Colores de clases",
	["Color of player unit classes."] = "Color de las clases del jugador.",
	["Creature type colors"] = "Color de tipo de criatura",
	["Color of pet unit creature types."] = "Color del tipo de criatura de la mascota.",
	["Color for %s."] = "Color para %s",

	-- Advanced options
	["Advanced"] = "Avanzado",
	["Advanced options."] = "Opciones avanzadas",
	["Layout Anchor"] = "Ancla de ventana",
	["Sets where Grid is anchored relative to the screen."] = "Establece dónde se ancla grid relativo a la pantalla",
	["Group Anchor"] = "Ancla de grupo",
	["Sets where groups are anchored relative to the layout frame."] = "Establece donde se anclan los grupos relativos a la ventana",
	["Reset Position"] = "Restaurar posición",
	["Resets the layout frame's position and anchor."] = "Restaura la posición y el ancla de la ventana.",
	["Hide tab"] = "Ocultar pestaña",
	["Do not show the tab when Grid is unlocked."] = "No mostrar la pestaña cuando Grid está desbloqueado",
--}}}

--{{{ GridLayoutLayouts
	["None"] = "Ninguno",
	["By Group 5"] = "Grupo de 5",
	["By Group 5 w/Pets"] = "Grupo de 5 con mascotas",
	["By Group 10"] = "Grupo de 10",
	["By Group 10 w/Pets"] = "Grupo de 10 con mascotas",
	["By Group 15"] = "Grupo de 15",
	["By Group 15 w/Pets"] = "Grupo de 15 con mascotas",
	["By Group 25"] = "Grupo de 25",
	["By Group 25 w/Pets"] = "Grupo de 25 con mascotas",
	["By Group 25 w/Tanks"] = "Grupo de 25 con tanques",
	["By Group 40"] = "Grupo de 40",
	["By Group 40 w/Pets"] = "Grupo de 40 con mascotas",
	["By Class 10 w/Pets"] = "Grupo de 10 por clases",
	["By Class 25 w/Pets"] = "Grupo de 25 por clases",
--}}}

--{{{ GridLDB
	["Click to open the options in a GUI window."] = "Click para abrir las opciones en una ventana GUI",
	["Right-Click to open the options in a drop-down menu."] = "Click derecho para abrir las opciones en un menú desplegable",
--}}}

--{{{ GridRange
	-- used for getting spell range from tooltip
	["(%d+) yd range"] = "Alcance de (%d+) m",
--}}}

--{{{ GridStatus
	["Status"] = "Estado",
	["Options for %s."] = "Opciones para %s",
	["Reset class colors"] = "Restaurar colores de clase",
	["Reset class colors to defaults."] = "Restaura los colores de clase a unos por defecto.",

	-- module prototype
	["Status: %s"] = "Estado: %s",
	["Color"] = "Color",
	["Color for %s"] = "Color para %s",
	["Priority"] = "Prioridad",
	["Priority for %s"] = "Prioridad para %s",
	["Range filter"] = "Filtro de rango",
	["Range filter for %s"] = "Filtro de rango para %s",
	["Enable"] = "Activar",
	["Enable %s"] = "Activar %s",
--}}}

--{{{ GridStatusAggro
	["Aggro"] = "Amenaza",
	["Aggro alert"] = "Alerta de amenaza",
	["High Threat color"] = "Color de gran amenaza",
	["Color for High Threat."] = "Color para gran amenaza.",
	["Aggro color"] = "Color de amenaza",
	["Color for Aggro."] = "Color para amenaza.",
	["Tanking color"] = "Color de tanque",
	["Color for Tanking."] = "Color para tanques",
	["Threat"] = "Amenaza",
	["Show more detailed threat levels."] = "Muestra niveles de amenaza más detallados",
	["High"] = "Alto",
	["Tank"] = "Tanque",
--}}}

--{{{ GridStatusAuras
	["Auras"] = "Aura",
	["Debuff type: %s"] = "Tipo de debuff: %s",
	["Poison"] = "Veneno",
	["Disease"] = "Enfermedad",
	["Magic"] = "Magia",
	["Curse"] = "Maldición",
	["Ghost"] = "Fantasma",
	["Buffs"] = "Buffos",
	["Debuff Types"] = "Tipos de Debuff",
	["Debuffs"] = "Debuffs",
	["Add new Buff"] = "Añadir nuevo bufo",
	["Adds a new buff to the status module"] = "Añade un nuevo bufo al módulo de estado",
	["<buff name>"] = "<nombre del bufo>",
	["Add new Debuff"] = "Añade un nuevo debuff",
	["Adds a new debuff to the status module"] = "Añade un nuevo bufo al módulo de estado",
	["<debuff name>"] = "<nombre del debuff>",
	["Delete (De)buff"] = "Borrar (De)buff",
	["Deletes an existing debuff from the status module"] = "Borra un debuff existente del módulo de estado",
	["Remove %s from the menu"] = "Elimina %s del menú",
	["Debuff: %s"] = "Debuff: %s",
	["Buff: %s"] = "Bufo: %s",
	["Class Filter"] = "Filtro de Clases",
	["Show status for the selected classes."] = "Muestra el estado para las clases seleccionadas.",
	["Show on %s."] = "Mostrar en %s.",
	["Show if mine"] = "Mostrar si es mío",
	["Display status only if the buff was cast by you."] = "Muestra el estado sólo si el bufo fue lanzado por ti",
	["Show if missing"] = "Mostrar si falta",
	["Display status only if the buff is not active."] = "Mostrar estado sólo si el bufo no está activo",
	["Filter Abolished units"] = "Filtrar unidades eliminadas",
	["Skip units that have an active Abolish buff."] = "Se salta las unidades que tienen un bufo activo de Suprimir",
	["Show duration"] = "Mostrar duración",
	["Show the time remaining, for use with the center icon cooldown."] = "Muestra el tiempo restante, para usar con el icono de cooldown central",
--}}}

--{{{ GridStatusHeals
	["Heals"] = "Sanación",
	["Incoming heals"] = "Sanaciones entrantes",
	["Ignore Self"] = "Ignorar las propias",
	["Ignore heals cast by you."] = "Ignora las sanaciones lanzadas por ti.",
	["Heal filter"] = "Filtro de sanaciones",
	["Show incoming heals for the selected heal types."] = "Muestra las sanaciones entrantes para los siguientes tipos seleccionadas.",
	["Direct heals"] = "Sanaciones directas",
	["Include direct heals."] = "Incluye las sanaciones directas.",
	["Channeled heals"] = "Sanaciones canalizadas",
	["Include channeled heals."] = "Incluye sanaciones canalizadas.",
	["HoT heals"] = "Sanaciones en el tiempo",
	["Include heal over time effects."] = "Incluye efectos de sanación en el tiempo",
--}}}

--{{{ GridStatusHealth
	["Low HP"] = "Poca vida",
	["DEAD"] = "Muerto",
	["FD"] = "FM",
	["Offline"] = "Desconectado",
	["Unit health"] = "Salud de la unidad",
	["Health deficit"] = "Falta de salud",
	["Low HP warning"] = "Alerta de salud baja",
	["Feign Death warning"] = "Alerta de Fingir Muerte",
	["Death warning"] = "Alerta de muerte",
	["Offline warning"] = "Alerta de desconectado",
	["Health"] = "Salud",
	["Show dead as full health"] = "Mostrar muerto como vida completa",
	["Treat dead units as being full health."] = "Trata las unidades muertas como si tuvieran la salud al completo",
	["Use class color"] = "Usar color de clase",
	["Color health based on class."] = "Color de la vida basado en la clase",
	["Health threshold"] = "Límite de salud",
	["Only show deficit above % damage."] = "Mostrar déficit sobre % de daño",
	["Color deficit based on class."] = "Mostrar déficit basado en clase",
	["Low HP threshold"] = "Límite de salud baja",
	["Set the HP % for the low HP warning."] = "Establece el % límite para la alerta de salud baja",
--}}}

--{{{ GridStatusMana
	["Mana"] = "Maná",
	["Low Mana"] = "Poco maná",
	["Mana threshold"] = "Límite de maná",
	["Set the percentage for the low mana warning."] = "Establece el porcentaje para la alerta de maná bajo",
	["Low Mana warning"] = "Alerta de maná bajo",
--}}}

--{{{ GridStatusName
	["Unit Name"] = "Nombre de unidad",
	["Color by class"] = "Color por clase",
--}}}

--{{{ GridStatusRange
	["Range"] = "Rango",
	["Range check frequency"] = "Frecuencia de revisión de rango",
	["Seconds between range checks"] = "Segundos entre revisión de rango",
	["More than %d yards away"] = "Más de %d metros",
	["%d yards"] = "%d metros",
	["Text"] = "Texto",
	["Text to display on text indicators"] = "Texto para mostrar en el indicador de texto",
	["<range>"] = "<rango>",
--}}}

--{{{ GridStatusReadyCheck
	["Ready Check"] = "Ready Check",
	["Set the delay until ready check results are cleared."] = "Establece el retraso hasta que los resultados del Ready Check se limpien",
	["Delay"] = "Retraso",
	["?"] = "?",
	["R"] = "R",
	["X"] = "X",
	["AFK"] = "AFK",
	["Waiting color"] = "Color de espera",
	["Color for Waiting."] = "Color para la espera.",
	["Ready color"] = "Color de preparado",
	["Color for Ready."] = "Color para el que está preparado.",
	["Not Ready color"] = "Color de no preparado",
	["Color for Not Ready."] = "Color para el que no está preparado.",
	["AFK color"] = "Color de AFK",
	["Color for AFK."] = "Color para AFK.",
--}}}

--{{{ GridStatusTarget
	["Target"] = "Objetivo",
	["Your Target"] = "Tu objetivo",
--}}}

--{{{ GridStatusVehicle
	["In Vehicle"] = "En vehículo",
	["Driving"] = "Conduciendo",
--}}}

--{{{ GridStatusVoiceComm
	["Voice Chat"] = "Chat de voz",
	["Talking"] = "Hablando",
--}}}

}