---------------------------------------------------------------------------------
--
-- Prat - A framework for World of Warcraft chat mods
--
-- Copyright (C) 2006-2007  Prat Development Team
--
-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to:
--
-- Free Software Foundation, Inc.,
-- 51 Franklin Street, Fifth Floor,
-- Boston, MA  02110-1301, USA.
--
--
-------------------------------------------------------------------------------

--[[
Name: AltNames
Revision: $Revision $
Author(s): Fin (fin@instinct.org)
Website: http://files.wowace.com/Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#AltNames
Subversion: http://svn.wowace.com/wowace/trunk/Prat/
Discussions: http://groups.google.com/group/wow-prat
Issues and feature requests: http://code.google.com/p/prat/issues/list
Description: Allows people's alt characters to be linked to their mains, which will then be displayed next to their names when found in chat messages (default=off).
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("AltNames")

if PRAT_MODULE == nil then 
    return 
end

local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
	["Start"] = true,
	["AltNames"] = true,
	["module_desc"] = "Allows people's alt characters to be linked to their mains, which can then be displayed next to their names when found in chat messages (default=off).",
	["quiet"] = "Be quiet",
	["quiet_name"] = true,
	["quiet_desc"] = "Whether to report to the chat frame or not.",
	["mainpos_name"] = "Main name position",
	["mainpos_desc"] = "Where to display a character's main name when on their alt.",
	["Main name position"] = true,
	["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = true,
	["Where to display a character's main name when on their alt."] = true,
	["Left"] = true,
	["Right"] = true,
	["Disabled"] = true,
	["Find characters"] = true,
	["Search the list of linked characters for matching main or alt names."] = true,
	["<search term> (eg, /altnames find fin)"] = true,
	["Link alt"] = true,
	["Link someone's alt character with the name of their main."] = true,
	["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = true,
	["Delete alt"] = true,
	["Delete a character's link to another character as their main."] = true,
	["Be quiet"] = true,
	["Whether to report to the chat frame or not."] = true,
	["You have not yet linked any alts with their mains."] = true,
	["no matches found"] = true,
	["List all"] = true,
	["List all links between alts and their main names."] = true,
	["Imports data from LOKWhoIsWho, if present (drop your SavedVariables\LOKWhoIsWho.lua in the Prat directory to be able to use this)."] = true,
	["LOKWhoIsWho import"] = true,
	["Clear all"] = true,
	["Clear all links between alts and main names."] = true,
	["Colour"] = true,
	["The colour of an alt's main name that will be displayed"] = true,
	["Import from guild roster"] = true,
	['Imports alt names from the guild roster by checking for members with the rank "alt" or "alts", or guild / officer notes like "<name>\'s alt"'] = true,
	['Import from Guild Greet database'] = true,
	['Imports alt names from a Guild Greet database, if present'] = true,
	['Use class colour (from the PlayerNames module)'] = true,
	["use class colour of main"] = true,
	["use class colour of alt"] = true,
	["don't use"] = true,
	["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = true,
	["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = true,
	["Don't use data from the PlayerNames module at all"] = true,
	["Import options"] = true,
	["Various ways to import a main's alts from other addons"] = true,
	["Don't overwrite existing links"] = true,
	["Don't overwrite existing alt <-> main links when importing or adding new alts."] = true,
	[".*[Aa]lts?$"] = true,
	["(.-)'s? [Aa]lt"] = "%f[%a\192-\255]([%a\192-\255]+)%f[^%a\128-\255]'s [Aa]lt",
	["([^%s%p%d%c%z]+)'s alt"] = "%f[%a\192-\255]([%a\192-\255]+)%f[^%a\128-\255]'s [Aa]lt",
	['ERROR: some function sent a blank message!'] = true,
	["Alts:"] = true,
	['Main:'] = true,
	["No main name supplied to link %s to"] = true,
	['alt name exists: %s -> %s; not overwriting as set in preferences'] = true,
	['warning: alt %s already linked to %s'] = true,
	["linked alt %s => %s"] = true,
	["character removed: %s"] = true,
	['no characters called "%s" found; nothing deleted'] = true,
	['%s total alts linked to mains'] = true,
	['no alts or mains found matching "%s"'] = true,
	["searched for: %s - total matches: %s"] = true,
	['LOKWhoIsWho lua file not found, sorry.'] = true,
	["LOKWhoIsWho data not found"] = true,
	["%s alts imported from LOKWhoIsWho"] = true,
	['No Guild Greet database found'] = true,
	['You are not in a guild'] = true,
	["guild member alts found and imported: %s"] = true,
	["Fix alts"] = true,
	["Fix corrupted entries in your list of alt names."] = true,
	["Class colour"] = true,
	["Use class colour (from the PlayerNames module)"] = true,
	['Show main in tooltip'] = true,
	["Display a player's main name in the tooltip"] = true,
	['Show alts in tooltip'] = true,
	["Display a player's alts in the tooltip"] = true,
	["Found alt: %s => main: %s"] = true,
	["alt"] = true,
	["main"] = true,
	["Alt"] = true,
	["Main"] = true,
	['no alts found for character '] = true,
	['List alts'] = true,
	['List alts for a given character'] = true,
	['<main> (eg /altnames listalts Fin)'] = true,
	['%d alts found for %s: %s'] = true,
	['No arg string given to :addAlt()'] = true, 
	["Use LibAlts Data"] = true,
	["Use the data available via the shared alt information library."] = true,
	["autoguildalts_name"] = "Auto Import Guild Alts",
	["autoguildalts_desc"] = "Automatically run the import from guild roster command silently",
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	[".*[Aa]lts?$"] = true,
	alt = true,
	Alt = true,
	["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = true,
	["alt name exists: %s -> %s; not overwriting as set in preferences"] = true,
	AltNames = true,
	["Alts:"] = true,
	autoguildalts_desc = "Automatically run the import from guild roster command silently",
	autoguildalts_name = "Auto Import Guild Alts",
	["Be quiet"] = true,
	["character removed: %s"] = true,
	["Class colour"] = true,
	["Clear all"] = true,
	["Clear all links between alts and main names."] = true,
	Colour = true,
	["%d alts found for %s: %s"] = true,
	["Delete a character's link to another character as their main."] = true,
	["Delete alt"] = true,
	Disabled = true,
	["Display a player's alts in the tooltip"] = true,
	["Display a player's main name in the tooltip"] = true,
	["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = true,
	["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = true,
	["Don't overwrite existing alt <-> main links when importing or adding new alts."] = true,
	["Don't overwrite existing links"] = true,
	["don't use"] = true,
	["Don't use data from the PlayerNames module at all"] = true,
	["ERROR: some function sent a blank message!"] = true,
	["Find characters"] = true,
	["Fix alts"] = true,
	["Fix corrupted entries in your list of alt names."] = true,
	["Found alt: %s => main: %s"] = true,
	["guild member alts found and imported: %s"] = true,
	["Import from Guild Greet database"] = true,
	["Import from guild roster"] = true,
	["Import options"] = true,
	["Imports alt names from a Guild Greet database, if present"] = true,
	["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = true,
	["Imports data from LOKWhoIsWho, if present (drop your SavedVariablesLOKWhoIsWho.lua in the Prat directory to be able to use this)."] = true,
	Left = true,
	["Link alt"] = true,
	["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = true,
	["linked alt %s => %s"] = true,
	["Link someone's alt character with the name of their main."] = true,
	["List all"] = true,
	["List all links between alts and their main names."] = true,
	["List alts"] = true,
	["List alts for a given character"] = true,
	["LOKWhoIsWho data not found"] = true,
	["LOKWhoIsWho import"] = true,
	["LOKWhoIsWho lua file not found, sorry."] = true,
	main = true,
	Main = true,
	["Main:"] = true,
	["<main> (eg /altnames listalts Fin)"] = true,
	["Main name position"] = true,
	mainpos_desc = "Where to display a character's main name when on their alt.",
	mainpos_name = "Main name position",
	module_desc = "Allows people's alt characters to be linked to their mains, which can then be displayed next to their names when found in chat messages (default=off).",
	["no alts found for character "] = true,
	["no alts or mains found matching \"%s\""] = true,
	["No arg string given to :addAlt()"] = true,
	["no characters called \"%s\" found; nothing deleted"] = true,
	["No Guild Greet database found"] = true,
	["No main name supplied to link %s to"] = true,
	["no matches found"] = true,
	quiet = "Be quiet",
	quiet_desc = "Whether to report to the chat frame or not.",
	quiet_name = true,
	Right = true,
	["(.-)'s? [Aa]lt"] = "%f[%a\\192-\\255]([%a\\192-\\255]+)%f[^%a\\128-\\255]'s [Aa]lt",
	["%s alts imported from LOKWhoIsWho"] = true,
	["searched for: %s - total matches: %s"] = true,
	["<search term> (eg, /altnames find fin)"] = true,
	["Search the list of linked characters for matching main or alt names."] = true,
	["Show alts in tooltip"] = true,
	["Show main in tooltip"] = true,
	["([^%s%p%d%c%z]+)'s alt"] = "%f[%a\\192-\\255]([%a\\192-\\255]+)%f[^%a\\128-\\255]'s [Aa]lt",
	Start = true,
	["%s total alts linked to mains"] = true,
	["The colour of an alt's main name that will be displayed"] = true,
	["Use class colour (from the PlayerNames module)"] = true,
	["use class colour of alt"] = true,
	["use class colour of main"] = true,
	["Use LibAlts Data"] = true,
	["Use the data available via the shared alt information library."] = true,
	["Various ways to import a main's alts from other addons"] = true,
	["warning: alt %s already linked to %s"] = true,
	["Where to display a character's main name when on their alt."] = true,
	["Whether to report to the chat frame or not."] = true,
	["You are not in a guild"] = true,
	["You have not yet linked any alts with their mains."] = true,
}

)
L:AddLocale("frFR",  
{
	-- [".*[Aa]lts?$"] = "",
	-- alt = "",
	-- Alt = "",
	-- ["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = "",
	-- ["alt name exists: %s -> %s; not overwriting as set in preferences"] = "",
	-- AltNames = "",
	-- ["Alts:"] = "",
	-- autoguildalts_desc = "",
	-- autoguildalts_name = "",
	-- ["Be quiet"] = "",
	-- ["character removed: %s"] = "",
	-- ["Class colour"] = "",
	-- ["Clear all"] = "",
	-- ["Clear all links between alts and main names."] = "",
	-- Colour = "",
	-- ["%d alts found for %s: %s"] = "",
	-- ["Delete a character's link to another character as their main."] = "",
	-- ["Delete alt"] = "",
	-- Disabled = "",
	-- ["Display a player's alts in the tooltip"] = "",
	["Display a player's main name in the tooltip"] = "Affiche le nom principale d'un joueur dans la tooltip",
	-- ["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = "",
	-- ["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = "",
	["Don't overwrite existing alt <-> main links when importing or adding new alts."] = "Ne pas écraser les liens principal <-> Alternatif lors d'un import ou d'un ajout de nouveaux personnages Alternatifs",
	["Don't overwrite existing links"] = "Ne pas écraser les liens existant",
	-- ["don't use"] = "",
	["Don't use data from the PlayerNames module at all"] = "Ne pas utiliser les donnée du module \"PlayerNames\" du tout",
	["ERROR: some function sent a blank message!"] = "ERREUR: une fonction a envoyé un message blanc !",
	["Find characters"] = "Trouver des personnages",
	["Fix alts"] = "Réparer les alternatifs", -- Needs review
	["Fix corrupted entries in your list of alt names."] = "Réparer les entrées corrompues dans votre liste de noms alternatifs.",
	-- ["Found alt: %s => main: %s"] = "",
	-- ["guild member alts found and imported: %s"] = "",
	-- ["Import from Guild Greet database"] = "",
	-- ["Import from guild roster"] = "",
	-- ["Import options"] = "",
	-- ["Imports alt names from a Guild Greet database, if present"] = "",
	-- ["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = "",
	-- ["Imports data from LOKWhoIsWho, if present (drop your SavedVariablesLOKWhoIsWho.lua in the Prat directory to be able to use this)."] = "",
	-- Left = "",
	-- ["Link alt"] = "",
	-- ["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = "",
	-- ["linked alt %s => %s"] = "",
	-- ["Link someone's alt character with the name of their main."] = "",
	-- ["List all"] = "",
	-- ["List all links between alts and their main names."] = "",
	-- ["List alts"] = "",
	-- ["List alts for a given character"] = "",
	-- ["LOKWhoIsWho data not found"] = "",
	-- ["LOKWhoIsWho import"] = "",
	-- ["LOKWhoIsWho lua file not found, sorry."] = "",
	-- main = "",
	-- Main = "",
	-- ["Main:"] = "",
	-- ["<main> (eg /altnames listalts Fin)"] = "",
	-- ["Main name position"] = "",
	-- mainpos_desc = "",
	-- mainpos_name = "",
	-- module_desc = "",
	-- ["no alts found for character "] = "",
	-- ["no alts or mains found matching \"%s\""] = "",
	-- ["No arg string given to :addAlt()"] = "",
	-- ["no characters called \"%s\" found; nothing deleted"] = "",
	-- ["No Guild Greet database found"] = "",
	-- ["No main name supplied to link %s to"] = "",
	-- ["no matches found"] = "",
	-- quiet = "",
	-- quiet_desc = "",
	-- quiet_name = "",
	Right = "Droite",
	-- ["(.-)'s? [Aa]lt"] = "",
	-- ["%s alts imported from LOKWhoIsWho"] = "",
	-- ["searched for: %s - total matches: %s"] = "",
	-- ["<search term> (eg, /altnames find fin)"] = "",
	-- ["Search the list of linked characters for matching main or alt names."] = "",
	-- ["Show alts in tooltip"] = "",
	-- ["Show main in tooltip"] = "",
	-- ["([^%s%p%d%c%z]+)'s alt"] = "",
	-- Start = "",
	-- ["%s total alts linked to mains"] = "",
	-- ["The colour of an alt's main name that will be displayed"] = "",
	-- ["Use class colour (from the PlayerNames module)"] = "",
	-- ["use class colour of alt"] = "",
	-- ["use class colour of main"] = "",
	-- ["Use LibAlts Data"] = "",
	-- ["Use the data available via the shared alt information library."] = "",
	-- ["Various ways to import a main's alts from other addons"] = "",
	-- ["warning: alt %s already linked to %s"] = "",
	-- ["Where to display a character's main name when on their alt."] = "",
	-- ["Whether to report to the chat frame or not."] = "",
	-- ["You are not in a guild"] = "",
	-- ["You have not yet linked any alts with their mains."] = "",
}

)
L:AddLocale("deDE", 
{
	[".*[Aa]lts?$"] = true,
	alt = "Alt",
	Alt = true,
	["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = "<Altname> (z.B. /altnames del FalscherAltname)",
	["alt name exists: %s -> %s; not overwriting as set in preferences"] = "Alt-Name vorhanden: %s -> %s; wir nicht überschrieben, wie in der Auswahl eingestellt.",
	AltNames = "AltName",
	["Alts:"] = true,
	autoguildalts_desc = "Automatisch den Import von der Gildenliste im Hintergrund ausführen.",
	autoguildalts_name = "Auto-Import der Gilden-Alts",
	["Be quiet"] = "Stumm schalten",
	["character removed: %s"] = "Charakter entfernt: %s",
	["Class colour"] = "Klassenfarbe",
	["Clear all"] = "Alle löschen",
	["Clear all links between alts and main names."] = "Alle Verknüpfungen zwischen Alt- und Haupt-Charakternamen löschen",
	Colour = "Farbe",
	["%d alts found for %s: %s"] = "%d Alts gefunden für %s: %s",
	["Delete a character's link to another character as their main."] = "Die Verknüpfung eines Charakters zu einem anderen (Haupt-)Charakter löschen.",
	["Delete alt"] = "Alts löschen",
	Disabled = "Inaktiv",
	["Display a player's alts in the tooltip"] = "Die Altnamen eines Spielers im Tooltip anzeigen.",
	["Display a player's main name in the tooltip"] = "Den Namen des Hauptcharakters eines Spielers im Tooltip anzeigen.",
	["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = "Namen der Hauptcharaktere in Klassenfarbe des Alts anzeigen (Daten werden vom Modul PlayerNames geliefert, falls aktiviert).",
	["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = "Namen der Hauptcharaktere in Klassenfarbe des Hauptcharakters anzeigen (Daten werden vom Modul PlayerNames geliefert, falls aktiviert).",
	["Don't overwrite existing alt <-> main links when importing or adding new alts."] = "Vorhandenen Alt nicht überschreiben <-> Verknüpfungen zu Hauptcharakteren während des Imports oder des Hinzufügens von neuen Alts.",
	["Don't overwrite existing links"] = "Bestehende Verknüpfungen nicht überschreiben",
	["don't use"] = "Nicht verwenden",
	["Don't use data from the PlayerNames module at all"] = "Daten vom Modul SpielerNamen nicht verwenden.",
	["ERROR: some function sent a blank message!"] = "ERROR: eine Funktion hat eine leere Nachricht hinterlassen.",
	["Find characters"] = "Charaktersuche",
	["Fix alts"] = "Alts reparieren",
	["Fix corrupted entries in your list of alt names."] = "Korrupte Einträge in deiner Liste der Alt-Namen reparieren.",
	["Found alt: %s => main: %s"] = "Alt gefunden: %s => Haupt: %s",
	["guild member alts found and imported: %s"] = "Alt-Chars eines Gildenmitglieds gefunden und importiert: %s",
	["Import from Guild Greet database"] = "Importiere von der Gilden-Begrüßungs-Datenbank",
	["Import from guild roster"] = "Importiere von Gildenliste",
	["Import options"] = "Import-Optionen",
	["Imports alt names from a Guild Greet database, if present"] = "Importiert Alt-Namen von einer Gilden-Begrüßungs-Datenbank, wenn vorhanden.",
	["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = "Importiert Alt-Namen von der Gildenliste, indem Mitglieder mit dem Rang \"alt\" oder \"alts\", oder Gilden- und Gildenoffiziersnotizen wie \"<name>s alt\" geprüft werden.",
	["Imports data from LOKWhoIsWho, if present (drop your SavedVariablesLOKWhoIsWho.lua in the Prat directory to be able to use this)."] = "Importiert Daten von LOKWhoIsWho, wenn vorhanden (um diese Funktion verwenden zu können, kopiere deine Datei SavedVariablesLOKWhoIsWho.lua in den Prat-Ordner!).",
	Left = "Links",
	["Link alt"] = "Alt verknüpfen",
	["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = "Verknüpfe <alt-name> <hauptcharname> (z.B. /altnames link Fin Finjaderaltvonfin)",
	["linked alt %s => %s"] = "Altchar verknüpft %s => %s",
	["Link someone's alt character with the name of their main."] = "Jemandes Alt-Charakter mit dem Namen seines Hauptcharakters verknüpfen.",
	["List all"] = "Alle auflisten",
	["List all links between alts and their main names."] = "Alle Verknüpfungen zwischen Alts und deren Hauptchar-Namen auflisten.",
	["List alts"] = "Alts auflisten",
	["List alts for a given character"] = "Alts eines bestimmten Charakters auflisten.",
	["LOKWhoIsWho data not found"] = "LOKWhoIsWho-Daten nicht gefunden",
	["LOKWhoIsWho import"] = "LOKWhoIsWho-Import",
	["LOKWhoIsWho lua file not found, sorry."] = "LOKWhoIsWho.lua-Datei nicht gefunden, entschuldige.",
	main = "Hauptchar",
	Main = "Hauptchar",
	["Main:"] = "Hauptchar:",
	["<main> (eg /altnames listalts Fin)"] = "<main> (z.b. /altnames listalts Shylera)",
	["Main name position"] = "Position des Namens eines Hauptcharakters",
	mainpos_desc = "Wo der Name eines Hauptchars dargestellt werden soll, wenn diese mit ihrem Alt-Char zocken.",
	mainpos_name = "Hauptchar-Name Position",
	module_desc = "Erlaubt das Verknüpfen von Alt-Chars mit deren Hauptchars, was dann neben deren Namen angezeigt werden kann, wenn sie in Chat-Mitteilungen erscheinen (standard = aus).",
	["no alts found for character "] = "Keine Alt-Chars für diesen Charakter gefunden.",
	["no alts or mains found matching \"%s\""] = "Keine Alt-Chars oder Hauptchars gefunden, die mit \"%s\" übereinstimmen.",
	["No arg string given to :addAlt()"] = "Kein Parameter angegeben für: :addAlt()",
	["no characters called \"%s\" found; nothing deleted"] = "Keine Charaktere mit dem Namen \"%s\" gefunden; es wurde nichts gelöscht.",
	["No Guild Greet database found"] = "Keine Gilden-Begrüßungs-Datenbank gefunden.",
	["No main name supplied to link %s to"] = "Kein Hauptcharname geliefert, mit dem %s verknüpft werden kann.",
	["no matches found"] = "Keine Übereinstimmungen gefunden.",
	quiet = "Sei ruhig",
	quiet_desc = "Ob Meldungen an den Chat-Rahmen gesendet werden oder nicht.",
	quiet_name = true,
	Right = "Rechts",
	["(.-)'s? [Aa]lt"] = " %f[%a\\192-\\255]([%a\\192-\\255]+)%f[^%a\\128-\\255]s [Aa]lt",
	["%s alts imported from LOKWhoIsWho"] = "%s Alts importiert von LOKWhoIsWho",
	["searched for: %s - total matches: %s"] = "Gesucht nach: %s - gesamte Übereinstimmungen: %s",
	["<search term> (eg, /altnames find fin)"] = "<Suchbegriff> (z.b. /altnames find Shy)",
	["Search the list of linked characters for matching main or alt names."] = "Durchsuche die Liste der verknüpften Charaktere nach passenden Hauptchar- oder Altchar-Namen.",
	["Show alts in tooltip"] = "Alts im Tooltip anzeigen",
	["Show main in tooltip"] = "Hauptchar im Tooltip anzeigen",
	["([^%s%p%d%c%z]+)'s alt"] = "%f[%a\\192-\\255]([%a\\192-\\255]+)%f[^%a\\128-\\255]s [Aa]lt",
	Start = "Starte",
	["%s total alts linked to mains"] = "Insgesamt %s Alts mit Haupt-Charakteren verknüpft",
	["The colour of an alt's main name that will be displayed"] = "Die Farbe des Hauptcharnamens eines Alts, der dargestellt wird.",
	["Use class colour (from the PlayerNames module)"] = "Klassenfarbe verwenden (vom Modul \"PlayerNames\") ",
	["use class colour of alt"] = "Klassenfarbe für Alt-Char verwenden.",
	["use class colour of main"] = "Klassenfarbe des Hauptchars verwenden",
	["Use LibAlts Data"] = "Daten von LibAlts benutzen",
	["Use the data available via the shared alt information library."] = "Verwende die vorhandenen Daten über die gemeinsam genutzte Alt-Informations-Sammlung.",
	["Various ways to import a main's alts from other addons"] = "Verschiedene Möglichkeiten, wie man die Alts eines Hauptchars von anderen AddOns importieren kann.",
	["warning: alt %s already linked to %s"] = "Warnung: Alt %s ist bereits mit %s verknüpft!",
	["Where to display a character's main name when on their alt."] = "Wo der Name eines Hauptcharakters angezeigt werden soll, wenn diese mit ihrem Alt-Char zocken.",
	["Whether to report to the chat frame or not."] = "Ob Meldungen im Chat-Rahmen erscheinen oder nicht.",
	["You are not in a guild"] = "Du bist in keiner Gilde",
	["You have not yet linked any alts with their mains."] = "Bisher hast du keine Alt-Chars mit ihren Hauptchars verknüpft.",
}

)
L:AddLocale("koKR",  
{
	-- [".*[Aa]lts?$"] = "",
	-- alt = "",
	-- Alt = "",
	-- ["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = "",
	-- ["alt name exists: %s -> %s; not overwriting as set in preferences"] = "",
	-- AltNames = "",
	-- ["Alts:"] = "",
	-- autoguildalts_desc = "",
	-- autoguildalts_name = "",
	-- ["Be quiet"] = "",
	-- ["character removed: %s"] = "",
	["Class colour"] = "직업 색상",
	-- ["Clear all"] = "",
	-- ["Clear all links between alts and main names."] = "",
	Colour = "색상",
	-- ["%d alts found for %s: %s"] = "",
	-- ["Delete a character's link to another character as their main."] = "",
	-- ["Delete alt"] = "",
	Disabled = "비활성",
	-- ["Display a player's alts in the tooltip"] = "",
	-- ["Display a player's main name in the tooltip"] = "",
	-- ["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = "",
	-- ["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = "",
	-- ["Don't overwrite existing alt <-> main links when importing or adding new alts."] = "",
	-- ["Don't overwrite existing links"] = "",
	-- ["don't use"] = "",
	-- ["Don't use data from the PlayerNames module at all"] = "",
	-- ["ERROR: some function sent a blank message!"] = "",
	-- ["Find characters"] = "",
	-- ["Fix alts"] = "",
	-- ["Fix corrupted entries in your list of alt names."] = "",
	-- ["Found alt: %s => main: %s"] = "",
	-- ["guild member alts found and imported: %s"] = "",
	-- ["Import from Guild Greet database"] = "",
	-- ["Import from guild roster"] = "",
	-- ["Import options"] = "",
	-- ["Imports alt names from a Guild Greet database, if present"] = "",
	-- ["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = "",
	-- ["Imports data from LOKWhoIsWho, if present (drop your SavedVariablesLOKWhoIsWho.lua in the Prat directory to be able to use this)."] = "",
	-- Left = "",
	-- ["Link alt"] = "",
	-- ["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = "",
	-- ["linked alt %s => %s"] = "",
	-- ["Link someone's alt character with the name of their main."] = "",
	-- ["List all"] = "",
	-- ["List all links between alts and their main names."] = "",
	-- ["List alts"] = "",
	-- ["List alts for a given character"] = "",
	-- ["LOKWhoIsWho data not found"] = "",
	-- ["LOKWhoIsWho import"] = "",
	-- ["LOKWhoIsWho lua file not found, sorry."] = "",
	-- main = "",
	-- Main = "",
	-- ["Main:"] = "",
	-- ["<main> (eg /altnames listalts Fin)"] = "",
	-- ["Main name position"] = "",
	-- mainpos_desc = "",
	-- mainpos_name = "",
	-- module_desc = "",
	-- ["no alts found for character "] = "",
	-- ["no alts or mains found matching \"%s\""] = "",
	-- ["No arg string given to :addAlt()"] = "",
	-- ["no characters called \"%s\" found; nothing deleted"] = "",
	-- ["No Guild Greet database found"] = "",
	-- ["No main name supplied to link %s to"] = "",
	-- ["no matches found"] = "",
	-- quiet = "",
	-- quiet_desc = "",
	-- quiet_name = "",
	-- Right = "",
	-- ["(.-)'s? [Aa]lt"] = "",
	-- ["%s alts imported from LOKWhoIsWho"] = "",
	-- ["searched for: %s - total matches: %s"] = "",
	-- ["<search term> (eg, /altnames find fin)"] = "",
	-- ["Search the list of linked characters for matching main or alt names."] = "",
	-- ["Show alts in tooltip"] = "",
	-- ["Show main in tooltip"] = "",
	-- ["([^%s%p%d%c%z]+)'s alt"] = "",
	-- Start = "",
	-- ["%s total alts linked to mains"] = "",
	-- ["The colour of an alt's main name that will be displayed"] = "",
	["Use class colour (from the PlayerNames module)"] = "직업 색상 사용 (플레이어 이름 모듈)",
	-- ["use class colour of alt"] = "",
	-- ["use class colour of main"] = "",
	-- ["Use LibAlts Data"] = "",
	-- ["Use the data available via the shared alt information library."] = "",
	-- ["Various ways to import a main's alts from other addons"] = "",
	-- ["warning: alt %s already linked to %s"] = "",
	-- ["Where to display a character's main name when on their alt."] = "",
	-- ["Whether to report to the chat frame or not."] = "",
	["You are not in a guild"] = "당신은 길드에 속해 있지 않습니다",
	-- ["You have not yet linked any alts with their mains."] = "",
}

)
L:AddLocale("esMX",  
{
	-- [".*[Aa]lts?$"] = "",
	-- alt = "",
	-- Alt = "",
	-- ["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = "",
	-- ["alt name exists: %s -> %s; not overwriting as set in preferences"] = "",
	-- AltNames = "",
	-- ["Alts:"] = "",
	-- autoguildalts_desc = "",
	-- autoguildalts_name = "",
	-- ["Be quiet"] = "",
	-- ["character removed: %s"] = "",
	-- ["Class colour"] = "",
	-- ["Clear all"] = "",
	-- ["Clear all links between alts and main names."] = "",
	-- Colour = "",
	-- ["%d alts found for %s: %s"] = "",
	-- ["Delete a character's link to another character as their main."] = "",
	-- ["Delete alt"] = "",
	-- Disabled = "",
	-- ["Display a player's alts in the tooltip"] = "",
	-- ["Display a player's main name in the tooltip"] = "",
	-- ["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = "",
	-- ["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = "",
	-- ["Don't overwrite existing alt <-> main links when importing or adding new alts."] = "",
	-- ["Don't overwrite existing links"] = "",
	-- ["don't use"] = "",
	-- ["Don't use data from the PlayerNames module at all"] = "",
	-- ["ERROR: some function sent a blank message!"] = "",
	-- ["Find characters"] = "",
	-- ["Fix alts"] = "",
	-- ["Fix corrupted entries in your list of alt names."] = "",
	-- ["Found alt: %s => main: %s"] = "",
	-- ["guild member alts found and imported: %s"] = "",
	-- ["Import from Guild Greet database"] = "",
	-- ["Import from guild roster"] = "",
	-- ["Import options"] = "",
	-- ["Imports alt names from a Guild Greet database, if present"] = "",
	-- ["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = "",
	-- ["Imports data from LOKWhoIsWho, if present (drop your SavedVariablesLOKWhoIsWho.lua in the Prat directory to be able to use this)."] = "",
	-- Left = "",
	-- ["Link alt"] = "",
	-- ["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = "",
	-- ["linked alt %s => %s"] = "",
	-- ["Link someone's alt character with the name of their main."] = "",
	-- ["List all"] = "",
	-- ["List all links between alts and their main names."] = "",
	-- ["List alts"] = "",
	-- ["List alts for a given character"] = "",
	-- ["LOKWhoIsWho data not found"] = "",
	-- ["LOKWhoIsWho import"] = "",
	-- ["LOKWhoIsWho lua file not found, sorry."] = "",
	-- main = "",
	-- Main = "",
	-- ["Main:"] = "",
	-- ["<main> (eg /altnames listalts Fin)"] = "",
	-- ["Main name position"] = "",
	-- mainpos_desc = "",
	-- mainpos_name = "",
	-- module_desc = "",
	-- ["no alts found for character "] = "",
	-- ["no alts or mains found matching \"%s\""] = "",
	-- ["No arg string given to :addAlt()"] = "",
	-- ["no characters called \"%s\" found; nothing deleted"] = "",
	-- ["No Guild Greet database found"] = "",
	-- ["No main name supplied to link %s to"] = "",
	-- ["no matches found"] = "",
	-- quiet = "",
	-- quiet_desc = "",
	-- quiet_name = "",
	-- Right = "",
	-- ["(.-)'s? [Aa]lt"] = "",
	-- ["%s alts imported from LOKWhoIsWho"] = "",
	-- ["searched for: %s - total matches: %s"] = "",
	-- ["<search term> (eg, /altnames find fin)"] = "",
	-- ["Search the list of linked characters for matching main or alt names."] = "",
	-- ["Show alts in tooltip"] = "",
	-- ["Show main in tooltip"] = "",
	-- ["([^%s%p%d%c%z]+)'s alt"] = "",
	-- Start = "",
	-- ["%s total alts linked to mains"] = "",
	-- ["The colour of an alt's main name that will be displayed"] = "",
	-- ["Use class colour (from the PlayerNames module)"] = "",
	-- ["use class colour of alt"] = "",
	-- ["use class colour of main"] = "",
	-- ["Use LibAlts Data"] = "",
	-- ["Use the data available via the shared alt information library."] = "",
	-- ["Various ways to import a main's alts from other addons"] = "",
	-- ["warning: alt %s already linked to %s"] = "",
	-- ["Where to display a character's main name when on their alt."] = "",
	-- ["Whether to report to the chat frame or not."] = "",
	-- ["You are not in a guild"] = "",
	-- ["You have not yet linked any alts with their mains."] = "",
}

)
L:AddLocale("ruRU",  
{
	[".*[Aa]lts?$"] = ".*[Аа]льты?$",
	alt = "альт",
	Alt = "Альт",
	["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = "<имя альта> (к примеру, /altnames del Загзаг)",
	["alt name exists: %s -> %s; not overwriting as set in preferences"] = "имя альта уже существует: %s -> %s; перезапись запрещена настройками",
	AltNames = "Имя альтов",
	["Alts:"] = "Альты:",
	-- autoguildalts_desc = "",
	autoguildalts_name = "Авто-импорт альтов гильдии",
	-- ["Be quiet"] = "",
	["character removed: %s"] = "персонаж удалён: %s",
	["Class colour"] = "Окраска по классу",
	["Clear all"] = "Очистить все",
	["Clear all links between alts and main names."] = "Очистить все ссылки между альтами и основными именами.",
	Colour = "Цвет",
	["%d alts found for %s: %s"] = "%d альтов найдено для %s: %s",
	["Delete a character's link to another character as their main."] = "Удалить ссылку персонажа на другого персонажа если он основной.",
	["Delete alt"] = "Удалить альта",
	Disabled = "Отключено",
	["Display a player's alts in the tooltip"] = "Отображать альтов игрока в подсказке",
	["Display a player's main name in the tooltip"] = "Отображать основных персонажей игрока в подсказке",
	["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = "Отображать имена основного персонажа по классу альта (данные берутся из модуля PlayerNames, если он включен)",
	["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = "Отображать имена основного персонажа по его основному классу (данные берутся из модуля PlayerNames, если он включен)",
	["Don't overwrite existing alt <-> main links when importing or adding new alts."] = "Не перезаписывать существующии связки альтов <-> основных при импортировании или добавлении нового.",
	["Don't overwrite existing links"] = "Не перезаписывать существующие связки",
	["don't use"] = "не окрашивать",
	["Don't use data from the PlayerNames module at all"] = "Не использовать для всех данные из модуля PlayerNames",
	-- ["ERROR: some function sent a blank message!"] = "",
	["Find characters"] = "Найти персонажи",
	["Fix alts"] = "Исправить альтов",
	["Fix corrupted entries in your list of alt names."] = "Исправить неправельные записи в вашем списке имен альтов.",
	["Found alt: %s => main: %s"] = "Альт найден: %s => основной: %s",
	["guild member alts found and imported: %s"] = "%s: найдено альтов участников гильдии и импортированно",
	["Import from Guild Greet database"] = "Импорт базы данных Guild Greet",
	["Import from guild roster"] = "Импорт из списка гильдии",
	["Import options"] = "Настройки импорта",
	["Imports alt names from a Guild Greet database, if present"] = "Импорт альтов из базы данных Guild Greet, если есть",
	["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = "Импорт имен альтов из списка гильдии определяя участника по званию \"alt\" или \"alts\", или общие / офицерские заметки типо \"<name> alt\"",
	["Imports data from LOKWhoIsWho, if present (drop your SavedVariablesLOKWhoIsWho.lua in the Prat directory to be able to use this)."] = "Импортировать данные из LOKWhoIsWho, если есть (перекиньте ваш SavedVariables/LOKWhoIsWho.lua в папку Pratа для использования).",
	Left = "Слева",
	["Link alt"] = "Связать альта",
	["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = "link <имя альта> <имя основного> (пример, /altnames link Загзаг Загзаговичюс)",
	["linked alt %s => %s"] = "альт %s связан с => %s",
	["Link someone's alt character with the name of their main."] = "Связать определённого альта с именем его основного персонажа.",
	["List all"] = "Весь список",
	["List all links between alts and their main names."] = "Весь список ссылок между альтами и основными именами.",
	["List alts"] = "Список альтов",
	["List alts for a given character"] = "Список альтов для заданных персонажей",
	["LOKWhoIsWho data not found"] = "Данные LOKWhoIsWho не найдены",
	["LOKWhoIsWho import"] = "Импорт из LOKWhoIsWho",
	["LOKWhoIsWho lua file not found, sorry."] = "Lua файл LOKWhoIsWho не найден, извените.",
	main = "основной",
	Main = "Основной",
	["Main:"] = "Основной:",
	["<main> (eg /altnames listalts Fin)"] = "<основной> (к примеру: /altnames listalts Загзаг)",
	["Main name position"] = "Позиция основного имени",
	mainpos_desc = "Где отображать имя главного персонажа если он на альте.",
	mainpos_name = "Позиция основного имени",
	-- module_desc = "",
	["no alts found for character "] = "не найдено альтов для персонажа",
	["no alts or mains found matching \"%s\""] = "совпавших альтов или основных \"%s\"",
	-- ["No arg string given to :addAlt()"] = "",
	["no characters called \"%s\" found; nothing deleted"] = "не найден персонаж по имени \"%s\"; нечего удалять",
	["No Guild Greet database found"] = "База данных Guild Greet не найдена",
	["No main name supplied to link %s to"] = "Не предоставлено основное имя для связки %s к",
	["no matches found"] = "совпадений не найдено",
	-- quiet = "",
	-- quiet_desc = "",
	-- quiet_name = "",
	Right = "Справа",
	["(.-)'s? [Aa]lt"] = "(.-)'s? [Аа]льт", -- Needs review
	["%s alts imported from LOKWhoIsWho"] = "Импортировано альтов из LOKWhoIsWho: %s",
	["searched for: %s - total matches: %s"] = "поиск для: %s - всего совподений: %s",
	["<search term> (eg, /altnames find fin)"] = "<элемент поиска> (к примеру, /altnames find Загзаг)",
	["Search the list of linked characters for matching main or alt names."] = "Поиск в списке связанных персонажей.",
	["Show alts in tooltip"] = "Альты в подсказке",
	["Show main in tooltip"] = "Основные в подсказке",
	["([^%s%p%d%c%z]+)'s alt"] = "([^%s%p%d%c%z]+) альт", -- Needs review
	Start = "Начать",
	["%s total alts linked to mains"] = "всего альтов связано с основным %s",
	-- ["The colour of an alt's main name that will be displayed"] = "",
	["Use class colour (from the PlayerNames module)"] = "Использовать окраску по цвету класса (из модуля PlayerNames)",
	["use class colour of alt"] = "цвета класса для альтов",
	["use class colour of main"] = "цвета класса для основных",
	["Use LibAlts Data"] = "Использовать LibAlts",
	-- ["Use the data available via the shared alt information library."] = "",
	["Various ways to import a main's alts from other addons"] = "Различные варианты импорта альтов основных персонажей из других аддонов",
	["warning: alt %s already linked to %s"] = "внимание: альт %s уже связан с %s",
	["Where to display a character's main name when on their alt."] = "Где отображать имя главного персонажа если он на альте.",
	["Whether to report to the chat frame or not."] = "Сообщать в чат или нет.",
	["You are not in a guild"] = "Вы не состоитев гильдии",
	["You have not yet linked any alts with their mains."] = "Вы еще не связали не одного альта с их основными.",
}

)
L:AddLocale("zhCN",  
{
	[".*[Aa]lts?$"] = true,
	alt = "马甲",
	Alt = "马甲",
	["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = "<马甲名称> (例, /altnames del 某个你以为是但不是的某人分身)",
	["alt name exists: %s -> %s; not overwriting as set in preferences"] = "马甲名称存在: %s -> %s;没有覆盖参数设置",
	AltNames = "马甲名称",
	["Alts:"] = "马甲:",
	-- autoguildalts_desc = "",
	-- autoguildalts_name = "",
	["Be quiet"] = "禁言",
	["character removed: %s"] = "删除角色: %s",
	["Class colour"] = "职业颜色",
	["Clear all"] = "全部清除",
	["Clear all links between alts and main names."] = "清除所有马甲与本尊名称间的联结",
	Colour = "颜色",
	["%d alts found for %s: %s"] = "%d 马甲找到 %s: %s",
	["Delete a character's link to another character as their main."] = "删除一个角色作为另一个角色本尊的联结",
	["Delete alt"] = "删除马甲",
	Disabled = "禁用",
	["Display a player's alts in the tooltip"] = "在提示里显示玩家的马甲名称",
	["Display a player's main name in the tooltip"] = "在提示里显示玩家的本尊名称",
	["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = "用和马甲职业相同的颜色显示本尊名称(如果玩家名称模块启用,从中采集数据)",
	["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = "用和本尊职业相同的颜色显示本尊名称(如果玩家名称模块启用,从中采集数据)",
	["Don't overwrite existing alt <-> main links when importing or adding new alts."] = "不要在导入或添加新马甲时覆盖已有的马甲 <-> 本尊",
	["Don't overwrite existing links"] = "不要覆盖已有联结",
	["don't use"] = "不使用",
	["Don't use data from the PlayerNames module at all"] = "不要从玩家名称模块使用数据",
	["ERROR: some function sent a blank message!"] = "错误:一些参数发送了一条空白信息!",
	["Find characters"] = "发现角色",
	["Fix alts"] = "修复马甲",
	["Fix corrupted entries in your list of alt names."] = "在你的马甲名称列表里修复损坏的条目",
	["Found alt: %s => main: %s"] = "发现马甲: %s => 本尊: %s",
	["guild member alts found and imported: %s"] = "公会成员马甲发现并导入: %s",
	["Import from Guild Greet database"] = "从公会欢迎数据库导入",
	["Import from guild roster"] = "从工会名单导入",
	["Import options"] = "导入选项",
	["Imports alt names from a Guild Greet database, if present"] = "导入马甲名称从公会欢迎数据库,如果可以",
	["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = "导入马甲名称从公会名单中检查到的成员头衔为“马甲”或“马甲们”的,或者公会官员备注为\"<某某>的马甲\"",
	["Imports data from LOKWhoIsWho, if present (drop your SavedVariablesLOKWhoIsWho.lua in the Prat directory to be able to use this)."] = "从LOKWhoIsWho导入数据,如果可以(你的Prat目录丢失SavedVariablesLOKWhoIsWho.lua可以使用这个).",
	Left = "左边",
	["Link alt"] = "联结马甲",
	["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = "联结 <马甲名称> <本尊名称>(例,/altnames link 顶尖战士 苍天哥)",
	["linked alt %s => %s"] = "联结的马甲 %s => %s",
	["Link someone's alt character with the name of their main."] = "联结某人的马甲角色与他们的本尊名称",
	["List all"] = "全部列出",
	["List all links between alts and their main names."] = "列出所有马甲与他们的本尊名称间的联结",
	["List alts"] = "列出马甲",
	["List alts for a given character"] = "列出特定角色的马甲",
	["LOKWhoIsWho data not found"] = "未发现LOKWhoIsWho数据",
	["LOKWhoIsWho import"] = "LOKWhoIsWho导入",
	["LOKWhoIsWho lua file not found, sorry."] = "未发现LOKWhoIsWho权限文件,息怒",
	main = "本尊",
	Main = "本尊",
	["Main:"] = "本尊:",
	["<main> (eg /altnames listalts Fin)"] = "<本尊> (例 /altnames listalts 顶尖战士)",
	["Main name position"] = "本尊名称位置",
	mainpos_desc = "当角色在马甲上时本尊名称的显示位置",
	mainpos_name = "本尊名称位置",
	module_desc = "把某人的马甲角色联结到他们的本尊,在聊天信息中的名字旁边显示(默认=关闭).",
	["no alts found for character "] = "未发现角色马甲",
	["no alts or mains found matching \"%s\""] = "未发现匹配\"%s\"马甲或本尊",
	["No arg string given to :addAlt()"] = "无字符串参数到:addAlt()",
	["no characters called \"%s\" found; nothing deleted"] = "未发现称作\"%s\"角色;无删除",
	["No Guild Greet database found"] = "未发现公会欢迎数据库",
	["No main name supplied to link %s to"] = "没有本尊名称以供联结%s",
	["no matches found"] = "无匹配发现",
	quiet = "安静",
	quiet_desc = "是否在聊天框报告",
	quiet_name = "无声_名字",
	Right = "右边",
	["(.-)'s? [Aa]lt"] = true, -- Needs review
	["%s alts imported from LOKWhoIsWho"] = "%s马甲从LOKWhoIsWho导入",
	["searched for: %s - total matches: %s"] = "搜索: %s - 完全匹配: %s",
	["<search term> (eg, /altnames find fin)"] = "<搜索条件>(例, /altnames find 顶尖战士)",
	["Search the list of linked characters for matching main or alt names."] = "搜索已联结的角色列表匹配本尊或马甲名称",
	["Show alts in tooltip"] = "在提示里显示马甲",
	["Show main in tooltip"] = "在提示里显示本尊",
	["([^%s%p%d%c%z]+)'s alt"] = true, -- Needs review
	Start = "起始",
	["%s total alts linked to mains"] = "%s全部马甲联结到本尊",
	["The colour of an alt's main name that will be displayed"] = "马甲的本尊名称将显示的颜色",
	["Use class colour (from the PlayerNames module)"] = "使用职业颜色(从玩家名称模块)",
	["use class colour of alt"] = "马甲职业的颜色",
	["use class colour of main"] = "本尊职业的颜色",
	["Use LibAlts Data"] = "使用LibAlts数据",
	["Use the data available via the shared alt information library."] = "使数据可通过共享的马甲信息库",
	["Various ways to import a main's alts from other addons"] = "用各种途径从其他插件导入本尊的马甲",
	["warning: alt %s already linked to %s"] = "注意:马甲%s已联结到%s",
	["Where to display a character's main name when on their alt."] = "当角色在马甲上时本尊名称显示何处",
	["Whether to report to the chat frame or not."] = "是否报告在聊天框",
	["You are not in a guild"] = "你不在一个公会里",
	["You have not yet linked any alts with their mains."] = "尚未有任何马甲联结到他们的本尊",
}

)
L:AddLocale("esES",  
{
	[".*[Aa]lts?$"] = true,
	alt = true,
	Alt = true,
	["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = "<nombre alt> (ej, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)",
	["alt name exists: %s -> %s; not overwriting as set in preferences"] = "existe el nombre alternativo: %s -> %s; sin sobrescribir como está establecido en las preferencias",
	AltNames = "AltNombres",
	["Alts:"] = true,
	-- autoguildalts_desc = "",
	-- autoguildalts_name = "",
	["Be quiet"] = "Silencio",
	["character removed: %s"] = "Personaje eliminado: %s",
	["Class colour"] = "Color Clase",
	["Clear all"] = "Limpiar todo",
	["Clear all links between alts and main names."] = "Borrar todos los enlaces entre nombres alternativos y principales.",
	Colour = "Color",
	["%d alts found for %s: %s"] = "%d alternativos encontrados para %s: %s",
	-- ["Delete a character's link to another character as their main."] = "",
	["Delete alt"] = "Eliminar alternativo",
	Disabled = "Desactivado",
	-- ["Display a player's alts in the tooltip"] = "",
	-- ["Display a player's main name in the tooltip"] = "",
	-- ["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = "",
	["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = "Mostrar nombres principales en el mismo color que el de su clase principal (tomando los datos del módulo PlayerNames si está habilitado)",
	["Don't overwrite existing alt <-> main links when importing or adding new alts."] = "No sobreescribir enlaces alternativo <-> principal existentes al importar o añadir nuevos alternativos.",
	["Don't overwrite existing links"] = "No sobreescribir enlaces existentes",
	["don't use"] = "No utilizar",
	["Don't use data from the PlayerNames module at all"] = "No utilizar datos del módulo PlayerNames en absoluto",
	["ERROR: some function sent a blank message!"] = "ERROR: alguna función envió un mensaje en blanco!",
	["Find characters"] = "Encontrar caracteres",
	["Fix alts"] = "Arreglar alternativos",
	["Fix corrupted entries in your list of alt names."] = "Arreglar entradas corruptas en su lista de nombres alternativos.",
	["Found alt: %s => main: %s"] = "Alternativo encontrado: %s => principal: %s",
	["guild member alts found and imported: %s"] = "Miembros de hermandad alternativos encontrados e importados: %s",
	-- ["Import from Guild Greet database"] = "",
	["Import from guild roster"] = "Importar desde la lista de la hermandad",
	["Import options"] = "Opciones de Importación",
	-- ["Imports alt names from a Guild Greet database, if present"] = "",
	-- ["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = "",
	["Imports data from LOKWhoIsWho, if present (drop your SavedVariablesLOKWhoIsWho.lua in the Prat directory to be able to use this)."] = "Importa datos de LOKWhoIsWho, si está presente (colocar su SavedVariablesLOKWhoIsWho.lua en el directorio Prat para poder usar este).",
	Left = "Izquierda",
	-- ["Link alt"] = "",
	["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = "enlace <nombre alt> <nombre principal> (ej, /nombrealt enlace Fin Finjathealtoffin)",
	["linked alt %s => %s"] = "alternativo enlazado %s => %s",
	-- ["Link someone's alt character with the name of their main."] = "",
	["List all"] = "Listar todo",
	["List all links between alts and their main names."] = "Lista todos los enlaces entre alternativos y sus nombres principales.",
	["List alts"] = "Lista alternativos",
	["List alts for a given character"] = "Lista alternativos para un personaje dado",
	["LOKWhoIsWho data not found"] = "LOKWhoIsWho datos no encontrados",
	["LOKWhoIsWho import"] = "importar LOKWhoIsWho",
	["LOKWhoIsWho lua file not found, sorry."] = "LOKWhoIsWho archivo lua no encontrado, lo siento.",
	main = "principal",
	Main = "Principal",
	["Main:"] = "Principal:",
	["<main> (eg /altnames listalts Fin)"] = "<principal> (ej /altnames listalts Fin)",
	["Main name position"] = "Posición del nombre principal",
	mainpos_desc = "Donde mostrar nombre principal de un personaje cuando es su alternativa.",
	mainpos_name = "Posición del nombre principal",
	-- module_desc = "",
	["no alts found for character "] = "sin alternativos encontrados para el personaje",
	["no alts or mains found matching \"%s\""] = "sin alternativos o principales coincidentes con \"%s\" encontrados",
	["No arg string given to :addAlt()"] = "Sin cadena de argumento dado a: addAlt()",
	["no characters called \"%s\" found; nothing deleted"] = "no se han encontrado personajes llamados \"%s\"; nada eliminado",
	-- ["No Guild Greet database found"] = "",
	["No main name supplied to link %s to"] = "Sin nombre principal proporcionado para el enlace %s",
	["no matches found"] = "Ninguna coincidencia encontrada",
	quiet = "Silencioso",
	quiet_desc = "Si desea informar al marco de chat o no.",
	-- quiet_name = "",
	Right = "Derecha",
	["(.-)'s? [Aa]lt"] = true, -- Needs review
	["%s alts imported from LOKWhoIsWho"] = "%s alternativos importados desde LOKWhoIsWho",
	["searched for: %s - total matches: %s"] = "buscado: %s - total de coincidencias: %s",
	["<search term> (eg, /altnames find fin)"] = "<término búsqueda> (ej, /altnames find fin)",
	-- ["Search the list of linked characters for matching main or alt names."] = "",
	["Show alts in tooltip"] = "Muestra alternativos en ayuda contextual",
	["Show main in tooltip"] = "Mostrar principal en ayuda contextual",
	["([^%s%p%d%c%z]+)'s alt"] = true, -- Needs review
	Start = "Inicio",
	["%s total alts linked to mains"] = "alternativos total %s vinculados a principales",
	-- ["The colour of an alt's main name that will be displayed"] = "",
	["Use class colour (from the PlayerNames module)"] = "Utilizar el color de clase (desde el módulo de NombresJugador)",
	["use class colour of alt"] = "utilizar color de clase de alt",
	["use class colour of main"] = "utilizar el color de la clase principal",
	["Use LibAlts Data"] = "Utiilizar Datos de LibAlts",
	["Use the data available via the shared alt information library."] = "Utilice los datos disponibles a través de la biblioteca compartida de información alternativa.",
	-- ["Various ways to import a main's alts from other addons"] = "",
	["warning: alt %s already linked to %s"] = "advertencia: alt %s ya vinculado a %s",
	-- ["Where to display a character's main name when on their alt."] = "",
	["Whether to report to the chat frame or not."] = "Si se debe reportar al marco de chat o no.",
	["You are not in a guild"] = "No está en una hermandad",
	["You have not yet linked any alts with their mains."] = "Aún no ha vinculado algún alternativo con su principal.",
}

)
L:AddLocale("zhTW",  
{
	-- [".*[Aa]lts?$"] = "",
	-- alt = "",
	-- Alt = "",
	-- ["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = "",
	-- ["alt name exists: %s -> %s; not overwriting as set in preferences"] = "",
	-- AltNames = "",
	-- ["Alts:"] = "",
	-- autoguildalts_desc = "",
	-- autoguildalts_name = "",
	["Be quiet"] = "安靜",
	["character removed: %s"] = "已移除角色：%s",
	["Class colour"] = "職業色彩",
	["Clear all"] = "清除所有",
	-- ["Clear all links between alts and main names."] = "",
	-- Colour = "",
	-- ["%d alts found for %s: %s"] = "",
	-- ["Delete a character's link to another character as their main."] = "",
	["Delete alt"] = "刪除別稱",
	Disabled = "停用",
	-- ["Display a player's alts in the tooltip"] = "",
	-- ["Display a player's main name in the tooltip"] = "",
	-- ["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = "",
	-- ["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = "",
	-- ["Don't overwrite existing alt <-> main links when importing or adding new alts."] = "",
	-- ["Don't overwrite existing links"] = "",
	-- ["don't use"] = "",
	-- ["Don't use data from the PlayerNames module at all"] = "",
	["ERROR: some function sent a blank message!"] = "錯誤：某些功能傳送空白訊息！",
	["Find characters"] = "搜尋角色",
	["Fix alts"] = "修正別稱",
	["Fix corrupted entries in your list of alt names."] = "修正列表中別稱損毀的項目",
	["Found alt: %s => main: %s"] = "搜尋別稱：%s => 主要名稱：%s",
	["guild member alts found and imported: %s"] = "公會成員別稱搜尋以及匯入：%s",
	-- ["Import from Guild Greet database"] = "",
	["Import from guild roster"] = "匯入公會名冊",
	["Import options"] = "匯入選項設定",
	-- ["Imports alt names from a Guild Greet database, if present"] = "",
	-- ["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = "",
	-- ["Imports data from LOKWhoIsWho, if present (drop your SavedVariablesLOKWhoIsWho.lua in the Prat directory to be able to use this)."] = "",
	Left = "左方",
	-- ["Link alt"] = "",
	-- ["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = "",
	-- ["linked alt %s => %s"] = "",
	-- ["Link someone's alt character with the name of their main."] = "",
	["List all"] = "列出所有",
	-- ["List all links between alts and their main names."] = "",
	["List alts"] = "列出別稱",
	-- ["List alts for a given character"] = "",
	-- ["LOKWhoIsWho data not found"] = "",
	-- ["LOKWhoIsWho import"] = "",
	-- ["LOKWhoIsWho lua file not found, sorry."] = "",
	main = "主要",
	Main = "主要",
	["Main:"] = "主要：",
	-- ["<main> (eg /altnames listalts Fin)"] = "",
	["Main name position"] = "主要名稱位置",
	-- mainpos_desc = "",
	mainpos_name = "主要名稱位置",
	-- module_desc = "",
	["no alts found for character "] = "未發現此角色分身",
	-- ["no alts or mains found matching \"%s\""] = "",
	-- ["No arg string given to :addAlt()"] = "",
	-- ["no characters called \"%s\" found; nothing deleted"] = "",
	-- ["No Guild Greet database found"] = "",
	-- ["No main name supplied to link %s to"] = "",
	-- ["no matches found"] = "",
	quiet = "安靜",
	quiet_desc = "是否回報至聊天視窗。",
	-- quiet_name = "",
	-- Right = "",
	-- ["(.-)'s? [Aa]lt"] = "",
	-- ["%s alts imported from LOKWhoIsWho"] = "",
	-- ["searched for: %s - total matches: %s"] = "",
	-- ["<search term> (eg, /altnames find fin)"] = "",
	-- ["Search the list of linked characters for matching main or alt names."] = "",
	-- ["Show alts in tooltip"] = "",
	-- ["Show main in tooltip"] = "",
	-- ["([^%s%p%d%c%z]+)'s alt"] = "",
	-- Start = "",
	-- ["%s total alts linked to mains"] = "",
	-- ["The colour of an alt's main name that will be displayed"] = "",
	["Use class colour (from the PlayerNames module)"] = "使用職業色彩（來自玩家名稱模組）",
	["use class colour of alt"] = "使用職業色彩於玩家次要人物",
	["use class colour of main"] = "使用職業色彩於玩家主要人物",
	["Use LibAlts Data"] = "使用 LibAlts 資料",
	-- ["Use the data available via the shared alt information library."] = "",
	["Various ways to import a main's alts from other addons"] = "由其他插件以各種方法匯入非主要人物。",
	["warning: alt %s already linked to %s"] = "錯誤：替代名稱 %s 已經連結至 %s",
	["Where to display a character's main name when on their alt."] = "用以顯示人物主要名稱於其其他角色名稱。",
	["Whether to report to the chat frame or not."] = "是否回報至聊天框架裡。",
	["You are not in a guild"] = "你並沒有加入任何公會",
	-- ["You have not yet linked any alts with their mains."] = "",
}

)
--@end-non-debug@

local module = Prat:NewModule(PRAT_MODULE, "AceHook-3.0", "AceEvent-3.0")

local altregistry = LibStub("LibAlts-1.0")

module.Alts = {}

Prat:SetModuleDefaults(module.name, {
	profile = {
		on	= false,
		quiet	= false,
		pncol	= 'no',
		altidx	= {},
		mainpos	= 'RIGHT',
		colour	= {},
	
		maincolour	= '97ff4c',	-- fairly light bright green
		altcolour	= 'ff6df2',	-- fairly bright light purpley pinkish
		noclobber	= false,
	
		tooltip_showmain	= false,
		tooltip_showalts	= false,

		usealtlib = true,
		autoguildalts = false,
	},
	realm = {
		alts	= {},
	}
} )


Prat:SetModuleInit(module, 
	function(self) 
		if self.db.profile.alts then
		   local alts = self.db.profile.alts
		   self.db.profile.alts = nil
		   for k,v in pairs(alts) do 
		     self.db.realm.alts[k] = self.db.realm.alts[k] or v
		   end
		end
		
		-- Load shared Alts data
		for alt,main in pairs(self.db.realm.alts) do
			altregistry:SetAlt(main,alt)
		end

		-- define a popup to get the main name
		StaticPopupDialogs['MENUITEM_LINKALT'] = {
			-- text		= "Who would you like to set as the main character of %s?",
			text	= 'Mainname',
			button1		= TEXT(ACCEPT),
			button2		= TEXT(CANCEL),
			hasEditBox	= 1,
			maxLetters	= 24,
			exclusive	= 0,
	
			OnAccept = function(this, altname)
				local mainname	= this.editBox:GetText()
	
				altname	= altname or 'xxx'
	
				module:addAlt(string.format('%s %s', altname, mainname))
			end,
	
			OnShow = function(this)
				this.editBox:SetFocus();
			end,
	
			OnHide = function(this)
				if ( this.editBox:IsShown() ) then
					this.editBox:SetFocus();
				end
				getglobal(this:GetName().."EditBox"):SetText("");
			end,
	
			EditBoxOnEnterPressed = function(this, altname)
        		local parent = this:GetParent()
        		local editBox = parent.editBox
				local mainname	= editBox:GetText()
	
				altname	= altname or 'xxx'
	
				module:addAlt(string.format('%s %s', altname, mainname))
	
				parent:Hide()
			end,
	
			EditBoxOnEscapePressed = function(this)
				this:GetParent():Hide();
			end,
			timeout		= 0,
			whileDead	= 1,
			hideOnEscape	= 1
			}
	return end)


Prat:SetModuleOptions(module, {
		name	= L["AltNames"],
		desc	= L["module_desc"],
		type	= "group",
		args = {
			find = {
				name	= L["Find characters"],
				desc	= L["Search the list of linked characters for matching main or alt names."],
				type	= "input",
				usage	= L["<search term> (eg, /altnames find fin)"],
				order	= 110,
				set	= function(info, q) info.handler:findChars(q) end,
				get	= false,
				},

			listalts = {
				name	= L['List alts'],
				desc	= L['List alts for a given character'],
				type	= 'input',
				usage	= L['<main> (eg /altnames listalts Fin)'],
				order	= 115,
				set	= function(info, m) info.handler:listAlts(m) end,
				get	= false,
				},

			link = {
				name	= L["Link alt"],
				desc	= L["Link someone's alt character with the name of their main."],
				type	= "input",
				order	= 120,
				usage	= L["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"],
				-- pass	= true,
				-- set	= function(argname, argstr) self:addAlt(argstr) end,
				set	= function(info, argstr) info.handler:addAlt(argstr) end,
				get	= false,
--				alias	= { 'new', 'add' },
				},

			del = {
				name	= L["Delete alt"],
				desc	= L["Delete a character's link to another character as their main."],
				type	= "input",
				usage	= L["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"],
				order	= 130,
				set	= function(info, altname) info.handler:delAlt(altname) end,
				get	= false,
				confirm	= true,
--				alias	= { 'remove', 'unlink' },
				},

			quiet = {
				name	= L["Be quiet"],
				desc	= L["Whether to report to the chat frame or not."],
				type	= "toggle",
				order	= 191, -- 19x = options

				},

			listall = {
				name	= L["List all"],
				desc	= L["List all links between alts and their main names."],
				type	= "execute",
				func	= "listAll",
--				alias	= { 'list', 'all' },
				},

			clearall = {
				name	= L["Clear all"],
				desc	= L["Clear all links between alts and main names."],
				type	= "execute",
				func	= "clearAllAlts",
				confirm	= true,
				},

			fixalts = {
				name	= L["Fix alts"],
				desc	= L["Fix corrupted entries in your list of alt names."],
				type	= "execute",
				func	= "fixAlts",
				},

			colour = {
				name	= L["Colour"],
				get	= function(info) return info.handler:getColour() end,
				set	= function(info, nr, ng, nb, na) info.handler.db.profile.colour = { r = nr, g = ng, b = nb, a = na } end,
				desc	= L["The colour of an alt's main name that will be displayed"],
				type	= "color",
				order   = 60,
				disabled = function(info) return info.handler.db.profile.pncol ~= 'no' end
				},

			pncol = {
					name	= L["Class colour"],
					desc	= L["Use class colour (from the PlayerNames module)"],
					type	= "select",
					get     =  function(info) return info.handler.db.profile.pncol end,
					set	= function(info, v) info.handler.db.profile.pncol = v end,
					order	= 55,
					values = {
						['main']	= L["use class colour of main"],
						['alt']		= L["use class colour of alt"],
						['no']		= L["don't use"],
					},
				},

			mainpos = {
				name	= L["Main name position"],
				desc	= L["Where to display a character's main name when on their alt."],
				type	= "select",
				order	= 50,
				get	= function(info) return info.handler.db.profile.mainpos end,
				set	= function(info, v) info.handler:setMainPos(v) end,
				values = {
					["LEFT"]	= L["Left"],
					["RIGHT"]	= L["Right"],
	 				["START"]	= L["Start"],
					},
				},

			tooltip_showmain = {
				name	= L['Show main in tooltip'],
				desc	= L["Display a player's main name in the tooltip"],
				type	= 'toggle',
				order	= 150,
				get	= function(info) return info.handler.db.profile.tooltip_showmain end,
				set	= function(info)
						info.handler.db.profile.tooltip_showmain = not info.handler.db.profile.tooltip_showmain
						info.handler.altertooltip = info.handler.db.profile.tooltip_showalts or info.handler.db.profile.tooltip_showmain

						info.handler:HookTooltip()
					end,

				},

			tooltip_showalts = {
				name	= L['Show alts in tooltip'],
				desc	= L["Display a player's alts in the tooltip"],
				type	= 'toggle',
				order	= 150,
				get	= function(info) return info.handler.db.profile.tooltip_showalts end,
				set	= function(info)
						info.handler.db.profile.tooltip_showalts = not info.handler.db.profile.tooltip_showalts
						info.handler.altertooltip = info.handler.db.profile.tooltip_showalts or info.handler.db.profile.tooltip_showmain
						
						info.handler:HookTooltip()
					end,
				},


			noclobber = {
				name	= L["Don't overwrite existing links"],
				desc	= L["Don't overwrite existing alt <-> main links when importing or adding new alts."],
				type	= "toggle",
				order	= 192,	-- 19x = options

				},

--			blankheader = {
--				order	= 499,
--				type	= 'header',
--				},

			--[[ IMPORT OPTIONS ]]--
			importheader = {
				name	= L["Import options"],
				desc	= L["Various ways to import a main's alts from other addons"],
				type	= 'header',
				order	= 500,
				},

			-- imports: LOKWhoIsWho - SavedVariables
			importfromlok = {
				name	= L["LOKWhoIsWho import"],
				desc	= L["Imports data from LOKWhoIsWho, if present (drop your SavedVariables\LOKWhoIsWho.lua in the Prat directory to be able to use this)."],
				type	= "execute",
				func	= "importFromLOK",
				confirm	= true,
				order	= 560,
				},

			-- imports: guild roster - officer notes, public notes, ranks
			guildimport = {
				name	= L["Import from guild roster"],
				desc	= L['Imports alt names from the guild roster by checking for members with the rank "alt" or "alts", or guild / officer notes like "<name>\'s alt"'],
				type	= "execute",
				func	= "importGuildAlts",
				confirm	= true,
				order	= 520,
				},

			-- imports: guild greet - SavedVariables
			ggimport = {
				name	= L['Import from Guild Greet database'],
				desc	= L['Imports alt names from a Guild Greet database, if present'],
				type	= 'execute',
				func	= "importGGAlts",
				confirm	= true,
				order	= 550,
				},

			usealtlib = {
				name	= L["Use LibAlts Data"],
				desc	= L["Use the data available via the shared alt information library."],
				type	= "toggle",
				order	= 540,	
				},
				
			autoguildalts = {
				name	= L["autoguildalts_name"],
				desc	= L["autoguildalts_desc"],
				type	= "toggle",
				order	= 540,	
				},				

			}
		}
)

--	if Prat:IsModuleActive("PlayerNames") then
--		self.moduleOptions['args']['pncol'] = {
--			name	= L["Class colour"],
--			desc	= L["Use class colour (from the PlayerNames module)"],
--			type	= "text",
--			get     =  function() return self.db.profile.pncol end,
--			set	= function(v) self.db.profile.pncol = v end,
--			order	= 150,
--			validate = {
--				['main']	= L["use class colour of main"],
--				['alt']		= L["use class colour of alt"],
--				['no']		= L["don't use"],
--				},
--			validateDesc = {
--				['main']	= L["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"],
--				['alt']		= L["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"],
--				['no']		= L["Don't use data from the PlayerNames module at all"],
--				},
--			}
--	end
--)


--[[------------------------------------------------
    Module Event Functions
------------------------------------------------]]--

function module:OnModuleEnable()
	-- much code ripped off from the PlayerMenu code - thanks, and sorry!

	-- things to do when the module is enabled
	for altname, mainname in pairs(self.db.realm.alts) do
		self.Alts[altname] = mainname
	end

	-- PlayerNames colour
	local pncol = self.db.profile.pncol

	if pncol == 'no' then
		pncol			= false
		self.db.profile.pncol	= false
	end

	self.db.profile.pncol = self.db.profile.pncol or false

	-- for caching a main's list of alts
	self.Altlists = {}

	-- just register one area which can be used for anything
	-- (and only actually has one use at the moment)
	self.ALTNAMES = ""

	-- set position that main names are displayed in chat messages
	self:setMainPos(self.db.profile.mainpos)

	-- register events
	Prat.RegisterChatEvent(self, "Prat_PreAddMessage")

	-- hook functions
	self.altertooltip = self.db.profile.tooltip_showmain or self.db.profile.tooltip_showalts

	self:HookTooltip()

	-- hack 'n' slash
	local slashcmds = {
		'/altnames',
		'/alts',
		'/alt',
		}

	--Prat:RegisterChatCommand(slashcmds, self.moduleOptions, string.upper("AltNames"))

	--self:SecureHook("UnitPopup_OnClick")
	--self:SecureHook("UnitPopup_ShowMenu")

    Prat:RegisterDropdownButton("LINK_ALT")

	-- add the bits to the context menus
	UnitPopupButtons['LINK_ALT'] = { text = "Set Main", dist = 0, func = function() module:UnitPopup_LinkAltOnClick() end , arg1 = "", arg2 = ""}

    if not self.menusAdded then
    	tinsert(UnitPopupMenus['PARTY'], #UnitPopupMenus['PARTY']-1, 'LINK_ALT')
    	tinsert(UnitPopupMenus['FRIEND'], #UnitPopupMenus['FRIEND']-1, 'LINK_ALT')
    	tinsert(UnitPopupMenus['SELF'], #UnitPopupMenus['SELF']-1, 'LINK_ALT')
    	tinsert(UnitPopupMenus['PLAYER'], #UnitPopupMenus['PLAYER']-1, 'LINK_ALT')
    	-- tinsert(UnitPopupMenus['TARGET'], getn(UnitPopupMenus['TARGET'])-1, 'LINK_ALT')
        
        self.menusAdded = true
    end
    	
	if self.db.profile.autoguildalts then
    	self:AutoImportGuildAlts(true)
    end
end

function module:AutoImportGuildAlts(b)
	if b then
	    self:RegisterEvent("GUILD_ROSTER_UPDATE", function() module:importGuildAlts(nil, true) end)
	    GuildRoster() 
	else
	    self:UnregisterEvent("GUILD_ROSTER_UPDATE")
	end
end

function module:OnValueChanged(info, b)
	local field = info[#info]
	if field == "autoguildalts" then
		AutoImportGuildAlts(b)
	end
end

local function NOP() return end

function module:HookTooltip()
	if self.altertooltip then
		self:SecureHookScript(GameTooltip, 'OnTooltipSetUnit')
		self:SecureHookScript(GameTooltip, 'OnTooltipCleared')
	
		module.HookTooltip = NOP
	end
end

--function module:UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData, ...)
--	for i=1, UIDROPDOWNMENU_MAXBUTTONS do
--		button = getglobal("DropDownList"..UIDROPDOWNMENU_MENU_LEVEL.."Button"..i);
--
--		-- Patch our handler function back in
--		if  button.value == "LINK_ALT" then
--		    button.func = UnitPopupButtons["LINK_ALT"].func
--		end
--	end
--end

function module:UnitPopup_LinkAltOnClick()
	local dropdownFrame = UIDROPDOWNMENU_INIT_MENU

	--if (button == 'LINK_ALT') then
		local altname	= dropdownFrame.name
		local dialog	= StaticPopup_Show('MENUITEM_LINKALT', altname)

		if dialog then
			local altname	= dropdownFrame.name
			dialog.data	= altname
		end
	--end
end



-- things to do when the module is disabled
function module:OnModuleDisable()
	-- unregister events
	Prat.UnregisterAllChatEvents(self)
end


--[[------------------------------------------------
    Core Functions
------------------------------------------------]]--


function module:print(msg, printanyway)
	-- make sure we've got a message
	if msg == nil then
		printanyway = true
		msg = L['ERROR: some function sent a blank message!']
	end

	local verbose = (not self.db.profile.quiet) 

	if (not self.silent) and (verbose or printanyway) then
		msg = string.format('|cffffd100' .. L['AltNames'] .. ':|r %s', msg)
		DEFAULT_CHAT_FRAME:AddMessage(msg)
	end
end

--[[ colo*u*ring and formatting ]]--

local clrname = function(name, colour)
	return '|cff' .. (colour or 'ffffff') .. (name or "") .. '|r'
end

local clrmain = function(mainname, maincolour)
	mainname	= mainname or ""
	maincolour	= maincolour or module.db.profile.maincolour or '8080ff'

	-- 1, 0.9, 0, 0.5, 0.5, 1

	return clrname(mainname, maincolour)
end

local clralt = function(altname, altcolour)
	altname		= altname or ""
	altcolour	= altcolour or module.db.profile.altcolour or 'ff8080'

	-- 1, 0.7, 0, 1, 0.5, 0.5

	return clrname(altname, altcolour)
end

local clralts = function(alts, altcolour)
	if not alts or (type(alts) ~= 'table') or (#alts == 0) then return false end

	for mainname, altname in pairs(alts) do
		alts[mainname] = clralt(module:formatCharName(altname))
	end

	return alts
end

function module:formatCharName(name)
	-- format character names as having uppercase first letter followed by all lowercase

	if name == nil then
		return ""
	end

	name	= name:gsub('[%%%[%]":|%s]', '')
	name	= name:gsub("'", '')

	name	= string.lower(name)
	name	= string.gsub(name, Prat.MULTIBYTE_FIRST_CHAR, string.upper, 1)

	return name
end

--[[ alt <-> main link management ]]--

function module:addAlt(argstr)
	local mainname

	local altname	= ""
	local args	= {}

	-- check we've been passed somethin
	if (argstr == nil) or (argstr == "") then
		self:print(L['No arg string given to :addAlt()'])
		return false
	end

	-- extract the alt's name and the main name to link to
	for k, v in argstr:gmatch('(%S+)%s+(%S+)') do
		altname, mainname = k, v
	end

	-- check we've got a main name to link to
	if altname and not mainname then
		altname = argstr
		self:print(string.format(L["No main name supplied to link %s to"], clralt(altname)), true)
		return false
	end

	-- clean up character names
	mainname	= self:formatCharName(mainname)
	altname		= self:formatCharName(altname)

	-- check if alt has already been linked to a main
	local oldmain	= ""
	local noclobber	= self.db.profile.noclobber

	if self.Alts[altname] then
		oldmain = self.Alts[altname]

		if oldmain == mainname then
			self:print(string.format(L['warning: alt %s already linked to %s'], clralt(altname), clrmain(mainname)))
			return false
		end

		if noclobber then
			self:print(string.format(L['alt name exists: %s -> %s; not overwriting as set in preferences'], clralt(altname), clrmain(oldmain)))
			return false
		end

		self:print(string.format(L['warning: alt %s already linked to %s'], clralt(altname), clrmain(oldmain)))
	end

	-- add alt to list of alts -> mains
	self.Alts[altname]		= mainname
	self.db.realm.alts[altname]	= mainname

	-- make sure this character's list of alts is rebuilt next time it's needed
	if self.Altlists[mainname] then self.Altlists[mainname] = nil end

    -- publish this info globablly
	altregistry:SetAlt(mainname, altname)

	self:print(string.format(L["linked alt %s => %s"], clralt(altname), clrmain(mainname)))
end

function module:delAlt(altname)
	local suppliedaltname = altname

	altname = self:formatCharName(altname)

	if self.Alts[altname] then
		self.Alts[altname]		= nil
		self.db.realm.alts[altname]	= nil

		self:print(string.format(L["character removed: %s"], clralt(suppliedaltname)))

		-- make sure this character's list of alts is rebuilt next time it's needed
		if self.Altlists[mainname] then self.Altlists[mainname] = nil end

		return true
	end

	self:print(string.format(L['no characters called "%s" found; nothing deleted'], clralt(suppliedaltname)))
end

function module:listAll()
	if not self.db.realm.alts and self.Alts then
		self:print(L["You have not yet linked any alts with their mains."], true)
		return false
	end

	local altcount = 0

	for altname, mainname in pairs(self.Alts) do
		altcount = altcount + 1
		self:print(string.format("alt: %s => main: %s", clralt(altname), clrmain(mainname)))
	end

	self:print(string.format(L['%s total alts linked to mains'], altcount))
end

function module:findChars(q)
	local numfound

	local matchhighlight

	if not self.Alts then
		self:print(L["You have not yet linked any alts with their mains."], true)
		return false
	else
		local matches = {}
		local numfound = 0

		for altname, mainname in pairs(self.Alts) do
			local a = string.lower(altname)
			local m = string.lower(mainname)
			local pat = string.lower(q)

			-- self:print(string.format("matching against: altname:'%s', mainname:'%s', pat:'%s'", a, m, pat))

			if (a == pat) or (m == pat) or (a:find(pat)) or (m:find(pat)) then
				matches[altname] = mainname
				numfound = numfound + 1
			end
		end

		if numfound == 0 then
			self:print(string.format(L['no alts or mains found matching "%s"'], '|cffffb200' .. q .. '|r'), true)
		else
			for altname, mainname in pairs(matches) do
				self:print(string.format(L["Found alt: %s => main: %s"], clralt(altname), clrmain(mainname)))
			end

			self:print(string.format(L["searched for: %s - total matches: %s"], q, numfound))
		end

		return numfound
	end
end


function module:fixAlts()
	local fixedalts = {}

	for altname, mainname in pairs(self.db.realm.alts) do
		altname		= self:formatCharName(altname)
		mainname	= self:formatCharName(mainname)

		fixedalts[altname] = mainname
	end

	self.Alts = fixedalts
	self.db.realm.alts = fixedalts
end


function module:clearAllAlts()
	self.Alts		= {}
	self.db.realm.alts	= {}
	self.Altlists		= {}
end


local CLR = Prat.CLR

function module:setMainPos(pos)
	-- which item to go after, depending on our position
	local msgitems = {
		RIGHT	= 'Pp',
		LEFT	= 'Ff',
		START	= nil,
		}

	pos	= pos or 'RIGHT'

	Prat.RegisterMessageItem('ALTNAMES', msgitems[pos])

	if pos == 'RIGHT' then
		self.padfmt	= ' '..CLR:Colorize("ffffff", "(").."%s"..CLR:Colorize("ffffff", ")")
	else
		self.padfmt	= CLR:Colorize("ffffff", "(").."%s"..CLR:Colorize("ffffff", ")")..' '
	end

	self.db.profile.mainpos	= pos
end

local function isAlt(name)
    local alt = module.Alts[name]
    if alt then return alt end
    
    if altregistry and altregistry:IsAlt(name) then
        return altregistry:GetMain(name)
    end  
    
    return
end

local playernames
function module:Prat_PreAddMessage(e, message, frame, event)
	local hexcolour = CLR.NONE
	local mainname = message.PLAYERLINK

	if self.db.profile.on and isAlt(mainname) then
		local altname	= isAlt(mainname)
		local padfmt	= self.padfmt or ' (%s)'


		if self.db.profile.colour then
			if self.db.profile.pncol ~= 'no' then
				local charname
				local coltype = self.db.profile.pncol

				if coltype == "alt" then
					charname = mainname
				elseif coltype == "main" then
					charname = altname
				else
					charname = nil
					self.db.profile.pncol = 'no'
				end

				playernames = playernames or Prat.Addon:GetModule("PlayerNames")
				if charname then
					local class, level, subgroup = playernames:GetData(charname)
					if class then
						hexcolour = playernames:GetClassColor(class)
					end
				end
			else
				hexcolour = CLR:GetHexColor(self.db.profile.colour)
			end

			hexcolour = hexcolour or CLR:GetHexColor(self.db.profile.colour)
		end

		self.ALTNAMES	= string.format(padfmt, CLR:Colorize(hexcolour, altname:gsub(Prat.MULTIBYTE_FIRST_CHAR, string.upper, 1)))

		message.ALTNAMES = self.ALTNAMES
	end
end

function module:getColour(r, g, b, a)
	local col = self.db.profile.colour
	if not col then return false end
	return col.r, col.g, col.b, nil
end

function module:importFromLOK()
	if not LOKWhoIsWho_Config then
		self:print(L['LOKWhoIsWho lua file not found, sorry.'])
		return false
	end

	local server	= GetRealmName()
	local lokalts	= LOKWhoIsWho_Config[server]['players']

	if lokalts == nil then
		self:print(L["LOKWhoIsWho data not found"])
		return false
	end

	local numimported = 0

	for altname, mainname in pairs(lokalts) do
		self:addAlt(string.format("%s %s", altname, mainname))
		numimported = numimported + 1
	end

	self:print(string.format(L["%s alts imported from LOKWhoIsWho"], numimported))
end

function module:importGGAlts()
	--[[
		imports guilds from a Guild Greet database, if present
	]]
	if not GLDG_Data then
		self:print(L['No Guild Greet database found'])
		return
	end

	local servername = GetRealmName()
	local k, v

	for k, v in pairs(GLDG_Data) do
		if string.match(k, servername .. ' - %S+') then
			local name, player

			for name, player in pairs(v) do
				-- not sure whether this would be useful:
				-- if player['alt'] and player['alt'] ~= "" and not player['own'] then
				if player['alt'] and player['alt'] ~= "" then
					mainname	= player['alt']
					altname		= name

					self:addAlt(string.format('%s %s', altname, mainname))
				end
			end
		end
	end
end

function module:importGuildAlts(altrank, silently)
	if altrank == "" then altrank = nil end

	local totalmembers
	self.silent = silently

	totalmembers = GetNumGuildMembers(true)

	if totalmembers == 0 then
		self:print(L['You are not in a guild'])
		return
	end


	-- build a list of guild members to check guild notes against later
	local guildMembers = {}

	for x = 1, totalmembers do
		local name, rank, rankIndex, level, class, zone, publicnote, officernote, online, status = GetGuildRosterInfo(x)
		guildMembers[string.lower(name)] = name
	end


	-- loop through members and check stuff for later
	local mainname
	local altname
	local numfound = 0

	for x = 1, totalmembers do
		altname		= nil
		mainname	= nil

		local name, rank, rankIndex, level, class, zone, publicnote, officernote, online, status = GetGuildRosterInfo(x)

		-- yeah I know the vars should be pre-lc'ed and it's not as efficient as it could be below
		-- ... feel free to clean it up

		-- untested (is there a more convenient trim function available?):
		--[[
		officernote = gsub("^%s*", "", officernote)
		publicnote = gsub("^%s*", "", publicnote)
		]]

        officernote = (officernote):match(L["(.-)'s? [Aa]lt"]) or officernote
        publicnote = (publicnote):match(L["(.-)'s? [Aa]lt"]) or publicnote

		local cleanpubnote = publicnote:match(Prat.AnyNamePattern) 
		local cleanoffnote = officernote:match(Prat.AnyNamePattern) 

		-- check for guild members with rank "alt" or "alts" or "officer alt"
		if (rank:match(L[".*[Aa]lts?$"]) or (altrank and rank == altrank) ) and (cleanpubnote and guildMembers[cleanpubnote:lower()] ) then
			-- self:print(string.format('found mainname name for member %s', name))
			mainname = cleanpubnote
		-- check whether guild note is an exact match of a member's name
		elseif cleanpubnote and guildMembers[cleanpubnote:lower()] then
			mainname = cleanpubnote
		elseif cleanoffnote and guildMembers[cleanoffnote:lower()] then
			mainname = cleanoffnote
		elseif officernote:find(L["([^%s%p%d%c%z]+)'s alt"]) or publicnote:find(L["([^%s%p%d%c%z]+)'s alt"]) then
			local TempName = officernote:match(L["([^%s%p%d%c%z]+)'s alt"]) or publicnote:match(L["([^%s%p%d%c%z]+)'s alt"])
			if TempName and guildMembers[string.lower(TempName)] then
				mainname = TempName
			end
		end

		-- set alt name if we've found their main name
		if mainname and mainname ~= "" then

			if mainname:lower() ~= name:lower() then 
				numfound	= numfound + 1
				altname		= name
				self:addAlt(string.format('%s %s', altname, mainname))
			end
		end
	end

	self:print(string.format(L["guild member alts found and imported: %s"], numfound))
	self.silent = nil
end


-- function for showing a list of alt names in the tooltip
function module:getAlts(mainname)
	if self.db.profile.usealtlib then
		local alts = { altregistry:GetAlts(mainname) }
		if #alts > 0 then
			return alts
		end		

		return false
	end

	-- self.Alts = self.db.profile.altnames

	-- check valid mainname is being passed and that we actually have a list of alts
	if not (mainname and self.Alts) then return false end

	-- format the character name
	mainname = self:formatCharName(mainname)

	-- check mainname wasn't just made of invalid characters
	if mainname == "" then return false end

	-- check we've not already built the list of alts for this character
	if self.Altlists[mainname] then return self.Altlists[mainname] end

	local alts	= {}
	local allalts	= self.Alts

	-- loop through list of alts and build alts table for given mainname
	for alt, tmpmainname in pairs(allalts) do
		if mainname == tmpmainname then
			table.insert(alts, alt)
		end
	end

	-- check there we've actually found some alts
	if #alts == 0 then return false end

	-- cache this list of alts
	self.Altlists[mainname] = alts

	return alts
end


-- function for showing main names in the tooltip
function module:getMain(altname)
	if self.db.profile.usealtlib then
		local main = altregistry:GetMain(altname)
		if main then
			return self:formatCharName(main)
		end		

		return false
	end

	-- self.Alts = self.db.profile.altnames

	-- check for valid alt name being passed and that we actually have a list of alts
	if not altname and self.Alts then return false end

	-- format the character name
	altname = self:formatCharName(altname)

	-- check the alt name wasn't just made of invalid character
	if altname == "" then return false end

	-- check a main exists for the given alt name
	if not self.Alts[altname] then return false end

	return self.Alts[altname]
end



function module:nicejoin(t, glue, gluebeforelast)
	-- check we've got a table
	if type(t) ~= 'table' then return false end

	local list	= {}
	local index	= 1

	-- create a copy of the table with a numerical and no nested tables
	for i, v in pairs(t) do
		local vtype	= type(v)
		local item	= self:formatCharName(v)

		if vtype ~= 'string' then
			item = vtype
		end

		list[index]	= item or vtype
		index		= index + 1
	end

	-- make sure we have some items to join
	if #list == 0 then
		return ""
	end

	-- trying to join one item = that item
	if #list == 1 then
		return list[1]
	end

	-- defaults with which we will want wo woin no that's not going to work
	-- defaults
	glue		= glue or ', '
	gluebeforelast	= gluebeforelast or ', and '

	-- pop the last value off
	local last	= table.remove(list) or "" -- shouldn't need the ' or ""'?

	-- standard way of joining a list of items together
	local str	= table.concat(list, glue)

	-- return the previous list, but add the last value nicely
	return str .. gluebeforelast .. last
end


-- displays all alts for a given character as a list rather than seperate matches
function module:listAlts(mainname)
	if not mainname then return false end

	mainname = self:formatCharName(mainname)

	if mainname == "" then return false end

	local alts

	alts = self:getAlts(mainname)

	if not alts or (#alts == 0) then
		self:print(L['no alts found for character '] .. mainname)
		return
	else
		self:print(string.format(L['%d alts found for %s: %s'], #alts, clrmain(mainname), clralt(self:nicejoin(alts))))
		return #alts
	end
end


-- hooked function to show mains and alts if set in preferences
function module:OnTooltipSetUnit()
	--[[
	check:

	 . the user wants information about alts or mains on the tooltip
	 . there's a tooltip to alter
	 .  we haven't already added anything to the tooltip

	]]
	if self.altertooltip and GameTooltip and not self.showingtooltip then
		-- create lines table for extra information that might be added
		local lines	= {}

		-- check who / what the tooltip's being displayed for
		local charname, unitid	= GameTooltip:GetUnit()

		-- check to see if it's a character
		if UnitIsPlayer(unitid) then
			local mainname, alts, tooltipaltered

			-- check if the user wants the mainame name shown on alts' tooltips
			if self.db.profile.tooltip_showmain then
				local mainname = self:getMain(charname)

				if mainname then
					-- add the character's main name to the tooltip
					GameTooltip:AddDoubleLine(L['Main:'] .. ' ', clrmain(mainname), 1, 0.9, 0, 0.5, 0.5, 1)
					tooltipaltered = true
				end
			end

			local width = GameTooltip:GetWidth()
			-- check if the user wants a list of alts shown on mains' tooltips
			if self.db.profile.tooltip_showalts then
				local alts	= self:getAlts(charname) or self:getAlts(mainame)

				if alts then
					-- build the string listing alts
--					local altstr = self:nicejoin(alts)

					-- add the list of alts to the tooltip
					GameTooltip:AddLine("|cffffc080"..L['Alts:'] .. "|r " .. clralt(self:nicejoin(alts)), 1, 0.5, 0.5, 1)
					tooltipaltered = true
				end
			end

			if tooltipaltered then
				GameTooltip:SetWidth(width)
				GameTooltip:Show()
			end

			-- make sure we don't add another tooltip
			self.showingtooltip = true
		end
	end
end

-- got to reset the flag so we know when to readd the lines
function module:OnTooltipCleared()
	self.showingtooltip	= false
end


  return
end ) -- Prat:AddModuleToLoad