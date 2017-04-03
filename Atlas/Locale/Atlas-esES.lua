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

-- Atlas Spanish Localization
-- Traducido por --> maqjav|Marosth de Tyrande<--
-- maqjav@gmail.com
-- Última Actualización (last update): 09/02/2010

--************************************************
-- Global Atlas Strings
--************************************************

if ( GetLocale() == "esES" ) then

AtlasSortIgnore = {"the (.+)"}

ATLAS_TITLE = "Atlas";

BINDING_HEADER_ATLAS_TITLE = "Enlaces Atlas";
BINDING_NAME_ATLAS_TOGGLE = "Barra del Atlas";
BINDING_NAME_ATLAS_OPTIONS = "Opciones de la Barra";
BINDING_NAME_ATLAS_AUTOSEL = "Auto-Selecciona";

ATLAS_SLASH = "/atlas";
ATLAS_SLASH_OPTIONS = "opciones";

ATLAS_STRING_LOCATION = "Localización";
ATLAS_STRING_LEVELRANGE = "Rango de nivel";
ATLAS_STRING_PLAYERLIMIT = "Límite de Jugadores";
ATLAS_STRING_SELECT_CAT = "Seleccionar Categoría";
ATLAS_STRING_SELECT_MAP = "Seleccionar Mapa";
ATLAS_STRING_SEARCH = "Buscar";
ATLAS_STRING_CLEAR = "Limpiar";
ATLAS_STRING_MINLEVEL = "Nivel mínimo";

ATLAS_OPTIONS_BUTTON = "Opciones";
ATLAS_OPTIONS_SHOWBUT = "Mostrar botón en el minimapa";
ATLAS_OPTIONS_AUTOSEL = "Auto-Seleccionar mazmorra";
ATLAS_OPTIONS_BUTPOS = "Posición del icono";
ATLAS_OPTIONS_TRANS = "Transparencia";
ATLAS_OPTIONS_RCLICK = "Botón derecho para mapa del mundo";
ATLAS_OPTIONS_RESETPOS = "Resetear posición";
ATLAS_OPTIONS_ACRONYMS = "Mostrar acrónimos";
ATLAS_OPTIONS_SCALE = "Escala";
ATLAS_OPTIONS_BUTRAD = "Radio del botón";
ATLAS_OPTIONS_CLAMPED = "Ajustar ventana a la pantalla";
ATLAS_OPTIONS_CTRL = "Pulsar control para ver las herramientas";

ATLAS_BUTTON_TOOLTIP_TITLE = "Atlas";
ATLAS_BUTTON_TOOLTIP_HINT = "Click izquierdo para abrir Atlas.\nClick central para opciones.\nClick derecho y arrastrar para mover el icono.";
ATLAS_LDB_HINT = "Click izquierdo para abrir Atlas.\nClick central para opciones.\nClick derecho para mostrar el menú.";

ATLAS_OPTIONS_CATDD = "Ordenar los mapas de mazmorra por:";
ATLAS_DDL_CONTINENT = "Continente";
ATLAS_DDL_CONTINENT_EASTERN = "Mazmorras de los Reinos del Este";
ATLAS_DDL_CONTINENT_KALIMDOR = "Mazmorras de Kalimdor";
ATLAS_DDL_CONTINENT_OUTLAND = "Mazmorras de Terrallende";
ATLAS_DDL_CONTINENT_NORTHREND = "Mazmorras de Rasganorte";
ATLAS_DDL_LEVEL = "Nivel";
ATLAS_DDL_LEVEL_UNDER45 = "Mazmorras de nivel inferior a 45";
ATLAS_DDL_LEVEL_45TO60 = "Mazmorras de nivel 45-60";
ATLAS_DDL_LEVEL_60TO70 = "Mazmorras de nivel 60-70";
ATLAS_DDL_LEVEL_70PLUS = "Mazmorras de nivel 70+";
ATLAS_DDL_LEVEL_80PLUS = "Mazmorras de nivel 80+";
ATLAS_DDL_PARTYSIZE = "Tamaño del grupo";
ATLAS_DDL_PARTYSIZE_5_AE = "Mazmorras para 5 jugadores A-E";
ATLAS_DDL_PARTYSIZE_5_FZ = "Mazmorras para 5 jugadores F-Z";
ATLAS_DDL_PARTYSIZE_10_AQ = "Mazmorras para 10 jugadores A-Q";
ATLAS_DDL_PARTYSIZE_10_RZ = "Mazmorras para 10 jugadores R-Z";
ATLAS_DDL_PARTYSIZE_20TO40 = "Mazmorras para 20-40 jugadores";
ATLAS_DDL_EXPANSION = "Expansión";
ATLAS_DDL_EXPANSION_OLD_AO = "Antiguas Mazmorras A-O";
ATLAS_DDL_EXPANSION_OLD_PZ = "Antiguas Mazmorras P-Z";
ATLAS_DDL_EXPANSION_BC = "Mazmorras de Burning Crusade";
ATLAS_DDL_EXPANSION_WOTLK = "Mazmorras Wrath of the Lich King";
ATLAS_DDL_TYPE = "Tipo";
ATLAS_DDL_TYPE_INSTANCE_AC = "Mazmorras A-C";
ATLAS_DDL_TYPE_INSTANCE_DR = "Mazmorras D-R";
ATLAS_DDL_TYPE_INSTANCE_SZ = "Mazmorras S-Z";
ATLAS_DDL_TYPE_ENTRANCE = "Entradas";

ATLAS_INSTANCE_BUTTON = "Mazmorra";
ATLAS_ENTRANCE_BUTTON = "Entrada";
ATLAS_SEARCH_UNAVAIL = "Buscar no disponible";

ATLAS_DEP_MSG1 = "Atlas ha detectado uno o varios modulos sin actualizar.";
ATLAS_DEP_MSG2 = "Se han sido desactivados para este personaje.";
ATLAS_DEP_MSG3 = "Borralos de tu directorio AddOns.";
ATLAS_DEP_OK = "Vale";

AtlasZoneSubstitutions = {
	["The Temple of Atal'Hakkar"] = "El Templo de Atal'Hakkar";
	["Ahn'Qiraj"] = "Templo de Ahn'Qiraj";
};

AtlasLocale = {

--************************************************
-- Zone Names, Acronyms, and Common Strings
--************************************************

	--World Events, Festival
	["Brewfest"] = "Festival de la cerveza";
	["Hallow's End"] = "Halloween";
	["Love is in the Air"] = "Amor en el aire";
	["Lunar Festival"] = "Festival lunar";
	["Midsummer Festival"] = "Festival del solsticio de verano";
	--Misc strings
	["Adult"] = "Adulto";
	["AKA"] = "AKA";
	["Alliance"] = "Alianza";
	["Arcane Container"] = "Contenedor Arcano";	
	["Argent Dawn"] = "El Alba Argenta";
	["Argent Crusade"] = "Cruzada Argenta";
	["Arms Warrior"] = "Guerrero Armas";
	["Attunement Required"] = "Armonización requerida";
	["Back"] = "Atras";
	["Basement"] = "Sótano";
	["Bat"] = "Murciélago";
	["Blacksmithing Plans"] = "Planos de herrero";
	["Boss"] = "Jefe";
	["Brazier of Invocation"] = "Blandón de Invocación";
	["Chase Begins"] = "Comienza persecución";
	["Chase Ends"] = "Final persecución";
	["Child"] = "Niño";
	["Connection"] = "Conexión";
	["DS2"] = "DS2";
	["Elevator"] = "Ascensor";
	["End"] = "Fin";
	["Engineer"] = "Ingeniero";	
	["Entrance"] = "Entrada";
	["Event"] = "Evento";
	["Exalted"] = "Exaltado";
	["Exit"] = "Salida";
	["Fourth Stop"] = "Cuarta parada";
	["Front"] = "Frente";
	["Ghost"] = "Fantasma";
	["Heroic"] = "Heróico";
	["Holy Paladin"] = "Paladín Sagrado";
	["Holy Priest"] = "Sacerdote Sagrado";
	["Horde"] = "Horda";
	["Hunter"] = "Cazador";
	["Imp"] = "Duendecillo";
	["Inside"] = "Dentro";
	["Key"] = "Llave";
	["Lower"] = "Abajo";
	["Mage"] = "Mago";
	["Meeting Stone"] = "Piedra de encuentro";
	["Monk"] = "Monje";	
	["Moonwell"] = "Claro de la luna";
	["Optional"] = "Opcional";
	["Orange"] = "Naranja";
	["Outside"] = "Fuera";
	["Paladin"] = "Paladín";
	["Panther"] = "Pantera";
	["Portal"] = "Portal";
	["Priest"] = "Sacerdote";
	["Protection Warrior"] = "Guerrero Protección";
	["Purple"] = "Morado";
	["Random"] = "Aleatorio";
	["Raptor"] = "Raptor";
	["Rare"] = "Raro";
	["Reputation"] = "Reputación";
	["Repair"] = "Reparar";
	["Retribution Paladin"] = "Paladín Reprensión";
	["Rewards"] = "Recompensas";
	["Rogue"] = "Pícaro";
	["Second Stop"] = "Segunda parada";
	["Shadow Priest"] = "Sacerdote Sombras";
	["Shaman"] = "Chamán";
	["Side"] = "Lado";
	["Snake"] = "Serpiente";
	["Spawn Point"] = "Punto de aparición";
	["Spider"] = "Araña";
	["Start"] = "Comienzo";
	["Summon"] = "Invocar";
	["Teleporter"] = "Teletransportador";
	["Third Stop"] = "Tercera parada";
	["Tiger"] = "Tigre";
	["Top"] = "Arriba";
	["Undead"] = "No muerto";
	["Underwater"] = "Bajo el agua";
	["Unknown"] = "Desconocido";
	["Upper"] = "Arriba";
	["Varies"] = "Varios";
	["Wanders"] = "Rondando";
	["Warlock"] = "Brujo";
	["Warrior"] = "Guerrero";
	["Wave 5"] = "Ola 5";
	["Wave 6"] = "Ola 6";
	["Wave 10"] = "Ola 10";
	["Wave 12"] = "Ola 12";
	["Wave 18"] = "Ola 18";

	--Classic Acronyms
	["AQ"] = "AQ"; -- Ahn'Qiraj
	["AQ20"] = "AQ20"; -- Ruins of Ahn'Qiraj
	["AQ40"] = "AQ40"; -- Temple of Ahn'Qiraj
	["Armory"] = "Armería";	-- Armory
	["BFD"] = "CB"; -- Blackfathom Deeps, Cavernas de Brazanegra
	["BRD"] = "PRN"; -- Blackrock Depths, Profundidades de Roca Negra
	["BRM"] = "MRN"; -- Blackrock Mountain, Montaña Roca Negra"
	["BWL"] = "GAN"; -- Blackwing Lair, Guarida Alanegra
	["Cath"] = "Cated"; --Catedral
	["DM"] = "LM"; -- Dire Maul, La Masacre	
	["Gnome"] = "Gnome"; -- Gnomeregan
	["GY"] = "Cemen"; -- Graveyard, Cementerio
	["LBRS"] = "CRNI";  -- Lower Blackrock Spire
	["Lib"] = "Lib";	 -- Library
	["Mara"] = "Mara";	 -- Maraudon
	["MC"] = "MC";	-- Molten Core, Núcleo de Magma
	["RFC"] = "SI"; -- Ragefire Chasm, Sima Ignea
	["RFD"] = "ZR"; --Razorfen Downs, Zahúrda Rajacieno
	["RFK"] = "HR"; -- Razorfen Kraul, Horado Rajacieno
	["Scholo"] = "Scholo"; -- Scholomance
	["SFK"] = "CCO"; -- Shadowfang Keep, Castillo de Colmillo Oscuro"
	["SM"] = "ME"; -- Scarlet Monastery, Monasterio Escarlata
	["ST"] = "TA"; -- Sunken Temple, Templo de Atal'Hakkar
	["Strat"] = "Strat"; -- Stratholme
	["Stocks"] = "Mazmorras"; -- The Stockade, Las Mazmorras
	["UBRS"] = "CRNS"; -- Upper Blackrock Spire, Cumbre de Roca Negra
	["Ulda"] = "Ulda"; -- Uldaman
	["VC"] = "LMM"; --The Deadmines, Las Minas de la Muerte
	["WC"] = "CL"; -- Wailing Caverns, Las Cuevas de los Lamentos
	["ZF"] = "ZF"; -- Zul'Farrak
	["ZG"] = "ZG"; -- Zul'Gurub

	--BC Acronyms
	["AC"] = "CA"; --Criptas Auchenai 
	["Arca"] = "Arca";
	["Auch"] = "Auch";
	["BF"] = "HS"; --orno de Sangre
	["BT"] = "TO"; --Templo Oscuro	
	["Bota"] = "Inver"; --El Invernáculo
	["CoT"] = "CdT"; --Cavernas del Tiempo
	["CoT1"] = "CdT1";	--Laderas de Trabalomas
	["CoT2"] = "CdT2"; --La Ciénaga Negra
	["CoT3"] = "CdT3"; --El Monte Hyjal
	["CR"] = "RCT"; --Reserva Colmillo Torcido
	["Eye"] = "Ojo"; --El Ojo"
	["GL"] = "Gruul"; --Guarida de Gruul
	["HC"] = "CFI"; --Ciudadela del Fuego Infernal
	["Kara"] = "Kara";
	["MaT"] = "BM"; --Bancal del Magister
	["Mag"] = "Mag"; --Guarida de Magtheridon
	["Mech"] = "Mech"; --El Mechanar
	["MT"] = "TM"; --Tumbas de Maná
	["Ramp"] = "Murallas";	 --Murallas del Fuego Infernal
	["SC"] = "CSS"; --Caverna Santuario Serpiente
	["Seth"] = "Seth"; --Salas Sethekk
	["SH"] = "SA"; --Las Salas Arrasadas
	["SL"] = "LS"; --Laberinto de las sombras
	["SP"] = "Recinto"; --Recinto de los Esclavos
	["SuP"] = "MPS"; --Meseta del pozo del Sol
	["SV"] = "CV"; --Cámara de Vapor
	["TK"] = "CT"; --El Castillo de la Tempestad
	["UB"] = "Soti"; --La Sotiénaga
	["ZA"] = "ZA";

	--WotLK Acronyms
	["AK, Kahet"] = "Kahet"; -- Ahn'kahet
	["AN, Nerub"] = "AN, Nerub"; -- Azjol-Nerub
	["Champ"] = "Camp"; -- Trial of the Champion
	["CoT-Strat"] = "Strat, CdT-Strat"; -- Culling of Stratholme
	["Crus"] = "Cruz"; -- Trial of the Crusader
	["DTK"] = "DTK"; -- Drak'Tharon Keep
	["FoS"] = "FdA"; ["FH1"] = "FH1"; -- The Forge of Souls
	["Gun"] = "Gun"; -- Gundrak
	["HoL"] = "CdR"; -- Halls of Lightning
	["HoR"] = "CdR"; ["FH3"] = "CR3"; -- Halls of Reflection
	["HoS"] = "CdP"; -- Halls of Stone
	["IC"] = "CCH"; -- Icecrown Citadel
	["Nax"] = "Nax"; -- Naxxramas	
	["Nex, Nexus"] = "Nexo"; -- The Nexus
	["Ocu"] = "Oculus"; -- The Oculus
	["Ony"] = "Ony"; -- Onyxia's Lair
	["OS"] = "SO"; -- The Obsidian Sanctum
	["PoS"] = "FdS"; ["FH2"] = "CR2"; -- Pit of Saron
	["RS"] = "SR"; -- The Ruby Sanctum
	["TEoE"] = "OE"; -- The Eye of Eternity
	["UK, Keep"] = "GU, Guarida"; -- Utgarde Keep
	["Uldu"] = "Uldu"; -- Ulduar
	["UP, Pinn"] = "PU, Pinaculo"; -- Utgarde Pinnacl
	["VH"] = "BV"; -- The Violet Hold
	["VoA"] = "CdA"; -- Vault of Archavon

	--Zones not included in LibBabble-Zone
	["Crusaders' Coliseum"] = "Coliseo de los Cruzados";

--************************************************
-- Instance Entrance Maps
--************************************************

	--Auchindoun (Entrance)
	["Ha'Lei"] = "Ha'Lei";
	["Greatfather Aldrimus"] = "Abuelo Aldrimus";
	["Clarissa"] = "Clarissa";
	["Ramdor the Mad"] = "Ramdor el Loco";
	["Horvon the Armorer <Armorsmith>"] = "Horvon el Armero <Forjador de armaduras>";
	["Nexus-Prince Haramad"] = "Príncipe-nexo Haramad";
	["Artificer Morphalius"] = "Artificiero Morphalius";
	["Mamdy the \"Ologist\""] = "Mamdy el  \"Todólogo\"";
	["\"Slim\" <Shady Dealer>"] = "\"Flaco\" <Vendedor sospechoso>";
	["\"Captain\" Kaftiz"] = "\"Capitán\" Kaftiz";
	["Isfar"] = "Isfar";
	["Field Commander Mahfuun"] = "Comandante de campo Mahfuun";
	["Spy Grik'tha"] = "Espía Grik'tha";
	["Provisioner Tsaalt"] = "Proveedor Tsaalt";
	["Dealer Tariq <Shady Dealer>"] = "Tratante Tariq <Vendedor sospechoso>";

	--Blackfathom Deeps (Entrance)
	--Nothing to translate!

	--Blackrock Mountain (Entrance)
	["Bodley"] = "Bodley";
	["Overmaster Pyron"] = "Maestro Supremo Pyron";
	["Lothos Riftwaker"] = "Lothos Levantagrietas";
	["Franclorn Forgewright"] = "Franclorn Forjador";
	["Orb of Command"] = "Orbe de orden";
	["Scarshield Quartermaster <Scarshield Legion>"] = "Intendente del Escudo del Estigma <Legión Escudo del Estigma>";

	--Coilfang Reservoir (Entrance)
	["Watcher Jhang"] = "Vigía Jhang";
	["Mortog Steamhead"] = "Mortog Testavapor";

	--Caverns of Time (Entrance)
	["Steward of Time <Keepers of Time>"] = "Administrador del Tiempo <Vigilantes del Tiempo>";
	["Alexston Chrome <Tavern of Time>"] = "Alexston Cromo <La Taberna del Tiempo>";
	["Yarley <Armorer>"] = "Yarley <Armero>";
	["Bortega <Reagents & Poison Supplies>"] = "Bortega <Suministros de venenos y componentes>";
	["Galgrom <Provisioner>"] = "Galgrom <Galgrom>";
	["Alurmi <Keepers of Time Quartermaster>"] = "Alurmi <Intendente de los Vigilantes del Tiempo>";
	["Zaladormu"] = "Zaladormu";
	["Soridormi <The Scale of Sands>"] = "Soridormi <La Escama de las Arenas>";
	["Arazmodu <The Scale of Sands>"] = "Arazmodu <La Escama de las Arenas>";
	["Andormu <Keepers of Time>"] = "Andormu <Vigilantes del Tiempo";
	["Nozari <Keepers of Time>"] = "Nozari <Vigilantes del Tiempo>";

	--Dire Maul (Entrance)
	["Dire Pool"] = "Estanque Funesto";
	["Dire Maul Arena"] = "Arena de La Masacre";
	["Mushgog"] = "Mushgog";
	["Skarr the Unbreakable"] = "Skarr el Inquebrantable";
	["The Razza"] = "El Razza";
	["Elder Mistwalker"] = "Ancestro Caminalba";

	--Gnomeregan (Entrance)
	["Transpolyporter"] = "Teletransportador"; --Check
	["Sprok <Away Team>"] = "Sprok <Equipo de huida>";
	["Matrix Punchograph 3005-A"] = "Perforégrafo Matriz 3005-A";
	["Namdo Bizzfizzle <Engineering Supplies>"] = "Namdo Silvabín <Suministros de ingeniería>";
	["Techbot"] = "Tecnobot";

	-- Hellfire Citadel (Entrance)
	["Steps and path to the Blood Furnace"] = "Steps and path to the Blood Furnace"; -- Need translation
	["Path to the Hellfire Ramparts and Shattered Halls"] = "Path to the Hellfire Ramparts and Shattered Halls"; -- Need translation
	["Meeting Stone of Magtheridon's Lair"] = "Meeting Stone of Magtheridon's Lair"; -- Need translation
	["Meeting Stone of Hellfire Citadel"] = "Meeting Stone of Hellfire Citadel"; -- Need translation

	--Karazhan (Entrance)
	["Archmage Leryda"] = "Archimaga Leryda";
	["Apprentice Darius"] = "Aprendiz Darius";
	["Archmage Alturus"] = "Archimago Alturus";
	["Stairs to Underground Pond"] = "Escaleras a Underground Pond";
	["Stairs to Underground Well"] = "Escaleras a Underground Well";
	["Charred Bone Fragment"] = "Trozo de hueso carbonizado";

	--Maraudon (Entrance)
	["The Nameless Prophet"] = "El profeta sin nombre";
	["Kolk <The First Kahn>"] = "Kolk <El Primer kahn>";
	["Gelk <The Second Kahn>"] = "Gelk <El Segundo kahn>";
	["Magra <The Third Kahn>"] = "Magra <El Tercer kahn>";
	["Cavindra"] = "Cavindra";

	--Scarlet Monastery (Entrance)
	--Nothing to translate!

	--The Deadmines (Entrance)
	["Marisa du'Paige"] = "Marisa du'Paige";
	["Brainwashed Noble"] = "Noble con lavado de cerebro";
	["Foreman Thistlenettle"] = "Supervisor Cardortiga";

	--Sunken Temple (Entrance)
	["Jade"] = "Jade";
	["Kazkaz the Unholy"] = "Kazkaz el Blasfemo";
	["Zekkis"] = "Zekkis";
	["Veyzhak the Cannibal"] = "Veyzhak el Caníbal";

	--Uldaman (Entrance)
	["Hammertoe Grez"] = "Grez Piemartillo";
	["Magregan Deepshadow"] = "Magregan Sombraprofunda";
	["Tablet of Ryun'Eh"] = "Tablilla de Ryun'Eh";
	["Krom Stoutarm's Chest"] = "Cofre de Krom Brazorrecio";
	["Garrett Family Chest"] = "Cofre de la familia Garrett";
	["Digmaster Shovelphlange"] = "Maestro de excavación Palatiro";

	--Wailing Caverns (Entrance)
	["Mad Magglish"] = "Loco Magglish";
	["Trigore the Lasher"] = "Trigore el Azotador";
	["Boahn <Druid of the Fang>"] = "Boahn <Druidas del colmillo>";
	["Above the Entrance:"] = "Sobre la Entrada:";
	["Ebru <Disciple of Naralex>"] = "Ebru <Discípula de Naralex>";
	["Nalpak <Disciple of Naralex>"] = "Nalpak <Discípulo de Naralex>";
	["Kalldan Felmoon <Specialist Leatherworking Supplies>"] = "Kalldan Lunavil <Suministros de peletería especializada>";
	["Waldor <Leatherworking Trainer>"] = "Waldor <Instructor de peletería>";

--************************************************
-- Kalimdor Instances (Classic)
--************************************************

	--Blackfathom Deeps
	["Ghamoo-ra"] = "Ghamoo-ra";
	["Lorgalis Manuscript"] = "Manuscrito de Lorgalis";
	["Lady Sarevess"] = "Lady Sarevess";
	["Argent Guard Thaelrid <The Argent Dawn>"] = "Guardia Argenta Thaelrid <El Alba Argenta>";
	["Gelihast"] = "Gelihast";
	["Shrine of Gelihast"] = "Santuario de Gelihast";
	["Lorgus Jett"] = "Lorgus Jett";
	["Fathom Stone"] = "Núcleo de las profundidades";
	["Baron Aquanis"] = "Barón Aquanis";
	["Twilight Lord Kelris"] = "Señor Crepuscular Kelris";
	["Old Serra'kis"] = "Viejo Serra'kis";
	["Aku'mai"] = "Aku'mai";
	["Morridune"] = "Morriduna";
	["Altar of the Deeps"] = "Altar de las profundidades";

	--Dire Maul (East)
	["Pusillin"] = "Pusillín";
	["Zevrim Thornhoof"] = "Zevrim Pezuñahendida";
	["Hydrospawn"] = "Hidromilecio";
	["Lethtendris"] = "Lethtendris";
	["Pimgib"] = "Pimgib";
	["Old Ironbark"] = "Viejo Cortezaférrea";
	["Alzzin the Wildshaper"] = "Alzzin el Formaferal";
	["Isalien"] = "Isalien";

	--Dire Maul (North)
	["Crescent Key"] = "Llave creciente";--omitted from Dire Maul (West)
	--"Library" omitted from here and DM West because of SM: "Library" duplicate
	["Guard Mol'dar"] = "Guardia Mol'dar";
	["Stomper Kreeg <The Drunk>"] = "Vapuleador Kreeg <El borracho>";
	["Guard Fengus"] = "Guardia Fengus";
	["Knot Thimblejack"] = "Knot Thimblejack";
	["Guard Slip'kik"] = "Guardia Slip'kik";
	["Captain Kromcrush"] = "Capitán Kromcrush";
	["King Gordok"] = "Rey Gordok";
	["Cho'Rush the Observer"] = "Cho'Rush el Observador";

	--Dire Maul (West)
	["J'eevee's Jar"] = "Jarra de J'eevee";
	["Pylons"] = "Pilones";
	["Shen'dralar Ancient"] = "Anciano Shen'dralar";
	["Tendris Warpwood"] = "Tendris Madeguerra";
	["Ancient Equine Spirit"] = "Antiguo espíritu equino";
	["Illyanna Ravenoak"] = "Illyanna Roblecuervo";
	["Ferra"] = "Ferra";
	["Magister Kalendris"] = "Magister Kalendris";
	["Tsu'zee"] = "Tsu'zee";
	["Immol'thar"] = "Immol'thar";
	["Lord Hel'nurath"] = "Lord Hel'nurath";
	["Prince Tortheldrin"] = "Príncipe Tortheldrin";
	["Falrin Treeshaper"] = "Falrin Tallarbol";
	["Lorekeeper Lydros"] = "Tradicionalista Lydros";
	["Lorekeeper Javon"] = "Tradicionalista Javon";
	["Lorekeeper Kildrath"] = "Tradicionalista Kildrath";
	["Lorekeeper Mykos"] = "Tradicionalista Mykos";
	["Shen'dralar Provisioner"] = "Proveedor Shen'dralar";
	["Skeletal Remains of Kariel Winthalus"] = "Restos de Kariel Winthalus";

	--Maraudon	
	["Scepter of Celebras"] = "Cetro de Celebras";
	["Veng <The Fifth Khan>"] = "Veng <El quinto Khan>";
	["Noxxion"] = "Noxxion";
	["Razorlash"] = "Lativaja";
	["Maraudos <The Fourth Khan>"] = "Maraudos <El cuarto Khan>";
	["Lord Vyletongue"] = "Lord Lenguavil";
	["Meshlok the Harvester"] = "Meshlok el Cosechador";
	["Celebras the Cursed"] = "Celebras el Maldito";
	["Landslide"] = "Derrumbio";
	["Tinkerer Gizlock"] = "Manitas Gizlock";
	["Rotgrip"] = "Escamapodrida";
	["Princess Theradras"] = "Princesa Theradras";
	["Elder Splitrock"] = "Ancestro Parterroca";


	--Ragefire Chasm
	["Maur Grimtotem"] = "Maur Totem Siniestro";
	["Oggleflint <Ragefire Chieftain>"] = "Ogglesílex <Jefe Furia Ardiente>";
	["Taragaman the Hungerer"] = "Taragaman el hambriento";
	["Jergosh the Invoker"] = "Jergosh el Convocador";
	["Zelemar the Wrathful"] = "Zelemar el Colérico";
	["Bazzalan"] = "Bazzalan";

	--Razorfen Downs
	["Tuten'kash"] = "Tuten'kash";
	["Henry Stern"] = "Henry Stern";
	["Belnistrasz"] = "Belnistrasz";
	["Sah'rhee"] = "Sah'rhee";
	["Mordresh Fire Eye"] = "Mordresh Ojo de Fuego";
	["Glutton"] = "Glotón";
	["Ragglesnout"] = "Morrandrajos";
	["Amnennar the Coldbringer"] = "Amnennar el Gélido";
	["Plaguemaw the Rotting"] = "Fauzpeste el Putrefacto";

	--Razorfen Kraul
	["Roogug"] = "Roogug";
	["Aggem Thorncurse <Death's Head Prophet>"] = "Aggem Malaespina <Profeta de los Caramuerte>";
	["Death Speaker Jargba <Death's Head Captain>"] = "Médium Jargba <Capitán Caramuerte>";
	["Overlord Ramtusk"] = "Señor Supremo Colmicarnero";
	["Razorfen Spearhide"] = "Cuerolanza de Rajacieno";
	["Agathelos the Raging"] = "Agathelos el Furioso";
	["Blind Hunter"] = "Cazador ciego";
	["Charlga Razorflank <The Crone>"] = "Charlga Filonavaja <La Bruja>";
	["Willix the Importer"] = "Willix el Importador";
	["Heralath Fallowbrook"] = "Heralath Arroyobarbecho";
	["Earthcaller Halmgar"] = "Clamor de Tierra Halmgar";

	--Ruins of Ahn'Qiraj
	["Cenarion Circle"] = "Círculo Cenarion";
	["Kurinnaxx"] = "Kurinnaxx";
	["Lieutenant General Andorov"] = "Teniente General Andorov";
	["Four Kaldorei Elites"] = "Cuatro Elites Kaldorei";
	["General Rajaxx"] = "General Rajaxx";
	["Captain Qeez"] = "Capitán Condurso";
	["Captain Tuubid"] = "Capitán Tuubid";
	["Captain Drenn"] = "Capitán Drenn";
	["Captain Xurrem"] = "Capitán Xurrem";
	["Major Yeggeth"] = "Mayor Yeggeth";
	["Major Pakkon"] = "Mayor Pakkon";
	["Colonel Zerran"] = "Coronel Zerran";
	["Moam"] = "Moam";
	["Buru the Gorger"] = "Buru el Manducador";
	["Ayamiss the Hunter"] = "Ayamiss el Cazador";
	["Ossirian the Unscarred"] = "Osiro el Sinmarcas";
	["Safe Room"] = "Habitación segura";

	--Temple of Ahn'Qiraj
	["Brood of Nozdormu"] = "Linaje de Nozdormu";
	["The Prophet Skeram"] = "El profeta Skeram";
	["The Bug Family"] = "La Familia Insecto";
	["Vem"] = "Vem";
	["Lord Kri"] = "Lord Kri";
	["Princess Yauj"] = "Princesa Yauj";
	["Battleguard Sartura"] = "Guardia de batalla Sartura";
	["Fankriss the Unyielding"] = "Fankriss el Implacable";
	["Viscidus"] = "Viscidus";
	["Princess Huhuran"] = "Princesa Huhuran";
	["Twin Emperors"] = "Los Emperadores Gemelos";
	["Emperor Vek'lor"] = "Emperador Vek'lor";
	["Emperor Vek'nilash"] = "Emperador Vek'nilash";
	["Ouro"] = "Ouro";
	["Eye of C'Thun"] = "Ojo de C'Thun";
	["C'Thun"] = "C'Thun";
	["Andorgos <Brood of Malygos>"] = "Andorgos <Camada de Malygos>";
	["Vethsera <Brood of Ysera>"] = "Vethsera <Camada de Ysera>";
	["Kandrostrasz <Brood of Alexstrasza>"] = "Kandrostrasz <Camada de Alexstrasza>";
	["Arygos"] = "Arygos";
	["Caelestrasz"] = "Caelestrasz";
	["Merithra of the Dream"] = "Merithra del Sueño";

	--Wailing Caverns
	["Disciple of Naralex"] = "Discípulo de Naralex";
	["Lord Cobrahn <Fanglord>"] = "Lord Cobrahn <Noble del Colmillo>";
	["Lady Anacondra <Fanglord>"] = "Lady Anacondra <Noble del Colmillo>";
	["Kresh"] = "Kresh";
	["Lord Pythas <Fanglord>"] = "Lord Pythas <Noble del Colmillo>";
	["Skum"] = "Skum";
	["Lord Serpentis <Fanglord>"] = "Lord Pythas <Noble del Colmillo>";
	["Verdan the Everliving"] = "Verdan el Eterno";
	["Mutanus the Devourer"] = "Mutanus el Devorador";
	["Naralex"] = "Naralex";
	["Deviate Faerie Dragon"] = "Dragón Férico descarriado";

	--Zul'Farrak
	["Antu'sul <Overseer of Sul>"] = "Antu'sul <Sobrestante de Sul>";
	["Theka the Martyr"] = "Theka el Mártir";
	["Witch Doctor Zum'rah"] = "Médico Brujo Zum'rah";
	["Zul'Farrak Dead Hero"] = "Héroe Muerto Zul'Farrak";
	["Nekrum Gutchewer"] = "Nekrum Cometripas";
	["Shadowpriest Sezz'ziz"] = "Sacerdote oscuro Sezz'ziz";
	["Dustwraith"] = "Ánima de Polvo";
	["Sergeant Bly"] = "Sargento Bly";
	["Weegli Blastfuse"] = "Weegli Plomofundido";
	["Murta Grimgut"] = "Murta Tripuriosa";
	["Raven"] = "Cuervo";
	["Oro Eyegouge"] = "Oro Bocojo";
	["Sandfury Executioner"] = "Ejecutor Furiarena";
	["Hydromancer Velratha"] = "Hidromántica Velratha";
	["Gahz'rilla"] = "Gahz'rilla";
	["Elder Wildmane"] = "Ancestro Barvacrín";
	["Chief Ukorz Sandscalp"] = "Jefe Ukorz Cabellarena";
	["Ruuzlu"] = "Ruuzlu";
	["Zerillis"] = "Zerillis";
	["Sandarr Dunereaver"] = "Sandarr Asaltadunas";

--****************************
-- Eastern Kingdoms Instances
--****************************

	--Blackrock Depths
	["Shadowforge Key"] = "Llave Forjatiniebla";
	["Prison Cell Key"] = "Llave de Celda de Prisión";
	["Jail Break!"] = "La fuga de la prisión";
	["Banner of Provocation"] = "Estandarte de Provocación";
	["Lord Roccor"] = "Lord Roccor";
	["Kharan Mighthammer"] = "Kharan Martillazo";
	["Commander Gor'shak <Kargath Expeditionary Force>"] = "Comandante Gor'shak <Fuerza Expedicionaria de Kargath>";
	["Marshal Windsor"] = "Alguacil Windsor";
	["High Interrogator Gerstahn <Twilight's Hammer Interrogator>"] = "Alta Interrogadora Gerstahn <Interrogadora del Martillo Crepuscular>";
	["Ring of Law"] = "Círculo de la Ley";
	["Anub'shiah"] = "Anub'shiah";
	["Eviscerator"] = "Eviscerador";
	["Gorosh the Dervish"] = "Gorosh el Endemoniado";
	["Grizzle"] = "Grisez";
	["Hedrum the Creeper"] = "Hedrum el Trepador";
	["Ok'thor the Breaker"] = "Ok'thor el Rompedor";
	["Theldren"] = "Theldren";
	["Lefty"] = "Lefty"; --FALTA
	["Malgen Longspear"] = "Malgen Longspear"; --FALTA
	["Gnashjaw <Malgen Longspear's Pet>"] = "Gnashjaw <Malgen Longspear's Pet>"; --FALTA
	["Rotfang"] = "Colmipútreo";
	["Va'jashni"] = "Va'jashni";
	["Houndmaster Grebmar"] = "Maestro de canes Grebmar";
	["Elder Morndeep"] = "Ancestro Alborhondo";
	["High Justice Grimstone"] = "Alto Justiciero Pedrasiniestra";
	["Monument of Franclorn Forgewright"] = "Monumento a Franclorn Forjador";
	["Pyromancer Loregrain"] = "Piromántico Cultugrano";
	["The Vault"] = "Cámara Negra";
	["Warder Stilgiss"] = "Guarda Stilgiss";
	["Verek"] = "Verek";
	["Watchman Doomgrip"] = "Vigía Presaletal";
	["Fineous Darkvire <Chief Architect>"] = "Finoso Virunegro <Arquitecto jefe>";
	["The Black Anvil"] = "El Yunquenegro";
	["Lord Incendius"] = "Lord Incendius";
	["Bael'Gar"] = "Bael'Gar";
	["Shadowforge Lock"] = "El candado de Forjatiniebla";
	["General Angerforge"] = "General Forjainquina";
	["Golem Lord Argelmach"] = "Señor Gólem Argelmach";
	["Field Repair Bot 74A"] = "Reparación de campo 74A";
	["The Grim Guzzler"] = "Tragapenas";
	["Hurley Blackbreath"] = "Hurley Negrálito";
	["Lokhtos Darkbargainer <The Thorium Brotherhood>"] = "Lokhtos Tratoscuro <La Hermandad del torio>";
	["Mistress Nagmara"] = "Maestra Nagmara";
	["Phalanx"] = "Falange";
	["Plugger Spazzring"] = "Plugger Aropatoso";
	["Private Rocknot"] = "Soldado Sinrroca";
	["Ribbly Screwspigot"] = "Ribbly Llavenrosca";
	["Coren Direbrew"] = "Coren Brebaje Temible";
	["Griz Gutshank <Arena Vendor>"] = "Griz Gutshank <Arena Vendor>"; --Fix
	["Ambassador Flamelash"] = "Embajador Latifuego";
	["Panzor the Invincible"] = "Panzor el Invencible";
	["Summoner's Tomb"] = "Tumba del Invocador";
	["The Lyceum"] = "El Liceo";
	["Magmus"] = "Magmus";
	["Emperor Dagran Thaurissan"] = "Emperador Dagran Thaurissan";
	["Princess Moira Bronzebeard <Princess of Ironforge>"] = "Princesa Moira Barbabronce <Princesa de Forjaz>";
	["High Priestess of Thaurissan"] = "Alta Sacerdotisa de Thaurissan";
	["The Black Forge"] = "La Forjanegra";
	["Core Fragment"] = "Trozo del Núcleo";
	["Overmaster Pyron"] = "Maestro Supremo Pyron";

	--Blackrock Spire (Lower)
	["Vaelan"] = "Vaelan";
	["Warosh <The Cursed>"] = "Warosh <El Maldito>";
	["Elder Stonefort"] = "Ancestro Petraforte";
	["Roughshod Pike"] = "Pica férrea";
	["Spirestone Butcher"] = "Carnicero Cumbrerroca";
	["Highlord Omokk"] = "Alto Señor Omokk";
	["Spirestone Battle Lord"] = "Señor de batalla Cumbrerroca";
	["Spirestone Lord Magus"] = "Señor Magus Cumbrerroca";
	["Shadow Hunter Vosh'gajin"] = "Cazador de las Sombras Vosh'gajin";
	["Fifth Mosh'aru Tablet"] = "Quinta tablilla Mosh'aru";
	["Bijou"] = "Bijou";
	["War Master Voone"] = "Maestro de guerra Voone";
	["Mor Grayhoof"] = "Mor Ruciapezuña";
	["Sixth Mosh'aru Tablet"] = "Sexta tablilla Mosh'aru";
	["Bijou's Belongings"] = "Pertenencias de Bijou";
	["Human Remains"] = "Restos humanos";
	["Unfired Plate Gauntlets"] = "Guanteletes de placas sin templar";
	["Bannok Grimaxe <Firebrand Legion Champion>"] = "Bannok Hachamacabra  <Legión Pirotigma>";
	["Mother Smolderweb"] = "Madre Telabrasada";
	["Crystal Fang"] = "Colmillor de Cristal";
	["Urok's Tribute Pile"] = "Pila de tributo a Urok";
	["Urok Doomhowl"] = "Urok Aullapocalipsis";
	["Quartermaster Zigris <Bloodaxe Legion>"] = "Intendente Zigris <Legión Hacha de Sangre>";
	["Halycon"] = "Halycon";
	["Gizrul the Slavener"] = "Gizrul el Esclavista";
	["Ghok Bashguud <Bloodaxe Champion>"] = "Ghok Bashguud <Campeón Hacha de Sangre>";
	["Overlord Wyrmthalak"] = "Señor Supremo Vermiothalak";
	["Burning Felguard"] = "Guarda vil ardiente";

	--Blackrock Spire (Upper)
	["Pyroguard Emberseer"] = "Piroguardián Brasadivino";
	["Solakar Flamewreath"] = "Solakar Corona de Fuego";
	["Father Flame"] = "Padre llama";
	["Darkstone Tablet"] = "Tablilla de Rocanegra";
	["Doomrigger's Coffer"] = "Broche de Equipasino";
	["Jed Runewatcher <Blackhand Legion>"] = "Jed Vigía de las runas <Legión Puño Negro>";
	["Goraluk Anvilcrack <Blackhand Legion Armorsmith>"] = "Goraluk Yunquegrieta <Forjador de armaduras de la Legión Puño Negro>";
	["Warchief Rend Blackhand"] = "Jefe de Guerra Rend Puño Negro";
	["Gyth <Rend Blackhand's Mount>"] = "Gyth <Montura de Rend Puño Negro>";
	["Awbee"] = "Awbee";
	["The Beast"] = "La Bestia";
	["Lord Valthalak"] = "Lord Valthalak";
	["Finkle Einhorn"] = "Finkle Unicornín";
	["General Drakkisath"] = "General Drakkisath";
	["Drakkisath's Brand"] = "El orbe de orden";

	--Blackwing Lair
	["Razorgore the Untamed"] = "Sangrevaja el Indomable";
	["Vaelastrasz the Corrupt"] = "Vaelastrasz el Corrupto";
	["Broodlord Lashlayer"] = "Señor de prole Capazote";
	["Firemaw"] = "Faucefogo";
	["Draconic for Dummies (Chapter VII)"] = "Dracónico para torpes (Capítulo VII)";
	["Master Elemental Shaper Krixix"] = "Maestro de los elementos Formacio Krixix";
	["Ebonroc"] = "Ebanorroca";
	["Flamegor"] = "Flamagor";
	["Chromaggus"] = "Chromaggus";
	["Nefarian"] = "Nefarian";

	--Gnomeregan
	["Workshop Key"] = "Llave de taller";
	["Blastmaster Emi Shortfuse"] = "Maestro Destructor Emi Plomocorto";
	["Grubbis"] = "Grubbis";
	["Chomper"] = "Mastic";
	["Clean Room"] = "Habitación limpia";
	["Tink Sprocketwhistle <Engineering Supplies>"] = "Tink Silbadentado <Suministros de ingeniería>";
	["The Sparklematic 5200"] = "El Destellamatic 5200";
	["Mail Box"] = "Buzón";
	["Kernobee"] = "Kernobee";
	["Alarm-a-bomb 2600"] = "Alarmabomba 2600";
	["Matrix Punchograph 3005-B"] = "Perforégrafo Matriz 3005-B";
	["Viscous Fallout"] = "Radiactivo viscoso";
	["Electrocutioner 6000"] = "Electrocutor 6000";
	["Matrix Punchograph 3005-C"] = "Perforégrafo Matriz 3005-C";
	["Crowd Pummeler 9-60"] = "Golpeamasa 9-60";
	["Matrix Punchograph 3005-D"] = "Perforégrafo Matriz 3005-D";
	["Dark Iron Ambassador"] = "Embajador Hierro Negro";
	["Mekgineer Thermaplugg"] = "Mekigeniero Termochufe";

	--Molten Core
	["Hydraxian Waterlords"] = "Srs. del Agua de Hydraxis";
	["Lucifron"] = "Lucifron";
	["Magmadar"] = "Magmadar";
	["Gehennas"] = "Gehennas";
	["Garr"] = "Garr";
	["Shazzrah"] = "Shazzrah";
	["Baron Geddon"] = "Barón Geddon";
	["Golemagg the Incinerator"] = "Golemagg el Incinerador";
	["Sulfuron Harbinger"] = "Sulfuron Presagista";
	["Majordomo Executus"] = "Mayordomo Executus";
	["Ragnaros"] = "Ragnaros";

	--Scholomance
	["Skeleton Key"] = "Llave esqueleto";
	["Viewing Room Key"] = "Llave de la Sala de visión";
	["Viewing Room"] = "Sala de visión";
	["Blood of Innocents"] = "Sangre de los Inocentes";	
	["Divination Scryer"] = "Cristal de adivinación";
	["Blood Steward of Kirtonos"] = "Administrador de sangre de Kirtonos";
	["The Deed to Southshore"] = "Las escrituras de Costasur";
	["Kirtonos the Herald"] = "Kirtonos el Heraldo";
	["Jandice Barov"] = "Jandice Barov";
	["The Deed to Tarren Mill"] = "Las escrituras de Molino Tarren";
	["Rattlegore"] = "Traquesangre";
	["Death Knight Darkreaver"] = "Caballero de la Muerte Atracoscuro";
	["Marduk Blackpool"] = "Marduz Pozonegro";
	["Vectus"] = "Vectus";
	["Ras Frostwhisper"] = "Ras Levescarcha";
	["The Deed to Brill"] = "Las escrituras de Rémol";
	["Kormok"] = "Kormok";
	["Instructor Malicia"] = "Instructora Malicia";
	["Doctor Theolen Krastinov <The Butcher>"] = "Doctor Theolen Krastinov <El Carnicero>";
	["Lorekeeper Polkelt"] = "Tradicionalista Polkelt";
	["The Ravenian"] = "El Devorador";
	["Lord Alexei Barov"] = "Lord Alexei Barov";
	["The Deed to Caer Darrow"] = "Las escrituras de Castel Darrow";
	["Lady Illucia Barov"] = "Lady Illucia Barov";
	["Darkmaster Gandling"] = "Maestro oscuro Gandling";
	["Torch Lever"] = "Antocha palanca";
	["Secret Chest"] = "Cofre secreto";
	["Alchemy Lab"] = "Laboratorio de alquimia";

	--Shadowfang Keep
	["Deathsworn Captain"] = "Capitán Juramorte";
	["Rethilgore <The Cell Keeper>"] = "Rethilgore <El Guardián de la celda>";
	["Sorcerer Ashcrombe"] = "Hechicero Ashcrombe";
	["Deathstalker Adamant"] = "Mortacechador Adamant";
	["Landen Stilwell"] = "Landen Fontana";
	["Investigator Fezzen Brasstacks"] = "Investigador Fezzen Arreolatón";
	["Deathstalker Vincent"] = "Mortacechador Vincent";
	["Apothecary Trio"] = "Trío de boticarios ";
	["Apothecary Hummel <Crown Chemical Co.>"] = "Boticario Hummel <Químicos La Corona, S.L.> ";
	["Apothecary Baxter <Crown Chemical Co.>"] = "Boticario Baxter <Químicos La Corona, S.L.>";
	["Apothecary Frye <Crown Chemical Co.>"] = "Boticario Frye <Químicos La Corona, S.L.>";
	["Fel Steed"] = "Corcel vil";
	["Jordan's Hammer"] = "Martillo de Jordan";
	["Crate of Ingots"] = "Cajón de lingotes";
	["Razorclaw the Butcher"] = "Zarpador el Carnicero";
	["Baron Silverlaine"] = "Barón Filargenta";
	["Commander Springvale"] = "Comandante Vallefont";
	["Odo the Blindwatcher"] = "Odo el vigía ciego";
	["Fenrus the Devourer"] = "Fenrus el Devorador";
	["Arugal's Voidwalker"] = "Abisario de Arugal";
	["The Book of Ur"] = "El libro de Ur";
	["Wolf Master Nandos"] = "Maestro de lobos Nandos";
	["Archmage Arugal"] = "Archimago Arugal";				

	--SM: Armory
	["The Scarlet Key"] = "La llave Escarlata";--omitted from SM: Cathedral
	["Herod <The Scarlet Champion>"] = "Herod <El Campeón Escarlata>";

	--SM: Cathedral
	["High Inquisitor Fairbanks"] = "Alto Inquisidor Ribalimpia";
	["Scarlet Commander Mograine"] = "Comandante Escarlata Mograine";
	["High Inquisitor Whitemane"] = "Alta Inquisidora Melenablanca";

	--SM: Graveyard
	["Interrogator Vishas"] = "Interrogador Vishas";
	["Vorrel Sengutz"] = "Vorrel Sengutz";
	["Pumpkin Shrine"] = "Calabaza Santuario";
	["Headless Horseman"] = "Jinete decapitado";
	["Bloodmage Thalnos"] = "Mago Sangriento Thalnos";
	["Ironspine"] = "Dosarcerado";
	["Azshir the Sleepless"] = "Azshir el Insomne";
	["Fallen Champion"] = "Campeón caído";

	--SM: Library
	["Houndmaster Loksey"] = "Maestro de canes Loksey";
	["Arcanist Doan"] = "Arcanista Doan";

	--Stratholme
	["The Scarlet Key"] = "La llave Escarlata";
	["Key to the City"] = "Llave de la ciudad";
	["Various Postbox Keys"] = "Varias llaves de los buzones";
	["Living Side"] = "Lado vivo";
	["Undead Side"] = "Lado no muerto";
	["Skul"] = "Skul";
	["Stratholme Courier"] = "Mensajero de Stratholme";
	["Fras Siabi"] = "Fras Siabi";
	["Atiesh <Hand of Sargeras>"] = "Atiesh <Mano de Sargeras>"; --Check
	["Hearthsinger Forresten"] = "Escupezones Foreste";
	["The Unforgiven"] = "El imperdonable";
	["Elder Farwhisper"] = "Elder Farwhisper"; --FALTA
	["Timmy the Cruel"] = "Timmy el Cruel";
	["Malor the Zealous"] = "Malor el Entusiasta";
	["Malor's Strongbox"] = "Caja fuerte de Malor";
	["Crimson Hammersmith"] = "Forjamartillos Carmesí";
	["Cannon Master Willey"] = "Cañonero Jefe Willey";
	["Archivist Galford"] = "Archivista Galford";
	["Grand Crusader Dathrohan"] = "Gran Cruzado Dathrohan";
	["Balnazzar"] = "Balnazzar";
	["Sothos"] = "Sothos";
	["Jarien"] = "Jarien";
	["Magistrate Barthilas"] = "Magistrado Barthilas";
	["Aurius"] = "Aurius";
	["Stonespine"] = "Pidrespina";
	["Baroness Anastari"] = "Baronesa Anastari";
	["Black Guard Swordsmith"] = "Armero Guardia Negra";
	["Nerub'enkan"] = "Nerub'enkan";
	["Maleki the Pallid"] = "Maleki el Pálido";
	["Ramstein the Gorger"] = "Ramstein el Empachador";
	["Baron Rivendare"] = "Barón Osahendido";
	["Ysida Harmon"] = "Ysida Harmon";
	["Crusaders' Square Postbox"] = "Buzón de la Plaza del Cruzado";
	["Market Row Postbox"] = "Buzón de la Fila del Mercado";
	["Festival Lane Postbox"] = "Buzón de la calle del Festival";
	["Elders' Square Postbox"] = "Buzón de la Plaza de los Ancianos";
	["King's Square Postbox"] = "Buzón de la Plaza del Rey";
	["Fras Siabi's Postbox"] = "Buzón de Fras Siabi";
	["3rd Box Opened"] = "Tercera Caja Abierta";
	["Postmaster Malown"] = "Jefe de correos Gassol";

	--The Deadmines
	["Rhahk'Zor <The Foreman>"] = "Rhahk'Zor <El Supervisor>";
	["Miner Johnson"] = "Minero Johnson";
	["Sneed <Lumbermaster>"] = "Sneed <Lumbermaster>";
	["Sneed's Shredder <Lumbermaster>"] = "Triturador de Sneed <Maestro leñador>";
	["Gilnid <The Smelter>"] = "Gilnid <El Fundidor>";
	["Defias Gunpowder"] = "Pólvora Defias";
	["Captain Greenskin"] = "Capitán Verdepel";
	["Edwin VanCleef <Defias Kingpin>"] = "Edwin VanCleef <Cerebro de los Defias>";
	["Mr. Smite <The Ship's First Mate>"] = "Don Mamporro <El contramaestre del barco>";
	["Cookie <The Ship's Cook>"] = "Cocinitas <El cocinero del barco>";

	--The Stockade
	["Targorr the Dread"] = "Targor el Pavoroso";
	["Kam Deepfury"] = "Kam Furiahonda";
	["Hamhock"] = "Hamhock";
	["Bazil Thredd"] = "Bazil Thredd";
	["Dextren Ward"] = "Dextren Ward";
	["Bruegal Ironknuckle"] = "Bruegal Nudoferro";

	--The Sunken Temple
	["The Temple of Atal'Hakkar"] = "Templo de Atal'Hakkar";
	["Yeh'kinya's Scroll"] = "Pergamino de Yeh'kinya";
	["Atal'ai Defenders"] = "Defensores Atal'ai";
	["Gasher"] = "Gasher";
	["Loro"] = "Loro";
	["Hukku"] = "Hukku";
	["Zolo"] = "Zolo";
	["Mijan"] = "Mijan";
	["Zul'Lor"] = "Zul'Lor";
	["Altar of Hakkar"] = "Altar de Hakkar";
	["Atal'alarion <Guardian of the Idol>"] = "Atal'alarion <Guardian of the Idol>";
	["Dreamscythe"] = "Guadañasueños";
	["Weaver"] = "Sastrón";
	["Avatar of Hakkar"] = "Avatar de Hakkar";
	["Jammal'an the Prophet"] = "Jammal'an el Profeta";
	["Ogom the Wretched"] = "Ogom el Desdichado";
	["Morphaz"] = "Morphaz";
	["Hazzas"] = "Hazzas";
	["Shade of Eranikus"] = "Sombra de Eranikus";
	["Essence Font"] = "Fuente de esencia";
	["Spawn of Hakkar"] = "Engendro de Hakkar";
	["Elder Starsong"] = "Ancestro Cantoestelar";
	["Statue Activation Order"] = "Orden de activación de estatuas";

	--Uldaman
	["Staff of Prehistoria"] = "Basón de Prehistoria";
	["Baelog"] = "Baelog";
	["Eric \"The Swift\""] = "Eric \"El Veloz\"";
	["Olaf"] = "Olaf";
	["Baelog's Chest"] = "El Cofre de Baelog";
	["Conspicuous Urn"] = "Urna llamativa";
	["Remains of a Paladin"] = "Restos de un paladín";
	["Revelosh"] = "Revelosh";
	["Ironaya"] = "Hierraya";
	["Obsidian Sentinel"] = "Centinela Obsidiano";
	["Annora <Enchanting Trainer>"] = "Annora <Maestro encantador>";
	["Ancient Stone Keeper"] = "Vigilante Pétreo Anciano";
	["Galgann Firehammer"] = "Galgann Flamartillo";
	["Tablet of Will"] = "Tablilla de Voluntad";
	["Shadowforge Cache"] = "Alijo de Forjatiniebla";
	["Grimlok <Stonevault Chieftain>"] = "Grimlok <Jefe Grutacanto>";
	["Archaedas <Ancient Stone Watcher>"] = "Archaedas <Vigía de piedra antiguo>";
	["The Discs of Norgannon"] = "Los Discos de Norgannon";
	["Ancient Treasure"] = "Tesoro Antiguo";

	--Zul'Gurub
	["Zandalar Tribe"] = "Tribu Zandalar";
	["Mudskunk Lure"] = "Mudskunk Lure";
	["Gurubashi Mojo Madness"] = "Locura de mojo Gurubashi";
	["High Priestess Jeklik"] = "Suma Sacerdotisa Jeklik";
	["High Priest Venoxis"] = "Sumo Sacerdote Venoxis";
	["Zanza the Restless"] = "Zanza el Incansable";
	["High Priestess Mar'li"] = "Suma Sacerdotisa Mar'li";
	["Bloodlord Mandokir"] = "Señor sangriento Mandokir";
	["Ohgan"] = "Ohgan";
	["Edge of Madness"] = "Blandón de la locura";
	["Gri'lek"] = "Gri'lek";
	["Hazza'rah"] = "Hazza'rah";
	["Renataki"] = "Renataki";
	["Wushoolay"] = "Wushoolay";
	["Gahz'ranka"] = "Gahz'ranka";
	["High Priest Thekal"] = "Sumo sacerdote Thekal";
	["Zealot Zath"] = "Zelote Zath";
	["Zealot Lor'Khan"] = "Zelote Lor'Khan";
	["High Priestess Arlokk"] = "Suma sacerdotisa Arlokk";
	["Jin'do the Hexxer"] = "Jin'do el Aojador";
	["Hakkar"] = "Hakkar";
	["Muddy Churning Waters"] = "Aguas Fangosas";

--*******************
-- Burning Crusade Instances
--*******************

	--Auch: Auchenai Crypts
	["Lower City"] = "Bajo Arrabal";--omitted from other Auch
	["Shirrak the Dead Watcher"] = "Shirrak el Vigía de los Muertos";
	["Exarch Maladaar"] = "Exarca Maladaar";
	["Avatar of the Martyred"] = "Avatar de los Martirizados";
	["D'ore"] = "D'ore";

	--Auch: Mana-Tombs
	["The Consortium"] = "El Consorcio";
	["Auchenai Key"] = "Llave Auchenai";--omitted from other Auch
	["The Eye of Haramad"] = "El ojo de Haramad";
	["Pandemonius"] = "Pandemonius";
	["Shadow Lord Xiraxis"] = "Señor de las Sombras Xiraxis";
	["Ambassador Pax'ivi"] = "Embajador Pax'ivi";
	["Tavarok"] = "Tavarok";
	["Cryo-Engineer Sha'heen"] = "Crioingeniero Sha'heen";
	["Ethereal Transporter Control Panel"] = "Panel de control del transportador etéreo";
	["Nexus-Prince Shaffar"] = "Príncipe-nexo Shaffar";
	["Yor <Void Hound of Shaffar>"] = "Yor <Can del vacío de Shaffar>";

	--Auch: Sethekk Halls
	["Essence-Infused Moonstone"] = "Piedra lunar imbuida de esencia";
	["Darkweaver Syth"] = "Tejeoscuro Syth";
	["Lakka"] = "Lakka";
	["The Saga of Terokk"] = "Esbirro de Terokk";
	["Anzu"] = "Anzu";
	["Talon King Ikiss"] = "Rey Garra Ikiss";

	--Auch: Shadow Labyrinth
	["Shadow Labyrinth Key"] = "Llave del Laberinto de las Sombras";
	["Spy To'gun"] = "Espía To'gun";
	["Ambassador Hellmaw"] = "Embajador Faucinferno";
	["Blackheart the Inciter"] = "Negrozón el Incitador";
	["Grandmaster Vorpil"] = "Maestro mayor Vorpil";
	["The Codex of Blood"] = "El Códice de Sangre";
	["Murmur"] = "Murmur";
	["First Fragment Guardian"] = "Guardián del Primer Fragmento";

	--Black Temple (Start)
	["Ashtongue Deathsworn"] = "Juramorte Lengua de Ceniza";--omitted from other BT
	["Towards Reliquary of Souls"] = "Hacia Relicario de Almas";
	["Towards Teron Gorefiend"] = "Hacia Teron Sanguino";
	["Towards Illidan Stormrage"] = "Hacia Illidan Tempestira";
	["Spirit of Olum"] = "Espíritu de Olum";
	["High Warlord Naj'entus"] = "Alto Señor de la Guerra Naj’entus";
	["Supremus"] = "Supremus";
	["Shade of Akama"] = "Sombra de Akama";
	["Spirit of Udalo"] = "Espíritu de Udalo";
	["Aluyen <Reagents>"] = "Aluyen <Vendedor de Componentes>";
	["Okuno <Ashtongue Deathsworn Quartermaster>"] = "Okuno <Provisiones Juramorte Lengua de ceniza>";
	["Seer Kanai"] = "Profeta Kanai";

	--Black Temple (Basement)
	["Gurtogg Bloodboil"] = "Gurtogg Sangre Hirviente";
	["Reliquary of Souls"] = "Relicario de Almas";
	["Essence of Suffering"] = "Esencia de Sufrimiento";
	["Essence of Desire"] = "Esencia de Deseo";
	["Essence of Anger"] = "Esencia de Cólera";
	["Teron Gorefiend"] = "Teron Sanguino";

	--Black Temple (Top)
	["Mother Shahraz"] = "Madre Shahraz";
	["The Illidari Council"] = "El Concilio Illidari";
	["Lady Malande"] = "Lady Malande";
	["Gathios the Shatterer"] = "Gathios el Despedazador";
	["High Nethermancer Zerevor"] = "Sumo abisálico Zerevor";
	["Veras Darkshadow"] = "Veras Sombra Oscura";
	["Illidan Stormrage <The Betrayer>"] = "Illidan Tempestira <El Traidor>";

	--CR: Serpentshrine Cavern
	["Hydross the Unstable <Duke of Currents>"] = "Hydross el Inestable <Hydross el Inestable>";
	["The Lurker Below"] = "El Rondador de abajo";
	["Leotheras the Blind"] = "Leotheras el Ciego";
	["Fathom-Lord Karathress"] = "Señor de la profundidades Karathress";
	["Seer Olum"] = "Profeta Olum";
	["Morogrim Tidewalker"] = "Morogrim Levantamareas";
	["Lady Vashj <Coilfang Matron>"] = "Lady Vashj <Matrona Colmillo Torcido>";

	--CR: The Slave Pens
	["Cenarion Expedition"] = "Excpedición Cenarion";--omitted from other CR
	["Reservoir Key"] = "Llave de dóposito";--omitted from other CR
	["Mennu the Betrayer"] = "Mennu el Traidor";
	["Weeder Greenthumb"] = "Desherbador Pulgaverde";
	["Skar'this the Heretic"] = "Skar'this el Herético";
	["Rokmar the Crackler"] = "Rokmar el Crujidor";
	["Naturalist Bite"] = "Naturalista Mordisco";
	["Quagmirran"] = "Quagmirran";
	["Ahune <The Frost Lord>"] = "Ahune <El Señor de la Escarcha>";

	--CR: The Steamvault
	["Hydromancer Thespia"] = "Hidromántico Thespia";
	["Main Chambers Access Panel"] = "Panel de acceso de la cámara principal";
	["Second Fragment Guardian"] = "Guardián del Segundo Fragmento";
	["Mekgineer Steamrigger"] = "Mekigeniero Vaporino";
	["Warlord Kalithresh"] = "Señor de la Guerra Kalithresh";

	--CR: The Underbog
	["Hungarfen"] = "Hungarfen";
	["The Underspore"] = "La Sotoespora";
	["Ghaz'an"] = "Ghaz'an";
	["Earthbinder Rayge"] = "Lingaterra Rayge";
	["Swamplord Musel'ek"] = "Señor del pantano Musel'ek";
	["Claw <Swamplord Musel'ek's Pet>"] = "Zarpa <Mascota del señor del pantano Musel'ek>";
	["The Black Stalker"] = "La acechadora negra";

	--CoT: The Black Morass
	["Opening of the Dark Portal"] = "Apertura del Portal Oscuro";
	["Keepers of Time"] = "Vigilantes del tiempo";--omitted from Old Hillsbrad Foothills
	["Key of Time"] = "Llave del tiempo";--omitted from Old Hillsbrad Foothills
	["Sa'at <Keepers of Time>"] = "Sa'at <Vigilantes del Tiempo>";
	["Chrono Lord Deja"] = "Chronolord Deja";
	["Temporus"] = "Temporus";
	["Aeonus"] = "Aeonus";
	["The Dark Portal"] = "El Portal Oscuro";
	["Medivh"] = "Medivh";

	--CoT: Hyjal Summit
	["Battle for Mount Hyjal"] = "Batalla por el Monte Hyjal";
	["The Scale of the Sands"] = "La Escama de las Arenas";
	["Alliance Base"] = "Base de la Alianza";
	["Lady Jaina Proudmoore"] = "Lady Jaina Valiente";
	["Horde Encampment"] = "Campamento de la Horda";
	["Thrall <Warchief>"] = "Thrall <Jefe de Guerra>";
	["Night Elf Village"] = "Pueblo de los Elfos de la Noche";
	["Tyrande Whisperwind <High Priestess of Elune>"] = "Tyrande Susurravientos <Suma sacerdotisa de Elune>";
	["Rage Winterchill"] = "Ira Fríoinvierno";
	["Anetheron"] = "Anetheron";
	["Kaz'rogal"] = "Kaz'rogal";
	["Azgalor"] = "Azgalor";
	["Archimonde"] = "Archimonde";
	["Indormi <Keeper of Ancient Gem Lore>"] = "Indormi <Vigilante de conocimiento de gemas antiguas>";
	["Tydormu <Keeper of Lost Artifacts>"] = "Tydormu <Vigilante de artefactos perdidos>";

	--CoT: Old Hillsbrad Foothills
	["Escape from Durnholde Keep"] = "Escape del Castillo de Durnholde";
	["Erozion"] = "Erozion";
	["Brazen"] = "Brazen";
	["Landing Spot"] = "Punto de Aterrizaje";
	["Lieutenant Drake"] = "Teniente Draco";
	["Thrall"] = "Thrall";
	["Captain Skarloc"] = "Capitán Skarloc";
	["Epoch Hunter"] = "Cazador de eras";
	["Taretha"] = "Taretha";
	["Jonathan Revah"] = "Jonathan Revah";
	["Jerry Carter"] = "Jerry Carter";
	["Traveling"] = "Viajando";
	["Thomas Yance <Travelling Salesman>"] = "Thomas Yance <Vendedor ambulante>";
	["Aged Dalaran Wizard"] = "Zhaorí Dalaran envejecido";
	["Kel'Thuzad <The Kirin Tor>"] = "Kel'Thuzad <Los Kirin Tor>";
	["Helcular"] = "Helcular";
	["Farmer Kent"] = "Granjero Kent";
	["Sally Whitemane"] = "Sally Melenablanca";
	["Renault Mograine"] = "Renault Mograine";
	["Little Jimmy Vishas"] = "Pequeño Jimmy Vishas";
	["Herod the Bully"] = "Herod el Matón";
	["Nat Pagle"] = "Nat Pagle";
	["Hal McAllister"] = "Hal McAllister";
	["Zixil <Aspiring Merchant>"] = "Zixil <Aspirante a mercader>";
	["Overwatch Mark 0 <Protector>"] = "Robovigilante Mark 0 <Protector>";
	["Southshore Inn"] = "Posada de Costasur";
	["Captain Edward Hanes"] = "Capitán Edward Hanes";
	["Captain Sanders"] = "Capitán Sanders";
	["Commander Mograine"] = "Comandante Mograine";
	["Isillien"] = "Isillien";
	["Abbendis"] = "Abbendis";
	["Fairbanks"] = "Ribalimpia";
	["Tirion Fordring"] = "Tirión Vardín";
	["Arcanist Doan"] = "Arcanista Doan";
	["Taelan"] = "Taelan";
	["Barkeep Kelly <Bartender>"] = "Posadero Kelly <Camarero>";
	["Frances Lin <Barmaid>"] = "Frances Lin <Camarera>";
	["Chef Jessen <Speciality Meat & Slop>"] = "Jefe Jessen <Especialidad en carne y bazofia>";
	["Stalvan Mistmantle"] = "Stalvan Mantoniebla";
	["Phin Odelic <The Kirin Tor>"] = "Phin Odelic <Los Kirin Tor>";
	["Magistrate Henry Maleb"] = "Magistrado Henry Maleb";
	["Raleigh the True"] = "Raleigh el Auténtico";
	["Nathanos Marris"] = "Nathanos Marris";
	["Bilger the Straight-laced"] = "Maestro cervecero Bilger";
	["Innkeeper Monica"] = "Tabernera Monica";
	["Julie Honeywell"] = "Julie Pozo de Miel";
	["Jay Lemieux"] = "Jay Lemieux";
	["Young Blanchy"] = "Joven Blanchy";
	["Don Carlos"] = "Don Carlos";
	["Guerrero"] = "Guerrero";

	--Gruul's Lair
	["High King Maulgar <Lord of the Ogres>"] = "Su majestad Maulgar <Señor de los ogros>";
	["Kiggler the Crazed"] = "Kiggler el Enloquecido";
	["Blindeye the Seer"] = "Ciego el Vidente";
	["Olm the Summoner"] = "Olm el Invocador";
	["Krosh Firehand"] = "Krosh Manofuego";
	["Gruul the Dragonkiller"] = "Gruul el Asesino de Dragones";

	--HFC: The Blood Furnace
	["Thrallmar"] = "Thrallmar";--omitted from other HFC
	["Honor Hold"] = "Bastión del Honor";--omitted from other HFC
	["Flamewrought Key"] = "Llave de Forjallamas";--omitted from other HFC
	["The Maker"] = "El Hacedor";
	["Broggok"] = "Broggok";
	["Keli'dan the Breaker"] = "Keli'dan el Ultrajador";

	--HFC: Hellfire Ramparts
	["Watchkeeper Gargolmar"] = "Guardián vigía Gargolmar";
	["Omor the Unscarred"] = "Omor el Sinmarcas";
	["Vazruden"] = "Vazruden el Heraldo";
	["Nazan <Vazruden's Mount>"] = "Nazan <Montura de Vazruden>";
	["Reinforced Fel Iron Chest"] = "Cofre de hierro vil reforzado";

	--HFC: Magtheridon's Lair
	["Magtheridon"] = "Magtheridon";

	--HFC: The Shattered Halls
	["Shattered Halls Key"] = "Llave de las Salas Arrasadas";
	["Randy Whizzlesprocket"] = "Randy Whizzlesprocket";
	["Drisella"] = "Drisella";
	["Grand Warlock Nethekurse"] = "Brujo supremo Malbisal";
	["Blood Guard Porung"] = "Guardia de sangre Mano Destrozada";
	["Warbringer O'mrogg"] = "Belisario O'mrogg";
	["Warchief Kargath Bladefist"] = "Jefe de Guerra Kargath Garrafilada";
	["Shattered Hand Executioner"] = "Ejecutor Mano Destrozada";
	["Private Jacint"] = "Soldado Jacint";
	["Rifleman Brownbeard"] = "Rifleman Brownbeard";
	["Captain Alina"] = "Capitán Alina";
	["Scout Orgarr"] = "Explorador Orgarr";
	["Korag Proudmane"] = "Korag Proudmane";
	["Captain Boneshatter"] = "Capitán Huesodestrozado";

	--Karazhan Start
	["The Violet Eye"] = "El Ojo Violeta";--omitted from Karazhan End
	["The Master's Key"] = "La llave del maestro";--omitted from Karazhan End
	["Staircase to the Ballroom"] = "Escaleras al Salón de baile";
	["Stairs to Upper Stable"] = "Escaleras al Establo superior";
	["Ramp to the Guest Chambers"] = "Rampa a Los aposentos de invitados";
	["Stairs to Opera House Orchestra Level"] = "Escaleras al nivel de la Opera";
	["Ramp from Mezzanine to Balcony"] = "Rampa desde Mezzanine al Balcón";
	["Connection to Master's Terrace"] = "Conexión con: El Bancal del Maestro";
	["Path to the Broken Stairs"] = "Camino a las Escaleras rotas"; --omitted from Karazhan End
	["Hastings <The Caretaker>"] = "Hastings <El Custodio>";
	["Servant Quarters"] = "Los sirvientes"; --Check
	["Hyakiss the Lurker"] = "Hyakiss el Rondador";
	["Rokad the Ravager"] = "Rokad el Devastador";
	["Shadikith the Glider"] = "Shadikith el Planeador";
	["Berthold <The Doorman>"] = "Berthold <El Portero>";
	["Calliard <The Nightman>"] = "Calliard <El Hombre de la noche>";
	["Attumen the Huntsman"] = "Attumen el Montero";
	["Midnight"] = "Medianoche";
	["Koren <The Blacksmith>"] = "Koren <El Herrero>";
	["Moroes <Tower Steward>"] = "Moroes <Administrador de la torre>";
	["Baroness Dorothea Millstipe"] = "Baronesa Dorothea Tallolino";
	["Lady Catriona Von'Indi"] = "Lady Catriona Von'Indi";
	["Lady Keira Berrybuck"] = "Lady Keira Bayadol";
	["Baron Rafe Dreuger"] = "Barón Rafe Dreuger";
	["Lord Robin Daris"] = "Lord Robin Daris";
	["Lord Crispin Ference"] = "Lord Crispin Ference";
	["Bennett <The Sergeant at Arms>"] = "Bennett <El Sargento de Armas>";
	["Ebonlocke <The Noble>"] = "Cerranegro <El Noble>";
	["Keanna's Log"] = "Apuntes de Keanna";
	["Maiden of Virtue"] = "Doncella de Virtud";
	["Sebastian <The Organist>"] = "Sebastian <El Organista>";
	["Barnes <The Stage Manager>"] = "Barnes <El Director de escena>";
	["The Opera Event"] = "Evento de la opera";
	["Red Riding Hood"] = "Caperucita Roja";
	["The Big Bad Wolf"] = "El Lobo Feroz";
	["Wizard of Oz"] = "El mago de Oz";
	["Dorothee"] = "Dorothea";
	["Tito"] = "Totó";
	["Strawman"] = "Espantapájaros";
	["Tinhead"] = "Hojalata";
	["Roar"] = "León";
	["The Crone"] = "La bruja";
	["Romulo and Julianne"] = "Romeo y Julieta";
	["Romulo"] = "Romeo";
	["Julianne"] = "Julieta";
	["The Master's Terrace"] = "El Bancal del Maestro";
	["Nightbane"] = "Nocturno";

	--Karazhan End
	["Broken Stairs"] = "Escaleras rotas";
	["Ramp to Guardian's Library"] = "Rampa a la Biblioteca del Guardián";
	["Suspicious Bookshelf"] = "Publicaciones sospechosas";
	["Ramp up to the Celestial Watch"] = "Subida a la Vista Celestial";
	["Ramp down to the Gamesman's Hall"] = "Bajada a la Sala de Juegos";
	["Chess Event"] = "Evento del Ajedrez";
	["Ramp to Medivh's Chamber"] = "Rampa a la Cámara de Medivh";
	["Spiral Stairs to Netherspace"] = "Escaleras de caracol a Rencor Abisal";
	["The Curator"] = "Curator";
	["Wravien <The Mage>"] = "Wravien <El Mago>";
	["Gradav <The Warlock>"] = "Gradav <El Brujo>";
	["Kamsis <The Conjurer>"] = "Kamsis <La Conjuradora>";
	["Terestian Illhoof"] = "Terestian Pezuña Enferma";
	["Kil'rek"] = "Kil'rek";
	["Shade of Aran"] = "Sombra de Aran";
	["Netherspite"] = "Rencor Abisal";
	["Ythyar"] = "Ythyar";
	["Echo of Medivh"] = "Eco de Medivh";
	["Dust Covered Chest"] = "Evento del Ajedrez";
	["Prince Malchezaar"] = "Príncipe Malchezaar";

	--Magisters Terrace
	["Shattered Sun Offensive"] = "Ofensiva del Sol Devastado";
	["Selin Fireheart"] = "Selin corazón de fuego";
	["Fel Crystals"] = "Cristales Viles";
	["Tyrith"] = "Tyrith";
	["Vexallus"] = "Vexallus";
	["Scrying Orb"] = "Orbe de visión";
	["Kalecgos"] = "Kalecgos";
	["Priestess Delrissa"] = "Sacerdotisa Delrissa";
	["Apoko"] = "Apoko";
	["Eramas Brightblaze"] = "Eramas Llamarada Brillante";
	["Ellrys Duskhallow"] = "Ellrys Anochecher Santificado";
	["Fizzle"] = "Fizel";
	["Garaxxas"] = "Garaxxas";
	["Sliver <Garaxxas' Pet>"] = "Tajada <Mascota de Garaxxas>";
	["Kagani Nightstrike"] = "Kajani Golpe de la Noche";
	["Warlord Salaris"] = "Señor de la Guerra Salaris";
	["Yazzai"] = "Yazzai";
	["Zelfan"] = "Zelfan";	
	["Kael'thas Sunstrider <Lord of the Blood Elves>"] = "Kael’thas Caminante del Sol <Señor de los elfos de sangre>";

	--Sunwell Plateau
	["Sathrovarr the Corruptor"] = "Sathrovarr el Corruptor";
	["Madrigosa"] = "Madrigosa";
	["Brutallus"] = "Brutallus"; --FALTA
	["Felmyst"] = "Brumavil";
	["Eredar Twins"] = "Gemelas Eredar";
	["Grand Warlock Alythess"] = "Gran Brujo Alythess"; --Check
	["Lady Sacrolash"] = "Lady Sacrolash"; --FALTA
	["M'uru"] = "M'uru";
	["Entropius"] = "Entropius"; --FALTA
	["Kil'jaeden <The Deceiver>"] = "Kil'jaeden <The Deceiver>"; --FALTA

	--TK: The Arcatraz
	["Key to the Arcatraz"] = "Llave de El Arcatraz";
	["Zereketh the Unbound"] = "Zereketh el Desatado";
	["Third Fragment Guardian"] = "Guardián del Tercer Fragmento";
	["Dalliah the Doomsayer"] = "Dalliah la Decidora del Destino";
	["Wrath-Scryer Soccothrates"] = "Arúspice de cólera Soccothrates";
	["Udalo"] = "Udalo";
	["Harbinger Skyriss"] = "Presagista Cieloriss";
	["Warden Mellichar"] = "Celador Mellichar";
	["Millhouse Manastorm"] = "Molino Tormenta de maná";

	--TK: The Botanica
	["The Sha'tar"] = "Los Sha'tar";--omitted from other TK
	["Warpforged Key"] = "Llave forjada de distorsión";--omitted from other TK
	["Commander Sarannis"] = "Comandante Sarannis";
	["High Botanist Freywinn"] = "Gran Botánico Freywinn";
	["Thorngrin the Tender"] = "Thorngrin el Tierno";
	["Laj"] = "Laj";
	["Warp Splinter"] = "Disidente de distorsión";

	--TK: The Mechanar
	["Gatewatcher Gyro-Kill"] = "Vigía de las puertas Giromata";
	["Gatewatcher Iron-Hand"] = "Vigía de las puertas Manoyerro";
	["Cache of the Legion"] = "Alijo de la Legión";
	["Mechano-Lord Capacitus"] = "Lord-mecano Capacitus";
	["Overcharged Manacell"] = "Célula de maná sobrecargada";
	["Nethermancer Sepethrea"] = "Abisálica Sepethrea";
	["Pathaleon the Calculator"] = "Pathaleon el Calculator";

	--TK: The Eye
	["Al'ar <Phoenix God>"] = "Al'ar <Dios Fénix>";
	["Void Reaver"] = "Atracador del vacío";
	["High Astromancer Solarian"] = "Gran astromántico Solarian";
	["Thaladred the Darkener <Advisor to Kael'thas>"] = "Thaladred el Ensombrecedor <Consejero de Kael'thas>";
	["Master Engineer Telonicus <Advisor to Kael'thas>"] = "Maestro ingeniero Telonicus <Consejero de Kael'thas>";
	["Grand Astromancer Capernian <Advisor to Kael'thas>"] = "Gran astromántica Capernian <Consejera de Kael'thas>";
	["Lord Sanguinar <The Blood Hammer>"] = "Lord Sanguinar <Martillo de Sangre>";

	--Zul'Aman
	["Harrison Jones"] = "Harrison Jones";
	["Nalorakk <Bear Avatar>"] = "Nalorakk <Avatar de oso>";
	["Tanzar"] = "Tanzar";
	["The Map of Zul'Aman"] = "Mapa de Zul'Aman de Budd";
	["Akil'Zon <Eagle Avatar>"] = "Akil'Zon <Avatar de águila>";
	["Harkor"] = "Harkor";
	["Jan'Alai <Dragonhawk Avatar>"] = "Jan'Alai <Avatar de dracohalcón>";
	["Kraz"] = "Kraz";
	["Halazzi <Lynx Avatar>"] = "Halazzi <Avatar de lince>";
	["Ashli"] = "Ashli";
	["Zungam"] = "Zungam";
	["Hex Lord Malacrass"] = "Señor aojador Malacrass";
	["Thurg"] = "Thurg";
	["Gazakroth"] = "Gazakroth";
	["Lord Raadan"] = "Lord Raadan";
	["Darkheart"] = "Corazón Oscuro";
	["Alyson Antille"] = "Alyson Antille";
	["Slither"] = "Slither";
	["Fenstalker"] = "Fenstalker";
	["Koragg"] = "Koragg";
	["Zul'jin"] = "Zul'jin";
	["Forest Frogs"] = "Ranas del bosque";
	["Kyren <Reagents>"] = "Kyren <Componentes>";
	["Gunter <Food Vendor>"] = "Gunter <Vendedor de comida>";
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
	["Elder Nadox"] = "Ancestro Nadox";
	["Prince Taldaram"] = "Príncipe Taldaram";
	["Jedoga Shadowseeker"] = "Jedoga Buscasombras";
	["Herald Volazj"] = "Heraldo Volazj";
	["Amanitar"] = "Amanitar";
	["Ahn'kahet Brazier"] = "Blandón Ahn'kahet"; --Check

	--Azjol-Nerub: Azjol-Nerub
	["Krik'thir the Gatewatcher"] = "Krik'thir el vigía de las puertas";
	["Watcher Gashra"] = "Vigía Gashra";
	["Watcher Narjil"] = "Vigía Narjil";
	["Watcher Silthik"] = "Vigía Silthik";
	["Hadronox"] = "Hadronox";
	["Elder Nurgen"] = "Ancestro Nurgen";
	["Anub'arak"] = "Anub'arak";

	--Caverns of Time: The Culling of Stratholme
	["The Culling of Stratholme"] = "La Matanza de Stratholme";
	["Meathook"] = "Gancho";
	["Salramm the Fleshcrafter"] = "Salramm el Modelador de carne";
	["Chrono-Lord Epoch"] = "Cronolord Época";
	["Mal'Ganis"] = "Mal'Ganis";
	["Chromie"] = "Cromi";
	["Infinite Corruptor"] = "Corruptor Infinito";
	["Guardian of Time"] = "Guardián del Tiempo";
	["Scourge Invasion Points"] = "Puntos Invasión de la Plaga";

	--Drak'Tharon Keep
	["Trollgore"] = "Cuernotrol";
	["Novos the Summoner"] = "Novos el Invocador";
	["Elder Kilias"] = "Ancestro Kilias";
	["King Dred"] = "Rey Dred";
	["The Prophet Tharon'ja"] = "El profeta Tharon'ja";
	["Kurzel"] = "Kurzel";
	["Drakuru's Brazier"] = "El blandón de Drakuru"; --Check

	--The Frozen Halls: Halls of Reflection
	--3 beginning NPCs omitted, see The Forge of Souls
	["Falric"] = "Falric";
	["Marwyn"] = "Marwyn";
	["Wrath of the Lich King"] = "El Rey Exánime";
	["The Captain's Chest"] = "El cofre del Capitán";

	--The Frozen Halls: Pit of Saron
	--6 beginning NPCs omitted, see The Forge of Souls
	["Forgemaster Garfrost"] = "Maestro de forja Gargelus";
	["Martin Victus"] = "Martin Victus"; --Check
	["Gorkun Ironskull"] = "Gorkun Testahierro";
	["Krick and Ick"] = "Puagh y Agh";
	["Scourgelord Tyrannus"] = "Señor de la Plaga Tyrannus";
	["Rimefang"] = "Dientefrío";

	--The Frozen Halls: The Forge of Souls
	--Lady Jaina Proudmoore omitted, in Hyjal Summit
	["Archmage Koreln <Kirin Tor>"] = "Archimago Koreln <Kirin Tor>";
	["Archmage Elandra <Kirin Tor>"] = "Archimaga Elandra <Kirin Tor>";
	["Lady Sylvanas Windrunner <Banshee Queen>"] = "Lady Sylvanas Brisaveloz <Reina alma en pena>";
	["Dark Ranger Loralen"] = "Forestal oscura Loralen";
	["Dark Ranger Kalira"] = "Forestal oscura Kalira";
	["Bronjahm <Godfather of Souls>"] = "Bronjahm <Padrino de almas>";
	["Devourer of Souls"] = "Devoraalmas";

	--Gundrak
	["Slad'ran <High Prophet of Sseratus>"] = "Slad'ran <Sumo profeta de Sseratus>";
	["Drakkari Colossus"] = "Coloso Drakkari";
	["Elder Ohanzee"] = "Ancestro Ohanzee";
	["Moorabi <High Prophet of Mam'toth>"] = "Moorabi <Sumo profeta de Mam'toth>";
	["Gal'darah <High Prophet of Akali>"] = "Gal'darah <Sumo profeta de Akali>";
	["Eck the Ferocious"] = "Eck el Feroz";

	--Icecrown Citadel
	["The Ashen Verdict"] = "El Veredicto Cinéreo";
	["Lord Marrowgar"] = "Lord Tuétano";
	["Lady Deathwhisper"] = "Lady Susurramuerte";
	["Gunship Battle"] = "Arsenal de la nave de guerra";
	["Deathbringer Saurfang"] = "Libramorte Colmillosauro";
	["Festergut"] = "Panzachancro";
	["Rotface"] = "Carapútrea";
	["Professor Putricide"] = "Profesor Putricidio";
	["Blood Prince Council"] = "Concilio de los príncipes de sangre"; --Check
	["Prince Keleseth"] = "Príncipe Keleseth";
	["Prince Taldaram"] = "Príncipe Taldaram";
	["Prince Valanar"] = "Príncipe Valanar";
	["Blood-Queen Lana'thel"] = "Reina de Sangre Lana'thel";
	["Valithria Dreamwalker"] = "Valithria Caminasueños";
	["Sindragosa <Queen of the Frostbrood>"] = "Sindragosa <Reina de los Razaescarcha>";
	["The Lich King"] = "El Rey Éxanime";
	["To next map"] = "Al siguiente mapa";
	["From previous map"] = "Desde mapa anterior";
	["Upper Spire"] = "Aguja Superior";
	["Sindragosa's Lair"] = "Guarida de Sindragosa";

	--Naxxramas
	["Mr. Bigglesworth"] = "Sr. Biguelvalor";
	["Patchwerk"] = "Remendejo";
	["Grobbulus"] = "Grobbulus";
	["Gluth"] = "Gluth";
	["Thaddius"] = "Thaddius";
	["Anub'Rekhan"] = "Anub'Rekhan";
	["Grand Widow Faerlina"] = "Gran Viuda Faerlina";
	["Maexxna"] = "Maexxna";
	["Instructor Razuvious"] = "Instructor Razuvious";
	["Gothik the Harvester"] = "Gothik el Cosechador";
	["The Four Horsemen"] = "Los cuatro Caballoshombre";
	["Thane Korth'azz"] = "Señor feudal Korth'azz";
	["Lady Blaumeux"] = "Lady Blaumeux";
	--Baron Rivendare omitted, listed under Stratholme
	["Sir Zeliek"] = "Sir Zeliek";
	["Four Horsemen Chest"] = "Cofre de los cuatro jinetes";
	["Noth the Plaguebringer"] = "Noth el Pesteador";
	["Heigan the Unclean"] = "Heigan el Impuro";
	["Loatheb"] = "Loatheb";
	["Frostwyrm Lair"] = "Guarida Vermis de Escarcha"; --Check
	["Sapphiron"] = "Sapphiron";
	["Kel'Thuzad"] = "Kel'Thuzad";

	--The Obsidian Sanctum
	["Black Dragonflight Chamber"] = "Cámara del vuelo Negro"; --Check
	["Sartharion <The Onyx Guardian>"] = "Sartharion <El Guardíán Onyx>"; --Check
	["Tenebron"] = "Tenebron";
	["Shadron"] = "Shadron";
	["Vesperon"] = "Vesperon";

	--Onyxia's Lair
	["Onyxian Warders"] = "Guardas de Onyxia";
	["Whelp Eggs"] = "Huevos de crías";
	["Onyxia"] = "Onyxia";

	--The Ruby Sanctum
	["Red Dragonflight Chamber"] = "La cámara del Vuelo de Dragones Rojo";
	["Baltharus the Warborn"] = "Baltharus el Batallante";
	["Saviana Ragefire"] = "Saviana Furia Ardiente";
	["General Zarithrian"] = "General Zarithrian";
	["Halion <The Twilight Destroyer>"] = "Halion el Destructor Crepuscular";

	--The Nexus: The Eye of Eternity
	["Malygos"] = "Malygos";
	["Key to the Focusing Iris"] = "Llave del Iris de enfoque";	

	--The Nexus: The Nexus
	["Berinand's Research"] = "Investigación de Berinand";
	["Commander Stoutbeard"] = "Comandante Barbarrecia";
	["Commander Kolurg"] = "Comandante Kolurg";
	["Grand Magus Telestra"] = "Gran Maga Telestra";
	["Anomalus"] = "Anomalus";
	["Elder Igasho"] = "Ancestro Igasho";
	["Ormorok the Tree-Shaper"] = "Ormorok el Cortador de árboles";
	["Keristrasza"] = "Keristrasza";

	--The Nexus: The Oculus
	["Drakos the Interrogator"] = "Drakos el interrogador";
	["Mage-Lord Urom"] = "Señor de la Magia Urom";
	["Ley-Guardian Eregos"] = "Guardián-Ley Eregos";
	["Varos Cloudstrider <Azure-Lord of the Blue Dragonflight>"] = "Varos Zancanubes <Lord Azur del Vuelo Azul>";
	["Centrifuge Construct"] = "Ensamblaje de centrifugadora";
	["Cache of Eregos"] = "Alijo de Eregos";

	--Trial of the Champion
	["Grand Champions"] = "Grandes campeones";
	["Champions of the Alliance"] = "Campeones de la Alianza";
	["Marshal Jacob Alerius"] = "Mariscal Jacob Alerius";
	["Ambrose Boltspark"] = "Ambrose Chisparrayo";
	["Colosos"] = "Colosos";
	["Jaelyne Evensong"] = "Jaelyne Unicanto";
	["Lana Stouthammer"] = "Lana Martillotenaz";
	["Champions of the Horde"] = "Campeones de la Horda";
	["Mokra the Skullcrusher"] = "Mokra el Trituracráneos";
	["Eressea Dawnsinger"] = "Eressea Cantoalba";
	["Runok Wildmane"] = "Runok Ferocrín";
	["Zul'tore"] = "Zul'tore";
	["Deathstalker Visceri"] = "Mortacechador Visceri";
	["Eadric the Pure <Grand Champion of the Argent Crusade>"] = "Eadric el Puro <Gran Campeón de la Cruzada Argenta>";
	["Argent Confessor Paletress"] = "Confesora Argenta Cabelloclaro";
	["The Black Knight"] = "El Caballero Negro";

	--Trial of the Crusader
	["Cavern Entrance"] = "Entrada a la caverna";
	["Northrend Beasts"] = "Bestias de Rasganorte";
	["Gormok the Impaler"] = "Gormok el Empalador";
	["Acidmaw"] = "Fauceácida";
	["Dreadscale"] = "Aterraescama";
	["Icehowl"] = "Aullahielo";
	["Lord Jaraxxus"] = "Lord Jaraxxus";
	["Faction Champions"] = "Campeones de la facción";
	["Twin Val'kyr"] = "Gemelas Val'kyr";
	["Fjola Lightbane"] = "Fjola Penívea";
	["Eydis Darkbane"] = "Eydis Penaumbra";
	["Anub'arak"] = "Anub'arak";
	["Heroic: Trial of the Grand Crusader"] = "Heróica: Prueba del Gran Cruzado";

	-- Ulduar General
	["Celestial Planetarium Key"] = "Llave del Planetario Celestial"; --Check
	["The Siege"] = "El asedio"; --Check
	["The Keepers"] = "Los vigilantes"; --C Check

	-- Ulduar A
	["Flame Leviathan"] = "Leviatán de llamas";
	["Ignis the Furnace Master"] = "Ignis el Maestro de la Caldera";
	["Razorscale"] = "Tajoescama";
	["XT-002 Deconstructor"] = "Desarmador XA-002";
	["Tower of Life"] = "Torre de Vida";
	["Tower of Flame"] = "Torre de Llamas";
	["Tower of Frost"] = "Torre de Escarcha";
	["Tower of Storms"] = "Torre de Tormentas";

	-- Ulduar B
	["Assembly of Iron"] = "Asamblea de Hierro";
	["Steelbreaker"] = "Rompeacero";
	["Runemaster Molgeim"] = "Maestro de runas Molgeim";
	["Stormcaller Brundir"] = "Clamatormentas Brundir";
	["Kologarn"] = "Kologarn";
	["Algalon the Observer"] = "Algalon el Observador";
	["Prospector Doren"] = "Prospector Doren";
	["Archivum Console"] = "Consola de El Archivum";

	-- Ulduar C
	["Auriaya"] = "Auriaya";
	["Freya"] = "Don de Freya";
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
	["Elder Yurauk"] = "Ancestro Yurauk";
	["Krystallus"] = "Krystallus";
	["Maiden of Grief"] = "Doncella de Pena";
	["Brann Bronzebeard"] = "Brann Barbabronce";
	["Tribunal Chest"] = "Cofre del tribunal";
	["Sjonnir the Ironshaper"] = "Sjonnir el Afilador";

	--Utgarde Keep: Utgarde Keep
	["Dark Ranger Marrah"] = "Forestal oscura Marrah";
	["Prince Keleseth <The San'layn>"] = "Príncipe Keleseth <Los San'layn>";
	["Elder Jarten"] = "Ancestro Jarten";
	["Dalronn the Controller"] = "Dalronn el Controlador";
	["Skarvald the Constructor"] = "Skarvald el Constructor";
	["Ingvar the Plunderer"] = "Ingvar el Desvalijador";	

	--Utgarde Keep: Utgarde Pinnacle
	["Brigg Smallshanks"] = "Brigg Espinillas";
	["Svala Sorrowgrave"] = "Svala Tumbapena";
	["Gortok Palehoof"] = "Gortok Pezuña Pálida";
	["Skadi the Ruthless"] = "Skadi el Despiadado";
	["Elder Chogan'gada"] = "Ancestro Chogan'gada";
	["King Ymiron"] = "Rey Ymiron";

	--Vault of Archavon
	["Archavon the Stone Watcher"] = "Archavon el Vigía de piedra";
	["Emalon the Storm Watcher"] = "Emalon el Vigía de piedra";
	["Koralon the Flame Watcher"] = "Koralon el Vigía de las llamas";
	["Toravon the Ice Watcher"] = "Toravon el Vigía de Hielo";
	
	--The Violet Hold
	["Erekem"] = "Erekem";
	["Zuramat the Obliterator"] = "Zuramat el Obliterador";
	["Xevozz"] = "Xevozz";
	["Ichoron"] = "Ícoron";
	["Moragg"] = "Moragg";
	["Lavanthor"] = "Lavanthor";
	["Cyanigosa"] = "Cianigosa";
	["The Violet Hold Key"] = "Llave de El Bastión Violeta";

};
end