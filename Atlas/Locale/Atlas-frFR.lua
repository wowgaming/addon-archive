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

-- Atlas French Localization
-- Sur un travail de Wysiwyg, Kiria, Trasher en 2007 / 2010
-- Many thanks to all contributors!

if ( GetLocale() == "frFR" ) then

--************************************************
-- Global Atlas Strings
--************************************************

AtlasSortIgnore = {"le (.+)", "la (.+)", "les (.+)"};

ATLAS_TITLE = "Atlas";

BINDING_HEADER_ATLAS_TITLE = "Atlas";
BINDING_NAME_ATLAS_TOGGLE  = "Atlas [Ouvrir/Fermer]";
BINDING_NAME_ATLAS_OPTIONS = "Options [Ouvrir/Fermer]";
BINDING_NAME_ATLAS_AUTOSEL = "Auto-Select";

ATLAS_SLASH = "/atlas";
ATLAS_SLASH_OPTIONS = "options";

ATLAS_STRING_LOCATION = "Lieu";
ATLAS_STRING_LEVELRANGE = "Niveau";
ATLAS_STRING_PLAYERLIMIT = "Limite de joueurs";
ATLAS_STRING_SELECT_CAT = "Choix de la catégorie";
ATLAS_STRING_SELECT_MAP = "Choix de la carte";
ATLAS_STRING_SEARCH = "Rechercher";
ATLAS_STRING_CLEAR = "Nettoyer";
ATLAS_STRING_MINLEVEL = "Niveau Minimum";

ATLAS_OPTIONS_BUTTON = "Options";
ATLAS_OPTIONS_SHOWBUT = "Afficher le bouton sur la mini-carte";
ATLAS_OPTIONS_AUTOSEL = "Sélection automatique de la carte";
ATLAS_OPTIONS_BUTPOS = "Position du bouton";
ATLAS_OPTIONS_TRANS = "Transparence";
ATLAS_OPTIONS_RCLICK = "Clic-Droit pour afficher la carte du monde";
ATLAS_OPTIONS_RESETPOS = "Position initiale";
ATLAS_OPTIONS_ACRONYMS = "Afficher les acronymes VO/VF";
ATLAS_OPTIONS_SCALE = "Echelle";
ATLAS_OPTIONS_BUTRAD = "Rayon du bouton";
ATLAS_OPTIONS_CLAMPED = "Fixer la fenêtre à l'écran";
ATLAS_OPTIONS_CTRL = "Maintenir la touche Ctrl enfoncée pour voir les infobulles"

ATLAS_BUTTON_TOOLTIP_TITLE = "Atlas";
ATLAS_BUTTON_TOOLTIP_HINT = "Clic-Gauche pour ouvrir Atlas.\nClic-Milieu pour les options d'Atlas.\nClic-Droit pour déplacer ce bouton.";
ATLAS_LDB_HINT = "Clic-Gauche pour ouvrir Atlas.\nClic-Milieu pour les options d'Atlas.\nClic-Droit pour le menu d'affichage.";

ATLAS_OPTIONS_CATDD = "Trier les instances par :";
ATLAS_DDL_CONTINENT = "Continent";
ATLAS_DDL_CONTINENT_EASTERN = "Instances des Royaumes de l'Est";
ATLAS_DDL_CONTINENT_KALIMDOR = "Instances de Kalimdor";
ATLAS_DDL_CONTINENT_OUTLAND = "Instances de l'Outreterre";
ATLAS_DDL_CONTINENT_NORTHREND = "Instances de Norfendre";
ATLAS_DDL_LEVEL = "Niveau";
ATLAS_DDL_LEVEL_UNDER45 = "Instances avant Niveau 45";
ATLAS_DDL_LEVEL_45TO60 = "Instances Niveau 45-60";
ATLAS_DDL_LEVEL_60TO70 = "Instances Niveau 60-70";
ATLAS_DDL_LEVEL_70TO80 = "Instances Niveau 70-80";
ATLAS_DDL_LEVEL_80PLUS = "Instances Niveau 80+";
ATLAS_DDL_PARTYSIZE  = "Taille de Groupe";
ATLAS_DDL_PARTYSIZE_5_AE = "Instances pour 5 Joueurs A-E";
ATLAS_DDL_PARTYSIZE_5_FZ = "Instances pour 5 Joueurs F-Z";
ATLAS_DDL_PARTYSIZE_10_AQ = "Instances pour 10 Joueurs A-Q";
ATLAS_DDL_PARTYSIZE_10_RZ = "Instances pour 10 Joueurs R-Z";
ATLAS_DDL_PARTYSIZE_20TO40 = "Instances pour 20-40 Joueurs";
ATLAS_DDL_EXPANSION = "Extension";
ATLAS_DDL_EXPANSION_OLD_AO = "Instances du Vieux Monde (A-O)";
ATLAS_DDL_EXPANSION_OLD_PZ = "Instances du Vieux Monde (P-Z)";
ATLAS_DDL_EXPANSION_BC = "Instances Burning Crusade";
ATLAS_DDL_EXPANSION_WOTLK = "Instances Wrath of the Lich King";
ATLAS_DDL_TYPE = "Type";
ATLAS_DDL_TYPE_INSTANCE_AC = "Instances A-C";
ATLAS_DDL_TYPE_INSTANCE_DR = "Instances D-R";
ATLAS_DDL_TYPE_INSTANCE_SZ = "Instances S-Z";
ATLAS_DDL_TYPE_ENTRANCE = "Entrées";

ATLAS_INSTANCE_BUTTON = "Instance";
ATLAS_ENTRANCE_BUTTON = "Entrée";
ATLAS_SEARCH_UNAVAIL  = "Recherche Indisponible";

ATLAS_DEP_MSG1 = "Atlas a détecté un ou plusieurs module(s) qui ne sont pas à jour.";
ATLAS_DEP_MSG2 = "Ils ont été désactivés pour ce personnage.";
ATLAS_DEP_MSG3 = "Les supprimer de votre dossier AddOns.";
ATLAS_DEP_OK = "Ok";

AtlasZoneSubstitutions = {
	["Le temple d'Atal'Hakkar"] = "Le temple d'Atal'Hakkar";
	["Ahn'Qiraj"] = "Temple d'Ahn'Qiraj";
};

AtlasLocale = {

--************************************************
-- Zone Names, Acronyms, and Common Strings
--************************************************

	--World Events, Festival
	["Brewfest"] = "Fête des Brasseurs";
	["Hallow's End"] = "Sanssaint";
	["Love is in the Air"] = "De l'amour dans l'air";
	["Lunar Festival"] = "Festival lunaire";
	["Midsummer Festival"] = "Solstice d'été : la fête du Feu";
	--Misc strings
	["Adult"] = "Adulte";
	["AKA"] = "AKA";
	["Alliance"] = "Alliance";
	["Arcane Container"] = "Arcane Container";
	["Argent Dawn"] = "Aube d'argent";
	["Argent Crusade"] = "La Croisade d'argent";
	["Arms Warrior"] = "Guerrier Armes";
	["Attunement Required"] = "Harmonisation requise";
	["Back"] = "de derrière"; -- Back de Back Door, trouver mieux
	["Basement"] = "Sous-sol";
	["Bat"] = "Chauve-souris";
	["Blacksmithing Plans"] = "Plans de forge";
	["Boss"] = "Boss";
	["Brazier of Invocation"] = "Brasero d'invocation";
	["Chase Begins"] = "Début de la chasse";
	["Chase Ends"] = "Fin de la chasse";
	["Child"] = "Enfant";
	["Connection"] = "Connexion";
	["DS2"] = "Set D2";
	["Elevator"] = "Ascenseur";
	["End"] = "Fin";
	["Engineer"] = "Ingénieur";
	["Entrance"] = "Entrée";
	["Event"] = "Evènement "; -- Espace pour le blanc avant une double ponctuation
	["Exalted"] = "Exalté";
	["Exit"] = "Sortie";
	["Fourth Stop"] = "Quatrième arrêt";
	["Front"] = "Principale"; -- Front de Front Door, trouver mieux
	["Ghost"] = "Fantôme";
	["Heroic"] = "Héroïque";
	["Holy Paladin"] = "Paladin Sacré";
	["Holy Priest"] = "Prêtre Sacré";
	["Horde"] = "Horde";
	["Hunter"] = "Chasseur";
	["Imp"] = "Diablotin";
	["Inside"] = "À l'intérieur";
	["Key"] = "Clé "; -- Espace pour le blanc avant une double ponctuation
	["Lower"] = "En bas";
	["Mage"] = "Mage";
	["Meeting Stone"] = "Pierre de rencontre";
	["Monk"] = "Moine";
	["Moonwell"] = "Puits de lune";
	["Optional"] = "Optionel";
	["Orange"] = "Orange";
	["Outside"] = "Extérieur";
	["Paladin"] = "Paladin";
	["Panther"] = "Panthère";
	["Portal"] = "Portail";
	["Priest"] = "Prêtre";
	["Protection Warrior"] = "Guerrier Protection";
	["Purple"] = "Violet";
	["Random"] = "Aléatoire";
	["Raptor"] = "Raptor";
	["Rare"] = "Rare";
	["Reputation"] = "Réputation "; -- Espace pour le blanc avant une double ponctuation 
	["Repair"] = "Réparation";
	["Retribution Paladin"] = "Paladin Vindicte";
	["Rewards"] = "Récompenses";
	["Rogue"] = "Voleur";
	["Second Stop"] = "Deuxième arrêt";
	["Shadow Priest"] = "Prêtre Ombre";
	["Shaman"] = "Chaman";
	["Side"] = "Coté";
	["Snake"] = "Serpent";
	["Spawn Point"] = "Points d'apparition";
	["Spider"] = "Araignée";
	["Start"] = "Début";
	["Summon"] = "Invoqué";
	["Teleporter"] = "Téléporteur";
	["Third Stop"] = "Troisième arrêt";
	["Tiger"] = "Tigre";
	["Top"] = "Haut";
	["Undead"] = "Mort-vivant";
	["Underwater"] = "Sous l'eau";
	["Unknown"] = "Inconnu";
	["Upper"] = "En haut";
	["Varies"] = "Variable";
	["Wanders"] = "Errant";
	["Warlock"] = "Démoniste";
	["Warrior"] = "Guerrier";
	["Wave 5"] = "Vague 5";
	["Wave 6"] = "Vague 6";
	["Wave 10"] = "Vague 10";
	["Wave 12"] = "Vague 12";
	["Wave 18"] = "Vague 18";

	--Classic Acronyms
	["AQ"] = "AQ"; -- Ahn'Qiraj
	["AQ20"] = "AQ20"; -- Ruins of Ahn'Qiraj, Ruines d'Ahn'Qiraj
	["AQ40"] = "AQ40"; -- Temple of Ahn'Qiraj, Temple d'Ahn'Qiraj
	["Armory"] = "Armory"; -- Armory, Armurerie
	["BFD"] = "BFD"; -- Blackfathom Deeps, Profondeurs de Brassenoire
	["BRD"] = "BRD"; -- Blackrock Depths, Profondeurs de Rochenoire
	["BRM"] = "BRM"; -- Blackrock Mountain, Mont Rochenoire
	["BWL"] = "BWL"; -- Blackwing Lair, Repaire de l'Aile noire
	["Cath"] = "Cath"; -- Cathedral, Cathédrale
	["DM"] = "DM/HT"; -- Dire Maul, Hache-tripes
	["Gnome"] = "Gnome"; -- Gnomeregan
	["GY"] = "GY"; -- Graveyard, Cimetière
	["LBRS"] = "LBRS/Pic 1"; -- Lower Blackrock Spire, Pic Rochenoire
	["Lib"] = "Lib"; -- Library, Bibliothèque
	["Mara"] = "Mara"; -- Maraudon
	["MC"] = "MC"; -- Molten Core, Cœur du Magma
	["RFC"] = "RFC"; -- Ragefire Chasm, Gouffre de Ragefeu
	["RFD"] = "RFD"; -- Razorfen Downs, Souilles de Tranchebauge
	["RFK"] = "RFK"; -- Razorfen Kraul, Kraal de Tranchebauge
	["Scholo"] = "Scholo"; -- Scholomance
	["SFK"] = "SFK"; -- Shadowfang Keep, Donjon d'Ombrecroc
	["SM"] = "SM/Le Mona"; -- Scarlet Monastery, Monastère écarlate
	["ST"] = "ST"; -- Sunken Temple, Le temple d'Atal'Hakkar
	["Strat"] = "Strat"; -- Stratholme
	["Stocks"] = "Stocks/Prison"; -- The Stockade, La Prison
	["UBRS"] = "UBRS/Pic 2"; -- Upper Blackrock Spire, Pic Rochenoire
	["Ulda"] = "Ulda"; -- Uldaman
	["VC"] = "VC"; -- The Deadmines, Les Mortemines
	["WC"] = "WC/Lam"; -- Wailing Caverns, Cavernes des lamentations
	["ZF"] = "ZF"; -- Zul'Farrak
	["ZG"] = "ZG"; -- Zul'Gurub

	--BC Acronyms
	["AC"] = "AC"; -- Auchenai Crypts, Cryptes Auchenaï
	["Arca"] = "Arca"; -- The Arcatraz, L'Arcatraz
	["Auch"] = "Auch"; -- Auchindoun
	["BF"] = "BF"; -- The Blood Furnace, La Fournaise du sang
	["BT"] = "BT"; -- Black Temple, Temple noir
	["Bota"] = "Bota"; -- The Botanica, La Botanica
	["CoT"] = "CoT/GT"; -- Caverns of Time, Grottes du Temps
	["CoT1"] = "CoT1/G1"; -- Old Hillsbrad Foothills, Contreforts de Hautebrande d'antan
	["CoT2"] = "CoT2/GT2"; -- The Black Morass, Le Noir Marécage
	["CoT3"] = "CoT3/GT3"; -- Hyjal Summit, Sommet d'Hyjal
	["CR"] = "CR"; -- Coilfang Reservoir, Réservoir de Glissecroc
	["Eye"] = "Eye/TK"; -- The Eye, L'Œil
	["GL"] = "GL"; -- Gruul's Lair, Repaire de Gruul
	["HC"] = "HFC"; -- Hellfire Citadel, Citadelle des Flammes infernales
	["Kara"] = "Kara"; -- Karazhan
	["MaT"] = "MT"; -- Magisters' Terrace, Terrasse des Magistères
	["Mag"] = "Mag"; -- Magtheridon's Lair, Le repaire de Magtheridon
	["Mech"] = "Mech"; -- The Mechanar, Le Méchanar
	["MT"] = "MT"; -- Mana-Tombs, Tombes-mana
	["Ramp"] = "Ramp"; -- Hellfire Ramparts, Remparts des Flammes infernales
	["SC"] = "SSC"; -- Serpentshrine Cavern, Caverne du sanctuaire du Serpent
	["Seth"] = "Seth"; -- Sethekk Halls, Les salles des Sethekk
	["SH"] = "SH"; -- The Shattered Halls, Les Salles brisées
	["SL"] = "SL/Laby"; -- Shadow Labyrinth, Labyrinthe des ombres
	["SP"] = "SP"; -- The Slave Pens, Les enclos aux esclaves
	["SuP"] = "SP"; -- Sunwell Plateau, Le temple d'Atal'Hakkar
	["SV"] = "SV"; -- The Steamvault, Le Caveau de la vapeur
	["TK"] = "TK"; -- Tempest Keep, Donjon de la Tempête
	["UB"] = "UB"; -- The Underbog, La Basse-tourbière
	["ZA"] = "ZA"; -- Zul'Aman

	--WotLK Acronyms
	["AK, Kahet"] = "AK, Kahet"; -- Ahn'kahet
	["AN, Nerub"] = "AN, Nerub"; -- Azjol-Nérub
	["Champ"] = "Champ"; -- L'épreuve du champion
	["CoT-Strat"] = "Strat, CoT-Strat"; -- L'Épuration de Stratholme	
	["Crus"] = "EDC"; -- L'épreuve du croisé
	["DTK"] = "DTK"; -- Donjon de Drak'Tharon
	["FoS"] = "FdA"; ["FH1"] = "FH1"; -- La Forge des âmes
	["Gun"] = "Gun"; -- Gundrak
	["HoL"] = "HoL"; -- Les salles de Foudre
	["HoR"] = "SdR"; ["FH3"] = "FH3"; -- Salles des Reflets
	["HoS"] = "HoS"; -- Les salles de Pierre
	["IC"] = "ICC"; -- Citadelle de la Couronne de glace
	["Nax"] = "Nax"; -- Naxxramas
	["Nex, Nexus"] = "Nex, Nexus"; -- Le Nexus
	["Ocu"] = "Ocu"; -- L'Oculus
	["Ony"] = "Ony"; -- Onyxia's Lair
	["OS"] = "OS"; -- Le sanctum Obsidien
	["PoS"] = "FdS"; ["FH2"] = "FH2"; -- Fosse de Saron
	["RS"] = "SR"; -- Le sanctum Rubis
	["TEoE"] = "Maly"; -- L'Œil de l'éternité	
	["UK, Keep"] = "UK, Keep"; -- Donjon d'Utgarde
	["Uldu"] = "Uldu"; -- Ulduar
	["UP, Pinn"] = "UP, Pinn"; -- Cime d'Utgarde
	["VH"] = "VH"; -- Le fort Pourpre
	["VoA"] = "Archa"; -- Caveau d'Archavon

	--Zones not included in LibBabble-Zone
	["Crusaders' Coliseum"] = "L'épreuve du croisé";

--************************************************
-- Instance Entrance Maps
--************************************************

	--Auchindoun (Entrance)
	["Ha'Lei"] = "Ha'Lei";
	["Greatfather Aldrimus"] = "Grandpère Aldrimus";
	["Clarissa"] = "Clarissa";
	["Ramdor the Mad"] = "Ramdor le Fol";
	["Horvon the Armorer <Armorsmith>"] = "Horvon l'Armurier <Fabricant d'armures>";
	["Nexus-Prince Haramad"] = "Prince-nexus Haramad";
	["Artificer Morphalius"] = "Artificier Morphalius";
	["Mamdy the \"Ologist\""] = "Mamdy \"l'Ologiste\"";
	["\"Slim\" <Shady Dealer>"] = "\"Mince\" <Marchand douteux>";
	["\"Captain\" Kaftiz"] = "\"Captain\" Kaftiz";
	["Isfar"] = "Isfar";
	["Field Commander Mahfuun"] = "Commandant Mahfuun";
	["Spy Grik'tha"] = "Espionne Grik'tha";
	["Provisioner Tsaalt"] = "Approvisionneur Tsaalt";
	["Dealer Tariq <Shady Dealer>"] = "Camelot Tariq <Marchand douteux>";

	--Blackfathom Deeps (Entrance)
	--Nothing to translate!

	--Blackrock Mountain (Entrance)
	["Bodley"] = "Bodley";
	["Overmaster Pyron"] = "Grand seigneur Pyron";
	["Lothos Riftwaker"] = "Lothos Ouvrefaille";
	["Franclorn Forgewright"] = "Franclorn Le Forgebusier";
	["Orb of Command"] = "Orbe de Commandement";
	["Scarshield Quartermaster <Scarshield Legion>"] = "Intendant du Bouclier balafré <Légion du Bouclier balafré>";

	--Coilfang Reservoir (Entrance)
	["Watcher Jhang"] = "Guetteur Jhang";
	["Mortog Steamhead"] = "Mortog Têtavapeur";

	--Caverns of Time (Entrance)
	["Steward of Time <Keepers of Time>"] = "Régisseur du temps <Les Gardiens du temps>";
	["Alexston Chrome <Tavern of Time>"] = "Alexston Chrome <Gargotte du temps>";
	["Yarley <Armorer>"] = "Yarley <Armurier>";
	["Bortega <Reagents & Poison Supplies>"] = "Bortega <Composants & poisons>";
	["Galgrom <Provisioner>"] = "Galgrom <Approvisionneur>";
	["Alurmi <Keepers of Time Quartermaster>"] = "Alurmi <Intendant des gardiens du Temps>";
	["Zaladormu"] = "Zaladormu";
	["Soridormi <The Scale of Sands>"] = "Soridormi <La Balance des sables>";
	["Arazmodu <The Scale of Sands>"] = "Arazmodu <La Balance des sables>";
	["Andormu <Keepers of Time>"] = "Andormu <Les Gardiens du temps>";
	["Nozari <Keepers of Time>"] = "Nozari <Les Gardiens du temps>";

	--Dire Maul (Entrance)
	["Dire Pool"] = "Bassin redoutable";
	["Dire Maul Arena"] = "L'Etripoir";
	["Mushgog"] = "Mushgog";
	["Skarr the Unbreakable"] = "Bâlhafr l'Invaincu";
	["The Razza"] = "La Razza";
	["Elder Mistwalker"] = "Ancienne Marche-brume";

	--Gnomeregan (Entrance)
	["Transpolyporter"] = "Portail de multitéléportation";
	["Sprok <Away Team>"] = "Sproque <Equipe envoyée>";
	["Matrix Punchograph 3005-A"] = "Matrice d'Encodage 3005-A";
	["Namdo Bizzfizzle <Engineering Supplies>"] = "Namdo Ventaperte <Fournitures d'ingénieur>";
	["Techbot"] = "Techbot";

	-- Hellfire Citadel (Entrance)
	["Steps and path to the Blood Furnace"] = "Steps and path to the Blood Furnace"; -- Need translation
	["Path to the Hellfire Ramparts and Shattered Halls"] = "Path to the Hellfire Ramparts and Shattered Halls"; -- Need translation
	["Meeting Stone of Magtheridon's Lair"] = "Meeting Stone of Magtheridon's Lair"; -- Need translation
	["Meeting Stone of Hellfire Citadel"] = "Meeting Stone of Hellfire Citadel"; -- Need translation

	--Karazhan (Entrance)
	["Archmage Leryda"] = "Archimage Leryda";
	["Apprentice Darius"] = "Apprenti Darius";
	["Archmage Alturus"] = "Archimage Alturus";
	["Stairs to Underground Pond"] = "Escalier vers le bassin souterrain";
	["Stairs to Underground Well"] = "Escalier vers le puits souterrain";
	["Charred Bone Fragment"] = "Fragment d'os carbonisé";

	--Maraudon (Entrance)
	["The Nameless Prophet"] = "Le Prophète sans nom";
	["Kolk <The First Kahn>"] = "Kolk <Le premier Khan>";
	["Gelk <The Second Kahn>"] = "Gelk <Le deuxième Kahn>";
	["Magra <The Third Kahn>"] = "Magra <Le troisième Kahn>";
	["Cavindra"] = "Cavindra";

	--Scarlet Monastery (Entrance)
	--Nothing to translate!

	--The Deadmines (Entrance)
	["Marisa du'Paige"] = "Marisa du'Paige";
	["Brainwashed Noble"] = "Noble manipulé";
	["Foreman Thistlenettle"] = "Contremaître Crispechardon";

	--Sunken Temple (Entrance)
	["Jade"] = "Jade";
	["Kazkaz the Unholy"] = "Kazkaz l'Impie";
	["Zekkis"] = "Zekkis";
	["Veyzhak the Cannibal"] = "Veyzhak le Cannibale";

	--Uldaman (Entrance)
	["Hammertoe Grez"] = "Martèlorteil Grez";
	["Magregan Deepshadow"] = "Magregan Fondombre";
	["Tablet of Ryun'Eh"] = "Tablette de Ryun'eh";
	["Krom Stoutarm's Chest"] = "Trésor de Krom Rudebras";
	["Garrett Family Chest"] = "Trésor de la famille Garrett";
	["Digmaster Shovelphlange"] = "Maître des fouilles Pellaphlange";

	--Wailing Caverns (Entrance)
	["Mad Magglish"] = "Magglish le Dingue";
	["Trigore the Lasher"] = "Trigore le Flagelleur";
	["Boahn <Druid of the Fang>"] = "Boahn <Druide du Croc>";
	["Above the Entrance:"] = "Au-dessus de l'entrée :";
	["Ebru <Disciple of Naralex>"] = "Ebru <Disciple de Naralex>";
	["Nalpak <Disciple of Naralex>"] = "Nalpak <Disciple de Naralex>";
	["Kalldan Felmoon <Specialist Leatherworking Supplies>"] = "Kalldan Gangrelune <Fournitures de travailleur du cuir spécialiste>";
	["Waldor <Leatherworking Trainer>"] = "Waldor <Maître des travailleurs du cuir>";

--************************************************
-- Kalimdor Instances (Classic)
--************************************************

	--Blackfathom Deeps
	["Ghamoo-ra"] = "Ghamoo-ra";
	["Lorgalis Manuscript"] = "Manuscrit de Lorgalis";
	["Lady Sarevess"] = "Dame Sarevess";
	["Argent Guard Thaelrid <The Argent Dawn>"] = "Garde d’argent Thaelrid <L'Aube d'argent>";
	["Gelihast"] = "Gelihast";
	["Shrine of Gelihast"] = "Autel de Gelihast";
	["Lorgus Jett"] = "Lorgus Jett";
	["Fathom Stone"] = "Noyau de la Brasse";
	["Baron Aquanis"] = "Baron Aquanis";
	["Twilight Lord Kelris"] = "Seigneur du crépuscule Kelris";
	["Old Serra'kis"] = "Vieux Serra'kis";
	["Aku'mai"] = "Aku'mai";
	["Morridune"] = "Morridune";
	["Altar of the Deeps"] = "Autel des profondeurs";

	--Dire Maul (East)
	["Pusillin"] = "Pusillin";
	["Zevrim Thornhoof"] = "Zevrim Sabot-de-ronce";
	["Hydrospawn"] = "Hydrogénos";
	["Lethtendris"] = "Lethtendris";
	["Pimgib"] = "Pimgib";
	["Old Ironbark"] = "Vieil Ecorcefer";
	["Alzzin the Wildshaper"] = "Alzzin le modeleur";
	["Isalien"] = "Isalien";

	--Dire Maul (North)
	["Crescent Key"] = "Clé en croissant";--omitted from Dire Maul (West)
	--"Library" = "Bibliothèque"; omitted from here and DM West because of SM: "Library" duplicate
	["Guard Mol'dar"] = "Garde Mol'dar";
	["Stomper Kreeg <The Drunk>"] = "Kreeg le Marteleur <L'ivrogne>";
	["Guard Fengus"] = "Garde Fengus";
	["Knot Thimblejack"] = "Noué Dédodevie";
	["Guard Slip'kik"] = "Garde Slip'kik";
	["Captain Kromcrush"] = "Capitaine Kromcrush";
	["King Gordok"] = "Roi Gordok";
	["Cho'Rush the Observer"] = "Cho'Rush l'Observateur";

	--Dire Maul (West)
	["J'eevee's Jar"] = "Bocal de J'eevee";
	["Pylons"] = "Pylônes";
	["Shen'dralar Ancient"] = "Ancienne de Shen'Dralar";
	["Tendris Warpwood"] = "Tendris Crochebois";
	["Ancient Equine Spirit"] = "Ancien esprit équin";
	["Illyanna Ravenoak"] = "Illyanna Corvichêne";
	["Ferra"] = "Ferra";
	["Magister Kalendris"] = "Magistère Kalendris";
	["Tsu'zee"] = "Tsu'zee";
	["Immol'thar"] = "Immol'thar";
	["Lord Hel'nurath"] = "Seigneur Hel'nurath";
	["Prince Tortheldrin"] = "Prince Tortheldrin";
	["Falrin Treeshaper"] = "Falrin Sculpteflore";
	["Lorekeeper Lydros"] = "Gardien du savoir Lydros";
	["Lorekeeper Javon"] = "Gardien du savoir Javon";
	["Lorekeeper Kildrath"] = "Gardien du savoir Kildrath";
	["Lorekeeper Mykos"] = "Gardienne du savoir Mykos";
	["Shen'dralar Provisioner"] = "Approvisionneur Shen'dralar";
	["Skeletal Remains of Kariel Winthalus"] = "Restes squelettiques de Kariel Winthalus";

	--Maraudon	
	["Scepter of Celebras"] = "Sceptre de Celebras";
	["Veng <The Fifth Khan>"] = "Veng <Le cinquième Kahn>";
	["Noxxion"] = "Noxcion";
	["Razorlash"] = "Tranchefouet";
	["Maraudos <The Fourth Khan>"] = "Maraudos <Le quatrième Kahn>";
	["Lord Vyletongue"] = "Seigneur Vylelangue";
	["Meshlok the Harvester"] = "Meshlok le Moissonneur";
	["Celebras the Cursed"] = "Celebras le Maudit";
	["Landslide"] = "Glissement de terrain";
	["Tinkerer Gizlock"] = "Bricoleur Kadenaz";
	["Rotgrip"] = "Grippe-charogne";
	["Princess Theradras"] = "Princesse Theradras";
	["Elder Splitrock"] = "Ancien Pierre-fendue";

	--Ragefire Chasm
	["Maur Grimtotem"] = "Maur Totem-sinistre";
	["Oggleflint <Ragefire Chieftain>"] = "Lorgnesilex <Chef Ragefeu>";
	["Taragaman the Hungerer"] = "Taragaman l'Affameur";
	["Jergosh the Invoker"] = "Jergosh l'Invocateur";
	["Zelemar the Wrathful"] = "Zelemar le Courroucé";
	["Bazzalan"] = "Bazzalan";

	--Razorfen Downs
	["Tuten'kash"] = "Tuten'kash";
	["Henry Stern"] = "Henry Stern";
	["Belnistrasz"] = "Belnistrasz";
	["Sah'rhee"] = "Sah'rhee";
	["Mordresh Fire Eye"] = "Mordresh Oeil-de-feu";
	["Glutton"] = "Glouton";
	["Ragglesnout"] = "Ragglesnout";
	["Amnennar the Coldbringer"] = "Amnennar le Porte-froid";
	["Plaguemaw the Rotting"] = "Pestegueule le Pourrissant";

	--Razorfen Kraul
	["Roogug"] = "Roogug";
	["Aggem Thorncurse <Death's Head Prophet>"] = "Aggem Malépine <Prophète de la Tête de mort>";
	["Death Speaker Jargba <Death's Head Captain>"] = "Nécrorateur Jargba <Capitaine des Têtes de mort>";
	["Overlord Ramtusk"] = "Seigneur Brusquebroche";
	["Razorfen Spearhide"] = "Lanceur de Tranchebauge";
	["Agathelos the Raging"] = "Agathelos le Déchaîné";
	["Blind Hunter"] = "Chasseur aveugle";
	["Charlga Razorflank <The Crone>"] = "Charlga Trancheflanc <La mégère>";
	["Willix the Importer"] = "Willix l’Importateur";
	["Heralath Fallowbrook"] = "Heralath Ruissefriche";
	["Earthcaller Halmgar"] = "Implorateur de la terre Halmgar";

	--Ruins of Ahn'Qiraj
	["Cenarion Circle"] = "Cercle cénarien";
	["Kurinnaxx"] = "Kurinnaxx";
	["Lieutenant General Andorov"] = "Général de division Andorov";
	["Four Kaldorei Elites"] = "Quatre Elite kaldorei";
	["General Rajaxx"] = "Général Rajaxx";
	["Captain Qeez"] = "Capitaine Qeez";
	["Captain Tuubid"] = "Capitaine Tuubid";
	["Captain Drenn"] = "Capitaine Drenn";
	["Captain Xurrem"] = "Capitaine Xurrem";
	["Major Yeggeth"] = "Major Yeggeth";
	["Major Pakkon"] = "Major Parron";
	["Colonel Zerran"] = "Colonel Zerran";
	["Moam"] = "Moam";
	["Buru the Gorger"] = "Buru Grandgosier";
	["Ayamiss the Hunter"] = "Ayamiss le Chasseur";
	["Ossirian the Unscarred"] = "Ossirian l'Intouché";
	["Safe Room"] = "Pièce sûre";

	--Temple of Ahn'Qiraj
	["Brood of Nozdormu"] = "Progéniture de Nozdormu";
	["The Prophet Skeram"] = "Le Prophète Skeram";
	["The Bug Family"] = "La famille insecte";
	["Vem"] = "Vem";
	["Lord Kri"] = "Seigneur Kri";
	["Princess Yauj"] = "Princesse Yauj";
	["Battleguard Sartura"] = "Garde de guerre Sartura";
	["Fankriss the Unyielding"] = "Fankriss l'Inflexible";
	["Viscidus"] = "Viscidus";
	["Princess Huhuran"] = "Princesse Huhuran";
	["Twin Emperors"] = "Les Empereurs jumeaux";
	["Emperor Vek'lor"] = "Empereur Vek'lor";
	["Emperor Vek'nilash"] = "Empereur Vek'nilash";
	["Ouro"] = "Ouro";
	["Eye of C'Thun"] = "Œil de C'Thun";
	["C'Thun"] = "C'Thun";
	["Andorgos <Brood of Malygos>"] = "Andorgos <Rejeton de Malygos>";
	["Vethsera <Brood of Ysera>"] = "Vethsera <Rejeton d'Ysera>";
	["Kandrostrasz <Brood of Alexstrasza>"] = "Kandrostrasz <Rejeton d'Alexstrasza>";
	["Arygos"] = "Arygos";
	["Caelestrasz"] = "Caelestrasz";
	["Merithra of the Dream"] = "Merithra du Rêve";

	--Wailing Caverns
	["Disciple of Naralex"] = "Disciple de Naralex";
	["Lord Cobrahn <Fanglord>"] = "Seigneur Cobrahn <Seigneur-Croc>";
	["Lady Anacondra <Fanglord>"] = "Dame Anacondra <Seigneur-Croc>";
	["Kresh"] = "Kresh";
	["Lord Pythas <Fanglord>"] = "Seigneur Pythas <Seigneur-Croc>";
	["Skum"] = "Skum";
	["Lord Serpentis <Fanglord>"] = "Seigneur Serpentis <Seigneur-Croc>";
	["Verdan the Everliving"] = "Verdan l'Immortel";
	["Mutanus the Devourer"] = "Mutanus le Dévoreur";
	["Naralex"] = "Naralex";
	["Deviate Faerie Dragon"] = "Dragon féerique déviant";

	--Zul'Farrak
	["Antu'sul <Overseer of Sul>"] = "Antu'sul <Surveillant de Sul>";
	["Theka the Martyr"] = "Theka le Martyr";
	["Witch Doctor Zum'rah"] = "Sorcier-docteur Zum'rah";
	["Zul'Farrak Dead Hero"] = "Héros mort de Zul'Farrak";
	["Nekrum Gutchewer"] = "Nekrum Mâchentrailles";
	["Shadowpriest Sezz'ziz"] = "Prêtre des ombres Sezz'ziz";
	["Dustwraith"] = "Ame en peine poudreuse";
	["Sergeant Bly"] = "Sergent Bly";
	["Weegli Blastfuse"] = "Gigoto Explomèche";
	["Murta Grimgut"] = "Murta Mornentraille";
	["Raven"] = "Corbeau";
	["Oro Eyegouge"] = "Oro Crève-oeil";
	["Sandfury Executioner"] = "Bourreau Furie-des-sables";
	["Hydromancer Velratha"] = "Hydromancienne Velratha";
	["Gahz'rilla"] = "Gahz'rilla";
	["Elder Wildmane"] = "Ancienne Crin-sauvage";
	["Chief Ukorz Sandscalp"] = "Chef Ukorz Scalpessable";
	["Ruuzlu"] = "Ruuzlu";
	["Zerillis"] = "Zerillis";
	["Sandarr Dunereaver"] = "Sandarr Ravadune";

--****************************
-- Eastern Kingdoms Instances (Classic)
--****************************

	--Blackrock Depths
	["Shadowforge Key"] = "Clé ombreforge";
	["Prison Cell Key"] = "Clé de la prison";
	["Jail Break!"] = "Evasion !";
	["Banner of Provocation"] = "Bannière de provocation";
	["Lord Roccor"] = "Seigneur Roccor";
	["Kharan Mighthammer"] = "Kharan Force-martel";
	["Commander Gor'shak <Kargath Expeditionary Force>"] = "Commandant Gor'shak <Corps expéditionnaire de Kargath>";
	["Marshal Windsor"] = "Maréchal Windsor";
	["High Interrogator Gerstahn <Twilight's Hammer Interrogator>"] = "Grand Interrogateur Gerstahn <Inquisiteur du Marteau du crépuscule>";
	["Ring of Law"] = "Cercle de la loi";
	["Anub'shiah"] = "Anub'shiah";
	["Eviscerator"] = "Eviscérateur";
	["Gorosh the Dervish"] = "Gorosh le Derviche";
	["Grizzle"] = "Grison";
	["Hedrum the Creeper"] = "Hedrum le Rampant";
	["Ok'thor the Breaker"] = "Ok'thor le Briseur";
	["Theldren"] = "Theldren";
	["Lefty"] = "Le Gaucher";
	["Malgen Longspear"] = "Malgen Long-épieu";
	["Gnashjaw <Malgen Longspear's Pet>"] = "Grince-mâchoires <Familier de Malgen Longspear>";
	["Rotfang"] = "Crocs-pourris";
	["Va'jashni"] = "Va'jashni";
	["Houndmaster Grebmar"] = "Maître-chien Grebmar";
	["Elder Morndeep"] = "Ancien Gouffre-du-matin";
	["High Justice Grimstone"] = "Juge Supérieur Mornepierre";
	["Monument of Franclorn Forgewright"] = "Statue de Franclorn Le Forgebusier";
	["Pyromancer Loregrain"] = "Pyromancien Blé-du-savoir";
	["The Vault"] = "La Chambre forte";
	["Warder Stilgiss"] = "Gardien Stilgiss";
	["Verek"] = "Verek";
	["Watchman Doomgrip"] = "Sentinelle Ruinepoigne";
	["Fineous Darkvire <Chief Architect>"] = "Fineous Sombrevire <Chef architecte>";
	["The Black Anvil"] = "L'Enclume noire";
	["Lord Incendius"] = "Seigneur Incendius";
	["Bael'Gar"] = "Bael'Gar";
	["Shadowforge Lock"] = "Le verrou d'Ombreforge";
	["General Angerforge"] = "Général Forgehargne";
	["Golem Lord Argelmach"] = "Seigneur golem Argelmach";
	["Field Repair Bot 74A"] = "Robot réparateur 74A";
	["The Grim Guzzler"] = "Le sinistre dévoreur";
	["Hurley Blackbreath"] = "Hurley Soufflenoir";
	["Lokhtos Darkbargainer <The Thorium Brotherhood>"] = "Lokhtos Sombrescompte <La Confrérie du thorium>";
	["Mistress Nagmara"] = "Gouvernante Nagmara";
	["Phalanx"] = "Phalange";
	["Plugger Spazzring"] = "Lanfiche Brouillecircuit";
	["Private Rocknot"] = "Soldat Rochenoeud";
	["Ribbly Screwspigot"] = "Ribbly Fermevanne";
	["Coren Direbrew"] = "Coren Navrebière";
	["Griz Gutshank <Arena Vendor>"] = "Griz Cannebide <Vendeur de l'arène>";
	["Ambassador Flamelash"] = "Ambassadeur Cinglefouet";
	["Panzor the Invincible"] = "Panzor l'Invincible";
	["Summoner's Tomb"] = "La tombe des invocateurs";
	["The Lyceum"] = "Le Lyceum";
	["Magmus"] = "Magmus";
	["Emperor Dagran Thaurissan"] = "Empereur Dagran Thaurissan";
	["Princess Moira Bronzebeard <Princess of Ironforge>"] = "Princesse Moira Barbe-de-bronze <Princesse de Forgefer>";
	["High Priestess of Thaurissan"] = "Grande prêtresse de Thaurissan";
	["The Black Forge"] = "La Forge noire";
	["Core Fragment"] = "Fragment du Magma";
	["Overmaster Pyron"] = "Grand seigneur Pyron";

	--Blackrock Spire (Lower)
	["Vaelan"] = "Vaelan";
	["Warosh <The Cursed>"] = "Warosh <Les maudits>";
	["Elder Stonefort"] = "Ancien Fort-de-pierre";
	["Roughshod Pike"] = "Pique de fortune";
	["Spirestone Butcher"] = "Boucher Pierre-du-pic";
	["Highlord Omokk"] = "Généralissime Omokk";
	["Spirestone Battle Lord"] = "Seigneur de bataille Pierre-du-pic";
	["Spirestone Lord Magus"] = "Seigneur magus Pierre-du-pic";
	["Shadow Hunter Vosh'gajin"] = "Chasseresse des ombres Vosh'gajin";
	["Fifth Mosh'aru Tablet"] = "Cinquième tablette Mosh'aru";
	["Bijou"] = "Bijou";
	["War Master Voone"] = "Maître de guerre Voone";
	["Mor Grayhoof"] = "Mor Sabot-gris";
	["Sixth Mosh'aru Tablet"] = "Sixième tablette Mosh'aru";
	["Bijou's Belongings"] = "Affaires de Bijou";
	["Human Remains"] = "Restes humains";
	["Unfired Plate Gauntlets"] = "Gantelets en plaques inachevés";
	["Bannok Grimaxe <Firebrand Legion Champion>"] = "Bannok Hache-sinistre <Champion de la légion Brandefeu>";
	["Mother Smolderweb"] = "Matriarche Couveuse";
	["Crystal Fang"] = "Croc cristallin";
	["Urok's Tribute Pile"] = "Pile d'offrandes à Urok";
	["Urok Doomhowl"] = "Urok Hurleruine";
	["Quartermaster Zigris <Bloodaxe Legion>"] = "Intendant Zigris <Légion Hache-sanglante>";
	["Halycon"] = "Halycon";
	["Gizrul the Slavener"] = "Gizrul l'esclavagiste";
	["Ghok Bashguud <Bloodaxe Champion>"] = "Ghok Bounnebaffe <Champion des Hache-sanglante>";
	["Overlord Wyrmthalak"] = "Seigneur Wyrmthalak";
	["Burning Felguard"] = "Gangregarde ardent";

	--Blackrock Spire (Upper)
	["Pyroguard Emberseer"] = "Pyrogarde Prophète ardent";
	["Solakar Flamewreath"] = "Solakar Voluteflamme";
	["Father Flame"] = "Père des flammes";
	["Darkstone Tablet"] = "Tablette de Sombrepierre";
	["Doomrigger's Coffer"] = "Fermoir de Frèteruine";
	["Jed Runewatcher <Blackhand Legion>"] = "Jed Guette-runes <Légion Main-noire>";
	["Goraluk Anvilcrack <Blackhand Legion Armorsmith>"] = "Goraluk Brisenclume <Fabricant d'armures de la légion Main-noire>";
	["Warchief Rend Blackhand"] = "Chef de guerre Rend Main-noire";
	["Gyth <Rend Blackhand's Mount>"] = "Gyth <Monture de Rend Main-noire>";
	["Awbee"] = "Awbee";
	["The Beast"] = "La Bête";
	["Lord Valthalak"] = "Seigneur Valthalak";
	["Finkle Einhorn"] = "Finkle Einhorn";
	["General Drakkisath"] = "Général Drakkisath";
	["Drakkisath's Brand"] = "Marque de Drakkisath";

	--Blackwing Lair
	["Razorgore the Untamed"] = "Tranchetripe l'Indompté";
	["Vaelastrasz the Corrupt"] = "Vaelastrasz le Corrompu";
	["Broodlord Lashlayer"] = "Seigneur des couvées Lanistaire";
	["Firemaw"] = "Gueule-de-feu";
	["Draconic for Dummies (Chapter VII)"] = "Le draconique pour les nuls (Chapitre VII)";
	["Master Elemental Shaper Krixix"] = "Maître élémentaire Krixix le Sculpteur";
	["Ebonroc"] = "Rochébène";
	["Flamegor"] = "Flamegor";
	["Chromaggus"] = "Chromaggus";
	["Nefarian"] = "Nefarian";

	--Gnomeregan
	["Workshop Key"] = "Clé d'atelier";
	["Blastmaster Emi Shortfuse"] = "Maître-dynamiteur Emi Courtemèche";
	["Grubbis"] = "Grubbis";
	["Chomper"] = "Mâchouilleur";
	["Clean Room"] = "Zone propre";
	["Tink Sprocketwhistle <Engineering Supplies>"] = "Bricolo Sifflepignon <Fournitures d'ingénieur>";
	["The Sparklematic 5200"] = "Le Brille-o-Matic 5200";
	["Mail Box"] = "Boîte aux lettres";
	["Kernobee"] = "Kernobee";
	["Alarm-a-bomb 2600"] = "Alarme-bombe 2600";
	["Matrix Punchograph 3005-B"] = "Matrice d'Encodage 3005-B";
	["Viscous Fallout"] = "Retombée visqueuse";
	["Electrocutioner 6000"] = "Electrocuteur 6000";
	["Matrix Punchograph 3005-C"] = "Matrice d'Encodage 3005-C";
	["Crowd Pummeler 9-60"] = "Faucheur de foule 9-60";
	["Matrix Punchograph 3005-D"] = "Matrice d'Encodage 3005-D";
	["Dark Iron Ambassador"] = "Ambassadeur Sombrefer";
	["Mekgineer Thermaplugg"] = "Mekgénieur Thermojoncteur";

	--Molten Core
	["Hydraxian Waterlords"] = "Les Hydraxiens";
	["Lucifron"] = "Lucifron";
	["Magmadar"] = "Magmadar";
	["Gehennas"] = "Gehennas";
	["Garr"] = "Garr";
	["Shazzrah"] = "Shazzrah";
	["Baron Geddon"] = "Baron Geddon";
	["Golemagg the Incinerator"] = "Golemagg l'Incinérateur";
	["Sulfuron Harbinger"] = "Messager de Sulfuron";
	["Majordomo Executus"] = "Chambellan Executus";
	["Ragnaros"] = "Ragnaros";

	--Scholomance
	["Skeleton Key"] = "Clé squelette";
	["Viewing Room Key"] = "Clé de la Chambre des visions";
	["Viewing Room"] = "Chambre des visions";
	["Blood of Innocents"] = "Sang des innocents";
	["Divination Scryer"] = "Clairvoyant";
	["Blood Steward of Kirtonos"] = "Régisseuse sanglante de Kirtonos";
	["The Deed to Southshore"] = "Titre de propriété d'Austrivage";
	["Kirtonos the Herald"] = "Kirtonos le Héraut";
	["Jandice Barov"] = "Jandice Barov";
	["The Deed to Tarren Mill"] = "Titre de propriété de Moulin-de-Tarren";
	["Rattlegore"] = "Cliquettripes";
	["Death Knight Darkreaver"] = "Chevalier de la mort Ravassombre";
	["Marduk Blackpool"] = "Marduk Noirétang";
	["Vectus"] = "Vectus";
	["Ras Frostwhisper"] = "Ras Murmegivre";
	["The Deed to Brill"] = "Titre de propriété de Brill";
	["Kormok"] = "Kormok";
	["Instructor Malicia"] = "Instructeur Malicia";
	["Doctor Theolen Krastinov <The Butcher>"] = "Docteur Theolen Krastinov <Le Boucher>";
	["Lorekeeper Polkelt"] = "Gardien du savoir Polkelt";
	["The Ravenian"] = "Le Voracien";
	["Lord Alexei Barov"] = "Seigneur Alexei Barov";
	["The Deed to Caer Darrow"] = "Titre de propriété de Caer Darrow";
	["Lady Illucia Barov"] = "Dame Illucia Barov";
	["Darkmaster Gandling"] = "Sombre Maître Gandling";
	["Torch Lever"] = "Torche levier";
	["Secret Chest"] = "Vieux coffre au trésor";
	["Alchemy Lab"] = "Laboratoire d'alchimie";

	--Shadowfang Keep
	["Deathsworn Captain"] = "Capitaine Ligemort";
	["Rethilgore <The Cell Keeper>"] = "Rethiltripe <Le gardien de la cellule>";
	["Sorcerer Ashcrombe"] = "Ensorceleur Ashcrombe";
	["Deathstalker Adamant"] = "Nécrotraqueur Adamant";
	["Landen Stilwell"] = "Landen Morpuits";
	["Investigator Fezzen Brasstacks"] = " Enquêteur Fezzen Desfaits";
	["Deathstalker Vincent"] = "Nécrotraqueur Vincent";
	["Apothecary Trio"] = "Trio d'apothicaires";
	["Apothecary Hummel <Crown Chemical Co.>"] = "Apothicaire Hummel <Cie de Chimie La Royale>";
	["Apothecary Baxter <Crown Chemical Co.>"] = "Apothicaire Baxter <Cie de Chimie La Royale>";
	["Apothecary Frye <Crown Chemical Co.>"] = "Apothicaire Frye <Cie de Chimie La Royale>";
	["Fel Steed"] = "Palefroi corrompu";
	["Jordan's Hammer"] = "Marteau de Jordan";
	["Crate of Ingots"] = "Caisse de lingots";
	["Razorclaw the Butcher"] = "Tranchegriffe le Boucher";
	["Baron Silverlaine"] = "Baron d'Argelaine";
	["Commander Springvale"] = "Commandant Printeval";
	["Odo the Blindwatcher"] = "Odo l'Aveugle";
	["Fenrus the Devourer"] = "Fenrus le Dévoreur";
	["Arugal's Voidwalker"] = "Marcheur du Vide d’Arugal";
	["The Book of Ur"] = "Le Livre d'Ur";
	["Wolf Master Nandos"] = "Maître-loup Nandos";
	["Archmage Arugal"] = "Archimage Arugal";

	--SM: Armory
	["The Scarlet Key"] = "La Clé écarlate";
	["Herod <The Scarlet Champion>"] = "Hérode <Le champion écarlate>";

	--SM: Cathedral
	["High Inquisitor Fairbanks"] = "Grand Inquisiteur Fairbanks";
	["Scarlet Commander Mograine"] = "Commandant écarlate Mograine";
	["High Inquisitor Whitemane"] = "Grande inquisitrice Blanchetête";

	--SM: Graveyard
	["Interrogator Vishas"] = "Interrogateur Vishas";
	["Vorrel Sengutz"] = "Vorrel Sengutz";
	["Pumpkin Shrine"] = "Sanctuaire Citrouille";
	["Headless Horseman"] = "Cavalier sans tête";
	["Bloodmage Thalnos"] = "Mage de sang Thalnos";
	["Ironspine"] = "Echine-de-fer";
	["Azshir the Sleepless"] = "Azshir le Sans-sommeil";
	["Fallen Champion"] = "Champion déchu";

	--SM: Library
	["Houndmaster Loksey"] = "Maître-chien Loksey";
	["Arcanist Doan"] = "Arcaniste Doan";

	--Stratholme
	["The Scarlet Key"] = "La Clé écarlate";
	["Key to the City"] = "Clé de la ville";
	["Various Postbox Keys"] = "Clé des boîtes à lettres";
	["Living Side"] = "Coté Phalange";
	["Undead Side"] = "Coté Baron";
	["Skul"] = "Krân";
	["Stratholme Courier"] = "Messager de Stratholme";
	["Fras Siabi"] = "Fras Siabi";
	["Atiesh <Hand of Sargeras>"] = "Atiesh <Main de Sargeras>";
	["Hearthsinger Forresten"] = "Chanteloge Forrestin";
	["The Unforgiven"] = "Le Condamné";
	["Elder Farwhisper"] = "Ancien Murmeloin";
	["Timmy the Cruel"] = "Timmy le Cruel";
	["Malor the Zealous"] = "Malor le Zélé";
	["Malor's Strongbox"] = "Coffre de Malor";
	["Crimson Hammersmith"] = "Forgeur de marteaux cramoisi";
	["Cannon Master Willey"] = "Maître canonnier Willey";
	["Archivist Galford"] = "Archiviste Galford";
	["Grand Crusader Dathrohan"] = "Grand croisé Dathrohan";
	["Balnazzar"] = "Balnazzar";
	["Sothos"] = "Sothos";
	["Jarien"] = "Jarien";
	["Magistrate Barthilas"] = "Magistrat Barthilas";
	["Aurius"] = "Aurius";
	["Stonespine"] = "Echine-de-pierre";
	["Baroness Anastari"] = "Baronne Anastari";
	["Black Guard Swordsmith"] = "Fabricant d'épées de la Garde noire";
	["Nerub'enkan"] = "Nerub'enkan";
	["Maleki the Pallid"] = "Maleki le Blafard";
	["Ramstein the Gorger"] = "Ramstein Grandgosier";
	["Baron Rivendare"] = "Baron Vaillefendre";
	["Ysida Harmon"] = "Ysida Harmon";
	["Crusaders' Square Postbox"] = "Boîte de la place des Croisés";
	["Market Row Postbox"] = "Boîte de l'allée du Marché";
	["Festival Lane Postbox"] = "Boîte de l'allée du Festival";
	["Elders' Square Postbox"] = "Boîte de la place des Anciens";
	["King's Square Postbox"] = "Boîte de la place du Roi";
	["Fras Siabi's Postbox"] = "Boîte de Fras Siabi";
	["3rd Box Opened"] = "3ème boîte ouverte";
	["Postmaster Malown"] = "Postier Malown";

	--The Deadmines
	["Rhahk'Zor <The Foreman>"] = "Rhahk'Zor <Le contremaître>";
	["Miner Johnson"] = "Mineur Johnson";
	["Sneed <Lumbermaster>"] = "Sneed <Bûcheron>";
	["Sneed's Shredder <Lumbermaster>"] = "Déchiqueteur de Sneed <Bûcheron>";
	["Gilnid <The Smelter>"] = "Gilnid <Le fondeur>";
	["Defias Gunpowder"] = "Poudre à canon de défias";
	["Captain Greenskin"] = "Capitaine Vertepeau";
	["Edwin VanCleef <Defias Kingpin>"] = "Edwin VanCleef <Caïd défias>";
	["Mr. Smite <The Ship's First Mate>"] = "M. Châtiment <Le premier officier du navire>";
	["Cookie <The Ship's Cook>"] = "Macaron <Le cuistot du navire>";

	--The Stockade
	["Targorr the Dread"] = "Targorr le Terrifiant";
	["Kam Deepfury"] = "Kam Furie-du-fond";
	["Hamhock"] = "Hamhock";
	["Bazil Thredd"] = "Bazil Thredd";
	["Dextren Ward"] = "Dextren Ward";
	["Bruegal Ironknuckle"] = "Bruegal Poing-de-fer";

	--The Sunken Temple
	["The Temple of Atal'Hakkar"] = "Le temple d'Atal'Hakkar";
	["Yeh'kinya's Scroll"] = "Parchemin de Yeh'kinya";
	["Atal'ai Defenders"] = "Défenseurs Atal'ai";
	["Gasher"] = "Balafreur";
	["Loro"] = "Loro";
	["Hukku"] = "Hukku";
	["Zolo"] = "Zolo";
	["Mijan"] = "Mijan";
	["Zul'Lor"] = "Zul'Lor";
	["Altar of Hakkar"] = "Autel d'Hakkar";
	["Atal'alarion <Guardian of the Idol>"] = "Atal'alarion <Gardien de l'idole>";
	["Dreamscythe"] = "Fauche-rêve";
	["Weaver"] = "Tisserand";
	["Avatar of Hakkar"] = "Avatar d'Hakkar";
	["Jammal'an the Prophet"] = "Jammal'an le prophète";
	["Ogom the Wretched"] = "Ogom le Misérable";
	["Morphaz"] = "Morphaz";
	["Hazzas"] = "Hazzas";
	["Shade of Eranikus"] = "Ombre d'Eranikus";
	["Essence Font"] = "Réceptacle d'essence";
	["Spawn of Hakkar"] = "Rejeton d'Hakkar";
	["Elder Starsong"] = "Ancienne Chantétoile";
	["Statue Activation Order"] = "Ordre d'activation des statues";

	--Uldaman
	["Staff of Prehistoria"] = "Bâton de la préhistoire";
	["Baelog"] = "Baelog";
	["Eric \"The Swift\""] = "Eric \"l'Agile\"";
	["Olaf"] = "Olaf";
	["Baelog's Chest"] = "Coffre de Baelog";
	["Conspicuous Urn"] = "Urne ostentatoire";
	["Remains of a Paladin"] = "Restes d'un paladin";
	["Revelosh"] = "Revelosh";
	["Ironaya"] = "Ironaya";
	["Obsidian Sentinel"] = "Sentinelle d'obsidienne";
	["Annora <Enchanting Trainer>"] = "Annora <Maître des enchanteurs>";
	["Ancient Stone Keeper"] = "Ancien gardien des pierres";
	["Galgann Firehammer"] = "Galgann Martel-de-feu";
	["Tablet of Will"] = "Tablette de Volonté";
	["Shadowforge Cache"] = "Cachette d'Ombreforge";
	["Grimlok <Stonevault Chieftain>"] = "Grimlok <Chef des Cavepierres>";
	["Archaedas <Ancient Stone Watcher>"] = "Archaedas <Ancien gardien des pierres>";
	["The Discs of Norgannon"] = "Les Disques de Norgannon";
	["Ancient Treasure"] = "Trésor Antique";

	--Zul'Gurub
	["Zandalar Tribe"] = "Tribu Zandalar";
	["Mudskunk Lure"] = "Appât au Puant de vase";
	["Gurubashi Mojo Madness"] = "Folie mojo des Gurubashi";
	["High Priestess Jeklik"] = "Grande prêtresse Jeklik";
	["High Priest Venoxis"] = "Grand prêtre Venoxis";
	["Zanza the Restless"] = "Zanza le Sans-Repos";
	["High Priestess Mar'li"] = "Grande prêtresse Mar'li";
	["Bloodlord Mandokir"] = "Seigneur sanglant Mandokir";
	["Ohgan"] = "Ohgan";
	["Edge of Madness"] = "Frontières de la folie";
	["Gri'lek"] = "Gri'lek";
	["Hazza'rah"] = "Hazza'rah";
	["Renataki"] = "Renataki";
	["Wushoolay"] = "Wushoolay";
	["Gahz'ranka"] = "Gahz'ranka";
	["High Priest Thekal"] = "Grand prêtre Thekal";
	["Zealot Zath"] = "Zélote Zath";
	["Zealot Lor'Khan"] = "Zélote Lor'Khan";
	["High Priestess Arlokk"] = "Grande prêtresse Arlokk";
	["Jin'do the Hexxer"] = "Jin'do le Maléficieur";
	["Hakkar"] = "Hakkar";
	["Muddy Churning Waters"] = "Eaux troubles et agitées";

--*******************
-- Burning Crusade Instances
--*******************

	--Auch: Auchenai Crypts
	["Lower City"] = "Ville basse"; --omitted from other Auch
	["Shirrak the Dead Watcher"] = "Shirrak le Veillemort";
	["Exarch Maladaar"] = "Exarque Maladaar";
	["Avatar of the Martyred"] = "Avatar des martyrs";
	["D'ore"] = "D'ore";

	--Auch: Mana-Tombs
	["The Consortium"] = "Le Consortium";
	["Auchenai Key"] = "Clé Auchenaï"; --omitted from other Auch
	["The Eye of Haramad"] = "L'Oeil d'Haramad";
	["Pandemonius"] = "Pandemonius";
	["Shadow Lord Xiraxis"] = "Seigneur des ténèbres Xiraxis";
	["Ambassador Pax'ivi"] = "Ambassadeur Pax'ivi";
	["Tavarok"] = "Tavarok";
	["Cryo-Engineer Sha'heen"] = "Cryo-Ingénieur Sha'heen";
	["Ethereal Transporter Control Panel"] = "Panneau de contrôle du transporteur étherien";
	["Nexus-Prince Shaffar"] = "Prince-nexus Shaffar";
	["Yor <Void Hound of Shaffar>"] = "Yor <Molosse du Vide de Shaffar>";

	--Auch: Sethekk Halls
	["Essence-Infused Moonstone"] = "Pierre de lune imprégnée d'essence";
	["Darkweaver Syth"] = "Tisseur d'ombre Syth";
	["Lakka"] = "Lakka";
	["The Saga of Terokk"] = "La Saga de Terokk";
	["Anzu"] = "Anzu";
	["Talon King Ikiss"] = "Roi-serre Ikiss";

	--Auch: Shadow Labyrinth
	["Shadow Labyrinth Key"] = "Clé du labyrinthe des ombres";
	["Spy To'gun"] = "Espion To'gun";
	["Ambassador Hellmaw"] = "Ambassadeur Gueule-d'enfer";
	["Blackheart the Inciter"] = "Cœur-noir le Séditieux";
	["Grandmaster Vorpil"] = "Grand Maître Vorpil";
	["The Codex of Blood"] = "Codex de sang";
	["Murmur"] = "Marmon";
	["First Fragment Guardian"] = "Gardien du premier fragment";

	--Black Temple (Start)
	["Ashtongue Deathsworn"] = "Ligemort Cendrelangue"; --omitted from other BT
	["Towards Reliquary of Souls"] = "Vers Reliquaire des âmes";
	["Towards Teron Gorefiend"] = "Vers Teron Fielsang";
	["Towards Illidan Stormrage"] = "Vers Illidan Hurlorage";
	["Spirit of Olum"] = "Esprit d'Olum";
	["High Warlord Naj'entus"] = "Grand seigneur de guerre Naj'entus";
	["Supremus"] = "Supremus";
	["Shade of Akama"] = "Ombre d'Akama";
	["Spirit of Udalo"] = "Esprit d'Udalo";
	["Aluyen <Reagents>"] = "Aluyen <Composants>";
	["Okuno <Ashtongue Deathsworn Quartermaster>"] = "Okuno <Intendant des ligemorts cendrelangue>";
	["Seer Kanai"] = "Voyant Kanai";

	--Black Temple (Basement)
	["Gurtogg Bloodboil"] = "Gurtogg Fièvresang";
	["Reliquary of Souls"] = "Reliquaire des âmes";
	["Essence of Suffering"] = "Essence de la souffrance";
	["Essence of Desire"] = "Essence du désir";
	["Essence of Anger"] = "Essence de la colère";
	["Teron Gorefiend"] = "Teron Fielsang";

	--Black Temple (Top)
	["Mother Shahraz"] = "Mère Shahraz";
	["The Illidari Council"] = "Le conseil Illidari";
	["Lady Malande"] = "Dame Malande";
	["Gathios the Shatterer"] = "Gathios le Briseur";
	["High Nethermancer Zerevor"] = "Grand néantomancien Zerevor";
	["Veras Darkshadow"] = "Veras Ombrenoir";
	["Illidan Stormrage <The Betrayer>"] = "Illidan Hurlorage <Le Traître>";

	--CR: Serpentshrine Cavern
	["Hydross the Unstable <Duke of Currents>"] = "Hydross l'Instable <Duc des courants>";
	["The Lurker Below"] = "Le Rôdeur d'En-bas";
	["Leotheras the Blind"] = "Leotheras l'Aveugle";
	["Fathom-Lord Karathress"] = "Seigneur des fonds Karathress";
	["Seer Olum"] = "Voyant Olum";
	["Morogrim Tidewalker"] = "Morogrim Marcheur-des-flots";
	["Lady Vashj <Coilfang Matron>"] = "Dame Vashj <Matrone de Glissecroc>";

	--CFR: The Slave Pens
	["Cenarion Expedition"] = "Expédition cénarienne"; --omitted from other CR
	["Reservoir Key"] = "Clé du réservoir"; --omitted from other CR
	["Mennu the Betrayer"] = "Mennu le Traître";
	["Weeder Greenthumb"] = "Weeder la Main-verte";
	["Skar'this the Heretic"] = "Skar'this l'Hérétique";
	["Rokmar the Crackler"] = "Rokmar le Crépitant";
	["Naturalist Bite"] = "Naturaliste Morsure";
	["Quagmirran"] = "Bourbierreux";
	["Ahune <The Frost Lord>"] = "Ahune <Le seigneur du Givre>";

	--CFR: The Steamvault
	["Hydromancer Thespia"] = "Hydromancienne Thespia";
	["Main Chambers Access Panel"] = "Panneau d'accès de la salle principale";
	["Second Fragment Guardian"] = "Gardien du second fragment";
	["Mekgineer Steamrigger"] = "Mékgénieur Montevapeur";
	["Warlord Kalithresh"] = "Seigneur de guerre Kalithresh";
	
	--CFR: The Underbog
	["Hungarfen"] = "Hungarfen";
	["The Underspore"] = "Palme de sporielle";
	["Ghaz'an"] = "Ghaz'an";
	["Earthbinder Rayge"] = "Lieur de terre Rayge";
	["Swamplord Musel'ek"] = "Seigneur des marais Musel'ek";
	["Claw <Swamplord Musel'ek's Pet>"] = "Griffe <Familier du seigneur des marais Musel'ek>";
	["The Black Stalker"] = "La Traqueuse noire";

	--CoT: The Black Morass
	["Opening of the Dark Portal"] = "Ouverture de la Porte des Ténèbres";
	["Keepers of Time"] = "Gardiens du Temps";
	["Key of Time"] = "Clé du Temps";
	["Sa'at <Keepers of Time>"] = "Sa'at <Les Gardiens du temps>";
	["Chrono Lord Deja"] = "Chronoseigneur Déjà";
	["Temporus"] = "Temporus";
	["Aeonus"] = "Aeonus";
	["The Dark Portal"] = "La Porte des Ténèbres";
	["Medivh"] = "Medivh";

	--CoT: Hyjal Summit
	["Battle for Mount Hyjal"] = "Bataille pour le Mont Hyjal";
	["The Scale of the Sands"] = "La Balance des sables";
	["Alliance Base"] = "Base de l'Alliance";
	["Lady Jaina Proudmoore"] = "Dame Jaina Portvaillant";
	["Horde Encampment"] = "Campement de la Horde";
	["Thrall <Warchief>"] = "Thrall <Chef de guerre>";
	["Night Elf Village"] = "Village des Elfes de la Nuit";
	["Tyrande Whisperwind <High Priestess of Elune>"] = "Tyrande Murmevent <Grande prêtresse d'Elune>";
	["Rage Winterchill"] = "Rage Froidhiver";
	["Anetheron"] = "Anetheron";
	["Kaz'rogal"] = "Kaz'rogal";
	["Azgalor"] = "Azgalor";
	["Archimonde"] = "Archimonde";
	["Indormi <Keeper of Ancient Gem Lore>"] = "Indormi <Gardienne du savoir ancien des gemmes>";
	["Tydormu <Keeper of Lost Artifacts>"] = "Tydormu <Gardien des artefacts perdus>";

	--CoT: Old Hillsbrad Foothills
	["Escape from Durnholde Keep"] = "L'évasion du Fort-de-Durn";
	["Erozion"] = "Erozion";
	["Brazen"] = "Airain";
	["Landing Spot"] = "Zone d'atterrissage";
	["Lieutenant Drake"] = "Lieutenant Drake";
	["Thrall"] = "Thrall";
	["Captain Skarloc"] = "Capitaine Skarloc";
	["Epoch Hunter"] = "Chasseur d'époques";
	["Taretha"] = "Taretha";
	["Jonathan Revah"] = "Jonathan Revah";
	["Jerry Carter"] = "Jerry Carter";
	["Traveling"] = "Itinérants";
	["Thomas Yance <Travelling Salesman>"] = "Thomas Yance <Marchand itinérant>";
	["Aged Dalaran Wizard"] = "Sorcier de Dalaran âgé";
	["Kel'Thuzad <The Kirin Tor>"] = "Kel'Thuzad <Le Kirin Tor>";
	["Helcular"] = "Helcular";
	["Farmer Kent"] = "Kent le fermier";
	["Sally Whitemane"] = "Sally Blanchetête";
	["Renault Mograine"] = "Renault Mograine";
	["Little Jimmy Vishas"] = "Petit Jimmy Vishas";
	["Herod the Bully"] = "Hérode le Malmeneur";
	["Nat Pagle"] = "Nat Pagle";
	["Hal McAllister"] = "Hal McAllister";
	["Zixil <Aspiring Merchant>"] = "Zixil <Marchand en herbe>";
	["Overwatch Mark 0 <Protector>"] = "Vigilant modèle 0 <Protecteur>";
	["Southshore Inn"] = "Auberge d'Austrivage";
	["Captain Edward Hanes"] = "Capitaine Edward Hanes";
	["Captain Sanders"] = "Capitaine Sanders";
	["Commander Mograine"] = "Commandant Mograine";
	["Isillien"] = "Isillien";
	["Abbendis"] = "Abbendis";
	["Fairbanks"] = "Fairbanks";
	["Tirion Fordring"] = "Tirion Fordring";
	["Arcanist Doan"] = "Arcaniste Doan";
	["Taelan"] = "Taelan";
	["Barkeep Kelly <Bartender>"] = "Kelly le serveur <Tavernier>";
	["Frances Lin <Barmaid>"] = "Frances Lin <Serveuse>";
	["Chef Jessen <Speciality Meat & Slop>"] = "Chef Jessen <Spécialités de viandes & pâtées>";
	["Stalvan Mistmantle"] = "Stalvan Mantebrume";
	["Phin Odelic <The Kirin Tor>"] = "Phin Odelic <Le Kirin Tor>";
	["Magistrate Henry Maleb"] = "Magistrat Henry Maleb";
	["Raleigh the True"] = "Raleigh le Vrai";
	["Nathanos Marris"] = "Nathanos Marris";
	["Bilger the Straight-laced"] = "Sentine le Guindé";
	["Innkeeper Monica"] = "Aubergiste Monica";
	["Julie Honeywell"] = "Julie Miellepuits";
	["Jay Lemieux"] = "Jay Lemieux";
	["Young Blanchy"] = "Jeune Blanchy";
	["Don Carlos"] = "Don Carlos";
	["Guerrero"] = "Guerrero";

	--Gruul's Lair
	["High King Maulgar <Lord of the Ogres>"] = "Haut Roi Maulgar <Seigneur des ogres>";
	["Kiggler the Crazed"] = "Kiggler le Cinglé";
	["Blindeye the Seer"] = "Oeillaveugle le Voyant";
	["Olm the Summoner"] = "Olm l'Invocateur";
	["Krosh Firehand"] = "Krosh Brasemain";
	["Gruul the Dragonkiller"] = "Gruul le Tue-dragon";

	--HFC: The Blood Furnace
	["Thrallmar"] = "Thrallmar"; --omitted from other HFC
	["Honor Hold"] = "Bastion de l'honneur"; --omitted from other HFC
	["Flamewrought Key"] = "Clé en flammes forgées"; --omitted from other HFC
	["The Maker"] = "Le Faiseur";
	["Broggok"] = "Broggok";
	["Keli'dan the Breaker"] = "Keli'dan le Briseur";

	--HFC: Hellfire Ramparts
	["Watchkeeper Gargolmar"] = "Gardien des guetteurs Gargolmar";
	["Omor the Unscarred"] = "Omor l'Intouché";
	["Vazruden"] = "Vazruden";
	["Nazan <Vazruden's Mount>"] = "Nazan <Monture de Vazruden>";
	["Reinforced Fel Iron Chest"] = "Coffre en gangrefer renforcé";

	--HFC: Magtheridon's Lair
	["Magtheridon"] = "Magtheridon";

	--HFC: The Shattered Halls
	["Shattered Halls Key"] = "Clé des Salles brisées";
	["Randy Whizzlesprocket"] = "Randy Vizirouage";
	["Drisella"] = "Drisella";
	["Grand Warlock Nethekurse"] = "Grand démoniste Néanathème";
	["Blood Guard Porung"] = "Garde de sang Porung";
	["Warbringer O'mrogg"] = "Porteguerre O'mrogg";
	["Warchief Kargath Bladefist"] = "Chef de guerre Kargath Lamepoing";
	["Shattered Hand Executioner"] = "Bourreau de la Main brisée";
	["Private Jacint"] = "Soldat Jacint";
	["Rifleman Brownbeard"] = "Fusilier Brownbeard";
	["Captain Alina"] = "Captaine Alina";
	["Scout Orgarr"] = "Eclaireur Orgarr";
	["Korag Proudmane"] = "Korag Proudmane";
	["Captain Boneshatter"] = "Capitaine Fracasse-os";

	--Karazhan Start
	["The Violet Eye"] = "L'Œil pourpre"; --omitted from Karazhan End
	["The Master's Key"] = "La clé du maître"; --omitted from Karazhan End
	["Staircase to the Ballroom"] = "Escalier de la salle de bal";
	["Stairs to Upper Stable"] = "Escalier vers les Ecuries";
	["Ramp to the Guest Chambers"] = "Rampe vers les Appartements des hôtes";
	["Stairs to Opera House Orchestra Level"] = "Escalier vers la fosse de l'Opéra";
	["Ramp from Mezzanine to Balcony"] = "Rampe de la Mezzanine au Balcon";
	["Connection to Master's Terrace"] = "Connexion à la terrasse du Maître";
	["Path to the Broken Stairs"] = "Chemin vers l'Escalier brisé";
	["Hastings <The Caretaker>"] = "Hastings <Le gardien>";
	["Servant Quarters"] = "Quartier des serviteurs";
	["Hyakiss the Lurker"] = "Hyakiss la Rôdeuse";
	["Rokad the Ravager"] = "Rodak le ravageur";
	["Shadikith the Glider"] = "Shadikith le glisseur";
	["Berthold <The Doorman>"] = "Berthold <Le concierge>";
	["Calliard <The Nightman>"] = "Calliard <Le veilleur de nuit>";
	["Attumen the Huntsman"] = "Attumen le Veneur";
	["Midnight"] = "Minuit";
	["Koren <The Blacksmith>"] = "Koren <Le forgeron>";
	["Moroes <Tower Steward>"] = "Moroes <Régisseur de la tour>";
	["Baroness Dorothea Millstipe"] = "Baronne Dorothea Millstipe";
	["Lady Catriona Von'Indi"] = "Dame Catriona Von'Indi";
	["Lady Keira Berrybuck"] = "Dame Keira Berrybuck";
	["Baron Rafe Dreuger"] = "Baron Rafe Dreuger";
	["Lord Robin Daris"] = "Seigneur Robin Daris";
	["Lord Crispin Ference"] = "Seigneur Crispin Ference";
	["Bennett <The Sergeant at Arms>"] = "Bennett <L'huissier>";
	["Ebonlocke <The Noble>"] = "Bouclenoire <Les nobles>";
	["Keanna's Log"] = "Journal de Keanna";
	["Maiden of Virtue"] = "Damoiselle de vertu";
	["Sebastian <The Organist>"] = "Sebastian <L'Organiste>";
	["Barnes <The Stage Manager>"] = "Barnes <Le Régisseur>";
	["The Opera Event"] = "L'Opéra";
	["Red Riding Hood"] = "Petit Chaperon Rouge";
	["The Big Bad Wolf"] = "Le Grand Méchant Loup";
	["Wizard of Oz"] = "Magicien d'Oz";
	["Dorothee"] = "Dorothée";
	["Tito"] = "Tito";
	["Strawman"] = "Homme de paille";
	["Tinhead"] = "Tête de fer-blanc";
	["Roar"] = "Graou";
	["The Crone"] = "La Mégère";
	["Romulo and Julianne"] = "Romulo et Julianne";
	["Romulo"] = "Romulo";
	["Julianne"] = "Julianne";
	["The Master's Terrace"] = "La terrasse du Maître";
	["Nightbane"] = "Plaie-de-nuit";

	--Karazhan End
	["Broken Stairs"] = "L'Escalier brisé";
	["Ramp to Guardian's Library"] = "Rampe vers la Bibliothèque du Gardien";
	["Suspicious Bookshelf"] = "Bibliotheque suspecte";
	["Ramp up to the Celestial Watch"] = "Rampe montant vers Le Guet céleste";
	["Ramp down to the Gamesman's Hall"] = "Rampe déscendant vers le Hall du Flambeur";
	["Chess Event"] = "L'Echéquier";
	["Ramp to Medivh's Chamber"] = "Rampe vers la chambre de Medivh";
	["Spiral Stairs to Netherspace"] = "Escalier en spiral vers le Néantespace";
	["The Curator"] = "Le conservateur";
	["Wravien <The Mage>"] = "Wravien <Le Mage>";
	["Gradav <The Warlock>"] = "Gradav <Le Démoniste>";
	["Kamsis <The Conjurer>"] = "Kamsis <L'Invocateur>";
	["Terestian Illhoof"] = "Terestian Malsabot";
	["Kil'rek"] = "Kil'rek";
	["Shade of Aran"] = "Ombre d'Aran";
	["Netherspite"] = "Dédain-du-Néant";
	["Ythyar"] = "Ythyar";
	["Echo of Medivh"] = "Echo de Medivh";
	["Dust Covered Chest"] = "Coffre couvert de poussière";
	["Prince Malchezaar"] = "Prince Malchezaar";

	--Magisters Terrace
	["Shattered Sun Offensive"] = "Opération Soleil brisé";
	["Selin Fireheart"] = "Selin Coeur-de-feu";
	["Fel Crystals"] = "Gangrecristaux";
	["Tyrith"] = "Tyrith";
	["Vexallus"] = "Vexallus";
	["Scrying Orb"] = "Orbe de divination";
	["Kalecgos"] = "Kalecgos";
	["Priestess Delrissa"] = "Prêtresse Delrissa";
	["Apoko"] = "Apoko";
	["Eramas Brightblaze"] = "Eramas Brillebrasier";
	["Ellrys Duskhallow"] = "Ellrys Sanctebrune";
	["Fizzle"] = "Féplouf";
	["Garaxxas"] = "Garaxxas";
	["Sliver <Garaxxas' Pet>"] = "Esquille <Familier de Garaxxas>";
	["Kagani Nightstrike"] = "Kagani Heurtenuit";
	["Warlord Salaris"] = "Seigneur de guerre Salaris";
	["Yazzai"] = "Yazzai";
	["Zelfan"] = "Zelfan";
	["Kael'thas Sunstrider <Lord of the Blood Elves>"] = "Kael'thas Haut-soleil <Seigneur des elfes de sang>";

	--Sunwell Plateau
	["Sathrovarr the Corruptor"] = "Sathrovarr le Corrupteur";
	["Madrigosa"] = "Madrigosa";
	["Brutallus"] = "Brutallus";
	["Felmyst"] = "Gangrebrume";
	["Eredar Twins"] = "Les jumelles Eredar";
	["Grand Warlock Alythess"] = "Grande démoniste Alythess";
	["Lady Sacrolash"] = "Dame Sacrocingle";
	["M'uru"] = "M'uru";
	["Entropius"] = "Entropius";
	["Kil'jaeden <The Deceiver>"] = "Kil'jaeden <Le Trompeur>";

	--TK: The Arcatraz
	["Key to the Arcatraz"] = "Clé de l'Arcatraz";
	["Zereketh the Unbound"] = "Zereketh le Délié";
	["Third Fragment Guardian"] = "Gardien du troisième fragment";
	["Dalliah the Doomsayer"] = "Dalliah l'Auspice-funeste";
	["Wrath-Scryer Soccothrates"] = "Scrute-courroux Soccothrates";
	["Udalo"] = "Udalo";
	["Harbinger Skyriss"] = "Messager Cieuriss";
	["Warden Mellichar"] = "Gardien Mellichar";
	["Millhouse Manastorm"] = "Milhouse Tempête-de-mana";

	--TK: The Botanica
	["The Sha'tar"] = "Les Sha'tar"; --omitted from other TK
	["Warpforged Key"] = "Clé dimensionnelle"; --omitted from other TK
	["Commander Sarannis"] = "Commandant Sarannis";
	["High Botanist Freywinn"] = "Grand botaniste Freywinn";
	["Thorngrin the Tender"] = "Rirépine le Tendre";
	["Laj"] = "Laj";
	["Warp Splinter"] = "Brise-dimension";

	--TK: The Mechanar
	["Gatewatcher Gyro-Kill"] = "Gardien de porte Gyro-Meurtre";
	["Gatewatcher Iron-Hand"] = "Gardien de porte Main-en-fer";
	["Cache of the Legion"] = "Cache de la Légion";
	["Mechano-Lord Capacitus"] = "Mécano-seigneur Capacitus";
	["Overcharged Manacell"] = "Cellule de mana surchargée";
	["Nethermancer Sepethrea"] = "Néantomancien Sepethrea";
	["Pathaleon the Calculator"] = "Pathaleon le Calculateur";

	--TK: The Eye
	["Al'ar <Phoenix God>"] = "Al'ar <Dieu phénix>";
	["Void Reaver"] = "Saccageur du Vide";
	["High Astromancer Solarian"] = "Grande Astromancienne Solarian";
	["Thaladred the Darkener <Advisor to Kael'thas>"] = "Thaladred l'Assombrisseur <Conseiller de Kael'thas>";
	["Master Engineer Telonicus <Advisor to Kael'thas>"] = "Maître ingénieur Telonicus <Conseiller de Kael'thas>";
	["Grand Astromancer Capernian <Advisor to Kael'thas>"] = "Grande astromancienne Capernian <Conseillère de Kael'thas>";
	["Lord Sanguinar <The Blood Hammer>"] = "Seigneur Sanguinar <Le Marteau de sang>";

	--Zul'Aman
	["Harrison Jones"] = "Harrison Jones";
	["Nalorakk <Bear Avatar>"] = "Nalorakk <Avatar d'Ours>";
	["Tanzar"] = "Tanzar";
	["The Map of Zul'Aman"] = "Carte de Zul'Aman de Budd";
	["Akil'Zon <Eagle Avatar>"] = "Akil'Zon <Avatar d'Aigle>";
	["Harkor"] = "Harkor";
	["Jan'Alai <Dragonhawk Avatar>"] = "Jan'Alai <Avatar de Faucon-dragon>";
	["Kraz"] = "Kraz";
	["Halazzi <Lynx Avatar>"] = "Halazzi <Avatar de Lynx>";
	["Ashli"] = "Ashli";
	["Zungam"] = "Zungam";
	["Hex Lord Malacrass"] = "Seigneur des maléfices Malacrass";
	["Thurg"] = "Thurg";
	["Gazakroth"] = "Gazakroth";
	["Lord Raadan"] = "Seigneur Raadan";
	["Darkheart"] = "Sombrecoeur";
	["Alyson Antille"] = "Alyson Antille";
	["Slither"] = "Sinueux";
	["Fenstalker"] = "Traquetourbe";
	["Koragg"] = "Koragg";
	["Zul'jin"] = "Zul'jin";
	["Forest Frogs"] = "Grenouilles forestière";
	["Kyren <Reagents>"] = "Kyren <Composants>";
	["Gunter <Food Vendor>"] = "Gunter <Vendeur de nourriture>";
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
	["Elder Nadox"] = "Ancien Nadox";
	["Prince Taldaram"] = "Prince Taldaram";
	["Jedoga Shadowseeker"] = "Jedoga Cherchelombre";
	["Herald Volazj"] = "Héraut Volazj";
	["Amanitar"] = "Amanitar";
	["Ahn'kahet Brazier"] = "Brasero d'Ahn'kahet";

	--Azjol-Nerub
	["Krik'thir the Gatewatcher"] = "Krik'thir le Gardien de porte";
	["Watcher Gashra"] = "Gardien Gashra";
	["Watcher Narjil"] = "Gardien Narjil";
	["Watcher Silthik"] = "Gardien Silthik";
	["Hadronox"] = "Hadronox";
	["Elder Nurgen"] = "Ancien Nurgen";
	["Anub'arak"] = "Anub'arak";

	--Caverns of Time: The Culling of Stratholme
	["The Culling of Stratholme"] = "L'Épuration de Stratholme";
	["Meathook"] = "Grancrochet";
	["Salramm the Fleshcrafter"] = "Salramm le Façonneur de chair";
	["Chrono-Lord Epoch"] = "Chronoseigneur Epoch";
	["Mal'Ganis"] = "Mal'Ganis";
	["Chromie"] = "Chromie";
	["Infinite Corruptor"] = "Corrupteur infini";
	["Guardian of Time"] = "Gardien du Temps";
	["Scourge Invasion Points"] = "Points d'invasion du Fléau";

	--Drak'Tharon Keep
	["Trollgore"] = "Trollétripe";
	["Novos the Summoner"] = "Novos l'Invocateur";
	["Elder Kilias"] = "Ancien Kilias";
	["King Dred"] = "Roi Dred";
	["The Prophet Tharon'ja"] = "Le prophète Tharon'ja";
	["Kurzel"] = "Kurzel";
	["Drakuru's Brazier"] = "Brasero Drakuru";

	--The Frozen Halls: Halls of Reflection
	--3 beginning NPCs omitted, see The Forge of Souls
	["Falric"] = "Falric";
	["Marwyn"] = "Marwyn";
	["Wrath of the Lich King"] = "Wrath of the Lich King";
	["The Captain's Chest"] = "Le coffre du capitaine";

	--The Frozen Halls: Pit of Saron
	--6 beginning NPCs omitted, see The Forge of Souls
	["Forgemaster Garfrost"] = "Maître-forge Gargivre";
	["Martin Victus"] = "Martin Victus";
	["Gorkun Ironskull"] = "Gorkun Crâne-de-fer";
	["Krick and Ick"] = "Krick et Ick";
	["Scourgelord Tyrannus"] = "Seigneur du Fléau Tyrannus";
	["Rimefang"] = "Frigecroc";

	--The Frozen Halls: The Forge of Souls
	--Lady Jaina Proudmoore omitted, in Hyjal Summit
	["Archmage Koreln <Kirin Tor>"] = "Archimage Koreln <Kirin Tor>";
	["Archmage Elandra <Kirin Tor>"] = "Archimage Elandra <Kirin Tor>";
	["Lady Sylvanas Windrunner <Banshee Queen>"] = "Dame Sylvanas Coursevent <Reine banshee>";
	["Dark Ranger Loralen"] = "Forestier-sombre Loralen";
	["Dark Ranger Kalira"] = "Forestier-sombre Kalira";
	["Bronjahm <Godfather of Souls>"] = "Bronjahm <Parrain des âmes>";
	["Devourer of Souls"] = "Dévoreur d'âmes";

	--Gundrak
	["Slad'ran <High Prophet of Sseratus>"] = "Slad'ran <Grand prophète de Sseratus>";
	["Drakkari Colossus"] = "Colosse drakkari";
	["Elder Ohanzee"] = "Ancien Ohanzee";
	["Moorabi <High Prophet of Mam'toth>"] = "Moorabi <Grand prophète de Mam'toth>";
	["Gal'darah <High Prophet of Akali>"] = "Gal'darah <Grand prophète d'Akali>";
	["Eck the Ferocious"] = "Eck le Féroce";

	--Icecrown Citadel
	["The Ashen Verdict"] = "Le Verdict des cendres";
	["Lord Marrowgar"] = "Seigneur Gargamoelle";
	["Lady Deathwhisper"] = "Dame Murmemort";
	["Gunship Battle"] = "Armurerie de la canonnière";
	["Deathbringer Saurfang"] = "Porte-mort Saurcroc";
	["Festergut"] = "Pulentraille";
	["Rotface"] = "Trognepus";
	["Professor Putricide"] = "Professeur Putricide";
	["Blood Prince Council"] = "Blood Prince Council";
	["Prince Keleseth"] = "Prince Keleseth";
	["Prince Taldaram"] = "Prince Taldaram";
	["Prince Valanar"] = "Prince Valanar";
	["Blood-Queen Lana'thel"] = "Reine de sang Lana'thel";
	["Valithria Dreamwalker"] = "Valithria Marcherêve";
	["Sindragosa <Queen of the Frostbrood>"] = "Sindragosa <Reine des Couvegivres>";
	["The Lich King"] = "Le roi-liche";
	["To next map"] = "Vers la carte suivante";
	["From previous map"] = "Vers la carte précédente";
	["Upper Spire"] = "Flèche supérieure";
	["Sindragosa's Lair"] = "Repaire de Sindragosa";

	--Naxxramas
	["Mr. Bigglesworth"] = "M. Bigglesworth";
	["Patchwerk"] = "Le Recousu";
	["Grobbulus"] = "Grobbulus";
	["Gluth"] = "Gluth";
	["Thaddius"] = "Thaddius";
	["Anub'Rekhan"] = "Anub'Rekhan";
	["Grand Widow Faerlina"] = "Grande veuve Faerlina";
	["Maexxna"] = "Maexxna";
	["Instructor Razuvious"] = "Instructeur Razuvious";
	["Gothik the Harvester"] = "Gothik le Moissonneur";
	["The Four Horsemen"] = "Les quatre cavaliers";
	["Thane Korth'azz"] = "Thane Korth'azz";
	["Lady Blaumeux"] = "Dame Blaumeux";
	--Baron Rivendare omitted, listed under Stratholme
	["Sir Zeliek"] = "Sir Zeliek";
	["Four Horsemen Chest"] = "Coffre des quatre cavaliers";
	["Noth the Plaguebringer"] = "Noth le Porte-peste";
	["Heigan the Unclean"] = "Heigan l'Impur";
	["Loatheb"] = "Horreb";
	["Frostwyrm Lair"] = "Repaire de la Wyrm des glaces";
	["Sapphiron"] = "Sapphiron";
	["Kel'Thuzad"] = "Kel'Thuzad";

	--The Obsidian Sanctum
	["Black Dragonflight Chamber"] = "Chambre du vol draconique noir";
	["Sartharion <The Onyx Guardian>"] = "Sartharion <Le gardien d'Onyx>";
	["Tenebron"] = "Ténébron";
	["Shadron"] = "Obscuron";
	["Vesperon"] = "Vespéron";

	--Onyxia's Lair
	["Onyxian Warders"] = "Gardiens onyxiens";
	["Whelp Eggs"] = "Œufs";
	["Onyxia"] = "Onyxia";

	--The Ruby Sanctum
	["Red Dragonflight Chamber"] = "Chambre du vol draconique Rouge";
	["Baltharus the Warborn"] = "Baltharus l'Enfant de la guerre";
	["Saviana Ragefire"] = "Savianna Ragefeu";
	["General Zarithrian"] = "Général Zarithrian";
	["Halion <The Twilight Destroyer>"] = "Halion le Destructeur du Crépuscule";

	--The Nexus: The Eye of Eternity
	["Malygos"] = "Malygos";
	["Key to the Focusing Iris"] = "Clé de l'iris de focalisation";

	--The Nexus: The Nexus
	["Berinand's Research"] = "Recherches de Bérinand";
	["Commander Stoutbeard"] = "Commandant Rudebarbe";
	["Commander Kolurg"] = "Commandant Kolurg";
	["Grand Magus Telestra"] = "Grand Magus Telestra";
	["Anomalus"] = "Anomalus";
	["Elder Igasho"] = "Ancien Igasho";
	["Ormorok the Tree-Shaper"] = "Ormorok le Sculpte-arbre";	
	["Keristrasza"] = "Keristrasza";

	--The Nexus: The Oculus
	["Drakos the Interrogator"] = "Drakos l'Interrogateur";
	["Mage-Lord Urom"] = "Seigneur-mage Urom";
	["Ley-Guardian Eregos"] = "Gardien-tellurique Eregos";
	["Varos Cloudstrider <Azure-Lord of the Blue Dragonflight>"] = "Varos Arpentenuée <Seigneur-azur du vol draconique bleu>";
	["Centrifuge Construct"] = "Assemblage centrifuge";
	["Cache of Eregos"] = "Cache d'Eregos";

	--Trial of the Champion
	["Grand Champions"] = "Grand Champions";
	["Champions of the Alliance"] = "Champions de l'Alliance";
	["Marshal Jacob Alerius"] = "Maréchal Jacob Alerius";
	["Ambrose Boltspark"] = "Ambrose Étinceboulon";
	["Colosos"] = "Colossos";
	["Jaelyne Evensong"] = "Jaelyne Chant-du-soir";
	["Lana Stouthammer"] = "Lana Rudemartel";
	["Champions of the Horde"] = "Champions de la Horde";
	["Mokra the Skullcrusher"] = "Mokra le Brise-tête";
	["Eressea Dawnsinger"] = "Eressea Chantelaube";
	["Runok Wildmane"] = "Runok Crin-sauvage";
	["Zul'tore"] = "Zul'tore";
	["Deathstalker Visceri"] = "Nécrotraqueur Viscéri";
	["Eadric the Pure <Grand Champion of the Argent Crusade>"] = "Eadric le Pur <Grand champion de la Croisade d'argent>";
	["Argent Confessor Paletress"] = "Confesseur d'argent Paletress";
	["The Black Knight"] = "Le Chevalier noir";

	--Trial of the Crusader
	["Cavern Entrance"] = "Entrée de la caverne";
	["Northrend Beasts"] = "Bêtes du Norfendre";
	["Gormok the Impaler"] = "Gormok l'Empaleur";
	["Acidmaw"] = "Gueule-d'acide";
	["Dreadscale"] = "Ecaille-d'effroi";
	["Icehowl"] = "Glace-hurlante";
	["Lord Jaraxxus"] = "Seigneur Jaraxxus";
	["Faction Champions"] = "Champions de faction";
	["Twin Val'kyr"] = "Jumelles val'kyrs";
	["Fjola Lightbane"] = "Fjola Plaie-lumineuse";
	["Eydis Darkbane"] = "Eydis Plaie-sombre";
	["Anub'arak"] = "Anub'arak";
	["Heroic: Trial of the Grand Crusader"] = "Héroïque: L'appel de la grande Croisade";

	-- Ulduar General
	["Celestial Planetarium Key"] = "Clé du planétarium céleste";
	["The Siege"] = "Le Siège";
	["The Keepers"] = "Les Gardiens"; --C

	-- Ulduar A
	["Flame Leviathan"] = "Léviathan des flammes";
	["Ignis the Furnace Master"] = "Ignis le maître de la Fournaise";
	["Razorscale"] = "Tranchécaille";
	["XT-002 Deconstructor"] = "Déconstructeur XT-002";
	["Tower of Life"] = "Tour de la vie";
	["Tower of Flame"] = "Tour des flammes";
	["Tower of Frost"] = "Tour du givre";
	["Tower of Storms"] = "Tour des tempêtes";

	-- Ulduar B
	["Assembly of Iron"] = "L'Assemblée de Fer";
	["Steelbreaker"] = "Brise-acier";
	["Runemaster Molgeim"] = "Maître des runes Molgeim";
	["Stormcaller Brundir"] = "Mande-foudre Brundir";
	["Kologarn"] = "Kologarn";
	["Algalon the Observer"] = "Algalon l'Observateur";	
	["Prospector Doren"] = "Prospecteur Doren";
	["Archivum Console"] = "Console de l'Archivum";

	-- Ulduar C
	["Auriaya"] = "Auriaya";
	["Freya"] = "Freya";
	["Thorim"] = "Thorim";
	["Hodir"] = "Hodir";

	-- Ulduar D
	["Mimiron"] = "Mimiron";

	-- Ulduar E
	["General Vezax"] = "Général Vezax";
	["Yogg-Saron"] = "Yogg-Saron";

	--Ulduar: Halls of Lightning
	["General Bjarngrim"] = "General Bjarngrim";
	["Volkhan"] = "Volkhan";
	["Ionar"] = "Ionar";
	["Loken"] = "Loken";

	--Ulduar: Halls of Stone
	["Elder Yurauk"] = "Ancien Yurauk";	
	["Krystallus"] = "Krystallus";
	["Maiden of Grief"] = "Damoiselle de peine";
	["Brann Bronzebeard"] = "Brann Barbe-de-bronze";
	["Tribunal Chest"] = "Coffre du tribunal";
	["Sjonnir the Ironshaper"] = "Sjonnir le Sculptefer";

	--Utgarde Keep: Utgarde Keep
	["Dark Ranger Marrah"] = "Forestier-sombre Marrah";
	["Prince Keleseth <The San'layn>"] = "Prince Keleseth <Les San'layn>";
	["Elder Jarten"] = "Ancien Jarten";
	["Dalronn the Controller"] = "Dalronn le Contrôleur";
	["Skarvald the Constructor"] = "Skarvald le Constructeur";
	["Ingvar the Plunderer"] = "Ingvar le Pilleur";	

	--Utgarde Keep: Utgarde Pinnacle
	["Brigg Smallshanks"] = "Brigg Courtecannes";
	["Svala Sorrowgrave"] = "Svala Tristetombe"; 
	["Gortok Palehoof"] = "Gortok Pâle-sabot";
	["Skadi the Ruthless"] = "Skadi le Brutal";
	["Elder Chogan'gada"] = "Ancien Chogan'gada";
	["King Ymiron"] = "Roi Ymiron";

	--Vault of Archavon
	["Archavon the Stone Watcher"] = "Archavon le Gardien des pierres";
	["Emalon the Storm Watcher"] = "Emalon le Guetteur d'orage";
	["Koralon the Flame Watcher"] = "Koralon le Veilleur des flammes";
	["Toravon the Ice Watcher"] = "Toravon la Sentinelle de glace";

	--The Violet Hold
	["Erekem"] = "Erekem";
	["Zuramat the Obliterator"] = "Zuramat l'Oblitérateur";
	["Xevozz"] = "Xevozz";
	["Ichoron"] = "Ichoron";
	["Moragg"] = "Moragg";
	["Lavanthor"] = "Lavanthor";
	["Cyanigosa"] = "Cyanigosa";
	["The Violet Hold Key"] = "La clé du Fort pourpre";

};
end