--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005-2010 Dan Gilbert <dan.b.gilbert@gmail.com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

local BabbleSubZone = Atlas_GetLocaleLibBabble("LibBabble-SubZone-3.0");
local BabbleZone = Atlas_GetLocaleLibBabble("LibBabble-Zone-3.0");

local BLUE = "|cff6666ff";
local GREY = "|cff999999";
local GREN = "|cff66cc33";
local _RED = "|cffcc6666";
local ORNG = "|cffcc9933";
local PURP = "|cff9900ff";
local INDENT = "      ";

local ZONE = 1;
local NPC = 2;
local ITEM = 3;
local OBJECT = 4;
local FACTION = 5;
local QUEST = 6;

local myCategory = AtlasDLLocale["Dungeon Locations"];

local myData = {
	DLEast = {
		ZoneName = { BabbleZone["Eastern Kingdoms"] };
		{ BLUE.."A) "..BabbleZone["Alterac Valley"]..", ".._RED..BabbleZone["Alterac Mountains"].." / "..BabbleZone["Hillsbrad Foothills"], ZONE, 2597, 36, 267 };
		{ BLUE.."B) "..BabbleZone["Arathi Basin"]..", ".._RED..BabbleZone["Arathi Highlands"], ZONE, 3358, 45 };
		{ GREY.."1) "..BabbleZone["Magisters' Terrace"]..", ".._RED..BabbleZone["Isle of Quel'Danas"], ZONE, 4095, 4080 };
		{ GREY..INDENT..BabbleZone["Sunwell Plateau"]..", ".._RED..BabbleZone["Isle of Quel'Danas"], ZONE, 4075, 4080 };
		{ GREY.."2) "..BabbleZone["Zul'Aman"]..", ".._RED..BabbleZone["Ghostlands"], ZONE, 3805, 3433 };
		{ GREY.."3) "..BabbleZone["Scarlet Monastery"]..", ".._RED..BabbleZone["Tirisfal Glades"], ZONE, 796, 85 };
		{ GREY.."4) "..BabbleZone["Stratholme"]..", ".._RED..BabbleZone["Eastern Plaguelands"], ZONE, 2017, 139 };
		{ GREY.."5) "..BabbleZone["Scholomance"]..", ".._RED..BabbleZone["Western Plaguelands"], ZONE, 2057, 28 };
		{ GREY.."6) "..BabbleZone["Shadowfang Keep"]..", ".._RED..BabbleZone["Silverpine Forest"], ZONE, 209, 130 };
		{ GREY.."7) "..BabbleZone["Gnomeregan"]..", ".._RED..BabbleZone["Dun Morogh"], ZONE, 133, 1 };
		{ GREY.."8) "..BabbleZone["Uldaman"]..", ".._RED..BabbleZone["Badlands"], ZONE, 1337, 3 };
		{ GREY.."9) "..BabbleZone["Blackwing Lair"]..", ".._RED..BabbleZone["Blackrock Spire"], ZONE, 2677, 1583 };
		{ GREY..INDENT..BabbleZone["Blackrock Depths"]..", ".._RED..BabbleZone["Blackrock Mountain"], ZONE, 1584, 25 };
		{ GREY..INDENT..BabbleZone["Blackrock Spire"]..", ".._RED..BabbleZone["Blackrock Mountain"], ZONE, 1583, 25 };
		{ GREY..INDENT..BabbleZone["Molten Core"]..", ".._RED..BabbleZone["Blackrock Depths"], ZONE, 2717, 1584 };
		{ GREY.."10) "..BabbleZone["The Stockade"]..", ".._RED..BabbleZone["Stormwind City"], ZONE, 717, 1519 };
		{ GREY.."11) "..BabbleZone["The Deadmines"]..", ".._RED..BabbleZone["Westfall"], ZONE, 1581, 40 };
		{ GREY.."12) "..BabbleZone["Zul'Gurub"]..", ".._RED..BabbleZone["Stranglethorn Vale"], ZONE, 19, 33 };
		{ GREY.."13) "..BabbleZone["Karazhan"]..", ".._RED..BabbleZone["Deadwind Pass"], ZONE, 2562, 41 };
		{ GREY.."14) "..BabbleZone["Sunken Temple"]..", ".._RED..BabbleZone["Swamp of Sorrows"], ZONE, 1417, 8 };
		{ "" };
		{ BLUE..AtlasDLLocale["Blue"]..": "..ORNG..AtlasDLLocale["Battlegrounds"] };
		{ GREY..AtlasDLLocale["White"]..": "..ORNG..AtlasDLLocale["Instances"] };
	};
	DLWest = {
		ZoneName = { BabbleZone["Kalimdor"] };
		{ BLUE.."A) "..BabbleZone["Warsong Gulch"]..", ".._RED..BabbleZone["The Barrens"].." / "..BabbleZone["Ashenvale"], ZONE, 3277, 17, 331 };
		{ GREY.."1) "..BabbleZone["Blackfathom Deeps"]..", ".._RED..BabbleZone["Ashenvale"], ZONE, 719, 331 };
		{ GREY.."2) "..BabbleZone["Ragefire Chasm"]..", ".._RED..BabbleZone["Orgrimmar"], ZONE, 2437, 1637 };
		{ GREY.."3) "..BabbleZone["Wailing Caverns"]..", ".._RED..BabbleZone["The Barrens"], ZONE, 718, 17 };
		{ GREY.."4) "..BabbleZone["Maraudon"]..", ".._RED..BabbleZone["Desolace"], ZONE, 2100, 405 };
		{ GREY.."5) "..BabbleZone["Dire Maul"]..", ".._RED..BabbleZone["Feralas"], ZONE, 2557, 357 };
		{ GREY.."6) "..BabbleZone["Razorfen Kraul"]..", ".._RED..BabbleZone["The Barrens"], ZONE, 491, 17 };
		{ GREY.."7) "..BabbleZone["Razorfen Downs"]..", ".._RED..BabbleZone["The Barrens"], ZONE, 722, 17 };
		{ GREY.."8) "..BabbleZone["Onyxia's Lair"]..", ".._RED..BabbleZone["Dustwallow Marsh"], ZONE, 2159, 15 };
		{ GREY.."9) "..BabbleZone["Zul'Farrak"]..", ".._RED..BabbleZone["Tanaris"], ZONE, 978, 440 };
		{ GREY.."10) "..BabbleZone["Caverns of Time"]..", ".._RED..BabbleZone["Tanaris"], ZONE, 0, 440 };
		{ GREY..INDENT..BabbleZone["Old Hillsbrad Foothills"], ZONE, 2367 };
		{ GREY..INDENT..BabbleZone["The Black Morass"], ZONE, 2366 };
		{ GREY..INDENT..BabbleZone["Hyjal Summit"], ZONE, 3606 };
		{ GREY..INDENT..BabbleZone["The Culling of Stratholme"], ZONE, 4100 };
		{ GREY.."11) "..BabbleZone["Ruins of Ahn'Qiraj"]..", ".._RED..BabbleZone["Silithus"], ZONE, 3429, 1377 };
		{ GREY..INDENT..BabbleZone["Temple of Ahn'Qiraj"]..", ".._RED..BabbleZone["Silithus"], ZONE, 3428, 1377 };
		{ "" };
		{ BLUE..AtlasDLLocale["Blue"]..": "..ORNG..AtlasDLLocale["Battlegrounds"] };
		{ GREY..AtlasDLLocale["White"]..": "..ORNG..AtlasDLLocale["Instances"] };
	};
	DLOutland = {
		ZoneName = { BabbleZone["Outland"] };
		{ GREY.."1) "..BabbleZone["Gruul's Lair"]..", ".._RED..BabbleZone["Blade's Edge Mountains"], ZONE, 3618, 3522 };
		{ GREY.."2) "..BabbleZone["Tempest Keep"]..", ".._RED..BabbleZone["Netherstorm"], ZONE, nil, 3523 };
		{ GREY..INDENT..BabbleZone["The Mechanar"], ZONE, 3849 };
		{ GREY..INDENT..BabbleZone["The Botanica"], ZONE, 3847 };
		{ GREY..INDENT..BabbleZone["The Arcatraz"], ZONE, 3846 };
		{ GREY..INDENT..BabbleZone["The Eye"], ZONE, 3842 };
		{ GREY.."3) "..BabbleZone["Coilfang Reservoir"]..", ".._RED..BabbleZone["Zangarmarsh"], ZONE, nil, 3521 };
		{ GREY..INDENT..BabbleZone["The Slave Pens"], ZONE, 3717 };
		{ GREY..INDENT..BabbleZone["The Underbog"], ZONE, 3716 };
		{ GREY..INDENT..BabbleZone["The Steamvault"], ZONE, 3715 };
		{ GREY..INDENT..BabbleZone["Serpentshrine Cavern"], ZONE, 3607 };
		{ GREY.."4) "..BabbleZone["Hellfire Citadel"]..", ".._RED..BabbleZone["Hellfire Peninsula"], ZONE, nil, 3483 };
		{ GREY..INDENT..BabbleZone["Hellfire Ramparts"], ZONE, 3562 };
		{ GREY..INDENT..BabbleZone["The Blood Furnace"], ZONE, 3713 };
		{ GREY..INDENT..BabbleZone["The Shattered Halls"], ZONE, 3714 };
		{ GREY..INDENT..BabbleZone["Magtheridon's Lair"], ZONE, 3836 };
		{ GREY.."5) "..BabbleZone["Auchindoun"]..", ".._RED..BabbleZone["Terokkar Forest"], ZONE, nil, 3519 };
		{ GREY..INDENT..BabbleZone["Mana-Tombs"], ZONE, 3792 };
		{ GREY..INDENT..BabbleZone["Auchenai Crypts"], ZONE, 3790 };
		{ GREY..INDENT..BabbleZone["Sethekk Halls"], ZONE, 3791 };
		{ GREY..INDENT..BabbleZone["Shadow Labyrinth"], ZONE, 3789 };
		{ GREY.."6) "..BabbleZone["Black Temple"]..", ".._RED..BabbleZone["Shadowmoon Valley"], ZONE, 3959, 3520 };
	};
	DLNorthrend = {
		ZoneName = { BabbleZone["Northrend"] };
		{ GREY.."1) "..BabbleZone["The Nexus"]..", ".._RED..BabbleZone["Coldarra"], ZONE, nil, 3537 };
		{ GREY..INDENT..BabbleZone["The Nexus"], ZONE, 4120 };
		{ GREY..INDENT..BabbleZone["The Oculus"], ZONE, 4228 };
		{ GREY..INDENT..BabbleZone["The Eye of Eternity"], ZONE, 4500 };
		{ GREY.."2) "..BabbleZone["Azjol-Nerub"]..", ".._RED..BabbleZone["Dragonblight"], ZONE, nil, 65 };
		{ GREY..INDENT..BabbleZone["Azjol-Nerub"], ZONE, 3477 };
		{ GREY..INDENT..BabbleZone["Ahn'kahet: The Old Kingdom"], ZONE, 4494 };
		{ GREY.."3) "..BabbleSubZone["Chamber of the Aspects"]..", ".._RED..BabbleZone["Dragonblight"], ZONE, nil, 65 };
		{ GREY..INDENT..BabbleZone["The Obsidian Sanctum"], ZONE, 4493 };
		{ GREY..INDENT..BabbleZone["The Ruby Sanctum"], ZONE, 4987 };
		{ GREY.."4) "..BabbleZone["Naxxramas"]..", ".._RED..BabbleZone["Dragonblight"], ZONE, 3456, 65 };
		{ GREY.."5) "..BabbleZone["Drak'Tharon Keep"]..", ".._RED..BabbleZone["Grizzly Hills"], ZONE, 4196, 394 };
		{ GREY.."6) "..BabbleZone["Utgarde Keep"]..", ".._RED..BabbleZone["Howling Fjord"], ZONE, nil, 495 };
		{ GREY..INDENT..BabbleZone["Utgarde Keep"], ZONE, 206 };
		{ GREY..INDENT..BabbleZone["Utgarde Pinnacle"], ZONE, 1196 };
		{ GREY.."7) "..BabbleZone["Gundrak"]..", ".._RED..BabbleZone["Zul'Drak"], ZONE, 4375, 66 };
		{ GREY.."8) "..BabbleZone["The Violet Hold"]..", ".._RED..BabbleZone["Dalaran"], ZONE, 4415, 4395 };
		{ GREY.."9) "..BabbleZone["Vault of Archavon"]..", ".._RED..BabbleZone["Wintergrasp"], ZONE, 4603, 4197 };
		{ GREY.."10) "..BabbleZone["Ulduar"]..", ".._RED..BabbleZone["The Storm Peaks"], ZONE, nil, 67 };
		{ GREY..INDENT..BabbleZone["Ulduar"], ZONE, 4273 };
		{ GREY..INDENT..BabbleZone["Halls of Stone"], ZONE, 4264 };
		{ GREY..INDENT..BabbleZone["Halls of Lightning"], ZONE, 4272 };
		{ GREY.."11) "..AtlasDLLocale["Crusaders' Coliseum"]..", ".._RED..BabbleZone["Icecrown"], ZONE, nil, 210 };
		{ GREY..INDENT..BabbleZone["Trial of the Crusader"], ZONE, 4722 };
		{ GREY..INDENT..BabbleZone["Trial of the Champion"], ZONE, 4723 };
		{ GREY.."12) "..BabbleZone["Icecrown Citadel"]..", ".._RED..BabbleZone["Icecrown"], ZONE, nil, 210 };
		{ GREY..INDENT..BabbleZone["Icecrown Citadel"], ZONE, 4812 };
		{ GREY..INDENT..BabbleSubZone["The Frozen Halls"], ZONE, nil, 210 };		
		{ GREY..INDENT..INDENT..BabbleZone["The Forge of Souls"], ZONE, 4809 };
		{ GREY..INDENT..INDENT..BabbleZone["Pit of Saron"], ZONE, 4813 };
		{ GREY..INDENT..INDENT..BabbleZone["Halls of Reflection"], ZONE, 4820 };
	};
};

Atlas_RegisterPlugin("Atlas_DungeonLocs", myCategory, myData);
