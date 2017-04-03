local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")
local BabbleFaction = AtlasLoot_GetLocaleLibBabble("LibBabble-Faction-3.0")
local BabbleZone = AtlasLoot_GetLocaleLibBabble("LibBabble-Zone-3.0")


	AtlasLoot_Data["REPMENU"] = {
		{ 2, "REPMENU_ORIGINALWOW", "INV_Helmet_66", "=ds="..AL["Factions - Original WoW"], ""};
		{ 17, "REPMENU_BURNINGCRUSADE", "INV_Misc_Ribbon_01", "=ds="..AL["Factions - Burning Crusade"], ""};
		{ 4, "AllianceVanguard1", "spell_misc_hellifrepvphonorholdfavor", "=ds="..BabbleFaction["Alliance Vanguard"], "=q5="..BabbleFaction["Alliance"]};
		{ 5, "WinterfinRetreat", "INV_Misc_Shell_04", "=ds="..BabbleFaction["Winterfin Retreat"], "=q5="..BabbleZone["Borean Tundra"]};
		{ 6, "TheWyrmrestAccord", "achievement_reputation_wyrmresttemple", "=ds="..BabbleFaction["The Wyrmrest Accord"], "=q5="..BabbleZone["Dragonblight"]};
		{ 7, "KnightsoftheEbonBlade", "achievement_reputation_knightsoftheebonblade", "=ds="..BabbleFaction["Knights of the Ebon Blade"], "=q5="..BabbleZone["Zul'Drak"].." / "..BabbleZone["Icecrown"]};
		{ 8, "TheOracles", "inv_misc_head_murloc_01", "=ds="..BabbleFaction["The Oracles"], "=q5="..BabbleZone["Sholazar Basin"]};
		{ 9, "TheSonsofHodir1", "Spell_Holy_DivinePurpose", "=ds="..BabbleFaction["The Sons of Hodir"], "=q5="..BabbleZone["The Storm Peaks"]};
		{ 19, "HordeExpedition1", "spell_misc_hellifrepvpthrallmarfavor", "=ds="..BabbleFaction["Horde Expedition"], "=q5="..BabbleFaction["Horde"]};
		{ 20, "TheKaluak", "INV_Fishingpole_03", "=ds="..BabbleFaction["The Kalu'ak"], "" };
		{ 21, "KirinTor", "achievement_reputation_kirintor", "=ds="..BabbleFaction["Kirin Tor"], "=q5="..BabbleZone["Borean Tundra"].." / "..BabbleZone["Dalaran"]};
		{ 22, "ArgentCrusade", "INV_Jewelry_Talisman_08", "=ds="..BabbleFaction["Argent Crusade"], "=q5="..BabbleZone["Zul'Drak"].." / "..BabbleZone["Icecrown"]};
		{ 23, "FrenzyheartTribe", "ability_mount_whitedirewolf", "=ds="..BabbleFaction["Frenzyheart Tribe"], "=q5="..BabbleZone["Sholazar Basin"]};
		{ 24, "AshenVerdict", "INV_Jewelry_Ring_85", "=ds="..BabbleFaction["The Ashen Verdict"], "=q5="..BabbleZone["Icecrown"]};
	};

	AtlasLoot_Data["REPMENU_ORIGINALWOW"] = {
		{ 2, "Argent1", "inv_jewelry_talisman_07", "=ds="..BabbleFaction["Argent Dawn"], "=q5="..BabbleZone["Eastern Plaguelands"]}; 
		{ 3, "AQBroodRings", "inv_misc_head_dragon_bronze", "=ds="..BabbleFaction["Brood of Nozdormu"], "=q5="..BabbleZone["Temple of Ahn'Qiraj"].." / "..BabbleZone["Caverns of Time"]};
		{ 4, "MiscFactions", "INV_Jewelry_Amulet_07", "=ds="..BabbleFaction["The Defilers"], "=q5="..BabbleFaction["Horde"].." - "..BabbleZone["Arathi Basin"]}; 
		{ 5, "MiscFactions", "INV_Misc_Head_Centaur_01", "=ds="..BabbleFaction["Gelkis Clan Centaur"], "=q5="..BabbleZone["Desolace"]};
		{ 6, "MiscFactions", "INV_Jewelry_Amulet_07", "=ds="..BabbleFaction["The League of Arathor"], "=q5="..BabbleFaction["Alliance"].." - "..BabbleZone["Arathi Basin"]};
		{ 7, "AlteracFactions", "INV_Jewelry_StormPikeTrinket_01", "=ds="..BabbleFaction["Stormpike Guard"], "=q5="..BabbleFaction["Alliance"].." - "..BabbleZone["Alterac Valley"]};
		{ 8, "Timbermaw", "achievement_reputation_timbermaw", "=ds="..BabbleFaction["Timbermaw Hold"], ""};
		{ 9, "Zandalar1", "inv_bijou_green", "=ds="..BabbleFaction["Zandalar Tribe"], "=q5="..BabbleZone["Zul'Gurub"]};
		{ 17, "BloodsailHydraxian", "INV_Helmet_66", "=ds="..BabbleFaction["Bloodsail Buccaneers"], "=q5="..BabbleZone["Stranglethorn Vale"]};
		{ 18, "Cenarion1", "ability_racial_ultravision", "=ds="..BabbleFaction["Cenarion Circle"], ""};
		{ 19, "AlteracFactions", "INV_Jewelry_FrostwolfTrinket_01", "=ds="..BabbleFaction["Frostwolf Clan"], "=q5="..BabbleFaction["Horde"].." - "..BabbleZone["Alterac Valley"]};
		{ 20, "BloodsailHydraxian", "Spell_Frost_SummonWaterElemental_2", "=ds="..BabbleFaction["Hydraxian Waterlords"], "=q5="..BabbleZone["Molten Core"]};
		{ 21, "MiscFactions", "INV_Misc_Head_Centaur_01", "=ds="..BabbleFaction["Magram Clan Centaur"], "=q5="..BabbleZone["Desolace"]};
		{ 22, "Thorium1", "INV_Ingot_Mithril", "=ds="..BabbleFaction["Thorium Brotherhood"], "=q5="..BabbleZone["Searing Gorge"]};
		{ 23, "MiscFactions", "Ability_Mount_PinkTiger", "=ds="..BabbleFaction["Wintersaber Trainers"], "=q5="..BabbleFaction["Alliance"].." - "..BabbleZone["Winterspring"]};
		Back = "REPMENU";
	};

	AtlasLoot_Data["REPMENU_BURNINGCRUSADE"] = {
		{ 2, "Aldor1", "INV_Jewelry_Talisman_08", "=ds="..BabbleFaction["The Aldor"], ""};
		{ 3, "CExpedition1", "INV_Misc_Ammo_Arrow_02", "=ds="..BabbleFaction["Cenarion Expedition"], "=q5="..BabbleZone["Zangarmarsh"]};
		{ 4, "HonorHold1", "INV_BannerPVP_02", "=ds="..BabbleFaction["Honor Hold"], "=q5="..BabbleFaction["Alliance"].." - "..BabbleZone["Hellfire Peninsula"]};
		{ 5, "Kurenai1", "INV_Misc_Foot_Centaur", "=ds="..BabbleFaction["Kurenai"], "=q5="..BabbleFaction["Alliance"].." - "..BabbleZone["Nagrand"]};
		{ 6, "Maghar1", "INV_Misc_Foot_Centaur", "=ds="..BabbleFaction["The Mag'har"], "=q5="..BabbleFaction["Horde"].." - "..BabbleZone["Nagrand"]};
		{ 7, "Ogrila1", "inv_misc_apexis_crystal", "=ds="..BabbleFaction["Ogri'la"], "=q5="..BabbleZone["Blade's Edge Mountains"]};
		{ 8, "Scryer1", "INV_Misc_Foot_Centaur", "=ds="..BabbleFaction["The Scryers"], ""};
		{ 9, "Skyguard1", "INV_Misc_Ribbon_01", "=ds="..BabbleFaction["Sha'tari Skyguard"], "=q5="..BabbleZone["Terokkar Forest"].." / "..BabbleZone["Blade's Edge Mountains"]};
		{ 10, "Sporeggar1", "inv_mushroom_11", "=ds="..BabbleFaction["Sporeggar"], "=q5="..BabbleZone["Zangarmarsh"]};
		{ 11, "Tranquillien1", "INV_Misc_Bandana_03", "=ds="..BabbleFaction["Tranquillien"], "=q5="..BabbleFaction["Horde"].." - "..BabbleZone["Ghostlands"]};
		{ 17, "Ashtongue1", "achievement_reputation_ashtonguedeathsworn", "=ds="..BabbleFaction["Ashtongue Deathsworn"], "=q5="..BabbleZone["Shadowmoon Valley"].." / "..BabbleZone["Black Temple"]};
		{ 18, "Consortium1", "INV_Weapon_Shortblade_31", "=ds="..BabbleFaction["The Consortium"], ""};
		{ 19, "KeepersofTime1", "Ability_Warrior_VictoryRush", "=ds="..BabbleFaction["Keepers of Time"], "=q5="..BabbleZone["Caverns of Time"]};
		{ 20, "LowerCity1", "Spell_Holy_ChampionsBond", "=ds="..BabbleFaction["Lower City"], ""};
		{ 21, "Netherwing1", "Ability_Mount_Netherdrakepurple", "=ds="..BabbleFaction["Netherwing"], "=q5="..BabbleZone["Shadowmoon Valley"]};
		{ 22, "ScaleSands1", "INV_Misc_MonsterScales_13", "=ds="..BabbleFaction["The Scale of the Sands"], "=q5="..BabbleZone["Hyjal Summit"]};
		{ 23, "Shatar1", "Ability_Warrior_ShieldMastery", "=ds="..BabbleFaction["The Sha'tar"], ""};
		{ 24, "SunOffensive1", "inv_shield_48", "=ds="..BabbleFaction["Shattered Sun Offensive"], "=q5="..BabbleZone["Isle of Quel'Danas"]};
		{ 25, "Thrallmar1", "INV_BannerPVP_01", "=ds="..BabbleFaction["Thrallmar"], "=q5="..BabbleFaction["Horde"].." - "..BabbleZone["Hellfire Peninsula"]};
		{ 26, "VioletEye1", "spell_holy_mindsooth", "=ds="..BabbleFaction["The Violet Eye"], "=q5="..BabbleZone["Karazhan"]};
		Back = "REPMENU";
	};

	AtlasLoot_Data["REPMENU_WOTLK"] = {
		{ 2, "AllianceVanguard1", "spell_misc_hellifrepvphonorholdfavor", "=ds="..BabbleFaction["Alliance Vanguard"], "=q5="..BabbleFaction["Alliance"]};
		{ 3, "WinterfinRetreat", "INV_Misc_Shell_04", "=ds="..BabbleFaction["Winterfin Retreat"], "=q5="..BabbleZone["Borean Tundra"]};
		{ 4, "TheWyrmrestAccord", "achievement_reputation_wyrmresttemple", "=ds="..BabbleFaction["The Wyrmrest Accord"], "=q5="..BabbleZone["Dragonblight"]};
		{ 5, "KnightsoftheEbonBlade", "achievement_reputation_knightsoftheebonblade", "=ds="..BabbleFaction["Knights of the Ebon Blade"], "=q5="..BabbleZone["Zul'Drak"].." / "..BabbleZone["Icecrown"]};
		{ 6, "TheOracles", "inv_misc_head_murloc_01", "=ds="..BabbleFaction["The Oracles"], "=q5="..BabbleZone["Sholazar Basin"]};
		{ 7, "TheSonsofHodir1", "Spell_Holy_DivinePurpose", "=ds="..BabbleFaction["The Sons of Hodir"], "=q5="..BabbleZone["The Storm Peaks"]};
		{ 17, "HordeExpedition1", "spell_misc_hellifrepvpthrallmarfavor", "=ds="..BabbleFaction["Horde Expedition"], "=q5="..BabbleFaction["Horde"]};
		{ 18, "TheKaluak", "INV_Fishingpole_03", "=ds="..BabbleFaction["The Kalu'ak"], "" };
		{ 19, "KirinTor", "achievement_reputation_kirintor", "=ds="..BabbleFaction["Kirin Tor"], "=q5="..BabbleZone["Borean Tundra"].." / "..BabbleZone["Dalaran"]};
		{ 20, "ArgentCrusade", "INV_Jewelry_Talisman_08", "=ds="..BabbleFaction["Argent Crusade"], "=q5="..BabbleZone["Zul'Drak"].." / "..BabbleZone["Icecrown"]};
		{ 21, "FrenzyheartTribe", "ability_mount_whitedirewolf", "=ds="..BabbleFaction["Frenzyheart Tribe"], "=q5="..BabbleZone["Sholazar Basin"]};
		{ 22, "AshenVerdict", "INV_Jewelry_Ring_85", "=ds="..BabbleFaction["The Ashen Verdict"], "=q5="..BabbleZone["Icecrown"]};
		Back = "REPMENU";
	};
