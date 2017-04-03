--[[---------------------------------------------------------------------------------
    Localisation for esES (Spanish)
----------------------------------------------------------------------------------]]

local L = Clique.Locals

-- This is the default locale.
if GetLocale() == "esES" then
	L.RANK                    = "Rango"
	L.RANK_PATTERN            = "Rango (%d+)"
	L.CAST_FORMAT             = "%s(Rango %s)"
	L.RACIAL_PASSIVE          = "Pasivo racial"
	L.PASSIVE                 = SPELL_PASSIVE	
	L.CLICKSET_DEFAULT        = "Por Defecto"
	L.CLICKSET_HARMFUL        = "Aciones de Daño"
	L.CLICKSET_HELPFUL        = "Acciones de Ayuda"
	L.CLICKSET_OOC            = "Fuera de Combate"
	L.CLICKSET_BEARFORM       = "Forma de Oso"
	L.CLICKSET_CATFORM        = "Forma Felina"
    L.CLICKSET_AQUATICFORM    = "Forma Acuática"
	L.CLICKSET_TRAVELFORM     = "Forma de Viaje"
	L.CLICKSET_MOONKINFORM    = "Forma de Moonkin"
	L.CLICKSET_TREEOFLIFE     = "Forma de Arbol de Vida"
	L.CLICKSET_SHADOWFORM     = "Forma de las Sombras"
	L.CLICKSET_STEALTHED      = "En Sigilo"
	L.CLICKSET_BATTLESTANCE   = "Actitud de Batalla"
	L.CLICKSET_DEFENSIVESTANCE = "Actitud Defensiva"
	L.CLICKSET_BERSERKERSTANCE = "Actitud Rabiosa"

	L.BEAR_FORM = "Forma de Oso"
	L.DIRE_BEAR_FORM = "Forma de Oso Temible"
	L.CAT_FORM = "Forma Felina"
	L.AQUATIC_FORM = "Forma Acuática"
	L.TRAVEL_FORM = "Forma de Viaje"
	L.TREEOFLIFE = "Arbol de Vida"
	L.MOONKIN_FORM = "Forma de Moonkin"
	L.STEALTH = "Sigilo"
	L.SHADOWFORM = "Forma de las Sombras"
	L.BATTLESTANCE = "Actitud de Batalla"
	L.DEFENSIVESTANCE = "Actitud Defensiva"
	L.BERSERKERSTANCE = "Actitud Rabiosa"

	L.BINDING_NOT_DEFINED     = "Binding no definido"
	L.CANNOT_CHANGE_COMBAT    = "No puede hacer cambios en combate.  Los cambios se realizarán cuando salga de combate."
	L.APPLY_QUEUE             = "Fuera de combate.  Aplicando todos los cambios pendientes."
	L.PROFILE_CHANGED         = "El perfil ha cambiado a '%s'."
	L.PROFILE_DELETED         = "El perfil '%s' ha sido borrado."
	L.PROFILE_RESET         = "Su perfil '%s' ha sido resetiado."
	L.ACTION_ACTIONBAR = "Cambiar Barra de Acción"
	L.ACTION_ACTION = "Botón de Acción"
	L.ACTION_PET = "Botón de Acción Mascota"
	L.ACTION_SPELL = "Lanzar Hechizo"
	L.ACTION_ITEM = "Usar Item"
	L.ACTION_MACRO = "Ejecutar macro por defecto"
	L.ACTION_STOP = "Parar Lanzamiento"
	L.ACTION_TARGET = "Apuntar Unidad"
	L.ACTION_FOCUS = "Fijar Foco"
	L.ACTION_ASSIST = "Asistir Unidad"
	L.ACTION_CLICK = "Click Botón"
	L.ACTION_MENU = "Mostrar Menú"

	L.HELP_TEXT               = "Bienvenido a Clique.  Para su operación básica, usted puede navegar por el Libro de Hechizos (Spellbook) y determinar que hechizo le gustaría asociar a un click específico.  Luego haga click sobre el hechizo, con la combinación de teclas que a usted le guste (click o click + teclado).  Por ejemplo, un sacerdote puede buscar en su libro de hechizos la \"Sanación Relámpago\" (Flash Heal) y realizar sobre este un Shift+LeftClick, lo cual asociará dicho hechizo a las combinación de teclas Shift+LeftClick."
	L.CUSTOM_HELP             = "Esta es la pantalla de edición por defecto de Clique.  Desde aquí usted puede configurar cualquiera de las combinaciones que el UI tiene disponible para nosotros en respuesta a los clicks.  Seleccione una acción base de la columna izquierda.  Usted puede hacer clic en el botón de abajo para asociar las convinaciones de clicks + teclas que desee, y entonces proporcionar los argumentos requeridos (if any)."
	
	L.BS_ACTIONBAR_HELP = "Cambie la barra de acción. 'increment' lo moverá arriba de una pagina, 'decrement' hará lo contrario.  Si usted proporciona un número, la barra de acción será girada a esa página. Usted puede especificar 1,3 para alternar entre las páginas 1 y 3."

	L.BS_ACTIONBAR_ARG1_LABEL = "Acción:"

	L.BS_ACTION_HELP = "Simular un click sobre un botón de acción. Especificar el número del botón de acción."
	L.BS_ACTION_ARG1_LABEL = "Número de Botón:"
	L.BS_ACTION_ARG2_LABEL = "(Opcional) Unidad:"

	L.BS_PET_HELP = "Simular un click sobre el botón de acción de mascotas.  Especificar el número de botón."
	L.BS_PET_ARG1_LABEL = "Número de Boton Mascota:"
	L.BS_PET_ARG2_LABEL = "(Opcional) Unidad:"

	L.BS_SPELL_HELP = "Lanzar un hechizo desde el libro de hechizos.  Toma un nombre de hechizo y opcionalmente una bolsa (bag) y ranura (slot) o un nombre de ítem para usar como objetivo del hechizo (i.e. Alimentar Mascota)"
	L.BS_SPELL_ARG1_LABEL = "Nombre del Hechizo:"
	L.BS_SPELL_ARG2_LABEL = "*Número de Rango/Bolsa:"
	L.BS_SPELL_ARG3_LABEL = "*Número de Ranura (Slot):"
	L.BS_SPELL_ARG4_LABEL = "*Nombre del Item:"
	L.BS_SPELL_ARG5_LABEL = "(Opcional) Unidad:"

	L.BS_ITEM_HELP = "Use un item.  Puede tomar una bolsa y ranura o un nombre de item."
	L.BS_ITEM_ARG1_LABEL = "Número de Bolsa:"
	L.BS_ITEM_ARG2_LABEL = "Número de Ranura (Slot):"
	L.BS_ITEM_ARG3_LABEL = "Nombre del Item:"
	L.BS_ITEM_ARG4_LABEL = "(Opcional) Unidad:"

	L.BS_MACRO_HELP = "Use una macro por defecto en un indice en particular"
	L.BS_MACRO_ARG1_LABEL = "Indice Macro:"
	L.BS_MACRO_ARG2_LABEL = "Texto Macro:"

	L.BS_STOP_HELP = "Parar de lanzar hechizos en curso"
	
	L.BS_TARGET_HELP = "Apuntar unidad"
	L.BS_TARGET_ARG1_LABEL = "(Opcional) Unidad:"

	L.BS_FOCUS_HELP = "Fijar su \"foco\" en unidad"
	L.BS_FOCUS_ARG1_LABEL = "(Opcional) Unidad:"

	L.BS_ASSIST_HELP = "Asistir la unidad"
	L.BS_ASSIST_ARG1_LABEL = "(Opcional) Unidad:"

	L.BS_CLICK_HELP = "Simular click sobre un botón"
	L.BS_CLICK_ARG1_LABEL = "Nombre del Botón:"

	L.BS_MENU_HELP = "Muestra menú emergente de la unidad"
end

