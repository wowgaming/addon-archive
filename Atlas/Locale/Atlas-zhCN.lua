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
-- Maintained by DiabloHu, arith
-- $Date: 2010-07-25 08:42:10 +0930 (Sun, 25 Jul 2010) $
-- $Revision: 927 $


if ( GetLocale() == "zhCN" ) then
--************************************************
-- Global Atlas Strings
--************************************************

AtlasSortIgnore = {};

ATLAS_TITLE = "Atlas";

BINDING_HEADER_ATLAS_TITLE = "Atlas 按键设置";
BINDING_NAME_ATLAS_TOGGLE = "开启/关闭 Atlas";
BINDING_NAME_ATLAS_OPTIONS = "切换设置";
BINDING_NAME_ATLAS_AUTOSEL = "自动选择";

ATLAS_SLASH 		= "/atlas";
ATLAS_SLASH_OPTIONS = "options";

ATLAS_STRING_LOCATION 		= "所属区域";
ATLAS_STRING_LEVELRANGE 	= "等级跨度";
ATLAS_STRING_PLAYERLIMIT 	= "人数上限";
ATLAS_STRING_SELECT_CAT 	= "选择分类";
ATLAS_STRING_SELECT_MAP 	= "选择地图";
ATLAS_STRING_SEARCH 		= "搜索";
ATLAS_STRING_CLEAR 		= "重置";
ATLAS_STRING_MINLEVEL 		= "需要等级";

ATLAS_OPTIONS_BUTTON		= "设置";
ATLAS_OPTIONS_SHOWBUT 		= "在小地图周围显示Atlas图标";
ATLAS_OPTIONS_AUTOSEL 		= "自动选择副本地图";
ATLAS_OPTIONS_BUTPOS 		= "图标位置";
ATLAS_OPTIONS_TRANS 		= "透明度";
ATLAS_OPTIONS_RCLICK 		= "点击右键打开世界地图";
ATLAS_OPTIONS_RESETPOS 		= "重置位置";
ATLAS_OPTIONS_ACRONYMS 		= "显示简称";
ATLAS_OPTIONS_SCALE 		= "窗口大小";
ATLAS_OPTIONS_BUTRAD 		= "图标半径";
ATLAS_OPTIONS_CLAMPED		= "使 Atlas 不超出游戏画面"
ATLAS_OPTIONS_CTRL 		= "弹出工具说明 (按住CTRL指向内容)"

ATLAS_BUTTON_TOOLTIP_TITLE = "Atlas";
ATLAS_BUTTON_TOOLTIP_HINT = "单击打开 Atlas\n中键单击打开设置\n按住右键可移动这个按钮";
ATLAS_LDB_HINT = "单击打开 Atlas\n右键点击打开设置";

ATLAS_OPTIONS_CATDD = "副本地图排序方式";
ATLAS_DDL_CONTINENT = "所属大陆";
ATLAS_DDL_CONTINENT_EASTERN = "东部王国副本";
ATLAS_DDL_CONTINENT_KALIMDOR = "卡利姆多副本";
ATLAS_DDL_CONTINENT_OUTLAND = "外域副本";
ATLAS_DDL_CONTINENT_NORTHREND = "诺森德副本";
ATLAS_DDL_LEVEL = "副本等级";
ATLAS_DDL_LEVEL_UNDER45 = "45 级以下副本";
ATLAS_DDL_LEVEL_45TO60 = "45-60 级副本";
ATLAS_DDL_LEVEL_60TO70 = "60-70 级副本";
ATLAS_DDL_LEVEL_70TO80 = "70-80 级副本";
ATLAS_DDL_LEVEL_80PLUS = "80 级以上副本";
ATLAS_DDL_PARTYSIZE = "副本规模";
ATLAS_DDL_PARTYSIZE_5_AE = "5 人副本 (第一页)";
ATLAS_DDL_PARTYSIZE_5_FZ = "5 人副本 (第二页)";
ATLAS_DDL_PARTYSIZE_10_AQ = "10 人副本 (第一页)";
ATLAS_DDL_PARTYSIZE_10_RZ = "10 人副本 (第二页)";
ATLAS_DDL_PARTYSIZE_20TO40 = "20-40 人副本";
ATLAS_DDL_EXPANSION = "资料片";
ATLAS_DDL_EXPANSION_OLD_AO = "旧世界副本 (第一页)";
ATLAS_DDL_EXPANSION_OLD_PZ = "旧世界副本 (第二页)";
ATLAS_DDL_EXPANSION_BC = "《燃烧的远征》副本";
ATLAS_DDL_EXPANSION_WOTLK = "《巫妖王之怒》副本";
ATLAS_DDL_TYPE = "类型";
ATLAS_DDL_TYPE_INSTANCE_AC = "副本 (第一页)";
ATLAS_DDL_TYPE_INSTANCE_DR = "副本 (第二页)";
ATLAS_DDL_TYPE_INSTANCE_SZ = "副本 (第三页)";
ATLAS_DDL_TYPE_ENTRANCE = "入口";

ATLAS_INSTANCE_BUTTON = "副本";
ATLAS_ENTRANCE_BUTTON = "入口";
ATLAS_SEARCH_UNAVAIL = "搜索不可用";

ATLAS_DEP_MSG1 = "检测到过期的 Atlas 扩展插件。";
ATLAS_DEP_MSG2 = "这些插件已经被禁用。";
ATLAS_DEP_MSG3 = "请从插件目录（AddOns）中将其删除。";
ATLAS_DEP_OK = "确定";


AtlasZoneSubstitutions = {
	["Ahn'Qiraj"] = "安其拉神殿";
	["The Temple of Atal'Hakkar"] = "沉没的神庙";
	["Old Hillsbrad Foothills"] = "时光之穴 - 旧希尔斯布莱德";
	["The Eye"] = "风暴要塞 - 风暴之眼";
}; 

AtlasLocale = {

--************************************************
-- Zone Names, Acronyms, and Common Strings
--************************************************

	--World Events, Festival
	["Brewfest"] = "美酒节";
	["Hallow's End"] = "万圣节";
	["Love is in the Air"] = "爱情的气息";
	["Lunar Festival"] = "春节庆典";
	["Midsummer Festival"] = "仲夏节庆典";
	--Misc strings
	["Adult"] = "成年";
	["AKA"] = "亦作";
	["Alliance"] = "联盟";
	["Arcane Container"] = "奥术容器";
	["Argent Dawn"] = "银色黎明";
	["Argent Crusade"] = "银色远征军";
	["Arms Warrior"] = "武器战士";
	["Attunement Required"] = "需要完成入口任务";
	["Back"] = "后门";
	["Basement"] = "底层";
	["Bat"] = "蝙蝠";
	["Blacksmithing Plans"] = "锻造设计图";
	["Boss"] = "首领";
	["Brazier of Invocation"] = "符咒火盆";
	["Chase Begins"] = "追捕开始";
	["Chase Ends"] = "追捕结束";
	["Child"] = "幼年";
	["Connection"] = "通道";
	["DS2"] = "地下城套装2";
	["Elevator"] = "升降梯";
	["End"] = "尾部";
	["Engineer"] = "工程师";
	["Entrance"] = "入口";
	["Event"] = "事件";
	["Exalted"] = "崇拜";
	["Exit"] = "出口";
	["Fourth Stop"] = "第四次止步";
	["Front"] = "前门";
	["Ghost"] = "幽灵";
	["Heroic"] = "英雄模式";
	["Holy Paladin"] = "神圣圣骑士";
	["Holy Priest"] = "神圣牧师";
	["Horde"] = "部落";
	["Hunter"] = "猎人";
	["Imp"] = "小鬼";
	["Inside"] = "内部";
	["Key"] = "钥匙";
	["Lower"] = "下层";
	["Mage"] = "法师";
	["Meeting Stone"] = "集合石";
	["Monk"] = "僧侣";
	["Moonwell"] = "月亮井";
	["Optional"] = "可跳过";
	["Orange"] = "橙色";
	["Outside"] = "室外";
	["Paladin"] = "圣骑士";
	["Panther"] = "猎豹";
	["Portal"] = "传送";
	["Priest"] = "牧师";
	["Protection Warrior"] = "防护战士";
	["Purple"] = "紫色";
	["Random"] = "随机";
	["Raptor"] = "迅猛龙";
	["Rare"] = "稀有";
	["Reputation"] = "阵营";
	["Repair"] = "修理";
	["Retribution Paladin"] = "惩戒圣骑士";
	["Rewards"] = "奖励";
	["Rogue"] = "潜行者";
	["Second Stop"] = "第二次止步";
	["Shadow Priest"] = "暗影牧师";
	["Shaman"] = "萨满祭司";
	["Side"] = "旁门";
	["Snake"] = "毒蛇";
	["Spawn Point"] = "刷新点";
	["Spider"] = "蜘蛛";
	["Start"] = "起始";
	["Summon"] = "召唤";
	["Teleporter"] = "传送";
	["Third Stop"] = "第三次止步";
	["Tiger"] = "猛虎";
	["Top"] = "顶层";
	["Undead"] = "亡灵";
	["Underwater"] = "水下";
	["Unknown"] = "未知";
	["Upper"] = "上层";
	["Varies"] = "多个位置";
	["Wanders"] = "游荡";
	["Warlock"] = "术士";
	["Warrior"] = "战士";
	["Wave 5"] = "第5波";
	["Wave 6"] = "第6波";
	["Wave 10"] = "第10波";
	["Wave 12"] = "第12波";
	["Wave 18"] = "第18波";

	--Classic Acronyms
	["AQ"] = "AQ"; -- Ahn'Qiraj
	["AQ20"] = "AQ20"; -- Ruins of Ahn'Qiraj
	["AQ40"] = "AQ40"; -- Temple of Ahn'Qiraj
	["Armory"] = "Armory"; -- Armory
	["BFD"] = "BFD"; -- Blackfathom Deeps
	["BRD"] = "BRD"; -- Blackrock Depths
	["BRM"] = "BRM"; -- Blackrock Mountain
	["BWL"] = "BWL"; -- Blackwing Lair
	["Cath"] = "Cath"; -- Cathedral
	["DM"] = "DM"; -- Dire Maul
	["Gnome"] = "Gnome"; -- Gnomeregan
	["GY"] = "GY"; -- Graveyard
	["LBRS"] = "LBRS"; -- Lower Blackrock Spire
	["Lib"] = "Lib"; -- Library
	["Mara"] = "Mara"; -- Maraudon
	["MC"] = "MC"; -- Molten Core
	["RFC"] = "RFC"; -- Ragefire Chasm
	["RFD"] = "RFD"; -- Razorfen Downs
	["RFK"] = "RFK"; -- Razorfen Kraul
	["Scholo"] = "Scholo"; -- Scholomance
	["SFK"] = "SFK"; -- Shadowfang Keep
	["SM"] = "SM"; -- Scarlet Monastery
	["ST"] = "ST"; -- Sunken Temple
	["Strat"] = "Strat"; -- Stratholme
	["Stocks"] = "Stocks"; -- The Stockade
	["UBRS"] = "UBRS"; -- Upper Blackrock Spire
	["Ulda"] = "Ulda"; -- Uldaman
	["VC"] = "VC"; -- The Deadmines
	["WC"] = "WC"; -- Wailing Caverns
	["ZF"] = "ZF"; -- Zul'Farrak
	["ZG"] = "ZG"; -- Zul'Gurub

	--BC Acronyms
	["AC"] = "AC"; -- Auchenai Crypts
	["Arca"] = "Arca"; -- The Arcatraz
	["Auch"] = "Auch"; -- Auchindoun
	["BF"] = "BF"; -- The Blood Furnace
	["BT"] = "BT"; -- Black Temple
	["Bota"] = "Bota"; -- The Botanica
	["CoT"] = "CoT"; -- Caverns of Time
	["CoT1"] = "CoT1"; -- Old Hillsbrad Foothills
	["CoT2"] = "CoT2"; -- The Black Morass
	["CoT3"] = "CoT3"; -- Hyjal Summit
	["CR"] = "CR"; -- Coilfang Reservoir
	["Eye"] = "Eye"; -- The Eye
	["GL"] = "GL"; -- Gruul's Lair
	["HC"] = "HC"; -- Hellfire Citadel
	["Kara"] = "Kara"; -- Karazhan
	["MaT"] = "MT"; -- Magisters' Terrace
	["Mag"] = "Mag"; -- Magtheridon's Lair
	["Mech"] = "Mech"; -- The Mechanar
	["MT"] = "MT"; -- Mana-Tombs
	["Ramp"] = "Ramp"; -- Hellfire Ramparts
	["SC"] = "SC"; -- Serpentshrine Cavern
	["Seth"] = "Seth"; -- Sethekk Halls
	["SH"] = "SH"; -- The Shattered Halls
	["SL"] = "SL"; -- Shadow Labyrinth
	["SP"] = "SP"; -- The Slave Pens
	["SuP"] = "SP"; -- Sunwell Plateau
	["SV"] = "SV"; -- The Steamvault
	["TK"] = "TK"; -- Tempest Keep
	["UB"] = "UB"; -- The Underbog
	["ZA"] = "ZA"; -- Zul'Aman

	--WotLK Acronyms
	["AK, Kahet"] = "AK, 安卡"; -- Ahn'kahet
	["AN, Nerub"] = "AN, 艾卓"; -- Azjol-Nerub
	["Champ"] = "Champ"; -- Trial of the Champion
	["CoT-Strat"] = "CoT-Strat"; -- Culling of Stratholme
	["Crus"] = "Crus"; -- Trial of the Crusader
	["DTK"] = "DTK"; -- Drak'Tharon Keep
	["FoS"] = "FoS"; ["FH1"] = "FH1"; -- The Forge of Souls
	["Gun"] = "Gun"; -- Gundrak
	["HoL"] = "HoL"; -- Halls of Lightning
	["HoR"] = "HoR"; ["FH3"] = "FH3"; -- Halls of Reflection
	["HoS"] = "HoS"; -- Halls of Stone
 	["IC"] = "IC"; -- Icecrown Citadel
	["Nax"] = "Nax"; -- Naxxramas
	["Nex, Nexus"] = "Nex, Nexus"; -- The Nexus
	["Ocu"] = "Ocu"; -- The Oculus
	["Ony"] = "Ony"; -- Onyxia's Lair
	["OS"] = "OS"; -- The Obsidian Sanctum
	["PoS"] = "PoS"; ["FH2"] = "FH2"; -- Pit of Saron
	["RS"] = "RS"; -- The Ruby Sanctum
	["TEoE"] = "TEoE"; -- The Eye of Eternity
	["UK, Keep"] = "UK, Keep"; -- Utgarde Keep
	["Uldu"] = "Uldu"; -- Ulduar
	["UP, Pinn"] = "UP, Pinn"; -- Utgarde Pinnacle
	["VH"] = "VH"; -- The Violet Hold
	["VoA"] = "VoA"; -- Vault of Archavon

	--Zones not included in LibBabble-Zone
	["Crusaders' Coliseum"] = "十字军大竞技场";

--************************************************
-- Instance Entrance Maps
--************************************************

	--Auchindoun (Entrance)
	["Ha'Lei"] = "哈雷";
	["Greatfather Aldrimus"] = "奥德里姆斯宗父";
	["Clarissa"] = "克拉里萨";
	["Ramdor the Mad"] = "疯狂的拉姆杜尔";
	["Horvon the Armorer <Armorsmith>"] = "铸甲匠霍尔冯 <护甲锻造师>";
	["Nexus-Prince Haramad"] = "节点亲王哈拉迈德";
	["Artificer Morphalius"] = "工匠莫法鲁斯";
	["Mamdy the \"Ologist\""] = "“杂学家”玛姆迪";
	["\"Slim\" <Shady Dealer>"] = "“瘦子” <毒药商>";
	["\"Captain\" Kaftiz"] = "“上尉”卡弗提兹";
	["Isfar"] = "伊斯法尔";
	["Field Commander Mahfuun"] = "战地指挥官玛弗恩";
	["Spy Grik'tha"] = "间谍格利克萨";
	["Provisioner Tsaalt"] = "补给官塔萨尔特";
	["Dealer Tariq <Shady Dealer>"] = "商人塔利基 <毒药商>";

	--Blackfathom Deeps (Entrance)
	--Nothing to translate!

	--Blackrock Mountain (Entrance)
	["Bodley"] = "伯德雷";
	["Overmaster Pyron"] = "征服者派隆";
	["Lothos Riftwaker"] = "洛索斯·天痕";
	["Franclorn Forgewright"] = "弗兰克罗恩·铸铁";
	["Orb of Command"] = "命令宝珠";
	["Scarshield Quartermaster <Scarshield Legion>"] = "裂盾军需官 <裂盾军团>";

	--Coilfang Reservoir (Entrance)
	["Watcher Jhang"] = "观察者杰哈恩";
	["Mortog Steamhead"] = "莫尔托格";

	--Caverns of Time (Entrance)
	["Steward of Time <Keepers of Time>"] = "时间管理者 <时光守护者>";
	["Alexston Chrome <Tavern of Time>"] = "阿历克斯顿·克罗姆 <时间旅店>";
	["Yarley <Armorer>"] = "亚尔雷 <护甲商>";
	["Bortega <Reagents & Poison Supplies>"] = "波特加 <材料与毒药商>";
	["Galgrom <Provisioner>"] = "加尔戈罗姆 <供给商人>";
	["Alurmi <Keepers of Time Quartermaster>"] = "艾鲁尔米 <时光守护者军需官>";
	["Zaladormu"] = "扎拉多姆";
	["Soridormi <The Scale of Sands>"] = "索莉多米 <流沙之鳞>";
	["Arazmodu <The Scale of Sands>"] = "阿拉兹姆多 <流沙之鳞>";
	["Andormu <Keepers of Time>"] = "安多姆 <时光守护者>";
	["Nozari <Keepers of Time>"] = "诺萨莉 <时光守护者>";

	--Dire Maul (Entrance)
	["Dire Pool"] = "厄运之池";
	["Dire Maul Arena"] = "厄运之槌竞技场";
	["Mushgog"] = "姆斯高格";
	["Skarr the Unbreakable"] = "无敌的斯卡尔";
	["The Razza"] = "拉扎尔";
	["Elder Mistwalker"] = "迷雾长者";

	--Gnomeregan (Entrance)
	["Transpolyporter"] = "传送器";
	["Sprok <Away Team>"] = "斯普洛克 <客队>";
	["Matrix Punchograph 3005-A"] = "矩阵式打孔计算机3005-A";
	["Namdo Bizzfizzle <Engineering Supplies>"] = "纳姆杜 <工程学供应商>";
	["Techbot"] = "尖端机器人";

	-- Hellfire Citadel (Entrance)
	["Steps and path to the Blood Furnace"] = "通往鲜血熔炉的阶梯与通道";
	["Path to the Hellfire Ramparts and Shattered Halls"] = "通往地狱火城墙与破碎大厅的通道";
	["Meeting Stone of Magtheridon's Lair"] = "集合石 - 玛瑟里顿的巢穴";
	["Meeting Stone of Hellfire Citadel"] = "集合石 - 地狱火堡垒";

	--Karazhan (Entrance)
	["Archmage Leryda"] = "大法师蕾尔达";
	["Apprentice Darius"] = "学徒达里乌斯";
	["Archmage Alturus"] = "大法师奥图鲁斯";
	["Stairs to Underground Pond"] = "通往地下水池的楼梯";
	["Stairs to Underground Well"] = "通往地下水井的楼梯";
	["Charred Bone Fragment"] = "焦骨碎块";

	--Maraudon (Entrance)
	["The Nameless Prophet"] = "无名预言者";
	["Kolk <The First Kahn>"] = "考尔克 <第一可汗>";
	["Gelk <The Second Kahn>"] = "格尔克 <第二可汗>";
	["Magra <The Third Kahn>"] = "玛格拉 <第三可汗>";
	["Cavindra"] = "凯雯德拉";

	--Scarlet Monastery (Entrance)
	--Nothing to translate!

	--The Deadmines (Entrance)
	["Marisa du'Paige"] = "玛里莎·杜派格";
	["Brainwashed Noble"] = "被洗脑的贵族";
	["Foreman Thistlenettle"] = "工头希斯耐特";

	--Sunken Temple (Entrance)
	["Jade"] = "玉龙";
	["Kazkaz the Unholy"] = "邪恶的卡萨卡兹";
	["Zekkis"] = "泽基斯";
	["Veyzhak the Cannibal"] = "食尸者维萨克";

	--Uldaman (Entrance)
	["Hammertoe Grez"] = "铁趾格雷兹";
	["Magregan Deepshadow"] = "马格雷甘·深影";
	["Tablet of Ryun'Eh"] = "雷乌纳石板";
	["Krom Stoutarm's Chest"] = "克罗姆·粗臂的箱子";
	["Garrett Family Chest"] = "加勒特的宝箱";
	["Digmaster Shovelphlange"] = "挖掘专家舒尔弗拉格";

	--Wailing Caverns (Entrance)
	["Mad Magglish"] = "疯狂的马格利什";
	["Trigore the Lasher"] = "鞭笞者特里高雷";
	["Boahn <Druid of the Fang>"] = "博艾恩 <尖牙德鲁伊>";
	["Above the Entrance:"] = "入口上方: ";
	["Ebru <Disciple of Naralex>"] = "厄布鲁 <纳拉雷克斯的信徒>";
	["Nalpak <Disciple of Naralex>"] = "纳尔帕克 <纳拉雷克斯的信徒>";
	["Kalldan Felmoon <Specialist Leatherworking Supplies>"] = "卡尔丹·暗月 <特殊制皮物资>";
	["Waldor <Leatherworking Trainer>"] = "瓦多尔 <制皮训练师>";

--************************************************
-- Kalimdor Instances (Classic)
--************************************************

	--Blackfathom Deeps
	["Ghamoo-ra"] = "加摩拉";
	["Lorgalis Manuscript"] = "潮湿的便笺";
	["Lady Sarevess"] = "萨利维丝";
	["Argent Guard Thaelrid <The Argent Dawn>"] = "银月守卫塞尔瑞德 <银色黎明>";
	["Gelihast"] = "格里哈斯特";
	["Shrine of Gelihast"] = "格里哈斯特神殿";
	["Lorgus Jett"] = "洛古斯·杰特";
	["Fathom Stone"] = "深渊之核";
	["Baron Aquanis"] = "阿奎尼斯男爵";
	["Twilight Lord Kelris"] = "梦游者克尔里斯";
	["Old Serra'kis"] = "瑟拉吉斯";
	["Aku'mai"] = "阿库迈尔";
	["Morridune"] = "莫瑞杜恩";
	["Altar of the Deeps"] = "玛塞斯特拉祭坛";
	
	--Dire Maul (East)
	["Pusillin"] = "普希林";
	["Zevrim Thornhoof"] = "瑟雷姆·刺蹄";
	["Hydrospawn"] = "海多斯博恩";
	["Lethtendris"] = "雷瑟塔帝丝";
	["Pimgib"] = "匹姆吉布";
	["Old Ironbark"] = "埃隆巴克";
	["Alzzin the Wildshaper"] = "奥兹恩";
	["Isalien"] = "伊萨莉恩";
	
	--Dire Maul (North)
	["Crescent Key"] = "月牙钥匙";--omitted from Dire Maul (West)
	--"Library" omitted from here and DM West because of SM: "Library" duplicate
	["Guard Mol'dar"] = "卫兵摩尔达";
	["Stomper Kreeg <The Drunk>"] = "践踏者克雷格 <醉鬼>";
	["Guard Fengus"] = "卫兵芬古斯";
	["Knot Thimblejack"] = "诺特·希姆加可";
	["Guard Slip'kik"] = "卫兵斯里基克";
	["Captain Kromcrush"] = "克罗卡斯";
	["King Gordok"] = "戈多克大王";
	["Cho'Rush the Observer"] = "观察者克鲁什";

	--Dire Maul (West)
	["J'eevee's Jar"] = "耶维尔的瓶子";
	["Pylons"] = "水晶塔";
	["Shen'dralar Ancient"] = "辛德拉古灵";
	["Tendris Warpwood"] = "特迪斯·扭木";
	["Ancient Equine Spirit"] = "上古圣马之魂";
	["Illyanna Ravenoak"] = "伊琳娜·暗木";
	["Ferra"] = "费拉";
	["Magister Kalendris"] = "卡雷迪斯镇长";
	["Tsu'zee"] = "苏斯";
	["Immol'thar"] = "伊莫塔尔";
	["Lord Hel'nurath"] = "赫尔努拉斯";
	["Prince Tortheldrin"] = "托塞德林王子";
	["Falrin Treeshaper"] = "法尔林·树影";
	["Lorekeeper Lydros"] = "博学者莱德罗斯";
	["Lorekeeper Javon"] = "博学者亚沃";
	["Lorekeeper Kildrath"] = "博学者基尔达斯";
	["Lorekeeper Mykos"] = "博学者麦库斯";
	["Shen'dralar Provisioner"] = "辛德拉圣职者";
	["Skeletal Remains of Kariel Winthalus"] = "卡里尔·温萨鲁斯的骸骨";
	
	--Maraudon	
	["Scepter of Celebras"] = "塞雷布拉斯节杖";
	["Veng <The Fifth Khan>"] = "温格 <第五可汗>";
	["Noxxion"] = "诺克赛恩";
	["Razorlash"] = "锐刺鞭笞者";
	["Maraudos <The Fourth Khan>"] = "玛劳杜斯 <第四可汗>";
	["Lord Vyletongue"] = "维利塔恩";
	["Meshlok the Harvester"] = "收割者麦什洛克";
	["Celebras the Cursed"] = "被诅咒的塞雷布拉斯";
	["Landslide"] = "兰斯利德";
	["Tinkerer Gizlock"] = "工匠吉兹洛克";
	["Rotgrip"] = "洛特格里普";
	["Princess Theradras"] = "瑟莱德丝公主";
	["Elder Splitrock"] = "碎石长者";
	
	--Ragefire Chasm
	["Maur Grimtotem"] = "玛尔·恐怖图腾";
	["Oggleflint <Ragefire Chieftain>"] = "奥格弗林特 <怒焰酋长>";
	["Taragaman the Hungerer"] = "饥饿者塔拉加曼";
	["Jergosh the Invoker"] = "祈求者耶戈什";
	["Zelemar the Wrathful"] = "愤怒者塞雷玛尔";
	["Bazzalan"] = "巴扎兰";
	
	--Razorfen Downs
	["Tuten'kash"] = "图特卡什";
	["Henry Stern"] = "亨利·斯特恩";
	["Belnistrasz"] = "奔尼斯特拉兹";
	["Sah'rhee"] = "萨哈斯";
	["Mordresh Fire Eye"] = "火眼莫德雷斯";
	["Glutton"] = "暴食者";
	["Ragglesnout"] = "拉戈斯诺特";
	["Amnennar the Coldbringer"] = "寒冰之王亚门纳尔";
	["Plaguemaw the Rotting"] = "腐烂的普雷莫尔";
	
	--Razorfen Kraul
	["Roogug"] = "鲁古格";
	["Aggem Thorncurse <Death's Head Prophet>"] = "阿格姆 <亡首预言者>";
	["Death Speaker Jargba <Death's Head Captain>"] = "亡语者贾格巴 <亡首队长>";
	["Overlord Ramtusk"] = "主宰拉姆塔斯";
	["Razorfen Spearhide"] = "剃刀沼泽刺鬃守卫";
	["Agathelos the Raging"] = "暴怒的阿迦赛罗斯";
	["Blind Hunter"] = "盲眼猎手";
	["Charlga Razorflank <The Crone>"] = "卡尔加·刺肋 <长者>";
	["Willix the Importer"] = "进口商威利克斯";
	["Heralath Fallowbrook"] = "赫尔拉斯·静水";
	["Earthcaller Halmgar"] = "唤地者哈穆加";

	--Ruins of Ahn'Qiraj
	["Cenarion Circle"] = "塞纳里奥议会";
	["Kurinnaxx"] = "库林纳克斯";
	["Lieutenant General Andorov"] = "安多洛夫中将";
	["Four Kaldorei Elites"] = "卡多雷四精英";
	["General Rajaxx"] = "拉贾克斯将军";
	["Captain Qeez"] = "奎兹上尉";
	["Captain Tuubid"] = "图比德上尉";
	["Captain Drenn"] = "德雷恩上尉";
	["Captain Xurrem"] = "库雷姆上尉";
	["Major Yeggeth"] = "耶吉斯少校";
	["Major Pakkon"] = "帕库少校";
	["Colonel Zerran"] = "泽兰上校";
	["Moam"] = "莫阿姆";
	["Buru the Gorger"] = "吞咽者布鲁";
	["Ayamiss the Hunter"] = "狩猎者阿亚米斯";
	["Ossirian the Unscarred"] = "无疤者奥斯里安";
	["Safe Room"] = "安全房间";

	--Temple of Ahn'Qiraj
	["Brood of Nozdormu"] = "诺兹多姆的子嗣";
	["The Prophet Skeram"] = "预言者斯克拉姆";
	["The Bug Family"] = "虫人家庭";
	["Vem"] = "维姆";
	["Lord Kri"] = "克里勋爵";
	["Princess Yauj"] = "亚尔基公主";
	["Battleguard Sartura"] = "沙尔图拉";
	["Fankriss the Unyielding"] = "顽强的范克瑞斯";
	["Viscidus"] = "维希度斯";
	["Princess Huhuran"] = "哈霍兰公主";
	["Twin Emperors"] = "双子皇帝";
	["Emperor Vek'lor"] = "维克洛尔大帝";
	["Emperor Vek'nilash"] = "维克尼拉斯大帝";
	["Ouro"] = "奥罗";
	["Eye of C'Thun"] = "克苏恩之眼";
	["C'Thun"] = "克苏恩";
	["Andorgos <Brood of Malygos>"] = "安多葛斯 <玛里苟斯的后裔>";
	["Vethsera <Brood of Ysera>"] = "温瑟拉 <伊瑟拉的后裔>";
	["Kandrostrasz <Brood of Alexstrasza>"] = "坎多斯特拉兹 <阿莱克丝塔萨的后裔>";
	["Arygos"] = "亚雷戈斯";
	["Caelestrasz"] = "凯雷斯特拉兹";
	["Merithra of the Dream"] = "梦境之龙麦琳瑟拉";
	
	--Wailing Caverns
	["Disciple of Naralex"] = "纳拉雷克斯的信徒";
	["Lord Cobrahn <Fanglord>"] = "考布莱恩 <毒牙之王>";
	["Lady Anacondra <Fanglord>"] = "安娜科德拉 <毒牙之王>";
	["Kresh"] = "克雷什";
	["Lord Pythas <Fanglord>"] = "皮萨斯 <毒牙之王>";
	["Skum"] = "斯卡姆";
	["Lord Serpentis <Fanglord>"] = "瑟芬迪斯 <毒牙之王>";
	["Verdan the Everliving"] = "永生者沃尔丹";
	["Mutanus the Devourer"] = "吞噬者穆坦努斯";
	["Naralex"] = "纳拉雷克斯";
	["Deviate Faerie Dragon"] = "变异精灵龙";
	
	--Zul'Farrak
	["Antu'sul <Overseer of Sul>"] = "安图苏尔 <苏尔督军>";
	["Theka the Martyr"] = "殉教者塞卡";
	["Witch Doctor Zum'rah"] = "巫医祖穆拉恩";
	["Zul'Farrak Dead Hero"] = "祖尔法拉克阵亡英雄";
	["Nekrum Gutchewer"] = "耐克鲁姆";
	["Shadowpriest Sezz'ziz"] = "暗影祭司塞瑟斯";
	["Dustwraith"] = "灰尘怨灵";
	["Sergeant Bly"] = "布莱中士";
	["Weegli Blastfuse"] = "维格利";
	["Murta Grimgut"] = "穆尔塔";
	["Raven"] = "拉文";
	["Oro Eyegouge"] = "欧罗·血眼";
	["Sandfury Executioner"] = "沙怒刽子手";
	["Hydromancer Velratha"] = "水占师维蕾萨";
	["Gahz'rilla"] = "加兹瑞拉";
	["Elder Wildmane"] = "蛮鬃长者";
	["Chief Ukorz Sandscalp"] = "乌克兹·沙顶";
	["Ruuzlu"] = "卢兹鲁";
	["Zerillis"] = "泽雷利斯";
	["Sandarr Dunereaver"] = "杉达尔·沙掠者";

--****************************
-- Eastern Kingdoms Instances (Classic)
--****************************
	
	--Blackrock Depths
	["Shadowforge Key"] = "暗炉钥匙";
	["Prison Cell Key"] = "监狱牢房钥匙";
	["Jail Break!"] = "冲破牢笼";
	["Banner of Provocation"] = "挑衅之旗";
	["Lord Roccor"] = "洛考尔";
	["Kharan Mighthammer"] = "卡兰·巨锤";
	["Commander Gor'shak <Kargath Expeditionary Force>"] = "指挥官哥沙克 <卡加斯远征军>";
	["Marshal Windsor"] = "温德索尔元帅";
	["High Interrogator Gerstahn <Twilight's Hammer Interrogator>"] = "审讯官格斯塔恩 <暮光之锤审问者>";
	["Ring of Law"] = "法律之环";
	["Anub'shiah"] = "阿努希尔";
	["Eviscerator"] = "剜眼者";
	["Gorosh the Dervish"] = "修行者高罗什";
	["Grizzle"] = "格里兹尔";
	["Hedrum the Creeper"] = "爬行者赫杜姆";
	["Ok'thor the Breaker"] = "破坏者奥科索尔";
	["Theldren"] = "塞尔德林";
	["Lefty"] = "莱弗提";
	["Malgen Longspear"] = "玛尔根·长矛";
	["Gnashjaw <Malgen Longspear's Pet>"] = "碎腭 <玛尔根·长矛的宠物>";
	["Rotfang"] = "烂牙";
	["Va'jashni"] = "瓦亚辛";
	["Houndmaster Grebmar"] = "驯犬者格雷布玛尔";
	["Elder Morndeep"] = "黎明长者";
	["High Justice Grimstone"] = "裁决者格里斯通";
	["Monument of Franclorn Forgewright"] = "弗兰克罗恩·铸铁的雕像";
	["Pyromancer Loregrain"] = "控火师罗格雷恩";
	["The Vault"] = "黑色宝库";
	["Warder Stilgiss"] = "典狱官斯迪尔基斯";
	["Verek"] = "维雷克";
	["Watchman Doomgrip"] = "卫兵杜格瑞普";
	["Fineous Darkvire <Chief Architect>"] = "弗诺斯·达克维尔 <首席建筑师>";
	["The Black Anvil"] = "黑铁砧";
	["Lord Incendius"] = "伊森迪奥斯";
	["Bael'Gar"] = "贝尔加";
	["Shadowforge Lock"] = "暗炉之锁";
	["General Angerforge"] = "安格弗将军";
	["Golem Lord Argelmach"] = "傀儡统帅阿格曼奇";
	["Field Repair Bot 74A"] = "修理机器人74A型";
	["The Grim Guzzler"] = "黑铁酒吧";
	["Hurley Blackbreath"] = "霍尔雷·黑须";
	["Lokhtos Darkbargainer <The Thorium Brotherhood>"] = "罗克图斯·暗契 <瑟银兄弟会>";
	["Mistress Nagmara"] = "娜玛拉小姐";
	["Phalanx"] = "法拉克斯";
	["Plugger Spazzring"] = "普拉格";
	["Private Rocknot"] = "罗克诺特下士";
	["Ribbly Screwspigot"] = "雷布里·斯库比格特";
	["Coren Direbrew"] = "科林·烈酒";
	["Griz Gutshank <Arena Vendor>"] = "格里兹·加特沙克 <竞技场商人>";
	["Ambassador Flamelash"] = "弗莱拉斯大使";
	["Panzor the Invincible"] = "无敌的潘佐尔";
	["Summoner's Tomb"] = "召唤者之墓";
	["The Lyceum"] = "讲学厅";
	["Magmus"] = "玛格姆斯";
	["Emperor Dagran Thaurissan"] = "达格兰·索瑞森大帝";
	["Princess Moira Bronzebeard <Princess of Ironforge>"] = "铁炉堡公主茉艾拉·铜须 <铁炉堡公主>";
	["High Priestess of Thaurissan"] = "索瑞森高阶女祭司";
	["The Black Forge"] = "黑熔炉";
	["Core Fragment"] = "熔火碎片";
	["Overmaster Pyron"] = "征服者派隆";

	--Blackrock Spire (Lower)
	["Vaelan"] = "维埃兰";
	["Warosh <The Cursed>"] = "瓦罗什 <被诅咒者>";
	["Elder Stonefort"] = "石墙长者";
	["Roughshod Pike"] = "尖锐长矛";
	["Spirestone Butcher"] = "尖石屠夫";
	["Highlord Omokk"] = "欧莫克大王";
	["Spirestone Battle Lord"] = "尖石统帅";
	["Spirestone Lord Magus"] = "尖石首席法师";
	["Shadow Hunter Vosh'gajin"] = "暗影猎手沃什加斯";
	["Fifth Mosh'aru Tablet"] = "第五块摩沙鲁石板";
	["Bijou"] = "比修";
	["War Master Voone"] = "指挥官沃恩";
	["Mor Grayhoof"] = "莫尔·灰蹄";
	["Sixth Mosh'aru Tablet"] = "第六块摩沙鲁石板";
	["Bijou's Belongings"] = "比修的装置";
	["Human Remains"] = "人类遗骸";
	["Unfired Plate Gauntlets"] = "未淬火的板甲护手";
	["Bannok Grimaxe <Firebrand Legion Champion>"] = "班诺克·巨斧 <火印军团勇士>";
	["Mother Smolderweb"] = "烟网蛛后";
	["Crystal Fang"] = "水晶之牙";
	["Urok's Tribute Pile"] = "乌洛克的贡品堆";
	["Urok Doomhowl"] = "乌洛克";
	["Quartermaster Zigris <Bloodaxe Legion>"] = "军需官兹格雷斯 <血斧军团>";
	["Halycon"] = "哈雷肯";
	["Gizrul the Slavener"] = "奴役者基兹鲁尔";
	["Ghok Bashguud <Bloodaxe Champion>"] = "霍克·巴什古德 <血斧军团的勇士>";
	["Overlord Wyrmthalak"] = "维姆萨拉克";
	["Burning Felguard"] = "燃烧地狱卫士";

	--Blackrock Spire (Upper)
	["Pyroguard Emberseer"] = "烈焰卫士艾博希尔";
	["Solakar Flamewreath"] = "索拉卡·火冠";
	["Father Flame"] = "烈焰之父";
	["Darkstone Tablet"] = "黑暗石板";
	["Doomrigger's Coffer"] = "末日扣环";
	["Jed Runewatcher <Blackhand Legion>"] = "杰德 <黑手军团>";
	["Goraluk Anvilcrack <Blackhand Legion Armorsmith>"] = "古拉鲁克 <黑手军团铸甲师>";
	["Warchief Rend Blackhand"] = "大酋长雷德·黑手";
	["Gyth <Rend Blackhand's Mount>"] = "盖斯 <雷德·黑手的坐骑>";
	["Awbee"] = "奥比";
	["The Beast"] = "比斯巨兽";
	["Lord Valthalak"] = "瓦塔拉克公爵";
	["Finkle Einhorn"] = "芬克·恩霍尔";
	["General Drakkisath"] = "达基萨斯将军";
	["Drakkisath's Brand"] = "达基萨斯的烙印";
	
	--Blackwing Lair
	["Razorgore the Untamed"] = "狂野的拉佐格尔";
	["Vaelastrasz the Corrupt"] = "堕落的瓦拉斯塔兹";
	["Broodlord Lashlayer"] = "勒什雷尔";
	["Firemaw"] = "费尔默";
	["Draconic for Dummies (Chapter VII)"] = "龙语傻瓜教程 (第七章)";
	["Master Elemental Shaper Krixix"] = "大元素师克里希克";
	["Ebonroc"] = "埃博诺克";
	["Flamegor"] = "弗莱格尔";
	["Chromaggus"] = "克洛玛古斯";
	["Nefarian"] = "奈法利安";
	
	--Gnomeregan
	["Workshop Key"] = "车间钥匙";
	["Blastmaster Emi Shortfuse"] = "爆破专家艾米·短线";
	["Grubbis"] = "格鲁比斯";
	["Chomper"] = "咀嚼者";
	["Clean Room"] = "清洗区";
	["Tink Sprocketwhistle <Engineering Supplies>"] = "丁克·铁哨 <工程学供应商>";
	["The Sparklematic 5200"] = "超级清洁器5200型";
	["Mail Box"] = "邮箱";
	["Kernobee"] = "克努比";
	["Alarm-a-bomb 2600"] = "警报炸弹2600型";
	["Matrix Punchograph 3005-B"] = "矩阵式打孔计算机 3005-B";
	["Viscous Fallout"] = "粘性辐射尘";
	["Electrocutioner 6000"] = "电刑器6000型";
	["Matrix Punchograph 3005-C"] = "矩阵式打孔计算机 3005-C";
	["Crowd Pummeler 9-60"] = "群体打击者9-60";
	["Matrix Punchograph 3005-D"] = "矩阵式打孔计算机 3005-D";
	["Dark Iron Ambassador"] = "黑铁大师";
	["Mekgineer Thermaplugg"] = "麦克尼尔·瑟玛普拉格";

	--Molten Core
	["Hydraxian Waterlords"] = "海达希亚水元素";
	["Lucifron"] = "鲁西弗隆";
	["Magmadar"] = "玛格曼达";
	["Gehennas"] = "基赫纳斯";
	["Garr"] = "加尔";
	["Shazzrah"] = "沙斯拉尔";
	["Baron Geddon"] = "迦顿男爵";
	["Golemagg the Incinerator"] = "焚化者古雷曼格";
	["Sulfuron Harbinger"] = "萨弗隆先驱者";
	["Majordomo Executus"] = "管理者埃克索图斯";
	["Ragnaros"] = "拉格纳罗斯";

	--Scholomance
	["Skeleton Key"] = "骷髅钥匙";
	["Viewing Room Key"] = "观察室钥匙";
	["Viewing Room"] = "观察室";
	["Blood of Innocents"] = "无辜者之血";
	["Divination Scryer"] = "预言水晶球";
	["Blood Steward of Kirtonos"] = "基尔图诺斯的卫士";
	["The Deed to Southshore"] = "南海镇地契";
	["Kirtonos the Herald"] = "传令官基尔图诺斯";
	["Jandice Barov"] = "詹迪斯·巴罗夫";
	["The Deed to Tarren Mill"] = "塔伦米尔地契";
	["Rattlegore"] = "血骨傀儡";
	["Death Knight Darkreaver"] = "死亡骑士达克雷尔";
	["Marduk Blackpool"] = "马杜克·布莱克波尔";
	["Vectus"] = "维克图斯";
	["Ras Frostwhisper"] = "莱斯·霜语";
	["The Deed to Brill"] = "布瑞尔地契";
	["Kormok"] = "库尔莫克";
	["Instructor Malicia"] = "讲师玛丽希亚";
	["Doctor Theolen Krastinov <The Butcher>"] = "瑟尔林·卡斯迪诺夫教授 <屠夫>";
	["Lorekeeper Polkelt"] = "博学者普克尔特";
	["The Ravenian"] = "拉文尼亚";
	["Lord Alexei Barov"] = "阿雷克斯·巴罗夫";
	["The Deed to Caer Darrow"] = "凯尔达隆地契";
	["Lady Illucia Barov"] = "伊露希亚·巴罗夫";
	["Darkmaster Gandling"] = "黑暗院长加丁";
	["Torch Lever"] = "火炬";
	["Secret Chest"] = "旧宝藏箱";
	["Alchemy Lab"] = "炼金实验室";

	--Shadowfang Keep
	["Deathsworn Captain"] = "死亡之誓";
	["Rethilgore <The Cell Keeper>"] = "雷希戈尔 <牢房看守>";
	["Sorcerer Ashcrombe"] = "巫师阿克鲁比";
	["Deathstalker Adamant"] = "亡灵哨兵阿达曼特";
	["Landen Stilwell"] = "兰登·斯蒂维尔";
	["Investigator Fezzen Brasstacks"] = "调查员菲赞•铜钉"; -- Needs review
	["Deathstalker Vincent"] = "亡灵哨兵文森特";
	["Apothecary Trio"] = "药剂师三人组"; -- Needs review
	["Apothecary Hummel <Crown Chemical Co.>"] = "药剂师胡默尔 <王冠化学制药公司>"; -- Needs review
	["Apothecary Baxter <Crown Chemical Co.>"] = "药剂师巴克斯特 <王冠化学制药公司>"; -- Needs review
	["Apothecary Frye <Crown Chemical Co.>"] = "药剂师弗莱伊 <王冠化学制药公司>"; -- Needs review
	["Fel Steed"] = "地狱战马";
	["Jordan's Hammer"] = "乔丹的铁锤";
	["Crate of Ingots"] = "铁锭箱";
	["Razorclaw the Butcher"] = "屠夫拉佐克劳";
	["Baron Silverlaine"] = "席瓦莱恩男爵";
	["Commander Springvale"] = "指挥官斯普林瓦尔";
	["Odo the Blindwatcher"] = "盲眼守卫奥杜";
	["Fenrus the Devourer"] = "吞噬者芬鲁斯";
	["Arugal's Voidwalker"] = "阿鲁高的虚空行者";
	["The Book of Ur"] = "乌尔之书";
	["Wolf Master Nandos"] = "狼王南杜斯";
	["Archmage Arugal"] = "大法师阿鲁高";

	--SM: Armory
	["The Scarlet Key"] = "血色十字军钥匙";--omitted from SM: Cathedral
	["Herod <The Scarlet Champion>"] = "赫洛德 <血色十字军勇士>";

	--SM: Cathedral
	["High Inquisitor Fairbanks"] = "大检察官法尔班克斯";
	["Scarlet Commander Mograine"] = "血色十字军指挥官莫格莱尼";
	["High Inquisitor Whitemane"] = "大检察官怀特迈恩";

	--SM: Graveyard
	["Interrogator Vishas"] = "审讯员韦沙斯";
	["Vorrel Sengutz"] = "沃瑞尔·森加斯";
	["Pumpkin Shrine"] = "南瓜神龛";
	["Headless Horseman"] = "无头骑士";
	["Bloodmage Thalnos"] = "血法师萨尔诺斯";
	["Ironspine"] = "铁脊死灵";
	["Azshir the Sleepless"] = "永醒的艾希尔";
	["Fallen Champion"] = "死灵勇士";
	
	--SM: Library
	["Houndmaster Loksey"] = "驯犬者洛克希";
	["Arcanist Doan"] = "奥法师杜安";

	--Stratholme
	["The Scarlet Key"] = "血色十字军钥匙";
	["Key to the City"] = "城市大门钥匙";
	["Various Postbox Keys"] = "邮箱钥匙";
	["Living Side"] = "血色区";
	["Undead Side"] = "亡灵区";
	["Skul"] = "斯库尔";
	["Stratholme Courier"] = "斯坦索姆信使";
	["Fras Siabi"] = "弗拉斯·希亚比";
	["Atiesh <Hand of Sargeras>"] = "埃提耶什 <萨格拉斯之手>";
	["Hearthsinger Forresten"] = "弗雷斯特恩";
	["The Unforgiven"] = "不可宽恕者";
	["Elder Farwhisper"] = "远风长者";
	["Timmy the Cruel"] = "悲惨的提米";
	["Malor the Zealous"] = "狂热的玛洛尔";
	["Malor's Strongbox"] = "玛洛尔的保险箱";
	["Crimson Hammersmith"] = "红衣铸锤师";
	["Cannon Master Willey"] = "炮手威利";
	["Archivist Galford"] = "档案管理员加尔福特";
	["Grand Crusader Dathrohan"] = "大十字军战士达索汉";
	["Balnazzar"] = "巴纳扎尔";
	["Sothos"] = "索托斯";
	["Jarien"] = "亚雷恩";
	["Magistrate Barthilas"] = "巴瑟拉斯镇长";
	["Aurius"] = "奥里克斯";
	["Stonespine"] = "石脊";
	["Baroness Anastari"] = "安娜丝塔丽男爵夫人";
	["Black Guard Swordsmith"] = "黑衣守卫铸剑师";
	["Nerub'enkan"] = "奈鲁布恩坎";
	["Maleki the Pallid"] = "苍白的玛勒基";
	["Ramstein the Gorger"] = "吞咽者拉姆斯登";
	["Baron Rivendare"] = "瑞文戴尔男爵";
	["Ysida Harmon"] = "伊思达·哈尔蒙";
	["Crusaders' Square Postbox"] = "十字军广场邮箱";
	["Market Row Postbox"] = "市场邮箱";
	["Festival Lane Postbox"] = "节日小道邮箱";
	["Elders' Square Postbox"] = "长者广场邮箱";
	["King's Square Postbox"] = "国王广场邮箱";
	["Fras Siabi's Postbox"] = "弗拉斯·希亚比的邮箱";
	["3rd Box Opened"] = "打开三个邮箱后";
	["Postmaster Malown"] = "邮差马龙";

	--The Deadmines
	["Rhahk'Zor <The Foreman>"] = "拉克佐 <工头>";
	["Miner Johnson"] = "矿工约翰森";
	["Sneed <Lumbermaster>"] = "斯尼德 <伐木工头>";
	["Sneed's Shredder <Lumbermaster>"] = "斯尼德的伐木机 <伐木工头>";
	["Gilnid <The Smelter>"] = "基尔尼格 <熔炼师>";
	["Defias Gunpowder"] = "迪菲亚火药";
	["Captain Greenskin"] = "绿皮队长";
	["Edwin VanCleef <Defias Kingpin>"] = "艾德温·范克里夫 <迪菲亚兄弟会首脑>";
	["Mr. Smite <The Ship's First Mate>"] = "重拳先生 <船上的大副>";
	["Cookie <The Ship's Cook>"] = "曲奇 <船上的厨师>";
	
	--The Stockade
	["Targorr the Dread"] = "可怕的塔格尔";
	["Kam Deepfury"] = "卡姆·深怒";
	["Hamhock"] = "哈姆霍克";
	["Bazil Thredd"] = "巴基尔·斯瑞德";
	["Dextren Ward"] = "迪克斯特·瓦德";
	["Bruegal Ironknuckle"] = "布鲁高·铁拳";

	--The Sunken Temple
	["The Temple of Atal'Hakkar"] = "阿塔哈卡神庙";
	["Yeh'kinya's Scroll"] = "叶基亚的卷轴";
	["Atal'ai Defenders"] = "阿塔莱防御者";
	["Gasher"] = "加什尔";
	["Loro"] = "洛若尔";
	["Hukku"] = "胡库";
	["Zolo"] = "祖罗";
	["Mijan"] = "米杉";
	["Zul'Lor"] = "祖罗尔";
	["Altar of Hakkar"] = "哈卡祭坛";
	["Atal'alarion <Guardian of the Idol>"] = "阿塔拉利恩 <护卫者>";
	["Dreamscythe"] = "德姆赛卡尔";
	["Weaver"] = "德拉维沃尔";
	["Avatar of Hakkar"] = "哈卡的化身";
	["Jammal'an the Prophet"] = "预言者迦玛兰";
	["Ogom the Wretched"] = "可悲的奥戈姆";
	["Morphaz"] = "摩弗拉斯";
	["Hazzas"] = "哈扎斯";
	["Shade of Eranikus"] = "伊兰尼库斯的阴影";
	["Essence Font"] = "精华之泉";
	["Spawn of Hakkar"] = "哈卡的后代";
	["Elder Starsong"] = "星歌长者";
	["Statue Activation Order"] = "雕像激活顺序";
	
	--Uldaman
	["Staff of Prehistoria"] = "史前法杖";
	["Baelog"] = "巴尔洛戈";
	["Eric \"The Swift\""] = "艾瑞克";
	["Olaf"] = "奥拉夫";
	["Baelog's Chest"] = "巴尔洛戈的箱子";
	["Conspicuous Urn"] = "显眼的石罐";
	["Remains of a Paladin"] = "圣骑士的遗体";
	["Revelosh"] = "鲁维罗什";
	["Ironaya"] = "艾隆纳亚";
	["Obsidian Sentinel"] = "黑曜石哨兵";
	["Annora <Enchanting Trainer>"] = "安诺拉 <大师级附魔师>";
	["Ancient Stone Keeper"] = "古代的石头看守者";
	["Galgann Firehammer"] = "加加恩·火锤";
	["Tablet of Will"] = "意志石板";
	["Shadowforge Cache"] = "暗影熔炉地窖";
	["Grimlok <Stonevault Chieftain>"] = "格瑞姆洛克 <石窟酋长>";
	["Archaedas <Ancient Stone Watcher>"] = "阿扎达斯 <远古石卫士>";
	["The Discs of Norgannon"] = "诺甘农圆盘";
	["Ancient Treasure"] = "古代宝藏";
	
	--Zul'Gurub
	["Zandalar Tribe"] = "赞达拉部族";
	["Mudskunk Lure"] = "臭泥鱼诱饵";
	["Gurubashi Mojo Madness"] = "古拉巴什疯狂魔精";
	["High Priestess Jeklik"] = "高阶祭司耶克里克";
	["High Priest Venoxis"] = "高阶祭司温诺西斯";
	["Zanza the Restless"] = "无眠者赞扎";
	["High Priestess Mar'li"] = "高阶祭司玛尔里";
	["Bloodlord Mandokir"] = "血领主曼多基尔";
	["Ohgan"] = "奥根";
	["Edge of Madness"] = "疯狂之源";
	["Gri'lek"] = "格里雷克";
	["Hazza'rah"] = "哈扎拉尔";
	["Renataki"] = "雷纳塔基";
	["Wushoolay"] = "乌苏雷";
	["Gahz'ranka"] = "加兹兰卡";
	["High Priest Thekal"] = "高阶祭司塞卡尔";
	["Zealot Zath"] = "狂热者扎斯";
	["Zealot Lor'Khan"] = "狂热者洛卡恩";
	["High Priestess Arlokk"] = "高阶祭司娅尔罗";
	["Jin'do the Hexxer"] = "妖术师金度";
	["Hakkar"] = "哈卡";
	["Muddy Churning Waters"] = "混浊的水";
	
--*******************
-- Burning Crusade Instances
--*******************

	--Auch: Auchenai Crypts
	["Lower City"] = "贫民窟";--omitted from other Auch
	["Shirrak the Dead Watcher"] = "死亡观察者希尔拉克";
	["Exarch Maladaar"] = "大主教玛拉达尔";
	["Avatar of the Martyred"] = "殉难者的化身";
	["D'ore"] = "德欧里";

	--Auch: Mana-Tombs
	["The Consortium"] = "星界财团";
	["Auchenai Key"] = "奥金尼钥匙";--omitted from other Auch
	["The Eye of Haramad"] = "哈拉迈德之眼";
	["Pandemonius"] = "潘德莫努斯";
	["Shadow Lord Xiraxis"] = "暗影领主希拉卡希斯";
	["Ambassador Pax'ivi"] = "帕克希维大使";
	["Tavarok"] = "塔瓦洛克";
	["Cryo-Engineer Sha'heen"] = "低温工程师沙赫恩";
	["Ethereal Transporter Control Panel"] = "虚灵传送器控制台";
	["Nexus-Prince Shaffar"] = "节点亲王沙法尔";
	["Yor <Void Hound of Shaffar>"] = "尤尔 <沙法尔的虚空猎犬>";

	--Auch: Sethekk Halls
	["Essence-Infused Moonstone"] = "灌注精华的月亮石";
	["Darkweaver Syth"] = "黑暗编织者塞斯";
	["Lakka"] = "拉卡";
	["The Saga of Terokk"] = "泰罗克的传说";
	["Anzu"] = "安苏";
	["Talon King Ikiss"] = "利爪之王艾吉斯";

	--Auch: Shadow Labyrinth
	["Shadow Labyrinth Key"] = "暗影迷宫钥匙";
	["Spy To'gun"] = "间谍托古恩";
	["Ambassador Hellmaw"] = "赫尔默大使";
	["Blackheart the Inciter"] = "煽动者布莱卡特";
	["Grandmaster Vorpil"] = "沃匹尔大师";
	["The Codex of Blood"] = "鲜血法典";
	["Murmur"] = "摩摩尔";
	["First Fragment Guardian"] = "第一块碎片的守护者";

	--Black Temple (Start)
	["Ashtongue Deathsworn"] = "灰舌死誓者";--omitted from other BT
	["Towards Reliquary of Souls"] = "通往灵魂之匣";
	["Towards Teron Gorefiend"] = "通往塔隆·血魔";
	["Towards Illidan Stormrage"] = "通往伊利丹·怒风";
	["Spirit of Olum"] = "奥鲁姆之魂";
	["High Warlord Naj'entus"] = "高阶督军纳因图斯";
	["Supremus"] = "苏普雷姆斯";
	["Shade of Akama"] = "阿卡玛之影";
	["Spirit of Udalo"] = "乌达鲁之魂";
	["Aluyen <Reagents>"] = "奥鲁尤 <材料商>";
	["Okuno <Ashtongue Deathsworn Quartermaster>"] = "沃库诺 <灰舌死誓者军需官>";
	["Seer Kanai"] = "先知坎奈";

	--Black Temple (Basement)
	["Gurtogg Bloodboil"] = "古尔图格·血沸";
	["Reliquary of Souls"] = "灵魂之匣";
	["Essence of Suffering"] = "愤怒精华";
	["Essence of Desire"] = "欲望精华";
	["Essence of Anger"] = "苦痛精华";
	["Teron Gorefiend"] = "塔隆·血魔";

	--Black Temple (Top)
	["Mother Shahraz"] = "莎赫拉丝主母";
	["The Illidari Council"] = "伊利达雷议会";
	["Lady Malande"] = "女公爵玛兰德";
	["Gathios the Shatterer"] = "击碎者加西奥斯";
	["High Nethermancer Zerevor"] = "高阶灵术师塞勒沃尔";
	["Veras Darkshadow"] = "薇尔莱丝·深影";
	["Illidan Stormrage <The Betrayer>"] = "伊利丹·怒风 <背叛者>";

	--CFR: Serpentshrine Cavern
	["Hydross the Unstable <Duke of Currents>"] = "不稳定的海度斯 <水流公爵>";
	["The Lurker Below"] = "鱼斯拉";
	["Leotheras the Blind"] = "盲眼者莱欧瑟拉斯";
	["Fathom-Lord Karathress"] = "深水领主卡拉瑟雷斯";
	["Seer Olum"] = "先知奥鲁姆";
	["Morogrim Tidewalker"] = "莫洛格里·踏潮者";
	["Lady Vashj <Coilfang Matron>"] = "瓦丝琪 <盘牙女王>";

	--CFR: The Slave Pens
	["Cenarion Expedition"] = "塞纳里奥远征队";--omitted from other CR
	["Reservoir Key"] = "水库钥匙";--omitted from other CR
	["Mennu the Betrayer"] = "背叛者门努";
	["Weeder Greenthumb"] = "除草者格林萨姆";
	["Skar'this the Heretic"] = "异教徒斯卡希斯";
	["Rokmar the Crackler"] = "巨钳鲁克玛尔";
	["Naturalist Bite"] = "博学者拜特";
	["Quagmirran"] = "夸格米拉";
	["Ahune <The Frost Lord>"] = "埃霍恩 <冰霜之王>";

	--CFR: The Steamvault
	["Hydromancer Thespia"] = "水术师瑟丝比娅";
	["Main Chambers Access Panel"] = "主厅控制面板";
	["Second Fragment Guardian"] = "第二块碎片的守护者";
	["Mekgineer Steamrigger"] = "机械师斯蒂里格";
	["Warlord Kalithresh"] = "督军卡利瑟里斯";

	--CFR: The Underbog
	["Hungarfen"] = "霍加尔芬";
	["The Underspore"] = "幽暗孢子";
	["Ghaz'an"] = "加兹安";
	["Earthbinder Rayge"] = "缚地者雷葛";
	["Swamplord Musel'ek"] = "沼地领主穆塞雷克";
	["Claw <Swamplord Musel'ek's Pet>"] = "克劳恩 <沼地领主穆塞雷克的宠物>";
	["The Black Stalker"] = "黑色阔步者";

	--CoT: The Black Morass
	["Opening of the Dark Portal"] = "开启黑暗之门";
	["Keepers of Time"] = "时光守护者";--omitted from Old Hillsbrad Foothills
	["Key of Time"] = "时光之匙";--omitted from Old Hillsbrad Foothills
	["Sa'at <Keepers of Time>"] = "萨艾特 <时光守护者>";
	["Chrono Lord Deja"] = "时空领主德亚";
	["Temporus"] = "坦普卢斯";
	["Aeonus"] = "埃欧努斯";
	["The Dark Portal"] = "黑暗之门";
	["Medivh"] = "麦迪文";

	--CoT: Hyjal Summit
	["Battle for Mount Hyjal"] = "海加尔之战";
	["The Scale of the Sands"] = "流沙之鳞";
	["Alliance Base"] = "联盟基地";
	["Lady Jaina Proudmoore"] = "吉安娜·普罗德摩尔";
	["Horde Encampment"] = "部落营地";
	["Thrall <Warchief>"] = "萨尔 <酋长>";
	["Night Elf Village"] = "暗夜精灵村庄";
	["Tyrande Whisperwind <High Priestess of Elune>"] = "泰兰德·语风 <艾露恩的高阶女祭司>";
	["Rage Winterchill"] = "雷基·冬寒";
	["Anetheron"] = "安纳塞隆";
	["Kaz'rogal"] = "卡兹洛加";
	["Azgalor"] = "阿兹加洛";
	["Archimonde"] = "阿克蒙德";
	["Indormi <Keeper of Ancient Gem Lore>"] = "因多米 <上古宝石保管者>";
	["Tydormu <Keeper of Lost Artifacts>"] = "泰多姆 <失落的神器保管者>";

	--CoT: Old Hillsbrad Foothills
	["Escape from Durnholde Keep"] = "逃离敦霍尔德堡";
	["Erozion"] = "伊洛希恩";
	["Brazen"] = "布拉森";
	["Landing Spot"] = "着陆点";
	["Lieutenant Drake"] = "德拉克中尉";
	["Thrall"] = "萨尔";
	["Captain Skarloc"] = "斯卡洛克上尉";
	["Epoch Hunter"] = "时空猎手";
	["Taretha"] = "塔蕾莎";
	["Jonathan Revah"] = "乔纳森·雷瓦";
	["Jerry Carter"] = "杰瑞·卡特尔";
	["Traveling"] = "旅行中";
	["Thomas Yance <Travelling Salesman>"] = "托马斯·杨斯 <旅行商人>";
	["Aged Dalaran Wizard"] = "老迈的达拉然巫师";
	["Kel'Thuzad <The Kirin Tor>"] = "克尔苏加德 <肯瑞托>";
	["Helcular"] = "赫尔库拉";
	["Farmer Kent"] = "农夫肯特";
	["Sally Whitemane"] = "萨莉·怀特迈恩";
	["Renault Mograine"] = "雷诺·莫格莱尼";
	["Little Jimmy Vishas"] = "吉米·维沙斯";
	["Herod the Bully"] = "赫洛德";
	["Nat Pagle"] = "纳特·帕格";
	["Hal McAllister"] = "哈尔·马克奥里斯特";
	["Zixil <Aspiring Merchant>"] = "吉克希尔 <有抱负的商人>";
	["Overwatch Mark 0 <Protector>"] = "守候者零型 <保护者>";
	["Southshore Inn"] = "南海镇旅馆";
	["Captain Edward Hanes"] = "爱德华·汉斯";
	["Captain Sanders"] = "杉德尔船长";
	["Commander Mograine"] = "指挥官莫格莱尼";
	["Isillien"] = "伊森利恩";
	["Abbendis"] = "阿比迪斯";
	["Fairbanks"] = "法尔班克斯";
	["Tirion Fordring"] = "提里奥·弗丁";
	["Arcanist Doan"] = "奥法师杜安";
	["Taelan"] = "泰兰";
	["Barkeep Kelly <Bartender>"] = "酒吧招待凯利 <调酒师>";
	["Frances Lin <Barmaid>"] = "弗兰斯·林 <招待员>";
	["Chef Jessen <Speciality Meat & Slop>"] = "厨师杰森 <美食大师>";
	["Stalvan Mistmantle"] = "斯塔文·密斯特曼托";
	["Phin Odelic <The Kirin Tor>"] = "费恩·奥德利克 <肯瑞托>";
	["Magistrate Henry Maleb"] = "赫尼·马雷布镇长";
	["Raleigh the True"] = "虔诚的莱雷恩";
	["Nathanos Marris"] = "纳萨诺斯·玛瑞斯";
	["Bilger the Straight-laced"] = "古板的比格尔";
	["Innkeeper Monica"] = "旅店老板莫妮卡";
	["Julie Honeywell"] = "朱丽·哈尼维尔";
	["Jay Lemieux"] = "贾森·雷缪克斯";
	["Young Blanchy"] = "小马布兰契";
	["Don Carlos"] = "卡洛斯";
	["Guerrero"] = "古雷罗";

	--Gruul's Lair
	["High King Maulgar <Lord of the Ogres>"] = "莫加尔大王 <食人魔之王>";
	["Kiggler the Crazed"] = "疯狂的基戈尔";
	["Blindeye the Seer"] = "盲眼先知";
	["Olm the Summoner"] = "召唤者沃尔姆";
	["Krosh Firehand"] = "克洛什·火拳";
	["Gruul the Dragonkiller"] = "屠龙者格鲁尔";

	--HFC: The Blood Furnace
	["Thrallmar"] = "萨尔玛";--omitted from other HFC
	["Honor Hold"] = "荣耀堡";--omitted from other HFC
	["Flamewrought Key"] = "焰铸钥匙";--omitted from other HFC
	["The Maker"] = "制造者";
	["Broggok"] = "布洛戈克";
	["Keli'dan the Breaker"] = "击碎者克里丹";

	--HFC: Hellfire Ramparts
	["Watchkeeper Gargolmar"] = "巡视者加戈玛";
	["Omor the Unscarred"] = "无疤者奥摩尔";
	["Vazruden"] = "传令官瓦兹德";
	["Nazan <Vazruden's Mount>"] = "纳杉 <瓦兹德的坐骑>";
	["Reinforced Fel Iron Chest"] = "强化魔铁箱";

	--HFC: Magtheridon's Lair
	["Magtheridon"] = "玛瑟里顿";

	--HFC: The Shattered Halls
	["Shattered Halls Key"] = "碎裂大厅钥匙";
	["Randy Whizzlesprocket"] = "兰迪·维兹普罗克";
	["Drisella"] = "德雷希拉";
	["Grand Warlock Nethekurse"] = "高阶术士奈瑟库斯";
	["Blood Guard Porung"] = "血卫士伯鲁恩";
	["Warbringer O'mrogg"] = "战争使者沃姆罗格";
	["Warchief Kargath Bladefist"] = "酋长卡加斯·刃拳";
	["Shattered Hand Executioner"] = "碎手斩杀者";
	["Private Jacint"] = "列兵亚森特";
	["Rifleman Brownbeard"] = "火枪手布隆恩·棕须";
	["Captain Alina"] = "奥琳娜上尉";
	["Scout Orgarr"] = "斥候奥贾尔";
	["Korag Proudmane"] = "克拉格·傲鬃";
	["Captain Boneshatter"] = "沙塔·碎骨上尉";

	--Karazhan Start
	["The Violet Eye"] = "紫罗兰之眼";--omitted from Karazhan End
	["The Master's Key"] = "麦迪文的钥匙";--omitted from Karazhan End
	["Staircase to the Ballroom"] = "通往宴会厅的楼梯";
	["Stairs to Upper Stable"] = "通往马厩上层的楼梯";
	["Ramp to the Guest Chambers"] = "通往会客间的斜坡";
	["Stairs to Opera House Orchestra Level"] = "通往歌剧院正厅的楼梯";
	["Ramp from Mezzanine to Balcony"] = "楼座与露台间的斜坡";
	["Connection to Master's Terrace"] = "通往主宰的露台";
	["Path to the Broken Stairs"] = "通往破碎阶梯的通道";--omitted from Karazhan End
	["Hastings <The Caretaker>"] = "哈斯汀斯 <看管者>";
	["Servant Quarters"] = "仆人区";
	["Hyakiss the Lurker"] = "潜伏者希亚其斯";
	["Rokad the Ravager"] = "蹂躏者洛卡德";
	["Shadikith the Glider"] = "滑翔者沙德基斯";
	["Berthold <The Doorman>"] = "伯特霍德 <门卫>";
	["Calliard <The Nightman>"] = "卡利亚德 <清洁工>";
	["Attumen the Huntsman"] = "猎手阿图门";
	["Midnight"] = "午夜";
	["Koren <The Blacksmith>"] = "库雷恩 <铁匠>";
	["Moroes <Tower Steward>"] = "莫罗斯 <管家>";
	["Baroness Dorothea Millstipe"] = "杜萝希·米尔斯提女伯爵";
	["Lady Catriona Von'Indi"] = "卡翠欧娜·冯因迪女伯爵";
	["Lady Keira Berrybuck"] = "吉拉·拜瑞巴克女伯爵";
	["Baron Rafe Dreuger"] = "拉弗·杜格尔男爵";
	["Lord Robin Daris"] = "罗宾·达瑞斯伯爵";
	["Lord Crispin Ference"] = "克里斯宾·费伦斯伯爵";
	["Bennett <The Sergeant at Arms>"] = "本内特 <警卫>";
	["Ebonlocke <The Noble>"] = "埃伯洛克 <贵族>";
	["Keanna's Log"] = "金娜的日记";
	["Maiden of Virtue"] = "贞节圣女";
	["Sebastian <The Organist>"] = "塞巴斯蒂安 <风琴手>";
	["Barnes <The Stage Manager>"] = "巴内斯 <舞台管理员>";
	["The Opera Event"] = "歌剧院事件";
	["Red Riding Hood"] = "小红帽";
	["The Big Bad Wolf"] = "大灰狼";
	["Wizard of Oz"] = "绿野仙踪";
	["Dorothee"] = "多萝茜";
	["Tito"] = "托托";
	["Strawman"] = "稻草人";
	["Tinhead"] = "铁皮人";
	["Roar"] = "胆小的狮子";
	["The Crone"] = "巫婆";
	["Romulo and Julianne"] = "罗密欧与朱丽叶";
	["Romulo"] = "罗密欧";
	["Julianne"] = "朱丽叶";
	["The Master's Terrace"] = "主宰的露台";
	["Nightbane"] = "夜之魇";

	--Karazhan End
	["Broken Stairs"] = "破碎阶梯";
	["Ramp to Guardian's Library"] = "通往守护者的图书馆的斜坡";
	["Suspicious Bookshelf"] = "奇怪的书架";
	["Ramp up to the Celestial Watch"] = "通往观星大厅的斜坡";
	["Ramp down to the Gamesman's Hall"] = "通往象棋大厅的斜坡";
	["Chess Event"] = "象棋事件";
	["Ramp to Medivh's Chamber"] = "通往麦迪文房间的斜坡";
	["Spiral Stairs to Netherspace"] = "通往虚空异界的楼梯";
	["The Curator"] = "馆长";
	["Wravien <The Mage>"] = "拉维恩 <法师>";
	["Gradav <The Warlock>"] = "格拉达夫 <术士>";
	["Kamsis <The Conjurer>"] = "卡姆希丝 <咒术师>";
	["Terestian Illhoof"] = "特雷斯坦·邪蹄";
	["Kil'rek"] = "基尔里克";
	["Shade of Aran"] = "埃兰之影";
	["Netherspite"] = "虚空幽龙";
	["Ythyar"] = "伊萨尔";
	["Echo of Medivh"] = "麦迪文的回音";
	["Dust Covered Chest"] = "灰尘覆盖的箱子";
	["Prince Malchezaar"] = "玛克扎尔王子";
	
	--Magisters Terrace
	["Shattered Sun Offensive"] = "破碎残阳";
	["Selin Fireheart"] = "塞林·火心";
	["Fel Crystals"] = "邪能水晶";
	["Tyrith"] = "塔雷斯";
	["Vexallus"] = "维萨鲁斯";
	["Scrying Orb"] = "占卜宝珠";
	["Kalecgos"] = "卡雷苟斯";--omitted from SP
	["Priestess Delrissa"] = "女祭司德莉希亚";
	["Apoko"] = "埃波克";
	["Eramas Brightblaze"] = "埃拉玛斯·炽光";
	["Ellrys Duskhallow"] = "艾尔蕾丝";
	["Fizzle"] = "菲兹尔";
	["Garaxxas"] = "贾拉克萨斯";
	["Sliver <Garaxxas' Pet>"] = "脆皮 <贾拉克萨斯的宠物>";
	["Kagani Nightstrike"] = "卡加尼·夜锋";
	["Warlord Salaris"] = "督军沙拉利斯";
	["Yazzai"] = "亚赛";
	["Zelfan"] = "扎尔凡";
	["Kael'thas Sunstrider <Lord of the Blood Elves>"] = "凯尔萨斯·逐日者 <血精灵之王>";--omitted from TK: The Eye

	--Sunwell Plateau
	["Sathrovarr the Corruptor"] = "腐蚀者萨索瓦尔";
	["Madrigosa"] = "玛蒂苟萨";
	["Brutallus"] = "布鲁塔卢斯";
	["Felmyst"] = "菲米丝";
	["Eredar Twins"] = "艾瑞达双子";
	["Grand Warlock Alythess"] = "高阶术士奥蕾塞丝";
	["Lady Sacrolash"] = "萨洛拉丝女王";
	["M'uru"] = "穆鲁";
	["Entropius"] = "熵魔";
	["Kil'jaeden <The Deceiver>"] = "基尔加丹 <欺诈者>";

	--TK: The Arcatraz
	["Key to the Arcatraz"] = "禁魔监狱钥匙";
	["Zereketh the Unbound"] = "自由的瑟雷凯斯";
	["Third Fragment Guardian"] = "第三块碎片的守护者";
	["Dalliah the Doomsayer"] = "末日预言者达尔莉安";
	["Wrath-Scryer Soccothrates"] = "天怒预言者苏克拉底";
	["Udalo"] = "先知乌达鲁";
	["Harbinger Skyriss"] = "预言者斯克瑞斯";
	["Warden Mellichar"] = "监护者梅里卡尔";
	["Millhouse Manastorm"] = "米尔豪斯·法力风暴";

	--TK: The Botanica
	["The Sha'tar"] = "沙塔尔";--omitted from other TK
	["Warpforged Key"] = "星船钥匙";--omitted from other TK
	["Commander Sarannis"] = "指挥官萨拉妮丝";
	["High Botanist Freywinn"] = "高级植物学家弗雷温";
	["Thorngrin the Tender"] = "看管者索恩格林";
	["Laj"] = "拉伊";
	["Warp Splinter"] = "迁跃扭木";

	--TK: The Mechanar
	["Gatewatcher Gyro-Kill"] = "看守者盖罗基尔";
	["Gatewatcher Iron-Hand"] = "看守者埃隆汉";
	["Cache of the Legion"] = "军团宝箱";
	["Mechano-Lord Capacitus"] = "机械领主卡帕西图斯";
	["Overcharged Manacell"] = "超载的魔法晶格";
	["Nethermancer Sepethrea"] = "灵术师塞比瑟蕾";
	["Pathaleon the Calculator"] = "计算者帕萨雷恩";

	--TK: The Eye
	["Al'ar <Phoenix God>"] = "奥 <凤凰之神>";
	["Void Reaver"] = "空灵机甲";
	["High Astromancer Solarian"] = "大星术师索兰莉安";
	["Thaladred the Darkener <Advisor to Kael'thas>"] = "亵渎者萨拉德雷 <凯尔萨斯的顾问>";
	["Master Engineer Telonicus <Advisor to Kael'thas>"] = "首席技师塔隆尼库斯 <凯尔萨斯的顾问>";
	["Grand Astromancer Capernian <Advisor to Kael'thas>"] = "星术师卡波妮娅 <凯尔萨斯的顾问>";
	["Lord Sanguinar <The Blood Hammer>"] = "萨古纳尔男爵 <鲜血之锤>";

	--Zul'Aman
	["Harrison Jones"] = "哈里森·琼斯";
	["Nalorakk <Bear Avatar>"] = "纳洛拉克 <野熊的化身>";
	["Tanzar"] = "坦扎尔";
	["The Map of Zul'Aman"] = "巴德的祖阿曼地图";
	["Akil'Zon <Eagle Avatar>"] = "埃基尔松 <雄鹰的化身>";
	["Harkor"] = "哈考尔";
	["Jan'Alai <Dragonhawk Avatar>"] = "加亚莱 <龙鹰的化身>";
	["Kraz"] = "克拉斯";
	["Halazzi <Lynx Avatar>"] = "哈尔拉兹 <山猫的化身>";
	["Ashli"] = "阿什莉";
	["Zungam"] = "苏加姆";
	["Hex Lord Malacrass"] = "妖术领主玛拉卡斯";
	["Thurg"] = "索尔格";
	["Gazakroth"] = "卡扎克洛斯";
	["Lord Raadan"] = "兰尔丹";
	["Darkheart"] = "黑心";
	["Alyson Antille"] = "阿莱松·安提雷";
	["Slither"] = "滑行者";
	["Fenstalker"] = "沼泽猎手";
	["Koragg"] = "库拉格";
	["Zul'jin"] = "祖尔金";
	["Forest Frogs"] = "丛林蛙, 其原型为: ";
	["Kyren <Reagents>"] = "凯雷 <材料商>";
	["Gunter <Food Vendor>"] = "冈特尔 <食物商人>";
	["Adarrah"] = "埃达尔拉";
	["Brennan"] = "布雷南";
	["Darwen"] = "达尔文";
	["Deez"] = "迪斯";
	["Galathryn"] = "加拉瑟林";
	["Mitzi"] = "米兹";
	["Mannuth"] = "曼努斯";

--*****************
-- WotLK Instances
--*****************

	--Azjol-Nerub: Ahn'kahet: The Old Kingdom
	["Elder Nadox"] = "纳多克斯长老";
	["Prince Taldaram"] = "塔达拉姆王子";
	["Jedoga Shadowseeker"] = "耶戈达·觅影者";
	["Herald Volazj"] = "传令官沃拉兹";
	["Amanitar"] = "埃曼尼塔";
	["Ahn'kahet Brazier"] = "安卡赫特火盆";

	--Azjol-Nerub: Azjol-Nerub
	["Krik'thir the Gatewatcher"] = "看门者克里克希尔 ";
	["Watcher Gashra"] = "看守者加什拉";
	["Watcher Narjil"] = "看守者纳尔伊";
	["Watcher Silthik"] = "看守者希尔希克";
	["Hadronox"] = "哈多诺克斯";
	["Elder Nurgen"] = "Elder Nurgen";
	["Anub'arak"] = "阿努巴拉克";
	
	--Caverns of Time: The Culling of Stratholme
	["The Culling of Stratholme"] = "净化斯坦索姆";
	["Meathook"] = "肉钩";
	["Salramm the Fleshcrafter"] = "塑血者沙尔拉姆";
	["Chrono-Lord Epoch"] = "时光领主埃博克";
	["Mal'Ganis"] = "玛尔加尼斯";
	["Chromie"] = "克罗米";
	["Infinite Corruptor"] = "永恒腐蚀者";
	["Guardian of Time"] = "时光守护者";
	["Scourge Invasion Points"] = "天灾入侵点";

	--Drak'Tharon Keep
	["Trollgore"] = "托尔戈";
	["Novos the Summoner"] = "召唤者诺沃斯";
	["Elder Kilias"] = "Elder Kilias";
	["King Dred"] = "暴龙之王爵德";
	["The Prophet Tharon'ja"] = "先知萨隆亚";
	["Kurzel"] = "库塞尔";
	["Drakuru's Brazier"] = "达库鲁的火盆";
	
	--The Frozen Halls: Halls of Reflection
	--3 beginning NPCs omitted, see The Forge of Souls
	["Falric"] = "法勒瑞克";
	["Marwyn"] = "麦尔温";
	["Wrath of the Lich King"] = "巫妖王之怒";
	["The Captain's Chest"] = "船长的箱子";

	--The Frozen Halls: Pit of Saron
	--6 beginning NPCs omitted, see The Forge of Souls
	["Forgemaster Garfrost"] = "锻造大师加弗罗斯";
	["Martin Victus"] = "马汀•维特斯";
	["Gorkun Ironskull"] = "葛刚•铁颅";
	["Krick and Ick"] = "克瑞克和艾克";
	["Scourgelord Tyrannus"] = "天谴领主提朗纽斯";
	["Rimefang"] = "霜牙";

	--The Frozen Halls: The Forge of Souls
	--Lady Jaina Proudmoore omitted, in Hyjal Summit
	["Archmage Koreln <Kirin Tor>"] = "大法师寇瑞伦 <祈伦托>";
	["Archmage Elandra <Kirin Tor>"] = "大法师伊兰卓 <祈伦托>";
	["Lady Sylvanas Windrunner <Banshee Queen>"] = "希瓦娜斯•风行者女士 <女妖之王>";
	["Dark Ranger Loralen"] = "黑暗游侠洛拉伦";
	["Dark Ranger Kalira"] = "黑暗游侠卡丽菈";
	["Bronjahm <Godfather of Souls>"] = "布朗吉姆 <众魂教父>";
	["Devourer of Souls"] = "众魂吞噬者";

	--Gundrak
	["Slad'ran <High Prophet of Sseratus>"] = "斯拉德兰 <西莱图斯的高阶先知>";
	["Drakkari Colossus"] = "达卡莱巨像";
	["Elder Ohanzee"] = "Elder Ohanzee";
	["Moorabi <High Prophet of Mam'toth>"] = "莫拉比 <犸托斯的高阶先知>";
	["Gal'darah <High Prophet of Akali>"] = "迦尔达拉 <阿卡里的高阶先知>";
	["Eck the Ferocious"] = "凶残的伊克";

	--Icecrown Citadel
	["The Ashen Verdict"] = "灰烬裁决军"; -- Needs review after WoW 3.3.3 is available in China
	["Lord Marrowgar"] = "玛洛嘉领主"; -- Needs review after WoW 3.3.3 is available in China
	["Lady Deathwhisper"] = "亡语女士"; -- Needs review after WoW 3.3.3 is available in China
	["Gunship Battle"] = "炮艇战"; -- Needs review after WoW 3.3.3 is available in China
	["Deathbringer Saurfang"] = "死亡使者萨鲁法尔"; -- Needs review after WoW 3.3.3 is available in China
	["Festergut"] = "脓肠"; -- Needs review after WoW 3.3.3 is available in China
	["Rotface"] = "腐脸"; -- Needs review after WoW 3.3.3 is available in China
	["Professor Putricide"] = "普崔希德教授"; -- Needs review after WoW 3.3.3 is available in China
	["Blood Prince Council"] = "血亲王议会"; -- Needs review after WoW 3.3.3 is available in China
	["Prince Keleseth"] = "凯雷希斯王子"; -- Needs review after WoW 3.3.3 is available in China
	["Prince Taldaram"] = "泰尔达朗王子"; -- Needs review after WoW 3.3.3 is available in China
	["Prince Valanar"] = "瓦拉纳尔王子"; -- Needs review after WoW 3.3.3 is available in China
	["Blood-Queen Lana'thel"] = "血腥女王菈娜萨尔"; -- Needs review after WoW 3.3.3 is available in China
	["Valithria Dreamwalker"] = "瓦莉丝瑞雅•梦行者"; -- Needs review after WoW 3.3.3 is available in China
	["Sindragosa <Queen of the Frostbrood>"] = "辛德拉苟莎 <霜育之后>"; -- Needs review after WoW 3.3.3 is available in China
	["The Lich King"] = "巫妖王"; -- Needs review after WoW 3.3.3 is available in China
	["To next map"] = "到下一个地图";
	["From previous map"] = "到前一个地图";
	["Upper Spire"] = "冰冠尖塔"; -- Needs review after WoW 3.3.3 is available in China
	["Sindragosa's Lair"] = "辛德拉苟莎之巢"; -- Needs review after WoW 3.3.3 is available in China

	--Naxxramas
	["Mr. Bigglesworth"] = "比格沃斯";
	["Patchwerk"] = "帕奇维克";
	["Grobbulus"] = "格罗布鲁斯";
	["Gluth"] = "格拉斯";
	["Thaddius"] = "塔迪乌斯";
	["Anub'Rekhan"] = "阿努布雷坎";
	["Grand Widow Faerlina"] = "黑女巫法琳娜";
	["Maexxna"] = "迈克斯纳";
	["Instructor Razuvious"] = "教官拉苏维奥斯";
	["Gothik the Harvester"] = "收割者戈提克";
	["The Four Horsemen"] = "天启四骑士";
	["Thane Korth'azz"] = "库尔塔兹领主";
	["Lady Blaumeux"] = "女公爵布劳缪克丝";
	--Baron Rivendare omitted, listed under Stratholme
	["Sir Zeliek"] = "瑟里耶克爵士";
	["Four Horsemen Chest"] = "四骑士之箱";
	["Noth the Plaguebringer"] = "瘟疫使者诺斯";
	["Heigan the Unclean"] = "肮脏的希尔盖";
	["Loatheb"] = "洛欧塞布";
	["Frostwyrm Lair"] = "冰霜巨龙巢穴";
	["Sapphiron"] = "萨菲隆";
	["Kel'Thuzad"] = "克尔苏加德";

	--The Obsidian Sanctum
	["Black Dragonflight Chamber"] = "黑龙军团巢穴";
	["Sartharion <The Onyx Guardian>"] = "萨塔里奥 <黑岩守护者>";
	["Tenebron"] = "塔尼布隆";
	["Shadron"] = "沙德隆";
	["Vesperon"] = "维斯匹隆";

	--Onyxia's Lair
	["Onyxian Warders"] = "奥妮克希亚守卫";
	["Whelp Eggs"] = "雏龙蛋";
	["Onyxia"] = "奥妮克希亚";

	--The Ruby Sanctum
	["Red Dragonflight Chamber"] = "红龙庭"; -- Needs review after WoW 3.3.5 is available in China
	["Baltharus the Warborn"] = "「战争降临」巴萨勒司"; -- Needs review after WoW 3.3.5 is available in China
	["Saviana Ragefire"] = "莎维纳‧怒火"; -- Needs review after WoW 3.3.5 is available in China
	["General Zarithrian"] = "札里瑞安将军"; -- Needs review after WoW 3.3.5 is available in China
	["Halion <The Twilight Destroyer>"] = "音色的黄昏驱逐舰"; -- Needs review after WoW 3.3.5 is available in China

	--The Nexus: The Eye of Eternity
	["Malygos"] = "玛里苟斯";
	["Key to the Focusing Iris"] = "聚焦之虹的钥匙";
	
	--The Nexus: The Nexus	
	["Berinand's Research"] = "伯林纳德的研究笔记";
	["Commander Stoutbeard"] = "指挥官斯托比德";
	["Commander Kolurg"] = "指挥官库鲁尔格";
	["Grand Magus Telestra"] = "大魔导师泰蕾丝塔";
	["Anomalus"] = "阿诺玛鲁斯";
	["Elder Igasho"] = "Elder Igasho";
	["Ormorok the Tree-Shaper"] = "塑树者奥莫洛克";
	["Keristrasza"] = "克莉斯塔萨";

	--The Nexus: The Oculus
	["Drakos the Interrogator"] = "审讯者达库斯";
	["Mage-Lord Urom"] = "法师领主伊洛姆";
	["Ley-Guardian Eregos"] = "魔网守护者埃雷苟斯";
	["Varos Cloudstrider <Azure-Lord of the Blue Dragonflight>"] = "瓦尔洛斯·云击 <蓝龙军团的领主>";
	["Centrifuge Construct"] = "离心构造体";
	["Cache of Eregos"] = "埃雷苟斯的宝箱";

	--Trial of the Champion
	["Grand Champions"] = "大勇士";
	["Champions of the Alliance"] = "联盟大勇士";
	["Marshal Jacob Alerius"] = "杰科布•亚雷瑞斯元帅";
	["Ambrose Boltspark"] = "安布罗斯•拴炫";
	["Colosos"] = "克罗索斯";
	["Jaelyne Evensong"] = "洁琳•晚歌";
	["Lana Stouthammer"] = "菈娜•顽锤";
	["Champions of the Horde"] = "部落大勇士";
	["Mokra the Skullcrusher"] = "『碎颅者』莫克拉";
	["Eressea Dawnsinger"] = "艾瑞西雅•曦咏";
	["Runok Wildmane"] = "鲁诺克•蛮鬃";
	["Zul'tore"] = "祖尔拓";
	["Deathstalker Visceri"] = "亡灵哨兵威瑟瑞";
	["Eadric the Pure <Grand Champion of the Argent Crusade>"] = "『纯净者』埃卓克 <银白十字军大勇士>";
	["Argent Confessor Paletress"] = "银白告解者帕尔璀丝";
	["The Black Knight"] = "黑骑士";

	--Trial of the Crusader
	["Cavern Entrance"] = "洞穴入口";
	["Northrend Beasts"] = "北裂境巨兽";
	["Gormok the Impaler"] = "『穿刺者』戈莫克";
	["Acidmaw"] = "酸喉";
	["Dreadscale"] = "惧鳞";
	["Icehowl"] = "冰嚎";
	["Lord Jaraxxus"] = "贾拉克瑟斯领主";
	["Faction Champions"] = "阵营勇士";
	["Twin Val'kyr"] = "华尔琪双子";
	["Fjola Lightbane"] = "菲欧拉•光寂";
	["Eydis Darkbane"] = "艾狄丝•暗寂";
	["Anub'arak"] = "阿努巴拉克";
	["Heroic: Trial of the Grand Crusader"] = "英雄: 大十字军试炼";

	-- Ulduar General
	["Celestial Planetarium Key"] = "天文馆钥匙";
	["The Siege"] = "城墙";
	["The Keepers"] = "守护者"; --C

	-- Ulduar A
	["Flame Leviathan"] = "烈焰巨兽";
	["Ignis the Furnace Master"] = "掌炉者伊格尼斯";
	["Razorscale"] = "锋鳞";
	["XT-002 Deconstructor"] = "XT-002拆解者";
	["Tower of Life"] = "生命之塔";
	["Tower of Flame"] = "烈焰之塔";
	["Tower of Frost"] = "冰霜之塔";
	["Tower of Storms"] = "风暴之塔";

	-- Ulduar B
	["Assembly of Iron"] = "钢铁议会";
	["Steelbreaker"] = "破钢者";
	["Runemaster Molgeim"] = "符文领主莫尔格姆";
	["Stormcaller Brundir"] = "风暴召唤者布鲁迪尔";
	["Kologarn"] = "科隆加恩";
	["Algalon the Observer"] = "观察者奥尔加隆";
	["Prospector Doren"] = "勘察员多伦";
	["Archivum Console"] = "大数据库控制台";

	-- Ulduar C
	["Auriaya"] = "欧尔莉亚";
	["Freya"] = "弗蕾亚";
	["Thorim"] = "托里姆";
	["Hodir"] = "霍迪尔";

	-- Ulduar D
	["Mimiron"] = "米米尔隆";

	-- Ulduar E
	["General Vezax"] = "维扎克斯将军";
	["Yogg-Saron"] = "尤格-萨隆";

	--Ulduar: Halls of Lightning
	["General Bjarngrim"] = "比亚格里将军";
	["Volkhan"] = "沃尔坎";
	["Ionar"] = "艾欧纳尔";
	["Loken"] = "洛肯";

	--Ulduar: Halls of Stone
	["Elder Yurauk"] = "Elder Yurauk";
	["Krystallus"] = "克莱斯塔卢斯";
	["Maiden of Grief"] = "悲伤圣女";
	["Brann Bronzebeard"] = "布莱恩·铜须";
	["Tribunal Chest"] = "远古法庭宝箱";
	["Sjonnir the Ironshaper"] = "塑铁者斯约尼尔";

	--Utgarde Keep: Utgarde Keep
	["Dark Ranger Marrah"] = "黑暗游侠玛尔拉";
	["Prince Keleseth <The San'layn>"] = "凯雷塞斯王子 <萨莱因>";
	["Elder Jarten"] = "Elder Jarten";
	["Dalronn the Controller"] = "控制者达尔隆";
	["Skarvald the Constructor"] = "建筑师斯卡瓦尔德";
	["Ingvar the Plunderer"] = "劫掠者因格瓦尔";

	--Utgarde Keep: Utgarde Pinnacle
	["Brigg Smallshanks"] = "布雷格";
	["Svala Sorrowgrave"] = "席瓦拉·索格蕾"; 
	["Gortok Palehoof"] = "戈托克·苍蹄";
	["Skadi the Ruthless"] = "残忍的斯卡迪";
	["Elder Chogan'gada"] = "Elder Chogan'gada";
	["King Ymiron"] = "伊米隆国王";

	--Vault of Archavon
	["Archavon the Stone Watcher"] = "岩石看守者阿尔卡冯";
	["Emalon the Storm Watcher"] = "风暴看守者埃玛隆";
	["Koralon the Flame Watcher"] = "烈焰看守者寇拉隆";
	["Toravon the Ice Watcher"] = "寒冰看守者";

	--The Violet Hold
	["Erekem"] = "埃雷克姆";
	["Zuramat the Obliterator"] = "湮灭者祖拉玛特";
	["Xevozz"] = "谢沃兹";
	["Ichoron"] = "艾库隆";
	["Moragg"] = "摩拉格";
	["Lavanthor"] = "拉文索尔";
	["Cyanigosa"] = "塞安妮苟萨";
	["The Violet Hold Key"] = "紫罗兰监狱钥匙";

};
end
