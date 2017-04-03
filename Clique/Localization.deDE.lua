--[[---------------------------------------------------------------------------------
    Localisation for deDE.  Any commented lines need to be updated
----------------------------------------------------------------------------------]]

local L = Clique.Locals

if GetLocale() == "deDE" then
	L.RANK                    = "Rang"
	L.RANK_PATTERN            = "Rang (%d+)"
	L.CAST_FORMAT             = "%s(Rang %s)"

	L.RACIAL_PASSIVE          = "Volk Passiv"
	L.PASSIVE                 = SPELL_PASSIVE
	
	L.CLICKSET_DEFAULT        = "Standard"
	L.CLICKSET_HARMFUL        = "Schadhafte Aktionen"
	L.CLICKSET_HELPFUL        = "Hilfreiche Aktionen"
	L.CLICKSET_OOC            = "Au\195\159erhalb des Kampfes"
	L.CLICKSET_BEARFORM       = "B\195\164ren Gestalt"
	L.CLICKSET_CATFORM        = "Katzen Gestalt"
    L.CLICKSET_AQUATICFORM    = "Wasser Gestalt"
	L.CLICKSET_TRAVELFORM     = "Reise Gestalt"
	L.CLICKSET_MOONKINFORM    = "Moonkin Gestalt"
	L.CLICKSET_TREEOFLIFE     = "Baum des Lebens Gestalt"
	L.CLICKSET_SHADOWFORM     = "Schattengestalt"
	L.CLICKSET_STEALTHED      = "Getarnt"
	L.CLICKSET_BATTLESTANCE   = "Kampfhaltung"
	L.CLICKSET_DEFENSIVESTANCE = "Verteidigungshaltung"
	L.CLICKSET_BERSERKERSTANCE = "Berserkerhaltung"

	L.BEAR_FORM = "B\195\164ren Gestalt"
	L.DIRE_BEAR_FORM = "Dire B\195\164ren Gestalt"
	L.CAT_FORM = "Katzen Gestalt"
	L.AQUATIC_FORM = "Wasser Gestalt"
	L.TRAVEL_FORM = "Reise Gestalt"
	L.TREEOFLIFE = "Baum des Lebens"
	L.MOONKIN_FORM = "oonkin Gestalt"
	L.STEALTH = "Tarnen"
	L.SHADOWFORM = "Schattengestalt"
	L.BATTLESTANCE = "Kampfhaltung"
	L.DEFENSIVESTANCE = "Verteidigungshaltung"
	L.BERSERKERSTANCE = "Berserkerhaltung"

	L.BINDING_NOT_DEFINED     = "Belegung nicht definiert."
	
	L.CANNOT_CHANGE_COMBAT    = "\195\132nderungen w\195\164rend des Kampfes nicht m\195\182glich. \195\132nderungen werden bis Kampfende verschoben."
	L.APPLY_QUEUE             = "Au\195\159erhalb des Kampfes. Ausstehende \195\132nderungen werden durchgef\195\188hrt."
	L.PROFILE_CHANGED         = "Profil gewechselt zu '%s'."
	L.PROFILE_DELETED         = "Profile '%s' wurde gel\195\182scht."

	L.ACTION_ACTIONBAR = "Wechsel Aktionsleiste"
	L.ACTION_ACTION = "Aktion Taste"
	L.ACTION_PET = "Tier Aktion Taste"
	L.ACTION_SPELL = "Zauber ausf\195\188hren"
	L.ACTION_ITEM = "Benutze Gegenstand"
	L.ACTION_MACRO = "Starte eigenes Makro"
	L.ACTION_STOP = "Zauber Unterbrechen"
	L.ACTION_TARGET = "Ziel ausw\195\164hlen"
	L.ACTION_FOCUS = "Setze Fokus"
	L.ACTION_ASSIST = "Assistiere Einheit"
	L.ACTION_CLICK = "Klicke Taste"
	L.ACTION_MENU = "Zeige Men\195\188"

	L.HELP_TEXT               = "Willkomen zu Clique. Zuerst suchst du einfach im Zauberbuch einen Spruch aus, welchen du an eine Taste binden m\195\182chtest. Dann klickst du mit der entsprechenden Taste diesen Zauber an. Als Beispiel, gehe zu \"Blitzheilung\" und klicke darauf mit Shift+LinkeMaustaste um diesen Zauber auf Shift+LinkeMaustaste zu legen."
	L.CUSTOM_HELP             = "Dies ist das Clique konfigurations Fenster. Von hier aus kannst du alle Klick-Kombinationen, die uns die UI erlaubt, konfigurieren. W\195\164hle eine Grundfunktion aus der linken Spalte. Klicke dann auf den unteren Button mit einer Tastenkombination deiner Wahl, und erg\195\164nze (falls ben\195\182tigt) die Parameter."

	L.BS_ACTIONBAR_HELP = "Wechselt die Aktionsleiste. 'increment' Wechselt eine Leiste rauf, 'decrement' mach das Gegenteil. Gibst du eine Zahl ein, wird nur die enstprechende Leiste gezeigt. Die Eingabe von 1,3 w\195\188rde zwischen Leiste 1 und 3 wechseln"
	L.BS_ACTIONBAR_ARG1_LABEL = "Aktion:"

	L.BS_ACTION_HELP = "Simuliert einen Klick auf eine Aktions Taste. Gebe die Nummer der Aktions Taste an."
	L.BS_ACTION_ARG1_LABEL = "Tasten Nummer:"
	L.BS_ACTION_ARG2_LABEL = "(Optional) Unit:"

	L.BS_PET_HELP = "Simuliert einen Klick auf eine Tier Aktions Taste. Gebe die Nummer der Aktions Taste an."
	L.BS_PET_ARG1_LABEL = "Tier Tasten Nummer:"
	L.BS_PET_ARG2_LABEL = "(Optional) Unit:"
	
	L.BS_SPELL_HELP = "F\195\188hrt einen Zauber aus dem Zauberbuch aus. M\195\182glich sind Zaubername, und optional Rucksack/Platz, oder Gegenstand-Name als Ziel eines Zaubers.(zB. Tier f\195\188ttern)"
	L.BS_SPELL_ARG1_LABEL = "Zauber Name:"
	L.BS_SPELL_ARG2_LABEL = "*Rang/Rucksack Nr:"
	L.BS_SPELL_ARG3_LABEL = "*Platz Nummer:"
	L.BS_SPELL_ARG4_LABEL = "*Gegenstands Name:"
	L.BS_SPELL_ARG5_LABEL = "(Optional) Unit:"

	L.BS_ITEM_HELP = "Benutze Gegenstand. Angabe von Rucksack/Platz, oder Gegenstand-Name."
	L.BS_ITEM_ARG1_LABEL = "Rucksack Nummer:"
	L.BS_ITEM_ARG2_LABEL = "Platz Nummer:"
	L.BS_ITEM_ARG3_LABEL = "Gegenstands Name:"
	L.BS_ITEM_ARG4_LABEL = "(Optional) Unit:"
	
	L.BS_MACRO_HELP = "Benutzt eigenes Makro aus vorhandenem index"
	L.BS_ARG1_LABEL = "Makro Index:"
	L.BS_ARG2_LABEL = "Makro Text:"
	
	L.BS_STOP_HELP = "Unterbricht den laufenden Zauberspruch"
	
	L.BS_TARGET_HELP = "Visiert \"unit\" als Ziel an"
	L.BS_TARGET_ARG1_LABEL = "(Optional) Unit:"
	
	L.BS_FOCUS_HELP = "W\195\164hlt \"focus\" Einheit aus."
	L.BS_FOCUS_ARG1_LABEL = "(Optional) Unit:"
	
	L.BS_ASSIST_HELP = "Assistiert der Einheit \"unit\""
	L.BS_ASSIST_ARG1_LABEL = "(Optional) Unit:"
	
	L.BS_CLICK_HELP = "Simuliert Klick auf eine Aktions Taste"
	L.BS_CLICK_ARG1_LABEL = "Tasten Name:"

	L.BS_MENU_HELP = "Zeigt das Einheiten Pop-Up Men\195\188"
end