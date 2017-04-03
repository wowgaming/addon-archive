--Create the library instance
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");

local AL = AceLocale:NewLocale("AtlasLoot", "deDE", false);

--Register translations
if AL then

	-- Text strings for UI objects
	AL["AtlasLoot"] = "AtlasLoot";
	AL["Select Loot Table"] = "Beuteverzeichnis";
	AL["Select Sub-Table"] = "Unterverzeichnis";
	AL["Drop Rate: "] = "Droprate: ";
	-- AL["DKP"] = "DKP";
	AL["Priority:"] = "Priorität:";
	AL["Click boss name to view loot."] = "Boss klicken um Beute zu sehen.";
	AL["Various Locations"] = "Verschiedene Orte";
	AL["This is a loot browser only.  To view maps as well, install either Atlas or Alphamap."] = "Atlasloot zeigt nur Loot an. Falls Sie Karten wünschen, installieren Sie 'Atlas' oder 'Alphamap'.";
	AL["Toggle AL Panel"] = "AtlasLoot-Leiste ein/aus";
	AL["Back"] = "Zurück";
	AL["Level 60"] = "Stufe 60";
	AL["Level 70"] = "Stufe 70";
	AL["Level 80"] = "Stufe 80";
	AL["|cffff0000(unsafe)"] = " |cffff0000(unsicher)";
	AL["Misc"] = "Sonstiges";
	AL["Miscellaneous"] = "Sonstiges";
	AL["Rewards"] = "Belohnungen";
	AL["Show 10 Man Loot"] = "Beute (10 Spieler)";
	AL["Show 25 Man Loot"] = "Beute (25 Spieler)";
	AL["Factions - Original WoW"] = "Fraktionen - Klassisches WoW";
	AL["Factions - Burning Crusade"] = "Fraktionen - Burning Crusade";
	AL["Factions - Wrath of the Lich King"] = "Fraktionen - Wrath of the Lich King";
	AL["Choose Table ..."] = "Verzeichnis wählen ...";
	AL["Unknown"] = "Unbekannt";
	AL["Add to QuickLooks:"] = "Lesezeichen hinzufügen";
	AL["Assign this loot table\n to QuickLook"] = "Dieses Beuteverzeichnis dem\n Lesezeichen hinzufügen";
	AL["Query Server"] = "Serverabfrage";
	AL["Reset Frames"] = "Fenster zurücksetzen";
	AL["Reset Wishlist"] = "Wunschzettel zurücksetzen";
	AL["Reset Quicklooks"] = "Lesezeichen zurücksetzen";
	AL["Select a Loot Table..."] = "Wähle ein Beuteverzeichnis ...";
	AL["OR"] = "ODER";
	AL["FuBar Options"] = "FuBar-Optionen";
	AL["Attach to Minimap"] = "An der Minimap anbringen";
	AL["Hide FuBar Plugin"] = "FuBar Plugin verstecken";
	AL["Show FuBar Plugin"] = "FuBar Plugin anzeigen";
	-- AL["Position:"] = "Position:";
	AL["Left"] = "Links";
	AL["Center"] = "Mitte";
	AL["Right"] = "Rechts";
	AL["Hide Text"] = "Text verstecken";
	AL["Hide Icon"] = "Icon verstecken";
	AL["Minimap Button Options"] = "Minimap-Button Optionen";

	-- Text for Options Panel
	AL["Atlasloot Options"] = "AtlasLoot Optionen";
	AL["Safe Chat Links"] = "Sichere Chatlinks";
	AL["Default Tooltips"] = "Standard-Tooltips";
	AL["Lootlink Tooltips"] = "Lootlink-Tooltips";
	AL["|cff9d9d9dLootlink Tooltips|r"] = "|cff9d9d9dLootlink-Tooltips|r";
	AL["ItemSync Tooltips"] = "ItemSync-Tooltpis";
	AL["|cff9d9d9dItemSync Tooltips|r"] = "|cff9d9d9dItemSync-Tooltips|r";
	AL["Use EquipCompare"] = "EquipCompare verwenden";
	AL["|cff9d9d9dUse EquipCompare|r"] = "|cff9d9d9dBenutze EquipCompare|r";
	AL["Show Comparison Tooltips"] = "Zeige eigenes Item zum Vergleich";
	AL["Make Loot Table Opaque"] = "Schwarzer Hintergrund";
	AL["Show itemIDs at all times"] = "Item-IDs immer anzeigen";
	AL["Hide AtlasLoot Panel"] = "AtlasLoot-Leiste ausblenden";
	AL["Show Basic Minimap Button"] = "Minimap-Button anzeigen";
	AL["|cff9d9d9dShow Basic Minimap Button|r"] = "|cff9d9d9dMinimap-Button anzeigen|r";
	AL["Set Minimap Button Position"] = "Position des Buttons an der Minimap festlegen";
	AL["Suppress Item Query Text"] = "Meldung der Serverabfrage verstecken";
	AL["Notify on LoD Module Load"] = "Meldung beim automatischen Laden der Module";
	AL["Load Loot Modules at Startup"] = "Module beim Start laden";
	AL["Loot Browser Scale: "] = "AtlasLoot Skalierung";
	AL["Button Position: "] = "Position des Buttons";
	AL["Button Radius: "] = "Radius des Buttons";
	AL["Done"] = "Fertig";
	AL["FuBar Toggle"] = "FuBar ein/aus";
	AL["Search Result: %s"] = "Suchergebnis: %s";
	AL["Search on"] = "Suchen in";
	AL["All modules"] = "Alle Module";
	AL["If checked, AtlasLoot will load and search across all the modules."] = "Lässt AtlasLoot in allen Modulen suchen.";
	AL["Search options"] = "Suchoptionen";
	AL["Partial matching"] = "Teilweise Übereinstimmung";
	AL["If checked, AtlasLoot search item names for a partial match."] = "Lässt AtlasLoot die Itemnamen mit teilweisen Übereinstimmungen durchsuchen.";
	AL["You don't have any module selected to search on!"] = "Du hast kein Modul zur Suche ausgewählt";
	AL["Treat Crafted Items:"] = "Herstellbare Gegenstände behandeln";
	AL["As Crafting Spells"] = "als Zauber";
	AL["As Items"] = "als Gegenstände";
	AL["Loot Browser Style:"] = "AtlasLoot Design:";
	AL["New Style"] = "Modernes Design";
	AL["Classic Style"] = "Klassisches Design";

	-- Slash commands
	AL["reset"] = "Zurücksetzen";
	AL["options"] = "Optionen";
	AL["Reset complete!"] = "AtlasLoot wurde erfolgreich zurückgesetzt!";

	-- AtlasLoot Panel
	AL["Collections"] = "Sammlungen";
	AL["Crafting"] = "Berufe";
	AL["Factions"] = "Fraktionen";
	AL["Load Modules"] = "Module laden";
	AL["Options"] = "Optionen";
	AL["PvP Rewards"] = "PvP Belohnungen";
	AL["QuickLook"] = "Lesezeichen";
	AL["World Events"] = "Weltevents";

	-- AtlasLoot Panel - Search
	AL["Clear"] = "Löschen";
	AL["Last Result"] = "Letzte Suche";
	AL["Search"] = "Suchen";

	-- AtlasLoot Browser Menus
	AL["Classic Instances"] = "Instanzen (Klassisch)";
	AL["BC Instances"] = "Instanzen (BC)";
	AL["Sets/Collections"] = "Sammlungen";
	AL["Reputation Factions"] = "Fraktionen";
	AL["WotLK Instances"] = "Instanzen (WotLK)";
	AL["World Bosses"] = "Weltbosse";
	AL["Close Menu"] = "Menü schließen";

	-- Crafting Menu
	AL["Crafting Daily Quests"] = "Tägliche Quests der Berufe";
	AL["Cooking Daily"] = "Tägliche Kochquest";
	AL["Fishing Daily"] = "Tägliche Angelquest";
	AL["Jewelcrafting Daily"] = "Tägliche Juwelierquest";
	AL["Crafted Sets"] = "Herstellbare Sets";
	AL["Crafted Epic Weapons"] = "Herstellbare epische Waffen";
	AL["Dragon's Eye"] = "Drachenauge";

	-- Sets/Collections Menu
	AL["Badge of Justice Rewards"] = "Abzeichen der Gerechtigkeit";
	AL["Emblem of Valor Rewards"] = "Emblem der Ehre";
	AL["Emblem of Heroism Rewards"] = "Emblem des Heldentums";
	AL["Emblem of Conquest Rewards"] = "Emblem der Eroberung";
	AL["Emblem of Triumph Rewards"] = "Emblem des Triumphs";
	AL["Emblem of Frost Rewards"] = "Emblem des Frosts";
	AL["BoE World Epics"] = "Epische Weltdrops (BoE)";
	AL["Dungeon 1/2 Sets"] = "Sets (Dungeon 1/2)";
	AL["Dungeon 3 Sets"] = "Sets (Dungeon 3)";
	AL["Legendary Items"] = "Legendäre Gegenstände";
	AL["Mounts"] = "Reittiere";
	AL["Vanity Pets"] = "Haustiere";
	AL["Misc Sets"] = "Sets (Sonstige)";
	AL["Classic Sets"] = "Sets (Klassische)";
	AL["Burning Crusade Sets"] = "Sets (Burning Crusade)";
	AL["Wrath Of The Lich King Sets"] = "Sets (Wrath of the Lich King)";
	AL["Ruins of Ahn'Qiraj Sets"] = "Sets (Ruinen von Ahn'Quiraj)";
	AL["Temple of Ahn'Qiraj Sets"] = "Sets (Tempel von Ahn'Quiraj)";
	AL["Tabards"] = "Wappenröcke";
	AL["Tier 1/2 Sets"] = "Sets (Tier 1/2)";
	AL["Tier 1/2/3 Sets"] = "Sets (Tier 1/2/3)";
	AL["Tier 3 Sets"] = "Sets (Tier 3)";
	AL["Tier 4/5/6 Sets"] = "Sets (Tier 4/5/6)";
	AL["Tier 7/8 Sets"] = "Sets (Tier 7/8)";
	AL["Upper Deck Card Game Items"] = "Kartenspiel Gegenstände";
	AL["Zul'Gurub Sets"] = "Sets (Zul'Gurub)";

	-- Factions Menu
	AL["Original Factions"] = "Fraktionen (Klassisch)";
	AL["BC Factions"] = "Fraktionen (BC)";
	AL["WotLK Factions"] = "Fraktionen (WotLK";

	-- PvP Menu
	AL["Arena PvP Sets"] = "PvP-Sets (Arena)";
	AL["PvP Rewards (Level 60)"] = "PvP-Belohnungen (Stufe 60)";
	AL["PvP Rewards (Level 70)"] = "PvP-Belohnungen (Stufe 70)";
	AL["PvP Rewards (Level 80)"] = "PvP-Belohnungen (Stufe 80)";
	AL["Arathi Basin Sets"] = "Arathibecken (Sets)";
	AL["PvP Accessories"] = "PvP-Zubehör";
	AL["PvP Armor Sets"] = "PvP-Rüstungssets";
	AL["PvP Weapons"] = "PvP-Waffen";
	AL["PvP Non-Set Epics"] = "PvP Nicht-Set Epics";
	AL["PvP Reputation Sets"] = "PvP-Rufbelohnungen";
	AL["Arena PvP Weapons"] = "PvP-Waffen (Arena)";
	AL["PvP Misc"] = "PvP (Sonstiges)";
	AL["PVP Gems/Enchants/Jewelcrafting Designs"] = "PvP Edelsteine/Verzauberungen/Rezepte";
	AL["Level 80 PvP Sets"] = "PvP-Sets (Stufe 80)";
	AL["Old Level 80 PvP Sets"] = "Alte PvP-Sets (Stufe 80)";
	AL["Arena Season 7/8 Sets"] = "PvP-Sets (7./8. Arenasaison)";
	AL["PvP Class Items"] = "PvP-Gegenstände (Klassenspezifisch)";
	AL["NOT AVAILABLE ANYMORE"] = "NICHT MEHR VERFÜGBAR";

	-- World Events
	AL["Abyssal Council"] = "Abyssischer Rat";
	AL["Argent Tournament"] = "Argentumturnier";
	AL["Bash'ir Landing Skyguard Raid"] = "Landeplatz von Bash'ir Himmelswache Raid";
	AL["Brewfest"] = "Braufest";
	AL["Children's Week"] = "Kinderwoche";
	AL["Day of the Dead"] = "Tag der Toten";
	AL["Elemental Invasion"] = "Invasion der Elementare";
	AL["Ethereum Prison"] = "Gefängnis des Astraleums";
	AL["Feast of Winter Veil"] = "Winterhauchfest";
	AL["Gurubashi Arena Booty Run"] = "Gurubashiarena";
	AL["Hallow's End"] = "Schlotternächte";
	AL["Harvest Festival"] = "Erntedankfest";
	AL["Love is in the Air"] = "Liebe liegt in der Luft";
	AL["Lunar Festival"] = "Mondfest";
	AL["Midsummer Fire Festival"] = "Sonnenwendfest";
	AL["Noblegarden"] = "Nobelgarten";
	AL["Pilgrim's Bounty"] = "Pilgerfreuden";
	-- AL["Skettis"] = true;
	AL["Stranglethorn Fishing Extravaganza"] = "Anglerwettbewerb im Schlingendorntal";

	-- Minimap Button
	AL["|cff1eff00Left-Click|r Browse Loot Tables"] = "|cff1eff00Linksklick|r Beuteverzeichnis durchsuchen";
	AL["|cffff0000Right-Click|r View Options"] = "|cff1eff00Rechtsklick|r Optionen anzeigen";
	AL["|cffff0000Shift-Click|r View Options"] = "|cffff0000Shiftklick|r Optionen anzeigen";
	AL["|cffccccccLeft-Click + Drag|r Move Minimap Button"] = "|cffccccccLinksklick + Ziehen|r Minimap Button bewegen";
	AL["|cffccccccRight-Click + Drag|r Move Minimap Button"] = "|cffccccccRechtsklick + Ziehen|r Minimap Button bewegen";

	-- Filter
	-- AL["Filter"] = true;
	AL["Select All Loot"] = "Komplette Beute auswählen";
	AL["Apply Filter:"] = "Filter anwenden:";
	AL["Armor:"] = "Rüstung:";
	AL["Melee weapons:"] = "Nahkampfwaffen:";
	AL["Ranged weapons:"] = "Fernkampfwaffen:";
	AL["Relics:"] = "Relikte:";
	AL["Other:"] = "Anderes:";

	-- Wishlist
	AL["Close"] = "Schließen";
	AL["Wishlist"] = "Wunschzettel";
	AL["Own Wishlists"] = "Eigene Wunschzettel";
	AL["Other Wishlists"] = "Andere Wunschzettel";
	AL["Shared Wishlists"] = "Geteilte Wunschzettel";
	AL["Mark items in loot tables"] = "Items im Verzeichnis hervorheben";
	AL["Mark items from own Wishlist"] = "Items eigener Wunschzettel hervorheben";
	AL["Mark items from all Wishlists"] = "Items aller Wunschzettel hervorheben";
	AL["Enable Wishlist Sharing"] = "Teilen von Wunschzetteln aktivieren";
	AL["Auto reject in combat"] = "Automatisches Ablehnen im Kampf";
	AL["Always use default Wishlist"] = "Immer Standard-Wunschzettel verwenden";
	AL["Add Wishlist"] = "Wunschzettel hinzufügen";
	AL["Edit Wishlist"] = "Wunschzettel bearbeiten";
	AL["Show More Icons"] = "Weitere Icons anzeigen";
	AL["Wishlist name:"] = "Name des Wunschzettels:";
	AL["Delete"] = "Löschen";
	AL["Edit"] = "Bearbeiten";
	AL["Share"] = "Teilen";
	AL["Show all Wishlists"] = "Alle Wunschzettel zeigen";
	AL["Show own Wishlists"] = "Eigene Wunschzettel zeigen";
	AL["Show shared Wishlists"] = "Geteilte Wunschzettel zeigen";
	AL["You must wait "] = "Sie müssen ";
	AL[" seconds before you can send a new Wishlist to "] = " Sekunden warten bis Sie einen neuen Wunschzettel schicken können an ";
	AL["Send Wishlist (%s) to"] = "Wunschzettel (%s) senden an";
	AL["Send"] = "Senden";
	AL["Cancel"] = "Abbrechen";
	AL["Delete Wishlist %s?"] = "Wunschzettel %s löschen?";
	AL["%s sends you a Wishlist. Accept?"] = "%s sendet einen Wunschzettel. Annehmen?";
	AL[" tried to send you a Wishlist. Rejected because you are in combat."] = " hat versucht einen Wunschzettel zu senden. Wegen Kampf abgelehnt.";
	AL[" rejects your Wishlist."] = " lehnt den Wunschzettel ab.";
	AL["You can't send Wishlists to yourself"] = "Sie können siche selber keinen Wunschzettel senden";
	AL["Please set a default Wishlist."] = "Bitte Standard-Wunschzettel festlegen.";
	AL["Set as default Wishlist"] = "Zum Standard-Wunschzettel machen";

	-- Misc Inventory related words
	AL["Enchant"] = "Verzauberung";
	AL["Scope"] = "Zielfernrohr";
	AL["Darkmoon Faire Card"] = "Dunkelmond-Karte";
	-- AL["Banner"] = true;
	-- AL["Set"] = true;
	AL["Token"] = "Gutschein";
	AL["Tokens"] = "Gutscheine";
	-- AL["Token Hand-Ins"] = true;
	AL["Skinning Knife"] = "Kürschnermesser";
	AL["Herbalism Knife"] = "Kräuterkundemesser";
	AL["Fish"] = "Fisch";
	AL["Combat Pet"] = "Haustier (Kampf)";
	AL["Fireworks"] = "Feuerwerk";
	AL["Fishing Lure"] = "Köder";

	-- Extra inventory stuff
	AL["Cloak"] = "Umhang";
	AL["Sigil"] = "Siegel"; -- Can be added to BabbleInv

	-- Alchemy
	AL["Battle Elixirs"] = "Kampfelixiere";
	AL["Guardian Elixirs"] = "Wächterelixiere";
	AL["Potions"] = "Tränke";
	AL["Transmutes"] = "Transmutieren";
	AL["Flasks"] = "Fläschchen";

	-- Enchanting
	AL["Enchant Boots"] = "Stiefel verzaubern";
	AL["Enchant Bracer"] = "Armschienen verzaubern";
	AL["Enchant Chest"] = "Brust verzaubern";
	AL["Enchant Cloak"] = "Umhang verzaubern";
	AL["Enchant Gloves"] = "Handschuhe verzaubern";
	AL["Enchant Ring"] = "Ring verzaubern";
	AL["Enchant Shield"] = "Schild verzaubern";
	AL["Enchant 2H Weapon"] = "2H Waffe verzaubern";
	AL["Enchant Weapon"] = "Waffe verzaubern";

	-- Engineering
	AL["Ammunition"] = "Munition";
	AL["Explosives"] = "Sprengladungen";

	-- Inscription
	AL["Major Glyph"] = "Erhebliche Glyphe";
	AL["Minor Glyph"] = "Geringe Glyphe";
	AL["Scrolls"] = "Rollen";
	AL["Off-Hand Items"] = "Nebenhand-Gegenstände";
	AL["Reagents"] = "Reagenzien";
	AL["Book of Glyph Mastery"] = "Buch der Glyphenbeherrschung";

	-- Leatherworking
	AL["Leather Armor"] = "Lederrüstungen";
	AL["Mail Armor"] = "Schwere Rüstungen";
	AL["Cloaks"] = "Umhänge";
	AL["Item Enhancements"] = "Gegenstandsverbesserungen";
	AL["Quivers and Ammo Pouches"] = "Köcher und Munitionsbeutel";
	AL["Drums, Bags and Misc."] = "Trommeln, Taschen, usw.";

	-- Tailoring
	AL["Cloth Armor"] = "Stoffrüstungen";
	AL["Shirts"] = "Hemden";
	AL["Bags"] = "Taschen";

	-- Labels for loot descriptions
	AL["Classes:"] = "Klassen:";
	AL["This Item Begins a Quest"] = "Dieser Gegenstand startet eine Quest";
	AL["Quest Item"] = "Questgegenstand";
	AL["Old Quest Item"] = "Alter Questgegenstand";
	AL["Quest Reward"] = "Questbelohnung";
	AL["Old Quest Reward"] = "Alte Questbelohnung";
	AL["Shared"] = "geteilter Loot";
	AL["Unique"] = "Einzigartig";
	AL["Right Half"] = "Rechte Hälfte";
	AL["Left Half"] = "Linke Hälfte";
	AL["28 Slot Soul Shard"] = "28er-Behälter Seelensplitter";
	AL["20 Slot"] = "20 Platz";
	AL["18 Slot"] = "18 Platz";
	AL["16 Slot"] = "16 Platz";
	AL["10 Slot"] = "10 Platz";
	AL["(has random enchantment)"] = "(zufällige Verzauberung)";
	AL["Currency"] = "Zum Kaufen von Belohnungen";
	AL["Currency (Alliance)"] = "Zum Kaufen von Belohnungen (Allianz)";
	AL["Currency (Horde)"] = "Zum Kaufen von Belohnungen (Horde)";
	AL["Conjured Item"] = "Verbrauchbar";
	AL["Used to summon boss"] = "Zur Beschwörung benötigt (Boss)";
	AL["Tradable against sunmote + item above"] = "Tausch:obiges Item + Sonnenpartikel";
	AL["Card Game Item"] = "Kartenspiel Item";
	AL["Skill Required:"] = "Benötigte Fertigkeit:";
	AL["Rating:"] = "Wertung"; -- Shorthand for 'Required Rating' for the personal/team ratings
	AL["Random Heroic Reward"] = "Zufällige heroische Belohnung";

	-- Minor Labels for loot table descriptions
	AL["Original WoW"] = "Klassisch";
	-- AL["Burning Crusade"] = true;
	-- AL["Wrath of the Lich King"] = true;
	AL["Entrance"] = "Eingang";
	AL["Season 2"] = "2. Saison";
	AL["Season 3"] = "3. Saison";
	AL["Season 4"] = "4. Saison";
	-- AL["Dungeon Set 1"] = true;
	-- AL["Dungeon Set 2"] = true;
	-- AL["Dungeon Set 3"] = true;
	-- AL["Tier 1"] = true;
	-- AL["Tier 2"] = true;
	-- AL["Tier 3"] = true;
	-- AL["Tier 4"] = true;
	-- AL["Tier 5"] = true;
	-- AL["Tier 6"] = true;	
	-- AL["Tier 7"] = true;
	-- AL["Tier 8"] = true;
	-- AL["Tier 9"] = true;
	-- AL["Tier 10"] = true;
	AL["10 Man"] = "10 Spieler";
	AL["25 Man"] = "25 Spieler";
	AL["10/25 Man"] = "10/25 Spieler";
	AL["Epic Set"] = "Episches Set";
	AL["Rare Set"] = "Seltenes Set";
	AL["Fire"] = "Feuer";
	AL["Water"] = "Wasser";
	AL["Wind"] = "Wind";
	AL["Earth"] = "Erde";
	AL["Master Angler"] = "Anglermeister";	
	AL["Fire Resistance Gear"] = "Feuerresistenz";
	AL["Arcane Resistance Gear"] = "Arkanresistenz";	
	AL["Nature Resistance Gear"] = "Naturresistenz";
	AL["Frost Resistance Gear"] = "Frostresistenz";
	AL["Shadow Resistance Gear"] = "Schattenresistenz";

	-- Labels for loot table sections
	AL["Additional Heroic Loot"] = "Zusätzliche heroische Beute";
	AL["Heroic Mode"] = "Heroisch";
	AL["Normal Mode"] = "Normal";
	AL["Raid"] = "Schlachtzug";
	-- AL["Hard Mode"] = true;
	AL["Bonus Loot"] = "Zusatzbeute";
	AL["One Drake Left"] = "Ein verbleibender Drache";
	AL["Two Drakes Left"] = "Zwei verbleibende Drachen";
	AL["Three Drakes Left"] = "Drei verbleibende Drachen";
    	AL["Arena Reward"] = "Arena Belohnung";
	-- AL["Phase 1"] = true;
	-- AL["Phase 2"] = true;
	-- AL["Phase 3"] = true;
	AL["First Prize"] = "Hauptpreis";
	AL["Rare Fish Rewards"] = "Besonderer Fisch - Belohnungen";
	AL["Rare Fish"] = "Besondere Fische";
	AL["Unattainable Tabards"] = "Unerreichbare Wappenröcke";
	AL["Heirloom"] = "Erbstücke";
	AL["Weapons"] = "Waffen";
	AL["Accessories"] = "Zubehör";
	AL["Alone in the Darkness"] = "Allein im Dunkeln";
	AL["Call of the Grand Crusade"] = "Der Ruf des großen Kreuzzugs";
	AL["A Tribute to Skill (25)"] = "Ein Tribut an die gute Leistung (25)";
	AL["A Tribute to Mad Skill (45)"] = "Ein Tribut an die hervorragende Leistung (45)";
	AL["A Tribute to Insanity (50)"] = "Ein Tribut an den Wahnsinn (50)";
	AL["A Tribute to Immortality"] = "Ein Tribut an die Unsterblichkeit";
	AL["Low Level"] = "Niedrigstufig";
	AL["High Level"] = "Hochstufig";

	-- Loot Table Names
	-- AL["Scholomance Sets"] = true;
	AL["PvP Accessories (Level 60)"] = "PvP-Zubehör (Stufe 60)";
	AL["PvP Accessories - Alliance (Level 60)"] = "PvP-Zubehör - Allianz (Stufe 60)";
	AL["PvP Accessories - Horde (Level 60)"] = "PvP-Zubehör - Horde (Stufe 60)";
	AL["PvP Weapons (Level 60)"] = "PvP-Waffen (Stufe 60)";
	AL["PvP Accessories (Level 70)"] = "PvP-Zubehör (Stufe 70)";
	AL["PvP Weapons (Level 70)"] = "PvP-Waffen (Stufe 70)";
	AL["PvP Reputation Sets (Level 70)"] = "PvP Ruf Sets (Stufe 70)";
	AL["Arena Season 2 Weapons"] = "Arena-Waffen 2. Saison";
	AL["Arena Season 3 Weapons"] = "Arena-Waffen 3. Saison";
	AL["Arena Season 4 Weapons"] = "Arena-Waffen 4. Saison";
	AL["Level 30-39"] = "Stufe 30-39";
	AL["Level 40-49"] = "Stufe 40-49";
	AL["Level 50-60"] = "Stufe 50-60";
	AL["Heroic"] = "Heroisch";
	AL["Summon"] = "Beschwören";
	AL["Random"] = "Zufällig";
	-- AL["Tier 8 Sets"] = true;
	-- AL["Tier 9 Sets"] = true;
	-- AL["Tier 10 Sets"] = true;
	AL["Furious Gladiator Sets"] = "Sets des wütenden Gladiatoren";
	AL["Relentless Gladiator Sets"] = "Sets des unerbittlichen Gladiatoren";
	AL["Brew of the Month Club"] = "Bier des Monats e.V.";

	-- Extra Text in Boss lists
	AL["Set: Embrace of the Viper"] = "Set: Umarmung der Viper (5 Teile)";
	AL["Set: Defias Leather"] = "Set: Defiasleder (5 Teile)";
	AL["Set: The Gladiator"] = "Set: Der Gladiator (5 Teile)";
	AL["Set: Chain of the Scarlet Crusade"] = "Set: Kettenrüstung des Scharlachroten Kreuzzugs";
	AL["Set: The Postmaster"] = "Der Postmeister (5 Teile)";
	AL["Set: Necropile Raiment"] = "Set: Roben des Totenbeschwörers (5 Teile)";
	AL["Set: Cadaverous Garb"] = "Set: Leichenhaftes Gewand (5 Teile)";
	AL["Set: Bloodmail Regalia"] = "Set: Ornat des Blutpanzers (5 Teile)";
	AL["Set: Deathbone Guardian"] = "Set: Wächter der Totengebeine (5 Teile)";
	AL["Set: Dal'Rend's Arms"] = "Set: Dal'Rends Waffen (2 Teile)";
	AL["Set: Spider's Kiss"] = "Set: Kuss der Spinne (2 Teile)";
	AL["AQ20 Class Sets"] = "AQ20-Klassen-Sets";
	AL["AQ Enchants"] = "AQ-Verzauberungen";
	AL["AQ40 Class Sets"] = "AQ40-Klassen-Sets";
	AL["AQ Opening Quest Chain"] = "AQ-Öffnungsquestreihe";
	AL["ZG Class Sets"] = "ZG-Klassen-Sets";
	AL["ZG Enchants"] = "ZG-Verzauberungen";
	AL["Class Books"] = "Klassenbücher";
	AL["Tribute Run"] = "Tribut Run";
	AL["Dire Maul Books"] = "Düsterbruch Bücher";
	AL["Random Boss Loot"] = "Zufälliger Boss Loot";	
	AL["BT Patterns/Plans"] = "BT Muster/Pläne";	
	AL["Hyjal Summit Designs"] = "Berg Hyjal Designs";
	AL["SP Patterns/Plans"] = "SP Muster/Pläne";
	AL["Ulduar Formula/Patterns/Plans"] = "Ulduar Formeln/Muster/Pläne";
	AL["Trial of the Crusader Patterns/Plans"] = "Prüfung des Kreuzfahrers Muster/Pläne";
	AL["Legendary Items for Kael'thas Fight"] = "Legendäre Items für Kael'thas Kampf";

	-- Pets
	AL["Pets"] = "Haustiere";
	-- AL["Promotional"] = true;
	-- AL["Pet Store"] = true;
	AL["Merchant Sold"] = "Vom Händler verkauft";
	AL["Rare"] = "Selten";
	AL["Achievement"] = "Erfolg";
	AL["Faction"] = "Fraktion";
	AL["Dungeon/Raid"] = "Instanz/Schlachtzug";

	-- Mounts
	AL["Achievement Reward"] = "Erfolgsbelohnung";
	AL["Alliance Flying Mounts"] = "Allianz Flugreittiere";
	AL["Alliance Mounts"] = "Allianz Reittiere";
	AL["Horde Flying Mounts"] = "Horde Flugreittiere";
	AL["Horde Mounts"] = "Horde Reittiere";
	AL["Card Game Mounts"] = "Kartenspielreittiere";
	AL["Crafted Mounts"] = "Herstellbar";
	AL["Event Mounts"] = "Eventreittiere";
	AL["Neutral Faction Mounts"] = "Fraktionsneutrale Reittiere";
	AL["PvP Mounts"] = "PvP Reittiere";
	AL["Alliance PvP Mounts"] = "Allianz PvP Reittiere";
	AL["Horde PvP Mounts"] = "Horde PvP Reittiere";
	AL["Halaa PvP Mounts"] = "Halaa PvP Reittiere";
	AL["Promotional Mounts"] = "Promotional Reittiere";
	AL["Rare Mounts"] = "Seltene Reittiere";

	-- Darkmoon Faire
	-- AL["Darkmoon Faire Rewards"] = true;
	-- AL["Low Level Decks"] = true;
	-- AL["Original and BC Trinkets"] = true;
	-- AL["WotLK Trinkets"] = true;

	-- Card Game Decks and descriptions
	AL["Loot Card Items"] = "Beutekarten Gegenstände";
	AL["UDE Items"] = "UDE Gegenstände";

	-- First set
	AL["Heroes of Azeroth"] = "Helden von Azeroth";
	AL["Landro Longshot"] = "Landro Fernblick";
	AL["Thunderhead Hippogryph"] = "Donnerkopfhippogryph";
	AL["Saltwater Snapjaw"] = "Salzwasserschnappkiefer";

	-- Second set
	AL["Through The Dark Portal"] = "Durch das Dunkle Portal";
	AL["King Mukla"] = "König Mukla";
	AL["Rest and Relaxation"] = "Ruhe und Entspannung";
	AL["Fortune Telling"] = "Wahrsagen";

	-- Third set
	AL["Fires of Outland"] = "Feuer der Scherbenwelt";
	AL["Spectral Tiger"] = "Spektraltiger";
	AL["Gone Fishin'"] = "Bin Angeln'";
	AL["Goblin Gumbo"] = "Goblineintopf";

	-- Fourth set
	AL["March of the Legion"] = "Marsch der Legion";
	AL["Kiting"] = "Papierdrachen";
	AL["Robotic Homing Chicken"] = "Raketenhühnchen";
	AL["Paper Airplane"] = "Papierflugmaschine";

	-- Fifth set
	AL["Servants of the Betrayer"] = "Diener des Verräters";
	AL["X-51 Nether-Rocket"] = "X-51 Netherrakete";
	AL["Personal Weather Machine"] = "Persönlicher Wettermacher";
	AL["Papa Hummel's Old-fashioned Pet Biscuit"] = "Papa Hummels altmodischer Tierkuchen";

	-- Sixth set
	AL["Hunt for Illidan"] = "Die Jagd nach Illidan";
	AL["The Footsteps of Illidan"] = "Die Fußspuren von Illidan";
	AL["Disco Inferno!"] = "Disko-Inferno";
	AL["Ethereal Plunderer"] = "Astraler Brandschatzer";

	-- Seventh set
	AL["Drums of War"] = "Trommeln des Krieges";
	AL["The Red Bearon"] = "Der rote Bäron";
	AL["Owned!"] = "pWn3d!";
	-- AL["Slashdance"] = true;

	-- Eighth set
	AL["Blood of Gladiators"] = "Blut der Gladiatoren";
	AL["Sandbox Tiger"] = "Sandkastentiger";
	AL["Center of Attention"] = "Mittelpunkt der Aufmerksamkeit";
	AL["Foam Sword Rack"] = "Schaumstoffschwertständer";

	-- Ninth set
	AL["Fields of Honor"] = "Felder der Ehre";
	AL["Path of Cenarius"] = "Pfad des Cenarius";
	-- AL["Pinata"] = true;
	-- AL["El Pollo Grande"] = true;

	-- Tenth set
	AL["Scourgewar"] = "Krieg der Geißel";
	AL["Tiny"] = "Winzling";
	AL["Tuskarr Kite"] = "Tuskarrdrachen";
	AL["Spectral Kitten"] = "Spektralkätzchen";

	-- Eleventh set
	AL["Wrathgate"] = "Pforte des Zorns";
	AL["Statue Generator"] = "Instantstatue";
	AL["Landro's Gift"] = "Landros Geschenkkiste";
	AL["Blazing Hippogryph"] = "Flammender Hippogryph";

	-- Twelvth set
	AL["Icecrown"] = "Eiskrone";
	AL["Wooly White Rhino"] = "Wolliges weißes Rhino";
	AL["Ethereal Portal"] = "Etherportal";
	AL["Paint Bomb"] = "Farbbombe";

	-- Battleground Brackets
	AL["BG/Open PvP Rewards"] = "BG/Open PvP Belohnungen";
	AL["Misc. Rewards"] = "Diverses";
	AL["Level 20-29 Rewards"] = "Belohnungen (Stufe 20-29)";
	AL["Level 30-39 Rewards"] = "Belohnungen (Stufe 30-39)";
	AL["Level 20-39 Rewards"] = "Belohnungen (Stufe 20-39)";
	AL["Level 40-49 Rewards"] = "Belohnungen (Stufe 40-49)";
	AL["Level 60 Rewards"] = "Belohnungen (Stufe 60)";

	-- Brood of Nozdormu Paths
	AL["Path of the Conqueror"] = "Der Pfad des Eroberers";
	AL["Path of the Invoker"] = "Der Pfad des Herbeirufers";
	AL["Path of the Protector"] = "Der Pfad des Beschützers";

	-- Violet Eye Paths
	AL["Path of the Violet Protector"] = "Violetter Beschützer";
	AL["Path of the Violet Mage"] = "Violetter Magier";
	AL["Path of the Violet Assassin"] = "Violetter Auftragsmörder";
	AL["Path of the Violet Restorer"] = "Violetter Bewahrer";

	-- Ashen Verdict Paths
	AL["Path of Courage"] = "Weg des Mutes";
	AL["Path of Destruction"] = "Weg der Zerstörung";
	AL["Path of Vengeance"] = "Weg der Vergeltung";
	AL["Path of Wisdom"] = "Weg der Weisheit";

	-- AQ Opening Event
	AL["Red Scepter Shard"] = "Roter Szeptersplitter";
	AL["Blue Scepter Shard"] = "Blauer Szeptersplitter";
	AL["Green Scepter Shard"] = "Grüner Szeptersplitter";
	AL["Scepter of the Shifting Sands"] = "Das Szepter der Sandstürme";

	-- World PvP
	AL["Hellfire Fortifications"] = "Befestigung des Höllenfeuers";
	AL["Twin Spire Ruins"] = "Ruinen der Zwillingsspitze";
	AL["Spirit Towers"] = "Geistertürme";
	-- AL["Halaa"] = true;
	AL["Venture Bay"] = "Venturebucht";

	-- Karazhan Opera Event Headings
	AL["Shared Drops"] = "geteilte Beute";
	-- AL["Romulo & Julianne"] = true;
	AL["Wizard of Oz"] = "Zauberer von Oz";
	AL["Red Riding Hood"] = "Rotkäppchen";

	-- Karazhan Animal Boss Types
	AL["Spider"] = "Spinne";
	AL["Darkhound"] = "Schattenhund";
	AL["Bat"] = "Fledermaus";

	-- ZG Tokens
	AL["Primal Hakkari Kossack"] = "Hakkarikosak";
	AL["Primal Hakkari Shawl"] = "Hakkarischal";
	AL["Primal Hakkari Bindings"] = "Hakkaribindungen";
	AL["Primal Hakkari Sash"] = "Hakkarischärpe";
	AL["Primal Hakkari Stanchion"] = "Hakkaristütze";
	AL["Primal Hakkari Aegis"] = "Aegis der Hakkari";
	AL["Primal Hakkari Girdle"] = "Hakkarigurt";
	AL["Primal Hakkari Armsplint"] = "Hakkariarmsplintes";
	AL["Primal Hakkari Tabard"] = "Hakkariwappenrock";

	-- AQ20 Tokens
	AL["Qiraji Ornate Hilt"] = "Verschnörkelter Griff";
	AL["Qiraji Martial Drape"] = "Kampftuch";
	AL["Qiraji Magisterial Ring"] = "Gebieterring";
	AL["Qiraji Ceremonial Ring"] = "Zeremonienring";
	AL["Qiraji Regal Drape"] = "Hoheitstuch";
	AL["Qiraji Spiked Hilt"] = "Stachelgriff";

	-- AQ40 Tokens
	AL["Qiraji Bindings of Dominance"] = "Dominanzbindungen";
	AL["Qiraji Bindings of Command"] = "Befehlsbindungen";
	AL["Vek'nilash's Circlet"] = "Vek'nilashs Reif";
	AL["Vek'lor's Diadem"] = "Vek'lors Diadem";
	AL["Ouro's Intact Hide"] = "Ouros intakte Haut";
	AL["Skin of the Great Sandworm"] = "Haut des Sandwurms";
	AL["Husk of the Old God"] = "Hülle des Gottes";
	AL["Carapace of the Old God"] = "Knochenpanzer des Gottes";

	-- Blacksmithing Mail Crafted Sets
	AL["Bloodsoul Embrace"] = "Umarmung der Blutseele";
	AL["Fel Iron Chain"] = "Teufelseisenkettenrüstung";

	-- Blacksmithing Plate Crafted Sets
	AL["Imperial Plate"] = "Stolz des Imperiums";
	AL["The Darksoul"] = "Die dunkle Seele";
	AL["Fel Iron Plate"] = "Teufelseisenplattenrüstung";
	AL["Adamantite Battlegear"] = "Adamantitschlachtrüstung";
	AL["Flame Guard"] = "Flammenwächter";
	AL["Enchanted Adamantite Armor"] = "Verzauberte Adamantitrüstung";
	AL["Khorium Ward"] = "Khoriumschutz";
	AL["Faith in Felsteel"] = "Teufelsstählerner Wille";
	AL["Burning Rage"] = "Brennernder Zorn";
	AL["Ornate Saronite Battlegear"] = "Verzierte Saronitschlachtrüstung";
	AL["Savage Saronite Battlegear"] = "Wilde Saronitschlachtrüstung";

	-- Leatherworking Crafted Sets
	AL["Volcanic Armor"] = "Vulkanrüstung";
	AL["Ironfeather Armor"] = "Eisenfederrüstung";
	AL["Stormshroud Armor"] = "Sturmschleier";
	AL["Devilsaur Armor"] = "Teufelsaurierrüstung";
	AL["Blood Tiger Harness"] = "Harnisch des Bluttigers";
	AL["Primal Batskin"] = "Urzeitliche Fledermaushaut";
	AL["Wild Draenish Armor"] = "Wilde draenische Rüstung";
	AL["Thick Draenic Armor"] = "Dicke draenische Rüstung";
	AL["Fel Skin"] = "Teufelshaut";
	AL["Strength of the Clefthoof"] = "Macht der Grollhufe";
        AL["Primal Intent"] = "Urgewalt";
	AL["Windhawk Armor"] = "Rüstung des Windfalken";
	AL["Borean Embrace"] = "Boreanische Umarmung";
	AL["Iceborne Embrace"] = "Winterliche Umarmung";
	AL["Eviscerator's Battlegear"] = "Schlachtrüstung des Ausweiders";
	AL["Overcaster Battlegear"] = "Unwetterschlachtrüstung";

	-- Leatherworking Crafted Mail Sets
	AL["Green Dragon Mail"] = "Grüner Drachenschuppenpanzer";
	AL["Blue Dragon Mail"] = "Blauer Drachenschuppenpanzer";
	AL["Black Dragon Mail"] = "Schwarzer Drachenschuppenpanzer";
	AL["Scaled Draenic Armor"] = "Geschuppte draenische Rüstung";
	AL["Felscale Armor"] = "Teufelsschuppenrüstung";
	AL["Felstalker Armor"] = "Rüstung des Teufelspirschers";
	AL["Fury of the Nether"] = "Netherzorn";
	AL["Netherscale Armor"] = "Netherschuppenrüstung";
	AL["Netherstrike Armor"] = "Rüstung des Netherstoßes";
	AL["Frostscale Binding"] = "Frostschuppenbindung";
	AL["Nerubian Hive"] = "Nerubischer Schwarm";
	AL["Stormhide Battlegear"] = "Sturmbalgschlachtrüstung";
	AL["Swiftarrow Battlefear"] = "Flinkpfeilschlachtrüstung";

	-- Tailoring Crafted Sets
	AL["Bloodvine Garb"] = "Blutrebengewand";
	AL["Netherweave Vestments"] = "Netherstoffgewänder";
	AL["Imbued Netherweave"] = "Magieerfüllte Netherstoffroben";
	AL["Arcanoweave Vestments"] = "Arkanostoffgewänder";
	AL["The Unyielding"] = "Der Unerschütterliche";
	AL["Whitemend Wisdom"] = "Weisheit des weißen Heilers";
	AL["Spellstrike Infusion"] = "Insignien des Zauberschlags";
	AL["Battlecast Garb"] = "Gewand des Schlachtenzaubers";
	AL["Soulcloth Embrace"] = "Seelenstoffumarmung";
	AL["Primal Mooncloth"] = "Urmondroben";
	AL["Shadow's Embrace"] = "Umarmung der Schatten";
	AL["Wrath of Spellfire"] = "Zorn des Zauberfeuers";
	AL["Frostwoven Power"] = "Frostgewirkte Macht";
	AL["Duskweaver"] = "Dämmerwirker";
	AL["Frostsavage Battlegear"] = "Frostgrimmschlachtrüstung";

	-- Classic WoW Sets
	AL["Defias Leather"] = "Defiasleder";
	AL["Embrace of the Viper"] = "Umarmung der Viper";
	AL["Chain of the Scarlet Crusade"] = "Kettenrüstung des Scharlachroten Kreuzzugs";
	AL["The Gladiator"] = "Der Gladiator";
	AL["Ironweave Battlesuit"] = "Eisengewebte Kampfrüstung";
	AL["Necropile Raiment"] = "Roben des Totenbeschwörers";
	AL["Cadaverous Garb"] = "Leichenhaftes Gewand";
	AL["Bloodmail Regalia"] = "Ornat des Blutpanzers";
	AL["Deathbone Guardian"] = "Wächter der Totengebeine";
	AL["The Postmaster"] = "Der Postmeister";
	AL["Shard of the Gods"] = "Scherbe der Götter";
	AL["Zul'Gurub Rings"] = "Zul'Gurub Ringe";
	AL["Major Mojo Infusion"] = "Kraft des Mojo";
	AL["Overlord's Resolution"] = "Erlass des Oberherren";
	AL["Prayer of the Primal"] = "Gebet der Uralten";
	AL["Zanzil's Concentration"] = "Zanzils Konzentration";
	AL["Spirit of Eskhandar"] = "Seele des Eskhandar";
	AL["The Twin Blades of Hakkari"] = "Die Zwillingsklingen von Hakkari";
	AL["Primal Blessing"] = "Ursegen";
	AL["Dal'Rend's Arms"] = "Dal'Rends Waffen";
	AL["Spider's Kiss"] = "Kuss der Spinne";

	-- The Burning Crusade Sets
	AL["Latro's Flurry"] = "Latros Schlaghagel";
	AL["The Twin Stars"] = "Die Zwillingssterne";
	AL["The Fists of Fury"] = "Fäuste des Rächers";
	AL["The Twin Blades of Azzinoth"] = "Die Zwillingsklingen von Azzinoth";

	-- Wrath of the Lich King Sets
	AL["Raine's Revenge"] = "Raines Rache";
	AL["Purified Shard of the Gods"] = "Geläuterte Scherbe der Götter";
	AL["Shiny Shard of the Gods"] = "Glänzende Scherbe der Götter";

	-- Recipe origin strings
	AL["Trainer"] = "Lehrer";
	AL["Discovery"] = "Entdeckung";
	AL["World Drop"] = "Weltdrop";
	-- AL["Drop"] = true;
	AL["Vendor"] = "Händler";
	-- AL["Quest"] = true;
	AL["Crafted"] = "Hergestellt";

	-- Scourge Invasion
	AL["Scourge Invasion"] = "Invasion der Geißel";
	AL["Scourge Invasion Sets"] = "Invasion der Geißel-Sets";
	AL["Blessed Regalia of Undead Cleansing"] = "Gesegneter Orant der Untotenbekämpfung";
	AL["Undead Slayer's Blessed Armor"] = "Gesegnete Rüstung des Untotenschlachtens";
	AL["Blessed Garb of the Undead Slayer"] = "Gesegnetes Gewand des Untotenschlächters";
	AL["Blessed Battlegear of Undead Slaying"] = "Gesegnete Kampfrüstung des Untotenschlachtens";
	AL["Prince Tenris Mirkblood"] = "Prinz Tenris Mirkblut";

	-- ZG Sets
	AL["Haruspex's Garb"] = "Gewand des Haruspex";
	AL["Predator's Armor"] = "Rüstung des Raubtiers";
	AL["Illusionist's Attire"] = "Roben des Illusionisten";
	AL["Freethinker's Armor"] = "Rüstung des Freidenkers";
	AL["Confessor's Raiment"] = "Gewand des Glaubenshüters";
	AL["Madcap's Outfit"] = "Rüstzeug des Wildfangs";
	AL["Augur's Regalia"] = "Ornat des Weissagers";
	AL["Demoniac's Threads"] = "Roben des Besessenen";
	AL["Vindicator's Battlegear"] = "Schlachtrüstung des Vollstreckers";

	-- AQ20 Sets
	AL["Symbols of Unending Life"] = "Symbole des endlosen Lebens";
	AL["Trappings of the Unseen Path"] = "Zierat des unsichtbaren Pfades";
	AL["Trappings of Vaulted Secrets"] = "Zierat der behüteten Geheimnisse";
	AL["Battlegear of Eternal Justice"] = "Schlachtrüstung der ewigen Gerechtigkeit";
	AL["Finery of Infinite Wisdom"] = "Pracht der unendlichen Weisheit";
	AL["Emblems of Veiled Shadows"] = "Embleme der Schattenschleier";
	AL["Gift of the Gathering Storm"] = "Gabe der aufziehenden Stürme";
	AL["Implements of Unspoken Names"] = "Ritualroben des ungesagten Namens";
	AL["Battlegear of Unyielding Strength"] = "Schlachtrüstung der unnachgiebigen Stärke";

	-- AQ40 Sets
	AL["Genesis Raiment"] = "Gewandung der Genesis";
	AL["Striker's Garb"] = "Gewand des Hetzers";
	AL["Enigma Vestments"] = "Gewänder des Mysteriums";
	AL["Avenger's Battlegear"] = "Schlachtrüstung des Rächers";
	AL["Garments of the Oracle"] = "Gewänder des Orakels";
	AL["Deathdealer's Embrace"] = "Umarmung des Todesboten";
	AL["Stormcaller's Garb"] = "Gewand des Sturmrufers";
	AL["Doomcaller's Attire"] = "Roben des Verdammnisrufers";
	AL["Conqueror's Battlegear"] = "Schlachtrüstung des Eroberers";

	-- Dungeon 1 Sets
	AL["Wildheart Raiment"] = "Herz der Wildnis";
	AL["Beaststalker Armor"] = "Rüstung des Bestienjägers";
	AL["Magister's Regalia"] = "Ornat des Magisters";
	AL["Lightforge Armor"] = "Esse des Lichts";
	AL["Vestments of the Devout"] = "Gewänder des Gläubigen";
	AL["Shadowcraft Armor"] = "Rüstung der Schattenkunst";
	AL["The Elements"] = "Die Elemente";
	AL["Dreadmist Raiment"] = "Nebel der Furcht";
	AL["Battlegear of Valor"] = "Schlachtrüstung der Ehre";

	-- Dungeon 2 Sets
	AL["Feralheart Raiment"] = "Ungezähmtes Herz";
	AL["Beastmaster Armor"] = "Rüstung der Tierherrschaft";
	AL["Sorcerer's Regalia"] = "Ornat der Zauberkünste";
	AL["Soulforge Armor"] = "Rüstung der Seelenschmiede";
	AL["Vestments of the Virtuous"] = "Gewänder des Tugendhaften";
	AL["Darkmantle Armor"] = "Rüstung der Finsternis";
	AL["The Five Thunders"] = "Die fünf Donner";
	AL["Deathmist Raiment"] = "Roben des Todesnebels";
	AL["Battlegear of Heroism"] = "Schlachtrüstung des Heldentums";

	-- Dungeon 3 Sets
	AL["Hallowed Raiment"] = "Geheiligte Roben";
	AL["Incanter's Regalia"] = "Ornat des Beschwörens";
	AL["Mana-Etched Regalia"] = "Managetränktes Ornat";
	AL["Oblivion Raiment"] = "Gewandung des Vergessens";
	AL["Assassination Armor"] = "Rüstung des Meuchelmords";
	AL["Moonglade Raiment"] = "Gewandung der Mondlichtung";
	AL["Wastewalker Armor"] = "Ödniswandlerrüstung";
	AL["Beast Lord Armor"] = "Rüstung des Wildtierfürsten";
	AL["Desolation Battlegear"] = "Schlachtrüstung der Verwüstung";
	AL["Tidefury Raiment"] = "Gewandung des Gezeitensturms";
	AL["Bold Armor"] = "Rüstung des Wagemutigen";
	AL["Doomplate Battlegear"] = "Verdammnisplattenrüstung";
	AL["Righteous Armor"] = "Rüstung des Rechtschaffenen";

	-- Tier 1 Sets
	AL["Cenarion Raiment"] = "Gewänder des Cenarius";
	AL["Giantstalker Armor"] = "Rüstung des Riesenjägers";
	AL["Arcanist Regalia"] = "Ornat des Arkanisten";
	AL["Lawbringer Armor"] = "Rüstung der Gerechtigkeit";
	AL["Vestments of Prophecy"] = "Gewänder der Prophezeihung";
	AL["Nightslayer Armor"] = "Der Nachtmeuchler";
	AL["The Earthfury"] = "Die Wut der Erde";
	AL["Felheart Raiment"] = "Teufelsherzroben";
	AL["Battlegear of Might"] = "Schlachtrüstung der Macht";

	-- Tier 2 Sets
	AL["Stormrage Raiment"] = "Sturmgrimms Gewänder";
	AL["Dragonstalker Armor"] = "Rüstung des Drachenjägers";
	AL["Netherwind Regalia"] = "Ornat des Netherwinds";
	AL["Judgement Armor"] = "Rüstung des Richturteils";
	AL["Vestments of Transcendence"] = "Gewänder der Erhabenheit";
	AL["Bloodfang Armor"] = "Blutfangrüstung";
	AL["The Ten Storms"] = "Die zehn Stürme";
	AL["Nemesis Raiment"] = "Roben der Nemesis";
	AL["Battlegear of Wrath"] = "Schlachtrüstung des Zorns";

	-- Tier 3 Sets
	AL["Dreamwalker Raiment"] = "Gewandung des Traumwandlers";
	AL["Cryptstalker Armor"] = "Rüstung des Gruftpirschers";
	AL["Frostfire Regalia"] = "Frostfeuerornat";
	AL["Redemption Armor"] = "Rüstung der Erlösung";
	AL["Vestments of Faith"] = "Gewänder des Glaubens";
	AL["Bonescythe Armor"] = "Rüstung der Knochensense";
	AL["The Earthshatterer"] = "Der Erdspalter";
	AL["Plagueheart Raiment"] = "Roben des verseuchten Herzens";
	AL["Dreadnaught's Battlegear"] = "Schlachtrüstung des Schreckenspanzers";

	-- Tier 4 Sets
	AL["Malorne Harness"] = "Malornes Harnisch";
	AL["Malorne Raiment"] = "Malornes Gewandung";
	AL["Malorne Regalia"] = "Malornes Ornat";
	AL["Demon Stalker Armor"] = "Rüstung des Dämonenwandlers";
	AL["Aldor Regalia"] = "Ornat der Aldor";
	AL["Justicar Armor"] = "Rüstung des Rechtsprechers";
	AL["Justicar Battlegear"] = "Schlachtrüstung des Rechtsprechers";
	AL["Justicar Raiment"] = "Gewandung des Rechtsprechers";
	AL["Incarnate Raiment"] = "Gewandung des Leibhaftigen";
	AL["Incarnate Regalia"] = "Ornat des Leibhaftigen";
	AL["Netherblade Set"] = "Netherklinge";
	AL["Cyclone Harness"] = "Harnisch des Orkans";
	AL["Cyclone Raiment"] = "Gewandung des Orkans";
	AL["Cyclone Regalia"] = "Ornat des Orkans";
	AL["Voidheart Raiment"] = "Gewandung des Herzens der Leere";
	AL["Warbringer Armor"] = "Rüstung des Kriegshetzers";
	AL["Warbringer Battlegear"] = "Schlachtrüstung des Kriegshetzers";

	-- Tier 5 Sets
	AL["Nordrassil Harness"] = "Harnisch von Nordrassil";
	AL["Nordrassil Raiment"] = "Gewandung von Nordrassil";
	AL["Nordrassil Regalia"] = "Ornat von Nordrassil";
	AL["Rift Stalker Armor"] = "Rüstung des Dimensionswandlers";
	AL["Tirisfal Regalia"] = "Ornat von Tirisfal";
	AL["Crystalforge Armor"] = "Kristallgeschmiedete Rüstung";
	AL["Crystalforge Battlegear"] = "Kristallgeschmiedete Schlachtrüstung";
	AL["Crystalforge Raiment"] = "Kristallgeschmiedete Gewandung";
	AL["Avatar Raiment"] = "Gewandung des Avatars";
	AL["Avatar Regalia"] = "Ornat des Avatars";
	AL["Deathmantle Set"] = "Todeshauch";
	AL["Cataclysm Harness"] = "Harnisch der Verheerung";
	AL["Cataclysm Raiment"] = "Gewandung der Verheerung";
	AL["Cataclysm Regalia"] = "Ornat der Verheerung";
	AL["Corruptor Raiment"] = "Gewandung des Verderbers";
	AL["Destroyer Armor"] = "Rüstung des Zerstörers";
	AL["Destroyer Battlegear"] = "Schlachtrüstung des Zerstörers";

	-- Tier 6 Sets
	AL["Thunderheart Harness"] = "Harnisch des Donnerherzens";
	AL["Thunderheart Raiment"] = "Gewandung des Donnerherzens";
	AL["Thunderheart Regalia"] = "Ornat des Donnerherzens";
	AL["Gronnstalker's Armor"] = "Rüstung des Gronnpirschers";
	AL["Tempest Regalia"] = "Ornat des Gewittersturms";
	AL["Lightbringer Armor"] = "Rüstung des Lichtbringers";
	AL["Lightbringer Battlegear"] = "Schlachtrüstung des Lichtbringers";
	AL["Lightbringer Raiment"] = "Gewandung des Lichtbringers";
	AL["Vestments of Absolution"] = "Ornat der Absolution";
	AL["Absolution Regalia"] = "Gewänder der Absolution";
	AL["Slayer's Armor"] = "Rüstung des Schlächters";
	AL["Skyshatter Harness"] = "Harnisch des Himmelsdonners";
	AL["Skyshatter Raiment"] = "Gewandung des Himmelsdonners";
	AL["Skyshatter Regalia"] = "Ornat des Himmelsdonners";
	AL["Malefic Raiment"] = "Gewandung der Boshaftigkeit";
	AL["Onslaught Armor"] = "Rüstung des Ansturms";
	AL["Onslaught Battlegear"] = "Schlachtrüstung des Ansturms";

	-- Tier 7 Sets
	AL["Scourgeborne Battlegear"] = "Schlachtrüstung der Geißelerben";
	AL["Scourgeborne Plate"] = "Plattenrüstung der Geißelerben";
	AL["Dreamwalker Garb"] = "Gewandung des Traumwandlers";
	AL["Dreamwalker Battlegear"] = "Schlachtrüstung des Traumwandlers";
	AL["Dreamwalker Regalia"] = "Ornat des Traumwandlers";
	AL["Cryptstalker Battlegear"] = "Schlachtrüstung des Gruftpirschers";
	AL["Frostfire Garb"] = "Frostfeuergewand";
	AL["Redemption Regalia"] = "Ornat der Erlösung";
	AL["Redemption Battlegear"] = "Schlachtrüstung der Erlösung";
	AL["Redemption Plate"] = "Plattenrüstung der Erlösung";
	AL["Regalia of Faith"] = "Ornat des Glaubens";
	AL["Garb of Faith"] = "Gewand des Glaubens";
	AL["Bonescythe Battlegear"] = "Schlachtrüstung der Knochensense";
	AL["Earthshatter Garb"] = "Erdspaltergewand";
	AL["Earthshatter Battlegear"] = "Erdspalterschlachtrüstung";
	AL["Earthshatter Regalia"] = "Erdspalterornat";
	AL["Plagueheart Garb"] = "Gewand des verseuchten Herzens";
	AL["Dreadnaught Battlegear"] = "Schreckenspanzerschlachtrüstung";
	AL["Dreadnaught Plate"] = "Schreckenspanzerplattenrüstung";

	-- Tier 8 Sets
	AL["Darkruned Battlegear"] = "Dunkle Runenschlachtrüstung";
	AL["Darkruned Plate"] = "Dunkle Runenplattenrüstung";
	AL["Nightsong Garb"] = "Gewand des Nachtweisen";
	AL["Nightsong Battlegear"] = "Schlachtrüstung des Nachtweisen";
	AL["Nightsong Regalia"] = "Ornat des Nachtweisen";
	AL["Scourgestalker Battlegear"] = "Schlachtrüstung des Geißeljägers";
	AL["Kirin Tor Garb"] = "Gewand der Kirin Tor";
	AL["Aegis Regalia"] = "Ornat der Aegis";
	AL["Aegis Battlegear"] = "Schlachtrüstung der Aegis";
	AL["Aegis Plate"] = "Plattenrüstung der Aegis";
	AL["Sanctification Regalia"] = "Ornat der Weihe";
	AL["Sanctification Garb"] = "Gewandung der Weihe";
	AL["Terrorblade Battlegear"] = "Schlachtrüstung der Schreckensklinge";
	AL["Worldbreaker Garb"] = "Gewandung des Weltenbrechers";
	AL["Worldbreaker Battlegear"] = "Schlachtrüstung des Weltenbrechers";
	AL["Worldbreaker Regalia"] = "Ornat des Weltenbrechers";
	AL["Deathbringer Garb"] = "Gewandung des Todesbringers";
	AL["Siegebreaker Battlegear"] = "Schlachtrüstung des Blockadenbrechers";
	AL["Siegebreaker Plate"] = "Plattenrüsung des Blockadenbrechers";

	-- Tier 9 Sets
	AL["Malfurion's Garb"] = "Malfurions Gewand";
	AL["Malfurion's Battlegear"] = "Malfurions Schlachtrüstung";
	AL["Malfurion's Regalia"] = "Malfurions Ornat";
	AL["Runetotem's Garb"] = "Runentotems Gewand";
	AL["Runetotem's Battlegear"] = "Runentotems Schlachtrüstung";
	AL["Runetotem's Regalia"] = "Runentotems Ornat";
	AL["Windrunner's Battlegear"] = "Windläufers Schlachtrüstung";
	AL["Windrunner's Pursuit"] = "Windläufers Jagdtracht";
	AL["Khadgar's Regalia"] = "Khadgars Ornat";
	AL["Sunstrider's Regalia"] = "Sonnenwanderers Ornat";
	AL["Turalyon's Garb"] = "Turalyons Gewand";
	AL["Turalyon's Battlegear"] = "Turalyons Schlachtrüstung";
	AL["Turalyon's Plate"] = "Turalyons Plattenrüstung";
	AL["Liadrin's Garb"] = "Liadrins Gewand";
	AL["Liadrin's Battlegear"] = "Liadrins Schlachtrüstung";
	AL["Liadrin's Plate"] = "Liadrins Plattenrüstung";
	AL["Velen's Regalia"] = "Velens Ornat";
	AL["Velen's Raiment"] = "Velens Gewandung";
	AL["Zabra's Regalia"] = "Zabras Ornat";
	AL["Zabra's Raiment"] = "Zabras Gewandung";
	AL["VanCleef's Battlegear"] = "Van Cleefs Schlachtrüstung";
	AL["Garona's Battlegear"] = "Garonas Schlachtrüstung";
	AL["Nobundo's Garb"] = "Nobundos Gewand";
	AL["Nobundo's Battlegear"] = "Nobundos Schlachtrüstung";
	AL["Nobundo's Regalia"] = "Nobundos Ornat";
	AL["Thrall's Garb"] = "Thralls Gewand";
	AL["Thrall's Battlegear"] = "Thralls Schlachtrüstung";
	AL["Thrall's Regalia"] = "Thralls Ornat";
	AL["Kel'Thuzad's Regalia"] = "Kel'Thuzads Ornat";
	AL["Gul'dan's Regalia"] = "Gul'dans Ornat";
	AL["Wrynn's Battlegear"] = "Wrynns Schlachtrüstung";
	AL["Wrynn's Plate"] = "Wrynns Plattenrüstung";
	AL["Hellscream's Battlegear"] = "Höllschreis Schlachtrüstung";
	AL["Hellscream's Plate"] = "Höllschreis Plattenrüstung";
	AL["Thassarian's Battlegear"] = "Thassarians Schlachtrüstung";
	AL["Koltira's Battlegear"] = "Koltiras Schlachtrüstung";
	AL["Thassarian's Plate"] = "Thassarians Plattenrüstung";
	AL["Koltira's Plate"] = "Koltiras Plattenrüstung";

	-- Tier 10 Sets
	AL["Lasherweave's Garb"] = "Peitschergewirktes Gewand";
	AL["Lasherweave's Battlegear"] = "Peitschergewirkte Schlachtrüstung";
	AL["Lasherweave's Regalia"] = "Peitschergewirktes Ornat";
	AL["Ahn'Kahar Blood Hunter's Battlegear"] = "Blutjägerschlachtrüstung der Ahn'Kahar";
	AL["Bloodmage's Regalia"] = "Ornat des Blutmagiers";
	AL["Lightsworn Garb"] = "Gewand des Lichts";
	AL["Lightsworn Plate"] = "Plattenrüstung des Lichts";
	AL["Lightsworn Battlegear"] = "Schlachtrüstung des Lichts";
	AL["Crimson Acolyte's Regalia"] = "Ornat des purpurroten Akolyten";
	AL["Crimson Acolyte's Raiment"] = "Roben des purpurroten Akolyten";
	AL["Shadowblade's Battlegear"] = "Schlachtrüstung der Schattenklinge";
	AL["Frost Witch's Garb"] = "Gewand der Frosthexe";
	AL["Frost Witch's Battlegear"] = "Schlachtrüstung der Frosthexe";
	AL["Frost Witch's Regalia"] = "Ornat der Frosthexe";
	AL["Dark Coven's Garb"] = "Ornat des dunklen Zirkels";
	AL["Ymirjar Lord's Battlegear"] = "Schlachtrüstung des Ymirjarfürsten";
	AL["Ymirjar Lord's Plate"] = "Plattenrüstung des Ymirjarfürsten";
	AL["Scourgelord's Battlegear"] = "Schlachtrüstung des Geißelfürsten";
	AL["Scourgelord's Plate"] = "Plattenrüstung des Geißelfürsten";

	-- Arathi Basin Sets - Alliance
	AL["The Highlander's Intent"] = "Brennender Eifer des Highlanders";
	AL["The Highlander's Purpose"] = "Schicksalsmacht des Highlanders";
	AL["The Highlander's Will"] = "Feuriger Wille des Highlanders";
	AL["The Highlander's Determination"] = "Inbrunst des Highlanders";
	AL["The Highlander's Fortitude"] = "Seelenkraft des Highlanders";
	AL["The Highlander's Resolution"] = "Unbeugsamkeit des Highlanders";
	AL["The Highlander's Resolve"] = "Entschlossenheit des Highlanders";

	-- Arathi Basin Sets - Horde
	AL["The Defiler's Intent"] = "Brennender Eifer der Entweihten";
	AL["The Defiler's Purpose"] = "Schicksalsmacht der Entweihten";
	AL["The Defiler's Will"] = "Feuriger Wille der Entweihten";
	AL["The Defiler's Determination"] = "Inbrunst der Entweihten";
	AL["The Defiler's Fortitude"] = "Seelenkraft der Entweihten";
	AL["The Defiler's Resolution"] = "Unbeugsamkeit der Entweihten";

	-- PvP Level 60 Rare Sets - Alliance
	AL["Lieutenant Commander's Refuge"] = "Haingewand des Feldkommandanten";
	AL["Lieutenant Commander's Pursuance"] = "Jagdrüstung des Feldkommandanten";
	AL["Lieutenant Commander's Arcanum"] = "Arkanum des Feldkommandanten";
	AL["Lieutenant Commander's Redoubt"] = "Zeremonienrüstung des Feldkommandanten";
	AL["Lieutenant Commander's Investiture"] = "Würdengewand des Feldkommandanten";
	AL["Lieutenant Commander's Guard"] = "Gewänder des Feldkommandanten";
	AL["Lieutenant Commander's Stormcaller"] = "Sturmornat des Feldkommandanten";
	AL["Lieutenant Commander's Dreadgear"] = "Schreckensrüstung des Feldkommandanten";
	AL["Lieutenant Commander's Battlearmor"] = "Sturmrüstung des Feldkommandanten";

	-- PvP Level 60 Rare Sets - Horde
	AL["Champion's Refuge"] = "Haingewand des Feldherren";
	AL["Champion's Pursuance"] = "Jagdrüstung des Feldherren";
	AL["Champion's Arcanum"] = "Arkanum des Feldherren";
	AL["Champion's Redoubt"] = "Zeremonierüstung des Feldherren";
	AL["Champion's Investiture"] = "Würdengewand des Feldherren";
	AL["Champion's Guard"] = "Gewänder des Feldherren";
	AL["Champion's Stormcaller"] = "Sturmornat des Feldherren";
	AL["Champion's Dreadgear"] = "Schreckensrüstung des Feldherren";
	AL["Champion's Battlearmor"] = "Sturmrüstung des Feldherren";

	-- PvP Level 60 Epic Sets - Alliance
	AL["Field Marshal's Sanctuary"] = "Zierat des Feldmarschalls";
	AL["Field Marshal's Pursuit"] = "Lohn des Feldmarschalls";
	AL["Field Marshal's Regalia"] = "Ornat des Feldmarschalls";
	AL["Field Marshal's Aegis"] = "Aegis des Feldmarschalls";
	AL["Field Marshal's Raiment"] = "Gewandung des Feldmarschalls";
	AL["Field Marshal's Vestments"] = "Gewänder des Feldmarschalls";
	AL["Field Marshal's Earthshaker"] = "Erderschütterer des Feldmarschalls";
	AL["Field Marshal's Threads"] = "Roben des Feldmarschalls";
	AL["Field Marshal's Battlegear"] = "Schlachtrüstung des Feldmarschalls";

	-- PvP Level 60 Epic Sets - Horde
	AL["Warlord's Sanctuary"] = "Zierat des Kriegsfürsten";
	AL["Warlord's Pursuit"] = "Lohn des des Kriegsfürsten";
	AL["Warlord's Regalia"] = "Ornat des Kriegsfürsten";
	AL["Warlord's Aegis"] = "Aegis des Kriegsfürsten";
	AL["Warlord's Raiment"] = "Gewandung des Kriegsfürsten";
	AL["Warlord's Vestments"] = "Gewänder des Kriegsfürsten";
	AL["Warlord's Earthshaker"] = "Erderschütterer des Kriegsfürsten";
	AL["Warlord's Threads"] = "Roben des Kriegsfürsten";
	AL["Warlord's Battlegear"] = "Schlachtrüstung des Kriegsfürsten";

	-- Outland Faction Reputation PvP Sets
	AL["Dragonhide Battlegear"] = "Schlachtrüstung aus Drachenleder";
	AL["Wyrmhide Battlegear"] = "Schlachtrüstung aus Wyrmbalg";
	AL["Kodohide Battlegear"] = "Schlachtrüstung aus Kodobalg";
	AL["Stalker's Chain Battlegear"] = "Kettenschlachtrüstung des Pirschers";
	AL["Evoker's Silk Battlegear"] = "Seidene Schlachtrüstung des Beschwörers";
	AL["Crusader's Scaled Battledgear"] = "Schuppenschlachtrüstung des Kreuzfahrers";
	AL["Crusader's Ornamented Battledgear"] = "Zieratschlachtrüstung des Kreuzfahrers";
	AL["Satin Battlegear"] = "Schlachtrüstung aus Satin";
	AL["Mooncloth Battlegear"] = "Schlachtrüstung aus Mondstoff";
	AL["Opportunist's Battlegear"] = "Schlachtrüstung des Heuchlers";
	AL["Seer's Linked Battlegear"] = "Gekettelte Schlachtrüstung des Sehers";
	AL["Seer's Mail Battlegear"] = "Schwere Schlachtrüstung des Sehers";
	AL["Seer's Ringmail Battlegear"] = "Ringpanzerschlachtrüstung des Sehers";
	AL["Dreadweave Battlegear"] = "Schlachtrüstung aus Schreckenszwirn";
	AL["Savage's Plate Battlegear"] = "Wilde Plattenschlachtrüstung";

	-- Arena Epic Sets
	AL["Gladiator's Sanctuary"] = "Schutzgewandung des Gladiators";
	AL["Gladiator's Wildhide"] = "Wildfell des Gladiators";
	AL["Gladiator's Refuge"] = "Zuflucht des Gladiators";
	AL["Gladiator's Pursuit"] = "Jagdtracht des Gladiators";
	AL["Gladiator's Regalia"] = "Ornat des Gladiators";
	AL["Gladiator's Aegis"] = "Aegis des Gladiators";
	AL["Gladiator's Vindication"] = "Rechtschaffenheit des Gladiators";
	AL["Gladiator's Redemption"] = "Erlösung des Gladiators";
	AL["Gladiator's Raiment"] = "Gewandung des Gladiators";
	AL["Gladiator's Investiture"] = "Vereidigung des Gladiators";
	AL["Gladiator's Vestments"] = "Gewänder des Gladiators";
	AL["Gladiator's Earthshaker"] = "Erderschütterer des Gladiators";
	AL["Gladiator's Thunderfist"] = "Donnerfaust des Gladiators";
	AL["Gladiator's Wartide"] = "Kriegsrausch des Gladiators";
	AL["Gladiator's Dreadgear"] = "Schreckensrüstung des Gladiators";
	AL["Gladiator's Felshroud"] = "Teufelsschleier des Gladiators";
	AL["Gladiator's Battlegear"] = "Schlachtrüstung des Gladiators";
	AL["Gladiator's Desecration"] = "Entweihung des Gladiators";

	-- Level 80 PvP Weapons
	AL["Savage Gladiator\'s Weapons"] = "Waffen des grausamen Gladiators"; --unused
	AL["Deadly Gladiator\'s Weapons"] = "Waffen des tödlichen Gladiators"; --unused
	AL["Furious Gladiator\'s Weapons"] = "Waffen des wütenden Gladiators";
	AL["Relentless Gladiator\'s Weapons"] = "Waffen des unerbittlichen Gladiators";
	AL["Wrathful Gladiator\'s Weapons"] = "Waffen des zornerfüllten Gladiators";

	-- Months
	AL["January"] = "Januar";
	AL["February"] = "Februar";
	AL["March"] = "März";
	-- AL["April"] = true;
	AL["May"] = "Mai";
	AL["June"] = "Juni";
	AL["July"] = "Juli";
	-- AL["August"] = true;
	-- AL["September"] = "true;
	AL["October"] = "Oktober";
	-- AL["November"] = true;
	AL["December"] = "Dezember";

	-- Specs
	AL["Balance"] = "Gleichgewicht";
	AL["Feral"] = "Wilder Kampf";
	AL["Restoration"] = "Wiederherstellung";
	AL["Holy"] = "Heilig";
	AL["Protection"] = "Schutz";
	AL["Retribution"] = "Vergeltung";
	AL["Shadow"] = "Schatten";
	AL["Elemental"] = "Elementar";
	AL["Enhancement"] = "Verstärkung";
	AL["Fury"] = "Furor";
	AL["Demonology"] = "Dämonologie";
	AL["Destruction"] = "Zerstörung";
    	AL["Tanking"] = "Schutz";
	AL["DPS"] = "Schaden";

	-- Naxx Zones
	AL["Construct Quarter"] = "Konstruktviertel";
	AL["Arachnid Quarter"] = "Arachnidenviertel";
	AL["Military Quarter"] = "Militärviertel";
	AL["Plague Quarter"] = "Seuchenviertel";
	AL["Frostwyrm Lair"] = "Frostwyrmhöhle";

	-- NPCs missing from BabbleBoss
	--AL["Trash Mobs"] = true;
	AL["Dungeon Set 2 Summonable"] = "Beschworener Boss (DS2)";
	AL["Highlord Kruul"] = "Hochlord Kruul";
	-- AL["Theldren"] = true;
	AL["Sothos and Jarien"] = "Sothos und Jarien";
	AL["Druid of the Fang"] = "Druiden des Giftzahns";
	AL["Defias Strip Miner"] = "Akkordminenarbeiter der Defias";
	AL["Defias Overseer/Taskmaster"] = "Vorarbeiter/Zuchtmeister der Defias";
	AL["Scarlet Defender/Myrmidon"] = "Scharlachroter Myrmidone/Verteidiger";
	AL["Scarlet Champion"] = "Scharlachroter Held";
	AL["Scarlet Centurion"] = "Scharlachroter Zenturio";
	AL["Scarlet Trainee"] = "Scharlachroter Lehrling";
	-- AL["Herod/Mograine"] = true;
	AL["Scarlet Protector/Guardsman"] = "Scharlachroter Beschützer/Gardist";
	AL["Shadowforge Flame Keeper"] = "Flammenbewahrer der Schattenschmiede";
	-- AL["Olaf"] = true;
	AL["Eric 'The Swift'"] = "Eric 'Der Flinke'";
	AL["Shadow of Doom"] = "Schatten der Verdammnis";
	AL["Bone Witch"] = "Knochenhexe";
	AL["Lumbering Horror"] = "Schwerfälliger Horror";
	AL["Avatar of the Martyred"] = "Avatar des Gemarterten";
	-- AL["Yor"] = true;
	AL["Nexus Stalker"] = "Nexuswandler";
	AL["Auchenai Monk"] = "Mönch der Auchenai";
	AL["Cabal Fanatic"] = "Fanatiker der Kabale";
	AL["Unchained Doombringer"] = "Entfesselter Verdammnisbringer";
	AL["Crimson Sorcerer"] = "Purpurroter Zauberhexer";
	AL["Thuzadin Shadowcaster"] = "Thuzadinschattenzauberer";
	AL["Crimson Inquisitor"] = "Purpurroter Inquisitor";
	AL["Crimson Battle Mage"] = "Purpurroter Kampfmagier";
	AL["Ghoul Ravener"] = "Tobsüchtiger Ghul";
	AL["Spectral Citizen"] = "Spektraler Bürger";
	AL["Spectral Researcher"] = "Spektraler Forscher";
	AL["Scholomance Adept"] = "Adept aus Scholomance";
	AL["Scholomance Dark Summoner"] = "Dunkler Beschwörer aus Scholomance";
	AL["Blackhand Elite"] = "Elitesoldat der Schwarzfaustlegion";
	AL["Blackhand Assassin"] = "Auftragsmörder der Schwarzfaustlegion";
	AL["Firebrand Pyromancer"] = "Pyromant der Feuerbrand";
	AL["Firebrand Invoker"] = "Herbeirufer der Feuerbrand";
	AL["Firebrand Grunt"] = "Grunzer der Feuerbrand";
	AL["Firebrand Legionnaire"] = "Legionär der Feuerbrand";
	AL["Spirestone Warlord"] = "Kriegsherr der Felsspitzoger";
	AL["Spirestone Mystic"] = "Mystiker der Felsspitzoger";
	AL["Anvilrage Captain"] = "Hauptmann der Zorneshämmer";
	AL["Anvilrage Marshal"] = "Marschall der Zorneshämmer";
	AL["Doomforge Arcanasmith"] = "Schicksalsträchtiger Arkanaschmied";
	AL["Weapon Technician"] = "Waffentechniker";
	AL["Doomforge Craftsman"] = "Schicksalsträchtiger Handwerker";
	AL["Murk Worm"] = "Düsterwurm";
	AL["Atal'ai Witch Doctor"] = "Hexendoktor der Atal'ai";
	AL["Raging Skeleton"] = "Tobendes Skelett";
	AL["Ethereal Priest"] = "Astraler Priester";
	AL["Sethekk Ravenguard"] = "Rabenwächter der Sethekk";
	AL["Time-Lost Shadowmage"] = "Zeitverlorener Schattenmagier";
	AL["Coilfang Sorceress"] = "Zauberhexerin des Echsenkessels";
	AL["Coilfang Oracle"] = "Orakel des Echsenkessels";
	AL["Shattered Hand Centurion"] = "Zenturio der Zerschmetterten Hand";
	AL["Eredar Deathbringer"] = "Todesbringer der Eredar";
	AL["Arcatraz Sentinel"] = "Schildwache der Arkatraz";
	AL["Gargantuan Abyssal"] = "Riesengroßer Abyss";
	AL["Sunseeker Botanist"] = "Botaniker der Sonnensucher";
	AL["Sunseeker Astromage"] = "Astromagier der Sonnensucher";
	AL["Durnholde Rifleman"] = "Scharfschütze von Durnholde";
	AL["Rift Keeper/Rift Lord"] = "Bewahrerin/Fürst der Zeitenrisse";
	AL["Crimson Templar"] = "Purpurroter Templer";
	AL["Azure Templar"] = "Azurblauer Templer";
	AL["Hoary Templar"] = "Weißgrauer Templer";
	AL["Earthen Templar"] = "Irdener Templer";
	AL["The Duke of Cynders"] = "Der Fürst der Asche";
	AL["The Duke of Fathoms"] = "Der Fürst der Tiefen";
	AL["The Duke of Zephyrs"] = "Der Fürst der Stürme";
	AL["The Duke of Shards"] = "Der Fürst der Splitter";
	AL["Aether-tech Assistant"] = "Äthertechnikerassistent";
	AL["Aether-tech Adept"] = "Äthertechnikeradept";
	AL["Aether-tech Master"] = "Meisteräthertechniker";
	-- AL["Trelopades"] = true;
	AL["King Dorfbruiser"] = "König Dorfelberster";
	AL["Gorgolon the All-seeing"] = "Gorgolon der Allessehende";
	-- AL["Matron Li-sahar"] = true;
	AL["Solus the Eternal"] = "Solus der Ewige";
	-- AL["Balzaphon"] = true;
	AL["Lord Blackwood"] = "Fürst Schwarzstahl";
	-- AL["Revanchion"] = true;
	AL["Scorn"] = "Der Verächter";
	AL["Sever"] = "Häcksler";
	-- AL["Lady Falther'ess"] = true;
	AL["Smokywood Pastures Vendor"] = "Kokelwälder Händler";
	-- AL["Shartuul"] = true;
	AL["Darkscreecher Akkarai"] = "Dunkelkreischer Akkarai";
	-- AL["Karrog"] = true;
	AL["Gezzarak the Huntress"] = "Gezzarak die Jägerin";
	AL["Vakkiz the Windrager"] = "Vakkiz der Windzürner";
	-- AL["Terokk"] = true;
	AL["Armbreaker Huffaz"] = "Armbrecher Huffaz";
	AL["Fel Tinkerer Zortan"] = "Teufelstüftler Zortan";
	-- AL["Forgosh"] = true;
	-- AL["Gul'bor"] = true;
	AL["Malevus the Mad"] = "Malevus die Verrückte";
	AL["Porfus the Gem Gorger"] = "Porfus der Edelsteinschlinger";
	AL["Wrathbringer Laz-tarash"] = "Zornschaffer Laz-tarash";
	AL["Bash'ir Landing Stasis Chambers"] = "Stasiskammer des Landeplatz von Bash'ir";
	AL["Templars"] = "Templer";
	AL["Dukes"] = "Fürsten";
	-- AL["High Council"] = true;
	AL["Headless Horseman"] = "Kopfloser Reiter";
	AL["Barleybrew Brewery"] = "Gerstenbräu";
	AL["Thunderbrew Brewery"] = "Donnerbräu";
	AL["Gordok Brewery"] = "Gordokbrauerei";
	AL["Drohn's Distillery"] = "Brauerei Drohn";
	AL["T'chali's Voodoo Brewery"] = "T'chalis Voodoobrauerei";
	AL["Scarshield Quartermaster"] = "Rüstmeister der Schmetterschilde";
	AL["Overmaster Pyron"] = "Übermeister Pyron";
	AL["Father Flame"] = "Vater Flamme";
	AL["Thomas Yance"] = "Thomas Yance";
	AL["Knot Thimblejack"] = "Knot Zwingschraub";
	AL["Shen'dralar Provisioner"] = "Versorger der Shen'dralar";
	AL["Namdo Bizzfizzle"] = "Namdo Blitzzischel";
	AL["The Nameles Prophet"] = "The Nameles Prophet";
	AL["Zelemar the Wrathful"] = "Zelemar the Wrathful";
	AL["Henry Stern"] = "Henry Stern";
	AL["Aggem Thorncurse"] = "Aggem Dornfluch";
	AL["Roogug"] = "Roogug";
	AL["Rajaxx's Captains"] = "Rajaxx's Captains";
	AL["Razorfen Spearhide"] = "Speerträger der Klingenhauer";
	AL["Rethilgore"] = "Rotkralle";
	AL["Kalldan Felmoon"] = "Kalldan Teufelsmond";
	AL["Magregan Deepshadow"] = "Magregan Grubenschatten";
	AL["Lord Ahune"] = "Fürst Ahune";
	AL["Coren Direbrew"] = "Coren Düsterbräu";
	-- AL["Don Carlos"] = true;
	-- AL["Thomas Yance"] = true;
	AL["Aged Dalaran Wizard"] = "Gealterter Hexer von Dalaran";
	AL["Cache of the Legion"] = "Behälter der Legion";
	-- AL["Rajaxx's Captains"] = true;
	AL["Felsteed"] = "Teufelsross";
	AL["Shattered Hand Executioner"] = "Henker der Zerschmetterten Hand";
	AL["Commander Stoutbeard"] = "Kommandant Starkbart"; -- Is in BabbleBoss
	-- AL["Bjarngrim"] = true; Is in BabbleBoss
	-- AL["Loken"] = true; Is in BabbleBoss
	AL["Time-Lost Proto Drake"] = "Zeitverlorener Protodrache";
	AL["Faction Champions"] = "Fraktion-Champions"; -- if you have a better name, use it.
	AL["Razzashi Raptor"] = "Razzashiraptor";
	AL["Deviate Ravager/Deviate Guardian"] = "Deviatverheerer/Deviatwächter";
	AL["Krick and Ick"]  = "Krick und Ick";

	-- Zones
	AL["World Drop"] = "Weltdrops";
	AL["Sunwell Isle"] = "Insel des Sonnenbrunnens";

	-- Shortcuts for Bossname files
	-- AL["LBRS"] = true;
	-- AL["UBRS"] = true;
	AL["CoT1"] = "HdZ1";
	AL["CoT2"] = "HdZ2";
	-- AL["Scholo"] = true;
	-- AL["Strat"] = true;
	AL["Serpentshrine"] = "Schlangenschrein";
	-- AL["Avatar"] = true; Avatar of the Martyred

	-- Chests, etc
	AL["Dark Coffer"] = "Dunkler Kasten";
	AL["The Secret Safe"] = "Geheimsafe";
	AL["The Vault"] = "Der Tresor";
	AL["Ogre Tannin Basket"] = "Gerbekorb der Oger";
	AL["Fengus's Chest"] = "Fengus Truhe";
	AL["The Prince's Chest"] = "Die Truhe des Prinzen";
	AL["Doan's Strongbox"] = "Doans Geldkassette";
	AL["Frostwhisper's Embalming Fluid"] = "Frostraunens Balsamierungsflüssigkeit";
	AL["Unforged Rune Covered Breastplate"] = "Ungeschmiedete runenverzierte Brustplatte";
	AL["Malor's Strongbox"] = "Malors Geldkassette";
	AL["Unfinished Painting"] = "Unvollendetes Gemälde";
	AL["Felvine Shard"] = "Teufelsrankensplitter";
	AL["Baelog's Chest"] = "Baelogs Truhe";
	AL["Lorgalis Manuscript"] = "Manuskript von Lorgalis";
	AL["Fathom Core"] = "Tiefenkern";
	AL["Conspicuous Urn"] = "Verdächtige Urne";
	AL["Gift of Adoration"] = "Geschenke der Verehrung";
	AL["Box of Chocolates"] = "Schokoladenschachtel";
	AL["Treat Bag"] = "Schlotterbeutel";
	AL["Gaily Wrapped Present"] = "Fröhlich verpacktes Geschenk";
	AL["Festive Gift"] = "Festtagsgeschenk";
	AL["Ticking Present"] = "Tickendes Geschenk";
	AL["Gently Shaken Gift"] = "Leicht geschütteltes Geschenk";
	AL["Carefully Wrapped Present"] = "Sorgfältig verpacktes Geschenk";
	AL["Winter Veil Gift"] = "Winterhauchgeschenk";
	AL["Smokywood Pastures Extra-Special Gift"] = "Kokelwälder Extraspezialgeschenk";
	AL["Brightly Colored Egg"] = "Osterei";
	AL["Lunar Festival Fireworks Pack"] = "Feuerwerkspaket des Mondfests";
	AL["Lucky Red Envelope"] = "Roter Glücksumschlag";
	AL["Small Rocket Recipes"] = "Rezepte für kleine Raketen";
	AL["Large Rocket Recipes"] = "Rezepte für große Raketen";
	AL["Cluster Rocket Recipes"] = "Rezepte für Raketenbündel";
	AL["Large Cluster Rocket Recipes"] = "Rezepte für große Raketenbündel";
	-- AL["Timed Reward Chest"] = true;
	-- AL["Timed Reward Chest 1"] = true;
	-- AL["Timed Reward Chest 2"] = true;
	-- AL["Timed Reward Chest 3"] = true;
	-- AL["Timed Reward Chest 4"] = true;
	AL["The Talon King's Coffer"] = "Der Kasten des Klauenkönigs";
	AL["Krom Stoutarm's Chest"] = "Krom Starkarms Truhe";
	AL["Garrett Family Chest"] = "Familientruhe der Garretts";
	AL["Reinforced Fel Iron Chest"] = "Verstärkte Teufelseisentruhe";
	AL["DM North Tribute Chest"] = "DM Nord Tributtruhe";
	AL["The Saga of Terokk"] = "Die Sage von Terokk";
	AL["First Fragment Guardian"] = "Wächter des ersten Teils";
	AL["Second Fragment Guardian"] = "Wächter des zweiten Teils";
	AL["Third Fragment Guardian"] = "Wächter des dritten Teils";
	AL["Overcharged Manacell"] = "Überladene Manazelle";
	AL["Mysterious Egg"] = "Mysteriöses Ei";
	AL["Hyldnir Spoils"] = "Hyldnirbeute";
	AL["Ripe Disgusting Jar"] = "Reife eklige Flasche";
	AL["Cracked Egg"] = "Zerbrochene Eierschale";
	AL["Small Spice Bag"] = "Kleines Gewürzsäckchen";
	AL["Handful of Candy"] = "Eine Handvoll Süßigkeiten";
	AL["Lovely Dress Box"] = "Karton 'Reizendes Kleid'";
	AL["Dinner Suit Box"] = "Karton 'Abendanzug'";
	AL["Bag of Heart Candies"] = "Tüte mit Zuckerherzen";

	-- The next 4 lines are the tooltip for the Server Query Button
	-- The translation doesn't have to be literal, just re-write the
	-- sentences as you would naturally and break them up into 4 roughly
	-- equal lines.
	AL["Queries the server for all items"] = "Fragt den Server nach allen Items";
   	AL["on this page. The items will be"] = "auf dieser Seite. Die Items werden";
	AL["refreshed when you next mouse"] = "geladen, sobald ihr das nächste Mal";
	AL["over them."] = "mit der Maus drüber fahrt.";
	AL["The Minimap Button is generated by the FuBar Plugin."] = "Der Minimap Button wird vom FuBar Plugin erzeugt.";
	AL["This is automatic, you do not need FuBar installed."] = "Dies passiert automatisch, FuBar muss nicht installiert sein.";

	-- Help Frame
	AL["Help"] = "Hilfe";
	AL["AtlasLoot Help"] = "AtlasLoot Hilfe";
	AL["For further help, see our website and forums: "] = "Bitte besuchen Sie für weitere Hilfe die Webseite und das Forum: ";
	AL["How to open the standalone Loot Browser:"] = "Eigenständigen Beute-Browser öffnen";
	AL["If you have AtlasLootFu enabled, click the minimap button, or alternatively a button generated by a mod like Titan or FuBar.  Finally, you can type '/al' in the chat window."] = "Sollte AtlasLootFu aktiviert sein, klicken Sie einfach den Minimap Button oder den Button in einem installierten Mod wie Titan oder FuBar. Andernfalls können Sie auch einfach '/al' im Chatfenster eingeben.";
	AL["How to view an 'unsafe' item:"] = "'Unsicheren' Gegenstand ansehen:";
	AL["Unsafe items have a red border around the icon and are marked because you have not seen the item since the last patch or server restart. Right-click the item, then move your mouse back over the item or click the 'Query Server' button at the bottom of the loot page."] = "Die Symbole unsicherer Gegenstände sind rot umrandet und gekennzeichnet, da sie seit dem letzten Patch oder Serverneustart nicht gesehen wurden. Rechtsklicken Sie den Gegenstand und bewegen dann die Maus wieder über selbigen oder nutzen Sie den 'Serverabfrage' Button am unteren Ende der Beute-Seite.";
	AL["How to view an item in the Dressing Room:"] = "Einen Gegenstand in der Anprobe anzeigen";
	AL["Simply Ctrl+Left Click on the item.  Sometimes the dressing room window is hidden behind the Atlas or AtlasLoot windows, so if nothing seems to happen move your Atlas or AtlasLoot windows and see if anything is hidden."] = "Strg+Linksklick auf den Gegenstand. Teilweise wird die Anprobe durch die Atlas oder AtlasLoot Fenster verdeckt. Wenn also nichts passiert, bewegen Sie diese Fenster an einen anderen Platz.";
	AL["How to link an item to someone else:"] = "Einen Gegenstand an jemand anderen verlinken";
	AL["Shift+Left Click the item like you would for any other in-game item"] = "Shift+Linksklick auf den zu verlinkenden Gegenstand";
	AL["How to add an item to the wishlist:"] = "Einen Gegenstand zum Wunschzettel hinzufügen";
	AL["Alt+Left Click any item to add it to the wishlist."] = "Alt+Linksklick auf einen Gegenstand fügt ihn zum Wunschzettel hinzu.";
	AL["How to delete an item from the wishlist:"] = "Einen Gegenstand vom Wunschzettel entfernen";
	AL["While on the wishlist screen, just Alt+Left Click on an item to delete it."] = "Zum Entfernen eines Gegenstandes müssen Sie diesen einfach im Wunschzettel Alt+Linksklicken.";
	AL["What else does the wishlist do?"] = "Wofür sonst ist der Wunschzettel da?";
	AL["If you Left Click any item on the wishlist, you can jump to the loot page the item comes from.  Also, on a loot page any item already in your wishlist is marked with a yellow star."] = "Mit einem Linksklick auf einen Gegenstand auf dem Wunschzettel gelangen Sie zu dem Beuteverzeichnis aus dem der Gegenstand stammt. Des Weiteren wird jeder bereits auf dem Wunschzettel befindliche Gegenstand in den Verzeichnissen mit einem zuvor vergebenen Symbol vermerkt.";
	AL["HELP!! I have broken the mod somehow!"] = "HILFE!!! Das Addon läuft nicht mehr!";
	AL["Use the reset buttons available in the options menu, or type '/al reset' in your chat window."] = "Nutzen Sie den Zurücksetzen Button im Optionsmenü oder geben Sie '/al reset' im Chatfenster ein.";

	-- Error Messages and warnings
	AL["AtlasLoot Error!"] = "AtlasLoot Fehler!";
	AL["WishList Full!"] = "Wunschzettel voll!";
	AL[" added to the WishList."] = " zum Wunschzettel hinzugefügt";
	AL[" already in the WishList!"] = " bereits auf dem Wunschzettel!";
	AL[" deleted from the WishList."] = " vom Wunschzettel gelöscht";
	AL["No match found for"] = "Keine Übereinstimmung gefunden für";
	AL[" is safe."] = " ist sicher.";
	AL["Server queried for "] = "Frage Server nach ";
	AL[".  Right click on any other item to refresh the loot page."] = ".  Rechtsklicken Sie ein anderes Item um die Seite zu aktualisieren.";

	-- Incomplete Table Registry error message
	AL[" not listed in loot table registry, please report this message to the AtlasLoot forums at http://www.atlasloot.net"] = " nicht im Loot-Tabellen Register gelistet, bitte melde diese Nachricht im AtlasLoot Forum unter http://www.atlasloot.net";

	-- LoD Module disabled or missing
	AL[" is unavailable, the following load on demand module is required: "] = " ist nicht verfügbar, das folgende Modul wird benötigt: ";

	-- LoD Module load sequence could not be completed
	AL["Status of the following module could not be determined: "] = "Status von folgendem Modul konnte nicht festgestellt werden: ";

	-- LoD Module required has loaded, but loot table is missing
	AL[" could not be accessed, the following module may be out of date: "] = " konnte nicht erreicht werden, das folgende Modul könnte veraltet sein: ";

	-- LoD module not defined
	AL["Loot module returned as nil!"] = "Lootmodul nicht definiert!";

	-- LoD module loaded successfully
	AL["sucessfully loaded."] = "erfogreich geladen.";

	-- Need a big dataset for searching
	AL["Loading available tables for searching"] = "Lade verfügbare Module zum Suchen";

	-- All Available modules loaded
	AL["All Available Modules Loaded"] = "Alle verfügbaren Module geladen";

	-- First time user
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."] = "Willkommen zu Atlasloot Enhanced!  Bitte nimm Dir einen Moment Zeit, um die Einstellungen festzulegen";
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences for tooltips and links in the chat window.\n\n  This options screen can be reached again at any later time by typing '/atlasloot'."] = "Willkommen zu Atlasloot Enhanced!  Bitte nimm dir einen Moment Zeit, um die Einstellungen für Tooltips und Chatlinks festzulegen.\nWenn du später etwas ändern willst, kannst du den Optionsbildschirm mit /atlasloot aufrufen.";
	AL["Setup"] = "Optionen";

	-- Old Atlas Detected
	AL["It has been detected that your version of Atlas does not match the version that Atlasloot is tuned for ("] = "Atlasloot hat festgestellt, dass die Version von Atlas, die du benutzt, nicht der Version entspricht für die Atlasloot konzipiert ist(";
	AL[").  Depending on changes, there may be the occasional error, so please visit http://www.atlasmod.com as soon as possible to update."] = "). Dadurch können (schwere) Fehler auftreten! Bitte besuch so schnell wie möglich http://www.atlasmod.com und lad dir die neuste Atlas Version runter.";
	-- AL["OK"] = "OK";
	AL["Incompatible Atlas Detected"] = "Nicht kompatibles Atlas gefunden";

	-- Unsafe item tooltip
	AL["Unsafe Item"] = "Unsicheres Item";
	AL["Item Unavailable"] = "Item nicht verfügbar";
	-- AL["ItemID:"] = true;
	AL["This item is not available on your server or your battlegroup yet."] = "Dieses Item ist auf deinem Server bzw. deinem Realmpool nicht verfügbar";
	AL["This item is unsafe.  To view this item without the risk of disconnection, you need to have first seen it in the game world. This is a restriction enforced by Blizzard since Patch 1.10."] = "Diese Item ist unsicher.\nSobald du dieses Item ingame gesehen hast,\nbesteht nicht mehr die Gefahr eines Verbindungsabbruch\n(Es ist dann nicht mehr unsicher). Diese\nBestimmung wurde von Blizzard mit\nPatch 1.10 festgelegt.";
	AL["You can right-click to attempt to query the server.  You may be disconnected."] = "Mit einem Rechtsklick wird der\nServer nach dem Item abgefragt, dabei\nkönnte die Verbindung unterbrochen werden.";

end