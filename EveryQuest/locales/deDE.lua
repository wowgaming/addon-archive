local L = LibStub("AceLocale-3.0"):NewLocale("EveryQuest", "deDE")
if not L then return end

-- Core.lua
L[" (%d Times)"] = "%d mal"
L[" [L]"] = "Core - Alle Strings befinden sich in der Core.lua" -- Needs review
L["%d Shown"] = "%d angezeigt"
L["%d days %d hr ago"] = "Vor %d Tagen und %d Stunden"
L["%d days ago"] = "Vor %d Tagen"
L["%d hr %d min ago"] = "Vor %d Stunden und %d Minuten"
L["%d hr ago"] = "Vor %d Stunden"
L["%d minutes ago"] = "Vor %d Minuten"
L["%d seconds ago"] = "Vor %d Sekunden"
L["%m/%d/%y %I%p"] = "%d.%m.%y %H"
L["1 day %d hr ago"] = "Vor einem Tag und %d Stunden"
L["1 day ago"] = "Vor einem Tag"
L["1 minute ago"] = "Vor einer Minute"
L["1 second ago"] = "Vor einer Sekunde"
L["Abandoned"] = "Abgebrochen"
L["Abandoned: %s"] = "Abgebrochen: %s"
L["Cancel"] = "Abbrechen"
L["Completed"] = "Abgeschlossen"
L["Completed%s: %s"] = "Abgeschlossen %s: %s"
L["Could not load %s Quest Data because of %s"] = "Konnte die Questdaten von %s nicht laden auf Grund von %s"
L["D"] = "D" -- Needs review
L["E"] = "E"
L["EQ_CLEARIMPORTDESC"] = [=[Klicke in die Checkbox um das Löschen der importierten Daten zu bestätigen.

Während des Imports wurde jedes importierte Quest markiert, so dass es später leicht entfernt werden kann. Aber keine Panik, in dem Moment in dem du EQ zum Questen benutzt, wird diese Importmarkierung entfernt. Daher gehen neue Daten nicht verloren.]=] -- Needs review
L["EQ_PURGETXT"] = "Bist du dir sicher, dass du alle alten Daten löschen möchtest? Wenn du dir unsicher bist oder gerade ein Upgrade durchgeführt hast, dann breche ab und schaue im EveryQuest Fenster ob deine Quests vorhanden sind. Um fortzufahren tippe 'LÖSCHEN' in die folgende Eingabemaske. Diese Aktion ist irreversibel. Du kannst die Datenbank auch später mit den Interface Optionen bereinigen" -- Needs review
L["EQ_UPGRADETXT"] = "EveryQuest hat %s veraltete Datenbank(en) entdeckt (bedingt durch einen Versionsupgrade), klicke Ja um den Upgrade zu versuchen. Das kann einen Moment dauern. Du kannst das Upgrade auch später über die Interface Optionen durchführen." -- Needs review
L["Failed"] = "Fehlgeschlagen"
L["Failed or Abandoned"] = "Fehlgeschlagen oder abgebrochen"
L["Failed: %s"] = "Fehlgeschlagen: %s"
L["Forget"] = "Vergessen"
L["G"] = "G"
L["H"] = "H"
L["Ignore"] = "Ignorieren"
L["Imported From: %s"] = "Importiert von: %s"
L["In Progress"] = "In Arbeit"
L["Loading %s Quest Data"] = "Lade Questdaten zu %s"
L["Other"] = "Andere"
L["P"] = "P" -- Needs review
L["PURGE_ERROR"] = "Du hast nicht den korrekten Text eingegeben um die alten Daten zu löschen. Lies bitte den Text!" -- Needs review
L["Purge"] = "Löschen"
L["QuestGuru"] = "QuestGuru"
L["QuestHistory"] = "QuestHistory"
L["R"] = "R"
L["Requires LOD Module: %s"] = "Benötigt das LOD Modul: %s"
L["Server Query"] = "Server Abfrage"
L["Status: %s"] = "Status: %s"
L["Turned In"] = "Abgegeben"
L["Unknown"] = "Unbekannt"
L["Upgrade"] = "Aktualisieren"
L["W"] = "W"
L["WE"] = "WE"
L["Y"] = "Y"
L["You are running a source checkout of EveryQuest %s directly from the repository."] = "Du führst einen Checkout des Quellcodes von EveryQuest %s direkt vom Repository durch."
L["You are running an ALPHA RELEASE of EveryQuest %s (revision %d). Please report any bugs @ http://www.wowace.com/addons/everyquest/tickets/"] = "Du benutzt eine ALPHA AUSGABE von EveryQuest %s (Revision %d). Bitte berichte jeden Fehler an http://www.wowace.com/addons/everyquest/tickets/" -- Needs review
L["r%d"] = "Core - Alle Strings befinden sich in der Core.lua"


-- events.lua
L["Abandon Quest: %s"] = "Quest abbrechen: %s"
L["Complete Quest: %s"] = "Abgeschlossenes Quest: %s"
L["Failed Quest: %s"] = "Fehlgeschlagene Quest: %s"
L["Obtained Quest: %s"] = "Erhaltene Quest: %s"
L["Turn In Quest: %s"] = "Quest Abgabe: %s"
L["Unable to get Quest Information from DB"] = "Konnte Questinformationen nicht aus der Datenbank holen"


-- frames.lua
L["%d Completed"] = "%d abgeschlossen"
L["%d Failed/Abandoned"] = "%d fehlgeschlagen/abgebrochen"
L["%d Hidden"] = "%d Versteckt" -- Needs review
L["%d Ignored"] = "%d ignoriert"
L["%d In Progress"] = "%d in Arbeit"
L["%d Turned In"] = "%d abgegeben"
L["%d Unknown"] = "%d unbekannt"
L["- Select -"] = "- Wähle -"
L["Click to toggle the main window"] = "Klicke um das Hauptfenster umzuschalten"
L["EveryQuest"] = "EveryQuest"
L["EveryQuest Log"] = "EveryQuest Log"
L["Filters"] = "Filter"
L["Options"] = "Optionen"
L["Right-click to open the options menu"] = "Rechtsklick um das Optionsmenü zu öffnen"
L["Toggle Frame"] = "Fenster umschalten"


-- import.lua
L["Clear Import Confirm"] = "Bestätige Import Löschung" -- Needs review
L["Clear Imported Data"] = "Lösche importierte Daten" -- Needs review
L["Delete any quest tagged as being imported."] = "Lösche alle als importiert markierten Quests." -- Needs review
L["Deleted %d quests from your database"] = "%d Quests aus deiner Datenbank gelöscht" -- Needs review
L["EQ_CLEARIMPORTDESC"] = [=[Um deine importierten Quests zu löschen, musst du:
1) Debugging aktivieren
2) das Häkchen zur Bestätigung setzen

Während des Imports wurde jedes importierte Quest markiert, so dass es später leicht entfernt werden kann. Keine Panik, wenn du startest mit EQ zu questen wird diese Importmarkierung entfernt und daher gehen neue Daten nicht verloren.]=] -- Needs review
L["EQ_IMPORT"] = [=[Hier kannst du den Questverlauf von anderen Addons importieren. Aktuell werden nur QuestGuru und QuestHistory unterstützt.

|cffFFAFAFANMERKUNG: Um alle deine Daten zu importieren, must du diese Funktion für alle Charaktere wiederholen während das Addon von dem du importierst geladen ist. Das ist eine Beschränkung von EveryQuest welches Daten pro Charakter und nicht global speichert (das spart Speicher und verkürzt die Startzeit).|r]=] -- Needs review
L["EQ_IMPORT_TRAILER"] = "Wenn einer dieser Knöpfe gesperrt ist, bedeutet dies, dass du eines der Addons nicht geladen hast. Melde dich ab und aktiviere das Addon um deine Daten zu importieren." -- Needs review
L["Import"] = "Importieren"
L["Import QuestGuru Data"] = "Importiere QuestGuru Daten" -- Needs review
L["Import QuestHistory Data"] = "Importiere QuestHistory Daten" -- Needs review
L["Import failed, you have no data relating to this character on this server."] = "Importieren fehlgeschlagen. Du hast auf diesem Server keine Daten welche zu diesem Charakter gehören." -- Needs review
L["Imported %d quests from %s"] = "Importierte %d Quests von %s" -- Needs review
L["QuestHistory importing is strictly alpha quality. This is due to having to guess at which quest you are trying to import."] = "QuestHistory Import ist zweifellos Alpha Qualität. Die Ursache ist, dass geraten werden muss, welches Quest du zu importieren versuchst." -- Needs review


-- options.lua
L["Alliance"] = "Allianz"
L["Ascending"] = "Aufsteigend" -- Needs review
L["Both Factions"] = "Beide Fraktionen"
L["Completed Quests"] = "Abgeschlossene Quests"
L["Configure filtering options for the quest list. These settings are character specific."] = "Konfiguration der Filteroptionen für die Questliste. Diese Einstellungen sind charakterspezifisch." -- Needs review
L["Control the display of specific quest statuses"] = "Kontrolliere die Anzeige für spezifischen Quest Status" -- Needs review
L["Customize how your quest list is sorted.  Higher Weight moves the items to the top of the list, lower weight goes to the bottom.  Sort order Ascending: A-Z 0-9, Descending: Z-A, 9-0."] = "Passe die Sortierung deiner Questliste an. Ein höheres Gewicht bewegt die Einträge zum Anfang der Liste, niedriges Gewicht zum Ende. Sortierreihenfolge ausfsteigend: A-Z 0-9, absteigend: Z-A. 9-0." -- Needs review
L["Daily Quests"] = "Tägliche Quests"
L["Descending"] = "Absteigend" -- Needs review
L["Direction"] = "Richtung" -- Needs review
L["Dungeon Quests"] = "Dungeon Quests"
L["EQ_DESC"] = "EveryQuest erlaubt es dir deine abgeschlossenen Quests in einer nutzerfreundlichen Liste zu verfolgen. Es zeigt dir ebenso, welche Quests in welchem Gebiet verfügbar sind. Kombiniere dieses Addon mit LightHeaded und TomTom für die ultimative Quest Erfahrung." -- Needs review
L["EQ_LOCALLIST"] = "Warnung: Lokalisierung der Questliste kann zu zufälligen Verbindungsabbrüchen führen. Das rührt daher, dass der Server nach einem Quest-Tooltip gefragt wird, wobei der Server möglicherweise das Quest nicht kennt." -- Needs review
L["Enable Filtering"] = "Filter aktivieren"
L["Example for Ignored quest: Some quests are still in Wowhead's database but are not attainable ingame anymore. Ignore them to hide them from the list."] = "Beispiel für ignoriertes Quest: Einige Quests sind noch in der Wowhead-Datenbank obwohl sie nicht mehr im Spiel verfügbar sind. Ignoriere diese um sie aus der Liste zu verbannen." -- Needs review
L["Faction Filter"] = "Fraktionsfilter"
L["Failed or Abandoned Quests"] = "Fehlgeschlagene oder abgebrochene Quests"
L["Filter Quests by Level"] = "Quests nach Level filtern"
L["Filter Quests by Type"] = "Quests nach Typ filtern"
L["General Settings"] = "Allgemeine Einstellungen"
L["Group Quests"] = "Gruppenquests"
L["Heroic Quests"] = "Heroische Quests"
L["Horde"] = "Horde"
L["Ignored Quests"] = "Ignorierte Quests"
L["Level Filter"] = "Level Filter" -- Needs review
L["List Order"] = "Sortierreihenfolge" -- Needs review
L["Localized Quest List"] = "Lokalisierte Quest-Liste" -- Needs review
L["Maximum Level"] = "Maximallevel"
L["Minimum Level"] = "Minimallevel"
L["More Numbers"] = "Mehr Zahlen"
L["No Side/No Data"] = "Keine Seite/Keine Daten" -- Needs review
L["Normal Quests"] = "Normale Quests"
L["Note: Stores localized quest titles in the global database"] = "Bemerkung: Speichert die deutschen Quest-Titel in der globalen Datenbank" -- Needs review
L["Order by Daily"] = "Sortiere nach täglich" -- Needs review
L["Order by Level"] = "Sortiere nach Level" -- Needs review
L["Order by Name"] = "Sortiere nach Name" -- Needs review
L["Order by Type"] = "Sortiere nach Typ" -- Needs review
L["Order by Weekly"] = "Sortiere nach wöchentlich" -- Needs review
L["Other"] = "Andere" -- Needs review
L["Purge Old data"] = "Alte Daten löschen"
L["Purge Old database data, generally used after running upgrade"] = "Alte Daten löschen wird gewöhnlich nach einem Upgrade benutzt" -- Needs review
L["PvP Quests"] = "PvP Quests"
L["Quests In Progress"] = "Quests in Arbeit" -- Needs review
L["Raid Quests"] = "Raid Quests"
L["Removes 'shown' from the displayed numbers, adds a counts of each status shown."] = "Entfernt 'Angezeigt' von den dargestellten Zahlen. Fügt einen Zähler zu jedem angezeigten Status hinzu." -- Needs review
L["Save Zone"] = "Gebiet speichern" -- Needs review
L["Saves which zone you where last looking at to load upon login"] = "Speichert in welchem Gebiet du zuletzt warst um dieses bei der Anmeldung zu laden" -- Needs review
L["Show Debugging Messages"] = "Debug Nachrichten anzeigen"
L["Show Debugging Messages - *WARNING* Spams your default chat frame"] = "Debug Nachrichten anzeigen - *WARNUNG* Führt zu vielen Nachrichten im normalen Chatfenster"
L["Show quests for specific faction"] = "Zeige Quests für eine bestimmte Fraktion"
L["Shows 'group suggested' quests"] = "Zeige Gruppen Quests"
L["Shows 'raid suggested' quests"] = "Zeige Raid Quests" -- Needs review
L["Shows Alliance Quests"] = "Zeige Allianz Quests"
L["Shows Horde Quests"] = "Zeige Horde Quests"
L["Shows PVP quests"] = "Zeige PvP Quests"
L["Shows completed quests still in your questlog"] = "Zeige abgeschlossene Quests im Questlog"
L["Shows daily quests"] = "Zeige Tägliche Quests"
L["Shows dungeon quests"] = "Zeige Dungeon Quests"
L["Shows heroic quests"] = "Zeige Heroische Quests"
L["Shows normal Blizzard soloable quests"] = "Zeige normale Solo Quests"
L["Shows quests that are available to both factions"] = "Zeige Quests welche für beide Fraktionen verfügbar sind" -- Needs review
L["Shows quests that don't have a side or don't have data for a specific side"] = "Zeige Quests welche keiner Seite zugeordnet sind bzw. keine Daten für eine spezifische Seite haben" -- Needs review
L["Shows quests that you are on but not completed"] = "Zeige angefangene aber nicht abgeschlossene Quests" -- Needs review
L["Shows quests that you have failed or abandoned"] = "Zeige fehlgeschlagene oder abgebrochene Quests"
L["Shows quests turned back into NPCs"] = "Zeige Quests die bei NPCs abgegeben wurden" -- Needs review
L["Shows quests you haven't seen before"] = "Zeige Quests, die du noch nie gehabt hast"
L["Shows quests you've ignored"] = "Zeige ignorierte Quests"
L["Shows weekly quests"] = "Zeige wöchentliche Quests"
L["Status Filter"] = "Status Filter"
L["Track Zone"] = "Gebiet überwachen" -- Needs review
L["Track zone changes and update the EveryQuest list for that zone"] = "Überwache Gebietswechsel und aktualisiere die EveryQuest Liste für dieses Gebiet" -- Needs review
L["Turned In Quests"] = "Abgegebene Quests"
L["Type Filter"] = "Typ Filter"
L["Unknown Status"] = "Unbekannter Status"
L["Upgrade DB"] = "Datenbank aktualisieren"
L["Upgrade the Database from the old format"] = "Datenbank vom alten Format aktualisieren"
L["Weekly Quests"] = "Wöchentliche Quests" -- Needs review
L["Weight"] = "Gewicht" -- Needs review


-- query.lua
L["Added %d quests to your database"] = "%d Quests wurden zur Datenbank hinzugefügt"
L["Auto Populate"] = "Automatisch veröffentlichen"
L["Consider uploading your WTF\\Account\\{account name}\\SavedVariables\\EveryQuest.lua to http://wow.kandarz.com/everyquest/upload.html"] = "Erwäge WTF\\\\Account\\\\{account name}\\\\SavedVariables\\\\EveryQuest.lua an der Adresse http://wow.kandarz.com/everyquest/upload.html hochzuladen." -- Needs review
L["EQ_QUERY"] = [=[|cffFFFF00NEU IN 3.3!|r

In diesem 2 Schritt Prozess kann EveryQuest deinen kompletten Questverlauf vom Blizzard Server holen! Finde all die Quests welche du vor der Nutzung von EveryQuest verpasst hast.

  |cff00E1FFSchritt 1:|r Klicke um den Server abzufragen.]=] -- Needs review
L["EQ_QUERY2"] = "  |cff00E1FFSchritt 2:|r Klicke um deine Datenbank zu befüllen. Sei gewarnt, abhängig von der Anzahl deiner abgeschlossenen Quests kann dies einige Zeit dauern und das Spiel wird während dieses Prozesses 'einfrieren'. Ich hoffe die Verbindung wird nicht getrennt." -- Needs review
L["EQ_QUERY_TRAILER"] = [=[  |cff00E1FFAlles erledigt!|r

Wenn du eine rote Nachricht im Chatfenster bekommen hast, bedeutet dies, dass die aktuelle EveryQuest Datenbank keine erledigten Quests enthält. Mach dir deshalb keine Sorgen, Blizzards Log enthält spezielle Quests welche du niemals zu jemandem zurück gebracht hast. Solche wie |cffFFFF00[FLAG: Tournament Invitation]|r]=] -- Needs review
L["Once the server responds, automatically start the import of quest data"] = "Starte den Import der Quest Daten automatisch, sobald der Server antwortet" -- Needs review
L["Once you recieve the server responce, populate the database with your completed quests."] = "Fülle die Datenbank automatisch mit deinen abgeschlossenen Quests sobald du die Serverantwort erhältst." -- Needs review
L["Populate History"] = "Verlauf veröffentlichen"
L["Populate History: %d quests not found in the database."] = "Verlauf veröffentlicht: %d Quests nicht in der Datenbank gefunden" -- Needs review
L["Populating your quest history from the server, this may take a while and might freeze your game."] = "Befülle den Questverlauf vom Server. Dies kann einige Zeit dauern und das Spiel einfrieren." -- Needs review
L["Query Server"] = "Server abfragen"
L["Querying Server for your quest history"] = "Server wird nach Questverlauf abgefragt"
L["Ready to populate your quest history from server"] = "Bereit, den Questverlauf mit den Serverdaten zu befüllen" -- Needs review


-- zonemenu.lua
L["Ahn'Qiraj War Effort"] = "Krieg von Ahn'Qiraj"
L["Alchemy"] = "Alchemie"
L["All"] = "Alle"
L["Battlegrounds"] = "Schlachtfelder"
L["Blacksmithing"] = "Schmiedekunst"
L["Brewfest"] = "Braufest"
L["Burning Crusade"] = "Burning Crusade"
L["Children's Week"] = "Kinderwoche"
L["Classes"] = "Klassen"
L["Classic"] = "Classic"
L["Cooking"] = "Kochkunst"
L["Dalaran Crater"] = "Dalarankrater" -- Needs review
L["Darkmoon Faire"] = "Dunkelmond-Jahrmarkt"
L["Day of the Dead"] = "Tag der Toten"
L["Dungeons"] = "Dungeons"
L["Engineering"] = "Ingenieurskunst"
L["Epic"] = "Episch"
L["First Aid"] = "Erste Hilfe"
L["Fishing"] = "Angeln"
L["Hallow's End"] = "Schlotternächte"
L["Harvest Festival"] = "Erntedankfest"
L["Herbalism"] = "Kräuterkunde"
L["Inscription"] = "Inschriftenkunde"
L["Jewelcrafting"] = "Juwelenschleifen"
L["Leatherworking"] = "Lederverarbeitung"
L["Legendary"] = "Legendär"
L["Love is in the Air"] = "Liebe liegt in der Luft"
L["Lunar Festival"] = "Mondfest"
L["Midsummer Fire Festival"] = "Sonnenwende"
L["Miscellaneous"] = "Verschiedenes"
L["New Year's Eve"] = "Neujahr"
L["Noblegarden"] = "Nobelgarten"
L["Pilgrim's Bounty"] = "Die Pilgerfreuden"
L["Professions"] = "Berufe"
L["Raids"] = "Schlachtzüge"
L["Reputation"] = "Ruf"
L["Scourge Invasion"] = "Invasion der Geißel"
L["Skettis"] = "Skettis"
L["Tailoring"] = "Schneiderei"
L["The Black Temple"] = "Der Schwarze Tempel"
L["Timbermaw Hold"] = "Holzschlundfeste"
L["Tournament"] = "Argentumturnier"
L["Winter Veil"] = "Winterhauch"
L["World Events"] = "Weltereignisse" -- Needs review
L["Wrath of the Lich King"] = "Wrath of the Lich King"
