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

local myCategory = AtlasTransLocale["Transportation Maps"];

local myData = {
	TransAllianceEast = {
		ZoneName = { BabbleZone["Eastern Kingdoms"].." ("..AtlasTransLocale["Alliance"]..")" };
		{ BLUE.."A) "..BabbleSubZone["The Dark Portal"]..", ".._RED..BabbleZone["Blasted Lands"], ZONE, 4 };
		{ BLUE.."B) "..BabbleSubZone["Valgarde"]..", ".._RED..BabbleZone["Howling Fjord"], ZONE, 495 };
		{ BLUE.."C) "..BabbleSubZone["Valiance Keep"]..", ".._RED..BabbleZone["Borean Tundra"], ZONE, 3537 };
		{ BLUE.."D) "..BabbleSubZone["Auberdine"]..", ".._RED..BabbleZone["Darkshore"], ZONE, 148 };
		{ BLUE.."E) "..BabbleSubZone["Ratchet"]..", ".._RED..BabbleZone["The Barrens"], ZONE, 17 };
		{ BLUE.."F) "..BabbleSubZone["Theramore Isle"]..", ".._RED..BabbleZone["Dustwallow Marsh"], ZONE, 15 };
		{ BLUE.."G) "..BabbleSubZone["The Dark Portal"]..", ".._RED..BabbleZone["Hellfire Peninsula"], ZONE, 3483 };
		{ GREY.."1) "..BabbleSubZone["Sun's Reach Harbor"]..", ".._RED..BabbleZone["Isle of Quel'Danas"], ZONE, 4080 };
		{ GREY.."2) "..BabbleSubZone["Hatchet Hills"]..", ".._RED..BabbleZone["Ghostlands"], ZONE, 3433 };
		{ GREY.."3) "..BabbleSubZone["Light's Hope Chapel"]..", ".._RED..BabbleZone["Eastern Plaguelands"], ZONE, 139 };
		{ GREY.."4) "..BabbleSubZone["Thondroril River"]..", ".._RED..BabbleZone["Western Plaguelands"], ZONE, 28 };
		{ GREY.."5) "..BabbleSubZone["Chillwind Point"]..", ".._RED..BabbleZone["Western Plaguelands"], ZONE, 28 };
		{ GREY.."6) "..BabbleSubZone["Aerie Peak"]..", ".._RED..BabbleZone["The Hinterlands"], ZONE, 47 };
		{ GREY.."7) "..BabbleSubZone["Southshore"]..", ".._RED..BabbleZone["Hillsbrad Foothills"], ZONE, 267 };
		{ GREY.."8) "..BabbleSubZone["Refuge Pointe"]..", ".._RED..BabbleZone["Arathi Highlands"], ZONE, 45 };
		{ GREY.."9) "..BabbleSubZone["Menethil Harbor"]..", ".._RED..BabbleZone["Wetlands"], ZONE, 11 };
		{ GREY.."10) "..BabbleZone["Ironforge"]..", ".._RED..BabbleZone["Dun Morogh"], ZONE, 1 };
		{ GREY.."11) "..BabbleSubZone["Thelsamar"]..", ".._RED..BabbleZone["Loch Modan"], ZONE, 38 };
		{ GREY.."12) "..BabbleSubZone["Thorium Point"]..", ".._RED..BabbleZone["Searing Gorge"], ZONE, 51 };
		{ GREY.."13) "..BabbleSubZone["Morgan's Vigil"]..", ".._RED..BabbleZone["Burning Steppes"], ZONE, 46 };
		{ GREY.."14) "..BabbleZone["Stormwind City"]..", ".._RED..BabbleZone["Elwynn Forest"], ZONE, 12 };
		{ GREY.."15) "..BabbleSubZone["Lakeshire"]..", ".._RED..BabbleZone["Redridge Mountains"], ZONE, 44 };
		{ GREY.."16) "..BabbleSubZone["Sentinel Hill"]..", ".._RED..BabbleZone["Westfall"], ZONE, 40 };
		{ GREY.."17) "..BabbleSubZone["Darkshire"]..", ".._RED..BabbleZone["Duskwood"], ZONE, 10 };
		{ GREY.."18) "..BabbleSubZone["Nethergarde Keep"]..", ".._RED..BabbleZone["Blasted Lands"], ZONE, 4 };
		{ GREY.."19) "..BabbleSubZone["Rebel Camp"]..", ".._RED..BabbleZone["Stranglethorn Vale"], ZONE, 33 };
		{ GREY.."20) "..BabbleSubZone["Booty Bay"]..", ".._RED..BabbleZone["Stranglethorn Vale"], ZONE, 33 };
		{ GREY.."21) "..BabbleSubZone["The Dark Portal"]..", ".._RED..BabbleZone["Blasted Lands"], ZONE, 4 };
	};
	TransAllianceWest = {
		ZoneName = { BabbleZone["Kalimdor"].." ("..AtlasTransLocale["Alliance"]..")" };
		{ BLUE.."A) "..BabbleSubZone["Menethil Harbor"]..", ".._RED..BabbleZone["Wetlands"], ZONE, 11 };
		{ BLUE.."B) "..BabbleZone["Stormwind City"]..", ".._RED..BabbleZone["Elwynn Forest"], ZONE, 12 };
		{ BLUE.."C) "..BabbleSubZone["Booty Bay"]..", ".._RED..BabbleZone["Stranglethorn Vale"], ZONE, 33 };
		{ GREY.."1) "..BabbleSubZone["Rut'Theran Village"]..", ".._RED..BabbleZone["Teldrassil"], ZONE, 141 };
		{ GREY.."2) "..BabbleSubZone["Nighthaven"]..GREY..", ".._RED..BabbleZone["Moonglade"]..GREN.." ("..AtlasTransLocale["Druid-only"]..")", ZONE, 493 };
		{ GREY.."3) "..AtlasTransLocale["South of the path along Lake Elune'ara"]..", ".._RED..BabbleZone["Moonglade"], ZONE, 493 };
		{ GREY.."4) "..BabbleSubZone["Everlook"]..", ".._RED..BabbleZone["Winterspring"], ZONE, 618 };
		{ GREY.."5) "..BabbleSubZone["Auberdine"]..", ".._RED..BabbleZone["Darkshore"], ZONE, 148 };
		{ GREY.."6) "..BabbleSubZone["Talonbranch Glade"]..", ".._RED..BabbleZone["Felwood"], ZONE, 361 };
		{ GREY.."7) "..BabbleSubZone["Emerald Sanctuary"]..", ".._RED..BabbleZone["Felwood"], ZONE, 361 };
		{ GREY.."8) "..BabbleSubZone["Stonetalon Peak"]..", ".._RED..BabbleZone["Stonetalon Mountains"], ZONE, 406 };
		{ GREY.."9) "..BabbleSubZone["Astranaar"]..", ".._RED..BabbleZone["Ashenvale"], ZONE, 331 };
		{ GREY.."10) "..BabbleSubZone["Forest Song"]..", ".._RED..BabbleZone["Ashenvale"], ZONE, 331 };
		{ GREY.."11) "..BabbleSubZone["Talrendis Point"]..", ".._RED..BabbleZone["Azshara"], ZONE, 16 };
		{ GREY.."12) "..BabbleSubZone["Nijel's Point"]..", ".._RED..BabbleZone["Desolace"], ZONE, 405 };
		{ GREY.."13) "..BabbleSubZone["Ratchet"]..", ".._RED..BabbleZone["The Barrens"], ZONE, 17 };
		{ GREY.."14) "..BabbleSubZone["Theramore Isle"]..", ".._RED..BabbleZone["Dustwallow Marsh"], ZONE, 15 };
		{ GREY.."15) "..BabbleSubZone["Mudsprocket"]..", ".._RED..BabbleZone["Dustwallow Marsh"], ZONE, 15 };
		{ GREY.."16) "..BabbleSubZone["Feathermoon Stronghold"]..", ".._RED..BabbleZone["Feralas"], ZONE, 357 };
		{ GREY.."17) "..BabbleSubZone["The Forgotten Coast"]..", ".._RED..BabbleZone["Feralas"], ZONE, 357 };
		{ GREY.."18) "..BabbleSubZone["Thalanaar"]..", ".._RED..BabbleZone["Feralas"], ZONE, 357 };
		{ GREY.."19) "..BabbleSubZone["Marshal's Refuge"]..", ".._RED..BabbleZone["Un'Goro Crater"], ZONE, 490 };
		{ GREY.."20) "..BabbleSubZone["Cenarion Hold"]..", ".._RED..BabbleZone["Silithus"], ZONE, 1377 };
		{ GREY.."21) "..BabbleSubZone["Gadgetzan"]..", ".._RED..BabbleZone["Tanaris"], ZONE, 440 };
		{ GREY.."22) "..BabbleSubZone["Blood Watch"]..", ".._RED..BabbleZone["Bloodmyst Isle"], ZONE, 3525 };
		{ GREY.."23) "..BabbleSubZone["Valaar's Berth"]..", ".._RED..BabbleZone["Azuremyst Isle"], ZONE, 3524 };
	};
	TransHordeEast = {
		ZoneName = { BabbleZone["Eastern Kingdoms"].." ("..AtlasTransLocale["Horde"]..")" };
		{ BLUE.."A) "..BabbleSubZone["Vengeance Landing"]..", ".._RED..BabbleZone["Howling Fjord"], ZONE, 495 };
		{ BLUE.."B) "..BabbleZone["Orgrimmar"]..", ".._RED..BabbleZone["Durotar"], ZONE, 14 };
		{ BLUE.."C) "..BabbleSubZone["Ratchet"]..", ".._RED..BabbleZone["The Barrens"], ZONE, 17 };
		{ BLUE.."D) "..BabbleSubZone["The Dark Portal"]..", ".._RED..BabbleZone["Hellfire Peninsula"], ZONE, 3483 };
		{ GREY.."1) "..BabbleSubZone["Sun's Reach Harbor"]..", ".._RED..BabbleZone["Isle of Quel'Danas"], ZONE, 4080 };
		{ GREY.."2) "..BabbleZone["Silvermoon City"]..", ".._RED..BabbleZone["Eversong Woods"], ZONE, 3430 };
		{ GREY.."3) "..BabbleSubZone["Tranquillien"]..", ".._RED..BabbleZone["Ghostlands"], ZONE, 3433 };
		{ GREY.."4) "..BabbleSubZone["Hatchet Hills"]..", ".._RED..BabbleZone["Ghostlands"], ZONE, 3433 };
		{ GREY.."5) "..BabbleSubZone["Light's Hope Chapel"]..", ".._RED..BabbleZone["Eastern Plaguelands"], ZONE, 139 };
		{ GREY.."6) "..BabbleSubZone["Thondroril River"]..", ".._RED..BabbleZone["Western Plaguelands"], ZONE, 28 };
		{ GREY.."7) "..BabbleSubZone["The Bulwark"]..", ".._RED..BabbleZone["Tirisfal Glades"], ZONE, 85 };
		{ GREY.."8) "..BabbleZone["Undercity"]..", ".._RED..BabbleZone["Tirisfal Glades"], ZONE, 85 };
		{ GREY.."9) "..BabbleSubZone["The Sepulcher"]..", ".._RED..BabbleZone["Silverpine Forest"], ZONE, 130 };
		{ GREY.."10) "..BabbleSubZone["Tarren Mill"]..", ".._RED..BabbleZone["Hillsbrad Foothills"], ZONE, 267 };
		{ GREY.."11) "..BabbleSubZone["Revantusk Village"]..", ".._RED..BabbleZone["The Hinterlands"], ZONE, 47 };
		{ GREY.."12) "..BabbleSubZone["Hammerfall"]..", ".._RED..BabbleZone["Arathi Highlands"], ZONE, 45 };
		{ GREY.."13) "..BabbleSubZone["Thorium Point"]..", ".._RED..BabbleZone["Searing Gorge"], ZONE, 51 };
		{ GREY.."14) "..BabbleSubZone["Kargath"]..", ".._RED..BabbleZone["Badlands"], ZONE, 3 };
		{ GREY.."15) "..BabbleSubZone["Flame Crest"]..", ".._RED..BabbleZone["Burning Steppes"], ZONE, 46 };
		{ GREY.."16) "..BabbleSubZone["Stonard"]..", ".._RED..BabbleZone["Swamp of Sorrows"], ZONE, 8 };
		{ GREY.."17) "..BabbleSubZone["Grom'gol Base Camp"]..", ".._RED..BabbleZone["Stranglethorn Vale"], ZONE, 33 };
		{ GREY.."18) "..BabbleSubZone["Booty Bay"]..", ".._RED..BabbleZone["Stranglethorn Vale"], ZONE, 33 };
		{ GREY.."19) "..BabbleSubZone["The Dark Portal"]..", ".._RED..BabbleZone["Blasted Lands"], ZONE, 4 };
	};
	TransHordeWest = {
		ZoneName = { BabbleZone["Kalimdor"].." ("..AtlasTransLocale["Horde"]..")" };
		{ BLUE.."A) "..BabbleSubZone["The Dark Portal"]..", ".._RED..BabbleZone["Blasted Lands"], ZONE, 4 };
		{ BLUE.."B) "..BabbleSubZone["Warsong Hold"]..", ".._RED..BabbleZone["Borean Tundra"], ZONE, 3537 };
		{ BLUE.."C) "..BabbleZone["Undercity"]..", ".._RED..BabbleZone["Tirisfal Glades"], ZONE, 85 };
		{ BLUE.."D) "..BabbleSubZone["Grom'gol Base Camp"]..", ".._RED..BabbleZone["Stranglethorn Vale"], ZONE, 33 };
		{ BLUE.."E) "..BabbleSubZone["Booty Bay"]..", ".._RED..BabbleZone["Stranglethorn Vale"], ZONE, 33 };
		{ GREY.."1) "..BabbleSubZone["Nighthaven"]..GREY..", ".._RED..BabbleZone["Moonglade"]..GREN.." ("..AtlasTransLocale["Druid-only"]..")", ZONE, 493 };
		{ GREY.."2) "..AtlasTransLocale["West of the path to Timbermaw Hold"]..", ".._RED..BabbleZone["Moonglade"], ZONE, 493 };
		{ GREY.."3) "..BabbleSubZone["Everlook"]..", ".._RED..BabbleZone["Winterspring"], ZONE, 618 };
		{ GREY.."4) "..BabbleSubZone["Bloodvenom Post"]..", ".._RED..BabbleZone["Felwood"], ZONE, 361 };
		{ GREY.."5) "..BabbleSubZone["Emerald Sanctuary"]..", ".._RED..BabbleZone["Felwood"], ZONE, 361 };
		{ GREY.."6) "..BabbleSubZone["Zoram'gar Outpost"]..", ".._RED..BabbleZone["Ashenvale"], ZONE, 331 };
		{ GREY.."7) "..BabbleSubZone["Valormok"]..", ".._RED..BabbleZone["Azshara"], ZONE, 16 };
		{ GREY.."8) "..BabbleSubZone["Splintertree Post"]..", ".._RED..BabbleZone["Ashenvale"], ZONE, 331 };
		{ GREY.."9) "..BabbleZone["Orgrimmar"]..", ".._RED..BabbleZone["Durotar"], ZONE, 14 };
		{ GREY.."10) "..BabbleSubZone["Sun Rock Retreat"]..", ".._RED..BabbleZone["Stonetalon Mountains"], ZONE, 406 };
		{ GREY.."11) "..BabbleSubZone["The Crossroads"]..", ".._RED..BabbleZone["The Barrens"], ZONE, 17 };
		{ GREY.."12) "..BabbleSubZone["Ratchet"]..", ".._RED..BabbleZone["The Barrens"], ZONE, 17 };
		{ GREY.."13) "..BabbleSubZone["Shadowprey Village"]..", ".._RED..BabbleZone["Desolace"], ZONE, 405 };
		{ GREY.."14) "..BabbleZone["Thunder Bluff"]..", ".._RED..BabbleZone["Mulgore"], ZONE, 215 };
		{ GREY.."15) "..BabbleSubZone["Camp Taurajo"]..", ".._RED..BabbleZone["The Barrens"], ZONE, 17 };
		{ GREY.."16) "..BabbleSubZone["Brackenwall Village"]..", ".._RED..BabbleZone["Dustwallow Marsh"], ZONE, 15 };
		{ GREY.."17) "..BabbleSubZone["Mudsprocket"]..", ".._RED..BabbleZone["Dustwallow Marsh"], ZONE, 15 };
		{ GREY.."18) "..BabbleSubZone["Camp Mojache"]..", ".._RED..BabbleZone["Feralas"], ZONE, 357 };
		{ GREY.."19) "..BabbleSubZone["Freewind Post"]..", ".._RED..BabbleZone["Thousand Needles"], ZONE, 400 };
		{ GREY.."20) "..BabbleSubZone["Marshal's Refuge"]..", ".._RED..BabbleZone["Un'Goro Crater"], ZONE, 490 };
		{ GREY.."21) "..BabbleSubZone["Cenarion Hold"]..", ".._RED..BabbleZone["Silithus"], ZONE, 1377 };
		{ GREY.."22) "..BabbleSubZone["Gadgetzan"]..", ".._RED..BabbleZone["Tanaris"], ZONE, 440 };
	};
	TransAllianceOutland = {
		ZoneName = { BabbleZone["Outland"].." ("..AtlasTransLocale["Alliance"]..")" };
		{ BLUE.."A) "..BabbleSubZone["The Dark Portal"]..", ".._RED..BabbleZone["Blasted Lands"], ZONE, 4 };
		{ BLUE.."B) "..BabbleZone["Stormwind City"]..", ".._RED..BabbleZone["Elwynn Forest"], ZONE, 12 };
		{ BLUE.."C) "..BabbleZone["Ironforge"]..", ".._RED..BabbleZone["Dun Morogh"], ZONE, 1 };
		{ BLUE..INDENT..BabbleZone["Darnassus"]..", ".._RED..BabbleZone["Teldrassil"], ZONE, 141 };
		{ BLUE..INDENT..BabbleZone["The Exodar"]..", ".._RED..BabbleZone["Azuremyst Isle"], ZONE, 3524 };
		{ BLUE..INDENT..BabbleSubZone["Sun's Reach Sanctum"]..", ".._RED..BabbleZone["Isle of Quel'Danas"], ZONE, 4080 };
		{ BLUE..INDENT..BabbleSubZone["Caverns of Time"]..", ".._RED..BabbleZone["Tanaris"], ZONE, 440 };
		{ GREY.."1) "..BabbleSubZone["The Dark Portal"]..", ".._RED..BabbleZone["Hellfire Peninsula"], ZONE, 3483 };
		{ GREY.."2) "..BabbleSubZone["Shatter Point"]..", ".._RED..BabbleZone["Hellfire Peninsula"], ZONE, 3483 };
		{ GREY.."3) "..BabbleSubZone["Honor Hold"]..", ".._RED..BabbleZone["Hellfire Peninsula"], ZONE, 3483 };
		{ GREY.."4) "..BabbleSubZone["Temple of Telhamat"]..", ".._RED..BabbleZone["Hellfire Peninsula"], ZONE, 3483 };
		{ GREY.."5) "..BabbleSubZone["Telredor"]..", ".._RED..BabbleZone["Zangarmarsh"], ZONE, 3521 };
		{ GREY.."6) "..BabbleSubZone["Orebor Harborage"]..", ".._RED..BabbleZone["Zangarmarsh"], ZONE, 3521 };
		{ GREY.."7) "..BabbleSubZone["Telaar"]..", ".._RED..BabbleZone["Nagrand"], ZONE, 3518 };
		{ GREY.."8) "..BabbleZone["Shattrath City"]..", ".._RED..BabbleZone["Terokkar Forest"], ZONE, 3519 };
		{ GREY.."9) "..BabbleSubZone["Allerian Stronghold"]..", ".._RED..BabbleZone["Terokkar Forest"], ZONE, 3519 };
		{ GREY.."10) "..BabbleSubZone["Wildhammer Stronghold"]..", ".._RED..BabbleZone["Shadowmoon Valley"], ZONE, 3520 };
		{ GREY.."11) "..BabbleSubZone["Altar of Sha'tar"]..", ".._RED..BabbleZone["Shadowmoon Valley"]..BLUE.." ("..AtlasTransLocale["The Aldor"]..")", ZONE, 3520 , FACTION, 932 };
		{ GREY.."12) "..BabbleSubZone["Sanctum of the Stars"]..", ".._RED..BabbleZone["Shadowmoon Valley"]..BLUE.." ("..AtlasTransLocale["The Scryers"]..")", ZONE, 3520 , FACTION, 934 };
		{ GREY.."13) "..BabbleSubZone["Sylvanaar"]..", ".._RED..BabbleZone["Blade's Edge Mountains"], ZONE, 3522 };
		{ GREY.."14) "..BabbleSubZone["Evergrove"]..", ".._RED..BabbleZone["Blade's Edge Mountains"], ZONE, 3522 };
		{ GREY.."15) "..BabbleSubZone["Toshley's Station"]..", ".._RED..BabbleZone["Blade's Edge Mountains"], ZONE, 3522 };
		{ GREY.."16) "..BabbleSubZone["Area 52"]..", ".._RED..BabbleZone["Netherstorm"], ZONE, 3523 };
		{ GREY.."17) "..BabbleSubZone["The Stormspire"]..", ".._RED..BabbleZone["Netherstorm"], ZONE, 3523 };
		{ GREY.."18) "..BabbleSubZone["Cosmowrench"]..", ".._RED..BabbleZone["Netherstorm"], ZONE, 3523 };
		{ GREN.."1') "..BabbleSubZone["Blackwind Landing"]..", ".._RED..BabbleZone["Terokkar Forest"], ZONE, 3519 };
		{ GREN.."2') "..BabbleSubZone["Skyguard Outpost"]..", ".._RED..BabbleZone["Blade's Edge Mountains"], ZONE, 3522 };
		{ GREN..INDENT.."("..AtlasTransLocale["Requires honored faction with Sha'tari Skyguard"]..")", FACTION, 1031 };
	};
	TransHordeOutland = {
		ZoneName = { BabbleZone["Outland"].." ("..AtlasTransLocale["Horde"]..")" };
		{ BLUE.."A) "..BabbleSubZone["The Dark Portal"]..", ".._RED..BabbleZone["Blasted Lands"], ZONE, 4 };
		{ BLUE.."B) "..BabbleZone["Orgrimmar"]..", ".._RED..BabbleZone["Durotar"], ZONE, 14 };
		{ BLUE.."C) "..BabbleZone["Thunder Bluff"]..", ".._RED..BabbleZone["Mulgore"], ZONE, 215 };
		{ BLUE..INDENT..BabbleZone["Undercity"]..", ".._RED..BabbleZone["Tirisfal Glades"], ZONE, 85 };
		{ BLUE..INDENT..BabbleZone["Silvermoon City"]..", ".._RED..BabbleZone["Eversong Woods"], ZONE, 3430 };
		{ BLUE..INDENT..BabbleSubZone["Sun's Reach Sanctum"]..", ".._RED..BabbleZone["Isle of Quel'Danas"], ZONE, 4080 };
		{ BLUE..INDENT..BabbleSubZone["Caverns of Time"]..", ".._RED..BabbleZone["Tanaris"], ZONE, 440 };
		{ GREY.."1) "..BabbleSubZone["The Dark Portal"]..", ".._RED..BabbleZone["Hellfire Peninsula"], ZONE, 3483 };
		{ GREY.."2) "..BabbleSubZone["Thrallmar"]..", ".._RED..BabbleZone["Hellfire Peninsula"], ZONE, 3483 };
		{ GREY.."3) "..BabbleSubZone["Spinebreaker Post"]..", ".._RED..BabbleZone["Hellfire Peninsula"], ZONE, 3483 };
		{ GREY.."4) "..BabbleSubZone["Falcon Watch"]..", ".._RED..BabbleZone["Hellfire Peninsula"], ZONE, 3483 };
		{ GREY.."5) "..BabbleSubZone["Swamprat Post"]..", ".._RED..BabbleZone["Zangarmarsh"], ZONE, 3521 };
		{ GREY.."6) "..BabbleSubZone["Zabra'jin"]..", ".._RED..BabbleZone["Zangarmarsh"], ZONE, 3521 };
		{ GREY.."7) "..BabbleSubZone["Garadar"]..", ".._RED..BabbleZone["Nagrand"], ZONE, 3518 };
		{ GREY.."8) "..BabbleZone["Shattrath City"]..", ".._RED..BabbleZone["Terokkar Forest"], ZONE, 3519 };
		{ GREY.."9) "..BabbleSubZone["Stonebreaker Hold"]..", ".._RED..BabbleZone["Terokkar Forest"], ZONE, 3519 };
		{ GREY.."10) "..BabbleSubZone["Shadowmoon Village"]..", ".._RED..BabbleZone["Shadowmoon Valley"], ZONE, 3520 };
		{ GREY.."11) "..BabbleSubZone["Altar of Sha'tar"]..", ".._RED..BabbleZone["Shadowmoon Valley"]..BLUE.." ("..AtlasTransLocale["The Aldor"]..")", ZONE, 3520 , FACTION, 932 };
		{ GREY.."12) "..BabbleSubZone["Sanctum of the Stars"]..", ".._RED..BabbleZone["Shadowmoon Valley"]..BLUE.." ("..AtlasTransLocale["The Scryers"]..")", ZONE, 3520 , FACTION, 934 };
		{ GREY.."13) "..BabbleSubZone["Thunderlord Stronghold"]..", ".._RED..BabbleZone["Blade's Edge Mountains"], ZONE, 3522 };
		{ GREY.."14) "..BabbleSubZone["Evergrove"]..", ".._RED..BabbleZone["Blade's Edge Mountains"], ZONE, 3522 };
		{ GREY.."15) "..BabbleSubZone["Mok'Nathal Village"]..", ".._RED..BabbleZone["Blade's Edge Mountains"], ZONE, 3522 };
		{ GREY.."16) "..BabbleSubZone["Area 52"]..", ".._RED..BabbleZone["Netherstorm"], ZONE, 3523 };
		{ GREY.."17) "..BabbleSubZone["The Stormspire"]..", ".._RED..BabbleZone["Netherstorm"], ZONE, 3523 };
		{ GREY.."18) "..BabbleSubZone["Cosmowrench"]..", ".._RED..BabbleZone["Netherstorm"], ZONE, 3523 };
		{ GREN.."1') "..BabbleSubZone["Blackwind Landing"]..", ".._RED..BabbleZone["Terokkar Forest"], ZONE, 3519 };
		{ GREN.."2') "..BabbleSubZone["Skyguard Outpost"]..", ".._RED..BabbleZone["Blade's Edge Mountains"], ZONE, 3522 };
		{ GREN..INDENT.."("..AtlasTransLocale["Requires honored faction with Sha'tari Skyguard"]..")", FACTION, 1031 };
	};
	TransAllianceNorthrend = {
		ZoneName = { BabbleZone["Northrend"].." ("..AtlasTransLocale["Alliance"]..")" };
		{ BLUE.."A) "..BabbleZone["Stormwind City"]..", ".._RED..BabbleZone["Elwynn Forest"], ZONE, 12 };
		{ BLUE.."B) "..BabbleSubZone["Menethil Harbor"]..", ".._RED..BabbleZone["Wetlands"], ZONE, 11 };
		{ BLUE.."C) "..BabbleZone["Stormwind City"]..", ".._RED..BabbleZone["Elwynn Forest"], ZONE, 12 };
		{ BLUE..INDENT..BabbleZone["The Exodar"]..", ".._RED..BabbleZone["Azuremyst Isle"], ZONE, 3524 };
		{ BLUE..INDENT..BabbleZone["Ironforge"]..", ".._RED..BabbleZone["Dun Morogh"], ZONE, 1 };
		{ BLUE..INDENT..BabbleZone["Darnassus"]..", ".._RED..BabbleZone["Teldrassil"], ZONE, 141 };
		{ BLUE..INDENT..BabbleZone["Shattrath City"]..", ".._RED..BabbleZone["Terokkar Forest"], ZONE, 3519 };
		{ BLUE..INDENT..BabbleSubZone["Caverns of Time"]..", ".._RED..BabbleZone["Tanaris"], ZONE, 440 };
		{ GREY.."1) "..BabbleSubZone["Valiance Keep"]..", ".._RED..BabbleZone["Borean Tundra"], ZONE, 3537 };
		{ GREY.."2) "..BabbleSubZone["Amber Ledge"]..", ".._RED..BabbleZone["Borean Tundra"], ZONE, 3537 };
		{ GREY.."3) "..BabbleSubZone["Transitus Shield"]..", ".._RED..BabbleZone["Coldarra"], ZONE, 3537 };
		{ GREY.."4) "..BabbleSubZone["Fizzcrank Airstrip"]..", ".._RED..BabbleZone["Borean Tundra"], ZONE, 3537 };
		{ GREY.."5) "..BabbleSubZone["Unu'pe"]..", ".._RED..BabbleZone["Borean Tundra"], ZONE, 3537 };
		{ GREY.."6) "..BabbleSubZone["Nesingwary Base Camp"]..", ".._RED..BabbleZone["Sholazar Basin"], ZONE, 3711 };
		{ GREY.."7) "..BabbleSubZone["River's Heart"]..", ".._RED..BabbleZone["Sholazar Basin"], ZONE, 3711 };
		{ GREY.."8) "..BabbleSubZone["Stars' Rest"]..", ".._RED..BabbleZone["Dragonblight"], ZONE, 65 };
		{ GREY.."9) "..BabbleSubZone["Moa'ki Harbor"]..", ".._RED..BabbleZone["Dragonblight"], ZONE, 65 };
		{ GREY.."10) "..BabbleSubZone["Fordragon Hold"]..", ".._RED..BabbleZone["Dragonblight"], ZONE, 65 };
		{ GREY.."11) "..BabbleSubZone["Wyrmrest Temple"]..", ".._RED..BabbleZone["Dragonblight"], ZONE, 65 };
		{ GREY.."12) "..BabbleSubZone["Wintergarde Keep"]..", ".._RED..BabbleZone["Dragonblight"], ZONE, 65 };
		{ GREY.."13) "..BabbleSubZone["Westguard Keep"]..", ".._RED..BabbleZone["Howling Fjord"], ZONE, 495 };
		{ GREY.."14) "..BabbleSubZone["Kamagua"]..", ".._RED..BabbleZone["Howling Fjord"], ZONE, 495 };
		{ GREY.."15) "..BabbleSubZone["Valgarde"]..", ".._RED..BabbleZone["Howling Fjord"], ZONE, 495 };
		{ GREY.."16) "..BabbleSubZone["Fort Wildervar"]..", ".._RED..BabbleZone["Howling Fjord"], ZONE, 495 };
		{ GREY.."17) "..BabbleSubZone["Amberpine Lodge"]..", ".._RED..BabbleZone["Grizzly Hills"], ZONE, 394 };
		{ GREY.."18) "..BabbleSubZone["Westfall Brigade Encampment"]..", ".._RED..BabbleZone["Grizzly Hills"], ZONE, 394 };
		{ GREY.."19) "..BabbleSubZone["Gundrak"]..", ".._RED..BabbleZone["Zul'Drak"], ZONE, 66 };
		{ GREY.."20) "..BabbleSubZone["Zim'Torga"]..", ".._RED..BabbleZone["Zul'Drak"], ZONE, 66 };
		{ GREY.."21) "..BabbleSubZone["The Argent Stand"]..", ".._RED..BabbleZone["Zul'Drak"], ZONE, 66 };
		{ GREY.."22) "..BabbleSubZone["Light's Breach"]..", ".._RED..BabbleZone["Zul'Drak"], ZONE, 66 };
		{ GREY.."23) "..BabbleSubZone["Ebon Watch"]..", ".._RED..BabbleZone["Zul'Drak"], ZONE, 66 };
		{ GREY.."24) "..BabbleSubZone["Windrunner's Overlook"]..", ".._RED..BabbleZone["Crystalsong Forest"], ZONE, 2817 };
		{ GREY.."25) "..BabbleZone["Dalaran"]..", ".._RED..BabbleZone["Crystalsong Forest"], ZONE, 2817 };
		{ GREY.."26) "..BabbleSubZone["Frosthold"]..", ".._RED..BabbleZone["The Storm Peaks"], ZONE, 67 };
		{ GREY.."27) "..BabbleSubZone["K3"]..", ".._RED..BabbleZone["The Storm Peaks"], ZONE, 67 };
		{ GREY.."28) "..BabbleSubZone["Bouldercrag's Refuge"]..", ".._RED..BabbleZone["The Storm Peaks"], ZONE, 67 };
		{ GREY.."29) "..BabbleSubZone["Ulduar"]..", ".._RED..BabbleZone["The Storm Peaks"], ZONE, 67 };
		{ GREY.."30) "..BabbleSubZone["Dun Niffelem"]..", ".._RED..BabbleZone["The Storm Peaks"], ZONE, 67 };
		{ GREY.."31) "..BabbleSubZone["The Argent Vanguard"]..", ".._RED..BabbleZone["Icecrown"], ZONE, 210 };
		{ GREY.."32) "..BabbleSubZone["Crusaders' Pinnacle"]..", ".._RED..BabbleZone["Icecrown"], ZONE, 210 };
		{ GREY.."33) "..BabbleSubZone["Argent Tournament Grounds"]..", ".._RED..BabbleZone["Icecrown"], ZONE, 210 };
		{ GREY.."34) "..BabbleSubZone["The Shadow Vault"]..", ".._RED..BabbleZone["Icecrown"], ZONE, 210 };
		{ GREY.."35) "..BabbleSubZone["Death's Rise"]..", ".._RED..BabbleZone["Icecrown"], ZONE, 210 };
		{ GREY.."36) "..BabbleSubZone["Valiance Landing Camp"]..", ".._RED..BabbleZone["Wintergrasp"], ZONE, 4197 };
	};
	TransHordeNorthrend = {
		ZoneName = { BabbleZone["Northrend"].." ("..AtlasTransLocale["Horde"]..")" };
		{ BLUE.."A) "..BabbleZone["Orgrimmar"]..", ".._RED..BabbleZone["Durotar"], ZONE, 14 };
		{ BLUE.."B) "..BabbleZone["Undercity"]..", ".._RED..BabbleZone["Tirisfal Glades"], ZONE, 85 };
		{ BLUE.."C) "..BabbleZone["Orgrimmar"]..", ".._RED..BabbleZone["Durotar"], ZONE, 14 };
		{ BLUE..INDENT..BabbleZone["Silvermoon City"]..", ".._RED..BabbleZone["Eversong Woods"], ZONE, 3430 };
		{ BLUE..INDENT..BabbleZone["Undercity"]..", ".._RED..BabbleZone["Tirisfal Glades"], ZONE, 85 };
		{ BLUE..INDENT..BabbleZone["Thunder Bluff"]..", ".._RED..BabbleZone["Mulgore"], ZONE, 215 };
		{ BLUE..INDENT..BabbleZone["Shattrath City"]..", ".._RED..BabbleZone["Terokkar Forest"], ZONE, 3519 };
		{ BLUE..INDENT..BabbleSubZone["Caverns of Time"]..", ".._RED..BabbleZone["Tanaris"], ZONE, 440 };
		{ GREY.."1) "..BabbleSubZone["Warsong Hold"]..", ".._RED..BabbleZone["Borean Tundra"], ZONE, 3537 };
		{ GREY.."2) "..BabbleSubZone["Amber Ledge"]..", ".._RED..BabbleZone["Borean Tundra"], ZONE, 3537 };
		{ GREY.."3) "..BabbleSubZone["Transitus Shield"]..", ".._RED..BabbleZone["Coldarra"], ZONE, 3537 };
		{ GREY.."4) "..BabbleSubZone["Bor'gorok Outpost"]..", ".._RED..BabbleZone["Borean Tundra"], ZONE, 3537 };
		{ GREY.."5) "..BabbleSubZone["Taunka'le Village"]..", ".._RED..BabbleZone["Borean Tundra"], ZONE, 3537 };
		{ GREY.."6) "..BabbleSubZone["Unu'pe"]..", ".._RED..BabbleZone["Borean Tundra"], ZONE, 3537 };
		{ GREY.."7) "..BabbleSubZone["Nesingwary Base Camp"]..", ".._RED..BabbleZone["Sholazar Basin"], ZONE, 3711 };
		{ GREY.."8) "..BabbleSubZone["River's Heart"]..", ".._RED..BabbleZone["Sholazar Basin"], ZONE, 3711 };
		{ GREY.."9) "..BabbleSubZone["Agmar's Hammer"]..", ".._RED..BabbleZone["Dragonblight"], ZONE, 65 };
		{ GREY.."10) "..BabbleSubZone["Moa'ki Harbor"]..", ".._RED..BabbleZone["Dragonblight"], ZONE, 65 };
		{ GREY.."11) "..BabbleSubZone["Kor'kron Vanguard"]..", ".._RED..BabbleZone["Dragonblight"], ZONE, 65 };
		{ GREY.."12) "..BabbleSubZone["Wyrmrest Temple"]..", ".._RED..BabbleZone["Dragonblight"], ZONE, 65 };
		{ GREY.."13) "..BabbleSubZone["Venomspite"]..", ".._RED..BabbleZone["Dragonblight"], ZONE, 65 };
		{ GREY.."14) "..BabbleSubZone["Kamagua"]..", ".._RED..BabbleZone["Howling Fjord"], ZONE, 495 };
		{ GREY.."15) "..BabbleSubZone["New Agamand"]..", ".._RED..BabbleZone["Howling Fjord"], ZONE, 495 };
		{ GREY.."16) "..BabbleSubZone["Vengeance Landing"]..", ".._RED..BabbleZone["Howling Fjord"], ZONE, 495 };
		{ GREY.."17) "..BabbleSubZone["Apothecary Camp"]..", ".._RED..BabbleZone["Howling Fjord"], ZONE, 495 };
		{ GREY.."18) "..BabbleSubZone["Camp Winterhoof"]..", ".._RED..BabbleZone["Howling Fjord"], ZONE, 495 };
		{ GREY.."19) "..BabbleSubZone["Conquest Hold"]..", ".._RED..BabbleZone["Grizzly Hills"], ZONE, 394 };
		{ GREY.."20) "..BabbleSubZone["Camp Oneqwah"]..", ".._RED..BabbleZone["Grizzly Hills"], ZONE, 394 };
		{ GREY.."21) "..BabbleSubZone["Gundrak"]..", ".._RED..BabbleZone["Zul'Drak"], ZONE, 66 };
		{ GREY.."22) "..BabbleSubZone["Zim'Torga"]..", ".._RED..BabbleZone["Zul'Drak"], ZONE, 66 };
		{ GREY.."23) "..BabbleSubZone["The Argent Stand"]..", ".._RED..BabbleZone["Zul'Drak"], ZONE, 66 };
		{ GREY.."24) "..BabbleSubZone["Light's Breach"]..", ".._RED..BabbleZone["Zul'Drak"], ZONE, 66 };
		{ GREY.."25) "..BabbleSubZone["Ebon Watch"]..", ".._RED..BabbleZone["Zul'Drak"], ZONE, 66 };
		{ GREY.."26) "..BabbleSubZone["Sunreaver's Command"]..", ".._RED..BabbleZone["Crystalsong Forest"], ZONE, 2817 };
		{ GREY.."27) "..BabbleZone["Dalaran"]..", ".._RED..BabbleZone["Crystalsong Forest"], ZONE, 2817 };
		{ GREY.."28) "..BabbleSubZone["K3"]..", ".._RED..BabbleZone["The Storm Peaks"], ZONE, 67 };
		{ GREY.."29) "..BabbleSubZone["Camp Tunka'lo"]..", ".._RED..BabbleZone["The Storm Peaks"], ZONE, 67 };
		{ GREY.."30) "..BabbleSubZone["Grom'arsh Crash-Site"]..", ".._RED..BabbleZone["The Storm Peaks"], ZONE, 67 };
		{ GREY.."31) "..BabbleSubZone["Bouldercrag's Refuge"]..", ".._RED..BabbleZone["The Storm Peaks"], ZONE, 67 };
		{ GREY.."32) "..BabbleSubZone["Ulduar"]..", ".._RED..BabbleZone["The Storm Peaks"], ZONE, 67 };
		{ GREY.."33) "..BabbleSubZone["Dun Niffelem"]..", ".._RED..BabbleZone["The Storm Peaks"], ZONE, 67 };
		{ GREY.."34) "..BabbleSubZone["The Argent Vanguard"]..", ".._RED..BabbleZone["Icecrown"], ZONE, 210 };
		{ GREY.."35) "..BabbleSubZone["Crusaders' Pinnacle"]..", ".._RED..BabbleZone["Icecrown"], ZONE, 210 };
		{ GREY.."36) "..BabbleSubZone["Argent Tournament Grounds"]..", ".._RED..BabbleZone["Icecrown"], ZONE, 210 };
		{ GREY.."37) "..BabbleSubZone["The Shadow Vault"]..", ".._RED..BabbleZone["Icecrown"], ZONE, 210 };
		{ GREY.."38) "..BabbleSubZone["Death's Rise"]..", ".._RED..BabbleZone["Icecrown"], ZONE, 210 };
		{ GREY.."39) "..BabbleSubZone["Warsong Landing Camp"]..", ".._RED..BabbleZone["Wintergrasp"], ZONE, 4197 };
	};
};

Atlas_RegisterPlugin("Atlas_Transportation", myCategory, myData);
