--[[
constants.en.lua
This file defines an AceLocale table for all the various text strings needed
by AtlasLoot.  In this implementation, if a translation is missing, it will fall
back to the English translation.

The AL["text"] = true; shortcut can ONLY be used for English (the root translation).
]]

--Table holding all loot tables is initialised here as it loads early
AtlasLoot_Data = {};
AtlasLoot_TableNames = {};

--Create the library instance
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");

local AL = AceLocale:NewLocale("AtlasLoot", "enUS", true);

--Register translations
if AL then

	-- Text strings for UI objects
	AL["AtlasLoot"] = true;
	AL["Select Loot Table"] = true;
	AL["Select Sub-Table"] = true;
	AL["Drop Rate: "] = true;
	AL["DKP"] = true;
	AL["Priority:"] = true;
	AL["Click boss name to view loot."] = true;
	AL["Various Locations"] = true;
	AL["This is a loot browser only.  To view maps as well, install either Atlas or Alphamap."] = true;
	AL["Toggle AL Panel"] = true;
	AL["Back"] = true;
	AL["Level 60"] = true;
	AL["Level 70"] = true;
	AL["Level 80"] = true;
	AL["|cffff0000(unsafe)"] = true;
	AL["Misc"] = true;
	AL["Miscellaneous"] = true;
	AL["Rewards"] = true;
	AL["Show 10 Man Loot"] = true;
	AL["Show 25 Man Loot"] = true;
	AL["Factions - Original WoW"] = true;
	AL["Factions - Burning Crusade"] = true;
	AL["Factions - Wrath of the Lich King"] = true;
	AL["Choose Table ..."] = true;
	AL["Unknown"] = true;
	AL["Add to QuickLooks:"] = true;
	AL["Assign this loot table\n to QuickLook"] = true;
	AL["Query Server"] = true;
	AL["Reset Frames"] = true;
	AL["Reset Wishlist"] = true;
	AL["Reset Quicklooks"] = true;
	AL["Select a Loot Table..."] = true;
	AL["OR"] = true;
	AL["FuBar Options"] = true;
	AL["Attach to Minimap"] = true;
	AL["Hide FuBar Plugin"] = true;
	AL["Show FuBar Plugin"] = true;
	AL["Position:"] = true;
	AL["Left"] = true;
	AL["Center"] = true;
	AL["Right"] = true;
	AL["Hide Text"] = true;
	AL["Hide Icon"] = true;
	AL["Minimap Button Options"] = true;

	-- Text for Options Panel
	AL["Atlasloot Options"] = true;
	AL["Safe Chat Links"] = true;
	AL["Default Tooltips"] = true;
	AL["Lootlink Tooltips"] = true;
	AL["|cff9d9d9dLootlink Tooltips|r"] = true;
	AL["ItemSync Tooltips"] = true;
	AL["|cff9d9d9dItemSync Tooltips|r"] = true;
	AL["Use EquipCompare"] = true;
	AL["|cff9d9d9dUse EquipCompare|r"] = true;
	AL["Show Comparison Tooltips"] = true;
	AL["Make Loot Table Opaque"] = true;
	AL["Show itemIDs at all times"] = true;
	AL["Hide AtlasLoot Panel"] = true;
	AL["Show Basic Minimap Button"] = true;
	AL["|cff9d9d9dShow Basic Minimap Button|r"] = true;
	AL["Set Minimap Button Position"] = true;
	AL["Suppress Item Query Text"] = true;
	AL["Notify on LoD Module Load"] = true;
	AL["Load Loot Modules at Startup"] = true;
	AL["Loot Browser Scale: "] = true;
	AL["Button Position: "] = true;
	AL["Button Radius: "] = true;
	AL["Done"] = true;
	AL["FuBar Toggle"] = true;
	AL["Search Result: %s"] = true;
	AL["Search on"] = true;
	AL["All modules"] = true;
	AL["If checked, AtlasLoot will load and search across all the modules."] = true;
	AL["Search options"] = true;
	AL["Partial matching"] = true;
	AL["If checked, AtlasLoot search item names for a partial match."] = true;
	AL["You don't have any module selected to search on!"] = true;
	AL["Treat Crafted Items:"] = true;
	AL["As Crafting Spells"] = true;
	AL["As Items"] = true;
	AL["Loot Browser Style:"] = true;
	AL["New Style"] = true;
	AL["Classic Style"] = true;

	-- Slash commands
	AL["reset"] = true;
	AL["options"] = true;
	AL["Reset complete!"] = true;

	-- AtlasLoot Panel
	AL["Collections"] = true;
	AL["Crafting"] = true;
	AL["Factions"] = true;
	AL["Load Modules"] = true;
	AL["Options"] = true;
	AL["PvP Rewards"] = true;
	AL["QuickLook"] = true;
	AL["World Events"] = true;

	-- AtlasLoot Panel - Search
	AL["Clear"] = true;
	AL["Last Result"] = true;
	AL["Search"] = true;

	-- AtlasLoot Browser Menus
	AL["Classic Instances"] = true;
	AL["BC Instances"] = true;
	AL["Sets/Collections"] = true;
	AL["Reputation Factions"] = true;
	AL["WotLK Instances"] = true;
	AL["World Bosses"] = true;
	AL["Close Menu"] = true;

	-- Crafting Menu
	AL["Crafting Daily Quests"] = true;
	AL["Cooking Daily"] = true;
	AL["Fishing Daily"] = true;
	AL["Jewelcrafting Daily"] = true;
	AL["Crafted Sets"] = true;
	AL["Crafted Epic Weapons"] = true;
	AL["Dragon's Eye"] = true;

	-- Sets/Collections Menu
	AL["Badge of Justice Rewards"] = true;
	AL["Emblem of Valor Rewards"] = true;
	AL["Emblem of Heroism Rewards"] = true;
	AL["Emblem of Conquest Rewards"] = true;
	AL["Emblem of Triumph Rewards"] = true;
	AL["Emblem of Frost Rewards"] = true;
	AL["BoE World Epics"] = true;
	AL["Dungeon 1/2 Sets"] = true;
	AL["Dungeon 3 Sets"] = true;
	AL["Legendary Items"] = true;
	AL["Mounts"] = true;
	AL["Vanity Pets"] = true;
	AL["Misc Sets"] = true;
	AL["Classic Sets"] = true;
	AL["Burning Crusade Sets"] = true;
	AL["Wrath Of The Lich King Sets"] = true;
	AL["Ruins of Ahn'Qiraj Sets"] = true;
	AL["Temple of Ahn'Qiraj Sets"] = true;
	AL["Tabards"] = true;
	AL["Tier 1/2 Sets"] = true;
	AL["Tier 1/2/3 Sets"] = true;
	AL["Tier 3 Sets"] = true;
	AL["Tier 4/5/6 Sets"] = true;
	AL["Tier 7/8 Sets"] = true;
	AL["Upper Deck Card Game Items"] = true;
	AL["Zul'Gurub Sets"] = true;

	-- Factions Menu
	AL["Original Factions"] = true;
	AL["BC Factions"] = true;
	AL["WotLK Factions"] = true;

	-- PvP Menu
	AL["Arena PvP Sets"] = true;
	AL["PvP Rewards (Level 60)"] = true;
	AL["PvP Rewards (Level 70)"] = true;
	AL["PvP Rewards (Level 80)"] = true;
	AL["Arathi Basin Sets"] = true;
	AL["PvP Accessories"] = true;
	AL["PvP Armor Sets"] = true;
	AL["PvP Weapons"] = true;
	AL["PvP Non-Set Epics"] = true;
	AL["PvP Reputation Sets"] = true;
	AL["Arena PvP Weapons"] = true;
	AL["PvP Misc"] = true;
	AL["PVP Gems/Enchants/Jewelcrafting Designs"] = true;
	AL["Level 80 PvP Sets"] = true;
	AL["Old Level 80 PvP Sets"] = true;
	AL["Arena Season 7/8 Sets"] = true;
	AL["PvP Class Items"] = true;
	AL["NOT AVAILABLE ANYMORE"] = true;

	-- World Events
	AL["Abyssal Council"] = true;
	AL["Argent Tournament"] = true;
	AL["Bash'ir Landing Skyguard Raid"] = true;
	AL["Brewfest"] = true;
	AL["Children's Week"] = true;
	AL["Day of the Dead"] = true;
	AL["Elemental Invasion"] = true;
	AL["Ethereum Prison"] = true;
	AL["Feast of Winter Veil"] = true;
	AL["Gurubashi Arena Booty Run"] = true;
	AL["Hallow's End"] = true;
	AL["Harvest Festival"] = true;
	AL["Love is in the Air"] = true;
	AL["Lunar Festival"] = true;
	AL["Midsummer Fire Festival"] = true;
	AL["Noblegarden"] = true;
	AL["Pilgrim's Bounty"] = true;
	AL["Skettis"] = true;
	AL["Stranglethorn Fishing Extravaganza"] = true;

	-- Minimap Button
	AL["|cff1eff00Left-Click|r Browse Loot Tables"] = true;
	AL["|cffff0000Right-Click|r View Options"] = true;
	AL["|cffff0000Shift-Click|r View Options"] = true;
	AL["|cffccccccLeft-Click + Drag|r Move Minimap Button"] = true;
	AL["|cffccccccRight-Click + Drag|r Move Minimap Button"] = true;

	-- Filter
	AL["Filter"] = true;
	AL["Select All Loot"] = true;
	AL["Apply Filter:"] = true;
	AL["Armor:"] = true;
	AL["Melee weapons:"] = true;
	AL["Ranged weapons:"] = true;
	AL["Relics:"] = true;
	AL["Other:"] = true;

	-- Wishlist
	AL["Close"] = true;
	AL["Wishlist"] = true;
	AL["Own Wishlists"] = true;
	AL["Other Wishlists"] = true;
	AL["Shared Wishlists"] = true;
	AL["Mark items in loot tables"] = true;
	AL["Mark items from own Wishlist"] = true;
	AL["Mark items from all Wishlists"] = true;
	AL["Enable Wishlist Sharing"] = true;
	AL["Auto reject in combat"] = true;
	AL["Always use default Wishlist"] = true;
	AL["Add Wishlist"] = true;
	AL["Edit Wishlist"] = true;
	AL["Show More Icons"] = true;
	AL["Wishlist name:"] = true;
	AL["Delete"] = true;
	AL["Edit"] = true;
	AL["Share"] = true;
	AL["Show all Wishlists"] = true;
	AL["Show own Wishlists"] = true;
	AL["Show shared Wishlists"] = true;
	AL["You must wait "] = true;
	AL[" seconds before you can send a new Wishlist to "] = true;
	AL["Send Wishlist (%s) to"] = true;
	AL["Send"] = true;
	AL["Cancel"] = true;
	AL["Delete Wishlist %s?"] = true;
	AL["%s sends you a Wishlist. Accept?"] = true;
	AL[" tried to send you a Wishlist. Rejected because you are in combat."] = true;
	AL[" rejects your Wishlist."] = true;
	AL["You can't send Wishlists to yourself"] = true;
	AL["Please set a default Wishlist."] = true;
	AL["Set as default Wishlist"] = true;

	-- Misc Inventory related words
	AL["Enchant"] = true;
	AL["Scope"] = true;
	AL["Darkmoon Faire Card"] = true;
	AL["Banner"] = true;
	AL["Set"] = true;
	AL["Token"] = true;
	AL["Tokens"] = true;
	AL["Token Hand-Ins"] = true;
	AL["Skinning Knife"] = true;
	AL["Herbalism Knife"] = true;
	AL["Fish"] = true;
	AL["Combat Pet"] = true;
	AL["Fireworks"] = true;
	AL["Fishing Lure"] = true;

	-- Extra inventory stuff
	AL["Cloak"] = true;
	AL["Sigil"] = true; -- Can be added to BabbleInv

	-- Alchemy
	AL["Battle Elixirs"] = true;
	AL["Guardian Elixirs"] = true;
	AL["Potions"] = true;
	AL["Transmutes"] = true;
	AL["Flasks"] = true;

	-- Enchanting
	AL["Enchant Boots"] = true;
	AL["Enchant Bracer"] = true;
	AL["Enchant Chest"] = true;
	AL["Enchant Cloak"] = true;
	AL["Enchant Gloves"] = true;
	AL["Enchant Ring"] = true;
	AL["Enchant Shield"] = true;
	AL["Enchant 2H Weapon"] = true;
	AL["Enchant Weapon"] = true;

	-- Engineering
	AL["Ammunition"] = true;
	AL["Explosives"] = true;

	-- Inscription
	AL["Major Glyph"] = true;
	AL["Minor Glyph"] = true;
	AL["Scrolls"] = true;
	AL["Off-Hand Items"] = true;
	AL["Reagents"] = true;
	AL["Book of Glyph Mastery"] = true;

	-- Leatherworking
	AL["Leather Armor"] = true;
	AL["Mail Armor"] = true;
	AL["Cloaks"] = true;
	AL["Item Enhancements"] = true;
	AL["Quivers and Ammo Pouches"] = true;
	AL["Drums, Bags and Misc."] = true;

	-- Tailoring
	AL["Cloth Armor"] = true;
	AL["Shirts"] = true;
	AL["Bags"] = true;

	-- Labels for loot descriptions
	AL["Classes:"] = true;
	AL["This Item Begins a Quest"] = true;
	AL["Quest Item"] = true;
	AL["Old Quest Item"] = true;
	AL["Quest Reward"] = true;
	AL["Old Quest Reward"] = true;
	AL["Shared"] = true;
	AL["Unique"] = true;
	AL["Right Half"] = true;
	AL["Left Half"] = true;
	AL["28 Slot Soul Shard"] = true;
	AL["20 Slot"] = true;
	AL["18 Slot"] = true;
	AL["16 Slot"] = true;
	AL["10 Slot"] = true;
	AL["(has random enchantment)"] = true;
	AL["Currency"] = true;
	AL["Currency (Alliance)"] = true;
	AL["Currency (Horde)"] = true;
	AL["Conjured Item"] = true;
	AL["Used to summon boss"] = true;
	AL["Tradable against sunmote + item above"] = true;
	AL["Card Game Item"] = true;
	AL["Skill Required:"] = true;
	AL["Rating:"] = true; -- Shorthand for 'Required Rating' for the personal/team ratings
	AL["Random Heroic Reward"] = true;

	-- Minor Labels for loot table descriptions
	AL["Original WoW"] = true;
	AL["Burning Crusade"] = true;
	AL["Wrath of the Lich King"] = true;
	AL["Entrance"] = true;
	AL["Season 2"] = true;
	AL["Season 3"] = true;
	AL["Season 4"] = true;
	AL["Dungeon Set 1"] = true;
	AL["Dungeon Set 2"] = true;
	AL["Dungeon Set 3"] = true;
	AL["Tier 1"] = true;
	AL["Tier 2"] = true;
	AL["Tier 3"] = true;
	AL["Tier 4"] = true;
	AL["Tier 5"] = true;
	AL["Tier 6"] = true;
	AL["Tier 7"] = true;
	AL["Tier 8"] = true;
	AL["Tier 9"] = true;
	AL["Tier 10"] = true;
	AL["10 Man"] = true;
	AL["25 Man"] = true;
	AL["10/25 Man"] = true;
	AL["Epic Set"] = true;
	AL["Rare Set"] = true;
	AL["Fire"] = true;
	AL["Water"] = true;
	AL["Wind"] = true;
	AL["Earth"] = true;
	AL["Master Angler"] = true;
	AL["Fire Resistance Gear"] = true;
	AL["Arcane Resistance Gear"] = true;
	AL["Nature Resistance Gear"] = true;
	AL["Frost Resistance Gear"] = true;
	AL["Shadow Resistance Gear"] = true;

	-- Labels for loot table sections
	AL["Additional Heroic Loot"] = true;
	AL["Heroic Mode"] = true;
	AL["Normal Mode"] = true;
	AL["Raid"] = true;
	AL["Hard Mode"] = true;
	AL["Bonus Loot"] = true;
	AL["One Drake Left"] = true;
	AL["Two Drakes Left"] = true;
	AL["Three Drakes Left"] = true;
	AL["Arena Reward"] = true;
	AL["Phase 1"] = true;
	AL["Phase 2"] = true;
	AL["Phase 3"] = true;
	AL["First Prize"] = true;
	AL["Rare Fish Rewards"] = true;
	AL["Rare Fish"] = true;
	AL["Unattainable Tabards"] = true;
	AL["Heirloom"] = true;
	AL["Weapons"] = true;
	AL["Accessories"] = true;
	AL["Alone in the Darkness"] = true;
	AL["Call of the Grand Crusade"] = true;
	AL["A Tribute to Skill (25)"] = true;
	AL["A Tribute to Mad Skill (45)"] = true;
	AL["A Tribute to Insanity (50)"] = true;
	AL["A Tribute to Immortality"] = true;
	AL["Low Level"] = true;
	AL["High Level"] = true;

	-- Loot Table Names
	AL["Scholomance Sets"] = true;
	AL["PvP Accessories (Level 60)"] = true;
	AL["PvP Accessories - Alliance (Level 60)"] = true;
	AL["PvP Accessories - Horde (Level 60)"] = true;
	AL["PvP Weapons (Level 60)"] = true;
	AL["PvP Accessories (Level 70)"] = true;
	AL["PvP Weapons (Level 70)"] = true;
	AL["PvP Reputation Sets (Level 70)"] = true;
	AL["Arena Season 2 Weapons"] = true;
	AL["Arena Season 3 Weapons"] = true;
	AL["Arena Season 4 Weapons"] = true;
	AL["Level 30-39"] = true;
	AL["Level 40-49"] = true;
	AL["Level 50-60"] = true;
	AL["Heroic"] = true;
	AL["Summon"] = true;
	AL["Random"] = true;
	AL["Tier 8 Sets"] = true;
	AL["Tier 9 Sets"] = true;
	AL["Tier 10 Sets"] = true;
	AL["Furious Gladiator Sets"] = true;
	AL["Relentless Gladiator Sets"] = true;
	AL["Brew of the Month Club"] = true;

	-- Extra Text in Boss lists
	AL["Set: Embrace of the Viper"] = true;
	AL["Set: Defias Leather"] = true;
	AL["Set: The Gladiator"] = true;
	AL["Set: Chain of the Scarlet Crusade"] = true;
	AL["Set: The Postmaster"] = true;
	AL["Set: Necropile Raiment"] = true;
	AL["Set: Cadaverous Garb"] = true;
	AL["Set: Bloodmail Regalia"] = true;
	AL["Set: Deathbone Guardian"] = true;
	AL["Set: Dal'Rend's Arms"] = true;
	AL["Set: Spider's Kiss"] = true;
	AL["AQ20 Class Sets"] = true;
	AL["AQ Enchants"] = true;
	AL["AQ40 Class Sets"] = true;
	AL["AQ Opening Quest Chain"] = true;
	AL["ZG Class Sets"] = true;
	AL["ZG Enchants"] = true;
	AL["Class Books"] = true;
	AL["Tribute Run"] = true;
	AL["Dire Maul Books"] = true;
	AL["Random Boss Loot"] = true;
	AL["BT Patterns/Plans"] = true;
	AL["Hyjal Summit Designs"] =true;
	AL["SP Patterns/Plans"] = true;
	AL["Ulduar Formula/Patterns/Plans"] = true;
	AL["Trial of the Crusader Patterns/Plans"] = true;
	AL["Legendary Items for Kael'thas Fight"] = true;

	-- Pets
	AL["Pets"] = true;
	AL["Promotional"] = true;
	AL["Pet Store"] = true;
	AL["Merchant Sold"] = true;
	AL["Rare"] = true;
	AL["Achievement"] = true;
	AL["Faction"] = true;
	AL["Dungeon/Raid"] = true;

	-- Mounts
	AL["Achievement Reward"] = true;
	AL["Alliance Flying Mounts"] = true;
	AL["Alliance Mounts"] = true;
	AL["Horde Flying Mounts"] = true;
	AL["Horde Mounts"] = true;
	AL["Card Game Mounts"] = true;
	AL["Crafted Mounts"] = true;
	AL["Event Mounts"] = true;
	AL["Neutral Faction Mounts"] = true;
	AL["PvP Mounts"] = true;
	AL["Alliance PvP Mounts"] = true;
	AL["Horde PvP Mounts"] = true;
	AL["Halaa PvP Mounts"] = true;
	AL["Promotional Mounts"] = true;
	AL["Rare Mounts"] = true;

	-- Darkmoon Faire
	AL["Darkmoon Faire Rewards"] = true;
	AL["Low Level Decks"] = true;
	AL["Original and BC Trinkets"] = true;
	AL["WotLK Trinkets"] = true;

	-- Card Game Decks and descriptions
	AL["Loot Card Items"] = true;
	AL["UDE Items"] = true;

	-- First set
	AL["Heroes of Azeroth"] = true;
	AL["Landro Longshot"] = true;
	AL["Thunderhead Hippogryph"] = true;
	AL["Saltwater Snapjaw"] = true;

	-- Second set
	AL["Through The Dark Portal"] = true;
	AL["King Mukla"] = true;
	AL["Rest and Relaxation"] = true;
	AL["Fortune Telling"] = true;

	-- Third set
	AL["Fires of Outland"] = true;
	AL["Spectral Tiger"] = true;
	AL["Gone Fishin'"] = true;
	AL["Goblin Gumbo"] = true;

	-- Fourth set
	AL["March of the Legion"] = true;
	AL["Kiting"] = true;
	AL["Robotic Homing Chicken"] = true;
	AL["Paper Airplane"] = true;

	-- Fifth set
	AL["Servants of the Betrayer"] = true;
	AL["X-51 Nether-Rocket"] = true;
	AL["Personal Weather Machine"] = true;
	AL["Papa Hummel's Old-fashioned Pet Biscuit"] = true;

	-- Sixth set
	AL["Hunt for Illidan"] = true;
	AL["The Footsteps of Illidan"] = true;
	AL["Disco Inferno!"] = true;
	AL["Ethereal Plunderer"] = true;

	-- Seventh set
	AL["Drums of War"] = true;
	AL["The Red Bearon"] = true;
	AL["Owned!"] = true;
	AL["Slashdance"] = true;

	-- Eighth set
	AL["Blood of Gladiators"] = true;
	AL["Sandbox Tiger"] = true;
	AL["Center of Attention"] = true;
	AL["Foam Sword Rack"] = true;

	-- Ninth set
	AL["Fields of Honor"] = true;
	AL["Path of Cenarius"] = true;
	AL["Pinata"] = true;
	AL["El Pollo Grande"] = true;

	-- Tenth set
	AL["Scourgewar"] = true;
	AL["Tiny"] = true;
	AL["Tuskarr Kite"] = true;
	AL["Spectral Kitten"] = true;

	-- Eleventh set
	AL["Wrathgate"] = true;
	AL["Statue Generator"] = true;
	AL["Landro's Gift"] = true;
	AL["Blazing Hippogryph"] = true;

	-- Twelvth set
	AL["Icecrown"] = true;
	AL["Wooly White Rhino"] = true;
	AL["Ethereal Portal"] = true;
	AL["Paint Bomb"] = true;

	-- Battleground Brackets
	AL["BG/Open PvP Rewards"] = true;
	AL["Misc. Rewards"] = true;
	AL["Level 20-39 Rewards"] = true;
	AL["Level 20-29 Rewards"] = true;
	AL["Level 30-39 Rewards"] = true;
	AL["Level 40-49 Rewards"] = true;
	AL["Level 60 Rewards"] = true;

	-- Brood of Nozdormu Paths
	AL["Path of the Conqueror"] = true;
	AL["Path of the Invoker"] = true;
	AL["Path of the Protector"] = true;

	-- Violet Eye Paths
	AL["Path of the Violet Protector"] = true;
	AL["Path of the Violet Mage"] = true;
	AL["Path of the Violet Assassin"] = true;
	AL["Path of the Violet Restorer"] = true;
	
	-- Ashen Verdict Paths
	AL["Path of Courage"] = true;
	AL["Path of Destruction"] = true;
	AL["Path of Vengeance"] = true;
	AL["Path of Wisdom"] = true;

	-- AQ Opening Event
	AL["Red Scepter Shard"] = true;
	AL["Blue Scepter Shard"] = true;
	AL["Green Scepter Shard"] = true;
	AL["Scepter of the Shifting Sands"] = true;

	-- World PvP
	AL["Hellfire Fortifications"] = true;
	AL["Twin Spire Ruins"] = true;
	AL["Spirit Towers"] = true;
	AL["Halaa"] = true;
	AL["Venture Bay"] = true;

	-- Karazhan Opera Event Headings
	AL["Shared Drops"] = true;
	AL["Romulo & Julianne"] = true;
	AL["Wizard of Oz"] = true;
	AL["Red Riding Hood"] = true;

	-- Karazhan Animal Boss Types
	AL["Spider"] = true;
	AL["Darkhound"] = true;
	AL["Bat"] = true;

	-- ZG Tokens
	AL["Primal Hakkari Kossack"] = true;
	AL["Primal Hakkari Shawl"] = true;
	AL["Primal Hakkari Bindings"] = true;
	AL["Primal Hakkari Sash"] = true;
	AL["Primal Hakkari Stanchion"] = true;
	AL["Primal Hakkari Aegis"] = true;
	AL["Primal Hakkari Girdle"] = true;
	AL["Primal Hakkari Armsplint"] = true;
	AL["Primal Hakkari Tabard"] = true;

	-- AQ20 Tokens
	AL["Qiraji Ornate Hilt"] = true;
	AL["Qiraji Martial Drape"] = true;
	AL["Qiraji Magisterial Ring"] = true;
	AL["Qiraji Ceremonial Ring"] = true;
	AL["Qiraji Regal Drape"] = true;
	AL["Qiraji Spiked Hilt"] = true;

	-- AQ40 Tokens
	AL["Qiraji Bindings of Dominance"] = true;
	AL["Qiraji Bindings of Command"] = true;
	AL["Vek'nilash's Circlet"] = true;
	AL["Vek'lor's Diadem"] = true;
	AL["Ouro's Intact Hide"] = true;
	AL["Skin of the Great Sandworm"] = true;
	AL["Husk of the Old God"] = true;
	AL["Carapace of the Old God"] = true;

	-- Blacksmithing Mail Crafted Sets
	AL["Bloodsoul Embrace"] = true;
	AL["Fel Iron Chain"] = true;

	-- Blacksmithing Plate Crafted Sets
	AL["Imperial Plate"] = true;
	AL["The Darksoul"] = true;
	AL["Fel Iron Plate"] = true;
	AL["Adamantite Battlegear"] = true;
	AL["Flame Guard"] = true;
	AL["Enchanted Adamantite Armor"] = true;
	AL["Khorium Ward"] = true;
	AL["Faith in Felsteel"] = true;
	AL["Burning Rage"] = true;
	AL["Ornate Saronite Battlegear"] = true;
	AL["Savage Saronite Battlegear"] = true;

	-- Leatherworking Crafted Leather Sets
	AL["Volcanic Armor"] = true;
	AL["Ironfeather Armor"] = true;
	AL["Stormshroud Armor"] = true;
	AL["Devilsaur Armor"] = true;
	AL["Blood Tiger Harness"] = true;
	AL["Primal Batskin"] = true;
	AL["Wild Draenish Armor"] = true;
	AL["Thick Draenic Armor"] = true;
	AL["Fel Skin"] = true;
	AL["Strength of the Clefthoof"] = true;
	AL["Primal Intent"] = true;
	AL["Windhawk Armor"] = true;
	AL["Borean Embrace"] = true;
	AL["Iceborne Embrace"] = true;
	AL["Eviscerator's Battlegear"] = true;
	AL["Overcaster Battlegear"] = true;

	-- Leatherworking Crafted Mail Sets
	AL["Green Dragon Mail"] = true;
	AL["Blue Dragon Mail"] = true;
	AL["Black Dragon Mail"] = true;
	AL["Scaled Draenic Armor"] = true;
	AL["Felscale Armor"] = true;
	AL["Felstalker Armor"] = true;
	AL["Fury of the Nether"] = true;
	AL["Netherscale Armor"] = true;
	AL["Netherstrike Armor"] = true;
	AL["Frostscale Binding"] = true;
	AL["Nerubian Hive"] = true;
	AL["Stormhide Battlegear"] = true;
	AL["Swiftarrow Battlefear"] = true;

	-- Tailoring Crafted Sets
	AL["Bloodvine Garb"] = true;
	AL["Netherweave Vestments"] = true;
	AL["Imbued Netherweave"] = true;
	AL["Arcanoweave Vestments"] = true;
	AL["The Unyielding"] = true;
	AL["Whitemend Wisdom"] = true;
	AL["Spellstrike Infusion"] = true;
	AL["Battlecast Garb"] = true;
	AL["Soulcloth Embrace"] = true;
	AL["Primal Mooncloth"] = true;
	AL["Shadow's Embrace"] = true;
	AL["Wrath of Spellfire"] = true;
	AL["Frostwoven Power"] = true;
	AL["Duskweaver"] = true;
	AL["Frostsavage Battlegear"] = true;

	-- Classic WoW Sets
	AL["Defias Leather"] = true;
	AL["Embrace of the Viper"] = true;
	AL["Chain of the Scarlet Crusade"] = true;
	AL["The Gladiator"] = true;
	AL["Ironweave Battlesuit"] = true;
	AL["Necropile Raiment"] = true;
	AL["Cadaverous Garb"] = true;
	AL["Bloodmail Regalia"] = true;
	AL["Deathbone Guardian"] = true;
	AL["The Postmaster"] = true;
	AL["Shard of the Gods"] = true;
	AL["Zul'Gurub Rings"] = true;
	AL["Major Mojo Infusion"] = true;
	AL["Overlord's Resolution"] = true;
	AL["Prayer of the Primal"] = true;
	AL["Zanzil's Concentration"] = true;
	AL["Spirit of Eskhandar"] = true;
	AL["The Twin Blades of Hakkari"] = true;
	AL["Primal Blessing"] = true;
	AL["Dal'Rend's Arms"] = true;
	AL["Spider's Kiss"] = true;

	-- The Burning Crusade Sets
	AL["Latro's Flurry"] = true;
	AL["The Twin Stars"] = true;
	AL["The Fists of Fury"] = true;
	AL["The Twin Blades of Azzinoth"] = true;

	-- Wrath of the Lich King Sets
	AL["Raine's Revenge"] = true;
	AL["Purified Shard of the Gods"] = true;
	AL["Shiny Shard of the Gods"] = true;

	-- Recipe origin strings
	AL["Trainer"] = true;
	AL["Discovery"] = true;
	AL["World Drop"] = true;
	AL["Drop"] = true;
	AL["Vendor"] = true;
	AL["Quest"] = true;
	AL["Crafted"] = true;

	-- Scourge Invasion
	AL["Scourge Invasion"] = true;
	AL["Scourge Invasion Sets"] = true;
	AL["Blessed Regalia of Undead Cleansing"] = true;
	AL["Undead Slayer's Blessed Armor"] = true;
	AL["Blessed Garb of the Undead Slayer"] = true;
	AL["Blessed Battlegear of Undead Slaying"] = true;
	AL["Prince Tenris Mirkblood"] = true;

	-- ZG Sets
	AL["Haruspex's Garb"] = true;
	AL["Predator's Armor"] = true;
	AL["Illusionist's Attire"] = true;
	AL["Freethinker's Armor"] = true;
	AL["Confessor's Raiment"] = true;
	AL["Madcap's Outfit"] = true;
	AL["Augur's Regalia"] = true;
	AL["Demoniac's Threads"] = true;
	AL["Vindicator's Battlegear"] = true;

	-- AQ20 Sets
	AL["Symbols of Unending Life"] = true;
	AL["Trappings of the Unseen Path"] = true;
	AL["Trappings of Vaulted Secrets"] = true;
	AL["Battlegear of Eternal Justice"] = true;
	AL["Finery of Infinite Wisdom"] = true;
	AL["Emblems of Veiled Shadows"] = true;
	AL["Gift of the Gathering Storm"] = true;
	AL["Implements of Unspoken Names"] = true;
	AL["Battlegear of Unyielding Strength"] = true;

	-- AQ40 Sets
	AL["Genesis Raiment"] = true;
	AL["Striker's Garb"] = true;
	AL["Enigma Vestments"] = true;
	AL["Avenger's Battlegear"] = true;
	AL["Garments of the Oracle"] = true;
	AL["Deathdealer's Embrace"] = true;
	AL["Stormcaller's Garb"] = true;
	AL["Doomcaller's Attire"] = true;
	AL["Conqueror's Battlegear"] = true;

	-- Dungeon 1 Sets
	AL["Wildheart Raiment"] = true;
	AL["Beaststalker Armor"] = true;
	AL["Magister's Regalia"] = true;
	AL["Lightforge Armor"] = true;
	AL["Vestments of the Devout"] = true;
	AL["Shadowcraft Armor"] = true;
	AL["The Elements"] = true;
	AL["Dreadmist Raiment"] = true;
	AL["Battlegear of Valor"] = true;

	-- Dungeon 2 Sets
	AL["Feralheart Raiment"] = true;
	AL["Beastmaster Armor"] = true;
	AL["Sorcerer's Regalia"] = true;
	AL["Soulforge Armor"] = true;
	AL["Vestments of the Virtuous"] = true;
	AL["Darkmantle Armor"] = true;
	AL["The Five Thunders"] = true;
	AL["Deathmist Raiment"] = true;
	AL["Battlegear of Heroism"] = true;

	-- Dungeon 3 Sets
	AL["Hallowed Raiment"] = true;
	AL["Incanter's Regalia"] = true;
	AL["Mana-Etched Regalia"] = true;
	AL["Oblivion Raiment"] = true;
	AL["Assassination Armor"] = true;
	AL["Moonglade Raiment"] = true;
	AL["Wastewalker Armor"] = true;
	AL["Beast Lord Armor"] = true;
	AL["Desolation Battlegear"] = true;
	AL["Tidefury Raiment"] = true;
	AL["Bold Armor"] = true;
	AL["Doomplate Battlegear"] = true;
	AL["Righteous Armor"] = true;

	-- Tier 1 Sets
	AL["Cenarion Raiment"] = true;
	AL["Giantstalker Armor"] = true;
	AL["Arcanist Regalia"] = true;
	AL["Lawbringer Armor"] = true;
	AL["Vestments of Prophecy"] = true;
	AL["Nightslayer Armor"] = true;
	AL["The Earthfury"] = true;
	AL["Felheart Raiment"] = true;
	AL["Battlegear of Might"] = true;

	-- Tier 2 Sets
	AL["Stormrage Raiment"] = true;
	AL["Dragonstalker Armor"] = true;
	AL["Netherwind Regalia"] = true;
	AL["Judgement Armor"] = true;
	AL["Vestments of Transcendence"] = true;
	AL["Bloodfang Armor"] = true;
	AL["The Ten Storms"] = true;
	AL["Nemesis Raiment"] = true;
	AL["Battlegear of Wrath"] = true;

	-- Tier 3 Sets
	AL["Dreamwalker Raiment"] = true;
	AL["Cryptstalker Armor"] = true;
	AL["Frostfire Regalia"] = true;
	AL["Redemption Armor"] = true;
	AL["Vestments of Faith"] = true;
	AL["Bonescythe Armor"] = true;
	AL["The Earthshatterer"] = true;
	AL["Plagueheart Raiment"] = true;
	AL["Dreadnaught's Battlegear"] = true;

	-- Tier 4 Sets
	AL["Malorne Harness"] = true;
	AL["Malorne Raiment"] = true;
	AL["Malorne Regalia"] = true;
	AL["Demon Stalker Armor"] = true;
	AL["Aldor Regalia"] = true;
	AL["Justicar Armor"] = true;
	AL["Justicar Battlegear"] = true;
	AL["Justicar Raiment"] = true;
	AL["Incarnate Raiment"] = true;
	AL["Incarnate Regalia"] = true;
	AL["Netherblade Set"] = true;
	AL["Cyclone Harness"] = true;
	AL["Cyclone Raiment"] = true;
	AL["Cyclone Regalia"] = true;
	AL["Voidheart Raiment"] = true;
	AL["Warbringer Armor"] = true;
	AL["Warbringer Battlegear"] = true;

	-- Tier 5 Sets
	AL["Nordrassil Harness"] = true;
	AL["Nordrassil Raiment"] = true;
	AL["Nordrassil Regalia"] = true;
	AL["Rift Stalker Armor"] = true;
	AL["Tirisfal Regalia"] = true;
	AL["Crystalforge Armor"] = true;
	AL["Crystalforge Battlegear"] = true;
	AL["Crystalforge Raiment"] = true;
	AL["Avatar Raiment"] = true;
	AL["Avatar Regalia"] = true;
	AL["Deathmantle Set"] = true;
	AL["Cataclysm Harness"] = true;
	AL["Cataclysm Raiment"] = true;
	AL["Cataclysm Regalia"] = true;
	AL["Corruptor Raiment"] = true;
	AL["Destroyer Armor"] = true;
	AL["Destroyer Battlegear"] = true;

	-- Tier 6 Sets
	AL["Thunderheart Harness"] = true;
	AL["Thunderheart Raiment"] = true;
	AL["Thunderheart Regalia"] = true;
	AL["Gronnstalker's Armor"] = true;
	AL["Tempest Regalia"] = true;
	AL["Lightbringer Armor"] = true;
	AL["Lightbringer Battlegear"] = true;
	AL["Lightbringer Raiment"] = true;
	AL["Vestments of Absolution"] = true;
	AL["Absolution Regalia"] = true;
	AL["Slayer's Armor"] = true;
	AL["Skyshatter Harness"] = true;
	AL["Skyshatter Raiment"] = true;
	AL["Skyshatter Regalia"] = true;
	AL["Malefic Raiment"] = true;
	AL["Onslaught Armor"] = true;
	AL["Onslaught Battlegear"] = true;

	-- Tier 7 Sets
	AL["Scourgeborne Battlegear"] = true;
	AL["Scourgeborne Plate"] = true;
	AL["Dreamwalker Garb"] = true;
	AL["Dreamwalker Battlegear"] = true;
	AL["Dreamwalker Regalia"] = true;
	AL["Cryptstalker Battlegear"] = true;
	AL["Frostfire Garb"] = true;
	AL["Redemption Regalia"] = true;
	AL["Redemption Battlegear"] = true;
	AL["Redemption Plate"] = true;
	AL["Regalia of Faith"] = true;
	AL["Garb of Faith"] = true;
	AL["Bonescythe Battlegear"] = true;
	AL["Earthshatter Garb"] = true;
	AL["Earthshatter Battlegear"] = true;
	AL["Earthshatter Regalia"] = true;
	AL["Plagueheart Garb"] = true;
	AL["Dreadnaught Battlegear"] = true;
	AL["Dreadnaught Plate"] = true;

	-- Tier 8 Sets
	AL["Darkruned Battlegear"] = true;
	AL["Darkruned Plate"] = true;
	AL["Nightsong Garb"] = true;
	AL["Nightsong Battlegear"] = true;
	AL["Nightsong Regalia"] = true;
	AL["Scourgestalker Battlegear"] = true;
	AL["Kirin Tor Garb"] = true;
	AL["Aegis Regalia"] = true;
	AL["Aegis Battlegear"] = true;
	AL["Aegis Plate"] = true;
	AL["Sanctification Regalia"] = true;
	AL["Sanctification Garb"] = true;
	AL["Terrorblade Battlegear"] = true;
	AL["Worldbreaker Garb"] = true;
	AL["Worldbreaker Battlegear"] = true;
	AL["Worldbreaker Regalia"] = true;
	AL["Deathbringer Garb"] = true;
	AL["Siegebreaker Battlegear"] = true;
	AL["Siegebreaker Plate"] = true;

	-- Tier 9 Sets
	AL["Malfurion's Garb"] = true;
	AL["Malfurion's Battlegear"] = true;
	AL["Malfurion's Regalia"] = true;
	AL["Runetotem's Garb"] = true;
	AL["Runetotem's Battlegear"] = true;
	AL["Runetotem's Regalia"] = true;
	AL["Windrunner's Battlegear"] = true;
	AL["Windrunner's Pursuit"] = true;
	AL["Khadgar's Regalia"] = true;
	AL["Sunstrider's Regalia"] = true;
	AL["Turalyon's Garb"] = true;
	AL["Turalyon's Battlegear"] = true;
	AL["Turalyon's Plate"] = true;
	AL["Liadrin's Garb"] = true;
	AL["Liadrin's Battlegear"] = true;
	AL["Liadrin's Plate"] = true;
	AL["Velen's Regalia"] = true;
	AL["Velen's Raiment"] = true;
	AL["Zabra's Regalia"] = true;
	AL["Zabra's Raiment"] = true;
	AL["VanCleef's Battlegear"] = true;
	AL["Garona's Battlegear"] = true;
	AL["Nobundo's Garb"] = true;
	AL["Nobundo's Battlegear"] = true;
	AL["Nobundo's Regalia"] = true;
	AL["Thrall's Garb"] = true;
	AL["Thrall's Battlegear"] = true;
	AL["Thrall's Regalia"] = true;
	AL["Kel'Thuzad's Regalia"] = true;
	AL["Gul'dan's Regalia"] = true;
	AL["Wrynn's Battlegear"] = true;
	AL["Wrynn's Plate"] = true;
	AL["Hellscream's Battlegear"] = true;
	AL["Hellscream's Plate"] = true;
	AL["Thassarian's Battlegear"] = true;
	AL["Koltira's Battlegear"] = true;
	AL["Thassarian's Plate"] = true;
	AL["Koltira's Plate"] = true;

	-- Tier 10 Sets
	AL["Lasherweave's Garb"] = true;
	AL["Lasherweave's Battlegear"] = true;
	AL["Lasherweave's Regalia"] = true;
	AL["Ahn'Kahar Blood Hunter's Battlegear"] = true;
	AL["Bloodmage's Regalia"] = true;
	AL["Lightsworn Garb"] = true;
	AL["Lightsworn Plate"] = true;
	AL["Lightsworn Battlegear"] = true;
	AL["Crimson Acolyte's Regalia"] = true;
	AL["Crimson Acolyte's Raiment"] = true;
	AL["Shadowblade's Battlegear"] = true;
	AL["Frost Witch's Garb"] = true;
	AL["Frost Witch's Battlegear"] = true;
	AL["Frost Witch's Regalia"] = true;
	AL["Dark Coven's Garb"] = true;
	AL["Ymirjar Lord's Battlegear"] = true;
	AL["Ymirjar Lord's Plate"] = true;
	AL["Scourgelord's Battlegear"] = true;
	AL["Scourgelord's Plate"] = true;

	-- Arathi Basin Sets - Alliance
	AL["The Highlander's Intent"] = true;
	AL["The Highlander's Purpose"] = true;
	AL["The Highlander's Will"] = true;
	AL["The Highlander's Determination"] = true;
	AL["The Highlander's Fortitude"] = true;
	AL["The Highlander's Resolution"] = true;
	AL["The Highlander's Resolve"] = true;

	-- Arathi Basin Sets - Horde
	AL["The Defiler's Intent"] = true;
	AL["The Defiler's Purpose"] = true;
	AL["The Defiler's Will"] = true;
	AL["The Defiler's Determination"] = true;
	AL["The Defiler's Fortitude"] = true;
	AL["The Defiler's Resolution"] = true;

	-- PvP Level 60 Rare Sets - Alliance
	AL["Lieutenant Commander's Refuge"] = true;
	AL["Lieutenant Commander's Pursuance"] = true;
	AL["Lieutenant Commander's Arcanum"] = true;
	AL["Lieutenant Commander's Redoubt"] = true;
	AL["Lieutenant Commander's Investiture"] = true;
	AL["Lieutenant Commander's Guard"] = true;
	AL["Lieutenant Commander's Stormcaller"] = true;
	AL["Lieutenant Commander's Dreadgear"] = true;
	AL["Lieutenant Commander's Battlearmor"] = true;

	-- PvP Level 60 Rare Sets - Horde
	AL["Champion's Refuge"] = true;
	AL["Champion's Pursuance"] = true;
	AL["Champion's Arcanum"] = true;
	AL["Champion's Redoubt"] = true;
	AL["Champion's Investiture"] = true;
	AL["Champion's Guard"] = true;
	AL["Champion's Stormcaller"] = true;
	AL["Champion's Dreadgear"] = true;
	AL["Champion's Battlearmor"] = true;

	-- PvP Level 60 Epic Sets - Alliance
	AL["Field Marshal's Sanctuary"] = true;
	AL["Field Marshal's Pursuit"] = true;
	AL["Field Marshal's Regalia"] = true;
	AL["Field Marshal's Aegis"] = true;
	AL["Field Marshal's Raiment"] = true;
	AL["Field Marshal's Vestments"] = true;
	AL["Field Marshal's Earthshaker"] = true;
	AL["Field Marshal's Threads"] = true;
	AL["Field Marshal's Battlegear"] = true;

	-- PvP Level 60 Epic Sets - Horde
	AL["Warlord's Sanctuary"] = true;
	AL["Warlord's Pursuit"] = true;
	AL["Warlord's Regalia"] = true;
	AL["Warlord's Aegis"] = true;
	AL["Warlord's Raiment"] = true;
	AL["Warlord's Vestments"] = true;
	AL["Warlord's Earthshaker"] = true;
	AL["Warlord's Threads"] = true;
	AL["Warlord's Battlegear"] = true;

	-- Outland Faction Reputation PvP Sets
	AL["Dragonhide Battlegear"] = true;
	AL["Wyrmhide Battlegear"] = true;
	AL["Kodohide Battlegear"] = true;
	AL["Stalker's Chain Battlegear"] = true;
	AL["Evoker's Silk Battlegear"] = true;
	AL["Crusader's Scaled Battledgear"] = true;
	AL["Crusader's Ornamented Battledgear"] = true;
	AL["Satin Battlegear"] = true;
	AL["Mooncloth Battlegear"] = true;
	AL["Opportunist's Battlegear"] = true;
	AL["Seer's Linked Battlegear"] = true;
	AL["Seer's Mail Battlegear"] = true;
	AL["Seer's Ringmail Battlegear"] = true;
	AL["Dreadweave Battlegear"] = true;
	AL["Savage's Plate Battlegear"] = true;

	-- Arena Epic Sets
	AL["Gladiator's Sanctuary"] = true;
	AL["Gladiator's Wildhide"] = true;
	AL["Gladiator's Refuge"] = true;
	AL["Gladiator's Pursuit"] = true;
	AL["Gladiator's Regalia"] = true;
	AL["Gladiator's Aegis"] = true;
	AL["Gladiator's Vindication"] = true;
	AL["Gladiator's Redemption"] = true;
	AL["Gladiator's Raiment"] = true;
	AL["Gladiator's Investiture"] = true;
	AL["Gladiator's Vestments"] = true;
	AL["Gladiator's Earthshaker"] = true;
	AL["Gladiator's Thunderfist"] = true;
	AL["Gladiator's Wartide"] = true;
	AL["Gladiator's Dreadgear"] = true;
	AL["Gladiator's Felshroud"] = true;
	AL["Gladiator's Battlegear"] = true;
	AL["Gladiator's Desecration"] = true;

	-- Level 80 PvP Weapons
	AL["Savage Gladiator\'s Weapons"] = true; --unused
	AL["Deadly Gladiator\'s Weapons"] = true; --unused
	AL["Furious Gladiator\'s Weapons"] = true;
	AL["Relentless Gladiator\'s Weapons"] = true;
	AL["Wrathful Gladiator\'s Weapons"] = true;

	-- Months
	AL["January"] = true;
	AL["February"] = true;
	AL["March"] = true;
	AL["April"] = true;
	AL["May"] = true;
	AL["June"] = true;
	AL["July"] = true;
	AL["August"] = true;
	AL["September"] = true;
	AL["October"] = true;
	AL["November"] = true;
	AL["December"] = true;

	-- Specs
	AL["Balance"] = true;
	AL["Feral"] = true;
	AL["Restoration"] = true;
	AL["Holy"] = true;
	AL["Protection"] = true;
	AL["Retribution"] = true;
	AL["Shadow"] = true;
	AL["Elemental"] = true;
	AL["Enhancement"] = true;
	AL["Fury"] = true;
	AL["Demonology"] = true;
	AL["Destruction"] = true;
	AL["Tanking"] = true;
	AL["DPS"] = true;

	-- Naxx Zones
	AL["Construct Quarter"] = true;
	AL["Arachnid Quarter"] = true;
	AL["Military Quarter"] = true;
	AL["Plague Quarter"] = true;
	AL["Frostwyrm Lair"] = true;

	-- NPCs missing from BabbleBoss
	AL["Trash Mobs"] = true;
	AL["Dungeon Set 2 Summonable"] = true;
	AL["Highlord Kruul"] = true;
	AL["Theldren"] = true;
	AL["Sothos and Jarien"] = true;
	AL["Druid of the Fang"] = true;
	AL["Defias Strip Miner"] = true;
	AL["Defias Overseer/Taskmaster"] = true;
	AL["Scarlet Defender/Myrmidon"] = true;
	AL["Scarlet Champion"] = true;
	AL["Scarlet Centurion"] = true;
	AL["Scarlet Trainee"] = true;
	AL["Herod/Mograine"] = true;
	AL["Scarlet Protector/Guardsman"] = true;
	AL["Shadowforge Flame Keeper"] = true;
	AL["Olaf"] = true;
	AL["Eric 'The Swift'"] = true;
	AL["Shadow of Doom"] = true;
	AL["Bone Witch"] = true;
	AL["Lumbering Horror"] = true;
	AL["Avatar of the Martyred"] = true;
	AL["Yor"] = true;
	AL["Nexus Stalker"] = true;
	AL["Auchenai Monk"] = true;
	AL["Cabal Fanatic"] = true;
	AL["Unchained Doombringer"] = true;
	AL["Crimson Sorcerer"] = true;
	AL["Thuzadin Shadowcaster"] = true;
	AL["Crimson Inquisitor"] = true;
	AL["Crimson Battle Mage"] = true;
	AL["Ghoul Ravener"] = true;
	AL["Spectral Citizen"] = true;
	AL["Spectral Researcher"] = true;
	AL["Scholomance Adept"] = true;
	AL["Scholomance Dark Summoner"] = true;
	AL["Blackhand Elite"] = true;
	AL["Blackhand Assassin"] = true;
	AL["Firebrand Pyromancer"] = true;
	AL["Firebrand Invoker"] = true;
	AL["Firebrand Grunt"] = true;
	AL["Firebrand Legionnaire"] = true;
	AL["Spirestone Warlord"] = true;
	AL["Spirestone Mystic"] = true;
	AL["Anvilrage Captain"] = true;
	AL["Anvilrage Marshal"] = true;
	AL["Doomforge Arcanasmith"] = true;
	AL["Weapon Technician"] = true;
	AL["Doomforge Craftsman"] = true;
	AL["Murk Worm"] = true;
	AL["Atal'ai Witch Doctor"] = true;
	AL["Raging Skeleton"] = true;
	AL["Ethereal Priest"] = true;
	AL["Sethekk Ravenguard"] = true;
	AL["Time-Lost Shadowmage"] = true;
	AL["Coilfang Sorceress"] = true;
	AL["Coilfang Oracle"] = true;
	AL["Shattered Hand Centurion"] = true;
	AL["Eredar Deathbringer"] = true;
	AL["Arcatraz Sentinel"] = true;
	AL["Gargantuan Abyssal"] = true;
	AL["Sunseeker Botanist"] = true;
	AL["Sunseeker Astromage"] = true;
	AL["Durnholde Rifleman"] = true;
	AL["Rift Keeper/Rift Lord"] = true;
	AL["Crimson Templar"] = true;
	AL["Azure Templar"] = true;
	AL["Hoary Templar"] = true;
	AL["Earthen Templar"] = true;
	AL["The Duke of Cynders"] = true;
	AL["The Duke of Fathoms"] = true;
	AL["The Duke of Zephyrs"] = true;
	AL["The Duke of Shards"] = true;
	AL["Aether-tech Assistant"] = true;
	AL["Aether-tech Adept"] = true;
	AL["Aether-tech Master"] = true;
	AL["Trelopades"] = true;
	AL["King Dorfbruiser"] = true;
	AL["Gorgolon the All-seeing"] = true;
	AL["Matron Li-sahar"] = true;
	AL["Solus the Eternal"] = true;
	AL["Balzaphon"] = true;
	AL["Lord Blackwood"] = true;
	AL["Revanchion"] = true;
	AL["Scorn"] = true;
	AL["Sever"] = true;
	AL["Lady Falther'ess"] = true;
	AL["Smokywood Pastures Vendor"] = true;
	AL["Shartuul"] = true;
	AL["Darkscreecher Akkarai"] = true;
	AL["Karrog"] = true;
	AL["Gezzarak the Huntress"] = true;
	AL["Vakkiz the Windrager"] = true;
	AL["Terokk"] = true;
	AL["Armbreaker Huffaz"] = true;
	AL["Fel Tinkerer Zortan"] = true;
	AL["Forgosh"] = true;
	AL["Gul'bor"] = true;
	AL["Malevus the Mad"] = true;
	AL["Porfus the Gem Gorger"] = true;
	AL["Wrathbringer Laz-tarash"] = true;
	AL["Bash'ir Landing Stasis Chambers"] = true;
	AL["Templars"] = true;
	AL["Dukes"] = true;
	AL["High Council"] = true;
	AL["Headless Horseman"] = true; --Is in BabbleBoss
	AL["Barleybrew Brewery"] = true;
	AL["Thunderbrew Brewery"] = true;
	AL["Gordok Brewery"] = true;
	AL["Drohn's Distillery"] = true;
	AL["T'chali's Voodoo Brewery"] = true;
	AL["Scarshield Quartermaster"] = true;
	AL["Overmaster Pyron"] = true; --Is in BabbleBoss
	AL["Father Flame"] = true;
	AL["Thomas Yance"] = true;
	AL["Knot Thimblejack"] = true;
	AL["Shen'dralar Provisioner"] = true;
	AL["Namdo Bizzfizzle"] = true;
	AL["The Nameles Prophet"] = true;
	AL["Zelemar the Wrathful"] = true;
	AL["Henry Stern"] = true; --Is in BabbleBoss
	AL["Aggem Thorncurse"] = true;
	AL["Roogug"] = true;
	AL["Rajaxx's Captains"] = true;
	AL["Razorfen Spearhide"] = true;
	AL["Rethilgore"] = true;
	AL["Kalldan Felmoon"] = true;
	AL["Magregan Deepshadow"] = true;
	AL["Lord Ahune"] = true;
	AL["Coren Direbrew"] = true; --Is in BabbleBoss
	AL["Don Carlos"] = true;
	AL["Thomas Yance"] = true;
	AL["Aged Dalaran Wizard"] = true;
	AL["Cache of the Legion"] = true;
	AL["Rajaxx's Captains"] = true;
	AL["Felsteed"] = true;
	AL["Shattered Hand Executioner"] = true;
	AL["Commander Stoutbeard"] = true; -- Is in BabbleBoss
	AL["Bjarngrim"] = true; -- Is in BabbleBoss
	AL["Loken"] = true; -- Is in BabbleBoss
	AL["Time-Lost Proto Drake"] = true;
	AL["Faction Champions"] = true; -- if you have a better name, use it.
	AL["Razzashi Raptor"] = true;
	AL["Deviate Ravager/Deviate Guardian"] = true;
	AL["Krick and Ick"]  = true;

	-- Zones
	AL["World Drop"] = true;
	AL["Sunwell Isle"] = true;

	-- Shortcuts for Bossname files
	AL["LBRS"] = true;
	AL["UBRS"] = true;
	AL["CoT1"] = true;
	AL["CoT2"] = true;
	AL["Scholo"] = true;
	AL["Strat"] = true;
	AL["Serpentshrine"] = true;
	AL["Avatar"] = true; -- Avatar of the Martyred

	-- Chests, etc
	AL["Dark Coffer"] = true;
	AL["The Secret Safe"] = true;
	AL["The Vault"] = true;
	AL["Ogre Tannin Basket"] = true;
	AL["Fengus's Chest"] = true;
	AL["The Prince's Chest"] = true;
	AL["Doan's Strongbox"] = true;
	AL["Frostwhisper's Embalming Fluid"] = true;
	AL["Unforged Rune Covered Breastplate"] = true;
	AL["Malor's Strongbox"] = true;
	AL["Unfinished Painting"] = true;
	AL["Felvine Shard"] = true;
	AL["Baelog's Chest"] = true;
	AL["Lorgalis Manuscript"] = true;
	AL["Fathom Core"] = true;
	AL["Conspicuous Urn"] = true;
	AL["Gift of Adoration"] = true;
	AL["Box of Chocolates"] = true;
	AL["Treat Bag"] = true;
	AL["Gaily Wrapped Present"] = true;
	AL["Festive Gift"] = true;
	AL["Ticking Present"] = true;
	AL["Gently Shaken Gift"] = true;
	AL["Carefully Wrapped Present"] = true;
	AL["Winter Veil Gift"] = true;
	AL["Smokywood Pastures Extra-Special Gift"] = true;
	AL["Brightly Colored Egg"] = true;
	AL["Lunar Festival Fireworks Pack"] = true;
	AL["Lucky Red Envelope"] = true;
	AL["Small Rocket Recipes"] = true;
	AL["Large Rocket Recipes"] = true;
	AL["Cluster Rocket Recipes"] = true;
	AL["Large Cluster Rocket Recipes"] = true;
	AL["Timed Reward Chest"] = true;
	AL["Timed Reward Chest 1"] = true;
	AL["Timed Reward Chest 2"] = true;
	AL["Timed Reward Chest 3"] = true;
	AL["Timed Reward Chest 4"] = true;
	AL["The Talon King's Coffer"] = true;
	AL["Krom Stoutarm's Chest"] = true;
	AL["Garrett Family Chest"] = true;
	AL["Reinforced Fel Iron Chest"] = true;
	AL["DM North Tribute Chest"] = true;
	AL["The Saga of Terokk"] = true;
	AL["First Fragment Guardian"] = true;
	AL["Second Fragment Guardian"] = true;
	AL["Third Fragment Guardian"] = true;
	AL["Overcharged Manacell"] = true;
	AL["Mysterious Egg"] = true;
	AL["Hyldnir Spoils"] = true;
	AL["Ripe Disgusting Jar"] = true;
	AL["Cracked Egg"] = true;
	AL["Small Spice Bag"] = true;
	AL["Handful of Candy"] = true;
	AL["Lovely Dress Box"] = true;
	AL["Dinner Suit Box"] = true;
	AL["Bag of Heart Candies"] = true;

	-- The next 4 lines are the tooltip for the Server Query Button
	-- The translation doesn't have to be literal, just re-write the
	-- sentences as you would naturally and break them up into 4 roughly
	-- equal lines.
	AL["Queries the server for all items"] = true;
	AL["on this page. The items will be"] = true;
	AL["refreshed when you next mouse"] = true;
	AL["over them."] = true;
	AL["The Minimap Button is generated by the FuBar Plugin."] = true;
	AL["This is automatic, you do not need FuBar installed."] = true;

	-- Help Frame
	AL["Help"] = true;
	AL["AtlasLoot Help"] = true;
	AL["For further help, see our website and forums: "] = true;
	AL["How to open the standalone Loot Browser:"] = true;
	AL["If you have AtlasLootFu enabled, click the minimap button, or alternatively a button generated by a mod like Titan or FuBar.  Finally, you can type '/al' in the chat window."] = true;
	AL["How to view an 'unsafe' item:"] = true;
	AL["Unsafe items have a red border around the icon and are marked because you have not seen the item since the last patch or server restart. Right-click the item, then move your mouse back over the item or click the 'Query Server' button at the bottom of the loot page."] = true;
	AL["How to view an item in the Dressing Room:"] = true;
	AL["Simply Ctrl+Left Click on the item.  Sometimes the dressing room window is hidden behind the Atlas or AtlasLoot windows, so if nothing seems to happen move your Atlas or AtlasLoot windows and see if anything is hidden."] = true;
	AL["How to link an item to someone else:"] = true;
	AL["Shift+Left Click the item like you would for any other in-game item"] = true;
	AL["How to add an item to the wishlist:"] = true;
	AL["Alt+Left Click any item to add it to the wishlist."] = true;
	AL["How to delete an item from the wishlist:"] = true;
	AL["While on the wishlist screen, just Alt+Left Click on an item to delete it."] = true;
	AL["What else does the wishlist do?"] = true;
	AL["If you Left Click any item on the wishlist, you can jump to the loot page the item comes from.  Also, on a loot page any item already in your wishlist is marked with a yellow star."] = true;
	AL["HELP!! I have broken the mod somehow!"] = true;
	AL["Use the reset buttons available in the options menu, or type '/al reset' in your chat window."] = true;

	-- Error Messages and warnings
	AL["AtlasLoot Error!"] = true;
	AL["WishList Full!"] = true;
	AL[" added to the WishList."] = true;
	AL[" already in the WishList!"] = true;
	AL[" deleted from the WishList."] = true;
	AL["No match found for"] = true;
	AL[" is safe."] = true;
	AL["Server queried for "] = true;
	AL[".  Right click on any other item to refresh the loot page."] = true;

	-- Incomplete Table Registry error message
	AL[" not listed in loot table registry, please report this message to the AtlasLoot forums at http://www.atlasloot.net"] = true;

	-- LoD Module disabled or missing
	AL[" is unavailable, the following load on demand module is required: "] = true;

	-- LoD Module load sequence could not be completed
	AL["Status of the following module could not be determined: "] = true;

	-- LoD Module required has loaded, but loot table is missing
	AL[" could not be accessed, the following module may be out of date: "] = true;

	-- LoD module not defined
	AL["Loot module returned as nil!"] = true;

	-- LoD module loaded successfully
	AL["sucessfully loaded."] = true;

	-- Need a big dataset for searching
	AL["Loading available tables for searching"] = true;

	-- All Available modules loaded
	AL["All Available Modules Loaded"] = true;

	-- First time user
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."] = true;
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences for tooltips and links in the chat window.\n\n  This options screen can be reached again at any later time by typing '/atlasloot'."] = true;
	AL["Setup"] = true;

	-- Old Atlas Detected
	AL["It has been detected that your version of Atlas does not match the version that Atlasloot is tuned for ("] = true;
	AL[").  Depending on changes, there may be the occasional error, so please visit http://www.atlasmod.com as soon as possible to update."] = true;
	AL["OK"] = true;
	AL["Incompatible Atlas Detected"] = true;

	-- Unsafe item tooltip
	AL["Unsafe Item"] = true;
	AL["Item Unavailable"] = true;
	AL["ItemID:"] = true;
	AL["This item is not available on your server or your battlegroup yet."] = true;
	AL["This item is unsafe.  To view this item without the risk of disconnection, you need to have first seen it in the game world. This is a restriction enforced by Blizzard since Patch 1.10."] = true;
	AL["You can right-click to attempt to query the server.  You may be disconnected."] = true;
end