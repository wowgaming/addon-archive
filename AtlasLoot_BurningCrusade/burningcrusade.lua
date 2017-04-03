local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local BabbleBoss = AtlasLoot_GetLocaleLibBabble("LibBabble-Boss-3.0")
local BabbleZone = AtlasLoot_GetLocaleLibBabble("LibBabble-Zone-3.0")

-- Index
--- Dungeons & Raids
---- Keys
---- Auchindoun: Auchenai Crypts
---- Auchindoun: Mana-Tombs
---- Auchindoun: Sethekk Halls
---- Auchindoun: Shadow Labyrinth
---- Black Temple
---- Caverns of Time: Old Hillsbrad Foothills
---- Caverns of Time: The Black Morass
---- Caverns of Time: Hyjal Summit
---- Coilfang Reservoir: The Slave Pens
---- Coilfang Reservoir: The Steamvault
---- Coilfang Reservoir: The Underbog
---- Coilfang Reservoir: Serpentshrine Cavern
---- Gruul's Lair
---- Hellfire Citadel: Hellfire Ramparts
---- Hellfire Citadel: The Blood Furnace
---- Hellfire Citadel: The Shattered Halls
---- Hellfire Citadel: Magtheridon's Lair
---- Karazhan
---- Sunwell Isle: Magister's Terrace
---- Sunwell Isle: Sunwell Plateau
---- Tempest Keep: The Arcatraz
---- Tempest Keep: The Botanica
---- Tempest Keep: The Mechanar
---- Tempest Keep: The Eye
---- Zul'Aman
--- Factions
---- Ashtongue Deathsworn
---- Cenarion Expedition
---- Honor Hold
---- Keepers of Time
---- Kurenai
---- Lower City
---- Netherwing
---- Ogri'la
---- Sha'tari Skyguard
---- Shattered Sun Offensive
---- Sporeggar
---- The Aldor
---- The Consortium
---- The Mag'har
---- The Scale of the Sands
---- The Scryers
---- The Sha'tar
---- The Violet Eye
---- Thrallmar
---- Tranquillien
---- Misc
--- PvP
---- World PvP - Hellfire Peninsula: Hellfire Fortifications
---- World PvP - Nagrand: Halaa
---- World PvP - Terokkar Forest: Bone Wastes
---- World PvP - Zangarmarsh: Twin Spire Ruins
---- Rep-PvP Level 70 - Armor Sets
---- PvP Level 70 - Accessories
---- PvP Level 70 - Non Set Epics
---- Arena - Armor Sets
---- Arena Season 2 - Weapons
---- Arena Season 3 - Weapons
---- Arena Season 4 - Weapons
--- Sets & Collections
---- Dungeon 3 Sets (D3)
---- Tier 4/Tier 5/Tier 6
---- The Burning Crusade Sets
---- Badge of Justice Rewards
---- BoE World Epics
--- World Bosses

	------------------------
	--- Dungeons & Raids ---
	------------------------

		------------
		--- Keys ---
		------------

	AtlasLoot_Data["BCKeys"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 27991, "", "=q1=Shadow Labyrinth Key", "=ds=#e9#"};
		{ 3, 28395, "", "=q1=Shattered Halls Key", "=ds=#e9#"};
		{ 4, 31084, "", "=q1=Key to the Arcatraz", "=ds=#e9#"};
		{ 6, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 7, 30622, "", "=q1=Flamewrought Key", "=ds=#e9# =ec1=#m7#"};
		{ 8, 30637, "", "=q1=Flamewrought Key", "=ds=#e9# =ec1=#m6#"};
		{ 9, 30623, "", "=q1=Reservoir Key", "=ds=#e9#"};
		{ 10, 30633, "", "=q1=Auchenai Key", "=ds=#e9#"};
		{ 11, 30635, "", "=q1=Key of Time", "=ds=#e9#"};
		{ 12, 30634, "", "=q1=Warpforged Key", "=ds=#e9#"};
		{ 16, 0, "INV_Box_01", "=q6=#j2#", ""};
		{ 17, 24490, "", "=q1=The Master's Key", "=ds=#e9#"};
		{ 19, 0, "INV_Box_01", "=q6=#m20#", ""};
		{ 20, 32092, "", "=q3=The Eye of Haramad", "=ds=#m27#"};
		{ 21, 32449, "", "=q1=Essence-Infused Moonstone", "=ds=#m27#"};
	};

		-----------------------------------
		--- Auchindoun: Auchenai Crypts ---
		-----------------------------------

	AtlasLoot_Data["AuchCryptsShirrak"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 27410, "", "=q3=Collar of Command", "=ds=#s1#, #a1#", "", "13.00%"};
		{ 3, 27409, "", "=q3=Raven-Heart Headdress", "=ds=#s1#, #a2#", "", "11.18%"};
		{ 4, 27408, "", "=q3=Hope Bearer Helm", "=ds=#s1#, #a4#", "", "15.16%"};
		{ 5, 26055, "", "=q3=Oculus of the Hidden Eye", "=ds=#s14#", "", "15.16%"};
		{ 6, 25964, "", "=q3=Shaarde the Lesser", "=ds=#h1#, #w10#", "", "11.59%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30587, "", "=q4=Champion's Fire Opal", "=ds=#e7#", "", "11.67%"};
		{ 19, 30588, "", "=q4=Potent Fire Opal", "=ds=#e7#", "", "1.67%"};
		{ 20, 30586, "", "=q4=Seer's Chrysoprase", "=ds=#e7#", "", "11.67%"};
		{ 22, 27866, "", "=q3=Scintillating Headdress of Second Sight", "=ds=#s1#, #a1#", "", "15.00%"};
		{ 23, 27493, "", "=q3=Gloves of the Deadwatcher", "=ds=#s9#, #a1#", "", "10.87%"};
		{ 24, 27865, "", "=q3=Bracers of Shirrak", "=ds=#s8#, #a3#", "", "21.74%"};
		{ 25, 27845, "", "=q3=Magma Plume Boots", "=ds=#s12#, #a3#", "", "23.91%"};
		{ 26, 27847, "", "=q3=Fanblade Pauldrons", "=ds=#s3#, #a4#", "", "6.52%"};
		{ 27, 27846, "", "=q3=Claw of the Watcher", "=ds=#h3#, #w13#", "", "6.52%"};
		Next = "AuchCryptsExarch";
	};

	AtlasLoot_Data["AuchCryptsExarch"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 2, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 3, 29354, "", "=q4=Light-Touched Stole of Altruism", "=ds=#s4#", "", "6.67%"};
		{ 4, 29257, "", "=q4=Sash of Arcane Visions", "=ds=#s10#, #a1#", "", "6.67%"};
		{ 5, 29244, "", "=q4=Wave-Song Girdle", "=ds=#s10#, #a3#", "", "20.00%"};
		{ 7, 27867, "", "=q3=Boots of the Unjust", "=ds=#s12#, #a2#", "", "3.33%"};
		{ 8, 27871, "", "=q3=Maladaar's Blessed Chaplet", "=ds=#s2#", "", "18.33%"};
		{ 9, 27869, "", "=q3=Soulpriest's Ring of Resolve", "=ds=#s13#", "", "18.33%"};
		{ 10, 27523, "", "=q3=Exarch's Diamond Band", "=ds=#s13#", "", "13.33%"};
		{ 11, 27872, "", "=q3=The Harvester of Souls", "=ds=#h1#, #w1#", "", "11.67%"};
		{ 13, 33836, "", "=q1=The Exarch's Soul Gem", "=ds=#m3#", "", "100%"};
		{ 16, 30587, "", "=q4=Champion's Fire Opal", "=ds=#e7#", "", "11.67%"};
		{ 17, 30588, "", "=q4=Potent Fire Opal", "=ds=#e7#", "", "1.67%"};
		{ 18, 30586, "", "=q4=Seer's Chrysoprase", "=ds=#e7#", "", "11.67%"};
		{ 20, 27870, "", "=q3=Doomplate Legguards", "=ds=#s11#, #a4# (D3)", "", "3.33%"};
		{ 22, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 23, 27411, "", "=q3=Slippers of Serenity", "=ds=#s12#, #a1#", "", "8.14%"};
		{ 24, 27415, "", "=q3=Darkguard Face Mask", "=ds=#s1#, #a2#", "", "11.44%"};
		{ 25, 27414, "", "=q3=Mok'Nathal Beast-Mask", "=ds=#s1#, #a3#", "", "11.27%"};
		{ 26, 27413, "", "=q3=Ring of the Exarchs", "=ds=#s13#", "", "10.42%"};
		{ 27, 27416, "", "=q3=Fetish of the Fallen", "=ds=#s14#", "", "12.81%"};
		{ 28, 27412, "", "=q3=Ironstaff of Regeneration", "=ds=#w9#", "", "11.95%"};
		Prev = "AuchCryptsShirrak";
		Next = "AuchCryptsAvatar";
	};

	AtlasLoot_Data["AuchCryptsAvatar"] = {
		{ 1, 27878, "", "=q3=Auchenai Death Shroud", "=ds=#s4#", "", "4.41%"};
		{ 2, 28268, "", "=q3=Natural Mender's Wraps", "=ds=#s9#, #a2#", "", "3.94%"};
		{ 3, 27876, "", "=q3=Will of the Fallen Exarch", "=ds=#h3#, #w6#", "", "5.10%"};
		{ 4, 27937, "", "=q3=Sky Breaker", "=ds=#h3#, #w6#", "", "3.48%"};
		{ 5, 27877, "", "=q3=Draenic Wildstaff", "=ds=#w9#", "", "4.87%"};
		{ 7, 27797, "", "=q3=Wastewalker Shoulderpads", "=ds=#s3#, #a2# (D3)", "", "3.94%"};
		Prev = "AuchCryptsExarch";
	};

		------------------------------
		--- Auchindoun: Mana-Tombs ---
		------------------------------

	AtlasLoot_Data["AuchManaPandemonius"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 25941, "", "=q3=Boots of the Outlander", "=ds=#s12#, #a3#", "", "10.55%"};
		{ 3, 25942, "", "=q3=Faith Bearer's Gauntlets", "=ds=#s9#, #a4#", "", "11.41%"};
		{ 4, 25940, "", "=q3=Idol of the Claw", "=ds=#s16#, #w14#", "", "12.18%"};
		{ 5, 25943, "", "=q3=Creepjacker", "=ds=#h3#, #w13#", "", "14.22%"};
		{ 6, 28166, "", "=q3=Shield of the Void", "=ds=#w8#", "", "10.81%"};
		{ 7, 25939, "", "=q3=Voidfire Wand", "=ds=#w12#", "", "13.04%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30584, "", "=q4=Enscribed Fire Opal", "=ds=#e7#", "", "0.08%"};
		{ 19, 30585, "", "=q4=Glistening Fire Opal", "=ds=#e7#", "", "6.06%"};
		{ 20, 30583, "", "=q4=Timeless Chrysoprase", "=ds=#e7#", "", "9.09%"};
		{ 22, 27816, "", "=q3=Mindrage Pauldrons", "=ds=#s3#, #a1#", "", "13.95%"};
		{ 23, 27818, "", "=q3=Starry Robes of the Crescent", "=ds=#s5#, #a2#", "", "11.63%"};
		{ 24, 27813, "", "=q3=Boots of the Colossus", "=ds=#s12#, #a4#", "", "13.95%"};
		{ 25, 27815, "", "=q3=Totem of the Astral Winds", "=ds=#s16#, #w15#", "", "2.33%"};
		{ 26, 27814, "", "=q3=Twinblade of Mastery", "=ds=#h1#, #w4#", "", "6.98%"};
		{ 27, 27817, "", "=q3=Starbolt Longbow", "=ds=#w2#", "", "9.30%"};
		Next = "AuchManaTavarok";
	};

	AtlasLoot_Data["AuchManaTavarok"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 25945, "", "=q3=Cloak of Revival", "=ds=#s4#", "", "8.08%"};
		{ 3, 25946, "", "=q3=Nethershade Boots", "=ds=#s12#, #a2#", "", "11.62%"};
		{ 4, 25947, "", "=q3=Lightning-Rod Pauldrons", "=ds=#s3#, #a3#", "", "11.25%"};
		{ 5, 25952, "", "=q3=Scimitar of the Nexus-Stalkers", "=ds=#h1#, #w10#", "", "12.12%"};
		{ 6, 25944, "", "=q3=Shaarde the Greater", "=ds=#h2#, #w10#", "", "9.35%"};
		{ 7, 25950, "", "=q3=Staff of Polarities", "=ds=#w9#", "", "9.91%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30584, "", "=q4=Enscribed Fire Opal", "=ds=#e7#", "", "0.08%"};
		{ 19, 30585, "", "=q4=Glistening Fire Opal", "=ds=#e7#", "", "6.06%"};
		{ 20, 30583, "", "=q4=Timeless Chrysoprase", "=ds=#e7#", "", "9.09%"};
		{ 22, 27824, "", "=q3=Robe of the Great Dark Beyond", "=ds=#s5#, #a1#", "", "9.09%"};
		{ 23, 27821, "", "=q3=Extravagant Boots of Malice", "=ds=#s12#, #a1#", "", "9.09%"};
		{ 24, 27825, "", "=q3=Predatory Gloves", "=ds=#s9#, #a2#", "", "15.15%"};
		{ 25, 27826, "", "=q3=Mantle of the Sea Wolf", "=ds=#s3#, #a3#", "", "3.03%"};
		{ 26, 27823, "", "=q3=Shard Encrusted Breastplate", "=ds=#s5#, #a3#", "", "15.15%"};
		{ 27, 27822, "", "=q3=Crystal Band of Valor", "=ds=#s13#", "", "15.15%"};
		Prev = "AuchManaPandemonius";
		Next = "AuchManaNexusPrince";
	};

	AtlasLoot_Data["AuchManaNexusPrince"] = {
		{ 1, 25957, "", "=q3=Ethereal Boots of the Skystrider", "=ds=#s12#, #a1#", "", "11.60%"};
		{ 2, 25955, "", "=q3=Mask of the Howling Storm", "=ds=#s1#, #a3#", "", "12.37%"};
		{ 3, 25956, "", "=q3=Nexus-Bracers of Vigor", "=ds=#s8#, #a4#", "", "10.84%"};
		{ 4, 25954, "", "=q3=Sigil of Shaffar", "=ds=#s2#", "", "12.45%"};
		{ 5, 25962, "", "=q3=Longstrider's Loop", "=ds=#s13#", "", "12.32%"};
		{ 6, 25953, "", "=q3=Ethereal Warp-Bow", "=ds=#w2#", "", "14.19%"};
		{ 8, 22921, "", "=q2=Recipe: Major Frost Protection Potion", "=ds=#p1# (360)", "", "0.85%"};
		{ 10, 28490, "", "=q1=Shaffar's Wrappings", "=ds=#m3#", "", "100%"};
		Prev = "AuchManaTavarok";
		Next = "AuchManaYor";
	};

	AtlasLoot_Data["AuchManaNexusPrinceHEROIC"] = {
		{ 1, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 2, 29240, "", "=q4=Bands of Negation", "=ds=#s8#, #a1#", "", "3.03%"};
		{ 3, 30535, "", "=q4=Forestwalker Kilt", "=ds=#s11#, #a2#", "", "27.27%"};
		{ 4, 29352, "", "=q4=Cobalt Band of Tyrigosa", "=ds=#s13#", "", "0.21%"};
		{ 5, 32082, "", "=q4=The Fel Barrier", "=ds=#w8#"};
		{ 7, 27831, "", "=q3=Mantle of the Unforgiven", "=ds=#s3#, #a1#", "", "9.20%"};
		{ 8, 27843, "", "=q3=Glyph-Lined Sash", "=ds=#s10#, #a1#", "", "10.80%"};
		{ 9, 27827, "", "=q3=Lucid Dream Bracers", "=ds=#s8#, #a2#"};
		{ 10, 27835, "", "=q3=Stillwater Girdle", "=ds=#s10#, #a3#", "", "6.06%"};
		{ 11, 27844, "", "=q3=Pauldrons of Swift Retribution", "=ds=#s3#, #a4#", "", "8.10%"};
		{ 12, 27798, "", "=q3=Gauntlets of Vindication", "=ds=#s9#, #a4#", "", "11.80%"};
		{ 14, 33835, "", "=q1=Shaffar's Wondrous Amulet", "=ds=#m3#", "", "100%"};
		{ 15, 28490, "", "=q1=Shaffar's Wrappings", "=ds=#m3#", "", "100%"};
		{ 16, 30584, "", "=q4=Enscribed Fire Opal", "=ds=#e7#", "", "0.08%"};
		{ 17, 30585, "", "=q4=Glistening Fire Opal", "=ds=#e7#", "", "6.06%"};
		{ 18, 30583, "", "=q4=Timeless Chrysoprase", "=ds=#e7#", "", "9.09%"};
		{ 20, 27837, "", "=q3=Wastewalker Leggings", "=ds=#s11#, #a2# (D3)", "", "3.03%"};
		{ 22, 27828, "", "=q3=Warp-Scarab Brooch", "=ds=#s14#", "", "30.30%"};
		{ 23, 28400, "", "=q3=Warp-Storm Warblade", "=ds=#h1#, #w10#"};
		{ 24, 27829, "", "=q3=Axe of the Nexus-Kings", "=ds=#h2#, #w1#", "", "9.09%"};
		{ 25, 27840, "", "=q3=Scepter of Sha'tar", "=ds=#h2#, #w6#"};
		{ 26, 27842, "", "=q3=Grand Scepter of the Nexus-Kings", "=ds=#w9#", "", "9.09%"};
		{ 28, 22921, "", "=q2=Recipe: Major Frost Protection Potion", "=ds=#p1# (360)", "", "2.85%"};
		Prev = "AuchManaTavarok";
		Next = "AuchManaYor";
	};

	AtlasLoot_Data["AuchManaYor"] = {
		{ 1, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 2, 31919, "", "=q4=Nexus-Prince's Ring of Balance", "=ds=#s13#"};
		{ 3, 31920, "", "=q4=Shaffar's Band of Brutality", "=ds=#s13#"};
		{ 4, 31921, "", "=q4=Yor's Collapsing Band", "=ds=#s13#"};
		{ 5, 31922, "", "=q4=Ring of Conflict Survival", "=ds=#s13#"};
		{ 6, 31923, "", "=q4=Band of the Crystalline Void", "=ds=#s13#"};
		{ 7, 31924, "", "=q4=Yor's Revenge", "=ds=#s13#"};
		{ 9, 31554, "", "=q3=Windchanneller's Tunic", "=ds=#s5#, #a1# =q2=#m16#"};
		{ 10, 31562, "", "=q3=Skystalker's Tunic", "=ds=#s5#, #a2# =q2=#m16#"};
		{ 11, 31570, "", "=q3=Mistshroud Tunic", "=ds=#s5#, #a3# =q2=#m16#"};
		{ 12, 31578, "", "=q3=Slatesteel Breastplate", "=ds=#s5# #a4#, =q2=#m16#"};
		{ 16, 30584, "", "=q4=Enscribed Fire Opal", "=ds=#e7#", "", "0.08%"};
		{ 17, 30585, "", "=q4=Glistening Fire Opal", "=ds=#e7#", "", "6.06%"};
		{ 18, 30583, "", "=q4=Timeless Chrysoprase", "=ds=#e7#", "", "9.09%"};
		Prev = "AuchManaNexusPrince";
	};

		---------------------------------
		--- Auchindoun: Sethekk Halls ---
		---------------------------------

	AtlasLoot_Data["AuchSethekkDarkweaver"] = {
		{ 1, 27919, "", "=q3=Light-Woven Slippers", "=ds=#s12#, #a1#", "", "13.90%"};
		{ 2, 27914, "", "=q3=Moonstrider Boots", "=ds=#s12#, #a2#", "", "12.26%"};
		{ 3, 27915, "", "=q3=Sky-Hunter Swift Boots", "=ds=#s12#, #a3#", "", "11.74%"};
		{ 4, 27918, "", "=q3=Bands of Syth", "=ds=#s8#, #a4#", "", "11.81%"};
		{ 5, 27917, "", "=q3=Libram of the Eternal Rest", "=ds=#s16#, #w16#", "", "14.12%"};
		{ 6, 27916, "", "=q3=Sethekk Feather-Darts", "=ds=#w11#", "", "11.34%"};
		{ 8, 24160, "", "=q3=Design: Khorium Inferno Band", "=ds=#p12# (355)", "", "0.29%"};
		{ 10, 27633, "", "=q1=Terokk's Mask", "=ds=#m3#", "", "100%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30553, "", "=q4=Pristine Fire Opal", "=ds=#e7#", "", "15.73%"};
		{ 19, 30554, "", "=q4=Stalwart Fire Opal", "=ds=#e7#", "", "10.11%"};
		{ 20, 30552, "", "=q4=Blessed Tanzanite", "=ds=#e7#", "", "0.18%"};
		{ 22, 25461, "", "=q1=Book of Forgotten Names", "=ds=#m3#", "", "100%"};
		Next = "AuchSethekkTalonKing";
	};

	AtlasLoot_Data["AuchSethekkRavenGod"] = {
		{ 1, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 2, 32768, "", "=q4=Reins of the Raven Lord", "=ds=#e12#"};
		{ 3, 30553, "", "=q4=Pristine Fire Opal", "=ds=#e7#", "", "15.73%"};
		{ 4, 30554, "", "=q4=Stalwart Fire Opal", "=ds=#e7#", "", "10.11%"};
		{ 5, 30552, "", "=q4=Blessed Tanzanite", "=ds=#e7#", "", "0.18%"};
		{ 7, 32769, "", "=q3=Belt of the Raven Lord", "=ds=#s10#, #a2#"};
		{ 8, 32778, "", "=q3=Boots of Righteous Fortitude", "=ds=#s12#, #a4#"};
		{ 9, 32779, "", "=q3=Band of Frigid Elements", "=ds=#s13#"};
		{ 10, 32781, "", "=q3=Talon of Anzu", "=ds=#h1#, #w4#"};
		{ 11, 32780, "", "=q3=The Boomstick", "=ds=#w5#"};
		Prev = "AuchSethekkTalonKing";
	};

	AtlasLoot_Data["AuchSethekkTalonKing"] = {
		{ 1, 27948, "", "=q3=Trousers of Oblivion", "=ds=#s11#, #a1# (D3)", "", "8.89%"};
		{ 2, 27838, "", "=q3=Incanter's Trousers", "=ds=#s11#, #a1# (D3)", "", "9.54%"};
		{ 3, 27875, "", "=q3=Hallowed Trousers", "=ds=#s11#, #a1# (D3)", "", "10.28%"};
		{ 4, 27776, "", "=q3=Shoulderpads of Assassination", "#s3#, #a2# (D3)", "", "10.21%"};
		{ 5, 27936, "", "=q3=Greaves of Desolation", "=ds=#s11#, #a3# (D3)", "", "12.00%"};
		{ 7, 27946, "", "=q3=Avian Cloak of Feathers", "=ds=#s4#", "", "10.21%"};
		{ 8, 27981, "", "=q3=Sethekk Oracle Cloak", "=ds=#s4#", "", "10.00%"};
		{ 9, 27985, "", "=q3=Deathforge Girdle", "=ds=#s10#, #a4#", "", "9.24%"};
		{ 10, 27925, "", "=q3=Ravenclaw Band", "=ds=#s13#", "", "12.79%"};
		{ 11, 27980, "", "=q3=Terokk's Nightmace", "=ds=#h1#, #w6#", "", "11.18%"};
		{ 12, 27986, "", "=q3=Crow Wing Reaper", "=ds=#h2#, #w1#", "", "8.50%"};
		{ 14, 27632, "", "=q1=Terokk's Quill", "=ds=#m3#", "", "100%"};
		{ 15, 27991, "", "=q1=Shadow Labyrinth Key", "=ds=#e9#", "", "100%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30553, "", "=q4=Pristine Fire Opal", "=ds=#e7#", "", "15.73%"};
		{ 19, 30554, "", "=q4=Stalwart Fire Opal", "=ds=#e7#", "", "10.11%"};
		{ 20, 30552, "", "=q4=Blessed Tanzanite", "=ds=#e7#", "", "0.18%"};
		{ 22, 29249, "", "=q4=Bands of the Benevolent", "=ds=#s8#, #a1#", "", "4.49%"};
		{ 23, 29259, "", "=q4=Bracers of the Hunt", "=ds=#s8#, #a3#", "", "7.87%"};
		{ 24, 32073, "", "=q4=Spaulders of Dementia", "=ds=#s3#, #a4#"};
		{ 25, 29355, "", "=q4=Terokk's Shadowstaff", "=ds=#w9#", "", "0.16%"};
		{ 27, 33834, "", "=q1=The Headfeathers of Ikiss", "=ds=#m3#", "", "100%"};
		Prev = "AuchSethekkDarkweaver";
		Next = "AuchSethekkRavenGod";
	};

		------------------------------------
		--- Auchindoun: Shadow Labyrinth ---
		------------------------------------

	AtlasLoot_Data["AuchShadowHellmaw"] = {
		{ 1, 27889, "", "=q3=Jaedenfire Gloves of Annihilation", "=ds=#s9#, #a1#", "", "13.58%"};
		{ 2, 27888, "", "=q3=Dream-Wing Helm", "=ds=#s1#, #a3#", "", "11.81%"};
		{ 3, 27884, "", "=q3=Ornate Boots of the Sanctified", "=ds=#s12#, #a4#", "", "13.15%"};
		{ 4, 27886, "", "=q3=Idol of the Emerald Queen", "=ds=#s16#, #w14#", "", "12.94%"};
		{ 5, 27887, "", "=q3=Platinum Shield of the Valorous", "=ds=#w8#", "", "10.88%"};
		{ 6, 27885, "", "=q3=Soul-Wand of the Aldor", "=ds=#w12#", "", "13.34%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30563, "", "=q4=Regal Tanzanite", "=ds=#e7#", "", "16.67%"};
		{ 19, 30559, "", "=q4=Etched Fire Opal", "=ds=#e7#", "", "17.85%"};
		{ 20, 30560, "", "=q4=Rune Covered Chrysoprase", "=ds=#e7#", "", "15.47%"};
		Next = "AuchShadowBlackheart";
	};

	AtlasLoot_Data["AuchShadowBlackheart"] = {
		{ 1, 27468, "", "=q3=Moonglade Handwraps", "=ds=#s9#, #a2# (D3)", "", "6.67%"};
		{ 3, 27892, "", "=q3=Cloak of the Inciter", "=ds=#s4#", "", "16.32%"};
		{ 4, 27893, "", "=q3=Ornate Leggings of the Venerated", "=ds=#s11#, #a4#", "", "13.35%"};
		{ 5, 28134, "", "=q3=Brooch of Hightened Potential", "=ds=#s2#", "", "10.54%"};
		{ 6, 27891, "", "=q3=Adamantine Figurine", "=ds=#s14#", "", "10.93%"};
		{ 7, 27890, "", "=q3=Wand of the Netherwing", "=ds=#w12#", "", "10.77%"};
		{ 9, 25728, "", "=q3=Pattern: Stylin' Purple Hat", "=ds=#p7# (350)", "", "0.94%"};
		{ 11, 30808, "", "=q1=Book of Fel Names", "=ds=#m3#", "", "100%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30563, "", "=q4=Regal Tanzanite", "=ds=#e7#", "", "16.67%"};
		{ 19, 30559, "", "=q4=Etched Fire Opal", "=ds=#e7#", "", "17.85%"};
		{ 20, 30560, "", "=q4=Rune Covered Chrysoprase", "=ds=#e7#", "", "15.47%"};
		Prev = "AuchShadowHellmaw";
		Next = "AuchShadowGrandmaster";
	};

	AtlasLoot_Data["AuchShadowGrandmaster"] = {
		{ 1, 27775, "", "=q3=Hallowed Pauldrons", "=ds=#s3#, #a1# (D3)", "", "16.11%"};
		{ 3, 27897, "", "=q3=Breastplate of Many Graces", "=ds=#s5#, #a4#", "", "12.67%"};
		{ 4, 27900, "", "=q3=Jewel of Charismatic Mystique", "=ds=#s14#", "", "16.64%"};
		{ 5, 27901, "", "=q3=Blackout Truncheon", "=ds=#h1#, #w6#", "", "14.35%"};
		{ 6, 27898, "", "=q3=Wrathfire Hand-Cannon", "=ds=#w5#", "", "14.71%"};
		{ 8, 30827, "", "=q1=Lexicon Demonica", "=ds=#m3#", "", "100%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30563, "", "=q4=Regal Tanzanite", "=ds=#e7#", "", "16.67%"};
		{ 19, 30559, "", "=q4=Etched Fire Opal", "=ds=#e7#", "", "17.85%"};
		{ 20, 30560, "", "=q4=Rune Covered Chrysoprase", "=ds=#e7#", "", "15.47%"};
		Prev = "AuchShadowBlackheart";
		Next = "AuchShadowMurmur";
	};

	AtlasLoot_Data["AuchShadowMurmur"] = {
		{ 1, 24309, "", "=q4=Pattern: Spellstrike Pants", "=ds=#p8# (375)", "", "0.37%"};
		{ 3, 27902, "", "=q3=Silent Slippers of Meditation", "=ds=#s12#, #a1#", "", "12.28%"};
		{ 4, 27912, "", "=q3=Harness of the Deep Currents", "=ds=#s5#, #a3#", "", "13.59%"};
		{ 5, 27913, "", "=q3=Whispering Blade of Slaying", "=ds=#h1#, #w4#", "", "9.69%"};
		{ 6, 27905, "", "=q3=Greatsword of Horrid Dreams", "=ds=#h3#, #w10#", "", "9.35%"};
		{ 7, 27903, "", "=q3=Sonic Spear", "=ds=#w7#", "", "11.17%"};
		{ 8, 27910, "", "=q3=Silvermoon Crest Shield", "=ds=#w8#", "", "12.46%"};
		{ 10, 27778, "", "=q3=Spaulders of Oblivion", "=ds=#s3#, #a1# (D3)", "", "12.28%"};
		{ 11, 28232, "", "=q3=Robe of Oblivion", "=ds=#s5#, #a1# (D3)", "", "10.47%"};
		{ 12, 28230, "", "=q3=Hallowed Garments", "=ds=#s5#, #a1# (D3)", "", "11.46%"};
		{ 13, 27908, "", "=q3=Leggings of Assassination", "=ds=#s11#, #a2# (D3)", "", "8.76%"};
		{ 14, 27909, "", "=q3=Tidefury Kilt", "=ds=#s11#, #a3# (D3)", "", "13.87%"};
		{ 15, 27803, "", "=q3=Shoulderguards of the Bold", "=ds=#s3#, #a4# (D3)", "", "9.49%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30563, "", "=q4=Regal Tanzanite", "=ds=#e7#", "", "16.67%"};
		{ 19, 30559, "", "=q4=Etched Fire Opal", "=ds=#e7#", "", "17.85%"};
		{ 20, 30560, "", "=q4=Rune Covered Chrysoprase", "=ds=#e7#", "", "15.47%"};
		{ 22, 30532, "", "=q4=Kirin Tor Master's Trousers", "=ds=#s11#, #a1#", "", "11.90%"};
		{ 23, 29357, "", "=q4=Master Thief's Gloves", "=ds=#s9#, #a2#"};
		{ 24, 29261, "", "=q4=Girdle of Ferocity", "=ds=#s10#, #a3#", "", "3.57%"};
		{ 25, 29353, "", "=q4=Shockwave Truncheon", "=ds=#h3#, #w6#", "", "10.71%"};
		{ 27, 31722, "", "=q1=Murmur's Essence", "=ds=#m3#", "", "100%"};
		{ 28, 33840, "", "=q1=Murmur's Whisper", "=ds=#m3#", "", "100%"};
		Prev = "AuchShadowGrandmaster";
	};

	AtlasLoot_Data["AuchTrash"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Trash Mobs"], "=q5="..BabbleZone["Mana-Tombs"]};
		{ 2, 23615, "", "=q3=Plans: Swiftsteel Gloves", "=ds=#p2# (370), =q1=#n54#", "", "0.52%"};
		{ 3, 22543, "", "=q2=Formula: Enchant Boots - Fortitude", "=ds=#p4# (320) =q1=#n83#", "", "0.52%"};
		{ 5, 0, "INV_Box_01", "=q6="..AL["Trash Mobs"], "=q5="..BabbleZone["Sethekk Halls"]};
		{ 6, 25731, "", "=q3=Pattern: Stylin' Crimson Hat", "=ds=#p7# (350) =q1=#n84#", "", "0.46%"};
		{ 7, 29669, "", "=q2=Pattern: Shadow Armor Kit", "=ds=#p7# (340) =q1=#n85#", "", "0.39%"};
		{ 9, 0, "INV_Box_01", "=q6="..AL["The Saga of Terokk"], "=q5="..BabbleZone["Sethekk Halls"]};
		{ 10, 27634, "", "=q1=The Saga of Terokk", "=ds=#m3#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["Trash Mobs"], "=q5="..BabbleZone["Auchenai Crypts"]};
		{ 17, 23605, "", "=q3=Plans: Felsteel Gloves", "=ds=#p2# (360), =q1=#n55#", "", "0.69%"};
		{ 18, 22544, "", "=q2=Formula: Enchant Boots - Dexterity", "=ds=#p4# (340) =q1=#n82#", "", "0.60%"};
		{ 20, 0, "INV_Box_01", "=q6="..AL["Trash Mobs"], "=q5="..BabbleZone["Shadow Labyrinth"]};
		{ 21, 23607, "", "=q3=Plans: Felsteel Helm", "=ds=#p2# (365), =q1=#n56#", "", "0.61%"};
		{ 23, 0, "INV_Box_01", "=q6="..AL["First Fragment Guardian"], "=q5="..BabbleZone["Shadow Labyrinth"]};
		{ 24, 24514, "", "=q1=First Key Fragment", "=ds=#m3#", "", "100%"};
	};

	--------------------
	--- Black Temple ---
	--------------------

	AtlasLoot_Data["BTNajentus"] = {
		{ 1, 32239, "", "=q4=Slippers of the Seacaller", "=ds=#s12#, #a1#", "", "15%"};
		{ 2, 32240, "", "=q4=Guise of the Tidal Lurker", "=ds=#s1#, #a2#", "", "16%"};
		{ 3, 32377, "", "=q4=Mantle of Darkness", "=ds=#s3#, #a2#", "", "15%"};
		{ 4, 32241, "", "=q4=Helm of Soothing Currents", "=ds=#s1#, #a3#", "", "10%"};
		{ 5, 32234, "", "=q4=Fists of Mukoa", "=ds=#s9#, #a3#", "", "16%"};
		{ 6, 32242, "", "=q4=Boots of Oceanic Fury", "=ds=#s12#, #a3#", "", "6%"};
		{ 7, 32232, "", "=q4=Eternium Shell Bracers", "=ds=#s8#, #a4#", "", "16%"};
		{ 8, 32243, "", "=q4=Pearl Inlaid Boots", "=ds=#s12#, #a4#", "", "10%"};
		{ 9, 32245, "", "=q4=Tide-stomper's Greaves", "=ds=#s12#, #a4#", "", "7%"};
		{ 16, 32238, "", "=q4=Ring of Calming Waves", "=ds=#s13#", "", "16%"};
		{ 17, 32247, "", "=q4=Ring of Captured Storms", "=ds=#s13#", "", "16%"};
		{ 18, 32237, "", "=q4=The Maelstrom's Fury", "=ds=#h3#, #w4#", "", "15%"};
		{ 19, 32236, "", "=q4=Rising Tide", "=ds=#h1#, #w1#", "", "16%"};
		{ 20, 32248, "", "=q4=Halberd of Desolation", "=ds=#w7#", "", "16%"};
		{ 22, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Next = "BTSupremus";
	};

	AtlasLoot_Data["BTSupremus"] = {
		{ 1, 32256, "", "=q4=Waistwrap of Infinity", "=ds=#s10#, #a1#", "", "16%"};
		{ 2, 32252, "", "=q4=Nether Shadow Tunic", "=ds=#s5#, #a2#", "", "14%"};
		{ 3, 32259, "", "=q4=Bands of the Coming Storm", "=ds=#s8#, #a3#", "", "6%"};
		{ 4, 32251, "", "=q4=Wraps of Precise Flight", "=ds=#s8#, #a3#", "", "15%"};
		{ 5, 32258, "", "=q4=Naturalist's Preserving Cinch", "=ds=#s10#, #a3#", "", "9%"};
		{ 6, 32250, "", "=q4=Pauldrons of Abyssal Fury", "=ds=#s3#, #a4#", "", "16%"};
		{ 8, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 16, 32260, "", "=q4=Choker of Endless Nightmares", "=ds=#s2#", "", "17%"};
		{ 17, 32261, "", "=q4=Band of the Abyssal Lord", "=ds=#s13#", "", "14%"};
		{ 18, 32257, "", "=q4=Idol of the White Stag", "=ds=#s16#, #w14#", "", "15%"};
		{ 19, 32254, "", "=q4=The Brutalizer", "=ds=#h1#, #w1#", "", "15%"};
		{ 20, 32262, "", "=q4=Syphon of the Nathrezim", "=ds=#h1#, #w6#", "", "16%"};
		{ 21, 32255, "", "=q4=Felstone Bulwark", "=ds=#w8#", "", "15%"};
		{ 22, 32253, "", "=q4=Legionkiller", "=ds=#w3#", "", "16%"};
		Prev = "BTNajentus";
		Next = "BTAkama";
	};

	AtlasLoot_Data["BTAkama"] = {
		{ 1, 32273, "", "=q4=Amice of Brilliant Light", "=ds=#s3#, #a1#", "", "16%"};
		{ 2, 32270, "", "=q4=Focused Mana Bindings", "=ds=#s8#, #a1#", "", "15%"};
		{ 3, 32513, "", "=q4=Wristbands of Divine Influence", "=ds=#s8#, #a1#", "", "16%"};
		{ 4, 32265, "", "=q4=Shadow-walker's Cord", "=ds=#s10#, #a2#", "", "16%"};
		{ 5, 32271, "", "=q4=Kilt of Immortal Nature", "=ds=#s11#, #a2#", "", "14%"};
		{ 6, 32264, "", "=q4=Shoulders of the Hidden Predator", "=ds=#s3#, #a3#", "", "16%"};
		{ 7, 32275, "", "=q4=Spiritwalker Gauntlets", "=ds=#s9#, #a3#", "", "9%"};
		{ 8, 32276, "", "=q4=Flashfire Girdle", "=ds=#s10#, #a3#", "", "5%"};
		{ 9, 32279, "", "=q4=The Seeker's Wristguards", "=ds=#s8#, #a4#", "", "8%"};
		{ 10, 32278, "", "=q4=Grips of Silent Justice", "=ds=#s9#, #a4#", "", "15%"};
		{ 11, 32263, "", "=q4=Praetorian's Legguards", "=ds=#s11#, #a4#", "", "14%"};
		{ 12, 32268, "", "=q4=Myrmidon's Treads", "=ds=#s12#, #a4#", "", "16%"};
		{ 16, 32266, "", "=q4=Ring of Deceitful Intent", "=ds=#s13#", "", "16%"};
		{ 17, 32361, "", "=q4=Blind-Seers Icon", "=ds=#s15#", "", "15%"};
		{ 19, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "BTSupremus";
		Next = "BTGorefiend";
	};

	AtlasLoot_Data["BTGorefiend"] = {
		{ 1, 32323, "", "=q4=Shadowmoon Destroyer's Drape", "=ds=#s4#", "", "17%"};
		{ 2, 32329, "", "=q4=Cowl of Benevolence", "=ds=#s1#, #a1#", "", "17%"};
		{ 3, 32327, "", "=q4=Robe of the Shadow Council", "=ds=#s5#, #a1#", "", "15%"};
		{ 4, 32324, "", "=q4=Insidious Bands", "=ds=#s8#, #a2#", "", "17%"};
		{ 5, 32328, "", "=q4=Botanist's Gloves of Growth", "=ds=#s9#, #a2#", "", "17%"};
		{ 6, 32510, "", "=q4=Softstep Boots of Tracking", "=ds=#s12#, #a3#", "", "15%"};
		{ 7, 32280, "", "=q4=Gauntlets of Enforcement", "=ds=#s9#, #a4#", "", "15%"};
		{ 8, 32512, "", "=q4=Girdle of Lordaeron's Fallen", "=ds=#s10#, #a4#", "", "19%"};
		{ 16, 32330, "", "=q4=Totem of Ancestral Guidance", "=ds=#s16#, #w15#", "", "13%"};
		{ 17, 32348, "", "=q4=Soul Cleaver", "=ds=#h2#, #w1#", "", "19%"};
		{ 18, 32326, "", "=q4=Twisted Blades of Zarak", "=ds=#w11#", "", "11%"};
		{ 19, 32325, "", "=q4=Rifle of the Stoic Guardian", "=ds=#w5#", "", "14%"};
		{ 21, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "BTAkama";
		Next = "BTBloodboil";
	};

	AtlasLoot_Data["BTBloodboil"] = {
		{ 1, 32337, "", "=q4=Shroud of Forgiveness", "=ds=#s4#", "", "16%"};
		{ 2, 32338, "", "=q4=Blood-cursed Shoulderpads", "=ds=#s3#, #a1#", "", "15%"};
		{ 3, 32340, "", "=q4=Garments of Temperance", "=ds=#s5#, #a1#", "", "15%"};
		{ 4, 32339, "", "=q4=Belt of Primal Majesty", "=ds=#s10#, #a2#", "", "14%"};
		{ 5, 32334, "", "=q4=Vest of Mounting Assault", "=ds=#s5#, #a3#", "", "15%"};
		{ 6, 32342, "", "=q4=Girdle of Mighty Resolve", "=ds=#s10#, #a4#", "", "8%"};
		{ 7, 32333, "", "=q4=Girdle of Stability", "=ds=#s10#, #a4#", "", "16%"};
		{ 8, 32341, "", "=q4=Leggings of Divine Retribution", "=ds=#s11#, #a4#", "", "14%"};
		{ 16, 32335, "", "=q4=Unstoppable Aggressor's Ring", "=ds=#s13#", "", "16%"};
		{ 17, 32501, "", "=q4=Shadowmoon Insignia", "=ds=#s14#", "", "15%"};
		{ 18, 32269, "", "=q4=Messenger of Fate", "=ds=#h1#, #w4#", "", "16%"};
		{ 19, 32344, "", "=q4=Staff of Immaculate Recovery", "=ds=#w9#", "", "15%"};
		{ 20, 32343, "", "=q4=Wand of Prismatic Focus", "=ds=#w12#", "", "14%"};
		{ 22, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "BTGorefiend";
		Next = "BTEssencofSouls";
	};

	AtlasLoot_Data["BTEssencofSouls"] = {
		{ 1, 32353, "", "=q4=Gloves of Unfailing Faith", "=ds=#s9#, #a1#", "", "17%"};
		{ 2, 32351, "", "=q4=Elunite Empowered Bracers", "=ds=#s8#, #a2#", "", "8%"};
		{ 3, 32347, "", "=q4=Grips of Damnation", "=ds=#s9#, #a2#", "", "16%"};
		{ 4, 32352, "", "=q4=Naturewarden's Treads", "=ds=#s12#, #a2#", "", "9%"};
		{ 5, 32517, "", "=q4=The Wavemender's Mantle", "=ds=#s3#, #a3#", "", "17%"};
		{ 6, 32346, "", "=q4=Boneweave Girdle", "=ds=#s10#, #a3#", "", "16%"};
		{ 7, 32354, "", "=q4=Crown of Empowered Fate", "=ds=#s1#, #a4#", "", "16%"};
		{ 8, 32345, "", "=q4=Dreadboots of the Legion", "=ds=#s12#, #a4#", "", "15%"};
		{ 16, 32349, "", "=q4=Translucent Spellthread Necklace", "=ds=#s2#", "", "16%"};
		{ 17, 32362, "", "=q4=Pendant of Titans", "=ds=#s2#", "", "15%"};
		{ 18, 32350, "", "=q4=Touch of Inspiration", "=ds=#s15#", "", "16%"};
		{ 19, 32332, "", "=q4=Torch of the Damned", "=ds=#h2#, #w6#", "", "17%"};
		{ 20, 32363, "", "=q4=Naaru-Blessed Life Rod", "=ds=#w12#", "", "14%"};
		{ 22, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "BTBloodboil";
		Next = "BTShahraz";
	};

	AtlasLoot_Data["BTShahraz"] = {
		{ 1, 32367, "", "=q4=Leggings of Devastation", "=ds=#s11#, #a1#", "", "16%"};
		{ 2, 32366, "", "=q4=Shadowmaster's Boots", "=ds=#s12#, #a2#", "", "15%"};
		{ 3, 32365, "", "=q4=Heartshatter Breastplate", "=ds=#s5#, #a4#", "", "15%"};
		{ 4, 32370, "", "=q4=Nadina's Pendant of Purity", "=ds=#s2#", "", "15%"};
		{ 5, 32368, "", "=q4=Tome of the Lightbringer", "=ds=#s16#, #w16#", "", "15%"};
		{ 6, 32369, "", "=q4=Blade of Savagery", "=ds=#h1#, #w10#", "", "15%"};
		{ 16, 31101, "", "=q4=Pauldrons of the Forgotten Conqueror", "=ds=#m23# #e15#", "", "76%"};
		{ 17, 31103, "", "=q4=Pauldrons of the Forgotten Protector", "=ds=#m23# #e15#", "", "80%"};
		{ 18, 31102, "", "=q4=Pauldrons of the Forgotten Vanquisher", "=ds=#m23# #e15#", "", "77%"};
		{ 20, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "BTEssencofSouls";
		Next = "BTCouncil";
	};

	AtlasLoot_Data["BTCouncil"] = {
		{ 1, 32331, "", "=q4=Cloak of the Illidari Council", "=ds=#s4#", "", "16%"};
		{ 2, 32519, "", "=q4=Belt of Divine Guidance", "=ds=#s10#, #a1#", "", "16%"};
		{ 3, 32518, "", "=q4=Veil of Turning Leaves", "=ds=#s3#, #a2#", "", "12%"};
		{ 4, 32376, "", "=q4=Forest Prowler's Helm", "=ds=#s1#, #a3#", "", "17%"};
		{ 5, 32373, "", "=q4=Helm of the Illidari Shatterer", "=ds=#s1#, #a4#", "", "17%"};
		{ 6, 32505, "", "=q4=Madness of the Betrayer", "=ds=#s14#", "", "16%"};
		{ 16, 31098, "", "=q4=Leggings of the Forgotten Conqueror", "=ds=#m23# #e15#", "", "34%"};
		{ 17, 31100, "", "=q4=Leggings of the Forgotten Protector", "=ds=#m23# #e15#", "", "33%"};
		{ 18, 31099, "", "=q4=Leggings of the Forgotten Vanquisher", "=ds=#m23# #e15#", "", "34%"};
		{ 20, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "BTShahraz";
		Next = "BTIllidanStormrage";
	};

	AtlasLoot_Data["BTIllidanStormrage"] = {
		{ 1, 32524, "", "=q4=Shroud of the Highborne", "=ds=#s4#", "", "16%"};
		{ 2, 32525, "", "=q4=Cowl of the Illidari High Lord", "=ds=#s1#, #a1#", "", "15%"};
		{ 3, 32235, "", "=q4=Cursed Vision of Sargeras", "=ds=#s1#, #a2#", "", "16%"};
		{ 4, 32521, "", "=q4=Faceplate of the Impenetrable", "=ds=#s1#, #a4#", "", "14%"};
		{ 5, 32497, "", "=q4=Stormrage Signet Ring", "=ds=#s13#", "", "15%"};
		{ 6, 32483, "", "=q4=The Skull of Gul'dan", "=ds=#s14#", "", "16%"};
		{ 7, 32496, "", "=q4=Memento of Tyrande", "=ds=#s14#", "", "15%"};
		{ 9, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 11, 32837, "", "=q5=Warglaive of Azzinoth", "=ds=#h3#, #w10#, =q1=#m1# =ds=#c9#, #c6#", "", "4%"};
		{ 12, 32838, "", "=q5=Warglaive of Azzinoth", "=ds=#h4#, #w10#, =q1=#m1# =ds=#c9#, #c6#", "", "4%"};
		{ 16, 31089, "", "=q4=Chestguard of the Forgotten Conqueror", "=ds=#m23# #e15#", "", "78%"};
		{ 17, 31091, "", "=q4=Chestguard of the Forgotten Protector", "=ds=#m23# #e15#", "", "79%"};
		{ 18, 31090, "", "=q4=Chestguard of the Forgotten Vanquisher", "=ds=#m23# #e15#", "", "78%"};
		{ 20, 32471, "", "=q4=Shard of Azzinoth", "=ds=#h1#, #w4#", "", "16%"};
		{ 21, 32500, "", "=q4=Crystal Spire of Karabor", "=ds=#h3#, #w6#", "", "15%"};
		{ 22, 32374, "", "=q4=Zhar'doom, Greatstaff of the Devourer", "=ds=#w9#", "", "14%"};
		{ 23, 32375, "", "=q4=Bulwark of Azzinoth", "=ds=#w8#", "", "14%"};
		{ 24, 32336, "", "=q4=Black Bow of the Betrayer", "=ds=#w2#", "", "16%"};
		Prev = "BTCouncil";
	};

	AtlasLoot_Data["BTTrash"] = {
		{ 1, 32590, "", "=q4=Nethervoid Cloak", "=ds=#s4#", "", "1%"};
		{ 2, 34012, "", "=q4=Shroud of the Final Stand", "=ds=#s4#", "", "1%"};
		{ 3, 32609, "", "=q4=Boots of the Divine Light", "=ds=#s12#, #a1#", "", "1%"};
		{ 4, 32593, "", "=q4=Treads of the Den Mother", "=ds=#s12#, #a2#", "", "1%"};
		{ 5, 32592, "", "=q4=Chestguard of Relentless Storms", "=ds=#s5#, #a3#", "", "1%"};
		{ 6, 32608, "", "=q4=Pillager's Gauntlets", "=ds=#s9#, #a4#", "", "1%"};
		{ 7, 32606, "", "=q4=Girdle of the Lightbearer", "=ds=#s10#, #a4#", "", "1%"};
		{ 8, 32591, "", "=q4=Choker of Serrated Blades", "=ds=#s2#", "", "1%"};
		{ 9, 32589, "", "=q4=Hellfire-Encased Pendant", "=ds=#s2#", "", "1%"};
		{ 10, 32526, "", "=q4=Band of Devastation", "=ds=#s13#", "", "1%"};
		{ 11, 32528, "", "=q4=Blessed Band of Karabor", "=ds=#s13#", "", "1%"};
		{ 12, 32527, "", "=q4=Ring of Ancient Knowledge", "=ds=#s13#", "", "2%"};
		{ 16, 34009, "", "=q4=Hammer of Judgement", "=ds=#h3#, #w6#", "", "1%"};
		{ 17, 32943, "", "=q4=Swiftsteel Bludgeon", "=ds=#h1#, #w6#", "", "2%"};
		{ 18, 34011, "", "=q4=Illidari Runeshield", "=ds=#w8#", "", "1%"};
		{ 20, 32228, "", "=q4=Empyrean Sapphire", "=ds=#e7#", "", "12%"};
		{ 21, 32231, "", "=q4=Pyrestone", "=ds=#e7#", "", "8%"};
		{ 22, 32229, "", "=q4=Lionseye", "=ds=#e7#", "", "6%"};
		{ 23, 32249, "", "=q4=Seaspray Emerald", "=ds=#e7#", "", "9%"};
		{ 24, 32230, "", "=q4=Shadowsong Amethyst", "=ds=#e7#", "", "6%"};
		{ 25, 32227, "", "=q4=Crimson Spinel", "=ds=#e7#", "", "8%"};
		{ 27, 32428, "", "=q3=Heart of Darkness", "=ds=#e8#", "", "16%"};
		{ 28, 32897, "", "=q2=Mark of the Illidari", "=ds=#m20#", "", "27%"};
	};

	AtlasLoot_Data["BTPatterns"] = {
		{ 1, 32738, "", "=q4=Plans: Dawnsteel Bracers", "=ds=#p2# (375)"};
		{ 2, 32739, "", "=q4=Plans: Dawnsteel Shoulders", "=ds=#p2# (375)"};
		{ 3, 32736, "", "=q4=Plans: Swiftsteel Bracers", "=ds=#p2# (375)"};
		{ 4, 32737, "", "=q4=Plans: Swiftsteel Shoulders", "=ds=#p2# (375)"};
		{ 5, 32748, "", "=q4=Pattern: Bindings of Lightning Reflexes", "=ds=#p7# (375)"};
		{ 6, 32744, "", "=q4=Pattern: Bracers of Renewed Life", "=ds=#p7# (375)"};
		{ 7, 32750, "", "=q4=Pattern: Living Earth Bindings", "=ds=#p7# (375)"};
		{ 8, 32751, "", "=q4=Pattern: Living Earth Shoulders", "=ds=#p7# (375)"};
		{ 9, 32749, "", "=q4=Pattern: Shoulders of Lightning Reflexes", "=ds=#p7# (375)"};
		{ 10, 32745, "", "=q4=Pattern: Shoulderpads of Renewed Life", "=ds=#p7# (375)"};
		{ 11, 32746, "", "=q4=Pattern: Swiftstrike Bracers", "=ds=#p7# (375)"};
		{ 12, 32747, "", "=q4=Pattern: Swiftstrike Shoulders", "=ds=#p7# (375)"};
		{ 16, 32754, "", "=q4=Pattern: Bracers of Nimble Thought", "=ds=#p8# (375)"};
		{ 17, 32755, "", "=q4=Pattern: Mantle of Nimble Thought", "=ds=#p8# (375)"};
		{ 18, 32753, "", "=q4=Pattern: Swiftheal Mantle", "=ds=#p8# (375)"};
		{ 19, 32752, "", "=q4=Pattern: Swiftheal Wraps", "=ds=#p8# (375)"};
	};

		------------------------------------------------
		--- Caverns of Time: Old Hillsbrad Foothills ---
		------------------------------------------------

	AtlasLoot_Data["CoTHillsbradDrake"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 27423, "", "=q3=Cloak of Impulsiveness", "=ds=#s4#", "", "19.68%"};
		{ 3, 27418, "", "=q3=Stormreaver Shadow-Kilt", "=ds=#s11#, #a1#", "", "18.16%"};
		{ 4, 27417, "", "=q3=Ravenwing Pauldrons", "=ds=#s3#, #a2#", "", "18.33%"};
		{ 5, 27420, "", "=q3=Uther's Ceremonial Warboots", "=ds=#s12#, #a4#", "", "17.14%"};
		{ 6, 27436, "", "=q3=Iron Band of the Unbreakable", "=ds=#s13#", "", "15.09%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30589, "", "=q4=Dazzling Chrysoprase", "=ds=#e7#", "", "0.66%"};
		{ 19, 30591, "", "=q4=Empowered Fire Opal", "=ds=#e7#", "", "0.24%"};
		{ 20, 30590, "", "=q4=Enduring Chrysoprase", "=ds=#e7#", "", "0.10%"};
		{ 22, 28212, "", "=q3=Aran's Sorcerous Slacks", "=ds=#s11#, #a1#", "", "11.43%"};
		{ 23, 28214, "", "=q3=Grips of the Lunar Eclipse", "=ds=#s9#, #a2#", "", "2.86%"};
		{ 24, 28215, "", "=q3=Mok'Nathal Mask of Battle", "=ds=#s1#, #a3#", "", "11.43%"};
		{ 25, 28211, "", "=q3=Lieutenant's Signet of Lordaeron", "=ds=#s13#", "", "5.71%"};
		{ 26, 28213, "", "=q3=Lordaeron Medical Guide", "=ds=#s15#", "", "8.57%"};
		{ 27, 28210, "", "=q3=Bloodskull Destroyer", "=ds=#h1#, #w6#", "", "5.71%"};
		Next = "CoTHillsbradSkarloc";
	};

	AtlasLoot_Data["CoTHillsbradSkarloc"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 27428, "", "=q3=Stormfront Gauntlets", "=ds=#s9#, #a3#", "", "19.04%"};
		{ 3, 27430, "", "=q3=Scaled Greaves of Patience", "=ds=#s11#, #a3#", "", "19.22%"};
		{ 4, 27427, "", "=q3=Durotan's Battle Harness", "=ds=#s5#, #a4#", "", "14.83%"};
		{ 5, 27424, "", "=q3=Amani Venom-Axe", "=ds=#h1#, #w1#", "", "18.50%"};
		{ 6, 27426, "", "=q3=Northshire Battlemace", "=ds=#h3#, #w6#", "", "15.37%"};
		{ 8, 22927, "", "=q2=Recipe: Ironshield Potion", "=ds=#p1# (365)", "", "1.03%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30589, "", "=q4=Dazzling Chrysoprase", "=ds=#e7#", "", "0.66%"};
		{ 19, 30591, "", "=q4=Empowered Fire Opal", "=ds=#e7#", "", "0.24%"};
		{ 20, 30590, "", "=q4=Enduring Chrysoprase", "=ds=#e7#", "", "0.10%"};
		{ 22, 28218, "", "=q3=Pontiff's Pantaloons of Prophecy", "=ds=#s11#, #a1#", "", "18.18%"};
		{ 23, 28220, "", "=q3=Moon-Crown Antlers", "=ds=#s1#, #a2#", "", "0.14%"};
		{ 24, 28219, "", "=q3=Emerald-Scale Greaves", "=ds=#s11#, #a3#", "", "3.03%"};
		{ 25, 28221, "", "=q3=Boots of the Watchful Heart", "=ds=#s12#, #a4#", "", "0.52%"};
		{ 26, 28217, "", "=q3=Tarren Mill Vitality Locket", "=ds=#s2#", "", "9.09%"};
		{ 27, 28216, "", "=q3=Dathrohan's Ceremonial Hammer", "=ds=#h3#, #w6#", "", "6.06%"};
		Prev = "CoTHillsbradDrake";
		Next = "CoTHillsbradHunter";
	};

	AtlasLoot_Data["CoTHillsbradHunter"] = {
		{ 1, 24173, "", "=q4=Design: Circlet of Arcane Might", "=ds=#p12# (370)", "", "0.10%"};
		{ 3, 27433, "", "=q3=Pauldrons of Sufferance", "=ds=#s3#, #a1#", "", "19.11%"};
		{ 4, 27434, "", "=q3=Mantle of Perenolde", "=ds=#s3#, #a2#", "", "16.26%"};
		{ 5, 27440, "", "=q3=Diamond Prism of Recurrence", "=ds=#s2#", "", "16.12%"};
		{ 6, 27432, "", "=q3=Broxigar's Ring of Valor", "=ds=#s13#", "", "16.35%"};
		{ 7, 27431, "", "=q3=Time-Shifted Dagger", "=ds=#h3#, #w4#", "", "14.09%"};
		Prev = "CoTHillsbradSkarloc";
	};

	AtlasLoot_Data["CoTHillsbradHunterHEROIC"] = {
		{ 1, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 2, 29250, "", "=q4=Cord of Sanctification", "=ds=#s10#, #a1#"};
		{ 3, 29246, "", "=q4=Nightfall Wristguards", "=ds=#s8#, #a2#"};
		{ 4, 29357, "", "=q4=Master Thief's Gloves", "=ds=#s9#, #a2#", "", "10.00%"};
		{ 5, 30534, "", "=q4=Wyrmscale Greaves", "=ds=#s11#, #a3#"};
		{ 6, 30536, "", "=q4=Greaves of the Martyr", "=ds=#s11#, #a4#", "", "15.00%"};
		{ 8, 27911, "", "=q3=Epoch's Whispering Cinch", "=ds=#s10#, #a2#", "", "10.00%"};
		{ 9, 28344, "", "=q3=Wyrmfury Pauldrons", "=ds=#s3#, #a3#", "", "0.24%"};
		{ 10, 28233, "", "=q3=Necklace of Resplendent Hope", "=ds=#s2#", "", "15.00%"};
		{ 11, 27904, "", "=q3=Resounding Ring of Glory", "=ds=#s13#", "", "0.17%"};
		{ 12, 28227, "", "=q3=Sparking Arcanite Ring", "=ds=#s13#", "", "0.24%"};
		{ 13, 28223, "", "=q3=Arcanist's Stone", "=ds=#s14#", "", "10.00%"};
		{ 14, 28226, "", "=q3=Timeslicer", "=ds=#h1#, #w4#", "", "5.00%"};
		{ 15, 28222, "", "=q3=Reaver of the Infinites", "=ds=#h2#, #w1#", "", "0.48%"};
		{ 16, 30589, "", "=q4=Dazzling Chrysoprase", "=ds=#e7#", "", "0.66%"};
		{ 17, 30591, "", "=q4=Empowered Fire Opal", "=ds=#e7#", "", "0.24%"};
		{ 18, 30590, "", "=q4=Enduring Chrysoprase", "=ds=#e7#", "", "0.10%"};
		{ 19, 24173, "", "=q4=Design: Circlet of Arcane Might", "=ds=#p12# (370)", "", "0.10%"};
		{ 21, 28191, "", "=q3=Mana-Etched Vestments", "=ds=#s5#, #a1# (D3)", "", "0.24%"};
		{ 22, 28224, "", "=q3=Wastewalker Helm", "=ds=#s1#, #a2# (D3)", "", "0.24%"};
		{ 23, 28401, "", "=q3=Hauberk of Desolation", "=ds=#s5#, #a3# (D3)", "", "0.14%"};
		{ 24, 28225, "", "=q3=Doomplate Warhelm", "=ds=#s1#, #a4# (D3)", "", "0.14%"};
		{ 26, 33847, "", "=q1=Epoch Hunter's Head", "=ds=#m3#", "", "100%"};
		Prev = "CoTHillsbradSkarloc";
	};

	AtlasLoot_Data["CoTTrash"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Trash Mobs"], "=q5="..BabbleZone["Old Hillsbrad Foothills"]};
		{ 2, 25729, "", "=q3=Pattern: Stylin' Adventure Hat", "=ds=#p7# (350) =q1=#n94#", "", "0.25%"};
		{ 4, 0, "INV_Box_01", "=q6="..AL["Don Carlos"], "=q5="..BabbleZone["Old Hillsbrad Foothills"]};
		{ 5, 38506, "", "=q3=Don Carlos' Famous Hat", "=ds=#s1#, #a1# =q2=#j3#"};
		{ 6, 38329, "", "=q1=Don Carlos' Hat", "=q1=#m3#"};
		{ 7, 38276, "", "=q1=Haliscan Brimmed Hat", "=q1=#m4#: =ds=#s1#, #a1#"};
		{ 9, 0, "INV_Box_01", "=q6="..AL["Trash Mobs"], "=q5="..BabbleZone["The Black Morass"]};
		{ 10, 25730, "", "=q3=Pattern: Stylin' Jungle Hat", "=ds=#p7# (350) =q1=#n95#", "", "0.29%"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["Thomas Yance"], "=q5="..BabbleZone["Old Hillsbrad Foothills"]};
		{ 17, 25725, "", "=q1=Pattern: Riding Crop", "=ds=#p7# (350)"};
		{ 19, 0, "INV_Box_01", "=q6="..AL["Aged Dalaran Wizard"], "=q5="..BabbleZone["Old Hillsbrad Foothills"]};
		{ 20, 22539, "", "=q1=Formula: Enchant Shield - Intellect", "=ds=#p4# (325)"};
	};

		-----------------------------------------
		--- Caverns of Time: The Black Morass ---
		-----------------------------------------

	AtlasLoot_Data["CoTMorassDeja"] = {
		{ 1, 27988, "", "=q3=Burnoose of Shifting Ages", "=ds=#s4#", "", "13.87%"};
		{ 2, 27994, "", "=q3=Mantle of Three Terrors", "=ds=#s3#, #a1#", "", "12.30%"};
		{ 3, 27995, "", "=q3=Sun-Gilded Shouldercaps", "=ds=#s3#, #a2#", "", "13.13%"};
		{ 4, 27993, "", "=q3=Mask of Inner Fire", "=ds=#s1#, #a3#", "", "13.84%"};
		{ 5, 27996, "", "=q3=Ring of Spiritual Precision", "=ds=#s13#", "", "14.45%"};
		{ 6, 27987, "", "=q3=Melmorta's Twilight Longbow", "=ds=#w2#", "", "11.51%"};
		{ 8, 29675, "", "=q2=Pattern: Arcane Armor Kit", "=ds=#p7# (340)", "", "0.35%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30558, "", "=q4=Glimmering Fire Opal", "=ds=#e7#"};
		{ 19, 30556, "", "=q4=Glinting Fire Opal", "=ds=#e7#"};
		{ 20, 30555, "", "=q4=Glowing Tanzanite", "=ds=#e7#"};
		Next = "CoTMorassTemporus";
	};

	AtlasLoot_Data["CoTMorassTemporus"] = {
		{ 1, 28185, "", "=q3=Khadgar's Kilt of Abjuration", "=ds=#s11#, #a1#", "", "14.26%"};
		{ 2, 28186, "", "=q3=Laughing Skull Battle-Harness", "=ds=#s5#, #a3#", "", "13.14%"};
		{ 3, 28034, "", "=q3=Hourglass of the Unraveller", "=ds=#s14#", "", "13.69%"};
		{ 4, 28187, "", "=q3=Star-Heart Lamp", "=ds=#s15#", "", "11.83%"};
		{ 5, 28184, "", "=q3=Millennium Blade", "=ds=#h1#, #w10#", "", "11.74%"};
		{ 6, 28033, "", "=q3=Epoch-Mender", "=ds=#w9#", "", "13.80%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30558, "", "=q4=Glimmering Fire Opal", "=ds=#e7#"};
		{ 19, 30556, "", "=q4=Glinting Fire Opal", "=ds=#e7#"};
		{ 20, 30555, "", "=q4=Glowing Tanzanite", "=ds=#e7#"};
		Prev = "CoTMorassDeja";
		Next = "CoTMorassAeonus";
	};

	AtlasLoot_Data["CoTMorassAeonus"] = {
		{ 1, 28193, "", "=q3=Mana-Etched Crown", "=ds=#s1#, #a1# (D3)", "", "11.99%"};
		{ 2, 27509, "", "=q3=Handgrips of Assassination", "=ds=#s9#, #a2# (D3)", "", "12.84%"};
		{ 3, 27873, "", "=q3=Moonglade Pants", "=ds=#s11#, #a2# (D3)", "", "11.28%"};
		{ 4, 28192, "", "=q3=Helm of Desolation", "=ds=#s1#, #a3# (D3)", "", "12.77%"};
		{ 5, 27977, "", "=q3=Legplates of the Bold", "=ds=#s11#, #a4# (D3)", "", "9.92%"};
		{ 6, 27839, "", "=q3=Legplates of the Righteous", "=ds=#s11#, #a4# (D3)", "", "12.10%"};
		{ 8, 28206, "", "=q3=Cowl of the Guiltless", "=ds=#s1#, #a2#", "", "12.25%"};
		{ 9, 28194, "", "=q3=Primal Surge Bracers", "=ds=#s8#, #a3#", "", "13.51%"};
		{ 10, 28207, "", "=q3=Pauldrons of the Crimson Flight", "=ds=#s3#, #a4#", "", "11.11%"};
		{ 11, 28190, "", "=q3=Scarab of the Infinite Cycle", "=ds=#s14#", "", "11.32%"};
		{ 12, 28189, "", "=q3=Latro's Shifting Sword", "=ds=#h1#, #w10#", "", "9.70%"};
		{ 13, 28188, "", "=q3=Bloodfire Greatstaff", "=ds=#w9#", "", "10.48%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30558, "", "=q4=Glimmering Fire Opal", "=ds=#e7#"};
		{ 19, 30556, "", "=q4=Glinting Fire Opal", "=ds=#e7#"};
		{ 20, 30555, "", "=q4=Glowing Tanzanite", "=ds=#e7#"};
		{ 22, 30531, "", "=q4=Breeches of the Occultist", "=ds=#s11#, #a1#", "", "1.49%"};
		{ 23, 29247, "", "=q4=Girdle of the Deathdealer", "=ds=#s10#, #a2#"};
		{ 24, 29253, "", "=q4=Girdle of Valorous Deeds", "=ds=#s10#, #a4#"};
		{ 25, 29356, "", "=q4=Quantum Blade", "=ds=#h2#, #w10#"};
		{ 27, 33858, "", "=q1=Aeonus's Hourglass", "=ds=#m3#", "", "100%"};
		Prev = "CoTMorassTemporus";
	};

		-------------------------------------
		--- Caverns of Time: Hyjal Summit ---
		-------------------------------------

	AtlasLoot_Data["MountHyjalWinterchill"] = {
		{ 1, 30871, "", "=q4=Bracers of Martyrdom", "=ds=#s8#, #a1#", "", "17%"};
		{ 2, 30870, "", "=q4=Cuffs of Devastation", "=ds=#s8#, #a1#", "", "16%"};
		{ 3, 30863, "", "=q4=Deadly Cuffs", "=ds=#s8#, #a2#", "", "15%"};
		{ 4, 30868, "", "=q4=Rejuvenating Bracers", "=ds=#s8#, #a2#", "", "16%"};
		{ 5, 30864, "", "=q4=Bracers of the Pathfinder", "=ds=#s8#, #a3#", "", "15%"};
		{ 6, 30869, "", "=q4=Howling Wind Bracers", "=ds=#s8#, #a3#", "", "12%"};
		{ 7, 30873, "", "=q4=Stillwater Boots", "=ds=#s12#, #a3#", "", "14%"};
		{ 8, 30866, "", "=q4=Blood-stained Pauldrons", "=ds=#s3#, #a4#", "", "15%"};
		{ 9, 30862, "", "=q4=Blessed Adamantite Bracers", "=ds=#s8#, #a4#", "", "15%"};
		{ 10, 30861, "", "=q4=Furious Shackles", "=ds=#s8#, #a4#", "", "15%"};
		{ 16, 30865, "", "=q4=Tracker's Blade", "=ds=#h1#, #w4#", "", "15%"};
		{ 17, 30872, "", "=q4=Chronicle of Dark Secrets", "=ds=#s15#", "", "16%"};
		{ 19, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 21, 32459, "", "=q1=Time-Phased Phylactery", "=ds=#m3#", "", "8%"};
		Next = "MountHyjalAnetheron";
	};

	AtlasLoot_Data["MountHyjalAnetheron"] = {
		{ 1, 30884, "", "=q4=Hatefury Mantle", "=ds=#s3#, #a1#", "", "16%"};
		{ 2, 30888, "", "=q4=Anetheron's Noose", "=ds=#s10#, #a1#", "", "16%"};
		{ 3, 30885, "", "=q4=Archbishop's Slippers", "=ds=#s12#, #a1#", "", "17%"};
		{ 4, 30879, "", "=q4=Don Alejandro's Money Belt", "=ds=#s10#, #a2#", "", "16%"};
		{ 5, 30886, "", "=q4=Enchanted Leather Sandals", "=ds=#s12#, #a2#", "", "15%"};
		{ 6, 30887, "", "=q4=Golden Links of Restoration", "=ds=#s5#, #a3#", "", "16%"};
		{ 7, 30880, "", "=q4=Quickstrider Moccasins", "=ds=#s12#, #a3#", "", "16%"};
		{ 8, 30878, "", "=q4=Glimmering Steel Mantle", "=ds=#s3#, #a4#", "", "16%"};
		{ 16, 30874, "", "=q4=The Unbreakable Will", "=ds=#h1#, #w10#", "", "16%"};
		{ 17, 30881, "", "=q4=Blade of Infamy", "=ds=#h1#, #w10#", "", "15%"};
		{ 18, 30883, "", "=q4=Pillar of Ferocity", "=ds=#w9#", "", "16%"};
		{ 19, 30882, "", "=q4=Bastion of Light", "=ds=#w8#", "", "15%"};
		{ 21, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "MountHyjalWinterchill";
		Next = "MountHyjalKazrogal";
	};

	AtlasLoot_Data["MountHyjalKazrogal"] = {
		{ 1, 30895, "", "=q4=Angelista's Sash", "=ds=#s10#, #a1#", "", "16%"};
		{ 2, 30916, "", "=q4=Leggings of Channeled Elements", "=ds=#s11#, #a1#", "", "17%"};
		{ 3, 30894, "", "=q4=Blue Suede Shoes", "=ds=#s12#, #a1#", "", "16%"};
		{ 4, 30917, "", "=q4=Razorfury Mantle", "=ds=#s3#, #a2#", "", "17%"};
		{ 5, 30914, "", "=q4=Belt of the Crescent Moon", "=ds=#s10#, #a2#", "", "9%"};
		{ 6, 30891, "", "=q4=Black Featherlight Boots", "=ds=#s12#, #a2#", "", "14%"};
		{ 7, 30892, "", "=q4=Beast-tamer's Shoulders", "=ds=#s3#, #a3#", "", "15%"};
		{ 8, 30919, "", "=q4=Valestalker Girdle", "=ds=#s10#, #a3#", "", "15%"};
		{ 9, 30893, "", "=q4=Sun-touched Chain Leggings", "=ds=#s11#, #a3#", "", "15%"};
		{ 10, 30915, "", "=q4=Belt of Seething Fury", "=ds=#s10#, #a4#", "", "17%"};
		{ 16, 30918, "", "=q4=Hammer of Atonement", "=ds=#h3#, #w6#", "", "17%"};
		{ 17, 30889, "", "=q4=Kaz'rogal's Hardened Heart", "=ds=#w8#", "", "16%"};
		{ 19, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "MountHyjalAnetheron";
		Next = "MountHyjalAzgalor";
	};

	AtlasLoot_Data["MountHyjalAzgalor"] = {
		{ 1, 30899, "", "=q4=Don Rodrigo's Poncho", "=ds=#s5#, #a2#", "", "15%"};
		{ 2, 30898, "", "=q4=Shady Dealer's Pantaloons", "=ds=#s11#, #a2#", "", "16%"};
		{ 3, 30900, "", "=q4=Bow-stitched Leggings", "=ds=#s11#, #a3#", "", "15%"};
		{ 4, 30896, "", "=q4=Glory of the Defender", "=ds=#s5#, #a4#", "", "15%"};
		{ 5, 30897, "", "=q4=Girdle of Hope", "=ds=#s10#, #a4#", "", "15%"};
		{ 6, 30901, "", "=q4=Boundless Agony", "=ds=#h1#, #w4#", "", "16%"};
		{ 16, 31092, "", "=q4=Gloves of the Forgotten Conqueror", "=ds=#m23# #e15#", "", "74%"};
		{ 17, 31094, "", "=q4=Gloves of the Forgotten Protector", "=ds=#m23# #e15#", "", "73%"};
		{ 18, 31093, "", "=q4=Gloves of the Forgotten Vanquisher", "=ds=#m23# #e15#", "", "73%"};
		{ 20, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "MountHyjalKazrogal";
		Next = "MountHyjalArchimonde";
	};

	AtlasLoot_Data["MountHyjalArchimonde"] = {
		{ 1, 30913, "", "=q4=Robes of Rhonin", "=ds=#s5#, #a1#", "", "15%"};
		{ 2, 30912, "", "=q4=Leggings of Eternity", "=ds=#s11#, #a1#", "", "15%"};
		{ 3, 30905, "", "=q4=Midnight Chestguard", "=ds=#s5#, #a2#", "", "14%"};
		{ 4, 30907, "", "=q4=Mail of Fevered Pursuit", "=ds=#s5#, #a3#", "", "15%"};
		{ 5, 30904, "", "=q4=Savior's Grasp", "=ds=#s5#, #a4#", "", "14%"};
		{ 6, 30903, "", "=q4=Legguards of Endless Rage", "=ds=#s11#, #a4#", "", "15%"};
		{ 7, 30911, "", "=q4=Scepter of Purification", "=ds=#s15#", "", "15%"};
		{ 9, 30910, "", "=q4=Tempest of Chaos", "=ds=#h3#, #w10#", "", "14%"};
		{ 10, 30902, "", "=q4=Cataclysm's Edge", "=ds=#h2#, #w10#", "", "15%"};
		{ 11, 30908, "", "=q4=Apostle of Argus", "=ds=#w9#", "", "15%"};
		{ 12, 30909, "", "=q4=Antonidas's Aegis of Rapt Concentration", "=ds=#w8#", "", "15%"};
		{ 13, 30906, "", "=q4=Bristleblitz Striker", "=ds=#w2#", "", "16%"};
		{ 16, 31097, "", "=q4=Helm of the Forgotten Conqueror", "=ds=#m23# #e15#", "", "70%"};
		{ 17, 31095, "", "=q4=Helm of the Forgotten Protector", "=ds=#m23# #e15#", "", "72%"};
		{ 18, 31096, "", "=q4=Helm of the Forgotten Vanquisher", "=ds=#m23# #e15#", "", "73%"};
		{ 20, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "MountHyjalAzgalor";
	};

	AtlasLoot_Data["MountHyjalTrash"] = {
		{ 1, 32590, "", "=q4=Nethervoid Cloak", "=ds=#s4#", "", "1%"};
		{ 2, 34010, "", "=q4=Pepe's Shroud of Pacification", "=ds=#s4#", "", "1%"};
		{ 3, 32609, "", "=q4=Boots of the Divine Light", "=ds=#s12#, #a1#", "", "1%"};
		{ 4, 32592, "", "=q4=Chestguard of Relentless Storms", "=ds=#s5#, #a3#", "", "1%"};
		{ 5, 32591, "", "=q4=Choker of Serrated Blades", "=ds=#s2#", "", "1%"};
		{ 6, 32589, "", "=q4=Hellfire-Encased Pendant", "=ds=#s2#", "", "1%"};
		{ 7, 34009, "", "=q4=Hammer of Judgement", "=ds=#h3#, #w6#", "", "1%"};
		{ 8, 32946, "", "=q4=Claw of Molten Fury", "=ds=#h3#, #w13#", "", "0.46%"};
		{ 9, 32945, "", "=q4=Fist of Molten Fury", "=ds=#h4#, #w13#", "", "0.42%"};
		{ 11, 32428, "", "=q3=Heart of Darkness", "=ds=#e8#", "", "16%"};
		{ 12, 32897, "", "=q2=Mark of the Illidari", "=ds=#m20#", "", "27%"};
		{ 16, 32285, "", "=q4=Design: Flashing Crimson Spinel", "=ds=#p12# (375)", "", "4%"};
		{ 17, 32296, "", "=q4=Design: Great Lionseye", "=ds=#p12# (375)", "", "3%"};
		{ 18, 32303, "", "=q4=Design: Inscribed Pyrestone", "=ds=#p12# (375)", "", "3%"};
		{ 19, 32295, "", "=q4=Design: Mystic Lionseye", "=ds=#p12# (375)", "", "4%"};
		{ 20, 32298, "", "=q4=Design: Shifting Shadowsong Amethyst", "=ds=#p12# (375)", "", "4%"};
		{ 21, 32297, "", "=q4=Design: Sovereign Shadowsong Amethyst", "=ds=#p12# (375)", "", "4%"};
		{ 22, 32289, "", "=q4=Design: Stormy Empyrean Sapphire", "=ds=#p12# (375)", "", "4%"};
		{ 23, 32307, "", "=q4=Design: Veiled Pyrestone", "=ds=#p12# (375)", "", "3%"};
	};

		------------------------------------------
		--- Coilfang Reservoir: The Slave Pens ---
		------------------------------------------

	AtlasLoot_Data["CFRSlaveMennu"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 24359, "", "=q3=Princely Reign Leggings", "=ds=#s11#, #a1#", "", "10.20%"};
		{ 3, 24357, "", "=q3=Vest of Living Lightning", "=ds=#s5#, #a3#", "", "11.94%"};
		{ 4, 24360, "", "=q3=Tracker's Belt", "=ds=#s10#, #a3#", "", "11.07%"};
		{ 5, 24356, "", "=q3=Wastewalker Shiv", "=ds=#h1#, #w4#", "", "12.47%"};
		{ 6, 24361, "", "=q3=Spellfire Longsword", "=ds=#h3#, #w10#", "", "11.07%"};
		{ 8, 29674, "", "=q2=Pattern: Nature Armor Kit", "=ds=#p7# (340)", "", "0.80%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30604, "", "=q4=Resplendent Fire Opal", "=ds=#e7#", "", "22.49%"};
		{ 19, 30605, "", "=q4=Vivid Chrysoprase", "=ds=#e7#", "", "9.39%"};
		{ 20, 30603, "", "=q4=Royal Tanzanite", "=ds=#e7#", "", "10.48%"};
		{ 22, 27542, "", "=q3=Cord of Belief", "=ds=#s10#, #a1#", "", "16.50%"};
		{ 23, 27545, "", "=q3=Mennu's Scaled Leggings", "=ds=#s11#, #a2#", "", "8.50%"};
		{ 24, 27541, "", "=q3=Archery Belt of the Broken", "=ds=#s10#, #a3#", "", "12.75%"};
		{ 25, 27546, "", "=q3=Traitor's Noose", "=ds=#s2#", "", "13.75%"};
		{ 26, 27544, "", "=q3=Totem of Spontaneous Regrowth", "=ds=#s16#, #w15#", "", "12.25%"};
		{ 27, 27543, "", "=q3=Starlight Dagger", "=ds=#h3#, #w4#", "", "20.00%"};
		{ 29, 29674, "", "=q2=Pattern: Nature Armor Kit", "=ds=#p7# (340)", "", "0.80%"};
		Next = "CFRSlaveRokmar";
	};

	AtlasLoot_Data["CFRSlaveRokmar"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 24379, "", "=q3=Bogstrok Scale Cloak", "=ds=#s4#", "", "10.05%"};
		{ 3, 24376, "", "=q3=Runed Fungalcap", "=ds=#s14#", "", "11.45%"};
		{ 4, 24378, "", "=q3=Coilfang Hammer of Renewal", "=ds=#h3#, #w6#", "", "9.66%"};
		{ 5, 24380, "", "=q3=Calming Spore Reed", "=ds=#w12#", "", "10.26%"};
		{ 6, 24381, "", "=q3=Coilfang Needler", "=ds=#w3#", "", "10.05%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30604, "", "=q4=Resplendent Fire Opal", "=ds=#e7#", "", "22.49%"};
		{ 19, 30605, "", "=q4=Vivid Chrysoprase", "=ds=#e7#", "", "9.39%"};
		{ 20, 30603, "", "=q4=Royal Tanzanite", "=ds=#e7#", "", "10.48%"};
		{ 22, 27550, "", "=q3=Ironscale War Cloak", "=ds=#s4#", "", "11.48%"};
		{ 23, 27547, "", "=q3=Coldwhisper Cord", "=ds=#s10#, #a1#", "", "14.85%"};
		{ 24, 28124, "", "=q3=Liar's Cord", "=ds=#s10#, #a2#", "", "8.96%"};
		{ 25, 27549, "", "=q3=Wavefury Boots", "=ds=#s12#, #a3#", "", "9.80%"};
		{ 26, 27548, "", "=q3=Girdle of Many Blessings", "=ds=#s10#, #a4#", "", "14.85%"};
		{ 27, 27551, "", "=q3=Skeletal Necklace of Battlerage", "=ds=#s2#", "", "16.25%"};
		Prev = "CFRSlaveMennu";
		Next = "CFRSlaveQuagmirran";
	};

	AtlasLoot_Data["CFRSlaveQuagmirran"] = {
		{ 1, 27796, "", "=q3=Mana-Etched Spaulders", "=ds=#s3#, #a1# (D3)", "", "5.24%"};
		{ 2, 27713, "", "=q3=Pauldrons of Desolation", "=ds=#s3#, #a3# (D3)", "", "10.70%"};
		{ 4, 27742, "", "=q3=Mage-Fury Girdle", "=ds=#s10#, #a1#", "", "12.00%"};
		{ 5, 27712, "", "=q3=Shackles of Quagmirran", "=ds=#s8#, #a2#"};
		{ 6, 27800, "", "=q3=Earthsoul Britches", "=ds=#s11#, #a2#", "", "13.76%"};
		{ 7, 28337, "", "=q3=Breastplate of Righteous Fury", "=ds=#s5#, #a4#", "", "8.73%"};
		{ 8, 27672, "", "=q3=Girdle of the Immovable", "=ds=#s10#, #a4#", "", "7.64%"};
		{ 9, 27740, "", "=q3=Band of Ursol", "=ds=#s13#", "", "12.23%"};
		{ 10, 27683, "", "=q3=Quagmirran's Eye", "=ds=#s14#", "", "7.86%"};
		{ 11, 27714, "", "=q3=Swamplight Lantern", "=ds=#s15#", "", "10.92%"};
		{ 12, 27673, "", "=q3=Phosphorescent Blade", "=ds=#h1#, #w10#"};
		{ 13, 27741, "", "=q3=Bleeding Hollow Warhammer", "=ds=#h3#, #w6#", "", "9.83%"};
		{ 15, 33821, "", "=q1=The Heart of Quagmirran", "=ds=#m3#", "", "100%"};
		{ 16, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 17, 30604, "", "=q4=Resplendent Fire Opal", "=ds=#e7#", "", "22.49%"};
		{ 18, 30605, "", "=q4=Vivid Chrysoprase", "=ds=#e7#", "", "9.39%"};
		{ 19, 30603, "", "=q4=Royal Tanzanite", "=ds=#e7#", "", "10.48%"};
		{ 20, 29242, "", "=q4=Boots of Blasphemy", "=ds=#s12#, #a1#", "", "10.04%"};
		{ 21, 30538, "", "=q4=Midnight Legguards", "=ds=#s11#, #a2#", "", "8.95%"};
		{ 22, 32078, "", "=q4=Pauldrons of Wild Magic", "=ds=#s3#, #a3#"};
		{ 23, 29349, "", "=q4=Adamantine Chain of the Unbroken", "=ds=#s2#", "", "1.53%"};
		{ 25, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 26, 24362, "", "=q3=Spore-Soaked Vaneer", "=ds=#s4#", "", "10.63%"};
		{ 27, 24365, "", "=q3=Deft Handguards", "=ds=#s9#, #a2#", "", "10.89%"};
		{ 28, 24366, "", "=q3=Scorpid-Sting Mantle", "=ds=#s3#, #a3#", "", "11.72%"};
		{ 29, 24363, "", "=q3=Unscarred Breastplate", "=ds=#s5#, #a4#", "", "9.54%"};
		{ 30, 24364, "", "=q3=Azureplate Greaves", "=ds=#s11#, #a4#", "", "9.98%"};
		Prev = "CFRSlaveRokmar";
	};

		------------------------------------------
		--- Coilfang Reservoir: The Steamvault ---
		------------------------------------------

	AtlasLoot_Data["CFRSteamThespia"] = {
		{ 1, 27508, "", "=q3=Incanter's Gloves", "=ds=#s9#, #a1# (D3)", "", "17.09%"};
		{ 3, 27789, "", "=q3=Cloak of Whispering Shells", "=ds=#s4#", "", "14.32%"};
		{ 4, 27787, "", "=q3=Chestguard of No Remorse", "=ds=#s5#, #a2#", "", "17.65%"};
		{ 5, 27783, "", "=q3=Moonrage Girdle", "=ds=#s10#, #a2#", "", "18.71%"};
		{ 6, 27784, "", "=q3=Scintillating Coral Band", "=ds=#s13#", "", "16.72%"};
		{ 8, 29673, "", "=q2=Pattern: Frost Armor Kit", "=ds=#p7# (340)", "", "0.60%"};
		{ 10, 30828, "", "=q1=Vial of Underworld Loam", "=ds=#m3#", "", "100%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30550, "", "=q4=Sundered Chrysoprase", "=ds=#e7#", "", "8.59%"};
		{ 19, 30551, "", "=q4=Infused Fire Opal", "=ds=#e7#", "", "6.64%"};
		{ 20, 30549, "", "=q4=Shifting Tanzanite", "=ds=#e7#", "", "1.56%"};
		Next = "CFRSteamSteamrigger";
	};

	AtlasLoot_Data["CFRSteamSteamrigger"] = {
		{ 1, 27793, "", "=q3=Earth Mantle Handwraps", "=ds=#s9#, #a3#", "", "16.92%"};
		{ 2, 27790, "", "=q3=Mask of Pennance", "=ds=#s1#, #a4#", "", "16.65%"};
		{ 3, 27792, "", "=q3=Steam-Hinge Chain of Valor", "=ds=#s2#", "", "14.49%"};
		{ 4, 27791, "", "=q3=Serpentcrest Life-Staff", "=ds=#w9#", "", "17.09%"};
		{ 5, 27794, "", "=q3=Recoilless Rocket Ripper X-54", "=ds=#w5#", "", "15.88%"};
		{ 7, 23887, "", "=q3=Schematic: Rocket Boots Xtreme", "=ds=#p5# (355)", "", "0.52%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30550, "", "=q4=Sundered Chrysoprase", "=ds=#e7#", "", "8.59%"};
		{ 19, 30551, "", "=q4=Infused Fire Opal", "=ds=#e7#", "", "6.64%"};
		{ 20, 30549, "", "=q4=Shifting Tanzanite", "=ds=#e7#", "", "1.56%"};
		Prev = "CFRSteamThespia";
		Next = "CFRSteamWarlord";
	};

	AtlasLoot_Data["CFRSteamWarlord"] = {
		{ 1, 24313, "", "=q4=Pattern: Battlecast Hood", "=ds=#p8# (375)", "", "0.20%"};
		{ 3, 27738, "", "=q3=Incanter's Pauldrons", "=ds=#s3#, #a1# (D3)", "", "12.25%"};
		{ 4, 27737, "", "=q3=Moonglade Shoulders", "=ds=#s3#, #a2# (D3)", "", "12.89%"};
		{ 5, 27801, "", "=q3=Beast Lord Mantle", "=ds=#s3#, #a3# (D3)", "", "10.63%"};
		{ 6, 27510, "", "=q3=Tidefury Gauntlets", "=ds=#s9#, #a3# (D3)", "", "12.45%"};
		{ 7, 27874, "", "=q3=Beast Lord Leggings", "=ds=#s11#, #a3# (D3)", "", "9.56%"};
		{ 8, 28203, "", "=q3=Breastplate of the Righteous", "=ds=#s5#, #a4# (D3)", "", "10.98%"};
		{ 9, 27475, "", "=q3=Gauntlets of the Bold", "=ds=#s9#, #a4# (D3)", "", "10.05%"};
		{ 11, 27804, "", "=q3=Devilshark Cape", "=ds=#s4#", "", "12.18%"};
		{ 12, 27799, "", "=q3=Vermillion Robes of the Dominant", "=ds=#s5#, #a1#", "", "12.47%"};
		{ 13, 27795, "", "=q3=Sash of Serpentra", "=ds=#s10#, #a1#", "", "11.03%"};
		{ 14, 27806, "", "=q3=Fathomheart Gauntlets", "=ds=#s9#, #a3#", "", "14.84%"};
		{ 15, 27805, "", "=q3=Ring of the Silver Hand", "=ds=#s13#", "", "13.95%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30550, "", "=q4=Sundered Chrysoprase", "=ds=#e7#", "", "8.59%"};
		{ 19, 30551, "", "=q4=Infused Fire Opal", "=ds=#e7#", "", "6.64%"};
		{ 20, 30549, "", "=q4=Shifting Tanzanite", "=ds=#e7#", "", "1.56%"};
		{ 21, 30543, "", "=q4=Pontifex Kilt", "=ds=#s11#, #a1#", "", "7.81%"};
		{ 22, 29243, "", "=q4=Wave-Fury Vambraces", "=ds=#s8#, #a3#", "", "17.97%"};
		{ 23, 29463, "", "=q4=Amber Bands of the Aggressor", "=ds=#s8#, #a4#", "", "2.34%"};
		{ 24, 29351, "", "=q4=Wrathtide Longbow", "=ds=#w2#", "", "3.52%"};
		{ 26, 31721, "", "=q1=Kalithresh's Trident", "=ds=#m3#", "", "100%"};
		{ 27, 33827, "", "=q1=The Warlord's Treatise", "=ds=#m3#", "", "100%"};
		Prev = "CFRSteamSteamrigger";
	};

	AtlasLoot_Data["CFRSteamTrash"] = {
		{ 1, 24159, "", "=q3=Design: Khorium Band of Frost", "=ds=#p12# (355) =q1=#n86#", "", "0.14%"};
		{ 3, 22533, "", "=q2=Formula: Enchant Bracer - Fortitude", "=ds=#p4# (350) =q1=#n87#", "", "0.40%"};
		{ 5, 24367, "", "=q1=Orders from Lady Vashj", "=ds=#m2#"};
		{ 6, 24368, "", "=q1=Coilfang Armaments", "=ds=#m3#", "", "12.68%"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["Second Fragment Guardian"], "=q5="..BabbleZone["The Steamvault"]};
		{ 17, 24487, "", "=q1=Second Key Fragment", "=ds=#m3#", "", "100%"};
	};

		----------------------------------------
		--- Coilfang Reservoir: The Underbog ---
		----------------------------------------

	AtlasLoot_Data["CFRUnderHungarfen"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 24450, "", "=q3=Manaspark Gloves", "=ds=#s9#, #a1#", "", "11.72%"};
		{ 3, 24452, "", "=q3=Starlight Gauntlets", "=ds=#s9#, #a2#", "", "12.35%"};
		{ 4, 24451, "", "=q3=Lykul Bloodbands", "=ds=#s8#, #a3#", "", "11.75%"};
		{ 5, 24413, "", "=q3=Totem of the Thunderhead", "=ds=#s16#, #w15#", "", "12.86%"};
		{ 6, 27631, "", "=q3=Needle Shrike", "=ds=#w11#", "", "11.60%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30606, "", "=q4=Lambent Chrysoprase", "=ds=#e7#", "", "17.89%"};
		{ 19, 30607, "", "=q4=Splendid Fire Opal", "=ds=#e7#", "", "6.50%"};
		{ 20, 30608, "", "=q4=Radiant Chrysoprase", "=ds=#e7#", "", "9.76%"};
		{ 22, 27746, "", "=q3=Arcanium Signet Bands", "=ds=#s8#, #a1#", "", "8.37%"};
		{ 23, 27745, "", "=q3=Hungarhide Gauntlets", "=ds=#s9#, #a3#", "", "13.79%"};
		{ 24, 27743, "", "=q3=Girdle of Living Flame", "=ds=#s10#, #a3#", "", "13.79%"};
		{ 25, 27748, "", "=q3=Cassock of the Loyal", "=ds=#s11#, #a4#", "", "7.39%"};
		{ 26, 27744, "", "=q3=Idol of Ursoc", "=ds=#s16#, #w14#", "", "16.26%"};
		{ 27, 27747, "", "=q3=Boggspine Knuckles", "=ds=#h4#, #w13#", "", "12.81%"};
		Next = "CFRUnderGhazan";
	};

	AtlasLoot_Data["CFRUnderGhazan"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 24459, "", "=q3=Cloak of Healing Rays", "=ds=#s4#", "", "14.18%"};
		{ 3, 24458, "", "=q3=Studded Girdle of Virtue", "=ds=#s10#, #a4#", "", "14.06%"};
		{ 4, 24460, "", "=q3=Talisman of Tenacity", "=ds=#s2#", "", "12.99%"};
		{ 5, 24462, "", "=q3=Luminous Pearls of Insight", "=ds=#s2#", "", "12.75%"};
		{ 6, 24461, "", "=q3=Hatebringer", "=ds=#h2#, #w6#", "", "14.12%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30606, "", "=q4=Lambent Chrysoprase", "=ds=#e7#", "", "17.89%"};
		{ 19, 30607, "", "=q4=Splendid Fire Opal", "=ds=#e7#", "", "6.50%"};
		{ 20, 30608, "", "=q4=Radiant Chrysoprase", "=ds=#e7#", "", "9.76%"};
		{ 22, 27760, "", "=q3=Dunewind Sash", "=ds=#s10#, #a2#", "", "14.67%"};
		{ 23, 27759, "", "=q3=Headdress of the Tides", "=ds=#s1#, #a3#", "", "13.33%"};
		{ 24, 27755, "", "=q3=Girdle of Gallantry", "=ds=#s10#, #a4#", "", "7.33%"};
		{ 25, 27758, "", "=q3=Hydra-fang Necklace", "=ds=#s2#", "", "12.00%"};
		{ 26, 27761, "", "=q3=Ring of the Shadow Deeps", "=ds=#s13#", "", "18.67%"};
		{ 27, 27757, "", "=q3=Greatstaff of the Leviathan", "=ds=#w9#", "", "16.00%"};
		Prev = "CFRUnderHungarfen";
		Next = "CFRUnderSwamplord";
	};

	AtlasLoot_Data["CFRUnderSwamplord"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 24454, "", "=q3=Cloak of Enduring Swiftness", "=ds=#s4#", "", "17.23%"};
		{ 3, 24455, "", "=q3=Tunic of the Nightwatcher", "=ds=#s5#, #a2#", "", "14.47%"};
		{ 4, 24457, "", "=q3=Truth Bearer Shoulderguards", "=ds=#s3#, #a4#", "", "14.42%"};
		{ 5, 24456, "", "=q3=Greaves of the Iron Guardian", "=ds=#s11#, #a4#", "", "12.41%"};
		{ 6, 24453, "", "=q3=Zangartooth Shortblade", "=ds=#h3#, #w4#", "", "15.17%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30606, "", "=q4=Lambent Chrysoprase", "=ds=#e7#", "", "17.89%"};
		{ 19, 30607, "", "=q4=Splendid Fire Opal", "=ds=#e7#", "", "6.50%"};
		{ 20, 30608, "", "=q4=Radiant Chrysoprase", "=ds=#e7#", "", "9.76%"};
		{ 22, 27764, "", "=q3=Hands of the Sun", "=ds=#s9#, #a1#", "", "12.14%"};
		{ 23, 27763, "", "=q3=Crown of the Forest Lord", "=ds=#s1#, #a2#", "", "20.00%"};
		{ 24, 27765, "", "=q3=Armwraps of Disdain", "=ds=#s8#, #a2#", "", "9.29%"};
		{ 25, 27766, "", "=q3=Swampstone Necklace", "=ds=#s2#", "", "17.14%"};
		{ 26, 27762, "", "=q3=Weathered Band of the Swamplord", "=ds=#s13#"};
		{ 27, 27767, "", "=q3=Bogreaver", "=ds=#h1#, #w1#", "", "9.29%"};
		Prev = "CFRUnderGhazan";
		Next = "CFRUnderStalker";
	};

	AtlasLoot_Data["CFRUnderStalker"] = {
		{ 1, 24481, "", "=q3=Robes of the Augurer", "=ds=#s5#, #a1#", "", "10.55%"};
		{ 2, 24466, "", "=q3=Skulldugger's Leggings", "=ds=#s11#, #a2#", "", "13.23%"};
		{ 3, 24465, "", "=q3=Shamblehide Chestguard", "=ds=#s5#, #a3#", "", "10.95%"};
		{ 4, 24463, "", "=q3=Pauldrons of Brute Force", "=ds=#s3#, #a4#", "", "11.95%"};
		{ 5, 24464, "", "=q3=The Stalker's Fangs", "=ds=#h1#, #w4#", "", "14.31%"};
		{ 7, 24248, "", "=q1=Brain of the Black Stalker", "=ds=#m3#", "", "100%"};
		Prev = "CFRUnderSwamplord";
	};

	AtlasLoot_Data["CFRUnderStalkerHEROIC"] = {
		{ 1, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 2, 29265, "", "=q4=Barkchip Boots", "=ds=#s12#, #a2#", "", "8.54%"};
		{ 3, 30541, "", "=q4=Stormsong Kilt", "=ds=#s11#, #a3#", "", "6.50%"};
		{ 4, 32081, "", "=q4=Eye of the Stalker", "=ds=#s13#"};
		{ 5, 29350, "", "=q4=The Black Stalk", "=ds=#w12#", "", "4.88%"};
		{ 7, 27781, "", "=q3=Demonfang Ritual Helm", "=ds=#s1#, #a1#", "", "8.94%"};
		{ 8, 27768, "", "=q3=Oracle Belt of Timeless Mystery", "=ds=#s10#, #a1#", "", "14.63%"};
		{ 9, 27938, "", "=q3=Savage Mask of the Lynx Lord", "=ds=#s1#, #a2#", "", "1.63%"};
		{ 10, 27773, "", "=q3=Barbaric Legstraps", "=ds=#s11#, #a3#", "", "9.35%"};
		{ 11, 27779, "", "=q3=Bone Chain Necklace", "=ds=#s2#", "", "14.23%"};
		{ 12, 27780, "", "=q3=Ring of Fabled Hope", "=ds=#s13#", "", "9.90%"};
		{ 13, 27896, "", "=q3=Alembic of Infernal Power", "=ds=#s14#", "", "12.60%"};
		{ 14, 27770, "", "=q3=Argussian Compass", "=ds=#s14#", "", "3.66%"};
		{ 16, 30606, "", "=q4=Lambent Chrysoprase", "=ds=#e7#", "", "17.89%"};
		{ 17, 30607, "", "=q4=Splendid Fire Opal", "=ds=#e7#", "", "6.50%"};
		{ 18, 30608, "", "=q4=Radiant Chrysoprase", "=ds=#e7#", "", "9.76%"};
		{ 20, 27907, "", "=q3=Mana-Etched Pantaloons", "=ds=#s11#, #a1# (D3)", "", "4.88%"};
		{ 21, 27771, "", "=q3=Doomplate Shoulderguards", "=ds=#s3#, #a4# (D3)", "", "6.50%"};
		{ 23, 27769, "", "=q3=Endbringer", "=ds=#h2#, #w10#", "", "9.35%"};
		{ 24, 27772, "", "=q3=Stormshield of Renewal", "=ds=#w8#", "", "13.01%"};
		{ 26, 24248, "", "=q1=Brain of the Black Stalker", "=ds=#m3#", "", "100%"};
		{ 27, 33826, "", "=q1=Black Stalker Egg", "=ds=#m3#", "", "100%"};
		Prev = "CFRUnderSwamplord";
	};

		------------------------------------------------
		--- Coilfang Reservoir: Serpentshrine Cavern ---
		------------------------------------------------

	AtlasLoot_Data["CFRSerpentHydross"] = {
		{ 1, 30056, "", "=q4=Robe of Hateful Echoes", "=ds=#s5#, #a1#", "", "18%"};
		{ 2, 32516, "", "=q4=Wraps of Purification", "=ds=#s8#, #a1#", "", "18%"};
		{ 3, 30050, "", "=q4=Boots of the Shifting Nightmare", "=ds=#s12#, #a1#", "", "17%"};
		{ 4, 30055, "", "=q4=Shoulderpads of the Stranger", "=ds=#s3#, #a2#", "", "16%"};
		{ 5, 30047, "", "=q4=Blackfathom Warbands", "=ds=#s8#, #a3#", "", "19%"};
		{ 6, 30054, "", "=q4=Ranger-General's Chestguard", "=ds=#s5#, #a3#", "", "18%"};
		{ 7, 30048, "", "=q4=Brighthelm of Justice", "=ds=#s1#, #a4#", "", "21%"};
		{ 8, 30053, "", "=q4=Pauldrons of the Wardancer", "=ds=#s3#, #a4#", "", "16%"};
		{ 16, 30052, "", "=q4=Ring of Lethality", "=ds=#s13#", "", "20%"};
		{ 17, 33055, "", "=q4=Band of Vile Aggression", "=ds=#s13#", "", "14%"};
		{ 18, 30664, "", "=q4=Living Root of the Wildheart", "=ds=#s14#, =q1=#m1# =ds=#c1#", "", "18%"};
		{ 19, 30629, "", "=q4=Scarab of Displacement", "=ds=#s14#", "", "21%"};
		{ 20, 30049, "", "=q4=Fathomstone", "=ds=#s15#", "", "19%"};
		{ 21, 30051, "", "=q4=Idol of the Crescent Goddess", "=ds=#s16#, #w14#", "", "11%"};
		{ 23, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Next = "CFRSerpentLurker";
	};

	AtlasLoot_Data["CFRSerpentLurker"] = {
		{ 1, 30064, "", "=q4=Cord of Screaming Terrors", "=ds=#s10#, #a1#", "", "17%"};
		{ 2, 30067, "", "=q4=Velvet Boots of the Guardian", "=ds=#s12#, #a1#", "", "17%"};
		{ 3, 30062, "", "=q4=Grove-Bands of Remulos", "=ds=#s8#, #a2#", "", "21%"};
		{ 4, 30060, "", "=q4=Boots of Effortless Striking", "=ds=#s12#, #a2#", "", "21%"};
		{ 5, 30066, "", "=q4=Tempest-Strider Boots", "=ds=#s12#, #a3#", "", "21%"};
		{ 6, 30065, "", "=q4=Glowing Breastplate of Truth", "=ds=#s5#, #a4#", "", "20%"};
		{ 7, 30057, "", "=q4=Bracers of Eradication", "=ds=#s8#, #a4#", "", "19%"};
		{ 9, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 16, 30059, "", "=q4=Choker of Animalistic Fury", "=ds=#s2#", "", "21%"};
		{ 17, 30061, "", "=q4=Ancestral Ring of Conquest", "=ds=#s13#", "", "20%"};
		{ 18, 33054, "", "=q4=The Seal of Danzalar", "=ds=#s13#", "", "14%"};
		{ 19, 30665, "", "=q4=Earring of Soulful Meditation", "=ds=#s14#, =q1=#m1# =ds=#c5#", "", "18%"};
		{ 20, 30063, "", "=q4=Libram of Absolute Truth", "=ds=#s16#, #w16#", "", "17%"};
		{ 21, 30058, "", "=q4=Mallet of the Tides", "=ds=#h1#, #w6#", "", "20%"};
		Prev = "CFRSerpentHydross";
		Next = "CFRSerpentLeotheras";
	};

	AtlasLoot_Data["CFRSerpentLeotheras"] = {
		{ 1, 30092, "", "=q4=Orca-Hide Boots", "=ds=#s12#, #a2#", "", "13%"};
		{ 2, 30097, "", "=q4=Coral-Barbed Shoulderpads", "=ds=#s3#, #a3#", "", "15%"};
		{ 3, 30091, "", "=q4=True-Aim Stalker Bands", "=ds=#s8#, #a3#", "", "17%"};
		{ 4, 30096, "", "=q4=Girdle of the Invulnerable", "=ds=#s10#, #a4#", "", "14%"};
		{ 5, 30627, "", "=q4=Tsunami Talisman", "=ds=#s14#", "", "15%"};
		{ 6, 30095, "", "=q4=Fang of the Leviathan", "=ds=#h3#, #w10#", "", "14%"};
		{ 16, 30239, "", "=q4=Gloves of the Vanquished Champion", "=ds=#m22# #e15#", "", "63%"};
		{ 17, 30240, "", "=q4=Gloves of the Vanquished Defender", "=ds=#m22# #e15#", "", "67%"};
		{ 18, 30241, "", "=q4=Gloves of the Vanquished Hero", "=ds=#m22# #e15#", "", "65%"};
		{ 20, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "CFRSerpentLurker";
		Next = "CFRSerpentKarathress";
	};

	AtlasLoot_Data["CFRSerpentKarathress"] = {
		{ 1, 30100, "", "=q4=Soul-Strider Boots", "=ds=#s12#, #a1#", "", "15%"};
		{ 2, 30101, "", "=q4=Bloodsea Brigand's Vest", "=ds=#s5#, #a2#", "", "15%"};
		{ 3, 30099, "", "=q4=Frayed Tether of the Drowned", "=ds=#s2#", "", "15%"};
		{ 4, 30663, "", "=q4=Fathom-Brooch of the Tidewalker", "=ds=#s14#, =q1=#m1# =ds=#c7#", "", "15%"};
		{ 5, 30626, "", "=q4=Sextant of Unstable Currents", "=ds=#s14#", "", "14%"};
		{ 6, 30090, "", "=q4=World Breaker", "=ds=#h2#, #w6#", "", "15%"};
		{ 16, 30245, "", "=q4=Leggings of the Vanquished Champion", "=ds=#m22# #e15#", "", "62%"};
		{ 17, 30246, "", "=q4=Leggings of the Vanquished Defender", "=ds=#m22# #e15#", "", "61%"};
		{ 18, 30247, "", "=q4=Leggings of the Vanquished Hero", "=ds=#m22# #e15#", "", "62%"};
		{ 20, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "CFRSerpentLeotheras";
		Next = "CFRSerpentMorogrim";
	};

	AtlasLoot_Data["CFRSerpentMorogrim"] = {
		{ 1, 30098, "", "=q4=Razor-Scale Battlecloak", "=ds=#s4#", "", "22%"};
		{ 2, 30079, "", "=q4=Illidari Shoulderpads", "=ds=#s3#, #a1#", "", "15%"};
		{ 3, 30075, "", "=q4=Gnarled Chestpiece of the Ancients", "=ds=#s5#, #a2#", "", "19%"};
		{ 4, 30085, "", "=q4=Mantle of the Tireless Tracker", "=ds=#s3#, #a3#", "", "20%"};
		{ 5, 30068, "", "=q4=Girdle of the Tidal Call", "=ds=#s10#, #a3#", "", "17%"};
		{ 6, 30084, "", "=q4=Pauldrons of the Argent Sentinel", "=ds=#s3#, #a4#", "", "21%"};
		{ 7, 30081, "", "=q4=Warboots of Obliteration", "=ds=#s12#, #a4#", "", "21%"};
		{ 9, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 16, 30008, "", "=q4=Pendant of the Lost Ages", "=ds=#s2#", "", "18%"};
		{ 17, 30083, "", "=q4=Ring of Sundered Souls", "=ds=#s13#", "", "21%"};
		{ 18, 33058, "", "=q4=Band of the Vigilant", "=ds=#s13#", "", "19%"};
		{ 19, 30720, "", "=q4=Serpent-Coil Braid", "=ds=#s14#, =q1=#m1# =ds=#c3#", "", "20%"};
		{ 20, 30082, "", "=q4=Talon of Azshara", "=ds=#h1#, #w10#", "", "20%"};
		{ 21, 30080, "", "=q4=Luminescent Rod of the Naaru", "=ds=#w12#", "", "15%"};
		Prev = "CFRSerpentKarathress";
		Next = "CFRSerpentVashj";
	};

	AtlasLoot_Data["CFRSerpentVashj"] = {
		{ 1, 30107, "", "=q4=Vestments of the Sea-Witch", "=ds=#s5#, #a1#", "", "13%"};
		{ 2, 30111, "", "=q4=Runetotem's Mantle", "=ds=#s3#, #a2#", "", "14%"};
		{ 3, 30106, "", "=q4=Belt of One-Hundred Deaths", "=ds=#s10#, #a2#", "", "12%"};
		{ 4, 30104, "", "=q4=Cobra-Lash Boots", "=ds=#s12#, #a3#", "", "13%"};
		{ 5, 30102, "", "=q4=Krakken-Heart Breastplate", "=ds=#s5#, #a4#", "", "15%"};
		{ 6, 30112, "", "=q4=Glorious Gauntlets of Crestfall", "=ds=#s9#, #a4#", "", "14%"};
		{ 7, 30109, "", "=q4=Ring of Endless Coils", "=ds=#s13#", "", "13%"};
		{ 8, 30110, "", "=q4=Coral Band of the Revived", "=ds=#s13#", "", "16%"};
		{ 9, 30621, "", "=q4=Prism of Inner Calm", "=ds=#s14#", "", "13%"};
		{ 10, 30103, "", "=q4=Fang of Vashj", "=ds=#h1#, #w4#", "", "14%"};
		{ 11, 30108, "", "=q4=Lightfathom Scepter", "=ds=#h3#, #w6#", "", "14%"};
		{ 12, 30105, "", "=q4=Serpent Spine Longbow", "=ds=#w2#", "", "13%"};
		{ 16, 30242, "", "=q4=Helm of the Vanquished Champion", "=ds=#m22# #e15#", "", "61%"};
		{ 17, 30243, "", "=q4=Helm of the Vanquished Defender", "=ds=#m22# #e15#", "", "62%"};
		{ 18, 30244, "", "=q4=Helm of the Vanquished Hero", "=ds=#m22# #e15#", "", "63%"};
		{ 20, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 22, 29906, "", "=q1=Vashj's Vial Remnant", "=ds=#m3#", "", "35%"};
		Prev = "CFRSerpentMorogrim";
	};

	AtlasLoot_Data["CFRSerpentTrash"] = {
		{ 1, 30027, "", "=q4=Boots of Courage Unending", "=ds=#s12#, #a4#", "", "3%"};
		{ 2, 30022, "", "=q4=Pendant of the Perilous", "=ds=#s2#", "", "3%"};
		{ 3, 30620, "", "=q4=Spyglass of the Hidden Fleet", "=ds=#s14#", "", "4%"};
		{ 4, 30023, "", "=q4=Totem of the Maelstrom", "=ds=#s16#, #w15#", "", "3%"};
		{ 5, 30021, "", "=q4=Wildfury Greatstaff", "=ds=#w9#", "", "3%"};
		{ 6, 30025, "", "=q4=Serpentshrine Shuriken", "=ds=#w11#", "", "3%"};
		{ 8, 30324, "", "=q4=Plans: Red Havoc Boots", "=ds=#p2# (375)", "", "1%"};
		{ 9, 30322, "", "=q4=Plans: Red Belt of Battle", "=ds=#p2# (375)", "", "2%"};
		{ 10, 30323, "", "=q4=Plans: Boots of the Protector", "=ds=#p2# (375)", "", "2%"};
		{ 11, 30321, "", "=q4=Plans: Belt of the Guardian", "=ds=#p2# (375)", "", "2%"};
		{ 12, 30280, "", "=q4=Pattern: Belt of Blasting", "=ds=#p8# (375)", "", "1%"};
		{ 13, 30282, "", "=q4=Pattern: Boots of Blasting", "=ds=#p8# (375)", "", "1%"};
		{ 14, 30283, "", "=q4=Pattern: Boots of the Long Road", "=ds=#p8# (375)", "", "2%"};
		{ 15, 30281, "", "=q4=Pattern: Belt of the Long Road", "=ds=#p8# (375)", "", "1%"};
		{ 16, 30308, "", "=q4=Pattern: Hurricane Boots", "=ds=#p7# (375)", "", "1%"};
		{ 17, 30304, "", "=q4=Pattern: Monsoon Belt", "=ds=#p7# (375)", "", "1%"};
		{ 18, 30305, "", "=q4=Pattern: Boots of Natural Grace", "=ds=#p7# (375)", "", "2%"};
		{ 19, 30307, "", "=q4=Pattern: Boots of the Crimson Hawk", "=ds=#p7# (375)", "", "1%"};
		{ 20, 30306, "", "=q4=Pattern: Boots of Utter Darkness", "=ds=#p7# (375)", "", "2%"};
		{ 21, 30301, "", "=q4=Pattern: Belt of Natural Power", "=ds=#p7# (375)", "", "1%"};
		{ 22, 30303, "", "=q4=Pattern: Belt of the Black Eagle", "=ds=#p7# (375)", "", "1%"};
		{ 23, 30302, "", "=q4=Pattern: Belt of Deep Shadow", "=ds=#p7# (375)", "", "1%"};
		{ 25, 30183, "", "=q4=Nether Vortex", "=ds=#e8#", "", "75%"};
		{ 27, 32897, "", "=q2=Mark of the Illidari", "=ds=#m20#", "", "27%"};
	};

		--------------------
		--- Gruul's Lair ---
		--------------------

	AtlasLoot_Data["GruulsLairHighKingMaulgar"] = {
		{ 1, 28797, "", "=q4=Brute Cloak of the Ogre-Magi", "#s4#", "", "8.39%"};
		{ 2, 28799, "", "=q4=Belt of Divine Inspiration", "#s10#, #a1#", "", "9.98%"};
		{ 3, 28796, "", "=q4=Malefic Mask of the Shadows", "=ds=#s1#, #a2#", "", "12.93%"};
		{ 4, 28801, "", "=q4=Maulgar's Warhelm", "=ds=#s1#, #a3#", "", "21.32%"};
		{ 5, 28795, "", "=q4=Bladespire Warbands", "=ds=#s8#, #a4#", "", "12.02%"};
		{ 6, 28800, "", "=q4=Hammer of the Naaru", "=ds=#h2#, #w6#", "", "15.87%"};
		{ 16, 29763, "", "=q4=Pauldrons of the Fallen Champion", "=ds=#m21# #e15#", "", "22.68%"};
		{ 17, 29764, "", "=q4=Pauldrons of the Fallen Defender", "=ds=#m21# #e15#", "", "34.69%"};
		{ 18, 29762, "", "=q4=Pauldrons of the Fallen Hero", "=ds=#m21# #e15#", "", "25.62%"};
		{ 20, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Next = "GruulGruul";
	};

	AtlasLoot_Data["GruulGruul"] = {
		{ 1, 28804, "", "=q4=Collar of Cho'gall", "=ds=#s1#, #a1#", "", "14.96%"};
		{ 2, 28803, "", "=q4=Cowl of Nature's Breath", "=ds=#s1#, #a2#", "", "14.21%"};
		{ 3, 28828, "", "=q4=Gronn-Stitched Girdle", "=ds=#s10#, #a2#", "", "11.22%"};
		{ 4, 28827, "", "=q4=Gauntlets of the Dragonslayer", "=ds=#s9#, #a3#", "", "7.48%"};
		{ 5, 28810, "", "=q4=Windshear Boots", "=ds=#s12#, #a3#", "", "10.22%"};
		{ 6, 28824, "", "=q4=Gauntlets of Martial Perfection", "=ds=#s9#, #a4#", "", "12.22%"};
		{ 7, 28822, "", "=q4=Teeth of Gruul", "=ds=#s2#", "", "11.47%"};
		{ 8, 28823, "", "=q4=Eye of Gruul", "=ds=#s14#", "", "6.73%"};
		{ 9, 28830, "", "=q4=Dragonspine Trophy", "=ds=#s14#", "", "11.72%"};
		{ 11, 31750, "", "=q1=Earthen Signet", "=ds=#m3#", "", "100%"};
		{ 16, 29766, "", "=q4=Leggings of the Fallen Champion", "=ds=#m21# #e15#", "", "23.69%"};
		{ 17, 29767, "", "=q4=Leggings of the Fallen Defender", "=ds=#m21# #e15#", "", "17.46%"};
		{ 18, 29765, "", "=q4=Leggings of the Fallen Hero", "=ds=#m21# #e15#", "", "30.17%"};
		{ 20, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 22, 28802, "", "=q4=Bloodmaw Magus-Blade", "=ds=#h3#, #w10#", "", "9.23%"};
		{ 23, 28794, "", "=q4=Axe of the Gronn Lords", "=ds=#h2#, #w1#", "", "6.73%"};
		{ 24, 28825, "", "=q4=Aldori Legacy Defender", "=ds=#w8#", "", "2.99%"};
		{ 25, 28826, "", "=q4=Shuriken of Negation", "=ds=#w11#", "", "16.21%"};
		Prev = "GruulsLairHighKingMaulgar";
	};

		-------------------------------------------
		--- Hellfire Citadel: Hellfire Ramparts ---
		-------------------------------------------

	AtlasLoot_Data["HCRampWatchkeeper"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 24024, "", "=q3=Pauldrons of Arcane Rage", "=ds=#s3#, #a1#", "", "14.69%"};
		{ 3, 24023, "", "=q3=Bracers of Finesse", "=ds=#s8#, #a2#", "", "13.29%"};
		{ 4, 24022, "", "=q3=Scale Leggings of the Skirmisher", "=ds=#s11#, #a3#", "", "14.38%"};
		{ 5, 24021, "", "=q3=Light-Touched Breastplate", "=ds=#s5#, #a4#", "", "13.03%"};
		{ 6, 24020, "", "=q3=Shadowrend Longblade", "=ds=#h1#, #w10#", "", "13.09%"};
		{ 8, 23881, "", "=q1=Gargolmar's Hand", "=ds=#m3#", "", "100%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30593, "", "=q4=Iridescent Fire Opal", "=ds=#e7#", "", "11.11%"};
		{ 19, 30594, "", "=q4=Effulgent Chrysoprase", "=ds=#e7#", "", "12.35%"};
		{ 20, 30592, "", "=q4=Steady Chrysoprase", "=ds=#e7#", "", "8.64%"};
		{ 22, 27448, "", "=q3=Cloak of the Everliving", "=ds=#s4#", "", "28.37%"};
		{ 23, 27451, "", "=q3=Boots of the Darkwalker", "=ds=#s12#, #a1#", "", "16.61%"};
		{ 24, 27450, "", "=q3=Wild Stalker Boots", "=ds=#s12#, #a3#", "", "14.19%"};
		{ 25, 27447, "", "=q3=Bracers of Just Rewards", "=ds=#s8#, #a4#", "", "13.84%"};
		{ 26, 27449, "", "=q3=Blood Knight Defender", "=ds=#w8#", "", "13.15%"};
		{ 28, 23881, "", "=q1=Gargolmar's Hand", "=ds=#m3#", "", "100%"};
		Next = "HCRampOmor";
	};

	AtlasLoot_Data["HCRampOmor"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 2, 27465, "", "=q3=Mana-Etched Gloves", "=ds=#s9#, #a1#", "", "11.74%"};
		{ 3, 27466, "", "=q3=Headdress of Alacrity", "=ds=#s1#, #a1#", "", "12.10%"};
		{ 4, 27462, "", "=q3=Crimson Bracers of Gloom", "=ds=#s8#, #a1#", "", "7.12%"};
		{ 5, 27467, "", "=q3=Silent-Strider Kneeboots", "=ds=#s12#, #a2#", "", "16.37%"};
		{ 6, 27478, "", "=q3=Girdle of the Blasted Reaches", "=ds=#s10#, #a3#", "", "14.59%"};
		{ 7, 27539, "", "=q3=Justice Bearer's Pauldrons", "=ds=#s3#, #a4#", "", "8.90%"};
		{ 8, 27906, "", "=q3=Crimsonforge Breastplate", "#s5#, #a4#", "", "12.10%"};
		{ 9, 27464, "", "=q3=Omor's Unyielding Will", "=ds=#s2#", "", "13.52%"};
		{ 10, 27895, "", "=q3=Band of Many Prisms", "=ds=#s13#", "", "11.74%"};
		{ 11, 27477, "", "=q3=Faol's Signet of Cleansing", "=ds=#s15#", "", "10.32%"};
		{ 12, 27463, "", "=q3=Terror Flame Dagger", "=ds=#h1#, #w4#", "", "8.90%"};
		{ 13, 27476, "", "=q3=Truncheon of Five Hells", "=ds=#h1#, #w6#", "", "9.25%"};
		{ 16, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 17, 30593, "", "=q4=Iridescent Fire Opal", "=ds=#e7#", "", "11.11%"};
		{ 18, 30594, "", "=q4=Effulgent Chrysoprase", "=ds=#e7#", "", "12.35%"};
		{ 19, 30592, "", "=q4=Steady Chrysoprase", "=ds=#e7#", "", "8.64%"};
		{ 21, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 22, 24090, "", "=q3=Bloodstained Ravager Gauntlets", "=ds=#s9#, #a3#", "", "12.14%"};
		{ 23, 24091, "", "=q3=Tenacious Defender", "=ds=#s10#, #a4#", "", "12.67%"};
		{ 24, 24073, "", "=q3=Garotte-String Necklace", "=ds=#s2#", "", "11.60%"};
		{ 25, 24096, "", "=q3=Heartblood Prayer Beads", "=ds=#s2#", "", "11.15%"};
		{ 26, 24094, "", "=q3=Heart Fire Warhammer", "=ds=#h2#, #w6#", "", "14.76%"};
		{ 27, 24069, "", "=q3=Crystalfire Staff", "=ds=#w9#", "", "12.43%"};
		{ 29, 23886, "", "=q1=Omor's Hoof", "=ds=#m3#", "", "100%"};
		Prev = "HCRampWatchkeeper";
		Next = "HCRampVazruden";
	};

	AtlasLoot_Data["HCRampVazruden"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Reinforced Fel Iron Chest"], ""};
		{ 2, 24150, "", "=q3=Mok'Nathal Wildercloak", "=ds=#s4#", "", "15.65%"};
		{ 3, 24083, "", "=q3=Lifegiver Britches", "=ds=#s11#, #a1#", "", "17.00%"};
		{ 4, 24063, "", "=q3=Shifting Sash of Midnight", "=ds=#s10#, #a2#", "", "17.25%"};
		{ 5, 24046, "", "=q3=Kilt of Rolling Thunders", "=ds=#s11#, #a3#", "", "15.96%"};
		{ 6, 24064, "", "=q3=Ironsole Clompers", "=ds=#s12#, #a4#", "", "13.80%"};
		{ 7, 24045, "", "=q3=Band of Renewal", "=ds=#s13#", "", "14.44%"};
		{ 8, 24154, "", "=q3=Witching Band", "=ds=#s13#", "", "13.23%"};
		{ 9, 24151, "", "=q3=Mok'Nathal Clan Ring", "=ds=#s13#", "", "15.45%"};
		{ 10, 24044, "", "=q3=Hellreaver", "=ds=#w7#", "", "13.91%"};
		{ 11, 24155, "", "=q3=Ursol's Claw", "=ds=#w9#", "", "16.21%"};
		{ 16, 0, "INV_Box_01", "=q6="..BabbleBoss["Vazruden"], ""};
		{ 17, 23892, "", "=q1=Ominous Letter", "=ds=#m2#", "", "100%"};
		{ 19, 0, "INV_Box_01", "=q6="..BabbleBoss["Nazan"], ""};
		{ 20, 23901, "", "=q1=Nazan's Head", "=ds=#m3#", "", "100%"};
		Prev = "HCRampOmor";
	};

	AtlasLoot_Data["HCRampVazrudenHEROIC"] = {
		{ 1, 29264, "", "=q4=Tree-Mender's Belt", "=ds=#s10#, #a2#", "", "16.05%"};
		{ 2, 32077, "", "=q4=Wrath Infused Gauntlets", "=ds=#s9#, #a3#"};
		{ 3, 29238, "", "=q4=Lion's Heart Girdle", "=ds=#s10#, #a4#", "", "14.81%"};
		{ 4, 29346, "", "=q4=Feltooth Eviscerator", "=ds=#h1#, #w4#", "", "5.56%"};
		{ 6, 27452, "", "=q3=Light Scribe Bands", "=ds=#s8#, #a1#", "", "11.73%"};
		{ 7, 27461, "", "=q3=Chestguard of the Prowler", "=ds=#s5#, #a2#", "", "11.73%"};
		{ 8, 27456, "", "=q3=Raiments of Nature's Breath", "=ds=#s5#, #a2#", "", "19.75%"};
		{ 9, 27454, "", "=q3=Volcanic Pauldrons", "=ds=#s3#, #a3#", "", "16.66%"};
		{ 10, 27458, "", "=q3=Oceansong Kilt", "=ds=#s11#, #a3#", "", "10.49%"};
		{ 11, 27455, "", "=q3=Irondrake Faceguard", "=ds=#s1#, #a4#", "", "11.11%"};
		{ 12, 27459, "", "=q3=Vambraces of Daring", "=ds=#s8#, #a4#", "", "10.49%"};
		{ 13, 27457, "", "=q3=Life Bearer's Gauntlets", "=ds=#s9#, #a4#", "", "8.02%"};
		{ 16, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 17, 30593, "", "=q4=Iridescent Fire Opal", "=ds=#e7#", "", "11.11%"};
		{ 18, 30594, "", "=q4=Effulgent Chrysoprase", "=ds=#e7#", "", "12.35%"};
		{ 19, 30592, "", "=q4=Steady Chrysoprase", "=ds=#e7#", "", "8.64%"};
		{ 21, 27453, "", "=q3=Averinn's Ring of Slaying", "=ds=#s13#", "", "14.20%"};
		{ 22, 27460, "", "=q3=Reavers' Ring", "=ds=#s13#", "", "17.90%"};
		{ 24, 0, "INV_Box_01", "=q6="..BabbleBoss["Vazruden"], ""};
		{ 25, 23892, "", "=q1=Ominous Letter", "=ds=#m2#", "", "100%"};
		{ 27, 0, "INV_Box_01", "=q6="..BabbleBoss["Nazan"], ""};
		{ 28, 23901, "", "=q1=Nazan's Head", "=ds=#m3#", "", "100%"};
		Prev = "HCRampOmor";
	};

		-------------------------------------------
		--- Hellfire Citadel: The Blood Furnace ---
		-------------------------------------------

	AtlasLoot_Data["HCFurnaceMaker"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 24388, "", "=q3=Girdle of the Gale Storm", "=ds=#s10#, #a3#", "", "15.84%"};
		{ 3, 24387, "", "=q3=Ironblade Gauntlets", "=ds=#s9#, #a4#", "", "13.27%"};
		{ 4, 24385, "", "=q3=Pendant of Battle-Lust", "=ds=#s2#", "", "15.43%"};
		{ 5, 24386, "", "=q3=Libram of Saints Departed", "=ds=#s16#, #w16#", "", "14.78%"};
		{ 6, 24384, "", "=q3=Diamond-Core Sledgemace", "=ds=#h3#, #w6#", "", "12.90%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30601, "", "=q4=Beaming Fire Opal", "=ds=#e7#", "", "18.18%"};
		{ 19, 30600, "", "=q4=Fluorescent Tanzanite", "=ds=#e7#", "", "9.85%"};
		{ 20, 30602, "", "=q4=Jagged Chrysoprase", "=ds=#e7#", "", "12.12%"};
		{ 22, 27485, "", "=q3=Embroidered Cape of Mysteries", "=ds=#s4#", "", "13.89%"};
		{ 23, 27488, "", "=q3=Mage-Collar of the Firestorm", "=ds=#s1#, #a1#", "", "16.67%"};
		{ 24, 27483, "", "=q3=Moon-Touched Bands", "=ds=#s8#, #a2#", "", "25.00%"};
		{ 25, 27487, "", "=q3=Bloodlord Legplates", "=ds=#s11#, #a4#", "", "9.26%"};
		{ 26, 27484, "", "=q3=Libram of Avengement", "=ds=#s16#, #w16#", "", "14.81%"};
		Next = "HCFurnaceBroggok";
	};

	AtlasLoot_Data["HCFurnaceBroggok"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 24392, "", "=q3=Arcing Bracers", "=ds=#s8#, #a1#", "", "14.37%"};
		{ 3, 24393, "", "=q3=Bloody Surgeon's Mitts", "=ds=#s9#, #a1#", "", "17.62%"};
		{ 4, 24391, "", "=q3=Kilt of the Night Strider", "=ds=#s11#, #a2#", "", "16.58%"};
		{ 5, 24390, "", "=q3=Auslese's Light Channeler", "=ds=#s14#", "", "11.57%"};
		{ 6, 24389, "", "=q3=Legion Blunderbuss", "=ds=#w5#", "", "17.69%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30601, "", "=q4=Beaming Fire Opal", "=ds=#e7#", "", "18.18%"};
		{ 19, 30600, "", "=q4=Fluorescent Tanzanite", "=ds=#e7#", "", "9.85%"};
		{ 20, 30602, "", "=q4=Jagged Chrysoprase", "=ds=#e7#", "", "12.12%"};
		{ 22, 27848, "", "=q3=Embroidered Spellpyre Boots", "=ds=#s12#, #a1#", "", "8.33%"};
		{ 23, 27492, "", "=q3=Moonchild Leggings", "=ds=#s11#, #a2#", "", "13.89%"};
		{ 24, 27489, "", "=q3=Virtue Bearer's Vambraces", "=ds=#s8#, #a4#", "", "22.22%"};
		{ 25, 27491, "", "=q3=Signet of Repose", "=ds=#s13#", "", "30.56%"};
		{ 26, 27490, "", "=q3=Firebrand Battleaxe", "=ds=#h1#, #w1#", "", "9.72%"};
		Prev = "HCFurnaceMaker";
		Next = "HCFurnaceBreaker";
	};

	AtlasLoot_Data["HCFurnaceBreaker"] = {
		{ 1, 28264, "", "=q3=Wastewalker Tunic", "=ds=#s5#, #a2# (D3)", "", "6.82%"};
		{ 2, 27497, "", "=q3=Doomplate Gauntlets", "=ds=#s9#, #a4# (D3)", "", "9.09%"};
		{ 4, 27506, "", "=q3=Robe of Effervescent Light", "=ds=#s5#, #a1#", "", "17.42%"};
		{ 5, 27514, "", "=q3=Leggings of the Unrepentant", "=ds=#s11#, #a2#", "", "13.64%"};
		{ 6, 27522, "", "=q3=World's End Bracers", "=ds=#s8#, #a3#", "", "25.76%"};
		{ 7, 27494, "", "=q3=Emerald Eye Bracer", "=ds=#s8#, #a3#", "", "11.50%"};
		{ 8, 27505, "", "=q3=Ruby Helm of the Just", "=ds=#s1#, #a4#", "", "11.36%"};
		{ 9, 27788, "", "=q3=Bloodsworn Warboots", "=ds=#s12#, #a4#"};
		{ 10, 27495, "", "=q3=Soldier's Dog Tags", "=ds=#s2#", "", "9.85%"};
		{ 11, 28121, "", "=q3=Icon of Unyielding Courage", "=ds=#s14#", "", "8.33%"};
		{ 12, 27512, "", "=q3=The Willbreaker", "=ds=#h3#, #w10#", "", "6.06%"};
		{ 13, 27507, "", "=q3=Adamantine Repeater", "=ds=#w3#", "", "6.82%"};
		{ 15, 33814, "", "=q1=Keli'dan's Feathered Stave", "=ds=#m3#", "", "100%"};
		{ 16, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 17, 30601, "", "=q4=Beaming Fire Opal", "=ds=#e7#", "", "18.18%"};
		{ 18, 30600, "", "=q4=Fluorescent Tanzanite", "=ds=#e7#", "", "9.85%"};
		{ 19, 30602, "", "=q4=Jagged Chrysoprase", "=ds=#e7#", "", "12.12%"};
		{ 20, 32080, "", "=q4=Mantle of Shadowy Embrace", "=ds=#s3#, #a2#"};
		{ 21, 29245, "", "=q4=Wave-Crest Striders", "=ds=#s12#, #a3#", "", "3.79%"};
		{ 22, 29239, "", "=q4=Eaglecrest Warboots", "=ds=#s12#, #a4#", "", "6.82%"};
		{ 23, 29347, "", "=q4=Talisman of the Breaker", "=ds=#s2#", "", "7.58%"};
		{ 25, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 26, 24397, "", "=q3=Raiments of Divine Authority", "=ds=#s5#, #a1#", "", "16.92%"};
		{ 27, 24395, "", "=q3=Mindfire Waistband", "=ds=#s10#, #a1#", "", "16.64%"};
		{ 28, 24398, "", "=q3=Mantle of the Dusk-Dweller", "=ds=#s3#, #a2#", "", "14.29%"};
		{ 29, 24396, "", "=q3=Vest of Vengeance", "=ds=#s5#, #a2#", "", "15.46%"};
		{ 30, 24394, "", "=q3=Warsong Howling Axe", "=ds=#h2#, #w1#", "", "15.52%"};
		Prev = "HCFurnaceBroggok";
	};

		---------------------------------------------
		--- Hellfire Citadel: The Shattered Halls ---
		---------------------------------------------

	AtlasLoot_Data["HCHallsNethekurse"] = {
		{ 1, 24312, "", "=q4=Pattern: Spellstrike Hood", "=ds=#p8# (375)", "", "0.47%"};
		{ 3, 27519, "", "=q3=Cloak of Malice", "=ds=#s4#", "", "17.44%"};
		{ 4, 27517, "", "=q3=Bands of Nethekurse", "=ds=#s8#, #a1#", "", "17.52%"};
		{ 5, 27521, "", "=q3=Telaari Hunting Girdle", "=ds=#s10#, #a3#", "", "16.50%"};
		{ 6, 27520, "", "=q3=Greathelm of the Unbreakable", "=ds=#s1#, #a4#", "", "16.47%"};
		{ 7, 27518, "", "=q3=Ivory Idol of the Moongoddess", "=ds=#s16#, #w14#", "", "17.42%"};
		{ 9, 23735, "", "=q1=Grand Warlock's Amulet", "=ds=#m3#", "", "100%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 24312, "", "=q4=Pattern: Spellstrike Hood", "=ds=#p8# (375)", "", "0.47%"};
		{ 19, 30548, "", "=q4=Polished Chrysoprase", "=ds=#e7#", "", "0.16%"};
		{ 20, 30547, "", "=q4=Luminous Fire Opal", "=ds=#e7#", "", "0.19%"};
		{ 21, 30546, "", "=q4=Sovereign Tanzanite", "=ds=#e7#", "", "3.39%"};
		{ 23, 25462, "", "=q1=Tome of Dusk", "=ds=#m3#", "", "100%"};
		Next = "HCHallsOmrogg";
	};

	AtlasLoot_Data["HCHallsPorung"] = {
		{ 1, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 2, 30548, "", "=q4=Polished Chrysoprase", "=ds=#e7#", "", "0.16%"};
		{ 3, 30547, "", "=q4=Luminous Fire Opal", "=ds=#e7#", "", "0.19%"};
		{ 4, 30546, "", "=q4=Sovereign Tanzanite", "=ds=#e7#", "", "3.39%"};
		{ 6, 30709, "", "=q3=Pantaloons of Flaming Wrath", "=ds=#s11#, #a1#", "", "14.58%"};
		{ 7, 30707, "", "=q3=Nimble-foot Treads", "=ds=#s12#, #a2#", "", "10.42%"};
		{ 8, 30708, "", "=q3=Belt of Flowing Thought", "=ds=#s10#, #a3#", "", "12.50%"};
		{ 9, 30705, "", "=q3=Spaulders of Slaughter", "=ds=#s3#, #a4#", "", "21.88%"};
		{ 10, 30710, "", "=q3=Blood Guard's Necklace of Ferocity", "=ds=#s2#", "", "10.42%"};
	};

	AtlasLoot_Data["HCHallsOmrogg"] = {
		{ 1, 27802, "", "=q3=Tidefury Shoulderguards", "=ds=#s3#, #a3# (D3)", "", "17.02%"};
		{ 3, 27525, "", "=q3=Jeweled Boots of Sanctification", "=ds=#s12#, #a1#", "", "18.26%"};
		{ 4, 27868, "", "=q3=Runesong Dagger", "=ds=#h3#, #w4#", "", "15.32%"};
		{ 5, 27524, "", "=q3=Firemaul of Destruction", "=ds=#h2#, #w6#", "", "17.95%"};
		{ 6, 27526, "", "=q3=Skyfire Hawk-Bow", "=ds=#w2#", "", "17.31%"};
		{ 8, 30829, "", "=q1=Tear of the Earthmother", "=ds=#m3#", "", "100%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30548, "", "=q4=Polished Chrysoprase", "=ds=#e7#", "", "0.16%"};
		{ 19, 30547, "", "=q4=Luminous Fire Opal", "=ds=#e7#", "", "0.19%"};
		{ 20, 30546, "", "=q4=Sovereign Tanzanite", "=ds=#e7#", "", "3.39%"};
		Prev = "HCHallsNethekurse";
		Next = "HCHallsKargath";
	};

	AtlasLoot_Data["HCHallsKargath"] = {
		{ 1, 27536, "", "=q3=Hallowed Handwraps", "=ds=#s9#, #a1# (D3)", "", "12.63%"};
		{ 2, 27537, "", "=q3=Gloves of Oblivion", "=ds=#s9#, #a1# (D3)", "", "12.54%"};
		{ 3, 27531, "", "=q3=Wastewalker Gloves", "=ds=#s9#, #a2# (D3)", "", "11.03%"};
		{ 4, 27474, "", "=q3=Beast Lord Handguards", "=ds=#s9#, #a3# (D3)", "", "10.73%"};
		{ 5, 27528, "", "=q3=Gauntlets of Desolation", "=ds=#s9#, #a3# (D3)", "", "13.86%"};
		{ 6, 27535, "", "=q3=Gauntlets of the Righteous", "=ds=#s9#, #a4# (D3)", "", "11.24%"};
		{ 8, 27527, "", "=q3=Greaves of the Shatterer", "=ds=#s11#, #a4#", "", "12.89%"};
		{ 9, 27529, "", "=q3=Figurine of the Colossus", "=ds=#s14#", "", "10.41%"};
		{ 10, 27534, "", "=q3=Hortus' Seal of Brilliance", "=ds=#s15#", "", "12.98%"};
		{ 11, 27533, "", "=q3=Demonblood Eviscerator", "=ds=#h3#, #w13#", "", "12.70%"};
		{ 12, 27538, "", "=q3=Lightsworn Hammer", "=ds=#h3#, #w6#", "", "10.6%"};
		{ 13, 27540, "", "=q3=Nexus Torch", "=ds=#w12#", "", "13.02%"};
		{ 15, 23723, "", "=q1=Warchief Kargath's Fist", "=ds=#m3#", "", "100%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30548, "", "=q4=Polished Chrysoprase", "=ds=#e7#", "", "0.16%"};
		{ 19, 30547, "", "=q4=Luminous Fire Opal", "=ds=#e7#", "", "0.19%"};
		{ 20, 30546, "", "=q4=Sovereign Tanzanite", "=ds=#e7#", "", "3.39%"};
		{ 22, 29255, "", "=q4=Bands of Rarefied Magic", "=ds=#s8#, #a1#", "", "0.58%"};
		{ 23, 29263, "", "=q4=Forestheart Bracers", "=ds=#s8#, #a2#", "", "0.28%"};
		{ 24, 29254, "", "=q4=Boots of the Righteous Path", "=ds=#s12#, #a4#"};
		{ 25, 29348, "", "=q4=The Bladefist", "=ds=#h3#, #w13#", "", "3.39%"};
		{ 27, 33815, "", "=q1=Bladefist's Seal", "=ds=#m3#", "", "100%"};
		Prev = "HCHallsOmrogg";
	};

	AtlasLoot_Data["HCHallsTrash"] = {
		{ 1, 22554, "", "=q2=Formula: Enchant 2H Weapon - Savagery", "=ds=#p4# (350) =q1=#n88#", "", "1.65%"};
		{ 3, 0, "INV_Box_01", "=q6="..AL["Shattered Hand Executioner"], ""};
		{ 4, 31716, "", "=q1=Unused Axe of the Executioner", "=ds=#m3#", "", "100%"};
	};

		--------------------------------------------
		--- Hellfire Citadel: Magtheridon's Lair ---
		--------------------------------------------

	AtlasLoot_Data["HCMagtheridon"] = {
		{ 1, 28777, "", "=q4=Cloak of the Pit Stalker", "=ds=#s4#"};
		{ 2, 28780, "", "=q4=Soul-Eater's Handwraps", "=ds=#s9#, #a1#"};
		{ 3, 28776, "", "=q4=Liar's Tongue Gloves", "=ds=#s9#, #a2#"};
		{ 4, 28778, "", "=q4=Terror Pit Girdle", "=ds=#s10#, #a3#"};
		{ 5, 28775, "", "=q4=Thundering Greathelm", "=ds=#s1#, #a4#"};
		{ 6, 28779, "", "=q4=Girdle of the Endless Pit", "=ds=#s10#, #a4#"};
		{ 7, 28789, "", "=q4=Eye of Magtheridon", "=ds=#s14#"};
		{ 8, 28781, "", "=q4=Karaborian Talisman", "=ds=#s15#"};
		{ 10, 28774, "", "=q4=Glaive of the Pit", "=ds=#w7#"};
		{ 11, 28782, "", "=q4=Crystalheart Pulse-Staff", "=ds=#w9#"};
		{ 12, 29458, "", "=q4=Aegis of the Vindicator", "=ds=#w8#"};
		{ 13, 28783, "", "=q4=Eredar Wand of Obliteration", "=ds=#w12#"};
		{ 15, 34846, "", "=q2=Black Sack of Gems", "=ds=#e1#"};
		{ 16, 29754, "", "=q4=Chestguard of the Fallen Champion", "=ds=#m21# #e15#"};
		{ 17, 29753, "", "=q4=Chestguard of the Fallen Defender", "=ds=#m21# #e15#"};
		{ 18, 29755, "", "=q4=Chestguard of the Fallen Hero", "=ds=#m21# #e15#"};
		{ 20, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 22, 32385, "", "=q4=Magtheridon's Head", "=ds=#m2#", "", "100%"};
		{ 23, 28791, "", "=q4=Ring of the Recalcitrant", "=q1=#m4#: =ds=#s13#"};
		{ 24, 28790, "", "=q4=Naaru Lightwarden's Band", "=q1=#m4#: =ds=#s13#"};
		{ 25, 28793, "", "=q4=Band of Crimson Fury", "=q1=#m4#: =ds=#s13#"};
		{ 26, 28792, "", "=q4=A'dal's Signet of Defense", "=q1=#m4#: =ds=#s13#"};
		{ 28, 34845, "", "=q4=Pit Lord's Satchel", "=ds=#e1# #m15#"};
	};

		----------------
		--- Karazhan ---
		----------------

	AtlasLoot_Data["KaraCharredBoneFragment"] = {
		{ 1, 24152, "INV_Misc_Bone_10", "=q1=Charred Bone Fragment", "=ds=#m3#"};
	};

	AtlasLoot_Data["KaraNamed"] = {
		{ 1, 0, "Ability_Hunter_Pet_Spider", "=q6="..BabbleBoss["Hyakiss the Lurker"], "=q5="..AL["Spider"]};
		{ 2, 30675, "", "=q4=Lurker's Cord", "=ds=#s10#, #a1# =q2=#m16#", "", "32.81%"};
		{ 3, 30676, "", "=q4=Lurker's Grasp", "=ds=#s10#, #a2# =q2=#m16#", "", "9.38%"};
		{ 4, 30677, "", "=q4=Lurker's Belt", "=ds=#s10#, #a3# =q2=#m16#", "", "23.44%"};
		{ 5, 30678, "", "=q4=Lurker's Girdle", "=ds=#s10#, #a4# =q2=#m16#", "", "15.62%"};
		{ 7, 0, "Ability_Hunter_Pet_Hyena", "=q6="..BabbleBoss["Rokad the Ravager"], "=q5="..AL["Darkhound"]};
		{ 8, 30684, "", "=q4=Ravager's Cuffs", "=ds=#s8#, #a1# =q2=#m16#", "", "27.78%"};
		{ 9, 30685, "", "=q4=Ravager's Wrist-Wraps", "=ds=#s8#, #a2# =q2=#m16#", "", "11.11%"};
		{ 10, 30686, "", "=q4=Ravager's Bands", "=ds=#s8#, #a3# =q2=#m16#", "", "23.33%"};
		{ 11, 30687, "", "=q4=Ravager's Bracers", "=ds=#s8#, #a4# =q2=#m16#", "", "8.89%"};
		{ 16, 0, "Ability_Hunter_Pet_Bat", "=q6="..BabbleBoss["Shadikith the Glider"], "=q5="..AL["Bat"]};
		{ 17, 30680, "", "=q4=Glider's Foot-Wraps", "=ds=#s12#, #a1# =q2=#m16#", "", "9.68%"};
		{ 18, 30681, "", "=q4=Glider's Boots", "=ds=#s12#, #a2# =q2=#m16#", "", "22.58%"};
		{ 19, 30682, "", "=q4=Glider's Sabatons", "=ds=#s12#, #a3# =q2=#m16#", "", "9.68%"};
		{ 20, 30683, "", "=q4=Glider's Greaves", "=ds=#s12#, #a4# =q2=#m16#", "", "8.60%"};
	};

	AtlasLoot_Data["KaraAttumen"] = {
		{ 1, 28477, "", "=q4=Harbinger Bands", "=ds=#s8#, #a1#", "", "14.68%"};
		{ 2, 28507, "", "=q4=Handwraps of Flowing Thought", "=ds=#s9#, #a1#", "", "12.44%"};
		{ 3, 28508, "", "=q4=Gloves of Saintly Blessings", "=ds=#s9#, #a1#", "", "11.69%"};
		{ 4, 28453, "", "=q4=Bracers of the White Stag", "=ds=#s8#, #a2#", "", "12.19%"};
		{ 5, 28506, "", "=q4=Gloves of Dexterous Manipulation", "=ds=#s9#, #a2#", "", "14.68%"};
		{ 6, 28503, "", "=q4=Whirlwind Bracers", "=ds=#s8#, #a3#", "", "9.20%"};
		{ 7, 28454, "", "=q4=Stalker's War Bands", "=ds=#s8#, #a3#", "", "16.17%"};
		{ 8, 28502, "", "=q4=Vambraces of Courage", "=ds=#s8#, #a4#", "", "10.70%"};
		{ 9, 28505, "", "=q4=Gauntlets of Renewed Hope", "=ds=#s9#, #a4#", "", "10.95%"};
		{ 16, 28509, "", "=q4=Worgen Claw Necklace", "=ds=#s2#", "", "17.16%"};
		{ 17, 28510, "", "=q4=Spectral Band of Innervation", "=ds=#s13#", "", "10.70%"};
		{ 18, 28504, "", "=q4=Steelhawk Crossbow", "=ds=#w3#", "", "12.44%"};
		{ 19, 30480, "", "=q4=Fiery Warhorse's Reins", "=ds=#e12#", "", "0.25%"};
		{ 21, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 23, 23809, "", "=q3=Schematic: Stabilized Eternium Scope", "=ds=#p5# (375)", "", "1.00%"};
	};

	AtlasLoot_Data["KaraMoroes"] = {
		{ 1, 28529, "", "=q4=Royal Cloak of Arathi Kings", "=ds=#s4#", "", "15.91%"};
		{ 2, 28570, "", "=q4=Shadow-Cloak of Dalaran", "=ds=#s4#", "", "12.18%"};
		{ 3, 28565, "", "=q4=Nethershard Girdle", "=ds=#s10#, #a1#", "", "14.08%"};
		{ 4, 28545, "", "=q4=Edgewalker Longboots", "=ds=#s12#, #a2#", "", "11.07%"};
		{ 5, 28567, "", "=q4=Belt of Gale Force", "=ds=#s10#, #a3#", "", "12.05%"};
		{ 6, 28566, "", "=q4=Crimson Girdle of the Indomitable", "=ds=#s10#, #a4#", "", "10.81%"};
		{ 7, 28569, "", "=q4=Boots of Valiance", "=ds=#s12#, #a4#", "", "11.33%"};
		{ 9, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 16, 28530, "", "=q4=Brooch of Unquenchable Fury", "=ds=#s2#", "", "12.25%"};
		{ 17, 28528, "", "=q4=Moroes' Lucky Pocket Watch", "=ds=#s14#", "", "12.05%"};
		{ 18, 28525, "", "=q4=Signet of Unshakable Faith", "=ds=#s15#", "", "14.54%"};
		{ 19, 28568, "", "=q4=Idol of the Avian Heart", "=ds=#s16#, #w14#", "", "14.08%"};
		{ 20, 28524, "", "=q4=Emerald Ripper", "=ds=#h1#, #w4#", "", "12.90%"};
		{ 22, 22559, "", "=q3=Formula: Enchant Weapon - Mongoose", "=ds=#p4# (375)", "", "1.05%"};
	};

	AtlasLoot_Data["KaraKeannaLog"] = {
		{ 1, 24492, "", "=q1=Keanna's Log", "=ds=#m3#"};
	};

	AtlasLoot_Data["KaraMaiden"] = {
		{ 1, 28511, "", "=q4=Bands of Indwelling", "=ds=#s8#, #a1#", "", "12.46%"};
		{ 2, 28515, "", "=q4=Bands of Nefarious Deeds", "=ds=#s8#, #a1#", "", "13.87%"};
		{ 3, 28517, "", "=q4=Boots of Foretelling", "=ds=#s12#, #a1#", "", "16.96%"};
		{ 4, 28514, "", "=q4=Bracers of Maliciousness", "=ds=#s8#, #a2#", "", "15.90%"};
		{ 5, 28521, "", "=q4=Mitts of the Treemender", "=ds=#s9#, #a2#", "", "13.16%"};
		{ 6, 28520, "", "=q4=Gloves of Centering", "=ds=#s9#, #a3#", "", "13.16%"};
		{ 7, 28519, "", "=q4=Gloves of Quickening", "=ds=#s9#, #a3#", "", "14.22%"};
		{ 8, 28512, "", "=q4=Bracers of Justice", "=ds=#s8#, #a4#", "", "15%"};
		{ 9, 28518, "", "=q4=Iron Gauntlets of the Maiden", "=ds=#s9#, #a4#", "", "12.63%"};
		{ 16, 28516, "", "=q4=Barbed Choker of Discipline", "=ds=#s2#", "", "11.48%"};
		{ 17, 28523, "", "=q4=Totem of Healing Rains", "=ds=#s16#, #w15#", "", "14.58%"};
		{ 18, 28522, "", "=q4=Shard of the Virtuous", "=ds=#h3#, #w6#", "", "10.69%"};
		{ 20, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
	};

	AtlasLoot_Data["KaraOperaEvent"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Shared Drops"], ""};
		{ 2, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 3, 28594, "", "=q4=Trial-FireTrousers", "=ds=#s11#, #a1#", "", "15.96%"};
		{ 4, 28591, "", "=q4=Earthsoul Leggings", "=ds=#s11#, #a2#", "", "12.45%"};
		{ 5, 28589, "", "=q4=Beastmaw Pauldrons", "=ds=#s3#, #a3#", "", "12.54%"};
		{ 6, 28593, "", "=q4=Eternium Greathelm", "=ds=#s1#, #a4#", "", "11.53%"};
		{ 7, 28590, "", "=q4=Ribbon of Sacrifice", "=ds=#s14#", "", "18.41%"};
		{ 8, 28592, "", "=q4=Libram of Souls Redeemed", "=ds=#s16#, #w16#", "", "8.38%"};
		{ 10, 0, "INV_Box_01", "=q6="..BabbleBoss["The Crone"], "=q5="..AL["Wizard of Oz"]};
		{ 11, 28586, "", "=q4=Wicked Witch's Hat", "=ds=#s1#, #a1#", "", "20.12%"};
		{ 12, 28585, "", "=q4=Ruby Slippers", "=ds=#s12#, #a1#", "", "25.39%"};
		{ 13, 28587, "", "=q4=Legacy", "=ds=#h2#, #w1#", "", "20.43%"};
		{ 14, 28588, "", "=q4=Blue Diamond Witchwand", "=ds=#w12#", "", "17.96%"};
		{ 16, 0, "INV_Box_01", "=q6="..BabbleBoss["Romulo & Julianne"], "=q5="..AL["Romulo & Julianne"]};
		{ 17, 28578, "", "=q4=Masquerade Gown", "=ds=#s5#, #a1#", "", "22.73%"};
		{ 18, 28579, "", "=q4=Romulo's Poison Vial", "=ds=#s14#", "", "29.54%"};
		{ 19, 28572, "", "=q4=Blade of the Unrequited", "=ds=#h1#, #w4#", "", "13.52%"};
		{ 20, 28573, "", "=q4=Despair", "=ds=#h2#, #w10#", "", "30.07%"};
		{ 24, 0, "INV_Box_01", "=q6="..BabbleBoss["The Big Bad Wolf"], "=q5="..AL["Red Riding Hood"]};
		{ 25, 28582, "", "=q4=Red Riding Hood's Cloak", "=ds=#s4#", "", "12.85%"};
		{ 26, 28583, "", "=q4=Big Bad Wolf's Head", "=ds=#s1#, #a3#", "", "16.37%"};
		{ 27, 28584, "", "=q4=Big Bad Wolf's Paw", "=ds=#h3#, #w13#", "", "16.12%"};
		{ 28, 28581, "", "=q4=Wolfslayer Sniper Rifle", "=ds=#w5#", "", "22.42%"};
	};

	AtlasLoot_Data["KaraCurator"] = {
		{ 1, 28612, "", "=q4=Pauldrons of the Solace-Giver", "=ds=#s3#, #a1#", "", "15.19%"};
		{ 2, 28647, "", "=q4=Forest Wind Shoulderpads", "=ds=#s3#, #a2#", "", "10.56%"};
		{ 3, 28631, "", "=q4=Dragon-Quake Shoulderguards", "=ds=#s3#, #a3#", "", "13.47%"};
		{ 4, 28621, "", "=q4=Wrynn Dynasty Greaves", "=ds=#s11#, #a4#", "", "11.85%"};
		{ 5, 28649, "", "=q4=Garona's Signet Ring", "=ds=#s13#", "", "12.07%"};
		{ 6, 28633, "", "=q4=Staff of Infinite Mysteries", "=ds=#w9#", "", "12.28%"};
		{ 8, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 16, 29757, "", "=q4=Gloves of the Fallen Champion", "=ds=#m21# #e15#", "", "29.42%"};
		{ 17, 29758, "", "=q4=Gloves of the Fallen Defender", "=ds=#m21# #e15#", "", "23.60%"};
		{ 18, 29756, "", "=q4=Gloves of the Fallen Hero", "=ds=#m21# #e15#", "", "21.66%"};
	};

	AtlasLoot_Data["KaraIllhoof"] = {
		{ 1, 28660, "", "=q4=Gilded Thorium Cloak", "=ds=#s4#", "", "14.63%"};
		{ 2, 28653, "", "=q4=Shadowvine Cloak of Infusion", "=ds=#s4#", "", "10.45%"};
		{ 3, 28652, "", "=q4=Cincture of Will", "=ds=#s10#, #a1#", "", "10.75%"};
		{ 4, 28654, "", "=q4=Malefic Girdle", "=ds=#s10#, #a1#", "", "11.04%"};
		{ 5, 28655, "", "=q4=Cord of Nature's Sustenance", "=ds=#s10#, #a2#", "", "14.93%"};
		{ 6, 28656, "", "=q4=Girdle of the Prowler", "=ds=#s10#, #a3#", "", "17.91%"};
		{ 7, 28662, "", "=q4=Breastplate of the Lightbinder", "=ds=#s5#, #a4#", "", "17.31%"};
		{ 9, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 16, 28661, "", "=q4=Mender's Heart-Ring", "=ds=#s13#", "", "11.64%"};
		{ 17, 28785, "", "=q4=The Lightning Capacitor", "=ds=#s14#", "", "10.75%"};
		{ 18, 28657, "", "=q4=Fool's Bane", "=ds=#h1#, #w6#", "", "14.63%"};
		{ 19, 28658, "", "=q4=Terestian's Stranglestaff", "=ds=#w9#", "", "7.46%"};
		{ 20, 28659, "", "=q4=Xavian Stiletto", "=ds=#w11#", "", "13.43%"};
		{ 22, 22561, "", "=q3=Formula: Enchant Weapon - Soulfrost", "=ds=#p4# (375)", "", "0.30%"};
	};

	AtlasLoot_Data["KaraAran"] = {
		{ 1, 28672, "", "=q4=Drape of the Dark Reavers", "=ds=#s4#", "", "11.70%"};
		{ 2, 28726, "", "=q4=Mantle of the Mind Flayer", "=ds=#s3#, #a1#", "", "16.03%"};
		{ 3, 28670, "", "=q4=Boots of the Infernal Coven", "=ds=#s12#, #a1#", "", "9.29%"};
		{ 4, 28663, "", "=q4=Boots of the Incorrupt", "=ds=#s12#, #a1#", "", "12.72%"};
		{ 5, 28669, "", "=q4=Rapscallion Boots", "=ds=#s12#, #a2#", "", "11.32%"};
		{ 6, 28671, "", "=q4=Steelspine Faceguard", "=ds=#s1#, #a3#", "", "12.21%"};
		{ 7, 28666, "", "=q4=Pauldrons of the Justice-Seeker", "=ds=#s3#, #a4#", "", "11.58%"};
		{ 9, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 11, 23933, "", "=q1=Medivh's Journal", "=ds=#m3#", "", "100%"};
		{ 16, 28674, "", "=q4=Saberclaw Talisman", "=ds=#s2#", "", "11.20%"};
		{ 17, 28675, "", "=q4=Shermanar Great-Ring", "=ds=#s13#", "", "10.43%"};
		{ 18, 28727, "", "=q4=Pendant of the Violet Eye", "=ds=#s14#", "", "15.39%"};
		{ 19, 28728, "", "=q4=Aran's Soothing Sapphire", "=ds=#s15#", "", "12.72%"};
		{ 20, 28673, "", "=q4=Tirisfal Wand of Ascendancy", "=ds=#w12#", "", "7.25%"};
		{ 22, 22560, "", "=q3=Formula: Enchant Weapon - Sunfire", "=ds=#p4# (375)", "", "0.76%"};
	};

	AtlasLoot_Data["KaraNetherspite"] = {
		{ 1, 28744, "", "=q4=Uni-Mind Headdress", "=ds=#s1#, #a1#", "", "12.91%"};
		{ 2, 28742, "", "=q4=Pantaloons of Repentence", "=ds=#s11#, #a1#", "", "10.99%"};
		{ 3, 28732, "", "=q4=Cowl of Defiance", "=ds=#s1#, #a2#", "", "17.31%"};
		{ 4, 28741, "", "=q4=Skulker's Greaves", "=ds=#s11#, #a2#", "", "15.38%"};
		{ 5, 28735, "", "=q4=Earthblood Chestguard", "=ds=#s5#, #a3#", "", "15.93%"};
		{ 6, 28740, "", "=q4=Rip-Flayer Leggings", "=ds=#s11#, #a3#", "", "10.16%"};
		{ 7, 28743, "", "=q4=Mantle of Abrahmis", "=ds=#s3#, #a4#", "", "9.34%"};
		{ 8, 28733, "", "=q4=Girdle of Truth", "=ds=#s10#, #a4#", "", "10.44%"};
		{ 16, 28731, "", "=q4=Shining Chain of the Afterworld", "=ds=#s2#", "", "15.11%"};
		{ 17, 28730, "", "=q4=Mithril Band of the Unscarred", "=ds=#s13#", "", "10.99%"};
		{ 18, 28734, "", "=q4=Jewel of Infinite Possibilities", "=ds=#s15#", "", "11.64%"};
		{ 19, 28729, "", "=q4=Spiteblade", "=ds=#h1#, #w10#", "", "6.32%"};
		{ 21, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
	};

	AtlasLoot_Data["KaraChess"] = {
		{ 1, 28756, "", "=q4=Headdress of the High Potentate", "=ds=#s1#, #a1#", "", "17.98%"};
		{ 2, 28755, "", "=q4=Bladed Shoulderpads of the Merciless", "=ds=#s3#, #a2#", "", "13.55%"};
		{ 3, 28750, "", "=q4=Girdle of Treachery", "=ds=#s10#, #a2#", "", "15.02%"};
		{ 4, 28752, "", "=q4=Forestlord Striders", "=ds=#s12#, #a2#", "", "14.04%"};
		{ 5, 28751, "", "=q4=Heart-Flame Leggings", "=ds=#s11#, #a3#", "", "12.56%"};
		{ 6, 28746, "", "=q4=Fiend Slayer Boots", "=ds=#s12#, #a3#", "", "16.26%"};
		{ 7, 28748, "", "=q4=Legplates of the Innocent", "=ds=#s11#, #a4#", "", "13.79%"};
		{ 8, 28747, "", "=q4=Battlescar Boots", "=ds=#s12#, #a4#", "", "13.79%"};
		{ 16, 28745, "", "=q4=Mithril Chain of Heroism", "=ds=#s2#", "", "12.81%"};
		{ 17, 28753, "", "=q4=Ring of Recurrence", "=ds=#s13#", "", "12.56%"};
		{ 18, 28749, "", "=q4=King's Defender", "=ds=#h1#, #w10#", "", "12.07%"};
		{ 19, 28754, "", "=q4=Triptych Shield of the Ancients", "=ds=#w8#", "", "13.30%"};
		{ 21, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
	};

	AtlasLoot_Data["KaraNightbane"] = {
		{ 1, 28602, "", "=q4=Robe of the Elder Scribes", "=ds=#s5#, #a1#", "", "17.38%"};
		{ 2, 28600, "", "=q4=Stonebough Jerkin", "=ds=#s5#, #a2#", "", "13.33%"};
		{ 3, 28601, "", "=q4=Chestguard of the Conniver", "=ds=#s5#, #a2#", "", "10.24%"};
		{ 4, 28599, "", "=q4=Scaled Breastplate of Carnage", "=ds=#s5#, #a3#", "", "11.67%"};
		{ 5, 28610, "", "=q4=Ferocious Swift-Kickers", "=ds=#s12#, #a3#", "", "15.71%"};
		{ 6, 28597, "", "=q4=Panzar'Thar Breastplate", "=ds=#s5#, #a4#", "", "10.00%"};
		{ 7, 28608, "", "=q4=Ironstriders of Urgency", "=ds=#s12#, #a4#", "", "9.05%"};
		{ 9, 31751, "", "=q1=Blazing Signet", "=ds=#m3#", "", "100%"};
		{ 10, 24139, "", "=q1=Faint Arcane Essence", "=ds=#m3#", "", "100%"};
		{ 16, 28609, "", "=q4=Emberspur Talisman", "=ds=#s2#", "", "13.33%"};
		{ 17, 28603, "", "=q4=Talisman of Nightbane", "=ds=#s15#", "", "12.62%"};
		{ 18, 28604, "", "=q4=Nightstaff of the Everliving", "=ds=#w9#", "", "16.67%"};
		{ 19, 28611, "", "=q4=Dragonheart Flameshield", "=ds=#w8#", "", "13.57%"};
		{ 20, 28606, "", "=q4=Shield of Impenetrable Darkness", "=ds=#w8#", "", "12.14%"};
		{ 22, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
	};

	AtlasLoot_Data["KaraPrince"] = {
		{ 1, 28765, "", "=q4=Stainless Cloak of the Pure Hearted", "=ds=#s4#", "", "10.37%"};
		{ 2, 28766, "", "=q4=Ruby Drape of the Mysticant", "=ds=#s4#", "", "12.50%"};
		{ 3, 28764, "", "=q4=Farstrider Wildercloak", "=ds=#s4#", "", "15.96%"};
		{ 4, 28762, "", "=q4=Adornment of Stolen Souls", "=ds=#s2#", "", "9.57%"};
		{ 5, 28763, "", "=q4=Jade Ring of the Everliving", "=ds=#s13#", "", "11.84%"};
		{ 6, 28757, "", "=q4=Ring of a Thousand Marks", "=ds=#s13#", "", "12.90%"};
		{ 8, 28770, "", "=q4=Nathrezim Mindblade", "=ds=#h3#, #w4#", "", "10.64%"};
		{ 9, 28768, "", "=q4=Malchazeen", "=ds=#h1#, #w4#", "", "9.84%"};
		{ 10, 28767, "", "=q4=The Decapitator", "=ds=#h1#, #w1#", "", "15.43%"};
		{ 11, 28773, "", "=q4=Gorehowl", "=ds=#h2#, #w1#", "", "12.63%"};
		{ 12, 28771, "", "=q4=Light's Justice", "=ds=#h3#, #w6#", "", "11.17%"};
		{ 13, 28772, "", "=q4=Sunfury Bow of the Phoenix", "=ds=#w2#", "", "9.97%"};
		{ 16, 29760, "", "=q4=Helm of the Fallen Champion", "=ds=#m21# #e15#", "", "23.01%"};
		{ 17, 29761, "", "=q4=Helm of the Fallen Defender", "=ds=#m21# #e15#", "", "26.73%"};
		{ 18, 29759, "", "=q4=Helm of the Fallen Hero", "=ds=#m21# #e15#", "", "20.48%"};
		{ 20, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
	};

	AtlasLoot_Data["KaraTrash"] = {
		{ 1, 30642, "", "=q4=Drape of the Righteous", "=ds=#s4#", "", "0.22%"};
		{ 2, 30668, "", "=q4=Grasp of the Dead", "=ds=#s9#, #a1#", "", "0.17%"};
		{ 3, 30673, "", "=q4=Inferno Waist Cord", "=ds=#s10#, #a1#", "", "0.21%"};
		{ 4, 30644, "", "=q4=Grips of the Deftness", "=ds=#s9#, #a2#", "", "0.23%"};
		{ 5, 30674, "", "=q4=Zierhut's Lost Treads", "=ds=#s12#, #a2#", "", "0.17%"};
		{ 6, 30643, "", "=q4=Belt of the Tracker", "=ds=#s10#, #a3#", "", "0.19%"};
		{ 7, 30641, "", "=q4=Boots of Elusion", "=ds=#s12#, #a4#", "", "0.13%"};
		{ 9, 23857, "", "=q1=Legacy of the Mountain King", "=ds="};
		{ 10, 23864, "", "=q1=Torment of the Worgen", "=ds="};
		{ 11, 23862, "", "=q1=Redemption of the Fallen", "=ds="};
		{ 12, 23865, "", "=q1=Wrath of the Titans", "=ds="};
		{ 14, 21882, "", "=q1=Soul Essence", "=ds=#e8#"};
		{ 16, 30666, "", "=q4=Ritssyn's Lost Pendant", "=ds=#s2#", "", "0.18%"};
		{ 17, 30667, "", "=q4=Ring of Unrelenting Storms", "=ds=#s13#", "", "0.17%"};
		{ 19, 21903, "", "=q4=Pattern: Soulcloth Shoulders", "=ds=#p8# (375)", "", "0.74%"};
		{ 20, 21904, "", "=q4=Pattern: Soulcloth Vest", "=ds=#p8# (375)", "", "1.07%"};
		{ 21, 22545, "", "=q2=Formula: Enchant Boots - Surefooted", "=ds=#p4# (370)", "", "0.66%"};
	};

		----------------------------------------
		--- Sunwell Isle: Magister's Terrace ---
		----------------------------------------

	AtlasLoot_Data["SMTFireheart"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 34702, "", "=q3=Cloak of Swift Mending", "=ds=#s4#", "", "5%"};
		{ 3, 34697, "", "=q3=Bindings of Raging Fire", "=ds=#s8#, #a1#", "", "5%"};
		{ 4, 34701, "", "=q3=Leggings of the Betrayed", "=ds=#s11#, #a2#", "", "5%"};
		{ 5, 34698, "", "=q3=Bracers of the Forest Stalker", "=ds=#s8#, #a3#", "", "5%"};
		{ 6, 34700, "", "=q3=Gauntlets of Divine Blessings", "=ds=#s9#, #a4#", "", "5%"};
		{ 7, 34699, "", "=q3=Sun-forged Cleaver", "=ds=#h1#, #w1#", "", "5%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 34602, "", "=q4=Eversong Cuffs", "=ds=#s8#, #a2#", "", "20%"};
		{ 19, 34601, "", "=q4=Shoulderplates of Everlasting Pain", "=ds=#s3#, #a4#", "", "21%"};
		{ 20, 34604, "", "=q4=Jaded Crystal Dagger", "=ds=#h3#, #w4#", "", "21%"};
		{ 21, 34603, "", "=q4=Distracting Blades", "=ds=#w11#", "", "21%"};
		{ 23, 35275, "", "=q3=Orb of the Sin'dorei", "=ds=#m20#", "", "2%"};
		Next = "SMTVexallus";
	};

	AtlasLoot_Data["SMTVexallus"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 34708, "", "=q3=Cloak of the Coming Night", "=ds=#s4#", "", "17%"};
		{ 3, 34705, "", "=q3=Bracers of Divine Infusion", "=ds=#s8#, #a1#", "", "5%"};
		{ 4, 34707, "", "=q3=Boots of Resuscitation", "=ds=#s12#, #a2#", "", "16%"};
		{ 5, 34704, "", "=q3=Band of Arcane Alacrity", "=ds=#s13#", "", "18%"};
		{ 6, 34706, "", "=q3=Band of Determination", "=ds=#s13#", "", "5%"};
		{ 7, 34703, "", "=q3=Latro's Dancing Blade", "=ds=#h1#, #w10#", "", "16%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 34607, "", "=q4=Fel-tinged Mantle", "=ds=#s3#, #a1#", "", "20%"};
		{ 19, 34605, "", "=q4=Breastplate of Fierce Survival", "=ds=#s5#, #a4#", "", "19%"};
		{ 20, 34606, "", "=q4=Edge of Oppression", "=ds=#h1#, #w4#", "", "20%"};
		{ 21, 34608, "", "=q4=Rod of the Blazing Light", "=ds=#w9#", "", "19%"};
		{ 23, 35275, "", "=q3=Orb of the Sin'dorei", "=ds=#m20#", "", "2%"};
		Prev = "SMTFireheart";
		Next = "SMTDelrissa";
	};

	AtlasLoot_Data["SMTDelrissa"] = {
		{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
		{ 2, 34792, "", "=q3=Cloak of the Betrayed", "=ds=#s4#", "", "17%"};
		{ 3, 34788, "", "=q3=Duskhallow Mantle", "=ds=#s3#, #a1#", "", "5%"};
		{ 4, 34791, "", "=q3=Gauntlets of the Tranquil Waves", "=ds=#s9#, #a3#", "", "16%"};
		{ 5, 34789, "", "=q3=Bracers of Slaughter", "=ds=#s8#, #a4#", "", "17%"};
		{ 6, 34790, "", "=q3=Battle-mace of the High Priestess", "=ds=#h3#, #w6#", "", "16%"};
		{ 7, 34783, "", "=q3=Nightstrike", "=ds=#w11#", "", "17%"};
		{ 9, 35756, "", "=q3=Formula: Enchant Cloak - Steelweave", "=ds=#p4# (375)", "", "14%"};
		{ 16, 0, "INV_Box_01", "=q6=#j3#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 34473, "", "=q4=Commendation of Kael'thas", "=ds=#s14#", "", "19%"};
		{ 19, 34472, "", "=q4=Shard of Contempt", "=ds=#s14#", "", "19%"};
		{ 20, 34470, "", "=q4=Timbal's Focusing Crystal", "=ds=#s14#", "", "19%"};
		{ 21, 34471, "", "=q4=Vial of the Sunwell", "=ds=#s14#", "", "19%"};
		{ 23, 35275, "", "=q3=Orb of the Sin'dorei", "=ds=#m20#", "", "2%"};
		Prev = "SMTVexallus";
		Next = "SMTKaelthas";
	};

	AtlasLoot_Data["SMTKaelthas"] = {
		{ 1, 34810, "", "=q4=Cloak of Blade Turning", "=ds=#s4#", "", "5%"};
		{ 2, 34808, "", "=q4=Gloves of Arcane Acuity", "=ds=#s9#, #a1#", "", "5%"};
		{ 3, 34809, "", "=q4=Sunrage Treads", "=ds=#s12#, #a2#", "", "15%"};
		{ 4, 34799, "", "=q4=Hauberk of the War Bringer", "=ds=#s5#, #a3#", "", "13%"};
		{ 5, 34807, "", "=q4=Sunstrider Warboots", "=ds=#s12#, #a4#", "", "5%"};
		{ 6, 34625, "", "=q4=Kharmaa's Ring of Fate", "=ds=#s13#", "", "5%"};
		{ 8, 34157, "", "=q1=Head of Kael'thas", "=ds=#m3#", "", "56%"};
		{ 16, 34793, "", "=q3=Cord of Reconstruction", "=ds=#s10#, #a1#", "", "5%"};
		{ 17, 34796, "", "=q3=Robes of Summer Flame", "=ds=#s5#, #a2#", "", "5%"};
		{ 18, 34795, "", "=q3=Helm of Sanctification", "=ds=#s1#, #a4#", "", "5%"};
		{ 19, 34798, "", "=q3=Band of Celerity", "=ds=#s13#", "", "5%"};
		{ 20, 34794, "", "=q3=Axe of Shattered Dreams", "=ds=#h2#, #w1#", "", "5%"};
		{ 21, 34797, "", "=q3=Sun-infused Focus Staff", "=ds=#w9#", "", "14%"};
		{ 22, 35504, "", "=q3=Phoenix Hatchling", "=ds=#e13#", "", "7%"};
		Prev = "SMTDelrissa";
	};

	AtlasLoot_Data["SMTKaelthasHEROIC"] = {
		{ 1, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 2, 34610, "", "=q4=Scarlet Sin'dorei Robes", "=ds=#s5#, #a1#", "", "19%"};
		{ 3, 34613, "", "=q4=Shoulderpads of the Silvermoon Retainer", "=ds=#s3#, #a2#", "", "19%"};
		{ 4, 34614, "", "=q4=Tunic of the Ranger Lord", "=ds=#s5#, #a3#", "", "18%"};
		{ 5, 34615, "", "=q4=Netherforce Chestplate", "=ds=#s5#, #a4#", "", "19%"};
		{ 6, 34612, "", "=q4=Greaves of the Penitent Knight", "=ds=#s12#, #a4#", "", "19%"};
		{ 8, 34160, "", "=q1=The Signet Ring of Prince Kael'thas", "=ds=#m3#", "", "12%"};
		{ 16, 34609, "", "=q4=Quickening Blade of the Prince", "=ds=#h1#, #w10#", "", "20%"};
		{ 17, 34616, "", "=q4=Breeching Comet", "=ds=#h1#, #w1#", "", "19%"};
		{ 18, 34611, "", "=q4=Cudgel of Consecration", "=ds=#h3#, #w6#", "", "19%"};
		{ 19, 35513, "", "=q4=Swift White Hawkstrider", "=ds=#e12#", "", "3%"};
		{ 21, 35504, "", "=q3=Phoenix Hatchling", "=ds=#e13#", "", "7%"};
		Prev = "SMTDelrissa";
	};

	AtlasLoot_Data["SMTTrash"] = {
		{ 1, 35516, "", "=q3=Sun Touched Satchel", "=ds=#e1# #m15#", "", "1%"};
	};

		-------------------------------------
		--- Sunwell Isle: Sunwell Plateau ---
		-------------------------------------

	AtlasLoot_Data["SPKalecgos"] = {
		{ 1, 34170, "", "=q4=Pantaloons of Calming Strife", "=ds=#s11#, #a1#"};
		{ 2, 34386, "", "=q4=Pantaloons of Growing Strife", "=ds=#m29#"};
		{ 3, 34169, "", "=q4=Breeches of Natural Aggression", "=ds=#s11#, #a2#"};
		{ 4, 34384, "", "=q4=Breeches of Natural Splendor", "=ds=#m29#"};
		{ 5, 34168, "", "=q4=Starstalker Legguards", "=ds=#s11#, #a3#", "", "1.#INF%"};
		{ 6, 34167, "", "=q4=Legplates of the Holy Juggernaut", "=ds=#s11#, #a4#"};
		{ 7, 34382, "", "=q4=Judicator's Legguards", "=ds=#m29#"};
		{ 8, 34166, "", "=q4=Band of Lucent Beams", "=ds=#s13#", "", "1.#INF%"};
		{ 9, 34165, "", "=q4=Fang of Kalecgos", "=ds=#h1#, #w4#"};
		{ 10, 34164, "", "=q4=Dragonscale-Encrusted Longblade", "=ds=#h1#, #w10#"};
		{ 16, 34848, "", "=q4=Bracers of the Forgotten Conqueror", "=ds=#m23# #e15#", "", "10%"};
		{ 17, 34851, "", "=q4=Bracers of the Forgotten Protector", "=ds=#m23# #e15#", "", "11%"};
		{ 18, 34852, "", "=q4=Bracers of the Forgotten Vanquisher", "=ds=#m23# #e15#", "", "12%"};
		{ 20, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Next = "SPBrutallus";
	};

	AtlasLoot_Data["SPBrutallus"] = {
		{ 1, 34181, "", "=q4=Leggings of Calamity", "=ds=#s11#, #a1#", "", "15%"};
		{ 2, 34180, "", "=q4=Felfury Legplates", "=ds=#s11#, #a4#", "", "13%"};
		{ 3, 34381, "", "=q4=Felstrength Legplates", "=ds=#m29#"};
		{ 4, 34178, "", "=q4=Collar of the Pit Lord", "=ds=#s2#", "", "15%"};
		{ 5, 34177, "", "=q4=Clutch of Demise", "=ds=#s2#", "", "15%"};
		{ 6, 34179, "", "=q4=Heart of the Pit", "=ds=#s15#", "", "13%"};
		{ 7, 34176, "", "=q4=Reign of Misery", "=ds=#h3#, #w6#", "", "17%"};
		{ 16, 34853, "", "=q4=Belt of the Forgotten Conqueror", "=ds=#m23# #e15#", "", "74%"};
		{ 17, 34854, "", "=q4=Belt of the Forgotten Protector", "=ds=#m23# #e15#", "", "70%"};
		{ 18, 34855, "", "=q4=Belt of the Forgotten Vanquisher", "=ds=#m23# #e15#", "", "75%"};
		{ 20, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "SPKalecgos";
		Next = "SPFelmyst";
	};

	AtlasLoot_Data["SPFelmyst"] = {
		{ 1, 34352, "", "=q4=Borderland Fortress Grips", "=ds=#s9#, #a4#", "", "15%"};
		{ 2, 34188, "", "=q4=Leggings of the Immortal Night", "=ds=#s11#, #a2#", "", "14%"};
		{ 3, 34385, "", "=q4=Leggings of the Immortal Beast", "=ds=#m29#"};
		{ 4, 34186, "", "=q4=Chain Links of the Tumultuous Storm", "=ds=#s11#, #a3#", "", "15%"};
		{ 5, 34383, "", "=q4=Kilt of Spiritual Reconstruction", "=ds=#m29#"};
		{ 6, 34184, "", "=q4=Brooch of the Highborne", "=ds=#s2#", "", "16%"};
		{ 7, 34185, "", "=q4=Sword Breaker's Bulwark", "=ds=#w8#", "", "16%"};
		{ 8, 34182, "", "=q4=Grand Magister's Staff of Torrents", "=ds=#w9#", "", "17%"};
		{ 16, 34856, "", "=q4=Boots of the Forgotten Conqueror", "=ds=#m23# #e15#", "", "79%"};
		{ 17, 34857, "", "=q4=Boots of the Forgotten Protector", "=ds=#m23# #e15#", "", "86%"};
		{ 18, 34858, "", "=q4=Boots of the Forgotten Vanquisher", "=ds=#m23# #e15#", "", "77%"};
		{ 20, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "SPBrutallus";
		Next = "SPEredarTwins";
	};

	AtlasLoot_Data["SPEredarTwins"] = {
		{ 1, 34205, "", "=q4=Shroud of Redeemed Souls", "=ds=#s4#", "", "18%"};
		{ 2, 34190, "", "=q4=Crimson Paragon's Cover", "=ds=#s4#", "", "16%"};
		{ 3, 34210, "", "=q4=Amice of the Convoker", "=ds=#s3#, #a1#", "", "19%"};
		{ 4, 34202, "", "=q4=Shawl of Wonderment", "=ds=#s3#, #a1#", "", "23%"};
		{ 5, 34393, "", "=q4=Shoulderpads of Knowledge's Pursuit", "=ds=#m29#"};
		{ 6, 34209, "", "=q4=Spaulders of Reclamation", "=ds=#s3#, #a2#", "", "20%"};
		{ 7, 34391, "", "=q4=Spaulders of Devastation", "=ds=#m29#"};
		{ 8, 34195, "", "=q4=Shoulderpads of Vehemence", "=ds=#s3#, #a2#", "", "17%"};
		{ 9, 34392, "", "=q4=Demontooth Shoulderpads", "=ds=#m29#"};
		{ 10, 34194, "", "=q4=Mantle of the Golden Forest", "=ds=#s3#, #a3#", "", "21%"};
		{ 11, 34208, "", "=q4=Equilibrium Epaulets", "=ds=#s3#, #a3#", "", "19%"};
		{ 12, 34390, "", "=q4=Erupting Epaulets", "=ds=#m29#"};
		{ 13, 34192, "", "=q4=Pauldrons of Perseverance", "=ds=#s3#, #a4#", "", "19%"};
		{ 14, 34388, "", "=q4=Pauldrons of Berserking", "=ds=#m29#"};
		{ 16, 34193, "", "=q4=Spaulders of the Thalassian Savior", "=ds=#s3#, #a4#", "", "17%"};
		{ 17, 34389, "", "=q4=Spaulders of the Thalassian Defender", "=ds=#m29#"};
		{ 18, 35290, "", "=q4=Sin'dorei Pendant of Conquest", "=ds=#s2#", "", "33%"};
		{ 19, 35291, "", "=q4=Sin'dorei Pendant of Salvation", "=ds=#s2#", "", "32%"};
		{ 20, 35292, "", "=q4=Sin'dorei Pendant of Triumph", "=ds=#s2#", "", "32%"};
		{ 21, 34204, "", "=q4=Amulet of Unfettered Magics", "=ds=#s2#", "", "20%"};
		{ 22, 34189, "", "=q4=Band of Ruinous Delight", "=ds=#s13#", "", "18%"};
		{ 23, 34206, "", "=q4=Book of Highborne Hymns", "=ds=#s15#", "", "22%"};
		{ 24, 34197, "", "=q4=Shiv of Exsanguination", "=ds=#h1#, #w4#", "", "23%"};
		{ 25, 34199, "", "=q4=Archon's Gavel", "=ds=#h3#, #w6#", "", "17%"};
		{ 26, 34203, "", "=q4=Grip of Mannoroth", "=ds=#h4#, #w13#", "", "20%"};
		{ 27, 34198, "", "=q4=Stanchion of Primal Instinct", "=ds=#w9#", "", "19%"};
		{ 28, 34196, "", "=q4=Golden Bow of Quel'Thalas", "=ds=#w3#", "", "18%"};
		{ 30, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "SPFelmyst";
		Next = "SPMuru";
	};

	AtlasLoot_Data["SPMuru"] = {
		{ 1, 34232, "", "=q4=Fel Conquerer Raiments", "=ds=#s5#, #a1#", "", "13%"};
		{ 2, 34233, "", "=q4=Robes of Faltered Light", "=ds=#s5#, #a1#", "", "17%"};
		{ 3, 34399, "", "=q4=Robes of Ghostly Hatred", "=ds=#m29#"};
		{ 4, 34212, "", "=q4=Sunglow Vest", "=ds=#s5#, #a2#", "", "14%"};
		{ 5, 34398, "", "=q4=Utopian Tunic of Elune", "=ds=#m29#"};
		{ 6, 34211, "", "=q4=Harness of Carnal Instinct", "=ds=#s5#, #a2#", "", "15%"};
		{ 7, 34397, "", "=q4=Bladed Chaos Tunic", "=ds=#m29#"};
		{ 8, 34234, "", "=q4=Shadowed Gauntlets of Paroxysm", "=ds=#s9#, #a2#", "", "18%"};
		{ 9, 34408, "", "=q4=Gloves of the Forest Drifter", "=ds=#m29#"};
		{ 10, 34229, "", "=q4=Garments of Serene Shores", "=ds=#s5#, #a3#", "", "13%"};
		{ 11, 34396, "", "=q4=Garments of Crashing Shores", "=ds=#m29#"};
		{ 12, 34228, "", "=q4=Vicious Hawkstrider Hauberk", "=ds=#s5#, #a3#", "", "15%"};
		{ 13, 34215, "", "=q4=Warharness of Reckless Fury", "=ds=#s5#, #a4#", "", "16%"};
		{ 14, 34394, "", "=q4=Breastplate of Agony's Aversion", "=ds=#m29#"};
		{ 15, 34240, "", "=q4=Gauntlets of the Soothed Soul", "=ds=#s9#, #a4#", "", "15%"};
		{ 16, 34216, "", "=q4=Heroic Judicator's Chestguard", "=ds=#s5#, #a4#", "", "16%"};
		{ 17, 34395, "", "=q4=Noble Judicator's Chestguard", "=ds=#m29#"};
		{ 18, 34213, "", "=q4=Ring of Hardened Resolve", "=ds=#s13#", "", "15%"};
		{ 19, 34230, "", "=q4=Ring of Omnipotence", "=ds=#s13#", "", "16%"};
		{ 20, 35282, "", "=q4=Sin'dorei Band of Dominance", "=ds=#s13#", "", "31%"};
		{ 21, 35283, "", "=q4=Sin'dorei Band of Salvation", "=ds=#s13#", "", "31%"};
		{ 22, 35284, "", "=q4=Sin'dorei Band of Triumph", "=ds=#s13#", "", "34%"};
		{ 23, 34427, "", "=q4=Blackened Naaru Sliver", "=ds=#s14#", "", "13%"};
		{ 24, 34430, "", "=q4=Glimmering Naaru Sliver", "=ds=#s14#", "", "16%"};
		{ 25, 34429, "", "=q4=Shifting Naaru Sliver", "=ds=#s14#", "", "15%"};
		{ 26, 34428, "", "=q4=Steely Naaru Sliver", "=ds=#s14#", "", "15%"};
		{ 27, 34214, "", "=q4=Muramasa", "=ds=#h1#, #w10#", "", "16%"};
		{ 28, 34231, "", "=q4=Aegis of Angelic Fortune", "=ds=#w8#", "", "14%"};
		{ 30, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "SPEredarTwins";
		Next = "SPKiljaeden";
	};

	AtlasLoot_Data["SPKiljaeden"] = {
		{ 1, 34241, "", "=q4=Cloak of Unforgivable Sin", "=ds=#s4#", "", "16%"};
		{ 2, 34242, "", "=q4=Tattered Cape of Antonidas", "=ds=#s4#", "", "16%"};
		{ 3, 34339, "", "=q4=Cowl of Light's Purity", "=ds=#s1#, #a1#", "", "18%"};
		{ 4, 34405, "", "=q4=Helm of Arcane Purity", "=ds=#m29#"};
		{ 5, 34340, "", "=q4=Dark Conjuror's Collar", "=ds=#s1#, #a1#", "", "20%"};
		{ 6, 34342, "", "=q4=Handguards of the Dawn", "=ds=#s9#, #a1#", "", "19%"};
		{ 7, 34406, "", "=q4=Gloves of Tyri's Power", "=ds=#m29#"};
		{ 8, 34344, "", "=q4=Handguards of the Defiled Worlds", "=ds=#s9#, #a1#", "", "22%"};
		{ 9, 34244, "", "=q4=Duplicitous Guise", "=ds=#s1#, #a2#", "", "17%"};
		{ 10, 34404, "", "=q4=Mask of the Furry Hunter", "=ds=#m29#"};
		{ 11, 34245, "", "=q4=Cover of Ursol the Wise", "=ds=#s1#, #a2#", "", "14%"};
		{ 12, 34403, "", "=q4=Cover of Ursoc the Mighty", "=ds=#m29#"};
		{ 13, 34333, "", "=q4=Coif of Alleria", "=ds=#s1#, #a3#", "", "14%"};
		{ 14, 34332, "", "=q4=Cowl of Gul'dan", "=ds=#s1#, #a3#", "", "14%"};
		{ 15, 34402, "", "=q4=Shroud of Chieftain Ner'zhul", "=ds=#m29#"};
		{ 16, 34343, "", "=q4=Thalassian Ranger Gauntlets", "=ds=#s9#, #a3#", "", "18%"};
		{ 17, 34243, "", "=q4=Helm of Burning Righteousness", "=ds=#s1#, #a4#", "", "21%"};
		{ 18, 34401, "", "=q4=Helm of Uther's Resolve", "=ds=#m29#"};
		{ 19, 34345, "", "=q4=Crown of Anasterian", "=ds=#s1#, #a4#", "", "16%"};
		{ 20, 34400, "", "=q4=Crown of Dath'Remar", "=ds=#m29#"};
		{ 21, 34341, "", "=q4=Borderland Paingrips", "=ds=#s9#, #a4#", "", "18%"};
		{ 23, 34334, "", "=q5=Thori'dal, the Stars' Fury", "=ds=#w2#", "", "6%"};
		{ 25, 34329, "", "=q4=Crux of the Apocalypse", "=ds=#h1#, #w4#", "", "16%"};
		{ 26, 34247, "", "=q4=Apolyon, the Soul-Render", "=ds=#h2#, #w10#", "", "17%"};
		{ 27, 34335, "", "=q4=Hammer of Sanctification", "=ds=#h3#, #w6#", "", "20%"};
		{ 28, 34331, "", "=q4=Hand of the Deceiver", "=ds=#h3#, #w13#", "", "17%"};
		{ 29, 34336, "", "=q4=Sunflare", "=ds=#h3#, #w4#", "", "18%"};
		{ 30, 34337, "", "=q4=Golden Staff of the Sin'dorei", "=ds=#w9#", "", "14%"};
		Prev = "SPMuru";
	};

	AtlasLoot_Data["SPTrash"] = {
		{ 1, 34351, "", "=q4=Tranquil Majesty Wraps", "=ds=#s9#, #a2#", "", "1%"};
		{ 2, 34407, "", "=q4=Tranquil Moonlight Wraps", "=ds=#m29#"};
		{ 3, 34350, "", "=q4=Gauntlets of the Ancient Shadowmoon", "=ds=#s9#, #a3#", "", "2%"};
		{ 4, 34409, "", "=q4=Gauntlets of the Ancient Frostwolf", "=ds=#m29#"};
		{ 5, 35733, "", "=q4=Ring of Harmonic Beauty", "=ds=#s13#", "", "8%"};
		{ 6, 34183, "", "=q4=Shivering Felspine", "=ds=#h2#, #w7#", "", "1%"};
		{ 7, 34346, "", "=q4=Mounting Vengeance", "=ds=#h4#, #w13#", "", "2%"};
		{ 8, 34349, "", "=q4=Blade of Life's Inevitability", "=ds=#w11#", "", "2%"};
		{ 9, 34348, "", "=q4=Wand of Cleansing Light", "=ds=#w12#", "", "4%"};
		{ 10, 34347, "", "=q4=Wand of the Demonsoul", "=ds=#w12#", "", "2%"};
		{ 12, 35273, "", "=q3=Study of Advanced Smelting", "=ds=#p23# (375)", "", "3%"};
		{ 14, 34664, "", "=q3=Sunmote", "=ds=#m20#", "", "66%"};
		{ 16, 32228, "", "=q4=Empyrean Sapphire", "=ds=#e7#", "", "12%"};
		{ 17, 32231, "", "=q4=Pyrestone", "=ds=#e7#", "", "8%"};
		{ 18, 32229, "", "=q4=Lionseye", "=ds=#e7#", "", "6%"};
		{ 19, 32249, "", "=q4=Seaspray Emerald", "=ds=#e7#", "", "9%"};
		{ 20, 32230, "", "=q4=Shadowsong Amethyst", "=ds=#e7#", "", "6%"};
		{ 21, 32227, "", "=q4=Crimson Spinel", "=ds=#e7#", "", "8%"};
		{ 23, 35208, "", "=q4=Plans: Sunblessed Gauntlets", "=ds=#p2# (365)", "", "0.25%"};
		{ 24, 35210, "", "=q4=Plans: Sunblessed Breastplate", "=ds=#p2# (365)", "", "0.25%"};
		{ 25, 35209, "", "=q4=Plans: Hard Khorium Battlefists", "=ds=#p2# (365)", "", "6%"};
		{ 26, 35211, "", "=q4=Plans: Hard Khorium Battleplate", "=ds=#p2# (365)", "", "0.38%"};
	};

	AtlasLoot_Data["SPPatterns"] = {
		{ 1, 35212, "", "=q4=Pattern: Leather Gauntlets of the Sun", "=ds=#p7# (365)"};
		{ 2, 35216, "", "=q4=Pattern: Leather Chestguard of the Sun", "=ds=#p7# (365)"};
		{ 3, 35213, "", "=q4=Pattern: Fletcher's Gloves of the Phoenix", "=ds=#p7# (365)"};
		{ 4, 35217, "", "=q4=Pattern: Pattern: Embrace of the Phoenix", "=ds=#p7# (365)"};
		{ 5, 35214, "", "=q4=Pattern: Gloves of Immortal Dusk", "=ds=#p7# (365)"};
		{ 6, 35218, "", "=q4=Pattern: Carapace of Sun and Shadow", "=ds=#p7# (365)"};
		{ 7, 35215, "", "=q4=Pattern: Sun-Drenched Scale Gloves", "=ds=#p7# (365)"};
		{ 8, 35219, "", "=q4=Pattern: Sun-Drenched Scale Chestguard", "=ds=#p7# (365)"};
		{ 9, 35204, "", "=q4=Pattern: Sunfire Handwraps", "=ds=#p8# (365)"};
		{ 10, 35206, "", "=q4=Pattern: Sunfire Robe", "=ds=#p8# (365)"};
		{ 11, 35205, "", "=q4=Pattern: Hands of Eternal Light", "=ds=#p8# (365)"};
		{ 12, 35207, "", "=q4=Pattern: Robe of Eternal Light", "=ds=#p8# (365)"};
		{ 13, 35198, "", "=q4=Design: Loop of Forged Power", "=ds=#p12# (365)"};
		{ 14, 35201, "", "=q4=Design: Pendant of Sunfire", "=ds=#p12# (365)"};
		{ 15, 35199, "", "=q4=Design: Ring of Flowing Life", "=ds=#p12# (365)"};
		{ 16, 35202, "", "=q4=Design: Amulet of Flowing Life", "=ds=#p12# (365)"};
		{ 17, 35200, "", "=q4=Design: Hard Khorium Band", "=ds=#p12# (365)"};
		{ 18, 35203, "", "=q4=Design: Hard Khorium Choker", "=ds=#p12# (365)"};
		{ 19, 35186, "", "=q4=Schematic: Annihilator Holo-Gogs", "=ds=#p5# (375)"};
		{ 20, 35187, "", "=q4=Schematic: Justicebringer 3000 Specs", "=ds=#p5# (375)"};
		{ 21, 35189, "", "=q4=Schematic: Powerheal 9000 Lens", "=ds=#p5# (375)"};
		{ 22, 35190, "", "=q4=Schematic: Hyper-Magnified Moon Specs", "=ds=#p5# (375)"};
		{ 23, 35191, "", "=q4=Schematic: Wonderheal XT68 Shades", "=ds=#p5# (375)"};
		{ 24, 35192, "", "=q4=Schematic: Primal-Attuned Goggles", "=ds=#p5# (375)"};
		{ 25, 35193, "", "=q4=Schematic: Lightning Etched Specs", "=ds=#p5# (375)"};
		{ 26, 35194, "", "=q4=Schematic: Surestrike Goggles v3.0", "=ds=#p5# (375)"};
		{ 27, 35195, "", "=q4=Schematic: Mayhem Projection Goggles", "=ds=#p5# (375)"};
		{ 28, 35196, "", "=q4=Schematic: Hard Khorium Goggles", "=ds=#p5# (375)"};
		{ 29, 35197, "", "=q4=Schematic: Quad Deathblow X44 Goggles", "=ds=#p5# (375)"};
	};

		----------------------------------
		--- Tempest Keep: The Arcatraz ---
		----------------------------------

	AtlasLoot_Data["TKArcUnbound"] = {
		{ 1, 28373, "", "=q3=Cloak of Scintillating Auras", "=ds=#s4#", "", "17.13%"};
		{ 2, 28374, "", "=q3=Mana-Sphere Shoulderguards", "=ds=#s3#, #a1#", "", "20.35%"};
		{ 3, 28384, "", "=q3=Outland Striders", "=ds=#s12#, #a3#", "", "19.52%"};
		{ 4, 28375, "", "=q3=Rubium War-Girdle", "=ds=#s10#, #a4#", "", "14.38%"};
		{ 5, 28372, "", "=q3=Idol of Feral Shadows", "=ds=#s16#, #w14#", "", "15.80%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30582, "", "=q4=Deadly Fire Opal", "=ds=#e7#", "", "0.18%"};
		{ 19, 30575, "", "=q4=Nimble Fire Opal", "=ds=#e7#", "", "0.18%"};
		{ 20, 30581, "", "=q4=Durable Fire Opal", "=ds=#e7#", "", "0.18%"};
		Next = "TKArcScryer";
	};

	AtlasLoot_Data["TKArcScryer"] = {
		{ 1, 28396, "", "=q3=Gloves of the Unbound", "=ds=#s9#, #a2#", "", "17.80%"};
		{ 2, 28398, "", "=q3=The Sleeper's Cord", "=ds=#s10#, #a2#", "", "16.29%"};
		{ 3, 28394, "", "=q3=Ryngo's Band of Ingenuity", "=ds=#s13#", "", "16.81%"};
		{ 4, 28393, "", "=q3=Warmaul of Infused Light", "=ds=#h2#, #w6#", "", "16.14%"};
		{ 5, 28397, "", "=q3=Emberhawk Crossbow", "=ds=#w3#", "", "17.65%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30582, "", "=q4=Deadly Fire Opal", "=ds=#e7#", "", "0.18%"};
		{ 19, 30575, "", "=q4=Nimble Fire Opal", "=ds=#e7#", "", "0.18%"};
		{ 20, 30581, "", "=q4=Durable Fire Opal", "=ds=#e7#", "", "0.18%"};
		Prev = "TKArcUnbound";
		Next = "TKArcDalliah";
	};

	AtlasLoot_Data["TKArcDalliah"] = {
		{ 1, 24308, "", "=q4=Pattern: Whitemend Pants", "=ds=#p8# (375)", "", "0.29%"};
		{ 3, 28391, "", "=q3=Worldfire Chestguard", "=ds=#s5#, #a3#", "", "18.57%"};
		{ 4, 28390, "", "=q3=Thatia's Self-Correcting Gauntlets", "=ds=#s9#, #a4#", "", "14.80%"};
		{ 5, 28387, "", "=q3=Lamp of Peaceful Repose", "=ds=#s15#", "", "15.92%"};
		{ 6, 28392, "", "=q3=Reflex Blades", "=ds=#h3#, #w13#", "", "18.37%"};
		{ 7, 28386, "", "=q3=Nether Core's Control Rod", "#w12#", "", "15.29%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30582, "", "=q4=Deadly Fire Opal", "=ds=#e7#", "", "0.18%"};
		{ 19, 30575, "", "=q4=Nimble Fire Opal", "=ds=#e7#", "", "0.18%"};
		{ 20, 30581, "", "=q4=Durable Fire Opal", "=ds=#e7#", "", "0.18%"};
		Prev = "TKArcScryer";
		Next = "TKArcHarbinger";
	};

	AtlasLoot_Data["TKArcHarbinger"] = {
		{ 1, 28415, "", "=q3=Hood of Oblivion", "=ds=#s1#, #a1# (D3)", "", "12.23%"};
		{ 2, 28413, "", "=q3=Hallowed Crown", "=ds=#s1#, #a1# (D3)", "", "12.17%"};
		{ 3, 28414, "", "=q3=Helm of Assassination", "=ds=#s1#, #a2# (D3)", "", "11.25%"};
		{ 4, 28231, "", "=q3=Tidefury Chestpiece", "=ds=#s5#, #a3# (D3)", "", "14.98%"};
		{ 5, 28403, "", "=q3=Doomplate Chestguard", "=ds=#s5#, #a4# (D3)", "", "13.15%"};
		{ 6, 28205, "", "=q3=Breastplate of the Bold", "=ds=#s5#, #a4# (D3)", "", "11.19%"};
		{ 8, 28406, "", "=q3=Sigil-Laced Boots", "=ds=#s12#, #a1#", "", "12.23%"};
		{ 9, 28419, "", "=q3=Choker of Fluid Thought", "=ds=#s2#", "", "14.92%"};
		{ 10, 28407, "", "=q3=Elementium Band of the Sentry", "=ds=#s13#", "", "10.70%"};
		{ 11, 28418, "", "=q3=Shiffar's Nexus-Horn", "=ds=#s14#", "", "12.23%"};
		{ 12, 28412, "", "=q3=Lamp of Peaceful Radiance", "=ds=#s15#", "", "13.15%"};
		{ 13, 28416, "", "=q3=Hungering Spineripper", "=ds=#h1#, #w4#", "", "12.35%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30582, "", "=q4=Deadly Fire Opal", "=ds=#e7#", "", "0.18%"};
		{ 19, 30575, "", "=q4=Nimble Fire Opal", "=ds=#e7#", "", "0.18%"};
		{ 20, 30581, "", "=q4=Durable Fire Opal", "=ds=#e7#", "", "0.18%"};
		{ 22, 29241, "", "=q4=Belt of Depravity", "=ds=#s10#, #a1#", "", "8.47%"};
		{ 23, 29248, "", "=q4=Shadowstep Striders", "=ds=#s12#, #a2#", "", "0.61%"};
		{ 24, 29252, "", "=q4=Bracers of Dignity", "=ds=#s8#, #a4#", "", "3.03%"};
		{ 25, 29360, "", "=q4=Vileblade of the Betrayer", "=ds=#h1#, #w4#", "", "0.18%"};
		{ 27, 33861, "", "=q1=The Scroll of Skyriss", "=ds=#m3#", "", "100%"};
		Prev = "TKArcDalliah";
	};

	AtlasLoot_Data["TKTrash"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Trash Mobs"], "=q5="..BabbleZone["The Botanica"]};
		{ 2, 24172, "", "=q4=Design: Coronet of Verdant Flame", "=ds=#p12# (370) =q1=#n92#", "", "0.27%"};
		{ 4, 0, "INV_Box_01", "=q6="..AL["Trash Mobs"], "=q5="..BabbleZone["The Mechanar"]};
		{ 5, 22920, "", "=q2=Recipe: Major Fire Protection Potion", "=ds=#p1# (360) =q1=#n93#", "", "0.30%"};
		{ 6, 21906, "", "=q2=Pattern: Arcanoweave Boots", "=ds=#p8# (360) =q1=#n93#", "", "0.57%"};
		{ 8, 0, "INV_Box_01", "=q6="..AL["Overcharged Manacell"], "=q5="..BabbleZone["The Mechanar"]};
		{ 9, 30824, "", "=q1=Overcharged Manacell", "=ds=#m3#"};
		{ 16, 0, "INV_Box_01", "=q6="..AL["Trash Mobs"], "=q5="..BabbleZone["The Arcatraz"]};
		{ 17, 23606, "", "=q3=Plans: Felsteel Leggings", "=ds=#p2# (360), =q1=#n57#", "", "3.93%"};
		{ 18, 22556, "", "=q2=Formula: Enchant 2H Weapon - Major Agility", "=ds=#p4# (360) =q1=#n89#", "", "1.68%"};
		{ 19, 29672, "", "=q2=Pattern: Flame Armor Kit", "=ds=#p7# (340) =q1=#n91#", "", "1.84%"};
		{ 20, 21905, "", "=q2=Pattern: Arcanoweave Bracers", "=ds=#p8# (350) =q1=#n90#", "", "1.21%"};
		{ 22, 0, "INV_Box_01", "=q6="..AL["Third Fragment Guardian"], "=q5="..BabbleZone["The Arcatraz"]};
		{ 23, 24488, "", "=q1=Third Key Fragment", "=ds=#m3#", "", "100%"};
	};

		----------------------------------
		--- Tempest Keep: The Botanica ---
		----------------------------------

	AtlasLoot_Data["TKBotSarannis"] = {
		{ 1, 28301, "", "=q3=Syrannis' Mystic Sheen", "=ds=#s4#", "", "28.54%"};
		{ 2, 28304, "", "=q3=Prismatic Mittens of Mending", "=ds=#s9#, #a1#", "", "32.46%"};
		{ 3, 28306, "", "=q3=Towering Mantle of the Hunt", "=ds=#s3#, #a3#", "", "30.68%"};
		{ 4, 28296, "", "=q3=Libram of the Lightbringer", "=ds=#s16#, #w16#", "", "34.10%"};
		{ 5, 28311, "", "=q3=Revenger", "=ds=#h1#, #w10#", "", "26.25%"};
		{ 7, 28769, "", "=q1=The Keystone", "=ds=#m3#", "", "100%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30574, "", "=q4=Brutal Tanzanite", "=ds=#e7#", "", "8.00%"};
		{ 19, 30572, "", "=q4=Imperial Tanzanite", "=ds=#e7#", "", "8.00%"};
		{ 20, 30573, "", "=q4=Mysterious Fire Opal", "=ds=#e7#", "", "8.00%"};
		Next = "TKBotFreywinn";
	};

	AtlasLoot_Data["TKBotFreywinn"] = {
		{ 1, 28317, "", "=q3=Energis Armwraps", "=ds=#s9#, #a1#", "", "17.60%"};
		{ 2, 28318, "", "=q3=Obsidian Clodstompers", "=ds=#s12#, #a4#", "", "16.48%"};
		{ 3, 28321, "", "=q3=Enchanted Thorium Torque", "=ds=#s2#", "", "18.09%"};
		{ 4, 28315, "", "=q3=Stormreaver Warblades", "=ds=#h4#, #w13#", "", "16.75%"};
		{ 5, 28316, "", "=q3=Aegis of the Sunbird", "=ds=#w8#", "", "14.60%"};
		{ 7, 23617, "", "=q3=Plans: Earthpeace Breastplate", "=ds=#p2# (370)", "", "1.07%"};
		{ 9, 31744, "", "=q1=Botanist's Field Guide", "=ds=#m3#", "", "100%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30574, "", "=q4=Brutal Tanzanite", "=ds=#e7#", "", "8.00%"};
		{ 19, 30572, "", "=q4=Imperial Tanzanite", "=ds=#e7#", "", "8.00%"};
		{ 20, 30573, "", "=q4=Mysterious Fire Opal", "=ds=#e7#", "", "8.00%"};
		Prev = "TKBotSarannis";
		Next = "TKBotThorngrin";
	};

	AtlasLoot_Data["TKBotThorngrin"] = {
		{ 1, 24310, "", "=q4=Pattern: Battlecast Pants", "=ds=#p8# (375)", "", "0.44%"};
		{ 3, 28324, "", "=q3=Gauntlets of Cruel Intention", "=ds=#s9#, #a4#", "", "15.56%"};
		{ 4, 28327, "", "=q3=Arcane Netherband", "=ds=#s13#", "", "17.77%"};
		{ 5, 28323, "", "=q3=Ring of Umbral Doom", "=ds=#s13#", "", "16.25%"};
		{ 6, 28322, "", "=q3=Runed Dagger of Solace", "=ds=#h3#, #w4#", "", "18.16%"};
		{ 7, 28325, "", "=q3=Dreamer's Dragonstaff", "=ds=#w9#", "", "15.46%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30574, "", "=q4=Brutal Tanzanite", "=ds=#e7#", "", "8.00%"};
		{ 19, 30572, "", "=q4=Imperial Tanzanite", "=ds=#e7#", "", "8.00%"};
		{ 20, 30573, "", "=q4=Mysterious Fire Opal", "=ds=#e7#", "", "8.00%"};
		Prev = "TKBotFreywinn";
		Next = "TKBotLaj";
	};

	AtlasLoot_Data["TKBotLaj"] = {
		{ 1, 27739, "", "=q3=Spaulders of the Righteous", "=ds=#s3#, #a4# (D3)", "", "18.13%"};
		{ 3, 28328, "", "=q3=Mithril-Bark Cloak", "=ds=#s4#", "", "20.88%"};
		{ 4, 28338, "", "=q3=Devil-Stitched Leggings", "=ds=#s11#, #a1#", "", "18.71%"};
		{ 5, 28340, "", "=q3=Mantle of Autumn", "=ds=#s3#, #a2#", "", "17.19%"};
		{ 6, 28339, "", "=q3=Boots of the Shifting Sands", "=ds=#s12#, #a2#", "", "19.07%"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30574, "", "=q4=Brutal Tanzanite", "=ds=#e7#", "", "8.00%"};
		{ 19, 30572, "", "=q4=Imperial Tanzanite", "=ds=#e7#", "", "8.00%"};
		{ 20, 30573, "", "=q4=Mysterious Fire Opal", "=ds=#e7#", "", "8.00%"};
		Prev = "TKBotThorngrin";
		Next = "TKBotSplinter";
	};

	AtlasLoot_Data["TKBotSplinter"] = {
		{ 1, 24311, "", "=q4=Pattern: Whitemend Hood", "=ds=#p8# (375)", "", "0.30%"};
		{ 3, 28371, "", "=q3=Netherfury Cape", "=ds=#s4#", "", "13.52%"};
		{ 4, 28342, "", "=q3=Warp Infused Drape", "=ds=#s5#, #a1#", "", "10.27%"};
		{ 5, 28347, "", "=q3=Warpscale Leggings", "=ds=#s11#, #a2#", "", "11.74%"};
		{ 6, 28343, "", "=q3=Jagged Bark Pendant", "=ds=#s2#", "", "12.34%"};
		{ 7, 28370, "", "=q3=Bangle of Endless Blessings", "=ds=#s14#", "", "12.38%"};
		{ 8, 28345, "", "=q3=Warp Splinter's Thorn", "=ds=#h1#, #w4#", "", "10.37%"};
		{ 9, 28367, "", "=q3=Greatsword of Forlorn Visions", "=ds=#h2#, #w10#", "", "11.64%"};
		{ 10, 28341, "", "=q3=Warpstaff of Arcanum", "=ds=#w9#", "", "10.47%"};
		{ 12, 31085, "", "=q1=Top Shard of the Arcatraz Key", "=ds=#m3#", "", "100%"};
		{ 16, 28229, "", "=q3=Incanter's Robe", "=ds=#s5#, #a1# (D3)", "", "8.42%"};
		{ 17, 28348, "", "=q3=Moonglade Cowl", "=ds=#s1#, #a2# (D3)", "", "11.17%"};
		{ 18, 28349, "", "=q3=Tidefury Helm", "=ds=#s1#, #a3# (D3)", "", "13.85%"};
		{ 19, 28228, "", "=q3=Beast Lord Curiass", "=ds=#s5#, #a3# (D3)", "", "9.59%"};
		{ 20, 28350, "", "=q3=Warhelm of the Bold", "=ds=#s1#, #a4# (D3)", "", "8.96%"};
		Prev = "TKBotLaj";
	};

	AtlasLoot_Data["TKBotSplinterHEROIC"] = {
		{ 1, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 2, 29258, "", "=q4=Boots of Ethereal Manipulation", "=ds=#s11#, #a1#"};
		{ 3, 29262, "", "=q4=Boots of the Endless Hunt", "=ds=#s12#, #a3#", "", "4.00%"};
		{ 4, 32072, "", "=q4=Gauntlets of Dissension", "=ds=#s9#, #a4#"};
		{ 5, 29359, "", "=q4=Feral Staff of Lashing", "=ds=#w9#"};
		{ 6, 24311, "", "=q4=Pattern: Whitemend Hood", "=ds=#p8# (375)", "", "0.30%"};
		{ 8, 28371, "", "=q3=Netherfury Cape", "=ds=#s4#", "", "4.00%"};
		{ 9, 28342, "", "=q3=Warp Infused Drape", "=ds=#s5#, #a1#", "", "8.00%"};
		{ 10, 28347, "", "=q3=Warpscale Leggings", "=ds=#s11#, #a2#", "", "12.00%"};
		{ 11, 28343, "", "=q3=Jagged Bark Pendant", "=ds=#s2#", "", "4.00%"};
		{ 12, 28370, "", "=q3=Bangle of Endless Blessings", "=ds=#s14#", "", "28.00%"};
		{ 13, 28345, "", "=q3=Warp Splinter's Thorn", "=ds=#h1#, #w4#", "", "28.00%"};
		{ 14, 28367, "", "=q3=Greatsword of Forlorn Visions", "=ds=#h2#, #w10#", "", "8.00%"};
		{ 15, 28341, "", "=q3=Warpstaff of Arcanum", "=ds=#w9#", "", "4.00%"};
		{ 16, 30574, "", "=q4=Brutal Tanzanite", "=ds=#e7#", "", "8.00%"};
		{ 17, 30572, "", "=q4=Imperial Tanzanite", "=ds=#e7#", "", "8.00%"};
		{ 18, 30573, "", "=q4=Mysterious Fire Opal", "=ds=#e7#", "", "8.00%"};
		{ 20, 28229, "", "=q3=Incanter's Robe", "=ds=#s5#, #a1# (D3)", "", "4.00%"};
		{ 21, 28348, "", "=q3=Moonglade Cowl", "=ds=#s1#, #a2# (D3)", "", "12.00%"};
		{ 22, 28349, "", "=q3=Tidefury Helm", "=ds=#s1#, #a3# (D3)", "", "12.00%"};
		{ 23, 28228, "", "=q3=Beast Lord Curiass", "=ds=#s5#, #a3# (D3)", "", "20.00%"};
		{ 24, 28350, "", "=q3=Warhelm of the Bold", "=ds=#s1#, #a4# (D3)", "", "16.00%"};
		{ 26, 31085, "", "=q1=Top Shard of the Arcatraz Key", "=ds=#m3#", "", "100%"};
		{ 27, 33859, "", "=q1=Warp Splinter Clipping", "=ds=#m3#", "", "100%"};
		Prev = "TKBotLaj";
	};

		----------------------------------
		--- Tempest Keep: The Mechanar ---
		----------------------------------

	AtlasLoot_Data["TKMechCacheoftheLegion"] = {
		{ 1, 0, "INV_Box_01", "=q6="..AL["Cache of the Legion"], ""};
		{ 2, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 3, 28249, "", "=q3=Capacitus' Cloak of Calibration", "=ds=#s4#", "", "21.16%"};
		{ 4, 28250, "", "=q3=Vestia's Pauldrons of Inner Grace", "=ds=#s3#, #a1#", "", "17.89%"};
		{ 5, 28252, "", "=q3=Bloodfyre Robes of Annihilation", "=ds=#s5#, #a1#", "", "22.53%"};
		{ 6, 28251, "", "=q3=Boots of the Glade-Keeper", "=ds=#s12#, #a2#", "", "18.74%"};
		{ 7, 28248, "", "=q3=Totem of the Void", "=ds=#s16#, #w15#", "", "19.58%"};
		{ 16, 0, "INV_Box_01", "=q6="..BabbleBoss["Gatewatcher Gyro-Kill"], ""};
		{ 17, 30436, "", "=q1=Jagged Blue Crystal", "=ds=#e9#", "", "100%"};
		{ 19, 0, "INV_Box_01", "=q6="..BabbleBoss["Gatewatcher Iron-Hand"], ""};
		{ 20, 30437, "", "=q1=Jagged Red Crystal", "=ds=#e9#", "", "100%"};
		Next = "TKMechCapacitus";
	};

	AtlasLoot_Data["TKMechCapacitus"] = {
		{ 1, 28256, "", "=q3=Thoriumweave Cloak", "=ds=#s4#", "", "14.81%"};
		{ 2, 28255, "", "=q3=Lunar-Claw Pauldrons", "=ds=#s3#, #a2#", "", "16.98%"};
		{ 3, 28254, "", "=q3=Warp Engineer's Prismatic Chain", "=ds=#s2#", "", "16.81%"};
		{ 4, 28257, "", "=q3=Hammer of the Penitent", "=ds=#h3#, #w6#", "", "14.36%"};
		{ 5, 28253, "", "=q3=Plasma Rat's Hyper-Scythe", "=ds=#w7#", "", "17.69%"};
		{ 7, 35582, "", "=q3=Schematic: Rocket Boots Xtreme Lite", "=ds=#p5# (355)"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30565, "", "=q4=Assassin's Fire Opal", "=ds=#e7#", "", "18.72%"};
		{ 19, 30566, "", "=q4=Defender's Tanzanite", "=ds=#e7#", "", "8.87%"};
		{ 20, 30564, "", "=q4=Shining Fire Opal", "=ds=#e7#", "", "3.45%"};
		Prev = "TKMechCacheoftheLegion";
		Next = "TKMechSepethrea";
	};

	AtlasLoot_Data["TKMechSepethrea"] = {
		{ 1, 28262, "", "=q3=Jade-Skull Breastplate", "=ds=#s5#, #a4#", "", "15.37%"};
		{ 2, 28259, "", "=q3=Cosmic Lifeband", "=ds=#s13#", "", "18.06%"};
		{ 3, 28260, "", "=q3=Manual of the Nethermancer", "=ds=#s15#", "", "15.61%"};
		{ 4, 28263, "", "=q3=Stellaris", "=ds=#h1#, #w1#", "", "15.58%"};
		{ 5, 28258, "", "=q3=Nethershrike", "=ds=#w11#", "", "15.88%"};
		{ 7, 22920, "", "=q2=Recipe: Major Fire Protection Potion", "=ds=#p1# (360) =q1=#n93#"};
		{ 16, 0, "INV_Box_01", "=q6=#j27#", ""};
		{ 17, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 18, 30565, "", "=q4=Assassin's Fire Opal", "=ds=#e7#", "", "18.72%"};
		{ 19, 30566, "", "=q4=Defender's Tanzanite", "=ds=#e7#", "", "8.87%"};
		{ 20, 30564, "", "=q4=Shining Fire Opal", "=ds=#e7#", "", "3.45%"};
		Prev = "TKMechCapacitus";
		Next = "TKMechCalc";
	};

	AtlasLoot_Data["TKMechCalc"] = {
		{ 1, 28269, "", "=q3=Baba's Cloak of Arcanistry", "=ds=#s4#", "", "11.78%"};
		{ 2, 28266, "", "=q3=Molten Earth Kilt", "=ds=#s11#, #a3#", "", "12.26%"};
		{ 3, 28265, "", "=q3=Dath'Remar's Ring of Defense", "=ds=#s13#", "", "10.61%"};
		{ 4, 28288, "", "=q3=Abacus of Violent Odds", "=ds=#s14#", "", "10.54%"};
		{ 5, 27899, "", "=q3=Mana Wrath", "=ds=#h3#, #w10#", "", "11.38%"};
		{ 6, 28267, "", "=q3=Edge of the Cosmos", "=ds=#h1#, #w10#", "", "11.13%"};
		{ 7, 28286, "", "=q3=Telescopic Sharprifle", "=ds=#w5#", "", "12.28%"};
		{ 9, 21907, "", "=q2=Pattern: Arcanoweave Robe", "=ds=#p8# (370)", "", "1.11%"};
		{ 11, 31086, "", "=q1=Bottom Shard of the Arcatraz Key", "=ds=#m3#", "", "100%"};
		{ 16, 28278, "", "=q3=Incanter's Cowl", "=ds=#s1#, #a1# (D3)", "", "13.39%"};
		{ 17, 28202, "", "=q3=Moonglade Robe", "=ds=#s5#, #a2# (D3)", "", "11.92%"};
		{ 18, 28204, "", "=q3=Tunic of Assassination", "=ds=#s5#, #a2# (D3)", "", "12.44%"};
		{ 19, 28275, "", "=q3=Beast Lord Helm", "=ds=#s1#, #a3# (D3)", "", "12.37%"};
		{ 20, 28285, "", "=q3=Helm of the Righteous", "=ds=#s1#, #a4# (D3)", "", "10.88%"};
		Prev = "TKMechSepethrea";
	};

	AtlasLoot_Data["TKMechCalcHEROIC"] = {
		{ 1, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 2, 29251, "", "=q4=Boots of the Pious", "=ds=#s12#, #a1#", "", "7.88%"};
		{ 3, 32076, "", "=q4=Handguards of the Steady", "=ds=#s9#, #a3#"};
		{ 4, 30533, "", "=q4=Vanquisher's Legplates", "=ds=#s11#, #a4#", "", "6.90%"};
		{ 5, 29362, "", "=q4=The Sun Eater", "=ds=#h1#, #w10#", "", "1.48%"};
		{ 7, 28269, "", "=q3=Baba's Cloak of Arcanistry", "=ds=#s4#", "", "11.82%"};
		{ 8, 28266, "", "=q3=Molten Earth Kilt", "=ds=#s11#, #a3#", "", "14.29%"};
		{ 9, 28265, "", "=q3=Dath'Remar's Ring of Defense", "=ds=#s13#", "", "8.87%"};
		{ 10, 28288, "", "=q3=Abacus of Violent Odds", "=ds=#s14#", "", "8.37%"};
		{ 11, 27899, "", "=q3=Mana Wrath", "=ds=#h3#, #w10#", "", "9.36%"};
		{ 12, 28267, "", "=q3=Edge of the Cosmos", "=ds=#h1#, #w10#", "", "11.82%"};
		{ 13, 28286, "", "=q3=Telescopic Sharprifle", "=ds=#w5#", "", "9.85%"};
		{ 15, 21907, "", "=q2=Pattern: Arcanoweave Robe", "=ds=#p8# (370)", "", "1.11%"};
		{ 16, 30565, "", "=q4=Assassin's Fire Opal", "=ds=#e7#", "", "18.72%"};
		{ 17, 30566, "", "=q4=Defender's Tanzanite", "=ds=#e7#", "", "8.87%"};
		{ 18, 30564, "", "=q4=Shining Fire Opal", "=ds=#e7#", "", "3.45%"};
		{ 20, 28278, "", "=q3=Incanter's Cowl", "=ds=#s1#, #a1# (D3)", "", "14.29%"};
		{ 21, 28202, "", "=q3=Moonglade Robe", "=ds=#s5#, #a2# (D3)", "", "11.33%"};
		{ 22, 28204, "", "=q3=Tunic of Assassination", "=ds=#s5#, #a2# (D3)", "", "8.87%"};
		{ 23, 28275, "", "=q3=Beast Lord Helm", "=ds=#s1#, #a3# (D3)", "", "14.78%"};
		{ 24, 28285, "", "=q3=Helm of the Righteous", "=ds=#s1#, #a4# (D3)", "", "10.34%"};
		{ 26, 33860, "", "=q1=Pathaleon's Projector", "=ds=#m3#", "", "100%"};
		{ 27, 31086, "", "=q1=Bottom Shard of the Arcatraz Key", "=ds=#m3#", "", "100%"};
		Prev = "TKMechSepethrea";
	};

		-----------------------------
		--- Tempest Keep: The Eye ---
		-----------------------------

	AtlasLoot_Data["TKEyeAlar"] = {
		{ 1, 29925, "", "=q4=Phoenix-Wing Cloak", "=ds=#s4#", "", "23%"};
		{ 2, 29918, "", "=q4=Mindstorm Wristbands", "=ds=#s8#, #a1#", "", "22%"};
		{ 3, 29947, "", "=q4=Gloves of the Searing Grip", "=ds=#s9#, #a2#", "", "23%"};
		{ 4, 29921, "", "=q4=Fire Crest Breastplate", "=ds=#s5#, #a3#", "", "20%"};
		{ 5, 29922, "", "=q4=Band of Al'Ar", "=ds=#s13#", "", "21%"};
		{ 6, 29920, "", "=q4=Phoenix-Ring of Rebirth", "=ds=#s13#", "", "21%"};
		{ 7, 30448, "", "=q4=Talon of Al'ar", "=ds=#s14#, =q1=#m1# =ds=#c2#", "", "22%"};
		{ 8, 30447, "", "=q4=Tome of Fiery Redemption", "=ds=#s14#, =q1=#m1# =ds=#c4#", "", "21%"};
		{ 9, 29923, "", "=q4=Talisman of the Sun King", "=ds=#s15#", "", "23%"};
		{ 16, 32944, "", "=q4=Talon of the Phoenix", "=ds=#h3#, #w13#", "", "12%"};
		{ 17, 29948, "", "=q4=Claw of the Phoenix", "=ds=#h4#, #w13#", "", "10%"};
		{ 18, 29924, "", "=q4=Netherbane", "=ds=#h1#, #w1#", "", "21%"};
		{ 19, 29949, "", "=q4=Arcanite Steam-Pistol", "=ds=#w5#", "", "22%"};
		{ 21, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Next = "TKEyeVoidReaver";
	};

	AtlasLoot_Data["TKEyeVoidReaver"] = {
		{ 1, 29986, "", "=q4=Cowl of the Grand Engineer", "=ds=#s1#, #a1#", "", "13%"};
		{ 2, 29984, "", "=q4=Girdle of Zaetar", "=ds=#s10#, #a2#", "", "13%"};
		{ 3, 29985, "", "=q4=Void Reaver Greaves", "=ds=#s11#, #a3#", "", "14%"};
		{ 4, 29983, "", "=q4=Fel-Steel Warhelm", "=ds=#s1#, #a4#", "", "12%"};
		{ 5, 32515, "", "=q4=Wristgaurds of Determination", "=ds=#s8#, #a4#", "", "13%"};
		{ 6, 30619, "", "=q4=Fel Reaver's Piston", "=ds=#s14#", "", "13%"};
		{ 7, 30450, "", "=q4=Warp-Spring Coil", "=ds=#s14#, =q1=#m1# =ds=#c6#", "", "12%"};
		{ 16, 30248, "", "=q4=Pauldrons of the Vanquished Champion", "=ds=#m22# #e15#", "", "61%"};
		{ 17, 30249, "", "=q4=Pauldrons of the Vanquished Defender", "=ds=#m22# #e15#", "", "62%"};
		{ 18, 30250, "", "=q4=Pauldrons of the Vanquished Hero", "=ds=#m22# #e15#", "", "61%"};
		{ 20, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "TKEyeAlar";
		Next = "TKEyeSolarian";
	};

	AtlasLoot_Data["TKEyeSolarian"] = {
		{ 1, 29977, "", "=q4=Star-Soul Breeches", "=ds=#s11#, #a1#", "", "19%"};
		{ 2, 29972, "", "=q4=Trousers of the Astromancer", "=ds=#s11#, #a1#", "", "19%"};
		{ 3, 29966, "", "=q4=Vambraces of Ending", "=ds=#s8#, #a2#", "", "23%"};
		{ 4, 29976, "", "=q4=Worldstorm Gauntlets", "=ds=#s9#, #a3#", "", "18%"};
		{ 5, 29951, "", "=q4=Star-Strider Boots", "=ds=#s12#, #a3#", "", "23%"};
		{ 6, 29965, "", "=q4=Girdle of the Righteous Path", "=ds=#s10#, #a4#", "", "21%"};
		{ 7, 29950, "", "=q4=Greaves of the Bloodwarder", "=ds=#s11#, #a4#", "", "19%"};
		{ 8, 32267, "", "=q4=Boots of the Resilient", "=ds=#s12#, #a4#", "", "17%"};
		{ 16, 30446, "", "=q4=Solarian's Sapphire", "=ds=#s14#, =q1=#m1# =ds=#c9#", "", "21%"};
		{ 17, 30449, "", "=q4=Void Star Talisman", "=ds=#s14#, =q1=#m1# =ds=#c8#", "", "22%"};
		{ 18, 29962, "", "=q4=Heartrazor", "=ds=#h1#, #w4#", "", "23%"};
		{ 19, 29981, "", "=q4=Etherium Life-Staff", "=ds=#w9#", "", "21%"};
		{ 20, 29982, "", "=q4=Wand of the Forgotten Star", "=ds=#w12#", "", "18%"};
		{ 22, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		Prev = "TKEyeVoidReaver";
		Next = "TKEyeKaelthas";
	};

	AtlasLoot_Data["TKEyeKaelthas"] = {
		{ 1, 29992, "", "=q4=Royal Cloak of the Sunstriders", "=ds=#s4#", "", "14%"};
		{ 2, 29989, "", "=q4=Sunshower Light Cloak", "=ds=#s4#", "", "12%"};
		{ 3, 29994, "", "=q4=Thalassian Wildercloak", "=ds=#s4#", "", "14%"};
		{ 4, 29990, "", "=q4=Crown of the Sun", "=ds=#s1#, #a1#", "", "14%"};
		{ 5, 29987, "", "=q4=Gauntlets of the Sun-King", "=ds=#s9#, #a1#", "", "14%"};
		{ 6, 29995, "", "=q4=Leggings of Murderous Intent", "=ds=#s11#, #a2#", "", "15%"};
		{ 7, 29991, "", "=q4=Sunhawk Leggings", "=ds=#s11#, #a3#", "", "13%"};
		{ 8, 29998, "", "=q4=Royal Gauntlets of Silvermoon", "=ds=#s9#, #a4#", "", "12%"};
		{ 9, 29997, "", "=q4=Band of the Ranger-General", "=ds=#s13#", "", "14%"};
		{ 10, 29993, "", "=q4=Twinblade of the Phoenix", "=ds=#h2#, #w10#", "", "12%"};
		{ 11, 29996, "", "=q4=Rod of the Sun King", "=ds=#h1#, #w6#", "", "15%"};
		{ 12, 29988, "", "=q4=The Nexus Key", "=ds=#w9#", "", "14%"};
		{ 14, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 16, 30236, "", "=q4=Chestguard of the Vanquished Champion", "=ds=#m22# #e15#", "", "69%"};
		{ 17, 30237, "", "=q4=Chestguard of the Vanquished Defender", "=ds=#m22# #e15#", "", "68%"};
		{ 18, 30238, "", "=q4=Chestguard of the Vanquished Hero", "=ds=#m22# #e15#", "", "66%"};
		{ 20, 32458, "", "=q4=Ashes of Al'ar", "=ds=#e12#", "", "2%"};
		{ 22, 32405, "", "=q4=Verdant Sphere", "=ds=#m2#", "", "100%"};
		{ 23, 30018, "", "=q4=Lord Sanguinar's Claim", "=q1=#m4#: =ds=#s2#"};
		{ 24, 30017, "", "=q4=Telonicus's Pendant of Mayhem", "=q1=#m4#: =ds=#s2#"};
		{ 25, 30007, "", "=q4=The Darkener's Grasp", "=q1=#m4#: =ds=#s2#"};
		{ 26, 30015, "", "=q4=The Sun King's Talisman", "=q1=#m4#: =ds=#s2#"};
		{ 28, 29905, "", "=q1=Kael's Vial Remnant", "=ds=#m3#", "", "37%"};
		Prev = "TKEyeSolarian";
	};

	AtlasLoot_Data["TKEyeTrash"] = {
		{ 1, 30024, "", "=q4=Mantle of the Elven Kings", "=ds=#s3#, #a1#", "", "3%"};
		{ 2, 30020, "", "=q4=Fire-Cord of the Magus", "=ds=#s10#, #a1#", "", "2%"};
		{ 3, 30029, "", "=q4=Bark-Gloves of Ancient Wisdom", "=ds=#s9#, #a2#", "", "2%"};
		{ 4, 30026, "", "=q4=Bands of the Celestial Archer", "=ds=#s8#, #a3#", "", "2%"};
		{ 5, 30030, "", "=q4=Girdle of Fallen Stars", "=ds=#s10#, #a3#", "", "2%"};
		{ 6, 30028, "", "=q4=Seventh Ring of the Tirisfalen", "=ds=#s13#", "", "2%"};
		{ 8, 30324, "", "=q4=Plans: Red Havoc Boots", "=ds=#p2# (375)", "", "1%"};
		{ 9, 30322, "", "=q4=Plans: Red Belt of Battle", "=ds=#p2# (375)", "", "2%"};
		{ 10, 30323, "", "=q4=Plans: Boots of the Protector", "=ds=#p2# (375)", "", "2%"};
		{ 11, 30321, "", "=q4=Plans: Belt of the Guardian", "=ds=#p2# (375)", "", "2%"};
		{ 12, 30280, "", "=q4=Pattern: Belt of Blasting", "=ds=#p8# (375)", "", "1%"};
		{ 13, 30282, "", "=q4=Pattern: Boots of Blasting", "=ds=#p8# (375)", "", "1%"};
		{ 14, 30283, "", "=q4=Pattern: Boots of the Long Road", "=ds=#p8# (375)", "", "2%"};
		{ 15, 30281, "", "=q4=Pattern: Belt of the Long Road", "=ds=#p8# (375)", "", "1%"};
		{ 16, 30308, "", "=q4=Pattern: Hurricane Boots", "=ds=#p7# (375)", "", "1%"};
		{ 17, 30304, "", "=q4=Pattern: Monsoon Belt", "=ds=#p7# (375)", "", "1%"};
		{ 18, 30305, "", "=q4=Pattern: Boots of Natural Grace", "=ds=#p7# (375)", "", "2%"};
		{ 19, 30307, "", "=q4=Pattern: Boots of the Crimson Hawk", "=ds=#p7# (375)", "", "1%"};
		{ 20, 30306, "", "=q4=Pattern: Boots of Utter Darkness", "=ds=#p7# (375)", "", "2%"};
		{ 21, 30301, "", "=q4=Pattern: Belt of Natural Power", "=ds=#p7# (375)", "", "1%"};
		{ 22, 30303, "", "=q4=Pattern: Belt of the Black Eagle", "=ds=#p7# (375)", "", "1%"};
		{ 23, 30302, "", "=q4=Pattern: Belt of Deep Shadow", "=ds=#p7# (375)", "", "1%"};
		{ 25, 30183, "", "=q4=Nether Vortex", "=ds=#e8#", "", "75%"};
		{ 27, 32897, "", "=q2=Mark of the Illidari", "=ds=#m20#", "", "27%"};
	};

	AtlasLoot_Data["TKEyeLegendaries"] = {
		{ 1, 30312, "", "=q5=Infinity Blade", "=ds=#h1#, #w4#"};
		{ 2, 30311, "", "=q5=Warp Slicer", "=ds=#h1#, #w10#"};
		{ 3, 30317, "", "=q5=Cosmic Infuser", "=ds=#h3#, #w6#"};
		{ 4, 30316, "", "=q5=Devastation", "=ds=#h2#, #w1#"};
		{ 5, 30313, "", "=q5=Staff of Disintegration", "=ds=#w9#"};
		{ 6, 30314, "", "=q5=Phaseshift Bulwark", "=ds=#w8#"};
		{ 7, 30318, "", "=q5=Netherstrand Longbow", "=ds=#w2#, =q1=#m1# =ds=#c2#"};
		{ 8, 30319, "", "=q5=Nether Spike", "=ds=#w17#"};
	};

		----------------
		--- Zul'Aman ---
		----------------

	AtlasLoot_Data["ZANalorakk"] = {
		{ 1, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 2, 33203, "", "=q4=Robes of Heavenly Purpose", "=ds=#s5#, #a1#", "", "13%"};
		{ 3, 33285, "", "=q4=Fury of the Ursine", "=ds=#s8#, #a1#", "", "13%"};
		{ 4, 33211, "", "=q4=Bladeangel's Money Belt", "=ds=#s10#, #a2#", "", "14%"};
		{ 5, 33206, "", "=q4=Pauldrons of Primal Fury", "=ds=#s3#, #a3#", "", "13%"};
		{ 6, 33327, "", "=q4=Mask of Introspection", "=ds=#s1#, #a4#", "", "13%"};
		{ 7, 33191, "", "=q4=Jungle Stompers", "=ds=#s12#, #a4#", "", "13%"};
		{ 8, 33640, "", "=q4=Fury", "=ds=#h4#, #w13#", "", "14%"};
		{ 10, 33307, "", "=q3=Formula: Enchant Weapon - Executioner", "=ds=#p4# (375)", "", "3%"};
		Next = "ZAAkilZon";
	};

	AtlasLoot_Data["ZAAkilZon"] = {
		{ 1, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 2, 33286, "", "=q4=Mojo-mender's Mask", "=ds=#s1#, #a3#", "", "13%"};
		{ 3, 33215, "", "=q4=Bloodstained Elven Battlevest", "=ds=#s5#, #a4#", "", "13%"};
		{ 4, 33216, "", "=q4=Chestguard of Hidden Purpose", "=ds=#s5#, #a4#", "", "13%"};
		{ 5, 33281, "", "=q4=Brooch of Nature's Mercy", "=ds=#s2#", "", "13%"};
		{ 6, 33293, "", "=q4=Signet of Ancient Magics", "=ds=#s13#", "", "13%"};
		{ 7, 33214, "", "=q4=Akil'zon's Talonblade", "=ds=#h1#, #w10#", "", "13%"};
		{ 8, 33283, "", "=q4=Amani Punisher", "=ds=#h3#, #w6#", "", "14%"};
		{ 10, 33307, "", "=q3=Formula: Enchant Weapon - Executioner", "=ds=#p4# (375)", "", "3%"};
		Prev = "ZANalorakk";
		Next = "ZAJanAlai";
	};

	AtlasLoot_Data["ZAJanAlai"] = {
		{ 1, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 2, 33357, "", "=q4=Footpads of Madness", "=ds=#s12#, #a1#", "", "13%"};
		{ 3, 33356, "", "=q4=Helm of Natural Regeneration", "=ds=#s1#, #a2#", "", "13%"};
		{ 4, 33329, "", "=q4=Shadowtooth Trollskin Cuirass", "=ds=#s5#, #a2#", "", "13%"};
		{ 5, 33328, "", "=q4=Arrow-fall Chestguard", "=ds=#s5#, #a3#", "", "13%"};
		{ 6, 33354, "", "=q4=Wub's Cursed Hexblade", "=ds=#h3#, #w4#", "", "14%"};
		{ 7, 33326, "", "=q4=Bulwark of the Amani Empire", "=ds=#w8#", "", "13%"};
		{ 8, 33332, "", "=q4=Enamelled Disc of Mojo", "=ds=#w8#", "", "12%"};
		{ 10, 33307, "", "=q3=Formula: Enchant Weapon - Executioner", "=ds=#p4# (375)", "", "3%"};
		Prev = "ZAAkilZon";
		Next = "ZAHalazzi";
	};

	AtlasLoot_Data["ZAHalazzi"] = {
		{ 1, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 2, 33317, "", "=q4=Robe of Departed Spirits", "=ds=#s5#, #a1#", "", "13%"};
		{ 3, 33300, "", "=q4=Shoulderpads of Dancing Blades", "=ds=#s3#, #a2#", "", "14%"};
		{ 4, 33322, "", "=q4=Shimmer-pelt Vest", "=ds=#s5#, #a2#", "", "13%"};
		{ 5, 33533, "", "=q4=Avalanche Leggings", "=ds=#s11#, #a3#", "", "13%"};
		{ 6, 33299, "", "=q4=Spaulders of the Advocate", "=ds=#s3#, #a4#", "", "13%"};
		{ 7, 33303, "", "=q4=Skullshatter Warboots", "=ds=#s12#, #a4#", "", "14%"};
		{ 8, 33297, "", "=q4=The Savage's Choker", "=ds=#s2#", "", "13%"};
		{ 10, 33307, "", "=q3=Formula: Enchant Weapon - Executioner", "=ds=#p4# (375)", "", "3%"};
		Prev = "ZAJanAlai";
		Next = "ZAMalacrass";
	};

	AtlasLoot_Data["ZAMalacrass"] = {
		{ 1, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 2, 33592, "", "=q4=Cloak of Ancient Rituals", "=ds=#s4#", "", "13%"};
		{ 3, 33453, "", "=q4=Hood of Hexing", "=ds=#s1#, #a1#", "", "13%"};
		{ 4, 33463, "", "=q4=Hood of the Third Eye", "=ds=#s1#, #a1#", "", "13%"};
		{ 5, 33432, "", "=q4=Coif of the Jungle Stalker", "=ds=#s1#, #a3#", "", "15%"};
		{ 6, 33464, "", "=q4=Hex Lord's Voodoo Pauldrons", "=ds=#s3#, #a3#", "", "13%"};
		{ 7, 33421, "", "=q4=Battleworn Tuskguard", "=ds=#s1#, #a4#", "", "15%"};
		{ 8, 33446, "", "=q4=Girdle of Stromgarde's Hope", "=ds=#s10#, #a4#", "", "15%"};
		{ 10, 33307, "", "=q3=Formula: Enchant Weapon - Executioner", "=ds=#p4# (375)", "", "3%"};
		{ 16, 33829, "", "=q4=Hex Shrunken Head", "=ds=#s14#", "", "12%"};
		{ 17, 34029, "", "=q4=Tiny Voodoo Mask", "=ds=#s14#", "", "25%"};
		{ 18, 33828, "", "=q4=Tome of Diabolic Remedy", "=ds=#s14#", "", "13%"};
		{ 19, 33389, "", "=q4=Dagger of Bad Mojo", "=ds=#h1#, #w4#", "", "15%"};
		{ 20, 33298, "", "=q4=Prowler's Strikeblade", "=ds=#h1#, #w4#", "", "14%"};
		{ 21, 33388, "", "=q4=Heartless", "=ds=#h1#, #w10#", "", "15%"};
		{ 22, 33465, "", "=q4=Staff of Primal Fury", "=ds=#w9#", "", "13%"};
		Prev = "ZAHalazzi";
		Next = "ZAZuljin";
	};

	AtlasLoot_Data["ZAZuljin"] = {
		{ 1, 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "", "100%"};
		{ 2, 33471, "", "=q4=Two-toed Sandals", "=ds=#s12#, #a1#", "", "15%"};
		{ 3, 33479, "", "=q4=Grimgin Faceguard", "=ds=#s1#, #a2#", "", "15%"};
		{ 4, 33469, "", "=q4=Hauberk of the Empire's Champion", "=ds=#s5#, #a3#", "", "16%"};
		{ 5, 33473, "", "=q4=Chestguard of the Warlord", "=ds=#s5#, #a4#", "", "15%"};
		{ 6, 33466, "", "=q4=Loop of Cursed Bones", "=ds=#s2#", "", "14%"};
		{ 7, 33830, "", "=q4=Ancient Aqir Artifact", "=ds=#s14#", "", "14%"};
		{ 8, 33831, "", "=q4=Berserker's Call", "=ds=#s14#", "", "14%"};
		{ 10, 33307, "", "=q3=Formula: Enchant Weapon - Executioner", "=ds=#p4# (375)", "", "3%"};
		{ 16, 33467, "", "=q4=Blade of Twisted Visions", "=ds=#h3#, #w10#", "", "14%"};
		{ 17, 33478, "", "=q4=Jin'rohk, The Great Apocalypse", "=ds=#h2#, #w10#", "", "14%"};
		{ 18, 33476, "", "=q4=Cleaver of the Unforgiving", "=ds=#h1#, #w1#", "", "15%"};
		{ 19, 33468, "", "=q4=Dark Blessing", "=ds=#h3#, #w6#", "", "15%"};
		{ 20, 33474, "", "=q4=Ancient Amani Longbow", "=ds=#w2#", "", "14%"};
		{ 22, 33102, "", "=q4=Blood of Zul'Jin", "=ds=#m2#", "", "87%"};
		Prev = "ZAMalacrass";
	};

	AtlasLoot_Data["ZATimedChest"] = {
		{ 1, 0, "INV_Box_01", "=q6=#x30#", ""};
		{ 2, 33590, "", "=q4=Cloak of Fiends", "=ds=#s4#", "", "10%"};
		{ 3, 33591, "", "=q4=Shadowcaster's Drape", "=ds=#s4#", "", "11%"};
		{ 4, 33489, "", "=q4=Mantle of Ill Intent", "=ds=#s3#, #a1#", "", "11%"};
		{ 5, 33480, "", "=q4=Cord of Braided Troll Hair", "=ds=#s10#, #a1#", "", "10%"};
		{ 6, 33483, "", "=q4=Life-step Belt", "=ds=#s10#, #a2#", "", "12%"};
		{ 7, 33971, "", "=q4=Elunite Imbued Leggings", "=ds=#s11#, #a2#", "", "10%"};
		{ 8, 33805, "", "=q4=Shadowhunter's Treads", "=ds=#s12#, #a3#", "", "10%"};
		{ 9, 33481, "", "=q4=Pauldrons of Stone Resolve", "=ds=#s3#, #a4#", "", "11%"};
		{ 16, 0, "INV_Box_01", "=q6=#x31#", ""};
		{ 17, 33495, "", "=q4=Rage", "=ds=#h3#, #w13#", "", "12%"};
		{ 18, 33493, "", "=q4=Umbral Shiv", "=ds=#h1#, #w4#", "", "12%"};
		{ 19, 33492, "", "=q4=Trollbane", "=ds=#h2#, #w1#", "", "11%"};
		{ 20, 33490, "", "=q4=Staff of Dark Mending", "=ds=#w9#", "", "13%"};
		{ 21, 33494, "", "=q4=Amani Divining Staff", "=ds=#w9#", "", "11%"};
		{ 22, 33491, "", "=q4=Tuskbreaker", "=ds=#w5#", "", "12%"};
		{ 24, 0, "INV_Box_01", "=q6=#x32#", ""};
		{ 25, 33497, "", "=q4=Mana Attuned Band", "=ds=#s13#", "", "18%"};
		{ 26, 33500, "", "=q4=Signet of Eternal Life", "=ds=#s13#", "", "20%"};
		{ 27, 33496, "", "=q4=Signet of Primal Wrath", "=ds=#s13#", "", "23%"};
		{ 28, 33499, "", "=q4=Signet of the Last Defender", "=ds=#s13#", "", "18%"};
		{ 29, 33498, "", "=q4=Signet of the Quiet Forest", "=ds=#s13#", "", "21%"};
	};

	AtlasLoot_Data["ZATrash"] = {
		{ 1, 33993, "", "=q3=Mojo", "=ds=#e13#"};
		{ 3, 33865, "", "=q2=Amani Hex Stick", "=ds=#m20#", "", "40%"};
		{ 4, 33930, "", "=q2=Amani Charm of the Bloodletter", "=ds=#m26#", "", "25%"};
		{ 5, 33932, "", "=q2=Amani Charm of the Witch Doctor", "=ds=#m26#", "", "24%"};
		{ 6, 33931, "", "=q2=Amani Charm of Mighty Mojo", "=ds=#m26#", "", "25%"};
		{ 7, 33933, "", "=q2=Amani Charm of the Raging Defender", "=ds=#m26#", "", "25%"};
	};

	----------------
	--- Factions ---
	----------------

		----------------------------
		--- Ashtongue Deathsworn ---
		----------------------------

	AtlasLoot_Data["Ashtongue1"] = {
		{ 1, 0, "INV_Misc_Gem_Pearl_05", "=q6=#r2#", ""};
		{ 2, 32444, "", "=q1=Plans: Shadesteel Girdle", "=ds=#p2# (375)"};
		{ 3, 32442, "", "=q1=Plans: Shadesteel Bracers", "=ds=#p2# (375)"};
		{ 4, 32436, "", "=q1=Pattern: Redeemed Soul Cinch", "=ds=#p7# (375)"};
		{ 5, 32435, "", "=q1=Pattern: Redeemed Soul Legguards", "=ds=#p7# (375)"};
		{ 6, 32430, "", "=q1=Pattern: Bracers of Shackled Souls", "=ds=#p7# (375)"};
		{ 7, 32429, "", "=q1=Pattern: Boots of Shackled Souls", "=ds=#p7# (375)"};
		{ 8, 32440, "", "=q1=Pattern: Soulguard Girdle", "=ds=#p8# (375)"};
		{ 9, 32438, "", "=q1=Pattern: Soulguard Bracers", "=ds=#p8# (375)"};
		{ 16, 0, "INV_Misc_Gem_Pearl_05", "=q6=#r3#", ""};
		{ 17, 32443, "", "=q1=Plans: Shadesteel Greaves", "=ds=#p2# (375)"};
		{ 18, 32441, "", "=q1=Plans: Shadesteel Sabots", "=ds=#p2# (375)"};
		{ 19, 32433, "", "=q1=Pattern: Redeemed Soul Mocassins", "=ds=#p7# (375)"};
		{ 20, 32434, "", "=q1=Pattern: Redeemed Soul Wristguards", "=ds=#p7# (375)"};
		{ 21, 32431, "", "=q1=Pattern: Greaves of Shackled Souls", "=ds=#p7# (375)"};
		{ 22, 32432, "", "=q1=Pattern: Waistguard of Shackled Souls", "=ds=#p7# (375)"};
		{ 23, 32447, "", "=q1=Pattern: Night's End", "=ds=#p8# (375)"};
		{ 24, 32439, "", "=q1=Pattern: Soulguard Leggings", "=ds=#p8# (375)"};
		{ 25, 32437, "", "=q1=Pattern: Soulguard Slippers", "=ds=#p8# (375)"};
		Next = "Ashtongue2";
		Back = "REPMENU_BURNINGCRUSADE";
	};

	AtlasLoot_Data["Ashtongue2"] = {
		{ 1, 0, "INV_Misc_Gem_Pearl_05", "=q6=#r5#", ""};
		{ 2, 32486, "", "=q4=Ashtongue Talisman of Equilibrium", "=ds=#s14#, =q1=#m1# =ds=#c1#"};
		{ 3, 32487, "", "=q4=Ashtongue Talisman of Swiftness", "=ds=#s14#, =q1=#m1# =ds=#c2#"};
		{ 4, 32488, "", "=q4=Ashtongue Talisman of Insight", "=ds=#s14#, =q1=#m1# =ds=#c3#"};
		{ 5, 32489, "", "=q4=Ashtongue Talisman of Zeal", "=ds=#s14#, =q1=#m1# =ds=#c4#"};
		{ 6, 32490, "", "=q4=Ashtongue Talisman of Acumen", "=ds=#s14#, =q1=#m1# =ds=#c5#"};
		{ 7, 32492, "", "=q4=Ashtongue Talisman of Lethality", "=ds=#s14#, =q1=#m1# =ds=#c6#"};
		{ 8, 32491, "", "=q4=Ashtongue Talisman of Vision", "=ds=#s14#, =q1=#m1# =ds=#c7#"};
		{ 9, 32493, "", "=q4=Ashtongue Talisman of Shadows", "=ds=#s14#, =q1=#m1# =ds=#c8#"};
		{ 10, 32485, "", "=q4=Ashtongue Talisman of Valor", "=ds=#s14#, =q1=#m1# =ds=#c9#"};
		Prev = "Ashtongue1";
		Back = "REPMENU_BURNINGCRUSADE";
	};

		----------------------------
		---  Cenarion Expedition ---
		----------------------------

	AtlasLoot_Data["CExpedition1"] = {
		{ 1, 0, "INV_Misc_Ammo_Arrow_02", "=q6=#r2#", ""};
		{ 2, 25737, "", "=q3=Pattern: Heavy Clefthoof Boots", "=ds=#p7# (355)"};
		{ 3, 24417, "", "=q2=Scout's Arrow", "=ds=#w17#"};
		{ 4, 23814, "", "=q1=Schematic: Green Smoke Flare", "=ds=#p5# (335)"};
		{ 5, 24429, "", "=q1=Expedition Flare", ""};
		{ 16, 0, "INV_Misc_Ammo_Arrow_02", "=q6=#r3#", ""};
		{ 17, 25838, "", "=q3=Warden's Hauberk", "=ds=#s5#, #a2#"};
		{ 18, 25836, "", "=q3=Preserver's Cudgel", "=ds=#h3#, #w6#"};
		{ 19, 25835, "", "=q3=Explorer's Walking Stick", "=ds=#w9#"};
		{ 20, 25735, "", "=q3=Pattern: Heavy Clefthoof Vest", "=ds=#p7# (360)"};
		{ 21, 25736, "", "=q3=Pattern: Heavy Clefthoof Leggings", "=ds=#p7# (355)"};
		{ 22, 29194, "", "=q2=Arcanum of Nature Warding", "#s1# #e17#"};
		{ 23, 25869, "", "=q1=Recipe: Transmute Earthstorm Diamond", "=ds=#p1# (350)"};
		{ 24, 32070, "", "=q1=Recipe: Earthen Elixir", "=ds=#p1# (320)"};
		{ 25, 23618, "", "=q1=Plans: Adamantite Sharpening Stone", "=ds=#p2# (350)"};
		{ 26, 28632, "", "=q1=Plans: Adamantite Weightstone", "=ds=#p2# (350)"};
		{ 27, 25526, "", "=q1=Plans: Greater Rune of Warding", "=ds=#p2# (350)"};
		{ 28, 29720, "", "=q1=Pattern: Clefthide Leg Armor", "=ds=#p7# (335)"};
		{ 29, 30623, "", "=q1=Reservoir Key", "=ds=#e9#"};
		Next = "CExpedition2";
		Back = "REPMENU_BURNINGCRUSADE";
	};

	AtlasLoot_Data["CExpedition2"] = {
		{ 1, 0, "INV_Misc_Ammo_Arrow_02", "=q6=#r4#", ""};
		{ 2, 31392, "", "=q4=Plans: Wildguard Helm", "=ds=#p2# (375)"};
		{ 3, 31391, "", "=q4=Plans: Wildguard Leggings", "=ds=#p2# (375)"};
		{ 4, 29174, "", "=q3=Watcher's Cowl", "=ds=#s1#, #a1#"};
		{ 5, 29173, "", "=q3=Strength of the Untamed", "=ds=#s2#"};
		{ 6, 31949, "", "=q3=Warden's Arrow", "=ds=#w17#"};
		{ 7, 24183, "", "=q3=Design: Nightseye Panther", "=ds=#p12# (370)"};
		{ 8, 29192, "", "=q2=Arcanum of Ferocity", "=ds=#s1# #e17#"};
		{ 9, 22918, "", "=q2=Recipe: Transmute Primal Water to Air", "=ds=#p1# (350)"};
		{ 10, 28271, "", "=q2=Formula: Enchant Gloves - Spell Strike", "=ds=#p4# (360)"};
		{ 16, 0, "INV_Misc_Ammo_Arrow_02", "=q6=#r5#", ""};
		{ 17, 29170, "", "=q4=Windcaller's Orb", "=ds=#s15#"};
		{ 18, 29172, "", "=q4=Ashyen's Gift", "=ds=#s13#"};
		{ 19, 29171, "", "=q4=Earthwarden", "=ds=#h2#, #w6#"};
		{ 20, 33999, "", "=q4=Cenarion War Hippogryph", "=ds=#e12#"};
		{ 21, 31390, "", "=q4=Plans: Wildguard Breastplate", "=ds=#p2# (375)"};
		{ 22, 31402, "", "=q4=Design: The Natural Ward", "=ds=#p12# (375)"};
		{ 23, 33149, "", "=q3=Formula: Enchant Cloak - Stealth", "=ds=#p4# (300)"};
		{ 24, 31356, "", "=q2=Recipe: Flask of Distilled Wisdom", "=ds=#p1# (300)"};
		{ 25, 22922, "", "=q1=Recipe: Major Nature Protection Potion", "=ds=#p1# (360)"};
		{ 26, 29721, "", "=q1=Pattern: Nethercleft Leg Armor", "=ds=#p7# (365)"};
		{ 27, 31804, "", "=q1=Cenarion Expedition Tabard", "=ds=#s7#"};
		Prev = "CExpedition1";
		Back = "REPMENU_BURNINGCRUSADE";
	};

		------------------
		--- Honor Hold ---
		------------------

	AtlasLoot_Data["HonorHold1"] = {
		{ 1, 0, "INV_BannerPVP_02", "=q6=#r2#", ""};
		{ 2, 29213, "", "=q3=Pattern: Felstalker Belt", "=ds=#p7# (350)"};
		{ 3, 23142, "", "=q2=Design: Enduring Deep Peridot", "=ds=#p12# (315)"};
		{ 4, 22531, "", "=q1=Formula: Enchant Bracer - Superior Healing", "=ds=#p4# (325)"};
		{ 5, 24007, "", "=q1=Footman's Waterskin", "=ds=#e4#"};
		{ 6, 24008, "", "=q1=Dried Mushroom Rations", "=ds=#e3#"};
		{ 16, 0, "INV_BannerPVP_02", "=q6=#r3#", ""};
		{ 17, 25826, "", "=q3=Sage's Band", "=ds=#s13#"};
		{ 18, 25825, "", "=q3=Footman's Longsword", "=ds=#h1#, #w10#"};
		{ 19, 29214, "", "=q3=Pattern: Felstalker Bracers", "=ds=#p7# (360)"};
		{ 20, 29215, "", "=q3=Pattern: Felstalker Breastplate", "=ds=#p7# (360)"};
		{ 21, 29196, "", "=q2=Arcanum of Fire Warding", "=ds=#s1# #e17#"};
		{ 22, 25870, "", "=q1=Recipe: Transmute Skyfire Diamond", "=ds=#p1# (350)"};
		{ 23, 22905, "", "=q1=Recipe: Elixir of Major Agility", "=ds=#p1# (330)"};
		{ 24, 29719, "", "=q1=Pattern: Cobrahide Leg Armor", "=ds=#p7# (335)"};
		{ 25, 30622, "", "=q1=Flamewrought Key", "=ds=#e9#"};
		Next = "HonorHold2";
		Back = "REPMENU_BURNINGCRUSADE";
	};

	AtlasLoot_Data["HonorHold2"] = {
		{ 1, 0, "INV_BannerPVP_02", "=q6=#r4#", ""};
		{ 2, 29169, "", "=q3=Ring of Convalescence", "=ds=#s13#"};
		{ 3, 29166, "", "=q3=Hellforged Halberd", "=ds=#w7#"};
		{ 4, 32883, "", "=q3=Felbane Slugs", "=ds=#w18#"};
		{ 5, 24180, "", "=q3=Design: Dawnstone Crab", "=ds=#p12# (370)"};
		{ 6, 29189, "", "=q2=Arcanum of Renewal", "=ds=#s1# #e17#"};
		{ 7, 22547, "", "=q1=Formula: Enchant Chest - Exceptional Stats", "=ds=#p4# (345)"};
		{ 8, 34218, "", "=q1=Pattern: Netherscale Ammo Pouch", "=ds=#p7# (350)"};
		{ 16, 0, "INV_BannerPVP_02", "=q6=#r5#", ""};
		{ 17, 29153, "", "=q4=Blade of the Archmage", "=ds=#h3#, #w10#"};
		{ 18, 29156, "", "=q4=Honor's Call", "=ds=#h1#, #w10#"};
		{ 19, 29151, "", "=q4=Veteran's Musket", "=ds=#w5#"};
		{ 20, 33150, "", "=q3=Formula: Enchant Cloak - Subtlety", "=ds=#p4# (300)"};
		{ 21, 23619, "", "=q1=Plans: Felsteel Shield Spike", "=ds=#p2# (360)"};
		{ 22, 29722, "", "=q1=Pattern: Nethercobra Leg Armor", "=ds=#p7# (365)"};
		{ 23, 23999, "", "=q1=Honor Hold Tabard", "=ds=#s7#"};
		Prev = "HonorHold1";
		Back = "REPMENU_BURNINGCRUSADE";
	};

		-----------------------
		--- Keepers of Time ---
		-----------------------

	AtlasLoot_Data["KeepersofTime1"] = {
		{ 1, 0, "Ability_Warrior_VictoryRush", "=q6=#r3#", ""};
		{ 2, 29198, "", "=q2=Arcanum of Frost Warding", "=ds=#s1# #e17#"};
		{ 3, 28272, "", "=q2=Formula: Enchant Gloves - Major Spellpower", "=ds=#p4# (360)"};
		{ 4, 22536, "", "=q1=Formula: Enchant Ring - Spellpower", "=ds=#p4# (360)"};
		{ 5, 25910, "", "=q1=Design: Enigmatic Skyfire Diamond", "=ds=#p12# (365)"};
		{ 6, 33160, "", "=q1=Design: Facet of Eternity", "=ds=#p12# (360)"};
		{ 7, 29713, "", "=q1=Pattern: Drums of Panic", "=ds=#p7# (370)"};
		{ 8, 30635, "", "=q1=Key of Time", "=ds=#e9#"};
		{ 16, 0, "Ability_Warrior_VictoryRush", "=q6=#r4#", ""};
		{ 17, 29184, "", "=q3=Timewarden's Leggings", "=ds=#s11#, #a4#"};
		{ 18, 29185, "", "=q3=Continuum Blade", "=ds=#h3#, #w10#"};
		{ 19, 24181, "", "=q3=Design: Living Ruby Serpent", "=ds=#p12# (370)"};
		{ 20, 24174, "", "=q3=Design: Pendant of Frozen Flame", "=ds=#p12# (360)"};
		{ 21, 29186, "", "=q2=Arcanum of the Defender", "=ds=#s1# #e17#"};
		{ 22, 33158, "", "=q1=Design: Stone of Blades", "=ds=#p12# (360)"};
		{ 24, 0, "Ability_Warrior_VictoryRush", "=q6=#r5#", ""};
		{ 25, 29183, "", "=q4=Bindings of the Timewalker", "=ds=#s8#, #a1#"};
		{ 26, 29181, "", "=q4=Timelapse Shard", "=ds=#s14#"};
		{ 27, 29182, "", "=q4=Riftmaker", "=ds=#h1#, #w4#"};
		{ 28, 33152, "", "=q3=Formula: Enchant Gloves - Superior Agility", "=ds=#p4# (300)"};
		{ 29, 31355, "", "=q2=Recipe: Flask of Supreme Power", "=ds=#p1# (300)"};
		{ 30, 31777, "", "=q1=Keepers of Time Tabard", "=ds=#s7#"};
		Back = "REPMENU_BURNINGCRUSADE";
	};

		---------------
		--- Kurenai ---
		---------------

	AtlasLoot_Data["Kurenai1"] = {
		{ 1, 0, "INV_Misc_Foot_Centaur", "=q6=#r2#", ""};
		{ 2, 29217, "", "=q3=Pattern: Netherfury Belt", "=ds=#p7# (340)"};
		{ 4, 0, "INV_Misc_Foot_Centaur", "=q6=#r3#", ""};
		{ 5, 29144, "", "=q3=Worg Hide Quiver", "=ds=#m14# #w19# =q1=#m1# =ds=#c2#"};
		{ 6, 29219, "", "=q3=Pattern: Netherfury Leggings", "=ds=#p7# (340)"};
		{ 7, 34175, "", "=q1=Pattern: Drums of Restoration", "=ds=#p7# (350)"};
		{ 8, 34173, "", "=q1=Pattern: Drums of Speed", "=ds=#p7# (345)"};
		{ 9, 30444, "", "=q1=Pattern: Reinforced Mining Bag", "=ds=#p7# (325)"};
		{ 11, 0, "INV_Misc_Foot_Centaur", "=q6=#r4#", ""};
		{ 12, 29148, "", "=q3=Blackened Leather Spaulders", "=ds=#s3#, #a2#"};
		{ 13, 29142, "", "=q3=Kurenai Kilt", "=ds=#s11#, #a2#"};
		{ 14, 29146, "", "=q3=Band of Elemental Spirits", "=ds=#s13#"};
		{ 15, 29218, "", "=q3=Pattern: Netherfury Boots", "=ds=#p7# (350)"};
		{ 16, 30443, "", "=q2=Recipe: Transmute Primal Fire to Earth", "=ds=#p1# (350)"};
		{ 18, 0, "INV_Misc_Foot_Centaur", "=q6=#r5#", ""};
		{ 19, 29227, "", "=q4=Reins of the Cobalt War Talbuk", "=ds=#e12#"};
		{ 20, 29229, "", "=q4=Reins of the Silver War Talbuk", "=ds=#e12#"};
		{ 21, 29230, "", "=q4=Reins of the Tan War Talbuk", "=ds=#e12#"};
		{ 22, 29231, "", "=q4=Reins of the White War Talbuk", "=ds=#e12#"};
		{ 23, 31830, "", "=q4=Reins of the Cobalt Riding Talbuk", "=ds=#e12#"};
		{ 24, 31832, "", "=q4=Reins of the Silver Riding Talbuk", "=ds=#e12#"};
		{ 25, 31834, "", "=q4=Reins of the Tan Riding Talbuk", "=ds=#e12#"};
		{ 26, 31836, "", "=q4=Reins of the White Riding Talbuk", "=ds=#e12#"};
		{ 27, 29140, "", "=q3=Cloak of the Ancient Spirits", "=ds=#s4#"};
		{ 28, 29136, "", "=q3=Far Seer's Helm", "=ds=#s1#, #a3#"};
		{ 29, 29138, "", "=q3=Arechron's Gift", "=ds=#h2#, #w6#"};
		{ 30, 31774, "", "=q1=Kurenai Tabard", "=ds=#s7#"};
		Back = "REPMENU_BURNINGCRUSADE";
	};

		------------------
		--- Lower City ---
		------------------

	AtlasLoot_Data["LowerCity1"] = {
		{ 1, 0, "Ability_Rogue_MasterOfSubtlety", "=q6=#r2#", ""};
		{ 2, 23138, "", "=q2=Design: Potent Flame Spessarite", "=ds=#p12# (325)"};
		{ 4, 0, "Ability_Rogue_MasterOfSubtlety", "=q6=#r4#", ""};
		{ 5, 30836, "", "=q3=Leggings of the Skettis Exile", "=ds=#s11#, #a1#"};
		{ 6, 30835, "", "=q3=Salvager's Hauberk", "=ds=#s5#, #a3#"};
		{ 7, 30841, "", "=q3=Lower City Prayerbook", "=ds=#s14#"};
		{ 8, 24179, "", "=q3=Design: Felsteel Boar", "=ds=#p12# (370)"};
		{ 9, 24175, "", "=q3=Design: Pendant of Thawing", "=ds=#p12# (360)"};
		{ 10, 30846, "", "=q2=Arcanum of the Outcast", "=ds=#s1# #e17#"};
		{ 11, 22910, "", "=q2=Recipe: Elixir of Major Shadow Power", "=ds=#p1# (350)"};
		{ 12, 33157, "", "=q1=Design: Falling Star", "=ds=#p12# (360)"};
		{ 13, 34200, "", "=q1=Pattern: Quiver of a Thousand Arrows", "=ds=#p7# (350)"};
		{ 16, 0, "Ability_Rogue_MasterOfSubtlety", "=q6=#r3#", ""};
		{ 17, 29199, "", "=q2=Arcanum of Shadow Warding", "=ds=#s1# #e17#"};
		{ 18, 22538, "", "=q1=Formula: Enchant Ring - Stats", "=ds=#p4# (375)"};
		{ 19, 30833, "", "=q1=Pattern: Cloak of Arcane Evasion", "=ds=#p8# (350)"};
		{ 20, 30633, "", "=q1=Auchenai Key", "=ds=#e9#"};
		{ 22, 0, "Ability_Rogue_MasterOfSubtlety", "=q6=#r5#", ""};
		{ 23, 30834, "", "=q4=Shapeshifter's Signet", "=ds=#s13#"};
		{ 24, 30832, "", "=q4=Gavel of Unearthed Secrets", "=ds=#h3#, #w6#"};
		{ 25, 30830, "", "=q4=Trident of the Outcast Tribe", "=ds=#w7#"};
		{ 26, 33148, "", "=q3=Formula: Enchant Cloak - Dodge", "=ds=#p4# (300)"};
		{ 27, 31357, "", "=q2=Recipe: Flask of Chromatic Resistance", "=ds=#p1# (300)"};
		{ 28, 31778, "", "=q1=Lower City Tabard", "=ds=#s7#"};
		Back = "REPMENU_BURNINGCRUSADE";
	};

		------------------
		--- Netherwing ---
		------------------

	AtlasLoot_Data["Netherwing1"] = {
		{ 1, 0, "Ability_Mount_Netherdrakepurple", "=q6=#r2#", ""};
		{ 2, 32694, "", "=q2=Overseer's Badge", "=ds=#s14#"};
		{ 4, 0, "Ability_Mount_Netherdrakepurple", "=q6=#r3#", ""};
		{ 5, 32695, "", "=q3=Captain's Badge", "=ds=#s14#"};
		{ 6, 32863, "", "=q3=Skybreaker Whip", "=q1=#m4#: =ds=#s14#"};
		{ 8, 0, "Ability_Mount_Netherdrakepurple", "=q6=#r4#", ""};
		{ 9, 32864, "", "=q3=Commander's Badge", "=ds=#s14#"};
		{ 16, 0, "Ability_Mount_Netherdrakepurple", "=q6=#r5#", ""};
		{ 17, 32858, "", "=q4=Reins of the Azure Netherwing Drake", "=ds=#e12#"};
		{ 18, 32859, "", "=q4=Reins of the Cobalt Netherwing Drake", "=ds=#e12#"};
		{ 19, 32857, "", "=q4=Reins of the Onyx Netherwing Drake", "=ds=#e12#"};
		{ 20, 32860, "", "=q4=Reins of the Purple Netherwing Drake", "=ds=#e12#"};
		{ 21, 32861, "", "=q4=Reins of the Veridian Netherwing Drake", "=ds=#e12#"};
		{ 22, 32862, "", "=q4=Reins of the Violet Netherwing Drake", "=ds=#e12#"};
		Back = "REPMENU_BURNINGCRUSADE";
	};

		---------------
		--- Ogri'la ---
		---------------

	AtlasLoot_Data["Ogrila1"] = {
		{ 1, 0, "INV_DataCrystal01", "=q6=#r2#", ""};
		{ 2, 32910, "", "=q1=Red Ogre Brew Special", "=q1=#m4#: =ds=#e2#"};
		{ 3, 32909, "", "=q1=Blue Ogre Brew Special", "=q1=#m4#: =ds=#e2#"};
		{ 5, 0, "INV_DataCrystal01", "=q6=#r3#", ""};
		{ 6, 32784, "", "=q1=Red Ogre Brew", "=ds=#e2#", "2 #ogrilashard#", ""};
		{ 7, 32783, "", "=q1=Blue Ogre Brew", "=ds=#e2#", "3 #ogrilashard#", ""};
		{ 14, 32572, "", "=q3=Apexis Crystal", "=ds=#m17#"};
		{ 16, 0, "INV_DataCrystal01", "=q6=#r4#", ""};
		{ 17, 32653, "", "=q3=Apexis Cloak", "=ds=#s4#", "1 #ogrilacrystal# 50 #ogrilashard#", ""};
		{ 18, 32654, "", "=q3=Crystalforged Trinket", "=ds=#s14#", "1 #ogrilacrystal# 50 #ogrilashard#", ""};
		{ 19, 32652, "", "=q3=Ogri'la Aegis", "=ds=#w8#", "1 #ogrilacrystal# 50 #ogrilashard#", ""};
		{ 20, 32650, "", "=q3=Cerulean Crystal Rod", "=ds=#w12#", "1 #ogrilacrystal# 50 #ogrilashard#", ""};
		{ 22, 0, "INV_DataCrystal01", "=q6=#r5#", ""};
		{ 23, 32647, "", "=q4=Shard-bound Bracers", "=ds=#s8#, #a2#", "4 #ogrilacrystal# 100 #ogrilashard#", ""};
		{ 24, 32648, "", "=q4=Vortex Walking Boots", "=ds=#s12#, #a4#", "4 #ogrilacrystal# 100 #ogrilashard#", ""};
		{ 25, 32651, "", "=q4=Crystal Orb of Enlightenment", "=ds=#s15#", "4 #ogrilacrystal# 100 #ogrilashard#", ""};
		{ 26, 32645, "", "=q4=Crystalline Crossbow", "=ds=#w3#", "4 #ogrilacrystal# 100 #ogrilashard#", ""};
		{ 27, 32828, "", "=q1=Ogri'la Tabard", "=ds=#s7#", "10 #ogrilashard#", ""};
		{ 29, 32569, "", "=q1=Apexis Shard", "=ds=#m17#"};
		Back = "REPMENU_BURNINGCRUSADE";
	};

		-------------------------
		--- Sha'tari Skyguard ---
		-------------------------

	AtlasLoot_Data["Skyguard1"] = {
		{ 1, 0, "INV_Misc_Ribbon_01", "=q6=#r2#", ""};
		{ 2, 32722, "", "=q1=Enriched Terocone Juice", "=ds=#e4#"};
		{ 4, 0, "INV_Misc_Ribbon_01", "=q6=#r3#", ""};
		{ 5, 32721, "", "=q1=Skyguard Rations", "=ds=#e3#"};
		{ 7, 0, "INV_Misc_Ribbon_01", "=q6=#r4#", ""};
		{ 8, 32539, "", "=q3=Skyguard's Drape", "=ds=#s4#"};
		{ 9, 32538, "", "=q3=Skywitch's Drape", "=ds=#s4#"};
		{ 16, 0, "INV_Misc_Ribbon_01", "=q6=#r5#", ""};
		{ 17, 32770, "", "=q4=Skyguard Silver Cross", "=ds=#s14#"};
		{ 18, 32771, "", "=q4=Airman's Ribbon of Gallantry", "=ds=#s14#"};
		{ 19, 32319, "", "=q4=Blue Riding Nether Ray", "=ds=#e12#"};
		{ 20, 32314, "", "=q4=Green Riding Nether Ray", "=ds=#e12#"};
		{ 21, 32317, "", "=q4=Red Riding Nether Ray", "=ds=#e12#"};
		{ 22, 32316, "", "=q4=Purple Riding Nether Ray", "=ds=#e12#"};
		{ 23, 32318, "", "=q4=Silver Riding Nether Ray", "=ds=#e12#"};
		{ 24, 38628, "", "=q3=Nether Ray Fry", "=ds=#e13#"};
		{ 25, 32445, "", "=q1=Skyguard Tabard", "=ds=#s7#"};
		Back = "REPMENU_BURNINGCRUSADE";
	};

		-------------------------------
		--- Shattered Sun Offensive ---
		-------------------------------

	AtlasLoot_Data["SunOffensive1"] = {
		{ 1, 0, "INV_Misc_Statue_04", "=q6=#r2#", ""};
		{ 2, 35244, "", "=q1=Design: Bold Crimson Spinel", "=ds=#p12# (375)"};
		{ 3, 35245, "", "=q1=Design: Bright Crimson Spinel", "=ds=#p12# (375)"};
		{ 4, 35255, "", "=q1=Design: Brilliant Lionseye", "=ds=#p12# (375)"};
		{ 5, 35246, "", "=q1=Design: Delicate Crimson Spinel", "=ds=#p12# (375)"};
		{ 6, 35256, "", "=q1=Design: Gleaming Lionseye", "=ds=#p12# (375)"};
		{ 7, 35262, "", "=q1=Design: Lustrous Empyrean Sapphire", "=ds=#p12# (375)"};
		{ 8, 35248, "", "=q1=Design: Runed Crimson Spinel", "=ds=#p12# (375)"};
		{ 9, 35260, "", "=q1=Design: Smooth Lionseye", "=ds=#p12# (375)"};
		{ 10, 35263, "", "=q1=Design: Solid Empyrean Sapphire", "=ds=#p12# (375)"};
		{ 11, 35264, "", "=q1=Design: Sparkling Empyrean Sapphire", "=ds=#p12# (375)"};
		{ 12, 35249, "", "=q1=Design: Subtle Crimson Spinel", "=ds=#p12# (375)"};
		{ 13, 35250, "", "=q1=Design: Teardrop Crimson Spinel", "=ds=#p12# (375)"};
		{ 14, 35261, "", "=q1=Design: Thick Lionseye", "=ds=#p12# (375)"};
		{ 15, 34780, "", "=q1=Naaru Ration", "=ds=#e3#"};
		{ 16, 0, "INV_Misc_Statue_04", "=q6=#r3#", ""};
		{ 17, 35238, "", "=q1=Design: Balanced Shadowsong Amethyst", "=ds=#p12# (375)"};
		{ 18, 35251, "", "=q1=Design: Dazzling Seaspray Emerald", "=ds=#p12# (375)"};
		{ 19, 35266, "", "=q1=Design: Glinting Pyrestone", "=ds=#p12# (375)"};
		{ 20, 35239, "", "=q1=Design: Glowing Shadowsong Amethyst", "=ds=#p12# (375)"};
		{ 21, 35240, "", "=q1=Design: Infused Shadowsong Amethyst", "=ds=#p12# (375)"};
		{ 22, 35253, "", "=q1=Design: Jagged Seaspray Emerald", "=ds=#p12# (375)"};
		{ 23, 35268, "", "=q1=Design: Luminous Pyrestone", "=ds=#p12# (375)"};
		{ 24, 35269, "", "=q1=Design: Potent Pyrestone", "=ds=#p12# (375)"};
		{ 25, 35254, "", "=q1=Design: Radiant Seaspray Emerald", "=ds=#p12# (375)"};
		{ 26, 34872, "", "=q1=Formula: Void Shatter", "=ds=#p4# (375)"};
		{ 27, 35500, "", "=q1=Formula: Enchant Chest - Defense", "=ds=#p4# (360)"};
		Next = "SunOffensive2";
		Back = "REPMENU_BURNINGCRUSADE";
	};

	AtlasLoot_Data["SunOffensive2"] = {
		{ 1, 0, "INV_Misc_Statue_04", "=q6=#r4#", ""};
		{ 2, 35769, "", "=q4=Design: Forceful Seaspray Emerald", "=ds=#p12# (375)"};
		{ 3, 35768, "", "=q4=Design: Quick Lionseye", "=ds=#p12# (375)"};
		{ 4, 35767, "", "=q4=Design: Reckless Pyrestone", "=ds=#p12# (375)"};
		{ 5, 35766, "", "=q4=Design: Steady Seaspray Emerald", "=ds=#p12# (375)"};
		{ 6, 34665, "", "=q3=Bombardier's Blade", "=ds=#h1#, #w4#"};
		{ 7, 34667, "", "=q3=Archmage's Guile", "=ds=#h3#, #w10#"};
		{ 8, 34672, "", "=q3=Inuuro's Blade", "=ds=#h1#, #w10#"};
		{ 9, 34666, "", "=q3=The Sunbreaker", "=ds=#h1#, #w10#"};
		{ 10, 34671, "", "=q3=K'iru's Presage", "=ds=#h3#, #w6#"};
		{ 11, 34670, "", "=q3=Seeker's Gavel", "=ds=#h3#, #w6#"};
		{ 12, 34673, "", "=q3=Legionfoe", "=ds=#h2#, #w1#"};
		{ 13, 34674, "", "=q3=Truestrike Crossbow", "=ds=#w3#"};
		{ 14, 29193, "", "=q2=Arcanum of the Gladiator", "=ds=#s1# #e17#"};
		{ 17, 35252, "", "=q1=Design: Enduring Seaspray Emerald", "=ds=#p12# (375)"};
		{ 18, 35697, "", "=q1=Design: Figurine - Crimson Serpent", "=ds=#p12# (375)"};
		{ 19, 35695, "", "=q1=Design: Figurine - Empyrean Tortoise", "=ds=#p12# (375)"};
		{ 20, 35696, "", "=q1=Design: Figurine - Khorium Boar", "=ds=#p12# (375)"};
		{ 21, 35699, "", "=q1=Design: Figurine - Seaspray Albatross", "=ds=#p12# (375)"};
		{ 22, 35698, "", "=q1=Design: Figurine - Shadowsong Panther", "=ds=#p12# (375)"};
		{ 23, 35259, "", "=q1=Design: Rigid Lionseye", "=ds=#p12# (375)"};
		{ 24, 35241, "", "=q1=Design: Royal Shadowsong Amethyst", "=ds=#p12# (375)"};
		{ 25, 35271, "", "=q1=Design: Wicked Pyrestone", "=ds=#p12# (375)"};
		{ 26, 35505, "", "=q1=Design: Ember Skyfire Diamond", "=ds=#p12# (370)"};
		{ 27, 35502, "", "=q1=Design: Eternal Earthstorm Diamond", "=ds=#p12# (370)"};
		{ 28, 35708, "", "=q1=Design: Regal Nightseye", "=ds=#p12# (350)"};
		Next = "SunOffensive3";
		Prev = "SunOffensive1";
		Back = "REPMENU_BURNINGCRUSADE";
	};

	AtlasLoot_Data["SunOffensive3"] = {
		{ 1, 0, "INV_Misc_Statue_04", "=q6=#r5#", ""};
		{ 2, 34678, "", "=q4=Shattered Sun Pendant of Acumen", "=ds=#s2#"};
		{ 3, 34679, "", "=q4=Shattered Sun Pendant of Might", "=ds=#s2#"};
		{ 4, 34680, "", "=q4=Shattered Sun Pendant of Resolve", "=ds=#s2#"};
		{ 5, 34677, "", "=q4=Shattered Sun Pendant of Restoration", "=ds=#s2#"};
		{ 6, 34676, "", "=q4=Dawnforged Defender", "=ds=#w8#"};
		{ 7, 34675, "", "=q4=Sunward Crest", "=ds=#w8#"};
		{ 8, 35325, "", "=q3=Design: Forceful Talasite", "=ds=#p12# (350)"};
		{ 9, 35322, "", "=q3=Design: Quick Dawnstone", "=ds=#p12# (350)"};
		{ 10, 35323, "", "=q3=Design: Reckless Noble Topaz", "=ds=#p12# (350)"};
		{ 11, 35221, "", "=q1=Tabard of the Shattered Sun", "=ds=#s7#"};
		{ 17, 35247, "", "=q1=Design: Flashing Crimson Spinel", "=ds=#p12# (375)"};
		{ 18, 35257, "", "=q1=Design: Great Lionseye", "=ds=#p12# (375)"};
		{ 19, 35267, "", "=q1=Design: Inscribed Pyrestone", "=ds=#p12# (375)"};
		{ 20, 35258, "", "=q1=Design: Mystic Lionseye", "=ds=#p12# (375)"};
		{ 21, 37504, "", "=q1=Design: Purified Shadowsong Amethyst", "=ds=#p12# (375)"};
		{ 22, 35242, "", "=q1=Design: Shifting Shadowsong Amethyst", "=ds=#p12# (375)"};
		{ 23, 35243, "", "=q1=Design: Sovereign Shadowsong Amethyst", "=ds=#p12# (375)"};
		{ 24, 35265, "", "=q1=Design: Stormy Empyrean Sapphire", "=ds=#p12# (375)"};
		{ 25, 35270, "", "=q1=Design: Veiled Pyrestone", "=ds=#p12# (375)"};
		{ 26, 35755, "", "=q1=Recipe: Assassin's Alchemist Stone", "=ds=#p1# (375)"};
		{ 27, 35752, "", "=q1=Recipe: Guardian's Alchemist Stone", "=ds=#p1# (375)"};
		{ 28, 35754, "", "=q1=Recipe: Redeemer's Alchemist Stone", "=ds=#p1# (375)"};
		{ 29, 35753, "", "=q1=Recipe: Sorcerer's Alchemist Stone", "=ds=#p1# (375)"};
		Prev = "SunOffensive2";
		Back = "REPMENU_BURNINGCRUSADE";
	};

		-----------------
		--- Sporeggar ---
		-----------------

	AtlasLoot_Data["Sporeggar1"] = {
		{ 1, 0, "INV_Mushroom_10", "=q6=#r2#", ""};
		{ 2, 27689, "", "=q1=Recipe: Sporeling Snack", "=ds=#p3# (310)", "2 #glowcap#", ""};
		{ 3, 30156, "", "=q1=Recipe: Clam Bar", "=ds=#p3# (300)", "1 #glowcap#", ""};
		{ 4, 25548, "", "=q1=Tallstalk Mushroom", "=ds=#e3#", "1 #glowcap#", ""};
		{ 5, 24539, "", "=q1=Marsh Lichen", "=ds=#e3#", "2 #glowcap#", ""};
		{ 7, 0, "INV_Mushroom_10", "=q6=#r3#", ""};
		{ 8, 25827, "", "=q3=Muck-Covered Drape", "=ds=#s4#", "25 #glowcap#", ""};
		{ 9, 25828, "", "=q3=Petrified Lichen Guard", "=ds=#w8#", "15 #glowcap#", ""};
		{ 10, 25550, "", "=q1=Redcap Toadstool", "=ds=#e3#", "1 #glowcap#", ""};
		{ 12, 24245, "", "=q1=Glowcap", "=ds=#m17#", "", ""};
		{ 16, 0, "INV_Mushroom_10", "=q6=#r4#", ""};
		{ 17, 29150, "", "=q3=Hardened Stone Shard", "=ds=#h1#, #w4#", "45 #glowcap#", ""};
		{ 18, 29149, "", "=q3=Sporeling's Firestick", "=ds=#w12#", "20 #glowcap#", ""};
		{ 19, 22916, "", "=q2=Recipe: Transmute Primal Earth to Water", "=ds=#p1# (350)", "25 #glowcap#", ""};
		{ 20, 38229, "", "=q1=Pattern: Mycah's Botanical Bag", "=ds=#p8# (375)", "25 #glowcap#", ""};
		{ 22, 0, "INV_Mushroom_10", "=q6=#r5#", ""};
		{ 23, 34478, "", "=q3=Tiny Sporebat", "=ds=#e13#", "30 #glowcap#", ""};
		{ 24, 22906, "", "=q2=Recipe: Shrouding Potion", "=ds=#p1# (335)", "30 #glowcap#", ""};
		{ 25, 31775, "", "=q1=Sporeggar Tabard", "=ds=#s7#", "10 #glowcap#", ""};
		Back = "REPMENU_BURNINGCRUSADE";
	};

		-----------------
		--- The Aldor ---
		-----------------

	AtlasLoot_Data["Aldor1"] = {
		{ 1, 0, "Spell_Holy_SealOfSalvation", "=q6=#r2#", ""};
		{ 2, 23149, "", "=q2=Design: Gleaming Golden Draenite", "=ds=#p12# (305)"};
		{ 3, 23601, "", "=q1=Plans: Flamebane Bracers", "=ds=#p2# (350)"};
		{ 4, 30842, "", "=q1=Pattern: Flameheart Bracers", "=ds=#p8# (350)"};
		{ 16, 0, "Spell_Holy_SealOfSalvation", "=q6=#r3#", ""};
		{ 17, 29129, "", "=q3=Anchorite's Robes", "=ds=#a1#, #s5#"};
		{ 18, 28881, "", "=q2=Inscription of Discipline", "=ds=#s3# #e17#"};
		{ 19, 28878, "", "=q2=Inscription of Faith", "=ds=#s3# #e17#"};
		{ 20, 28885, "", "=q2=Inscription of Vengeance", "=ds=#s3# #e17#"};
		{ 21, 28882, "", "=q2=Inscription of Warding", "=ds=#s3# #e17#"};
		{ 22, 23145, "", "=q2=Design: Royal Shadow Draenite", "=ds=#p12# (305)"};
		{ 23, 23603, "", "=q1=Plans: Flamebane Gloves", "=ds=#p2# (360)"};
		{ 24, 29704, "", "=q1=Pattern: Blastguard Belt", "=ds=#p7# (350)"};
		{ 25, 29693, "", "=q1=Pattern: Flamescale Belt", "=ds=#p7# (350)"};
		{ 26, 30843, "", "=q1=Pattern: Flameheart Gloves", "=ds=#p8# (360)"};
		{ 27, 24293, "", "=q1=Pattern: Silver Spellthread", "=ds=#p8# (335)"};
		Next = "Aldor2";
		Back = "REPMENU_BURNINGCRUSADE";
	};

	AtlasLoot_Data["Aldor2"] = {
		{ 1, 0, "Spell_Holy_SealOfSalvation", "=q6=#r4#", ""};
		{ 2, 29127, "", "=q3=Vindicator's Hauberk", "=ds=#s5#, #a4#"};
		{ 3, 29128, "", "=q3=Lightwarden's Band", "=ds=#s13#"};
		{ 4, 29130, "", "=q3=Auchenai Staff", "=ds=#w9#"};
		{ 5, 24177, "", "=q3=Design: Pendant of Shadow's End", "=ds=#p12# (360)"};
		{ 6, 23604, "", "=q1=Plans: Flamebane Breastplate", "=ds=#p2# (365)"};
		{ 7, 29703, "", "=q1=Pattern: Blastguard Boots", "=ds=#p7# (350)"};
		{ 8, 29691, "", "=q1=Pattern: Flamescale Boots", "=ds=#p7# (350)"};
		{ 9, 25721, "", "=q1=Pattern: Vindicator's Armor Kit", "=ds=#p7# (325)"};
		{ 16, 0, "Spell_Holy_SealOfSalvation", "=q6=#r5#", ""};
		{ 17, 29123, "", "=q4=Medallion of the Lightbearer", "=ds=#s2#"};
		{ 18, 29124, "", "=q4=Vindicator's Brand", "=ds=#h1#, #w10#"};
		{ 19, 28886, "", "=q3=Greater Inscription of Discipline", "=ds=#s3# #e17#"};
		{ 20, 28887, "", "=q3=Greater Inscription of Faith", "=ds=#s3# #e17#"};
		{ 21, 28888, "", "=q3=Greater Inscription of Vengeance", "=ds=#s3# #e17#"};
		{ 22, 28889, "", "=q3=Greater Inscription of Warding", "=ds=#s3# #e17#"};
		{ 23, 23602, "", "=q1=Plans: Flamebane Helm", "=ds=#p2# (355)"};
		{ 24, 29702, "", "=q1=Pattern: Blastguard Pants", "=ds=#p7# (350)"};
		{ 25, 29689, "", "=q1=Pattern: Flamescale Leggings", "=ds=#p7# (350)"};
		{ 26, 24295, "", "=q1=Pattern: Golden Spellthread", "=ds=#p8# (375)"};
		{ 27, 30844, "", "=q1=Pattern: Flameheart Vest", "=ds=#p8# (370)"};
		{ 28, 31779, "", "=q1=Aldor Tabard", "=ds=#s7#"};
		Prev = "Aldor1";
		Back = "REPMENU_BURNINGCRUSADE";
	};

		----------------------
		--- The Consortium ---
		----------------------

	AtlasLoot_Data["Consortium1"] = {
		{ 1, 0, "INV_Weapon_Shortblade_31", "=q6=#r2#", ""};
		{ 2, 25732, "", "=q3=Pattern: Fel Leather Gloves", "=ds=#p7# (340)"};
		{ 3, 28274, "", "=q2=Formula: Enchant Cloak - Spell Penetration", "=ds=#p4# (325)"};
		{ 4, 23146, "", "=q2=Design: Shifting Shadow Draenite", "=ds=#p12# (315)"};
		{ 5, 23136, "", "=q2=Design: Luminous Flame Spessarite", "=ds=#p12# (305)"};
		{ 16, 0, "INV_Weapon_Shortblade_31", "=q6=#r3#", ""};
		{ 17, 29457, "", "=q3=Nethershard", "=ds=#h3#, #w4#"};
		{ 18, 29456, "", "=q3=Gift of the Ethereal", "=ds=#h1#, #w10#"};
		{ 19, 29118, "", "=q3=Smuggler's Ammo Pouch", "=ds=#m14# #w20# =q1=#m1# =ds=#c2#"};
		{ 20, 25733, "", "=q3=Pattern: Fel Leather Boots", "=ds=#p7# (350)"};
		{ 21, 23134, "", "=q2=Design: Delicate Blood Garnet", "=ds=#p12# (325)"};
		{ 22, 23155, "", "=q2=Design: Lustrous Azure Moonstone", "=ds=#p12# (325)"};
		{ 23, 23150, "", "=q2=Design: Thick Golden Draenite", "=ds=#p12# (315)"};
		{ 24, 22552, "", "=q1=Formula: Enchant Weapon - Major Striking", "=ds=#p4# (340)"};
		{ 25, 25908, "", "=q1=Design: Swift Skyfire Diamond", "=ds=#p12# (365)"};
		{ 26, 25902, "", "=q1=Design: Powerful Earthstorm Diamond", "=ds=#p12# (365) (#z12#)"};
		{ 27, 24314, "", "=q1=Pattern: Bag of Jewels", "=ds=#p8# (340)"};
		Next = "Consortium2";
		Back = "REPMENU_BURNINGCRUSADE";
	};

	AtlasLoot_Data["Consortium2"] = {
		{ 1, 0, "INV_Weapon_Shortblade_31", "=q6=#r4#", ""};
		{ 2, 29117, "", "=q3=Stormspire Vest", "=ds=#s5#, #a1#"};
		{ 3, 29116, "", "=q3=Nomad's Leggings", "=ds=#s11#, #a2#"};
		{ 4, 29115, "", "=q3=Consortium Blaster", "=ds=#w5#"};
		{ 5, 24178, "", "=q3=Design: Pendant of the Null Rune", "=ds=#p12# (360)"};
		{ 6, 25734, "", "=q3=Pattern: Fel Leather Leggings", "=ds=#p7# (350)"};
		{ 7, 22535, "", "=q1=Formula: Enchant Ring - Striking", "=ds=#p4# (360) (#z12#)"};
		{ 8, 23874, "", "=q1=Schematic: Elemental Seaforium Charge", "=ds=#p5# (350)"};
		{ 9, 25903, "", "=q1=Design: Bracing Earthstorm Diamond", "=ds=#p12# (365) (#z12#)"};
		{ 10, 33156, "", "=q1=Design: Crimson Sun", "=ds=#p12# (360)"};
		{ 11, 33305, "", "=q1=Design: Don Julio's Heart", "=ds=#p12# (360)"};
		{ 16, 0, "INV_Weapon_Shortblade_31", "=q6=#r5#", ""};
		{ 17, 29122, "", "=q4=Nether Runner's Cowl", "=ds=#s1#, #a1#"};
		{ 18, 29119, "", "=q4=Haramad's Bargain", "=ds=#s2#"};
		{ 19, 29121, "", "=q4=Guile of Khoraazi", "=ds=#h1#, #w4#"};
		{ 20, 33622, "", "=q3=Design: Relentless Earthstorm Diamond", "=ds=#p12# (365)"};
		{ 21, 31776, "", "=q1=Consortium Tabard", "=ds=#s7#"};
		Prev = "Consortium1";
		Back = "REPMENU_BURNINGCRUSADE";
	};

		-------------------
		--- The Mag'har ---
		-------------------

	AtlasLoot_Data["Maghar1"] = {
		{ 1, 0, "INV_Misc_Foot_Centaur", "=q6=#r2#", ""};
		{ 2, 25741, "", "=q3=Pattern: Netherfury Belt", "=ds=#p7# (340)"};
		{ 4, 0, "INV_Misc_Foot_Centaur", "=q6=#r3#", ""};
		{ 5, 29143, "", "=q3=Clefthoof Hide Quiver", "=ds=#m14# #w19# =q1=#m1# =ds=#c2#"};
		{ 6, 25742, "", "=q3=Pattern: Netherfury Leggings", "=ds=#p7# (340)"};
		{ 7, 34174, "", "=q1=Pattern: Drums of Restoration", "=ds=#p7# (350)"};
		{ 8, 34172, "", "=q1=Pattern: Drums of Speed", "=ds=#p7# (345)"};
		{ 9, 29664, "", "=q1=Pattern: Reinforced Mining Bag", "=ds=#p7# (325)"};
		{ 11, 0, "INV_Misc_Foot_Centaur", "=q6=#r4#", ""};
		{ 12, 29147, "", "=q3=Talbuk Hide Spaulders", "=ds=#s3#, #a2#"};
		{ 13, 29141, "", "=q3=Tempest Leggings", "=ds=#s11#, #a2#"};
		{ 14, 29145, "", "=q3=Band of Ancestral Spirits", "=ds=#s13#"};
		{ 15, 25743, "", "=q3=Pattern: Netherfury Boots", "=ds=#p7# (350)"};
		{ 16, 22917, "", "=q2=Recipe: Transmute Primal Fire to Earth", "=ds=#p1# (350)"};
		{ 18, 0, "INV_Misc_Foot_Centaur", "=q6=#r5#", ""};
		{ 19, 29102, "", "=q4=Reins of the Cobalt War Talbuk", "=ds=#e12#"};
		{ 20, 29104, "", "=q4=Reins of the Silver War Talbuk", "=ds=#e12#"};
		{ 21, 29105, "", "=q4=Reins of the Tan War Talbuk", "=ds=#e12#"};
		{ 22, 29103, "", "=q4=Reins of the White War Talbuk", "=ds=#e12#"};
		{ 23, 31829, "", "=q4=Reins of the Cobalt Riding Talbuk", "=ds=#e12#"};
		{ 24, 31831, "", "=q4=Reins of the Silver Riding Talbuk", "=ds=#e12#"};
		{ 25, 31833, "", "=q4=Reins of the Tan Riding Talbuk", "=ds=#e12#"};
		{ 26, 31835, "", "=q4=Reins of the White Riding Talbuk", "=ds=#e12#"};
		{ 27, 29139, "", "=q3=Ceremonial Cover", "=ds=#s4#"};
		{ 28, 29135, "", "=q3=Earthcaller's Headdress", "=ds=#s1#, #a3#"};
		{ 29, 29137, "", "=q3=Hellscream's Will", "=ds=#h2#, #w1#"};
		{ 30, 31773, "", "=q1=Mag'har Tabard", "=ds=#s7#"};
		Back = "REPMENU_BURNINGCRUSADE";
	};

		------------------------------
		--- The Scale of the Sands ---
		------------------------------

	AtlasLoot_Data["ScaleSands1"] = {
		{ 1, 29298, "", "=q4=Band of Eternity", "=ds=#s13#, =q1=#r2#"};
		{ 2, 29299, "", "=q4=Band of Eternity", "=ds=#s13#, =q1=#r3#"};
		{ 3, 29300, "", "=q4=Band of Eternity", "=ds=#s13#, =q1=#r4#"};
		{ 4, 29301, "", "=q4=Band of the Eternal Champion", "=ds=#s13#, =q1=#r5#"};
		{ 6, 29294, "", "=q4=Band of Eternity", "=ds=#s13#, =q1=#r2#"};
		{ 7, 29295, "", "=q4=Band of Eternity", "=ds=#s13#, =q1=#r3#"};
		{ 8, 29296, "", "=q4=Band of Eternity", "=ds=#s13#, =q1=#r4#"};
		{ 9, 29297, "", "=q4=Band of the Eternal Defender", "=ds=#s13#, =q1=#r5#"};
		{ 16, 29302, "", "=q4=Band of Eternity", "=ds=#s13#, =q1=#r2#"};
		{ 17, 29303, "", "=q4=Band of Eternity", "=ds=#s13#, =q1=#r3#"};
		{ 18, 29304, "", "=q4=Band of Eternity", "=ds=#s13#, =q1=#r4#"};
		{ 19, 29305, "", "=q4=Band of the Eternal Sage", "=ds=#s13#, =q1=#r5#"};
		{ 21, 29307, "", "=q4=Band of Eternity", "=ds=#s13#, =q1=#r2#"};
		{ 22, 29306, "", "=q4=Band of Eternity", "=ds=#s13#, =q1=#r3#"};
		{ 23, 29308, "", "=q4=Band of Eternity", "=ds=#s13#, =q1=#r4#"};
		{ 24, 29309, "", "=q4=Band of the Eternal Restorer", "=ds=#s13#, =q1=#r5#"};
		Next = "ScaleSands2";
		Back = "REPMENU_BURNINGCRUSADE";
	};

	AtlasLoot_Data["ScaleSands2"] = {
		{ 1, 0, "INV_Misc_MonsterScales_13", "=q6=#r2#", ""};
		{ 2, 32274, "", "=q4=Design: Bold Crimson Spinel", "=ds=#p12# (375)"};
		{ 3, 32283, "", "=q4=Design: Bright Crimson Spinel", "=ds=#p12# (375)"};
		{ 4, 32277, "", "=q4=Design: Delicate Crimson Spinel", "=ds=#p12# (375)"};
		{ 5, 32282, "", "=q4=Design: Runed Crimson Spinel", "=ds=#p12# (375)"};
		{ 6, 32284, "", "=q4=Design: Subtle Crimson Spinel", "=ds=#p12# (375)"};
		{ 7, 32281, "", "=q4=Design: Teardrop Crimson Spinel", "=ds=#p12# (375)"};
		{ 8, 32288, "", "=q4=Design: Lustrous Empyrean Sapphire", "=ds=#p12# (375)"};
		{ 9, 32286, "", "=q4=Design: Solid Empyrean Sapphire", "=ds=#p12# (375)"};
		{ 10, 32287, "", "=q4=Design: Sparkling Empyrean Sapphire", "=ds=#p12# (375)"};
		{ 11, 32290, "", "=q4=Design: Brilliant Lionseye", "=ds=#p12# (375)"};
		{ 12, 32293, "", "=q4=Design: Gleaming Lionseye", "=ds=#p12# (375)"};
		{ 13, 32291, "", "=q4=Design: Smooth Lionseye", "=ds=#p12# (375)"};
		{ 14, 32294, "", "=q4=Design: Thick Lionseye", "=ds=#p12# (375)"};
		{ 16, 0, "INV_Misc_MonsterScales_13", "=q6=#r3#", ""};
		{ 17, 35763, "", "=q4=Design: Quick Lionseye", "=ds=#p12# (375)"};
		{ 18, 32306, "", "=q4=Design: Glinting Pyrestone", "=ds=#p12# (375)"};
		{ 19, 32305, "", "=q4=Design: Luminous Pyrestone", "=ds=#p12# (375)"};
		{ 20, 32304, "", "=q4=Design: Potent Pyrestone", "=ds=#p12# (375)"};
		{ 21, 35762, "", "=q4=Design: Reckless Pyrestone", "=ds=#p12# (375)"};
		{ 22, 32299, "", "=q4=Design: Balanced Shadowsong Amethyst", "=ds=#p12# (375)"};
		{ 23, 32301, "", "=q4=Design: Glowing Shadowsong Amethyst", "=ds=#p12# (375)"};
		{ 24, 32300, "", "=q4=Design: Infused Shadowsong Amethyst", "=ds=#p12# (375)"};
		{ 25, 32311, "", "=q4=Design: Dazzling Seaspray Emerald", "=ds=#p12# (375)"};
		{ 26, 35765, "", "=q4=Design: Forceful Seaspray Emerald", "=ds=#p12# (375)"};
		{ 27, 32312, "", "=q4=Design: Jagged Seaspray Emerald", "=ds=#p12# (375)"};
		{ 28, 32310, "", "=q4=Design: Radiant Seaspray Emerald", "=ds=#p12# (375)"};
		{ 29, 35764, "", "=q4=Design: Steady Seaspray Emerald", "=ds=#p12# (375)"};
		Next = "ScaleSands3";
		Prev = "ScaleSands1";
		Back = "REPMENU_BURNINGCRUSADE";
	};

	AtlasLoot_Data["ScaleSands3"] = {
		{ 1, 0, "INV_Misc_MonsterScales_13", "=q6=#r3#", ""};
		{ 2, 31737, "", "=q4=Timeless Arrow", "=ds=#w17#"};
		{ 3, 31735, "", "=q4=Timeless Shell", "=ds=#w18#"};
		{ 5, 0, "INV_Misc_MonsterScales_13", "=q6=#r4#", ""};
		{ 6, 32292, "", "=q4=Design: Rigid Lionseye", "=ds=#p12# (375)"};
		{ 7, 32308, "", "=q4=Design: Wicked Pyrestone", "=ds=#p12# (375)"};
		{ 8, 32309, "", "=q4=Design: Enduring Seaspray Emerald", "=ds=#p12# (375)"};
		{ 9, 32302, "", "=q4=Design: Royal Shadowsong Amethyst", "=ds=#p12# (375)"};
		Prev = "ScaleSands2";
		Back = "REPMENU_BURNINGCRUSADE";
	};

		-------------------
		--- The Scryers ---
		-------------------

	AtlasLoot_Data["Scryer1"] = {
		{ 1, 0, "Spell_Holy_ChampionsBond", "=q6=#r2#", ""};
		{ 2, 23133, "", "=q2=Design: Runed Blood Garnet", "=ds=#p12# (315)"};
		{ 3, 23597, "", "=q1=Plans: Enchanted Adamantite Belt", "=ds=#p2# (355)"};
		{ 16, 0, "Spell_Holy_ChampionsBond", "=q6=#r3#", ""};
		{ 17, 28907, "", "=q2=Inscription of the Blade", "=ds=#s3# #e17#"};
		{ 18, 28908, "", "=q2=Inscription of the Knight", "=ds=#s3# #e17#"};
		{ 19, 28904, "", "=q2=Inscription of the Oracle", "=ds=#s3# #e17#"};
		{ 20, 28903, "", "=q2=Inscription of the Orb", "=ds=#s3# #e17#"};
		{ 21, 23143, "", "=q2=Design: Dazzling Deep Peridot", "=ds=#p12# (325)"};
		{ 22, 23598, "", "=q1=Plans: Enchanted Adamantite Boots", "=ds=#p2# (355)"};
		{ 23, 29701, "", "=q1=Pattern: Enchanted Clefthoof Boots", "=ds=#p7# (350)"};
		{ 24, 29682, "", "=q1=Pattern: Enchanted Felscale Gloves", "=ds=#p7# (350)"};
		{ 25, 24292, "", "=q1=Pattern: Mystic Spellthread", "=ds=#p8# (335)"};
		Next = "Scryer2";
		Back = "REPMENU_BURNINGCRUSADE";
	};

	AtlasLoot_Data["Scryer2"] = {
		{ 1, 0, "Spell_Holy_ChampionsBond", "=q6=#r4#", ""};
		{ 2, 29131, "", "=q3=Retainer's Leggings", "=ds=#s11#, #a2# "};
		{ 3, 29134, "", "=q3=Gauntlets of the Chosen", "=ds=#s9#, #a4# "};
		{ 4, 29132, "", "=q3=Scryer's Bloodgem", "=ds=#s14#"};
		{ 5, 29133, "", "=q3=Seer's Cane", "=ds=#w9#"};
		{ 6, 24176, "", "=q3=Design: Pendant of Withering", "=ds=#p12# (360)"};
		{ 7, 22908, "", "=q2=Recipe: Elixir of Major Firepower", "=ds=#p1# (345)"};
		{ 8, 23599, "", "=q1=Plans: Enchanted Adamantite Breastplate", "=ds=#p2# (360)"};
		{ 9, 29700, "", "=q1=Pattern: Enchanted Clefthoof Gloves", "=ds=#p7# (350)"};
		{ 10, 29684, "", "=q1=Pattern: Enchanted Felscale Boots", "=ds=#p7# (350)"};
		{ 11, 25722, "", "=q1=Pattern: Magister's Armor Kit", "=ds=#p7# (325)"};
		{ 16, 0, "Spell_Holy_ChampionsBond", "=q6=#r5#", ""};
		{ 17, 29126, "", "=q4=Seer's Signet", "=ds=#s13#"};
		{ 18, 29125, "", "=q4=Retainer's Blade", "=ds=#h1#, #w4#"};
		{ 19, 28910, "", "=q3=Greater Inscription of the Blade", "=ds=#s3# #e17#"};
		{ 20, 28911, "", "=q3=Greater Inscription of the Knight", "=ds=#s3# #e17#"};
		{ 21, 28912, "", "=q3=Greater Inscription of the Oracle", "=ds=#s3# #e17#"};
		{ 22, 28909, "", "=q3=Greater Inscription of the Orb", "=ds=#s3# #e17#"};
		{ 23, 23600, "", "=q1=Plans: Enchanted Adamantite Leggings", "=ds=#p2# (365)"};
		{ 24, 29698, "", "=q1=Pattern: Enchanted Clefthoof Leggings", "=ds=#p7# (350)"};
		{ 25, 29677, "", "=q1=Pattern: Enchanted Felscale Leggings", "=ds=#p7# (350)"};
		{ 26, 24294, "", "=q1=Pattern: Runic Spellthread", "=ds=#p8# (375)"};
		{ 27, 31780, "", "=q1=Scryers Tabard", "=ds=#s7#"};
		Prev = "Scryer1";
		Back = "REPMENU_BURNINGCRUSADE";
	};

		-------------------
		--- The Sha'tar ---
		-------------------

	AtlasLoot_Data["Shatar1"] = {
		{ 1, 0, "Spell_Nature_LightningOverload", "=q6=#r2#", ""};
		{ 2, 25904, "", "=q1=Design: Insightful Earthstorm Diamond", "=ds=#p12# (365)"};
		{ 4, 0, "Spell_Nature_LightningOverload", "=q6=#r4#", ""};
		{ 5, 29180, "", "=q3=Blessed Scale Girdle", "=ds=#s10#, #a3#"};
		{ 6, 29179, "", "=q3=Xi'ri's Gift", "=ds=#s14#"};
		{ 7, 24182, "", "=q3=Design: Talasite Owl", "=ds=#p12# (370)"};
		{ 8, 29191, "", "=q2=Arcanum of Power", "=ds=#s1# #e17#"};
		{ 9, 22915, "", "=q2=Recipe: Transmute Primal Air to Fire", "=ds=#p1# (350)"};
		{ 10, 28281, "", "=q2=Formula: Enchant Weapon - Major Healing", "=ds=#p4# (350)"};
		{ 11, 13517, "", "=q1=Recipe: Alchemist's Stone", "=ds=#p1# (350)"};
		{ 12, 22537, "", "=q1=Formula: Enchant Ring - Healing Power", "=ds=#p4# (370)"};
		{ 13, 33159, "", "=q1=Design: Blood of Amber", "=ds=#p12# (360)"};
		{ 16, 0, "Spell_Nature_LightningOverload", "=q6=#r3#", ""};
		{ 17, 30826, "", "=q3=Design: Ring of Arcane Shielding", "=ds=#p12# (360)"};
		{ 18, 29195, "", "=q2=Arcanum of Arcane Warding", "=ds=#s1# #e17#"};
		{ 19, 28273, "", "=q2=Formula: Enchant Gloves - Major Healing", "=ds=#p4# (350)"};
		{ 20, 33155, "", "=q1=Design: Kailee's Rose", "=ds=#p12# (360)"};
		{ 21, 29717, "", "=q1=Pattern: Drums of Battle", "=ds=#p7# (365)"};
		{ 22, 30634, "", "=q1=Warpforged Key", "=ds=#e9#"};
		{ 24, 0, "Spell_Nature_LightningOverload", "=q6=#r5#", ""};
		{ 25, 29177, "", "=q4=A'dal's Command", "=ds=#s13#"};
		{ 26, 29175, "", "=q4=Gavel of Pure Light", "=ds=#h3#, #w6#"};
		{ 27, 29176, "", "=q4=Crest of the Sha'tar", "=ds=#w8#"};
		{ 28, 33153, "", "=q3=Formula: Enchant Gloves - Threat", "=ds=#p4# (300)"};
		{ 29, 31354, "", "=q2=Recipe: Flask of the Titans", "=ds=#p1# (300)"};
		{ 30, 31781, "", "=q1=Sha'tar Tabard", "=ds=#s7#"};
		Back = "REPMENU_BURNINGCRUSADE";
	};

		----------------------
		--- The Violet Eye ---
		----------------------

	AtlasLoot_Data["VioletEye1"] = {
		{ 1, 0, "INV_Jewelry_Ring_62", "=q6="..AL["Path of the Violet Assassin"], ""};
		{ 2, 29280, "", "=q3=Violet Signet", "=ds=#s13#, =q1=#r2#"};
		{ 3, 29281, "", "=q4=Violet Signet", "=ds=#s13#, =q1=#r3#"};
		{ 4, 29282, "", "=q4=Violet Signet", "=ds=#s13#, =q1=#r4#"};
		{ 5, 29283, "", "=q4=Violet Signet of the Master Assassin", "=ds=#s13#, =q1=#r5#"};
		{ 7, 0, "INV_Jewelry_Ring_62", "=q6="..AL["Path of the Violet Mage"], ""};
		{ 8, 29284, "", "=q3=Violet Signet", "=ds=#s13#, =q1=#r2#"};
		{ 9, 29285, "", "=q4=Violet Signet", "=ds=#s13#, =q1=#r3#"};
		{ 10, 29286, "", "=q4=Violet Signet", "=ds=#s13#, =q1=#r4#"};
		{ 11, 29287, "", "=q4=Violet Signet of the Archmage", "=ds=#s13#, =q1=#r5#"};
		{ 16, 0, "INV_Jewelry_Ring_62", "=q6="..AL["Path of the Violet Restorer"], ""};
		{ 17, 29288, "", "=q3=Violet Signet", "=ds=#s13#, =q1=#r2#"};
		{ 18, 29289, "", "=q4=Violet Signet", "=ds=#s13#, =q1=#r3#"};
		{ 19, 29291, "", "=q4=Violet Signet", "=ds=#s13#, =q1=#r4#"};
		{ 20, 29290, "", "=q4=Violet Signet of the Grand Restorer", "=ds=#s13#, =q1=#r5#"};
		{ 22, 0, "INV_Jewelry_Ring_62", "=q6="..AL["Path of the Violet Protector"], ""};
		{ 23, 29276, "", "=q3=Violet Signet", "=ds=#s13#, =q1=#r2#"};
		{ 24, 29277, "", "=q4=Violet Signet", "=ds=#s13#, =q1=#r3#"};
		{ 25, 29278, "", "=q4=Violet Signet", "=ds=#s13#, =q1=#r4#"};
		{ 26, 29279, "", "=q4=Violet Signet of the Great Protector", "=ds=#s13#, =q1=#r5#"};
		Next = "VioletEye2";
		Back = "REPMENU_BURNINGCRUSADE";
	};

	AtlasLoot_Data["VioletEye2"] = {
		{ 1, 0, "Ability_Warrior_ShieldMastery", "=q6=#r3#", ""};
		{ 2, 31113, "", "=q4=Violet Badge", "=q1=#m4#: =ds=#s14#"};
		{ 3, 31395, "", "=q4=Plans: Iceguard Helm", "=ds=#p2# (375)"};
		{ 4, 31393, "", "=q4=Plans: Iceguard Breastplate", "=ds=#p2# (375)"};
		{ 5, 31401, "", "=q4=Design: The Frozen Eye", "=ds=#p12# (375)"};
		{ 6, 29187, "", "=q2=Inscription of Endurance", "=ds=#s3# #e17#"};
		{ 7, 33209, "", "=q2=Recipe: Flask of Chromatic Wonder", "=ds=#p1# (375)"};
		{ 9, 0, "Ability_Warrior_ShieldMastery", "=q6=#r4#", ""};
		{ 10, 34581, "", "=q4=Mysterious Arrow", "=ds=#w17#"};
		{ 11, 34582, "", "=q4=Mysterious Shell", "=ds=#w18#"};
		{ 12, 31394, "", "=q4=Plans: Iceguard Leggings", "=ds=#p2# (375)"};
		{ 13, 33205, "", "=q4=Pattern: Shadowprowler's Chestguard", "=ds=#p7# (365)"};
		{ 16, 0, "Ability_Warrior_ShieldMastery", "=q6=#r5#", ""};
		{ 17, 33124, "", "=q3=Pattern: Cloak of Darkness", "=ds=#p7# (360)"};
		{ 18, 33165, "", "=q1=Formula: Enchant Weapon - Greater Agility", "=ds=#p4# (350)"};
		Prev = "VioletEye1";
		Back = "REPMENU_BURNINGCRUSADE";
	};

		-----------------
		--- Thrallmar ---
		-----------------

	AtlasLoot_Data["Thrallmar1"] = {
		{ 1, 0, "INV_BannerPVP_01", "=q6=#r2#", ""};
		{ 2, 25738, "", "=q3=Pattern: Felstalker Belt", "=ds=#p7# (350)"};
		{ 3, 31359, "", "=q2=Design: Enduring Deep Peridot", "=ds=#p12# (315)"};
		{ 4, 24000, "", "=q1=Formula: Enchant Bracer - Superior Healing", "=ds=#p4# (325)"};
		{ 5, 24006, "", "=q1=Grunt's Waterskin", "=ds=#e4#"};
		{ 6, 24009, "", "=q1=Dried Fruit Rations", "=ds=#e3#"};
		{ 16, 0, "INV_BannerPVP_01", "=q6=#r3#", ""};
		{ 17, 25824, "", "=q3=Farseer's Band", "=ds=#s13#"};
		{ 18, 25823, "", "=q3=Grunt's Waraxe", "=ds=#h1#, #w1#"};
		{ 19, 25739, "", "=q3=Pattern: Felstalker Bracers", "=ds=#p7# (360)"};
		{ 20, 25740, "", "=q3=Pattern: Felstalker Breastplate", "=ds=#p7# (360)"};
		{ 21, 29197, "", "=q2=Arcanum of Fire Warding", "=ds=#s1# #e17#"};
		{ 22, 29232, "", "=q1=Recipe: Transmute Skyfire Diamond", "=ds=#p1# (350)"};
		{ 23, 24001, "", "=q1=Recipe: Elixir of Major Agility", "=ds=#p1# (330)"};
		{ 24, 31361, "", "=q1=Pattern: Cobrahide Leg Armor", "=ds=#p7# (335)"};
		{ 25, 30637, "", "=q1=Flamewrought Key", "=ds=#e9#"};
		Next = "Thrallmar2";
		Back = "REPMENU_BURNINGCRUSADE";
	};

	AtlasLoot_Data["Thrallmar2"] = {
		{ 1, 0, "INV_BannerPVP_01", "=q6=#r4#", ""};
		{ 2, 29168, "", "=q3=Ancestral Band", "=ds=#s13#"};
		{ 3, 29167, "", "=q3=Blackened Spear", "=ds=#w7#"};
		{ 4, 32882, "", "=q3=Hellfire Shot", "=ds=#w18#"};
		{ 5, 31358, "", "=q3=Design: Dawnstone Crab", "=ds=#p12# (370)"};
		{ 6, 29190, "", "=q2=Arcanum of Renewal", "=ds=#s1# #e17#"};
		{ 7, 24003, "", "=q1=Formula: Enchant Chest - Exceptional Stats", "=ds=#p4# (345)"};
		{ 8, 34201, "", "=q1=Pattern: Netherscale Ammo Pouch", "=ds=#p7# (350)"};
		{ 16, 0, "INV_BannerPVP_01", "=q6=#r5#", ""};
		{ 17, 29155, "", "=q4=Stormcaller", "=ds=#h3#, #w10#"};
		{ 18, 29165, "", "=q4=Warbringer", "=ds=#h1#, #w1#"};
		{ 19, 29152, "", "=q4=Marksman's Bow", "=ds=#w2#"};
		{ 20, 33151, "", "=q3=Formula: Enchant Cloak - Subtlety", "=ds=#p4# (300)"};
		{ 21, 24002, "", "=q1=Plans: Felsteel Shield Spike", "=ds=#p2# (360)"};
		{ 22, 31362, "", "=q1=Pattern: Nethercobra Leg Armor", "=ds=#p7# (365)"};
		{ 23, 24004, "", "=q1=Thrallmar Tabard", "=ds=#s7#"};
		Prev = "Thrallmar1";
		Back = "REPMENU_BURNINGCRUSADE";
	};

		--------------------
		--- Tranquillien ---
		--------------------

	AtlasLoot_Data["Tranquillien1"] = {
		{ 1, 0, "INV_Misc_Bandana_03", "=q6=#r2#", ""};
		{ 2, 22991, "", "=q2=Apprentice Boots", "=ds=#s12#, #a1# "};
		{ 3, 22992, "", "=q2=Bogwalker Boots", "=ds=#s12#, #a2# "};
		{ 4, 22993, "", "=q2=Volunteer's Greaves", "=ds=#s12#, #a3# "};
		{ 5, 28164, "", "=q2=Tranquillien Flamberge", "=ds=#h2#, #w10#"};
		{ 7, 0, "INV_Misc_Bandana_03", "=q6=#r3#", ""};
		{ 8, 28155, "", "=q2=Apothecary's Waistband", "=ds=#s10#, #a1# "};
		{ 9, 28158, "", "=q2=Batskin Belt", "=ds=#s10#, #a2# "};
		{ 10, 28162, "", "=q2=Tranquillien Defender's Girdle", "=ds=#s10#, #a3# "};
		{ 16, 0, "INV_Misc_Bandana_03", "=q6=#r4#", ""};
		{ 17, 22986, "", "=q2=Apothecary's Robe", "=ds=#s5#, #a1# "};
		{ 18, 22987, "", "=q2=Deathstalker's Vest", "=ds=#s5#, #a2# "};
		{ 19, 22985, "", "=q2=Suncrown Hauberk", "=ds=#s5#, #a3# "};
		{ 22, 0, "INV_Misc_Bandana_03", "=q6=#r5#", ""};
		{ 23, 22990, "", "=q3=Tranquillien Champion's Cloak", "=ds=#s4#"};
		Back = "REPMENU_BURNINGCRUSADE";
	};

		------------
		--- Misc ---
		------------

	AtlasLoot_Data["ShattrathFlasks1"] = {
		{ 1, 32898, "", "=q1=Shattrath Flask of Fortification", "=ds=#e2#"};
		{ 2, 32899, "", "=q1=Shattrath Flask of Mighty", "=ds=#e2#"};
		{ 3, 32901, "", "=q1=Shattrath Flask of Relentless", "=ds=#e2#"};
		{ 4, 32900, "", "=q1=Shattrath Flask of Supreme Power", "=ds=#e2#"};
	};

	-----------
	--- PvP ---
	-----------

		---------------------------------------------------------------
		--- World PvP - Hellfire Peninsula: Hellfire Fortifications ---
		---------------------------------------------------------------

	AtlasLoot_Data["Hellfire"] = {
		{ 1, 27833, "", "=q3=Band of the Victor", "=ds=15 #markthrallmarhhold#"};
		{ 2, 27786, "", "=q3=Barbed Deep Peridot", "=ds=10 #markthrallmarhhold#"};
		{ 3, 28360, "", "=q3=Mighty Blood Garnet", "=ds=10 #markthrallmarhhold#"};
		{ 5, 0, "INV_BannerPVP_02", "=q6=#m7#", ""};
		{ 6, 24520, "", "=q1=Honor Hold Favor", "=ds=5 #markhhold#"};
		{ 7, 24579, "", "=q1=Mark of Honor Hold", "=ds=#m18#"};
		{ 16, 27830, "", "=q3=Circlet of the Victor", "=ds=15 #markthrallmarhhold#"};
		{ 17, 27785, "", "=q3=Notched Deep Peridot", "=ds=10 #markthrallmarhhold#"};
		{ 18, 27777, "", "=q3=Stark Blood Garnet", "=ds=10 #markthrallmarhhold#"};
		{ 20, 0, "INV_BannerPVP_01", "=q6=#m6#", ""};
		{ 21, 24522, "", "=q1=Thrallmar Favor", "=ds=5 #markthrallmar#"};
		{ 22, 24581, "", "=q1=Mark of Thrallmar", "=ds=#m19#"};
		Back = "PVPMENU2";
	};

		----------------------------------
		--- World PvP - Nagrand: Halaa ---
		----------------------------------

	AtlasLoot_Data["Nagrand1"] = {
		{ 1, 28915, "", "=q4=Reins of the Dark Riding Talbuk", "=ds=#e12#", "70 #halaabattle# 15 #halaaresearch#", ""};
		{ 2, 27679, "", "=q4=Sublime Mystic Dawnstone", "=ds=#e7#", "100 #halaabattle#", ""};
		{ 3, 27649, "", "=q3=Hierophant's Leggings", "=ds=#a1# #s11#", "40 #halaabattle# 2 #halaaresearch#", ""};
		{ 4, 27648, "", "=q3=Dreamstalker Leggings", "=ds=#a2# #s11#", "40 #halaabattle# 2 #halaaresearch#", ""};
		{ 5, 27650, "", "=q3=Shadowstalker's Leggings", "=ds=#a2# #s11#", "40 #halaabattle# 2 #halaaresearch#", ""};
		{ 6, 27647, "", "=q3=Marksman's Legguards", "=ds=#a3# #s11#", "40 #halaabattle# 2 #halaaresearch#", ""};
		{ 7, 27652, "", "=q3=Stormbreaker's Leggings", "=ds=#a3# #s11#", "40 #halaabattle# 2 #halaaresearch#", ""};
		{ 8, 27654, "", "=q3=Avenger's Legguards", "=ds=#a4# #s11#", "40 #halaabattle# 2 #halaaresearch#", ""};
		{ 9, 27653, "", "=q3=Slayer's Legguards", "=ds=#a4# #s11#", "40 #halaabattle# 2 #halaaresearch#", ""};
		{ 11, 24208, "", "=q3=Design: Mystic Dawnstone", "=ds=#p12# (350)"};
		{ 14, 26045, "", "=q2=Halaa Battle Token", "=ds=#m17#"};
		{ 16, 29228, "", "=q4=Reins of the Dark War Talbuk", "=ds=#e12#", "100 #halaabattle# 20 #halaaresearch#", ""};
		{ 17, 27680, "", "=q3=Halaani Bag", "=ds=#m14# #e1#", "8 #halaaresearch#", ""};
		{ 18, 27638, "", "=q3=Hierophant's Sash", "=ds=#a1# #s10#", "20 #halaabattle# 1 #halaaresearch#", ""};
		{ 19, 27645, "", "=q3=Dreamstalker Sash", "=ds=#a2# #s10#", "20 #halaabattle# 1 #halaaresearch#", ""};
		{ 20, 27637, "", "=q3=Shadowstalker's Sash", "=ds=#a2# #s10#", "20 #halaabattle# 1 #halaaresearch#", ""};
		{ 21, 27646, "", "=q3=Marksman's Belt", "=ds=#a3# #s10#", "20 #halaabattle# 1 #halaaresearch#", ""};
		{ 22, 27643, "", "=q3=Stormbreaker's Girdle", "=ds=#a3# #s10#", "20 #halaabattle# 1 #halaaresearch#", ""};
		{ 23, 27644, "", "=q3=Avenger's Waistguard", "=ds=#a4# #s10#", "20 #halaabattle# 1 #halaaresearch#", ""};
		{ 24, 27639, "", "=q3=Slayer's Waistguard", "=ds=#a4# #s10#", "20 #halaabattle# 1 #halaaresearch#", ""};
		{ 26, 33783, "", "=q3=Design: Steady Talasite", "=ds=#p12# (350)", "4 #halaaresearch#", ""};
		{ 27, 32071, "", "=q1=Recipe: Elixir of Ironskin", "=ds=#p1# (330)", "2 #halaaresearch#", ""};
		{ 29, 26044, "", "=q2=Halaa Research Token", "=ds=#m17#"};
		Next = "Nagrand2";
		Back = "PVPMENU2";
	};

	AtlasLoot_Data["Nagrand2"] = {
		{ 1, 30611, "", "=q3=Halaani Razorshaft", "=ds=#w17#"};
		{ 2, 30615, "", "=q1=Halaani Whiskey", "=ds=#e4#"};
		{ 4, 0, "INV_BannerPVP_02", "=q6=#m7#", ""};
		{ 5, 30598, "", "=q3=Don Amancio's Heart", "=ds=#e7#"};
		{ 6, 30597, "", "=q2=Halaani Claymore", "=ds=#h2#, #w10#"};
		{ 7, 30599, "", "=q2=Avenging Blades", "=ds=#w11#"};
		{ 16, 30612, "", "=q3=Halaani Grimshot", "=ds=#w18#"};
		{ 19, 0, "INV_BannerPVP_01", "=q6=#m6#", ""};
		{ 20, 30571, "", "=q3=Don Rodrigo's Heart", "=ds=#e7#"};
		{ 21, 30570, "", "=q2=Arkadian Claymore", "=ds=#h2#, #w10#"};
		{ 22, 30568, "", "=q2=The Sharp Cookie", "=ds=#w11#"};
		Prev = "Nagrand1";
		Back = "PVPMENU2";
	};

		------------------------------------------------
		--- World PvP - Terokkar Forest: Bone Wastes ---
		------------------------------------------------

	AtlasLoot_Data["Terokkar"] = {
		{ 1, 28553, "", "=q4=Band of the Exorcist", "=ds=#s13#", "50 #spiritshard#", ""};
		{ 2, 28557, "", "=q3=Swift Starfire Diamond", "=ds=#e7#", "8 #spiritshard#", ""};
		{ 3, 28759, "", "=q3=Exorcist's Dreadweave Hood", "=ds=#a1# #s1#", "18 #spiritshard#", ""};
		{ 4, 28574, "", "=q3=Exorcist's Dragonhide Helm", "=ds=#a2# #s1#", "18 #spiritshard#", ""};
		{ 5, 28575, "", "=q3=Exorcist's Wyrmhide Helm", "=ds=#a2# #s1#", "18 #spiritshard#", ""};
		{ 6, 28577, "", "=q3=Exorcist's Linked Helm", "=ds=#a3# #s1#", "18 #spiritshard#", ""};
		{ 7, 28560, "", "=q3=Exorcist's Lamellar Helm", "=ds=#a4# #s1#", "18 #spiritshard#", ""};
		{ 8, 28761, "", "=q3=Exorcist's Scaled Helm", "=ds=#a4# #s1#", "18 #spiritshard#", ""};
		{ 10, 32947, "", "=q1=Auchenai Healing Potion", "=ds=#e2#", "2 #spiritshard#", ""};
		{ 12, 28558, "", "=q1=Spirit Shard", "=ds=#m17#"};
		{ 16, 28555, "", "=q4=Seal of the Exorcist", "=ds=#s13#", "50 #spiritshard#", ""};
		{ 17, 28556, "", "=q3=Swift Windfire Diamond", "=ds=#e7#", "8 #spiritshard#", ""};
		{ 18, 28760, "", "=q3=Exorcist's Silk Hood", "=ds=#a1# #s1#", "18 #spiritshard#", ""};
		{ 19, 28561, "", "=q3=Exorcist's Leather Helm", "=ds=#a2# #s1#", "18 #spiritshard#", ""};
		{ 20, 28576, "", "=q3=Exorcist's Chain Helm", "=ds=#a3# #s1#", "18 #spiritshard#", ""};
		{ 21, 28758, "", "=q3=Exorcist's Mail Helm", "=ds=#a3# #s1#", "18 #spiritshard#", ""};
		{ 22, 28559, "", "=q3=Exorcist's Plate Helm", "=ds=#a4# #s1#", "18 #spiritshard#", ""};
		{ 25, 32948, "", "=q1=Auchenai Mana Potion", "=ds=#e2#", "2 #spiritshard#", ""};
		Back = "PVPMENU2";
	};

		-------------------------------------------------
		--- World PvP - Zangarmarsh: Twin Spire Ruins ---
		-------------------------------------------------

	AtlasLoot_Data["Zangarmarsh"] = {
		{ 1, 27990, "", "=q3=Idol of Savagery", "=ds=#w14#", "15 #markthrallmarhhold#", ""};
		{ 2, 27984, "", "=q3=Totem of Impact", "=ds=#w15#", "15 #markthrallmarhhold#", ""};
		{ 3, 27922, "", "=q3=Mark of Defiance", "=ds=#s14#", "30 #markthrallmarhhold#", ""};
		{ 4, 27929, "", "=q3=Terminal Edge", "=ds=#w11#", "15 #markthrallmarhhold#", ""};
		{ 5, 27939, "", "=q3=Incendic Rod", "=ds=#w12#", "15 #markthrallmarhhold#", ""};
		{ 7, 24579, "", "=q1=Mark of Honor Hold", "=ds=#m18#"};
		{ 16, 27983, "", "=q3=Libram of Zeal", "=ds=#w16#", "15 #markthrallmarhhold#", ""};
		{ 17, 27920, "", "=q3=Mark of Conquest", "=ds=#s14#", "30 #markthrallmarhhold#", ""};
		{ 18, 27927, "", "=q3=Mark of Vindication", "=ds=#s14#", "30 #markthrallmarhhold#", ""};
		{ 19, 27930, "", "=q3=Splintermark", "=ds=#w2#", "15 #markthrallmarhhold#", ""};
		{ 22, 24581, "", "=q1=Mark of Thrallmar", "=ds=#m19#"};
		Back = "PVPMENU2";
	};

		-------------------------------------
		--- Rep-PvP Level 70 - Armor Sets ---
		-------------------------------------
		
	AtlasLoot_Data["PVP70RepCloth"] = {
		{ 1, 0, "INV_BannerPVP_02", "=q6=#pvprep705_1#", "=ec1=#c5#"};
		{ 2, 35339, "", "=q3=Satin Hood", "=ds=#s1#, #a1#"};
		{ 3, 35341, "", "=q3=Satin Mantle", "=ds=#f2#, =ec1=#r3#"};
		{ 4, 35342, "", "=q3=Satin Robe", "=ds=#f6#, =ec1=#r3#"};
		{ 5, 35338, "", "=q3=Satin Gloves", "=ds=#f5#, =ec1=#r3#"};
		{ 6, 35340, "", "=q3=Satin Leggings", "=ds=#f1#, =ec1=#r3#"};
		{ 8, 0, "INV_BannerPVP_02", "=q6=#pvprep705_2#", "=ec1=#c5#"};
		{ 9, 35333, "", "=q3=Mooncloth Cowl", "=ds=#f2#, =ec1=#r3#"};
		{ 10, 35336, "", "=q3=Mooncloth Shoulderpads", "=ds=#f6#, =ec1=#r3#"};
		{ 11, 35337, "", "=q3=Mooncloth Vestments", "=ds=#s5#, #a1#"};
		{ 12, 35335, "", "=q3=Mooncloth Mitts", "=ds=#f1#, =ec1=#r3#"};
		{ 13, 35334, "", "=q3=Mooncloth Legguards", "=ds=#f5#, =ec1=#r3#"};
		{ 16, 0, "INV_BannerPVP_02", "=q6=#pvprep703#", "=ec1=#c3#"};
		{ 17, 35344, "", "=q3=Evoker's Silk Cowl", "=ds=#f1#, =ec1=#r3#"};
		{ 18, 35343, "", "=q3=Evoker's Silk Amice", "=ds=#s4#, #a1#"};
		{ 19, 35346, "", "=q3=Evoker's Silk Raiment", "=ds=#f5#, =ec1=#r3#"};
		{ 20, 35345, "", "=q3=Evoker's Silk Handguards", "=ds=#f2#, =ec1=#r3#"};
		{ 21, 35347, "", "=q3=Evoker's Silk Trousers", "=ds=#f6#, =ec1=#r3#"};
		{ 23, 0, "INV_BannerPVP_02", "=q6=#pvprep708#", "=ec1=#c8#"};
		{ 24, 35329, "", "=q3=Dreadweave Hood", "=ds=#f6#, =ec1=#r3#"};
		{ 25, 35331, "", "=q3=Dreadweave Mantle", "=ds=#f1#, =ec1=#r3#"};
		{ 26, 35332, "", "=q3=Dreadweave Robe", "=ds=#s5#, #a1#"};
		{ 27, 35328, "", "=q3=Dreadweave Gloves", "=ds=#f5#, =ec1=#r3#"};
		{ 28, 35330, "", "=q3=Dreadweave Leggings", "=ds=#f2#, =ec1=#r3#"};
		Next = "PVP70RepLeather";
		Back = "PVP70RepSET";
	};

	AtlasLoot_Data["PVP70RepLeather"] = {
		{ 1, 0, "INV_BannerPVP_02", "=q6=#pvprep701_1#", "=ec1=#c1#"};
		{ 2, 35357, "", "=q3=Dragonhide Helm", "=ds=#f1#, =ec1=#r3#"};
		{ 3, 35359, "", "=q3=Dragonhide Spaulders", "=ds=#f2#, =ec1=#r3#"};
		{ 4, 35360, "", "=q3=Dragonhide Robe", "=ds=#s5#, #a2#"};
		{ 5, 35356, "", "=q3=Dragonhide Gloves", "=ds=#f5#, =ec1=#r3#"};
		{ 6, 35358, "", "=q3=Dragonhide Legguards", "=ds=#f6#, =ec1=#r3#"};
		{ 8, 0, "INV_BannerPVP_02", "=q6=#pvprep701_2#", "=ec1=#c1#"};
		{ 9, 35372, "", "=q3=Wyrmhide Helm", "=ds=#f5#, =ec1=#r3#"};
		{ 10, 35374, "", "=q3=Wyrmhide Spaulders", "=ds=#f6#, =ec1=#r3#"};
		{ 11, 35375, "", "=q3=Wyrmhide Robe", "=ds=#f2#, =ec1=#r3#"};
		{ 12, 35371, "", "=q3=Wyrmhide Gloves", "=ds=#s9#, #a2#"};
		{ 13, 35373, "", "=q3=Wyrmhide Legguards", "=ds=#f1#, =ec1=#r3#"};
		{ 16, 0, "INV_BannerPVP_02", "=q6=#pvprep701_3#", "=ec1=#c1#"};
		{ 17, 35362, "", "=q3=Kodohide Helm", "=ds=#f2#, =ec1=#r3#"};
		{ 18, 35364, "", "=q3=Kodohide Spaulders", "=ds=#s4#, #a2#"};
		{ 19, 35365, "", "=q3=Kodohide Robe", "=ds=#f6#, =ec1=#r3#"};
		{ 20, 35361, "", "=q3=Kodohide Gloves", "=ds=#f1#, =ec1=#r3#"};
		{ 21, 35363, "", "=q3=Kodohide Legguards", "=ds=#f5#, =ec1=#r3#"};
		{ 23, 0, "INV_BannerPVP_02", "=q6=#pvprep706#", "=ec1=#c6#"};
		{ 24, 35367, "", "=q3=Opportunist's Leather Helm", "=ds=#f6#, =ec1=#r3#"};
		{ 25, 35369, "", "=q3=Opportunist's Leather Spaulders", "=ds=#f5#, =ec1=#r3#"};
		{ 26, 35370, "", "=q3=Opportunist's Leather Tunic", "=ds=#f1#, =ec1=#r3#"};
		{ 27, 35366, "", "=q3=Opportunist's Leather Gloves", "=ds=#s9#, #a2#"};
		{ 28, 35368, "", "=q3=Opportunist's Leather Legguards", "=ds=#f2#, =ec1=#r3#"};
		Prev = "PVP70RepCloth";
		Next = "PVP70RepMail";
		Back = "PVP70RepSET";
	};

	AtlasLoot_Data["PVP70RepMail"] = {
		{ 1, 0, "INV_BannerPVP_02", "=q6=#pvprep707_1#", "=ec1=#c7#"};
		{ 2, 35383, "", "=q3=Seer's Linked Helm", "=ds=#s1#, #a3#"};
		{ 3, 35385, "", "=q3=Seer's Linked Spaulders", "=ds=#f6#, =ec1=#r3#"};
		{ 4, 35381, "", "=q3=Seer's Linked Armor", "=ds=#f2#, =ec1=#r3#"};
		{ 5, 35382, "", "=q3=Seer's Linked Gauntlets", "=ds=#f1#, =ec1=#r3#"};
		{ 6, 35384, "", "=q3=Seer's Linked Leggings", "=ds=#f5#, =ec1=#r3#"};
		{ 8, 0, "INV_BannerPVP_02", "=q6=#pvprep707_2#", "=ec1=#c7#"};
		{ 9, 35388, "", "=q3=Seer's Mail Helm", "=ds=#f2#, =ec1=#r3#"};
		{ 10, 35390, "", "=q3=Seer's Mail Spaulders", "=ds=#f5#, =ec1=#r3#"};
		{ 11, 35386, "", "=q3=Seer's Mail Armor", "=ds=#s5#, #a3#"};
		{ 12, 35387, "", "=q3=Seer's Mail Gauntlets", "=ds=#f6#, =ec1=#r3#"};
		{ 13, 35389, "", "=q3=Seer's Mail Leggings", "=ds=#f1#, =ec1=#r3#"};
		{ 16, 0, "INV_BannerPVP_02", "=q6=#pvprep707_3#", "=ec1=#c7#"};
		{ 17, 35393, "", "=q3=Seer's Ringmail Headpiece", "=ds=#f5#, =ec1=#r3#"};
		{ 18, 35395, "", "=q3=Seer's Ringmail Shoulderpads", "=ds=#f2#, =ec1=#r3#"};
		{ 19, 35391, "", "=q3=Seer's Ringmail Chestguard", "=ds=#f1#, =ec1=#r3#"};
		{ 20, 35392, "", "=q3=Seer's Ringmail Gloves", "=ds=#s9#, #a3#"};
		{ 21, 35394, "", "=q3=Seer's Ringmail Legguards", "=ds=#f6#, =ec1=#r3#"};
		{ 23, 0, "INV_BannerPVP_02", "=q6=#pvprep702#", "=ec1=#c2#"};
		{ 24, 35378, "", "=q3=Stalker's Chain Helm", "=ds=#f1#, =ec1=#r3#"};
		{ 25, 35380, "", "=q3=Stalker's Chain Spaulders", "=ds=#f2#, =ec1=#r3#"};
		{ 26, 35376, "", "=q3=Stalker's Chain Armor", "=ds=#f5#, =ec1=#r3#"};
		{ 27, 35377, "", "=q3=Stalker's Chain Gauntlets", "=ds=#s9#, #a3#"};
		{ 28, 35379, "", "=q3=Stalker's Chain Leggings", "=ds=#f6#, =ec1=#r3#"};
		Prev = "PVP70RepLeather";
		Next = "PVP70RepPlate";
		Back = "PVP70RepSET";
	};

	AtlasLoot_Data["PVP70RepPlate"] = {
		{ 1, 0, "INV_BannerPVP_02", "=q6=#pvprep704_1#", "=ec1=#c4#"};
		{ 2, 35414, "", "=q3=Crusader's Scaled Helm", "=ds=#f5#, =ec1=#r3#"};
		{ 3, 35416, "", "=q3=Crusader's Scaled Shoulders", "=ds=#f2#, =ec1=#r3#"};
		{ 4, 35412, "", "=q3=Crusader's Scaled Chestpiece", "=ds=#f1#, =ec1=#r3#"};
		{ 5, 35413, "", "=q3=Crusader's Scaled Gauntlets", "=ds=#s5#, #a4#"};
		{ 6, 35415, "", "=q3=Crusader's Scaled Legguards", "=ds=#f6#, =ec1=#r3#"};
		{ 8, 0, "INV_BannerPVP_02", "=q6=#pvprep704_2#", "=ec1=#c4#"};
		{ 9, 35404, "", "=q3=Crusader's Ornamented Headguard", "=ds=#f2#, =ec1=#r3#"};
		{ 10, 35406, "", "=q3=Crusader's Ornamented Spaulders", "=ds=#s4#, #a4#"};
		{ 11, 35402, "", "=q3=Crusader's Ornamented Chestplate", "=ds=#f5#, =ec1=#r3#"};
		{ 12, 35403, "", "=q3=Crusader's Ornamented Gloves", "=ds=#f6#, =ec1=#r3#"};
		{ 13, 35405, "", "=q3=Crusader's Ornamented Leggings", "=ds=#f1#, =ec1=#r3#"};
		{ 16, 0, "INV_BannerPVP_02", "=q6=#pvprep709#", "=ec1=#c9#"};
		{ 17, 35409, "", "=q3=Savage Plate Helm", "=ds=#s1#, #a4#"};
		{ 18, 35411, "", "=q3=Savage Plate Shoulders", "=ds=#f1#, =ec1=#r3#"};
		{ 19, 35407, "", "=q3=Savage Plate Chestpiece", "=ds=#f2#, =ec1=#r3#"};
		{ 20, 35408, "", "=q3=Savage Plate Gauntlets", "=ds=#f6#, =ec1=#r3#"};
		{ 21, 35410, "", "=q3=Savage Plate Legguards", "=ds=#f5#, =ec1=#r3#"};
		Prev = "PVP70RepMail";
		Back = "PVP70RepSET";
	};

		----------------------------------
		--- PvP Level 70 - Accessories ---
		----------------------------------
		
	AtlasLoot_Data["PvP70Accessories1_A"] = {
		{ 1, 28235, "", "=q3=Medallion of the Alliance", "=ds=", "8000 #alliance#"};
		{ 2, 28237, "", "=q3=Medallion of the Alliance", "=ds=", "8000 #alliance#"};
		{ 3, 28238, "", "=q3=Medallion of the Alliance", "=ds=", "8000 #alliance#"};
		{ 4, 28236, "", "=q3=Medallion of the Alliance", "=ds=", "8000 #alliance#"};
		{ 5, 30349, "", "=q3=Medallion of the Alliance", "=ds=", "8000 #alliance#"};
		{ 6, 28234, "", "=q3=Medallion of the Alliance", "=ds=", "8000 #alliance#"};
		{ 7, 30351, "", "=q3=Medallion of the Alliance", "=ds=", "8000 #alliance#"};
		{ 8, 30348, "", "=q3=Medallion of the Alliance", "=ds=", "8000 #alliance#"};
		{ 9, 30350, "", "=q3=Medallion of the Alliance", "=ds=", "8000 #alliance#"};
		{ 11, 31853, "", "=q1=Major Combat Healing Potion", "=ds=", "200 #faction#"};
		{ 12, 31839, "", "=q1=Major Combat Healing Potion", "=ds=", "200 #faction#"};
		{ 13, 31855, "", "=q1=Major Combat Mana Potion", "=ds=", "200 #faction#"};
		{ 14, 31841, "", "=q1=Major Combat Mana Potion", "=ds=", "200 #faction#"};
		{ 15, 32453, "", "=q1=Star's Tears", "=ds=", "1 #gold# 8 #faction#"};
		{ 16, 37864, "", "=q4=Medallion of the Alliance", "=ds=", "40000 #alliance#"};
		{ 17, 25829, "", "=q4=Talisman of the Alliance", "=ds=", "23000 #alliance#"};
		{ 19, 28120, "", "=q4=Gleaming Ornate Dawnstone", "=ds=", "6885 #faction#"};
		{ 20, 28119, "", "=q4=Smooth Ornate Dawnstone", "=ds=", "6885 #faction#"};
		{ 21, 28362, "", "=q4=Bold Ornate Ruby", "=ds=", "6885 #faction#"};
		{ 22, 28118, "", "=q4=Runed Ornate Ruby", "=ds=", "6885 #faction#"};
		{ 23, 28363, "", "=q4=Inscribed Ornate Topaz", "=ds=", "8500 #faction#"};
		{ 24, 28123, "", "=q4=Potent Ornate Topaz", "=ds=", "8500 #faction#"};
		{ 26, 31838, "", "=q1=Major Combat Healing Potion", "=ds=", "200 #faction#"};
		{ 27, 31852, "", "=q1=Major Combat Healing Potion", "=ds=", "200 #faction#"};
		{ 28, 31840, "", "=q1=Major Combat Mana Potion", "=ds=", "200 #faction#"};
		{ 29, 31854, "", "=q1=Major Combat Mana Potion", "=ds=", "200 #faction#"};
		Next = "PvP70Accessories2";
		Back = "PVPMENU";
	};

	AtlasLoot_Data["PvP70Accessories1_H"] = {
		{ 1, 28241, "", "=q3=Medallion of the Horde", "=ds=", "8000 #horde#"};
		{ 2, 28243, "", "=q3=Medallion of the Horde", "=ds=", "8000 #horde#"};
		{ 3, 28239, "", "=q3=Medallion of the Horde", "=ds=", "8000 #horde#"};
		{ 4, 28242, "", "=q3=Medallion of the Horde", "=ds=", "8000 #horde#"};
		{ 5, 30346, "", "=q3=Medallion of the Horde", "=ds=", "8000 #horde#"};
		{ 6, 28240, "", "=q3=Medallion of the Horde", "=ds=", "8000 #horde#"};
		{ 7, 30345, "", "=q3=Medallion of the Horde", "=ds=", "8000 #horde#"};
		{ 8, 30343, "", "=q3=Medallion of the Horde", "=ds=", "8000 #horde#"};
		{ 9, 30344, "", "=q3=Medallion of the Horde", "=ds=", "8000 #horde#"};
		{ 11, 31853, "", "=q1=Major Combat Healing Potion", "=ds=", "200 #faction#"};
		{ 12, 31839, "", "=q1=Major Combat Healing Potion", "=ds=", "200 #faction#"};
		{ 13, 31855, "", "=q1=Major Combat Mana Potion", "=ds=", "200 #faction#"};
		{ 14, 31841, "", "=q1=Major Combat Mana Potion", "=ds=", "200 #faction#"};
		{ 15, 32453, "", "=q1=Star's Tears", "=ds=", "1 #gold# 8 #faction#"};
		{ 16, 37865, "", "=q4=Medallion of the Horde", "=ds=", "40000 #horde#"};
		{ 17, 24551, "", "=q4=Talisman of the Horde", "=ds=", "23000 #horde#"};
		{ 19, 28120, "", "=q4=Gleaming Ornate Dawnstone", "=ds=", "6885 #faction#"};
		{ 20, 28119, "", "=q4=Smooth Ornate Dawnstone", "=ds=", "6885 #faction#"};
		{ 21, 28362, "", "=q4=Bold Ornate Ruby", "=ds=", "6885 #faction#"};
		{ 22, 28118, "", "=q4=Runed Ornate Ruby", "=ds=", "6885 #faction#"};
		{ 23, 28363, "", "=q4=Inscribed Ornate Topaz", "=ds=", "8500 #faction#"};
		{ 24, 28123, "", "=q4=Potent Ornate Topaz", "=ds=", "8500 #faction#"};
		{ 26, 31838, "", "=q1=Major Combat Healing Potion", "=ds=", "200 #faction#"};
		{ 27, 31852, "", "=q1=Major Combat Healing Potion", "=ds=", "200 #faction#"};
		{ 28, 31840, "", "=q1=Major Combat Mana Potion", "=ds=", "200 #faction#"};
		{ 29, 31854, "", "=q1=Major Combat Mana Potion", "=ds=", "200 #faction#"};
		Next = "PvP70Accessories2";
		Back = "PVPMENU";
	};
	
	AtlasLoot_Data["PvP70Accessories2"] = {
		{ 1, 28378, "", "=q4=Sergeant's Heavy Cape", "=ds=", "8000 #faction#"};
		{ 2, 28377, "", "=q4=Sergeant's Heavy Cloak", "=ds=", "8000 #faction#"};
		{ 4, 44431, "", "=q4=Cloak of Certain Reprieve", "=ds=", "21000 #faction#"};
		{ 5, 41591, "", "=q4=Sergeant's Reinforced Cape", "=ds=", "21000 #faction#"};
		{ 6, 41592, "", "=q4=The Gladiator's Resolution", "=ds=", "21000 #faction#"};
		{ 7, 44429, "", "=q4=Volanthius Shroud", "=ds=", "21000 #faction#"};
		{ 9, 41588, "", "=q4=Battlemaster's Aggression", "=ds=", "36000 #faction#"};
		{ 10, 41587, "", "=q4=Battlemaster's Celerity", "=ds=", "36000 #faction#"};
		{ 11, 41590, "", "=q4=Battlemaster's Courage", "=ds=", "36000 #faction#"};
		{ 12, 41589, "", "=q4=Battlemaster's Resolve", "=ds=", "36000 #faction#"};
		{ 14, 28247, "", "=q3=Band of Dominance", "=ds=", "10000 #alliance#"};
		{ 15, 28246, "", "=q3=Band of Triumph", "=ds=", "10000 #alliance#"};
		{ 16, 35132, "", "=q4=Guardian's Pendant of Conquest", "=ds=", "16000 #faction#"};
		{ 17, 35133, "", "=q4=Guardian's Pendant of Dominance", "=ds=", "16000 #faction#"};
		{ 18, 37929, "", "=q4=Guardian's Pendant of Reprieve", "=ds=", "16000 #faction#"};
		{ 19, 35134, "", "=q4=Guardian's Pendant of Salvation", "=ds=", "16000 #faction#"};
		{ 20, 37928, "", "=q4=Guardian's Pendant of Subjugation", "=ds=", "16000 #faction#"};
		{ 21, 35135, "", "=q4=Guardian's Pendant of Triumph", "=ds=", "16000 #faction#"};
		{ 23, 35129, "", "=q4=Guardian's Band of Dominance", "=ds=", "16000 #faction#"};
		{ 24, 35130, "", "=q4=Guardian's Band of Salvation", "=ds=", "16000 #faction#"};
		{ 25, 37927, "", "=q4=Guardian's Band of Subjugation", "=ds=", "16000 #faction#"};
		{ 26, 35131, "", "=q4=Guardian's Band of Triumph", "=ds=", "16000 #faction#"};
		{ 27, 33853, "", "=q4=Vindicator's Band of Dominance", "=ds=", "12000 #faction#"};
		{ 28, 33918, "", "=q4=Vindicator's Band of Salvation", "=ds=", "12000 #faction#"};
		{ 29, 35320, "", "=q4=Vindicator's Band of Subjugation", "=ds=", "12000 #faction#"};
		{ 30, 33919, "", "=q4=Vindicator's Band of Triumph", "=ds=", "12000 #faction#"};
		Prev = "PvP70Accessories1_A";
		Back = "PVPMENU";
	};

		------------------------------------
		--- PvP Level 70 - Non Set Epics ---
		------------------------------------

	AtlasLoot_Data["PvP70NonSet1"] = {
		{ 1, 35168, "", "=q4=Guardian's Dreadweave Cuffs", "=ds=", "13000 #faction#"};
		{ 2, 35153, "", "=q4=Guardian's Dreadweave Belt", "=ds=", "18000 #faction#"};
		{ 3, 35138, "", "=q4=Guardian's Dreadweave Stalkers", "=ds=", "18000 #faction#"};
		{ 5, 35174, "", "=q4=Guardian's Mooncloth Cuffs", "=ds=", "13000 #faction#"};
		{ 6, 35159, "", "=q4=Guardian's Mooncloth Belt", "=ds=", "18000 #faction#"};
		{ 7, 35144, "", "=q4=Guardian's Mooncloth Slippers", "=ds=", "18000 #faction#"};
		{ 9, 35179, "", "=q4=Guardian's Silk Cuffs", "=ds=", "13000 #faction#"};
		{ 10, 35164, "", "=q4=Guardian's Silk Belt", "=ds=", "18000 #faction#"};
		{ 11, 35149, "", "=q4=Guardian's Silk Footguards", "=ds=", "18000 #faction#"};
		{ 16, 35167, "", "=q4=Guardian's Dragonhide Bracers", "=ds=", "13000 #faction#"};
		{ 17, 35152, "", "=q4=Guardian's Dragonhide Belt", "=ds=", "18000 #faction#"};
		{ 18, 35137, "", "=q4=Guardian's Dragonhide Boots", "=ds=", "18000 #faction#"};
		{ 20, 35169, "", "=q4=Guardian's Kodohide Bracers", "=ds=", "13000 #faction#"};
		{ 21, 35154, "", "=q4=Guardian's Kodohide Belt", "=ds=", "18000 #faction#"};
		{ 22, 35139, "", "=q4=Guardian's Kodohide Boots", "=ds=", "18000 #faction#"};
		{ 24, 35171, "", "=q4=Guardian's Leather Bracers", "=ds=", "13000 #faction#"};
		{ 25, 35156, "", "=q4=Guardian's Leather Belt", "=ds=", "18000 #faction#"};
		{ 26, 35141, "", "=q4=Guardian's Leather Boots", "=ds=", "18000 #faction#"};
		{ 28, 35180, "", "=q4=Guardian's Wyrmhide Bracers", "=ds=", "13000 #faction#"};
		{ 29, 35165, "", "=q4=Guardian's Wyrmhide Belt", "=ds=", "18000 #faction#"};
		{ 30, 35150, "", "=q4=Guardian's Wyrmhide Boots", "=ds=", "18000 #faction#"};
		Next = "PvP70NonSet2";
		Back = "PVPMENU";
	};

	AtlasLoot_Data["PvP70NonSet2"] = {
		{ 1, 35166, "", "=q4=Guardian's Chain Bracers", "=ds=", "13000 #faction#"};
		{ 2, 35151, "", "=q4=Guardian's Chain Girdle", "=ds=", "18000 #faction#"};
		{ 3, 35136, "", "=q4=Guardian's Chain Sabatons", "=ds=", "18000 #faction#"};
		{ 5, 35172, "", "=q4=Guardian's Linked Bracers", "=ds=", "13000 #faction#"};
		{ 6, 35157, "", "=q4=Guardian's Linked Girdle", "=ds=", "18000 #faction#"};
		{ 7, 35142, "", "=q4=Guardian's Linked Sabatons", "=ds=", "18000 #faction#"};
		{ 9, 35173, "", "=q4=Guardian's Mail Bracers", "=ds=", "13000 #faction#"};
		{ 10, 35158, "", "=q4=Guardian's Mail Girdle", "=ds=", "18000 #faction#"};
		{ 11, 35143, "", "=q4=Guardian's Mail Sabatons", "=ds=", "18000 #faction#"};
		{ 13, 35177, "", "=q4=Guardian's Ringmail Bracers", "=ds=", "13000 #faction#"};
		{ 14, 35162, "", "=q4=Guardian's Ringmail Girdle", "=ds=", "18000 #faction#"};
		{ 15, 35147, "", "=q4=Guardian's Ringmail Sabatons", "=ds=", "18000 #faction#"};
		{ 16, 35170, "", "=q4=Guardian's Lamellar Bracers", "=ds=", "13000 #faction#"};
		{ 17, 35155, "", "=q4=Guardian's Lamellar Belt", "=ds=", "18000 #faction#"};
		{ 18, 35140, "", "=q4=Guardian's Lamellar Greaves", "=ds=", "18000 #faction#"};
		{ 20, 35175, "", "=q4=Guardian's Ornamented Bracers", "=ds=", "13000 #faction#"};
		{ 21, 35160, "", "=q4=Guardian's Ornamented Belt", "=ds=", "18000 #faction#"};
		{ 22, 35145, "", "=q4=Guardian's Ornamented Greaves", "=ds=", "18000 #faction#"};
		{ 24, 35176, "", "=q4=Guardian's Plate Bracers", "=ds=", "13000 #faction#"};
		{ 25, 35161, "", "=q4=Guardian's Plate Belt", "=ds=", "18000 #faction#"};
		{ 26, 35146, "", "=q4=Guardian's Plate Greaves", "=ds=", "18000 #faction#"};
		{ 28, 35178, "", "=q4=Guardian's Scaled Bracers", "=ds=", "13000 #faction#"};
		{ 29, 35163, "", "=q4=Guardian's Scaled Belt", "=ds=", "18000 #faction#"};
		{ 30, 35148, "", "=q4=Guardian's Scaled Greaves", "=ds=", "18000 #faction#"};
		Prev = "PvP70NonSet1";
		Back = "PVPMENU";
	};

		--------------------------
		--- Arena - Armor Sets ---
		--------------------------

	AtlasLoot_Data["ArenaDruidFeral"] = {
		{ 1, 0, "Ability_Druid_Maul", "=q6=#arenas1_1#", "=q1=#m21# #e15#"};
		{ 2, 28127, "", "=q4=Gladiator's Dragonhide Helm", "=ds=#s1#"};
		{ 3, 28129, "", "=q4=Gladiator's Dragonhide Spaulders", "=ds=#s3#"};
		{ 4, 28130, "", "=q4=Gladiator's Dragonhide Tunic", "=ds=#s5#"};
		{ 5, 28126, "", "=q4=Gladiator's Dragonhide Gloves", "=ds=#s9#"};
		{ 6, 28128, "", "=q4=Gladiator's Dragonhide Legguards", "=ds=#s11#"};
		{ 8, 0, "Ability_Druid_Maul", "=q6=#arenas1_1#", "=q1=#m22#/#m23# #e15#"};
		{ 9, 31968, "", "=q4=Merciless Gladiator's Dragonhide Helm", "=ds=#s1#", "15000 #faction#"};
		{ 10, 31971, "", "=q4=Merciless Gladiator's Dragonhide Spaulders", "=ds=#s3#", "13000 #faction#"};
		{ 11, 31972, "", "=q4=Merciless Gladiator's Dragonhide Tunic", "=ds=#s5#", "15000 #faction#"};
		{ 12, 31967, "", "=q4=Merciless Gladiator's Dragonhide Gloves", "=ds=#s9#", "12000 #faction#"};
		{ 13, 31969, "", "=q4=Merciless Gladiator's Dragonhide Legguards", "=ds=#s11#", "15000 #faction#"};
		{ 16, 0, "Ability_Druid_Maul", "=q6=#arenas1_1#", "=q1=#m36#"};
		{ 17, 33672, "", "=q4=Vengeful Gladiator's Dragonhide Helm", "=ds=#s1#", ""};
		{ 18, 33674, "", "=q4=Vengeful Gladiator's Dragonhide Spaulders", "=ds=#s3#", ""};
		{ 19, 33675, "", "=q4=Vengeful Gladiator's Dragonhide Tunic", "=ds=#s5#", ""};
		{ 20, 33671, "", "=q4=Vengeful Gladiator's Dragonhide Gloves", "=ds=#s9#", ""};
		{ 21, 33673, "", "=q4=Vengeful Gladiator's Dragonhide Legguards", "=ds=#s11#", ""};
		{ 23, 0, "Ability_Druid_Maul", "=q6=#arenas1_1#", ""};
		{ 24, 34999, "", "=q4=Brutal Gladiator's Dragonhide Helm", "=ds=", "1875 #arena#", ""};
		{ 25, 35001, "", "=q4=Brutal Gladiator's Dragonhide Spaulders", "=ds=", "1500 #arena#", ""};
		{ 26, 35002, "", "=q4=Brutal Gladiator's Dragonhide Tunic", "=ds=", "1875 #arena#", ""};
		{ 27, 34998, "", "=q4=Brutal Gladiator's Dragonhide Gloves", "=ds=", "1125 #arena#", ""};
		{ 28, 35000, "", "=q4=Brutal Gladiator's Dragonhide Legguards", "=ds=", "1875 #arena#", ""};
		Back = "ARENASET";
	};

	AtlasLoot_Data["ArenaDruidBalance"] = {
		{ 1, 0, "Spell_Nature_InsectSwarm", "=q6=#arenas1_2#", "=q1=#m21# #e15#"};
		{ 2, 28137, "", "=q4=Gladiator's Wyrmhide Helm", "=ds=#s1#"};
		{ 3, 28139, "", "=q4=Gladiator's Wyrmhide Spaulders", "=ds=#s3#"};
		{ 4, 28140, "", "=q4=Gladiator's Wyrmhide Tunic", "=ds=#s5#"};
		{ 5, 28136, "", "=q4=Gladiator's Wyrmhide Gloves", "=ds=#s9#"};
		{ 6, 28138, "", "=q4=Gladiator's Wyrmhide Legguards", "=ds=#s11#"};
		{ 8, 0, "Spell_Nature_InsectSwarm", "=q6=#arenas1_2#", "=q1=#m22#/#m23# #e15#"};
		{ 9, 32057, "", "=q4=Merciless Gladiator's Wyrmhide Helm", "=ds=#s1#", "15000 #faction#"};
		{ 10, 32059, "", "=q4=Merciless Gladiator's Wyrmhide Spaulders", "=ds=#s3#", "13000 #faction#"};
		{ 11, 32060, "", "=q4=Merciless Gladiator's Wyrmhide Tunic", "=ds=#s5#", "15000 #faction#"};
		{ 12, 32056, "", "=q4=Merciless Gladiator's Wyrmhide Gloves", "=ds=#s9#", "12000 #faction#"};
		{ 13, 32058, "", "=q4=Merciless Gladiator's Wyrmhide Legguards", "=ds=#s11#", "15000 #faction#"};
		{ 16, 0, "Spell_Nature_InsectSwarm", "=q6=#arenas1_2#", "=q1=#m36#"};
		{ 17, 33768, "", "=q4=Vengeful Gladiator's Wyrmhide Helm", "=ds=#s1#", ""};
		{ 18, 33770, "", "=q4=Vengeful Gladiator's Wyrmhide Spaulders", "=ds=#s3#", ""};
		{ 19, 33771, "", "=q4=Vengeful Gladiator's Wyrmhide Tunic", "=ds=#s5#", ""};
		{ 20, 33767, "", "=q4=Vengeful Gladiator's Wyrmhide Gloves", "=ds=#s9#", ""};
		{ 21, 33769, "", "=q4=Vengeful Gladiator's Wyrmhide Legguards", "=ds=#s11#", ""};
		{ 23, 0, "Spell_Nature_InsectSwarm", "=q6=#arenas1_2#", ""};
		{ 24, 35112, "", "=q4=Brutal Gladiator's Wyrmhide Helm", "=ds=", "1875 #arena#", ""};
		{ 25, 35114, "", "=q4=Brutal Gladiator's Wyrmhide Spaulders", "=ds=", "1500 #arena#", ""};
		{ 26, 35115, "", "=q4=Brutal Gladiator's Wyrmhide Tunic", "=ds=", "1875 #arena#", ""};
		{ 27, 35111, "", "=q4=Brutal Gladiator's Wyrmhide Gloves", "=ds=", "1125 #arena#", ""};
		{ 28, 35113, "", "=q4=Brutal Gladiator's Wyrmhide Legguards", "=ds=", "1875 #arena#", ""};
		Back = "ARENASET";
	};

	AtlasLoot_Data["ArenaDruidRestoration"] = {
		{ 1, 0, "Spell_Nature_Regeneration", "=q6=#arenas1_3#", "=q1=#m21# #e15#"};
		{ 2, 31376, "", "=q4=Gladiator's Kodohide Helm", "=ds=#s1#"};
		{ 3, 31378, "", "=q4=Gladiator's Kodohide Spaulders", "=ds=#s3#"};
		{ 4, 31379, "", "=q4=Gladiator's Kodohide Tunic", "=ds=#s5#"};
		{ 5, 31375, "", "=q4=Gladiator's Kodohide Gloves", "=ds=#s9#"};
		{ 6, 31377, "", "=q4=Gladiator's Kodohide Legguards", "=ds=#s11#"};
		{ 8, 0, "Spell_Nature_Regeneration", "=q6=#arenas1_3#", "=q1=#m22#/#m23# #e15#"};
		{ 9, 31988, "", "=q4=Merciless Gladiator's Kodohide Helm", "=ds=#s1#", "15000 #faction#"};
		{ 10, 31990, "", "=q4=Merciless Gladiator's Kodohide Spaulders", "=ds=#s3#", "13000 #faction#"};
		{ 11, 31991, "", "=q4=Merciless Gladiator's Kodohide Tunic", "=ds=#s5#", "15000 #faction#"};
		{ 12, 31987, "", "=q4=Merciless Gladiator's Kodohide Gloves", "=ds=#s9#", "12000 #faction#"};
		{ 13, 31989, "", "=q4=Merciless Gladiator's Kodohide Legguards", "=ds=#s11#", "15000 #faction#"};
		{ 16, 0, "Spell_Nature_Regeneration", "=q6=#arenas1_3#", "=q1=#m36#"};
		{ 17, 33691, "", "=q4=Vengeful Gladiator's Kodohide Helm", "=ds=#s1#", ""};
		{ 18, 33693, "", "=q4=Vengeful Gladiator's Kodohide Spaulders", "=ds=#s3#", ""};
		{ 19, 33694, "", "=q4=Vengeful Gladiator's Kodohide Tunic", "=ds=#s5#", ""};
		{ 20, 33690, "", "=q4=Vengeful Gladiator's Kodohide Gloves", "=ds=#s9#", ""};
		{ 21, 33692, "", "=q4=Vengeful Gladiator's Kodohide Legguards", "=ds=#s11#", ""};
		{ 23, 0, "Spell_Nature_Regeneration", "=q6=#arenas1_3#", ""};
		{ 24, 35023, "", "=q4=Brutal Gladiator's Kodohide Helm", "=ds=", "1875 #arena#", ""};
		{ 25, 35025, "", "=q4=Brutal Gladiator's Kodohide Spaulders", "=ds=", "1500 #arena#", ""};
		{ 26, 35026, "", "=q4=Brutal Gladiator's Kodohide Tunic", "=ds=", "1875 #arena#", ""};
		{ 27, 35022, "", "=q4=Brutal Gladiator's Kodohide Gloves", "=ds=", "1125 #arena#", ""};
		{ 28, 35024, "", "=q4=Brutal Gladiator's Kodohide Legguards", "=ds=", "1875 #arena#", ""};
		Back = "ARENASET";
	};

	AtlasLoot_Data["ArenaHunter"] = {
		{ 1, 0, "Ability_Hunter_RunningShot", "=q6=#arenas2#", "=q1=#m21# #e15#"};
		{ 2, 28331, "", "=q4=Gladiator's Chain Helm", "=ds=#s1#"};
		{ 3, 28333, "", "=q4=Gladiator's Chain Spaulders", "=ds=#s3#"};
		{ 4, 28334, "", "=q4=Gladiator's Chain Armor", "=ds=#s5#"};
		{ 5, 28335, "", "=q4=Gladiator's Chain Gauntlets", "=ds=#s9#"};
		{ 6, 28332, "", "=q4=Gladiator's Chain Leggings", "=ds=#s11#"};
		{ 8, 0, "Ability_Hunter_RunningShot", "=q6=#arenas2#", "=q1=#m22#/#m23# #e15#"};
		{ 9, 31962, "", "=q4=Merciless Gladiator's Chain Helm", "=ds=#s1#", "15000 #faction#"};
		{ 10, 31964, "", "=q4=Merciless Gladiator's Chain Spaulders", "=ds=#s3#", "13000 #faction#"};
		{ 11, 31960, "", "=q4=Merciless Gladiator's Chain Armor", "=ds=#s5#", "15000 #faction#"};
		{ 12, 31961, "", "=q4=Merciless Gladiator's Chain Gauntlets", "=ds=#s9#", "12000 #faction#"};
		{ 13, 31963, "", "=q4=Merciless Gladiator's Chain Leggings", "=ds=#s11#", "15000 #faction#"};
		{ 16, 0, "Ability_Hunter_RunningShot", "=q6=#arenas2#", "=q1=#m36#"};
		{ 17, 33666, "", "=q4=Vengeful Gladiator's Chain Helm", "=ds=#s1#", ""};
		{ 18, 33668, "", "=q4=Vengeful Gladiator's Chain Spaulders", "=ds=#s3#", ""};
		{ 19, 33664, "", "=q4=Vengeful Gladiator's Chain Armor", "=ds=#s5#", ""};
		{ 20, 33665, "", "=q4=Vengeful Gladiator's Chain Gauntlets", "=ds=#s9#", ""};
		{ 21, 33667, "", "=q4=Vengeful Gladiator's Chain Leggings", "=ds=#s11#", ""};
		{ 23, 0, "Ability_Hunter_RunningShot", "=q6=#arenas2#", ""};
		{ 24, 34992, "", "=q4=Brutal Gladiator's Chain Helm", "=ds=", "1875 #arena#", ""};
		{ 25, 34994, "", "=q4=Brutal Gladiator's Chain Spaulders", "=ds=", "1500 #arena#", ""};
		{ 26, 34990, "", "=q4=Brutal Gladiator's Chain Armor", "=ds=", "1875 #arena#", ""};
		{ 27, 34991, "", "=q4=Brutal Gladiator's Chain Gauntlets", "=ds=", "1125 #arena#", ""};
		{ 28, 34993, "", "=q4=Brutal Gladiator's Chain Leggings", "=ds=", "1875 #arena#", ""};
		Back = "ARENASET";
	};

	AtlasLoot_Data["ArenaMage"] = {
		{ 1, 0, "Spell_Frost_IceStorm", "=q6=#arenas3#", "=q1=#m21# #e15#"};
		{ 2, 25855, "", "=q4=Gladiator's Silk Cowl", "=ds=#s1#"};
		{ 3, 25854, "", "=q4=Gladiator's Silk Amice", "=ds=#s3#"};
		{ 4, 25856, "", "=q4=Gladiator's Silk Raiment", "=ds=#s5#"};
		{ 5, 25857, "", "=q4=Gladiator's Silk Handguards", "=ds=#s9#"};
		{ 6, 25858, "", "=q4=Gladiator's Silk Trousers", "=ds=#s11#"};
		{ 8, 0, "Spell_Frost_IceStorm", "=q6=#arenas3#", "=q1=#m22#/#m23# #e15#"};
		{ 9, 32048, "", "=q4=Merciless Gladiator's Silk Cowl", "=ds=#s1#", "15000 #faction#"};
		{ 10, 32047, "", "=q4=Merciless Gladiator's Silk Amice", "=ds=#s3#", "13000 #faction#"};
		{ 11, 32050, "", "=q4=Merciless Gladiator's Silk Raiment", "=ds=#s5#", "15000 #faction#"};
		{ 12, 32049, "", "=q4=Merciless Gladiator's Silk Handguards", "=ds=#s9#", "12000 #faction#"};
		{ 13, 32051, "", "=q4=Merciless Gladiator's Silk Trousers", "=ds=#s11#", "15000 #faction#"};
		{ 16, 0, "Spell_Frost_IceStorm", "=q6=#arenas3#", "=q1=#m36#"};
		{ 17, 33758, "", "=q4=Vengeful Gladiator's Silk Cowl", "=ds=#s1#", ""};
		{ 18, 33757, "", "=q4=Vengeful Gladiator's Silk Amice", "=ds=#s3#", ""};
		{ 19, 33760, "", "=q4=Vengeful Gladiator's Silk Raiment", "=ds=#s5#", ""};
		{ 20, 33759, "", "=q4=Vengeful Gladiator's Silk Handguards", "=ds=#s9#", ""};
		{ 21, 33761, "", "=q4=Vengeful Gladiator's Silk Trousers", "=ds=#s11#", ""};
		{ 23, 0, "Spell_Frost_IceStorm", "=q6=#arenas3#", ""};
		{ 24, 35097, "", "=q4=Brutal Gladiator's Silk Cowl", "=ds=", "1875 #arena#", ""};
		{ 25, 35096, "", "=q4=Brutal Gladiator's Silk Amice", "=ds=", "1500 #arena#", ""};
		{ 26, 35099, "", "=q4=Brutal Gladiator's Silk Raiment", "=ds=", "1875 #arena#", ""};
		{ 27, 35098, "", "=q4=Brutal Gladiator's Silk Handguards", "=ds=", "1125 #arena#", ""};
		{ 28, 35100, "", "=q4=Brutal Gladiator's Silk Trousers", "=ds=", "1875 #arena#", ""};
		Back = "ARENASET";
	};

	AtlasLoot_Data["ArenaPaladinProtection"] = {
		{ 1, 0, "Spell_Holy_SealOfMight", "=q6=#arenas4_1#", "=q1=#m21# #e15#"};
		{ 2, 27704, "", "=q4=Gladiator's Lamellar Helm", "=ds=#s1#"};
		{ 3, 27706, "", "=q4=Gladiator's Lamellar Shoulders", "=ds=#s3#"};
		{ 4, 27702, "", "=q4=Gladiator's Lamellar Chestpiece", "=ds=#s5#"};
		{ 5, 27703, "", "=q4=Gladiator's Lamellar Gauntlets", "=ds=#s9#"};
		{ 6, 27705, "", "=q4=Gladiator's Lamellar Legguards", "=ds=#s11#"};
		{ 8, 0, "Spell_Holy_SealOfMight", "=q6=#arenas4_1#", "=q1=#m22#/#m23# #e15#"};
		{ 9, 31997, "", "=q4=Merciless Gladiator's Lamellar Helm", "=ds=#s1#", "15000 #faction#"};
		{ 10, 31996, "", "=q4=Merciless Gladiator's Lamellar Shoulders", "=ds=#s3#", "13000 #faction#"};
		{ 11, 31992, "", "=q4=Merciless Gladiator's Lamellar Chestpiece", "=ds=#s5#", "15000 #faction#"};
		{ 12, 31993, "", "=q4=Merciless Gladiator's Lamellar Gauntlets", "=ds=#s9#", "12000 #faction#"};
		{ 13, 31995, "", "=q4=Merciless Gladiator's Lamellar Legguards", "=ds=#s11#", "15000 #faction#"};
		{ 16, 0, "Spell_Holy_SealOfMight", "=q6=#arenas4_1#", "=q1=#m36#"};
		{ 17, 33697, "", "=q4=Vengeful Gladiator's Lamellar Helm", "=ds=#s1#", ""};
		{ 18, 33699, "", "=q4=Vengeful Gladiator's Lamellar Shoulders", "=ds=#s3#", ""};
		{ 19, 33695, "", "=q4=Vengeful Gladiator's Lamellar Chestpiece", "=ds=#s5#", ""};
		{ 20, 33696, "", "=q4=Vengeful Gladiator's Lamellar Gauntlets", "=ds=#s9#", ""};
		{ 21, 33698, "", "=q4=Vengeful Gladiator's Lamellar Legguards", "=ds=#s11#", ""};
		{ 23, 0, "Spell_Holy_SealOfMight", "=q6=#arenas4_1#", ""};
		{ 24, 35029, "", "=q4=Brutal Gladiator's Lamellar Helm", "=ds=", "1875 #arena#", ""};
		{ 25, 35031, "", "=q4=Brutal Gladiator's Lamellar Shoulders", "=ds=", "1500 #arena#", ""};
		{ 26, 35027, "", "=q4=Brutal Gladiator's Lamellar Chestpiece", "=ds=", "1875 #arena#", ""};
		{ 27, 35028, "", "=q4=Brutal Gladiator's Lamellar Gauntlets", "=ds=", "1125 #arena#", ""};
		{ 28, 35030, "", "=q4=Brutal Gladiator's Lamellar Legguards", "=ds=", "1875 #arena#", ""};
		Back = "ARENASET";
	};

	AtlasLoot_Data["ArenaPaladinRetribution"] = {
		{ 1, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", "=q1=#m21# #e15#"};
		{ 2, 27881, "", "=q4=Gladiator's Scaled Helm", "=ds=#s1#"};
		{ 3, 27883, "", "=q4=Gladiator's Scaled Shoulders", "=ds=#s3#"};
		{ 4, 27879, "", "=q4=Gladiator's Scaled Chestpiece", "=ds=#s5#"};
		{ 5, 27880, "", "=q4=Gladiator's Scaled Gauntlets", "=ds=#s9#"};
		{ 6, 27882, "", "=q4=Gladiator's Scaled Legguards", "=ds=#s11#"};
		{ 8, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", "=q1=#m22#/#m23# #e15#"};
		{ 9, 32041, "", "=q4=Merciless Gladiator's Scaled Helm", "=ds=#s1#", "15000 #faction#"};
		{ 10, 32043, "", "=q4=Merciless Gladiator's Scaled Shoulders", "=ds=#s3#", "13000 #faction#"};
		{ 11, 32039, "", "=q4=Merciless Gladiator's Scaled Chestpiece", "=ds=#s5#", "15000 #faction#"};
		{ 12, 32040, "", "=q4=Merciless Gladiator's Scaled Gauntlets", "=ds=#s9#", "12000 #faction#"};
		{ 13, 32042, "", "=q4=Merciless Gladiator's Scaled Legguards", "=ds=#s11#", "15000 #faction#"};
		{ 16, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", "=q1=#m36#"};
		{ 17, 33751, "", "=q4=Vengeful Gladiator's Scaled Helm", "=ds=#s1#", ""};
		{ 18, 33753, "", "=q4=Vengeful Gladiator's Scaled Shoulders", "=ds=#s3#", ""};
		{ 19, 33749, "", "=q4=Vengeful Gladiator's Scaled Chestpiece", "=ds=#s5#", ""};
		{ 20, 33750, "", "=q4=Vengeful Gladiator's Scaled Gauntlets", "=ds=#s9#", ""};
		{ 21, 33752, "", "=q4=Vengeful Gladiator's Scaled Legguards", "=ds=#s11#", ""};
		{ 23, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", ""};
		{ 24, 35090, "", "=q4=Brutal Gladiator's Scaled Helm", "=ds=", "1875 #arena#", ""};
		{ 25, 35092, "", "=q4=Brutal Gladiator's Scaled Shoulders", "=ds=", "1500 #arena#", ""};
		{ 26, 35088, "", "=q4=Brutal Gladiator's Scaled Chestpiece", "=ds=", "1875 #arena#", ""};
		{ 27, 35089, "", "=q4=Brutal Gladiator's Scaled Gauntlets", "=ds=", "1125 #arena#", ""};
		{ 28, 35091, "", "=q4=Brutal Gladiator's Scaled Legguards", "=ds=", "1875 #arena#", ""};
		Back = "ARENASET";
	};

	AtlasLoot_Data["ArenaPaladinHoly"] = {
		{ 1, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", "=q1=#m21# #e15#"};
		{ 2, 31616, "", "=q4=Gladiator's Ornamented Headcover", "=ds=#s1#"};
		{ 3, 31619, "", "=q4=Gladiator's Ornamented Spaulders", "=ds=#s3#"};
		{ 4, 31613, "", "=q4=Gladiator's Ornamented Chestguard", "=ds=#s5#"};
		{ 5, 31614, "", "=q4=Gladiator's Ornamented Gloves", "=ds=#s9#"};
		{ 6, 31618, "", "=q4=Gladiator's Ornamented Legplates", "=ds=#s11#"};
		{ 8, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", "=q1=#m22#/#m23# #e15#"};
		{ 9, 32022, "", "=q4=Merciless Gladiator's Ornamented Headcover", "=ds=#s1#", "15000 #faction#"};
		{ 10, 32024, "", "=q4=Merciless Gladiator's Ornamented Spaulders", "=ds=#s3#", "13000 #faction#"};
		{ 11, 32020, "", "=q4=Merciless Gladiator's Ornamented Chestguard", "=ds=#s5#", "15000 #faction#"};
		{ 12, 32021, "", "=q4=Merciless Gladiator's Ornamented Gloves", "=ds=#s9#", "12000 #faction#"};
		{ 13, 32023, "", "=q4=Merciless Gladiator's Ornamented Legplates", "=ds=#s11#", "15000 #faction#"};
		{ 16, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", "=q1=#m36#"};
		{ 17, 33724, "", "=q4=Vengeful Gladiator's Ornamented Headcover", "=ds=#s1#", ""};
		{ 18, 33726, "", "=q4=Vengeful Gladiator's Ornamented Spaulders", "=ds=#s3#", ""};
		{ 19, 33722, "", "=q4=Vengeful Gladiator's Ornamented Chestguard", "=ds=#s5#", ""};
		{ 20, 33723, "", "=q4=Vengeful Gladiator's Ornamented Gloves", "=ds=#s9#", ""};
		{ 21, 33725, "", "=q4=Vengeful Gladiator's Ornamented Legplates", "=ds=#s11#", ""};
		{ 23, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", ""};
		{ 24, 35061, "", "=q4=Brutal Gladiator's Ornamented Headcover", "=ds=", "1875 #arena#", ""};
		{ 25, 35063, "", "=q4=Brutal Gladiator's Ornamented Spaulders", "=ds=", "1500 #arena#", ""};
		{ 26, 35059, "", "=q4=Brutal Gladiator's Ornamented Chestguard", "=ds=", "1875 #arena#", ""};
		{ 27, 35060, "", "=q4=Brutal Gladiator's Ornamented Gloves", "=ds=", "1125 #arena#", ""};
		{ 28, 35062, "", "=q4=Brutal Gladiator's Ornamented Legplates", "=ds=", "1875 #arena#", ""};
		Back = "ARENASET";
	};

	AtlasLoot_Data["ArenaPriestShadow"] = {
		{ 1, 0, "Spell_Shadow_AntiShadow", "=q6=#arenas5_1#", "=q1=#m21# #e15#"};
		{ 2, 27708, "", "=q4=Gladiator's Satin Hood", "=ds=#s1#"};
		{ 3, 27710, "", "=q4=Gladiator's Satin Mantle", "=ds=#s3#"};
		{ 4, 27711, "", "=q4=Gladiator's Satin Robe", "=ds=#s5#"};
		{ 5, 27707, "", "=q4=Gladiator's Satin Gloves", "=ds=#s9#"};
		{ 6, 27709, "", "=q4=Gladiator's Satin Leggings", "=ds=#s11#"};
		{ 8, 0, "Spell_Shadow_AntiShadow", "=q6=#arenas5_1#", "=q1=#m22#/#m23# #e15#"};
		{ 9, 32035, "", "=q4=Merciless Gladiator's Satin Hood", "=ds=#s1#", "15000 #faction#"};
		{ 10, 32037, "", "=q4=Merciless Gladiator's Satin Mantle", "=ds=#s3#", "13000 #faction#"};
		{ 11, 32038, "", "=q4=Merciless Gladiator's Satin Robe", "=ds=#s5#", "15000 #faction#"};
		{ 12, 32034, "", "=q4=Merciless Gladiator's Satin Gloves", "=ds=#s9#", "12000 #faction#"};
		{ 13, 32036, "", "=q4=Merciless Gladiator's Satin Leggings", "=ds=#s11#", "15000 #faction#"};
		{ 16, 0, "Spell_Shadow_AntiShadow", "=q6=#arenas5_1#", "=q1=#m36#"};
		{ 17, 33745, "", "=q4=Vengeful Gladiator's Satin Hood", "=ds=#s1#", ""};
		{ 18, 33747, "", "=q4=Vengeful Gladiator's Satin Mantle", "=ds=#s3#", ""};
		{ 19, 33748, "", "=q4=Vengeful Gladiator's Satin Robe", "=ds=#s5#", ""};
		{ 20, 33744, "", "=q4=Vengeful Gladiator's Satin Gloves", "=ds=#s9#", ""};
		{ 21, 33746, "", "=q4=Vengeful Gladiator's Satin Leggings", "=ds=#s11#", ""};
		{ 23, 0, "Spell_Shadow_AntiShadow", "=q6=#arenas5_1#", ""};
		{ 24, 35084, "", "=q4=Brutal Gladiator's Satin Hood", "=ds=", "1875 #arena#", ""};
		{ 25, 35086, "", "=q4=Brutal Gladiator's Satin Mantle", "=ds=", "1500 #arena#", ""};
		{ 26, 35087, "", "=q4=Brutal Gladiator's Satin Robe", "=ds=", "1875 #arena#", ""};
		{ 27, 35083, "", "=q4=Brutal Gladiator's Satin Gloves", "=ds=", "1125 #arena#", ""};
		{ 28, 35085, "", "=q4=Brutal Gladiator's Satin Leggings", "=ds=", "1875 #arena#", ""};
		Back = "ARENASET";
	};

	AtlasLoot_Data["ArenaPriestHoly"] = {
		{ 1, 0, "Spell_Holy_PowerWordShield", "=q6=#arenas5_2#", "=q1=#m21# #e15#"};
		{ 2, 31410, "", "=q4=Gladiator's Mooncloth Hood", "=ds=#s1#"};
		{ 3, 31412, "", "=q4=Gladiator's Mooncloth Mantle", "=ds=#s3#"};
		{ 4, 31413, "", "=q4=Gladiator's Mooncloth Robe", "=ds=#s5#"};
		{ 5, 31409, "", "=q4=Gladiator's Mooncloth Gloves", "=ds=#s9#"};
		{ 6, 31411, "", "=q4=Gladiator's Mooncloth Leggings", "=ds=#s11#"};
		{ 8, 0, "Spell_Holy_PowerWordShield", "=q6=#arenas5_2#", "=q1=#m22#/#m23# #e15#"};
		{ 9, 32016, "", "=q4=Merciless Gladiator's Mooncloth Hood", "=ds=#s1#", "15000 #faction#"};
		{ 10, 32018, "", "=q4=Merciless Gladiator's Mooncloth Mantle", "=ds=#s3#", "13000 #faction#"};
		{ 11, 32019, "", "=q4=Merciless Gladiator's Mooncloth Robe", "=ds=#s5#", "15000 #faction#"};
		{ 12, 32015, "", "=q4=Merciless Gladiator's Mooncloth Gloves", "=ds=#s9#", "12000 #faction#"};
		{ 13, 32017, "", "=q4=Merciless Gladiator's Mooncloth Leggings", "=ds=#s11#", "15000 #faction#"};
		{ 16, 0, "Spell_Holy_PowerWordShield", "=q6=#arenas5_2#", "=q1=#m36#"};
		{ 17, 33718, "", "=q4=Vengeful Gladiator's Mooncloth Hood", "=ds=#s1#", ""};
		{ 18, 33720, "", "=q4=Vengeful Gladiator's Mooncloth Mantle", "=ds=#s3#", ""};
		{ 19, 33721, "", "=q4=Vengeful Gladiator's Mooncloth Robe", "=ds=#s5#", ""};
		{ 20, 33717, "", "=q4=Vengeful Gladiator's Mooncloth Gloves", "=ds=#s9#", ""};
		{ 21, 33719, "", "=q4=Vengeful Gladiator's Mooncloth Leggings", "=ds=#s11#", ""};
		{ 23, 0, "Spell_Holy_PowerWordShield", "=q6=#arenas5_2#", ""};
		{ 24, 35054, "", "=q4=Brutal Gladiator's Mooncloth Hood", "=ds=", "1875 #arena#", ""};
		{ 25, 35056, "", "=q4=Brutal Gladiator's Mooncloth Mantle", "=ds=", "1500 #arena#", ""};
		{ 26, 35057, "", "=q4=Brutal Gladiator's Mooncloth Robe", "=ds=", "1875 #arena#", ""};
		{ 27, 35053, "", "=q4=Brutal Gladiator's Mooncloth Gloves", "=ds=", "1125 #arena#", ""};
		{ 28, 35055, "", "=q4=Brutal Gladiator's Mooncloth Leggings", "=ds=", "1875 #arena#", ""};
		Back = "ARENASET";
	};

	AtlasLoot_Data["ArenaRogue"] = {
		{ 1, 0, "Ability_BackStab", "=q6=#arenas6#", "=q1=#m21# #e15#"};
		{ 2, 25830, "", "=q4=Gladiator's Leather Helm", "=ds=#s1#"};
		{ 3, 25832, "", "=q4=Gladiator's Leather Spaulders", "=ds=#s3#"};
		{ 4, 25831, "", "=q4=Gladiator's Leather Tunic", "=ds=#s5#"};
		{ 5, 25834, "", "=q4=Gladiator's Leather Gloves", "=ds=#s9#"};
		{ 6, 25833, "", "=q4=Gladiator's Leather Legguards", "=ds=#s11#"};
		{ 8, 0, "Ability_BackStab", "=q6=#arenas6#", "=q1=#m22#/#m23# #e15#"};
		{ 9, 31999, "", "=q4=Merciless Gladiator's Leather Helm", "=ds=#s1#", "15000 #faction#"};
		{ 10, 32001, "", "=q4=Merciless Gladiator's Leather Spaulders", "=ds=#s3#", "13000 #faction#"};
		{ 11, 32002, "", "=q4=Merciless Gladiator's Leather Tunic", "=ds=#s5#", "15000 #faction#"};
		{ 12, 31998, "", "=q4=Merciless Gladiator's Leather Gloves", "=ds=#s9#", "12000 #faction#"};
		{ 13, 32000, "", "=q4=Merciless Gladiator's Leather Legguards", "=ds=#s11#", "15000 #faction#"};
		{ 16, 0, "Ability_BackStab", "=q6=#arenas6#", "=q1=#m36#"};
		{ 17, 33701, "", "=q4=Vengeful Gladiator's Leather Helm", "=ds=#s1#", ""};
		{ 18, 33703, "", "=q4=Vengeful Gladiator's Leather Spaulders", "=ds=#s3#", ""};
		{ 19, 33704, "", "=q4=Vengeful Gladiator's Leather Tunic", "=ds=#s5#", ""};
		{ 20, 33700, "", "=q4=Vengeful Gladiator's Leather Gloves", "=ds=#s9#", ""};
		{ 21, 33702, "", "=q4=Vengeful Gladiator's Leather Legguards", "=ds=#s11#", ""};
		{ 23, 0, "Ability_BackStab", "=q6=#arenas6#", ""};
		{ 24, 35033, "", "=q4=Brutal Gladiator's Leather Helm", "=ds=", "1875 #arena#", ""};
		{ 25, 35035, "", "=q4=Brutal Gladiator's Leather Spaulders", "=ds=", "1500 #arena#", ""};
		{ 26, 35036, "", "=q4=Brutal Gladiator's Leather Tunic", "=ds=", "1875 #arena#", ""};
		{ 27, 35032, "", "=q4=Brutal Gladiator's Leather Gloves", "=ds=", "1125 #arena#", ""};
		{ 28, 35034, "", "=q4=Brutal Gladiator's Leather Legguards", "=ds=", "1875 #arena#", ""};
		Back = "ARENASET";
	};

	AtlasLoot_Data["ArenaWarlockDemonology"] = {
		{ 1, 0, "Spell_Shadow_CurseOfTounges", "=q6=#arenas8_1#", "=q1=#m21# #e15#"};
		{ 2, 24553, "", "=q4=Gladiator's Dreadweave Hood", "=ds=#s1#"};
		{ 3, 24554, "", "=q4=Gladiator's Dreadweave Mantle", "=ds=#s3#"};
		{ 4, 24552, "", "=q4=Gladiator's Dreadweave Robe", "=ds=#s5#"};
		{ 5, 24556, "", "=q4=Gladiator's Dreadweave Gloves", "=ds=#s9#"};
		{ 6, 24555, "", "=q4=Gladiator's Dreadweave Leggings", "=ds=#s11#"};
		{ 8, 0, "Spell_Shadow_CurseOfTounges", "=q6=#arenas8_1#", "=q1=#m22#/#m23# #e15#"};
		{ 9, 31974, "", "=q4=Merciless Gladiator's Dreadweave Hood", "=ds=#s1#", "15000 #faction#"};
		{ 10, 31976, "", "=q4=Merciless Gladiator's Dreadweave Mantle", "=ds=#s3#", "13000 #faction#"};
		{ 11, 31977, "", "=q4=Merciless Gladiator's Dreadweave Robe", "=ds=#s5#", "15000 #faction#"};
		{ 12, 31973, "", "=q4=Merciless Gladiator's Dreadweave Gloves", "=ds=#s9#", "12000 #faction#"};
		{ 13, 31975, "", "=q4=Merciless Gladiator's Dreadweave Leggings", "=ds=#s11#", "15000 #faction#"};
		{ 16, 0, "Spell_Shadow_CurseOfTounges", "=q6=#arenas8_1#", "=q1=#m36#"};
		{ 17, 33677, "", "=q4=Vengeful Gladiator's Dreadweave Hood", "=ds=#s1#", ""};
		{ 18, 33679, "", "=q4=Vengeful Gladiator's Dreadweave Mantle", "=ds=#s3#", ""};
		{ 19, 33680, "", "=q4=Vengeful Gladiator's Dreadweave Robe", "=ds=#s5#", ""};
		{ 20, 33676, "", "=q4=Vengeful Gladiator's Dreadweave Gloves", "=ds=#s9#", ""};
		{ 21, 33678, "", "=q4=Vengeful Gladiator's Dreadweave Leggings", "=ds=#s11#", ""};
		{ 23, 0, "Spell_Shadow_CurseOfTounges", "=q6=#arenas8_1#", ""};
		{ 24, 35004, "", "=q4=Brutal Gladiator's Dreadweave Hood", "=ds=", "1875 #arena#", ""};
		{ 25, 35006, "", "=q4=Brutal Gladiator's Dreadweave Mantle", "=ds=", "1500 #arena#", ""};
		{ 26, 35007, "", "=q4=Brutal Gladiator's Dreadweave Robe", "=ds=", "1875 #arena#", ""};
		{ 27, 35003, "", "=q4=Brutal Gladiator's Dreadweave Gloves", "=ds=", "1125 #arena#", ""};
		{ 28, 35005, "", "=q4=Brutal Gladiator's Dreadweave Leggings", "=ds=", "1875 #arena#", ""};
		Back = "ARENASET";
	};

	AtlasLoot_Data["ArenaWarlockDestruction"] = {
		{ 1, 0, "Spell_Shadow_CurseOfTounges", "=q6=#arenas8_2#", "=q1=#m21# #e15#"};
		{ 2, 30187, "", "=q4=Gladiator's Felweave Cowl", "=ds=#s1#"};
		{ 3, 30186, "", "=q4=Gladiator's Felweave Amice", "=ds=#s3#"};
		{ 4, 30200, "", "=q4=Gladiator's Felweave Raiment", "=ds=#s5#"};
		{ 5, 30188, "", "=q4=Gladiator's Felweave Handguards", "=ds=#s9#"};
		{ 6, 30201, "", "=q4=Gladiator's Felweave Trousers", "=ds=#s11#"};
		{ 8, 0, "Spell_Shadow_CurseOfTounges", "=q6=#arenas8_2#", "=q1=#m22#/#m23# #e15#"};
		{ 9, 31980, "", "=q4=Merciless Gladiator's Felweave Cowl", "=ds=#s1#", "15000 #faction#"};
		{ 10, 31979, "", "=q4=Merciless Gladiator's Felweave Amice", "=ds=#s3#", "13000 #faction#"};
		{ 11, 31982, "", "=q4=Merciless Gladiator's Felweave Raiment", "=ds=#s5#", "15000 #faction#"};
		{ 12, 31981, "", "=q4=Merciless Gladiator's Felweave Handguards", "=ds=#s9#", "12000 #faction#"};
		{ 13, 31983, "", "=q4=Merciless Gladiator's Felweave Trousers", "=ds=#s11#", "15000 #faction#"};
		{ 16, 0, "Spell_Shadow_CurseOfTounges", "=q6=#arenas8_2#", "=q1=#m36#"};
		{ 17, 33683, "", "=q4=Vengeful Gladiator's Felweave Cowl", "=ds=#s1#", ""};
		{ 18, 33682, "", "=q4=Vengeful Gladiator's Felweave Amice", "=ds=#s3#", ""};
		{ 19, 33685, "", "=q4=Vengeful Gladiator's Felweave Raiment", "=ds=#s5#", ""};
		{ 20, 33684, "", "=q4=Vengeful Gladiator's Felweave Handguards", "=ds=#s9#", ""};
		{ 21, 33686, "", "=q4=Vengeful Gladiator's Felweave Trousers", "=ds=#s11#", ""};
		{ 23, 0, "Spell_Shadow_CurseOfTounges", "=q6=#arenas8_2#", ""};
		{ 24, 35010, "", "=q4=Brutal Gladiator's Felweave Cowl", "=ds=", "1875 #arena#", ""};
		{ 25, 35009, "", "=q4=Brutal Gladiator's Felweave Amice", "=ds=", "1500 #arena#", ""};
		{ 26, 35012, "", "=q4=Brutal Gladiator's Felweave Raiment", "=ds=", "1875 #arena#", ""};
		{ 27, 35011, "", "=q4=Brutal Gladiator's Felweave Handguards", "=ds=", "1125 #arena#", ""};
		{ 28, 35013, "", "=q4=Brutal Gladiator's Felweave Trousers", "=ds=", "1875 #arena#", ""};
		Back = "ARENASET";
	};

	AtlasLoot_Data["ArenaShamanEnhancement"] = {
		{ 1, 0, "Spell_FireResistanceTotem_01", "=q6=#arenas7_1#", "=q1=#m21# #e15#"};
		{ 2, 25998, "", "=q4=Gladiator's Linked Helm", "=ds=#s1#"};
		{ 3, 25999, "", "=q4=Gladiator's Linked Spaulders", "=ds=#s3#"};
		{ 4, 25997, "", "=q4=Gladiator's Linked Armor", "=ds=#s5#"};
		{ 5, 26000, "", "=q4=Gladiator's Linked Gauntlets", "=ds=#s9#"};
		{ 6, 26001, "", "=q4=Gladiator's Linked Leggings", "=ds=#s11#"};
		{ 8, 0, "Spell_FireResistanceTotem_01", "=q6=#arenas7_1#", "=q1=#m22#/#m23# #e15#"};
		{ 9, 32006, "", "=q4=Merciless Gladiator's Linked Helm", "=ds=#s1#", "15000 #faction#"};
		{ 10, 32008, "", "=q4=Merciless Gladiator's Linked Spaulders", "=ds=#s3#", "13000 #faction#"};
		{ 11, 32004, "", "=q4=Merciless Gladiator's Linked Armor", "=ds=#s5#", "15000 #faction#"};
		{ 12, 32005, "", "=q4=Merciless Gladiator's Linked Gauntlets", "=ds=#s9#", "12000 #faction#"};
		{ 13, 32007, "", "=q4=Merciless Gladiator's Linked Leggings", "=ds=#s11#", "15000 #faction#"};
		{ 16, 0, "Spell_FireResistanceTotem_01", "=q6=#arenas7_1#", "=q1=#m36#"};
		{ 17, 33708, "", "=q4=Vengeful Gladiator's Linked Helm", "=ds=#s1#", ""};
		{ 18, 33710, "", "=q4=Vengeful Gladiator's Linked Spaulders", "=ds=#s3#", ""};
		{ 19, 33706, "", "=q4=Vengeful Gladiator's Linked Armor", "=ds=#s5#", ""};
		{ 20, 33707, "", "=q4=Vengeful Gladiator's Linked Gauntlets", "=ds=#s9#", ""};
		{ 21, 33709, "", "=q4=Vengeful Gladiator's Linked Leggings", "=ds=#s11#", ""};
		{ 23, 0, "Spell_FireResistanceTotem_01", "=q6=#arenas7_1#", ""};
		{ 24, 35044, "", "=q4=Brutal Gladiator's Linked Helm", "=ds=", "1875 #arena#", ""};
		{ 25, 35046, "", "=q4=Brutal Gladiator's Linked Spaulders", "=ds=", "1500 #arena#", ""};
		{ 26, 35042, "", "=q4=Brutal Gladiator's Linked Armor", "=ds=", "1875 #arena#", ""};
		{ 27, 35043, "", "=q4=Brutal Gladiator's Linked Gauntlets", "=ds=", "1125 #arena#", ""};
		{ 28, 35045, "", "=q4=Brutal Gladiator's Linked Leggings", "=ds=", "1875 #arena#", ""};
		Back = "ARENASET";
	};

	AtlasLoot_Data["ArenaShamanElemental"] = {
		{ 1, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", "=q1=#m21# #e15#"};
		{ 2, 27471, "", "=q4=Gladiator's Mail Helm", "=ds=#s1#"};
		{ 3, 27473, "", "=q4=Gladiator's Mail Spaulders", "=ds=#s3#"};
		{ 4, 27469, "", "=q4=Gladiator's Mail Armor", "=ds=#s5#"};
		{ 5, 27470, "", "=q4=Gladiator's Mail Gauntlets", "=ds=#s9#"};
		{ 6, 27472, "", "=q4=Gladiator's Mail Leggings", "=ds=#s11#"};
		{ 8, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", "=q1=#m22#/#m23# #e15#"};
		{ 9, 32011, "", "=q4=Merciless Gladiator's Mail Helm", "=ds=#s1#", ""};
		{ 10, 32013, "", "=q4=Merciless Gladiator's Mail Spaulders", "=ds=#s3#", "13000 #faction#"};
		{ 11, 32009, "", "=q4=Merciless Gladiator's Mail Armor", "=ds=#s5#", "15000 #faction#"};
		{ 12, 32010, "", "=q4=Merciless Gladiator's Mail Gauntlets", "=ds=#s9#", "12000 #faction#"};
		{ 13, 32012, "", "=q4=Merciless Gladiator's Mail Leggings", "=ds=#s11#", "15000 #faction#"};
		{ 16, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", "=q1=#m36#"};
		{ 17, 33713, "", "=q4=Vengeful Gladiator's Mail Helm", "=ds=#s1#", ""};
		{ 18, 33715, "", "=q4=Vengeful Gladiator's Mail Spaulders", "=ds=#s3#", ""};
		{ 19, 33711, "", "=q4=Vengeful Gladiator's Mail Armor", "=ds=#s5#", ""};
		{ 20, 33712, "", "=q4=Vengeful Gladiator's Mail Gauntlets", "=ds=#s9#", ""};
		{ 21, 33714, "", "=q4=Vengeful Gladiator's Mail Leggings", "=ds=#s11#", ""};
		{ 23, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", ""};
		{ 24, 35050, "", "=q4=Brutal Gladiator's Mail Helm", "=ds=", "1875 #arena#", ""};
		{ 25, 35052, "", "=q4=Brutal Gladiator's Mail Spaulders", "=ds=", "1500 #arena#", ""};
		{ 26, 35048, "", "=q4=Brutal Gladiator's Mail Armor", "=ds=", "1875 #arena#", ""};
		{ 27, 35049, "", "=q4=Brutal Gladiator's Mail Gauntlets", "=ds=", "1125 #arena#", ""};
		{ 28, 35051, "", "=q4=Brutal Gladiator's Mail Leggings", "=ds=", "1875 #arena#", ""};
		Back = "ARENASET";
	};

	AtlasLoot_Data["ArenaShamanRestoration"] = {
		{ 1, 0, "Spell_Nature_HealingWaveGreater", "=q6=#arenas7_3#", "=q1=#m21# #e15#"};
		{ 2, 31400, "", "=q4=Gladiator's Ringmail Helm", "=ds=#s1#"};
		{ 3, 31407, "", "=q4=Gladiator's Ringmail Spaulders", "=ds=#s3#"};
		{ 4, 31396, "", "=q4=Gladiator's Ringmail Armor", "=ds=#s5#"};
		{ 5, 31397, "", "=q4=Gladiator's Ringmail Gauntlets", "=ds=#s9#"};
		{ 6, 31406, "", "=q4=Gladiator's Ringmail Leggings", "=ds=#s11#"};
		{ 8, 0, "Spell_Nature_HealingWaveGreater", "=q6=#arenas7_3#", "=q1=#m22#/#m23# #e15#"};
		{ 9, 32031, "", "=q4=Merciless Gladiator's Ringmail Helm", "=ds=#s1#", "15000 #faction#"};
		{ 10, 32033, "", "=q4=Merciless Gladiator's Ringmail Spaulders", "=ds=#s3#", "13000 #faction#"};
		{ 11, 32029, "", "=q4=Merciless Gladiator's Ringmail Armor", "=ds=#s5#", "15000 #faction#"};
		{ 12, 32030, "", "=q4=Merciless Gladiator's Ringmail Gauntlets", "=ds=#s9#", "12000 #faction#"};
		{ 13, 32032, "", "=q4=Merciless Gladiator's Ringmail Leggings", "=ds=#s11#", "15000 #faction#"};
		{ 16, 0, "Spell_Nature_HealingWaveGreater", "=q6=#arenas7_3#", "=q1=#m36#"};
		{ 17, 33740, "", "=q4=Vengeful Gladiator's Ringmail Helm", "=ds=#s1#", ""};
		{ 18, 33742, "", "=q4=Vengeful Gladiator's Ringmail Spaulders", "=ds=#s3#", ""};
		{ 19, 33738, "", "=q4=Vengeful Gladiator's Ringmail Armor", "=ds=#s5#", ""};
		{ 20, 33739, "", "=q4=Vengeful Gladiator's Ringmail Gauntlets", "=ds=#s9#", ""};
		{ 21, 33741, "", "=q4=Vengeful Gladiator's Ringmail Leggings", "=ds=#s11#", ""};
		{ 23, 0, "Spell_Nature_HealingWaveGreater", "=q6=#arenas7_3#", ""};
		{ 24, 35079, "", "=q4=Brutal Gladiator's Ringmail Helm", "=ds=", "1875 #arena#", ""};
		{ 25, 35081, "", "=q4=Brutal Gladiator's Ringmail Spaulders", "=ds=", "1500 #arena#", ""};
		{ 26, 35077, "", "=q4=Brutal Gladiator's Ringmail Armor", "=ds=", "1875 #arena#", ""};
		{ 27, 35078, "", "=q4=Brutal Gladiator's Ringmail Gauntlets", "=ds=", "1125 #arena#", ""};
		{ 28, 35080, "", "=q4=Brutal Gladiator's Ringmail Leggings", "=ds=", "1875 #arena#", ""};
		Back = "ARENASET";
	};

	AtlasLoot_Data["ArenaWarrior"] = {
		{ 1, 0, "Ability_Warrior_BattleShout", "=q6=#arenas9#", "=q1=#m21# #e15#"};
		{ 2, 24545, "", "=q4=Gladiator's Plate Helm", "=ds=#s1#"};
		{ 3, 24546, "", "=q4=Gladiator's Plate Shoulders", "=ds=#s3#"};
		{ 4, 24544, "", "=q4=Gladiator's Plate Chestpiece", "=ds=#s5#"};
		{ 5, 24549, "", "=q4=Gladiator's Plate Gauntlets", "=ds=#s9#"};
		{ 6, 24547, "", "=q4=Gladiator's Plate Legguards", "=ds=#s11#"};
		{ 8, 0, "Ability_Warrior_BattleShout", "=q6=#arenas9#", "=q1=#m22#/#m23# #e15#"};
		{ 9, 30488, "", "=q4=Merciless Gladiator's Plate Helm", "=ds=#s1#", "15000 #faction#"};
		{ 10, 30490, "", "=q4=Merciless Gladiator's Plate Shoulders", "=ds=#s3#", "13000 #faction#"};
		{ 11, 30486, "", "=q4=Merciless Gladiator's Plate Chestpiece", "=ds=#s5#", "15000 #faction#"};
		{ 12, 30487, "", "=q4=Merciless Gladiator's Plate Gauntlets", "=ds=#s9#", "12000 #faction#"};
		{ 13, 30489, "", "=q4=Merciless Gladiator's Plate Legguards", "=ds=#s11#", "15000 #faction#"};
		{ 16, 0, "Ability_Warrior_BattleShout", "=q6=#arenas9#", "=q1=#m36#"};
		{ 17, 33730, "", "=q4=Vengeful Gladiator's Plate Helm", "=ds=#s1#", ""};
		{ 18, 33732, "", "=q4=Vengeful Gladiator's Plate Shoulders", "=ds=#s3#", ""};
		{ 19, 33728, "", "=q4=Vengeful Gladiator's Plate Chestpiece", "=ds=#s5#", ""};
		{ 20, 33729, "", "=q4=Vengeful Gladiator's Plate Gauntlets", "=ds=#s9#", ""};
		{ 21, 33731, "", "=q4=Vengeful Gladiator's Plate Legguards", "=ds=#s11#", ""};
		{ 23, 0, "Ability_Warrior_BattleShout", "=q6=#arenas9#", ""};
		{ 24, 35068, "", "=q4=Brutal Gladiator's Plate Helm", "=ds=", "1875 #arena#", ""};
		{ 25, 35070, "", "=q4=Brutal Gladiator's Plate Shoulders", "=ds=", "1500 #arena#", ""};
		{ 26, 35066, "", "=q4=Brutal Gladiator's Plate Chestpiece", "=ds=", "1875 #arena#", ""};
		{ 27, 35067, "", "=q4=Brutal Gladiator's Plate Gauntlets", "=ds=", "1125 #arena#", ""};
		{ 28, 35069, "", "=q4=Brutal Gladiator's Plate Legguards", "=ds=", "1875 #arena#", ""};
		Back = "ARENASET";
	};

		--------------------------------
		--- Arena Season 4 - Weapons ---
		--------------------------------

	AtlasLoot_Data["Arena4Weapons1"] = {
		{ 1, 35076, "", "=q4=Brutal Gladiator's Right Ripper", "=ds=#h3#, #w13#", "2625 #arena#", ""};
		{ 2, 35038, "", "=q4=Brutal Gladiator's Left Ripper", "=ds=#h4#, #w13#", "1125 #arena#", ""};
		{ 3, 35037, "", "=q4=Brutal Gladiator's Left Render", "=ds=#h4#, #w13#", "1125 #arena#", ""};
		{ 4, 35102, "", "=q4=Brutal Gladiator's Spellblade", "=ds=#h3#, #w4#", "3150 #arena#", ""};
		{ 5, 37739, "", "=q4=Brutal Gladiator's Blade of Alacrity", "=ds=#h3#, #w4#", "3150 #arena#", ""};
		{ 6, 35093, "", "=q4=Brutal Gladiator's Shanker", "=ds=#h1#, #w4#", "2625 #arena#", ""};
		{ 7, 35058, "", "=q4=Brutal Gladiator's Mutilator", "=ds=#h4#, #w4#", "1125 #arena#", ""};
		{ 8, 35095, "", "=q4=Brutal Gladiator's Shiv", "=ds=#h4#, #w4#", "1125 #arena#", ""};
		{ 9, 35101, "", "=q4=Brutal Gladiator's Slicer", "=ds=#h1#, #w10#", "2625 #arena#", ""};
		{ 10, 35072, "", "=q4=Brutal Gladiator's Quickblade", "=ds=#h4#, #w10#", "1125 #arena#", ""};
		{ 11, 35015, "", "=q4=Brutal Gladiator's Greatsword", "=ds=#h2#, #w10#", "3750 #arena#", ""};
		{ 12, 34996, "", "=q4=Brutal Gladiator's Cleaver", "=ds=#h1#, #w1#", "2625 #arena#", ""};
		{ 13, 34995, "", "=q4=Brutal Gladiator's Chopper", "=ds=#h4#, #w1#", "1125 #arena#", ""};
		{ 14, 36737, "", "=q4=Brutal Gladiator's Hatchet", "=ds=#h4#, #w1#", "650 #arena#", ""};
		{ 15, 35017, "", "=q4=Brutal Gladiator's Hacker", "=ds=#h4#, #w1#", "1125 #arena#", ""};
		{ 16, 34997, "", "=q4=Brutal Gladiator's Decapitator", "=ds=#h2#, #w1#", "3750 #arena#", ""};
		{ 17, 35110, "", "=q4=Brutal Gladiator's Waraxe", "=ds=#h3#, #w1#", "650 #arena#", ""};
		{ 18, 35014, "", "=q4=Brutal Gladiator's Gavel", "=ds=#h3#, #w6#", "3150 #arena#", ""};
		{ 19, 35082, "", "=q4=Brutal Gladiator's Salvation", "=ds=#h3#, #w6#", "3150 #arena#", ""};
		{ 20, 37740, "", "=q4=Brutal Gladiator's Swift Judgement", "=ds=#h3#, #w6#", "3150 #arena#", ""};
		{ 21, 35071, "", "=q4=Brutal Gladiator's Pummeler", "=ds=#h1#, #w6#", "2625 #arena#", ""};
		{ 22, 34988, "", "=q4=Brutal Gladiator's Bonecracker", "=ds=#h4#, #w6#", "3150 #arena#", ""};
		{ 23, 34989, "", "=q4=Brutal Gladiator's Bonegrinder", "=ds=#h2#, #w6#", "3750 #arena#", ""};
		{ 24, 35064, "", "=q4=Brutal Gladiator's Painsaw", "=ds=#w7#", "3750 #arena#", ""};
		{ 25, 34987, "", "=q4=Brutal Gladiator's Battle Staff", "=ds=#w9#", "3750 #arena#", ""};
		{ 26, 35103, "", "=q4=Brutal Gladiator's Staff", "=ds=#w9#", "3750 #arena#", ""};
		{ 27, 35109, "", "=q4=Brutal Gladiator's War Staff", "=ds=#w9#", "3750 #arena#", ""};
		Next = "Arena4Weapons2";
		Back = "PVPMENU";
	};

	AtlasLoot_Data["Arena4Weapons2"] = {
		{ 1, 34986, "", "=q4=Brutal Gladiator's Barrier", "=ds=#w8#", "1875 #arena#", ""};
		{ 2, 35073, "", "=q4=Brutal Gladiator's Redoubt", "=ds=#w8#", "1875 #arena#", ""};
		{ 3, 35094, "", "=q4=Brutal Gladiator's Shield Wall", "=ds=#w8#", "1875 #arena#", ""};
		{ 4, 35108, "", "=q4=Brutal Gladiator's War Edge", "=ds=#w11#", "1000 #arena#", ""};
		{ 5, 35047, "", "=q4=Brutal Gladiator's Longbow", "=ds=#w2#", "3750 #arena#", ""};
		{ 6, 35018, "", "=q4=Brutal Gladiator's Heavy Crossbow", "=ds=#w3#", "3750 #arena#", ""};
		{ 7, 35075, "", "=q4=Brutal Gladiator's Rifle", "=ds=#w5#", "3750 #arena#", ""};
		{ 8, 34985, "", "=q4=Brutal Gladiator's Baton of Light", "=ds=#w12#", "1000 #arena#", ""};
		{ 9, 35065, "", "=q4=Brutal Gladiator's Piercing Touch", "=ds=#w12#", "1000 #arena#", ""};
		{ 10, 35107, "", "=q4=Brutal Gladiator's Touch of Defeat", "=ds=#w12#", "1000 #arena#", ""};
		{ 11, 35008, "", "=q4=Brutal Gladiator's Endgame", "=ds=#s15#", "1125 #arena#", ""};
		{ 12, 35016, "", "=q4=Brutal Gladiator's Grimoire", "=ds=#s15#", "1125 #arena#", ""};
		{ 13, 35074, "", "=q4=Brutal Gladiator's Reprieve", "=ds=#s15#", "1125 #arena#", ""};
		{ 16, 35019, "", "=q4=Brutal Gladiator's Idol of Resolve", "=ds=#w14#", "1000 #arena#", ""};
		{ 17, 35020, "", "=q4=Brutal Gladiator's Idol of Steadfastness#w14#", "=ds=", "1000 #arena#", ""};
		{ 18, 35021, "", "=q4=Brutal Gladiator's Idol of Tenacity", "=ds=#w14#", "1000 #arena#", ""};
		{ 19, 35039, "", "=q4=Brutal Gladiator's Libram of Fortitude", "=ds=#w16#", "1000 #arena#", ""};
		{ 20, 35040, "", "=q4=Brutal Gladiator's Libram of Justice", "=ds=#w16#", "1000 #arena#", ""};
		{ 21, 35041, "", "=q4=Brutal Gladiator's Libram of Vengeance", "=ds=#w16#", "1000 #arena#", ""};
		{ 22, 35104, "", "=q4=Brutal Gladiator's Totem of Indomitability", "=ds=#w15#", "1000 #arena#", ""};
		{ 23, 35105, "", "=q4=Brutal Gladiator's Totem of Survival", "=ds=#w15#", "1000 #arena#", ""};
		{ 24, 35106, "", "=q4=Brutal Gladiator's Totem of the Third Wind", "=ds=#w15#", "1000 #arena#", ""};
		Prev = "Arena4Weapons1";
		Back = "PVPMENU";
	};

	--------------------------
	--- Sets & Collections ---
	--------------------------

		---------------------------
		--- Dungeon 3 Sets (D3) ---
		---------------------------

	AtlasLoot_Data["DS3Cloth"] = {
		{ 1, 0, "Spell_Holy_InnerFire", "=q6=#ds3s1#", ""};
		{ 2, 28413, "", "=q3=Hallowed Crown", "=ds="..BabbleBoss["Harbinger Skyriss"].." ("..BabbleZone["The Arcatraz"]..")"};
		{ 3, 27775, "", "=q3=Hallowed Pauldrons", "=ds="..BabbleBoss["Grandmaster Vorpil"].." ("..BabbleZone["Shadow Labyrinth"]..")"};
		{ 4, 28230, "", "=q3=Hallowed Garments", "=ds="..BabbleBoss["Murmur"].." ("..BabbleZone["Shadow Labyrinth"]..")"};
		{ 5, 27536, "", "=q3=Hallowed Handwraps", "=ds="..BabbleBoss["Warchief Kargath Bladefist"].." ("..BabbleZone["The Shattered Halls"]..")"};
		{ 6, 27875, "", "=q3=Hallowed Trousers", "=ds="..BabbleBoss["Talon King Ikiss"].." ("..BabbleZone["Sethekk Halls"]..")"};
		{ 8, 0, "INV_Elemental_Mote_Nether", "=q6=#ds3s3#", ""};
		{ 9, 28193, "", "=q3=Mana-Etched Crown", "=ds="..BabbleBoss["Aeonus"].." ("..BabbleZone["The Black Morass"]..")"};
		{ 10, 27796, "", "=q3=Mana-Etched Spaulders", "=ds="..BabbleBoss["Quagmirran"].." (#j3#)"};
		{ 11, 28191, "", "=q3=Mana-Etched Vestments", "=ds="..BabbleBoss["Epoch Hunter"].." ("..BabbleZone["Old Hillsbrad Foothills"]..") (#j3#)"};
		{ 12, 27465, "", "=q3=Mana-Etched Gloves", "=ds="..BabbleBoss["Omor the Unscarred"].." ("..BabbleZone["Hellfire Ramparts"]..") (#j3#)"};
		{ 13, 27907, "", "=q3=Mana-Etched Pantaloons", "=ds="..BabbleBoss["The Black Stalker"].." (#j3#)"};
		{ 16, 0, "Ability_Creature_Cursed_04", "=q6=#ds3s2#", ""};
		{ 17, 28278, "", "=q3=Incanter's Cowl", "=ds="..BabbleBoss["Pathaleon the Calculator"].." ("..BabbleZone["The Mechanar"]..")"};
		{ 18, 27738, "", "=q3=Incanter's Pauldrons", "=ds="..BabbleBoss["Warlord Kalithresh"].." ("..BabbleZone["The Steamvault"]..")"};
		{ 19, 28229, "", "=q3=Incanter's Robe", "=ds="..BabbleBoss["Warp Splinter"].." ("..BabbleZone["The Botanica"]..")"};
		{ 20, 27508, "", "=q3=Incanter's Gloves", "=ds="..BabbleBoss["Hydromancer Thespia"].." ("..BabbleZone["The Steamvault"]..")"}; 
		{ 21, 27838, "", "=q3=Incanter's Trousers", "=ds="..BabbleBoss["Talon King Ikiss"].." ("..BabbleZone["Sethekk Halls"]..")"};
		{ 23, 0, "Ability_Creature_Cursed_03", "=q6=#ds3s4#", ""};
		{ 24, 28415, "", "=q3=Hood of Oblivion", "=ds="..BabbleBoss["Harbinger Skyriss"].." ("..BabbleZone["The Arcatraz"]..")"};
		{ 25, 27778, "", "=q3=Spaulders of Oblivion", "=ds="..BabbleBoss["Murmur"].." ("..BabbleZone["Shadow Labyrinth"]..")"};
		{ 26, 28232, "", "=q3=Robe of Oblivion", "=ds="..BabbleBoss["Murmur"].." ("..BabbleZone["Shadow Labyrinth"]..")"};
		{ 27, 27537, "", "=q3=Gloves of Oblivion", "=ds="..BabbleBoss["Warchief Kargath Bladefist"].." ("..BabbleZone["The Shattered Halls"]..")"};
		{ 28, 27948, "", "=q3=Trousers of Oblivion", "=ds="..BabbleBoss["Talon King Ikiss"].." ("..BabbleZone["Sethekk Halls"]..")"};
		Next = "DS3Leather";
		Back = "DS3SET";
	};

	AtlasLoot_Data["DS3Leather"] = {
		{ 1, 0, "Ability_Rogue_SinisterCalling", "=q6=#ds3s5#", ""};
		{ 2, 28414, "", "=q3=Helm of Assassination", "=ds="..BabbleBoss["Harbinger Skyriss"].." ("..BabbleZone["The Arcatraz"]..")"};
		{ 3, 27776, "", "=q3=Shoulderpads of Assassination", "=ds="..BabbleBoss["Talon King Ikiss"].." ("..BabbleZone["Sethekk Halls"]..")"};
		{ 4, 28204, "", "=q3=Tunic of Assassination", "=ds="..BabbleBoss["Pathaleon the Calculator"].." ("..BabbleZone["The Mechanar"]..")"};
		{ 5, 27509, "", "=q3=Handgrips of Assassination", "=ds="..BabbleBoss["Aeonus"].." ("..BabbleZone["The Black Morass"]..")"};
		{ 6, 27908, "", "=q3=Leggings of Assassination", "=ds="..BabbleBoss["Murmur"].." ("..BabbleZone["Shadow Labyrinth"]..")"};
		{ 8, 0, "Ability_Hunter_RapidKilling", "=q6=#ds3s7#", ""};
		{ 9, 28224, "", "=q3=Wastewalker Helm", "=ds="..BabbleBoss["Epoch Hunter"].." ("..BabbleZone["Old Hillsbrad Foothills"]..") (#j3#)"};
		{ 10, 27797, "", "=q3=Wastewalker Shoulderpads", "=ds="..AL["Avatar"].." ("..BabbleZone["Auchenai Crypts"]..") (#j3#)"};
		{ 11, 28264, "", "=q3=Wastewalker Tunic", "=ds="..BabbleBoss["Keli'dan the Breaker"].." ("..BabbleZone["The Blood Furnace"]..") (#j3#)"};
		{ 12, 27531, "", "=q3=Wastewalker Gloves", "=ds="..BabbleBoss["Warchief Kargath Bladefist"].." ("..BabbleZone["The Shattered Halls"]..")"};
		{ 13, 27837, "", "=q3=Wastewalker Leggings", "=ds="..BabbleBoss["Nexus-Prince Shaffar"].." ("..BabbleZone["Mana-Tombs"]..") (#j3#)"};
		{ 16, 0, "Spell_Holy_SealOfRighteousness", "=q6=#ds3s6#", ""};
		{ 17, 28348, "", "=q3=Moonglade Cowl", "=ds="..BabbleBoss["Warp Splinter"].." ("..BabbleZone["The Botanica"]..")"};
		{ 18, 27737, "", "=q3=Moonglade Shoulders", "=ds="..BabbleBoss["Warlord Kalithresh"].." ("..BabbleZone["The Steamvault"]..")"};
		{ 19, 28202, "", "=q3=Moonglade Robe", "=ds="..BabbleBoss["Pathaleon the Calculator"].." ("..BabbleZone["The Mechanar"]..")"};
		{ 20, 27468, "", "=q3=Moonglade Handwraps", "=ds="..BabbleBoss["Blackheart the Inciter"].." ("..BabbleZone["Shadow Labyrinth"]..")"};
		{ 21, 27873, "", "=q3=Moonglade Pants", "=ds="..BabbleBoss["Aeonus"].." ("..BabbleZone["The Black Morass"]..")"};
		Prev = "DS3Cloth";
		Next = "DS3Mail";
		Back = "DS3SET";
	};

	AtlasLoot_Data["DS3Mail"] = {
		{ 1, 0, "Ability_Hunter_Pet_Wolf", "=q6=#ds3s8#", ""};
		{ 2, 28275, "", "=q3=Beast Lord Helm", "=ds="..BabbleBoss["Pathaleon the Calculator"].." ("..BabbleZone["The Mechanar"]..")"};
		{ 3, 27801, "", "=q3=Beast Lord Mantle", "=ds="..BabbleBoss["Warlord Kalithresh"].." ("..BabbleZone["The Steamvault"]..")"};
		{ 4, 28228, "", "=q3=Beast Lord Curiass", "=ds="..BabbleBoss["Warp Splinter"].." ("..BabbleZone["The Botanica"]..")"};
		{ 5, 27474, "", "=q3=Beast Lord Handguards", "=ds="..BabbleBoss["Warchief Kargath Bladefist"].." ("..BabbleZone["The Shattered Halls"]..")"};
		{ 6, 27874, "", "=q3=Beast Lord Leggings", "=ds="..BabbleBoss["Warlord Kalithresh"].." ("..BabbleZone["The Steamvault"]..")"};
		{ 8, 0, "INV_Helmet_70", "=q6=#ds3s10#", ""};
		{ 9, 28349, "", "=q3=Tidefury Helm", "=ds="..BabbleBoss["Warp Splinter"].." ("..BabbleZone["The Botanica"]..")"};
		{ 10, 27802, "", "=q3=Tidefury Shoulderguards", "=ds="..BabbleBoss["Warbringer O'mrogg"].." ("..BabbleZone["The Shattered Halls"]..")"};
		{ 11, 28231, "", "=q3=Tidefury Chestpiece", "=ds="..BabbleBoss["Harbinger Skyriss"].." ("..BabbleZone["The Arcatraz"]..")"};
		{ 12, 27510, "", "=q3=Tidefury Gauntlets", "=ds="..BabbleBoss["Warlord Kalithresh"].." ("..BabbleZone["The Steamvault"]..")"};
		{ 13, 27909, "", "=q3=Tidefury Kilt", "=ds="..BabbleBoss["Murmur"].." ("..BabbleZone["Shadow Labyrinth"]..")"};
		{ 16, 0, "Ability_FiegnDead", "=q6=#ds3s9#", ""};
		{ 17, 28192, "", "=q3=Helm of Desolation", "=ds="..BabbleBoss["Aeonus"].." ("..BabbleZone["The Black Morass"]..")"};
		{ 18, 27713, "", "=q3=Pauldrons of Desolation", "=ds="..BabbleBoss["Quagmirran"].." (#j3#)"};
		{ 19, 28401, "", "=q3=Hauberk of Desolation", "=ds="..BabbleBoss["Epoch Hunter"].." ("..BabbleZone["Old Hillsbrad Foothills"]..") (#j3#)"};
		{ 20, 27528, "", "=q3=Gauntlets of Desolation", "=ds="..BabbleBoss["Warchief Kargath Bladefist"].." ("..BabbleZone["The Shattered Halls"]..")"};
		{ 21, 27936, "", "=q3=Greaves of Desolation", "=ds="..BabbleBoss["Talon King Ikiss"].." ("..BabbleZone["Sethekk Halls"]..")"};
		Prev = "DS3Leather";
		Next = "DS3Plate";
		Back = "DS3SET";
	};

	AtlasLoot_Data["DS3Plate"] = {
		{ 1, 0, "Spell_Fire_EnchantWeapon", "=q6=#ds3s11#", ""};
		{ 2, 28350, "", "=q3=Warhelm of the Bold", "=ds="..BabbleBoss["Warp Splinter"].." ("..BabbleZone["The Botanica"]..")"};
		{ 3, 27803, "", "=q3=Shoulderguards of the Bold", "=ds="..BabbleBoss["Murmur"].." ("..BabbleZone["Shadow Labyrinth"]..")"};
		{ 4, 28205, "", "=q3=Breastplate of the Bold", "=ds="..BabbleBoss["Harbinger Skyriss"].." ("..BabbleZone["The Arcatraz"]..")"};
		{ 5, 27475, "", "=q3=Gauntlets of the Bold", "=ds="..BabbleBoss["Warlord Kalithresh"].." ("..BabbleZone["The Steamvault"]..")"};
		{ 6, 27977, "", "=q3=Legplates of the Bold", "=ds="..BabbleBoss["Aeonus"].." ("..BabbleZone["The Black Morass"]..")"};
		{ 8, 0, "INV_Hammer_02", "=q6=#ds3s13#", ""};
		{ 9, 28285, "", "=q3=Helm of the Righteous", "=ds="..BabbleBoss["Pathaleon the Calculator"].." ("..BabbleZone["The Mechanar"]..")"};
		{ 10, 27739, "", "=q3=Spaulders of the Righteous", "=ds="..BabbleBoss["Laj"].." ("..BabbleZone["The Botanica"]..")"};
		{ 11, 28203, "", "=q3=Breastplate of the Righteous", "=ds="..BabbleBoss["Warlord Kalithresh"].." ("..BabbleZone["The Steamvault"]..")"};
		{ 12, 27535, "", "=q3=Gauntlets of the Righteous", "=ds="..BabbleBoss["Warbringer O'mrogg"].." ("..BabbleZone["The Shattered Halls"]..")"};
		{ 13, 27839, "", "=q3=Legplates of the Righteous", "=ds="..BabbleBoss["Aeonus"].." ("..BabbleZone["The Black Morass"]..")"};
		{ 16, 0, "INV_Helmet_08", "=q6=#ds3s12#", ""};
		{ 17, 28225, "", "=q3=Doomplate Warhelm", "=ds="..BabbleBoss["Epoch Hunter"].." ("..BabbleZone["Old Hillsbrad Foothills"]..") (#j3#)"};
		{ 18, 27771, "", "=q3=Doomplate Shouldergards", "=ds="..BabbleBoss["The Black Stalker"].." (#j3#)"};
		{ 19, 28403, "", "=q3=Doomplate Chestguard", "=ds="..BabbleBoss["Harbinger Skyriss"].." ("..BabbleZone["The Arcatraz"]..")"};
		{ 20, 27497, "", "=q3=Doomplate Gauntlets", "=ds="..BabbleBoss["Keli'dan the Breaker"].." ("..BabbleZone["The Blood Furnace"]..") (#j3#)"};
		{ 21, 27870, "", "=q3=Doomplate Legguards", "=ds="..BabbleBoss["Exarch Maladaar"].." ("..BabbleZone["Auchenai Crypts"]..") (#j3#)"};
		Prev = "DS3Mail";
		Back = "DS3SET";
	};

		----------------------------
		--- Tier 4/Tier 5/Tier 6 ---
		----------------------------

	AtlasLoot_Data["T456DruidFeral"] = {
		{ 1, 0, "Ability_Druid_Maul", "=q6=#t4s1_1#", "=ec1=#m21#"};
		{ 2, 29098, "", "=q4=Stag-Helm of Malorne", "=ds="..BabbleBoss["Prince Malchezaar"].." ("..BabbleZone["Karazhan"]..")"};
		{ 3, 29100, "", "=q4=Mantle of Malorne", "=ds="..BabbleBoss["High King Maulgar"]};
		{ 4, 29096, "", "=q4=Breastplate of Malorne", "=ds="..BabbleBoss["Magtheridon"]};
		{ 5, 29097, "", "=q4=Gauntlets of Malorne", "=ds="..BabbleBoss["The Curator"].." ("..BabbleZone["Karazhan"]..")"};
		{ 6, 29099, "", "=q4=Greaves of Malorne", "=ds="..BabbleBoss["Gruul the Dragonkiller"]};
		{ 8, 0, "Ability_Druid_Maul", "=q6=#t5s1_1#", "=ec1=#m22#"};
		{ 9, 30228, "", "=q4=Nordrassil Headdress", "=ds="..BabbleBoss["Lady Vashj"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 10, 30230, "", "=q4=Nordrassil Feral-Mantle", "=ds="..BabbleBoss["Void Reaver"].." ("..BabbleZone["The Eye"]..")"};
		{ 11, 30222, "", "=q4=Nordrassil Chestplate", "=ds="..BabbleBoss["Kael'thas Sunstrider"].." ("..BabbleZone["The Eye"]..")"};
		{ 12, 30223, "", "=q4=Nordrassil Handgrips", "=ds="..BabbleBoss["Leotheras the Blind"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 13, 30229, "", "=q4=Nordrassil Feral-Kilt", "=ds="..BabbleBoss["Fathom-Lord Karathress"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 16, 0, "Ability_Druid_Maul", "=q6=#t6s1_1#", "=ec1=#m23#"};
		{ 17, 31039, "", "=q4=Thunderheart Cover", "=ds="..BabbleBoss["Archimonde"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 18, 31048, "", "=q4=Thunderheart Pauldrons", "=ds="..BabbleBoss["Mother Shahraz"].." ("..BabbleZone["Black Temple"]..")"};
		{ 19, 31042, "", "=q4=Thunderheart Chestguard", "=ds="..BabbleBoss["Illidan Stormrage"].." ("..BabbleZone["Black Temple"]..")"};
		{ 20, 34444, "", "=q4=Thunderheart Wristguards", "=ds="..BabbleBoss["Kalecgos"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 21, 31034, "", "=q4=Thunderheart Gauntlets", "=ds="..BabbleBoss["Azgalor"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 22, 34556, "", "=q4=Thunderheart Waistguard", "=ds="..BabbleBoss["Brutallus"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 23, 31044, "", "=q4=Thunderheart Leggings", "=ds="..BabbleBoss["The Illidari Council"].." ("..BabbleZone["Black Temple"]..")"};
		{ 24, 34573, "", "=q4=Thunderheart Treads", "=ds="..BabbleBoss["Felmyst"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		Back = "T456SET";
	};

	AtlasLoot_Data["T456DruidRestoration"] = {
		{ 1, 0, "Spell_Nature_Regeneration", "=q6=#t4s1_2#", "=ec1=#m21#"};
		{ 2, 29086, "", "=q4=Crown of Malorne", "=ds="..BabbleBoss["Prince Malchezaar"].." ("..BabbleZone["Karazhan"]..")"};
		{ 3, 29089, "", "=q4=Shoulderguards of Malorne", "=ds="..BabbleBoss["High King Maulgar"]};
		{ 4, 29087, "", "=q4=Chestguard of Malorne", "=ds="..BabbleBoss["Magtheridon"]};
		{ 5, 29090, "", "=q4=Handguards of Malorne", "=ds="..BabbleBoss["The Curator"].." ("..BabbleZone["Karazhan"]..")"};
		{ 6, 29088, "", "=q4=Legguards of Malorne", "=ds="..BabbleBoss["Gruul the Dragonkiller"]};
		{ 8, 0, "Spell_Nature_Regeneration", "=q6=#t5s1_2#", "=ec1=#m22#"};
		{ 9, 30219, "", "=q4=Nordrassil Headguard", "=ds="..BabbleBoss["Lady Vashj"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 10, 30221, "", "=q4=Nordrassil Life-Mantle", "=ds="..BabbleBoss["Void Reaver"].." ("..BabbleZone["The Eye"]..")"};
		{ 11, 30216, "", "=q4=Nordrassil Chestguard", "=ds="..BabbleBoss["Kael'thas Sunstrider"].." ("..BabbleZone["The Eye"]..")"};
		{ 12, 30217, "", "=q4=Nordrassil Gloves", "=ds="..BabbleBoss["Leotheras the Blind"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 13, 30220, "", "=q4=Nordrassil Life-Kilt", "=ds="..BabbleBoss["Fathom-Lord Karathress"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 16, 0, "Spell_Nature_Regeneration", "=q6=#t6s1_2#", "=ec1=#m23#"};
		{ 17, 31037, "", "=q4=Thunderheart Helmet", "=ds="..BabbleBoss["Archimonde"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 18, 31047, "", "=q4=Thunderheart Spaulders", "=ds="..BabbleBoss["Mother Shahraz"].." ("..BabbleZone["Black Temple"]..")"};
		{ 19, 31041, "", "=q4=Thunderheart Tunic", "=ds="..BabbleBoss["Illidan Stormrage"].." ("..BabbleZone["Black Temple"]..")"};
		{ 20, 34445, "", "=q4=Thunderheart Bracers", "=ds="..BabbleBoss["Kalecgos"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 21, 31032, "", "=q4=Thunderheart Gloves", "=ds="..BabbleBoss["Azgalor"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 22, 34554, "", "=q4=Thunderheart Belt", "=ds="..BabbleBoss["Brutallus"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 23, 31045, "", "=q4=Thunderheart Legguards", "=ds="..BabbleBoss["The Illidari Council"].." ("..BabbleZone["Black Temple"]..")"};
		{ 24, 34571, "", "=q4=Thunderheart Boots", "=ds="..BabbleBoss["Felmyst"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		Back = "T456SET";
	};

	AtlasLoot_Data["T456DruidBalance"] = {
		{ 1, 0, "Spell_Nature_InsectSwarm", "=q6=#t4s1_3#", "=ec1=#m21#"};
		{ 2, 29093, "", "=q4=Antlers of Malorne", "=ds="..BabbleBoss["Prince Malchezaar"].." ("..BabbleZone["Karazhan"]..")"};
		{ 3, 29095, "", "=q4=Pauldrons of Malorne", "=ds="..BabbleBoss["High King Maulgar"]};
		{ 4, 29091, "", "=q4=Chestpiece of Malorne", "=ds="..BabbleBoss["Magtheridon"]};
		{ 5, 29092, "", "=q4=Gloves of Malorne", "=ds="..BabbleBoss["The Curator"].." ("..BabbleZone["Karazhan"]..")"};
		{ 6, 29094, "", "=q4=Britches of Malorne", "=ds="..BabbleBoss["Gruul the Dragonkiller"]};
		{ 8, 0, "Spell_Nature_InsectSwarm", "=q6=#t5s1_3#", "=ec1=#m22#"};
		{ 9, 30233, "", "=q4=Nordrassil Headpiece", "=ds="..BabbleBoss["Lady Vashj"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 10, 30235, "", "=q4=Nordrassil Wrath-Mantle", "=ds="..BabbleBoss["Void Reaver"].." ("..BabbleZone["The Eye"]..")"};
		{ 11, 30231, "", "=q4=Nordrassil Chestpiece", "=ds="..BabbleBoss["Kael'thas Sunstrider"].." ("..BabbleZone["The Eye"]..")"};
		{ 12, 30232, "", "=q4=Nordrassil Gauntlets", "=ds="..BabbleBoss["Leotheras the Blind"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 13, 30234, "", "=q4=Nordrassil Wrath-Kilt", "=ds="..BabbleBoss["Fathom-Lord Karathress"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 16, 0, "Spell_Nature_InsectSwarm", "=q6=#t6s1_3#", "=ec1=#m23#"};
		{ 17, 31040, "", "=q4=Thunderheart Headguard", "=ds="..BabbleBoss["Archimonde"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 18, 31049, "", "=q4=Thunderheart Shoulderpads", "=ds="..BabbleBoss["Mother Shahraz"].." ("..BabbleZone["Black Temple"]..")"};
		{ 19, 31043, "", "=q4=Thunderheart Vest", "=ds="..BabbleBoss["Illidan Stormrage"].." ("..BabbleZone["Black Temple"]..")"};
		{ 20, 34446, "", "=q4=Thunderheart Bands", "=ds="..BabbleBoss["Kalecgos"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 21, 31035, "", "=q4=Thunderheart Handguards", "=ds="..BabbleBoss["Azgalor"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 22, 34555, "", "=q4=Thunderheart Cord", "=ds="..BabbleBoss["Brutallus"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 23, 31046, "", "=q4=Thunderheart Pants", "=ds="..BabbleBoss["The Illidari Council"].." ("..BabbleZone["Black Temple"]..")"};
		{ 24, 34572, "", "=q4=Thunderheart Footwraps", "=ds="..BabbleBoss["Felmyst"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		Back = "T456SET";
	};

	AtlasLoot_Data["T456Hunter"] = {
		{ 1, 0, "Ability_Hunter_RunningShot", "=q6=#t4s2#", "=ec1=#m21#"};
		{ 2, 29081, "", "=q4=Demon Stalker Greathelm", "=ds="..BabbleBoss["Prince Malchezaar"].." ("..BabbleZone["Karazhan"]..")"};
		{ 3, 29084, "", "=q4=Demon Stalker Shoulderguards", "=ds="..BabbleBoss["High King Maulgar"]};
		{ 4, 29082, "", "=q4=Demon Stalker Harness", "=ds="..BabbleBoss["Magtheridon"]};
		{ 5, 29085, "", "=q4=Demon Stalker Gauntlets", "=ds="..BabbleBoss["The Curator"].." ("..BabbleZone["Karazhan"]..")"};
		{ 6, 29083, "", "=q4=Demon Stalker Greaves", "=ds="..BabbleBoss["Gruul the Dragonkiller"]};
		{ 8, 0, "Ability_Hunter_RunningShot", "=q6=#t5s2#", "=ec1=#m22#"};
		{ 9, 30141, "", "=q4=Rift Stalker Helm", "=ds="..BabbleBoss["Lady Vashj"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 10, 30143, "", "=q4=Rift Stalker Mantle", "=ds="..BabbleBoss["Void Reaver"].." ("..BabbleZone["The Eye"]..")"};
		{ 11, 30139, "", "=q4=Rift Stalker Hauberk", "=ds="..BabbleBoss["Kael'thas Sunstrider"].." ("..BabbleZone["The Eye"]..")"};
		{ 12, 30140, "", "=q4=Rift Stalker Gauntlets", "=ds="..BabbleBoss["Leotheras the Blind"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 13, 30142, "", "=q4=Rift Stalker Leggings", "=ds="..BabbleBoss["Fathom-Lord Karathress"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 16, 0, "Ability_Hunter_RunningShot", "=q6=#t6s2#", "=ec1=#m23#"};
		{ 17, 31003, "", "=q4=Gronnstalker's Helmet", "=ds="..BabbleBoss["Archimonde"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 18, 31006, "", "=q4=Gronnstalker's Spaulders", "=ds="..BabbleBoss["Mother Shahraz"].." ("..BabbleZone["Black Temple"]..")"};
		{ 19, 31004, "", "=q4=Gronnstalker's Chestguard", "=ds="..BabbleBoss["Illidan Stormrage"].." ("..BabbleZone["Black Temple"]..")"};
		{ 20, 34443, "", "=q4=Gronnstalker's Bracers", "=ds="..BabbleBoss["Kalecgos"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 21, 31001, "", "=q4=Gronnstalker's Gloves", "=ds="..BabbleBoss["Azgalor"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 22, 34549, "", "=q4=Gronnstalker's Belt", "=ds="..BabbleBoss["Brutallus"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 23, 31005, "", "=q4=Gronnstalker's Leggings", "=ds="..BabbleBoss["The Illidari Council"].." ("..BabbleZone["Black Temple"]..")"};
		{ 24, 34570, "", "=q4=Gronnstalker's Boots", "=ds="..BabbleBoss["Felmyst"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		Back = "T456SET";
	};

	AtlasLoot_Data["T456Mage"] = {
		{ 1, 0, "Spell_Frost_IceStorm", "=q6=#t4s3#", "=ec1=#m21#"};
		{ 2, 29076, "", "=q4=Collar of the Aldor", "=ds="..BabbleBoss["Prince Malchezaar"].." ("..BabbleZone["Karazhan"]..")"};
		{ 3, 29079, "", "=q4=Pauldrons of the Aldor", "=ds="..BabbleBoss["High King Maulgar"]};
		{ 4, 29077, "", "=q4=Vestments of the Aldor", "=ds="..BabbleBoss["Magtheridon"]};
		{ 5, 29080, "", "=q4=Gloves of the Aldor", "=ds="..BabbleBoss["The Curator"].." ("..BabbleZone["Karazhan"]..")"};
		{ 6, 29078, "", "=q4=Legwraps of the Aldor", "=ds="..BabbleBoss["Gruul the Dragonkiller"]};
		{ 8, 0, "Spell_Frost_IceStorm", "=q6=#t5s3#", "=ec1=#m22#"};
		{ 9, 30206, "", "=q4=Cowl of Tirisfal", "=ds="..BabbleBoss["Lady Vashj"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 10, 30210, "", "=q4=Mantle of Tirisfal", "=ds="..BabbleBoss["Void Reaver"].." ("..BabbleZone["The Eye"]..")"};
		{ 11, 30196, "", "=q4=Robes of Tirisfal", "=ds="..BabbleBoss["Kael'thas Sunstrider"].." ("..BabbleZone["The Eye"]..")"};
		{ 12, 30205, "", "=q4=Gloves of Tirisfal", "=ds="..BabbleBoss["Leotheras the Blind"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 13, 30207, "", "=q4=Leggings of Tirisfal", "=ds="..BabbleBoss["Fathom-Lord Karathress"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 16, 0, "Spell_Frost_IceStorm", "=q6=#t6s3#", "=ec1=#m23#"};
		{ 17, 31056, "", "=q4=Cowl of the Tempest", "=ds="..BabbleBoss["Archimonde"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 18, 31059, "", "=q4=Mantle of the Tempest", "=ds="..BabbleBoss["Mother Shahraz"].." ("..BabbleZone["Black Temple"]..")"};
		{ 19, 31057, "", "=q4=Robes of the Tempest", "=ds="..BabbleBoss["Illidan Stormrage"].." ("..BabbleZone["Black Temple"]..")"};
		{ 20, 34447, "", "=q4=Bracers of the Tempest", "=ds="..BabbleBoss["Kalecgos"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 21, 31055, "", "=q4=Gloves of the Tempest", "=ds="..BabbleBoss["Azgalor"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 22, 34557, "", "=q4=Belt of the Tempest", "=ds="..BabbleBoss["Brutallus"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 23, 31058, "", "=q4=Leggings of the Tempest", "=ds="..BabbleBoss["The Illidari Council"].." ("..BabbleZone["Black Temple"]..")"};
		{ 24, 34574, "", "=q4=Boots of the Tempest", "=ds="..BabbleBoss["Felmyst"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		Back = "T456SET";
	};
	
	AtlasLoot_Data["T456PaladinProtection"] = {
		{ 1, 0, "Spell_Holy_SealOfMight", "=q6=#t4s4_1#", "=ec1=#m21#"};
		{ 2, 29068, "", "=q4=Justicar Faceguard", "=ds="..BabbleBoss["Prince Malchezaar"].." ("..BabbleZone["Karazhan"]..")"};
		{ 3, 29070, "", "=q4=Justicar Shoulderguards", "=ds="..BabbleBoss["High King Maulgar"]};
		{ 4, 29066, "", "=q4=Justicar Chestguard", "=ds="..BabbleBoss["Magtheridon"]};
		{ 5, 29067, "", "=q4=Justicar Handguards", "=ds="..BabbleBoss["The Curator"].." ("..BabbleZone["Karazhan"]..")"};
		{ 6, 29069, "", "=q4=Justicar Legguards", "=ds="..BabbleBoss["Gruul the Dragonkiller"]};
		{ 8, 0, "Spell_Holy_SealOfMight", "=q6=#t5s4_1#", "=ec1=#m22#"};
		{ 9, 30125, "", "=q4=Crystalforge Faceguard", "=ds="..BabbleBoss["Lady Vashj"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 10, 30127, "", "=q4=Crystalforge Shoulderguards", "=ds="..BabbleBoss["Void Reaver"].." ("..BabbleZone["The Eye"]..")"};
		{ 11, 30123, "", "=q4=Crystalforge Chestguard", "=ds="..BabbleBoss["Kael'thas Sunstrider"].." ("..BabbleZone["The Eye"]..")"};
		{ 12, 30124, "", "=q4=Crystalforge Handguards", "=ds="..BabbleBoss["Leotheras the Blind"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 13, 30126, "", "=q4=Crystalforge Legguards", "=ds="..BabbleBoss["Fathom-Lord Karathress"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 16, 0, "Spell_Holy_SealOfMight", "=q6=#t6s4_1#", "=ec1=#m23#"};
		{ 17, 30987, "", "=q4=Lightbringer Faceguard", "=ds="..BabbleBoss["Archimonde"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 18, 30998, "", "=q4=Lightbringer Shoulderguards", "=ds="..BabbleBoss["Mother Shahraz"].." ("..BabbleZone["Black Temple"]..")"};
		{ 19, 30991, "", "=q4=Lightbringer Chestguard", "=ds="..BabbleBoss["Illidan Stormrage"].." ("..BabbleZone["Black Temple"]..")"};
		{ 20, 34433, "", "=q4=Lightbringer Wristguards", "=ds="..BabbleBoss["Kalecgos"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 21, 30985, "", "=q4=Lightbringer Handguards", "=ds="..BabbleBoss["Azgalor"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 22, 34488, "", "=q4=Lightbringer Waistguard", "=ds="..BabbleBoss["Brutallus"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 23, 30995, "", "=q4=Lightbringer Legguards", "=ds="..BabbleBoss["The Illidari Council"].." ("..BabbleZone["Black Temple"]..")"};
		{ 24, 34560, "", "=q4=Lightbringer Greaves", "=ds="..BabbleBoss["Felmyst"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		Back = "T456SET";
	};

	AtlasLoot_Data["T456PaladinRetribution"] = {
		{ 1, 0, "Spell_Holy_AuraOfLight", "=q6=#t4s4_2#", "=ec1=#m21#"};
		{ 2, 29073, "", "=q4=Justicar Crown", "=ds="..BabbleBoss["Prince Malchezaar"].." ("..BabbleZone["Karazhan"]..")"};
		{ 3, 29075, "", "=q4=Justicar Shoulderplates", "=ds="..BabbleBoss["High King Maulgar"]};
		{ 4, 29071, "", "=q4=Justicar Breastplate", "=ds="..BabbleBoss["Magtheridon"]};
		{ 5, 29072, "", "=q4=Justicar Gauntlets", "=ds="..BabbleBoss["The Curator"].." ("..BabbleZone["Karazhan"]..")"};
		{ 6, 29074, "", "=q4=Justicar Greaves", "=ds="..BabbleBoss["Gruul the Dragonkiller"]};
		{ 8, 0, "Spell_Holy_AuraOfLight", "=q6=#t5s4_2#", "=ec1=#m22#"};
		{ 9, 30131, "", "=q4=Crystalforge War-Helm", "=ds="..BabbleBoss["Lady Vashj"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 10, 30133, "", "=q4=Crystalforge Shoulderbraces", "=ds="..BabbleBoss["Void Reaver"].." ("..BabbleZone["The Eye"]..")"};
		{ 11, 30129, "", "=q4=Crystalforge Breastplate", "=ds="..BabbleBoss["Kael'thas Sunstrider"].." ("..BabbleZone["The Eye"]..")"};
		{ 12, 30130, "", "=q4=Crystalforge Gauntlets", "=ds="..BabbleBoss["Leotheras the Blind"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 13, 30132, "", "=q4=Crystalforge Greaves", "=ds="..BabbleBoss["Fathom-Lord Karathress"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 16, 0, "Spell_Holy_AuraOfLight", "=q6=#t6s4_2#", "=ec1=#m23#"};
		{ 17, 30989, "", "=q4=Lightbringer War-Helm", "=ds="..BabbleBoss["Archimonde"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 18, 30997, "", "=q4=Lightbringer Shoulderbraces", "=ds="..BabbleBoss["Mother Shahraz"].." ("..BabbleZone["Black Temple"]..")"};
		{ 19, 30990, "", "=q4=Lightbringer Breastplate", "=ds="..BabbleBoss["Illidan Stormrage"].." ("..BabbleZone["Black Temple"]..")"};
		{ 20, 34431, "", "=q4=Lightbringer Bands", "=ds="..BabbleBoss["Kalecgos"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 21, 30982, "", "=q4=Lightbringer Gauntlets", "=ds="..BabbleBoss["Azgalor"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 22, 34485, "", "=q4=Lightbringer Girdle", "=ds="..BabbleBoss["Brutallus"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 23, 30993, "", "=q4=Lightbringer Greaves", "=ds="..BabbleBoss["The Illidari Council"].." ("..BabbleZone["Black Temple"]..")"};
		{ 24, 34561, "", "=q4=Lightbringer Boots", "=ds="..BabbleBoss["Felmyst"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		Back = "T456SET";
	};

	AtlasLoot_Data["T456PaladinHoly"] = {
		{ 1, 0, "Spell_Holy_HolyBolt", "=q6=#t4s4_3#", "=ec1=#m21#"};
		{ 2, 29061, "", "=q4=Justicar Diadem", "=ds="..BabbleBoss["Prince Malchezaar"].." ("..BabbleZone["Karazhan"]..")"};
		{ 3, 29064, "", "=q4=Justicar Pauldrons", "=ds="..BabbleBoss["High King Maulgar"]};
		{ 4, 29062, "", "=q4=Justicar Chestpiece", "=ds="..BabbleBoss["Magtheridon"]};
		{ 5, 29065, "", "=q4=Justicar Gloves", "=ds="..BabbleBoss["The Curator"].." ("..BabbleZone["Karazhan"]..")"};
		{ 6, 29063, "", "=q4=Justicar Leggings", "=ds="..BabbleBoss["Gruul the Dragonkiller"]};
		{ 8, 0, "Spell_Holy_HolyBolt", "=q6=#t5s4_3#", "=ec1=#m22#"};
		{ 9, 30136, "", "=q4=Crystalforge Greathelm", "=ds="..BabbleBoss["Lady Vashj"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 10, 30138, "", "=q4=Crystalforge Pauldrons", "=ds="..BabbleBoss["Void Reaver"].." ("..BabbleZone["The Eye"]..")"};
		{ 11, 30134, "", "=q4=Crystalforge Chestpiece", "=ds="..BabbleBoss["Kael'thas Sunstrider"].." ("..BabbleZone["The Eye"]..")"};
		{ 12, 30135, "", "=q4=Crystalforge Gloves", "=ds="..BabbleBoss["Leotheras the Blind"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 13, 30137, "", "=q4=Crystalforge Leggings", "=ds="..BabbleBoss["Fathom-Lord Karathress"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 16, 0, "Spell_Holy_HolyBolt", "=q6=#t6s4_3#", "=ec1=#m23#"};
		{ 17, 30988, "", "=q4=Lightbringer Greathelm", "=ds="..BabbleBoss["Archimonde"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 18, 30996, "", "=q4=Lightbringer Pauldrons", "=ds="..BabbleBoss["Mother Shahraz"].." ("..BabbleZone["Black Temple"]..")"};
		{ 19, 30992, "", "=q4=Lightbringer Chestpiece", "=ds="..BabbleBoss["Illidan Stormrage"].." ("..BabbleZone["Black Temple"]..")"};
		{ 20, 34432, "", "=q4=Lightbringer Bracers", "=ds="..BabbleBoss["Kalecgos"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 21, 30983, "", "=q4=Lightbringer Gloves", "=ds="..BabbleBoss["Azgalor"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 22, 34487, "", "=q4=Lightbringer Belt", "=ds="..BabbleBoss["Brutallus"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 23, 30994, "", "=q4=Lightbringer Leggings", "=ds="..BabbleBoss["The Illidari Council"].." ("..BabbleZone["Black Temple"]..")"};
		{ 24, 34559, "", "=q4=Lightbringer Treads", "=ds="..BabbleBoss["Felmyst"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		Back = "T456SET";
	};

	AtlasLoot_Data["T456PriestHoly"] = {
		{ 1, 0, "Spell_Holy_PowerWordShield", "=q6=#t4s5_1#", "=ec1=#m21#"};
		{ 2, 29049, "", "=q4=Light-Collar of the Incarnate", "=ds="..BabbleBoss["Prince Malchezaar"].." ("..BabbleZone["Karazhan"]..")"};
		{ 3, 29054, "", "=q4=Light-Mantle of the Incarnate", "=ds="..BabbleBoss["High King Maulgar"]};
		{ 4, 29050, "", "=q4=Robes of the Incarnate", "=ds="..BabbleBoss["Magtheridon"]};
		{ 5, 29055, "", "=q4=Handwraps of the Incarnate", "The Curator ("..BabbleZone["Karazhan"]..")"};
		{ 6, 29053, "", "=q4=Trousers of the Incarnate", "=ds="..BabbleBoss["Gruul the Dragonkiller"]};
		{ 8, 0, "Spell_Holy_PowerWordShield", "=q6=#t5s5_1#", "=ec1=#m22#"};
		{ 9, 30152, "", "=q4=Cowl of the Avatar", "=ds="..BabbleBoss["Lady Vashj"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 10, 30154, "", "=q4=Mantle of the Avatar", "=ds="..BabbleBoss["Void Reaver"].." ("..BabbleZone["The Eye"]..")"};
		{ 11, 30150, "", "=q4=Vestments of the Avatar", "=ds="..BabbleBoss["Kael'thas Sunstrider"].." ("..BabbleZone["The Eye"]..")"};
		{ 12, 30151, "", "=q4=Gloves of the Avatar", "=ds="..BabbleBoss["Leotheras the Blind"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 13, 30153, "", "=q4=Breeches of the Avatar", "=ds="..BabbleBoss["Fathom-Lord Karathress"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 16, 0, "Spell_Holy_PowerWordShield", "=q6=#t6s5_1#", "=ec1=#m23#"};
		{ 17, 31063, "", "=q4=Cowl of Absolution", "=ds="..BabbleBoss["Archimonde"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 18, 31069, "", "=q4=Mantle of Absolution", "=ds="..BabbleBoss["Mother Shahraz"].." ("..BabbleZone["Black Temple"]..")"};
		{ 19, 31066, "", "=q4=Vestments of Absolution", "=ds="..BabbleBoss["Illidan Stormrage"].." ("..BabbleZone["Black Temple"]..")"};
		{ 20, 34435, "", "=q4=Cuffs of Absolution", "=ds="..BabbleBoss["Kalecgos"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 21, 31060, "", "=q4=Gloves of Absolution", "=ds="..BabbleBoss["Azgalor"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 22, 34527, "", "=q4=Belt of Absolution", "=ds="..BabbleBoss["Brutallus"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 23, 31068, "", "=q4=Breeches of Absolution", "=ds="..BabbleBoss["The Illidari Council"].." ("..BabbleZone["Black Temple"]..")"};
		{ 24, 34562, "", "=q4=Boots of Absolution", "=ds="..BabbleBoss["Felmyst"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		Back = "T456SET";
	};

	AtlasLoot_Data["T456PriestShadow"] = {
		{ 1, 0, "Spell_Shadow_AntiShadow", "=q6=#t4s5_2#", "=ec1=#m21#"};
		{ 2, 29058, "", "=q4=Soul-Collar of the Incarnate", "=ds="..BabbleBoss["Prince Malchezaar"].." ("..BabbleZone["Karazhan"]..")"};
		{ 3, 29060, "", "=q4=Soul-Mantle of the Incarnate", "=ds="..BabbleBoss["High King Maulgar"]};
		{ 4, 29056, "", "=q4=Shroud of the Incarnate", "=ds="..BabbleBoss["Magtheridon"]};
		{ 5, 29057, "", "=q4=Gloves of the Incarnate", "=ds="..BabbleBoss["The Curator"].." ("..BabbleZone["Karazhan"]..")"};
		{ 6, 29059, "", "=q4=Leggings of the Incarnate", "=ds="..BabbleBoss["Gruul the Dragonkiller"]};
		{ 8, 0, "Spell_Shadow_AntiShadow", "=q6=#t5s5_2#", "=ec1=#m22#"};
		{ 9, 30161, "", "=q4=Hood of the Avatar", "=ds="..BabbleBoss["Lady Vashj"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 10, 30163, "", "=q4=Wings of the Avatar", "=ds="..BabbleBoss["Void Reaver"].." ("..BabbleZone["The Eye"]..")"};
		{ 11, 30159, "", "=q4=Shroud of the Avatar", "=ds="..BabbleBoss["Kael'thas Sunstrider"].." ("..BabbleZone["The Eye"]..")"};
		{ 12, 30160, "", "=q4=Handguards of the Avatar", "=ds="..BabbleBoss["Leotheras the Blind"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 13, 30162, "", "=q4=Leggings of the Avatar", "=ds="..BabbleBoss["Fathom-Lord Karathress"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 16, 0, "Spell_Shadow_AntiShadow", "=q6=#t6s5_2#", "=ec1=#m23#"};
		{ 17, 31064, "", "=q4=Hood of Absolution", "=ds="..BabbleBoss["Archimonde"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 18, 31070, "", "=q4=Shoulderpads of Absolution", "=ds="..BabbleBoss["Mother Shahraz"].." ("..BabbleZone["Black Temple"]..")"};
		{ 19, 31065, "", "=q4=Shroud of Absolution", "=ds="..BabbleBoss["Illidan Stormrage"].." ("..BabbleZone["Black Temple"]..")"};
		{ 20, 34434, "", "=q4=Bracers of Absolution", "=ds="..BabbleBoss["Kalecgos"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 21, 31061, "", "=q4=Handguards of Absolution", "=ds="..BabbleBoss["Azgalor"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 22, 34528, "", "=q4=Cord of Absolution", "=ds="..BabbleBoss["Brutallus"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 23, 31067, "", "=q4=Leggings of Absolution", "=ds="..BabbleBoss["The Illidari Council"].." ("..BabbleZone["Black Temple"]..")"};
		{ 24, 34563, "", "=q4=Treads of Absolution", "=ds="..BabbleBoss["Felmyst"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		Back = "T456SET";
	};

	AtlasLoot_Data["T456Rogue"] = {
		{ 1, 0, "Ability_BackStab", "=q6=#t4s6#", "=ec1=#m21#"};
		{ 2, 29044, "", "=q4=Netherblade Facemask", "=ds="..BabbleBoss["Prince Malchezaar"].." ("..BabbleZone["Karazhan"]..")"};
		{ 3, 29047, "", "=q4=Netherblade Shoulderpads", "=ds="..BabbleBoss["High King Maulgar"]};
		{ 4, 29045, "", "=q4=Netherblade Chestpiece", "=ds="..BabbleBoss["Magtheridon"]};
		{ 5, 29048, "", "=q4=Netherblade Gloves", "=ds="..BabbleBoss["The Curator"].." ("..BabbleZone["Karazhan"]..")"};
		{ 6, 29046, "", "=q4=Netherblade Breeches", "=ds="..BabbleBoss["Gruul the Dragonkiller"]};
		{ 8, 0, "Ability_BackStab", "=q6=#t5s6#", "=ec1=#m22#"};
		{ 9, 30146, "", "=q4=Deathmantle Helm", "=ds="..BabbleBoss["Lady Vashj"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 10, 30149, "", "=q4=Deathmantle Shoulderpads", "=ds="..BabbleBoss["Void Reaver"].." ("..BabbleZone["The Eye"]..")"};
		{ 11, 30144, "", "=q4=Deathmantle Chestguard", "=ds="..BabbleBoss["Kael'thas Sunstrider"].." ("..BabbleZone["The Eye"]..")"};
		{ 12, 30145, "", "=q4=Deathmantle Handguards", "=ds="..BabbleBoss["Leotheras the Blind"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 13, 30148, "", "=q4=Deathmantle Legguards", "=ds="..BabbleBoss["Fathom-Lord Karathress"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 16, 0, "Ability_BackStab", "=q6=#t6s6#", "=ec1=#m23#"};
		{ 17, 31027, "", "=q4=Slayer's Helm", "=ds="..BabbleBoss["Archimonde"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 18, 31030, "", "=q4=Slayer's Shoulderpads", "=ds="..BabbleBoss["Mother Shahraz"].." ("..BabbleZone["Black Temple"]..")"};
		{ 19, 31028, "", "=q4=Slayer's Chestguard", "=ds="..BabbleBoss["Illidan Stormrage"].." ("..BabbleZone["Black Temple"]..")"};
		{ 20, 34448, "", "=q4=Slayer's Bracers", "=ds="..BabbleBoss["Kalecgos"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 21, 31026, "", "=q4=Slayer's Handguards", "=ds="..BabbleBoss["Azgalor"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 22, 34558, "", "=q4=Slayer's Belt", "=ds="..BabbleBoss["Brutallus"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 23, 31029, "", "=q4=Slayer's Legguards", "=ds="..BabbleBoss["The Illidari Council"].." ("..BabbleZone["Black Temple"]..")"};
		{ 24, 34575, "", "=q4=Slayer's Boots", "=ds="..BabbleBoss["Felmyst"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		Back = "T456SET";
	};

	AtlasLoot_Data["T456ShamanEnhancement"] = {
		{ 1, 0, "Spell_FireResistanceTotem_01", "=q6=#t4s7_1#", "=ec1=#m21#"};
		{ 2, 29040, "", "=q4=Cyclone Helm", "=ds="..BabbleBoss["Prince Malchezaar"].." ("..BabbleZone["Karazhan"]..")"};
		{ 3, 29043, "", "=q4=Cyclone Shoulderplates", "=ds="..BabbleBoss["High King Maulgar"]};
		{ 4, 29038, "", "=q4=Cyclone Breastplate", "=ds="..BabbleBoss["Magtheridon"]};
		{ 5, 29039, "", "=q4=Cyclone Gauntlets", "=ds="..BabbleBoss["The Curator"].." ("..BabbleZone["Karazhan"]..")"};
		{ 6, 29042, "", "=q4=Cyclone War-Kilt", "=ds="..BabbleBoss["Gruul the Dragonkiller"]};
		{ 8, 0, "Spell_FireResistanceTotem_01", "=q6=#t5s7_1#", "=ec1=#m22#"};
		{ 9, 30190, "", "=q4=Cataclysm Helm", "=ds="..BabbleBoss["Lady Vashj"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 10, 30194, "", "=q4=Cataclysm Shoulderplates", "=ds="..BabbleBoss["Void Reaver"].." ("..BabbleZone["The Eye"]..")"};
		{ 11, 30185, "", "=q4=Cataclysm Chestplate", "=ds="..BabbleBoss["Kael'thas Sunstrider"].." ("..BabbleZone["The Eye"]..")"};
		{ 12, 30189, "", "=q4=Cataclysm Gauntlets", "=ds="..BabbleBoss["Leotheras the Blind"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 13, 30192, "", "=q4=Cataclysm Leggings", "=ds="..BabbleBoss["Fathom-Lord Karathress"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 16, 0, "Spell_FireResistanceTotem_01", "=q6=#t6s7_1#", "=ec1=#m23#"};
		{ 17, 31015, "", "=q4=Skyshatter Cover", "=ds="..BabbleBoss["Archimonde"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 18, 31024, "", "=q4=Skyshatter Pauldrons", "=ds="..BabbleBoss["Mother Shahraz"].." ("..BabbleZone["Black Temple"]..")"};
		{ 19, 31018, "", "=q4=Skyshatter Tunic", "=ds="..BabbleBoss["Illidan Stormrage"].." ("..BabbleZone["Black Temple"]..")"};
		{ 20, 34439, "", "=q4=Skyshatter Wristguards", "=ds="..BabbleBoss["Kalecgos"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 21, 31011, "", "=q4=Skyshatter Grips", "=ds="..BabbleBoss["Azgalor"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 22, 34545, "", "=q4=Skyshatter Girdle", "=ds="..BabbleBoss["Brutallus"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 23, 31021, "", "=q4=Skyshatter Pants", "=ds="..BabbleBoss["The Illidari Council"].." ("..BabbleZone["Black Temple"]..")"};
		{ 24, 34567, "", "=q4=Skyshatter Greaves", "=ds="..BabbleBoss["Felmyst"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		Back = "T456SET";
	};

	AtlasLoot_Data["T456ShamanRestoration"] = {
		{ 1, 0, "Spell_Nature_HealingWaveGreater", "=q6=#t4s7_2#", "=ec1=#m21#"};
		{ 2, 29028, "", "=q4=Cyclone Headdress", "=ds="..BabbleBoss["Prince Malchezaar"].." ("..BabbleZone["Karazhan"]..")"};
		{ 3, 29031, "", "=q4=Cyclone Shoulderpads", "=ds="..BabbleBoss["High King Maulgar"]};
		{ 4, 29029, "", "=q4=Cyclone Hauberk", "=ds="..BabbleBoss["Magtheridon"]};
		{ 5, 29032, "", "=q4=Cyclone Gloves", "=ds="..BabbleBoss["The Curator"].." ("..BabbleZone["Karazhan"]..")"};
		{ 6, 29030, "", "=q4=Cyclone Kilt", "=ds="..BabbleBoss["Gruul the Dragonkiller"]};
		{ 8, 0, "Spell_Nature_HealingWaveGreater", "=q6=#t5s7_2#", "=ec1=#m22#"};
		{ 9, 30166, "", "=q4=Cataclysm Headguard", "=ds="..BabbleBoss["Lady Vashj"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 10, 30168, "", "=q4=Cataclysm Shoulderguards", "=ds="..BabbleBoss["Void Reaver"].." ("..BabbleZone["The Eye"]..")"};
		{ 11, 30164, "", "=q4=Cataclysm Chestguard", "=ds="..BabbleBoss["Kael'thas Sunstrider"].." ("..BabbleZone["The Eye"]..")"};
		{ 12, 30165, "", "=q4=Cataclysm Gloves", "=ds="..BabbleBoss["Leotheras the Blind"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 13, 30167, "", "=q4=Cataclysm Legguards", "=ds="..BabbleBoss["Fathom-Lord Karathress"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 16, 0, "Spell_Nature_HealingWaveGreater", "=q6=#t6s7_2#", "=ec1=#m23#"};
		{ 17, 31012, "", "=q4=Skyshatter Helmet", "=ds="..BabbleBoss["Archimonde"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 18, 31022, "", "=q4=Skyshatter Shoulderpads", "=ds="..BabbleBoss["Mother Shahraz"].." ("..BabbleZone["Black Temple"]..")"};
		{ 19, 31016, "", "=q4=Skyshatter Chestguard", "=ds="..BabbleBoss["Illidan Stormrage"].." ("..BabbleZone["Black Temple"]..")"};
		{ 20, 34438, "", "=q4=Skyshatter Bracers", "=ds="..BabbleBoss["Kalecgos"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 21, 31007, "", "=q4=Skyshatter Gloves", "=ds="..BabbleBoss["Azgalor"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 22, 34543, "", "=q4=Skyshatter Belt", "=ds="..BabbleBoss["Brutallus"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 23, 31019, "", "=q4=Skyshatter Leggings", "=ds="..BabbleBoss["The Illidari Council"].." ("..BabbleZone["Black Temple"]..")"};
		{ 24, 34565, "", "=q4=Skyshatter Boots", "=ds="..BabbleBoss["Felmyst"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		Back = "T456SET";
	};

	AtlasLoot_Data["T456ShamanElemental"] = {
		{ 1, 0, "Spell_Nature_Lightning", "=q6=#t4s7_3#", "=ec1=#m21#"};
		{ 2, 29035, "", "=q4=Cyclone Faceguard", "=ds="..BabbleBoss["Prince Malchezaar"].." ("..BabbleZone["Karazhan"]..")"};
		{ 3, 29037, "", "=q4=Cyclone Shoulderguards", "=ds="..BabbleBoss["High King Maulgar"]};
		{ 4, 29033, "", "=q4=Cyclone Chestguard", "=ds="..BabbleBoss["Magtheridon"]};
		{ 5, 29034, "", "=q4=Cyclone Handguards", "=ds="..BabbleBoss["The Curator"].." ("..BabbleZone["Karazhan"]..")"};
		{ 6, 29036, "", "=q4=Cyclone Legguards", "=ds="..BabbleBoss["Gruul the Dragonkiller"]};
		{ 8, 0, "Spell_Nature_Lightning", "=q6=#t5s7_3#", "=ec1=#m22#"};
		{ 9, 30171, "", "=q4=Cataclysm Headpiece", "=ds="..BabbleBoss["Lady Vashj"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 10, 30173, "", "=q4=Cataclysm Shoulderpads", "=ds="..BabbleBoss["Void Reaver"].." ("..BabbleZone["The Eye"]..")"};
		{ 11, 30169, "", "=q4=Cataclysm Chestpiece", "=ds="..BabbleBoss["Kael'thas Sunstrider"].." ("..BabbleZone["The Eye"]..")"};
		{ 12, 30170, "", "=q4=Cataclysm Handgrips", "=ds="..BabbleBoss["Leotheras the Blind"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 13, 30172, "", "=q4=Cataclysm Legguards", "=ds="..BabbleBoss["Fathom-Lord Karathress"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 16, 0, "Spell_Nature_Lightning", "=q6=#t6s7_3#", "=ec1=#m23#"};
		{ 17, 31014, "", "=q4=Skyshatter Headguard", "=ds="..BabbleBoss["Archimonde"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 18, 31023, "", "=q4=Skyshatter Mantle", "=ds="..BabbleBoss["Mother Shahraz"].." ("..BabbleZone["Black Temple"]..")"};
		{ 19, 31017, "", "=q4=Skyshatter Breastplate", "=ds="..BabbleBoss["Illidan Stormrage"].." ("..BabbleZone["Black Temple"]..")"};
		{ 20, 34437, "", "=q4=Skyshatter Bands", "=ds="..BabbleBoss["Kalecgos"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 21, 31008, "", "=q4=Skyshatter Gauntlets", "=ds="..BabbleBoss["Azgalor"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 22, 34542, "", "=q4=Skyshatter Cord", "=ds="..BabbleBoss["Brutallus"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 23, 31020, "", "=q4=Skyshatter Legguards", "=ds="..BabbleBoss["The Illidari Council"].." ("..BabbleZone["Black Temple"]..")"};
		{ 24, 34566, "", "=q4=Skyshatter Treads", "=ds="..BabbleBoss["Felmyst"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		Back = "T456SET";
	};

	AtlasLoot_Data["T456Warlock"] = {
		{ 1, 0, "Spell_Shadow_CurseOfTounges", "=q6=#t4s8#", "=ec1=#m21#"};
		{ 2, 28963, "", "=q4=Voidheart Crown", "=ds="..BabbleBoss["Prince Malchezaar"].." ("..BabbleZone["Karazhan"]..")"};
		{ 3, 28967, "", "=q4=Voidheart Mantle", "=ds="..BabbleBoss["High King Maulgar"]};
		{ 4, 28964, "", "=q4=Voidheart Robe", "=ds="..BabbleBoss["Magtheridon"]};
		{ 5, 28968, "", "=q4=Voidheart Gloves", "=ds="..BabbleBoss["The Curator"].." ("..BabbleZone["Karazhan"]..")"};
		{ 6, 28966, "", "=q4=Voidheart Leggings", "=ds="..BabbleBoss["Gruul the Dragonkiller"]};
		{ 8, 0, "Spell_Shadow_CurseOfTounges", "=q6=#t5s8#", "=ec1=#m22#"};
		{ 9, 30212, "", "=q4=Hood of the Corruptor", "=ds="..BabbleBoss["Lady Vashj"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 10, 30215, "", "=q4=Mantle of the Corruptor", "=ds="..BabbleBoss["Void Reaver"].." ("..BabbleZone["The Eye"]..")"};
		{ 11, 30214, "", "=q4=Robe of the Corruptor", "=ds="..BabbleBoss["Kael'thas Sunstrider"].." ("..BabbleZone["The Eye"]..")"};
		{ 12, 30211, "", "=q4=Gloves of the Corruptor", "=ds="..BabbleBoss["Leotheras the Blind"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 13, 30213, "", "=q4=Leggings of the Corruptor", "=ds="..BabbleBoss["Fathom-Lord Karathress"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 16, 0, "Spell_Shadow_CurseOfTounges", "=q6=#t6s8#", "=ec1=#m23#"};
		{ 17, 31051, "", "=q4=Hood of the Malefic", "=ds="..BabbleBoss["Archimonde"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 18, 31054, "", "=q4=Mantle of the Malefic", "=ds="..BabbleBoss["Mother Shahraz"].." ("..BabbleZone["Black Temple"]..")"};
		{ 19, 31052, "", "=q4=Robe of the Malefic", "=ds="..BabbleBoss["Illidan Stormrage"].." ("..BabbleZone["Black Temple"]..")"};
		{ 20, 34436, "", "=q4=Bracers of the Malefic", "=ds="..BabbleBoss["Kalecgos"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 21, 31050, "", "=q4=Gloves of the Malefic", "=ds="..BabbleBoss["Azgalor"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 22, 34541, "", "=q4=Belt of the Malefic", "=ds="..BabbleBoss["Brutallus"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 23, 31053, "", "=q4=Leggings of the Malefic", "=ds="..BabbleBoss["The Illidari Council"].." ("..BabbleZone["Black Temple"]..")"};
		{ 24, 34564, "", "=q4=Boots of the Malefic", "=ds="..BabbleBoss["Felmyst"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		Back = "T456SET";
	};

	AtlasLoot_Data["T456WarriorProtection"] = {
		{ 1, 0, "INV_Shield_05", "=q6=#t4s9_1#", "=ec1=#m21#"};
		{ 2, 29011, "", "=q4=Warbringer Greathelm", "=ds="..BabbleBoss["Prince Malchezaar"].." ("..BabbleZone["Karazhan"]..")"};
		{ 3, 29016, "", "=q4=Warbringer Shoulderguards", "=ds="..BabbleBoss["High King Maulgar"]};
		{ 4, 29012, "", "=q4=Warbringer Chestguard", "=ds="..BabbleBoss["Magtheridon"]};
		{ 5, 29017, "", "=q4=Warbringer Handguards", "=ds="..BabbleBoss["The Curator"].." ("..BabbleZone["Karazhan"]..")"};
		{ 6, 29015, "", "=q4=Warbringer Legguards", "=ds="..BabbleBoss["Gruul the Dragonkiller"]};
		{ 8, 0, "INV_Shield_05", "=q6=#t5s9_1#", "=ec1=#m22#"};
		{ 9, 30115, "", "=q4=Destroyer Greathelm", "=ds="..BabbleBoss["Lady Vashj"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 10, 30117, "", "=q4=Destroyer Shoulderguards", "=ds="..BabbleBoss["Void Reaver"].." ("..BabbleZone["The Eye"]..")"};
		{ 11, 30113, "", "=q4=Destroyer Chestguard", "=ds="..BabbleBoss["Kael'thas Sunstrider"].." ("..BabbleZone["The Eye"]..")"};
		{ 12, 30114, "", "=q4=Destroyer Handguards", "=ds="..BabbleBoss["Leotheras the Blind"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 13, 30116, "", "=q4=Destroyer Legguards", "=ds="..BabbleBoss["Fathom-Lord Karathress"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 16, 0, "INV_Shield_05", "=q6=#t6s9_1#", "=ec1=#m23#"};
		{ 17, 30974, "", "=q4=Onslaught Greathelm", "=ds="..BabbleBoss["Archimonde"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 18, 30980, "", "=q4=Onslaught Shoulderguards", "=ds="..BabbleBoss["Mother Shahraz"].." ("..BabbleZone["Black Temple"]..")"};
		{ 19, 30976, "", "=q4=Onslaught Chestguard", "=ds="..BabbleBoss["Illidan Stormrage"].." ("..BabbleZone["Black Temple"]..")"};
		{ 20, 34442, "", "=q4=Onslaught Wristguards", "=ds="..BabbleBoss["Kalecgos"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 21, 30970, "", "=q4=Onslaught Handguards", "=ds="..BabbleBoss["Azgalor"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 22, 34547, "", "=q4=Onslaught Waistguard", "=ds="..BabbleBoss["Brutallus"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 23, 30978, "", "=q4=Onslaught Legguards", "=ds="..BabbleBoss["The Illidari Council"].." ("..BabbleZone["Black Temple"]..")"};
		{ 24, 34568, "", "=q4=Onslaught Boots", "=ds="..BabbleBoss["Felmyst"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		Back = "T456SET";
	};

	AtlasLoot_Data["T456WarriorFury"] = {
		{ 1, 0, "Ability_Warrior_BattleShout", "=q6=#t4s9_2#", "=ec1=#m21#"};
		{ 2, 29021, "", "=q4=Warbringer Battle-Helm", "=ds="..BabbleBoss["Prince Malchezaar"].." ("..BabbleZone["Karazhan"]..")"};
		{ 3, 29023, "", "=q4=Warbringer Shoulderplates", "=ds="..BabbleBoss["High King Maulgar"]};
		{ 4, 29019, "", "=q4=Warbringer Breastplate", "=ds="..BabbleBoss["Magtheridon"]};
		{ 5, 29020, "", "=q4=Warbringer Gauntlets", "=ds="..BabbleBoss["The Curator"].." ("..BabbleZone["Karazhan"]..")"};
		{ 6, 29022, "", "=q4=Warbringer Greaves", "=ds="..BabbleBoss["Gruul the Dragonkiller"]};
		{ 8, 0, "Ability_Warrior_BattleShout", "=q6=#t5s9_2#", "=ec1=#m22#"};
		{ 9, 30120, "", "=q4=Destroyer Battle-Helm", "=ds="..BabbleBoss["Lady Vashj"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 10, 30122, "", "=q4=Destroyer Shoulderblades", "=ds="..BabbleBoss["Void Reaver"].." ("..BabbleZone["The Eye"]..")"};
		{ 11, 30118, "", "=q4=Destroyer Breastplate", "=ds="..BabbleBoss["Kael'thas Sunstrider"].." ("..BabbleZone["The Eye"]..")"};
		{ 12, 30119, "", "=q4=Destroyer Gauntlets", "=ds="..BabbleBoss["Leotheras the Blind"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 13, 30121, "", "=q4=Destroyer Greaves", "=ds="..BabbleBoss["Fathom-Lord Karathress"].." ("..BabbleZone["Serpentshrine Cavern"]..")"};
		{ 16, 0, "Ability_Warrior_BattleShout", "=q6=#t6s9_2#", "=ec1=#m23#"};
		{ 17, 30972, "", "=q4=Onslaught Battle-Helm", "=ds="..BabbleBoss["Archimonde"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 18, 30979, "", "=q4=Onslaught Shoulderblades", "=ds="..BabbleBoss["Mother Shahraz"].." ("..BabbleZone["Black Temple"]..")"};
		{ 19, 30975, "", "=q4=Onslaught Breastplate", "=ds="..BabbleBoss["Illidan Stormrage"].." ("..BabbleZone["Black Temple"]..")"};
		{ 20, 34441, "", "=q4=Onslaught Bracers", "=ds="..BabbleBoss["Kalecgos"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 21, 30969, "", "=q4=Onslaught Gauntlets", "=ds="..BabbleBoss["Azgalor"].." ("..BabbleZone["Hyjal Summit"]..")"};
		{ 22, 34546, "", "=q4=Onslaught Belt", "=ds="..BabbleBoss["Brutallus"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		{ 23, 30977, "", "=q4=Onslaught Greaves", "=ds="..BabbleBoss["The Illidari Council"].." ("..BabbleZone["Black Temple"]..")"};
		{ 24, 34569, "", "=q4=Onslaught Treads", "=ds="..BabbleBoss["Felmyst"].." ("..BabbleZone["Sunwell Plateau"]..")"};
		Back = "T456SET";
	};

		--------------------------------
		--- The Burning Crusade Sets ---
		--------------------------------

	AtlasLoot_Data["TBCSets"] = {
		{ 1, 0, "INV_Box_01", "=q6=#bcs3#", "=q1=#z7#"};
		{ 2, 34703, "", "=q3=Latro's Dancing Blade", "=ds=#h1#, #w10#, =q2=#n138# (#z30#)", "", ""};
		{ 3, 28189, "", "=q3=Latro's Shifting Sword", "=ds=#h1#, #w10#, =q2=#n139# (#z33#)", "", ""};
		{ 5, 0, "INV_Box_01", "=q6=#bcs1#", "=q1=#z17#"};
		{ 6, 31338, "", "=q4=Charlotte's Ivy", "=ds=#s2#", "", "0.01%"};
		{ 7, 31339, "", "=q4=Lola's Eve", "=ds=#s13#", "", "0.01%"};
		{ 16, 0, "INV_Box_01", "=q6=#bcs4#", "=q2=#n11#, =q1=#z34#"};
		{ 17, 32946, "", "=q4=Claw of Molten Fury", "=ds=#h3#, #w13#"};
		{ 18, 32945, "", "=q4=Fist of Molten Fury", "=ds=#h4#, #w13#"};
		{ 20, 0, "INV_Box_01", "=q6=#bcs2#", "=q2=#n137#, =q1=#z18#"};
		{ 21, 32837, "", "=q5=Warglaive of Azzinoth", "=ds=#h3#, #w10#, =q1=#m1# =ds=#c9#, #c6#"};
		{ 22, 32838, "", "=q5=Warglaive of Azzinoth", "=ds=#h4#, #w10#, =q1=#m1# =ds=#c9#, #c6#"};
		Back = "SETSBURNINGCURSADE";
	};

		--------------------------------
		--- Badge of Justice Rewards ---
		--------------------------------

	AtlasLoot_Data["HardModeCloth"] = {
		{ 1, 0, "INV_Box_01", "=q6=#z31#", ""};
		{ 2, 32090, "", "=q4=Cowl of Naaru Blessings", "=ds=#s1#", "50 #heroic#", ""};
		{ 3, 32089, "", "=q4=Mana-Binders Cowl", "=ds=#s1#", "50 #heroic#", ""};
		{ 4, 33588, "", "=q4=Runed Spell-cuffs", "=ds=#s8#", "35 #heroic#", ""};
		{ 5, 33589, "", "=q4=Wristguards of Tranquil Thought", "=ds=#s8#", "35 #heroic#", ""};
		{ 6, 33587, "", "=q4=Light-Blessed Bonds", "=ds=#s9#", "60 #heroic#", ""};
		{ 7, 33586, "", "=q4=Studious Wraps", "=ds=#s9#", "60 #heroic#", ""};
		{ 8, 33291, "", "=q4=Voodoo-woven Belt", "=ds=#s10#", "60 #heroic#", ""};
		{ 9, 33585, "", "=q4=Achromic Trousers of the Naaru", "=ds=#s11#", "75 #heroic#", ""};
		{ 10, 33584, "", "=q4=Pantaloons of Arcane Annihilation", "=ds=#s11#", "75 #heroic#", ""};
		{ 16, 0, "INV_Box_01", "=q6=#z32#", ""};
		{ 17, 34924, "", "=q4=Gown of Spiritual Wonder", "=ds=#s5#", "100 #heroic#", ""};
		{ 18, 34917, "", "=q4=Shroud of the Lore`nial", "=ds=#s5#", "100 #heroic#", ""};
		{ 19, 34936, "", "=q4=Tormented Demonsoul Robes", "=ds=#s5#", "100 #heroic#", ""};
		{ 20, 34938, "", "=q4=Enslaved Doomguard Soulgrips", "=ds=#s9#", "75 #heroic#", ""};
		{ 21, 34925, "", "=q4=Adorned Supernal Legwraps", "=ds=#s11#", "100 #heroic#", ""};
		{ 22, 34937, "", "=q4=Corrupted Soulcloth Pantaloons", "=ds=#s11#", "100 #heroic#", ""};
		{ 23, 34918, "", "=q4=Legwraps of Sweltering Flame", "=ds=#s11#", "100 #heroic#", ""};
		{ 24, 34919, "", "=q4=Boots of Incantations", "=ds=#s12#", "75 #heroic#", ""};
		{ 25, 34926, "", "=q4=Slippers of Dutiful Mending", "=ds=#s12#", "75 #heroic#", ""};
		Back = "70TOKENMENU";
	};

	AtlasLoot_Data["HardModeLeather"] = {
		{ 1, 0, "INV_Box_01", "=q6=#z31#", ""};
		{ 2, 32088, "", "=q4=Cowl of Beastly Rage", "=ds=#s1#", "50 #heroic#", ""};
		{ 3, 33972, "", "=q4=Mask of Primal Power", "=ds=#s1#", "75 #heroic#", ""};
		{ 4, 32087, "", "=q4=Mask of the Deceiver", "=ds=#s1#", "50 #heroic#", ""};
		{ 5, 33287, "", "=q4=Gnarled Ironwood Pauldrons", "=ds=#s3#", "60 #heroic#", ""};
		{ 6, 33973, "", "=q4=Pauldrons of Tribal Fury", "=ds=#s3#", "60 #heroic#", ""};
		{ 7, 33566, "", "=q4=Blessed Elunite Coverings", "=ds=#s5#", "75 #heroic#", ""};
		{ 8, 33579, "", "=q4=Vestments of Hibernation", "=ds=#s5#", "75 #heroic#", ""};
		{ 9, 33578, "", "=q4=Armwraps of the Kaldorei Protector", "=ds=#s8#", "35 #heroic#", ""};
		{ 10, 33580, "", "=q4=Band of the Swift Paw", "=ds=#s8#", "35 #heroic#", ""};
		{ 11, 33557, "", "=q4=Gargon's Bracers Peaceful Slumber", "=ds=#s8#", "35 #heroic#", ""};
		{ 12, 33540, "", "=q4=Master Assassin Wristwraps", "=ds=#s8#", "35 #heroic#", ""};
		{ 13, 33974, "", "=q4=Grasp of the Moonkin", "=ds=#s9#", "60 #heroic#", ""};
		{ 14, 33539, "", "=q4=Trickster's Stickyfingers", "=ds=#s9#", "60 #heroic#", ""};
		{ 15, 33559, "", "=q4=Starfire Waistband", "=ds=#s10#", "60 #heroic#", ""};
		{ 17, 33583, "", "=q4=Waistguard of the Great Beast", "=ds=#s10#", "60 #heroic#", ""};
		{ 18, 33552, "", "=q4=Pants of Splendid Recovery", "=ds=#s11#", "75 #heroic#", ""};
		{ 19, 33538, "", "=q4=Shallow-grave Trousers", "=ds=#s11#", "75 #heroic#", ""};
		{ 20, 33582, "", "=q4=Footwraps of Wild Encroachment", "=ds=#s12#", "60 #heroic#", ""};
		{ 21, 33577, "", "=q4=Moon-walkers", "=ds=#s12#", "60 #heroic#", ""};
		{ 22, 33222, "", "=q4=Nyn'jah's Tabi Boots", "=ds=#s12#", "60 #heroic#", ""};
		Next = "HardModeLeather2";
		Back = "70TOKENMENU";
	};

	AtlasLoot_Data["HardModeLeather2"] = {
		{ 1, 0, "INV_Box_01", "=q6=#z32#", ""};
		{ 2, 34906, "", "=q4=Embrace of Everlasting Prowess", "=ds=#s5#", "100 #heroic#", ""};
		{ 3, 34903, "", "=q4=Embrace of Starlight", "=ds=#s5#", "100 #heroic#", ""};
		{ 4, 34900, "", "=q4=Shroud of Nature's Harmony", "=ds=#s5#", "100 #heroic#", ""};
		{ 5, 34927, "", "=q4=Tunic of the Dark Hour", "=ds=#s5#", "100 #heroic#", ""};
		{ 6, 34904, "", "=q4=Barbed Gloves of the Sage", "=ds=#s9#", "75 #heroic#", ""};
		{ 7, 34911, "", "=q4=Handwraps of the Aggressor", "=ds=#s9#", "75 #heroic#", ""};
		{ 8, 34902, "", "=q4=Oakleaf-Spun Handguards", "=ds=#s9#", "75 #heroic#", ""};
		{ 9, 34929, "", "=q4=Belt of the Silent Path", "=ds=#s10#", "75 #heroic#", ""};
		{ 10, 34905, "", "=q4=Crystalwind Leggings", "=ds=#s11#", "100 #heroic#", ""};
		{ 11, 34901, "", "=q4=Grovewalker's Leggings", "=ds=#s11#", "100 #heroic#", ""};
		{ 12, 34910, "", "=q4=Tameless Breeches", "=ds=#s11#", "100 #heroic#", ""};
		{ 13, 34928, "", "=q4=Trousers of the Scryers' Retainer", "=ds=#s11#", "100 #heroic#", ""};
		Prev = "HardModeLeather";
		Back = "70TOKENMENU";
	};

	AtlasLoot_Data["HardModeMail"] = {
		{ 1, 0, "INV_Box_01", "=q6=#z31#", ""};
		{ 2, 32086, "", "=q4=Storm Master's Helmet", "=ds=#s1#, #a3#", "50 #heroic#", ""};
		{ 3, 32085, "", "=q4=Warpstalker Helm", "=ds=#s1#, #a3#", "50 #heroic#", ""};
		{ 4, 33970, "", "=q4=Pauldrons of the Furious Elements", "=ds=#s3#, #a3#", "60 #heroic#", ""};
		{ 5, 33965, "", "=q4=Hauberk of the Furious Elements", "=ds=#s5#, #a3#", "75 #heroic#", ""};
		{ 6, 33535, "", "=q4=Earthquake Bracers", "=ds=#s8#, #a3#", "35 #heroic#", ""};
		{ 7, 33532, "", "=q4=Gleaming Earthen Bracers", "=ds=#s8#, #a3#", "35 #heroic#", ""};
		{ 8, 33529, "", "=q4=Steadying Bracers", "=ds=#s8#, #a3#", "35 #heroic#", ""};
		{ 9, 33528, "", "=q4=Gauntlets of Sniping", "=ds=#s9#, #a3#", "60 #heroic#", ""};
		{ 10, 33534, "", "=q4=Grips of Nature's Wrath", "=ds=#s9#, #a3#", "60 #heroic#", ""};
		{ 11, 33531, "", "=q4=Polished Waterscale Gloves", "=ds=#s9#, #a3#", "60 #heroic#", ""};
		{ 12, 33386, "", "=q4=Man'kin'do's Belt", "=ds=#s10#, #a3#", "60 #heroic#", ""};
		{ 13, 33536, "", "=q4=Stormwrap", "=ds=#s10#, #a3#", "60 #heroic#", ""};
		{ 14, 33280, "", "=q4=War-Feathered Loop", "=ds=#s10#, #a3#", "60 #heroic#", ""};
		{ 15, 33530, "", "=q4=Natural Life Leggings", "=ds=#s11#, #a3#", "75 #heroic#", ""};
		{ 16, 33527, "", "=q4=Shifting Camouflage Pants", "=ds=#s11#, #a3#", "75 #heroic#", ""};
		{ 17, 33537, "", "=q4=Treads of Booming Thunder", "=ds=#s12#, #a3#", "60 #heroic#", ""};
		{ 18, 33324, "", "=q4=Treads of Life Path", "=ds=#s12#, #a3#", "60 #heroic#", ""};
		{ 21, 0, "INV_Box_01", "=q6=#z32#", ""};
		{ 22, 34933, "", "=q4=Hauberk of Whirling Fury", "=ds=#s5#", "100 #heroic#", ""};
		{ 23, 34912, "", "=q4=Scaled Drakeskin Chestguard", "=ds=#s5#", "100 #heroic#", ""};
		{ 24, 34930, "", "=q4=Wave of Life Chestguard", "=ds=#s5#", "100 #heroic#", ""};
		{ 25, 34916, "", "=q4=Gauntlets of Rapidity", "=ds=#s9#", "75 #heroic#", ""};
		{ 26, 34935, "", "=q4=Aftershock Waistguard", "=ds=#s10#", "75 #heroic#", ""};
		{ 27, 34932, "", "=q4=Clutch of the Soothing Breeze", "=ds=#s10#", "75 #heroic#", ""};
		{ 28, 34914, "", "=q4=Leggings of the Pursuit", "=ds=#s11#", "100 #heroic#", ""};
		{ 29, 34931, "", "=q4=Runed Scales of Antiquity", "=ds=#s11#", "100 #heroic#", ""};
		{ 30, 34934, "", "=q4=Rushing Storm Kilt", "=ds=#s11#", "100 #heroic#", ""};
		Back = "70TOKENMENU";
	};

	AtlasLoot_Data["HardModePlate"] = {
		{ 1, 0, "INV_Box_01", "=q6=#z31#", ""};
		{ 2, 33810, "", "=q4=Amani Mask of Death", "=ds=#s1#, #a4#", "75 #heroic#", ""};
		{ 3, 32083, "", "=q4=Faceguard of Determination", "=ds=#s1#, #a4#", "50 #heroic#", ""};
		{ 4, 32084, "", "=q4=Helmet of the Steadfast Champion", "=ds=#s1#, #a4#", "50 #heroic#", ""};
		{ 5, 33514, "", "=q4=Pauldrons of Gruesome Fate", "=ds=#s3#, #a4#", "60 #heroic#", ""};
		{ 6, 33522, "", "=q4=Chestguard of the Stoic Guardian", "=ds=#s5#, #a4#", "75 #heroic#", ""};
		{ 7, 33516, "", "=q4=Bracers of the Ancient Phalanx", "=ds=#s8#, #a4#", "35 #heroic#", ""};
		{ 8, 33513, "", "=q4=Eternium Rage-shackles", "=ds=#s8#, #a4#", "35 #heroic#", ""};
		{ 9, 33520, "", "=q4=Vambraces of the Naaru", "=ds=#s8#, #a4#", "35 #heroic#", ""};
		{ 10, 33517, "", "=q4=Bonefist Gauntlets", "=ds=#s9#, #a4#", "60 #heroic#", ""};
		{ 11, 33512, "", "=q4=Furious Deathgrips", "=ds=#s9#, #a4#", "60 #heroic#", ""};
		{ 12, 33519, "", "=q4=Handguards of the Templar", "=ds=#s9#, #a4#", "60 #heroic#", ""};
		{ 13, 33331, "", "=q4=Chain of Unleashed Rage", "=ds=#s10#, #a4#", "60 #heroic#", ""};
		{ 14, 33524, "", "=q4=Girdle of the Protector", "=ds=#s10#, #a4#", "60 #heroic#", ""};
		{ 15, 33279, "", "=q4=Iron-tusk Girdle", "=ds=#s10#, #a4#", "60 #heroic#", ""};
		{ 17, 33501, "", "=q4=Bloodthirster's Greaves", "=ds=#s11#, #a4#", "75 #heroic#", ""};
		{ 18, 33518, "", "=q4=High Justicar's Legplates", "=ds=#s11#, #a4#", "75 #heroic#", ""};
		{ 19, 33515, "", "=q4=Unwavering Legguards", "=ds=#s11#, #a4#", "75 #heroic#", ""};
		{ 20, 33207, "", "=q4=Implacable Guardian Sabatons", "=ds=#s12#, #a4#", "60 #heroic#", ""};
		{ 21, 33523, "", "=q4=Sabatons of the Righteous Defender", "=ds=#s12#, #a4#", "60 #heroic#", ""};
		Next = "HardModePlate2";
		Back = "70TOKENMENU";
	};

	AtlasLoot_Data["HardModePlate2"] = {
		{ 1, 0, "INV_Box_01", "=q6=#z32#", ""};
		{ 2, 34942, "", "=q4=Breastplate of Ire", "=ds=#s5#", "100 #heroic#", ""};
		{ 3, 34939, "", "=q4=Chestplate of Stoicism", "=ds=#s5#", "100 #heroic#", ""};
		{ 4, 34921, "", "=q4=Ecclesiastical Cuirass", "=ds=#s5#", "100 #heroic#", ""};
		{ 5, 34945, "", "=q4=Shattrath Protectorate's Breastplate", "=ds=#s5#", "100 #heroic#", ""};
		{ 6, 34944, "", "=q4=Girdle of Seething Rage", "=ds=#s10#", "75 #heroic#", ""};
		{ 7, 34941, "", "=q4=Girdle of the Fearless", "=ds=#s10#", "75 #heroic#", ""};
		{ 8, 34923, "", "=q4=Waistguard of Reparation", "=ds=#s10#", "75 #heroic#", ""};
		{ 9, 34922, "", "=q4=Greaves of Pacification", "=ds=#s11#", "100 #heroic#", ""};
		{ 10, 34946, "", "=q4=Inscribed Legplates of the Aldor", "=ds=#s11#", "100 #heroic#", ""};
		{ 11, 34943, "", "=q4=Legplates of Unending Fury", "=ds=#s11#", "100 #heroic#", ""};
		{ 12, 34940, "", "=q4=Sunguard Legplates", "=ds=#s11#", "100 #heroic#", ""};
		{ 13, 34947, "", "=q4=Blue's Greaves of the Righteous Guardian", "=ds=#s12#", "75 #heroic#", ""};
		Prev = "HardModePlate";
		Back = "70TOKENMENU";
	};

	AtlasLoot_Data["HardModeResist"] = {
		{ 1, 0, "INV_Box_01", "=q6=#a1#", ""};
		{ 2, 30762, "", "=q4=Infernoweave Robe", "=ds=#a1#, #s5#", "30 #heroic#", ""};
		{ 3, 30764, "", "=q4=Infernoweave Gloves", "=ds=#a1#, #s9#", "20 #heroic#", ""};
		{ 4, 30761, "", "=q4=Infernoweave Leggings", "=ds=#a1#, #s11#", "30 #heroic#", ""};
		{ 5, 30763, "", "=q4=Infernoweave Boots", "=ds=#a1#, #s12#", "20 #heroic#", ""};
		{ 7, 0, "INV_Box_01", "=q6=#a2#", ""};
		{ 8, 30776, "", "=q4=Inferno Hardened Chestguard", "=ds=#a2#, #s5#", "30 #heroic#", ""};
		{ 9, 30780, "", "=q4=Inferno Hardened Gloves", "=ds=#a2#, #s9#", "20 #heroic#", ""};
		{ 10, 30778, "", "=q4=Inferno Hardened Leggings", "=ds=#a2#, #s11#", "30 #heroic#", ""};
		{ 11, 30779, "", "=q4=Inferno Hardened Boots", "=ds=#a2#, #s12#", "20 #heroic#", ""};
		{ 13, 29434, "", "=q4=Badge of Justice", "=ds=#m17#"};
		{ 16, 0, "INV_Box_01", "=q6=#a3#", ""};
		{ 17, 30773, "", "=q4=Inferno Forged Hauberk", "=ds=#a3#, #s5#", "30 #heroic#", ""};
		{ 18, 30774, "", "=q4=Inferno Forged Gloves", "=ds=#a3#, #s9#", "20 #heroic#", ""};
		{ 19, 30772, "", "=q4=Inferno Forged Leggings", "=ds=#a3#, #s11#", "30 #heroic#", ""};
		{ 20, 30770, "", "=q4=Inferno Forged Boots", "=ds=#a3#, #s12#", "20 #heroic#", ""};
		{ 22, 0, "INV_Box_01", "=q6=#a4#", ""};
		{ 23, 30769, "", "=q4=Inferno Tempered Chestguard", "=ds=#a4#, #s5#", "30 #heroic#", ""};
		{ 24, 30767, "", "=q4=Inferno Tempered Gauntlets", "=ds=#a4#, #s9#", "20 #heroic#", ""};
		{ 25, 30766, "", "=q4=Inferno Tempered Leggings", "=ds=#a4#, #s11#", "30 #heroic#", ""};
		{ 26, 30768, "", "=q4=Inferno Tempered Boots", "=ds=#a4#, #s12#", "20 #heroic#", ""};
		Back = "70TOKENMENU";
	};

	AtlasLoot_Data["HardModeCloaks"] = {
		{ 1, 0, "INV_Box_01", "=q6=#z31#", ""};
		{ 2, 29375, "", "=q4=Bishop's Cloak", "=ds=#s4#", "25 #heroic#", ""};
		{ 3, 29382, "", "=q4=Blood Knight War Cloak", "=ds=#s4#", "25 #heroic#", ""};
		{ 4, 35321, "", "=q4=Cloak of Arcane Alacrity", "=ds=#s4#", "60 #heroic#", ""};
		{ 5, 33304, "", "=q4=Cloak of Subjugated Power", "=ds=#s4#", "60 #heroic#", ""};
		{ 6, 35324, "", "=q4=Cloak of Swift Reprieve", "=ds=#s4#", "60 #heroic#", ""};
		{ 7, 33484, "", "=q4=Dory's Embrace", "=ds=#s4#", "60 #heroic#", ""};
		{ 8, 29385, "", "=q4=Farstrider Defender's Cloak", "=ds=#s4#", "25 #heroic#", ""};
		{ 9, 33333, "", "=q4=Kharmaa's Shroud of Hope", "=ds=#s4#", "60 #heroic#", ""};
		{ 10, 29369, "", "=q4=Shawl of Shifting Probabilities", "=ds=#s4#", "25 #heroic#", ""};
		{ 11, 33593, "", "=q4=Slikk's Cloak of Placation", "=ds=#s4#", "35 #heroic#", ""};
		Back = "70TOKENMENU";
	};

	AtlasLoot_Data["HardModeRelic"] = {
		{ 1, 0, "INV_Box_01", "=q6=#z31#", ""};
		{ 2, 29390, "", "=q4=Everbloom Idol", "=ds=#s16#, #w14#", "15 #heroic#", ""};
		{ 3, 33508, "", "=q4=Idol of Budding Life", "=ds=#s16#, #w14#", "20 #heroic#", ""};
		{ 4, 33509, "", "=q4=Idol of Terror", "=ds=#s16#, #w14#", "20 #heroic#", ""};
		{ 5, 33510, "", "=q4=Idol of the Unseen Moon", "=ds=#s16#, #w14#", "20 #heroic#", ""};
		{ 7, 33506, "", "=q4=Skycall Totem", "=ds=#s16#, #w15#", "20 #heroic#", ""};
		{ 8, 33507, "", "=q4=Stonebreaker's Totem", "=ds=#s16#, #w15#", "20 #heroic#", ""};
		{ 9, 33505, "", "=q4=Totem of Living Water", "=ds=#s16#, #w15#", "20 #heroic#", ""};
		{ 10, 29389, "", "=q4=Totem of the Pulsing Earth", "=ds=#s16#, #w15#", "15 #heroic#", ""};
		{ 17, 33503, "", "=q4=Libram of Divine Judgement", "=ds=#s16#, #w16#", "20 #heroic#", ""};
		{ 18, 33504, "", "=q4=Libram of Divine Purpose", "=ds=#s16#, #w16#", "20 #heroic#", ""};
		{ 19, 33502, "", "=q4=Libram of Mending", "=ds=#s16#, #w16#", "20 #heroic#", ""};
		{ 20, 29388, "", "=q4=Libram of Repentance", "=ds=#s16#, #w16#", "15 #heroic#", ""};
		Back = "70TOKENMENU";
	};

	AtlasLoot_Data["HardModeArena"] = {
		{ 1, 32811, "", "=q4=Veteran's Dreadweave Cuffs", "=ds=#s8#, #a1#", "25 #heroic#", ""};
		{ 2, 32799, "", "=q4=Veteran's Dreadweave Belt", "=ds=#s10#, #a1#", "40 #heroic#", ""};
		{ 3, 32787, "", "=q4=Veteran's Dreadweave Stalkers", "=ds=#s12#, #a1#", "40 #heroic#", ""};
		{ 5, 32980, "", "=q4=Veteran's Mooncloth Cuffs", "=ds=#s8#, #a1#", "25 #heroic#", ""};
		{ 6, 32979, "", "=q4=Veteran's Mooncloth Belt", "=ds=#s10#, #a1#", "40 #heroic#", ""};
		{ 7, 32981, "", "=q4=Veteran's Mooncloth Slippers", "=ds=#s12#, #a1#", "40 #heroic#", ""};
		{ 9, 32820, "", "=q4=Veteran's Silk Cuffs", "=ds=#s8#, #a1#", "25 #heroic#", ""};
		{ 10, 32807, "", "=q4=Veteran's Silk Belt", "=ds=#s10#, #a1#", "40 #heroic#", ""};
		{ 11, 32795, "", "=q4=Veteran's Silk Footguards", "=ds=#s12#, #a1#", "40 #heroic#", ""};
		{ 16, 32810, "", "=q4=Veteran's Dragonhide Bracers", "=ds=#s8#, #a2#", "25 #heroic#", ""};
		{ 17, 32798, "", "=q4=Veteran's Dragonhide Belt", "=ds=#s10#, #a2#", "40 #heroic#", ""};
		{ 18, 32786, "", "=q4=Veteran's Dragonhide Boots", "=ds=#s12#, #a2#", "40 #heroic#", ""};
		{ 20, 32812, "", "=q4=Veteran's Kodohide Bracers", "=ds=#s8#, #a2#", "25 #heroic#", ""};
		{ 21, 32800, "", "=q4=Veteran's Kodohide Belt", "=ds=#s10#, #a2#", "40 #heroic#", ""};
		{ 22, 32788, "", "=q4=Veteran's Kodohide Boots", "=ds=#s12#, #a2#", "40 #heroic#", ""};
		{ 24, 32814, "", "=q4=Veteran's Leather Bracers", "=ds=#s8#, #a2#", "25 #heroic#", ""};
		{ 25, 32802, "", "=q4=Veteran's Leather Belt", "=ds=#s10#, #a2#", "40 #heroic#", ""};
		{ 26, 32790, "", "=q4=Veteran's Leather Boots", "=ds=#s12#, #a2#", "40 #heroic#", ""};
		{ 28, 32821, "", "=q4=Veteran's Wyrmhide Bracers", "=ds=#s8#, #a2#", "25 #heroic#", ""};
		{ 29, 32808, "", "=q4=Veteran's Wyrmhide Belt", "=ds=#s10#, #a2#", "40 #heroic#", ""};
		{ 30, 32796, "", "=q4=Veteran's Wyrmhide Boots", "=ds=#s12#, #a2#", "40 #heroic#", ""};
		Next = "HardModeArena2";
		Back = "70TOKENMENU";
	};

	AtlasLoot_Data["HardModeArena2"] = {
		{ 1, 32809, "", "=q4=Veteran's Chain Bracers", "=ds=#s8#, #a3#", "25 #heroic#", ""};
		{ 2, 32797, "", "=q4=Veteran's Chain Girdle", "=ds=#s10#, #a3#", "40 #heroic#", ""};
		{ 3, 32785, "", "=q4=Veteran's Chain Sabatons", "=ds=#s12#, #a3#", "40 #heroic#", ""};
		{ 5, 32816, "", "=q4=Veteran's Linked Bracers", "=ds=#s8#, #a3#", "25 #heroic#", ""};
		{ 6, 32803, "", "=q4=Veteran's Linked Girdle", "=ds=#s10#, #a3#", "40 #heroic#", ""};
		{ 7, 32791, "", "=q4=Veteran's Linked Sabatons", "=ds=#s12#, #a3#", "40 #heroic#", ""};
		{ 9, 32817, "", "=q4=Veteran's Mail Bracers", "=ds=#s8#, #a3#", "25 #heroic#", ""};
		{ 10, 32804, "", "=q4=Veteran's Mail Girdle", "=ds=#s10#, #a3#", "40 #heroic#", ""};
		{ 11, 32792, "", "=q4=Veteran's Mail Sabatons", "=ds=#s12#, #a3#", "40 #heroic#", ""};
		{ 13, 32997, "", "=q4=Veteran's Ringmail Bracers", "=ds=#s8#, #a3#", "25 #heroic#", ""};
		{ 14, 32998, "", "=q4=Veteran's Ringmail Girdle", "=ds=#s10#, #a3#", "40 #heroic#", ""};
		{ 15, 32999, "", "=q4=Veteran's Ringmail Sabatons", "=ds=#s12#, #a3#", "40 #heroic#", ""};
		{ 16, 32813, "", "=q4=Veteran's Lamellar Bracers", "=ds=#s8#, #a4#", "25 #heroic#", ""};
		{ 17, 32801, "", "=q4=Veteran's Lamellar Belt", "=ds=#s10#, #a4#", "40 #heroic#", ""};
		{ 18, 32789, "", "=q4=Veteran's Lamellar Greaves", "=ds=#s12#, #a4#", "40 #heroic#", ""};
		{ 20, 32989, "", "=q4=Veteran's Ornamented Bracers", "=ds=#s8#, #a4#", "25 #heroic#", ""};
		{ 21, 32988, "", "=q4=Veteran's Ornamented Belt", "=ds=#s10#, #a4#", "40 #heroic#", ""};
		{ 22, 32990, "", "=q4=Veteran's Ornamented Greaves", "=ds=#s12#, #a4#", "40 #heroic#", ""};
		{ 24, 32818, "", "=q4=Veteran's Plate Bracers", "=ds=#s8#, #a4#", "25 #heroic#", ""};
		{ 25, 32805, "", "=q4=Veteran's Plate Belt", "=ds=#s10#, #a4#", "40 #heroic#", ""};
		{ 26, 32793, "", "=q4=Veteran's Plate Greaves", "=ds=#s12#, #a4#", "40 #heroic#", ""};
		{ 28, 32819, "", "=q4=Veteran's Scaled Bracers", "=ds=#s8#, #a4#", "25 #heroic#", ""};
		{ 29, 32806, "", "=q4=Veteran's Scaled Belt", "=ds=#s10#, #a4#", "40 #heroic#", ""};
		{ 30, 32794, "", "=q4=Veteran's Scaled Greaves", "=ds=#s12#, #a4#", "40 #heroic#", ""};
		Prev = "HardModeArena";
		Back = "70TOKENMENU";
	};

	AtlasLoot_Data["HardModeWeapons"] = {
		{ 1, 0, "INV_Box_01", "=q6=#z31#", ""};
		{ 2, 29275, "", "=q4=Searing Sunblade", "=ds=#h4#, #w4#", "50 #heroic#", ""};
		{ 3, 33192, "", "=q4=Carved Witch Doctor's Stick", "=ds=#w12#", "25 #heroic#", ""};
		{ 4, 29266, "", "=q4=Azure-Shield of Coldarra", "=ds=#w8#", "33 #heroic#", ""};
		{ 5, 29267, "", "=q4=Light-Bearer's Faith Shield", "=ds=#w8#", "33 #heroic#", ""};
		{ 6, 29268, "", "=q4=Mazthoril Honor Shield", "=ds=#w8#", "33 #heroic#", ""};
		{ 7, 33334, "", "=q4=Fetish of the Primal Gods", "=ds=#s15#", "35 #heroic#", ""};
		{ 8, 29270, "", "=q4=Flametounge Seal", "=ds=#s15#", "25 #heroic#", ""};
		{ 9, 29273, "", "=q4=Khadgar's Knapsack", "=ds=#s15#", "25 #heroic#", ""};
		{ 10, 29272, "", "=q4=Orb of the Soul-Eater", "=ds=#s15#", "25 #heroic#", ""};
		{ 11, 29269, "", "=q4=Sapphiron's Wing Bone", "=ds=#s15#", "25 #heroic#", ""};
		{ 12, 29271, "", "=q4=Talisman of Kalecgos", "=ds=#s15#", "25 #heroic#", ""};
		{ 13, 29274, "", "=q4=Tears of Heaven", "=ds=#s15#", "25 #heroic#", ""};
		{ 14, 33325, "", "=q4=Voodoo Shaker", "=ds=#s15#", "35 #heroic#", ""};
		{ 16, 0, "INV_Box_01", "=q6=#z32#", ""};
		{ 17, 34893, "", "=q4=Vanir's Right Fist of Brutality", "=ds=#h3#, #w13#", "105 #heroic#", ""};
		{ 18, 34951, "", "=q4=Vanir's Left Fist of Brutality", "=ds=#h4#, #w13#", "45 #heroic#", ""};
		{ 19, 34950, "", "=q4=Vanir's Left Fist of Savagery", "=ds=#h4#, #w13#", "45 #heroic#", ""};
		{ 20, 34895, "", "=q4=Scryer's Blade of Focus", "=ds=#h3#, #w4#", "150 #heroic#", ""};
		{ 21, 34894, "", "=q4=Blade of Serration", "=ds=#h1#, #w4#", "105 #heroic#", ""};
		{ 22, 34949, "", "=q4=Swift Blade of Uncertainty", "=ds=#h4#, #w4#", "45 #heroic#", ""};
		{ 23, 34952, "", "=q4=The Mutilator", "=ds=#h4#, #w4#", "45 #heroic#", ""};
		{ 24, 34891, "", "=q4=The Blade of Harbingers", "=ds=#h2#, #w1#", "150 #heroic#", ""};
		{ 25, 34896, "", "=q4=Gavel of Naaru Blessings", "=ds=#h3#, #w6#", "150 #heroic#", ""};
		{ 26, 34898, "", "=q4=Staff of the Forest Lord", "=ds=#w9#", "150 #heroic#", ""};
		{ 27, 34892, "", "=q4=Crossbow of Relentless Strikes", "=ds=#w3#", "150 #heroic#", ""};
		Back = "70TOKENMENU";
	};

	AtlasLoot_Data["HardModeAccessories"] = {
		{ 1, 0, "INV_Box_01", "=q6=#z31#", ""};
		{ 2, 33296, "", "=q4=Brooch of Deftness", "=ds=#s2#", "35 #heroic#", ""};
		{ 3, 29381, "", "=q4=Choker of Vile Intent", "=ds=#s2#", "25 #heroic#", ""};
		{ 4, 29374, "", "=q4=Necklace of Eternal Hope", "=ds=#s2#", "25 #heroic#", ""};
		{ 5, 29368, "", "=q4=Manasurge Pendant", "=ds=#s2#", "25 #heroic#", ""};
		{ 6, 29386, "", "=q4=Necklace of the Juggernaut", "=ds=#s2#", "25 #heroic#", ""};
		{ 7, 29373, "", "=q4=Band of Halos", "=ds=#s13#", "25 #heroic#", ""};
		{ 8, 29379, "", "=q4=Ring of Arathi Warlords", "=ds=#s13#", "25 #heroic#", ""};
		{ 9, 29367, "", "=q4=Ring of Cryptic Dreams", "=ds=#s13#", "25 #heroic#", ""};
		{ 10, 29384, "", "=q4=Ring of Unyielding Force", "=ds=#s13#", "25 #heroic#", ""};
		{ 12, 23572, "", "=q3=Primal Nether", "=ds=#e8#", "10 #heroic#", ""};
		{ 13, 32227, "", "=q4=Crimson Spinel", "=ds=#e7#", "15 #heroic#", ""};
		{ 14, 32229, "", "=q4=Lionseye", "=ds=#e7#", "15 #heroic#", ""};
		{ 15, 32249, "", "=q4=Seaspray Emerald", "=ds=#e7#", "15 #heroic#", ""};
		{ 16, 35326, "", "=q4=Battlemaster's Alacrity", "=ds=#s14#", "75 #heroic#", ""};
		{ 17, 34049, "", "=q4=Battlemaster's Audacity", "=ds=#s14#", "75 #heroic#", ""};
		{ 18, 34163, "", "=q4=Battlemaster's Cruelty", "=ds=#s14#", "75 #heroic#", ""};
		{ 19, 34162, "", "=q4=Battlemaster's Depravity", "=ds=#s14#", "75 #heroic#", ""};
		{ 20, 33832, "", "=q4=Battlemaster's Determination", "=ds=#s14#", "75 #heroic#", ""};
		{ 21, 34050, "", "=q4=Battlemaster's Perseverance", "=ds=#s14#", "75 #heroic#", ""};
		{ 22, 29383, "", "=q4=Bloodlust Brooch", "=ds=#s14#", "41 #heroic#", ""};
		{ 23, 29376, "", "=q4=Essence of the Martyr", "=ds=#s14#", "41 #heroic#", ""};
		{ 24, 29387, "", "=q4=Gnomeregan Auto-Blocker 600", "=ds=#s14#", "41 #heroic#", ""};
		{ 25, 29370, "", "=q4=Icon of the Silver Crescent", "=ds=#s14#", "41 #heroic#", ""};
		{ 27, 30183, "", "=q4=Nether Vortex", "=ds=#e8#", "15 #heroic#", ""};
		{ 28, 32228, "", "=q4=Empyrean Sapphire", "=ds=#e7#", "15 #heroic#", ""};
		{ 29, 32231, "", "=q4=Pyrestone", "=ds=#e7#", "15 #heroic#", ""};
		{ 30, 32230, "", "=q4=Shadowsong Amethyst", "=ds=#e7#", "15 #heroic#", ""};
		Next = "HardModeAccessories2";
		Back = "70TOKENMENU";
	};

	AtlasLoot_Data["HardModeAccessories2"] = {
		{ 1, 0, "INV_Box_01", "=q6=#z32#", ""};
		{ 2, 34887, "", "=q4=Angelista's Revenge", "=ds=#s13#", "60 #heroic#", ""};
		{ 3, 34890, "", "=q4=Anveena's Touch", "=ds=#s13#", "60 #heroic#", ""};
		{ 4, 34889, "", "=q4=Fused Nethergon Band", "=ds=#s13#", "60 #heroic#", ""};
		{ 5, 34888, "", "=q4=Ring of the Stalwart Protector", "=ds=#s13#", "60 #heroic#", ""};
		Prev = "HardModeAccessories";
		Back = "70TOKENMENU";
	};

		-----------------------
		--- BoE World Epics ---
		-----------------------

	AtlasLoot_Data["WorldEpics4"] = {
		{ 1, 31329, "", "=q4=Lifegiving Cloak", "=ds=#s4#", "", ""};
		{ 2, 31340, "", "=q4=Will of Edward the Odd", "=ds=#s5#, #a1#", "", ""};
		{ 3, 31343, "", "=q4=Kamaei's Cerulean Skirt", "=ds=#s11#, #a1#", "", ""};
		{ 4, 31333, "", "=q4=The Night Watchman", "=ds=#s1#, #a2#", "", ""};
		{ 5, 31335, "", "=q4=Pants of Living Growth", "=ds=#s11#, #a2#", "", ""};
		{ 6, 31330, "", "=q4=Lightning Crown", "=ds=#s1#, #a3#", "", ""};
		{ 7, 31328, "", "=q4=Leggings of Beast Mastery", "=ds=#s11#, #a3#", "", ""};
		{ 8, 31320, "", "=q4=Chestguard of Exile", "=ds=#s5#, #a4#", "", ""};
		{ 9, 31338, "", "=q4=Charlotte's Ivy", "=ds=#s2#", "", ""};
		{ 10, 31321, "", "=q4=Choker of Repentance", "=ds=#s2#", "", ""};
		{ 11, 31319, "", "=q4=Band of Impenetrable Defenses", "=ds=#s13#", "", ""};
		{ 12, 31339, "", "=q4=Lola's Eve", "=ds=#s13#", "", ""};
		{ 13, 31326, "", "=q4=Truestrike Ring", "=ds=#s13#", "", ""};
		{ 16, 31331, "", "=q4=The Night Blade", "=ds=#h1#, #w4#", "", ""};
		{ 17, 31336, "", "=q4=Blade of Wizardry", "=ds=#h3#, #w10#", "", ""};
		{ 18, 31332, "", "=q4=Blinkstrike", "=ds=#h1#, #w10#", "", ""};
		{ 19, 31318, "", "=q4=Singing Crystal Axe", "=ds=#h2#, #w1#", "", ""};
		{ 20, 31342, "", "=q4=The Ancient Scepter of Sue-Min", "=ds=#h3#, #w6#", "", ""};
		{ 21, 31322, "", "=q4=The Hammer of Destiny", "=ds=#h2#, #w6#", "", ""};
		{ 22, 31334, "", "=q4=Staff of Natural Fury", "=ds=#w9#", "", ""};
		{ 23, 34622, "", "=q4=Spinesever", "=ds=#w11#", "", ""};
		{ 24, 31323, "", "=q4=Don Santos' Famous Hunting Rifle", "=ds=#w5#", "", ""};
		Next = "WorldEpicsWrath1";
		Prev = "WorldEpics3";
		Back = "WORLDEPICS";
	};

	--------------------
	--- World Bosses ---
	--------------------

	AtlasLoot_Data["WorldBossesBC"] = {
		{ 1, 0, "INV_Box_01", "=q6="..BabbleBoss["Doom Lord Kazzak"], ""};
		{ 2, 30735, "", "=q4=Ancient Spellcloak of the Highborne", "=ds=#s4#", "", "16.5%"};
		{ 3, 30734, "", "=q4=Leggings of the Seventh Circle", "=ds=#s11#, #a1#", "", "17.0%"};
		{ 4, 30737, "", "=q4=Gold-Leaf Wildboots", "=ds=#s12#, #a2#", "", "21.1%"};
		{ 5, 30739, "", "=q4=Scaled Greaves of the Marksman", "=ds=#s11#, #a3#", "", "14.0%"};
		{ 6, 30740, "", "=q4=Ripfiend Shoulderplates", "=ds=#s3#, #a4#", "", "16.1%"};
		{ 7, 30741, "", "=q4=Topaz-Studded Battlegrips", "=ds=#s9#, #a4#", "", "17.0%"};
		{ 8, 30736, "", "=q4=Ring of Flowing Light", "=ds=#s13#", "", "15.8%"};
		{ 9, 30738, "", "=q4=Ring of Reciprocity", "=ds=#s13#", "", "23.4%"};
		{ 10, 30733, "", "=q4=Hope Ender", "=ds=#h1#, #w10#", "", "16.7%"};
		{ 11, 30732, "", "=q4=Exodar Life-Staff", "=ds=#w9#", "", "17.1%"};
		{ 16, 0, "INV_Box_01", "=q6="..BabbleBoss["Doomwalker"], ""};
		{ 17, 30729, "", "=q4=Black-Iron Battlecloak", "=ds=#s4#", "", "19.6%"};
		{ 18, 30725, "", "=q4=Anger-Spark Gloves", "=ds=#s9#, #a1#", "", "17.9%"};
		{ 19, 30727, "", "=q4=Gilded Trousers of Benediction", "=ds=#s11#, #a1#", "", "18.1%"};
		{ 20, 30730, "", "=q4=Terrorweave Tunic", "=ds=#s5#, #a2#", "", "18.8%"};
		{ 21, 30728, "", "=q4=Fathom-Helm of the Deeps", "=ds=#s1#, #a3#", "", "16.2%"};
		{ 22, 30731, "", "=q4=Faceguard of the Endless Watch", "=ds=#s1#, #a4#", "", "18.1%"};
		{ 23, 30726, "", "=q4=Archaic Charm of Presence", "=ds=#s2#", "", "20.9%"};
		{ 24, 30723, "", "=q4=Talon of the Tempest", "=ds=#h3#, #w4#", "", "15.4%"};
		{ 25, 30722, "", "=q4=Ethereum Nexus-Reaver", "=ds=#h2#, #w1#", "", "16.0%"};
		{ 26, 30724, "", "=q4=Barrel-Blade Longrifle", "=ds=#w5#", "", "20.0%"};
	};