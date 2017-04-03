local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")
local BabbleZone = AtlasLoot_GetLocaleLibBabble("LibBabble-Zone-3.0")

	AtlasLoot_Data["CRAFTINGMENU"] = {
		{ 2, "ALCHEMYMENU", "INV_Potion_23", "=ds="..GetSpellInfo(2259), ""};
		{ 3, "SMITHINGMENU", "Trade_BlackSmithing", "=ds="..GetSpellInfo(2018), ""};
		{ 4, "ENCHANTINGMENU", "Trade_Engraving", "=ds="..GetSpellInfo(7411), ""};
		{ 5, "ENGINEERINGMENU", "Trade_Engineering", "=ds="..GetSpellInfo(4036), ""};
		{ 6, "INSCRIPTIONMENU", "INV_Inscription_Tradeskill01", "=ds="..GetSpellInfo(45357), ""};
		{ 7, "JEWELCRAFTINGMENU", "INV_Misc_Gem_01", "=ds="..GetSpellInfo(25229), ""};
		{ 8, "LEATHERWORKINGMENU", "INV_Misc_ArmorKit_17", "=ds="..GetSpellInfo(2108), ""};
		{ 9, "Mining1", "Trade_Mining", "=ds="..GetSpellInfo(2575), ""};
		{ 10, "TAILORINGMENU", "Trade_Tailoring", "=ds="..GetSpellInfo(3908), ""};
		{ 12, "Cooking1", "INV_Misc_Food_15", "=ds="..GetSpellInfo(2550), ""};
		{ 13, "FirstAid1", "Spell_Holy_SealOfSacrifice", "=ds="..GetSpellInfo(3273), ""};
		{ 17, "CRAFTSET1", "INV_Box_01", AL["Crafted Sets"], ""};
		{ 18, "CraftedWeapons1", "INV_Sword_1H_Blacksmithing_02", AL["Crafted Epic Weapons"], ""};
		{ 20, "COOKINGDAILYMENU", "INV_Misc_Food_15", AL["Cooking Daily"], ""};
		{ 21, "FISHINGDAILYMENU", "inv_fishingpole_03", AL["Fishing Daily"], ""};
		{ 22, "JEWELCRAFTINGDAILYMENU", "INV_Misc_Gem_01", AL["Jewelcrafting Daily"], ""};
	};

	AtlasLoot_Data["ALCHEMYMENU"] = {
		{ 2, "AlchemyBattleElixir1", "INV_Potion_23", "=ds="..AL["Battle Elixirs"], "" };
		{ 3, "AlchemyPotion1", "INV_Potion_23", "=ds="..AL["Potions"], "" };
		{ 4, "AlchemyTransmute1", "INV_Potion_23", "=ds="..AL["Transmutes"], "" };
		{ 17, "AlchemyGuardianElixir1", "INV_Potion_23", "=ds="..AL["Guardian Elixirs"], "" };
		{ 18, "AlchemyFlask1", "INV_Potion_23", "=ds="..AL["Flasks"], "" };
		{ 19, "AlchemyMisc1", "INV_Potion_23", "=ds="..AL["Miscellaneous"], "" };
		Back = "CRAFTINGMENU";
	};

	AtlasLoot_Data["SMITHINGMENU"] = {
		{ 2, "SmithingArmorOld1", "Trade_BlackSmithing", "=ds="..BabbleInventory["Armor"], "=q5="..AL["Original WoW"] };
		{ 3, "SmithingArmorBC1", "Trade_BlackSmithing", "=ds="..BabbleInventory["Armor"], "=q5="..AL["Burning Crusade"] };
		{ 4, "SmithingArmorWrath1", "Trade_BlackSmithing", "=ds="..BabbleInventory["Armor"], "=q5="..AL["Wrath of the Lich King"] };
		{ 5, "SmithingEnhancement1", "Trade_BlackSmithing", "=ds="..AL["Item Enhancements"], "" };
		{ 7, "Armorsmith1", "Trade_BlackSmithing", "=ds="..GetSpellInfo(9788), "" };
		{ 8, "Axesmith1", "Trade_BlackSmithing", "=ds="..GetSpellInfo(17041), "" };
		{ 9, "Swordsmith1", "Trade_BlackSmithing", "=ds="..GetSpellInfo(17039), "" };
		{ 17, "SmithingWeaponOld1", "Trade_BlackSmithing", "=ds="..BabbleInventory["Weapon"], "=q5="..AL["Original WoW"] };
		{ 18, "SmithingWeaponBC1", "Trade_BlackSmithing", "=ds="..BabbleInventory["Weapon"], "=q5="..AL["Burning Crusade"] };
		{ 19, "SmithingWeaponWrath1", "Trade_BlackSmithing", "=ds="..BabbleInventory["Weapon"], "=q5="..AL["Wrath of the Lich King"] };
		{ 20, "SmithingMisc1", "Trade_BlackSmithing", "=ds="..AL["Miscellaneous"], "" };
		{ 22, "Weaponsmith1", "Trade_BlackSmithing", "=ds="..GetSpellInfo(9787), "" };
		{ 23, "Hammersmith1", "Trade_BlackSmithing", "=ds="..GetSpellInfo(17040), "" };
		Back = "CRAFTINGMENU";
	};

	AtlasLoot_Data["ENCHANTINGMENU"] = {
		{ 2, "EnchantingBoots1", "Trade_Engraving", "=ds="..AL["Enchant Boots"], "" };
		{ 3, "EnchantingChest1", "Trade_Engraving", "=ds="..AL["Enchant Chest"], "" };
		{ 4, "EnchantingGloves1", "Trade_Engraving", "=ds="..AL["Enchant Gloves"], "" };
		{ 5, "EnchantingShield1", "Trade_Engraving", "=ds="..AL["Enchant Shield"], "" };
		{ 6, "Enchanting2HWeapon1", "Trade_Engraving", "=ds="..AL["Enchant 2H Weapon"], "" };
		{ 7, "EnchantingMisc1", "Trade_Engraving", "=ds="..AL["Miscellaneous"], "" };
		{ 17, "EnchantingBracer1", "Trade_Engraving", "=ds="..AL["Enchant Bracer"], "" };
		{ 18, "EnchantingCloak1", "Trade_Engraving", "=ds="..AL["Enchant Cloak"], "" };
		{ 19, "EnchantingRing1", "Trade_Engraving", "=ds="..AL["Enchant Ring"], "" };
		{ 20, "EnchantingStaff1", "Trade_Engraving", "=ds="..BabbleInventory["Staff"], "" };
		{ 21, "EnchantingWeapon1", "Trade_Engraving", "=ds="..AL["Enchant Weapon"], "" };
		Back = "CRAFTINGMENU";
	};

	AtlasLoot_Data["ENGINEERINGMENU"] = {
		{ 2, "EngineeringAmmo1", "Trade_Engineering", "=ds="..AL["Ammunition"], "" };
		{ 3, "EngineeringExplosives1", "Trade_Engineering", "=ds="..AL["Explosives"], "" };
		{ 4, "EngineeringMisc1", "Trade_Engineering", "=ds="..AL["Miscellaneous"], "" };
		{ 5, "EngineeringWeapon1", "Trade_Engineering", "=ds="..BabbleInventory["Weapon"], "" };
		{ 7, "Gnomish1", "Trade_Engineering", "=ds="..GetSpellInfo(20220), "" };
		{ 17, "EngineeringArmor1", "Trade_Engineering", "=ds="..BabbleInventory["Armor"], "" };
		{ 18, "EngineeringItemEnhancements1", "Trade_Engineering", "=ds="..AL["Item Enhancements"], "" };
		{ 19, "EngineeringReagents1", "Trade_Engineering", "=ds="..AL["Reagents"], "" };
		{ 22, "Goblin1", "Trade_Engineering", "=ds="..GetSpellInfo(20221), "" };
		Back = "CRAFTINGMENU";
	};

	AtlasLoot_Data["INSCRIPTIONMENU"] = {
		{ 2, "Inscription_Scrolls1", "INV_Inscription_Tradeskill01", "=ds="..AL["Scrolls"], "" };
		{ 3, "Inscription_Misc1", "INV_Inscription_Tradeskill01", "=ds="..AL["Miscellaneous"], "" };
		{ 5, "Inscription_DeathKnightMajor1", "Spell_Deathknight_DeathStrike", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Major Glyph"] };
		{ 6, "Inscription_DruidMajor1", "Spell_Nature_Regeneration", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Major Glyph"] };
		{ 7, "Inscription_HunterMajor1", "Ability_Hunter_RunningShot", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "=q5="..AL["Major Glyph"] };
		{ 8, "Inscription_MageMajor1", "Spell_Frost_IceStorm", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], "=q5="..AL["Major Glyph"] };
		{ 9, "Inscription_PaladinMajor1", "Spell_Holy_SealOfMight", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Major Glyph"] };
		{ 10, "Inscription_PriestMajor1", "Spell_Holy_PowerWordShield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Major Glyph"] };
		{ 11, "Inscription_RogueMajor1", "Ability_BackStab", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "=q5="..AL["Major Glyph"] };
		{ 12, "Inscription_ShamanMajor1", "Spell_FireResistanceTotem_01", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Major Glyph"] };
		{ 13, "Inscription_WarlockMajor1", "Spell_Shadow_CurseOfTounges", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "=q5="..AL["Major Glyph"] };
		{ 14, "Inscription_WarriorMajor1", "Ability_Warrior_BattleShout", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["Major Glyph"] };
		{ 17, "Inscription_OffHand1", "INV_Inscription_Tradeskill01", "=ds="..AL["Off-Hand Items"], "" };
		{ 18, "Inscription_Reagents1", "INV_Inscription_Tradeskill01", "=ds="..AL["Reagents"], "" };
		{ 20, "Inscription_DeathKnightMinor1", "Spell_Deathknight_DeathStrike", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Minor Glyph"] };
		{ 21, "Inscription_DruidMinor1", "Spell_Nature_Regeneration", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Minor Glyph"] };
		{ 22, "Inscription_HunterMinor1", "Ability_Hunter_RunningShot", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "=q5="..AL["Minor Glyph"] };
		{ 23, "Inscription_MageMinor1", "Spell_Frost_IceStorm", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], "=q5="..AL["Minor Glyph"] };
		{ 24, "Inscription_PaladinMinor1", "Spell_Holy_SealOfMight", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Minor Glyph"] };
		{ 25, "Inscription_PriestMinor1", "Spell_Holy_PowerWordShield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Minor Glyph"] };
		{ 26, "Inscription_RogueMinor1", "Ability_BackStab", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "=q5="..AL["Minor Glyph"] };
		{ 27, "Inscription_ShamanMinor1", "Spell_FireResistanceTotem_01", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Minor Glyph"] };
		{ 28, "Inscription_WarlockMinor1", "Spell_Shadow_CurseOfTounges", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "=q5="..AL["Minor Glyph"] };
		{ 29, "Inscription_WarriorMinor1", "Ability_Warrior_BattleShout", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["Minor Glyph"] };
		Back = "CRAFTINGMENU";
	};

	AtlasLoot_Data["JEWELCRAFTINGMENU"] = {
		{ 1, "JewelRed1", "INV_Misc_Gem_01", "=ds="..BabbleInventory["Red"].." "..BabbleInventory["Gem"], "" };
		{ 2, "JewelBlue1", "INV_Misc_Gem_01", "=ds="..BabbleInventory["Blue"].." "..BabbleInventory["Gem"], "" };
		{ 3, "JewelYellow1", "INV_Misc_Gem_01", "=ds="..BabbleInventory["Yellow"].." "..BabbleInventory["Gem"], "" };
		{ 4, "JewelGreen1", "INV_Misc_Gem_01", "=ds="..BabbleInventory["Green"].." "..BabbleInventory["Gem"], "" };
		{ 5, "JewelOrange1", "INV_Misc_Gem_01", "=ds="..BabbleInventory["Orange"].." "..BabbleInventory["Gem"], "" };
		{ 6, "JewelPurple1", "INV_Misc_Gem_01", "=ds="..BabbleInventory["Purple"].." "..BabbleInventory["Gem"], "" };
		{ 7, "JewelMeta1", "INV_Misc_Gem_01", "=ds="..BabbleInventory["Meta"].." "..BabbleInventory["Gem"], "" };
		{ 8, "JewelPrismatic1", "INV_Misc_Gem_01", "=ds="..BabbleInventory["Prismatic"].." "..BabbleInventory["Gem"], "" };
		{ 9, "JewelDragonsEye1", "INV_Misc_Gem_01", "=ds="..AL["Dragon's Eye"], "" };
		{ 16, "JewelNeck1", "INV_Misc_Gem_01", "=ds="..BabbleInventory["Neck"], "" };
		{ 17, "JewelTrinket1", "INV_Misc_Gem_01", "=ds="..BabbleInventory["Trinket"], "" };
		{ 18, "JewelRing1", "INV_Misc_Gem_01", "=ds="..BabbleInventory["Ring"], "" };
		{ 19, "JewelMisc1", "INV_Misc_Gem_01", "=ds="..AL["Miscellaneous"], "" };
		Back = "CRAFTINGMENU";
	};

	AtlasLoot_Data["LEATHERWORKINGMENU"] = {
		{ 2, "LeatherLeatherArmorOld1", "INV_Misc_ArmorKit_17", "=ds="..AL["Leather Armor"], "=q5="..AL["Original WoW"] };
		{ 3, "LeatherLeatherArmorBC1", "INV_Misc_ArmorKit_17", "=ds="..AL["Leather Armor"], "=q5="..AL["Burning Crusade"] };
		{ 4, "LeatherLeatherArmorWrath1", "INV_Misc_ArmorKit_17", "=ds="..AL["Leather Armor"], "=q5="..AL["Wrath of the Lich King"] };
		{ 6, "LeatherCloaks1", "INV_Misc_ArmorKit_17", "=ds="..AL["Cloaks"], "" };
		{ 7, "LeatherQuiversPouches1", "INV_Misc_ArmorKit_17", "=ds="..AL["Quivers and Ammo Pouches"], "" };
		{ 8, "LeatherLeather1", "INV_Misc_ArmorKit_17", "=ds="..BabbleInventory["Leather"], "" };
		{ 10, "Dragonscale1", "INV_Misc_ArmorKit_17", "=ds="..GetSpellInfo(10656), "" };
		{ 11, "Tribal1", "INV_Misc_ArmorKit_17", "=ds="..GetSpellInfo(10660), "" };
		{ 17, "LeatherMailArmorOld1", "INV_Misc_ArmorKit_17", "=ds="..AL["Mail Armor"], "=q5="..AL["Original WoW"] };
		{ 18, "LeatherMailArmorBC1", "INV_Misc_ArmorKit_17", "=ds="..AL["Mail Armor"], "=q5="..AL["Burning Crusade"] };
		{ 19, "LeatherMailArmorWrath1", "INV_Misc_ArmorKit_17", "=ds="..AL["Mail Armor"], "=q5="..AL["Wrath of the Lich King"] };
		{ 21, "LeatherItemEnhancement1", "INV_Misc_ArmorKit_17", "=ds="..AL["Item Enhancements"], "" };
		{ 22, "LeatherDrumsBagsMisc1", "INV_Misc_ArmorKit_17", "=ds="..AL["Drums, Bags and Misc."], "" };
		{ 25, "Elemental1", "INV_Misc_ArmorKit_17", "=ds="..GetSpellInfo(10658), "" };
		Back = "CRAFTINGMENU";
	};

	AtlasLoot_Data["TAILORINGMENU"] = {
		{ 2, "TailoringArmorOld1", "Trade_Tailoring", "=ds="..AL["Cloth Armor"], "=q5="..AL["Original WoW"] };
		{ 3, "TailoringArmorBC1", "Trade_Tailoring", "=ds="..AL["Cloth Armor"], "=q5="..AL["Burning Crusade"] };
		{ 4, "TailoringArmorWotLK1", "Trade_Tailoring", "=ds="..AL["Cloth Armor"], "=q5="..AL["Wrath of the Lich King"] };
		{ 6, "Mooncloth1", "Trade_Tailoring", "=ds="..GetSpellInfo(26798), "" };
		{ 7, "Shadoweave1", "Trade_Tailoring", "=ds="..GetSpellInfo(26801), "" };
		{ 17, "TailoringBags1", "Trade_Tailoring", "=ds="..AL["Bags"], "" };
		{ 18, "TailoringMisc1", "Trade_Tailoring", "=ds="..AL["Miscellaneous"], "" };
		{ 19, "TailoringShirts1", "Trade_Tailoring", "=ds="..AL["Shirts"], "" };
		{ 21, "Spellfire1", "Trade_Tailoring", "=ds="..GetSpellInfo(26797), "" };
		Back = "CRAFTINGMENU";
	};

	AtlasLoot_Data["CRAFTSET1"] = {
		{ 1, "", "INV_Chest_Plate05", "=q6="..GetSpellInfo(2018), "=q5="..BabbleInventory["Plate"] };
		{ 2, "BlacksmithingPlateImperialPlate", "INV_Belt_01", "=ds="..AL["Imperial Plate"], "" };
		{ 3, "BlacksmithingPlateTheDarksoul", "INV_Shoulder_01", "=ds="..AL["The Darksoul"], "" };
		{ 4, "BlacksmithingPlateFelIronPlate", "INV_Chest_Plate07", "=ds="..AL["Fel Iron Plate"], "" };
		{ 5, "BlacksmithingPlateAdamantiteB", "INV_Gauntlets_30", "=ds="..AL["Adamantite Battlegear"], "" };
		{ 6, "BlacksmithingPlateFlameG", "INV_Helmet_22", "=ds="..AL["Flame Guard"], "=q5="..AL["Fire Resistance Gear"] };
		{ 7, "BlacksmithingPlateEnchantedAdaman", "INV_Belt_29", "=ds="..AL["Enchanted Adamantite Armor"], "=q5="..AL["Arcane Resistance Gear"] };
		{ 8, "BlacksmithingPlateKhoriumWard", "INV_Boots_Chain_01", "=ds="..AL["Khorium Ward"], "" };
		{ 9, "BlacksmithingPlateFaithFelsteel", "INV_Pants_Plate_06", "=ds="..AL["Faith in Felsteel"], "" };
		{ 10, "BlacksmithingPlateBurningRage", "INV_Gauntlets_26", "=ds="..AL["Burning Rage"], "" };
		{ 11, "BlacksmithingPlateOrnateSaroniteBattlegear", "inv_helmet_130", "=ds="..AL["Ornate Saronite Battlegear"], "" };
		{ 12, "BlacksmithingPlateSavageSaroniteBattlegear", "inv_helmet_130", "=ds="..AL["Savage Saronite Battlegear"], "" };
		{ 16, "", "INV_Chest_Chain_04", "=q6="..GetSpellInfo(2018), "=q5="..BabbleInventory["Mail"] };
		{ 17, "BlacksmithingMailBloodsoulEmbrace", "INV_Shoulder_15", "=ds="..AL["Bloodsoul Embrace"], "" };
		{ 18, "BlacksmithingMailFelIronChain", "INV_Helmet_35", "=ds="..AL["Fel Iron Chain"], "" };
		Next = "CRAFTSET2";
		Back = "CRAFTINGMENU";
	};

	AtlasLoot_Data["CRAFTSET2"] = {
		{ 1, "LeatherworkingLeatherVolcanicArmor", "INV_Pants_06", "=ds="..AL["Volcanic Armor"], "=q5="..AL["Fire Resistance Gear"] };
		{ 2, "LeatherworkingLeatherIronfeatherArmor", "INV_Chest_Leather_06", "=ds="..AL["Ironfeather Armor"], "" };
		{ 3, "LeatherworkingLeatherStormshroudArmor", "INV_Chest_Leather_08", "=ds="..AL["Stormshroud Armor"], "" };
		{ 4, "LeatherworkingLeatherDevilsaurArmor", "INV_Pants_Wolf", "=ds="..AL["Devilsaur Armor"], "" };
		{ 5, "LeatherworkingLeatherBloodTigerH", "INV_Shoulder_23", "=ds="..AL["Blood Tiger Harness"], "" };
		{ 6, "LeatherworkingLeatherPrimalBatskin", "INV_Chest_Leather_03", "=ds="..AL["Primal Batskin"], "" };
		{ 7, "LeatherworkingLeatherWildDraenishA", "INV_Pants_Leather_07", "=ds="..AL["Wild Draenish Armor"], "" };
		{ 8, "LeatherworkingLeatherThickDraenicA", "INV_Boots_Chain_01", "=ds="..AL["Thick Draenic Armor"], "" };
		{ 9, "LeatherworkingLeatherFelSkin", "INV_Gauntlets_22", "=ds="..AL["Fel Skin"], "" };
		{ 10, "LeatherworkingLeatherSClefthoof", "INV_Boots_07", "=ds="..AL["Strength of the Clefthoof"], "" };
		{ 11, "LeatherworkingLeatherPrimalIntent", "INV_Chest_Cloth_45", "=ds="..AL["Primal Intent"], "=q5="..GetSpellInfo(10658) };
		{ 12, "LeatherworkingLeatherWindhawkArmor", "INV_Chest_Leather_01", "=ds="..AL["Windhawk Armor"], "=q5="..GetSpellInfo(10660) };
		{ 16, "LeatherworkingLeatherBoreanEmbrace", "inv_helmet_110", "=ds="..AL["Borean Embrace"], "" };
		{ 17, "LeatherworkingLeatherIceborneEmbrace", "inv_chest_fur", "=ds="..AL["Iceborne Embrace"], "" };
		{ 18, "LeatherworkingLeatherEvisceratorBattlegear", "inv_helmet_04", "=ds="..AL["Eviscerator's Battlegear"], "" };
		{ 19, "LeatherworkingLeatherOvercasterBattlegear", "inv_pants_leather_09", "=ds="..AL["Overcaster Battlegear"], "" };
		Prev = "CRAFTSET1";
		Next = "CRAFTSET3";
		Back = "CRAFTINGMENU";
	};

	AtlasLoot_Data["CRAFTSET3"] = {
		{ 1, "LeatherworkingMailGreenDragonM", "INV_Pants_05", "=ds="..AL["Green Dragon Mail"], "=q5="..AL["Nature Resistance Gear"] };
		{ 2, "LeatherworkingMailBlueDragonM", "INV_Chest_Chain_04", "=ds="..AL["Blue Dragon Mail"], "=q5="..AL["Arcane Resistance Gear"] };
		{ 3, "LeatherworkingMailBlackDragonM", "INV_Pants_03", "=ds="..AL["Black Dragon Mail"], "=q5="..AL["Fire Resistance Gear"] };
		{ 4, "LeatherworkingMailScaledDraenicA", "INV_Pants_Mail_07", "=ds="..AL["Scaled Draenic Armor"], "" };
		{ 5, "LeatherworkingMailFelscaleArmor", "INV_Boots_Chain_08", "=ds="..AL["Felscale Armor"], "" };
		{ 6, "LeatherworkingMailFelstalkerArmor", "INV_Belt_13", "=ds="..AL["Felstalker Armor"], "" };
		{ 7, "LeatherworkingMailNetherFury", "INV_Pants_Plate_12", "=ds="..AL["Fury of the Nether"], "" };
		{ 8, "LeatherworkingMailNetherscaleArmor", "INV_Belt_29", "=ds="..AL["Netherscale Armor"], "=q5="..GetSpellInfo(10656) };
		{ 9, "LeatherworkingMailNetherstrikeArmor", "INV_Belt_03", "=ds="..AL["Netherstrike Armor"], "=q5="..GetSpellInfo(10656) };
		{ 16, "LeatherworkingMailFrostscaleBinding", "inv_chest_chain_13", "=ds="..AL["Frostscale Binding"], "" };
		{ 17, "LeatherworkingMailNerubianHive", "inv_helmet_110", "=ds="..AL["Nerubian Hive"], "" };
		{ 18, "LeatherworkingMailStormhideBattlegear", "inv_pants_mail_18", "=ds="..AL["Stormhide Battlegear"], "" };
		{ 19, "LeatherworkingMailSwiftarrowBattlefear", "inv_belt_19", "=ds="..AL["Swiftarrow Battlefear"], "" };
		Prev = "CRAFTSET2";
		Next = "CRAFTSET4";
		Back = "CRAFTINGMENU";
	};

	AtlasLoot_Data["CRAFTSET4"] = {
		{ 1, "TailoringBloodvineG", "INV_Pants_Cloth_14", "=ds="..AL["Bloodvine Garb"], "" };
		{ 2, "TailoringNeatherVest", "INV_Chest_Cloth_29", "=ds="..AL["Netherweave Vestments"], "" };
		{ 3, "TailoringImbuedNeather", "INV_Pants_Leather_09", "=ds="..AL["Imbued Netherweave"], "" };
		{ 4, "TailoringArcanoVest", "INV_Chest_Cloth_01", "=ds="..AL["Arcanoweave Vestments"], "=q5="..AL["Arcane Resistance Gear"] };
		{ 5, "TailoringTheUnyielding", "INV_Belt_03", "=ds="..AL["The Unyielding"], "" };
		{ 6, "TailoringWhitemendWis", "INV_Helmet_53", "=ds="..AL["Whitemend Wisdom"], "" };
		{ 7, "TailoringSpellstrikeInfu", "INV_Pants_Cloth_14", "=ds="..AL["Spellstrike Infusion"], "" };
		{ 8, "TailoringBattlecastG", "INV_Helmet_70", "=ds="..AL["Battlecast Garb"], "" };
		{ 9, "TailoringSoulclothEm", "INV_Chest_Cloth_12", "=ds="..AL["Soulcloth Embrace"], "=q5="..AL["Arcane Resistance Gear"] };
		{ 10, "TailoringPrimalMoon", "INV_Chest_Cloth_04", "=ds="..AL["Primal Mooncloth"], "=q5="..GetSpellInfo(26798) };
		{ 11, "TailoringShadowEmbrace", "INV_Shoulder_25", "=ds="..AL["Shadow's Embrace"], "=q5="..GetSpellInfo(26801) };
		{ 12, "TailoringSpellfireWrath", "INV_Gauntlets_19", "=ds="..AL["Wrath of Spellfire"], "=q5="..GetSpellInfo(26797) };
		{ 16, "TailoringFrostwovenPower", "inv_belt_29", "=ds="..AL["Frostwoven Power"], "" };
		{ 17, "TailoringDuskweaver", "inv_chest_cloth_19", "=ds="..AL["Frostsavage Battlegear"], "" };
		{ 18, "TailoringFrostsavageBattlegear", "inv_helmet_125", "=ds="..AL["Battlecast Garb"], "" };
		Prev = "CRAFTSET3";
		Back = "CRAFTINGMENU";
	};

	AtlasLoot_Data["COOKINGDAILYMENU"] = {
		{ 2, "CookingDaily1", "inv_misc_cauldron_arcane", "=ds="..BabbleZone["Shattrath"], "=q5="..AL["Burning Crusade"] };
		{ 17, "CookingDaily2", "achievement_profession_chefhat", "=ds="..BabbleZone["Dalaran"], "=q5="..AL["Wrath of the Lich King"] };
		Back = "CRAFTINGMENU";
	};

	AtlasLoot_Data["FISHINGDAILYMENU"] = {
		{ 2, "FishingDaily1", "inv_drink_19", "=ds="..BabbleZone["Terokkar Forest"], "=q5="..AL["Burning Crusade"] };
		{ 17, "FishingDaily2", "inv_fishingpole_05", "=ds="..BabbleZone["Dalaran"], "=q5="..AL["Wrath of the Lich King"] };
		Back = "CRAFTINGMENU";
	};

	AtlasLoot_Data["JEWELCRAFTINGDAILYMENU"] = {
		{ 2, "JewelcraftingDaily1", "inv_jewelcrafting_gem_32", "=ds="..BabbleInventory["Red"].." / "..BabbleInventory["Yellow"].." "..BabbleInventory["Gem"], "=q5="..AL["Wrath of the Lich King"] };
		{ 3, "JewelcraftingDaily3", "inv_jewelcrafting_gem_34", "=ds="..BabbleInventory["Green"].." "..BabbleInventory["Gem"], "=q5="..AL["Wrath of the Lich King"] };
		{ 4, "JewelcraftingDaily5", "inv_jewelcrafting_gem_35", "=ds="..BabbleInventory["Blue"].." / "..BabbleInventory["Meta"].." "..BabbleInventory["Gem"], "=q5="..AL["Wrath of the Lich King"] };
		{ 17, "JewelcraftingDaily2", "inv_jewelcrafting_gem_33", "=ds="..BabbleInventory["Orange"].." "..BabbleInventory["Gem"], "=q5="..AL["Wrath of the Lich King"] };
		{ 18, "JewelcraftingDaily4", "inv_jewelcrafting_gem_31", "=ds="..BabbleInventory["Purple"].." "..BabbleInventory["Gem"], "=q5="..AL["Wrath of the Lich King"] };
		{ 19, "JewelcraftingDaily6", "inv_jewelcrafting_dragonseye01", "=ds="..AL["Dragon's Eye"].." / "..BabbleInventory["Neck"].." / "..BabbleInventory["Ring"], "=q5="..AL["Wrath of the Lich King"] };
		Back = "CRAFTINGMENU";
	};

    --Please don't delete EmptyTable, it is needed as it is certain to load
    --even if no loot modules have loaded
	AtlasLoot_Data["EmptyTable"] = {
	};
