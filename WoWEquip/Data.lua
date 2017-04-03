-- WoWEquip data file

local WoWEquip = LibStub("AceAddon-3.0"):GetAddon("WoWEquip")
local L = LibStub("AceLocale-3.0"):GetLocale("WoWEquip", false)
local LGII = LibStub("AceLocale-3.0"):GetLocale("WoWEquipLGII", false)


--[[
An Enchant/Gem menu has the following format:

menuTable = {
	t = "name",
	menuItem,
	menuItem,
	menuItem,
}

A menuItem can be either another menuTable (effectively creating a submenu)
or be a table having the following format:

menuItem = {enchantID, itemID or -enchantLinkID[, minitemMinLevel or -minitemLevel]}

enchantID: The enchantID used by the enchant in an itemlink.
itemID: Used in the menu for showing the item's tooltip. If this number is
    negative, it is treated as an enchant/recipe link instead.
minitemMinLevel: Disables the menuitem if the itemMinLevel of the item to be applied
    on is lower. If this number is negative, compares itemLevel instead.
]]


function WoWEquip:GenerateEnchantDataTables()
	local ArcanumTable = {
		t = L["Arcanums (Librams)"],
		{1508, 11647}, -- Lesser Arcanum of Voracity (Agi)
		{1504, 11643}, -- Lesser Arcanum of Tenacity
		{2545, 18331}, -- Arcanum of Protection
		{1505, 11644}, -- Lesser Arcanum of Resilience
		{2543, 18329}, -- Arcanum of Rapidity
		{1503, 11642}, -- Lesser Arcanum of Constitution
		{1509, 11648}, -- Lesser Arcanum of Voracity (Int)
		{1483, 11622}, -- Lesser Arcanum of Rumination
		{2544, 18330}, -- Arcanum of Focus
		{1510, 11649}, -- Lesser Arcanum of Voracity (Spi)
		{1507, 11646}, -- Lesser Arcanum of Voracity (Sta)
		{1506, 11645}, -- Lesser Arcanum of Voracity (Str)
	}
	local ZGIdolTable = {
		t = L["Zul'Gurub (Idols)"],
		{2583, 19782}, -- Presence of Might
		{2584, 19783}, -- Syncretist's Sigil
		{2585, 19784}, -- Death's Embrace
		{2586, 19785}, -- Falcon's Call
		{2587, 19786}, -- Vodouisant's Vigilant Embrace
		{2588, 19787}, -- Presence of Sight
		{2589, 19788}, -- Hoodoo Hex
		{2590, 19789}, -- Prophetic Aura
		{2591, 19790}, -- Animist's Caress
		{2681, 22635}, -- Savage Guard
	}
	local ArgentDawnTable = {
		t = L["Argent Dawn (Insignias)"],
		{2682, 22636}, -- Ice Guard
		{2683, 22638}, -- Shadow Guard
	}
	local ArmorKitTable = {
		t = L["Armor Kits"],
		{15, 2304}, -- Light Armor Kit
		{16, 2313}, -- Medium Armor Kit
		{17, 4265, 15}, -- Heavy Armor Kit
		{18, 8173, 25}, -- Thick Armor Kit
		{1843, 15564, 35}, -- Rugged Armor Kit
		{2503, 18251, 45}, -- Core Armor Kit
	}
	local ArmorKitTableTBC = {
		t = L["Armor Kits"],
		{2989, 29488, 60}, -- Arcane Armor Kit
		{2793, 25651, 60}, -- Vindicator's Armor Kit
		{2985, 29485, 60}, -- Flame Armor Kit
		{2987, 29486, 60}, -- Frost Armor Kit
		{2988, 29487, 60}, -- Nature Armor Kit
		{2984, 29483, 60}, -- Shadow Armor Kit
		{2792, 25650, 55}, -- Knothide Armor Kit
		{2841, 34330, 60}, -- Heavy Knothide Armor Kit
		{2794, 25652, 60}, -- Magister's Armor Kit
	}
	local ArmorKitTableTBC2 = {
		t = L["Armor Kits"],
		{2841, 34330, 60}, -- Heavy Knothide Armor Kit
	}
	local ArmorKitTableWrath = {
		t = L["Armor Kits"],
		{3329, 38375, 60}, -- Borean Armor Kit
		{3330, 38376, 60}, -- Heavy Borean Armor Kit
	}
	local BSWeaponEnchants = {
		t = L["Blacksmithing"],
		{34, 6043}, -- Iron Counterweight
		{37, 6041}, -- Steel Weapon Chain
	}
	local BSWeaponEnchantsTBC = {
		t = L["Blacksmithing"],
		{3223, 33185, 60}, -- Adamantite Weapon Chain
	}
	local BSWeaponEnchantsWrath = {
		t = L["Blacksmithing"],
		{3731, 41976}, -- Titanium Weapon Chain
	}
	local QuestWeaponEnchants = {
		t = L["Quest Rewards"],
		{36, 5421}, -- Fiery Blaze Enchantment
	}
	local OneHandEnchantsTableClassic = {
		t = L["Enchanting"].." "..L["(1H)"],
		{2564, -23800}, -- Enchant Weapon - Agility
		{250, -7788}, -- Enchant Weapon - Minor Striking
		{241, -13503}, -- Enchant Weapon - Lesser Striking
		{943, -13693}, -- Enchant Weapon - Striking
		{805, -13943}, -- Enchant Weapon - Greater Striking
		{1897, -20031}, -- Enchant Weapon - Superior Striking
		{249, -7786}, -- Enchant Weapon - Minor Beastslayer
		{853, -13653}, -- Enchant Weapon - Lesser Beastslayer
		{854, -13655}, -- Enchant Weapon - Lesser Elemental Slayer
		{2443, -21931}, -- Enchant Weapon - Winter's Might
		{1894, -20029}, -- Enchant Weapon - Icy Chill
		{1899, -20033}, -- Enchant Weapon - Unholy Weapon
		{1898, -20032}, -- Enchant Weapon - Lifestealing
		{803, -13898}, -- Enchant Weapon - Fiery Weapon
		{1900, -20034}, -- Enchant Weapon - Crusader
		{912, -13915}, -- Enchant Weapon - Demonslaying
		{2568, -23804}, -- Enchant Weapon - Mighty Intellect
		{2505, -22750}, -- Enchant Weapon - Healing Power
		{2504, -22749}, -- Enchant Weapon - Spell Power
		{2567, -23803}, -- Enchant Weapon - Mighty Spirit
		{2563, -23799}, -- Enchant Weapon - Strength
	}
	local OneHandEnchantsTableTBC = {
		t = L["Enchanting"].." "..L["(1H)"],
		{3222, -42620, 35}, -- Enchant Weapon - Greater Agility
		{963, -27967, 35}, -- Enchant Weapon - Major Striking
		{2671, -27981, 35}, -- Enchant Weapon - Sunfire
		{2672, -27982, 35}, -- Enchant Weapon - Soulfrost
		{2666, -27968, 35}, -- Enchant Weapon - Major Intellect
		{2673, -27984, 35}, -- Enchant Weapon - Mongoose
		{3225, -42974, 60}, -- Enchant Weapon - Executioner
		{2675, -28004, 35}, -- Enchant Weapon - Battlemaster
		{3273, -46578, 60}, -- Enchant Weapon - Deathfrost
		{3846, -34010, 35}, -- Enchant Weapon - Major Healing
		{2669, -27975, 35}, -- Enchant Weapon - Major Spellpower
		{2674, -28003, 35}, -- Enchant Weapon - Spellsurge
		{2668, -27972, 35}, -- Enchant Weapon - Potency
	}
	local OneHandEnchantsTableWrath = {
		t = L["Enchanting"].." "..L["(1H)"],
		{1103, -44633, 60}, -- Enchant Weapon - Exceptional Agility
		{1606, -60621, 60}, -- Enchant Weapon - Greater Potency
		{3833, -60707, 60}, -- Enchant Weapon - Superior Potency
		{3788, -59619, 60}, -- Enchant Weapon - Accuracy
		{3789, -59621, 60}, -- Enchant Weapon - Berserking
		{3869, -64441}, -- Enchant Weapon - Blade Ward
		{3251, -44621, 60}, -- Enchant Weapon - Giant Slayer
		{3241, -44576, 60}, -- Enchant Weapon - Lifeward
		{3239, -44524, 60}, -- Enchant Weapon - Icebreaker
		{3870, -64579}, -- Enchant Weapon - Blood Draining
		{3790, -59625, 60}, -- Enchant Weapon - Black Magic
		{3830, -44629, 60}, -- Enchant Weapon - Exceptional Spellpower
		{3834, -60714, 60}, -- Enchant Weapon - Mighty Spellpower
		{3844, -44510, 60}, -- Enchant Weapon - Exceptional Spirit
	}
	local OneHandOnlyRuneforging = {
		t = L["Runeforging"].." "..L["(1H)"],
		{3594, -54446}, -- Rune of Swordbreaking
		{3595, -54447}, -- Rune of Spellbreaking
		{3883, -70164}, -- Rune of the Nerubian Carapace
	}
	local TwoHandOnlyRuneforging = {
		t = L["Runeforging"].." "..L["(2H)"],
		{3847, -62158}, -- Rune of the Stoneskin Gargoyle
		{3365, -53323}, -- Rune of Swordshattering
		{3367, -53342}, -- Rune of Spellshattering
	}
	local Runeforging = {
		t = L["Runeforging"],
		{3366, -53331}, -- Rune of Lichbane
		{3370, -53343}, -- Rune of Razorice
		{3368, -53344}, -- Rune of the Fallen Crusader
		{3369, -53341}, -- Rune of Cinderglacier
	}
	local OneHandEnchantsTable = {
		{t = L["Wrath"],
			OneHandEnchantsTableWrath,
			OneHandOnlyRuneforging,
			Runeforging,
			BSWeaponEnchantsWrath,
		},
		{t = L["TBC"],
			OneHandEnchantsTableTBC,
			BSWeaponEnchantsTBC,
		},
		{t = L["Classic"],
			OneHandEnchantsTableClassic,
			BSWeaponEnchants,
			QuestWeaponEnchants,
		},
	}
	local TwoHandEnchantsTableWrath = {
		t = L["Enchanting"].." "..L["(2H)"],
		{3828, -44630, 60}, -- Enchant 2H Weapon - Greater Savagery
		{3827, -60691, 60}, -- Enchant 2H Weapon - Massacre
		{3247, -44595, 60}, -- Enchant 2H Weapon - Scourgebane
	}

	local data = {
		INVTYPE_HEAD = {
			{t = L["Wrath"],
				{t = L["Reputation Vendors"],
					{3817, 44149}, -- Arcanum of Torment
					{3820, 44159}, -- Arcanum of Burning Mysteries
					{3819, 44152}, -- Arcanum of Blissful Mending
					{3815, 44140}, -- Arcanum of the Eclipsed Moon
					{3816, 44141}, -- Arcanum of the Flame's Soul
					{3812, 44137}, -- Arcanum of the Frosty Soul
					{3813, 44138}, -- Arcanum of Toxic Warding
					{3842, 44701}, -- Arcanum of the Savage Gladiator
					{3814, 44139}, -- Arcanum of the Fleeing Shadow
					{3818, 44150}, -- Arcanum of the Stalwart Protector
				},
				ArmorKitTableWrath,
				{t = L["Engineers Only"],
					{3878, -67839}, -- Mind Amplification Dish
				},
				{t = L["PvP"],
					{3795, 44069}, -- Arcanum of Triumph
					{3797, 44075}, -- Arcanum of Dominance
					{3842, 44701}, -- Arcanum of the Savage Gladiator
				},
			},
			{t = L["TBC"],
				{t = L["Reputation Vendors"],
					{3006, 29195}, -- Arcanum of Arcane Warding
					{3003, 29192}, -- Arcanum of Ferocity
					{2999, 29186}, -- Arcanum of the Defender
					{3007, 29196}, -- Arcanum of Fire Warding
					{3008, 29198}, -- Arcanum of Frost Warding
					{3001, 29189}, -- Arcanum of Renewal
					{3005, 29194}, -- Arcanum of Nature Warding
					{3009, 29199}, -- Arcanum of Shadow Warding
					{3002, 29191}, -- Arcanum of Power
					{3004, 29193}, -- Arcanum of the Gladiator
					{3096, 30846}, -- Arcanum of the Outcast
				},
				ArmorKitTableTBC2,
			},
			{t = L["Classic"],
				ArcanumTable,
				ZGIdolTable,
				ArgentDawnTable,
			},
		},
		INVTYPE_SHOULDER = {
			{t = L["Wrath"],
				{t = L["Hodir Inscriptions"],
					{2986, 44131, 60}, -- Lesser Inscription of the Axe
					{3808, 44133, 60}, -- Greater Inscription of the Axe
					{2978, 44132, 60}, -- Lesser Inscription of the Pinnacle
					{3811, 44136, 60}, -- Greater Inscription of the Pinnacle
					{3806, 44129, 60}, -- Lesser Inscription of the Storm
					{3810, 44135, 60}, -- Greater Inscription of the Storm
					{3807, 44130, 60}, -- Lesser Inscription of the Crag
					{3809, 44134, 60}, -- Greater Inscription of the Crag
				},
				{t = L["Scribes Only"],
					{3835, -61117}, -- Master's Inscription of the Axe
					{3837, -61119}, -- Master's Inscription of the Pinnacle
					{3838, -61120}, -- Master's Inscription of the Storm
					{3836, -61118}, -- Master's Inscription of the Crag
				},
				{t = L["PvP"],
					{3793, 44067}, -- Inscription of Triumph
					{3794, 44068}, -- Inscription of Dominance
					{3852, 44957}, -- Greater Inscription of the Gladiator
				},
				ArmorKitTableWrath,
			},
			{t = L["TBC"],
				{t = L["Aldor Inscriptions"],
					{2977, 28882}, -- Inscription of Warding
					{2978, 28889}, -- Greater Inscription of Warding
					{2979, 28878}, -- Inscription of Faith
					{2980, 28887}, -- Greater Inscription of Faith
					{2981, 28881}, -- Inscription of Discipline
					{2982, 28886}, -- Greater Inscription of Discipline
					{2983, 28885}, -- Inscription of Vengeance
					{2986, 28888}, -- Greater Inscription of Vengeance
				},
				{t = L["Scryer Inscriptions"],
					{2990, 28908}, -- Inscription of the Knight
					{2991, 28911}, -- Greater Inscription of the Knight
					{2992, 28904}, -- Inscription of the Oracle
					{2993, 28912}, -- Greater Inscription of the Oracle
					{2994, 28903}, -- Inscription of the Orb
					{2995, 28909}, -- Greater Inscription of the Orb
					{2996, 28907}, -- Inscription of the Blade
					{2997, 28910}, -- Greater Inscription of the Blade
				},
				{t = L["Violet Eye Inscriptions"],
					{2998, 29187}, -- Inscription of Endurance
				},
				ArmorKitTableTBC2,
			},
			{t = L["Classic"],
				{t = L["Argent Dawn Mantles"],
					{2488, 18182}, -- Chromatic Mantle of the Dawn
					{2485, 18171}, -- Arcane Mantle of the Dawn
					{2483, 18169}, -- Flame Mantle of the Dawn
					{2484, 18170}, -- Frost Mantle of the Dawn
					{2486, 18172}, -- Nature Mantle of the Dawn
					{2487, 18173}, -- Shadow Mantle of the Dawn
				},
				{t = L["Zul'Gurub Signets"],
					{2606, 20077}, -- Zandalar Signet of Might
					{2604, 20078}, -- Zandalar Signet of Serenity
					{2605, 20076}, -- Zandalar Signet of Mojo
				},
				{t = L["Naxxramas Sapphiron Drops"],
					{2721, 23545}, -- Power of the Scourge
					{2715, 23547}, -- Resilience of the Scourge
					{2716, 23549}, -- Fortitude of the Scourge
					{2717, 23548}, -- Might of the Scourge
				},
			},
		},
		--INVTYPE_ROBE -- Aliased to INVTYPE_CHEST at the end of this table
		INVTYPE_CHEST = {
			{t = L["Wrath"],
				{t = L["Enchanting"],
					{3252, -44623, 60}, -- Enchant Chest - Super Stats
					{3832, -60692, 60}, -- Enchant Chest - Powerful Stats
					{1953, -47766, 60}, -- Enchant Chest - Greater Defense
					{3236, -44492, 60}, -- Enchant Chest - Mighty Health
					{3297, -47900, 60}, -- Enchant Chest - Super Health
					{3233, -27958, 60}, -- Enchant Chest - Exceptional Mana
					{3245, -44588, 60}, -- Enchant Chest - Exceptional Resilience
					{2381, -44509, 60}, -- Enchant Chest - Greater Mana Restoration
				},
				ArmorKitTableWrath,
			},
			{t = L["TBC"],
				{t = L["Enchanting"],
					{2661, -27960, 35}, -- Enchant Chest - Exceptional Stats
					{1951, -46594, 35}, -- Enchant Chest - Defense
					{2659, -27957, 35}, -- Enchant Chest - Exceptional Health
					{2933, -33992, 35}, -- Enchant Chest - Major Resilience
					{1144, -33990, 35}, -- Enchant Chest - Major Spirit
					{3150, -33991, 35}, -- Enchant Chest - Restore Mana Prime
					--{2376, -33991, LE["Enchant Chest - Restore Mana Prime"], 35},	-- There's 2 versions apparently
				},
				ArmorKitTableTBC,
			},
			{t = L["Classic"],
				{t = L["Enchanting"],
					{44, -7426}, -- Enchant Chest - Minor Absorption
					{63, -13538}, -- Enchant Chest - Lesser Absorption
					{847, -13626}, -- Enchant Chest - Minor Stats
					{866, -13700}, -- Enchant Chest - Lesser Stats
					{928, -13941}, -- Enchant Chest - Stats
					{1891, -20025}, -- Enchant Chest - Greater Stats
					{41, -7420}, -- Enchant Chest - Minor Health
					{242, -7748}, -- Enchant Chest - Lesser Health
					{254, -7857}, -- Enchant Chest - Health
					{850, -13640}, -- Enchant Chest - Greater Health
					{908, -13858}, -- Enchant Chest - Superior Health
					{1892, -20026}, -- Enchant Chest - Major Health
					{24, -7443}, -- Enchant Chest - Minor Mana
					{246, -7776}, -- Enchant Chest - Lesser Mana
					{843, -13607}, -- Enchant Chest - Mana
					{857, -13663}, -- Enchant Chest - Greater Mana
					{913, -13917}, -- Enchant Chest - Superior Mana
					{1893, -20028}, -- Enchant Chest - Major Mana
				},
				ArmorKitTable,
			},
		},
		INVTYPE_LEGS = {
			{t = L["Wrath"],
				{t = L["Leatherworking"],
					{3326, 38372}, -- Nerubian Leg Armor
					{3823, 38374}, -- Icescale Leg Armor
					{3853, 44963}, -- Earthen Leg Armor
					{3325, 38371}, -- Jormungar Leg Armor
					{3822, 38373}, -- Frosthide Leg Armor
				},
				{t = L["Leatherworkers Only"],
					{3328, -60584}, -- Nerubian Leg Reinforcements
					{3327, -60583}, -- Jormungar Leg Reinforcements
				},
				{t = L["Tailoring"],
					{3718, 41601}, -- Shining Spellthread
					{3720, 41603}, -- Azure Spellthread
					{3719, 41602}, -- Brilliant Spellthread
					{3721, 41604}, -- Sapphire Spellthread
				},
				{t = L["Tailors Only"],
					{3719, -56039}, -- Sanctified Spellthread
					{3721, -56034}, -- Master's Spellthread
				},
				ArmorKitTableWrath,
			},
			{t = L["TBC"],
				{t = L["Leatherworking"],
					{3010, 29533}, -- Cobrahide Leg Armor
					{3012, 29535}, -- Nethercobra Leg Armor
					{3011, 29534}, -- Clefthide Leg Armor
					{3013, 29536}, -- Nethercleft Leg Armor
				},
				{t = L["Tailoring"],
					{2745, 24275}, -- Silver Spellthread
					{2747, 24273}, -- Mystic Spellthread
					{2746, 24276}, -- Golden Spellthread
					{2748, 24274}, -- Runic Spellthread
				},
				ArmorKitTableTBC,
			},
			{t = L["Classic"],
				ArcanumTable,
				ZGIdolTable,
				ArgentDawnTable,
				ArmorKitTable,
			},
		},
		INVTYPE_FEET = {
			{t = L["Wrath"],
				{t = L["Enchanting"],
					{983, -44589, 60}, -- Enchant Boots - Superior Agility
					{3824, -60606, 60}, -- Enchant Boots - Assault
					{1597, -60763, 60}, -- Enchant Boots - Greater Assault
					{3826, -60623, 60}, -- Enchant Boots - Icewalker
					{3858, -63746}, -- Enchant Boots - Lesser Accuracy
					{3232, -47901, 60}, -- Enchant Boots - Tuskarr's Vitality
					{1147, -44508, 60}, -- Enchant Boots - Greater Spirit
					{1075, -44528, 60}, -- Enchant Boots - Greater Fortitude
					{3244, -44584, 60}, -- Enchant Boots - Greater Vitality
				},
				ArmorKitTableWrath,
				{t = L["Engineers Only"],
					{3606, -55016}, -- Nitro Boots
				},
			},
			{t = L["TBC"],
				{t = L["Enchanting"],
					{2657, -27951, 35}, -- Enchant Boots - Dexterity
					{2658, -27954, 35}, -- Enchant Boots - Surefooted
					{2939, -34007, 35}, -- Enchant Boots - Cat's Swiftness
					{2940, -34008, 35}, -- Enchant Boots - Boar's Speed
					{2649, -27950, 35}, -- Enchant Boots - Fortitude
					{2656, -27948, 35}, -- Enchant Boots - Vitality
				},
				ArmorKitTableTBC,
			},
			{t = L["Classic"],
				{t = L["Enchanting"],
					{247, -7867}, -- Enchant Boots - Minor Agility
					{849, -13637}, -- Enchant Boots - Lesser Agility
					{904, -13935}, -- Enchant Boots - Agility
					{1887, -20023}, -- Enchant Boots - Greater Agility
					{911, -13890}, -- Enchant Boots - Minor Speed
					{66, -7863}, -- Enchant Boots - Minor Stamina
					{724, -13644}, -- Enchant Boots - Lesser Stamina
					{852, -13836}, -- Enchant Boots - Stamina
					{929, -20020}, -- Enchant Boots - Greater Stamina
					{255, -13687}, -- Enchant Boots - Lesser Spirit
					{851, -20024}, -- Enchant Boots - Spirit
				},
				{t = L["Blacksmithing"],
					{464, 7969}, -- Mithril Spurs
				},
				ArmorKitTable,
			},
		},
		INVTYPE_WRIST = {
			{t = L["Wrath"],
				{t = L["Enchanting"],
					{2661, -44616, 60}, -- Enchant Bracers - Greater Stats
					{1600, -60616, 60}, -- Enchant Bracers - Striking
					{3845, -44575, 60}, -- Enchant Bracers - Greater Assault
					{3231, -44598, 60}, -- Enchant Bracers - Expertise
					{1119, -44555, 60}, -- Enchant Bracers - Exceptional Intellect
					{2326, -44635, 60}, -- Enchant Bracers - Greater Spellpower
					{2332, -60767, 60}, -- Enchant Bracers - Superior Spellpower
					{1147, -44593, 60}, -- Enchant Bracers - Major Spirit
					{3850, -62256, 60}, -- Enchant Bracers - Major Stamina
				},
				{t = L["Leatherworkers Only"],
					{3763, -57701}, -- Fur Lining - Arcane Resist
					{3756, -57683}, -- Fur Lining - Attack Power
					{3759, -57692}, -- Fur Lining - Fire Resist
					{3760, -57694}, -- Fur Lining - Frost Resist
					{3762, -57699}, -- Fur Lining - Nature Resist
					{3761, -57696}, -- Fur Lining - Shadow Resist
					{3758, -57691}, -- Fur Lining - Spell Power
					{3757, -57690}, -- Fur Lining - Stamina
				},
			},
			{t = L["TBC"].." "..L["Enchanting"],
				--{t = L["Enchanting"],
					{1891, -27905, 35}, -- Enchant Bracer - Stats
					{1593, -34002, 35}, -- Enchant Bracer - Assault
					{2648, -27906, 35}, -- Enchant Bracer - Major Defense
					{369, -34001, 35}, -- Enchant Bracer - Major Intellect
					{2650, -27917, 35}, -- Enchant Bracer - Spellpower
					{2650, -27911, 35}, -- Enchant Bracer - Superior Healing
					{2649, -27914, 35}, -- Enchant Bracer - Fortitude
					{2647, -27899, 35}, -- Enchant Bracer - Brawn
					{2679, -27913, 35}, -- Enchant Bracer - Restore Mana Prime
				--},
			},
			{t = L["Classic"].." "..L["Enchanting"],
				--{t = L["Enchanting"],
					{247, -7779}, -- Enchant Bracer - Minor Agility
					{924, -7428}, -- Enchant Bracer - Minor Deflection
					{925, -13646}, -- Enchant Bracer - Lesser Deflection
					{923, -13931}, -- Enchant Bracer - Deflection
					{723, -13622}, -- Enchant Bracer - Lesser Intellect
					{905, -13822}, -- Enchant Bracer - Intellect
					{1883, -20008}, -- Enchant Bracer - Greater Intellect
					{41, -7418}, -- Enchant Bracer - Minor Health
					{2650, -23802}, -- Enchant Bracer - Healing Power
					{243, -7766}, -- Enchant Bracer - Minor Spirit
					{255, -7859}, -- Enchant Bracer - Lesser Spirit
					{851, -13642}, -- Enchant Bracer - Spirit
					{907, -13846}, -- Enchant Bracer - Greater Spirit
					{1884, -20009}, -- Enchant Bracer - Superior Spirit
					{66, -7457}, -- Enchant Bracer - Minor Stamina
					{724, -13501}, -- Enchant Bracer - Lesser Stamina
					{852, -13648}, -- Enchant Bracer - Stamina
					{929, -13945}, -- Enchant Bracer - Greater Stamina
					{1886, -20011}, -- Enchant Bracer - Superior Stamina
					{248, -7782}, -- Enchant Bracer - Minor Strength
					{823, -13536}, -- Enchant Bracer - Lesser Strength
					{856, -13661}, -- Enchant Bracer - Strength
					{927, -13939}, -- Enchant Bracer - Greater Strength
					{1885, -20010}, -- Enchant Bracer - Superior Strength
					{2565, -23801}, -- Enchant Bracer - Mana Regeneration
				--},
			},
		},
		INVTYPE_HAND = {
			{t = L["Wrath"],
				{t = L["Enchanting"],
					{3222, -44529, 60}, -- Enchant Gloves - Major Agility
					{3829, -44513, 60}, -- Enchant Gloves - Greater Assault
					{1603, -60668, 60}, -- Enchant Gloves - Crusher
					{3231, -44484, 60}, -- Enchant Gloves - Expertise
					{3238, -44506, 60}, -- Enchant Gloves - Gatherer
					{3234, -44488, 60}, -- Enchant Gloves - Precision
					{3253, -44625, 60}, -- Enchant Gloves - Armsman
					{3246, -44592, 60}, -- Enchant Gloves - Exceptional Spellpower
					{846, -71692}, -- Enchant Gloves - Angler
				},
				ArmorKitTableWrath,
				{t = L["Engineers Only"],
					{3860, -63770}, -- Reticulated Armor Webbing
					{3604, -54999}, -- Hyperspeed Accelerators
					{3603, -54998}, -- Hand-Mounted Pyro Rocket
				},
			},
			{t = L["TBC"],
				{t = L["Enchanting"],
					{1594, -33996, 35}, -- Enchant Gloves - Assault
					{2934, -33993, 35}, -- Enchant Gloves - Blasting
					{2935, -33994, 35}, -- Enchant Gloves - Precise Strike
					{2322, -33999, 35}, -- Enchant Gloves - Major Healing
					{2937, -33997, 35}, -- Enchant Gloves - Major Spellpower
					{684, -33995, 35}, -- Enchant Gloves - Major Strength
				},
				{t = L["Leatherworking"],
					{3260, 34207, 60}, -- Glove Reinforcements
				},
				ArmorKitTableTBC,
			},
			{t = L["Classic"],
				{t = L["Enchanting"],
					{904, -13815}, -- Enchant Gloves - Agility
					{1887, -20012}, -- Enchant Gloves - Greater Agility
					{2564, -25080}, -- Enchant Gloves - Superior Agility
					{2616, -25078}, -- Enchant Gloves - Fire Power
					{846, -13620}, -- Enchant Gloves - Fishing
					{2615, -25074}, -- Enchant Gloves - Frost Power
					{931, -13948}, -- Enchant Gloves - Minor Haste
					{845, -13617}, -- Enchant Gloves - Herbalism
					{909, -13868}, -- Enchant Gloves - Advanced Herbalism
					{844, -13612}, -- Enchant Gloves - Mining
					{906, -13841}, -- Enchant Gloves - Advanced Mining
					{930, -13947}, -- Enchant Gloves - Riding Skill
					{2614, -25073}, -- Enchant Gloves - Shadow Power
					{2617, -25079}, -- Enchant Gloves - Healing Power
					{865, -13698}, -- Enchant Gloves - Skinning
					{856, -13887}, -- Enchant Gloves - Strength
					{927, -20013}, -- Enchant Gloves - Greater Strength
					{2613, -25072}, -- Enchant Gloves - Threat
				},
				ArmorKitTable,
			},
		},
		INVTYPE_FINGER = {
			{t = L["Wrath"].." "..L["Enchanters Only"],
				--{t = L["Enchanters Only"],
					{3839, -44645}, -- Enchant Ring - Assault
					{3840, -44636}, -- Enchant Ring - Greater Spellpower
					{3791, -59636}, -- Enchant Ring - Stamina
				--},
			},
			{t = L["TBC"].." "..L["Enchanters Only"],
				--{t = L["Enchanters Only"],
					{2931, -27927, 35}, -- Enchant Ring - Stats
					{2930, -27926, 35}, -- Enchant Ring - Healing Power
					{2928, -27924, 35}, -- Enchant Ring - Spellpower
					{2929, -27920, 35}, -- Enchant Ring - Striking
				--},
			},
		},
		INVTYPE_CLOAK = {
			{t = L["Wrath"],
				{t = L["Enchanting"],
					{3256, -44631, 60}, -- Enchant Cloak - Shadow Armor
					{983, -44500, 60}, -- Enchant Cloak - Superior Agility
					{1099, -60663, 60}, -- Enchant Cloak - Major Agility
					{1262, -44596, 60}, -- Enchant Cloak - Superior Arcane Resistance
					{3294, -47672, 60}, -- Enchant Cloak - Mighty Armor
					{1951, -44591, 60}, -- Enchant Cloak - Titanweave
					{1354, -44556, 60}, -- Enchant Cloak - Superior Fire Resistance
					{3230, -44483, 60}, -- Enchant Cloak - Superior Frost Resistance
					{3825, -60609, 60}, -- Enchant Cloak - Speed
					{3831, -47898, 60}, -- Enchant Cloak - Greater Speed
					{1400, -44494, 60}, -- Enchant Cloak - Superior Nature Resistance
					{1446, -44590, 60}, -- Enchant Cloak - Superior Shadow Resistance
					{3243, -44582, 60}, -- Enchant Cloak - Spell Piercing
					{3296, -47899, 60}, -- Enchant Cloak - Wisdom
				},
				{t = L["Tailors Only"],
					{3730, -55777}, -- Swordguard Embroidery
					{3728, -55769}, -- Darkglow Embroidery
					{3722, -55642}, -- Lightweave Embroidery
				},
				{t = L["Engineers Only"],
					{3605, -55002}, -- Flexweave Underlay
					{3859, -63765}, -- Springy Arachnoweave
				},
			},
			{t = L["TBC"].." "..L["Enchanting"],
				--{t = L["Enchanting"],
					{368, -34004, 35}, -- Enchant Cloak - Greater Agility
					{2664, -27962, 35}, -- Enchant Cloak - Major Resistance
					{1257, -34005, 35}, -- Enchant Cloak - Greater Arcane Resistance
					{2662, -27961, 35}, -- Enchant Cloak - Major Armor
					{2648, -47051, 35}, -- Enchant Cloak - Steelweave
					{2622, -25086, 35}, -- Enchant Cloak - Dodge
					{1441, -34006, 35}, -- Enchant Cloak - Greater Shadow Resistance
					{2938, -34003, 35}, -- Enchant Cloak - Spell Penetration
				--},
			},
			{t = L["Classic"].." "..L["Enchanting"],
				--{t = L["Enchanting"],
					{247, -13419}, -- Enchant Cloak - Minor Agility
					{849, -13882}, -- Enchant Cloak - Lesser Agility
					{65, -7454}, -- Enchant Cloak - Minor Resistance
					{903, -13794}, -- Enchant Cloak - Resistance
					{1888, -20014}, -- Enchant Cloak - Greater Resistance
					{783, -7771}, -- Enchant Cloak - Minor Protection
					{744, -13421}, -- Enchant Cloak - Lesser Protection
					{848, -13635}, -- Enchant Cloak - Defense
					{884, -13746}, -- Enchant Cloak - Greater Defense
					{1889, -20015}, -- Enchant Cloak - Superior Defense
					{256, -7861}, -- Enchant Cloak - Lesser Fire Resistance
					{2463, -13657}, -- Enchant Cloak - Fire Resistance
					{2619, -25081}, -- Enchant Cloak - Greater Fire Resistance
					{2620, -25082}, -- Enchant Cloak - Greater Nature Resistance
					{804, -13522}, -- Enchant Cloak - Lesser Shadow Resistance
					{910, -25083}, -- Enchant Cloak - Stealth
					{2621, -25084}, -- Enchant Cloak - Subtlety
				--},
			},
		},
		INVTYPE_WAIST = {
			{t = L["Wrath"].." "..L["Engineers Only"],
				{3599, -54736}, -- Personal Electromagnetic Pulse Generator
				{3601, -54793}, -- Belt-Clipped Spynoculars
			},
		},
		INVTYPE_SHIELD = {
			{t = L["Wrath"],
				{t = L["Enchanting"],
					{1952, -44489, 60}, -- Enchant Shield - Defense
					{1128, -60653, 60}, -- Enchant Shield - Greater Intellect
				},
				{t = L["Blacksmithing"],
					{3748, 42500, 60}, -- Titanium Shield Spike
					{3849, 44936, 60}, -- Titanium Plating
				},
			},
			{t = L["TBC"],
				{t = L["Enchanting"],
					{1888, -27947, 35}, -- Enchant Shield - Resistance
					{2653, -27944, 35}, -- Enchant Shield - Tough Shield
					{2654, -27945, 35}, -- Enchant Shield - Intellect
					{3229, -44383, 35}, -- Enchant Shield - Resilience
					{2655, -27946, 35}, -- Enchant Shield - Shield Block
					{1071, -34009, 35}, -- Enchant Shield - Major Stamina
				},
				{t = L["Blacksmithing"],
					{2714, 23530}, -- Felsteel Shield Spike
				},
			},
			{t = L["Classic"],
				{t = L["Enchanting"],
					{848, -13464}, -- Enchant Shield - Lesser Protection
					{926, -13933}, -- Enchant Shield - Frost Resistance
					{863, -13689}, -- Enchant Shield - Lesser Block
					{255, -13485}, -- Enchant Shield - Lesser Spirit
					{851, -13659}, -- Enchant Shield - Spirit
					{907, -13905}, -- Enchant Shield - Greater Spirit
					{1890, -20016}, -- Enchant Shield - Superior Spirit
					{66, -13378}, -- Enchant Shield - Minor Stamina
					{724, -13631}, -- Enchant Shield - Lesser Stamina
					{852, -13817}, -- Enchant Shield - Stamina
					{929, -20017}, -- Enchant Shield - Greater Stamina
				},
				{t = L["Blacksmithing"],
					{43, 6042}, -- Iron Shield Spike
					{463, 7967}, -- Mithril Shield Spike
					{1704, 12645}, -- Thorium Shield Spike
				},
			},
		},
		INVTYPE_WEAPON = OneHandEnchantsTable,
		INVTYPE_WEAPONMAINHAND = OneHandEnchantsTable,
		INVTYPE_WEAPONOFFHAND = OneHandEnchantsTable,
		INVTYPE_2HWEAPON = {
			{t = L["Wrath"],
				OneHandEnchantsTableWrath,
				TwoHandEnchantsTableWrath,
				TwoHandOnlyRuneforging,
				Runeforging,
				BSWeaponEnchantsWrath,
			},
			{t = L["TBC"],
				OneHandEnchantsTableTBC,
				{t = L["Enchanting"].." "..L["(2H)"],
					{2670, -27977, 35}, -- Enchant 2H Weapon - Major Agility
					{2667, -27971, 35}, -- Enchant 2H Weapon - Savagery
				},
				BSWeaponEnchantsTBC,
			},
			{t = L["Classic"],
				OneHandEnchantsTableClassic,
				{t = L["Enchanting"].." "..L["(2H)"],
					{2646, -27837}, -- Enchant 2H Weapon - Agility
					{241, -7745}, -- Enchant 2H Weapon - Minor Impact
					{943, -13529}, -- Enchant 2H Weapon - Lesser Impact
					{1897, -13695}, -- Enchant 2H Weapon - Impact
					{963, -13937}, -- Enchant 2H Weapon - Greater Impact
					{1896, -20030}, -- Enchant 2H Weapon - Superior Impact
					{723, -7793}, -- Enchant 2H Weapon - Lesser Intellect
					{1904, -20036}, -- Enchant 2H Weapon - Major Intellect
					{255, -13380}, -- Enchant 2H Weapon - Lesser Spirit
					{1903, -20035}, -- Enchant 2H Weapon - Major Spirit
				},
				BSWeaponEnchants,
				QuestWeaponEnchants,
			},
		},
		--INVTYPE_RANGEDRIGHT -- Aliased to INVTYPE_RANGED at the end of this table
		INVTYPE_RANGED = {
			{t = L["Wrath"],
				{3843, 44739}, -- Diamond-cut Refractor Scope
				{3608, 41167}, -- Heartseeker Scope
				{3607, 41146}, -- Sun Scope
			},
			{t = L["TBC"],
				{2722, 23764}, -- Adamantite Scope
				{2723, 23765}, -- Khorium Scope
				{2724, 23766}, -- Stabilized Eternium Scope
			},
			{t = L["Classic"],
				{30, 4405}, -- Crude Scope
				{32, 4406}, -- Standard Scope
				{33, 4407}, -- Accurate Scope
				{663, 10546}, -- Deadly Scope
				{664, 10548}, -- Sniper Scope
				{2523, 18283}, -- Biznicks 247x128 Accurascope
			},
		},
		-- Categories with no enchants
		--INVTYPE_HOLDABLE
		--INVTYPE_THROWN
		--INVTYPE_RELIC
		FishingEnchants = {
			{3269, 34836}, -- Spun Truesilver Fishing Line
			{2603, 19971}, -- High Test Eternium Fishing Line
		},
		StaffEnchants = {
			{t = L["Wrath"],
				OneHandEnchantsTableWrath,
				TwoHandEnchantsTableWrath,
				{t = LGII["Staves"],
					{3855, -62959, 60}, -- Enchant Staff - Spellpower
					{3854, -62948, 60}, -- Enchant Staff - Greater Spellpower
				},
				TwoHandOnlyRuneforging,
				Runeforging,
				BSWeaponEnchantsWrath,
			},
			-- TBC/Classic enchants are aliased over from INVTYPE_2HWEAPON later
		},
		NoEnchants = {},
		NoEnchants2 = {0, 0},
	}
	data.INVTYPE_ROBE = data.INVTYPE_CHEST
	data.INVTYPE_RANGEDRIGHT = data.INVTYPE_RANGED
	data.StaffEnchants[2] = data.INVTYPE_2HWEAPON[2]
	data.StaffEnchants[3] = data.INVTYPE_2HWEAPON[3]

	return data
end

function WoWEquip:GenerateGemDataTables()
	local GemsMenu = {
		{t = L["Wrath"],
			{t = BLUE_GEM,
				{t = ITEM_QUALITY2_DESC,
					{3389, 39927}, -- Lustrous Chalcedony
					{3387, 39919}, -- Solid Chalcedony
					{3388, 39920}, -- Sparkling Chalcedony
					{3390, 39932}, -- Stormy Chalcedony
				},
				{t = ITEM_QUALITY2_DESC.." "..L["Perfect"],
					{3654, 41440}, -- Perfect Lustrous Chalcedony
					{3655, 41441}, -- Perfect Solid Chalcedony
					{3653, 41442}, -- Perfect Sparkling Chalcedony
					{3656, 41443}, -- Perfect Stormy Chalcedony
				},
				{t = ITEM_QUALITY3_DESC,
					{3456, 40010}, -- Lustrous Sky Sapphire
					{3454, 40008}, -- Solid Sky Sapphire
					{3455, 40009}, -- Sparkling Sky Sapphire
					{3457, 40011}, -- Stormy Sky Sapphire
				},
				{t = ITEM_QUALITY4_DESC,
					{3534, 40121}, -- Lustrous Majestic Zircon
					{3532, 40119}, -- Solid Majestic Zircon
					{3863, 45880}, -- Solid Stormjewel
					{3533, 40120}, -- Sparkling Majestic Zircon
					{3864, 45881}, -- Sparkling Stormjewel
					{3535, 40122}, -- Stormy Majestic Zircon
				},
				{t = L["Jewelcrafters Only"],
					{3736, 42146}, -- Lustrous Dragon's Eye
					{3293, 36767}, -- Solid Dragon's Eye
					{3735, 42145}, -- Sparkling Dragon's Eye
					{3747, 42155}, -- Stormy Dragon's Eye
				},
			},
			{t = RED_GEM,
				{t = ITEM_QUALITY2_DESC,
					{3371, 39900}, -- Bold Bloodstone
					{3375, 39906}, -- Bright Bloodstone
					{3374, 39905}, -- Delicate Bloodstone
					{3377, 39908}, -- Flashing Bloodstone
					{3378, 39909}, -- Fractured Bloodstone
					{3379, 39910}, -- Precise Bloodstone
					{3380, 39911}, -- Runed Bloodstone
					{3376, 39907}, -- Subtle Bloodstone
				},
				{t = ITEM_QUALITY2_DESC.." "..L["Perfect"],
					{3649, 41432}, -- Perfect Bold Bloodstone
					{3651, 41433}, -- Perfect Bright Bloodstone
					{3644, 41434}, -- Perfect Delicate Bloodstone
					{3648, 41435}, -- Perfect Flashing Bloodstone
					{3652, 41436}, -- Perfect Fractured Bloodstone
					{3647, 41437}, -- Perfect Precise Bloodstone
					{3650, 41438}, -- Perfect Runed Bloodstone
					{3646, 41439}, -- Perfect Subtle Bloodstone
				},
				{t = ITEM_QUALITY3_DESC,
					{3446, 39996}, -- Bold Scarlet Ruby
					{3449, 39999}, -- Bright Scarlet Ruby
					{3447, 39997}, -- Delicate Scarlet Ruby
					{3451, 40001}, -- Flashing Scarlet Ruby
					{3452, 40002}, -- Fractured Scarlet Ruby
					{3453, 40003}, -- Precise Scarlet Ruby
					{3448, 39998}, -- Runed Scarlet Ruby
					{3450, 40000}, -- Subtle Scarlet Ruby
				},
				{t = ITEM_QUALITY4_DESC,
					{3861, 45862}, -- Bold Stormjewel
					{3518, 40111}, -- Bold Cardinal Ruby
					{3521, 40114}, -- Bright Cardinal Ruby
					{3519, 40112}, -- Delicate Cardinal Ruby
					{3862, 45879}, -- Delicate Stormjewel
					{3523, 40116}, -- Flashing Cardinal Ruby
					{3525, 40117}, -- Fractured Cardinal Ruby
					{3524, 40118}, -- Precise Cardinal Ruby
					{3520, 40113}, -- Runed Cardinal Ruby
					{3866, 45883}, -- Runed Stormjewel
					{3522, 40115}, -- Subtle Cardinal Ruby
				},
				{t = L["Jewelcrafters Only"],
					{3732, 42142}, -- Bold Dragon's Eye
					{3292, 36766}, -- Bright Dragon's Eye
					{3733, 42143}, -- Delicate Dragon's Eye
					{3741, 42152}, -- Flashing Dragon's Eye
					{3745, 42153}, -- Fractured Dragon's Eye
					{3746, 42154}, -- Precise Dragon's Eye
					{3734, 42144}, -- Runed Dragon's Eye
					{3740, 42151}, -- Subtle Dragon's Eye
				},
			},
			{t = YELLOW_GEM,
				{t = ITEM_QUALITY2_DESC,
					{3381, 39912}, -- Brilliant Sun Crystal
					{3385, 39917}, -- Mystic Sun Crystal
					{3386, 39918}, -- Quick Sun Crystal
					{3383, 39915}, -- Rigid Sun Crystal
					{3382, 39914}, -- Smooth Sun Crystal
					{3384, 39916}, -- Thick Sun Crystal
				},
				{t = ITEM_QUALITY2_DESC.." "..L["Perfect"],
					{3661, 41444}, -- Perfect Brilliant Sun Crystal
					{3662, 41445}, -- Perfect Mystic Sun Crystal
					{3659, 41446}, -- Perfect Quick Sun Crystal
					{3660, 41447}, -- Perfect Rigid Sun Crystal
					{3657, 41448}, -- Perfect Smooth Sun Crystal
					{3658, 41449}, -- Perfect Thick Sun Crystal
				},
				{t = ITEM_QUALITY3_DESC,
					{3458, 40012}, -- Brilliant Autumn's Glow
					{3462, 40016}, -- Mystic Autumn's Glow
					{3463, 40017}, -- Quick Autumn's Glow
					{3460, 40014}, -- Rigid Autumn's Glow
					{3459, 40013}, -- Smooth Autumn's Glow
					{3461, 40015}, -- Thick Autumn's Glow
				},
				{t = ITEM_QUALITY4_DESC,
					{3526, 40123}, -- Brilliant King's Amber
					{3865, 45882}, -- Brilliant Stormjewel
					{3792, 44066}, -- Kharmaa's Grace
					{3530, 40127}, -- Mystic King's Amber
					{3531, 40128}, -- Quick King's Amber
					{3528, 40125}, -- Rigid King's Amber
					{3867, 45987}, -- Rigid Stormjewel
					{3527, 40124}, -- Smooth King's Amber
					{3529, 40126}, -- Thick King's Amber
				},
				{t = L["Jewelcrafters Only"],
					{3737, 42148}, -- Brilliant Dragon's Eye
					{3744, 42158}, -- Mystic Dragon's Eye
					{3739, 42150}, -- Quick Dragon's Eye
					{3742, 42156}, -- Rigid Dragon's Eye
					{3738, 42149}, -- Smooth Dragon's Eye
					{3743, 42157}, -- Thick Dragon's Eye
				},
			},
			{t = L["Green"],
				{t = ITEM_QUALITY2_DESC,
					{3438, 39984}, -- Dazzling Dark Jade
					{3430, 39976}, -- Enduring Dark Jade
					{3442, 39989}, -- Energized Dark Jade
					{3432, 39978}, -- Forceful Dark Jade
					{3437, 39983}, -- Intricate Dark Jade
					{3428, 39974}, -- Jagged Dark Jade
					{3440, 39986}, -- Lambert Dark Jade
					{3434, 39980}, -- Misty Dark Jade
					{3441, 39988}, -- Opaque Dark Jade
					{3443, 39990}, -- Radiant Dark Jade
					{3433, 39979}, -- Seer's Dark Jade
					{3445, 39992}, -- Shattered Dark Jade
					{3435, 39981}, -- Shining Dark Jade
					{3431, 39977}, -- Steady Dark Jade
					{3439, 39985}, -- Sundered Dark Jade
					{3444, 39991}, -- Tense Dark Jade
					{3427, 39968}, -- Timeless Dark Jade
					{3436, 39982}, -- Turbid Dark Jade
					{3429, 39975}, -- Vivid Dark Jade
				},
				{t = ITEM_QUALITY2_DESC.." "..L["Perfect"],
					{3711, 41463}, -- Perfect Dazzling Dark Jade
					{3700, 41464}, -- Perfect Enduring Dark Jade
					{3714, 41465}, -- Perfect Energized Dark Jade
					{3702, 41466}, -- Perfect Forceful Dark Jade
					{3701, 41467}, -- Perfect Intricate Dark Jade
					{3699, 41468}, -- Perfect Jagged Dark Jade
					{3712, 41469}, -- Perfect Lambert Dark Jade
					{3698, 41470}, -- Perfect Misty Dark Jade
					{3713, 41471}, -- Perfect Opaque Dark Jade
					{3709, 41472}, -- Perfect Radiant Dark Jade
					{3705, 41473}, -- Perfect Seer's Dark Jade
					{3716, 41474}, -- Perfect Shattered Dark Jade
					{3703, 41475}, -- Perfect Shining Dark Jade
					{3708, 41476}, -- Perfect Steady Dark Jade
					{3710, 41477}, -- Perfect Sundered Dark Jade
					{3715, 41478}, -- Perfect Tense Dark Jade
					{3706, 41479}, -- Perfect Timeless Dark Jade
					{3707, 41480}, -- Perfect Turbid Dark Jade
					{3704, 41481}, -- Perfect Vivid Dark Jade
				},
				{t = ITEM_QUALITY3_DESC,
					{3510, 40094}, -- Dazzling Forest Emerald
					{3502, 40089}, -- Enduring Forest Emerald
					{3514, 40105}, -- Energized Forest Emerald
					{3504, 40091}, -- Forceful Forest Emerald
					{3509, 40104}, -- Intricate Forest Emerald
					{3500, 40086}, -- Jagged Forest Emerald
					{3512, 40100}, -- Lambert Forest Emerald
					{3506, 40095}, -- Misty Forest Emerald
					{3513, 40103}, -- Opaque Forest Emerald
					{3515, 40098}, -- Radiant Forest Emerald
					{3505, 40092}, -- Seer's Forest Emerald
					{3517, 40106}, -- Shattered Forest Emerald
					{3507, 40099}, -- Shining Forest Emerald
					{3503, 40090}, -- Steady Forest Emerald
					{3511, 40096}, -- Sundered Forest Emerald
					{3516, 40101}, -- Tense Forest Emerald
					{3499, 40085}, -- Timeless Forest Emerald
					{3508, 40102}, -- Turbid Forest Emerald
					{3501, 40088}, -- Vivid Forest Emerald
				},
				{t = ITEM_QUALITY4_DESC,
					{3583, 40175}, -- Dazzling Eye of Zul
					{3575, 40167}, -- Enduring Eye of Zul
					{3587, 40179}, -- Energized Eye of Zul
					{3577, 40169}, -- Forceful Eye of Zul
					{3582, 40174}, -- Intricate Eye of Zul
					{3573, 40165}, -- Jagged Eye of Zul
					{3585, 40177}, -- Lambent Eye of Zul
					{3579, 40171}, -- Misty Eye of Zul
					{3586, 40178}, -- Opaque Eye of Zul
					{3588, 40180}, -- Radiant Eye of Zul
					{3578, 40170}, -- Seer's Eye of Zul
					{3590, 40182}, -- Shattered Eye of Zul
					{3580, 40172}, -- Shining Eye of Zul
					{3576, 40168}, -- Steady Eye of Zul
					{3584, 40176}, -- Sundered Eye of Zul
					{3589, 40181}, -- Tense Eye of Zul
					{3572, 40164}, -- Timeless Eye of Zul
					{3581, 40173}, -- Turbid Eye of Zul
					{3574, 40166}, -- Vivid Eye of Zul
				},
			},
			{t = L["Orange"],
				{t = ITEM_QUALITY2_DESC,
					{3420, 39966}, -- Accurate Huge Citrine
					{3407, 39949}, -- Champion's Huge Citrine
					{3410, 39952}, -- Deadly Huge Citrine
					{3413, 39955}, -- Deft Huge Citrine
					{3416, 39958}, -- Durable Huge Citrine
					{3424, 39962}, -- Empowered Huge Citrine
					{3411, 39948}, -- Etched Huge Citrine
					{3409, 39951}, -- Fierce Huge Citrine
					{3419, 39965}, -- Glimmering Huge Citrine
					{3406, 39953}, -- Glinting Huge Citrine
					{3405, 39947}, -- Inscribed Huge Citrine
					{3412, 39954}, -- Lucent Huge Citrine
					{3404, 39946}, -- Luminous Huge Citrine
					{3414, 39956}, -- Potent Huge Citrine
					{3423, 39961}, -- Pristine Huge Citrine
					{3417, 39959}, -- Reckless Huge Citrine
					{3421, 39967}, -- Resolute Huge Citrine
					{3408, 39950}, -- Resplendent Huge Citrine
					{3418, 39964}, -- Stalwart Huge Citrine
					{3426, 39963}, -- Stark Huge Citrine
					{3415, 39957}, -- Veiled Huge Citrine
					{3422, 39960}, -- Wicked Huge Citrine
				},
				{t = ITEM_QUALITY2_DESC.." "..L["Perfect"],
					{3696, 41482}, -- Perfect Accurate Huge Citrine
					{3683, 41483}, -- Perfect Champion's Huge Citrine
					{3686, 41484}, -- Perfect Deadly Huge Citrine
					{3677, 41485}, -- Perfect Deft Huge Citrine
					{3692, 41486}, -- Perfect Durable Huge Citrine
					{3680, 41487}, -- Perfect Empowered Huge Citrine
					{3682, 41488}, -- Perfect Etched Huge Citrine
					{3685, 41489}, -- Perfect Fierce Huge Citrine
					{3695, 41490}, -- Perfect Glimmering Huge Citrine
					{3687, 41491}, -- Perfect Glinting Huge Citrine
					{3681, 41492}, -- Perfect Inscribed Huge Citrine
					{3688, 41493}, -- Perfect Lucent Huge Citrine
					{3689, 41494}, -- Perfect Luminous Huge Citrine
					{3690, 41495}, -- Perfect Potent Huge Citrine
					{3679, 41496}, -- Perfect Pristine Huge Citrine
					{3693, 41497}, -- Perfect Reckless Huge Citrine
					{3697, 41498}, -- Perfect Resolute Huge Citrine
					{3684, 41499}, -- Perfect Resplendent Huge Citrine
					{3694, 41500}, -- Perfect Stalwart Huge Citrine
					{3678, 41501}, -- Perfect Stark Huge Citrine
					{3691, 41502}, -- Perfect Veiled Huge Citrine
					{3767, 41429}, -- Perfect Wicked Huge Citrine
				},
				{t = ITEM_QUALITY3_DESC,
					{3497, 40058}, -- Accurate Monarch Topaz
					{3479, 40039}, -- Champion's Monarch Topaz
					{3482, 40043}, -- Deadly Monarch Topaz
					{3485, 40046}, -- Deft Monarch Topaz
					{3489, 40050}, -- Durable Monarch Topaz
					{3493, 40054}, -- Empowered Monarch Topaz
					{3478, 40038}, -- Etched Monarch Topaz
					{3481, 40041}, -- Fierce Monarch Topaz
					{3496, 40057}, -- Glimmering Monarch Topaz
					{3483, 40044}, -- Glinting Monarch Topaz
					{3477, 40037}, -- Inscribed Monarch Topaz
					{3484, 40045}, -- Lucent Monarch Topaz
					{3486, 40047}, -- Luminous Monarch Topaz
					{3487, 40048}, -- Potent Monarch Topaz
					{3492, 40053}, -- Pristine Monarch Topaz
					{3490, 40051}, -- Reckless Monarch Topaz
					{3498, 40059}, -- Resolute Monarch Topaz
					{3480, 40040}, -- Resplendent Monarch Topaz
					{3495, 40056}, -- Stalwart Monarch Topaz
					{3494, 40055}, -- Stark Monarch Topaz
					{3488, 40049}, -- Veiled Monarch Topaz
					{3491, 40052}, -- Wicked Monarch Topaz
				},
				{t = ITEM_QUALITY4_DESC,
					{3570, 40162}, -- Accurate Ametrine
					{3551, 40144}, -- Champion's Ametrine
					{3554, 40147}, -- Deadly Ametrine
					{3557, 40150}, -- Deft Ametrine
					{3561, 40154}, -- Durable Ametrine
					{3566, 40158}, -- Empowered Ametrine
					{3550, 40143}, -- Etched Ametrine
					{3553, 40146}, -- Fierce Ametrine
					{3569, 40161}, -- Glimmering Ametrine
					{3555, 40148}, -- Glinting Ametrine
					{3549, 40142}, -- Inscribed Ametrine
					{3556, 40149}, -- Lucent Ametrine
					{3558, 40151}, -- Luminous Ametrine
					{3559, 40152}, -- Potent Ametrine
					{3565, 40157}, -- Pristine Ametrine
					{3563, 40155}, -- Reckless Ametrine
					{3571, 40163}, -- Resolute Ametrine
					{3552, 40145}, -- Resplendent Ametrine
					{3568, 40160}, -- Stalwart Ametrine
					{3567, 40159}, -- Stark Ametrine
					{3560, 40153}, -- Veiled Ametrine
					{3564, 40156}, -- Wicked Ametrine
				},
			},
			{t = L["Purple"],
				{t = ITEM_QUALITY2_DESC,
					{3395, 39937}, -- Balanced Shadow Crystal
					{3397, 39939}, -- Defender's Shadow Crystal
					{3394, 39936}, -- Glowing Shadow Crystal
					{3398, 39940}, -- Guardian Shadow Crystal
					{3402, 39944}, -- Infused Shadow Crystal
					{3403, 39945}, -- Mysterious Shadow Crystal
					{3391, 39933}, -- Puissant Shadow Crystal
					{3399, 39941}, -- Purified Shadow Crystal
					{3396, 39938}, -- Regal Shadow Crystal
					{3401, 39943}, -- Royal Shadow Crystal
					{3393, 39935}, -- Shifting Shadow Crystal
					{3392, 39934}, -- Sovereign Shadow Crystal
					{3400, 39942}, -- Tenuous Shadow Crystal
				},
				{t = ITEM_QUALITY2_DESC.." "..L["Perfect"],
					{3664, 41450}, -- Perfect Balanced Shadow Crystal
					{3670, 41451}, -- Perfect Defender's Shadow Crystal
					{3675, 41452}, -- Perfect Glowing Shadow Crystal
					{3669, 41453}, -- Perfect Guardian Shadow Crystal
					{3663, 41454}, -- Perfect Infused Shadow Crystal
					{3674, 41455}, -- Perfect Mysterious Shadow Crystal
					{3665, 41456}, -- Perfect Puissant Shadow Crystal
					{3673, 41457}, -- Perfect Purified Shadow Crystal
					{3668, 41458}, -- Perfect Regal Shadow Crystal
					{3672, 41459}, -- Perfect Royal Shadow Crystal
					{3667, 41460}, -- Perfect Shifting Shadow Crystal
					{3671, 41461}, -- Perfect Sovereign Shadow Crystal
					{3666, 41462}, -- Perfect Tenuous Shadow Crystal
				},
				{t = ITEM_QUALITY3_DESC,
					{3467, 40029}, -- Balanced Twilight Opal
					{3469, 40032}, -- Defender's Twilight Opal
					{3466, 40025}, -- Glowing Twilight Opal
					{3471, 40034}, -- Guardian Twilight Opal
					{3475, 40030}, -- Infused Twilight Opal
					{3476, 40028}, -- Mysterious Twilight Opal
					{3470, 40033}, -- Puissant Twilight Opal
					{3472, 40026}, -- Purified Twilight Opal
					{3468, 40031}, -- Regal Twilight Opal
					{3473, 40027}, -- Royal Twilight Opal
					{3465, 40023}, -- Shifting Twilight Opal
					{3464, 40022}, -- Sovereign Twilight Opal
					{3474, 40024}, -- Tenuous Twilight Opal
				},
				{t = ITEM_QUALITY4_DESC,
					{3539, 40136}, -- Balanced Dreadstone
					{3541, 40139}, -- Defender's Dreadstone
					{3538, 40132}, -- Glowing Dreadstone
					{3542, 40141}, -- Guardian's Dreadstone
					{3547, 40137}, -- Infused Dreadstone
					{3548, 40135}, -- Mysterious Dreadstone
					{3543, 40140}, -- Puissant Dreadstone
					{3545, 40133}, -- Purified Dreadstone
					{3540, 40138}, -- Regal Dreadstone
					{3546, 40134}, -- Royal Dreadstone
					{3537, 40130}, -- Shifting Dreadstone
					{3536, 40129}, -- Sovereign Dreadstone
					{3544, 40131}, -- Tenuous Dreadstone
				},
			},
			{t = L["Prismatic"],
				{3749, 42701}, -- Enchanted Pearl
				{3750, 42702}, -- Enchanted Tear
				{3879, 49110}, -- Nightmare Tear
			},
		},
		{t = L["TBC"],
			{t = BLUE_GEM,
				{t = ITEM_QUALITY1_DESC,
					{2963, 28465}, -- Lustrous Zircon
					{2961, 28463}, -- Solid Zircon
					{2962, 28464}, -- Sparkling Zircon
				},
				{t = ITEM_QUALITY2_DESC,
					{2701, 23121}, -- Lustrous Azure Moonstone
					{2698, 23118}, -- Solid Azure Moonstone
					{2699, 23119}, -- Sparkling Azure Moonstone
					{2700, 23120}, -- Stormy Azure Moonstone
				},
				{t = ITEM_QUALITY3_DESC,
					{3268, 34831}, -- Eye of the Sea
					{2733, 24037}, -- Lustrous Star of Elune
					{2731, 24033}, -- Solid Star of Elune
					{2732, 24035}, -- Sparkling Star of Elune
					{2765, 24039}, -- Stormy Star of Elune
				},
				{t = ITEM_QUALITY4_DESC,
					{3262, 34256}, -- Charmed Amani Jewel
					{3124, 32202}, -- Lustrous Empyrean Sapphire
					{3122, 32200}, -- Solid Empyrean Sapphire
					{3123, 32201}, -- Sparkling Empyrean Sapphire
					{3125, 32203}, -- Stormy Empyrean Sapphire
				},
				{t = L["Jewelcrafters Only"],
					{3212, 33135}, -- Falling Star
				},
			},
			{t = RED_GEM,
				{t = ITEM_QUALITY1_DESC,
					{2956, 28458}, -- Bold Tourmaline
					{2960, 28462}, -- Bright Tourmaline
					{2957, 28459}, -- Delicate Tourmaline
					{2959, 28461}, -- Runed Tourmaline
					{2958, 28460}, -- Teardrop Tourmaline
				},
				{t = ITEM_QUALITY2_DESC,
					{2691, 23095}, -- Bold Blood Garnet
					{2971, 28595}, -- Bright Blood Garnet
					{2693, 23097}, -- Delicate Blood Garnet
					{2692, 23096}, -- Runed Blood Garnet
					{2690, 23094}, -- Teardrop Blood Garnet
				},
				{t = ITEM_QUALITY3_DESC,
					{2725, 24027}, -- Bold Living Ruby
					{2729, 24031}, -- Bright Living Ruby
					{2726, 24028}, -- Delicate Living Ruby
					{3103, 30598}, -- Don Amancio's Heart (A)
					{3065, 30571}, -- Don Rodrigo's Heart (H)
					{2754, 24036}, -- Flashing Living Ruby
					{2944, 28361}, -- Mighty Blood Garnet (A)
					{2943, 28360}, -- Mighty Blood Garnet (H)
					{2728, 24030}, -- Runed Living Ruby
					{2924, 27812}, -- Stark Blood Garnet (A)
					{2896, 27777}, -- Stark Blood Garnet (H)
					{2730, 24032}, -- Subtle Living Ruby
					{2727, 24029}, -- Teardrop Living Ruby
				},
				{t = ITEM_QUALITY4_DESC,
					{3115, 32193}, -- Bold Crimson Spinel
					{2945, 28362}, -- Bold Ornate Ruby
					{3119, 32197}, -- Bright Crimson Spinel
					{3116, 32194}, -- Delicate Crimson Spinel
					{3121, 32199}, -- Flashing Crimson Spinel
					{3118, 32196}, -- Runed Crimson Spinel
					{2912, 28118}, -- Runed Ornate Ruby
					{3120, 32198}, -- Subtle Crimson Spinel
					{3117, 32195}, -- Teardrop Crimson Spinel
				},
				{t = ITEM_QUALITY4_DESC.." "..L["Quest Rewards"],
					{3281, 35487}, -- Bright Crimson Spinel
					{3282, 35488}, -- Runed Crimson Spinel
					{3283, 35489}, -- Teardrop Crimson Spinel
				},
				{t = L["Jewelcrafters Only"],
					{3208, 33131}, -- Crimson Sun
					{3210, 33133}, -- Don Julio's Heart
					{3211, 33134}, -- Kailee's Rose
				},
			},
			{t = YELLOW_GEM,
				{t = ITEM_QUALITY1_DESC,
					{2964, 28466}, -- Brilliant Amber
					{2967, 28469}, -- Gleaming Amber
					{2966, 28468}, -- Rigid Amber
					{2965, 28467}, -- Smooth Amber
					{2968, 28470}, -- Thick Amber
				},
				{t = ITEM_QUALITY2_DESC,
					{2694, 23113}, -- Brilliant Golden Draenite
					{2695, 23114}, -- Gleaming Golden Draenite
					{3104, 31860}, -- Great Golden Draenite
					{2697, 23116}, -- Rigid Golden Draenite
					{2942, 28290}, -- Smooth Golden Draenite
					{2696, 23115}, -- Thick Golden Draenite
				},
				{t = ITEM_QUALITY3_DESC,
					{2734, 24047}, -- Brilliant Dawnstone
					{2759, 24053}, -- Mystic Dawnstone
					{2736, 24050}, -- Gleaming Dawnstone
					{3105, 31861}, -- Great Dawnstone
					{3270, 35315}, -- Quick Dawnstone
					{2764, 24051}, -- Rigid Dawnstone
					{2735, 24048}, -- Smooth Dawnstone
					{2737, 24052}, -- Thick Dawnstone
				},
				{t = ITEM_QUALITY4_DESC,
					{3126, 32204}, -- Brilliant Lionseye
					{3129, 32207}, -- Gleaming Lionseye
					{2914, 28120}, -- Gleaming Ornate Dawnstone
					{3132, 32210}, -- Great Lionseye
					{3131, 32209}, -- Mystic Lionseye
					{3287, 35761}, -- Quick Lionseye
					{3128, 32206}, -- Rigid Lionseye
					{3127, 32205}, -- Smooth Lionseye
					{2913, 28119}, -- Smooth Ornate Dawnstone
					{2891, 27679}, -- Sublime Mystic Dawnstone
					{3130, 32208}, -- Thick Lionseye
				},
				{t = L["Jewelcrafters Only"],
					{3217, 33140}, -- Blood of Amber
					{3221, 33144}, -- Facet of Eternity
					{3220, 33143}, -- Stone of Blades
				},
			},
			{t = L["Green"],
				{t = ITEM_QUALITY2_DESC,
					{2707, 23106}, -- Dazzling Deep Peridot
					{2706, 23105}, -- Enduring Deep Peridot
					{2757, 23104}, -- Jagged Deep Peridot
					{2762, 23103}, -- Radiant Deep Peridot
				},
				{t = ITEM_QUALITY3_DESC,
					{2921, 27809}, -- Barbed Deep Peridot (A)
					{2918, 27786}, -- Barbed Deep Peridot (H)
					{2744, 24065}, -- Dazzling Talasite
					{2743, 24062}, -- Enduring Talasite
					{3272, 35318}, -- Forceful Talasite
					{2758, 24067}, -- Jagged Talasite
					{2923, 27820}, -- Notched Deep Peridot (A)
					{2898, 27785}, -- Notched Deep Peridot (H)
					{2763, 24066}, -- Radiant Talasite
					{3226, 33782}, -- Steady Talasite
					{3157, 32635}, -- Unstable Peridot
					{3161, 32639}, -- Unstable Talasite
				},
				{t = ITEM_QUALITY4_DESC,
					{3147, 32225}, -- Dazzling Seaspray Emerald
					{3145, 32223}, -- Enduring Seaspray Emerald
					{3285, 35759}, -- Forceful Seaspray Emerald
					{3148, 32226}, -- Jagged Seaspray Emerald
					{3284, 35758}, -- Steady Seaspray Emerald
					{3146, 32224}, -- Radiant Seaspray Emerald
				},
				{t = ITEM_QUALITY4_DESC.." "..L["Instance Drops"],
					{3077, 30589}, -- Dazzling Chrysoprase
					{3082, 30594}, -- Effulgent Chrysoprase
					{3078, 30590}, -- Enduring Chrysoprase
					{3085, 30602}, -- Jagged Chrysoprase
					{3089, 30606}, -- Lambent Chrysoprase
					{3047, 30548}, -- Polished Chrysoprase
					{3091, 30608}, -- Radiant Chrysoprase
					{3058, 30560}, -- Rune Covered Chrysoprase
					{3074, 30586}, -- Seer's Chrysoprase
					{3080, 30592}, -- Steady Chrysoprase
					{3049, 30550}, -- Sundered Chrysoprase
					{3071, 30583}, -- Timeless Chrysoprase
					{3088, 30605}, -- Vivid Chrysoprase
				},
			},
			{t = L["Orange"],
				{t = ITEM_QUALITY2_DESC,
					{2755, 23100}, -- Glinting Flame Spessarite
					{2752, 23098}, -- Inscribed Flame Spessarite
					{2705, 23099}, -- Luminous Flame Spessarite
					{2760, 23101}, -- Potent Flame Spessarite
					{3110, 31866}, -- Veiled Flame Spessarite
					{3113, 31869}, -- Wicked Flame Spessarite
				},
				{t = ITEM_QUALITY3_DESC,
					{2756, 24061}, -- Glinting Noble Topaz
					{2753, 24058}, -- Inscribed Noble Topaz
					{2742, 24060}, -- Luminous Noble Topaz
					{2761, 24059}, -- Potent Noble Topaz
					{3271, 35316}, -- Reckless Noble Topaz
					{3159, 32637}, -- Unstable Citrine
					{3160, 32638}, -- Unstable Topaz
					{3111, 31867}, -- Veiled Noble Topaz
					{3112, 31868}, -- Wicked Noble Topaz
				},
				{t = ITEM_QUALITY4_DESC,
					{3142, 32220}, -- Glinting Pyrestone
					{2946, 28363}, -- Inscribed Ornate Topaz
					{3139, 32217}, -- Inscribed Pyrestone
					{3141, 32219}, -- Luminous Pyrestone
					{2916, 28123}, -- Potent Ornate Topaz
					{3140, 32218}, -- Potent Pyrestone
					{3286, 35760}, -- Reckless Pyrestone
					{3143, 32221}, -- Veiled Pyrestone
					{3144, 32222}, -- Wicked Pyrestone
				},
				{t = ITEM_QUALITY4_DESC.." "..L["Instance Drops"],
					{3062, 30565}, -- Assassin's Fire Opal
					{3084, 30601}, -- Beaming Fire Opal
					{3075, 30587}, -- Champion's Fire Opal
					{3070, 30582}, -- Deadly Fire Opal
					{3069, 30581}, -- Durable Fire Opal
					{3079, 30591}, -- Empowered Fire Opal
					{3072, 30584}, -- Enscribed Fire Opal
					{3057, 30559}, -- Etched Fire Opal
					{3056, 30558}, -- Glimmering Fire Opal
					{3055, 30556}, -- Glinting Fire Opal
					{3073, 30585}, -- Glistening Fire Opal
					{3050, 30551}, -- Infused Fire Opal
					{3081, 30593}, -- Iridescent Fire Opal
					{3046, 30547}, -- Luminous Fire Opal
					{3066, 30573}, -- Mysterious Fire Opal
					{3068, 30575}, -- Nimble Fire Opal
					{3076, 30588}, -- Potent Fire Opal
					{3052, 30553}, -- Pristine Fire Opal
					{3087, 30604}, -- Resplendent Fire Opal
					{3061, 30564}, -- Shining Fire Opal
					{3090, 30607}, -- Splendid Fire Opal
					{3053, 30554}, -- Stalwart Fire Opal
				},
			},
			{t = L["Purple"],
				{t = ITEM_QUALITY2_DESC,
					{3106, 31862}, -- Balanced Shadow Draenite
					{2708, 23108}, -- Glowing Shadow Draenite
					{3108, 31864}, -- Infused Shadow Draenite
					{3201, 32833}, -- Purified Jaggal Pearl
					{2709, 23109}, -- Royal Shadow Draenite
					{2710, 23110}, -- Shifting Shadow Draenite
					{2711, 23111}, -- Sovereign Shadow Draenite
				},
				{t = ITEM_QUALITY3_DESC,
					{3107, 31863}, -- Balanced Nightseye
					{2740, 24056}, -- Glowing Nightseye
					{3109, 31865}, -- Infused Nightseye
					{3202, 32836}, -- Purified Shadow Pearl
					{3280, 35707}, -- Regal Nightseye
					{2741, 24057}, -- Royal Nightseye
					{2739, 24055}, -- Shifting Nightseye
					{2738, 24054}, -- Sovereign Nightseye
					{3156, 32634}, -- Unstable Amethyst
					{3158, 32636}, -- Unstable Sapphire
				},
				{t = ITEM_QUALITY4_DESC,
					{3135, 32213}, -- Balanced Shadowsong Amethyst
					{3137, 32215}, -- Glowing Shadowsong Amethyst
					{3136, 32214}, -- Infused Shadowsong Amethyst
					{3318, 37503}, -- Purified Shadowsong Amethyst
					{3138, 32216}, -- Royal Shadowsong Amethyst
					{3134, 32212}, -- Shifting Shadowsong Amethyst
					{3133, 32211}, -- Sovereign Shadowsong Amethyst
				},
				{t = ITEM_QUALITY4_DESC.." "..L["Quest Rewards"],
					{3099, 31116}, -- Infused Amethyst
					{3101, 31118}, -- Pulsing Amethyst
					{3100, 31117}, -- Soothing Amethyst
				},
				{t = ITEM_QUALITY4_DESC.." "..L["Instance Drops"],
					{3051, 30552}, -- Blessed Tanzanite
					{3067, 30574}, -- Brutal Tanzanite
					{3063, 30566}, -- Defender's Tanzanite
					{3083, 30600}, -- Fluorescent Tanzanite
					{3054, 30555}, -- Glowing Tanzanite
					{3064, 30572}, -- Imperial Tanzanite
					{3060, 30563}, -- Regal Tanzanite
					{3086, 30603}, -- Royal Tanzanite
					{3048, 30549}, -- Shifting Tanzanite
					{3045, 30546}, -- Sovereign Tanzanite
				},
			},
			{t = L["Prismatic"],
				{2947, 22460}, -- Prismatic Sphere
				{2948, 22459}, -- Void Sphere
			},
		},
	}
	local GemsMetaMenu = {
		{t = L["Wrath"],
			{t = L["Jewelcrafting"],
				{3637, 41380}, -- Austere Earthsiege Diamond
				{3641, 41389}, -- Beaming Earthsiege Diamond
				{3626, 41395}, -- Bracing Earthsiege Diamond
				{3621, 41285}, -- Chaotic Skyflare Diamond
				{3622, 41307}, -- Destructive Skyflare Diamond
				{3634, 41377}, -- Effulgent Skyflare Diamond
				{3623, 41333}, -- Ember Skyflare Diamond
				{3624, 41335}, -- Enigmatic Skyflare Diamond
				{3631, 41396}, -- Eternal Earthsiege Diamond
				{3635, 41378}, -- Forlorn Skyflare Diamond
				{3636, 41379}, -- Impassive Skyflare Diamond
				{3627, 41401}, -- Insightful Earthsiege Diamond
				{3640, 41385}, -- Invigorating Earthsiege Diamond
				{3638, 41381}, -- Persistent Earthsiege Diamond
				{3642, 41397}, -- Powerful Earthsiege Diamond
				{3628, 41398}, -- Relentless Earthsiege Diamond
				{3633, 41376}, -- Revitalizing Skyflare Diamond
				{3625, 41339}, -- Swift Skyflare Diamond
				{3643, 41400}, -- Thundering Skyflare Diamond
				{3632, 41375}, -- Tireless Skyflare Diamond
				{3639, 41382}, -- Trenchant Earthsiege Diamond
			},
			{t = L["Wintergrasp"],
				{3801, 44081}, -- Enigmatic Starflare Diamond
				{3802, 44084}, -- Forlorn Starflare Diamond
				{3800, 44082}, -- Impassive Starflare Diamond
				{3803, 44087}, -- Persistent Earthshatter Diamond
				{3804, 44088}, -- Powerful Earthshatter Diamond
				{3798, 44076}, -- Swift Starflare Diamond
				{3799, 44078}, -- Tireless Starflare Diamond
				{3805, 44089}, -- Trenchant Earthshatter Diamond
			},
		},
		{t = L["TBC"],
			{2832, 25897}, -- Bracing Earthstorm Diamond
			{2834, 25899}, -- Brutal Earthstorm Diamond
			{3261, 34220}, -- Chaotic Skyfire Diamond
			{2827, 25890}, -- Destructive Skyfire Diamond
			{3275, 35503}, -- Ember Skyfire Diamond
			{2830, 25895}, -- Enigmatic Skyfire Diamond
			{3274, 35501}, -- Eternal Earthstorm Diamond
			{3163, 32641}, -- Imbued Unstable Diamond
			{2835, 25901}, -- Insightful Earthstorm Diamond
			{2828, 25893}, -- Mystical Skyfire Diamond
			{3162, 32640}, -- Potent Unstable Diamond
			{2831, 25896}, -- Powerful Earthstorm Diamond
			{3154, 32409}, -- Relentless Earthstorm Diamond
			{2969, 28556}, -- Swift Windfire Diamond
			{2829, 25894}, -- Swift Skyfire Diamond
			{2970, 28557}, -- Swift Starfire Diamond
			{2833, 25898}, -- Tenacious Earthstorm Diamond
			{3155, 32410}, -- Thundering Skyfire Diamond
		},
	}

	-- Generate the gem color data
	local colordata = {blue = {}, red = {}, yellow = {}, meta = {},}
	local function addGem(t, buildTable)
		if type(t) ~= "table" then return end
		for i = 1, #t do
			local v = t[i]
			if type(v[1]) == "number" then
				buildTable[v[1]] = true
			else
				addGem(v, buildTable)
			end
		end
	end
	addGem(GemsMenu[1][1], colordata.blue)
	addGem(GemsMenu[2][1], colordata.blue)
	addGem(GemsMenu[1][4], colordata.blue)
	addGem(GemsMenu[2][4], colordata.blue)
	addGem(GemsMenu[1][6], colordata.blue)
	addGem(GemsMenu[2][6], colordata.blue)
	addGem(GemsMenu[1][7], colordata.blue)
	addGem(GemsMenu[2][7], colordata.blue)
	addGem(GemsMenu[1][2], colordata.red)
	addGem(GemsMenu[2][2], colordata.red)
	addGem(GemsMenu[1][5], colordata.red)
	addGem(GemsMenu[2][5], colordata.red)
	addGem(GemsMenu[1][6], colordata.red)
	addGem(GemsMenu[2][6], colordata.red)
	addGem(GemsMenu[1][7], colordata.red)
	addGem(GemsMenu[2][7], colordata.red)
	addGem(GemsMenu[1][3], colordata.yellow)
	addGem(GemsMenu[2][3], colordata.yellow)
	addGem(GemsMenu[1][4], colordata.yellow)
	addGem(GemsMenu[2][4], colordata.yellow)
	addGem(GemsMenu[1][5], colordata.yellow)
	addGem(GemsMenu[2][5], colordata.yellow)
	addGem(GemsMenu[1][7], colordata.yellow)
	addGem(GemsMenu[2][7], colordata.yellow)
	addGem(GemsMetaMenu, colordata.meta)

	-- Sort the gem menus by gem name, but keep the same ordering for menus
	local LE = LibStub("AceLocale-3.0"):GetLocale("WoWEquipLE", false)
	local function sortFunc(a, b)
		-- This function sorts menu items by name and places them before all submenus.
		-- Submenu ordering is retained in the hard-coded order by using temp numbers.
		if a.t and b.t then return a.temp < b.temp end -- both are submenus, arrange by their temp number
		if a.t then return false end -- a[] is a submenu, return false to signify a is not < b
		if b.t then return true end -- b[] is a submenu, return true to signify a < b
		return LE[a[2]] < LE[b[2]] -- arrange by name
	end
	local function sortgems(t)
		for i = 1, #t do
			local v = t[i]
			if v.t then
				sortgems(v)
				v.temp = i -- give submenu a temp number
			end
		end
		sort(t, sortFunc)
		for i = 1, #t do
			local v = t[i]
			if v.t then
				v.temp = nil -- remove that temp number
			end
		end
	end
	sortgems(GemsMenu)
	sortgems(GemsMetaMenu)

	local data = {
		[EMPTY_SOCKET_BLUE] = GemsMenu,
		[EMPTY_SOCKET_META] = GemsMetaMenu,
		[EMPTY_SOCKET_RED] = GemsMenu,
		[EMPTY_SOCKET_YELLOW] = GemsMenu,
		[EMPTY_SOCKET_NO_COLOR] = GemsMenu,
	}

	return data, colordata
end

function WoWEquip:CollapseFavoritesData(data)
	-- Recursive function to match a table in the favorites to the data tables
	local function findEnchant(t, u)
		for i = 1, #t do
			local v = t[i]
			if v.t then
				local found = findEnchant(v, u)
				if found then return found end
			else
				if u[1] == v[1] and u[2] == v[2] and u[3] == v[3] and u[4] == v[4] then return v end
			end
		end
	end
	-- Alias the favourite subtables to the actual entries
	local db = self.db.global.favorites
	for k, v in next, data do
		if db[k] then
			for i = #db[k], 1, -1 do
				local enchant = findEnchant(data[k], db[k][i])
				if enchant then
					-- Enchant found, assign the table over to the favorites
					db[k][i] = enchant
				else
					-- Not found, remove the favorite entry
					tremove(db[k], i)
				end
			end
			if #db[k] == 0 then db[k] = nil end
		end
	end
	-- Self delete for garbage collection
	if not self.GenerateEnchantDataTables and not self.GenerateGemDataTables then
		self.CollapseFavoritesData = nil
		getmetatable(WoWEquip).__index = nil
	end
end




-- vim: ts=4 noexpandtab
