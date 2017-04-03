
OVERACHIEVER_ACHID = {
	WorldExplorer = 46,		-- "World Explorer"
	LoveCritters = 1206,		-- "To All The Squirrels I've Loved Before"
	LoveCritters2 = 2557,		-- "To All The Squirrels Who Shared My Life"
	PestControl = 2556,		-- "Pest Control"
	WellRead = 1244,		-- "Well Read"
	HigherLearning = 1956,		-- "Higher Learning"
	Scavenger = 1257,		-- "The Scavenger"
	OutlandAngler = 1225,		-- "Outland Angler"
	NorthrendAngler = 1517,		-- "Northrend Angler"
	TastesLikeChicken = 1832,	-- "Takes Like Chicken"
	HappyHour = 1833,		-- "It's Happy Hour Somewhere"

	GourmetNorthrend = 1779,	-- "The Northrend Gourmet" (last part)
	GourmetOutland = 1800,		-- "The Outland Gourmet"
	--GourmetWinter = 1688,		-- "The Winter Veil Gourmet"

	MediumRare = 1311,		-- "Medium Rare"
	BloodyRare = 1312,		-- "Bloody Rare"
	NorthernExposure = 2256,	-- "Northern Exposure"
	Frostbitten = 2257,		-- "Frostbitten"

	LetItSnow = 1687,		-- "Let It Snow"
	FistfulOfLove = 1699,		-- "Fistful of Love"
	BunnyMaker = 2422,		-- "Shake Your Bunny-Maker"
	CheckYourHead = 291,		-- "Check Your Head"
	TurkeyLurkey = 3559,		-- "Turkey Lurkey"

	-- Statistics:
	Stat_ConsumeDrinks = 346,	-- "Beverages consumed"
	Stat_ConsumeFood = 347,		-- "Food eaten"
};


-- Look up the achievement ID of the given zone's exploration achievement, whatever the localization.
-- Using zone names alone isn't reliable because the achievement names don't always use the zone's name as given by
-- functions like GetRealZoneText() with some localizations.

local LBZ = LibStub("LibBabble-Zone-3.0");
LBZ = LBZ:GetReverseLookupTable()

OVERACHIEVER_EXPLOREZONEID = {
-- Kalimdor:
	["Azuremyst Isle"] = 860,
	["Moonglade"] = 855,
	["Thousand Needles"] = 846,
	["Winterspring"] = 857,
	["Ashenvale"] = 845,
	["Teldrassil"] = 842,
	["Tanaris"] = 851,
	["Mulgore"] = 736,
	["Dustwallow Marsh"] = 850,
	["Felwood"] = 853,
	["Darkshore"] = 844,
	["Desolace"] = 848,
	["Durotar"] = 728,
	["Feralas"] = 849,
	["The Barrens"] = 750,
	["Bloodmyst Isle"] = 861,
	["Un'Goro Crater"] = 854,
	["Azshara"] = 852,
	["Stonetalon Mountains"] = 847,
	["Silithus"] = 856,
-- Eastern Kingdoms:
	["The Hinterlands"] = 773,
	["Stranglethorn Vale"] = 781,
	["Eastern Plaguelands"] = 771,
	["Duskwood"] = 778,
	["Ghostlands"] = 858,
	["Redridge Mountains"] = 780,
	["Arathi Highlands"] = 761,
	["Eversong Woods"] = 859,
	["Westfall"] = 802,
	["Badlands"] = 765,
	["Searing Gorge"] = 774,
	["Loch Modan"] = 779,
	["Burning Steppes"] = 775,
	["Wetlands"] = 841,
	["Tirisfal Glades"] = 768,
	["Isle of Quel'Danas"] = 868,
	["Silverpine Forest"] = 769,
	["Dun Morogh"] = 627,
	["Deadwind Pass"] = 777,
	["Western Plaguelands"] = 770,
	["Elwynn Forest"] = 776,
	["Blasted Lands"] = 766,
	["Swamp of Sorrows"] = 782,
	["Hillsbrad Foothills"] = 772,
	["Alterac Mountains"] = 760,
-- Outland:
	["Blade's Edge Mountains"] = 865,
	["Zangarmarsh"] = 863,
	["Netherstorm"] = 843,
	["Hellfire Peninsula"] = 862,
	["Terokkar Forest"] = 867,
	["Shadowmoon Valley"] = 864,
	["Nagrand"] = 866,
-- Northrend:
	["Icecrown"] = 1270,
	["Crystalsong Forest"] = 1457,
	["Dragonblight"] = 1265,
	["Howling Fjord"] = 1263,
	["Borean Tundra"] = 1264,
	["Sholazar Basin"] = 1268,
	["Zul'Drak"] = 1267,
	["Grizzly Hills"] = 1266,
	["The Storm Peaks"] = 1269,
};

function Overachiever.ExploreZoneIDLookup(zoneName)
  local z = LBZ[zoneName] or zoneName
  return OVERACHIEVER_EXPLOREZONEID[z];
end


OVERACHIEVER_CATEGORY_HEROIC = {
	[14921] = true, -- Lich King Dungeon
	[14923] = true, -- Lich King 25-Player Raid
};

OVERACHIEVER_CATEGORY_25 = {
	[14923] = true,			-- Lich King 25-Player Raid
	[14962] = true,			-- Secrets of Ulduar 25-Player Raid
	[15002] = true,			-- Call of the Crusade 25-Player Raid
	[15042] = true,			-- Fall of the Lich King 25-Player Raid
};

OVERACHIEVER_HEROIC_CRITERIA = {
	[1658] =			-- "Champions of the Frozen Wastes"
		{ [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true,
		  [13] = true, [14] = true, [15] = true },
};

