--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005-2010 Dan Gilbert <dan.b.gilbert@gmail.com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

-- Deutsche Lokalisierung (German, deDE)
-- Dynaletik (ICQ: 176-289-585)
-- Nihlo (ICQ: 260-869-930)
-- Telchar (ICQ: 391-632-535)

-- Letztes Update: 25.07.2010

if ( GetLocale() == "deDE" ) then

--************************************************
-- Global Atlas Strings
--************************************************

AtlasSortIgnore = {
	"der (.+)",
	"die (.+)",
	"das (.+)"
}

ATLAS_TITLE = "Atlas";

BINDING_HEADER_ATLAS_TITLE = "Atlas Tastaturbelegungen";
BINDING_NAME_ATLAS_TOGGLE = "Atlas an/aus";
BINDING_NAME_ATLAS_OPTIONS = "Optionen an/aus";
BINDING_NAME_ATLAS_AUTOSEL = "Automatische Auswahl";

ATLAS_SLASH = "/atlas";
ATLAS_SLASH_OPTIONS = "Optionen";

ATLAS_STRING_LOCATION = "Region";
ATLAS_STRING_LEVELRANGE = "Stufenbereich";
ATLAS_STRING_PLAYERLIMIT = "Max. Spielerzahl";
ATLAS_STRING_SELECT_CAT = "Kategorie wählen";
ATLAS_STRING_SELECT_MAP = "Karte wählen";
ATLAS_STRING_SEARCH = "Suchen";
ATLAS_STRING_CLEAR = "Leeren";
ATLAS_STRING_MINLEVEL = "Minimale Stufe";

ATLAS_OPTIONS_BUTTON = "Optionen";
ATLAS_OPTIONS_SHOWBUT = "Minimap-Schalter anzeigen";
ATLAS_OPTIONS_AUTOSEL = "Automatische Karten-Auswahl";
ATLAS_OPTIONS_BUTPOS = "Schalterposition";
ATLAS_OPTIONS_TRANS = "Transparenz";
ATLAS_OPTIONS_RCLICK = "Rechte Maustaste für Weltkarte drücken";
ATLAS_OPTIONS_RESETPOS = "Position zurücksetzen";
ATLAS_OPTIONS_ACRONYMS = "Abkürzungen anzeigen";
ATLAS_OPTIONS_SCALE = "Skalierung";
ATLAS_OPTIONS_BUTRAD = "Schalterradius";
ATLAS_OPTIONS_CLAMPED = "Fenster im Bildschirm festsetzen";
ATLAS_OPTIONS_CTRL = "Steuerung drücken, um Tooltips anzuzeigen";

ATLAS_BUTTON_TOOLTIP_TITLE = "Atlas";
ATLAS_BUTTON_TOOLTIP_HINT = "Linke Maustaste drücken, um Atlas zu öffnen.\nMittlere Maustaste drücken, um Atlas Optionen anzuzeigen.\nRechte Maustaste gedrückt halten, um diesen Schalter zu verschieben.";
ATLAS_LDB_HINT = "Linke Maustaste drücken, um Atlas zu öffnen.\nRechte Maustaste drücken, um die Atlas Optionen anzuzeigen.";

ATLAS_OPTIONS_CATDD = "Sortierung der Karten nach:";
ATLAS_DDL_CONTINENT = "Kontinent";
ATLAS_DDL_CONTINENT_EASTERN = "Instanzen der Östlichen Königreiche";
ATLAS_DDL_CONTINENT_KALIMDOR = "Instanzen von Kalimdor";
ATLAS_DDL_CONTINENT_OUTLAND = "Instanzen der Scherbenwelt";
ATLAS_DDL_CONTINENT_NORTHREND = "Instanzen von Nordend";
ATLAS_DDL_LEVEL = "Stufe";
ATLAS_DDL_LEVEL_UNDER45 = "Instanzen unter Stufe 45";
ATLAS_DDL_LEVEL_45TO60 = "Instanzen Stufe 45-60";
ATLAS_DDL_LEVEL_60TO70 = "Instanzen Stufe 60-70";
ATLAS_DDL_LEVEL_70TO80 = "Instanzen Stufe 70-80";
ATLAS_DDL_LEVEL_80PLUS = "Instanzen Stufe 80+";
ATLAS_DDL_PARTYSIZE = "Gruppengröße";
ATLAS_DDL_PARTYSIZE_5_AE = "Instanzen für 5 Spieler A-E";
ATLAS_DDL_PARTYSIZE_5_FZ = "Instanzen für 5 Spieler F-Z";
ATLAS_DDL_PARTYSIZE_10_AQ = "Instanzen für 10 Spieler A-Q";
ATLAS_DDL_PARTYSIZE_10_RZ = "Instanzen für 10 Spieler R-Z";
ATLAS_DDL_PARTYSIZE_20TO40 = "Instanzen für 20-40 Spieler";
ATLAS_DDL_EXPANSION = "Erweiterung";
ATLAS_DDL_EXPANSION_OLD_AO = "Instanzen der alten Welt A-O";
ATLAS_DDL_EXPANSION_OLD_PZ = "Instanzen der alten Welt P-Z";
ATLAS_DDL_EXPANSION_BC = "Burning Crusade Instanzen";
ATLAS_DDL_EXPANSION_WOTLK = "Wrath of the Lich King Instanzen";
ATLAS_DDL_TYPE = "Typ";
ATLAS_DDL_TYPE_INSTANCE_AC = "Instanzen A-C";
ATLAS_DDL_TYPE_INSTANCE_DR = "Instanzen D-R";
ATLAS_DDL_TYPE_INSTANCE_SZ = "Instanzen S-Z";
ATLAS_DDL_TYPE_ENTRANCE = "Eingänge";

ATLAS_INSTANCE_BUTTON = "Instanz";
ATLAS_ENTRANCE_BUTTON = "Eingang";
ATLAS_SEARCH_UNAVAIL = "Suche nicht verfügbar";

ATLAS_DEP_MSG1 = "Atlas hat veraltete Module entdeckt.";
ATLAS_DEP_MSG2 = "Daher wurden diese Module deaktiviert.";
ATLAS_DEP_MSG3 = "Entfernen Sie diese aus Ihrem Verzeichnis AddOns.";
ATLAS_DEP_OK = "OK";

AtlasZoneSubstitutions = {
	["Ahn'Qiraj"] = "Tempel von Ahn'Qiraj";
};

AtlasLocale = {

--************************************************
-- Zone Names, Acronyms, and Common Strings
--************************************************

	--World Events, Festival
	["Brewfest"] = "Braufest";
	["Hallow's End"] = "Schlotternächte";
	["Love is in the Air"] = "Liebe liegt in der Luft";
	["Lunar Festival"] = "Mondfest";
	["Midsummer Festival"] = "Sonnenwendfest";
	--Misc strings
	["Adult"] = "Erwachsen";
	["AKA"] = "AKA";
	["Alliance"] = "Allianz";
	["Arcane Container"] = "Arkaner Behälter";
	["Argent Dawn"] = "Argentumdämmerung";
	["Argent Crusade"] = "Argentumkreuzuug";
	["Arms Warrior"] = "Offensiv Krieger";
	["Attunement Required"] = "Zugangsquest erforderlich";
	["Back"] = "Hinten";
	["Basement"] = "Keller";
	["Bat"] = "Fledermaus";
	["Blacksmithing Plans"] = "Schmiedekunstpläne";
	["Boss"] = "Boss";
	["Brazier of Invocation"] = "Räuchergefäß der Anrufung";
	["Chase Begins"] = "Jagd beginnt";
	["Chase Ends"] = "Jagd endet";
	["Child"] = "Kind";
	["Connection"] = "Verbindung";
	["DS2"] = "DS2";
	["Elevator"] = "Aufzug";
	["End"] = "Ende";
	["Engineer"] = "Ingenieur";
	["Entrance"] = "Eingang";
	["Event"] = "Ereignis";
	["Exalted"] = "Ehrfürchtig";
	["Exit"] = "Ausgang";
	["Fourth Stop"] = "Vierter Halt";
	["Front"] = "Vorne";
	["Ghost"] = "Geist";
	["Heroic"] = "Heroisch";
	["Holy Paladin"] = "Heilig Paladin";
	["Holy Priest"] = "Heilig Priesterin";
	["Horde"] = "Horde";
	["Hunter"] = "Jäger";
	["Imp"] = "Wichtel";
	["Inside"] = "Innen";
	["Key"] = "Schlüssel";
	["Lower"] = "Unten";
	["Mage"] = "Magier";
	["Meeting Stone"] = "Versammlungsstein";
	["Monk"] = "Mönch";
	["Moonwell"] = "Mondbrunnen";
	["Optional"] = "Optional";
	["Orange"] = "Orange";
	["Outside"] = "Außerhalb";
	["Paladin"] = "Paladin";
	["Panther"] = "Panther";
	["Portal"] = "Portal";
	["Priest"] = "Priester";
	["Protection Warrior"] = "Defensiv Krieger";
	["Purple"] = "Lila";
	["Random"] = "Zufällig";
	["Raptor"] = "Raptor";
	["Rare"] = "Rar";
	["Reputation"] = "Ruf";
	["Repair"] = "Reparieren";
	["Retribution Paladin"] = "Vergeltungs Paladin";
	["Rewards"] = "Belohnungen";
	["Rogue"] = "Schurke";
	["Second Stop"] = "Zweiter Halt";
	["Shadow Priest"] = "Schatten Priesterin";
	["Shaman"] = "Schamane";
	["Side"] = "Seite";
	["Snake"] = "Schlange";
	["Spawn Point"] = "Spawnpunkt";
	["Spider"] = "Spinne";
	["Start"] = "Anfang";
	["Summon"] = "Beschwörbar";
	["Teleporter"] = "Teleporter";
	["Third Stop"] = "Dritter Halt";
	["Tiger"] = "Tiger";
	["Top"] = "Spitze";
	["Undead"] = "Untot";
	["Underwater"] = "Unter Wasser";
	["Unknown"] = "Unbekannt";
	["Upper"] = "Oben";
	["Varies"] = "Variiert";
	["Wanders"] = "Wandert";
	["Warlock"] = "Hexenmeister";
	["Warrior"] = "Krieger";
	["Wave 5"] = "Welle 5";
	["Wave 6"] = "Welle 6";
	["Wave 10"] = "Welle 10";
	["Wave 12"] = "Welle 12";
	["Wave 18"] = "Welle 18";

	--Classic Acronyms
	["AQ"] = "AQ"; -- Ahn'Qiraj
	["AQ20"] = "AQ20"; -- Ruins of Ahn'Qiraj
	["AQ40"] = "AQ40"; -- Temple of Ahn'Qiraj
	["Armory"] = "Waffenkammer"; -- Armory
	["BFD"] = "BFT"; -- Blackfathom Deeps
	["BRD"] = "BRT"; -- Blackrock Depths
	["BRM"] = "BRM"; -- Blackrock Mountain
	["BWL"] = "BWL"; -- Blackwing Lair
	["Cath"] = "Kathe"; -- Cathedral
	["DM"] = "DM"; -- Dire Maul
	["Gnome"] = "Gnome"; -- Gnomeregan
	["GY"] = "Friedhof"; -- Graveyard
	["LBRS"] = "LBRS"; -- Lower Blackrock Spire
	["Lib"] = "Bib"; -- Library
	["Mara"] = "Mara"; -- Maraudon
	["MC"] = "MC"; -- Molten Core
	["RFC"] = "RF"; -- Ragefire Chasm
	["RFD"] = "Hügel"; -- Razorfen Downs
	["RFK"] = "Kral"; -- Razorfen Kraul
	["Scholo"] = "Scholo"; -- Scholomance
	["SFK"] = "BSF"; -- Shadowfang Keep
	["SM"] = "Kloster"; -- Scarlet Monastery
	["ST"] = "Tempel"; -- Sunken Temple
	["Strat"] = "Strat"; -- Stratholme
	["Stocks"] = "Verlies"; -- The Stockade
	["UBRS"] = "UBRS"; -- Upper Blackrock Spire
	["Ulda"] = "Ulda"; -- Uldaman
	["VC"] = "DM"; -- The Deadmines
	["WC"] = "HdW"; -- Wailing Caverns
	["ZF"] = "ZF"; -- Zul'Farrak
	["ZG"] = "ZG"; -- Zul'Gurub

	--BC Acronyms
	["AC"] = "Krypta"; -- Auchenai Crypts
	["Arca"] = "Arka"; -- The Arcatraz
	["Auch"] = "Auch"; -- Auchindoun
	["BF"] = "BK"; -- The Blood Furnace
	["BT"] = "BT"; -- Black Temple
	["Bota"] = "Bota"; -- The Botanica
	["CoT"] = "HdZ"; -- Caverns of Time
	["CoT1"] = "Durnholde, HdZ1"; -- Old Hillsbrad Foothills
	["CoT2"] = "Morast, HdZ2"; -- The Black Morass
	["CoT3"] = "Hyjal, HdZ3"; -- Hyjal Summit
	["CR"] = "EK"; -- Coilfang Reservoir
	["Eye"] = "FdS"; -- The Eye
	["GL"] = "Gruul"; -- Gruul's Lair
	["HC"] = "HZ"; -- Hellfire Citadel
	["Kara"] = "Kara"; -- Karazhan
	["MaT"] = "TdM"; -- Magisters' Terrace
	["Mag"] = "Maggi"; -- Magtheridon's Lair
	["Mech"] = "Mecha"; -- The Mechanar
	["MT"] = "Gruft"; -- Mana-Tombs
	["Ramp"] = "BW"; -- Hellfire Ramparts
	["SC"] = "SSC, HdS"; -- Serpentshrine Cavern
	["Seth"] = "SH"; -- Sethekk Halls
	["SH"] = "ZH"; -- The Shattered Halls
	["SL"] = "Laby"; -- Shadow Labyrinth
	["SP"] = "SU"; -- The Slave Pens
	["SuP"] = "Sunwell"; -- Sunwell Plateau
	["SV"] = "DK"; -- The Steamvault
	["TK"] = "FdS"; -- Tempest Keep
	["UB"] = "TS"; -- The Underbog
	["ZA"] = "ZA"; -- Zul'Aman

	--WotLK Acronyms
	["AK, Kahet"] = "AK, Kahet"; -- Ahn'kahet
	["AN, Nerub"] = "AN, Azjol"; -- Azjol-Nerub
	["Champ"] = "PDC"; -- Trial of the Champion
	["CoT-Strat"] = "HdZ4"; -- Culling of Stratholme
	["Crus"] = "PDK"; -- Trial of the Crusader
	["DTK"] = "Feste"; -- Drak'Tharon Keep
	["FoS"] = "Schmiede, SS"; ["FH1"] = "FH1"; -- The Forge of Souls
	["Gun"] = "Gun"; -- Gundrak
	["HoL"] = "HdB"; -- Halls of Lightning
	["HoR"] = "HdR"; ["FH3"] = "FH3"; -- Halls of Reflection
	["HoS"] = "HdS"; -- Halls of Stone
	["IC"] = "ICC, Zita"; -- Icecrown Citadel
	["Nax"] = "Naxx"; -- Naxxramas
	["Nex, Nexus"] = "Nex"; -- The Nexus
	["Ocu"] = "Ocu"; -- The Oculus
	["Ony"] = "Ony"; -- Onyxia's Lair
	["OS"] = "Obsi"; -- The Obsidian Sanctum
	["PoS"] = "Grube"; ["FH2"] = "FH2"; -- Pit of Saron
	["RS"] = "RS"; -- The Ruby Sanctum
	["TEoE"] = "Maly"; -- The Eye of Eternity
	["UK, Keep"] = "Burg"; -- Utgarde Keep
	["Uldu"] = "Uldu"; -- Ulduar
	["UP, Pinn"] = "Turm"; -- Utgarde Pinnacle
	["VH"] = "VF, Vio"; -- The Violet Hold
	["VoA"] = "Archa"; -- Vault of Archavon

	--Zones not included in LibBabble-Zone
	["Crusaders' Coliseum"] = "Kolloseum der Kreuzfahrer"; 

--************************************************
-- Instance Entrance Maps
--************************************************

	--Auchindoun (Entrance)
	["Ha'Lei"] = "Ha'Lei";
	["Greatfather Aldrimus"] = "Großvater Aldrimus";
	["Clarissa"] = "Clarissa";
	["Ramdor the Mad"] = "Ramdor der Wahnsinnige";
	["Horvon the Armorer <Armorsmith>"] = "Horvon der Rüstungsschmied <Rüstungsschmied>";
	["Nexus-Prince Haramad"] = "Nexusprinz Haramad";
	["Artificer Morphalius"] = "Konstrukteur Morphalius";
	["Mamdy the \"Ologist\""] = "Mamdy der \"Ologe\"";
	["\"Slim\" <Shady Dealer>"] = "Smudo <Zwielichtiger Händler>";
	["\"Captain\" Kaftiz"] = "\"Kapitän\" Kaftiz";
	["Isfar"] = "Isfar";
	["Field Commander Mahfuun"] = "Feldkommandeur Mahfuun";
	["Spy Grik'tha"] = "Spionin Grik'tha";
	["Provisioner Tsaalt"] = "Versorger Tsaalt";
	["Dealer Tariq <Shady Dealer>"] = "Händler Tariq <Zwielichtiger Händler>";

	--Blackfathom Deeps (Entrance)
	--Nothing to translate!

	--Blackrock Mountain (Entrance)
	["Bodley"] = "Bodley";
	["Overmaster Pyron"] = "Übermeister Pyron";
	["Lothos Riftwaker"] = "Lothos Felsspalter";
	["Franclorn Forgewright"] = "Franclorn Schmiedevater";
	["Orb of Command"] = "Befehlskugel";
	["Scarshield Quartermaster <Scarshield Legion>"] = "Rüstmeister der Schmetterschilde <Schmetterschildlegion>";

	--Coilfang Reservoir (Entrance)
	["Watcher Jhang"] = "Behüterin Jhang";
	["Mortog Steamhead"] = "Mortog Dampfkopf";

	--Caverns of Time (Entrance)
	["Steward of Time <Keepers of Time>"] = "Ordner der Zeit <Hüter der Zeit>";
	["Alexston Chrome <Tavern of Time>"] = "Alexston Chrom <Taverne der Zeit>";
	["Yarley <Armorer>"] = "Yarley <Rüstungsschmied>";
	["Bortega <Reagents & Poison Supplies>"] = "Bortega <Reagenzien & Giftreagenzien>";
	["Galgrom <Provisioner>"] = "Galgrom <Versorger>";
	["Alurmi <Keepers of Time Quartermaster>"] = "Alurmi <Rüstmeisterin der Hüter der Zeit>";
	["Zaladormu"] = "Zaladormu";
	["Soridormi <The Scale of Sands>"] = "Soridormi <Die Wächter der Sande>";
	["Arazmodu <The Scale of Sands>"] = "Arazmodu <Die Wächter der Sande>";
	["Andormu <Keepers of Time>"] = "Andormu <Hüter der Zeit>";
	["Nozari <Keepers of Time>"] = "Nozari <Hüter der Zeit>";

	--Dire Maul (Entrance)
	["Dire Pool"] = "Düsterteich";
	["Dire Maul Arena"] = "Düsterbruch Arena";
	["Mushgog"] = "Mushgog";
	["Skarr the Unbreakable"] = "Skarr der Unbezwingbare";
	["The Razza"] = "Der Razza";
	["Elder Mistwalker"] = "Urahnin Nebelgänger";

	--Gnomeregan (Entrance)
	["Transpolyporter"] = "Transpolyporter";
	["Sprok <Away Team>"] = "Sprok <Außenteam>";
	["Matrix Punchograph 3005-A"] = "Matrix-Prägograph 3005-A";
	["Namdo Bizzfizzle <Engineering Supplies>"] = "Namdo Blitzzischel <Ingenieursbedarf>";
	["Techbot"] = "Techbot";

	-- Hellfire Citadel (Entrance)
	["Steps and path to the Blood Furnace"] = "Stufen und Pfad zum Blutkessel";
	["Path to the Hellfire Ramparts and Shattered Halls"] = "Pfad zum Höllenfeuerbollwerk und den zerschmetterten Hallen";
	["Meeting Stone of Magtheridon's Lair"] = "Versammlungsstein für Magtheridons Kammer";
	["Meeting Stone of Hellfire Citadel"] = "Versammlungsstein der Höllenfeuerzitadelle";

	--Karazhan (Entrance)
	["Archmage Leryda"] = "Erzmagierin Leryda";
	["Apprentice Darius"] = "Lehrling Darius";
	["Archmage Alturus"] = "Erzmagier Alturus";
	["Stairs to Underground Pond"] = "Treppe zum Unterirdischen Teich";
	["Stairs to Underground Well"] = "Treppe zum Unterirdischen Brunnen";
	["Charred Bone Fragment"] = "Verkohltes Knochenfragment";

	--Maraudon (Entrance)
	["The Nameless Prophet"] = "Der namenlose Prophet";
	["Kolk <The First Kahn>"] = "Kolk <Der erste Khan>";
	["Gelk <The Second Kahn>"] = "Gelk <Der zweite Khan>";
	["Magra <The Third Kahn>"] = "Magra <Der dritte Khan>";
	["Cavindra"] = "Cavindra";

	--Scarlet Monastery (Entrance)
	--Nothing to translate!

	--The Deadmines (Entrance)
	["Marisa du'Paige"] = "Marisa du'Paige";
	["Brainwashed Noble"] = "Manipulierter Adliger";
	["Foreman Thistlenettle"] = "Großknecht Distelklette";

	--Sunken Temple (Entrance)
	["Jade"] = "Jade";
	["Kazkaz the Unholy"] = "Kazkaz der Unheilige";
	["Zekkis"] = "Zekkis";
	["Veyzhak the Cannibal"] = "Veyzhack der Kannibale";

	--Uldaman (Entrance)
	["Hammertoe Grez"] = "Hammerzeh Grez";
	["Magregan Deepshadow"] = "Magregan Grubenschatten";
	["Tablet of Ryun'Eh"] = "Schrifttafel von Ryun'eh";
	["Krom Stoutarm's Chest"] = "Krom Starkarms Truhe";
	["Garrett Family Chest"] = "Familientruhe der Garretts";
	["Digmaster Shovelphlange"] = "Grubenmeister Schaufelphlansch";

	--Wailing Caverns (Entrance)
	["Mad Magglish"] = "Zausel der Verrückte";
	["Trigore the Lasher"] = "Trigore der Peitscher";
	["Boahn <Druid of the Fang>"] = "Boahn <Druide des Giftzahns>";
	["Above the Entrance:"] = "Über dem Eingang:";
	["Ebru <Disciple of Naralex>"] = "Ebru <Jüngerin von Naralex>";
	["Nalpak <Disciple of Naralex>"] = "Nalpak <Jünger von Naralex>";
	["Kalldan Felmoon <Specialist Leatherworking Supplies>"] = "Kalldan Teufelsmond <Speziallederverarbeitungsbedarf>";
	["Waldor <Leatherworking Trainer>"] = "Waldor <Lederverarbeitungslehrer>";

--************************************************
-- Kalimdor Instances (Classic)
--************************************************

	--Blackfathom Deeps
	["Ghamoo-ra"] = "Ghamoo-ra";
	["Lorgalis Manuscript"] = "Manuskript von Lorgalis";
	["Lady Sarevess"] = "Lady Sarevess";
	["Argent Guard Thaelrid <The Argent Dawn>"] = "Argentumwache Thaelrid <Die Argentumdämmerung>";
	["Gelihast"] = "Gelihast";
	["Shrine of Gelihast"] = "Schrein von Gelihast";
	["Lorgus Jett"] = "Lorgus Jett";
	["Fathom Stone"] = "Tiefenstein";
	["Baron Aquanis"] = "Baron Aquanis";
	["Twilight Lord Kelris"] = "Lord des Schattenhammers Kelris";
	["Old Serra'kis"] = "Old Serra'kis";
	["Aku'mai"] = "Aku'mai";
	["Morridune"] = "Morridune";
	["Altar of the Deeps"] = "Altar der Tiefen";

	--Dire Maul (East)
	["Pusillin"] = "Pusillin";
	["Zevrim Thornhoof"] = "Zevrim Dornhuf";
	["Hydrospawn"] = "Hydrobrut";
	["Lethtendris"] = "Lethtendris";
	["Pimgib"] = "Pimgib";
	["Old Ironbark"] = "Eisenborke der Große";
	["Alzzin the Wildshaper"] = "Alzzin der Wildformer";
	["Isalien"] = "Isalien";

	--Dire Maul (North)
	["Crescent Key"] = "Mondsichelschlüssel";--omitted from Dire Maul (West)
	--"Library" omitted from here and DM West because of SM: "Library" duplicate
	["Guard Mol'dar"] = "Wache Mol'dar";
	["Stomper Kreeg <The Drunk>"] = "Stampfer Kreeg <Der Betrunkene>";
	["Guard Fengus"] = "Wache Fengus";
	["Knot Thimblejack"] = "Knot Zwingschraub";
	["Guard Slip'kik"] = "Wache Slip'kik";
	["Captain Kromcrush"] = "Hauptmann Krombruch";
	["King Gordok"] = "König Gordok";
	["Cho'Rush the Observer"] = "Cho'Rush der Beobachter";

	--Dire Maul (West)
	["J'eevee's Jar"] = "J'eevees Glas";
	["Pylons"] = "Pylonen";
	["Shen'dralar Ancient"] = "Uralte Shen'dralar";
	["Tendris Warpwood"] = "Tendris Wucherborke";
	["Ancient Equine Spirit"] = "Uralter Pferdegeist";
	["Illyanna Ravenoak"] = "Illyanna Rabeneiche";
	["Ferra"] = "Ferra";
	["Magister Kalendris"] = "Magister Kalendris";
	["Tsu'zee"] = "Tsu'zee";
	["Immol'thar"] = "Immol'thar";
	["Lord Hel'nurath"] = "Lord Hel'nurath";
	["Prince Tortheldrin"] = "Prinz Tortheldrin";
	["Falrin Treeshaper"] = "Falrin Rankenweber";
	["Lorekeeper Lydros"] = "Hüter des Wissens Lydros";
	["Lorekeeper Javon"] = "Hüter des Wissens Javon";
	["Lorekeeper Kildrath"] = "Hüter des Wissens Kildrath";
	["Lorekeeper Mykos"] = "Hüterin des Wissens Mykos";
	["Shen'dralar Provisioner"] = "Versorger der Shen'dralar";
	["Skeletal Remains of Kariel Winthalus"] = "Die sterblichen Überreste von Kariel Winthalus";

	--Maraudon	
	["Scepter of Celebras"] = "Szepter von Celebras";
	["Veng <The Fifth Khan>"] = "Veng <Der fünfte Khan>";
	["Noxxion"] = "Noxxion";
	["Razorlash"] = "Schlingwurzler";
	["Maraudos <The Fourth Khan>"] = "Maraudos <Der vierte Khan>";
	["Lord Vyletongue"] = "Lord Schlangenzunge";
	["Meshlok the Harvester"] = "Meshlok der Ernter";
	["Celebras the Cursed"] = "Celebras der Verfluchte";
	["Landslide"] = "Erdrutsch";
	["Tinkerer Gizlock"] = "Tüftler Gizlock";
	["Rotgrip"] = "Faulschnapper";
	["Princess Theradras"] = "Prinzessin Theradras";
	["Elder Splitrock"] = "Urahne Splitterfels";

	--Ragefire Chasm
	["Maur Grimtotem"] = "Maur Grimmtotem";
	["Oggleflint <Ragefire Chieftain>"] = "Flintauge <Häuptling der Flammenschlundtroggs>";
	["Taragaman the Hungerer"] = "Taragaman der Hungerleider";
	["Jergosh the Invoker"] = "Jergosh der Herbeirufer";
	["Zelemar the Wrathful"] = "Zelemar der Hasserfüllte";
	["Bazzalan"] = "Bazzalan";

	--Razorfen Downs
	["Tuten'kash"] = "Tuten'kash";
	["Henry Stern"] = "Henry Stern";
	["Belnistrasz"] = "Belnistrasz";
	["Sah'rhee"] = "Sah'rhee";
	["Mordresh Fire Eye"] = "Mordresh Feuerauge";
	["Glutton"] = "Nimmersatt";
	["Ragglesnout"] = "Struppmähne";
	["Amnennar the Coldbringer"] = "Amnennar der Kältebringer";
	["Plaguemaw the Rotting"] = "Seuchenschlund der Faulende";

	--Razorfen Kraul
	["Roogug"] = "Roogug";
	["Aggem Thorncurse <Death's Head Prophet>"] = "Aggem Dornfluch <Prophet der Totenköpfe>";
	["Death Speaker Jargba <Death's Head Captain>"] = "Todessprecher Jargba <Hauptmann der Totenköpfe>";
	["Overlord Ramtusk"] = "Oberanführer Rammhauer";
	["Razorfen Spearhide"] = "Speerträger der Klingenhauer";
	["Agathelos the Raging"] = "Agathelos der Tobende";
	["Blind Hunter"] = "Blinder Jäger";
	["Charlga Razorflank <The Crone>"] = "Charlga Klingenflanke <Die Greisin>";
	["Willix the Importer"] = "Willix der Importeur";
	["Heralath Fallowbrook"] = "Heralath Bachquell";
	["Earthcaller Halmgar"] = "Erdenrufer Halmgar";

	--Ruins of Ahn'Qiraj
	["Cenarion Circle"] = "Zirkel des Cenarius";
	["Kurinnaxx"] = "Kurinnaxx";
	["Lieutenant General Andorov"] = "Generalleutnant Andorov";
	["Four Kaldorei Elites"] = "Vier Elitesoldaten der Kaldorei";
	["General Rajaxx"] = "General Rajaxx";
	["Captain Qeez"] = "Hauptmann Qeez";
	["Captain Tuubid"] = "Hauptmann Tuubid";
	["Captain Drenn"] = "Hauptmann Drenn";
	["Captain Xurrem"] = "Hauptmann Xurrem";
	["Major Yeggeth"] = "Major Yeggeth";
	["Major Pakkon"] = "Major Pakkon";
	["Colonel Zerran"] = "Oberst Zerran";
	["Moam"] = "Moam";
	["Buru the Gorger"] = "Buru der Verschlinger";
	["Ayamiss the Hunter"] = "Ayamiss der Jäger";
	["Ossirian the Unscarred"] = "Ossirian der Narbenlose";
	["Safe Room"] = "Sicherer Raum";

	--Temple of Ahn'Qiraj
	["Brood of Nozdormu"] = "Brut Nozdormus";
	["The Prophet Skeram"] = "Der Prophet Skeram";
	["The Bug Family"] = "Die Käferfamilie";
	["Vem"] = "Vem";
	["Lord Kri"] = "Lord Kri";
	["Princess Yauj"] = "Prinzessin Yauj";
	["Battleguard Sartura"] = "Schlachtwache Sartura";
	["Fankriss the Unyielding"] = "Fankriss der Unnachgiebige";
	["Viscidus"] = "Viscidus";
	["Princess Huhuran"] = "Prinzessin Huhuran";
	["Twin Emperors"] = "Die Zwillings-Imperatoren";
	["Emperor Vek'lor"] = "Imperator Vek'lor";
	["Emperor Vek'nilash"] = "Imperator Vek'nilash";
	["Ouro"] = "Ouro";
	["Eye of C'Thun"] = "Auge von C'Thun";
	["C'Thun"] = "C'Thun";
	["Andorgos <Brood of Malygos>"] = "Andorgos <Brut Malygos'>";
	["Vethsera <Brood of Ysera>"] = "Vethsera <Brut Yseras>";
	["Kandrostrasz <Brood of Alexstrasza>"] = "Kandrostrasz <Brut Alexstraszas>";
	["Arygos"] = "Arygos";
	["Caelestrasz"] = "Caelestrasz";
	["Merithra of the Dream"] = "Merithra des Traums";

	--Wailing Caverns
	["Disciple of Naralex"] = "Jünger von Naralex";
	["Lord Cobrahn <Fanglord>"] = "Lord Kobrahn <Giftzahnlord>";
	["Lady Anacondra <Fanglord>"] = "Lady Anacondra <Giftzahnlord>";
	["Kresh"] = "Kresh";
	["Lord Pythas <Fanglord>"] = "Lord Pythas <Giftzahnlord>";
	["Skum"] = "Skum";
	["Lord Serpentis <Fanglord>"] = "Lord Serpentis <Giftzahnlord>";
	["Verdan the Everliving"] = "Verdan der Ewiglebende";
	["Mutanus the Devourer"] = "Mutanus der Verschlinger";
	["Naralex"] = "Naralex";
	["Deviate Faerie Dragon"] = "Deviatfeendrache";

	--Zul'Farrak
	["Antu'sul <Overseer of Sul>"] = "Antu'sul <Vorarbeiter von Sul>";
	["Theka the Martyr"] = "Theka der Märtyrer";
	["Witch Doctor Zum'rah"] = "Hexendoktor Zum'rah";
	["Zul'Farrak Dead Hero"] = "Toter Held aus Zul'Farrak";
	["Nekrum Gutchewer"] = "Nekrum der Ausweider";
	["Shadowpriest Sezz'ziz"] = "Schattenpriester Sezz'ziz";
	["Dustwraith"] = "Karaburan";
	["Sergeant Bly"] = "Unteroffizier Bly";
	["Weegli Blastfuse"] = "Weegli Lunte";
	["Murta Grimgut"] = "Murta Bauchgrimm";
	["Raven"] = "Die Krähe";
	["Oro Eyegouge"] = "Oro Hohlauge";
	["Sandfury Executioner"] = "Henker der Sandwüter";
	["Hydromancer Velratha"] = "Wasserbeschwörerin Velratha";
	["Gahz'rilla"] = "Gahz'rilla";
	["Elder Wildmane"] = "Urahnin Wildmähne";
	["Chief Ukorz Sandscalp"] = "Häuptling Ukorz Sandskalp";
	["Ruuzlu"] = "Ruuzlu";
	["Zerillis"] = "Zerillis";
	["Sandarr Dunereaver"] = "Sandarr der Wüstenräuber";

--****************************
-- Eastern Kingdoms Instances (Classic)
--****************************

	--Blackrock Depths
	["Shadowforge Key"] = "Schlüssel zur Schattenschmiede";
	["Prison Cell Key"] = "Gefängniszellenschlüssel";
	["Jail Break!"] = "Gefängnisausbruch!";
	["Banner of Provocation"] = "Banner der Provokation";
	["Lord Roccor"] = "Lord Roccor";
	["Kharan Mighthammer"] = "Kharan Hammermacht";
	["Commander Gor'shak <Kargath Expeditionary Force>"] = "Kommandant Gor'shak <Expeditionskorps von Kargath>";
	["Marshal Windsor"] = "Marschall Windsor";
	["High Interrogator Gerstahn <Twilight's Hammer Interrogator>"] = "Verhörmeisterin Gerstahn <Befrager des Schattenhammers>";
	["Ring of Law"] = "Ring des Gesetzes";
	["Anub'shiah"] = "Anub'shiah";
	["Eviscerator"] = "Ausweider";
	["Gorosh the Dervish"] = "Gorosh der Derwisch";
	["Grizzle"] = "Grizzle";
	["Hedrum the Creeper"] = "Hedrum der Krabbler";
	["Ok'thor the Breaker"] = "Ok'thor der Zerstörer";
	["Theldren"] = "Theldren";
	["Lefty"] = "Lefty";
	["Malgen Longspear"] = "Malgen Langspeer";
	["Gnashjaw <Malgen Longspear's Pet>"] = "Knirschkiefer <Malgen Langspeers Tier>";
	["Rotfang"] = "Totenbiss";
	["Va'jashni"] = "Va'jashni";
	["Houndmaster Grebmar"] = "Hundemeister Grebmar";
	["Elder Morndeep"] = "Urahne Schwermut";
	["High Justice Grimstone"] = "Oberrichter Grimmstein";
	["Monument of Franclorn Forgewright"] = "Denkmal für Franclorn Schmiedevater";
	["Pyromancer Loregrain"] = "Pyromant Weisenkorn";
	["The Vault"] = "Der Tresorraum";
	["Warder Stilgiss"] = "Wärter Stilgiss";
	["Verek"] = "Verek";
	["Watchman Doomgrip"] = "Wachmann Stahlgriff";
	["Fineous Darkvire <Chief Architect>"] = "Fineous Dunkelader <Chefarchitekt>";
	["The Black Anvil"] = "Der Schwarze Amboss";
	["Lord Incendius"] = "Lord Incendius";
	["Bael'Gar"] = "Bael'Gar";
	["Shadowforge Lock"] = "Schloss der Schattenschmiede";
	["General Angerforge"] = "General Zornesschmied";
	["Golem Lord Argelmach"] = "Golemlord Argelmach";
	["Field Repair Bot 74A"] = "Feldreparaturbot 74A";
	["The Grim Guzzler"] = "Der Grimmige Säufer";
	["Hurley Blackbreath"] = "Hurley Pestatem";
	["Lokhtos Darkbargainer <The Thorium Brotherhood>"] = "Lokhtos Düsterfeilsch <Die Thoriumbruderschaft>";
	["Mistress Nagmara"] = "Herrin Nagmara";
	["Phalanx"] = "Phalanx";
	["Plugger Spazzring"] = "Stöpsel Zapfring";
	["Private Rocknot"] = "Gefreiter Rocknot";
	["Ribbly Screwspigot"] = "Ribbly Schraubstutz";
	["Coren Direbrew"] = "Coren Düsterbräu";
	["Griz Gutshank <Arena Vendor>"] = "Griz Mummwinkel <Arenaverkäufer>";
	["Ambassador Flamelash"] = "Botschafter Flammenschlag";
	["Panzor the Invincible"] = "Panzor der Unbesiegbare";
	["Summoner's Tomb"] = "Grab des Beschwörers";
	["The Lyceum"] = "Das Lyzeum";
	["Magmus"] = "Magmus";
	["Emperor Dagran Thaurissan"] = "Imperator Dagran Thaurissan";
	["Princess Moira Bronzebeard <Princess of Ironforge>"] = "Prinzessin Moira Bronzebart <Prinzessin von Eisenschmiede>";
	["High Priestess of Thaurissan"] = "Hohepriesterin von Thaurissan";
	["The Black Forge"] = "Die Schwarze Schmiede";
	["Core Fragment"] = "Kernfragment";
	["Overmaster Pyron"] = "Übermeister Pyron";

	--Blackrock Spire (Lower)
	["Vaelan"] = "Vaelan";
	["Warosh <The Cursed>"] = "Warosh <Die Verfluchten>";
	["Elder Stonefort"] = "Urahne Steinwehr";
	["Roughshod Pike"] = "Beschlagene Pike";
	["Spirestone Butcher"] = "Metzger der Felsspitzoger";
	["Highlord Omokk"] = "Hochlord Omokk";
	["Spirestone Battle Lord"] = "Kampflord der Felsspitzoger";
	["Spirestone Lord Magus"] = "Maguslord der Felsspitzoger";
	["Shadow Hunter Vosh'gajin"] = "Schattenjägerin Vosh'gajin";
	["Fifth Mosh'aru Tablet"] = "Fünfte Schrifttafel von Mosh'aru";
	["Bijou"] = "Bijou";
	["War Master Voone"] = "Kriegsmeister Voone";
	["Mor Grayhoof"] = "Mor Grauhuf";
	["Sixth Mosh'aru Tablet"] = "Sechste Schrifttafel von Mosh'aru";
	["Bijou's Belongings"] = "Bijous Habseligkeiten";
	["Human Remains"] = "Menschliche Überreste";
	["Unfired Plate Gauntlets"] = "Ungebrannte Plattenstulpen";
	["Bannok Grimaxe <Firebrand Legion Champion>"] = "Bannok Grimmaxt <Champion der Feuerbrandlegion>";
	["Mother Smolderweb"] = "Mutter Glimmernetz";
	["Crystal Fang"] = "Kristallfangzahn";
	["Urok's Tribute Pile"] = "Uroks Tributhaufen";
	["Urok Doomhowl"] = "Urok Schreckensbote";
	["Quartermaster Zigris <Bloodaxe Legion>"] = "Rüstmeister Zigris <Blutaxtlegion>";
	["Halycon"] = "Halycon";
	["Gizrul the Slavener"] = "Gizrul der Geifernde";
	["Ghok Bashguud <Bloodaxe Champion>"] = "Ghok Haudrauf <Champion der Blutäxte>";
	["Overlord Wyrmthalak"] = "Oberanführer Wyrmthalak";
	["Burning Felguard"] = "Brennende Teufelswache";

	--Blackrock Spire (Upper)
	["Pyroguard Emberseer"] = "Feuerwache Glutseher";
	["Solakar Flamewreath"] = "Solakar Feuerkrone";
	["Father Flame"] = "Vater Flamme";
	["Darkstone Tablet"] = "Dunkelsteinschrifttafel";
	["Doomrigger's Coffer"] = "Doomriggers Kasten";
	["Jed Runewatcher <Blackhand Legion>"] = "Jed Runenblick <Schwarzfaustlegion>";
	["Goraluk Anvilcrack <Blackhand Legion Armorsmith>"] = "Goraluk Hammerbruch <Rüstungsschmied der Schwarzfaustlegion>";
	["Warchief Rend Blackhand"] = "Kriegshäuptling Rend Schwarzfaust";
	["Gyth <Rend Blackhand's Mount>"] = "Gyth <Rend Schwarzfausts Reittier>";
	["Awbee"] = "Awbee";
	["The Beast"] = "Die Bestie";
	["Lord Valthalak"] = "Lord Valthalak";
	["Finkle Einhorn"] = "Finkle Einhorn";
	["General Drakkisath"] = "General Drakkisath";
	["Drakkisath's Brand"] = "Drakkisaths Brandzeichen";

	--Blackwing Lair
	["Razorgore the Untamed"] = "Feuerkralle der Ungezähmte";
	["Vaelastrasz the Corrupt"] = "Vaelastrasz der Verdorbene";
	["Broodlord Lashlayer"] = "Brutwächter Dreschbringer";
	["Firemaw"] = "Feuerschwinge";
	["Draconic for Dummies (Chapter VII)"] = "Drachisch für Dummies (Kapitel VII)";
	["Master Elemental Shaper Krixix"] = "Meisterelementarformer Krixix";
	["Ebonroc"] = "Schattenschwinge";
	["Flamegor"] = "Flammenmaul";
	["Chromaggus"] = "Chromaggus";
	["Nefarian"] = "Nefarian";

	--Gnomeregan
	["Workshop Key"] = "Werkstattschlüssel";
	["Blastmaster Emi Shortfuse"] = "Sprengmeisterin Emi Schnellzünd";
	["Grubbis"] = "Grubbis";
	["Chomper"] = "Mümmler";
	["Clean Room"] = "Saubere Zone";
	["Tink Sprocketwhistle <Engineering Supplies>"] = "Tink Sprosspfiff <Ingenieursbedarf>";
	["The Sparklematic 5200"] = "Der Funkelmat 5200";
	["Mail Box"] = "Briefkasten";
	["Kernobee"] = "Kernobee";
	["Alarm-a-bomb 2600"] = "Bombenalarm 2600";
	["Matrix Punchograph 3005-B"] = "Matrix-Prägograph 3005-B";
	["Viscous Fallout"] = "Verflüssigte Ablagerung";
	["Electrocutioner 6000"] = "Elektrokutor 6000";
	["Matrix Punchograph 3005-C"] = "Matrix-Prägograph 3005-C";
	["Crowd Pummeler 9-60"] = "Meuteverprügler 9-60";
	["Matrix Punchograph 3005-D"] = "Matrix-Prägograph 3005-D";
	["Dark Iron Ambassador"] = "Botschafter der Dunkeleisenzwerge";
	["Mekgineer Thermaplugg"] = "Robogenieur Thermadraht";

	--Molten Core
	["Hydraxian Waterlords"] = "Hydraxianer";
	["Lucifron"] = "Lucifron";
	["Magmadar"] = "Magmadar";
	["Gehennas"] = "Gehennas";
	["Garr"] = "Garr";
	["Shazzrah"] = "Shazzrah";
	["Baron Geddon"] = "Baron Geddon";
	["Golemagg the Incinerator"] = "Golemagg der Verbrenner";
	["Sulfuron Harbinger"] = "Sulfuronherold";
	["Majordomo Executus"] = "Majordomus Exekutus";
	["Ragnaros"] = "Ragnaros";

	--Scholomance
	["Skeleton Key"] = "Skelettschlüssel";
	["Viewing Room Key"] = "Schlüssel zum Vorführraum";
	["Viewing Room"] = "Vorführraum";
	["Blood of Innocents"] = "Das Blut Unschuldiger";
	["Divination Scryer"] = "Orakel der Anrufung";
	["Blood Steward of Kirtonos"] = "Blutdiener von Kirtonos";
	["The Deed to Southshore"] = "Die Besitzurkunde für Süderstade";
	["Kirtonos the Herald"] = "Kirtonos der Herold";
	["Jandice Barov"] = "Jandice Barov";
	["The Deed to Tarren Mill"] = "Die Besitzurkunde für Tarrens Mühle";
	["Rattlegore"] = "Blutrippe";
	["Death Knight Darkreaver"] = "Todesritter Schattensichel";
	["Marduk Blackpool"] = "Marduk Schwarzborn";
	["Vectus"] = "Vectus";
	["Ras Frostwhisper"] = "Ras Frostraunen";
	["The Deed to Brill"] = "Die Besitzurkunde für Brill";
	["Kormok"] = "Kormok";
	["Instructor Malicia"] = "Instrukteurin Malicia";
	["Doctor Theolen Krastinov <The Butcher>"] = "Doktor Theolen Krastinov <Der Schlächter>";
	["Lorekeeper Polkelt"] = "Hüter des Wissens Polkelt";
	["The Ravenian"] = "Der Ravenier";
	["Lord Alexei Barov"] = "Lord Alexei Barov";
	["The Deed to Caer Darrow"] = "Die Besitzurkunde für Darrowehr";
	["Lady Illucia Barov"] = "Lady Illucia Barov";
	["Darkmaster Gandling"] = "Dunkelmeister Gandling";
	["Torch Lever"] = "Fackelhebel";
	["Secret Chest"] = "Geheime Truhe";
	["Alchemy Lab"] = "Alchimielabor";

	--Shadowfang Keep
	["Deathsworn Captain"] = "Todeshöriger Hauptmann";
	["Rethilgore <The Cell Keeper>"] = "Rotkralle <Der Zellenbewahrer>";
	["Sorcerer Ashcrombe"] = "Zauberhexer Aschengrund";
	["Deathstalker Adamant"] = "Todespirscher Adamant";
	["Landen Stilwell"] = "Landen Stillbrunn";
	["Investigator Fezzen Brasstacks"] = "Ermittler Fezzen Kupferstapel";
	["Deathstalker Vincent"] = "Todespirscher Vincent";
	["Apothecary Trio"] = "Apotheker-Trio";
	["Apothecary Hummel <Crown Chemical Co.>"] = "Apotheker Hummel <Chemiemanufaktur Krone>";
	["Apothecary Baxter <Crown Chemical Co.>"] = "Apotheker Baxter <Chemiemanufaktur Krone>";
	["Apothecary Frye <Crown Chemical Co.>"] = "Apotheker Frye <Chemiemanufaktur Krone>";
	["Fel Steed"] = "Teufelsross";
	["Jordan's Hammer"] = "Jordans Hammer";
	["Crate of Ingots"] = "Kiste mit Blöcken";
	["Razorclaw the Butcher"] = "Klingenklaue der Metzger";
	["Baron Silverlaine"] = "Baron Silberlein";
	["Commander Springvale"] = "Kommandant Grünthal";
	["Odo the Blindwatcher"] = "Odo der Blindseher";
	["Fenrus the Devourer"] = "Fenrus der Verschlinger";
	["Arugal's Voidwalker"] = "Arugals Leerwandler";
	["The Book of Ur"] = "Das Buch von Ur";
	["Wolf Master Nandos"] = "Wolfmeister Nandos";
	["Archmage Arugal"] = "Erzmagier Arugal";

	--SM: Armory
	["The Scarlet Key"] = "Der scharlachrote Schlüssel";--omitted from SM: Cathedral
	["Herod <The Scarlet Champion>"] = "Herod <Der Scharlachrote Held>";

	--SM: Cathedral
	["High Inquisitor Fairbanks"] = "Hochinquisitor Schönufer";
	["Scarlet Commander Mograine"] = "Scharlachroter Kommandant Mograine";
	["High Inquisitor Whitemane"] = "Hochinquisitorin Weißsträhne";

	--SM: Graveyard
	["Interrogator Vishas"] = "Befrager Vishas";
	["Vorrel Sengutz"] = "Vorrel Sengutz";
	["Pumpkin Shrine"] = "Kürbisschrein";
	["Headless Horseman"] = "Der kopflose Reiter";
	["Bloodmage Thalnos"] = "Blutmagier Thalnos";
	["Ironspine"] = "Eisenrücken";
	["Azshir the Sleepless"] = "Azshir der Schlaflose";
	["Fallen Champion"] = "Gestürzter Held";

	--SM: Library
	["Houndmaster Loksey"] = "Hundemeister Loksey";
	["Arcanist Doan"] = "Arkanist Doan";

	--Stratholme
	["The Scarlet Key"] = "Der scharlachrote Schlüssel";
	["Key to the City"] = "Schlüssel zur Stadt";
	["Various Postbox Keys"] = "Verschiedene Briefkastenschlüssel";
	["Living Side"] = "Seite der Lebenden";
	["Undead Side"] = "Seite der Untoten";
	["Skul"] = "Skul";
	["Stratholme Courier"] = "Kurier von Stratholme";
	["Fras Siabi"] = "Fras Siabi";
	["Atiesh <Hand of Sargeras>"] = "Atiesh <Hand von Sargeras>";
	["Hearthsinger Forresten"] = "Herdsinger Forresten";
	["The Unforgiven"] = "Der Unverziehene";
	["Elder Farwhisper"] = "Urahne Fernwisper";
	["Timmy the Cruel"] = "Timmy der Grausame";
	["Malor the Zealous"] = "Malor der Eifrige";
	["Malor's Strongbox"] = "Malors Geldkassette";
	["Crimson Hammersmith"] = "Purpurroter Hammerschmied";
	["Cannon Master Willey"] = "Kanonenmeister Willey";
	["Archivist Galford"] = "Archivar Galford";
	["Grand Crusader Dathrohan"] = "Oberster Kreuzzügler Dathrohan";
	["Balnazzar"] = "Balnazzar";
	["Sothos"] = "Sothos";
	["Jarien"] = "Jarien";
	["Magistrate Barthilas"] = "Magistrat Barthilas";
	["Aurius"] = "Aurius";
	["Stonespine"] = "Steinbuckel";
	["Baroness Anastari"] = "Baroness Anastari";
	["Black Guard Swordsmith"] = "Schwertschmied der schwarzen Wache";
	["Nerub'enkan"] = "Nerub'enkan";
	["Maleki the Pallid"] = "Maleki der Leichenblasse";
	["Ramstein the Gorger"] = "Ramstein der Verschlinger";
	["Baron Rivendare"] = "Baron Totenschwur";
	["Ysida Harmon"] = "Ysida Harmon";
	["Crusaders' Square Postbox"] = "Briefkasten am Kreuzzüglerplatz";
	["Market Row Postbox"] = "Briefkasten in der Marktgasse";
	["Festival Lane Postbox"] = "Briefkasten in der Feststraße";
	["Elders' Square Postbox"] = "Briefkasten am Ältestenplatz";
	["King's Square Postbox"] = "Briefkasten am Königsplatz";
	["Fras Siabi's Postbox"] = "Fras Siabis Briefkasten";
	["3rd Box Opened"] = "Dritter geöffneter Briefkasten";
	["Postmaster Malown"] = "Postmeister Malown";

	--The Deadmines
	["Rhahk'Zor <The Foreman>"] = "Rhahk'Zor <Der Großknecht>";
	["Miner Johnson"] = "Minenarbeiter Johnson";
	["Sneed <Lumbermaster>"] = "Sneed <Holzfällermeister>";
	["Sneed's Shredder <Lumbermaster>"] = "Sneeds Schredder <Holzfällermeister>";
	["Gilnid <The Smelter>"] = "Gilnid <Der Schmelzer>";
	["Defias Gunpowder"] = "Schießpulver der Defias";
	["Captain Greenskin"] = "Kapitän Grünhaut";
	["Edwin VanCleef <Defias Kingpin>"] = "Edwin van Cleef <Herrscher der Defias>";
	["Mr. Smite <The Ship's First Mate>"] = "Handlanger Pein <Der Erste Maat>";
	["Cookie <The Ship's Cook>"] = "Krümel <Der Smutje>";

	--The Stockade
	["Targorr the Dread"] = "Targorr der Schreckliche";
	["Kam Deepfury"] = "Kam Tiefenzorn";
	["Hamhock"] = "Hamhock";
	["Bazil Thredd"] = "Bazil Thredd";
	["Dextren Ward"] = "Dextren Ward";
	["Bruegal Ironknuckle"] = "Bruegal Eisenfaust";

	--The Sunken Temple
	["The Temple of Atal'Hakkar"] = "Versunkener Tempel";
	["Yeh'kinya's Scroll"] = "Yeh'kinyas Rolle";
	["Atal'ai Defenders"] = "Atal'ai Verteidiger";
	["Gasher"] = "Schlitzer";
	["Loro"] = "Loro";
	["Hukku"] = "Hukku";
	["Zolo"] = "Zolo";
	["Mijan"] = "Mijan";
	["Zul'Lor"] = "Zul'Lor";
	["Altar of Hakkar"] = "Altar von Hakkar";
	["Atal'alarion <Guardian of the Idol>"] = "Atal'alarion <Wächter des Götzen>";
	["Dreamscythe"] = "Traumsense";
	["Weaver"] = "Wirker";
	["Avatar of Hakkar"] = "Avatar von Hakkar";
	["Jammal'an the Prophet"] = "Jammal'an der Prophet";
	["Ogom the Wretched"] = "Ogom der Elende";
	["Morphaz"] = "Morphaz";
	["Hazzas"] = "Hazzas";
	["Shade of Eranikus"] = "Eranikus' Schemen";
	["Essence Font"] = "Essenz-Born";
	["Spawn of Hakkar"] = "Brut von Hakkar";
	["Elder Starsong"] = "Urahnin Sternensang";
	["Statue Activation Order"] = "Statuen Aktivierungsreihenfolge";

	--Uldaman
	["Staff of Prehistoria"] = "Stab der Prähistorie";
	["Baelog"] = "Baelog";
	["Eric \"The Swift\""] = "Eric \"Der Flinke\"";
	["Olaf"] = "Olaf";
	["Baelog's Chest"] = "Baelogs Truhe";
	["Conspicuous Urn"] = "Verdächtige Urne";
	["Remains of a Paladin"] = "Überreste eines Paladins";
	["Revelosh"] = "Revelosh";
	["Ironaya"] = "Ironaya";
	["Obsidian Sentinel"] = "Obsidianschildwache";
	["Annora <Enchanting Trainer>"] = "Annora <Verzauberkunstlehrerin>";
	["Ancient Stone Keeper"] = "Uralter Steinbewahrer";
	["Galgann Firehammer"] = "Galgann Feuerhammer";
	["Tablet of Will"] = "Schrifttafel des Willens";
	["Shadowforge Cache"] = "Schattenschmiedecache";
	["Grimlok <Stonevault Chieftain>"] = "Grimlok <Häuptling der Steingrufttroggs>";
	["Archaedas <Ancient Stone Watcher>"] = "Archaedas <Alter Steinbehüter>";
	["The Discs of Norgannon"] = "Die Scheiben von Norgannon";
	["Ancient Treasure"] = "Antiker Schatz";

	--Zul'Gurub
	["Zandalar Tribe"] = "Stamm der Zandalar";
	["Mudskunk Lure"] = "Matschstinkerköder";
	["Gurubashi Mojo Madness"] = "Mojowahnsinn der Gurubashi";
	["High Priestess Jeklik"] = "Hohepriesterin Jeklik";
	["High Priest Venoxis"] = "Hohepriester Venoxis";
	["Zanza the Restless"] = "Zanza der Ruhelose";
	["High Priestess Mar'li"] = "Hohepriesterin Mar'li";
	["Bloodlord Mandokir"] = "Blutfürst Mandokir";
	["Ohgan"] = "Ohgan";
	["Edge of Madness"] = "Rand des Wahnsinns";
	["Gri'lek"] = "Gri'lek";
	["Hazza'rah"] = "Hazza'rah";
	["Renataki"] = "Renataki";
	["Wushoolay"] = "Wushoolay";
	["Gahz'ranka"] = "Gahz'ranka";
	["High Priest Thekal"] = "Hohepriester Thekal";
	["Zealot Zath"] = "Zelot Zath";
	["Zealot Lor'Khan"] = "Zelot Lor'Khan";
	["High Priestess Arlokk"] = "Hohepriesterin Arlokk";
	["Jin'do the Hexxer"] = "Jin'do der Verhexer";
	["Hakkar"] = "Hakkar";
	["Muddy Churning Waters"] = "Schlammiges aufgewühltes Gewässer";

--*******************
-- Burning Crusade Instances
--*******************

	--Auch: Auchenai Crypts
	["Lower City"] = "Unteres Viertel";--omitted from other Auch
	["Shirrak the Dead Watcher"] = "Shirrak der Totenwächter";
	["Exarch Maladaar"] = "Exarch Maladaar";
	["Avatar of the Martyred"] = "Avatar des Gemarterten";
	["D'ore"] = "D'ore";

	--Auch: Mana-Tombs
	["The Consortium"] = "Das Konsortium";
	["Auchenai Key"] = "Schlüssel der Auchenai";--omitted from other Auch
	["The Eye of Haramad"] = "Das Auge des Haramad";
	["Pandemonius"] = "Pandemonius";
	["Shadow Lord Xiraxis"] = "Schattenlord Xiraxis";
	["Ambassador Pax'ivi"] = "Botschafter Pax'ivi";
	["Tavarok"] = "Tavarok";
	["Cryo-Engineer Sha'heen"] = "Kryoingenieur Sha'heen";
	["Ethereal Transporter Control Panel"] = "Bedienungskonsole des Astraltransporters";
	["Nexus-Prince Shaffar"] = "Nexusprinz Shaffar";
	["Yor <Void Hound of Shaffar>"] = "Yor <Shaffars Leerenhund>";

	--Auch: Sethekk Halls
	["Essence-Infused Moonstone"] = "Mit Essenz erfüllter Mondstein";
	["Darkweaver Syth"] = "Dunkelwirker Syth";
	["Lakka"] = "Lakka";
	["The Saga of Terokk"] = "Die Sage von Terokk";
	["Anzu"] = "Anzu";
	["Talon King Ikiss"] = "Klauenkönig Ikiss";

	--Auch: Shadow Labyrinth
	["Shadow Labyrinth Key"] = "Schlüssel des Schattenlabyrinths";
	["Spy To'gun"] = "Spion To'gun";
	["Ambassador Hellmaw"] = "Botschafter Höllenschlund";
	["Blackheart the Inciter"] = "Schwarzherz der Hetzer";
	["Grandmaster Vorpil"] = "Großmeister Vorpil";
	["The Codex of Blood"] = "Kodex des Blutes";
	["Murmur"] = "Murmur";
	["First Fragment Guardian"] = "Wächter des ersten Teils";

	--Black Temple (Start)
	["Ashtongue Deathsworn"] = "Todeshörige der Aschenzungen";--omitted from other BT
	["Towards Reliquary of Souls"] = "Zum Relikt der Seelen";
	["Towards Teron Gorefiend"] = "Zu Teron Blutschatten";
	["Towards Illidan Stormrage"] = "Zu Illidan Sturmgrimm";
	["Spirit of Olum"] = "Geist von Olum";
	["High Warlord Naj'entus"] = "Oberster Kriegsfürst Naj'entus";
	["Supremus"] = "Supremus";
	["Shade of Akama"] = "Akamas Schemen";
	["Spirit of Udalo"] = "Geist von Udalo";
	["Aluyen <Reagents>"] = "Aluyen <Reagenzien>";
	["Okuno <Ashtongue Deathsworn Quartermaster>"] = "Okuno <Rüstmeister der Todeshörigen>";
	["Seer Kanai"] = "Seher Kanai";

	--Black Temple (Basement)
	["Gurtogg Bloodboil"] = "Gurtogg Siedeblut";
	["Reliquary of Souls"] = "Relikt der Seelen";
	["Essence of Suffering"] = "Essenz des Leidens";
	["Essence of Desire"] = "Essenz der Begierde";
	["Essence of Anger"] = "Essenz des Zorns";
	["Teron Gorefiend"] = "Teron Blutschatten";  

	--Black Temple (Top)
	["Mother Shahraz"] = "Mutter Shahraz";
	["The Illidari Council"] = "Der Rat der Illidari";
	["Lady Malande"] = "Lady Malande";
	["Gathios the Shatterer"] = "Gathios der Zerschmetterer";
	["High Nethermancer Zerevor"] = "Hochnethermant Zerevor";
	["Veras Darkshadow"] = "Veras Schwarzschatten";
	["Illidan Stormrage <The Betrayer>"] = "Illidan Sturmgrimm <Der Verräter>";

	--CFR: Serpentshrine Cavern
	["Hydross the Unstable <Duke of Currents>"] = "Hydross der Unstete <Fürst der Strömung>";
	["The Lurker Below"] = "Das Grauen aus der Tiefe";
	["Leotheras the Blind"] = "Leotheras der Blinde";
	["Fathom-Lord Karathress"] = "Tiefenlord Karathress";
	["Seer Olum"] = "Seher Olum";
	["Morogrim Tidewalker"] = "Morogrim Gezeitenwandler";
	["Lady Vashj <Coilfang Matron>"] = "Lady Vashj <Matrone des Echsenkessels>";

	--CFR: The Slave Pens
	["Cenarion Expedition"] = "Expedition des Cenarius";--omitted from other CR
	["Reservoir Key"] = "Schlüssel des Kessels";--omitted from other CR
	["Mennu the Betrayer"] = "Mennu der Verräter";
	["Weeder Greenthumb"] = "Jäter Gründaum";
	["Skar'this the Heretic"] = "Nar'biss der Ketzer";
	["Rokmar the Crackler"] = "Rokmar der Zerquetscher";
	["Naturalist Bite"] = "Naturalist Biss";
	["Quagmirran"] = "Quagmirran";
	["Ahune <The Frost Lord>"] = "Ahune <Der Frostfürst>";

	--CFR: The Steamvault
	["Hydromancer Thespia"] = "Wasserbeschwörerin Thespia";
	["Main Chambers Access Panel"] = "Zugangskonsole der Hauptkammer";
	["Second Fragment Guardian"] = "Wächter des zweiten Teils";
	["Mekgineer Steamrigger"] = "Robogenieur Dampfhammer";
	["Warlord Kalithresh"] = "Kriegsherr Kalithresh";

	--CFR: The Underbog
	["Hungarfen"] = "Hungarfenn";
	["The Underspore"] = "Die Tiefenspore";
	["Ghaz'an"] = "Ghaz'an";
	["Earthbinder Rayge"] = "Erdbinder Rayge";
	["Swamplord Musel'ek"] = "Sumpffürst Musel'ek";
	["Claw <Swamplord Musel'ek's Pet>"] = "Klaue <Sumpffürst Musel'eks Tier>";
	["The Black Stalker"] = "Die Schattenmutter";

	--CoT: The Black Morass
	["Opening of the Dark Portal"] = "Öffnung des Dunklen Portals";
	["Keepers of Time"] = "Hüter der Zeit";--omitted from Old Hillsbrad Foothills
	["Key of Time"] = "Schlüssel der Zeit";--omitted from Old Hillsbrad Foothills
	["Sa'at <Keepers of Time>"] = "Sa'at <Hüter der Zeit>";
	["Chrono Lord Deja"] = "Chronolord Deja";
	["Temporus"] = "Temporus";
	["Aeonus"] = "Aeonus";
	["The Dark Portal"] = "Das Dunkle Portal";
	["Medivh"] = "Medivh";

	--CoT: Hyjal Summit
	["Battle for Mount Hyjal"] = "Schlacht um Berg Hyjal";
	["The Scale of the Sands"] = "Die Wächter der Sande";
	["Alliance Base"] = "Basis der Allianz";
	["Lady Jaina Proudmoore"] = "Lady Jaina Prachtmeer";
	["Horde Encampment"] = "Lager der Horde";
	["Thrall <Warchief>"] = "Thrall <Kriegshäuptling>";
	["Night Elf Village"] = "Nachtelfen Dorf";
	["Tyrande Whisperwind <High Priestess of Elune>"] = "Tyrande Wisperwind <Hohepriesterin von Elune>";
	["Rage Winterchill"] = "Furor Winterfrost";
	["Anetheron"] = "Anetheron";
	["Kaz'rogal"] = "Kaz'rogal";
	["Azgalor"] = "Azgalor";
	["Archimonde"] = "Archimonde";
	["Indormi <Keeper of Ancient Gem Lore>"] = "Indormi <Bewahrerin der alten Edelsteinkunde>";
	["Tydormu <Keeper of Lost Artifacts>"] = "Tydormu <Bewahrer der verlorenen Artefakte>";

	--CoT: Old Hillsbrad Foothills
	["Escape from Durnholde Keep"] = "Flucht aus Burg Durnholde";
	["Erozion"] = "Erozion";
	["Brazen"] = "Brazen";
	["Landing Spot"] = "Landepunkt";
	["Lieutenant Drake"] = "Leutnant Drach";
	["Thrall"] = "Thrall";
	["Captain Skarloc"] = "Kapitän Skarloc";
	["Epoch Hunter"] = "Epochenjäger";
	["Taretha"] = "Taretha";
	["Jonathan Revah"] = "Jonathan Revah";
	["Jerry Carter"] = "Jerry Carter";
	["Traveling"] = "Reisend";
	["Thomas Yance <Travelling Salesman>"] = "Thomas Yance <Handelsreisender>";
	["Aged Dalaran Wizard"] = "Gealterter Hexer von Dalaran";
	["Kel'Thuzad <The Kirin Tor>"] = "Kel'Thuzad <Kirin Tor>";
	["Helcular"] = "Helcular";
	["Farmer Kent"] = "Bauer Kent";
	["Sally Whitemane"] = "Sally Weißsträhne";
	["Renault Mograine"] = "Renault Mograine";
	["Little Jimmy Vishas"] = "Kleiner Jimmy Vishas";
	["Herod the Bully"] = "Herod der Tyrann";
	["Nat Pagle"] = "Nat Pagle";
	["Hal McAllister"] = "Hal McAllister";
	["Zixil <Aspiring Merchant>"] = "Zixil <Aufstrebender Händler>";
	["Overwatch Mark 0 <Protector>"] = "Überwacher V.0 <Beschützer>";
	["Southshore Inn"] = "Süderstade Gasthaus";
	["Captain Edward Hanes"] = "Kapitän Edward Hanes";
	["Captain Sanders"] = "Kapitän Sanders";
	["Commander Mograine"] = "Kommandant Mograine";
	["Isillien"] = "Isillien";
	["Abbendis"] = "Abbendis";
	["Fairbanks"] = "Schönufer";
	["Tirion Fordring"] = "Tirion Fordring";
	["Arcanist Doan"] = "Arkanist Doan";
	["Taelan"] = "Taelan";
	["Barkeep Kelly <Bartender>"] = "Barkeeper Kelly <Schankkellner>";
	["Frances Lin <Barmaid>"] = "Frances Lin <Bardame>";
	["Chef Jessen <Speciality Meat & Slop>"] = "Küchenchef Jessen <Spezialitätenfleisch & Pampe>";
	["Stalvan Mistmantle"] = "Stalvan Dunstmantel";
	["Phin Odelic <The Kirin Tor>"] = "Phin Odelic <Kirin Tor>";
	["Magistrate Henry Maleb"] = "Magistrat Henry Maleb";
	["Raleigh the True"] = "Raleigh der Getreue";
	["Nathanos Marris"] = "Nathanos Marris";
	["Bilger the Straight-laced"] = "Bilger der Strenge";
	["Innkeeper Monica"] = "Gastwirtin Monica";
	["Julie Honeywell"] = "Julie Honigbrunn";
	["Jay Lemieux"] = "Jay Lemieux";
	["Young Blanchy"] = "Kleine Graumähne";
	["Don Carlos"] = "Don Carlos";
	["Guerrero"] = "Guerrero";

	--Gruul's Lair
	["High King Maulgar <Lord of the Ogres>"] = "Hochkönig Maulgar <Lord der Oger>";
	["Kiggler the Crazed"] = "Gicherer der Wahnsinnige";
	["Blindeye the Seer"] = "Blindauge der Seher";
	["Olm the Summoner"] = "Olm der Beschwörer";
	["Krosh Firehand"] = "Krosh Feuerhand";
	["Gruul the Dragonkiller"] = "Gruul der Drachenschlächter";

	--HFC: The Blood Furnace
	["Thrallmar"] = "Thrallmar"; --omitted from other HFC
	["Honor Hold"] = "Ehrenfeste";--omitted from other HFC
	["Flamewrought Key"] = "Flammengeschmiedeter Schlüssel";--omitted from other HFC
	["The Maker"] = "Der Schöpfer";
	["Broggok"] = "Broggok";
	["Keli'dan the Breaker"] = "Keli'dan der Zerstörer";

	--HFC: Hellfire Ramparts
	["Watchkeeper Gargolmar"] = "Wachhabender Gargolmar";
	["Omor the Unscarred"] = "Omor der Narbenlose";
	["Vazruden"] = "Vazruden";
	["Nazan <Vazruden's Mount>"] = "Nazan <Vazrudens Reittier>";
	["Reinforced Fel Iron Chest"] = "Verstärkte Teufelseisentruhe";

	--HFC: Magtheridon's Lair
	["Magtheridon"] = "Magtheridon";

	--HFC: The Shattered Halls
	["Shattered Halls Key"] = "Schlüssel der zerschmetterten Hallen";
	["Randy Whizzlesprocket"] = "Randy Sauseritzel";
	["Drisella"] = "Drisella";
	["Grand Warlock Nethekurse"] = "Großhexenmeister Nethekurse";
	["Blood Guard Porung"] = "Blutwache Porung";
	["Warbringer O'mrogg"] = "Kriegshetzer O'mrogg";
	["Warchief Kargath Bladefist"] = "Kriegshäuptling Kargath Messerfaust";
	["Shattered Hand Executioner"] = "Henker der Zerschmetterten Hand";
	["Private Jacint"] = "Gefreiter Jacint";
	["Rifleman Brownbeard"] = "Scharfschütze Braunbart";
	["Captain Alina"] = "Hauptmann Alina";
	["Scout Orgarr"] = "Späher Orgarr";
	["Korag Proudmane"] = "Korag Mähnenstolz";
	["Captain Boneshatter"] = "Hauptmann Knochenbrecher";

	--Karazhan Start
	["The Violet Eye"] = "Das Violette Auge";--omitted from Karazhan End
	["The Master's Key"] = "Der Schlüssel des Meisters";--omitted from Karazhan End
	["Staircase to the Ballroom"] = "Treppen zum Ballsaal";
	["Stairs to Upper Stable"] = "Treppen zum Oberen Stall";
	["Ramp to the Guest Chambers"] = "Rampe zu den Gästekammern";
	["Stairs to Opera House Orchestra Level"] = "Treppen zur Opernhaus Orchester Ebene";
	["Ramp from Mezzanine to Balcony"] = "Rampe vom Zwischengeschoss zum Balkon";
	["Connection to Master's Terrace"] = "Verbindung zur Terrasse des Meisters";
	["Path to the Broken Stairs"] = "Weg zur Beschädigten Treppe";--omitted from Karazhan End
	["Hastings <The Caretaker>"] = "Hastings <Der Hauswart>";
	["Servant Quarters"] = "Quartier der Diener";
	["Hyakiss the Lurker"] = "Hyakiss der Lauerer";
	["Rokad the Ravager"] = "Rokad der Verheerer";
	["Shadikith the Glider"] = "Shadikith der Gleiter";
	["Berthold <The Doorman>"] = "Berthold <Der Pförtner>";
	["Calliard <The Nightman>"] = "Calliard <Der Nachtwächter>";
	["Attumen the Huntsman"] = "Attumen der Jäger";
	["Midnight"] = "Mittnacht";
	["Koren <The Blacksmith>"] = "Koren <Der Schmied>";
	["Moroes <Tower Steward>"] = "Moroes <Turmwärter>";
	["Baroness Dorothea Millstipe"] = "Baroness Dorothea Mühlenstein";
	["Lady Catriona Von'Indi"] = "Lady Catriona Von'Indi";
	["Lady Keira Berrybuck"] = "Lady Keira Beerhas";
	["Baron Rafe Dreuger"] = "Baron Rafe Dreuger";
	["Lord Robin Daris"] = "Lord Robin Daris";
	["Lord Crispin Ference"] = "Lord Crispin Ference";
	["Bennett <The Sergeant at Arms>"] = "Bennett <Die Schutzwache>";
	["Ebonlocke <The Noble>"] = "Schwarzhaupt <Der Adlige>";
	["Keanna's Log"] = "Keannas Aufzeichnungen";
	["Maiden of Virtue"] = "Tugendhafte Maid";
	["Sebastian <The Organist>"] = "Sebastian <Der Orgelspieler>";
	["Barnes <The Stage Manager>"] = "Barnes <Der Inspizient>";
	["The Opera Event"] = "Das Opernevent";
	["Red Riding Hood"] = "Rotkäppchen";
	["The Big Bad Wolf"] = "Der große böse Wolf";
	["Wizard of Oz"] = "Zauberer von Oz";
	["Dorothee"] = "Dorothee";
	["Tito"] = "Tito";
	["Strawman"] = "Strohmann";
	["Tinhead"] = "Blechkopf";
	["Roar"] = "Brüller";
	["The Crone"] = "Die böse Hexe";
	["Romulo and Julianne"] = "Romulo und Julianne";
	["Romulo"] = "Romulo";
	["Julianne"] = "Julianne";
	["The Master's Terrace"] = "Die Terrasse des Meisters";
	["Nightbane"] = "Schrecken der Nacht";

	--Karazhan End
	["Broken Stairs"] = "Beschädigte Treppe";
	["Ramp to Guardian's Library"] = "Rampe zur Bibliothek der Beschützer";
	["Suspicious Bookshelf"] = "Verdächtiges Bücherregal";
	["Ramp up to the Celestial Watch"] = "Rampe nach oben zur Himmelswacht";
	["Ramp down to the Gamesman's Hall"] = "Rampe nach unten zur Halle der Spieler";
	["Chess Event"] = "Schachevent";
	["Ramp to Medivh's Chamber"] = "Rampe zu Medivhs Kammer";
	["Spiral Stairs to Netherspace"] = "Wendeltreppe zum Netherraum";
	["The Curator"] = "Der Kurator";
	["Wravien <The Mage>"] = "Wravien <Der Magier>";
	["Gradav <The Warlock>"] = "Gradav <Der Hexenmeister>";
	["Kamsis <The Conjurer>"] = "Kamsis <Die Beschwörerin>";
	["Terestian Illhoof"] = "Terestian Siechhuf";
	["Kil'rek"] = "Kil'rek";
	["Shade of Aran"] = "Arans Schemen";
	["Netherspite"] = "Nethergroll";
	["Ythyar"] = "Ythyar";
	["Echo of Medivh"] = "Echo Medivhs";
	["Dust Covered Chest"] = "Staubbedeckte Truhe";
	["Prince Malchezaar"] = "Prinz Malchezaar";

	--Magisters Terrace
	["Shattered Sun Offensive"] = "Offensive der Zerschmetterten Sonne";
	["Selin Fireheart"] = "Selin Feuerherz";
	["Fel Crystals"] = "Teufelskristalle";
	["Tyrith"] = "Tyrith";
	["Vexallus"] = "Vexallus";
	["Scrying Orb"] = "Seherkugel";
	["Kalecgos"] = "Kalecgos";--omitted from SP
	["Priestess Delrissa"] = "Priesterin Delrissa";
	["Apoko"] = "Apoko";
	["Eramas Brightblaze"] = "Eramas Leuchtfeuer";
	["Ellrys Duskhallow"] = "Ellrys Dämmerweih";
	["Fizzle"] = "Zischel";
	["Garaxxas"] = "Garaxxas";
	["Sliver <Garaxxas' Pet>"] = "Splitter <Garaxxas Tier>";
	["Kagani Nightstrike"] = "Kagani Nachtschlag";
	["Warlord Salaris"] = "Kriegsherr Salaris";
	["Yazzai"] = "Yazzai";
	["Zelfan"] = "Zelfan";
	["Kael'thas Sunstrider <Lord of the Blood Elves>"] = "Kael'thas Sonnenwanderer <Fürst der Blutelfen>";--omitted from TK: The Eye

	--Sunwell Plateau
	["Sathrovarr the Corruptor"] = "Sathrovarr der Verderber";
	["Madrigosa"] = "Madrigosa";
	["Brutallus"] = "Brutallus";
	["Felmyst"] = "Teufelsruch";
	["Eredar Twins"] = "Eredar Zwillinge";
	["Grand Warlock Alythess"] = "Großhexenmeisterin Alythess";
	["Lady Sacrolash"] = "Lady Sacrolash";
	["M'uru"] = "M'uru";
	["Entropius"] = "Entropius";
	["Kil'jaeden <The Deceiver>"] = "Kil'jaeden <Der Betrüger>";

	--TK: The Arcatraz
	["Key to the Arcatraz"] = "Schlüssel zur Arkatraz";
	["Zereketh the Unbound"] = "Zereketh der Unabhängige";
	["Third Fragment Guardian"] = "Wächter des dritten Teils";
	["Dalliah the Doomsayer"] = "Dalliah die Verdammnisverkünderin";
	["Wrath-Scryer Soccothrates"] = "Zornseher Soccothrates";
	["Udalo"] = "Udalo";
	["Harbinger Skyriss"] = "Herold Horizontiss";
	["Warden Mellichar"] = "Aufseher Mellichar";
	["Millhouse Manastorm"] = "Millhaus Manasturm";

	--TK: The Botanica
	["The Sha'tar"] = "Die Sha'tar";--omitted from other TK
	["Warpforged Key"] = "Warpgeschmiedeter Schlüssel";--omitted from other TK
	["Commander Sarannis"] = "Kommandant Sarannis";
	["High Botanist Freywinn"] = "Hochbotaniker Freywinn";
	["Thorngrin the Tender"] = "Dorngrin der Hüter";
	["Laj"] = "Laj";
	["Warp Splinter"] = "Warpzweig";

	--TK: The Mechanar
	["Gatewatcher Gyro-Kill"] = "Torwächter Gyrotod";
	["Gatewatcher Iron-Hand"] = "Torwächter Eisenhand";
	["Cache of the Legion"] = "Behälter der Legion";
	["Mechano-Lord Capacitus"] = "Mechanolord Kapazitus";
	["Overcharged Manacell"] = "Überladene Manazelle";
	["Nethermancer Sepethrea"] = "Nethermantin Sepethrea";
	["Pathaleon the Calculator"] = "Pathaleon der Kalkulator";

	--TK: The Eye
	["Al'ar <Phoenix God>"] = "Al'ar <Phönixgott>";
	["Void Reaver"] = "Leerhäscher";
	["High Astromancer Solarian"] = "Hochastromant Solarian";
	["Thaladred the Darkener <Advisor to Kael'thas>"] = "Thaladred der Verfinsterer <Berater von Kael'thas>";
	["Master Engineer Telonicus <Advisor to Kael'thas>"] = "Meisteringenieur Telonicus <Berater von Kael'thas>";
	["Grand Astromancer Capernian <Advisor to Kael'thas>"] = "Großastromantin Capernian <Beraterin von Kael'thas>";
	["Lord Sanguinar <The Blood Hammer>"] = "Fürst Blutdurst <Der Bluthammer>";

	--Zul'Aman
	["Harrison Jones"] = "Harrison Jones";
	["Nalorakk <Bear Avatar>"] = "Nalorakk <Avatar des Bären>";
	["Tanzar"] = "Tanzar";
	["The Map of Zul'Aman"] = "Karte von Zul'Aman";
	["Akil'Zon <Eagle Avatar>"] = "Akil'zon <Avatar des Adlers>";
	["Harkor"] = "Harkor";
	["Jan'Alai <Dragonhawk Avatar>"] = "Jan'alai <Avatar des Drachenfalken>";
	["Kraz"] = "Kraz";
	["Halazzi <Lynx Avatar>"] = "Halazzi <Avatar des Luchses>";
	["Ashli"] = "Ashli";
	["Zungam"] = "Zungam";
	["Hex Lord Malacrass"] = "Hexlord Malacrass";
	["Thurg"] = "Thurg";
	["Gazakroth"] = "Gazakroth";
	["Lord Raadan"] = "Lord Raadan";
	["Darkheart"] = "Düsterherz";
	["Alyson Antille"] = "Alyson Antille";
	["Slither"] = "Glibber";
	["Fenstalker"] = "Fennpirscher";
	["Koragg"] = "Koragg";
	["Zul'jin"] = "Zul'jin";
	["Forest Frogs"] = "Urwaldfrösche";
	["Kyren <Reagents>"] = "Kyren <Reagenzien>";
	["Gunter <Food Vendor>"] = "Gunter <Lebensmittelverkäufer>";
	["Adarrah"] = "Adarrah";
	["Brennan"] = "Brennan";
	["Darwen"] = "Darwen";
	["Deez"] = "Deez";
	["Galathryn"] = "Galathryn";
	["Mitzi"] = "Mitzi";
	["Mannuth"] = "Mannuth";

--*****************
-- WotLK Instances
--*****************

	--Azjol-Nerub: Ahn'kahet: The Old Kingdom
	["Elder Nadox"] = "Urahne Nadox";
	["Prince Taldaram"] = "Prinz Taldaram";
	["Jedoga Shadowseeker"] = "Jedoga Schattensucher";
	["Herald Volazj"] = "Herold Volazj";
	["Amanitar"] = "Amanitar";
	["Ahn'kahet Brazier"] = "Kohlenbecken von Ahn'kahet";

	--Azjol-Nerub: Azjol-Nerub
	["Krik'thir the Gatewatcher"] = "Krik'thir der Torwächter";
	["Watcher Gashra"] = "Aufseher Gashra";
	["Watcher Narjil"] = "Aufseher Narjil";
	["Watcher Silthik"] = "Aufseher Silthik";
	["Hadronox"] = "Hadronox";
	["Elder Nurgen"] = "Urahne Nurgen";
	["Anub'arak"] = "Anub'arak";

	--Caverns of Time: The Culling of Stratholme
	["The Culling of Stratholme"] = "Das Ausmerzen von Stratholme";
	["Meathook"] = "Fleischhaken";
	["Salramm the Fleshcrafter"] = "Salramm der Fleischformer";
	["Chrono-Lord Epoch"] = "Chronolord Epoch";
	["Mal'Ganis"] = "Mal'Ganis";
	["Chromie"] = "Chromie";
	["Infinite Corruptor"] = "Ewiger Verderber";
	["Guardian of Time"] = "Wächter der Zeit";
	["Scourge Invasion Points"] = "Invasionspunkte der Geißel";

	--Drak'Tharon Keep
	["Trollgore"] = "Trollgrind";
	["Novos the Summoner"] = "Novos der Beschwörer";
	["Elder Kilias"] = "Urahne Kilias";
	["King Dred"] = "König Dred";
	["The Prophet Tharon'ja"] = "Der Prophet Tharon'ja";
	["Kurzel"] = "Kurzel";
	["Drakuru's Brazier"] = "Drakuru's Kohlenpfanne";

	--The Frozen Halls: Halls of Reflection
	--3 beginning NPCs omitted, see The Forge of Souls
	["Falric"] = "Falric";
	["Marwyn"] = "Marwyn";
	["Wrath of the Lich King"] = "Flucht vor dem Lichkönig";
	["The Captain's Chest"] = "Die Truhe des Hauptmanns";

	--The Frozen Halls: Pit of Saron
	--6 beginning NPCs omitted, see The Forge of Souls
	["Forgemaster Garfrost"] = "Schmiedemeister Garfrost";
	["Martin Victus"] = "Martin Victus";
	["Gorkun Ironskull"] = "Gorkun Eisenschädel";
	["Krick and Ick"] = "Krick und Ick";
	["Scourgelord Tyrannus"] = "Geißelfürst Tyrannus";
	["Rimefang"] = "Raufang";

	--The Frozen Halls: The Forge of Souls
	--Lady Jaina Proudmoore omitted, in Hyjal Summit
	["Archmage Koreln <Kirin Tor>"] = "Erzmagier Koreln <Kirin Tor>";
	["Archmage Elandra <Kirin Tor>"] = "Erzmagierin Elandra <Kirin Tor>";
	["Lady Sylvanas Windrunner <Banshee Queen>"] = "Fürstin Sylvanas Windläufer <Bansheekönigin>";
	["Dark Ranger Loralen"] = "Dunkelläuferin Loralen";
	["Dark Ranger Kalira"] = "Dunkelläuferin Kalira";
	["Bronjahm <Godfather of Souls>"] = "Bronjahm <Seelenpate>";
	["Devourer of Souls"] = "Verschlinger der Seelen";

	--Gundrak
	["Slad'ran <High Prophet of Sseratus>"] = "Slad'ran <Hochprophet des Sseratus>";
	["Drakkari Colossus"] = "Koloss der Drakkari";
	["Elder Ohanzee"] = "Urahne Ohanzee";
	["Moorabi <High Prophet of Mam'toth>"] = "Moorabi <Hochprophet des Mam'toth>";
	["Gal'darah <High Prophet of Akali>"] = "Gal'darah <Hochprophet von Akali>";
	["Eck the Ferocious"] = "Der wilde Eck";

	--Icecrown Citadel
	["The Ashen Verdict"] = "Das Äscherne Verdikt";
	["Lord Marrowgar"] = "Lord Mark'gar";
	["Lady Deathwhisper"] = "Lady Todeswisper";
	["Gunship Battle"] = "Der Luftschiffkampf";
	["Deathbringer Saurfang"] = "Todesbringer Saurfang";
	["Festergut"] = "Fauldarm";
	["Rotface"] = "Modermiene";
	["Professor Putricide"] = "Professor Seuchenmord";
	["Blood Prince Council"] = "Rat der Blutprinzen";
	["Prince Keleseth"] = "Prinz Keleseth";
	["Prince Taldaram"] = "Prinz Taldaram";
	["Prince Valanar"] = "Prinz Valanar";
	["Blood-Queen Lana'thel"] = "Blutkönigin Lana'thel";
	["Valithria Dreamwalker"] = "Valithria Traumwandler";
	["Sindragosa <Queen of the Frostbrood>"] = "Sindragosa <Königin der Frostbrut>";
	["The Lich King"] = "Der Lichkönig";
	["To next map"] = "Zur nächsten Karte";
	["From previous map"] = "Von vorheriger Karte";
	["Upper Spire"] = "Obere Spitze";
	["Sindragosa's Lair"] = "Sindragosas Hort";

	--Naxxramas
	["Mr. Bigglesworth"] = "Mr. Bigglesworth";
	["Patchwerk"] = "Flickwerk";
	["Grobbulus"] = "Grobbulus";
	["Gluth"] = "Gluth";
	["Thaddius"] = "Thaddius";
	["Anub'Rekhan"] = "Anub'Rekhan";
	["Grand Widow Faerlina"] = "Großwitwe Faerlina";
	["Maexxna"] = "Maexxna";
	["Instructor Razuvious"] = "Instrukteur Razuvious";
	["Gothik the Harvester"] = "Gothik der Ernter";
	["The Four Horsemen"] = "Das Reiterkonzil";
	["Thane Korth'azz"] = "Than Korth'azz";
	["Lady Blaumeux"] = "Lady Blaumeux";
	--Baron Rivendare omitted, listed under Stratholme
	["Sir Zeliek"] = "Sir Zeliek";
	["Four Horsemen Chest"] = "Truhe der Vier Reiter";
	["Noth the Plaguebringer"] = "Noth der Seuchenfürst";
	["Heigan the Unclean"] = "Heigan der Unreine";
	["Loatheb"] = "Loatheb";
	["Frostwyrm Lair"] = "Frostwyrmhöhle";
	["Sapphiron"] = "Saphiron";
	["Kel'Thuzad"] = "Kel'Thuzad";

	--The Obsidian Sanctum
	["Black Dragonflight Chamber"] = "Kammer des schwarzen Drachenschwarms";
	["Sartharion <The Onyx Guardian>"] = "Sartharion <Der Onyxwächter>";
	["Tenebron"] = "Tenebron";
	["Shadron"] = "Shadron";
	["Vesperon"] = "Vesperon";

	--Onyxia's Lair
	["Onyxian Warders"] = "Onyxias Wärter";
	["Whelp Eggs"] = "Welpeneier";
	["Onyxia"] = "Onyxia";

	--The Ruby Sanctum
	["Red Dragonflight Chamber"] = "Kammer des roten Drachenschwarms";
	["Baltharus the Warborn"] = "Baltharus der Kriegsjünger";
	["Saviana Ragefire"] = "Saviana Flammenschlund";
	["General Zarithrian"] = "General Zarithrian";
	["Halion <The Twilight Destroyer>"] = "Halion <Der Zwielichtzerstörer>";

	--The Nexus: The Eye of Eternity
	["Malygos"] = "Malygos";
	["Key to the Focusing Iris"] = "Schlüssel der fokussierenden Iris";

	--The Nexus: The Nexus
	["Berinand's Research"] = "Berinands Forschungsergebnisse";
	["Commander Stoutbeard"] = "Kommandant Starkbart";
	["Commander Kolurg"] = "Kommandant Kolurg";
	["Grand Magus Telestra"] = "Großmagistrix Telestra";
	["Anomalus"] = "Anomalus";
	["Elder Igasho"] = "Urahne Igasho";
	["Ormorok the Tree-Shaper"] = "Ormorok der Baumformer";
	["Keristrasza"] = "Keristrasza";

	--The Nexus: The Oculus
	["Drakos the Interrogator"] = "Drakos der Befrager";
	["Mage-Lord Urom"] = "Magierlord Urom";
	["Ley-Guardian Eregos"] = "Leywächter Eregos";
	["Varos Cloudstrider <Azure-Lord of the Blue Dragonflight>"] = "Varos Wolkenwanderer <Azurlord des blauen Drachenschwarms>";
	["Centrifuge Construct"] = "Zentrifugenkonstrukt";
	["Cache of Eregos"] = "Eregos' Lager";

	--Trial of the Champion
	["Grand Champions"] = "Großchampions";
	["Champions of the Alliance"] = "Champions der Allianz";
	["Marshal Jacob Alerius"] = "Marschall Jacob Alerius";
	["Ambrose Boltspark"] = "Ambrose Bolzenfunk";
	["Colosos"] = "Kolosos";
	["Jaelyne Evensong"] = "Jaelyne Abendlied";
	["Lana Stouthammer"] = "Lana Starkhammer";
	["Champions of the Horde"] = "Champions der Horde";
	["Mokra the Skullcrusher"] = "Mokra der Schädelberster";
	["Eressea Dawnsinger"] = "Eressea Morgensänger";
	["Runok Wildmane"] = "Runok Wildmähne";
	["Zul'tore"] = "Zul'tore";
	["Deathstalker Visceri"] = "Todespirscher Visceri";
	["Eadric the Pure <Grand Champion of the Argent Crusade>"] = "Eadric der Reine <Großchampion des Argentumkreuzzugs>";
	["Argent Confessor Paletress"] = "Argentumbeichtpatin Blondlocke";
	["The Black Knight"] = "Der Schwarze Ritter";

	--Trial of the Crusader
	["Cavern Entrance"] = "Höhleneingang";
	["Northrend Beasts"] = "Nordend Bestien";
	["Gormok the Impaler"] = "Gormok der Pfähler";
	["Acidmaw"] = "Ätzschlund";
	["Dreadscale"] = "Schreckensmaul";
	["Icehowl"] = "Eisheuler";
	["Lord Jaraxxus"] = "Lord Jaraxxus";
	["Faction Champions"] = "Fraktion-Champions";
	["Twin Val'kyr"] = "Valkyr Zwillinge";
	["Fjola Lightbane"] = "Fjola Lichtbann";
	["Eydis Darkbane"] = "Eydis Nachtbann";
	["Anub'arak"] = "Anub'arak";
	["Heroic: Trial of the Grand Crusader"] = "Heroisch: Prüfung des Obersten Kreuzfahrers";

	-- Ulduar General
	["Celestial Planetarium Key"] = "Schlüssel des Himmlischen Planetariums";
	["The Siege"] = "Die Belagerung";
	["The Keepers"] = "Die Hüter"; --C

	-- Ulduar A
	["Flame Leviathan"] = "Flammenleviathan";
	["Ignis the Furnace Master"] = "Ignis, Meister des Eisenwerks";
	["Razorscale"] = "Klingenschuppe";
	["XT-002 Deconstructor"] = "XT-002 Dekonstruktor";
	["Tower of Life"] = "Turm des Lebens";
	["Tower of Flame"] = "Turm der Flammen";
	["Tower of Frost"] = "Turm des Frostes";
	["Tower of Storms"] = "Turm der Stürme";

	-- Ulduar B
	["Assembly of Iron"] = "Versammlung des Eisens";
	["Steelbreaker"] = "Stahlbrecher";
	["Runemaster Molgeim"] = "Runenmeister Molgeim";
	["Stormcaller Brundir"] = "Sturmrufer Brundir";
	["Kologarn"] = "Kologarn";
	["Algalon the Observer"] = "Algalon der Beobachter";
	["Prospector Doren"] = "Ausgrabungsleiter Doren"; 
	["Archivum Console"] = "Archivumkonsole";

	-- Ulduar C
	["Auriaya"] = "Auriaya";
	["Freya"] = "Freya";
	["Thorim"] = "Thorim";
	["Hodir"] = "Hodir";

	-- Ulduar D
	["Mimiron"] = "Mimiron";

	-- Ulduar E
	["General Vezax"] = "General Vezax";
	["Yogg-Saron"] = "Yogg-Saron";

	--Ulduar: Halls of Lightning
	["General Bjarngrim"] = "General Bjarngrim";
	["Volkhan"] = "Volkhan";
	["Ionar"] = "Ionar";
	["Loken"] = "Loken";

	--Ulduar: Halls of Stone
	["Elder Yurauk"] = "Urahne Yurauk";
	["Krystallus"] = "Krystallus";
	["Maiden of Grief"] = "Maid der Trauer";
	["Brann Bronzebeard"] = "Brann Bronzebart";
	["Tribunal Chest"] = "Kiste des Tribunals";
	["Sjonnir the Ironshaper"] = "Sjonnir der Eisenformer";

	--Utgarde Keep: Utgarde Keep
	["Dark Ranger Marrah"] = "Dunkelläuferin Marrah";
	["Prince Keleseth <The San'layn>"] = "Prinz Keleseth <Die San'layn>";
	["Elder Jarten"] = "Urahne Jarten";
	["Dalronn the Controller"] = "Dalronn der Aufseher";
	["Skarvald the Constructor"] = "Skarvald der Konstrukteur";
	["Ingvar the Plunderer"] = "Ingvar der Brandschatzer";

	--Utgarde Keep: Utgarde Pinnacle
	["Brigg Smallshanks"] = "Brigg Kleinkeul";
	["Svala Sorrowgrave"] = "Svala Grabesleid"; 
	["Gortok Palehoof"] = "Gortok Bleichhuf";
	["Skadi the Ruthless"] = "Skadi der Skrupellose";
	["Elder Chogan'gada"] = "Urahne Chogan'gada";
	["King Ymiron"] = "König Ymiron";

	--Vault of Archavon
	["Archavon the Stone Watcher"] = "Archavon der Steinwächter";
	["Emalon the Storm Watcher"] = "Emalon der Sturmwächter";	
	["Koralon the Flame Watcher"] = "Koralon der Flammenwächter";
	["Toravon the Ice Watcher"] = "Toravon der Eiswächter";

	--The Violet Hold
	["Erekem"] = "Erekem";
	["Zuramat the Obliterator"] = "Zuramat der Vernichter";
	["Xevozz"] = "Xevozz";
	["Ichoron"] = "Ichoron";
	["Moragg"] = "Moragg";
	["Lavanthor"] = "Lavanthor";
	["Cyanigosa"] = "Cyanigosa";
	["The Violet Hold Key"] = "Der Schlüssel zur Violetten Festung";
};

end