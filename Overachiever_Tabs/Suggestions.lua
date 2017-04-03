
--
--  Overachiever - Tabs: Suggestions.lua
--    by Tuhljin
--
--  If you don't wish to use the suggestions tab, feel free to delete this file or rename it (e.g. to
--  Suggestions_unused.lua). The addon's other features will work regardless.
--

local L = OVERACHIEVER_STRINGS

local LBZ = LibStub("LibBabble-Zone-3.0"):GetUnstrictLookupTable()
local LBZR = LibStub("LibBabble-Zone-3.0"):GetReverseLookupTable()
local LBI = LibStub:GetLibrary("LibBabble-Inventory-3.0"):GetLookupTable()
local LBIR = LibStub:GetLibrary("LibBabble-Inventory-3.0"):GetReverseLookupTable()

local RecentReminders = Overachiever.RecentReminders

local IsAlliance = UnitFactionGroup("player") == "Alliance"
local suggested = {}



-- ZONE-SPECIFIC ACHIEVEMENTS
----------------------------------------------------

local ACHID_ZONE_NUMQUESTS
if (IsAlliance) then
  ACHID_ZONE_NUMQUESTS = {
  -- Outland
	["Blade's Edge Mountains"] = 1193,
	["Zangarmarsh"] = 1190,
	["Netherstorm"] = 1194,
	["Hellfire Peninsula"] = 1189,
	["Terokkar Forest"] = 1191,
	["Shadowmoon Valley"] = 1195,
	["Nagrand"] = 1192,
  -- Northrend
	["Icecrown"] = 40,
	["Dragonblight"] = 35,
	["Howling Fjord"] = 34,
	["Borean Tundra"] = 33,
	["Sholazar Basin"] = 39,
	["Zul'Drak"] = 36,
	["Grizzly Hills"] = 37,
	["The Storm Peaks"] = 38,
  }
else
  ACHID_ZONE_NUMQUESTS = {
  -- Outland
	["Blade's Edge Mountains"] = 1193,
	["Zangarmarsh"] = 1190,
	["Netherstorm"] = 1194,
	["Hellfire Peninsula"] = 1271,
	["Terokkar Forest"] = 1272,
	["Shadowmoon Valley"] = 1195,
	["Nagrand"] = 1273,
  -- Northrend
	["Icecrown"] = 40,
	["Dragonblight"] = 1359,
	["Howling Fjord"] = 1356,
	["Borean Tundra"] = 1358,
	["Sholazar Basin"] = 39,
	["Zul'Drak"] = 36,
	["Grizzly Hills"] = 1357,
	["The Storm Peaks"] = 38,
  }
end

local ACHID_ZONE_MISC = {
-- Eastern Kingdoms
	["Stranglethorn Vale"] =	-- "The Green Hills of Stranglethorn", "Gurubashi Arena Master",
		{ 940, 389, 396, 306 },	-- "Gurubashi Arena Grand Master", "Master Angler of Azeroth"
-- Outland
	["Blade's Edge Mountains"] = 1276,	-- "Blade's Edge Bomberman"
	["Nagrand"] = { 939, "1576:1" },	-- "Hills Like White Elekk", "Of Blood and Anguish"
	["Netherstorm"] = 545,		-- "Shave and a Haircut"
	["Shattrath City"] =	-- "My Sack is "Gigantique"", "Old Man Barlowned", "Kickin' It Up a Notch"
		{ 1165, 905, 906 },
	["Terokkar Forest"] = { 905, 1275 },	-- "Old Man Barlowned", "Bombs Away"
-- Northrend
	["Borean Tundra"] = 561,	-- "D.E.H.T.A's Little P.I.T.A."
	["Dragonblight"] = { 1277, 547 },	-- "Rapid Defense", "Veteran of the Wrathgate"
	["Dalaran"] = { 2096, 1956, 1958, 545, 1998, IsAlliance and 1782 or 1783, 3217 },
	["Grizzly Hills"] = { "1596:1" },	-- "Guru of Drakuru"
	["Icecrown"] = { SUBZONES = {
		["*Argent Tournament Grounds*The Ring of Champions*Argent Pavilion*The Argent Valiants' Ring*The Aspirants' Ring*The Alliance Valiants' Ring*Silver Covenant Pavilion*Sunreaver Pavilion*The Horde Valiants' Ring*"] =
			{ 2756, 2772, 2836, 2773, 3736 },
		-- "Argent Aspiration", "Tilted!", "Lance a Lot", "It's Just a Flesh Wound", "Pony Up!"
	} },
	["Sholazar Basin"] =		-- "The Snows of Northrend", "Honorary Frenzyheart",
		{ 938, 961, 962 },	-- "Savior of the Oracles"
	["Zul'Drak"] = { "1576:2", "1596:2" },	-- "Of Blood and Anguish", "Guru of Drakuru"
	["Wintergrasp"] = { 2199, 1717, 1751, 1755, 1727, 1723 },
}
if (IsAlliance) then
  tinsert(ACHID_ZONE_MISC["Grizzly Hills"], 2016) -- "Grizzled Veteran"
  tinsert(ACHID_ZONE_MISC["Wintergrasp"], 1737)	-- "Destruction Derby"
  tinsert(ACHID_ZONE_MISC["Wintergrasp"], 1752)	-- "Master of Wintergrasp"
  -- "City Defender", "Shave and a Haircut":
  ACHID_ZONE_MISC["Stormwind City"] = { 388, 545 }
  ACHID_ZONE_MISC["Ironforge"] = { 388, 545 }
  ACHID_ZONE_MISC["Darnassus"] = 388
  ACHID_ZONE_MISC["The Exodar"] = 388
  -- "Wrath of the Alliance", faction leader kill, "For The Alliance!":
  ACHID_ZONE_MISC["Orgrimmar"] = { 604, 610, 614 }
  ACHID_ZONE_MISC["Thunder Bluff"] = { 604, 611, 614 }
  ACHID_ZONE_MISC["Undercity"] = { 604, 612, 614 }
  ACHID_ZONE_MISC["Silvermoon City"] = { 604, 613, 614 }
  -- "A Silver Confidant", "Champion of the Alliance":
  tinsert(ACHID_ZONE_MISC["Icecrown"], 3676)
  tinsert(ACHID_ZONE_MISC["Icecrown"], 2782)
else
  tinsert(ACHID_ZONE_MISC["Grizzly Hills"], 2017) -- "Grizzled Veteran"
  tinsert(ACHID_ZONE_MISC["Wintergrasp"], 2476)	-- "Destruction Derby"
  tinsert(ACHID_ZONE_MISC["Wintergrasp"], 2776)	-- "Master of Wintergrasp"
  -- "City Defender", "Shave and a Haircut":
  ACHID_ZONE_MISC["Orgrimmar"] = { 1006, 545 }
  ACHID_ZONE_MISC["Thunder Bluff"] = 1006
  ACHID_ZONE_MISC["Undercity"] = { 1006, 545 }
  ACHID_ZONE_MISC["Silvermoon City"] = 1006
  -- "Wrath of the Horde", faction leader kill, "For The Horde!":
  ACHID_ZONE_MISC["Stormwind City"] = { 603, 615, 619 }
  ACHID_ZONE_MISC["Ironforge"] = { 603, 616, 619 }
  ACHID_ZONE_MISC["Darnassus"] = { 603, 617, 619 }
  ACHID_ZONE_MISC["The Exodar"] = { 603, 618, 619 }
  -- "The Sunreavers", "Champion of the Horde":
  tinsert(ACHID_ZONE_MISC["Icecrown"], 3677)
  tinsert(ACHID_ZONE_MISC["Icecrown"], 2788)
end
-- "The Fishing Diplomat":
tinsert(ACHID_ZONE_MISC["Stormwind City"], "150:2")
tinsert(ACHID_ZONE_MISC["Orgrimmar"], "150:1")
-- "Old Crafty" and "Old Ironjaw":
tinsert(ACHID_ZONE_MISC["Orgrimmar"], 1836)
tinsert(ACHID_ZONE_MISC["Ironforge"], 1837)

-- INSTANCES - ANY DIFFICULTY (any group size):
local ACHID_INSTANCES = {
-- Classic Dungeons
	["The Deadmines"] = 628,
	["Ragefire Chasm"] = 629,
	["Wailing Caverns"] = 630,
	["Shadowfang Keep"] = 631,
	["Blackfathom Deeps"] = 632,
	["The Stockade"] = 633,		-- "Stormwind Stockade"
	["Gnomeregan"] = 634,
	["Razorfen Kraul"] = 635,
	["Razorfen Downs"] = 636,
	["Scarlet Monastery"] = 637,
	["Uldaman"] = 638,
	["Zul'Farrak"] = 639,
	["Maraudon"] = 640,
	["Sunken Temple"] = 641,
	["Blackrock Depths"] = 642,
	["Lower Blackrock Spire"] = 643,
	["Upper Blackrock Spire"] = { 1307, 2188 },	-- "Upper Blackrock Spire", "Leeeeeeeeeeeeeroy!"
	["Dire Maul"] = 644,
	["Scholomance"] = 645,
	["Stratholme"] = 646,
-- Classic Raids
	["Zul'Gurub"] = { 688, 560, 957 },	-- "Zul'Gurub", "Deadliest Catch", "Hero of the Zandalar"
	["Ruins of Ahn'Qiraj"] = 689,
	--["Onyxia's Lair"] = 684, -- This is now a Feat of Strength
	["Molten Core"] = 686,
	["Blackwing Lair"] = 685,
	["Temple of Ahn'Qiraj"] = 687,
-- Burning Crusade
	["Auchenai Crypts"] = 666,
	["The Mechanar"] = 658,
	["Zul'Aman"] = 691,
	["The Blood Furnace"] = 648,
	["Hellfire Ramparts"] = 647,
	["Mana-Tombs"] = 651,
	["The Botanica"] = 659,
	["Shadow Labyrinth"] = 654,
	["Sunwell Plateau"] = 698,
	["Black Temple"] = 697,			-- "The Black Temple"
	["Hyjal Summit"] = 695,			-- "The Battle for Mount Hyjal"
	["Tempest Keep"] = 696,
	["Sethekk Halls"] = 653,
	["Old Hillsbrad Foothills"] = 652,	-- "The Escape From Durnholde"
	["The Black Morass"] = 655,		-- "Opening of the Dark Portal"
	["Magtheridon's Lair"] = 693,
	["Gruul's Lair"] = 692,
	["Karazhan"] = 690,
	["The Steamvault"] = 656,
	["Serpentshrine Cavern"] = { 694, 144 },	-- "Serpentshrine Cavern", "The Lurker Above"
	["The Shattered Halls"] = 657,
	["The Slave Pens"] = 649,
	["The Underbog"] = 650,			-- "Underbog"
	["Magisters' Terrace"] = 661,		-- "Magister's Terrace"
	["The Arcatraz"] = 660,
-- Lich King Dungeons
	["The Culling of Stratholme"] = 479,
	["Utgarde Keep"] = 477,
	["Drak'Tharon Keep"] = 482,
	["Gundrak"] = 484,
	["Ahn'kahet: The Old Kingdom"] = 481,
	["Halls of Stone"] = 485,
	["Utgarde Pinnacle"] = 488,
	["The Oculus"] = 487,
	["Halls of Lightning"] = 486,
	["The Nexus"] = 478,
	["The Violet Hold"] = 483,
	["Azjol-Nerub"] = 480,
	["Trial of the Champion"] = IsAlliance and 4296 or 3778,
	["The Forge of Souls"] = 4516,
	["Halls of Reflection"] = 4518,
	["Pit of Saron"] = 4517,
}
-- Battlegrounds
ACHID_INSTANCES["Eye of the Storm"] = { 1171, 587, 1258, 211 }
if (IsAlliance) then
	ACHID_INSTANCES["Alterac Valley"] = { 1167, 907 }
	ACHID_INSTANCES["Arathi Basin"] = { 1169, 907 }
	ACHID_INSTANCES["Warsong Gulch"] = { 1172, 1259, 907 }
	ACHID_INSTANCES["Strand of the Ancients"] = 2194
	ACHID_INSTANCES["Isle of Conquest"] = { 3857, 3845, 3846 }
else
	ACHID_INSTANCES["Alterac Valley"] = { 1168, 714 }
	ACHID_INSTANCES["Arathi Basin"] = { 1170, 714 }
	ACHID_INSTANCES["Warsong Gulch"] = { 1173, 1259, 714 }
	ACHID_INSTANCES["Strand of the Ancients"] = 2195
	ACHID_INSTANCES["Isle of Conquest"] = { 3957, 3845, 4176 }
end
-- For all battlegrounds:
local ACHID_BATTLEGROUNDS = { 238, 245, IsAlliance and 246 or 1005, 247, 229, 227, 231, 1785 }

-- INSTANCES - NORMAL ONLY (any group size):
local ACHID_INSTANCES_NORMAL = {
}

-- INSTANCES - HEROIC ONLY (any group size):
local ACHID_INSTANCES_HEROIC = {
-- Burning Crusade
	["Auchenai Crypts"] = 672,
	["The Blood Furnace"] = 668,
	["The Slave Pens"] = 669,
	["Hellfire Ramparts"] = 667,
	["Mana-Tombs"] = 671,
	["The Underbog"] = 670,			-- "Heroic: Underbog"
	["Old Hillsbrad Foothills"] = 673,	-- "Heroic: The Escape From Durnholde"
	["Magisters' Terrace"] = 682,		-- "Heroic: Magister's Terrace"
	["The Arcatraz"] = 681,
	["The Mechanar"] = 679,
	["The Shattered Halls"] = 678,
	["The Steamvault"] = 677,
	["The Botanica"] = 680,
	["The Black Morass"] = 676,		-- "Heroic: Opening of the Dark Portal"
	["Shadow Labyrinth"] = 675,
	["Sethekk Halls"] = 674,
-- Lich King Dungeons
	["Halls of Stone"] = { 496, 1866, 2154, 2155 },
	["Gundrak"] = { 495, 2040, 2152, 1864, 2058 },
	["Azjol-Nerub"] = { 491, 1860, 1296, 1297 },
	["Halls of Lightning"] = { 497, 2042, 1867, 1834 },
	["Utgarde Keep"] = { 489, 1919 },
	["The Nexus"] = { 490, 2037, 2036, 2150 },
	["Drak'Tharon Keep"] = { 493, 2039, 2057, 2151 },
	["Ahn'kahet: The Old Kingdom"] = { 492, 2056, 1862, 2038 }, --removed: 1861
	["The Oculus"] = { 498, 1868, 1871, 2044, 2045, 2046 },
	["The Violet Hold"] = { 494, 2153, 1865, 2041, 1816 },
	["The Culling of Stratholme"] = { 500, 1872, 1817 },
	["Utgarde Pinnacle"] = { 499, 1873, 2043, 2156, 2157 },
	["Trial of the Champion"] = { IsAlliance and 4298 or 4297, 3802, 3803, 3804 },
	["The Forge of Souls"] = { 4519, 4522, 4523 },
	["Halls of Reflection"] = { 4521, 4526 },
	["Pit of Saron"] = { 4520, 4524, 4525 },
}

-- INSTANCES - 10-MAN ONLY (normal or heroic):
local ACHID_INSTANCES_10 = {
-- Lich King Raids
	["Naxxramas"] = { 2146, 576, 578, 572, 1856, 2176, 2178, 2180, 568, 2187, 1996, 1997, 1858, 564, 2182, 2184,
		566, 574, 562 },
	["Onyxia's Lair"] = { 4396, 4402, 4403, 4404 },
	["The Eye of Eternity"] = { 622, 1874, 2148, 1869 },
	["The Obsidian Sanctum"] = { 1876, 2047, 2049, 2050, 2051, 624 },
	["Ulduar"] = { 2957, 2903, 2894,
		SUBZONES = {
			--["*Formation Grounds*The Colossal Forge*Razorscale's Aerie*The Scrapyard*"] = 2886, -- Siege
			["Formation Grounds"] = { 3097, 2905, 2907, 2909, 2911, 2913 },
			["Razorscale's Aerie"] = { 2919, 2923 },
			["The Colossal Forge"] = { 2925, 2927, 2930 },
			["The Scrapyard"] = { 2931, 2933, 2934, 2937, 3058 },

			--["*The Assembly of Iron*The Shattered Walkway*The Observation Ring*"] = 2888, -- Antechamber
			["The Assembly of Iron"] = { 2939, 2940, 2941, 2945, 2947 },
			["The Shattered Walkway"] = { 2951, 2953, 2955, 2959 },
			["The Observation Ring"] = { 3006, 3076 },

			--["*The Spark of Imagination*The Conservatory of Life*The Clash of Thunder*The Halls of Winter*"] = 2890, -- Keepers
			["The Halls of Winter"] = { 2961, 2963, 2967, 3182, 2969 },
			["The Clash of Thunder"] = { 2971, 2973, 2975, 2977 },
			["The Conservatory of Life"] = { 2979, 2980, 2985, 2982, 3177 },
			["The Spark of Imagination"] = { 2989, 3138, 3180 },

			--["*The Descent into Madness*The Prison of Yogg-Saron*"] = 2892, -- Descent
			["The Descent into Madness"] = { 2996, 3181 },
			["The Prison of Yogg-Saron"] = { 3009, 3157, 3008, 3012, 3014, 3015 },

			["The Celestial Planetarium"] = { 3036, 3003, 3004, 3316 }, -- Alganon
		},
	},
	["Vault of Archavon"] = { 1722, 3136, 3836, 4016 },
	["Trial of the Crusader"] = { 3917, 3936, 3798, 3799, 3800, 3996, 3797 },
	["Icecrown Citadel"] = { 4580, 4601, 4534, 4538, 4577, 4535, 4536, 4537, 4578, 4581, 4539, 4579, 4582 },
}

-- INSTANCES - 25-MAN ONLY (normal or heroic):
local ACHID_INSTANCES_25 = {
-- Lich King Raids
	["Naxxramas"] = { 2186, 579, 565, 577, 575, 2177, 563, 567, 1857, 569, 573, 1859, 2139, 2181, 2183, 2185,
		2147, 2140, 2179 },
	["Onyxia's Lair"] = { 4397, 4405, 4406, 4407 },
	["The Eye of Eternity"] = { 623, 1875, 1870, 2149 },
	["The Obsidian Sanctum"] = { 625, 2048, 2052, 2053, 2054, 1877 },
	["Ulduar"] = { 2958, 2904, 2895,
		SUBZONES = {
			--["*Formation Grounds*The Colossal Forge*Razorscale's Aerie*The Scrapyard*"] = 2887, -- Siege
			["Formation Grounds"] = { 3098, 2906, 2908, 2910, 2912, 2918 },
			["Razorscale's Aerie"] = { 2921, 2924 },
			["The Colossal Forge"] = { 2926, 2928, 2929 },
			["The Scrapyard"] = { 2932, 2935, 2936, 2938, 3059 },

			--["*The Assembly of Iron*The Shattered Walkway*The Observation Ring*"] = 2889, -- Antechamber
			["The Assembly of Iron"] = { 2942, 2943, 2944, 2946, 2948 },
			["The Shattered Walkway"] = { 2952, 2954, 2956, 2960 },
			["The Observation Ring"] = { 3007, 3077 },

			--["*The Spark of Imagination*The Conservatory of Life*The Clash of Thunder*The Halls of Winter*"] = 2891, -- Keepers
			["The Halls of Winter"] = { 2962, 2965, 2968, 3184, 2970 },
			["The Clash of Thunder"] = { 2972, 2974, 2976, 2978 },
			["The Conservatory of Life"] = { 3118, 2981, 2984, 2983, 3185 },
			["The Spark of Imagination"] = { 3237, 2995, 3189 },

			--["*The Descent into Madness*The Prison of Yogg-Saron*"] = 2893, -- Descent
			["The Descent into Madness"] = { 2997, 3188 },
			["The Prison of Yogg-Saron"] = { 3011, 3161, 3010, 3013, 3017, 3016 },

			["The Celestial Planetarium"] = { 3037, 3002, 3005 }, -- Alganon
		},
	},
	["Vault of Archavon"] = { 1721, 3137, 3837, 4017 },
	["Trial of the Crusader"] = { 3916, 3937, 3814, 3815, 3816, 3997, 3813 },
	["Icecrown Citadel"] = { 4620, 4621, 4610, 4614, 4615, 4611, 4612, 4613, 4616, 4622, 4618, 4619, 4617 },
}

-- INSTANCES - NORMAL 10-MAN ONLY:
local ACHID_INSTANCES_10_NORMAL = {
	["Icecrown Citadel"] = 4532,
}

-- INSTANCES - HEROIC 10-MAN ONLY:
local ACHID_INSTANCES_10_HEROIC = {
	["Trial of the Crusader"] = { 3918, 3808 },
	["Icecrown Citadel"] = 4636,
}

-- INSTANCES - NORMAL 25-MAN ONLY:
local ACHID_INSTANCES_25_NORMAL = {
	["Icecrown Citadel"] = 4608,
}

-- INSTANCES - HEROIC 25-MAN ONLY:
local ACHID_INSTANCES_25_HEROIC = {
	["Trial of the Crusader"] = { 3812, 3817 },
	["Icecrown Citadel"] = 4637,
}


-- Create reverse lookup table for L.SUBZONES:
local SUBZONES_REV = {}
for k,v in pairs(L.SUBZONES) do  SUBZONES_REV[v] = k;  end

local function ZoneLookup(zoneName, isSub, subz)
  zoneName = zoneName or subz or ""
  local trimz = strtrim(zoneName)
  return isSub and SUBZONES_REV[trimz] or LBZR[trimz] or LBZR[zoneName] or trimz
end


-- TRADESKILL ACHIEVEMENTS
----------------------------------------------------

local ACHID_TRADESKILL = {
	["Cooking"] = IsAlliance and 1563 or 1784,	-- "Hail to the Chef"
	["Fishing"] = 1516,				-- "Accomplished Angler"
}

local ACHID_TRADESKILL_ZONE = {
	["Cooking"] = {
		["Dalaran"] = { 1998, IsAlliance and 1782 or 1783, 3217, 3296 },
			-- "Dalaran Cooking Award", "Our Daily Bread", "Chasing Marcia", "Cooking with Style"
		["Shattrath City"] = 906	-- "Kickin' It Up a Notch"
        },
	["Fishing"] = {
		["Dalaran"] = { 2096, 1958 },	-- "The Coin Master", "I Smell A Giant Rat"
		["Ironforge"] = 1837,		-- "Old Ironjaw"
		["Orgrimmar"] = {1836,"150:1"},	-- "Old Crafty", "The Fishing Diplomat"
		["Serpentshrine Cavern"] = 144,	-- "The Lurker Above"
		["Shattrath City"] = 905,	-- "Old Man Barlowned"
		["Stormwind City"] = "150:2",	-- "The Fishing Diplomat"
		["Terokkar Forest"] = { 905, 726 },	-- "Old Man Barlowned", "Mr. Pinchy's Magical Crawdad Box"
		["Zul'Gurub"] = 560,		-- "Deadliest Catch"
		
		-- "Master Angler of Azeroth":
		["Stranglethorn Vale"] = 306,
		["Howling Fjord"] = 306,
		["Grizzly Hills"] = 306,
		["Borean Tundra"] = 306,
		["Sholazar Basin"] = 306,
		["Dragonblight"] = 306,
		["Crystalsong Forest"] = 306,
		["Icecrown"] = 306,
		["Zul'Drak"] = 306,
        }
}

local ACHID_TRADESKILL_BG = { Cooking = 1785 }	-- "Dinner Impossible"



-- SUGGESTIONS TAB CREATION AND HANDLING
----------------------------------------------------

local VARS
local frame, panel, sortdrop
local LocationsList, EditZoneOverride, subzdrop, subzdrop_menu, subzdrop_Update = {}
local RefreshBtn, ResetBtn, NoSuggestionsLabel, ResultsLabel

local function SortDrop_OnSelect(self, value)
  VARS.SuggestionsSort = value
  frame.sort = value
  frame:ForceUpdate(true)
end

local function OnLoad(v)
  VARS = v
  sortdrop:SetSelectedValue(VARS.SuggestionsSort or 0)
end

frame, panel = Overachiever.BuildNewTab("Overachiever_SuggestionsFrame", L.SUGGESTIONS_TAB,
                "Interface\\AddOns\\Overachiever_Tabs\\SuggestionsWatermark", L.SUGGESTIONS_HELP, OnLoad,
                ACHIEVEMENT_FILTER_INCOMPLETE)
frame.AchList_checkprev = true

sortdrop = TjDropDownMenu.CreateDropDown("Overachiever_SuggestionsFrameSortDrop", panel, {
  {
    text = L.TAB_SORT_NAME,
    value = 0
  },
  {
    text = L.TAB_SORT_COMPLETE,
    value = 1
  },
  {
    text = L.TAB_SORT_POINTS,
    value = 2
  },
  {
    text = L.TAB_SORT_ID,
    value = 3
  };
})
sortdrop:SetLabel(L.TAB_SORT, true)
sortdrop:SetPoint("TOPLEFT", panel, "TOPLEFT", -16, -22)
sortdrop:OnSelect(SortDrop_OnSelect)

local CurrentSubzone

local function Refresh_Add(...)
  local id, _, complete, nextid
  for i=1, select("#", ...) do
    id = select(i, ...)
    if (id) then

      if (type(id) == "table") then
        Refresh_Add(unpack(id))
        if (id.SUBZONES) then
          for subz, subzsuggest in pairs(id.SUBZONES) do
            if (subz == CurrentSubzone or strfind(subz, "*"..CurrentSubzone.."*", 1, true)) then
            -- Asterisks surround subzone names since they aren't used in any actual subzone names.
              Refresh_Add(subzsuggest)
            end
          end
        end

      elseif (type(id) == "string") then
        local crit
        id, crit = strsplit(":", id)
        id, crit = tonumber(id), tonumber(crit)
        _, _, _, complete = GetAchievementInfo(id)
        if (complete) then
          nextid, complete = GetNextAchievement(id)
          if (nextid) then
            local name = GetAchievementCriteriaInfo(id, crit)
            while (complete and GetAchievementCriteriaInfo(nextid, crit) == name) do
            -- Find first incomplete achievement in the chain that has this criteria:
              id = nextid
              nextid, complete = GetNextAchievement(id)
            end
            if (nextid and GetAchievementCriteriaInfo(nextid, crit) == name) then
              id = nextid
            end
          end
        end
        suggested[id] = crit
        -- Known limitation (of no consequence at this time due to which suggestions actually use this feature):
        -- If an achievement is suggested due to multiple criteria, only one of them is reflected by this.
        -- (A future fix may involve making it a table when there's more than one, though it would need to check
        -- against adding the same criteria number twice.)

      else
        _, _, _, complete = GetAchievementInfo(id)
        if (complete) then
          nextid, complete = GetNextAchievement(id)
          if (nextid) then
            while (complete) do  -- Find first incomplete achievement in the chain:
              id = nextid
              nextid, complete = GetNextAchievement(id)
            end
            id = nextid or id
          end
        end
        suggested[id] = true
      end

    end
  end
end

local TradeskillSuggestions

local Refresh_stoploop

local function Refresh(self)
  if (not frame:IsVisible() or Refresh_stoploop) then  return;  end
  if (self == RefreshBtn or self == EditZoneOverride) then  PlaySound("igMainMenuOptionCheckBoxOn");  end

  wipe(suggested)
  EditZoneOverride:ClearFocus()
  CurrentSubzone = ZoneLookup(GetSubZoneText(), true)
  local zone = LocationsList[ strtrim(strlower(EditZoneOverride:GetText())) ]
  if (zone) then
    zone = LocationsList[zone]
    EditZoneOverride:SetText(zone)
    if (self ~= subzdrop) then  subzdrop_Update(zone);  end
    local subz = subzdrop:GetSelectedValue()
    if (subz ~= 0) then  CurrentSubzone = subz;  end
  else
    zone = ZoneLookup(GetRealZoneText(), nil, CurrentSubzone)
    EditZoneOverride:SetTextColor(0.75, 0.1, 0.1)
    Refresh_stoploop = true
    subzdrop:SetMenu(subzdrop_menu)
    Refresh_stoploop = nil
    subzdrop:Disable()
  end

  local instype, heroicD, twentyfive, heroicR = Overachiever.GetDifficulty()

  -- Suggestions based on an open tradeskill window or whether a fishing pole is equipped:
  TradeskillSuggestions = GetTradeSkillLine()
  local tradeskill = LBIR[TradeskillSuggestions]
  if (not ACHID_TRADESKILL[tradeskill] and IsEquippedItemType("Fishing Poles")) then
    TradeskillSuggestions, tradeskill = LBI["Fishing"], "Fishing"
  end
  if (ACHID_TRADESKILL[tradeskill]) then
    Refresh_Add(ACHID_TRADESKILL[tradeskill])
    if (ACHID_TRADESKILL_ZONE[tradeskill]) then
      Refresh_Add(ACHID_TRADESKILL_ZONE[tradeskill][zone])
    end
    if (instype == "pvp") then  -- If in a battleground:
      Refresh_Add(ACHID_TRADESKILL_BG[tradeskill])
    end
  else
    TradeskillSuggestions = nil

  -- Suggestions for your location:
    if (instype) then  -- If in an instance:
      Refresh_Add(ACHID_INSTANCES[zone])
      if (instype == "pvp") then  -- If in a battleground:
        Refresh_Add(ACHID_BATTLEGROUNDS)
      end

      if (heroicD or heroicR) then
        if (twentyfive) then
          Refresh_Add(ACHID_INSTANCES_HEROIC[zone], ACHID_INSTANCES_25[zone], ACHID_INSTANCES_25_HEROIC[zone])
        else
          Refresh_Add(ACHID_INSTANCES_HEROIC[zone], ACHID_INSTANCES_10[zone], ACHID_INSTANCES_10_HEROIC[zone])
        end
      else
        if (twentyfive) then
          Refresh_Add(ACHID_INSTANCES_NORMAL[zone], ACHID_INSTANCES_25[zone], ACHID_INSTANCES_25_NORMAL[zone])
        else
          Refresh_Add(ACHID_INSTANCES_NORMAL[zone], ACHID_INSTANCES_10[zone], ACHID_INSTANCES_10_NORMAL[zone])
        end
      end

    else
      Refresh_Add(Overachiever.ExploreZoneIDLookup(zone), ACHID_ZONE_NUMQUESTS[zone], ACHID_ZONE_MISC[zone])
      -- Also look for instance achievements for an instance you're near if we can look it up easily (since many zones
      -- have subzones with the instance name when you're near the instance entrance and some instance entrances are
      -- actually in their own "zone" using the instance's zone name):
      Refresh_Add(ACHID_INSTANCES[CurrentSubzone] or ACHID_INSTANCES[zone])

      local ach10, ach25 = ACHID_INSTANCES_10[CurrentSubzone] or ACHID_INSTANCES_10[zone], ACHID_INSTANCES_25[CurrentSubzone] or ACHID_INSTANCES_25[zone]
      local achH10, achH25 = ACHID_INSTANCES_10_HEROIC[CurrentSubzone] or ACHID_INSTANCES_10_HEROIC[zone], ACHID_INSTANCES_25_HEROIC[CurrentSubzone] or ACHID_INSTANCES_25_HEROIC[zone]
      local achN10, achN25 = ACHID_INSTANCES_10_NORMAL[CurrentSubzone] or ACHID_INSTANCES_10_NORMAL[zone], ACHID_INSTANCES_25_NORMAL[CurrentSubzone] or ACHID_INSTANCES_25_NORMAL[zone]

      if (ach10 or ach25 or achH10 or achH25 or achN10 or achN25) then
      -- If there are 10-man or 25-man specific achievements, this is a raid:
        if (heroicR) then
          if (twentyfive) then
            Refresh_Add(ACHID_INSTANCES_HEROIC[CurrentSubzone] or ACHID_INSTANCES_HEROIC[zone], ach25, achH25)
          else
            Refresh_Add(ACHID_INSTANCES_HEROIC[CurrentSubzone] or ACHID_INSTANCES_HEROIC[zone], ach10, achH10)
          end
        else
          if (twentyfive) then
            Refresh_Add(ACHID_INSTANCES_NORMAL[CurrentSubzone] or ACHID_INSTANCES_NORMAL[zone], ach25, achN25)
          else
            Refresh_Add(ACHID_INSTANCES_NORMAL[CurrentSubzone] or ACHID_INSTANCES_NORMAL[zone], ach10, achN10)
          end
        end
      -- Not a raid:
      elseif (heroicD) then
        Refresh_Add(ACHID_INSTANCES_HEROIC[CurrentSubzone] or ACHID_INSTANCES_HEROIC[zone])
      else
        Refresh_Add(ACHID_INSTANCES_NORMAL[CurrentSubzone] or ACHID_INSTANCES_NORMAL[zone])
      end
    end

    -- Suggestions from recent reminders:
    Overachiever.RecentReminders_Check()
    for id in pairs(RecentReminders) do
      suggested[id] = true
    end
  end

  local list, count = frame.AchList, 0
  wipe(list)
  local critlist = frame.AchList_criteria and wipe(frame.AchList_criteria)
  if (not critlist) then
    critlist = {}
    frame.AchList_criteria = critlist
  end
  for id,v in pairs(suggested) do
    count = count + 1
    list[count] = id
    if (v ~= true) then
      critlist[id] = v
    end
  end

  Overachiever_SuggestionsFrameContainerScrollBar:SetValue(0)
  frame:ForceUpdate(true)
end

function frame.SetNumListed(num)
  if (num > 0) then
    NoSuggestionsLabel:Hide()
    if (TradeskillSuggestions) then
      ResultsLabel:SetText(L.SUGGESTIONS_RESULTS_TRADESKILL:format(TradeskillSuggestions, num))
    else
      ResultsLabel:SetText(L.SUGGESTIONS_RESULTS:format(num))
    end
  else
    NoSuggestionsLabel:Show()
    if (TradeskillSuggestions) then
      NoSuggestionsLabel:SetText(L.SUGGESTIONS_EMPTY_TRADESKILL:format(TradeskillSuggestions))
    else
      NoSuggestionsLabel:SetText(L.SUGGESTIONS_EMPTY)
    end
    ResultsLabel:SetText(" ")
  end
end

RefreshBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
RefreshBtn:SetWidth(75); RefreshBtn:SetHeight(21)
--RefreshBtn:SetPoint("TOPLEFT", sortdrop, "BOTTOMLEFT", 16, -14)
RefreshBtn:SetText(L.SUGGESTIONS_REFRESH)
RefreshBtn:SetScript("OnClick", Refresh)

ResultsLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ResultsLabel:SetPoint("TOPLEFT", RefreshBtn, "BOTTOMLEFT", 0, -8)
ResultsLabel:SetWidth(178)
ResultsLabel:SetJustifyH("LEFT")
ResultsLabel:SetText(" ")

panel:SetScript("OnShow", Refresh)

NoSuggestionsLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
NoSuggestionsLabel:SetPoint("TOP", frame, "TOP", 0, -189)
NoSuggestionsLabel:SetText(L.SUGGESTIONS_EMPTY)
NoSuggestionsLabel:SetWidth(490)

frame:RegisterEvent("TRADE_SKILL_SHOW")
frame:RegisterEvent("TRADE_SKILL_CLOSE")
frame:SetScript("OnEvent", Refresh)


-- SUPPORT FOR OTHER ADDONS
----------------------------------------------------

-- Open suggestions tables up for other addons to read or manipulate:
Overachiever.SUGGESTIONS = {
	zone_numquests = ACHID_ZONE_NUMQUESTS,
	zone = ACHID_ZONE_MISC,
	instance = ACHID_INSTANCES,
	bg = ACHID_BATTLEGROUNDS,
	instance_normal = ACHID_INSTANCES_NORMAL,
	instance_heroic = ACHID_INSTANCES_HEROIC,
	instance_10 = ACHID_INSTANCES_10,
	instance_25 = ACHID_INSTANCES_25,
	instance_10_normal = ACHID_INSTANCES_10_NORMAL,
	instance_10_heroic = ACHID_INSTANCES_10_HEROIC,
	instance_25_normal = ACHID_INSTANCES_25_NORMAL,
	instance_25_heroic = ACHID_INSTANCES_25_HEROIC,
	tradeskill = ACHID_TRADESKILL,
	tradeskill_zone = ACHID_TRADESKILL_ZONE,
	tradeskill_bg = ACHID_TRADESKILL_BG,
}



-- ZONE/INSTANCE OVERRIDE INPUT
----------------------------------------------------

EditZoneOverride = CreateFrame("EditBox", "Overachiever_SuggestionsFrameZoneOverrideEdit", panel, "InputBoxTemplate")
EditZoneOverride:SetWidth(170); EditZoneOverride:SetHeight(16)
EditZoneOverride:SetAutoFocus(false)
EditZoneOverride:SetPoint("TOPLEFT", sortdrop, "BOTTOMLEFT", 22, -19)
do
  local label = EditZoneOverride:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  label:SetPoint("BOTTOMLEFT", EditZoneOverride, "TOPLEFT", -6, 4)
  label:SetText(L.SUGGESTIONS_LOCATION)

  -- CREATE LIST OF VALID LOCATIONS:
  -- Add all zones to the list:
  local zonetab = {}
  for i=1,select("#",GetMapContinents()) do  zonetab[i] = { GetMapZones(i) };  end
  for i,tab in ipairs(zonetab) do
    for n,z in ipairs(tab) do  suggested[z] = true;  end  -- Already localized so no need for LBZ here.
  end
  zonetab = nil
  -- Add instances for which we have suggestions:
  local function addtolist(list, ...)
    local tab
    for i=1,select("#", ...) do
      tab = select(i, ...)
      for k,v in pairs(tab) do  list[ LBZ[k] or k ] = true;  end  -- Add localized version of instance names.
    end
  end
  addtolist(suggested, ACHID_INSTANCES, ACHID_INSTANCES_10, ACHID_INSTANCES_25, ACHID_INSTANCES_10_NORMAL,
            ACHID_INSTANCES_25_NORMAL, ACHID_INSTANCES_10_HEROIC, ACHID_INSTANCES_25_HEROIC)
  addtolist = nil
  -- Arrange into alphabetically-sorted array:
  local count = 0
  for k in pairs(suggested) do
    count = count + 1
    LocationsList[count] = k
  end
  wipe(suggested)
  sort(LocationsList)
  -- Cross-reference by lowercase key to place in the array:
  for i,v in ipairs(LocationsList) do  LocationsList[strlower(v)] = i;  end
end

EditZoneOverride:SetScript("OnEnterPressed", Refresh)

local function findFirstLocation(text)
  if (strtrim(text) == "") then  return;  end
  local len = strlen(text)
  for i,v in ipairs(LocationsList) do
    if (strsub(strlower(v), 1, len) == text) then  return i, v, len, text;  end
  end
end

EditZoneOverride:SetScript("OnEditFocusGained", function(self)
  self:SetTextColor(1, 1, 1)
  self:HighlightText()
  CloseMenus()
end)

EditZoneOverride:SetScript("OnChar", function(self)
  local i, v, len = findFirstLocation(strlower(self:GetText()))
  if (i) then
    self:SetText(v)
    self:HighlightText(len, strlen(v))
    self:SetCursorPosition(len)
  end
end)

EditZoneOverride:SetScript("OnTabPressed", function(self)
  local text = strlower(self:GetText())
  local text2, len
  if (text == "") then
    text2 = LocationsList[IsShiftKeyDown() and #LocationsList or 1]
    len = 0
  elseif (not LocationsList[text]) then
    len = self:GetUTF8CursorPosition()
    if (len == 0) then
      text2 = LocationsList[IsShiftKeyDown() and #LocationsList or 1]
    else
      text = strsub(text, 1, len)
      if (IsShiftKeyDown()) then
        for i = #LocationsList, 1, -1 do
          if (strsub(strlower(LocationsList[i]), 1, len) == text) then
            text2 = LocationsList[i]
            break;
          end
        end
      else
        local i
        i, text2, len = findFirstLocation(text)
      end
    end
  else
    local i, v
    i, v, len, text = findFirstLocation(text)
    if (i) then
      local pos = self:GetUTF8CursorPosition()
      text = strsub(text, 1, pos)
      len = strlen(text)
      local mod = IsShiftKeyDown() and -1 or 1
      repeat
        i = i + mod
        text2 = LocationsList[i]
        if (not text2) then  i = (mod == 1 and 0) or #LocationsList + 1;  end
      until (text2 and strsub(strlower(text2), 1, pos) == text)
    end
  end
  if (text2) then
    self:SetText(text2)
    self:HighlightText(len, strlen(text2))
    self:SetCursorPosition(len)
  end
end)

EditZoneOverride:SetScript("OnEnter", function(self)
  GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
  GameTooltip:AddLine(L.SUGGESTIONS_LOCATION_TIP, 1, 1, 1)
  GameTooltip:AddLine(L.SUGGESTIONS_LOCATION_TIP2, nil, nil, nil, 1)
  GameTooltip:Show()
end)

EditZoneOverride:SetScript("OnLeave", function(self)
  GameTooltip:Hide()
end)


subzdrop_menu = {  {  text = L.SUGGESTIONS_LOCATION_NOSUBZONE, value = 0  };  }
subzdrop = TjDropDownMenu.CreateDropDown("Overachiever_SuggestionsFrameSubzoneDrop", panel, subzdrop_menu)
subzdrop:SetLabel(L.SUGGESTIONS_LOCATION_SUBZONE, true)
subzdrop:SetPoint("LEFT", sortdrop, "LEFT")
subzdrop:SetPoint("TOP", EditZoneOverride, "BOTTOM", 0, -21)
subzdrop:SetDropDownWidth(158)
subzdrop:OnSelect(Refresh)

do
  local menu

  local function addtosubzlist(list, key, ...)
    local tab
    for i=1,select("#", ...) do
      tab = select(i, ...)
      tab = tab[key]
      tab = type(tab) == "table" and tab.SUBZONES
      if (tab) then
        for k in pairs(tab) do
          if (strsub(k, 1, 1) == "*") then
            for subz in gmatch(k, "%*([^%*]+)%*") do  list[ L.SUBZONES[subz] or subz ] = true;  end
          else
            list[ L.SUBZONES[k] or k ] = true
          end
        end
      end
    end
  end

  function subzdrop_Update(zone)
    menu = menu or {}
    if (menu[zone] == nil) then
      local tab = {}
      addtosubzlist(suggested, zone, ACHID_ZONE_MISC, ACHID_INSTANCES, ACHID_INSTANCES_10, ACHID_INSTANCES_25,
                ACHID_INSTANCES_10_NORMAL, ACHID_INSTANCES_25_NORMAL, ACHID_INSTANCES_10_HEROIC, ACHID_INSTANCES_25_HEROIC)
      -- Arrange into alphabetically-sorted array:
      local count = 0
      for k in pairs(suggested) do
        count = count + 1
        tab[count] = k
      end
      wipe(suggested)
      if (count > 0) then
        sort(tab)  -- Sort alphabetically.
        -- Turn into dropdown menu format:
        for i,name in ipairs(tab) do  tab[i] = {  text = name, value = name  };  end
        tinsert(tab, 1, {  text = L.SUGGESTIONS_LOCATION_NOSUBZONE, value = 0  })
        menu[zone] = tab
        subzdrop:SetMenu(tab)
        subzdrop:SetSelectedValue(0)
        subzdrop:Enable()
        return;
      else
        menu[zone] = false
      end
    end
    if (menu[zone]) then
      subzdrop:SetMenu(menu[zone])
      subzdrop:Enable()
    else
      subzdrop:SetMenu(subzdrop_menu)
      subzdrop:Disable()
    end
  end
end

local orig_subzdropBtn_OnClick = Overachiever_SuggestionsFrameSubzoneDropButton:GetScript("OnClick")
Overachiever_SuggestionsFrameSubzoneDropButton:SetScript("OnClick", function(...)
  Refresh()
  if (subzdrop:IsEnabled()) then  orig_subzdropBtn_OnClick(...);  end
end)


RefreshBtn:SetPoint("TOPLEFT", subzdrop, "BOTTOMLEFT", 16, -14)

ResetBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
ResetBtn:SetWidth(75); ResetBtn:SetHeight(21)
ResetBtn:SetPoint("LEFT", RefreshBtn, "RIGHT", 4, 0)
ResetBtn:SetText(L.SEARCH_RESET)
ResetBtn:SetScript("OnClick", function(self)
  PlaySound("igMainMenuOptionCheckBoxOff")
  EditZoneOverride:SetText("")
  Refresh()
end)



-- MISCELLANEOUS
----------------------------------------------------

--[[
local function grabFromCategory(cat, ...)
  wipe(suggested)
  -- Get achievements in the category except those with a previous one in the chain that are also in the category:
  local id, prev, p2
  for i = 1, GetCategoryNumAchievements(cat) do
    id = GetAchievementInfo(cat, i)
    prev, p2 = nil, GetPreviousAchievement(id)
    while (p2 and GetAchievementCategory(p2) == cat) do
      prev = p2
      p2 = GetPreviousAchievement(id)
    end
    suggested[ (prev or id) ] = true
  end
  -- Add achievements specified by function call (useful for meta-achievements in a different category):
  for i=1, select("#", ...) do
    id = select(i, ...)
    suggested[id] = true
  end
  -- Fold achievements into their meta-achievements on the list:
  local tab, _, critType, assetID = {}
  for id in pairs(suggested) do
    for i=1,GetAchievementNumCriteria(id) do
      _, critType, _, _, _, _, _, assetID = GetAchievementCriteriaInfo(id, i)
      if (critType == 8 and suggested[assetID]) then
        tab[assetID] = true -- Not removed immediately in case there are meta-achievements within meta-achievements
      end
    end
  end
  for assetID in pairs(tab) do  suggested[assetID] = nil;  end
  -- Format list:
  local count = 0
  wipe(tab)
  for id in pairs(suggested) do
    count = count + 1
    tab[count] = id
  end
  return tab
end
--]]

-- ULDUAR 10: Results from grabFromCategory(14961, 2957):
--	{ 2894, 2903, 2905, 2907, 2909, 2911, 2913, 2919, 2925, 2927, 2931, 2933, 2934, 2937, 2939, 2940, 2945, 2947, 2951, 2955, 2957, 2959, 2961, 2963, 2967, 2969, 2971, 2973, 2975, 2977, 2979, 2980, 2982, 2985, 2989, 2996, 3003, 3004, 3008, 3009, 3012, 3014, 3015, 3036, 3076, 3097, 3138, 3157, 3177, 3316 }
-- ULDUAR 25: Results from grabFromCategory(14962, 2958):
--	{ 2895, 2904, 2906, 2908, 2910, 2912, 2918, 2921, 2926, 2928, 2932, 2935, 2936, 2938, 2942, 2943, 2946, 2948, 2952, 2956, 2958, 2960, 2962, 2965, 2968, 2970, 2972, 2974, 2976, 2978, 2981, 2983, 2984, 2995, 2997, 3002, 3005, 3010, 3011, 3013, 3016, 3017, 3037, 3077, 3098, 3118, 3161, 3185, 3237 }

--[[
-- /run Overachiever.Debug_GetIDsInCat( GetAchievementCategory(GetTrackedAchievements()) )
function Overachiever.Debug_GetIDsInCat(cat)
  local tab = Overachiever_Settings.Debug_AchIDsInCat
  if (not tab) then  Overachiever_Settings.Debug_AchIDsInCat = {};  tab = Overachiever_Settings.Debug_AchIDsInCat;  end
  local catname = GetCategoryInfo(cat)
  tab[catname] = {}
  tab = tab[catname]
  local id, n
  for i=1,GetCategoryNumAchievements(cat) do
    id, n = GetAchievementInfo(cat, i)
    tab[n] = id
  end
end
--]]

--[[
-- /run Overachiever.Debug_GetMissingAch()
local function getAchIDsFromTab(from, to)
  for k,v in pairs(from) do
    if (type(v) == "table") then
      getAchIDsFromTab(v, to)
    else
      if (type(v) == "string") then
        local id, crit = strsplit(":", v)
        id, crit = tonumber(id) or id, tonumber(crit) or crit
        to[id] = to[id] or {}
        to[id][crit] = true
      else
        to[v] = to[v] or false
      end
    end
  end
end

function Overachiever.Debug_GetMissingAch()
  wipe(suggested)
  getAchIDsFromTab(Overachiever.SUGGESTIONS, suggested)
  getAchIDsFromTab(OVERACHIEVER_ACHID, suggested)
  getAchIDsFromTab(OVERACHIEVER_EXPLOREZONEID, suggested)
  local count = 0
  for id, crit in pairs(suggested) do
    if (type(id) ~= "number") then
      print("Invalid ID type:",id,type(id))
      count = count + 1
    elseif (GetAchievementInfo(id)) then
      if (crit) then
        local num = GetAchievementNumCriteria(id)
        for c in pairs(crit) do
          if (c > num) then
            print(GetAchievementLink(id),"is missing criteria #"..(tostring(c) or "<?>"))
            count = count + 1
          end
        end
      end
    else
      print("Missing ID:",id..(crit and " (with criteria)" or ""))
      count = count + 1
    end
  end
  print("Overachiever.Debug_GetMissingAch():",count,"problems found.")
end
--]]
