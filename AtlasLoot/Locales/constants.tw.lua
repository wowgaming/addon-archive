-- $Id: constants.tw.lua 2726 2010-07-18 17:31:56Z arith $
--[[
constants.tw.lua
This file defines an AceLocale table for all the various text strings needed
by AtlasLoot.  In this implementation, if a translation is missing, it will fall
back to the English translation.

The AL["text"] = true; shortcut can ONLY be used for English (the root translation).
]]

--Table holding all loot tables is initialised here as it loads early
--AtlasLoot_Data = {};

--Create the library instance
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");

local AL = AceLocale:NewLocale("AtlasLoot", "zhTW", false);

--Register translations
if AL then

	--Text strings for UI objects
	AL["AtlasLoot"] = "AtlasLoot";
	AL["Select Loot Table"] = "選擇物品表格";
	AL["Select Sub-Table"] = "選擇子表格";
	AL["Drop Rate: "] = "掉落機率: ";
	AL["DKP"] = "DKP";
	AL["Priority:"] = "優先權: ";
	AL["Click boss name to view loot."] = "點選首領以檢視物品表";
	AL["Various Locations"] = "多個地方";
	AL["This is a loot browser only.  To view maps as well, install either Atlas or Alphamap."] = "這只是一個物品檢視視窗。如要檢視地圖，請安裝 Atlas 或是 Alphamap。";
	AL["Toggle AL Panel"] = "AtlasLoot 面板";
	AL["Back"] = "返回";
	AL["Level 60"] = "60 級";
	AL["Level 70"] = "70 級";
	AL["Level 80"] = "80 級";
	AL["|cffff0000(unsafe)"] = "|cffff0000(不安全)";
	AL["Misc"] = "雜項";
	AL["Miscellaneous"] = "雜項";
	AL["Rewards"] = "獎勵";
	AL["Show 10 Man Loot"] = "10 人團隊物品表";
	AL["Show 25 Man Loot"] = "25 人團隊物品表";
	AL["Factions - Original WoW"] = "陣營 - 舊世界";
	AL["Factions - Burning Crusade"] = "陣營 - 燃燒的遠征";
	AL["Factions - Wrath of the Lich King"] = "陣營 - 巫妖王之怒";
	AL["Choose Table ..."] = "選擇表格...";
	AL["Unknown"] = "未知";
	AL["Add to QuickLooks:"] = "新增至快速瀏覽";
	AL["Assign this loot table\n to QuickLook"] = "分配此物品表\n 至快速瀏覽";
	AL["Query Server"] = "向伺服器查詢";
	AL["Reset Frames"] = "重設框架";
	AL["Reset Wishlist"] = "重設願望清單";
	AL["Reset Quicklooks"] = "重設快速瀏覽";
	AL["Select a Loot Table..."] = "選擇一個物品表";
	AL["OR"] = "或";
	AL["FuBar Options"] = "FuBar 選項";
	AL["Attach to Minimap"] = "依附於小地圖上";
	AL["Hide FuBar Plugin"] = "隱藏 FuBar 插件";
	AL["Show FuBar Plugin"] = "顯示 FuBar 插件";
	AL["Position:"] = "位置";
	AL["Left"] = "左";
	AL["Center"] = "中";
	AL["Right"] = "右";
	AL["Hide Text"] = "隱藏文字";
	AL["Hide Icon"] = "隱藏圖示";
	AL["Minimap Button Options"] = "小地圖按鍵選項";

	--Text for Options Panel
	AL["Atlasloot Options"] = "Atlasloot 選項";
	AL["Safe Chat Links"] = "安全物品連結";
	AL["Default Tooltips"] = "預設提示";
	AL["Lootlink Tooltips"] = "Lootlink 提示";
	AL["|cff9d9d9dLootlink Tooltips|r"] = "|cff9d9d9dLootlink 提示|r";
	AL["ItemSync Tooltips"] = "ItemSync 提示";
	AL["|cff9d9d9dItemSync Tooltips|r"] = "|cff9d9d9dItemSync 提示|r";
	AL["Use EquipCompare"] = "使用 EquipCompare";
	AL["|cff9d9d9dUse EquipCompare|r"] = "|cff9d9d9d使用 EquipCompare|r";
	AL["Show Comparison Tooltips"] = "顯示物品比較提示訊息";
	AL["Make Loot Table Opaque"] = "使物品掉落表不透明";
	AL["Show itemIDs at all times"] = "顯示物品 ID";
	AL["Hide AtlasLoot Panel"] = "隱藏 AtlasLoot 面板";
	AL["Show Basic Minimap Button"] = "顯示基本小地圖按鍵";
	AL["|cff9d9d9dShow Basic Minimap Button|r"] = "|cff9d9d9d顯示基本小地圖按鍵";
	AL["Set Minimap Button Position"] = "設定小地圖按鍵位置";
	AL["Suppress Item Query Text"] = "關閉物品查詢文字";
	AL["Notify on LoD Module Load"] = "載入模組通知";
	AL["Load Loot Modules at Startup"] = "在起始時載入所有模組";
	AL["Loot Browser Scale: "] = "物品表大小";
	AL["Button Position: "] = "按鍵位置";
	AL["Button Radius: "] = "按鍵軸距";
	AL["Done"] = "完成";
	AL["FuBar Toggle"] = "切換 FuBar";
	AL["Search Result: %s"] = "搜尋結果: %s";
	AL["Search on"] = "在以下模組搜尋: ";
	AL["All modules"] = "所有模組";
	AL["If checked, AtlasLoot will load and search across all the modules."] = "勾選以載入所有模組並在各模組間搜尋。";
	AL["Search options"] = "搜尋選項";
	AL["Partial matching"] = "部份符合";
	AL["If checked, AtlasLoot search item names for a partial match."] = "勾選以啟用部份符合。";
	AL["You don't have any module selected to search on!"] = "沒有任何模組被選取以進行搜尋！";
	AL["Treat Crafted Items:"] = "交易技能呈現方式:";
	AL["As Crafting Spells"] = "技能";
	AL["As Items"] = "製成品";
	AL["Loot Browser Style:"] = "物品掉落表呈現方式:";
	AL["New Style"] = "新樣式";
	AL["Classic Style"] = "傳統樣式";

	--Slash commands
	AL["reset"] = "重設";
	AL["options"] = "選項";
	AL["Reset complete!"] = "重設完成";

	--AtlasLoot Panel
	AL["Collections"] = "套裝/特殊物品";
	AL["Crafting"] = "交易技能物品";
	AL["Factions"] = "陣營";
	AL["Load Modules"] = "載入模組";
	AL["Options"] = "選項";
	AL["PvP Rewards"] = "PvP 榮譽獎勵";
	AL["QuickLook"] = "快速瀏覽";
	AL["World Events"] = "世界事件";

	--AtlasLoot Panel - Search
	AL["Clear"] = "清除";
	AL["Last Result"] = "上次的結果";
	AL["Search"] = "搜尋";

	--AtlasLoot Browser Menus
	AL["Classic Instances"] = "舊世界副本";
	AL["BC Instances"] = "燃燒的遠征副本";
	AL["Sets/Collections"] = "套裝/特殊物品";
	AL["Reputation Factions"] = "聲望獎勵";
	AL["WotLK Instances"] = "巫妖王之怒副本";
	AL["World Bosses"] = "世界首領";
	AL["Close Menu"] = "關閉選單";

	--Crafting Menu
	AL["Crafting Daily Quests"] = "交易技能每日任務";
	AL["Cooking Daily"] = "烹飪每日任務";
	AL["Fishing Daily"] = "釣魚每日任務";
	AL["Jewelcrafting Daily"] = "珠寶加工每日任務";
	AL["Crafted Sets"] = "交易技能套裝";
	AL["Crafted Epic Weapons"] = "交易技能史詩武器";
	AL["Dragon's Eye"] = "龍瞳石";

	--Sets/Collections Menu
	AL["Badge of Justice Rewards"] = "正義徽章獎勵";
	AL["Emblem of Valor Rewards"] = "勇氣紋章獎勵";
	AL["Emblem of Heroism Rewards"] = "英雄紋章獎勵";
	AL["Emblem of Conquest Rewards"] = "征服紋章獎勵";
	AL["Emblem of Triumph Rewards"] = "凱旋紋章獎勵";
	AL["Emblem of Frost Rewards"] = "冰霜紋章獎勵";
	AL["BoE World Epics"] = "裝綁世界掉落紫裝";
	AL["Dungeon 1/2 Sets"] = "副本套裝 1/2";
	AL["Dungeon 3 Sets"] = "副本套裝 3";
	AL["Legendary Items"] = "傳說物品";
	AL["Mounts"] = "坐騎";
	AL["Vanity Pets"] = "普通寵物";
	AL["Misc Sets"] = "其他套裝";
	AL["Classic Sets"] = "舊世界套裝";
	AL["Burning Crusade Sets"] = "燃燒的遠征套裝";
	AL["Wrath Of The Lich King Sets"] = "巫妖王之怒套裝";
	AL["Ruins of Ahn'Qiraj Sets"] = "安其拉廢墟套裝";
	AL["Temple of Ahn'Qiraj Sets"] = "安其拉神廟套裝";
	AL["Tabards"] = "外袍";
	AL["Tier 1/2 Sets"] = "T1/2 套裝";
	AL["Tier 1/2/3 Sets"] = "T1/2/3 套裝";
	AL["Tier 3 Sets"] = "T3 套裝";
	AL["Tier 4/5/6 Sets"] = "T4/5/6 套裝";
	AL["Tier 7/8 Sets"] = "T7/T8 套裝";
	AL["Upper Deck Card Game Items"] = "Upper Deck 卡片遊戲物品";
	AL["Zul'Gurub Sets"] = "祖爾格拉布套裝";

	--Factions Menu
	AL["Original Factions"] = "舊世界陣營";
	AL["BC Factions"] = "燃燒的遠征陣營";
	AL["WotLK Factions"] = "巫妖王之怒陣營";

	--PvP Menu
	AL["Arena PvP Sets"] = "競技場 PvP 套裝";
	AL["PvP Rewards (Level 60)"] = "PvP 獎勵 (60 級)";
	AL["PvP Rewards (Level 70)"] = "PvP 獎勵 (70 級)";
	AL["PvP Rewards (Level 80)"] = "PvP 獎勵 (80 級)";
	AL["Arathi Basin Sets"] = "阿拉希盆地套裝";
	AL["PvP Accessories"] = "PvP 配件";
	AL["PvP Armor Sets"] = "PvP 套裝";
	AL["PvP Weapons"] = "PvP 武器";
	AL["PvP Non-Set Epics"] = "PvP 非套裝史詩物品";
	AL["PvP Reputation Sets"] = "PvP 聲望套裝";
	AL["Arena PvP Weapons"] = "競技場 PvP 武器";
	AL["PvP Misc"] = "PvP 珠寶加工設計圖";
	AL["PVP Gems/Enchants/Jewelcrafting Designs"] = "PvP 珠寶/附魔設計圖";
	AL["Level 80 PvP Sets"] = "等級 80 PvP 套裝";
	AL["Old Level 80 PvP Sets"] = "舊等級 80 PvP 套裝";
	AL["Arena Season 7/8 Sets"] = "競技場第七/八季 PvP 套裝";
	AL["PvP Class Items"] = "PvP 職業物品";
	AL["NOT AVAILABLE ANYMORE"] = "已不再提供";

	--World Events
	AL["Abyssal Council"] = "深淵議會";
	AL["Argent Tournament"] = "銀白聯賽";
	AL["Bash'ir Landing Skyguard Raid"] = "貝許爾平臺空防";
	AL["Brewfest"] = "啤酒節";
	AL["Children's Week"] = "兒童週";
	AL["Day of the Dead"] = "亡者節";
	AL["Elemental Invasion"] = "元素入侵";
	AL["Ethereum Prison"] = "伊斯利恩監獄";
	AL["Feast of Winter Veil"] = "冬幕節";
	AL["Gurubashi Arena Booty Run"] = "古拉巴什競技場藏寶競技";
	AL["Hallow's End"] = "復活節";
	AL["Harvest Festival"] = "收穫節";
	AL["Love is in the Air"] = "愛就在你我身邊";
	AL["Lunar Festival"] = "農曆新年慶典";
	AL["Midsummer Fire Festival"] = "仲夏火焰節慶";
	AL["Noblegarden"] = "彩蛋節";
	AL["Pilgrim's Bounty"] = "旅人豐年祭";
	AL["Skettis"] = "司凱堤斯";
	AL["Stranglethorn Fishing Extravaganza"] = "荊棘谷釣魚大賽";

	--Minimap Button
	AL["|cff1eff00Left-Click|r Browse Loot Tables"] = "|cff1eff00左鍵|r 瀏覽物品掉落表";
	AL["|cffff0000Right-Click|r View Options"] = "|cffff0000右鍵|r 檢視選項";
	AL["|cffff0000Shift-Click|r View Options"] = "|cffff0000Shift點擊|r 檢視選項";
	AL["|cffccccccLeft-Click + Drag|r Move Minimap Button"] = "|cffcccccc左鍵並拖曳以移動圖示位置";
	AL["|cffccccccRight-Click + Drag|r Move Minimap Button"] = "|cffcccccc右鍵並拖曳以移動圖示位置";

	-- Filter
	AL["Filter"] = "篩選";
	AL["Select All Loot"] = "選擇所有掉落物品";
	AL["Apply Filter:"] = "套用篩選條件";
	AL["Armor:"] = "護甲種類:";
	AL["Melee weapons:"] = "近戰武器:";
	AL["Ranged weapons:"] = "遠程武器:";
	AL["Relics:"] = "聖物";
	AL["Other:"] = "其他:";

	-- Wishlist
	AL["Close"] = "關閉";
	AL["Wishlist"] = "裝備願望清單";
	AL["Own Wishlists"] = "自己的願望清單";
	AL["Other Wishlists"] = "其他的願望清單";
	AL["Shared Wishlists"] = "分享的願望清單";
	AL["Mark items in loot tables"] = "在物品表標記物品";
	AL["Mark items from own Wishlist"] = "從自己的願望清單標記物品";
	AL["Mark items from all Wishlists"] = "從所有的願望清單標記物品";
	AL["Enable Wishlist Sharing"] = "允許願望清單分享";
	AL["Auto reject in combat"] = "戰鬥中自動拒絕";
	AL["Always use default Wishlist"] = "永遠使用預設的願望清單";
	AL["Add Wishlist"] = "新增願望清單";
	AL["Edit Wishlist"] = "編輯願望清單";
	AL["Show More Icons"] = "顯示更多圖示";
	AL["Wishlist name:"] = "願望清單名稱:";
	AL["Delete"] = "刪除";
	AL["Edit"] = "編輯";
	AL["Share"] = "分享";
	AL["Show all Wishlists"] = "顯示所有的願望清單";
	AL["Show own Wishlists"] = "顯示自己的願望清單";
	AL["Show shared Wishlists"] = "顯示分享的願望清單";
	AL["You must wait "] = "你必須等候 ";
	AL[" seconds before you can send a new Wishlist to "] = " 秒後才可以將願望清單傳送給";
	AL["Send Wishlist (%s) to"] = "傳送 '%s' 願望清單給";
	AL["Send"] = "傳送";
	AL["Cancel"] = "取消";
	AL["Delete Wishlist %s?"] = "是否刪除 '%s' 願望清單?";
	AL["%s sends you a Wishlist. Accept?"] = "%s傳送了一個願望清單給你，是否接受?";
	AL[" tried to send you a Wishlist. Rejected because you are in combat."] = "嘗試傳送一個願望清單給你，因你正在戰鬥中而系統自動拒絕了。";
	AL[" rejects your Wishlist."] = "拒絕了你的願望清單";
	AL["You can't send Wishlists to yourself"] = "你不能將願望清單傳送給自己。";
	AL["Please set a default Wishlist."] = "請設定一個預設的願望清單。";
	AL["Set as default Wishlist"] = "設為預設的願望清單";

	--Misc Inventory related words
	AL["Enchant"] = "公式";
	AL["Scope"] = "瞄準鏡";
	AL["Darkmoon Faire Card"] = "暗月卡";
	AL["Banner"] = "軍旗";
	AL["Set"] = "套裝";
	AL["Token"] = "勳章";
	AL["Tokens"] = "勳章";
	AL["Token Hand-Ins"] = "勳章繳交";
	AL["Skinning Knife"] = "剝皮小刀";
	AL["Herbalism Knife"] = "草藥刀";
	AL["Fish"] = "釣魚";
	AL["Combat Pet"] = "戰鬥寵物";
	AL["Fireworks"] = "煙火";
	AL["Fishing Lure"] = "魚餌";

	--Extra inventory stuff
	AL["Cloak"] = "披風";
	AL["Sigil"] = "符印"; --Can be added to BabbleInv

	--Alchemy
	AL["Battle Elixirs"] = "戰鬥藥劑";
	AL["Guardian Elixirs"] = "防護藥劑";
	AL["Potions"] = "藥水";
	AL["Transmutes"] = "轉化";
	AL["Flasks"] = "精煉藥劑";

	--Enchanting
	AL["Enchant Boots"] = "附魔靴子";
	AL["Enchant Bracer"] = "附魔護腕";
	AL["Enchant Chest"] = "附魔胸甲";
	AL["Enchant Cloak"] = "附魔披風";
	AL["Enchant Gloves"] = "附魔手套";
	AL["Enchant Ring"] = "附魔戒指";
	AL["Enchant Shield"] = "附魔盾牌";
	AL["Enchant 2H Weapon"] = "附魔雙手武器";
	AL["Enchant Weapon"] = "附魔武器";

	--Engineering
	AL["Ammunition"] = "彈藥";
	AL["Explosives"] = "爆裂物";

	--Inscription
	AL["Major Glyph"] = "極效雕紋";
	AL["Minor Glyph"] = "初階雕紋";
	AL["Scrolls"] = "卷軸";
	AL["Off-Hand Items"] = "副手物品";
	AL["Reagents"] = "材料";
	AL["Book of Glyph Mastery"] = "雕紋精通之書";

	--Leatherworking
	AL["Leather Armor"] = "皮甲護甲";
	AL["Mail Armor"] = "鎖甲護甲";
	AL["Cloaks"] = "披風";
	AL["Item Enhancements"] = "物品附魔";
	AL["Quivers and Ammo Pouches"] = "箭袋/彈藥袋";
	AL["Drums, Bags and Misc."] = "戰鼓、背包與其他物品";

	--Tailoring
	AL["Cloth Armor"] = "護甲";
	AL["Shirts"] = "襯衣";
	AL["Bags"] = "容器";

	--Labels for loot descriptions
	AL["Classes:"] = "職業: ";
	AL["This Item Begins a Quest"] = "該物品將觸發一個任務";
	AL["Quest Item"] = "任務物品";
	AL["Old Quest Item"] = "舊任務物品";
	AL["Quest Reward"] = "任務獎勵";
	AL["Old Quest Reward"] = "舊任務獎勵";
	AL["Shared"] = "隨機掉落";
	AL["Unique"] = "唯一";
	AL["Right Half"] = "右半部份";
	AL["Left Half"] = "左半部份";
	AL["28 Slot Soul Shard"] = "28 格靈魂袋";
	AL["20 Slot"] = "20 格容器";
	AL["18 Slot"] = "18 格容器";
	AL["16 Slot"] = "16 格容器";
	AL["10 Slot"] = "10 格容器";
	AL["(has random enchantment)"] = "(具有隨機屬性)";
	AL["Currency"] = "貨幣";
	AL["Currency (Alliance)"] = "貨幣 (聯盟)";
	AL["Currency (Horde)"] = "貨幣 (部落)";
	AL["Conjured Item"] = "特殊物品";
	AL["Used to summon boss"] = "使用以召喚首領";
	AL["Tradable against sunmote + item above"] = "以太陽微粒兌換的裝備";
	AL["Card Game Item"] = "卡片遊戲物品";
	AL["Skill Required:"] = "需要技能等級: ";
	AL["Rating:"] = "等級:";	--Shorthand for 'Required Rating' for the personal/team ratings in Arena S4
	AL["Random Heroic Reward"] = "隨機英雄副本獎勵";

	--Minor Labels for loot table descriptions
	AL["Original WoW"] = "舊魔獸世界";
	AL["Burning Crusade"] = "燃燒的遠征";
	AL["Wrath of the Lich King"] = "巫妖王之怒";
	AL["Entrance"] = "入口";
	AL["Season 2"] = "第二季聯賽";
	AL["Season 3"] = "第三季聯賽";
	AL["Season 4"] = "第四季聯賽";
	AL["Dungeon Set 1"] = "副本套裝 1";
	AL["Dungeon Set 2"] = "副本套裝 2";
	AL["Dungeon Set 3"] = "副本套裝 3";
	AL["Tier 1"] = "T1";
	AL["Tier 2"] = "T2";
	AL["Tier 3"] = "T3";
	AL["Tier 4"] = "T4";
	AL["Tier 5"] = "T5";
	AL["Tier 6"] = "T6";
	AL["Tier 7"] = "T7";
	AL["Tier 8"] = "T8";
	AL["Tier 9"] = "T9";
	AL["Tier 10"] = "T10";
	AL["10 Man"] = "10 人";
	AL["25 Man"] = "25 人";
	AL["10/25 Man"] = "10/25 人";
	AL["Epic Set"] = "PvP 史詩套裝";
	AL["Rare Set"] = "PvP 稀有套裝";
	AL["Fire"] = "赤紅";
	AL["Water"] = "碧藍";
	AL["Wind"] = "蒼白";
	AL["Earth"] = "土色";
	AL["Master Angler"] = "釣魚大師";
	AL["Fire Resistance Gear"] = "火抗裝備";
	AL["Arcane Resistance Gear"] = "秘法抗性裝備";
	AL["Nature Resistance Gear"] = "自然抗性裝備";
	AL["Frost Resistance Gear"] = "冰霜抗性裝備";
	AL["Shadow Resistance Gear"] = "暗影抗性裝備";

	--Labels for loot table sections
	AL["Additional Heroic Loot"] = "更多的英雄物品";
	AL["Heroic Mode"] = "英雄模式";
	AL["Normal Mode"] = "一般模式";
	AL["Raid"] = "團隊";
	AL["Hard Mode"] = "困難模式";
	AL["Bonus Loot"] = "額外獎勵";
	AL["One Drake Left"] = "剩餘一隻飛龍";
	AL["Two Drakes Left"] = "剩餘二隻飛龍";
	AL["Three Drakes Left"] = "剩餘三隻飛龍";
	AL["Arena Reward"] = "競技場獎勵";
	AL["Phase 1"] = "第一階段";
	AL["Phase 2"] = "第二階段";
	AL["Phase 3"] = "第三階段";
	AL["First Prize"] = "頭獎";
	AL["Rare Fish Rewards"] = "稀有釣魚獎勵";
	AL["Rare Fish"] = "稀有魚類";
	AL["Unattainable Tabards"] = "難以取得的外袍";
	AL["Heirloom"] = "家傳物品";
	AL["Weapons"] = "武器";
	AL["Accessories"] = "配件";
	AL["Alone in the Darkness"] = "闇境孤軍";
	AL["Call of the Grand Crusade"] = "大十字軍的呼喚";
	AL["A Tribute to Skill (25)"] = "獻給技藝精湛";
	AL["A Tribute to Mad Skill (45)"] = "獻給瘋狂的技藝";
	AL["A Tribute to Insanity (50)"] = "獻給瘋子";
	AL["A Tribute to Immortality"] = "獻給不朽";
	AL["Low Level"] = "較低等級";
	AL["High Level"] = "較高等級";

	--Loot Table Names
	AL["Scholomance Sets"] = "通靈學院套裝";
	AL["PvP Accessories (Level 60)"] = "PvP 配件 (60 級)";
	AL["PvP Accessories - Alliance (Level 60)"] = "PvP 聯盟配件 (60 級)";
	AL["PvP Accessories - Horde (Level 60)"] = "PvP 部落配件 (60 級)";
	AL["PvP Weapons (Level 60)"] = "PvP 武器 (60 級)";
	AL["PvP Accessories (Level 70)"] = "PvP 配件 (70 級)";
	AL["PvP Weapons (Level 70)"] = "PvP 武器 (70 級)";
	AL["PvP Reputation Sets (Level 70)"] = "PvP 聲望套裝 (等級 70)";
	AL["Arena Season 2 Weapons"] = "競技場第二季武器";
	AL["Arena Season 3 Weapons"] = "競技場第三季武器";
	AL["Arena Season 4 Weapons"] = "競技場第四季武器";
	AL["Level 30-39"] = "等級 30～39";
	AL["Level 40-49"] = "等級 40～49";
	AL["Level 50-60"] = "等級 50～60";
	AL["Heroic"] = "英雄模式";
	AL["Summon"] = "召喚";
	AL["Random"] = "隨機";
	AL["Tier 8 Sets"] = "T8 套裝";
	AL["Tier 9 Sets"] = "T9 套裝";
	AL["Tier 10 Sets"] = "T10 套裝";
	AL["Furious Gladiator Sets"] = "狂烈鬥士套裝";
	AL["Relentless Gladiator Sets"] = "無情鬥士套裝";
	AL["Brew of the Month Club"] = "每月啤酒俱樂部";

	--Extra Text in Boss lists
	AL["Set: Embrace of the Viper"] = "套裝:毒蛇的擁抱";
	AL["Set: Defias Leather"] = "套裝:迪菲亞皮甲";
	AL["Set: The Gladiator"] = "套裝:角鬥士";
	AL["Set: Chain of the Scarlet Crusade"] = "套裝:血色十字軍鍊甲";
	AL["Set: The Postmaster"] = "套裝:郵差套裝";
	AL["Set: Necropile Raiment"] = "套裝:骨堆套裝";
	AL["Set: Cadaverous Garb"] = "套裝:蒼白套裝";
	AL["Set: Bloodmail Regalia"] = "套裝:血鏈套裝";
	AL["Set: Deathbone Guardian"] = "套裝:亡骨守護者套裝";
	AL["Set: Dal'Rend's Arms"] = "套裝:雷德雙刀";
	AL["Set: Spider's Kiss"] = "套裝:蜘蛛之吻";
	AL["AQ20 Class Sets"] = "AQ20 職業套裝";
	AL["AQ Enchants"] = "AQ 公式";
	AL["AQ40 Class Sets"] = "AQ40 職業套裝";
	AL["AQ Opening Quest Chain"] = "安其拉開門系列任務";
	AL["ZG Class Sets"] = "ZG 職業套裝";
	AL["ZG Enchants"] = "ZG 公式";
	AL["Class Books"] = "職業技能書";
	AL["Tribute Run"] = "貢品";
	AL["Dire Maul Books"] = "厄運書籍";
	AL["Random Boss Loot"] = "首領隨機掉落";
	AL["BT Patterns/Plans"] = "黑暗神廟卷軸";
	AL["Hyjal Summit Designs"] ="海加爾山設計圖";
	AL["SP Patterns/Plans"] = "特殊圖樣/卷軸";
	AL["Ulduar Formula/Patterns/Plans"] = "奧杜亞公式/圖樣/設計圖";
	AL["Trial of the Crusader Patterns/Plans"] = "十字軍試煉圖樣/設計圖";
	AL["Legendary Items for Kael'thas Fight"] = "凱爾薩斯·逐日者史詩物品";

	--Pets
	AL["Pets"] = "寵物";
	AL["Promotional"] = "促銷";
	AL["Pet Store"] = "寵物商店";
	AL["Merchant Sold"] = "商人販售";
	AL["Rare"] = "稀有";
	AL["Achievement"] = "成就";
	AL["Faction"] = "陣營";
	AL["Dungeon/Raid"] = "副本/團隊";

	--Mounts
	AL["Achievement Reward"] = "成就獎勵";
	AL["Alliance Flying Mounts"] = "聯盟飛行坐騎";
	AL["Alliance Mounts"] = "聯盟坐騎";
	AL["Horde Flying Mounts"] = "部落飛行坐騎";
	AL["Horde Mounts"] = "部落坐騎";
	AL["Card Game Mounts"] = "套卡獎勵坐騎";
	AL["Crafted Mounts"] = "精製坐騎";
	AL["Event Mounts"] = "事件獎勵坐騎";
	AL["Neutral Faction Mounts"] = "中立陣營坐騎";
	AL["PvP Mounts"] = "PvP 坐騎";
	AL["Alliance PvP Mounts"] = "聯盟 PvP 坐騎";
	AL["Horde PvP Mounts"] = "部落 PvP 坐騎";
	AL["Halaa PvP Mounts"] = "哈剌 PvP 坐騎";
	AL["Promotional Mounts"] = "特定商業促銷坐騎";
	AL["Rare Mounts"] = "稀有坐騎";

	--Darkmoon Faire
	AL["Darkmoon Faire Rewards"] = "暗月馬戲團獎勵";
	AL["Low Level Decks"] = "低階套排";
	AL["Original and BC Trinkets"] = "舊世界與 BC 飾品";
	AL["WotLK Trinkets"] = "巫妖王之怒飾品";

	--Card Game Decks and descriptions
	AL["Loot Card Items"] = "可換取的物品";
	AL["UDE Items"] = "兌換商品";

	-- First set
	AL["Heroes of Azeroth"] = "艾澤拉斯英雄";
	AL["Landro Longshot"] = "藍卓";
	AL["Thunderhead Hippogryph"] = "雷首角鷹獸";
	AL["Saltwater Snapjaw"] = "海水鉗嘴龜";

	-- Second set
	AL["Through The Dark Portal"] = "通過黑暗之門";
	AL["King Mukla"] = "穆克拉";
	AL["Rest and Relaxation"] = "休息和放鬆";
	AL["Fortune Telling"] = "算命";

	-- Third set
	AL["Fires of Outland"] = "外域之火";
	AL["Spectral Tiger"] = "幽靈虎";
	AL["Gone Fishin'"] = "釣魚椅";
	AL["Goblin Gumbo"] = "哥布林濃湯";

	-- Fourth set
	AL["March of the Legion"] = "軍團的行軍";
	AL["Kiting"] = "風箏";
	AL["Robotic Homing Chicken"] = "寵物機械小雞";
	AL["Paper Airplane"] = "紙飛機";

	-- Fifth set
	AL["Servants of the Betrayer"] = "背叛者的奴僕";
	AL["X-51 Nether-Rocket"] = "X51型虛空火箭";
	AL["Personal Weather Machine"] = "個人氣象儀";
	AL["Papa Hummel's Old-fashioned Pet Biscuit"] = "休莫爾老爹的老派寵物軟餅";

	-- Sixth set
	AL["Hunt for Illidan"] = "獵殺伊利丹";
	AL["The Footsteps of Illidan"] = "伊利丹的腳步";
	--AL["Disco Inferno!"] = "Disco Inferno!";
	AL["Ethereal Plunderer"] = "伊斯利掠奪者";

	-- Seventh set
	AL["Drums of War"] = "戰爭之鼓";
	--AL["The Red Bearon"] = true;
	--AL["Owned!"] = true;
	--AL["Slashdance"] = true;

	-- Eighth set
	AL["Blood of Gladiators"] = "鬥士之血";
	AL["Sandbox Tiger"] = "沙池虎";
	--AL["Center of Attention"] = true;
	AL["Foam Sword Rack"] = "泡沫之劍架";

	-- Ninth set
	AL["Fields of Honor"] = "榮耀之地";
	AL["Path of Cenarius"] = "通往塞納留斯之路";
	AL["Pinata"] = "糖果玩偶";
	AL["El Pollo Grande"] = "艾伯格蘭德";

	-- Tenth set
	--AL["Scourgewar"] = true;
	--AL["Tiny"] = true;
	AL["Tuskarr Kite"] = "巨牙海民風箏";
	--AL["Spectral Kitten"] = true;

	-- Eleventh set
	AL["Wrathgate"] = "憤怒";
	AL["Statue Generator"] = "雕像製造者";
	AL["Landro's Gift"] = "藍卓的禮物";
	AL["Blazing Hippogryph"] = "熾熱的角鷹獸";

	-- Twelvth set
	AL["Icecrown"] = "寒冰皇冠";
	AL["Wooly White Rhino"] = "白色蓬毛犀牛";
	AL["Ethereal Portal"] = "以太傳送門";
	AL["Paint Bomb"] = "漆彈";

	--Battleground Brackets
	AL["BG/Open PvP Rewards"] = "燃燒遠征開放 PvP 獎勵";
	AL["Misc. Rewards"] = "雜項獎勵";
	AL["Level 20-39 Rewards"] = "等級 20～39 獎勵";
	AL["Level 20-29 Rewards"] = "等級 20～29 獎勵";
	AL["Level 30-39 Rewards"] = "等級 30～39 獎勵";
	AL["Level 40-49 Rewards"] = "等級 40～49 獎勵";
	AL["Level 60 Rewards"] = "等級 60 獎勵";

	--Brood of Nozdormu Paths
	AL["Path of the Conqueror"] = "征服者之路";
	AL["Path of the Invoker"] = "祈求者之路";
	AL["Path of the Protector"] = "保護者之路";

	--Violet Eye Paths
	AL["Path of the Violet Protector"] = "紫羅蘭保衛者之路";
	AL["Path of the Violet Mage"] = "紫蘿蘭法師之路";
	AL["Path of the Violet Assassin"] = "紫羅蘭刺客之路";
	AL["Path of the Violet Restorer"] = "紫羅蘭治療師之路";
	
	-- Ashen Verdict Paths
	AL["Path of Courage"] = "勇氣之路";
	AL["Path of Destruction"] = "毀滅之路";
	AL["Path of Vengeance"] = "復仇之路";
	AL["Path of Wisdom"] = "智慧之路";

	--AQ Opening Event
	AL["Red Scepter Shard"] = "紅色權杖碎片";
	AL["Blue Scepter Shard"] = "藍色權杖碎片";
	AL["Green Scepter Shard"] = "綠色權杖碎片";
	AL["Scepter of the Shifting Sands"] = "流沙權杖";

	--World PvP
	AL["Hellfire Fortifications"] = "地獄火防禦堡壘";
	AL["Twin Spire Ruins"] = "雙塔廢墟";
	AL["Spirit Towers"] = "精神哨塔";
	AL["Halaa"] = "哈剌";
	AL["Venture Bay"] = "風險海灣";

	--Karazhan Opera Event Headings
	AL["Shared Drops"] = "隨機掉落";
	AL["Romulo & Julianne"] = "羅慕歐與茱麗葉";
	AL["Wizard of Oz"] = "綠野仙蹤";
	AL["Red Riding Hood"] = "小紅帽";

	--Karazhan Animal Boss Types
	AL["Spider"] = "蜘蛛";
	AL["Darkhound"] = "黑暗犬";
	AL["Bat"] = "蝙蝠";

	--ZG Tokens
	AL["Primal Hakkari Kossack"] = "原始哈卡萊套索";
	AL["Primal Hakkari Shawl"] = "原始哈卡萊披肩";
	AL["Primal Hakkari Bindings"] = "原始哈卡萊護腕";
	AL["Primal Hakkari Sash"] = "原始哈卡萊腰帶";
	AL["Primal Hakkari Stanchion"] = "原始哈卡萊直柱";
	AL["Primal Hakkari Aegis"] = "原始哈卡萊之盾";
	AL["Primal Hakkari Girdle"] = "原始哈卡萊束帶";
	AL["Primal Hakkari Armsplint"] = "原始哈卡萊護臂";
	AL["Primal Hakkari Tabard"] = "原始哈卡萊徽章";

	--AQ20 Tokens
	AL["Qiraji Ornate Hilt"] = "其拉華麗刀柄";
	AL["Qiraji Martial Drape"] = "其拉軍用披風";
	AL["Qiraji Magisterial Ring"] = "其拉將領戒指";
	AL["Qiraji Ceremonial Ring"] = "其拉典禮戒指";
	AL["Qiraji Regal Drape"] = "其拉帝王披風";
	AL["Qiraji Spiked Hilt"] = "其拉尖刺刀柄";

	--AQ40 Tokens
	AL["Qiraji Bindings of Dominance"] = "其拉統御腕輪";
	AL["Qiraji Bindings of Command"] = "其拉命令腕輪";
	AL["Vek'nilash's Circlet"] = "維克尼拉斯的頭飾";
	AL["Vek'lor's Diadem"] = "維克洛爾的王冠";
	AL["Ouro's Intact Hide"] = "奧羅的外皮";
	AL["Skin of the Great Sandworm"] = "巨型沙蟲的皮";
	AL["Husk of the Old God"] = "上古之神的外殼";
	AL["Carapace of the Old God"] = "上古之神的甲殼";

	-- Blacksmithing Mail Crafted Sets
	AL["Bloodsoul Embrace"] = "血魂的擁抱";
	AL["Fel Iron Chain"] = "魔鐵鍊甲";

	-- Blacksmithing Plate Crafted Sets
	AL["Imperial Plate"] = "帝王鎧甲";
	AL["The Darksoul"] = "黑暗之魂";
	AL["Fel Iron Plate"] = "魔鐵鎧甲";
	AL["Adamantite Battlegear"] = "堅鋼戰甲";
	AL["Flame Guard"] = "烈焰套裝";
	AL["Enchanted Adamantite Armor"] = "附魔堅鋼護甲";
	AL["Khorium Ward"] = "克銀結界";
	AL["Faith in Felsteel"] = "信仰魔鋼";
	AL["Burning Rage"] = "燃燒狂怒";
	AL["Ornate Saronite Battlegear"] = "華麗薩鋼戰裝";
	AL["Savage Saronite Battlegear"] = "蠻荒薩鋼戰裝";

	-- Leatherworking Crafted Leather Sets
	AL["Volcanic Armor"] = "火山護甲";
	AL["Ironfeather Armor"] = "鐵羽護甲";
	AL["Stormshroud Armor"] = "雷暴護甲";
	AL["Devilsaur Armor"] = "魔暴龍護甲";
	AL["Blood Tiger Harness"] = "血虎套索";
	AL["Primal Batskin"] = "原始蝙蝠皮套裝";
	AL["Wild Draenish Armor"] = "狂野德萊尼護甲";
	AL["Thick Draenic Armor"] = "厚德萊尼護甲";
	AL["Fel Skin"] = "惡魔皮膚";
	AL["Strength of the Clefthoof"] = "裂蹄力量";
	AL["Primal Intent"] = "原始之意套裝";
	AL["Windhawk Armor"] = "風之隼護甲";
	AL["Borean Embrace"] = "北風之擁";
	AL["Iceborne Embrace"] = "冰降之擁";
	AL["Eviscerator's Battlegear"] = "剔骨者戰裝";
	AL["Overcaster Battlegear"] = "超法者戰裝";

	-- Leatherworking Crafted Mail Sets
	AL["Green Dragon Mail"] = "綠龍鎖甲";
	AL["Blue Dragon Mail"] = "藍龍鎖甲";
	AL["Black Dragon Mail"] = "黑龍鎖甲";
	AL["Scaled Draenic Armor"] = "德萊尼鱗護甲";
	AL["Felscale Armor"] = "魔鱗護甲";
	AL["Felstalker Armor"] = "惡魔捕獵者套裝";
	AL["Fury of the Nether"] = "虛空之怒套裝";
	AL["Netherscale Armor"] = "虛空鱗護甲";
	AL["Netherstrike Armor"] = "地擊套裝";
	AL["Frostscale Binding"] = "霜鱗束縛";
	AL["Nerubian Hive"] = "奈幽蟲巢";
	AL["Stormhide Battlegear"] = "風暴皮革戰裝";
	AL["Swiftarrow Battlefear"] = "迅箭戰裝";

	-- Tailoring Crafted Sets
	AL["Bloodvine Garb"] = "血藤之服";
	AL["Netherweave Vestments"] = "幽紋套裝";
	AL["Imbued Netherweave"] = "魔染幽紋套裝";
	AL["Arcanoweave Vestments"] = "奧紋套裝";
	AL["The Unyielding"] = "不屈套裝";
	AL["Whitemend Wisdom"] = "白癒智慧";
	AL["Spellstrike Infusion"] = "法擊套裝";
	AL["Battlecast Garb"] = "戰放服裝";
	AL["Soulcloth Embrace"] = "靈魂布的擁抱";
	AL["Primal Mooncloth"] = "原始月布";
	AL["Shadow's Embrace"] = "暗影的擁抱";
	AL["Wrath of Spellfire"] = "魔焰之怒";
	AL["Frostwoven Power"] = "霜織之力";
	AL["Duskweaver"] = "暮織者";
	AL["Frostsavage Battlegear"] = "霜蠻戰裝";

	--Classic WoW Sets
	AL["Defias Leather"] = "迪菲亞皮甲";
	AL["Embrace of the Viper"] = "毒蛇的擁抱";
	AL["Chain of the Scarlet Crusade"] = "血色十字軍鍊甲";
	AL["The Gladiator"] = "角鬥士套裝";
	AL["Ironweave Battlesuit"] = "鐵織戰裝";
	AL["Necropile Raiment"] = "骨堆套裝";
	AL["Cadaverous Garb"] = "蒼白裝束";
	AL["Bloodmail Regalia"] = "血鏈戰衣";
	AL["Deathbone Guardian"] = "亡骨守護者";
	AL["The Postmaster"] = "郵差套裝";
	AL["Shard of the Gods"] = "天神裂片";
	AL["Zul'Gurub Rings"] = "祖爾格拉布套戒";
	AL["Major Mojo Infusion"] = "極效魔精套裝";
	AL["Overlord's Resolution"] = "霸主的決心";
	AL["Prayer of the Primal"] = "遠古祈禱文";
	AL["Zanzil's Concentration"] = "贊吉爾的專注";
	AL["Spirit of Eskhandar"] = "艾斯卡達爾之靈";
	AL["The Twin Blades of Hakkari"] = "哈卡萊雙刃";
	AL["Primal Blessing"] = "原始祝福";
	AL["Dal'Rend's Arms"] = "雷德雙刀";
	AL["Spider's Kiss"] = "蜘蛛之吻";

	--The Burning Crusade Sets
	AL["Latro's Flurry"] = "拉托的亂舞";
	AL["The Twin Stars"] = "雙子星套裝";
	AL["The Fists of Fury"] = "狂暴支配套裝";
	AL["The Twin Blades of Azzinoth"] = "埃辛諾斯的雙刃";

	--Wrath of the Lich King Sets
	AL["Raine's Revenge"] = "萊尼的復仇";
	AL["Purified Shard of the Gods"] = "純淨諸神裂片";
	AL["Shiny Shard of the Gods"] = "閃亮諸神裂片";

	--Recipe origin strings
	AL["Trainer"] = "訓練師";
	AL["Discovery"] = "探索";
	AL["World Drop"] = "世界掉落";
	AL["Drop"] = "掉落";
	AL["Vendor"] = "商人販售";
	AL["Quest"] = "任務";
	AL["Crafted"] = "製作";

	--Scourge Invasion
	AL["Scourge Invasion"] = "天譴軍團";
	AL["Scourge Invasion Sets"] = "天譴軍團套裝";
	AL["Blessed Regalia of Undead Cleansing"] = "淨亡祝福戰衣";
	AL["Undead Slayer's Blessed Armor"] = "弒亡祝福護甲";
	AL["Blessed Garb of the Undead Slayer"] = "弒亡祝福裝束";
	AL["Blessed Battlegear of Undead Slaying"] = "弒亡祝福戰裝";
	AL["Prince Tenris Mirkblood"] = "坦瑞斯·暗血王子";

	--ZG Sets
	AL["Haruspex's Garb"] = "占卜師裝束";
	AL["Predator's Armor"] = "捕獵者套裝";
	AL["Illusionist's Attire"] = "幻術師套裝";
	AL["Freethinker's Armor"] = "思考者護甲";
	AL["Confessor's Raiment"] = "懺悔者衣飾";
	AL["Madcap's Outfit"] = "狂妄者套裝";
	AL["Augur's Regalia"] = "占兆者戰衣";
	AL["Demoniac's Threads"] = "惡魔師套裝";
	AL["Vindicator's Battlegear"] = "辯護者戰裝";

	--AQ20 Sets
	AL["Symbols of Unending Life"] = "不滅生命徽記";
	AL["Trappings of the Unseen Path"] = "隱秘通途套裝";
	AL["Trappings of Vaulted Secrets"] = "魔法的秘密";
	AL["Battlegear of Eternal Justice"] = "永恆公正戰裝";
	AL["Finery of Infinite Wisdom"] = "無盡的智慧";
	AL["Emblems of Veiled Shadows"] = "朦朧之影";
	AL["Gift of the Gathering Storm"] = "聚集的風暴";
	AL["Implements of Unspoken Names"] = "禁斷的邪語";
	AL["Battlegear of Unyielding Strength"] = "不屈力量戰裝";

	--AQ40 Sets
	AL["Genesis Raiment"] = "起源套裝";
	AL["Striker's Garb"] = "打擊者裝束";
	AL["Enigma Vestments"] = "神秘套裝";
	AL["Avenger's Battlegear"] = "復仇者戰甲";
	AL["Garments of the Oracle"] = "神諭者套裝";
	AL["Deathdealer's Embrace"] = "亡賈的擁抱";
	AL["Stormcaller's Garb"] = "風暴召喚者裝束";
	AL["Doomcaller's Attire"] = "厄運召喚者";
	AL["Conqueror's Battlegear"] = "征服者戰裝";

	--Dungeon 1 Sets
	AL["Wildheart Raiment"] = "野性之心套裝";
	AL["Beaststalker Armor"] = "獸巡者護甲";
	AL["Magister's Regalia"] = "博學者戰衣";
	AL["Lightforge Armor"] = "光鑄護甲";
	AL["Vestments of the Devout"] = "虔誠套裝";
	AL["Shadowcraft Armor"] = "迅影護甲";
	AL["The Elements"] = "元素套裝";
	AL["Dreadmist Raiment"] = "鬼霧套裝";
	AL["Battlegear of Valor"] = "勇氣戰甲";

	--Dungeon 2 Sets
	AL["Feralheart Raiment"] = "野獸之心套裝";
	AL["Beastmaster Armor"] = "獸王護甲";
	AL["Sorcerer's Regalia"] = "巫士戰衣";
	AL["Soulforge Armor"] = "魂鑄護甲";
	AL["Vestments of the Virtuous"] = "善潔套裝";
	AL["Darkmantle Armor"] = "闇影護甲";
	AL["The Five Thunders"] = "五雷套裝";
	AL["Deathmist Raiment"] = "亡霧套裝";
	AL["Battlegear of Heroism"] = "英氣戰甲";

	--Dungeon 3 Sets
	AL["Hallowed Raiment"] = "神聖儀祭套裝";
	AL["Incanter's Regalia"] = "魔法使戰衣";
	AL["Mana-Etched Regalia"] = "法力蝕刻戰衣";
	AL["Oblivion Raiment"] = "失落戰衣套裝";
	AL["Assassination Armor"] = "暗殺套裝";
	AL["Moonglade Raiment"] = "月光林地套裝";
	AL["Wastewalker Armor"] = "荒行套裝";
	AL["Beast Lord Armor"] = "野獸之王護甲";
	AL["Desolation Battlegear"] = "哀傷之鏈戰裝";
	AL["Tidefury Raiment"] = "惡潮套裝";
	AL["Bold Armor"] = "勇猛護甲套裝";
	AL["Doomplate Battlegear"] = "末日戰裝";
	AL["Righteous Armor"] = "公正套裝";

	--Tier 1 Sets
	AL["Cenarion Raiment"] = "塞納里奧套裝";
	AL["Giantstalker Armor"] = "巨人巡者護甲";
	AL["Arcanist Regalia"] = "秘法師戰衣";
	AL["Lawbringer Armor"] = "秩序之源護甲";
	AL["Vestments of Prophecy"] = "預言套裝";
	AL["Nightslayer Armor"] = "黑夜殺手護甲";
	AL["The Earthfury"] = "大地之怒套裝";
	AL["Felheart Raiment"] = "惡魔之心套裝";
	AL["Battlegear of Might"] = "力量戰裝";

	--Tier 2 Sets
	AL["Stormrage Raiment"] = "怒風套裝";
	AL["Dragonstalker Armor"] = "龍巡者護甲";
	AL["Netherwind Regalia"] = "靈風戰衣";
	AL["Judgement Armor"] = "審判護甲";
	AL["Vestments of Transcendence"] = "卓越套裝";
	AL["Bloodfang Armor"] = "血牙護甲";
	AL["The Ten Storms"] = "無盡風暴套裝";
	AL["Nemesis Raiment"] = "復仇套裝";
	AL["Battlegear of Wrath"] = "憤怒戰裝";

	--Tier 3 Sets
	AL["Dreamwalker Raiment"] = "夢行者套裝";
	AL["Cryptstalker Armor"] = "地穴行者護甲";
	AL["Frostfire Regalia"] = "霜火套裝";
	AL["Redemption Armor"] = "救贖護甲";
	AL["Vestments of Faith"] = "信仰套裝";
	AL["Bonescythe Armor"] = "骨鐮套裝";
	AL["The Earthshatterer"] = "碎地者護甲";
	AL["Plagueheart Raiment"] = "瘟疫之心套裝";
	AL["Dreadnaught's Battlegear"] = "無畏戰裝";

	--Tier 4 Sets
	AL["Malorne Harness"] = "瑪洛尼戰馭套裝";
	AL["Malorne Raiment"] = "瑪洛尼儀祭套裝";
	AL["Malorne Regalia"] = "瑪洛尼戰衣";
	AL["Demon Stalker Armor"] = "惡魔巡者套裝";
	AL["Aldor Regalia"] = "奧多爾戰衣套裝";
	AL["Justicar Armor"] = "審判者防禦套裝";
	AL["Justicar Battlegear"] = "審判者戰甲套裝";
	AL["Justicar Raiment"] = "審判者神聖套裝";
	AL["Incarnate Raiment"] = "聖軀儀祭套裝";
	AL["Incarnate Regalia"] = "聖軀戰衣套裝";
	AL["Netherblade Set"] = "虛空之刃套裝";
	AL["Cyclone Harness"] = "颶風戰馭套裝";
	AL["Cyclone Raiment"] = "颶風儀祭套裝";
	AL["Cyclone Regalia"] = "颶風戰衣";
	AL["Voidheart Raiment"] = "虛無之心套裝";
	AL["Warbringer Armor"] = "戰爭使者防禦套裝";
	AL["Warbringer Battlegear"] = "戰爭使者戰裝";

	--Tier 5 Sets
	AL["Nordrassil Harness"] = "諾達希爾戰馭套裝";
	AL["Nordrassil Raiment"] = "諾達希爾儀祭套裝";
	AL["Nordrassil Regalia"] = "諾達希爾戰衣";
	AL["Rift Stalker Armor"] = "裂隙巡者護甲套裝";
	AL["Tirisfal Regalia"] = "提里斯法戰衣套裝";
	AL["Crystalforge Armor"] = "晶鑄防禦套裝";
	AL["Crystalforge Battlegear"] = "晶鑄戰甲套裝";
	AL["Crystalforge Raiment"] = "晶鑄神聖套裝";
	AL["Avatar Raiment"] = "聖者儀祭套裝";
	AL["Avatar Regalia"] = "聖者戰衣套裝";
	AL["Deathmantle Set"] = "死神傳承套裝";
	AL["Cataclysm Harness"] = "裂地戰馭套裝";
	AL["Cataclysm Raiment"] = "裂地儀祭套裝";
	AL["Cataclysm Regalia"] = "裂地戰衣";
	AL["Corruptor Raiment"] = "墮落者戰衣套裝";
	AL["Destroyer Armor"] = "毀滅者防禦套裝";
	AL["Destroyer Battlegear"] = "毀滅者戰裝";

	--Tier 6 Sets
	AL["Thunderheart Harness"] = "雷霆之心戰馭套裝";
	AL["Thunderheart Raiment"] = "雷霆之心儀祭套裝";
	AL["Thunderheart Regalia"] = "雷霆之心戰衣";
	AL["Gronnstalker's Armor"] = "古羅巡者套裝";
	AL["Tempest Regalia"] = "風暴戰衣";
	AL["Lightbringer Armor"] = "光明使者防禦套裝";
	AL["Lightbringer Battlegear"] = "光明使者戰甲套裝";
	AL["Lightbringer Raiment"] = "光明使者神聖套裝";
	AL["Vestments of Absolution"] = "赦免外衣套裝";
	AL["Absolution Regalia"] = "赦免戰衣套裝";
	AL["Slayer's Armor"] = "殺戮者護甲套裝";
	AL["Skyshatter Harness"] = "碎天者戰馭套裝";
	AL["Skyshatter Raiment"] = "碎天者儀祭套裝";
	AL["Skyshatter Regalia"] = "碎天者戰衣";
	AL["Malefic Raiment"] = "邪惡戰衣套裝";
	AL["Onslaught Armor"] = "猛擊防禦套裝";
	AL["Onslaught Battlegear"] = "猛擊戰裝";

	--Tier 7 Sets
	AL["Scourgeborne Battlegear"] = "天譴宿命戰裝";
	AL["Scourgeborne Plate"] = "天譴宿命鎧甲";
	AL["Dreamwalker Garb"] = "夢行者裝束";
	AL["Dreamwalker Battlegear"] = "夢行者戰裝";
	AL["Dreamwalker Regalia"] = "夢行者戰衣";
	AL["Cryptstalker Battlegear"] = "地穴巡者戰甲";
	AL["Frostfire Garb"] = "霜火裝束";
	AL["Redemption Regalia"] = "救贖戰衣";
	AL["Redemption Battlegear"] = "救贖戰裝";
	AL["Redemption Plate"] = "救贖鎧甲";
	AL["Regalia of Faith"] = "信仰戰衣";
	AL["Garb of Faith"] = "信仰裝束";
	AL["Bonescythe Battlegear"] = "骨鐮戰裝";
	AL["Earthshatter Garb"] = "碎地者裝束";
	AL["Earthshatter Battlegear"] = "碎地者戰裝";
	AL["Earthshatter Regalia"] = "碎地者戰衣";
	AL["Plagueheart Garb"] = "瘟疫之心裝束";
	AL["Dreadnaught Battlegear"] = "無畏戰裝";
	AL["Dreadnaught Plate"] = "無畏鎧甲";

	--Tier 8 Sets
	AL["Darkruned Battlegear"] = "黑暗符文戰裝";
	AL["Darkruned Plate"] = "黑暗符文鎧甲";
	AL["Nightsong Garb"] = "夜歌裝束";
	AL["Nightsong Battlegear"] = "夜歌戰裝";
	AL["Nightsong Regalia"] = "夜歌戰衣";
	AL["Scourgestalker Battlegear"] = "天譴巡者戰裝";
	AL["Kirin Tor Garb"] = "祈倫托裝束";
	AL["Aegis Regalia"] = "神禦戰衣";
	AL["Aegis Battlegear"] = "神禦戰裝";
	AL["Aegis Plate"] = "神禦鎧甲";
	AL["Sanctification Regalia"] = "崇聖戰衣";
	AL["Sanctification Garb"] = "崇聖裝束";
	AL["Terrorblade Battlegear"] = "懼刃戰裝";
	AL["Worldbreaker Garb"] = "碎界者裝束";
	AL["Worldbreaker Battlegear"] = "碎界者戰裝";
	AL["Worldbreaker Regalia"] = "碎界者戰衣";
	AL["Deathbringer Garb"] = "死亡使者裝束";
	AL["Siegebreaker Battlegear"] = "破陣戰裝";
	AL["Siegebreaker Plate"] = "破陣鎧甲";

	-- Tier 9 Sets
	AL["Malfurion's Garb"] = "瑪法里恩的裝束";
	AL["Malfurion's Battlegear"] = "瑪法里恩的戰裝";
	AL["Malfurion's Regalia"] = "瑪法里恩的戰衣";
	AL["Runetotem's Garb"] = "符文圖騰的裝束";
	AL["Runetotem's Battlegear"] = "符文圖騰的戰裝";
	AL["Runetotem's Regalia"] = "符文圖騰的戰衣";
	AL["Windrunner's Battlegear"] = "風行者的戰裝";
	AL["Windrunner's Pursuit"] = "風行者的獵裝";
	AL["Khadgar's Regalia"] = "卡德加的戰衣";
	AL["Sunstrider's Regalia"] = "逐日者的戰衣";
	AL["Turalyon's Garb"] = "圖拉揚的裝束";
	AL["Turalyon's Battlegear"] = "圖拉揚的戰裝";
	AL["Turalyon's Plate"] = "圖拉揚的鎧甲";
	AL["Liadrin's Garb"] = "莉雅德倫的裝束";
	AL["Liadrin's Battlegear"] = "莉雅德倫的戰裝";
	AL["Liadrin's Plate"] = "莉雅德倫的鎧甲";
	AL["Velen's Regalia"] = "費倫的戰衣";
	AL["Velen's Raiment"] = "費倫的衣飾";
	AL["Zabra's Regalia"] = "薩布拉的戰衣";
	AL["Zabra's Raiment"] = "薩布拉的衣飾";
	AL["VanCleef's Battlegear"] = "范克里夫的戰裝";
	AL["Garona's Battlegear"] = "迦羅娜的戰裝";
	AL["Nobundo's Garb"] = "諾柏多的裝束";
	AL["Nobundo's Battlegear"] = "諾柏多的戰裝";
	AL["Nobundo's Regalia"] = "諾柏多的戰衣";
	AL["Thrall's Garb"] = "索爾的裝束";
	AL["Thrall's Battlegear"] = "索爾的戰裝";
	AL["Thrall's Regalia"] = "索爾的戰衣";
	AL["Kel'Thuzad's Regalia"] = "科爾蘇加德的戰衣";
	AL["Gul'dan's Regalia"] = "古爾丹的戰衣";
	AL["Wrynn's Battlegear"] = "烏瑞恩的戰裝";
	AL["Wrynn's Plate"] = "烏瑞恩的鎧甲";
	AL["Hellscream's Battlegear"] = "地獄吼的戰裝";
	AL["Hellscream's Plate"] = "地獄吼的鎧甲";
	AL["Thassarian's Battlegear"] = "薩沙理安的戰裝";
	AL["Koltira's Battlegear"] = "寇爾提拉的戰裝";
	AL["Thassarian's Plate"] = "薩沙理安的鎧甲";
	AL["Koltira's Plate"] = "寇爾提拉的鎧甲";

	-- Tier 10 Sets
	AL["Lasherweave's Garb"] = "棘織裝束";
	AL["Lasherweave's Battlegear"] = "棘織戰裝";
	AL["Lasherweave's Regalia"] = "棘織戰衣";
	AL["Ahn'Kahar Blood Hunter's Battlegear"] = "安卡哈血狩戰裝";
	AL["Bloodmage's Regalia"] = "血法戰衣";
	AL["Lightsworn Garb"] = "光誓裝束";
	AL["Lightsworn Plate"] = "光誓鎧甲";
	AL["Lightsworn Battlegear"] = "光誓戰裝";
	AL["Crimson Acolyte's Regalia"] = "赤紅侍僧戰衣";
	AL["Crimson Acolyte's Raiment"] = "赤紅侍僧衣飾";
	AL["Shadowblade's Battlegear"] = "影刃戰裝";
	AL["Frost Witch's Garb"] = "冰霜女巫裝束";
	AL["Frost Witch's Battlegear"] = "冰霜女巫戰裝";
	AL["Frost Witch's Regalia"] = "冰霜女巫戰衣";
	AL["Dark Coven's Garb"] = "黑暗巫會裝束";
	AL["Ymirjar Lord's Battlegear"] = "依米亞領主戰裝";
	AL["Ymirjar Lord's Plate"] = "依米亞領主鎧甲";
	AL["Scourgelord's Battlegear"] = "天譴領主戰裝";
	AL["Scourgelord's Plate"] = "天譴領主鎧甲";

	--Arathi Basin Sets - Alliance
	AL["The Highlander's Intent"] = "高地人的專注";
	AL["The Highlander's Purpose"] = "高地人的毅力";
	AL["The Highlander's Will"] = "高地人的意志";
	AL["The Highlander's Determination"] = "高地人的果斷";
	AL["The Highlander's Fortitude"] = "高地人的堅韌";
	AL["The Highlander's Resolution"] = "高地人的決心";
	AL["The Highlander's Resolve"] = "高地人的執著";

	--Arathi Basin Sets - Horde
	AL["The Defiler's Intent"] = "污染者的專注";
	AL["The Defiler's Purpose"] = "污染者的毅力";
	AL["The Defiler's Will"] = "污染者的意志";
	AL["The Defiler's Determination"] = "污染者的果斷";
	AL["The Defiler's Fortitude"] = "污染者的堅韌";
	AL["The Defiler's Resolution"] = "污染者的決心";

	--PvP Level 60 Rare Sets - Alliance
	AL["Lieutenant Commander's Refuge"] = "少校的庇護";
	AL["Lieutenant Commander's Pursuance"] = "少校的追求";
	AL["Lieutenant Commander's Arcanum"] = "少校的奧秘";
	AL["Lieutenant Commander's Redoubt"] = "少校的防禦";
	AL["Lieutenant Commander's Investiture"] = "少校的服裝";
	AL["Lieutenant Commander's Guard"] = "少校的防護";
	AL["Lieutenant Commander's Stormcaller"] = "少校的震地者";
	AL["Lieutenant Commander's Dreadgear"] = "少校的裝備";
	AL["Lieutenant Commander's Battlearmor"] = "少校的護甲";

	--PvP Level 60 Rare Sets - Horde
	AL["Champion's Refuge"] = "勇士的庇護";
	AL["Champion's Pursuance"] = "勇士的追求";
	AL["Champion's Arcanum"] = "勇士的奧秘";
	AL["Champion's Redoubt"] = "勇士的壁壘";
	AL["Champion's Investiture"] = "勇士的服裝";
	AL["Champion's Guard"] = "勇士的套裝";
	AL["Champion's Stormcaller"] = "勇士的召喚";
	AL["Champion's Dreadgear"] = "勇士的裝備";
	AL["Champion's Battlearmor"] = "勇士的護甲";

	--PvP Level 60 Epic Sets - Alliance
	AL["Field Marshal's Sanctuary"] = "戰場元帥的聖裝";
	AL["Field Marshal's Pursuit"] = "戰場元帥的獵裝";
	AL["Field Marshal's Regalia"] = "戰場元帥的戰衣";
	AL["Field Marshal's Aegis"] = "戰場元帥的聖禦";
	AL["Field Marshal's Raiment"] = "戰場元帥的神服";
	AL["Field Marshal's Vestments"] = "戰場元帥的制服";
	AL["Field Marshal's Earthshaker"] = "戰場元帥的震地者";
	AL["Field Marshal's Threads"] = "戰場元帥的魔裝";
	AL["Field Marshal's Battlegear"] = "戰場元帥的戰裝";

	--PvP Level 60 Epic Sets - Horde
	AL["Warlord's Sanctuary"] = "督軍的聖裝";
	AL["Warlord's Pursuit"] = "督軍的獵裝";
	AL["Warlord's Regalia"] = "督軍的戰衣";
	AL["Warlord's Aegis"] = "督軍的聖禦";
	AL["Warlord's Raiment"] = "督軍的神服";
	AL["Warlord's Vestments"] = "督軍的制服";
	AL["Warlord's Earthshaker"] = "督軍的震撼";
	AL["Warlord's Threads"] = "督軍的魔裝";
	AL["Warlord's Battlegear"] = "督軍的戰甲";

	--Outland Faction Reputation PvP Sets
	AL["Dragonhide Battlegear"] = "龍皮戰裝";
	AL["Wyrmhide Battlegear"] = "龍革戰裝";
	AL["Kodohide Battlegear"] = "科多獸皮戰裝";
	AL["Stalker's Chain Battlegear"] = "潛獵者鍊甲戰裝";
	AL["Evoker's Silk Battlegear"] = "塑能師絲質戰裝";
	AL["Crusader's Scaled Battledgear"] = "十字軍綴鱗戰裝";
	AL["Crusader's Ornamented Battledgear"] = "十字軍裝飾戰裝";
	AL["Satin Battlegear"] = "緞質戰裝";
	AL["Mooncloth Battlegear"] = "月布戰裝";
	AL["Opportunist's Battlegear"] = "投機者戰裝";
	AL["Seer's Linked Battlegear"] = "先知鎖鍊戰裝";
	AL["Seer's Mail Battlegear"] = "先知鎖甲戰裝";
	AL["Seer's Ringmail Battlegear"] = "先知環甲戰裝";
	AL["Dreadweave Battlegear"] = "懼紋戰裝";
	AL["Savage's Plate Battlegear"] = "野蠻鎧甲戰裝";

	--Arena Epic Sets
	AL["Gladiator's Sanctuary"] = "鬥士的聖裝";		   -- arenas1_1
	AL["Gladiator's Wildhide"] = "鬥士的狂野革甲套裝";	-- arenas1_2
	AL["Gladiator's Refuge"] = "鬥士的庇護套裝";		  -- arenas1_3
	AL["Gladiator's Pursuit"] = "鬥士的獵裝";			 -- arenas2
	AL["Gladiator's Regalia"] = "鬥士的戰衣";			 -- arenas3
	AL["Gladiator's Aegis"] = "鬥士的聖禦";			   -- arenas4_1
	AL["Gladiator's Vindication"] = "鬥士的辯護套裝";	 -- arenas4_2
	AL["Gladiator's Redemption"] = "鬥士的救贖套裝";	  -- arenas4_3
	AL["Gladiator's Raiment"] = "鬥士的儀祭服套裝";	   -- arenas5_1
	AL["Gladiator's Investiture"] = "鬥士的傳承套裝";	 -- arenas5_2
	AL["Gladiator's Vestments"] = "鬥士的戰鬥皮甲";	   -- arenas6
	AL["Gladiator's Earthshaker"] = "鬥士的震地者套裝";   -- arenas7_1
	AL["Gladiator's Thunderfist"] = "鬥士的雷霆之拳套裝"; -- arenas7_2
	AL["Gladiator's Wartide"] = "鬥士的戰鬥之潮套裝";	 -- arenas7_3
	AL["Gladiator's Dreadgear"] = "鬥士的戰慄套裝";	   -- arenas8_1
	AL["Gladiator's Felshroud"] = "鬥士的魔化罩衣套裝";   -- arenas8_2
	AL["Gladiator's Battlegear"] = "鬥士的戰裝";		  -- arenas9
	AL["Gladiator's Desecration"] = "鬥士的褻瀆套裝";	 -- arenas10

	-- Level 80 PvP Weapons
	AL["Savage Gladiator\'s Weapons"] = "蠻荒鬥士武器";
	AL["Deadly Gladiator\'s Weapons"] = "致命鬥士武器";
	AL["Furious Gladiator\'s Weapons"] = "狂烈鬥士武器";
	AL["Relentless Gladiator\'s Weapons"] = "無情鬥士武器";
	AL["Wrathful Gladiator\'s Weapons"] = "憤怒鬥士武器";

	-- Months
	AL["January"] = "一月";
	AL["February"] = "二月";
	AL["March"] = "三月";
	AL["April"] = "四月";
	AL["May"] = "五月";
	AL["June"] = "六月";
	AL["July"] = "七月";
	AL["August"] = "八月";
	AL["September"] = "九月";
	AL["October"] = "十月";
	AL["November"] = "十一月";
	AL["December"] = "十二月";

	-- Specs
	AL["Balance"] = "平衡";
	AL["Feral"] = "野性";
	AL["Restoration"] = "恢復";
	AL["Holy"] = "神聖";
	AL["Protection"] = "防護";
	AL["Retribution"] = "懲戒";
	AL["Shadow"] = "暗影";
	AL["Elemental"] = "元素";
	AL["Enhancement"] = "增強";
	AL["Fury"] = "狂怒";
	AL["Demonology"] = "惡魔";
	AL["Destruction"] = "毀滅";
	AL["Tanking"] = "防禦型";
	AL["DPS"] = "傷害型";

	--Naxx Zones
	AL["Construct Quarter"] = "傀儡區";
	AL["Arachnid Quarter"] = "蜘蛛區";
	AL["Military Quarter"] = "軍事區";
	AL["Plague Quarter"] = "瘟疫區";
	AL["Frostwyrm Lair"] = "冰霜巨龍巢穴";

	--NPCs missing from BabbleBoss
	AL["Trash Mobs"] = "小怪";
	AL["Dungeon Set 2 Summonable"] = "T0.5 召喚王";
	AL["Highlord Kruul"] = "卡魯歐領主";
	AL["Theldren"] = "瑟爾倫";
	AL["Sothos and Jarien"] = "索索斯及賈林";
	AL["Druid of the Fang"] = "尖牙德魯伊";
	AL["Defias Strip Miner"] = "迪菲亞赤膊礦工";
	AL["Defias Overseer/Taskmaster"] = "迪菲亞監工/工頭";
	AL["Scarlet Defender/Myrmidon"] = "血色防禦者/血色僕從";
	AL["Scarlet Champion"] = "血色勇士";
	AL["Scarlet Centurion"] = "血色百夫長";
	AL["Scarlet Trainee"] = "血色預備兵";
	AL["Herod/Mograine"] = "赫洛德/莫格萊尼";
	AL["Scarlet Protector/Guardsman"] = "血色保衛者/血色衛兵";
	AL["Shadowforge Flame Keeper"] = "暗爐持火者";
	AL["Olaf"] = "奧拉夫";
	AL["Eric 'The Swift'"] = "埃瑞克";
	AL["Shadow of Doom"] = "末日陰影";
	AL["Bone Witch"] = "骸骨巫師";
	AL["Lumbering Horror"] = "笨拙的憎惡";
	AL["Avatar of the Martyred"] = "馬丁瑞德的化身";
	AL["Yor"] = "約兒";
	AL["Nexus Stalker"] = "奈薩斯捕獵者";
	AL["Auchenai Monk"] = "奧奇奈僧侶";
	AL["Cabal Fanatic"] = "卡巴狂熱者";
	AL["Unchained Doombringer"] = "無束縛的摧毀者";
	AL["Crimson Sorcerer"] = "紅衣法術師";
	AL["Thuzadin Shadowcaster"] = "圖薩丁暗影施法者";
	AL["Crimson Inquisitor"] = "紅衣審查者";
	AL["Crimson Battle Mage"] = "紅衣戰鬥法師";
	AL["Ghoul Ravener"] = "食屍搶奪者";
	AL["Spectral Citizen"] = "鬼魂市民";
	AL["Spectral Researcher"] = "鬼靈研究員";
	AL["Scholomance Adept"] = "通靈學院專家";
	AL["Scholomance Dark Summoner"] = "通靈學院黑暗召喚師";
	AL["Blackhand Elite"] = "黑手精英";
	AL["Blackhand Assassin"] = "黑手刺客";
	AL["Firebrand Pyromancer"] = "火印炎術師";
	AL["Firebrand Invoker"] = "火印塑能師";
	AL["Firebrand Grunt"] = "火印步兵";
	AL["Firebrand Legionnaire"] = "火印軍團戰士";
	AL["Spirestone Warlord"] = "尖石軍閥";
	AL["Spirestone Mystic"] = "尖石秘法師";
	AL["Anvilrage Captain"] = "鐵怒上尉";
	AL["Anvilrage Marshal"] = "鐵怒隊長";
	AL["Doomforge Arcanasmith"] = "末日之爐魔匠";
	AL["Weapon Technician"] = "武器技師";
	AL["Doomforge Craftsman"] = "末日之爐工匠";
	AL["Murk Worm"] = "黑暗蟲";
	AL["Atal'ai Witch Doctor"] = "阿塔萊巫醫";
	AL["Raging Skeleton"] = "狂怒的骸骨";
	AL["Ethereal Priest"] = "伊斯利牧師";
	AL["Sethekk Ravenguard"] = "塞司克烏鴉護衛";
	AL["Time-Lost Shadowmage"] = "時光流逝暗影法師";
	AL["Coilfang Sorceress"] = "盤牙法師";
	AL["Coilfang Oracle"] = "盤牙神諭者";
	AL["Shattered Hand Centurion"] = "破碎之手百夫長";
	AL["Eredar Deathbringer"] = "埃雷達爾死亡召喚者";
	AL["Arcatraz Sentinel"] = "亞克崔茲哨兵";
	AL["Gargantuan Abyssal"] = "巨型冥淵火";
	AL["Sunseeker Botanist"] = "尋日植物學家";
	AL["Sunseeker Astromage"] = "尋日星法師";
	AL["Durnholde Rifleman"] = "敦霍爾德槍手";
	AL["Rift Keeper/Rift Lord"] = "裂縫看守者 / 裂縫領主";
	AL["Crimson Templar"] = "赤紅聖殿騎士";
	AL["Azure Templar"] = "碧藍聖殿騎士";
	AL["Hoary Templar"] = "蒼白聖殿騎士";
	AL["Earthen Templar"] = "土色聖殿騎士";
	AL["The Duke of Cynders"] = "辛德爾公爵";
	AL["The Duke of Fathoms"] = "深淵公爵";
	AL["The Duke of Zephyrs"] = "微風公爵";
	AL["The Duke of Shards"] = "碎石公爵";
	AL["Aether-tech Assistant"] = "蒼穹技師助手";
	AL["Aether-tech Adept"] = "蒼穹技師專家";
	AL["Aether-tech Master"] = "蒼穹技師大師";
	AL["Trelopades"] = "特羅費茲";
	AL["King Dorfbruiser"] = "國王多爾福布利薩";
	AL["Gorgolon the All-seeing"] = "全知者戈爾多隆";
	AL["Matron Li-sahar"] = "女侍衛長利薩哈爾";
	AL["Solus the Eternal"] = "智者索勒斯";
	AL["Balzaphon"] = "巴爾薩馮";
	AL["Lord Blackwood"] = "黑木公爵";
	AL["Revanchion"] = "雷瓦克安";
	AL["Scorn"] = "瑟克恩";
	AL["Sever"] = "塞沃爾";
	AL["Lady Falther'ess"] = "法瑟蕾絲夫人";
	AL["Smokywood Pastures Vendor"] = "燻木牧場商人";
	AL["Shartuul"] = "夏圖歐";
	AL["Darkscreecher Akkarai"] = "黑暗尖叫者阿卡萊";
	AL["Karrog"] = "凱羅格";
	AL["Gezzarak the Huntress"] = "女獵人吉札拉";
	AL["Vakkiz the Windrager"] = "風怒者瓦奇茲";
	AL["Terokk"] = "泰洛克";
	AL["Armbreaker Huffaz"] = "斷臂者霍法茲";
	AL["Fel Tinkerer Zortan"] = "惡魔工匠祖坦";
	AL["Forgosh"] = "弗古斯";
	AL["Gul'bor"] = "古柏爾";
	AL["Malevus the Mad"] = "狂怒者馬拉弗斯";
	AL["Porfus the Gem Gorger"] = "寶石吞噬者波弗斯";
	AL["Wrathbringer Laz-tarash"] = "憤怒使者拉茲泰拉西";
	AL["Bash'ir Landing Stasis Chambers"] = "貝許爾的靜止密室";
	AL["Templars"] = "聖殿騎士";
	AL["Dukes"] = "公爵";
	AL["High Council"] = "高階議會";
	AL["Headless Horseman"] = "無頭騎士";
	AL["Barleybrew Brewery"] = "麥酒釀造廠";
	AL["Thunderbrew Brewery"] = "雷霆啤酒釀造廠";
	AL["Gordok Brewery"] = "戈多克綠酒釀造廠";
	AL["Drohn's Distillery"] = "德羅恩的釀酒廠";
	AL["T'chali's Voodoo Brewery"] = "提洽里的巫毒釀酒廠";
	AL["Scarshield Quartermaster"] = "裂盾軍需官";
	AL["Overmaster Pyron"] = "征服者派隆"; --Is in BabbleBoss
	AL["Father Flame"] = "烈焰之父";
	AL["Thomas Yance"] = "湯瑪斯·陽斯";
	AL["Knot Thimblejack"] = "諾特·希姆加克";
	AL["Shen'dralar Provisioner"] = "辛德拉聖職者";
	AL["Namdo Bizzfizzle"] = "納姆杜";
	AL["The Nameles Prophet"] = "無名預言者";
	AL["Zelemar the Wrathful"] = "『憤怒者』賽勒瑪爾";
	AL["Henry Stern"] = "亨利·斯特恩"; --Is in BabbleBoss
	AL["Aggem Thorncurse"] = "阿格姆";
	AL["Roogug"] = "魯古格";
	AL["Rajaxx's Captains"] = "拉賈克斯的上尉們";
	AL["Razorfen Spearhide"] = "剃刀沼澤刺鬃守衛";
	AL["Rethilgore"] = "雷希戈爾";
	AL["Kalldan Felmoon"] = "卡爾丹·暗月";
	AL["Magregan Deepshadow"] = "馬格雷甘·深影";
	AL["Lord Ahune"] = "艾胡恩";
	AL["Coren Direbrew"] = "寇仁·恐酒"; --Is in BabbleBoss
	AL["Don Carlos"] = "卡洛斯先生龍舌蘭酒";
	AL["Thomas Yance"] = "湯瑪斯·陽斯";
	AL["Aged Dalaran Wizard"] = "年邁的達拉然巫師";
	AL["Cache of the Legion"] = "軍團貯藏箱";
	AL["Rajaxx's Captains"] = "拉賈克斯將軍的軍官群";
	AL["Felsteed"] = "惡魔戰馬";
	AL["Shattered Hand Executioner"] = "破碎之手劊子手";
	AL["Commander Stoutbeard"] = "指揮官厚鬚"; --Is in BabbleBoss
	AL["Bjarngrim"] = "畢亞格林"; --Is in BabbleBoss
	AL["Loken"] = "洛肯"; --Is in BabbleBoss
	AL["Time-Lost Proto Drake"] = "時光流逝元龍";
	AL["Faction Champions"] = "陣營勇士"; -- if you have a better name, use it.
	AL["Razzashi Raptor"] = "拉札希迅猛龍";
	AL["Deviate Ravager/Deviate Guardian"] = "變異劫毀者/變異守護者";
	AL["Krick and Ick"]  = "克瑞克與艾克";

	--Zones
	AL["World Drop"] = "世界掉落";
	AL["Sunwell Isle"] = "太陽之井 - 奎爾達納斯之島";

	--Shortcuts for Bossname files
	AL["LBRS"] = "黑下";
	AL["UBRS"] = "黑上";
	AL["CoT1"] = "時光之穴1";
	AL["CoT2"] = "時光之穴2";
	AL["Scholo"] = "通靈";
	AL["Strat"] = "斯坦";
	AL["Serpentshrine"] = "毒蛇神殿";
	AL["Avatar"] = "馬丁瑞德的化身";  -- Avatar of the Martyred

	--Chests, etc
	AL["Dark Coffer"] = "黑色寶庫";
	AL["The Secret Safe"] = "隱密的保險箱";
	AL["The Vault"] = "寶窟";
	AL["Ogre Tannin Basket"] = "巨魔鞣酸籃";
	AL["Fengus's Chest"] = "衛兵芬古斯的箱子";
	AL["The Prince's Chest"] = "王子的箱子";
	AL["Doan's Strongbox"] = "杜安的箱子";
	AL["Frostwhisper's Embalming Fluid"] = "萊斯·霜語的防腐液";
	AL["Unforged Rune Covered Breastplate"] = "未鑄造的符文覆飾胸甲";
	AL["Malor's Strongbox"] = "瑪洛爾的箱子";
	AL["Unfinished Painting"] = "未完成的畫作";
	AL["Felvine Shard"] = "魔藤碎片";
	AL["Baelog's Chest"] = "巴爾洛戈的箱子";
	AL["Lorgalis Manuscript"] = "洛迦里斯手稿";
	AL["Fathom Core"] = "深淵之核";
	AL["Conspicuous Urn"] = "顯眼的石罐";
	AL["Gift of Adoration"] = "愛慕之禮";
	AL["Box of Chocolates"] = "巧克力盒";
	AL["Treat Bag"] = "糖果包";
	AL["Gaily Wrapped Present"] = "精心包裝的禮物";
	AL["Festive Gift"] = "節慶禮物";
	AL["Ticking Present"] = "滴答作響的禮物";
	AL["Gently Shaken Gift"] = "輕輕搖晃過的禮物";
	AL["Carefully Wrapped Present"] = "仔細包裝的禮物";
	AL["Winter Veil Gift"] = "冬幕節禮物";
	AL["Smokywood Pastures Extra-Special Gift"] = "燻木牧場的超特別禮物";
	AL["Brightly Colored Egg"] = "彩蛋";
	AL["Lunar Festival Fireworks Pack"] = "新年煙火包";
	AL["Lucky Red Envelope"] = "幸運紅包袋";
	AL["Small Rocket Recipes"] = "小型煙火配方";
	AL["Large Rocket Recipes"] = "大型煙火配方";
	AL["Cluster Rocket Recipes"] = "煙花束配方";
	AL["Large Cluster Rocket Recipes"] = "大型煙花束設計圖";
	AL["Timed Reward Chest"] = "限時任務獎勵箱子";
	AL["Timed Reward Chest 1"] = "限時任務獎勵箱子 1";
	AL["Timed Reward Chest 2"] = "限時任務獎勵箱子 2";
	AL["Timed Reward Chest 3"] = "限時任務獎勵箱子 3";
	AL["Timed Reward Chest 4"] = "限時任務獎勵箱子 4";
	AL["The Talon King's Coffer"] = "鷹王的保險箱";
	AL["Krom Stoutarm's Chest"] = "克羅姆·粗臂的箱子";
	AL["Garrett Family Chest"] = "加勒特的寶箱";
	AL["Reinforced Fel Iron Chest"] = "強化惡魔鐵箱";
	AL["DM North Tribute Chest"] = "北厄貢品箱";
	AL["The Saga of Terokk"] = "泰洛克的傳說";
	AL["First Fragment Guardian"] = "第一碎片守衛者";
	AL["Second Fragment Guardian"] = "第二碎片守衛者";
	AL["Third Fragment Guardian"] = "第三碎片守衛者";
	AL["Overcharged Manacell"] = "滿溢的法力容器";
	AL["Mysterious Egg"] = "詭秘的蛋";
	AL["Hyldnir Spoils"] = "海迪尼爾戰利品";
	AL["Ripe Disgusting Jar"] = "熟成的噁心罐子";
	AL["Cracked Egg"] = "破損的蛋";
	AL["Small Spice Bag"] = "小香料包";
	AL["Handful of Candy"] = "一把糖果";
	AL["Lovely Dress Box"] = "可愛的裙裝盒";
	AL["Dinner Suit Box"] = "晚宴套裝盒";
	AL["Bag of Heart Candies"] = "心願糖果袋";

	--The next 4 lines are the tooltip for the Server Query Button
	--The translation doesn't have to be literal, just re-write the
	--sentences as you would naturally and break them up into 4 roughly
	--equal lines.
	AL["Queries the server for all items"] = "向伺服器查詢此頁所有物品。完成後";
	AL["on this page. The items will be"] = "滑鼠移至物品圖示上即可更新。";
	AL["refreshed when you next mouse"] = "";
	AL["over them."] = "";
	AL["The Minimap Button is generated by the FuBar Plugin."] = "小地圖按鍵由 FuBar 插件所產生";
	AL["This is automatic, you do not need FuBar installed."] = "你不用另行安裝 FuBar";

	--Help Frame
	AL["Help"] = "說明";
	AL["AtlasLoot Help"] = "AtlasLoot 說明";
	AL["For further help, see our website and forums: "] = "進階說明請參閱網站及論壇: \n";
	AL["How to open the standalone Loot Browser:"] = "如何開啟獨立的物品掉落檢視器: ";
	AL["If you have AtlasLootFu enabled, click the minimap button, or alternatively a button generated by a mod like Titan or FuBar.  Finally, you can type '/al' in the chat window."] = "點選小地圖旁的 AtlasLoot / Titan / FuBar 按鈕。或在聊天視窗輸入 '/al' 以開啟物品掉落檢視器。";
	AL["How to view an 'unsafe' item:"] = "如何檢視不安全物品: ";
	AL["Unsafe items have a red border around the icon and are marked because you have not seen the item since the last patch or server restart. Right-click the item, then move your mouse back over the item or click the 'Query Server' button at the bottom of the loot page."] = "不安全的物品其圖示周圍有紅色外筐，用以標示從上次的重大更新或伺服器重新啟動後你尚未檢視過的物品。在物品圖示右鍵點擊，然後將滑鼠移開，再重新移回圖示上方，或是按下 '從伺服器查詢' 按鈕。";
	AL["How to view an item in the Dressing Room:"] = "如何在試衣間檢視物品: ";
	AL["Simply Ctrl+Left Click on the item.  Sometimes the dressing room window is hidden behind the Atlas or AtlasLoot windows, so if nothing seems to happen move your Atlas or AtlasLoot windows and see if anything is hidden."] = "在物品上按下 Ctrl + 滑鼠右鍵即可。有時試衣間的視窗隱藏在 Atlas 或是 AtlasLoot 視窗之下，因此若是未看到試衣間視窗，嘗試移動 Atlas 或是 AtlasLoot 視窗。";
	AL["How to link an item to someone else:"] = "如何傳送物品連結給其他人: ";
	AL["Shift+Left Click the item like you would for any other in-game item"] = "在物品上按 Shift + 滑鼠左鍵。";
	AL["How to add an item to the wishlist:"] = "如何新增物品到願望清單: ";
	AL["Alt+Left Click any item to add it to the wishlist."] = "在物品上按 Alt + 滑鼠左鍵。";
	AL["How to delete an item from the wishlist:"] = "如何將物品從願望清單刪除: ";
	AL["While on the wishlist screen, just Alt+Left Click on an item to delete it."] = "在願望清單視窗中，於欲刪除物品上按 Alt + 滑鼠左鍵。";
	AL["What else does the wishlist do?"] = "願望清單還可以做什麼？";
	AL["If you Left Click any item on the wishlist, you can jump to the loot page the item comes from.  Also, on a loot page any item already in your wishlist is marked with a yellow star."] = "如果你在願望清單裡對任何物品按滑鼠左鍵，視窗將跳至該物品的掉落頁面，以便你查閱對應的掉落首領等。此外，一個已經被你加至願望清單的物品，在對應的首領掉落頁面也會以黃色星星標示。";
	AL["HELP!! I have broken the mod somehow!"] = "求助，我有個壞掉的模組無法正常運作！";
	AL["Use the reset buttons available in the options menu, or type '/al reset' in your chat window."] = "請嘗試用重設按鈕，或是輸入 '/al reset' 來重設所有設定。";

	--Error Messages and warnings
	AL["AtlasLoot Error!"] = "AtlasLoot 錯誤!";
	AL["WishList Full!"] = "願望清單已滿";
	AL[" added to the WishList."] = "已加入願望清單";
	AL[" already in the WishList!"] = "已經存在於願望清單";
	AL[" deleted from the WishList."] = "已從願望清單移除";
	AL["No match found for"] = "找不到符合於";
	AL[" is safe."] = "的連結現在安全了。";
	AL["Server queried for "] = "從伺服器查詢物品";
	AL[".  Right click on any other item to refresh the loot page."] = "的資訊. 右鍵點選其他物品以更新這一個物品頁面";

	--Incomplete Table Registry error message
	AL[" not listed in loot table registry, please report this message to the AtlasLoot forums at http://www.atlasloot.net"] = "並未列於物品掉落註冊表，請至 AtlasLoot 論壇回報問題：http://www.atlasloot.net";

	--LoD Module disabled or missing
	AL[" is unavailable, the following load on demand module is required: "] = "無法取得，需要以下的動態載入模組：";

	--LoD Module load sequence could not be completed
	AL["Status of the following module could not be determined: "] = "以下模組的狀態無法被確認：";

	--LoD Module required has loaded, but loot table is missing
	AL[" could not be accessed, the following module may be out of date: "] = "無法被存取，以下的模組可能版本已過於老舊：";

	--LoD module not defined
	AL["Loot module returned as nil!"] = "找不到可動態載入的模組";

	--LoD module loaded successfully
	AL["sucessfully loaded."] = "載入成功";

	--Need a big dataset for searching
	AL["Loading available tables for searching"] = "載入搜尋所需的資料表";

	--All Available modules loaded
	AL["All Available Modules Loaded"] = "所有的模組已載入";

	--First time user
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."] = "歡迎使用 Atlasloot Enhanced。請花一些時間設定您的偏好選項。";
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences for tooltips and links in the chat window.\n\n  This options screen can be reached again at any later time by typing '/atlasloot'."] = "歡迎使用 AtlasLoot Enhanced. 請花一點時間來設定訊息提示和連結的喜好. 輸入 /atlasloot 可以再次設定喜好選項";
	AL["Setup"] = "設定";

	--Old Atlas Detected
	AL["It has been detected that your version of Atlas does not match the version that Atlasloot is tuned for ("] = "您現在的 Atlas 插件版本並不完全支援此版本的 Atlasloot, Atlas 的最新版本為 (";
	AL[").  Depending on changes, there may be the occasional error, so please visit http://www.atlasmod.com as soon as possible to update."] = "). 依 Atlas 版本的變化, AtlasLoot 也許會出現偶然的錯誤, 請儘快前往 http://www.atlasmod.com 更新";
	AL["OK"] = "OK";
	AL["Incompatible Atlas Detected"] = "偵測到不相容的 Atlas 版本";

	--Unsafe item tooltip
	AL["Unsafe Item"] = "不安全的物品";
	AL["Item Unavailable"] = "物品資訊目前無法取得";
	AL["ItemID:"] = "物品 ID:";
	AL["This item is not available on your server or your battlegroup yet."] = "這件物品目前在您的伺服器或是戰場群組中無法取得";
	AL["This item is unsafe.  To view this item without the risk of disconnection, you need to have first seen it in the game world. This is a restriction enforced by Blizzard since Patch 1.10."] = "這個物品並不安全. 如要安全的檢視這個物品並且避免斷線, 你必須在當前的伺服器中曾見過該物品. 這是暴雪自 1.10 更新之後增加的限制.";
	AL["You can right-click to attempt to query the server.  You may be disconnected."] = "你可以按下滑鼠右鍵來嘗試向伺服器查詢該物品的資訊, 然而你將可能因此斷線.";
end
