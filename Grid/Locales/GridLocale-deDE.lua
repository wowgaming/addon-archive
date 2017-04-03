--[[--------------------------------------------------------------------
	GridLocale-deDE.lua
	German (Deutsch) localization for Grid.
----------------------------------------------------------------------]]

if GetLocale() ~= "deDE" then return end
local _, ns = ...
ns.L = {

--{{{ GridCore
	["Debugging"] = "Debuggen",
	["Module debugging menu."] = "Debug-Menü",
	["Debug"] = "Debug",
	["Toggle debugging for %s."] = "Aktiviere das Debuggen für %s.",
	["Configure"] = "Konfigurieren",
	["Configure Grid"] = "Grid konfigurieren",
	["Hide minimap icon"] = "Minikarten Button verstecken",
	["Grid is disabled: use '/grid standby' to enable."] = "Grid ist ausgeschaltet: Tippe '/grid standby' zum einschalten.",
	["Enable dual profile"] = "Duales Profil aktivieren",
	["Automatically swap profiles when switching talent specs."] = "Wechselt automatisch das Profil wenn die Talentspezialisierung gewechselt wird.",
	["Dual profile"] = "Duales Profil",
	["Select the profile to swap with the current profile when switching talent specs."] = "Wähle das Profil, das aktiviert werden soll wenn die momentane Talentspezialisierung gewechselt wird.",
--}}}

--{{{ GridFrame
	["Frame"] = "Rahmen",
	["Options for GridFrame."] = "Optionen für den Grid-Rahmen.",

	["Show Tooltip"] = "Zeige Tooltip",
	["Show unit tooltip.  Choose 'Always', 'Never', or 'OOC'."] = "Wann sollen Tooltips angezeigt werden: 'Außerhalb des Kampfes', 'Immer' oder 'Nie'.",
	["Always"] = "Immer",
	["Never"] = "Nie",
	["OOC"] = "Außerhalb des Kampfes",
	["Center Text Length"] = "Länge des mittleren Textes",
	["Number of characters to show on Center Text indicator."] = "Anzahl der Buchstaben die im mittleren Text angezeigt werden.",
	["Invert Bar Color"] = "Invertiere die Leistenfarbe",
	["Swap foreground/background colors on bars."] = "Tausche die Vordergrund-/Hintergrundfarbe der Leisten.",
	["Healing Bar Opacity"] = "Heilleistendeckkraft",
	["Sets the opacity of the healing bar."] = "Verändert die Deckkraft der Heilleiste.",

	["Indicators"] = "Indikatoren",
	["Border"] = "Rand",
	["Health Bar"] = "Gesundheitsleiste",
	["Health Bar Color"] = "Gesundheitsleistenfarbe",
	["Healing Bar"] = "Heilleiste",
	["Center Text"] = "Text in der Mitte",
	["Center Text 2"] = "2. Text in der Mitte",
	["Center Icon"] = "Symbol im Zentrum",
	["Top Left Corner"] = "Obere linke Ecke",
	["Top Right Corner"] = "Obere rechte Ecke",
	["Bottom Left Corner"] = "Untere linke Ecke",
	["Bottom Right Corner"] = "Untere rechte Ecke",
	["Frame Alpha"] = "Rahmentransparenz",

	["Options for %s indicator."] = "Optionen für den %s Indikator.",
	["Statuses"] = "Zustände",
	["Toggle status display."] = "Aktiviert die Anzeige des Zustands.",

	-- Advanced options
	["Advanced"] = "Erweitert",
	["Advanced options."] = "Erweiterte Einstellungen.",
	["Enable %s indicator"] = "Indikator für %s ",
	["Toggle the %s indicator."] = "Aktiviert den %s Indikator.",
	["Frame Width"] = "Rahmenbreite",
	["Adjust the width of each unit's frame."] = "Die Breite von jedem Einheitenfenster anpassen.",
	["Frame Height"] = "Rahmenhöhe",
	["Adjust the height of each unit's frame."] = "Die Höhe von jedem Einheitenfenster anpassen.",
	["Frame Texture"] = "Rahmentextur",
	["Adjust the texture of each unit's frame."] = "Die Textur von jedem Einheitenfenster anpassen.",
	["Border Size"] = "Randbreite",
	["Adjust the size of the border indicators."] = "Die Randbreite der Indikatoren anpassen.",
	["Corner Size"] = "Eckengröße",
	["Adjust the size of the corner indicators."] = "Die Größe der Eckenindikatoren anpassen.",
	["Enable Mouseover Highlight"] = "Rahmen Hervorhebung",
	["Toggle mouseover highlight."] = "Rahmen Hervorhebung (Mouseover Highlight) ein-/ausschalten.",
	["Font"] = "Schriftart",
	["Adjust the font settings"] = "Die Schriftart anpassen",
	["Font Size"] = "Schriftgröße",
	["Adjust the font size."] = "Die Schriftgröße anpassen.",
	["Font Outline"] = "Schriftumriss",
	["Adjust the font outline."] = "Den Schriftumriss anpassen.",
	["None"] = "Kein Umriss",
	["Thin"] = "Dünn",
	["Thick"] = "Dick",
	["Orientation of Frame"] = "Ausrichtung der Statusleiste",
	["Set frame orientation."] = "Ausrichtung der Statusleiste festlegen.",
	["Orientation of Text"] = "Ausrichtung des Texts",
	["Set frame text orientation."] = "Text Ausrichtung festlegen.",
	["Vertical"] = "Vertikal",
	["Horziontal"] = "Horizontal",
	["Icon Size"] = "Symbolgröße",
	["Adjust the size of the center icon."] = "Die Größe des Symbols im Zentrum anpassen.",
	["Icon Border Size"] = "Symbolrandbreite",
	["Adjust the size of the center icon's border."] = "Die Randbreite des Symbols im Zentrum anpassen.",
	["Icon Stack Text"] = "Symbol Stack-Text",
	["Toggle center icon's stack count text."] = "Stack-Text für Symbol im Zentrum ein-/ausblenden.",
	["Icon Cooldown Frame"] = "Symbol Cooldown-Rahmen",
	["Toggle center icon's cooldown frame."] = "Cooldown-Rahmen für Symbol im Zentrum ein-/ausblenden.",
--}}}

--{{{ GridLayout
	["Layout"] = "Layout",
	["Options for GridLayout."] = "Optionen für das Layout von Grid.",

	["Drag this tab to move Grid."] = "Reiter klicken und bewegen, um Grid zu verschieben.",
	["Lock Grid to hide this tab."] = "'Grid sperren' um diesen Reiter zu verstecken.",
	["Alt-Click to permanantly hide this tab."] = "Alt-Klick um diesen Reiter immer zu verstecken.",

	-- Layout options
	["Show Frame"] = "Zeige Rahmen",

	["Solo Layout"] = "Solo Layout",
	["Select which layout to use when not in a party."] = "Wähle welches Layout benutzt werden soll, wenn Du in keiner Gruppe bist.",
	["Party Layout"] = "Gruppen Layout",
	["Select which layout to use when in a party."] = "Wähle welches Gruppen Layout benutzt werden soll.",
	["25 Player Raid Layout"] = "25 Spieler Schlachtzug Layout",
	["Select which layout to use when in a 25 player raid."] = "Wähle welches Schlachtzug Layout für 25 Spieler benutzt werden soll.",
	["10 Player Raid Layout"] = "10 Spieler Schlachtzug Layout",
	["Select which layout to use when in a 10 player raid."] = "Wähle welches Schlachtzug Layout für 10 Spieler benutzt werden soll.",
	["Battleground Layout"] = "Schlachtfeld Layout",
	["Select which layout to use when in a battleground."] = "Wähle welches Schlachtfeld Layout benutzt werden soll.",
	["Arena Layout"] = "Arena Layout",
	["Select which layout to use when in an arena."] = "Wähle welches Arena Layout benutzt werden soll.",
	["Horizontal groups"] = "Horizontal gruppieren",
	["Switch between horzontal/vertical groups."] = "Wechselt zwischen horizontaler/vertikaler Gruppierung.",
	["Clamped to screen"] = "Im Bildschirm lassen",
	["Toggle whether to permit movement out of screen."] = "Legt fest ob der Grid-Rahmen im Bildschirm bleiben soll.",
	["Frame lock"] = "Grid sperren",
	["Locks/unlocks the grid for movement."] = "Sperrt Grid oder entsperrt Grid, um den Rahmen zu verschieben.",
	["Click through the Grid Frame"] = "Durch Grid-Rahmen klicken",
	["Allows mouse click through the Grid Frame."] = "Erlaubt Mausklicks durch den Grid-Rahmen.",

	["Center"] = "Zentriert",
	["Top"] = "Oben",
	["Bottom"] = "Unten",
	["Left"] = "Links",
	["Right"] = "Rechts",
	["Top Left"] = "Obenlinks",
	["Top Right"] = "Obenrechts",
	["Bottom Left"] = "Untenlinks",
	["Bottom Right"] = "Untenrechts",

	-- Display options
	["Padding"] = "Zwischenabstand",
	["Adjust frame padding."] = "Den Zwischenabstand anpassen.",
	["Spacing"] = "Abstand",
	["Adjust frame spacing."] = "Den Abstand anpassen.",
	["Scale"] = "Skalierung",
	["Adjust Grid scale."] = "Skalierung anpassen.",
	["Border"] = "Rand",
	["Adjust border color and alpha."] = "Anpassen der Rahmenfarbe und Transparenz.",
	["Border Texture"] = "Randtextur",
	["Choose the layout border texture."] = "Layout Randtextur auswählen.",
	["Background"] = "Hintergrund",
	["Adjust background color and alpha."] = "Anpassen der Hintergrundfarbe und Transparenz.",
	["Pet color"] = "Begleiterfarbe",
	["Set the color of pet units."] = "Legt die Begleiterfarbe fest.",
	["Pet coloring"] = "Begleiterfärbung",
	["Set the coloring strategy of pet units."] = "Legt fest, wie die Begleiter eingefärbt werden.",
	["By Owner Class"] = "Nach Besitzerklasse",
	["By Creature Type"] = "Nach Kreaturtyp",
	["Using Fallback color"] = "Nach Ersatzfarbe",
	["Beast"] = "Wildtier",
	["Demon"] = "Dämon",
	["Humanoid"] = "Humanoid",
	["Undead"] = "Untoter",
	["Dragonkin"] = "Drachkin",
	["Elemental"] = "Elementar",
	["Not specified"] = "Nicht spezifiziert",
	["Colors"] = "Farben",
	["Color options for class and pets."] = "Legt fest, wie Klassen und Begleiter eingefärbt werden.",
	["Fallback colors"] = "Ersatzfarben",
	["Color of unknown units or pets."] = "Farbe für unbekannte Einheiten oder Begleiter.",
	["Unknown Unit"] = "Unbekannte Einheit",
	["The color of unknown units."] = "Farbe für unbekannte Einheiten.",
	["Unknown Pet"] = "Unbekannter Begleiter",
	["The color of unknown pets."] = "Farbe für unbekannte Begleiter.",
	["Class colors"] = "Klassenfarben",
	["Color of player unit classes."] = "Farbe für Spielerklassen.",
	["Creature type colors"] = "Kreaturtypfarben",
	["Color of pet unit creature types."] = "Farbe für die verschiedenen Kreaturtypen.",
	["Color for %s."] = "Farbe für %s.",

	-- Advanced options
	["Advanced"] = "Erweitert",
	["Advanced options."] = "Erweiterte Einstellungen.",
	["Layout Anchor"] = "Ankerpunkt des Layouts",
	["Sets where Grid is anchored relative to the screen."] = "Setzt den Ankerpunkt von Grid relativ zum Bildschirm.",
	["Group Anchor"] = "Ankerpunkt der Gruppe",
	["Sets where groups are anchored relative to the layout frame."] = "Setzt den Ankerpunkt der Gruppe relativ zum Layoutrahmen.",
	["Reset Position"] = "Position zurücksetzen",
	["Resets the layout frame's position and anchor."] = "Setzt den Ankerpunkt und die Position des Layoutrahmens zurück.",
	["Hide tab"] = "Reiter verstecken",
	["Do not show the tab when Grid is unlocked."] = "Reiter immer verstecken. (Egal ob Grid gesperrt oder entsperrt ist.)",
--}}}

--{{{ GridLayoutLayouts
	["None"] = "Ausblenden",
	["By Group 5"] = "5er Gruppe",
	["By Group 5 w/Pets"] = "5er Gruppe mit Begleitern",
	["By Group 10"] = "10er Gruppe",
	["By Group 10 w/Pets"] = "10er Gruppe mit Begleitern",
	["By Group 15"] = "15er Gruppe",
	["By Group 15 w/Pets"] = "15er Gruppe mit Begleitern",
	["By Group 25"] = "25er Gruppe",
	["By Group 25 w/Pets"] = "25er Gruppe mit Begleitern",
	["By Group 25 w/Tanks"] = "25er Gruppe mit Tanks",
	["By Group 40"] = "40er Gruppe",
	["By Group 40 w/Pets"] = "40er Gruppe mit Begleitern",
	["By Class 10 w/Pets"] = "10er Gruppe nach Klasse",
	["By Class 25 w/Pets"] = "25er Gruppe nach Klasse",
--}}}

--{{{ GridLDB
	["Click to open the options in a GUI window."] = "Linksklick: GUI Fenster.",
	["Right-Click to open the options in a drop-down menu."] = "Rechtsklick: Drop-down Menu.",
--}}}

--{{{ GridRange
	-- used for getting spell range from tooltip
	["(%d+) yd range"] = "(%d+) Meter Reichweite",
--}}}

--{{{ GridStatus
	["Status"] = "Status",
	["Options for %s."] = "Optionen für %s.",
	["Reset class colors"] = "Klassenfarben zurücksetzen",
	["Reset class colors to defaults."] = "Klassenfarben auf Standard zurücksetzen.",

	-- module prototype
	["Status: %s"] = "Status: %s",
	["Color"] = "Farbe",
	["Color for %s"] = "Farbe für %s",
	["Priority"] = "Priorität",
	["Priority for %s"] = "Priorität für %s",
	["Range filter"] = "Entfernungsfilter",
	["Range filter for %s"] = "Entfernungsfilter für %s",
	["Enable"] = "Aktivieren",
	["Enable %s"] = "Aktiviert %s",
--}}}

--{{{ GridStatusAggro
	["Aggro"] = "Aggro",
	["Aggro alert"] = "Aggro-Alarm",
	["High Threat color"] = "Hohe Bedrohung Farbe",
	["Color for High Threat."] = "Farbe für 'Hohe Bedrohung'.",
	["Aggro color"] = "Aggro Farbe",
	["Color for Aggro."] = "Farbe für 'Aggro'.",
	["Tanking color"] = "Tanken Farbe",
	["Color for Tanking."] = "Farbe für 'Tanken'.",
	["Threat"] = "Bedrohung",
	["Show more detailed threat levels."] = "Zeigt mehrere Bedrohungsstufen.",
	["High"] = "Hoch",
	["Tank"] = "Tank",
--}}}

--{{{ GridStatusAuras
	["Auras"] = "Auren",
	["Debuff type: %s"] = "Schwächungszaubertyp: %s",
	["Poison"] = "Gift",
	["Disease"] = "Krankheit",
	["Magic"] = "Magie",
	["Curse"] = "Fluch",
	["Ghost"] = "Geistererscheinung",
	["Buffs"] = "Stärkungszauber",
	["Debuff Types"] = "Schwächungszaubertyp",
	["Debuffs"] = "Schwächungszauber",
	["Add new Buff"] = "Neuen Stärkungszauber hinzufügen",
	["Adds a new buff to the status module"] = "Fügt einen neuen Stärkungszauber zum Status Modul hinzu",
	["<buff name>"] = "<Stärkungszaubername>",
	["Add new Debuff"] = "Neuen Schwächungszauber hinzufügen",
	["Adds a new debuff to the status module"] = "Fügt einen neuen Schwächungszauber zum Status Modul hinzu",
	["<debuff name>"] = "<Schwächungszaubername>",
	["Delete (De)buff"] = "Lösche Schwächungs-/Stärkungszauber",
	["Deletes an existing debuff from the status module"] = "Löscht einen Schwächungszauber vom Status Modul",
	["Remove %s from the menu"] = "Entfernt %s vom Menü",
	["Debuff: %s"] = "Schwächungszauber: %s",
	["Buff: %s"] = "Stärkungszauber: %s",
	["Class Filter"] = "Klassenfilter",
	["Show status for the selected classes."] = "Zeigt den Status für die ausgwählte Klasse.",
	["Show on %s."] = "Zeige %s.",
	["Show if mine"] = "Zeigen wenn es meiner ist",
	["Display status only if the buff was cast by you."] = "Zeigt den Status nur an, wenn Du ihn gezaubert hast.",
	["Show if missing"] = "Zeigen wenn es fehlt",
	["Display status only if the buff is not active."] = "Zeigt den Status nur an, wenn der Stärkungszauber nicht aktiv ist.",
	["Filter Abolished units"] = "Bereinigte Einheiten filtern",
	["Skip units that have an active Abolish buff."] = "Einheiten verwerfen, die einen aktiven bereinigenden Stärkungszauber haben (Krankheit/Vergiftung aufheben).",
	["Show duration"] = "Dauer anzeigen",
	["Show the time remaining, for use with the center icon cooldown."] = "Zeigt die Dauer im Cooldown-Rahmen (Symbol im Zentrum).",
--}}}

--{{{ GridStatusHeals
	["Heals"] = "Heilungen",
	["Incoming heals"] = "Eingehende Heilungen",
	["Ignore Self"] = "Sich selbst ignorieren",
	["Ignore heals cast by you."] = "Ignoriert Heilungen die von Dir gezaubert werden.",
	["Heal filter"] = "Heilungsfilter",
	["Show incoming heals for the selected heal types."] = "Zeigt eingehende Heilungen für die ausgewählten Heilungstypen.",
	["Direct heals"] = "Direkte Heilungen",
	["Include direct heals."] = "Direkte Heilungen einbeziehen.",
	["Channeled heals"] = "Kanalisierte Heilungen",
	["Include channeled heals."] = "Kanalisierte Heilungen einbeziehen.",
	["HoT heals"] = "HoT Heilungen",
	["Include heal over time effects."] = "HoT (Heal over Time - Heilung über Zeit) Effekte einbeziehen.",
--}}}

--{{{ GridStatusHealth
	["Low HP"] = "Wenig HP",
	["DEAD"] = "TOT",
	["FD"] = "TG",
	["Offline"] = "Offline",
	["Unit health"] = "Gesundheit",
	["Health deficit"] = "Gesundheitsdefizit",
	["Low HP warning"] = "Wenig HP Warnung",
	["Feign Death warning"] = "Warnung wenn totgestellt",
	["Death warning"] = "Todeswarnung",
	["Offline warning"] = "Offlinewarnung",
	["Health"] = "Gesundheit",
	["Show dead as full health"] = "Zeige Tote mit voller Gesundheit an",
	["Treat dead units as being full health."] = "Behandle Tote als hätten sie volle Gesundheit.",
	["Use class color"] = "Benutze Klassenfarbe",
	["Color health based on class."] = "Färbt den Gesundheitsbalken in Klassenfarbe.",
	["Health threshold"] = "Gesundheitsgrenzwert",
	["Only show deficit above % damage."] = "Zeigt Defizit bei mehr als % Schaden.",
	["Color deficit based on class."] = "Färbt das Defizit nach Klassenfarbe.",
	["Low HP threshold"] = "Wenig HP Grenzwert",
	["Set the HP % for the low HP warning."] = "Setzt den % Grenzwert für die Wenig HP Warnung.",
--}}}

--{{{ GridStatusMana
	["Mana"] = "Mana",
	["Low Mana"] = "Wenig Mana",
	["Mana threshold"] = "Mana Grenzwert",
	["Set the percentage for the low mana warning."] = "Setzt den % Grenzwert für die Wenig Mana Warnung.",
	["Low Mana warning"] = "Wenig Mana Warnung",
--}}}

--{{{ GridStatusName
	["Unit Name"] = "Namen",
	["Color by class"] = "In Klassenfarbe",
--}}}

--{{{ GridStatusRange
	["Range"] = "Entfernung",
	["Range check frequency"] = "Häufigkeit der Reichweitenmessung",
	["Seconds between range checks"] = "Sekunden zwischen den Reichweitenmessungen",
	["More than %d yards away"] = "Mehr als %d meter entfernt",
	["%d yards"] = "%d meter",
	["Text"] = "Text",
	["Text to display on text indicators"] = "Text, der in einem Textindikator angezeigt wird",
	["<range>"] = "<entfernung>",
--}}}

--{{{ GridStatusReadyCheck
	["Ready Check"] = "Bereitschaftscheck",
	["Set the delay until ready check results are cleared."] = "Zeit, bis die Bereitschaftscheck-Ergebnisse gelöscht werden.",
	["Delay"] = "Verzögerung",
	["?"] = "?",
	["R"] = "OK",
	["X"] = "X",
	["AFK"] = "AFK",
	["Waiting color"] = "Warten Farbe",
	["Color for Waiting."] = "Farbe für 'Warten'.",
	["Ready color"] = "Bereit Farbe",
	["Color for Ready."] = "Farbe für 'Bereit'.",
	["Not Ready color"] = "Nicht bereit Farbe",
	["Color for Not Ready."] = "Farbe für 'Nicht bereit'.",
	["AFK color"] = "AFK Farbe",
	["Color for AFK."] = "Farbe für 'AFK'.",
--}}}

--{{{ GridStatusTarget
	["Target"] = "Ziel",
	["Your Target"] = "Dein Ziel",
--}}}

--{{{ GridStatusVehicle
	["In Vehicle"] = "In Fahrzeug",
	["Driving"] = "Fährt",
--}}}

--{{{ GridStatusVoiceComm
	["Voice Chat"] = "Sprachchat",
	["Talking"] = "Redet",
--}}}

}