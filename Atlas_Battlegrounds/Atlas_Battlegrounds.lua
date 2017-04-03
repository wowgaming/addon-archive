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

local myCategory = AtlasBGLocale["Battleground Maps"];

local myData = {
	AlteracValleyNorth = {
		ZoneName = { BabbleZone["Alterac Valley"].." ("..AtlasBGLocale["North"]..", "..AtlasBGLocale["Alliance"]..")", 2597 };
		Location = { BabbleZone["Alterac Mountains"], 36 };
		LevelRange = "51-60 / 61-70 / 71-79 / 80";
		MinLevel = "51";
		PlayerLimit = "40";
		Acronym = AtlasBGLocale["AV"];
		{ ORNG..AtlasBGLocale["Reputation"]..": "..AtlasBGLocale["Stormpike Guard"], FACTION, 730 };
		{ BLUE.."A) "..AtlasBGLocale["Entrance"] };
		{ BLUE.."B) "..BabbleSubZone["Dun Baldar"] };
		{ BLUE..INDENT..AtlasBGLocale["Vanndar Stormpike <Stormpike General>"], NPC, 11948 };
		{ BLUE..INDENT..AtlasBGLocale["Dun Baldar North Marshal"], NPC, 14762 };
		{ BLUE..INDENT..AtlasBGLocale["Dun Baldar South Marshal"], NPC, 14763 };
		{ BLUE..INDENT..AtlasBGLocale["Icewing Marshal"], NPC, 14764 };
		{ BLUE..INDENT..AtlasBGLocale["Stonehearth Marshal"], NPC, 14765 };
		{ BLUE..INDENT..AtlasBGLocale["Prospector Stonehewer"], NPC, 13816 };
		{ _RED.."1) "..BabbleSubZone["Irondeep Mine"] };
		{ GREY..INDENT..AtlasBGLocale["Morloch"].." ("..AtlasBGLocale["Neutral"]..")", NPC, 11657 };
		{ GREY..INDENT..AtlasBGLocale["Umi Thorson"], NPC, 13078 };
		{ GREY..INDENT..AtlasBGLocale["Keetar"].." ("..AtlasBGLocale["Horde"]..")", NPC, 13079 };
		{ GREY.."2) "..AtlasBGLocale["Arch Druid Renferal"], NPC, 13442 };
		{ ORNG.."3) "..AtlasBGLocale["Dun Baldar North Bunker"] };
		{ GREY..INDENT..AtlasBGLocale["Wing Commander Mulverick"].." ("..AtlasBGLocale["Horde"]..")", NPC, 13181 };
		{ GREY.."4) "..AtlasBGLocale["Murgot Deepforge"], NPC, 13257 };
		{ GREY..INDENT..AtlasBGLocale["Dirk Swindle <Bounty Hunter>"], NPC, 14188 };
		{ GREY..INDENT..AtlasBGLocale["Athramanis <Bounty Hunter>"], NPC, 14187 };
		{ GREY..INDENT..AtlasBGLocale["Lana Thunderbrew <Blacksmithing Supplies>"], NPC, 4257 };
		{ _RED.."5) "..AtlasBGLocale["Stormpike Aid Station"] };
		{ GREY.."6) "..AtlasBGLocale["Stormpike Stable Master <Stable Master>"], NPC, 13617 };
		{ GREY..INDENT..AtlasBGLocale["Stormpike Ram Rider Commander"], NPC, 13577 };
		{ GREY..INDENT..AtlasBGLocale["Svalbrad Farmountain <Trade Goods>"], NPC, 5135 };
		{ GREY..INDENT..AtlasBGLocale["Kurdrum Barleybeard <Reagents & Poison Supplies>"], NPC, 5139 };
		{ GREY.."7) "..AtlasBGLocale["Stormpike Quartermaster"], NPC, 12096 };
		{ GREY..INDENT..AtlasBGLocale["Jonivera Farmountain <General Goods>"], NPC, 5134 };
		{ GREY..INDENT..AtlasBGLocale["Brogus Thunderbrew <Food & Drink>"], NPC, 4255 };
		{ GREY.."8) "..AtlasBGLocale["Wing Commander Ichman"].." ("..AtlasBGLocale["Rescued"]..")", NPC, 13437 };
		{ GREY..INDENT..AtlasBGLocale["Wing Commander Slidore"].." ("..AtlasBGLocale["Rescued"]..")", NPC, 13438 };
		{ GREY..INDENT..AtlasBGLocale["Wing Commander Vipore"].." ("..AtlasBGLocale["Rescued"]..")", NPC, 13439 };
		{ ORNG.."9) "..AtlasBGLocale["Dun Baldar South Bunker"] };
		{ GREY..INDENT..AtlasBGLocale["Corporal Noreg Stormpike"], NPC, 13447 };
		{ GREY..INDENT..AtlasBGLocale["Gaelden Hammersmith <Stormpike Supply Officer>"], NPC, 13216 };
		{ _RED.."10) "..BabbleSubZone["Stormpike Graveyard"] };
		{ GREY.."11) "..BabbleSubZone["Icewing Cavern"] };
		{ GREY..INDENT..AtlasBGLocale["Stormpike Banner"], OBJECT, 179024 };
		{ GREY.."12) "..AtlasBGLocale["Stormpike Lumber Yard"] };
		{ GREY..INDENT..AtlasBGLocale["Wing Commander Jeztor"].." ("..AtlasBGLocale["Horde"]..")", NPC, 13180 };
		{ ORNG.."13) "..BabbleSubZone["Icewing Bunker"] };
		{ GREY..INDENT..AtlasBGLocale["Wing Commander Guse"].." ("..AtlasBGLocale["Horde"]..")", NPC, 13179 };
		{ _RED.."14) "..BabbleSubZone["Stonehearth Graveyard"] };
		{ GREY.."15) "..AtlasBGLocale["Stormpike Ram Rider Commander"], NPC, 13577 };
		{ ORNG.."16) "..BabbleSubZone["Stonehearth Outpost"] };
		{ GREY..INDENT..AtlasBGLocale["Captain Balinda Stonehearth <Stormpike Captain>"], NPC, 11949 };
		{ _RED.."17) "..BabbleSubZone["Snowfall Graveyard"] };
		{ GREY..INDENT..AtlasBGLocale["Ichman's Beacon"], ITEM, 17505 };
		{ GREY..INDENT..AtlasBGLocale["Mulverick's Beacon"].." ("..AtlasBGLocale["Horde"]..")", ITEM, 17323 };
		{ ORNG.."18) "..BabbleSubZone["Stonehearth Bunker"] };
		{ GREY.."19) "..AtlasBGLocale["Ivus the Forest Lord"].." ("..AtlasBGLocale["Summon"]..")", NPC, 13419 };
		{ GREY.."20) "..AtlasBGLocale["Western Crater"] };
		{ GREY..INDENT..AtlasBGLocale["Vipore's Beacon"], ITEM, 17506 };
		{ GREY..INDENT..AtlasBGLocale["Jeztor's Beacon"].." ("..AtlasBGLocale["Horde"]..")", ITEM, 17325 };
		{ GREY.."21) "..AtlasBGLocale["Eastern Crater"] };
		{ GREY..INDENT..AtlasBGLocale["Slidore's Beacon"], ITEM, 17507 };
		{ GREY..INDENT..AtlasBGLocale["Guse's Beacon"].." ("..AtlasBGLocale["Horde"]..")", ITEM, 17324 };
		{ "" };
		{ _RED..AtlasBGLocale["Red"]..": "..BLUE..AtlasBGLocale["Graveyards, Capturable Areas"] };
		{ ORNG..AtlasBGLocale["Orange"]..": "..BLUE..AtlasBGLocale["Bunkers, Towers, Destroyable Areas"] };
		{ GREY..AtlasBGLocale["White"]..": "..BLUE..AtlasBGLocale["Assault NPCs, Quest Areas"] };
	};
	AlteracValleySouth = {
		ZoneName = { BabbleZone["Alterac Valley"].." ("..AtlasBGLocale["South"]..", "..AtlasBGLocale["Horde"]..")", 2597 };
		Location = { BabbleZone["Hillsbrad Foothills"], 36 };
		LevelRange = "51-60 / 61-70 / 71-79 / 80";
		MinLevel = "51";
		PlayerLimit = "40";
		Acronym = AtlasBGLocale["AV"];
		{ ORNG..AtlasBGLocale["Reputation"]..": "..AtlasBGLocale["Frostwolf Clan"], FACTION, 729 };
		{ BLUE.."A) "..AtlasBGLocale["Entrance"].." ("..AtlasBGLocale["Horde"]..")" };
		{ BLUE.."B) "..BabbleSubZone["Frostwolf Keep"] };
		{ BLUE..INDENT..AtlasBGLocale["Drek'Thar <Frostwolf General>"], NPC, 11946 };
		{ BLUE..INDENT..AtlasBGLocale["Duros"], NPC, 12122 };
		{ BLUE..INDENT..AtlasBGLocale["Drakan"], NPC, 12121 };
		{ BLUE..INDENT..AtlasBGLocale["West Frostwolf Warmaster"], NPC, 14777 };
		{ BLUE..INDENT..AtlasBGLocale["East Frostwolf Warmaster"], NPC, 14772 };
		{ BLUE..INDENT..AtlasBGLocale["Tower Point Warmaster"], NPC, 14776 };
		{ BLUE..INDENT..AtlasBGLocale["Iceblood Warmaster"], NPC, 14773 };
		{ _RED.."1) "..AtlasBGLocale["Lokholar the Ice Lord"].." ("..AtlasBGLocale["Summon"]..")", NPC, 13256 };
		{ ORNG.."2) "..BabbleSubZone["Iceblood Garrison"] };
		{ GREY..INDENT..AtlasBGLocale["Captain Galvangar <Frostwolf Captain>"], NPC, 11947 };
		{ ORNG.."3) "..AtlasBGLocale["Iceblood Tower"] };
		{ _RED.."4) "..BabbleSubZone["Iceblood Graveyard"] };
		{ ORNG.."5) "..AtlasBGLocale["Tower Point"] };
		{ GREY..INDENT..AtlasBGLocale["Wing Commander Slidore"].." ("..AtlasBGLocale["Alliance"]..")", NPC, 13438 };
		{ _RED.."6) "..BabbleSubZone["Coldtooth Mine"] };
		{ GREY..INDENT..AtlasBGLocale["Taskmaster Snivvle"].." ("..AtlasBGLocale["Neutral"]..")", NPC, 11677 };
		{ GREY..INDENT..AtlasBGLocale["Masha Swiftcut"], NPC, 13088 };
		{ GREY..INDENT..AtlasBGLocale["Aggi Rumblestomp"].." ("..AtlasBGLocale["Alliance"]..")", NPC, 13086 };
		{ _RED.."7) "..BabbleSubZone["Frostwolf Graveyard"] };
		{ GREY.."8) "..AtlasBGLocale["Wing Commander Vipore"].." ("..AtlasBGLocale["Alliance"]..")", NPC, 13439 };
		{ GREY..INDENT..AtlasBGLocale["Jotek"], NPC, 13798 };
		{ GREY..INDENT..AtlasBGLocale["Smith Regzar"], NPC, 13176 };
		{ GREY..INDENT..AtlasBGLocale["Primalist Thurloga"], NPC, 13236 };
		{ GREY..INDENT..AtlasBGLocale["Sergeant Yazra Bloodsnarl"], NPC, 13448 };
		{ GREY.."9) "..AtlasBGLocale["Frostwolf Stable Master <Stable Master>"], NPC, 13616 };
		{ GREY..INDENT..AtlasBGLocale["Frostwolf Wolf Rider Commander"], NPC, 13441 };
		{ GREY.."10) "..AtlasBGLocale["Frostwolf Quartermaster"], NPC, 12097 };
		{ ORNG.."11) "..AtlasBGLocale["West Frostwolf Tower"] };
		{ GREY..INDENT..AtlasBGLocale["Wing Commander Ichman"].." ("..AtlasBGLocale["Alliance"]..")", NPC, 13437 };
		{ ORNG.."12) "..AtlasBGLocale["East Frostwolf Tower"] };
		{ GREY.."13) "..AtlasBGLocale["Wing Commander Guse"].." ("..AtlasBGLocale["Rescued"]..")", NPC, 13179 };
		{ GREY..INDENT..AtlasBGLocale["Wing Commander Jeztor"].." ("..AtlasBGLocale["Rescued"]..")", NPC, 13180 };
		{ GREY..INDENT..AtlasBGLocale["Wing Commander Mulverick"].." ("..AtlasBGLocale["Rescued"]..")", NPC, 13181 };
		{ _RED.."14) "..AtlasBGLocale["Frostwolf Relief Hut"] };
		{ GREY.."15) "..BabbleSubZone["Wildpaw Cavern"] };
		{ GREY..INDENT..AtlasBGLocale["Frostwolf Banner"], OBJECT, 179025 };
		{ "" };
		{ _RED..AtlasBGLocale["Red"]..": "..BLUE..AtlasBGLocale["Graveyards, Capturable Areas"] };
		{ ORNG..AtlasBGLocale["Orange"]..": "..BLUE..AtlasBGLocale["Bunkers, Towers, Destroyable Areas"] };
		{ GREY..AtlasBGLocale["White"]..": "..BLUE..AtlasBGLocale["Assault NPCs, Quest Areas"] };
	};
	ArathiBasin = {
		ZoneName = { BabbleZone["Arathi Basin"], 3358 };
		Location = { BabbleZone["Arathi Highlands"], 45 };
		LevelRange = "20-29 / 30-39 / 40-49 / 50-59 / 60-69 / 70-79 / 80";
		MinLevel = "20";
		PlayerLimit = "15";
		Acronym = AtlasBGLocale["AB"];
		{ ORNG..AtlasBGLocale["Reputation"]..": "..AtlasBGLocale["The Defilers"].." ("..AtlasBGLocale["Horde"]..")", FACTION, 510 };
		{ ORNG..AtlasBGLocale["Reputation"]..": "..AtlasBGLocale["The League of Arathor"].." ("..AtlasBGLocale["Alliance"]..")", FACTION, 509 };
		{ BLUE.."A) "..BabbleSubZone["Trollbane Hall"].." ("..AtlasBGLocale["Alliance"]..")" };
		{ BLUE.."B) "..BabbleSubZone["Defiler's Den"].." ("..AtlasBGLocale["Horde"]..")" };
		{ GREY.."1) "..BabbleSubZone["Stables"] };
		{ GREY.."2) "..BabbleSubZone["Gold Mine"] };
		{ GREY.."3) "..BabbleSubZone["Blacksmith"] };
		{ GREY.."4) "..BabbleSubZone["Lumber Mill"] };
		{ GREY.."5) "..BabbleSubZone["Farm"] };
	};
	WarsongGulch = {
		ZoneName = { BabbleZone["Warsong Gulch"], 3277 };
		Location = { BabbleZone["Ashenvale"].." / "..BabbleZone["The Barrens"], 331, 17 };
		LevelRange = "10-19 / 20-29 / 30-39 / 40-49 / 50-59 / 60-69 / 70-79 / 80";
		MinLevel = "10";
		PlayerLimit = "10";
		Acronym = AtlasBGLocale["WSG"];
		{ ORNG..AtlasBGLocale["Reputation"]..": "..AtlasBGLocale["Warsong Outriders"].." ("..AtlasBGLocale["Horde"]..")", FACTION, 889 };
		{ ORNG..AtlasBGLocale["Reputation"]..": "..AtlasBGLocale["Silverwing Sentinels"].." ("..AtlasBGLocale["Alliance"]..")", FACTION, 890 };
		{ BLUE.."A) "..BabbleSubZone["Silverwing Hold"].." ("..AtlasBGLocale["Alliance"]..")" };
		{ BLUE.."B) "..BabbleSubZone["Warsong Lumber Mill"].." ("..AtlasBGLocale["Horde"]..")" };
	};
	EyeOfTheStorm = {
		ZoneName = { AtlasBGLocale["Eye of the Storm"], 3820 };
		Location = { BabbleZone["Netherstorm"], 3523 };
		LevelRange = "61-69 / 70-79 / 80";
		MinLevel = "61";
		PlayerLimit = "15";
		Acronym = AtlasBGLocale["EotS"];
		{ BLUE.."A) "..AtlasBGLocale["Entrance"].." ("..AtlasBGLocale["Alliance"]..")" };
		{ BLUE.."B) "..AtlasBGLocale["Entrance"].." ("..AtlasBGLocale["Horde"]..")" };
		{ _RED.."X) "..BabbleZone["Graveyard"] };
		{ ORNG.."X) "..AtlasBGLocale["Flag"] };
		{ GREY.."1) "..BabbleSubZone["Mage Tower"] };
		{ GREY.."2) "..BabbleSubZone["Draenei Ruins"] };
		{ GREY.."3) "..BabbleSubZone["Fel Reaver Ruins"] };
		{ GREY.."4) "..BabbleSubZone["Blood Elf Tower"] };
	};
	StrandOfTheAncients = {
		ZoneName = { BabbleZone["Strand of the Ancients"], 4384 };
		Location = { BabbleZone["Dragonblight"], 65 };
		LevelRange = "71-79 / 80";
		MinLevel = "71";
		PlayerLimit = "15";
		Acronym = AtlasBGLocale["SotA"];
		{ ORNG..AtlasBGLocale["Gates are marked with their colors."] };
		{ BLUE.."A) "..AtlasBGLocale["Start"].." ("..AtlasBGLocale["Attacking Team"]..")" };
		{ BLUE.."B) "..AtlasBGLocale["Start"].." ("..AtlasBGLocale["Defending Team"]..")" };
		{ GREY.."1) "..AtlasBGLocale["Massive Seaforium Charge"], NPC, 21848 };
		{ GREY.."2) "..AtlasBGLocale["Battleground Demolisher"], NPC, 28781 };
		{ GREY.."3) "..AtlasBGLocale["Resurrection Point"] };
		{ GREY.."4) "..AtlasBGLocale["Graveyard Flag"] };
		{ GREY.."5) "..AtlasBGLocale["Titan Relic"], OBJECT, 192829 };
	};
	IsleOfConquest = {
		ZoneName = { BabbleZone["Isle of Conquest"], 4710 };
		Location = { BabbleZone["Icecrown"], 210 };
		LevelRange = "71-79 / 80";
		MinLevel = "71";
		PlayerLimit = "40";
		Acronym = AtlasBGLocale["IoC"];
		{ ORNG..AtlasBGLocale["Gates are marked with red bars."] };
		{ BLUE.."A) "..AtlasBGLocale["Start"].." ("..AtlasBGLocale["Horde"]..")" };
		{ BLUE..INDENT..AtlasBGLocale["Overlord Agmar"], NPC, 34922 };
		{ BLUE.."B) "..AtlasBGLocale["Start"].." ("..AtlasBGLocale["Alliance"]..")" };
		{ BLUE..INDENT..AtlasBGLocale["High Commander Halford Wyrmbane <7th Legion>"], NPC, 34924 };
		{ GREY.."1) "..AtlasBGLocale["The Refinery"] };
		{ GREY.."2) "..AtlasBGLocale["The Docks"] };
		{ GREY.."3) "..AtlasBGLocale["The Workshop"] };
		{ GREY.."4) "..AtlasBGLocale["The Hangar"] };
		{ GREY.."5) "..AtlasBGLocale["The Quarry"] };
		{ GREN.."1') "..AtlasBGLocale["Contested Graveyards"] };
		{ GREN.."2') "..AtlasBGLocale["Horde Graveyard"] };
		{ GREN.."3') "..AtlasBGLocale["Alliance Graveyard"] };
	};
	-- Hellfire Peninsula PvP 
	HellfirePeninsulaPvP = {
		ZoneName = { BabbleZone["Hellfire Peninsula"].." - "..AtlasBGLocale["Hellfire Fortifications"] };
		Location = { BabbleZone["Hellfire Peninsula"], ZONE, 3483 };
		LevelRange = "58-80";
		MinLevel = "58";
		{ ORNG.."PvP: "..AtlasBGLocale["Hellfire Fortifications"] };
		{ "" };
		{ BLUE.."A) "..BabbleSubZone["The Stadium"], ZONE, 3669 };
		{ BLUE.."B) "..BabbleSubZone["The Overlook"], ZONE, 3670 };
		{ BLUE.."C) "..BabbleSubZone["Broken Hill"], ZONE, 3671 };
	};
	-- Zangarmarsh PvP
	ZangarmarshPvP = {
		ZoneName = { BabbleZone["Zangarmarsh"].." - "..BabbleSubZone["Twin Spire Ruins"] };
		Location = { BabbleZone["Zangarmarsh"], ZONE, 3521 };
		LevelRange = "60-80";
		MinLevel = "60";
		{ ORNG.."PvP: "..BabbleSubZone["Twin Spire Ruins"] };
		{ "" };
		{ BLUE.."A) "..AtlasBGLocale["West Beacon"] };
		{ BLUE.."B) "..AtlasBGLocale["East Beacon"] };
		{ GREN.."1') "..AtlasBGLocale["Twinspire Graveyard"] };
		{ "" };
		{ GREY..AtlasBGLocale["Alliance Field Scout"], NPC, 18581 };
		{ GREY..AtlasBGLocale["Horde Field Scout"], NPC, 18564 };
		
	};
	-- Halaa PvP
	HalaaPvP = {
		ZoneName = { BabbleZone["Nagrand"].." - "..BabbleSubZone["Halaa"] };
		Location = { BabbleZone["Nagrand"] };
		LevelRange = "64-80";
		MinLevel = "64";
		{ ORNG.."PvP: "..BabbleSubZone["Halaa"] };
		{ "" };
		{ GREN.."1') "..AtlasBGLocale["Wyvern Camp"] };
		{ "" };
		{ GREY.."1) "..AtlasBGLocale["Quartermaster Jaffrey Noreliqe"], NPC, 18821 };
		{ GREY.."2) "..AtlasBGLocale["Quartermaster Davian Vaclav"], NPC, 18822 };
		{ GREY.."3) "..AtlasBGLocale["Chief Researcher Amereldine"], NPC, 18816 };
		{ GREY.."4) "..AtlasBGLocale["Chief Researcher Kartos"], NPC, 18817 };
		{ GREY.."5) "..AtlasBGLocale["Aldraan <Blade Merchant>"], NPC, 21485 };
		{ GREY.."6) "..AtlasBGLocale["Banro <Ammunition>"], NPC, 21488 };
		{ GREY.."7) "..AtlasBGLocale["Cendrii <Food & Drink>"], NPC, 21487 };
		{ GREY.."8) "..AtlasBGLocale["Coreiel <Blade Merchant>"], NPC, 21474 };
		{ GREY.."9) "..AtlasBGLocale["Embelar <Food & Drink>"], NPC, 21484 };
		{ GREY.."10) "..AtlasBGLocale["Tasaldan <Ammunition>"], NPC, 21483 };
	};
	-- Terokkar Forest PvP
	TerokkarForestPvP = {
		ZoneName = { BabbleZone["Terokkar Forest"].." - "..AtlasBGLocale["Auchindoun Spirit Towers"] };
		Location = { BabbleSubZone["The Bone Wastes"]..", "..BabbleZone["Terokkar Forest"] };
		LevelRange = "62-80";
		MinLevel = "62";
		{ ORNG.."PvP: "..AtlasBGLocale["Auchindoun Spirit Towers"] };
	};
	-- Wintergrasp
	WintergraspPvP = {
		ZoneName = { BabbleZone["Wintergrasp"] };
--		Location = { BabbleZone["Wintergrasp"] };
		LevelRange = "73-80";
		MinLevel = "73";
		{ ORNG.."PvP: "..BabbleZone["Wintergrasp"] };
		{ "" };
		{ BLUE.."A) "..BabbleSubZone["Wintergrasp Fortress"] };
		{ BLUE..INDENT..BabbleZone["Vault of Archavon"] };
		{ BLUE.."B) "..BabbleSubZone["Valiance Landing Camp"] };
		{ BLUE.."C) "..BabbleSubZone["Warsong Landing Camp"] };
		{ ORNG.."1) "..BabbleSubZone["Wintergrasp Fortress"] };
		{ ORNG..INDENT..AtlasBGLocale["Fortress Vihecal Workshop (E)"] };
		{ ORNG..INDENT..AtlasBGLocale["Fortress Vihecal Workshop (W)"] };
		{ ORNG.."2) "..BabbleSubZone["The Sunken Ring"] };
		{ ORNG..INDENT..AtlasBGLocale["Sunken Ring Vihecal Workshop"] };
		{ ORNG.."3) "..BabbleSubZone["The Broken Temple"] };
		{ ORNG..INDENT..AtlasBGLocale["Broken Temple Vihecal Workshop"] };
		{ ORNG.."4) "..BabbleSubZone["Eastspark Workshop"] };
		{ ORNG..INDENT..AtlasBGLocale["Eastspark Vihecale Workshop"] };
		{ ORNG.."5) "..BabbleSubZone["Westspark Workshop"] };
		{ ORNG..INDENT..AtlasBGLocale["Westspark Vihecale Workshop"] };
		{ GREN.."6) "..BabbleSubZone["Flamewatch Tower"] };
		{ GREN.."7) "..BabbleSubZone["Winter's Edge Tower"] };
		{ GREN.."8) "..BabbleSubZone["Shadowsight Tower"] };
		{ GREY.."9) "..AtlasBGLocale["Wintergrasp Graveyard"] };
		{ GREY.."10) "..AtlasBGLocale["Sunken Ring Graveyard"] };
		{ GREY.."11) "..AtlasBGLocale["Broken Temple Graveyard"] };
		{ GREY.."12) "..AtlasBGLocale["Southeast Graveyard"] };
		{ GREY.."13) "..AtlasBGLocale["Southwest Graveyard"] };
	};
	-- Eastern Plaguelands - Game of Tower
	GameOfTower = {
		ZoneName = { BabbleZone["Eastern Plaguelands"].." - "..AtlasBGLocale["A Game of Towers"] };
--		Location = { BabbleZone["Eastern Plaguelands"] };
		LevelRange = "53-80";
		MinLevel = "53";
		{ ORNG.."PvP: "..AtlasBGLocale["A Game of Towers"] };
		{ "" };
		{ BLUE.."A) "..BabbleSubZone["Light's Hope Chapel"] };
		{ GREY.."1) "..BabbleSubZone["Crown Guard Tower"] };
		{ GREY.."2) "..BabbleSubZone["Eastwall Tower"] };
		{ GREY.."3) "..BabbleSubZone["Northpass Tower"] };
		{ GREY.."4) "..BabbleSubZone["Plaguewood Tower"] };
	};
	-- Silithus - The Silithyst Must Flow
	SilithystMustFlow = {
		ZoneName = { BabbleZone["Silithus"].." - "..AtlasBGLocale["The Silithyst Must Flow"] };
--		Location = { BabbleZone["Silithus"] };
		LevelRange = "55-80";
		MinLevel = "55";
		{ ORNG.."PvP: "..AtlasBGLocale["The Silithyst Must Flow"] };
		{ "" };
		{ BLUE.."A) "..BabbleSubZone["Cenarion Hold"] };
		{ GREY.."1) "..AtlasBGLocale["Alliance's Camp"] };
		{ GREY.."2) "..AtlasBGLocale["Horde's Camp"] };
	};
};

Atlas_RegisterPlugin("Atlas_Battlegrounds", myCategory, myData);
