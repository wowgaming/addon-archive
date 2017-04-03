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
-- $Date: 2010-08-01 20:29:57 +0930 (Sun, 01 Aug 2010) $
-- $Revision: 945 $
if ( GetLocale() == "zhTW" ) then

AtlasBGLocale = {

	--Common
	["Alliance"] = "聯盟";
	["Battleground Maps"] = "戰場地圖";
	["Entrance"] = "入口";
	["Horde"] = "部落";
	["Neutral"] = "中立";
	["North"] = "北";
	["Orange"] = "橙";
	["Red"] = "紅";
	["Reputation"] = "聲望";
	["Rescued"] = "營救";
	["South"] = "南";
	["Start"] = "開始";
	["Summon"] = "召喚";
	["White"] = "白";

	--Places
	["AV"] = "AV/奧山"; -- Alterac Valley
	["AB"] = "AB/阿拉希"; -- Arathi Basin
	["Eye of the Storm"] = "暴風之眼"; ["EotS"] = "EotS/暴風";
	["IoC"] = "IoC"; -- Isle of Conquest
	["SotA"] = "SotA/遠祖"; -- Strand of the Ancients
	["WSG"] = "WSG/戰歌"; -- Warsong Gulch

	--Alterac Valley (North)
	["Stormpike Guard"] = "雷矛衛隊";
	["Vanndar Stormpike <Stormpike General>"] = "范達爾·雷矛";
	["Dun Baldar North Marshal"] = "丹巴達爾北部元帥";
	["Dun Baldar South Marshal"] = "丹巴達爾南部元帥";
	["Icewing Marshal"] = "冰翼元帥";
	["Stonehearth Marshal"] = "石爐元帥";
	["Prospector Stonehewer"] = "勘察員塔雷·石鎬";
	["Morloch"] = "莫洛克";
	["Umi Thorson"] = "烏米·托爾森";
	["Keetar"] = "基塔爾";
	["Arch Druid Renferal"] = "大德魯伊雷弗拉爾";
	["Dun Baldar North Bunker"] = "丹巴達爾北部碉堡";
	["Wing Commander Mulverick"] = "空軍指揮官穆維里克";--omitted from AVS
	["Murgot Deepforge"] = "莫高特·深爐";
	["Dirk Swindle <Bounty Hunter>"] = "德爾克 <賞金獵人>";
	["Athramanis <Bounty Hunter>"] = "亞斯拉瑪尼斯 <賞金獵人>";
	["Lana Thunderbrew <Blacksmithing Supplies>"] = "蘭納·雷酒 <鐵匠供應商>";
	["Stormpike Aid Station"] = "雷矛急救站";
	["Stormpike Stable Master <Stable Master>"] = "雷矛獸欄管理員";
	["Stormpike Ram Rider Commander"] = "雷矛山羊騎兵指揮官";
	["Svalbrad Farmountain <Trade Goods>"] = "斯瓦爾布萊德·遠山 <商人>";
	["Kurdrum Barleybeard <Reagents & Poison Supplies>"] = "庫德拉姆·麥鬚 <材料與藥水供應商>";
	["Stormpike Quartermaster"] = "雷矛軍需官";
	["Jonivera Farmountain <General Goods>"] = "約尼維拉·遠山 <雜貨商>";
	["Brogus Thunderbrew <Food & Drink>"] = "布羅古斯·雷酒 <食物和飲料>";
	["Wing Commander Ichman"] = "空軍指揮官艾克曼";--omitted from AVS
	["Wing Commander Slidore"] = "空軍指揮官斯里多爾";--omitted from AVS
	["Wing Commander Vipore"] = "空軍指揮官維波里";--omitted from AVS
	["Dun Baldar South Bunker"] = "丹巴達爾南部碉堡";
	["Corporal Noreg Stormpike"] = "諾雷格·雷矛下士";
	["Gaelden Hammersmith <Stormpike Supply Officer>"] = "蓋爾丁 <雷矛物資商人>";
	["Stormpike Banner"] = "雷矛軍旗";
	["Stormpike Lumber Yard"] = "雷矛林場";
	["Wing Commander Jeztor"] = "空軍指揮官傑斯托";--omitted from AVS
	["Wing Commander Guse"] = "空軍指揮官古斯";--omitted from AVS
	["Stormpike Ram Rider Commander"] = "雷矛山羊騎兵指揮官";
	["Captain Balinda Stonehearth <Stormpike Captain>"] = "巴琳達·石爐上尉";
	["Ichman's Beacon"] = "艾克曼的信號燈";
	["Mulverick's Beacon"] = "穆維里克的信號燈";
	["Ivus the Forest Lord"] = "『森林之王』伊弗斯";
	["Western Crater"] = "西部凹地";
	["Vipore's Beacon"] = "維波里的信號燈";
	["Jeztor's Beacon"] = "傑斯托的信號燈";
	["Eastern Crater"] = "東部凹地";
	["Slidore's Beacon"] = "斯里多爾的信號燈";
	["Guse's Beacon"] = "古斯的信號燈";
	["Graveyards, Capturable Areas"] = "墓地, 可佔領的地區";--omitted from AVS
	["Bunkers, Towers, Destroyable Areas"] = "碉堡, 哨塔, 可摧毀的地區";--omitted from AVS
	["Assault NPCs, Quest Areas"] = "突擊 NPCs, 任務地區";--omitted from AVS

	--Alterac Valley (South)
	["Frostwolf Clan"] = "霜狼氏族";
	["Drek'Thar <Frostwolf General>"] = "德雷克塔爾";
	["Duros"] = "杜洛斯";
	["Drakan"] = "崔坎";
	["West Frostwolf Warmaster"] = "西部霜狼將領";
	["East Frostwolf Warmaster"] = "東部霜狼將領";
	["Tower Point Warmaster"] = "哨塔高地將領";
	["Iceblood Warmaster"] = "冰血將領";
	["Lokholar the Ice Lord"] = "『冰雪之王』洛克霍拉";
	["Captain Galvangar <Frostwolf Captain>"] = "加爾范上尉";
	["Iceblood Tower"] = "冰血哨塔";
	["Tower Point"] = "哨塔高地";
	["Taskmaster Snivvle"] = "監工斯尼維爾";
	["Masha Swiftcut"] = "瑪莎";
	["Aggi Rumblestomp"] = "埃其";
	["Jotek"] = "喬泰克";
	["Smith Regzar"] = "鐵匠雷格薩";
	["Primalist Thurloga"] = "原獵者瑟魯加";
	["Sergeant Yazra Bloodsnarl"] = "亞斯拉·血矛";
	["Frostwolf Stable Master <Stable Master>"] = "霜狼獸欄管理員";
	["Frostwolf Wolf Rider Commander"] = "霜狼騎兵指揮官";
	["Frostwolf Quartermaster"] = "霜狼軍需官";
	["West Frostwolf Tower"] = "西部霜狼哨塔";
	["East Frostwolf Tower"] = "東部霜狼哨塔";
	["Frostwolf Relief Hut"] = "霜狼急救站";
	["Frostwolf Banner"] = "霜狼軍旗";

	--Arathi Basin
	["The Defilers"] = "污染者";
	["The League of Arathor"] = "阿拉索聯軍";

	--Eye of the Storm
	["Flag"] = "旗幟";

	--Isle of Conquest
	["The Refinery"] = "精煉廠";
	["The Docks"] = "碼頭";
	["The Workshop"] = "工坊";
	["The Hangar"] = "機棚";
	["The Quarry"] = "礦場";
	["Contested Graveyards"] = "爭奪中的墓地";
	["Horde Graveyard"] = "部落墓地";
	["Alliance Graveyard"] = "聯盟墓地";
	["Gates are marked with red bars."] = "閘門以紅條標記.";
	["Overlord Agmar"] = "霸主阿格瑪";
	["High Commander Halford Wyrmbane <7th Legion>"] = "高階指揮官海弗德·龍禍 <第七軍團>";

	--Strand of the Ancients
	["Attacking Team"] = "攻擊隊伍";
	["Defending Team"] = "防禦隊伍";
	["Massive Seaforium Charge"] = "巨型爆鹽炸藥";
	["Battleground Demolisher"] = "戰場石毀車";
	["Resurrection Point"] = "復活術點";
	["Graveyard Flag"] = "墓地旗幟";
	["Titan Relic"] = "泰坦聖物";
	["Gates are marked with their colors."] = "大門已被標記顏色";

	--Warsong Gulch
	["Warsong Outriders"] = "戰歌偵察騎兵";
	["Silverwing Sentinels"] = "銀翼要塞的戰士";

	-- Hellfire Peninsula PvP 
	["Hellfire Fortifications"] = "地獄火防禦堡壘";
	
	-- Zangarmarsh PvP
	["West Beacon"] = "西部哨塔";
	["East Beacon"] = "東部哨塔";
	["Twinspire Graveyard"] = "雙塔墓地";
	["Alliance Field Scout"] = "聯盟戰場斥候";
	["Horde Field Scout"] = "部落戰場斥候";

	-- Terokkar Forest PvP
	["Auchindoun Spirit Towers"] = "奧齊頓精神哨塔";

	-- Halaa
	["Wyvern Camp"] = "雙足翼龍營地";
	["Quartermaster Jaffrey Noreliqe"] = "軍需官傑夫利·諾利克";
	["Quartermaster Davian Vaclav"] = "軍需官戴夫恩·瓦克拉夫";
	["Chief Researcher Amereldine"] = "首席調查員阿莫瑞丹";
	["Chief Researcher Kartos"] = "首席調查員卡托斯";
	["Aldraan <Blade Merchant>"] = "阿爾德蘭 <劍刃武器商>";
	["Banro <Ammunition>"] = "班洛 <彈藥商>";
	["Cendrii <Food & Drink>"] = "善德利 <食物和飲料>";
	["Coreiel <Blade Merchant>"] = "寇瑞歐 <劍刃武器商>";
	["Embelar <Food & Drink>"] = "安畢拉爾 <食物和飲料>";
	["Tasaldan <Ammunition>"] = "塔薩丹 <彈藥商>";

	-- Wintergrasp
	["Fortress Vihecal Workshop (E)"] = "堡壘載具工坊 (東)";
	["Fortress Vihecal Workshop (W)"] = "堡壘載具工坊 (西)";
	["Sunken Ring Vihecal Workshop"] = "沉沒之環載具工坊";
	["Broken Temple Vihecal Workshop"] = "破碎神殿載具工坊";
	["Eastspark Vihecale Workshop"] = "東炫載具工坊";
	["Westspark Vihecale Workshop"] = "西炫載具工坊";
	["Wintergrasp Graveyard"] = "堡壘墓地";
	["Sunken Ring Graveyard"] = "沉沒之環墓地";
	["Broken Temple Graveyard"] = "破碎神殿墓地";
	["Southeast Graveyard"] = "東南墓地";
	["Southwest Graveyard"] = "西南墓地";

	-- Eastern Plaguelands - Game of Tower
	["A Game of Towers"] = "哨塔爭奪戰";
	
	-- Silithus - The Silithyst Must Flow
	["The Silithyst Must Flow"] = "收集希利塞斯";
	["Alliance's Camp"] = "聯盟營地";
	["Horde's Camp"] = "部落營地";
};
end
