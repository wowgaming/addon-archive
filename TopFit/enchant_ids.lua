-- this table matches enchant ids on items to their corresponding stat.
-- CAUTION: this is not the item-id of an enchant item, nor the same id that is used in tradeskills

TopFit.enchantIDs = {
	-- Head
	[1] = {
		[1504] = { 									 					-- Lesser Arcane Amalgamation
			["ITEM_MOD_RESILIENCE_RATING_SHORT"] = 125, 
		},
		[3820] = {														-- Arcanum of Burning Mysteries
			["ITEM_MOD_SPELL_POWER_SHORT"] = 30,
			["ITEM_MOD_CRIT_RATING_SHORT"] = 20,
		},
		[3819] = {														-- Arcanum of Blissful Mending
			["ITEM_MOD_SPELL_POWER_SHORT"] = 30,
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 10,
		},
		[3002] = {														-- Arcanum of Power
			["ITEM_MOD_SPELL_POWER_SHORT"] = 22,
			["ITEM_MOD_HIT_RATING_SHORT"] = 14,
		},
		[3001] = {														-- Arcanum of Renewal
			["ITEM_MOD_SPELL_POWER_SHORT"] = 19,
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 9,
		},
		[3817] = {														-- Arcanum of Torment
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 50,
			["ITEM_MOD_CRIT_RATING_SHORT"] = 20
		},
		[3003] = {														-- Arcanum of Ferocity
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 34,
			["ITEM_MOD_HIT_RATING_SHORT"] = 16,
		},
		[2999] = {														-- Arcanum of the Defender
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 16,
			["ITEM_MOD_DODGE_RATING_SHORT"] = 17,
		},
		[3818] = {														-- Arcanum of the Stalwart Protector
			["ITEM_MOD_STAMINA_SHORT"] = 37,
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 20,
		},
		[3795] = {														-- Arcanum of Triumph
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 50,
			["ITEM_MOD_RESILIENCE_RATING_SHORT"] = 20,
		},
		[3797] = {														-- Arcanum of Dominance
			["ITEM_MOD_SPELL_POWER_SHORT"] = 29,
			["ITEM_MOD_RESILIENCE_RATING_SHORT"] = 20,
		},
		[3842] = {														-- Arcanum of the Savage Gladiator
			["ITEM_MOD_STAMINA_SHORT"] = 30,
			["ITEM_MOD_RESILIENCE_RATING_SHORT"] = 25,
		},
		[3004] = {														-- Arcanum of the Gladiator
			["ITEM_MOD_STAMINA_SHORT"] = 18,
			["ITEM_MOD_RESILIENCE_RATING_SHORT"] = 20,
		},
		[3096] = {														-- Arcanum of the Outcast
			["ITEM_MOD_STRENGTH_SHORT"] = 17,
			["ITEM_MOD_INTELLECT_SHORT"] = 16,
		},
		[2544] = { 														-- Arcanum of Focus
			["ITEM_MOD_SPELL_POWER_SHORT"] = 8,
		},
		[2545] = {														-- Arcanum of Protection
			["ITEM_MOD_DODGE_RATING_SHORT"] = 12,
		},
		[2543] = {														-- Arcanum of Rapidity
			["ITEM_MOD_HASTE_RATING_SHORT"] = 10,
		},
		[1503] = {														-- Lesser Arcanum of Constitution
			["ITEM_MOD_HEALTH_SHORT"] = 100,
		},
		[1483] = {														-- Lesser Arcanum of Rumination
			["ITEM_MOD_MANA_SHORT"] = 150,
		},
		[3815] = {														-- Arcanum of the Eclipsed Moon
			["ITEM_MOD_STAMINA_SHORT"] = 30,
			["RESISTANCE6_NAME"] = 25,
		},
		[3006] = {														-- Arcanum of Arcane Warding
			["RESISTANCE6_NAME"] = 20,
		},
		[3816] = {														-- Arcanum of the Flame's Soul
			["ITEM_MOD_STAMINA_SHORT"] = 30,
			["RESISTANCE2_NAME"] = 25,
		},
		[3007] = {														-- Arcanum of Fire Warding
			["RESISTANCE2_NAME"] = 20,
		},
		[1505] = {														-- Lesser Arcanum of Resilience
			["RESISTANCE2_NAME"] = 20,
		},
		[3812] = {														-- Arcanum of the Frosty Soul
			["ITEM_MOD_STAMINA_SHORT"] = 30,
			["RESISTANCE4_NAME"] = 25,
		},
		[3008] = {														-- Arcanum of Frost Warding
			["RESISTANCE4_NAME"] = 20,
		},
		[2682] = {														-- Ice Guard
			["RESISTANCE4_NAME"] = 10,
		},
		[3813] = {														-- Arcanum of Toxic Warding
			["ITEM_MOD_STAMINA_SHORT"] = 30,
			["RESISTANCE3_NAME"] = 25,
		},
		[3005] = {														-- Arcanum of Nature Warding
			["RESISTANCE3_NAME"] = 20,
		},
		[2681] = {														-- Savage Guard
			["RESISTANCE3_NAME"] = 10,
		},
		[3814] = {														-- Arcanum of the Fleeing Shadow
			["ITEM_MOD_STAMINA_SHORT"] = 30,
			["RESISTANCE5_NAME"] = 25,
		},
		[3009] = {														-- Arcanum of Shadow Warding
			["RESISTANCE5_NAME"] = 20,
		},
		[2683] = {														-- Shadow Guard
			["RESISTANCE5_NAME"] = 10,
		},
		[1508] = {														-- Lesser Arcanum of Voracity
			["ITEM_MOD_AGILITY_SHORT"] = 8,
		},
		[1509] = {														-- Lesser Arcanum of Voracity
			["ITEM_MOD_INTELLECT_SHORT"] = 8,
		},
		[1510] = {														-- Lesser Arcanum of Voracity
			["ITEM_MOD_SPIRIT_SHORT"] = 8,
		},
		[3330] = {														-- Heavy Borean Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 18,
		},
		[3329] = {														-- Borean Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 12,
		},
		[2841] = {														-- Heavy Knothide Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 10,
		},
		[1507] = {														-- Lesser Arcanum of Voracity
			["ITEM_MOD_STAMINA_SHORT"] = 8,
		},
		[1506] = {														-- Lesser Arcanum of Voracity
			["ITEM_MOD_STRENGTH_SHORT"] = 8,
		},
		[3752] = {														-- Falcon's Call
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 24,
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			["ITEM_MOD_HIT_RATING_SHORT"] = 10,
		},
		[2588] = {														-- Presence of Sight
			["ITEM_MOD_SPELL_POWER_SHORT"] = 18,
			["ITEM_MOD_HIT_RATING_SHORT"] = 8,
		},
		[2584] = {														-- Syncretist's Sigil
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 10,
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			["ITEM_MOD_SPELL_POWER_SHORT"] = 12,
		},
		[2590] = {														-- Prophetic Aura
			["ITEM_MOD_SPELL_POWER_SHORT"] = 13,
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 5,
		},
		[3755] = {														-- Death's Embrace
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 28,
			["ITEM_MOD_DODGE_RATING_SHORT"] = 12,
		},
		[2587] = {														-- Vodouisant's Vigilant Embrace
			["ITEM_MOD_SPELL_POWER_SHORT"] = 13,
			["ITEM_MOD_INTELLECT_SHORT"] = 15,
		},
		[2589] = {														-- Hoodoo Hex
			["ITEM_MOD_SPELL_POWER_SHORT"] = 18,
			["ITEM_MOD_STAMINA_SHORT"] = 10,
		},
		[2583] = {														-- Presence of Might
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 10,
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			["ITEM_MOD_BLOCK_VALUE_SHORT"] = 30,
		},
		[2591] = {														-- Animist's Caress
			["ITEM_MOD_INTELLECT_SHORT"] = 10,
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			["ITEM_MOD_SPELL_POWER_SHORT"] = 12,
		},
		[3878] = {														-- Mind Amplification Dish
			["ITEM_MOD_STAMINA_SHORT"] = 45,
			-- + mind control
			-- engineering 410
		},
	},
	-- Shoulders
	[3] = {
		[3808] = {														-- Greater Inscription of the Axe
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 40,
			["ITEM_MOD_CRIT_RATING_SHORT"] = 15,
		},
		[3875] = {														-- Lesser Inscription of the Axe
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 30,
			["ITEM_MOD_CRIT_RATING_SHORT"] = 10,
		},
		[3811] = {														-- Greater Inscription of the Pinnacle
			["ITEM_MOD_DODGE_RATING_SHORT"] = 20,
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 15,
		},
		[3876] = {														-- Lesser Inscription of the Pinnacle
			["ITEM_MOD_DODGE_RATING_SHORT"] = 15,
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 10,
		},
		[3810] = {														-- Greater Inscription of the Storm
			["ITEM_MOD_SPELL_POWER_SHORT"] = 24,
			["ITEM_MOD_CRIT_RATING_SHORT"] = 15,
		},
		[3806] = {														-- Lesser Inscription of the Storm 
			["ITEM_MOD_SPELL_POWER_SHORT"] = 18,
			["ITEM_MOD_CRIT_RATING_SHORT"] = 10,
		},
		[3809] = {														-- Greater Inscription of the Crag
			["ITEM_MOD_SPELL_POWER_SHORT"] = 24,
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 8,
		},
		[3807] = {														-- Lesser Inscription of the Crag
			["ITEM_MOD_SPELL_POWER_SHORT"] = 18,
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 5,
		},
		[3852] = {														-- Greater Inscription of the Gladiator
			["ITEM_MOD_STAMINA_SHORT"] = 30,
			["ITEM_MOD_RESILIENCE_RATING_SHORT"] = 15,
		},
		[3793] = {														-- Inscription of Triumph
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 40,
			["ITEM_MOD_RESILIENCE_RATING_SHORT"] = 15,
		},
		[3794] = {														-- Inscription of Dominance
			["ITEM_MOD_SPELL_POWER_SHORT"] = 23,
			["ITEM_MOD_RESILIENCE_RATING_SHORT"] = 15,
		},
		[2986] = {														-- Greater Inscription of Vengeance
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 30,
			["ITEM_MOD_CRIT_RATING_SHORT"] = 10,
		},
		[2978] = {														-- Greater Inscription of Warding
			["ITEM_MOD_DODGE_RATING_SHORT"] = 15,
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 10,
		},
		[2982] = {														-- Greater Inscription of Discipline
			["ITEM_MOD_SPELL_POWER_SHORT"] = 18,
			["ITEM_MOD_CRIT_RATING_SHORT"] = 10,
		},
		[2980] = {														-- Greater Inscription of Faith
			["ITEM_MOD_SPELL_POWER_SHORT"] = 18,
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 5,
		},
		[2983] = {														-- Inscription of Vengeance
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 26,
		},
		[2977] = {														-- Inscription of Warding
			["ITEM_MOD_DODGE_RATING_SHORT"] = 13,
		},
		[2981] = {														-- Inscription of Discipline
			["ITEM_MOD_SPELL_POWER_SHORT"] = 15,
		},
		[2979] = {														-- Inscription of Faith
			["ITEM_MOD_SPELL_POWER_SHORT"] = 15,
		},
		[2997] = {														-- Greater Inscription of the Blade
			["ITEM_MOD_CRIT_RATING_SHORT"] = 15,
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 20,
		},
		[2991] = {														-- Greater Inscription of the Knight
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 15,
			["ITEM_MOD_DODGE_RATING_SHORT"] = 10,
		},
		[2995] = {														-- Greater Inscription of the Orb
			["ITEM_MOD_CRIT_RATING_SHORT"] = 10,
			["ITEM_MOD_SPELL_POWER_SHORT"] = 15,
		},
		[2993] = {														-- Greater Inscription of the Oracle
			["ITEM_MOD_SPELL_POWER_SHORT"] = 12,
			["ITEM_MOD_HEALTH_REGENERATION_SHORT"] = 8,
		},
		[2996] = {														-- Inscription of the Blade
			["ITEM_MOD_CRIT_RATING_SHORT"] = 13,
		},
		[2994] = {														-- Inscription of the Orb
			["ITEM_MOD_CRIT_RATING_SHORT"] = 13,
		},
		[2990] = {														-- Inscription of the Knight
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 13,
		},
		[2992] = {														-- Inscription of the Oracle
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 6,
		},
		[2606] = {														-- Zandalar Signet of Might
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 30,
		},
		[2604] = {														-- Zandalar Signet of Serenity
			["ITEM_MOD_SPELL_POWER_SHORT"] = 18,
		},
		[2605] = {														-- Zandalar Signet of Mojo
			["ITEM_MOD_SPELL_POWER_SHORT"] = 18,
		},
		[3330] = {														-- Heavy Borean Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 18,
		},
		[3329] = {														-- Borean Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 12,
		},
		[2841] = {														-- Heavy Knothide Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 10,
		},
		[2487] = {														-- Shadow Mantle of the Dawn
			["RESISTANCE5_NAME"] = 5,
		},
		[2486] = {														-- Nature Mantle of the Dawn
			["RESISTANCE3_NAME"] = 5,
		},
		[2484] = {														-- Frost Mantle of the Dawn
			["RESISTANCE4_NAME"] = 5,
		},
		[2483] = {														-- Flame Mantle of the Dawn
			["RESISTANCE2_NAME"] = 5,
		},
		[2485] = {														-- Arcane Mantle of the Dawn
			["RESISTANCE6_NAME"] = 5,
		},
		[2488] = {														-- Chromatic Mantle of the Dawn
			["RESISTANCE1_NAME"] = 5,
			["RESISTANCE2_NAME"] = 5,
			["RESISTANCE3_NAME"] = 5,
			["RESISTANCE4_NAME"] = 5,
			["RESISTANCE5_NAME"] = 5,
			["RESISTANCE6_NAME"] = 5,
		},
		[2998] = {														-- Inscription of Endurance
			["RESISTANCE1_NAME"] = 7,
			["RESISTANCE2_NAME"] = 7,
			["RESISTANCE3_NAME"] = 7,
			["RESISTANCE4_NAME"] = 7,
			["RESISTANCE5_NAME"] = 7,
			["RESISTANCE6_NAME"] = 7,
		},
		[3835] = {														-- Master's Inscription of the Axe
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 120,
			["ITEM_MOD_CRIT_RATING_SHORT"] = 15,
			-- inscription 400
		},
		[3837] = {														-- Master's Inscription of the Pinnacle
			["ITEM_MOD_DODGE_RATING_SHORT"] = 60,
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 15,
			-- inscription 400
		},
		[3838] = {														-- Master's Inscription of the Storm
			["ITEM_MOD_SPELL_POWER_SHORT"] = 70,
			["ITEM_MOD_CRIT_RATING_SHORT"] = 15,
			-- inscription 400
		},
		[3836] = {														-- Master's Inscription of the Crag
			["ITEM_MOD_SPELL_POWER_SHORT"] = 120,
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 6,
			-- inscription 400
		},
	},
	-- Back
	[15] = {
		[3294] = {														-- Enchant Cloak - Mighty Armor
			["RESISTANCE0_NAME"] = 225,
			-- 60+
		},
		[2662] = {														-- Enchant Cloak - Major Armor
			["RESISTANCE0_NAME"] = 120,
			-- 35+
		},
		[1889] = {														-- Enchant Cloak - Superior Defense
			["RESISTANCE0_NAME"] = 70,
		},
		[884] = {														-- Enchant Cloak - Greater Defense
			["RESISTANCE0_NAME"] = 50,
		},
		[848] = {														-- Enchant Cloak - Defense
			["RESISTANCE0_NAME"] = 30,
		},
		[744] = {														-- Enchant Cloak - Lesser Protection
			["RESISTANCE0_NAME"] = 20,
		},
		[783] = {														-- Enchant Cloak - Minor Protection
			["RESISTANCE0_NAME"] = 10,
		},
		[3831] = {														-- Enchant Cloak - Greater Speed
			["ITEM_MOD_HASTE_RATING_SHORT"] = 23,
			-- 60+
		},
		[3825] = {														-- Enchant Cloak - Speed
			["ITEM_MOD_HASTE_RATING_SHORT"] = 15,
			-- 60+
		},
		[1951] = {														-- Enchant Cloak - Titanweave
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 16,
			-- 60+
		},
		[2648] = {														-- Enchant Cloak - Steelweave
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 12,
			-- 35+
		},
		[3243] = {														-- Enchant Cloak - Spell Piercing
			["ITEM_MOD_SPELL_PENETRATION_SHORT"] = 35,
			-- 60+
		},
		[2938] = {														-- Enchant Cloak - Spell Penetration
			["ITEM_MOD_SPELL_PENETRATION_SHORT"] = 20,
			-- 35+
		},
		[2622] = {														-- Enchant Cloak - Dodge
			["ITEM_MOD_DODGE_RATING_SHORT"] = 12,
			-- 35+
		},
		[3258] = {														-- Enchant Cloak - Shadow Armor
			["ITEM_MOD_AGILITY_SHORT"] = 10,
			-- + stealth
			-- 60+
		},
		[910] = {														-- Enchant Cloak - Stealth
			-- + stealth
		},
		[3296] = {														-- Enchant Cloak - Wisdom
			["ITEM_MOD_SPIRIT_SHORT"] = 10,
			-- + 2% aggro reduce
			-- 60+
		},
		[2621] = {														-- Enchant Cloak - Subtlety
			-- + 2% aggro reuduce
		},
		[1099] = {														-- Enchant Cloak - Major Agility
			["ITEM_MOD_AGILITY_SHORT"] = 22,
			-- 60+
		},
		[983] = {														-- Enchant Cloak - Superior Agility
			["ITEM_MOD_AGILITY_SHORT"] = 16,
			-- 60+
		},
		[368] = {														-- Enchant Cloak - Greater Agility
			["ITEM_MOD_AGILITY_SHORT"] = 12,
			-- 35+
		},
		[849] = {														-- Enchant Cloak - Lesser Agility
			["ITEM_MOD_AGILITY_SHORT"] = 3,
		},
		[247] = {														-- Enchant Cloak - Minor Agility
			["ITEM_MOD_AGILITY_SHORT"] = 1,
		},
		[2664] = {														-- Enchant Cloak - Major Resistance
			["RESISTANCE1_NAME"] = 7,
			["RESISTANCE2_NAME"] = 7,
			["RESISTANCE3_NAME"] = 7,
			["RESISTANCE4_NAME"] = 7,
			["RESISTANCE5_NAME"] = 7,
			["RESISTANCE6_NAME"] = 7,
			-- 35+
		},
		[1888] = {														-- Enchant Cloak - Greater Resistance
			["RESISTANCE1_NAME"] = 5,
			["RESISTANCE2_NAME"] = 5,
			["RESISTANCE3_NAME"] = 5,
			["RESISTANCE4_NAME"] = 5,
			["RESISTANCE5_NAME"] = 5,
			["RESISTANCE6_NAME"] = 5,
		},
		[903] = {														-- Enchant Cloak - Resistance
			["RESISTANCE1_NAME"] = 3,
			["RESISTANCE2_NAME"] = 3,
			["RESISTANCE3_NAME"] = 3,
			["RESISTANCE4_NAME"] = 3,
			["RESISTANCE5_NAME"] = 3,
			["RESISTANCE6_NAME"] = 3,
		},
		[65] = {														-- Enchant Cloak - Minor Resistance
			["RESISTANCE1_NAME"] = 1,
			["RESISTANCE2_NAME"] = 1,
			["RESISTANCE3_NAME"] = 1,
			["RESISTANCE4_NAME"] = 1,
			["RESISTANCE5_NAME"] = 1,
			["RESISTANCE6_NAME"] = 1,
		},
		[1262] = {														-- Enchant Cloak - Superior Arcane Resistance
			["RESISTANCE6_NAME"] = 20,
			-- 60+
		},
		[1257] = {														-- Enchant Cloak - Greater Arcane Resistance
			["RESISTANCE6_NAME"] = 15,
			-- 35+
		},
		[1354] = {														-- Enchant Cloak - Superior Fire Resistance
			["RESISTANCE2_NAME"] = 20,
			-- 60+
		},
		[2619] = {														-- Enchant Cloak - Greater Fire Resistance
			["RESISTANCE2_NAME"] = 15,
		},
		[2463] = {														-- Enchant Cloak - Fire Resistance
			["RESISTANCE2_NAME"] = 7,
		},
		[256] = {														-- Enchant Cloak - Lesser Fire Resistance
			["RESISTANCE2_NAME"] = 5,
		},
		[3230] = {														-- Enchant Cloak - Superior Frost Resistance
			["RESISTANCE4_NAME"] = 20,
			-- 60+
		},
		[1400] = {														-- Enchant Cloak - Superior Nature Resistance
			["RESISTANCE3_NAME"] = 20,
			-- 60+
		},
		[2620] = {														-- Enchant Cloak - Greater Nature Resistance
			["RESISTANCE3_NAME"] = 15,
		},
		[1446] = {														-- Enchant Cloak - Superior Shadow Resistance
			["RESISTANCE5_NAME"] = 20,
			-- 60+
		},
		[1441] = {														-- Enchant Cloak - Greater Shadow Resistance
			["RESISTANCE5_NAME"] = 15,
		},
		[804] = {														-- Enchant Cloak - Lesser Shadow Resistance
			["RESISTANCE5_NAME"] = 10,
		},
		[3728] = {														-- Darkglow Embroidery
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 33,
			-- 400, 35% proc, 60 seconds CD ~ 25 mana per 5 sec.
			-- tailoring 400
		},
		[3722] = {														-- Lightweave Embroidery
			["ITEM_MOD_SPELL_POWER_SHORT"] = 95,
			-- 295 spp for 15sec, 50% proc, 45 seconds CD
			-- tailoring 400
		},
		[3730] = {														-- Swordguard Embroidery
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 100,
			-- 400 ap for 15sec, 25% proc, 45 seconds CD (?)
			-- tailoring 400
		},
		[3605] = {														-- Flexweave Underlay
			["ITEM_MOD_AGILITY_SHORT"] = 23,
			-- parachute 1/min
			-- engineering 350
		},
		[3859] = {														-- Springy Arachnoweave
			["ITEM_MOD_SPELL_POWER_SHORT"] = 27,
			-- parachute 1/min
			-- engineering 350
		},
	},
	-- Chest
	[5] = {
		[3330] = {														-- Heavy Borean Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 18,
			-- 70+
		},
		[3329] = {														-- Borean Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 12,
			-- 70+
		},
		[2841] = {														-- Heavy Knothide Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			-- 60+
		},
		[2792] = {														-- Knothide Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			-- 55+
		},
		[1843] = {														-- Rugged Armor Kit
			["RESISTANCE0_NAME"] = 40,
			-- 35+
		},
		[18] = {														-- Thick Armor Kit
			["RESISTANCE0_NAME"] = 32,
			-- 25+
		},
		[17] = {														-- Heavy Armor Kit
			["RESISTANCE0_NAME"] = 24,
			-- 15+
		},
		[16] = {														-- Medium Armor Kit
			["RESISTANCE0_NAME"] = 16,
		},
		[15] = {														-- Light Armor Kit
			["RESISTANCE0_NAME"] = 8,
		},
		[1953] = {														-- Enchant Chest - Greater Defense
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 22,
			-- 60+
		},
		[1951] = {														-- Enchant Chest - Defense
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 16,
			-- 35+
		},
		[2793] = {														-- Vindicator's Armor Kit
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 8,
		},
		[2503] = {														-- Core Armor Kit
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 5,
		},
		[2794] = {														-- Magister's Armor Kit
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 4,
		},
		[3245] = {														-- Enchant Chest - Exceptional Resilience
			["ITEM_MOD_RESILIENCE_RATING_SHORT"] = 20,
			-- 60+
		},
		[2933] = {														-- Enchant Chest - Major Resilience
			["ITEM_MOD_RESILIENCE_RATING_SHORT"] = 15,
			-- 35+
		},
		[63] = {														-- Enchant Chest - Lesser Absorption
			-- Enchant a piece of chest armor so it has a 5% chance per hit of giving you 25 points of damage absorption.
		},
		[44] = {														-- Enchant Chest - Minor Absorption
			-- Enchant a piece of chest armor so it has a 2% chance per hit of giving you 10 points of damage absorption
		},
		[2381] = {														-- Enchant Chest - Greater Mana Restoration
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 10,
			-- 60+
		},
		[3150] = {														-- Enchant Chest - Restore Mana Prime
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 7,
			-- 35+
		},
		[3297] = {														-- Enchant Chest - Super Health
			["ITEM_MOD_HEALTH_SHORT"] = 275,
			-- 60+
		},
		[3236] = {														-- Enchant Chest - Mighty Health
			["ITEM_MOD_HEALTH_SHORT"] = 200,
			-- 60+
		},
		[2659] = {														-- Enchant Chest - Exceptional Health
			["ITEM_MOD_HEALTH_SHORT"] = 150,
			-- 35+
		},
		[1892] = {														-- Enchant Chest - Major Health
			["ITEM_MOD_HEALTH_SHORT"] = 100,
		},
		[908] = {														-- Enchant Chest - Superior Health
			["ITEM_MOD_HEALTH_SHORT"] = 12,
		},
		[850] = {														-- Enchant Chest - Greater Health
			["ITEM_MOD_HEALTH_SHORT"] = 35,
		},
		[254] = {														-- Enchant Chest - Health
			["ITEM_MOD_HEALTH_SHORT"] = 25,
		},
		[242] = {														-- Enchant Chest - Lesser Health
			["ITEM_MOD_HEALTH_SHORT"] = 15,
		},
		[41] = {														-- Enchant Chest - Minor Health
			["ITEM_MOD_HEALTH_SHORT"] = 5,
		},
		[3233] = {														-- Enchant Chest - Exceptional Mana
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 250,
			-- 60+
		},
		[1893] = {														-- Enchant Chest - Major Mana
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 100,
		},
		[913] = {														-- Enchant Chest - Superior Mana
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 65,
		},
		[857] = {														-- Enchant Chest - Greater Mana
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 50,
		},
		[843] = {														-- Enchant Chest - Mana
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 30,
		},
		[246] = {														-- Enchant Chest - Lesser Mana
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 20,
		},
		[24] = {														-- Enchant Chest - Minor Mana
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 5,
		},
		[3832] = {														-- Enchant Chest - Powerful Stats
			["ITEM_MOD_AGILITY_SHORT"] = 10,
			["ITEM_MOD_INTELLECT_SHORT"] = 10,
			["ITEM_MOD_SPIRIT_SHORT"] = 10,
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			["ITEM_MOD_STRENGTH_SHORT"] = 10,
			-- 60+
		},
		[3252] = {														-- Enchant Chest - Super Stats
			["ITEM_MOD_AGILITY_SHORT"] = 8,
			["ITEM_MOD_INTELLECT_SHORT"] = 8,
			["ITEM_MOD_SPIRIT_SHORT"] = 8,
			["ITEM_MOD_STAMINA_SHORT"] = 8,
			["ITEM_MOD_STRENGTH_SHORT"] = 8,
			-- 60+
		},
		[2661] = {														-- Enchant Chest - Exceptional Stats
			["ITEM_MOD_AGILITY_SHORT"] = 6,
			["ITEM_MOD_INTELLECT_SHORT"] = 6,
			["ITEM_MOD_SPIRIT_SHORT"] = 6,
			["ITEM_MOD_STAMINA_SHORT"] = 6,
			["ITEM_MOD_STRENGTH_SHORT"] = 6,
			-- 35+
		},
		[1891] = {														-- Enchant Chest - Greater Stats
			["ITEM_MOD_AGILITY_SHORT"] = 4,
			["ITEM_MOD_INTELLECT_SHORT"] = 4,
			["ITEM_MOD_SPIRIT_SHORT"] = 4,
			["ITEM_MOD_STAMINA_SHORT"] = 4,
			["ITEM_MOD_STRENGTH_SHORT"] = 4,
		},
		[928] = {														-- Enchant Chest - Stats
			["ITEM_MOD_AGILITY_SHORT"] = 3,
			["ITEM_MOD_INTELLECT_SHORT"] = 3,
			["ITEM_MOD_SPIRIT_SHORT"] = 3,
			["ITEM_MOD_STAMINA_SHORT"] = 3,
			["ITEM_MOD_STRENGTH_SHORT"] = 3,
		},
		[866] = {														-- Enchant Chest - Lesser Stats
			["ITEM_MOD_AGILITY_SHORT"] = 2,
			["ITEM_MOD_INTELLECT_SHORT"] = 2,
			["ITEM_MOD_SPIRIT_SHORT"] = 2,
			["ITEM_MOD_STAMINA_SHORT"] = 2,
			["ITEM_MOD_STRENGTH_SHORT"] = 2,
		},
		[847] = {														-- Enchant Chest - Minor Stats
			["ITEM_MOD_AGILITY_SHORT"] = 1,
			["ITEM_MOD_INTELLECT_SHORT"] = 1,
			["ITEM_MOD_SPIRIT_SHORT"] = 1,
			["ITEM_MOD_STAMINA_SHORT"] = 1,
			["ITEM_MOD_STRENGTH_SHORT"] = 1,
		},
		[1144] = {														-- Enchant Chest - Major Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 15,
		},
		[2989] = {														-- Arcane Armor Kit
			["RESISTANCE6_NAME"] = 8,
		},
		[2985] = {														-- Flame Armor Kit
			["RESISTANCE2_NAME"] = 8,
		},
		[2987] = {														-- Frost Armor Kit
			["RESISTANCE4_NAME"] = 8,
		},
		[2988] = {														-- Nature Armor Kit
			["RESISTANCE3_NAME"] = 8,
		},
		[2984] = {														-- Shadow Armor Kit
			["RESISTANCE5_NAME"] = 8,
		},
	},
	-- Waist
	[6] = {
		[3729] = {														-- Eternal Belt Buckle
			-- adds a prismatic socket
		},
		[3599] = {														-- Personal Electromagnetic Pulse Generator
			-- Use: Confuse nearby mechanical units
			-- engineering 390
		},
		[3601] = {														-- Frag Belt
			-- Attach a miniaturized explosive assembly to your belt, allowing you to detach and throw a Cobalt Frag Bomb every 6 minutes.
			-- engineering 380
		},
	},
	-- Wrist [TODO]
	[9] = {
	},
	-- Ring #1
	[11] = {
		[3839] = {														-- Enchant Ring - Assault
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 40,
			-- enchanting 400
		},
		[3791] = {														-- Enchant Ring - Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 30,
			-- enchanting 400
		},
		[3840] = {														-- Enchant Ring - Greater Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 23,
			-- enchanting 400
		},
		[2931] = {														-- Enchant Ring - Stats
			["ITEM_MOD_AGILITY_SHORT"] = 4,
			["ITEM_MOD_INTELLECT_SHORT"] = 4,
			["ITEM_MOD_SPIRIT_SHORT"] = 4,
			["ITEM_MOD_STAMINA_SHORT"] = 4,
			["ITEM_MOD_STRENGTH_SHORT"] = 4,
			-- 35+
			-- enchanting 375
		},
		[2928] = {														-- Enchant Ring - Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 12,
			-- enchanting 360
		},
		[2930] = {														-- Enchant Ring - Healing Power
			["ITEM_MOD_SPELL_POWER_SHORT"] = 12,
			-- enchanting 370
		},
		[2929] = {														-- Enchant Ring - Striking
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 2/WeaponSpeed
			-- enchanting 360
		},
	},
	-- Ring #2
	[12] = {
		[3839] = {														-- Enchant Ring - Assault
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 40,
			-- enchanting 400
		},
		[3791] = {														-- Enchant Ring - Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 30,
			-- enchanting 400
		},
		[3840] = {														-- Enchant Ring - Greater Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 23,
			-- enchanting 400
		},
		[2931] = {														-- Enchant Ring - Stats
			["ITEM_MOD_AGILITY_SHORT"] = 4,
			["ITEM_MOD_INTELLECT_SHORT"] = 4,
			["ITEM_MOD_SPIRIT_SHORT"] = 4,
			["ITEM_MOD_STAMINA_SHORT"] = 4,
			["ITEM_MOD_STRENGTH_SHORT"] = 4,
			-- 35+
			-- enchanting 375
		},
		[2928] = {														-- Enchant Ring - Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 12,
			-- enchanting 360
		},
		[2930] = {														-- Enchant Ring - Healing Power
			["ITEM_MOD_SPELL_POWER_SHORT"] = 12,
			-- enchanting 370
		},
		[2929] = {														-- Enchant Ring - Striking
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 2/WeaponSpeed
			-- enchanting 360
		},
	},
	-- Ranged Slot
	[18] = {
		[3607] = {														-- Sun Scope
			["ITEM_MOD_HASTE_RATING_SHORT"] = 40,
			-- ranged only
		},
		[3608] = {														-- Heartseeker Scope
			["ITEM_MOD_CRIT_RATING_SHORT"] = 40,
			-- ranged only
		},
		[2724] = {														-- Stabilized Eternium Scope
			["ITEM_MOD_CRIT_RATING_SHORT"] = 28,
			-- ranged only
		},
		[2523] = {														-- Biznicks 247x128 Accurascope
			["ITEM_MOD_HIT_RATING_SHORT"] = 40,
			-- ranged only
		},
		[3843] = {														-- Diamond-cut Refractor Scope
			--["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 15/WeaponSpeed
			-- ranged only
		},
		[2723] = {														-- Khorium Scope
			--["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 12/WeaponSpeed
			-- ranged only
		},
		[2722] = {														-- Adamantite Scope
			--["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 10/WeaponSpeed
			-- ranged only
		},
		[664] = {														-- Sniper Scope
			--["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 7/WeaponSpeed
			-- ranged only
		},
		[663] = {														-- Deadly Scope
			--["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 5/WeaponSpeed
			-- ranged only
		},
		[33] = {														-- Accurate Scope
			--["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 3/WeaponSpeed
			-- ranged only
		},
		[32] = {														-- Standard Scope
			--["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 2/WeaponSpeed
			-- ranged only
		},
		[30] = {														-- Crude Scope
			--["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 1/WeaponSpeed
			-- ranged only
		},
	},
	-- Offhand
	[17] = {
		-- Shields
		[1952] = {														-- Enchant Shield - Defense
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 20,
			-- 60+
		},
		[2655] = {														-- Enchant Shield - Shield Block
			["ITEM_MOD_BLOCK_RATING_SHORT"] = 15,
			-- 35+
		},
		[863] = {														-- Enchant Shield - Lesser Block
			["ITEM_MOD_BLOCK_RATING_SHORT"] = 10,
		},
		[3849] = {														-- Titanium Plating
			["ITEM_MOD_BLOCK_VALUE_SHORT"] = 81,
			-- disarm duration -50%
		},
		[2653] = {														-- Enchant Shield - Tough Shield
			["ITEM_MOD_BLOCK_VALUE_SHORT"] = 36,
			-- 35+
		},
		[3229] = {														-- Enchant Shield - Resilience
			["ITEM_MOD_RESILIENCE_RATING_SHORT"] = 12,
			-- 35+
		},
		[3748] = {														-- Titanium Shield Spike
			-- deals 45-67 damage every time you block
		},
		[2714] = {														-- Felsteel Shield Spike
			-- deals 26-38 damage every time you block
		},
		[1704] = {														-- Thorium Shield Spike
			-- deals 20-30 damage every time you block
		},
		[463] = {														-- Mithril Shield Spike
			-- deals 16-20 damage every time you block
		},
		[43] = {														-- Iron Shield Spike
			-- deals 8-12 damage every time you block
		},
		[1888] = {														-- Enchant Shield - Resistance
			["RESISTANCE1_NAME"] = 5,
			["RESISTANCE2_NAME"] = 5,
			["RESISTANCE3_NAME"] = 5,
			["RESISTANCE4_NAME"] = 5,
			["RESISTANCE5_NAME"] = 5,
			["RESISTANCE6_NAME"] = 5,
			-- 35+
		},
		[926] = {														-- Enchant Shield - Frost Resistance
			["RESISTANCE4_NAME"] = 8,
		},
		[1128] = {														-- Enchant Shield - Greater Intellect
			["ITEM_MOD_INTELLECT_SHORT"] = 25,
			-- 60+
		},
		[2654] = {														-- Enchant Shield - Intellect
			["ITEM_MOD_INTELLECT_SHORT"] = 12,
			-- 35+
		},
		[1890] = {														-- Enchant Shield - Vitality
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 4,
			["ITEM_MOD_HEALTH_REGENERATION_SHORT"] = 4,
		},
		[907] = {														-- Enchant Shield - Greater Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 7,
		},
		[851] = {														-- Enchant Shield - Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 5,
		},
		[255] = {														-- Enchant Shield - Lesser Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 3,
		},
		[1071] = {														-- Enchant Shield - Major Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 18,
		},
		[929] = {														-- Enchant Shield - Greater Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 7,
		},
		[852] = {														-- Enchant Shield - Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 5,
		},
		[724] = {														-- Enchant Shield - Lesser Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 3,
		},
		[66] = {														-- Enchant Shield - Minor Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 1,
		},
		-- One-Hand
		[3594] = {														-- Rune of Swordbreaking
			["ITEM_MOD_PARRY_RATING_SHORT"] = 2*45.25018692,
			-- parry +2% [~90]
			-- disarm duration -50%
			-- runeforging
		},
		[3595] = {														-- Rune of Spellbreaking
			-- spell damage: deflect 2%
			-- silence duration -50%
			-- runeforging
		},
		[3368] = {														-- Rune of the Fallen Crusader
			-- proc: 3% maxhp heal
			-- strength + 15%
			-- runeforging
		},
		[3366] = {														-- Rune of Lichbane
			-- 2% extra weapon damage as Fire damage or 4% versus Undead targets
			-- runeforging
		},
		[3370] = {														-- Rune of Razorice
			--  2% extra weapon damage as Frost damage and has a chance to increase vulnerability to your Frost attacks
			-- runeforging
		},
		[3369] = {														-- Rune of Cinderglacier
			-- chance to increase the damage by 20% for your next 2 attacks that deal Frost or Shadow damage
			-- runeforging
		},
		[1103] = {														-- Enchant Weapon - Exceptional Agility
			["ITEM_MOD_AGILITY_SHORT"] = 26,
			-- 60+
		},
		[3222] = {														-- Enchant Weapon - Greater Agility
			["ITEM_MOD_AGILITY_SHORT"] = 20,
			-- 35+
		},
		[2564] = {														-- Enchant Weapon - Agility
			["ITEM_MOD_AGILITY_SHORT"] = 15,
		},
		[2666] = {														-- Enchant Weapon - Major Intellect
			["ITEM_MOD_INTELLECT_SHORT"] = 30,
			-- 35+
		},
		[2568] = {														-- Enchant Weapon - Mighty Intellect
			["ITEM_MOD_INTELLECT_SHORT"] = 22,
		},
		[3844] = {														-- Enchant Weapon - Exceptional Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 45,
			-- 60+
		},
		[2567] = {														-- Enchant Weapon - Mighty Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 20,
		},
		[2668] = {														-- Enchant Weapon - Potency
			["ITEM_MOD_STRENGTH_SHORT"] = 20,
			-- 35+
		},
		[2563] = {														-- Enchant Weapon - Strength
			["ITEM_MOD_STRENGTH_SHORT"] = 15,
		},
		[963] = {														-- Enchant Weapon - Major Striking
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 7/WeaponSpeed
			-- 35+
		},
		[1897] = {														-- Enchant Weapon - Superior Striking
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 5/WeaponSpeed
		},
		[805] = {														-- Enchant Weapon - Greater Striking
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 4/WeaponSpeed
		},
		[943] = {														-- Enchant Weapon - Striking
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 3/WeaponSpeed
		},
		[241] = {														-- Enchant Weapon - Lesser Striking
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 2/WeaponSpeed
		},
		[250] = {														-- Enchant Weapon - Minor Striking
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 1/WeaponSpeed
		},
		[853] = {														-- Enchant Weapon - Lesser Beastslayer
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 6/WeaponSpeed against beasts
		},
		[249] = {														-- Enchant Weapon - Minor Beastslayer
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 2/WeaponSpeed against beasts
		},
		[854] = {														-- Enchant Weapon - Lesser Elemental Slayer
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 6/WeaponSpeed against elementals
		},
		[3869] = {														-- Enchant Weapon - Blade Ward
			-- TODO
		},
		[3870] = {														-- Enchant Weapon - Blood Draining
			-- TODO
		},
		[3790] = {														-- Enchant Weapon - Black Magic
			-- TODO
			-- 60+
		},
		[3241] = {														-- Enchant Weapon - Lifeward
			-- hps depends too much on your weapon / attacks :( TODO
			-- 60+
		},
		[3789] = {														-- Enchant Weapon - Berserking
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 100,
			["RESISTANCE0_NAME"] = -150,	-- TODO: actually, it's -5%
			-- 60+
		},
		[3251] = {														-- Enchant Weapon - Giant Slayer
			-- reducing movement speed and doing additional damage against giants
			-- 60+
		},
		[3239] = {														-- Enchant Weapon - Icebreaker
			["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 4.3, -- (?)
			-- 60+
		},
		[3225] = {														-- Enchant Weapon - Executioner
			["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 100, -- (?)
			-- 60+
		},
		[2674] = {														-- Enchant Weapon - Spellsurge
			-- TODO
			-- 35+
		},
		[2673] = {														-- Enchant Weapon - Mongoose
			-- TODO
			-- 35+
		},
		[2675] = {														-- Enchant Weapon - Battlemaster
			-- TODO
			-- 35+
		},
		[3273] = {														-- Enchant Weapon - Deathfrost
			--  cause your damaging spells and melee weapon hits to occasionally inflict additional Frost damage and slow the target
			-- 60+
		},
		[1900] = {														-- Enchant Weapon - Crusader
			-- heal for 75 to 125 and increase Strength by 100 for 15 sec. when attacking in melee
			-- reduced effect for players above level 60
			-- TODO
		},
		[912] = {														-- Enchant Weapon - Demonslaying
			--  chance of stunning and doing additional damage against demons
			-- TODO
		},
		[803] = {														-- Enchant Weapon - Fiery Weapon
			["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 4,
			-- TODO
		},
		[1894] = {														-- Enchant Weapon - Icy Chill
			-- often chill the target, reducing their movement and attack speed
			-- reduced effect for players above level 60
			-- TODO
		},
		[1898] = {														-- Enchant Weapon - Lifestealing
			-- often steal life from the enemy and give it to the wielder
			-- reduced effect for players above level 60
			-- TODO
		},
		[1899] = {														-- Enchant Weapon - Unholy Weapon
			-- often inflict a curse on the target, reducing their melee damage
			-- TODO
		},
		[36] = {														-- Fiery Blaze Enchantment
			-- 15% chance to inflict 9 to 13 Fire damage to all enemies within 3 yards
			-- TODO
		},
		[3833] = {														-- Enchant Weapon - Superior Potency
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 65,
			-- 60+
		},
		[1606] = {														-- Enchant Weapon - Greater Potency
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 50,
			-- 60+
		},
		[3834] = {														-- Enchant Weapon - Mighty Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 63,
			-- 60+
		},
		[3830] = {														-- Enchant Weapon - Exceptional Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 50,
			-- 60+
		},
		[2669] = {														-- Enchant Weapon - Major Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 40,
			-- 35+
		},
		[3846] = {														-- Enchant Weapon - Major Healing
			["ITEM_MOD_SPELL_POWER_SHORT"] = 40,
			-- 35+
		},
		[2504] = {														-- Enchant Weapon - Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 30,
		},
		[2505] = {														-- Enchant Weapon - Healing Power
			["ITEM_MOD_SPELL_POWER_SHORT"] = 29,
		},
		[2671] = {														-- Enchant Weapon - Sunfire
			-- TODO: fire + arcane + 50 spp
			-- 35+
		},
		[2672] = {														-- Enchant Weapon - Soulfrost
			-- TODO: shadow + frost + 54 spp
			-- 35+
		},
		[2443] = {														-- Enchant Weapon - Winter's Might
			-- TODO: frost spp + 7
		},
		[3788] = {														-- Enchant Weapon - Accuracy
			["ITEM_MOD_CRIT_RATING_SHORT"] = 25,
			["ITEM_MOD_HIT_RATING_SHORT"] = 25,
			-- 60+
		},
		[3731] = {														-- Titanium Weapon Chain
			["ITEM_MOD_HIT_RATING_SHORT"] = 28,
			-- disarm duration -50%
		},
		[3223] = {														-- Adamantite Weapon Chain
			["ITEM_MOD_PARRY_RATING_SHORT"] = 15,
			-- disarm duration -50%
		},
		[37] = {														-- Steel Weapon Chain
			-- disarm duration -50%
		},
	},
	-- Main Hand
	[16] = {
		-- One-Hand
		[3594] = {														-- Rune of Swordbreaking
			["ITEM_MOD_PARRY_RATING_SHORT"] = 2*45.25018692,
			-- parry +2% [~90]
			-- disarm duration -50%
			-- runeforging
		},
		[3595] = {														-- Rune of Spellbreaking
			-- spell damage: deflect 2%
			-- silence duration -50%
			-- runeforging
		},
		[3368] = {														-- Rune of the Fallen Crusader
			-- proc: 3% maxhp heal
			-- strength + 15%
			-- runeforging
		},
		[3366] = {														-- Rune of Lichbane
			-- 2% extra weapon damage as Fire damage or 4% versus Undead targets
			-- runeforging
		},
		[3370] = {														-- Rune of Razorice
			--  2% extra weapon damage as Frost damage and has a chance to increase vulnerability to your Frost attacks
			-- runeforging
		},
		[3369] = {														-- Rune of Cinderglacier
			-- chance to increase the damage by 20% for your next 2 attacks that deal Frost or Shadow damage
			-- runeforging
		},
		[1103] = {														-- Enchant Weapon - Exceptional Agility
			["ITEM_MOD_AGILITY_SHORT"] = 26,
			-- 60+
		},
		[3222] = {														-- Enchant Weapon - Greater Agility
			["ITEM_MOD_AGILITY_SHORT"] = 20,
			-- 35+
		},
		[2564] = {														-- Enchant Weapon - Agility
			["ITEM_MOD_AGILITY_SHORT"] = 15,
		},
		[2666] = {														-- Enchant Weapon - Major Intellect
			["ITEM_MOD_INTELLECT_SHORT"] = 30,
			-- 35+
		},
		[2568] = {														-- Enchant Weapon - Mighty Intellect
			["ITEM_MOD_INTELLECT_SHORT"] = 22,
		},
		[3844] = {														-- Enchant Weapon - Exceptional Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 45,
			-- 60+
		},
		[2567] = {														-- Enchant Weapon - Mighty Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 20,
		},
		[2668] = {														-- Enchant Weapon - Potency
			["ITEM_MOD_STRENGTH_SHORT"] = 20,
			-- 35+
		},
		[2563] = {														-- Enchant Weapon - Strength
			["ITEM_MOD_STRENGTH_SHORT"] = 15,
		},
		[963] = {														-- Enchant Weapon - Major Striking
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 7/WeaponSpeed
			-- 35+
		},
		[1897] = {														-- Enchant Weapon - Superior Striking
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 5/WeaponSpeed
		},
		[805] = {														-- Enchant Weapon - Greater Striking
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 4/WeaponSpeed
		},
		[943] = {														-- Enchant Weapon - Striking
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 3/WeaponSpeed
		},
		[241] = {														-- Enchant Weapon - Lesser Striking
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 2/WeaponSpeed
		},
		[250] = {														-- Enchant Weapon - Minor Striking
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 1/WeaponSpeed
		},
		[853] = {														-- Enchant Weapon - Lesser Beastslayer
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 6/WeaponSpeed against beasts
		},
		[249] = {														-- Enchant Weapon - Minor Beastslayer
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 2/WeaponSpeed against beasts
		},
		[854] = {														-- Enchant Weapon - Lesser Elemental Slayer
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 6/WeaponSpeed against elementals
		},
		[3869] = {														-- Enchant Weapon - Blade Ward
			-- TODO
		},
		[3870] = {														-- Enchant Weapon - Blood Draining
			-- TODO
		},
		[3790] = {														-- Enchant Weapon - Black Magic
			-- TODO
			-- 60+
		},
		[3241] = {														-- Enchant Weapon - Lifeward
			-- hps depends too much on your weapon / attacks :( TODO
			-- 60+
		},
		[3789] = {														-- Enchant Weapon - Berserking
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 100,
			["RESISTANCE0_NAME"] = -150,	-- TODO: actually, it's -5%
			-- 60+
		},
		[3251] = {														-- Enchant Weapon - Giant Slayer
			-- reducing movement speed and doing additional damage against giants
			-- 60+
		},
		[3239] = {														-- Enchant Weapon - Icebreaker
			["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 4.3, -- (?)
			-- 60+
		},
		[3225] = {														-- Enchant Weapon - Executioner
			["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 100, -- (?)
			-- 60+
		},
		[2674] = {														-- Enchant Weapon - Spellsurge
			-- TODO
			-- 35+
		},
		[2673] = {														-- Enchant Weapon - Mongoose
			-- TODO
			-- 35+
		},
		[2675] = {														-- Enchant Weapon - Battlemaster
			-- TODO
			-- 35+
		},
		[3273] = {														-- Enchant Weapon - Deathfrost
			--  cause your damaging spells and melee weapon hits to occasionally inflict additional Frost damage and slow the target
			-- 60+
		},
		[1900] = {														-- Enchant Weapon - Crusader
			-- heal for 75 to 125 and increase Strength by 100 for 15 sec. when attacking in melee
			-- reduced effect for players above level 60
			-- TODO
		},
		[912] = {														-- Enchant Weapon - Demonslaying
			--  chance of stunning and doing additional damage against demons
			-- TODO
		},
		[803] = {														-- Enchant Weapon - Fiery Weapon
			["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 4,
			-- TODO
		},
		[1894] = {														-- Enchant Weapon - Icy Chill
			-- often chill the target, reducing their movement and attack speed
			-- reduced effect for players above level 60
			-- TODO
		},
		[1898] = {														-- Enchant Weapon - Lifestealing
			-- often steal life from the enemy and give it to the wielder
			-- reduced effect for players above level 60
			-- TODO
		},
		[1899] = {														-- Enchant Weapon - Unholy Weapon
			-- often inflict a curse on the target, reducing their melee damage
			-- TODO
		},
		[36] = {														-- Fiery Blaze Enchantment
			-- 15% chance to inflict 9 to 13 Fire damage to all enemies within 3 yards
			-- TODO
		},
		[3833] = {														-- Enchant Weapon - Superior Potency
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 65,
			-- 60+
		},
		[1606] = {														-- Enchant Weapon - Greater Potency
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 50,
			-- 60+
		},
		[3834] = {														-- Enchant Weapon - Mighty Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 63,
			-- 60+
		},
		[3830] = {														-- Enchant Weapon - Exceptional Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 50,
			-- 60+
		},
		[2669] = {														-- Enchant Weapon - Major Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 40,
			-- 35+
		},
		[3846] = {														-- Enchant Weapon - Major Healing
			["ITEM_MOD_SPELL_POWER_SHORT"] = 40,
			-- 35+
		},
		[2504] = {														-- Enchant Weapon - Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 30,
		},
		[2505] = {														-- Enchant Weapon - Healing Power
			["ITEM_MOD_SPELL_POWER_SHORT"] = 29,
		},
		[2671] = {														-- Enchant Weapon - Sunfire
			-- TODO: fire + arcane + 50 spp
			-- 35+
		},
		[2672] = {														-- Enchant Weapon - Soulfrost
			-- TODO: shadow + frost + 54 spp
			-- 35+
		},
		[2443] = {														-- Enchant Weapon - Winter's Might
			-- TODO: frost spp + 7
		},
		[3788] = {														-- Enchant Weapon - Accuracy
			["ITEM_MOD_CRIT_RATING_SHORT"] = 25,
			["ITEM_MOD_HIT_RATING_SHORT"] = 25,
			-- 60+
		},
		[3731] = {														-- Titanium Weapon Chain
			["ITEM_MOD_HIT_RATING_SHORT"] = 28,
			-- disarm duration -50%
		},
		[3223] = {														-- Adamantite Weapon Chain
			["ITEM_MOD_PARRY_RATING_SHORT"] = 15,
			-- disarm duration -50%
		},
		[37] = {														-- Steel Weapon Chain
			-- disarm duration -50%
		},
		-- Two-Hand
		[1896] = {														-- Enchant 2H Weapon - Superior Impact
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 9/WeaponSpeed,
		},
		[963] = {														-- Enchant 2H Weapon - Greater Impact
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 7/WeaponSpeed,
		},
		[1897] = {														-- Enchant 2H Weapon - Impact
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 5/WeaponSpeed,
		},
		[943] = {														-- Enchant 2H Weapon - Lesser Impact
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 3/WeaponSpeed,
		},
		[241] = {														-- Enchant 2H Weapon - Minor Impact
			-- ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 2/WeaponSpeed,
		},
		[3827] = {														-- Enchant 2H Weapon - Massacre
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 110,
			-- 60+
		},
		[3828] = {														-- Enchant 2H Weapon - Greater Savagery
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 85,
			-- 60+
		},
		[2667] = {														-- Enchant 2H Weapon - Savagery
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 70,
			-- 35+
		},
		[3247] = {														-- Enchant 2H Weapon - Scourgebane
			-- ["ITEM_MOD_ATTACK_POWER_SHORT"] = 140, against undead
			-- 35+
			-- TODO
		},
		[3854] = {														-- Enchant Staff - Greater Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 81,
			-- 60+
		},
		[3855] = {														-- Enchant Staff - Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 69,
			-- 60+
		},
		[34] = {														-- Iron Counterweight
			["ITEM_MOD_HASTE_RATING_SHORT"] = 20,
		},
		[2670] = {														-- Enchant 2H Weapon - Major Agility
			["ITEM_MOD_AGILITY_SHORT"] = 35,
			-- 35+
		},
		[2646] = {														-- Enchant 2H Weapon - Agility
			["ITEM_MOD_AGILITY_SHORT"] = 25,
		},
		[1904] = {														-- Enchant 2H Weapon - Major Intellect
			["ITEM_MOD_INTELLECT_SHORT"] = 9,
		},
		[723] = {														-- Enchant 2H Weapon - Lesser Intellect
			["ITEM_MOD_INTELLECT_SHORT"] = 3,
		},
		[1903] = {														-- Enchant 2H Weapon - Major Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 9,
		},
		[255] = {														-- Enchant 2H Weapon - Lesser Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 3,
		},
		[3367] = {														-- Rune of Spellshattering
			-- spell damage: deflect 4%
			-- silence duration -50%
			-- runeforging
		},
		[3365] = {														-- Rune of Swordshattering
			["ITEM_MOD_PARRY_RATING_SHORT"] = 4*45.25018692,
			-- parry +4% [~90]
			-- disarm duration -50%
			-- runeforging
		},
	},
	-- Wrist
	[9] = {
		[3231] = {														-- Enchant Bracers - Expertise
			["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 15,
			-- 60+
		},
		[3845] = {														-- Enchant Bracers - Greater Assault
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 50,
			-- 60+
		},
		[1600] = {														-- Enchant Bracers - Striking
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 38,
			-- 60+
		},
		[1593] = {														-- Enchant Bracer - Assault
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 24,
			-- 35+
		},
		[2332] = {														-- Enchant Bracers - Superior Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 30,
			-- 60+
		},
		[2326] = {														-- Enchant Bracers - Greater Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 23,
			-- 60+
		},
		[2650] = {														-- Enchant Bracer - Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 15,
			-- 35+
		},
		[2650] = {														-- Enchant Bracer - Superior Healing
			["ITEM_MOD_SPELL_POWER_SHORT"] = 15,
			-- 35+
		},
		[2650] = {														-- Enchant Bracer - Healing Power
			["ITEM_MOD_SPELL_POWER_SHORT"] = 15,
		},
		[2679] = {														-- Enchant Bracer - Restore Mana Prime
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 8,
			-- 35+
		},
		[2565] = {														-- Enchant Bracer - Mana Regeneration
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 5,
		},
		[41] = {														-- Enchant Bracer - Minor Health
			["ITEM_MOD_HEALTH_SHORT"] = 5,
		},
		[2648] = {														-- Enchant Bracer - Major Defense
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 12,
			-- 35+
		},
		[923] = {														-- Enchant Bracer - Deflection
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 5,
		},
		[925] = {														-- Enchant Bracer - Lesser Deflection
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 3,
		},
		[924] = {														-- Enchant Bracer - Minor Deflection
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 2,
		},
		[1891] = {														-- Enchant Bracer - Stats
			["ITEM_MOD_AGILITY_SHORT"] = 4,
			["ITEM_MOD_INTELLECT_SHORT"] = 4,
			["ITEM_MOD_SPIRIT_SHORT"] = 4,
			["ITEM_MOD_STAMINA_SHORT"] = 4,
			["ITEM_MOD_STRENGTH_SHORT"] = 4,
			-- 35+
		},
		[2661] = {														-- Enchant Bracers - Greater Stats
			["ITEM_MOD_AGILITY_SHORT"] = 6,
			["ITEM_MOD_INTELLECT_SHORT"] = 6,
			["ITEM_MOD_SPIRIT_SHORT"] = 6,
			["ITEM_MOD_STAMINA_SHORT"] = 6,
			["ITEM_MOD_STRENGTH_SHORT"] = 6,
			-- 60+
		},
		[247] = {														-- Enchant Bracer - Minor Agility
			["ITEM_MOD_AGILITY_SHORT"] = 1,
		},
		[1119] = {														-- Enchant Bracers - Exceptional Intellect
			["ITEM_MOD_INTELLECT_SHORT"] = 16,
			-- 60+
		},
		[369] = {														-- Enchant Bracer - Major Intellect
			["ITEM_MOD_INTELLECT_SHORT"] = 12,
			-- 35+
		},
		[1883] = {														-- Enchant Bracer - Greater Intellect
			["ITEM_MOD_INTELLECT_SHORT"] = 7,
		},
		[905] = {														-- Enchant Bracer - Intellect
			["ITEM_MOD_INTELLECT_SHORT"] = 5,
		},
		[723] = {														-- Enchant Bracer - Lesser Intellect
			["ITEM_MOD_INTELLECT_SHORT"] = 3,
		},
		[1147] = {														-- Enchant Bracers - Major Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 18,
			-- 60+
		},
		[1884] = {														-- Enchant Bracer - Superior Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 9,
		},
		[907] = {														-- Enchant Bracer - Greater Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 7,
		},
		[851] = {														-- Enchant Bracer - Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 5,
		},
		[255] = {														-- Enchant Bracer - Lesser Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 3,
		},
		[243] = {														-- Enchant Bracer - Minor Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 1,
		},
		[3850] = {														-- Enchant Bracers - Major Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 40,
			-- 60+
		},
		[2649] = {														-- Enchant Bracer - Fortitude
			["ITEM_MOD_STAMINA_SHORT"] = 12,
			-- 35+
		},
		[1886] = {														-- Enchant Bracer - Superior Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 9,
		},
		[929] = {														-- Enchant Bracer - Greater Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 7,
		},
		[852] = {														-- Enchant Bracer - Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 5,
		},
		[724] = {														-- Enchant Bracer - Lesser Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 3,
		},
		[66] = {														-- Enchant Bracer - Minor Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 1,
		},
		[2647] = {														-- Enchant Bracer - Brawn
			["ITEM_MOD_STRENGTH_SHORT"] = 12,
			-- 35+
		},
		[1885] = {														-- Enchant Bracer - Superior Strength
			["ITEM_MOD_STRENGTH_SHORT"] = 9,
		},
		[927] = {														-- Enchant Bracer - Greater Strength
			["ITEM_MOD_STRENGTH_SHORT"] = 7,
		},
		[856] = {														-- Enchant Bracer - Strength
			["ITEM_MOD_STRENGTH_SHORT"] = 5,
		},
		[823] = {														-- Enchant Bracer - Lesser Strength
			["ITEM_MOD_STRENGTH_SHORT"] = 3,
		},
		[248] = {														-- Enchant Bracer - Minor Strength
			["ITEM_MOD_STRENGTH_SHORT"] = 1,
		},
		[3756] = {														-- Fur Lining - Attack Power
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 130,
			-- leatherworking 400
		},
		[3758] = {														-- Fur Lining - Spell Power
			["ITEM_MOD_SPELL_POWER_SHORT"] = 76,
			-- leatherworking 400
		},
		[3757] = {														-- Fur Lining - Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 102,
		},
		[3763] = {														-- Fur Lining - Arcane Resist
			["RESISTANCE6_NAME"] = 70,
			-- leatherworking 400
		},
		[3759] = {														-- Fur Lining - Fire Resist
			["RESISTANCE2_NAME"] = 70,
			-- leatherworking 400
		},
		[3760] = {														-- Fur Lining - Frost Resist
			["RESISTANCE4_NAME"] = 70,
			-- leatherworking 400
		},
		[3762] = {														-- Fur Lining - Nature Resist
			["RESISTANCE3_NAME"] = 70,
			-- leatherworking 400
		},
		[3761] = {														-- Fur Lining - Shadow Resist
			["RESISTANCE5_NAME"] = 70,
			-- leatherworking 400
		},
		[3717] = {														-- Socket Bracer
			-- adds a prismtic socket to your bracers
			-- 60+
			-- blacksmithing 400
		},
	},
	-- Hands
	[10] = {
		[3330] = {														-- Heavy Borean Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 18,
			-- 70+
		},
		[3329] = {														-- Borean Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 12,
			-- 70+
		},
		[2841] = {														-- Heavy Knothide Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			-- 60+
		},
		[2792] = {														-- Knothide Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			-- 55+
		},
		[1843] = {														-- Rugged Armor Kit
			["RESISTANCE0_NAME"] = 40,
			-- 35+
		},
		[18] = {														-- Thick Armor Kit
			["RESISTANCE0_NAME"] = 32,
			-- 25+
		},
		[17] = {														-- Heavy Armor Kit
			["RESISTANCE0_NAME"] = 24,
			-- 15+
		},
		[16] = {														-- Medium Armor Kit
			["RESISTANCE0_NAME"] = 16,
		},
		[15] = {														-- Light Armor Kit
			["RESISTANCE0_NAME"] = 8,
		},
		[2793] = {														-- Vindicator's Armor Kit
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 8,
		},
		[2503] = {														-- Core Armor Kit
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 5,
		},
		[2794] = {														-- Magister's Armor Kit
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 4,
		},
		[3260] = {														-- Glove Reinforcements
			["RESISTANCE0_NAME"] = 240,
		},
		[3246] = {														-- Enchant Gloves - Exceptional Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 28,
			-- 60+
		},
		[2937] = {														-- Enchant Gloves - Major Spellpower
			["ITEM_MOD_SPELL_POWER_SHORT"] = 20,
			-- 35+
		},
		[2322] = {														-- Enchant Gloves - Major Healing
			["ITEM_MOD_SPELL_POWER_SHORT"] = 19,
			-- 35+
		},
		[2617] = {														-- Enchant Gloves - Healing Power
			["ITEM_MOD_SPELL_POWER_SHORT"] = 16,
		},
		[2616] = {														-- Enchant Gloves - Fire Power
			-- TODO: 20 fire spell power
		},
		[2615] = {														-- Enchant Gloves - Frost Power
			-- TODO: 20 frost spell power
		},
		[2614] = {														-- Enchant Gloves - Shadow Power
			-- TODO: 20 shadow spell power
		},
		[3231] = {														-- Enchant Gloves - Expertise
			["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 15,
			-- 60+
		},
		[3234] = {														-- Enchant Gloves - Precision
			["ITEM_MOD_HIT_RATING_SHORT"] = 20,
			-- 60+
		},
		[2935] = {														-- Enchant Gloves - Precise Strikes
			["ITEM_MOD_HIT_RATING_SHORT"] = 15,
			-- 35+
		},
		[2934] = {														-- Enchant Gloves - Blasting
			["ITEM_MOD_CRIT_RATING_SHORT"] = 10,
			-- 35+
		},
		[1603] = {														-- Enchant Gloves - Crusher
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 44,
			-- 60+
		},
		[3829] = {														-- Enchant Gloves - Greater Assault
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 35,
			-- 60+
		},
		[1594] = {														-- Enchant Gloves - Assault
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 26,
			-- 35+
		},
		[3253] = {														-- Enchant Gloves - Armsman
			["ITEM_MOD_PARRY_RATING_SHORT"] = 10,
			-- TODO: +2% Threat
			-- 60+
		},
		[2613] = {														-- Enchant Gloves - Threat
			-- TODO: +2% Threat
		},
		[931] = {														-- Enchant Gloves - Minor Haste
			["ITEM_MOD_HASTE_RATING_SHORT"] = 10,
		},
		[3238] = {														-- Enchant Gloves - Gatherer
			-- TODO: mining, herbalism, skinning +5
			-- 60+
		},
		[846] = {														-- Enchant Gloves - Fishing
			-- TODO: fishing +2
		},
		[909] = {														-- Enchant Gloves - Advanced Herbalism
			-- TODO: herbalism +5
		},
		[845] = {														-- Enchant Gloves - Herbalism
			-- TODO: herbalism +2
		},
		[906] = {														-- Enchant Gloves - Advanced Mining
			-- TODO: mining +5
		},
		[844] = {														-- Enchant Gloves - Mining
			-- TODO: mining +2
		},
		[865] = {														-- Enchant Gloves - Skinning
			-- TODO: skinning +5
		},
		[930] = {														-- Enchant Gloves - Riding Skill
			-- increase mount speed by 2%
			-- 70-
		},
		[3222] = {														-- Enchant Gloves - Major Agility
			["ITEM_MOD_AGILITY_SHORT"] = 20,
			-- 60+
		},
		[2564] = {														-- Enchant Gloves - Superior Agility
			["ITEM_MOD_AGILITY_SHORT"] = 15,
		},
		[1887] = {														-- Enchant Gloves - Greater Agility
			["ITEM_MOD_AGILITY_SHORT"] = 7,
		},
		[904] = {														-- Enchant Gloves - Agility
			["ITEM_MOD_AGILITY_SHORT"] = 5,
		},
		[684] = {														-- Enchant Gloves - Major Strength
			["ITEM_MOD_STRENGTH_SHORT"] = 15,
			-- 35+
		},
		[927] = {														-- Enchant Gloves - Greater Strength
			["ITEM_MOD_STRENGTH_SHORT"] = 7,
		},
		[856] = {														-- Enchant Gloves - Strength
			["ITEM_MOD_STRENGTH_SHORT"] = 5,
		},
		[2989] = {														-- Arcane Armor Kit
			["RESISTANCE6_NAME"] = 8,
		},
		[2985] = {														-- Flame Armor Kit
			["RESISTANCE2_NAME"] = 8,
		},
		[2987] = {														-- Frost Armor Kit
			["RESISTANCE4_NAME"] = 8,
		},
		[2988] = {														-- Nature Armor Kit
			["RESISTANCE3_NAME"] = 8,
		},
		[2984] = {														-- Shadow Armor Kit
			["RESISTANCE5_NAME"] = 8,
		},
		[3603] = {														-- Hand-Mounted Pyro Rocket
			["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 40.8, -- (?)
			-- deal 1654 to 2020 Fire damage (45 yards range!), 45sec CD
			-- engineering 400
		},
		[3604] = {														-- Hyperspeed Accelerators
			["ITEM_MOD_HASTE_RATING_SHORT"] = 68, -- (?)
			-- engineering 400
		},
		[3860] = {														-- Reticulated Armor Webbing
			["RESISTANCE0_NAME"] = 885,
			-- engineering 400
		},
		[3723] = {														-- Socket Gloves
			-- TODO: adds a prismatic socket to yout gloves
			-- blacksmithing 400
		},
	},
	-- Legs
	[7] = {
		[3330] = {														-- Heavy Borean Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 18,
			-- 70+
		},
		[3329] = {														-- Borean Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 12,
			-- 70+
		},
		[2841] = {														-- Heavy Knothide Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			-- 60+
		},
		[2792] = {														-- Knothide Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			-- 55+
		},
		[1843] = {														-- Rugged Armor Kit
			["RESISTANCE0_NAME"] = 40,
			-- 35+
		},
		[18] = {														-- Thick Armor Kit
			["RESISTANCE0_NAME"] = 32,
			-- 25+
		},
		[17] = {														-- Heavy Armor Kit
			["RESISTANCE0_NAME"] = 24,
			-- 15+
		},
		[16] = {														-- Medium Armor Kit
			["RESISTANCE0_NAME"] = 16,
		},
		[15] = {														-- Light Armor Kit
			["RESISTANCE0_NAME"] = 8,
		},
		[2793] = {														-- Vindicator's Armor Kit
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 8,
		},
		[2503] = {														-- Core Armor Kit
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 5,
		},
		[2794] = {														-- Magister's Armor Kit
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 4,
		},
		[1504] = {														-- Lesser Arcanum of Tenacity
			["RESISTANCE0_NAME"] = 125,
		},
		[1507] = {														-- Lesser Arcanum of Voracity
			["ITEM_MOD_STAMINA_SHORT"] = 8,
		},
		[1506] = {														-- Lesser Arcanum of Voracity
			["ITEM_MOD_STRENGTH_SHORT"] = 8,
		},
		[1508] = {														-- Lesser Arcanum of Voracity
			["ITEM_MOD_AGILITY_SHORT"] = 8,
		},
		[1509] = {														-- Lesser Arcanum of Voracity
			["ITEM_MOD_INTELLECT_SHORT"] = 8,
		},
		[1510] = {														-- Lesser Arcanum of Voracity
			["ITEM_MOD_SPIRIT_SHORT"] = 8,
		},
		[2544] = {														-- Arcanum of Focus
			["ITEM_MOD_SPELL_POWER_SHORT"] = 8,
		},
		[2543] = {														-- Arcanum of Rapidity
			["ITEM_MOD_HASTE_RATING_SHORT"] = 10,
		},
		[2545] = {														-- Arcanum of Protection
			["ITEM_MOD_DODGE_RATING_SHORT"] = 12,
		},
		[1503] = {														-- Lesser Arcanum of Constitution
			["ITEM_MOD_HEALTH_SHORT"] = 100,
		},
		[1483] = {														-- Lesser Arcanum of Rumination
			["ITEM_MOD_MANA_SHORT"] = 150,
		},
		[3822] = {														-- Frosthide Leg Armor
			["ITEM_MOD_STAMINA_SHORT"] = 55,
			["ITEM_MOD_AGILITY_SHORT"] = 22,
			-- 80+
		},
		[3325] = {														-- Jormungar Leg Armor
			["ITEM_MOD_STAMINA_SHORT"] = 45,
			["ITEM_MOD_AGILITY_SHORT"] = 15,
			-- 70+
		},
		[3013] = {														-- Nethercleft Leg Armor
			["ITEM_MOD_STAMINA_SHORT"] = 40,
			["ITEM_MOD_AGILITY_SHORT"] = 12,
			-- 60+
		},
		[3011] = {														-- Clefthide Leg Armor
			["ITEM_MOD_STAMINA_SHORT"] = 30,
			["ITEM_MOD_AGILITY_SHORT"] = 10,
			-- 50+
		},
		[2989] = {														-- Arcane Armor Kit
			["RESISTANCE6_NAME"] = 8,
			-- 60+
		},
		[1505] = {														-- Lesser Arcanum of Resilience
			["RESISTANCE2_NAME"] = 20,
		},
		[2985] = {														-- Flame Armor Kit
			["RESISTANCE2_NAME"] = 8,
			-- 65+
		},
		[2682] = {														-- Ice Guard
			["RESISTANCE4_NAME"] = 10,
			-- 55+
		},
		[2987] = {														-- Frost Armor Kit
			["RESISTANCE4_NAME"] = 8,
			-- 65+
		},
		[2681] = {														-- Savage Guard
			["RESISTANCE3_NAME"] = 10,
			-- 55+
		},
		[2988] = {														-- Nature Armor Kit
			["RESISTANCE3_NAME"] = 8,
			-- 65+
		},
		[2683] = {														-- Shadow Guard
			["RESISTANCE5_NAME"] = 10,
			-- 55+
		},
		[2984] = {														-- Shadow Armor Kit
			["RESISTANCE5_NAME"] = 8,
			-- 65+
		},
		[3853] = {														-- Earthen Leg Armor
			["ITEM_MOD_RESILIENCE_RATING_SHORT"] = 40,
			["ITEM_MOD_STAMINA_SHORT"] = 28,
			-- 80+
		},
		[3823] = {														-- Icescale Leg Armor
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 75,
			["ITEM_MOD_CRIT_RATING_SHORT"] = 22,
			-- 80+
		},
		[3326] = {														-- Nerubian Leg Armor
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 55,
			["ITEM_MOD_CRIT_RATING_SHORT"] = 15,
			-- 70+
		},
		[3012] = {														-- Nethercobra Leg Armor
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 50,
			["ITEM_MOD_CRIT_RATING_SHORT"] = 12,
			-- 60+
		},
		[3010] = {														-- Cobrahide Leg Armor
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 40,
			["ITEM_MOD_CRIT_RATING_SHORT"] = 10,
			-- 50+
		},
		[3719] = {														-- Brilliant Spellthread
			["ITEM_MOD_SPELL_POWER_SHORT"] = 50,
			["ITEM_MOD_SPIRIT_SHORT"] = 20,
			-- 70+
		},
		[3718] = {														-- Shining Spellthread
			["ITEM_MOD_SPELL_POWER_SHORT"] = 35,
			["ITEM_MOD_SPIRIT_SHORT"] = 12,
			-- 70+
		},
		[3721] = {														-- Sapphire Spellthread
			["ITEM_MOD_SPELL_POWER_SHORT"] = 50,
			["ITEM_MOD_STAMINA_SHORT"] = 30,
			-- 70+
		},
		[3720] = {														-- Azure Spellthread
			["ITEM_MOD_SPELL_POWER_SHORT"] = 35,
			["ITEM_MOD_STAMINA_SHORT"] = 20,
			-- 70+
		},
		[2746] = {														-- Golden Spellthread
			["ITEM_MOD_SPELL_POWER_SHORT"] = 35,
			["ITEM_MOD_STAMINA_SHORT"] = 20,
			-- 60+
		},
		[2748] = {														-- Runic Spellthread
			["ITEM_MOD_SPELL_POWER_SHORT"] = 35,
			["ITEM_MOD_STAMINA_SHORT"] = 20,
			-- 60+
		},
		[2745] = {														-- Silver Spellthread
			["ITEM_MOD_SPELL_POWER_SHORT"] = 25,
			["ITEM_MOD_STAMINA_SHORT"] = 15,
			-- 50+
		},
		[2747] = {														-- Mystic Spellthread
			["ITEM_MOD_SPELL_POWER_SHORT"] = 25,
			["ITEM_MOD_STAMINA_SHORT"] = 15,
			-- 50+
		},
		[3752] = {														-- Falcon's Call
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 24,
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			["ITEM_MOD_HIT_RATING_SHORT"] = 10,
		},
		[2588] = {														-- Presence of Sight
			["ITEM_MOD_SPELL_POWER_SHORT"] = 18,
			["ITEM_MOD_HIT_RATING_SHORT"] = 8,
		},
		[2584] = {														-- Syncretist's Sigil
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 10,
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			["ITEM_MOD_SPELL_POWER_SHORT"] = 12,
		},
		[2590] = {														-- Prophetic Aura
			["ITEM_MOD_SPELL_POWER_SHORT"] = 13,
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 5,
		},
		[3755] = {														-- Death's Embrace
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 28,
			["ITEM_MOD_DODGE_RATING_SHORT"] = 12,
		},
		[2587] = {														-- Vodouisant's Vigilant Embrace
			["ITEM_MOD_SPELL_POWER_SHORT"] = 13,
			["ITEM_MOD_INTELLECT_SHORT"] = 15,
		},
		[2589] = {														-- Hoodoo Hex
			["ITEM_MOD_SPELL_POWER_SHORT"] = 18,
			["ITEM_MOD_STAMINA_SHORT"] = 10,
		},
		[2583] = {														-- Presence of Might
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 10,
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			["ITEM_MOD_BLOCK_VALUE_SHORT"] = 30,
		},
		[2591] = {														-- Animist's Caress
			["ITEM_MOD_INTELLECT_SHORT"] = 10,
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			["ITEM_MOD_SPELL_POWER_SHORT"] = 12,
		},
		[3328] = {														-- Nerubian Leg Reinforcements
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 75,
			["ITEM_MOD_CRIT_RATING_SHORT"] = 22,
			-- leatherworking 400
		},
		[3327] = {														-- Jormungar Leg Reinforcements
			["ITEM_MOD_STAMINA_SHORT"] = 55,
			["ITEM_MOD_AGILITY_SHORT"] = 22,
			-- leatherworking 400
		},
		[3872] = {														-- Sanctified Spellthread
			["ITEM_MOD_SPELL_POWER_SHORT"] = 50,
			["ITEM_MOD_SPIRIT_SHORT"] = 20,
			-- tailoring 405
		},
		[3873] = {														-- Master's Spellthread
			["ITEM_MOD_SPELL_POWER_SHORT"] = 50,
			["ITEM_MOD_STAMINA_SHORT"] = 30,
			-- tailoring 405
		},
	},
	-- Feet
	[8] = {
		[3330] = {														-- Heavy Borean Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 18,
			-- 70+
		},
		[3329] = {														-- Borean Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 12,
			-- 70+
		},
		[2841] = {														-- Heavy Knothide Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			-- 60+
		},
		[2792] = {														-- Knothide Armor Kit
			["ITEM_MOD_STAMINA_SHORT"] = 10,
			-- 55+
		},
		[1843] = {														-- Rugged Armor Kit
			["RESISTANCE0_NAME"] = 40,
			-- 35+
		},
		[18] = {														-- Thick Armor Kit
			["RESISTANCE0_NAME"] = 32,
			-- 25+
		},
		[17] = {														-- Heavy Armor Kit
			["RESISTANCE0_NAME"] = 24,
			-- 15+
		},
		[16] = {														-- Medium Armor Kit
			["RESISTANCE0_NAME"] = 16,
		},
		[15] = {														-- Light Armor Kit
			["RESISTANCE0_NAME"] = 8,
		},
		[2793] = {														-- Vindicator's Armor Kit
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 8,
		},
		[2503] = {														-- Core Armor Kit
			["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 5,
		},
		[2794] = {														-- Magister's Armor Kit
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 4,
		},
		[2989] = {														-- Arcane Armor Kit
			["RESISTANCE6_NAME"] = 8,
		},
		[2985] = {														-- Flame Armor Kit
			["RESISTANCE2_NAME"] = 8,
		},
		[2987] = {														-- Frost Armor Kit
			["RESISTANCE4_NAME"] = 8,
		},
		[2988] = {														-- Nature Armor Kit
			["RESISTANCE3_NAME"] = 8,
		},
		[2984] = {														-- Shadow Armor Kit
			["RESISTANCE5_NAME"] = 8,
		},
		[1597] = {														-- Enchant Boots - Greater Assault
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 23,
			-- 60+
		},
		[3824] = {														-- Enchant Boots - Assault
			["ITEM_MOD_ATTACK_POWER_SHORT"] = 24,
			-- 60+
		},
		[3826] = {														-- Enchant Boots - Icewalker
			["ITEM_MOD_HIT_RATING_SHORT"] = 12,
			["ITEM_MOD_CRIT_RATING_SHORT"] = 12,
			-- 60+
		},
		[2658] = {														-- Enchant Boots - Surefooted
			["ITEM_MOD_HIT_RATING_SHORT"] = 10,
			["ITEM_MOD_CRIT_RATING_SHORT"] = 10,
			-- 35+
		},
		[3858] = {														-- Enchant Boots - Lesser Accuracy
			["ITEM_MOD_HIT_RATING_SHORT"] = 5,
		},
		[2939] = {														-- Enchant Boots - Cat's Swiftness
			["ITEM_MOD_AGILITY_SHORT"] = 6,
			-- TODO: minor speed
			-- 35+
		},
		[3232] = {														-- Enchant Boots - Tuskarr's Vitality
			["ITEM_MOD_STAMINA_SHORT"] = 15,
			-- TODO: minor speed
			-- 60+
		},
		[2940] = {														-- Enchant Boots - Boar's Speed
			["ITEM_MOD_STAMINA_SHORT"] = 9,
			-- TODO: minor speed
			-- 35+
		},
		[911] = {														-- Enchant Boots - Minor Speed
			-- TODO: minor speed
		},
		[464] = {														-- Mithril Spurs
			-- TODO: +4% Mount Speed
			-- 70-
		},
		[3244] = {														-- Enchant Boots - Greater Vitality
			["ITEM_MOD_HEALTH_REGENERATION_SHORT"] = 7,
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 7,
			-- 60+
		},
		[2656] = {														-- Enchant Boots - Vitality
			["ITEM_MOD_HEALTH_REGENERATION_SHORT"] = 5,
			["ITEM_MOD_MANA_REGENERATION_SHORT"] = 5,
			-- 35+
		},
		[3606] = {														-- Nitro Boosts
			["ITEM_MOD_CRIT_RATING_SHORT"] = 24,
			-- TODO: greatly increase run speed for 5 sec
			-- engineering 405
		},
		[983] = {														-- Enchant Boots - Superior Agility
			["ITEM_MOD_AGILITY_SHORT"] = 16,
			-- 60+
		},
		[2657] = {														-- Enchant Boots - Dexterity
			["ITEM_MOD_AGILITY_SHORT"] = 12,
			-- 35+
		},
		[1887] = {														-- Enchant Boots - Greater Agility
			["ITEM_MOD_AGILITY_SHORT"] = 7,
		},
		[904] = {														-- Enchant Boots - Agility
			["ITEM_MOD_AGILITY_SHORT"] = 5,
		},
		[849] = {														-- Enchant Boots - Lesser Agility
			["ITEM_MOD_AGILITY_SHORT"] = 3,
		},
		[247] = {														-- Enchant Boots - Minor Agility
			["ITEM_MOD_AGILITY_SHORT"] = 1,
		},
		[1147] = {														-- Enchant Boots - Greater Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 18,
			-- 60+
		},
		[851] = {														-- Enchant Boots - Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 5,
		},
		[255] = {														-- Enchant Boots - Lesser Spirit
			["ITEM_MOD_SPIRIT_SHORT"] = 3,
		},
		[1075] = {														-- Enchant Boots - Greater Fortitude
			["ITEM_MOD_STAMINA_SHORT"] = 22,
			-- 60+
		},
		[2649] = {														-- Enchant Boots - Fortitude
			["ITEM_MOD_STAMINA_SHORT"] = 12,
			-- 35+
		},
		[929] = {														-- Enchant Boots - Greater Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 7,
		},
		[852] = {														-- Enchant Boots - Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 5,
		},
		[724] = {														-- Enchant Boots - Lesser Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 3,
		},
		[66] = {														-- Enchant Boots - Minor Stamina
			["ITEM_MOD_STAMINA_SHORT"] = 1,
		},
	},
}
