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

-- Atlas Localization Data (Chinese)
-- Initial translation by DiabloHu
-- Version : Chinese (by DiabloHu)
-- $Date: 2010-08-01 20:29:57 +0930 (Sun, 01 Aug 2010) $
-- $Revision: 945 $
-- http://ngacn.cc


if ( GetLocale() == "zhCN" ) then

AtlasBGLocale = {

	--Common
	["Alliance"] = "联盟";
	["Battleground Maps"] = "战场地图";
	["Entrance"] = "入口";
	["Horde"] = "部落";
	["Neutral"] = "中立";
	["North"] = "北部";
	["Orange"] = "橙色";
	["Red"] = "红色";
	["Reputation"] = "阵营";
	["Rescued"] = "被营救";
	["South"] = "南部";
	["Start"] = "起始点";
	["Summon"] = "召唤";
	["White"] = "白色";

	--Places
	["AV"] = "AV"; -- Alterac Valley
	["AB"] = "AB"; -- Arathi Basin
	["Eye of the Storm"] = "风暴之眼"; ["EotS"] = "EotS";
	["IoC"] = "IoC"; -- Isle of Conquest
	["SotA"] = "SotA"; -- Strand of the Ancients
	["WSG"] = "WSG"; -- Warsong Gulch

	--Alterac Valley (North)
	["Stormpike Guard"] = "雷矛卫队";
	["Vanndar Stormpike <Stormpike General>"] = "范达尔·雷矛 <雷矛将军>";
	["Dun Baldar North Marshal"] = "丹巴达尔北部统帅";
	["Dun Baldar South Marshal"] = "丹巴达尔南部统帅";
	["Icewing Marshal"] = "冰翼统帅";
	["Stonehearth Marshal"] = "石炉统帅";
	["Prospector Stonehewer"] = "勘查员塔雷·石镐";
	["Morloch"] = "莫洛克";
	["Umi Thorson"] = "乌米·索尔森";
	["Keetar"] = "基塔尔";
	["Arch Druid Renferal"] = "大德鲁伊雷弗拉尔";
	["Dun Baldar North Bunker"] = "丹巴达尔北部碉堡";
	["Wing Commander Mulverick"] = "空军指挥官穆维里克";--omitted from AVS
	["Murgot Deepforge"] = "莫高特·深炉";
	["Dirk Swindle <Bounty Hunter>"] = "德尔克 <赏金猎人>";
	["Athramanis <Bounty Hunter>"] = "亚斯拉玛尼斯 <赏金猎人>";
	["Lana Thunderbrew <Blacksmithing Supplies>"] = "兰纳·雷酒 <锻造供应商>";
	["Stormpike Aid Station"] = "雷矛急救站";
	["Stormpike Stable Master <Stable Master>"] = "雷矛兽栏管理员 <兽栏管理员>";
	["Stormpike Ram Rider Commander"] = "雷矛山羊骑兵指挥官";
	["Svalbrad Farmountain <Trade Goods>"] = "斯瓦尔布莱德·远山 <商人>";
	["Kurdrum Barleybeard <Reagents & Poison Supplies>"] = "库德拉姆·麦须 <毒药和材料>";
	["Stormpike Quartermaster"] = "雷矛军需官";
	["Jonivera Farmountain <General Goods>"] = "约尼维拉·远山 <杂货商>";
	["Brogus Thunderbrew <Food & Drink>"] = "布罗古斯·雷酒 <食物和饮料>";
	["Wing Commander Ichman"] = "空军指挥官艾克曼";--omitted from AVS
	["Wing Commander Slidore"] = "空军指挥官斯里多尔";--omitted from AVS
	["Wing Commander Vipore"] = "空军指挥官维波里";--omitted from AVS
	["Dun Baldar South Bunker"] = "丹巴达尔南部碉堡";
	["Corporal Noreg Stormpike"] = "诺雷格·雷矛中尉";
	["Gaelden Hammersmith <Stormpike Supply Officer>"] = "盖尔丁 <雷矛军需官>";
	["Stormpike Banner"] = "雷矛军旗";
	["Stormpike Lumber Yard"] = "雷矛伐木场";
	["Wing Commander Jeztor"] = "空军指挥官杰斯托";--omitted from AVS
	["Wing Commander Guse"] = "空军指挥官古斯";--omitted from AVS
	["Stormpike Ram Rider Commander"] = "雷矛山羊骑兵指挥官";
	["Captain Balinda Stonehearth <Stormpike Captain>"] = "巴琳达·斯通赫尔斯 <雷矛上尉>";
	["Ichman's Beacon"] = "艾克曼的信号灯";
	["Mulverick's Beacon"] = "穆维里克的信号灯";
	["Ivus the Forest Lord"] = "森林之王伊弗斯";
	["Western Crater"] = "西部平原";
	["Vipore's Beacon"] = "维波里的信号灯";
	["Jeztor's Beacon"] = "杰斯托的信号灯";
	["Eastern Crater"] = "东部平原";
	["Slidore's Beacon"] = "斯里多尔的信号灯";
	["Guse's Beacon"] = "古斯的信号灯";
	["Graveyards, Capturable Areas"] = "墓地, 可占领区域";--omitted from AVS
	["Bunkers, Towers, Destroyable Areas"] = "碉堡, 哨塔, 可摧毁区域";--omitted from AVS
	["Assault NPCs, Quest Areas"] = "相关NPC, 任务区域";--omitted from AVS

	--Alterac Valley (South)
	["Frostwolf Clan"] = "霜狼氏族";
	["Drek'Thar <Frostwolf General>"] = "德雷克塔尔 <霜狼将军>";
	["Duros"] = "杜洛斯";
	["Drakan"] = "德拉卡";
	["West Frostwolf Warmaster"] = "霜狼西部将领";
	["East Frostwolf Warmaster"] = "东部霜狼将领";
	["Tower Point Warmaster"] = "哨塔高地将领";
	["Iceblood Warmaster"] = "冰血将领";
	["Lokholar the Ice Lord"] = "冰雪之王洛克霍拉";
	["Captain Galvangar <Frostwolf Captain>"] = "加尔范上尉 <霜狼上尉>";
	["Iceblood Tower"] = "冰血哨塔";
	["Tower Point"] = "哨塔高地";
	["Taskmaster Snivvle"] = "工头斯尼维尔";
	["Masha Swiftcut"] = "玛莎";
	["Aggi Rumblestomp"] = "埃其";
	["Jotek"] = "乔泰克";
	["Smith Regzar"] = "铁匠雷格萨";
	["Primalist Thurloga"] = "指挥官瑟鲁加";
	["Sergeant Yazra Bloodsnarl"] = "亚斯拉·血矛";
	["Frostwolf Stable Master <Stable Master>"] = "霜狼兽栏管理员 <兽栏管理员>";
	["Frostwolf Wolf Rider Commander"] = "霜狼骑兵指挥官";
	["Frostwolf Quartermaster"] = "霜狼军需官";
	["West Frostwolf Tower"] = "西部霜狼哨塔";
	["East Frostwolf Tower"] = "东部霜狼哨塔";
	["Frostwolf Relief Hut"] = "霜狼急救站";
	["Frostwolf Banner"] = "霜狼军旗";

	--Arathi Basin
	["The Defilers"] = "污染者";
	["The League of Arathor"] = "阿拉索联军";

	--Eye of the Storm
	["Flag"] = "旗帜";

	--Isle of Conquest
	["The Refinery"] = "精炼厂";
	["The Docks"] = "码头";
	["The Workshop"] = "工坊";
	["The Hangar"] = "机棚";
	["The Quarry"] = "矿场";
	["Contested Graveyards"] = "争夺中的墓地";
	["Horde Graveyard"] = "部落墓地";
	["Alliance Graveyard"] = "联盟墓地";
	["Gates are marked with red bars."] = "闸门以红条标记.";
	["Overlord Agmar"] = "霸主阿格玛";
	["High Commander Halford Wyrmbane <7th Legion>"] = "最高指挥官海弗德•龙祸";

	--Strand of the Ancients
	["Attacking Team"] = "进攻方";
	["Defending Team"] = "防守方";
	["Massive Seaforium Charge"] = "大型爆盐炸弹";
	["Battleground Demolisher"] = "战场攻城车";
	["Resurrection Point"] = "复活点";
	["Graveyard Flag"] = "墓地旗帜";
	["Titan Relic"] = "泰坦圣物";
	["Gates are marked with their colors."] = "大门以其颜色进行了标记。";

	--Warsong Gulch
	["Warsong Outriders"] = "战歌侦察骑兵";
	["Silverwing Sentinels"] = "银翼要塞";

	-- Hellfire Peninsula PvP 
	["Hellfire Fortifications"] = "防御工事";
	
	-- Zangarmarsh PvP
	["West Beacon"] = "West Beacon"; -- Need translation
	["East Beacon"] = "East Beacon"; -- Need translation
	["Twinspire Graveyard"] = "Twinspire Graveyard"; -- Need translation
	["Alliance Field Scout"] = "Alliance Field Scout"; -- Need translation
	["Horde Field Scout"] = "Horde Field Scout"; -- Need translation
	
	-- Terokkar Forest PvP
	["Auchindoun Spirit Towers"] = "Auchindoun Spirit Towers"; -- Need translation

	-- Halaa
	["Wyvern Camp"] = "Wyvern Camp"; -- Need translation
	["Quartermaster Jaffrey Noreliqe"] = "Quartermaster Jaffrey Noreliqe"; -- Need translation
	["Quartermaster Davian Vaclav"] = "Quartermaster Davian Vaclav"; -- Need translation
	["Chief Researcher Amereldine"] = "Chief Researcher Amereldine"; -- Need translation
	["Chief Researcher Kartos"] = "Chief Researcher Kartos"; -- Need translation
	["Aldraan <Blade Merchant>"] = "Aldraan <Blade Merchant>"; -- Need translation
	["Banro <Ammunition>"] = "Banro <Ammunition>"; -- Need translation
	["Cendrii <Food & Drink>"] = "Cendrii <Food & Drink>"; -- Need translation
	["Coreiel <Blade Merchant>"] = "Coreiel <Blade Merchant>"; -- Need translation
	["Embelar <Food & Drink>"] = "Embelar <Food & Drink>"; -- Need translation
	["Tasaldan <Ammunition>"] = "Tasaldan <Ammunition>"; -- Need translation

	-- Wintergrasp
	["Fortress Vihecal Workshop (E)"] = "Fortress Vihecal Workshop (E)"; -- Need translation
	["Fortress Vihecal Workshop (W)"] = "Fortress Vihecal Workshop (W)"; -- Need translation
	["Sunken Ring Vihecal Workshop"] = "Sunken Ring Vihecal Workshop"; -- Need translation
	["Broken Temple Vihecal Workshop"] = "Broken Temple Vihecal Workshop"; -- Need translation
	["Eastspark Vihecale Workshop"] = "Eastspark Vihecale Workshop"; -- Need translation
	["Westspark Vihecale Workshop"] = "Westspark Vihecale Workshop"; -- Need translation
	["Wintergrasp Graveyard"] = "Wintergrasp Graveyard"; -- Need translation
	["Sunken Ring Graveyard"] = "Sunken Ring Graveyard"; -- Need translation
	["Broken Temple Graveyard"] = "Broken Temple Graveyard"; -- Need translation
	["Southeast Graveyard"] = "Southeast Graveyard"; -- Need translation
	["Southwest Graveyard"] = "Southwest Graveyard"; -- Need translation

	-- Eastern Plaguelands - Game of Tower
	["A Game of Towers"] = "Game of Tower"; -- Need translation

	-- Silithus - The Silithyst Must Flow
	["The Silithyst Must Flow"] = "The Silithyst Must Flow"; -- Need translation
	["Alliance's Camp"] = "Alliance's Camp"; -- Need translation
	["Horde's Camp"] = "Horde's Camp"; -- Need translation
};
end
