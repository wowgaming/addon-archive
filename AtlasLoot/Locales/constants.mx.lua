--[[
constants.es.lua --- Traduction ES por maqjav
This file defines an AceLocale table for all the various text strings needed
by AtlasLoot.  In this implementation, if a translation is missing, it will fall
back to the English translation.


]]




--Create the library instance
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");

local AL = AceLocale:NewLocale("AtlasLoot", "esMX", false);

if AL then
	--Text strings for UI objects
	--AL["AtlasLoot"] = true,
	AL["No match found for"] = "No se ha encontrado ninguna coincidencia";
	AL["Search"] = "Buscar";
	AL["Clear"] = "Limpiar";
	AL["Select Loot Table"] = "Selecciona tabla";
	AL["Select Sub-Table"] = "Selecciona subtabla";
	AL["Drop Rate: "] = "Prob. de conseguirse: ";
	--AL["DKP"] = true,
	AL["Priority:"] = "Prioridad:";
	AL["Click boss name to view loot."] = "Haz click sobre el nombre del jefe para ver el botín.";
	AL["Various Locations"] = "Se obtiene en diferentes sitios";
	AL["This is a loot browser only.  To view maps as well, install either Atlas or Alphamap."] = "Esto es tan solo un buscador de botines. Para ver el mapa instala el Atlas o Alphamap";
	AL["Toggle AL Panel"] = "Panel AtlasLoot";
	AL[" is safe."] = " es válido.";
	AL["Server queried for "] = "Preguntando al servidor por ";
	AL[".  Right click on any other item to refresh the loot page."] = ".  Haz click-dcho en otro objeto para refrescar la página.";
	AL["Back"] = "Atrás";
	AL["Level 60"] = "Nivel 60";
	AL["Level 70"] = "Nivel 70";
	AL["Level 80"] = "Nivel 80";
	AL["|cffff0000(unsafe)"] = " |cffff0000(no seguro)";
	AL["Misc"] = "Misc.";
	AL["Miscellaneous"] = "Misceláneo";
	AL["Rewards"] = "Recompensas";
	AL["Heroic Mode"] = "Modo heróico";
	AL["Normal Mode"] = "Modo normal";
	AL["Hard Mode"] = "Modo dificil";
	AL["Show 10 Man Loot"] = "Muestra 10 Pers. Botín";
	AL["Show 25 Man Loot"] = "Muestra 25 Pers. Botín";
	AL["10 Man"] = "10 pers.";
	AL["25 Man"] = "25 pers.";	
	AL["Raid"] = "Banda";
	AL["Factions - Original WoW"] = "Facciones - WoW Original";
	AL["Factions - Burning Crusade"] = "Facciones - Burning Crusade";
	AL["Factions - Wrath of the Lich King"] = "Facciones - Wrath of the Lich King";
	AL["Choose Table ..."] = "Elige una tabla...";
	AL["Close Menu"] = "Cerrar menú";
	AL["Unknown"] = "Desconocido";
	AL["Skill Required:"] = "Habilidad necesaria";
	AL["QuickLook"] = "VistaRápida";
	AL["Add to QuickLooks:"] = "Añade a VistaRápida";
	AL["Rating:"] = "Indice:";	--Shorthand for 'Required Rating' for the personal/team ratings in Arena S4 
	AL["Query Server"] = "Pregun. Servidor";
	AL["Classic Instances"] = "Mazmorras clásicas";
	AL["BC Instances"] = "Mazmorras BC";
	AL["WotLK Instances"] = "Mazmorras WotLK";
	AL["Original WoW"] = "WoW Original";	
	--AL["Burning Crusade"] = true,
	AL["Entrance"] = "Entrada";
	AL["Original Factions"] = "Facciones originales";
	AL["BC Factions"] = "Facciones BC";
	AL["WotLK Factions"] = "Facciones WotLK";
	AL["Reset Frames"] = "Restaurar marcos";
	AL["Reset Wishlist"] = "Res. ListaDeseada";
	AL["Reset Quicklooks"] = "Res. BotínRápido";
	AL["Select a Loot Table..."] = "Elige una tabla de Botín...";
	AL["OR"] = "O";
	--AL["Wrath of the Lich King"] = true,
	AL["FuBar Options"] = "Opciones FuBar";
	AL["Attach to Minimap"] = "Sujetar al minimapa";
	AL["Hide FuBar Plugin"] = "Esconder FuBar Plugin";
	AL["Show FuBar Plugin"] = "Mostrar FuBar Plugin"; 
	AL["Position:"] = "Posición:";
	AL["Left"] = "Izquierda";
	AL["Center"] = "Centro";
	AL["Right"] = "Derecha";
	AL["Hide Text"] = "Esconder Texto";
	AL["Hide Icon"] = "Esconder Icono";
	AL["Minimap Button Options"] = "Opciones botón minimapa";
	AL["Bonus Loot"] = "Bonus Botín";
	AL["Three Drakes Left"] = "Quedan tres dracos";
	AL["Two Drakes Left"] = "Quedan dos dracos";
	AL["One Drake Left"] = "Queda un draco";
	
	--Text for Options Panel
	AL["Atlasloot Options"] = "Opciones Atlasloot";
	AL["Safe Chat Links"] = "Enlaces seguros en el chat";
	AL["Default Tooltips"] = "Bocadillos texto predet.";
	AL["Lootlink Tooltips"] = "Bocadillos enlaces de botín";
	AL["|cff9d9d9dLootlink Tooltips|r"] = "|cff9d9d9dBocadillos enlaces de botín";
	AL["ItemSync Tooltips"] = "Bocadillos sincronismo de objetos";
	AL["|cff9d9d9dItemSync Tooltips|r"] = "|cff9d9d9dBocadillos de sincronismo de objetos";
	AL["Use EquipCompare"] = "Utilizar EquipCompare";
	AL["|cff9d9d9dUse EquipCompare|r"] = "|cff9d9d9dUtilizar EquipCompare";
	AL["Show Comparison Tooltips"] = "Mostrar bocadillos de comparación";
	AL["Make Loot Table Opaque"] = "Hacer opaca tabla botines";
	AL["Show itemIDs at all times"] = "Mostrar el ID objetos";
	AL["Hide AtlasLoot Panel"] = "Esconder panel de AtlasLoot";
	AL["Show Basic Minimap Button"] = "Mostrar botón básico en el mini mapa";
	AL["|cff9d9d9dShow Basic Minimap Button|r"] = "|cff9d9d9dMostrar botón de Minimapa básico|r";
	AL["Set Minimap Button Position"] = "Elegir la posición del botón del mini mapa";
	AL["Suppress Item Query Text"] = "Suprimir texto petición objetos";
	AL["Notify on LoD Module Load"] = "Notificar al cargar un módulo";
	AL["Load Loot Modules at Startup"] = "Cargar módulos al iniciar el juego";
	AL["Loot Browser Scale: "] = "Escala del buscador: ";
	AL["Button Position: "] = "Posición del botón";
	AL["Button Radius: "] = "Radio del botón";
	AL["Done"] = "Hecho";
	AL["FuBar Toggle"] = "Conmutar FuBar";
	AL["WishList"] = "Lista deseada";
	AL["Search Result: %s"] = "Buscar resultado: %s";
	AL["Last Result"] = "Último resulta.";
	AL["Search on"] = "Buscar en";
	AL["All modules"] = "Todos los módulos";
	AL["If checked, AtlasLoot will load and search across all the modules."] = "Si lo marcas, AtlasLoot lo cargará y buscará por todos los módulos.";
	AL["Search options"] = "Buscar opciones";
	AL["Partial matching"] = "Coincidencia parcial";
	AL["If checked, AtlasLoot search item names for a partial match."] = "Si lo marcas, AtlasLoot buscará el nombre de los objetos con una coincidencia parcial.";
	AL["You don't have any module selected to search on!"] = "¡No tienes marcado ningún módulo donde buscar!";
	--The next 4 lines are the tooltip for the Server Query Button
	--The translation doesn't have to be literal, just re-write the
	--sentences as you would naturally and break them up into 4 roughly
	--equal lines.
	AL["Queries the server for all items"] = "Pregunta al servidor por todos los objectos";
	AL["on this page. The items will be"] = "de esta página, Los objectos serán";
	AL["refreshed when you next mouse"] = "refrescados al pasar el ratón";
	AL["over them."] = "sobre ellos";
	AL["The Minimap Button is generated by the FuBar Plugin."] = "El botón del Minimapa es generado por el plugin FuBar.";
	AL["This is automatic, you do not need FuBar installed."] = "Esto es automático, no tienes que tener instalado FuBar.";
	
	--Slash commands
	AL["reset"] = "Reiniciar";
	AL["options"] = "Opciones";
	AL["Reset complete!"] = "¡Se ha reiniciado!";

	--Error Messages and warnings
	AL["AtlasLoot Error!"] = "¡AtlasLoot error!";
	AL["WishList Full!"] = "¡Lista de deseos llena'";
	AL[" added to the WishList."] = " añadido a la lista de deseos.";
	AL[" already in the WishList!"] = " ya esta en la lista de deseos";
	AL[" deleted from the WishList."] = " borrado de la lista de deseos";

	--Incomplete Table Registry error message
	AL[" not listed in loot table registry, please report this message to the AtlasLoot forums at http://www.atlasloot.net"] = " no figura en el registro de botines, por favor informa sobre este mensaje en los foros de AtlasLoot http://www.atlasloot.net";

	--LoD Module disabled or missing
	AL[" is unavailable, the following load on demand module is required: "] = " no está disponible, se necesita el siguiente módulo: ";

	--LoD Module load sequence could not be completed
	AL["Status of the following module could not be determined: "] = "No se ha podido determinar el estado del siguiente módulo: ";

	--LoD Module required has loaded, but loot table is missing
	AL[" could not be accessed, the following module may be out of date: "] = " no se ha podido acceder, el siguiente módulo no debe estar actualizado: ";

	--LoD module not defined
	AL["Loot module returned as nil!"] = "¡El módulo de botín ha retornado null!";

	--LoD module loaded successfully
	AL["sucessfully loaded."] = "cargado satisfactoriamente.";

	--Need a big dataset for searching
	AL["Loading available tables for searching"] = "Cargando las tablas disponibles para búsquedas";

 	--All Available modules loaded
	AL["All Available Modules Loaded"] = "Se han cargado todos los módulos disponibles";

	--Minimap Button
	AL["|cff1eff00Left-Click|r Browse Loot Tables"] = "|cff1eff00Click-izdo|r Navegar por las tablas de botines";
	AL["|cffff0000Right-Click|r View Options"] = "|cffff0000Click-dcho|r Ver opciones";
	AL["|cffff0000Shift-Click|r View Options"] = "|cffff0000Shift-Click|r Ver opciones";
	AL["|cffccccccLeft-Click + Drag|r Move Minimap Button"] = "|cffccccccClick-izdo + arrastrar|r Mueve el botón del mini mapa";
	AL["|cffccccccRight-Click + Drag|r Move Minimap Button"] = "|cffccccccClick-dcho + arrastrar|r Mueve el botón del mini mapa";
	
	--AtlasLoot Panel
	AL["Options"] = "Opciones";
	AL["Collections"] = "Colecciones";
	AL["Factions"] = "Facciones";
	AL["World Events"] = "Eventos mundo";
	AL["Load Modules"] = "Cargar módulos";
	AL["Crafting"] = "Fabricados";
	AL["Crafting Daily Quests"] = "Fabricados misiones diarias";
	
	--First time user
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."] = "Bienvenido a AtlasLoot Enhanced. Por favor, tómate un momento para elegir tus preferencias.";
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences for tooltips and links in the chat window.\n\n  This options screen can be reached again at any later time by typing '/atlasloot'."] = "Bienvenido a Atlasloot Enhanced. Por favor tómate un momento para elegir tus preferencias en cada bocadillo y enlaces de la ventana de chat.\n\n Puedes volver a abrir esta ventana de opciones escribiendo '/atlasloot'.";
	AL["Setup"] = "Configuración";

	--Old Atlas Detected
	AL["It has been detected that your version of Atlas does not match the version that Atlasloot is tuned for ("] = "Se ha detectado que tu versión de Atlas no coincide con la versión del AtlasLoot para la cual se ha hecho (";
	AL[").  Depending on changes, there may be the occasional error, so please visit http://www.atlasmod.com as soon as possible to update."] = ").  Dependiendo de algún cambio, puede haber algún error ocasional, con lo que por favor, visita http://www.atlasmod.com/ lo antes posible para posibles actualizaciones.";
	AL["OK"] = "Vale";
	AL["Incompatible Atlas Detected"] = "Se ha detectado un Atlas incompatible ";

	--Unsafe item tooltip
	AL["Unsafe Item"] = "Objeto no seguro";
	AL["Item Unavailable"] = "Objeto no disponible";
	AL["ItemID:"] = "ObjetoID:";
	AL["This item is not available on your server or your battlegroup yet."] = "Este objeto no está disponible en tu servidor o en tu grupo de batalla todavía";
	AL["This item is unsafe.  To view this item without the risk of disconnection, you need to have first seen it in the game world. This is a restriction enforced by Blizzard since Patch 1.10."] =	"Este objeto no es seguro.\nPara verlo sin riesgo de ser desconectado, tienes que haberlo visto primero en el mundo del juego.\nEsto es una restricción forzada por Blizzard desde el Parche 1.10.";
	AL["You can right-click to attempt to query the server.  You may be disconnected."] = "Puedes hacer Click-dcho para intentar consultar al servidor.\nPuedes ser desconectado.";

	--Misc Inventory related words
	AL["Enchant"] = "Encantamiento";
	AL["Scope"] = "Mira";
	AL["Darkmoon Faire Card"] = "Carta de la Feria de la Luna";
	AL["Banner"] = "Estandarte";
	AL["Set"] = "Conjunto";
	AL["Token"] = "Insignia";
	AL["Tokens"] = "Insignias";	
	AL["Skinning Knife"] = "Cuchillo para desollar";
	AL["Herbalism Knife"] = "Cuchillo de herbolista"; --Comprobar
	AL["Fish"] = "Pescado"; --Comprobar
	AL["Combat Pet"] = "Mascota de combate"; --Comprobar
	AL["Fireworks"] = "Fuegos artificiales";
	
	--Extra inventory stuff
	AL["Cloak"] = "Capa";
	AL["Weapons"] = "Armas";

	--Alchemy
	AL["Battle Elixirs"] = "Elixires de Batalla";
	AL["Guardian Elixirs"] = "Elixires de Guardián";
	AL["Potions"] = "Pociones";
	AL["Transmutes"] = "Transmutaciones";
	AL["Flasks"] = "Frascos";

	--Enchanting
	AL["Enchant Boots"] = "Encantamiento Botas";
	AL["Enchant Bracer"] = "Encantamiento Brazalete";
	AL["Enchant Chest"] = "Encantamiento Pecho";
	AL["Enchant Cloak"] = "Encantamiento Capa";
	AL["Enchant Gloves"] = "Encantamiento Guantes";
	AL["Enchant Ring"] = "Encantamiento Anillo";
	AL["Enchant Shield"] = "Encantamiento Escudo";
	AL["Enchant 2H Weapon"] = "Encantamiento Arma 2 Manos";
	AL["Enchant Weapon"] = "Encantamiento Arma";
    
	--Engineering
	AL["Ammunition"] = "Munición";
	AL["Explosives"] = "Explosivos";
	--Inscription
	AL["Major Glyph"] = "Glifos Sublimes";
	AL["Minor Glyph"] = "Glifos Menores";
	AL["Scrolls"] = "Pergaminos";
	AL["Off-Hand Items"] = "Objetos de mano-izda";
	AL["Reagents"] = "Consumibles";
	AL["Book of Glyph Mastery"] = "Libro sobre maestría en glifos";

	--Leatherworking
	AL["Leather Armor"] = "Armaduras de cuero";
	AL["Mail Armor"] = "Armaduras de malla";
	AL["Cloaks"] = "Capas";
	AL["Item Enhancements"] = "Objetos de Mejora";
	AL["Quivers and Ammo Pouches"] = "Carcajs y bolsas de munición";
	AL["Drums, Bags and Misc."] = "Tambores, Bolsas y Misc.";

	--Tailoring
	AL["Cloth Armor"] = "Armadura de tela";
	AL["Shirts"] = "Camisas";
	AL["Bags"] = "Bolsas";
	
	--Labels for loot descriptions
	AL["Classes:"] = "Clases";
	AL["This Item Begins a Quest"] = "Este objeto empieza una misión";
	AL["Quest Item"] = "Objeto de misión";
	AL["Quest Reward"] = "Recompensa de misión";
	AL["Shared"] = "Compartido";
	AL["Unique"] = "Único";
	AL["Right Half"] = "Parte derecha";
	AL["Left Half"] = "Parte izquierda";
	AL["28 Slot Soul Shard"] = "28 huecos para fragmentos de alma";
	AL["20 Slot"] = "20 huecos";
	AL["18 Slot"] = "18 huecos";
	AL["16 Slot"] = "16 huecos";
	AL["10 Slot"] = "10 huecos";
	AL["(has random enchantment)"] = "(añade un encantamiento aleatorio)";
	AL["Currency"] = "Utiliza recompensas para comprarlo";
	AL["Currency (Horde)"] = "Utiliza recompensas para comprarlo (Horda)";
	AL["Currency (Alliance)"] = "Utiliza recompensas para comprarlo (Alianza)";
	AL["World Bosses"] = "Jefes del Mundo";
	AL["Reputation Factions"] = "Reputación con facciones";
	AL["Sets/Collections"] = "Conjuntos/Colecciones";
	AL["Card Game Item"] = "Juego de cartas";
	AL["Tier 1"] = "Conjunto T1";
	AL["Tier 2"] = "Conjunto T2";
	AL["Tier 3"] = "Conjunto T3";
	AL["Tier 4"] = "Conjunto T4";
	AL["Tier 5"] = "Conjunto T5";
	AL["Tier 6"] = "Conjunto T6";
	AL["Tier 7"] = "Conjunto T7";
	AL["Tier 8"] = "Conjunto T8";
	AL["10/25 Man"] = "10/25 Personas";
	AL["Tier 8 Sets"] = "Conjuntos T8";
	AL["Tier 7/8 Sets"] = "Conjuntos T7/8";
	AL["Level 80 PvP Sets"] = "Conjuntos Nivel 80 JcJ";
	AL["Furious Gladiator Sets"] = "Conjunto Gladiador Furioso";
	AL["Arena Reward"] = "Recompensas de Arenas";
	AL["Conjured Item"] = "Objetos conjurados";
	AL["Used to summon boss"] = "Usado para invocar a un jefe";
	AL["Phase 1"] = "Fase 1";
	AL["Phase 2"] = "Fase 2";
	AL["Phase 3"] = "Fase 3";
	AL["Fire"] = "Fuego";
	AL["Water"] = "Agua";
	AL["Wind"] = "Aire";
	AL["Earth"] = "Tierra";
	AL["Master Angler"] = "Maestro pescador";
	AL["First Prize"] = "Primer precio";
	AL["Rare Fish Rewards"] = "Recompensas raras de pesca";
	AL["Rare Fish"] = "Pescados raros";
	AL["Tradable against sunmote + item above"] = "Comerciables";
	AL["Rare"] = "Raro";
	AL["Heroic"] = "Heróico";
	AL["Hard Mode"] = "Modo difícil";		
	AL["Summon"] = "Invocar";
	AL["Random"] = "Aleatorio";
	AL["Weapons"] = "Armas";
	AL["Achievement"] = "Logro";
	AL["Unattainable Tabards"] = "Tabardos inasequibles";
	AL["Heirloom"] = "Reliquia";	

	--Darkmoon Faire
	AL["Darkmoon Faire Rewards"] = "Recompensas Feria de la Luna Negra";
	AL["Low Level Decks"] = "Bajaras de bajo nivel";
	AL["Original and BC Trinkets"] = "Abalorios Original y BC";
	AL["WotLK Trinkets"] = "Abalorios WotLK";
    
	--Argent Tournament
	AL["Argent Tournament"] = "Torneo Argenta";
	
	-- Daily Quest
--	AL["Jewelcrafting Daily"] = true;
--	AL["Cooking Daily"] = true;

	--Card Game Decks and descriptions
	AL["Upper Deck Card Game Items"] = "Juegos de cartas de The Burning Crusade";
	AL["Loot Card Items"] = "Objetos (juegos de cartas)";
	AL["UDE Items"] = "Objetos (puntos UDE)";

	-- First set
	AL["Heroes of Azeroth"] = "Heroes de Azeroth";
	AL["Landro Longshot"] = "Landro Tirolargo";
	AL["Thunderhead Hippogryph"] = "Hipogrifo Tronatesta";
	AL["Saltwater Snapjaw"] = "Quijaforte marino";
	-- Second set	
	AL["Through The Dark Portal"] = "A través del Portal Oscuro";
	AL["King Mukla"] = "Rey Mukla";
	AL["Rest and Relaxation"] = "Descanso y relajación";
	AL["Fortune Telling"] = "La buena aventura"; --Comprobar
	-- Third set
	AL["Fires of Outland"] = "Fuegos de Terrallende";
	AL["Spectral Tiger"] = "Tigre espectral";
	AL["Gone Fishin'"] = "Se fué pescando"; --Comprobar
	AL["Goblin Gumbo"] = "Potaje goblin";
	-- Fourth set
	AL["March of the Legion"] = "Marca de la Legión";
	--AL["Kiting"] = true, FALTA
	--AL["Robotic Homing Chicken"] = true, FALTA
	AL["Paper Airplane"] = "Avión de papel"
	-- Fifth set	
	AL["Servants of the Betrayer"] = "Sirvientes del Traidor";
	AL["X-51 Nether-Rocket"] = "Cohete abisal X-51";
	AL["Personal Weather Machine"] = "Máquina del tiempo personal";
	AL["Papa Hummel's Old-fashioned Pet Biscuit"] = "Galleta de mascota retro de papá Hummel"
	-- Sixth set
	AL["Hunt for Illidan"] = "Caza de Illidan"; 
	AL["The Footsteps of Illidan"] = "Las huellas de Illidan"; 
	--AL["Disco Inferno!"] = true, FALTA
	AL["Ethereal Plunderer"] = "Desvalijador etéreo";
	-- Seventh set
	AL["Drums of War"] = "Tambores de guerra";
	--AL["The Red Bearon"] = "The Red Bearon"; --FALTA
	--AL["Owned!"] = true, --FALTA
	--AL["Slashdance"] = true, --FALTA
	-- Eighth set
	AL["Blood of Gladiators"] = "Sangre de Gladiadores";
	AL["Sandbox Tiger"] = "Tigre Balancín";
	AL["Center of Attention"] = "Centro de atención"; --Check
	AL["Foam Sword Rack"] = "Espada de gomaespuma";
	
	--Battleground Brackets
	AL["Misc. Rewards"] = "Recompensas varias";
	AL["Level 20-29 Rewards"] = "Recompensas de niveles 20-29";
	AL["Level 30-39 Rewards"] = "Recompensas de niveles 30-39";
	AL["Level 20-39 Rewards"] = "Recompensas de niveles 20-39";
	AL["Level 40-49 Rewards"] = "Recompensas de niveles 40-49";
	AL["Level 60 Rewards"] = "Recompensas de nivel 60";

	--Brood of Nozdormu Paths
	AL["Path of the Conqueror"] = "El camino del conquistador";
	AL["Path of the Invoker"] = "El camino del invocador";
	AL["Path of the Protector"] = "El camino del protector";

	--Violet Eye Paths
	AL["Path of the Violet Protector"] = "El camino del protector violeta";
	AL["Path of the Violet Mage"] = "El camino del mago violeta";
	AL["Path of the Violet Assassin"] = "El camino del asesino violeta";
	AL["Path of the Violet Restorer"] = "El camino del restaurador violeta";

	--AQ Opening Event
	AL["Red Scepter Shard"] = "Fragmento de cetro rojo";
	AL["Blue Scepter Shard"] = "Fragmento de cetro azul";
	AL["Green Scepter Shard"] = "Fragmento de cetro verde";
	AL["Scepter of the Shifting Sands"] = "El cetro del Mar de Dunas";

	--World PvP
	AL["Hellfire Fortifications"] = "Fortificaciones de la Península de fuego";
	AL["Twin Spire Ruins"] = "Ruinas de las Agujas Gemelas";
	AL["Spirit Towers"] = "Torres de los espíritus";
	--AL["Halaa"] = true,
	AL["Venture Bay"] = "Bahía Aventura"; --Check
	
	--Karazhan Opera Event Headings
	AL["Shared Drops"] = "Objetos compartidos";
	AL["Romulo & Julianne"] = "Romeo y Julieta";
	AL["Wizard of Oz"] = "El mago de Oz";
	AL["Red Riding Hood"] = "Caperucita roja";

	--Karazhan Animal Boss Types
	AL["Spider"] = "Araña";
	AL["Darkhound"] = "Can oscuro";
	AL["Bat"] = "Murciélago";

	--ZG Tokens
	AL["Primal Hakkari Kossack"] = "Casaca Hakkari primigenia";
	AL["Primal Hakkari Shawl"] = "Primal Hakkari Shawl";
	AL["Primal Hakkari Bindings"] = "Ataduras Hakkari primigenias";
	AL["Primal Hakkari Sash"] = "Fajín Hakkari primigenio";
	AL["Primal Hakkari Stanchion"] = "Puntal Hakkari primigenio";
	AL["Primal Hakkari Aegis"] = "Égida Hakkari primigenia";
	AL["Primal Hakkari Girdle"] = "Faja Hakkari primigenia";
	AL["Primal Hakkari Armsplint"] = "Cabestrillo Hakkari primigenio";
	AL["Primal Hakkari Tabard"] = "Tabardo Hakkari primigenio";

	--AQ20 Tokens
	AL["Qiraji Ornate Hilt"] = "Empuñadura Qiraji ornamentada";
	AL["Qiraji Martial Drape"] = "Mantón Qiraji marcial";
	AL["Qiraji Magisterial Ring"] = "Anillo Qiraji magistral";
	AL["Qiraji Ceremonial Ring"] = "Anillo ceremonial Qiraji";
	AL["Qiraji Regal Drape"] = "Mantón Qiraji real";
	AL["Qiraji Spiked Hilt"] = "Puño con pinchos Qiraji";

	--AQ40 Tokens
	AL["Qiraji Bindings of Dominance"] = "Ataduras de dominio Qiraji";
	AL["Qiraji Bindings of Command"] = "Ataduras de mando Qiraji";
	AL["Vek'nilash's Circlet"] = "Aro de Vek'nilash";
	AL["Vek'lor's Diadem"] = "Diadema de Vek'lor";
	AL["Ouro's Intact Hide"] = "Pellejo intacto de Ouro";
	AL["Skin of the Great Sandworm"] = "Piel del Gran gusano de arena";
	AL["Husk of the Old God"] = "Colmillo del dios antiguo";
	AL["Carapace of the Old God"] = "Caparazón del dios antiguo";

	--Blacksmithing Crafted Sets
	AL["Imperial Plate"] = "Placas imperiales";
	AL["The Darksoul"] = "El Almanegra";
	AL["Fel Iron Plate"] = "Placa de hierro vil";
	AL["Adamantite Battlegear"] = "Equipo de batalla de adamantita";
	AL["Flame Guard"] = "Guardia de las llamas";
	AL["Enchanted Adamantite Armor"] = "Armadura de adamantita encantada";
	AL["Khorium Ward"] = "Resguardo de Korio";
	AL["Faith in Felsteel"] = "Fe en el acero vil";
	AL["Burning Rage"] = "Ira ardiente";
	AL["Bloodsoul Embrace"] = "Abrazo de alma de sangre";
	AL["Fel Iron Chain"] = "Cadena de hierro vil";

	--Tailoring Crafted Sets
	AL["Bloodvine Garb"] = "Atuendo de vid de sangre";
	AL["Netherweave Vestments"] = "Vestimentas de tejido abisal";
	AL["Imbued Netherweave"] = "Tejido abisal imbuido";
	AL["Arcanoweave Vestments"] = "Vestimentas de tejido Arcano";
	AL["The Unyielding"] = "Los implacables";
	AL["Whitemend Wisdom"] = "Sabiduría con remiendos blancos";
	AL["Spellstrike Infusion"] = "Infusión de golpe de hechizo";
	AL["Battlecast Garb"] = "Atuendo de conjuro de batalla";
	AL["Soulcloth Embrace"] = "Abrazo de paño de alma";
	AL["Primal Mooncloth"] = "Tela lunar primigenia";
	AL["Shadow's Embrace"] = "Abrazo de las sombras";
	AL["Wrath of Spellfire"] = "Cólera de hechizo de Fuego";

	--Leatherworking Crafted Sets
	AL["Volcanic Armor"] = "Armadura volcánica";
	AL["Ironfeather Armor"] = "Armadura Plumahierro";
	AL["Stormshroud Armor"] = "Armadura de sudario de tormenta";
	AL["Devilsaur Armor"] = "Armadura de demosaurio";
	AL["Blood Tiger Harness"] = "Arnés de tigre de sangre";
	AL["Primal Batskin"] = "Piel de murciélago primigenia";
	AL["Wild Draenish Armor"] = "Armadura draenei salvaje";
	AL["Thick Draenic Armor"] = "Armadura draenei gruesa";
	AL["Fel Skin"] = "Piel vil";
	AL["Strength of the Clefthoof"] = "Fuerza de los uñagrieta";
	AL["Green Dragon Mail"] = "Malla de dragón verde";
	AL["Blue Dragon Mail"] = "Malla de dragón azul";
	AL["Black Dragon Mail"] = "Malla de dragón negro";
	AL["Scaled Draenic Armor"] = "Armadura draénica escamada";
	AL["Felscale Armor"] = "Armadura de escama vil";
	AL["Felstalker Armor"] = "Armadura de acechador vil";
	AL["Fury of the Nether"] = "Furia del vacío";
	AL["Primal Intent"] = "Intención primigenia";
	AL["Windhawk Armor"] = "Armadura de halcón del viento";
	AL["Netherscale Armor"] = "Armadura de escamas abisales";
	AL["Netherstrike Armor"] = "Armadura de golpe abisal";

	--Vanilla WoW Sets
	AL["Defias Leather"] = "Cuero Defias";
	AL["Embrace of the Viper"] = "Abrazo de la víbora";
	AL["Chain of the Scarlet Crusade"] = "Cadena de la Cruzada Escarlata";
	AL["The Gladiator"] = "El Gladiador";
	AL["Ironweave Battlesuit"] = "Abrazo de paño de alma";
	AL["Necropile Raiment"] = "Vestiduras necrópilas";
	AL["Cadaverous Garb"] = "Atuendo de cadáver";
	AL["Bloodmail Regalia"] = "Atavío mallasangre";
	AL["Deathbone Guardian"] = "Guardia de hueso de muerto";
	AL["The Postmaster"] = "El jefe de correos";
	AL["Shard of the Gods"] = "Fragmentos de los Dioses";
	AL["Zul'Gurub Rings"] = "Anillos de Zul'Gurub";
	AL["Major Mojo Infusion"] = "Infusión de mojo sublime";
	AL["Overlord's Resolution"] = "Resolución de Señor Supremo";
	AL["Prayer of the Primal"] = "Rezo del primigenio";
	AL["Zanzil's Concentration"] = "Concentración de Zanzil";
	AL["Spirit of Eskhandar"] = "Espiritú de Eskhandar";
	AL["The Twin Blades of Hakkari"] = "Las hojas gemelas de Hakkari";
	AL["Primal Blessing"] = "Bendición primigenia";
	AL["Dal'Rend's Arms"] = "Armas de Dal'Rend";
	AL["Spider's Kiss"] = "Beso de la araña";

	--The Burning Crusade Sets
	AL["Latro's Flurry"] = "Latro's Flurry"; --FALTA
	AL["The Twin Stars"] = "Las estrellas gemelas";
	AL["The Fists of Fury"] = "Los puños de furia";
	AL["The Twin Blades of Azzinoth"] = "Las hojas gemelas de Azzinoth";

	--Wrath of the Lich King Sets
	AL["Raine's Revenge"] = "Venganza de Raine";
--  AL["Low Level"] = true;
--	AL["High Level"] = true;


	--Recipe origin strings
	AL["Trainer"] = "Instructor";
	AL["Discovery"] = "Descubierto";
	AL["World Drop"] = "Botín del Mundo";
	AL["Drop"] = "Botín"; 
	AL["Vendor"] = "Vendedor";
	AL["Quest"] = "Misión";
	AL["Crafted"] = "Fabricado";
    
	--Scourge Invasion
	AL["Scourge Invasion"] = "Invasión de la Plaga"; --Comprobar
	AL["Scourge Invasion Sets"] = "Conjuntos Invasión de la Plaga";
	AL["Blessed Regalia of Undead Cleansing"] = "Atavío bendecido de limpieza de no-muertos";
	AL["Undead Slayer's Blessed Armor"] = "Armadura bendecida de Asesino de no-muertos";
	AL["Blessed Garb of the Undead Slayer"] = "Atuendo bendecido del Asesino de no-muertos";
	AL["Blessed Battlegear of Undead Slaying"] = "Equipo de batalla de matanza de no-muertos";
	AL["Prince Tenris Mirkblood"] = "Príncipe Tenris Sangre Penumbra";
	
	--ZG Sets
	AL["Haruspex's Garb"] = "Atuendo de Haruspex";
	AL["Predator's Armor"] = "Armadura de depredador";
	AL["Illusionist's Attire"] = "Ropajes del ilusionista";
	AL["Freethinker's Armor"] = "Armadura del librepensador";
	AL["Confessor's Raiment"] = "Vestiduras de confesor";
	AL["Madcap's Outfit"] = "Equipo del Loquillo";
	AL["Augur's Regalia"] = "Atavío de Augur";
	AL["Demoniac's Threads"] = "Vestuario demoníaco";
	AL["Vindicator's Battlegear"] = "Equipo de batalla del vindicador";

	--AQ20 Sets
	AL["Symbols of Unending Life"] = "Símbolos de de vida inagotable";
	AL["Trappings of the Unseen Path"] = "Ajuar de la senda oculta";
	AL["Trappings of Vaulted Secrets"] = "Ajuar de secretos oscuros";
	AL["Battlegear of Eternal Justice"] = "Equipo de batalla de Justicia eterna";
	AL["Finery of Infinite Wisdom"] = "Galas de infinita sabiduría";
	AL["Emblems of Veiled Shadows"] = "Emblemas de las Sombras Ocultas";
	AL["Gift of the Gathering Storm"] = "Ofrenda de la tormenta inminente";
	AL["Implements of Unspoken Names"] = "Implementos de los Nombres Prohibidos";
	AL["Battlegear of Unyielding Strength"] = "Equipo de batalla de fuerza implacable";

	--AQ40 Sets
	AL["Genesis Raiment"] = "Vestiduras génesis";
	AL["Striker's Garb"] = "Atuendo de artillero";
	AL["Enigma Vestments"] = "Vestimentas Enigma";
	AL["Avenger's Battlegear"] = "Equipo de batalla del Vengador";
	AL["Garments of the Oracle"] = "Prendas del oráculo";
	AL["Deathdealer's Embrace"] = "Abrazo de mortífero";
	AL["Stormcaller's Garb"] = "Atuendo de clamatormentas";
	AL["Doomcaller's Attire"] = "Ropajes de clamacondenas";
	AL["Conqueror's Battlegear"] = "Equipo de batalla de conquistador";

	--Dungeon 1 Sets
	AL["Wildheart Raiment"] = "Vestiduras corazón salvaje";
	AL["Beaststalker Armor"] = "Armadura de acechabestias";
	AL["Magister's Regalia"] = "Atavío de magister";
	AL["Lightforge Armor"] = "Armadura Forjaluz";
	AL["Vestments of the Devout"] = "Vestimentas del devoto";
	AL["Shadowcraft Armor"] = "Armadura Arte Sombrío";
	AL["The Elements"] = "Los elementos";
	AL["Dreadmist Raiment"] = "Vestiduras Calígine";
	AL["Battlegear of Valor"] = "Equipo de batalla de valor";

	--Dungeon 2 Sets
	AL["Feralheart Raiment"] = "Vestiduras Cuoroferal";
	AL["Beastmaster Armor"] = "Armadura de Señor de Bestias";
	AL["Sorcerer's Regalia"] = "Atavío de hechicero";
	AL["Soulforge Armor"] = "Armadura Forjalma";
	AL["Vestments of the Virtuous"] = "Vestimentas del virtuoso";
	AL["Darkmantle Armor"] = "Armadura mantoscuro";
	AL["The Five Thunders"] = "Los cinco truenos";
	AL["Deathmist Raiment"] = "Vestiduras Brumamorta";
	AL["Battlegear of Heroism"] = "Equipo de batalla de heroísmo";

	--Dungeon 3 Sets
	AL["Hallowed Raiment"] = "Vestiduras sacralizadas";
	AL["Incanter's Regalia"] = "Atavío de embrujamiento";
	AL["Mana-Etched Regalia"] = "Atavío con grabados de maná";
	AL["Oblivion Raiment"] = "Vestiduras de olvido";
	AL["Assassination Armor"] = "Armadura de asesinato";
	AL["Moonglade Raiment"] = "Vestiduras de Claro de la Luna";
	AL["Wastewalker Armor"] = "Armadura de residuario";
	AL["Beast Lord Armor"] = "Armadura de Señor de Bestias";
	AL["Desolation Battlegear"] = "Equipo de batalla de desolación";
	AL["Tidefury Raiment"] = "Vestiduras Furiamarea";
	AL["Bold Armor"] = "Armadura del osado";
	AL["Doomplate Battlegear"] = "Equipo de batalla de placas malditas";
	AL["Righteous Armor"] = "Armadura recta";

	--Tier 1 Sets
	AL["Cenarion Raiment"] = "Vestiduras de Cenarius";
	AL["Giantstalker Armor"] = "Armadura de acechagigantes";
	AL["Arcanist Regalia"] = "Atavío de arcanista";
	AL["Lawbringer Armor"] = "Armadura de Justiciero";
	AL["Vestments of Prophecy"] = "Vestimentas de profecía";
	AL["Nightslayer Armor"] = "Armadura de Destripador Nocturno";
	AL["The Earthfury"] = "Furia de la tierra";
	AL["Felheart Raiment"] = "Vestiduras Corazón Oscuro";
	AL["Battlegear of Might"] = "Equipo de batalla de poderío";

	--Tier 2 Sets
	AL["Stormrage Raiment"] = "Vestiduras de Tempestina";
	AL["Dragonstalker Armor"] = "Armadura de acechadragón";
	AL["Netherwind Regalia"] = "Atavío viento abisal";
	AL["Judgement Armor"] = "Armadura de la Sentencia";
	AL["Vestments of Transcendence"] = "Vestimentas de trascendencia";
	AL["Bloodfang Armor"] = "Armadura Colmillo de Sangre";
	AL["The Ten Storms"] = "Las diez tormentas";
	AL["Nemesis Raiment"] = "Vestiduras de la Némesis";
	AL["Battlegear of Wrath"] = "Equipo de batalla de la cólera";

	--Tier 3 Sets
	AL["Dreamwalker Raiment"] = "Vestiduras de Caminasueños";
	AL["Cryptstalker Armor"] = "Armadura de acechacriptas";
	AL["Frostfire Regalia"] = "Atavío de escarchafuego";
	AL["Redemption Armor"] = "Armadura de la Redención";
	AL["Vestments of Faith"] = "Vestimentas de fe";
	AL["Bonescythe Armor"] = "Armadura de segahuesos";
	AL["The Earthshatterer"] = "El Trizaterrador";
	AL["Plagueheart Raiment"] = "Vestidura Corazón de la Peste";
	AL["Dreadnaught's Battlegear"] = "Equipo de batalla de Acorator";

	--Tier 4 Sets
	AL["Malorne Harness"] = "Arnés de Malorne";
	AL["Malorne Raiment"] = "Vestiduras de Malorne";
	AL["Malorne Regalia"] = "Atavío de Malorne";
	AL["Demon Stalker Armor"] = "Armadura de acechademonios";
	AL["Aldor Regalia"] = "Atavío de los Aldor";
	AL["Justicar Armor"] = "Armadura de justicar";
	AL["Justicar Battlegear"] = "Equipo de batalla de justicar";
	AL["Justicar Raiment"] = "Vestiduras de justicar";
	AL["Incarnate Raiment"] = "Vestiduras encarnadas";
	AL["Incarnate Regalia"] = "Atavío encarnado";
	AL["Netherblade Set"] = "Filo abisal";
	AL["Cyclone Harness"] = "Arnés de ciclón";
	AL["Cyclone Raiment"] = "Vestiduras de ciclón";
	AL["Cyclone Regalia"] = "Atavío de ciclón";
	AL["Voidheart Raiment"] = "Vestiduras de corazón vacío";
	AL["Warbringer Armor"] = "Armadura de belisario";
	AL["Warbringer Battlegear"] = "Equipo de batalla de belisario";

	--Tier 5 Sets
	AL["Nordrassil Harness"] = "Arnés de Nordrassil";
	AL["Nordrassil Raiment"] = "Vestiduras de Nordrassil";
	AL["Nordrassil Regalia"] = "Atavío de Nordrassil";
	AL["Rift Stalker Armor"] = "Armadura de acechador de falla";
	AL["Tirisfal Regalia"] = "Atavío Tirisfal";
	AL["Crystalforge Armor"] = "Armadura forjacristal";
	AL["Crystalforge Battlegear"] = "Equipo de batalla forjacristal";
	AL["Crystalforge Raiment"] = "Vestiduras forjacristal";
	AL["Avatar Raiment"] = "Atavío de avatar";
	AL["Avatar Regalia"] = "Vestiduras de avatar";
	AL["Deathmantle Set"] = "Manto de la muerte";
	AL["Cataclysm Harness"] = "Arnés de cataclismo";
	AL["Cataclysm Raiment"] = "Vestiduras de cataclismo";
	AL["Cataclysm Regalia"] = "Atavío de cataclismo";
	AL["Corruptor Raiment"] = "Vestiduras de corruptor";
	AL["Destroyer Armor"] = "Armadura de destructor";
	AL["Destroyer Battlegear"] = "Equipo de batalla de destructor";

	--Tier 6 Sets
	AL["Thunderheart Harness"] = "Arnés de Truenozón";
	AL["Thunderheart Raiment"] = "Vestiduras de Truenozón";
	AL["Thunderheart Regalia"] = "Atavío de Truenozón";
	AL["Gronnstalker's Armor"] = "Armadura de acechagronns";
	AL["Tempest Regalia"] = "Atavío de tempestad";
	AL["Lightbringer Armor"] = "Armadura de Iluminado";
	AL["Lightbringer Battlegear"] = "Equipo de batalla de Iluminado";
	AL["Lightbringer Raiment"] = "Vestiduras de Iluminado";
	AL["Vestments of Absolution"] = "Vestimentas de absolución";
	AL["Absolution Regalia"] = "Atavío de absolución";
	AL["Slayer's Armor"] = "Armadura de destripador";
	AL["Skyshatter Harness"] = "Arnés de destrozacielos";
	AL["Skyshatter Raiment"] = "Vestiduras de destrozacielos";
	AL["Skyshatter Regalia"] = "Atavío de destrozacielos";
	AL["Malefic Raiment"] = "Vestiduras maléficas";
	AL["Onslaught Armor"] = "Armadura de acometida";
	AL["Onslaught Battlegear"] = "Equipo de batalla de acometida";

	--Tier 7 Sets
	AL["Scourgeborne Battlegear"] = "Equipo de batalla de vástagos de la Plaga";
	AL["Scourgeborne Plate"] = "Placas de vástagos de la Plaga";
	AL["Dreamwalker Garb"] = "Atuendo de Caminasueños";
	AL["Dreamwalker Battlegear"] = "Equipo de batalla de Caminasueños";
	AL["Dreamwalker Regalia"] = "Atavío de Caminasueños";
	AL["Cryptstalker Battlegear"] = "Equipo de batalla de acechacriptas";
	AL["Frostfire Garb"] = "Atuendo Fuego de Escarcha";
	AL["Redemption Regalia"] = "Atavío de la Redención";
	AL["Redemption Battlegear"] = "Equipo de batalla de redención";
	AL["Redemption Plate"] = "Placas de la Redención";
	AL["Regalia of Faith"] = "Atavío de fe";
	AL["Garb of Faith"] = "Atuendo de fe";
	AL["Bonescythe Battlegear"] = "Equipo de batalla de Segahuesos";
	AL["Earthshatter Garb"] = "Atuendo de Rompeterra";
	AL["Earthshatter Battlegear"] = "Equipo de batalla de Rompeterra";
	AL["Earthshatter Regalia"] = "Atavío de Rompeterra";
	AL["Plagueheart Garb"] = "Atuendo corazón de peste";
	AL["Dreadnaught Battlegear"] = "Equipo de batalla de Acorator";
	AL["Dreadnaught Plate"] = "Placas acorator";
	
	--Tier 8 Sets
	AL["Darkruned Battlegear"] = "Batalla de Runaoscura"; --Check
	AL["Darkruned Plate"] = "Placas de Runaoscura"; --Check
	AL["Nightsong Garb"] = "Arrullanoche"; --Check
	AL["Nightsong Battlegear"] = "Arrullanoche"; --Check
	AL["Nightsong Regalia"] = "Arrullanoche"; --Check
	AL["Scourgestalker Battlegear"] = "Acechador de la Plaga"; --Check
	--AL["Kirin Tor Garb"] = "Kirin Tor Garb"; --FALTA
	AL["Aegis Regalia"] = "Égida"; --Check
	AL["Aegis Battlegear"] = "Batalla de Égida"; --Check
	AL["Aegis Plate"] = "Placas de Égida"; --Check
	AL["Sanctification Regalia"] = "Santificación"; --Check
	AL["Sanctification Garb"] = "Santificación"; --Check
	AL["Terrorblade Battlegear"] = "Hoja de Terror"; --Check
	AL["Worldbreaker Garb"] = "Rompemundos"; --Check
	AL["Worldbreaker Battlegear"] = "Batalla de Rompemundos"; --Check
	AL["Worldbreaker Regalia"] = "Rompemundos"; --Check
	AL["Deathbringer Garb"] = "Libramonte"; --Check
	AL["Siegebreaker Battlegear"] = "Batalla de rompedor de asedio"; --Check
	AL["Siegebreaker Plate"] = "Placas de rompedor de asedio"; --Check
	--Arathi Basin Sets - Alliance
	AL["The Highlander's Intent"] = "Intención del montañés";
	AL["The Highlander's Purpose"] = "Propósito del montañés";
	AL["The Highlander's Will"] = "Voluntaz del montañés";
	AL["The Highlander's Determination"] = "Determinación del montañés";
	AL["The Highlander's Fortitude"] = "Entereza del montañés";
	AL["The Highlander's Resolution"] = "Resolución de montañés";
	AL["The Highlander's Resolve"] = "Decisión del montañés";

	--Arathi Basin Sets - Horde
	AL["The Defiler's Intent"] = "Intención del Envilecido";
	AL["The Defiler's Purpose"] = "Propósito del Rapiñador";
	AL["The Defiler's Will"] = "Voluntad del Rapiñador";
	AL["The Defiler's Determination"] = "Determinación del Envilecido";
	AL["The Defiler's Fortitude"] = "Entereza del Envilecido";
	AL["The Defiler's Resolution"] = "Resolución del Envilecido";

	--PvP Level 60 Rare Sets - Alliance
	AL["Lieutenant Commander's Refuge"] = "Refugio de Teniente Coronel";
	AL["Lieutenant Commander's Pursuance"] = "Persistencia de Teniente Coronel";
	AL["Lieutenant Commander's Arcanum"] = "Arcano de Teniente Coronel";
	AL["Lieutenant Commander's Redoubt"] = "Reducto de Teniente Coronel";
	AL["Lieutenant Commander's Investiture"] = "Investidura de Teniente Coronel";
	AL["Lieutenant Commander's Guard"] = "Guardia de Teniente Coronel";
	AL["Lieutenant Commander's Stormcaller"] = "Sacudetierra de Teniente Coronel";
	AL["Lieutenant Commander's Dreadgear"] = "Equipo de terror de Teniente Coronel";
	AL["Lieutenant Commander's Battlearmor"] = "Armadura de batalla de Teniente Coronel";

	--PvP Level 60 Rare Sets - Horde
	AL["Champion's Refuge"] = "Refugio de Campeón";
	AL["Champion's Pursuance"] = "Cumplimiento de Campeón";
	AL["Champion's Arcanum"] = "Arcno de Campeón";
	AL["Champion's Redoubt"] = "Reducto de Campeón";
	AL["Champion's Investiture"] = "Investidura de Campeón";
	AL["Champion's Guard"] = "Guardia de Campeón";
	AL["Champion's Stormcaller"] = "Clamatormentas de Campeón";
	AL["Champion's Dreadgear"] = "Equipo de terror de Campeón";
	AL["Champion's Battlearmor"] = "Armadura de batalla de Campeón";

	--PvP Level 60 Epic Sets - Alliance
	AL["Field Marshal's Sanctuary"] = "Santuario de Mariscal de campo";
	AL["Field Marshal's Pursuit"] = "Persecución de Mariscal de campo";
	AL["Field Marshal's Regalia"] = "Atavío de Mariscal de campo";
	AL["Field Marshal's Aegis"] = "Égida de Mariscal de campo";
	AL["Field Marshal's Raiment"] = "Vestiduras de Mariscal de campo";
	AL["Field Marshal's Vestments"] = "Vestimentas de Mariscal de campo";
	AL["Field Marshal's Earthshaker"] = "Sacudetierra de Mariscal de campo";
	AL["Field Marshal's Threads"] = "Vestuario de Mariscal de campo";
	AL["Field Marshal's Battlegear"] = "Equipo de batalla de Mariscal de campo";

	--PvP Level 60 Epic Sets - Horde
	AL["Warlord's Sanctuary"] = "Santuario de Señor de la Guerra";
	AL["Warlord's Pursuit"] = "Persecución de Señor de la Guerra";
	AL["Warlord's Regalia"] = "Atavío de Señor de la Guerra";
	AL["Warlord's Aegis"] = "Égida de Señor de la Guerra";
	AL["Warlord's Raiment"] = "Vestiduras de Señor de la Guerra";
	AL["Warlord's Vestments"] = "Vestimentas de Señor de la Guerra";
	AL["Warlord's Earthshaker"] = "Sacudetierra de Señor de la Guerra";
	AL["Warlord's Threads"] = "Vestuario de Señor de la Guerra";
	AL["Warlord's Battlegear"] = "Equipo de batalla de Señor de la Guerra";

	--Outland Faction Reputation PvP Sets
	AL["Dragonhide Battlegear"] = "Equipo de batalla de pellejo de dragón";
	AL["Wyrmhide Battlegear"] = "Equipo de batalla de pellejo de vermis";
	AL["Kodohide Battlegear"] = "Equipo de batalla de pellejo de kodo";
	AL["Stalker's Chain Battlegear"] = "Equipo de batalla de anillas de acechador";
	AL["Evoker's Silk Battlegear"] = "Equipo de batalla de seda evocador";
	AL["Crusader's Scaled Battledgear"] = "Equipo de batalla escamada de cruzado";
	AL["Crusader's Ornamented Battledgear"] = "Equipo de batalla ornamentado de cruzado";
	AL["Satin Battlegear"] = "Equipo de batalla de satén";
	AL["Mooncloth Battlegear"] = "Equipo de batalla de tela lunar";
	AL["Opportunist's Battlegear"] = "Equipo de batalla de oportunista";
	AL["Seer's Linked Battlegear"] = "Equipo de batalla de eslabones de vidente";
	AL["Seer's Mail Battlegear"] = "Equipo de batalla de malla de vidente";
	AL["Seer's Ringmail Battlegear"] = "Equipo de batalla de cota guarnecida de vidente";
	AL["Dreadweave Battlegear"] = "Equipo de batalla de tejido de tinieblas";
	AL["Savage's Plate Battlegear"] = "Equipo de batalla de placas salvajes";

	--Arena Epic Sets
	AL["Gladiator's Sanctuary"] = "Santuario de Gladiador";
	AL["Gladiator's Wildhide"] = "Envoltura salvaje de Gladiador";
	AL["Gladiator's Refuge"] = "Refugio de Gladiador";
	AL["Gladiator's Pursuit"] = "Persecución de Gladiador";
	AL["Gladiator's Regalia"] = "Atavío de Gladiador";
	AL["Gladiator's Aegis"] = "Égida de Gladiador";
	AL["Gladiator's Vindication"] = "Vindicación de Gladiador";
	AL["Gladiator's Redemption"] = "Redención de Gladiador";
	AL["Gladiator's Raiment"] = "Vestiduras de Gladiador";
	AL["Gladiator's Investiture"] = "Investidura de Gladiador";
	AL["Gladiator's Vestments"] = "Vestimentas de Gladiador";
	AL["Gladiator's Earthshaker"] = "Sacudetierra de Gladiador";
	AL["Gladiator's Thunderfist"] = "Puño de trueno de Gladiador";
	AL["Gladiator's Wartide"] = "Marea de guerra de Gladiador";
	AL["Gladiator's Dreadgear"] = "Equipo de terror de Gladiador";
	AL["Gladiator's Felshroud"] = "Sayo vil de Gladiador";
	AL["Gladiator's Battlegear"] = "Equipo de batalla de Gladiador";
	AL["Gladiator's Desecration"] = "Persecución de Gladiador";
    
	--Level 80 PvP Weapons
	AL["Savage Gladiator\'s Weapons"] = "Armas de Gladiador indómito";
	AL["Deadly Gladiator\'s Weapons"] = "Armas de Gladiador mortífero"; --Comprobar
	
	--Set Labels
	AL["Set: Embrace of the Viper"] = "Conjunto: Abrazo de la víbora";
	AL["Set: Defias Leather"] = "Conjunto: Cuero Defias";
	AL["Set: The Gladiator"] = "Conjunto: El Gladiador";
	AL["Set: Chain of the Scarlet Crusade"] = "Conjunto: Cadena de la Cruzada Escarlata";
	AL["Set: The Postmaster"] = "Conjunto: El jefe de correos";
	AL["Set: Necropile Raiment"] = "Conjunto: Vestiduras necrópilas";
	AL["Set: Cadaverous Garb"] = "Conjunto: Atuendo de cadáver";
	AL["Set: Bloodmail Regalia"] = "Conjunto: Atavío mallasangre";
	AL["Set: Deathbone Guardian"] = "Conjunto: Guardia de hueso de muerto";
	AL["Set: Dal'Rend's Arms"] = "Conjunto: Armas de Dal'Rend";
	AL["Set: Spider's Kiss"] = "Beso de la araña";
	AL["Temple of Ahn'Qiraj Sets"] = "Conjuntos del Templo de Ahn'Qiraj";
	AL["AQ40 Class Sets"] = "Conjuntos por Clase de AQ40";
	AL["Ruins of Ahn'Qiraj Sets"] = "Conjuntos de las Ruinas de Ahn'Qiraj";
	AL["AQ20 Class Sets"] = "Conjuntos por Clase de AQ20";
	AL["AQ Enchants"] = "Encantamientos AQ";
	AL["AQ Opening Quest Chain"] = "Apertura de la misión de la cadena AQ";
	AL["Misc Sets"] = "Conjuntos varios";
	AL["Classic Sets"] = "Conjuntos WoW Clásico";
	AL["Burning Crusade Sets"] = "Conjuntos Burning Crusade";
	AL["Wrath Of The Lich King Sets"] = "Conjuntos Wrath Of The Lich King";
	AL["Scholomance Sets"] = "Conjuntos Scholomance";
	AL["Crafted Sets"] = "Conjuntos fabricados";
	AL["Crafted Epic Weapons"] = "Armas épicas fabricadas";
	AL["Zul'Gurub Sets"] = "Conjuntos de Zul'Gurub";
	AL["ZG Class Sets"] = "Conjuntos por Clase de ZG";
	AL["ZG Enchants"] = "Encantamientos ZG";
	AL["Dungeon 1/2 Sets"] = "Conjuntos de Mazmorra 1/2";
	AL["Dungeon Set 1"] = "Conjunto de Mazmorra 1";
	AL["Dungeon Set 2"] = "Conjunto de Mazmorra 2";
	AL["Dungeon Set 3"] = "Conjunto de Mazmorra 3";	
	AL["Dungeon 3 Sets"] = "Conjuntos de Mazmorra 3";
	AL["Tier 1/2 Sets"] = "Conjuntos T1/2";
	AL["Tier 1/2/3 Sets"] = "Conjuntos T1/2/3";
	AL["Tier 3 Sets"] = "Conjuntos T3";
	AL["Tier 4/5/6 Sets"] = "Conjuntos T4/5/6";
	AL["PvP Reputation Sets (Level 70)"] = "Conjuntos JcJ por Reputación (Nivel 70)";
	AL["PvP Rewards (Level 60)"] = "Recompensas JcJ (Nivel 60)";
	AL["PvP Rewards (Level 70)"] = "Recompensas JcJ (Nivel 70)";
	AL["PvP Rewards (Level 80)"] = "Recompensas JcJ (Nivel 80)";
	AL["PvP Accessories (Level 60)"] = "Accesorios JcJ (Nivel 60)";
	AL["PvP Accessories - Alliance (Level 60)"] = "Accesorios - Alianza (Nivel 60)";
	AL["PvP Accessories - Horde (Level 60)"] = "Accesorios - Horda (Nivel 60)";
	AL["PvP Accessories (Level 70)"] = "Accesorios JcJ (Nivel 70)";
	AL["PvP Misc"] = "Diseños Joyería JcJ";
	AL["PvP Rewards"] = "Recompen. JcJ";
	AL["PvP Armor Sets"] = "Conjuntos de armaduras JcJ";
	AL["PvP Weapons"] = "Armas JcJ";
	AL["PvP Weapons (Level 60)"] = "Armas JcJ (Nivel 60)";
	AL["PvP Weapons (Level 70)"] = "Armas JcJ (Nivel 70)";
	AL["PvP Accessories"] = "Accesorios JcJ";
	AL["PvP Non-Set Epics"] = "Épicos JcJ No-Conjuntos";
	AL["PvP Reputation Sets"] = "Conjuntos JcJ por reputación";
	AL["Arena PvP Sets"] = "Conjuntos de Arenas JcJ";
	AL["Arena PvP Weapons"] = "Armas de Arenas JcJ";
	AL["Arena Season 2 Weapons"] = "Armas Arenas - Temporada 2";
	AL["Arena Season 3 Weapons"] = "Armas Arenas - Temporada 3";
	AL["Arena Season 4 Weapons"] = "Armas Arenas - Temporada 4";
	AL["Season 2"] = "Temporada 2";
	AL["Season 3"] = "Temporada 3";
	AL["Season 4"] = "Temporada 4";
	AL["Arathi Basin Sets"] = "Conjuntos de Cuenca de Arathi";
	AL["Class Books"] = "Libros de clase";
	AL["Tribute Run"] = "Homenaje de carrera";
	AL["Dire Maul Books"] = "Libros de La Masacre";
	AL["Random Boss Loot"] = "Botín de jefes aleatorios";
	AL["Epic Set"] = "Conjunto épico";
	AL["Rare Set"] = "Conjunto raro";
	AL["Legendary Items"] = "Objetos legendários";
	AL["Badge of Justice Rewards"] = "Recompensas con Distintivos de justicia";
	AL["Emblem of Valor Rewards"] = "Recompensas con Emblemas del valor";
	AL["Emblem of Heroism Rewards"] = "Recompensas con Emblemas de heroismo";
	AL["Emblem of Conquest Rewards"] = "Recompensas con Emblemas de conquista";
	AL["Accessories"] = "Accesorios";
	AL["Fire Resistance Gear"] = "Equipamientos con resistencia al fuego";
	AL["Arcane Resistance Gear"] = "Equipamientos con resistencia a lo arcano";
	AL["Nature Resistance Gear"] = "Equipamientos con resistencia a la naturaleza";
	AL["Frost Resistance Gear"] = "Equipamientos con resistencia al hielo";
	AL["Shadow Resistance Gear"] = "Equipamientos con resistencia a las sombras";
	AL["Tabards"] = "Tabardos";
	AL["Legendary Items for Kael'thas Fight"] = "Objetos legendários de la pelea contra Kael'thas";
	AL["BoE World Epics"] = "Épicos del mundo BoE";
	AL["Level 30-39"] = "Niveles 30-39";
	AL["Level 40-49"] = "Niveles 40-49";
	AL["Level 50-60"] = "Niveles 50-60";
	AL["BT Patterns/Plans"] = "Recetas/Planos del Templo Oscuro";
	AL["Hyjal Summit Designs"] = "Diseños de la Cumbre de Hyjal";
	AL["SP Patterns/Plans"] = "Recinto de Esclavos Recetas/Planos";
	AL["Additional Heroic Loot"] = "Botin heróico adicional";
	AL["Sigil"] = "Sigilo";
	
	--Pets
	AL["Pets"] = "Mascotas";
	AL["Vanity Pets"] = "Mascotas No-Combate";

	--Mounts
	AL["Mounts"] = "Monturas";
	AL["Card Game Mounts"] = "Monturas Barajas";
	AL["Crafted Mounts"] = "Monturas fabricadas";
	AL["Event Mounts"] = "Monturas de eventos";
	AL["PvP Mounts"] = "JcJ Monturas";
	AL["Rare Mounts"] = "Monturas raras";
	
	--Specs
	AL["Balance"] = "Equilibrio";
	AL["Feral"] = "Combate Feral";
	AL["Restoration"] = "Restauración";
	AL["Holy"] = "Sagrado";
	AL["Protection"] = "Protección";
	AL["Retribution"] = "Reprensión";
	AL["Shadow"] = "Sombras";
	--AL["Elemental"] = true,
	AL["Enhancement"] = "Mejora";
	AL["Fury"] = "Furia";
	AL["Demonology"] = "Demonología";
	AL["Destruction"] = "Destrucción";
	AL["Tanking"] = "Tanque";
	--AL["DPS"] = true,
	--Naxx Zones
	AL["Construct Quarter"] = "El Arrabal de los Ensamblajes";
	AL["Arachnid Quarter"] = "El Arrabal Arácnido";
	AL["Military Quarter"] = "El Arrabal Militar";
	AL["Plague Quarter"] = "El Arrabal de la Peste";
	--AL["Frostwyrm Lair"] = "Frostwyrm Lair"; --FALTA
	
	--NPCs missing from BabbleBoss
	AL["Trash Mobs"] = "Bichos varios";
	AL["Dungeon Set 2 Summonable"] = "Invocación Conjunto de mazmorra 2";
	AL["Highlord Kruul"] = "Alto Señor Kruul";
	--AL["Theldren"] = true,
	AL["Sothos and Jarien"] = "Sothos y Jarien";
	AL["Druid of the Fang"] = "Druida del Colmillo";
	AL["Defias Strip Miner"] = "Cantero Defias";
	AL["Defias Overseer/Taskmaster"] = "Sobrestante/Capataz Defias";
	AL["Scarlet Defender/Myrmidon"] = "Defensor/Mirmidón Escarlata";
	AL["Scarlet Champion"] = "Campeón Escarlata";
	AL["Scarlet Centurion"] = "Centurión Escarlata";
	AL["Scarlet Trainee"] = "Practicante Escarlata";
	--AL["Herod/Mograine"] = true,
	AL["Scarlet Protector/Guardsman"] = "Protector/Custodio Escarlata";
	AL["Shadowforge Flame Keeper"] = "Vigilante de la Llama Forjatiniebla";
	--AL["Olaf"] = true,
	AL["Eric 'The Swift'"] = "Eric 'El Veloz'";
	AL["Shadow of Doom"] = "Sombras del Apocalipsis";
	AL["Bone Witch"] = "Bruja Osaria";
	AL["Lumbering Horror"] = "Horror pesado";
	AL["Avatar of the Martyred"] = "Avatar de los Martirizados";
	--AL["Yor"] = true,
	AL["Nexus Stalker"] = "Acechador nexo";
	AL["Auchenai Monk"] = "Monje Auchenai";
	AL["Cabal Fanatic"] = "Fanático de la Cábala";
	AL["Unchained Doombringer"] = "Fatídico desencadenado";
	AL["Crimson Sorcerer"] = "Hechicero Carmesí";
	AL["Thuzadin Shadowcaster"] = "Taumaturgo oscuro Thuzadin";
	AL["Crimson Inquisitor"] = "Inquisidor Carmesí";
	AL["Crimson Battle Mage"] = "Mago de batalla Carmesí";
	AL["Ghoul Ravener"] = "Cuervoso necrófago";
	AL["Spectral Citizen"] = "Ciudadano espectral";
	AL["Spectral Researcher"] = "Investigador espectral";
	AL["Scholomance Adept"] = "Adepto de Scholomance";
	AL["Scholomance Dark Summoner"] = "Invocador Oscuro de Scholomance";
	AL["Blackhand Elite"] = "Élite Puño Negro";
	AL["Blackhand Assassin"] = "Asesino Puño Negro";
	AL["Firebrand Pyromancer"] = "Piromántico Pirotigma";
	AL["Firebrand Invoker"] = "Convocador Pirotigma";
	AL["Firebrand Grunt"] = "Bruto Pirotigma";
	AL["Firebrand Legionnaire"] = "Legionario Pirotigma";
	AL["Spirestone Warlord"] = "Señor de la Guerra Cumbrerroca";
	AL["Spirestone Mystic"] = "Místico Cumbrerroca";
	AL["Anvilrage Captain"] = "Capitán Yunque Colérico";
	AL["Anvilrage Marshal"] = "Alguacil de Yunque Colérico";
	AL["Doomforge Arcanasmith"] = "Arcanorrero de la Forja Maldita";
	AL["Weapon Technician"] = "Técnico de armas";
	AL["Doomforge Craftsman"] = "Artesano de la Forja Maldita";
	AL["Murk Worm"] = "Gusano de la oscuridad";
	AL["Atal'ai Witch Doctor"] = "Médico brujo Atal'ai";
	AL["Raging Skeleton"] = "Esqueleto enfurecido";
	AL["Ethereal Priest"] = "Sacerdote etéreo";
	AL["Sethekk Ravenguard"] = "Guardia cuervo Sethekk";
	AL["Time-Lost Shadowmage"] = "Mago de las Sombras Tiempo Perdido";
	AL["Coilfang Sorceress"] = "Hechicera Colmillo Torcido";
	AL["Coilfang Oracle"] = "Oráculo Colmillo Torcido";
	AL["Shattered Hand Centurion"] = "Centurión Mano Destrozada";
	AL["Eredar Deathbringer"] = "Libramorte Eredar";
	AL["Arcatraz Sentinel"] = "Centinela de Arcatraz";
	AL["Gargantuan Abyssal"] = "Abissal inmenso";
	AL["Sunseeker Botanist"] = "Botánica Buscasol";
	AL["Sunseeker Astromage"] = "Astromago Buscasol";
	AL["Durnholde Rifleman"] = "Fusilero de Durnholde";
	AL["Rift Keeper/Rift Lord"] = "Vigilante/Señor de la falla";
	AL["Crimson Templar"] = "Templario Carmesí";
	AL["Azure Templar"] = "Templario azur";
	AL["Hoary Templar"] = "Templario vetusto";
	AL["Earthen Templar"] = "Templario de tierra";
	AL["The Duke of Cynders"] = "Duque de las Brasas";
	AL["The Duke of Fathoms"] = "Duque de las Profundidades";
	AL["The Duke of Zephyrs"] = "Duque de los Céfiros";
	AL["The Duke of Shards"] = "Duque de las Esquirlas";
	AL["Aether-tech Assistant"] = "Ayudante técnico aether";
	AL["Aether-tech Adept"] = "Aether-tech Adept"; --FALTA
	AL["Aether-tech Master"] = "Aether-tech Master"; --FALTA
	AL["Trelopades"] = "Trelopades"; --FALTA
	AL["King Dorfbruiser"] = "King Dorfbruiser"; --FALTA
	AL["Gorgolon the All-seeing"] = "Gorgolon the All-seeing"; --FALTA
	AL["Matron Li-sahar"] = "Matrona Li-sahar";
	AL["Solus the Eternal"] = "Solus el Eterno";
	--AL["Balzaphon"] = true,
	AL["Lord Blackwood"] = "Lord Bosque Negro";
	--AL["Revanchion"] = true,
	--AL["Scorn"] = true,
	--AL["Sever"] = true,
	AL["Lady Falther'ess"] = "Lady Falther'ess";
	AL["Smokywood Pastures Vendor"] = "Vendedor de Pastos de Bosquehumeante";
	--AL["Shartuul"] = true,
	AL["Darkscreecher Akkarai"] = "Estridador oscuro Akkarai";
	--AL["Karrog"] = true,
	AL["Gezzarak the Huntress"] = "Gezzarak la Cazadora";
	AL["Vakkiz the Windrager"] = "Vakkiz el Furibundo del Viento";
	--AL["Terokk"] = true,
	AL["Armbreaker Huffaz"] = "Partebrazos Huffaz";
	AL["Fel Tinkerer Zortan"] = "Manitas vil Zortan";
	--AL["Forgosh"] = true,
	--AL["Gul'bor"] = true,
	AL["Malevus the Mad"] = "Malevus el Loco";
	AL["Porfus the Gem Gorger"] = "Porfus el Engullidor de gemas";
	AL["Wrathbringer Laz-tarash"] = "Encolerizador Laz-tarash";
	AL["Bash'ir Landing Stasis Chambers"] = "Cámaras de éxtasis del Alot Bash'ir";
	AL["Templars"] = "Templarios";
	AL["Dukes"] = "Duques";
	AL["High Council"] = "Consejero mayor";
	AL["Headless Horseman"] = "Jinete decapitado";
	AL["Barleybrew Brewery"] = "Cervecería Cebadiz"; --Comprobar
	AL["Thunderbrew Brewery"] = "Cervecería Cebatruenos"; --Comprobar
	AL["Gordok Brewery"] = "Cervecería Gordok"; --Comprobar
	AL["Drohn's Distillery"] = "Destilería de Drohn";
	AL["T'chali's Voodoo Brewery"] = "Cervecería Voodoo de T'chali";
	AL["Scarshield Quartermaster"] = "Intendente del Escudo del Estigma";
	AL["Overmaster Pyron"] = "Maestro Supremo Pyron";
	AL["Father Flame"] = "Padre llama";
	--AL["Thomas Yance"] = true,
	AL["Knot Thimblejack"] = "Knot Thimblejack";
	AL["Shen'dralar Provisioner"] = "Proveedor Shen'dralar";
	AL["Namdo Bizzfizzle"] = "Namdo Silvabín";
	AL["The Nameles Prophet"] = "El profeta sin nombre";
	AL["Zelemar the Wrathful"] = "Zelemar el Colérico";
	--AL["Henry Stern"] = true,
	AL["Aggem Thorncurse"] = "Aggem Malaespina";
	--AL["Roogug"] = true,
	AL["Rajaxx's Captains"] = "Capitanes de Rajaxx";
	AL["Razorfen Spearhide"] = "Lanceur de Tranchebauge";
	AL["Rethilgore"] = "Rethilgore";
	AL["Kalldan Felmoon"] = "Kalldan Lunavil";
	AL["Magregan Deepshadow"] = "Magregan Sombraprofunda";
	--AL["Lord Ahune"] = true,
	AL["Coren Direbrew"] = "Coren Cerveza Temible";
	--AL["Don Carlos"] = true,
	--AL["Thomas Yance"] = "Thomas Yance";
	AL["Aged Dalaran Wizard"] = "Zahorí de Dalaran envejecido";
	AL["Cache of the Legion"] = "Alijo de la Legión";
	AL["Rajaxx's Captains"] = "Capitanes de Rajaxx";
	AL["Felsteed"] = "Corcel vil";
	AL["Shattered Hand Executioner"] = "Verdugo Mano Destrozada";	 
	AL["Commander Stoutbeard"] = "Commander Stoutbeard"; --FALTA
	AL["Bjarngrim"] = "Bjarngrim"; --FALTA
	AL["Loken"] = "Loken"; --FALTA
	AL["Time-Lost Proto Drake"] = "Protodraco Tiempo Perdido";
	
	--Zones
	AL["World Drop"] = "Hallazgos del Mundo";
	AL["Sunwell Isle"] = "Isla de Kel'Danas";
	
	--Shortcuts for Bossname files
	AL["LBRS"] = "CRNI";
	AL["UBRS"] = "CRNS";
	AL["CoT1"] = "CdT1";
	AL["CoT2"] = "CdT2";
	--  AL["Scholo"] = true,
	--  AL["Strat"] = true,
	AL["Serpentshrine"] = "Serpiente";
	--AL["Avatar"] = true,	

	--Chests, etc
	AL["Dark Coffer"] = "El cofre oscuro";
	AL["The Secret Safe"] = "El secreto seguro";
	AL["The Vault"] = "La caja fuerte";
	AL["Ogre Tannin Basket"] = "Cesta de Ogro Tanino";
	AL["Fengus's Chest"] = "Cofre de Fengus";
	AL["The Prince's Chest"] = "El cofre del Príncipe";
	AL["Doan's Strongbox"] = "Caja fuerte de Doan";
	AL["Frostwhisper's Embalming Fluid"] = "Líquido de embalsamar Levescarcha";
	AL["Unforged Rune Covered Breastplate"] = "Coraza cubierta de runas sin forjar";
	AL["Malor's Strongbox"] = "Caja fuerte de Malor";
	AL["Unfinished Painting"] = "Pintura sin terminar"; --Comprobar
	AL["Felvine Shard"] = "Fragmento de gangrevid";
	AL["Baelog's Chest"] = "Cofre de Baelog";
	AL["Lorgalis Manuscript"] = "Manuscrito de Lorgalis";
	AL["Fathom Core"] = "Núcleo de las profundidades";
	AL["Conspicuous Urn"] = "Urna llamativa";
	AL["Gift of Adoration"] = "Ofrenda de adoración";
	AL["Box of Chocolates"] = "Caja de bombones";
	AL["Treat Bag"] = "Bolsa de premios";
	AL["Gaily Wrapped Present"] = "Regalo con envoltorio alegre";
	AL["Festive Gift"] = "Obsequio festivo";
	AL["Ticking Present"] = "Obsequio que hace tic-tac";
	AL["Gently Shaken Gift"] = "Regalo ligeramente agitado";
	AL["Carefully Wrapped Present"] = "Presente envuelto con cuidado";
	AL["Winter Veil Gift"] = "Regalo de Fiesta de Invierno";
	AL["Smokywood Pastures Extra-Special Gift"] = "Obsequio megaespecial de Pastos de Bosquehumeante";
	AL["Brightly Colored Egg"] = "Huevos de colores brillantes"; --Comprobar
	AL["Lunar Festival Fireworks Pack"] = "Paquete de fuegos de artificio del Festival Lunar";
	AL["Lucky Red Envelope"] = "Sobre rojo de la suerte";
	AL["Small Rocket Recipes"] = "Recetas de cohetes pequeños";
	AL["Large Rocket Recipes"] = "Recetas de cohetes grandes";
	AL["Cluster Rocket Recipes"] = "Recetas de traca de cohetes";
	AL["Large Cluster Rocket Recipes"] = "Recetas de traca de cohetes grandes";
	AL["Timed Reward Chest"] = "Cofre de recompensa con tiempo"; --Comprobar
	AL["Timed Reward Chest 1"] = "Cofre de recompensa con tiempo 1";
	AL["Timed Reward Chest 2"] = "Cofre de recompensa con tiempo 2";
	AL["Timed Reward Chest 3"] = "Cofre de recompensa con tiempo 3";
	AL["Timed Reward Chest 4"] = "Cofre de recompensa con tiempo 4";
	AL["The Talon King's Coffer"] = "El cofre del Rey Talon";
	AL["Krom Stoutarm's Chest"] = "Tesoro de Krom Rudebras";
	AL["Garrett Family Chest"] = "Tesoro de la familia Garrett";
	AL["Reinforced Fel Iron Chest"] = "Cofre reforzado de hierro vil";
	AL["DM North Tribute Chest"] = "Cofre del tributo de LM norte";
	AL["The Saga of Terokk"] = "La Saga de Terokk";
	AL["First Fragment Guardian"] = "Guardián del primer trozo";
	AL["Second Fragment Guardian"] = "Guardián del segundo trozo";
	AL["Third Fragment Guardian"] = "Guardián del tercer trozo";
	AL["Overcharged Manacell"] = "Célula de maná sobrecargada";
	AL["Mysterious Egg"] = "Huevo misterioso";
	AL["Hyldnir Spoils"] = "Botín Hyldnir";
	AL["Ripe Disgusting Jar"] = "Tarro desagradable maduro";
	AL["Cracked Egg"] = "Huevo roto";
	
	--World Events
	AL["Abyssal Council"] = "Consejo abisal";
	AL["Bash'ir Landing Skyguard Raid"] = "Punto de anclaje de Bash'ir";
	AL["Brewfest"] = "Fiesta de la Cerveza";
	AL["Children's Week"] = "Semana de los niños";
	AL["Elemental Invasion"] = "Invasión de elementales";
	AL["Ethereum Prison"] = "Prisión de los Etereum";
	AL["Feast of Winter Veil"] = "Festival de Invierno";
	AL["Gurubashi Arena Booty Run"] = "El cofre pirata de Gurubashi";
	AL["Hallow's End"] = "Halloween";
	AL["Harvest Festival"] = "Festival de la Cosecha";
	AL["Love is in the Air"] = "Amor en el aire";
	AL["Lunar Festival"] = "Festival Lunar";
	AL["Midsummer Fire Festival"] = "Festival del Solsticio de Verano";
	AL["Noblegarden"] = "El jardín de los nobles";
	AL["Skettis"] = "Skettis";
	AL["Stranglethorn Fishing Extravaganza"] = "Concurso de Pesca";
--	AL["Argent Tournament"] = "Torneo Argenta"; -- duplicated

	--Help Frame
	AL["Help"] = "Ayuda";
	AL["AtlasLoot Help"] = "Ayuda Atlasloot";
	AL["For further help, see our website and forums: "] = "Para mas ayuda consulta nuestra web y foros: ";
	AL["How to open the standalone Loot Browser:"] = "Como abrir el buscador de botín estandar:";
	AL["If you have AtlasLootFu enabled, click the minimap button, or alternatively a button generated by a mod like Titan or FuBar.  Finally, you can type '/al' in the chat window."] = "Si tienes AtlasLootFu activado, haz click en el botón del minimapa, o alternativamente en algún botón generado por otro addon como Titan o FuBar.  Finalmente, puedes escribir '/al' en la ventana del chat.";
	AL["How to view an 'unsafe' item:"] = "Como ver un objeto 'no seguro':";
	AL["Unsafe items have a red border around the icon and are marked because you have not seen the item since the last patch or server restart. Right-click the item, then move your mouse back over the item or click the 'Query Server' button at the bottom of the loot page."] = "Los objetos no seguros tienen un borde rojo alrededor de su icono y son marcados porque no has visto dicho objeto en el juego desde el último parche o reinicio de servidor. Haz click-dcho en el objeto y después mueve el cursor por encima del icono o haz click en 'pregunta al servidor' en el pie de la ventana de botín.";
	AL["How to view an item in the Dressing Room:"] = "Como ver un objeto en la ventana del provador:";
	AL["Simply Ctrl+Left Click on the item.  Sometimes the dressing room window is hidden behind the Atlas or AtlasLoot windows, so if nothing seems to happen move your Atlas or AtlasLoot windows and see if anything is hidden."] = "Simplemente haz click Ctrl+Izdo en el objeto.  Algunas veces la ventana del provador está escondida detrás de las ventanas del Atlas o del Atlasloot por lo que si ves que no pasa nada, mueve tu ventana del Atlas y del Atlasloot.";
	AL["How to link an item to someone else:"] = "Como enlazar un objeto a otra persona:";
	AL["Shift+Left Click the item like you would for any other in-game item"] = "Haz lick Shift+izdo en el objeto como harías con cualquier otro objeto del juego";
	AL["How to add an item to the wishlist:"] = "Como añadir un objeto a la lista deseada:";
	AL["Alt+Left Click any item to add it to the wishlist."] = "Haz click Alt+izdo en el objeto que quieres añadir a la lista.";
	AL["How to delete an item from the wishlist:"] = "Como eliminar un objeto de la lista deseada:";
	AL["While on the wishlist screen, just Alt+Left Click on an item to delete it."] = "Mientras estás en la ventana de la lista deseada, solo tienes que hacer click Alt+izdo en el objeto a borrar.";
	AL["What else does the wishlist do?"] = "¿Que mas hace la lista deseada?";
	AL["If you Left Click any item on the wishlist, you can jump to the loot page the item comes from.  Also, on a loot page any item already in your wishlist is marked with a yellow star."] = "Si haces click izquierdo en un objeto de tu lista deseada, puedes saltar a la ventana de botín de donde proviene.  Del mismo modo, los objetos que se encuentran en tu lista aparecen marcados con una estrella amarilla.";
	AL["HELP!! I have broken the mod somehow!"] = "¡¡AYUDA!! De alguna manera he roto el addon";
	AL["Use the reset buttons available in the options menu, or type '/al reset' in your chat window."] = "Utiliza los botones de reinicio disponibles en el menú de opciones o escribe '/al reset' en tu ventana de chat.";
end