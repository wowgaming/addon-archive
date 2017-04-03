local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local BabbleBoss = AtlasLoot_GetLocaleLibBabble("LibBabble-Boss-3.0")
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")
local BabbleFaction = AtlasLoot_GetLocaleLibBabble("LibBabble-Faction-3.0")
local BabbleZone = AtlasLoot_GetLocaleLibBabble("LibBabble-Zone-3.0")


-- Index
--- Dungeons & Raids
---- Keys
---- Utgarde Keep
---- The Nexus
---- Azjol-Nerub
---- Ahn'kahet: The Old Kingdom
---- Drak'Tharon Keep
---- The Violet Hold
---- Gundrak
---- Halls of Stone
---- Halls of Lightning
---- Caverns of Time: Old Stratholme
---- Utgarde Pinnacle
---- The Oculus
---- Vault of Archavon
---- Naxxramas
----- Construct Quarter
----- Arachnid Quarter
----- Military Quarter
----- Plague Quarter
----- Frostwyrm Lair
---- Obsidian Sanctum
---- The Eye of Eternity
---- Ulduar
---- Trial of the Champion
---- Trial of the Crusader
---- Trial of the Grand Crusader
---- Onyxia (Level 80)
---- The Forge of Souls
---- Pit of Saron
---- Halls of Reflection
---- Icecrown Citadel
----- Lower Spire
----- The Plagueworks
----- The Crimson Hall
----- Frostwing Halls
----- The Frozen Throne
---- Icecrown Citadel HEROIC
---- Ruby Sanctum
--- Factions
---- Alliance Vanguard
---- Argent Crusade
---- Frenzyheart Tribe
---- Horde Expedition
---- Kirin Tor
---- Knights of the Ebon Blade
---- The Kalu'ak
---- The Oracles
---- The Sons of Hodir
---- Winterfin Retreat
---- The Wyrmrest Accord
---- The Ashen Verdict
--- PvP
---- Armor Sets
---- Level 80 Epic Non-Sets
---- Wrathful Gladiator Weapons
---- PvP Class Items
---- PvP Miscellaneous
---- World PvP - Wintergrasp
---- World PvP - Grizzly Hills: Venture Bay
--- Sets & Collections
---- Naxx Sets (T7)/Ulduar Sets (T8)
---- Tier 9 Sets (T9)
---- Tier 10 Sets (T10)
---- Wrath Of The Lich King Sets
---- Blizzard Collectables
---- Legendaries
---- Tabards
---- Card Game Items
---- Vanity Pets
---- Mounts
---- BoE World Epics
---- Heirloom Items
---- Emblem of Heroism Items
---- Emblem of Valor Items
---- Emblem of Conquest Items
---- Emblem of Triumph Items
---- Emblem of Frost Items

	------------------------
	--- Dungeons & Raids ---
	------------------------

		------------
		--- Keys ---
		------------

	AtlasLoot_Data["WrathKeys"] = {
		{ 1, 44582, "", "=q4=Key to the Focusing Iris", "=ds=#e9#"};
		{ 2, 44581, "", "=q4=Heroic Key to the Focusing Iris", "=ds=#e9#"};
		{ 3, 45796, "", "=q1=Celestial Planetarium Key", "=ds=#e9#"};
		{ 4, 45798, "", "=q1=Heroic Celestial Planetarium Key", "=ds=#e9#"};
		{ 5, 42482, "", "=q1=The Violet Hold Key", "=ds=#e9#"};
	};

		--------------------
		--- Utgarde Keep ---
		--------------------

	AtlasLoot_Data["UtgardeKeepKeleseth"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35572, "", "=q3=Reinforced Velvet Helm", "=ds=#s1#, #a1#", "", "28%"};
		{ 3, 35571, "", "=q3=Dragon Stabler's Gauntlets", "=ds=#s9#, #a3#", "", "31%"};
		{ 4, 35570, "", "=q3=Keleseth's Blade of Evocation", "=ds=#h3#, #w4#", "", "28%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37180, "", "=q3=Battlemap Hide Helm", "=ds=#s1#, #a2#", "", "21%"};
		{ 19, 37178, "", "=q3=Strategist's Belt", "=ds=#s10#, #a4#", "", "22%"};
		{ 20, 37179, "", "=q3=Infantry Assault Blade", "=ds=#h1#, #w10#", "", "21%"};
		{ 21, 37177, "", "=q3=Wand of the San'layn", "=ds=#w12#", "", "21%"};
		Next = "UtgardeKeepSkarvald";
	};

	AtlasLoot_Data["UtgardeKeepSkarvald"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35575, "", "=q3=Skarvald's Dragonskin Habergeon", "=ds=#s5#, #a2#", "", "31%"};
		{ 3, 35574, "", "=q3=Chestplate of the Northern Lights", "=ds=#s5#, #a4#", "", "28%"};
		{ 4, 35573, "", "=q3=Arm Blade of Augelmir", "=ds=#h3#, #w13#", "", "30%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37183, "", "=q3=Bindings of the Tunneler", "=ds=#s8#, #a2#", "", "21%"};
		{ 19, 37184, "", "=q3=Dalronn's Jerkin", "=ds=#s5#, #a3#", "", "21%"};
		{ 20, 37182, "", "=q3=Helmet of the Constructor", "=ds=#s1#, #a4#", "", "21%"};
		{ 21, 37181, "", "=q3=Dagger of Betrayal", "=ds=#h1#, #w4#", "", "21%"};
		Prev = "UtgardeKeepKeleseth";
		Next = "UtgardeKeepIngvar";
	};

	AtlasLoot_Data["UtgardeKeepIngvar"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35577, "", "=q3=Holistic Patchwork Breeches", "=ds=#s11#, #a2#", "", "28%"};
		{ 3, 35578, "", "=q3=Overlaid Chain Spaulders", "=ds=#s3#, #a3#", "", "26%"};
		{ 4, 35576, "", "=q3=Ingvar's Monolithic Cleaver", "=ds=#h2#, #w1#", "", "27%"};
		{ 5, 33330, "", "=q1=Ingvar's Head", "=ds=#m3#"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37194, "", "=q4=Sharp-Barbed Leather Belt", "=ds=#s10#, #a2#", "", "20%"};
		{ 19, 37193, "", "=q4=Staggering Legplates", "=ds=#s11#, #a4#", "", "18%"};
		{ 20, 37192, "", "=q4=Annhylde's Ring", "=ds=#s13#", "", "18%"};
		{ 21, 37191, "", "=q4=Drake-Mounted Crossbow", "=ds=#w3#", "", "19%"};
		{ 22, 37189, "", "=q3=Breeches of the Caller", "=ds=#s11#, #a1#", "", "19%"};
		{ 23, 37188, "", "=q3=Plunderer's Helmet", "=ds=#s1#, #a3#", "", "20%"};
		{ 24, 37186, "", "=q3=Unsmashable Heavy Band", "=ds=#s13#", "", "20%"};
		{ 25, 37190, "", "=q3=Enraged Feral Staff", "=ds=#w9#", "", "20%"};
		{ 26, 41793, "", "=q3=Design: Fierce Monarch Topaz", "=ds=#p12# (390)", "", "8%"};
		{ 27, 43102, "", "=q3=Frozen Orb", "=ds=#e6#", "", "100%"};
		Prev = "UtgardeKeepSkarvald";
		Next = "UtgardeKeepTrash";
	};

	AtlasLoot_Data["UtgardeKeepTrash"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35580, "", "=q3=Skein Woven Mantle", "=ds=#s3#, #a1#", "", "1%"};
		{ 3, 35579, "", "=q3=Vrykul Shackles", "=ds=#s8#, #a2#", "", "2%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 37197, "", "=q3=Tattered Castle Drape", "=ds=#s4#", "", "1%"};
		{ 18, 37196, "", "=q3=Runecaster's Mantle", "=ds=#s3#, #a1#", "", "1%"};
		Prev = "UtgardeKeepSkarvald";
	};

		-----------------
		--- The Nexus ---
		-----------------

	AtlasLoot_Data["TheNexusOrmorok"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35602, "", "=q3=Chiseled Stalagmite Pauldrons", "=ds=#s3#, #a4#", "", "30%"};
		{ 3, 35603, "", "=q3=Greaves of the Blue Flight", "=ds=#s12#, #a4#", "", "32%"};
		{ 4, 35601, "", "=q3=Drakonid Arm Blade", "=ds=#h4#, #w13#", "", "33%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37153, "", "=q3=Gloves of the Crystal Gardener", "=ds=#s9#, #a1#", "", "21%"};
		{ 19, 37155, "", "=q3=Frozen Forest Kilt", "=ds=#s11#, #a3#", "", "22%"};
		{ 20, 37152, "", "=q3=Girdle of Ice", "=ds=#s10#, #a4#", "", "22%"};
		{ 21, 37151, "", "=q3=Band of Frosted Thorns", "=ds=#s13#", "", "22%"};
		Next = "TheNexusAnomalus";
	};

	AtlasLoot_Data["TheNexusAnomalus"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35599, "", "=q3=Gauntlets of Serpent Scales", "=ds=#s9#, #a3#", "", "31%"};
		{ 3, 35600, "", "=q3=Cleated Ice Boots", "=ds=#s12#, #a3#", "", "29%" };
		{ 4, 35598, "", "=q3=Tome of the Lore Keepers", "=ds=#s15#", "", "29%" };
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37149, "", "=q3=Helm of Anomalus", "=ds=#s1#, #a2#", "", "21%"};
		{ 19, 37144, "", "=q3=Hauberk of the Arcane Wraith", "=ds=#s5#, #a3#", "", "22%"};
		{ 20, 37150, "", "=q3=Rift Striders", "=ds=#s12#, #a4#", "", "22%"};
		{ 21, 37141, "", "=q3=Amulet of Dazzling Light", "=ds=#s2#", "", "21%"};
		Prev = "TheNexusOrmorok";
		Next = "TheNexusTelestra";
	};

	AtlasLoot_Data["TheNexusTelestra"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35605, "", "=q3=Belt of Draconic Runes", "=ds=#s10#, #a2#", "", "29%" };
		{ 3, 35604, "", "=q3=Insulating Bindings", "=ds=#s8#, #a4#", "", "29%" };
		{ 4, 35617, "", "=q3=Wand of Shimmering Scales", "=ds=#w12#", "", "28%" };
		{ 6, 21524, "", "=q2=Red Winter Hat", "=ds=#s1#, #a1# =q2=#m28#"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37139, "", "=q3=Spaulders of the Careless Thief", "=ds=#s3#, #a2#", "", "21%"};
		{ 19, 37138, "", "=q3=Bands of Channeled Energy", "=ds=#s8#, #a3#", "", "21%" };
		{ 20, 37135, "", "=q3=Arcane-Shielded Helm", "=ds=#s1#, #a4#", "", "21%" };
		{ 21, 37134, "", "=q3=Telestra's Journal", "=ds=#s15#", "", "20%" };
		{ 23, 21524, "", "=q2=Red Winter Hat", "=ds=#s1#, #a1# =q2=#m28#"};
		Prev = "TheNexusAnomalus";
		Next = "TheNexusKolurgStoutbeardHEROIC";
	};

	AtlasLoot_Data["TheNexusKolurgStoutbeardHEROIC"] = {
		{ 1, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 2, 37728, "", "=q3=Cloak of the Enemy", "=ds=#s4#", "", "20%"};
		{ 3, 37731, "", "=q3=Opposed Stasis Leggings", "=ds=#s11#, #a1#", "", "20%"};
		{ 4, 37730, "", "=q3=Cleric's Linen Shoes", "=ds=#s12#, #a1#", "", "19%"};
		{ 5, 37729, "", "=q3=Grips of Sculptured Icicles", "=ds=#s9#, #a4#", "", "20%"};
		Prev = "TheNexusTelestra";
		Next = "TheNexusKeristrasza";
	};

	AtlasLoot_Data["TheNexusKeristrasza"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35596, "", "=q3=Attuned Crystalline Boots", "=ds=#s12#, #a1#", "", "29%"};
		{ 3, 35595, "", "=q3=Glacier Sharpened Vileblade", "=ds=#h1#, #w4#", "", "30%"};
		{ 4, 35597, "", "=q3=Band of Glittering Permafrost", "=ds=#s13#", "", "30%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37172, "", "=q4=Gloves of Glistening Runes", "=ds=#s9#, #a1#", "", "19%"};
		{ 19, 37170, "", "=q4=Interwoven Scale Bracers", "=ds=#s8#, #a3#", "", "20%"};
		{ 20, 37171, "", "=q4=Flame-Bathed Steel Girdle", "=ds=#s10#, #a4#", "", "19%"};
		{ 21, 37169, "", "=q4=War Mace of Unrequited Love", "=ds=#h3#, #w6#", "", "18%"};
		{ 22, 37165, "", "=q3=Crystal-Infused Tunic", "=ds=#s5#, #a2#", "", "20%"};
		{ 23, 37167, "", "=q3=Dragon Slayer's Sabatons", "=ds=#s12#, #a3#", "", "20%"};
		{ 24, 37166, "", "=q3=Sphere of Red Dragon's Blood", "=ds=#s14#", "", "20%"};
		{ 25, 37162, "", "=q3=Bulwark of the Noble Protector", "=ds=#w8#", "", "20%"};
		{ 26, 41794, "", "=q3=Design: Deadly Monarch Topaz", "=ds=#p12# (390)", "", "9%"};
		{ 27, 43102, "", "=q3=Frozen Orb", "=ds=#e6#", "", "100%"};
		Prev = "TheNexusKolurgStoutbeardHEROIC";
	};

		-------------------
		--- Azjol-Nerub ---
		-------------------

	AtlasLoot_Data["AzjolNerubKrikthir"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35657, "", "=q3=Exquisite Spider-Silk Footwraps", "=ds=#s12#, #a1#", "", "30%"};
		{ 3, 35656, "", "=q3=Aura Focused Gauntlets", "=ds=#s9#, #a4#", "", "32%"};
		{ 4, 35655, "", "=q3=Cobweb Machete", "=ds=#h1#, #w4#", "", "30%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37218, "", "=q3=Stone-Worn Footwraps", "=ds=#s12#, #a1#", "", "21%"};
		{ 19, 37219, "", "=q3=Custodian's Chestpiece", "=ds=#s5#, #a2#", "", "21%"};
		{ 20, 37217, "", "=q3=Golden Limb Bands", "=ds=#s8#, #a4#", "", "22%"};
		{ 21, 37216, "", "=q3=Facade Shield of Glyphs", "=ds=#w8#", "", "22%"};
		Next = "AzjolNerubHadronox";
	};

	AtlasLoot_Data["AzjolNerubHadronox"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35660, "", "=q3=Spinneret Epaulets", "=ds=#s3#, #a2#", "", "30%"};
		{ 3, 35659, "", "=q3=Treads of Aspiring Heights", "=ds=#s12#, #a2#", "", "30%"};
		{ 4, 35658, "", "=q3=Life-Staff of the Web Lair", "=ds=#w9#", "", "29%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37222, "", "=q3=Egg Sac Robes", "=ds=#s5#, #a1#", "", "21%"};
		{ 19, 37230, "", "=q3=Grotto Mist Gloves", "=ds=#s9#, #a2#", "", "21%"};
		{ 20, 37221, "", "=q3=Hollowed Mandible Legplates", "=ds=#s11#, #a3#", "", "20%"};
		{ 21, 37220, "", "=q3=Essence of Gossamer", "=ds=#s14#", "", "20%"};
		Prev = "AzjolNerubKrikthir";
		Next = "AzjolNerubAnubarak";
	};

	AtlasLoot_Data["AzjolNerubAnubarak"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35663, "", "=q3=Charmed Silken Cord", "=ds=#s10#, #a1#", "", "29%"};
		{ 3, 35662, "", "=q3=Wing Cover Girdle", "=ds=#s10#, #a3#", "", "29%"};
		{ 4, 35661, "", "=q3=Signet of Arachnathid Command", "=ds=#s13#", "", "28%"};
		{ 6, 43411, "", "=q1=Anub'arak's Broken Husk", "=ds=#m3#"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37242, "", "=q4=Sash of the Servant", "=ds=#s10#, #a1#", "", "19%"};
		{ 19, 37240, "", "=q4=Flamebeard's Bracers", "=ds=#s8#, #a4#", "", "19%"};
		{ 20, 37241, "", "=q4=Ancient Aligned Girdle", "=ds=#s10#, #a4#", "", "19%"};
		{ 21, 37238, "", "=q4=Rod of the Fallen Monarch", "=ds=#w12#", "", "19%"};
		{ 22, 37236, "", "=q3=Insect Vestments", "=ds=#s5#, #a2#", "", "20%"};
		{ 23, 37237, "", "=q3=Chitin Shell Greathelm", "=ds=#s1#, #a4#", "", "20%"};
		{ 24, 37232, "", "=q3=Ring of the Traitor King", "=ds=#s13#", "", "19%"};
		{ 25, 37235, "", "=q3=Crypt Lord's Deft Blade", "=ds=#h1#, #w10#", "", "21%"};
		{ 26, 41796, "", "=q3=Design: Infused Twilight Opal", "=ds=#p12# (390)", "", "12%"};
		{ 27, 43102, "", "=q3=Frozen Orb", "=ds=#e6#", "", "100%"};
		Prev = "AzjolNerubHadronox";
		Next = "AzjolNerubTrash";
	};

	AtlasLoot_Data["AzjolNerubTrash"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 2, 37243, "", "=q3=Treasure Seeker's Belt", "=ds=#s10#, #a2#", "", "1%"};
		{ 3, 37625, "", "=q3=Web Winder Gloves", "=ds=#s9#, #a4#", "", "1%"};
		{ 4, 37624, "", "=q3=Stained-Glass Shard Ring", "=ds=#s13#", "", "1%"};
		Prev = "AzjolNerubAnubarak";
	};

		----------------------------------
		--- Ahn'kahet: The Old Kingdom ---
		----------------------------------

	AtlasLoot_Data["AhnkahetNadox"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35607, "", "=q3=Ahn'kahar Handwraps", "=ds=#s9#, #a2#", "", "30%"};
		{ 3, 35608, "", "=q3=Crawler-Emblem Belt", "=ds=#s10#, #a4#", "", "29%"};
		{ 4, 35606, "", "=q3=Blade of Nadox", "=ds=#h1#, #w4#", "", "31%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37594, "", "=q3=Elder Headpiece", "=ds=#s1#, #a1#", "", "22%"};
		{ 19, 37593, "", "=q3=Sprinting Shoulderpads", "=ds=#s3#, #a2#", "", "23%"};
		{ 20, 37592, "", "=q3=Brood Plague Helmet", "=ds=#s1#, #a3#", "", "22%"};
		{ 21, 37591, "", "=q3=Nerubian Shield Ring", "=ds=#s13#", "", "22%"};
		Next = "AhnkahetTaldaram";
	};

	AtlasLoot_Data["AhnkahetTaldaram"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35611, "", "=q3=Gloves of the Blood Prince", "=ds=#s9#, #a1#", "", "30%"};
		{ 3, 35610, "", "=q3=Slasher's Amulet", "=ds=#s2#", "", "31%"};
		{ 4, 35609, "", "=q3=Talisman of Scourge Command", "=ds=#s15#", "", "29%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37613, "", "=q3=Flame Sphere Bindings", "=ds=#s8#, #a1#", "", "21%"};
		{ 19, 37614, "", "=q3=Gauntlets of the Plundering Geist", "=ds=#s9#, #a3#", "", "21%"};
		{ 20, 37612, "", "=q3=Bonegrinder Breastplate", "=ds=#s5#, #a4#", "", "20%"};
		{ 21, 37595, "", "=q3=Necklace of Taldaram", "=ds=#s2#", "", "21%"};
		Prev = "AhnkahetNadox";
		Next = "AhnkahetAmanitarHEROIC";
	};

	AtlasLoot_Data["AhnkahetAmanitarHEROIC"] = {
		{ 1, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 2, 43287, "", "=q3=Silken Bridge Handwraps", "=ds=#s9#, #a1#", "", "21%"};
		{ 3, 43286, "", "=q3=Legguards of Swarming Attacks", "=ds=#s11#, #a2#", "", "23%"};
		{ 4, 43285, "", "=q3=Amulet of the Spell Flinger", "=ds=#s2#", "", "22%"};
		{ 5, 43284, "", "=q3=Amanitar Skullbow", "=ds=#w3#", "", "22%"};
		Prev = "AhnkahetTaldaram";
		Next = "AhnkahetJedoga";
	};

	AtlasLoot_Data["AhnkahetJedoga"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 43278, "", "=q3=Cloak of the Darkcaster", "=ds=#s4#", "", "30%"};
		{ 3, 43279, "", "=q3=Battlechest of the Twilight Cult", "=ds=#s5#, #a4#", "", "29%"};
		{ 4, 43277, "", "=q3=Jedoga's Greatring", "=ds=#s13#", "", "28%"};
		{ 6, 21524, "", "=q2=Red Winter Hat", "=ds=#s1#, #a1# =q2=#m28#"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 43283, "", "=q3=Subterranean Waterfall Shroud", "=ds=#s4#", "", "21%"};
		{ 19, 43280, "", "=q3=Faceguard of the Hammer Clan", "=ds=#s1#, #a4#", "", "21%"};
		{ 20, 43282, "", "=q3=Shadowseeker's Pendant", "=ds=#s2#", "", "22%"};
		{ 21, 43281, "", "=q3=Edge of Oblivion", "=ds=#h2#, #w1#", "", "22%"};
		{ 23, 21524, "", "=q2=Red Winter Hat", "=ds=#s1#, #a1# =q2=#m28#"};
		Prev = "AhnkahetAmanitarHEROIC";
		Next = "AhnkahetVolazj";
	};

	AtlasLoot_Data["AhnkahetVolazj"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35612, "", "=q3=Mantle of Echoing Bats", "=ds=#s3#, #a1#", "", "29%"};
		{ 3, 35613, "", "=q3=Pyramid Embossed Belt", "=ds=#s10#, #a2#", "", "31%"};
		{ 4, 35614, "", "=q3=Volazj's Sabatons", "=ds=#s12#, #a4#", "", "31%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37622, "", "=q4=Skirt of the Old Kingdom", "=ds=#s11#, #a1#", "", "19%"};
		{ 19, 37623, "", "=q4=Fiery Obelisk Handguards", "=ds=#s9#, #a3#", "", "19%"};
		{ 20, 37620, "", "=q4=Bracers of the Herald", "=ds=#s8#, #a4#", "", "18%"};
		{ 21, 37619, "", "=q4=Wand of Ahnkahet", "=ds=#w12#", "", "18%"};
		{ 22, 37616, "", "=q3=Kilt of the Forgotten One", "=ds=#s11#, #a2#", "", "19%"};
		{ 23, 37618, "", "=q3=Greaves of Ancient Evil", "=ds=#s12#, #a4#", "", "20%"};
		{ 24, 37617, "", "=q3=Staff of Sinister Claws", "=ds=#w9#", "", "19%"};
		{ 25, 37615, "", "=q3=Titanium Compound Bow", "=ds=#w2#", "", "19%"};
		{ 26, 41790, "", "=q3=Design: Precise Scarlet Ruby", "=ds=#p12# (390)", "", "17%"};
		{ 27, 43102, "", "=q3=Frozen Orb", "=ds=#e6#", "", "100%"};
		Prev = "AhnkahetJedoga";
		Next = "AhnkahetTrash";
	};

	AtlasLoot_Data["AhnkahetTrash"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35616, "", "=q3=Spored Tendrils Spaulders", "=ds=#s3#, #a3#", "", "1%"};
		{ 3, 35615, "", "=q3=Glowworm Cavern Bindings", "=ds=#s8#, #a3#", "", "1%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 37625, "", "=q3=Web Winder Gloves", "=ds=#s9#, #a4#", "", "1%"};
		{ 18, 37624, "", "=q3=Stained-Glass Shard Ring", "=ds=#s13#", "", "1%"};
		Prev = "AhnkahetVolazj";
	};

		------------------------
		--- Drak'Tharon Keep ---
		------------------------

	AtlasLoot_Data["DrakTharonKeepTrollgore"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35620, "", "=q3=Berserker's Horns", "=ds=#s1#, #a2#", "", "33%"};
		{ 3, 35619, "", "=q3=Infection Resistant Legguards", "=ds=#s11#, #a3#", "", "28%"};
		{ 4, 35618, "", "=q3=Troll Butcherer", "=ds=#h2#, #w10#", "", "30%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37715, "", "=q3=Cowl of the Dire Troll", "=ds=#s1#, #a1#", "", "21%"};
		{ 19, 37714, "", "=q3=Batrider's Cord", "=ds=#s10#, #a2#", "", "22%"};
		{ 20, 37717, "", "=q3=Legs of Physical Regeneration", "=ds=#s11#, #a4#", "", "22%"};
		{ 21, 37712, "", "=q3=Terrace Defence Boots", "=ds=#s12#, #a4#", "", "22%"};
		Next = "DrakTharonKeepNovos";
	};

	AtlasLoot_Data["DrakTharonKeepNovos"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35632, "", "=q3=Robes of Novos", "=ds=#s5#, #a1#", "", "32%"};
		{ 3, 35631, "", "=q3=Crystal Pendant of Warding", "=ds=#s2#", "", "28%"};
		{ 4, 35630, "", "=q3=Summoner's Stone Gavel", "=ds=#h1#, #w6#", "", "30%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37722, "", "=q3=Breastplate of Undeath", "=ds=#s5#, #a4#", "", "22%"};
		{ 19, 37718, "", "=q3=Temple Crystal Fragment", "=ds=#s15#", "", "21%"};
		{ 20, 37721, "", "=q3=Cursed Lich Blade", "=ds=#h3#, #w10#", "", "22%"};
		Prev = "DrakTharonKeepTrollgore";
		Next = "DrakTharonKeepKingDred";
	};

	AtlasLoot_Data["DrakTharonKeepKingDred"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35635, "", "=q3=Stable Master's Breeches", "=ds=#s11#, #a1#", "", "28%"};
		{ 3, 35634, "", "=q3=Scabrous-Hide Helm", "=ds=#s1#, #a2#", "", "28%"};
		{ 4, 35633, "", "=q3=Staff of the Great Reptile", "=ds=#w9#", "", "31%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37725, "", "=q3=Savage Wound Wrap", "=ds=#s8#, #a1#", "", "21%"};
		{ 19, 37724, "", "=q3=Handler's Arm Strap", "=ds=#s8#, #a2#", "", "21%"};
		{ 20, 37726, "", "=q3=King Dred's Helm", "=ds=#s1#, #a3#", "", "21%"};
		{ 21, 37723, "", "=q3=Incisor Fragment", "=ds=#s14#", "", "21%"};
		Prev = "DrakTharonKeepNovos";
		Next = "DrakTharonKeepTharonja";
	};

	AtlasLoot_Data["DrakTharonKeepTharonja"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35638, "", "=q3=Helmet of Living Flesh", "=ds=#s1#, #a3#", "", "33%"};
		{ 3, 35637, "", "=q3=Muradin's Lost Greaves", "=ds=#s11#, #a4#", "", "28%"};
		{ 4, 35636, "", "=q3=Tharon'ja's Aegis", "=ds=#w8#", "", "30%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37798, "", "=q4=Overlook Handguards", "=ds=#s9#, #a1#", "", "19%"};
		{ 19, 37791, "", "=q4=Leggings of the Winged Serpent", "=ds=#s11#, #a2#", "", "20%"};
		{ 20, 37788, "", "=q4=Limb Regeneration Bracers", "=ds=#s8#, #a3#", "", "21%"};
		{ 21, 37784, "", "=q4=Keystone Great-Ring", "=ds=#s13#", "", "19%"};
		{ 22, 37735, "", "=q3=Ziggurat Imprinted Chestguard", "=ds=#s5#, #a4#", "", "21%"};
		{ 23, 37732, "", "=q3=Spectral Seal of the Prophet", "=ds=#s13#", "", "20%"};
		{ 24, 37734, "", "=q3=Talisman of Troll Divinity", "=ds=#s14#", "", "21%"};
		{ 25, 37733, "", "=q3=Mojo Masked Crusher", "=ds=#h2#, #w6#", "", "21%"};
		{ 26, 41795, "", "=q3=Design: Timeless Forest Emerald", "=ds=#p12# (390)", "", "14%"};
		{ 27, 43102, "", "=q3=Frozen Orb", "=ds=#e6#", "", "100%"};
		Prev = "DrakTharonKeepKingDred";
		Next = "DrakTharonKeepTrash";
	};

	AtlasLoot_Data["DrakTharonKeepTrash"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35641, "", "=q3=Scytheclaw Boots", "=ds=#s12#, #a2#", "", "1%"};
		{ 3, 35640, "", "=q3=Darkweb Bindings", "=ds=#s8#, #a3#", "", "1%"};
		{ 4, 35639, "", "=q3=Brighthelm of Guarding", "=ds=#s1#, #a4#", "", "1%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 37799, "", "=q3=Reanimator's Cloak", "=ds=#s4#", "", "1%"};
		{ 18, 37800, "", "=q3=Aviary Guardsman's Hauberk", "=ds=#s5#, #a3#", "", "1%"};
		{ 19, 37801, "", "=q3=Waistguard of the Risen Knight", "=ds=#s10#, #a4#", "", "1%"};
		Prev = "DrakTharonKeepTharonja";
	};

		-----------------------
		--- The Violet Hold ---
		-----------------------

	AtlasLoot_Data["VioletHoldErekem"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 43363, "", "=q3=Screeching Cape", "=ds=#s4#", "", "43%"};
		{ 3, 43375, "", "=q3=Trousers of the Arakkoa", "=ds=#s11#, #a1#", "", "45%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 43406, "", "=q3=Cloak of the Gushing Wound", "=ds=#s4#", "", "29%"};
		{ 19, 43405, "", "=q3=Sabatons of Erekem", "=ds=#s12#, #a4#", "", "29%"};
		{ 20, 43407, "", "=q3=Stormstrike Mace", "=ds=#h1#, #w6#", "", "30%"};
		Next = "VioletHoldZuramat";
	};

	AtlasLoot_Data["VioletHoldZuramat"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 43353, "", "=q3=Void Sentry Legplates", "=ds=#s11#, #a4#", "", "44%"};
		{ 3, 43358, "", "=q3=Pendant of Shadow Beams", "=ds=#s2#", "", "41%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 43403, "", "=q3=Shroud of Darkness", "=ds=#s1#, #a2#", "", "28%"};
		{ 19, 43402, "", "=q3=The Obliterator Greaves", "=ds=#s12#, #a4#", "", "28%"};
		{ 20, 43404, "", "=q3=Zuramat's Necklace", "=ds=#s2#", "", "28%"};
		Prev = "VioletHoldErekem";
		Next = "VioletHoldXevozz";
	};

	AtlasLoot_Data["VioletHoldXevozz"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35644, "", "=q3=Xevozz's Belt", "=ds=#s10#, #a3#", "", "43%"};
		{ 3, 35642, "", "=q3=Riot Shield", "=ds=#w8#", "", "42%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37867, "", "=q3=Footwraps of Teleportation", "=ds=#s12#, #a1#", "", "29%"};
		{ 19, 37868, "", "=q3=Girdle of the Ethereal", "=ds=#s10#, #a3#", "", "29%"};
		{ 20, 37861, "", "=q3=Necklace of Arcane Spheres", "=ds=#s2#", "", "29%"};
		Prev = "VioletHoldZuramat";
		Next = "VioletHoldIchoron";
	};

	AtlasLoot_Data["VioletHoldIchoron"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35647, "", "=q3=Handguards of Rapid Pursuit", "=ds=#s9#, #a2#", "", "44%"};
		{ 3, 35643, "", "=q3=Spaulders of Ichoron", "=ds=#s3#, #a4#", "", "40%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 43401, "", "=q3=Water-Drenched Robe", "=ds=#s5#, #a1#", "", "28%"};
		{ 19, 37862, "", "=q3=Gauntlets of the Water Revenant", "=ds=#s9#, #a4#", "", "28%"};
		{ 20, 37869, "", "=q3=Globule Signet", "=ds=#s13#", "", "28%"};
		Prev = "VioletHoldXevozz";
		Next = "VioletHoldMoragg";
	};

	AtlasLoot_Data["VioletHoldMoragg"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 43387, "", "=q3=Shoulderplates of the Beholder", "=ds=#s3#, #a4#", "", "43%"};
		{ 3, 43382, "", "=q3=Band of Eyes", "=ds=#s13#", "", "43%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 43410, "", "=q3=Moragg's Chestguard", "=ds=#s5#, #a3#", "", "29%"};
		{ 19, 43408, "", "=q3=Solitare of Reflecting Beams", "=ds=#s13#", "", "29%"};
		{ 20, 43409, "", "=q3=Saliva Corroded Pike", "=ds=#w7#", "", "30%"};
		Prev = "VioletHoldIchoron";
		Next = "VioletHoldLavanthor";
	};

	AtlasLoot_Data["VioletHoldLavanthor"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35646, "", "=q3=Lava Burn Gloves", "=ds=#s9#, #a1#", "", "44%"};
		{ 3, 35645, "", "=q3=Prison Warden's Shotgun", "=ds=#w5#", "", "45%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37870, "", "=q3=Twin-Headed Boots", "=ds=#s12#, #a3#", "", "30%"};
		{ 19, 37872, "", "=q3=Lavanthor's Talisman", "=ds=#s14#", "", "30%"};
		{ 20, 37871, "", "=q3=The Key", "=ds=#h1#, #w1#", "", "29%"};
		Prev = "VioletHoldMoragg";
		Next = "VioletHoldCyanigosa";
	};

	AtlasLoot_Data["VioletHoldCyanigosa"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35650, "", "=q3=Boots of the Portal Guardian", "=ds=#s12#, #a3#", "", "31%"};
		{ 3, 35651, "", "=q3=Plate Claws of the Dragon", "=ds=#s9#, #a4#", "", "31%"};
		{ 4, 35649, "", "=q3=Jailer's Baton", "=ds=#w9#", "", "31%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37884, "", "=q4=Azure Cloth Bindings", "=ds=#s8#, #a1#", "", "20%"};
		{ 19, 37886, "", "=q4=Handgrips of the Savage Emissary", "=ds=#s9#, #a3#", "", "21%"};
		{ 20, 43500, "", "=q4=Bolstered Legplates", "=ds=#s11#, #a4#", "", "20%"};
		{ 21, 37883, "", "=q4=Staff of Trickery", "=ds=#w9#", "", "21%"};
		{ 22, 37876, "", "=q3=Cyanigosa's Leggings", "=ds=#s11#, #a1#", "", "22%"};
		{ 23, 37875, "", "=q3=Spaulders of the Violet Hold", "=ds=#s3#, #a3#", "", "21%"};
		{ 24, 37874, "", "=q3=Gauntlets of Capture", "=ds=#s9#, #a4#", "", "21%"};
		{ 25, 37873, "", "=q3=Mark of the War Prisoner", "=ds=#s14#", "", "20%"};
		{ 26, 41791, "", "=q3=Design: Thick Autumn's Glow", "=ds=#p12# (390)", "", "9%"};
		{ 27, 43102, "", "=q3=Frozen Orb", "=ds=#e6#", "", "100%"};
		Prev = "VioletHoldLavanthor";
		Next = "VioletHoldTrash";
	};

	AtlasLoot_Data["VioletHoldTrash"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35654, "", "=q3=Bindings of the Bastille", "=ds=#s8#, #a1#", "", "1%"};
		{ 3, 35653, "", "=q3=Dungeon Girdle", "=ds=#s10#, #a4#", "", "1%"};
		{ 4, 35652, "", "=q3=Incessant Torch", "=ds=#w12#", "", "1%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 35654, "", "=q3=Bindings of the Bastille", "=ds=#s8#, #a1#", "", "1%"};
		{ 18, 37890, "", "=q3=Chain Gang Legguards", "=ds=#s11#, #a2#", "", "1%"};
		{ 19, 37891, "", "=q3=Cast Iron Shackles", "=ds=#s8#, #a4#", "", "1%"};
		{ 20, 35653, "", "=q3=Dungeon Girdle", "=ds=#s10#, #a4#", "", "1%"};
		{ 21, 37889, "", "=q3=Prison Manifest", "=ds=#s15#", "", "1%"};
		{ 22, 35652, "", "=q3=Incessant Torch", "=ds=#w12#", "", "1%"};
		Prev = "VioletHoldCyanigosa";
	};

		---------------
		--- Gundrak ---
		---------------

	AtlasLoot_Data["GundrakSladran"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35584, "", "=q3=Embroidered Gown of Zul'drak", "=ds=#s5#, #a1#", "", "28%"};
		{ 3, 35585, "", "=q3=Cannibal's Legguards", "=ds=#s11#, #a3#", "", "29%"};
		{ 4, 35583, "", "=q3=Witch Doctor's Wildstaff", "=ds=#w9#", "", "28%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37629, "", "=q3=Slithering Slippers", "=ds=#s12#, #a1#", "", "21%"};
		{ 19, 37628, "", "=q3=Slad'ran's Coiled Cord", "=ds=#s10#, #a3#", "", "20%"};
		{ 20, 37627, "", "=q3=Snake Den Spaulders", "=ds=#s3#, #a4#", "", "20%"};
		{ 21, 37626, "", "=q3=Wand of Sseratus", "=ds=#w12#", "", "20%"};
		Next = "GundrakColossus";
	};

	AtlasLoot_Data["GundrakColossus"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35591, "", "=q3=Shoulderguards of the Ice Troll", "=ds=#s3#, #a2#", "", "25%"};
		{ 3, 35592, "", "=q3=Hauberk of Totemic Mastery", "=ds=#s5#, #a3#", "", "26%"};
		{ 4, 35590, "", "=q3=Drakkari Hunting Bow", "=ds=#w2#", "", "26%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37637, "", "=q3=Living Mojo Belt", "=ds=#s10#, #a1#", "", "20%"};
		{ 19, 37636, "", "=q3=Helm of Cheated Fate", "=ds=#s1#, #a2#", "", "21%"};
		{ 20, 37634, "", "=q3=Bracers of the Divine Elemental", "=ds=#s8#, #a2#", "", "20%"};
		{ 21, 37635, "", "=q3=Pauldrons of the Colossus", "=ds=#s3#, #a4#", "", "20%"};
		Prev = "GundrakSladran";
		Next = "GundrakMoorabi";
	};

	AtlasLoot_Data["GundrakMoorabi"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35588, "", "=q3=Forlorn Breastplate of War", "=ds=#s5#, #a4#", "", "29%"};
		{ 3, 35589, "", "=q3=Arcane Focal Signet", "=ds=#s13#", "", "29%"};
		{ 4, 35587, "", "=q3=Frozen Scepter of Necromancy", "=ds=#h3#, #w6#", "", "30%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37630, "", "=q3=Shroud of Moorabi", "=ds=#s4#", "", "21%"};
		{ 19, 37633, "", "=q3=Ground Tremor Helm", "=ds=#s1#, #a4#", "", "22%"};
		{ 20, 37632, "", "=q3=Mojo Frenzy Greaves", "=ds=#s12#, #a4#", "", "22%"};
		{ 21, 37631, "", "=q3=Fist of the Deity", "=ds=#h3#, #w13#", "", "22%"};
		Prev = "GundrakColossus";
		Next = "GundrakEckHEROIC";
	};

	AtlasLoot_Data["GundrakEckHEROIC"] = {
		{ 1, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 2, 43313, "", "=q3=Leggings of the Ruins Dweller", "=ds=#s11#, #a1#", "", "23%"};
		{ 3, 43312, "", "=q3=Gorloc Muddy Footwraps", "=ds=#s12#, #a2#", "", "23%"};
		{ 4, 43311, "", "=q3=Helmet of the Shrine", "=ds=#s1#, #a3#", "", "22%"};
		{ 5, 43310, "", "=q3=Engraved Chestplate of Eck", "=ds=#s5#, #a4#", "", "23%"};
		Prev = "GundrakMoorabi";
		Next = "GundrakGaldarah";
	};

	AtlasLoot_Data["GundrakGaldarah"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 43305, "", "=q3=Shroud of Akali", "=ds=#s4#", "", "28%"};
		{ 3, 43309, "", "=q3=Amulet of the Stampede", "=ds=#s2#", "", "31%"};
		{ 4, 43306, "", "=q3=Gal'darah's Signet", "=ds=#s13#", "", "30%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37643, "", "=q4=Sash of Blood Removal", "=ds=#s10#, #a2#", "", "19%"};
		{ 19, 37644, "", "=q4=Gored Hide Legguards", "=ds=#s11#, #a2#", "", "19%"};
		{ 20, 37645, "", "=q4=Horn-Tipped Gauntlets", "=ds=#s9#, #a4#", "", "19%"};
		{ 21, 37642, "", "=q4=Hemorrhaging Circle", "=ds=#s13#", "", "18%"};
		{ 22, 37641, "", "=q3=Arcane Flame Altar-Garb", "=ds=#s5#, #a1#", "", "19%"};
		{ 23, 37640, "", "=q3=Boots of Transformation", "=ds=#s12#, #a2#", "", "20%"};
		{ 24, 37639, "", "=q3=Grips of the Beast God", "=ds=#s9#, #a3#", "", "20%"};
		{ 25, 37638, "", "=q3=Offering of Sacrifice", "=ds=#s14#", "", "20%"};
		{ 26, 43102, "", "=q3=Frozen Orb", "=ds=#e6#", "", "100%"};
		Prev = "GundrakEckHEROIC";
		Next = "GundrakTrash";
	};

	AtlasLoot_Data["GundrakTrash"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35594, "", "=q3=Snowmelt Silken Cinch", "=ds=#s10#, #a1#", "", "2%"};
		{ 3, 35593, "", "=q3=Steel Bear Trap Bracers", "=ds=#s8#, #a4#", "", "1%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 37647, "", "=q3=Cloak of Bloodied Waters", "=ds=#s4#", "", "1%"};
		{ 18, 37648, "", "=q3=Belt of Tasseled Lanterns", "=ds=#s10#, #a3#", "", "1%"};
		{ 19, 37646, "", "=q3=Burning Skull Pendant", "=ds=#s2#", "", "1%"};
		Prev = "GundrakGaldarah";
	}; 

		----------------------
		--- Halls of Stone ---
		----------------------

	AtlasLoot_Data["HallsofStoneMaiden"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 38614, "", "=q3=Embrace of Sorrow", "=ds=#s4#", "", "28%"};
		{ 3, 38613, "", "=q3=Chain of Fiery Orbs", "=ds=#s2#", "", "29%"};
		{ 4, 38611, "", "=q3=Ringlet of Repose", "=ds=#s13#", "", "29%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 38616, "", "=q3=Maiden's Girdle", "=ds=#s10#, #a2#", "", "21%"};
		{ 19, 38615, "", "=q3=Lightning-Charged Gloves", "=ds=#s9#, #a3#", "", "21%"};
		{ 20, 38617, "", "=q3=Woeful Band", "=ds=#s13#", "", "22%"};
		{ 21, 38618, "", "=q3=Hammer of Grief", "=ds=#h2#, #w6#", "", "22%"};
		Next = "HallsofStoneKrystallus";
	};

	AtlasLoot_Data["HallsofStoneKrystallus"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35673, "", "=q3=Leggings of Burning Gleam", "=ds=#s11#, #a1#", "", "29%"};
		{ 3, 35672, "", "=q3=Hollow Geode Helm", "=ds=#s1#, #a3#", "", "30%"};
		{ 4, 35670, "", "=q3=Brann's Lost Mining Helmet", "=ds=#s1#, #a4#", "", "26%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37652, "", "=q3=Spaulders of Krystallus", "=ds=#s3#, #a2#", "", "28%"};
		{ 19, 37650, "", "=q3=Shardling Legguards", "=ds=#s11#, #a4#", "", "27%"};
		{ 20, 37651, "", "=q3=The Prospector's Prize", "=ds=#s13#", "", "27%"};
		Prev = "HallsofStoneMaiden";
		Next = "HallsofStoneTribunal";
	};

	AtlasLoot_Data["HallsofStoneTribunal"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35677, "", "=q3=Cosmos Vestments", "=ds=#s5#, #a2#", "", "25%"};
		{ 3, 35676, "", "=q3=Constellation Leggings", "=ds=#s11#, #a2#", "", "26%"};
		{ 4, 35675, "", "=q3=Linked Armor of the Sphere", "=ds=#s5#, #a3#", "", "24%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37655, "", "=q3=Mantle of the Tribunal", "=ds=#s3#, #a1#", "", "16%"};
		{ 19, 37656, "", "=q3=Raging Construct Bands", "=ds=#s8#, #a3#", "", "16%"};
		{ 20, 37654, "", "=q3=Sabatons of the Ages", "=ds=#s12#, #a3#", "", "14%"};
		{ 21, 37653, "", "=q3=Sword of Justice", "=ds=#h2#, #w10#", "", "16%"};
		Prev = "HallsofStoneKrystallus";
		Next = "HallsofStoneSjonnir";
	};

	AtlasLoot_Data["HallsofStoneSjonnir"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35679, "", "=q3=Static Cowl", "=ds=#s1#, #a1#", "", "28%"};
		{ 3, 35678, "", "=q3=Ironshaper's Legplates", "=ds=#s11#, #a4#", "", "28%"};
		{ 4, 35680, "", "=q3=Amulet of Wills", "=ds=#s2#", "", "29%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37669, "", "=q4=Leggings of the Stone Halls", "=ds=#s11#, #a3#", "", "18%"};
		{ 19, 37668, "", "=q4=Bands of the Stoneforge", "=ds=#s8#, #a4#", "", "18%"};
		{ 20, 37670, "", "=q4=Sjonnir's Girdle", "=ds=#s10#, #a4#", "", "18%"};
		{ 21, 37667, "", "=q4=The Fleshshaper", "=ds=#h1#, #w4#", "", "18%"};
		{ 22, 37666, "", "=q3=Boots of the Whirling Mist", "=ds=#s12#, #a2#", "", "19%"};
		{ 23, 37658, "", "=q3=Sun-Emblazoned Chestplate", "=ds=#s5#, #a4#", "", "19%"};
		{ 24, 37657, "", "=q3=Spark of Life", "=ds=#s14#", "", "19%"};
		{ 25, 37660, "", "=q3=Forge Ember", "=ds=#s14#", "", "18%"};
		{ 26, 41792, "", "=q3=Design: Deft Monarch Topaz", "=ds=#p12# (390)", "", "15%"};
		{ 27, 43102, "", "=q3=Frozen Orb", "=ds=#e6#", "", "100%"};
		Prev = "HallsofStoneTribunal";
		Next = "HallsofStoneTrash";
	};

	AtlasLoot_Data["HallsofStoneTrash"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 35682, "", "=q3=Rune Giant Bindings", "=ds=#s8#, #a1#", "", "0.44%"};
		{ 3, 35683, "", "=q3=Palladium Ring", "=ds=#s13#", "", "0.46%"};
		{ 4, 35681, "", "=q3=Unrelenting Blade", "=ds=#h1#, #w4#", "", "0.41%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 37673, "", "=q3=Dark Runic Mantle", "=ds=#s3#, #a1#", "", "1%"};
		{ 18, 37672, "", "=q3=Patina-Coated Breastplate", "=ds=#s5#, #a4#", "", "1%"};
		{ 19, 37671, "", "=q3=Refined Ore Gloves", "=ds=#s9#, #a4#", "", "1%"};
		Prev = "HallsofStoneSjonnir";
	};

		--------------------------
		--- Halls of Lightning ---
		--------------------------

	AtlasLoot_Data["HallsofLightningBjarngrim"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 36982, "", "=q3=Mantle of Electrical Charges", "=ds=#s3#, #a1#", "", "22%"};
		{ 3, 36979, "", "=q3=Bjarngrim Family Signet", "=ds=#s13#", "", "22%"};
		{ 4, 36980, "", "=q3=Hewn Sparring Quarterstaff", "=ds=#w9#", "", "22%"};
		{ 5, 36981, "", "=q3=Hardened Vrykul Throwing Axe", "=ds=#w11#", "", "23%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37825, "", "=q3=Traditionally Dyed Handguards", "=ds=#s9#, #a1#", "", "21%"};
		{ 19, 37818, "", "=q3=Patroller's War-Kilt", "=ds=#s11#, #a3#", "", "21%"};
		{ 20, 37814, "", "=q3=Iron Dwarf Smith Pauldrons", "=ds=#s3#, #a4#", "", "21%"};
		{ 21, 37826, "", "=q3=The General's Steel Girdle", "=ds=#s10#, #a4#", "", "22%"};
		Next = "HallsofLightningVolkhan";
	};

	AtlasLoot_Data["HallsofLightningVolkhan"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 36983, "", "=q3=Cape of Seething Steam", "=ds=#s4#", "", "22%"};
		{ 3, 36985, "", "=q3=Volkhan's Hood", "=ds=#s1#, #a1#", "", "23%"};
		{ 4, 36986, "", "=q3=Kilt of Molten Golems", "=ds=#s11#, #a3#", "", "22%"};
		{ 5, 36984, "", "=q3=Eternally Folded Blade", "=ds=#h1#, #w10#", "", "22%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37840, "", "=q3=Shroud of Reverberation", "=ds=#s4#", "", "21%"};
		{ 19, 37843, "", "=q3=Giant-Hair Woven Gloves", "=ds=#s9#, #a1#", "", "21%"};
		{ 20, 37842, "", "=q3=Belt of Vivacity", "=ds=#s10#, #a2#", "", "21%"};
		{ 21, 37841, "", "=q3=Slag Footguards", "=ds=#s12#, #a2#", "", "21%"};
		Prev = "HallsofLightningBjarngrim";
		Next = "HallsofLightningIonar";
	};

	AtlasLoot_Data["HallsofLightningIonar"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 39536, "", "=q3=Thundercloud Grasps", "=ds=#s9#, #a1#", "", "22%"};
		{ 3, 39657, "", "=q3=Tornado Cuffs", "=ds=#s8#, #a3#", "", "21%"};
		{ 4, 39534, "", "=q3=Pauldrons of the Lightning Revenant", "=ds=#s3#, #a4#", "", "21%"};
		{ 5, 39535, "", "=q3=Ionar's Girdle", "=ds=#s10#, #a4#", "", "21%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37846, "", "=q3=Charged-Bolt Grips", "=ds=#s9#, #a2#", "", "20%"};
		{ 19, 37845, "", "=q3=Cord of Swirling Winds", "=ds=#s10#, #a3#", "", "21%"};
		{ 20, 37826, "", "=q3=The General's Steel Girdle", "=ds=#s10#, #a4#", "", "22%"};
		{ 21, 37844, "", "=q3=Winged Talisman", "=ds=#s14#", "", "21%"};
		Prev = "HallsofLightningVolkhan";
		Next = "HallsofLightningLoken";
	};

	AtlasLoot_Data["HallsofLightningLoken"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 36991, "", "=q3=Raiments of the Titans", "=ds=#s5#, #a1#", "", "22%"};
		{ 3, 36996, "", "=q3=Hood of the Furtive Assassin", "=ds=#s1#, #a2#", "", "22%"};
		{ 4, 36992, "", "=q3=Leather-Braced Chain Leggings", "=ds=#s11#, #a3#", "", "22%"};
		{ 5, 36995, "", "=q3=Fists of Loken", "=ds=#s9#, #a4#", "", "22%"};
		{ 6, 36988, "", "=q3=Chaotic Spiral Amulet", "=ds=#s2#", "", "22%"};
		{ 7, 36993, "", "=q3=Seal of the Pantheon", "=ds=#s14#", "", "18%"};
		{ 8, 36994, "", "=q3=Projectile Activator", "=ds=#w5#", "", "21%"};
		{ 9, 36989, "", "=q3=Ancient Measuring Rod", "=ds=#w12#", "", "21%"};
		{ 10, 41799, "", "=q3=Design: Eternal Earthsiege Diamond", "=ds=#p12# (420)", "", "11%"};
		{ 12, 43151, "", "=q1=Loken's Tongue", "=ds=#m3#"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37854, "", "=q4=Woven Bracae Leggings", "=ds=#s11#, #a1#", "", "18%"};
		{ 19, 37853, "", "=q4=Advanced Tooled-Leather Bands", "=ds=#s8#, #a2#", "", "18%"};
		{ 20, 37855, "", "=q4=Mail Girdle of the Audient Earth", "=ds=#s10#, #a3#", "", "19%"};
		{ 21, 37852, "", "=q4=Colossal Skull-Clad Cleaver", "=ds=#h2#, #w1#", "", "18%"};
		{ 22, 37851, "", "=q3=Ornate Woolen Stola", "=ds=#s5#, #a1#", "", "19%"};
		{ 23, 37850, "", "=q3=Flowing Sash of Order", "=ds=#s10#, #a1#", "", "19%"};
		{ 24, 37849, "", "=q3=Planetary Helm", "=ds=#s1#, #a4#", "", "19%"};
		{ 25, 37848, "", "=q3=Lightning Giant Staff", "=ds=#w9#", "", "18%"};
		{ 26, 41799, "", "=q3=Design: Eternal Earthsiege Diamond", "=ds=#p12# (420)", "", "11%"};
		{ 27, 43102, "", "=q3=Frozen Orb", "=ds=#e6#", "", "100%"};
		Prev = "HallsofLightningIonar";
		Next = "HallsofLightningTrash";
	};

	AtlasLoot_Data["HallsofLightningTrash"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 36997, "", "=q3=Sash of the Hardened Watcher", "=ds=#s10#, #a1#", "", "1%"};
		{ 3, 37000, "", "=q3=Storming Vortex Bracers", "=ds=#s8#, #a2#", "", "1%"};
		{ 4, 36999, "", "=q3=Boots of the Terrestrial Guardian", "=ds=#s12#, #a3#", "", "1%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 37858, "", "=q3=Awakened Handguards", "=ds=#s9#, #a2#", "", "1%"};
		{ 18, 37857, "", "=q3=Helm of the Lightning Halls", "=ds=#s1#, #a3#", "", "1%"};
		{ 19, 37856, "", "=q3=Librarian's Paper Cutter", "=ds=#h1#, #w4#", "", "1%"};
		Prev = "HallsofLightningLoken";
	};

		---------------------------------------
		--- Caverns of Time: Old Stratholme ---
		---------------------------------------

	AtlasLoot_Data["CoTStratholmeMeathook"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 37083, "", "=q3=Kilt of Sewn Flesh", "=ds=#s11#, #a2#", "", "23%"};
		{ 3, 37082, "", "=q3=Slaughterhouse Sabatons", "=ds=#s12#, #a4#", "", "22%"};
		{ 4, 37079, "", "=q3=Enchanted Wire Stitching", "=ds=#s13#", "", "23%"};
		{ 5, 37081, "", "=q3=Meathook's Slicer", "=ds=#h1#, #w10#", "", "22%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37680, "", "=q3=Belt of Unified Souls", "=ds=#s10#, #a1#", "", "22%"};
		{ 19, 37678, "", "=q3=Bile-Cured Gloves", "=ds=#s9#, #a2#", "", "22%"};
		{ 20, 37679, "", "=q3=Spaulders of the Abomination", "=ds=#s3#, #a3#", "", "21%"};
		{ 21, 37675, "", "=q3=Legplates of Steel Implants", "=ds=#s11#, #a4#", "", "23%"};
		Next = "CoTStratholmeSalramm";
	};

	AtlasLoot_Data["CoTStratholmeSalramm"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 37084, "", "=q3=Flowing Cloak of Command", "=ds=#s4#", "", "22%"};
		{ 3, 37095, "", "=q3=Waistband of the Thuzadin", "=ds=#s10#, #a3#", "", "23%"};
		{ 4, 37088, "", "=q3=Spiked Metal Cilice", "=ds=#s10#, #a4#", "", "22%"};
		{ 5, 37086, "", "=q3=Tome of Salramm", "=ds=#s15#", "", "23%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37684, "", "=q3=Forgotten Shadow Hood", "=ds=#s1#, #a1#", "", "22%"};
		{ 19, 37682, "", "=q3=Bindings of Dark Will", "=ds=#s8#, #a4#", "", "22%"};
		{ 20, 37683, "", "=q3=Necromancer's Amulet", "=ds=#s2#", "", "22%"};
		{ 21, 37681, "", "=q3=Gavel of the Fleshcrafter", "=ds=#h3#, #w6#", "", "22%"};
		Prev = "CoTStratholmeMeathook";
		Next = "CoTStratholmeEpoch";
	};

	AtlasLoot_Data["CoTStratholmeEpoch"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 37106, "", "=q3=Ouroboros Belt", "=ds=#s10#, #a2#", "", "23%"};
		{ 3, 37105, "", "=q3=Treads of Altered History", "=ds=#s12#, #a3#", "", "24%"};
		{ 4, 37096, "", "=q3=Necklace of the Chrono-Lord", "=ds=#s2#", "", "22%"};
		{ 5, 37099, "", "=q3=Sempiternal Staff", "=ds=#w9#", "", "22%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37687, "", "=q3=Gloves of Distorted Time", "=ds=#s9#, #a1#", "", "23%"};
		{ 19, 37686, "", "=q3=Cracked Epoch Grasps", "=ds=#s9#, #a3#", "", "23%"};
		{ 20, 37688, "", "=q3=Legplates of the Infinite Drakonid", "=ds=#s11#, #a4#", "", "23%"};
		{ 21, 37685, "", "=q3=Mobius Band", "=ds=#s13#", "", "23%"};
		Prev = "CoTStratholmeSalramm";
		Next = "CoTStratholmeInfiniteCorruptorHEROIC";
	};

	AtlasLoot_Data["CoTStratholmeInfiniteCorruptorHEROIC"] = {
		{ 1, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 2, 43951, "", "=q4=Reins of the Bronze Drake", "=ds=#e12#", "", "100%"};
		Prev = "CoTStratholmeEpoch";
		Next = "CoTStratholmeMalGanis";
	};

	AtlasLoot_Data["CoTStratholmeMalGanis"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 37113, "", "=q3=Demonic Fabric Bands", "=ds=#s8#, #a1#", "", "16%"};
		{ 3, 37114, "", "=q3=Gloves of Northern Lordaeron", "=ds=#s9#, #a2#", "", "19%"};
		{ 4, 37110, "", "=q3=Gauntlets of Dark Conversion", "=ds=#s9#, #a3#", "", "18%"};
		{ 5, 37109, "", "=q3=Discarded Silver Hand Spaulders", "=ds=#s3#, #a4#", "", "18%"};
		{ 6, 37111, "", "=q3=Soul Preserver", "=ds=#s14#", "", "14%"};
		{ 7, 37108, "", "=q3=Dreadlord's Blade", "=ds=#h2#, #w10#", "", "16%"};
		{ 8, 37112, "", "=q3=Beguiling Scepter", "=ds=#h3#, #w6#", "", "19%"};
		{ 9, 37107, "", "=q3=Leeka's Shield", "=ds=#w8#", "", "18%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37696, "", "=q4=Plague-Infected Bracers", "=ds=#s8#, #a2#", "", "11%"};
		{ 19, 37695, "", "=q4=Legguards of Nature's Power", "=ds=#s11#, #a3#", "", "11%"};
		{ 20, 37694, "", "=q4=Band of Guile", "=ds=#s13#", "", "11%"};
		{ 21, 37693, "", "=q4=Greed", "=ds=#h3#, #w13#", "", "11%"};
		{ 22, 43085, "", "=q4=Royal Crest of Lordaeron", "=ds=#w8#", "", "10%"};
		{ 23, 37691, "", "=q3=Mantle of Deceit", "=ds=#s3#, #a1#", "", "14%"};
		{ 24, 37690, "", "=q3=Pauldrons of Destiny", "=ds=#s3#, #a4#", "", "14%"};
		{ 25, 37689, "", "=q3=Pendant of the Nathrezim", "=ds=#s2#", "", "14%"};
		{ 26, 37692, "", "=q3=Pierce's Pistol", "=ds=#w5#", "", "14%"};
		{ 27, 43102, "", "=q3=Frozen Orb", "=ds=#e6#", "", "100%"};
		Prev = "CoTStratholmeInfiniteCorruptorHEROIC";
		Next = "CoTStratholmeTrash";
	};

	AtlasLoot_Data["CoTStratholmeTrash"] = {
		{ 1, 37117, "", "=q3=King's Square Bracers", "=ds=#s8#, #a2#", "", "1%"};
		{ 2, 37116, "", "=q3=Epaulets of Market Row", "=ds=#s3#, #a3#", "", "1%"};
		{ 3, 37115, "", "=q3=Crusader's Square Pauldrons", "=ds=#s3#, #a4#", "", "1%"};
		Prev = "CoTStratholmeMalGanis";		
	};

		------------------------
		--- Utgarde Pinnacle ---
		------------------------

	AtlasLoot_Data["UPSorrowgrave"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 37043, "", "=q3=Tear-Linked Gauntlets", "=ds=#s9#, #a3#", "", "24%"};
		{ 3, 37040, "", "=q3=Svala's Bloodied Shackles", "=ds=#s8#, #a4#", "", "23%"};
		{ 4, 37037, "", "=q3=Ritualistic Athame", "=ds=#h1#, #w4#", "", "22%"};
		{ 5, 37038, "", "=q3=Brazier Igniter", "=ds=#w12#", "", "21%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37370, "", "=q3=Cuffs of the Trussed Hall", "=ds=#s8#, #a1#", "", "21%"};
		{ 19, 37369, "", "=q3=Sorrowgrave's Breeches", "=ds=#s11#, #a1#", "", "22%"};
		{ 20, 37368, "", "=q3=Silent Spectator Shoulderpads", "=ds=#s3#, #a2#", "", "22%"};
		{ 21, 37367, "", "=q3=Echoing Stompers", "=ds=#s12#, #a4#", "", "22%"};
		Next = "UPPalehoof";
	};

	AtlasLoot_Data["UPPalehoof"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 37048, "", "=q3=Shroud of Resurrection", "=ds=#s4#", "", "24%"};
		{ 3, 37052, "", "=q3=Reanimated Armor", "=ds=#s5#, #a4#", "", "21%"};
		{ 4, 37051, "", "=q3=Seal of Valgarde", "=ds=#s15#", "", "21%"};
		{ 5, 37050, "", "=q3=Trophy Gatherer", "=ds=#w2#", "", "24%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37374, "", "=q3=Ravenous Leggings of the Furbolg", "=ds=#s11#, #a2#", "", "22%"};
		{ 19, 37373, "", "=q3=Massive Spaulders of the Jormungar", "=ds=#s3#, #a3#", "", "21%"};
		{ 20, 37376, "", "=q3=Ferocious Pauldrons of the Rhino", "=ds=#s3#, #a4#", "", "21%"};
		{ 21, 37371, "", "=q3=Ring of the Frenzied Wolvar", "=ds=#s13#", "", "22%"};
		Prev = "UPSorrowgrave";
		Next = "UPSkadi";
	};

	AtlasLoot_Data["UPSkadi"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 37055, "", "=q3=Silken Amice of the Ymirjar", "=ds=#s3#, #a1#", "", "23%"};
		{ 3, 37057, "", "=q3=Drake Rider's Tunic", "=ds=#s5#, #a2#", "", "23%"};
		{ 4, 37056, "", "=q3=Harpooner's Striders", "=ds=#s12#, #a4#", "", "22%"};
		{ 5, 37053, "", "=q3=Amulet of Deflected Blows", "=ds=#s2#", "", "20%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 44151, "", "=q4=Reins of the Blue Proto-Drake", "=ds=#e12#", "", "1%"};
		{ 19, 37389, "", "=q3=Crenelation Leggings", "=ds=#s11#, #a2#", "", "21%"};
		{ 20, 37379, "", "=q3=Skadi's Iron Belt", "=ds=#s10#, #a4#", "", "22%"};
		{ 21, 37377, "", "=q3=Netherbreath Spellblade", "=ds=#h3#, #w4#", "", "21%"};
		{ 22, 37384, "", "=q3=Staff of Wayward Principles", "=ds=#w9#", "", "21%"};
		Prev = "UPPalehoof";
		Next = "UPYmiron";
	};

	AtlasLoot_Data["UPYmiron"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 37067, "", "=q3=Ceremonial Pyre Mantle", "=ds=#s3#, #a2#", "", "19%"};
		{ 3, 37062, "", "=q3=Crown of Forgotten Kings", "=ds=#s1#, #a4#", "", "21%"};
		{ 4, 37066, "", "=q3=Ancient Royal Legguards", "=ds=#s11#, #a4#", "", "23%"};
		{ 5, 37058, "", "=q3=Signet of Ranulf", "=ds=#s13#", "", "22%"};
		{ 6, 37064, "", "=q3=Vestige of Haldor", "=ds=#s14#", "", "24%"};
		{ 7, 37060, "", "=q3=Jeweled Coronation Sword", "=ds=#h3#, #w10#", "", "20%"};
		{ 8, 37065, "", "=q3=Ymiron's Blade", "=ds=#h1#, #w10#", "", "20%"};
		{ 9, 37061, "", "=q3=Tor's Crest", "=ds=#w8#", "", "23%"};
		{ 10, 41797, "", "=q3=Design: Austere Earthsiege Diamond", "=ds=#p12# (420)", "", "10%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37408, "", "=q4=Girdle of Bane", "=ds=#s10#, #a1#", "", "19%"};
		{ 19, 37409, "", "=q4=Gilt-Edged Leather Gauntlets", "=ds=#s9#, #a2#", "", "19%"};
		{ 20, 37407, "", "=q4=Sovereign's Belt", "=ds=#s10#, #a3#", "", "20%"};
		{ 21, 37401, "", "=q4=Red Sword of Courage", "=ds=#h1#, #w10#", "", "18%"};
		{ 22, 37398, "", "=q3=Mantle of Discarded Ways", "=ds=#s3#, #a3#", "", "20%"};
		{ 23, 37395, "", "=q3=Ornamented Plate Regalia", "=ds=#s5#, #a4#", "", "20%"};
		{ 24, 37397, "", "=q3=Gold Amulet of Kings", "=ds=#s2#", "", "20%"};
		{ 25, 37390, "", "=q3=Meteorite Whetstone", "=ds=#s14#", "", "20%"};
		{ 26, 41797, "", "=q3=Design: Austere Earthsiege Diamond", "=ds=#p12# (420)", "", "10%"};
		{ 27, 43102, "", "=q3=Frozen Orb", "=ds=#e6#", "", "100%"};
		Prev = "UPSkadi";
		Next = "UPTrash";
	};

	AtlasLoot_Data["UPTrash"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 37070, "", "=q3=Tundra Wolf Boots", "=ds=#s12#, #a2#", "", "2%"};
		{ 3, 37069, "", "=q3=Dragonflayer Seer's Bindings", "=ds=#s8#, #a3#", "", "1%"};
		{ 4, 37068, "", "=q3=Berserker's Sabatons", "=ds=#s12#, #a4#", "", "3%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 37587, "", "=q3=Ymirjar Physician's Robe", "=ds=#s5#, #a2#", "", "1%"};
		{ 18, 37590, "", "=q3=Bands of Fading Light", "=ds=#s8#, #a4#", "", "1%"};
		{ 19, 37410, "", "=q3=Tracker's Balanced Knives", "=ds=#w11#", "", "1%"};
		Prev = "UPYmiron";
	};

		------------------
		--- The Oculus ---
		------------------

	AtlasLoot_Data["OcuDrakos"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 36945, "", "=q3=Verdisa's Cuffs of Dreaming", "=ds=#s8#, #a1#", "", "21%"};
		{ 3, 36946, "", "=q3=Runic Cage Chestpiece", "=ds=#s5#, #a3#", "", "23%"};
		{ 4, 36943, "", "=q3=Timeless Beads of Eternos", "=ds=#s2#", "", "21%"};
		{ 5, 36944, "", "=q3=Lifeblade of Belgaristrasz", "=ds=#h1#, #w4#", "", "25%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37258, "", "=q3=Drakewing Raiments", "=ds=#s5#, #a1#", "", "22%"};
		{ 19, 37256, "", "=q3=Scaled Armor of Drakos", "=ds=#s5#, #a3#", "", "23%"};
		{ 20, 37257, "", "=q3=Band of Torture", "=ds=#s13#", "", "23%"};
		{ 21, 37255, "", "=q3=The Interrogator", "=ds=#h1#, #w10#", "", "23%"};
		Next = "OcuCloudstrider";
	};

	AtlasLoot_Data["OcuCloudstrider"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 36947, "", "=q3=Centrifuge Core Cloak", "=ds=#s4#", "", "21%"};
		{ 3, 36949, "", "=q3=Gloves of the Azure-Lord", "=ds=#s9#, #a1#", "", "21%"};
		{ 4, 36948, "", "=q3=Horned Helm of Varos", "=ds=#s1#, #a2#", "", "22%"};
		{ 5, 36950, "", "=q3=Wing Commander's Breastplate", "=ds=#s5#, #a4#", "", "23%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37261, "", "=q3=Gloves of Radiant Light", "=ds=#s9#, #a2#", "", "22%"};
		{ 19, 37262, "", "=q3=Azure Ringmail Leggings", "=ds=#s11#, #a3#", "", "21%"};
		{ 20, 37263, "", "=q3=Legplates of the Oculus Guardian", "=ds=#s11#, #a4#", "", "21%"};
		{ 21, 37260, "", "=q3=Cloudstrider's Waraxe", "=ds=#h1#, #w1#", "", "21%"};
		Prev = "OcuDrakos";
		Next = "OcuUrom";
	};

	AtlasLoot_Data["OcuUrom"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 36954, "", "=q3=The Conjurer's Slippers", "=ds=#s12#, #a1#", "", "21%"};
		{ 3, 36951, "", "=q3=Sidestepping Handguards", "=ds=#s9#, #a2#", "", "20%"};
		{ 4, 36953, "", "=q3=Spaulders of Skillful Maneuvers", "=ds=#s3#, #a3#", "", "21%"};
		{ 5, 36952, "", "=q3=Girdle of Obscuring", "=ds=#s10#, #a4#", "", "18%"};
		{ 7, 21525, "", "=q2=Green Winter Hat", "=ds=#s1#, #a1# =q2=#m28#"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37289, "", "=q3=Sash of Phantasmal Images", "=ds=#s10#, #a1#", "", "18%"};
		{ 19, 37288, "", "=q3=Catalytic Bands", "=ds=#s8#, #a4#", "", "18%"};
		{ 20, 37195, "", "=q3=Band of Enchanted Growth", "=ds=#s13#", "", "20%"};
		{ 21, 37264, "", "=q3=Pendulum of Telluric Currents", "=ds=#s14#", "", "20%"};
		{ 23, 21525, "", "=q2=Green Winter Hat", "=ds=#s1#, #a1# =q2=#m28#"};
		Prev = "OcuCloudstrider";
		Next = "OcuEregos";
	};

	AtlasLoot_Data["OcuEregos"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 36973, "", "=q3=Vestments of the Scholar", "=ds=#s5#, #a1#", "", "18%"};
		{ 3, 36971, "", "=q3=Headguard of Westrift", "=ds=#s1#, #a3#", "", "17%"};
		{ 4, 36969, "", "=q3=Helm of the Ley-Guardian", "=ds=#s1#, #a4#", "", "14%"};
		{ 5, 36974, "", "=q3=Eredormu's Ornamented Chestguard", "=ds=#s5#, #a4#", "", "18%"};
		{ 6, 36961, "", "=q3=Dragonflight Great-Ring", "=ds=#s13#", "", "17%"};
		{ 7, 36972, "", "=q3=Tome of Arcane Phenomena", "=ds=#s14#", "", "15%"};
		{ 8, 36962, "", "=q3=Wyrmclaw Battleaxe", "=ds=#h2#, #w1#", "", "17%"};
		{ 9, 36975, "", "=q3=Malygos's Favor", "=ds=#w9#", "", "17%"};
		{ 10, 41798, "", "=q3=Design: Bracing Earthsiege Diamond", "=ds=#p12# (420)", "", "7%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 37361, "", "=q4=Cuffs of Winged Levitation", "=ds=#s8#, #a1#", "", "14%"};
		{ 19, 37363, "", "=q4=Gauntlets of Dragon Wrath", "=ds=#s9#, #a4#", "", "13%"};
		{ 20, 37362, "", "=q4=Leggings of Protective Auras", "=ds=#s11#, #a4#", "", "13%"};
		{ 21, 37360, "", "=q4=Staff of Draconic Combat", "=ds=#w9#", "", "14%"};
		{ 22, 37291, "", "=q3=Ancient Dragon Spirit Cape", "=ds=#s4#", "", "14%"};
		{ 23, 37294, "", "=q3=Crown of Unbridled Magic", "=ds=#s1#, #a1#", "", "14%"};
		{ 24, 37293, "", "=q3=Mask of the Watcher", "=ds=#s1#, #a2#", "", "15%"};
		{ 25, 37292, "", "=q3=Ley-Guardian's Legguards", "=ds=#s11#, #a4#", "", "15%"};
		{ 26, 43102, "", "=q3=Frozen Orb", "=ds=#e6#", "", "100%"};
		{ 28, 52676, "", "=q2=Cache of the Ley-Guardian", "=ds="..AL["Random Heroic Reward"]};
		Prev = "OcuUrom";
		Next = "OcuTrash";
	};

	AtlasLoot_Data["OcuTrash"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 36978, "", "=q3=Ley-Whelphide Belt", "=ds=#s10#, #a2#", "", "0.45%"};
		{ 3, 36977, "", "=q3=Bindings of the Construct", "=ds=#s8#, #a4#", "", "1%"};
		{ 4, 36976, "", "=q3=Ring-Lord's Leggings", "=ds=#s11#, #a1#", "", "1%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 37366, "", "=q3=Drake-Champion's Bracers", "=ds=#s8#, #a2#", "", "1%"};
		{ 18, 37365, "", "=q3=Bands of the Sky Ring", "=ds=#s8#, #a3#", "", "1%"};
		{ 19, 37290, "", "=q3=Dragon Prow Amulet", "=ds=#s2#", "", "1%"};
		{ 20, 37364, "", "=q3=Frostbridge Orb", "=ds=#s15#", "", "1%"};
		Prev = "OcuEregos";
	};

		-------------------------
		--- Vault of Archavon ---
		-------------------------

	AtlasLoot_Data["VaultofArchavonArchavon1"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 2, 39492, "", "=q4=Heroes' Frostfire Robe", "=ds=#s5#, #a1#"};
		{ 3, 39495, "", "=q4=Heroes' Frostfire Gloves", "=ds=#s9#, #a1#"};
		{ 4, 39493, "", "=q4=Heroes' Frostfire Leggings", "=ds=#s11#, #a1#"};
		{ 6, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 7, 39515, "", "=q4=Heroes' Robe of Faith", "=ds=#s5#, #a1#"};
		{ 8, 39519, "", "=q4=Heroes' Gloves of Faith", "=ds=#s9#, #a1#"};
		{ 9, 39517, "", "=q4=Heroes' Leggings of Faith", "=ds=#s11#, #a1#"};
		{ 11, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 12, 39523, "", "=q4=Heroes' Raiments of Faith", "=ds=#s5#, #a1#"};
		{ 13, 39530, "", "=q4=Heroes' Handwraps of Faith", "=ds=#s9#, #a1#"};
		{ 14, 39528, "", "=q4=Heroes' Pants of Faith", "=ds=#s11#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 17, 41950, "", "=q4=Hateful Gladiator's Silk Raiment", "=ds=#s5#, #a1#"};
		{ 18, 41969, "", "=q4=Hateful Gladiator's Silk Handguards", "=ds=#s9#, #a1#"};
		{ 19, 41957, "", "=q4=Hateful Gladiator's Silk Trousers", "=ds=#s11#, #a1#"};
		{ 21, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 22, 41857, "", "=q4=Hateful Gladiator's Mooncloth Robe", "=ds=#s5#, #a1#"};
		{ 23, 41872, "", "=q4=Hateful Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1#"};
		{ 24, 41862, "", "=q4=Hateful Gladiator's Mooncloth Leggings", "=ds=#s11#, #a1#"};
		{ 26, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 27, 41919, "", "=q4=Hateful Gladiator's Satin Robe", "=ds=#s5#, #a1#"};
		{ 28, 41938, "", "=q4=Hateful Gladiator's Satin Gloves", "=ds=#s9#, #a1#"};
		{ 29, 41925, "", "=q4=Hateful Gladiator's Satin Leggings", "=ds=#s11#, #a1#"};
		Next = "VaultofArchavonArchavon2";
	};

	AtlasLoot_Data["VaultofArchavonArchavon2"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 2, 39497, "", "=q4=Heroes' Plagueheart Robe", "=ds=#s5#, #a1#"};
		{ 3, 39500, "", "=q4=Heroes' Plagueheart Gloves", "=ds=#s9#, #a1#"};
		{ 4, 39498, "", "=q4=Heroes' Plagueheart Leggings", "=ds=#s11#, #a1#"};
		{ 6, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 7, 39547, "", "=q4=Heroes' Dreamwalker Vestments", "=ds=#s5#, #a2#"};
		{ 8, 39544, "", "=q4=Heroes' Dreamwalker Gloves", "=ds=#s9#, #a2#"};
		{ 9, 39546, "", "=q4=Heroes' Dreamwalker Trousers", "=ds=#s11#, #a2#"};
		{ 11, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 12, 39554, "", "=q4=Heroes' Dreamwalker Raiments", "=ds=#s5#, #a2#"};
		{ 13, 39557, "", "=q4=Heroes' Dreamwalker Handgrips", "=ds=#s9#, #a2#"};
		{ 14, 39555, "", "=q4=Heroes' Dreamwalker Legguards", "=ds=#s11#, #a2#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 17, 42001, "", "=q4=Hateful Gladiator's Felweave Raiment", "=ds=#s5#, #a1#"};
		{ 18, 42015, "", "=q4=Hateful Gladiator's Felweave Handguards", "=ds=#s9#, #a1#"};
		{ 19, 42003, "", "=q4=Hateful Gladiator's Felweave Trousers", "=ds=#s11#, #a1#"};
		{ 21, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 22, 41314, "", "=q4=Hateful Gladiator's Wyrmhide Robes", "=ds=#s5#, #a2#"};
		{ 23, 41291, "", "=q4=Hateful Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2#"};
		{ 24, 41302, "", "=q4=Hateful Gladiator's Wyrmhide Legguards", "=ds=#s11#, #a2#"};
		{ 26, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 27, 41659, "", "=q4=Hateful Gladiator's Dragonhide Robes", "=ds=#s5#, #a2#"};
		{ 28, 41771, "", "=q4=Hateful Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2#"};
		{ 29, 41665, "", "=q4=Hateful Gladiator's Dragonhide Legguards", "=ds=#s11#, #a2#"};
		Prev = "VaultofArchavonArchavon1";
		Next = "VaultofArchavonArchavon3";
	};

	AtlasLoot_Data["VaultofArchavonArchavon3"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 2, 39538, "", "=q4=Heroes' Dreamwalker Robe", "=ds=#s5#, #a2#"};
		{ 3, 39543, "", "=q4=Heroes' Dreamwalker Handguards", "=ds=#s9#, #a2#"};
		{ 4, 39539, "", "=q4=Heroes' Dreamwalker Leggings", "=ds=#s11#, #a2#"};
		{ 6, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 7, 39558, "", "=q4=Heroes' Bonescythe Breastplate", "=ds=#s5#, #a2#"};
		{ 8, 39560, "", "=q4=Heroes' Bonescythe Gauntlets", "=ds=#s9#, #a2#"};
		{ 9, 39564, "", "=q4=Heroes' Bonescythe Legplates", "=ds=#s11#, #a2#"};
		{ 11, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 12, 39579, "", "=q4=Heroes' Crypstalker Tunic", "=ds=#s5#, #a3#"};
		{ 13, 39582, "", "=q4=Heroes' Crypstalker Handguards", "=ds=#s9#, #a3#"};
		{ 14, 39580, "", "=q4=Heroes' Crypstalker Legguards", "=ds=#s11#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 17, 41308, "", "=q4=Hateful Gladiator's Kodohide Robes", "=ds=#s5#, #a2#"};
		{ 18, 41284, "", "=q4=Hateful Gladiator's Kodohide Gloves", "=ds=#s9#, #a2#"};
		{ 19, 41296, "", "=q4=Hateful Gladiator's Kodohide Legguards", "=ds=#s11#, #a2#"};
		{ 21, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 22, 41648, "", "=q4=Hateful Gladiator's Leather Tunic", "=ds=#s5#, #a2#"};
		{ 23, 41765, "", "=q4=Hateful Gladiator's Leather Gloves", "=ds=#s9#, #a2#"};
		{ 24, 41653, "", "=q4=Hateful Gladiator's Leather Legguards", "=ds=#s11#, #a2#"};
		{ 26, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 27, 41085, "", "=q4=Hateful Gladiator's Chain Armor", "=ds=#s5#, #a3#"};
		{ 28, 41141, "", "=q4=Hateful Gladiator's Chain Gauntlets", "=ds=#s9#, #a3#"};
		{ 29, 41203, "", "=q4=Hateful Gladiator's Chain Leggings", "=ds=#s11#, #a3#"};
		Prev = "VaultofArchavonArchavon2";
		Next = "VaultofArchavonArchavon4";
	};

	AtlasLoot_Data["VaultofArchavonArchavon4"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 2, 39592, "", "=q4=Heroes' Earthshatter Hauberk", "=ds=#s5#, #a3#"};
		{ 3, 39593, "", "=q4=Heroes' Earthshatter Gloves", "=ds=#s9#, #a3#"};
		{ 4, 39595, "", "=q4=Heroes' Earthshatter Kilt", "=ds=#s11#, #a3#"};
		{ 6, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 7, 39597, "", "=q4=Heroes' Earthshatter Chestguard", "=ds=#s5#, #a3#"};
		{ 8, 39601, "", "=q4=Heroes' Earthshatter Grips", "=ds=#s9#, #a3#"};
		{ 9, 39603, "", "=q4=Heroes' Earthshatter War-Kilt", "=ds=#s11#, #a3#"};
		{ 11, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 12, 39588, "", "=q4=Heroes' Earthshatter Tunic", "=ds=#s5#, #a3#"};
		{ 13, 39591, "", "=q4=Heroes' Earthshatter Handguards", "=ds=#s9#, #a3#"};
		{ 14, 39589, "", "=q4=Heroes' Earthshatter Legguards", "=ds=#s11#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 17, 40989, "", "=q4=Hateful Gladiator's Mail Armor", "=ds=#s5#, #a3#"};
		{ 18, 41005, "", "=q4=Hateful Gladiator's Mail Gauntlets", "=ds=#s9#, #a3#"};
		{ 19, 41031, "", "=q4=Hateful Gladiator's Mail Leggings", "=ds=#s11#, #a3#"};
		{ 21, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 22, 41079, "", "=q4=Hateful Gladiator's Linked Armor", "=ds=#s5#, #a3#"};
		{ 23, 41135, "", "=q4=Hateful Gladiator's Linked Gauntlets", "=ds=#s9#, #a3#"};
		{ 24, 41162, "", "=q4=Hateful Gladiator's Linked Leggings", "=ds=#s11#, #a3#"};
		{ 26, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 27, 40988, "", "=q4=Hateful Gladiator's Ringmail Armor", "=ds=#s5#, #a3#"};
		{ 28, 40999, "", "=q4=Hateful Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3#"};
		{ 29, 41025, "", "=q4=Hateful Gladiator's Ringmail Leggings", "=ds=#s11#, #a3#"};
		Prev = "VaultofArchavonArchavon3";
		Next = "VaultofArchavonArchavon5";
	};

	AtlasLoot_Data["VaultofArchavonArchavon5"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 2, 39617, "", "=q4=Heroes' Scourgeborne Battleplate", "=ds=#s5#, #a4#"};
		{ 3, 39618, "", "=q4=Heroes' Scourgeborne Gauntlets", "=ds=#s9#, #a4#"};
		{ 4, 39620, "", "=q4=Heroes' Scourgeborne Legplates", "=ds=#s11#, #a4#"};
		{ 6, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
		{ 7, 39623, "", "=q4=Heroes' Scourgeborne Chestguard", "=ds=#s5#, #a4#"};
		{ 8, 39624, "", "=q4=Heroes' Scourgeborne Handguards", "=ds=#s9#, #a4#"};
		{ 9, 39626, "", "=q4=Heroes' Scourgeborne Legguards", "=ds=#s11#, #a4#"};
		{ 11, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 12, 39629, "", "=q4=Heroes' Redemption Tunic", "=ds=#s5#, #a4#"};
		{ 13, 39632, "", "=q4=Heroes' Redemption Gloves", "=ds=#s9#, #a4#"};
		{ 14, 39630, "", "=q4=Heroes' Redemption Greaves", "=ds=#s11#, #a4#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 17, 40781, "", "=q4=Hateful Gladiator's Dreadplate Chestpiece", "=ds=#s5#, #a4#"};
		{ 18, 40803, "", "=q4=Hateful Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4#"};
		{ 19, 40841, "", "=q4=Hateful Gladiator's Dreadplate Legguards", "=ds=#s11#, #a4#"};
		{ 26, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 27, 40904, "", "=q4=Hateful Gladiator's Ornamented Chestguard", "=ds=#s5#, #a4#"};
		{ 28, 40925, "", "=q4=Hateful Gladiator's Ornamented Gloves", "=ds=#s9#, #a4#"};
		{ 29, 40937, "", "=q4=Hateful Gladiator's Ornamented Legplates", "=ds=#s11#, #a4#"}; 
		Prev = "VaultofArchavonArchavon4";
		Next = "VaultofArchavonArchavon6";
	};

	AtlasLoot_Data["VaultofArchavonArchavon6"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 2, 39633, "", "=q4=Heroes' Redemption Chestpiece", "=ds=#s5#, #a4#"};
		{ 3, 39634, "", "=q4=Heroes' Redemption Gauntlets", "=ds=#s9#, #a4#"};
		{ 4, 39636, "", "=q4=Heroes' Redemption Legplates", "=ds=#s11#, #a4#"};
		{ 6, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Protection"]};
		{ 7, 39638, "", "=q4=Heroes' Redemption Breastplate", "=ds=#s5#, #a4#"};
		{ 8, 39639, "", "=q4=Heroes' Redemption Handguards", "=ds=#s9#, #a4#"};
		{ 9, 39641, "", "=q4=Heroes' Redemption Legguards", "=ds=#s11#, #a4#"};
		{ 11, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 12, 39606, "", "=q4=Heroes' Dreadnaught Battleplate", "=ds=#s5#, #a4#"};
		{ 13, 39609, "", "=q4=Heroes' Dreadnaught Gauntlets", "=ds=#s9#, #a4#"};
		{ 14, 39607, "", "=q4=Heroes' Dreadnaught Legplates", "=ds=#s11#, #a4#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 17, 40782, "", "=q4=Hateful Gladiator's Scaled Chestpiece", "=ds=#s5#, #a4#"};
		{ 18, 40802, "", "=q4=Hateful Gladiator's Scaled Gauntlets", "=ds=#s11#, #a4#"};
		{ 19, 40842, "", "=q4=Hateful Gladiator's Scaled Legguards", "=ds=#s11#, #a4#"};
		{ 26, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 27, 40783, "", "=q4=Hateful Gladiator's Plate Chestpiece", "=ds=#s5#, #a4#"};
		{ 28, 40801, "", "=q4=Hateful Gladiator's Plate Gauntlets", "=ds=#s9#, #a4#"};
		{ 29, 40840, "", "=q4=Hateful Gladiator's Plate Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonArchavon5";
		Next = "VaultofArchavonArchavon7";
	};

	AtlasLoot_Data["VaultofArchavonArchavon7"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["Protection"]};
		{ 2, 39611, "", "=q4=Heroes' Dreadnaught Breastplate", "=ds=#s5#, #a4#"};
		{ 3, 39622, "", "=q4=Heroes' Dreadnaught Handguards", "=ds=#s9#, #a4#"};
		{ 4, 39612, "", "=q4=Heroes' Dreadnaught Legguards", "=ds=#s11#, #a4#"};
		{ 6, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 7, 43959, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m7#", "", ""};
		{ 8, 44083, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m6#", "", ""};
		Prev = "VaultofArchavonArchavon6";
	};

	AtlasLoot_Data["VaultofArchavonArchavon125Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 2, 40418, "", "=q4=Valorous Frostfire Robe", "=ds=#s5#, #a1#"};
		{ 3, 40415, "", "=q4=Valorous Frostfire Gloves", "=ds=#s9#, #a1#"};
		{ 4, 40417, "", "=q4=Valorous Frostfire Leggings", "=ds=#s11#, #a1#"};
		{ 6, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 7, 40449, "", "=q4=Valorous Robe of Faith", "=ds=#s5#, #a1#"};
		{ 8, 40445, "", "=q4=Valorous Gloves of Faith", "=ds=#s9#, #a1#"};
		{ 9, 40448, "", "=q4=Valorous Leggings of Faith", "=ds=#s11#, #a1#"};
		{ 11, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 12, 40458, "", "=q4=Valorous Raiments of Faith", "=ds=#s5#, #a1#"};
		{ 13, 40454, "", "=q4=Valorous Handwraps of Faith", "=ds=#s9#, #a1#"};
		{ 14, 40457, "", "=q4=Valorous Pants of Faith", "=ds=#s11#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 17, 41951, "", "=q4=Deadly Gladiator's Silk Raiment", "=ds=#s5#, #a1#"};
		{ 18, 41970, "", "=q4=Deadly Gladiator's Silk Handguards", "=ds=#s9#, #a1#"};
		{ 19, 41958, "", "=q4=Deadly Gladiator's Silk Trousers", "=ds=#s11#, #a1#"};
		{ 21, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 22, 41858, "", "=q4=Deadly Gladiator's Mooncloth Robe", "=ds=#s5#, #a1#"};
		{ 23, 41873, "", "=q4=Deadly Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1#"};
		{ 24, 41863, "", "=q4=Deadly Gladiator's Mooncloth Leggings", "=ds=#s11#, #a1#"};
		{ 26, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 27, 41920, "", "=q4=Deadly Gladiator's Satin Robe", "=ds=#s5#, #a1#"};
		{ 28, 41939, "", "=q4=Deadly Gladiator's Satin Gloves", "=ds=#s9#, #a1#"};
		{ 29, 41926, "", "=q4=Deadly Gladiator's Satin Leggings", "=ds=#s11#, #a1#"};
		Next = "VaultofArchavonArchavon225Man";
	};

	AtlasLoot_Data["VaultofArchavonArchavon225Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 2, 40423, "", "=q4=Valorous Plagueheart Robe", "=ds=#s5#, #a1#"};
		{ 3, 40420, "", "=q4=Valorous Plagueheart Gloves", "=ds=#s9#, #a1#"};
		{ 4, 40422, "", "=q4=Valorous Plagueheart Leggings", "=ds=#s11#, #a1#"};
		{ 6, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 7, 40469, "", "=q4=Valorous Dreamwalker Vestments", "=ds=#s5#, #a2#"};
		{ 8, 40466, "", "=q4=Valorous Dreamwalker Gloves", "=ds=#s9#, #a2#"};
		{ 9, 40468, "", "=q4=Valorous Dreamwalker Trousers", "=ds=#s11#, #a2#"};
		{ 11, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 12, 40471, "", "=q4=Valorous Dreamwalker Raiments", "=ds=#s5#, #a2#"};
		{ 13, 40472, "", "=q4=Valorous Dreamwalker Handgrips", "=ds=#s9#, #a2#"};
		{ 14, 40493, "", "=q4=Valorous Dreamwalker Legguards", "=ds=#s11#, #a2#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 17, 41997, "", "=q4=Deadly Gladiator's Felweave Raiment", "=ds=#s5#, #a1#"};
		{ 18, 42016, "", "=q4=Deadly Gladiator's Felweave Handguards", "=ds=#s9#, #a1#"};
		{ 19, 42004, "", "=q4=Deadly Gladiator's Felweave Trousers", "=ds=#s11#, #a1#"};
		{ 21, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 22, 41315, "", "=q4=Deadly Gladiator's Wyrmhide Robes", "=ds=#s5#, #a2#"};
		{ 23, 41292, "", "=q4=Deadly Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2#"};
		{ 24, 41303, "", "=q4=Deadly Gladiator's Wyrmhide Legguards", "=ds=#s11#, #a2#"};
		{ 26, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 27, 41660, "", "=q4=Deadly Gladiator's Dragonhide Robes", "=ds=#s5#, #a2#"};
		{ 28, 41772, "", "=q4=Deadly Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2#"};
		{ 29, 41666, "", "=q4=Deadly Gladiator's Dragonhide Legguards", "=ds=#s11#, #a2#"};
		Prev = "VaultofArchavonArchavon125Man";
		Next = "VaultofArchavonArchavon325Man";
	};

	AtlasLoot_Data["VaultofArchavonArchavon325Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 2, 40463, "", "=q4=Valorous Dreamwalker Robe", "=ds=#s5#, #a2#"};
		{ 3, 40460, "", "=q4=Valorous Dreamwalker Handguards", "=ds=#s9#, #a2#"};
		{ 4, 40462, "", "=q4=Valorous Dreamwalker Leggings", "=ds=#s11#, #a2#"};
		{ 6, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 7, 40495, "", "=q4=Valorous Bonescythe Breastplate", "=ds=#s5#, #a2#"};
		{ 8, 40496, "", "=q4=Valorous Bonescythe Gauntlets", "=ds=#s9#, #a2#"};
		{ 9, 40500, "", "=q4=Valorous Bonescythe Legplates", "=ds=#s11#, #a2#"};
		{ 11, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 12, 40503, "", "=q4=Valorous Crypstalker Tunic", "=ds=#s5#, #a3#"};
		{ 13, 40504, "", "=q4=Valorous Crypstalker Handguards", "=ds=#s9#, #a3#"};
		{ 14, 40506, "", "=q4=Valorous Crypstalker Legguards", "=ds=#s11#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 17, 41309, "", "=q4=Deadly Gladiator's Kodohide Robes", "=ds=#s5#, #a2#"};
		{ 18, 41286, "", "=q4=Deadly Gladiator's Kodohide Gloves", "=ds=#s9#, #a2#"};
		{ 19, 41297, "", "=q4=Deadly Gladiator's Kodohide Legguards", "=ds=#s11#, #a2#"};
		{ 21, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 22, 41649, "", "=q4=Deadly Gladiator's Leather Tunic", "=ds=#s5#, #a2#"};
		{ 23, 41766, "", "=q4=Deadly Gladiator's Leather Gloves", "=ds=#s9#, #a2#"};
		{ 24, 41654, "", "=q4=Deadly Gladiator's Leather Legguards", "=ds=#s11#, #a2#"};
		{ 26, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 27, 41086, "", "=q4=Deadly Gladiator's Chain Armor", "=ds=#s5#, #a3#"};
		{ 28, 41142, "", "=q4=Deadly Gladiator's Chain Gauntlets", "=ds=#s9#, #a3#"};
		{ 29, 41204, "", "=q4=Deadly Gladiator's Chain Leggings", "=ds=#s11#, #a3#"};
		Prev = "VaultofArchavonArchavon225Man";
		Next = "VaultofArchavonArchavon425Man";
	};

	AtlasLoot_Data["VaultofArchavonArchavon425Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 2, 40514, "", "=q4=Valorous Earthshatter Hauberk", "=ds=#s5#, #a3#"};
		{ 3, 40515, "", "=q4=Valorous Earthshatter Gloves", "=ds=#s9#, #a3#"};
		{ 4, 40517, "", "=q4=Valorous Earthshatter Kilt", "=ds=#s11#, #a3#"};
		{ 6, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 7, 40523, "", "=q4=Valorous Earthshatter Chestguard", "=ds=#s5#, #a3#"};
		{ 8, 40520, "", "=q4=Valorous Earthshatter Grips", "=ds=#s9#, #a3#"};
		{ 9, 40522, "", "=q4=Valorous Earthshatter War-Kilt", "=ds=#s11#, #a3#"};
		{ 11, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 12, 40508, "", "=q4=Valorous Earthshatter Tunic", "=ds=#s5#, #a3#"};
		{ 13, 40509, "", "=q4=Valorous Earthshatter Handguards", "=ds=#s9#, #a3#"};
		{ 14, 40512, "", "=q4=Valorous Earthshatter Legguards", "=ds=#s11#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 17, 40991, "", "=q4=Deadly Gladiator's Mail Armor", "=ds=#s5#, #a3#"};
		{ 18, 41006, "", "=q4=Deadly Gladiator's Mail Gauntlets", "=ds=#s9#, #a3#"};
		{ 19, 41032, "", "=q4=Deadly Gladiator's Mail Leggings", "=ds=#s11#, #a3#"};
		{ 21, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 22, 41080, "", "=q4=Deadly Gladiator's Linked Armor", "=ds=#s5#, #a3#"};
		{ 23, 41136, "", "=q4=Deadly Gladiator's Linked Gauntlets", "=ds=#s9#, #a3#"};
		{ 24, 41198, "", "=q4=Deadly Gladiator's Linked Leggings", "=ds=#s11#, #a3#"};
		{ 26, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 27, 40990, "", "=q4=Deadly Gladiator's Ringmail Armor", "=ds=#s5#, #a3#"};
		{ 28, 41000, "", "=q4=Deadly Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3#"};
		{ 29, 41026, "", "=q4=Deadly Gladiator's Ringmail Leggings", "=ds=#s11#, #a3#"};
		Prev = "VaultofArchavonArchavon325Man";
		Next = "VaultofArchavonArchavon525Man";
	};

	AtlasLoot_Data["VaultofArchavonArchavon525Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 2, 40550, "", "=q4=Valorous Scourgeborne Battleplate", "=ds=#s5#, #a4#"};
		{ 3, 40552, "", "=q4=Valorous Scourgeborne Gauntlets", "=ds=#s9#, #a4#"};
		{ 4, 40556, "", "=q4=Valorous Scourgeborne Legplates", "=ds=#s11#, #a4#"};
		{ 6, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
		{ 7, 40559, "", "=q4=Valorous Scourgeborne Chestguard", "=ds=#s5#, #a4#"};
		{ 8, 40563, "", "=q4=Valorous Scourgeborne Handguards", "=ds=#s9#, #a4#"};
		{ 9, 40567, "", "=q4=Valorous Scourgeborne Legguards", "=ds=#s11#, #a4#"};
		{ 11, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 12, 40569, "", "=q4=Valorous Redemption Tunic", "=ds=#s5#, #a4#"};
		{ 13, 40570, "", "=q4=Valorous Redemption Gloves", "=ds=#s9#, #a4#"};
		{ 14, 40572, "", "=q4=Valorous Redemption Greaves", "=ds=#s11#, #a4#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 17, 40784, "", "=q4=Deadly Gladiator's Dreadplate Chestpiece", "=ds=#s5#, #a4#"};
		{ 18, 40806, "", "=q4=Deadly Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4#"};
		{ 19, 40845, "", "=q4=Deadly Gladiator's Dreadplate Legguards", "=ds=#s11#, #a4#"};
		{ 26, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 27, 40905, "", "=q4=Deadly Gladiator's Ornamented Chestguard", "=ds=#s5#, #a4#"};
		{ 28, 40926, "", "=q4=Deadly Gladiator's Ornamented Gloves", "=ds=#s9#, #a4#"};
		{ 29, 40938, "", "=q4=Deadly Gladiator's Ornamented Legplates", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonArchavon425Man";
		Next = "VaultofArchavonArchavon625Man";
	};

	AtlasLoot_Data["VaultofArchavonArchavon625Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 2, 40574, "", "=q4=Valorous Redemption Chestpiece", "=ds=#s5#, #a4#"};
		{ 3, 40575, "", "=q4=Valorous Redemption Gauntlets", "=ds=#s9#, #a4#"};
		{ 4, 40577, "", "=q4=Valorous Redemption Legplates", "=ds=#s11#, #a4#"};
		{ 6, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Protection"]};
		{ 7, 40579, "", "=q4=Valorous Redemption Breastplate", "=ds=#s5#, #a4#"};
		{ 8, 40580, "", "=q4=Valorous Redemption Handguards", "=ds=#s9#, #a4#"};
		{ 9, 40583, "", "=q4=Valorous Redemption Legguards", "=ds=#s11#, #a4#"};
		{ 11, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 12, 40525, "", "=q4=Valorous Dreadnaught Battleplate", "=ds=#s5#, #a4#"};
		{ 13, 40527, "", "=q4=Valorous Dreadnaught Gauntlets", "=ds=#s9#, #a4#"};
		{ 14, 40529, "", "=q4=Valorous Dreadnaught Legplates", "=ds=#s11#, #a4#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 17, 40785, "", "=q4=Deadly Gladiator's Scaled Chestpiece", "=ds=#s5#, #a4#"};
		{ 18, 40805, "", "=q4=Deadly Gladiator's Scaled Gauntlets", "=ds=#s9#, #a4#"};
		{ 19, 40846, "", "=q4=Deadly Gladiator's Scaled Legguards", "=ds=#s11#, #a4#"};
		{ 26, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 27, 40786, "", "=q4=Deadly Gladiator's Plate Chestpiece", "=ds=#s5#, #a4#"};
		{ 28, 40804, "", "=q4=Deadly Gladiator's Plate Gauntlets", "=ds=#s9#, #a4#"};
		{ 29, 40844, "", "=q4=Deadly Gladiator's Plate Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonArchavon525Man";
		Next = "VaultofArchavonArchavon725Man";
	};

	AtlasLoot_Data["VaultofArchavonArchavon725Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["Protection"]};
		{ 2, 40544, "", "=q4=Valorous Dreadnaught Breastplate", "=ds=#s5#, #a4#"};
		{ 3, 40545, "", "=q4=Valorous Dreadnaught Handguards", "=ds=#s9#, #a4#"};
		{ 4, 40547, "", "=q4=Valorous Dreadnaught Legguards", "=ds=#s11#, #a4#"};
		{ 6, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 7, 43959, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m7#", "", ""};
		{ 8, 44083, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m6#", "", ""};
		Prev = "VaultofArchavonArchavon625Man";
	};

	AtlasLoot_Data["VaultofArchavonEmalon1"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 2, 46131, "", "=q4=Valorous Kirin'dor Gauntlets", "=ds=#s9#, #a1#"};
		{ 3, 45367, "", "=q4=Valorous Kirin'dor Leggings", "=ds=#s11#, #a1#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 6, 45387, "", "=q4=Valorous Gloves of Sanctification", "=ds=#s9#, #a1#"};
		{ 7, 45388, "", "=q4=Valorous Leggings of Sanctification", "=ds=#s11#, #a1#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 10, 45392, "", "=q4=Valorous Handwraps of Sanctification", "=ds=#s9#, #a1#"};
		{ 11, 45394, "", "=q4=Valorous Pants of Sanctification", "=ds=#s11#, #a1#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 14, 45419, "", "=q4=Valorous Deathbringer Gloves", "=ds=#s9#, #a1#"};
		{ 15, 45420, "", "=q4=Valorous Deathbringer Leggings", "=ds=#s11#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 17, 41970, "", "=q4=Deadly Gladiator's Silk Handguards", "=ds=#s9#, #a1#"};
		{ 18, 41958, "", "=q4=Deadly Gladiator's Silk Trousers", "=ds=#s11#, #a1#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 21, 41873, "", "=q4=Deadly Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1#"};
		{ 22, 41863, "", "=q4=Deadly Gladiator's Mooncloth Leggings", "=ds=#s11#, #a1#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 25, 41939, "", "=q4=Deadly Gladiator's Satin Gloves", "=ds=#s9#, #a1#"};
		{ 26, 41926, "", "=q4=Deadly Gladiator's Satin Leggings", "=ds=#s11#, #a1#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 29, 42016, "", "=q4=Deadly Gladiator's Felweave Handguards", "=ds=#s9#, #a1#"};
		{ 30, 42004, "", "=q4=Deadly Gladiator's Felweave Trousers", "=ds=#s11#, #a1#"};
		Next = "VaultofArchavonEmalon2";
	};

	AtlasLoot_Data["VaultofArchavonEmalon2"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 2, 45351, "", "=q4=Valorous Nightsong Gloves", "=ds=#s9#, #a2#"};
		{ 3, 45353, "", "=q4=Valorous Nightsong Trousers", "=ds=#s11#, #a2#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 6, 45355, "", "=q4=Valorous Nightsong Handgrips", "=ds=#s9#, #a2#"};
		{ 7, 45357, "", "=q4=Valorous Nightsong Legguards", "=ds=#s11#, #a2#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 10, 45345, "", "=q4=Valorous Nightsong Handguards", "=ds=#s9#, #a2#"};
		{ 11, 45347, "", "=q4=Valorous Nightsong Leggings", "=ds=#s11#, #a2#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 14, 45397, "", "=q4=Valorous Terrorblade Gauntlets", "=ds=#s9#, #a2#"};
		{ 15, 45399, "", "=q4=Valorous Terrorblade Legplates", "=ds=#s11#, #a2#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 17, 41292, "", "=q4=Deadly Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2#"};
		{ 18, 41303, "", "=q4=Deadly Gladiator's Wyrmhide Legguards", "=ds=#s11#, #a2#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 21, 41772, "", "=q4=Deadly Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2#"};
		{ 22, 41666, "", "=q4=Deadly Gladiator's Dragonhide Legguards", "=ds=#s11#, #a2#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 25, 41286, "", "=q4=Deadly Gladiator's Kodohide Gloves", "=ds=#s9#, #a2#"};
		{ 26, 41297, "", "=q4=Deadly Gladiator's Kodohide Legguards", "=ds=#s11#, #a2#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 29, 41766, "", "=q4=Deadly Gladiator's Leather Gloves", "=ds=#s9#, #a2#"};
		{ 30, 41654, "", "=q4=Deadly Gladiator's Leather Legguards", "=ds=#s11#, #a2#"};
		Prev = "VaultofArchavonEmalon1";
		Next = "VaultofArchavonEmalon3";
	};

	AtlasLoot_Data["VaultofArchavonEmalon3"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 2, 45360, "", "=q4=Valorous Scourgestalker Handguards", "=ds=#s9#, #a3#"};
		{ 3, 45362, "", "=q4=Valorous Scourgestalker Legguards", "=ds=#s11#, #a3#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 6, 45406, "", "=q4=Valorous Worldbreaker Gloves", "=ds=#s9#, #a3#"};
		{ 7, 45409, "", "=q4=Valorous Worldbreaker Kilt", "=ds=#s11#, #a3#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 10, 45414, "", "=q4=Valorous Worldbreaker Grips", "=ds=#s9#, #a3#"};
		{ 11, 45416, "", "=q4=Valorous Worldbreaker War-Kilt", "=ds=#s11#, #a3#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 14, 45401, "", "=q4=Valorous Worldbreaker Handguards", "=ds=#s9#, #a3#"};
		{ 15, 45403, "", "=q4=Valorous Worldbreaker Legguards", "=ds=#s11#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 17, 41142, "", "=q4=Deadly Gladiator's Chain Gauntlets", "=ds=#s9#, #a3#"};
		{ 18, 41204, "", "=q4=Deadly Gladiator's Chain Leggings", "=ds=#s11#, #a3#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 21, 41006, "", "=q4=Deadly Gladiator's Mail Gauntlets", "=ds=#s9#, #a3#"};
		{ 22, 41032, "", "=q4=Deadly Gladiator's Mail Leggings", "=ds=#s11#, #a3#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 25, 41136, "", "=q4=Deadly Gladiator's Linked Gauntlets", "=ds=#s9#, #a3#"};
		{ 26, 41198, "", "=q4=Deadly Gladiator's Linked Leggings", "=ds=#s11#, #a3#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 29, 41000, "", "=q4=Deadly Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3#"};
		{ 30, 41026, "", "=q4=Deadly Gladiator's Ringmail Leggings", "=ds=#s11#, #a3#"};
		Prev = "VaultofArchavonEmalon2";
		Next = "VaultofArchavonEmalon4";
	};

	AtlasLoot_Data["VaultofArchavonEmalon4"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 2, 45341, "", "=q4=Valorous Darkruned Gauntlets", "=ds=#s9#, #a4#"};
		{ 3, 45343, "", "=q4=Valorous Darkruned Legplates", "=ds=#s11#, #a4#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
		{ 6, 45337, "", "=q4=Valorous Darkruned Handguards", "=ds=#s9#, #a4#"};
		{ 7, 45338, "", "=q4=Valorous Darkruned Legguards", "=ds=#s11#, #a4#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 10, 45370, "", "=q4=Valorous Aegis Gloves", "=ds=#s9#, #a4#"};
		{ 11, 45371, "", "=q4=Valorous Aegis Greaves", "=ds=#s11#, #a4#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 14, 45376, "", "=q4=Valorous Aegis Gauntlets", "=ds=#s9#, #a4#"};
		{ 15, 45379, "", "=q4=Valorous Aegis Legplates", "=ds=#s11#, #a4#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 17, 40806, "", "=q4=Deadly Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4#"};
		{ 18, 40845, "", "=q4=Deadly Gladiator's Dreadplate Legguards", "=ds=#s11#, #a4#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 25, 40926, "", "=q4=Deadly Gladiator's Ornamented Gloves", "=ds=#s9#, #a4#"};
		{ 26, 40938, "", "=q4=Deadly Gladiator's Ornamented Legplates", "=ds=#s11#, #a4#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 29, 40805, "", "=q4=Deadly Gladiator's Scaled Gauntlets", "=ds=#s9#, #a4#"};
		{ 30, 40846, "", "=q4=Deadly Gladiator's Scaled Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonEmalon3";
		Next = "VaultofArchavonEmalon5";
	};

	AtlasLoot_Data["VaultofArchavonEmalon5"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Protection"]};
		{ 2, 45383, "", "=q4=Valorous Aegis Handguards", "=ds=#s9#, #a4#"};
		{ 3, 45384, "", "=q4=Valorous Aegis Legguards", "=ds=#s11#, #a4#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 6, 45430, "", "=q4=Valorous Siegebreaker Gauntlets", "=ds=#s9#, #a4#"};
		{ 7, 45432, "", "=q4=Valorous Siegebreaker Legplates", "=ds=#s11#, #a4#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["Protection"]};
		{ 10, 45426, "", "=q4=Valorous Siegebreaker Handguards", "=ds=#s9#, #a4#"};
		{ 11, 45427, "", "=q4=Valorous Siegebreaker Legguards", "=ds=#s11#, #a4#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 21, 40804, "", "=q4=Deadly Gladiator's Plate Gauntlets", "=ds=#s9#, #a4#"};
		{ 22, 40844, "", "=q4=Deadly Gladiator's Plate Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonEmalon4";
		Next = "VaultofArchavonEmalon6";
	};

	AtlasLoot_Data["VaultofArchavonEmalon6"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Cloth"]};
		{ 2, 41908, "", "=q4=Deadly Gladiator's Cuffs of Dominance", "=ds=#s8#, #a1#"};
		{ 3, 41897, "", "=q4=Deadly Gladiator's Cord of Dominance", "=ds=#s10#, #a1#"};
		{ 4, 41902, "", "=q4=Deadly Gladiator's Treads of Dominance", "=ds=#s12#, #a1#"};
		{ 6, 41892, "", "=q4=Deadly Gladiator's Cuffs of Salvation", "=ds=#s8#, #a1#"};
		{ 7, 41880, "", "=q4=Deadly Gladiator's Cord of Salvation", "=ds=#s10#, #a1#"};
		{ 8, 41884, "", "=q4=Deadly Gladiator's Treads of Salvation", "=ds=#s12#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Leather"]};
		{ 17, 41639, "", "=q4=Deadly Gladiator's Armwraps of Dominance", "=ds=#s8#, #a2#"};
		{ 18, 41629, "", "=q4=Deadly Gladiator's Belt of Dominance", "=ds=#s10#, #a2#"};
		{ 19, 41634, "", "=q4=Deadly Gladiator's Boots of Dominance", "=ds=#s12#, #a2#"};
		{ 21, 41624, "", "=q4=Deadly Gladiator's Armwraps of Salvation", "=ds=#s8#, #a2#"};
		{ 22, 41616, "", "=q4=Deadly Gladiator's Belt of Salvation", "=ds=#s10#, #a2#"};
		{ 23, 41620, "", "=q4=Deadly Gladiator's Boots of Salvation", "=ds=#s12#, #a2#"};
		{ 25, 41839, "", "=q4=Deadly Gladiator's Armwraps of Triumph", "=ds=#s8#, #a2#"};
		{ 26, 41831, "", "=q4=Deadly Gladiator's Belt of Triumph", "=ds=#s10#, #a2#"};
		{ 27, 41835, "", "=q4=Deadly Gladiator's Boots of Triumph", "=ds=#s12#, #a2#"};
		Prev = "VaultofArchavonEmalon5";
		Next = "VaultofArchavonEmalon7";
	};

	AtlasLoot_Data["VaultofArchavonEmalon7"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Mail"]};
		{ 2, 41064, "", "=q4=Deadly Gladiator's Wristguards of Dominance", "=ds=#s8#, #a3#"};
		{ 3, 41069, "", "=q4=Deadly Gladiator's Waistguard of Dominance", "=ds=#s10#, #a3#"};
		{ 4, 41074, "", "=q4=Deadly Gladiator's Sabatons of Dominance", "=ds=#s12#, #a3#"};
		{ 6, 41059, "", "=q4=Deadly Gladiator's Wristguards of Salvation", "=ds=#s8#, #a3#"};
		{ 7, 41048, "", "=q4=Deadly Gladiator's Waistguard of Salvation", "=ds=#s10#, #a3#"};
		{ 8, 41054, "", "=q4=Deadly Gladiator's Sabatons of Salvation", "=ds=#s12#, #a3#"};
		{ 10, 41224, "", "=q4=Deadly Gladiator's Wristguards of Triumph", "=ds=#s8#, #a3#"};
		{ 11, 41234, "", "=q4=Deadly Gladiator's Waistguard of Triumph", "=ds=#s10#, #a3#"};
		{ 12, 41229, "", "=q4=Deadly Gladiator's Sabatons of Triumph", "=ds=#s12#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Plate"]};
		{ 17, 40982, "", "=q4=Deadly Gladiator's Bracers of Salvation", "=ds=#s8#, #a4#"};
		{ 18, 40974, "", "=q4=Deadly Gladiator's Girdle of Salvation", "=ds=#s10#, #a4#"};
		{ 19, 40975, "", "=q4=Deadly Gladiator's Greaves of Salvation", "=ds=#s12#, #a4#"};
		{ 21, 40888, "", "=q4=Deadly Gladiator's Bracers of Triumph", "=ds=#s8#, #a4#"};
		{ 22, 40879, "", "=q4=Deadly Gladiator's Girdle of Triumph", "=ds=#s10#, #a4#"};
		{ 23, 40880, "", "=q4=Deadly Gladiator's Greaves of Triumph", "=ds=#s12#, #a4#"};
		Prev = "VaultofArchavonEmalon6";
		Next = "VaultofArchavonEmalon8";
	};

	AtlasLoot_Data["VaultofArchavonEmalon8"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Back"]};
		{ 2, 42064, "", "=q4=Deadly Gladiator's Cloak of Ascendancy", "=ds=#s4#"};
		{ 3, 42066, "", "=q4=Deadly Gladiator's Cloak of Deliverance", "=ds=#s4#"};
		{ 4, 42062, "", "=q4=Deadly Gladiator's Cloak of Dominance", "=ds=#s4#"};
		{ 5, 42065, "", "=q4=Deadly Gladiator's Cloak of Salvation", "=ds=#s4#"};
		{ 6, 42063, "", "=q4=Deadly Gladiator's Cloak of Subjugation", "=ds=#s4#"};
		{ 7, 42067, "", "=q4=Deadly Gladiator's Cloak of Triumph", "=ds=#s4#"};
		{ 8, 42068, "", "=q4=Deadly Gladiator's Cloak of Victory", "=ds=#s4#"};
		{ 11, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 12, 43959, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m7#", "", ""};
		{ 13, 44083, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m6#", "", ""};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Neck"]};
		{ 17, 42030, "", "=q4=Deadly Gladiator's Pendant of Ascendancy", "=ds=#s2#"};
		{ 18, 42032, "", "=q4=Deadly Gladiator's Pendant of Deliverance", "=ds=#s2#"};
		{ 19, 42029, "", "=q4=Deadly Gladiator's Pendant of Dominance", "=ds=#s2#"};
		{ 20, 42033, "", "=q4=Deadly Gladiator's Pendant of Salvation", "=ds=#s2#"};
		{ 21, 42031, "", "=q4=Deadly Gladiator's Pendant of Subjugation", "=ds=#s2#"};
		{ 22, 42027, "", "=q4=Deadly Gladiator's Pendant of Triumph", "=ds=#s2#"};
		{ 23, 42028, "", "=q4=Deadly Gladiator's Pendant of Victory", "=ds=#s2#"};
		{ 26, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Ring"]};
		{ 27, 42114, "", "=q4=Deadly Gladiator's Band of Ascendancy", "=ds=#s13#"};
		{ 28, 42115, "", "=q4=Deadly Gladiator's Band of Victory", "=ds=#s13#"};
		Prev = "VaultofArchavonEmalon7";
	};

	AtlasLoot_Data["VaultofArchavonEmalon125Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 2, 46132, "", "=q4=Conqueror's Kirin'dor Gauntlets", "=ds=#s9#, #a1#"};
		{ 3, 46133, "", "=q4=Conqueror's Kirin'dor Leggings", "=ds=#s11#, #a1#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 6, 46188, "", "=q4=Conqueror's Gloves of Sanctification", "=ds=#s9#, #a1#"};
		{ 7, 46195, "", "=q4=Conqueror's Leggings of Sanctification", "=ds=#s11#, #a1#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 10, 46163, "", "=q4=Conqueror's Handwraps of Sanctification", "=ds=#s9#, #a1#"};
		{ 11, 46170, "", "=q4=Conqueror's Pants of Sanctification", "=ds=#s11#, #a1#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 14, 46135, "", "=q4=Conqueror's Deathbringer Gloves", "=ds=#s9#, #a1#"};
		{ 15, 46139, "", "=q4=Conqueror's Deathbringer Leggings", "=ds=#s11#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 17, 41971, "", "=q4=Furious Gladiator's Silk Handguards", "=ds=#s9#, #a1#"};
		{ 18, 41959, "", "=q4=Furious Gladiator's Silk Trousers", "=ds=#s11#, #a1#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 21, 41874, "", "=q4=Furious Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1#"};
		{ 22, 41864, "", "=q4=Furious Gladiator's Mooncloth Leggings", "=ds=#s11#, #a1#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 25, 41940, "", "=q4=Furious Gladiator's Satin Gloves", "=ds=#s9#, #a1#"};
		{ 26, 41927, "", "=q4=Furious Gladiator's Satin Leggings", "=ds=#s11#, #a1#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 29, 42017, "", "=q4=Furious Gladiator's Felweave Handguards", "=ds=#s9#, #a1#"};
		{ 30, 42005, "", "=q4=Furious Gladiator's Felweave Trousers", "=ds=#s11#, #a1#"};
		Next = "VaultofArchavonEmalon225Man";
	};

	AtlasLoot_Data["VaultofArchavonEmalon225Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 2, 46189, "", "=q4=Conqueror's Nightsong Gloves", "=ds=#s9#, #a2#"};
		{ 3, 46192, "", "=q4=Conqueror's Nightsong Trousers", "=ds=#s11#, #a2#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 6, 46158, "", "=q4=Conqueror's Nightsong Handgrips", "=ds=#s9#, #a2#"};
		{ 7, 46160, "", "=q4=Conqueror's Nightsong Legguards", "=ds=#s11#, #a2#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 10, 46183, "", "=q4=Conqueror's Nightsong Handguards", "=ds=#s9#, #a2#"};
		{ 11, 46185, "", "=q4=Conqueror's Nightsong Leggings", "=ds=#s11#, #a2#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 14, 46124, "", "=q4=Conqueror's Terrorblade Gauntlets", "=ds=#s9#, #a2#"};
		{ 15, 46126, "", "=q4=Conqueror's Terrorblade Legplates", "=ds=#s11#, #a2#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 17, 41293, "", "=q4=Furious Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2#"};
		{ 18, 41304, "", "=q4=Furious Gladiator's Wyrmhide Legguards", "=ds=#s11#, #a2#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 21, 41773, "", "=q4=Furious Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2#"};
		{ 22, 41667, "", "=q4=Furious Gladiator's Dragonhide Legguards", "=ds=#s11#, #a2#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 25, 41287, "", "=q4=Furious Gladiator's Kodohide Gloves", "=ds=#s9#, #a2#"};
		{ 26, 41298, "", "=q4=Furious Gladiator's Kodohide Legguards", "=ds=#s11#, #a2#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 29, 41767, "", "=q4=Furious Gladiator's Leather Gloves", "=ds=#s9#, #a2#"};
		{ 30, 41655, "", "=q4=Furious Gladiator's Leather Legguards", "=ds=#s11#, #a2#"};
		Prev = "VaultofArchavonEmalon125Man";
		Next = "VaultofArchavonEmalon325Man";
	};

	AtlasLoot_Data["VaultofArchavonEmalon325Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 2, 46142, "", "=q4=Conqueror's Scourgestalker Handguards", "=ds=#s9#, #a3#"};
		{ 3, 46144, "", "=q4=Conqueror's Scourgestalker Legguards", "=ds=#s11#, #a3#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 6, 46207, "", "=q4=Conqueror's Worldbreaker Gloves", "=ds=#s9#, #a3#"};
		{ 7, 46210, "", "=q4=Conqueror's Worldbreaker Kilt", "=ds=#s11#, #a3#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 10, 46200, "", "=q4=Conqueror's Worldbreaker Grips", "=ds=#s9#, #a3#"};
		{ 11, 46208, "", "=q4=Conqueror's Worldbreaker War-Kilt", "=ds=#s11#, #a3#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 14, 46199, "", "=q4=Conqueror's Worldbreaker Handguards", "=ds=#s9#, #a3#"};
		{ 15, 46202, "", "=q4=Conqueror's Worldbreaker Legguards", "=ds=#s11#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 17, 41143, "", "=q4=Furious Gladiator's Chain Gauntlets", "=ds=#s9#, #a3#"};
		{ 18, 41205, "", "=q4=Furious Gladiator's Chain Leggings", "=ds=#s11#, #a3#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 21, 41007, "", "=q4=Furious Gladiator's Mail Gauntlets", "=ds=#s9#, #a3#"};
		{ 22, 41033, "", "=q4=Furious Gladiator's Mail Leggings", "=ds=#s11#, #a3#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 25, 41137, "", "=q4=Furious Gladiator's Linked Gauntlets", "=ds=#s9#, #a3#"};
		{ 26, 41199, "", "=q4=Furious Gladiator's Linked Leggings", "=ds=#s11#, #a3#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 29, 41001, "", "=q4=Furious Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3#"};
		{ 30, 41027, "", "=q4=Furious Gladiator's Ringmail Leggings", "=ds=#s11#, #a3#"};
		Prev = "VaultofArchavonEmalon225Man";
		Next = "VaultofArchavonEmalon425Man";
	};

	AtlasLoot_Data["VaultofArchavonEmalon425Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 2, 46113, "", "=q4=Conqueror's Darkruned Gauntlets", "=ds=#s9#, #a4#"};
		{ 3, 46116, "", "=q4=Conqueror's Darkruned Legplates", "=ds=#s11#, #a4#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
		{ 6, 46119, "", "=q4=Conqueror's Darkruned Handguards", "=ds=#s9#, #a4#"};
		{ 7, 46121, "", "=q4=Conqueror's Darkruned Legguards", "=ds=#s11#, #a4#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 10, 46179, "", "=q4=Conqueror's Aegis Gloves", "=ds=#s9#, #a4#"};
		{ 11, 46181, "", "=q4=Conqueror's Aegis Greaves", "=ds=#s11#, #a4#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 14, 46155, "", "=q4=Conqueror's Aegis Gauntlets", "=ds=#s9#, #a4#"};
		{ 15, 46153, "", "=q4=Conqueror's Aegis Legplates", "=ds=#s11#, #a4#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 17, 40809, "", "=q4=Furious Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4#"};
		{ 18, 40848, "", "=q4=Furious Gladiator's Dreadplate Legguards", "=ds=#s11#, #a4#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 25, 40927, "", "=q4=Furious Gladiator's Ornamented Gloves", "=ds=#s9#, #a4#"};
		{ 26, 40939, "", "=q4=Furious Gladiator's Ornamented Legplates", "=ds=#s11#, #a4#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 29, 40808, "", "=q4=Furious Gladiator's Scaled Gauntlets", "=ds=#s9#, #a4#"};
		{ 30, 40849, "", "=q4=Furious Gladiator's Scaled Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonEmalon325Man";
		Next = "VaultofArchavonEmalon525Man";
	};

	AtlasLoot_Data["VaultofArchavonEmalon525Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Protection"]};
		{ 2, 46174, "", "=q4=Conqueror's Aegis Handguards", "=ds=#s9#, #a4#"};
		{ 3, 46176, "", "=q4=Conqueror's Aegis Legguards", "=ds=#s11#, #a4#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 6, 46148, "", "=q4=Conqueror's Siegebreaker Gauntlets", "=ds=#s9#, #a4#"};
		{ 7, 46150, "", "=q4=Conqueror's Siegebreaker Legplates", "=ds=#s11#, #a4#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["Protection"]};
		{ 10, 46164, "", "=q4=Conqueror's Siegebreaker Handguards", "=ds=#s9#, #a4#"};
		{ 11, 46169, "", "=q4=Conqueror's Siegebreaker Legguards", "=ds=#s11#, #a4#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 21, 40807, "", "=q4=Furious Gladiator's Plate Gauntlets", "=ds=#s9#, #a4#"};
		{ 22, 40847, "", "=q4=Furious Gladiator's Plate Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonEmalon425Man";
		Next = "VaultofArchavonEmalon625Man";
	};

	AtlasLoot_Data["VaultofArchavonEmalon625Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Cloth"]};
		{ 2, 41909, "", "=q4=Furious Gladiator's Cuffs of Dominance",  "=ds=#s8#, #a1#"};
		{ 3, 41898, "", "=q4=Furious Gladiator's Cord of Dominance", "=ds=#s10#, #a1#"};
		{ 4, 41903, "", "=q4=Furious Gladiator's Slippers of Dominance",  "=ds=#s12#, #a1#"};
		{ 6, 41893, "", "=q4=Furious Gladiator's Cuffs of Salvation",  "=ds=#s8#, #a1#"};
		{ 7, 41881, "", "=q4=Furious Gladiator's Cord of Salvation",  "=ds=#s10#, #a1#"};
		{ 8, 41885, "", "=q4=Furious Gladiator's Slippers of Salvation",  "=ds=#s12#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Leather"]};
		{ 17, 41640, "", "=q4=Furious Gladiator's Armwraps of Dominance",  "=ds=#s8#, #a2#"};
		{ 18, 41630, "", "=q4=Furious Gladiator's Belt of Dominance",  "=ds=#s10#, #a2#"};
		{ 19, 41635, "", "=q4=Furious Gladiator's Boots of Dominance",  "=ds=#s12#, #a2#"};
		{ 21, 41625, "", "=q4=Furious Gladiator's Armwraps of Salvation",  "=ds=#s8#, #a2#"};
		{ 22, 41617, "", "=q4=Furious Gladiator's Belt of Salvation", "=ds=#s10#, #a2#"};
		{ 23, 41621, "", "=q4=Furious Gladiator's Boots of Salvation",  "=ds=#s12#, #a2#"};
		{ 25, 41840, "", "=q4=Furious Gladiator's Armwraps of Triumph",  "=ds=#s8#, #a2#"};
		{ 26, 41832, "", "=q4=Furious Gladiator's Belt of Triumph",  "=ds=#s10#, #a2#"};
		{ 27, 41836, "", "=q4=Furious Gladiator's Boots of Triumph",  "=ds=#s12#, #a2#"};
		Prev = "VaultofArchavonEmalon525Man";
		Next = "VaultofArchavonEmalon725Man";
	};

	AtlasLoot_Data["VaultofArchavonEmalon725Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Mail"]};
		{ 2, 41065, "", "=q4=Furious Gladiator's Wristguards of Dominance", "=ds=#s8#, #a3#"};
		{ 3, 41070, "", "=q4=Furious Gladiator's Waistguard of Dominance",  "=ds=#s10#, #a3#"};
		{ 4, 41075, "", "=q4=Furious Gladiator's Sabatons of Dominance", "=ds=#s12#, #a3#"};
		{ 6, 41060, "", "=q4=Furious Gladiator's Wristguards of Salvation", "=ds=#s8#, #a3#"};
		{ 7, 41051, "", "=q4=Furious Gladiator's Waistguard of Salvation",  "=ds=#s10#, #a3#"};
		{ 8, 41055, "", "=q4=Furious Gladiator's Sabatons of Salvation", "=ds=#s12#, #a3#"};
		{ 10, 41225, "", "=q4=Furious Gladiator's Wristguards of Triumph", "=ds=#s8#, #a3#"};
		{ 11, 41235, "", "=q4=Furious Gladiator's Waistguard of Triumph",  "=ds=#s10#, #a3#"};
		{ 12, 41230, "", "=q4=Furious Gladiator's Sabatons of Triumph", "=ds=#s12#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Plate"]};
		{ 17, 40983, "", "=q4=Furious Gladiator's Bracers of Salvation", "=ds=#s8#, #a4#"};
		{ 18, 40976, "", "=q4=Furious Gladiator's Girdle of Salvation", "=ds=#s10#, #a4#"};
		{ 19, 40977, "", "=q4=Furious Gladiator's Greaves of Salvation", "=ds=#s12#, #a4#"};
		{ 21, 40889, "", "=q4=Furious Gladiator's Bracers of Triumph", "=ds=#s8#, #a4#"};
		{ 22, 40881, "", "=q4=Furious Gladiator's Girdle of Triumph", "=ds=#s10#, #a4#"};
		{ 23, 40882, "", "=q4=Furious Gladiator's Greaves of Triumph", "=ds=#s12#, #a4#"};
		Prev = "VaultofArchavonEmalon625Man";
		Next = "VaultofArchavonEmalon825Man";
	};

	AtlasLoot_Data["VaultofArchavonEmalon825Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Back"]};
		{ 2, 42071, "", "=q4=Furious Gladiator's Cloak of Ascendancy", "=ds=#s4#"};
		{ 3, 42073, "", "=q4=Furious Gladiator's Cloak of Deliverance", "=ds=#s4#"};
		{ 4, 42069, "", "=q4=Furious Gladiator's Cloak of Dominance", "=ds=#s4#"};
		{ 5, 42072, "", "=q4=Furious Gladiator's Cloak of Salvation", "=ds=#s4#"};
		{ 6, 42070, "", "=q4=Furious Gladiator's Cloak of Subjugation", "=ds=#s4#"};
		{ 7, 42074, "", "=q4=Furious Gladiator's Cloak of Triumph", "=ds=#s4#"};
		{ 8, 42075, "", "=q4=Furious Gladiator's Cloak of Victory", "=ds=#s4#"};
		{ 11, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 12, 43959, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m7#", "", ""};
		{ 13, 44083, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m6#", "", ""};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Neck"]};
		{ 17, 42037, "", "=q4=Furious Gladiator's Pendant of Ascendancy", "=ds=#s2#"};
		{ 18, 42039, "", "=q4=Furious Gladiator's Pendant of Deliverance", "=ds=#s2#"};
		{ 19, 42036, "", "=q4=Furious Gladiator's Pendant of Dominance", "=ds=#s2#"};
		{ 20, 42040, "", "=q4=Furious Gladiator's Pendant of Salvation", "=ds=#s2#"};
		{ 21, 42038, "", "=q4=Furious Gladiator's Pendant of Subjugation", "=ds=#s2#"};
		{ 22, 46373, "", "=q4=Furious Gladiator's Pendant of Sundering", "=ds=#s2#"};
		{ 23, 42034, "", "=q4=Furious Gladiator's Pendant of Triumph", "=ds=#s2#"};
		{ 24, 42035, "", "=q4=Furious Gladiator's Pendant of Victory", "=ds=#s2#"};
		{ 26, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Ring"]};
		{ 27, 42116, "", "=q4=Furious Gladiator's Band of Dominance", "=ds=#s13#"};
		{ 28, 42117, "", "=q4=Furious Gladiator's Band of Triumph", "=ds=#s13#"};
		Prev = "VaultofArchavonEmalon725Man";
	};

	AtlasLoot_Data["VaultofArchavonKoralon1_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 2, 47752, "", "=q4=Khadgar's Gauntlets of Conquest", "=ds=#s9#, #a1#"};
		{ 3, 47750, "", "=q4=Khadgar's Leggings of Conquest", "=ds=#s11#, #a1#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 6, 47982, "", "=q4=Velen's Gloves of Conquest", "=ds=#s9#, #a1#"};
		{ 7, 47980, "", "=q4=Velen's Leggings of Conquest", "=ds=#s11#, #a1#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 10, 48072, "", "=q4=Velen's Handwraps of Conquest", "=ds=#s9#, #a1#"};
		{ 11, 48074, "", "=q4=Velen's Pants of Conquest", "=ds=#s11#, #a1#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 14, 47783, "", "=q4=Kel'Thuzad's Gloves of Conquest", "=ds=#s9#, #a1#"};
		{ 15, 47785, "", "=q4=Kel'Thuzad's Leggings of Conquest", "=ds=#s11#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 17, 41971, "", "=q4=Furious Gladiator's Silk Handguards", "=ds=#s9#, #a1#"};
		{ 18, 41959, "", "=q4=Furious Gladiator's Silk Trousers", "=ds=#s11#, #a1#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 21, 41874, "", "=q4=Furious Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1#"};
		{ 22, 41864, "", "=q4=Furious Gladiator's Mooncloth Leggings", "=ds=#s11#, #a1#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 25, 41940, "", "=q4=Furious Gladiator's Satin Gloves", "=ds=#s9#, #a1#"};
		{ 26, 41927, "", "=q4=Furious Gladiator's Satin Leggings", "=ds=#s11#, #a1#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 29, 42017, "", "=q4=Furious Gladiator's Felweave Handguards", "=ds=#s9#, #a1#"};
		{ 30, 42005, "", "=q4=Furious Gladiator's Felweave Trousers", "=ds=#s11#, #a1#"};
		Next = "VaultofArchavonKoralon2_A";
	};

	AtlasLoot_Data["VaultofArchavonKoralon2_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 2, 48162, "", "=q4=Stormrage's Gloves of Conquest", "=ds=#s9#, #a2#"};
		{ 3, 48160, "", "=q4=Stormrage's Trousers of Conquest", "=ds=#s11#, #a2#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 6, 48213, "", "=q4=Stormrage's Handgrips of Conquest", "=ds=#s9#, #a2#"};
		{ 7, 48215, "", "=q4=Stormrage's Legguards of Conquest", "=ds=#s11#, #a2#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 10, 48132, "", "=q4=Stormrage's Handguards of Conquest", "=ds=#s9#, #a2#"};
		{ 11, 48130, "", "=q4=Stormrage's Leggings of Conquest", "=ds=#s11#, #a2#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 14, 48222, "", "=q4=VanCleef's Gauntlets of Conquest", "=ds=#s9#, #a2#"};
		{ 15, 48220, "", "=q4=VanCleef's Legplates of Conquest", "=ds=#s11#, #a2#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 17, 41293, "", "=q4=Furious Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2#"};
		{ 18, 41304, "", "=q4=Furious Gladiator's Wyrmhide Legguards", "=ds=#s11#, #a2#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 21, 41773, "", "=q4=Furious Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2#"};
		{ 22, 41667, "", "=q4=Furious Gladiator's Dragonhide Legguards", "=ds=#s11#, #a2#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 25, 41287, "", "=q4=Furious Gladiator's Kodohide Gloves", "=ds=#s9#, #a2#"};
		{ 26, 41298, "", "=q4=Furious Gladiator's Kodohide Legguards", "=ds=#s11#, #a2#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 29, 41767, "", "=q4=Furious Gladiator's Leather Gloves", "=ds=#s9#, #a2#"};
		{ 30, 41655, "", "=q4=Furious Gladiator's Leather Legguards", "=ds=#s11#, #a2#"};
		Prev = "VaultofArchavonKoralon1_A";
		Next = "VaultofArchavonKoralon3_A";
	};

	AtlasLoot_Data["VaultofArchavonKoralon3_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 2, 48254, "", "=q4=Windrunner's Handguards of Conquest", "=ds=#s9#, #a3#"};
		{ 3, 48252, "", "=q4=Windrunner's Legguards of Conquest", "=ds=#s11#, #a3#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 6, 48312, "", "=q4=Nobundo's Gloves of Conquest", "=ds=#s9#, #a3#"};
		{ 7, 48314, "", "=q4=Nobundo's Kilt of Conquest", "=ds=#s11#, #a3#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 10, 48342, "", "=q4=Nobundo's Grips of Conquest", "=ds=#s9#, #a3#"};
		{ 11, 48344, "", "=q4=Nobundo's War-Kilt of Conquest", "=ds=#s11#, #a3#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 14, 48284, "", "=q4=Nobundo's Handguards of Conquest", "=ds=#s9#, #a3#"};
		{ 15, 48282, "", "=q4=Nobundo's Legguards of Conquest", "=ds=#s11#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 17, 41143, "", "=q4=Furious Gladiator's Chain Gauntlets", "=ds=#s9#, #a3#"};
		{ 18, 41205, "", "=q4=Furious Gladiator's Chain Leggings", "=ds=#s11#, #a3#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 21, 41007, "", "=q4=Furious Gladiator's Mail Gauntlets", "=ds=#s9#, #a3#"};
		{ 22, 41033, "", "=q4=Furious Gladiator's Mail Leggings", "=ds=#s11#, #a3#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 25, 41137, "", "=q4=Furious Gladiator's Linked Gauntlets", "=ds=#s9#, #a3#"};
		{ 26, 41199, "", "=q4=Furious Gladiator's Linked Leggings", "=ds=#s11#, #a3#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 29, 41001, "", "=q4=Furious Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3#"};
		{ 30, 41027, "", "=q4=Furious Gladiator's Ringmail Leggings", "=ds=#s11#, #a3#"};
		Prev = "VaultofArchavonKoralon2_A";
		Next = "VaultofArchavonKoralon4_A";
	};

	AtlasLoot_Data["VaultofArchavonKoralon4_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 2, 48480, "", "=q4=Thassarian's Gauntlets of Conquest", "=ds=#s9#, #a4#"};
		{ 3, 48476, "", "=q4=Thassarian's Legplates of Conquest", "=ds=#s11#, #a4#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
		{ 6, 48537, "", "=q4=Thassarian's Handguards of Conquest", "=ds=#s9#, #a4#"};
		{ 7, 48533, "", "=q4=Thassarian's Legguards of Conquest", "=ds=#s11#, #a4#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 10, 48574, "", "=q4=Turalyon's Gloves of Conquest", "=ds=#s9#, #a4#"};
		{ 11, 48568, "", "=q4=Turalyon's Greaves of Conquest", "=ds=#s11#, #a4#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 14, 48603, "", "=q4=Turalyon's Gauntlets of Conquest", "=ds=#s9#, #a4#"};
		{ 15, 48605, "", "=q4=Turalyon's Legplates of Conquest", "=ds=#s11#, #a4#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 17, 40809, "", "=q4=Furious Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4#"};
		{ 18, 40848, "", "=q4=Furious Gladiator's Dreadplate Legguards", "=ds=#s11#, #a4#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 25, 40927, "", "=q4=Furious Gladiator's Ornamented Gloves", "=ds=#s9#, #a4#"};
		{ 26, 40939, "", "=q4=Furious Gladiator's Ornamented Legplates", "=ds=#s11#, #a4#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 29, 40808, "", "=q4=Furious Gladiator's Scaled Gauntlets", "=ds=#s9#, #a4#"};
		{ 30, 40849, "", "=q4=Furious Gladiator's Scaled Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonKoralon3_A";
		Next = "VaultofArchavonKoralon5_A";
	};

	AtlasLoot_Data["VaultofArchavonKoralon5_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Protection"]};
		{ 2, 48633, "", "=q4=Turalyon's Handguards of Conquest", "=ds=#s9#, #a4#"};
		{ 3, 48635, "", "=q4=Turalyon's Legguards of Conquest","=ds=#s11#, #a4#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 6, 48375, "", "=q4=Wrynn's Gauntlets of Conquest", "=ds=#s9#, #a4#"};
		{ 7, 48373, "", "=q4=Wrynn's Legplates of Conquest", "=ds=#s11#, #a4#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["Protection"]};
		{ 10, 48449, "", "=q4=Wrynn's Handguards of Conquest", "=ds=#s9#, #a4#"};
		{ 11, 48445, "", "=q4=Wrynn's Legguards of Conquest", "=ds=#s11#, #a4#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 21, 40807, "", "=q4=Furious Gladiator's Plate Gauntlets", "=ds=#s9#, #a4#"};
		{ 22, 40847, "", "=q4=Furious Gladiator's Plate Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonKoralon4_A";
		Next = "VaultofArchavonKoralon6_A";
	};

	AtlasLoot_Data["VaultofArchavonKoralon6_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Cloth"]};
		{ 2, 41909, "", "=q4=Furious Gladiator's Cuffs of Dominance",  "=ds=#s8#, #a1#"};
		{ 3, 41898, "", "=q4=Furious Gladiator's Cord of Dominance", "=ds=#s10#, #a1#"};
		{ 4, 41903, "", "=q4=Furious Gladiator's Slippers of Dominance",  "=ds=#s12#, #a1#"};
		{ 6, 41893, "", "=q4=Furious Gladiator's Cuffs of Salvation",  "=ds=#s8#, #a1#"};
		{ 7, 41881, "", "=q4=Furious Gladiator's Cord of Salvation",  "=ds=#s10#, #a1#"};
		{ 8, 41885, "", "=q4=Furious Gladiator's Slippers of Salvation",  "=ds=#s12#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Leather"]};
		{ 17, 41640, "", "=q4=Furious Gladiator's Armwraps of Dominance",  "=ds=#s8#, #a2#"};
		{ 18, 41630, "", "=q4=Furious Gladiator's Belt of Dominance",  "=ds=#s10#, #a2#"};
		{ 19, 41635, "", "=q4=Furious Gladiator's Boots of Dominance",  "=ds=#s12#, #a2#"};
		{ 21, 41625, "", "=q4=Furious Gladiator's Armwraps of Salvation",  "=ds=#s8#, #a2#"};
		{ 22, 41617, "", "=q4=Furious Gladiator's Belt of Salvation", "=ds=#s10#, #a2#"};
		{ 23, 41621, "", "=q4=Furious Gladiator's Boots of Salvation",  "=ds=#s12#, #a2#"};
		{ 25, 41840, "", "=q4=Furious Gladiator's Armwraps of Triumph",  "=ds=#s8#, #a2#"};
		{ 26, 41832, "", "=q4=Furious Gladiator's Belt of Triumph",  "=ds=#s10#, #a2#"};
		{ 27, 41836, "", "=q4=Furious Gladiator's Boots of Triumph",  "=ds=#s12#, #a2#"};
		Prev = "VaultofArchavonKoralon5_A";
		Next = "VaultofArchavonKoralon7_A";
	};

	AtlasLoot_Data["VaultofArchavonKoralon7_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Mail"]};
		{ 2, 41065, "", "=q4=Furious Gladiator's Wristguards of Dominance", "=ds=#s8#, #a3#"};
		{ 3, 41070, "", "=q4=Furious Gladiator's Waistguard of Dominance",  "=ds=#s10#, #a3#"};
		{ 4, 41075, "", "=q4=Furious Gladiator's Sabatons of Dominance", "=ds=#s12#, #a3#"};
		{ 6, 41060, "", "=q4=Furious Gladiator's Wristguards of Salvation", "=ds=#s8#, #a3#"};
		{ 7, 41051, "", "=q4=Furious Gladiator's Waistguard of Salvation",  "=ds=#s10#, #a3#"};
		{ 8, 41055, "", "=q4=Furious Gladiator's Sabatons of Salvation", "=ds=#s12#, #a3#"};
		{ 10, 41225, "", "=q4=Furious Gladiator's Wristguards of Triumph", "=ds=#s8#, #a3#"};
		{ 11, 41235, "", "=q4=Furious Gladiator's Waistguard of Triumph",  "=ds=#s10#, #a3#"};
		{ 12, 41230, "", "=q4=Furious Gladiator's Sabatons of Triumph", "=ds=#s12#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Plate"]};
		{ 17, 40983, "", "=q4=Furious Gladiator's Bracers of Salvation", "=ds=#s8#, #a4#"};
		{ 18, 40976, "", "=q4=Furious Gladiator's Girdle of Salvation", "=ds=#s10#, #a4#"};
		{ 19, 40977, "", "=q4=Furious Gladiator's Greaves of Salvation", "=ds=#s12#, #a4#"};
		{ 21, 40889, "", "=q4=Furious Gladiator's Bracers of Triumph", "=ds=#s8#, #a4#"};
		{ 22, 40881, "", "=q4=Furious Gladiator's Girdle of Triumph", "=ds=#s10#, #a4#"};
		{ 23, 40882, "", "=q4=Furious Gladiator's Greaves of Triumph", "=ds=#s12#, #a4#"};
		Prev = "VaultofArchavonKoralon6_A";
		Next = "VaultofArchavonKoralon8_A";
	};

	AtlasLoot_Data["VaultofArchavonKoralon8_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Back"]};
		{ 2, 42071, "", "=q4=Furious Gladiator's Cloak of Ascendancy", "=ds=#s4#"};
		{ 3, 42073, "", "=q4=Furious Gladiator's Cloak of Deliverance", "=ds=#s4#"};
		{ 4, 42069, "", "=q4=Furious Gladiator's Cloak of Dominance", "=ds=#s4#"};
		{ 5, 42072, "", "=q4=Furious Gladiator's Cloak of Salvation", "=ds=#s4#"};
		{ 6, 42070, "", "=q4=Furious Gladiator's Cloak of Subjugation", "=ds=#s4#"};
		{ 7, 42074, "", "=q4=Furious Gladiator's Cloak of Triumph", "=ds=#s4#"};
		{ 8, 42075, "", "=q4=Furious Gladiator's Cloak of Victory", "=ds=#s4#"};
		{ 11, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 12, 43959, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m7#", "", ""};
		{ 13, 44083, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m6#", "", ""};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Neck"]};
		{ 17, 42037, "", "=q4=Furious Gladiator's Pendant of Ascendancy", "=ds=#s2#"};
		{ 18, 42039, "", "=q4=Furious Gladiator's Pendant of Deliverance", "=ds=#s2#"};
		{ 19, 42036, "", "=q4=Furious Gladiator's Pendant of Dominance", "=ds=#s2#"};
		{ 20, 42040, "", "=q4=Furious Gladiator's Pendant of Salvation", "=ds=#s2#"};
		{ 21, 42038, "", "=q4=Furious Gladiator's Pendant of Subjugation", "=ds=#s2#"};
		{ 22, 46373, "", "=q4=Furious Gladiator's Pendant of Sundering", "=ds=#s2#"};
		{ 23, 42034, "", "=q4=Furious Gladiator's Pendant of Triumph", "=ds=#s2#"};
		{ 24, 42035, "", "=q4=Furious Gladiator's Pendant of Victory", "=ds=#s2#"};
		{ 26, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Ring"]};
		{ 27, 42116, "", "=q4=Furious Gladiator's Band of Dominance", "=ds=#s13#"};
		{ 28, 42117, "", "=q4=Furious Gladiator's Band of Triumph", "=ds=#s13#"};
		Prev = "VaultofArchavonKoralon7_A";
	};

	AtlasLoot_Data["VaultofArchavonKoralon125Man_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 2, 47753, "", "=q4=Khadgar's Gauntlets of Triumph", "=ds=#s9#, #a1#"};
		{ 3, 47755, "", "=q4=Khadgar's Leggings of Triumph", "=ds=#s11#, #a1#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 6, 47983, "", "=q4=Velen's Gloves of Triumph", "=ds=#s9#, #a1#"};
		{ 7, 47985, "", "=q4=Velen's Leggings of Triumph", "=ds=#s11#, #a1#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 10, 48077, "", "=q4=Velen's Handwraps of Triumph", "=ds=#s9#, #a1#"};
		{ 11, 48079, "", "=q4=Velen's Pants of Triumph", "=ds=#s11#, #a1#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 14, 47782, "", "=q4=Kel'Thuzad's Gloves of Triumph", "=ds=#s9#, #a1#"};
		{ 15, 47780, "", "=q4=Kel'Thuzad's Leggings of Triumph", "=ds=#s11#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 17, 41972, "", "=q4=Relentless Gladiator's Silk Handguards", "=ds=#s9#, #a1#"};
		{ 18, 41960, "", "=q4=Relentless Gladiator's Silk Trousers", "=ds=#s11#, #a1#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 21, 41875, "", "=q4=Relentless Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1#"};
		{ 22, 41865, "", "=q4=Relentless Gladiator's Mooncloth Leggings", "=ds=#s11#, #a1#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 25, 41941, "", "=q4=Relentless Gladiator's Satin Gloves", "=ds=#s9#, #a1#"};
		{ 26, 41928, "", "=q4=Relentless Gladiator's Satin Leggings", "=ds=#s11#, #a1#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 29, 42018, "", "=q4=Relentless Gladiator's Felweave Handguards", "=ds=#s9#, #a1#"};
		{ 30, 42006, "", "=q4=Relentless Gladiator's Felweave Trousers", "=ds=#s11#, #a1#"};
		Next = "VaultofArchavonKoralon225Man_A";
	};

	AtlasLoot_Data["VaultofArchavonKoralon225Man_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 2, 48163, "", "=q4=Stormrage's Gloves of Triumph", "=ds=#s9#, #a2#"};
		{ 3, 48165, "", "=q4=Stormrage's Trousers of Triumph", "=ds=#s11#, #a2#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 6, 48212, "", "=q4=Stormrage's Handgrips of Triumph", "=ds=#s9#, #a2#"};
		{ 7, 48210, "", "=q4=Stormrage's Legguards of Triumph", "=ds=#s11#, #a2#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 10, 48133, "", "=q4=Stormrage's Handguards of Triumph", "=ds=#s9#, #a2#"};
		{ 11, 48135, "", "=q4=Stormrage's Leggings of Triumph", "=ds=#s11#, #a2#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 14, 48224, "", "=q4=VanCleef's Gauntlets of Triumph", "=ds=#s9#, #a2#"};
		{ 15, 48226, "", "=q4=VanCleef's Legplates of Triumph", "=ds=#s11#, #a2#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 17, 41294, "", "=q4=Relentless Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2#"};
		{ 18, 41305, "", "=q4=Relentless Gladiator's Wyrmhide Legguards", "=ds=#s11#, #a2#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 21, 41774, "", "=q4=Relentless Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2#"};
		{ 22, 41668, "", "=q4=Relentless Gladiator's Dragonhide Legguards", "=ds=#s11#, #a2#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 25, 41288, "", "=q4=Relentless Gladiator's Kodohide Gloves", "=ds=#s9#, #a2#"};
		{ 26, 41299, "", "=q4=Relentless Gladiator's Kodohide Legguards", "=ds=#s11#, #a2#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 29, 41768, "", "=q4=Relentless Gladiator's Leather Gloves", "=ds=#s9#, #a2#"};
		{ 30, 41656, "", "=q4=Relentless Gladiator's Leather Legguards", "=ds=#s11#, #a2#"};
		Prev = "VaultofArchavonKoralon125Man_A";
		Next = "VaultofArchavonKoralon325Man_A";
	};

	AtlasLoot_Data["VaultofArchavonKoralon325Man_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 2, 48256, "", "=q4=Windrunner's Handguards of Triumph", "=ds=#s9#, #a3#"};
		{ 3, 48258, "", "=q4=Windrunner's Legguards of Triumph", "=ds=#s11#, #a3#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 6, 48317, "", "=q4=Nobundo's Gloves of Triumph", "=ds=#s9#, #a3#"};
		{ 7, 48319, "", "=q4=Nobundo's Kilt of Triumph", "=ds=#s11#, #a3#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 10, 48347, "", "=q4=Nobundo's Grips of Triumph", "=ds=#s9#, #a3#"};
		{ 11, 48349, "", "=q4=Nobundo's War-Kilt of Triumph", "=ds=#s11#, #a3#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 14, 48286, "", "=q4=Nobundo's Handguards of Triumph", "=ds=#s9#, #a3#"};
		{ 15, 48288, "", "=q4=Nobundo's Legguards of Triumph", "=ds=#s11#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 17, 41144, "", "=q4=Relentless Gladiator's Chain Gauntlets", "=ds=#s9#, #a3#"};
		{ 18, 41206, "", "=q4=Relentless Gladiator's Chain Leggings", "=ds=#s11#, #a3#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 21, 41008, "", "=q4=Relentless Gladiator's Mail Gauntlets", "=ds=#s9#, #a3#"};
		{ 22, 41034, "", "=q4=Relentless Gladiator's Mail Leggings", "=ds=#s11#, #a3#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 25, 41138, "", "=q4=Relentless Gladiator's Linked Gauntlets", "=ds=#s9#, #a3#"};
		{ 26, 41200, "", "=q4=Relentless Gladiator's Linked Leggings", "=ds=#s11#, #a3#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 29, 41002, "", "=q4=Relentless Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3#"};
		{ 30, 41028, "", "=q4=Relentless Gladiator's Ringmail Leggings", "=ds=#s11#, #a3#"};
		Prev = "VaultofArchavonKoralon225Man_A";
		Next = "VaultofArchavonKoralon425Man_A";
	};

	AtlasLoot_Data["VaultofArchavonKoralon425Man_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 2, 48482, "", "=q4=Thassarian's Gauntlets of Triumph", "=ds=#s9#, #a4#"};
		{ 3, 48484, "", "=q4=Thassarian's Legplates of Triumph", "=ds=#s11#, #a4#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
		{ 6, 48539, "", "=q4=Thassarian's Handguards of Triumph", "=ds=#s9#, #a4#"};
		{ 7, 48541, "", "=q4=Thassarian's Legguards of Triumph", "=ds=#s11#, #a4#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 10, 48576, "", "=q4=Turalyon's Gloves of Triumph", "=ds=#s9#, #a4#"};
		{ 11, 48578, "", "=q4=Turalyon's Greaves of Triumph", "=ds=#s11#, #a4#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 14, 48608, "", "=q4=Turalyon's Gauntlets of Triumph", "=ds=#s9#, #a4#"};
		{ 15, 48610, "", "=q4=Turalyon's Legplates of Triumph", "=ds=#s11#, #a4#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 17, 40811, "", "=q4=Relentless Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4#"};
		{ 18, 40851, "", "=q4=Relentless Gladiator's Dreadplate Legguards", "=ds=#s11#, #a4#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 25, 40928, "", "=q4=Relentless Gladiator's Ornamented Gloves", "=ds=#s9#, #a4#"};
		{ 26, 40940, "", "=q4=Relentless Gladiator's Ornamented Legplates", "=ds=#s11#, #a4#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 29, 40812, "", "=q4=Relentless Gladiator's Scaled Gauntlets", "=ds=#s9#, #a4#"};
		{ 30, 40852, "", "=q4=Relentless Gladiator's Scaled Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonKoralon325Man_A";
		Next = "VaultofArchavonKoralon525Man_A";
	};

	AtlasLoot_Data["VaultofArchavonKoralon525Man_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Protection"]};
		{ 2, 48640, "", "=q4=Turalyon's Handguards of Triumph", "=ds=#s9#, #a4#"};
		{ 3, 48638, "", "=q4=Turalyon's Legguards of Triumph", "=ds=#s11#, #a4#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 6, 48377, "", "=q4=Wrynn's Gauntlets of Triumph", "=ds=#s9#, #a4#"};
		{ 7, 48379, "", "=q4=Wrynn's Legplates of Triumph", "=ds=#s11#, #a4#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["Protection"]};
		{ 10, 48452, "", "=q4=Wrynn's Handguards of Triumph", "=ds=#s9#, #a4#"};
		{ 11, 48446, "", "=q4=Wrynn's Legguards of Triumph", "=ds=#s11#, #a4#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 21, 40810, "", "=q4=Relentless Gladiator's Plate Gauntlets", "=ds=#s9#, #a4#"};
		{ 22, 40850, "", "=q4=Relentless Gladiator's Plate Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonKoralon425Man_A";
		Next = "VaultofArchavonKoralon625Man_A";
	};

	AtlasLoot_Data["VaultofArchavonKoralon625Man_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Cloth"]};
		{ 2, 41910, "", "=q4=Relentless Gladiator's Cuffs of Dominance", "=ds=#s8#, #a1#"};
		{ 3, 41899, "", "=q4=Relentless Gladiator's Cord of Dominance", "=ds=#s10#, #a1#"};
		{ 4, 41904, "", "=q4=Relentless Gladiator's Treads of Dominance", "=ds=#s12#, #a1#"};
		{ 6, 41894, "", "=q4=Relentless Gladiator's Cuffs of Salvation", "=ds=#s8#, #a1#"};
		{ 7, 41882, "", "=q4=Relentless Gladiator's Cord of Salvation", "=ds=#s10#, #a1#"};
		{ 8, 41886, "", "=q4=Relentless Gladiator's Treads of Salvation", "=ds=#s12#, #a1#"};
		{ 10, 49181, "", "=q4=Relentless Gladiator's Cuffs of Alacrity", "=ds=#s8#, #a1#"};
		{ 11, 49179, "", "=q4=Relentless Gladiator's Cord of Alacrity", "=ds=#s10#, #a1#"};
		{ 12, 49183, "", "=q4=Relentless Gladiator's Treads of Alacrity", "=ds=#s12#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Leather"]};
		{ 17, 41641, "", "=q4=Relentless Gladiator's Armwraps of Dominance", "=ds=#s8#, #a2#"};
		{ 18, 41631, "", "=q4=Relentless Gladiator's Belt of Dominance", "=ds=#s10#, #a2#"};
		{ 19, 41636, "", "=q4=Relentless Gladiator's Boots of Dominance", "=ds=#s12#, #a2#"};
		{ 21, 41626, "", "=q4=Relentless Gladiator's Armwraps of Salvation", "=ds=#s8#, #a2#"};
		{ 22, 41618, "", "=q4=Relentless Gladiator's Belt of Salvation", "=ds=#s10#, #a2#"};
		{ 23, 41622, "", "=q4=Relentless Gladiator's Boots of Salvation", "=ds=#s12#, #a2#"};
		{ 25, 41841, "", "=q4=Relentless Gladiator's Armwraps of Triumph", "=ds=#s8#, #a2#"};
		{ 26, 41833, "", "=q4=Relentless Gladiator's Belt of Triumph", "=ds=#s10#, #a2#"};
		{ 27, 41837, "", "=q4=Relentless Gladiator's Boots of Triumph", "=ds=#s12#, #a2#"};
		Prev = "VaultofArchavonKoralon525Man_A";
		Next = "VaultofArchavonKoralon725Man_A";
	};

	AtlasLoot_Data["VaultofArchavonKoralon725Man_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Mail"]};
		{ 2, 41066, "", "=q4=Relentless Gladiator's Wristguards of Dominance", "=ds=#s8#, #a3#"};
		{ 3, 41071, "", "=q4=Relentless Gladiator's Waistguard of Dominance","=ds=#s10#, #a3#"};
		{ 4, 41076, "", "=q4=Relentless Gladiator's Sabatons of Dominance", "=ds=#s12#, #a3#"};
		{ 6, 41061, "", "=q4=Relentless Gladiator's Wristguards of Salvation", "=ds=#s8#, #a3#"};
		{ 7, 41052, "", "=q4=Relentless Gladiator's Waistguard of Salvation", "=ds=#s10#, #a3#"};
		{ 8, 41056, "", "=q4=Relentless Gladiator's Sabatons of Salvation", "=ds=#s12#, #a3#"};
		{ 10, 41226, "", "=q4=Relentless Gladiator's Wristguards of Triumph", "=ds=#s8#, #a3#"};
		{ 11, 41236, "", "=q4=Relentless Gladiator's Waistguard of Triumph", "=ds=#s10#, #a3#"};
		{ 12, 41231, "", "=q4=Relentless Gladiator's Sabatons of Triumph", "=ds=#s12#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Plate"]};
		{ 17, 40984, "", "=q4=Relentless Gladiator's Bracers of Salvation","=ds=#s8#, #a4#"};
		{ 18, 40978, "", "=q4=Relentless Gladiator's Girdle of Salvation", "=ds=#s10#, #a4#"};
		{ 19, 40979, "", "=q4=Relentless Gladiator's Greaves of Salvation", "=ds=#s12#, #a4#"};
		{ 21, 40890, "", "=q4=Relentless Gladiator's Bracers of Triumph", "=ds=#s8#, #a4#"};
		{ 22, 40883, "", "=q4=Relentless Gladiator's Girdle of Triumph", "=ds=#s10#, #a4#"};
		{ 23, 40884, "", "=q4=Relentless Gladiator's Greaves of Triumph", "=ds=#s12#, #a4#"};
		Prev = "VaultofArchavonKoralon625Man_A";
		Next = "VaultofArchavonKoralon825Man_A";
	};

	AtlasLoot_Data["VaultofArchavonKoralon825Man_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Back"]};
		{ 2, 42078, "", "=q4=Relentless Gladiator's Cloak of Ascendancy", "=ds=#s4#"};
		{ 3, 42080, "", "=q4=Relentless Gladiator's Cloak of Deliverance", "=ds=#s4#"};
		{ 4, 42076, "", "=q4=Relentless Gladiator's Cloak of Dominance", "=ds=#s4#"};
		{ 5, 42079, "", "=q4=Relentless Gladiator's Cloak of Salvation", "=ds=#s4#"};
		{ 6, 42077, "", "=q4=Relentless Gladiator's Cloak of Subjugation", "=ds=#s4#"};
		{ 7, 42081, "", "=q4=Relentless Gladiator's Cloak of Triumph", "=ds=#s4#"};
		{ 8, 42082, "", "=q4=Relentless Gladiator's Cloak of Victory", "=ds=#s4#"};
		{ 11, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 12, 43959, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m7#", "", ""};
		{ 13, 44083, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m6#", "", ""};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Neck"]};
		{ 17, 42044, "", "=q4=Relentless Gladiator's Pendant of Ascendancy", "=ds=#s2#"};
		{ 18, 42046, "", "=q4=Relentless Gladiator's Pendant of Deliverance", "=ds=#s2#"};
		{ 19, 42043, "", "=q4=Relentless Gladiator's Pendant of Dominance", "=ds=#s2#"};
		{ 20, 42047, "", "=q4=Relentless Gladiator's Pendant of Salvation", "=ds=#s2#"};
		{ 21, 42045, "", "=q4=Relentless Gladiator's Pendant of Subjugation", "=ds=#s2#"};
		{ 22, 46374, "", "=q4=Relentless Gladiator's Pendant of Sundering", "=ds=#s2#"};
		{ 23, 42041, "", "=q4=Relentless Gladiator's Pendant of Triumph", "=ds=#s2#"};
		{ 24, 42042, "", "=q4=Relentless Gladiator's Pendant of Victory", "=ds=#s2#"};
		{ 26, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Ring"]};
		{ 27, 42118, "", "=q4=Relentless Gladiator's Band of Ascendancy", "=ds=#s13#"};
		{ 28, 42119, "", "=q4=Relentless Gladiator's Band of Victory", "=ds=#s13#"};
		Prev = "VaultofArchavonKoralon725Man_A";
	};

	AtlasLoot_Data["VaultofArchavonKoralon1_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 2, 47773, "", "=q4=Sunstrider's Gauntlets of Conquest", "=ds=#s9#, #a1#"};
		{ 3, 47775, "", "=q4=Sunstrider's Leggings of Conquest", "=ds=#s11#, #a1#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 6, 48067, "", "=q4=Zabra's Gloves of Conquest", "=ds=#s9#, #a1#"};
		{ 7, 48069, "", "=q4=Zabra's Leggings of Conquest", "=ds=#s11#, #a1#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 10, 48097, "", "=q4=Zabra's Handwraps of Conquest", "=ds=#s9#, #a1#"};
		{ 11, 48099, "", "=q4=Zabra's Pants of Conquest", "=ds=#s11#, #a1#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 14, 47802, "", "=q4=Gul'dan's Gloves of Conquest", "=ds=#s9#, #a1#"};
		{ 15, 47800, "", "=q4=Gul'dan's Leggings of Conquest", "=ds=#s11#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 17, 41971, "", "=q4=Furious Gladiator's Silk Handguards", "=ds=#s9#, #a1#"};
		{ 18, 41959, "", "=q4=Furious Gladiator's Silk Trousers", "=ds=#s11#, #a1#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 21, 41874, "", "=q4=Furious Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1#"};
		{ 22, 41864, "", "=q4=Furious Gladiator's Mooncloth Leggings", "=ds=#s11#, #a1#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 25, 41940, "", "=q4=Furious Gladiator's Satin Gloves", "=ds=#s9#, #a1#"};
		{ 26, 41927, "", "=q4=Furious Gladiator's Satin Leggings", "=ds=#s11#, #a1#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 29, 42017, "", "=q4=Furious Gladiator's Felweave Handguards", "=ds=#s9#, #a1#"};
		{ 30, 42005, "", "=q4=Furious Gladiator's Felweave Trousers", "=ds=#s11#, #a1#"};
		Next = "VaultofArchavonKoralon2_H";
	};

	AtlasLoot_Data["VaultofArchavonKoralon2_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 2, 48183, "", "=q4=Runetotem's Gloves of Conquest", "=ds=#s9#, #a2#"};
		{ 3, 48185, "", "=q4=Runetotem's Trousers of Conquest", "=ds=#s11#, #a2#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 6, 48192, "", "=q4=Runetotem's Handgrips of Conquest", "=ds=#s9#, #a2#"};
		{ 7, 48190, "", "=q4=Runetotem's Legguards of Conquest", "=ds=#s11#, #a2#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 10, 48153, "", "=q4=Runetotem's Handguards of Conquest", "=ds=#s9#, #a2#"};
		{ 11, 48155, "", "=q4=Runetotem's Leggings of Conquest", "=ds=#s11#, #a2#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 14, 48244, "", "=q4=Garona's Gauntlets of Conquest", "=ds=#s9#, #a2#"};
		{ 15, 48246, "", "=q4=Garona's Legplates of Conquest", "=ds=#s11#, #a2#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 17, 41293, "", "=q4=Furious Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2#"};
		{ 18, 41304, "", "=q4=Furious Gladiator's Wyrmhide Legguards", "=ds=#s11#, #a2#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 21, 41773, "", "=q4=Furious Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2#"};
		{ 22, 41667, "", "=q4=Furious Gladiator's Dragonhide Legguards", "=ds=#s11#, #a2#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 25, 41287, "", "=q4=Furious Gladiator's Kodohide Gloves", "=ds=#s9#, #a2#"};
		{ 26, 41298, "", "=q4=Furious Gladiator's Kodohide Legguards", "=ds=#s11#, #a2#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 29, 41767, "", "=q4=Furious Gladiator's Leather Gloves", "=ds=#s9#, #a2#"};
		{ 30, 41655, "", "=q4=Furious Gladiator's Leather Legguards", "=ds=#s11#, #a2#"};
		Prev = "VaultofArchavonKoralon1_H";
		Next = "VaultofArchavonKoralon3_H";
	};

	AtlasLoot_Data["VaultofArchavonKoralon3_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 2, 48276, "", "=q4=Windrunner's Handguards of Conquest", "=ds=#s9#, #a3#"};
		{ 3, 48278, "", "=q4=Windrunner's Legguards of Conquest", "=ds=#s11#, #a3#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 6, 48337, "", "=q4=Thrall's Gloves of Conquest", "=ds=#s9#, #a3#"};
		{ 7, 48339, "", "=q4=Thrall's Kilt of Conquest", "=ds=#s11#, #a3#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 10, 48367, "", "=q4=Thrall's Grips of Conquest", "=ds=#s9#, #a3#"};
		{ 11, 48369, "", "=q4=Thrall's War-Kilt of Conquest", "=ds=#s11#, #a3#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 14, 48296, "", "=q4=Thrall's Handguards of Conquest", "=ds=#s9#, #a3#"};
		{ 15, 48298, "", "=q4=Thrall's Legguards of Conquest", "=ds=#s11#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 17, 41143, "", "=q4=Furious Gladiator's Chain Gauntlets", "=ds=#s9#, #a3#"};
		{ 18, 41205, "", "=q4=Furious Gladiator's Chain Leggings", "=ds=#s11#, #a3#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 21, 41007, "", "=q4=Furious Gladiator's Mail Gauntlets", "=ds=#s9#, #a3#"};
		{ 22, 41033, "", "=q4=Furious Gladiator's Mail Leggings", "=ds=#s11#, #a3#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 25, 41137, "", "=q4=Furious Gladiator's Linked Gauntlets", "=ds=#s9#, #a3#"};
		{ 26, 41199, "", "=q4=Furious Gladiator's Linked Leggings", "=ds=#s11#, #a3#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 29, 41001, "", "=q4=Furious Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3#"};
		{ 30, 41027, "", "=q4=Furious Gladiator's Ringmail Leggings", "=ds=#s11#, #a3#"};
		Prev = "VaultofArchavonKoralon2_H";
		Next = "VaultofArchavonKoralon4_H";
	};

	AtlasLoot_Data["VaultofArchavonKoralon4_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 2, 48502, "", "=q4=Koltira's Gauntlets of Conquest", "=ds=#s9#, #a4#"};
		{ 3, 48504, "", "=q4=Koltira's Legplates of Conquest", "=ds=#s11#, #a4#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
		{ 6, 48559, "", "=q4=Koltira's Handguards of Conquest", "=ds=#s9#, #a4#"};
		{ 7, 48561, "", "=q4=Koltira's Legguards of Conquest", "=ds=#s11#, #a4#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 10, 48598, "", "=q4=Liadrin's Gloves of Conquest", "=ds=#s9#, #a4#"};
		{ 11, 48596, "", "=q4=Liadrin's Greaves of Conquest", "=ds=#s11#, #a4#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 14, 48630, "", "=q4=Liadrin's Gauntlets of Conquest", "=ds=#s9#, #a4#"};
		{ 15, 48628, "", "=q4=Liadrin's Legplates of Conquest", "=ds=#s11#, #a4#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 17, 40809, "", "=q4=Furious Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4#"};
		{ 18, 40848, "", "=q4=Furious Gladiator's Dreadplate Legguards", "=ds=#s11#, #a4#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 25, 40927, "", "=q4=Furious Gladiator's Ornamented Gloves", "=ds=#s9#, #a4#"};
		{ 26, 40939, "", "=q4=Furious Gladiator's Ornamented Legplates", "=ds=#s11#, #a4#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 29, 40808, "", "=q4=Furious Gladiator's Scaled Gauntlets", "=ds=#s9#, #a4#"};
		{ 30, 40849, "", "=q4=Furious Gladiator's Scaled Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonKoralon3_H";
		Next = "VaultofArchavonKoralon5_H";
	};

	AtlasLoot_Data["VaultofArchavonKoralon5_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Protection"]};
		{ 2, 48653, "", "=q4=Liadrin's Handguards of Conquest", "=ds=#s9#, #a4#"};
		{ 3, 48655, "", "=q4=Liadrin's Legguards of Conquest", "=ds=#s11#, #a4#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 6, 48387, "", "=q4=Hellscream's Gauntlets of Conquest", "=ds=#s9#, #a4#"};
		{ 7, 48389, "", "=q4=Hellscream's Legplates of Conquest", "=ds=#s11#, #a4#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["Protection"]};
		{ 10, 48457, "", "=q4=Hellscream's Handguards of Conquest", "=ds=#s9#, #a4#"};
		{ 11, 48459, "", "=q4=Hellscream's Legguards of Conquest", "=ds=#s11#, #a4#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 21, 40807, "", "=q4=Furious Gladiator's Plate Gauntlets", "=ds=#s9#, #a4#"};
		{ 22, 40847, "", "=q4=Furious Gladiator's Plate Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonKoralon4_H";
		Next = "VaultofArchavonKoralon6_H";
	};

	AtlasLoot_Data["VaultofArchavonKoralon6_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Cloth"]};
		{ 2, 41909, "", "=q4=Furious Gladiator's Cuffs of Dominance",  "=ds=#s8#, #a1#"};
		{ 3, 41898, "", "=q4=Furious Gladiator's Cord of Dominance", "=ds=#s10#, #a1#"};
		{ 4, 41903, "", "=q4=Furious Gladiator's Slippers of Dominance",  "=ds=#s12#, #a1#"};
		{ 6, 41893, "", "=q4=Furious Gladiator's Cuffs of Salvation",  "=ds=#s8#, #a1#"};
		{ 7, 41881, "", "=q4=Furious Gladiator's Cord of Salvation",  "=ds=#s10#, #a1#"};
		{ 8, 41885, "", "=q4=Furious Gladiator's Slippers of Salvation",  "=ds=#s12#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Leather"]};
		{ 17, 41640, "", "=q4=Furious Gladiator's Armwraps of Dominance",  "=ds=#s8#, #a2#"};
		{ 18, 41630, "", "=q4=Furious Gladiator's Belt of Dominance",  "=ds=#s10#, #a2#"};
		{ 19, 41635, "", "=q4=Furious Gladiator's Boots of Dominance",  "=ds=#s12#, #a2#"};
		{ 21, 41625, "", "=q4=Furious Gladiator's Armwraps of Salvation",  "=ds=#s8#, #a2#"};
		{ 22, 41617, "", "=q4=Furious Gladiator's Belt of Salvation", "=ds=#s10#, #a2#"};
		{ 23, 41621, "", "=q4=Furious Gladiator's Boots of Salvation",  "=ds=#s12#, #a2#"};
		{ 25, 41840, "", "=q4=Furious Gladiator's Armwraps of Triumph",  "=ds=#s8#, #a2#"};
		{ 26, 41832, "", "=q4=Furious Gladiator's Belt of Triumph",  "=ds=#s10#, #a2#"};
		{ 27, 41836, "", "=q4=Furious Gladiator's Boots of Triumph",  "=ds=#s12#, #a2#"};
		Prev = "VaultofArchavonKoralon5_H";
		Next = "VaultofArchavonKoralon7_H";
	};

	AtlasLoot_Data["VaultofArchavonKoralon7_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Mail"]};
		{ 2, 41065, "", "=q4=Furious Gladiator's Wristguards of Dominance", "=ds=#s8#, #a3#"};
		{ 3, 41070, "", "=q4=Furious Gladiator's Waistguard of Dominance",  "=ds=#s10#, #a3#"};
		{ 4, 41075, "", "=q4=Furious Gladiator's Sabatons of Dominance", "=ds=#s12#, #a3#"};
		{ 6, 41060, "", "=q4=Furious Gladiator's Wristguards of Salvation", "=ds=#s8#, #a3#"};
		{ 7, 41051, "", "=q4=Furious Gladiator's Waistguard of Salvation",  "=ds=#s10#, #a3#"};
		{ 8, 41055, "", "=q4=Furious Gladiator's Sabatons of Salvation", "=ds=#s12#, #a3#"};
		{ 10, 41225, "", "=q4=Furious Gladiator's Wristguards of Triumph", "=ds=#s8#, #a3#"};
		{ 11, 41235, "", "=q4=Furious Gladiator's Waistguard of Triumph",  "=ds=#s10#, #a3#"};
		{ 12, 41230, "", "=q4=Furious Gladiator's Sabatons of Triumph", "=ds=#s12#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Plate"]};
		{ 17, 40983, "", "=q4=Furious Gladiator's Bracers of Salvation", "=ds=#s8#, #a4#"};
		{ 18, 40976, "", "=q4=Furious Gladiator's Girdle of Salvation", "=ds=#s10#, #a4#"};
		{ 19, 40977, "", "=q4=Furious Gladiator's Greaves of Salvation", "=ds=#s12#, #a4#"};
		{ 21, 40889, "", "=q4=Furious Gladiator's Bracers of Triumph", "=ds=#s8#, #a4#"};
		{ 22, 40881, "", "=q4=Furious Gladiator's Girdle of Triumph", "=ds=#s10#, #a4#"};
		{ 23, 40882, "", "=q4=Furious Gladiator's Greaves of Triumph", "=ds=#s12#, #a4#"};
		Prev = "VaultofArchavonKoralon6_H";
		Next = "VaultofArchavonKoralon8_H";
	};

	AtlasLoot_Data["VaultofArchavonKoralon8_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Back"]};
		{ 2, 42071, "", "=q4=Furious Gladiator's Cloak of Ascendancy", "=ds=#s4#"};
		{ 3, 42073, "", "=q4=Furious Gladiator's Cloak of Deliverance", "=ds=#s4#"};
		{ 4, 42069, "", "=q4=Furious Gladiator's Cloak of Dominance", "=ds=#s4#"};
		{ 5, 42072, "", "=q4=Furious Gladiator's Cloak of Salvation", "=ds=#s4#"};
		{ 6, 42070, "", "=q4=Furious Gladiator's Cloak of Subjugation", "=ds=#s4#"};
		{ 7, 42074, "", "=q4=Furious Gladiator's Cloak of Triumph", "=ds=#s4#"};
		{ 8, 42075, "", "=q4=Furious Gladiator's Cloak of Victory", "=ds=#s4#"};
		{ 11, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 12, 43959, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m7#", "", ""};
		{ 13, 44083, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m6#", "", ""};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Neck"]};
		{ 17, 42037, "", "=q4=Furious Gladiator's Pendant of Ascendancy", "=ds=#s2#"};
		{ 18, 42039, "", "=q4=Furious Gladiator's Pendant of Deliverance", "=ds=#s2#"};
		{ 19, 42036, "", "=q4=Furious Gladiator's Pendant of Dominance", "=ds=#s2#"};
		{ 20, 42040, "", "=q4=Furious Gladiator's Pendant of Salvation", "=ds=#s2#"};
		{ 21, 42038, "", "=q4=Furious Gladiator's Pendant of Subjugation", "=ds=#s2#"};
		{ 22, 46373, "", "=q4=Furious Gladiator's Pendant of Sundering", "=ds=#s2#"};
		{ 23, 42034, "", "=q4=Furious Gladiator's Pendant of Triumph", "=ds=#s2#"};
		{ 24, 42035, "", "=q4=Furious Gladiator's Pendant of Victory", "=ds=#s2#"};
		{ 26, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Ring"]};
		{ 27, 42116, "", "=q4=Furious Gladiator's Band of Dominance", "=ds=#s13#"};
		{ 28, 42117, "", "=q4=Furious Gladiator's Band of Triumph", "=ds=#s13#"};
		Prev = "VaultofArchavonKoralon7_H";
	};

	AtlasLoot_Data["VaultofArchavonKoralon125Man_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 2, 47772, "", "=q4=Sunstrider's Gauntlets of Triumph", "=ds=#s9#, #a1#"};
		{ 3, 47770, "", "=q4=Sunstrider's Leggings of Triumph", "=ds=#s11#, #a1#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 6, 48066, "", "=q4=Zabra's Gloves of Triumph", "=ds=#s9#, #a1#"};
		{ 7, 48064, "", "=q4=Zabra's Leggings of Triumph", "=ds=#s11#, #a1#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 10, 48096, "", "=q4=Zabra's Handwraps of Triumph", "=ds=#s9#, #a1#"};
		{ 11, 48094, "", "=q4=Zabra's Pants of Triumph", "=ds=#s11#, #a1#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 14, 47803, "", "=q4=Gul'dan's Gloves of Triumph", "=ds=#s9#, #a1#"};
		{ 15, 47805, "", "=q4=Gul'dan's Leggings of Triumph", "=ds=#s11#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 17, 41972, "", "=q4=Relentless Gladiator's Silk Handguards", "=ds=#s9#, #a1#"};
		{ 18, 41960, "", "=q4=Relentless Gladiator's Silk Trousers", "=ds=#s11#, #a1#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 21, 41875, "", "=q4=Relentless Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1#"};
		{ 22, 41865, "", "=q4=Relentless Gladiator's Mooncloth Leggings", "=ds=#s11#, #a1#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 25, 41941, "", "=q4=Relentless Gladiator's Satin Gloves", "=ds=#s9#, #a1#"};
		{ 26, 41928, "", "=q4=Relentless Gladiator's Satin Leggings", "=ds=#s11#, #a1#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 29, 42018, "", "=q4=Relentless Gladiator's Felweave Handguards", "=ds=#s9#, #a1#"};
		{ 30, 42006, "", "=q4=Relentless Gladiator's Felweave Trousers", "=ds=#s11#, #a1#"};
		Next = "VaultofArchavonKoralon225Man_H";
	};

	AtlasLoot_Data["VaultofArchavonKoralon225Man_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 2, 48182, "", "=q4=Runetotem's Gloves of Triumph", "=ds=#s9#, #a2#"};
		{ 3, 48180, "", "=q4=Runetotem's Trousers of Triumph", "=ds=#s11#, #a2#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 6, 48193, "", "=q4=Runetotem's Handgrips of Triumph", "=ds=#s9#, #a2#"};
		{ 7, 48195, "", "=q4=Runetotem's Legguards of Triumph", "=ds=#s11#, #a2#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 10, 48152, "", "=q4=Runetotem's Handguards of Triumph", "=ds=#s9#, #a2#"};
		{ 11, 48150, "", "=q4=Runetotem's Leggings of Triumph", "=ds=#s11#, #a2#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 14, 48241, "", "=q4=Garona's Gauntlets of Triumph", "=ds=#s9#, #a2#"};
		{ 15, 48239, "", "=q4=Garona's Legplates of Triumph", "=ds=#s11#, #a2#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 17, 41294, "", "=q4=Relentless Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2#"};
		{ 18, 41305, "", "=q4=Relentless Gladiator's Wyrmhide Legguards", "=ds=#s11#, #a2#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 21, 41774, "", "=q4=Relentless Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2#"};
		{ 22, 41668, "", "=q4=Relentless Gladiator's Dragonhide Legguards", "=ds=#s11#, #a2#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 25, 41288, "", "=q4=Relentless Gladiator's Kodohide Gloves", "=ds=#s9#, #a2#"};
		{ 26, 41299, "", "=q4=Relentless Gladiator's Kodohide Legguards", "=ds=#s11#, #a2#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 29, 41768, "", "=q4=Relentless Gladiator's Leather Gloves", "=ds=#s9#, #a2#"};
		{ 30, 41656, "", "=q4=Relentless Gladiator's Leather Legguards", "=ds=#s11#, #a2#"};
		Prev = "VaultofArchavonKoralon125Man_H";
		Next = "VaultofArchavonKoralon325Man_H";
	};

	AtlasLoot_Data["VaultofArchavonKoralon325Man_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 2, 48273, "", "=q4=Windrunner's Handguards of Triumph", "=ds=#s9#, #a3#"};
		{ 3, 48271, "", "=q4=Windrunner's Legguards of Triumph", "=ds=#s11#, #a3#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 6, 48334, "", "=q4=Thrall's Gloves of Triumph", "=ds=#s9#, #a3#"};
		{ 7, 48332, "", "=q4=Thrall's Kilt of Triumph", "=ds=#s11#, #a3#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 10, 48364, "", "=q4=Thrall's Grips of Triumph", "=ds=#s9#, #a3#"};
		{ 11, 48362, "", "=q4=Thrall's War-Kilt of Triumph", "=ds=#s11#, #a3#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 14, 48301, "", "=q4=Thrall's Handguards of Triumph", "=ds=#s9#, #a3#"};
		{ 15, 48303, "", "=q4=Thrall's Legguards of Triumph", "=ds=#s11#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 17, 41144, "", "=q4=Relentless Gladiator's Chain Gauntlets", "=ds=#s9#, #a3#"};
		{ 18, 41206, "", "=q4=Relentless Gladiator's Chain Leggings", "=ds=#s11#, #a3#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 21, 41008, "", "=q4=Relentless Gladiator's Mail Gauntlets", "=ds=#s9#, #a3#"};
		{ 22, 41034, "", "=q4=Relentless Gladiator's Mail Leggings", "=ds=#s11#, #a3#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 25, 41138, "", "=q4=Relentless Gladiator's Linked Gauntlets", "=ds=#s9#, #a3#"};
		{ 26, 41200, "", "=q4=Relentless Gladiator's Linked Leggings", "=ds=#s11#, #a3#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 29, 41002, "", "=q4=Relentless Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3#"};
		{ 30, 41028, "", "=q4=Relentless Gladiator's Ringmail Leggings", "=ds=#s11#, #a3#"};
		Prev = "VaultofArchavonKoralon225Man_H";
		Next = "VaultofArchavonKoralon425Man_H";
	};

	AtlasLoot_Data["VaultofArchavonKoralon425Man_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 2, 48499, "", "=q4=Koltira's Gauntlets of Triumph", "=ds=#s9#, #a4#"};
		{ 3, 48497, "", "=q4=Koltira's Legplates of Triumph", "=ds=#s11#, #a4#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
		{ 6, 48556, "", "=q4=Koltira's Handguards of Triumph", "=ds=#s9#, #a4#"};
		{ 7, 48554, "", "=q4=Koltira's Legguards of Triumph", "=ds=#s11#, #a4#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 10, 48593, "", "=q4=Liadrin's Gloves of Triumph", "=ds=#s9#, #a4#"};
		{ 11, 48591, "", "=q4=Liadrin's Greaves of Triumph", "=ds=#s11#, #a4#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 14, 48625, "", "=q4=Liadrin's Gauntlets of Triumph", "=ds=#s9#, #a4#"};
		{ 15, 48623, "", "=q4=Liadrin's Legplates of Triumph", "=ds=#s11#, #a4#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 17, 40811, "", "=q4=Relentless Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4#"};
		{ 18, 40851, "", "=q4=Relentless Gladiator's Dreadplate Legguards", "=ds=#s11#, #a4#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 25, 40928, "", "=q4=Relentless Gladiator's Ornamented Gloves", "=ds=#s9#, #a4#"};
		{ 26, 40940, "", "=q4=Relentless Gladiator's Ornamented Legplates", "=ds=#s11#, #a4#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 29, 40812, "", "=q4=Relentless Gladiator's Scaled Gauntlets", "=ds=#s9#, #a4#"};
		{ 30, 40852, "", "=q4=Relentless Gladiator's Scaled Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonKoralon325Man_H";
		Next = "VaultofArchavonKoralon525Man_H";
	};

	AtlasLoot_Data["VaultofArchavonKoralon525Man_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Protection"]};
		{ 2, 48658, "", "=q4=Liadrin's Handguards of Triumph", "=ds=#s9#, #a4#"};
		{ 3, 48660, "", "=q4=Liadrin's Legguards of Triumph", "=ds=#s11#, #a4#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 6, 48392, "", "=q4=Hellscream's Gauntlets of Triumph", "=ds=#s9#, #a4#"};
		{ 7, 48394, "", "=q4=Hellscream's Legplates of Triumph", "=ds=#s11#, #a4#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["Protection"]};
		{ 10, 48462, "", "=q4=Hellscream's Handguards of Triumph", "=ds=#s9#, #a4#"};
		{ 11, 48464, "", "=q4=Hellscream's Legguards of Triumph", "=ds=#s11#, #a4#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 21, 40810, "", "=q4=Relentless Gladiator's Plate Gauntlets", "=ds=#s9#, #a4#"};
		{ 22, 40850, "", "=q4=Relentless Gladiator's Plate Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonKoralon425Man_H";
		Next = "VaultofArchavonKoralon625Man_H";
	};

	AtlasLoot_Data["VaultofArchavonKoralon625Man_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Cloth"]};
		{ 2, 41910, "", "=q4=Relentless Gladiator's Cuffs of Dominance", "=ds=#s8#, #a1#"};
		{ 3, 41899, "", "=q4=Relentless Gladiator's Cord of Dominance", "=ds=#s19#, #a1#"};
		{ 4, 41904, "", "=q4=Relentless Gladiator's Treads of Dominance", "=ds=#s12#, #a1#"};
		{ 6, 41894, "", "=q4=Relentless Gladiator's Cuffs of Salvation", "=ds=#s8#, #a1#"};
		{ 7, 41882, "", "=q4=Relentless Gladiator's Cord of Salvation", "=ds=#s10#, #a1#"};
		{ 8, 41886, "", "=q4=Relentless Gladiator's Treads of Salvation", "=ds=#s12#, #a1#"};
		{ 10, 49181, "", "=q4=Relentless Gladiator's Cuffs of Alacrity", "=ds=#s8#, #a1#"};
		{ 11, 49179, "", "=q4=Relentless Gladiator's Cord of Alacrity", "=ds=#s10#, #a1#"};
		{ 12, 49183, "", "=q4=Relentless Gladiator's Treads of Alacrity", "=ds=#s12#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Leather"]};
		{ 17, 41641, "", "=q4=Relentless Gladiator's Armwraps of Dominance", "=ds=#s8#, #a2#"};
		{ 18, 41631, "", "=q4=Relentless Gladiator's Belt of Dominance", "=ds=#s10#, #a2#"};
		{ 19, 41636, "", "=q4=Relentless Gladiator's Boots of Dominance", "=ds=#s12#, #a2#"};
		{ 21, 41626, "", "=q4=Relentless Gladiator's Armwraps of Salvation", "=ds=#s8#, #a2#"};
		{ 22, 41618, "", "=q4=Relentless Gladiator's Belt of Salvation", "=ds=#s10#, #a2#"};
		{ 23, 41622, "", "=q4=Relentless Gladiator's Boots of Salvation", "=ds=#s12#, #a2#"};
		{ 25, 41841, "", "=q4=Relentless Gladiator's Armwraps of Triumph", "=ds=#s8#, #a2#"};
		{ 26, 41833, "", "=q4=Relentless Gladiator's Belt of Triumph", "=ds=#s10#, #a2#"};
		{ 27, 41837, "", "=q4=Relentless Gladiator's Boots of Triumph", "=ds=#s12#, #a2#"};
		Prev = "VaultofArchavonKoralon525Man_H";
		Next = "VaultofArchavonKoralon725Man_H";
	};

	AtlasLoot_Data["VaultofArchavonKoralon725Man_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Mail"]};
		{ 2, 41066, "", "=q4=Relentless Gladiator's Wristguards of Dominance", "=ds=#s8#, #a3#"};
		{ 3, 41071, "", "=q4=Relentless Gladiator's Waistguard of Dominance","=ds=#s10#, #a3#"};
		{ 4, 41076, "", "=q4=Relentless Gladiator's Sabatons of Dominance", "=ds=#s12#, #a3#"};
		{ 6, 41061, "", "=q4=Relentless Gladiator's Wristguards of Salvation", "=ds=#s8#, #a3#"};
		{ 7, 41052, "", "=q4=Relentless Gladiator's Waistguard of Salvation", "=ds=#s10#, #a3#"};
		{ 8, 41056, "", "=q4=Relentless Gladiator's Sabatons of Salvation", "=ds=#s12#, #a3#"};
		{ 10, 41226, "", "=q4=Relentless Gladiator's Wristguards of Triumph", "=ds=#s8#, #a3#"};
		{ 11, 41236, "", "=q4=Relentless Gladiator's Waistguard of Triumph", "=ds=#s10#, #a3#"};
		{ 12, 41231, "", "=q4=Relentless Gladiator's Sabatons of Triumph", "=ds=#s12#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Plate"]};
		{ 17, 40984, "", "=q4=Relentless Gladiator's Bracers of Salvation","=ds=#s8#, #a4#"};
		{ 18, 40978, "", "=q4=Relentless Gladiator's Girdle of Salvation", "=ds=#s10#, #a4#"};
		{ 19, 40979, "", "=q4=Relentless Gladiator's Greaves of Salvation", "=ds=#s12#, #a4#"};
		{ 21, 40890, "", "=q4=Relentless Gladiator's Bracers of Triumph", "=ds=#s8#, #a4#"};
		{ 22, 40883, "", "=q4=Relentless Gladiator's Girdle of Triumph", "=ds=#s10#, #a4#"};
		{ 23, 40884, "", "=q4=Relentless Gladiator's Greaves of Triumph", "=ds=#s12#, #a4#"};
		Prev = "VaultofArchavonKoralon625Man_H";
		Next = "VaultofArchavonKoralon825Man_H";
	};

	AtlasLoot_Data["VaultofArchavonKoralon825Man_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Back"]};
		{ 2, 42078, "", "=q4=Relentless Gladiator's Cloak of Ascendancy", "=ds=#s4#"};
		{ 3, 42080, "", "=q4=Relentless Gladiator's Cloak of Deliverance", "=ds=#s4#"};
		{ 4, 42076, "", "=q4=Relentless Gladiator's Cloak of Dominance", "=ds=#s4#"};
		{ 5, 42079, "", "=q4=Relentless Gladiator's Cloak of Salvation", "=ds=#s4#"};
		{ 6, 42077, "", "=q4=Relentless Gladiator's Cloak of Subjugation", "=ds=#s4#"};
		{ 7, 42081, "", "=q4=Relentless Gladiator's Cloak of Triumph", "=ds=#s4#"};
		{ 8, 42082, "", "=q4=Relentless Gladiator's Cloak of Victory", "=ds=#s4#"};
		{ 11, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 12, 43959, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m7#", "", ""};
		{ 13, 44083, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m6#", "", ""};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Neck"]};
		{ 17, 42044, "", "=q4=Relentless Gladiator's Pendant of Ascendancy", "=ds=#s2#"};
		{ 18, 42046, "", "=q4=Relentless Gladiator's Pendant of Deliverance", "=ds=#s2#"};
		{ 19, 42043, "", "=q4=Relentless Gladiator's Pendant of Dominance", "=ds=#s2#"};
		{ 20, 42047, "", "=q4=Relentless Gladiator's Pendant of Salvation", "=ds=#s2#"};
		{ 21, 42045, "", "=q4=Relentless Gladiator's Pendant of Subjugation", "=ds=#s2#"};
		{ 22, 46374, "", "=q4=Relentless Gladiator's Pendant of Sundering", "=ds=#s2#"};
		{ 23, 42041, "", "=q4=Relentless Gladiator's Pendant of Triumph", "=ds=#s2#"};
		{ 24, 42042, "", "=q4=Relentless Gladiator's Pendant of Victory", "=ds=#s2#"};
		{ 26, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Ring"]};
		{ 27, 42118, "", "=q4=Relentless Gladiator's Band of Ascendancy", "=ds=#s13#"};
		{ 28, 42119, "", "=q4=Relentless Gladiator's Band of Victory", "=ds=#s13#"};
		Prev = "VaultofArchavonKoralon725Man_H";
	};

	AtlasLoot_Data["VaultofArchavonToravon1"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 2, 50275, "", "=q4=Bloodmage Gloves", "=ds=#s9#, #a1#"};
		{ 3, 50277, "", "=q4=Bloodmage Leggings", "=ds=#s11#, #a1#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 6, 50766, "", "=q4=Crimson Acolyte Gloves", "=ds=#s9#, #a1#"};
		{ 7, 50769, "", "=q4=Crimson Acolyte Leggings", "=ds=#s11#, #a1#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 10, 50391, "", "=q4=Crimson Acolyte Handwraps", "=ds=#s9#, #a1#"};
		{ 11, 50393, "", "=q4=Crimson Acolyte Pants", "=ds=#s11#, #a1#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 14, 50240, "", "=q4=Dark Coven Gloves", "=ds=#s9#, #a1#"};
		{ 15, 50242, "", "=q4=Dark Coven Leggings", "=ds=#s11#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 17, 41972, "", "=q4=Relentless Gladiator's Silk Handguards", "=ds=#s9#, #a1#"};
		{ 18, 41960, "", "=q4=Relentless Gladiator's Silk Trousers", "=ds=#s11#, #a1#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 21, 41875, "", "=q4=Relentless Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1#"};
		{ 22, 41865, "", "=q4=Relentless Gladiator's Mooncloth Leggings", "=ds=#s11#, #a1#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 25, 41941, "", "=q4=Relentless Gladiator's Satin Gloves", "=ds=#s9#, #a1#"};
		{ 26, 41928, "", "=q4=Relentless Gladiator's Satin Leggings", "=ds=#s11#, #a1#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 29, 42018, "", "=q4=Relentless Gladiator's Felweave Handguards", "=ds=#s9#, #a1#"};
		{ 30, 42006, "", "=q4=Relentless Gladiator's Felweave Trousers", "=ds=#s11#, #a1#"};
		Next = "VaultofArchavonToravon2";
	};

	AtlasLoot_Data["VaultofArchavonToravon2"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 2, 50822, "", "=q4=Lasherweave's Gloves", "=ds=#s9#, #a2#"};
		{ 3, 50820, "", "=q4=Lasherweave's Trousers", "=ds=#s11#, #a2#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 6, 50827, "", "=q4=Lasherweave's Handgrips", "=ds=#s9#, #a2#"};
		{ 7, 50825, "", "=q4=Lasherweave's Legguards", "=ds=#s11#, #a2#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 10, 50107, "", "=q4=Lasherweave's Gauntlets", "=ds=#s9#, #a2#" };
		{ 11, 50109, "", "=q4=Lasherweave's Legplates", "=ds=#s11#, #a2#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 14, 50088, "", "=q4=Shadowblade Gauntlets", "=ds=#s9#, #a2#"};
		{ 15, 50090, "", "=q4=Shadowblade Legplates", "=ds=#s11#, #a2#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 17, 41294, "", "=q4=Relentless Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2#"};
		{ 18, 41305, "", "=q4=Relentless Gladiator's Wyrmhide Legguards", "=ds=#s11#, #a2#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 21, 41774, "", "=q4=Relentless Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2#"};
		{ 22, 41668, "", "=q4=Relentless Gladiator's Dragonhide Legguards", "=ds=#s11#, #a2#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 25, 41288, "", "=q4=Relentless Gladiator's Kodohide Gloves", "=ds=#s9#, #a2#"};
		{ 26, 41299, "", "=q4=Relentless Gladiator's Kodohide Legguards", "=ds=#s11#, #a2#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 29, 41768, "", "=q4=Relentless Gladiator's Leather Gloves", "=ds=#s9#, #a2#"};
		{ 30, 41656, "", "=q4=Relentless Gladiator's Leather Legguards", "=ds=#s11#, #a2#"};
		Prev = "VaultofArchavonToravon1";
		Next = "VaultofArchavonToravon3";
	};

	AtlasLoot_Data["VaultofArchavonToravon3"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 2, 50114, "", "=q4=Ahn'Kahar Blood Hunter's Handguards", "=ds=#s9#, #a3#"};
		{ 3, 50116, "", "=q4=Ahn'Kahar Blood Hunter's Legguards", "=ds=#s11#, #a3#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 6, 50842, "", "=q4=Frost Witch's Gloves", "=ds=#s9#, #a3#"};
		{ 7, 50844, "", "=q4=Frost Witch's Kilt", "=ds=#s11#, #a3#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 10, 50831, "", "=q4=Frost Witch's Grips", "=ds=#s9#, #a3#"};
		{ 11, 50833, "", "=q4=Frost Witch's War-Kilt", "=ds=#s11#, #a3#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 14, 50836, "", "=q4=Frost Witch's Handguards", "=ds=#s9#, #a3#"};
		{ 15, 50838, "", "=q4=Frost Witch's Legguards", "=ds=#s11#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 17, 41144, "", "=q4=Relentless Gladiator's Chain Gauntlets", "=ds=#s9#, #a3#"};
		{ 18, 41206, "", "=q4=Relentless Gladiator's Chain Leggings", "=ds=#s11#, #a3#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 21, 41008, "", "=q4=Relentless Gladiator's Mail Gauntlets", "=ds=#s9#, #a3#"};
		{ 22, 41034, "", "=q4=Relentless Gladiator's Mail Leggings", "=ds=#s11#, #a3#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 25, 41138, "", "=q4=Relentless Gladiator's Linked Gauntlets", "=ds=#s9#, #a3#"};
		{ 26, 41200, "", "=q4=Relentless Gladiator's Linked Leggings", "=ds=#s11#, #a3#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 29, 41002, "", "=q4=Relentless Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3#"};
		{ 30, 41028, "", "=q4=Relentless Gladiator's Ringmail Leggings", "=ds=#s11#, #a3#"};
		Prev = "VaultofArchavonToravon2";
		Next = "VaultofArchavonToravon4";
	};

	AtlasLoot_Data["VaultofArchavonToravon4"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 2, 50095, "", "=q4=Scourgelord Gauntlets", "=ds=#s9#, #a4#"};
		{ 3, 50097, "", "=q4=Scourgelord Legplates", "=ds=#s11#, #a4#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
		{ 6, 50856, "", "=q4=Scourgelord Handguards", "=ds=#s9#, #a4#"};
		{ 7, 50854, "", "=q4=Scourgelord Legguards", "=ds=#s11#, #a4#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 10, 50868, "", "=q4=Lightsworn Gloves", "=ds=#s9#, #a4#"};
		{ 11, 50866, "", "=q4=Lightsworn Greaves", "=ds=#s11#, #a4#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 14, 50327, "", "=q4=Lightsworn Gauntlets", "=ds=#s9#, #a4#"};
		{ 15, 50325, "", "=q4=Lightsworn Legplates", "=ds=#s11#, #a4#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 17, 40811, "", "=q4=Relentless Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4#"};
		{ 18, 40851, "", "=q4=Relentless Gladiator's Dreadplate Legguards", "=ds=#s11#, #a4#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 25, 40928, "", "=q4=Relentless Gladiator's Ornamented Gloves", "=ds=#s9#, #a4#"};
		{ 26, 40940, "", "=q4=Relentless Gladiator's Ornamented Legplates", "=ds=#s11#, #a4#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 29, 40812, "", "=q4=Relentless Gladiator's Scaled Gauntlets", "=ds=#s9#, #a4#"};
		{ 30, 40852, "", "=q4=Relentless Gladiator's Scaled Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonToravon3";
		Next = "VaultofArchavonToravon5";
	};

	AtlasLoot_Data["VaultofArchavonToravon5"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Protection"]};
		{ 2, 50863, "", "=q4=Lightsworn Handguards", "=ds=#s9#, #a4#"};
		{ 3, 50861, "", "=q4=Lightsworn Legguards", "=ds=#s11#, #a4#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 6, 50079, "", "=q4=Ymirjar Lord's Gauntlets", "=ds=#s9#, #a4#"};
		{ 7, 50081, "", "=q4=Ymirjar Lord's Legplates", "=ds=#s11#, #a4#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["Protection"]};
		{ 10, 50849, "", "=q4=Ymirjar Lord's Handguards", "=ds=#s9#, #a4#"};
		{ 11, 50847, "", "=q4=Ymirjar Lord's Legguards", "=ds=#s11#, #a4#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 21, 40810, "", "=q4=Relentless Gladiator's Plate Gauntlets", "=ds=#s9#, #a4#"};
		{ 22, 40850, "", "=q4=Relentless Gladiator's Plate Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonToravon4";
		Next = "VaultofArchavonToravon6";
	};

	AtlasLoot_Data["VaultofArchavonToravon6"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Cloth"]};
		{ 2, 41910, "", "=q4=Relentless Gladiator's Cuffs of Dominance", "=ds=#s8#, #a1#"};
		{ 3, 41899, "", "=q4=Relentless Gladiator's Cord of Dominance", "=ds=#s10#, #a1#"};
		{ 4, 41904, "", "=q4=Relentless Gladiator's Treads of Dominance", "=ds=#s12#, #a1#"};
		{ 6, 41894, "", "=q4=Relentless Gladiator's Cuffs of Salvation", "=ds=#s8#, #a1#"};
		{ 7, 41882, "", "=q4=Relentless Gladiator's Cord of Salvation", "=ds=#s10#, #a1#"};
		{ 8, 41886, "", "=q4=Relentless Gladiator's Treads of Salvation", "=ds=#s12#, #a1#"};
		{ 10, 49181, "", "=q4=Relentless Gladiator's Cuffs of Alacrity", "=ds=#s8#, #a1#"};
		{ 11, 49179, "", "=q4=Relentless Gladiator's Cord of Alacrity", "=ds=#s10#, #a1#"};
		{ 12, 49183, "", "=q4=Relentless Gladiator's Treads of Alacrity", "=ds=#s12#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Leather"]};
		{ 17, 41641, "", "=q4=Relentless Gladiator's Armwraps of Dominance", "=ds=#s8#, #a2#"};
		{ 18, 41631, "", "=q4=Relentless Gladiator's Belt of Dominance", "=ds=#s10#, #a2#"};
		{ 19, 41636, "", "=q4=Relentless Gladiator's Boots of Dominance", "=ds=#s12#, #a2#"};
		{ 21, 41626, "", "=q4=Relentless Gladiator's Armwraps of Salvation", "=ds=#s8#, #a2#"};
		{ 22, 41618, "", "=q4=Relentless Gladiator's Belt of Salvation", "=ds=#s10#, #a2#"};
		{ 23, 41622, "", "=q4=Relentless Gladiator's Boots of Salvation", "=ds=#s12#, #a2#"};
		{ 25, 41841, "", "=q4=Relentless Gladiator's Armwraps of Triumph", "=ds=#s8#, #a2#"};
		{ 26, 41833, "", "=q4=Relentless Gladiator's Belt of Triumph", "=ds=#s10#, #a2#"};
		{ 27, 41837, "", "=q4=Relentless Gladiator's Boots of Triumph", "=ds=#s12#, #a2#"};
		Prev = "VaultofArchavonToravon5";
		Next = "VaultofArchavonToravon7";
	};

	AtlasLoot_Data["VaultofArchavonToravon7"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Mail"]};
		{ 2, 41066, "", "=q4=Relentless Gladiator's Wristguards of Dominance", "=ds=#s8#, #a3#"};
		{ 3, 41071, "", "=q4=Relentless Gladiator's Waistguard of Dominance", "=ds=#s10#, #a3#"};
		{ 4, 41076, "", "=q4=Relentless Gladiator's Sabatons of Dominance", "=ds=#s12#, #a3#"};
		{ 6, 41061, "", "=q4=Relentless Gladiator's Wristguards of Salvation", "=ds=#s8#, #a3#"};
		{ 7, 41052, "", "=q4=Relentless Gladiator's Waistguard of Salvation", "=ds=#s10#, #a3#"};
		{ 8, 41056, "", "=q4=Relentless Gladiator's Sabatons of Salvation", "=ds=#s12#, #a3#"};
		{ 10, 41226, "", "=q4=Relentless Gladiator's Wristguards of Triumph", "=ds=#s8#, #a3#"};
		{ 11, 41236, "", "=q4=Relentless Gladiator's Waistguard of Triumph", "=ds=#s10#, #a3#"};
		{ 12, 41231, "", "=q4=Relentless Gladiator's Sabatons of Triumph", "=ds=#s12#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Plate"]};
		{ 17, 40984, "", "=q4=Relentless Gladiator's Bracers of Salvation", "=ds=#s8#, #a4#"};
		{ 18, 40978, "", "=q4=Relentless Gladiator's Girdle of Salvation", "=ds=#s10#, #a4#"};
		{ 19, 40979, "", "=q4=Relentless Gladiator's Greaves of Salvation", "=ds=#s12#, #a4#"};
		{ 21, 40890, "", "=q4=Relentless Gladiator's Bracers of Triumph", "=ds=#s8#, #a4#"};
		{ 22, 40883, "", "=q4=Relentless Gladiator's Girdle of Triumph", "=ds=#s10#, #a4#"};
		{ 23, 40884, "", "=q4=Relentless Gladiator's Greaves of Triumph", "=ds=#s12#, #a4#"};
		Prev = "VaultofArchavonToravon6";
		Next = "VaultofArchavonToravon8";
	};

	AtlasLoot_Data["VaultofArchavonToravon8"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Back"]};
		{ 2, 42078, "", "=q4=Relentless Gladiator's Cloak of Ascendancy", "=ds=#s4#"};
		{ 3, 42080, "", "=q4=Relentless Gladiator's Cloak of Deliverance", "=ds=#s4#"};
		{ 4, 42076, "", "=q4=Relentless Gladiator's Cloak of Dominance", "=ds=#s4#"};
		{ 5, 42079, "", "=q4=Relentless Gladiator's Cloak of Salvation", "=ds=#s4#"};
		{ 6, 42077, "", "=q4=Relentless Gladiator's Cloak of Subjugation", "=ds=#s4#"};
		{ 7, 42081, "", "=q4=Relentless Gladiator's Cloak of Triumph", "=ds=#s4#"};
		{ 8, 42082, "", "=q4=Relentless Gladiator's Cloak of Victory", "=ds=#s4#"};
		{ 11, 49426, "", "=q4=Emblem of Frost", "=ds=#e15#", "", "100%"};
		{ 12, 43959, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m7#", "", ""};
		{ 13, 44083, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m6#", "", ""};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Neck"]};
		{ 17, 42044, "", "=q4=Relentless Gladiator's Pendant of Ascendancy", "=ds=#s2#"};
		{ 18, 42046, "", "=q4=Relentless Gladiator's Pendant of Deliverance", "=ds=#s2#"};
		{ 19, 42043, "", "=q4=Relentless Gladiator's Pendant of Dominance", "=ds=#s2#"};
		{ 20, 42047, "", "=q4=Relentless Gladiator's Pendant of Salvation", "=ds=#s2#"};
		{ 21, 42045, "", "=q4=Relentless Gladiator's Pendant of Subjugation", "=ds=#s2#"};
		{ 22, 46374, "", "=q4=Relentless Gladiator's Pendant of Sundering", "=ds=#s2#"};
		{ 23, 42041, "", "=q4=Relentless Gladiator's Pendant of Triumph", "=ds=#s2#"};
		{ 24, 42042, "", "=q4=Relentless Gladiator's Pendant of Victory", "=ds=#s2#"};
		{ 26, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Ring"]};
		{ 27, 42118, "", "=q4=Relentless Gladiator's Band of Ascendancy", "=ds=#s13#"};
		{ 28, 42119, "", "=q4=Relentless Gladiator's Band of Victory", "=ds=#s13#"};
		Prev = "VaultofArchavonToravon7";
	};

	AtlasLoot_Data["VaultofArchavonToravon125Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 2, 51159, "", "=q4=Sanctified Bloodmage Gloves", "=ds=#s9#, #a1#"};
		{ 3, 51157, "", "=q4=Sanctified Bloodmage Leggings", "=ds=#s11#, #a1#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 6, 51179, "", "=q4=Sanctified Crimson Acolyte Gloves", "=ds=#s9#, #a1#"};
		{ 7, 51177, "", "=q4=Sanctified Crimson Acolyte Leggings", "=ds=#s11#, #a1#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 10, 51183, "", "=q4=Sanctified Crimson Acolyte Handwraps", "=ds=#s9#, #a1#"};
		{ 11, 51181, "", "=q4=Sanctified Crimson Acolyte Pants", "=ds=#s11#, #a1#"};
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 14, 51209, "", "=q4=Sanctified Dark Coven Gloves", "=ds=#s9#, #a1#"};
		{ 15, 51207, "", "=q4=Sanctified Dark Coven Leggings", "=ds=#s11#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
		{ 17, 51464, "", "=q4=Wrathful Gladiator's Silk Handguards", "=ds=#s9#, #a1#"};
		{ 18, 51466, "", "=q4=Wrathful Gladiator's Silk Trousers", "=ds=#s11#, #a1#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Holy"]};
		{ 21, 51483, "", "=q4=Wrathful Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1#"};
		{ 22, 51485, "", "=q4=Wrathful Gladiator's Mooncloth Leggings", "=ds=#s11#, #a1#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Shadow"]};
		{ 25, 51488, "", "=q4=Wrathful Gladiator's Satin Gloves", "=ds=#s9#, #a1#"};
		{ 26, 51490, "", "=q4=Wrathful Gladiator's Satin Leggings", "=ds=#s11#, #a1#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
		{ 29, 51537, "", "=q4=Wrathful Gladiator's Felweave Handguards", "=ds=#s9#, #a1#"};
		{ 30, 51539, "", "=q4=Wrathful Gladiator's Felweave Trousers", "=ds=#s11#, #a1#"};
		Next = "VaultofArchavonToravon225Man";
	};

	AtlasLoot_Data["VaultofArchavonToravon225Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 2, 51148, "", "=q4=Sanctified Lasherweave's Gloves", "=ds=#s9#, #a2#" };
		{ 3, 51146, "", "=q4=Sanctified Lasherweave's Trousers", "=ds=#s11#, #a2#" };
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 6, 51144, "", "=q4=Sanctified Lasherweave's Handgrips", "=ds=#s9#, #a2#" };
		{ 7, 51142, "", "=q4=Sanctified Lasherweave's Legguards", "=ds=#s11#, #a2#" };
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 10, 51138, "", "=q4=Sanctified Lasherweave's Gauntlets", "=ds=#s9#, #a2#" };
		{ 11, 51136, "", "=q4=Sanctified Lasherweave's Legplates", "=ds=#s11#, #a2#" };
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 14, 51188, "", "=q4=Sanctified Shadowblade Gauntlets", "=ds=#s9#, #a2#"};
		{ 15, 51186, "", "=q4=Sanctified Shadowblade Legplates", "=ds=#s11#, #a2#"};
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Balance"]};
		{ 17, 51434, "", "=q4=Wrathful Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2#"};
		{ 18, 51436, "", "=q4=Wrathful Gladiator's Wyrmhide Legguards", "=ds=#s11#, #a2#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Feral"]};
		{ 21, 51426, "", "=q4=Wrathful Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2#"};
		{ 22, 51428, "", "=q4=Wrathful Gladiator's Dragonhide Legguards", "=ds=#s11#, #a2#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Restoration"]};
		{ 25, 51420, "", "=q4=Wrathful Gladiator's Kodohide Gloves", "=ds=#s9#, #a2#"};
		{ 26, 51422, "", "=q4=Wrathful Gladiator's Kodohide Legguards", "=ds=#s11#, #a2#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
		{ 29, 51493, "", "=q4=Wrathful Gladiator's Leather Gloves", "=ds=#s9#, #a2#"};
		{ 30, 51495, "", "=q4=Wrathful Gladiator's Leather Legguards", "=ds=#s11#, #a2#"};
		Prev = "VaultofArchavonToravon125Man";
		Next = "VaultofArchavonToravon325Man";
	};

	AtlasLoot_Data["VaultofArchavonToravon325Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 2, 51154, "", "=q4=Sanctified Ahn'Kahar Blood Hunter's Handguards", "=ds=#s9#, #a3#"};
		{ 3, 51152, "", "=q4=Sanctified Ahn'Kahar Blood Hunter's Legguards", "=ds=#s11#, #a3#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 6, 51201, "", "=q4=Sanctified Frost Witch's Gloves", "=ds=#s9#, #a3#" };
		{ 7, 51203, "", "=q4=Sanctified Frost Witch's Kilt", "=ds=#s11#, #a3#" };
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 10, 51196, "", "=q4=Sanctified Frost Witch's Grips", "=ds=#s9#, #a3#" };
		{ 11, 51198, "", "=q4=Sanctified Frost Witch's War-Kilt", "=ds=#s11#, #a3#" };
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 14, 51191, "", "=q4=Sanctified Frost Witch's Handguards", "=ds=#s9#, #a3#" };
		{ 15, 51193, "", "=q4=Sanctified Frost Witch's Legguards", "=ds=#s11#, #a3#" };
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
		{ 17, 51459, "", "=q4=Wrathful Gladiator's Chain Gauntlets", "=ds=#s9#, #a3#"};
		{ 18, 51461, "", "=q4=Wrathful Gladiator's Chain Leggings", "=ds=#s11#, #a3#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Elemental"]};
		{ 21, 51510, "", "=q4=Wrathful Gladiator's Mail Gauntlets", "=ds=#s9#, #a3#"};
		{ 22, 51512, "", "=q4=Wrathful Gladiator's Mail Leggings", "=ds=#s11#, #a3#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Enhancement"]};
		{ 25, 51504, "", "=q4=Wrathful Gladiator's Linked Gauntlets", "=ds=#s9#, #a3#"};
		{ 26, 51506, "", "=q4=Wrathful Gladiator's Linked Leggings", "=ds=#s11#, #a3#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Restoration"]};
		{ 29, 51498, "", "=q4=Wrathful Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3#"};
		{ 30, 51500, "", "=q4=Wrathful Gladiator's Ringmail Leggings", "=ds=#s11#, #a3#"};
		Prev = "VaultofArchavonToravon225Man";
		Next = "VaultofArchavonToravon425Man";
	};

	AtlasLoot_Data["VaultofArchavonToravon425Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 2, 51128, "", "=q4=Sanctified Scourgelord Gauntlets", "=ds=#s9#, #a4#"};
		{ 3, 51126, "", "=q4=Sanctified Scourgelord Legplates", "=ds=#s11#, #a4#"};
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
		{ 6, 51132, "", "=q4=Sanctified Scourgelord Handguards", "=ds=#s9#, #a4#"};
		{ 7, 51131, "", "=q4=Sanctified Scourgelord Legguards", "=ds=#s11#, #a4#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 10, 51169, "", "=q4=Sanctified Lightsworn Gloves", "=ds=#s9#, #a4#" };
		{ 11, 51168, "", "=q4=Sanctified Lightsworn Greaves", "=ds=#s11#, #a4#" };
		{ 13, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 14, 51163, "", "=q4=Sanctified Lightsworn Gauntlets", "=ds=#s9#, #a4#" };
		{ 15, 51161, "", "=q4=Sanctified Lightsworn Legplates", "=ds=#s11#, #a4#" };
		{ 16, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
		{ 17, 51414, "", "=q4=Wrathful Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4#"};
		{ 18, 51416, "", "=q4=Wrathful Gladiator's Dreadplate Legguards", "=ds=#s11#, #a4#"};
		{ 24, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Holy"]};
		{ 25, 51469, "", "=q4=Wrathful Gladiator's Ornamented Gloves", "=ds=#s9#, #a4#"};
		{ 26, 51471, "", "=q4=Wrathful Gladiator's Ornamented Legplates", "=ds=#s11#, #a4#"};
		{ 28, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Retribution"]};
		{ 29, 51475, "", "=q4=Wrathful Gladiator's Scaled Gauntlets", "=ds=#s9#, #a4#"};
		{ 30, 51477, "", "=q4=Wrathful Gladiator's Scaled Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonToravon325Man";
		Next = "VaultofArchavonToravon525Man";
	};

	AtlasLoot_Data["VaultofArchavonToravon525Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Protection"]};
		{ 2, 51172, "", "=q4=Sanctified Lightsworn Handguards", "=ds=#s9#, #a4#" };
		{ 3, 51171, "", "=q4=Sanctified Lightsworn Legguards", "=ds=#s11#, #a4#" };
		{ 5, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 6, 51213, "", "=q4=Ymirjar Lord's Gauntlets", "=ds=#s9#, #a4#"};
		{ 7, 51211, "", "=q4=Ymirjar Lord's Legplates", "=ds=#s11#, #a4#"};
		{ 9, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["Protection"]};
		{ 10, 51217, "", "=q4=Ymirjar Lord's Handguards", "=ds=#s9#, #a4#"};
		{ 11, 51216, "", "=q4=Ymirjar Lord's Legguards", "=ds=#s11#, #a4#"};
		{ 20, 0, "INV_Box_01", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
		{ 21, 51542, "", "=q4=Wrathful Gladiator's Plate Gauntlets", "=ds=#s9#, #a4#"};
		{ 22, 51544, "", "=q4=Wrathful Gladiator's Plate Legguards", "=ds=#s11#, #a4#"};
		Prev = "VaultofArchavonToravon425Man";
		Next = "VaultofArchavonToravon625Man";
	};

	AtlasLoot_Data["VaultofArchavonToravon625Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Cloth"]};
		{ 2, 51329, "", "=q4=Wrathful Gladiator's Cuffs of Dominance", "=ds=#s8#, #a1#"};
		{ 3, 51327, "", "=q4=Wrathful Gladiator's Cord of Dominance", "=ds=#s10#, #a1#"};
		{ 4, 51328, "", "=q4=Wrathful Gladiator's Treads of Dominance", "=ds=#s12#, #a1#"};
		{ 6, 51367, "", "=q4=Wrathful Gladiator's Cuffs of Salvation", "=ds=#s8#, #a1#"};
		{ 7, 51365, "", "=q4=Wrathful Gladiator's Cord of Salvation", "=ds=#s10#, #a1#"};
		{ 8, 51366, "", "=q4=Wrathful Gladiator's Treads of Salvation", "=ds=#s12#, #a1#"};
		{ 10, 51339, "", "=q4=Wrathful Gladiator's Cuffs of Alacrity", "=ds=#s8#, #a1#"};
		{ 11, 51337, "", "=q4=Wrathful Gladiator's Cord of Alacrity", "=ds=#s10#, #a1#"};
		{ 12, 51338, "", "=q4=Wrathful Gladiator's Treads of Alacrity", "=ds=#s12#, #a1#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Leather"]};
		{ 17, 51345, "", "=q4=Wrathful Gladiator's Armwraps of Dominance", "=ds=#s8#, #a2#"};
		{ 18, 51343, "", "=q4=Wrathful Gladiator's Belt of Dominance", "=ds=#s10#, #a2#"};
		{ 19, 51344, "", "=q4=Wrathful Gladiator's Boots of Dominance", "=ds=#s12#, #a2#"};
		{ 21, 51342, "", "=q4=Wrathful Gladiator's Armwraps of Salvation", "=ds=#s8#, #a2#"};
		{ 22, 51340, "", "=q4=Wrathful Gladiator's Belt of Salvation", "=ds=#s10#, #a2#"};
		{ 23, 51341, "", "=q4=Wrathful Gladiator's Boots of Salvation", "=ds=#s12#, #a2#"};
		{ 25, 51370, "", "=q4=Wrathful Gladiator's Armwraps of Triumph", "=ds=#s8#, #a2#"};
		{ 26, 51368, "", "=q4=Wrathful Gladiator's Belt of Triumph", "=ds=#s10#, #a2#"};
		{ 27, 51369, "", "=q4=Wrathful Gladiator's Boots of Triumph", "=ds=#s12#, #a2#"};
		Prev = "VaultofArchavonToravon525Man";
		Next = "VaultofArchavonToravon725Man";
	};

	AtlasLoot_Data["VaultofArchavonToravon725Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Mail"]};
		{ 2, 51376, "", "=q4=Wrathful Gladiator's Wristguards of Dominance", "=ds=#s8#, #a3#"};
		{ 3, 51374, "", "=q4=Wrathful Gladiator's Waistguard of Dominance", "=ds=#s10#, #a3#"};
		{ 4, 51375, "", "=q4=Wrathful Gladiator's Sabatons of Dominance", "=ds=#s12#, #a3#"};
		{ 6, 51373, "", "=q4=Wrathful Gladiator's Wristguards of Salvation", "=ds=#s8#, #a3#"};
		{ 7, 51371, "", "=q4=Wrathful Gladiator's Waistguard of Salvation", "=ds=#s10#, #a3#"};
		{ 8, 51372, "", "=q4=Wrathful Gladiator's Sabatons of Salvation", "=ds=#s12#, #a3#"};
		{ 10, 51352, "", "=q4=Wrathful Gladiator's Wristguards of Triumph", "=ds=#s8#, #a3#"};
		{ 11, 51350, "", "=q4=Wrathful Gladiator's Waistguard of Triumph", "=ds=#s10#, #a3#"};
		{ 12, 51351, "", "=q4=Wrathful Gladiator's Sabatons of Triumph", "=ds=#s12#, #a3#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Plate"]};
		{ 17, 51361, "", "=q4=Wrathful Gladiator's Bracers of Salvation", "=ds=#s8#, #a4#"};
		{ 18, 51359, "", "=q4=Wrathful Gladiator's Girdle of Salvation", "=ds=#s10#, #a4#"};
		{ 19, 51360, "", "=q4=Wrathful Gladiator's Greaves of Salvation", "=ds=#s12#, #a4#"};
		{ 21, 51364, "", "=q4=Wrathful Gladiator's Bracers of Triumph", "=ds=#s8#, #a4#"};
		{ 22, 51362, "", "=q4=Wrathful Gladiator's Girdle of Triumph", "=ds=#s10#, #a4#"};
		{ 23, 51363, "", "=q4=Wrathful Gladiator's Greaves of Triumph", "=ds=#s12#, #a4#"};
		Prev = "VaultofArchavonToravon625Man";
		Next = "VaultofArchavonToravon825Man";
	};

	AtlasLoot_Data["VaultofArchavonToravon825Man"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Back"]};
		{ 2, 51334, "", "=q4=Wrathful Gladiator's Cloak of Ascendancy", "=ds=#s4#"};
		{ 3, 51348, "", "=q4=Wrathful Gladiator's Cloak of Deliverance", "=ds=#s4#"};
		{ 4, 51330, "", "=q4=Wrathful Gladiator's Cloak of Dominance", "=ds=#s4#"};
		{ 5, 51346, "", "=q4=Wrathful Gladiator's Cloak of Salvation", "=ds=#s4#"};
		{ 6, 51332, "", "=q4=Wrathful Gladiator's Cloak of Subjugation", "=ds=#s4#"};
		{ 7, 51354, "", "=q4=Wrathful Gladiator's Cloak of Triumph", "=ds=#s4#"};
		{ 8, 51356, "", "=q4=Wrathful Gladiator's Cloak of Victory", "=ds=#s4#"};
		{ 11, 49426, "", "=q4=Emblem of Frost", "=ds=#e15#", "", "100%"};
		{ 12, 43959, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m7#", "", ""};
		{ 13, 44083, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m6#", "", ""};
		{ 16, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Neck"]};
		{ 17, 51335, "", "=q4=Wrathful Gladiator's Pendant of Ascendancy", "=ds=#s2#"};
		{ 18, 51349, "", "=q4=Wrathful Gladiator's Pendant of Deliverance", "=ds=#s2#"};
		{ 19, 51331, "", "=q4=Wrathful Gladiator's Pendant of Dominance", "=ds=#s2#"};
		{ 20, 51347, "", "=q4=Wrathful Gladiator's Pendant of Salvation", "=ds=#s2#"};
		{ 21, 51333, "", "=q4=Wrathful Gladiator's Pendant of Subjugation", "=ds=#s2#"};
		{ 22, 51353, "", "=q4=Wrathful Gladiator's Pendant of Sundering", "=ds=#s2#"};
		{ 23, 51355, "", "=q4=Wrathful Gladiator's Pendant of Triumph", "=ds=#s2#"};
		{ 24, 51357, "", "=q4=Wrathful Gladiator's Pendant of Victory", "=ds=#s2#"};
		{ 26, 0, "INV_Box_01", "=q6="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Ring"]};
		{ 27, 51336, "", "=q4=Wrathful Gladiator's Band of Dominance", "=ds=#s13#"};
		{ 28, 51358, "", "=q4=Wrathful Gladiator's Band of Triumph", "=ds=#s13#"};
		Prev = "VaultofArchavonToravon725Man";
	};

		-----------------
		--- Naxxramas ---
		-----------------

		-------------------------
		--- Construct Quarter ---
		-------------------------

	AtlasLoot_Data["Naxx80Patchwerk"] = {
		{ 1, 39272, "", "=q4=Drape of Surgery", "=ds=#s4#", "", "10%"};
		{ 2, 39273, "", "=q4=Sullen Cloth Boots", "=ds=#s12#, #a1#", "", "10%"};
		{ 3, 39275, "", "=q4=Contagion Gloves", "=ds=#s9#, #a2#", "", "10%"};
		{ 4, 39274, "", "=q4=Retcher's Shoulderpads", "=ds=#s3#, #a3#", "", "10%"};
		{ 5, 39267, "", "=q4=Abomination Shoulderblades", "=ds=#s3#, #a4#", "", "13%"};
		{ 6, 39262, "", "=q4=Gauntlets of Combined Strength", "=ds=#s9#, #a4#", "", "24%"};
		{ 7, 39261, "", "=q4=Tainted Girdle of Mending", "=ds=#s10#, #a4#", "", "13%"};
		{ 8, 39271, "", "=q4=Blade of Dormant Memories", "=ds=#h3#, #w4#", "", "10%"};
		{ 9, 39270, "", "=q4=Hatestrike", "=ds=#h1#, #w10#", "", "13%"};
		Next = "Naxx80Grobbulus";
	};

	AtlasLoot_Data["Naxx80Patchwerk25Man"] = {
		{ 1, 40271, "", "=q4=Sash of Solitude", "=ds=#s10#, #a1#", "", "19%"};
		{ 2, 40269, "", "=q4=Boots of Persuasion", "=ds=#s12#, #a1#", "", "9%"};
		{ 3, 40260, "", "=q4=Belt of the Tortured", "=ds=#s10#, #a2#", "", "9%"};
		{ 4, 40270, "", "=q4=Boots of Septic Wounds", "=ds=#s12#, #a2#", "", "9%"};
		{ 5, 40262, "", "=q4=Gloves of Calculated Risk", "=ds=#s9#, #a3#", "", "9%"};
		{ 6, 40272, "", "=q4=Girdle of the Gambit", "=ds=#s10#, #a3#", "", "9%"};
		{ 7, 40261, "", "=q4=Crude Discolored Battlegrips", "=ds=#s9#, #a4#", "", "9%"};
		{ 8, 40263, "", "=q4=Fleshless Girdle", "=ds=#s10#. #a4#", "", "19%"};
		{ 9, 40259, "", "=q4=Waistguard of Divine Grace", "=ds=#s10#, #a4#", "", "9%"};
		{ 10, 40071, "", "=q4=Chains of Adoration", "=ds=#s2#", "", "11%"};
		{ 11, 40065, "", "=q4=Fool's Trial", "=ds=#s2#", "", "11%"};
		{ 12, 40069, "", "=q4=Heritage", "=ds=#s2#", "", "11%"};
		{ 13, 40064, "", "=q4=Thunderstorm Amulet", "=ds=#s2#", "", "11%"};
		{ 14, 40080, "", "=q4=Lost Jewel", "=ds=#s13#", "", "11%"};
		{ 15, 40075, "", "=q4=Ruthlessness", "=ds=#s13#", "", "11%"};
		{ 16, 40107, "", "=q4=Sand-Worn Band", "=ds=#s13#", "", "11%"};
		{ 17, 40074, "", "=q4=Strong-Handed Ring", "=ds=#s13#", "", "12%"};
		{ 18, 40273, "", "=q4=Surplus Limb", "=ds=#s15#", "", "9%"};
		{ 19, 40267, "", "=q4=Totem of Hex", "=ds=#s16#, #w15#", "", "9%"};
		{ 20, 40268, "", "=q4=Libram of Tolerance", "=ds=#s16#, #w16#", "", "19%"};
		{ 21, 40264, "", "=q4=Split Greathammer", "=ds=#h1#, #w6#", "", "9%"};
		{ 22, 40266, "", "=q4=Hero's Surrender", "=ds=#w8#", "", "9%"};
		{ 23, 40265, "", "=q4=Arrowsong", "=ds=#w2#", "", "19%"};
		Next = "Naxx80Grobbulus25Man";
	};

	AtlasLoot_Data["Naxx80Grobbulus"] = {
		{ 1, 39284, "", "=q4=Miasma Mantle", "=ds=#s3#, #a1#", "", "18%"};
		{ 2, 39285, "", "=q4=Handgrips of Turmoil", "=ds=#s9#, #a1#", "", "10%"};
		{ 3, 39283, "", "=q4=Putrescent Bands", "=ds=#s8#, #a2#", "", "10%"};
		{ 4, 39279, "", "=q4=Blistered Belt of Decay", "=ds=#s10#, #a2#", "", "9%"};
		{ 5, 39278, "", "=q4=Bands of Anxiety", "=ds=#s8#, #a3#", "", "9%"};
		{ 6, 39280, "", "=q4=Leggings of Innumerable Barbs", "=ds=#s11#, #a4#", "", "10%"};
		{ 7, 39282, "", "=q4=Bone-Linked Amulet", "=ds=#s2#", "", "10%"};
		{ 8, 39277, "", "=q4=Sealing Ring of Grobbulus", "=ds=#s13#", "", "9%"};
		{ 9, 39281, "", "=q4=Infection Repulser", "=ds=#h3#, #w6#", "", "19%"};
		{ 10, 39276, "", "=q4=The Skull of Ruin", "=ds=#w8#", "", "9%"};
		Prev = "Naxx80Patchwerk";
		Next = "Naxx80Gluth1";
	};

	AtlasLoot_Data["Naxx80Grobbulus25Man"] = {
		{ 1, 40250, "", "=q4=Aged Winter Cloak", "=ds=#s4#", "", "11%"};
		{ 2, 40254, "", "=q4=Cloak of Averted Crisis", "=ds=#s4#", "", "11%"};
		{ 3, 40252, "", "=q4=Cloak of the Shadowed Sun", "=ds=#s4#", "", "11%"};
		{ 4, 40253, "", "=q4=Shawl of the Old Maid", "=ds=#s4#", "", "11%"};
		{ 5, 40251, "", "=q4=Shroud of Luminosity", "=ds=#s4#", "", "11%"};
		{ 6, 40287, "", "=q4=Cowl of Vanity", "=ds=#s1#, #a1#", "", "19%"};
		{ 7, 40286, "", "=q4=Mantle of the Corrupted", "=ds=#s3#, #a1#", "", "1%"};
		{ 8, 40351, "", "=q4=Mantle of the Fatigued Sage", "=ds=#s3#, #a1#", "", "19%"};
		{ 9, 40289, "", "=q4=Sympathetic Amice", "=ds=#s3#, #a1#", "", "9%"};
		{ 10, 40277, "", "=q4=Tunic of Indulgence", "=ds=#s5#, #a2#", "", "18%"};
		{ 11, 40285, "", "=q4=Desecrated Past", "=ds=#s11#, #a2#", "", "9%"};
		{ 12, 40288, "", "=q4=Spaulders of Incoherence", "=ds=#s3#, #a3#", "", "19%"};
		{ 13, 40283, "", "=q4=Fallout Impervious Tunic", "=ds=#s5#, #a3#", "", "9%"};
		{ 14, 40282, "", "=q4=Slime Stream Bands", "=ds=#s8#, #a3#", "", "9%"};
		{ 15, 40275, "", "=q4=Depraved Linked Belt", "=ds=#s10#, #a3#", "", "9%"};
		{ 16, 40279, "", "=q4=Chestguard of the Exhausted", "=ds=#s5#, #a4#", "", "9%"};
		{ 17, 40274, "", "=q4=Bracers of Liberation", "=ds=#s8#, #a4#", "", "18%"};
		{ 18, 40278, "", "=q4=Girdle of Chivalry", "=ds=#s10#, #a4#", "", "9%"};
		{ 19, 40257, "", "=q4=Defender's Code", "=ds=#s14#", "", "11%"};
		{ 20, 40255, "", "=q4=Dying Curse", "=ds=#s14#", "", "11%"};
		{ 21, 40258, "", "=q4=Forethought Talisman", "=ds=#s14#", "", "11%"};
		{ 22, 40256, "", "=q4=Grim Toll", "=ds=#s14#", "", "11%"};
		{ 23, 40281, "", "=q4=Twilight Mist", "=ds=#h1#, #w4#", "", "19%"};
		{ 24, 40280, "", "=q4=Origin of Nightmares", "=ds=#w9#", "", "9%"};
		{ 25, 40284, "", "=q4=Plague Igniter", "=ds=#w12#", "", "9%"};
		Prev = "Naxx80Patchwerk25Man";
		Next = "Naxx80Gluth125Man";
	};

	AtlasLoot_Data["Naxx80Gluth1"] = {
		{ 1, 39272, "", "=q4=Drape of Surgery", "=ds=#s4#", "", "10%"};
		{ 2, 39284, "", "=q4=Miasma Mantle", "=ds=#s3#, #a1#", "", "18%"};
		{ 3, 39396, "", "=q4=Gown of Blaumeux", "=ds=#s5#, #a1#", "", "0.43%"};
		{ 4, 39309, "", "=q4=Leggings of the Instructor", "=ds=#s11#, #a1#", "", "10%"};
		{ 5, 39237, "", "=q4=Spaulders of Resumed Battle", "=ds=#s3#, #a2#", "", "10%"};
		{ 6, 39279, "", "=q4=Blistered Belt of Decay", "=ds=#s10#, #a2#", "", "9%"};
		{ 7, 39191, "", "=q4=Splint-Bound Leggings", "=ds=#s11#, #a2#", "", "11%"};
		{ 8, 39215, "", "=q4=Boots of the Follower", "=ds=#s12#, #a2#", "", "11%"};
		{ 9, 39294, "", "=q4=Arc-Scorched Helmet", "=ds=#s1#, #a3#", "", "9%"};
		{ 10, 39248, "", "=q4=Tunic of the Lost Pack", "=ds=#s5#, #a3#", "", "10%"};
		{ 11, 39194, "", "=q4=Rusted-Link Spiked Gauntlets", "=ds=#s9#, #a3#", "", "10%"};
		{ 12, 39251, "", "=q4=Necrogenic Belt", "=ds=#s10#, #a3#", "", "10%"};
		{ 13, 39379, "", "=q4=Spectral Rider's Girdle", "=ds=#s10#, #a3#", "", "10%"};
		{ 14, 39188, "", "=q4=Chivalric Chestguard", "=ds=#s5#, #a4#", "", "10%"};
		{ 15, 39345, "", "=q4=Girdle of the Ascended Phantom", "=ds=#s10#, #a4#", "", "20%"};
		{ 16, 39146, "", "=q4=Collar of Dissolution", "=ds=#s2#", "", "10%"};
		{ 17, 39232, "", "=q4=Pendant of Lost Vocations", "=ds=#s2#", "", "10%"};
		{ 18, 39193, "", "=q4=Band of Neglected Pleas", "=ds=#s13#", "", "11%"};
		{ 19, 39388, "", "=q4=Spirit-World Glass", "=ds=#s14#", "", "10%"};
		{ 20, 39200, "", "=q4=Grieving Spellblade", "=ds=#h3#, #w10#", "", "11%"};
		{ 21, 39344, "", "=q4=Slayer of the Lifeless", "=ds=#h1#, #w10#", "", "10%"};
		{ 22, 39281, "", "=q4=Infection Repulser", "=ds=#h3#, #w6#", "", "19%"};
		{ 23, 39394, "", "=q4=Charmed Cierge", "=ds=#w9#", "", "0.44%"};
		Prev = "Naxx80Grobbulus";
		Next = "Naxx80Gluth2";
	};

	AtlasLoot_Data["Naxx80Gluth2"] = {
		{ 1, 40622, "", "=q4=Spaulders of the Lost Conqueror", "=ds=#e15#", "", "29%"};
		{ 2, 40623, "", "=q4=Spaulders of the Lost Protector", "=ds=#e15#", "", "30%"};
		{ 3, 40624, "", "=q4=Spaulders of the Lost Vanquisher", "=ds=#e15#", "", "38%"};
		{ 4, 40610, "", "=q4=Chestguard of the Lost Conqueror", "=ds=#e15#", "", "9%"};
		{ 5, 40611, "", "=q4=Chestguard of the Lost Protector", "=ds=#e15#", "", "9%"};
		{ 6, 40612, "", "=q4=Chestguard of the Lost Vanquisher", "=ds=#e15#", "", "12%"};
		{ 7, 40619, "", "=q4=Leggings of the Lost Conqueror", "=ds=#e15#", "", "27%"};
		{ 8, 40620, "", "=q4=Leggings of the Lost Protector", "=ds=#e15#", "", "28%"};
		{ 9, 40621, "", "=q4=Leggings of the Lost Vanquisher", "=ds=#e15#", "", "36%"};
		Prev = "Naxx80Gluth1";
		Next = "Naxx80Thaddius";
	};

	AtlasLoot_Data["Naxx80Gluth125Man"] = {
		{ 1, 40247, "", "=q4=Cowl of Innocent Delight", "=ds=#s1#, #a1#", "", "9%"};
		{ 2, 40289, "", "=q4=Sympathetic Amice", "=ds=#s3#, #a1#", "", "9%"};
		{ 3, 40602, "", "=q4=Robes of Mutation", "=ds=#s5#, #a1#", "", "19%"};
		{ 4, 39733, "", "=q4=Gloves of Token Respect", "=ds=#s9#, #a1#", "", "19%"};
		{ 5, 40303, "", "=q4=Wraps of the Persecuted", "=ds=#s9#, #a1#", "", "9%"};
		{ 6, 40326, "", "=q4=Boots of Forlorn Wishes", "=ds=#s12#, #a1#", "", "20%"};
		{ 7, 40296, "", "=q4=Cover of Silence", "=ds=#s1#, #a2#", "", "8%"};
		{ 8, 39768, "", "=q4=Cowl of the Perished", "=ds=#s1#, #a2#", "", "9%"};
		{ 9, 40319, "", "=q4=Chestpiece of Suspicion", "=ds=#s5#, #a2#", "", "9%"};
		{ 10, 40260, "", "=q4=Belt of the Tortured", "=ds=#s10#, #a2#", "", "9%"};
		{ 11, 40205, "", "=q4=Stalk-Skin Belt", "=ds=#s10#, #a2#", "", "9%"};
		{ 12, 40270, "", "=q4=Boots of Septic Wounds", "=ds=#s12#, #a2#", "", "9%"};
		{ 13, 40193, "", "=q4=Tunic of Masked Suffering", "=ds=#s5#, #a3#", "", "20%"};
		{ 14, 40209, "", "=q4=Bindings of the Decrepit", "=ds=#s8#, #a3#", "", "9%"};
		{ 15, 40302, "", "=q4=Benefactor's Gauntlets", "=ds=#s9#, #a3#", "", "8%"};
		{ 16, 39718, "", "=q4=Corpse Scarab Handguards", "=ds=#s9#, #a3#", "", "9%"};
		{ 17, 40242, "", "=q4=Grotesque Handgrips", "=ds=#s9#, #a3#", "", "19%"};
		{ 18, 39760, "", "=q4=Helm of Diminished Pride", "=ds=#s1#, #a4#", "", "18%"};
		{ 19, 40185, "", "=q4=Shoulderguards of Opportunity", "=ds=#s3#, #a4#", "", "9%"};
		{ 20, 40203, "", "=q4=Breastplate of Tormented Rage", "=ds=#s5#, #a4#", "", "18%"};
		{ 21, 40332, "", "=q4=Abetment Bracers", "=ds=#s8#, #a4#", "", "19%"};
		{ 22, 40188, "", "=q4=Gauntlets of the Disobediant", "=ds=#s9#, #a4#", "", "9%"};
		{ 23, 40259, "", "=q4=Waistguard of Divine Grace", "=ds=#s10#, #a4#", "", "9%"};
		{ 24, 40204, "", "=q4=Legguards of the Apostle", "=ds=#s11#, #a4#", "", "9%"};
		{ 25, 39717, "", "=q4=Inexorable Sabatons", "=ds=#s12#, #a4#", "", "23%"};
		{ 26, 40206, "", "=q4=Iron-Spring Jumpers", "=ds=#s12#, #a4#", "", "9%"};
		{ 27, 40297, "", "=q4=Sabatons of Endurance", "=ds=#s12#, #a4#", "", "17%"};
		{ 28, 40350, "", "=q4=Urn of Lost Memories", "=ds=#s15#", "", "1%"};
		{ 29, 40191, "", "=q4=Libram of Radiance", "=ds=#s16#, #w16#", "", "9%"};
		Prev = "Naxx80Grobbulus25Man";
		Next = "Naxx80Gluth225Man";
	};

	AtlasLoot_Data["Naxx80Gluth225Man"] = {
		{ 1, 40281, "", "=q4=Twilight Mist", "=ds=#h1#, #w4#", "", "19%"};
		{ 2, 39714, "", "=q4=Webbed Death", "=ds=#h1#, #w4#", "", "24%"};
		{ 3, 39730, "", "=q4=Widow's Fury", "=ds=#h1#, #w10#", "", "9%"};
		{ 4, 40343, "", "=q4=Armageddon", "=ds=#h2#, #w10#", "", "1%"};
		{ 5, 40239, "", "=q4=The Hand of Nerub", "=ds=#h4#, #w13#", "", "19%"};
		{ 6, 40280, "", "=q4=Origin of Nightmares", "=ds=#w9#", "", "9%"};
		{ 7, 39716, "", "=q4=Shield of Assimilation", "=ds=#w8#", "", "24%"};
		{ 8, 40265, "", "=q4=Arrowsong", "=ds=#w2#", "", "19%"};
		{ 9, 40346, "", "=q4=Final Voyage", "=ds=#w3#", "", "1%"};
		{ 16, 40637, "", "=q4=Mantle of the Lost Conqueror", "=ds=#e15#", "", "57%"};
		{ 17, 40638, "", "=q4=Mantle of the Lost Protector", "=ds=#e15#", "", "58%"};
		{ 18, 40639, "", "=q4=Mantle of the Lost Vanquisher", "=ds=#e15#", "", "76%"};
		{ 19, 40625, "", "=q4=Breastplate of the Lost Conqueror", "=ds=#e15#", "", "17%"};
		{ 20, 40626, "", "=q4=Breastplate of the Lost Protector", "=ds=#e15#", "", "19%"};
		{ 21, 40627, "", "=q4=Breastplate of the Lost Vanquisher", "=ds=#e15#", "", "24%"};
		{ 22, 40634, "", "=q4=Legplates of the Lost Conqueror", "=ds=#e15#", "", "56%"};
		{ 23, 40635, "", "=q4=Legplates of the Lost Protector", "=ds=#e15#", "", "58%"};
		{ 24, 40636, "", "=q4=Legplates of the Lost Vanquisher", "=ds=#e15#", "", "76%"};
		Prev = "Naxx80Gluth125Man";
		Next = "Naxx80Thaddius25Man";
	};

	AtlasLoot_Data["Naxx80Thaddius"] = {
		{ 1, 39295, "", "=q4=Cowl of Sheet Lightning", "=ds=#s1#, #a1#", "", "9%"};
		{ 2, 39294, "", "=q4=Arc-Scorched Helmet", "=ds=#s1#, #a3#", "", "9%"};
		{ 3, 39293, "", "=q4=Blackened Legplates of Feugen", "=ds=#s11#, #a4#", "", "9%"};
		{ 4, 39292, "", "=q4=Repelling Charge", "=ds=#s14#", "", "9%"};
		{ 5, 39291, "", "=q4=Torment of the Banished", "=ds=#h1#, #w10#", "", "9%"};
		{ 16, 40619, "", "=q4=Leggings of the Lost Conqueror", "=ds=#e15#", "", "27%"};
		{ 17, 40620, "", "=q4=Leggings of the Lost Protector", "=ds=#e15#", "", "28%"};
		{ 18, 40621, "", "=q4=Leggings of the Lost Vanquisher", "=ds=#e15#", "", "36%"};
		Prev = "Naxx80Gluth2";
	};

	AtlasLoot_Data["Naxx80Thaddius25Man"] = {
		{ 1, 40303, "", "=q4=Wraps of the Persecuted", "=ds=#s9#, #a1#", "", "9%"};
		{ 2, 40301, "", "=q4=Cincture of Polarity", "=ds=#s10#, #a1#", "", "9%"};
		{ 3, 40296, "", "=q4=Cover of Silence", "=ds=#s1#, #a2#", "", "8%"};
		{ 4, 40304, "", "=q4=Headpiece of Fungal Bloom", "=ds=#s1#, #a2#", "", "9%"};
		{ 5, 40299, "", "=q4=Pauldrons of the Abandoned", "=ds=#s3#, #a3#", "", "9%"};
		{ 6, 40302, "", "=q4=Benefactor's Gauntlets", "=ds=#s9#, #a3#", "", "8%"};
		{ 7, 40298, "", "=q4=Faceguard of the Succumbed", "=ds=#s1#, #a4#", "", "9%"};
		{ 8, 40294, "", "=q4=Riveted Abomination Leggings", "=ds=#s11#, #a4#", "", "8%"};
		{ 9, 40297, "", "=q4=Sabatons of Endurance", "=ds=#s12#, #a4#", "", "17%"};
		{ 10, 40300, "", "=q4=Spire of Sunset", "=ds=#w9#", "", "9%"};
		{ 16, 40634, "", "=q4=Legplates of the Lost Conqueror", "=ds=#e15#", "", "56%"};
		{ 17, 40635, "", "=q4=Legplates of the Lost Protector", "=ds=#e15#", "", "58%"};
		{ 18, 40636, "", "=q4=Legplates of the Lost Vanquisher", "=ds=#e15#", "", "76%"};
		Prev = "Naxx80Gluth225Man";
	};

		------------------------
		--- Arachnid Quarter ---
		------------------------

	AtlasLoot_Data["Naxx80AnubRekhan"] = {
		{ 1, 39192, "", "=q4=Gloves of Dark Gestures", "=ds=#s9#, #a1#", "", "10%"};
		{ 2, 39190, "", "=q4=Agonal Sash", "=ds=#s10#, #a1#", "", "10%"};
		{ 3, 39191, "", "=q4=Splint-Bound Leggings", "=ds=#s11#, #a2#", "", "11%"};
		{ 4, 39189, "", "=q4=Boots of Persistence", "=ds=#s12#, #a3#", "", "10%"};
		{ 5, 39188, "", "=q4=Chivalric Chestguard", "=ds=#s5#, #a4#", "", "10%"};
		{ 6, 39139, "", "=q4=Ravaging Sabatons", "=ds=#s12#, #a4#", "", "11%"};
		{ 7, 39146, "", "=q4=Collar of Dissolution", "=ds=#s2#", "", "10%"};
		{ 8, 39193, "", "=q4=Band of Neglected Pleas", "=ds=#s13#", "", "11%"};
		{ 9, 39141, "", "=q4=Deflection Band", "=ds=#s13#", "", "10%"};
		{ 10, 39140, "", "=q4=Knife of Incision", "=ds=#h1#, #w4#", "", "11%"};
		Next = "Naxx80Faerlina";
	};

	AtlasLoot_Data["Naxx80AnubRekhan25Man"] = {
		{ 1, 39719, "", "=q4=Mantle of the Locusts", "=ds=#s3#, #a1#", "", "9%"};
		{ 2, 39721, "", "=q4=Sash of the Parlor", "=ds=#s10#, #a1#", "", "19%"};
		{ 3, 39720, "", "=q4=Leggings of Atrophy", "=ds=#s11#, #a1#", "", "9%"};
		{ 4, 39722, "", "=q4=Swarm Bindings", "=ds=#s8#, #a2#", "", "9%"};
		{ 5, 39701, "", "=q4=Dawnwalkers", "=ds=#s12#, #a2#", "", "19%"};
		{ 6, 39702, "", "=q4=Arachnoid Gold Band", "=ds=#s8#, #a3#", "", "8%"};
		{ 7, 39718, "", "=q4=Corpse Scarab Handguards", "=ds=#s9#, #a3#", "", "9%"};
		{ 8, 39704, "", "=q4=Pauldrons of Unnatural Death", "=ds=#s3#, #a4#", "", "19%"};
		{ 9, 39703, "", "=q4=Rescinding Grips", "=ds=#s9#, #a4#", "", "19%"};
		{ 10, 39717, "", "=q4=Inexorable Sabatons", "=ds=#s12#, #a4#", "", "23%"};
		{ 11, 39706, "", "=q4=Sabatons of Sudden Reprisal", "=ds=#s12#, #a4#", "", "9%"};
		{ 12, 40071, "", "=q4=Chains of Adoration", "=ds=#s2#", "", "11%"};
		{ 13, 40065, "", "=q4=Fool's Trial", "=ds=#s2#", "", "11%"};
		{ 14, 40069, "", "=q4=Heritage", "=ds=#s2#", "", "11%"};
		{ 15, 40064, "", "=q4=Thunderstorm Amulet", "=ds=#s2#", "", "11%"};
		{ 16, 40080, "", "=q4=Lost Jewel", "=ds=#s13#", "", "11%"};
		{ 17, 40075, "", "=q4=Ruthlessness", "=ds=#s13#", "", "11%"};
		{ 18, 40107, "", "=q4=Sand-Worn Band", "=ds=#s13#", "", "11%"};
		{ 19, 40074, "", "=q4=Strong-Handed Ring", "=ds=#s13#", "", "12%"};
		{ 20, 39714, "", "=q4=Webbed Death", "=ds=#h1#, #w4#", "", "24%"};
		{ 21, 40208, "", "=q4=Cryptfiend's Bite", "=ds=#w7#", "", "10%"};
		{ 22, 39716, "", "=q4=Shield of Assimilation", "=ds=#w8#", "", "24%"};
		{ 23, 39712, "", "=q4=Gemmed Wand of the Nerubians", "=ds=#w12#", "", "24%"};
		Next = "Naxx80Faerlina25Man";
	};

	AtlasLoot_Data["Naxx80Faerlina"] = {
		{ 1, 39216, "", "=q4=Sash of Mortal Desire", "=ds=#s10#, #a1#", "", "10%"};
		{ 2, 39215, "", "=q4=Boots of the Follower", "=ds=#s12#, #a2#", "", "11%"};
		{ 3, 39196, "", "=q4=Boots of the Worshiper", "=ds=#s12#, #a2#", "", "11%"};
		{ 4, 39217, "", "=q4=Avenging Combat Leggings", "=ds=#s11#, #a3#", "", "11%"};
		{ 5, 39194, "", "=q4=Rusted-Link Spiked Gauntlets", "=ds=#s9#, #a3#", "", "10%"};
		{ 6, 39198, "", "=q4=Frostblight Pauldrons", "=ds=#s3#, #a4#", "", "10%"};
		{ 7, 39195, "", "=q4=Bracers of Lost Sentiments", "=ds=#s8#, #a4#", "", "11%"};
		{ 8, 39197, "", "=q4=Gauntlets of the Master", "=ds=#s9#, #a4#", "", "10%"};
		{ 9, 39199, "", "=q4=Watchful Eye", "=ds=#s15#", "", "11%"};
		{ 10, 39200, "", "=q4=Grieving Spellblade", "=ds=#h3#, #w10#", "", "11%"};
		Prev = "Naxx80AnubRekhan";
		Next = "Naxx80Maexxna";
	};

	AtlasLoot_Data["Naxx80Faerlina25Man"] = {
		{ 1, 39732, "", "=q4=Faerlina's Madness", "=ds=#s1#, #a1#", "", "8%"};
		{ 2, 39731, "", "=q4=Punctilious Bindings", "=ds=#s8#, #a1#", "", "9%"};
		{ 3, 39733, "", "=q4=Gloves of Token Respect", "=ds=#s9#, #a1#", "", "19%"};
		{ 4, 39735, "", "=q4=Belt of False Dignity", "=ds=#s10#, #a1#", "", "9%"};
		{ 5, 39756, "", "=q4=Tunic of Prejudice", "=ds=#s5#, #a2#", "", "19%"};
		{ 6, 39727, "", "=q4=Dislocating Handguards", "=ds=#s9#, #a2#", "", "10%"};
		{ 7, 39724, "", "=q4=Cult's Chestguard", "=ds=#s5#, #a3#"};
		{ 8, 39734, "", "=q4=Atonement Greaves", "=ds=#s12#, #a3#", "", "8%"};
		{ 9, 39723, "", "=q4=Fire-Scorched Greathelm", "=ds=#s1#, #a4#", "", "23%"};
		{ 10, 39725, "", "=q4=Epaulets of the Grieving Servant", "=ds=#s3#, #a4#", "", "11%"};
		{ 11, 39729, "", "=q4=Bracers of the Tyrant", "=ds=#s8#, #a4#", "", "8%"};
		{ 12, 39726, "", "=q4=Callous-Hearted Gauntlets", "=ds=#s9#, #a4#", "", "24%"};
		{ 13, 40071, "", "=q4=Chains of Adoration", "=ds=#s2#", "", "11%"};
		{ 14, 40065, "", "=q4=Fool's Trial", "=ds=#s2#", "", "11%"};
		{ 15, 40069, "", "=q4=Heritage", "=ds=#s2#", "", "11%"};
		{ 16, 40064, "", "=q4=Thunderstorm Amulet", "=ds=#s2#", "", "11%"};
		{ 17, 40080, "", "=q4=Lost Jewel", "=ds=#s13#", "", "11%"};
		{ 18, 40075, "", "=q4=Ruthlessness", "=ds=#s13#", "", "11%"};
		{ 19, 40107, "", "=q4=Sand-Worn Band", "=ds=#s13#", "", "11%"};
		{ 20, 40108, "", "=q4=Seized Beauty", "=ds=#s13#", "", "11%"};
		{ 21, 40074, "", "=q4=Strong-Handed Ring", "=ds=#s13#", "", "12%"};
		{ 22, 39757, "", "=q4=Idol of Worship", "=ds=#s16#, #w14#", "", "9%"};
		{ 23, 39728, "", "=q4=Totem of Misery", "=ds=#s16#, #w15#", "", "9%"};
		{ 24, 39730, "", "=q4=Widow's Fury", "=ds=#h1#, #w10#", "", "9%"};
		Prev = "Naxx80AnubRekhan25Man";
		Next = "Naxx80Maexxna25Man";
	};

	AtlasLoot_Data["Naxx80Maexxna"] = {
		{ 1, 39225, "", "=q4=Cloak of Armed Strife", "=ds=#s4#", "", "10%"};
		{ 2, 39230, "", "=q4=Spaulders of the Monstrosity", "=ds=#s3#, #a2#", "", "11%"};
		{ 3, 39224, "", "=q4=Leggings of Discord", "=ds=#s11#, #a2#", "", "10%"};
		{ 4, 39228, "", "=q4=Web Cocoon Grips", "=ds=#s9#, #a4#", "", "10%"};
		{ 5, 39232, "", "=q4=Pendant of Lost Vocations", "=ds=#s2#", "", "10%"};
		{ 6, 39231, "", "=q4=Timeworn Silken Band", "=ds=#s13#", "", "10%"};
		{ 7, 39229, "", "=q4=Embrace of the Spider", "=ds=#s14#", "", "11%"};
		{ 8, 39226, "", "=q4=Maexxna's Femur", "=ds=#h1#, #w6#", "", "10%"};
		{ 9, 39221, "", "=q4=Wraith Spear", "=ds=#w7#", "", "10%"};
		{ 10, 39233, "", "=q4=Aegis of Damnation", "=ds=#w8#", "", "10%"};
		Prev = "Naxx80Faerlina";
	};

	AtlasLoot_Data["Naxx80Maexxna25Man"] = {
		{ 1, 40250, "", "-q4-Aged Winter Cloak", "=ds=#s4#", "", "11%"};
		{ 2, 40254, "", "=q4=Cloak of Averted Crisis", "=ds=#s4#", "", "11%"};
		{ 3, 40252, "", "=q4=Cloak of the Shadowed Sun", "=ds=#s4#", "", "11%"};
		{ 4, 40253, "", "=q4=Shawl of the Old Maid", "=ds=#s4#", "", "11%"};
		{ 5, 40251, "", "=q4=Shroud of Luminosity", "=ds=#s4#", "", "11%"};
		{ 6, 40062, "", "=q4=Digested Silken Robes", "=ds=#s5#, #a1#", "", "9%"};
		{ 7, 40060, "", "=q4=Distorted Limbs", "=ds=#s11#, #a1#", "", "9%"};
		{ 8, 39768, "", "=q4=Cowl of the Perished", "=ds=#s1#, #a2#", "", "9%"};
		{ 9, 40063, "", "=q4=Mantle of Shattered Kinship", "=ds=#s3#, #a2#", "", "9%"};
		{ 10, 39765, "", "=q4=Sinner's Bindings", "=ds=#s8#, #a2#", "", "19%"};
		{ 11, 39761, "", "=q4=Infectious Skitterer Leggings", "=ds=#s11#, #a2#", "", "8%"};
		{ 12, 40061, "", "=q4=Quivering Tunic", "=ds=#s5#, #a3#", "", "19%"};
		{ 13, 39762, "", "=q4=Torn Web Wrapping", "=ds=#s10#, #a3#", "", "9%"};
		{ 14, 39760, "", "=q4=Helm of Diminished Pride", "=ds=#s1#, #a4#", "", "18%"};
		{ 15, 39767, "", "=q4=Undiminished Battleplate", "=ds=#s5#, #a4#", "", "9%"};
		{ 16, 39764, "", "=q4=Bindings of the Hapless Prey", "=ds=#s8#, #a4#", "", "9%"};
		{ 17, 39759, "", "=q4=Ablative Chitin Girdle", "=ds=#s10#, #a4#", "", "8%"};
		{ 18, 40257, "", "=q4=Defender's Code", "=ds=#s14#", "", "11%"};
		{ 19, 40255, "", "=q4=Dying Curse", "=ds=#s14#", "", "11%"};
		{ 20, 40258, "", "=q4=Forethought Talisman", "=ds=#s14#", "", "11%"};
		{ 21, 40256, "", "=q4=Grim Toll", "=ds=#s14#", "", "11%"};
		{ 22, 39766, "", "=q4=Matriarch's Spawn", "=ds=#s15#", "", "19%"};
		{ 23, 39763, "", "=q4=Wraith Strike", "=ds=#h3#, #w13#", "", "9%"};
		{ 24, 39758, "", "=q4=The Jawbone", "=ds=#h2#, #w6#", "", "9%"};
		Prev = "Naxx80Faerlina25Man";
	};

		------------------------
		--- Military Quarter ---
		------------------------

	AtlasLoot_Data["Naxx80Razuvious"] = {
		{ 1, 39297, "", "=q4=Cloak of Darkening", "=ds=#s4#", "", "10%"};
		{ 2, 39310, "", "=q4=Mantle of the Extensive Mind", "=ds=#s3#, #a1#", "", "10%"};
		{ 3, 39309, "", "=q4=Leggings of the Instructor", "=ds=#s11#, #a1#", "", "10%"};
		{ 4, 39299, "", "=q4=Rapid Attack Gloves", "=ds=#s9#, #a2#", "", "10%"};
		{ 5, 39308, "", "=q4=Girdle of Lenience", "=ds=#s10#, #a2#", "", "10%"};
		{ 6, 39307, "", "=q4=Iron Rings of Endurance", "=ds=#s8#, #a3#", "", "10%"};
		{ 7, 39306, "", "=q4=Plated Gloves of Relief", "=ds=#s9#, #a4#", "", "10%"};
		{ 8, 39298, "", "=q4=Waistguard of the Tutor", "=ds=#s10#, #a4#", "", "10%"};
		{ 9, 39311, "", "=q4=Scepter of Murmuring Spirits", "=ds=#s15#", "", "10%"};
		{ 10, 39296, "", "=q4=Accursed Bow of the Elite", "=ds=#w2#", "", "10%"};
		Next = "Naxx80Gothik";
	};

	AtlasLoot_Data["Naxx80Razuvious25Man"] = {
		{ 1, 40325, "", "=q4=Bindings of the Expansive Mind", "=ds=#s8#, #a1#", "", "9%"};
		{ 2, 40326, "", "=q4=Boots of Forlorn Wishes", "=ds=#s12#, #a1#", "", "20%"};
		{ 3, 40305, "", "=q4=Spaulders of Egotism", "=ds=#s3#, #a2#", "", "8%"};
		{ 4, 40319, "", "=q4=Chestpiece of Suspicion", "=ds=#s5#, #a2#", "", "9%"};
		{ 5, 40323, "", "=q4=Esteemed Bindings", "=ds=#s8#, #a2#", "", "9%"};
		{ 6, 40315, "", "=q4=Shoulderpads of Secret Arts", "=ds=#s3#, #a3#", "", "9%"};
		{ 7, 40324, "", "=q4=Bands of Mutual Respect", "=ds=#s8#, #a3#", "", "9%"};
		{ 8, 40327, "", "=q4=Girdle of Recuperation", "=ds=#s10#, #a3#", "", "9%"};
		{ 9, 40306, "", "=q4=Bracers of the Unholy Knight", "=ds=#s8#, #a4#", "", "9%"};
		{ 10, 40316, "", "=q4=Gauntlets of Guiding Touch", "=ds=#s9#, #a4#", "", "9%"};
		{ 11, 40317, "", "=q4=Girdle of Razuvious", "=ds=#s10#, #a4#", "", "9%"};
		{ 12, 40318, "", "=q4=Legplates of Double Strikes", "=ds=#s11#, #a4#", "", "9%"};
		{ 13, 40320, "", "=q4=Faithful Steel Sabatons", "=ds=#s12#, #a4#", "", "9%"};
		{ 14, 40071, "", "=q4=Chains of Adoration", "=ds=#s2#", "", "11%"};
		{ 15, 40065, "", "=q4=Fool's Trial", "=ds=#s2#", "", "11%"};
		{ 16, 40069, "", "=q4=Heritage", "=ds=#s2#", "", "11%"};
		{ 17, 40064, "", "=q4=Thunderstorm Amulet", "=ds=#s2#", "", "11%"};
		{ 18, 40080, "", "=q4=Lost Jewel", "=ds=#s13#", "", "11%"};
		{ 19, 40075, "", "=q4=Ruthlessness", "=ds=#s13#", "", "11%"};
		{ 20, 40107, "", "=q4=Sand-Worn Band", "=ds=#s13#", "", "11%"};
		{ 21, 40074, "", "=q4=Strong-Handed Ring", "=ds=#s13#", "", "12%"};
		{ 22, 40321, "", "=q4=Idol of the Shooting Star", "=ds=#s16#, #w14#", "", "9%"};
		{ 23, 40322, "", "=q4=Totem of Dueling", "=ds=#s16#, #w15#", "", "9%"};
		Next = "Naxx80Gothik25Man";
	};

	AtlasLoot_Data["Naxx80Gothik"] = {
		{ 1, 39390, "", "=q4=Resurgent Phantom Bindings", "=ds=#s8#, #a1#", "", "10%"};
		{ 2, 39386, "", "=q4=Tunic of Dislocation", "=ds=#s5#, #a2#", "", "19%"};
		{ 3, 39391, "", "=q4=Heinous Mail Chestguard", "=ds=#s5#, #a3#", "", "11%"};
		{ 4, 39379, "", "=q4=Spectral Rider's Girdle", "=ds=#s10#, #a3#", "", "10%"};
		{ 5, 39345, "", "=q4=Girdle of the Ascended Phantom", "=ds=#s10#, #a4#", "", "20%"};
		{ 6, 39369, "", "=q4=Sabatons of Deathlike Gloom", "=ds=#s12#, #a4#", "", "10%"};
		{ 7, 39392, "", "=q4=Veiled Amulet of Life", "=ds=#s2#", "", "10%"};
		{ 8, 39389, "", "=q4=Signet of the Malevolent", "=ds=#s2#", "", "10%"};
		{ 9, 39388, "", "=q4=Spirit-World Glass", "=ds=#s14#", "", "10%"};
		{ 10, 39344, "", "=q4=Slayer of the Lifeless", "=ds=#h1#, #w10#", "", "10%"};
		Prev = "Naxx80Razuvious";
		Next = "Naxx80FourHorsemen";
	};

	AtlasLoot_Data["Naxx80Gothik25Man"] = {
		{ 1, 40250, "", "-q4-Aged Winter Cloak", "=ds=#s4#", "", "11%"};
		{ 2, 40254, "", "=q4=Cloak of Averted Crisis", "=ds=#s4#", "", "11%"};
		{ 3, 40252, "", "=q4=Cloak of the Shadowed Sun", "=ds=#s4#", "", "11%"};
		{ 4, 40253, "", "=q4=Shawl of the Old Maid", "=ds=#s4#", "", "11%"};
		{ 5, 40251, "", "=q4=Shroud of Luminosity", "=ds=#s4#", "", "11%"};
		{ 6, 40339, "", "=q4=Gothik's Cowl", "=ds=#s1#, #a1#", "", "19%"};
		{ 7, 40338, "", "=q4=Bindings of Yearning", "=ds=#s8#, #a1#", "", "19%"};
		{ 8, 40329, "", "=q4=Hood of the Exodus", "=ds=#s1#, #a2#", "", "9%"};
		{ 9, 40341, "", "=q4=Shackled Cinch", "=ds=#s10#, #a2#", "", "9%"};
		{ 10, 40333, "", "=q4=Leggings of Fleeting Moments", "=ds=#s11#, #a2#", "", "9%"};
		{ 11, 40340, "", "=q4=Helm of Unleashed Energy", "=ds=#s1#, #a3#", "", "9%"};
		{ 12, 40331, "", "=q4=Leggings of Failed Escape", "=ds=#s11#, #a3#", "", "9%"};
		{ 13, 40328, "", "=q4=Helm of Vital Protection", "=ds=#s1#, #a4#", "", "9%"};
		{ 14, 40334, "", "=q4=Burdened Shoulderplates", "=ds=#s3#, #a4#", "", "9%"};
		{ 15, 40332, "", "=q4=Abetment Bracers", "=ds=#s8#, #a4#", "", "19%"};
		{ 16, 40330, "", "=q4=Bracers of Unrelenting Attack", "=ds=#s8#, #a4#", "", "9%"};
		{ 17, 40257, "", "=q4=Defender's Code", "=ds=#s14#", "", "11%"};
		{ 18, 40255, "", "=q4=Dying Curse", "=ds=#s14#", "", "11%"};
		{ 19, 40258, "", "=q4=Forethought Talisman", "=ds=#s14#", "", "11%"};
		{ 20, 40256, "", "=q4=Grim Toll", "=ds=#s14#", "", "11%"};
		{ 21, 40342, "", "=q4=Idol of Awakening", "=ds=#s16#, #w14#", "", "9%"};
		{ 22, 40337, "", "=q4=Libram of Resurgence", "=ds=#s16#, #w16#", "", "19%"};
		{ 23, 40336, "", "=q4=Life and Death", "=ds=#h3#, #w10#", "", "19%"};
		{ 24, 40335, "", "=q4=Touch of Horror", "=ds=#w12#", "", "9%"};
		Prev = "Naxx80Razuvious25Man";
		Next = "Naxx80FourHorsemen25Man";
	};

	AtlasLoot_Data["Naxx80FourHorsemen"] = {
		{ 1, 39396, "", "=q4=Gown of Blaumeux", "=ds=#s5#, #a1#", "", "12%"};
		{ 2, 39397, "", "=q4=Pauldrons of Havoc", "=ds=#s3#, #a3#", "", "12%"};
		{ 3, 39395, "", "=q4=Thane's Tainted Greathelm", "=ds=#s1#, #a4#", "", "12%"};
		{ 4, 39393, "", "=q4=Claymore of Ancient Power", "=ds=#h2#, #w10#", "", "12%"};
		{ 5, 39394, "", "=q4=Charmed Cierge", "=ds=#w9#", "", "12%"};
		{ 16, 40610, "", "=q4=Chestguard of the Lost Conqueror", "=ds=#e15#", "", "18%"};
		{ 17, 40611, "", "=q4=Chestguard of the Lost Protector", "=ds=#e15#", "", "19%"};
		{ 18, 40612, "", "=q4=Chestguard of the Lost Vanquisher", "=ds=#e15#", "", "25%"};
		Prev = "Naxx80Gothik";
	};

	AtlasLoot_Data["Naxx80FourHorsemen25Man"] = {
		{ 1, 40349, "", "=q4=Gloves of Peaceful Death", "=ds=#s9#, #a2#", "", "11%"};
		{ 2, 40344, "", "=q4=Helm of the Grave", "=ds=#s1#, #a3#", "", "10%"};
		{ 3, 40352, "", "=q4=Leggings of Voracious Shadows", "=ds=#s11#, #a3#", "", "10%"};
		{ 4, 40347, "", "=q4=Zeliek's Gauntlets", "=ds=#s9#, #a4#", "", "8%"};
		{ 5, 40350, "", "=q4=Urn of Lost Memories", "=ds=#s15#", "", "10%"};
		{ 6, 40345, "", "=q4=Broken Promise", "=ds=#h1#, #w10#", "", "10%"};
		{ 8, 40343, "", "=q4=Armageddon", "=ds=#h2#, #w10#", "", "9%"};
		{ 7, 40348, "", "=q4=Damnation", "=ds=#w9#", "", "10%"};
		{ 9, 40346, "", "=q4=Final Voyage", "=ds=#w3#", "", "10%"};
		{ 16, 40625, "", "=q4=Breastplate of the Lost Conqueror", "=ds=#e15#", "", "30%"};
		{ 17, 40626, "", "=q4=Breastplate of the Lost Protector", "=ds=#e15#", "", "30%"};
		{ 18, 40627, "", "=q4=Breastplate of the Lost Vanquisher", "=ds=#e15#", "", "40%"};
		Prev = "Naxx80Gothik25Man";
	};

		----------------------
		--- Plague Quarter ---
		----------------------

	AtlasLoot_Data["Naxx80Noth"] = {
		{ 1, 39241, "", "=q4=Dark Shroud of the Scourge", "=ds=#s4#", "", "10%"};
		{ 2, 39242, "", "=q4=Robes of Hoarse Breaths", "=ds=#s5#, #a1#", "", "10%"};
		{ 3, 39240, "", "=q4=Noth's Curse", "=ds=#s1#, #a2#", "", "10%"};
		{ 4, 39237, "", "=q4=Spaulders of Resumed Battle", "=ds=#s3#, #a2#", "", "10%"};
		{ 5, 39243, "", "=q4=Handgrips of the Foredoomed", "=ds=#s9#, #a3#", "", "10%"};
		{ 6, 39236, "", "=q4=Trespasser's Boots", "=ds=#s12#, #a3#", "", "10%"};
		{ 7, 39239, "", "=q4=Chestplate of the Risen Soldier", "=ds=#s5#, #a4#", "", "10%"};
		{ 8, 39235, "", "=q4=Bone-Framed Bracers", "=ds=#s8#, #a4#", "", "10%"};
		{ 9, 39234, "", "=q4=Plague-Impervious Boots", "=ds=#s12#, #a4#", "", "10%"};
		{ 10, 39244, "", "=q4=Ring of the Fated", "=ds=#s13#", "", "10%"};
		Next = "Naxx80Heigan";
	};

	AtlasLoot_Data["Naxx80Noth25Man"] = {
		{ 1, 40602, "", "=q4=Robes of Mutation", "=ds=#s5#, #a1#", "", "19%"};
		{ 2, 40198, "", "=q4=Bands of Impurity", "=ds=#s8#, #a1#", "", "9%"};
		{ 3, 40197, "", "=q4=Gloves of the Fallen Wizard", "=ds=#s9#, #a1#", "", "9%"};
		{ 4, 40186, "", "=q4=Thrusting Bands", "=ds=#s8#, #a2#", "", "9%"};
		{ 5, 40200, "", "=q4=Belt of Potent Chanting", "=ds=#s10#, #a2#", "", "9%"};
		{ 6, 40193, "", "=q4=Tunic of Masked Suffering", "=ds=#s5#, #a3#", "", "20%"};
		{ 7, 40196, "", "=q4=Legguards of the Undisturbed", "=ds=#s11#, #a3#", "", "9%"};
		{ 8, 40184, "", "=q4=Crippled Treads", "=ds=#s12#, #a3#", "", "9%"};
		{ 9, 40185, "", "=q4=Shoulderguards of Opportunity", "=ds=#s3#, #a4#", "", "9%"};
		{ 10, 40188, "", "=q4=Gauntlets of the Disobediant", "=ds=#s9#, #a4#", "", "9%"};
		{ 11, 40187, "", "=q4=Poignant Sabatons", "=ds=#s12#, #a4#", "", "9%"};
		{ 12, 40071, "", "=q4=Chains of Adoration", "=ds=#s2#", "", "11%"};
		{ 13, 40065, "", "=q4=Fool's Trial", "=ds=#s2#", "", "11%"};
		{ 14, 40069, "", "=q4=Heritage", "=ds=#s2#", "", "11%"};
		{ 15, 40064, "", "=q4=Thunderstorm Amulet", "=ds=#s2#", "", "11%"};
		{ 16, 40080, "", "=q4=Lost Jewel", "=ds=#s13#", "", "11%"};
		{ 17, 40075, "", "=q4=Ruthlessness", "=ds=#s13#", "", "11%"};
		{ 18, 40107, "", "=q4=Sand-Worn Band", "=ds=#s13#", "", "11%"};
		{ 29, 40074, "", "=q4=Strong-Handed Ring", "=ds=#s13#", "", "12%"};
		{ 20, 40192, "", "=q4=Accursed Spine", "=ds=#s15#", "", "9%"};
		{ 21, 40191, "", "=q4=Libram of Radiance", "=ds=#s16#, #w16#", "", "9%"};
		{ 22, 40189, "", "=q4=Angry Dread", "=ds=#h1#, #w6#", "", "19%"};
		{ 23, 40190, "", "=q4=Spinning Fate", "=ds=#w11#", "", "9%"};
		Next = "Naxx80Heigan25Man";
	};

	AtlasLoot_Data["Naxx80Heigan"] = {
		{ 1, 39252, "", "=q4=Preceptor's Bindings", "=ds=#s8#, #a1#", "", "9%"};
		{ 2, 39254, "", "=q4=Saltarello Shoes", "=ds=#s12#, #a1#", "", "10%"};
		{ 3, 39247, "", "=q4=Cuffs of Dark Shadows", "=ds=#s8#, #a2#", "", "9%"};
		{ 4, 39248, "", "=q4=Tunic of the Lost Pack", "=ds=#s5#, #a3#", "", "10%"};
		{ 5, 39251, "", "=q4=Necrogenic Belt", "=ds=#s10#, #a3#", "", "10%"};
		{ 6, 39249, "", "=q4=Shoulderplates of Bloodshed", "=ds=#s3#, #a4#", "", "9%"};
		{ 7, 39246, "", "=q4=Amulet of Autopsy", "=ds=#s2#", "", "9%"};
		{ 8, 39250, "", "=q4=Ring of Holy Cleansing", "=ds=#s13#", "", "10%"};
		{ 9, 39245, "", "=q4=Demise", "=ds=#h2#, #w6#", "", "9%"};
		{ 10, 39255, "", "=q4=Staff of the Plague Beast", "=ds=#w9#", "", "9%"};
		Prev = "Naxx80Noth";
		Next = "Naxx80Loatheb";
	};

	AtlasLoot_Data["Naxx80Heigan25Man"] = {
		{ 1, 40250, "", "=q4=Aged Winter Cloak", "=ds=#s4#", "", "11%"};
		{ 2, 40254, "", "=q4=Cloak of Averted Crisis", "=ds=#s4#", "", "11%"};
		{ 3, 40252, "", "=q4=Cloak of the Shadowed Sun", "=ds=#s4#", "", "11%"};
		{ 4, 40253, "", "=q4=Shawl of the Old Maid", "=ds=#s4#", "", "11%"};
		{ 5, 40251, "", "=q4=Shroud of Luminosity", "=ds=#s4#", "", "11%"};
		{ 6, 40234, "", "=q4=Heigan's Putrid Vestments", "=ds=#s5#, #a1#", "", "9%"};
		{ 7, 40236, "", "=q4=Serene Echoes", "=ds=#s12#, #a1#", "", "19%"};
		{ 8, 40238, "", "=q4=Gloves of the Dancing Bear", "=ds=#s9#, #a2#", "", "9%"};
		{ 9, 40205, "", "=q4=Stalk-Skin Belt", "=ds=#s10#, #a2#", "", "9%"};
		{ 10, 40235, "", "=q4=Helm of Pilgrimage", "=ds=#s1#, #a3#", "", "10%"};
		{ 11, 40209, "", "=q4=Bindings of the Decrepit", "=ds=#s8#, #a3#", "", "9%"};
		{ 12, 40201, "", "=q4=Leggings of Colossal Strides", "=ds=#s11#, #a3#", "", "9%"};
		{ 13, 40237, "", "=q4=Eruption-Scared Boots", "=ds=#s12#, #a3#", "", "10%"};
		{ 14, 40203, "", "=q4=Breastplate of Tormented Rage", "=ds=#s5#, #a4#", "", "18%"};
		{ 15, 40210, "", "=q4=Chestguard of Bitter Charms", "=ds=#s5#, #a4#", "", "9%"};
		{ 16, 40204, "", "=q4=Legguards of the Apostle", "=ds=#s11#, #a4#", "", "9%"};
		{ 17, 40206, "", "=q4=Iron-Spring Jumpers", "=ds=#s12#, #a4#", "", "9%"};
		{ 18, 40257, "", "=q4=Defender's Code", "=ds=#s14#", "", "11%"};
		{ 19, 40255, "", "=q4=Dying Curse", "=ds=#s14#", "", "11%"};
		{ 20, 40258, "", "=q4=Forethought Talisman", "=ds=#s14#", "", "11%"};
		{ 21, 40256, "", "=q4=Grim Toll", "=ds=#s14#", "", "11%"};
		{ 22, 40207, "", "=q4=Sigil of Awareness", "=ds=#s16#, #w21#", "", "9%"};
		{ 23, 40208, "", "=q4=Cryptfiend's Bite", "=ds=#w7#", "", "10%"};
		{ 24, 40233, "", "=q4=The Undeath Carrier", "=ds=#w9#", "", "9%"};
		Prev = "Naxx80Noth25Man";
		Next = "Naxx80Loatheb25Man";
	};

	AtlasLoot_Data["Naxx80Loatheb"] = {
		{ 1, 39259, "", "=q4=Fungi-Stained Coverings", "=ds=#s5#, #a2#", "", "10%"};
		{ 2, 39260, "", "=q4=Helm of the Corrupted Mind", "=ds=#s1#, #a4#", "", "10%"};
		{ 3, 39258, "", "=q4=Legplates of Inescapable Death", "=ds=#s11#, #a4#", "", "10%"};
		{ 4, 39257, "", "=q4=Loatheb's Shadow", "=ds=#s14#", "", "10%"};
		{ 5, 39256, "", "=q4=Sulfur Stave", "=ds=#w9#", "", "10%"};
		{ 16, 40622, "", "=q4=Spaulders of the Lost Conqueror", "=ds=#e15#", "", "29%"};
		{ 17, 40623, "", "=q4=Spaulders of the Lost Protector", "=ds=#e15#", "", "30%"};
		{ 18, 40624, "", "=q4=Spaulders of the Lost Vanquisher", "=ds=#e15#", "", "38%"};
		Prev = "Naxx80Heigan";
	};

	AtlasLoot_Data["Naxx80Loatheb25Man"] = {
		{ 1, 40247, "", "=q4=Cowl of Innocent Delight", "=ds=#s1#, #a1#", "", "9%"};
		{ 2, 40246, "", "=q4=Boots of Impetuous Ideals", "=ds=#s12#, #a1#", "", "9%"};
		{ 3, 40249, "", "=q4=Vest of Vitality", "=ds=#s5#, #a2#", "", "10%"};
		{ 4, 40243, "", "=q4=Footwraps of Vile Deceit", "=ds=#s12#, #a2#", "", "10%"};
		{ 5, 40242, "", "=q4=Grotesque Handgrips", "=ds=#s9#, #a3#", "", "19%"};
		{ 6, 40241, "", "=q4=Girdle of Unity", "=ds=#s10#, #a4#", "", "10%"};
		{ 7, 40240, "", "=q4=Greaves of Turbulence", "=ds=#s11#, #a4#", "", "9%"};
		{ 8, 40244, "", "=q4=The Impossible Dream", "=ds=#h3#, #w6#", "", "10%"};
		{ 9, 40239, "", "=q4=The Hand of Nerub", "=ds=#h4#, #w13#", "", "19%"};
		{ 10, 40245, "", "=q4=Fading Glow", "=ds=#w12#", "", "10%"};
		{ 16, 40637, "", "=q4=Mantle of the Lost Conqueror", "=ds=#e15#", "", "57%"};
		{ 17, 40638, "", "=q4=Mantle of the Lost Protector", "=ds=#e15#", "", "58%"};
		{ 18, 40639, "", "=q4=Mantle of the Lost Vanquisher", "=ds=#e15#", "", "76%"};
		Prev = "Naxx80Heigan25Man";
	};

		----------------------
		--- Frostwyrm Lair ---
		----------------------

	AtlasLoot_Data["Naxx80Sapphiron"] = {
		{ 1, 39415, "", "=q4=Shroud of the Citadel", "=ds=#s4#", "", "19%"};
		{ 2, 39404, "", "=q4=Cloak of Mastery", "=ds=#s4#", "", "18%"};
		{ 3, 39409, "", "=q4=Cowl of Winged Fear", "=ds=#s1#, #a1#", "", "18%"};
		{ 4, 39408, "", "=q4=Leggings of Sapphiron", "=ds=#s11#, #a1#", "", "19%"};
		{ 5, 39399, "", "=q4=Helm of the Vast Legions", "=ds=#s1#, #a2#", "", "17%"};
		{ 6, 39405, "", "=q4=Helmet of the Inner Sanctum", "=ds=#s1#, #a3#", "", "18%"};
		{ 7, 39403, "", "=q4=Helm of the Unsubmissive", "=ds=#s1#, #a4#", "", "17%"};
		{ 8, 39398, "", "=q4=Massive Skeletal Ribcage", "=ds=#s5#, #a4#", "", "19%"};
		{ 9, 39401, "", "=q4=Circle of Death", "=ds=#s13#", "", "19%"};
		{ 10, 39407, "", "=q4=Circle of Life", "=ds=#s13#", "", "18%"};
		{ 11, 44569, "", "=q4=Key to the Focusing Iris", "=ds=#m2#", "", "91%"};
		{ 12, 44582, "", "=q4=Key to the Focusing Iris", "=q1=#m4#: =ds=#e9#"};
		Next = "Naxx80KelThuzad";
	};

	AtlasLoot_Data["Naxx80Sapphiron25Man"] = {
		{ 1, 40381, "", "=q4=Sympathy", "=ds=#s5#, #a1#", "", "19%"};
		{ 2, 40380, "", "=q4=Gloves of Grandeur", "=ds=#s9#, #a1#", "", "18%"};
		{ 3, 40376, "", "=q4=Legwraps of the Defeated Dragon", "=ds=#s11#, #a1#", "", "19%"};
		{ 4, 40362, "", "=q4=Gloves of Fast Reactions", "=ds=#s9#, #a2#", "", "17%"};
		{ 5, 40379, "", "=q4=Legguards of the Boneyard", "=ds=#s11#, #a2#", "", "19%"};
		{ 6, 40367, "", "=q4=Boots of the Great Construct", "=ds=#s12#, #a3#", "", "18%"};
		{ 7, 40366, "", "=q4=Platehelm of the Great Wyrm", "=ds=#s1#, #a4#", "", "18%"};
		{ 8, 40377, "", "=q4=Noble Birthright Pauldrons", "=ds=#s3#, #a4#", "", "18%"};
		{ 9, 40365, "", "=q4=Breastplate of Frozen Pain", "=ds=#s5#, #a4#", "", "19%"};
		{ 10, 40363, "", "=q4= Bone-Inlaid Legguards", "=ds=#s11#, #a4#", "", "18%"};
		{ 11, 40378, "", "=q4=Ceaseless Pity", "=ds=#s2#", "", "19%"};
		{ 12, 40374, "", "=q4=Cosmic Lights", "=ds=#s2#", "", "19%"};
		{ 13, 40369, "", "=q4=Icy Blast Amulet", "=ds=#s2#", "", "18%"};
		{ 14, 40370, "", "=q4=Gatekeeper", "=ds=#s13#", "", "18%"};
		{ 15, 40375, "", "=q4=Ring of Decaying Beauty", "=ds=#s13#", "", "20%"};
		{ 16, 40371, "", "=q4=Bandit's Insignia", "=ds=#s14#", "", "18%"};
		{ 17, 40373, "", "=q4=Extract of Necromatic Power", "=ds=#s14#", "", "18%"};
		{ 18, 40372, "", "=q4=Rune of Repulsion", "=ds=#s14#", "", "19%"};
		{ 19, 40382, "", "=q4=Soul of the Dead", "=ds=#s14#", "", "20%"};
		{ 20, 40368, "", "=q4=Murder", "=ds=#h1#, #w4#", "", "19%"};
		{ 22, 44577, "", "=q4=Heroic Key to the Focusing Iris", "=ds=#m2#", "", "92%"};
		{ 23, 44581, "", "=q4=Heroic Key to the Focusing Iris", "=q1=#m4#: =ds=#e9#"};
		Next = "Naxx80KelThuzad25Man";
	};

	AtlasLoot_Data["Naxx80KelThuzad"] = {
		{ 1, 39425, "", "=q4=Cloak of the Dying", "=ds=#s4#", "", "19%"};
		{ 2, 39421, "", "=q4=Gem of Imprisoned Vassals", "=ds=#s2#", "", "19%"};
		{ 3, 39416, "", "=q4=Kel'Thuzad's Reach", "=ds=#h3#, #w13#", "", "18%"};
		{ 4, 39424, "", "=q4=The Soulblade", "=ds=#h3#, #w4#", "", "19%"};
		{ 5, 39420, "", "=q4=Anarchy", "=ds=#h1#, #w4#", "", "18%"};
		{ 6, 39417, "", "=q4=Death's Bite", "=ds=#h2#, #w1#", "", "18%"};
		{ 7, 39423, "", "=q4=Hammer of the Astral Plane", "=ds=#h3#, #w6#", "", "18%"};
		{ 8, 39422, "", "=q4=Staff of the Plaguehound", "=ds=#w9#", "", "19%"};
		{ 9, 39426, "", "=q4=Wand of the Archlich", "=ds=#w12#", "", "19%"};
		{ 10, 39419, "", "=q4=Nerubian Conquerer", "=ds=#w5#", "", "19%"};
		{ 16, 40616, "", "=q4=Helm of the Lost Conqueror", "=ds=#e15#", "", "28%"};
		{ 17, 40617, "", "=q4=Helm of the Lost Protector", "=ds=#e15#", "", "28%"};
		{ 18, 40618, "", "=q4=Helm of the Lost Vanquisher", "=ds=#e15#", "", "38%"};
		Prev = "Naxx80Sapphiron";
		Next = "Naxx80Trash";
	};

	AtlasLoot_Data["Naxx80KelThuzad25Man"] = {
		{ 1, 40405, "", "=q4=Cape of the Unworthy Wizard", "=ds=#s4#", "", "18%"};
		{ 2, 40403, "", "=q4=Drape of the Deadly Foe", "=ds=#s4#", "", "18%"};
		{ 3, 40398, "", "=q4=Leggings of Mortal Arrogance", "=ds=#s11#, #a1#", "", "18%"};
		{ 4, 40387, "", "=q4=Boundless Ambition", "=ds=#s2#", "", "18%"};
		{ 5, 40399, "", "=q4=Signet of Manifested Pain", "=ds=#s13#", "", "17%"};
		{ 6, 40383, "", "=q4=Calamity's Grasp", "=ds=#h3#, #w13#", "", "18%"};
		{ 7, 40386, "", "=q4=Sinister Revenge", "=ds=#h1#, #w4#", "", "17%"};
		{ 8, 40396, "", "=q4=The Turning Tide", "=ds=#h3#, #w10#", "", "18%"};
		{ 9, 40402, "", "=q4=Last Laugh", "=ds=#h1#, #w1#", "", "18%"};
		{ 10, 40384, "", "=q4=Betrayer of Humanity", "=ds=#h2#, #w1#", "", "17%"};
		{ 11, 40395, "", "=q4=Torch of Holy Fire", "=ds=#h3#, #w6#", "", "18%"};
		{ 12, 40388, "", "=q4=Journey's End", "=ds=#w9#", "", "18%"};
		{ 13, 40401, "", "=q4=Voice of Reason", "=ds=#w8#", "", "17%"};
		{ 14, 40400, "", "=q4=Wall of Terror", "=ds=#w8#", "", "18%"};
		{ 15, 40385, "", "=q4=Envoy of Mortality", "=ds=#w5#", "", "17%"};
		{ 16, 40631, "", "=q4=Crown of the Lost Conqueror", "=ds=#e15#", "", "54%"};
		{ 17, 40632, "", "=q4=Crown of the Lost Protector", "=ds=#e15#", "", "57%"};
		{ 18, 40633, "", "=q4=Crown of the Lost Vanquisher", "=ds=#e15#", "", "73%"};
		Prev = "Naxx80Sapphiron25Man";
		Next = "Naxx80Trash25Man";
	};

	AtlasLoot_Data["Naxx80Trash"] = {
		{ 1, 39467, "", "=q4=Minion Bracers", "=ds=#s8#, #a4#", "", "1%"};
		{ 2, 39472, "", "=q4=Chain of Latent Energies", "=ds=#s2#", "", "1%"};
		{ 3, 39470, "", "=q4=Medallion of the Disgraced", "=ds=#s2#", "", "1%"};
		{ 4, 39427, "", "=q4=Omen of Ruin", "=ds=#h1#, #w4#", "", "1%"};
		{ 5, 39468, "", "=q4=The Stray", "=ds=#h4#, #w13#", "", "1%"};
		{ 6, 39473, "", "=q4=Contortion", "=ds=#w12#", "", "1%"};
		Prev = "Naxx80KelThuzad";
	};

	AtlasLoot_Data["Naxx80Trash25Man"] = {
		{ 1, 40410, "", "=q4=Shadow of the Ghoul", "=ds=#s4#", "", "1%"};
		{ 2, 40409, "", "=q4=Boots of the Escaped Captive", "=ds=#s12#, #a2#", "", "1%"};
		{ 3, 40414, "", "=q4=Shoulderguards of the Undaunted", "=ds=#s3#, #a4#", "", "1%"};
		{ 4, 40412, "", "=q4=Ousted Bead Necklace", "=ds=#s2#", "", "1%"};
		{ 5, 40408, "", "=q4=Haunting Call", "=ds=#h3#, #w4#", "", "1%"};
		{ 6, 40407, "", "=q4=Silent Crusader", "=ds=#h1#, #w10#", "", "1%"};
		{ 7, 40406, "", "=q4=Inevitable Defeat", "=ds=#h2#, #w6#", "", "1%"};
		Prev = "Naxx80KelThuzad25Man";
	};

		------------------------
		--- Obsidian Sanctum ---
		------------------------

	AtlasLoot_Data["Sartharion"] = {
		{ 1, 40428, "", "=q4=Titan's Outlook", "=ds=#s1#, #a4#", "", "18%"};
		{ 2, 40427, "", "=q4=Circle of Arcane Streams", "=ds=#s2#", "", "18%"};
		{ 3, 40426, "", "=q4=Signet of the Accord", "=ds=#s13#", "", "19%"};
		{ 4, 40433, "", "=q4=Wyrmrest Band", "=ds=#s13#", "", "7%"};
		{ 5, 40430, "", "=q4=Majestic Dragon Figurine", "=ds=#s14#", "", "18%"};
		{ 6, 40429, "", "=q4=Crimson Steel", "=ds=#h3#, #w13#", "", "18%"};
		{ 7, 43345, "", "=q4=Dragon Hide Bag", "=ds=#e1#", "", "100%"};
		{ 8, 43347, "", "=q4=Satchel of Spoils", "", "", "100%"};
		{ 10, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["One Drake Left"]};
		{ 11, 43988, "", "=q4=Gale-Proof Cloak", "=ds=#s4#", "", "1%"};
		{ 12, 43990, "", "=q4=Blade-Scarred Tunic", "=ds=#s5#, #a2#", "", "2%"};
		{ 13, 43991, "", "=q4=Legguards of Composure", "=ds=#s11#, #a2#", "", "1%"};
		{ 14, 43989, "", "=q4=Remembrance Girdle", "=ds=#s10#, #a4#", "", "2%"};
		{ 15, 43992, "", "=q4=Volitant Amulet", "=ds=#s2#", "", "2%"};
		{ 16, 40613, "", "=q4=Gloves of the Lost Conqueror", "=ds=#e15#", "", "28%"};
		{ 17, 40614, "", "=q4=Gloves of the Lost Protector", "=ds=#e15#", "", "29%"};
		{ 18, 40615, "", "=q4=Gloves of the Lost Vanquisher", "=ds=#e15#", "", "37%"};
		{ 20, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["Two Drakes Left"]};
		{ 21, 43995, "", "=q4=Enamored Cowl", "=ds=#s1#, #a1#", "", "0.00%"};
		{ 22, 43998, "", "=q4=Chestguard of Flagrant Prowess", "=ds=#s5#, #a3#"};
		{ 23, 43996, "", "=q4=Sabatons of Firmament", "=ds=#s12#, #a3#"};
		{ 24, 43994, "", "=q4=Belabored Legplates", "=ds=#s11#, #a4#"};
		{ 25, 43993, "", "=q4=Greatring of Collision", "=ds=#s13#"};
		{ 27, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["Three Drakes Left"]};
		{ 28, 43986, "", "=q4=Reins of the Black Drake", "=ds=#e12#", "", "100%"};
	};

	AtlasLoot_Data["Sartharion25Man"] = {
		{ 1, 40437, "", "=q4=Concealment Shoulderpads", "=ds=#s3#, #a2#", "", "16%"};
		{ 2, 40439, "", "=q4=Mantle of the Eternal Sentinel", "=ds=#s3#, #a2#", "", "19%"};
		{ 3, 40451, "", "=q4=Hyaline Helm of the Sniper", "=ds=#s1#, #a3#", "", "16%"};
		{ 4, 40438, "", "=q4=Council Chamber Epaulets", "=ds=#s3#, #a3#", "", "19%"};
		{ 5, 40453, "", "=q4=Chestplate of the Great Aspects", "=ds=#s5#, #a4#", "", "17%"};
		{ 6, 40446, "", "=q4=Dragon Brood Legguards", "=ds=#s11#, #a4#", "", "17%"};
		{ 7, 40433, "", "=q4=Wyrmrest Band", "=ds=#s13#", "", "7%"};
		{ 8, 40431, "", "=q4=Fury of the Five Flights", "=ds=#s14#", "", "17%"};
		{ 9, 40432, "", "=q4=Illustration of the Dragon Soul", "=ds=#s14#", "", "19%"};
		{ 10, 40455, "", "=q4=Staff of Restraint", "=ds=#w9#", "", "19%"};
		{ 11, 43345, "", "=q4=Dragon Hide Bag", "=ds=#e1#", "", "100%"};
		{ 12, 43346, "", "=q4=Large Satchel of Spoils", "", "", "100%"};
		{ 13, 40628, "", "=q4=Gauntlets of the Lost Conqueror", "=ds=#e15#", "", "51%"};
		{ 14, 40629, "", "=q4=Gauntlets of the Lost Protector", "=ds=#e15#", "", "53%"};
		{ 15, 40630, "", "=q4=Gauntlets of the Lost Vanquisher", "=ds=#e15#", "", "67%"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["One Drake Left"]};
		{ 17, 44002, "", "=q4=The Sanctum's Flowing Vestments", "=ds=#s5#, #a1#", "", "7%"};
		{ 18, 44003, "", "=q4=Upstanding Spaulders", "=ds=#s3#, #a3#", "", "7%"};
		{ 19, 44004, "", "=q4=Bountiful Gauntlets", "=ds=#s9#, #a3#", "", "6%"};
		{ 20, 44000, "", "=q4=Dragonstorm Breastplate", "=ds=#s5#, #a4#", "", "6%"};
		{ 22, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["Two Drakes Left"]};
		{ 23, 44005, "", "=q4=Pennant Cloak", "=ds=#s4#", "", "3%"};
		{ 24, 44008, "", "=q4=Unsullied Cuffs", "=ds=#s8#, #a1#", "", "3%"};
		{ 25, 44007, "", "=q4=Headpiece of Reconciliation", "=ds=#s1#, #a2#", "", "3%"};
		{ 26, 44011, "", "=q4=Leggings of the Honored", "=ds=#s11#, #a2#", "", "3%"};
		{ 27, 44006, "", "=q4=Obsidian Greathelm", "=ds=#s1#, #a4#", "", "3%"};
		{ 29, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["Three Drakes Left"]};
		{ 30, 43954, "", "=q4=Reins of the Twilight Drake", "=ds=#e12#", "", "100%"};
	};

		---------------------------
		--- The Eye of Eternity ---
		---------------------------

	AtlasLoot_Data["Malygos"] = {
		{ 1, 40526, "", "=q4=Gown of the Spell-Weaver", "=ds=#s5#, #a1#", "", "12%"};
		{ 2, 40519, "", "=q4=Footsteps of Malygos", "=ds=#s12#, #a2#", "", "12%"};
		{ 3, 40511, "", "=q4=Focusing Energy Epaulets", "=ds=#s3#, #a4#", "", "13%"};
		{ 4, 40486, "", "=q4=Necklace of the Glittering Chamber", "=ds=#s2#", "", "12%"};
		{ 5, 40474, "", "=q4=Surge Needle Ring", "=ds=#s13#", "", "10%"};
		{ 6, 40491, "", "=q4=Hailstorm", "=ds=#h1#, #w10#", "", "11%"};
		{ 7, 40488, "", "=q4=Ice Spire Scepter", "=ds=#h3#, #w6#", "", "12%"};
		{ 8, 40489, "", "=q4=Greatstaff of the Nexus", "=ds=#w9#", "", "12%"};
		{ 9, 40497, "", "=q4=Black Ice", "=ds=#w7#", "", "10%"};
		{ 10, 40475, "", "=q4=Barricade of Eternity", "=ds=#w8#", "", "11%"};
		{ 11, 43952, "", "=q4=Reins of the Azure Drake", "=ds=#e12#", "", "1%"};
		{ 13, 44569, "", "=q4=Key to the Focusing Iris", "=ds=#m3#", "", "91%"};
		{ 16, 44650, "", "=q1=Heart of Magic", "=ds=#m3#", "", "100%"};
		{ 17, 44658, "", "=q4=Chain of the Ancient Wyrm", "=q1=#m4#: =ds=#s2#"};
		{ 18, 44660, "", "=q4=Drakescale Collar", "=q1=#m4#: =ds=#s2#"};
		{ 19, 44659, "", "=q4=Pendant of the Dragonsworn", "=q1=#m4#: =ds=#s2#"};
		{ 20, 44657, "", "=q4=Torque of the Red Dragonflight", "=q1=#m4#: =ds=#s2#"};
	};

	AtlasLoot_Data["Malygos25Man"] = {
		{ 1, 40562, "", "=q4=Hood of Rationality", "=ds=#s1#, #a1#", "", "9%"};
		{ 2, 40555, "", "=q4=Mantle of Dissemination", "=ds=#s3#, #a1#", "", "9%"};
		{ 3, 40194, "", "=q4=Blanketing Robes of Snow", "=ds=#s5#, #a1#", "", "9%"};
		{ 4, 40561, "", "=q4=Leash of Heedless Magic", "=ds=#s10#, #a1#", "", "9%"};
		{ 5, 40560, "", "=q4=Leggings of the Wanton Spellcaster", "=ds=#s11#, #a1#", "", "10%"};
		{ 6, 40558, "", "=q4=Arcanic Tramplers", "=ds=#s12#, #a1#", "", "7%"};
		{ 7, 40594, "", "=q4=Spaulders of Catatonia", "=ds=#s3#, #a2#", "", "10%"};
		{ 8, 40539, "", "=q4=Chestguard of the Recluse", "=ds=#s5#, #a2#", "", "8%"};
		{ 9, 40541, "", "=q4=Frosted Adroit Handguards", "=ds=#s9#, #a2#", "", "9%"};
		{ 10, 40566, "", "=q4=Unravelling Strands of Sanity", "=ds=#s10#, #a2#", "", "11%"};
		{ 11, 40543, "", "=q4=Blue Aspect Helm", "=ds=#s1#, #a3#", "", "9%"};
		{ 12, 40588, "", "=q4=Tunic of the Artifact Guardian", "=ds=#s5#, #a3#", "", "9%"};
		{ 13, 40564, "", "=q4=Winter Spectacle Gloves", "=ds=#s9#, #a3#", "", "9%"};
		{ 14, 40549, "", "=q4=Boots of the Renewed Flight", "=ds=#s12#, #a3#", "", "8%"};
		{ 15, 40590, "", "=q4=Elevated Lair Pauldrons", "=ds=#s3#, #a4#", "", "9%"};
		{ 16, 40589, "", "=q4=Legplates of Sovereignty", "=ds=#s11#, #a4#", "", "9%"};
		{ 17, 40592, "", "=q4=Boots of Healing Energies", "=ds=#s12#, #a4#", "", "10%"};
		{ 18, 40591, "", "=q4=Melancholy Sabatons", "=ds=#s12#, #a4#", "", "9%"};
		{ 19, 40532, "", "=q4=Living Ice Crystals", "=ds=#s14#", "", "9%"};
		{ 20, 40531, "", "=q4=Mark of Norgannon", "=ds=#s14#", "", "8%"};
		{ 21, 43952, "", "=q4=Reins of the Azure Drake", "=ds=#e12#", "", "1%"};
		{ 23, 44577, "", "=q4=Heroic Key to the Focusing Iris", "=ds=#m3#", "", "92%"};
		{ 25, 44650, "", "=q1=Heart of Magic", "=ds=#m3#", "", "100%"};
		{ 26, 44664, "", "=q4=Favor of the Dragon Queen", "=q1=#m4#: =ds=#s2#"};
		{ 27, 44662, "", "=q4=Life-Binder's Locket", "=q1=#m4#: =ds=#s2#"};
		{ 28, 44665, "", "=q4=Nexus War Champion Beads", "=q1=#m4#: =ds=#s2#"};
		{ 29, 44661, "", "=q4=Wyrmrest Necklace of Power", "=q1=#m4#: =ds=#s2#"};
	};

		--------------
		--- Ulduar ---
		--------------

	AtlasLoot_Data["UlduarLeviathan"] = {
		{ 1, 45289, "", "=q4=Lifespark Visage", "=ds=#s1#, #a1#", "", "22%"};
		{ 2, 45291, "", "=q4=Combustion Bracers", "=ds=#s8#, #a1#", "", "17%"};
		{ 3, 45288, "", "=q4=Firestrider Chestguard", "=ds=#s5#, #a3#", "", "22%"};
		{ 4, 45283, "", "=q4=Flamewatch Armguards", "=ds=#s8#, #a4#", "", "19%"};
		{ 5, 45285, "", "=q4=Might of the Leviathan", "=ds=#s2#", "", "18%"};
		{ 6, 45292, "", "=q4=Energy Siphon", "=ds=#s14#", "", "18%"};
		{ 7, 45286, "", "=q4=Pyrite Infuser", "=ds=#s14#", "", "17%"};
		{ 8, 45284, "", "=q4=Kinetic Ripper", "=ds=#h4#, #w13#", "", "19%"};
		{ 9, 45287, "", "=q4=Firesoul", "=ds=#h3#, #w10#", "", "17%"};
		{ 10, 45282, "", "=q4=Ironsoul", "=ds=#h2#, #w6#", "", "19%"};
		{ 16, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 17, 45293, "", "=q4=Handguards of Potent Cures", "=ds=#s9#, #a2#", "", "0.18%"};
		{ 18, 45300, "", "=q4=Mantle of Fiery Vengeance", "=ds=#s3#, #a3#"};
		{ 19, 45295, "", "=q4=Gilded Steel Legplates", "=ds=#s11#, #a4#", "", "0.25%"};
		{ 20, 45297, "", "=q4=Shimmering Seal", "=ds=#s13#", "", "0.11%"};
		{ 21, 45296, "", "=q4=Twirling Blades", "=ds=#w11#", "", "0.36%"};
		Next = "UlduarRazorscale";
	};

	AtlasLoot_Data["UlduarLeviathan25Man"] = {
		{ 1, 45038, "", "=q5=Fragment of Val'anyr", "=ds=#m3#", "", "40%"};
		{ 2, 46017, "", "=q5=Val'anyr, Hammer of Ancient Kings", "=q1=#m4#: =ds=#h1#, #w6#"};
		{ 4, 45117, "", "=q4=Constructor's Handwraps", "=ds=#s9#, #a1#", "", "19%"};
		{ 5, 45119, "", "=q4=Embrace of the Leviathan", "=ds=#s10#, #a1#", "", "20%"};
		{ 6, 45108, "", "=q4=Mechanist's Bindings", "=ds=#s8#, #a2#", "", "19%"};
		{ 7, 45118, "", "=q4=Steamworker's Goggles", "=ds=#s1#, #a3#", "", "20%"};
		{ 8, 45109, "", "=q4=Gloves of the Fiery Behemoth", "=ds=#s9#, #a3#", "", "18%"};
		{ 9, 45107, "", "=q4=Iron Riveted War Helm", "=ds=#s1#, #a4#", "", "17%"};
		{ 10, 45111, "", "=q4=Mimiron's Inferno Couplings", "=ds=#s8#, #a4#", "", "18%"};
		{ 11, 45116, "", "=q4=Freya's Choker of Warding", "=ds=#s2#", "", "19%"};
		{ 12, 45113, "", "=q4=Glowing Ring of Reclamation", "=ds=#s13#", "", "19%"};
		{ 13, 45106, "", "=q4=Strength of the Automaton", "=ds=#s13#", "", "16%"};
		{ 14, 45112, "", "=q4=The Leviathan's Coil", "=ds=#s13#", "", "19%"};
		{ 15, 45115, "", "=q4=Overcharged Fuel Rod", "=ds=#s15#", "", "18%"};
		{ 16, 45114, "", "=q4=Steamcaller's Totem", "=ds=#s16#, #w15#", "", "18%"};
		{ 17, 45110, "", "=q4=Titanguard", "=ds=#h1#, #w10#", "", "18%"};
		{ 18, 45086, "", "=q4=Rising Sun", "=ds=#w11#", "", "18%"};
		{ 20, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 21, 45135, "", "=q4=Boots of Fiery Resolution", "=ds=#s12#, #a1#", "", "0.27%"};
		{ 22, 45136, "", "=q4=Shoulderpads of Dormant Energies", "=ds=#s3#, #a2#"};
		{ 23, 45134, "", "=q4=Plated Leggings of Ruination", "=ds=#s11#, #a4#"};
		{ 24, 45133, "", "=q4=Pendant of Fiery Havoc", "=ds=#s2#"};
		{ 25, 45132, "", "=q4=Golden Saronite Dragon", "=ds=#h3#, #w13#", "", "0.11%"};
		Next = "UlduarRazorscale25Man";
	};

	AtlasLoot_Data["UlduarRazorscale"] = {
		{ 1, 45306, "", "=q4=Binding of the Dragon Matriarch", "=ds=#s10#, #a1#", "", "20%"};
		{ 2, 45302, "", "=q4=Treads of the Invader", "=ds=#s12#, #a2#", "", "19%"};
		{ 3, 45301, "", "=q4=Bracers of the Smothering Inferno", "=ds=#s8#, #a3#", "", "20%"};
		{ 4, 45307, "", "=q4=Ironscale Leggings", "=ds=#s11#, #a3#", "", "20%"};
		{ 5, 45299, "", "=q4=Dragonsteel Faceplate", "=ds=#s1#, #a4#", "", "19%"};
		{ 6, 45305, "", "=q4=Breastplate of the Afterlife", "=ds=#s5#, #a4#", "", "19%"};
		{ 7, 45304, "", "=q4=Stormtempered Girdle", "=ds=#s10#, #a4#", "", "19%"};
		{ 8, 45303, "", "=q4=Band of Draconic Guile", "=ds=#s13#", "", "20%"};
		{ 9, 45308, "", "=q4=Eye of the Broodmother", "=ds=#s14#", "", "21%"};
		{ 10, 45298, "", "=q4=Razorscale Talon", "=ds=#h1#, #w10#", "", "20%"};
		Prev = "UlduarLeviathan";
		Next = "UlduarIgnis";
	};

	AtlasLoot_Data["UlduarRazorscale25Man"] = {
		{ 1, 45038, "", "=q5=Fragment of Val'anyr", "=ds=#m3#", "", "40%"};
		{ 2, 46017, "", "=q5=Val'anyr, Hammer of Ancient Kings", "=q1=#m4#: =ds=#h1#, #w6#"};
		{ 4, 45138, "", "=q4=Drape of the Drakerider", "=ds=#s4#", "", "20%"};
		{ 5, 45150, "", "=q4=Collar of the Wyrmhunter", "=ds=#s1#, #a1#", "", "20%"};
		{ 6, 45146, "", "=q4=Shackles of the Odalisque", "=ds=#s8#, #a1#", "", "20%"};
		{ 7, 45149, "", "=q4=Bracers of the Broodmother", "=ds=#s8#, #a2#", "", "21%"};
		{ 8, 45141, "", "=q4=Proto-hide Leggings", "=ds=#s11#, #a2#", "", "19%"};
		{ 9, 45151, "", "=q4=Belt of the Fallen Wyrm", "=ds=#s10#, #a3#", "", "19%"};
		{ 10, 45143, "", "=q4=Saronite Mesh Legguards", "=ds=#s11#, #a3#", "", "20%"};
		{ 11, 45140, "", "=q4=Razorscale Shoulderguards", "=ds=#s3#, #a4#", "", "19%"};
		{ 12, 45139, "", "=q4=Dragonslayer's Brace", "=ds=#s10#, #a4#", "", "19%"};
		{ 13, 45148, "", "=q4=Living Flame", "=ds=#s14#", "", "19%"};
		{ 14, 45510, "", "=q4=Libram of Discord", "=ds=#s16#, #w16#", "", "19%"};
		{ 15, 45144, "", "=q4=Sigil of Deflection", "=ds=#s16#, #w21#", "", "19%"};
		{ 16, 45142, "", "=q4=Remorse", "=ds=#h1#, #w10#", "", "19%"};
		{ 17, 45147, "", "=q4=Guiding Star", "=ds=#h3#, #w6#", "", "19%"};
		{ 18, 45137, "", "=q4=Veranus' Bane", "=ds=#w5#", "", "18%"};
		Prev = "UlduarLeviathan25Man";
		Next = "UlduarIgnis25Man";
	};

	AtlasLoot_Data["UlduarIgnis"] = {
		{ 1, 45317, "", "=q4=Shawl of the Caretaker", "=ds=#s4#", "", "20%"};
		{ 2, 45318, "", "=q4=Drape of Fuming Anger", "=ds=#s4#", "", "19%"};
		{ 3, 45312, "", "=q4=Gloves of Smoldering Touch", "=ds=#s9#, #a2#", "", "20%"};
		{ 4, 45316, "", "=q4=Armbraces of the Vibrant Flame", "=ds=#s8#, #a3#", "", "19%"};
		{ 5, 45321, "", "=q4=Pauldrons of Tempered Will", "=ds=#s3#, #a4#", "", "21%"};
		{ 6, 45310, "", "=q4=Gauntlets of the Iron Furnace", "=ds=#s9#, #a4#", "", "20%"};
		{ 7, 45313, "", "=q4=Furnace Stone", "=ds=#s14#", "", "19%"};
		{ 8, 45314, "", "=q4=Igniter Rod", "=ds=#s15#", "", "19%"};
		{ 9, 45311, "", "=q4=Relentless Edge", "=ds=#w7#", "", "20%"};
		{ 10, 45309, "", "=q4=Rifle of the Platinum Guard", "=ds=#w5#", "", "19%"};
		Prev = "UlduarRazorscale";
		Next = "UlduarDeconstructor";
	};

	AtlasLoot_Data["UlduarIgnis25Man"] = {
		{ 1, 45038, "", "=q5=Fragment of Val'anyr", "=ds=#m3#", "", "40%"};
		{ 2, 46017, "", "=q5=Val'anyr, Hammer of Ancient Kings", "=q1=#m4#: =ds=#h1#, #w6#"};
		{ 4, 45186, "", "=q4=Soot-Covered Mantle", "=ds=#s3#, #a1#", "", "18%"};
		{ 5, 45185, "", "=q4=Flamewrought Cinch", "=ds=#s10#, #a2#", "", "20%"};
		{ 6, 45162, "", "=q4=Flamestalker Boots", "=ds=#s12#, #a2#", "", "18%"};
		{ 7, 45164, "", "=q4=Helm of the Furnace Master", "=ds=#s1#, #a3#", "", "19%"};
		{ 8, 45187, "", "=q4=Wristguards of the Firetender", "=ds=#s8#, #a3#", "", "19%"};
		{ 9, 45167, "", "=q4=Lifeforge Breastplate", "=ds=#s5#, #a4#", "", "19%"};
		{ 10, 45161, "", "=q4=Girdle of Embers", "=ds=#s10#, #a4#", "", "19%"};
		{ 11, 45166, "", "=q4=Charred Saronite Greaves", "=ds=#s12#, #a4#", "", "20%"};
		{ 12, 45157, "", "=q4=Cindershard Ring", "=ds=#s13#", "", "20%"};
		{ 13, 45168, "", "=q4=Pyrelight Circle", "=ds=#s13#", "", "20%"};
		{ 14, 45158, "", "=q4=Heart of Iron", "=ds=#s14#", "", "19%"};
		{ 15, 45169, "", "=q4=Totem of the Dancing Flame", "=ds=#s16#, #w15#", "", "21%"};
		{ 16, 45165, "", "=q4=Worldcarver", "=ds=#h2#, #w1#", "", "19%"};
		{ 17, 45171, "", "=q4=Intensity", "=ds=#w9#", "", "20%"};
		{ 18, 45170, "", "=q4=Scepter of Creation", "=ds=#w12#", "", "21%"};
		Prev = "UlduarRazorscale25Man";
		Next = "UlduarDeconstructor25Man";
	};

	AtlasLoot_Data["UlduarDeconstructor"] = {
		{ 1, 45694, "", "=q4=Conductive Cord", "=ds=#s10#, #a1#", "", "21%"};
		{ 2, 45677, "", "=q4=Treacherous Shoulderpads", "=ds=#s3#, #a2#", "", "19%"};
		{ 3, 45686, "", "=q4=Vest of the Glowing Crescent", "=ds=#s5#, #a2#", "", "21%"};
		{ 4, 45687, "", "=q4=Helm of Veiled Energies", "=ds=#s1#, #a3#", "", "21%"};
		{ 5, 45679, "", "=q4=Gloves of Taut Grip", "=ds=#s9#, #a3#", "", "19%"};
		{ 6, 45676, "", "=q4=Chestplate of Vicious Potency", "=ds=#s5#, #a4#", "", "19%"};
		{ 7, 45680, "", "=q4=Armbands of the Construct", "=ds=#s8#, #a4#", "", "18%"};
		{ 8, 45675, "", "=q4=Power Enhancing Loop", "=ds=#s13#", "", "20%"};
		{ 9, 45685, "", "=q4=Plasma Foil", "=ds=#h3#, #w4#", "", "22%"};
		{ 10, 45682, "", "=q4=Pulsing Spellshield", "=ds=#w8#", "", "14%"};
		{ 16, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 17, 45869, "", "=q4=Fluxing Energy Coils", "=ds=#s8#, #a2#", "", "3%"};
		{ 18, 45867, "", "=q4=Breastplate of the Stoneshaper", "=ds=#s5#, #a3#", "", "2%"};
		{ 19, 45871, "", "=q4=Seal of Ulduar", "=ds=#s13#", "", "2%"};
		{ 20, 45868, "", "=q4=Aesir's Edge", "=ds=#h2#, #w10#", "", "2%"};
		{ 21, 45870, "", "=q4=Magnetized Projectile Emitter", "=ds=#w5#", "", "3%"};
		Prev = "UlduarIgnis";
		Next = "UlduarIronCouncil";
	};

	AtlasLoot_Data["UlduarDeconstructor25Man"] = {
		{ 1, 45038, "", "=q5=Fragment of Val'anyr", "=ds=#m3#", "", "40%"};
		{ 2, 46017, "", "=q5=Val'anyr, Hammer of Ancient Kings", "=q1=#m4#: =ds=#h1#, #w6#"};
		{ 4, 45253, "", "=q4=Mantle of Wavering Calm", "=ds=#s3#, #a1#", "", "19%"};
		{ 5, 45258, "", "=q4=Sandals of Rash Temperament", "=ds=#s12#, #a1#", "", "19%"};
		{ 6, 45260, "", "=q4=Boots of Hasty Revival", "=ds=#s12#, #a2#", "", "21%"};
		{ 7, 45259, "", "=q4=Quartz-studded Harness", "=ds=#s5#, #a3#", "", "18%"};
		{ 8, 45249, "", "=q4=Brass-lined Boots", "=ds=#s12#, #a3#", "", "18%"};
		{ 9, 45251, "", "=q4=Shoulderplates of the Deconstructor", "=ds=#s3#, #a4#", "", "18%"};
		{ 10, 45252, "", "=q4=Horologist's Wristguards", "=ds=#s8#, #a4#", "", "19%"};
		{ 11, 45248, "", "=q4=Clockwork Legplates", "=ds=#s11#, #a4#", "", "19%"};
		{ 12, 45250, "", "=q4=Crazed Construct Ring", "=ds=#s13#", "", "18%"};
		{ 13, 45247, "", "=q4=Signet of the Earthshaker", "=ds=#s13#", "", "20%"};
		{ 14, 45254, "", "=q4=Sigil of the Vengeful Heart", "=ds=#s16#, #w21#", "", "20%"};
		{ 15, 45255, "", "=q4=Thunderfall Totem", "=ds=#s16#, #w15#", "", "20%"};
		{ 16, 45246, "", "=q4=Golem-Shard Sticker", "=ds=#h1#, #w4#", "", "19%"};
		{ 17, 45256, "", "=q4=Twisted Visage", "=ds=#w9#", "", "19%"};
		{ 18, 45257, "", "=q4=Quartz Crystal Wand", "=ds=#w12#", "", "20%"};
		{ 20, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 21, 45446, "", "=q4=Grasps of Reason", "=ds=#s8#, #a1#", "", "0.16%"};
		{ 22, 45444, "", "=q4=Gloves of the Steady Hand", "=ds=#s9#, #a3#", "", "0.29%"};
		{ 23, 45445, "", "=q4=Breastplate of the Devoted", "=ds=#s5#, #a4#", "", "0.16%"};
		{ 24, 45443, "", "=q4=Charm of Meticulous Timing", "=ds=#s2#", "", "0.15%"};
		{ 25, 45442, "", "=q4=Sorthalis, Hammer of the Watchers", "=ds=#h1#, #w6#", "", "0.28%"};
		Prev = "UlduarIgnis25Man";
		Next = "UlduarIronCouncil25Man";
	};

	AtlasLoot_Data["UlduarIronCouncil"] = {
		{ 1, 45322, "", "=q4=Cloak of the Iron Council", "=ds=#s4#", "", "18%"};
		{ 2, 45423, "", "=q4=Runetouch Handwraps", "=ds=#s8#, #a1#", "", "24%"};
		{ 3, 45324, "", "=q4=Leggings of Swift Reflexes", "=ds=#s11#, #a2#", "", "19%"};
		{ 4, 45378, "", "=q4=Boots of the Petrified Forest", "=ds=#s12#, #a2#", "", "17%"};
		{ 5, 45329, "", "=q4=Circlet of True Sight", "=ds=#s1#, #a3#", "", "19%"};
		{ 6, 45333, "", "=q4=Belt of the Iron Servant", "=ds=#s10#, #a3#", "", "22%"};
		{ 7, 45330, "", "=q4=Greaves of Iron Intensity", "=ds=#s12#, #a4#", "", "23%"};
		{ 8, 45418, "", "=q4=Lady Maye's Sapphire Ring", "=ds=#s13#", "", "21%"};
		{ 9, 45332, "", "=q4=Stormtip", "=ds=#h3#, #w4#", "", "23%"};
		{ 10, 45331, "", "=q4=Rune-Etched Nightblade", "=ds=#h1#, #w10#", "", "19%"};
		{ 16, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 17, 45455, "", "=q4=Belt of the Crystal Tree", "=ds=#s10#, #a2#", "", "19%"};
		{ 18, 45447, "", "=q4=Watchful Eye", "=ds=#s2#", "", "18%"};
		{ 19, 45456, "", "=q4=Loop of the Agile", "=ds=#s13#", "", "16%"};
		{ 20, 45449, "", "=q4=The Masticator", "=ds=#h3#, #w13#", "", "18%"};
		{ 21, 45448, "", "=q4=Perilous Bite", "=ds=#h1#, #w4#", "", "17%"};
		{ 22, 45506, "", "=q4=Archivum Data Disc", "=ds=#m2#", "", "91%"};
		Prev = "UlduarDeconstructor";
		Next = "UlduarKologarn";
	};

	AtlasLoot_Data["UlduarIronCouncil25Man"] = {
		{ 1, 45038, "", "=q5=Fragment of Val'anyr", "=ds=#m3#", "", "40%"};
		{ 2, 46017, "", "=q5=Val'anyr, Hammer of Ancient Kings", "=q1=#m4#: =ds=#h1#, #w6#"};
		{ 4, 45224, "", "=q4=Drape of the Lithe", "=ds=#s4#", "", "19%"};
		{ 5, 45240, "", "=q4=Raiments of the Iron Council", "=ds=#s5#, #a1#", "", "24%"};
		{ 6, 45238, "", "=q4=Overload Legwraps", "=ds=#s11#, #a1#", "", "20%"};
		{ 7, 45237, "", "=q4=Phaelia's Vestments of the Sprouting Seed", "=ds=#s5#, #a2#", "", "23%"};
		{ 8, 45232, "", "=q4=Runed Ironhide Boots", "=ds=#s12#, #a2#", "", "22%"};
		{ 9, 45227, "", "=q4=Iron-studded Mantle", "=ds=#s3#, #a3#", "", "22%"};
		{ 10, 45239, "", "=q4=Runeshaper's Gloves", "=ds=#s9#, #a3#", "", "20%"};
		{ 11, 45226, "", "=q4=Ancient Iron Heaume", "=ds=#s1#, #a4#", "", "20%"};
		{ 12, 45225, "", "=q4=Steelbreaker's Embrace", "=ds=#s5#, #a4#", "", "19%"};
		{ 13, 45228, "", "=q4=Handguards of the Enclave", "=ds=#s9#, #a4#", "", "21%"};
		{ 14, 45193, "", "=q4=Insurmountable Fervor", "=ds=#s2#", "", "19%"};
		{ 15, 45236, "", "=q4=Unblinking Eye", "=ds=#s2#", "", "19%"};
		{ 16, 45235, "", "=q4=Radiant Seal", "=ds=#s13#", "", "20%"};
		{ 17, 45233, "", "=q4=Rune Edge", "=ds=#h2#, #w10#", "", "20%"};
		{ 18, 45234, "", "=q4=Rapture", "=ds=#w9#", "", "19%"};
		{ 20, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 21, 45242, "", "=q4=Drape of Mortal Downfall", "=ds=#s4#", "", "21%"};
		{ 22, 45245, "", "=q4=Shoulderpads of the Intruder", "=ds=#s3#, #a2#", "", "14%"};
		{ 23, 45244, "", "=q4=Greaves of Swift Vengeance", "=ds=#s12#, #a3#", "", "9%"};
		{ 24, 45241, "", "=q4=Belt of Colossal Rage", "=ds=#s10#, #a4#", "", "15%"};
		{ 25, 45243, "", "=q4=Sapphire Amulet of Renewal", "=ds=#s2#", "", "10%"};
		{ 26, 45607, "", "=q4=Fang of Oblivion", "=ds=#h1#, #w4#", "", "18%"};
		{ 27, 45857, "", "=q4=Archivum Data Disc", "=ds=#m2#", "", "94%"};
		Prev = "UlduarDeconstructor25Man";
		Next = "UlduarKologarn25Man";
	};

	AtlasLoot_Data["UlduarKologarn"] = {
		{ 1, 45704, "", "=q4=Shawl of the Shattered Giant", "=ds=#s4#", "", "19%"};
		{ 2, 45701, "", "=q4=Greaves of the Earthbinder", "=ds=#s12#, #a3#", "", "21%"};
		{ 3, 45697, "", "=q4=Shoulderguards of the Solemn Watch", "=ds=#s3#, #a4#", "", "18%"};
		{ 4, 45698, "", "=q4=Sabatons of the Iron Watcher", "=ds=#s12#, #a4#", "", "18%"};
		{ 5, 45696, "", "=q4=Mark of the Unyielding", "=ds=#s2#", "", "19%"};
		{ 6, 45699, "", "=q4=Pendant of the Piercing Glare", "=ds=#s2#", "", "17%"};
		{ 7, 45702, "", "=q4=Emerald Signet Ring", "=ds=#s13#", "", "18%"};
		{ 8, 45703, "", "=q4=Spark of Hope", "=ds=#s14#", "", "17%"};
		{ 9, 45700, "", "=q4=Stoneguard", "=ds=#h1#, #w10#", "", "19%"};
		{ 10, 45695, "", "=q4=Spire of Withering Dreams", "=ds=#w9#", "", "21%"};
		Prev = "UlduarIronCouncil";
		Next = "UlduarAlgalon";
	};

	AtlasLoot_Data["UlduarKologarn25Man"] = {
		{ 1, 45038, "", "=q5=Fragment of Val'anyr", "=ds=#m3#", "", "40%"};
		{ 2, 46017, "", "=q5=Val'anyr, Hammer of Ancient Kings", "=q1=#m4#: =ds=#h1#, #w6#"};
		{ 4, 45272, "", "=q4=Robes of the Umbral Brute", "=ds=#s5#, #a1#", "", "20%"};
		{ 5, 45275, "", "=q4=Bracers of Unleashed Magic", "=ds=#s8#, #a1#", "", "18%"};
		{ 6, 45273, "", "=q4=Handwraps of Plentiful Recovery", "=ds=#s9#, #a1#", "", "18%"};
		{ 7, 45265, "", "=q4=Shoulderpads of the Monolith", "=ds=#s3#, #a2#", "", "16%"};
		{ 8, 45274, "", "=q4=Leggings of the Stoneweaver", "=ds=#s11#, #a3#", "", "14%"};
		{ 9, 45264, "", "=q4=Decimator's Armguards", "=ds=#s8#, #a4#", "", "16%"};
		{ 10, 45269, "", "=q4=Unfaltering Armguards", "=ds=#s8#, #a4#", "", "16%"};
		{ 11, 45268, "", "=q4=Gloves of the Pythonic Guardian", "=ds=#s9#, #a4#", "", "18%"};
		{ 12, 45267, "", "=q4=Saronite Plated Legguards", "=ds=#s11#, #a4#", "", "18%"};
		{ 13, 45262, "", "=q4=Necklace of Unerring Mettle", "=ds=#s2#", "", "18%"};
		{ 14, 45263, "", "=q4=Wrathstone", "=ds=#s14#", "", "18%"};
		{ 15, 45271, "", "=q4=Ironmender", "=ds=#s15#", "", "17%"};
		{ 16, 45270, "", "=q4=Idol of the Crying Wind", "=ds=#s16#, #w14#", "", "17%"};
		{ 17, 45266, "", "=q4=Malice", "=ds=#h1#, #w10#", "", "18%"};
		{ 18, 45261, "", "=q4=Giant's Bane", "=ds=#w5#", "", "16%"};
		Prev = "UlduarIronCouncil25Man";
		Next = "UlduarAlgalon25Man";
	};

	AtlasLoot_Data["UlduarAlgalon"] = {
		{ 1, 46042, "", "=q4=Drape of the Messenger", "=ds=#s4#"};
		{ 2, 46045, "", "=q4=Pulsar Gloves", "=ds=#s9#, #a1#", "", "40%"};
		{ 3, 46050, "", "=q4=Starlight Treads", "=ds=#s12#, #a1#"};
		{ 4, 46043, "", "=q4=Gloves of the Endless Dark", "=ds=#s9#, #a2#"};
		{ 5, 46049, "", "=q4=Zodiac Leggings", "=ds=#s11#, #a2#"};
		{ 6, 46044, "", "=q4=Observer's Mantle", "=ds=#s3#, #a3#"};
		{ 7, 46037, "", "=q4=Shoulderplates of the Celestial Watch", "=ds=#s3#, #a4#"};
		{ 8, 46039, "", "=q4=Breastplate of the Timeless", "=ds=#s5#, #a4#"};
		{ 9, 46041, "", "=q4=Starfall Girdle", "=ds=#s10#, #a4#"};
		{ 10, 46047, "", "=q4=Pendant of the Somber Witness", "=ds=#s2#"};
		{ 11, 46040, "", "=q4=Strength of the Heavens", "=ds=#s2#", "", "40%"};
		{ 12, 46048, "", "=q4=Band of Lights", "=ds=#s13#"};
		{ 13, 46046, "", "=q4=Nebula Band", "=ds=#s13#"};
		{ 14, 46038, "", "=q4=Dark Matter", "=ds=#s14#"};
		{ 15, 46051, "", "=q4=Meteorite Crystal", "=ds=#s14#", "", "40%"};
		{ 16, 46052, "", "=q4=Reply-Code Alpha", "=ds=#m2#", "", "100%"};
		{ 17, 46320, "", "=q4=Drape of the Skyherald", "=q1=#m4#: =ds=#s4#"};
		{ 18, 46321, "", "=q4=Sunglimmer Drape", "=q1=#m4#: =ds=#s4#"};
		{ 19, 46322, "", "=q4=Brann's Sealing Ring", "=q1=#m4#: =ds=#s13#"};
		{ 20, 46323, "", "=q4=Starshine Signet", "=q1=#m4#: =ds=#s13#"};
		Prev = "UlduarKologarn";
		Next = "UlduarAuriaya";
	};

	AtlasLoot_Data["UlduarAlgalon25Man"] = {
		{ 1, 45665, "", "=q4=Pharos Gloves", "=ds=#s9#, #a1#", "", "40%"};
		{ 2, 45619, "", "=q4=Starwatcher's Binding", "=ds=#s10#, #a1#", "", ""};
		{ 3, 45611, "", "=q4=Solar Bindings", "=ds=#s8#, #a2#", "", "40%"};
		{ 4, 45616, "", "=q4=Star-beaded Clutch", "=ds=#s10#, #a2#"};
		{ 5, 45610, "", "=q4=Boundless Gaze", "=ds=#s1#, #a3#"};
		{ 6, 45615, "", "=q4=Planewalker Treads", "=ds=#s12#, #a3#"};
		{ 7, 45594, "", "=q4=Legplates of the Endless Void", "=ds=#s11#, #a4#", "", "20%"};
		{ 8, 45599, "", "=q4=Sabatons of Lifeless Night", "=ds=#s12#, #a4#"};
		{ 9, 45617, "", "=q4=Cosmos", "=ds=#s15#"};
		{ 10, 45620, "", "=q4=Starshard Edge", "=ds=#h3#, #w4#"};
		{ 11, 45607, "", "=q4=Fang of Oblivion", "=ds=#h1#, #w4#", "", "18%"};
		{ 12, 45612, "", "=q4=Constellus", "=ds=#h3#, #w6#", "", "11%"};
		{ 13, 45613, "", "=q4=Dreambinder", "=ds=#w9#", "", "1%"};
		{ 14, 45587, "", "=q4=Bulwark of Algalon", "=ds=#w8#"};
		{ 15, 45570, "", "=q4=Skyforge Crossbow", "=ds=#w3#", "", "1%"};
		{ 16, 45609, "", "=q4=Comet's Trail", "=ds=#s14#"};
		{ 18, 46053, "", "=q4=Reply-Code Alpha", "=ds=#m2#", "", "100%"};
		{ 19, 45588, "", "=q4=Drape of the Skyborn", "=q1=#m4#: =ds=#s4#"};
		{ 20, 45618, "", "=q4=Sunglimmer Cloak", "=q1=#m4#: =ds=#s4#"};
		{ 21, 45608, "", "=q4=Brann's Signet Ring", "=q1=#m4#: =ds=#s13#"};
		{ 22, 45614, "", "=q4=Starshine Circle", "=q1=#m4#: =ds=#s13#"};
		Prev = "UlduarKologarn25Man";
		Next = "UlduarAuriaya25Man";
	};

	AtlasLoot_Data["UlduarAuriaya"] = {
		{ 1, 45832, "", "=q4=Mantle of the Preserver", "=ds=#s3#, #a1#", "", "19%"};
		{ 2, 45865, "", "=q4=Raiments of the Corrupted", "=ds=#s5#, #a1#", "", "20%"};
		{ 3, 45864, "", "=q4=Cover of the Keepers", "=ds=#s1#, #a2#", "", "20%"};
		{ 4, 45709, "", "=q4=Nimble Climber's Belt", "=ds=#s10#, #a2#", "", "19%"};
		{ 5, 45711, "", "=q4=Ironaya's Discarded Mantle", "=ds=#s3#, #a3#", "", "19%"};
		{ 6, 45712, "", "=q4=Chestplate of Titanic Fury", "=ds=#s5#, #a4#", "", "20%"};
		{ 7, 45708, "", "=q4=Archaedas' Lost Legplates", "=ds=#s11#, #a4#", "", "20%"};
		{ 8, 45866, "", "=q4=Elemental Focus Stone", "=ds=#s14#", "", "19%"};
		{ 9, 45707, "", "=q4=Shieldwall of the Breaker", "=ds=#w8#", "", "19%"};
		{ 10, 45713, "", "=q4=Nurturing Touch", "=ds=#w12#", "", "21%"};
		Prev = "UlduarAlgalon";
		Next = "UlduarHodir";
	};

	AtlasLoot_Data["UlduarAuriaya25Man"] = {
		{ 1, 45038, "", "=q5=Fragment of Val'anyr", "=ds=#m3#", "", "40%"};
		{ 2, 46017, "", "=q5=Val'anyr, Hammer of Ancient Kings", "=q1=#m4#: =ds=#h1#, #w6#"};
		{ 4, 45319, "", "=q4=Cloak of the Makers", "=ds=#s4#", "", "19%"};
		{ 5, 45435, "", "=q4=Cowl of the Absolute", "=ds=#s1#, #a1#", "", "19%"};
		{ 6, 45441, "", "=q4=Sandals of the Ancient Keeper", "=ds=#s12#, #a1#", "", "20%"};
		{ 7, 45439, "", "=q4=Unwavering Stare", "=ds=#s1#, #a2#", "", "20%"};
		{ 8, 45325, "", "=q4=Gloves of the Stonereaper", "=ds=#s9#, #a2#", "", "20%"};
		{ 9, 45440, "", "=q4=Amice of the Stoic Watch", "=ds=#s3#, #a3#", "", "20%"};
		{ 10, 45320, "", "=q4=Shoulderplates of the Eternal", "=ds=#s3#, #a4#", "", "20%"};
		{ 11, 45334, "", "=q4=Unbreakable Chestguard", "=ds=#s5#, #a4#", "", "18%"};
		{ 12, 45434, "", "=q4=Greaves of the Rockmender", "=ds=#s12#, #a4#", "", "20%"};
		{ 13, 45326, "", "=q4=Platinum Band of the Aesir", "=ds=#s13#", "", "19%"};
		{ 14, 45438, "", "=q4=Ring of the Faithful Servant", "=ds=#s13#", "", "19%"};
		{ 15, 45436, "", "=q4=Libram of the Resolute", "=ds=#s16#, #w16#", "", "20%"};
		{ 16, 45437, "", "=q4=Runescribed Blade", "=ds=#h3#, #w10#", "", "20%"};
		{ 17, 45315, "", "=q4=Stonerender", "=ds=#h1#, #w6#", "", "19%"};
		{ 18, 45327, "", "=q4=Siren's Cry", "=ds=#w2#", "", "20%"};
		Prev = "UlduarAlgalon25Man";
		Next = "UlduarHodir25Man";
	};

	AtlasLoot_Data["UlduarHodir"] = {
		{ 1, 45873, "", "=q4=Winter's Frigid Embrace", "=ds=#s4#", "", "15%"};
		{ 2, 45464, "", "=q4=Cowl of Icy Breaths", "=ds=#s1#, #a1#", "", "20%"};
		{ 3, 45874, "", "=q4=Signet of Winter", "=ds=#s13#", "", "16%"};
		{ 4, 45458, "", "=q4=Stormedge", "=ds=#h2#, #w1#", "", "17%"};
		{ 5, 45872, "", "=q4=Avalanche", "=ds=#w2#", "", "22%"};
		{ 7, 45650, "", "=q4=Leggings of the Wayward Conqueror", "=ds=#e15#", "", "29%"};
		{ 8, 45651, "", "=q4=Leggings of the Wayward Protector", "=ds=#e15#", "", "29%"};
		{ 9, 45652, "", "=q4=Leggings of the Wayward Vanquisher", "=ds=#e15#", "", "34%"};
		{ 16, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 17, 45888, "", "=q4=Bitter Cold Armguards", "=ds=#s8#, #a4#", "", "18%"};
		{ 18, 45876, "", "=q4=Shiver", "=ds=#h1#, #w6#", "", "16%"};
		{ 19, 45886, "", "=q4=Icecore Staff", "=ds=#w9#", "", "20%"};
		{ 20, 45887, "", "=q4=Ice Layered Barrier", "=ds=#w8#", "", "18%"};
		{ 21, 45877, "", "=q4=The Boreal Guard", "=ds=#w8#", "", "17%"};
		{ 23, 45786, "", "=q1=Hodir's Sigil", "=ds=#m3#", "", "23%"};
		Prev = "UlduarAuriaya";
		Next = "UlduarThorim";
	};

	AtlasLoot_Data["UlduarHodir25Man"] = {
		{ 1, 45038, "", "=q5=Fragment of Val'anyr", "=ds=#m3#", "", "40%"};
		{ 2, 46017, "", "=q5=Val'anyr, Hammer of Ancient Kings", "=q1=#m4#: =ds=#h1#, #w6#"};
		{ 4, 45453, "", "=q4=Winter's Icy Embrace", "=ds=#s5#, #a2#", "", "16%"};
		{ 5, 45454, "", "=q4=Frost-bound Chain Bracers", "=ds=#s8#, #a3#", "", "18%"};
		{ 6, 45452, "", "=q4=Frostplate Greaves", "=ds=#s11#, #a4#", "", "16%"};
		{ 7, 45451, "", "=q4=Frozen Loop", "=ds=#s13#", "", "15%"};
		{ 8, 45450, "", "=q4=Northern Barrier", "=ds=#w8#", "", "19%"};
		{ 10, 45632, "", "=q4=Breastplate of the Wayward Conqueror", "=ds=#e15#", "", "52%"};
		{ 11, 45633, "", "=q4=Breastplate of the Wayward Protector", "=ds=#e15#", "", "50%"};
		{ 12, 45634, "", "=q4=Breastplate of the Wayward Vanquisher", "=ds=#e15#", "", "71%"};
		{ 16, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 17, 45461, "", "=q4=Drape of Icy Intent", "=ds=#s4#", "", "19%"};
		{ 18, 45462, "", "=q4=Gloves of the Frozen Glade", "=ds=#s9#, #a2#", "", "10%"};
		{ 19, 45460, "", "=q4=Bindings of Winter Gale", "=ds=#s8#, #a3#", "", "12%"};
		{ 20, 45459, "", "=q4=Frigid Strength of Hodir", "=ds=#s2#", "", "13%"};
		{ 21, 45612, "", "=q4=Constellus", "=ds=#h3#, #w6#", "", "11%"};
		{ 22, 45457, "", "=q4=Staff of Endless Winter", "=ds=#w9#", "", "19%"};
		{ 24, 45815, "", "=q1=Hodir's Sigil", "=ds=#m3#", "", "21%"};
		Prev = "UlduarAuriaya25Man";
		Next = "UlduarThorim25Man";
	};

	AtlasLoot_Data["UlduarThorim"] = {
		{ 1, 45893, "", "=q4=Guise of the Midgard Serpent", "=ds=#s1#, #a2#", "", "19%"};
		{ 2, 45927, "", "=q4=Handwraps of Resonance", "=ds=#s9#, #a1#", "", "17%"};
		{ 3, 45894, "", "=q4=Leggings of Unstable Discharge", "=ds=#s11#, #a1#", "", "17%"};
		{ 4, 45895, "", "=q4=Belt of the Blood Pit", "=ds=#s10#, #a3#", "", "18%"};
		{ 5, 45892, "", "=q4=Legacy of Thunder", "=ds=#h1# #w6#", "", "18%"};
		{ 7, 45659, "", "=q4=Spaulders of the Wayward Conqueror", "=ds=#e15#", "", "25%"};
		{ 8, 45660, "", "=q4=Spaulders of the Wayward Protector", "=ds=#e15#", "", "28%"};
		{ 9, 45661, "", "=q4=Spaulders of the Wayward Vanquisher", "=ds=#e15#", "", "34%"};
		{ 16, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 17, 45928, "", "=q4=Gauntlets of the Thunder God", "=ds=#s9#, #a4#", "", "5%"};
		{ 18, 45933, "", "=q4=Pendant of the Shallow Grave", "=ds=#s2#", "", "4%"};
		{ 19, 45931, "", "=q4=Mjolnir Runestone", "=ds=#s14#", "", "5%"};
		{ 20, 45929, "", "=q4=Sif's Remembrance", "=ds=#s14#", "", "4%"};
		{ 21, 45930, "", "=q4=Combatant's Bootblade", "=ds=#h1# #w4#", "", "5%"};
		{ 23, 45784, "", "=q1=Thorim's Sigil", "=ds=#m3#", "", "5%"};
		Prev = "UlduarHodir";
		Next = "UlduarFreya";
	};

	AtlasLoot_Data["UlduarThorim25Man"] = {
		{ 1, 45038, "", "=q5=Fragment of Val'anyr", "=ds=#m3#", "", "40%"};
		{ 2, 46017, "", "=q5=Val'anyr, Hammer of Ancient Kings", "=q1=#m4#: =ds=#h1#, #w6#"};
		{ 4, 45468, "", "=q4=Leggings of Lost Love", "=ds=#s11#, #a1#", "", "17%"};
		{ 5, 45467, "", "=q4=Belt of the Betrayed", "=ds=#s10#, #a3#", "", "17%"};
		{ 6, 45469, "", "=q4=Sif's Promise", "=ds=#s13#", "", "14%"};
		{ 7, 45466, "", "=q4=Scale of Fates", "=ds=#s14#", "", "17%"};
		{ 8, 45463, "", "=q4=Vulmir, the Northern Tempest", "=ds=#h1# #w6#", "", "18%"};
		{ 10, 45638, "", "=q4=Crown of the Wayward Conqueror", "=ds=#e15#", "", "50%"};
		{ 11, 45639, "", "=q4=Crown of the Wayward Protector", "=ds=#e15#", "", "57%"};
		{ 12, 45640, "", "=q4=Crown of the Wayward Vanquisher", "=ds=#e15#", "", "71%"};
		{ 16, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 17, 45473, "", "=q4=Embrace of the Gladiator", "=ds=#s5#, #a2#", "", "2%"};
		{ 18, 45474, "", "=q4=Pauldrons of the Combatant", "=ds=#s3#, #a3#", "", "2%"};
		{ 19, 45472, "", "=q4=Warhelm of the Champion", "=ds=#s1#, #a4#", "", "1%"};
		{ 20, 45471, "", "=q4=Fate's Clutch", "=ds=#s13#", "", "1%"};
		{ 21, 45570, "", "=q4=Skyforge Crossbow", "=ds=#w3#", "", "1%"};
		{ 22, 45470, "", "=q4=Wisdom's Hold", "=ds=#w8#", "", "2%"};
		{ 24, 45817, "", "=q1=Thorim's Sigil", "=ds=#m3#", "", "3%"};
		Prev = "UlduarHodir25Man";
		Next = "UlduarFreya25Man";
	};

	AtlasLoot_Data["UlduarFreya"] = {
		{ 1, 45940, "", "=q4=Tunic of the Limber Stalker", "=ds=#s5#, #a2#", "", "15%"};
		{ 2, 45941, "", "=q4=Chestguard of the Lasher", "=ds=#s5#, #a3#", "", "15%"};
		{ 3, 45935, "", "=q4=Ironbark Faceguard", "=ds=#s1#, #a4#", "", "17%"};
		{ 4, 45936, "", "=q4=Legplates of Flourishing Resolve", "=ds=#s11#, #a4#", "", "15%"};
		{ 5, 45934, "", "=q4=Unraveling Reach", "=ds=#w9#", "", "18%"};
		{ 7, 45644, "", "=q4=Gloves of the Wayward Conqueror", "=ds=#e15#", "", "25%"};
		{ 8, 45645, "", "=q4=Gloves of the Wayward Protector", "=ds=#e15#", "", "23%"};
		{ 9, 45646, "", "=q4=Gloves of the Wayward Vanquisher", "=ds=#e15#", "", "30%"};
		{ 11, 46110, "", "=q3=Alchemist's Cache", "=ds=#p1# (425)", "", "66%"};
		{ 16, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 17, 45943, "", "=q4=Gloves of Whispering Winds", "=ds=#s9#, #a3#", "", "2%"};
		{ 18, 45945, "", "=q4=Seed of Budding Carnage", "=ds=#s2#", "", "2%"};
		{ 19, 45946, "", "=q4=Fire Orchid Signet", "=ds=#s13#", "", "2%"};
		{ 20, 45947, "", "=q4=Serilas, Blood Blade of Invar One-Arm", "=ds=#h1# #w10#", "", "2%"};
		{ 21, 45294, "", "=q4=Petrified Ivy Sprig", "=ds=#w12#", "", "1%"};
		{ 23, 45788, "", "=q1=Freya's Sigil", "=ds=#m3#", "", "4%"};
		Prev = "UlduarThorim";
		Next = "UlduarMimiron";
	};

	AtlasLoot_Data["UlduarFreya25Man"] = {
		{ 1, 45038, "", "=q5=Fragment of Val'anyr", "=ds=#m3#", "", "40%"};
		{ 2, 46017, "", "=q5=Val'anyr, Hammer of Ancient Kings", "=q1=#m4#: =ds=#h1#, #w6#"};
		{ 4, 45483, "", "=q4=Boots of the Servant", "=ds=#s12#, #a1#", "", "15%"};
		{ 5, 45482, "", "=q4=Leggings of the Lifetender", "=ds=#s11#, #a2#", "", "17%"};
		{ 6, 45481, "", "=q4=Gauntlets of Ruthless Reprisal", "=ds=#s9#, #a4#", "", "16%"};
		{ 7, 45480, "", "=q4=Nymph Heart Charm", "=ds=#s2#", "", "13%"};
		{ 8, 45479, "", "=q4=The Lifebinder", "=ds=#w9#", "", "19%"};
		{ 10, 45653, "", "=q4=Legplates of the Wayward Conqueror", "=ds=#e15#", "", "43%"};
		{ 11, 45654, "", "=q4=Legplates of the Wayward Protector", "=ds=#e15#", "", "52%"};
		{ 12, 45655, "", "=q4=Legplates of the Wayward Vanquisher", "=ds=#e15#", "", "69%"};
		{ 14, 46110, "", "=q3=Alchemist's Cache", "=ds=#p1# (425)", "", "66%"};
		{ 16, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 17, 45486, "", "=q4=Drape of the Sullen Goddess", "=ds=#s4#"};
		{ 18, 45488, "", "=q4=Leggings of the Enslaved Idol", "=ds=#s11#, #a1#", "", "0.13%"};
		{ 19, 45487, "", "=q4=Handguards of Revitalization", "=ds=#s9#, #a4#", "", "0.34%"};
		{ 20, 45485, "", "=q4=Bronze Pendant of the Vanir", "=ds=#s2#"};
		{ 21, 45484, "", "=q4=Bladetwister", "=ds=#h1#, #w4#", "", "0.27%"};
		{ 22, 45613, "", "=q4=Dreambinder", "=ds=#w9#", "", "1%"};
		{ 24, 45814, "", "=q1=Freya's Sigil", "=ds=#m3#", "", "0.27%"};
		Prev = "UlduarThorim25Man";
		Next = "UlduarMimiron25Man";
	};

	AtlasLoot_Data["UlduarMimiron"] = {
		{ 1, 45973, "", "=q4=Stylish Power Cape", "=ds=#s4#", "", "19%"};
		{ 2, 45976, "", "=q4=Static Charge Handwraps", "=ds=#s9#, #a1#", "", "20%"};
		{ 3, 45974, "", "=q4=Shoulderguards of Assimilation", "=ds=#s3#, #a2#", "", "75%"};
		{ 4, 45975, "", "=q4=Cable of the Metrognome", "=ds=#s10#, #a4#", "", "11%"};
		{ 5, 45972, "", "=q4=Pulse Baton", "=ds=#h3#, #w6#", "", "0.13%"};
		{ 7, 45647, "", "=q4=Helm of the Wayward Conqueror", "=ds=#e15#", "", "28%"};
		{ 8, 45648, "", "=q4=Helm of the Wayward Protector", "=ds=#e15#", "", "75%"};
		{ 9, 45649, "", "=q4=Helm of the Wayward Vanquisher", "=ds=#e15#", "", "37%"};
		{ 16, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 17, 45993, "", "=q4=Mimiron's Flight Goggles", "=ds=#s1#, #a2#", "", "1%"};
		{ 18, 45989, "", "=q4=Tempered Mercury Greaves", "=ds=#s12#, #a3#", "", "0.34%"};
		{ 19, 45982, "", "=q4=Fused Alloy Legplates", "=ds=#s11#, #a4#", "", "0.34%"};
		{ 20, 45988, "", "=q4=Greaves of the Iron Army", "=ds=#s12#, #a4#"};
		{ 21, 45990, "", "=q4=Fusion Blade", "=ds=#h1#, #w10#", "", "0.13%"};
		{ 23, 45787, "", "=q1=Mimiron's Sigil", "=ds=#m3#", "", "2%"};
		Prev = "UlduarFreya";
		Next = "UlduarVezax";
	};

	AtlasLoot_Data["UlduarMimiron25Man"] = {
		{ 1, 45038, "", "=q5=Fragment of Val'anyr", "=ds=#m3#", "", "40%"};
		{ 2, 46017, "", "=q5=Val'anyr, Hammer of Ancient Kings", "=q1=#m4#: =ds=#h1#, #w6#"};
		{ 4, 45493, "", "=q4=Asimov's Drape", "=ds=#s4#", "", "11%"};
		{ 5, 45492, "", "=q4=Malleable Steelweave Mantle", "=ds=#s3#, #a2#", "", "25%"};
		{ 6, 45491, "", "=q4=Waistguard of the Creator", "=ds=#s10#, #a2#", "", "17%"};
		{ 7, 45490, "", "=q4=Pandora's Plea", "=ds=#s14#", "", "17%"};
		{ 8, 45489, "", "=q4=Insanity's Grip", "=ds=#h3#, #w13#", "", "15%"};
		{ 10, 45641, "", "=q4=Gauntlets of the Wayward Conqueror", "=ds=#e15#", "", "45%"};
		{ 11, 45642, "", "=q4=Gauntlets of the Wayward Protector", "=ds=#e15#", "", "50%"};
		{ 12, 45643, "", "=q4=Gauntlets of the Wayward Vanquisher", "=ds=#e15#", "", "68%"};
		{ 16, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 17, 45496, "", "=q4=Titanskin Cloak", "=ds=#s4#", "", "0.33%"};
		{ 18, 45497, "", "=q4=Crown of Luminescence", "=ds=#s1#, #a1#"};
		{ 19, 45663, "", "=q4=Armbands of Bedlam", "=ds=#s8#, #a4#"};
		{ 20, 45495, "", "=q4=Conductive Seal", "=ds=#s13#"};
		{ 21, 45494, "", "=q4=Delirium's Touch", "=ds=#h4#, #w13#"};
		{ 22, 45620, "", "=q4=Starshard Edge", "=ds=#h3#, #w4#"};
		{ 24, 45816, "", "=q1=Mimiron's Sigil", "=ds=#m3#", "", "0.16%"};
		Prev = "UlduarFreya25Man";
		Next = "UlduarVezax25Man";
	};

	AtlasLoot_Data["UlduarVezax"] = {
		{ 1, 46014, "", "=q4=Saronite Animus Cloak", "=ds=#s4#", "", "22%"};
		{ 2, 46013, "", "=q4=Underworld Mantle", "=ds=#s3#, #a1#", "", "20%"};
		{ 3, 46012, "", "=q4=Vestments of the Piercing Light", "=ds=#s5#, #a1#", "", "20%"};
		{ 4, 46009, "", "=q4=Bindings of the Depths", "=ds=#s8#, #a2#", "", "17%"};
		{ 5, 46346, "", "=q4=Boots of Unsettled Prey", "=ds=#s12#, #a3#", "", "6%"};
		{ 6, 45997, "", "=q4=Gauntlets of the Wretched", "=ds=#s9#, #a4#", "", "17%"};
		{ 7, 46008, "", "=q4=Choker of the Abyss", "=ds=#s2#", "", "18%"};
		{ 8, 46015, "", "=q4=Pendant of Endless Despair", "=ds=#s2#", "", "18%"};
		{ 9, 46010, "", "=q4=Darkstone Ring", "=ds=#s13#", "", "21%"};
		{ 10, 46011, "", "=q4=Shadowbite", "=ds=#h1#, #w4#", "", "19%"};
		{ 11, 45996, "", "=q4=Hoperender", "=ds=#w7#", "", "22%"};
		{ 16, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 17, 46032, "", "=q4=Drape of the Faceless General", "=ds=#s4#", "", "2%"};
		{ 18, 46034, "", "=q4=Leggings of Profound Darkness", "=ds=#s11#, #a1#", "", "3%"};
		{ 19, 46036, "", "=q4=Void Sabre", "=ds=#h1#, #w10#", "", "2%"};
		{ 20, 46035, "", "=q4=Aesuga, Hand of the Ardent Champion", "=ds=#h1#, #w6#", "", "3%"};
		{ 21, 46033, "", "=q4=Tortured Earth", "=ds=#w9#", "", "4%"};
		Prev = "UlduarMimiron";
		Next = "UlduarYoggSaron";
	};

	AtlasLoot_Data["UlduarVezax25Man"] = {
		{ 1, 45038, "", "=q5=Fragment of Val'anyr", "=ds=#m3#", "", "40%"};
		{ 2, 46017, "", "=q5=Val'anyr, Hammer of Ancient Kings", "=q1=#m4#: =ds=#h1#, #w6#"};
		{ 4, 45514, "", "=q4=Mantle of the Unknowing", "=ds=#s3#, #a1#", "", "20%"};
		{ 5, 45508, "", "=q4=Belt of the Darkspeaker", "=ds=#s10#, #a1#", "", "21%"};
		{ 6, 45512, "", "=q4=Grips of the Unbroken", "=ds=#s9#, #a2#", "", "19%"};
		{ 7, 45504, "", "=q4=Darkcore Leggings", "=ds=#s11#, #a3#", "", "18%"};
		{ 8, 45513, "", "=q4=Boots of the Forgotten Depths", "=ds=#s12#, #a3#", "", "18%"};
		{ 9, 45502, "", "=q4=Helm of the Faceless", "=ds=#s1#, #a4#", "", "19%"};
		{ 10, 45505, "", "=q4=Belt of Clinging Hope", "=ds=#s10#, #a4#", "", "19%"};
		{ 11, 45501, "", "=q4=Boots of the Underdweller", "=ds=#s12#, #a4#", "", "17%"};
		{ 12, 45503, "", "=q4=Metallic Loop of the Sufferer", "=ds=#s13#", "", "20%"};
		{ 13, 45515, "", "=q4=Ring of the Vacant Eye", "=ds=#s13#", "", "21%"};
		{ 14, 45507, "", "=q4=The General's Heart", "=ds=#s14#", "", "20%"};
		{ 15, 45509, "", "=q4=Idol of the Corruptor", "=ds=#s16#, #w14#", "", "17%"};
		{ 16, 45145, "", "=q4=Libram of the Sacred Shield", "=ds=#s16#, #w16#", "", "19%"};
		{ 17, 45498, "", "=q4=Lotrafen, Spear of the Damned", "=ds=#w7#", "", "20%"};
		{ 18, 45511, "", "=q4=Scepter of Lost Souls", "=ds=#w12#", "", "19%"};
		{ 20, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 21, 45520, "", "=q4=Handwraps of the Vigilant", "=ds=#s9#, #a1#", "", "0.32%"};
		{ 22, 45519, "", "=q4=Vestments of the Blind Denizen", "=ds=#s5#, #a2#", "", "0.32%"};
		{ 23, 45517, "", "=q4=Pendulum of Infinity", "=ds=#s2#", "", "0.36%"};
		{ 24, 45518, "", "=q4=Flare of the Heavens", "=ds=#s14#"};
		{ 25, 45516, "", "=q4=Voldrethar, Dark Blade of Oblivion", "=ds=#h2#, #w10#"};
		Prev = "UlduarMimiron25Man";
		Next = "UlduarYoggSaron25Man";
	};

	AtlasLoot_Data["UlduarYoggSaron"] = {
		{ 1, 46030, "", "=q4=Treads of the Dragon Council", "=ds=#s12#, #a1#", "", "17%"};
		{ 2, 46019, "", "=q4=Leggings of the Insatiable", "=ds=#s11#, #a3#", "", "12%"};
		{ 3, 46028, "", "=q4=Faceguard of the Eyeless Horror", "=ds=#s1#, #a4#", "", "17%"};
		{ 4, 46022, "", "=q4=Pendant of a Thousand Maws", "=ds=#s2#", "", "8%"};
		{ 5, 46021, "", "=q4=Royal Seal of King Llane", "=ds=#s14#", "", "12%"};
		{ 6, 46024, "", "=q4=Kingsbane", "=ds=#h1#, #w4#", "", "10%"};
		{ 7, 46016, "", "=q4=Abaddon", "=ds=#h2#, #w10#", "", "17%"};
		{ 8, 46031, "", "=q4=Touch of Madness", "=ds=#h1#, #w1#", "", "25%"};
		{ 9, 46025, "", "=q4=Devotion", "=ds=#w9#", "", "23%"};
		{ 10, 46018, "", "=q4=Deliverance", "=ds=#w3#", "", "35%"};
		{ 12, 45635, "", "=q4=Chestguard of the Wayward Conqueror", "=ds=#e15#", "", "52%"};
		{ 13, 45636, "", "=q4=Chestguard of the Wayward Protector", "=ds=#e15#", "", "50%"};
		{ 14, 45637, "", "=q4=Chestguard of the Wayward Vanquisher", "=ds=#e15#", "", "27%"};
		{ 16, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 17, 46068, "", "=q4=Amice of Inconceivable Horror", "=ds=#s3#, #a1#"};
		{ 18, 46095, "", "=q4=Soul-Devouring Cinch", "=ds=#s10#, #a2#"};
		{ 19, 46096, "", "=q4=Signet of Soft Lament", "=ds=#s13#"};
		{ 20, 46097, "", "=q4=Caress of Insanity", "=ds=#h1#, #w6#"};
		{ 21, 46067, "", "=q4=Hammer of Crushing Whispers", "=ds=#h2#, #w6#"};
		{ 23, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["Alone in the Darkness"]};
		{ 24, 46312, "", "=q4=Vanquished Clutches of Yogg-Saron", "=ds=#s14#", "", "100%"};
		Prev = "UlduarVezax";
		Next = "UlduarTrash";
	};

	AtlasLoot_Data["UlduarYoggSaron25Man"] = {
		{ 1, 45038, "", "=q5=Fragment of Val'anyr", "=ds=#m3#", "", "40%"};
		{ 2, 46017, "", "=q5=Val'anyr, Hammer of Ancient Kings", "=q1=#m4#: =ds=#h1#, #w6#"};
		{ 4, 45529, "", "=q4=Shawl of Haunted Memories", "=ds=#s4#", "", "25%"};
		{ 5, 45532, "", "=q4=Cowl of Dark Whispers", "=ds=#s1#, #a1#", "", "17%"};
		{ 6, 45523, "", "=q4=Garona's Guise", "=ds=#s1#, #a2#", "", "18%"};
		{ 7, 45524, "", "=q4=Chestguard of Insidious Intent", "=ds=#s5#, #a3#", "", "13%"};
		{ 8, 45531, "", "=q4=Chestguard of the Fallen God", "=ds=#s5#, #a3#", "", "16%"};
		{ 9, 45525, "", "=q4=Godbane Signet", "=ds=#s13#", "", "11%"};
		{ 10, 45530, "", "=q4=Sanity's Bond", "=ds=#s13#", "", "18%"};
		{ 11, 45522, "", "=q4=Blood of the Old God", "=ds=#s14#", "", "20%"};
		{ 12, 45527, "", "=q4=Soulscribe", "=ds=#h3#, #w4#", "", "9%"};
		{ 13, 45521, "", "=q4=Earthshaper", "=ds=#h2#, #w6#", "", "15%"};
		{ 16, 45656, "", "=q4=Mantle of the Wayward Conqueror", "=ds=#e15#", "", "59%"};
		{ 17, 45657, "", "=q4=Mantle of the Wayward Protector", "=ds=#e15#", "", "54%"};
		{ 18, 45658, "", "=q4=Mantle of the Wayward Vanquisher", "=ds=#e15#", "", "66%"};
		{ 20, 0, "INV_Box_01", "=q6=#j53#", ""};
		{ 21, 45537, "", "=q4=Treads of the False Oracle", "=ds=#s12#, #a1#", "", "1%"};
		{ 22, 45536, "", "=q4=Legguards of Cunning Deception", "=ds=#s11#, #a2#", "", "1%"};
		{ 23, 45534, "", "=q4=Seal of the Betrayed King", "=ds=#s13#"};
		{ 24, 45535, "", "=q4=Show of Faith", "=ds=#s14#"};
		{ 25, 45533, "", "=q4=Dark Edge of Depravity", "=ds=#h2#, #w1#", "", "1%"};
		{ 27, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["Alone in the Darkness"]};
		{ 28, 45693, "", "=q4=Mimiron's Head", "=ds=#e12#", "", "100%"};
		Prev = "UlduarVezax25Man";
		Next = "UlduarTrash25Man";
	};

	AtlasLoot_Data["UlduarTrash"] = {
		{ 1, 46341, "", "=q4=Drape of the Spellweaver", "=ds=#s4#", "", "2%"};
		{ 2, 46347, "", "=q4=Cloak of the Dormant Blaze", "=ds=#s4#", "", "2%"};
		{ 3, 46344, "", "=q4=Iceshear Mantle", "=ds=#s3#, #a1#", "", "2%"};
		{ 4, 46346, "", "=q4=Boots of Unsettled Prey", "=ds=#s12#, #a3#", "", "6%"};
		{ 5, 46345, "", "=q4=Bracers of Righteous Reformation", "=ds=#s8#, #a4#", "", "2%"};
		{ 6, 46340, "", "=q4=Adamant Handguards", "=ds=#s9#, #a4#", "", "2%"};
		{ 7, 46343, "", "=q4=Fervor of the Protectorate", "=ds=#s2#", "", "2%"};
		{ 8, 46339, "", "=q4=Mimiron's Repeater", "=ds=#w5#", "", "2%"};
		{ 9, 46351, "", "=q4=Bloodcrush Cudgel", "=ds=#h1# #w6#", "", "2%"};
		{ 10, 46350, "", "=q4=Pillar of Fortitude", "=ds=#w9#", "", "2%"};
		{ 11, 46342, "", "=q4=Golemheart Longbow", "=ds=#w2#", "", "2%"};
		Prev = "UlduarYoggSaron";
		Next = "UlduarPatterns";
	};

	AtlasLoot_Data["UlduarTrash25Man"] = {
		{ 1, 45541, "", "=q4=Shroud of Alteration", "=ds=#s4#", "", "2%"};
		{ 2, 45549, "", "=q4=Grips of Chaos", "=ds=#s8#, #a1#", "", "3%"};
		{ 3, 45547, "", "=q4=Relic Hunter's Cord", "=ds=#s10#, #a2#", "", "3%"};
		{ 4, 45548, "", "=q4=Belt of the Sleeper", "=ds=#s10#, #a2#", "", "2%"};
		{ 5, 45543, "", "=q4=Shoulders of Misfortune", "=ds=#s3#, #a3#", "", "2%"};
		{ 6, 45544, "", "=q4=Leggings of the Tortured Earth", "=ds=#s11#, #a3#", "", "2%"};
		{ 7, 45542, "", "=q4=Greaves of the Stonewarder", "=ds=#s12#, #a4#", "", "2%"};
		{ 8, 45540, "", "=q4=Bladebearer's Signet", "=ds=#s13#", "", "2%"};
		{ 9, 45539, "", "=q4=Pendant of Focused Energies", "=ds=#s2#", "", "6%"};
		{ 10, 45538, "", "=q4=Titanstone Pendant", "=ds=#s2#", "", "3%"};
		{ 11, 46138, "", "=q4=Idol of the Flourishing Life", "=ds=#s16#, #w14#", "", "6%"};
		{ 12, 45605, "", "=q4=Daschal's Bite", "=ds=#h1# #w4#", "", "2%"};
		Prev = "UlduarYoggSaron25Man";
		Next = "UlduarPatterns";
	};

	AtlasLoot_Data["UlduarPatterns"] = {
		{ 1, 45089, "", "=q4=Plans: Battlelord's Plate Boots", "=ds=#p2# (450)"};
		{ 2, 45088, "", "=q4=Plans: Belt of the Titans", "=ds=#p2# (450)"};
		{ 3, 45092, "", "=q4=Plans: Indestructible Plate Girdle", "=ds=#p2# (450)"};
		{ 4, 45090, "", "=q4=Plans: Plate Girdle of Righteousness", "=ds=#p2# (450)"};
		{ 5, 45093, "", "=q4=Plans: Spiked Deathdealers", "=ds=#p2# (450)"};
		{ 6, 46027, "", "=q4=Formula: Enchant Weapon - Blade Ward", "=ds=#p4# (450)"};
		{ 7, 46348, "", "=q4=Formula: Enchant Weapon - Blood Draining", "=ds=#p4# (450)"};
		{ 8, 45100, "", "=q4=Pattern: Belt of Arctic Life", "=ds=#p7# (450)"};
		{ 9, 45094, "", "=q4=Pattern: Belt of Dragons", "=ds=#p7# (450)"};
		{ 10, 45096, "", "=q4=Pattern: Blue Belt of Chaos", "=ds=#p7# (450)"};
		{ 11, 45095, "", "=q4=Pattern: Boots of Living Scale", "=ds=#p7# (450)"};
		{ 12, 45101, "", "=q4=Pattern: Boots of Wintry Endurance", "=ds=#p7# (450)"};
		{ 13, 45098, "", "=q4=Pattern: Death-warmed Belt", "=ds=#p7# (450)"};
		{ 14, 45099, "", "=q4=Pattern: Footpads of Silence", "=ds=#p7# (450)"};
		{ 15, 45097, "", "=q4=Pattern: Lightning Grounded Boots", "=ds=#p7# (450)"};
		{ 16, 45104, "", "=q4=Pattern: Cord of the White Dawn", "=ds=#p8# (450)"};
		{ 17, 45102, "", "=q4=Pattern: Sash of Ancient Power", "=ds=#p8# (450)"};
		{ 18, 45105, "", "=q4=Pattern: Savior's Slippers", "=ds=#p8# (450)"};
		{ 19, 45103, "", "=q4=Pattern: Spellslinger's Slippers", "=ds=#p8# (450)"};
		{ 30, 45087, "", "=q3=Runed Orb", "=ds=#e8#"};
	};

		-----------------------------
		--- Trial of the Champion ---
		-----------------------------

	AtlasLoot_Data["TrialoftheChampionChampions"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 47173, "", "=q4=Bindings of the Wicked", "=ds=#s8#, #a1#"};
		{ 3, 47170, "", "=q4=Belt of Fierce Competition", "=ds=#s10#, #a2#"};
		{ 4, 47174, "", "=q4=Binding of the Tranquil Glade", "=ds=#s10#, #a2#"};
		{ 5, 47175, "", "=q4=Scale Boots of the Outlander", "=ds=#s12#, #a3#"};
		{ 6, 47172, "", "=q4=Helm of the Bested Gallant", "=ds=#s1#, #a4#"};
		{ 7, 47171, "", "=q4=Legguards of Abandoned Fealty", "=ds=#s11#, #a4#"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 47249, "", "=q4=Leggings of the Snowy Bramble", "=ds=#s11#, #a2#"};
		{ 19, 47248, "", "=q4=Treads of Dismal Fortune", "=ds=#s12#, #a2#"};
		{ 20, 47250, "", "=q4=Pauldrons of the Deafening Gale", "=ds=#s3#, #a3#"};
		{ 21, 47244, "", "=q4=Chestguard of the Ravenous Fiend", "=ds=#s5#, #a3#"};
		{ 22, 47243, "", "=q4=Mark of the Relentless", "=ds=#s13#"};
		{ 23, 47493, "", "=q4=Edge of Ruin", "=ds=#h2#, #w1#"};
		{ 24, 44990, "", "=q1=Champion's Seal", "=ds=#e15#", "", "100%"};
		Next = "TrialoftheChampionConfessorPaletress";
	};

	AtlasLoot_Data["TrialoftheChampionConfessorPaletress"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 47181, "", "=q4=Belt of the Churning Blaze", "=ds=#s10#, #a1#"};
		{ 3, 47218, "", "=q4=The Confessor's Binding", "=ds=#s10#, #a1#"};
		{ 4, 47185, "", "=q4=Leggings of the Haggard Apprentice", "=ds=#s11#, #a1#"};
		{ 5, 47217, "", "=q4=Gaze of the Somber Keeper", "=ds=#s1#, #a2#"};
		{ 6, 47177, "", "=q4=Gloves of the Argent Fanatic", "=ds=#s9#, #a2#"};
		{ 7, 47178, "", "=q4=Carapace of Grim Visions", "=ds=#s5#, #a3#"};
		{ 8, 47211, "", "=q4=Wristguards of Ceaseless Regret", "=ds=#s8#, #a3#"};
		{ 9, 47176, "", "=q4=Breastplate of the Imperial Joust", "=ds=#s5#, #a4#"};
		{ 10, 47212, "", "=q4=Mercy's Hold", "=ds=#s9#, #a4#"};
		{ 11, 47219, "", "=q4=Brilliant Hailstone Amulet", "=ds=#s2#"};
		{ 12, 47213, "", "=q4=Abyssal Rune", "=ds=#s14#"};
		{ 13, 47214, "", "=q4=Banner of Victory", "=ds=#s14#"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 47498, "", "=q4=Gloves of Dismal Fortune", "=ds=#s9#, #a2#"};
		{ 19, 47496, "", "=q4=Armbands of the Wary Lookout", "=ds=#s8#, #a2#"};
		{ 20, 47245, "", "=q4=Pauldrons of Concealed Loathing", "=ds=#s3#, #a3#"};
		{ 21, 47497, "", "=q4=Helm of the Crestfallen Challenger", "=ds=#s1#, #a4#"};
		{ 22, 47514, "", "=q4=Regal Aurous Shoulderplates", "=ds=#s3#, #a4#"};
		{ 23, 47510, "", "=q4=Trueheart Girdle", "=ds=#s10#, #a4#"};
		{ 24, 47495, "", "=q4=Legplates of Relentless Onslaught", "=ds=#s11#, #a4#"};
		{ 25, 47511, "", "=q4=Plated Greaves of Providence", "=ds=#s12#, #a4#"};
		{ 26, 47494, "", "=q4=Ancient Pendant of Arathor", "=ds=#s2#"};
		{ 27, 47512, "", "=q4=Sinner's Confession", "=ds=#s13#"};
		{ 28, 47500, "", "=q4=Peacekeeper Blade", "=ds=#h1#, #w10#"};
		{ 29, 47522, "", "=q4=Marrowstrike", "=ds=#w7#"};
		{ 30, 44990, "", "=q1=Champion's Seal", "=ds=#e15#", "", "100%"};
		Prev = "TrialoftheChampionChampions";
		Next = "TrialoftheChampionEadricthePure";
	};

	AtlasLoot_Data["TrialoftheChampionEadricthePure"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 47181, "", "=q4=Belt of the Churning Blaze", "=ds=#s10#, #a1#"};
		{ 3, 47185, "", "=q4=Leggings of the Haggard Apprentice", "=ds=#s11#, #a1#"};
		{ 4, 47210, "", "=q4=Mantle of Gnarled Overgrowth", "=ds=#s3#, #a2#"};
		{ 5, 47177, "", "=q4=Gloves of the Argent Fanatic", "=ds=#s9#, #a2#"};
		{ 6, 47202, "", "=q4=Leggings of Brazen Trespass", "=ds=#s11#, #a2#"};
		{ 7, 47178, "", "=q4=Carapace of Grim Visions", "=ds=#s5#, #a3#"};
		{ 8, 47176, "", "=q4=Breastplate of the Imperial Joust", "=ds=#s5#, #a4#"};
		{ 9, 47197, "", "=q4=Gauntlets of the Stouthearted Crusader", "=ds=#s9#, #a4#"};
		{ 10, 47201, "", "=q4=Boots of Heartfelt Repentance", "=ds=#s12#, #a4#"};
		{ 11, 47199, "", "=q4=Greaves of the Grand Paladin", "=ds=#s12#, #a4#"};
		{ 12, 47200, "", "=q4=Signet of Purity", "=ds=#s13#"};
		{ 13, 47213, "", "=q4=Abyssal Rune", "=ds=#s14#"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 18, 47501, "", "=q4=Kurisu's Indecision", "=ds=#s4#"};
		{ 19, 47496, "", "=q4=Armbands of the Wary Lookout", "=ds=#s8#, #a2#"};
		{ 20, 47498, "", "=q4=Gloves of Dismal Fortune", "=ds=#s9#, #a2#"};
		{ 21, 47504, "", "=q4=Barkhide Treads", "=ds=#s12#, #a2#"};
		{ 22, 47497, "", "=q4=Helm of the Crestfallen Challenger", "=ds=#s1#, #a4#"};
		{ 23, 47502, "", "=q4=Majestic Silversmith Shoulderplates", "=ds=#s3#, #a4#"};
		{ 24, 47495, "", "=q4=Legplates of Relentless Onslaught", "=ds=#s11#, #a4#"};
		{ 25, 47503, "", "=q4=Legplates of the Argent Armistice", "=ds=#s11#, #a4#"};
		{ 26, 47494, "", "=q4=Ancient Pendant of Arathor", "=ds=#s2#"};
		{ 27, 47500, "", "=q4=Peacekeeper Blade", "=ds=#h1#, #w10#"};
		{ 28, 47509, "", "=q4=Mariel's Sorrow", "=ds=#h3#, #w6#"};
		{ 29, 47508, "", "=q4=Aledar's Battlestar", "=ds=#h1#, #w6#"};
		{ 30, 44990, "", "=q1=Champion's Seal", "=ds=#e15#", "", "100%"};
		Prev = "TrialoftheChampionConfessorPaletress";
		Next = "TrialoftheChampionBlackKnight";
	};

	AtlasLoot_Data["TrialoftheChampionBlackKnight"] = {
		{ 1, 47232, "", "=q4=Drape of the Undefeated", "=ds=#s4#"};
		{ 2, 47226, "", "=q4=Mantle of Inconsolable Fear", "=ds=#s3#, #a1#"};
		{ 3, 47230, "", "=q4=Handwraps of Surrendered Hope", "=ds=#s9#, #a1#"};
		{ 4, 47221, "", "=q4=Shoulderpads of the Infamous Knave", "=ds=#s3#, #a2#"};
		{ 5, 47231, "", "=q4=Belt of Merciless Cruelty", "=ds=#s10#, #a3#"};
		{ 6, 47228, "", "=q4=Leggings of the Bloodless Knight", "=ds=#s11#, #a3#"};
		{ 7, 47220, "", "=q4=Helm of the Violent Fray", "=ds=#s1#, #a4#"};
		{ 8, 47229, "", "=q4=Girdle of Arrogant Downfall", "=ds=#s10#, #a4#"};
		{ 9, 47227, "", "=q4=Girdle of the Pallid Knight", "=ds=#s10#, #a4#"};
		{ 16, 47222, "", "=q4=Uruka's Band of Zeal", "=ds=#s13#"};
		{ 17, 47215, "", "=q4=Tears of the Vanquished", "=ds=#s14#"};
		{ 18, 47216, "", "=q4=The Black Heart", "=ds=#s14#"};
		Prev = "TrialoftheChampionEadricthePure";
	};

	AtlasLoot_Data["TrialoftheChampionBlackKnightHEROIC"] = {
		{ 1, 47241, "", "=q4=Emblem of Triumph", "=ds=#e15#", "", "100%"};
		{ 2, 47564, "", "=q4=Gaze of the Unknown", "=ds=#s1#, #a1#"};
		{ 3, 47527, "", "=q4=Embrace of Madness", "=ds=#s5#, #a1#"};
		{ 4, 47560, "", "=q4=Boots of the Crackling Flame", "=ds=#s12#, #a1#"};
		{ 5, 47529, "", "=q4=Mask of Distant Memory", "=ds=#s1#, #a2#"};
		{ 6, 47561, "", "=q4=Gloves of the Dark Exile", "=ds=#s9#, #a3#"};
		{ 7, 47563, "", "=q4=Girdle of the Dauntless Conqueror", "=ds=#s10#, #a3#"};
		{ 8, 47565, "", "=q4=Vambraces of Unholy Command", "=ds=#s8#, #a4#"};
		{ 9, 47567, "", "=q4=Gauntlets of Revelation", "=ds=#s9#, #a4#"};
		{ 10, 47562, "", "=q4=Symbol of Redemption", "=ds=#s2#"};
		{ 11, 47566, "", "=q4=The Warlord's Depravity", "=ds=#s2#"};
		{ 16, 47569, "", "=q4=Spectral Kris", "=ds=#h3#, #w4#"};
		{ 17, 49682, "", "=q4=Black Knight's Rondel", "=ds=#h1#, #w4#"};
		{ 18, 47568, "", "=q4=True-aim Long Rifle", "=ds=#w5#"};
		{ 20, 43102, "", "=q3=Frozen Orb", "=ds=#e6#", "", "100%"};
		{ 22, 44990, "", "=q1=Champion's Seal", "=ds=#e15#", "", "100%"};
		Prev = "TrialoftheChampionEadricthePure";
	};

		-----------------------------
		--- Trial of the Crusader ---
		-----------------------------

	AtlasLoot_Data["TrialoftheCrusaderNorthrendBeasts_A"] = {
		{ 1, 47617, "", "=q4=Icehowl Cinch", "=ds=#s10#, #a1#"};
		{ 2, 47613, "", "=q4=Shoulderpads of the Glacial Wilds", "=ds=#s3#, #a2#"};
		{ 3, 47608, "", "=q4=Acidmaw Boots", "=ds=#s12#, #a2#"};
		{ 4, 47616, "", "=q4=Shoulderguards of the Spirit Walker", "=ds=#s3#, #a3#"};
		{ 5, 47610, "", "=q4=Armbands of the Northern Stalker", "=ds=#s8#, #a3#"};
		{ 6, 47611, "", "=q4=Dreadscale Armguards", "=ds=#s8#, #a4#"};
		{ 7, 47609, "", "=q4=Gauntlets of Rising Anger", "=ds=#s9#, #a4#"};
		{ 8, 47615, "", "=q4=Belt of the Frozen Reach", "=ds=#s10#, #a4#"};
		{ 9, 47614, "", "=q4=Girdle of the Impaler", "=ds=#s10#, #a4#"};
		{ 16, 47607, "", "=q4=Collar of Ceaseless Torment", "=ds=#s2#"};
		{ 17, 47578, "", "=q4=Carnivorous Band", "=ds=#s13#"};
		{ 19, 47612, "", "=q4=Rod of Imprisoned Souls", "=ds=#w12#"};
		Next = "TrialoftheCrusaderLordJaraxxus_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderNorthrendBeasts_H"] = {
		{ 1, 47855, "", "=q4=Icehowl Binding", "=ds=#s10#, #a1#"};
		{ 2, 47857, "", "=q4=Pauldrons of the Glacial Wilds", "=ds=#s3#, #a2#"};
		{ 3, 47853, "", "=q4=Acidmaw Treads", "=ds=#s12#, #a2#"};
		{ 4, 47860, "", "=q4=Pauldrons of the Spirit Walker", "=ds=#s3#, #a3#"};
		{ 5, 47850, "", "=q4=Bracers of the Northern Stalker", "=ds=#s8#, #a3#"};
		{ 6, 47852, "", "=q4=Dreadscale Bracers", "=ds=#s8#, #a4#"};
		{ 7, 47851, "", "=q4=Gauntlets of Mounting Anger", "=ds=#s9#, #a4#"};
		{ 8, 47859, "", "=q4=Belt of the Impaler", "=ds=#s10#, #a4#"};
		{ 9, 47858, "", "=q4=Girdle of the Frozen Reach", "=ds=#s10#, #a4#"};
		{ 16, 47849, "", "=q4=Collar of Unending Torment", "=ds=#s2#"};
		{ 17, 47854, "", "=q4=Gormok's Band", "=ds=#s13#"};
		{ 19, 47856, "", "=q4=Scepter of Imprisoned Souls", "=ds=#w12#"};
		Next = "TrialoftheCrusaderLordJaraxxus_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderNorthrendBeasts25Man_A"] = {
		{ 1, 46970, "", "=q4=Drape of the Untamed Predator", "=ds=#s4#"};
		{ 2, 46976, "", "=q4=Shawl of the Refreshing Winds", "=ds=#s4#"};
		{ 3, 46992, "", "=q4=Flowing Vestments of Ascent", "=ds=#s5#, #a1#"};
		{ 4, 46972, "", "=q4=Cord of the Tenebrous Mist", "=ds=#s10#, #a1#"};
		{ 5, 46974, "", "=q4=Leggings of the Broken Beast", "=ds=#s11#, #a2#"};
		{ 6, 46988, "", "=q4=Boots of the Unrelenting Storm", "=ds=#s12#, #a2#"};
		{ 7, 46960, "", "=q4=Breastplate of Cruel Intent", "=ds=#s5#, #a3#"};
		{ 8, 46990, "", "=q4=Belt of the Ice Burrower", "=ds=#s10#, #a3#"};
		{ 9, 46962, "", "=q4=Chestplate of the Towering Monstrosity", "=ds=#s5#, #a4#"};
		{ 10, 46961, "", "=q4=Boneshatter Armplates", "=ds=#s8#, #a4#"};
		{ 11, 46985, "", "=q4=Boots of the Courageous", "=ds=#s12#, #a4#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 46959, "", "=q4=Band of the Violent Temperment", "=ds=#s13#"};
		{ 20, 46979, "", "=q4=Blade of Tarasque", "=ds=#h3#, #w4#"};
		{ 21, 46958, "", "=q4=Steel Bladebreaker", "=ds=#h1#, #w4#"};
		{ 22, 46963, "", "=q4=Crystal Plated Vanguard", "=ds=#w8#"};
		Next = "TrialoftheCrusaderLordJaraxxus25Man_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderNorthrendBeasts25Man_H"] = {
		{ 1, 47257, "", "=q4=Cloak of the Untamed Predator", "=ds=#s4#"};
		{ 2, 47256, "", "=q4=Drape of the Refreshing Winds", "=ds=#s4#"};
		{ 3, 47264, "", "=q4=Flowing Robes of Ascent", "=ds=#s5#, #a1#"};
		{ 4, 47258, "", "=q4=Belt of the Tenebrous Mist", "=ds=#s10#, #a1#"};
		{ 5, 47259, "", "=q4=Legwraps of the Broken Beast", "=ds=#s11#, #a2#"};
		{ 6, 47262, "", "=q4=Boots of the Harsh Winter", "=ds=#s12#, #a2#"};
		{ 7, 47251, "", "=q4=Cuirass of Cruel Intent", "=ds=#s5#, #a3#"};
		{ 8, 47265, "", "=q4=Binding of the Ice Burrower", "=ds=#s10#, #a3#"};
		{ 9, 47254, "", "=q4=Hauberk of the Towering Monstrosity", "=ds=#s5#, #a4#"};
		{ 10, 47253, "", "=q4=Boneshatter Vambraces", "=ds=#s8#, #a4#"};
		{ 11, 47263, "", "=q4=Sabatons of the Courageous", "=ds=#s12#, #a4#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47252, "", "=q4=Ring of the Violent Temperament", "=ds=#s13#"};
		{ 20, 47261, "", "=q4=Barb of Tarasque", "=ds=#h3#, #w4#"};
		{ 21, 47255, "", "=q4=Stygian Bladebreaker", "=ds=#h1#, #w4#"};
		{ 22, 47260, "", "=q4=Forlorn Barrier", "=ds=#w8#"};
		Next = "TrialoftheCrusaderLordJaraxxus25Man_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderLordJaraxxus_A"] = {
		{ 1, 47663, "", "=q4=Felspark Bindings", "=ds=#s8#, #a1#"};
		{ 2, 47620, "", "=q4=Leggings of the Demonic Messenger", "=ds=#s11#, #a1#"};
		{ 3, 47669, "", "=q4=Belt of the Winter Solstice", "=ds=#s10#, #a2#"};
		{ 4, 47621, "", "=q4=Girdle of the Farseer", "=ds=#s10#, #a3#"};
		{ 5, 49235, "", "=q4=Boots of Tortured Space", "=ds=#s12#, #a3#"};
		{ 6, 47683, "", "=q4=Sentinel Scouting Greaves", "=ds=#s12#, #a3#"};
		{ 7, 47680, "", "=q4=Armguards of the Nether Lord", "=ds=#s8#, #a4#"};
		{ 8, 47711, "", "=q4=Girdle of the Nether Champion", "=ds=#s10#, #a4#"};
		{ 16, 47619, "", "=q4=Amulet of Binding Elements", "=ds=#s2#"};
		{ 17, 47679, "", "=q4=Endurance of the Infernal", "=ds=#s2#"};
		{ 18, 47618, "", "=q4=Firestorm Ring", "=ds=#s13#"};
		{ 19, 47703, "", "=q4=Planestalker Signet", "=ds=#s13#"};
		{ 21, 47676, "", "=q4=Dirk of the Night Watch", "=ds=#h1#, #w4#"};
		Prev = "TrialoftheCrusaderNorthrendBeasts_A";
		Next = "TrialoftheCrusaderFactionChampions_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderLordJaraxxus_H"] = {
		{ 1, 47861, "", "=q4=Felspark Bracers", "=ds=#s8#, #a1#"};
		{ 2, 47865, "", "=q4=Legwraps of the Demonic Messenger", "=ds=#s11#, #a1#"};
		{ 3, 47863, "", "=q4=Belt of the Bloodhoof Emissary", "=ds=#s10#, #a2#"};
		{ 4, 47866, "", "=q4=Darkspear Ritual Binding", "=ds=#s10#, #a3#"};
		{ 5, 49236, "", "=q4=Sabatons of Tortured Space", "=ds=#s12#, #a3#"};
		{ 6, 47867, "", "=q4=Warsong Poacher's Greaves", "=ds=#s12#, #a3#"};
		{ 7, 47869, "", "=q4=Armplates of the Nether Lord", "=ds=#s8#, #a4#"};
		{ 8, 47870, "", "=q4=Belt of the Nether Champion", "=ds=#s10#, #a4#"};
		{ 16, 47872, "", "=q4=Fortitude of the Infernal", "=ds=#s2#"};
		{ 17, 47864, "", "=q4=Pendant of Binding Elements", "=ds=#s2#"};
		{ 18, 47862, "", "=q4=Firestorm Band", "=ds=#s13#"};
		{ 19, 47868, "", "=q4=Planestalker Band", "=ds=#s13#"};
		{ 21, 47871, "", "=q4=Orcish Deathblade", "=ds=#h1#, #w4#"};
		Prev = "TrialoftheCrusaderNorthrendBeasts_H";
		Next = "TrialoftheCrusaderFactionChampions_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderLordJaraxxus25Man_A"] = {
		{ 1, 47042, "", "=q4=Pride of the Eredar", "=ds=#s4#"};
		{ 2, 47051, "", "=q4=Leggings of the Soothing Touch", "=ds=#s11#, #a1#"};
		{ 3, 47000, "", "=q4=Cuirass of Calamitous Fate", "=ds=#s5#, #a2#"};
		{ 4, 47055, "", "=q4=Bracers of the Autumn Willow", "=ds=#s8#, #a2#"};
		{ 5, 47056, "", "=q4=Bracers of Cloudy Omen", "=ds=#s8#, #a3#"};
		{ 6, 46999, "", "=q4=Bloodbath Belt", "=ds=#s10#, #a4#"};
		{ 7, 47057, "", "=q4=Legplates of Failing Light", "=ds=#s11#, #a4#"};
		{ 8, 47052, "", "=q4=Legguards of Feverish Dedication", "=ds=#s11#, #a4#"};
		{ 9, 46997, "", "=q4=Dawnbreaker Greaves", "=ds=#s12#, #a4#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47043, "", "=q4=Charge of the Demon Lord", "=ds=#s2#"};
		{ 19, 47223, "", "=q4=Ring of the Darkmender", "=ds=#s13#"};
		{ 20, 47041, "", "=q4=Solace of the Defeated", "=ds=#s14#"};
		{ 21, 47053, "", "=q4=Symbol of Transgression", "=ds=#s15#"};
		{ 23, 46996, "", "=q4=Lionhead Slasher", "=ds=#h1#, #w1#"};
		{ 24, 46994, "", "=q4=Talonstrike", "=ds=#w3#"};
		Prev = "TrialoftheCrusaderNorthrendBeasts25Man_A";
		Next = "TrialoftheCrusaderFactionChampions25Man_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderLordJaraxxus25Man_H"] = {
		{ 1, 47275, "", "=q4=Pride of the Demon Lord", "=ds=#s4#"};
		{ 2, 47274, "", "=q4=Pants of the Soothing Touch", "=ds=#s11#, #a1#"};
		{ 3, 47270, "", "=q4=Vest of Calamitous Fate", "=ds=#s5#, #a2#"};
		{ 4, 47277, "", "=q4=Bindings of the Autumn Willow", "=ds=#s8#, #a2#"};
		{ 5, 47280, "", "=q4=Wristwraps of Cloudy Omen", "=ds=#s8#, #a3#"};
		{ 6, 47268, "", "=q4=Bloodbath Girdle", "=ds=#s10#, #a4#"};
		{ 7, 47279, "", "=q4=Leggings of Failing Light", "=ds=#s11#, #a4#"};
		{ 8, 47273, "", "=q4=Legplates of Feverish Dedication", "=ds=#s11#, #a4#"};
		{ 9, 47269, "", "=q4=Dawnbreaker Sabatons", "=ds=#s12#, #a4#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47272, "", "=q4=Charge of the Eredar", "=ds=#s2#"};
		{ 19, 47278, "", "=q4=Circle of the Darkmender", "=ds=#s13#"};
		{ 20, 47271, "", "=q4=Solace of the Fallen", "=ds=#s14#"};
		{ 21, 47276, "", "=q4=Talisman of Heedless Sins", "=ds=#s15#"};
		{ 23, 47266, "", "=q4=Blood Fury", "=ds=#h1#, #w1#"};
		{ 24, 47267, "", "=q4=Death's Head Crossbow", "=ds=#w3#"};
		Prev = "TrialoftheCrusaderNorthrendBeasts25Man_H";
		Next = "TrialoftheCrusaderFactionChampions25Man_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderFactionChampions_A"] = {
		{ 1, 47721, "", "=q4=Sandals of the Silver Magus", "=ds=#s12#, #a1#"};
		{ 2, 47719, "", "=q4=Gloves of the Silver Assassin", "=ds=#s9#, #a2#"};
		{ 3, 47718, "", "=q4=Helm of the Silver Ranger", "=ds=#s1#, #a3#"};
		{ 4, 47717, "", "=q4=Faceplate of the Silver Champion", "=ds=#s1#, #a4#"};
		{ 5, 47720, "", "=q4=Pauldrons of the Silver Defender", "=ds=#s3#, #a4#"};
		{ 7, 47728, "", "=q4=Binding Light", "=ds=#s14#"};
		{ 8, 47727, "", "=q4=Fervor of the Frostborn", "=ds=#s14#"};
		{ 9, 47726, "", "=q4=Talisman of Volatile Power", "=ds=#s14#"};
		{ 10, 47725, "", "=q4=Victor's Call", "=ds=#s14#"};
		{ 16, 47724, "", "=q4=Blade of the Silver Disciple", "=ds=#h1#, #w4#"};
		Prev = "TrialoftheCrusaderLordJaraxxus_A";
		Next = "TrialoftheCrusaderTwinValkyrs_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderFactionChampions_H"] = {
		{ 1, 47873, "", "=q4=Sunreaver Magus' Sandals", "=ds=#s12#, #a1#"};
		{ 2, 47878, "", "=q4=Sunreaver Assassin's Gloves", "=ds=#s9#, #a2#"};
		{ 3, 47875, "", "=q4=Sunreaver Ranger's Helm", "=ds=#s1#, #a3#"};
		{ 4, 47876, "", "=q4=Sunreaver Champion's Faceplate", "=ds=#s1#, #a4#"};
		{ 5, 47877, "", "=q4=Sunreaver Defender's Pauldrons", "=ds=#s3#, #a4#"};
		{ 7, 47880, "", "=q4=Binding Stone", "=ds=#s14#"};
		{ 8, 47882, "", "=q4=Eitrigg's Oath", "=ds=#s14#"};
		{ 9, 47879, "", "=q4=Fetish of Volatile Power", "=ds=#s14#"};
		{ 10, 47881, "", "=q4=Vengeance of the Forsaken", "=ds=#s14#"};
		{ 16, 47874, "", "=q4=Sunreaver Disciple's Blade", "=ds=#h1#, #w4#"};
		Prev = "TrialoftheCrusaderLordJaraxxus_H";
		Next = "TrialoftheCrusaderTwinValkyrs_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderFactionChampions25Man_A"] = {
		{ 1, 47089, "", "=q4=Cloak of Displacement", "=ds=#s4#"};
		{ 2, 47081, "", "=q4=Cord of Biting Cold", "=ds=#s10#, #a1#"};
		{ 3, 47092, "", "=q4=Boots of the Mourning Widow", "=ds=#s12#, #a1#"};
		{ 4, 47094, "", "=q4=Vestments of the Shattered Fellowship", "=ds=#s5#, #a2#"};
		{ 5, 47071, "", "=q4=Treads of the Icewalker", "=ds=#s12#, #a2#"};
		{ 6, 47073, "", "=q4=Bracers of the Untold Massacre", "=ds=#s8#, #a3#"};
		{ 7, 47083, "", "=q4=Legguards of Concealed Hatred", "=ds=#s11#, #a3#"};
		{ 8, 47090, "", "=q4=Boots of Tremoring Earth", "=ds=#s12#, #a3#"};
		{ 9, 47082, "", "=q4=Chestplate of the Frostborn Hero", "=ds=#s5#, #a4#"};
		{ 10, 47093, "", "=q4=Vambraces of the Broken Bond", "=ds=#s8#, #a4#"};
		{ 11, 47072, "", "=q4=Girdle of Bloodied Scars", "=ds=#s10#, #a4#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47070, "", "=q4=Ring of Callous Aggression", "=ds=#s13#"};
		{ 19, 47080, "", "=q4=Satrina's Impeding Scarab", "=ds=#s14#"};
		{ 21, 47069, "", "=q4=Justicebringer", "=ds=#h2#, #w1#"};
		{ 22, 47079, "", "=q4=Bastion of Purity", "=ds=#w8#"};
		Prev = "TrialoftheCrusaderLordJaraxxus25Man_A";
		Next = "TrialoftheCrusaderTwinValkyrs25Man_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderFactionChampions25Man_H"] = {
		{ 1, 47291, "", "=q4=Shroud of Displacement", "=ds=#s4#"};
		{ 2, 47286, "", "=q4=Belt of Biting Cold", "=ds=#s10#, #a1#"};
		{ 3, 47293, "", "=q4=Sandals of the Mourning Widow", "=ds=#s12#, #a1#"};
		{ 4, 47292, "", "=q4=Robes of the Shattered Fellowship", "=ds=#s5#, #a2#"};
		{ 5, 47284, "", "=q4=Icewalker Treads", "=ds=#s12#, #a2#"};
		{ 6, 47281, "", "=q4=Bracers of the Silent Massacre", "=ds=#s8#, #a3#"};
		{ 7, 47289, "", "=q4=Leggings of Concealed Hatred", "=ds=#s11#, #a3#"};
		{ 8, 47295, "", "=q4=Sabatons of Tremoring Earth", "=ds=#s12#, #a3#"};
		{ 9, 47288, "", "=q4=Chestplate of the Frostwolf Hero", "=ds=#s5#, #a4#"};
		{ 10, 47294, "", "=q4=Bracers of the Broken Bond", "=ds=#s8#, #a4#"};
		{ 11, 47283, "", "=q4=Belt of Bloodied Scars", "=ds=#s10#, #a4#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47282, "", "=q4=Band of Callous Aggression", "=ds=#s13#"};
		{ 19, 47290, "", "=q4=Juggernaut's Vitality", "=ds=#s14#"};
		{ 21, 47285, "", "=q4=Dual-blade Butcher", "=ds=#h2#, #w1#"};
		{ 22, 47287, "", "=q4=Bastion of Resolve", "=ds=#w8#"};
		Prev = "TrialoftheCrusaderLordJaraxxus_H25Man";
		Next = "TrialoftheCrusaderTwinValkyrs_H25Man";
	};

	AtlasLoot_Data["TrialoftheCrusaderTwinValkyrs_A"] = {
		{ 1, 47745, "", "=q4=Gloves of Looming Shadow", "=ds=#s9#, #a1#"};
		{ 2, 49231, "", "=q4=Boots of the Grieving Soul", "=ds=#s12#, #a1#"};
		{ 3, 47746, "", "=q4=Helm of the Snowy Grotto", "=ds=#s1#, #a2#"};
		{ 4, 47739, "", "=q4=Armor of Shifting Shadows", "=ds=#s5#, #a2#"};
		{ 5, 47744, "", "=q4=Gloves of the Azure Prophet", "=ds=#s9#, #a3#"};
		{ 6, 47738, "", "=q4=Sabatons of the Lingering Vortex", "=ds=#s12#, #a4#"};
		{ 8, 47747, "", "=q4=Darkbane Pendant", "=ds=#s2#"};
		{ 9, 47700, "", "=q4=Loop of the Twin Val'kyr", "=ds=#s13#"};
		{ 10, 47742, "", "=q4=Chalice of Benedictus", "=ds=#s15#"};
		{ 16, 47736, "", "=q4=Icefall Blade", "=ds=#h1#, #w4#"};
		{ 17, 47737, "", "=q4=Reckoning", "=ds=#h2#, #w10#"};
		{ 18, 47743, "", "=q4=Enlightenment", "=ds=#w9#"};
		{ 19, 47740, "", "=q4=The Diplomat", "=ds=#w5#"};
		Prev = "TrialoftheCrusaderFactionChampions_A";
		Next = "TrialoftheCrusaderAnubarak_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderTwinValkyrs_H"] = {
		{ 1, 47889, "", "=q4=Looming Shadow Wraps", "=ds=#s9#, #a1#"};
		{ 2, 49232, "", "=q4=Sandals of the Grieving Soul", "=ds=#s12#, #a1#"};
		{ 3, 47891, "", "=q4=Helm of the High Mesa", "=ds=#s1#, #a2#"};
		{ 4, 47887, "", "=q4=Vest of Shifting Shadows", "=ds=#s5#, #a2#"};
		{ 5, 47893, "", "=q4=Sen'jin Ritualist Gloves", "=ds=#s9#, #a3#"};
		{ 6, 47885, "", "=q4=Greaves of the Lingering Vortex", "=ds=#s12#, #a4#"};
		{ 8, 47890, "", "=q4=Darkbane Amulet", "=ds=#s2#"};
		{ 9, 47888, "", "=q4=Band of the Twin Val'kyr", "=ds=#s13#"};
		{ 10, 47913, "", "=q4=Lightbane Focus", "=ds=#s15#"};
		{ 16, 47886, "", "=q4=Nemesis Blade", "=ds=#h1#, #w4#"};
		{ 17, 47884, "", "=q4=Edge of Agony", "=ds=#h2#, #w10#"};
		{ 18, 47892, "", "=q4=Illumination", "=ds=#w9#"};
		{ 19, 47883, "", "=q4=Widebarrel Flintlock", "=ds=#w5#"};
		Prev = "TrialoftheCrusaderFactionChampions_H";
		Next = "TrialoftheCrusaderAnubarak_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderTwinValkyrs25Man_A"] = {
		{ 1, 47126, "", "=q4=Skyweaver Robes", "=ds=#s5#, #a1#"};
		{ 2, 47141, "", "=q4=Bindings of Dark Essence", "=ds=#s8#, #a1#"};
		{ 3, 47107, "", "=q4=Belt of the Merciless Killer", "=ds=#s10#, #a2#"};
		{ 4, 47140, "", "=q4=Cord of Pale Thorns", "=ds=#s10#, #a2#"};
		{ 5, 47106, "", "=q4=Sabatons of Ruthless Judgment", "=ds=#s12#, #a3#"};
		{ 6, 47142, "", "=q4=Breastplate of the Frozen Lake", "=ds=#s5#, #a4#"};
		{ 7, 47108, "", "=q4=Bracers of the Shieldmaiden", "=ds=#s8#, #a4#"};
		{ 8, 47121, "", "=q4=Legguards of Ascension", "=ds=#s11#, #a4#"};
		{ 10, 47116, "", "=q4=The Arbiter's Muse", "=ds=#s2#"};
		{ 11, 47105, "", "=q4=The Executioner's Malice", "=ds=#s2#"};
		{ 12, 47139, "", "=q4=Wail of the Val'kyr", "=ds=#s2#"};
		{ 13, 47115, "", "=q4=Death's Verdict", "=ds=#s14#"};
		{ 14, 47138, "", "=q4=Chalice of Searing Light", "=ds=#s15#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47104, "", "=q4=Twin Spike", "=ds=#h1#, #w4#"};
		{ 19, 47114, "", "=q4=Lupine Longstaff", "=ds=#w9#"};
		Prev = "TrialoftheCrusaderFactionChampions25Man_A";
		Next = "TrialoftheCrusaderAnubarak25Man_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderTwinValkyrs25Man_H"] = {
		{ 1, 47301, "", "=q4=Skyweaver Vestments", "=ds=#s5#, #a1#"};
		{ 2, 47306, "", "=q4=Dark Essence Bindings", "=ds=#s8#, #a1#"};
		{ 3, 47308, "", "=q4=Belt of Pale Thorns", "=ds=#s10#, #a2#"};
		{ 4, 47299, "", "=q4=Belt of the Pitiless Killer", "=ds=#s10#, #a2#"};
		{ 5, 47296, "", "=q4=Greaves of Ruthless Judgment", "=ds=#s12#, #a3#"};
		{ 6, 47310, "", "=q4=Chestplate of the Frozen Lake", "=ds=#s5#, #a4#"};
		{ 7, 47298, "", "=q4=Armguards of the Shieldmaiden", "=ds=#s8#, #a4#"};
		{ 8, 47304, "", "=q4=Legplates of Ascension", "=ds=#s11#, #a4#"};
		{ 10, 47307, "", "=q4=Cry of the Val'kyr", "=ds=#s2#"};
		{ 11, 47305, "", "=q4=Legionnaire's Gorget", "=ds=#s2#"};
		{ 12, 47297, "", "=q4=The Executioner's Vice", "=ds=#s2#"};
		{ 13, 47303, "", "=q4=Death's Choice", "=ds=#s14#"};
		{ 14, 47309, "", "=q4=Mystifying Charm", "=ds=#s15#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47300, "", "=q4=Gouge of the Frigid Heart", "=ds=#h1#, #w4#"};
		{ 19, 47302, "", "=q4=Twin's Pact", "=ds=#w9#"};
		Prev = "TrialoftheCrusaderFactionChampions25Man_H";
		Next = "TrialoftheCrusaderAnubarak25Man_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderAnubarak_A"] = {
		{ 1, 47838, "", "=q4=Vestments of the Sleepless", "=ds=#s5#, #a1#"};
		{ 2, 47837, "", "=q4=Cinch of the Undying", "=ds=#s10#, #a1#" };
		{ 3, 47832, "", "=q4=Spaulders of the Snow Bandit", "=ds=#s3#, #a2#" };
		{ 4, 47813, "", "=q4=Helmet of the Crypt Lord", "=ds=#s1#, #a3#" };
		{ 5, 47829, "", "=q4=Pauldrons of the Timeless Hunter", "=ds=#s3#, #a3#" };
		{ 6, 47811, "", "=q4=Chestguard of the Warden", "=ds=#s5#, #a4#" };
		{ 7, 47836, "", "=q4=Legplates of the Immortal Spider", "=ds=#s11#, #a4#" };
		{ 8, 47830, "", "=q4=Legplates of the Silver Hand", "=ds=#s11#, #a4#" };
		{ 10, 47810, "", "=q4=Crusader's Glory", "=ds=#h1#, #w10#" };
		{ 11, 47814, "", "=q4=Westfall Saber", "=ds=#h1#, #w10#" };
		{ 12, 47808, "", "=q4=The Lion's Maw", "=ds=#h1#, #w1#" };
		{ 13, 47809, "", "=q4=Argent Resolve", "=ds=#h3#, #w6#" };
		{ 14, 47816, "", "=q4=The Grinder", "=ds=#h1#, #w6#" };
		{ 16, 47834, "", "=q4=Fordragon Blades", "=ds=#w7#" };
		{ 17, 47815, "", "=q4=Cold Convergence", "=ds=#w9#" };
		{ 18, 47835, "", "=q4=Bulwark of the Royal Guard", "=ds=#w8#" };
		{ 19, 47812, "", "=q4=Vigilant Ward", "=ds=#w8#" };
		{ 20, 47741, "", "=q4=Baelgun's Heavy Crossbow", "=ds=#w3#" };
		Prev = "TrialoftheCrusaderTwinValkyrs_A";
		Next = "TrialoftheCrusaderTributeHEROIC_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderAnubarak_H"] = {
		{ 1, 47906, "", "=q4=Robes of the Sleepless", "=ds=#s5#, #a1#"};
		{ 2, 47909, "", "=q4=Belt of the Eternal", "=ds=#s10#, #a1#" };
		{ 3, 47904, "", "=q4=Shoulderpads of the Snow Bandit", "=ds=#s3#, #a2#" };
		{ 4, 47897, "", "=q4=Helm of the Crypt Lord", "=ds=#s1#, #a3#" };
		{ 5, 47901, "", "=q4=Pauldrons of the Shadow Hunter", "=ds=#s3#, #a3#" };
		{ 6, 47896, "", "=q4=Stoneskin Chestplate", "=ds=#s5#, #a4#" };
		{ 7, 47902, "", "=q4=Legplates of Redeemed Blood", "=ds=#s11#, #a4#" };
		{ 8, 47908, "", "=q4=Sunwalker Legguards", "=ds=#s11#, #a4#" };
		{ 10, 47899, "", "=q4=Ardent Guard", "=ds=#h1#, #w10#" };
		{ 11, 47903, "", "=q4=Forsaken Bonecarver", "=ds=#h1#, #w10#" };
		{ 12, 47898, "", "=q4=Frostblade Hatchet", "=ds=#h1#, #w1#" };
		{ 13, 47894, "", "=q4=Mace of the Earthborn Chieftain", "=ds=#h3#, #w6#" };
		{ 14, 47905, "", "=q4=Blackhorn Bludgeon", "=ds=#h1#, #w6#" };
		{ 16, 47911, "", "=q4=Anguish", "=ds=#w7#" };
		{ 17, 47900, "", "=q4=Perdition", "=ds=#w9#" };
		{ 18, 47910, "", "=q4=Aegis of the Coliseum", "=ds=#w8#" };
		{ 19, 47895, "", "=q4=Pride of the Kor'kron", "=ds=#w8#" };
		{ 20, 47907, "", "=q4=Darkmaw Crossbow", "=ds=#w3#" };
		Prev = "TrialoftheCrusaderTwinValkyrs_H";
		Next = "TrialoftheCrusaderTributeHEROIC_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderAnubarak25Man_A"] = {
		{ 1, 47225, "", "=q4=Maiden's Favor", "=ds=#s4#"};
		{ 2, 47183, "", "=q4=Strength of the Nerub", "=ds=#s4#"};
		{ 3, 47203, "", "=q4=Armbands of the Ashen Saint", "=ds=#s8#, #a1#"};
		{ 4, 47235, "", "=q4=Gloves of the Lifeless Touch", "=ds=#s9#, #a1#"};
		{ 5, 47187, "", "=q4=Leggings of the Deepening Void", "=ds=#s11#, #a1#"};
		{ 6, 47194, "", "=q4=Footpads of the Icy Floe", "=ds=#s12#, #a1#"};
		{ 7, 47151, "", "=q4=Bracers of Dark Determination", "=ds=#s8#, #a2#"};
		{ 8, 47186, "", "=q4=Legwraps of the Awakening", "=ds=#s11#, #a2#"};
		{ 9, 47204, "", "=q4=Chestguard of Flowing Elements", "=ds=#s5#, #a3#"};
		{ 10, 47152, "", "=q4=Belt of Deathly Dominion", "=ds=#s10#, #a3#"};
		{ 11, 47184, "", "=q4=Legguards of the Lurking Threat", "=ds=#s11#, #a3#"};
		{ 12, 47234, "", "=q4=Gloves of Bitter Reprisal", "=ds=#s9#, #a4#"};
		{ 13, 47195, "", "=q4=Belt of the Forgotten Martyr", "=ds=#s10#, #a4#"};
		{ 14, 47150, "", "=q4=Greaves of the 7th Legion", "=ds=#s12#, #a4#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47054, "", "=q4=Band of Deplorable Violence", "=ds=#s13#"};
		{ 19, 47149, "", "=q4=Signet of the Traitor King", "=ds=#s13#"};
		{ 20, 47182, "", "=q4=Reign of the Unliving", "=ds=#s14#"};
		{ 22, 47148, "", "=q4=Stormpike Cleaver", "=ds=#h1#, #w1#"};
		{ 23, 47193, "", "=q4=Misery's End", "=ds=#h3#, #w6#"};
		{ 24, 47233, "", "=q4=Archon Glaive", "=ds=#w7#"};
		Prev = "TrialoftheCrusaderTwinValkyrs25Man_A";
		Next = "TrialoftheCrusaderTribute25ManHEROIC_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderAnubarak25Man_H"] = {
		{ 1, 47328, "", "=q4=Maiden's Adoration", "=ds=#s4#"};
		{ 2, 47320, "", "=q4=Might of the Nerub", "=ds=#s4#"};
		{ 3, 47324, "", "=q4=Bindings of the Ashen Saint", "=ds=#s8#, #a1#"};
		{ 4, 47326, "", "=q4=Handwraps of the Lifeless Touch", "=ds=#s9#, #a1#"};
		{ 5, 47317, "", "=q4=Breeches of the Deepening Void", "=ds=#s11#, #a1#"};
		{ 6, 47321, "", "=q4=Boots of the Icy Floe", "=ds=#s12#, #a1#"};
		{ 7, 47313, "", "=q4=Armbands of Dark Determination", "=ds=#s8#, #a2#"};
		{ 8, 47318, "", "=q4=Leggings of the Awakening", "=ds=#s11#, #a2#"};
		{ 9, 47325, "", "=q4=Cuirass of Flowing Elements", "=ds=#s5#, #a3#"};
		{ 10, 47311, "", "=q4=Waistguard of Deathly Dominion", "=ds=#s10#, #a3#"};
		{ 11, 47319, "", "=q4=Leggings of the Lurking Threat", "=ds=#s11#, #a3#"};
		{ 12, 47330, "", "=q4=Gauntlets of Bitter Reprisal", "=ds=#s9#, #a4#"};
		{ 13, 47323, "", "=q4=Girdle of the Forgotten Martyr", "=ds=#s10#, #a4#"};
		{ 14, 47312, "", "=q4=Greaves of the Saronite Citadel", "=ds=#s12#, #a4#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47315, "", "=q4=Band of the Traitor King", "=ds=#s13#"};
		{ 19, 47327, "", "=q4=Lurid Manifestation", "=ds=#s13#"};
		{ 20, 47316, "", "=q4=Reign of the Dead", "=ds=#s14#"};
		{ 22, 47314, "", "=q4=Hellscream Slicer", "=ds=#h1#, #w1#"};
		{ 23, 47322, "", "=q4=Suffering's End", "=ds=#h3#, #w6#"};
		{ 24, 47329, "", "=q4=Hellion Glaive", "=ds=#w7#"};
		Prev = "TrialoftheCrusaderTwinValkyrs25Man_H";
		Next = "TrialoftheCrusaderTribute25ManHEROIC_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderPatterns_A"] = {
		{ 1, 47622, "", "=q4=Plans: Breastplate of the White Knight", "=ds=#p2# (450)"};
		{ 2, 47623, "", "=q4=Plans: Saronite Swordbreakers", "=ds=#p2# (450)"};
		{ 3, 47627, "", "=q4=Plans: Sunforged Bracers", "=ds=#p2# (450)"};
		{ 4, 47626, "", "=q4=Plans: Sunforged Breastplate", "=ds=#p2# (450)"};
		{ 5, 47624, "", "=q4=Plans: Titanium Razorplate", "=ds=#p2# (450)"};
		{ 6, 47625, "", "=q4=Plans: Titanium Spikeguards", "=ds=#p2# (450)"};
		{ 7, 47629, "", "=q4=Pattern: Black Chitin Bracers", "=ds=#p7# (450)"};
		{ 8, 47635, "", "=q4=Pattern: Bracers of Swift Death", "=ds=#p7# (450)"};
		{ 9, 47631, "", "=q4=Pattern: Crusader's Dragonscale Bracers", "=ds=#p7# (450)"};
		{ 10, 47630, "", "=q4=Pattern: Crusader's Dragonscale Breastplate", "=ds=#p7# (450)"};
		{ 11, 47628, "", "=q4=Pattern: Ensorcelled Nerubian Breastplate", "=ds=#p7# (450)"};
		{ 12, 47634, "", "=q4=Pattern: Knightbane Carapace", "=ds=#p7# (450)"};
		{ 13, 47632, "", "=q4=Pattern: Lunar Eclipse Chestguard", "=ds=#p7# (450)"};
		{ 14, 47633, "", "=q4=Pattern: Moonshadow Armguards", "=ds=#p7# (450)"};
		{ 16, 47654, "", "=q4=Pattern: Bejeweled Wizard's Bracers", "=ds=#p8# (450)"};
		{ 17, 47655, "", "=q4=Pattern: Merlin's Robe", "=ds=#p8# (450)"};
		{ 18, 47656, "", "=q4=Pattern: Royal Moonshroud Bracers", "=ds=#p8# (450)"};
		{ 19, 47657, "", "=q4=Pattern: Royal Moonshroud Robe", "=ds=#p8# (450)"};
		{ 30, 47556, "", "=q3=Crusader Orb", "=ds=#e8#"};
		Prev = "TrialoftheCrusaderTributeHEROIC_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderPatterns_H"] = {
		{ 1, 47640, "", "=q4=Plans: Breastplate of the White Knight", "=ds=#p2# (450)"};
		{ 2, 47641, "", "=q4=Plans: Saronite Swordbreakers", "=ds=#p2# (450)"};
		{ 3, 47642, "", "=q4=Plans: Sunforged Bracers", "=ds=#p2# (450)"};
		{ 4, 47643, "", "=q4=Plans: Sunforged Breastplate", "=ds=#p2# (450)"};
		{ 5, 47644, "", "=q4=Plans: Titanium Razorplate", "=ds=#p2# (450)"};
		{ 6, 47645, "", "=q4=Plans: Titanium Spikeguards", "=ds=#p2# (450)"};
		{ 7, 47646, "", "=q4=Pattern: Black Chitin Bracers", "=ds=#p7# (450)"};
		{ 8, 47647, "", "=q4=Pattern: Bracers of Swift Death", "=ds=#p7# (450)"};
		{ 9, 47648, "", "=q4=Pattern: Crusader's Dragonscale Bracers", "=ds=#p7# (450)"};
		{ 10, 47649, "", "=q4=Pattern: Crusader's Dragonscale Breastplate", "=ds=#p7# (450)"};
		{ 11, 47650, "", "=q4=Pattern: Ensorcelled Nerubian Breastplate", "=ds=#p7# (450)"};
		{ 12, 47651, "", "=q4=Pattern: Knightbane Carapace", "=ds=#p7# (450)"};
		{ 13, 47652, "", "=q4=Pattern: Lunar Eclipse Chestguard", "=ds=#p7# (450)"};
		{ 14, 47653, "", "=q4=Pattern: Moonshadow Armguards", "=ds=#p7# (450)"};
		{ 16, 47639, "", "=q4=Pattern: Bejeweled Wizard's Bracers", "=ds=#p8# (450)"};
		{ 17, 47638, "", "=q4=Pattern: Merlin's Robe", "=ds=#p8# (450)"};
		{ 18, 47637, "", "=q4=Pattern: Royal Moonshroud Bracers", "=ds=#p8# (450)"};
		{ 19, 47636, "", "=q4=Pattern: Royal Moonshroud Robe", "=ds=#p8# (450)"};
		{ 30, 47556, "", "=q3=Crusader Orb", "=ds=#e8#"};
		Prev = "TrialoftheCrusaderTributeHEROIC_H";
	};

		-----------------------------------
		--- Trial of the Grand Crusader ---
		-----------------------------------

	AtlasLoot_Data["TrialoftheCrusaderNorthrendBeastsHEROIC_A"] = {
		{ 1, 47921, "", "=q4=Icehowl Cinch", "=ds=#s10#, #a1#"};
		{ 2, 47923, "", "=q4=Shoulderpads of the Glacial Wilds", "=ds=#s3#, #a2#"};
		{ 3, 47919, "", "=q4=Acidmaw Boots", "=ds=#s12#, #a2#"};
		{ 4, 47926, "", "=q4=Shoulderguards of the Spirit Walker", "=ds=#s3#, #a3#"};
		{ 5, 47916, "", "=q4=Armbands of the Northern Stalker", "=ds=#s8#, #a3#"};
		{ 6, 47918, "", "=q4=Dreadscale Armguards", "=ds=#s8#, #a4#"};
		{ 7, 47917, "", "=q4=Gauntlets of Rising Anger", "=ds=#s9#, #a4#"};
		{ 8, 47924, "", "=q4=Belt of the Frozen Reach", "=ds=#s10#, #a4#"};
		{ 9, 47925, "", "=q4=Girdle of the Impaler", "=ds=#s10#, #a4#"};
		{ 16, 47915, "", "=q4=Collar of Ceaseless Torment", "=ds=#s2#"};
		{ 17, 47920, "", "=q4=Gormok's Band", "=ds=#s13#"};
		{ 19, 47922, "", "=q4=Rod of Imprisoned Souls", "=ds=#w12#"};
		Next = "TrialoftheCrusaderLordJaraxxusHEROIC_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderNorthrendBeastsHEROIC_H"] = {
		{ 1, 47994, "", "=q4=Icehowl Binding", "=ds=#s10#, #a1#"};
		{ 2, 47996, "", "=q4=Pauldrons of the Glacial Wilds", "=ds=#s3#, #a2#"};
		{ 3, 47992, "", "=q4=Acidmaw Treads", "=ds=#s12#, #a2#"};
		{ 4, 47999, "", "=q4=Pauldrons of the Spirit Walker", "=ds=#s3#, #a3#"};
		{ 5, 47989, "", "=q4=Bracers of the Northern Stalker", "=ds=#s8#, #a3#"};
		{ 6, 47991, "", "=q4=Dreadscale Bracers", "=ds=#s8#, #a4#"};
		{ 7, 47990, "", "=q4=Gauntlets of Mounting Anger", "=ds=#s9#, #a4#"};
		{ 8, 47998, "", "=q4=Belt of the Impaler", "=ds=#s10#, #a4#"};
		{ 9, 47997, "", "=q4=Girdle of the Frozen Reach", "=ds=#s10#, #a4#"};
		{ 16, 47988, "", "=q4=Collar of Unending Torment", "=ds=#s2#"};
		{ 17, 47993, "", "=q4=Carnivorous Band", "=ds=#s13#"};
		{ 19, 47995, "", "=q4=Scepter of Imprisoned Souls", "=ds=#w12#"};
		Next = "TrialoftheCrusaderLordJaraxxusHEROIC_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderNorthrendBeasts25ManHEROIC_A"] = {
		{ 1, 46971, "", "=q4=Drape of the Untamed Predator", "=ds=#s4#"};
		{ 2, 46977, "", "=q4=Shawl of the Refreshing Winds", "=ds=#s4#"};
		{ 3, 46993, "", "=q4=Flowing Vestments of Ascent", "=ds=#s5#, #a1#"};
		{ 4, 46973, "", "=q4=Cord of the Tenebrous Mist", "=ds=#s10#, #a1#"};
		{ 5, 46975, "", "=q4=Leggings of the Broken Beast", "=ds=#s11#, #a2#"};
		{ 6, 46989, "", "=q4=Boots of the Unrelenting Storm", "=ds=#s12#, #a2#"};
		{ 7, 46965, "", "=q4=Breastplate of Cruel Intent", "=ds=#s5#, #a3#"};
		{ 8, 46991, "", "=q4=Belt of the Ice Burrower", "=ds=#s10#, #a3#"};
		{ 9, 46968, "", "=q4=Chestplate of the Towering Monstrosity", "=ds=#s5#, #a4#"};
		{ 10, 46967, "", "=q4=Boneshatter Armplates", "=ds=#s8#, #a4#"};
		{ 11, 46986, "", "=q4=Boots of the Courageous", "=ds=#s12#, #a4#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 46966, "", "=q4=Band of the Violent Temperment", "=ds=#s13#"};
		{ 20, 46980, "", "=q4=Blade of Tarasque", "=ds=#h3#, #w4#"};
		{ 21, 46969, "", "=q4=Steel Bladebreaker", "=ds=#h1#, #w4#"};
		{ 22, 46964, "", "=q4=Crystal Plated Vanguard", "=ds=#w8#"};
		Next = "TrialoftheCrusaderLordJaraxxus25ManHEROIC_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderNorthrendBeasts25ManHEROIC_H"] = {
		{ 1, 47418, "", "=q4=Cloak of the Untamed Predator", "=ds=#s4#"};
		{ 2, 47417, "", "=q4=Drape of the Refreshing Winds", "=ds=#s4#"};
		{ 3, 47425, "", "=q4=Flowing Robes of Ascent", "=ds=#s5#, #a1#"};
		{ 4, 47419, "", "=q4=Belt of the Tenebrous Mist", "=ds=#s10#, #a1#"};
		{ 5, 47420, "", "=q4=Legwraps of the Broken Beast", "=ds=#s11#, #a2#"};
		{ 6, 47423, "", "=q4=Boots of the Harsh Winter", "=ds=#s12#, #a2#"};
		{ 7, 47412, "", "=q4=Cuirass of Cruel Intent", "=ds=#s5#, #a3#"};
		{ 8, 47426, "", "=q4=Binding of the Ice Burrower", "=ds=#s10#, #a3#"};
		{ 9, 47415, "", "=q4=Hauberk of the Towering Monstrosity", "=ds=#s5#, #a4#"};
		{ 10, 47414, "", "=q4=Boneshatter Vambraces", "=ds=#s8#, #a4#"};
		{ 11, 47424, "", "=q4=Sabatons of the Courageous", "=ds=#s12#, #a4#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47413, "", "=q4=Ring of the Violent Temperament", "=ds=#s13#"};
		{ 20, 47422, "", "=q4=Barb of Tarasque", "=ds=#h3#, #w4#"};
		{ 21, 47416, "", "=q4=Stygian Bladebreaker", "=ds=#h1#, #w4#"};
		{ 22, 47421, "", "=q4=Forlorn Barrier", "=ds=#w8#"};
		Next = "TrialoftheCrusaderLordJaraxxus25ManHEROIC_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderLordJaraxxusHEROIC_A"] = {
		{ 1, 47927, "", "=q4=Felspark Bindings", "=ds=#s8#, #a1#"};
		{ 2, 47931, "", "=q4=Leggings of the Demonic Messenger", "=ds=#s11#, #a1#"};
		{ 3, 47929, "", "=q4=Belt of the Winter Solstice", "=ds=#s10#, #a2#"};
		{ 4, 47932, "", "=q4=Girdle of the Farseer", "=ds=#s10#, #a3#"};
		{ 5, 49238, "", "=q4=Boots of Tortured Space", "=ds=#s12#, #a3#"};
		{ 6, 47933, "", "=q4=Sentinel Scouting Greaves", "=ds=#s12#, #a3#"};
		{ 7, 47935, "", "=q4=Armguards of the Nether Lord", "=ds=#s8#, #a4#"};
		{ 8, 47937, "", "=q4=Girdle of the Nether Champion", "=ds=#s10#, #a4#"};
		{ 16, 47930, "", "=q4=Amulet of Binding Elements", "=ds=#s2#"};
		{ 17, 47939, "", "=q4=Endurance of the Infernal", "=ds=#s2#"};
		{ 18, 47928, "", "=q4=Firestorm Ring", "=ds=#s13#"};
		{ 19, 47934, "", "=q4=Planestalker Signet", "=ds=#s13#"};
		{ 21, 47938, "", "=q4=Dirk of the Night Watch", "=ds=#h1#, #w4#"};
		Prev = "TrialoftheCrusaderNorthrendBeastsHEROIC_A";
		Next = "TrialoftheCrusaderFactionChampionsHEROIC_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderLordJaraxxusHEROIC_H"] = {
		{ 1, 48000, "", "=q4=Felspark Bracers", "=ds=#s8#, #a1#"};
		{ 2, 48004, "", "=q4=Legwraps of the Demonic Messenger", "=ds=#s11#, #a1#"};
		{ 3, 48002, "", "=q4=Belt of the Bloodhoof Emissary", "=ds=#s10#, #a2#"};
		{ 4, 48005, "", "=q4=Darkspear Ritual Binding", "=ds=#s10#, #a3#"};
		{ 5, 49237, "", "=q4=Sabatons of Tortured Space", "=ds=#s12#, #a3#"};
		{ 6, 48006, "", "=q4=Warsong Poacher's Greaves", "=ds=#s12#, #a3#"};
		{ 7, 48008, "", "=q4=Armplates of the Nether Lord", "=ds=#s8#, #a4#"};
		{ 8, 48009, "", "=q4=Belt of the Nether Champion", "=ds=#s10#, #a4#"};
		{ 16, 48011, "", "=q4=Fortitude of the Infernal", "=ds=#s2#"};
		{ 17, 48003, "", "=q4=Pendant of Binding Elements", "=ds=#s2#"};
		{ 18, 48001, "", "=q4=Firestorm Band", "=ds=#s13#"};
		{ 19, 48007, "", "=q4=Planestalker Band", "=ds=#s13#"};
		{ 21, 48010, "", "=q4=Orcish Deathblade", "=ds=#h1#, #w4#"};
		Prev = "TrialoftheCrusaderNorthrendBeastsHEROIC_H";
		Next = "TrialoftheCrusaderFactionChampionsHEROIC_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderLordJaraxxus25ManHEROIC_A"] = {
		{ 1, 47063, "", "=q4=Pride of the Eredar", "=ds=#s4#"};
		{ 2, 47062, "", "=q4=Leggings of the Soothing Touch", "=ds=#s11#, #a1#"};
		{ 3, 47004, "", "=q4=Cuirass of Calamitous Fate", "=ds=#s5#, #a2#"};
		{ 4, 47066, "", "=q4=Bracers of the Autumn Willow", "=ds=#s8#, #a2#"};
		{ 5, 47068, "", "=q4=Bracers of Cloudy Omen", "=ds=#s8#, #a3#"};
		{ 6, 47002, "", "=q4=Bloodbath Belt", "=ds=#s10#, #a4#"};
		{ 7, 47067, "", "=q4=Legplates of Failing Light", "=ds=#s11#, #a4#"};
		{ 8, 47061, "", "=q4=Legguards of Feverish Dedication", "=ds=#s11#, #a4#"};
		{ 9, 47003, "", "=q4=Dawnbreaker Greaves", "=ds=#s12#, #a4#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47060, "", "=q4=Charge of the Demon Lord", "=ds=#s2#"};
		{ 19, 47224, "", "=q4=Ring of the Darkmender", "=ds=#s13#"};
		{ 20, 47059, "", "=q4=Solace of the Defeated", "=ds=#s14#"};
		{ 21, 47064, "", "=q4=Symbol of Transgression", "=ds=#s15#"};
		{ 23, 47001, "", "=q4=Lionhead Slasher", "=ds=#h1#, #w1#"};
		{ 24, 46995, "", "=q4=Talonstrike", "=ds=#w3#"};
		Prev = "TrialoftheCrusaderNorthrendBeasts25ManHEROIC_A";
		Next = "TrialoftheCrusaderFactionChampions25ManHEROIC_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderLordJaraxxus25ManHEROIC_H"] = {
		{ 1, 47436, "", "=q4=Pride of the Demon Lord", "=ds=#s4#"};
		{ 2, 47435, "", "=q4=Pants of the Soothing Touch", "=ds=#s11#, #a1#"};
		{ 3, 47431, "", "=q4=Vest of Calamitous Fate", "=ds=#s5#, #a2#"};
		{ 4, 47438, "", "=q4=Bindings of the Autumn Willow", "=ds=#s8#, #a2#"};
		{ 5, 47441, "", "=q4=Wristwraps of Cloudy Omen", "=ds=#s8#, #a3#"};
		{ 6, 47429, "", "=q4=Bloodbath Girdle", "=ds=#s10#, #a4#"};
		{ 7, 47440, "", "=q4=Leggings of Failing Light", "=ds=#s11#, #a4#"};
		{ 8, 47434, "", "=q4=Legplates of Feverish Dedication", "=ds=#s11#, #a4#"};
		{ 9, 47430, "", "=q4=Dawnbreaker Sabatons", "=ds=#s12#, #a4#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47433, "", "=q4=Charge of the Eredar", "=ds=#s2#"};
		{ 19, 47439, "", "=q4=Circle of the Darkmender", "=ds=#s13#"};
		{ 20, 47432, "", "=q4=Solace of the Fallen", "=ds=#s14#"};
		{ 21, 47437, "", "=q4=Talisman of Heedless Sins", "=ds=#s15#"};
		{ 23, 47427, "", "=q4=Blood Fury", "=ds=#h1#, #w1#"};
		{ 24, 47428, "", "=q4=Death's Head Crossbow", "=ds=#w3#"};
		Prev = "TrialoftheCrusaderNorthrendBeasts25ManHEROIC_H";
		Next = "TrialoftheCrusaderFactionChampions25ManHEROIC_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderFactionChampionsHEROIC_A"] = {
		{ 1, 47940, "", "=q4=Sandals of the Silver Magus", "=ds=#s12#, #a1#"};
		{ 2, 47945, "", "=q4=Gloves of the Silver Assassin", "=ds=#s9#, #a2#"};
		{ 3, 47942, "", "=q4=Helm of the Silver Ranger", "=ds=#s1#, #a3#"};
		{ 4, 47943, "", "=q4=Faceplate of the Silver Champion", "=ds=#s1#, #a4#"};
		{ 5, 47944, "", "=q4=Pauldrons of the Silver Defender", "=ds=#s3#, #a4#"};
		{ 7, 47947, "", "=q4=Binding Light", "=ds=#s14#"};
		{ 8, 47949, "", "=q4=Fervor of the Frostborn", "=ds=#s14#"};
		{ 9, 47946, "", "=q4=Talisman of Volatile Power", "=ds=#s14#"};
		{ 10, 47948, "", "=q4=Victor's Call", "=ds=#s14#"};
		{ 16, 47941, "", "=q4=Blade of the Silver Disciple", "=ds=#h1#, #w4#"};
		Prev = "TrialoftheCrusaderLordJaraxxusHEROIC_A";
		Next = "TrialoftheCrusaderTwinValkyrsHEROIC_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderFactionChampionsHEROIC_H"] = {
		{ 1, 48012, "", "=q4=Sunreaver Magus' Sandals", "=ds=#s12#, #a1#"};
		{ 2, 48017, "", "=q4=Sunreaver Assassin's Gloves", "=ds=#s9#, #a2#"};
		{ 3, 48014, "", "=q4=Sunreaver Ranger's Helm", "=ds=#s1#, #a3#"};
		{ 4, 48015, "", "=q4=Sunreaver Champion's Faceplate", "=ds=#s1#, #a4#"};
		{ 5, 48016, "", "=q4=Sunreaver Defender's Pauldrons", "=ds=#s3#, #a4#"};
		{ 7, 48019, "", "=q4=Binding Stone", "=ds=#s14#"};
		{ 8, 48021, "", "=q4=Eitrigg's Oath", "=ds=#s14#"};
		{ 9, 48018, "", "=q4=Fetish of Volatile Power", "=ds=#s14#"};
		{ 10, 48020, "", "=q4=Vengeance of the Forsaken", "=ds=#s14#"};
		{ 16, 48013, "", "=q4=Sunreaver Disciple's Blade", "=ds=#h1#, #w4#"};
		Prev = "TrialoftheCrusaderLordJaraxxusHEROIC_H";
		Next = "TrialoftheCrusaderTwinValkyrsHEROIC_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderFactionChampions25ManHEROIC_A"] = {
		{ 1, 47095, "", "=q4=Cloak of Displacement", "=ds=#s4#"};
		{ 2, 47084, "", "=q4=Cord of Biting Cold", "=ds=#s10#, #a1#"};
		{ 3, 47097, "", "=q4=Boots of the Mourning Widow", "=ds=#s12#, #a1#"};
		{ 4, 47096, "", "=q4=Vestments of the Shattered Fellowship", "=ds=#s5#, #a2#"};
		{ 5, 47077, "", "=q4=Treads of the Icewalker", "=ds=#s12#, #a2#"};
		{ 6, 47074, "", "=q4=Bracers of the Untold Massacre", "=ds=#s8#, #a3#"};
		{ 7, 47087, "", "=q4=Legguards of Concealed Hatred", "=ds=#s11#, #a3#"};
		{ 8, 47099, "", "=q4=Boots of Tremoring Earth", "=ds=#s12#, #a3#"};
		{ 9, 47086, "", "=q4=Chestplate of the Frostborn Hero", "=ds=#s5#, #a4#"};
		{ 10, 47098, "", "=q4=Vambraces of the Broken Bond", "=ds=#s8#, #a4#"};
		{ 11, 47076, "", "=q4=Girdle of Bloodied Scars", "=ds=#s10#, #a4#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47075, "", "=q4=Ring of Callous Aggression", "=ds=#s13#"};
		{ 19, 47088, "", "=q4=Satrina's Impeding Scarab", "=ds=#s14#"};
		{ 21, 47078, "", "=q4=Justicebringer", "=ds=#h2#, #w1#"};
		{ 22, 47085, "", "=q4=Bastion of Purity", "=ds=#w8#"};
		Prev = "TrialoftheCrusaderLordJaraxxus25ManHEROIC_A";
		Next = "TrialoftheCrusaderTwinValkyrs25ManHEROIC_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderFactionChampions25ManHEROIC_H"] = {
		{ 1, 47452, "", "=q4=Shroud of Displacement", "=ds=#s4#"};
		{ 2, 47447, "", "=q4=Belt of Biting Cold", "=ds=#s10#, #a1#"};
		{ 3, 47454, "", "=q4=Sandals of the Mourning Widow", "=ds=#s12#, #a1#"};
		{ 4, 47453, "", "=q4=Robes of the Shattered Fellowship", "=ds=#s5#, #a2#"};
		{ 5, 47445, "", "=q4=Icewalker Treads", "=ds=#s12#, #a2#"};
		{ 6, 47442, "", "=q4=Bracers of the Silent Massacre", "=ds=#s8#, #a3#"};
		{ 7, 47450, "", "=q4=Leggings of Concealed Hatred", "=ds=#s11#, #a3#"};
		{ 8, 47456, "", "=q4=Sabatons of Tremoring Earth", "=ds=#s12#, #a3#"};
		{ 9, 47449, "", "=q4=Chestplate of the Frostwolf Hero", "=ds=#s5#, #a4#"};
		{ 10, 47455, "", "=q4=Bracers of the Broken Bond", "=ds=#s8#, #a4#"};
		{ 11, 47444, "", "=q4=Belt of Bloodied Scars", "=ds=#s10#, #a4#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47443, "", "=q4=Band of Callous Aggression", "=ds=#s13#"};
		{ 19, 47451, "", "=q4=Juggernaut's Vitality", "=ds=#s14#"};
		{ 21, 47446, "", "=q4=Dual-blade Butcher", "=ds=#h2#, #w1#"};
		{ 22, 47448, "", "=q4=Bastion of Resolve", "=ds=#w8#"};
		Prev = "TrialoftheCrusaderLordJaraxxus25ManHEROIC_H";
		Next = "TrialoftheCrusaderTwinValkyrs25ManHEROIC_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderTwinValkyrsHEROIC_A"] = {
		{ 1, 47956, "", "=q4=Gloves of Looming Shadow", "=ds=#s9#, #a1#"};
		{ 2, 49234, "", "=q4=Boots of the Grieving Soul", "=ds=#s12#, #a1#"};
		{ 3, 47959, "", "=q4=Helm of the Snowy Grotto", "=ds=#s1#, #a2#"};
		{ 4, 47954, "", "=q4=Armor of Shifting Shadows", "=ds=#s5#, #a2#"};
		{ 5, 47961, "", "=q4=Gloves of the Azure Prophet", "=ds=#s9#, #a3#"};
		{ 6, 47952, "", "=q4=Sabatons of the Lingering Vortex", "=ds=#s12#, #a4#"};
		{ 8, 47957, "", "=q4=Darkbane Pendant", "=ds=#s2#"};
		{ 9, 47955, "", "=q4=Loop of the Twin Val'kyr", "=ds=#s13#"};
		{ 10, 47958, "", "=q4=Chalice of Benedictus", "=ds=#s15#"};
		{ 16, 47953, "", "=q4=Icefall Blade", "=ds=#h1#, #w4#"};
		{ 17, 47951, "", "=q4=Reckoning", "=ds=#h2#, #w10#"};
		{ 18, 47960, "", "=q4=Enlightenment", "=ds=#w9#"};
		{ 19, 47950, "", "=q4=The Diplomat", "=ds=#w5#"};
		Prev = "TrialoftheCrusaderFactionChampionsHEROIC_A";
		Next = "TrialoftheCrusaderAnubarakHEROIC_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderTwinValkyrsHEROIC_H"] = {
		{ 1, 48028, "", "=q4=Looming Shadow Wraps", "=ds=#s9#, #a1#"};
		{ 2, 49233, "", "=q4=Sandals of the Grieving Soul", "=ds=#s12#, #a1#"};
		{ 3, 48034, "", "=q4=Helm of the High Mesa", "=ds=#s1#, #a2#"};
		{ 4, 48026, "", "=q4=Vest of Shifting Shadows", "=ds=#s5#, #a2#"};
		{ 5, 48038, "", "=q4=Sen'jin Ritualist Gloves", "=ds=#s9#, #a3#"};
		{ 6, 48024, "", "=q4=Greaves of the Lingering Vortex", "=ds=#s12#, #a4#"};
		{ 8, 48030, "", "=q4=Darkbane Amulet", "=ds=#s2#"};
		{ 9, 48027, "", "=q4=Band of the Twin Val'kyr", "=ds=#s13#"};
		{ 10, 48032, "", "=q4=Lightbane Focus", "=ds=#s15#"};
		{ 16, 48025, "", "=q4=Nemesis Blade", "=ds=#h1#, #w4#"};
		{ 17, 48023, "", "=q4=Edge of Agony", "=ds=#h2#, #w10#"};
		{ 18, 48036, "", "=q4=Illumination", "=ds=#w9#"};
		{ 19, 48022, "", "=q4=Widebarrel Flintlock", "=ds=#w5#"};
		Prev = "TrialoftheCrusaderFactionChampionsHEROIC_H";
		Next = "TrialoftheCrusaderAnubarakHEROIC_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderTwinValkyrs25ManHEROIC_A"] = {
		{ 1, 47129, "", "=q4=Skyweaver Robes", "=ds=#s5#, #a1#"};
		{ 2, 47143, "", "=q4=Bindings of Dark Essence", "=ds=#s8#, #a1#"};
		{ 3, 47112, "", "=q4=Belt of the Merciless Killer", "=ds=#s10#, #a2#"};
		{ 4, 47145, "", "=q4=Cord of Pale Thorns", "=ds=#s10#, #a2#"};
		{ 5, 47109, "", "=q4=Sabatons of Ruthless Judgment", "=ds=#s12#, #a3#"};
		{ 6, 47147, "", "=q4=Breastplate of the Frozen Lake", "=ds=#s5#, #a4#"};
		{ 7, 47111, "", "=q4=Bracers of the Shieldmaiden", "=ds=#s8#, #a4#"};
		{ 8, 47132, "", "=q4=Legguards of Ascension", "=ds=#s11#, #a4#"};
		{ 10, 47133, "", "=q4=The Arbiter's Muse", "=ds=#s2#"};
		{ 11, 47110, "", "=q4=The Executioner's Malice", "=ds=#s2#"};
		{ 12, 47144, "", "=q4=Wail of the Val'kyr", "=ds=#s2#"};
		{ 13, 47131, "", "=q4=Death's Verdict", "=ds=#s14#"};
		{ 14, 47146, "", "=q4=Chalice of Searing Light", "=ds=#s15#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47113, "", "=q4=Twin Spike", "=ds=#h1#, #w4#"};
		{ 19, 47130, "", "=q4=Lupine Longstaff", "=ds=#w9#"};
		Prev = "TrialoftheCrusaderFactionChampions25ManHEROIC_A";
		Next = "TrialoftheCrusaderAnubarak25ManHEROIC_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderTwinValkyrs25ManHEROIC_H"] = {
		{ 1, 47462, "", "=q4=Skyweaver Vestments", "=ds=#s5#, #a1#"};
		{ 2, 47467, "", "=q4=Dark Essence Bindings", "=ds=#s8#, #a1#"};
		{ 3, 47469, "", "=q4=Belt of Pale Thorns", "=ds=#s10#, #a2#"};
		{ 4, 47460, "", "=q4=Belt of the Pitiless Killer", "=ds=#s10#, #a2#"};
		{ 5, 47457, "", "=q4=Greaves of Ruthless Judgment", "=ds=#s12#, #a3#"};
		{ 6, 47471, "", "=q4=Chestplate of the Frozen Lake", "=ds=#s5#, #a4#"};
		{ 7, 47459, "", "=q4=Armguards of the Shieldmaiden", "=ds=#s8#, #a4#"};
		{ 8, 47465, "", "=q4=Legplates of Ascension", "=ds=#s11#, #a4#"};
		{ 10, 47468, "", "=q4=Cry of the Val'kyr", "=ds=#s2#"};
		{ 11, 47466, "", "=q4=Legionnaire's Gorget", "=ds=#s2#"};
		{ 12, 47458, "", "=q4=The Executioner's Vice", "=ds=#s2#"};
		{ 13, 47464, "", "=q4=Death's Choice", "=ds=#s14#"};
		{ 14, 47470, "", "=q4=Mystifying Charm", "=ds=#s15#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47461, "", "=q4=Gouge of the Frigid Heart", "=ds=#h1#, #w4#"};
		{ 19, 47463, "", "=q4=Twin's Pact", "=ds=#w9#"};
		Prev = "TrialoftheCrusaderFactionChampions25ManHEROIC_H";
		Next = "TrialoftheCrusaderAnubarak25ManHEROIC_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderAnubarakHEROIC_A"] = {
		{ 1, 47974, "", "=q4=Vestments of the Sleepless", "=ds=#s5#, #a1#"};
		{ 2, 47977, "", "=q4=Cinch of the Undying", "=ds=#s10#, #a1#" };
		{ 3, 47972, "", "=q4=Spaulders of the Snow Bandit", "=ds=#s3#, #a2#" };
		{ 4, 47965, "", "=q4=Headpiece of the Crypt Lord", "=ds=#s1#, #a3#" };
		{ 5, 47969, "", "=q4=Pauldrons of the Timeless Hunter", "=ds=#s3#, #a3#" };
		{ 6, 47964, "", "=q4=Chestguard of the Warden", "=ds=#s5#, #a4#" };
		{ 7, 47976, "", "=q4=Legplates of the Immortal Spider", "=ds=#s11#, #a4#" };
		{ 8, 47970, "", "=q4=Legplates of the Silver Hand", "=ds=#s11#, #a4#" };
		{ 10, 47967, "", "=q4=Crusader's Glory", "=ds=#h1#, #w10#" };
		{ 11, 47971, "", "=q4=Westfall Saber", "=ds=#h1#, #w10#" };
		{ 12, 47966, "", "=q4=The Lion's Maw", "=ds=#h1#, #w1#" };
		{ 13, 47962, "", "=q4=Argent Resolve", "=ds=#h3#, #w6#" };
		{ 14, 47973, "", "=q4=The Grinder", "=ds=#h1#, #w6#" };
		{ 16, 47979, "", "=q4=Fordragon Blades", "=ds=#w7#" };
		{ 17, 47968, "", "=q4=Cold Convergence", "=ds=#w9#" };
		{ 18, 47978, "", "=q4=Bulwark of the Royal Guard", "=ds=#w8#" };
		{ 19, 47963, "", "=q4=Vigilant Ward", "=ds=#w8#" };
		{ 20, 47975, "", "=q4=Baelgun's Heavy Crossbow", "=ds=#w3#" };
		Prev = "TrialoftheCrusaderTwinValkyrsHEROIC_A";
		Next = "TrialoftheCrusaderTributeHEROIC_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderAnubarakHEROIC_H"] = {
		{ 1, 48051, "", "=q4=Robes of the Sleepless", "=ds=#s5#, #a1#"};
		{ 2, 48054, "", "=q4=Belt of the Eternal", "=ds=#s10#, #a1#" };
		{ 3, 48049, "", "=q4=Shoulderpads of the Snow Bandit", "=ds=#s3#, #a2#" };
		{ 4, 48042, "", "=q4=Helm of the Crypt Lord", "=ds=#s1#, #a3#" };
		{ 5, 48046, "", "=q4=Pauldrons of the Shadow Hunter", "=ds=#s3#, #a3#" };
		{ 6, 48041, "", "=q4=Stoneskin Chestplate", "=ds=#s5#, #a4#" };
		{ 7, 48047, "", "=q4=Legplates of the Redeemed Blood Knight", "=ds=#s11#, #a4#" };
		{ 8, 48053, "", "=q4=Sunwalker Legguards", "=ds=#s11#, #a4#" };
		{ 10, 48044, "", "=q4=Ardent Guard", "=ds=#h1#, #w10#" };
		{ 11, 48048, "", "=q4=Forsaken Bonecarver", "=ds=#h1#, #w10#" };
		{ 12, 48043, "", "=q4=Frostblade Hatchet", "=ds=#h1#, #w1#" };
		{ 13, 48039, "", "=q4=Mace of the Earthborn Chieftain", "=ds=#h3#, #w6#" };
		{ 14, 48050, "", "=q4=Blackhorn Bludgeon", "=ds=#h1#, #w6#" };
		{ 16, 48056, "", "=q4=Anguish", "=ds=#w7#" };
		{ 17, 48045, "", "=q4=Perdition", "=ds=#w9#" };
		{ 18, 48055, "", "=q4=Aegis of the Coliseum", "=ds=#w8#" };
		{ 19, 48040, "", "=q4=Pride of the Kor'kron", "=ds=#w8#" };
		{ 20, 48052, "", "=q4=Darkmaw Crossbow", "=ds=#w3#" };
		Prev = "TrialoftheCrusaderTwinValkyrsHEROIC_H";
		Next = "TrialoftheCrusaderTributeHEROIC_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderAnubarak25ManHEROIC_A"] = {
		{ 1, 47238, "", "=q4=Maiden's Favor", "=ds=#s4#"};
		{ 2, 47192, "", "=q4=Strength of the Nerub", "=ds=#s4#"};
		{ 3, 47208, "", "=q4=Armbands of the Ashen Saint", "=ds=#s8#, #a1#"};
		{ 4, 47236, "", "=q4=Gloves of the Lifeless Touch", "=ds=#s9#, #a1#"};
		{ 5, 47189, "", "=q4=Leggings of the Deepening Void", "=ds=#s11#, #a1#"};
		{ 6, 47205, "", "=q4=Footpads of the Icy Floe", "=ds=#s12#, #a1#"};
		{ 7, 47155, "", "=q4=Bracers of Dark Determination", "=ds=#s8#, #a2#"};
		{ 8, 47190, "", "=q4=Legwraps of the Awakening", "=ds=#s11#, #a2#"};
		{ 9, 47209, "", "=q4=Chestguard of Flowing Elements", "=ds=#s5#, #a3#"};
		{ 10, 47153, "", "=q4=Belt of Deathly Dominion", "=ds=#s10#, #a3#"};
		{ 11, 47191, "", "=q4=Legguards of the Lurking Threat", "=ds=#s11#, #a3#"};
		{ 12, 47240, "", "=q4=Gloves of Bitter Reprisal", "=ds=#s9#, #a4#"};
		{ 13, 47207, "", "=q4=Belt of the Forgotten Martyr", "=ds=#s10#, #a4#"};
		{ 14, 47154, "", "=q4=Greaves of the 7th Legion", "=ds=#s12#, #a4#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47237, "", "=q4=Band of Deplorable Violence", "=ds=#s13#"};
		{ 19, 47157, "", "=q4=Signet of the Traitor King", "=ds=#s13#"};
		{ 20, 47188, "", "=q4=Reign of the Unliving", "=ds=#s14#"};
		{ 22, 47156, "", "=q4=Stormpike Cleaver", "=ds=#h1#, #w1#"};
		{ 23, 47206, "", "=q4=Misery's End", "=ds=#h3#, #w6#"};
		{ 24, 47239, "", "=q4=Archon Glaive", "=ds=#w7#"};
		Prev = "TrialoftheCrusaderTwinValkyrs25ManHEROIC_A";
		Next = "TrialoftheCrusaderTribute25ManHEROIC_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderAnubarak25ManHEROIC_H"] = {
		{ 1, 47490, "", "=q4=Maiden's Adoration", "=ds=#s4#"};
		{ 2, 47481, "", "=q4=Might of the Nerub", "=ds=#s4#"};
		{ 3, 47485, "", "=q4=Bindings of the Ashen Saint", "=ds=#s8#, #a1#"};
		{ 4, 47487, "", "=q4=Handwraps of the Lifeless Touch", "=ds=#s9#, #a1#"};
		{ 5, 47478, "", "=q4=Breeches of the Deepening Void", "=ds=#s11#, #a1#"};
		{ 6, 47482, "", "=q4=Boots of the Icy Floe", "=ds=#s12#, #a1#"};
		{ 7, 47474, "", "=q4=Armbands of Dark Determination", "=ds=#s8#, #a2#"};
		{ 8, 47479, "", "=q4=Leggings of the Awakening", "=ds=#s11#, #a2#"};
		{ 9, 47486, "", "=q4=Cuirass of Flowing Elements", "=ds=#s5#, #a3#"};
		{ 10, 47472, "", "=q4=Waistguard of Deathly Dominion", "=ds=#s10#, #a3#"};
		{ 11, 47480, "", "=q4=Leggings of the Lurking Threat", "=ds=#s11#, #a3#"};
		{ 12, 47492, "", "=q4=Gauntlets of Bitter Reprisal", "=ds=#s9#, #a4#"};
		{ 13, 47484, "", "=q4=Girdle of the Forgotten Martyr", "=ds=#s10#, #a4#"};
		{ 14, 47473, "", "=q4=Greaves of the Saronite Citadel", "=ds=#s12#, #a4#"};
		{ 16, 47242, "", "=q4=Trophy of the Crusade", "=ds=#e15#"};
		{ 18, 47476, "", "=q4=Band of the Traitor King", "=ds=#s13#"};
		{ 19, 47489, "", "=q4=Lurid Manifestation", "=ds=#s13#"};
		{ 20, 47477, "", "=q4=Reign of the Dead", "=ds=#s14#"};
		{ 22, 47475, "", "=q4=Hellscream Slicer", "=ds=#h1#, #w1#"};
		{ 23, 47483, "", "=q4=Suffering's End", "=ds=#h3#, #w6#"};
		{ 24, 47491, "", "=q4=Hellion Glaive", "=ds=#w7#"};
		Prev = "TrialoftheCrusaderTwinValkyrs25ManHEROIC_H";
		Next = "TrialoftheCrusaderTribute25ManHEROIC_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderTributeHEROIC_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["Call of the Grand Crusade"]};
		{ 2, 47242, "", "=q4=Trophy of the Crusade", "=ds=2x #e15#"};
		{ 4, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["A Tribute to Skill (25)"]};
		{ 5, 48712, "", "=q4=The Spinebreaker", "=ds=#h3#, #w13#"};
		{ 6, 48708, "", "=q4=Spellstorm Blade", "=ds=#h3#, #w10#"};
		{ 7, 48713, "", "=q4=Lothar's Edge", "=ds=#h2#, #w1#"};
		{ 8, 48709, "", "=q4=Heartcrusher", "=ds=#h3#, #w6#"};
		{ 9, 48714, "", "=q4=Honor of the Fallen", "=ds=#h1#, #w6#"};
		{ 10, 48710, "", "=q4=Paragon's Breadth", "=ds=#w9#"};
		{ 11, 48711, "", "=q4=Rhok'shalla, the Shadow's Bane", "=ds=#w2#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["A Tribute to Mad Skill (45)"]};
		{ 17, 47242, "", "=q4=Trophy of the Crusade", "=ds=2x #e15#"};
		{ 19, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["A Tribute to Insanity (50)"]};
		{ 20, 48673, "", "=q4=Cloak of the Silver Covenant", "=ds=#s4#" };
		{ 21, 48675, "", "=q4=Cloak of the Unmoving Guardian", "=ds=#s4#" };
		{ 22, 48674, "", "=q4=Cloak of the Victorious Combatant", "=ds=#s4#" };
		{ 23, 48671, "", "=q4=Drape of Bitter Incantation", "=ds=#s4#" };
		{ 24, 48672, "", "=q4=Shawl of the Fervent Crusader", "=ds=#s4#" };
		{ 25, 49044, "", "=q4=Swift Alliance Steed", "=ds=#e12# =ec1=#m7#"};
		Prev = "TrialoftheCrusaderAnubarakHEROIC_A";
		Next = "TrialoftheCrusaderPatterns_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderTributeHEROIC_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["Call of the Grand Crusade"]};
		{ 2, 47242, "", "=q4=Trophy of the Crusade", "=ds=2x #e15#"};
		{ 4, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["A Tribute to Skill (25)"]};
		{ 5, 48703, "", "=q4=The Facebreaker", "=ds=#h3#, #w13#" };
		{ 6, 48701, "", "=q4=Spellharvest", "=ds=#h3#, #w10#" };
		{ 7, 48695, "", "=q4=Mor'kosh, the Bloodreaver", "=ds=#h2#, #w1#" };
		{ 8, 48693, "", "=q4=Heartsmasher", "=ds=#h3#, #w6#" };
		{ 9, 48699, "", "=q4=Blood and Glory", "=ds=#h1#, #w6#" };
		{ 10, 48705, "", "=q4=Attrition", "=ds=#w9#" };
		{ 11, 48697, "", "=q4=Frenzystrike Longbow", "=ds=#w2#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["A Tribute to Mad Skill (45)"]};
		{ 17, 47242, "", "=q4=Trophy of the Crusade", "=ds=2x #e15#"};
		{ 19, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["A Tribute to Insanity (50)"]};
		{ 20, 48668, "", "=q4=Cloak of Serrated Blades", "=ds=#s4#" };
		{ 21, 48669, "", "=q4=Cloak of the Triumphant Combatant", "=ds=#s4#" };
		{ 22, 48670, "", "=q4=Cloak of the Unflinching Guardian", "=ds=#s4#" };
		{ 23, 48666, "", "=q4=Drape of the Sunreavers", "=ds=#s4#" };
		{ 24, 48667, "", "=q4=Shawl of the Devout Crusader", "=ds=#s4#" };
		{ 25, 49046, "", "=q4=Swift Horde Wolf", "=ds=#e12# =ec1=#m6#"};
		Prev = "TrialoftheCrusaderAnubarakHEROIC_H";
		Next = "TrialoftheCrusaderPatterns_H";
	};

	AtlasLoot_Data["TrialoftheCrusaderTribute25ManHEROIC_A"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["Call of the Grand Crusade"]};
		{ 2, 47557, "", "=q4=Regalia of the Grand Conqueror", "=ds=#e15#"};
		{ 3, 47558, "", "=q4=Regalia of the Grand Protector", "=ds=#e15#"};
		{ 4, 47559, "", "=q4=Regalia of the Grand Vanquisher", "=ds=#e15#"};
		{ 6, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["A Tribute to Skill (25)"]};
		{ 7, 47517, "", "=q4=Blade of the Unbroken Covenant", "=ds=#h3#, #w10#"};
		{ 8, 47506, "", "=q4=Silverwing Defender", "=ds=#h1#, #w10#"};
		{ 9, 47515, "", "=q4=Decimation", "=ds=#h2#, #w10#"};
		{ 10, 47526, "", "=q4=Remorseless", "=ds=#h1#, #w6#"};
		{ 11, 47519, "", "=q4=Catastrophe", "=ds=#h2#, #w6#"};
		{ 12, 47524, "", "=q4=Clemency", "=ds=#w9#"};
		{ 13, 47521, "", "=q4=BRK-1000", "=ds=#w5#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["A Tribute to Mad Skill (45)"]};
		{ 17, 47557, "", "=q4=Regalia of the Grand Conqueror", "=ds=#e15#"};
		{ 18, 47558, "", "=q4=Regalia of the Grand Protector", "=ds=#e15#"};
		{ 19, 47559, "", "=q4=Regalia of the Grand Vanquisher", "=ds=#e15#"};
		{ 21, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["A Tribute to Insanity (50)"]};
		{ 22, 47553, "", "=q4=Bolvar's Devotion", "=ds=#s4#"};
		{ 23, 47552, "", "=q4=Jaina's Radiance", "=ds=#s4#"};
		{ 24, 47549, "", "=q4=Magni's Resolution", "=ds=#s4#"};
		{ 25, 47545, "", "=q4=Vereesa's Dexterity", "=ds=#s4#"};
		{ 26, 47547, "", "=q4=Varian's Furor", "=ds=#s4#"};
		Prev = "TrialoftheCrusaderAnubarak25ManHEROIC_A";
		Next = "TrialoftheCrusaderPatterns_A";
	};

	AtlasLoot_Data["TrialoftheCrusaderTribute25ManHEROIC_H"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["Call of the Grand Crusade"]};
		{ 2, 47557, "", "=q4=Regalia of the Grand Conqueror", "=ds=#e15#"};
		{ 3, 47558, "", "=q4=Regalia of the Grand Protector", "=ds=#e15#"};
		{ 4, 47559, "", "=q4=Regalia of the Grand Vanquisher", "=ds=#e15#"};
		{ 6, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["A Tribute to Skill (25)"]};
		{ 7, 47518, "", "=q4=Mortalis", "=ds=#h3#, #w10#"};
		{ 8, 47513, "", "=q4=Ogrim's Deflector", "=ds=#h1#, #w10#"};
		{ 9, 47516, "", "=q4=Fleshrender", "=ds=#h2#, #w10#"};
		{ 10, 47528, "", "=q4=Cudgel of the Damned", "=ds=#h1#, #w6#"};
		{ 11, 47520, "", "=q4=Grievance", "=ds=#h2#, #w6#"};
		{ 12, 47525, "", "=q4=Sufferance", "=ds=#w9#"};
		{ 13, 47523, "", "=q4=Fezzik's Autocannon", "=ds=#w5#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["A Tribute to Mad Skill (45)"]};
		{ 17, 47557, "", "=q4=Regalia of the Grand Conqueror", "=ds=#e15#"};
		{ 18, 47558, "", "=q4=Regalia of the Grand Protector", "=ds=#e15#"};
		{ 19, 47559, "", "=q4=Regalia of the Grand Vanquisher", "=ds=#e15#"};
		{ 21, 0, "INV_Box_01", "=q6="..AL["Bonus Loot"], "=q5="..AL["A Tribute to Insanity (50)"]};
		{ 22, 47551, "", "=q4=Aethas' Intensity", "=ds=#s4#"};
		{ 23, 47550, "", "=q4=Cairne's Endurance", "=ds=#s4#"};
		{ 24, 47548, "", "=q4=Garrosh's Rage", "=ds=#s4#"};
		{ 25, 47554, "", "=q4=Lady Liadrin's Conviction", "=ds=#s4#"};
		{ 26, 47546, "", "=q4=Sylvanas' Cunning", "=ds=#s4#"};
		Prev = "TrialoftheCrusaderAnubarak25ManHEROIC_H";
		Next = "TrialoftheCrusaderPatterns_H";
	};

		-------------------------
		--- Onyxia (Level 80) ---
		-------------------------

	AtlasLoot_Data["Onyxia_1"] = {
		{ 1, 49307, "", "=q4=Fluttering Sapphiron Drape", "=ds=#s4#", "" };
		{ 2, 49316, "", "=q4=Circlet of Transcendence", "=ds=#s1#, #a1#", "" };
		{ 3, 49317, "", "=q4=Coronet of Transcendence", "=ds=#s1#, #a1#", "" };
		{ 4, 49315, "", "=q4=Nemesis Skullcover", "=ds=#s1#, #a1#", "" };
		{ 5, 49318, "", "=q4=Netherwind Hood", "=ds=#s1#, #a1#", "" };
		{ 6, 49322, "", "=q4=Bloodfang Mask", "=ds=#s1#, #a2#", "" };
		{ 7, 49327, "", "=q4=Stormrage Antlers", "=ds=#s1#, #a2#", "" };
		{ 8, 49328, "", "=q4=Stormrage Helm", "=ds=#s1#, #a2#", "" };
		{ 9, 49326, "", "=q4=Stormrage Hood", "=ds=#s1#, #a2#", "" };
		{ 10, 49331, "", "=q4=Coif of Ten Storms", "=ds=#s1#, #a3#", "" };
		{ 11, 49330, "", "=q4=Cowl of Ten Storms", "=ds=#s1#, #a3#", "" };
		{ 12, 49329, "", "=q4=Gaze of Ten Storms", "=ds=#s1#, #a3#", "" };
		{ 13, 49319, "", "=q4=Dragonstalker's Helmet", "=ds=#s1#, #a3#", "" };
		{ 14, 49320, "", "=q4=Faceguard of Wrath", "=ds=#s1#, #a4#", "" };
		{ 15, 49321, "", "=q4=Greathelm of Wrath", "=ds=#s1#, #a4#", "" };
		{ 16, 49333, "", "=q4=Frostforged Helmet", "=ds=#s1#, #a4#", "" };
		{ 17, 49332, "", "=q4=Frostforged Ringhelm", "=ds=#s1#, #a4#", "" };
		{ 18, 49323, "", "=q4=Judgement Cover", "=ds=#s1#, #a4#", "" };
		{ 19, 49325, "", "=q4=Judgement Helm", "=ds=#s1#, #a4#", "" };
		{ 20, 49324, "", "=q4=Judgement Helmet", "=ds=#s1#, #a4#", "" };
		{ 21, 49306, "", "=q4=Eskhandar's Choker", "=ds=#s2#", "" };
		{ 22, 49309, "", "=q4=Runed Ring of Binding", "=ds=#s13#", "" };
		{ 23, 49463, "", "=q4=Purified Shard of the Flame", "=ds=#s14#", "" };
		{ 24, 49310, "", "=q4=Purified Shard of the Scale", "=ds=#s14#", "" };
		{ 25, 49308, "", "=q4=Antique Cornerstone Grimoire", "=ds=#s15#", "" };
		Next = "Onyxia_2";
	};

	AtlasLoot_Data["Onyxia_2"] = {
		{ 1, 49304, "", "=q4=Sharpened Fang of the Mystics", "=ds=#h3#, #w4#", "" };
		{ 2, 49437, "", "=q4=Rusted Gutgore Ripper", "=ds=#h1#, #w4#", "" };
		{ 3, 49298, "", "=q4=Glinting Azuresong Mageblade", "=ds=#h3#, #w10#", "" };
		{ 4, 49303, "", "=q4=Gleaming Quel'Serrar", "=ds=#h1#, #w10#", "" };
		{ 5, 49296, "", "=q4=Singed Vis'kag the Bloodletter", "=ds=#h1#, #w10#", "" };
		{ 6, 49299, "", "=q4=Keen Obsidian Edged Blade", "=ds=#h2#, #w10#", "" };
		{ 7, 49297, "", "=q4=Empowered Deathbringer", "=ds=#h1#, #w1#", "" };
		{ 8, 49302, "", "=q4=Reclaimed Shadowstrike", "=ds=#w7#", "" };
		{ 9, 49301, "", "=q4=Reclaimed Thunderstrike", "=ds=#w7#", "" };
		{ 10, 49305, "", "=q4=Snub-Nose Blastershot Launcher", "=ds=#w5#", "" };
		{ 16, 49644, "", "=q4=Head of Onyxia", "=ds=#m3#", "" };
		{ 17, 49485, "", "=q4=Sparkling Onyxia Tooth Pendant", "=q1=#m4#: =ds=#s2#", "", };
		{ 18, 49486, "", "=q4=Polished Dragonslayer's Signet", "=q1=#m4#: =ds=#s13#", "", };
		{ 19, 49487, "", "=q4=Purified Onyxia Blood Talisman", "=q1=#m4#: =ds=#s14#", "", };
		{ 21, 49295, "", "=q4=Enlarged Onyxia Hide Backpack", "=ds=#e1#", "" };
		{ 22, 49294, "", "=q4=Ashen Sack of Gems", "=ds=#e7# #e1#", "" };
		{ 24, 49636, "", "=q4=Reins of the Onyxian Drake", "=ds=#e12#", "" };
		Prev = "Onyxia_1";
	};

	AtlasLoot_Data["Onyxia_125Man"] = {
		{ 1, 49491, "", "=q4=Flowing Sapphiron Drape", "=ds=#s4#", "" };
		{ 2, 49482, "", "=q4=Aurora of Transcendence", "=ds=#s1#, #a1#", "" };
		{ 3, 49483, "", "=q4=Halo of Transcendence", "=ds=#s1#, #a1#", "" };
		{ 4, 49484, "", "=q4=Nemesis Skullcap", "=ds=#s1#, #a1#", "" };
		{ 5, 49481, "", "=q4=Netherwind Crown", "=ds=#s1#, #a1#", "" };
		{ 6, 49477, "", "=q4=Bloodfang Hood", "=ds=#s1#, #a2#", "" };
		{ 7, 49472, "", "=q4=Stormrage Crown", "=ds=#s1#, #a2#", "" };
		{ 8, 49473, "", "=q4=Stormrage Cover", "=ds=#s1#, #a2#", "" };
		{ 9, 49471, "", "=q4=Stormrage Coverlet", "=ds=#s1#, #a2#", "" };
		{ 10, 49469, "", "=q4=Crown of Ten Storms", "=ds=#s1#, #a3#", "" };
		{ 11, 49468, "", "=q4=Helm of Ten Storms", "=ds=#s1#, #a3#", "" };
		{ 12, 49470, "", "=q4=Helmet of Ten Storms", "=ds=#s1#, #a3#", "" };
		{ 13, 49480, "", "=q4=Dragonstalker's Helm", "=ds=#s1#, #a3#", "" };
		{ 14, 49479, "", "=q4=Helm of Wrath", "=ds=#s1#, #a4#", "" };
		{ 15, 49478, "", "=q4=Helmet of Wrath", "=ds=#s1#, #a4#", "" };
		{ 16, 49467, "", "=q4=Frostforged Greathelm", "=ds=#s1#, #a4#", "" };
		{ 17, 49466, "", "=q4=Frostforged Helm", "=ds=#s1#, #a4#", "" };
		{ 18, 49476, "", "=q4=Judgement Crown", "=ds=#s1#, #a4#", "" };
		{ 19, 49475, "", "=q4=Judgement Heaume", "=ds=#s1#, #a4#", "" };
		{ 20, 49474, "", "=q4=Judgement Hood", "=ds=#s1#, #a4#", "" };
		{ 21, 49492, "", "=q4=Eskhandar's Links", "=ds=#s2#", "" };
		{ 22, 49489, "", "=q4=Signified Ring of Binding", "=ds=#s13#", "" };
		{ 23, 49464, "", "=q4=Shiny Shard of the Flame", "=ds=#s14#", "" };
		{ 24, 49488, "", "=q4=Shiny Shard of the Scale", "=ds=#s14#", "" };
		{ 25, 49490, "", "=q4=Antediluvian Cornerstone Grimoire", "=ds=#s15#", "" };
		Next = "Onyxia_225Man";
	};

	AtlasLoot_Data["Onyxia_225Man"] = {
		{ 1, 49494, "", "=q4=Honed Fang of the Mystics", "=ds=#h3# #w4#", "" };
		{ 2, 49465, "", "=q4=Tarnished Gutgore Ripper", "=ds=#h1# #w4#", "" };
		{ 3, 49499, "", "=q4=Polished Azuresong Mageblade", "=ds=#h3# #w10#", "" };
		{ 4, 49495, "", "=q4=Burnished Quel'Serrar", "=ds=#h1# #w10#", "" };
		{ 5, 49501, "", "=q4=Tempered Vis'kag the Bloodletter", "=ds=#h1# #w10#", "" };
		{ 6, 49498, "", "=q4=Sharpened Obsidian Edged Blade", "=ds=#h2# #w10#", "" };
		{ 7, 49500, "", "=q4=Raging Deathbringer", "=ds=#h1# #w1#", "" };
		{ 8, 49496, "", "=q4=Reinforced Shadowstrike", "=ds=#w7#", "" };
		{ 9, 49497, "", "=q4=Reinforced Thunderstrike", "=ds=#w7#", "" };
		{ 10, 49493, "", "=q4=Rifled Blastershot Launcher", "=ds=#w5#", "" };
		{ 16, 49644, "", "=q4=Head of Onyxia", "=ds=#m3#", "" };
		{ 17, 49485, "", "=q4=Sparkling Onyxia Tooth Pendant", "=q1=#m4#: =ds=#s2#", "", };
		{ 18, 49486, "", "=q4=Polished Dragonslayer's Signet", "=q1=#m4#: =ds=#s13#", "", };
		{ 19, 49487, "", "=q4=Purified Onyxia Blood Talisman", "=q1=#m4#: =ds=#s14#", "", };
		{ 21, 49295, "", "=q4=Enlarged Onyxia Hide Backpack", "=ds=#e1#", "" };
		{ 22, 49294, "", "=q4=Ashen Sack of Gems", "=ds=#e7# #e1#", "" };
		{ 24, 49636, "", "=q4=Reins of the Onyxian Drake", "=ds=#e12#", "" };
		Prev = "Onyxia_125Man";
	};

		--------------------------
		--- The Forge of Souls ---
		--------------------------

	AtlasLoot_Data["FoSBronjahm"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 49788, "", "=q4=Cold Sweat Grips", "=ds=#s9#, #a1#"};
		{ 3, 49785, "", "=q4=Bewildering Shoulderpads", "=ds=#s3#, #a2#"};
		{ 4, 49786, "", "=q4=Robes of the Cheating Heart", "=ds=#s5#, #a2#"};
		{ 5, 49787, "", "=q4=Seven Stormy Mornings", "=ds=#s8#, #a3#"};
		{ 6, 49784, "", "=q4=Minister's Number One Legplates", "=ds=#s11#, #a4#"};
		{ 7, 49783, "", "=q4=Lucky Old Sun", "=ds=#h1#, #w6#"};
		{ 9, 50317, "", "=q4=Papa's New Bag", "=ds=#e1#"};
		{ 10, 50316, "", "=q4=Papa's Brand New Bag", "=ds=#e1#"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 50193, "", "=q4=Very Fashionable Shoulders", "=ds=#s3#, #a1#"};
		{ 18, 50197, "", "=q4=Eyes of Bewilderment", "=ds=#s1#, #a3#"};
		{ 19, 50194, "", "=q4=Weeping Gauntlets", "=ds=#s9#, #a4#"};
		{ 20, 50196, "", "=q4=Love's Prisoner", "=ds=#s2#"};
		{ 21, 50191, "", "=q4=Nighttime", "=ds=#h1#, #w1#"};
		{ 22, 50169, "", "=q4=Papa's Brand New Knife", "=ds=#w11#"};
		{ 24, 50317, "", "=q4=Papa's New Bag", "=ds=#e1#"};
		{ 25, 50316, "", "=q4=Papa's Brand New Bag", "=ds=#e1#"};
		Next = "FoSDevourer";
	};

	AtlasLoot_Data["FoSDevourer"] = {
		{ 1, 49792, "", "=q4=Accursed Crawling Cape", "=ds=#s4#"};
		{ 2, 49796, "", "=q4=Essence of Anger", "=ds=#s10#, #a1#"};
		{ 3, 49798, "", "=q4=Soul Screaming Boots", "=ds=#s12#, #a3#"};
		{ 4, 49791, "", "=q4=Lost Reliquary Chestguard", "=ds=#s5#, #a4#"};
		{ 5, 49797, "", "=q4=Brace Guards of the Starless Night", "=ds=#s8#, #a4#"};
		{ 6, 49794, "", "=q4=Legplates of Frozen Granite", "=ds=#s11#, #a4#"};
		{ 7, 49795, "", "=q4=Sollerets of Suffering", "=ds=#s12#, #a4#"};
		{ 16, 49799, "", "=q4=Coil of Missing Gems", "=ds=#s2#"};
		{ 17, 49800, "", "=q4=Spiteful Signet", "=ds=#s13#"};
		{ 19, 49789, "", "=q4=Heartshiver", "=ds=#h1#, #w4#"};
		{ 20, 49790, "", "=q4=Blood Boil Lancet", "=ds=#w9#"};
		{ 21, 49793, "", "=q4=Tower of the Mouldering Corpse", "=ds=#w9#"};
		Prev = "FoSBronjahm";
		Next = "FHTrashMobs";
	};

	AtlasLoot_Data["FoSDevourerHEROIC"] = {
		{ 1, 50213, "", "=q4=Mord'rethar Robes", "=ds=#s5#, #a1#"};
		{ 2, 50206, "", "=q4=Frayed Scoundrel's Cap", "=ds=#s1#, #a2#"};
		{ 3, 50212, "", "=q4=Essence of Desire", "=ds=#s9#, #a2#"};
		{ 4, 50214, "", "=q4=Helm of the Spirit Shock", "=ds=#s1#, #a3#"};
		{ 5, 50209, "", "=q4=Essence of Suffering", "=ds=#s8#, #a3#"};
		{ 6, 50208, "", "=q4=Pauldrons of the Devourer", "=ds=#s3#, #a4#"};
		{ 7, 50207, "", "=q4=Black Spire Sabatons", "=ds=#s12#, #a4#"};
		{ 8, 50215, "", "=q4=Recovered Reliquary Boots", "=ds=#s12#, #a4#"};
		{ 16, 50211, "", "=q4=Arcane Loops of Anger", "=ds=#s2#"};
		{ 17, 50198, "", "=q4=Needle-Encrusted Scorpion", "=ds=#s14#"};
		{ 19, 50203, "", "=q4=Blood Weeper", "=ds=#h1#, #w4#"};
		{ 20, 50210, "", "=q4=Seethe", "=ds=#h3#, #w10#"};
		Prev = "FoSBronjahm";
		Next = "FHTrashMobs";
	};

		--------------------
		--- Pit of Saron ---
		--------------------

	AtlasLoot_Data["PoSGarfrost"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 49805, "", "=q4=Ice-Steeped Sandals", "=ds=#s12#, #a1#"};
		{ 3, 49806, "", "=q4=Flayer's Black Belt", "=ds=#s10#, #a2#"};
		{ 4, 49804, "", "=q4=Polished Mirror Helm", "=ds=#s1#, #a3#"};
		{ 5, 49803, "", "=q4=Ring of Carnelian and Bone", "=ds=#s13#"};
		{ 6, 49802, "", "=q4=Garfrost's Two-Ton Hammer", "=ds=#h2#, #w6#"};
		{ 7, 49801, "", "=q4=Unspeakable Secret", "=ds=#w9#"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 50233, "", "=q4=Spurned Val'kyr Shoulderguards", "=ds=#s3#, #a3#"};
		{ 18, 50234, "", "=q4=Shoulderplates of Frozen Blood", "=ds=#s3#, #a4#"};
		{ 19, 50230, "", "=q4=Malykriss Vambraces", "=ds=#s8#, #a4#"};
		{ 20, 50229, "", "=q4=Legguards of the Frosty Depths", "=ds=#s11#, #a4#"};
		{ 21, 50228, "", "=q4=Barbed Ymirheim Choker", "=ds=#s2#"};
		{ 22, 50227, "", "=q4=Surgeon's Needle", "=ds=#h3#, #w4#"};
		Next = "PoSKrickIck";
	};

	AtlasLoot_Data["PoSKrickIck"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 49809, "", "=q4=Wristguards of Subterranean Moss", "=ds=#s8#, #a1#"};
		{ 3, 49810, "", "=q4=Scabrous Zombie Leather Belt", "=ds=#s10#, #a3#"};
		{ 4, 49811, "", "=q4=Black Dragonskin Breeches", "=ds=#s11#, #a3#"};
		{ 5, 49808, "", "=q4=Bent Gold Belt", "=ds=#s10#, #a4#"};
		{ 6, 49812, "", "=q4=Purloined Wedding Ring", "=ds=#s13#"};
		{ 7, 49807, "", "=q4=Krick's Beetle Stabber", "=ds=#h1#, #w4#"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 50266, "", "=q4=Ancient Polar Bear Hide", "=ds=#s5#, #a1#"};
		{ 18, 50263, "", "=q4=Braid of Salt and Fire", "=ds=#s10#, #a1#"};
		{ 19, 50264, "", "=q4=Chewed Leather Wristguards", "=ds=#s8#, #a2#"};
		{ 20, 50265, "", "=q4=Blackened Ghoul Skin Leggings", "=ds=#s11#, #a3#"};
		{ 21, 50235, "", "=q4=Ick's Rotting Thumb", "=ds=#s14#"};
		{ 22, 50262, "", "=q4=Felglacier Bolter", "=ds=#w3#"};
		Prev = "PoSGarfrost";
		Next = "PoSTyrannus";
	};

	AtlasLoot_Data["PoSTyrannus"] = {
		{ 1, 49823, "", "=q4=Cloak of the Fallen Cardinal", "=ds=#s4#"};
		{ 2, 49825, "", "=q4=Palebone Robes", "=ds=#s5#, #a1#"};
		{ 3, 49822, "", "=q4=Rimewoven Silks", "=ds=#s11#, #a1#"};
		{ 4, 49817, "", "=q4=Shaggy Wyrmleather Leggings", "=ds=#s11#, #a2#"};
		{ 5, 49824, "", "=q4=Horns of the Spurned Val'kyr", "=ds=#s1#, #a3#"};
		{ 6, 49826, "", "=q4=Shroud of Rime", "=ds=#s5#, #a3#"};
		{ 7, 49820, "", "=q4=Gondria's Spectral Bracer", "=ds=#s8#, #a3#"};
		{ 8, 49819, "", "=q4=Skeleton Lord's Cranium", "=ds=#s1#, #a4#"};
		{ 9, 49816, "", "=q4=Scourgelord's Frigid Chestplate", "=ds=#s5#, #a4#"};
		{ 16, 49818, "", "=q4=Painfully Sharp Choker", "=ds=#s2#"};
		{ 18, 49821, "", "=q4=Protector of Frigid Souls", "=ds=#w8#"};
		{ 19, 49813, "", "=q4=Rimebane Rifle", "=ds=#w5#"};
		Prev = "PoSKrickIck";
		Next = "FHTrashMobs";
	};

	AtlasLoot_Data["PoSTyrannusHEROIC"] = {
		{ 1, 50286, "", "=q4=Prelate's Snowshoes", "=ds=#s12#, #a1#"};
		{ 2, 50269, "", "=q4=Fleshwerk Leggings", "=ds=#s11#, #a2#"};
		{ 3, 50270, "", "=q4=Belt of Rotted Fingernails", "=ds=#s10#, #a3#"};
		{ 4, 50283, "", "=q4=Mudslide Boots", "=ds=#s12#, #a3#"};
		{ 5, 50272, "", "=q4=Frost Wyrm Ribcage", "=ds=#s5#, #a4#"};
		{ 6, 50285, "", "=q4=Icebound Bronze Cuirass", "=ds=#s5#, #a4#"};
		{ 7, 50284, "", "=q4=Rusty Frozen Fingerguards", "=ds=#s9#, #a4#"};
		{ 16, 50271, "", "=q4=Band of Stained Souls", "=ds=#s13#"};
		{ 17, 50259, "", "=q4=Nevermelting Ice Crystal", "=ds=#s14#"};
		{ 19, 50268, "", "=q4=Rimefang's Claw", "=ds=#h1#, #w10#"};
		{ 20, 50267, "", "=q4=Tyrannical Beheader", "=ds=#h2#, #w1#"};
		{ 21, 50273, "", "=q4=Engraved Gargoyle Femur", "=ds=#w9#"};
		Prev = "PoSKrickIck";
		Next = "FHTrashMobs";
	};

		---------------------------
		--- Halls of Reflection ---
		---------------------------

	AtlasLoot_Data["HoRFalric"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 49832, "", "=q4=Eerie Runeblade Polisher", "=ds=#s4#"};
		{ 3, 49828, "", "=q4=Marwyn's Macabre Fingertips", "=ds=#s9#, #a1#"};
		{ 4, 49830, "", "=q4=Fallen Sentry's Hood", "=ds=#s1#, #a2#"};
		{ 5, 49831, "", "=q4=Muddied Boots of Brill", "=ds=#s12#, #a3#"};
		{ 6, 49829, "", "=q4=Valonforth's Tarnished Pauldrons", "=ds=#s3#, #a4#"};
		{ 7, 49827, "", "=q4=Ghoulslicer", "=ds=#h1#, #w10#"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 50292, "", "=q4=Bracer of Worn Molars", "=ds=#s8#, #a1#"};
		{ 18, 50293, "", "=q4=Spaulders of Black Betrayal", "=ds=#s3#, #a2#"};
		{ 19, 50295, "", "=q4=Spiked Toestompers", "=ds=#s12#, #a3#"};
		{ 20, 50294, "", "=q4=Chestpiece of High Treason", "=ds=#s5#, #a4#"};
		{ 21, 50290, "", "=q4=Falric's Wrist-Chopper", "=ds=#h1#, #w1#"};
		{ 22, 50291, "", "=q4=Soulsplinter", "=ds=#w12#"};
		Next = "HoRMarwyn";
	};

	AtlasLoot_Data["HoRMarwyn"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 49834, "", "=q4=Frayed Abomination Stitching Shoulders", "=ds=#s3#, #a1#"};
		{ 3, 49838, "", "=q4=Carpal Tunnelers", "=ds=#s9#, #a2#"};
		{ 4, 49837, "", "=q4=Mitts of Burning Hail", "=ds=#s9#, #a3#"};
		{ 5, 49836, "", "=q4=Frostsworn Bone Leggings", "=ds=#s11#, #a3#"};
		{ 6, 49833, "", "=q4=Splintered Icecrown Parapet", "=ds=#h3#, #w10#"};
		{ 7, 49835, "", "=q4=Splintered Door of the Citadel", "=ds=#w8#"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 50298, "", "=q4=Sightless Crown of Ulmaas", "=ds=#s1#, #a1#"};
		{ 18, 50299, "", "=q4=Suspiciously Soft Gloves", "=ds=#s9#, #a1#"};
		{ 19, 50300, "", "=q4=Choking Hauberk", "=ds=#s5#, #a2#"};
		{ 20, 50297, "", "=q4=Frostsworn Bone Chestpiece", "=ds=#s5#, #a3#"};
		{ 21, 50260, "", "=q4=Ephemeral Snowflake", "=ds=#s14#"};
		{ 22, 50296, "", "=q4=Orca-Hunter's Harpoon", "=ds=#w7#"};
		Prev = "HoRFalric";
		Next = "HoRLichKing";
	};

	AtlasLoot_Data["HoRLichKing"] = {
		{ 1, 49842, "", "=q4=Tapestry of the Frozen Throne", "=ds=#s4#"};
		{ 2, 49849, "", "=q4=Tattered Glacial-Woven Hood", "=ds=#s1#, #a1#"};
		{ 3, 49848, "", "=q4=Grim Lasher Shoulderguards", "=ds=#s3#, #a2#"};
		{ 4, 49841, "", "=q4=Blackened Geist Ribs", "=ds=#s5#, #a2#"};
		{ 5, 49847, "", "=q4=Legguards of Untimely Demise", "=ds=#s11#, #a3#"};
		{ 6, 49851, "", "=q4=Greathelm of the Silver Hand", "=ds=#s1#, #a4#"};
		{ 7, 49843, "", "=q4=Crystalline Citadel Gauntlets", "=ds=#s9#, #a4#"};
		{ 16, 49846, "", "=q4=Chilled Heart of the Glacier", "=ds=#h3#, #w4#"};
		{ 17, 49839, "", "=q4=Mourning Malice", "=ds=#h2#, #w10#"};
		{ 18, 49840, "", "=q4=Hate-Forged Cleaver", "=ds=#h1#, #w1#"};
		{ 19, 49845, "", "=q4=Bone Golem Scapula", "=ds=#h3#, #w6#"};
		{ 20, 49844, "", "=q4=Crypt Fiend Slayer", "=ds=#w2#"};
		Prev = "HoRMarwyn";
		Next = "FHTrashMobs";
	};

	AtlasLoot_Data["HoRLichKingHEROIC"] = {
		{ 1, 50314, "", "=q4=Strip of Remorse", "=ds=#s10#, #a1#"};
		{ 2, 50312, "", "=q4=Chestguard of Broken Branches", "=ds=#s5#, #a2#"};
		{ 3, 50308, "", "=q4=Blighted Leather Footpads", "=ds=#s12#, #a2#"};
		{ 4, 50304, "", "=q4=Hoarfrost Gauntlets", "=ds=#s9#, #a3#"};
		{ 5, 50311, "", "=q4=Second Helm of the Executioner", "=ds=#s1#, #a4#"};
		{ 6, 50305, "", "=q4=Grinning Skull Boots", "=ds=#s12#, #a4#"};
		{ 8, 50310, "", "=q4=Fossilized Ammonite Choker", "=ds=#s2#"};
		{ 9, 50313, "", "=q4=Oath of Empress Zoe", "=ds=#s13#"};
		{ 10, 50306, "", "=q4=The Lady's Promise", "=ds=#s13#"};
		{ 11, 50309, "", "=q4=Shriveled Heart", "=ds=#s15#"};
		{ 16, 50302, "", "=q4=Liar's Tongue", "=ds=#h1#, #w10#"};
		{ 17, 50303, "", "=q4=Black Icicle", "=ds=#h1#, #w6#"};
		Prev = "HoRMarwyn";
		Next = "FHTrashMobs";
	};

	AtlasLoot_Data["FHTrashMobs"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 49854, "", "=q4=Mantle of Tattered Feathers", "=ds=#s3#, #a1#"};
		{ 3, 49855, "", "=q4=Plated Grips of Korth'azz", "=ds=#s9#, #a4#"};
		{ 4, 49853, "", "=q4=Titanium Links of Lore", "=ds=#s10#, #a4#"};
		{ 5, 49852, "", "=q4=Coffin Nail", "=ds=#w12#"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 50318, "", "=q4=Ghostly Wristwraps", "=ds=#s8#, #a2#"};
		{ 18, 50315, "", "=q4=Seven-Fingered Claws", "=ds=#h3#, #w13#"};
		{ 19, 50319, "", "=q4=Unsharpened Ice Razor", "=ds=#h1#, #w4#"};
		{ 21, 50380, "", "=q4=Battered Hilt", "=ds=#m2#"};
		{ 22, 50379, "", "=q4=Battered Hilt", "=ds=#m2#"};
		{ 23, 50047, "", "=q4=Quel'Delar, Lens of the Mind", "=q1=#m4#: =ds=#h3#, #w10#"};
		{ 24, 50046, "", "=q4=Quel'Delar, Cunning of the Shadows", "=q1=#m4#: =ds=#h1#, #w10#"};
		{ 25, 50049, "", "=q4=Quel'Delar, Ferocity of the Scorned", "=q1=#m4#: =ds=#h2#, #w10#"};
		{ 26, 50048, "", "=q4=Quel'Delar, Might of the Faithful", "=q1=#m4#: =ds=#h2#, #w10#"};
		{ 27, 50051, "", "=q4=Hammer of Purified Flame", "=q1=#m4#: =ds=#h3#, #w6#"};
		{ 28, 50050, "", "=q4=Cudgel of Furious Justice", "=q1=#m4#: =ds=#h1#, #w6#"};
		{ 29, 50052, "", "=q4=Lightborn Spire", "=q1=#m4#: =ds=#h2#, #w6#"};
	};

		------------------------
		--- Icecrown Citadel ---
		------------------------

		-------------------
		--- Lower Spire ---
		-------------------

	AtlasLoot_Data["ICCLordMarrowgar"] = {
		{ 1, 50764, "", "=q4=Shawl of Nerubian Silk", "=ds=#s4#"};
		{ 2, 50773, "", "=q4=Cord of the Patronizing Practitioner", "=ds=#s10#, #a1#"};
		{ 3, 50774, "", "=q4=Coldwraith Bracers", "=ds=#s8#, #a3#"};
		{ 4, 50762, "", "=q4=Linked Scourge Vertebrae", "=ds=#s10#, #a3#"};
		{ 5, 50775, "", "=q4=Corrupted Silverplate Leggings", "=ds=#s11#, #a4#"};
		{ 6, 50772, "", "=q4=Ancient Skeletal Boots", "=ds=#s12#, #a4#"};
		{ 8, 50763, "", "=q4=Marrowgar's Scratching Choker", "=ds=#s2#"};
		{ 9, 50339, "", "=q4=Sliver of Pure Ice", "=ds=#s14#"};
		{ 16, 50771, "", "=q4=Frost Needle", "=ds=#h3#, #w10#"};
		{ 17, 50761, "", "=q4=Citadel Enforcer's Claymore", "=ds=#h2#, #w10#"};
		{ 18, 50759, "", "=q4=Bone Warden's Splitter", "=ds=#h1#, #w1#"};
		{ 19, 50760, "", "=q4=Bonebreaker Scepter", "=ds=#h1#, #w6#"};
		Next = "ICCLadyDeathwhisper";
	};

	AtlasLoot_Data["ICCLordMarrowgar25Man"] = {
		{ 1, 49978, "", "=q4=Crushing Coldwraith Belt", "=ds=#s10#, #a1#"};
		{ 2, 49979, "", "=q4=Handguards of Winter's Respite", "=ds=#s9#, #a2#"};
		{ 3, 49950, "", "=q4=Frostbitten Fur Boots", "=ds=#s12#, #a2#"};
		{ 4, 49952, "", "=q4=Snowserpent Mail Helm", "=ds=#s1#, #a3#"};
		{ 5, 49980, "", "=q4=Rusted Bonespike Pauldrons", "=ds=#s3#, #a4#"};
		{ 6, 49951, "", "=q4=Gendarme's Cuirass", "=ds=#s5#, #a4#"};
		{ 7, 49960, "", "=q4=Bracers of Dark Reckoning", "=ds=#s8#, #a4#"};
		{ 8, 49964, "", "=q4=Legguards of Lost Hope", "=ds=#s11#, #a4#"};
		{ 10, 49975, "", "=q4=Bone Sentinel's Amulet", "=ds=#s2#"};
		{ 11, 49949, "", "=q4=Band of the Bone Colossus", "=ds=#s13#"};
		{ 12, 49977, "", "=q4=Loop of the Endless Labyrinth", "=ds=#s13#"};
		{ 13, 49967, "", "=q4=Marrowgar's Frigid Eye", "=ds=#s13#"};
		{ 16, 49968, "", "=q4=Frozen Bonespike", "=ds=#h3#, #w4#"};
		{ 17, 50415, "", "=q4=Bryntroll, the Bone Arbiter", "=ds=#h2#, #w1#"};
		{ 18, 49976, "", "=q4=Bulwark of Smouldering Steel", "=ds=#w8#"};
		{ 20, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 21, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		Next = "ICCLadyDeathwhisper25Man";
	};

	AtlasLoot_Data["ICCLadyDeathwhisper"] = {
		{ 1, 50785, "", "=q4=Bracers of Dark Blessings", "=ds=#s8#, #a1#"};
		{ 2, 50782, "", "=q4=Sister's Handshrouds", "=ds=#s9#, #a1#"};
		{ 3, 50780, "", "=q4=Chestguard of the Frigid Noose", "=ds=#s5#, #a2#"};
		{ 4, 50778, "", "=q4=Soulthief's Braided Belt", "=ds=#s10#, #a2#"};
		{ 5, 50783, "", "=q4=Boots of the Frozen Seed", "=ds=#s12#, #a2#"};
		{ 6, 50777, "", "=q4=Handgrips of Frost and Sleet", "=ds=#s9#, #a3#"};
		{ 7, 50784, "", "=q4=Deathspeaker Disciple's Belt", "=ds=#s10#, #a3#"};
		{ 8, 50779, "", "=q4=Deathspeaker Zealot's Helm", "=ds=#s1#, #a4#"};
		{ 9, 50786, "", "=q4=Ghoul Commander's Cuirass", "=ds=#s5#, #a4#"};
		{ 16, 50342, "", "=q4=Whispering Fanged Skull", "=ds=#s14#"};
		{ 17, 50781, "", "=q4=Scourgelord's Baton", "=ds=#s15#"};
		{ 19, 50776, "", "=q4=Njordnar Bone Bow", "=ds=#w2#"};
		Prev = "ICCLordMarrowgar";
		Next = "ICCGunshipBattle";
	};

	AtlasLoot_Data["ICCLadyDeathwhisper25Man"] = {
		{ 1, 49991, "", "=q4=Shoulders of Mercy Killing", "=ds=#s3#, #a1#"};
		{ 2, 49994, "", "=q4=The Lady's Brittle Bracers", "=ds=#s8#, #a1#"};
		{ 3, 49987, "", "=q4=Cultist's Bloodsoaked Spaulders", "=ds=#s3#, #a2#"};
		{ 4, 49996, "", "=q4=Deathwhisper Chestpiece", "=ds=#s5#, #a2#"};
		{ 5, 49988, "", "=q4=Leggings of Northern Lights", "=ds=#s11#, #a3#"};
		{ 6, 49993, "", "=q4=Necrophotic Greaves", "=ds=#s12#, #a3#"};
		{ 7, 49986, "", "=q4=Broken Ram Skull Helm", "=ds=#s1#, #a4#"};
		{ 8, 49995, "", "=q4=Fallen Lord's Handguards", "=ds=#s9#, #a4#"};
		{ 9, 49983, "", "=q4=Blood-Soaked Saronite Stompers", "=ds=#s12#, #a4#"};
		{ 11, 49989, "", "=q4=Ahn'kahar Onyx Neckguard", "=ds=#s2#"};
		{ 12, 49985, "", "=q4=Juggernaut Band", "=ds=#s13#"};
		{ 13, 49990, "", "=q4=Ring of Maddening Whispers", "=ds=#s13#"};
		{ 16, 49982, "", "=q4=Heartpierce", "=ds=#h1#, #w4#"};
		{ 17, 49992, "", "=q4=Nibelung", "=ds=#w9#"};
		{ 18, 50034, "", "=q4=Zod's Repeating Longbow", "=ds=#w2#"};
		{ 20, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 21, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		Prev = "ICCLordMarrowgar25Man";
		Next = "ICCGunshipBattle25Man";
	};

	AtlasLoot_Data["ICCGunshipBattle"] = {
		{ 1, 50791, "", "=q4=Saronite Gargoyle Cloak", "=ds=#s4#"};
		{ 2, 50795, "", "=q4=Cord of Dark Suffering", "=ds=#s10#, #a2#"};
		{ 3, 50797, "", "=q4=Ice-Reinforced Vrykul Helm", "=ds=#s1#, #a3#"};
		{ 4, 50792, "", "=q4=Pauldrons of Lost Hope", "=ds=#s3#, #a3#"};
		{ 5, 50789, "", "=q4=Icecrown Rampart Bracers", "=ds=#s8#, #a3#"};
		{ 6, 50796, "", "=q4=Bracers of Pale Illumination", "=ds=#s8#, #a4#"};
		{ 7, 50788, "", "=q4=Bone Drake's Enameled Boots", "=ds=#s12#, #a4#"};
		{ 9, 50790, "", "=q4=Abomination's Bloody Ring", "=ds=#s13#"};
		{ 10, 50340, "", "=q4=Muradin's Spyglass", "=ds=#s14#"};
		{ 16, 50793, "", "=q4=Midnight Sun", "=ds=#h3#, #w4#"};
		{ 17, 50787, "", "=q4=Frost Giant's Cleaver", "=ds=#h1#, #w1#"};
		{ 18, 50794, "", "=q4=Neverending Winter", "=ds=#w8#"};
		Prev = "ICCLadyDeathwhisper";
		Next = "ICCSaurfang";
	};

	AtlasLoot_Data["ICCGunshipBattle25Man"] = {
		{ 1, 49998, "", "=q4=Shadowvault Slayer's Cloak", "=ds=#s4#"};
		{ 2, 50006, "", "=q4=Corp'rethar Ceremonial Crown", "=ds=#s1#, #a1#"};
		{ 3, 50011, "", "=q4=Gunship Captain's Mittens", "=ds=#s9#, #a1#"};
		{ 4, 50001, "", "=q4=Ikfirus's Sack of Wonder", "=ds=#s5#, #a2#"};
		{ 5, 50009, "", "=q4=Boots of Unnatural Growth", "=ds=#s12#, #a2#"};
		{ 6, 50000, "", "=q4=Scourge Hunter's Vambraces", "=ds=#s8#, #a3#"};
		{ 7, 50003, "", "=q4=Boneguard Commander's Pauldrons", "=ds=#s3#, #a4#"};
		{ 8, 50002, "", "=q4=Polar Bear Claw Bracers", "=ds=#s8#, #a4#"};
		{ 9, 50010, "", "=q4=Waistband of Righteous Fury", "=ds=#s10#, #a4#"};
		{ 11, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 12, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		{ 16, 50005, "", "=q4=Amulet of the Silent Eulogy", "=ds=#s2#"};
		{ 17, 50008, "", "=q4=Ring of Rapid Ascent", "=ds=#s13#"};
		{ 18, 49999, "", "=q4=Skeleton Lord's Circle", "=ds=#s13#"};
		{ 19, 50359, "", "=q4=Althor's Abacus", "=ds=#s14#"};
		{ 20, 50352, "", "=q4=Corpse Tongue Coin", "=ds=#s14#"};
		{ 22, 50411, "", "=q4=Scourgeborne Waraxe", "=ds=#h1#, #w1#"};
		Prev = "ICCLadyDeathwhisper25Man";
		Next = "ICCSaurfang25Man";
	};

	AtlasLoot_Data["ICCSaurfang"] = {
		{ 1, 50807, "", "=q4=Thaumaturge's Crackling Cowl", "=ds=#s1#, #a1#"};
		{ 2, 50804, "", "=q4=Icecrown Spire Sandals", "=ds=#s12#, #a1#"};
		{ 3, 50799, "", "=q4=Scourge Stranglers", "=ds=#s9#, #a2#"};
		{ 4, 50806, "", "=q4=Leggings of Unrelenting Blood", "=ds=#s11#, #a2#"};
		{ 5, 50800, "", "=q4=Hauberk of a Thousand Cuts", "=ds=#s5#, #a3#"};
		{ 6, 50801, "", "=q4=Blade-Scored Carapace", "=ds=#s5#, #a4#"};
		{ 7, 50802, "", "=q4=Gargoyle Spit Bracers", "=ds=#s8#, #a4#"};
		{ 8, 50808, "", "=q4=Deathforged Legplates", "=ds=#s11#, #a4#"};
		{ 16, 50809, "", "=q4=Soulcleave Pendant", "=ds=#s2#"};
		{ 17, 50803, "", "=q4=Saurfang's Cold-Forged Band", "=ds=#s13#"};
		{ 19, 50798, "", "=q4=Ramaladni's Blade of Culling", "=ds=#h2#, #w1#"};
		{ 20, 50805, "", "=q4=Mag'hari Chieftain's Staff", "=ds=#w9#"};
		Prev = "ICCGunshipBattle";
		Next = "ICCFestergut";
	};

	AtlasLoot_Data["ICCSaurfang25Man"] = {
		{ 1, 50014, "", "=q4=Greatcloak of the Turned Champion", "=ds=#s4#"};
		{ 2, 50333, "", "=q4=Toskk's Maximized Wristguards", "=ds=#s8#, #a2#"};
		{ 3, 50015, "", "=q4=Belt of the Blood Nova", "=ds=#s10#, #a3#"};
		{ 4, 50362, "", "=q4=Deathbringer's Will", "=ds=#s14#"};
		{ 5, 50412, "", "=q4=Bloodvenom Blade", "=ds=#h1#, #w10#"};
		{ 7, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 8, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		{ 16, 52027, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 17, 52026, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 18, 52025, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		Prev = "ICCGunshipBattle25Man";
		Next = "ICCFestergut25Man";
	};

		-----------------------
		--- The Plagueworks ---
		-----------------------

	AtlasLoot_Data["ICCFestergut"] = {
		{ 1, 50859, "", "=q4=Cloak of Many Skins", "=ds=#s4#"};
		{ 2, 50988, "", "=q4=Bloodstained Surgeon's Shoulderguards", "=ds=#s3#, #a1#"};
		{ 3, 50990, "", "=q4=Kilt of Untreated Wounds", "=ds=#s11#, #a1#"};
		{ 4, 50985, "", "=q4=Wrists of Septic Shock", "=ds=#s8#, #a2#"};
		{ 5, 50858, "", "=q4=Plague-Soaked Leather Leggings", "=ds=#s11#, #a2#"};
		{ 6, 50812, "", "=q4=Taldron's Long Neglected Boots", "=ds=#s12#, #a3#"};
		{ 7, 50967, "", "=q4=Festergut's Gaseous Gloves", "=ds=#s9#, #a4#"};
		{ 8, 50811, "", "=q4=Festering Fingerguards", "=ds=#s9#, #a4#"};
		{ 16, 50852, "", "=q4=Precious's Putrid Collar", "=ds=#s2#"};
		{ 17, 50986, "", "=q4=Signet of Putrefaction", "=ds=#s13#"};
		{ 19, 50810, "", "=q4=Gutbuster", "=ds=#h1#, #w6#"};
		{ 20, 50966, "", "=q4=Abracadaver", "=ds=#w9#"};
		Prev = "ICCSaurfang";
		Next = "ICCRotface";
	};

	AtlasLoot_Data["ICCFestergut25Man"] = {
		{ 1, 50063, "", "=q4=Lingering Illness", "=ds=#s10#, #a1#"};
		{ 2, 50056, "", "=q4=Plaguebringer's Stained Pants", "=ds=#s11#, #a1#"};
		{ 3, 50062, "", "=q4=Plague Scientist's Boots", "=ds=#s12#, #a1#"};
		{ 4, 50042, "", "=q4=Gangrenous Leggings", "=ds=#s11#, #a2#"};
		{ 5, 50041, "", "=q4=Leather of Stitched Scourge Parts", "=ds=#s11#, #a2#"};
		{ 6, 50059, "", "=q4=Horrific Flesh Epaulets", "=ds=#s3#, #a3#"};
		{ 7, 50038, "", "=q4=Carapace of Forgotten Kings", "=ds=#s5#, #a3#"};
		{ 8, 50064, "", "=q4=Unclean Surgical Gloves", "=ds=#s9#, #a3#"};
		{ 9, 50413, "", "=q4=Nerub'ar Stalker's Cord", "=ds=#s10#, #a3#"};
		{ 10, 50060, "", "=q4=Faceplate of the Forgotten", "=ds=#s1#, #a4#"};
		{ 11, 50037, "", "=q4=Fleshrending Gauntlets", "=ds=#s9#, #a4#"};
		{ 12, 50036, "", "=q4=Belt of Broken Bones", "=ds=#s10#, #a4#"};
		{ 16, 50061, "", "=q4=Holiday's Grace", "=ds=#s2#"};
		{ 17, 50414, "", "=q4=Might of Blight", "=ds=#s13#"};
		{ 19, 50035, "", "=q4=Black Bruise", "=ds=#h3#, #w13#"};
		{ 20, 50040, "", "=q4=Distant Land", "=ds=#w9#"};
		{ 22, 50226, "", "=q4=Festergut's Acidic Blood", "=ds=#m3#"};
		{ 24, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 25, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		Prev = "ICCSaurfang25Man";
		Next = "ICCRotface25Man";
	};

	AtlasLoot_Data["ICCRotface"] = {
		{ 1, 51007, "", "=q4=Ether-Soaked Bracers", "=ds=#s8#, #a1#"};
		{ 2, 51005, "", "=q4=Gloves of Broken Fingers", "=ds=#s9#, #a1#"};
		{ 3, 51009, "", "=q4=Chestguard of the Failed Experiment", "=ds=#s5#, #a2#"};
		{ 4, 51002, "", "=q4=Taldron's Short-Sighted Helm", "=ds=#s1#, #a3#"};
		{ 5, 51006, "", "=q4=Shuffling Shoes", "=ds=#s12#, #a3#"};
		{ 6, 51000, "", "=q4=Flesh-Shaper's Gurney Strap", "=ds=#s10#, #a4#"};
		{ 8, 51008, "", "=q4=Choker of Filthy Diamonds", "=ds=#s2#"};
		{ 9, 51001, "", "=q4=Rotface's Rupturing Ring", "=ds=#s13#"};
		{ 16, 51003, "", "=q4=Abomination Knuckles", "=ds=#h3#, #w13#"};
		{ 17, 51004, "", "=q4=Lockjaw", "=ds=#h3#, #w6#"};
		{ 18, 50998, "", "=q4=Shaft of Glacial Ice", "=ds=#w9#"};
		{ 19, 50999, "", "=q4=Gluth's Fetching Knife", "=ds=#w11#"};
		Prev = "ICCFestergut";
		Next = "ICCPutricide";
	};

	AtlasLoot_Data["ICCRotface25Man"] = {
		{ 1, 50019, "", "=q4=Winding Sheet", "=ds=#s4#"};
		{ 2, 50032, "", "=q4=Death Surgeon's Sleeves", "=ds=#s8#, #a1#"};
		{ 3, 50026, "", "=q4=Helm of the Elder Moon", "=ds=#s1#, #a2#"};
		{ 4, 50021, "", "=q4=Aldriana's Gloves of Secrecy", "=ds=#s9#, #a2#"};
		{ 5, 50022, "", "=q4=Dual-Bladed Pauldrons", "=ds=#s3#, #a3#"};
		{ 6, 50030, "", "=q4=Bloodsunder's Bracers", "=ds=#s8#, #a3#"};
		{ 7, 50020, "", "=q4=Raging Behemoth's Shoulderplates", "=ds=#s3#, #a4#"};
		{ 8, 50024, "", "=q4=Blightborne Warplate", "=ds=#s5#, #a4#"};
		{ 9, 50027, "", "=q4=Rot-Resistant Breastplate", "=ds=#s5#, #a4#"};
		{ 11, 50023, "", "=q4=Bile-Encrusted Medallion", "=ds=#s2#"};
		{ 12, 50025, "", "=q4=Seal of Many Mouths", "=ds=#s13#"};
		{ 13, 50353, "", "=q4=Dislodged Foreign Object", "=ds=#s14#"};
		{ 16, 50028, "", "=q4=Trauma", "=ds=#h3#, #w6#"};
		{ 17, 50016, "", "=q4=Rib Spreader", "=ds=#h1#, #w4#"};
		{ 18, 50033, "", "=q4=Corpse-Impaling Spike", "=ds=#w12#"};
		{ 20, 50231, "", "=q4=Rotface's Acidic Blood", "=ds=#m3#"};
		{ 22, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 23, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		Prev = "ICCFestergut25Man";
		Next = "ICCPutricide25Man";
	};

	AtlasLoot_Data["ICCPutricide"] = {
		{ 1, 51020, "", "=q4=Shoulders of Ruinous Senility", "=ds=#s3#, #a1#"};
		{ 2, 51017, "", "=q4=Cauterized Cord", "=ds=#s10#, #a1#"};
		{ 3, 51013, "", "=q4=Discarded Bag of Entrails", "=ds=#s1#, #a2#"};
		{ 4, 51015, "", "=q4=Shoulderpads of the Morbid Ritual", "=ds=#s3#, #a3#"};
		{ 5, 51019, "", "=q4=Rippling Flesh Kilt", "=ds=#s11#, #a3#"};
		{ 6, 51014, "", "=q4=Scalpel-Sharpening Shoulderguards", "=ds=#s3#, #a4#"};
		{ 7, 51018, "", "=q4=Chestplate of Septic Stitches", "=ds=#s5#, #a4#"};
		{ 16, 51012, "", "=q4=Infected Choker", "=ds=#s2#"};
		{ 17, 51016, "", "=q4=Pendant of Split Veins", "=ds=#s2#"};
		{ 18, 50341, "", "=q4=Unidentifiable Organ", "=ds=#s14#"};
		{ 20, 51011, "", "=q4=Flesh-Carving Scalpel", "=ds=#h1#, #w4#"};
		{ 21, 51010, "", "=q4=The Facelifter", "=ds=#h1#, #w10#"};
		Prev = "ICCRotface";
		Next = "ICCCouncil";
	};

	AtlasLoot_Data["ICCPutricide25Man"] = {
		{ 1, 50067, "", "=q4=Astrylian's Sutured Cinch", "=ds=#s10#, #a2#"};
		{ 2, 50069, "", "=q4=Professor's Bloodied Smock", "=ds=#s10#, #a2#"};
		{ 3, 50351, "", "=q4=Tiny Abomination in a Jar", "=ds=#s14#"};
		{ 4, 50179, "", "=q4=Last Word", "=ds=#h1#, #w6#"};
		{ 5, 50068, "", "=q4=Rigormortis", "=ds=#h1#, #w10#"};
		{ 7, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 8, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		{ 16, 52027, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 17, 52026, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 18, 52025, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		Prev = "ICCRotface25Man";
		Next = "ICCCouncil25Man";
	};

		------------------------
		--- The Crimson Hall ---
		------------------------
		
	AtlasLoot_Data["ICCCouncil"] = {
		{ 1, 51382, "", "=q4=Heartsick Mender's Cape", "=ds=#s4#"};
		{ 2, 51379, "", "=q4=Bloodsoul Raiment", "=ds=#s5#, #a1#"};
		{ 3, 51380, "", "=q4=Pale Corpse Boots", "=ds=#s12#, #a1#"};
		{ 4, 51023, "", "=q4=Taldaram's Soft Slippers", "=ds=#s12#, #a2#"};
		{ 5, 51325, "", "=q4=Blood-Drinker's Girdle", "=ds=#s10#, #a3#"};
		{ 6, 51383, "", "=q4=Spaulders of the Blood Princes", "=ds=#s3#, #a4#"};
		{ 7, 51025, "", "=q4=Battle-Maiden's Legguards", "=ds=#s11#, #a4#"};
		{ 9, 51381, "", "=q4=Cerise Coiled Ring", "=ds=#s13#"};
		{ 10, 51024, "", "=q4=Thrice Fanged Signet", "=ds=#s13#"};
		{ 16, 51021, "", "=q4=Soulbreaker", "=ds=#h1#, #w10#"};
		{ 17, 51022, "", "=q4=Hersir's Greatspear", "=ds=#w7#"};
		{ 18, 51326, "", "=q4=Wand of Ruby Claret", "=ds=#w12#"};
		Prev = "ICCPutricide";
		Next = "ICCLanathel";
	};

	AtlasLoot_Data["ICCCouncil25Man"] = {
		{ 1, 50074, "", "=q4=Royal Crimson Cloak", "=ds=#s4#"};
		{ 2, 50172, "", "=q4=Sanguine Silk Robes", "=ds=#s5#, #a1#"};
		{ 3, 50176, "", "=q4=San'layn Ritualist Gloves", "=ds=#s9#, #a1#"};
		{ 4, 50073, "", "=q4=Geistlord's Punishment Sack", "=ds=#s1#, #a2#"};
		{ 5, 50171, "", "=q4=Shoulders of Frost-Tipped Thorns", "=ds=#s3#, #a2#"};
		{ 6, 50177, "", "=q4=Mail of Crimson Coins", "=ds=#s5#, #a3#"};
		{ 7, 50071, "", "=q4=Treads of the Wasteland", "=ds=#s12#, #a3#"};
		{ 8, 50072, "", "=q4=Landsoul's Horned Greathelm", "=ds=#s1#, #a4#"};
		{ 9, 50175, "", "=q4=Crypt Keeper's Bracers", "=ds=#s8#, #a4#"};
		{ 10, 50075, "", "=q4=Taldaram's Plated Fists", "=ds=#s9#, #a4#"};
		{ 16, 50174, "", "=q4=Incarnadine Band of Mending", "=ds=#s13#"};
		{ 17, 50170, "", "=q4=Valanar's Other Signet Ring", "=ds=#s13#"};
		{ 18, 50173, "", "=q4=Shadow Silk Spindle", "=ds=#s15#"};
		{ 20, 50184, "", "=q4=Keleseth's Seducer", "=ds=#h4#, #w13#"};
		{ 21, 49919, "", "=q4=Cryptmaker", "=ds=#h2#, #w6#"};
		{ 23, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 24, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		Prev = "ICCPutricide25Man";
		Next = "ICCLanathel25Man";
	};

	AtlasLoot_Data["ICCLanathel"] = {
		{ 1, 51554, "", "=q4=Cowl of Malefic Repose", "=ds=#s1#, #a1#"};
		{ 2, 51552, "", "=q4=Shoulderpads of the Searing Kiss", "=ds=#s3#, #a2#"};
		{ 3, 51550, "", "=q4=Ivory-Inlaid Leggings", "=ds=#s11#, #a2#"};
		{ 4, 51551, "", "=q4=Chestguard of Siphoned Elements", "=ds=#s5#, #a3#"};
		{ 5, 51386, "", "=q4=Throatrender Handguards", "=ds=#s9#, #a4#"};
		{ 6, 51556, "", "=q4=Veincrusher Gauntlets", "=ds=#s9#, #a4#"};
		{ 7, 51555, "", "=q4=Tightening Waistband", "=ds=#s10#, #a4#"};
		{ 16, 51548, "", "=q4=Collar of Haughty Disdain", "=ds=#s2#"};
		{ 17, 51387, "", "=q4=Seal of the Twilight Queen", "=ds=#s13#"};
		{ 19, 51384, "", "=q4=Bloodsipper", "=ds=#h1#, #w4#"};
		{ 20, 51385, "", "=q4=Stakethrower", "=ds=#w5#"};
		{ 21, 51553, "", "=q4=Lana'thel's Bloody Nail", "=ds=#w12#"};
		Prev = "ICCCouncil";
		Next = "ICCValithria";
	};

	AtlasLoot_Data["ICCLanathel25Man"] = {
		{ 1, 50182, "", "=q4=Blood Queen's Crimson Choker", "=ds=#s2#"};
		{ 2, 50180, "", "=q4=Lana'thel's Chain of Flagellation", "=ds=#s2#"};
		{ 3, 50354, "", "=q4=Bauble of True Blood", "=ds=#s14#"};
		{ 4, 50178, "", "=q4=Bloodfall", "=ds=#w7#"};
		{ 5, 50181, "", "=q4=Dying Light", "=ds=#w9#"};
		{ 6, 50065, "", "=q4=Icecrown Glacial Wall", "=ds=#w8#"};
		{ 8, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 9, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		{ 16, 52027, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 17, 52026, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 18, 52025, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		Prev = "ICCCouncil25Man";
		Next = "ICCValithria25Man";
	};

		------------------------
		--- The Frozen Halls ---
		------------------------

	AtlasLoot_Data["ICCValithria"] = {
		{ 1, 51584, "", "=q4=Lich Wrappings", "=ds=#s4#"};
		{ 2, 51777, "", "=q4=Leggings of the Refracted Mind", "=ds=#s11#, #a1#"};
		{ 3, 51585, "", "=q4=Sister Svalna's Spangenhelm", "=ds=#s1#, #a2#"};
		{ 4, 51565, "", "=q4=Skinned Whelp Shoulders", "=ds=#s3#, #a2#"};
		{ 5, 51583, "", "=q4=Stormbringer Gloves", "=ds=#s9#, #a3#"};
		{ 6, 51566, "", "=q4=Legguards of the Twisted Dream", "=ds=#s11#, #a3#"};
		{ 7, 51586, "", "=q4=Emerald Saint's Spaulders", "=ds=#s3#, #a4#"};
		{ 8, 51563, "", "=q4=Taiga Bindings", "=ds=#s8#, #a4#"};
		{ 9, 51564, "", "=q4=Ironrope Belt of Ymirjar", "=ds=#s10#, #a4#"};
		{ 16, 51562, "", "=q4=Oxheart", "=ds=#h2#, #w6#"};
		{ 17, 51582, "", "=q4=Sister Svalna's Aether Staff", "=ds=#w9#"};
		{ 18, 51561, "", "=q4=Dreamhunter's Carbine", "=ds=#w5#"};
		Prev = "ICCLanathel";
		Next = "ICCSindragosa";
	};

	AtlasLoot_Data["ICCValithria25Man"] = {
		{ 1, 50205, "", "=q4=Frostbinder's Shredded Cape", "=ds=#s4#"};
		{ 2, 50418, "", "=q4=Robe of the Waking Nightmare", "=ds=#s5#, #a1#"};
		{ 3, 50417, "", "=q4=Bracers of Eternal Dreaming", "=ds=#s8#, #a2#"};
		{ 4, 50202, "", "=q4=Snowstorm Helm", "=ds=#s1#, #a3#"};
		{ 5, 50188, "", "=q4=Anub'ar Stalker's Gloves", "=ds=#s9#, #a3#"};
		{ 6, 50187, "", "=q4=Coldwraith Links", "=ds=#s10#, #a4#"};
		{ 7, 50199, "", "=q4=Leggings of Dying Candles", "=ds=#s11#, #a4#"};
		{ 8, 50192, "", "=q4=Scourge Reaver's Legplates", "=ds=#s11#, #a4#"};
		{ 9, 50416, "", "=q4=Boots of the Funeral March", "=ds=#s12#, #a4#"};
		{ 10, 50190, "", "=q4=Grinning Skull Greatboots", "=ds=#s12#, #a4#"};
		{ 16, 50195, "", "=q4=Noose of Malachite", "=ds=#s2#"};
		{ 17, 50185, "", "=q4=Devium's Eternally Cold Ring", "=ds=#s13#"};
		{ 18, 50186, "", "=q4=Frostbrood Sapphire Ring", "=ds=#s13#"};
		{ 20, 50183, "", "=q4=Lungbreaker", "=ds=#h1#, #w4#"};
		{ 21, 50472, "", "=q4=Nightmare Ender", "=ds=#w12#"};
		{ 23, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 24, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		Prev = "ICCLanathel25Man";
		Next = "ICCSindragosa25Man";
	};

	AtlasLoot_Data["ICCSindragosa"] = {
		{ 1, 51790, "", "=q4=Robes of Azure Downfall", "=ds=#s5#, #a1#"};
		{ 2, 51783, "", "=q4=Vambraces of the Frost Wyrm Queen", "=ds=#s8#, #a2#"};
		{ 3, 51789, "", "=q4=Icicle Shapers", "=ds=#s9#, #a2#"};
		{ 4, 51792, "", "=q4=Shoulderguards of Crystalline Bone", "=ds=#s3#, #a3#"};
		{ 5, 51785, "", "=q4=Wyrmwing Treads", "=ds=#s12#, #a3#"};
		{ 6, 51782, "", "=q4=Etched Dragonbone Girdle", "=ds=#s10#, #a4#"};
		{ 7, 51786, "", "=q4=Legplates of Aetheric Strife", "=ds=#s11#, #a4#"};
		{ 8, 51787, "", "=q4=Scourge Fanged Stompers", "=ds=#s12#, #a4#"};
		{ 10, 51026, "", "=q1=Crystalline Essence of Sindragosa", "=ds=#m3#"};
		{ 16, 51779, "", "=q4=Rimetooth Pendant", "=ds=#s2#"};
		{ 18, 51784, "", "=q4=Splintershard", "=ds=#h4#, #w13#"};
		{ 19, 51788, "", "=q4=Bleak Coldarra Carver", "=ds=#h3#, #w4#"};
		{ 20, 51791, "", "=q4=Lost Pavise of the Blue Flight", "=ds=#w8#"};
		Prev = "ICCValithria";
		Next = "ICCLichKing";
	};

	AtlasLoot_Data["ICCSindragosa25Man"] = {
		{ 1, 50421, "", "=q4=Sindragosa's Cruel Claw", "=ds=#s2#"};
		{ 2, 50424, "", "=q4=Memory of Malygos", "=ds=#s13#"};
		{ 3, 50360, "", "=q4=Phylactery of the Nameless Lich", "=ds=#s14#"};
		{ 4, 50361, "", "=q4=Sindragosa's Flawless Fang", "=ds=#s14#"};
		{ 5, 50423, "", "=q4=Sundial of Eternal Dusk", "=ds=#s15#"};
		{ 7, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 8, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		{ 9, 51026, "", "=q1=Crystalline Essence of Sindragosa", "=ds=#m3#"};
		{ 16, 52027, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 17, 52026, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 18, 52025, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		Prev = "ICCValithria25Man";
		Next = "ICCLichKing25Man";
	};

		-------------------------
		--- The Frozen Throne ---
		-------------------------

	AtlasLoot_Data["ICCLichKing"] = {
		{ 1, 51801, "", "=q4=Pugius, Fist of Defiance", "=ds=#h3#, #w13#"};
		{ 2, 51803, "", "=q4=Tel'thas, Dagger of the Blood King", "=ds=#h3#, #w4#"};
		{ 3, 51800, "", "=q4=Stormfury, Black Blade of the Betrayer", "=ds=#h1#, #w4#"};
		{ 4, 51795, "", "=q4=Troggbane, Axe of the Frostborne King", "=ds=#h1#, #w1#"};
		{ 5, 51798, "", "=q4=Valius, Gavel of the Lightbringer", "=ds=#h3#, #w6#"};
		{ 6, 51796, "", "=q4=Warmace of Menethil", "=ds=#h2#, #w6#"};
		{ 7, 51799, "", "=q4=Halion, Staff of Forgotten Love", "=ds=#w9#"};
		{ 8, 51797, "", "=q4=Tainted Twig of Nordrassil", "=ds=#w9#"};
		{ 9, 51802, "", "=q4=Windrunner's Heartseeker", "=ds=#w3#"};
		Prev = "ICCSindragosa";
		Next = "ICCTrash25Man";
	};

	AtlasLoot_Data["ICCLichKing25Man"] = {
		{ 1, 50426, "", "=q4=Heaven's Fall, Kryss of a Thousand Lies", "=ds=#h1#, #w4#"};
		{ 2, 50427, "", "=q4=Bloodsurge, Kel'Thuzad's Blade of Agony", "=ds=#h3#, #w10#"};
		{ 3, 50070, "", "=q4=Glorenzelg, High-Blade of the Silver Hand", "=ds=#h2#, #w10#"};
		{ 4, 50012, "", "=q4=Havoc's Call, Blade of Lordaeron Kings", "=ds=#h1#, #w1#"};
		{ 5, 50428, "", "=q4=Royal Scepter of Terenas II", "=ds=#h3#, #w6#"};
		{ 6, 49997, "", "=q4=Mithrios, Bronzebeard's Legacy", "=ds=#h1#, #w6#"};
		{ 7, 50425, "", "=q4=Oathbinder, Charge of the Ranger-General", "=ds=#w7#"};
		{ 8, 50429, "", "=q4=Archus, Greatstaff of Antonidas", "=ds=#w9#"};
		{ 9, 49981, "", "=q4=Fal'inrush, Defender of Quel'thalas", "=ds=#w3#"};
		{ 16, 52027, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 17, 52026, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 18, 52025, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		{ 20, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 21, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		Prev = "ICCSindragosa25Man";
		Next = "ICCTrash25Man";
	};

	AtlasLoot_Data["ICCTrash25Man"] = {
		{ 1, 50449, "", "=q4=Stiffened Corpse Shoulderpads", "=ds=#s3#, #a1#"};
		{ 2, 50450, "", "=q4=Leggings of Dubious Charms", "=ds=#s11#, #a3#"};
		{ 3, 50451, "", "=q4=Belt of the Lonely Noble", "=ds=#s10#, #a4#"};
		{ 4, 50452, "", "=q4=Wodin's Lucky Necklace", "=ds=#s2#"};
		{ 5, 50447, "", "=q4=Harbinger's Bone Band", "=ds=#s13#"};
		{ 6, 50453, "", "=q4=Ring of Rotting Sinew", "=ds=#s13#"};
		{ 7, 50444, "", "=q4=Rowan's Rifle of Silver Bullets", "=ds=#w5#"};
		Prev = "ICCLichKing";
	};

		-------------------------------
		--- Icecrown Citadel HEROIC ---
		-------------------------------

		-------------------
		--- Lower Spire ---
		-------------------

	AtlasLoot_Data["ICCLordMarrowgarHEROIC"] = {
		{ 1, 51933, "", "=q4=Shawl of Nerubian Silk", "=ds=#s4#"};
		{ 2, 51930, "", "=q4=Cord of the Patronizing Practitioner", "=ds=#s10#, #a1#"};
		{ 3, 51929, "", "=q4=Coldwraith Bracers", "=ds=#s8#, #a3#"};
		{ 4, 51935, "", "=q4=Linked Scourge Vertebrae", "=ds=#s10#, #a3#"};
		{ 5, 51928, "", "=q4=Corrupted Silverplate Leggings", "=ds=#s11#, #a4#"};
		{ 6, 51931, "", "=q4=Ancient Skeletal Boots", "=ds=#s12#, #a4#"};
		{ 8, 51934, "", "=q4=Marrowgar's Scratching Choker", "=ds=#s2#"};
		{ 9, 50346, "", "=q4=Sliver of Pure Ice", "=ds=#s14#"};
		{ 16, 51932, "", "=q4=Frost Needle", "=ds=#h3#, #w10#"};
		{ 17, 51936, "", "=q4=Citadel Enforcer's Claymore", "=ds=#h2#, #w10#"};
		{ 18, 51938, "", "=q4=Bone Warden's Splitter", "=ds=#h1#, #w1#"};
		{ 19, 51937, "", "=q4=Bonebreaker Scepter", "=ds=#h1#, #w6#"};
		Next = "ICCLadyDeathwhisperHEROIC";
	};

	AtlasLoot_Data["ICCLordMarrowgar25ManHEROIC"] = {
		{ 1, 50613, "", "=q4=Crushing Coldwraith Belt", "=ds=#s10#, #a1#"};
		{ 2, 50615, "", "=q4=Handguards of Winter's Respite", "=ds=#s9#, #a2#"};
		{ 3, 50607, "", "=q4=Frostbitten Fur Boots", "=ds=#s12#, #a2#"};
		{ 4, 50605, "", "=q4=Snowserpent Mail Helm", "=ds=#s1#, #a3#"};
		{ 5, 50617, "", "=q4=Rusted Bonespike Pauldrons", "=ds=#s3#, #a4#"};
		{ 6, 50606, "", "=q4=Gendarme's Cuirass", "=ds=#s5#, #a4#"};
		{ 7, 50611, "", "=q4=Bracers of Dark Reckoning", "=ds=#s8#, #a4#"};
		{ 8, 50612, "", "=q4=Legguards of Lost Hope", "=ds=#s11#, #a4#"};
		{ 10, 50609, "", "=q4=Bone Sentinel's Amulet", "=ds=#s2#"};
		{ 11, 50604, "", "=q4=Band of the Bone Colossus", "=ds=#s13#"};
		{ 12, 50614, "", "=q4=Loop of the Endless Labyrinth", "=ds=#s13#"};
		{ 13, 50610, "", "=q4=Marrowgar's Frigid Eye", "=ds=#s13#"};
		{ 16, 50608, "", "=q4=Frozen Bonespike", "=ds=#h3#, #w4#"};
		{ 17, 50709, "", "=q4=Bryntroll, the Bone Arbiter", "=ds=#h2#, #w1#"};
		{ 18, 50616, "", "=q4=Bulwark of Smouldering Steel", "=ds=#w8#"};
		{ 20, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 21, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		Next = "ICCLadyDeathwhisper25ManHEROIC";
	};

	AtlasLoot_Data["ICCLadyDeathwhisperHEROIC"] = {
		{ 1, 51918, "", "=q4=Bracers of Dark Blessings", "=ds=#s8#, #a1#"};
		{ 2, 51921, "", "=q4=Sister's Handshrouds", "=ds=#s9#, #a1#"};
		{ 3, 51923, "", "=q4=Chestguard of the Frigid Noose", "=ds=#s5#, #a2#"};
		{ 4, 51925, "", "=q4=Soulthief's Braided Belt", "=ds=#s10#, #a2#"};
		{ 5, 51920, "", "=q4=Boots of the Frozen Seed", "=ds=#s12#, #a2#"};
		{ 6, 51926, "", "=q4=Handgrips of Frost and Sleet", "=ds=#s9#, #a3#"};
		{ 7, 51919, "", "=q4=Deathspeaker Disciple's Belt", "=ds=#s10#, #a3#"};
		{ 8, 51924, "", "=q4=Deathspeaker Zealot's Helm", "=ds=#s1#, #a4#"};
		{ 9, 51917, "", "=q4=Ghoul Commander's Cuirass", "=ds=#s5#, #a4#"};
		{ 16, 50343, "", "=q4=Whispering Fanged Skull", "=ds=#s14#"};
		{ 17, 51922, "", "=q4=Scourgelord's Baton", "=ds=#s15#"};
		{ 19, 51927, "", "=q4=Njordnar Bone Bow", "=ds=#w2#"};
		Prev = "ICCLordMarrowgarHEROIC";
		Next = "ICCGunshipBattleHEROIC";
	};

	AtlasLoot_Data["ICCLadyDeathwhisper25ManHEROIC"] = {
		{ 1, 50643, "", "=q4=Shoulders of Mercy Killing", "=ds=#s3#, #a1#"};
		{ 2, 50651, "", "=q4=The Lady's Brittle Bracers", "=ds=#s8#, #a1#"};
		{ 3, 50646, "", "=q4=Cultist's Bloodsoaked Spaulders", "=ds=#s3#, #a2#"};
		{ 4, 50649, "", "=q4=Deathwhisper Chestpiece", "=ds=#s5#, #a2#"};
		{ 5, 50645, "", "=q4=Leggings of Northern Lights", "=ds=#s11#, #a3#"};
		{ 6, 50652, "", "=q4=Necrophotic Greaves", "=ds=#s12#, #a3#"};
		{ 7, 50640, "", "=q4=Broken Ram Skull Helm", "=ds=#s1#, #a4#"};
		{ 8, 50650, "", "=q4=Fallen Lord's Handguards", "=ds=#s9#, #a4#"};
		{ 9, 50639, "", "=q4=Blood-Soaked Saronite Stompers", "=ds=#s12#, #a4#"};
		{ 11, 50647, "", "=q4=Ahn'kahar Onyx Neckguard", "=ds=#s2#"};
		{ 12, 50642, "", "=q4=Juggernaut Band", "=ds=#s13#"};
		{ 13, 50644, "", "=q4=Ring of Maddening Whispers", "=ds=#s13#"};
		{ 16, 50641, "", "=q4=Heartpierce", "=ds=#h1#, #w4#"};
		{ 17, 50648, "", "=q4=Nibelung", "=ds=#w9#"};
		{ 18, 50638, "", "=q4=Zod's Repeating Longbow", "=ds=#w2#"};
		{ 20, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 21, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		Prev = "ICCLordMarrowgar25ManHEROIC";
		Next = "ICCGunshipBattle25ManHEROIC";
	};

	AtlasLoot_Data["ICCGunshipBattleHEROIC"] = {
		{ 1, 51912, "", "=q4=Saronite Gargoyle Cloak", "=ds=#s4#"};
		{ 2, 51908, "", "=q4=Cord of Dark Suffering", "=ds=#s10#, #a2#"};
		{ 3, 51906, "", "=q4=Ice-Reinforced Vrykul Helm", "=ds=#s1#, #a3#"};
		{ 4, 51911, "", "=q4=Pauldrons of Lost Hope", "=ds=#s3#, #a3#"};
		{ 5, 51914, "", "=q4=Icecrown Rampart Bracers", "=ds=#s8#, #a3#"};
		{ 6, 51907, "", "=q4=Bracers of Pale Illumination", "=ds=#s8#, #a4#"};
		{ 7, 51915, "", "=q4=Bone Drake's Enameled Boots", "=ds=#s12#, #a4#"};
		{ 9, 51913, "", "=q4=Abomination's Bloody Ring", "=ds=#s13#"};
		{ 10, 50345, "", "=q4=Muradin's Spyglass", "=ds=#s14#"};
		{ 16, 51910, "", "=q4=Midnight Sun", "=ds=#h3#, #w4#"};
		{ 17, 51916, "", "=q4=Frost Giant's Cleaver", "=ds=#h1#, #w1#"};
		{ 18, 51909, "", "=q4=Neverending Winter", "=ds=#w8#"};
		Prev = "ICCLadyDeathwhisperHEROIC";
		Next = "ICCSaurfangHEROIC";
	};

	AtlasLoot_Data["ICCGunshipBattle25ManHEROIC"] = {
		{ 1, 50653, "", "=q4=Shadowvault Slayer's Cloak", "=ds=#s4#"};
		{ 2, 50661, "", "=q4=Corp'rethar Ceremonial Crown", "=ds=#s1#, #a1#"};
		{ 3, 50663, "", "=q4=Gunship Captain's Mittens", "=ds=#s9#, #a1#"};
		{ 4, 50656, "", "=q4=Ikfirus's Sack of Wonder", "=ds=#s5#, #a2#"};
		{ 5, 50665, "", "=q4=Boots of Unnatural Growth", "=ds=#s12#, #a2#"};
		{ 6, 50655, "", "=q4=Scourge Hunter's Vambraces", "=ds=#s8#, #a3#"};
		{ 7, 50660, "", "=q4=Boneguard Commander's Pauldrons", "=ds=#s3#, #a4#"};
		{ 8, 50659, "", "=q4=Polar Bear Claw Bracers", "=ds=#s8#, #a4#"};
		{ 9, 50667, "", "=q4=Waistband of Righteous Fury", "=ds=#s10#, #a4#"};
		{ 11, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 12, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		{ 16, 50658, "", "=q4=Amulet of the Silent Eulogy", "=ds=#s2#"};
		{ 17, 50664, "", "=q4=Ring of Rapid Ascent", "=ds=#s13#"};
		{ 18, 50657, "", "=q4=Skeleton Lord's Circle", "=ds=#s13#"};
		{ 19, 50366, "", "=q4=Althor's Abacus", "=ds=#s14#"};
		{ 20, 50349, "", "=q4=Corpse Tongue Coin", "=ds=#s14#"};
		{ 22, 50654, "", "=q4=Scourgeborne Waraxe", "=ds=#h1#, #w1#"};
		Prev = "ICCLadyDeathwhisper25ManHEROIC";
		Next = "ICCSaurfang25ManHEROIC";
	};

	AtlasLoot_Data["ICCSaurfangHEROIC"] = {
		{ 1, 51896, "", "=q4=Thaumaturge's Crackling Cowl", "=ds=#s1#, #a1#"};
		{ 2, 51899, "", "=q4=Icecrown Spire Sandals", "=ds=#s12#, #a1#"};
		{ 3, 51904, "", "=q4=Scourge Stranglers", "=ds=#s9#, #a2#"};
		{ 4, 51897, "", "=q4=Leggings of Unrelenting Blood", "=ds=#s11#, #a2#"};
		{ 5, 51903, "", "=q4=Hauberk of a Thousand Cuts", "=ds=#s5#, #a3#"};
		{ 6, 51902, "", "=q4=Blade-Scored Carapace", "=ds=#s5#, #a4#"};
		{ 7, 51901, "", "=q4=Gargoyle Spit Bracers", "=ds=#s8#, #a4#"};
		{ 8, 51895, "", "=q4=Deathforged Legplates", "=ds=#s11#, #a4#"};
		{ 10, 51894, "", "=q4=Soulcleave Pendant", "=ds=#s2#"};
		{ 11, 51900, "", "=q4=Saurfang's Cold-Forged Band", "=ds=#s13#"};
		{ 16, 52027, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 17, 52026, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 18, 52025, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		{ 20, 51905, "", "=q4=Ramaladni's Blade of Culling", "=ds=#h2#, #w1#"};
		{ 21, 51898, "", "=q4=Mag'hari Chieftain's Staff", "=ds=#w9#"};
		Prev = "ICCGunshipBattleHEROIC";
		Next = "ICCFestergutHEROIC";
	};

	AtlasLoot_Data["ICCSaurfang25ManHEROIC"] = {
		{ 1, 50668, "", "=q4=Greatcloak of the Turned Champion", "=ds=#s4#"};
		{ 2, 50670, "", "=q4=Toskk's Maximized Wristguards", "=ds=#s8#, #a2#"};
		{ 3, 50671, "", "=q4=Belt of the Blood Nova", "=ds=#s10#, #a3#"};
		{ 4, 50363, "", "=q4=Deathbringer's Will", "=ds=#s14#"};
		{ 5, 50672, "", "=q4=Bloodvenom Blade", "=ds=#h1#, #w10#"};
		{ 7, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 8, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		{ 16, 52030, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 17, 52029, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 18, 52028, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		{ 20, 52027, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 21, 52026, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 22, 52025, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		Prev = "ICCGunshipBattle25ManHEROIC";
		Next = "ICCFestergut25ManHEROIC";
	};

		-----------------------
		--- The Plagueworks ---
		-----------------------

	AtlasLoot_Data["ICCFestergutHEROIC"] = {
		{ 1, 51888, "", "=q4=Cloak of Many Skins", "=ds=#s4#"};
		{ 2, 51883, "", "=q4=Bloodstained Surgeon's Shoulderguards", "=ds=#s3#, #a1#"};
		{ 3, 51882, "", "=q4=Kilt of Untreated Wounds", "=ds=#s11#, #a1#"};
		{ 4, 51885, "", "=q4=Wrists of Septic Shock", "=ds=#s8#, #a2#"};
		{ 5, 51889, "", "=q4=Plague-Soaked Leather Leggings", "=ds=#s11#, #a2#"};
		{ 6, 51891, "", "=q4=Taldron's Long Neglected Boots", "=ds=#s12#, #a3#"};
		{ 7, 51886, "", "=q4=Festergut's Gaseous Gloves", "=ds=#s9#, #a4#"};
		{ 8, 51892, "", "=q4=Festering Fingerguards", "=ds=#s9#, #a4#"};
		{ 16, 51890, "", "=q4=Precious's Putrid Collar", "=ds=#s2#"};
		{ 17, 51884, "", "=q4=Signet of Putrefaction", "=ds=#s13#"};
		{ 19, 51893, "", "=q4=Gutbuster", "=ds=#h1#, #w6#"};
		{ 20, 51887, "", "=q4=Abracadaver", "=ds=#w9#"};
		Prev = "ICCSaurfangHEROIC";
		Next = "ICCRotfaceHEROIC";
	};

	AtlasLoot_Data["ICCFestergut25ManHEROIC"] = {
		{ 1, 50702, "", "=q4=Lingering Illness", "=ds=#s10#, #a1#"};
		{ 2, 50694, "", "=q4=Plaguebringer's Stained Pants", "=ds=#s11#, #a1#"};
		{ 3, 50699, "", "=q4=Plague Scientist's Boots", "=ds=#s12#, #a1#"};
		{ 4, 50697, "", "=q4=Gangrenous Leggings", "=ds=#s11#, #a2#"};
		{ 5, 50696, "", "=q4=Leather of Stitched Scourge Parts", "=ds=#s11#, #a2#"};
		{ 6, 50698, "", "=q4=Horrific Flesh Epaulets", "=ds=#s3#, #a3#"};
		{ 7, 50689, "", "=q4=Carapace of Forgotten Kings", "=ds=#s5#, #a3#"};
		{ 8, 50703, "", "=q4=Unclean Surgical Gloves", "=ds=#s9#, #a3#"};
		{ 9, 50688, "", "=q4=Nerub'ar Stalker's Cord", "=ds=#s10#, #a3#"};
		{ 10, 50701, "", "=q4=Faceplate of the Forgotten", "=ds=#s1#, #a4#"};
		{ 11, 50690, "", "=q4=Fleshrending Gauntlets", "=ds=#s9#, #a4#"};
		{ 12, 50691, "", "=q4=Belt of Broken Bones", "=ds=#s10#, #a4#"};
		{ 16, 50700, "", "=q4=Holiday's Grace", "=ds=#s2#"};
		{ 17, 50693, "", "=q4=Might of Blight", "=ds=#s13#"};
		{ 19, 50692, "", "=q4=Black Bruise", "=ds=#h3#, #w13#"};
		{ 20, 50695, "", "=q4=Distant Land", "=ds=#w9#"};
		{ 22, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 23, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		Prev = "ICCSaurfang25ManHEROIC";
		Next = "ICCRotface25ManHEROIC";
	};

	AtlasLoot_Data["ICCRotfaceHEROIC"] = {
		{ 1, 51872, "", "=q4=Ether-Soaked Bracers", "=ds=#s8#, #a1#"};
		{ 2, 51874, "", "=q4=Gloves of Broken Fingers", "=ds=#s9#, #a1#"};
		{ 3, 51870, "", "=q4=Chestguard of the Failed Experiment", "=ds=#s5#, #a2#"};
		{ 4, 51877, "", "=q4=Taldron's Short-Sighted Helm", "=ds=#s1#, #a3#"};
		{ 5, 51873, "", "=q4=Shuffling Shoes", "=ds=#s12#, #a3#"};
		{ 6, 51879, "", "=q4=Flesh-Shaper's Gurney Strap", "=ds=#s10#, #a4#"};
		{ 8, 51871, "", "=q4=Choker of Filthy Diamonds", "=ds=#s2#"};
		{ 9, 51878, "", "=q4=Rotface's Rupturing Ring", "=ds=#s13#"};
		{ 16, 51876, "", "=q4=Abomination Knuckles", "=ds=#h3#, #w13#"};
		{ 17, 51875, "", "=q4=Lockjaw", "=ds=#h3#, #w6#"};
		{ 18, 51881, "", "=q4=Shaft of Glacial Ice", "=ds=#w9#"};
		{ 19, 51880, "", "=q4=Gluth's Fetching Knife", "=ds=#w11#"};
		Prev = "ICCFestergutHEROIC";
		Next = "ICCPutricideHEROIC";
	};

	AtlasLoot_Data["ICCRotface25ManHEROIC"] = {
		{ 1, 50677, "", "=q4=Winding Sheet", "=ds=#s4#"};
		{ 2, 50686, "", "=q4=Death Surgeon's Sleeves", "=ds=#s8#, #a1#"};
		{ 3, 50679, "", "=q4=Helm of the Elder Moon", "=ds=#s1#, #a2#"};
		{ 4, 50675, "", "=q4=Aldriana's Gloves of Secrecy", "=ds=#s9#, #a2#"};
		{ 5, 50673, "", "=q4=Dual-Bladed Pauldrons", "=ds=#s3#, #a3#"};
		{ 6, 50687, "", "=q4=Bloodsunder's Bracers", "=ds=#s8#, #a3#"};
		{ 7, 50674, "", "=q4=Raging Behemoth's Shoulderplates", "=ds=#s3#, #a4#"};
		{ 8, 50681, "", "=q4=Blightborne Warplate", "=ds=#s5#, #a4#"};
		{ 9, 50680, "", "=q4=Rot-Resistant Breastplate", "=ds=#s5#, #a4#"};
		{ 11, 50682, "", "=q4=Bile-Encrusted Medallion", "=ds=#s2#"};
		{ 12, 50678, "", "=q4=Seal of Many Mouths", "=ds=#s13#"};
		{ 13, 50348, "", "=q4=Dislodged Foreign Object", "=ds=#s14#"};
		{ 16, 50685, "", "=q4=Trauma", "=ds=#h3#, #w6#"};
		{ 17, 50676, "", "=q4=Rib Spreader", "=ds=#h1#, #w4#"};
		{ 18, 50684, "", "=q4=Corpse-Impaling Spike", "=ds=#w12#"};
		{ 20, 50231, "", "=q4=Rotface's Acidic Blood", "=ds=#m3#"};
		{ 22, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 23, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		Prev = "ICCFestergut25ManHEROIC";
		Next = "ICCPutricide25ManHEROIC";
	};

	AtlasLoot_Data["ICCPutricideHEROIC"] = {
		{ 1, 51859, "", "=q4=Shoulders of Ruinous Senility", "=ds=#s3#, #a1#"};
		{ 2, 51862, "", "=q4=Cauterized Cord", "=ds=#s10#, #a1#"};
		{ 3, 51866, "", "=q4=Discarded Bag of Entrails", "=ds=#s1#, #a2#"};
		{ 4, 51864, "", "=q4=Shoulderpads of the Morbid Ritual", "=ds=#s3#, #a3#"};
		{ 5, 51860, "", "=q4=Rippling Flesh Kilt", "=ds=#s11#, #a3#"};
		{ 6, 51865, "", "=q4=Scalpel-Sharpening Shoulderguards", "=ds=#s3#, #a4#"};
		{ 7, 51861, "", "=q4=Chestplate of Septic Stitches", "=ds=#s5#, #a4#"};
		{ 9, 51867, "", "=q4=Infected Choker", "=ds=#s2#"};
		{ 10, 51863, "", "=q4=Pendant of Split Veins", "=ds=#s2#"};
		{ 11, 50344, "", "=q4=Unidentifiable Organ", "=ds=#s14#"};
		{ 16, 52027, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 17, 52026, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 18, 52025, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		{ 20, 51868, "", "=q4=Flesh-Carving Scalpel", "=ds=#h1#, #w4#"};
		{ 21, 51869, "", "=q4=The Facelifter", "=ds=#h1#, #w10#"};
		Prev = "ICCRotfaceHEROIC";
		Next = "ICCCouncilHEROIC";
	};

	AtlasLoot_Data["ICCPutricide25ManHEROIC"] = {
		{ 1, 50707, "", "=q4=Astrylian's Sutured Cinch", "=ds=#s10#, #a2#"};
		{ 2, 50705, "", "=q4=Professor's Bloodied Smock", "=ds=#s10#, #a2#"};
		{ 3, 50706, "", "=q4=Tiny Abomination in a Jar", "=ds=#s14#"};
		{ 4, 50708, "", "=q4=Last Word", "=ds=#h1#, #w6#"};
		{ 5, 50704, "", "=q4=Rigormortis", "=ds=#h1#, #w10#"};
		{ 7, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 8, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		{ 16, 52030, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 17, 52029, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 18, 52028, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		{ 20, 52027, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 21, 52026, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 22, 52025, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		Prev = "ICCRotface25ManHEROIC";
		Next = "ICCCouncil25ManHEROIC";
	};

		------------------------
		--- The Crimson Hall ---
		------------------------
		
	AtlasLoot_Data["ICCCouncilHEROIC"] = {
		{ 1, 51848, "", "=q4=Heartsick Mender's Cape", "=ds=#s4#"};
		{ 2, 51851, "", "=q4=Bloodsoul Raiment", "=ds=#s5#, #a1#"};
		{ 3, 51850, "", "=q4=Pale Corpse Boots", "=ds=#s12#, #a1#"};
		{ 4, 51856, "", "=q4=Taldaram's Soft Slippers", "=ds=#s12#, #a2#"};
		{ 5, 51853, "", "=q4=Blood-Drinker's Girdle", "=ds=#s10#, #a3#"};
		{ 6, 51847, "", "=q4=Spaulders of the Blood Princes", "=ds=#s3#, #a4#"};
		{ 7, 51854, "", "=q4=Battle-Maiden's Legguards", "=ds=#s11#, #a4#"};
		{ 9, 51849, "", "=q4=Cerise Coiled Ring", "=ds=#s13#"};
		{ 10, 51855, "", "=q4=Thrice Fanged Signet", "=ds=#s13#"};
		{ 16, 51858, "", "=q4=Soulbreaker", "=ds=#h1#, #w10#"};
		{ 17, 51857, "", "=q4=Hersir's Greatspear", "=ds=#w7#"};
		{ 18, 51852, "", "=q4=Wand of Ruby Claret", "=ds=#w12#"};
		Prev = "ICCPutricideHEROIC";
		Next = "ICCLanathelHEROIC";
	};

	AtlasLoot_Data["ICCCouncil25ManHEROIC"] = {
		{ 1, 50718, "", "=q4=Royal Crimson Cloak", "=ds=#s4#"};
		{ 2, 50717, "", "=q4=Sanguine Silk Robes", "=ds=#s5#, #a1#"};
		{ 3, 50722, "", "=q4=San'layn Ritualist Gloves", "=ds=#s9#, #a1#"};
		{ 4, 50713, "", "=q4=Geistlord's Punishment Sack", "=ds=#s1#, #a2#"};
		{ 5, 50715, "", "=q4=Shoulders of Frost-Tipped Thorns", "=ds=#s3#, #a2#"};
		{ 6, 50723, "", "=q4=Mail of Crimson Coins", "=ds=#s5#, #a3#"};
		{ 7, 50711, "", "=q4=Treads of the Wasteland", "=ds=#s12#, #a3#"};
		{ 8, 50712, "", "=q4=Landsoul's Horned Greathelm", "=ds=#s1#, #a4#"};
		{ 9, 50716, "", "=q4=Taldaram's Plated Fists", "=ds=#s9#, #a4#"};
		{ 10, 50721, "", "=q4=Crypt Keeper's Bracers", "=ds=#s8#, #a4#"};
		{ 16, 50720, "", "=q4=Incarnadine Band of Mending", "=ds=#s13#"};
		{ 17, 50714, "", "=q4=Valanar's Other Signet Ring", "=ds=#s13#"};
		{ 18, 50719, "", "=q4=Shadow Silk Spindle", "=ds=#s15#"};
		{ 20, 50710, "", "=q4=Keleseth's Seducer", "=ds=#h4#, #w13#"};
		{ 21, 50603, "", "=q4=Cryptmaker", "=ds=#h2#, #w6#"};
		{ 23, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 24, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		Prev = "ICCPutricide25ManHEROIC";
		Next = "ICCLanathel25ManHEROIC";
	};

	AtlasLoot_Data["ICCLanathelHEROIC"] = {
		{ 1, 51837, "", "=q4=Cowl of Malefic Repose", "=ds=#s1#, #a1#"};
		{ 2, 51839, "", "=q4=Shoulderpads of the Searing Kiss", "=ds=#s3#, #a2#"};
		{ 3, 51841, "", "=q4=Ivory-Inlaid Leggings", "=ds=#s11#, #a2#"};
		{ 4, 51840, "", "=q4=Chestguard of Siphoned Elements", "=ds=#s5#, #a3#"};
		{ 5, 51844, "", "=q4=Throatrender Handguards", "=ds=#s9#, #a4#"};
		{ 6, 51835, "", "=q4=Veincrusher Gauntlets", "=ds=#s9#, #a4#"};
		{ 7, 51836, "", "=q4=Tightening Waistband", "=ds=#s10#, #a4#"};
		{ 9, 51842, "", "=q4=Collar of Haughty Disdain", "=ds=#s2#"};
		{ 10, 51843, "", "=q4=Seal of the Twilight Queen", "=ds=#s13#"};
		{ 16, 52027, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 17, 52026, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 18, 52025, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		{ 20, 51846, "", "=q4=Bloodsipper", "=ds=#h1#, #w4#"};
		{ 21, 51845, "", "=q4=Stakethrower", "=ds=#w5#"};
		{ 22, 51838, "", "=q4=Lana'thel's Bloody Nail", "=ds=#w12#"};
		Prev = "ICCCouncilHEROIC";
		Next = "ICCValithriaHEROIC";
	};

	AtlasLoot_Data["ICCLanathel25ManHEROIC"] = {
		{ 1, 50724, "", "=q4=Blood Queen's Crimson Choker", "=ds=#s2#"};
		{ 2, 50728, "", "=q4=Lana'thel's Chain of Flagellation", "=ds=#s2#"};
		{ 3, 50726, "", "=q4=Bauble of True Blood", "=ds=#s14#"};
		{ 4, 50727, "", "=q4=Bloodfall", "=ds=#w7#"};
		{ 5, 50725, "", "=q4=Dying Light", "=ds=#w9#"};
		{ 6, 50729, "", "=q4=Icecrown Glacial Wall", "=ds=#w8#"};
		{ 8, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 9, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		{ 16, 52030, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 17, 52029, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 18, 52028, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		{ 20, 52027, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 21, 52026, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 22, 52025, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		Prev = "ICCCouncil25ManHEROIC";
		Next = "ICCValithria25ManHEROIC";
	};

		------------------------
		--- The Frozen Halls ---
		------------------------

	AtlasLoot_Data["ICCValithriaHEROIC"] = {
		{ 1, 51826, "", "=q4=Lich Wrappings", "=ds=#s4#"};
		{ 2, 51823, "", "=q4=Leggings of the Refracted Mind", "=ds=#s11#, #a1#"};
		{ 3, 51825, "", "=q4=Sister Svalna's Spangenhelm", "=ds=#s1#, #a2#"};
		{ 4, 51830, "", "=q4=Skinned Whelp Shoulders", "=ds=#s3#, #a2#"};
		{ 5, 51827, "", "=q4=Stormbringer Gloves", "=ds=#s9#, #a3#"};
		{ 6, 51829, "", "=q4=Legguards of the Twisted Dream", "=ds=#s11#, #a3#"};
		{ 7, 51824, "", "=q4=Emerald Saint's Spaulders", "=ds=#s3#, #a4#"};
		{ 8, 51832, "", "=q4=Taiga Bindings", "=ds=#s8#, #a4#"};
		{ 9, 51831, "", "=q4=Ironrope Belt of Ymirjar", "=ds=#s10#, #a4#"};
		{ 16, 51833, "", "=q4=Oxheart", "=ds=#h2#, #w6#"};
		{ 17, 51828, "", "=q4=Sister Svalna's Aether Staff", "=ds=#w9#"};
		{ 18, 51834, "", "=q4=Dreamhunter's Carbine", "=ds=#w5#"};
		Prev = "ICCLanathelHEROIC";
		Next = "ICCSindragosaHEROIC";
	};

	AtlasLoot_Data["ICCValithria25ManHEROIC"] = {
		{ 1, 50628, "", "=q4=Frostbinder's Shredded Cape", "=ds=#s4#"};
		{ 2, 50629, "", "=q4=Robe of the Waking Nightmare", "=ds=#s5#, #a1#"};
		{ 3, 50630, "", "=q4=Bracers of Eternal Dreaming", "=ds=#s8#, #a2#"};
		{ 4, 50626, "", "=q4=Snowstorm Helm", "=ds=#s1#, #a3#"};
		{ 5, 50619, "", "=q4=Anub'ar Stalker's Gloves", "=ds=#s9#, #a3#"};
		{ 6, 50620, "", "=q4=Coldwraith Links", "=ds=#s10#, #a4#"};
		{ 7, 50623, "", "=q4=Leggings of Dying Candles", "=ds=#s11#, #a4#"};
		{ 8, 50624, "", "=q4=Scourge Reaver's Legplates", "=ds=#s11#, #a4#"};
		{ 9, 50632, "", "=q4=Boots of the Funeral March", "=ds=#s12#, #a4#"};
		{ 10, 50625, "", "=q4=Grinning Skull Greatboots", "=ds=#s12#, #a4#"};
		{ 16, 50627, "", "=q4=Noose of Malachite", "=ds=#s2#"};
		{ 17, 50622, "", "=q4=Devium's Eternally Cold Ring", "=ds=#s13#"};
		{ 18, 50618, "", "=q4=Frostbrood Sapphire Ring", "=ds=#s13#"};
		{ 20, 50621, "", "=q4=Lungbreaker", "=ds=#h1#, #w4#"};
		{ 21, 50631, "", "=q4=Nightmare Ender", "=ds=#w9#"};
		{ 23, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 24, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		Prev = "ICCLanathel25ManHEROIC";
		Next = "ICCSindragosa25ManHEROIC";
	};

	AtlasLoot_Data["ICCSindragosaHEROIC"] = {
		{ 1, 51813, "", "=q4=Robes of Azure Downfall", "=ds=#s5#, #a1#"};
		{ 2, 51820, "", "=q4=Vambraces of the Frost Wyrm Queen", "=ds=#s8#, #a2#"};
		{ 3, 51814, "", "=q4=Icicle Shapers", "=ds=#s9#, #a2#"};
		{ 4, 51811, "", "=q4=Shoulderguards of Crystalline Bone", "=ds=#s3#, #a3#"};
		{ 5, 51818, "", "=q4=Wyrmwing Treads", "=ds=#s12#, #a3#"};
		{ 6, 51821, "", "=q4=Etched Dragonbone Girdle", "=ds=#s10#, #a4#"};
		{ 7, 51817, "", "=q4=Legplates of Aetheric Strife", "=ds=#s11#, #a4#"};
		{ 8, 51816, "", "=q4=Scourge Fanged Stompers", "=ds=#s12#, #a4#"};
		{ 10, 51822, "", "=q4=Rimetooth Pendant", "=ds=#s2#"};
		{ 16, 52027, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 17, 52026, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 18, 52025, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		{ 20, 51819, "", "=q4=Splintershard", "=ds=#h4#, #w13#"};
		{ 21, 51815, "", "=q4=Bleak Coldarra Carver", "=ds=#h3#, #w4#"};
		{ 22, 51812, "", "=q4=Lost Pavise of the Blue Flight", "=ds=#w8#"};
		Prev = "ICCValithriaHEROIC";
		Next = "ICCLichKingHEROIC";
	};

	AtlasLoot_Data["ICCSindragosa25ManHEROIC"] = {
		{ 1, 50633, "", "=q4=Sindragosa's Cruel Claw", "=ds=#s2#"};
		{ 2, 50636, "", "=q4=Memory of Malygos", "=ds=#s13#"};
		{ 3, 50365, "", "=q4=Phylactery of the Nameless Lich", "=ds=#s14#"};
		{ 4, 50364, "", "=q4=Sindragosa's Flawless Fang", "=ds=#s14#"};
		{ 5, 50635, "", "=q4=Sundial of Eternal Dusk", "=ds=#s15#"};
		{ 7, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 8, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		{ 9, 51026, "", "=q1=Crystalline Essence of Sindragosa", "=ds=#m3#"};
		{ 16, 52030, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 17, 52029, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 18, 52028, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		{ 20, 52027, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 21, 52026, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 22, 52025, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		Prev = "ICCValithria25ManHEROIC";
		Next = "ICCLichKing25ManHEROIC";
	};

		-------------------------
		--- The Frozen Throne ---
		-------------------------

	AtlasLoot_Data["ICCLichKingHEROIC"] = {
		{ 1, 51941, "", "=q4=Pugius, Fist of Defiance", "=ds=#h3#, #w13#"};
		{ 2, 51939, "", "=q4=Tel'thas, Dagger of the Blood King", "=ds=#h3#, #w4#"};
		{ 3, 51942, "", "=q4=Stormfury, Black Blade of the Betrayer", "=ds=#h1#, #w4#"};
		{ 4, 51947, "", "=q4=Troggbane, Axe of the Frostborne King", "=ds=#h1#, #w1#"};
		{ 5, 51944, "", "=q4=Valius, Gavel of the Lightbringer", "=ds=#h3#, #w6#"};
		{ 6, 51946, "", "=q4=Warmace of Menethil", "=ds=#h2#, #w6#"};
		{ 7, 51943, "", "=q4=Halion, Staff of Forgotten Love", "=ds=#w9#"};
		{ 8, 51945, "", "=q4=Tainted Twig of Nordrassil", "=ds=#w9#"};
		{ 9, 51940, "", "=q4=Windrunner's Heartseeker", "=ds=#w3#"};
		{ 16, 52027, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 17, 52026, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 18, 52025, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		{ 20, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		Prev = "ICCSindragosaHEROIC";
		Next = "ICCTrash25Man";
	};
	
	AtlasLoot_Data["ICCLichKing25ManHEROIC"] = {
		{ 1, 50736, "", "=q4=Heaven's Fall, Kryss of a Thousand Lies", "=ds=#h1#, #w4#"};
		{ 2, 50732, "", "=q4=Bloodsurge, Kel'Thuzad's Blade of Agony", "=ds=#h3#, #w10#"};
		{ 3, 50730, "", "=q4=Glorenzelg, High-Blade of the Silver Hand", "=ds=#h2#, #w10#"};
		{ 4, 50737, "", "=q4=Havoc's Call, Blade of Lordaeron Kings", "=ds=#h1#, #w1#"};
		{ 5, 50734, "", "=q4=Royal Scepter of Terenas II", "=ds=#h3#, #w6#"};
		{ 6, 50738, "", "=q4=Mithrios, Bronzebeard's Legacy", "=ds=#h1#, #w6#"};
		{ 7, 50735, "", "=q4=Oathbinder, Charge of the Ranger-General", "=ds=#w7#"};
		{ 8, 50731, "", "=q4=Archus, Greatstaff of Antonidas", "=ds=#w9#"};
		{ 9, 50733, "", "=q4=Fal'inrush, Defender of Quel'thalas", "=ds=#w3#"};
		{ 10, 50818, "", "=q4=Invincible's Reins", "=ds=#e12#"};
		{ 12, 50274, "", "=q5=Shadowfrost Shard", "=ds=#m3#"};
		{ 13, 49908, "", "=q4=Primordial Saronite", "=ds=#e8#"};
		{ 16, 52030, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 17, 52029, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 18, 52028, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		{ 20, 52027, "", "=q4=Conqueror's Mark of Sanctification", "=ds=#e15#"};
		{ 21, 52026, "", "=q4=Protector's Mark of Sanctification", "=ds=#e15#"};
		{ 22, 52025, "", "=q4=Vanquisher's Mark of Sanctification", "=ds=#e15#"};
		Prev = "ICCSindragosa25ManHEROIC";
		Next = "ICCTrash25Man";
	};

		--------------------
		--- Ruby Sanctum ---
		--------------------

	AtlasLoot_Data["Halion"] = {
		{ 1, 53115, "", "=q4=Abduction's Cover", "=ds=#s4#"};
		{ 2, 53118, "", "=q4=Misbegotten Belt", "=ds=#s10#, #a1#"};
		{ 3, 53114, "", "=q4=Gloaming Sark", "=ds=#s5#, #a2#"};
		{ 4, 53117, "", "=q4=Changeling Gloves", "=ds=#s9#, #a2#"};
		{ 5, 53113, "", "=q4=Twilight Scale Shoulders", "=ds=#s3#, #a3#"};
		{ 6, 53119, "", "=q4=Boots of Divided Being", "=ds=#s12#, #a3#"};
		{ 7, 53112, "", "=q4=Bracers of the Heir", "=ds=#s8#, #a4#"};
		{ 8, 53121, "", "=q4=Surrogate Belt", "=ds=#s10#, #a4#"};
		{ 9, 53111, "", "=q4=Scion's Treads", "=ds=#s12#, #a4#"};
		{ 16, 53103, "", "=q4=Baltharus' Gift", "=ds=#s2#"};
		{ 17, 53116, "", "=q4=Saviana's Tribute", "=ds=#s13#"};
		{ 18, 53110, "", "=q4=Zarithrian's Offering", "=ds=#s13#"};
	};

	AtlasLoot_Data["Halion25Man"] = {
		{ 1, 53489, "", "=q4=Cloak of Burning Dusk", "=ds=#s4#"};
		{ 2, 53486, "", "=q4=Bracers of Fiery Night", "=ds=#s8#, #a1#"};
		{ 3, 53134, "", "=q4=Phaseshifter's Bracers", "=ds=#s8#, #a2#"};
		{ 4, 53126, "", "=q4=Umbrage Armbands", "=ds=#s10#, #a2#"};
		{ 5, 53488, "", "=q4=Split Shape Belt", "=ds=#s10#, #a3#"};
		{ 6, 53127, "", "=q4=Returning Footfalls", "=ds=#s12#, #a3#"};
		{ 7, 53125, "", "=q4=Apocalypse's Advance", "=ds=#s12#, #a4#"};
		{ 8, 53487, "", "=q4=Foreshadow Steps", "=ds=#s12#, #a4#"};
		{ 9, 53129, "", "=q4=Treads of Impending Resurrection", "=ds=#s12#, #a4#"};
		{ 16, 53132, "", "=q4=Penumbra Pendant", "=ds=#s2#"};
		{ 17, 53490, "", "=q4=Ring of Phased Regeneration", "=ds=#s13#"};
		{ 18, 53133, "", "=q4=Signet of Twilight", "=ds=#s13#"};
		{ 19, 54572, "", "=q4=Charred Twilight Scale", "=ds=#s14#"};
		{ 20, 54573, "", "=q4=Glowing Twilight Scale", "=ds=#s14#"};
		{ 21, 54571, "", "=q4=Petrified Twilight Scale", "=ds=#s14#"};
		{ 22, 54569, "", "=q4=Sharpened Twilight Scale", "=ds=#s14#"};
	};

	AtlasLoot_Data["HalionHEROIC"] = {
		{ 1, 54556, "", "=q4=Abduction's Cover", "=ds=#s4#"};
		{ 2, 54562, "", "=q4=Misbegotten Belt", "=ds=#s10#, #a1#"};
		{ 3, 54561, "", "=q4=Gloaming Sark", "=ds=#s5#, #a2#"};
		{ 4, 54560, "", "=q4=Changeling Gloves", "=ds=#s9#, #a2#"};
		{ 5, 54566, "", "=q4=Twilight Scale Shoulders", "=ds=#s3#, #a3#"};
		{ 6, 54558, "", "=q4=Boots of Divided Being", "=ds=#s12#, #a3#"};
		{ 7, 54559, "", "=q4=Bracers of the Heir", "=ds=#s8#, #a4#"};
		{ 8, 54565, "", "=q4=Surrogate Belt", "=ds=#s10#, #a4#"};
		{ 9, 54564, "", "=q4=Scion's Treads", "=ds=#s12#, #a4#"};
		{ 16, 54557, "", "=q4=Baltharus' Gift", "=ds=#s2#"};
		{ 17, 54563, "", "=q4=Saviana's Tribute", "=ds=#s13#"};
		{ 18, 54567, "", "=q4=Zarithrian's Offering", "=ds=#s13#"};
	};

	AtlasLoot_Data["Halion25ManHEROIC"] = {
		{ 1, 54583, "", "=q4=Cloak of Burning Dusk", "=ds=#s4#"};
		{ 2, 54582, "", "=q4=Bracers of Fiery Night", "=ds=#s8#, #a1#"};
		{ 3, 54584, "", "=q4=Phaseshifter's Bracers", "=ds=#s8#, #a2#"};
		{ 4, 54580, "", "=q4=Umbrage Armbands", "=ds=#s10#, #a2#"};
		{ 5, 54587, "", "=q4=Split Shape Belt", "=ds=#s10#, #a3#"};
		{ 6, 54577, "", "=q4=Returning Footfalls", "=ds=#s12#, #a3#"};
		{ 7, 54578, "", "=q4=Apocalypse's Advance", "=ds=#s12#, #a4#"};
		{ 8, 54586, "", "=q4=Foreshadow Steps", "=ds=#s12#, #a4#"};
		{ 9, 54579, "", "=q4=Treads of Impending Resurrection", "=ds=#s12#, #a4#"};
		{ 16, 54581, "", "=q4=Penumbra Pendant", "=ds=#s2#"};
		{ 17, 54585, "", "=q4=Ring of Phased Regeneration", "=ds=#s13#"};
		{ 18, 54576, "", "=q4=Signet of Twilight", "=ds=#s13#"};
		{ 19, 54588, "", "=q4=Charred Twilight Scale", "=ds=#s14#"};
		{ 20, 54589, "", "=q4=Glowing Twilight Scale", "=ds=#s14#"};
		{ 21, 54591, "", "=q4=Petrified Twilight Scale", "=ds=#s14#"};
		{ 22, 54590, "", "=q4=Sharpened Twilight Scale", "=ds=#s14#"};
	};

	----------------
	--- Factions ---
	----------------

		-------------------------
		--- Alliance Vanguard ---
		-------------------------

	AtlasLoot_Data["AllianceVanguard1"] = {
		{ 2, 0, "INV_Shield_36", "=q6=#r4#", ""};
		{ 3, 38459, "", "=q3=Orb of the Eastern Kingdoms", "=ds=#s15#"};
		{ 4, 38465, "", "=q3=Vanguard Soldier's Dagger", "=ds=#h1#, #w4#"};
		{ 5, 38455, "", "=q3=Hammer of the Alliance Vanguard", "=ds=#h1#, #w6#"};
		{ 6, 38463, "", "=q3=Lordaeron's Resolve", "=ds=#w8#"};
		{ 7, 38453, "", "=q3=Shield of the Lion-hearted", "=ds=#w8#"};
		{ 8, 38457, "", "=q3=Sawed-off Hand Cannon", "=ds=#w5#"};
		{ 9, 38464, "", "=q3=Gnomish Magician's Quill", "=ds=#w12#"};
		{ 17, 0, "INV_Shield_36", "=q6=#r5#", ""};
		{ 18, 44503, "", "=q4=Schematic: Mekgineer's Chopper", "=ds=#p5# (450)"};
		{ 19, 44937, "", "=q3=Plans: Titanium Plating", "=ds=#p2# (450)"};
		{ 20, 44701, "", "=q7=Arcanum of the Savage Gladiator", "=ds=#s1# #e17#"};
		Back = "REPMENU";
	};

		----------------------
		--- Argent Crusade ---
		----------------------

	AtlasLoot_Data["ArgentCrusade"] = {
		{ 1, 0, "INV_Jewelry_Talisman_08", "=q6=#r2#", ""};
		{ 2, 43154, "", "=q1=Tabard of the Argent Crusade", "=ds=#s7#"};
		{ 4, 0, "INV_Jewelry_Talisman_08", "=q6=#r4#", ""};
		{ 5, 44248, "", "=q3=Battle Mender's Helm", "=ds=#s1#, #a3#"};
		{ 6, 44247, "", "=q3=Fang-Deflecting Faceguard", "=ds=#s1#, #a4#"};
		{ 7, 44244, "", "=q3=Argent Skeleton Crusher", "=ds=#h2#, #w6#"};
		{ 8, 44245, "", "=q3=Zombie Sweeper Shotgun", "=ds=#w5#"};
		{ 9, 44214, "", "=q3=Purifying Torch", "=ds=#w12#"};
		{ 10, 41726, "", "=q3=Design: Guardian's Twilight Opal", "=ds=#p12# (390)"};
		{ 11, 44150, "", "=q3=Arcanum of the Stalwart Protector", "=ds=#s1# #e17#"};
		{ 16, 0, "INV_Jewelry_Talisman_08", "=q6=#r3#", ""};
		{ 17, 44216, "", "=q3=Cloak of Holy Extermination", "=ds=#s4#"};
		{ 18, 44240, "", "=q3=Special Issue Legplates", "=ds=#s11#, #a4#"};
		{ 19, 44239, "", "=q3=Standard Issue Legguards", "=ds=#s11#, #a4#"};
		{ 20, 44139, "", "=q7=Arcanum of the Fleeing Shadow", "=ds=#s1# #e17#"};
		{ 22, 0, "INV_Jewelry_Talisman_08", "=q6=#r5#", ""};
		{ 23, 44297, "", "=q4=Boots of the Neverending Path", "=ds=#s12#, #a2#"};
		{ 24, 44295, "", "=q4=Polished Regimental Hauberk", "=ds=#s5#, #a3#"};
		{ 25, 44296, "", "=q4=Helm of Purified Thoughts", "=ds=#s1#, #a4#"};
		{ 26, 44283, "", "=q4=Signet of Hopeful Light", "=ds=#s13#"};
		{ 27, 42187, "", "=q1=Pattern: Brilliant Spellthread", "=ds=#p8# (430)"};
		Back = "REPMENU";
	};

		-------------------------
		--- Frenzyheart Tribe ---
		-------------------------

	AtlasLoot_Data["FrenzyheartTribe"] = {
		{ 1, 0, "INV_Misc_Rune_14", "=q6=#r2#", ""};
		{ 2, 41561, "", "=q2=Design: Reckless Huge Citrine", "=ds=#p12# 350"};
		{ 3, 44064, "", "=q1=Nepeta Leaf", "=ds="};
		{ 4, 44072, "", "=q1=Roasted Mystery Beast", "=ds=#e3#"};
		{ 6, 0, "INV_Potion_139", "=q6="..AL["Ripe Disgusting Jar"], ""};
		{ 7, 44719, "", "=q3=Frenzyheart Brew", "=ds=", ""};
		{ 8, 39671, "", "=q1=Resurgent Healing Potion", "=ds=#e2#", ""};
		{ 9, 40067, "", "=q1=Icy Mana Potion", "=ds=#e2#", ""};
		{ 10, 40087, "", "=q1=Powerful Rejuvenation Potion", "=ds=#e2#", ""};
		{ 11, 44716, "", "=q1=Mysterious Fermented Liquid", "=ds=#e4#", ""};
		{ 16, 0, "INV_Misc_Rune_14", "=q6=#r4#", ""};
		{ 17, 44116, "", "=q3=Muddied Crimson Gloves", "=ds=#s9#, #a1#"};
		{ 18, 44117, "", "=q3=Azure Strappy Pants", "=ds=#s11#, #a2#"};
		{ 19, 44122, "", "=q3=Scavenged Feathery Leggings", "=ds=#s11#, #a3#"};
		{ 20, 44120, "", "=q3=Giant-Sized Gauntlets", "=ds=#s9#, #a4#"};
		{ 21, 44121, "", "=q3=Sparkly Shiny Gloves", "=ds=#s9#, #a4#"};
		{ 22, 44123, "", "=q3=Discarded Titanium Legplates", "=ds=#s11#, #a4#"};
		{ 23, 44118, "", "=q3=Stolen Vrykul Harpoon", "=ds=#w11#"};
		{ 24, 41723, "", "=q3=Design: Jagged Forest Emerald", "=ds=#p12# 390"};
		{ 25, 44717, "", "=q1=Disgusting Jar", "=ds="};
		{ 27, 0, "INV_Misc_Rune_14", "=q6=#r5#", ""};
		{ 28, 44073, "", "=q1=Frenzyheart Insignia of Fury", "=ds=#s14#"};
		Back = "REPMENU";
	};

		----------------------------
		--- The Horde Expedition ---
		----------------------------

	AtlasLoot_Data["HordeExpedition1"] = {
		{ 2, 0, "INV_Shield_50", "=q6=#r4#", ""};
		{ 3, 38458, "", "=q3=Darkspear Orb", "=ds=#s15#"};
		{ 4, 38461, "", "=q3=Warsong Shanker", "=ds=#h1#, #w4#"};
		{ 5, 38454, "", "=q3=Warsong Punisher", "=ds=#h1#, #w6#"};
		{ 6, 38452, "", "=q3=Bulwark of the Warchief", "=ds=#w8#"};
		{ 7, 38462, "", "=q3=Warsong Stormshield", "=ds=#w8#"};
		{ 8, 38456, "", "=q3=Sin'dorei Recurve Bow", "=ds=#w2#"};
		{ 9, 38460, "", "=q3=Charged Wand of the Cleft", "=ds=#w12#"};
		{ 17, 0, "INV_Shield_50", "=q6=#r5#", ""};
		{ 18, 44502, "", "=q4=Schematic: Mechano-hog", "=ds=#p5# (450)"};
		{ 19, 44938, "", "=q3=Plans: Titanium Plating", "=ds=#p2# (450)"};
		{ 20, 44702, "", "=q7=Arcanum of the Savage Gladiator", "=ds=#s1# #e17#"};
		Back = "REPMENU";
	};

		-----------------
		--- Kirin Tor ---
		-----------------

	AtlasLoot_Data["KirinTor"] = {
		{ 1, 0, "Spell_Fire_MasterOfElements", "=q6=#r2#", ""};
		{ 2, 43157, "", "=q1=Tabard of the Kirin Tor", "=ds=#s7#"};
		{ 4, 0, "Spell_Fire_MasterOfElements", "=q6=#r3#", ""};
		{ 5, 44167, "", "=q3=Shroud of Dedicated Research", "=ds=#s4#"};
		{ 6, 44170, "", "=q3=Helm of the Majestic Stag", "=ds=#s1#, #a2#"};
		{ 7, 44171, "", "=q3=Spaulders of Grounded Lightning", "=ds=#s3#, #a3#"};
		{ 8, 44166, "", "=q3=Lightblade Rivener", "=ds=#h1#, #w4#"};
		{ 9, 44141, "", "=q3=Arcanum of the Flame's Soul", "=ds=#s1# #e17#"};
		{ 16, 0, "Spell_Fire_MasterOfElements", "=q6=#r4#", ""};
		{ 17, 44179, "", "=q3=Mind-Expanding Leggings", "=ds=#s11#, #a2#"};
		{ 18, 44176, "", "=q3=Girdle of the Warrior Magi", "=ds=#s10#, #a4#"};
		{ 19, 44173, "", "=q3=Flameheart Spell Scalpel", "=ds=#h3#, #w4#"};
		{ 20, 44174, "", "=q3=Stave of Shrouded Mysteries", "=ds=#w9#"};
		{ 21, 44159, "", "=q7=Arcanum of Burning Mysteries", "=ds=#s1# #e17#"};
		{ 23, 0, "Spell_Fire_MasterOfElements", "=q6=#r5#", ""};
		{ 24, 44180, "", "=q4=Robes of Crackling Flame", "=ds=#s5#, #a1#"};
		{ 25, 44181, "", "=q4=Ghostflicker Waistband", "=ds=#s10#, #a2#"};
		{ 26, 44182, "", "=q4=Boots of Twinkling Stars", "=ds=#s12#, #a3#"};
		{ 27, 44183, "", "=q4=Fireproven Gauntlets", "=ds=#s9#, #a4#"};
		{ 28, 41718, "", "=q3=Design: Runed Scarlet Ruby", "=ds=#p12# (390)"};
		{ 29, 42188, "", "=q1=Pattern: Sapphire Spellthread", "=ds=#p8# (430)"};
		Back = "REPMENU";
	};

		---------------------------------
		--- Knights of the Ebon Blade ---
		---------------------------------

	AtlasLoot_Data["KnightsoftheEbonBlade"] = {
		{ 1, 0, "INV_Weapon_Hand_01", "=q6=#r2#", ""};
		{ 2, 41562, "", "=q2=Design: Deadly Huge Citrine", "=ds=#p12# (350)"};
		{ 3, 43155, "", "=q1=Tabard of the Ebon Blade", "=ds=#s7#"};
		{ 5, 0, "INV_Weapon_Hand_01", "=q6=#r4#", ""};
		{ 6, 44256, "", "=q3=Sterile Flesh-Handling Gloves", "=ds=#s9#, #a1#"};
		{ 7, 44258, "", "=q3=Wound-Binder's Wristguards", "=ds=#s8#, #a2#"};
		{ 8, 44257, "", "=q3=Spaulders of the Black Arrow", "=ds=#s3#, #a3#"};
		{ 9, 44250, "", "=q3=Reaper of Dark Souls", "=ds=#h1#, #w10#"};
		{ 10, 44249, "", "=q3=Runeblade of Demonstrable Power", "=ds=#h2#, #w10#"};
		{ 11, 41721, "", "=q3=Design: Wicked Monarch Topaz", "=ds=#p12# (390)"};
		{ 12, 44149, "", "=q7=Arcanum of Torment", "=ds=#s1# #e17#"};
		{ 13, 42183, "", "=q1=Pattern: Abyssal Bag", "=ds=#p8# (435)"};
		{ 16, 0, "INV_Weapon_Hand_01", "=q6=#r3#", ""};
		{ 17, 44242, "", "=q3=Dark Soldier Cape", "=ds=#s4#"};
		{ 18, 44243, "", "=q3=Toxin-Tempered Sabatons", "=ds=#s12#, #a4#"};
		{ 19, 44241, "", "=q3=Unholy Persuader", "=ds=#h4#, #w13#"};
		{ 20, 44512, "", "=q3=Pattern: Nerubian Reinforced Quiver", "=ds=#p7# (415)"};
		{ 21, 44138, "", "=q3=Arcanum of Toxic Warding", "=ds=#s1# #e17#"};
		{ 23, 0, "INV_Weapon_Hand_01", "=q6=#r5#", ""};
		{ 24, 44302, "", "=q4=Belt of Dark Mending", "=ds=#s10#, #a1#"};
		{ 25, 44303, "", "=q4=Darkheart Chestguard", "=ds=#s5#, #a2#"};
		{ 26, 44305, "", "=q4=Kilt of Dark Mercy", "=ds=#s11#, #a3#"};
		{ 27, 44306, "", "=q4=Death-Inured Sabatons", "=ds=#s12#, #a4#"};
		{ 28, 41725, "", "=q3=Design: Glowing Twilight Opal", "=ds=#p12# (390)"};
		Back = "REPMENU";
	};

		-------------------
		--- The Kalu'ak ---
		-------------------

	AtlasLoot_Data["TheKaluak"] = {
		{ 1, 0, "INV_Fishingpole_03", "=q6=#r2#", ""};
		{ 2, 41568, "", "=q2=Design: Seer's Dark Jade", "=ds=#p12# (350)"};
		{ 3, 44049, "", "=q1=Freshly-Speared Emperor Salmon", "=ds=#e3#"};
		{ 5, 0, "INV_Fishingpole_03", "=q6=#r3#", ""};
		{ 6, 44061, "", "=q3=Pigment-Stained Robes", "=ds=#s5#, #a1#"};
		{ 7, 44062, "", "=q3=Turtle-Minders Robe", "=ds=#s5#, #a1#"};
		{ 8, 44054, "", "=q3=Whale-Skin Breastplate", "=ds=#s5#, #a2#"};
		{ 9, 44055, "", "=q3=Whale-Skin Vest", "=ds=#s5#, #a2#"};
		{ 10, 44059, "", "=q3=Cuttlefish Scale Breastplate", "=ds=#s5#, #a3#"};
		{ 11, 44060, "", "=q3=Cuttlefish Tooth Ringmail", "=ds=#s5#, #a3#"};
		{ 12, 44057, "", "=q3=Ivory-Reinforced Chestguard", "=ds=#s5#, #a4#"};
		{ 13, 44058, "", "=q3=Whalebone Carapace", "=ds=#s5#, #a4#"};
		{ 14, 44511, "", "=q3=Pattern: Dragonscale Ammo Pouch", "=ds=#p7# (415)"};
		{ 15, 41574, "", "=q2=Design: Defender's Shadow Crystal", "=ds=#p12# (350)"};
		{ 16, 0, "INV_Fishingpole_03", "=q6=#r4#", ""};
		{ 17, 44051, "", "=q3=Traditional Flensing Knife", "=ds=#h1#, #w4#"};
		{ 18, 44052, "", "=q3=Totemic Purification Rod", "=ds=#h3#, #w6#"};
		{ 19, 44053, "", "=q3=Whale-Stick Harpoon", "=ds=#w7#"};
		{ 20, 44509, "", "=q3=Pattern: Trapper's Traveling Pack", "=ds=#p7# (415)"};
		{ 21, 45774, "", "=q1=Pattern: Emerald Bag", "=ds=#p8# (435)"};
		{ 23, 0, "INV_Fishingpole_03", "=q6=#r5#", ""};
		{ 24, 44050, "", "=q4=Mastercraft Kalu'ak Fishing Pole", "=ds=#e20#"};
		{ 25, 44723, "", "=q3=Nurtured Penguin Egg", "=ds=#e13#"};
		Back = "REPMENU";
	};

		-------------------
		--- The Oracles ---
		-------------------

	AtlasLoot_Data["TheOracles"] = {
		{ 1, 0, "INV_Helmet_138", "=q6=#r2#", ""};
		{ 2, 41567, "", "=q2=Design: Vivid Dark Jade", "=ds=#p12# (350)"};
		{ 3, 44065, "", "=q1=Oracle Secret Solution", "=ds=#e2#"};
		{ 5, 0, "INV_Helmet_138", "=q6=#r3#", ""};
		{ 6, 44071, "", "=q1=Slow-Roasted Eel", "=ds=#e3#"};
		{ 8, 0, "INV_Egg_02", "=q6="..AL["Cracked Egg"], ""};
		{ 9, 44707, "", "=q4=Reins of the Green Proto-Drake", "=ds=#e12#", ""};
		{ 10, 39898, "", "=q1=Cobra Hatchling", "=ds=#e13#", ""};
		{ 11, 44721, "", "=q1=Proto-Drake Whelp", "=ds=#e13#", ""};
		{ 12, 39896, "", "=q1=Tickbird Hatchling", "=ds=#e13#", ""};
		{ 13, 39899, "", "=q1=White Tickbird Hatchling", "=ds=#e13#", ""};
		{ 14, 44722, "", "=q1=Aged Yolk", "=ds=#e3#", ""};
		{ 16, 0, "INV_Helmet_138", "=q6=#r4#", ""};
		{ 17, 44104, "", "=q3=Fishy Cinch", "=ds=#s10#, #a1#"};
		{ 18, 44106, "", "=q3=Glitterscale Wrap", "=ds=#s10#, #a2#" };
		{ 19, 44110, "", "=q3=Sharkjaw Cap", "=ds=#s1#, #a3#" };
		{ 20, 44109, "", "=q3=Toothslice Helm", "=ds=#s1#, #a3#" };
		{ 21, 44112, "", "=q3=Glimmershell Shoulder Protectors", "=ds=#s3#, #a4#"};
		{ 22, 44111, "", "=q3=Gold Star Spaulders", "=ds=#s3#, #a4#"};
		{ 23, 44108, "", "=q3=Shinygem Rod", "=ds=#w12#"};
		{ 24, 41724, "", "=q3=Design: Sundered Forest Emerald", "=ds=#p12# (390)"};
		{ 25, 39878, "", "=q1=Mysterious Egg", "=ds="};
		{ 27, 0, "INV_Helmet_138", "=q6=#r5#", ""};
		{ 28, 44074, "", "=q4=Oracle Talisman of Ablution", "=ds=#s14#"};
		Back = "REPMENU";
	};

		-------------------------
		--- The Sons of Hodir ---
		-------------------------

	AtlasLoot_Data["TheSonsofHodir1"] = {
		{ 1, 0, "Spell_Holy_DivinePurpose", "=q6=#r3#", ""};
		{ 2, 44190, "", "=q3=Spaulders of Frozen Knives", "=ds=#s3#, #a2#"};
		{ 3, 44189, "", "=q3=Giant Ring Belt", "=ds=#s10#, #a3#"};
		{ 4, 44510, "", "=q3=Pattern: Mammoth Mining Bag", "=ds=#p7# (415)"};
		{ 5, 44137, "", "=q3=Arcanum of the Frosty Soul", "=ds=#s1# #e17#"};
		{ 6, 44131, "", "=q3=Lesser Inscription of the Axe", "=ds=#s3# #e17#"};
		{ 7, 44130, "", "=q3=Lesser Inscription of the Crag", "=ds=#s3# #e17#"};
		{ 8, 44132, "", "=q3=Lesser Inscription of the Pinnacle", "=ds=#s3# #e17#"};
		{ 9, 44129, "", "=q3=Lesser Inscription of the Storm ", "=ds=#s3# #e17#"};
		{ 16, 0, "Spell_Holy_DivinePurpose", "=q6=#r4#", ""};
		{ 17, 43958, "", "=q4=Reins of the Ice Mammoth", "=ds=#e12# =ec1=#m7#"};
		{ 18, 44080, "", "=q4=Reins of the Ice Mammoth", "=ds=#e12# =ec1=#m6#"};
		{ 19, 44194, "", "=q3=Giant-Friend Kilt", "=ds=#s11#, #a2#" };
		{ 20, 44195, "", "=q3=Spaulders of the Giant Lords", "=ds=#s3#, #a4#"};
		{ 21, 44193, "", "=q3=Broken Stalactite", "=ds=#h1#, #w4#"};
		{ 22, 44192, "", "=q3=Stalactite Chopper", "=ds=#h1#, #w1#"};
		Next = "TheSonsofHodir2";
		Back = "REPMENU";
	};

	AtlasLoot_Data["TheSonsofHodir2"] = {
		{ 1, 0, "Spell_Holy_DivinePurpose", "=q6=#r5#", ""};
		{ 2, 43961, "", "=q4=Reins of the Grand Ice Mammoth", "=ds=#e12# =ec1=#m7#"};
		{ 3, 44086, "", "=q4=Reins of the Grand Ice Mammoth", "=ds=#e12# =ec1=#m6#"};
		{ 4, 44133, "", "=q7=Greater Inscription of the Axe", "=ds=#s3# #e17#"};
		{ 5, 44134, "", "=q7=Greater Inscription of the Crag", "=ds=#s3# #e17#"};
		{ 6, 44136, "", "=q7=Greater Inscription of the Pinnacle", "=ds=#s3# #e17#"};
		{ 7, 44135, "", "=q7=Greater Inscription of the Storm ", "=ds=#s3# #e17#"};
		{ 8, 41720, "", "=q3=Design: Smooth Autumn's Glow", "=ds=#p12# (390)"};
		{ 9, 42184, "", "=q1=Pattern: Glacial Bag", "=ds=#p8# (445)"};
		Prev = "TheSonsofHodir1";
		Back = "REPMENU";
	};

		-------------------------
		--- Winterfin Retreat ---
		-------------------------

	AtlasLoot_Data["WinterfinRetreat"] = {
		{ 2, 36784, "", "=q3=Siren's Tear", "=ds=#e7#", "100 #winterfinclam#"};
		{ 3, 37462, "", "=q2=Sea King's Crown", "=ds=#s1#, #a1#", "30 #winterfinclam#"};
		{ 4, 37463, "", "=q2=Winterfin Patch of Honor", "=ds=#s1#, #a2#", "30 #winterfinclam#"};
		{ 5, 37461, "", "=q2=Tidebreaker Trident", "=ds=#w7#", "50 #winterfinclam#"};
		{ 6, 36783, "", "=q2=Northsea Pearl", "=ds=#e7#", "30 #winterfinclam#"};
		{ 7, 37464, "", "=q1=Winterfin Horn of Distress", "=ds=#e22#", "5 #winterfinclam#"};
		{ 8, 37449, "", "=q1=Breath of Murloc", "=ds=#e2#", "5 #winterfinclam#"};
		{ 9, 38351, "", "=q1=Murliver Oil", "=ds=#e2#", "2 #winterfinclam#"};
		{ 10, 38350, "", "=q1=Winterfin \"Depth Charge\"", "=ds=#e4#", "1 #winterfinclam#"};
		{ 12, 34597, "", "=q1=Winterfin Clam", "=ds=#m17#"};
		Back = "REPMENU";
	};

		---------------------------
		--- The Wyrmrest Accord ---
		---------------------------

	AtlasLoot_Data["TheWyrmrestAccord"] = {
		{ 1, 0, "Ability_Druid_Eclipse", "=q6=#r1#", ""};
		{ 2, 43156, "", "=q1=Tabard of the Wyrmrest Accord", "=ds=#s7#"};
		{ 4, 0, "Ability_Druid_Eclipse", "=q6=#r3#", ""};
		{ 5, 44188, "", "=q3=Cloak of Peaceful Resolutions", "=ds=#s4#"};
		{ 6, 44196, "", "=q3=Sash of the Wizened Wyrm", "=ds=#s10#, #a1#"};
		{ 7, 44197, "", "=q3=Bracers of Accorded Courtesy", "=ds=#s8#, #a4#"};
		{ 8, 44187, "", "=q3=Fang of Truth", "=ds=#h1#, #w10#"};
		{ 9, 44140, "", "=q3=Arcanum of the Eclipsed Moon", "=ds=#s1# #e17#"};
		{ 16, 0, "Ability_Druid_Eclipse", "=q6=#r4#", ""};
		{ 17, 44200, "", "=q3=Ancestral Sinew Wristguards", "=ds=#s8#, #a1#"};
		{ 18, 44198, "", "=q3=Breastplate of the Solemn Council", "=ds=#s5#, #a4#"};
		{ 19, 44201, "", "=q3=Sabatons of Draconic Vigor", "=ds=#s12#, #a4#"};
		{ 20, 44199, "", "=q3=Gavel of the Brewing Storm", "=ds=#h3#, #w6#"};
		{ 21, 44152, "", "=q7=Arcanum of Blissful Mending", "=ds=#s1# #e17#"};
		{ 22, 42185, "", "=q1=Pattern: Mysterious Bag", "=ds=#p8# (440)"};
		{ 24, 0, "Ability_Druid_Eclipse", "=q6=#r5#", ""};
		{ 25, 44202, "", "=q4=Sandals of Crimson Fury", "=ds=#s12#, #a1#"};
		{ 26, 44203, "", "=q4=Dragonfriend Bracers", "=ds=#s8#, #a2#"};
		{ 27, 44204, "", "=q4=Grips of Fierce Pronouncements", "=ds=#s9#, #a3#"};
		{ 28, 44205, "", "=q4=Legplates of Bloody Reprisal", "=ds=#s11#, #a4#"};
		{ 29, 43955, "", "=q4=Reins of the Red Drake", "=ds=#e12#"};
		{ 30, 41722, "", "=q3=Design: Glimmering Monarch Topaz", "=ds=#p12# (390)"};
		Back = "REPMENU";
	};

		-------------------------
		--- The Ashen Verdict ---
		-------------------------

	AtlasLoot_Data["AshenVerdict"] = {
		{ 1, 50375, "", "=q4=Ashen Band of Courage", "=ds=#s13#, =q1=#r2#"};
		{ 2, 50388, "", "=q4=Ashen Band of Greater Courage", "=ds=#s13#, =q1=#r3#"};
		{ 3, 50403, "", "=q4=Ashen Band of Unmatched Courage", "=ds=#s13#, =q1=#r4#"};
		{ 4, 50404, "", "=q4=Ashen Band of Endless Courage", "=ds=#s13#, =q1=#r5#"};
		{ 6, 50377, "", "=q4=Ashen Band of Destruction", "=ds=#s13#, =q1=#r2#"};
		{ 7, 50384, "", "=q4=Ashen Band of Greater Destruction", "=ds=#s13#, =q1=#r3#"};
		{ 8, 50397, "", "=q4=Ashen Band of Unmatched Destruction", "=ds=#s13#, =q1=#r4#"};
		{ 9, 50398, "", "=q4=Ashen Band of Endless Destruction", "=ds=#s13#, =q1=#r5#"};
		{ 11, 52569, "", "=q4=Ashen Band of Might", "=ds=#s13#, =q1=#r2#"};
		{ 12, 52570, "", "=q4=Ashen Band of Greater Might", "=ds=#s13#, =q1=#r3#"};
		{ 13, 52571, "", "=q4=Ashen Band of Unmatched Might", "=ds=#s13#, =q1=#r4#"};
		{ 14, 52572, "", "=q4=Ashen Band of Endless Might", "=ds=#s13#, =q1=#r5#"};
		{ 16, 50376, "", "=q4=Ashen Band of Vengeance", "=ds=#s13#, =q1=#r2#"};
		{ 17, 50387, "", "=q4=Ashen Band of Greater Vengeance", "=ds=#s13#, =q1=#r3#"};
		{ 18, 50401, "", "=q4=Ashen Band of Unmatched Vengeance", "=ds=#s13#, =q1=#r4#"};
		{ 19, 50402, "", "=q4=Ashen Band of Endless Vengeance", "=ds=#s13#, =q1=#r5#"};
		{ 21, 50378, "", "=q4=Ashen Band of Wisdom", "=ds=#s13#, =q1=#r2#"};
		{ 22, 50386, "", "=q4=Ashen Band of Greater Wisdom", "=ds=#s13#, =q1=#r3#"};
		{ 23, 50399, "", "=q4=Ashen Band of Unmatched Wisdom", "=ds=#s13#, =q1=#r4#"};
		{ 24, 50400, "", "=q4=Ashen Band of Endless Wisdom", "=ds=#s13#, =q1=#r5#"};
		Next = "AshenVerdict2";
		Back = "REPMENU";
	};

	AtlasLoot_Data["AshenVerdict2"] = {
		{ 1, 0, "Inv_Jewelry_Ring_85", "=q6=#r3#", ""};
		{ 2, 49974, "", "=q4=Plans: Boots of Kingly Upheaval", "=ds=#p2# (450)"};
		{ 3, 49972, "", "=q4=Plans: Hellfrozen Bonegrinders", "=ds=#p2# (450)"};
		{ 4, 49970, "", "=q4=Plans: Protectors of Life", "=ds=#p2# (450)"};
		{ 5, 49958, "", "=q4=Pattern: Blessed Cenarion Boots", "=ds=#p7# (450)"};
		{ 6, 49963, "", "=q4=Pattern: Earthsoul Boots", "=ds=#p7# (450)"};
		{ 7, 49961, "", "=q4=Pattern: Footpads of Impending Death", "=ds=#p7# (450)"};
		{ 8, 49966, "", "=q4=Pattern: Rock-Steady Treads", "=ds=#p7# (450)"};
		{ 9, 49954, "", "=q4=Pattern: Deathfrost Boots", "=ds=#p8# (450)"};
		{ 10, 49956, "", "=q4=Pattern: Sandals of Consecration", "=ds=#p8# (450)"};
		{ 11, 52023, "", "=q4=Plans: Evil Arrow", "=ds=#p17# (450)"};
		{ 12, 52022, "", "=q4=Plans: Shatter Rounds", "=ds=#p18# (450)"};
		{ 16, 0, "Inv_Jewelry_Ring_85", "=q6=#r4#", ""};
		{ 17, 49971, "", "=q4=Plans: Legplates of Painful Death", "=ds=#p2# (450)"};
		{ 18, 49973, "", "=q4=Plans: Pillars of Might", "=ds=#p2# (450)"};
		{ 19, 49969, "", "=q4=Plans: Puresteel Legplates", "=ds=#p2# (450)"};
		{ 20, 49959, "", "=q4=Pattern: Bladeborn Leggings", "=ds=#p7# (450)"};
		{ 21, 49965, "", "=q4=Pattern: Draconic Bonesplinter Legguards", "=ds=#p7# (450)"};
		{ 22, 49957, "", "=q4=Pattern: Legwraps of Unleashed Nature", "=ds=#p7# (450)"};
		{ 23, 49962, "", "=q4=Pattern: Lightning-Infused Leggings", "=ds=#p7# (450)"};
		{ 24, 49953, "", "=q4=Pattern: Leggings of Woven Death", "=ds=#p8# (450)"};
		{ 25, 49955, "", "=q4=Pattern: Lightweave Leggings", "=ds=#p8# (450)"};
		Prev = "AshenVerdict";
		Back = "REPMENU";
	};

	-----------
	--- PvP ---
	-----------

		------------------
		--- Armor Sets ---
		------------------

	AtlasLoot_Data["PvP80DeathKnight"] = {
		{ 1, 0, "Spell_Deathknight_DeathStrike", "=q6=#arenas10#", ""};
		{ 2, 51415, "", "=q4=Wrathful Gladiator's Dreadplate Helm", "=ds=", "2370 #arena# #reqrating# 1950"};
		{ 3, 51418, "", "=q4=Wrathful Gladiator's Dreadplate Shoulders", "=ds=", "1930 #arena# #reqrating# 2000"};
		{ 4, 51413, "", "=q4=Wrathful Gladiator's Dreadplate Chestpiece", "=ds=", "2370 #arena# #reqrating# 1600"};
		{ 5, 51414, "", "=q4=Wrathful Gladiator's Dreadplate Gauntlets", "=ds=", "1430 #arena# #reqrating# 1400"};
		{ 6, 51416, "", "=q4=Wrathful Gladiator's Dreadplate Legguards", "=ds=", "2370 #arena# #reqrating# 1500"};
		{ 8, 0, "Spell_Deathknight_DeathStrike", "=q6=#arenas10#", ""};
		{ 9, 40830, "", "=q4=Relentless Gladiator's Dreadplate Helm", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 10, 40871, "", "=q4=Relentless Gladiator's Dreadplate Shoulders", "=ds=", "10550 #faction# 600 #arena# / 60 #eoffrost#"};
		{ 11, 40791, "", "=q4=Relentless Gladiator's Dreadplate Chestpiece", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 12, 40811, "", "=q4=Relentless Gladiator's Dreadplate Gauntlets", "=ds=", "8000 #faction# 440 #arena# / 60 #eoffrost#"};
		{ 13, 40851, "", "=q4=Relentless Gladiator's Dreadplate Legguards", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 16, 0, "Spell_Deathknight_DeathStrike", "=q6=#arenas10#", ""};
		{ 17, 40827, "", "=q4=Furious Gladiator's Dreadplate Helm", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 18, 40868, "", "=q4=Furious Gladiator's Dreadplate Shoulders", "=ds=", "34700 #faction# / 50 #eoftriumph#"};
		{ 19, 40787, "", "=q4=Furious Gladiator's Dreadplate Chestpiece", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 20, 40809, "", "=q4=Furious Gladiator's Dreadplate Gauntlets", "=ds=", "43400 #faction# / 50 #eoftriumph#"};
		{ 21, 40848, "", "=q4=Furious Gladiator's Dreadplate Legguards", "=ds=", "34700 #faction# / 75 #eoftriumph#"};
		{ 23, 0, "Spell_Deathknight_DeathStrike", "=q6=#arenas10#", ""};
		{ 24, 40824, "", "=q4=Deadly Gladiator's Dreadplate Helm", "=ds=", "58 #eofconquest#"};
		{ 25, 40863, "", "=q4=Deadly Gladiator's Dreadplate Shoulders", "=ds=", "46 #eofconquest#"};
		{ 26, 40784, "", "=q4=Deadly Gladiator's Dreadplate Chestpiece", "=ds=", "58 #eofconquest#"};
		{ 27, 40806, "", "=q4=Deadly Gladiator's Dreadplate Gauntlets", "=ds=", "46 #eofconquest#"};
		{ 28, 40845, "", "=q4=Deadly Gladiator's Dreadplate Legguards", "=ds=", "58 #eofconquest#"};
		Next = "PvP80DeathKnight2";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80DeathKnight2"] = {
		{ 1, 0, "Spell_Deathknight_DeathStrike", "=q6=#arenas10#", ""};
		{ 2, 40820, "", "=q4=Hateful Gladiator's Dreadplate Helm", "=ds=", "45 #eofvalor#"};
		{ 3, 40860, "", "=q4=Hateful Gladiator's Dreadplate Shoulders", "=ds=", "30 #eofvalor#"};
		{ 4, 40781, "", "=q4=Hateful Gladiator's Dreadplate Chestpiece", "=ds=", "45 #eofvalor#"};
		{ 5, 40803, "", "=q4=Hateful Gladiator's Dreadplate Gauntlets", "=ds=", "30 #eofvalor#"};
		{ 6, 40841, "", "=q4=Hateful Gladiator's Dreadplate Legguards", "=ds=", "45 #eofvalor#"};
		{ 8, 0, "Spell_Deathknight_DeathStrike", "=q6=#arenas10#", ""};
		{ 9, 40817, "", "=q3=Savage Gladiator's Dreadplate Helm", "=ds=", "45 #eofheroism#"};
		{ 10, 40857, "", "=q3=Savage Gladiator's Dreadplate Shoulders", "=ds=", "30 #eofheroism#"};
		{ 11, 40779, "", "=q3=Savage Gladiator's Dreadplate Chestpiece", "=ds=", "45 #eofheroism#"};
		{ 12, 40799, "", "=q3=Savage Gladiator's Dreadplate Gauntlets", "=ds=", "30 #eofheroism#"};
		{ 13, 40837, "", "=q3=Savage Gladiator's Dreadplate Legguards", "=ds=", "45 #eofheroism#"};
		Prev = "PvP80DeathKnight";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80DruidBalance"] = {
		{ 1, 0, "Spell_Nature_InsectSwarm", "=q6=#arenas1_2#", ""};
		{ 2, 51435, "", "=q4=Wrathful Gladiator's Wyrmhide Helm", "=ds=", "2370 #arena# #reqrating# 1950"};
		{ 3, 51438, "", "=q4=Wrathful Gladiator's Wyrmhide Spaulders", "=ds=", "1930 #arena# #reqrating# 2000"};
		{ 4, 51433, "", "=q4=Wrathful Gladiator's Wyrmhide Robes", "=ds=", "2370 #arena# #reqrating# 1600"};
		{ 5, 51434, "", "=q4=Wrathful Gladiator's Wyrmhide Gloves", "=ds=", "1430 #arena# #reqrating# 1400"};
		{ 6, 51436, "", "=q4=Wrathful Gladiator's Wyrmhide Legguards", "=ds=", "2370 #arena# #reqrating# 1500"};
		{ 8, 0, "Spell_Nature_InsectSwarm", "=q6=#arenas1_2#", ""};
		{ 9, 41328, "", "=q4=Relentless Gladiator's Wyrmhide Helm", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 10, 41282, "", "=q4=Relentless Gladiator's Wyrmhide Spaulders", "=ds=", "10550 #faction# 600 #arena# / 60 #eoffrost#"};
		{ 11, 41317, "", "=q4=Relentless Gladiator's Wyrmhide Robes", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 12, 41294, "", "=q4=Relentless Gladiator's Wyrmhide Gloves", "=ds=", "8000 #faction# 440 #arena# / 60 #eoffrost#"};
		{ 13, 41305, "", "=q4=Relentless Gladiator's Wyrmhide Legguards", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 16, 0, "Spell_Nature_InsectSwarm", "=q6=#arenas1_2#", ""};
		{ 17, 41327, "", "=q4=Furious Gladiator's Wyrmhide Helm", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 18, 41281, "", "=q4=Furious Gladiator's Wyrmhide Spaulders", "=ds=", "34700 #faction# / 50 #eoftriumph#"};
		{ 19, 41316, "", "=q4=Furious Gladiator's Wyrmhide Robes", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 20, 41293, "", "=q4=Furious Gladiator's Wyrmhide Gloves", "=ds=", "43400 #faction# / 50 #eoftriumph#"};
		{ 21, 41304, "", "=q4=Furious Gladiator's Wyrmhide Legguards", "=ds=", "34700 #faction# / 75 #eoftriumph#"};
		{ 23, 0, "Spell_Nature_InsectSwarm", "=q6=#arenas1_2#", ""};
		{ 24, 41326, "", "=q4=Deadly Gladiator's Wyrmhide Helm", "=ds=", "58 #eofconquest#"};
		{ 25, 41280, "", "=q4=Deadly Gladiator's Wyrmhide Spaulders", "=ds=", "46 #eofconquest#"};
		{ 26, 41315, "", "=q4=Deadly Gladiator's Wyrmhide Robes", "=ds=", "58 #eofconquest#"};
		{ 27, 41292, "", "=q4=Deadly Gladiator's Wyrmhide Gloves", "=ds=", "46 #eofconquest#"};
		{ 28, 41303, "", "=q4=Deadly Gladiator's Wyrmhide Legguards", "=ds=", "58 #eofconquest#"};
		Next = "PvP80DruidBalance2";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80DruidBalance2"] = {
		{ 1, 0, "Spell_Nature_InsectSwarm", "=q6=#arenas1_2#", ""};
		{ 2, 41325, "", "=q4=Hateful Gladiator's Wyrmhide Helm", "=ds=", "45 #eofvalor#"};
		{ 3, 41279, "", "=q4=Hateful Gladiator's Wyrmhide Spaulders", "=ds=", "30 #eofvalor#"};
		{ 4, 41314, "", "=q4=Hateful Gladiator's Wyrmhide Robes", "=ds=", "45 #eofvalor#"};
		{ 5, 41291, "", "=q4=Hateful Gladiator's Wyrmhide Gloves", "=ds=", "30 #eofvalor#"};
		{ 6, 41302, "", "=q4=Hateful Gladiator's Wyrmhide Legguards", "=ds=", "45 #eofvalor#"};
		{ 8, 0, "Spell_Nature_InsectSwarm", "=q6=#arenas1_2#", ""};
		{ 9, 41324, "", "=q3=Savage Gladiator's Wyrmhide Helm", "=ds=", "45 #eofheroism#"};
		{ 10, 41278, "", "=q3=Savage Gladiator's Wyrmhide Spaulders", "=ds=", "30 #eofheroism#"};
		{ 11, 41313, "", "=q3=Savage Gladiator's Wyrmhide Robes", "=ds=", "45 #eofheroism#"};
		{ 12, 41290, "", "=q3=Savage Gladiator's Wyrmhide Gloves", "=ds=", "30 #eofheroism#"};
		{ 13, 41301, "", "=q3=Savage Gladiator's Wyrmhide Legguards", "=ds=", "45 #eofheroism#"};
		Prev = "PvP80DruidBalance";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80DruidFeral"] = {
		{ 1, 0, "Ability_Druid_Maul", "=q6=#arenas1_1#", ""};
		{ 2, 51427, "", "=q4=Wrathful Gladiator's Dragonhide Helm", "=ds=", "2370 #arena# #reqrating# 1950"};
		{ 3, 51430, "", "=q4=Wrathful Gladiator's Dragonhide Spaulders", "=ds=", "1930 #arena# #reqrating# 2000"};
		{ 4, 51425, "", "=q4=Wrathful Gladiator's Dragonhide Robes", "=ds=", "2370 #arena# #reqrating# 1600"};
		{ 5, 51426, "", "=q4=Wrathful Gladiator's Dragonhide Gloves", "=ds=", "1430 #arena# #reqrating# 1400"};
		{ 6, 51428, "", "=q4=Wrathful Gladiator's Dragonhide Legguards", "=ds=", "2370 #arena# #reqrating# 1500"};
		{ 8, 0, "Ability_Druid_Maul", "=q6=#arenas1_1#", ""};
		{ 9, 41679, "", "=q4=Relentless Gladiator's Dragonhide Helm", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 10, 41716, "", "=q4=Relentless Gladiator's Dragonhide Spaulders", "=ds=", "10550 #faction# 600 #arena# / 60 #eoffrost#"};
		{ 11, 41662, "", "=q4=Relentless Gladiator's Dragonhide Robes", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 12, 41774, "", "=q4=Relentless Gladiator's Dragonhide Gloves", "=ds=", "8000 #faction# 440 #arena# / 60 #eoffrost#"};
		{ 13, 41668, "", "=q4=Relentless Gladiator's Dragonhide Legguards", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 16, 0, "Ability_Druid_Maul", "=q6=#arenas1_1#", ""};
		{ 17, 41678, "", "=q4=Furious Gladiator's Dragonhide Helm", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 18, 41715, "", "=q4=Furious Gladiator's Dragonhide Spaulders", "=ds=", "34700 #faction# / 50 #eoftriumph#"};
		{ 19, 41661, "", "=q4=Furious Gladiator's Dragonhide Robes", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 20, 41773, "", "=q4=Furious Gladiator's Dragonhide Gloves", "=ds=", "43400 #faction# / 50 #eoftriumph#"};
		{ 21, 41667, "", "=q4=Furious Gladiator's Dragonhide Legguards", "=ds=", "34700 #faction# / 75 #eoftriumph#"};
		{ 23, 0, "Ability_Druid_Maul", "=q6=#arenas1_1#", ""};
		{ 24, 41677, "", "=q4=Deadly Gladiator's Dragonhide Helm", "=ds=", "58 #eofconquest#"};
		{ 25, 41714, "", "=q4=Deadly Gladiator's Dragonhide Spaulders", "=ds=", "46 #eofconquest#"};
		{ 26, 41660, "", "=q4=Deadly Gladiator's Dragonhide Robes", "=ds=", "58 #eofconquest#"};
		{ 27, 41772, "", "=q4=Deadly Gladiator's Dragonhide Gloves", "=ds=", "46 #eofconquest#"};
		{ 28, 41666, "", "=q4=Deadly Gladiator's Dragonhide Legguards", "=ds=", "58 #eofconquest#"};
		Next = "PvP80DruidFeral2";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80DruidFeral2"] = {
		{ 1, 0, "Ability_Druid_Maul", "=q6=#arenas1_1#", ""};
		{ 2, 41676, "", "=q4=Hateful Gladiator's Dragonhide Helm", "=ds=", "45 #eofvalor#"};
		{ 3, 41713, "", "=q4=Hateful Gladiator's Dragonhide Spaulders", "=ds=", "30 #eofvalor#"};
		{ 4, 41659, "", "=q4=Hateful Gladiator's Dragonhide Robes", "=ds=", "45 #eofvalor#"};
		{ 5, 41771, "", "=q4=Hateful Gladiator's Dragonhide Gloves", "=ds=", "30 #eofvalor#"};
		{ 6, 41665, "", "=q4=Hateful Gladiator's Dragonhide Legguards", "=ds=", "45 #eofvalor#"};
		{ 8, 0, "Ability_Druid_Maul", "=q6=#arenas1_1#", ""};
		{ 9, 41675, "", "=q3=Savage Gladiator's Dragonhide Helm", "=ds=", "45 #eofheroism#"};
		{ 10, 41712, "", "=q3=Savage Gladiator's Dragonhide Spaulders", "=ds=", "30 #eofheroism#"};
		{ 11, 41658, "", "=q3=Savage Gladiator's Dragonhide Robes", "=ds=", "45 #eofheroism#"};
		{ 12, 41770, "", "=q3=Savage Gladiator's Dragonhide Gloves", "=ds=", "30 #eofheroism#"};
		{ 13, 41664, "", "=q3=Savage Gladiator's Dragonhide Legguards", "=ds=", "45 #eofheroism#"};
		Prev = "PvP80DruidFeral";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80DruidRestoration"] = {
		{ 1, 0, "Spell_Nature_Regeneration", "=q6=#arenas1_3#", ""};
		{ 2, 51421, "", "=q4=Wrathful Gladiator's Kodohide Helm", "=ds=", "2370 #arena# #reqrating# 1950"};
		{ 3, 51424, "", "=q4=Wrathful Gladiator's Kodohide Spaulders", "=ds=", "1930 #arena# #reqrating# 2000"};
		{ 4, 51419, "", "=q4=Wrathful Gladiator's Kodohide Robes", "=ds=", "2370 #arena# #reqrating# 1600"};
		{ 5, 51420, "", "=q4=Wrathful Gladiator's Kodohide Gloves", "=ds=", "1430 #arena# #reqrating# 1400"};
		{ 6, 51422, "", "=q4=Wrathful Gladiator's Kodohide Legguards", "=ds=", "2370 #arena# #reqrating# 1500"};
		{ 8, 0, "Spell_Nature_Regeneration", "=q6=#arenas1_3#", ""};
		{ 9, 41322, "", "=q4=Relentless Gladiator's Kodohide Helm", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 10, 41276, "", "=q4=Relentless Gladiator's Kodohide Spaulders", "=ds=", "10550 #faction# 600 #arena# / 60 #eoffrost#"};
		{ 11, 41311, "", "=q4=Relentless Gladiator's Kodohide Robes", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 12, 41288, "", "=q4=Relentless Gladiator's Kodohide Gloves", "=ds=", "8000 #faction# 440 #arena# / 60 #eoffrost#"};
		{ 13, 41299, "", "=q4=Relentless Gladiator's Kodohide Legguards", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 16, 0, "Spell_Nature_Regeneration", "=q6=#arenas1_3#", ""};
		{ 17, 41321, "", "=q4=Furious Gladiator's Kodohide Helm", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 18, 41275, "", "=q4=Furious Gladiator's Kodohide Spaulders", "=ds=", "34700 #faction# / 50 #eoftriumph#"};
		{ 19, 41310, "", "=q4=Furious Gladiator's Kodohide Robes", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 20, 41287, "", "=q4=Furious Gladiator's Kodohide Gloves", "=ds=", "43400 #faction# / 50 #eoftriumph#"};
		{ 21, 41298, "", "=q4=Furious Gladiator's Kodohide Legguards", "=ds=", "34700 #faction# / 75 #eoftriumph#"};
		{ 23, 0, "Spell_Nature_Regeneration", "=q6=#arenas1_3#", ""};
		{ 24, 41320, "", "=q4=Deadly Gladiator's Kodohide Helm", "=ds=", "58 #eofconquest#"};
		{ 25, 41274, "", "=q4=Deadly Gladiator's Kodohide Spaulders", "=ds=", "46 #eofconquest#"};
		{ 26, 41309, "", "=q4=Deadly Gladiator's Kodohide Robes", "=ds=", "58 #eofconquest#"};
		{ 27, 41286, "", "=q4=Deadly Gladiator's Kodohide Gloves", "=ds=", "46 #eofconquest#"};
		{ 28, 41297, "", "=q4=Deadly Gladiator's Kodohide Legguards", "=ds=", "58 #eofconquest#"};
		Next = "PvP80DruidRestoration2";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80DruidRestoration2"] = {
		{ 1, 0, "Spell_Nature_Regeneration", "=q6=#arenas1_3#", ""};
		{ 2, 41319, "", "=q4=Hateful Gladiator's Kodohide Helm", "=ds=", "45 #eofvalor#"};
		{ 3, 41273, "", "=q4=Hateful Gladiator's Kodohide Spaulders", "=ds=", "30 #eofvalor#"};
		{ 4, 41308, "", "=q4=Hateful Gladiator's Kodohide Robes", "=ds=", "45 #eofvalor#"};
		{ 5, 41284, "", "=q4=Hateful Gladiator's Kodohide Gloves", "=ds=", "30 #eofvalor#"};
		{ 6, 41296, "", "=q4=Hateful Gladiator's Kodohide Legguards", "=ds=", "45 #eofvalor#"};
		{ 8, 0, "Spell_Nature_Regeneration", "=q6=#arenas1_3#", ""};
		{ 9, 41269, "", "=q3=Savage Gladiator's Kodohide Helm", "=ds=", "45 #eofheroism#"};
		{ 10, 41271, "", "=q3=Savage Gladiator's Kodohide Spaulders", "=ds=", "30 #eofheroism#"};
		{ 11, 41272, "", "=q3=Savage Gladiator's Kodohide Robes", "=ds=", "45 #eofheroism#"};
		{ 12, 41268, "", "=q3=Savage Gladiator's Kodohide Gloves", "=ds=", "30 #eofheroism#"};
		{ 13, 41270, "", "=q3=Savage Gladiator's Kodohide Legguards", "=ds=", "45 #eofheroism#"};
		Prev = "PvP80DruidRestoration";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80Hunter"] = {
		{ 1, 0, "Ability_Hunter_RunningShot", "=q6=#arenas2#", ""};
		{ 2, 51460, "", "=q4=Wrathful Gladiator's Chain Helm", "=ds=", "2370 #arena# #reqrating# 1950"};
		{ 3, 51462, "", "=q4=Wrathful Gladiator's Chain Spaulders", "=ds=", "1930 #arena# #reqrating# 2000"};
		{ 4, 51458, "", "=q4=Wrathful Gladiator's Chain Armor", "=ds=", "2370 #arena# #reqrating# 1600"};
		{ 5, 51459, "", "=q4=Wrathful Gladiator's Chain Gauntlets", "=ds=", "1430 #arena# #reqrating# 1400"};
		{ 6, 51461, "", "=q4=Wrathful Gladiator's Chain Leggings", "=ds=", "2370 #arena# #reqrating# 1500"};
		{ 8, 0, "Ability_Hunter_RunningShot", "=q6=#arenas2#", ""};
		{ 9, 41158, "", "=q4=Relentless Gladiator's Chain Helm", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 10, 41218, "", "=q4=Relentless Gladiator's Chain Spaulders", "=ds=", "10550 #faction# 600 #arena# / 60 #eoffrost#"};
		{ 11, 41088, "", "=q4=Relentless Gladiator's Chain Armor", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 12, 41144, "", "=q4=Relentless Gladiator's Chain Gauntlets", "=ds=", "8000 #faction# 440 #arena# / 60 #eoffrost#"};
		{ 13, 41206, "", "=q4=Relentless Gladiator's Chain Leggings", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 16, 0, "Ability_Hunter_RunningShot", "=q6=#arenas2#", ""};
		{ 17, 41157, "", "=q4=Furious Gladiator's Chain Helm", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 18, 41217, "", "=q4=Furious Gladiator's Chain Spaulders", "=ds=", "34700 #faction# / 50 #eoftriumph#"};
		{ 19, 41087, "", "=q4=Furious Gladiator's Chain Armor", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 20, 41143, "", "=q4=Furious Gladiator's Chain Gauntlets", "=ds=", "43400 #faction# / 50 #eoftriumph#"};
		{ 21, 41205, "", "=q4=Furious Gladiator's Chain Leggings", "=ds=", "34700 #faction# / 75 #eoftriumph#"};
		{ 23, 0, "Ability_Hunter_RunningShot", "=q6=#arenas2#", ""};
		{ 24, 41156, "", "=q4=Deadly Gladiator's Chain Helm", "=ds=", "58 #eofconquest#"};
		{ 25, 41216, "", "=q4=Deadly Gladiator's Chain Spaulders", "=ds=", "46 #eofconquest#"};
		{ 26, 41086, "", "=q4=Deadly Gladiator's Chain Armor", "=ds=", "58 #eofconquest#"};
		{ 27, 41142, "", "=q4=Deadly Gladiator's Chain Gauntlets", "=ds=", "46 #eofconquest#"};
		{ 28, 41204, "", "=q4=Deadly Gladiator's Chain Leggings", "=ds=", "58 #eofconquest#"};
		Next = "PvP80Hunter2";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80Hunter2"] = {
		{ 1, 0, "Ability_Hunter_RunningShot", "=q6=#arenas2#", ""};
		{ 2, 41155, "", "=q4=Hateful Gladiator's Chain Helm", "=ds=", "45 #eofvalor#"};
		{ 3, 41215, "", "=q4=Hateful Gladiator's Chain Spaulders", "=ds=", "30 #eofvalor#"};
		{ 4, 41085, "", "=q4=Hateful Gladiator's Chain Armor", "=ds=", "45 #eofvalor#"};
		{ 5, 41141, "", "=q4=Hateful Gladiator's Chain Gauntlets", "=ds=", "30 #eofvalor#"};
		{ 6, 41203, "", "=q4=Hateful Gladiator's Chain Leggings", "=ds=", "45 #eofvalor#"};
		{ 8, 0, "Ability_Hunter_RunningShot", "=q6=#arenas2#", ""};
		{ 9, 41154, "", "=q3=Savage Gladiator's Chain Helm", "=ds=", "45 #eofheroism#"};
		{ 10, 41214, "", "=q3=Savage Gladiator's Chain Spaulders", "=ds=", "30 #eofheroism#"};
		{ 11, 41084, "", "=q3=Savage Gladiator's Chain Armor", "=ds=", "45 #eofheroism#"};
		{ 12, 41140, "", "=q3=Savage Gladiator's Chain Gauntlets", "=ds=", "30 #eofheroism#"};
		{ 13, 41202, "", "=q3=Savage Gladiator's Chain Leggings", "=ds=", "45 #eofheroism#"};
		Prev = "PvP80Hunter";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80Mage"] = {
		{ 1, 0, "Spell_Frost_IceStorm", "=q6=#arenas3#", ""};
		{ 2, 51465, "", "=q4=Wrathful Gladiator's Silk Cowl", "=ds=", "2370 #arena# #reqrating# 1950"};
		{ 3, 51467, "", "=q4=Wrathful Gladiator's Silk Amice", "=ds=", "1930 #arena# #reqrating# 2000"};
		{ 4, 51463, "", "=q4=Wrathful Gladiator's Silk Raiment", "=ds=", "2370 #arena# #reqrating# 1600"};
		{ 5, 51464, "", "=q4=Wrathful Gladiator's Silk Handguards", "=ds=", "1430 #arena# #reqrating# 1400"};
		{ 6, 51466, "", "=q4=Wrathful Gladiator's Silk Trousers", "=ds=", "2370 #arena# #reqrating# 1500"};
		{ 8, 0, "Spell_Frost_IceStorm", "=q6=#arenas3#", ""};
		{ 9, 41947, "", "=q4=Relentless Gladiator's Silk Cowl", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 10, 41966, "", "=q4=Relentless Gladiator's Silk Amice", "=ds=", "10550 #faction# 600 #arena# / 60 #eoffrost#"};
		{ 11, 41954, "", "=q4=Relentless Gladiator's Silk Raiment", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 12, 41972, "", "=q4=Relentless Gladiator's Silk Handguards", "=ds=", "8000 #faction# 440 #arena# / 60 #eoffrost#"};
		{ 13, 41960, "", "=q4=Relentless Gladiator's Silk Trousers", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 16, 0, "Spell_Frost_IceStorm", "=q6=#arenas3#", ""};
		{ 17, 41946, "", "=q4=Furious Gladiator's Silk Cowl", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 18, 41965, "", "=q4=Furious Gladiator's Silk Amice", "=ds=", "34700 #faction# / 50 #eoftriumph#"};
		{ 19, 41953, "", "=q4=Furious Gladiator's Silk Raiment", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 20, 41971, "", "=q4=Furious Gladiator's Silk Handguards", "=ds=", "43400 #faction# / 50 #eoftriumph#"};
		{ 21, 41959, "", "=q4=Furious Gladiator's Silk Trousers", "=ds=", "34700 #faction# / 75 #eoftriumph#"};
		{ 23, 0, "Spell_Frost_IceStorm", "=q6=#arenas3#", ""};
		{ 24, 41945, "", "=q4=Deadly Gladiator's Silk Cowl", "=ds=", "58 #eofconquest#"};
		{ 25, 41964, "", "=q4=Deadly Gladiator's Silk Amice", "=ds=", "46 #eofconquest#"};
		{ 26, 41951, "", "=q4=Deadly Gladiator's Silk Raiment", "=ds=", "58 #eofconquest#"};
		{ 27, 41970, "", "=q4=Deadly Gladiator's Silk Handguards", "=ds=", "46 #eofconquest#"};
		{ 28, 41958, "", "=q4=Deadly Gladiator's Silk Trousers", "=ds=", "58 #eofconquest#"};
		Next = "PvP80Mage2";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80Mage2"] = {
		{ 1, 0, "Spell_Frost_IceStorm", "=q6=#arenas3#", ""};
		{ 2, 41944, "", "=q4=Hateful Gladiator's Silk Cowl", "=ds=", "45 #eofvalor#"};
		{ 3, 41963, "", "=q4=Hateful Gladiator's Silk Amice", "=ds=", "30 #eofvalor#"};
		{ 4, 41950, "", "=q4=Hateful Gladiator's Silk Raiment", "=ds=", "45 #eofvalor#"};
		{ 5, 41969, "", "=q4=Hateful Gladiator's Silk Handguards", "=ds=", "30 #eofvalor#"};
		{ 6, 41957, "", "=q4=Hateful Gladiator's Silk Trousers", "=ds=", "45 #eofvalor#"};
		{ 8, 0, "Spell_Frost_IceStorm", "=q6=#arenas3#", ""};
		{ 9, 41943, "", "=q3=Savage Gladiator's Silk Cowl", "=ds=", "45 #eofheroism#"};
		{ 10, 41962, "", "=q3=Savage Gladiator's Silk Amice", "=ds=", "30 #eofheroism#"};
		{ 11, 41949, "", "=q3=Savage Gladiator's Silk Raiment", "=ds=", "45 #eofheroism#"};
		{ 12, 41968, "", "=q3=Savage Gladiator's Silk Handguards", "=ds=", "30 #eofheroism#"};
		{ 13, 41956, "", "=q3=Savage Gladiator's Silk", "=ds=", "45 #eofheroism#"};
		Prev = "PvP80Mage";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80PaladinRetribution"] = {
		{ 1, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", ""};
		{ 2, 51476, "", "=q4=Wrathful Gladiator's Scaled Helm", "=ds=", "2370 #arena# #reqrating# 1950"};
		{ 3, 51479, "", "=q4=Wrathful Gladiator's Scaled Shoulders", "=ds=", "1930 #arena# #reqrating# 2000"};
		{ 4, 51474, "", "=q4=Wrathful Gladiator's Scaled Chestpiece", "=ds=", "2370 #arena# #reqrating# 1600"};
		{ 5, 51475, "", "=q4=Wrathful Gladiator's Scaled Gauntlets", "=ds=", "1430 #arena# #reqrating# 1400"};
		{ 6, 51477, "", "=q4=Wrathful Gladiator's Scaled Legguards", "=ds=", "2370 #arena# #reqrating# 1500"};
		{ 8, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", ""};
		{ 9, 40831, "", "=q4=Relentless Gladiator's Scaled Helm", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 10, 40872, "", "=q4=Relentless Gladiator's Scaled Shoulders", "=ds=", "10550 #faction# 600 #arena# / 60 #eoffrost#"};
		{ 11, 40792, "", "=q4=Relentless Gladiator's Scaled Chestpiece", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 12, 40812, "", "=q4=Relentless Gladiator's Scaled Gauntlets", "=ds=", "8000 #faction# 440 #arena# / 60 #eoffrost#"};
		{ 13, 40852, "", "=q4=Relentless Gladiator's Scaled Legguards", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 16, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", ""};
		{ 17, 40828, "", "=q4=Furious Gladiator's Scaled Helm", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 18, 40869, "", "=q4=Furious Gladiator's Scaled Shoulders", "=ds=", "34700 #faction# / 50 #eoftriumph#"};
		{ 19, 40788, "", "=q4=Furious Gladiator's Scaled Chestpiece", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 20, 40808, "", "=q4=Furious Gladiator's Scaled Gauntlets", "=ds=", "43400 #faction# / 50 #eoftriumph#"};
		{ 21, 40849, "", "=q4=Furious Gladiator's Scaled Legguards", "=ds=", "34700 #faction# / 75 #eoftriumph#"};
		{ 23, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", ""};
		{ 24, 40825, "", "=q4=Deadly Gladiator's Scaled Helm", "=ds=", "58 #eofconquest#"};
		{ 25, 40864, "", "=q4=Deadly Gladiator's Scaled Shoulders", "=ds=", "46 #eofconquest#"};
		{ 26, 40785, "", "=q4=Deadly Gladiator's Scaled Chestpiece", "=ds=", "58 #eofconquest#"};
		{ 27, 40805, "", "=q4=Deadly Gladiator's Scaled Gauntlets", "=ds=", "46 #eofconquest#"};
		{ 28, 40846, "", "=q4=Deadly Gladiator's Scaled Legguards", "=ds=", "58 #eofconquest#"};
		Next = "PvP80PaladinRetribution2";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80PaladinRetribution2"] = {
		{ 1, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", ""};
		{ 2, 40821, "", "=q4=Hateful Gladiator's Scaled Helm", "=ds=", "45 #eofvalor#"};
		{ 3, 40861, "", "=q4=Hateful Gladiator's Scaled Shoulders", "=ds=", "30 #eofvalor#"};
		{ 4, 40782, "", "=q4=Hateful Gladiator's Scaled Chestpiece", "=ds=", "45 #eofvalor#"};
		{ 5, 40802, "", "=q4=Hateful Gladiator's Scaled Gauntlets", "=ds=", "30 #eofvalor#"};
		{ 6, 40842, "", "=q4=Hateful Gladiator's Scaled Legguards", "=ds=", "45 #eofvalor#"};
		{ 8, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", ""};
		{ 9, 40818, "", "=q3=Savage Gladiator's Scaled Helm", "=ds=", "45 #eofheroism#"};
		{ 10, 40858, "", "=q3=Savage Gladiator's Scaled Shoulders", "=ds=", "30 #eofheroism#"};
		{ 11, 40780, "", "=q3=Savage Gladiator's Scaled Chestpiece", "=ds=", "45 #eofheroism#"};
		{ 12, 40798, "", "=q3=Savage Gladiator's Scaled Gauntlets", "=ds=", "30 #eofheroism#"};
		{ 13, 40838, "", "=q3=Savage Gladiator's Scaled Legguards", "=ds=", "45 #eofheroism#"};
		Prev = "PvP80PaladinRetribution";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80PaladinHoly"] = {
		{ 1, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", ""};
		{ 2, 51470, "", "=q4=Wrathful Gladiator's Ornamented Headcover", "=ds=", "2370 #arena# #reqrating# 1950"};
		{ 3, 51473, "", "=q4=Wrathful Gladiator's Ornamented Spaulders", "=ds=", "1930 #arena# #reqrating# 2000"};
		{ 4, 51468, "", "=q4=Wrathful Gladiator's Ornamented Chestguard", "=ds=", "2370 #arena# #reqrating# 1600"};
		{ 5, 51469, "", "=q4=Wrathful Gladiator's Ornamented Gloves", "=ds=", "1430 #arena# #reqrating# 1400"};
		{ 6, 51471, "", "=q4=Wrathful Gladiator's Ornamented Legplates", "=ds=", "2370 #arena# #reqrating# 1500"};
		{ 8, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", ""};
		{ 9, 40934, "", "=q4=Relentless Gladiator's Ornamented Headcover", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 10, 40964, "", "=q4=Relentless Gladiator's Ornamented Spaulders", "=ds=", "10550 #faction# 600 #arena# / 60 #eoffrost#"};
		{ 11, 40910, "", "=q4=Relentless Gladiator's Ornamented Chestguard", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 12, 40928, "", "=q4=Relentless Gladiator's Ornamented Gloves", "=ds=", "8000 #faction# 440 #arena# / 60 #eoffrost#"};
		{ 13, 40940, "", "=q4=Relentless Gladiator's Ornamented Legplates", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 16, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", ""};
		{ 17, 40933, "", "=q4=Furious Gladiator's Ornamented Headcover", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 18, 40963, "", "=q4=Furious Gladiator's Ornamented Spaulders", "=ds=", "34700 #faction# / 50 #eoftriumph#"};
		{ 19, 40907, "", "=q4=Furious Gladiator's Ornamented Chestguard", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 20, 40927, "", "=q4=Furious Gladiator's Ornamented Gloves", "=ds=", "43400 #faction# / 50 #eoftriumph#"};
		{ 21, 40939, "", "=q4=Furious Gladiator's Ornamented Legplates", "=ds=", "34700 #faction# / 75 #eoftriumph#"};
		{ 23, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", ""};
		{ 24, 40932, "", "=q4=Deadly Gladiator's Ornamented Headcover", "=ds=", "58 #eofconquest#"};
		{ 25, 40962, "", "=q4=Deadly Gladiator's Ornamented Spaulders", "=ds=", "46 #eofconquest#"};
		{ 26, 40905, "", "=q4=Deadly Gladiator's Ornamented Chestguard", "=ds=", "58 #eofconquest#"};
		{ 27, 40926, "", "=q4=Deadly Gladiator's Ornamented Gloves", "=ds=", "46 #eofconquest#"};
		{ 28, 40938, "", "=q4=Deadly Gladiator's Ornamented Legplates", "=ds=", "58 #eofconquest#"};
		Next = "PvP80PaladinHoly2";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80PaladinHoly2"] = {
		{ 1, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", ""};
		{ 2, 40931, "", "=q4=Hateful Gladiator's Ornamented Headcover", "=ds=", "45 #eofvalor#"};
		{ 3, 40961, "", "=q4=Hateful Gladiator's Ornamented Spaulders", "=ds=", "30 #eofvalor#"};
		{ 4, 40904, "", "=q4=Hateful Gladiator's Ornamented Gloves", "=ds=", "45 #eofvalor#"};
		{ 5, 40925, "", "=q4=Hateful Gladiator's Ornamented Chestguard", "=ds=", "30 #eofvalor#"};
		{ 6, 40937, "", "=q4=Hateful Gladiator's Ornamented Legplates", "=ds=", "45 #eofvalor#"};
		{ 8, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", ""};
		{ 9, 40930, "", "=q3=Savage Gladiator's Ornamented Headcover", "=ds=", "45 #eofheroism#"};
		{ 10, 40960, "", "=q3=Savage Gladiator's Ornamented Spaulders", "=ds=", "30 #eofheroism#"};
		{ 11, 40898, "", "=q3=Savage Gladiator's Ornamented Chestguard", "=ds=", "45 #eofheroism#"};
		{ 12, 40918, "", "=q3=Savage Gladiator's Ornamented Gloves", "=ds=", "30 #eofheroism#"};
		{ 13, 40936, "", "=q3=Savage Gladiator's Ornamented Legplates", "=ds=", "45 #eofheroism#"};
		Prev = "PvP80PaladinHoly";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80PriestShadow"] = {
		{ 1, 0, "Spell_Shadow_AntiShadow", "=q6=#arenas5_1#", ""};
		{ 2, 51489, "", "=q4=Wrathful Gladiator's Satin Hood", "=ds=", "2370 #arena# #reqrating# 1950"};
		{ 3, 51491, "", "=q4=Wrathful Gladiator's Satin Mantle", "=ds=", "1930 #arena# #reqrating# 2000"};
		{ 4, 51487, "", "=q4=Wrathful Gladiator's Satin Robe", "=ds=", "2370 #arena# #reqrating# 1600"};
		{ 5, 51488, "", "=q4=Wrathful Gladiator's Satin Gloves", "=ds=", "1430 #arena# #reqrating# 1400"};
		{ 6, 51490, "", "=q4=Wrathful Gladiator's Satin Leggings", "=ds=", "2370 #arena# #reqrating# 1500"};
		{ 8, 0, "Spell_Shadow_AntiShadow", "=q6=#arenas5_1#", ""};
		{ 9, 41916, "", "=q4=Relentless Gladiator's Satin Hood", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 10, 41935, "", "=q4=Relentless Gladiator's Satin Mantle", "=ds=", "10550 #faction# 600 #arena# / 60 #eoffrost#"};
		{ 11, 41922, "", "=q4=Relentless Gladiator's Satin Robe", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 12, 41941, "", "=q4=Relentless Gladiator's Satin Gloves", "=ds=", "8000 #faction# 440 #arena# / 60 #eoffrost#"};
		{ 13, 41928, "", "=q4=Relentless Gladiator's Satin Leggings", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 16, 0, "Spell_Shadow_AntiShadow", "=q6=#arenas5_1#", ""};
		{ 17, 41915, "", "=q4=Furious Gladiator's Satin Hood", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 18, 41934, "", "=q4=Furious Gladiator's Satin Mantle", "=ds=", "34700 #faction# / 50 #eoftriumph#"};
		{ 19, 41921, "", "=q4=Furious Gladiator's Satin Robe", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 20, 41940, "", "=q4=Furious Gladiator's Satin Gloves", "=ds=", "43400 #faction# / 50 #eoftriumph#"};
		{ 21, 41927, "", "=q4=Furious Gladiator's Satin Leggings", "=ds=", "34700 #faction# / 75 #eoftriumph#"};
		{ 23, 0, "Spell_Shadow_AntiShadow", "=q6=#arenas5_1#", ""};
		{ 24, 41914, "", "=q4=Deadly Gladiator's Satin Hood", "=ds=", "58 #eofconquest#"};
		{ 25, 41933, "", "=q4=Deadly Gladiator's Satin Mantle", "=ds=", "46 #eofconquest#"};
		{ 26, 41920, "", "=q4=Deadly Gladiator's Satin Robe", "=ds=", "58 #eofconquest#"};
		{ 27, 41939, "", "=q4=Deadly Gladiator's Satin Gloves", "=ds=", "46 #eofconquest#"};
		{ 28, 41926, "", "=q4=Deadly Gladiator's Satin Leggings", "=ds=", "58 #eofconquest#"};
		Next = "PvP80PriestShadow2";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80PriestShadow2"] = {
		{ 1, 0, "Spell_Shadow_AntiShadow", "=q6=#arenas5_1#", ""};
		{ 2, 41913, "", "=q4=Hateful Gladiator's Satin Hood", "=ds=", "45 #eofvalor#"};
		{ 3, 41931, "", "=q4=Hateful Gladiator's Satin Mantle", "=ds=", "30 #eofvalor#"};
		{ 4, 41919, "", "=q4=Hateful Gladiator's Satin Robe", "=ds=", "45 #eofvalor#"};
		{ 5, 41938, "", "=q4=Hateful Gladiator's Satin Gloves", "=ds=", "30 #eofvalor#"};
		{ 6, 41925, "", "=q4=Hateful Gladiator's Satin Leggings", "=ds=", "45 #eofvalor#"};
		{ 8, 0, "Spell_Shadow_AntiShadow", "=q6=#arenas5_1#", ""};
		{ 9, 41912, "", "=q3=Savage Gladiator's Satin Hood", "=ds=", "45 #eofheroism#"};
		{ 10, 41930, "", "=q3=Savage Gladiator's Satin Mantle", "=ds=", "30 #eofheroism#"};
		{ 11, 41918, "", "=q3=Savage Gladiator's Satin Robe", "=ds=", "45 #eofheroism#"};
		{ 12, 41937, "", "=q3=Savage Gladiator's Satin Gloves", "=ds=", "30 #eofheroism#"};
		{ 13, 41924, "", "=q3=Savage Gladiator's Satin Leggings", "=ds=", "45 #eofheroism#"};
		Prev = "PvP80PriestShadow";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80PriestHoly"] = {
		{ 1, 0, "Spell_Holy_PowerWordShield", "=q6=#arenas5_2#", ""};
		{ 2, 51484, "", "=q4=Wrathful Gladiator's Mooncloth Hood", "=ds=", "2370 #arena# #reqrating# 1950"};
		{ 3, 51486, "", "=q4=Wrathful Gladiator's Mooncloth Mantle", "=ds=", "1930 #arena# #reqrating# 2000"};
		{ 4, 51482, "", "=q4=Wrathful Gladiator's Mooncloth Robe", "=ds=", "2370 #arena# #reqrating# 1600"};
		{ 5, 51483, "", "=q4=Wrathful Gladiator's Mooncloth Gloves", "=ds=", "1430 #arena# #reqrating# 1400"};
		{ 6, 51485, "", "=q4=Wrathful Gladiator's Mooncloth Leggings", "=ds=", "2370 #arena# #reqrating# 1500"};
		{ 8, 0, "Spell_Holy_PowerWordShield", "=q6=#arenas5_2#", ""};
		{ 9, 41855, "", "=q4=Relentless Gladiator's Mooncloth Hood", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 10, 41870, "", "=q4=Relentless Gladiator's Mooncloth Mantle", "=ds=", "10550 #faction# 600 #arena# / 60 #eoffrost#"};
		{ 11, 41860, "", "=q4=Relentless Gladiator's Mooncloth Robe", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 12, 41875, "", "=q4=Relentless Gladiator's Mooncloth Gloves", "=ds=", "8000 #faction# 440 #arena# / 60 #eoffrost#"};
		{ 13, 41865, "", "=q4=Relentless Gladiator's Mooncloth Leggings", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 16, 0, "Spell_Holy_PowerWordShield", "=q6=#arenas5_2#", ""};
		{ 17, 41854, "", "=q4=Furious Gladiator's Mooncloth Hood", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 18, 41869, "", "=q4=Furious Gladiator's Mooncloth Mantle", "=ds=", "34700 #faction# / 50 #eoftriumph#"};
		{ 19, 41859, "", "=q4=Furious Gladiator's Mooncloth Robe", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 20, 41874, "", "=q4=Furious Gladiator's Mooncloth Gloves", "=ds=", "43400 #faction# / 50 #eoftriumph#"};
		{ 21, 41864, "", "=q4=Furious Gladiator's Mooncloth Leggings", "=ds=", "34700 #faction# / 75 #eoftriumph#"};
		{ 23, 0, "Spell_Holy_PowerWordShield", "=q6=#arenas5_2#", ""};
		{ 24, 41853, "", "=q4=Deadly Gladiator's Mooncloth Hood", "=ds=", "58 #eofconquest#"};
		{ 25, 41868, "", "=q4=Deadly Gladiator's Mooncloth Mantle", "=ds=", "46 #eofconquest#"};
		{ 26, 41858, "", "=q4=Deadly Gladiator's Mooncloth Robe", "=ds=", "58 #eofconquest#"};
		{ 27, 41873, "", "=q4=Deadly Gladiator's Mooncloth Gloves", "=ds=", "46 #eofconquest#"};
		{ 28, 41863, "", "=q4=Deadly Gladiator's Mooncloth Leggings", "=ds=", "58 #eofconquest#"};
		Next = "PvP80PriestHoly2";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80PriestHoly2"] = {
		{ 1, 0, "Spell_Holy_PowerWordShield", "=q6=#arenas5_2#", ""};
		{ 2, 41852, "", "=q4=Hateful Gladiator's Mooncloth Hood", "=ds=", "45 #eofvalor#"};
		{ 3, 41867, "", "=q4=Hateful Gladiator's Mooncloth Mantle", "=ds=", "30 #eofvalor#"};
		{ 4, 41857, "", "=q4=Hateful Gladiator's Mooncloth Robe", "=ds=", "45 #eofvalor#"};
		{ 5, 41872, "", "=q4=Hateful Gladiator's Mooncloth Gloves", "=ds=", "30 #eofvalor#"};
		{ 6, 41862, "", "=q4=Hateful Gladiator's Mooncloth Leggings", "=ds=", "45 #eofvalor#"};
		{ 8, 0, "Spell_Holy_PowerWordShield", "=q6=#arenas5_2#", ""};
		{ 9, 41848, "", "=q3=Savage Gladiator's Mooncloth Hood", "=ds=", "45 #eofheroism#"};
		{ 10, 41850, "", "=q3=Savage Gladiator's Mooncloth Mantle", "=ds=", "30 #eofheroism#"};
		{ 11, 41851, "", "=q3=Savage Gladiator's Mooncloth Robe", "=ds=", "45 #eofheroism#"};
		{ 12, 41847, "", "=q3=Savage Gladiator's Mooncloth Gloves", "=ds=", "30 #eofheroism#"};
		{ 13, 41849, "", "=q3=Savage Gladiator's Mooncloth Leggings", "=ds=", "45 #eofheroism#"};
		Prev = "PvP80PriestHoly";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80Rogue"] = {
		{ 1, 0, "Ability_BackStab", "=q6=#arenas6#", ""};
		{ 2, 51494, "", "=q4=Wrathful Gladiator's Leather Helm", "=ds=", "2370 #arena# #reqrating# 1950"};
		{ 3, 51496, "", "=q4=Wrathful Gladiator's Leather Spaulders", "=ds=", "1930 #arena# #reqrating# 2000"};
		{ 4, 51492, "", "=q4=Wrathful Gladiator's Leather Tunic", "=ds=", "2370 #arena# #reqrating# 1600"};
		{ 5, 51493, "", "=q4=Wrathful Gladiator's Leather Gloves", "=ds=", "1430 #arena# #reqrating# 1400"};
		{ 6, 51495, "", "=q4=Wrathful Gladiator's Leather Legguards", "=ds=", "2370 #arena# #reqrating# 1500"};
		{ 8, 0, "Ability_BackStab", "=q6=#arenas6#", ""};
		{ 9, 41673, "", "=q4=Relentless Gladiator's Leather Helm", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 10, 41684, "", "=q4=Relentless Gladiator's Leather Spaulders", "=ds=", "10550 #faction# 600 #arena# / 60 #eoffrost#"};
		{ 11, 41651, "", "=q4=Relentless Gladiator's Leather Tunic", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 12, 41768, "", "=q4=Relentless Gladiator's Leather Gloves", "=ds=", "8000 #faction# 440 #arena# / 60 #eoffrost#"};
		{ 13, 41656, "", "=q4=Relentless Gladiator's Leather Legguards", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 16, 0, "Ability_BackStab", "=q6=#arenas6#", ""};
		{ 17, 41672, "", "=q4=Furious Gladiator's Leather Helm", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 18, 41683, "", "=q4=Furious Gladiator's Leather Spaulders", "=ds=", "34700 #faction# / 50 #eoftriumph#"};
		{ 19, 41650, "", "=q4=Furious Gladiator's Leather Tunic", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 20, 41767, "", "=q4=Furious Gladiator's Leather Gloves", "=ds=", "43400 #faction# / 50 #eoftriumph#"};
		{ 21, 41655, "", "=q4=Furious Gladiator's Leather Legguards", "=ds=", "34700 #faction# / 75 #eoftriumph#"};
		{ 23, 0, "Ability_BackStab", "=q6=#arenas6#", ""};
		{ 24, 41671, "", "=q4=Deadly Gladiator's Leather Helm", "=ds=", "58 #eofconquest#"};
		{ 25, 41682, "", "=q4=Deadly Gladiator's Leather Spaulders", "=ds=", "46 #eofconquest#"};
		{ 26, 41649, "", "=q4=Deadly Gladiator's Leather Tunic", "=ds=", "58 #eofconquest#"};
		{ 27, 41766, "", "=q4=Deadly Gladiator's Leather Gloves", "=ds=", "46 #eofconquest#"};
		{ 28, 41654, "", "=q4=Deadly Gladiator's Leather Legguards", "=ds=", "58 #eofconquest#"};
		Next = "PvP80Rogue2";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80Rogue2"] = {
		{ 1, 0, "Ability_BackStab", "=q6=#arenas6#", ""};
		{ 2, 41670, "", "=q4=Hateful Gladiator's Leather Helm", "=ds=", "45 #eofvalor#"};
		{ 3, 41681, "", "=q4=Hateful Gladiator's Leather Spaulders", "=ds=", "30 #eofvalor#"};
		{ 4, 41648, "", "=q4=Hateful Gladiator's Leather Tunic", "=ds=", "45 #eofvalor#"};
		{ 5, 41765, "", "=q4=Hateful Gladiator's Leather Gloves", "=ds=", "30 #eofvalor#"};
		{ 6, 41653, "", "=q4=Hateful Gladiator's Leather Legguards", "=ds=", "45 #eofvalor#"};
		{ 8, 0, "Ability_BackStab", "=q6=#arenas6#", ""};
		{ 9, 41644, "", "=q3=Savage Gladiator's Leather Helm", "=ds=", "45 #eofheroism#"};
		{ 10, 41646, "", "=q3=Savage Gladiator's Leather Spaulders", "=ds=", "30 #eofheroism#"};
		{ 11, 41647, "", "=q3=Savage Gladiator's Leather Tunic", "=ds=", "45 #eofheroism#"};
		{ 12, 41643, "", "=q3=Savage Gladiator's Leather Gloves", "=ds=", "30 #eofheroism#"};
		{ 13, 41645, "", "=q3=Savage Gladiator's Leather Legguards", "=ds=", "45 #eofheroism#"};
		Prev = "PvP80Rogue";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80ShamanElemental"] = {
		{ 1, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", ""};
		{ 2, 51511, "", "=q4=Wrathful Gladiator's Mail Helm", "=ds=", "2370 #arena# #reqrating# 1950"};
		{ 3, 51514, "", "=q4=Wrathful Gladiator's Mail Spaulders", "=ds=", "1930 #arena# #reqrating# 2000"};
		{ 4, 51509, "", "=q4=Wrathful Gladiator's Mail Armor", "=ds=", "2370 #arena# #reqrating# 1600"};
		{ 5, 51510, "", "=q4=Wrathful Gladiator's Mail Gauntlets", "=ds=", "1430 #arena# #reqrating# 1400"};
		{ 6, 51512, "", "=q4=Wrathful Gladiator's Mail Leggings", "=ds=", "2370 #arena# #reqrating# 1500"};
		{ 8, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", ""};
		{ 9, 41020, "", "=q4=Relentless Gladiator's Mail Helm", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 10, 41045, "", "=q4=Relentless Gladiator's Mail Spaulders", "=ds=", "10550 #faction# 600 #arena# / 60 #eoffrost#"};
		{ 11, 40995, "", "=q4=Relentless Gladiator's Mail Armor", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 12, 41008, "", "=q4=Relentless Gladiator's Mail Gauntlets", "=ds=", "8000 #faction# 440 #arena# / 60 #eoffrost#"};
		{ 13, 41034, "", "=q4=Relentless Gladiator's Mail Leggings", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 16, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", ""};
		{ 17, 41019, "", "=q4=Furious Gladiator's Mail Helm", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 18, 41044, "", "=q4=Furious Gladiator's Mail Spaulders", "=ds=", "34700 #faction# / 50 #eoftriumph#"};
		{ 19, 40993, "", "=q4=Furious Gladiator's Mail Armor", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 20, 41007, "", "=q4=Furious Gladiator's Mail Gauntlets", "=ds=", "43400 #faction# / 50 #eoftriumph#"};
		{ 21, 41033, "", "=q4=Furious Gladiator's Mail Leggings", "=ds=", "34700 #faction# / 75 #eoftriumph#"};
		{ 23, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", ""};
		{ 24, 41018, "", "=q4=Deadly Gladiator's Mail Helm", "=ds=", "58 #eofconquest#"};
		{ 25, 41043, "", "=q4=Deadly Gladiator's Mail Spaulders", "=ds=", "46 #eofconquest#"};
		{ 26, 40991, "", "=q4=Deadly Gladiator's Mail Armor", "=ds=", "58 #eofconquest#"};
		{ 27, 41006, "", "=q4=Deadly Gladiator's Mail Gauntlets", "=ds=", "46 #eofconquest#"};
		{ 28, 41032, "", "=q4=Deadly Gladiator's Mail Leggings", "=ds=", "58 #eofconquest#"};
		Next = "PvP80ShamanElemental2";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80ShamanElemental2"] = {
		{ 1, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", ""};
		{ 2, 41017, "", "=q4=Hateful Gladiator's Mail Helm", "=ds=", "45 #eofvalor#"};
		{ 3, 41042, "", "=q4=Hateful Gladiator's Mail Spaulders", "=ds=", "30 #eofvalor#"};
		{ 4, 40989, "", "=q4=Hateful Gladiator's Mail Armor", "=ds=", "45 #eofvalor#"};
		{ 5, 41005, "", "=q4=Hateful Gladiator's Mail Gauntlets", "=ds=", "30 #eofvalor#"};
		{ 6, 41031, "", "=q4=Hateful Gladiator's Mail Leggings", "=ds=", "45 #eofvalor#"};
		{ 8, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", ""};
		{ 9, 41016, "", "=q3=Savage Gladiator's Mail Helm", "=ds=", "45 #eofheroism#"};
		{ 10, 41041, "", "=q3=Savage Gladiator's Mail Spaulders", "=ds=", "30 #eofheroism#"};
		{ 11, 40987, "", "=q3=Savage Gladiator's Mail Armor", "=ds=", "45 #eofheroism#"};
		{ 12, 41004, "", "=q3=Savage Gladiator's Mail Gauntlets", "=ds=", "30 #eofheroism#"};
		{ 13, 41030, "", "=q3=Savage Gladiator's Mail Leggings", "=ds=", "45 #eofheroism#"};
		Prev = "PvP80ShamanElemental";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80ShamanEnhancement"] = {
		{ 1, 0, "Spell_FireResistanceTotem_01", "=q6=#arenas7_1#", ""};
		{ 2, 51505, "", "=q4=Wrathful Gladiator's Linked Helm", "=ds=", "2370 #arena# #reqrating# 1950"};
		{ 3, 51508, "", "=q4=Wrathful Gladiator's Linked Spaulders", "=ds=", "1930 #arena# #reqrating# 2000"};
		{ 4, 51503, "", "=q4=Wrathful Gladiator's Linked Armor", "=ds=", "2370 #arena# #reqrating# 1600"};
		{ 5, 51504, "", "=q4=Wrathful Gladiator's Linked Gauntlets", "=ds=", "1430 #arena# #reqrating# 1400"};
		{ 6, 51506, "", "=q4=Wrathful Gladiator's Linked Leggings", "=ds=", "2370 #arena# #reqrating# 1500"};
		{ 8, 0, "Spell_FireResistanceTotem_01", "=q6=#arenas7_1#", ""};
		{ 9, 41152, "", "=q4=Relentless Gladiator's Linked Helm", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 10, 41212, "", "=q4=Relentless Gladiator's Linked Spaulders", "=ds=", "10550 #faction# 600 #arena# / 60 #eoffrost#"};
		{ 11, 41082, "", "=q4=Relentless Gladiator's Linked Armor", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 12, 41138, "", "=q4=Relentless Gladiator's Linked Gauntlets", "=ds=", "8000 #faction# 440 #arena# / 60 #eoffrost#"};
		{ 13, 41200, "", "=q4=Relentless Gladiator's Linked Leggings", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 16, 0, "Spell_FireResistanceTotem_01", "=q6=#arenas7_1#", ""};
		{ 17, 41151, "", "=q4=Furious Gladiator's Linked Helm", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 18, 41211, "", "=q4=Furious Gladiator's Linked Spaulders", "=ds=", "34700 #faction# / 50 #eoftriumph#"};
		{ 19, 41081, "", "=q4=Furious Gladiator's Linked Armor", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 20, 41137, "", "=q4=Furious Gladiator's Linked Gauntlets", "=ds=", "43400 #faction# / 50 #eoftriumph#"};
		{ 21, 41199, "", "=q4=Furious Gladiator's Linked Leggings", "=ds=", "34700 #faction# / 75 #eoftriumph#"};
		{ 23, 0, "Spell_FireResistanceTotem_01", "=q6=#arenas7_1#", ""};
		{ 24, 41150, "", "=q4=Deadly Gladiator's Linked Helm", "=ds=", "58 #eofconquest#"};
		{ 25, 41210, "", "=q4=Deadly Gladiator's Linked Spaulders", "=ds=", "46 #eofconquest#"};
		{ 26, 41080, "", "=q4=Deadly Gladiator's Linked Armor", "=ds=", "58 #eofconquest#"};
		{ 27, 41136, "", "=q4=Deadly Gladiator's Linked Gauntlets", "=ds=", "46 #eofconquest#"};
		{ 28, 41198, "", "=q4=Deadly Gladiator's Linked Leggings", "=ds=", "58 #eofconquest#"};
		Next = "PvP80ShamanEnhancement2";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80ShamanEnhancement2"] = {
		{ 1, 0, "Spell_FireResistanceTotem_01", "=q6=#arenas7_1#", ""};
		{ 2, 41149, "", "=q4=Hateful Gladiator's Linked Helm", "=ds=", "45 #eofvalor#"};
		{ 3, 41209, "", "=q4=Hateful Gladiator's Linked Spaulders", "=ds=", "30 #eofvalor#"};
		{ 4, 41079, "", "=q4=Hateful Gladiator's Linked Armor", "=ds=", "45 #eofvalor#"};
		{ 5, 41135, "", "=q4=Hateful Gladiator's Linked Gauntlets", "=ds=", "30 #eofvalor#"};
		{ 6, 41162, "", "=q4=Hateful Gladiator's Linked Leggings", "=ds=", "45 #eofvalor#"};
		{ 8, 0, "Spell_FireResistanceTotem_01", "=q6=#arenas7_1#", ""};
		{ 9, 41148, "", "=q3=Savage Gladiator's Linked Helm", "=ds=", "45 #eofheroism#"};
		{ 10, 41208, "", "=q3=Savage Gladiator's Linked Spaulders", "=ds=", "30 #eofheroism#"};
		{ 11, 41078, "", "=q3=Savage Gladiator's Linked Armor", "=ds=", "45 #eofheroism#"};
		{ 12, 41134, "", "=q3=Savage Gladiator's Linked Gauntlets", "=ds=", "30 #eofheroism#"};
		{ 13, 41160, "", "=q3=Savage Gladiator's Linked Leggings", "=ds=", "45 #eofheroism#"};
		Prev = "PvP80ShamanEnhancement";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80ShamanRestoration"] = {
		{ 1, 0, "Spell_Nature_HealingWaveGreater", "=q6=#arenas7_3#", ""};
		{ 2, 51499, "", "=q4=Wrathful Gladiator's Ringmail Helm", "=ds=", "2370 #arena# #reqrating# 1950"};
		{ 3, 51502, "", "=q4=Wrathful Gladiator's Ringmail Spaulders", "=ds=", "1930 #arena# #reqrating# 2000"};
		{ 4, 51497, "", "=q4=Wrathful Gladiator's Ringmail Armor", "=ds=", "2370 #arena# #reqrating# 1600"};
		{ 5, 51498, "", "=q4=Wrathful Gladiator's Ringmail Gauntlets", "=ds=", "1430 #arena# #reqrating# 1400"};
		{ 6, 51500, "", "=q4=Wrathful Gladiator's Ringmail Leggings", "=ds=", "2370 #arena# #reqrating# 1500"};
		{ 8, 0, "Spell_Nature_HealingWaveGreater", "=q6=#arenas7_3#", ""};
		{ 9, 41014, "", "=q4=Relentless Gladiator's Ringmail Helm", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 10, 41039, "", "=q4=Relentless Gladiator's Ringmail Spaulders", "=ds=", "10550 #faction# 600 #arena# / 60 #eoffrost#"};
		{ 11, 40994, "", "=q4=Relentless Gladiator's Ringmail Armor", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 12, 41002, "", "=q4=Relentless Gladiator's Ringmail Gauntlets", "=ds=", "8000 #faction# 440 #arena# / 60 #eoffrost#"};
		{ 13, 41028, "", "=q4=Relentless Gladiator's Ringmail Leggings", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 16, 0, "Spell_Nature_HealingWaveGreater", "=q6=#arenas7_3#", ""};
		{ 17, 41013, "", "=q4=Furious Gladiator's Ringmail Helm", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 18, 41038, "", "=q4=Furious Gladiator's Ringmail Spaulders", "=ds=", "34700 #faction# / 50 #eoftriumph#"};
		{ 19, 40992, "", "=q4=Furious Gladiator's Ringmail Armor", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 20, 41001, "", "=q4=Furious Gladiator's Ringmail Gauntlets", "=ds=", "43400 #faction# / 50 #eoftriumph#"};
		{ 21, 41027, "", "=q4=Furious Gladiator's Ringmail Leggings", "=ds=", "34700 #faction# / 75 #eoftriumph#"};
		{ 23, 0, "Spell_Nature_HealingWaveGreater", "=q6=#arenas7_3#", ""};
		{ 24, 41012, "", "=q4=Deadly Gladiator's Ringmail Helm", "=ds=", "58 #eofconquest#"};
		{ 25, 41037, "", "=q4=Deadly Gladiator's Ringmail Spaulders", "=ds=", "46 #eofconquest#"};
		{ 26, 40990, "", "=q4=Deadly Gladiator's Ringmail Armor", "=ds=", "58 #eofconquest#"};
		{ 27, 41000, "", "=q4=Deadly Gladiator's Ringmail Gauntlets", "=ds=", "46 #eofconquest#"};
		{ 28, 41026, "", "=q4=Deadly Gladiator's Ringmail Leggings", "=ds=", "58 #eofconquest#"};
		Next = "PvP80ShamanRestoration2";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80ShamanRestoration2"] = {
		{ 1, 0, "Spell_Nature_HealingWaveGreater", "=q6=#arenas7_3#", ""};
		{ 2, 41011, "", "=q4=Hateful Gladiator's Ringmail Helm", "=ds=", "45 #eofvalor#"};
		{ 3, 41036, "", "=q4=Hateful Gladiator's Ringmail Spaulders", "=ds=", "30 #eofvalor#"};
		{ 4, 40988, "", "=q4=Hateful Gladiator's Ringmail Armor", "=ds=", "45 #eofvalor#"};
		{ 5, 40999, "", "=q4=Hateful Gladiator's Ringmail Gauntlets", "=ds=", "30 #eofvalor#"};
		{ 6, 41025, "", "=q4=Hateful Gladiator's Ringmail Leggings", "=ds=", "45 #eofvalor#"};
		{ 8, 0, "Spell_Nature_HealingWaveGreater", "=q6=#arenas7_3#", ""};
		{ 9, 41010, "", "=q3=Savage Gladiator's Ringmail Helm", "=ds=", "45 #eofheroism#"};
		{ 10, 41024, "", "=q3=Savage Gladiator's Ringmail Spaulders", "=ds=", "30 #eofheroism#"};
		{ 11, 40986, "", "=q3=Savage Gladiator's Ringmail Armor", "=ds=", "45 #eofheroism#"};
		{ 12, 40998, "", "=q3=Savage Gladiator's Ringmail Gauntlets", "=ds=", "30 #eofheroism#"};
		{ 13, 41023, "", "=q3=Savage Gladiator's Ringmail Leggings", "=ds=", "45 #eofheroism#"};
		Prev = "PvP80ShamanRestoration";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80Warlock"] = {
		{ 1, 0, "Spell_Shadow_CurseOfTounges", "=q6=#arenas8_2#", ""};
		{ 2, 51538, "", "=q4=Wrathful Gladiator's Felweave Cowl", "=ds=", "2370 #arena# #reqrating# 1950"};
		{ 3, 51540, "", "=q4=Wrathful Gladiator's Felweave Amice", "=ds=", "1930 #arena# #reqrating# 2000"};
		{ 4, 51536, "", "=q4=Wrathful Gladiator's Felweave Raiment", "=ds=", "2370 #arena# #reqrating# 1600"};
		{ 5, 51537, "", "=q4=Wrathful Gladiator's Felweave Handguards", "=ds=", "1430 #arena# #reqrating# 1400"};
		{ 6, 51539, "", "=q4=Wrathful Gladiator's Felweave Trousers", "=ds=", "2370 #arena# #reqrating# 1500"};
		{ 8, 0, "Spell_Shadow_CurseOfTounges", "=q6=#arenas8_2#", ""};
		{ 9, 41994, "", "=q4=Relentless Gladiator's Felweave Cowl", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 10, 42012, "", "=q4=Relentless Gladiator's Felweave Amice", "=ds=", "10550 #faction# 600 #arena# / 60 #eoffrost#"};
		{ 11, 41999, "", "=q4=Relentless Gladiator's Felweave Raiment", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 12, 42018, "", "=q4=Relentless Gladiator's Felweave Handguards", "=ds=", "8000 #faction# 440 #arena# / 60 #eoffrost#"};
		{ 13, 42006, "", "=q4=Relentless Gladiator's Felweave Trousers", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 16, 0, "Spell_Shadow_CurseOfTounges", "=q6=#arenas8_2#", ""};
		{ 17, 41993, "", "=q4=Furious Gladiator's Felweave Cowl", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 18, 42011, "", "=q4=Furious Gladiator's Felweave Amice", "=ds=", "34700 #faction# / 50 #eoftriumph#"};
		{ 19, 41998, "", "=q4=Furious Gladiator's Felweave Raiment", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 20, 42017, "", "=q4=Furious Gladiator's Felweave Handguards", "=ds=", "43400 #faction# / 50 #eoftriumph#"};
		{ 21, 42005, "", "=q4=Furious Gladiator's Felweave Trousers", "=ds=", "34700 #faction# / 75 #eoftriumph#"};
		{ 23, 0, "Spell_Shadow_CurseOfTounges", "=q6=#arenas8_2#", ""};
		{ 24, 41992, "", "=q4=Deadly Gladiator's Felweave Cowl", "=ds=", "58 #eofconquest#"};
		{ 25, 42010, "", "=q4=Deadly Gladiator's Felweave Amice", "=ds=", "46 #eofconquest#"};
		{ 26, 41997, "", "=q4=Deadly Gladiator's Felweave Raiment", "=ds=", "58 #eofconquest#"};
		{ 27, 42016, "", "=q4=Deadly Gladiator's Felweave Handguards", "=ds=", "46 #eofconquest#"};
		{ 28, 42004, "", "=q4=Deadly Gladiator's Felweave Trousers", "=ds=", "58 #eofconquest#"};
		Next = "PvP80Warlock2";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80Warlock2"] = {
		{ 1, 0, "Spell_Shadow_CurseOfTounges", "=q6=#arenas8_2#", ""};
		{ 2, 41991, "", "=q4=Hateful Gladiator's Felweave Cowl", "=ds=", "45 #eofvalor#"};
		{ 3, 42009, "", "=q4=Hateful Gladiator's Felweave Amice", "=ds=", "30 #eofvalor#"};
		{ 4, 42001, "", "=q4=Hateful Gladiator's Felweave Raiment", "=ds=", "45 #eofvalor#"};
		{ 5, 42015, "", "=q4=Hateful Gladiator's Felweave Handguards", "=ds=", "30 #eofvalor#"};
		{ 6, 42003, "", "=q4=Hateful Gladiator's Felweave Trousers", "=ds=", "45 #eofvalor#"};
		{ 8, 0, "Spell_Shadow_CurseOfTounges", "=q6=#arenas8_2#", ""};
		{ 9, 41990, "", "=q3=Savage Gladiator's Felweave Cowl", "=ds=", "45 #eofheroism#"};
		{ 10, 42008, "", "=q3=Savage Gladiator's Felweave Amice", "=ds=", "30 #eofheroism#"};
		{ 11, 41996, "", "=q3=Savage Gladiator's Felweave Raiment", "=ds=", "45 #eofheroism#"};
		{ 12, 42014, "", "=q3=Savage Gladiator's Felweave Handguards", "=ds=", "30 #eofheroism#"};
		{ 13, 42002, "", "=q3=Savage Gladiator's Felweave Trousers", "=ds=", "45 #eofheroism#"};
		Prev = "PvP80Warlock";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80Warrior"] = {
		{ 1, 0, "Ability_Warrior_BattleShout", "=q6=#arenas9#", ""};
		{ 2, 51543, "", "=q4=Wrathful Gladiator's Plate Helm", "=ds=", "2370 #arena# #reqrating# 1950"};
		{ 3, 51545, "", "=q4=Wrathful Gladiator's Plate Shoulders", "=ds=", "1930 #arena# #reqrating# 2000"};
		{ 4, 51541, "", "=q4=Wrathful Gladiator's Plate Chestpiece", "=ds=", "2370 #arena# #reqrating# 1600"};
		{ 5, 51542, "", "=q4=Wrathful Gladiator's Plate Gauntlets", "=ds=", "1430 #arena# #reqrating# 1400"};
		{ 6, 51544, "", "=q4=Wrathful Gladiator's Plate Legguards", "=ds=", "2370 #arena# #reqrating# 1500"};
		{ 8, 0, "Ability_Warrior_BattleShout", "=q6=#arenas9#", ""};
		{ 9, 40829, "", "=q4=Relentless Gladiator's Plate Helm", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 10, 40870, "", "=q4=Relentless Gladiator's Plate Shoulders", "=ds=", "10550 #faction# 600 #arena# / 60 #eoffrost#"};
		{ 11, 40790, "", "=q4=Relentless Gladiator's Plate Chestpiece", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 12, 40810, "", "=q4=Relentless Gladiator's Plate Gauntlets", "=ds=", "8000 #faction# 440 #arena# / 60 #eoffrost#"};
		{ 13, 40850, "", "=q4=Relentless Gladiator's Plate Legguards", "=ds=", "13200 #faction# 770 #arena# / 95 #eoffrost#"};
		{ 16, 0, "Ability_Warrior_BattleShout", "=q6=#arenas9#", ""};
		{ 17, 40826, "", "=q4=Furious Gladiator's Plate Helm", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 18, 40866, "", "=q4=Furious Gladiator's Plate Shoulders", "=ds=", "34700 #faction# / 50 #eoftriumph#"};
		{ 19, 40789, "", "=q4=Furious Gladiator's Plate Chestpiece", "=ds=", "54500 #faction# / 75 #eoftriumph#"};
		{ 20, 40807, "", "=q4=Furious Gladiator's Plate Gauntlets", "=ds=", "43400 #faction# / 50 #eoftriumph#"};
		{ 21, 40847, "", "=q4=Furious Gladiator's Plate Legguards", "=ds=", "34700 #faction# / 75 #eoftriumph#"};
		{ 23, 0, "Ability_Warrior_BattleShout", "=q6=#arenas9#", ""};
		{ 24, 40823, "", "=q4=Deadly Gladiator's Plate Helm", "=ds=", "58 #eofconquest#"};
		{ 25, 40862, "", "=q4=Deadly Gladiator's Plate Shoulders", "=ds=", "46 #eofconquest#"};
		{ 26, 40786, "", "=q4=Deadly Gladiator's Plate Chestpiece", "=ds=", "58 #eofconquest#"};
		{ 27, 40804, "", "=q4=Deadly Gladiator's Plate Gauntlets", "=ds=", "46 #eofconquest#"};
		{ 28, 40844, "", "=q4=Deadly Gladiator's Plate Legguards", "=ds=", "58 #eofconquest#"};
		Next = "PvP80Warrior2";
		Back = "LEVEL80PVPSETS";
	};

	AtlasLoot_Data["PvP80Warrior2"] = {
		{ 1, 0, "Ability_Warrior_BattleShout", "=q6=#arenas9#", ""};
		{ 2, 40819, "", "=q4=Hateful Gladiator's Plate Helm", "=ds=", "45 #eofvalor#"};
		{ 3, 40859, "", "=q4=Hateful Gladiator's Plate Shoulders", "=ds=", "30 #eofvalor#"};
		{ 4, 40783, "", "=q4=Hateful Gladiator's Plate Chestpiece", "=ds=", "45 #eofvalor#"};
		{ 5, 40801, "", "=q4=Hateful Gladiator's Plate Gauntlets", "=ds=", "30 #eofvalor#"};
		{ 6, 40840, "", "=q4=Hateful Gladiator's Plate Legguards", "=ds=", "45 #eofvalor#"};
		{ 8, 0, "Ability_Warrior_BattleShout", "=q6=#arenas9#", ""};
		{ 9, 40816, "", "=q3=Savage Gladiator's Plate Helm", "=ds=", "45 #eofheroism#"};
		{ 10, 40856, "", "=q3=Savage Gladiator's Plate Shoulders", "=ds=", "30 #eofheroism#"};
		{ 11, 40778, "", "=q3=Savage Gladiator's Plate Chestpiece", "=ds=", "45 #eofheroism#"};
		{ 12, 40797, "", "=q3=Savage Gladiator's Plate Gauntlets", "=ds=", "30 #eofheroism#"};
		{ 13, 40836, "", "=q3=Savage Gladiator's Plate Legguards", "=ds=", "45 #eofheroism#"};
		Prev = "PvP80Warrior";
		Back = "LEVEL80PVPSETS";
	};

		------------------------------
		--- Level 80 Epic Non-Sets ---
		------------------------------

	AtlasLoot_Data["PvP80NonSet1"] = {
		{ 1, 51334, "", "=q4=Wrathful Gladiator's Cloak of Ascendancy", "=ds=", "52200 #faction#"};
		{ 2, 51348, "", "=q4=Wrathful Gladiator's Cloak of Deliverance", "=ds=", "52200 #faction#"};
		{ 3, 51330, "", "=q4=Wrathful Gladiator's Cloak of Dominance", "=ds=", "52200 #faction#"};
		{ 4, 51346, "", "=q4=Wrathful Gladiator's Cloak of Salvation", "=ds=", "52200 #faction#"};
		{ 5, 51332, "", "=q4=Wrathful Gladiator's Cloak of Subjugation", "=ds=", "52200 #faction#"};
		{ 6, 51354, "", "=q4=Wrathful Gladiator's Cloak of Triumph", "=ds=", "52200 #faction#"};
		{ 7, 51356, "", "=q4=Wrathful Gladiator's Cloak of Victory", "=ds=", "52200 #faction#"};
		{ 9, 51336, "", "=q4=Wrathful Gladiator's Band of Dominance", "=ds=", "52200 #faction#"};
		{ 10, 51358, "", "=q4=Wrathful Gladiator's Band of Triumph", "=ds=", "52200 #faction#"};
		{ 12, 51377, "", "=q4=Medallion of the Alliance", "=ds=", "68200 #faction#"};
		{ 13, 51378, "", "=q4=Medallion of the Horde", "=ds=", "68200 #faction#"};
		{ 16, 51335, "", "=q4=Wrathful Gladiator's Pendant of Ascendancy", "=ds=", "52200 #faction#"};
		{ 17, 51349, "", "=q4=Wrathful Gladiator's Pendant of Deliverance", "=ds=", "52200 #faction#"};
		{ 18, 51331, "", "=q4=Wrathful Gladiator's Pendant of Dominance", "=ds=", "52200 #faction#"};
		{ 19, 51347, "", "=q4=Wrathful Gladiator's Pendant of Salvation", "=ds=", "52200 #faction#"};
		{ 20, 51333, "", "=q4=Wrathful Gladiator's Pendant of Subjugation", "=ds=", "52200 #faction#"};
		{ 21, 51353, "", "=q4=Wrathful Gladiator's Pendant of Sundering", "=ds=", "52200 #faction#"};
		{ 22, 51355, "", "=q4=Wrathful Gladiator's Pendant of Triumph", "=ds=", "52200 #faction#"};
		{ 23, 51357, "", "=q4=Wrathful Gladiator's Pendant of Victory", "=ds=", "52200 #faction#"};
		{ 25, 42133, "", "=q4=Battlemaster's Fury", "=ds=", "34100 #faction#"};
		{ 26, 42134, "", "=q4=Battlemaster's Precision", "=ds=", "34100 #faction#"};
		{ 27, 42136, "", "=q4=Battlemaster's Rage", "=ds=", "34100 #faction#"};
		{ 28, 42137, "", "=q4=Battlemaster's Ruination", "=ds=", "34100 #faction#"};
		{ 29, 42135, "", "=q4=Battlemaster's Vivacity", "=ds=", "34100 #faction#"};
		Next = "PvP80NonSet2";
		Back = "PVPMENU";
	};

	AtlasLoot_Data["PvP80NonSet2"] = {
		{ 1, 42078, "", "=q4=Relentless Gladiator's Cloak of Ascendancy", "=ds=", "26100 #faction#"};
		{ 2, 42080, "", "=q4=Relentless Gladiator's Cloak of Deliverance", "=ds=", "26100 #faction#"};
		{ 3, 42076, "", "=q4=Relentless Gladiator's Cloak of Dominance", "=ds=", "26100 #faction#"};
		{ 4, 42079, "", "=q4=Relentless Gladiator's Cloak of Salvation", "=ds=", "26100 #faction#"};
		{ 5, 42077, "", "=q4=Relentless Gladiator's Cloak of Subjugation", "=ds=", "26100 #faction#"};
		{ 6, 42081, "", "=q4=Relentless Gladiator's Cloak of Triumph", "=ds=", "26100 #faction#"};
		{ 7, 42082, "", "=q4=Relentless Gladiator's Cloak of Victory", "=ds=", "26100 #faction#"};
		{ 9, 42118, "", "=q4=Relentless Gladiator's Band of Ascendancy", "=ds=", "26100 #faction#"};
		{ 10, 42119, "", "=q4=Relentless Gladiator's Band of Victory", "=ds=", "26100 #faction#"};
		{ 16, 42044, "", "=q4=Relentless Gladiator's Pendant of Ascendancy", "=ds=", "26100 #faction#"};
		{ 17, 42046, "", "=q4=Relentless Gladiator's Pendant of Deliverance", "=ds=", "26100 #faction#"};
		{ 18, 42043, "", "=q4=Relentless Gladiator's Pendant of Dominance", "=ds=", "26100 #faction#"};
		{ 19, 42047, "", "=q4=Relentless Gladiator's Pendant of Salvation", "=ds=", "26100 #faction#"};
		{ 20, 42045, "", "=q4=Relentless Gladiator's Pendant of Subjugation", "=ds=", "26100 #faction#"};
		{ 21, 46374, "", "=q4=Relentless Gladiator's Pendant of Sundering", "=ds=", "26100 #faction#"};
		{ 22, 42041, "", "=q4=Relentless Gladiator's Pendant of Triumph", "=ds=", "26100 #faction#"};
		{ 23, 42042, "", "=q4=Relentless Gladiator's Pendant of Victory", "=ds=", "26100 #faction#"};
		Prev = "PvP80NonSet1";
		Back = "PVPMENU";
	};

--Cloth
	AtlasLoot_Data["PvP80NonSet3"] = {
		{ 1, 51329, "", "=q4=Wrathful Gladiator's Cuffs of Dominance", "=ds=", "43400 #faction#"};
		{ 2, 51327, "", "=q4=Wrathful Gladiator's Cord of Dominance", "=ds=", "68200 #faction# #reqrating# 1300"};
		{ 3, 51328, "", "=q4=Wrathful Gladiator's Treads of Dominance", "=ds=", "68200 #faction# #reqrating# 1400"};
		{ 5, 51367, "", "=q4=Wrathful Gladiator's Cuffs of Salvation", "=ds=", "43400 #faction#"};
		{ 6, 51365, "", "=q4=Wrathful Gladiator's Cord of Salvation", "=ds=", "68200 #faction# #reqrating# 1300"};
		{ 7, 51366, "", "=q4=Wrathful Gladiator's Treads of Salvation", "=ds=", "68200 #faction# #reqrating# 1400"};
		{ 9, 51339, "", "=q4=Wrathful Gladiator's Cuffs of Alacrity", "=ds=", "43400 #faction#"};
		{ 10, 51337, "", "=q4=Wrathful Gladiator's Cord of Alacrity", "=ds=", "68200 #faction# #reqrating# 1300"};
		{ 11, 51338, "", "=q4=Wrathful Gladiator's Treads of Alacrity", "=ds=", "68200 #faction# #reqrating# 1400"};
		{ 16, 41910, "", "=q4=Relentless Gladiator's Cuffs of Dominance", "=ds=", "21700 #faction#"};
		{ 17, 41899, "", "=q4=Relentless Gladiator's Cord of Dominance", "=ds=", "34100 #faction#"};
		{ 18, 41904, "", "=q4=Relentless Gladiator's Treads of Dominance", "=ds=", "34100 #faction#"};
		{ 20, 41894, "", "=q4=Relentless Gladiator's Cuffs of Salvation", "=ds=", "21700 #faction#"};
		{ 21, 41882, "", "=q4=Relentless Gladiator's Cord of Salvation", "=ds=", "34100 #faction#"};
		{ 22, 41886, "", "=q4=Relentless Gladiator's Treads of Salvation", "=ds=", "34100 #faction#"};
		{ 24, 49181, "", "=q4=Relentless Gladiator's Cuffs of Alacrity", "=ds=", "21700 #faction#"};
		{ 25, 49179, "", "=q4=Relentless Gladiator's Cord of Alacrity", "=ds=", "34100 #faction#"};
		{ 26, 49183, "", "=q4=Relentless Gladiator's Treads of Alacrity", "=ds=", "34100 #faction#"};
		Next = "PvP80NonSet4";
		Back = "PVP80NONSETEPICS";
	};

--Leather
	AtlasLoot_Data["PvP80NonSet4"] = {
		{ 1, 51345, "", "=q4=Wrathful Gladiator's Armwraps of Dominance", "=ds=", "43400 #faction#"};
		{ 2, 51343, "", "=q4=Wrathful Gladiator's Belt of Dominance", "=ds=", "68200 #faction# #reqrating# 1300"};
		{ 3, 51344, "", "=q4=Wrathful Gladiator's Boots of Dominance", "=ds=", "68200 #faction# #reqrating# 1400"};
		{ 5, 51342, "", "=q4=Wrathful Gladiator's Armwraps of Salvation", "=ds=", "43400 #faction#"};
		{ 6, 51340, "", "=q4=Wrathful Gladiator's Belt of Salvation", "=ds=", "68200 #faction# #reqrating# 1300"};
		{ 7, 51341, "", "=q4=Wrathful Gladiator's Boots of Salvation", "=ds=", "68200 #faction# #reqrating# 1400"};
		{ 9, 51370, "", "=q4=Wrathful Gladiator's Armwraps of Triumph", "=ds=", "43400 #faction#"};
		{ 10, 51368, "", "=q4=Wrathful Gladiator's Belt of Triumph", "=ds=", "68200 #faction# #reqrating# 1300"};
		{ 11, 51369, "", "=q4=Wrathful Gladiator's Boots of Triumph", "=ds=", "68200 #faction# #reqrating# 1400"};
		{ 16, 41641, "", "=q4=Relentless Gladiator's Armwraps of Dominance", "=ds=", "21700 #faction#"};
		{ 17, 41631, "", "=q4=Relentless Gladiator's Belt of Dominance", "=ds=", "34100 #faction#"};
		{ 18, 41636, "", "=q4=Relentless Gladiator's Boots of Dominance", "=ds=", "34100 #faction#"};
		{ 20, 41626, "", "=q4=Relentless Gladiator's Armwraps of Salvation", "=ds=", "21700 #faction#"};
		{ 21, 41618, "", "=q4=Relentless Gladiator's Belt of Salvation", "=ds=", "34100 #faction#"};
		{ 22, 41622, "", "=q4=Relentless Gladiator's Boots of Salvation", "=ds=", "34100 #faction#"};
		{ 24, 41841, "", "=q4=Relentless Gladiator's Armwraps of Triumph", "=ds=", "21700 #faction#"};
		{ 25, 41833, "", "=q4=Relentless Gladiator's Belt of Triumph", "=ds=", "34100 #faction#"};
		{ 26, 41837, "", "=q4=Relentless Gladiator's Boots of Triumph", "=ds=", "34100 #faction#"};
		Next = "PvP80NonSet5";
		Prev = "PvP80NonSet3";
		Back = "PVP80NONSETEPICS";
	};

--Mail
	AtlasLoot_Data["PvP80NonSet5"] = {
		{ 1, 51376, "", "=q4=Wrathful Gladiator's Wristguards of Dominance", "=ds=", "43400 #faction#"};
		{ 2, 51374, "", "=q4=Wrathful Gladiator's Waistguard of Dominance", "=ds=", "68200 #faction# #reqrating# 1300"};
		{ 3, 51375, "", "=q4=Wrathful Gladiator's Sabatons of Dominance", "=ds=", "68200 #faction# #reqrating# 1400"};
		{ 5, 51373, "", "=q4=Wrathful Gladiator's Wristguards of Salvation", "=ds=", "43400 #faction#"};
		{ 6, 51371, "", "=q4=Wrathful Gladiator's Waistguard of Salvation", "=ds=", "68200 #faction# #reqrating# 1300"};
		{ 7, 51372, "", "=q4=Wrathful Gladiator's Sabatons of Salvation", "=ds=", "68200 #faction# #reqrating# 1400"};
		{ 9, 51352, "", "=q4=Wrathful Gladiator's Wristguards of Triumph", "=ds=", "43400 #faction#"};
		{ 10, 51350, "", "=q4=Wrathful Gladiator's Waistguard of Triumph", "=ds=", "68200 #faction# #reqrating# 1300"};
		{ 11, 51351, "", "=q4=Wrathful Gladiator's Sabatons of Triumph", "=ds=", "68200 #faction# #reqrating# 1400"};
		{ 16, 41066, "", "=q4=Relentless Gladiator's Wristguards of Dominance", "=ds=", "21700 #faction#"};
		{ 17, 41071, "", "=q4=Relentless Gladiator's Waistguard of Dominance", "=ds=", "34100 #faction#"};
		{ 18, 41076, "", "=q4=Relentless Gladiator's Sabatons of Dominance", "=ds=", "34100 #faction#"};
		{ 20, 41061, "", "=q4=Relentless Gladiator's Wristguards of Salvation", "=ds=", "21700 #faction#"};
		{ 21, 41052, "", "=q4=Relentless Gladiator's Waistguard of Salvation", "=ds=", "34100 #faction#"};
		{ 22, 41056, "", "=q4=Relentless Gladiator's Sabatons of Salvation", "=ds=", "34100 #faction#"};
		{ 24, 41226, "", "=q4=Relentless Gladiator's Wristguards of Triumph", "=ds=", "21700 #faction#"};
		{ 25, 41236, "", "=q4=Relentless Gladiator's Waistguard of Triumph", "=ds=", "34100 #faction#"};
		{ 26, 41231, "", "=q4=Relentless Gladiator's Sabatons of Triumph", "=ds=", "34100 #faction#"};
		Next = "PvP80NonSet6";
		Prev = "PvP80NonSet4";
		Back = "PVP80NONSETEPICS";
	};

--Plate
	AtlasLoot_Data["PvP80NonSet6"] = {
		{ 1, 51361, "", "=q4=Wrathful Gladiator's Bracers of Salvation", "=ds=", "43400 #faction#"};
		{ 2, 51359, "", "=q4=Wrathful Gladiator's Girdle of Salvation", "=ds=", "68200 #faction# #reqrating# 1300"};
		{ 3, 51360, "", "=q4=Wrathful Gladiator's Greaves of Salvation", "=ds=", "68200 #faction# #reqrating# 1400"};
		{ 5, 51364, "", "=q4=Wrathful Gladiator's Bracers of Triumph", "=ds=", "43400 #faction#"};
		{ 6, 51362, "", "=q4=Wrathful Gladiator's Girdle of Triumph", "=ds=", "68200 #faction# #reqrating# 1300"};
		{ 7, 51363, "", "=q4=Wrathful Gladiator's Greaves of Triumph", "=ds=", "68200 #faction# #reqrating# 1400"};
		{ 16, 40984, "", "=q4=Relentless Gladiator's Bracers of Salvation", "=ds=", "21700 #faction#"};
		{ 17, 40978, "", "=q4=Relentless Gladiator's Girdle of Salvation", "=ds=", "34100 #faction#"};
		{ 18, 40979, "", "=q4=Relentless Gladiator's Greaves of Salvation", "=ds=", "34100 #faction#"};
		{ 20, 40890, "", "=q4=Relentless Gladiator's Bracers of Triumph", "=ds=", "21700 #faction#"};
		{ 21, 40883, "", "=q4=Relentless Gladiator's Girdle of Triumph", "=ds=", "34100 #faction#"};
		{ 22, 40884, "", "=q4=Relentless Gladiator's Greaves of Triumph", "=ds=", "34100 #faction#"};
		Prev = "PvP80NonSet5";
		Next = "PvP80ClassItems1";
		Back = "PVP80NONSETEPICS";
	};

		------------------------------------
		--- Wrathful Gladiator Weapons ---
		------------------------------------

	AtlasLoot_Data["WrathfulGladiatorWeapons1"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Low Level"], ""};
		{ 2, 51523, "", "=q4=Wrathful Gladiator's Right Ripper", "=ds=#h3#, #w13#", "38500 #faction# 1090 #arena# #reqrating# 1800"};
		{ 3, 51530, "", "=q4=Wrathful Gladiator's Left Render", "=ds=#h4#, #w13#", "16500 #faction# 450 #arena# #reqrating# 1800"};
		{ 4, 51443, "", "=q4=Wrathful Gladiator's Left Ripper", "=ds=#h4#, #w13#", "15000 #faction# 1100 #arena# #reqrating# 1800"};
		{ 5, 51406, "", "=q4=Wrathful Gladiator's Blade of Alacrity", "=ds=#h3#, #w4#", "38500 #faction# 1300 #arena# #reqrating# 1800"};
		{ 6, 51397, "", "=q4=Wrathful Gladiator's Spellblade", "=ds=#h3#, #w4#", "38500 #faction# 1300 #arena# #reqrating# 1800"};
		{ 7, 51517, "", "=q4=Wrathful Gladiator's Shanker", "=ds=#h1#, #w4#", "38500 #faction# 1090 #arena# #reqrating# 1800"};
		{ 8, 51527, "", "=q4=Wrathful Gladiator's Mutilator", "=ds=#h4#, #w4#", "16500 #faction# 450 #arena# #reqrating# 1800"};
		{ 9, 51441, "", "=q4=Wrathful Gladiator's Shiv", "=ds=#h4#, #w4#", "16500 #faction# 450 #arena# #reqrating# 1800"};
		{ 10, 51521, "", "=q4=Wrathful Gladiator's Slicer", "=ds=#h1#, #w10#", "38500 #faction# 1090 #arena# #reqrating# 1800"};
		{ 11, 51447, "", "=q4=Wrathful Gladiator's Quickblade", "=ds=#h4#, #w10#", "16500 #faction# 450 #arena# #reqrating# 1800"};
		{ 12, 51392, "", "=q4=Wrathful Gladiator's Greatsword", "=ds=#h2#, #w10#", "55000 #faction# 1540 #arena# #reqrating# 1800"};
		{ 13, 51515, "", "=q4=Wrathful Gladiator's Cleaver", "=ds=#h1#, #w1#", "38500 #faction# 1090 #arena# #reqrating# 1800"};
		{ 14, 51525, "", "=q4=Wrathful Gladiator's Chopper", "=ds=#h4#, #w1#", "16500 #faction# 450 #arena# #reqrating# 1800"};
		{ 15, 51439, "", "=q4=Wrathful Gladiator's Hacker", "=ds=#h4#, #w1#", "16500 #faction# 450 #arena# #reqrating# 1800"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["High Level"], ""};
		{ 17, 51524, "", "=q4=Wrathful Gladiator's Grasp", "=ds=#h3#, #w13#", "3300 #arena# #reqrating# 2200"};
		{ 18, 51529, "", "=q4=Wrathful Gladiator's Left Claw", "=ds=#h4#, #w13#", "1370 #arena# #reqrating# 2200"};
		{ 19, 51444, "", "=q4=Wrathful Gladiator's Left Razor", "=ds=#h4#, #w13#", "1370 #arena# #reqrating# 2200"};
		{ 20, 51398, "", "=q4=Wrathful Gladiator's Blade of Celerity", "=ds=#h3#, #w4#", "3950 #arena# #reqrating# 2200"};
		{ 21, 51399, "", "=q4=Wrathful Gladiator's Mageblade", "=ds=#h3#, #w4#", "3950 #arena# #reqrating# 2200"};
		{ 22, 51518, "", "=q4=Wrathful Gladiator's Spike", "=ds=#h1#, #w4#", "3300 #arena# #reqrating# 2200"};
		{ 23, 51442, "", "=q4=Wrathful Gladiator's Dirk", "=ds=#h4#, #w4#", "1370 #arena# #reqrating# 2200"};
		{ 24, 51528, "", "=q4=Wrathful Gladiator's Eviscerator", "=ds=#h4#, #w4#", "1370 #arena# #reqrating# 2200"};
		{ 25, 51522, "", "=q4=Wrathful Gladiator's Longblade", "=ds=#h1#, #w10#", "3300 #arena# #reqrating# 2200"};
		{ 26, 51448, "", "=q4=Wrathful Gladiator's Swiftblade", "=ds=#h4#, #w10#", "1370 #arena# #reqrating# 2200"};
		{ 27, 51393, "", "=q4=Wrathful Gladiator's Claymore", "=ds=#h2#, #w10#", "4670 #arena# #reqrating# 2200"};
		{ 28, 51516, "", "=q4=Wrathful Gladiator's Handaxe", "=ds=#h1#, #w1#", "3300 #arena# #reqrating# 2200"};
		{ 29, 51440, "", "=q4=Wrathful Gladiator's Dicer", "=ds=#h4#, #w1#", "1370 #arena# #reqrating# 2200"};
		{ 30, 51526, "", "=q4=Wrathful Gladiator's Splitter", "=ds=#h4#, #w1#", "1370 #arena# #reqrating# 2200"};
		Next = "WrathfulGladiatorWeapons2";
		Back = "PVPMENU";
	};

	AtlasLoot_Data["WrathfulGladiatorWeapons2"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Low Level"], ""};
		{ 2, 51388, "", "=q4=Wrathful Gladiator's Decapitator", "=ds=#h2#, #w1#", "55000 #faction# 1540 #arena# #reqrating# 1800"};
		{ 3, 51453, "", "=q4=Wrathful Gladiator's Gavel", "=ds=#h3#, #w6#", "38500 #faction# 1300 #arena# #reqrating# 1800"};
		{ 4, 51519, "", "=q4=Wrathful Gladiator's Pummeler", "=ds=#h1#, #w6#", "38500 #faction# 1090 #arena# #reqrating# 1800"};
		{ 5, 51445, "", "=q4=Wrathful Gladiator's Bonecracker", "=ds=#h4#, #w6#", "16500 #faction# 450 #arena# #reqrating# 1800"};
		{ 6, 51390, "", "=q4=Wrathful Gladiator's Bonegrinder", "=ds=#h2#, #w6#", "55000 #faction# 1540 #arena# #reqrating# 1800"};
		{ 7, 51480, "", "=q4=Wrathful Gladiator's Pike", "=ds=#w7#", "55000 #faction# 1540 #arena# #reqrating# 1800"};
		{ 8, 51404, "", "=q4=Wrathful Gladiator's Battle Staff", "=ds=#w9#", "55000 #faction# 1540 #arena# #reqrating# 1800"};
		{ 9, 51456, "", "=q4=Wrathful Gladiator's Energy Staff", "=ds=#w9#", "55000 #faction# 1540 #arena# #reqrating# 1800"};
		{ 10, 51402, "", "=q4=Wrathful Gladiator's Focus Staff", "=ds=#w9#", "55000 #faction# 1540 #arena# #reqrating# 1800"};
		{ 11, 51431, "", "=q4=Wrathful Gladiator's Staff", "=ds=#w9#", "55000 #faction# 1540 #arena# #reqrating# 1800"};
		{ 12, 51400, "", "=q4=Wrathful Gladiator's War Staff", "=ds=#w9#", "55000 #faction# 1540 #arena# #reqrating# 1800"};
		{ 13, 51394, "", "=q4=Wrathful Gladiator's Longbow", "=ds=#w2#", "55000 #faction# 1540 #arena# #reqrating# 1800"};
		{ 14, 51411, "", "=q4=Wrathful Gladiator's Heavy Crossbow", "=ds=#w3#", "55000 #faction# 1540 #arena# #reqrating# 1800"};
		{ 15, 51449, "", "=q4=Wrathful Gladiator's Rifle", "=ds=#w5#", "55000 #faction# 1540 #arena# #reqrating# 1800"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["High Level"], ""};
		{ 17, 51389, "", "=q4=Wrathful Gladiator's Sunderer", "=ds=#h2#, #w1#", "4670 #arena# #reqrating# 2200"};
		{ 18, 51454, "", "=q4=Wrathful Gladiator's Salvation", "=ds=#h3#, #w6#", "3950 #arena# #reqrating# 2200"};
		{ 19, 51520, "", "=q4=Wrathful Gladiator's Truncheon", "=ds=#h1#, #w6#", "3300 #arena# #reqrating# 2200"};
		{ 20, 51446, "", "=q4=Wrathful Gladiator's Punisher", "=ds=#h4#, #w6#", "1370 #arena# #reqrating# 2200"};
		{ 21, 51391, "", "=q4=Wrathful Gladiator's Crusher", "=ds=#h2#, #w6#", "4670 #arena# #reqrating# 2200"};
		{ 22, 51481, "", "=q4=Wrathful Gladiator's Halberd", "=ds=#w7#", "4670 #arena# #reqrating# 2200"};
		{ 23, 51403, "", "=q4=Wrathful Gladiator's Acute Staff", "=ds=#w9#", "4670 #arena# #reqrating# 2200"};
		{ 24, 51401, "", "=q4=Wrathful Gladiator's Combat Staff", "=ds=#w9#", "4670 #arena# #reqrating# 2200"};
		{ 25, 51432, "", "=q4=Wrathful Gladiator's Greatstaff", "=ds=#w9#", "4670 #arena# #reqrating# 2200"};
		{ 26, 51457, "", "=q4=Wrathful Gladiator's Light Staff", "=ds=#w9#", "4670 #arena# #reqrating# 2200"};
		{ 27, 51405, "", "=q4=Wrathful Gladiator's Skirmish Staff", "=ds=#w9#", "4670 #arena# #reqrating# 2200"};
		{ 28, 51395, "", "=q4=Wrathful Gladiator's Recurve", "=ds=#w2#", "4670 #arena# #reqrating# 2200"};
		{ 29, 51412, "", "=q4=Wrathful Gladiator's Repeater", "=ds=#w3#", "4670 #arena# #reqrating# 2200"};
		{ 30, 51450, "", "=q4=Wrathful Gladiator's Shotgun", "=ds=#w5#", "4670 #arena# #reqrating# 2200"};
		Prev = "WrathfulGladiatorWeapons1";
		Next = "WrathfulGladiatorWeapons3";
		Back = "PVPMENU";
	};

	AtlasLoot_Data["WrathfulGladiatorWeapons3"] = {
		{ 1, 51452, "", "=q4=Wrathful Gladiator's Barrier", "=ds=#w8#", "350 #arena# #reqrating# 1800"};
		{ 2, 51455, "", "=q4=Wrathful Gladiator's Redoubt", "=ds=#w8#", "350 #arena# #reqrating# 1800"};
		{ 3, 51533, "", "=q4=Wrathful Gladiator's Shield Wall", "=ds=#w8#", "350 #arena# #reqrating# 1800"};
		{ 4, 51535, "", "=q4=Wrathful Gladiator's War Edge", "=ds=#w11#", "1260 #arena# #reqrating# 1700"};
		{ 5, 51532, "", "=q4=Wrathful Gladiator's Baton of Light", "=ds=#w12#", "1260 #arena# #reqrating# 1700"};
		{ 6, 51531, "", "=q4=Wrathful Gladiator's Piercing Touch", "=ds=#w12#", "1260 #arena# #reqrating# 1700"};
		{ 7, 51410, "", "=q4=Wrathful Gladiator's Touch of Defeat", "=ds=#w12#", "1260 #arena# #reqrating# 1700"};
		{ 8, 51451, "", "=q4=Wrathful Gladiator's Wand of Alacrity", "=ds=#w12#", "1260 #arena# #reqrating# 1700"};
		{ 9, 51407, "", "=q4=Wrathful Gladiator's Compendium", "=ds=#s15#", "350 #arena# #reqrating# 1800"};
		{ 10, 51396, "", "=q4=Wrathful Gladiator's Endgame", "=ds=#s15#", "350 #arena# #reqrating# 1800"};
		{ 11, 51408, "", "=q4=Wrathful Gladiator's Grimoire", "=ds=#s15#", "350 #arena# #reqrating# 1800"};
		{ 12, 51409, "", "=q4=Wrathful Gladiator's Reprieve", "=ds=#s15#", "350 #arena# #reqrating# 1800"};
		Prev = "WrathfulGladiatorWeapons2";
		Back = "PVPMENU";
	};

		-----------------------
		--- PvP Class Items ---
		-----------------------

	AtlasLoot_Data["PvP80ClassItems1"] = {
		{ 1, 0, "INV_Box_01", "=q6="..BabbleInventory["Idols"], ""};
		{ 2, 51429, "", "=q4=Wrathful Gladiator's Idol of Resolve", "=ds=#w14#", "1260 #arena# #reqrating# 1700"};
		{ 3, 51437, "", "=q4=Wrathful Gladiator's Idol of Steadfastness", "=ds=#w14#", "1260 #arena# #reqrating# 1700"};
		{ 4, 51423, "", "=q4=Wrathful Gladiator's Idol of Tenacity", "=ds=#w14#", "1260 #arena# #reqrating# 1700"};
		{ 6, 42591, "", "=q4=Relentless Gladiator's Idol of Resolve", "=ds=#w14#", "6400 #faction# 350 #arena# #reqrating# 700"};
		{ 7, 42585, "", "=q4=Relentless Gladiator's Idol of Steadfastness", "=ds=#w14#", "6400 #faction# 350 #arena# #reqrating# 700"};
		{ 8, 42580, "", "=q4=Relentless Gladiator's Idol of Tenacity", "=ds=#w14#", "6400 #faction# 350 #arena# #reqrating# 700"};
		{ 10, 42589, "", "=q4=Furious Gladiator's Idol of Resolve", "12000 #faction#"};
		{ 11, 42584, "", "=q4=Furious Gladiator's Idol of Steadfastness", "12000 #faction#"};
		{ 12, 42579, "", "=q4=Furious Gladiator's Idol of Tenacity", "12000 #faction#"};
		{ 16, 0, "INV_Box_01", "=q6="..BabbleInventory["Librams"], ""};
		{ 17, 51478, "", "=q4=Wrathful Gladiator's Libram of Fortitude", "=ds=#w16#", "1260 #arena# #reqrating# 1700"};
		{ 18, 51472, "", "=q4=Wrathful Gladiator's Libram of Justice", "=ds=#w16#", "1260 #arena# #reqrating# 1700"};
		{ 20, 42854, "", "=q4=Relentless Gladiator's Libram of Fortitude", "=ds=#w16#", "6400 #faction# 350 #arena# #reqrating# 700"};
		{ 21, 42616, "", "=q4=Relentless Gladiator's Libram of Justice", "=ds=#w16#", "6400 #faction# 350 #arena# #reqrating# 700"};
		{ 23, 42853, "", "=q4=Furious Gladiator's Libram of Fortitude", "12000 #faction#"};
		{ 24, 42615, "", "=q4=Furious Gladiator's Libram of Justice", "12000 #faction#"};
		Prev = "PvP80NonSet6";
		Next = "PvP80ClassItems2";
		Back = "PVP80NONSETEPICS";
	};

	AtlasLoot_Data["PvP80ClassItems2"] = {
		{ 1, 0, "INV_Box_01", "=q6="..BabbleInventory["Sigils"], ""};
		{ 2, 51417, "", "=q4=Wrathful Gladiator's Sigil of Strife", "=ds=#w21#", "1260 #arena# #reqrating# 1700"};
		{ 4, 42622, "", "=q4=Relentless Gladiator's Sigil of Strife", "=ds=#w21#", "6400 #faction# 350 #arena# #reqrating# 700"};
		{ 6, 42621, "", "=q4=Furious Gladiator's Sigil of Strife", "12000 #faction#"};
		{ 16, 0, "INV_Box_01", "=q6="..BabbleInventory["Totems"], ""};
		{ 17, 51507, "", "=q4=Wrathful Gladiator's Totem of Indomitability", "=ds=#w15#", "1260 #arena# #reqrating# 1700"};
		{ 18, 51513, "", "=q4=Wrathful Gladiator's Totem of Survival", "=ds=#w15#", "1260 #arena# #reqrating# 1700"};
		{ 19, 51501, "", "=q4=Wrathful Gladiator's Totem of the Third Wind", "=ds=#w15#", "1260 #arena# #reqrating# 1700"};
		{ 21, 42609, "", "=q4=Relentless Gladiator's Totem of Indomitability", "=ds=#w15#", "6400 #faction# 350 #arena# #reqrating# 700"};
		{ 22, 42604, "", "=q4=Relentless Gladiator's Totem of Survival", "=ds=#w15#", "6400 #faction# 350 #arena# #reqrating# 700"};
		{ 23, 42599, "", "=q4=Relentless Gladiator's Totem of the Third Wind", "=ds=#w15#", "6400 #faction# 350 #arena# #reqrating# 700"};
		{ 25, 42608, "", "=q4=Furious Gladiator's Totem of Indomitability", "12000 #faction#"};
		{ 26, 42603, "", "=q4=Furious Gladiator's Totem of Survival", "12000 #faction#"};
		{ 27, 42598, "", "=q4=Furious Gladiator's Totem of the Third Wind", "12000 #faction#"};
		Prev = "PvP80ClassItems1";
		Back = "PVP80NONSETEPICS";
	};

		-------------------------
		--- PvP Miscellaneous ---
		-------------------------

	AtlasLoot_Data["PvP80Misc"] = {
		{ 1, 51534, "", "=q4=Wrathful Gladiator's Tabard", "=ds=#s7#", "550 #arena# #reqrating# 2300" };
		{ 2, 44957, "", "=q4=Greater Inscription of the Gladiator", "=ds=#s3# #e17#", "10000 #faction#" };
		{ 3, 45706, "", "=q4=Commendation of Bravery", "=ds=", "100 #arena#" };
		{ 5, 36931, "", "=q4=Ametrine", "=ds=#e7#", "10000 #faction#" };
		{ 6, 36919, "", "=q4=Cardinal Ruby", "=ds=#e7#", "10000 #faction#" };
		{ 7, 36928, "", "=q4=Dreadstone", "=ds=#e7#", "10000 #faction#" };
		{ 8, 36934, "", "=q4=Eye of Zul", "=ds=#e7#", "10000 #faction#" };
		{ 9, 36922, "", "=q4=King's Amber", "=ds=#e7#", "10000 #faction#" };
		{ 10, 36925, "", "=q4=Majestic Zircon", "=ds=#e7#", "10000 #faction#" };
		{ 16, 41563, "", "=q2=Design: Durable Huge Citrine", "=ds=#p12# (350)", "1250 #faction#"};
		{ 17, 41564, "", "=q2=Design: Empowered Huge Citrine", "=ds=#p12# (350)", "1250 #faction#"};
		{ 18, 41565, "", "=q2=Design: Lucent Huge Citrine", "=ds=#p12# (350)", "1250 #faction#"};
		{ 19, 41575, "", "=q2=Design: Mysterious Shadow Crystal", "=ds=#p12# (350)", "1250 #faction#"};
		{ 20, 41559, "", "=q2=Design: Mystic Sun Crystal", "=ds=#p12# (350)", "1250 #faction#"};
		{ 21, 41573, "", "=q2=Design: Opaque Dark Jade", "=ds=#p12# (350)", "1250 #faction#"};
		{ 22, 41566, "", "=q2=Design: Resplendent Huge Citrine", "=ds=#p12# (350)", "1250 #faction#"};
		{ 23, 41569, "", "=q2=Design: Shattered Dark Jade", "=ds=#p12# (350)", "1250 #faction#"};
		{ 24, 41572, "", "=q2=Design: Steady Dark Jade", "=ds=#p12# (350)", "1250 #faction#"};
		{ 25, 41560, "", "=q2=Design: Stormy Chalcedony", "=ds=#p12# (350)", "1250 #faction#"};
		{ 26, 41570, "", "=q2=Design: Tense Dark Jade", "=ds=#p12# (350)", "1250 #faction#"};
		{ 27, 41571, "", "=q2=Design: Turbid Dark Jade", "=ds=#p12# (350)", "1250 #faction#"};
		Back = "PVPMENU";
	};

		--------------------------------
		--- World PvP - Wintergrasp  ---
		--------------------------------

	AtlasLoot_Data["LakeWintergrasp1"] = {
		{ 1, 51570, "", "=q4=Titan-Forged Cloak of Ascendancy", "=ds=#s4#", "25 #wintergraspmark#" };
		{ 2, 51571, "", "=q4=Titan-Forged Cloak of Victory", "=ds=#s4#", "25 #wintergraspmark#" };
		{ 4, 46083, "", "=q4=Titan-Forged Rune of Accuracy", "=ds=#s14#", "25 #wintergraspmark#" };
		{ 5, 46085, "", "=q4=Titan-Forged Rune of Alacrity", "=ds=#s14#", "25 #wintergraspmark#" };
		{ 6, 46081, "", "=q4=Titan-Forged Rune of Audacity", "=ds=#s14#", "25 #wintergraspmark#" };
		{ 7, 46084, "", "=q4=Titan-Forged Rune of Cruelty", "=ds=#s14#", "25 #wintergraspmark#" };
		{ 9, 46082, "", "=q4=Titan-Forged Rune of Determination", "=ds=#s14#", "25 #wintergraspmark#" };
		{ 10, 43956, "", "=q4=Reins of the Black War Mammoth", "=ds=#e12#", "300 #wintergrasp#"};
		{ 11, 44077, "", "=q4=Reins of the Black War Mammoth", "=ds=#e12#", "300 #wintergrasp#"};
		{ 16, 51568, "", "=q4=Titan-Forged Pendant of Ascendancy", "=ds=#s4#", "25 #wintergraspmark#" };
		{ 17, 51569, "", "=q4=Titan-Forged Pendant of Victory", "=ds=#s4#", "25 #wintergraspmark#" };
		{ 19, 44914, "", "=q4=Anvil of Titans", "=ds=#s14#", "25 #wintergraspmark#" };
		{ 20, 44912, "", "=q4=Flow of Knowledge", "=ds=#s14#", "25 #wintergraspmark#" };
		{ 21, 46086, "", "=q4=Platinum Disks of Battle", "=ds=#s14#", "25 #wintergraspmark#" };
		{ 22, 46088, "", "=q4=Platinum Disks of Swiftness", "=ds=#s14#", "25 #wintergraspmark#" };
		{ 23, 46087, "", "=q4=Platinum Disks of Sorcery", "=ds=#s14#", "25 #wintergraspmark#" };
		{ 25, 48999, "", "=q4=Titan-Forged Band of Ascendancy", "=ds=#s13#", "15 #wintergraspmark#" };
		{ 26, 49000, "", "=q4=Titan-Forged Band of Victory", "=ds=#s13#", "15 #wintergraspmark#" };
		Next = "LakeWintergrasp2";
		Back = "WINTERGRASPMENU";
	};

	AtlasLoot_Data["LakeWintergrasp2"] = {
		{ 2, 44910, "", "=q4=Titan-Forged Hood of Dominance", "=ds=#s1#, #a1#", "40 #wintergraspmark#" };
		{ 3, 51573, "", "=q4=Titan-Forged Shoulderpads of Domination", "=ds=#s3#, #a1#", "40 #wintergraspmark#" };
		{ 4, 46065, "", "=q4=Titan-Forged Raiment of Dominance", "=ds=#s5#, #a1#", "40 #wintergraspmark#" };
		{ 6, 46079, "", "=q4=Titan-Forged Cord of Dominance", "=ds=#s10#, #a1#", "15 #wintergraspmark#" };
		{ 7, 48997, "", "=q4=Titan-Forged Cloth Trousers of Domination", "=ds=#s11#, #a1#", "40 #wintergraspmark#" };
		{ 8, 44899, "", "=q4=Titan-Forged Slippers of Dominance", "=ds=#s12#, #a1#", "15 #wintergraspmark#" };
		{ 17, 44909, "", "=q4=Titan-Forged Hood of Salvation", "=ds=#s1#, #a1#", "40 #wintergraspmark#" };
		{ 18, 51572, "", "=q4=Titan-Forged Shoulderpads of Salvation", "=ds=#s3#, #a1#", "40 #wintergraspmark#" };
		{ 19, 46066, "", "=q4=Titan-Forged Raiment of Salvation", "=ds=#s3#, #a1#", "40 #wintergraspmark#" };
		{ 20, 48979, "", "=q4=Titan-Forged Cuffs of Salvation", "=ds=#s8#, #a1#", "15 #wintergraspmark#" };
		{ 21, 46080, "", "=q4=Titan-Forged Cord of Salvation", "=ds=#s10#, #a1#", "15 #wintergraspmark#" };
		{ 22, 48991, "", "=q4=Titan-Forged Cloth Leggings of Salvation", "=ds=#s11#, #a1#", "40 #wintergraspmark#" };
		{ 23, 44900, "", "=q4=Titan-Forged Slippers of Salvation", "=ds=#s12#, #a1#", "15 #wintergraspmark#" };
		Prev = "LakeWintergrasp1";
		Next = "LakeWintergrasp3";
		Back = "WINTERGRASPMENU";
	};

	AtlasLoot_Data["LakeWintergrasp3"] = {
		{ 1, 44907, "", "=q4=Titan-Forged Leather Helm of Dominance", "=ds=#s1#, #a2#", "40 #wintergraspmark#" };
		{ 2, 51574, "", "=q4=Titan-Forged Leather Spaulders of Dominance", "=ds=#s3#, #a2#", "40 #wintergraspmark#" };
		{ 3, 46064, "", "=q4=Titan-Forged Leather Chestguard of Dominance", "=ds=#s5#, #a2#", "40 #wintergraspmark#" };
		{ 4, 48974, "", "=q4=Titan-Forged Armwraps of Dominance", "=ds=#s8#, #a2#", "15 #wintergraspmark#" };
		{ 5, 46076, "", "=q4=Titan-Forged Belt of Dominance", "=ds=#s10#, #a2#", "15 #wintergraspmark#" };
		{ 6, 48998, "", "=q4=Titan-Forged Leather Legguards of Dominance", "=ds=#s11#, #a2#", "40 #wintergraspmark#" };
		{ 7, 44891, "", "=q4=Titan-Forged Boots of Dominance", "=ds=#s12#, #a2#", "15 #wintergraspmark#" };
		{ 9, 44906, "", "=q4=Titan-Forged Leather Helm of Salvation", "=ds=#s1#, #a2#", "40 #wintergraspmark#" };
		{ 10, 51575, "", "=q4=Titan-Forged Leather Spaulders of Salvation", "=ds=#s3#, #a2#", "40 #wintergraspmark#" };
		{ 11, 46063, "", "=q4=Titan-Forged Leather Chestguard of Salvation", "=ds=#s5#, #a2#", "40 #wintergraspmark#" };
		{ 12, 48975, "", "=q4=Titan-Forged Armwraps of Salvation", "=ds=#s8#, #a2#", "15 #wintergraspmark#" };
		{ 13, 46077, "", "=q4=Titan-Forged Belt of Salvation", "=ds=#s10#, #a2#", "15 #wintergraspmark#" };
		{ 14, 48987, "", "=q4=Titan-Forged Leather Legguards of Salvation", "=ds=#s11#, #a2#", "40 #wintergraspmark#" };
		{ 15, 44892, "", "=q4=Titan-Forged Boots of Salvation", "=ds=#s12#, #a2#", "15 #wintergraspmark#" };
		{ 16, 44908, "", "=q4=Titan-Forged Leather Helm of Triumph", "=ds=#s1#, #a2#", "40 #wintergraspmark#" };
		{ 17, 51576, "", "=q4=Titan-Forged Leather Spaulders of Triumph", "=ds=#s3#, #a2#", "40 #wintergraspmark#" };
		{ 18, 46062, "", "=q4=Titan-Forged Leather Tunic of Triumph", "=ds=#s5#, #a2#", "40 #wintergraspmark#" };
		{ 19, 48976, "", "=q4=Titan-Forged Armwraps of Triumph", "=ds=#s8#, #a2#", "15 #wintergraspmark#" };
		{ 20, 46078, "", "=q4=Titan-Forged Belt of Triumph", "=ds=#s10#, #a2#", "15 #wintergraspmark#" };
		{ 21, 48988, "", "=q4=Titan-Forged Leather Legguards of Triumph", "=ds=#s11#, #a2#", "40 #wintergraspmark#" };
		{ 22, 44893, "", "=q4=Titan-Forged Boots of Triumph", "=ds=#s12#, #a2#", "15 #wintergraspmark#" };
		Prev = "LakeWintergrasp2";
		Next = "LakeWintergrasp4";
		Back = "WINTERGRASPMENU";
	};

	AtlasLoot_Data["LakeWintergrasp4"] = {
		{ 1, 44904, "", "=q4=Titan-Forged Mail Helm of Dominance", "=ds=#s1#, #a3#", "40 #wintergraspmark#" };
		{ 2, 51578, "", "=q4=Titan-Forged Shoulders of Dominance", "=ds=#s3#, #a3#", "40 #wintergraspmark#" };
		{ 3, 46061, "", "=q4=Titan-Forged Mail Armor of Domination", "=ds=#s5#, #a3#", "40 #wintergraspmark#" };
		{ 4, 48980, "", "=q4=Titan-Forged Wristguards of Dominance", "=ds=#s8#, #a3#", "15 #wintergraspmark#" };
		{ 5, 46073, "", "=q4=Titan-Forged Waistguard of Dominance", "=ds=#s10#, #a3#", "15 #wintergraspmark#" };
		{ 6, 48990, "", "=q4=Titan-Forged Mail Leggings of Dominance", "=ds=#s11#, #a3#", "40 #wintergraspmark#" };
		{ 7, 44896, "", "=q4=Titan-Forged Sabatons of Dominance", "=ds=#s12#, #a3#", "15 #wintergraspmark#" };
		{ 9, 44905, "", "=q4=Titan-Forged Ringmail Helm of Salvation", "=ds=#s1#, #a3#", "40 #wintergraspmark#" };
		{ 10, 51579, "", "=q4=Titan-Forged Shoulders of Salvation", "=ds=#s3#, #a3#", "40 #wintergraspmark#" };
		{ 11, 46060, "", "=q4=Titan-Forged Ringmail of Salvation", "=ds=#s5#, #a3#", "40 #wintergraspmark#" };
		{ 12, 48981, "", "=q4=Titan-Forged Wristguards of Salvation", "=ds=#s8#, #a3#", "15 #wintergraspmark#" };
		{ 13, 46074, "", "=q4=Titan-Forged Waistguard of Salvation", "=ds=#s10#, #a3#", "15 #wintergraspmark#" };
		{ 14, 48994, "", "=q4=Titan-Forged Mail Leggings of Salvation", "=ds=#s11#, #a3#", "40 #wintergraspmark#" };
		{ 15, 44897, "", "=q4=Titan-Forged Sabatons of Salvation", "=ds=#s12#, #a3#", "15 #wintergraspmark#" };
		{ 16, 44903, "", "=q4=Titan-Forged Chain Helm of Triumph", "=ds=#s1#, #a3#", "40 #wintergraspmark#" };
		{ 17, 51577, "", "=q4=Titan-Forged Shoulders of Triumph", "=ds=#s3#, #a3#", "40 #wintergraspmark#" };
		{ 18, 46059, "", "=q4=Titan-Forged Chain Armor of Triumph", "=ds=#s5#, #a3#", "40 #wintergraspmark#" };
		{ 19, 48982, "", "=q4=Titan-Forged Wristguards of Triumph", "=ds=#s8#, #a3#", "15 #wintergraspmark#" };
		{ 20, 46075, "", "=q4=Titan-Forged Waistguard of Triumph", "=ds=#s10#, #a3#", "15 #wintergraspmark#" };
		{ 21, 48983, "", "=q4=Titan-Forged Mail Leggings of Triumph", "=ds=#s11#, #a3#", "40 #wintergraspmark#" };
		{ 22, 44898, "", "=q4=Titan-Forged Sabatons of Triumph", "=ds=#s12#, #a3#", "15 #wintergraspmark#" };
		Prev = "LakeWintergrasp3";
		Next = "LakeWintergrasp5";
		Back = "WINTERGRASPMENU";
	};

	AtlasLoot_Data["LakeWintergrasp5"] = {
		{ 2, 44901, "", "=q4=Titan-Forged Plate Headcover of Salvation", "=ds=#s1#, #a4#", "40 #wintergraspmark#" };
		{ 3, 51581, "", "=q4=Titan-Forged Shoulderplates of Salvation", "=ds=#s3#, #a4#", "40 #wintergraspmark#" };
		{ 4, 46057, "", "=q4=Titan-Forged Chestguard of Salvation", "=ds=#s5#, #a4#", "40 #wintergraspmark#" };
		{ 5, 48977, "", "=q4=Titan-Forged Bracers of Salvation", "=ds=#s8#, #a4#", "15 #wintergraspmark#" };
		{ 6, 46071, "", "=q4=Titan-Forged Girdle of Salvation", "=ds=#s10#, #a4#", "15 #wintergraspmark#" };
		{ 7, 48992, "", "=q4=Titan-Forged Plate Legplates of Salvation", "=ds=#s11#, #a4#", "40 #wintergraspmark#" };
		{ 8, 44894, "", "=q4=Titan-Forged Greaves of Salvation", "=ds=#s12#, #a4#", "15 #wintergraspmark#" };
		{ 17, 44902, "", "=q4=Titan-Forged Plate Helm of Triumph", "=ds=#s1#, #a4#", "40 #wintergraspmark#" };
		{ 18, 51580, "", "=q4=Titan-Forged Plate Shoulderplates of Triumph", "=ds=#s3#, #a4#", "40 #wintergraspmark#" };
		{ 19, 46058, "", "=q4=Titan-Forged Breastplate of Triumph", "=ds=#s5#, #a4#", "40 #wintergraspmark#" };
		{ 20, 48978, "", "=q4=Titan-Forged Bracers of Triumph", "=ds=#s8#, #a4#", "15 #wintergraspmark#" };
		{ 21, 46072, "", "=q4=Titan-Forged Girdle of Triumph", "=ds=#s10#, #a4#", "15 #wintergraspmark#" };
		{ 22, 48993, "", "=q4=Titan-Forged Plate Legguards of Triumph", "=ds=#s11#, #a4#", "40 #wintergraspmark#" };
		{ 23, 44895, "", "=q4=Titan-Forged Greaves of Triumph", "=ds=#s12#, #a4#", "15 #wintergraspmark#" };
		Prev = "LakeWintergrasp4";
		Next = "LakeWintergrasp6";
		Back = "WINTERGRASPMENU";
	};

	AtlasLoot_Data["LakeWintergrasp6"] = {
		{ 1, 44066, "", "=q4=Kharmaa's Grace", "=ds=#e7#", "20 #wintergrasp#"};
		{ 2, 44081, "", "=q3=Enigmatic Starflare Diamond", "=ds=#e7#", "15 #wintergrasp#"};
		{ 3, 44084, "", "=q3=Forlorn Starflare Diamond", "=ds=#e7#", "15 #wintergrasp#"};
		{ 4, 44082, "", "=q3=Impassive Starflare Diamond", "=ds=#e7#", "15 #wintergrasp#"};
		{ 5, 44076, "", "=q3=Swift Starflare Diamond", "=ds=#e7#", "15 #wintergrasp#"};
		{ 6, 44078, "", "=q3=Swift Starflare Diamond", "=ds=#e7#", "15 #wintergrasp#"};
		{ 7, 44087, "", "=q3=Persistent Earthshatter Diamond", "=ds=#e7#", "15 #wintergrasp#"};
		{ 8, 44088, "", "=q3=Powerful Earthshatter Diamond", "=ds=#e7#", "15 #wintergrasp#"};
		{ 9, 44089, "", "=q3=Trenchant Earthshatter Diamond", "=ds=#e7#", "15 #wintergrasp#"};
		{ 11, 44075, "", "=q3=Arcanum of Dominance", "=ds=#s1# #e17#", "40 #wintergrasp#"};
		{ 12, 44069, "", "=q3=Arcanum of Triumph", "=ds=#s1# #e17#", "40 #wintergrasp#"};
		{ 13, 44068, "", "=q3=Inscription of Dominance", "=ds=#s3# #e17#", "30 #wintergrasp#"};
		{ 14, 44067, "", "=q3=Inscription of Triumph", "=ds=#s3# #e17#", "30 #wintergrasp#"};
		{ 16, 41730, "", "=q3=Design: Durable Monarch Topaz", "=ds=#p12# (390)", "12 #wintergrasp#"};
		{ 17, 41732, "", "=q3=Design: Empowered Monarch Topaz", "=ds=#p12# (390)", "12 #wintergrasp#"};
		{ 18, 41733, "", "=q3=Design: Lucent Monarch Topaz", "=ds=#p12# (390)", "12 #wintergrasp#"};
		{ 19, 41735, "", "=q3=Design: Shattered Forest Emerald", "=ds=#p12# (390)", "12 #wintergrasp#"};
		{ 20, 41739, "", "=q3=Design: Opaque Forest Emerald", "=ds=#p12# (390)", "12 #wintergrasp#"};
		{ 21, 41736, "", "=q3=Design: Tense Forest Emerald", "=ds=#p12# (390)", "12 #wintergrasp#"};
		{ 22, 41737, "", "=q3=Design: Turbid Forest Emerald", "=ds=#p12# (390)", "12 #wintergrasp#"};
		{ 23, 41738, "", "=q3=Design: Steady Forest Emerald", "=ds=#p12# (390)", "12 #wintergrasp#"};
		{ 24, 41734, "", "=q3=Design: Resplendent Monarch Topaz", "=ds=#p12# (390)", "12 #wintergrasp#"};
		{ 25, 41727, "", "=q3=Design: Mystic Autumn's Glow", "=ds=#p12# (390)", "12 #wintergrasp#"};
		{ 26, 41740, "", "=q3=Design: Mysterious Twilight Opal", "=ds=#p12# (390)", "12 #wintergrasp#"};
		{ 27, 41728, "", "=q3=Design: Stormy Sky Sapphire", "=ds=#p12# (390)", "12 #wintergrasp#"};
		{ 28, 41742, "", "=q3=Design: Enigmatic Skyflare Diamond", "=ds=#p12# (420)", "24 #wintergrasp#"};
		{ 29, 41743, "", "=q3=Design: Forlorn Skyflare Diamond", "=ds=#p12# (420)", "24 #wintergrasp#"};
		{ 30, 41744, "", "=q3=Design: Impassive Skyflare Diamond", "=ds=#p12# (420)", "24 #wintergrasp#"};
		Prev = "LakeWintergrasp5";
		Next = "LakeWintergrasp7";
		Back = "WINTERGRASPMENU";
	};

	AtlasLoot_Data["LakeWintergrasp7"] = {
		{ 1, 44107, "", "=q7=Exquisite Sunderseer Mantle", "=ds=#s3#, #a1#", "200 #wintergrasp#"};
		{ 2, 44103, "", "=q7=Exceptional Stormshroud Shoulders", "=ds=#s3#, #a2#", "200 #wintergrasp#"};
		{ 3, 44105, "", "=q7=Lasting Feralheart Spaulders", "=ds=#s3#, #a2#", "200 #wintergrasp#"};
		{ 4, 44102, "", "=q7=Aged Pauldrons of The Five Thunders", "=ds=#s3#, #a3#", "200 #wintergrasp#"};
		{ 5, 44101, "", "=q7=Prized Beastmaster's Mantle", "=ds=#s3#, #a3#", "200 #wintergrasp#"};
		{ 6, 44100, "", "=q7=Pristine Lightforge Spaulders", "=ds=#s3#, #a4#", "200 #wintergrasp#"};
		{ 7, 44099, "", "=q7=Strengthened Stockade Pauldrons", "=ds=#s3#, #a4#", "200 #wintergrasp#"};
		{ 9, 44098, "", "=q7=Inherited Insignia of the Alliance", "=ds=#s14#", "250 #wintergrasp#"};
		{ 10, 44097, "", "=q7=Inherited Insignia of the Horde", "=ds=#s14#", "250 #wintergrasp#"};
		{ 12, 44115, "", "=q7=Wintergrasp Commendation", "=ds=", "30 #wintergrasp# / 9 #wintergraspmark#"};
		{ 16, 44091, "", "=q7=Sharpened Scarlet Kris", "=ds=#h1#, #w4#", "200 #wintergrasp#"};
		{ 17, 44096, "", "=q7=Battleworn Thrash Blade", "=ds=#h1#, #w10#", "200 #wintergrasp#"};
		{ 18, 44092, "", "=q7=Reforged Truesilver Champion", "=ds=#h2#, #w10#", "325 #wintergrasp#"};
		{ 19, 44094, "", "=q7=The Blessed Hammer of Grace", "=ds=#h3#, #w6#", "250 #wintergrasp#"};
		{ 20, 44095, "", "=q7=Grand Staff of Jordan", "=ds=#w9#", "325 #wintergrasp#"};
		{ 21, 44093, "", "=q7=Upgraded Dwarven Hand Cannon", "=ds=#w5#", "325 #wintergrasp#"};
		Prev = "LakeWintergrasp6";
		Back = "WINTERGRASPMENU";
	};

		-----------------------------------------------
		--- World PvP - Grizzly Hills: Venture Bay  ---
		-----------------------------------------------

	AtlasLoot_Data["VentureBay1"] = {
		{ 1, 38354, "", "=q3=Oil-Stained Tarp", "=ds=#s4#", "50 #venturecoin#"};
		{ 2, 38355, "", "=q3=Thick Goblin Back Protector ", "=ds=#s4#", "50 #venturecoin#"};
		{ 3, 38353, "", "=q3=Venture Bay Buccaneer's Cape", "=ds=#s4#", "50 #venturecoin#"};
		{ 4, 38358, "", "=q3=Arcane Revitalizer", "=ds=#s14#", "70 #venturecoin#"};
		{ 5, 38359, "", "=q3=Goblin Repetition Reducer", "=ds=#s14#", "70 #venturecoin#"};
		{ 6, 38357, "", "=q3=Sharpened Throwing Gizmo", "=ds=#w11#", "30 #venturecoin#"};
		{ 7, 38356, "", "=q3=Venture Battle Wand", "=ds=#w12#", "30 #venturecoin#"};
		{ 8, 38360, "", "=q3=Idol of Arcane Terror", "=ds=#w14#", "30 #venturecoin#"};
		{ 9, 38365, "", "=q3=Idol of Perspicacious Attacks", "=ds=#w14#", "30 #venturecoin#"};
		{ 10, 38366, "", "=q3=Idol of Pure Thoughts", "=ds=#w14#", "30 #venturecoin#"};
		{ 11, 38364, "", "=q3=Venture Co. Libram of Mostly Holy Deeds", "=ds=#w16#", "30 #venturecoin#"};
		{ 12, 38363, "", "=q3=Venture Co. Libram of Protection", "=ds=#w16#", "30 #venturecoin#"};
		{ 13, 38362, "", "=q3=Venture Co. Libram of Retribution", "=ds=#w16#", "30 #venturecoin#"};
		{ 16, 38368, "", "=q3=Totem of the Bay", "=ds=#w15#", "30 #venturecoin#"};
		{ 17, 38367, "", "=q3=Venture Co. Flame Slicer", "=ds=#w15#", "30 #venturecoin#"};
		{ 18, 38361, "", "=q3=Venture Co. Lightning Rod", "=ds=#w15#", "30 #venturecoin#"};
		{ 19, 40875, "", "=q3=Sigil of Arthritic Binding", "=ds=#w21#", "30 #venturecoin#"};
		{ 20, 40822, "", "=q3=Sigil of the Frozen Conscience", "=ds=#w21#", "30 #venturecoin#"};
		{ 21, 40867, "", "=q3=Sigil of the Wild Buck", "=ds=#w21#", "30 #venturecoin#"};
		{ 23, 37836, "", "=q1=Venture Coin", "=ds=#m17#"};
		Back = "PVPMENU";
	};

	--------------------------
	--- Sets & Collections ---
	--------------------------

		---------------------------------------
		--- Naxx Sets (T7)/Ulduar Sets (T8) ---
		---------------------------------------

	AtlasLoot_Data["NaxxDeathKnightDPS"] = {
		{ 1, 0, "Spell_Deathknight_DeathStrike", "=q6=#t7s10_1#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39619, "", "=q4=Heroes' Scourgeborne Helmet", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39621, "", "=q4=Heroes' Scourgeborne Shoulderplates", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39617, "", "=q4=Heroes' Scourgeborne Battleplate", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39618, "", "=q4=Heroes' Scourgeborne Gauntlets", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39620, "", "=q4=Heroes' Scourgeborne Legplates", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Spell_Deathknight_DeathStrike", "=q6=#t7s10_1#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40554, "", "=q4=Valorous Scourgeborne Helmet", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40557, "", "=q4=Valorous Scourgeborne Shoulderplates", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40550, "", "=q4=Valorous Scourgeborne Battleplate", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40552, "", "=q4=Valorous Scourgeborne Gauntlets", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40556, "", "=q4=Valorous Scourgeborne Legplates", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Spell_Deathknight_DeathStrike", "=q6=#t8s10_1#", "=q5="..AL["Tier 8"].." ("..AL["10 Man"]..")"};
		{ 17, 45342, "", "=q4=Valorous Darkruned Helmet", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45344, "", "=q4=Valorous Darkruned Shoulderplates", "=ds="..BabbleBoss.Thorim};
		{ 19, 45340, "", "=q4=Valorous Darkruned Battleplate", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45341, "", "=q4=Valorous Darkruned Gauntlets", "=ds="..BabbleBoss.Freya};
		{ 21, 45343, "", "=q4=Valorous Darkruned Legplates", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Spell_Deathknight_DeathStrike", "=q6=#t8s10_1#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46115, "", "=q4=Conqueror's Darkruned Helmet", "=ds="..BabbleBoss.Thorim};
		{ 25, 46117, "", "=q4=Conqueror's Darkruned Shoulderplates", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46111, "", "=q4=Conqueror's Darkruned Battleplate", "=ds="..BabbleBoss.Hodir};
		{ 27, 46113, "", "=q4=Conqueror's Darkruned Gauntlets", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46116, "", "=q4=Conqueror's Darkruned Legplates", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxDeathKnightTank"] = {
		{ 1, 0, "Spell_Deathknight_DeathStrike", "=q6=#t7s10_2#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39625, "", "=q4=Heroes' Scourgeborne Faceguard", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39627, "", "=q4=Heroes' Scourgeborne Pauldrons", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39623, "", "=q4=Heroes' Scourgeborne Chestguard", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39624, "", "=q4=Heroes' Scourgeborne Handguards", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39626, "", "=q4=Heroes' Scourgeborne Legguards", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Spell_Deathknight_DeathStrike", "=q6=#t7s10_2#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40565, "", "=q4=Valorous Scourgeborne Faceguard", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40568, "", "=q4=Valorous Scourgeborne Pauldrons", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40559, "", "=q4=Valorous Scourgeborne Chestguard", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40563, "", "=q4=Valorous Scourgeborne Handguards", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40567, "", "=q4=Valorous Scourgeborne Legguards", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Spell_Deathknight_DeathStrike", "=q6=#t8s10_2#", "=q5="..AL["Tier 8"].." ("..AL["10 Man"]..")"};
		{ 17, 45336, "", "=q4=Valorous Darkruned Faceguard", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45339, "", "=q4=Valorous Darkruned Pauldrons", "=ds="..BabbleBoss.Thorim};
		{ 19, 45335, "", "=q4=Valorous Darkruned Chestguard", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45337, "", "=q4=Valorous Darkruned Handguards", "=ds="..BabbleBoss.Freya};
		{ 21, 45338, "", "=q4=Valorous Darkruned Legguards", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Spell_Deathknight_DeathStrike", "=q6=#t8s10_2#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46120, "", "=q4=Conqueror's Darkruned Faceguard", "=ds="..BabbleBoss.Thorim};
		{ 25, 46122, "", "=q4=Conqueror's Darkruned Pauldrons", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46118, "", "=q4=Conqueror's Darkruned Chestguard", "=ds="..BabbleBoss.Hodir};
		{ 27, 46119, "", "=q4=Conqueror's Darkruned Handguards", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46121, "", "=q4=Conqueror's Darkruned Legguards", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxDruidFeral"] = {
		{ 1, 0, "Ability_Druid_Maul", "=q6=#t7s1_2#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39553, "", "=q4=Heroes' Dreamwalker Headguard", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39556, "", "=q4=Heroes' Dreamwalker Shoulderpads", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39554, "", "=q4=Heroes' Dreamwalker Raiments", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39557, "", "=q4=Heroes' Dreamwalker Handgrips", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39555, "", "=q4=Heroes' Dreamwalker Legguards", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Ability_Druid_Maul", "=q6=#t7s1_2#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40473, "", "=q4=Valorous Dreamwalker Headguard", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40494, "", "=q4=Valorous Dreamwalker Shoulderpads", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40471, "", "=q4=Valorous Dreamwalker Raiments", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40472, "", "=q4=Valorous Dreamwalker Handgrips", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40493, "", "=q4=Valorous Dreamwalker Legguards", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Ability_Druid_Maul", "=q6=#t8s1_2#", "=q5="..AL["Tier 8"].." ("..AL["10 Man"]..")"};
		{ 17, 45356, "", "=q4=Valorous Nightsong Headguard", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45359, "", "=q4=Valorous Nightsong Shoulderpads", "=ds="..BabbleBoss.Thorim};
		{ 19, 45358, "", "=q4=Valorous Nightsong Raiments", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45355, "", "=q4=Valorous Nightsong Handgrips", "=ds="..BabbleBoss.Freya};
		{ 21, 45357, "", "=q4=Valorous Nightsong Legguards", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Ability_Druid_Maul", "=q6=#t8s1_2#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46161, "", "=q4=Conqueror's Nightsong Headguard", "=ds="..BabbleBoss.Thorim};
		{ 25, 46157, "", "=q4=Conqueror's Nightsong Shoulderpads", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46159, "", "=q4=Conqueror's Nightsong Raiments", "=ds="..BabbleBoss.Hodir};
		{ 27, 46158, "", "=q4=Conqueror's Nightsong Handgrips", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46160, "", "=q4=Conqueror's Nightsong Legguards", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxDruidRestoration"] = {
		{ 1, 0, "Spell_Nature_Regeneration", "=q6=#t7s1_3#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39531, "", "=q4=Heroes' Dreamwalker Headpiece", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39542, "", "=q4=Heroes' Dreamwalker Spaulders", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39538, "", "=q4=Heroes' Dreamwalker Robe", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39543, "", "=q4=Heroes' Dreamwalker Handguards", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39539, "", "=q4=Heroes' Dreamwalker Leggings", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Spell_Nature_Regeneration", "=q6=#t7s1_3#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40461, "", "=q4=Valorous Dreamwalker Headpiece", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40465, "", "=q4=Valorous Dreamwalker Spaulders", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40463, "", "=q4=Valorous Dreamwalker Robe", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40460, "", "=q4=Valorous Dreamwalker Handguards", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40462, "", "=q4=Valorous Dreamwalker Leggings", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Spell_Nature_Regeneration", "=q6=#t8s1_3#", "=q5="..AL["Tier 8"].." ("..AL["10 Man"]..")"};
		{ 17, 45346, "", "=q4=Valorous Nightsong Headpiece", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45349, "", "=q4=Valorous Nightsong Spaulders", "=ds="..BabbleBoss.Thorim};
		{ 19, 45348, "", "=q4=Valorous Nightsong Robe", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45345, "", "=q4=Valorous Nightsong Handguards", "=ds="..BabbleBoss.Freya};
		{ 21, 45347, "", "=q4=Valorous Nightsong Leggings", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Spell_Nature_Regeneration", "=q6=#t8s1_3#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46184, "", "=q4=Conqueror's Nightsong Headpiece", "=ds="..BabbleBoss.Thorim};
		{ 25, 46187, "", "=q4=Conqueror's Nightsong Spaulders", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46186, "", "=q4=Conqueror's Nightsong Robe", "=ds="..BabbleBoss.Hodir};
		{ 27, 46183, "", "=q4=Conqueror's Nightsong Handguards", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46185, "", "=q4=Conqueror's Nightsong Leggings", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxDruidBalance"] = {
		{ 1, 0, "Spell_Nature_InsectSwarm", "=q6=#t7s1_1#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39545, "", "=q4=Heroes' Dreamwalker Cover", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39548, "", "=q4=Heroes' Dreamwalker Mantle", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39547, "", "=q4=Heroes' Dreamwalker Vestments", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39544, "", "=q4=Heroes' Dreamwalker Gloves", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39546, "", "=q4=Heroes' Dreamwalker Trousers", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Spell_Nature_InsectSwarm", "=q6=#t7s1_1#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40467, "", "=q4=Valorous Dreamwalker Cover", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40470, "", "=q4=Valorous Dreamwalker Mantle", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40469, "", "=q4=Valorous Dreamwalker Vestments", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40466, "", "=q4=Valorous Dreamwalker Gloves", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40468, "", "=q4=Valorous Dreamwalker Trousers", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Spell_Nature_InsectSwarm", "=q6=#t8s1_1#", "=q5="..AL["Tier 8"].." ("..AL["10 Man"]..")"};
		{ 17, 46313, "", "=q4=Valorous Nightsong Cover", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45352, "", "=q4=Valorous Nightsong Mantle", "=ds="..BabbleBoss.Thorim};
		{ 19, 45354, "", "=q4=Valorous Nightsong Vestments", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45351, "", "=q4=Valorous Nightsong Gloves", "=ds="..BabbleBoss.Freya};
		{ 21, 45353, "", "=q4=Valorous Nightsong Trousers", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Spell_Nature_InsectSwarm", "=q6=#t8s1_1#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46191, "", "=q4=Conqueror's Nightsong Cover", "=ds="..BabbleBoss.Thorim};
		{ 25, 46196, "", "=q4=Conqueror's Nightsong Mantle", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46194, "", "=q4=Conqueror's Nightsong Vestments", "=ds="..BabbleBoss.Hodir};
		{ 27, 46189, "", "=q4=Conqueror's Nightsong Gloves", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46192, "", "=q4=Conqueror's Nightsong Trousers", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxHunter"] = {
		{ 1, 0, "Ability_Hunter_RunningShot", "=q6=#t7s2#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39578, "", "=q4=Heroes' Cryptstalker Headpiece", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39581, "", "=q4=Heroes' Cryptstalker Spaulders", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39579, "", "=q4=Heroes' Cryptstalker Tunic", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39582, "", "=q4=Heroes' Cryptstalker Handguards", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39580, "", "=q4=Heroes' Cryptstalker Legguards", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Ability_Hunter_RunningShot", "=q6=#t7s2#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40505, "", "=q4=Valorous Crypstalker Headpiece", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40507, "", "=q4=Valorous Crypstalker Spaulders", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40503, "", "=q4=Valorous Crypstalker Tunic", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40504, "", "=q4=Valorous Crypstalker Handguards", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40506, "", "=q4=Valorous Crypstalker Legguards", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Ability_Hunter_RunningShot", "=q6=#t8s2#", "=q5="..AL["Tier 8"].." ("..AL["10 Man"]..")"};
		{ 17, 45361, "", "=q4=Valorous Scourgestalker Headpiece", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45363, "", "=q4=Valorous Scourgestalker Spaulders", "=ds="..BabbleBoss.Thorim};
		{ 19, 45364, "", "=q4=Valorous Scourgestalker Tunic", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45360, "", "=q4=Valorous Scourgestalker Handguards", "=ds="..BabbleBoss.Freya};
		{ 21, 45362, "", "=q4=Valorous Scourgestalker Legguards", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Ability_Hunter_RunningShot", "=q6=#t8s2#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46143, "", "=q4=Conqueror's Scourgestalker Headpiece", "=ds="..BabbleBoss.Thorim};
		{ 25, 46145, "", "=q4=Conqueror's Scourgestalker Spaulders", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46141, "", "=q4=Conqueror's Scourgestalker Tunic", "=ds="..BabbleBoss.Hodir};
		{ 27, 46142, "", "=q4=Conqueror's Scourgestalker Handguards", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46144, "", "=q4=Conqueror's Scourgestalker Legguards", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxMage"] = {
		{ 1, 0, "Spell_Frost_IceStorm", "=q6=#t7s3#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39491, "", "=q4=Heroes' Frostfire Circlet", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39494, "", "=q4=Heroes' Frostfire Shoulderpads", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39492, "", "=q4=Heroes' Frostfire Robe", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39495, "", "=q4=Heroes' Frostfire Gloves", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39493, "", "=q4=Heroes' Frostfire Leggings", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Spell_Frost_IceStorm", "=q6=#t7s3#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40416, "", "=q4=Valorous Frostfire Circlet", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40419, "", "=q4=Valorous Frostfire Shoulderpads", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40418, "", "=q4=Valorous Frostfire Robe", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40415, "", "=q4=Valorous Frostfire Gloves", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40417, "", "=q4=Valorous Frostfire Leggings", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Spell_Frost_IceStorm", "=q6=#t8s3#", "=q5="..AL["Tier 8"].." ("..AL["10 Man"]..")"};
		{ 17, 45365, "", "=q4=Valorous Kirin Tor Hood", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45369, "", "=q4=Valorous Kirin Tor Shoulderpads", "=ds="..BabbleBoss.Thorim};
		{ 19, 45368, "", "=q4=Valorous Kirin Tor Tunic", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 46131, "", "=q4=Valorous Kirin Tor Gauntlets", "=ds="..BabbleBoss.Freya};
		{ 21, 45367, "", "=q4=Valorous Kirin Tor Leggings", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Spell_Frost_IceStorm", "=q6=#t8s3#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46129, "", "=q4=Conqueror's Kirin Tor Hood", "=ds="..BabbleBoss.Thorim};
		{ 25, 46134, "", "=q4=Conqueror's Kirin Tor Shoulderpads", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46130, "", "=q4=Conqueror's Kirin Tor Tunic", "=ds="..BabbleBoss.Hodir};
		{ 27, 46132, "", "=q4=Conqueror's Kirin Tor Gauntlets", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46133, "", "=q4=Conqueror's Kirin Tor Leggings", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxPaladinHoly"] = {
		{ 1, 0, "Spell_Holy_HolyBolt", "=q6=#t7s4_1#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39628, "", "=q4=Heroes' Redemption Headpiece", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39631, "", "=q4=Heroes' Redemption Spaulders", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39629, "", "=q4=Heroes' Redemption Tunic", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39632, "", "=q4=Heroes' Redemption Gloves", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39630, "", "=q4=Heroes' Redemption Greaves", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Spell_Holy_HolyBolt", "=q6=#t7s4_1#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40571, "", "=q4=Valorous Redemption Headpiece", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40573, "", "=q4=Valorous Redemption Spaulders", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40569, "", "=q4=Valorous Redemption Tunic", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40570, "", "=q4=Valorous Redemption Gloves", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40572, "", "=q4=Valorous Redemption Greaves", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Spell_Holy_HolyBolt", "=q6=#t8s4_1#", "=q5=("..AL["10 Man"]..")"};
		{ 17, 45372, "", "=q4=Valorous Aegis Headpiece", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45373, "", "=q4=Valorous Aegis Spaulders", "=ds="..BabbleBoss.Thorim};
		{ 19, 45374, "", "=q4=Valorous Aegis Tunic", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45370, "", "=q4=Valorous Aegis Gloves", "=ds="..BabbleBoss.Freya};
		{ 21, 45371, "", "=q4=Valorous Aegis Greaves", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Spell_Holy_HolyBolt", "=q6=#t8s4_1#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46180, "", "=q4=Conqueror's Aegis Headpiece", "=ds="..BabbleBoss.Thorim};
		{ 25, 46182, "", "=q4=Conqueror's Aegis Spaulders", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46178, "", "=q4=Conqueror's Aegis Tunic", "=ds="..BabbleBoss.Hodir};
		{ 27, 46179, "", "=q4=Conqueror's Aegis Gloves", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46181, "", "=q4=Conqueror's Aegis Greaves", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxPaladinRetribution"] = {
		{ 1, 0, "Spell_Holy_AuraOfLight", "=q6=#t7s4_2#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39635, "", "=q4=Heroes' Redemption Helm", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39637, "", "=q4=Heroes' Redemption Shoulderplates", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39633, "", "=q4=Heroes' Redemption Chestpiece", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39634, "", "=q4=Heroes' Redemption Gauntlets", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39636, "", "=q4=Heroes' Redemption Legplates", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Spell_Holy_AuraOfLight", "=q6=#t7s4_2#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40576, "", "=q4=Valorous Redemption Helm", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40578, "", "=q4=Valorous Redemption Shoulderplates", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40574, "", "=q4=Valorous Redemption Chestpiece", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40575, "", "=q4=Valorous Redemption Gauntlets", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40577, "", "=q4=Valorous Redemption Legplates", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Spell_Holy_AuraOfLight", "=q6=#t8s4_2#", "=q5=("..AL["10 Man"]..")"};
		{ 17, 45377, "", "=q4=Valorous Aegis Helm", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45380, "", "=q4=Valorous Aegis Shoulderplates", "=ds="..BabbleBoss.Thorim};
		{ 19, 45375, "", "=q4=Valorous Aegis Battleplate", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45376, "", "=q4=Valorous Aegis Gauntlets", "=ds="..BabbleBoss.Freya};
		{ 21, 45379, "", "=q4=Valorous Aegis Legplates", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Spell_Holy_AuraOfLight", "=q6=#t8s4_2#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46156, "", "=q4=Conqueror's Aegis Helm", "=ds="..BabbleBoss.Thorim};
		{ 25, 46152, "", "=q4=Conqueror's Aegis Shoulderplates", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46154, "", "=q4=Conqueror's Aegis Battleplate", "=ds="..BabbleBoss.Hodir};
		{ 27, 46155, "", "=q4=Conqueror's Aegis Gauntlets", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46153, "", "=q4=Conqueror's Aegis Legplates", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxPaladinProtection"] = {
		{ 1, 0, "Spell_Holy_SealOfMight", "=q6=#t7s4_3#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39640, "", "=q4=Heroes' Redemption Faceguard", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39642, "", "=q4=Heroes' Redemption Shouldergards", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39638, "", "=q4=Heroes' Redemption Breastplate", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39639, "", "=q4=Heroes' Redemption Handguards", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39641, "", "=q4=Heroes' Redemption Legguards", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Spell_Holy_SealOfMight", "=q6=#t7s4_3#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40581, "", "=q4=Valorous Redemption Faceguard", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40584, "", "=q4=Valorous Redemption Shouldergards", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40579, "", "=q4=Valorous Redemption Breastplate", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40580, "", "=q4=Valorous Redemption Handguards", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40583, "", "=q4=Valorous Redemption Legguards", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Spell_Holy_SealOfMight", "=q6=#t8s4_3#", "=q5=("..AL["10 Man"]..")"};
		{ 17, 45382, "", "=q4=Valorous Aegis Faceguard", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45385, "", "=q4=Valorous Aegis Shouldergards", "=ds="..BabbleBoss.Thorim};
		{ 19, 45381, "", "=q4=Valorous Aegis Breastplate", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45383, "", "=q4=Valorous Aegis Handguards", "=ds="..BabbleBoss.Freya};
		{ 21, 45384, "", "=q4=Valorous Aegis Legguards", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Spell_Holy_SealOfMight", "=q6=#t8s4_3#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46175, "", "=q4=Conqueror's Aegis Faceguard", "=ds="..BabbleBoss.Thorim};
		{ 25, 46177, "", "=q4=Conqueror's Aegis Shouldergards", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46173, "", "=q4=Conqueror's Aegis Breastplate", "=ds="..BabbleBoss.Hodir};
		{ 27, 46174, "", "=q4=Conqueror's Aegis Handguards", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46176, "", "=q4=Conqueror's Aegis Legguards", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxPriestShadow"] = {
		{ 1, 0, "Spell_Shadow_AntiShadow", "=q6=#t7s5_2#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39521, "", "=q4=Heroes' Circlet of Faith", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39529, "", "=q4=Heroes' Mantle of Faith", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39523, "", "=q4=Heroes' Raiments of Faith", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39530, "", "=q4=Heroes' Handwraps of Faith", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39528, "", "=q4=Heroes' Pants of Faith", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Spell_Shadow_AntiShadow", "=q6=#t7s5_2#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40456, "", "=q4=Valorous Circlet of Faith", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40459, "", "=q4=Valorous Mantle of Faith", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40458, "", "=q4=Valorous Raiments of Faith", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40454, "", "=q4=Valorous Handwraps of Faith", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40457, "", "=q4=Valorous Pants of Faith", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Spell_Shadow_AntiShadow", "=q6=#t8s5_2#", "=q5="..AL["Tier 8"].." ("..AL["10 Man"]..")"};
		{ 17, 45391, "", "=q4=Valorous Circlet of Sanctification", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45393, "", "=q4=Valorous Mantle of Sanctification", "=ds="..BabbleBoss.Thorim};
		{ 19, 45395, "", "=q4=Valorous Raiments of Sanctification", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45392, "", "=q4=Valorous Handwraps of Sanctification", "=ds="..BabbleBoss.Freya};
		{ 21, 45394, "", "=q4=Valorous Pants of Sanctification", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Spell_Shadow_AntiShadow", "=q6=#t8s5_2#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46172, "", "=q4=Conqueror's Circlet of Sanctification", "=ds="..BabbleBoss.Thorim};
		{ 25, 46165, "", "=q4=Conqueror's Mantle of Sanctification", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46168, "", "=q4=Conqueror's Raiments of Sanctification", "=ds="..BabbleBoss.Hodir};
		{ 27, 46163, "", "=q4=Conqueror's Handwraps of Sanctification", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46170, "", "=q4=Conqueror's Pants of Sanctification", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxPriestHoly"] = {
		{ 1, 0, "Spell_Holy_PowerWordShield", "=q6=#t7s5_1#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39514, "", "=q4=Heroes' Crown of Faith", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39518, "", "=q4=Heroes' Shoulderpads of Faith", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39515, "", "=q4=Heroes' Robe of Faith", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39519, "", "=q4=Heroes' Gloves of Faith", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39517, "", "=q4=Heroes' Leggings of Faith", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Spell_Holy_PowerWordShield", "=q6=#t7s5_1#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40447, "", "=q4=Valorous Crown of Faith", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40450, "", "=q4=Valorous Shoulderpads of Faith", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40449, "", "=q4=Valorous Robe of Faith", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40445, "", "=q4=Valorous Gloves of Faith", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40448, "", "=q4=Valorous Leggings of Faith", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Spell_Holy_PowerWordShield", "=q6=#t8s5_1#", "=q5="..AL["Tier 8"].." ("..AL["10 Man"]..")"};
		{ 17, 45386, "", "=q4=Valorous Cowl of Sanctification", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45390, "", "=q4=Valorous Shoulderpads of Sanctification", "=ds="..BabbleBoss.Thorim};
		{ 19, 45389, "", "=q4=Valorous Robe of Sanctification", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45387, "", "=q4=Valorous Gloves of Sanctification", "=ds="..BabbleBoss.Freya};
		{ 21, 45388, "", "=q4=Valorous Leggings of Sanctification", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Spell_Holy_PowerWordShield", "=q6=#t8s5_1#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46197, "", "=q4=Conqueror's Cowl of Sanctification", "=ds="..BabbleBoss.Thorim};
		{ 25, 46190, "", "=q4=Conqueror's Shoulderpads of Sanctification", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46193, "", "=q4=Conqueror's Robe of Sanctification", "=ds="..BabbleBoss.Hodir};
		{ 27, 46188, "", "=q4=Conqueror's Gloves of Sanctification", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46195, "", "=q4=Conqueror's Leggings of Sanctification", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxRogue"] = {
		{ 1, 0, "Ability_BackStab", "=q6=#t7s6#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39561, "", "=q4=Heroes' Bonescythe Helmet", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39565, "", "=q4=Heroes' Bonescythe Pauldrons", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39558, "", "=q4=Heroes' Bonescythe Breastplate", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39560, "", "=q4=Heroes' Bonescythe Gauntlets", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39564, "", "=q4=Heroes' Bonescythe Legplates", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Ability_BackStab", "=q6=#t7s6#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40499, "", "=q4=Valorous Bonescythe Helmet", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40502, "", "=q4=Valorous Bonescythe Pauldrons", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40495, "", "=q4=Valorous Bonescythe Breastplate", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40496, "", "=q4=Valorous Bonescythe Gauntlets", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40500, "", "=q4=Valorous Bonescythe Legplates", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Ability_BackStab", "=q6=#t8s6#", "=q5="..AL["Tier 8"].." ("..AL["10 Man"]..")"};
		{ 17, 45398, "", "=q4=Valorous Terrorblade Helmet", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45400, "", "=q4=Valorous Terrorblade Pauldrons", "=ds="..BabbleBoss.Thorim};
		{ 19, 45396, "", "=q4=Valorous Terrorblade Breastplate", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45397, "", "=q4=Valorous Terrorblade Gauntlets", "=ds="..BabbleBoss.Freya};
		{ 21, 45399, "", "=q4=Valorous Terrorblade Legplates", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Ability_BackStab", "=q6=#t8s6#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46125, "", "=q4=Conqueror's Terrorblade Helmet", "=ds="..BabbleBoss.Thorim};
		{ 25, 46127, "", "=q4=Conqueror's Terrorblade Pauldrons", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46123, "", "=q4=Conqueror's Terrorblade Breastplate", "=ds="..BabbleBoss.Hodir};
		{ 27, 46124, "", "=q4=Conqueror's Terrorblade Gauntlets", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46126, "", "=q4=Conqueror's Terrorblade Legplates", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxShamanRestoration"] = {
		{ 1, 0, "Spell_Nature_HealingWaveGreater", "=q6=#t7s7_3#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39583, "", "=q4=Heroes' Earthshatter Headpiece", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39590, "", "=q4=Heroes' Earthshatter Spaulders", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39588, "", "=q4=Heroes' Earthshatter Tunic", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39591, "", "=q4=Heroes' Earthshatter Handguards", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39589, "", "=q4=Heroes' Earthshatter Legguards", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Spell_Nature_HealingWaveGreater", "=q6=#t7s7_3#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40510, "", "=q4=Valorous Earthshatter Headpiece", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40513, "", "=q4=Valorous Earthshatter Spaulders", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40508, "", "=q4=Valorous Earthshatter Tunic", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40509, "", "=q4=Valorous Earthshatter Handguards", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40512, "", "=q4=Valorous Earthshatter Legguards", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Spell_Nature_HealingWaveGreater", "=q6=#t8s7_3#", "=q5="..AL["Tier 8"].." ("..AL["10 Man"]..")"};
		{ 17, 45402, "", "=q4=Valorous Worldbreaker Headpiece", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45404, "", "=q4=Valorous Worldbreaker Spaulders", "=ds="..BabbleBoss.Thorim};
		{ 19, 45405, "", "=q4=Valorous Worldbreaker Tunic", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45401, "", "=q4=Valorous Worldbreaker Handguards", "=ds="..BabbleBoss.Freya};
		{ 21, 45403, "", "=q4=Valorous Worldbreaker Legguards", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Spell_Nature_HealingWaveGreater", "=q6=#t8s7_3#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46201, "", "=q4=Conqueror's Worldbreaker Headpiece", "=ds="..BabbleBoss.Thorim};
		{ 25, 46204, "", "=q4=Conqueror's Worldbreaker Spaulders", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46198, "", "=q4=Conqueror's Worldbreaker Tunic", "=ds="..BabbleBoss.Hodir};
		{ 27, 46199, "", "=q4=Conqueror's Worldbreaker Handguards", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46202, "", "=q4=Conqueror's Worldbreaker Legguards", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxShamanEnhancement"] = {
		{ 1, 0, "Spell_FireResistanceTotem_01", "=q6=#t7s7_2#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39602, "", "=q4=Heroes' Earthshatter Faceguard", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39604, "", "=q4=Heroes' Earthshatter Shoulderguards", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39597, "", "=q4=Heroes' Earthshatter Chestguard", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39601, "", "=q4=Heroes' Earthshatter Grips", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39603, "", "=q4=Heroes' Earthshatter War-Kilt", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Spell_FireResistanceTotem_01", "=q6=#t7s7_2#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40521, "", "=q4=Valorous Earthshatter Faceguard", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40524, "", "=q4=Valorous Earthshatter Shoulderguards", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40523, "", "=q4=Valorous Earthshatter Chestguard", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40520, "", "=q4=Valorous Earthshatter Grips", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40522, "", "=q4=Valorous Earthshatter War-Kilt", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Spell_FireResistanceTotem_01", "=q6=#t8s7_2#", "=q5="..AL["Tier 8"].." ("..AL["10 Man"]..")"};
		{ 17, 45412, "", "=q4=Valorous Worldbreaker Faceguard", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45415, "", "=q4=Valorous Worldbreaker Shoulderguards", "=ds="..BabbleBoss.Thorim};
		{ 19, 45413, "", "=q4=Valorous Worldbreaker Chestguard", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45414, "", "=q4=Valorous Worldbreaker Grips", "=ds="..BabbleBoss.Freya};
		{ 21, 45416, "", "=q4=Valorous Worldbreaker War-Kilt", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Spell_FireResistanceTotem_01", "=q6=#t8s7_2#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46212, "", "=q4=Conqueror's Worldbreaker Faceguard", "=ds="..BabbleBoss.Thorim};
		{ 25, 46203, "", "=q4=Conqueror's Worldbreaker Shoulderguards", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46205, "", "=q4=Conqueror's Worldbreaker Chestguard", "=ds="..BabbleBoss.Hodir};
		{ 27, 46200, "", "=q4=Conqueror's Worldbreaker Grips", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46208, "", "=q4=Conqueror's Worldbreaker War-Kilt", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxShamanElemental"] = {
		{ 1, 0, "Spell_Nature_Lightning", "=q6=#t7s7_1#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39594, "", "=q4=Heroes' Earthshatter Helm", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39596, "", "=q4=Heroes' Earthshatter Shoulderpads", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39592, "", "=q4=Heroes' Earthshatter Hauberk", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39593, "", "=q4=Heroes' Earthshatter Gloves", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39595, "", "=q4=Heroes' Earthshatter Kilt", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Spell_Nature_Lightning", "=q6=#t7s7_1#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40516, "", "=q4=Valorous Earthshatter Helm", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40518, "", "=q4=Valorous Earthshatter Shoulderpads", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40514, "", "=q4=Valorous Earthshatter Hauberk", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40515, "", "=q4=Valorous Earthshatter Gloves", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40517, "", "=q4=Valorous Earthshatter Kilt", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Spell_Nature_Lightning", "=q6=#t8s7_1#", "=q5="..AL["Tier 8"].." ("..AL["10 Man"]..")"};
		{ 17, 45408, "", "=q4=Valorous Worldbreaker Helm", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45410, "", "=q4=Valorous Worldbreaker Shoulderpads", "=ds="..BabbleBoss.Thorim};
		{ 19, 45411, "", "=q4=Valorous Worldbreaker Hauberk", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45406, "", "=q4=Valorous Worldbreaker Gloves", "=ds="..BabbleBoss.Freya};
		{ 21, 45409, "", "=q4=Valorous Worldbreaker Kilt", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Spell_Nature_Lightning", "=q6=#t8s7_1#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46209, "", "=q4=Conqueror's Worldbreaker Helm", "=ds="..BabbleBoss.Thorim};
		{ 25, 46211, "", "=q4=Conqueror's Worldbreaker Shoulderpads", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46206, "", "=q4=Conqueror's Worldbreaker Hauberk", "=ds="..BabbleBoss.Hodir};
		{ 27, 46207, "", "=q4=Conqueror's Worldbreaker Gloves", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46210, "", "=q4=Conqueror's Worldbreaker Kilt", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxWarlock"] = {
		{ 1, 0, "Spell_Shadow_CurseOfTounges", "=q6=#t7s8#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39496, "", "=q4=Heroes' Plagueheart Circlet", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39499, "", "=q4=Heroes' Plagueheart Shoulderpads", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39497, "", "=q4=Heroes' Plagueheart Robe", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39500, "", "=q4=Heroes' Plagueheart Gloves", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39498, "", "=q4=Heroes' Plagueheart Leggings", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Spell_Shadow_CurseOfTounges", "=q6=#t7s8#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40421, "", "=q4=Valorous Plagueheart Circlet", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40424, "", "=q4=Valorous Plagueheart Shoulderpads", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40423, "", "=q4=Valorous Plagueheart Robe", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40420, "", "=q4=Valorous Plagueheart Gloves", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40422, "", "=q4=Valorous Plagueheart Leggings", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Spell_Shadow_CurseOfTounges", "=q6=#t8s8#", "=q5="..AL["Tier 8"].." ("..AL["10 Man"]..")"};
		{ 17, 45417, "", "=q4=Valorous Deathbringer Hood", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45422, "", "=q4=Valorous Deathbringer Shoulderpads", "=ds="..BabbleBoss.Thorim};
		{ 19, 45421, "", "=q4=Valorous Deathbringer Robe", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45419, "", "=q4=Valorous Deathbringer Gloves", "=ds="..BabbleBoss.Freya};
		{ 21, 45420, "", "=q4=Valorous Deathbringer Leggings", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Spell_Shadow_CurseOfTounges", "=q6=#t8s8#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46140, "", "=q4=Conqueror's Deathbringer Hood", "=ds="..BabbleBoss.Thorim};
		{ 25, 46136, "", "=q4=Conqueror's Deathbringer Shoulderpads", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46137, "", "=q4=Conqueror's Deathbringer Robe", "=ds="..BabbleBoss.Hodir};
		{ 27, 46135, "", "=q4=Conqueror's Deathbringer Gloves", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46139, "", "=q4=Conqueror's Deathbringer Leggings", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxWarriorFury"] = {
		{ 1, 0, "Ability_Warrior_BattleShout", "=q6=#t7s9_1#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39605, "", "=q4=Heroes' Dreadnaught Helmet", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39608, "", "=q4=Heroes' Dreadnaught Shoulderplates", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39606, "", "=q4=Heroes' Dreadnaught Battleplate", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39609, "", "=q4=Heroes' Dreadnaught Gauntlets", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39607, "", "=q4=Heroes' Dreadnaught Legplates", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "Ability_Warrior_BattleShout", "=q6=#t7s9_1#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40528, "", "=q4=Valorous Dreadnaught Helmet", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40530, "", "=q4=Valorous Dreadnaught Shoulderplates", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40525, "", "=q4=Valorous Dreadnaught Battleplate", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40527, "", "=q4=Valorous Dreadnaught Gauntlets", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40529, "", "=q4=Valorous Dreadnaught Legplates", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "Ability_Warrior_BattleShout", "=q6=#t8s9_1#", "=q5="..AL["Tier 8"].." ("..AL["10 Man"]..")"};
		{ 17, 45431, "", "=q4=Valorous Siegebreaker Helmet", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45433, "", "=q4=Valorous Siegebreaker Shoulderplates", "=ds="..BabbleBoss.Thorim};
		{ 19, 45429, "", "=q4=Valorous Siegebreaker Battleplate", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45430, "", "=q4=Valorous Siegebreaker Gauntlets", "=ds="..BabbleBoss.Freya};
		{ 21, 45432, "", "=q4=Valorous Siegebreaker Legplates", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "Ability_Warrior_BattleShout", "=q6=#t8s9_1#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46151, "", "=q4=Conqueror's Siegebreaker Helmet", "=ds="..BabbleBoss.Thorim};
		{ 25, 46149, "", "=q4=Conqueror's Siegebreaker Shoulderplates", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46146, "", "=q4=Conqueror's Siegebreaker Battleplate", "=ds="..BabbleBoss.Hodir};
		{ 27, 46148, "", "=q4=Conqueror's Siegebreaker Gauntlets", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46150, "", "=q4=Conqueror's Siegebreaker Legplates", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

	AtlasLoot_Data["NaxxWarriorProtection"] = {
		{ 1, 0, "INV_Shield_05", "=q6=#t7s9_2#", "=q5="..AL["Tier 7"].." ("..AL["10 Man"]..")"};
		{ 2, 39610, "", "=q4=Heroes' Dreadnaught Greathelm", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 3, 39613, "", "=q4=Heroes' Dreadnaught Pauldrons", "=ds="..BabbleBoss["Loatheb"]};
		{ 4, 39611, "", "=q4=Heroes' Dreadnaught Breastplate", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 5, 39622, "", "=q4=Heroes' Dreadnaught Handguards", "=ds="..BabbleBoss["Sartharion"]};
		{ 6, 39612, "", "=q4=Heroes' Dreadnaught Legguards", "=ds="..BabbleBoss["Thaddius"]};
		{ 8, 0, "INV_Shield_05", "=q6=#t7s9_2#", "=q5="..AL["Tier 7"].." ("..AL["25 Man"]..")"};
		{ 9, 40546, "", "=q4=Valorous Dreadnaught Greathelm", "=ds="..BabbleBoss["Kel'Thuzad"]};
		{ 10, 40548, "", "=q4=Valorous Dreadnaught Pauldrons", "=ds="..BabbleBoss["Loatheb"]};
		{ 11, 40544, "", "=q4=Valorous Dreadnaught Breastplate", "=ds="..BabbleBoss["The Four Horsemen"]};
		{ 12, 40545, "", "=q4=Valorous Dreadnaught Handguards", "=ds="..BabbleBoss["Sartharion"]};
		{ 13, 40547, "", "=q4=Valorous Dreadnaught Legguards", "=ds="..BabbleBoss["Thaddius"]};
		{ 16, 0, "INV_Shield_05", "=q6=#t8s9_2#", "=q5="..AL["Tier 8"].." ("..AL["10 Man"]..")"};
		{ 17, 45425, "", "=q4=Valorous Siegebreaker Greathelm", "=ds="..BabbleBoss["Mimiron"]};
		{ 18, 45428, "", "=q4=Valorous Siegebreaker Pauldrons", "=ds="..BabbleBoss.Thorim};
		{ 19, 45424, "", "=q4=Valorous Siegebreaker Breastplate", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 20, 45426, "", "=q4=Valorous Siegebreaker Handguards", "=ds="..BabbleBoss.Freya};
		{ 21, 45427, "", "=q4=Valorous Siegebreaker Legguards", "=ds="..BabbleBoss.Hodir};
		{ 23, 0, "INV_Shield_05", "=q6=#t8s9_2#", "=q5="..AL["Tier 8"].." ("..AL["25 Man"]..")"};
		{ 24, 46166, "", "=q4=Conqueror's Siegebreaker Greathelm", "=ds="..BabbleBoss.Thorim};
		{ 25, 46167, "", "=q4=Conqueror's Siegebreaker Pauldrons", "=ds="..BabbleBoss["Yogg-Saron"]};
		{ 26, 46162, "", "=q4=Conqueror's Siegebreaker Breastplate", "=ds="..BabbleBoss.Hodir};
		{ 27, 46164, "", "=q4=Conqueror's Siegebreaker Handguards", "=ds="..BabbleBoss["Mimiron"]};
		{ 28, 46169, "", "=q4=Conqueror's Siegebreaker Legguards", "=ds="..BabbleBoss.Freya};
		Back = "T7T8SET";
	};

		------------------------
		--- Tier 9 Sets (T9) ---
		------------------------

	AtlasLoot_Data["T9DeathKnightDPS_A"] = {
		{ 1, 0, "Spell_Deathknight_DeathStrike", "=q6=#t9s10_2a#", "=q5="..AL["Tier 9"]};
		{ 2, 48472, "", "=q4=Thassarian's Helmet of Conquest", "=ds=#s1#, #a4#", "50 #eoftriumph#"};
		{ 3, 48478, "", "=q4=Thassarian's Shoulderplates of Conquest", "=ds=#s3#, #a4#", "30 #eoftriumph#"};
		{ 4, 48474, "", "=q4=Thassarian's Battleplate of Conquest", "=ds=#s5#, #a4#", "50 #eoftriumph#"};
		{ 5, 48480, "", "=q4=Thassarian's Gauntlets of Conquest", "=ds=#s9#, #a4#", "30 #eoftriumph#"};
		{ 6, 48476, "", "=q4=Thassarian's Legplates of Conquest", "=ds=#s11#, #a4#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Deathknight_DeathStrike", "=q6=#t9s10_2a#", "=q5="..AL["Tier 9"]};
		{ 9, 48483, "", "=q4=Thassarian's Helmet of Triumph", "=ds=#s1#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48485, "", "=q4=Thassarian's Shoulderplates of Triumph", "=ds=#s3#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48481, "", "=q4=Thassarian's Battleplate of Triumph", "=ds=#s5#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48482, "", "=q4=Thassarian's Gauntlets of Triumph", "=ds=#s9#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48484, "", "=q4=Thassarian's Legplates of Triumph", "=ds=#s11#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Deathknight_DeathStrike", "=q6=#t9s10_2a#", "=q5="..AL["Tier 9"]};
		{ 17, 48488, "", "=q4=Thassarian's Helmet of Triumph", "=ds="};
		{ 18, 48486, "", "=q4=Thassarian's Shoulderplates of Triumph", "=ds="};
		{ 19, 48490, "", "=q4=Thassarian's Battleplate of Triumph", "=ds="};
		{ 20, 48489, "", "=q4=Thassarian's Gauntlets of Triumph", "=ds="};
		{ 21, 48487, "", "=q4=Thassarian's Legplates of Triumph", "=ds="};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9DeathKnightDPS_H"] = {
		{ 1, 0, "Spell_Deathknight_DeathStrike", "=q6=#t9s10_2h#", "=q5="..AL["Tier 9"]};
		{ 2, 48503, "", "=q4=Koltira's Helmet of Conquest", "=ds=#s1#, #a4#", "50 #eoftriumph#"};
		{ 3, 48505, "", "=q4=Koltira's Shoulderplates of Conquest", "=ds=#s3#, #a4#", "30 #eoftriumph#"};
		{ 4, 48501, "", "=q4=Koltira's Battleplate of Conquest", "=ds=#s5#, #a4#", "50 #eoftriumph#"};
		{ 5, 48502, "", "=q4=Koltira's Gauntlets of Conquest", "=ds=#s9#, #a4#", "30 #eoftriumph#"};
		{ 6, 48504, "", "=q4=Koltira's Legplates of Conquest", "=ds=#s11#, #a4#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Deathknight_DeathStrike", "=q6=#t9s10_2h#", "=q5="..AL["Tier 9"]};
		{ 9, 48498, "", "=q4=Koltira's Helmet of Triumph", "=ds=#s1#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48496, "", "=q4=Koltira's Shoulderplates of Triumph", "=ds=#s3#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48500, "", "=q4=Koltira's Battleplate of Triumph", "=ds=#s5#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48499, "", "=q4=Koltira's Gauntlets of Triumph", "=ds=#s9#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48497, "", "=q4=Koltira's Legplates of Triumph", "=ds=#s11#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Deathknight_DeathStrike", "=q6=#t9s10_2h#", "=q5="..AL["Tier 9"]};
		{ 17, 48493, "", "=q4=Koltira's Helmet of Triumph", "=ds="};
		{ 18, 48495, "", "=q4=Koltira's Shoulderplates of Triumph", "=ds="};
		{ 19, 48491, "", "=q4=Koltira's Battleplate of Triumph", "=ds="};
		{ 20, 48492, "", "=q4=Koltira's Gauntlets of Triumph", "=ds="};
		{ 21, 48494, "", "=q4=Koltira's Legplates of Triumph", "=ds="};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9DeathKnightTank_A"] = {
		{ 1, 0, "Spell_Deathknight_DeathStrike", "=q6=#t9s10_1a#", "=q5="..AL["Tier 9"]};
		{ 2, 48529, "", "=q4=Thassarian's Faceguard of Conquest", "=ds=#s1#, #a4#", "50 #eoftriumph#"};
		{ 3, 48535, "", "=q4=Thassarian's Pauldrons of Conquest", "=ds=#s3#, #a4#", "30 #eoftriumph#"};
		{ 4, 48531, "", "=q4=Thassarian's Chestguard of Conquest", "=ds=#s5#, #a4#", "50 #eoftriumph#"};
		{ 5, 48537, "", "=q4=Thassarian's Handguards of Conquest", "=ds=#s9#, #a4#", "30 #eoftriumph#"};
		{ 6, 48533, "", "=q4=Thassarian's Legguards of Conquest", "=ds=#s11#, #a4#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Deathknight_DeathStrike", "=q6=#t9s10_1a#", "=q5="..AL["Tier 9"]};
		{ 9, 48540, "", "=q4=Thassarian's Faceguard of Triumph", "=ds=#s1#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48542, "", "=q4=Thassarian's Pauldrons of Triumph", "=ds=#s3#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48538, "", "=q4=Thassarian's Chestguard of Triumph", "=ds=#s5#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48539, "", "=q4=Thassarian's Handguards of Triumph", "=ds=#s9#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48541, "", "=q4=Thassarian's Legguards of Triumph", "=ds=#s11#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Deathknight_DeathStrike", "=q6=#t9s10_1a#", "=q5="..AL["Tier 9"]};
		{ 17, 48545, "", "=q4=Thassarian's Faceguard of Triumph", "=ds="};
		{ 18, 48543, "", "=q4=Thassarian's Pauldrons of Triumph", "=ds="};
		{ 19, 48547, "", "=q4=Thassarian's Chestguard of Triumph", "=ds="};
		{ 20, 48546, "", "=q4=Thassarian's Handguards of Triumph", "=ds="};
		{ 21, 48544, "", "=q4=Thassarian's Legguards of Triumph", "=ds="};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9DeathKnightTank_H"] = {
		{ 1, 0, "Spell_Deathknight_DeathStrike", "=q6=#t9s10_1h#", "=q5="..AL["Tier 9"]};
		{ 2, 48560, "", "=q4=Koltira's Faceguard of Conquest", "=ds=#s1#, #a4#", "50 #eoftriumph#"};
		{ 3, 48562, "", "=q4=Koltira's Pauldrons of Conquest", "=ds=#s3#, #a4#", "30 #eoftriumph#"};
		{ 4, 48558, "", "=q4=Koltira's Chestguard of Conquest", "=ds=#s5#, #a4#", "50 #eoftriumph#"};
		{ 5, 48559, "", "=q4=Koltira's Handguards of Conquest", "=ds=#s9#, #a4#", "30 #eoftriumph#"};
		{ 6, 48561, "", "=q4=Koltira's Legguards of Conquest", "=ds=#s11#, #a4#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Deathknight_DeathStrike", "=q6=#t9s10_1h#", "=q5="..AL["Tier 9"]};
		{ 9, 48555, "", "=q4=Koltira's Faceguard of Triumph", "=ds=#s1#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48553, "", "=q4=Koltira's Pauldrons of Triumph", "=ds=#s3#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48557, "", "=q4=Koltira's Chestguard of Triumph", "=ds=#s5#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48556, "", "=q4=Koltira's Handguards of Triumph", "=ds=#s9#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48554, "", "=q4=Koltira's Legguards of Triumph", "=ds=#s11#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Deathknight_DeathStrike", "=q6=#t9s10_1h#", "=q5="..AL["Tier 9"]};
		{ 17, 48550, "", "=q4=Koltira's Faceguard of Triumph", "=ds="};
		{ 18, 48552, "", "=q4=Koltira's Pauldrons of Triumph", "=ds="};
		{ 19, 48548, "", "=q4=Koltira's Chestguard of Triumph", "=ds="};
		{ 20, 48549, "", "=q4=Koltira's Handguards of Triumph", "=ds="};
		{ 21, 48551, "", "=q4=Koltira's Legguards of Triumph", "=ds="};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9DruidRestoration_A"] = {
		{ 1, 0, "Spell_Nature_Regeneration", "=q6=#t9s1_1a#", "=q5="..AL["Tier 9"]};
		{ 2, 48102, "", "=q4=Malfurion's Headpiece of Conquest", "=ds=#s1#, #a2#", "50 #eoftriumph#"};
		{ 3, 48131, "", "=q4=Malfurion's Spaulders of Conquest", "=ds=#s3#, #a2#", "30 #eoftriumph#"};
		{ 4, 48129, "", "=q4=Malfurion's Robe of Conquest", "=ds=#s5#, #a2#", "50 #eoftriumph#"};
		{ 5, 48132, "", "=q4=Malfurion's Handguards of Conquest", "=ds=#s9#, #a2#", "30 #eoftriumph#"};
		{ 6, 48130, "", "=q4=Malfurion's Leggings of Conquest", "=ds=#s11#, #a2#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Nature_Regeneration", "=q6=#t9s1_1a#", "=q5="..AL["Tier 9"]};
		{ 9, 48134, "", "=q4=Malfurion's Headpiece of Triumph", "=ds=#s1#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48137, "", "=q4=Malfurion's Spaulders of Triumph", "=ds=#s3#, #a2#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48136, "", "=q4=Malfurion's Robe of Triumph", "=ds=#s5#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48133, "", "=q4=Malfurion's Handguards of Triumph", "=ds=#s9#, #a2#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48135, "", "=q4=Malfurion's Leggings of Triumph", "=ds=#s11#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Nature_Regeneration", "=q6=#t9s1_1a#", "=q5="..AL["Tier 9"]};
		{ 17, 48141, "", "=q4=Malfurion's Headpiece of Triumph", "=ds="};
		{ 18, 48138, "", "=q4=Malfurion's Spaulders of Triumph", "=ds="};
		{ 19, 48139, "", "=q4=Malfurion's Robe of Triumph", "=ds="};
		{ 20, 48142, "", "=q4=Malfurion's Handguards of Triumph", "=ds="};
		{ 21, 48140, "", "=q4=Malfurion's Leggings of Triumph", "=ds="};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9DruidRestoration_H"] = {
		{ 1, 0, "Spell_Nature_Regeneration", "=q6=#t9s1_1h#", "=q5="..AL["Tier 9"]};
		{ 2, 48154, "", "=q4=Runetotem's Headpiece of Conquest", "=ds=#s1#, #a2#", "50 #eoftriumph#"};
		{ 3, 48157, "", "=q4=Runetotem's Spaulders of Conquest", "=ds=#s3#, #a2#", "30 #eoftriumph#"};
		{ 4, 48156, "", "=q4=Runetotem's Robe of Conquest", "=ds=#s5#, #a2#", "50 #eoftriumph#"};
		{ 5, 48153, "", "=q4=Runetotem's Handguards of Conquest", "=ds=#s9#, #a2#", "30 #eoftriumph#"};
		{ 6, 48155, "", "=q4=Runetotem's Leggings of Conquest", "=ds=#s11#, #a2#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Nature_Regeneration", "=q6=#t9s1_1h#", "=q5="..AL["Tier 9"]};
		{ 9, 48151, "", "=q4=Runetotem's Headpiece of Triumph", "=ds=#s1#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48148, "", "=q4=Runetotem's Spaulders of Triumph", "=ds=#s3#, #a2#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48149, "", "=q4=Runetotem's Robe of Triumph", "=ds=#s5#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48152, "", "=q4=Runetotem's Handguards of Triumph", "=ds=#s9#, #a2#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48150, "", "=q4=Runetotem's Leggings of Triumph", "=ds=#s11#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Nature_Regeneration", "=q6=#t9s1_1h#", "=q5="..AL["Tier 9"]};
		{ 17, 48144, "", "=q4=Runetotem's Headpiece of Triumph", "=ds="};
		{ 18, 48147, "", "=q4=Runetotem's Spaulders of Triumph", "=ds="};
		{ 19, 48146, "", "=q4=Runetotem's Robe of Triumph", "=ds="};
		{ 20, 48143, "", "=q4=Runetotem's Handguards of Triumph", "=ds="};
		{ 21, 48145, "", "=q4=Runetotem's Leggings of Triumph", "=ds="};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9DruidFeral_A"] = {
		{ 1, 0, "Ability_Druid_Maul", "=q6=#t9s1_2a#", "=q5="..AL["Tier 9"]};
		{ 2, 48214, "", "=q4=Malfurion's Headguard of Conquest", "=ds=#s1#, #a2#", "50 #eoftriumph#"};
		{ 3, 48217, "", "=q4=Malfurion's Shoulderpads of Conquest", "=ds=#s3#, #a2#", "30 #eoftriumph#"};
		{ 4, 48216, "", "=q4=Malfurion's Raiments of Conquest", "=ds=#s5#, #a2#", "50 #eoftriumph#"};
		{ 5, 48213, "", "=q4=Malfurion's Handgrips of Conquest", "=ds=#s9#, #a2#", "30 #eoftriumph#"};
		{ 6, 48215, "", "=q4=Malfurion's Legguards of Conquest", "=ds=#s11#, #a2#", "50 #eoftriumph#"};
		{ 8, 0, "Ability_Druid_Maul", "=q6=#t9s1_2a#", "=q5="..AL["Tier 9"]};
		{ 9, 48211, "", "=q4=Malfurion's Headguard of Triumph", "=ds=#s1#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48208, "", "=q4=Malfurion's Shoulderpads of Triumph", "=ds=#s3#, #a2#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48209, "", "=q4=Malfurion's Raiments of Triumph", "=ds=#s5#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48212, "", "=q4=Malfurion's Handgrips of Triumph", "=ds=#s9#, #a2#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48210, "", "=q4=Malfurion's Legguards of Triumph", "=ds=#s11#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Ability_Druid_Maul", "=q6=#t9s1_2a#", "=q5="..AL["Tier 9"]};
		{ 17, 48204, "", "=q4=Malfurion's Headguard of Triumph", "=ds="};
		{ 18, 48207, "", "=q4=Malfurion's Shoulderpads of Triumph", "=ds="};
		{ 19, 48206, "", "=q4=Malfurion's Raiments of Triumph", "=ds="};
		{ 20, 48203, "", "=q4=Malfurion's Handgrips of Triumph", "=ds="};
		{ 21, 48205, "", "=q4=Malfurion's Legguards of Triumph", "=ds="};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9DruidFeral_H"] = {
		{ 1, 0, "Ability_Druid_Maul", "=q6=#t9s1_2h#", "=q5="..AL["Tier 9"]};
		{ 2, 48188, "", "=q4=Runetotem's Headguard of Conquest", "=ds=#s1#, #a2#", "50 #eoftriumph#"};
		{ 3, 48191, "", "=q4=Runetotem's Shoulderpads of Conquest", "=ds=#s3#, #a2#", "30 #eoftriumph#"};
		{ 4, 48189, "", "=q4=Runetotem's Raiments of Conquest", "=ds=#s5#, #a2#", "50 #eoftriumph#"};
		{ 5, 48192, "", "=q4=Runetotem's Handgrips of Conquest", "=ds=#s9#, #a2#", "30 #eoftriumph#"};
		{ 6, 48190, "", "=q4=Runetotem's Legguards of Conquest", "=ds=#s11#, #a2#", "50 #eoftriumph#"};
		{ 8, 0, "Ability_Druid_Maul", "=q6=#t9s1_2h#", "=q5="..AL["Tier 9"]};
		{ 9, 48194, "", "=q4=Runetotem's Headguard of Triumph", "=ds=#s1#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48197, "", "=q4=Runetotem's Shoulderpads of Triumph", "=ds=#s3#, #a2#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48196, "", "=q4=Runetotem's Raiments of Triumph", "=ds=#s5#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48193, "", "=q4=Runetotem's Handgrips of Triumph", "=ds=#s9#, #a2#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48195, "", "=q4=Runetotem's Legguards of Triumph", "=ds=#s11#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Ability_Druid_Maul", "=q6=#t9s1_2h#", "=q5="..AL["Tier 9"]};
		{ 17, 48201, "", "=q4=Runetotem's Headguard of Triumph", "=ds="};
		{ 18, 48198, "", "=q4=Runetotem's Shoulderpads of Triumph", "=ds="};
		{ 19, 48199, "", "=q4=Runetotem's Raiments of Triumph", "=ds="};
		{ 20, 48202, "", "=q4=Runetotem's Handgrips of Triumph", "=ds="};
		{ 21, 48200, "", "=q4=Runetotem's Legguards of Triumph", "=ds="};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9DruidBalance_A"] = {
		{ 1, 0, "Spell_Nature_InsectSwarm", "=q6=#t9s1_3a#", "=q5="..AL["Tier 9"]};
		{ 2, 48158, "", "=q4=Malfurion's Cover of Conquest", "=ds=#s1#, #a2#", "50 #eoftriumph#"};
		{ 3, 48161, "", "=q4=Malfurion's Mantle of Conquest", "=ds=#s3#, #a2#", "30 #eoftriumph#"};
		{ 4, 48159, "", "=q4=Malfurion's Vestments of Conquest", "=ds=#s5#, #a2#", "50 #eoftriumph#"};
		{ 5, 48162, "", "=q4=Malfurion's Gloves of Conquest", "=ds=#s9#, #a2#", "30 #eoftriumph#"};
		{ 6, 48160, "", "=q4=Malfurion's Trousers of Conquest", "=ds=#s11#, #a2#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Nature_InsectSwarm", "=q6=#t9s1_3a#", "=q5="..AL["Tier 9"]};
		{ 9, 48164, "", "=q4=Malfurion's Cover of Triumph", "=ds=#s1#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48167, "", "=q4=Malfurion's Mantle of Triumph", "=ds=#s3#, #a2#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48166, "", "=q4=Malfurion's Vestments of Triumph", "=ds=#s5#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48163, "", "=q4=Malfurion's Gloves of Triumph", "=ds=#s9#, #a2#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48165, "", "=q4=Malfurion's Trousers of Triumph", "=ds=#s11#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Nature_InsectSwarm", "=q6=#t9s1_3a#", "=q5="..AL["Tier 9"]};
		{ 17, 48171, "", "=q4=Malfurion's Cover of Triumph", "=ds="};
		{ 18, 48168, "", "=q4=Malfurion's Mantle of Triumph", "=ds="};
		{ 19, 48169, "", "=q4=Malfurion's Vestments of Triumph", "=ds="};
		{ 20, 48172, "", "=q4=Malfurion's Gloves of Triumph", "=ds="};
		{ 21, 48170, "", "=q4=Malfurion's Trousers of Triumph", "=ds="};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9DruidBalance_H"] = {
		{ 1, 0, "Spell_Nature_InsectSwarm", "=q6=#t9s1_3h#", "=q5="..AL["Tier 9"]};
		{ 2, 48184, "", "=q4=Runetotem's Cover of Conquest", "=ds=#s1#, #a2#", "50 #eoftriumph#"};
		{ 3, 48187, "", "=q4=Runetotem's Mantle of Conquest", "=ds=#s3#, #a2#", "30 #eoftriumph#"};
		{ 4, 48186, "", "=q4=Runetotem's Vestments of Conquest", "=ds=#s5#, #a2#", "50 #eoftriumph#"};
		{ 5, 48183, "", "=q4=Runetotem's Gloves of Conquest", "=ds=#s9#, #a2#", "30 #eoftriumph#"};
		{ 6, 48185, "", "=q4=Runetotem's Trousers of Conquest", "=ds=#s11#, #a2#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Nature_InsectSwarm", "=q6=#t9s1_3h#", "=q5="..AL["Tier 9"]};
		{ 9, 48181, "", "=q4=Runetotem's Cover of Triumph", "=ds=#s1#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48178, "", "=q4=Runetotem's Mantle of Triumph", "=ds=#s3#, #a2#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48179, "", "=q4=Runetotem's Vestments of Triumph", "=ds=#s5#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48182, "", "=q4=Runetotem's Gloves of Triumph", "=ds=#s9#, #a2#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48180, "", "=q4=Runetotem's Trousers of Triumph", "=ds=#s11#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Nature_InsectSwarm", "=q6=#t9s1_3h#", "=q5="..AL["Tier 9"]};
		{ 17, 48174, "", "=q4=Runetotem's Cover of Triumph", "=ds="};
		{ 18, 48177, "", "=q4=Runetotem's Mantle of Triumph", "=ds="};
		{ 19, 48176, "", "=q4=Runetotem's Vestments of Triumph", "=ds="};
		{ 20, 48173, "", "=q4=Runetotem's Gloves of Triumph", "=ds="};
		{ 21, 48175, "", "=q4=Runetotem's Trousers of Triumph", "=ds="};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9Hunter_A"] = {
		{ 1, 0, "Ability_Hunter_RunningShot", "=q6=#t9s2_a#", "=q5="..AL["Tier 9"]};
		{ 2, 48250, "", "=q4=Windrunner's Headpiece of Conquest", "=ds=#s1#, #a3#", "50 #eoftriumph#"};
		{ 3, 48253, "", "=q4=Windrunner's Spaulders of Conquest", "=ds=#s3#, #a3#", "30 #eoftriumph#"};
		{ 4, 48251, "", "=q4=Windrunner's Tunic of Conquest", "=ds=#s5#, #a3#", "50 #eoftriumph#"};
		{ 5, 48254, "", "=q4=Windrunner's Handguards of Conquest", "=ds=#s9#, #a3#", "30 #eoftriumph#"};
		{ 6, 48252, "", "=q4=Windrunner's Legguards of Conquest", "=ds=#s11#, #a3#", "50 #eoftriumph#"};
		{ 8, 0, "Ability_Hunter_RunningShot", "=q6=#t9s2_a#", "=q5="..AL["Tier 9"]};
		{ 9, 48257, "", "=q4=Windrunner's Headpiece of Triumph", "=ds=#s1#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48259, "", "=q4=Windrunner's Spaulders of Triumph", "=ds=#s3#, #a3#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48255, "", "=q4=Windrunner's Tunic of Triumph", "=ds=#s5#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48256, "", "=q4=Windrunner's Handguards of Triumph", "=ds=#s9#, #a3#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48258, "", "=q4=Windrunner's Legguards of Triumph", "=ds=#s11#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Ability_Hunter_RunningShot", "=q6=#t9s2_h#", "=q5="..AL["Tier 9"]};
		{ 17, 48262, "", "=q4=Windrunner's Headpiece of Triumph", "=ds=#s1#, #a3#"};
		{ 18, 48260, "", "=q4=Windrunner's Spaulders of Triumph", "=ds=#s3#, #a3#"};
		{ 19, 48264, "", "=q4=Windrunner's Tunic of Triumph", "=ds=#s5#, #a3#"};
		{ 20, 48263, "", "=q4=Windrunner's Handguards of Triumph", "=ds=#s9#, #a3#"};
		{ 21, 48261, "", "=q4=Windrunner's Legguards of Triumph", "=ds=#s11#, #a3#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9Hunter_H"] = {
		{ 1, 0, "Ability_Hunter_RunningShot", "=q6=#t9s2_h#", "=q5="..AL["Tier 9"]};
		{ 2, 48277, "", "=q4=Windrunner's Headpiece of Conquest", "=ds=#s1#, #a3#", "50 #eoftriumph#"};
		{ 3, 48279, "", "=q4=Windrunner's Spaulders of Conquest", "=ds=#s3#, #a3#", "30 #eoftriumph#"};
		{ 4, 48275, "", "=q4=Windrunner's Tunic of Conquest", "=ds=#s5#, #a3#", "50 #eoftriumph#"};
		{ 5, 48276, "", "=q4=Windrunner's Handguards of Conquest", "=ds=#s9#, #a3#", "30 #eoftriumph#"};
		{ 6, 48278, "", "=q4=Windrunner's Legguards of Conquest", "=ds=#s11#, #a3#", "50 #eoftriumph#"};
		{ 8, 0, "Ability_Hunter_RunningShot", "=q6=#t9s2_h#", "=q5="..AL["Tier 9"]};
		{ 9, 48272, "", "=q4=Windrunner's Headpiece of Triumph", "=ds=#s1#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48270, "", "=q4=Windrunner's Spaulders of Triumph", "=ds=#s3#, #a3#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48274, "", "=q4=Windrunner's Tunic of Triumph", "=ds=#s5#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48273, "", "=q4=Windrunner's Handguards of Triumph", "=ds=#s9#, #a3#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48271, "", "=q4=Windrunner's Legguards of Triumph", "=ds=#s11#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Ability_Hunter_RunningShot", "=q6=#t9s2_h#", "=q5="..AL["Tier 9"]};
		{ 17, 48267, "", "=q4=Windrunner's Headpiece of Triumph", "=ds=#s1#, #a3#"};
		{ 18, 48269, "", "=q4=Windrunner's Spaulders of Triumph", "=ds=#s3#, #a3#"};
		{ 19, 48265, "", "=q4=Windrunner's Tunic of Triumph", "=ds=#s5#, #a3#"};
		{ 20, 48266, "", "=q4=Windrunner's Handguards of Triumph", "=ds=#s9#, #a3#"};
		{ 21, 48268, "", "=q4=Windrunner's Legguards of Triumph", "=ds=#s11#, #a3#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9Mage_A"] = {
		{ 1, 0, "Spell_Frost_IceStorm", "=q6=#t9s3_a#", "=q5="..AL["Tier 9"]};
		{ 2, 47748, "", "=q4=Khadgar's Hood of Conquest", "=ds=#s1#, #a1#", "50 #eoftriumph#"};
		{ 3, 47751, "", "=q4=Khadgar's Shoulderpads of Conquest", "=ds=#s3#, #a1#", "30 #eoftriumph#"};
		{ 4, 47749, "", "=q4=Khadgar's Robe of Conquest", "=ds=#s5#, #a1#", "50 #eoftriumph#"};
		{ 5, 47752, "", "=q4=Khadgar's Gauntlets of Conquest", "=ds=#s9#, #a1#", "30 #eoftriumph#"};
		{ 6, 47750, "", "=q4=Khadgar's Leggings of Conquest", "=ds=#s11#, #a1#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Frost_IceStorm", "=q6=#t9s3_a#", "=q5="..AL["Tier 9"]};
		{ 9, 47754, "", "=q4=Khadgar's Hood of Triumph", "=ds=#s1#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 47757, "", "=q4=Khadgar's Shoulderpads of Triumph", "=ds=#s3#, #a1#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 47756, "", "=q4=Khadgar's Robe of Triumph", "=ds=#s5#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 47753, "", "=q4=Khadgar's Gauntlets of Triumph", "=ds=#s9#, #a1#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 47755, "", "=q4=Khadgar's Leggings of Triumph", "=ds=#s11#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Frost_IceStorm", "=q6=#t9s3_a#", "=q5="..AL["Tier 9"]};
		{ 17, 47761, "", "=q4=Khadgar's Hood of Triumph", "=ds=#s1#, #a1#"};
		{ 18, 47758, "", "=q4=Khadgar's Shoulderpads of Triumph", "=ds=#s3#, #a1#"};
		{ 19, 47759, "", "=q4=Khadgar's Robe of Triumph", "=ds=#s5#, #a1#"};
		{ 20, 47762, "", "=q4=Khadgar's Gauntlets of Triumph", "=ds=#s9#, #a1#"};
		{ 21, 47760, "", "=q4=Khadgar's Leggings of Triumph", "=ds=#s11#, #a1#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9Mage_H"] = {
		{ 1, 0, "Spell_Frost_IceStorm", "=q6=#t9s3_h#", "=q5="..AL["Tier 9"]};
		{ 2, 47774, "", "=q4=Sunstrider's Hood of Conquest", "=ds=#s1#, #a1#", "50 #eoftriumph#"};
		{ 3, 47777, "", "=q4=Sunstrider's Shoulderpads of Conquest", "=ds=#s3#, #a1#", "30 #eoftriumph#"};
		{ 4, 47776, "", "=q4=Sunstrider's Robe of Conquest", "=ds=#s5#, #a1#", "50 #eoftriumph#"};
		{ 5, 47773, "", "=q4=Sunstrider's Gauntlets of Conquest", "=ds=#s9#, #a1#", "30 #eoftriumph#"};
		{ 6, 47775, "", "=q4=Sunstrider's Leggings of Conquest", "=ds=#s11#, #a1#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Frost_IceStorm", "=q6=#t9s3_h#", "=q5="..AL["Tier 9"]};
		{ 9, 47771, "", "=q4=Sunstrider's Hood of Triumph", "=ds=#s1#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 47768, "", "=q4=Sunstrider's Shoulderpads of Triumph", "=ds=#s3#, #a1#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 47769, "", "=q4=Sunstrider's Robe of Triumph", "=ds=#s5#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 47772, "", "=q4=Sunstrider's Gauntlets of Triumph", "=ds=#s9#, #a1#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 47770, "", "=q4=Sunstrider's Leggings of Triumph", "=ds=#s11#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Frost_IceStorm", "=q6=#t9s3_h#", "=q5="..AL["Tier 9"]};
		{ 17, 47764, "", "=q4=Sunstrider's Hood of Triumph", "=ds=#s1#, #a1#"};
		{ 18, 47767, "", "=q4=Sunstrider's Shoulderpads of Triumph", "=ds=#s3#, #a1#"};
		{ 19, 47766, "", "=q4=Sunstrider's Robe of Triumph", "=ds=#s5#, #a1#"};
		{ 20, 47763, "", "=q4=Sunstrider's Gauntlets of Triumph", "=ds=#s9#, #a1#"};
		{ 21, 47765, "", "=q4=Sunstrider's Leggings of Triumph", "=ds=#s11#, #a1#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9PaladinHoly_A"] = {
		{ 1, 0, "Spell_Holy_HolyBolt", "=q6=#t9s4_1a#", "=q5="..AL["Tier 9"]};
		{ 2, 48564, "", "=q4=Turalyon's Headpiece of Conquest", "=ds=#s1#, #a4#", "50 #eoftriumph#"};
		{ 3, 48572, "", "=q4=Turalyon's Spaulders of Conquest", "=ds=#s3#, #a4#", "30 #eoftriumph#"};
		{ 4, 48566, "", "=q4=Turalyon's Tunic of Conquest", "=ds=#s5#, #a4#", "50 #eoftriumph#"};
		{ 5, 48574, "", "=q4=Turalyon's Gloves of Conquest", "=ds=#s9#, #a4#", "30 #eoftriumph#"};
		{ 6, 48568, "", "=q4=Turalyon's Greaves of Conquest", "=ds=#s11#, #a4#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Holy_HolyBolt", "=q6=#t9s4_1a#", "=q5="..AL["Tier 9"]};
		{ 9, 48577, "", "=q4=Turalyon's Headpiece of Triumph", "=ds=#s1#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48579, "", "=q4=Turalyon's Spaulders of Triumph", "=ds=#s3#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48575, "", "=q4=Turalyon's Tunic of Triumph", "=ds=#s5#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48576, "", "=q4=Turalyon's Gloves of Triumph", "=ds=#s9#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48578, "", "=q4=Turalyon's Greaves of Triumph", "=ds=#s11#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Holy_HolyBolt", "=q6=#t9s4_1a#", "=q5="..AL["Tier 9"]};
		{ 17, 48582, "", "=q4=Turalyon's Headpiece of Triumph", "=ds=#s1#, #a4#"};
		{ 18, 48580, "", "=q4=Turalyon's Spaulders of Triumph", "=ds=#s3#, #a4#"};
		{ 19, 48584, "", "=q4=Turalyon's Tunic of Triumph", "=ds=#s5#, #a4#"};
		{ 20, 48583, "", "=q4=Turalyon's Gloves of Triumph", "=ds=#s9#, #a4#"};
		{ 21, 48581, "", "=q4=Turalyon's Greaves of Triumph", "=ds=#s11#, #a4#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9PaladinHoly_H"] = {
		{ 1, 0, "Spell_Holy_HolyBolt", "=q6=#t9s4_1h#", "=q5="..AL["Tier 9"]};
		{ 2, 48597, "", "=q4=Liadrin's Headpiece of Conquest", "=ds=#s1#, #a4#", "50 #eoftriumph#"};
		{ 3, 48595, "", "=q4=Liadrin's Spaulders of Conquest", "=ds=#s3#, #a4#", "30 #eoftriumph#"};
		{ 4, 48599, "", "=q4=Liadrin's Tunic of Conquest", "=ds=#s5#, #a4#", "50 #eoftriumph#"};
		{ 5, 48598, "", "=q4=Liadrin's Gloves of Conquest", "=ds=#s9#, #a4#", "30 #eoftriumph#"};
		{ 6, 48596, "", "=q4=Liadrin's Greaves of Conquest", "=ds=#s11#, #a4#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Holy_HolyBolt", "=q6=#t9s4_1h#", "=q5="..AL["Tier 9"]};
		{ 9, 48592, "", "=q4=Liadrin's Headpiece of Triumph", "=ds=#s1#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48590, "", "=q4=Liadrin's Spaulders of Triumph", "=ds=#s3#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48594, "", "=q4=Liadrin's Tunic of Triumph", "=ds=#s5#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48593, "", "=q4=Liadrin's Gloves of Triumph", "=ds=#s9#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48591, "", "=q4=Liadrin's Greaves of Triumph", "=ds=#s11#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Holy_HolyBolt", "=q6=#t9s4_1h#", "=q5="..AL["Tier 9"]};
		{ 17, 48587, "", "=q4=Liadrin's Headpiece of Triumph", "=ds=#s1#, #a4#"};
		{ 18, 48585, "", "=q4=Liadrin's Spaulders of Triumph", "=ds=#s3#, #a4#"};
		{ 19, 48589, "", "=q4=Liadrin's Tunic of Triumph", "=ds=#s5#, #a4#"};
		{ 20, 48588, "", "=q4=Liadrin's Gloves of Triumph", "=ds=#s9#, #a4#"};
		{ 21, 48586, "", "=q4=Liadrin's Greaves of Triumph", "=ds=#s11#, #a4#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9PaladinRetribution_A"] = {
		{ 1, 0, "Spell_Holy_AuraOfLight", "=q6=#t9s4_2a#", "=q5="..AL["Tier 9"]};
		{ 2, 48604, "", "=q4=Turalyon's Helm of Conquest", "=ds=#s1#, #a4#", "50 #eoftriumph#"};
		{ 3, 48606, "", "=q4=Turalyon's Shoulderplates of Conquest", "=ds=#s3#, #a4#", "30 #eoftriumph#"};
		{ 4, 48602, "", "=q4=Turalyon's Battleplate of Conquest", "=ds=#s5#, #a4#", "50 #eoftriumph#"};
		{ 5, 48603, "", "=q4=Turalyon's Gauntlets of Conquest", "=ds=#s9#, #a4#", "30 #eoftriumph#"};
		{ 6, 48605, "", "=q4=Turalyon's Legplates of Conquest", "=ds=#s11#, #a4#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Holy_AuraOfLight", "=q6=#t9s4_2a#", "=q5="..AL["Tier 9"]};
		{ 9, 48609, "", "=q4=Turalyon's Helm of Triumph", "=ds=#s1#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48611, "", "=q4=Turalyon's Shoulderplates of Triumph", "=ds=#s3#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48607, "", "=q4=Turalyon's Battleplate of Triumph", "=ds=#s5#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48608, "", "=q4=Turalyon's Gauntlets of Triumph", "=ds=#s9#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48610, "", "=q4=Turalyon's Legplates of Triumph", "=ds=#s11#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Holy_AuraOfLight", "=q6=#t9s4_2a#", "=q5="..AL["Tier 9"]};
		{ 17, 48614, "", "=q4=Turalyon's Helm of Triumph", "=ds=#s1#, #a4#"};
		{ 18, 48612, "", "=q4=Turalyon's Shoulderplates of Triumph", "=ds=#s3#, #a4#"};
		{ 19, 48616, "", "=q4=Turalyon's Battleplate of Triumph", "=ds=#s5#, #a4#"};
		{ 20, 48615, "", "=q4=Turalyon's Gauntlets of Triumph", "=ds=#s9#, #a4#"};
		{ 21, 48613, "", "=q4=Turalyon's Legplates of Triumph", "=ds=#s11#, #a4#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9PaladinRetribution_H"] = {
		{ 1, 0, "Spell_Holy_AuraOfLight", "=q6=#t9s4_2h#", "=q5="..AL["Tier 9"]};
		{ 2, 48629, "", "=q4=Liadrin's Helm of Conquest", "=ds=#s1#, #a4#", "50 #eoftriumph#"};
		{ 3, 48627, "", "=q4=Liadrin's Shoulderplates of Conquest", "=ds=#s3#, #a4#", "30 #eoftriumph#"};
		{ 4, 48631, "", "=q4=Liadrin's Battleplate of Conquest", "=ds=#s5#, #a4#", "50 #eoftriumph#"};
		{ 5, 48630, "", "=q4=Liadrin's Gauntlets of Conquest", "=ds=#s9#, #a4#", "30 #eoftriumph#"};
		{ 6, 48628, "", "=q4=Liadrin's Legplates of Conquest", "=ds=#s11#, #a4#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Holy_AuraOfLight", "=q6=#t9s4_2h#", "=q5="..AL["Tier 9"]};
		{ 9, 48624, "", "=q4=Liadrin's Helm of Triumph", "=ds=#s1#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48622, "", "=q4=Liadrin's Shoulderplates of Triumph", "=ds=#s3#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48626, "", "=q4=Liadrin's Battleplate of Triumph", "=ds=#s5#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48625, "", "=q4=Liadrin's Gauntlets of Triumph", "=ds=#s9#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48623, "", "=q4=Liadrin's Legplates of Triumph", "=ds=#s11#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Holy_AuraOfLight", "=q6=#t9s4_2h#", "=q5="..AL["Tier 9"]};
		{ 17, 48619, "", "=q4=Liadrin's Helm of Triumph", "=ds=#s1#, #a4#"};
		{ 18, 48621, "", "=q4=Liadrin's Shoulderplates of Triumph", "=ds=#s3#, #a4#"};
		{ 19, 48617, "", "=q4=Liadrin's Battleplate of Triumph", "=ds=#s5#, #a4#"};
		{ 20, 48618, "", "=q4=Liadrin's Gauntlets of Triumph", "=ds=#s9#, #a4#"};
		{ 21, 48620, "", "=q4=Liadrin's Legplates of Triumph", "=ds=#s11#, #a4#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9PaladinProtection_A"] = {
		{ 1, 0, "Spell_Holy_SealOfMight", "=q6=#t9s4_3a#", "=q5="..AL["Tier 9"]};
		{ 2, 48634, "", "=q4=Turalyon's Faceguard of Conquest", "=ds=#s1#, #a4#", "50 #eoftriumph#"};
		{ 3, 48636, "", "=q4=Turalyon's Shoulderguards of Conquest", "=ds=#s3#, #a4#", "30 #eoftriumph#"};
		{ 4, 48632, "", "=q4=Turalyon's Breastplate of Conquest", "=ds=#s5#, #a4#", "50 #eoftriumph#"};
		{ 5, 48633, "", "=q4=Turalyon's Handguards of Conquest", "=ds=#s9#, #a4#", "30 #eoftriumph#"};
		{ 6, 48635, "", "=q4=Turalyon's Legguards of Conquest", "=ds=#s11#, #a4#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Holy_SealOfMight", "=q6=#t9s4_3a#", "=q5="..AL["Tier 9"]};
		{ 9, 48639, "", "=q4=Turalyon's Faceguard of Triumph", "=ds=#s1#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48637, "", "=q4=Turalyon's Shoulderguards of Triumph", "=ds=#s3#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48641, "", "=q4=Turalyon's Breastplate of Triumph", "=ds=#s5#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48640, "", "=q4=Turalyon's Handguards of Triumph", "=ds=#s9#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48638, "", "=q4=Turalyon's Legguards of Triumph", "=ds=#s11#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Holy_SealOfMight", "=q6=#t9s4_3a#", "=q5="..AL["Tier 9"]};
		{ 17, 48644, "", "=q4=Turalyon's Faceguard of Triumph", "=ds=#s1#, #a4#"};
		{ 18, 48646, "", "=q4=Turalyon's Shoulderguards of Triumph", "=ds=#s3#, #a4#"};
		{ 19, 48642, "", "=q4=Turalyon's Breastplate of Triumph", "=ds=#s5#, #a4#"};
		{ 20, 48643, "", "=q4=Turalyon's Handguards of Triumph", "=ds=#s9#, #a4#"};
		{ 21, 48645, "", "=q4=Turalyon's Legguards of Triumph", "=ds=#s11#, #a4#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9PaladinProtection_H"] = {
		{ 1, 0, "Spell_Holy_SealOfMight", "=q6=#t9s4_3h#", "=q5="..AL["Tier 9"]};
		{ 2, 48654, "", "=q4=Liadrin's Faceguard of Conquest", "=ds=#s1#, #a4#", "50 #eoftriumph#"};
		{ 3, 48656, "", "=q4=Liadrin's Shoulderguards of Conquest", "=ds=#s3#, #a4#", "30 #eoftriumph#"};
		{ 4, 48652, "", "=q4=Liadrin's Breastplate of Conquest", "=ds=#s5#, #a4#", "50 #eoftriumph#"};
		{ 5, 48653, "", "=q4=Liadrin's Handguards of Conquest", "=ds=#s9#, #a4#", "30 #eoftriumph#"};
		{ 6, 48655, "", "=q4=Liadrin's Legguards of Conquest", "=ds=#s11#, #a4#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Holy_SealOfMight", "=q6=#t9s4_3h#", "=q5="..AL["Tier 9"]};
		{ 9, 48659, "", "=q4=Liadrin's Faceguard of Triumph", "=ds=#s1#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48661, "", "=q4=Liadrin's Shoulderguards of Triumph", "=ds=#s3#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48657, "", "=q4=Liadrin's Breastplate of Triumph", "=ds=#s5#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48658, "", "=q4=Liadrin's Handguards of Triumph", "=ds=#s9#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48660, "", "=q4=Liadrin's Legguards of Triumph", "=ds=#s11#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Holy_SealOfMight", "=q6=#t9s4_3h#", "=q5="..AL["Tier 9"]};
		{ 17, 48649, "", "=q4=Liadrin's Faceguard of Triumph", "=ds=#s1#, #a4#"};
		{ 18, 48647, "", "=q4=Liadrin's Shoulderguards of Triumph", "=ds=#s3#, #a4#"};
		{ 19, 48651, "", "=q4=Liadrin's Breastplate of Triumph", "=ds=#s5#, #a4#"};
		{ 20, 48650, "", "=q4=Liadrin's Handguards of Triumph", "=ds=#s9#, #a4#"};
		{ 21, 48648, "", "=q4=Liadrin's Legguards of Triumph", "=ds=#s11#, #a4#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9PriestShadow_A"] = {
		{ 1, 0, "Spell_Shadow_AntiShadow", "=q6=#t9s5_1a#", "=q5="..AL["Tier 9"]};
		{ 2, 48073, "", "=q4=Velen's Circlet of Conquest", "=ds=#s1#, #a1#", "50 #eoftriumph#"};
		{ 3, 48076, "", "=q4=Velen's Mantle of Conquest", "=ds=#s3#, #a1#", "30 #eoftriumph#"};
		{ 4, 48075, "", "=q4=Velen's Raiments of Conquest", "=ds=#s5#, #a1#", "50 #eoftriumph#"};
		{ 5, 48072, "", "=q4=Velen's Handwraps of Conquest", "=ds=#s9#, #a1#", "30 #eoftriumph#"};
		{ 6, 48074, "", "=q4=Velen's Pants of Conquest", "=ds=#s11#, #a1#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Shadow_AntiShadow", "=q6=#t9s5_1a#", "=q5="..AL["Tier 9"]};
		{ 9, 48078, "", "=q4=Velen's Circlet of Triumph", "=ds=#s1#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48081, "", "=q4=Velen's Mantle of Triumph", "=ds=#s3#, #a1#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48080, "", "=q4=Velen's Raiments of Triumph", "=ds=#s5#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48077, "", "=q4=Velen's Handwraps of Triumph", "=ds=#s9#, #a1#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48079, "", "=q4=Velen's Pants of Triumph", "=ds=#s11#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Shadow_AntiShadow", "=q6=#t9s5_1a#", "=q5="..AL["Tier 9"]};
		{ 17, 48085, "", "=q4=Velen's Circlet of Triumph", "=ds=#s1#, #a1#"};
		{ 18, 48082, "", "=q4=Velen's Mantle of Triumph", "=ds=#s3#, #a1#"};
		{ 19, 48083, "", "=q4=Velen's Raiments of Triumph", "=ds=#s5#, #a1#"};
		{ 20, 48086, "", "=q4=Velen's Handwraps of Triumph", "=ds=#s9#, #a1#"};
		{ 21, 48084, "", "=q4=Velen's Pants of Triumph", "=ds=#s11#, #a1#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9PriestShadow_H"] = {
		{ 1, 0, "Spell_Shadow_AntiShadow", "=q6=#t9s5_1h#", "=q5="..AL["Tier 9"]};
		{ 2, 48098, "", "=q4=Zabra's Circlet of Conquest", "=ds=#s1#, #a1#", "50 #eoftriumph#"};
		{ 3, 48101, "", "=q4=Zabra's Mantle of Conquest", "=ds=#s3#, #a1#", "30 #eoftriumph#"};
		{ 4, 48100, "", "=q4=Zabra's Raiments of Conquest", "=ds=#s5#, #a1#", "50 #eoftriumph#"};
		{ 5, 48097, "", "=q4=Zabra's Handwraps of Conquest", "=ds=#s9#, #a1#", "30 #eoftriumph#"};
		{ 6, 48099, "", "=q4=Zabra's Pants of Conquest", "=ds=#s11#, #a1#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Shadow_AntiShadow", "=q6=#t9s5_1h#", "=q5="..AL["Tier 9"]};
		{ 9, 48095, "", "=q4=Zabra's Circlet of Triumph", "=ds=#s1#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48092, "", "=q4=Zabra's Mantle of Triumph", "=ds=#s3#, #a1#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48093, "", "=q4=Zabra's Raiments of Triumph", "=ds=#s5#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48096, "", "=q4=Zabra's Handwraps of Triumph", "=ds=#s9#, #a1#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48094, "", "=q4=Zabra's Pants of Triumph", "=ds=#s11#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Shadow_AntiShadow", "=q6=#t9s5_1h#", "=q5="..AL["Tier 9"]};
		{ 17, 48088, "", "=q4=Zabra's Circlet of Triumph", "=ds=#s1#, #a1#"};
		{ 18, 48091, "", "=q4=Zabra's Mantle of Triumph", "=ds=#s3#, #a1#"};
		{ 19, 48090, "", "=q4=Zabra's Raiments of Triumph", "=ds=#s5#, #a1#"};
		{ 20, 48087, "", "=q4=Zabra's Handwraps of Triumph", "=ds=#s9#, #a1#"};
		{ 21, 48089, "", "=q4=Zabra's Pants of Triumph", "=ds=#s11#, #a1#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9PriestHoly_A"] = {
		{ 1, 0, "Spell_Holy_PowerWordShield", "=q6=#t9s5_2a#", "=q5="..AL["Tier 9"]};
		{ 2, 47914, "", "=q4=Velen's Cowl of Conquest", "=ds=#s1#, #a1#", "50 #eoftriumph#"};
		{ 3, 47981, "", "=q4=Velen's Shoulderpads of Conquest", "=ds=#s3#, #a1#", "30 #eoftriumph#"};
		{ 4, 47936, "", "=q4=Velen's Robe of Conquest", "=ds=#s5#, #a1#", "50 #eoftriumph#"};
		{ 5, 47982, "", "=q4=Velen's Gloves of Conquest", "=ds=#s9#, #a1#", "30 #eoftriumph#"};
		{ 6, 47980, "", "=q4=Velen's Leggings of Conquest", "=ds=#s11#, #a1#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Holy_PowerWordShield", "=q6=#t9s5_2a#", "=q5="..AL["Tier 9"]};
		{ 9, 47984, "", "=q4=Velen's Cowl of Triumph", "=ds=#s1#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 47987, "", "=q4=Velen's Shoulderpads of Triumph", "=ds=#s3#, #a1#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 47986, "", "=q4=Velen's Robe of Triumph", "=ds=#s5#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 47983, "", "=q4=Velen's Gloves of Triumph", "=ds=#s9#, #a1#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 47985, "", "=q4=Velen's Leggings of Triumph", "=ds=#s11#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Holy_PowerWordShield", "=q6=#t9s5_2a#", "=q5="..AL["Tier 9"]};
		{ 17, 48035, "", "=q4=Velen's Cowl of Triumph", "=ds=#s1#, #a1#"};
		{ 18, 48029, "", "=q4=Velen's Shoulderpads of Triumph", "=ds=#s3#, #a1#"};
		{ 19, 48031, "", "=q4=Velen's Robe of Triumph", "=ds=#s5#, #a1#"};
		{ 20, 48037, "", "=q4=Velen's Gloves of Triumph", "=ds=#s9#, #a1#"};
		{ 21, 48033, "", "=q4=Velen's Leggings of Triumph", "=ds=#s11#, #a1#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9PriestHoly_H"] = {
		{ 1, 0, "Spell_Holy_PowerWordShield", "=q6=#t9s5_2h#", "=q5="..AL["Tier 9"]};
		{ 2, 48068, "", "=q4=Zabra's Cowl of Conquest", "=ds=#s1#, #a1#", "50 #eoftriumph#"};
		{ 3, 48071, "", "=q4=Zabra's Shoulderpads of Conquest", "=ds=#s3#, #a1#", "30 #eoftriumph#"};
		{ 4, 48070, "", "=q4=Zabra's Robe of Conquest", "=ds=#s5#, #a1#", "50 #eoftriumph#"};
		{ 5, 48067, "", "=q4=Zabra's Gloves of Conquest", "=ds=#s9#, #a1#", "30 #eoftriumph#"};
		{ 6, 48069, "", "=q4=Zabra's Leggings of Conquest", "=ds=#s11#, #a1#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Holy_PowerWordShield", "=q6=#t9s5_2h#", "=q5="..AL["Tier 9"]};
		{ 9, 48065, "", "=q4=Zabra's Cowl of Triumph", "=ds=#s1#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48062, "", "=q4=Zabra's Shoulderpads of Triumph", "=ds=#s3#, #a1#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48063, "", "=q4=Zabra's Robe of Triumph", "=ds=#s5#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48066, "", "=q4=Zabra's Gloves of Triumph", "=ds=#s9#, #a1#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48064, "", "=q4=Zabra's Leggings of Triumph", "=ds=#s11#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Holy_PowerWordShield", "=q6=#t9s5_2h#", "=q5="..AL["Tier 9"]};
		{ 17, 48058, "", "=q4=Zabra's Cowl of Triumph", "=ds=#s1#, #a1#"};
		{ 18, 48061, "", "=q4=Zabra's Shoulderpads of Triumph", "=ds=#s3#, #a1#"};
		{ 19, 48060, "", "=q4=Zabra's Robe of Triumph", "=ds=#s5#, #a1#"};
		{ 20, 48057, "", "=q4=Zabra's Gloves of Triumph", "=ds=#s9#, #a1#"};
		{ 21, 48059, "", "=q4=Zabra's Leggings of Triumph", "=ds=#s11#, #a1#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9Rogue_A"] = {
		{ 1, 0, "Ability_BackStab", "=q6=#t9s6_a#", "=q5="..AL["Tier 9"]};
		{ 2, 48218, "", "=q4=VanCleef's Helmet of Conquest", "=ds=#s1#, #a2#", "50 #eoftriumph#"};
		{ 3, 48221, "", "=q4=VanCleef's Pauldrons of Conquest", "=ds=#s3#, #a2#", "30 #eoftriumph#"};
		{ 4, 48219, "", "=q4=VanCleef's Breastplate of Conquest", "=ds=#s5#, #a2#", "50 #eoftriumph#"};
		{ 5, 48222, "", "=q4=VanCleef's Gauntlets of Conquest", "=ds=#s9#, #a2#", "30 #eoftriumph#"};
		{ 6, 48220, "", "=q4=VanCleef's Legplates of Conquest", "=ds=#s11#, #a2#", "50 #eoftriumph#"};
		{ 8, 0, "Ability_BackStab", "=q6=#t9s6_a#", "=q5="..AL["Tier 9"]};
		{ 9, 48225, "", "=q4=VanCleef's Helmet of Triumph", "=ds=#s1#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48227, "", "=q4=VanCleef's Pauldrons of Triumph", "=ds=#s3#, #a2#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48223, "", "=q4=VanCleef's Breastplate of Triumph", "=ds=#s5#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48224, "", "=q4=VanCleef's Gauntlets of Triumph", "=ds=#s9#, #a2#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48226, "", "=q4=VanCleef's Legplates of Triumph", "=ds=#s11#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Ability_BackStab", "=q6=#t9s6_a#", "=q5="..AL["Tier 9"]};
		{ 17, 48230, "", "=q4=VanCleef's Helmet of Triumph", "=ds=#s1#, #a2#"};
		{ 18, 48228, "", "=q4=VanCleef's Pauldrons of Triumph", "=ds=#s3#, #a2#"};
		{ 19, 48232, "", "=q4=VanCleef's Breastplate of Triumph", "=ds=#s5#, #a2#"};
		{ 20, 48231, "", "=q4=VanCleef's Gauntlets of Triumph", "=ds=#s9#, #a2#"};
		{ 21, 48229, "", "=q4=VanCleef's Legplates of Triumph", "=ds=#s11#, #a2#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9Rogue_H"] = {
		{ 1, 0, "Ability_BackStab", "=q6=#t9s6_h#", "=q5="..AL["Tier 9"]};
		{ 2, 48245, "", "=q4=Garona's Helmet of Conquest", "=ds=#s1#, #a2#", "50 #eoftriumph#"};
		{ 3, 48247, "", "=q4=Garona's Pauldrons of Conquest", "=ds=#s3#, #a2#", "30 #eoftriumph#"};
		{ 4, 48243, "", "=q4=Garona's Breastplate of Conquest", "=ds=#s5#, #a2#", "50 #eoftriumph#"};
		{ 5, 48244, "", "=q4=Garona's Gauntlets of Conquest", "=ds=#s9#, #a2#", "30 #eoftriumph#"};
		{ 6, 48246, "", "=q4=Garona's Legplates of Conquest", "=ds=#s11#, #a2#", "50 #eoftriumph#"};
		{ 8, 0, "Ability_BackStab", "=q6=#t9s6_h#", "=q5="..AL["Tier 9"]};
		{ 9, 48240, "", "=q4=Garona's Helmet of Triumph", "=ds=#s1#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48238, "", "=q4=Garona's Pauldrons of Triumph", "=ds=#s3#, #a2#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48242, "", "=q4=Garona's Breastplate of Triumph", "=ds=#s5#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48241, "", "=q4=Garona's Gauntlets of Triumph", "=ds=#s9#, #a2#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48239, "", "=q4=Garona's Legplates of Triumph", "=ds=#s11#, #a2#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Ability_BackStab", "=q6=#t9s6_h#", "=q5="..AL["Tier 9"]};
		{ 17, 48235, "", "=q4=Garona's Helmet of Triumph", "=ds=#s1#, #a2#"};
		{ 18, 48237, "", "=q4=Garona's Pauldrons of Triumph", "=ds=#s3#, #a2#"};
		{ 19, 48233, "", "=q4=Garona's Breastplate of Triumph", "=ds=#s5#, #a2#"};
		{ 20, 48234, "", "=q4=Garona's Gauntlets of Triumph", "=ds=#s9#, #a2#"};
		{ 21, 48236, "", "=q4=Garona's Legplates of Triumph", "=ds=#s11#, #a2#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9ShamanElemental_A"] = {
		{ 1, 0, "Spell_Nature_Lightning", "=q6=#t9s7_3a#", "=q5="..AL["Tier 9"]};
		{ 2, 48313, "", "=q4=Nobundo's Helm of Conquest", "=ds=#s1#, #a3#", "50 #eoftriumph#"};
		{ 3, 48315, "", "=q4=Nobundo's Shoulderpads of Conquest", "=ds=#s3#, #a3#", "30 #eoftriumph#"};
		{ 4, 48310, "", "=q4=Nobundo's Hauberk of Conquest", "=ds=#s5#, #a3#", "50 #eoftriumph#"};
		{ 5, 48312, "", "=q4=Nobundo's Gloves of Conquest", "=ds=#s9#, #a3#", "30 #eoftriumph#"};
		{ 6, 48314, "", "=q4=Nobundo's Kilt of Conquest", "=ds=#s11#, #a3#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Nature_Lightning", "=q6=#t9s7_3a#", "=q5="..AL["Tier 9"]};
		{ 9, 48318, "", "=q4=Nobundo's Helm of Triumph", "=ds=#s1#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48320, "", "=q4=Nobundo's Shoulderpads of Triumph", "=ds=#s3#, #a3#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48316, "", "=q4=Nobundo's Hauberk of Triumph", "=ds=#s5#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48317, "", "=q4=Nobundo's Gloves of Triumph", "=ds=#s9#, #a3#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48319, "", "=q4=Nobundo's Kilt of Triumph", "=ds=#s11#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Nature_Lightning", "=q6=#t9s7_3a#", "=q5="..AL["Tier 9"]};
		{ 17, 48323, "", "=q4=Nobundo's Helm of Triumph", "=ds=#s1#, #a3#"};
		{ 18, 48321, "", "=q4=Nobundo's Shoulderpads of Triumph", "=ds=#s3#, #a3#"};
		{ 19, 48325, "", "=q4=Nobundo's Hauberk of Triumph", "=ds=#s5#, #a3#"};
		{ 20, 48324, "", "=q4=Nobundo's Gloves of Triumph", "=ds=#s9#, #a3#"};
		{ 21, 48322, "", "=q4=Nobundo's Kilt of Triumph", "=ds=#s11#, #a3#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9ShamanElemental_H"] = {
		{ 1, 0, "Spell_Nature_Lightning", "=q6=#t9s7_3h#", "=q5="..AL["Tier 9"]};
		{ 2, 48338, "", "=q4=Thrall's Helm of Conquest", "=ds=#s1#, #a3#", "50 #eoftriumph#"};
		{ 3, 48340, "", "=q4=Thrall's Shoulderpads of Conquest", "=ds=#s3#, #a3#", "30 #eoftriumph#"};
		{ 4, 48336, "", "=q4=Thrall's Hauberk of Conquest", "=ds=#s5#, #a3#", "50 #eoftriumph#"};
		{ 5, 48337, "", "=q4=Thrall's Gloves of Conquest", "=ds=#s9#, #a3#", "30 #eoftriumph#"};
		{ 6, 48339, "", "=q4=Thrall's Kilt of Conquest", "=ds=#s11#, #a3#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Nature_Lightning", "=q6=#t9s7_3h#", "=q5="..AL["Tier 9"]};
		{ 9, 48333, "", "=q4=Thrall's Helm of Triumph", "=ds=#s1#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48331, "", "=q4=Thrall's Shoulderpads of Triumph", "=ds=#s3#, #a3#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48335, "", "=q4=Thrall's Hauberk of Triumph", "=ds=#s5#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48334, "", "=q4=Thrall's Gloves of Triumph", "=ds=#s9#, #a3#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48332, "", "=q4=Thrall's Kilt of Triumph", "=ds=#s11#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Nature_Lightning", "=q6=#t9s7_3h#", "=q5="..AL["Tier 9"]};
		{ 17, 48328, "", "=q4=Thrall's Helm of Triumph", "=ds=#s1#, #a3#"};
		{ 18, 48330, "", "=q4=Thrall's Shoulderpads of Triumph", "=ds=#s3#, #a3#"};
		{ 19, 48326, "", "=q4=Thrall's Hauberk of Triumph", "=ds=#s5#, #a3#"};
		{ 20, 48327, "", "=q4=Thrall's Gloves of Triumph", "=ds=#s9#, #a3#"};
		{ 21, 48329, "", "=q4=Thrall's Kilt of Triumph", "=ds=#s11#, #a3#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9ShamanEnhancement_A"] = {
		{ 1, 0, "Spell_FireResistanceTotem_01", "=q6=#t9s7_2a#", "=q5="..AL["Tier 9"]};
		{ 2, 48343, "", "=q4=Nobundo's Faceguard of Conquest", "=ds=#s1#, #a3#", "50 #eoftriumph#"};
		{ 3, 48345, "", "=q4=Nobundo's Shoulderguards of Conquest", "=ds=#s3#, #a3#", "30 #eoftriumph#"};
		{ 4, 48341, "", "=q4=Nobundo's Chestguard of Conquest", "=ds=#s5#, #a3#", "50 #eoftriumph#"};
		{ 5, 48342, "", "=q4=Nobundo's Grips of Conquest", "=ds=#s9#, #a3#", "30 #eoftriumph#"};
		{ 6, 48344, "", "=q4=Nobundo's War-Kilt of Conquest", "=ds=#s11#, #a3#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_FireResistanceTotem_01", "=q6=#t9s7_2a#", "=q5="..AL["Tier 9"]};
		{ 9, 48348, "", "=q4=Nobundo's Faceguard of Triumph", "=ds=#s1#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48350, "", "=q4=Nobundo's Shoulderguards of Triumph", "=ds=#s3#, #a3#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48346, "", "=q4=Nobundo's Chestguard of Triumph", "=ds=#s5#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48347, "", "=q4=Nobundo's Grips of Triumph", "=ds=#s9#, #a3#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48349, "", "=q4=Nobundo's War-Kilt of Triumph", "=ds=#s11#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_FireResistanceTotem_01", "=q6=#t9s7_2a#", "=q5="..AL["Tier 9"]};
		{ 17, 48353, "", "=q4=Nobundo's Faceguard of Triumph", "=ds=#s1#, #a3#"};
		{ 18, 48351, "", "=q4=Nobundo's Shoulderguards of Triumph", "=ds=#s3#, #a3#"};
		{ 19, 48355, "", "=q4=Nobundo's Chestguard of Triumph", "=ds=#s5#, #a3#"};
		{ 20, 48354, "", "=q4=Nobundo's Grips of Triumph", "=ds=#s9#, #a3#"};
		{ 21, 48352, "", "=q4=Nobundo's War-Kilt of Triumph", "=ds=#s11#, #a3#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9ShamanEnhancement_H"] = {
		{ 1, 0, "Spell_FireResistanceTotem_01", "=q6=#t9s7_2h#", "=q5="..AL["Tier 9"]};
		{ 2, 48368, "", "=q4=Thrall's Faceguard of Conquest", "=ds=#s1#, #a3#", "50 #eoftriumph#"};
		{ 3, 48370, "", "=q4=Thrall's Shoulderguards of Conquest", "=ds=#s3#, #a3#", "30 #eoftriumph#"};
		{ 4, 48366, "", "=q4=Thrall's Chestguard of Conquest", "=ds=#s5#, #a3#", "50 #eoftriumph#"};
		{ 5, 48367, "", "=q4=Thrall's Grips of Conquest", "=ds=#s9#, #a3#", "30 #eoftriumph#"};
		{ 6, 48369, "", "=q4=Thrall's War-Kilt of Conquest", "=ds=#s11#, #a3#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_FireResistanceTotem_01", "=q6=#t9s7_2h#", "=q5="..AL["Tier 9"]};
		{ 9, 48363, "", "=q4=Thrall's Faceguard of Triumph", "=ds=#s1#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48361, "", "=q4=Thrall's Shoulderguards of Triumph", "=ds=#s3#, #a3#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48365, "", "=q4=Thrall's Chestguard of Triumph", "=ds=#s5#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48364, "", "=q4=Thrall's Grips of Triumph", "=ds=#s9#, #a3#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48362, "", "=q4=Thrall's War-Kilt of Triumph", "=ds=#s11#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_FireResistanceTotem_01", "=q6=#t9s7_2h#", "=q5="..AL["Tier 9"]};
		{ 17, 48358, "", "=q4=Thrall's Faceguard of Triumph", "=ds=#s1#, #a3#"};
		{ 18, 48360, "", "=q4=Thrall's Shoulderguards of Triumph", "=ds=#s3#, #a3#"};
		{ 19, 48356, "", "=q4=Thrall's Chestguard of Triumph", "=ds=#s5#, #a3#"};
		{ 20, 48357, "", "=q4=Thrall's Grips of Triumph", "=ds=#s9#, #a3#"};
		{ 21, 48359, "", "=q4=Thrall's War-Kilt of Triumph", "=ds=#s11#, #a3#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9ShamanRestoration_A"] = {
		{ 1, 0, "Spell_Nature_HealingWaveGreater", "=q6=#t9s7_1a#", "=q5="..AL["Tier 9"]};
		{ 2, 48280, "", "=q4=Nobundo's Headpiece of Conquest", "=ds=#s1#, #a3#", "50 #eoftriumph#"};
		{ 3, 48283, "", "=q4=Nobundo's Spaulders of Conquest", "=ds=#s3#, #a3#", "30 #eoftriumph#"};
		{ 4, 48281, "", "=q4=Nobundo's Tunic of Conquest", "=ds=#s5#, #a3#", "50 #eoftriumph#"};
		{ 5, 48284, "", "=q4=Nobundo's Handguards of Conquest", "=ds=#s9#, #a3#", "30 #eoftriumph#"};
		{ 6, 48282, "", "=q4=Nobundo's Legguards of Conquest", "=ds=#s11#, #a3#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Nature_HealingWaveGreater", "=q6=#t9s7_1a#", "=q5="..AL["Tier 9"]};
		{ 9, 48287, "", "=q4=Nobundo's Headpiece of Triumph", "=ds=#s1#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48289, "", "=q4=Nobundo's Spaulders of Triumph", "=ds=#s3#, #a3#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48285, "", "=q4=Nobundo's Tunic of Triumph", "=ds=#s5#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48286, "", "=q4=Nobundo's Handguards of Triumph", "=ds=#s9#, #a3#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48288, "", "=q4=Nobundo's Legguards of Triumph", "=ds=#s11#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Nature_HealingWaveGreater", "=q6=#t9s7_1a#", "=q5="..AL["Tier 9"]};
		{ 17, 48292, "", "=q4=Nobundo's Headpiece of Triumph", "=ds=#s1#, #a3#"};
		{ 18, 48290, "", "=q4=Nobundo's Spaulders of Triumph", "=ds=#s3#, #a3#"};
		{ 19, 48294, "", "=q4=Nobundo's Tunic of Triumph", "=ds=#s5#, #a3#"};
		{ 20, 48293, "", "=q4=Nobundo's Handguards of Triumph", "=ds=#s9#, #a3#"};
		{ 21, 48291, "", "=q4=Nobundo's Legguards of Triumph", "=ds=#s11#, #a3#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9ShamanRestoration_H"] = {
		{ 1, 0, "Spell_Nature_HealingWaveGreater", "=q6=#t9s7_1h#", "=q5="..AL["Tier 9"]};
		{ 2, 48297, "", "=q4=Thrall's Headpiece of Conquest", "=ds=#s1#, #a3#", "50 #eoftriumph#"};
		{ 3, 48299, "", "=q4=Thrall's Spaulders of Conquest", "=ds=#s3#, #a3#", "30 #eoftriumph#"};
		{ 4, 48295, "", "=q4=Thrall's Tunic of Conquest", "=ds=#s5#, #a3#", "50 #eoftriumph#"};
		{ 5, 48296, "", "=q4=Thrall's Handguards of Conquest", "=ds=#s9#, #a3#", "30 #eoftriumph#"};
		{ 6, 48298, "", "=q4=Thrall's Legguards of Conquest", "=ds=#s11#, #a3#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Nature_HealingWaveGreater", "=q6=#t9s7_1h#", "=q5="..AL["Tier 9"]};
		{ 9, 48302, "", "=q4=Thrall's Headpiece of Triumph", "=ds=#s1#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48304, "", "=q4=Thrall's Spaulders of Triumph", "=ds=#s3#, #a3#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48300, "", "=q4=Thrall's Tunic of Triumph", "=ds=#s5#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48301, "", "=q4=Thrall's Handguards of Triumph", "=ds=#s9#, #a3#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48303, "", "=q4=Thrall's Legguards of Triumph", "=ds=#s11#, #a3#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Nature_HealingWaveGreater", "=q6=#t9s7_1h#", "=q5="..AL["Tier 9"]};
		{ 17, 48307, "", "=q4=Thrall's Headpiece of Triumph", "=ds=#s1#, #a3#"};
		{ 18, 48309, "", "=q4=Thrall's Spaulders of Triumph", "=ds=#s3#, #a3#"};
		{ 19, 48305, "", "=q4=Thrall's Tunic of Triumph", "=ds=#s5#, #a3#"};
		{ 20, 48306, "", "=q4=Thrall's Handguards of Triumph", "=ds=#s9#, #a3#"};
		{ 21, 48308, "", "=q4=Thrall's Legguards of Triumph", "=ds=#s11#, #a3#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9Warlock_A"] = {
		{ 1, 0, "Spell_Shadow_CurseOfTounges", "=q6=#t9s8_a#", "=q5="..AL["Tier 9"]};
		{ 2, 47784, "", "=q4=Kel'Thuzad's Hood of Conquest", "=ds=#s1#, #a1#", "50 #eoftriumph#"};
		{ 3, 47787, "", "=q4=Kel'Thuzad's Shoulderpads of Conquest", "=ds=#s3#, #a1#", "30 #eoftriumph#"};
		{ 4, 47786, "", "=q4=Kel'Thuzad's Robe of Conquest", "=ds=#s5#, #a1#", "50 #eoftriumph#"};
		{ 5, 47783, "", "=q4=Kel'Thuzad's Gloves of Conquest", "=ds=#s9#, #a1#", "30 #eoftriumph#"};
		{ 6, 47785, "", "=q4=Kel'Thuzad's Leggings of Conquest", "=ds=#s11#, #a1#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Shadow_CurseOfTounges", "=q6=#t9s8_a#", "=q5="..AL["Tier 9"]};
		{ 9, 47778, "", "=q4=Kel'Thuzad's Hood of Triumph", "=ds=#s1#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 47781, "", "=q4=Kel'Thuzad's Shoulderpads of Triumph", "=ds=#s3#, #a1#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 47779, "", "=q4=Kel'Thuzad's Robe of Triumph", "=ds=#s5#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 47782, "", "=q4=Kel'Thuzad's Gloves of Triumph", "=ds=#s9#, #a1#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 47780, "", "=q4=Kel'Thuzad's Leggings of Triumph", "=ds=#s11#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Shadow_CurseOfTounges", "=q6=#t9s8_a#", "=q5="..AL["Tier 9"]};
		{ 17, 47789, "", "=q4=Kel'Thuzad's Hood of Triumph", "=ds=#s1#, #a1#"};
		{ 18, 47792, "", "=q4=Kel'Thuzad's Shoulderpads of Triumph", "=ds=#s3#, #a1#"};
		{ 19, 47791, "", "=q4=Kel'Thuzad's Robe of Triumph", "=ds=#s5#, #a1#"};
		{ 20, 47788, "", "=q4=Kel'Thuzad's Gloves of Triumph", "=ds=#s9#, #a1#"};
		{ 21, 47790, "", "=q4=Kel'Thuzad's Leggings of Triumph", "=ds=#s11#, #a1#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9Warlock_H"] = {
		{ 1, 0, "Spell_Shadow_CurseOfTounges", "=q6=#t9s8_h#", "=q5="..AL["Tier 9"]};
		{ 2, 47801, "", "=q4=Gul'dan's Hood of Conquest", "=ds=#s1#, #a1#", "50 #eoftriumph#"};
		{ 3, 47798, "", "=q4=Gul'dan's Shoulderpads of Conquest", "=ds=#s3#, #a1#", "30 #eoftriumph#"};
		{ 4, 47799, "", "=q4=Gul'dan's Robe of Conquest", "=ds=#s5#, #a1#", "50 #eoftriumph#"};
		{ 5, 47802, "", "=q4=Gul'dan's Gloves of Conquest", "=ds=#s9#, #a1#", "30 #eoftriumph#"};
		{ 6, 47800, "", "=q4=Gul'dan's Leggings of Conquest", "=ds=#s11#, #a1#", "50 #eoftriumph#"};
		{ 8, 0, "Spell_Shadow_CurseOfTounges", "=q6=#t9s8_h#", "=q5="..AL["Tier 9"]};
		{ 9, 47804, "", "=q4=Gul'dan's Hood of Triumph", "=ds=#s1#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 47807, "", "=q4=Gul'dan's Shoulderpads of Triumph", "=ds=#s3#, #a1#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 47806, "", "=q4=Gul'dan's Robe of Triumph", "=ds=#s5#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 47803, "", "=q4=Gul'dan's Gloves of Triumph", "=ds=#s9#, #a1#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 47805, "", "=q4=Gul'dan's Leggings of Triumph", "=ds=#s11#, #a1#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Spell_Shadow_CurseOfTounges", "=q6=#t9s8_h#", "=q5="..AL["Tier 9"]};
		{ 17, 47796, "", "=q4=Gul'dan's Hood of Triumph", "=ds=#s1#, #a1#"};
		{ 18, 47793, "", "=q4=Gul'dan's Shoulderpads of Triumph", "=ds=#s3#, #a1#"};
		{ 19, 47794, "", "=q4=Gul'dan's Robe of Triumph", "=ds=#s5#, #a1#"};
		{ 20, 47797, "", "=q4=Gul'dan's Gloves of Triumph", "=ds=#s9#, #a1#"};
		{ 21, 47795, "", "=q4=Gul'dan's Leggings of Triumph", "=ds=#s11#, #a1#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9WarriorFury_A"] = {
		{ 1, 0, "Ability_Warrior_BattleShout", "=q6=#t9s9_1a#", "=q5="..AL["Tier 9"]};
		{ 2, 48371, "", "=q4=Wrynn's Helmet of Conquest", "=ds=#s1#, #a4#", "50 #eoftriumph#"};
		{ 3, 48374, "", "=q4=Wrynn's Shoulderplates of Conquest", "=ds=#s3#, #a4#", "30 #eoftriumph#"};
		{ 4, 48372, "", "=q4=Wrynn's Battleplate of Conquest", "=ds=#s5#, #a4#", "50 #eoftriumph#"};
		{ 5, 48375, "", "=q4=Wrynn's Gauntlets of Conquest", "=ds=#s9#, #a4#", "30 #eoftriumph#"};
		{ 6, 48373, "", "=q4=Wrynn's Legplates of Conquest", "=ds=#s11#, #a4#", "50 #eoftriumph#"};
		{ 8, 0, "Ability_Warrior_BattleShout", "=q6=#t9s9_1a#", "=q5="..AL["Tier 9"]};
		{ 9, 48378, "", "=q4=Wrynn's Helmet of Triumph", "=ds=#s1#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48380, "", "=q4=Wrynn's Shoulderplates of Triumph", "=ds=#s3#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48376, "", "=q4=Wrynn's Battleplate of Triumph", "=ds=#s5#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48377, "", "=q4=Wrynn's Gauntlets of Triumph", "=ds=#s9#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48379, "", "=q4=Wrynn's Legplates of Triumph", "=ds=#s11#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Ability_Warrior_BattleShout", "=q6=#t9s9_1a#", "=q5="..AL["Tier 9"]};
		{ 17, 48383, "", "=q4=Wrynn's Helmet of Triumph", "=ds=#s1#, #a4#"};
		{ 18, 48381, "", "=q4=Wrynn's Shoulderplates of Triumph", "=ds=#s3#, #a4#"};
		{ 19, 48385, "", "=q4=Wrynn's Battleplate of Triumph", "=ds=#s5#, #a4#"};
		{ 20, 48384, "", "=q4=Wrynn's Gauntlets of Triumph", "=ds=#s9#, #a4#"};
		{ 21, 48382, "", "=q4=Wrynn's Legplates of Triumph", "=ds=#s11#, #a4#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9WarriorFury_H"] = {
		{ 1, 0, "Ability_Warrior_BattleShout", "=q6=#t9s9_1h#", "=q5="..AL["Tier 9"]};
		{ 2, 48388, "", "=q4=Hellscream's Helmet of Conquest", "=ds=#s1#, #a4#", "50 #eoftriumph#"};
		{ 3, 48390, "", "=q4=Hellscream's Shoulderplates of Conquest", "=ds=#s3#, #a4#", "30 #eoftriumph#"};
		{ 4, 48386, "", "=q4=Hellscream's Battleplate of Conquest", "=ds=#s5#, #a4#", "50 #eoftriumph#"};
		{ 5, 48387, "", "=q4=Hellscream's Gauntlets of Conquest", "=ds=#s9#, #a4#", "30 #eoftriumph#"};
		{ 6, 48389, "", "=q4=Hellscream's Legplates of Conquest", "=ds=#s11#, #a4#", "50 #eoftriumph#"};
		{ 8, 0, "Ability_Warrior_BattleShout", "=q6=#t9s9_1h#", "=q5="..AL["Tier 9"]};
		{ 9, 48393, "", "=q4=Hellscream's Helmet of Triumph", "=ds=#s1#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48395, "", "=q4=Hellscream's Shoulderplates of Triumph", "=ds=#s3#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48391, "", "=q4=Hellscream's Battleplate of Triumph", "=ds=#s5#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48392, "", "=q4=Hellscream's Gauntlets of Triumph", "=ds=#s9#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48394, "", "=q4=Hellscream's Legplates of Triumph", "=ds=#s11#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "Ability_Warrior_BattleShout", "=q6=#t9s9_1h#", "=q5="..AL["Tier 9"]};
		{ 17, 48398, "", "=q4=Hellscream's Helmet of Triumph", "=ds=#s1#, #a4#"};
		{ 18, 48400, "", "=q4=Hellscream's Shoulderplates of Triumph", "=ds=#s3#, #a4#"};
		{ 19, 48396, "", "=q4=Hellscream's Battleplate of Triumph", "=ds=#s5#, #a4#"};
		{ 20, 48397, "", "=q4=Hellscream's Gauntlets of Triumph", "=ds=#s9#, #a4#"};
		{ 21, 48399, "", "=q4=Hellscream's Legplates of Triumph", "=ds=#s11#, #a4#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9WarriorProtection_A"] = {
		{ 1, 0, "INV_Shield_05", "=q6=#t9s9_2a#", "=q5="..AL["Tier 9"]};
		{ 2, 48429, "", "=q4=Wrynn's Greathelm of Conquest", "=ds=#s1#, #a4#", "50 #eoftriumph#"};
		{ 3, 48448, "", "=q4=Wrynn's Pauldrons of Conquest", "=ds=#s3#, #a4#", "30 #eoftriumph#"};
		{ 4, 48436, "", "=q4=Wrynn's Breastplate of Conquest", "=ds=#s5#, #a4#", "50 #eoftriumph#"};
		{ 5, 48449, "", "=q4=Wrynn's Handguards of Conquest", "=ds=#s9#, #a4#", "30 #eoftriumph#"};
		{ 6, 48445, "", "=q4=Wrynn's Legguards of Conquest", "=ds=#s11#, #a4#", "50 #eoftriumph#"};
		{ 8, 0, "INV_Shield_05", "=q6=#t9s9_2a#", "=q5="..AL["Tier 9"]};
		{ 9, 48430, "", "=q4=Wrynn's Greathelm of Triumph", "=ds=#s1#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48454, "", "=q4=Wrynn's Pauldrons of Triumph", "=ds=#s3#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48450, "", "=q4=Wrynn's Breastplate of Triumph", "=ds=#s5#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48452, "", "=q4=Wrynn's Handguards of Triumph", "=ds=#s9#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48446, "", "=q4=Wrynn's Legguards of Triumph", "=ds=#s11#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "INV_Shield_05", "=q6=#t9s9_2a#", "=q5="..AL["Tier 9"]};
		{ 17, 48433, "", "=q4=Wrynn's Greathelm of Triumph", "=ds=#s1#, #a4#"};
		{ 18, 48455, "", "=q4=Wrynn's Pauldrons of Triumph", "=ds=#s3#, #a4#"};
		{ 19, 48451, "", "=q4=Wrynn's Breastplate of Triumph", "=ds=#s5#, #a4#"};
		{ 20, 48453, "", "=q4=Wrynn's Handguards of Triumph", "=ds=#s9#, #a4#"};
		{ 21, 48447, "", "=q4=Wrynn's Legguards of Triumph", "=ds=#s11#, #a4#"};
		Back = "T9SET";
	};

	AtlasLoot_Data["T9WarriorProtection_H"] = {
		{ 1, 0, "INV_Shield_05", "=q6=#t9s9_2h#", "=q5="..AL["Tier 9"]};
		{ 2, 48458, "", "=q4=Hellscream's Greathelm of Conquest", "=ds=#s1#, #a4#", "50 #eoftriumph#"};
		{ 3, 48460, "", "=q4=Hellscream's Pauldrons of Conquest", "=ds=#s3#, #a4#", "30 #eoftriumph#"};
		{ 4, 48456, "", "=q4=Hellscream's Breastplate of Conquest", "=ds=#s5#, #a4#", "50 #eoftriumph#"};
		{ 5, 48457, "", "=q4=Hellscream's Handguards of Conquest", "=ds=#s9#, #a4#", "30 #eoftriumph#"};
		{ 6, 48459, "", "=q4=Hellscream's Legguards of Conquest", "=ds=#s11#, #a4#", "50 #eoftriumph#"};
		{ 8, 0, "INV_Shield_05", "=q6=#t9s9_2h#", "=q5="..AL["Tier 9"]};
		{ 9, 48463, "", "=q4=Hellscream's Greathelm of Triumph", "=ds=#s1#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 10, 48465, "", "=q4=Hellscream's Pauldrons of Triumph", "=ds=#s3#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 11, 48461, "", "=q4=Hellscream's Breastplate of Triumph", "=ds=#s5#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 12, 48462, "", "=q4=Hellscream's Handguards of Triumph", "=ds=#s9#, #a4#", "45 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 13, 48464, "", "=q4=Hellscream's Legguards of Triumph", "=ds=#s11#, #a4#", "75 #eoftriumph# 1 #trophyofthecrusade#"};
		{ 16, 0, "INV_Shield_05", "=q6=#t9s9_2h#", "=q5="..AL["Tier 9"]};
		{ 17, 48468, "", "=q4=Hellscream's Greathelm of Triumph", "=ds=#s1#, #a4#"};
		{ 18, 48470, "", "=q4=Hellscream's Pauldrons of Triumph", "=ds=#s3#, #a4#"};
		{ 19, 48466, "", "=q4=Hellscream's Breastplate of Triumph", "=ds=#s5#, #a4#"};
		{ 20, 48467, "", "=q4=Hellscream's Handguards of Triumph", "=ds=#s9#, #a4#"};
		{ 21, 48469, "", "=q4=Hellscream's Legguards of Triumph", "=ds=#s11#, #a4#"};
		Back = "T9SET";
	};

		--------------------------
		--- Tier 10 Sets (T10) ---
		--------------------------

	AtlasLoot_Data["T10DeathKnightDPS"] = {
		{ 1, 0, "Spell_Deathknight_DeathStrike", "=q6=#t10s10_1#", "=q5="..AL["Tier 10"]};
		{ 2, 50096, "", "=q4=Scourgelord Helmet", "=ds=#s1#, #a4#", "95 #eoffrost#" };
		{ 3, 50098, "", "=q4=Scourgelord Shoulderplates", "=ds=#s3#, #a4#", "60 #eoffrost#" };
		{ 4, 50094, "", "=q4=Scourgelord Battleplate", "=ds=#s5#, #a4#", "95 #eoffrost#" };
		{ 5, 50095, "", "=q4=Scourgelord Gauntlets", "=ds=#s9#, #a4#", "60 #eoffrost#" };
		{ 6, 50097, "", "=q4=Scourgelord Legplates", "=ds=#s11#, #a4#", "95 #eoffrost#" };
		{ 8, 0, "Spell_Deathknight_DeathStrike", "=q6=#t10s10_1#", "=q5="..AL["Tier 10"]};
		{ 9, 51127, "", "=q4=Sanctified Scourgelord Helmet", "=ds=#s1#, #a4#"};
		{ 10, 51125, "", "=q4=Sanctified Scourgelord Shoulderplates", "=ds=#s3#, #a4#"};
		{ 11, 51129, "", "=q4=Sanctified Scourgelord Battleplate", "=ds=#s5#, #a4#"};
		{ 12, 51128, "", "=q4=Sanctified Scourgelord Gauntlets", "=ds=#s9#, #a4#"};
		{ 13, 51126, "", "=q4=Sanctified Scourgelord Legplates", "=ds=#s11#, #a4#"};
		{ 16, 0, "Spell_Deathknight_DeathStrike", "=q6=#t10s10_1#", "=q5="..AL["Tier 10"]};
		{ 17, 51312, "", "=q4=Sanctified Scourgelord Helmet", "=ds="};
		{ 18, 51314, "", "=q4=Sanctified Scourgelord Shoulderplates", "=ds="};
		{ 19, 51310, "", "=q4=Sanctified Scourgelord Battleplate", "=ds="};
		{ 20, 51311, "", "=q4=Sanctified Scourgelord Gauntlets", "=ds="};
		{ 21, 51313, "", "=q4=Sanctified Scourgelord Legplates", "=ds="};
		Back = "T10SET";
	};

	AtlasLoot_Data["T10DeathKnightTank"] = {
		{ 1, 0, "Spell_Deathknight_DeathStrike", "=q6=#t10s10_2#", "=q5="..AL["Tier 10"]};
		{ 2, 50855, "", "=q4=Scourgelord Faceguard", "=ds=#s1#, #a4#", "95 #eoffrost#" };
		{ 3, 50853, "", "=q4=Scourgelord Pauldrons", "=ds=#s3#, #a4#", "60 #eoffrost#" };
		{ 4, 50857, "", "=q4=Scourgelord Chestguard", "=ds=#s5#, #a4#", "95 #eoffrost#" };
		{ 5, 50856, "", "=q4=Scourgelord Handguards", "=ds=#s9#, #a4#", "60 #eoffrost#" };
		{ 6, 50854, "", "=q4=Scourgelord Legguards", "=ds=#s11#, #a4#", "95 #eoffrost#" };
		{ 8, 0, "Spell_Deathknight_DeathStrike", "=q6=#t10s10_2#", "=q5="..AL["Tier 10"]};
		{ 9, 51133, "", "=q4=Sanctified Scourgelord Faceguard", "=ds=#s1#, #a4#"};
		{ 10, 51130, "", "=q4=Sanctified Scourgelord Pauldrons", "=ds=#s3#, #a4#"};
		{ 11, 51134, "", "=q4=Sanctified Scourgelord Chestguard", "=ds=#s5#, #a4#"};
		{ 12, 51132, "", "=q4=Sanctified Scourgelord Handguards", "=ds=#s9#, #a4#"};
		{ 13, 51131, "", "=q4=Sanctified Scourgelord Legguards", "=ds=#s11#, #a4#"};
		{ 16, 0, "Spell_Deathknight_DeathStrike", "=q6=#t10s10_2#", "=q5="..AL["Tier 10"]};
		{ 17, 51306, "", "=q4=Sanctified Scourgelord Faceguard", "=ds="};
		{ 18, 51309, "", "=q4=Sanctified Scourgelord Pauldrons", "=ds="};
		{ 19, 51305, "", "=q4=Sanctified Scourgelord Chestguard", "=ds="};
		{ 20, 51307, "", "=q4=Sanctified Scourgelord Handguards", "=ds="};
		{ 21, 51308, "", "=q4=Sanctified Scourgelord Legguards", "=ds="};
		Back = "T10SET";
	};

	AtlasLoot_Data["T10DruidRestoration"] = {
		{ 1, 0, "Spell_Nature_Regeneration", "=q6=#t10s1_1#", "=q5="..AL["Tier 10"]};
		{ 2, 50108, "", "=q4=Lasherweave's Helmet  ", "=ds=#s1#, #a2#", "95 #eoffrost#" };
		{ 3, 50113, "", "=q4=Lasherweave's Pauldrons", "=ds=#s3#, #a2#", "60 #eoffrost#" };
		{ 4, 50106, "", "=q4=Lasherweave's Robes", "=ds=#s5#, #a2#", "95 #eoffrost#" };
		{ 5, 50107, "", "=q4=Lasherweave's Gauntlets", "=ds=#s9#, #a2#", "60 #eoffrost#" };
		{ 6, 50109, "", "=q4=Lasherweave's Legplates", "=ds=#s11#, #a2#", "95 #eoffrost#" };
		{ 8, 0, "Spell_Nature_Regeneration", "=q6=#t10s1_1#", "=q5="..AL["Tier 10"]};
		{ 9, 51137, "", "=q4=Sanctified Lasherweave's Helmet", "=ds=#s1#, #a2#" };
		{ 10, 51135, "", "=q4=Sanctified Lasherweave's Pauldrons", "=ds=#s3#, #a2#" };
		{ 11, 51139, "", "=q4=Sanctified Lasherweave's Robes", "=ds=#s5#, #a2#" };
		{ 12, 51138, "", "=q4=Sanctified Lasherweave's Gauntlets", "=ds=#s9#, #a2#" };
		{ 13, 51136, "", "=q4=Sanctified Lasherweave's Legplates", "=ds=#s11#, #a2#" };
		{ 16, 0, "Spell_Nature_Regeneration", "=q6=#t10s1_1#", "=q5="..AL["Tier 10"]};
		{ 17, 51302, "", "=q4=Sanctified Lasherweave's Helmet", "=ds="};
		{ 18, 51304, "", "=q4=Sanctified Lasherweave's Pauldrons", "=ds="};
		{ 19, 51300, "", "=q4=Sanctified Lasherweave's Robes", "=ds="};
		{ 20, 51301, "", "=q4=Sanctified Lasherweave's Gauntlets", "=ds="};
		{ 21, 51303, "", "=q4=Sanctified Lasherweave's Legplates", "=ds="};
		Back = "T10SET";
	};

	AtlasLoot_Data["T10DruidFeral"] = {
		{ 1, 0, "Ability_Druid_Maul", "=q6=#t10s1_2#", "=q5="..AL["Tier 10"]};
		{ 2, 50826, "", "=q4=Lasherweave's Headguard", "=ds=#s1#, #a2#", "95 #eoffrost#" };
		{ 3, 50824, "", "=q4=Lasherweave's Shoulderpads", "=ds=#s3#, #a2#", "60 #eoffrost#" };
		{ 4, 50828, "", "=q4=Lasherweave's Raiment", "=ds=#s5#, #a2#", "95 #eoffrost#" };
		{ 5, 50827, "", "=q4=Lasherweave's Handgrips", "=ds=#s9#, #a2#", "60 #eoffrost#" };
		{ 6, 50825, "", "=q4=Lasherweave's Legguards", "=ds=#s11#, #a2#", "95 #eoffrost#" };
		{ 8, 0, "Ability_Druid_Maul", "=q6=#t10s1_2#", "=q5="..AL["Tier 10"]};
		{ 9, 51143, "", "=q4=Sanctified Lasherweave's Headguard", "=ds=#s1#, #a2#" };
		{ 10, 51140, "", "=q4=Sanctified Lasherweave's Shoulderpads", "=ds=#s3#, #a2#" };
		{ 11, 51141, "", "=q4=Sanctified Lasherweave's Raiment", "=ds=#s5#, #a2#" };
		{ 12, 51144, "", "=q4=Sanctified Lasherweave's Handgrips", "=ds=#s9#, #a2#" };
		{ 13, 51142, "", "=q4=Sanctified Lasherweave's Legguards", "=ds=#s11#, #a2#" };
		{ 16, 0, "Ability_Druid_Maul", "=q6=#t10s1_2#", "=q5="..AL["Tier 10"]};
		{ 17, 51296, "", "=q4=Sanctified Lasherweave's Headguard", "=ds="};
		{ 18, 51299, "", "=q4=Sanctified Lasherweave's Shoulderpads", "=ds="};
		{ 19, 51298, "", "=q4=Sanctified Lasherweave's Raiment", "=ds="};
		{ 20, 51295, "", "=q4=Sanctified Lasherweave's Handgrips", "=ds="};
		{ 21, 51297, "", "=q4=Sanctified Lasherweave's Legguards", "=ds="};
		Back = "T10SET";
	};

	AtlasLoot_Data["T10DruidBalance"] = {
		{ 1, 0, "Spell_Nature_InsectSwarm", "=q6=#t10s1_3#", "=q5="..AL["Tier 10"]};
		{ 2, 50821, "", "=q4=Lasherweave's Cover", "=ds=#s1#, #a2#", "95 #eoffrost#" };
		{ 3, 50819, "", "=q4=Lasherweave's Mantle", "=ds=#s3#, #a2#", "60 #eoffrost#" };
		{ 4, 50823, "", "=q4=Lasherweave's Vestment", "=ds=#s5#, #a2#", "95 #eoffrost#" };
		{ 5, 50822, "", "=q4=Lasherweave's Gloves", "=ds=#s9#, #a2#", "60 #eoffrost#" };
		{ 6, 50820, "", "=q4=Lasherweave's Trousers", "=ds=#s11#, #a2#", "95 #eoffrost#" };
		{ 8, 0, "Spell_Nature_InsectSwarm", "=q6=#t10s1_3#", "=q5="..AL["Tier 10"]};
		{ 9, 51149, "", "=q4=Sanctified Lasherweave's Cover", "=ds=#s1#, #a2#" };
		{ 10, 51147, "", "=q4=Sanctified Lasherweave's Mantle", "=ds=#s3#, #a2#" };
		{ 11, 51145, "", "=q4=Sanctified Lasherweave's Vestment", "=ds=#s5#, #a2#" };
		{ 12, 51148, "", "=q4=Sanctified Lasherweave's Gloves", "=ds=#s9#, #a2#" };
		{ 13, 51146, "", "=q4=Sanctified Lasherweave's Trousers", "=ds=#s11#, #a2#" };
		{ 16, 0, "Spell_Nature_InsectSwarm", "=q6=#t10s1_3#", "=q5="..AL["Tier 10"]};
		{ 17, 51290, "", "=q4=Sanctified Lasherweave's Cover", "=ds="};
		{ 18, 51292, "", "=q4=Sanctified Lasherweave's Mantle", "=ds="};
		{ 19, 51294, "", "=q4=Sanctified Lasherweave's Vestment", "=ds="};
		{ 20, 51291, "", "=q4=Sanctified Lasherweave's Gloves", "=ds="};
		{ 21, 51293, "", "=q4=Sanctified Lasherweave's Trousers", "=ds="};
		Back = "T10SET";
	};

	AtlasLoot_Data["T10Hunter"] = {
		{ 1, 0, "Ability_Hunter_RunningShot", "=q6=#t10s2#", "=q5="..AL["Tier 10"]};
		{ 2, 50115, "", "=q4=Ahn'Kahar Blood Hunter's Headpiece", "=ds=#s1#, #a3#", "95 #eoffrost#" };
		{ 3, 50117, "", "=q4=Ahn'Kahar Blood Hunter's Spaulders", "=ds=#s3#, #a3#", "60 #eoffrost#" };
		{ 4, 50118, "", "=q4=Ahn'Kahar Blood Hunter's Tunic", "=ds=#s5#, #a3#", "95 #eoffrost#" };
		{ 5, 50114, "", "=q4=Ahn'Kahar Blood Hunter's Handguards", "=ds=#s9#, #a3#", "60 #eoffrost#" };
		{ 6, 50116, "", "=q4=Ahn'Kahar Blood Hunter's Legguards", "=ds=#s11#, #a3#", "95 #eoffrost#" };
		{ 8, 0, "Ability_Hunter_RunningShot", "=q6=#t10s2#", "=q5="..AL["Tier 10"]};
		{ 9, 51153, "", "=q4=Sanctified Ahn'Kahar Blood Hunter's Headpiece", "=ds=#s1#, #a3#"};
		{ 10, 51151, "", "=q4=Sanctified Ahn'Kahar Blood Hunter's Spaulders", "=ds=#s3#, #a3#"};
		{ 11, 51150, "", "=q4=Sanctified Ahn'Kahar Blood Hunter's Tunic", "=ds=#s5#, #a3#"};
		{ 12, 51154, "", "=q4=Sanctified Ahn'Kahar Blood Hunter's Handguards", "=ds=#s9#, #a3#"};
		{ 13, 51152, "", "=q4=Sanctified Ahn'Kahar Blood Hunter's Legguards", "=ds=#s11#, #a3#"};
		{ 16, 0, "Ability_Hunter_RunningShot", "=q6=#t10s2#", "=q5="..AL["Tier 10"]};
		{ 17, 51286, "", "=q4=Sanctified Ahn'Kahar Blood Hunter's Headpiece", "=ds=#s1#, #a3#"};
		{ 18, 51288, "", "=q4=Sanctified Ahn'Kahar Blood Hunter's Spaulders", "=ds=#s3#, #a3#"};
		{ 19, 51289, "", "=q4=Sanctified Ahn'Kahar Blood Hunter's Tunic", "=ds=#s5#, #a3#"};
		{ 20, 51285, "", "=q4=Sanctified Ahn'Kahar Blood Hunter's Handguards", "=ds=#s9#, #a3#"};
		{ 21, 51287, "", "=q4=Sanctified Ahn'Kahar Blood Hunter's Legguards", "=ds=#s11#, #a3#"};
		Back = "T10SET";
	};

	AtlasLoot_Data["T10Mage"] = {
		{ 1, 0, "Spell_Frost_IceStorm", "=q6=#t10s3#", "=q5="..AL["Tier 10"]};
		{ 2, 50276, "", "=q4=Bloodmage Hood", "=ds=#s1#, #a1#", "95 #eoffrost#" };
		{ 3, 50279, "", "=q4=Bloodmage Shoulderpads", "=ds=#s3#, #a1#", "60 #eoffrost#" };
		{ 4, 50278, "", "=q4=Bloodmage Robe", "=ds=#s5#, #a1#", "95 #eoffrost#" };
		{ 5, 50275, "", "=q4=Bloodmage Gloves", "=ds=#s9#, #a1#", "60 #eoffrost#" };
		{ 6, 50277, "", "=q4=Bloodmage Leggings", "=ds=#s11#, #a1#", "95 #eoffrost#" };
		{ 8, 0, "Spell_Frost_IceStorm", "=q6=#t10s3#", "=q5="..AL["Tier 10"]};
		{ 9, 51158, "", "=q4=Sanctified Bloodmage Hood", "=ds=#s1#, #a1#"};
		{ 10, 51155, "", "=q4=Sanctified Bloodmage Shoulderpads", "=ds=#s3#, #a1#"};
		{ 11, 51156, "", "=q4=Sanctified Bloodmage Robe", "=ds=#s5#, #a1#"};
		{ 12, 51159, "", "=q4=Sanctified Bloodmage Gloves", "=ds=#s9#, #a1#"};
		{ 13, 51157, "", "=q4=Sanctified Bloodmage Leggings", "=ds=#s11#, #a1#"};
		{ 16, 0, "Spell_Frost_IceStorm", "=q6=#t10s3#", "=q5="..AL["Tier 10"]};
		{ 17, 51281, "", "=q4=Sanctified Bloodmage Hood", "=ds=#s1#, #a1#"};
		{ 18, 51284, "", "=q4=Sanctified Bloodmage Shoulderpads", "=ds=#s3#, #a1#"};
		{ 19, 51283, "", "=q4=Sanctified Bloodmage Robe", "=ds=#s5#, #a1#"};
		{ 20, 51280, "", "=q4=Sanctified Bloodmage Gauntlets", "=ds=#s9#, #a1#"};
		{ 21, 51282, "", "=q4=Sanctified Bloodmage Leggings", "=ds=#s11#, #a1#"};
		Back = "T10SET";
	};

	AtlasLoot_Data["T10PaladinHoly"] = {
		{ 1, 0, "Spell_Holy_HolyBolt", "=q6=#t10s4_1#", "=q5="..AL["Tier 10"]};
		{ 2, 50867, "", "=q4=Lightsworn Headpiece", "=ds=#s1#, #a4#", "95 #eoffrost#" };
		{ 3, 50865, "", "=q4=Lightsworn Spaulders", "=ds=#s3#, #a4#", "60 #eoffrost#" };
		{ 4, 50869, "", "=q4=Lightsworn Tunic", "=ds=#s5#, #a4#", "95 #eoffrost#" };
		{ 5, 50868, "", "=q4=Lightsworn Gloves", "=ds=#s9#, #a4#", "60 #eoffrost#" };
		{ 6, 50866, "", "=q4=Lightsworn Greaves", "=ds=#s11#, #a4#", "95 #eoffrost#" };
		{ 8, 0, "Spell_Holy_HolyBolt", "=q6=#t10s4_1#", "=q5="..AL["Tier 10"]};
		{ 9, 51167, "", "=q4=Sanctified Lightsworn Headpiece", "=ds=#s1#, #a4#" };
		{ 10, 51166, "", "=q4=Sanctified Lightsworn Spaulders", "=ds=#s3#, #a4#" };
		{ 11, 51165, "", "=q4=Sanctified Lightsworn Tunic", "=ds=#s5#, #a4#" };
		{ 12, 51169, "", "=q4=Sanctified Lightsworn Gloves", "=ds=#s9#, #a4#" };
		{ 13, 51168, "", "=q4=Sanctified Lightsworn Greaves", "=ds=#s11#, #a4#" };
		{ 16, 0, "Spell_Holy_HolyBolt", "=q6=#t10s4_1#", "=q5="..AL["Tier 10"]};
		{ 17, 51272, "", "=q4=Sanctified Lightsworn Headpiece", "=ds=#s1#, #a4#"};
		{ 18, 51273, "", "=q4=Sanctified Lightsworn Spaulders", "=ds=#s3#, #a4#"};
		{ 19, 51274, "", "=q4=Sanctified Lightsworn Tunic", "=ds=#s5#, #a4#"};
		{ 20, 51270, "", "=q4=Sanctified Lightsworn Gloves", "=ds=#s9#, #a4#"};
		{ 21, 51271, "", "=q4=Sanctified Lightsworn Greaves", "=ds=#s11#, #a4#"};
		Back = "T10SET";
	};

	AtlasLoot_Data["T10PaladinRetribution"] = {
		{ 1, 0, "Spell_Holy_AuraOfLight", "=q6=#t10s4_2#", "=q5="..AL["Tier 10"]};
		{ 2, 50326, "", "=q4=Lightsworn Helmet", "=ds=#s1#, #a4#", "95 #eoffrost#" };
		{ 3, 50324, "", "=q4=Lightsworn Shoulderplates", "=ds=#s3#, #a4#", "60 #eoffrost#" };
		{ 4, 50328, "", "=q4=Lightsworn Battleplate", "=ds=#s5#, #a4#", "95 #eoffrost#" };
		{ 5, 50327, "", "=q4=Lightsworn Gauntlets", "=ds=#s9#, #a4#", "60 #eoffrost#" };
		{ 6, 50325, "", "=q4=Lightsworn Legplates", "=ds=#s11#, #a4#", "95 #eoffrost#" };
		{ 8, 0, "Spell_Holy_AuraOfLight", "=q6=#t10s4_2#", "=q5="..AL["Tier 10"]};
		{ 9, 51162, "", "=q4=Sanctified Lightsworn Helmet", "=ds=#s1#, #a4#" };
		{ 10, 51160, "", "=q4=Sanctified Lightsworn Shoulderplates", "=ds=#s3#, #a4#" };
		{ 11, 51164, "", "=q4=Sanctified Lightsworn Battleplate", "=ds=#s5#, #a4#" };
		{ 12, 51163, "", "=q4=Sanctified Lightsworn Gauntlets", "=ds=#s9#, #a4#" };
		{ 13, 51161, "", "=q4=Sanctified Lightsworn Legplates", "=ds=#s11#, #a4#" };
		{ 16, 0, "Spell_Holy_AuraOfLight", "=q6=#t10s4_2#", "=q5="..AL["Tier 10"]};
		{ 17, 51277, "", "=q4=Sanctified Lightsworn Helmet", "=ds=#s1#, #a4#"};
		{ 18, 51279, "", "=q4=Sanctified Lightsworn Shoulderplates", "=ds=#s3#, #a4#"};
		{ 19, 51275, "", "=q4=Sanctified Lightsworn Battleplate", "=ds=#s5#, #a4#"};
		{ 20, 51276, "", "=q4=Sanctified Lightsworn Gauntlets", "=ds=#s9#, #a4#"};
		{ 21, 51278, "", "=q4=Sanctified Lightsworn Legplates", "=ds=#s11#, #a4#"};
		Back = "T10SET";
	};

	AtlasLoot_Data["T10PaladinProtection"] = {
		{ 1, 0, "Spell_Holy_SealOfMight", "=q6=#t10s4_3#", "=q5="..AL["Tier 10"]};
		{ 2, 50862, "", "=q4=Lightsworn Faceguard", "=ds=#s1#, #a4#", "95 #eoffrost#" };
		{ 3, 50860, "", "=q4=Lightsworn Shoulderguards", "=ds=#s3#, #a4#", "60 #eoffrost#" };
		{ 4, 50864, "", "=q4=Lightsworn Chestguard", "=ds=#s5#, #a4#", "95 #eoffrost#" };
		{ 5, 50863, "", "=q4=Lightsworn Handguards", "=ds=#s9#, #a4#", "60 #eoffrost#" };
		{ 6, 50861, "", "=q4=Lightsworn Legguards", "=ds=#s11#, #a4#", "95 #eoffrost#" };
		{ 8, 0, "Spell_Holy_SealOfMight", "=q6=#t10s4_3#", "=q5="..AL["Tier 10"]};
		{ 9, 51173, "", "=q4=Sanctified Lightsworn Faceguard", "=ds=#s1#, #a4#" };
		{ 10, 51170, "", "=q4=Sanctified Lightsworn Shoulderguards", "=ds=#s3#, #a4#" };
		{ 11, 51174, "", "=q4=Sanctified Lightsworn Chestguard", "=ds=#s5#, #a4#" };
		{ 12, 51172, "", "=q4=Sanctified Lightsworn Handguards", "=ds=#s9#, #a4#" };
		{ 13, 51171, "", "=q4=Sanctified Lightsworn Legguards", "=ds=#s11#, #a4#" };
		{ 16, 0, "Spell_Holy_SealOfMight", "=q6=#t10s4_3#", "=q5="..AL["Tier 10"]};
		{ 17, 51266, "", "=q4=Sanctified Lightsworn Faceguard", "=ds=#s1#, #a4#"};
		{ 18, 51269, "", "=q4=Sanctified Lightsworn Shoulderguards", "=ds=#s3#, #a4#"};
		{ 19, 51265, "", "=q4=Sanctified Lightsworn Chestguard", "=ds=#s5#, #a4#"};
		{ 20, 51267, "", "=q4=Sanctified Lightsworn Handguards", "=ds=#s9#, #a4#"};
		{ 21, 51268, "", "=q4=Sanctified Lightsworn Legguards", "=ds=#s11#, #a4#"};
		Back = "T10SET";
	};

	AtlasLoot_Data["T10PriestShadow"] = {
		{ 1, 0, "Spell_Shadow_AntiShadow", "=q6=#t10s5_1#", "=q5="..AL["Tier 10"]};
		{ 2, 50392, "", "=q4=Crimson Acolyte Cowl", "=ds=#s1#, #a1#", "95 #eoffrost#" };
		{ 3, 50396, "", "=q4=Crimson Acolyte Mantle", "=ds=#s3#, #a1#", "60 #eoffrost#" };
		{ 4, 50394, "", "=q4=Crimson Acolyte Raiments", "=ds=#s5#, #a1#", "95 #eoffrost#" };
		{ 5, 50391, "", "=q4=Crimson Acolyte Handwraps", "=ds=#s9#, #a1#", "60 #eoffrost#" };
		{ 6, 50393, "", "=q4=Crimson Acolyte Pants", "=ds=#s11#, #a1#", "95 #eoffrost#" };
		{ 8, 0, "Spell_Shadow_AntiShadow", "=q6=#t10s5_1#", "=q5="..AL["Tier 10"]};
		{ 9, 51184, "", "=q4=Sanctified Crimson Acolyte Cowl", "=ds=#s1#, #a1#"};
		{ 10, 51182, "", "=q4=Sanctified Crimson Acolyte Mantle", "=ds=#s3#, #a1#"};
		{ 11, 51180, "", "=q4=Sanctified Crimson Acolyte Raiments", "=ds=#s5#, #a1#"};
		{ 12, 51183, "", "=q4=Sanctified Crimson Acolyte Handwraps", "=ds=#s9#, #a1#"};
		{ 13, 51181, "", "=q4=Sanctified Crimson Acolyte Pants", "=ds=#s11#, #a1#"};
		{ 16, 0, "Spell_Shadow_AntiShadow", "=q6=#t10s5_1#", "=q5="..AL["Tier 10"]};
		{ 17, 51255, "", "=q4=Sanctified Crimson Acolyte Cowl", "=ds=#s1#, #a1#"};
		{ 18, 51257, "", "=q4=Sanctified Crimson Acolyte Mantle", "=ds=#s3#, #a1#"};
		{ 19, 51259, "", "=q4=Sanctified Crimson Acolyte Raiments", "=ds=#s5#, #a1#"};
		{ 20, 51256, "", "=q4=Sanctified Crimson Acolyte Handwraps", "=ds=#s9#, #a1#"};
		{ 21, 51258, "", "=q4=Sanctified Crimson Acolyte Pants", "=ds=#s11#, #a1#"};
		Back = "T10SET";
	};

	AtlasLoot_Data["T10PriestHoly"] = {
		{ 1, 0, "Spell_Holy_PowerWordShield", "=q6=#t10s5_2#", "=q5="..AL["Tier 10"]};
		{ 2, 50765, "", "=q4=Crimson Acolyte Hood", "=ds=#s1#, #a1#", "95 #eoffrost#" };
		{ 3, 50767, "", "=q4=Crimson Acolyte Shoulderpads", "=ds=#s3#, #a1#", "60 #eoffrost#" };
		{ 4, 50768, "", "=q4=Crimson Acolyte Robe", "=ds=#s5#, #a1#", "95 #eoffrost#" };
		{ 5, 50766, "", "=q4=Crimson Acolyte Gloves", "=ds=#s9#, #a1#", "60 #eoffrost#" };
		{ 6, 50769, "", "=q4=Crimson Acolyte Leggings", "=ds=#s11#, #a1#", "95 #eoffrost#" };
		{ 8, 0, "Spell_Holy_PowerWordShield", "=q6=#t10s5_2#", "=q5="..AL["Tier 10"]};
		{ 9, 51178, "", "=q4=Sanctified Crimson Acolyte Hood", "=ds=#s1#, #a1#"};
		{ 10, 51175, "", "=q4=Sanctified Crimson Acolyte Shoulderpads", "=ds=#s3#, #a1#"};
		{ 11, 51176, "", "=q4=Sanctified Crimson Acolyte Robe", "=ds=#s5#, #a1#"};
		{ 12, 51179, "", "=q4=Sanctified Crimson Acolyte Gloves", "=ds=#s9#, #a1#"};
		{ 13, 51177, "", "=q4=Sanctified Crimson Acolyte Leggings", "=ds=#s11#, #a1#"};
		{ 16, 0, "Spell_Holy_PowerWordShield", "=q6=#t10s5_2#", "=q5="..AL["Tier 10"]};
		{ 17, 51261, "", "=q4=Sanctified Crimson Acolyte Hood", "=ds=#s1#, #a1#"};
		{ 18, 51264, "", "=q4=Sanctified Crimson Acolyte Shoulderpads", "=ds=#s3#, #a1#"};
		{ 19, 51263, "", "=q4=Sanctified Crimson Acolyte Robe", "=ds=#s5#, #a1#"};
		{ 20, 51260, "", "=q4=Sanctified Crimson Acolyte Gloves", "=ds=#s9#, #a1#"};
		{ 21, 51262, "", "=q4=Sanctified Crimson Acolyte Leggings", "=ds=#s11#, #a1#"};
		Back = "T10SET";
	};

	AtlasLoot_Data["T10Rogue"] = {
		{ 1, 0, "Ability_BackStab", "=q6=#t10s6#", "=q5="..AL["Tier 10"]};
		{ 2, 50089, "", "=q4=Shadowblade Helmet", "=ds=#s1#, #a2#", "95 #eoffrost#" };
		{ 3, 50105, "", "=q4=Shadowblade Pauldrons", "=ds=#s3#, #a2#", "60 #eoffrost#" };
		{ 4, 50087, "", "=q4=Shadowblade Breastplate", "=ds=#s5#, #a2#", "95 #eoffrost#" };
		{ 5, 50088, "", "=q4=Shadowblade Gauntlets", "=ds=#s9#, #a2#", "60 #eoffrost#" };
		{ 6, 50090, "", "=q4=Shadowblade Legplates", "=ds=#s11#, #a2#", "95 #eoffrost#" };
		{ 8, 0, "Ability_BackStab", "=q6=#t10s6#", "=q5="..AL["Tier 10"]};
		{ 9, 51187, "", "=q4=Sanctified Shadowblade Helmet", "=ds=#s1#, #a2#"};
		{ 10, 51185, "", "=q4=Sanctified Shadowblade Pauldrons", "=ds=#s3#, #a2#"};
		{ 11, 51189, "", "=q4=Sanctified Shadowblade Breastplate", "=ds=#s5#, #a2#"};
		{ 12, 51188, "", "=q4=Sanctified Shadowblade Gauntlets", "=ds=#s9#, #a2#"};
		{ 13, 51186, "", "=q4=Sanctified Shadowblade Legplates", "=ds=#s11#, #a2#"};
		{ 16, 0, "Ability_BackStab", "=q6=#t10s6#", "=q5="..AL["Tier 10"]};
		{ 17, 51252, "", "=q4=Sanctified Shadowblade Helmet", "=ds=#s1#, #a2#"};
		{ 18, 51254, "", "=q4=Sanctified Shadowblade Pauldrons", "=ds=#s3#, #a2#"};
		{ 19, 51250, "", "=q4=Sanctified Shadowblade Breastplate", "=ds=#s5#, #a2#"};
		{ 20, 51251, "", "=q4=Sanctified Shadowblade Gauntlets", "=ds=#s9#, #a2#"};
		{ 21, 51253, "", "=q4=Sanctified Shadowblade Legplates", "=ds=#s11#, #a2#"};
		Back = "T10SET";
	};

	AtlasLoot_Data["T10ShamanElemental"] = {
		{ 1, 0, "Spell_Nature_Lightning", "=q6=#t10s7_3#", "=q5="..AL["Tier 10"]};
		{ 2, 50843, "", "=q4=Frost Witch's Helm", "=ds=#s1#, #a3#", "95 #eoffrost#" };
		{ 3, 50845, "", "=q4=Frost Witch's Shoulderpads", "=ds=#s3#, #a3#", "60 #eoffrost#" };
		{ 4, 50841, "", "=q4=Frost Witch's Hauberk", "=ds=#s5#, #a3#", "95 #eoffrost#" };
		{ 5, 50842, "", "=q4=Frost Witch's Gloves", "=ds=#s9#, #a3#", "60 #eoffrost#" };
		{ 6, 50844, "", "=q4=Frost Witch's Kilt", "=ds=#s11#, #a3#", "95 #eoffrost#" };
		{ 8, 0, "Spell_Nature_Lightning", "=q6=#t10s7_3#", "=q5="..AL["Tier 10"]};
		{ 9, 51202, "", "=q4=Sanctified Frost Witch's Helm", "=ds=#s1#, #a3#" };
		{ 10, 51204, "", "=q4=Sanctified Frost Witch's Shoulderpads", "=ds=#s3#, #a3#" };
		{ 11, 51200, "", "=q4=Sanctified Frost Witch's Hauberk", "=ds=#s5#, #a3#" };
		{ 12, 51201, "", "=q4=Sanctified Frost Witch's Gloves", "=ds=#s9#, #a3#" };
		{ 13, 51203, "", "=q4=Sanctified Frost Witch's Kilt", "=ds=#s11#, #a3#" };
		{ 16, 0, "Spell_Nature_Lightning", "=q6=#t10s7_3#", "=q5="..AL["Tier 10"]};
		{ 17, 51237, "", "=q4=Sanctified Frost Witch's Helm", "=ds=#s1#, #a3#"};
		{ 18, 51235, "", "=q4=Sanctified Frost Witch's Shoulderpads", "=ds=#s3#, #a3#"};
		{ 19, 51239, "", "=q4=Sanctified Frost Witch's Hauberk", "=ds=#s5#, #a3#"};
		{ 20, 51238, "", "=q4=Sanctified Frost Witch's Gloves", "=ds=#s9#, #a3#"};
		{ 21, 51236, "", "=q4=Sanctified Frost Witch's Kilt", "=ds=#s11#, #a3#"};
		Back = "T10SET";
	};

	AtlasLoot_Data["T10ShamanEnhancement"] = {
		{ 1, 0, "Spell_FireResistanceTotem_01", "=q6=#t10s7_2#", "=q5="..AL["Tier 10"]};
		{ 2, 50832, "", "=q4=Frost Witch's Faceguard", "=ds=#s1#, #a3#", "95 #eoffrost#" };
		{ 3, 50834, "", "=q4=Frost Witch's Shoulderguards", "=ds=#s3#, #a3#", "60 #eoffrost#" };
		{ 4, 50830, "", "=q4=Frost Witch's Chestguard", "=ds=#s5#, #a3#", "95 #eoffrost#" };
		{ 5, 50831, "", "=q4=Frost Witch's Grips", "=ds=#s9#, #a3#", "60 #eoffrost#" };
		{ 6, 50833, "", "=q4=Frost Witch's War-Kilt", "=ds=#s11#, #a3#", "95 #eoffrost#" };
		{ 8, 0, "Spell_FireResistanceTotem_01", "=q6=#t10s7_2#", "=q5="..AL["Tier 10"]};
		{ 9, 51197, "", "=q4=Sanctified Frost Witch's Faceguard", "=ds=#s1#, #a3#" };
		{ 10, 51199, "", "=q4=Sanctified Frost Witch's Shoulderguards", "=ds=#s3#, #a3#" };
		{ 11, 51195, "", "=q4=Sanctified Frost Witch's Chestguard", "=ds=#s5#, #a3#" };
		{ 12, 51196, "", "=q4=Sanctified Frost Witch's Grips", "=ds=#s9#, #a3#" };
		{ 13, 51198, "", "=q4=Sanctified Frost Witch's War-Kilt", "=ds=#s11#, #a3#" };
		{ 16, 0, "Spell_FireResistanceTotem_01", "=q6=#t10s7_2#", "=q5="..AL["Tier 10"]};
		{ 17, 51242, "", "=q4=Sanctified Frost Witch's Faceguard", "=ds=#s1#, #a3#"};
		{ 18, 51240, "", "=q4=Sanctified Frost Witch's Shoulderguards", "=ds=#s3#, #a3#"};
		{ 19, 51244, "", "=q4=Sanctified Frost Witch's Chestguard", "=ds=#s5#, #a3#"};
		{ 20, 51243, "", "=q4=Sanctified Frost Witch's Grips", "=ds=#s9#, #a3#"};
		{ 21, 51241, "", "=q4=Sanctified Frost Witch's War-Kilt", "=ds=#s11#, #a3#"};
		Back = "T10SET";
	
	};

	AtlasLoot_Data["T10ShamanRestoration"] = {
		{ 1, 0, "Spell_Nature_HealingWaveGreater", "=q6=#t10s7_1#", "=q5="..AL["Tier 10"]};
		{ 2, 50837, "", "=q4=Frost Witch's Headpiece", "=ds=#s1#, #a3#", "95 #eoffrost#" };
		{ 3, 50839, "", "=q4=Frost Witch's Spaulders", "=ds=#s3#, #a3#", "60 #eoffrost#" };
		{ 4, 50835, "", "=q4=Frost Witch's Tunic", "=ds=#s5#, #a3#", "95 #eoffrost#" };
		{ 5, 50836, "", "=q4=Frost Witch's Handguards", "=ds=#s9#, #a3#", "60 #eoffrost#" };
		{ 6, 50838, "", "=q4=Frost Witch's Legguards", "=ds=#s11#, #a3#", "95 #eoffrost#" };
		{ 8, 0, "Spell_Nature_HealingWaveGreater", "=q6=#t10s7_1#", "=q5="..AL["Tier 10"]};
		{ 9, 51192, "", "=q4=Sanctified Frost Witch's Headpiece", "=ds=#s1#, #a3#" };
		{ 10, 51194, "", "=q4=Sanctified Frost Witch's Spaulders", "=ds=#s3#, #a3#" };
		{ 11, 51190, "", "=q4=Sanctified Frost Witch's Tunic", "=ds=#s5#, #a3#" };
		{ 12, 51191, "", "=q4=Sanctified Frost Witch's Handguards", "=ds=#s9#, #a3#" };
		{ 13, 51193, "", "=q4=Sanctified Frost Witch's Legguards", "=ds=#s11#, #a3#" };
		{ 16, 0, "Spell_Nature_HealingWaveGreater", "=q6=#t10s7_1#", "=q5="..AL["Tier 10"]};
		{ 17, 51247, "", "=q4=Sanctified Frost Witch's Headpiece", "=ds=#s1#, #a3#"};
		{ 18, 51245, "", "=q4=Sanctified Frost Witch's Spaulders", "=ds=#s3#, #a3#"};
		{ 19, 51249, "", "=q4=Sanctified Frost Witch's Tunic", "=ds=#s5#, #a3#"};
		{ 20, 51248, "", "=q4=Sanctified Frost Witch's Handguards", "=ds=#s9#, #a3#"};
		{ 21, 51246, "", "=q4=Sanctified Frost Witch's Legguards", "=ds=#s11#, #a3#"};
		Back = "T10SET";
	};

	AtlasLoot_Data["T10Warlock"] = {
		{ 1, 0, "Spell_Shadow_CurseOfTounges", "=q6=#t10s8#", "=q5="..AL["Tier 10"]};
		{ 2, 50241, "", "=q4=Dark Coven Hood", "=ds=#s1#, #a1#", "95 #eoffrost#" };
		{ 3, 50244, "", "=q4=Dark Coven Shoulderpads", "=ds=#s3#, #a1#", "60 #eoffrost#" };
		{ 4, 50243, "", "=q4=Dark Coven Robe", "=ds=#s5#, #a1#", "95 #eoffrost#" };
		{ 5, 50240, "", "=q4=Dark Coven Gloves", "=ds=#s9#, #a1#", "60 #eoffrost#" };
		{ 6, 50242, "", "=q4=Dark Coven Leggings", "=ds=#s11#, #a1#", "95 #eoffrost#" };
		{ 8, 0, "Spell_Shadow_CurseOfTounges", "=q6=#t10s8#", "=q5="..AL["Tier 10"]};
		{ 9, 51208, "", "=q4=Sanctified Dark Coven Hood", "=ds=#s1#, #a1#"};
		{ 10, 51205, "", "=q4=Sanctified Dark Coven Shoulderpads", "=ds=#s3#, #a1#"};
		{ 11, 51206, "", "=q4=Sanctified Dark Coven Robe", "=ds=#s5#, #a1#"};
		{ 12, 51209, "", "=q4=Sanctified Dark Coven Gloves", "=ds=#s9#, #a1#"};
		{ 13, 51207, "", "=q4=Sanctified Dark Coven Leggings", "=ds=#s11#, #a1#"};
		{ 16, 0, "Spell_Shadow_CurseOfTounges", "=q6=#t10s8#", "=q5="..AL["Tier 10"]};
		{ 17, 51231, "", "=q4=Sanctified Dark Coven Hood", "=ds=#s1#, #a1#"};
		{ 18, 51234, "", "=q4=Sanctified Dark Coven Shoulderpads", "=ds=#s3#, #a1#"};
		{ 19, 51233, "", "=q4=Sanctified Dark Coven Robe", "=ds=#s5#, #a1#"};
		{ 20, 51230, "", "=q4=Sanctified Dark Coven Gloves", "=ds=#s9#, #a1#"};
		{ 21, 51232, "", "=q4=Sanctified Dark Coven Leggings", "=ds=#s11#, #a1#"};
		Back = "T10SET";
	};

	AtlasLoot_Data["T10WarriorFury"] = {
		{ 1, 0, "Ability_Warrior_BattleShout", "=q6=#t10s9_1#", "=q5="..AL["Tier 10"]};
		{ 2, 50080, "", "=q4=Ymirjar Lord's Helmet", "=ds=#s1#, #a4#", "95 #eoffrost#" };
		{ 3, 50082, "", "=q4=Ymirjar Lord's Shoulderplates", "=ds=#s3#, #a4#", "60 #eoffrost#" };
		{ 4, 50078, "", "=q4=Ymirjar Lord's Battleplate", "=ds=#s5#, #a4#", "95 #eoffrost#" };
		{ 5, 50079, "", "=q4=Ymirjar Lord's Gauntlets", "=ds=#s9#, #a4#", "60 #eoffrost#" };
		{ 6, 50081, "", "=q4=Ymirjar Lord's Legplates", "=ds=#s11#, #a4#", "95 #eoffrost#" };
		{ 8, 0, "Ability_Warrior_BattleShout", "=q6=#t10s9_1#", "=q5="..AL["Tier 10"]};
		{ 9, 51212, "", "=q4=Ymirjar Lord's Helmet", "=ds=#s1#, #a4#"};
		{ 10, 51210, "", "=q4=Ymirjar Lord's Shoulderplates", "=ds=#s3#, #a4#"};
		{ 11, 51214, "", "=q4=Ymirjar Lord's Battleplate", "=ds=#s5#, #a4#"};
		{ 12, 51213, "", "=q4=Ymirjar Lord's Gauntlets", "=ds=#s9#, #a4#"};
		{ 13, 51211, "", "=q4=Ymirjar Lord's Legplates", "=ds=#s11#, #a4#"};
		{ 16, 0, "Ability_Warrior_BattleShout", "=q6=#t10s9_1#", "=q5="..AL["Tier 10"]};
		{ 17, 51227, "", "=q4=Ymirjar Lord's Helmet", "=ds=#s1#, #a4#"};
		{ 18, 51229, "", "=q4=Ymirjar Lord's Shoulderplates", "=ds=#s3#, #a4#"};
		{ 19, 51225, "", "=q4=Ymirjar Lord's Battleplate", "=ds=#s5#, #a4#"};
		{ 20, 51226, "", "=q4=Ymirjar Lord's Gauntlets", "=ds=#s9#, #a4#"};
		{ 21, 51228, "", "=q4=Ymirjar Lord's Legplates", "=ds=#s11#, #a4#"};
		Back = "T10SET";
	};

	AtlasLoot_Data["T10WarriorProtection"] = {
		{ 1, 0, "INV_Shield_05", "=q6=#t10s9_2#", "=q5="..AL["Tier 10"]};
		{ 2, 50848, "", "=q4=Ymirjar Lord's Greathelm", "=ds=#s1#, #a4#", "95 #eoffrost#" };
		{ 3, 50846, "", "=q4=Ymirjar Lord's Pauldrons", "=ds=#s3#, #a4#", "60 #eoffrost#" };
		{ 4, 50850, "", "=q4=Ymirjar Lord's Breastplate", "=ds=#s5#, #a4#", "95 #eoffrost#" };
		{ 5, 50849, "", "=q4=Ymirjar Lord's Handguards", "=ds=#s9#, #a4#", "60 #eoffrost#" };
		{ 6, 50847, "", "=q4=Ymirjar Lord's Legguards", "=ds=#s11#, #a4#", "95 #eoffrost#" };
		{ 8, 0, "INV_Shield_05", "=q6=#t10s9_2#", "=q5="..AL["Tier 10"]};
		{ 9, 51218, "", "=q4=Ymirjar Lord's Greathelm", "=ds=#s1#, #a4#"};
		{ 10, 51215, "", "=q4=Ymirjar Lord's Pauldrons", "=ds=#s3#, #a4#"};
		{ 11, 51219, "", "=q4=Ymirjar Lord's Breastplate", "=ds=#s5#, #a4#"};
		{ 12, 51217, "", "=q4=Ymirjar Lord's Handguards", "=ds=#s9#, #a4#"};
		{ 13, 51216, "", "=q4=Ymirjar Lord's Legguards", "=ds=#s11#, #a4#"};
		{ 16, 0, "INV_Shield_05", "=q6=#t10s9_2#", "=q5="..AL["Tier 10"]};
		{ 17, 51221, "", "=q4=Ymirjar Lord's Greathelm", "=ds=#s1#, #a4#"};
		{ 18, 51224, "", "=q4=Ymirjar Lord's Pauldrons", "=ds=#s3#, #a4#"};
		{ 19, 51220, "", "=q4=Ymirjar Lord's Breastplate", "=ds=#s5#, #a4#"};
		{ 20, 51222, "", "=q4=Ymirjar Lord's Handguards", "=ds=#s9#, #a4#"};
		{ 21, 51223, "", "=q4=Ymirjar Lord's Legguards", "=ds=#s11#, #a4#"};
		Back = "T10SET";
	};

		-----------------------------------
		--- Wrath Of The Lich King Sets ---
		-----------------------------------

	AtlasLoot_Data["WOTLKSets"] = {
		{ 1, 0, "INV_Box_01", "=q6=#wotlk1#", "=q1=#z17#"};
		{ 2, 37758, "", "=q3=Raine's Choker of Combustion", "=ds=#s2#"};
		{ 3, 37821, "", "=q3=Raine's Signet of Blasting", "=ds=#s13#"};
		{ 5, 0, "INV_Box_01", "=q6=#wotlk2#", "=q1=#z15#"};
		{ 6, 49463, "", "=q4=Purified Shard of the Flame", "=ds=#s14#"};
		{ 7, 49310, "", "=q4=Purified Shard of the Scale", "=ds=#s14#"};
		{ 16, 0, "INV_Box_01", "=q6=#wotlk3#", "=q1=#z15#"};
		{ 17, 49464, "", "=q4=Shiny Shard of the Flame", "=ds=#s14#"};
		{ 18, 49488, "", "=q4=Shiny Shard of the Scale", "=ds=#s14#"};
		Back = "SETSWRATHOFLICHKING";
	};

		-------------------
		--- Legendaries ---
		-------------------

	AtlasLoot_Data["Legendaries"] = {
		{ 1, 34334, "", "=q5=Thori'dal, the Stars' Fury", "=ds=#w2#"};
		{ 3, 32837, "", "=q5=Warglaive of Azzinoth", "=ds=#h3#, #w10#, =q1=#m1# =ds=#c9#, #c6#"};
		{ 4, 32838, "", "=q5=Warglaive of Azzinoth", "=ds=#h4#, #w10#, =q1=#m1# =ds=#c9#, #c6#"};
		{ 6, 30312, "", "=q5=Infinity Blade", "=q1=#m26#: =ds=#h1#, #w4#"};
		{ 7, 30311, "", "=q5=Warp Slicer", "=q1=#m26#: =ds=#h1#, #w10#"};
		{ 8, 30317, "", "=q5=Cosmic Infuser", "=q1=#m26#: =ds=#h3#, #w6#"};
		{ 9, 30316, "", "=q5=Devastation", "=q1=#m26#: =ds=#h2#, #w1#"};
		{ 10, 30313, "", "=q5=Staff of Disintegration", "=q1=#m26#: =ds=#w9#"};
		{ 11, 30314, "", "=q5=Phaseshift Bulwark", "=q1=#m26#: =ds=#w8#"};
		{ 12, 30318, "", "=q5=Netherstrand Longbow", "=q1=#m26#: =ds=#w2#, =q1=#m1# =ds=#c2#"};
		{ 13, 30319, "", "=q5=Nether Spike", "=q1=#m26#: =ds=#w17#"};
		{ 16, 22736, "", "=q5=Andonisus, Reaper of Souls", "=q1=#m26#: =ds=#h3#, #w10#"};
		{ 17, 19019, "", "=q5=Thunderfury, Blessed Blade of the Windseeker", "=ds=#h1#, #w10#"};
		{ 18, 17182, "", "=q5=Sulfuras, Hand of Ragnaros", "=ds=#h2#, #w6#"};
		{ 19, 21176, "", "=q5=Black Qiraji Resonating Crystal", "=ds=#e12#"};
		{ 21, 22632, "", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#w9#, =q1=#m1# =ds=#c1#"};
		{ 22, 22589, "", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#w9#, =q1=#m1# =ds=#c3#"};
		{ 23, 22631, "", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#w9#, =q1=#m1# =ds=#c5#"};
		{ 24, 22630, "", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#w9#, =q1=#m1# =ds=#c8#"};
		{ 26, 49623, "", "=q5=Shadowmourne", "=ds=#h2# #w1#", "" };
		{ 27, 46017, "", "=q5=Val'anyr, Hammer of Ancient Kings", "=ds=#h3# #w6#", "" };
		Back = "SETMENU";
	};

		---------------
		--- Tabards ---
		---------------

	AtlasLoot_Data["Tabards3"] = {
		{ 1, 51534, "", "=q4=Wrathful Gladiator's Tabard", "=ds=#s7#"};
		{ 2, 49086, "", "=q4=Relentless Gladiator's Tabard", "=ds=#s7#"};
		{ 3, 45983, "", "=q4=Furious Gladiator's Tabard", "=ds=#s7#"};
		{ 4, 43349, "", "=q4=Tabard of Brute Force", "=ds=#m32#"};
		{ 5, 40643, "", "=q4=Tabard of the Achiever", "=ds=#m32#"};
		{ 6, 43348, "", "=q4=Tabard of the Explorer", "=ds=#m32#"};
		{ 7, 43300, "", "=q4=Loremaster's Colors", "=ds=#m32#"};
		{ 8, 49052, "", "=q3=Tabard of Conquest", "=ds=#m32# =ec1=#m7#"};
		{ 9, 49054, "", "=q3=Tabard of Conquest", "=ds=#m32# =ec1=#m6#"};
		{ 11, 46874, "", "=q3=Argent Crusader's Tabard", "=ds=#s7#"};
		{ 12, 46817, "", "=q1=Silver Covenant Tabard", "=ds=#s7# =ec1=#m7#"};
		{ 13, 46818, "", "=q1=Sunreaver Tabard", "=ds=#s7# =ec1=#m6#"};
		{ 16, 43154, "", "=q1=Tabard of the Argent Crusade", "=ds=#s7#"};
		{ 17, 43157, "", "=q1=Tabard of the Kirin Tor", "=ds=#s7#"};
		{ 18, 43155, "", "=q1=Tabard of the Ebon Blade", "=ds=#s7#"};
		{ 19, 43156, "", "=q1=Tabard of the Wyrmrest Accord", "=ds=#s7#"};
		{ 21, 45579, "", "=q1=Darnassus Tabard", "=ds=#s7# =ec1=#m7#"};
		{ 22, 45580, "", "=q1=Exodar Tabard", "=ds=#s7# =ec1=#m7#"};
		{ 23, 45578, "", "=q1=Gnomeregan Tabard", "=ds=#s7# =ec1=#m7#"};
		{ 24, 45577, "", "=q1=Ironforge Tabard", "=ds=#s7# =ec1=#m7#"};
		{ 25, 45574, "", "=q1=Stormwind Tabard", "=ds=#s7# =ec1=#m7#"};
		{ 26, 45581, "", "=q1=Orgrimmar Tabard", "=ds=#s7# =ec1=#m6#"};
		{ 27, 45582, "", "=q1=Sen'jin Tabard", "=ds=#s7# =ec1=#m6#"};
		{ 28, 45585, "", "=q1=Silvermoon City Tabard", "=ds=#s7# =ec1=#m6#"};
		{ 29, 45584, "", "=q1=Thunder Bluff Tabard", "=ds=#s7# =ec1=#m6#"};
		{ 30, 45583, "", "=q1=Undercity Tabard", "=ds=#s7# =ec1=#m6#"};
		Next = "Tabards2";
		Back = "SETMENU";
	};

	AtlasLoot_Data["Tabards2"] = {
		{ 1, 38312, "", "=q4=Tabard of Brilliance", "=ds=#s7#, =q1=#m24#"};
		{ 2, 23705, "", "=q4=Tabard of Flame", "=ds=#s7#, =q1=#m24#"};
		{ 3, 23709, "", "=q4=Tabard of Frost", "=ds=#s7#, =q1=#m24#"};
		{ 4, 38313, "", "=q4=Tabard of Fury", "=ds=#s7#, =q1=#m24#"};
		{ 5, 38309, "", "=q4=Tabard of Nature", "=ds=#s7#, =q1=#m24#"};
		{ 6, 38310, "", "=q4=Tabard of the Arcane", "=ds=#s7#, =q1=#m24#"};
		{ 7, 38314, "", "=q4=Tabard of the Defender", "=ds=#s7#, =q1=#m24#"};
		{ 8, 38311, "", "=q4=Tabard of the Void", "=ds=#s7#, =q1=#m24#"};
		{ 9, 35279, "", "=q3=Tabard of Summer Skies", "=ds=#s7#, =q1=#m4#"};
		{ 11, 35280, "", "=q3=Tabard of Summer Flames", "=ds=#s7#, =q1=#m4#"};
		{ 12, 31404, "", "=q2=Green Trophy Tabard of the Illidari", "=ds=#s7#, =q1=#m4#"};
		{ 13, 31405, "", "=q2=Purple Trophy Tabard of the Illidari", "=ds=#s7#, =q1=#m4#"};
		{ 14, 24344, "", "=q1=Tabard of the Hand", "=ds=#s7#, =q1=#m4#, =ec1=#m7#"};
		{ 15, 25549, "", "=q1=Blood Knight Tabard", "=ds=#s7#, =ec1=#m6#"};
		{ 16, 31779, "", "=q1=Aldor Tabard", "=ds=#s7#"};
		{ 17, 31804, "", "=q1=Cenarion Expedition Tabard", "=ds=#s7#"};
		{ 18, 31776, "", "=q1=Consortium Tabard", "=ds=#s7#"};
		{ 19, 23999, "", "=q1=Honor Hold Tabard", "=ds=#s7#, =ec1=#m7#"};
		{ 20, 31777, "", "=q1=Keepers of Time Tabard", "=ds=#s7#"};
		{ 21, 31774, "", "=q1=Kurenai Tabard", "=ds=#s7#, =ec1=#m7#"};
		{ 22, 31778, "", "=q1=Lower City Tabard", "=ds=#s7#"};
		{ 23, 31773, "", "=q1=Mag'har Tabard", "=ds=#s7#, =ec1=#m6#"};
		{ 24, 32828, "", "=q1=Ogri'la Tabard", "=ds=#s7#"};
		{ 25, 31781, "", "=q1=Sha'tar Tabard", "=ds=#s7#"};
		{ 26, 31775, "", "=q1=Sporeggar Tabard", "=ds=#s7#"};
		{ 27, 31780, "", "=q1=Scryers Tabard", "=ds=#s7#"};
		{ 28, 32445, "", "=q1=Skyguard Tabard", "=ds=#s7#"};
		{ 29, 35221, "", "=q1=Tabard of the Shattered Sun", "=ds=#s7#"};
		{ 30, 24004, "", "=q1=Thrallmar Tabard", "=ds=#s7#, =ec1=#m6#"};
		Prev = "Tabards3";
		Next = "Tabards1";
		Back = "SETMENU";
	};

	AtlasLoot_Data["Tabards1"] = {
		{ 1, 0, "INV_BannerPVP_02", "=q6=#m7#", ""};
		{ 2, 15196, "", "=q1=Private's Tabard", "=ds=#s7#"};
		{ 3, 15198, "", "=q1=Knight's Colors", "=ds=#s7#"};
		{ 4, 20132, "", "=q1=Arathor Battle Tabard", "=ds=#s7#, =q1=#m4#"};
		{ 5, 19032, "", "=q1=Stormpike Battle Tabard", "=ds=#s7#"};
		{ 6, 19506, "", "=q1=Silverwing Battle Tabard", "=ds=#s7#"};
		{ 8, 0, "INV_BannerPVP_01", "=q6=#m6#", ""};
		{ 9, 15197, "", "=q1=Scout's Tabard", "=ds=#s7#"};
		{ 10, 15199, "", "=q1=Stone Guard's Herald", "=ds=#s7#"};
		{ 11, 20131, "", "=q1=Battle Tabard of the Defilers", "=ds=#s7#, =q1=#m4#"};
		{ 12, 19031, "", "=q1=Frostwolf Battle Tabard", "=ds=#s7#"};
		{ 13, 19505, "", "=q1=Warsong Battle Tabard", "=ds=#s7#"};
		{ 16, 23192, "", "=q2=Tabard of the Scarlet Crusade", "=ds=#s7#", "", "0.48%"};
		{ 17, 5976, "", "=q1=Guild Tabard", "=ds=#s7#"};
		{ 19, 0, "INV_Box_01", "=q6=#j29#", ""};
		{ 20, 36941, "", "=q3=Competitor's Tabard", "=ds=#s7#"};
		{ 21, 22999, "", "=q1=Tabard of the Agent Dawn", "=ds=#s7#, =q1=#m4#"};
		{ 22, 28788, "", "=q1=Tabard of the Protector", "=ds=#s7#, =q1=#m4#"};
		{ 23, 19160, "", "=q1=Contest Winner's Tabard", "=ds=#s7#"};
		Prev = "Tabards2";
		Back = "SETMENU";
	};

		----------------------------------
		--- Upper Deck Card Game Items ---
		----------------------------------

	AtlasLoot_Data["CardGame1"] = {
		{ 1, 0, "INV_Box_01", "=q6=#ud4#", "=q1=#ud47#"};
		{ 2, 54068, "", "=q4=Wooly White Rhino ", "=ds=#ud48#"};
		{ 3, 54452, "", "=q3=Ethereal Portal", "=ds=#ud49#"};
		{ 4, 54455, "", "=q1=Paint Bomb", "=ds=#ud50#"};
		{ 6, 0, "INV_Box_01", "=q6=#ud4#", "=q1=#ud43#"};
		{ 7, 54069, "", "=q4=Blazing Hippogryph", "=ds=#ud46#"};
		{ 8, 54212, "", "=q3=Instant Statue Pedestal", "=ds=#ud45#"};
		{ 9, 54218, "", "=q1=Landro's Gift Box", "=ds=#ud44#"};
		{ 11, 0, "INV_Box_01", "=q6=#ud4#", "=q1=#ud39#"};
		{ 12, 49287, "", "=q4=Tuskarr Kite", "=ds=#ud41#"};
		{ 13, 49343, "", "=q3=Spectral Tiger Cub", "=ds=#ud42#"};
		{ 14, 49289, "", "=q2=Little White Stallion Bridle", "=ds=#ud40#"};
		{ 15, 49288, "", "=q2=Little Ivory Raptor Whistle", "=ds=#ud40#"};
		{ 16, 0, "INV_Box_01", "=q6=#ud4#", "=q1=#ud35#"};
		{ 17, 49290, "", "=q4=Magic Rooster Egg", "=ds=#ud38#"};
		{ 18, 46780, "", "=q3=Ogre Pinata", "=ds=#ud37#"};
		{ 19, 46779, "", "=q1=Path of Cenarius", "=ds=#ud36#"};
		{ 21, 0, "INV_Box_01", "=q6=#ud4#", "=q1=#ud31#"};
		{ 22, 45037, "", "=q4=Epic Purple Shirt", "=ds=#ud32#"};
		{ 23, 45063, "", "=q3=Foam Sword Rack", "=ds=#ud33#"};
		{ 24, 45047, "", "=q3=Sandbox Tiger", "=ds=#ud34#"};
		{ 26, 0, "INV_Box_01", "=q6=#ud4#", "=q1=#ud27#"};
		{ 27, 49282, "", "=q4=Big Battle Bear", "=ds=#ud28#"};
		{ 28, 38578, "", "=q3=The Flag of Ownership", "=ds=#ud29#"};
		{ 29, 38577, "", "=q1=Party G.R.E.N.A.D.E.", "=ds=#ud30#"};
		Next = "CardGame2";
		Back = "SETMENU";
	};

	AtlasLoot_Data["CardGame2"] = {
		{ 1, 0, "INV_Box_01", "=q6=#ud4#", "=q1=#ud23#"};
		{ 2, 38050, "", "=q3=Soul-Trader Beacon", "=ds=#ud26#"};
		{ 3, 38301, "", "=q3=D.I.S.C.O", "=ds=#ud25#"};
		{ 4, 38233, "", "=q1=Path of Illidan", "=ds=#ud24#"};
		{ 6, 0, "INV_Box_01", "=q6=#ud4#", "=q1=#ud19#"};
		{ 7, 35227, "", "=q4=Goblin Weather Machine - Prototype 01-B", "=ds=#ud21#"};
		{ 8, 49286, "", "=q4=X-51 Nether-Rocket X-TREME", "=ds=#ud22#"};
		{ 9, 49285, "", "=q3=X-51 Nether-Rocket", "=ds=#ud22#"};
		{ 10, 35223, "", "=q3=Papa Hummel's Old-Fashioned Pet Biscuit", "=ds=#ud20#"};
		{ 12, 0, "INV_Box_01", "=q6=#ud4#", "=q1=#ud15#"};
		{ 13, 34493, "", "=q4=Dragon Kite", "=ds=#ud16#"};
		{ 14, 34492, "", "=q3=Rocket Chicken", "=ds=#ud17#"};
		{ 15, 34499, "", "=q3=Paper Flying Machine Kit", "=ds=#ud18#"};
		{ 16, 0, "INV_Box_01", "=q6=#ud4#", "=q1=#ud3#"};
		{ 17, 49284, "", "=q4=Reins of the Swift Spectral Tiger", "=ds=#ud14#"};
		{ 18, 49283, "", "=q3=Reins of the Spectral Tiger", "=ds=#ud14#"};
		{ 19, 33223, "", "=q3=Fishing Chair", "=ds=#ud13#"};
		{ 20, 33219, "", "=q3=Goblin Gumbo Kettle", "=ds=#ud12#"};
		{ 22, 0, "INV_Box_01", "=q6=#ud4#", "=q1=#ud2#"};
		{ 23, 32588, "", "=q3=Banana Charm", "=ds=#ud9#"};
		{ 24, 32566, "", "=q3=Picnic Basket", "=ds=#ud10#"};
		{ 25, 32542, "", "=q3=Imp in a Ball", "=ds=#ud11#"};
		{ 27, 0, "INV_Box_01", "=q6=#ud4#", "=q1=#ud1#"};
		{ 28, 23705, "", "=q4=Tabard of Flame", "=ds=#ud6#"};
		{ 29, 23713, "", "=q4=Hippogryph Hatchling", "=ds=#ud7#"};
		{ 30, 23720, "", "=q4=Riding Turtle", "=ds=#ud8#"};	
		Prev = "CardGame1";
		Next = "CardGame3";
		Back = "SETMENU";
	};

	AtlasLoot_Data["CardGame3"] = {
		{ 1, 0, "INV_Box_01", "=q6=#ud5#", ""};
		{ 2, 38312, "", "=q4=Tabard of Brilliance", "=ds=#s7#"};
		{ 3, 23709, "", "=q4=Tabard of Frost", "=ds=#s7#"};
		{ 4, 38313, "", "=q4=Tabard of Fury", "=ds=#s7#"};
		{ 5, 38309, "", "=q4=Tabard of Nature", "=ds=#s7#"};
		{ 6, 38310, "", "=q4=Tabard of the Arcane", "=ds=#s7#"};
		{ 7, 38314, "", "=q4=Tabard of the Defender", "=ds=#s7#"};
		{ 8, 38314, "", "=q4=Tabard of the Defender", "=ds=#s7#"};
		{ 9, 38311, "", "=q4=Tabard of the Void", "=ds=#s7#"};
		{ 10, 49704, "", "=q4=Carved Ogre Idol", "=ds="};
		{ 11, 49703, "", "=q4=Perpetual Purple Firework", "=ds="};
		Prev = "CardGame2";
		Back = "SETMENU";
	};

		-------------------
		--- Vanity Pets ---
		-------------------

	AtlasLoot_Data["PetsMerchant1"] = {
		{ 1, 44984, "", "=q3=Ammen Vale Lashling", "=ds=#e13#"};
		{ 2, 54436, "", "=q3=Blue Clockwork Rocket Bot", "=ds=#e13#"};
		{ 3, 44970, "", "=q3=Dun Morogh Cub", "=ds=#e13#"};
		{ 4, 44973, "", "=q3=Durotar Scorpion", "=ds=#e13#"};
		{ 5, 44974, "", "=q3=Elwynn Lamb", "=ds=#e13#"};
		{ 6, 44982, "", "=q3=Enchanted Broom", "=ds=#e13#"};
		{ 7, 39973, "", "=q3=Ghostly Skull", "=ds=#e13#"};
		{ 8, 45002, "", "=q3=Mechanopeep", "=ds=#e13#"};
		{ 9, 44980, "", "=q3=Mulgore Hatchling", "=ds=#e13#"};
		{ 10, 45606, "", "=q3=Sen'jin Fetish", "=ds=#e13#"};
		{ 11, 44965, "", "=q3=Teldrassil Sproutling", "=ds=#e13#"};
		{ 12, 44971, "", "=q3=Tirisfal Batling", "=ds=#e13#"};
		{ 13, 44822, "", "=q1=Albino Snake", "=ds=#e13#"};
		{ 14, 11023, "", "=q1=Ancona Chicken", "=ds=#e13#"};
		{ 15, 10360, "", "=q1=Black Kingsnake", "=ds=#e13#"};
		{ 16, 10361, "", "=q1=Brown Snake", "=ds=#e13#"};
		{ 17, 29958, "", "=q1=Blue Dragonhawk Hatchling", "=ds=#e13#"};
		{ 18, 29901, "", "=q1=Blue Moth Egg", "=ds=#e13#"};
		{ 19, 29364, "", "=q1=Brown Rabbit Crate", "=ds=#e13#"};
		{ 20, 46398, "", "=q1=Calico Cat", "=ds=#e13#"};
		{ 21, 8485, "", "=q1=Cat Carrier (Bombay)", "=ds=#e13#"};
		{ 22, 8486, "", "=q1=Cat Carrier (Cornish Rex)", "=ds=#e13#"};
		{ 23, 8487, "", "=q1=Cat Carrier (Orange Tabby)", "=ds=#e13#"};
		{ 24, 8490, "", "=q1=Cat Carrier (Siamese)", "=ds=#e13#"};
		{ 25, 8488, "", "=q1=Cat Carrier (Silver Tabby)", "=ds=#e13#"};
		{ 26, 8489, "", "=q1=Cat Carrier (White Kitten)", "=ds=#e13#"};
		{ 27, 10393, "", "=q1=Cockroach", "=ds=#e13#"};
		{ 28, 10392, "", "=q1=Crimson Snake", "=ds=#e13#"};
		{ 29, 29953, "", "=q1=Golden Dragonhawk Hatchling", "=ds=#e13#"};
		{ 30, 8500, "", "=q1=Great Horned Owl", "=ds=#e13#"};
		Next = "PetsMerchant2";
		Back = "PETMENU";
	};

	AtlasLoot_Data["PetsMerchant2"] = {
		{ 1, 8501, "", "=q1=Hawk Owl", "=ds=#e13#"};
		{ 2, 29363, "", "=q1=Mana Wyrmling", "=ds=#e13#"};
		{ 3, 48120, "", "=q1=Obsidian Hatchling", "=ds=#e13#"};
		{ 4, 8496, "", "=q1=Parrot Cage (Cockatiel)", "=ds=#e13#"};
		{ 5, 8492, "", "=q1=Parrot Cage (Green Wing Macaw)", "=ds=#e13#"};
		{ 6, 8495, "", "=q1=Parrot Cage (Senegal)", "=ds=#e13#"};
		{ 7, 10394, "", "=q1=Prairie Dog Whistle", "=ds=#e13#"};
		{ 8, 8497, "", "=q1=Rabbit Crate (Snowshoe)", "=ds=#e13#"};
		{ 9, 29956, "", "=q1=Red Dragonhawk Hatchling", "=ds=#e13#"};
		{ 10, 29902, "", "=q1=Red Moth Egg", "=ds=#e13#"};
		{ 11, 29957, "", "=q1=Silver Dragonhawk Hatchling", "=ds=#e13#"};
		{ 12, 11026, "", "=q1=Tree Frog Box", "=ds=#e13#"};
		{ 13, 29904, "", "=q1=White Moth Egg", "=ds=#e13#"};
		{ 14, 11027, "", "=q1=Wood Frog Box", "=ds=#e13#"};
		{ 15, 29903, "", "=q1=Yellow Moth Egg", "=ds=#e13#"};
		Prev = "PetsMerchant1";
		Next = "PetsQuestCrafted1";
		Back = "PETMENU";
	};

	AtlasLoot_Data["PetsQuestCrafted1"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Quest"], ""};
		{ 2, 45022, "", "=q3=Argent Gruntling", "=ds=#e13# =ec1=#m6#"};
		{ 3, 44998, "", "=q3=Argent Squire", "=ds=#e13# =ec1=#m7#"};
		{ 4, 35350, "", "=q3=Chuck's Bucket", "=ds=#e13#"};
		{ 5, 33818, "", "=q3=Muckbreath's Bucket", "=ds=#e13#"};
		{ 6, 35349, "", "=q3=Snarly's Bucket", "=ds=#e13#"};
		{ 7, 44983, "", "=q3=Strand Crawler", "=ds=#e13#"};
		{ 8, 33816, "", "=q3=Toothy's Bucket", "=ds=#e13#"};
		{ 9, 19450, "", "=q1=A Jubling's Tiny Home", "=ds=#e13#"};
		{ 10, 11110, "", "=q1=Chicken Egg", "=ds=#e13#"};
		{ 11, 10398, "", "=q1=Mechanical Chicken", "=ds=#e13#"};
		{ 12, 31760, "", "=q1=Miniwing", "=ds=#e13#"};
		{ 13, 12529, "", "=q1=Smolderweb Carrier", "=ds=#e13#"};
		{ 14, 11474, "", "=q1=Sprite Darter Egg", "=ds=#e13#"};
		{ 15, 12264, "", "=q1=Worg Carrier", "=ds=#e13#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["Crafted"], ""};
		{ 17, 15996, "", "=q1=Lifelike Mechanical Toad", "=ds=#e13#"};
		{ 18, 11826, "", "=q1=Lil' Smoky", "=ds=#e13#"};
		{ 19, 4401, "", "=q1=Mechanical Squirrel Box", "=ds=#e13#"};
		{ 20, 11825, "", "=q1=Pet Bombling", "=ds=#e13#"};
		{ 21, 21277, "", "=q1=Tranquil Mechanical Yeti", "=ds=#e13#"};
		Prev = "PetsMerchant2";
		Next = "PetsRare1";
		Back = "PETMENU";
	};

	AtlasLoot_Data["PetsRare1"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Achievement"], ""};
		{ 2, 44738, "", "=q3=Kirin Tor Familiar", "=ds=#e13#"};
		{ 3, 44841, "", "=q3=Little Fawn's Salt Lick", "=ds=#e13#"};
		{ 4, 49912, "", "=q3=Perky Pug", "=ds=#e13#"};
		{ 5, 49646, "", "=q3=Core Hound Pup", "=ds=#e13#"};
		{ 6, 40653, "", "=q3=Reeking Pet Carrier", "=ds=#e13#"};
		{ 7, 44810, "", "=q3=Turkey Cage", "=ds=#e13#"};
		{ 8, 44819, "", "=q1=Baby Blizzard Bear", "=ds=#e13#"};
		{ 9, 49362, "", "=q1=Onyxian Whelpling", "=ds=#e13#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["Faction"], ""};
		{ 17, 38628, "", "=q3=Nether Ray Fry", "=ds=#e13#"};
		{ 18, 44723, "", "=q3=Nurtured Penguin Egg", "=ds=#e13#"};
		{ 19, 46820, "", "=q3=Shimmering Wyrmling", "=ds=#e13# =ec1=#m7#"};
		{ 20, 46821, "", "=q3=Shimmering Wyrmling", "=ds=#e13# =ec1=#m6#"};
		{ 21, 34478, "", "=q3=Tiny Sporebat", "=ds=#e13#"};
		{ 22, 39898, "", "=q1=Cobra Hatchling", "=ds=#e13#"};
		{ 23, 44721, "", "=q1=Proto-Drake Whelp", "=ds=#e13#"};
		{ 24, 39896, "", "=q1=Tickbird Hatchling", "=ds=#e13#"};
		{ 25, 39899, "", "=q1=White Tickbird Hatchling", "=ds=#e13#"};
		Prev = "PetsQuestCrafted1";
		Next = "PetsRare2";
		Back = "PETMENU";
	};

	AtlasLoot_Data["PetsRare2"] = {
		{ 1, 0, "INV_Box_01", "=q6=#z17#", ""};
		{ 2, 8494, "", "=q4=Parrot Cage (Hyacinth Macaw)", "=ds=#e13#"};
		{ 3, 43698, "", "=q3=Giant Sewer Rat", "=ds=#e13#"};
		{ 4, 34535, "", "=q1=Azure Whelpling", "=ds=#e13#"};
		{ 5, 29960, "", "=q1=Captured Firefly", "=ds=#e13#"};
		{ 6, 8491, "", "=q1=Cat Carrier (Black Tabby)", "=ds=#e13#"};
		{ 7, 10822, "", "=q1=Dark Whelpling", "=ds=#e13#"};
		{ 8, 48112, "", "=q1=Darting Hatchling", "=ds=#e13#"};
		{ 9, 20769, "", "=q1=Disgusting Oozeling", "=ds=#e13#"};
		{ 10, 48116, "", "=q1=Gundrak Hatchling", "=ds=#e13#"};
		{ 11, 48118, "", "=q1=Leaping Hatchling", "=ds=#e13#"};
		{ 12, 27445, "", "=q1=Magical Crawdad Box", "=ds=#e13#"};
		{ 13, 48122, "", "=q1=Ravasaur Hatchling", "=ds=#e13#"};
		{ 14, 48124, "", "=q1=Razormaw Hatchling", "=ds=#e13#"};
		{ 15, 8499, "", "=q1=Tiny Crimson Whelpling", "=ds=#e13#"};
		{ 16, 8498, "", "=q1=Tiny Emerald Whelpling", "=ds=#e13#"};
		{ 18, 0, "INV_Box_01", "=q6="..AL["Dungeon/Raid"], ""};
		{ 19, 33993, "", "=q3=Mojo", "=q1="..BabbleZone["Zul'Aman"]};
		{ 20, 35504, "", "=q3=Phoenix Hatchling", "=q2="..BabbleBoss["Kael'thas Sunstrider"]..", =q1="..BabbleZone["Magisters' Terrace"]};
		{ 21, 38658, "", "=q3=Vampiric Batling", "=q2="..BabbleBoss["Prince Tenris Mirkblood"]..", =q1="..BabbleZone["Karazhan"]};
		{ 22, 48114, "", "=q1=Deviate Hatchling", "=q2="..AL["Deviate Ravager/Deviate Guardian"]..", =q1="..BabbleZone["Wailing Caverns"]};
		{ 23, 48126, "", "=q1=Razzashi Hatchling", "=q2="..AL["Razzashi Raptor"]..", =q1="..BabbleZone["Zul'Gurub"]};
		Prev = "PetsRare1";
		Next = "PetsEvent1";
		Back = "PETMENU";
	};

	AtlasLoot_Data["PetsEvent1"] = {
		{ 1, 23083, "", "=q3=Captured Flame", "=ds=#e13#"};
		{ 2, 34425, "", "=q3=Clockwork Rocket Bot", "=ds=#e13#"};
		{ 3, 46545, "", "=q3=Curious Oracle Hatchling", "=ds=#e13#"};
		{ 4, 46544, "", "=q3=Curious Wolvar Pup", "=ds=#e13#"};
		{ 5, 32616, "", "=q3=Egbert's Egg", "=ds=#e13#"};
		{ 6, 32622, "", "=q3=Elekk Training Collar", "=ds=#e13#"};
		{ 7, 53641, "", "=q3=Ice Chip", "=ds=#e13#"};
		{ 8, 46707, "", "=q3=Pint-Sized Pink Pachyderm", "=ds=#e13#"};
		{ 9, 34955, "", "=q3=Scorched Stone", "=ds=#e13#"};
		{ 10, 33154, "", "=q3=Sinister Squashling", "=ds=#e13#"};
		{ 11, 32617, "", "=q3=Sleepy Willy", "=ds=#e13#"};
		{ 12, 44794, "", "=q3=Spring Rabbit's Foot", "=ds=#e13#"};
		{ 13, 32233, "", "=q3=Wolpertinger's Tankard", "=ds=#e13#"};
		{ 14, 50446, "", "=q3=Toxic Wasteling", "=ds=#e13#"};
		{ 16, 21301, "", "=q1=Green Helper Box", "=ds=#e13#"};
		{ 17, 21308, "", "=q1=Jingling Bell", "=ds=#e13#"};
		{ 18, 23007, "", "=q1=Piglet's Collar", "=ds=#e13#"};
		{ 19, 23015, "", "=q1=Rat Cage", "=ds=#e13#"};
		{ 20, 21305, "", "=q1=Red Helper Box", "=ds=#e13#"};
		{ 21, 21309, "", "=q1=Snowman Kit", "=ds=#e13#"};
		{ 22, 22235, "", "=q1=Truesilver Shafted Arrow", "=ds=#e13#"};
		{ 23, 23002, "", "=q1=Turtle Box", "=ds=#e13#"};
		Prev = "PetsRare1";
		Next = "PetsPromotional1";
		Back = "PETMENU";
	};

	AtlasLoot_Data["PetsPromotional1"] = {
		{ 1, 34493, "", "=q4=Dragon Kite", "=ds=#e13#"};
		{ 2, 23713, "", "=q4=Hippogryph Hatchling", "=ds=#e13#"};
		{ 3, 49287, "", "=q4=Tuskarr Kite", "=ds=#e13#"};
		{ 4, 32588, "", "=q3=Banana Charm", "=ds=#e13#"};
		{ 5, 20371, "", "=q3=Blue Murloc Egg", "=ds=#e13#"};
		{ 6, 13584, "", "=q3=Diablo Stone", "=ds=#e13#"};
		{ 7, 39286, "", "=q3=Frosty's Collar", "=ds=#e13#"};
		{ 8, 37297, "", "=q3=Gold Medallion", "=ds=#e13#"};
		{ 9, 46802, "", "=q3=Heavy Murloc Egg", "=ds=#e13#"};
		{ 10, 30360, "", "=q3=Lurky's Egg", "=ds=#e13#"};
		{ 11, 45180, "", "=q3=Murkimus' Little Spear", "=ds=#e13#"};
		{ 12, 25535, "", "=q3=Netherwhelp's Collar", "=ds=#e13#"};
		{ 13, 13583, "", "=q3=Panda Collar", "=ds=#e13#"};
		{ 14, 22114, "", "=q3=Pink Murloc Egg", "=ds=#e13#"};
		{ 15, 34492, "", "=q3=Rocket Chicken", "=ds=#e13#"};
		{ 16, 38050, "", "=q3=Soul-Trader Beacon", "=ds=#e13#"};
		{ 17, 49343, "", "=q3=Spectral Tiger Cub", "=ds=#e13#"};
		{ 18, 39656, "", "=q3=Tyrael's Hilt", "=ds=#e13#"};
		{ 19, 41133, "", "=q3=Unhatched Mr. Chilly", "=ds=#e13#"};
		{ 20, 46767, "", "=q3=Warbot Ignition Key", "=ds=#e13#"};
		{ 21, 13582, "", "=q3=Zergling Leash", "=ds=#e13#"};
		{ 22, 56806, "", "=q3=Mini Thor", "=ds=#e13#"};
		Prev = "PetsEvent1";
		Next = "PetsPetStore1";
		Back = "PETMENU";
	};

	AtlasLoot_Data["PetsPetStore1"] = {
		{ 1, 49693, "", "=q3=Lil' Phylactery", "=ds=#e13#"};
		{ 2, 54847, "", "=q3=Lil' XT", "=ds=#e13#"};
		{ 3, 49665, "", "=q3=Pandaren Monk", "=ds=#e13#"};
		{ 4, 49663, "", "=q3=Wind Rider Cub", "=ds=#e13#"};
		{ 5, 49662, "", "=q3=Gryphon Hatchling", "=ds=#e13#"};
		Prev = "PetsPromotional1";
		Next = "PetsAccessories1";
		Back = "PETMENU";
	};

	AtlasLoot_Data["PetsAccessories1"] = {
		{ 1, 47541, "", "=q3=Argent Pony Bridle", "=ds="};
		{ 2, 35223, "", "=q3=Papa Hummel's Old-Fashioned Pet Biscuit", "=ds="};
		{ 3, 37431, "", "=q2=Fetch Ball", "=ds="};
		{ 4, 43626, "", "=q2=Happy Pet Snack", "=ds="};
		{ 5, 43352, "", "=q2=Pet Grooming Kit", "=ds="};
		{ 6, 44820, "", "=q1=Red Ribbon Pet Leash", "=ds="};
		{ 7, 37460, "", "=q1=Rope Pet Leash", "=ds="};
		Prev = "PetsPetStore1";
		Back = "PETMENU";
	};

		--------------
		--- Mounts ---
		--------------

	AtlasLoot_Data["MountsAlliance1"] = {
		{ 1, 0, "inv_misc_tournaments_symbol_nightelf", "=q6="..BabbleFaction["Darnassus"].." #j30#", "=ec1=#m7#"};
		{ 2, 18766, "", "=q4=Reins of the Swift Frostsaber", "=ds=#e12#"};
		{ 3, 18767, "", "=q4=Reins of the Swift Mistsaber", "=ds=#e12#"};
		{ 4, 18902, "", "=q4=Reins of the Swift Stormsaber", "=ds=#e12#"};
		{ 5, 8632, "", "=q3=Reins of the Spotted Frostsaber", "=ds=#e12#"};
		{ 6, 47100, "", "=q3=Reins of the Striped Dawnsaber", "=ds=#e12#"};
		{ 7, 8631, "", "=q3=Reins of the Striped Frostsaber", "=ds=#e12#"};
		{ 8, 8629, "", "=q3=Reins of the Striped Nightsaber", "=ds=#e12#"};
		{ 16, 0, "inv_misc_tournaments_symbol_gnome", "=q6="..BabbleFaction["Gnomeregan Exiles"].." #j30#", "=ec1=#m7#"};
		{ 17, 18772, "", "=q4=Swift Green Mechanostrider", "=ds=#e12#"};
		{ 18, 18773, "", "=q4=Swift White Mechanostrider", "=ds=#e12#"};
		{ 19, 18774, "", "=q4=Swift Yellow Mechanostrider", "=ds=#e12#"};
		{ 20, 8595, "", "=q3=Blue Mechanostrider", "=ds=#e12#"};
		{ 21, 13321, "", "=q3=Green Mechanostrider", "=ds=#e12#"};
		{ 22, 8563, "", "=q3=Red Mechanostrider", "=ds=#e12#"};
		{ 23, 13322, "", "=q3=Unpainted Mechanostrider", "=ds=#e12#"};
		Next = "MountsAlliance2";
		Back = "MOUNTMENU";
	};

	AtlasLoot_Data["MountsAlliance2"] = {
		{ 1, 0, "inv_misc_tournaments_symbol_dwarf", "=q6="..BabbleFaction["Ironforge"].." #j30#", "=ec1=#m7#"};
		{ 2, 18786, "", "=q4=Swift Brown Ram", "=ds=#e12#"};
		{ 3, 18787, "", "=q4=Swift Gray Ram", "=ds=#e12#"};
		{ 4, 18785, "", "=q4=Swift White Ram", "=ds=#e12#"};
		{ 5, 5872, "", "=q3=Brown Ram", "=ds=#e12#"};
		{ 6, 5864, "", "=q3=Gray Ram", "=ds=#e12#"};
		{ 7, 5873, "", "=q3=White Ram", "=ds=#e12#"};
		{ 9, 0, "inv_misc_tournaments_symbol_draenei", "=q6="..BabbleFaction["Exodar"].." #j30#", "=ec1=#m7#"};
		{ 10, 29745, "", "=q4=Great Blue Elekk", "=ds=#e12#"};
		{ 11, 29746, "", "=q4=Great Green Elekk", "=ds=#e12#"};
		{ 12, 29747, "", "=q4=Great Purple Elekk", "=ds=#e12#"};
		{ 13, 28481, "", "=q3=Brown Elekk", "=ds=#e12#"};
		{ 14, 29744, "", "=q3=Gray Elekk", "=ds=#e12#"};
		{ 15, 29743, "", "=q3=Purple Elekk", "=ds=#e12#"};
		{ 16, 0, "inv_misc_tournaments_symbol_human", "=q6="..BabbleFaction["Stormwind"].." #j30#", "=ec1=#m7#"};
		{ 17, 18777, "", "=q4=Swift Brown Steed", "=ds=#e12#"};
		{ 18, 18776, "", "=q4=Swift Palomino", "=ds=#e12#"};
		{ 19, 18778, "", "=q4=Swift White Steed", "=ds=#e12#"};
		{ 20, 2411, "", "=q3=Black Stallion Bridle", "=ds=#e12#"};
		{ 21, 5656, "", "=q3=Brown Horse Bridle", "=ds=#e12#"};
		{ 22, 5655, "", "=q3=Chestnut Mare Bridle", "=ds=#e12#"};
		{ 23, 2414, "", "=q3=Pinto Bridle", "=ds=#e12#"};
		Prev = "MountsAlliance1";
		Next = "MountsAlliance3";
		Back = "MOUNTMENU";
	};

	AtlasLoot_Data["MountsAlliance3"] = {
		{ 1, 0, "INV_BannerPVP_02", "=q6="..AL["Alliance Flying Mounts"], "=ec1=#m7#"};
		{ 2, 25473, "", "=q4=Swift Blue Gryphon", "=ds=#e12#"};
		{ 3, 25528, "", "=q4=Swift Green Gryphon", "=ds=#e12#"};
		{ 4, 25529, "", "=q4=Swift Purple Gryphon", "=ds=#e12#"};
		{ 5, 25527, "", "=q4=Swift Red Gryphon", "=ds=#e12#"};
		{ 6, 25471, "", "=q3=Ebon Gryphon", "=ds=#e12#"};
		{ 7, 25470, "", "=q3=Golden Gryphon", "=ds=#e12#"};
		{ 8, 25472, "", "=q3=Snowy Gryphon", "=ds=#e12#"};
		{ 10, 44225, "", "=q4=Reins of the Armored Brown Bear", "=ds=#e12#"};
		{ 11, 44230, "", "=q4=Reins of the Wooly Mammoth", "=ds=#e12#"};
		{ 12, 44235, "", "=q4=Reins of the Traveler's Tundra Mammoth", "=ds=#e12#"};
		{ 13, 44689, "", "=q4=Armored Snowy Gryphon", "=ds=#e12#"};
		{ 16, 0, "INV_BannerPVP_02", "=q6="..BabbleFaction["Kurenai"].." #j30#", "=ec1=#m7#"};
		{ 17, 29227, "", "=q4=Reins of the Cobalt War Talbuk", "=ds=#e12#"};
		{ 18, 29229, "", "=q4=Reins of the Silver War Talbuk", "=ds=#e12#"};
		{ 19, 29230, "", "=q4=Reins of the Tan War Talbuk", "=ds=#e12#"};
		{ 20, 29231, "", "=q4=Reins of the White War Talbuk", "=ds=#e12#"};
		{ 21, 31830, "", "=q4=Reins of the Cobalt Riding Talbuk", "=ds=#e12#"};
		{ 22, 31832, "", "=q4=Reins of the Silver Riding Talbuk", "=ds=#e12#"};
		{ 23, 31834, "", "=q4=Reins of the Tan Riding Talbuk", "=ds=#e12#"};
		{ 24, 31836, "", "=q4=Reins of the White Riding Talbuk", "=ds=#e12#"};
		{ 26, 0, "INV_BannerPVP_02", "=q6="..BabbleFaction["Wintersaber Trainers"].." #j30#", "=ec1=#m7#"};
		{ 27, 13086, "", "=q4=Reins of the Winterspring Frostsaber", "=ds=#e12#"};
		{ 28, 0, "INV_BannerPVP_02", "=q6="..BabbleFaction["The Silver Covenant"].." #j30#", "=ec1=#m7#"};
		{ 29, 46815, "", "=q4=Quel'dorei Steed", "=ds=#e12#"};
		{ 30, 46813, "", "=q4=Silver Covenant Hippogryph", "=ds=#e12#"};
		Prev = "MountsAlliance2";
		Back = "MOUNTMENU";
	};

	AtlasLoot_Data["MountsHorde1"] = {
		{ 1, 0, "inv_misc_tournaments_symbol_orc", "=q6="..BabbleFaction["Orgrimmar"].." #j30#", "=ec1=#m6#"};
		{ 2, 18796, "", "=q4=Horn of the Swift Brown Wolf", "=ds=#e12#"};
		{ 3, 18798, "", "=q4=Horn of the Swift Gray Wolf", "=ds=#e12#"};
		{ 4, 18797, "", "=q4=Horn of the Swift Timber Wolf", "=ds=#e12#"};
		{ 5, 46099, "", "=q3=Horn of the Black Wolf", "=ds=#e12#"};
		{ 6, 5668, "", "=q3=Horn of the Brown Wolf", "=ds=#e12#"};
		{ 7, 5665, "", "=q3=Horn of the Dire Wolf", "=ds=#e12#"};
		{ 8, 1132, "", "=q3=Horn of the Timber Wolf", "=ds=#e12#"};
		{ 16, 0, "inv_misc_tournaments_symbol_bloodelf", "=q6="..BabbleFaction["Silvermoon City"].." #j30#", "=ec1=#m6#"};
		{ 17, 29223, "", "=q4=Swift Green Hawkstrider", "=ds=#e12#"};
		{ 18, 28936, "", "=q4=Swift Pink Hawkstrider", "=ds=#e12#"};
		{ 19, 29224, "", "=q4=Swift Purple Hawkstrider", "=ds=#e12#"};
		{ 20, 29221, "", "=q3=Black Hawkstrider", "=ds=#e12#"};
		{ 21, 29220, "", "=q3=Blue Hawkstrider", "=ds=#e12#"};
		{ 22, 29222, "", "=q3=Purple Hawkstrider", "=ds=#e12#"};
		{ 23, 28927, "", "=q3=Red Hawkstrider", "=ds=#e12#"};
		Next = "MountsHorde2";
		Back = "MOUNTMENU";
	};

	AtlasLoot_Data["MountsHorde2"] = {
		{ 1, 0, "inv_misc_tournaments_symbol_troll", "=q6="..BabbleFaction["Darkspear Trolls"].." #j30#", "=ec1=#m6#"};
		{ 2, 18788, "", "=q4=Swift Blue Raptor", "=ds=#e12#"};
		{ 3, 18789, "", "=q4=Swift Olive Raptor", "=ds=#e12#"};
		{ 4, 18790, "", "=q4=Swift Orange Raptor", "=ds=#e12#"};
		{ 5, 8588, "", "=q3=Whistle of the Emerald Raptor", "=ds=#e12#"};
		{ 6, 8591, "", "=q3=Whistle of the Turquoise Raptor", "=ds=#e12#"};
		{ 7, 8592, "", "=q3=Whistle of the Violet Raptor", "=ds=#e12#"};
		{ 9, 0, "inv_misc_tournaments_symbol_tauren", "=q6="..BabbleFaction["Thunder Bluff"].." #j30#", "=ec1=#m6#"};
		{ 10, 18794, "", "=q4=Great Brown Kodo", "=ds=#e12#"};
		{ 11, 18795, "", "=q4=Great Gray Kodo", "=ds=#e12#"};
		{ 12, 18793, "", "=q4=Great White Kodo", "=ds=#e12#"};
		{ 13, 15290, "", "=q3=Brown Kodo", "=ds=#e12#"};
		{ 14, 15277, "", "=q3=Gray Kodo", "=ds=#e12#"};
		{ 15, 46100, "", "=q3=White Kodo", "=ds=#e12#"};
		{ 16, 0, "inv_misc_tournaments_symbol_scourge", "=q6="..BabbleFaction["Undercity"].." #j30#", "=ec1=#m6#"};
		{ 17, 13334, "", "=q4=Green Skeletal Warhorse", "=ds=#e12#"};
		{ 18, 47101, "", "=q4=Ochre Skeletal Warhorse", "=ds=#e12#"};
		{ 19, 18791, "", "=q4=Purple Skeletal Warhorse", "=ds=#e12#"};
		{ 20, 46308, "", "=q3=Black Skeletal Horse", "=ds=#e12#"};
		{ 21, 13332, "", "=q3=Blue Skeletal Horse", "=ds=#e12#"};
		{ 22, 13333, "", "=q3=Brown Skeletal Horse", "=ds=#e12#"};
		{ 23, 13331, "", "=q3=Red Skeletal Horse", "=ds=#e12#"};
		Prev = "MountsHorde1";
		Next = "MountsHorde3";
		Back = "MOUNTMENU";
	};

	AtlasLoot_Data["MountsHorde3"] = {
		{ 1, 0, "INV_BannerPVP_01", "=q6="..AL["Horde Flying Mounts"], "=ec1=#m6#"};
		{ 2, 25531, "", "=q4=Swift Green Wind Rider", "=ds=#e12#"};
		{ 3, 25533, "", "=q4=Swift Purple Wind Rider", "=ds=#e12#"};
		{ 4, 25477, "", "=q4=Swift Red Wind Rider", "=ds=#e12#"};
		{ 5, 25532, "", "=q4=Swift Yellow Wind Rider", "=ds=#e12#"};
		{ 6, 25475, "", "=q3=Blue Wind Rider", "=ds=#e12#"};
		{ 7, 25476, "", "=q3=Green Wind Rider", "=ds=#e12#"};
		{ 8, 25474, "", "=q3=Tawny Wind Rider", "=ds=#e12#"};
		{ 10, 44226, "", "=q4=Reins of the Armored Brown Bear", "=ds=#e12#"};
		{ 11, 44231, "", "=q4=Reins of the Wooly Mammoth", "=ds=#e12#"};
		{ 12, 44234, "", "=q4=Reins of the Traveler's Tundra Mammoth", "=ds=#e12#"};
		{ 13, 44690, "", "=q4=Armored Blue Wind Rider", "=ds=#e12#"};
		{ 16, 0, "INV_BannerPVP_01", "=q6="..BabbleFaction["The Mag'har"].." #j30#", "=ec1=#m6#"};
		{ 17, 29102, "", "=q4=Reins of the Cobalt War Talbuk", "=ds=#e12#"};
		{ 18, 29104, "", "=q4=Reins of the Silver War Talbuk", "=ds=#e12#"};
		{ 19, 29105, "", "=q4=Reins of the Tan War Talbuk", "=ds=#e12#"};
		{ 20, 29103, "", "=q4=Reins of the White War Talbuk", "=ds=#e12#"};
		{ 21, 31829, "", "=q4=Reins of the Cobalt Riding Talbuk", "=ds=#e12#"};
		{ 22, 31831, "", "=q4=Reins of the Silver Riding Talbuk", "=ds=#e12#"};
		{ 23, 31833, "", "=q4=Reins of the Tan Riding Talbuk", "=ds=#e12#"};
		{ 24, 31835, "", "=q4=Reins of the White Riding Talbuk", "=ds=#e12#"};
		{ 26, 0, "INV_BannerPVP_02", "=q6=Ravasaur Trainers #j30#", "=ec1=#m7#"};
		{ 27, 46102, "", "=q4=Whistle of the Venomhide Ravasaur", "=ds=#e12#"};
		{ 28, 0, "INV_BannerPVP_02", "=q6="..BabbleFaction["The Sunreavers"].." #j30#", "=ec1=#m7#"};
		{ 29, 46816, "", "=q4=Sunreaver Hawkstrider", "=ds=#e12#"};
		{ 30, 46814, "", "=q4=Sunreaver Dragonhawk", "=ds=#e12#"};
		Prev = "MountsHorde2";
		Back = "MOUNTMENU";
	};

	AtlasLoot_Data["MountsFaction1"] = {
		{ 1, 0, "INV_Box_01", "=q6="..BabbleFaction["Netherwing"].." #j30#", ""};
		{ 2, 32858, "", "=q4=Reins of the Azure Netherwing Drake", "=ds=#e12#"};
		{ 3, 32859, "", "=q4=Reins of the Cobalt Netherwing Drake", "=ds=#e12#"};
		{ 4, 32857, "", "=q4=Reins of the Onyx Netherwing Drake", "=ds=#e12#"};
		{ 5, 32860, "", "=q4=Reins of the Purple Netherwing Drake", "=ds=#e12#"};
		{ 6, 32861, "", "=q4=Reins of the Veridian Netherwing Drake", "=ds=#e12#"};
		{ 7, 32862, "", "=q4=Reins of the Violet Netherwing Drake", "=ds=#e12#"};
		{ 9, 0, "INV_Box_01", "=q6="..BabbleFaction["Sha'tari Skyguard"].." #j30#", ""};
		{ 10, 32319, "", "=q4=Blue Riding Nether Ray", "=ds=#e12#"};
		{ 11, 32314, "", "=q4=Green Riding Nether Ray", "=ds=#e12#"};
		{ 12, 32317, "", "=q4=Red Riding Nether Ray", "=ds=#e12#"};
		{ 13, 32316, "", "=q4=Purple Riding Nether Ray", "=ds=#e12#"};
		{ 14, 32318, "", "=q4=Silver Riding Nether Ray", "=ds=#e12#"};
		{ 16, 0, "INV_Box_01", "=q6="..BabbleFaction["Cenarion Expedition"].." #j30#", ""};
		{ 17, 33999, "", "=q4=Cenarion War Hippogryph", "=ds=#e12#"};
		{ 19, 0, "INV_Box_01", "=q6="..BabbleFaction["The Sons of Hodir"].." #j30#", ""};
		{ 20, 43958, "", "=q4=Reins of the Ice Mammoth", "=ds=#e12# =ec1=#m7#"};
		{ 21, 44080, "", "=q4=Reins of the Ice Mammoth", "=ds=#e12# =ec1=#m6#"};
		{ 22, 43961, "", "=q4=Reins of the Grand Ice Mammoth", "=ds=#e12# =ec1=#m7#"};
		{ 23, 44086, "", "=q4=Reins of the Grand Ice Mammoth", "=ds=#e12# =ec1=#m6#"};
		{ 25, 0, "INV_Box_01", "=q6="..BabbleFaction["The Wyrmrest Accord"].." #j30#", ""};
		{ 26, 43955, "", "=q4=Reins of the Red Drake", "=ds=#e12#"};
		{ 28, 0, "INV_Box_01", "=q6="..BabbleFaction["The Oracles"].." #j30#", ""};
		{ 29, 44707, "", "=q4=Reins of the Green Proto-Drake", "=q2=#x38#", ""};
		Back = "MOUNTMENU";
	};

	AtlasLoot_Data["MountsPvP1"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Arena Reward"], ""};
		{ 2, 30609, "", "=q4=Swift Nether Drake", "=ds=#e12#"};
		{ 3, 34092, "", "=q4=Merciless Nether Drake", "=ds=#e12#"};
		{ 4, 37676, "", "=q4=Vengeful Nether Drake", "=ds=#e12#"};
		{ 5, 43516, "", "=q4=Brutal Nether Drake", "=ds=#e12#"};
		{ 6, 46171, "", "=q4=Deadly Gladiator's Frostwyrm", "=ds=#e12#"};
		{ 8, 0, "INV_Box_01", "=q6="..AL["Alliance PvP Mounts"], ""};
		{ 9, 29465, "", "=q4=Black Battlestrider", "=ds=#e12# =ec1=#m7#"};
		{ 10, 29467, "", "=q4=Black War Ram", "=ds=#e12# =ec1=#m7#"};
		{ 11, 29468, "", "=q4=Black War Steed Bridle", "=ds=#e12# =ec1=#m7#"};
		{ 12, 35906, "", "=q4=Reins of the Black War Elekk", "=ds=#e12# =ec1=#m7#"};
		{ 13, 29471, "", "=q4=Reins of the Black War Tiger", "=ds=#e12# =ec1=#m7#"};
		{ 14, 19030, "", "=q4=Stormpike Battle Charger", "=ds=#e12# =ec1=#m7#"};
		{ 15, 43956, "", "=q4=Reins of the Black War Mammoth", "=ds=#e12# =ec1=#m7#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["Halaa PvP Mounts"], ""};
		{ 17, 28915, "", "=q4=Reins of the Dark Riding Talbuk", "=ds=#e12#"};
		{ 18, 29228, "", "=q4=Reins of the Dark War Talbuk", "=ds=#e12#"};
		{ 23, 0, "INV_Box_01", "=q6="..AL["Horde PvP Mounts"], ""};
		{ 24, 29466, "", "=q4=Black War Kodo", "=ds=#e12# =ec1=#m6#"};
		{ 25, 29469, "", "=q4=Horn of the Black War Wolf", "=ds=#e12# =ec1=#m6#"};
		{ 26, 29470, "", "=q4=Red Skeletal Warhorse", "=ds=#e12# =ec1=#m6#"};
		{ 27, 34129, "", "=q4=Swift Warstrider", "=ds=#e12# =ec1=#m6#"};
		{ 28, 29472, "", "=q4=Whistle of the Black War Raptor", "=ds=#e12# =ec1=#m6#"};
		{ 29, 19029, "", "=q4=Horn of the Frostwolf Howler", "=ds=#e12# =ec1=#m6#"};
		{ 30, 44077, "", "=q4=Reins of the Black War Mammoth", "=ds=#e12# =ec1=#m6#"};
		Back = "MOUNTMENU";
	};

	AtlasLoot_Data["MountsRare1"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Dungeon/Raid"], ""};
		{ 2, 33809, "", "=q4=Amani War Bear", "=q2=#x33#, =q1=#z29#"};
		{ 3, 32458, "", "=q4=Ashes of Al'ar", "=q2=#n59#, =q1=#z19#"};
		{ 4, 49098, "", "=q4=Crusader's Black Warhorse", "=q2="..AL["A Tribute to Immortality"]..", =q1="..BabbleZone["Trial of the Crusader"], "", ""};
		{ 5, 49096, "", "=q4=Crusader's White Warhorse", "=q2="..AL["A Tribute to Immortality"]..", =q1="..BabbleZone["Trial of the Crusader"], "", ""};
		{ 6, 13335, "", "=q4=Deathcharger's Reins", "=q2=#n52#, =q1=#z6#", "", "0.10%"};
		{ 7, 30480, "", "=q4=Fiery Warhorse's Reins", "=q2=#n53#, =q1=#z12#", "", "0.25%"};
		{ 8, 50818, "", "=q4=Invincible's Reins", "=q2="..BabbleBoss["The Lich King"]..", =q1="..BabbleZone["Icecrown Citadel"], "", ""};
		{ 9, 45693, "", "=q4=Mimiron's Head", "=q2="..AL["Alone in the Darkness"]..", =q1="..BabbleZone["Ulduar"], "", ""};
		{ 10, 43986, "", "=q4=Reins of the Black Drake", "=q2=#n153#, =q1=#j37# #z38# #j46#", ""};
		{ 11, 43954, "", "=q4=Reins of the Twilight Drake", "=q2=#n153#, =q1=#j38# #z38# #j46#", ""};
		{ 12, 43953, "", "=q4=Reins of the Blue Drake", "=q2="..BabbleZone["The Oculus"], ""};
		{ 13, 43952, "", "=q4=Reins of the Azure Drake", "=q2=#n154#, =q1=#j38# #z39#", ""};
		{ 14, 44151, "", "=q4=Reins of the Blue Proto-Drake", "=q2=#n151#, =q1=#j47# #z35#", ""};
		{ 15, 43951, "", "=q4=Reins of the Bronze Drake", "=q2=#n152#, =q1=#j47# #z36#", ""};
		{ 17, 52200, "", "=q4=Reins of the Crimson Deathcharger", "=q2="..BabbleBoss["The Lich King"]..", =q1="..BabbleZone["Icecrown Citadel"], "", ""};
		{ 18, 44083, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m7#", "", ""};
		{ 19, 43959, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e12# =ec1=#m6#", "", ""};
		{ 20, 32768, "", "=q4=Reins of the Raven Lord", "=q2=#n58#, =q1=#z16#"};
		{ 21, 49046, "", "=q4=Swift Horde Wolf", "=q2="..AL["A Tribute to Insanity (50)"]..", =q1="..BabbleZone["Trial of the Crusader"], "", ""};--Horde
		{ 22, 49044, "", "=q4=Swift Alliance Steed", "=q2="..AL["A Tribute to Insanity (50)"]..", =q1="..BabbleZone["Trial of the Crusader"], "", ""};--Alliance
		{ 23, 35513, "", "=q4=Swift White Hawkstrider", "=q2=#n59#, =q1=#z30#"};
		{ 24, 19872, "", "=q4=Swift Razzashi Raptor", "=q2=#n33#, =q1=#z8#", "", "0.43%"};
		{ 25, 19902, "", "=q4=Swift Zulian Tiger", "=q2=#n28#, =q1=#z8#", "", " 0.70%"};
		Next = "MountsRare2";
		Back = "MOUNTMENU";
	};

	AtlasLoot_Data["MountsRare2"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Achievement Reward"], ""};
		{ 2, 44223, "", "=q4=Reins of the Black War Bear", "=ds=#e12# =ec1=#m7#"};
		{ 3, 44224, "", "=q4=Reins of the Black War Bear", "=ds=#e12# =ec1=#m6#"};
		{ 4, 44843, "", "=q4=Blue Dragonhawk Mount", "=ds=#e12# =ec1=#m7#"};
		{ 5, 44842, "", "=q4=Red Dragonhawk Mount", "=ds=#e12# =ec1=#m6#"};
		{ 6, 44178, "", "=q4=Reins of the Albino Drake", "=ds=#e12#"};
		{ 7, 44164, "", "=q4=Reins of the Black Proto-Drake", "=ds=#e12#"};
		{ 8, 45801, "", "=q4=Reins of the Ironbound Proto-Drake", "=ds=#e12#"};
		{ 9, 44175, "", "=q4=Reins of the Plagued Proto-Drake", "=ds=#e12#"};
		{ 10, 44160, "", "=q4=Reins of the Red Proto-Drake", "=ds=#e12#"};
		{ 11, 45802, "", "=q4=Reins of the Rusted Proto-Drake", "=ds=#e12#"};
		{ 12, 44177, "", "=q4=Reins of the Violet Proto-Drake", "=ds=#e12#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["Rare Mounts"], ""};
		{ 17, 44168, "", "=q4=Reins of the Time-Lost Proto-Drake", "=q2=#n155#, =q1=#z37#", ""};
		{ 18, 46109, "", "=q3=Sea Turtle", "=q2=#p24#", ""};
		{ 20, 21218, "", "=q3=Blue Qiraji Resonating Crystal", "=q2=#n11#, =q1=#z11#", "", "10.91%"};
		{ 21, 21323, "", "=q3=Green Qiraji Resonating Crystal", "=q2=#n11#, =q1=#z11#", "", "11.77%"};
		{ 22, 21321, "", "=q3=Red Qiraji Resonating Crystal", "=q2=#n11#, =q1=#z11#", "", "1.32%"};
		{ 23, 21324, "", "=q3=Yellow Qiraji Resonating Crystal", "=q2=#n11#, =q1=#z11#", "", "12.64%"};
		Prev = "MountsRare1";
		Back = "MOUNTMENU";
	};

	AtlasLoot_Data["MountsCraftQuestPromotion1"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Quest Reward"], ""};
		{ 2, 21176, "", "=q5=Black Qiraji Resonating Crystal", "=q2=#m4#"};
		{ 3, 43962, "", "=q4=Reins of the White Polar Bear", "=q2=#m4#: #x39#", ""};
		{ 5, 0, "INV_Box_01", "=q6="..AL["Crafted Mounts"], ""};
		{ 6, 54797, "", "=q4=Frosty Flying Carpet", "=q2=#p8#"};
		{ 7, 44558, "", "=q4=Magnificent Flying Carpet", "=q2=#p8#"};
		{ 8, 44413, "", "=q4=Mekgineer's Chopper", "=q2=#p5# =ec1=#m7#"};
		{ 9, 41508, "", "=q4=Mechano-hog", "=q2=#p5# =ec1=#m6#"};
		{ 10, 34061, "", "=q4=Turbo-Charged Flying Machine Control", "=q2=#p5#"};
		{ 11, 44554, "", "=q3=Flying Carpet", "=q2=#p8#"};
		{ 12, 34060, "", "=q3=Flying Machine Control", "=q2=#p5#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["Promotional Mounts"], ""};
		{ 17, 43599, "", "=q3=Big Blizzard Bear", "=ds=#e12#"};
		{ 18, 37719, "", "=q4=Swift Zhevra", "=ds=#e12#"};
		{ 19, 54860, "", "=q4=X-53 Touring Rocket", "=ds=#e12#"};
		{ 21, 0, "INV_Box_01", "=q6="..AL["Card Game Mounts"], ""};
		{ 22, 54068, "", "=q4=Wooly White Rhino ", "=q2=#m24#"};
		{ 23, 49282, "", "=q4=Big Battle Bear", "=q2=#m24#"};
		{ 24, 49290, "", "=q4=Magic Rooster Egg", "=q2=#m24#"};
		{ 25, 49284, "", "=q4=Reins of the Swift Spectral Tiger", "=q2=#m24#"};
		{ 26, 23720, "", "=q4=Riding Turtle", "=q2=#m24#"};
		{ 27, 49286, "", "=q4=X-51 Nether-Rocket X-TREME", "=q2=#m24#"};
		{ 28, 49283, "", "=q3=Reins of the Spectral Tiger", "=q2=#m24#"};
		{ 29, 49285, "", "=q3=X-51 Nether-Rocket", "=q2=#m24#"};
		Back = "MOUNTMENU";
	};

	AtlasLoot_Data["MountsEvent1"] = {
		{ 1, 0, "INV_BannerPVP_02", "=q6=#m7#", ""};
		{ 2, 45591, "", "=q4=Darnassian Nightsaber", "=ds=#e12#", "100 #champseal#"};
		{ 3, 45590, "", "=q4=Exodar Elekk", "=ds=#e12#", "100 #champseal#"};
		{ 4, 45589, "", "=q4=Gnomeregan Mechanostrider", "=ds=#e12#", "100 #champseal#"};
		{ 5, 45586, "", "=q4=Ironforge Ram", "=ds=#e12#", "100 #champseal#"};
		{ 6, 45125, "", "=q4=Stormwind Steed", "=ds=#e12#", "100 #champseal#"};
		{ 8, 46745, "", "=q4=Great Red Elekk", "=ds=#e12#", "500 #gold# 5 #champseal#"};
		{ 9, 46752, "", "=q4=Swift Gray Steed", "=ds=#e12#", "500 #gold# 5 #champseal#"};
		{ 10, 46744, "", "=q4=Swift Moonsaber", "=ds=#e12#", "500 #gold# 5 #champseal#"};
		{ 11, 46748, "", "=q4=Swift Violet Ram", "=ds=#e12#", "500 #gold# 5 #champseal#"};
		{ 12, 46747, "", "=q4=Turbostrider", "=ds=#e12#", "500 #gold# 5 #champseal#"};
		{ 14, 47179, "", "=q4=Argent Charger", "=ds=#e12#", "100 #champseal#"};
		{ 15, 47180, "", "=q4=Argent Warhorse", "=ds=#e12#", "100 #champseal#"};
		{ 16, 0, "INV_BannerPVP_01", "=q6=#m6#", ""};
		{ 17, 45593, "", "=q4=Darkspear Raptor", "=ds=#e12#", "100 #champseal#"};
		{ 18, 45597, "", "=q4=Forsaken Warhorse", "=ds=#e12#", "100 #champseal#"};
		{ 19, 45595, "", "=q4=Orgrimmar Wolf", "=ds=#e12#", "100 #champseal#"};
		{ 20, 45596, "", "=q4=Silvermoon Hawkstrider", "=ds=#e12#", "100 #champseal#"};
		{ 21, 45592, "", "=q4=Thunder Bluff Kodo", "=ds=#e12#", "100 #champseal#"};
		{ 23, 46750, "", "=q4=Great Golden Kodo", "=ds=#e12#", "500 #gold# 5 #champseal#"};
		{ 24, 46749, "", "=q4=Swift Burgundy Wolf", "=ds=#e12#", "500 #gold# 5 #champseal#"};
		{ 25, 46743, "", "=q4=Swift Purple Raptor", "=ds=#e12#", "500 #gold# 5 #champseal#"};
		{ 26, 46751, "", "=q4=Swift Red Hawkstrider", "=ds=#e12#", "500 #gold# 5 #champseal#"};
		{ 27, 46746, "", "=q4=White Skeletal Warhorse", "=ds=#e12#", "500 #gold# 5 #champseal#"};
		{ 29, 45725, "", "=q4=Argent Hippogryph", "=ds=#e12#", "150 #champseal#"};
		Next = "MountsEvent2";
		Back = "MOUNTMENU";
	};

	AtlasLoot_Data["MountsEvent2"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Brewfest"], ""};
		{ 2, 37828, "", "=q4=Great Brewfest Kodo", "=q2=#n150#"};
		{ 3, 33977, "", "=q4=Swift Brewfest Ram", "=q2=#n150#"};
		{ 4, 33976, "", "=q3=Brewfest Ram", "=ds=#e12#"};
		{ 6, 0, "INV_Box_01", "=q6="..AL["Hallow's End"], ""};
		{ 7, 37012, "", "=q4=The Horseman's Reins", "=q2=#n136#"};
		{ 8, 37011, "", "=q3=Magic Broom", "=q2=#n136#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["Love is in the Air"], ""};
		{ 17, 50250, "", "=q4=Big Love Rocket", "=ds=#e12#"};
		Prev = "MountsEvent1";
		Back = "MOUNTMENU";
	};

		-----------------------
		--- BoE World Epics ---
		-----------------------

	AtlasLoot_Data["WorldEpicsWrath1"] = {
		{ 1, 44309, "", "=q4=Sash of Jordan", "=ds=#s10#, #a1#"};
		{ 2, 44312, "", "=q4=Wapach's Spaulders of Solidarity", "=ds=#s3#, #a4#"};
		{ 3, 44308, "", "=q4=Signet of Edward the Odd", "=ds=#s13#"};
		{ 4, 37835, "", "=q4=Je'Tze's Bell", "=ds=#s14#"};
		{ 5, 37254, "", "=q4=Super Simian Sphere", "=ds=#s14#"};
		{ 16, 44310, "", "=q4=Namlak's Supernumerary Sticker", "=ds=#h1#, #w4#"};
		{ 17, 43613, "", "=q4=The Dusk Blade", "=ds=#h1#, #w4#"};
		{ 18, 44311, "", "=q4=Avool's Sword of Jin", "=ds=#h1#, #w10#"};
		{ 19, 43611, "", "=q4=Krol Cleaver", "=ds=#h1#, #w10#"};
		{ 20, 44313, "", "=q4=Zom's Crackling Bulwark", "=ds=#w8#"};
		{ 21, 43612, "", "=q4=Spineslicer", "=ds=#w11#"};
		Prev = "WorldEpics4";
		Back = "WORLDEPICS";
	};

		----------------------
		--- Heirloom Items ---
		----------------------

	AtlasLoot_Data["Heirloom"] = {
		{ 1, 42985, "", "=q7=Tattered Dreadmist Mantle", "=ds=#s3#, #a1#", "40 #eofheroism# / 60 #champseal#"};
		{ 2, 42984, "", "=q7=Preened Ironfeather Shoulders", "=ds=#s3#, #a2#", "40 #eofheroism# / 60 #champseal#"};
		{ 3, 42952, "", "=q7=Stained Shadowcraft Spaulders", "=ds=#s3#, #a2#", "40 #eofheroism# / 60 #champseal#"};
		{ 4, 42950, "", "=q7=Champion Herod's Shoulder", "=ds=#s3#, #a3#", "40 #eofheroism# / 60 #champseal#"};
		{ 5, 42951, "", "=q7=Mystical Pauldrons of Elements", "=ds=#s3#, #a3#", "40 #eofheroism# / 60 #champseal#"};
		{ 6, 42949, "", "=q7=Polished Spaulders of Valor", "=ds=#s3#, #a4#", "40 #eofheroism# / 60 #champseal#"};
		{ 8, 42992, "", "=q7=Discerning Eye of the Beast", "=ds=#s14#", "50 #eofheroism#  / 75 #champseal#"};
		{ 9, 42991, "", "=q7=Swift Hand of Justice", "=ds=#s14#", "50 #eofheroism#  / 75 #champseal#"};
		{ 11, 50255, "", "=q7=Dread Pirate Ring", "=ds=#s13#", ""};
		{ 13, 49177, "", "=q7=Tome of Cold Weather Flight", "=ds=", "1000 #gold#"};
		{ 16, 48691, "", "=q7=Tattered Dreadmist Robe", "=ds=#s5#, #a1#", "40 #eofheroism# / 60 #champseal#"};
		{ 17, 48687, "", "=q7=Preened Ironfeather Breastplate", "=ds=#s5#, #a2#", "40 #eofheroism# / 60 #champseal#"};
		{ 18, 48689, "", "=q7=Stained Shadowcraft Tunic", "=ds=#s5#, #a2#", "40 #eofheroism# / 60 #champseal#"};
		{ 19, 48677, "", "=q7=Champion's Deathdealer Breastplate", "=ds=#s5#, #a3#", "40 #eofheroism# / 60 #champseal#"};
		{ 20, 48683, "", "=q7=Mystical Vest of Elements", "=ds=#s5#, #a3#", "40 #eofheroism# / 60 #champseal#"};
		{ 21, 48685, "", "=q7=Polished Breastplate of Valor", "=ds=#s5#, #a4#", "40 #eofheroism# / 60 #champseal#"};
		{ 23, 42944, "", "=q7=Balanced Heartseeker", "=ds=#w4#, #h1#", "40 #eofheroism#  / 60 #champseal#"};
		{ 24, 42945, "", "=q7=Venerable Dal'Rend's Sacred Charge", "=ds=#w10#, #h3#", "40 #eofheroism#  / 60 #champseal#"};
		{ 25, 42943, "", "=q7=Bloodied Arcanite Reaper", "=ds=#w1#, #h2#", "65 #eofheroism#  / 95 #champseal#"};
		{ 26, 42948, "", "=q7=Devout Aurastone Hammer", "=ds=#w6#, #h3#", "50 #eofheroism#  / 75 #champseal#"};
		{ 27, 48716, "", "=q7=Venerable Mass of McGowan", "=ds=#w6#, #h1#", "40 #eofheroism#  / 75 #champseal#"};
		{ 28, 48718, "", "=q7=Repurposed Lava Dredger", "=ds=#w6#, #h2#", "65 #eofheroism#  / 95 #champseal#"};
		{ 29, 42947, "", "=q7=Dignified Headmaster's Charge", "=ds=#w9#", "65 #eofheroism#  / 95 #champseal#"};
		{ 30, 42946, "", "=q7=Charmed Ancient Bone Bow", "=ds=#w2#", "65 #eofheroism#  / 95 #champseal#"};
		Next = "Heirloom2";
		Back = "SETMENU";
	};

	AtlasLoot_Data["Heirloom2"] = {
		{ 1, 44107, "", "=q7=Exquisite Sunderseer Mantle", "=ds=#s3#, #a1#", "200 #wintergrasp#"};
		{ 2, 44103, "", "=q7=Exceptional Stormshroud Shoulders", "=ds=#s3#, #a2#", "200 #wintergrasp#"};
		{ 3, 44105, "", "=q7=Lasting Feralheart Spaulders", "=ds=#s3#, #a2#", "200 #wintergrasp#"};
		{ 4, 44102, "", "=q7=Aged Pauldrons of The Five Thunders", "=ds=#s3#, #a3#", "200 #wintergrasp#"};
		{ 5, 44101, "", "=q7=Prized Beastmaster's Mantle", "=ds=#s3#, #a3#", "200 #wintergrasp#"};
		{ 6, 44100, "", "=q7=Pristine Lightforge Spaulders", "=ds=#s3#, #a4#", "200 #wintergrasp#"};
		{ 7, 44099, "", "=q7=Strengthened Stockade Pauldrons", "=ds=#s3#, #a4#", "200 #wintergrasp#"};
		{ 9, 44098, "", "=q7=Inherited Insignia of the Alliance", "=ds=#s14#", "250 #wintergrasp#"};
		{ 10, 44097, "", "=q7=Inherited Insignia of the Horde", "=ds=#s14#", "250 #wintergrasp#"};
		{ 12, 44115, "", "=q7=Wintergrasp Commendation", "=ds=", "30 #wintergrasp# / 9 #wintergraspmark#"};
		{ 16, 44091, "", "=q7=Sharpened Scarlet Kris", "=ds=#h1#, #w4#", "200 #wintergrasp#"};
		{ 17, 44096, "", "=q7=Battleworn Thrash Blade", "=ds=#h1#, #w10#", "200 #wintergrasp#"};
		{ 18, 44092, "", "=q7=Reforged Truesilver Champion", "=ds=#h2#, #w10#", "325 #wintergrasp#"};
		{ 19, 44094, "", "=q7=The Blessed Hammer of Grace", "=ds=#h3#, #w6#", "250 #wintergrasp#"};
		{ 20, 44095, "", "=q7=Grand Staff of Jordan", "=ds=#w9#", "325 #wintergrasp#"};
		{ 21, 44093, "", "=q7=Upgraded Dwarven Hand Cannon", "=ds=#w5#", "325 #wintergrasp#"};
		Prev = "Heirloom";
		Back = "SETMENU";
	};

		-------------------------------
		--- Emblem of Heroism Items ---
		-------------------------------

	AtlasLoot_Data["EmblemofHeroism"] = {
		{ 1, 40697, "", "=q4=Elegant Temple Gardens' Girdle", "=ds=#s10#, #a1#", "40 #eofheroism#"};
		{ 2, 40696, "", "=q4=Plush Sash of Guzbah", "=ds=#s10#, #a1#", "40 #eofheroism#"};
		{ 3, 40694, "", "=q4=Jorach's Crocolisk Skin Belt", "=ds=#s10#, #a2#", "40 #eofheroism#"};
		{ 4, 40695, "", "=q4=Vine Belt of the Woodland Dryad", "=ds=#s10#, #a2#", "40 #eofheroism#"};
		{ 5, 40693, "", "=q4=Beadwork Belt of Shamanic Vision", "=ds=#s10#, #a3#", "40 #eofheroism#"};
		{ 6, 40692, "", "=q4=Vereesa's Silver Chain Belt", "=ds=#s10#, #a3#", "40 #eofheroism#"};
		{ 7, 40691, "", "=q4=Magroth's Meditative Cincture", "=ds=#s10#, #a4#", "40 #eofheroism#"};
		{ 8, 40688, "", "=q4=Verdungo's Barbarian Cord", "=ds=#s10#, #a4#", "40 #eofheroism#"};
		{ 9, 40689, "", "=q4=Waistguard of Living Iron", "=ds=#s10#, #a4#", "40 #eofheroism#"};
		{ 16, 40704, "", "=q4=Pride", "=ds=#w13#, #h4#", "50 #eofheroism#"};
		{ 17, 40702, "", "=q4=Rolfsen's Ripper", "=ds=#w4#, #h4#", "50 #eofheroism#"};
		{ 18, 40703, "", "=q4=Grasscutter", "=ds=#w10#, #h4#", "50 #eofheroism#"};
		{ 19, 40716, "", "=q4=Lillehoff's Winged Blades", "=ds=#w11#", "15 #eofheroism#"};
		{ 20, 40701, "", "=q4=Crygil's Discarded Plate Panel", "=ds=#w8#", "35 #eofheroism#"};
		{ 21, 40700, "", "=q4=Protective Barricade of the Light", "=ds=#w8#", "35 #eofheroism#"};
		{ 22, 40699, "", "=q4=Handbook of Obscure Remedies", "=ds=#s15#", "25 #eofheroism#"};
		{ 23, 40698, "", "=q4=Ward of the Violet Citadel", "=ds=#s15#", "25 #eofheroism#"};
		Next = "EmblemofHeroism2";
		Back = "EMBLEMOFHEROISMMENU";
	};

	AtlasLoot_Data["EmblemofHeroism2"] = {
		{ 1, 40711, "", "=q4=Idol of Lush Moss", "=ds=#w14#", "15 #eofheroism#"};
		{ 2, 40712, "", "=q4=Idol of Steadfast Renewal", "=ds=#w14#", "15 #eofheroism#"};
		{ 3, 40713, "", "=q4=Idol of the Ravenous Beast", "=ds=#w14#", "15 #eofheroism#"};
		{ 4, 40707, "", "=q4=Libram of Obstruction", "=ds=#w16#", "15 #eofheroism#"};
		{ 5, 40706, "", "=q4=Libram of Reciprocation", "=ds=#w16#", "15 #eofheroism#"};
		{ 6, 40705, "", "=q4=Libram of Renewal", "=ds=#w16#", "15 #eofheroism#"};
		{ 7, 40715, "", "=q4=Sigil of Haunted Dreams", "=ds=#w21#", "15 #eofheroism#"};
		{ 8, 40714, "", "=q4=Sigil of the Unfaltering Knight", "=ds=#w21#", "15 #eofheroism#"};
		{ 9, 40709, "", "=q4=Totem of Forest Growth", "=ds=#w15#", "15 #eofheroism#"};
		{ 10, 40710, "", "=q4=Totem of Splintering", "=ds=#w15#", "15 #eofheroism#"};
		{ 11, 40708, "", "=q4=Totem of the Elemental Plane", "=ds=#w15#", "15 #eofheroism#"};
		{ 16, 40679, "", "=q4=Chained Military Gorget", "=ds=#s2#", "25 #eofheroism#"};
		{ 17, 40680, "", "=q4=Encircling Burnished Gold Chains", "=ds=#s2#", "25 #eofheroism#"};
		{ 18, 40681, "", "=q4=Lattice Choker of Light", "=ds=#s2#", "25 #eofheroism#"};
		{ 19, 40678, "", "=q4=Pendant of the Outcast Hero", "=ds=#s2#", "25 #eofheroism#"};
		{ 20, 40684, "", "=q4=Mirror of Truth", "=ds=#s14#", "40 #eofheroism#"};
		{ 21, 40682, "", "=q4=Sundial of the Exiled", "=ds=#s14#", "40 #eofheroism#"};
		{ 22, 40685, "", "=q4=The Egg of Mortal Essence", "=ds=#s14#", "40 #eofheroism#"};
		{ 23, 40683, "", "=q4=Valor Medal of the First War", "=ds=#s14#", "40 #eofheroism#"};
		Prev = "EmblemofHeroism";
		Next = "EmblemofHeroism3";
		Back = "EMBLEMOFHEROISMMENU";
	};

	AtlasLoot_Data["EmblemofHeroism3"] = {
		{ 1, 40610, "", "=q4=Chestguard of the Lost Conqueror", "=ds=#e15#", "80 #eofheroism#"};
		{ 2, 40611, "", "=q4=Chestguard of the Lost Protector", "=ds=#e15#", "80 #eofheroism#"};
		{ 3, 40612, "", "=q4=Chestguard of the Lost Vanquisher", "=ds=#e15#", "80 #eofheroism#"};
		{ 5, 40613, "", "=q4=Gloves of the Lost Conqueror", "=ds=#e15#", "60 #eofheroism#"};
		{ 6, 40614, "", "=q4=Gloves of the Lost Protector", "=ds=#e15#", "60 #eofheroism#"};
		{ 7, 40615, "", "=q4=Gloves of the Lost Vanquisher", "=ds=#e15#", "60 #eofheroism#"};
		{ 9, 44230, "", "=q4=Reins of the Wooly Mammoth", "=ds=#e12# =ec1=#m7#", "200 #eofheroism#"};
		{ 10, 44231, "", "=q4=Reins of the Wooly Mammoth", "=ds=#e12# =ec1=#m6#", "200 #eofheroism#"};
		{ 16, 36919, "", "=q4=Cardinal Ruby", "=ds=#e7#", "20 #eofheroism#" };
		{ 17, 36922, "", "=q4=King's Amber", "=ds=#e7#", "20 #eofheroism#" };
		{ 18, 36925, "", "=q4=Majestic Zircon", "=ds=#e7#", "20 #eofheroism#" };
		{ 19, 36931, "", "=q4=Ametrine", "=ds=#e7#", "10 #eofheroism#" };
		{ 20, 36928, "", "=q4=Dreadstone", "=ds=#e7#", "10 #eofheroism#" };
		{ 21, 36934, "", "=q4=Eye of Zul", "=ds=#e7#", "10 #eofheroism#" };
		{ 23, 43102, "", "=q3=Frozen Orb", "=ds=#e6#", "10 #eofheroism#"};
		Prev = "EmblemofHeroism2";
		Next = "EmblemofHeroism4";
		Back = "EMBLEMOFHEROISMMENU";
	};

	AtlasLoot_Data["EmblemofHeroism4"] = {
		{ 1, 42985, "", "=q7=Tattered Dreadmist Mantle", "=ds=#s3#, #a1#", "40 #eofheroism#"};
		{ 2, 42984, "", "=q7=Preened Ironfeather Shoulders", "=ds=#s3#, #a2#", "40 #eofheroism#"};
		{ 3, 42952, "", "=q7=Stained Shadowcraft Spaulders", "=ds=#s3#, #a2#", "40 #eofheroism#"};
		{ 4, 42950, "", "=q7=Champion Herod's Shoulder", "=ds=#s3#, #a3#", "40 #eofheroism#"};
		{ 5, 42951, "", "=q7=Mystical Pauldrons of Elements", "=ds=#s3#, #a3#", "40 #eofheroism#"};
		{ 6, 42949, "", "=q7=Polished Spaulders of Valor", "=ds=#s3#, #a4#", "40 #eofheroism#"};
		{ 8, 48691, "", "=q7=Tattered Dreadmist Robe", "=ds=#s5#, #a1#", "40 #eofheroism#"};
		{ 9, 48687, "", "=q7=Preened Ironfeather Breastplate", "=ds=#s5#, #a2#", "40 #eofheroism#"};
		{ 10, 48689, "", "=q7=Stained Shadowcraft Tunic", "=ds=#s5#, #a2#", "40 #eofheroism#"};
		{ 11, 48677, "", "=q7=Champion's Deathdealer Breastplate", "=ds=#s5#, #a3#", "40 #eofheroism#"};
		{ 12, 48683, "", "=q7=Mystical Vest of Elements", "=ds=#s5#, #a3#", "40 #eofheroism#"};
		{ 13, 48685, "", "=q7=Polished Breastplate of Valor", "=ds=#s5#, #a4#", "40 #eofheroism#"};
		{ 16, 42992, "", "=q7=Discerning Eye of the Beast", "=ds=#s14#", "50 #eofheroism#"};
		{ 17, 42991, "", "=q7=Swift Hand of Justice", "=ds=#s14#", "50 #eofheroism#"};
		{ 19, 42944, "", "=q7=Balanced Heartseeker", "=ds=#w4#, #h1#", "40 #eofheroism#"};
		{ 20, 42945, "", "=q7=Venerable Dal'Rend's Sacred Charge", "=ds=#w10#, #h3#", "40 #eofheroism#"};
		{ 21, 42943, "", "=q7=Bloodied Arcanite Reaper", "=ds=#w1#, #h2#", "65 #eofheroism#"};
		{ 22, 42948, "", "=q7=Devout Aurastone Hammer", "=ds=#w6#, #h3#", "50 #eofheroism#"};
		{ 23, 48716, "", "=q7=Venerable Mass of McGowan", "=ds=#w6#, #h1#", "40 #eofheroism#"};
		{ 24, 48718, "", "=q7=Repurposed Lava Dredger", "=ds=#w6#, #h2#", "65 #eofheroism#"};
		{ 25, 42947, "", "=q7=Dignified Headmaster's Charge", "=ds=#w9#", "65 #eofheroism#"};
		{ 26, 42946, "", "=q7=Charmed Ancient Bone Bow", "=ds=#w2#", "65 #eofheroism#"};
		Prev = "EmblemofHeroism3";
		Back = "EMBLEMOFHEROISMMENU";
	};

		-----------------------------
		--- Emblem of Valor Items ---
		-----------------------------

	AtlasLoot_Data["EmblemofValor"] = {
		{ 1, 40724, "", "=q4=Cloak of Kea Feathers", "=ds=#s4#", "25 #eofvalor#"};
		{ 2, 40723, "", "=q4=Disguise of the Kumiho", "=ds=#s4#", "25 #eofvalor#"};
		{ 3, 40722, "", "=q4=Platinum Mesh Cloak", "=ds=#s4#", "25 #eofvalor#"};
		{ 4, 40721, "", "=q4=Hammerhead Sharkskin Cloak", "=ds=#s4#", "25 #eofvalor#"};
		{ 6, 40741, "", "=q4=Cuffs of the Shadow Ascendant", "=ds=#s8#, #a1#", "60 #eofvalor#"};
		{ 7, 40740, "", "=q4=Wraps of the Astral Traveler", "=ds=#s8#, #a1#", "60 #eofvalor#"};
		{ 8, 40751, "", "=q4=Slippers of the Holy Light", "=ds=#s12#, #a1#", "40 #eofvalor#"};
		{ 9, 40750, "", "=q4=Xintor's Expeditionary Boots", "=ds=#s12#, #a1#", "40 #eofvalor#"};
		{ 11, 40739, "", "=q4=Bands of the Great Tree", "=ds=#s8#, #a2#", "60 #eofvalor#"};
		{ 12, 40738, "", "=q4=Wristwraps of the Cutthroat", "=ds=#s8#, #a2#", "60 #eofvalor#"};
		{ 13, 40748, "", "=q4=Boots of Captain Ellis", "=ds=#s12#, #a2#", "40 #eofvalor#"};
		{ 14, 40749, "", "=q4=Rainey's Chewed Boots", "=ds=#s12#, #a2#", "40 #eofvalor#"};
		{ 16, 40736, "", "=q4=Armguard of the Tower Archer", "=ds=#s8#, #a3#", "60 #eofvalor#"};
		{ 17, 40737, "", "=q4=Pigmented Clan Bindings", "=ds=#s8#, #a3#", "60 #eofvalor#"};
		{ 18, 40746, "", "=q4=Pack-Ice Striders", "=ds=#s12#, #a3#", "40 #eofvalor#"};
		{ 19, 40747, "", "=q4=Treads of Coastal Wandering", "=ds=#s12#, #a3#", "40 #eofvalor#"};
		{ 21, 40734, "", "=q4=Bracers of Dalaran's Parapets", "=ds=#s8#, #a4#", "60 #eofvalor#"};
		{ 22, 40733, "", "=q4=Wristbands of the Sentinel Huntress", "=ds=#s8#, #a4#", "60 #eofvalor#"};
		{ 23, 40735, "", "=q4=Zartson's Jungle Vambraces", "=ds=#s8#, #a4#", "60 #eofvalor#"};
		{ 24, 40742, "", "=q4=Bladed Steelboots", "=ds=#s12#, #a4#", "40 #eofvalor#"};
		{ 25, 40743, "", "=q4=Kyzoc's Ground Stompers", "=ds=#s12#, #a4#", "40 #eofvalor#"};
		{ 26, 40745, "", "=q4=Sabatons of Rapid Recovery", "=ds=#s12#, #a4#", "40 #eofvalor#"};
		Next = "EmblemofValor2";
		Back = "EMBLEMOFVALORMENU";
	};

	AtlasLoot_Data["EmblemofValor2"] = {
		{ 1, 40719, "", "=q4=Band of Channeled Magic", "=ds=#s13#", "25 #eofvalor#"};
		{ 2, 40720, "", "=q4=Renewal of Life", "=ds=#s13#", "25 #eofvalor#"};
		{ 3, 40717, "", "=q4=Ring of Invincibility", "=ds=#s13#", "25 #eofvalor#"};
		{ 4, 40718, "", "=q4=Signet of the Impregnable Fortress", "=ds=#s13#", "25 #eofvalor#"};
		{ 6, 40342, "", "=q4=Idol of Awakening", "=ds=#s16#, #w14#", "25 #eofvalor#" };
		{ 7, 40321, "", "=q4=Idol of the Shooting Star", "=ds=#s16#, #w14#", "25 #eofvalor#" };
		{ 8, 39757, "", "=q4=Idol of Worship", "=ds=#s16#, #w14#", "25 #eofvalor#" };
		{ 9, 40191, "", "=q4=Libram of Radiance", "=ds=#s16#, #w16#", "25 #eofvalor#" };
		{ 10, 40337, "", "=q4=Libram of Resurgence", "=ds=#s16#, #w16#", "25 #eofvalor#" };
		{ 11, 40268, "", "=q4=Libram of Tolerance", "=ds=#s16#, #w16#", "25 #eofvalor#" };
		{ 12, 40207, "", "=q4=Sigil of Awareness", "=ds=#s16#, #w21#", "25 #eofvalor#" };
		{ 13, 40322, "", "=q4=Totem of Dueling", "=ds=#s16#, #w15#", "25 #eofvalor#" };
		{ 14, 40267, "", "=q4=Totem of Hex", "=ds=#s16#, #w15#", "25 #eofvalor#" };
		{ 15, 39728, "", "=q4=Totem of Misery", "=ds=#s16#, #w15#", "25 #eofvalor#" };
		{ 16, 40637, "", "=q4=Mantle of the Lost Conqueror", "=ds=#e15#", "60 #eofvalor#"};
		{ 17, 40638, "", "=q4=Mantle of the Lost Protector", "=ds=#e15#", "60 #eofvalor#"};
		{ 18, 40639, "", "=q4=Mantle of the Lost Vanquisher", "=ds=#e15#", "60 #eofvalor#"};
		{ 20, 40634, "", "=q4=Legplates of the Lost Conqueror", "=ds=#e15#", "75 #eofvalor#"};
		{ 21, 40635, "", "=q4=Legplates of the Lost Protector", "=ds=#e15#", "75 #eofvalor#"};
		{ 22, 40636, "", "=q4=Legplates of the Lost Vanquisher", "=ds=#e15#", "75 #eofvalor#"};
		{ 24, 40752, "", "=q4=Emblem of Heroism", "=ds=#m17#", "1 #eofvalor#" };
		Prev = "EmblemofValor";
		Back = "EMBLEMOFVALORMENU";
	};

		--------------------------------
		--- Emblem of Conquest Items ---
		--------------------------------

	AtlasLoot_Data["EmblemofConquest1"] = {
		{ 1, 45840, "", "=q4=Touch of the Occult", "=ds=#s9#, #a1#", "28 #eofconquest#" };
		{ 2, 45831, "", "=q4=Sash of Potent Incantations", "=ds=#s10#, #a1#", "28 #eofconquest#" };
		{ 3, 45848, "", "=q4=Legwraps of the Master Conjurer", "=ds=#s11#, #a1#", "39 #eofconquest#" };
		{ 5, 45833, "", "=q4=Bladebreaker Gauntlets", "=ds=#s9#, #a4#", "28 #eofconquest#" };
		{ 6, 45835, "", "=q4=Gauntlets of Serene Blessing", "=ds=#s9#, #a4#", "28 #eofconquest#" };
		{ 7, 45834, "", "=q4=Gauntlets of the Royal Watch", "=ds=#s9#, #a4#", "28 #eofconquest#" };
		{ 8, 45824, "", "=q4=Belt of the Singing Blade", "=ds=#s10#, #a4#", "28 #eofconquest#" };
		{ 9, 45826, "", "=q4=Girdle of Unyielding Trust", "=ds=#s10#, #a4#", "28 #eofconquest#" };
		{ 10, 45825, "", "=q4=Shieldwarder Girdle", "=ds=#s10#, #a4#", "28 #eofconquest#" };
		{ 11, 45843, "", "=q4=Legguards of the Peaceful Covenant", "=ds=#s11#, #a4#", "39 #eofconquest#" };
		{ 12, 45841, "", "=q4=Legplates of the Violet Champion", "=ds=#s11#, #a4#", "39 #eofconquest#" };
		{ 13, 45842, "", "=q4=Wyrmguard Legplates", "=ds=#s11#, #a4#", "39 #eofconquest#" };
		{ 16, 45838, "", "=q4=Gloves of the Blind Stalker", "=ds=#s9#, #a2#", "28 #eofconquest#" };
		{ 17, 45839, "", "=q4=Grips of the Secret Grove", "=ds=#s9#, #a2#", "28 #eofconquest#" };
		{ 18, 45830, "", "=q4=Belt of the Living Thicket", "=ds=#s10#, #a2#", "28 #eofconquest#" };
		{ 19, 45829, "", "=q4=Belt of the Twilight Assassin", "=ds=#s10#, #a2#", "28 #eofconquest#" };
		{ 20, 45846, "", "=q4=Leggings of Wavering Shadow", "=ds=#s11#, #a2#", "39 #eofconquest#" };
		{ 21, 45847, "", "=q4=Wildstrider Legguards", "=ds=#s11#, #a2#", "39 #eofconquest#" };
		{ 23, 45837, "", "=q4=Gloves of Augury", "=ds=#s9#, #a3#", "28 #eofconquest#" };
		{ 24, 45836, "", "=q4=Gloves of Unerring Aim", "=ds=#s9#, #a3#", "28 #eofconquest#" };
		{ 25, 45827, "", "=q4=Belt of the Ardent Marksman", "=ds=#s10#, #a3#", "28 #eofconquest#" };
		{ 26, 45828, "", "=q4=Windchill Binding", "=ds=#s10#, #a3#", "28 #eofconquest#" };
		{ 27, 45844, "", "=q4=Leggings of the Tireless Sentry", "=ds=#s11#, #a3#", "39 #eofconquest#" };
		{ 28, 45845, "", "=q4=Leggings of the Weary Mystic", "=ds=#s11#, #a3#", "39 #eofconquest#" };
		Next = "EmblemofConquest2";
		Back = "EMBLEMOFCONQUESTMENU";
	};

	AtlasLoot_Data["EmblemofConquest2"] = {
		{ 1, 45820, "", "=q4=Broach of the Wailing Night", "=ds=#s2#", "19 #eofconquest#" };
		{ 2, 45822, "", "=q4=Evoker's Charm", "=ds=#s2#", "19 #eofconquest#" };
		{ 3, 45823, "", "=q4=Frozen Tear of Elune", "=ds=#s2#", "19 #eofconquest#" };
		{ 4, 45821, "", "=q4=Shard of the Crystal Forest", "=ds=#s2#", "19 #eofconquest#" };
		{ 5, 45819, "", "=q4=Spiked Battleguard Choker", "=ds=#s2#", "19 #eofconquest#" };
		{ 7, 45638, "", "=q4=Crown of the Wayward Conqueror", "=ds=", "58 #eofconquest#" };
		{ 8, 45639, "", "=q4=Crown of the Wayward Protector", "=ds=", "58 #eofconquest#" };
		{ 9, 45640, "", "=q4=Crown of the Wayward Vanquisher", "=ds=", "58 #eofconquest#" };
		{ 11, 45632, "", "=q4=Breastplate of the Wayward Conqueror", "=ds=", "58 #eofconquest#" };
		{ 12, 45633, "", "=q4=Breastplate of the Wayward Protector", "=ds=", "58 #eofconquest#" };
		{ 13, 45634, "", "=q4=Breastplate of the Wayward Vanquisher", "=ds=", "58 #eofconquest#" };
		{ 16, 45509, "", "=q4=Idol of the Corruptor", "=ds=#s16#, #w14#", "19 #eofconquest#" };
		{ 17, 45270, "", "=q4=Idol of the Crying Wind", "=ds=#s16#, #w14#", "19 #eofconquest#" };
		{ 18, 46138, "", "=q4=Idol of the Flourishing Life", "=ds=#s16#, #w14#", "19 #eofconquest#" };
		{ 19, 45510, "", "=q4=Libram of Discord", "=ds=#s16#, #w16#", "19 #eofconquest#" };
		{ 20, 45436, "", "=q4=Libram of the Resolute", "=ds=#s16#, #w16#", "19 #eofconquest#" };
		{ 21, 45145, "", "=q4=Libram of the Sacred Shield", "=ds=#s16#, #w16#", "19 #eofconquest#" };
		{ 22, 45144, "", "=q4=Sigil of Deflection", "=ds=#s16#, #w21#", "19 #eofconquest#" };
		{ 23, 45254, "", "=q4=Sigil of the Vengeful Heart", "=ds=#s16#, #w21#", "19 #eofconquest#" };
		{ 24, 45114, "", "=q4=Steamcaller's Totem", "=ds=#s16#, #w15#", "19 #eofconquest#" };
		{ 25, 45255, "", "=q4=Thunderfall Totem", "=ds=#s16#, #w15#", "19 #eofconquest#" };
		{ 26, 45169, "", "=q4=Totem of the Dancing Flame", "=ds=#s16#, #w15#", "19 #eofconquest#" };
		{ 28, 40753, "", "=q4=Emblem of Valor", "=ds=#m17#", "1 #eofconquest#" };
		{ 29, 45087, "", "=q3=Runed Orb", "=ds=#e6#", "18 #eofconquest#" };
		Prev = "EmblemofConquest1";
		Back = "EMBLEMOFCONQUESTMENU";
	};

		-------------------------------
		--- Emblem of Triumph Items ---
		-------------------------------

	AtlasLoot_Data["EmblemofTriumph1_A"] = {
		{ 2, 47694, "", "=q4=Helm of Clouded Sight", "=ds=#s1#, #a1#", "75 #eoftriumph#" };
		{ 3, 47693, "", "=q4=Hood of Fiery Aftermath", "=ds=#s1#, #a1#", "75 #eoftriumph#" };
		{ 4, 47713, "", "=q4=Mantle of Catastrophic Emanation", "=ds=#s3#, #a1#", "45 #eoftriumph#" };
		{ 5, 47715, "", "=q4=Pauldrons of Revered Mortality", "=ds=#s3#, #a1#", "45 #eoftriumph#" };
		{ 7, 47690, "", "=q4=Helm of Abundant Growth", "=ds=#s1#, #a2#", "75 #eoftriumph#" };
		{ 8, 47689, "", "=q4=Hood of Lethal Intent", "=ds=#s1#, #a2#", "75 #eoftriumph#" };
		{ 9, 47708, "", "=q4=Duskstalker Shoulderpads", "=ds=#s3#, #a2#", "45 #eoftriumph#" };
		{ 10, 47712, "", "=q4=Shoulders of the Fateful Accord", "=ds=#s3#, #a2#", "45 #eoftriumph#" };
		{ 17, 47686, "", "=q4=Helm of Inner Warmth", "=ds=#s1#, #a3#", "75 #eoftriumph#" };
		{ 18, 47685, "", "=q4=Helm of the Brooding Dragon", "=ds=#s1#, #a3#", "75 #eoftriumph#" };
		{ 19, 47704, "", "=q4=Epaulets of the Devourer", "=ds=#s3#, #a3#", "45 #eoftriumph#" };
		{ 20, 47707, "", "=q4=Mantle of the Groundbreaker", "=ds=#s3#, #a3#", "45 #eoftriumph#" };
		{ 22, 47677, "", "=q4=Faceplate of the Honorbound", "=ds=#s1#, #a4#", "75 #eoftriumph#" };
		{ 23, 47681, "", "=q4=Heaume of the Restless Watch", "=ds=#s1#, #a4#", "75 #eoftriumph#" };
		{ 24, 47674, "", "=q4=Helm of Thunderous Rampage", "=ds=#s1#, #a4#", "75 #eoftriumph#" };
		{ 25, 47702, "", "=q4=Pauldrons of the Cavalier", "=ds=#s3#, #a4#", "45 #eoftriumph#" };
		{ 26, 47697, "", "=q4=Pauldrons of Trembling Rage", "=ds=#s3#, #a4#", "45 #eoftriumph#" };
		{ 27, 47698, "", "=q4=Shoulderplates of Enduring Order", "=ds=#s3#, #a4#", "45 #eoftriumph#" };
		Next = "EmblemofTriumph2";
		Back = "EMBLEMOFTRIUMPHMENU";
	};

	AtlasLoot_Data["EmblemofTriumph1_H"] = {
		{ 2, 47695, "", "=q4=Hood of Clouded Sight", "=ds=#s1#, #a1#", "75 #eoftriumph#" };
		{ 3, 47692, "", "=q4=Hood of Smoldering Aftermath", "=ds=#s1#, #a1#", "75 #eoftriumph#" };
		{ 4, 47714, "", "=q4=Pauldrons of Catastrophic Emanation", "=ds=#s3#, #a1#", "45 #eoftriumph#" };
		{ 5, 47716, "", "=q4=Mantle of Revered Mortality", "=ds=#s3#, #a1#", "45 #eoftriumph#" };
		{ 7, 47691, "", "=q4=Mask of Abundant Growth", "=ds=#s1#, #a2#", "75 #eoftriumph#" };
		{ 8, 47688, "", "=q4=Mask of Lethal Intent", "=ds=#s1#, #a2#", "75 #eoftriumph#" };
		{ 9, 47709, "", "=q4=Duskstalker Pauldrons", "=ds=#s3#, #a2#", "45 #eoftriumph#" };
		{ 10, 47710, "", "=q4=Epaulets of the Fateful Accord", "=ds=#s3#, #a2#", "45 #eoftriumph#" };
		{ 17, 47687, "", "=q4=Headguard of Inner Warmth", "=ds=#s1#, #a3#", "75 #eoftriumph#" };
		{ 18, 47684, "", "=q4=Coif of the Brooding Dragon", "=ds=#s1#, #a3#", "75 #eoftriumph#" };
		{ 19, 47705, "", "=q4=Pauldrons of the Devourer", "=ds=#s3#, #a3#", "45 #eoftriumph#" };
		{ 20, 47706, "", "=q4=Shoulders of the Groundbreaker", "=ds=#s3#, #a3#", "45 #eoftriumph#" };
		{ 22, 47678, "", "=q4=Headplate of the Honorbound", "=ds=#s1#, #a4#", "75 #eoftriumph#" };
		{ 23, 47682, "", "=q4=Helm of the Restless Watch", "=ds=#s1#, #a4#", "75 #eoftriumph#" };
		{ 24, 47675, "", "=q4=Faceplate of Thunderous Rampage", "=ds=#s1#, #a4#", "75 #eoftriumph#" };
		{ 25, 47701, "", "=q4=Shoulderplates of the Cavalier", "=ds=#s3#, #a4#", "45 #eoftriumph#" };
		{ 26, 47696, "", "=q4=Shoulderplates of Trembling Rage", "=ds=#s3#, #a4#", "45 #eoftriumph#" };
		{ 27, 47699, "", "=q4=Shoulderguards of Enduring Order", "=ds=#s3#, #a4#", "45 #eoftriumph#" };
		Next = "EmblemofTriumph2";
		Back = "EMBLEMOFTRIUMPHMENU";
	};

	AtlasLoot_Data["EmblemofTriumph2"] = {
		{ 1, 47732, "", "=q4=Band of the Invoker", "=ds=#s13#", "35 #eoftriumph#" };
		{ 2, 47729, "", "=q4=Bloodshed Band", "=ds=#s13#", "35 #eoftriumph#" };
		{ 3, 47731, "", "=q4=Clutch of Fortification", "=ds=#s13#", "35 #eoftriumph#" };
		{ 4, 47730, "", "=q4=Dexterous Brightstone Ring", "=ds=#s13#", "35 #eoftriumph#" };
		{ 5, 47733, "", "=q4=Heartmender Circle", "=ds=#s13#", "35 #eoftriumph#" };
		{ 7, 47735, "", "=q4=Glyph of Indomitability", "=ds=#s14#", "50 #eoftriumph#" };
		{ 8, 47734, "", "=q4=Mark of Supremacy", "=ds=#s14#", "50 #eoftriumph#" };
		{ 9, 48722, "", "=q4=Shard of the Crystal Heart", "=ds=#s14#", "50 #eoftriumph#" };
		{ 10, 48724, "", "=q4=Talisman of Resurgence", "=ds=#s14#", "50 #eoftriumph#" };
		{ 12, 47556, "", "=q3=Crusader Orb", "=ds=#e6#", "15 #eoftriumph#"};
		{ 16, 47671, "", "=q4=Idol of Flaring Growth", "=ds=#s16#, #w14#", "25 #eoftriumph#" };
		{ 17, 47670, "", "=q4=Idol of Lunar Fury", "=ds=#s16#, #w14#", "25 #eoftriumph#" };
		{ 18, 47668, "", "=q4=Idol of Mutilation", "=ds=#s16#, #w14#", "25 #eoftriumph#" };
		{ 19, 47664, "", "=q4=Libram of Defiance", "=ds=#s16#, #w16#", "25 #eoftriumph#" };
		{ 20, 47661, "", "=q4=Libram of Valiance", "=ds=#s16#, #w16#", "25 #eoftriumph#" };
		{ 21, 47662, "", "=q4=Libram of Veracity", "=ds=#s16#, #w16#", "25 #eoftriumph#" };
		{ 22, 47672, "", "=q4=Sigil of Insolence", "=ds=#s16#, #w21#", "25 #eoftriumph#" };
		{ 23, 47673, "", "=q4=Sigil of Virulence", "=ds=#s16#, #w21#", "25 #eoftriumph#" };
		{ 24, 47665, "", "=q4=Totem of Calming Tides", "=ds=#s16#, #w15#", "25 #eoftriumph#" };
		{ 25, 47666, "", "=q4=Totem of Electrifying Wind", "=ds=#s16#, #w15#", "25 #eoftriumph#" };
		{ 26, 47667, "", "=q4=Totem of Quaking Earth", "=ds=#s16#, #w15#", "25 #eoftriumph#" };
		{ 28, 47659, "", "=q4=Crimson Star", "=ds=#w11#", "25 #eoftriumph#" };
		{ 29, 47660, "", "=q4=Blades of the Sable Cross", "=ds=#w11#", "25 #eoftriumph#" };
		{ 30, 47658, "", "=q4=Brimstone Igniter", "=ds=#w12#", "25 #eoftriumph#" };
		Prev = "EmblemofTriumph1_A";
		Back = "EMBLEMOFTRIUMPHMENU";
	};

		-----------------------------
		--- Emblem of Frost Items ---
		-----------------------------

	AtlasLoot_Data["EmblemofFrost"] = {
		{ 1, 50975, "", "=q4=Ermine Coronation Robes", "=ds=#s5#, #a1#", "95 #eoffrost#" };
		{ 2, 50974, "", "=q4=Meteor Chaser's Raiment", "=ds=#s5#, #a1#", "95 #eoffrost#" };
		{ 3, 50984, "", "=q4=Gloves of Ambivalence", "=ds=#s9#, #a1#", "60 #eoffrost#" };
		{ 4, 50983, "", "=q4=Gloves of False Gestures", "=ds=#s9#, #a1#", "60 #eoffrost#" };
		{ 5, 50996, "", "=q4=Belt of Omission", "=ds=#s10#, #a1#", "60 #eoffrost#" };
		{ 6, 50997, "", "=q4=Circle of Ossus", "=ds=#s10#, #a1#", "60 #eoffrost#" };
		{ 8, 50972, "", "=q4=Shadow Seeker's Tunic", "=ds=#s5#, #a2#", "95 #eoffrost#" };
		{ 9, 50973, "", "=q4=Vestments of Spruce and Fir", "=ds=#s5#, #a2#", "95 #eoffrost#" };
		{ 10, 50982, "", "=q4=Cat Burglar's Grips", "=ds=#s9#, #a2#", "60 #eoffrost#" };
		{ 11, 50981, "", "=q4=Gloves of the Great Horned Owl", "=ds=#s9#, #a2#", "60 #eoffrost#" };
		{ 12, 50994, "", "=q4=Belt of Petrified Ivy", "=ds=#s10#, #a2#", "60 #eoffrost#" };
		{ 13, 50995, "", "=q4=Vengeful Noose", "=ds=#s10#, #a2#", "60 #eoffrost#" };
		{ 16, 50970, "", "=q4=Longstrider's Vest", "=ds=#s5#, #a3#", "95 #eoffrost#" };
		{ 17, 50971, "", "=q4=Mail of the Geyser", "=ds=#s5#, #a3#", "95 #eoffrost#" };
		{ 18, 50980, "", "=q4=Blizzard Keeper's Mitts", "=ds=#s9#, #a3#", "60 #eoffrost#" };
		{ 19, 50979, "", "=q4=Logsplitters", "=ds=#s9#, #a3#", "60 #eoffrost#" };
		{ 20, 50993, "", "=q4=Band of the Night Raven", "=ds=#s10#, #a3#", "60 #eoffrost#" };
		{ 21, 50992, "", "=q4=Waistband of Despair", "=ds=#s10#, #a3#", "60 #eoffrost#" };
		{ 22, 50965, "", "=q4=Castle Breaker's Battleplate", "=ds=#s5#, #a4#", "95 #eoffrost#" };
		{ 23, 50969, "", "=q4=Chestplate of Unspoken Truths", "=ds=#s5#, #a4#", "95 #eoffrost#" };
		{ 24, 50968, "", "=q4=Cataclysmic Chestguard", "=ds=#s5#, #a4#", "95 #eoffrost#" };
		{ 25, 50977, "", "=q4=Gatecrasher's Gauntlets", "=ds=#s9#, #a4#", "60 #eoffrost#" };
		{ 26, 50976, "", "=q4=Gauntlets of Overexposure", "=ds=#s9#, #a4#", "60 #eoffrost#" };
		{ 27, 50978, "", "=q4=Gauntlets of the Kraken", "=ds=#s9#, #a4#", "60 #eoffrost#" };
		{ 28, 50989, "", "=q4=Lich Killer's Lanyard", "=ds=#s10#, #a4#", "60 #eoffrost#" };
		{ 29, 50987, "", "=q4=Malevolant Girdle", "=ds=#s10#, #a4#", "60 #eoffrost#" };
		{ 30, 50991, "", "=q4=Verdigris Chain Belt", "=ds=#s10#, #a4#", "60 #eoffrost#" };
		Next = "EmblemofFrost2";
		Back = "SETMENU";
	};

	AtlasLoot_Data["EmblemofFrost2"] = {
		{ 1, 50468, "", "=q4=Drape of the Violet Tower", "=ds=#s4#", "50 #eoffrost#" };
		{ 2, 50467, "", "=q4=Might of the Ocean Serpent", "=ds=#s4#", "50 #eoffrost#" };
		{ 3, 50470, "", "=q4=Recovered Scarlet Onslaught Cape", "=ds=#s4#", "50 #eoffrost#" };
		{ 4, 50466, "", "=q4=Sentinel's Winter Cloak", "=ds=#s4#", "50 #eoffrost#" };
		{ 5, 50469, "", "=q4=Volde's Cloak of the Night Sky", "=ds=#s4#", "50 #eoffrost#" };
		{ 7, 50356, "", "=q4=Corroded Skeleton Key", "=ds=#s14#", "60 #eoffrost#" };
		{ 8, 50355, "", "=q4=Herkuml War Token", "=ds=#s14#", "60 #eoffrost#" };
		{ 9, 50357, "", "=q4=Maghia's Misguided Quill", "=ds=#s14#", "60 #eoffrost#" };
		{ 10, 50358, "", "=q4=Purified Lunar Dust", "=ds=#s14#", "60 #eoffrost#" };
		{ 12, 49908, "", "=q3=Primordial Saronite", "=ds=#e6#", "23 #eoffrost#" };
		{ 14, 47241, "", "=q4=Emblem of Triumph", "=ds=#m17#", "1 #eoffrost#" };
		{ 16, 50456, "", "=q4=Idol of the Crying Moon", "=ds=#s16#, #w14#", "30 #eoffrost#" };
		{ 17, 50457, "", "=q4=Idol of the Lunar Eclipse", "=ds=#s16#, #w14#", "30 #eoffrost#" };
		{ 18, 50454, "", "=q4=Idol of the Black Willow", "=ds=#s16#, #w14#", "30 #eoffrost#" };
		{ 19, 50460, "", "=q4=Libram of Blinding Light", "=ds=#s16#, #w16#", "30 #eoffrost#" };
		{ 20, 50461, "", "=q4=Libram of the Eternal Tower", "=ds=#s16#, #w16#", "30 #eoffrost#" };
		{ 21, 50455, "", "=q4=Libram of Three Truths", "=ds=#s16#, #w16#", "30 #eoffrost#" };
		{ 22, 50462, "", "=q4=Sigil of the Bone Gryphon", "=ds=#s16#, #w21#", "30 #eoffrost#" };
		{ 23, 50459, "", "=q4=Sigil of the Hanged Man", "=ds=#s16#, #w21#", "30 #eoffrost#" };
		{ 24, 50458, "", "=q4=Bizuri's Totem of Shattered Ice", "=ds=#s16#, #w15#", "30 #eoffrost#" };
		{ 25, 50463, "", "=q4=Totem of the Avalanche", "=ds=#s16#, #w15#", "30 #eoffrost#" };
		{ 26, 50464, "", "=q4=Totem of the Surging Sea", "=ds=#s16#, #w15#", "30 #eoffrost#" };
		{ 28, 50474, "", "=q4=Shrapnel Star", "=ds=#w11#", "30 #eoffrost#" };
		Prev = "EmblemofFrost";
		Back = "SETMENU";
	};