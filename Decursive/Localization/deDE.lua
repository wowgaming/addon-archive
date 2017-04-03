--[[
    This file is part of Decursive.
    
    Decursive (v 2.5.1-6-gd3885c5) add-on for World of Warcraft UI
    Copyright (C) 2006-2007-2008-2009 John Wellesz (archarodim AT teaser.fr) ( http://www.2072productions.com/?to=decursive.php )

    This is the continued work of the original Decursive (v1.9.4) by Quu
    "Decursive 1.9.4" is in public domain ( www.quutar.com )

    Decursive is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Decursive is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Decursive.  If not, see <http://www.gnu.org/licenses/>.
--]]
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- German localization
-------------------------------------------------------------------------------

--[=[
--                      YOUR ATTENTION PLEASE
--
--         !!!!!!! TRANSLATORS TRANSLATORS TRANSLATORS !!!!!!!
--
--    Thank you very much for your interest in translating Decursive.
--    Do not edit those files. Use the localization interface available at the following address:
--
--      ################################################################
--      #  http://wow.curseforge.com/projects/decursive/localization/  #
--      ################################################################
--
--    Your translations made using this interface will be automatically included in the next release.
--
--]=]

local addonName, T = ...;
-- big ugly scary fatal error message display function {{{
if not T._FatalError then
-- the beautiful error popup : {{{ -
StaticPopupDialogs["DECURSIVE_ERROR_FRAME"] = {
    text = "|cFFFF0000Decursive Error:|r\n%s",
    button1 = "OK",
    OnAccept = function()
        return false;
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    showAlert = 1,
    }; -- }}}
T._FatalError = function (TheError) StaticPopup_Show ("DECURSIVE_ERROR_FRAME", TheError); end
end
-- }}}
if not T._LoadedFiles or not T._LoadedFiles["enUS.lua"] then
    if not DecursiveInstallCorrupted then T._FatalError("Decursive installation is corrupted! (enUS.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end

local L = LibStub("AceLocale-3.0"):NewLocale("Decursive", "deDE");

if not L then
    T._LoadedFiles["deDE.lua"] = "2.5.1-6-gd3885c5";
    return;
end;


L["ABOLISH_CHECK"] = "Zuvor überprüfen ob Reinigung nötig"
L["ABOUT_AUTHOREMAIL"] = "E-MAIL DES ENTWICKLERS"
L["ABOUT_CREDITS"] = "VERDIENST"
L["ABOUT_LICENSE"] = "LIZENZ"
L["ABOUT_NOTES"] = "Anzeige und Reinigung von Gebrechen für Solo, Gruppe und Schlachtzug mit erweitertem Filter- und Prioritäten-System."
L["ABOUT_OFFICIALWEBSITE"] = "OFFIZIELLE WEBSEITE"
L["ABOUT_SHAREDLIBS"] = "GEMEINSAM GENUTZTE SAMMLUNGEN"
L["ABSENT"] = "Fehlt (%s)"
L["AFFLICTEDBY"] = "%s Befallen"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "Zeige Anzahl der Betroffenen: "
L["ANCHOR"] = "Decursive Textfenster"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "Micro-Unit-Fenster anzeigen oder verstecken"
L["BINDING_NAME_DCRPRADD"] = "Ziel zur Prioritätenliste hinzufügen"
L["BINDING_NAME_DCRPRCLEAR"] = "Prioritätenliste leeren"
L["BINDING_NAME_DCRPRLIST"] = "Prioritätenliste ausgeben"
L["BINDING_NAME_DCRPRSHOW"] = "Zeige/Verstecke die Prioritätenliste UI"
L["BINDING_NAME_DCRSHOW"] = "Zeige/Verstecke Decursive Main Bar"
L["BINDING_NAME_DCRSHOWOPTION"] = "Feststehendes Optionsfeld anzeigen"
L["BINDING_NAME_DCRSKADD"] = "Ziel zur Ignorierliste hinzufügen"
L["BINDING_NAME_DCRSKCLEAR"] = "Ignorierliste leeren"
L["BINDING_NAME_DCRSKLIST"] = "Ignorierliste ausgeben"
L["BINDING_NAME_DCRSKSHOW"] = "Zeige/Verstecke die Ignorierliste UI"
L["BLACK_LENGTH"] = "Sekunden auf der Blacklist: "
L["BLACKLISTED"] = "Black-listed"
L["CHARM"] = "Verführung/Übernommen/Gedankenkontrolle"
L["CLASS_HUNTER"] = "Jäger"
L["CLEAR_PRIO"] = "C"
L["CLEAR_SKIP"] = "C"
L["COLORALERT"] = "Warnfarbe einstellen, wenn ein '%s' benötigt wird."
L["COLORCHRONOS"] = "Chronometer"
L["COLORCHRONOS_DESC"] = "Chronometer-Farbe einstellen"
L["COLORSTATUS"] = "Farbe für '%s' MUF-Status einstellen."
L["CTRL"] = "Strg"
L["CURE_PETS"] = "Scanne und reinige Pets"
L["CURSE"] = "Fluch"
L["DEBUG_REPORT_HEADER"] = [=[|cFF11FF33Bitte sende den Inhalt dieses Fensters an Archarodim+DcrReport@teaser.fr|r
|cFF009999(Benutze Strg+A, um alles zu markieren, und dann Strg+C, um den Text in deine Zwischenablage zu kopieren)|r
Bitte berichte ebenfalls, ob du merkwürdiges Verhalten von Decursive bemerkt hast.
]=]
L["DECURSIVE_DEBUG_REPORT"] = " **** |cFFFF0000Decursive-Debug-Bericht|r ****"
L["DECURSIVE_DEBUG_REPORT_NOTIFY"] = [=[Ein Debug-Bericht ist vorhanden!
Gib |cFFFF0000/dcr general report|r ein, um ihn zu sehen.]=]
L["DECURSIVE_DEBUG_REPORT_SHOW"] = "Debug Report verfügbar !"
L["DECURSIVE_DEBUG_REPORT_SHOW_DESC"] = "Zeigt einen Debug Report an der für den Author wichtig ist...."
L["DEFAULT_MACROKEY"] = "NONE"
L["DEV_VERSION_ALERT"] = [=[Du benutzt eine Entwickler-Version von Decursive.

Falls du nicht teilhaben willst am Testen neuer Features/Fehlerbehebungen, Erhalten von Fehlerbehebungsberichten im Spiel, Probleme oder Anfragen senden möchtest an den Entwickler, dann VERWENDE DIESE VERSION NICHT und lade die letzte stabile Version herunter bei curse.com oder wowace.com.

Diese Mitteilunge wird nur einmal pro Version in den Chat ausgegeben.]=]
L["DEV_VERSION_EXPIRED"] = [=[Diese Entwickler-Version von Decursive ist abgelaufen.
Du solltest die neueste Entwickler-Version herunterladen oder zurückgehen zur aktuellen stabilen Release-Version, die du bei CURSE.COM oder WAWACE.COM findest.
Diese Warnung wird alle zwei Tage angezeigt.]=]
L["DEWDROPISGONE"] = "Es gibt kein Äquivalent zu DewDrop für Ace3. Alt-Rechts-Klicken, um das Optionsfeld zu öffnen."
L["DISABLEWARNING"] = [=[Decursive wurde ausgeschaltet!

Um es erneut zu aktivieren, gib |cFFFFAA44/DCR ENABLE|r ein.]=]
L["DISEASE"] = "Krankheit"
L["DONOT_BL_PRIO"] = "Keine Namen der Prioritätenliste bannen"
L["FAILEDCAST"] = [=[|cFF22FFFF%s %s|r |cFFAA0000gescheitert bei|r %s
|cFF00AAAA%s|r]=]
L["FOCUSUNIT"] = "Focus Einheit"
L["FUBARMENU"] = "FuBar Menu"
L["FUBARMENU_DESC"] = "Setzt die Optionen relativ zum FuBar Icon"
L["GLOR1"] = "In Gedenken an Glorfindal"
L["GLOR2"] = [=[Decursive ist Bertrand gewidmet, der uns viel zu früh verlassen hat.
Er wird immer in Erinnerung bleiben.]=]
L["GLOR3"] = [=[In Gedenken an Bertrand Sense
1969 - 2007]=]
L["GLOR4"] = [=[Freundschaft und Zuneigung haben ihre Wurzeln überall, die, die Glorfindal in World of Warcraft getroffen haben kennen einen Menschen großen Einsatzes und einen charismatischen Leiter.

Er war im echten Leben wie im Spiel, Selbstlos, Grosszügig, immer für seine Freunde da und vor allem ein enthusiastischer Mensch.

Er verließ uns mit 38 und lies nicht nur Anonyme Spieler in einer Virtuellen Welt, sondern echte Freunde zurück, die ihn immer vermissen werden.]=]
L["GLOR5"] = "Er wird immer in Erinnerung bleiben..."
L["HANDLEHELP"] = "Alle Micro-Unit-Fenster (MUFs) verschieben"
L["HIDE_LIVELIST"] = "Verstecke die Live-Liste"
L["HIDE_MAIN"] = "Verstecke Decursive Fenster"
L["HIDESHOW_BUTTONS"] = "Verbergen-/Anzeigen-Schaltflächen"
L["HLP_LEFTCLICK"] = "Linksklick"
L["HLP_LL_ONCLICK_TEXT"] = [=[Das Klicken auf die aktuelle Liste ist nicht mehr möglich seit WoW 2.0. Lies bitte die Datei "Readme.txt" in deinem Decursive-Ordner...
(Um diese Liste zu bewegen, bewege die Decursive-Leiste, /dcrshow und Links-Alt-Klick zum Bewegen)]=]
L["HLP_MIDDLECLICK"] = "Mittlere Maustaste"
L["HLP_NOTHINGTOCURE"] = "Es gibt nichts zu Heilen!"
L["HLP_RIGHTCLICK"] = "Rechtsklick"
L["HLP_USEXBUTTONTOCURE"] = "Benutze \"%s\" um dieses Gebrechen zu Heilen!"
L["HLP_WRONGMBUTTON"] = "Falscher Mausbutton!"
L["IGNORE_STEALTH"] = "Ignoriere getarnte Einheiten"
L["IS_HERE_MSG"] = "Decursive wurde geladen, kontrolliere bitte die Einstellungen"
L["LIST_ENTRY_ACTIONS"] = [=[|cFF33AA33[CTRL]|r-Click: Entfernt den Spieler
|cFF33AA33LEFT|r-Click: Diesen Spieler eins nach oben setzen
|cFF33AA33RIGHT|r-Click: Diesen Spieler eins nach unten setzen
|cFF33AA33[SHIFT] LEFT|r-Click: Setzt den Spieler ganz nach oben
|cFF33AA33[SHIFT] RIGHT|r-Click: Setzt den Spieler ganz nach unten]=]
L["MACROKEYALREADYMAPPED"] = [=[Warnung: Die Taste zu dem Decursive macro [%s] ist an Aktion gebunden '%s'.
Decursive wird es auf die vorherige Einstellung zurück setzen wenn du eine andere Taste für das Marko auswählst.]=]
L["MACROKEYMAPPINGFAILED"] = "Die Taste [%s] kann nicht an das Decursive-Macro gebunden werden"
L["MACROKEYMAPPINGSUCCESS"] = "Die Taste [%s] wurde erfolgreich an das Decursive-Macro gebunden"
L["MACROKEYNOTMAPPED"] = "Decursive mouse-over Makro ist nicht an eine Taste gebunden, schau in der Option \"Makro\" (Interface) nach "
L["MAGIC"] = "Magie"
L["MAGICCHARMED"] = "Magie Zauber"
L["MISSINGUNIT"] = "Fehlende Einheit"
L["NORMAL"] = "Normal"
L["NOSPELL"] = "Kein Zauber verfügbar"
L["OPT_ABOLISHCHECK_DESC"] = "Wähle, ob Einheiten mit einem aktiven \"Aufheben\"-Zauber angezeigt und geheilt werden sollen."
L["OPT_ABOUT"] = "Über"
L["OPT_ADDDEBUFF"] = "Ein Gebrechen manuell hinzufügen"
L["OPT_ADDDEBUFF_DESC"] = "Ein neues Gebrechen der Liste hinzufügen"
L["OPT_ADDDEBUFFFHIST"] = "Erneuertes Gebrechen hinzufügen."
L["OPT_ADDDEBUFFFHIST_DESC"] = "Ein Gebrechen anhand der Historie hinzufügen"
L["OPT_ADDDEBUFF_USAGE"] = "<Affliction name>"
L["OPT_ADVDISP"] = "Erweiterte Anzeigeeinstellungen"
L["OPT_ADVDISP_DESC"] = "Erlauben, die Transparenz des Rands und der Mitte getrennt einzustellen, den Abstand zwischen jedem MUF einzustellen."
L["OPT_AFFLICTEDBYSKIPPED"] = "%s betroffen von %s, wird jedoch übersprungen"
L["OPT_ALWAYSIGNORE"] = "Auch ignorieren wenn nicht im Kampf"
L["OPT_ALWAYSIGNORE_DESC"] = "Falls Markiert, wird dieses Gebrechen auch dann ignoriert, wenn du dich nicht im Kampf befindest."
L["OPT_AMOUNT_AFFLIC_DESC"] = "Definiert die maximale Anzahl der anzuzeigenden Verfluchten in der aktuellen Liste"
L["OPT_ANCHOR_DESC"] = "Zeigt Anker des Rahmens der allgemeinen Mitteilungen an"
L["OPT_AUTOHIDEMFS"] = "Automatisch verstecken"
L["OPT_AUTOHIDEMFS_DESC"] = "Wähle, wann das MUF-Fenster verborgen werden soll."
L["OPT_BLACKLENTGH_DESC"] = "Definiert wie lange ein Spieler auf der Blacklist steht. "
L["OPT_BORDERTRANSP"] = "Rahmen-Transparenz"
L["OPT_BORDERTRANSP_DESC"] = "Rahmen-Transparenz setzten"
L["OPT_CENTERTRANSP"] = "Transparenz Mitte"
L["OPT_CENTERTRANSP_DESC"] = "Transparenz der Mitte einstellen"
L["OPT_CHARMEDCHECK_DESC"] = "Wenn markiert, bist du in der Lage, bezauberte Einheiten zu sehen und zu behandeln."
L["OPT_CHATFRAME_DESC"] = "Decursive Nachrichten werden im Standart Bildfeld ausgegeben."
L["OPT_CHECKOTHERPLAYERS"] = "Andere Spieler überprüfen"
L["OPT_CHECKOTHERPLAYERS_DESC"] = "Zeigt Decursive-Version den Spielern in deiner aktuellen Gruppe oder Gilde an (kann nicht Versionen vor Decursive 2.4.6 anzeigen)."
L["OPT_CREATE_VIRTUAL_DEBUFF"] = "Erzeuge eine virtuelle Test Krankheit/Gebrechen"
L["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = "Lässt dich sehen, wie es aussieht, wenn ein Gebrechen gefunden wurde."
L["OPT_CUREPETS_DESC"] = "Begleiter werden bearbeitet und geheilt"
L["OPT_CURINGOPTIONS"] = "Aktuelle Einstellungen"
L["OPT_CURINGOPTIONS_DESC"] = "Verschiedene Aspekte des Heilungsprozesses einstellen"
L["OPT_CURINGOPTIONS_EXPLANATION"] = [=[
Wähle die Arten von Gebrechen, die du heilen möchtest. Nicht markierte Typen werden komplett von Decursive ignoriert.

Die grüne Zahl legt die Priorität des Gebrechens fest. Diese Priorität beeinflußt mehrere Aspekte:
- Was Decursive als erstes anzeigt, wenn ein Spieler an verschiedenen Debuff-Typen leidet.
- Welche Maus-Schaltfläche du klicken mußt, um den jeweiligen Debuff zu heilen (Erster Zauber ist Linksklick, zweiter ist Rechtsklick, etc...).

All dies wird in der Dokumentation genau erklärt (muß gelesen werden):
http://www.wowace.com/addons/decursive/
]=]
L["OPT_CURINGORDEROPTIONS"] = "Aktuelle Sortierungseinstellungen"
L["OPT_CURSECHECK_DESC"] = "Falls markiert, bist du in der Lage, verfluchte Einheiten zu sehen und zu heilen."
L["OPT_DEBCHECKEDBYDEF"] = [=[

Standardmäßig markiert]=]
L["OPT_DEBUFFENTRY_DESC"] = "Auswählen welche Klasse im Kampf ignoriert werden soll wenn sie von dieser Krankheit betroffen ist."
L["OPT_DEBUFFFILTER"] = "Gebrechen gefilter"
L["OPT_DEBUFFFILTER_DESC"] = "Wähle Gebrechen anhand des Namens und der Klasse welches innerhalb des Kampfes gefiltert werden soll."
L["OPT_DISABLEMACROCREATION"] = "Deaktiviert Makro erstellung"
L["OPT_DISABLEMACROCREATION_DESC"] = "Decursive-Makro wird nicht mehr kreiert oder erhalten"
L["OPT_DISEASECHECK_DESC"] = "Wenn Aktiv, die Möglichkeit erkrankte Einheiten zu sehen und zu heilen."
L["OPT_DISPLAYOPTIONS"] = "Anzeigeoptionen"
L["OPT_DONOTBLPRIO_DESC"] = "Einheiten auf der Prioritätenliste werden nicht in die Blacklist übernommen."
L["OPT_ENABLEDEBUG"] = "Fehlersuche zulassen"
L["OPT_ENABLEDEBUG_DESC"] = "Ausgabe der Fehlersuche zulassen"
L["OPT_ENABLEDECURSIVE"] = "Decursive aktivieren"
L["OPT_FILTEROUTCLASSES_FOR_X"] = "%q wird bei den spezifizierten Klassen ignoriert während du dich im Kampf befindest."
L["OPT_GENERAL"] = "Allgemeine Optionen"
L["OPT_GROWDIRECTION"] = "MUF-Anzeige umkehren"
L["OPT_GROWDIRECTION_DESC"] = "Das MUF von unten nach oben anzeigen"
L["OPT_HIDELIVELIST_DESC"] = "Wenn nicht versteckt, zeigt eine Informations Leiste von Spielern mit Flüchen"
L["OPT_HIDEMFS_GROUP"] = "Solo/Gruppe"
L["OPT_HIDEMFS_GROUP_DESC"] = "Das MUF verstecken wenn du nicht im Raid bist"
L["OPT_HIDEMFS_NEVER"] = "Nie"
L["OPT_HIDEMFS_NEVER_DESC"] = "Das MUF-Fenster nie automatisch verstecken."
L["OPT_HIDEMFS_SOLO"] = "Solo"
L["OPT_HIDEMFS_SOLO_DESC"] = "Das MUF-Fenster verstecken wenn du in keiner Gruppe oder Raidgruppe bist."
L["OPT_HIDEMUFSHANDLE"] = "MUF-Handhabung verbergen"
L["OPT_HIDEMUFSHANDLE_DESC"] = [=[Verbirgt die Handhabung der Mikro-Einheiten-Rahmen und schaltet die Möglichkeit aus, diese zu bewegen.
Benutze denselben Befehl, um diese wiederherzustellen.]=]
L["OPT_IGNORESTEALTHED_DESC"] = "Verhüllte/Versteckte Einheiten werden ignoriert"
L["OPTION_MENU"] = "Decursive Einstellungen"
L["OPT_LIVELIST"] = "Live-Liste"
L["OPT_LIVELIST_DESC"] = "Optionen für die Live-Liste"
L["OPT_LLALPHA"] = "Transparenz Live-Liste"
L["OPT_LLALPHA_DESC"] = "Andert die Decursive Haupt und Live Leiste Transparenz (Haupt Leiste muss sichtbar sein)"
L["OPT_LLSCALE"] = "Skalierung der Live-Liste"
L["OPT_LLSCALE_DESC"] = "Setzt die Größe der Decursive Hauptleiste und der Live-Liste (Hauptleiste muss angezeigt werden)"
L["OPT_LVONLYINRANGE"] = "Nur Einheiten in Reichweite"
L["OPT_LVONLYINRANGE_DESC"] = "Nur Einheiten in Dispelreichweite werden in der Live-Liste angezeigt"
L["OPT_MACROBIND"] = "Tastkombination für das Macro setzen"
L["OPT_MACROBIND_DESC"] = [=[Definiert die Taste mit der das 'Decursive' Makro aufgerufen wird

Wähle die gewünschte Taste und drück die Taste "Enter" um die Zuordnung abzuschliessen (Mit dem Mouse Over Curso über dem Edit Feld)
]=]
L["OPT_MACROOPTIONS"] = "Macro-Optionen"
L["OPT_MACROOPTIONS_DESC"] = "Das Verhalten des Decursive-Macros festlegen"
L["OPT_MAGICCHARMEDCHECK_DESC"] = "Wenn Aktiv, ist es möglich mit Magie verzauberte Einheiten zu sehen und zu heilen."
L["OPT_MAGICCHECK_DESC"] = "Wenn Aktiv, ist es möglich mit Magie befallene Einheiten zu sehen und zu heilen."
L["OPT_MAXMFS"] = "Maximale Anzahl an Einheiten die angezeigt werden sollen"
L["OPT_MAXMFS_DESC"] = "Definiert die maximale Anzahl an Mikro-Unitframes die angezeigt werden sollen"
L["OPT_MESSAGES"] = "Nachrichten"
L["OPT_MESSAGES_DESC"] = "Optionen über Nachrichten Anzeige"
L["OPT_MFALPHA"] = "Transparenz"
L["OPT_MFALPHA_DESC"] = "Abweichende Transparenz der MUF's wenn Einheiten nicht betroffen sind"
L["OPT_MFPERFOPT"] = "Performance-Einstellungen"
L["OPT_MFREFRESHRATE"] = "Aktualisierungsrate"
L["OPT_MFREFRESHRATE_DESC"] = "Zeit zwischen jedem refresh Aufruf (1 oder mehrere micro-unit-frames können auf einmal aktuallisiert werden)"
L["OPT_MFREFRESHSPEED"] = "Aktualisierungsgeschwindigkeit"
L["OPT_MFREFRESHSPEED_DESC"] = "Anzahl der Micro-Unit-Fenster die in einem Durchgang aktualisiert werden sollen"
L["OPT_MFSCALE"] = "Scalieriung des Micro-Unit-Fensters"
L["OPT_MFSCALE_DESC"] = "Große des Micro-Unit-Fensters setzten"
L["OPT_MFSETTINGS"] = "Einstellungen des Micro-Unit-Fensters"
L["OPT_MFSETTINGS_DESC"] = "Stellt die MUF Fenster Optionen nach deinen Bedürfnissen ein.   "
L["OPT_MUFFOCUSBUTTON"] = "Fokus-Schaltfläche:"
L["OPT_MUFMOUSEBUTTONS"] = "Maus-Schaltflächen"
L["OPT_MUFMOUSEBUTTONS_DESC"] = "Maus-Schaltflächen einstellen, die du für jede Warnfarbe des Mikro-Einheiten-Rahmens benutzen möchtest."
L["OPT_MUFSCOLORS"] = "Farben"
L["OPT_MUFSCOLORS_DESC"] = "Farben des Micro-Unit-Fensters verändern"
L["OPT_MUFTARGETBUTTON"] = "Tiel-Schaltfläche:"
L["OPT_NOKEYWARN"] = "Warnen wenn keine Tastenbelegung angegeben"
L["OPT_NOKEYWARN_DESC"] = "Warnen wenn keine Tastenbelegung angegeben"
L["OPT_NOSTARTMESSAGES"] = "Begrüssungsmitteilungen ausschalten"
L["OPT_NOSTARTMESSAGES_DESC"] = "Die drei Mitteilungen entfernen, die Decursive bei jedem Einloggen im Chat-Rahmen ausgibt."
L["OPT_PLAYSOUND_DESC"] = "Einen Ton abspielen wenn jemand von einem Fluch betroffen ist"
L["OPT_POISONCHECK_DESC"] = "Wenn Aktiv, ist es möglich vergiftete Einheiten zu sehen und zu heilen."
L["OPT_PRINT_CUSTOM_DESC"] = "Decursive-Nachrichten werden in einem eigenen Chat-Fenster angezeigt"
L["OPT_PRINT_ERRORS_DESC"] = "Fehler werden angezeigt"
L["OPT_PROFILERESET"] = "Profil zurückgestetzt..."
L["OPT_RANDOMORDER_DESC"] = "Einheiten werden Angezeigt und in zufälliger Reihenfolge geheilt(Nicht empfohlen)"
L["OPT_READDDEFAULTSD"] = "RE-ADD Standart Gebrechen "
L["OPT_READDDEFAULTSD_DESC1"] = [=[Fügt fehlende Decursive standart Gebrechen zu dieser Liste.
Deine Einstellungen werden nicht geändert. ]=]
L["OPT_READDDEFAULTSD_DESC2"] = "Alle Decursive standart Gebrechen sind in dieser Liste. "
L["OPT_REMOVESKDEBCONF"] = [=[ Bist du sicher du wills '%s' entfernen aus der Decursive Krankheiten Liste ?
]=]
L["OPT_REMOVETHISDEBUFF"] = "Dieses Gebrechen entfernen"
L["OPT_REMOVETHISDEBUFF_DESC"] = "Entfernt '%s' von der skip list"
L["OPT_RESETDEBUFF"] = "Resete diese Gebrechen"
L["OPT_RESETDTDCRDEFAULT"] = " Resets '%s' auf Decursive Standart"
L["OPT_RESETMUFMOUSEBUTTONS"] = "Zurücksetzen"
L["OPT_RESETMUFMOUSEBUTTONS_DESC"] = "Zuordnungen der Maus-Schaltflächen auf Standard zurücksetzen."
L["OPT_RESETOPTIONS"] = "Optionen zurücksetzten"
L["OPT_RESETOPTIONS_DESC"] = "Aktuelles Profil zurücksetzten"
L["OPT_RESTPROFILECONF"] = [=[Bist du sicher du willst das Profile
'(%s) %s'
auf die Standart Einstellungen zurück setzen ?]=]
L["OPT_REVERSE_LIVELIST_DESC"] = "Live-Liste von unten nach oben befüllen"
L["OPT_SCANLENGTH_DESC"] = "Zeit zwischen jedem Scanvorgang festlegen"
L["OPT_SHOWBORDER"] = "Zeige Klassenfarbige Umrandung"
L["OPT_SHOWBORDER_DESC"] = "Eine farbliche Umrandung wird um die MUF's angezeigt welche die Unit Klasse darstellt "
L["OPT_SHOWCHRONO"] = "Zeige Zeitmesser"
L["OPT_SHOWCHRONO_DESC"] = "Zeit in Sec. die verstrichen ist seit eine Einheit mit einem Gebrechen befallen ist, wird angezeigt.  "
L["OPT_SHOWCHRONOTIMElEFT"] = "Zeit verbleibend"
L["OPT_SHOWCHRONOTIMElEFT_DESC"] = "Zeige verbleibende Zeit an anstatt bereits verstrichener Zeit."
L["OPT_SHOWHELP"] = "Hilfe anzeigen"
L["OPT_SHOWHELP_DESC"] = "Zeigt einen Detaillierten Tooltip bei Mouse Over über das micro-unit-frame"
L["OPT_SHOWMFS"] = "Micro-Unit-Fenster anzeigen"
L["OPT_SHOWMFS_DESC"] = "Muss aktiv sein wenn du über Mausclick heilen möchtest."
L["OPT_SHOWMINIMAPICON"] = "Minimap Icon"
L["OPT_SHOWMINIMAPICON_DESC"] = "Minimap Icon anzeigen/verstecken"
L["OPT_SHOW_STEALTH_STATUS"] = "Verborgenheitsstatus anzeigen"
L["OPT_SHOW_STEALTH_STATUS_DESC"] = "Wenn sich ein Spieler in Verborgenheit befindet, nimmt sein MUF eine spezielle Farbe an."
L["OPT_SHOWTOOLTIP_DESC"] = "Zeigt einen Detailierten Tooltip über einen Fluch in der Life Liste auf den MUF's "
L["OPT_STICKTORIGHT"] = "MUF rechts ausrichten"
L["OPT_STICKTORIGHT_DESC"] = "Das MUF-Fenster wächst von rechts nach links. Falls notwendig, wird der Halter bewegt."
L["OPT_TESTLAYOUT"] = "Test-Layout"
L["OPT_TESTLAYOUT_DESC"] = [=[Erschaffe simulierte Einheiten, so dass du das Anzeige-Layout testen kannst.
(Warte ein paar Sekunden nach dem Klicken!)]=]
L["OPT_TESTLAYOUTUNUM"] = "Einheitsnummer"
L["OPT_TESTLAYOUTUNUM_DESC"] = "Anzahl der zu erschaffenden simulierten Einheiten einstellen."
L["OPT_TIECENTERANDBORDER"] = "Transparenz der Mitte und des Rands miteinander verbinden."
L["OPT_TIECENTERANDBORDER_OPT"] = "Falls markiert, ist die Transparenz des Rands die Hälfte der Transparenz der Mitte."
L["OPT_TIE_LIVELIST_DESC"] = "Die Anzeige der aktuellen Liste ist verbunden mit der Anzeige der Decursive-Leisten."
L["OPT_TIEXYSPACING"] = "Horizontaler und vertikaler Abstand"
L["OPT_TIEXYSPACING_DESC"] = "Der horizontale und vertikale Abstand zwischen MUFs sind gleich."
L["OPT_UNITPERLINES"] = "Anzahl Einheiten pro Zeile"
L["OPT_UNITPERLINES_DESC"] = "Definiert die max. Anzahl an Micro-Unitframes die pro Zeile angezeigt werden sollen."
L["OPT_USERDEBUFF"] = "Diese Krankheit ist nicht Teil von Decursive's standardmässigen Krankheiten."
L["OPT_XSPACING"] = "Horizontaler Abstand"
L["OPT_XSPACING_DESC"] = "Den horizontalen Abstand zwischen MUFs festlegen."
L["OPT_YSPACING"] = "Vertikaler Abstand"
L["OPT_YSPACING_DESC"] = "Den vertikalen Abstand zwischen MUFs festlegen."
L["PLAY_SOUND"] = "Akustische Warnung falls Reinigung nötig"
L["POISON"] = "Gift"
L["POPULATE"] = "P"
L["POPULATE_LIST"] = "Schnellbestücken der Decursive Liste"
L["PRINT_CHATFRAME"] = "Nachrichten im Chat ausgeben"
L["PRINT_CUSTOM"] = "Nachrichten in Bildschirmmitte ausgeben"
L["PRINT_ERRORS"] = "Fehlernachrichten ausgeben"
L["PRIORITY_LIST"] = "Decursive Prioritätenliste"
L["PRIORITY_SHOW"] = "P"
L["RANDOM_ORDER"] = "Reinige in zufälliger Reihenfolge"
L["REVERSE_LIVELIST"] = "Zeige die Live-Liste umgekehrt"
L["SCAN_LENGTH"] = "Sekunden zwischen Live-Scans: "
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "Um das Decursive Fenster anzuzeigen, /dcrshow eingeben"
L["SHOW_TOOLTIP"] = "Zeige Tooltips in der Betroffenenliste"
L["SKIP_LIST_STR"] = "Decursive Ignorierliste"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "Zauber %s gefunden!"
L["STEALTHED"] = "Getarnt"
L["STR_CLOSE"] = "Schließen"
L["STR_DCR_PRIO"] = "Decursive Prioritätenliste"
L["STR_DCR_SKIP"] = "Decursive Ignorierliste"
L["STR_GROUP"] = "Gruppe "
L["STR_OPTIONS"] = "Einstellungen"
L["STR_OTHER"] = "Sonstige"
L["STR_POP"] = "Bestückungsliste"
L["STR_QUICK_POP"] = "Schnellbestücken"
L["SUCCESSCAST"] = "|cFF22FFFF%s %s|r |cFF00AA00Erfolgreich bei|r %s"
L["TARGETUNIT"] = "Zieleinheit"
L["TIE_LIVELIST"] = "Tie live-List Sichtbarkeit zu DCR Fenster"
L["TOOFAR"] = "Zu weit weg"
L["UNITSTATUS"] = "Einheitenstatus:"



T._LoadedFiles["deDE.lua"] = "2.5.1-6-gd3885c5";
