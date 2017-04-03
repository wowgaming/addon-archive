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

-- Atlas Traditional Chinese Localization
-- $Date: 2010-07-27 01:44:00 +0930 (Tue, 27 Jul 2010) $
-- $Revision: 928 $


if ( GetLocale() ==	"zhTW" ) then
--************************************************
-- Global Atlas Strings
--************************************************

AtlasSortIgnore = {"the (.+)"};

ATLAS_TITLE = "Atlas 地圖集";

BINDING_HEADER_ATLAS_TITLE = "Atlas 按鍵設定";
BINDING_NAME_ATLAS_TOGGLE = "開啟/關閉 Atlas";
BINDING_NAME_ATLAS_OPTIONS = "切換設定";
BINDING_NAME_ATLAS_AUTOSEL = "自動選擇";

ATLAS_SLASH = "/atlas";
ATLAS_SLASH_OPTIONS = "選項";

ATLAS_STRING_LOCATION = "位置";
ATLAS_STRING_LEVELRANGE = "等級範圍";
ATLAS_STRING_PLAYERLIMIT = "人數上限";
ATLAS_STRING_SELECT_CAT = "選擇類別";
ATLAS_STRING_SELECT_MAP = "選擇地圖";
ATLAS_STRING_SEARCH = "搜尋";
ATLAS_STRING_CLEAR = "清除";
ATLAS_STRING_MINLEVEL = "最低等級";

ATLAS_OPTIONS_BUTTON = "選項";
ATLAS_OPTIONS_SHOWBUT = "在小地圖旁顯示 Atlas 按鈕";
ATLAS_OPTIONS_AUTOSEL = "自動選擇副本地圖";
ATLAS_OPTIONS_BUTPOS = "按鈕位置";
ATLAS_OPTIONS_TRANS = "透明度";
ATLAS_OPTIONS_RCLICK = "點擊滑鼠右鍵開啟世界地圖";
ATLAS_OPTIONS_RESETPOS = "重設位置";
ATLAS_OPTIONS_ACRONYMS = "顯示副本縮寫";
ATLAS_OPTIONS_SCALE = "視窗大小比率";
ATLAS_OPTIONS_BUTRAD = "按鈕半徑範圍";
ATLAS_OPTIONS_CLAMPED = "使 Atlas 視窗不超出遊戲畫面";
ATLAS_OPTIONS_CTRL = "按住 Ctrl 鍵以顯示工具提示";

ATLAS_BUTTON_TOOLTIP_TITLE = "Atlas 副本地圖";
ATLAS_BUTTON_TOOLTIP_HINT = "左鍵開啟 Atlas.\n中鍵開啟 Atlas 選項.\n右鍵並拖曳以移動圖示按鈕位置.";
ATLAS_LDB_HINT = "左鍵開啟 Atlas.\n中鍵開啟 Atlas 選項.\n右鍵打開顯示選單.";

ATLAS_OPTIONS_CATDD = "副本地圖排序方式:";
ATLAS_DDL_CONTINENT = "大陸";
ATLAS_DDL_CONTINENT_EASTERN = "東部王國副本";
ATLAS_DDL_CONTINENT_KALIMDOR = "卡林多副本";
ATLAS_DDL_CONTINENT_OUTLAND = "外域副本";
ATLAS_DDL_CONTINENT_NORTHREND = "北裂境副本";
ATLAS_DDL_LEVEL = "等級";
ATLAS_DDL_LEVEL_UNDER45 = "副本等級低於 45";
ATLAS_DDL_LEVEL_45TO60 = "副本等級介於 45-60";
ATLAS_DDL_LEVEL_60TO70 = "副本等級介於 60-70";
ATLAS_DDL_LEVEL_70TO80 = "副本等級介於 70-80";
ATLAS_DDL_LEVEL_80PLUS = "副本等級大於 80";
ATLAS_DDL_PARTYSIZE = "隊伍人數";
ATLAS_DDL_PARTYSIZE_5_AE = "5 人副本 A-E";
ATLAS_DDL_PARTYSIZE_5_FZ = "5 人副本 F-Z";
ATLAS_DDL_PARTYSIZE_10_AQ = "10 人副本 A-Q";
ATLAS_DDL_PARTYSIZE_10_RZ = "10 人副本 R-Z";
ATLAS_DDL_PARTYSIZE_20TO40 = "20-40 人副本";
ATLAS_DDL_EXPANSION = "資料片";
ATLAS_DDL_EXPANSION_OLD_AO = "舊世界副本 A-O";
ATLAS_DDL_EXPANSION_OLD_PZ = "舊世界副本 P-Z";
ATLAS_DDL_EXPANSION_BC = "燃燒的遠征副本";
ATLAS_DDL_EXPANSION_WOTLK = "巫妖王之怒副本";
ATLAS_DDL_TYPE = "類型";
ATLAS_DDL_TYPE_INSTANCE_AC = "副本 A-C";
ATLAS_DDL_TYPE_INSTANCE_DR = "副本 D-R";
ATLAS_DDL_TYPE_INSTANCE_SZ = "副本 S-Z";
ATLAS_DDL_TYPE_ENTRANCE = "入口";

ATLAS_INSTANCE_BUTTON = "副本";
ATLAS_ENTRANCE_BUTTON = "入口";
ATLAS_SEARCH_UNAVAIL = "搜尋功能停用";

ATLAS_DEP_MSG1 = "Atlas 偵測到過期的模組";
ATLAS_DEP_MSG2 = "這些模組已從這個角色被停用";
ATLAS_DEP_MSG3 = "請將這些模組從 AddOns 目錄移除";
ATLAS_DEP_OK = "Ok";

AtlasZoneSubstitutions = {
	["The Temple of Atal'Hakkar"] = "沈沒的神廟";
	["Ahn'Qiraj"] = "安其拉神廟";
	["Karazhan"] = "卡拉贊 - 1.開始";
	["Black Temple"] = "黑暗神廟 - 1.開始";
};

AtlasLocale = {

--************************************************
-- Zone Names, Acronyms, and Common Strings
--************************************************

	--World Events, Festival
	["Brewfest"] = "啤酒節";
	["Hallow's End"] = "萬鬼節";
	["Love is in the Air"] = "愛就在身邊";
	["Lunar Festival"] = "新年慶典";
	["Midsummer Festival"] = "仲夏節慶";
	--Misc strings
	["Adult"] = "成年";
	["AKA"] = "又稱";
	["Alliance"] = "聯盟";
	["Arcane Container"] = "秘法容器";
	["Argent Dawn"] = "銀色黎明";
	["Argent Crusade"] = "銀白十字軍";
	["Arms Warrior"] = "武戰";
	["Attunement Required"] = "需完成傳送門/鑰匙前置任務";
	["Back"] = "後方";
	["Basement"] = "地下室";
	["Bat"] = "蝙蝠";
	["Blacksmithing Plans"] = "黑鐵鍛造圖樣";
	["Boss"] = "首領";
	["Brazier of Invocation"] = "祈願火盆";
	["Chase Begins"] = "追逐開始";
	["Chase Ends"] = "追逐結束";
	["Child"] = "幼年";
	["Connection"] = "通道";
	["DS2"] = "副本套裝2";
	["Elevator"] = "電梯";
	["End"] = "結束";
	["Engineer"] = "工程師";
	["Entrance"] = "入口";
	["Event"] = "事件";
	["Exalted"] = "崇拜";
	["Exit"] = "出口";
	["Fourth Stop"] = "第四停留點";
	["Front"] = "前方";
	["Ghost"] = "鬼魂";
	["Heroic"] = "英雄";
	["Holy Paladin"] = "神聖聖騎";
	["Holy Priest"] = "神聖牧師";
	["Horde"] = "部落";
	["Hunter"] = "獵人";
	["Imp"] = "小鬼";
	["Inside"] = "內部";
	["Key"] = "鑰匙";
	["Lower"] = "下層";
	["Mage"] = "法師";
	["Meeting Stone"] = "集合石";
	["Monk"] = "僧侶";
	["Moonwell"] = "月井";
	["Optional"] = "可選擇";
	["Orange"] = "橙";
	["Outside"] = "戶外";
	["Paladin"] = "聖騎士";
	["Panther"] = "黑豹";
	["Portal"] = "入口/傳送門";
	["Priest"] = "牧師";
	["Protection Warrior"] = "防戰";
	["Purple"] = "紫";
	["Random"] = "隨機";
	["Raptor"] = "迅猛龍";
	["Rare"] = "稀有";
	["Reputation"] = "聲望";
	["Repair"] = "修理";
	["Retribution Paladin"] = "懲戒聖騎";
	["Rewards"] = "獎勵";
	["Rogue"] = "盜賊";
	["Second Stop"] = "第二停留點";
	["Shadow Priest"] = "暗影牧師";
	["Shaman"] = "薩滿";
	["Side"] = "側邊";
	["Snake"] = "蛇";
	["Spawn Point"] = "生成點";
	["Spider"] = "蜘蛛";
	["Start"] = "開始";
	["Summon"] = "召喚";
	["Teleporter"] = "傳送";
	["Third Stop"] = "第三停留點";
	["Tiger"] = "虎";
	["Top"] = "上方";
	["Undead"] = "不死族";
	["Underwater"] = "水下";
	["Unknown"] = "未知";
	["Upper"] = "上層";
	["Varies"] = "多處";
	["Wanders"] = "徘徊";
	["Warlock"] = "術士";
	["Warrior"] = "戰士";
	["Wave 5"] = "第 5 波";
	["Wave 6"] = "第 6 波";
	["Wave 10"] = "第 10 波";
	["Wave 12"] = "第 12 波";
	["Wave 18"] = "第 18 波";	

	--Classic Acronyms
	["AQ"] = "AQ"; -- Ahn'Qiraj 安其拉
	["AQ20"] = "AQ20"; -- Ruins of Ahn'Qiraj 安其拉廢墟
	["AQ40"] = "AQ40"; -- Temple of Ahn'Qiraj 安其拉神廟
	["Armory"] = "軍械庫";  -- Armory 軍械庫
	["BFD"] = "BFD/黑淵"; -- Blackfathom Deeps 黑暗深淵
	["BRD"] = "BRD/黑石淵"; -- Blackrock Depths 黑石深淵
	["BRM"] = "黑石山"; -- Blackrock Mountain 黑石山
	["BWL"] = "BWL/黑翼"; -- Blackwing Lair 黑翼之巢
	["Cath"] = "教堂"; -- Cathedral 大教堂
	["DM"] = "DM/厄運"; -- Dire Maul 厄運之槌
	["Gnome"] = "Gnome/諾姆"; -- Gnomeregan 諾姆瑞根
	["GY"] = "GY"; -- Graveyard 墓園
	["LBRS"] = "LBRS/黑下";  -- Lower Blackrock Spire 黑石塔下層
	["Lib"] = "Lib"; -- Library 圖書館
	["Mara"] = "Mara/瑪拉"; -- Maraudon 瑪拉頓
	["MC"] = "MC"; -- Molten Core 熔火之心
	["RFC"] = "RFC/怒焰"; -- Ragefire Chasm 怒焰裂谷
	["RFD"] = "RFD"; -- Razorfen Downs 剃刀高地
	["RFK"] = "RFK"; -- Razorfen Kraul 剃刀沼澤
	["Scholo"] = "Scholo/通靈"; -- Scholomance 通靈學院
	["SFK"] = "SFK/影牙"; -- Shadowfang Keep 影牙城堡
	["SM"] = "SM/血色"; -- Scarlet Monastery 血色修道院
	["ST"] = "ST/神廟"; -- Sunken Temple 沉沒的神廟
	["Strat"] = "Strat/斯坦"; -- Stratholme 斯坦索姆
	["Stocks"] = "監獄"; -- The Stockade 監獄
	["UBRS"] = "UBRS/黑上"; -- Upper Blackrock Spire 黑石塔上層
	["Ulda"] = "Ulda"; -- Uldaman 奧達曼
	["VC"] = "VC/死礦"; -- The Deadmines 死亡礦坑
	["WC"] = "WC/哀嚎"; -- Wailing Caverns 哀嚎洞穴
	["ZF"] = "ZF/祖法"; -- Zul'Farrak 祖爾法拉克
	["ZG"] = "ZG/祖爾"; -- Zul'Gurub 祖爾格拉布

	--BC Acronyms
	["AC"] = "AC"; -- Auchenai Crypts 奧奇奈地穴
	["Arca"] = "Arca 亞克"; -- The Arcatraz 亞克崔茲
	["Auch"] = "Auch"; -- Auchindoun 奧齊頓
	["BF"] = "BF"; -- The Blood Furnace 血熔爐
	["BT"] = "BT/黑廟"; -- Black Temple 黑暗神廟
	["Bota"] = "Bota/波塔"; -- The Botanica 波塔尼卡
	["CoT"] = "CoT"; -- Caverns of Time 時光之穴
	["CoT1"] = "CoT1/舊址"; -- Old Hillsbrad Foothills 希爾斯布萊德丘陵舊址
	["CoT2"] = "CoT2/黑沼"; -- The Black Morass 黑色沼澤
	["CoT3"] = "CoT3/海山"; -- Hyjal Summit 海加爾山
	["CR"] = "CR/盤牙"; -- Coilfang Reservoir
	["Eye"] = "Eye";  -- The Eye 中文版裡 The Eye 名稱被刪除，以 風暴要塞 命名這個25人副本
	["GL"] = "GL/戈魯爾"; -- Gruul's Lair 戈魯爾之巢
	["HC"] = "HFC/火堡"; -- Hellfire Citadel 地獄火堡壘
	["Kara"] = "Kara/卡拉"; -- Karazhan 卡拉贊
	["MaT"] = "MT/博學"; -- Magisters' Terrace 博學者殿堂
	["Mag"] = "Mag/瑪瑟"; -- Magtheridon's Lair 瑪瑟里頓的巢穴
	["Mech"] = "Mech/麥克"; -- The Mechanar 麥克納爾
	["MT"] = "MT/法力"; -- Mana-Tombs 法力墓地
	["Ramp"] = "Ramp"; -- Hellfire Ramparts 地獄火壁壘
	["SC"] = "SC/毒蛇"; -- Serpentshrine Cavern 毒蛇神殿洞穴
	["Seth"] = "Seth/塞司克"; -- Sethekk Halls 塞司克大廳
	["SH"] = "SH/破碎"; -- The Shattered Halls 破碎大廳
	["SL"] = "SL/迷宮"; -- Shadow Labyrinth 暗影迷宮
	["SP"] = "SP"; -- The Slave Pens 奴隸監獄
	["SuP"] = "SP/太陽井"; -- Sunwell Plateau 太陽之井高地
	["SV"] = "SV/蒸汽"; -- The Steamvault 蒸汽洞窟
	["TK"] = "TK/風暴"; -- Tempest Keep 風暴要塞
	["UB"] = "UB/深幽"; -- The Underbog 深幽泥沼
	["ZA"] = "ZA"; -- Zul'Aman 祖阿曼

	--WotLK Acronyms
	["AK, Kahet"] = "AK/安卡"; -- Ahn'kahet -- 安卡罕特
	["AN, Nerub"] = "AN/奈幽"; -- Azjol-Nerub -- 阿茲歐-奈幽
	["Champ"] = "勇士"; -- Trial of the Champion -- 勇士試煉
	["CoT-Strat"] = "CoT斯坦"; -- Culling of Stratholme -- 斯坦索姆的抉擇
	["Crus"] = "十字軍"; -- Trial of the Crusader --十字軍試煉
	["DTK"] = "DTK/德拉克"; -- Drak'Tharon Keep -- 德拉克薩隆要塞
	["FoS"] = "FoS/熔爐"; ["FH1"] = "FH1"; -- The Forge of Souls -- 眾魂熔爐
	["Gun"] = "Gun/剛德"; -- Gundrak -- 剛德拉克
	["HoL"] = "HoL/雷光"; -- Halls of Lightning --雷光大廳
	["HoR"] = "HoR/倒影"; ["FH3"] = "FH3"; -- Halls of Reflection -- 倒影大廳
	["HoS"] = "HoS/石廳"; -- Halls of Stone -- 石之大廳
 	["IC"] = "ICC/冰冠"; -- Icecrown Citadel -- 冰冠城塞
	["Nax"] = "Nax/納克"; -- Naxxramas -- 納克薩瑪斯
	["Nex, Nexus"] = "Nex/奧心"; -- The Nexus -- 奧核之心
	["Ocu"] = "Ocu/奧眼"; -- The Oculus -- 奧核之眼
	["Ony"] = "Ony/黑龍"; -- Onyxia's Lair 奧妮克希亞的巢穴
	["OS"] = "OS/黑曜"; -- The Obsidian Sanctum -- 黑曜聖所
	["PoS"] = "PoS"; ["FH2"] = "FH2"; -- Pit of Saron -- 薩倫之淵
	["RS"] = "RS/晶紅"; -- The Ruby Sanctum
	["TEoE"] = "TEoE/永恆"; -- The Eye of Eternity--永恆之眼
	["UK, Keep"] = "UK/俄塞"; -- Utgarde Keep -- 俄特加德要塞
	["Uldu"] = "Uldu/奧杜亞"; -- Ulduar-- 奧杜亞
	["UP, Pinn"] = "UP/俄巔"; -- Utgarde Pinnacl -- 俄特加德之巔
	["VH"] = "VH/紫堡"; -- The Violet Hold -- 紫羅蘭堡
	["VoA"] = "VoA/亞夏"; -- Vault of Archavon--亞夏梵穹殿

	--Zones not included in LibBabble-Zone
	["Crusaders' Coliseum"] = "銀白大競技場";

--************************************************
-- Instance Entrance Maps
--************************************************

	--Auchindoun (Entrance)
	["Ha'Lei"] = "哈勒";
	["Greatfather Aldrimus"] = "大祖父阿爾崔瑪斯";
	["Clarissa"] = "克萊瑞莎";
	["Ramdor the Mad"] = "瘋狂者藍姆多";
	["Horvon the Armorer <Armorsmith>"] = "護甲匠霍沃";
	["Nexus-Prince Haramad"] = "奈薩斯王子哈拉瑪德";
	["Artificer Morphalius"] = "工匠莫法利厄司";
	["Mamdy the \"Ologist\""] = "學家瑪姆迪";
	["\"Slim\" <Shady Dealer>"] = "「史令姆」";
	["\"Captain\" Kaftiz"] = "隊長卡夫提茲";
	["Isfar"] = "伊斯法";
	["Field Commander Mahfuun"] = "戰場元帥瑪赫范";
	["Spy Grik'tha"] = "間諜葛瑞克薩";
	["Provisioner Tsaalt"] = "糧食供應者·茲索特";
	["Dealer Tariq <Shady Dealer>"] = "商人塔爾利奎";

	--Blackfathom Deeps (Entrance)
	--Nothing to translate!

	--Blackrock Mountain (Entrance)
	["Bodley"] = "布德利";
	["Overmaster Pyron"] = "征服者派隆";
	["Lothos Riftwaker"] = "洛索斯·天痕";
	["Franclorn Forgewright"] = "弗蘭克羅恩·鑄鐵";
	["Orb of Command"] = "命令寶珠";
	["Scarshield Quartermaster <Scarshield Legion>"] = "裂盾軍需官";

	--Coilfang Reservoir (Entrance)
	["Watcher Jhang"] = "看守者詹汗格";
	["Mortog Steamhead"] = "莫塔格·史提海德";

	--Caverns of Time (Entrance)
	["Steward of Time <Keepers of Time>"] = "時間服務員";
	["Alexston Chrome <Tavern of Time>"] = "艾力克斯頓·科洛米";
	["Yarley <Armorer>"] = "亞利";
	["Bortega <Reagents & Poison Supplies>"] = "伯特卡";
	["Galgrom <Provisioner>"] = "卡葛隆姆";
	["Alurmi <Keepers of Time Quartermaster>"] = "阿勒米";
	["Zaladormu"] = "薩拉多姆";
	["Soridormi <The Scale of Sands>"] = "索芮朵蜜";
	["Arazmodu <The Scale of Sands>"] = "阿拉斯莫杜>";
	["Andormu <Keepers of Time>"] = "安杜姆";
	["Nozari <Keepers of Time>"] = "諾札瑞";

	--Dire Maul (Entrance)
	["Dire Pool"] = "厄運之池";
	["Dire Maul Arena"] = "厄運競技場";
	["Mushgog"] = "姆斯高格";
	["Skarr the Unbreakable"] = "無敵的斯卡爾";
	["The Razza"] = "拉札";
	["Elder Mistwalker"] = "霧行長者";

	--Gnomeregan (Entrance)
	["Transpolyporter"] = "傳送器";
	["Sprok <Away Team>"] = "斯普洛克";
	["Matrix Punchograph 3005-A"] = "矩陣式打孔電腦3005-A";
	["Namdo Bizzfizzle <Engineering Supplies>"] = "納姆杜";
	["Techbot"] = "尖端機器人";

	-- Hellfire Citadel (Entrance)
	["Steps and path to the Blood Furnace"] = "通往血熔爐的階梯與通道";
	["Path to the Hellfire Ramparts and Shattered Halls"] = "通往地獄火壁壘與破碎大廳的通道";
	["Meeting Stone of Magtheridon's Lair"] = "集合石 - 瑪瑟里頓的巢穴";
	["Meeting Stone of Hellfire Citadel"] = "集合石 - 地獄火堡壘";

	--Karazhan (Entrance)
	["Archmage Leryda"] = "大法師利瑞達";
	["Apprentice Darius"] = "學徒達瑞爾斯";
	["Archmage Alturus"] = "大法師艾特羅斯";
	["Stairs to Underground Pond"] = "通往地底池塘的階梯";
	["Stairs to Underground Well"] = "通往地底水井的階梯";
	["Charred Bone Fragment"] = "燒焦的白骨碎片";

	--Maraudon (Entrance)
	["The Nameless Prophet"] = "無名預言者";
	["Kolk <The First Kahn>"] = "考爾克 <第一可汗>";
	["Gelk <The Second Kahn>"] = "吉爾克 <第二可汗>";
	["Magra <The Third Kahn>"] = "瑪格拉 <第三可汗>";
	["Cavindra"] = "凱雯德拉";

	--Scarlet Monastery (Entrance)
	--Nothing to translate!

	--The Deadmines (Entrance)
	["Marisa du'Paige"] = "瑪里莎·杜派格";
	["Brainwashed Noble"] = "被洗腦的貴族";
	["Foreman Thistlenettle"] = "工頭希斯耐特";

	--Sunken Temple (Entrance)
	["Jade"] = "玉龍";
	["Kazkaz the Unholy"] = "邪惡的卡薩卡茲";
	["Zekkis"] = "澤基斯";
	["Veyzhak the Cannibal"] = "食屍者維薩克";

	--Uldaman (Entrance)
	["Hammertoe Grez"] = "鐵趾格雷茲";
	["Magregan Deepshadow"] = "馬格雷甘·深影";
	["Tablet of Ryun'Eh"] = "雷烏納石板";
	["Krom Stoutarm's Chest"] = "克羅姆·粗臂的箱子";
	["Garrett Family Chest"] = "加瑞特家族的寶箱";
	["Digmaster Shovelphlange"] = "挖掘專家舒爾弗拉格";

	--Wailing Caverns (Entrance)
	["Mad Magglish"] = "瘋狂的馬格利什";
	["Trigore the Lasher"] = "鞭笞者特里高雷";
	["Boahn <Druid of the Fang>"] = "博艾恩";
	["Above the Entrance:"] = "入口上方:";
	["Ebru <Disciple of Naralex>"] = "厄布魯";
	["Nalpak <Disciple of Naralex>"] = "納爾派克";
	["Kalldan Felmoon <Specialist Leatherworking Supplies>"] = "卡爾丹·暗月";
	["Waldor <Leatherworking Trainer>"] = "瓦多爾";

--************************************************
-- Kalimdor Instances (Classic)
--************************************************

	--Blackfathom Deeps
	["Ghamoo-ra"] = "加摩拉";
	["Lorgalis Manuscript"] = "洛迦里斯手稿";
	["Lady Sarevess"] = "薩利維絲";
	["Argent Guard Thaelrid <The Argent Dawn>"] = "銀色黎明守衛塞爾瑞德";
	["Gelihast"] = "格里哈斯特";
	["Shrine of Gelihast"] = "格里哈斯特神殿";
	["Lorgus Jett"] = "洛古斯·傑特";
	["Fathom Stone"] = "深淵之石";
	["Baron Aquanis"] = "阿奎尼斯男爵";
	["Twilight Lord Kelris"] = "夢遊者克爾里斯";
	["Old Serra'kis"] = "瑟拉吉斯";
	["Aku'mai"] = "阿庫麥爾";
	["Morridune"] = "莫瑞杜恩";
	["Altar of the Deeps"] = "瑪塞斯特拉祭壇";
	
	--Dire Maul (East)
	["Pusillin"] = "普希林";
	["Zevrim Thornhoof"] = "瑟雷姆·刺蹄";
	["Hydrospawn"] = "海多斯博恩";
	["Lethtendris"] = "蕾瑟塔蒂絲";
	["Pimgib"] = "匹姆吉布";
	["Old Ironbark"] = "埃隆巴克";
	["Alzzin the Wildshaper"] = "『狂野變形者』奧茲恩";
	["Isalien"] = "依薩利恩 (召喚)";
	
	--Dire Maul (North)
	["Crescent Key"] = "月牙鑰匙";--omitted from Dire Maul (West)
	--"Library" omitted from here and DM West because of SM: "Library" duplicate
	["Guard Mol'dar"] = "衛兵摩爾達";
	["Stomper Kreeg <The Drunk>"] = "踐踏者克雷格";
	["Guard Fengus"] = "衛兵芬古斯";
	["Knot Thimblejack"] = "諾特·希姆加克";
	["Guard Slip'kik"] = "衛兵斯里基克";
	["Captain Kromcrush"] = "克羅卡斯";
	["King Gordok"] = "戈多克大王";
	["Cho'Rush the Observer"] = "『觀察者』克魯什";

	--Dire Maul (West)
	["J'eevee's Jar"] = "耶維爾的瓶子";
	["Pylons"] = "水晶塔";
	["Shen'dralar Ancient"] = "辛德拉古靈";
	["Tendris Warpwood"] = "特迪斯·扭木";
	["Ancient Equine Spirit"] = "上古聖馬之魂";
	["Illyanna Ravenoak"] = "伊琳娜·暗木";
	["Ferra"] = "費拉";
	["Magister Kalendris"] = "博學者卡雷迪斯";
	["Tsu'zee"] = "蘇斯";
	["Immol'thar"] = "伊莫塔爾";
	["Lord Hel'nurath"] = "赫爾努拉斯";
	["Prince Tortheldrin"] = "托塞德林王子";
	["Falrin Treeshaper"] = "法琳·樹形者";
	["Lorekeeper Lydros"] = "博學者萊德羅斯";
	["Lorekeeper Javon"] = "博學者亞沃";
	["Lorekeeper Kildrath"] = "博學者基爾達斯";
	["Lorekeeper Mykos"] = "博學者麥庫斯";
	["Shen'dralar Provisioner"] = "辛德拉聖職者";
	["Skeletal Remains of Kariel Winthalus"] = "卡里爾·溫薩魯斯的骸骨";
	
	--Maraudon	
	["Scepter of Celebras"] = "塞雷布拉斯節杖";
	["Veng <The Fifth Khan>"] = "溫格 <第五可汗>";
	["Noxxion"] = "諾克賽恩";
	["Razorlash"] = "銳刺鞭笞者";
	["Maraudos <The Fourth Khan>"] = "瑪拉多斯 <第四可汗>";
	["Lord Vyletongue"] = "維利塔恩";
	["Meshlok the Harvester"] = "收割者麥什洛克";
	["Celebras the Cursed"] = "被詛咒的塞雷布拉斯";
	["Landslide"] = "蘭斯利德";
	["Tinkerer Gizlock"] = "工匠吉茲洛克";
	["Rotgrip"] = "洛特格里普";
	["Princess Theradras"] = "瑟萊德絲公主";
	["Elder Splitrock"] = "碎石長者";
	
	--Ragefire Chasm
	["Maur Grimtotem"] = "瑪爾·恐怖圖騰";
	["Oggleflint <Ragefire Chieftain>"] = "奧格弗林特";
	["Taragaman the Hungerer"] = "『飢餓者』塔拉加曼";
	["Jergosh the Invoker"] = "『塑能師』耶戈什";
	["Zelemar the Wrathful"] = "憤怒者·賽勒瑪爾";
	["Bazzalan"] = "巴札蘭";
	
	--Razorfen Downs
	["Tuten'kash"] = "圖特卡什";
	["Henry Stern"] = "亨利·斯特恩";
	["Belnistrasz"] = "貝尼斯特拉茲";
	["Sah'rhee"] = "薩哈斯";
	["Mordresh Fire Eye"] = "火眼莫德雷斯";
	["Glutton"] = "暴食者";
	["Ragglesnout"] = "拉戈斯諾特";
	["Amnennar the Coldbringer"] = "『寒冰使者』亞門納爾";
	["Plaguemaw the Rotting"] = "腐爛的普雷莫爾";
	
	--Razorfen Kraul
	["Roogug"] = "魯古格";
	["Aggem Thorncurse <Death's Head Prophet>"] = "阿格姆";
	["Death Speaker Jargba <Death's Head Captain>"] = "亡語者賈格巴";
	["Overlord Ramtusk"] = "拉姆塔斯主宰";
	["Razorfen Spearhide"] = "剃刀沼澤刺鬃守衛";
	["Agathelos the Raging"] = "暴怒的阿迦賽羅斯";
	["Blind Hunter"] = "盲眼獵手";
	["Charlga Razorflank <The Crone>"] = "卡爾加·刺肋";
	["Willix the Importer"] = "進口商威利克斯";
	["Heralath Fallowbrook"] = "赫爾拉斯·靜水";
	["Earthcaller Halmgar"] = "喚地者哈穆加";

	--Ruins of Ahn'Qiraj
	["Cenarion Circle"] = "塞納里奧議會";
	["Kurinnaxx"] = "庫林納克斯";
	["Lieutenant General Andorov"] = "安多洛夫中將";
	["Four Kaldorei Elites"] = "四個卡多雷精英";
	["General Rajaxx"] = "拉賈克斯將軍";
	["Captain Qeez"] = "奎茲上尉";
	["Captain Tuubid"] = "圖畢德上尉";
	["Captain Drenn"] = "德蘭上尉";
	["Captain Xurrem"] = "瑟瑞姆上尉";
	["Major Yeggeth"] = "葉吉斯少校";
	["Major Pakkon"] = "帕康少校";
	["Colonel Zerran"] = "澤朗上校";
	["Moam"] = "莫阿姆";
	["Buru the Gorger"] = "吞咽者布魯";
	["Ayamiss the Hunter"] = "狩獵者阿亞米斯";
	["Ossirian the Unscarred"] = "無疤者奧斯里安";
	["Safe Room"] = "安全的空間";

	--Temple of Ahn'Qiraj
	["Brood of Nozdormu"] = "諾茲多姆的子嗣";
	["The Prophet Skeram"] = "預言者斯克拉姆";
	["The Bug Family"] = "蟲族";
	["Vem"] = "維姆";
	["Lord Kri"] = "克里勳爵";
	["Princess Yauj"] = "亞爾基公主";
	["Battleguard Sartura"] = "沙爾圖拉";
	["Fankriss the Unyielding"] = "頑強的范克里斯";
	["Viscidus"] = "維希度斯";
	["Princess Huhuran"] = "哈霍蘭公主";
	["Twin Emperors"] = "雙子帝王";
	["Emperor Vek'lor"] = "維克洛爾大帝";
	["Emperor Vek'nilash"] = "維克尼拉斯";
	["Ouro"] = "奧羅";
	["Eye of C'Thun"] = "克蘇恩";
	["C'Thun"] = "克蘇恩";
	["Andorgos <Brood of Malygos>"] = "安多葛斯";
	["Vethsera <Brood of Ysera>"] = "溫瑟拉";
	["Kandrostrasz <Brood of Alexstrasza>"] = "坎多斯特拉茲";
	["Arygos"] = "亞雷戈斯";
	["Caelestrasz"] = "凱雷斯特拉茲";
	["Merithra of the Dream"] = "夢境之龍麥琳瑟拉";
	
	--Wailing Caverns
	["Disciple of Naralex"] = "納拉雷克斯的信徒";
	["Lord Cobrahn <Fanglord>"] = "考布萊恩領主";
	["Lady Anacondra <Fanglord>"] = "安娜科德拉";
	["Kresh"] = "克雷什";
	["Lord Pythas <Fanglord>"] = "皮薩斯領主";
	["Skum"] = "斯卡姆";
	["Lord Serpentis <Fanglord>"] = "瑟芬迪斯領主";
	["Verdan the Everliving"] = "永生者沃爾丹";
	["Mutanus the Devourer"] = "『吞噬者』穆坦努斯";
	["Naralex"] = "納拉雷克斯";
	["Deviate Faerie Dragon"] = "變異精靈龍";
	
	--Zul'Farrak
	["Antu'sul <Overseer of Sul>"] = "安圖蘇爾";
	["Theka the Martyr"] = "殉教者塞卡";
	["Witch Doctor Zum'rah"] = "巫醫祖穆拉恩";
	["Zul'Farrak Dead Hero"] = "祖爾法拉克陣亡英雄";
	["Nekrum Gutchewer"] = "耐克魯姆";
	["Shadowpriest Sezz'ziz"] = "暗影祭司塞瑟斯";
	["Dustwraith"] = "灰塵怨靈";
	["Sergeant Bly"] = "布萊中士";
	["Weegli Blastfuse"] = "維格利";
	["Murta Grimgut"] = "莫爾塔";
	["Raven"] = "拉文";
	["Oro Eyegouge"] = "奧羅";
	["Sandfury Executioner"] = "沙怒劊子手";
	["Hydromancer Velratha"] = "水占師維蕾薩";
	["Gahz'rilla"] = "加茲瑞拉";
	["Elder Wildmane"] = "蠻鬃長者";
	["Chief Ukorz Sandscalp"] = "烏克茲·沙頂";
	["Ruuzlu"] = "盧茲魯";
	["Zerillis"] = "澤雷利斯";
	["Sandarr Dunereaver"] = "杉達爾·沙掠者";
	
--****************************
-- Eastern Kingdoms Instances (Classic)
--****************************
	
	--Blackrock Depths
	["Shadowforge Key"] = "暗爐鑰匙";
	["Prison Cell Key"] = "監獄牢房鑰匙";
	["Jail Break!"] = "衝破牢籠";
	["Banner of Provocation"] = "挑釁旗幟";
	["Lord Roccor"] = "洛考爾";
	["Kharan Mighthammer"] = "卡蘭·巨錘";
	["Commander Gor'shak <Kargath Expeditionary Force>"] = "指揮官哥沙克";
	["Marshal Windsor"] = "溫德索爾元帥";
	["High Interrogator Gerstahn <Twilight's Hammer Interrogator>"] = "審訊官格斯塔恩";
	["Ring of Law"] = "競技場";
	["Anub'shiah"] = "阿努希爾";
	["Eviscerator"] = "剜眼者";
	["Gorosh the Dervish"] = "修行者高羅什";
	["Grizzle"] = "格里茲爾";
	["Hedrum the Creeper"] = "爬行者赫杜姆";
	["Ok'thor the Breaker"] = "破壞者奧科索爾";
	["Theldren"] = "瑟爾倫";
	["Lefty"] = "左撇";
	["Malgen Longspear"] = "瑪根·長矛";
	["Gnashjaw <Malgen Longspear's Pet>"] = "碎顎";
	["Rotfang"] = "腐牙";
	["Va'jashni"] = "瓦加什尼";
	["Houndmaster Grebmar"] = "馴犬者格雷布瑪爾";
	["Elder Morndeep"] = "晨深長者";
	["High Justice Grimstone"] = "裁決者格里斯通";
	["Monument of Franclorn Forgewright"] = "弗蘭克羅恩·鑄鐵的雕像";
	["Pyromancer Loregrain"] = "控火師羅格雷恩";
	["The Vault"] = "黑色寶庫";
	["Warder Stilgiss"] = "典獄官斯迪爾基斯";
	["Verek"] = "維雷克";
	["Watchman Doomgrip"] = "衛兵杜格瑞普";
	["Fineous Darkvire <Chief Architect>"] = "弗諾斯·達克維爾";
	["The Black Anvil"] = "黑鐵砧";
	["Lord Incendius"] = "伊森迪奧斯";
	["Bael'Gar"] = "貝爾加";
	["Shadowforge Lock"] = "暗爐之鎖";
	["General Angerforge"] = "安格弗將軍";
	["Golem Lord Argelmach"] = "傀儡統帥阿格曼奇";
	["Field Repair Bot 74A"] = "修理機器人74A型";
	["The Grim Guzzler"] = "黑鐵酒吧";
	["Hurley Blackbreath"] = "霍爾雷·黑鬚";
	["Lokhtos Darkbargainer <The Thorium Brotherhood>"] = "羅克圖斯·暗契";
	["Mistress Nagmara"] = "娜瑪拉小姐";
	["Phalanx"] = "法拉克斯";
	["Plugger Spazzring"] = "普拉格";
	["Private Rocknot"] = "羅克諾特下士";
	["Ribbly Screwspigot"] = "雷布里·斯庫比格特";
	["Coren Direbrew"] = "寇仁·恐酒";
	["Griz Gutshank <Arena Vendor>"] = "格利茲·易柄";
	["Ambassador Flamelash"] = "弗萊拉斯大使";
	["Panzor the Invincible"] = "無敵的潘佐爾";
	["Summoner's Tomb"] = "召喚者之墓";
	["The Lyceum"] = "講學廳";
	["Magmus"] = "瑪格姆斯";
	["Emperor Dagran Thaurissan"] = "達格蘭·索瑞森大帝";
	["Princess Moira Bronzebeard <Princess of Ironforge>"] = "茉艾拉·銅鬚公主";
	["High Priestess of Thaurissan"] = "索瑞森高階女祭司";
	["The Black Forge"] = "黑熔爐";
	["Core Fragment"] = "熔火碎片";
	["Overmaster Pyron"] = "征服者派隆";

	--Blackrock Spire (Lower)
	["Vaelan"] = "維埃蘭";
	["Warosh <The Cursed>"] = "瓦羅什";
	["Elder Stonefort"] = "石壘長者";
	["Roughshod Pike"] = "尖銳長矛";
	["Spirestone Butcher"] = "尖石屠夫";
	["Highlord Omokk"] = "歐莫克大王";
	["Spirestone Battle Lord"] = "尖石戰鬥統帥";
	["Spirestone Lord Magus"] = "尖石首席魔導師";
	["Shadow Hunter Vosh'gajin"] = "暗影獵手沃許加斯";
	["Fifth Mosh'aru Tablet"] = "第五塊摩沙魯石板";
	["Bijou"] = "比修";
	["War Master Voone"] = "指揮官沃恩";
	["Mor Grayhoof"] = "莫爾·灰蹄";
	["Sixth Mosh'aru Tablet"] = "第六塊摩沙魯石板";
	["Bijou's Belongings"] = "比修的裝置";
	["Human Remains"] = "人類殘骸";
	["Unfired Plate Gauntlets"] = "未淬火的鎧甲護手";
	["Bannok Grimaxe <Firebrand Legion Champion>"] = "班諾克·巨斧";
	["Mother Smolderweb"] = "煙網蛛后";
	["Crystal Fang"] = "水晶之牙";
	["Urok's Tribute Pile"] = "烏洛克的貢品堆";
	["Urok Doomhowl"] = "烏洛克";
	["Quartermaster Zigris <Bloodaxe Legion>"] = "軍需官茲格雷斯";
	["Halycon"] = "哈雷肯";
	["Gizrul the Slavener"] = "『奴役者』基茲盧爾";
	["Ghok Bashguud <Bloodaxe Champion>"] = "霍克·巴什古德";
	["Overlord Wyrmthalak"] = "維姆薩拉克主宰";
	["Burning Felguard"] = "燃燒地獄衛士";

	--Blackrock Spire (Upper)
	["Pyroguard Emberseer"] = "烈焰衛士艾博希爾";
	["Solakar Flamewreath"] = "索拉卡·火冠";
	["Father Flame"] = "烈焰之父";
	["Darkstone Tablet"] = "黑暗石板";
	["Doomrigger's Coffer"] = "末日扣環之箱";
	["Jed Runewatcher <Blackhand Legion>"] = "傑德";
	["Goraluk Anvilcrack <Blackhand Legion Armorsmith>"] = "古拉魯克";
	["Warchief Rend Blackhand"] = "大酋長雷德·黑手";
	["Gyth <Rend Blackhand's Mount>"] = "蓋斯";
	["Awbee"] = "奧比";
	["The Beast"] = "比斯巨獸";
	["Lord Valthalak"] = "瓦薩拉克";
	["Finkle Einhorn"] = "芬克·恩霍爾";
	["General Drakkisath"] = "達基薩斯將軍";
	["Drakkisath's Brand"] = "達基薩斯徽記";
	
	--Blackwing Lair
	["Razorgore the Untamed"] = "狂野的拉佐格爾";
	["Vaelastrasz the Corrupt"] = "墮落的瓦拉斯塔茲";
	["Broodlord Lashlayer"] = "勒西雷爾";
	["Firemaw"] = "費爾默";
	["Draconic for Dummies (Chapter VII)"] = "龍語傻瓜教程";
	["Master Elemental Shaper Krixix"] = "大元素師克里希克";
	["Ebonroc"] = "埃博諾克";
	["Flamegor"] = "弗萊格爾";
	["Chromaggus"] = "克洛瑪古斯";
	["Nefarian"] = "奈法利安";
	
	--Gnomeregan
	["Workshop Key"] = "車間鑰匙";
	["Blastmaster Emi Shortfuse"] = "爆破專家艾米·短線";
	["Grubbis"] = "格魯比斯";
	["Chomper"] = "咀嚼者";
	["Clean Room"] = "清洗區";
	["Tink Sprocketwhistle <Engineering Supplies>"] = "丁克·鐵哨";
	["The Sparklematic 5200"] = "超級清潔器5200型！";
	["Mail Box"] = "鎖甲箱";
	["Kernobee"] = "克努比";
	["Alarm-a-bomb 2600"] = "警報炸彈2600型";
	["Matrix Punchograph 3005-B"] = "矩陣式打孔電腦 3005-B";
	["Viscous Fallout"] = "粘性輻射塵";
	["Electrocutioner 6000"] = "電刑器6000型";
	["Matrix Punchograph 3005-C"] = "矩陣式打孔電腦 3005-C";
	["Crowd Pummeler 9-60"] = "群體打擊者9-60";
	["Matrix Punchograph 3005-D"] = "矩陣式打孔電腦 3005-D";
	["Dark Iron Ambassador"] = "黑鐵大師";
	["Mekgineer Thermaplugg"] = "麥克尼爾·瑟瑪普拉格";
	
	--Molten Core
	["Hydraxian Waterlords"] = "海達希亞水元素";
	["Lucifron"] = "魯西弗隆";
	["Magmadar"] = "瑪格曼達";
	["Gehennas"] = "基赫納斯";
	["Garr"] = "加爾";
	["Shazzrah"] = "沙斯拉爾";
	["Baron Geddon"] = "迦頓男爵";
	["Golemagg the Incinerator"] = "焚化者古雷曼格";
	["Sulfuron Harbinger"] = "薩弗隆先驅者";
	["Majordomo Executus"] = "管理者埃克索圖斯";
	["Ragnaros"] = "拉格納羅斯";

	--Scholomance
	["Skeleton Key"] = "骷髏鑰匙";
	["Viewing Room Key"] = "鑰匙: 觀察室鑰匙";
	["Viewing Room"] = "觀察室";
	["Blood of Innocents"] = "鑰匙: 無辜者之血";
	["Divination Scryer"] = "鑰匙: 預言水晶球";
	["Blood Steward of Kirtonos"] = "基爾圖諾斯的衛士";
	["The Deed to Southshore"] = "南海鎮地契";
	["Kirtonos the Herald"] = "傳令官基爾圖諾斯";
	["Jandice Barov"] = "詹迪斯·巴羅夫";
	["The Deed to Tarren Mill"] = "塔倫米爾地契";
	["Rattlegore"] = "血骨傀儡";
	["Death Knight Darkreaver"] = "死亡騎士達克雷爾";
	["Marduk Blackpool"] = "馬杜克·布萊克波爾";
	["Vectus"] = "維克圖斯";
	["Ras Frostwhisper"] = "萊斯·霜語";
	["The Deed to Brill"] = "布瑞爾地契";
	["Kormok"] = "科爾莫克";
	["Instructor Malicia"] = "講師瑪麗希亞";
	["Doctor Theolen Krastinov <The Butcher>"] = "瑟爾林·卡斯迪諾夫教授";
	["Lorekeeper Polkelt"] = "博學者普克爾特";
	["The Ravenian"] = "拉文尼亞";
	["Lord Alexei Barov"] = "阿萊克斯·巴羅夫";
	["The Deed to Caer Darrow"] = "凱爾達隆地契";
	["Lady Illucia Barov"] = "伊露希亞·巴羅夫";
	["Darkmaster Gandling"] = "黑暗院長加丁";
	["Torch Lever"] = "火炬";
	["Secret Chest"] = "舊寶藏箱";
	["Alchemy Lab"] = "煉金實驗室";
	
	--Shadowfang Keep
	["Deathsworn Captain"] = "死亡之誓";
	["Rethilgore <The Cell Keeper>"] = "雷希戈爾";
	["Sorcerer Ashcrombe"] = "巫士阿克魯比";
	["Deathstalker Adamant"] = "亡靈哨兵阿達曼特";
	["Landen Stilwell"] = "藍登·史帝威爾";
	["Investigator Fezzen Brasstacks"] = "調查員菲贊·銅釘";
	["Deathstalker Vincent"] = "亡靈哨兵文森特";
	["Apothecary Trio"] = "藥劑師三人組";
	["Apothecary Hummel <Crown Chemical Co.>"] = "藥劑師胡默爾 <王冠化學製藥公司>";
	["Apothecary Baxter <Crown Chemical Co.>"] = "藥劑師巴克斯特 <王冠化學製藥公司>";
	["Apothecary Frye <Crown Chemical Co.>"] = "藥劑師弗萊伊 <王冠化學製藥公司>";
	["Fel Steed"] = "魔化戰馬";
	["Jordan's Hammer"] = "喬丹的鐵錘";
	["Crate of Ingots"] = "一箱鐵錠";
	["Razorclaw the Butcher"] = "屠夫拉佐克勞";
	["Baron Silverlaine"] = "席瓦萊恩男爵";
	["Commander Springvale"] = "指揮官斯普林瓦爾";
	["Odo the Blindwatcher"] = "『盲眼守衛』奧杜";
	["Fenrus the Devourer"] = "『吞噬者』芬魯斯";
	["Arugal's Voidwalker"] = "阿魯高的虛無行者";
	["The Book of Ur"] = "烏爾之書";
	["Wolf Master Nandos"] = "狼王南杜斯";
	["Archmage Arugal"] = "大法師阿魯高";

	--SM: Armory
	["The Scarlet Key"] = "血色十字軍鑰匙";--omitted from SM: Cathedral
	["Herod <The Scarlet Champion>"] = "赫洛德";

	--SM: Cathedral
	["High Inquisitor Fairbanks"] = "大檢察官法爾班克斯";
	["Scarlet Commander Mograine"] = "血色十字軍指揮官莫格萊尼";
	["High Inquisitor Whitemane"] = "大檢察官懷特邁恩";

	--SM: Graveyard
	["Interrogator Vishas"] = "審訊員韋沙斯";
	["Vorrel Sengutz"] = "沃瑞爾·森古斯";
	["Pumpkin Shrine"] = "無頭騎士南瓜";
	["Headless Horseman"] = "無頭騎士";
	["Bloodmage Thalnos"] = "血法師薩爾諾斯";
	["Ironspine"] = "鐵脊死靈";
	["Azshir the Sleepless"] = "永醒的艾希爾";
	["Fallen Champion"] = "死靈勇士";

	--SM: Library
	["Houndmaster Loksey"] = "馴犬者洛克希";
	["Arcanist Doan"] = "祕法師杜安";

	--Stratholme
	["The Scarlet Key"] = "血色十字軍鑰匙";
	["Key to the City"] = "城市大門鑰匙";
	["Various Postbox Keys"] = "郵箱鑰匙";
	["Living Side"] = "血色區";
	["Undead Side"] = "不死區";
	["Skul"] = "斯庫爾";
	["Stratholme Courier"] = "斯坦索姆信差";
	["Fras Siabi"] = "弗拉斯·希亞比";
	["Atiesh <Hand of Sargeras>"] = "阿泰絲";
	["Hearthsinger Forresten"] = "弗雷斯特恩";
	["The Unforgiven"] = "不可寬恕者";
	["Elder Farwhisper"] = "遙語長者";
	["Timmy the Cruel"] = "悲慘的提米";
	["Malor the Zealous"] = "狂熱的瑪洛爾";
	["Malor's Strongbox"] = "瑪洛爾的保險箱";
	["Crimson Hammersmith"] = "紅衣錘匠";
	["Cannon Master Willey"] = "炮手威利";
	["Archivist Galford"] = "檔案管理員加爾福特";
	["Grand Crusader Dathrohan"] = "大十字軍戰士達索漢";
	["Balnazzar"] = "巴納札爾";
	["Sothos"] = "索索斯";
	["Jarien"] = "賈林";
	["Magistrate Barthilas"] = "巴瑟拉斯鎮長s";
	["Aurius"] = "奧里克斯";
	["Stonespine"] = "石脊";
	["Baroness Anastari"] = "安娜絲塔麗男爵夫人";
	["Black Guard Swordsmith"] = "黑衣守衛鑄劍師";
	["Nerub'enkan"] = "奈魯布恩坎";
	["Maleki the Pallid"] = "蒼白的瑪勒基";
	["Ramstein the Gorger"] = "吞嚥者拉姆斯登";
	["Baron Rivendare"] = "瑞文戴爾男爵";
	["Ysida Harmon"] = "亞希達·哈莫";
	["Crusaders' Square Postbox"] = "十字軍廣場郵箱";
	["Market Row Postbox"] = "市場郵箱";
	["Festival Lane Postbox"] = "節日小道郵箱";
	["Elders' Square Postbox"] = "長者廣場郵箱";
	["King's Square Postbox"] = "國王廣場郵箱";
	["Fras Siabi's Postbox"] = "弗拉斯·希亞比的郵箱";
	["3rd Box Opened"] = "第三個郵箱被開啟";
	["Postmaster Malown"] = "郵差瑪羅恩";

	--The Deadmines
	["Rhahk'Zor <The Foreman>"] = "拉克佐";
	["Miner Johnson"] = "礦工約翰森";
	["Sneed <Lumbermaster>"] = "斯尼德";
	["Sneed's Shredder <Lumbermaster>"] = "斯尼德的伐木機";
	["Gilnid <The Smelter>"] = "基爾尼格";
	["Defias Gunpowder"] = "迪菲亞火藥";
	["Captain Greenskin"] = "綠皮隊長";
	["Edwin VanCleef <Defias Kingpin>"] = "艾德溫·范克里夫";
	["Mr. Smite <The Ship's First Mate>"] = "重拳先生";
	["Cookie <The Ship's Cook>"] = "曲奇";
	
	--The Stockade
	["Targorr the Dread"] = "可怕的塔高爾";
	["Kam Deepfury"] = "卡姆·深怒";
	["Hamhock"] = "哈姆霍克";
	["Bazil Thredd"] = "巴基爾·斯瑞德";
	["Dextren Ward"] = "迪克斯特·瓦德";
	["Bruegal Ironknuckle"] = "布魯戈·艾爾克納寇";

	--The Sunken Temple
	["The Temple of Atal'Hakkar"] = "阿塔哈卡神廟";
	["Yeh'kinya's Scroll"] = "葉基亞的卷軸";
	["Atal'ai Defenders"] = "阿塔萊防禦者";
	["Gasher"] = "加什爾";
	["Loro"] = "洛若爾";
	["Hukku"] = "胡庫";
	["Zolo"] = "祖羅";
	["Mijan"] = "米杉";
	["Zul'Lor"] = "祖羅爾";
	["Altar of Hakkar"] = "哈卡祭壇";
	["Atal'alarion <Guardian of the Idol>"] = "阿塔拉利恩";
	["Dreamscythe"] = "德姆塞卡爾";
	["Weaver"] = "德拉維沃爾";
	["Avatar of Hakkar"] = "哈卡的化身";
	["Jammal'an the Prophet"] = "預言者迦瑪蘭";
	["Ogom the Wretched"] = "可悲的奧戈姆";
	["Morphaz"] = "摩弗拉斯";
	["Hazzas"] = "哈札斯";
	["Shade of Eranikus"] = "伊蘭尼庫斯的陰影";
	["Essence Font"] = "精華之泉";
	["Spawn of Hakkar"] = "哈卡的後代";
	["Elder Starsong"] = "星歌長者";
	["Statue Activation Order"] = "雕像啟動順序";
	
	--Uldaman
	["Staff of Prehistoria"] = "史前法杖";
	["Baelog"] = "巴爾洛戈";
	["Eric \"The Swift\""] = "埃瑞克";
	["Olaf"] = "奧拉夫";
	["Baelog's Chest"] = "巴爾洛戈的箱子";
	["Conspicuous Urn"] = "顯眼的石罐";
	["Remains of a Paladin"] = "聖騎士的遺體";
	["Revelosh"] = "魯維羅什";
	["Ironaya"] = "艾隆納亞";
	["Obsidian Sentinel"] = "黑曜石哨兵";
	["Annora <Enchanting Trainer>"] = "安諾拉 <附魔師>";
	["Ancient Stone Keeper"] = "古代的石頭看守者";
	["Galgann Firehammer"] = "加加恩·火錘";
	["Tablet of Will"] = "意志石板";
	["Shadowforge Cache"] = "暗影熔爐地窖";
	["Grimlok <Stonevault Chieftain>"] = "格瑞姆洛克";
	["Archaedas <Ancient Stone Watcher>"] = "阿札達斯";
	["The Discs of Norgannon"] = "諾甘農圓盤";
	["Ancient Treasure"] = "古代寶藏";
	
	--Zul'Gurub
	["Zandalar Tribe"] = "贊達拉部族";
	["Mudskunk Lure"] = "臭泥魚誘餌";
	["Gurubashi Mojo Madness"] = "古拉巴什瘋狂魔精";
	["High Priestess Jeklik"] = "高階祭司耶克里克";
	["High Priest Venoxis"] = "高階祭司溫諾希斯";
	["Zanza the Restless"] = "無眠者贊札";
	["High Priestess Mar'li"] = "哈卡萊安魂者";
	["Bloodlord Mandokir"] = "血領主曼多基爾";
	["Ohgan"] = "奧根";
	["Edge of Madness"] = "瘋狂之緣";
	["Gri'lek"] = "格里雷克";
	["Hazza'rah"] = "哈札拉爾";
	["Renataki"] = "雷納塔基";
	["Wushoolay"] = "烏蘇雷";
	["Gahz'ranka"] = "加茲蘭卡";
	["High Priest Thekal"] = "古拉巴什食腐者";
	["Zealot Zath"] = "狂熱者札斯";
	["Zealot Lor'Khan"] = "狂熱者洛卡恩";
	["High Priestess Arlokk"] = "哈卡萊先知";
	["Jin'do the Hexxer"] = "妖術師金度";
	["Hakkar"] = "哈卡";
	["Muddy Churning Waters"] = "混濁的水";
	
--*******************
-- Burning Crusade Instances
--*******************

	--Auch: Auchenai Crypts
	["Lower City"] = "陰鬱城";--omitted from other Auch
	["Shirrak the Dead Watcher"] = "死亡看守者辛瑞克";
	["Exarch Maladaar"] = "主教瑪拉達爾";
	["Avatar of the Martyred"] = "馬丁瑞德的化身";
	["D'ore"] = "迪歐瑞";

	--Auch: Mana-Tombs
	["The Consortium"] = "聯合團";
	["Auchenai Key"] = "奧奇奈鑰匙";--omitted from other Auch
	["The Eye of Haramad"] = "哈拉瑪德之眼";
	["Pandemonius"] = "班提蒙尼厄斯";
	["Shadow Lord Xiraxis"] = "暗影領主希瑞西斯";
	["Ambassador Pax'ivi"] = "帕克西維大使";
	["Tavarok"] = "塔瓦洛克";
	["Cryo-Engineer Sha'heen"] = "工程師薩希恩";
	["Ethereal Transporter Control Panel"] = "虛空傳送者控制面板";
	["Nexus-Prince Shaffar"] = "奈薩斯王子薩法爾";
	["Yor <Void Hound of Shaffar>"] = "約兒";

	--Auch: Sethekk Halls
	["Essence-Infused Moonstone"] = "精華灌注的月亮石";
	["Darkweaver Syth"] = "暗法師希斯";
	["Lakka"] = "拉卡";
	["The Saga of Terokk"] = "泰洛克的傳說";
	["Anzu"] = "安祖";
	["Talon King Ikiss"] = "鷹王伊奇斯";

	--Auch: Shadow Labyrinth
	["Shadow Labyrinth Key"] = "暗影迷宮鑰匙";
	["Spy To'gun"] = "間諜·吐剛";
	["Ambassador Hellmaw"] = "海爾瑪大使";
	["Blackheart the Inciter"] = "煽動者黑心";
	["Grandmaster Vorpil"] = "領導者瓦皮歐";
	["The Codex of Blood"] = "血之聖典";
	["Murmur"] = "莫爾墨";
	["First Fragment Guardian"] = "第一碎片守衛者";

	--Black Temple (Start)
	["Ashtongue Deathsworn"] = "灰舌死亡誓言者";--omitted from other BT
	["Towards Reliquary of Souls"] = "通往靈魂聖盒";
	["Towards Teron Gorefiend"] = "通往泰朗·血魔";
	["Towards Illidan Stormrage"] = "通往伊利丹";
	["Spirit of Olum"] = "歐蘭的靈魂";
	["High Warlord Naj'entus"] = "高階督軍納珍塔斯";
	["Supremus"] = "瑟普莫斯";
	["Shade of Akama"] = "阿卡瑪的黑暗面";
	["Spirit of Udalo"] = "烏達羅之靈";
	["Aluyen <Reagents>"] = "阿魯焰 <施法材料>";
	["Okuno <Ashtongue Deathsworn Quartermaster>"] = "歐庫諾 <灰舌死亡誓言者軍需官>";
	["Seer Kanai"] = "先知卡奈";

	--Black Temple (Basement)
	["Gurtogg Bloodboil"] = "葛塔格·血沸";
	["Reliquary of Souls"] = "靈魂聖盒";
	["Essence of Suffering"] = "受難精華";
	["Essence of Desire"] = "慾望精華";
	["Essence of Anger"] = "憤怒精華";
	["Teron Gorefiend"] = "泰朗·血魔";

	--Black Temple (Top)
	["Mother Shahraz"] = "薩拉茲女士";
	["The Illidari Council"] = "伊利達瑞議事";
	["Lady Malande"] = "瑪蘭黛女士";
	["Gathios the Shatterer"] = "粉碎者高希歐";
	["High Nethermancer Zerevor"] = "高等虛空術師札瑞佛";
	["Veras Darkshadow"] = "維拉斯·深影";
	["Illidan Stormrage <The Betrayer>"] = "伊利丹·怒風 <背叛者>";

	--CR: Serpentshrine Cavern
	["Hydross the Unstable <Duke of Currents>"] = "不穩定者海卓司";
	["The Lurker Below"] = "海底潛伏者";
	["Leotheras the Blind"] = "盲目者李奧薩拉斯";
	["Fathom-Lord Karathress"] = "深淵之王卡拉薩瑞斯";
	["Seer Olum"] = "先知歐蘭";
	["Morogrim Tidewalker"] = "莫洛葛利姆·潮行者";
	["Lady Vashj <Coilfang Matron>"] = "瓦許女士";

	--CR: The Slave Pens
	["Cenarion Expedition"] = "塞納里奧遠征隊";--omitted from other CR
	["Reservoir Key"] = "蓄湖之鑰";--omitted from other CR
	["Mennu the Betrayer"] = "背叛者曼紐";
	["Weeder Greenthumb"] = "威德·綠指";
	["Skar'this the Heretic"] = "異教徒司卡利斯";
	["Rokmar the Crackler"] = "爆裂者洛克瑪";
	["Naturalist Bite"] = "博物學家·拜特";
	["Quagmirran"] = "奎克米瑞";
	["Ahune <The Frost Lord>"] = "艾胡恩";

	--CR: The Steamvault
	["Hydromancer Thespia"] = "海法師希斯比亞";
	["Main Chambers Access Panel"] = "主房間通道面板";
	["Second Fragment Guardian"] = "第二碎片守衛者";
	["Mekgineer Steamrigger"] = "米克吉勒·蒸汽操控者";
	["Warlord Kalithresh"] = "督軍卡利斯瑞";

	--CR: The Underbog
	["Hungarfen"] = "飢餓之牙";
	["The Underspore"] = "地孢";
	["Ghaz'an"] = "高薩安";
	["Earthbinder Rayge"] = "縛地者瑞吉";
	["Swamplord Musel'ek"] = "沼澤之王莫斯萊克";
	["Claw <Swamplord Musel'ek's Pet>"] = "喚風者卡勞";
	["The Black Stalker"] = "黑色捕獵者";

	--CoT: The Black Morass
	["Opening of the Dark Portal"] = "開啟黑暗之門";
	["Keepers of Time"] = "時光守衛者";--omitted from Old Hillsbrad Foothills
	["Key of Time"] = "時光之鑰";--omitted from Old Hillsbrad Foothills
	["Sa'at <Keepers of Time>"] = "塞特";
	["Chrono Lord Deja"] = "第六波: 克洛諾斯領主迪賈";
	["Temporus"] = "第十二波: 坦普拉斯";
	["Aeonus"] = "第十八波: 艾奧那斯";
	["The Dark Portal"] = "黑暗之門";
	["Medivh"] = "麥迪文";

	--CoT: Hyjal Summit
	["Battle for Mount Hyjal"] = "海加爾山戰場";
	["The Scale of the Sands"] = "流沙之鱗";
	["Alliance Base"] = "聯盟營地";
	["Lady Jaina Proudmoore"] = "珍娜·普勞德摩爾女士";
	["Horde Encampment"] = "部落營地";
	["Thrall <Warchief>"] = "索爾 <首領>";
	["Night Elf Village"] = "夜精靈村";
	["Tyrande Whisperwind <High Priestess of Elune>"] = "泰蘭妲·語風";
	["Rage Winterchill"] = "瑞奇·寒冬";
	["Anetheron"] = "安納斯隆";
	["Kaz'rogal"] = "卡斯羅高";
	["Azgalor"] = "埃加洛爾";
	["Archimonde"] = "阿克蒙德";
	["Indormi <Keeper of Ancient Gem Lore>"] = "隱多米";
	["Tydormu <Keeper of Lost Artifacts>"] = "提多姆";

	--CoT: Old Hillsbrad Foothills
	["Escape from Durnholde Keep"] = "逃離敦霍爾德";
	["Erozion"] = "伊洛森";
	["Brazen"] = "布瑞茲恩";
	["Landing Spot"] = "降落點";
	["Lieutenant Drake"] = "中尉崔克";
	["Thrall"] = "索爾";
	["Captain Skarloc"] = "史卡拉克上尉";
	["Epoch Hunter"] = "伊波奇獵人";
	["Taretha"] = "塔蕾莎";
	["Jonathan Revah"] = "強納森·瑞瓦";
	["Jerry Carter"] = "傑瑞·卡特";
	["Traveling"] = "旅行中";
	["Thomas Yance <Travelling Salesman>"] = "湯瑪斯·陽斯";
	["Aged Dalaran Wizard"] = "年邁的達拉然法師";
	["Kel'Thuzad <The Kirin Tor>"] = "科爾蘇加德";
	["Helcular"] = "赫爾庫拉";
	["Farmer Kent"] = "農夫肯特";
	["Sally Whitemane"] = "莎麗·白鬃";
	["Renault Mograine"] = "雷諾·莫根尼";
	["Little Jimmy Vishas"] = "小吉米·維希斯";
	["Herod the Bully"] = "流氓希洛特";
	["Nat Pagle"] = "納特·帕格";
	["Hal McAllister"] = "哈爾·馬克奧里斯特";
	["Zixil <Aspiring Merchant>"] = "吉克希爾";
	["Overwatch Mark 0 <Protector>"] = "守候者零型";
	["Southshore Inn"] = "南海鎮旅館";
	["Captain Edward Hanes"] = "隊長艾德華·漢尼斯";
	["Captain Sanders"] = "桑德斯船長";
	["Commander Mograine"] = "指揮官莫格萊尼";
	["Isillien"] = "伊斯利恩";
	["Abbendis"] = "阿比迪斯";
	["Fairbanks"] = "費爾班克";
	["Tirion Fordring"] = "提里恩·弗丁";
	["Arcanist Doan"] = "祕法師杜安";
	["Taelan"] = "泰蘭";
	["Barkeep Kelly <Bartender>"] = "酒吧老闆凱利";
	["Frances Lin <Barmaid>"] = "法蘭斯·林";
	["Chef Jessen <Speciality Meat & Slop>"] = "廚師傑森";
	["Stalvan Mistmantle"] = "斯塔文·密斯特曼托";
	["Phin Odelic <The Kirin Tor>"] = "費恩·奧德利克";
	["Magistrate Henry Maleb"] = "赫尼·馬雷布鎮長";
	["Raleigh the True"] = "純真者洛歐欸";
	["Nathanos Marris"] = "納薩諾斯·瑪瑞斯";
	["Bilger the Straight-laced"] = "嚴厲者畢歐吉";
	["Innkeeper Monica"] = "旅店老闆莫妮卡";
	["Julie Honeywell"] = "喬莉·哈妮威爾";
	["Jay Lemieux"] = "杰·黎米厄斯";
	["Young Blanchy"] = "小馬布蘭契";
	["Don Carlos"] = "卡洛斯大爺";
	["Guerrero"] = "葛雷洛";

	--Gruul's Lair
	["High King Maulgar <Lord of the Ogres>"] = "大君王莫卡爾 <巨魔之王>";
	["Kiggler the Crazed"] = "瘋癲者奇克勒";
	["Blindeye the Seer"] = "先知盲眼";
	["Olm the Summoner"] = "召喚者歐莫";
	["Krosh Firehand"] = "克羅斯·火手";
	["Gruul the Dragonkiller"] = "弒龍者戈魯爾";

	--HFC: The Blood Furnace
	["Thrallmar"] = "索爾瑪";--omitted from other HFC
	["Honor Hold"] = "榮譽堡";--omitted from other HFC
	["Flamewrought Key"] = "火鑄之鑰";--omitted from other HFC
	["The Maker"] = "創造者";
	["Broggok"] = "布洛克";
	["Keli'dan the Breaker"] = "破壞者·凱利丹";

	--HFC: Hellfire Ramparts
	["Watchkeeper Gargolmar"] = "看護者卡爾古瑪";
	["Omor the Unscarred"] = "無疤者歐瑪爾";
	["Vazruden"] = "先驅者維斯路登";
	["Nazan <Vazruden's Mount>"] = "納桑";
	["Reinforced Fel Iron Chest"] = "強化惡魔鐵箱";

	--HFC: Magtheridon's Lair
	["Magtheridon"] = "瑪瑟里頓";

	--HFC: The Shattered Halls
	["Shattered Halls Key"] = "破碎大廳鑰匙";
	["Randy Whizzlesprocket"] = "藍迪·威索洛克";
	["Drisella"] = "崔賽拉";
	["Grand Warlock Nethekurse"] = "大術士·奈德克斯";
	["Blood Guard Porung"] = "血衛士波洛克";
	["Warbringer O'mrogg"] = "戰爭製造者·歐姆拉格";
	["Warchief Kargath Bladefist"] = "大酋長卡加斯·刃拳";
	["Shattered Hand Executioner"] = "破碎之手劊子手";
	["Private Jacint"] = "士兵賈辛特";
	["Rifleman Brownbeard"] = "槍兵伯朗畢爾";
	["Captain Alina"] = "隊長阿蓮娜";
	["Scout Orgarr"] = "斥候歐卡爾";
	["Korag Proudmane"] = "科洛特·波特曼";
	["Captain Boneshatter"] = "隊長碎骨";

	--Karazhan Start
	["The Violet Eye"] = "紫羅蘭之眼";--omitted from Karazhan End
	["The Master's Key"] = "主人鑰匙";--omitted from Karazhan End
	["Staircase to the Ballroom"] = "通往舞廳的樓梯間";
	["Stairs to Upper Stable"] = "通往上層的樓梯";
	["Ramp to the Guest Chambers"] = "通往迎賓廳斜坡";
	["Stairs to Opera House Orchestra Level"] = "通往歌劇院樂團層的樓梯";
	["Ramp from Mezzanine to Balcony"] = "夾層至包廂的斜坡";
	["Connection to Master's Terrace"] = "通往大師的露台";
	["Path to the Broken Stairs"] = "通往損壞的階梯";--omitted from Karazhan End
	["Hastings <The Caretaker>"] = "哈斯丁";
	["Servant Quarters"] = "伺從區";
	["Hyakiss the Lurker"] = "潛伏者亞奇斯";
	["Rokad the Ravager"] = "劫掠者·拉卡";
	["Shadikith the Glider"] = "滑翔者·薛迪依斯";
	["Berthold <The Doorman>"] = "勃特霍德";
	["Calliard <The Nightman>"] = "卡利卡";
	["Attumen the Huntsman"] = "獵人阿圖曼";
	["Midnight"] = "午夜";
	["Koren <The Blacksmith>"] = "卡爾侖";
	["Moroes <Tower Steward>"] = "摩洛";
	["Baroness Dorothea Millstipe"] = "女爵朵洛希·米爾斯泰普";
	["Lady Catriona Von'Indi"] = "凱崔娜·瓦映迪女士";
	["Lady Keira Berrybuck"] = "凱伊拉·拜瑞巴克女士";
	["Baron Rafe Dreuger"] = "男爵洛夫·崔克爾";
	["Lord Robin Daris"] = "貴族羅賓·達利斯";
	["Lord Crispin Ference"] = "貴族克利斯平·費蘭斯";
	["Bennett <The Sergeant at Arms>"] = "班尼特";
	["Ebonlocke <The Noble>"] = "埃伯洛克";
	["Keanna's Log"] = "琪安娜的日誌";
	["Maiden of Virtue"] = "貞潔聖女";
	["Sebastian <The Organist>"] = "塞巴斯汀";
	["Barnes <The Stage Manager>"] = "巴奈斯";
	["The Opera Event"] = "歌劇事件";
	["Red Riding Hood"] = "小紅帽";
	["The Big Bad Wolf"] = "大野狼";
	["Wizard of Oz"] = "綠野仙蹤";
	["Dorothee"] = "桃樂絲";
	["Tito"] = "多多";
	["Strawman"] = "稻草人";
	["Tinhead"] = "機器人";
	["Roar"] = "獅子";
	["The Crone"] = "老巫婆";
	["Romulo and Julianne"] = "羅密歐與茱莉葉";
	["Romulo"] = "羅密歐";
	["Julianne"] = "茱莉葉";
	["The Master's Terrace"] = "大師的露臺";
	["Nightbane"] = "夜禍";
	
	--Karazhan End
	["Broken Stairs"] = "損壞的階梯";
	["Ramp to Guardian's Library"] = "通往管理員圖書館的斜坡";
	["Suspicious Bookshelf"] = "神秘的書架";
	["Ramp up to the Celestial Watch"] = "通往天文觀測台的斜坡";
	["Ramp down to the Gamesman's Hall"] = "通往投機者大廳的斜坡";
	["Chess Event"] = "西洋棋事件";
	["Ramp to Medivh's Chamber"] = "通往麥迪文房間的斜坡";
	["Spiral Stairs to Netherspace"] = "通往虛空空間的螺旋梯";
	["The Curator"] = "館長";
	["Wravien <The Mage>"] = "瑞依恩 <法師>";
	["Gradav <The Warlock>"] = "葛瑞戴 <術士>";
	["Kamsis <The Conjurer>"] = "康席斯 <咒術師>";
	["Terestian Illhoof"] = "泰瑞斯提安·疫蹄";
	["Kil'rek"] = "基瑞克";
	["Shade of Aran"] = "艾蘭之影";
	["Netherspite"] = "尼德斯";
	["Ythyar"] = "伊斯亞爾";
	["Echo of Medivh"] = "麥迪文的回音";
	["Dust Covered Chest"] = "滿佈灰塵箱子";
	["Prince Malchezaar"] = "莫克札王子";
	
	--Magisters Terrace
	["Shattered Sun Offensive"] = "破碎之日進攻部隊";
	["Selin Fireheart"] = "斯琳·炎心";
	["Fel Crystals"] = "惡魔水晶";
	["Tyrith"] = "提里斯";
	["Vexallus"] = "維克索魯斯";
	["Scrying Orb"] = "索蘭尼亞的占卜寶珠";
	["Kalecgos"] = "卡雷苟斯";--omitted from SP
	["Priestess Delrissa"] = "女牧師戴利莎";
	["Apoko"] = "阿波考";
	["Eramas Brightblaze"] = "依拉瑪·火光";
	["Ellrys Duskhallow"] = "艾爾里斯·聖暮";
	["Fizzle"] = "費索";
	["Garaxxas"] = "卡拉克薩斯";
	["Sliver <Garaxxas' Pet>"] = "割裂者 <卡拉克薩斯的寵物>";
	["Kagani Nightstrike"] = "卡嘉尼·夜擊";
	["Warlord Salaris"] = "督軍沙拉利思";
	["Yazzai"] = "耶賽";
	["Zelfan"] = "塞爾汎";
	["Kael'thas Sunstrider <Lord of the Blood Elves>"] = "凱爾薩斯·逐日者 <血精靈領主>";--omitted from TK: The Eye

	--Sunwell Plateau
	["Sathrovarr the Corruptor"] = "『墮落者』塞斯諾瓦";
	["Madrigosa"] = "瑪德里茍沙";
	["Brutallus"] = "布魯托魯斯";
	["Felmyst"] = "魔霧";
	["Eredar Twins"] = "埃雷達爾雙子";
	["Grand Warlock Alythess"] = "大術士艾黎瑟絲";
	["Lady Sacrolash"] = "莎珂蕾希女士";
	["M'uru"] = "莫魯";
	["Entropius"] = "安卓普斯";
	["Kil'jaeden <The Deceiver>"] = "基爾加丹";

	--TK: The Arcatraz
	["Key to the Arcatraz"] = "亞克崔茲鑰匙";
	["Zereketh the Unbound"] = "無約束的希瑞奇斯";
	["Third Fragment Guardian"] = "第三碎片守衛者";
	["Dalliah the Doomsayer"] = "末日預言者達利亞";
	["Wrath-Scryer Soccothrates"] = "怒鐮者索扣斯瑞特";
	["Udalo"] = "先知烏達羅";
	["Harbinger Skyriss"] = "先驅者史蓋力司";
	["Warden Mellichar"] = "守望者米利恰爾";
	["Millhouse Manastorm"] = "米歐浩斯·曼納斯頓";

	--TK: The Botanica
	["The Sha'tar"] = "薩塔";--omitted from other TK
	["Warpforged Key"] = "扭曲鍛造鑰匙";--omitted from other TK
	["Commander Sarannis"] = "指揮官薩瑞尼斯";
	["High Botanist Freywinn"] = "大植物學家費瑞衛恩";
	["Thorngrin the Tender"] = "看管者索古林";
	["Laj"] = "拉杰";
	["Warp Splinter"] = "扭曲分裂者";

	--TK: The Mechanar
	["Gatewatcher Gyro-Kill"] = "看守者蓋洛奇歐";
	["Gatewatcher Iron-Hand"] = "看守者鐵手";
	["Cache of the Legion"] = "軍團儲藏處";
	["Mechano-Lord Capacitus"] = "機械王卡帕希特斯";
	["Overcharged Manacell"] = "滿溢的法力容器";
	["Nethermancer Sepethrea"] = "虛空術師賽派斯瑞";
	["Pathaleon the Calculator"] = "計算者帕薩里歐";

	--TK: The Eye
	["Al'ar <Phoenix God>"] = "歐爾 <鳳凰神>";
	["Void Reaver"] = "虛空劫掠者";
	["High Astromancer Solarian"] = "大星術師索拉瑞恩";
	["Thaladred the Darkener <Advisor to Kael'thas>"] = "凱爾薩斯·日行者 <凱爾薩斯諫言者>";
	["Master Engineer Telonicus <Advisor to Kael'thas>"] = "首席技師泰隆尼卡斯 <凱爾薩斯諫言者>";
	["Grand Astromancer Capernian <Advisor to Kael'thas>"] = "大星術師卡普尼恩 <凱爾薩斯諫言者>";
	["Lord Sanguinar <The Blood Hammer>"] = "桑古納爾領主 <血錘>";

	--Zul'Aman
	["Harrison Jones"] = "哈利森·瓊斯";
	["Nalorakk <Bear Avatar>"] = "納羅拉克 <熊化身>";
	["Tanzar"] = "坦札爾";
	["The Map of Zul'Aman"] = "祖阿曼地圖";
	["Akil'Zon <Eagle Avatar>"] = "阿奇爾森 <雄鷹化身>";
	["Harkor"] = "哈克爾";
	["Jan'Alai <Dragonhawk Avatar>"] = "賈納雷 <龍鷹化身>";
	["Kraz"] = "卡拉茲";
	["Halazzi <Lynx Avatar>"] = "哈拉齊 <山貓化身>";
	["Ashli"] = "阿西利";
	["Zungam"] = "祖剛";
	["Hex Lord Malacrass"] = "妖術領主瑪拉克雷斯";
	["Thurg"] = "瑟吉";
	["Gazakroth"] = "葛薩克羅司";
	["Lord Raadan"] = "領主雷阿登";
	["Darkheart"] = "黑心";
	["Alyson Antille"] = "艾利森·安第列";
	["Slither"] = "史立塞";
	["Fenstalker"] = "沼群巡者";
	["Koragg"] = "可拉格";
	["Zul'jin"] = "祖爾金";
	["Forest Frogs"] = "森林樹蛙";
	["Kyren <Reagents>"] = "凱倫 <施法材料>";
	["Gunter <Food Vendor>"] = "甘特 <食物商人>";
	["Adarrah"] = "阿達拉";
	["Brennan"] = "布里納";
	["Darwen"] = "達爾溫";
	["Deez"] = "迪滋";
	["Galathryn"] = "加拉瑟林";
	["Mitzi"] = "米特辛";
	["Mannuth"] = "曼努斯";
	
--*****************
-- WotLK Instances
--*****************

	--Azjol-Nerub: Ahn'kahet: The Old Kingdom
	["Elder Nadox"] = "老那杜斯";
	["Prince Taldaram"] = "泰爾達朗王子";
	["Jedoga Shadowseeker"] = "潔杜佳·尋影者";
	["Herald Volazj"] = "信使沃菈齊";
	["Amanitar"] = "毒蕈魔";
	["Ahn'kahet Brazier"] = "安卡罕特火盆";

	--Azjol-Nerub: Azjol-Nerub
	["Krik'thir the Gatewatcher"] = "『守門者』齊力克西爾";
	["Watcher Gashra"] = "看守者賈西拉";
	["Watcher Narjil"] = "看守者納吉爾";
	["Watcher Silthik"] = "看守者席爾希克";
	["Hadronox"] = "哈卓諾克斯";
	["Elder Nurgen"] = "訥金長者";
	["Anub'arak"] = "阿努巴拉克";

	--Caverns of Time: The Culling of Stratholme
	["The Culling of Stratholme"] = "斯坦索姆的抉擇";
	["Meathook"] = "肉鉤";
	["Salramm the Fleshcrafter"] = "『血肉工匠』塞歐朗姆";
	["Chrono-Lord Epoch"] = "紀元時間領主";
	["Mal'Ganis"] = "瑪爾加尼斯";
	["Chromie"] = "克羅米";
	["Infinite Corruptor"] = "恆龍墮落者";
	["Guardian of Time"] = "時光守護者";
	["Scourge Invasion Points"] = "天譴軍團地點";

	--Drak'Tharon Keep
	["Trollgore"] = "血角食人妖";
	["Novos the Summoner"] = "『召喚者』諾沃司";
	["Elder Kilias"] = "奇里亞斯長者";
	["King Dred"] = "崔德王之盔";
	["The Prophet Tharon'ja"] = "預言者薩隆杰";
	["Kurzel"] = "庫賽爾";
	["Drakuru's Brazier"] = "德拉庫魯的火盆";

	--The Frozen Halls: Halls of Reflection
	--3 beginning NPCs omitted, see The Forge of Souls
	["Falric"] = "法勒瑞克";
	["Marwyn"] = "麥爾溫";
	["Wrath of the Lich King"] = "巫妖王之怒";
	["The Captain's Chest"] = "船長的箱子";

	--The Frozen Halls: Pit of Saron
	--6 beginning NPCs omitted, see The Forge of Souls
	["Forgemaster Garfrost"] = "鍛造大師加弗羅斯";
	["Martin Victus"] = "馬汀·維特斯";
	["Gorkun Ironskull"] = "葛剛·鐵顱";
	["Krick and Ick"] = "克瑞克和艾克";
	["Scourgelord Tyrannus"] = "天譴領主提朗紐斯";
	["Rimefang"] = "霜牙";

	--The Frozen Halls: The Forge of Souls
	--Lady Jaina Proudmoore omitted, in Hyjal Summit
	["Archmage Koreln <Kirin Tor>"] = "大法師寇瑞倫 <祈倫托>";
	["Archmage Elandra <Kirin Tor>"] = "大法師伊蘭卓 <祈倫托>";
	["Lady Sylvanas Windrunner <Banshee Queen>"] = "希瓦娜斯·風行者女士 <女妖之王>";
	["Dark Ranger Loralen"] = "黑暗遊俠洛拉倫";
	["Dark Ranger Kalira"] = "黑暗遊俠卡麗菈";
	["Bronjahm <Godfather of Souls>"] = "布朗吉姆 <眾魂教父>";
	["Devourer of Souls"] = "眾魂吞噬者";

	--Gundrak
	["Slad'ran <High Prophet of Sseratus>"] = "史拉德銳 <司瑟拉圖斯高階預言者>";
	["Drakkari Colossus"] = "德拉克瑞巨像";
	["Elder Ohanzee"] = "歐漢茲長者";
	["Moorabi <High Prophet of Mam'toth>"] = "慕拉比 <曼多司高階預言者>";
	["Gal'darah <High Prophet of Akali>"] = "蓋爾達拉 <阿卡利高階預言者>";
	["Eck the Ferocious"] = "『兇猛』埃克";

	--Icecrown Citadel
	["The Ashen Verdict"] = "灰燼裁決軍";
	["Lord Marrowgar"] = "瑪洛嘉領主";
	["Lady Deathwhisper"] = "亡語女士";
	["Gunship Battle"] = "砲艇戰";
	["Deathbringer Saurfang"] = "死亡使者薩魯法爾";
	["Festergut"] = "膿腸";
	["Rotface"] = "腐臉";
	["Professor Putricide"] = "普崔希德教授";
	["Blood Prince Council"] = "血親王議會";
	["Prince Keleseth"] = "凱雷希斯王子";
	["Prince Taldaram"] = "泰爾達朗王子";
	["Prince Valanar"] = "瓦拉納爾王子";
	["Blood-Queen Lana'thel"] = "血腥女王菈娜薩爾";
	["Valithria Dreamwalker"] = "瓦莉絲瑞雅·夢行者";
	["Sindragosa <Queen of the Frostbrood>"] = "辛德拉苟莎 <霜育之后>";
	["The Lich King"] = "巫妖王";
	["To next map"] = "到下一個地圖";
	["From previous map"] = "到前一個地圖";
	["Upper Spire"] = "冰冠尖塔";
	["Sindragosa's Lair"] = "辛德拉苟莎之巢";

	--Naxxramas
	["Mr. Bigglesworth"] = "畢勾沃斯先生";
	["Patchwerk"] = "縫補者";
	["Grobbulus"] = "葛羅巴斯";
	["Gluth"] = "古魯斯";
	["Thaddius"] = "泰迪斯";
	["Anub'Rekhan"] = "阿努比瑞克漢";
	["Grand Widow Faerlina"] = "大寡婦費琳娜";
	["Maexxna"] = "梅克絲娜";
	["Instructor Razuvious"] = "講師拉祖維斯";
	["Gothik the Harvester"] = "『收割者』高希";
	["The Four Horsemen"] = "四騎士";
	["Thane Korth'azz"] = "寇斯艾茲族長";
	["Lady Blaumeux"] = "布洛莫斯女士";
	--Baron Rivendare omitted, listed under Stratholme
	["Sir Zeliek"] = "札里克爵士";
	["Four Horsemen Chest"] = "四騎士之箱";
	["Noth the Plaguebringer"] = "『瘟疫使者』諾斯";
	["Heigan the Unclean"] = "『不潔者』海根";
	["Loatheb"] = "憎恨者";
	["Frostwyrm Lair"] = "冰霜巨龍的巢穴";
	["Sapphiron"] = "薩菲隆";
	["Kel'Thuzad"] = "科爾蘇加德";

	--The Obsidian Sanctum
	["Black Dragonflight Chamber"] = "黑龍軍團密室";
	["Sartharion <The Onyx Guardian>"] = "撒爾薩里安 <黑曜守護者>";
	["Tenebron"] = "坦納伯朗";
	["Shadron"] = "夏德朗";
	["Vesperon"] = "維斯佩朗";

	--Onyxia's Lair
	["Onyxian Warders"] = "奧妮克希亞守衛";
	["Whelp Eggs"] = "雛龍蛋";
	["Onyxia"] = "奧妮克希亞";

	--The Ruby Sanctum
	["Red Dragonflight Chamber"] = "紅龍軍團密室";
	["Baltharus the Warborn"] = "『戰爭之子』巴爾薩魯斯";
	["Saviana Ragefire"] = "薩薇安娜‧怒焰";
	["General Zarithrian"] = "扎里斯利安將軍";
	["Halion <The Twilight Destroyer>"] = "海萊恩 <暮光毀滅者>";

	--The Nexus: The Eye of Eternity
	["Malygos"] = "瑪里苟斯";
	["Key to the Focusing Iris"] = "聚源虹膜之鑰";

	--The Nexus: The Nexus	
	["Berinand's Research"] = "貝瑞那德的研究";
	["Commander Stoutbeard"] = "指揮官厚鬚";
	["Commander Kolurg"] = "指揮官寇勒格";
	["Grand Magus Telestra"] = "大魔導師特雷斯翠";
	["Anomalus"] = "艾諾瑪路斯";
	["Elder Igasho"] = "伊加修長者";
	["Ormorok the Tree-Shaper"] = "『樹木造形者』歐爾莫洛克";
	["Keristrasza"] = "凱瑞史卓莎";


	--The Nexus: The Oculus
	["Drakos the Interrogator"] = "『審問者』德拉高斯";
	["Mage-Lord Urom"] = "法師領主厄隆";
	["Ley-Guardian Eregos"] = "地脈守護者伊瑞茍斯";
	["Varos Cloudstrider <Azure-Lord of the Blue Dragonflight>"] = "瓦羅斯·雲行者";
	["Centrifuge Construct"] = "離心傀儡";
	["Cache of Eregos"] = "伊瑞茍斯的貯藏箱";	

	--Trial of the Champion
	["Grand Champions"] = "大勇士";
	["Champions of the Alliance"] = "聯盟大勇士";
	["Marshal Jacob Alerius"] = "傑科布·亞雷瑞斯元帥";
	["Ambrose Boltspark"] = "安布羅斯·拴炫";
	["Colosos"] = "克羅索斯";
	["Jaelyne Evensong"] = "潔琳·晚歌";
	["Lana Stouthammer"] = "菈娜·頑錘";
	["Champions of the Horde"] = "部落大勇士";
	["Mokra the Skullcrusher"] = "『碎顱者』莫克拉";
	["Eressea Dawnsinger"] = "艾瑞西雅·曦詠";
	["Runok Wildmane"] = "魯諾克·蠻鬃";
	["Zul'tore"] = "祖爾拓";
	["Deathstalker Visceri"] = "亡靈哨兵威瑟瑞";
	["Eadric the Pure <Grand Champion of the Argent Crusade>"] = "『純淨者』埃卓克 <銀白十字軍大勇士>";
	["Argent Confessor Paletress"] = "銀白告解者帕爾璀絲";
	["The Black Knight"] = "黑騎士";

	--Trial of the Crusader
	["Cavern Entrance"] = "洞穴入口";
	["Northrend Beasts"] = "北裂境巨獸";
	["Gormok the Impaler"] = "『穿刺者』戈莫克";
	["Acidmaw"] = "酸喉";
	["Dreadscale"] = "懼鱗";
	["Icehowl"] = "冰嚎";
	["Lord Jaraxxus"] = "賈拉克瑟斯領主";
	["Faction Champions"] = "陣營勇士";
	["Twin Val'kyr"] = "華爾琪雙子";
	["Fjola Lightbane"] = "菲歐拉·光寂";
	["Eydis Darkbane"] = "艾狄絲·暗寂";
	["Anub'arak"] = "阿努巴拉克";
	["Heroic: Trial of the Grand Crusader"] = "英雄: 大十字軍試煉";

	-- Ulduar General
	["Celestial Planetarium Key"] = "星穹渾天儀之鑰";
	["The Siege"] = "攻城區";
	["The Keepers"] = "守護者"; --C

	-- Ulduar A
	["Flame Leviathan"] = "烈焰戰輪";
	["Ignis the Furnace Master"] = "『火爐之主』伊格尼司";
	["Razorscale"] = "銳鱗";
	["XT-002 Deconstructor"] = "XT-002拆解者";
	["Tower of Life"] = "生命之塔";
	["Tower of Flame"] = "烈焰之塔";
	["Tower of Frost"] = "冰霜之塔";
	["Tower of Storms"] = "風暴之塔";

	-- Ulduar B
	["Assembly of Iron"] = "鐵之集會";
	["Steelbreaker"] = "破鋼者";
	["Runemaster Molgeim"] = "符文大師墨吉姆";
	["Stormcaller Brundir"] = "風暴召喚者布倫迪爾";
	["Kologarn"] = "柯洛剛恩";
	["Algalon the Observer"] = "『觀察者』艾爾加隆";
	["Prospector Doren"] = "勘察員多倫";
	["Archivum Console"] = "大資料庫控制臺";

	-- Ulduar C
	["Auriaya"] = "奧芮雅";
	["Freya"] = "芙蕾雅";
	["Thorim"] = "索林姆";
	["Hodir"] = "霍迪爾";

	-- Ulduar D
	["Mimiron"] = "彌米倫";

	-- Ulduar E
	["General Vezax"] = "威札斯將軍";
	["Yogg-Saron"] = "尤格薩倫";

	--Ulduar: Halls of Lightning
	["General Bjarngrim"] = "畢亞格林將軍";
	["Volkhan"] = "渥克瀚";
	["Ionar"] = "埃歐納";
	["Loken"] = "洛肯";

	--Ulduar: Halls of Stone
	["Elder Yurauk"] = "由羅克長者";	
	["Krystallus"] = "克利斯托魯斯";
	["Maiden of Grief"] = "悲嘆少女";
	["Brann Bronzebeard"] = "布萊恩·銅鬚";
	["Tribunal Chest"] = "議庭之箱";
	["Sjonnir the Ironshaper"] = "『塑鐵者』斯雍尼爾";	

	--Utgarde Keep: Utgarde Keep
	["Dark Ranger Marrah"] = "黑暗遊俠瑪拉";
	["Prince Keleseth <The San'layn>"] = "凱雷希斯王子";
	["Elder Jarten"] = "加坦長者";
	["Dalronn the Controller"] = "『控制者』達隆恩";
	["Skarvald the Constructor"] = "『建造者』史卡沃";
	["Ingvar the Plunderer"] = "『盜掠者』因格瓦";

	--Utgarde Keep: Utgarde Pinnacle
	["Brigg Smallshanks"] = "布里格·細柄";
	["Svala Sorrowgrave"] = "絲瓦拉·悲傷亡墓"; 
	["Gortok Palehoof"] = "戈托克·白蹄";
	["Skadi the Ruthless"] = "無情的斯卡迪";
	["Elder Chogan'gada"] = "修干加達長者";
	["King Ymiron"] = "依米倫王";

	--Vault of Archavon
	["Archavon the Stone Watcher"] = "『石之看守者』亞夏梵";
	["Emalon the Storm Watcher"] = "『風暴看守者』艾瑪隆";	
	["Koralon the Flame Watcher"] = "『烈焰看守者』寇拉隆";
	["Toravon the Ice Watcher"] = "『寒冰看守者』拓拉梵";

	--The Violet Hold
	["Erekem"] = "伊銳坎";
	["Zuramat the Obliterator"] = "『消滅者』舒拉邁特";
	["Xevozz"] = "基沃滋";
	["Ichoron"] = "伊仇隆";
	["Moragg"] = "摩拉革";
	["Lavanthor"] = "拉方索";
	["Cyanigosa"] = "霞妮苟莎";
	["The Violet Hold Key"] = "紫羅蘭堡鑰匙";
};
end
