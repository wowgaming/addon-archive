local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")
local BabbleFaction = AtlasLoot_GetLocaleLibBabble("LibBabble-Faction-3.0")
local BabbleZone = AtlasLoot_GetLocaleLibBabble("LibBabble-Zone-3.0")


	AtlasLoot_Data["WORLDEVENTMENU"] = {
		{ 1, "ARGENTMENU", "Ability_Paladin_ArtofWar", "=ds="..AL["Argent Tournament"], "=q5="..BabbleZone["Icecrown"]};
		{ 3, "Brewfest1", "INV_Cask_04", "=ds="..AL["Brewfest"], "=q5="..AL["Various Locations"]};
		{ 4, "DayoftheDead", "INV_Misc_Bone_HumanSkull_02", "=ds="..AL["Day of the Dead"], "=q5="..AL["Various Locations"]};
		{ 5, "Halloween1", "INV_Misc_Bag_28_Halloween", "=ds="..AL["Hallow's End"], "=q5="..AL["Various Locations"]};
		{ 6, "Valentineday", "INV_ValentinesBoxOfChocolates02", "=ds="..AL["Love is in the Air"], "=q5="..AL["Various Locations"]};
		{ 7, "MidsummerFestival", "INV_SummerFest_FireFlower", "=ds="..AL["Midsummer Fire Festival"], "=q5="..AL["Various Locations"]};
		{ 8, "PilgrimsBounty_H", "inv_helmet_65", "=ds="..AL["Pilgrim's Bounty"], "=q5="..AL["Various Locations"]};
		{ 10, "BashirLanding", "INV_Trinket_Naxxramas02", "=ds="..AL["Bash'ir Landing Skyguard Raid"], "=q5="..BabbleZone["Blade's Edge Mountains"]};
		{ 11, "GurubashiArena", "INV_Box_02", "=ds="..AL["Gurubashi Arena Booty Run"], "=q5="..BabbleZone["Stranglethorn Vale"]};
		{ 12, "Shartuul", "INV_Misc_Rune_04", "=ds="..AL["Shartuul"], "=q5="..BabbleZone["Blade's Edge Mountains"]};
		{ 14, "ABYSSALMENU", "INV_Staff_13", "=ds="..AL["Abyssal Council"], "=q5="..BabbleZone["Silithus"]};
		{ 15, "SKETTISMENU", "Spell_Nature_NaturesWrath", "=ds="..AL["Skettis"], "=q5="..BabbleZone["Terokkar Forest"]};
		{ 16, "DARKMOONMENU", "INV_Misc_Ticket_Tarot_Madness", "=ds="..BabbleFaction["Darkmoon Faire"], "=q5="..AL["Various Locations"]};
		{ 18, "ChildrensWeek", "Ability_Hunter_BeastCall", "=ds="..AL["Children's Week"], "=q5="..AL["Various Locations"]};
		{ 19, "Winterviel1", "INV_Holiday_Christmas_Present_01", "=ds="..AL["Feast of Winter Veil"], "=q5="..AL["Various Locations"]};
		{ 20, "HarvestFestival", "INV_Misc_Food_33", "=ds="..AL["Harvest Festival"], "=q5="..AL["Various Locations"]};
		{ 21, "LunarFestival1", "INV_Misc_ElvenCoins", "=ds="..AL["Lunar Festival"], "=q5="..AL["Various Locations"]};
		{ 22, "Noblegarden", "INV_Egg_03", "=ds="..AL["Noblegarden"], "=q5="..AL["Various Locations"]};
		{ 25, "ElementalInvasion", "INV_DataCrystal03", "=ds="..AL["Elemental Invasion"], "=q5="..AL["Various Locations"]};
		{ 26, "ScourgeInvasionEvent1", "INV_Jewelry_Talisman_13", "=ds="..AL["Scourge Invasion"], "=q5="..AL["Various Locations"]};
		{ 27, "FishingExtravaganza", "INV_Fishingpole_02", "=ds="..AL["Stranglethorn Fishing Extravaganza"], "=q5="..BabbleZone["Stranglethorn Vale"]};
		{ 29, "ETHEREUMMENU", "INV_Misc_PunchCards_Prismatic", "=ds="..AL["Ethereum Prison"], ""};
	};

	AtlasLoot_Data["ARGENTMENU"] = {
		{ 2, "ArgentTournament1", "inv_scroll_11", "=ds="..BabbleInventory["Miscellaneous"], ""};
		{ 3, "ArgentTournament3", "inv_boots_plate_09", "=ds="..BabbleInventory["Armor"], ""};
		{ 4, "ArgentTournament5", "achievement_reputation_argentchampion", "=ds="..AL["Vanity Pets"], ""};
		{ 5, "ArgentTournament8", "inv_jewelry_talisman_01", "=ds="..AL["Heirloom"], ""};
		{ 17, "ArgentTournament2", "inv_misc_tournaments_tabard_human", "=ds="..AL["Tabards"].." / "..AL["Banner"], ""};
		{ 18, "ArgentTournament4", "inv_mace_29", "=ds="..AL["Weapons"], ""};
		{ 19, "ArgentTournament6", "ability_mount_charger", "=ds="..AL["Mounts"], ""};
		Back = "WORLDEVENTMENU";
	};

	AtlasLoot_Data["DARKMOONMENU"] = {
		{ 2, "Darkmoon1", "INV_Misc_Ticket_Darkmoon_01", "=ds="..AL["Darkmoon Faire Rewards"], ""};
		{ 3, "Darkmoon3", "INV_Misc_Ticket_Tarot_Madness", "=ds="..AL["Original and BC Trinkets"], ""};
		{ 17, "Darkmoon2", "INV_Misc_Ticket_Tarot_Furies", "=ds="..AL["Low Level Decks"], ""};
		{ 18, "Darkmoon4", "INV_Inscription_TarotGreatness", "=ds="..AL["WotLK Trinkets"], ""};
		Back = "WORLDEVENTMENU";
	};

	AtlasLoot_Data["ABYSSALMENU"] = {
		{ 2, "Templars", "INV_Jewelry_Talisman_05", "=ds="..AL["Abyssal Council"].." - "..AL["Templars"], ""};
		{ 3, "HighCouncil", "INV_Staff_13", "=ds="..AL["Abyssal Council"].." - "..AL["High Council"], ""};
		{ 17, "Dukes", "INV_Jewelry_Ring_36", "=ds="..AL["Abyssal Council"].." - "..AL["Dukes"], ""};
		Back = "WORLDEVENTMENU";
	};

	AtlasLoot_Data["ETHEREUMMENU"] = {
		{ 2, "ArmbreakerHuffaz", "INV_Jewelry_Ring_59", "=ds="..AL["Armbreaker Huffaz"], ""};
		{ 3, "Forgosh", "INV_Boots_05", "=ds="..AL["Forgosh"], ""};
		{ 4, "MalevustheMad", "INV_Boots_Chain_04", "=ds="..AL["Malevus the Mad"], ""};
		{ 5, "WrathbringerLaztarash", "INV_Misc_Orb_01", "=ds="..AL["Wrathbringer Laz-tarash"], ""};
		{ 17, "FelTinkererZortan", "INV_Boots_Chain_08", "=ds="..AL["Fel Tinkerer Zortan"], ""};
		{ 18, "Gulbor", "INV_Jewelry_Necklace_29Naxxramas", "=ds="..AL["Gul'bor"], ""};
		{ 19, "PorfustheGemGorger", "INV_Boots_Cloth_01", "=ds="..AL["Porfus the Gem Gorger"], ""};
		{ 20, "BashirStasisChambers", "INV_Trinket_Naxxramas02", "=ds="..AL["Bash'ir Landing Stasis Chambers"], ""};
		Back = "WORLDEVENTMENU";
	};

	AtlasLoot_Data["SKETTISMENU"] = {
		{ 2, "DarkscreecherAkkarai", "INV_Misc_Rune_07", "=ds="..AL["Darkscreecher Akkarai"], ""};
		{ 3, "GezzaraktheHuntress", "INV_Misc_Rune_07", "=ds="..AL["Gezzarak the Huntress"], ""};
		{ 4, "Terokk", "INV_Misc_Rune_07", "=ds="..AL["Terokk"], ""};
		{ 17, "Karrog", "INV_Misc_Rune_07", "=ds="..AL["Karrog"], ""};
		{ 18, "VakkiztheWindrager", "INV_Misc_Rune_07", "=ds="..AL["Vakkiz the Windrager"], ""};
		Back = "WORLDEVENTMENU";
	};