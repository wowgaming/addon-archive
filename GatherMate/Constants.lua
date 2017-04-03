--[[
	Below are constants needed for DB storage and retrieval
	The core of gathermate handles adding new node that collector finds
	data shared between Collector and Display also live in GatherMate for sharing like zone_data for sizes, and node ids with reverses for display and comparison
	Credit to Astrolabe (http://www.gathereraddon.com) for lookup tables used in GatherMate. Astrolabe is licensed LGPL
]]
local GatherMate = LibStub("AceAddon-3.0"):GetAddon("GatherMate")
local NL = LibStub("AceLocale-3.0"):GetLocale("GatherMateNodes",true)
local L = LibStub("AceLocale-3.0"):GetLocale("GatherMate")

--[[
	Zone data for heigth, width, and gathermate ID
]]
local zone_data = { -- {width, height, zoneID}
	Arathi = {3599.78645678886,2399.85763785924,1,},
	Ogrimmar = {1402.563051365538,935.042034243692,2,},
	EasternKingdoms = {37649.15159852673,25099.43439901782,3,},
	Undercity = {959.3140238076666,639.5426825384444,4,},
	Barrens = { 10133.3330078125, 6756.24987792969, 5},
	Darnassis = {1058.300884213672,705.5339228091146,6,},
	AzuremystIsle = {4070.691916244019, 2713.794610829346,7,},
	UngoroCrater = {3699.872808671186,2466.581872447457,8,},
	BurningSteppes = { 2929.16659545898, 1952.08349609375, 9},
	Wetlands = {4135.166184805389,2756.777456536926,10,},
	Winterspring = {7099.756078049357,4733.170718699571,11,},
	Dustwallow = { 5250.00006103516, 3499.99975585938, 12},
	Darkshore = {6549.780280774227,4366.520187182819,13,},
	LochModan = {2758.158752877019,1838.772501918013,14,},
	BladesEdgeMountains = {5424.84803598309,3616.56535732206,15,},
	Durotar = {5287.285801274457,3524.857200849638,16,},
	Silithus = {3483.224287356748,2322.149524904499,17,},
	ShattrathCity = {1306.210386847456,870.8069245649707,18,},
	Ashenvale = {5766.471113365881,3844.314075577254,19,},
	Azeroth = { 40741.181640625, 27149.6875, 20},
	Nagrand = { 5525.0, 3683.33316802979, 21},
	TerokkarForest = {5399.832305361811,3599.888203574541,22,},
	EversongWoods = { 4925.0, 3283.3330078125, 23},
	SilvermoonCity = {1211.384457945605,807.5896386304033,24,},
	Tanaris = {6899.765399158026,4599.843599438685,25,},
	Stormwind = { 1737.499958992, 1158.3330078125, 26},
	SwampOfSorrows = {2293.606089974149,1529.070726649433,27,},
	EasternPlaguelands = { 4031.25, 2687.49987792969, 28}, -- post wrath size
--	EasternPlaguelands = {2687.49987792969,4031.25,28,},
	BlastedLands = {3349.808966078055,2233.20597738537,29,},
	Elwynn = {3470.62593362794,2313.750622418627,30,},
	DeadwindPass = {2499.848163715574,1666.565442477049,31,},
	DunMorogh = {4924.664537147015,3283.109691431343,32,},
	TheExodar = {1056.732317707213,704.4882118048087,33,},
	Felwood = {5749.8046476606,3833.2030984404,34,},
	Silverpine = {4199.739879721531,2799.826586481021,35,},
	ThunderBluff = {1043.762849319158,695.8418995461053,36,},
	Hinterlands = { 3850.0, 2566.66662597656, 37},
	StonetalonMountains = {4883.173287670144,3255.448858446763,38,},
	Mulgore = {5137.32138887616,3424.88092591744,39,},
	Hellfire = {5164.421615455519,3442.947743637013,40,},
	Ironforge = {790.5745810546713,527.0497207031142,41,},
	ThousandNeedles = {4399.86408093722,2933.242720624814,42,},
	Stranglethorn = { 6381.24975585938, 4254.166015625, 43},
	Badlands = {2487.343589680943,1658.229059787295,44,},
	Teldrassil = {5091.467863261982,3394.311908841321,45,},
	Moonglade = {2308.253559286662,1538.835706191108,46,},
	ShadowmoonValley = { 5500.0, 3666.66638183594, 47},
	Tirisfal = {4518.469744413802,3012.313162942535,48,},
	Aszhara = {5070.669448432522,3380.446298955014,49,},
	Redridge = {2170.704876735185,1447.136584490123,50,},
	BloodmystIsle = {3262.385067990556,2174.92337866037,51,},
	WesternPlaguelands = {4299.7374000546,2866.4916000364,52,},
	Alterac = {2799.820894040741,1866.547262693827,53,},
	Westfall = {3499.786489780177,2333.190993186784,54,},
	Duskwood = {2699.837284973949,1799.891523315966,55,},
	Netherstorm = {5574.82788866266,3716.551925775107,56,},
	Ghostlands = {3299.755735439147,2199.837156959431,57,},
	Zangarmarsh = { 5027.08349609375, 3352.08325195312, 58},
	Desolace = {4495.726850591814,2997.151233727876,59,},
	Kalimdor = { 36799.810546875, 24533.2001953125, 60},
	SearingGorge = {2231.119799153945,1487.413199435963,61,},
	Expansion01 = { 17464.078125, 11642.71875, 62},
	Feralas = {6949.760203962193,4633.173469308129,63,},
	Hilsbrad = {3199.802496078764,2133.201664052509,64,},
	Sunwell = {3327.0830078125,2218.7490234375,65,},
	-- Wrath Zones
	Northrend = {17751.3984375,11834.2650146484,66,},
	BoreanTundra = {5764.5830088,3843.749878,67,},
	Dragonblight = {5608.33312988281,3739.58337402344,68,},
	GrizzlyHills = {5249.999878,3499.999878,69,},
	HowlingFjord = {6045.83288574219,4031.24981689453,70,},
	IcecrownGlacier = {6270.83331298828, 4181.25,71,},
	SholazarBasin = {4356.25,2904.166504,72,},
	TheStormPeaks = {7112.49963378906,4741.666015625,73,},
	ZulDrak = {4993.75,3329.166504,74,},
--	LakeWintergrasp = {2974.99987792969,1983.33325195312,75,}, defined twice, removing old ref
	ScarletEnclave = {3162.5,2108.333374,76,},
	CrystalsongForest = {2722.91662597656,1814.5830078125,77,},
	LakeWintergrasp = {2974.99987792969,1983.33325195312,78,},
	StrandoftheAncients = {1743.74993896484,1162.49993896484,79,},
	Dalaran = {667,768,80,},
-- instance maps
	Naxxramas = { 1856.24975585938, 1237.5, 81},
	Naxxramas1 = { 729.219970703125, 1093.830078125, 82},
	Naxxramas2 = { 729.219970703125, 1093.830078125, 83},
	Naxxramas3 = { 800.0, 1200.0, 84},
	Naxxramas4 = { 800.219970703125, 1200.330078125, 85},
	Naxxramas5 = { 1379.8798828125, 2069.80981445312, 86},
	Naxxramas6 = { 437.2900390625, 655.93994140625, 87},
	--AlteracValley = { 2824.99987792969, 4237.49987792969, 88},
	--WarsongGulch = { 764.583312988281, 1145.83331298828, 89},
	AzjolNerub = { 1072.91664505005, 714.583297729492, 90},
	AzjolNerub1 = { 501.983001708984, 752.973999023438, 91},
	AzjolNerub2 = { 195.315979003906, 292.973999023438, 92},
	AzjolNerub3 = { 245.0, 367.5, 93},
	Ulduar77 = { 3399.99981689453, 2266.66666412354, 94},
	Ulduar771 = { 613.466064453125, 920.196014404297, 95},
	DrakTharonKeep = { 627.083312988281, 418.75, 96},
	DrakTharonKeep1 = { 413.293991088867, 619.941009521484, 97},
	DrakTharonKeep2 = { 413.293991088867, 619.941009521484, 98},
	TheObsidianSanctum = { 1162.49991798401, 775.0, 99},
	HallsofLightning = { 3399.99993896484, 2266.66666412354, 100},
	HallsofLightning1 = { 377.489990234375, 566.235015869141, 101},
	HallsofLightning2 = { 472.160034179688, 708.237014770508, 102},
	VioletHold = { 383.333312988281, 256.25, 103},
	VioletHold1 = { 170.820068359375, 256.22900390625, 104},
	--NetherstormArena = { 1514.58337402344, 2270.83319091797, 105},
	CoTStratholme = { 1824.99993896484, 1216.66650390625, 106},
	CoTStratholme1 = { 750.199951171875, 1125.29998779297, 107},
	TheEyeofEternity = { 3399.99981689453, 2266.66666412354, 108},
	TheEyeofEternity1 = { 286.713012695312, 430.070068359375, 109},
	Nexus80 = { 2600.0, 1733.33322143555, 110},
	Nexus801 = { 343.138977050781, 514.706970214844, 111},
	Nexus802 = { 443.138977050781, 664.706970214844, 112},
	Nexus803 = { 343.138977050781, 514.706970214844, 113},
	Nexus804 = { 196.463989257812, 294.700988769531, 114},
	VaultofArchavon = { 2599.99987792969, 1733.33325195312, 115},
	VaultofArchavon1 = { 603.230728149414, 904.846008300781, 116},
	Ulduar = { 3287.49987792969, 2191.66662597656, 117},
	Ulduar1 = { 446.300048828125, 669.450988769531, 118},
	Ulduar2 = { 885.639892578125, 1328.46099853516, 119},
	Ulduar3 = { 607.0, 910.5, 120},
	Ulduar4 = { 1046.30004882812, 1569.4599609375, 121},
	Dalaran1 = { 553.33984375, 830.015014648438, 122},
	Dalaran2 = { 375.48974609375, 563.223999023438, 123},
	Gundrak = { 1143.74996948242, 762.499877929688, 124},
	Gundrak1 = { 603.35009765625, 905.033050537109, 125},
	TheNexus = { 0.0, 0.0, 126},
	TheNexus1 = { 734.1875, 1101.2809753418, 127},
	Ahnkahet = { 972.91667175293, 647.916610717773, 128},
	Ahnkahet1 = { 648.279022216797, 972.41796875, 129},
	--ArathiBasin = { 1756.24992370605, 1170.83325195312, 130},
	UtgardePinnacle = { 6549.99951171875, 4366.66650390625, 131},
	UtgardePinnacle1 = { 365.957015991211, 548.936019897461, 132},
	UtgardePinnacle2 = { 504.119003295898, 756.179943084717, 133},
	UtgardeKeep = { 0.0, 0.0, 134},
	UtgardeKeep1 = { 489.721500396729, 734.580993652344, 135},
	UtgardeKeep2 = { 320.720293045044, 481.081008911133, 136},
	UtgardeKeep3 = { 491.054512023926, 736.581008911133, 137},
	IsleofConquest = { 2650.0, 1766.66658401489, 138},
	TheArgentColiseum = { 2599.99996948242, 1733.33334350586, 139},
	TheArgentColiseum1 = { 246.657989501953, 369.986186981201, 140},
	TheArgentColiseum1 = { 246.657989501953, 369.986186981201, 141},
	TheArgentColiseum2 = { 493.330017089844, 739.996017456055, 142},
	HrothgarsLanding = { 3677.08312988281, 2452.083984375, 143},
}
-- meta table to return 0 for all unknown zones, instances, and what not
local emptyZoneTbl = {0,0,0}
setmetatable(zone_data, { __index = function(t, k) ChatFrame1:AddMessage("GatherMate is missing data for "..k); return emptyZoneTbl end })


-- empty continents include -1 for the universe, and 0 for eastern kingdoms (meta continents so to speak)
local emptyCont = {}
local continentList = setmetatable({ GetMapContinents() }, {__index = function() return emptyCont end})
local zoneList = setmetatable({}, { __index = function() return emptyZoneTbl end})
for continent in pairs(continentList) do
	local zones = { GetMapZones(continent) }
	continentList[continent] = zones
	for zone, name in pairs(zones) do
		SetMapZoom(continent, zone)
		local mapFile = GetMapInfo()
		zoneList[name] = zone_data[mapFile]
		if mapFile == "Elwynn" then continentList[continent][0] = "EasternKingdoms"
		elseif mapFile == "Mulgore" then continentList[continent][0] = "Kalimdor"
		elseif mapFile == "Hellfire" then continentList[continent][0] = "Expansion01"
		elseif mapFile == "ZulDrak" then continentList[continent][0] = "Northrend" end
	end
end
-- Special zones workaround, so that fishing in these zones work
local specialZones = {}
specialZones[L["The Frozen Sea"]] = true
specialZones[L["The North Sea"]] = true
zoneList[L["The Frozen Sea"]] = zone_data["Northrend"]
zoneList[L["The North Sea"]] = zone_data["Northrend"]

GatherMate.zoneData = zoneList
GatherMate.continentData = continentList
GatherMate.specialZones = specialZones
zone_data = nil

--[[
	Node Identifiers
]]
local node_ids = {
	["Fishing"] = {
		[NL["Floating Wreckage"]] 				= 101, -- treasure.tga
		[NL["Patch of Elemental Water"]] 		= 102, -- purewater.tga
		[NL["Floating Debris"]] 				= 103, -- debris.tga
		[NL["Oil Spill"]] 						= 104, -- oilspill.tga
		[NL["Firefin Snapper School"]] 			= 105, -- firefin.tga
		[NL["Greater Sagefish School"]] 		= 106, -- greatersagefish.tga
		[NL["Oily Blackmouth School"]] 			= 107, -- oilyblackmouth.tga
		[NL["Sagefish School"]] 				= 108, -- sagefish.tga
		[NL["School of Deviate Fish"]] 			= 109, -- firefin.tga
		[NL["Stonescale Eel Swarm"]] 			= 110, -- eel.tga
		--[NL["Muddy Churning Water"]] 			= 111, -- ZG only fishing node
		[NL["Highland Mixed School"]] 			= 112, -- fishhook.tga 
		[NL["Pure Water"]] 						= 113, -- purewater.tga           
		[NL["Bluefish School"]] 				= 114, -- bluefish,tga
		--[NL["Feltail School"]] 					= 115, -- feltail.tga
		[NL["Brackish Mixed School"]]         	= 115, -- feltail.tga
		[NL["Mudfish School"]] 					= 116, -- mudfish.tga
		[NL["School of Darter"]] 				= 117, -- darter.tga
		[NL["Sporefish School"]] 				= 118, -- sporefish.tga
		[NL["Steam Pump Flotsam"]] 				= 119, -- steampump.tga
		[NL["School of Tastyfish"]] 			= 120, -- net.tga
		[NL["Borean Man O' War School"]]        = 121,
		[NL["Deep Sea Monsterbelly School"]]	= 122,
		[NL["Dragonfin Angelfish School"]]		= 123,
		[NL["Fangtooth Herring School"]]		= 124,
		[NL["Floating Wreckage Pool"]]			= 125,
		[NL["Glacial Salmon School"]]			= 126,
		[NL["Glassfin Minnow School"]]			= 127,
		[NL["Imperial Manta Ray School"]]		= 128,
		[NL["Moonglow Cuttlefish School"]]		= 129,
		[NL["Musselback Sculpin School"]]		= 130,
		[NL["Nettlefish School"]]				= 131,
		[NL["Strange Pool"]]					= 132,
		[NL["Schooner Wreckage"]]				= 133,
		[NL["Waterlogged Wreckage"]]			= 134,
		[NL["Bloodsail Wreckage"]]				= 135,
		-- Begin tediuous prefix mapping	
		[NL["Lesser Sagefish School"]]			= 136, -- sagefish.tga
		[NL["Lesser Oily Blackmouth School"]] 	= 137, -- oilyblackmouth.tga
		[NL["Sparse Oily Blackmouth School"]] 	= 138, -- oilyblackmouth.tga
		[NL["Abundant Oily Blackmouth School"]]	= 139, -- oilyblackmouth.tga
		[NL["Teeming Oily Blackmouth School"]]	= 140, -- oilyblackmouth.tga
		[NL["Lesser Firefin Snapper School"]] 	= 141, -- firefin.tga
		[NL["Sparse Firefin Snapper School"]] 	= 142, -- firefin.tga
		[NL["Abundant Firefin Snapper School"]]	= 143, -- firefin.tga
		[NL["Teeming Firefin Snapper School"]] 	= 144, -- firefin.tga
		[NL["Lesser Floating Debris"]] 			= 145, -- debris.tga
		[NL["Sparse Schooner Wreckage"]]		= 146,
		[NL["Abundant Bloodsail Wreckage"]]		= 147,
		[NL["Teeming Floating Wreckage"]]		= 148,	
	},
	["Mining"] = {
		[NL["Copper Vein"]] 					= 201,
		[NL["Tin Vein"]] 						= 202,
		[NL["Iron Deposit"]] 					= 203,
		[NL["Silver Vein"]] 					= 204,
		[NL["Gold Vein"]] 						= 205,
		[NL["Mithril Deposit"]] 				= 206,
		[NL["Ooze Covered Mithril Deposit"]]	= 207,
		[NL["Truesilver Deposit"]] 				= 208,
		[NL["Ooze Covered Silver Vein"]] 		= 209,
		[NL["Ooze Covered Gold Vein"]] 			= 210,
		[NL["Ooze Covered Truesilver Deposit"]] = 211,
		[NL["Ooze Covered Rich Thorium Vein"]] 	= 212,
		[NL["Ooze Covered Thorium Vein"]] 		= 213,
		[NL["Small Thorium Vein"]] 				= 214,
		[NL["Rich Thorium Vein"]] 				= 215,
		--[NL["Hakkari Thorium Vein"]] 			= 216, -- found on in ZG
		[NL["Dark Iron Deposit"]] 				= 217,
		[NL["Lesser Bloodstone Deposit"]] 		= 218,
		[NL["Incendicite Mineral Vein"]] 		= 219,
		[NL["Indurium Mineral Vein"]]			= 220,
		[NL["Fel Iron Deposit"]] 				= 221,
		[NL["Adamantite Deposit"]] 				= 222,
		[NL["Rich Adamantite Deposit"]] 		= 223,
		[NL["Khorium Vein"]] 					= 224,
		--[NL["Large Obsidian Chunk"]] 			= 225, -- found only in AQ20/40
		--[NL["Small Obsidian Chunk"]] 			= 226, -- found only in AQ20/40
		[NL["Nethercite Deposit"]] 				= 227,
		[NL["Cobalt Deposit"]]					= 228,
		[NL["Rich Cobalt Deposit"]]				= 229,
		[NL["Titanium Vein"]]					= 230,
		[NL["Saronite Deposit"]]				= 231,
		[NL["Rich Saronite Deposit"]]			= 232,
	},
	["Extract Gas"] = {
		[NL["Windy Cloud"]] 					= 301,
		[NL["Swamp Gas"]] 						= 302,
		[NL["Arcane Vortex"]] 					= 303,
		[NL["Felmist"]] 						= 304,
		[NL["Steam Cloud"]]					    = 305,
		[NL["Cinder Cloud"]]					= 306,
		[NL["Arctic Cloud"]]					= 307,
	},
	["Herb Gathering"] = {
		[NL["Peacebloom"]] 						= 401,
		[NL["Silverleaf"]] 						= 402,
		[NL["Earthroot"]] 						= 403,
		[NL["Mageroyal"]] 						= 404,
		[NL["Briarthorn"]] 						= 405,
		--[NL["Swiftthistle"]] 					= 406, -- found it briathorn nodes
		[NL["Stranglekelp"]] 					= 407,
		[NL["Bruiseweed"]] 						= 408,
		[NL["Wild Steelbloom"]] 				= 409,
		[NL["Grave Moss"]] 						= 410,
		[NL["Kingsblood"]] 						= 411,
		[NL["Liferoot"]] 						= 412,
		[NL["Fadeleaf"]] 						= 413,
		[NL["Goldthorn"]] 						= 414,
		[NL["Khadgar's Whisker"]] 				= 415,
		[NL["Wintersbite"]] 					= 416,
		[NL["Firebloom"]] 						= 417,
		[NL["Purple Lotus"]] 					= 418,
		--[NL["Wildvine"]] 						= 419, -- found in purple lotus nodes
		[NL["Arthas' Tears"]] 					= 420,
		[NL["Sungrass"]] 						= 421,
		[NL["Blindweed"]] 						= 422,
		[NL["Ghost Mushroom"]] 					= 423,
		[NL["Gromsblood"]] 						= 424,
		[NL["Golden Sansam"]] 					= 425,
		[NL["Dreamfoil"]] 						= 426,
		[NL["Mountain Silversage"]] 			= 427,
		[NL["Plaguebloom"]] 					= 428,
		[NL["Icecap"]] 							= 429,
		--[NL["Bloodvine"]] 					= 430, -- zg bush loot
		[NL["Black Lotus"]] 					= 431,
		[NL["Felweed"]] 						= 432,
		[NL["Dreaming Glory"]] 					= 433,
		[NL["Terocone"]] 						= 434,
		--[NL["Ancient Lichen"]] 				= 435, -- instance only node
		[NL["Bloodthistle"]] 					= 436,
		[NL["Mana Thistle"]] 					= 437,
		[NL["Netherbloom"]] 					= 438,
		[NL["Nightmare Vine"]] 					= 439,
		[NL["Ragveil"]] 						= 440,
		[NL["Flame Cap"]] 						= 441,
		[NL["Netherdust Bush"]] 				= 442,
		[NL["Adder's Tongue"]]					= 443,
		--[NL["Constrictor Grass"]]				= 444, -- drop form others
		--[NL["Deadnettle"]]						= 445, --looted from other plants
		[NL["Goldclover"]]						= 446,
		[NL["Icethorn"]]						= 447,
		[NL["Lichbloom"]]						= 448,
		[NL["Talandra's Rose"]]					= 449,
		[NL["Tiger Lily"]]						= 450,
		[NL["Firethorn"]]						= 451,
		[NL["Frozen Herb"]]						= 452,
		[NL["Frost Lotus"]]						= 453, -- found in lake wintergrasp only
	},
	["Treasure"] = {
		[NL["Giant Clam"]] 						= 501,
		[NL["Battered Chest"]] 					= 502,
		[NL["Tattered Chest"]] 					= 503,
		[NL["Solid Chest"]] 					= 504,
		[NL["Large Iron Bound Chest"]] 			= 505,
		[NL["Large Solid Chest"]] 				= 506,
		[NL["Large Battered Chest"]]			= 507,
		[NL["Buccaneer's Strongbox"]] 			= 508,
		[NL["Large Mithril Bound Chest"]] 		= 509,
		[NL["Large Darkwood Chest"]] 			= 510,
		[NL["Un'Goro Dirt Pile"]] 				= 511,
		[NL["Bloodpetal Sprout"]] 				= 512,
		[NL["Blood of Heroes"]] 				= 513,
		[NL["Practice Lockbox"]] 				= 514,
		[NL["Battered Footlocker"]] 			= 515,
		[NL["Waterlogged Footlocker"]] 			= 516,
		[NL["Dented Footlocker"]] 				= 517,
		[NL["Mossy Footlocker"]] 				= 518,
		[NL["Scarlet Footlocker"]] 				= 519,
		[NL["Burial Chest"]] 					= 520,
		[NL["Fel Iron Chest"]] 					= 521,
		[NL["Heavy Fel Iron Chest"]] 			= 522,
		[NL["Adamantite Bound Chest"]] 			= 523,
		[NL["Felsteel Chest"]] 					= 524,
		[NL["Glowcap"]] 						= 525,
		[NL["Wicker Chest"]] 					= 526,
		[NL["Primitive Chest"]] 				= 527,
		[NL["Solid Fel Iron Chest"]] 			= 528,
		[NL["Bound Fel Iron Chest"]] 			= 529,
		--[NL["Bound Adamantite Chest"]] 		= 530, -- instance only node
		[NL["Netherwing Egg"]] 					= 531,
		[NL["Everfrost Chip"]]					= 532,
		[NL["Brightly Colored Egg"]]			= 533,
	},
}
GatherMate.nodeIDs = node_ids
local reverse = {}
for k,v in pairs(node_ids) do
	reverse[k] = GatherMate:CreateReversedTable(v)
end
GatherMate.reverseNodeIDs = reverse
-- Special fix because "Battered Chest" (502) and "Tattered Chest" (503) both translate to "Ramponierte Truhe" in deDE
if GetLocale() == "deDE" then GatherMate.reverseNodeIDs["Treasure"][502] = "Ramponierte Truhe" end

--[[
	Collector data for rare spawn determination
]]
local Collector = GatherMate:GetModule("Collector")
--[[
	Rare spawns are formatted as such the rareid = [nodes it replaces]
]]
local rare_spawns = {
	[204] = {[202]=true,[203]=true}, -- silver
	[205] = {[203]=true,[206]=true}, -- gold
	[208] = {[206]=true,[214]=true,[215]=true}, -- truesilver
	[209] = {[212]=true,[213]=true,[207]=true}, -- oozed covered silver
	[210] = {[212]=true,[213]=true,[207]=true}, -- ooze covered gold
	[211] = {[212]=true,[213]=true,[207]=true}, -- oozed covered true silver
	[217] = {[206]=true,[214]=true,[215]=true}, -- dark iron
	[224] = {[222]=true,[223]=true,[221]=true}, -- khorium
	[223] = {[222]=true}, -- rich adamantite
	[229] = {[228]=true}, -- rich cobalt node
	[232] = {[231]=true}, -- rich saronite node
	[230] = {[231]=true}, -- titanium node
	
	[441] = {[440]=true}, --flame cap
	
	[136] = {[108]=true}, -- sage fish
	[137] = {[107]=true}, --oily
	[138] = {[107]=true}, --oily
	[139] = {[107]=true}, --oily
	[140] = {[107]=true}, --oily
	[141] = {[105]=true}, --snapper
	[142] = {[105]=true}, --snapper
	[143] = {[105]=true}, --snapper
	[144] = {[105]=true}, --snapper
	[145] = {[103]=true}, --debris
	[146] = {[133]=true}, --schooner
	[147] = {[135]=true}, --bloodsail
	[148] = {[101]=true}, -- floating wreckage

}
Collector.rareNodes = rare_spawns
-- Format zone = { "Database", "new node id"}
local nodeRemap = {
	[78] = { ["Herb Gathering"] = 452},
	[73] = { ["Herb Gathering"] = 452},
}
Collector.specials = nodeRemap
--[[
	Below are Display Module Constants
]]
local Display = GatherMate:GetModule("Display")
local icon_path = "Interface\\AddOns\\GatherMate\\Artwork\\"
Display.trackingCircle = icon_path.."track_circle.tga"

Display:SetSkillTracking("Mining", "Interface\\Icons\\Spell_Nature_Earthquake")
Display:SetSkillTracking("Herb Gathering", "Interface\\Icons\\INV_Misc_Flower_02")
Display:SetSkillTracking("Fishing", "Interface\\Icons\\INV_Misc_Fish_02")
Display:SetSkillTracking("Treasure", "Interface\\Icons\\Racial_Dwarf_FindTreasure")

Display:SetSkillProfession("Herb Gathering", L["Herbalism"])
Display:SetSkillProfession("Mining", L["Mining"])
Display:SetSkillProfession("Fishing", L["Fishing"])
Display:SetSkillProfession("Extract Gas", L["Engineering"])
--[[
	Textures for display
]]
local node_textures = {
	["Fishing"] = {
		[101] = icon_path.."Fish\\treasure.tga",
		[102] = icon_path.."Fish\\purewater.tga",
		[103] = icon_path.."Fish\\debris.tga",
		[104] = icon_path.."Fish\\oilspill.tga",
		[105] = icon_path.."Fish\\firefin.tga",
		[106] = icon_path.."Fish\\greater_sagefish.tga",
		[107] = icon_path.."Fish\\oilyblackmouth.tga",
		[108] = icon_path.."Fish\\sagefish.tga",
		[109] = icon_path.."Fish\\firefin.tga",
		[110] = icon_path.."Fish\\eel.tga",
		[111] = icon_path.."Fish\\net.tga",
		[112] = icon_path.."Fish\\fish_hook.tga",
		[113] = icon_path.."Fish\\purewater.tga",
		[114] = icon_path.."Fish\\bluefish.tga",
		[115] = icon_path.."Fish\\feltail.tga",
		[116] = icon_path.."Fish\\mudfish.tga",
		[117] = icon_path.."Fish\\darter.tga",
		[118] = icon_path.."Fish\\sporefish.tga",
		[119] = icon_path.."Fish\\steampump.tga",
		[120] = icon_path.."Fish\\net.tga",
		[121] = icon_path.."Fish\\manowar.tga",
		[122] = icon_path.."Fish\\net.tga",
		[123] = icon_path.."Fish\\anglefish.tga",
		[124] = icon_path.."Fish\\herring.tga",
		[125] = icon_path.."Fish\\treasure.tga",
		[126] = icon_path.."Fish\\salmon.tga",
		[127] = icon_path.."Fish\\minnow.tga",
		[128] = icon_path.."Fish\\manta.tga",
		[129] = icon_path.."Fish\\bonescale.tga",
		[130] = icon_path.."Fish\\musselback.tga",
		[131] = icon_path.."Fish\\nettlefish.tga",
		[132] = icon_path.."Fish\\purewater.tga",
		[133] = icon_path.."Fish\\treasure.tga",
		[134] = icon_path.."Fish\\treasure.tga",
		[135] = icon_path.."Fish\\treasure.tga",
		[136] = icon_path.."Fish\\sagefish.tga",
		[137] = icon_path.."Fish\\oilyblackmouth.tga",
		[138] = icon_path.."Fish\\oilyblackmouth.tga",
		[139] = icon_path.."Fish\\oilyblackmouth.tga",
		[140] = icon_path.."Fish\\oilyblackmouth.tga",
		[141] = icon_path.."Fish\\firefin.tga",
		[142] = icon_path.."Fish\\firefin.tga",
		[143] = icon_path.."Fish\\firefin.tga",
		[144] = icon_path.."Fish\\firefin.tga",
		[145] = icon_path.."Fish\\debris.tga",
		[146] = icon_path.."Fish\\treasure.tga",
		[147] = icon_path.."Fish\\treasure.tga",
		[148] = icon_path.."Fish\\treasure.tga",
	},
	["Mining"] = {
		[201] = icon_path.."Mine\\copper.tga",
		[202] = icon_path.."Mine\\tin.tga",
		[203] = icon_path.."Mine\\iron.tga",
		[204] = icon_path.."Mine\\silver.tga",
		[205] = icon_path.."Mine\\gold.tga",
		[206] = icon_path.."Mine\\mithril.tga",
		[207] = icon_path.."Mine\\mithril.tga",
		[208] = icon_path.."Mine\\truesilver.tga",
		[209] = icon_path.."Mine\\silver.tga",
		[210] = icon_path.."Mine\\gold.tga",
		[211] = icon_path.."Mine\\truesilver.tga",
		[212] = icon_path.."Mine\\rich_thorium.tga",
		[213] = icon_path.."Mine\\thorium.tga",
		[214] = icon_path.."Mine\\thorium.tga",
		[215] = icon_path.."Mine\\rich_thorium.tga",
		[216] = icon_path.."Mine\\rich_thorium.tga",
		[217] = icon_path.."Mine\\darkiron.tga",
		[218] = icon_path.."Mine\\blood_iron.tga",
		[219] = icon_path.."Mine\\darkiron.tga",
		[220] = icon_path.."Mine\\blood_iron.tga",
		[221] = icon_path.."Mine\\feliron.tga",
		[222] = icon_path.."Mine\\adamantium.tga",
		[223] = icon_path.."Mine\\rich_adamantium.tga",
		[224] = icon_path.."Mine\\khorium.tga",
		[225] = icon_path.."Mine\\ethernium.tga",
		[226] = icon_path.."Mine\\ethernium.tga",
		[227] = icon_path.."Mine\\ethernium.tga",
		-- place holder graphic
		[228] = icon_path.."Mine\\cobalt.tga",
		[229] = icon_path.."Mine\\cobalt.tga",
		[230] = icon_path.."Mine\\titanium.tga",
		[231] = icon_path.."Mine\\saronite.tga",
		[232] = icon_path.."Mine\\saronite.tga",
	},
	["Extract Gas"] = {
		[301] = icon_path.."Gas\\windy_cloud.tga",
		[302] = icon_path.."Gas\\swamp_gas.tga",
		[303] = icon_path.."Gas\\arcane_vortex.tga",
		[304] = icon_path.."Gas\\felmist.tga",
		[305] = icon_path.."Gas\\steam.tga",
		[306] = icon_path.."Gas\\cinder.tga",
		[307] = icon_path.."Gas\\arctic.tga",
	},
	["Herb Gathering"] = {
		[401] = icon_path.."Herb\\peacebloom.tga",
		[402] = icon_path.."Herb\\silverleaf.tga",
		[403] = icon_path.."Herb\\earthroot.tga",
		[404] = icon_path.."Herb\\mageroyal.tga",
		[405] = icon_path.."Herb\\briarthorn.tga",
		[406] = icon_path.."Herb\\earthroot.tga",
		[407] = icon_path.."Herb\\stranglekelp.tga",
		[408] = icon_path.."Herb\\bruiseweed.tga",
		[409] = icon_path.."Herb\\wild_steelbloom.tga",
		[410] = icon_path.."Herb\\grave_moss.tga",
		[411] = icon_path.."Herb\\kingsblood.tga",
		[412] = icon_path.."Herb\\liferoot.tga",
		[413] = icon_path.."Herb\\fadeleaf.tga",
		[414] = icon_path.."Herb\\goldthorn.tga",
		[415] = icon_path.."Herb\\khadgars_whisker.tga",
		[416] = icon_path.."Herb\\wintersbite.tga",
		[417] = icon_path.."Herb\\firebloom.tga",
		[418] = icon_path.."Herb\\purple_lotus.tga",
		[419] = icon_path.."Herb\\purple_lotus.tga",
		[420] = icon_path.."Herb\\arthas_tears.tga",
		[421] = icon_path.."Herb\\sungrass.tga",
		[422] = icon_path.."Herb\\blindweed.tga",
		[423] = icon_path.."Herb\\ghost_mushroom.tga",
		[424] = icon_path.."Herb\\gromsblood.tga",
		[425] = icon_path.."Herb\\golden_sansam.tga",
		[426] = icon_path.."Herb\\dreamfoil.tga",
		[427] = icon_path.."Herb\\mountain_silversage.tga",
		[428] = icon_path.."Herb\\plaguebloom.tga",
		[429] = icon_path.."Herb\\icecap.tga",
		[430] = icon_path.."Herb\\purple_lotus.tga",
		[431] = icon_path.."Herb\\black_lotus.tga",
		[432] = icon_path.."Herb\\felweed.tga",
		[433] = icon_path.."Herb\\dreaming_glory.tga",
		[434] = icon_path.."Herb\\terocone.tga",
		[435] = icon_path.."Herb\\ancient_lichen.tga",
		[436] = icon_path.."Herb\\stranglekelp.tga",
		[437] = icon_path.."Herb\\mana_thistle.tga",
		[438] = icon_path.."Herb\\netherbloom.tga",
		[439] = icon_path.."Herb\\nightmare_vine.tga",
		[440] = icon_path.."Herb\\ragveil.tga",
		[441] = icon_path.."Herb\\flame_cap.tga",
		[442] = icon_path.."Herb\\netherdust.tga",
		-- place holder graphic
		[443] = icon_path.."Herb\\evergreen.tga",
		[444] = icon_path.."Herb\\constrictor.tga",
		[445] = icon_path.."Herb\\constrictor.tga",
		[446] = icon_path.."Herb\\goldclover.tga",
		[447] = icon_path.."Herb\\icethorn.tga",
		[448] = icon_path.."Herb\\whispervine.tga",
		[449] = icon_path.."Herb\\trose.tga",
		[450] = icon_path.."Herb\\tigerlily.tga",
		[451] = icon_path.."Herb\\briarthorn.tga",
		[452] = icon_path.."Herb\\misc_flower.tga",
		[453] = icon_path.."Herb\\frostlotus.tga",
	},
	["Treasure"] = {
		[501] = icon_path.."Treasure\\clam.tga",
		[502] = icon_path.."Treasure\\chest.tga",
		[503] = icon_path.."Treasure\\chest.tga",
		[504] = icon_path.."Treasure\\chest.tga",
		[505] = icon_path.."Treasure\\chest.tga",
		[506] = icon_path.."Treasure\\chest.tga",
		[507] = icon_path.."Treasure\\hest.tga",
		[508] = icon_path.."Treasure\\chest.tga",
		[509] = icon_path.."Treasure\\chest.tga",
		[510] = icon_path.."Treasure\\chest.tga",
		[511] = icon_path.."Treasure\\soil.tga",
		[512] = icon_path.."Treasure\\sprout.tga",
		[513] = icon_path.."Treasure\\blood.tga",
		[514] = icon_path.."Treasure\\footlocker.tga",
		[515] = icon_path.."Treasure\\footlocker.tga",
		[516] = icon_path.."Treasure\\footlocker.tga",
		[517] = icon_path.."Treasure\\footlocker.tga",
		[518] = icon_path.."Treasure\\footlocker.tga",
		[519] = icon_path.."Treasure\\footlocker.tga",
		[520] = icon_path.."Treasure\\chest.tga",
		[521] = icon_path.."Treasure\\treasure.tga",
		[522] = icon_path.."Treasure\\treasure.tga",
		[523] = icon_path.."Treasure\\treasure.tga",
		[524] = icon_path.."Treasure\\treasure.tga",
		[525] = icon_path.."Treasure\\mushroom.tga",
		[526] = icon_path.."Treasure\\treasure.tga",
		[527] = icon_path.."Treasure\\treasure.tga",
		[528] = icon_path.."Treasure\\tresure.tga",
		[529] = icon_path.."Treasure\\treasure.tga",
		[530] = icon_path.."Treasure\\treasure.tga",
		[531] = icon_path.."Treasure\\egg.tga",	
		[532] = icon_path.."Treasure\\everfrost.tga",	
		[533] = icon_path.."Treasure\\egg.tga",
	},
}
GatherMate.nodeTextures = node_textures
--[[
	Min level to harvest
]]
local node_minharvest = {
	["Fishing"] = {
	},
	["Mining"] = {
		[201] = 1,
		[202] = 65,
		[203] = 125,
		[204] = 75,
		[205] = 155,
		[206] = 175,
		[207] = 175,
		[208] = 230,
		[209] = 75,
		[210] = 155,
		[211] = 230,
		[212] = 255,
		[213] = 230,
		[214] = 230,
		[215] = 255,
		[216] = 255,
		[217] = 230,
		[218] = 75,
		[219] = 65,
		[220] = 150,
		[221] = 275,
		[222] = 325,
		[223] = 350,
		[224] = 375,
		[225] = 305,
		[226] = 305,
		[227] = 275,
		[228] = 350,
		[229] = 375,
		[230] = 450,
		[231] = 400,
		[232] = 425,
	},
	["Extract Gas"] = {
		[301] = 305,
		[302] = 305,
		[303] = 305,
		[304] = 305,
		[305] = 305,
		[306] = 305,
		[307] = 305,
	},
	["Herb Gathering"] = {
		[401] = 1,
		[402] = 1,
		[403] = 15,
		[404] = 50,
		[405] = 70,
		[406] = 15,
		[407] = 85,
		[408] = 100,
		[409] = 115,
		[410] = 120,
		[411] = 125,
		[412] = 150,
		[413] = 160,
		[414] = 170,
		[415] = 185,
		[416] = 195,
		[417] = 205,
		[418] = 210,
		[419] = 210,
		[420] = 220,
		[421] = 230,
		[422] = 235,
		[423] = 245,
		[424] = 250,
		[425] = 260,
		[426] = 270,
		[427] = 280,
		[428] = 285,
		[429] = 290,
		[430] = 300,
		[431] = 300,
		[432] = 300,
		[433] = 315,
		[434] = 325,
		[435] = 340,
		[436] = 1,
		[437] = 375,
		[438] = 350,
		[439] = 365,
		[440] = 325,
		[441] = 335,
		[442] = 350,
		[443] = 400,
		--[444] = ??, Constrictor Grass
		--[445] = ??, Deadnettle
		[446] = 350,
		[447] = 435,
		[448] = 425,
		[449] = 385,
		[450] = 375,
		[451] = 360,
		[452] = 415,
		[452] = 425,
	},
	["Treasure"] = {
	},
}
GatherMate.nodeMinHarvest = node_minharvest
--[[
	Minimap scale settings for zoom
]]
local minimap_size = {
	indoor = {
		[0] = 300, -- scale
		[1] = 240, -- 1.25
		[2] = 180, -- 5/3
		[3] = 120, -- 2.5
		[4] = 80,  -- 3.75
		[5] = 50,  -- 6
	},
	outdoor = {
		[0] = 466 + 2/3, -- scale
		[1] = 400,       -- 7/6
		[2] = 333 + 1/3, -- 1.4
		[3] = 266 + 2/6, -- 1.75
		[4] = 200,       -- 7/3
		[5] = 133 + 1/3, -- 3.5
	},
}
Display.minimapSize = minimap_size
--[[
	Minimap shapes lookup table to determine round of not
	borrowed from strolobe for faster lookups
]]
local minimap_shapes = {
	-- { upper-left, lower-left, upper-right, lower-right }
	["SQUARE"]                = { false, false, false, false },
	["CORNER-TOPLEFT"]        = { true,  false, false, false },
	["CORNER-TOPRIGHT"]       = { false, false, true,  false },
	["CORNER-BOTTOMLEFT"]     = { false, true,  false, false },
	["CORNER-BOTTOMRIGHT"]    = { false, false, false, true },
	["SIDE-LEFT"]             = { true,  true,  false, false },
	["SIDE-RIGHT"]            = { false, false, true,  true },
	["SIDE-TOP"]              = { true,  false, true,  false },
	["SIDE-BOTTOM"]           = { false, true,  false, true },
	["TRICORNER-TOPLEFT"]     = { true,  true,  true,  false },
	["TRICORNER-TOPRIGHT"]    = { true,  false, true,  true },
	["TRICORNER-BOTTOMLEFT"]  = { true,  true,  false, true },
	["TRICORNER-BOTTOMRIGHT"] = { false, true,  true,  true },
}
Display.minimapShapes = minimap_shapes
