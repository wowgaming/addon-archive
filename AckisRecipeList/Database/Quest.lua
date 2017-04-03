--[[
************************************************************************
Quest.lua
Quest data for all of Ackis Recipe List
************************************************************************
File date: 2010-01-21T05:11:47Z 
File revision: 2805 
Project revision: 2817
Project version: v1.0-r2818
************************************************************************
Format:
	AddQuest(QuestID, Zone, X, Y, Faction)
************************************************************************
Please see http://www.wowace.com/addons/arl/ for more information.
************************************************************************
This source code is released under All Rights Reserved.
************************************************************************
]]--

local MODNAME	= "Ackis Recipe List"
local addon		= LibStub("AceAddon-3.0"):GetAddon(MODNAME)
local L			= LibStub("AceLocale-3.0"):GetLocale(MODNAME)
local BZ		= LibStub("LibBabble-Zone-3.0"):GetLookupTable()

local NEUTRAL	= 0
local ALLIANCE	= 1
local HORDE	= 2

function addon:InitQuest(DB)
	local function AddQuest(QuestID, Zone, X, Y, Faction)
		addon:addLookupList(DB, QuestID, nil, Zone, X, Y, Faction)
	end

	AddQuest(22,	BZ["Westfall"],			55.77,	30.92,	ALLIANCE)
	AddQuest(38,	BZ["Westfall"],			55.77,	30.92,	ALLIANCE)
	AddQuest(90,	BZ["Duskwood"],			73.8,	43.7,	ALLIANCE)
	AddQuest(92,	BZ["Redridge Mountains"],	22.7,	44.0,	ALLIANCE)
	AddQuest(93,	BZ["Duskwood"],			73.8,	43.7,	ALLIANCE)
	AddQuest(127,	BZ["Redridge Mountains"],	27.8,	47.3,	ALLIANCE)
	AddQuest(296,	BZ["Wetlands"],			38.0,	49.9,	ALLIANCE)
	AddQuest(384,	BZ["Dun Morogh"],		46.8,	52.5,	ALLIANCE)
	AddQuest(385,	BZ["Loch Modan"],		81.8,	61.7,	ALLIANCE)
	AddQuest(418,	BZ["Loch Modan"],		34.8,	49.1,	ALLIANCE)
	AddQuest(429,	BZ["Silverpine Forest"],	53.5,	13.5,	HORDE)
	AddQuest(471,	BZ["Wetlands"],			8.6,	55.7,	ALLIANCE)
	AddQuest(498,	BZ["Hillsbrad Foothills"],	63.2,	20.7,	HORDE)
	AddQuest(501,	BZ["Hillsbrad Foothills"],	61.5,	19.2,	HORDE)
	AddQuest(555,	BZ["Hillsbrad Foothills"],	51.8,	58.7,	ALLIANCE)
	AddQuest(564,	BZ["Hillsbrad Foothills"],	52.4,	56.0,	ALLIANCE)
	AddQuest(703,	BZ["Badlands"],			42.4,	52.8,	NEUTRAL)
	AddQuest(715,	BZ["Badlands"],			25.8,	44.4,	NEUTRAL)
	AddQuest(769,	BZ["Thunder Bluff"],		44.1,	44.6,	HORDE)
	AddQuest(862,	BZ["The Barrens"],		55.3,	31.8,	HORDE)
	AddQuest(1487,	BZ["The Barrens"],		45.8,	36.3,	NEUTRAL)
	AddQuest(1559,	BZ["Badlands"],			42.4,	52.8,	NEUTRAL)
	AddQuest(1578,	BZ["Ironforge"],		48.5,	43.0,	ALLIANCE)
	AddQuest(1582,	BZ["Darnassus"],		64.3,	21.9,	ALLIANCE)
	AddQuest(1618,	BZ["Ironforge"],		48.5,	43.0,	ALLIANCE)
	AddQuest(2178,	BZ["Darkshore"],		37.7,	40.7,	ALLIANCE)
	AddQuest(2203,	BZ["Badlands"],			2.5,	46.1,	HORDE)
	AddQuest(2359,	BZ["Westfall"],			68.4,	70.0,	ALLIANCE)
	AddQuest(2478,	BZ["The Barrens"],		55.5,	5.6,	HORDE)
	AddQuest(2501,	BZ["Loch Modan"],		37.0,	49.2,	ALLIANCE)
	AddQuest(2751,	BZ["Orgrimmar"],		78.0,	21.4,	HORDE)
	AddQuest(2752,	BZ["Orgrimmar"],		78.0,	21.4,	HORDE)
	AddQuest(2753,	BZ["Orgrimmar"],		78.0,	21.4,	HORDE)
	AddQuest(2754,	BZ["Orgrimmar"],		78.0,	21.4,	HORDE)
	AddQuest(2755,	BZ["Orgrimmar"],		78.0,	21.4,	HORDE)
	AddQuest(2756,	BZ["Orgrimmar"],		80.7,	23.4,	HORDE)
	AddQuest(2758,	BZ["Stormwind City"],		63.0,	36.9,	ALLIANCE)
	AddQuest(2761,	BZ["Stranglethorn Vale"],	50.6,	20.5,	NEUTRAL)
	AddQuest(2762,	BZ["Stranglethorn Vale"],	50.6,	20.5,	NEUTRAL)
	AddQuest(2763,	BZ["Stranglethorn Vale"],	50.6,	20.5,	NEUTRAL)
	AddQuest(2771,	BZ["Tanaris"],			51.5,	28.7,	NEUTRAL)
	AddQuest(2772,	BZ["Tanaris"],			51.5,	28.7,	NEUTRAL)
	AddQuest(2773,	BZ["Tanaris"],			51.5,	28.7,	NEUTRAL)
	AddQuest(2848,	BZ["Feralas"],			30.6,	42.7,	ALLIANCE)
	AddQuest(2849,	BZ["Feralas"],			30.6,	42.7,	ALLIANCE)
	AddQuest(2850,	BZ["Feralas"],			30.6,	42.7,	ALLIANCE)
	AddQuest(2851,	BZ["Feralas"],			30.6,	42.7,	ALLIANCE)
	AddQuest(2852,	BZ["Feralas"],			30.6,	42.7,	ALLIANCE)
	AddQuest(2853,	BZ["Feralas"],			30.6,	42.7,	ALLIANCE)
	AddQuest(2855,	BZ["Feralas"],			74.5,	42.9,	HORDE)
	AddQuest(2856,	BZ["Feralas"],			74.5,	42.9,	HORDE)
	AddQuest(2857,	BZ["Feralas"],			74.5,	42.9,	HORDE)
	AddQuest(2858,	BZ["Feralas"],			74.5,	42.9,	HORDE)
	AddQuest(2859,	BZ["Feralas"],			74.5,	42.9,	HORDE)
	AddQuest(2860,	BZ["Feralas"],			74.5,	42.9,	HORDE)
	AddQuest(3402,	BZ["Searing Gorge"],		41.0,	74.8,	NEUTRAL)
	AddQuest(4083,	BZ["Blackrock Depths"],		0,	0,	NEUTRAL)
	AddQuest(4161,	BZ["Teldrassil"],		57.1,	61.3,	ALLIANCE)
	AddQuest(5124,	BZ["Winterspring"],		61.0,	38.7,	NEUTRAL)
	AddQuest(5127,	BZ["Winterspring"],		63.8,	73.8,	NEUTRAL)
	AddQuest(5305,	BZ["Winterspring"],		61.3,	37.1,	NEUTRAL)
	AddQuest(5306,	BZ["Winterspring"],		61.3,	37.1,	NEUTRAL)
	AddQuest(5307,	BZ["Winterspring"],		61.3,	37.2,	NEUTRAL)
	AddQuest(5518,	BZ["Dire Maul"],		0,	0,	NEUTRAL)
	AddQuest(6032,	BZ["Felwood"],			65.7,	2.9,	NEUTRAL)
	AddQuest(6610,	BZ["Tanaris"],			52.6,	28.1,	NEUTRAL)
	AddQuest(6622,	BZ["Arathi Highlands"],		73.4,	36.8,	HORDE)
	AddQuest(6624,	BZ["Dustwallow Marsh"],		67.7,	48.9,	ALLIANCE)
	AddQuest(7321,	BZ["Hillsbrad Foothills"],	62.4,	19.1,	HORDE)
	AddQuest(7493,	BZ["Orgrimmar"],		51.0,	76.5,	HORDE)
	AddQuest(7497,	BZ["Stormwind City"],		67.2,	85.5,	ALLIANCE)
	AddQuest(7604,	BZ["Blackrock Depths"],		0,	0,	NEUTRAL)
	AddQuest(7649,	BZ["Dire Maul"],		0,	0,	NEUTRAL)
	AddQuest(7650,	BZ["Dire Maul"],		0,	0,	NEUTRAL)
	AddQuest(7651,	BZ["Dire Maul"],		0,	0,	NEUTRAL)
	AddQuest(7653,	BZ["Tanaris"],			51.4,	28.7,	NEUTRAL)
	AddQuest(7654,	BZ["Tanaris"],			51.4,	28.7,	NEUTRAL)
	AddQuest(7655,	BZ["Tanaris"],			51.4,	28.7,	NEUTRAL)
	AddQuest(7656,	BZ["Tanaris"],			51.4,	28.7,	NEUTRAL)
	AddQuest(7657,	BZ["Tanaris"],			51.4,	28.7,	NEUTRAL)
	AddQuest(7658,	BZ["Tanaris"],			51.4,	28.7,	NEUTRAL)
	AddQuest(7659,	BZ["Tanaris"],			51.4,	28.7,	NEUTRAL)
	AddQuest(8313,	BZ["Silithus"],			38.0,	45.3,	NEUTRAL)
	AddQuest(8323,	BZ["Silithus"],			67.1,	69.7,	NEUTRAL)
	AddQuest(8586,	BZ["Tanaris"],			52.6,	28.1,	NEUTRAL)
	AddQuest(8798,	BZ["Winterspring"],		60.9,	37.7,	NEUTRAL)
	AddQuest(9171,	BZ["Ghostlands"],		48.3,	30.9,	HORDE)
	AddQuest(9249,	BZ["Darkmoon Faire"],		0,	0,	NEUTRAL)
	AddQuest(9356,	BZ["Hellfire Peninsula"],	49.2,	74.8,	NEUTRAL)
	AddQuest(9454,	BZ["Azuremyst Isle"],		49.8,	51.9,	ALLIANCE)
	AddQuest(9635,	BZ["Zangarmarsh"],		33.7,	50.2,	HORDE)
	AddQuest(9636,	BZ["Zangarmarsh"],		68.6,	50.2,	ALLIANCE)
	AddQuest(10860,	BZ["Blade's Edge Mountains"],	76.1,	60.3,	HORDE)
	AddQuest(12889,	BZ["The Storm Peaks"],		37.7,	46.5,	NEUTRAL)
	AddQuest(13571,	BZ["Dalaran"],			0,	0,	NEUTRAL)
	AddQuest(13087,	BZ["Howling Fjord"],		58.2,	62.1,	ALLIANCE)
	AddQuest(13088,	BZ["Borean Tundra"],		57.9,	71.5,	ALLIANCE)
	AddQuest(13089,	BZ["Howling Fjord"],		78.7,	29.5,	HORDE)
	AddQuest(13090,	BZ["Borean Tundra"],		42.0,	54.2,	HORDE)
	AddQuest(14151,	BZ["Dalaran"],			42.5,	32.1,	NEUTRAL)

end
