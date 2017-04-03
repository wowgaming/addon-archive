if not ACP then return end

if (GetLocale() == "esES") then
	ACP:UpdateLocale( {
		["Reload your User Interface?"] = "?Recargar la Interfaz de Usuario?",
		["Save the current addon list to [%s]?"] = "?Grabar la lista actual de accesorios en [%s]?",
		["Enter the new name for [%s]:"] = "Escriba el nuevo nombre para [%s]:",
		["Addons [%s] Saved."] = "Accesorios [%s] grabados.",
		["Addons [%s] Unloaded."] = "Accesorios [%s] descargados.",
		["Addons [%s] Loaded."] = "Accesorios [%s] cargados.",
		["Addons [%s] renamed to [%s]."] = "Accesorios [%s] renombrados a [%s].",
		["Loaded on demand."] = "Cargar a demanda.",
		["AddOns"] = "Accesorios",
		["Load"] = "Cargar",
		["Disable All"] = "---",
		["Enable All"] = "+++",
		["ReloadUI"] = "RecargarIU",
		["Sets"] = "Perfiles",
		["No information available."] = "No hay informaci\195\179n disponible.",
		["Loaded"] = "Cargado",
		["Recursive"] = "Recursivo",
		["LoD Children"] = "Hijos CaD",
		["Loadable OnDemand"] = "Cargable a demanda",
		["Disabled on reloadUI"] = "Desactivar al RecargarIU",
		["Default"] = "Por defecto";
		["Set "] = "Perfil ";
		["Save"] = "Grabar ";
		["Load"] = "Cargar ";
		["Add to current selection"] = "A?adir a la selecci\195\179n actual";
		["Remove from current selection"] = "Eliminar de la selecci\195\179n actual";
		["Rename"] = "Renombrar ";
		["Use SHIFT to override the current enabling of dependancies behaviour."] = "Utilice MAY para reemplazar el comportamiento de activaci?n de dependencias actual.",
		["Press CTRL to override the enabling of LoD children."] = "Presione CTRL para reemplazar la activaci\195\179n de los hijos CaD.",
			["Click to enable protect mode. Protected addons will not be disabled"] = "Clic para activar el modo protegido. Los accesorios protegidos no seran deshabilitados",
			["when performing a reloadui."] = "cuando realice RecargarIU.",
			["ACP: Some protected addons aren't loaded. Reload now?"] = "ACP: Algunos accesorios protegidos no se encuentran cargados. ?Recargar ahora?",
		
		
		["Blizzard_AchievementUI"] = "Blizzard: Achievement",
		["Blizzard_AuctionUI"] = "Blizzard: Subasta",
		["Blizzard_BarbershopUI"] = "Blizzard: Barbershop",
		["Blizzard_BattlefieldMinimap"] = "Blizzard: Minimapa del Campo de Batalla",
		["Blizzard_BindingUI"] = "Blizzard: Asignaci\195\179n",
		["Blizzard_Calendar"] = "Blizzard: Calendar",
		["Blizzard_CombatLog"] = "Blizzard: Combat Log",
		["Blizzard_CombatText"] = "Blizzard: Texto de Combate",
		["Blizzard_FeedbackUI"] = "Blizzard: Feedback",
		["Blizzard_GlyphUI"] = "Blizzard: Glyph",
		["Blizzard_GMSurveyUI"] = "Blizzard: Ayuda GM",
		["Blizzard_GuildBankUI"] = "Blizzard: GuildBank",
		["Blizzard_InspectUI"] = "Blizzard: Inspeci\195\179n",
		["Blizzard_ItemSocketingUI"] = "Blizzard: Colocaci\195\179n de objetos",
		["Blizzard_MacroUI"] = "Blizzard: Macro",
		["Blizzard_RaidUI"] = "Blizzard: Raid",
		["Blizzard_TalentUI"] = "Blizzard: Talento",
		["Blizzard_TimeManager"] = "Blizzard: TimeManager",
		["Blizzard_TokenUI"] = "Blizzard: Token",
		["Blizzard_TradeSkillUI"] = "Blizzard: Profesi\195\179n",
		["Blizzard_TrainerUI"] = "Blizzard: Profesor",
		["Blizzard_VehicleUI"] = "Blizzard: Vehicle",
		
		["*** Enabling <%s> %s your UI ***"] = "*** Activando <%s> %s su IU ***";
		["*** Unknown Addon <%s> Required ***"] = "*** Accesorio desconocido <%s> requerido ***";
		["LoD Child Enable is now %s"] = "La Activaci\195\179n de los Hijos CaD es ahora %s";
		["Recursive Enable is now %s"] = "La Activaci\195\179n Recursiva es ahora %s";
		["Addon <%s> not valid"] = "Accesorio <%s> incorrecto";
		["Reload"] = "Recargar";
		["Author"] = "Autor";
		["Version"] = "Versi\195\179n";
		["Status"] = "Estado";
		["Dependencies"] = "Dependencias";
		["Embeds"] = "Inclusiones";
	} )
end