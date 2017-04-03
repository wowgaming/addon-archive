--[[
constants.cn.lua
This file defines an AceLocale table for all the various text strings needed
by AtlasLoot.  In this implementation, if a translation is missing, it will fall
back to the English translation.

The AL["text"] = true; shortcut can ONLY be used for English (the root translation).
]]
-- $Id: constants.cn.lua 2727 2010-07-18 17:45:00Z arith $




--Create the library instance
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");

local AL = AceLocale:NewLocale("AtlasLoot", "zhCN", false);

--Register translations
if AL then

	--Text strings for UI objects
	--AL["AtlasLoot"] = true;
	AL["Select Loot Table"] = "选择掉落表";
	AL["Select Sub-Table"] = "选择二级表";
	AL["Drop Rate: "] = "掉落率: ";
	AL["DKP"] = "DKP";
	AL["Priority:"] = "优先: ";
	AL["Click boss name to view loot."] = "点击首领名以浏览掉落";
	AL["Various Locations"] = "多个位置";
	AL["This is a loot browser only.  To view maps as well, install either Atlas or Alphamap."] = "这只是个掉落浏览器，如果要同时查看地图，请安装Atlas或者Alphamap";
	AL["Toggle AL Panel"] = "AtlasLoot 面板";
	AL["Back"] = "返回";
	AL["Level 60"] = "等级 60";
	AL["Level 70"] = "等级 70";
	AL["Level 80"] = "等级 80";
	AL["|cffff0000(unsafe)"] = "|cffff0000(不安全)";
	AL["Misc"] = "其他";
	AL["Miscellaneous"] = "其他";
	AL["Rewards"] = "奖励";
	AL["Show 10 Man Loot"] = "显示10人掉落";
	AL["Show 25 Man Loot"] = "显示25人掉落";
	AL["Factions - Original WoW"] = "阵营 - 旧大陆";
	AL["Factions - Burning Crusade"] = "阵营 - 燃烧的远征";
	AL["Factions - Wrath of the Lich King"] = "阵营 - 巫妖王之怒";
	AL["Choose Table ..."] = "请选择……";
	AL["Unknown"] = "未知";
	AL["Add to QuickLooks:"] = "添加到快捷浏览";
	AL["Assign this loot table\n to QuickLook"] = "分配此物品表\n至快捷浏览";
	AL["Query Server"] = "查询物品";
	AL["Reset Frames"] = "重置框体";
	AL["Reset Wishlist"] = "重置需求表";
	AL["Reset Quicklooks"] = "重置快速访问";
	AL["Select a Loot Table..."] = "选择掉落表";
	AL["OR"] = "或";
	AL["FuBar Options"] = "FuBar选项";
	AL["Attach to Minimap"] = "附着在小地图";
	AL["Hide FuBar Plugin"] = "隐藏FuBar插件";
	AL["Show FuBar Plugin"] = "显示FuBar插件";
	AL["Position:"] = "位置:";
	AL["Left"] = "左";
	AL["Center"] = "中";
	AL["Right"] = "右";
	AL["Hide Text"] = "隐藏文本";
	AL["Hide Icon"] = "隐藏图标";
	AL["Minimap Button Options"] = "小地图按钮选项";

	--Text for Options Panel
	AL["Atlasloot Options"] = "Atlasloot 设置";
	AL["Safe Chat Links"] = "使用安全物品连接";
	AL["Default Tooltips"] = "默认提示样式";
	AL["Lootlink Tooltips"] = "Lootlink 提示样式";
	AL["|cff9d9d9dLootlink Tooltips|r"] = "|cff9d9d9dLootlink 提示样式";
	AL["ItemSync Tooltips"] = "ItemSync 提示样式";
	AL["|cff9d9d9dItemSync Tooltips|r"] = "|cff9d9d9dItemSync 提示样式|r";
	AL["Use EquipCompare"] = "使用装备对比";
	AL["|cff9d9d9dUse EquipCompare|r"] = "|cff9d9d9d使用装备对比|r";
	AL["Show Comparison Tooltips"] = "显示装备对比";
	AL["Make Loot Table Opaque"] = "禁用物品列表背景透明";
	AL["Show itemIDs at all times"] = "永远显示物品ID";
	AL["Hide AtlasLoot Panel"] = "隐藏 AtlasLoot 面板";
	AL["Show Basic Minimap Button"] = "显示小地图图标";
	AL["|cff9d9d9dShow Basic Minimap Button|r"] = "设置小地图图标位置";
	AL["Set Minimap Button Position"] = "设置小地图按钮位置";
	AL["Suppress Item Query Text"] = "查询物品时不显示提示信息";
	AL["Notify on LoD Module Load"] = "当物品数据模块载入时进行提示";
	AL["Load Loot Modules at Startup"] = "在启动时载入所有物品数据模块";
	AL["Loot Browser Scale: "] = "掉落浏览器比例：";
	AL["Button Position: "] = "按钮位置:";
	AL["Button Radius: "] = "按钮半径:";
	AL["Done"] = "确定";
	AL["FuBar Toggle"] = "FuBar开关";
	AL["Search Result: %s"] = "搜索结果：%s";
	AL["Search on"] = "搜索于";
	AL["All modules"] = "全部模块";
	AL["If checked, AtlasLoot will load and search across all the modules."] = "如果选中，AtlasLoot会载入并扫描所有的模块。";
	AL["Search options"] = "搜索选项";
	AL["Partial matching"] = "部分匹配";
	AL["If checked, AtlasLoot search item names for a partial match."] = "如果选中，AtlasLoot会将输入文字作为物品名称的一部分进行匹配。";
	AL["You don't have any module selected to search on!"] = "你没有选择任何用于搜索的模块。";
	AL["Treat Crafted Items:"] = "交易技能呈现方式:";
	AL["As Crafting Spells"] = "技能";
	AL["As Items"] = "制成品";
	AL["Loot Browser Style:"] = "物品掉落表呈现方式:";
	AL["New Style"] = "新样式";
	AL["Classic Style"] = "传统样式";
	
	--Slash commands
	AL["reset"] = "reset";
	AL["options"] = "options";
	AL["Reset complete!"] = "重置完成";

	--AtlasLoot Panel
	AL["Collections"] = "套装/收藏";
	AL["Crafting"] = "制造的物品";
	AL["Factions"] = "阵营";
	AL["Load Modules"] = "载入所有数据";
	AL["Options"] = "设置";
	AL["PvP Rewards"] = "PvP奖励";
	AL["QuickLook"] = "快捷浏览";
	AL["World Events"] = "世界事件";

	--AtlasLoot Panel - Search
	AL["Clear"] = "重置";
	AL["Last Result"] = "上次搜索";
	AL["Search"] = "搜索";

	--AtlasLoot Browser Menus
	AL["Classic Instances"] = "旧大陆副本";
	AL["BC Instances"] = "燃烧的远征副本";
	AL["Sets/Collections"] = "套装/收藏";
	AL["Reputation Factions"] = "声望阵营";
	AL["WotLK Instances"] = "巫妖王之怒副本";
	AL["World Bosses"] = "世界首领";
	AL["Close Menu"] = "关闭";

	--Crafting Menu
	AL["Crafting Daily Quests"] = "交易技能日常任务";
	AL["Cooking Daily"] = "烹饪每日任务";
	AL["Fishing Daily"] = "钓鱼每日任务";
	AL["Jewelcrafting Daily"] = "珠宝加工每日任务";
	AL["Crafted Sets"] = "制造出的套装";
	AL["Crafted Epic Weapons"] = "制造出的史诗武器";
	AL["Dragon's Eye"] = "龙眼石";

	--Sets/Collections Menu
	AL["Badge of Justice Rewards"] = "公正徽章兑换奖励";
	AL["Emblem of Valor Rewards"] = "勇气纹章奖励";
	AL["Emblem of Heroism Rewards"] = "英雄纹章奖励";
	AL["Emblem of Conquest Rewards"] = "征服纹章奖励";
	AL["Emblem of Triumph Rewards"] = "凯旋纹章奖励";
	AL["Emblem of Frost Rewards"] = "冰霜纹章奖励";
	AL["BoE World Epics"] = "世界掉落的史诗装备";
	AL["Dungeon 1/2 Sets"] = "地下城套装1/2";
	AL["Dungeon 3 Sets"] = "地下城套装3";
	AL["Legendary Items"] = "传奇物品";
	AL["Mounts"] = "坐骑";
	AL["Vanity Pets"] = "非战斗宠物";
	AL["Misc Sets"] = "其它套装";
	AL["Classic Sets"] = "旧大陆套装";
	AL["Burning Crusade Sets"] = "燃烧的远征套装";
	AL["Wrath Of The Lich King Sets"] = "巫妖王之怒套装";
	AL["Ruins of Ahn'Qiraj Sets"] = "安其拉废墟职业套装";
	AL["Temple of Ahn'Qiraj Sets"] = "安其拉神殿职业套装";
	AL["Tabards"] = "战袍";
	AL["Tier 1/2 Sets"] = "T1/T2套装";
	AL["Tier 1/2/3 Sets"] = "T1/T2/T3套装";
	AL["Tier 3 Sets"] = "T3套装";
	AL["Tier 4/5/6 Sets"] = "T4/T5/T6套装";
	AL["Tier 7/8 Sets"] = "T7/T8套装";
	AL["Upper Deck Card Game Items"] = "集换式卡牌游戏奖品";
	AL["Zul'Gurub Sets"] = "祖尔格拉布职业套装";

	--Factions Menu
	AL["Original Factions"] = "旧大陆声望";
	AL["BC Factions"] = "燃烧的远征声望";
	AL["WotLK Factions"] = "巫妖王之怒声望";

	--PvP Menu
	AL["Arena PvP Sets"] = "竞技场奖励套装";
	AL["PvP Rewards (Level 60)"] = "PvP奖励 (等级 60)";
	AL["PvP Rewards (Level 70)"] = "PvP奖励 (等级 70)";
  	AL["PvP Rewards (Level 80)"] = "PvP奖励 (等级 80)";
	AL["Arathi Basin Sets"] = "阿拉希盆地套装";
	AL["PvP Accessories"] = "PvP奖励杂物";
	AL["PvP Armor Sets"] = "PvP奖励套装";
	AL["PvP Weapons"] = "PvP奖励武器";
	AL["PvP Non-Set Epics"] = "PvP奖励非套装史诗级部件";
	AL["PvP Reputation Sets"] = "PvP声望套装";
	AL["Arena PvP Weapons"] = "竞技场奖励武器";
	AL["PvP Misc"] = "PvP珠宝设计图";
	AL["PVP Gems/Enchants/Jewelcrafting Designs"] = "PvP 珠宝/附魔设计图";
	AL["Level 80 PvP Sets"] = "80级PvP套装";
	AL["Old Level 80 PvP Sets"] = "旧等级 80 PvP 套装";
	AL["Arena Season 7/8 Sets"] = "竞技场第七/八季 PvP 套装";
	AL["PvP Class Items"] = "PvP 职业物品";
	AL["NOT AVAILABLE ANYMORE"] = "已不再提供";

	--World Events
	AL["Abyssal Council"] = "深渊议会";
	AL["Argent Tournament"] = "银色锦标赛";
	AL["Bash'ir Landing Skyguard Raid"] = "巴什伊尔码头";
	AL["Brewfest"] = "美酒节";
	AL["Children's Week"] = "儿童周";
	AL["Day of the Dead"] = "悼念日";
	AL["Elemental Invasion"] = "元素入侵";
	AL["Ethereum Prison"] = "复仇军监狱";
	AL["Feast of Winter Veil"] = "冬幕节";
	AL["Gurubashi Arena Booty Run"] = "古拉巴什竞技场";
	AL["Hallow's End"] = "万圣节";
	AL["Harvest Festival"] = "收获节";
	AL["Love is in the Air"] = "情人节";
	AL["Lunar Festival"] = "春节";
	AL["Midsummer Fire Festival"] = "仲夏火焰节";
	AL["Noblegarden"] = "彩蛋节";
	AL["Pilgrim's Bounty"] = "感恩节";
	AL["Skettis"] = "斯克提斯";
	AL["Stranglethorn Fishing Extravaganza"] = "荆棘谷钓鱼大赛";

	--Minimap Button
	AL["|cff1eff00Left-Click|r Browse Loot Tables"] = "|cff1eff00单击|r 浏览掉落表";
	AL["|cffff0000Right-Click|r View Options"] = "|cffff0000右键点击|r 进行设置";
	AL["|cffff0000Shift-Click|r View Options"] = "|cffff0000Shift-单击|r 进行设置";
	AL["|cffccccccLeft-Click + Drag|r Move Minimap Button"] = "|cffcccccc左键拖动|r 移动小地图按钮";
	AL["|cffccccccRight-Click + Drag|r Move Minimap Button"] = "|cffcccccc右键拖动|r 移动小地图按钮";

	-- Filter
	AL["Filter"] = "筛选";
	AL["Select All Loot"] = "选择所有掉落物品";
	AL["Apply Filter:"] = "套用筛选条件";
	AL["Armor:"] = "护甲种类:";
	AL["Melee weapons:"] = "近战武器:";
	AL["Ranged weapons:"] = "远程武器:";
	AL["Relics:"] = "圣物";
	AL["Other:"] = "其他:";

	-- Wishlist
	AL["Close"] = "关闭";
	AL["WishList"] = "装备需求表";
	AL["Own Wishlists"] = "自己的需求表";
	AL["Other Wishlists"] = "其他的需求表";
	AL["Shared Wishlists"] = "分享的需求表";
	AL["Mark items in loot tables"] = "在物品表标记物品";
	AL["Mark items from own Wishlist"] = "从自己的需求表标记物品";
	AL["Mark items from all Wishlists"] = "从所有的需求表标记物品";
	AL["Enable Wishlist Sharing"] = "允许需求表分享";
	AL["Auto reject in combat"] = "战斗中自动拒绝";
	AL["Always use default Wishlist"] = "永远使用默认的需求表";
	AL["Add Wishlist"] = "新增需求表";
	AL["Edit Wishlist"] = "编辑需求表";
	AL["Show More Icons"] = "显示更多图标";
	AL["Wishlist name:"] = "需求表名称:";
	AL["Delete"] = "删除";
	AL["Edit"] = "编辑";
	AL["Share"] = "分享";
	AL["Show all Wishlists"] = "显示所有的需求表";
	AL["Show own Wishlists"] = "显示自己的需求表";
	AL["Show shared Wishlists"] = "显示分享的需求表";
	AL["You must wait "] = "你必须等候 ";
	AL[" seconds before you can send a new Wishlist to "] = " 秒后才可以将需求表传送给";
	AL["Send Wishlist (%s) to"] = "传送 '%s' 需求表给";
	AL["Send"] = "传送";
	AL["Cancel"] = "取消";
	AL["Delete Wishlist %s?"] = "是否删除 '%s' 需求表?";
	AL["%s sends you a Wishlist. Accept?"] = "%s传送了一个需求表给你，是否接受?";
	AL[" tried to send you a Wishlist. Rejected because you are in combat."] = "尝试传送一个愿望清单给你，因你正在战斗中而系统自动拒绝了。";
	AL[" rejects your Wishlist."] = "拒绝了你的需求表";
	AL["You can't send Wishlists to yourself"] = "你不能将需求表传送给自己。";
	AL["Please set a default Wishlist."] = "请设定一个默认的需求表。";
	AL["Set as default Wishlist"] = "设为默认的需求表";
	
	--Misc Inventory related words
	AL["Enchant"] = "附魔";
	AL["Scope"] = "瞄准镜";
	AL["Darkmoon Faire Card"] = "暗月马戏团卡片";
	AL["Banner"] = "旗帜";
	AL["Set"] = "套装";
	AL["Token"] = "兑换物";
	AL["Tokens"] = "兑换物";
	AL["Token Hand-Ins"] = "勋章缴交";
	AL["Skinning Knife"] = "剥皮刀";
	AL["Herbalism Knife"] = "采药刀";
	AL["Fish"] = "鱼";
	AL["Combat Pet"] = "战斗宠物";
	AL["Fireworks"] = "焰火";
	AL["Fishing Lure"] = "鱼饵";

	--Extra inventory stuff
	AL["Cloak"] = "披风";
	AL["Sigil"] = "魔印";

	--Alchemy
	AL["Battle Elixirs"] = "战斗药剂";
	AL["Guardian Elixirs"] = "守护药剂";
	AL["Potions"] = "药水";
	AL["Transmutes"] = "转化";
	AL["Flasks"] = "药剂";

	--Enchanting
	AL["Enchant Boots"] = "附魔脚部";
	AL["Enchant Bracer"] = "附魔护腕";
	AL["Enchant Chest"] = "附魔胸部";
	AL["Enchant Cloak"] = "附魔斗篷";
	AL["Enchant Gloves"] = "附魔手套";
	AL["Enchant Ring"] = "附魔戒指";
	AL["Enchant Shield"] = "附魔盾牌";
	AL["Enchant 2H Weapon"] = "附魔双手武器";
	AL["Enchant Weapon"] = "附魔武器";

	--Engineering
	AL["Ammunition"] = "弹药";
	AL["Explosives"] = "爆炸物";

	--Inscription
	AL["Major Glyph"] = "大型雕文";
	AL["Minor Glyph"] = "小型雕文";
	AL["Scrolls"] = "卷轴";
	AL["Off-Hand Items"] = "副手物品";
	AL["Reagents"] = "材料";
	AL["Book of Glyph Mastery"] = "雕文精通之书";

	--Leatherworking
	AL["Leather Armor"] = "皮甲";
	AL["Mail Armor"] = "锁甲";
	AL["Cloaks"] = "斗篷";
	AL["Item Enhancements"] = "物品强化";
	AL["Quivers and Ammo Pouches"] = "箭袋和弹药袋";
	AL["Drums, Bags and Misc."] = "鼓、包等";

	--Tailoring
	AL["Cloth Armor"] = "布甲";
	AL["Shirts"] = "衬衫";
	AL["Bags"] = "包";
	
	--Labels for loot descriptions
	AL["Classes:"] = "职业:";
	AL["This Item Begins a Quest"] = "将触发一个任务";
	AL["Quest Item"] = "任务物品";
	AL["Old Quest Item"] = "旧任务物品";
	AL["Quest Reward"] = "任务奖励";
	AL["Old Quest Reward"] = "旧任务奖励";
	AL["Shared"] = "共享掉落";
	AL["Unique"] = "唯一";
	AL["Right Half"] = "右半部分";
	AL["Left Half"] = "左半部分";
	AL["28 Slot Soul Shard"] = "28格灵魂袋";
	AL["20 Slot"] = "20格";
	AL["18 Slot"] = "18格";
	AL["16 Slot"] = "16格";
	AL["10 Slot"] = "10格";
	AL["(has random enchantment)"] = "(随机附魔)";
	AL["Currency"] = "用以购买奖励";
	AL["Currency (Alliance)"] = "用以购买奖励 (联盟)";
	AL["Currency (Horde)"] = "用以购买奖励 (部落)";
	AL["Conjured Item"] = "魔法制造的物品";
	AL["Used to summon boss"] = "用以召唤首领";
	AL["Tradable against sunmote + item above"] = "用太阳之尘和上个物品兑换得到";
	AL["Card Game Item"] = "卡片游戏奖品";
	AL["Skill Required:"] = "需要技能：";
	AL["Rating:"] = "等级"; --Shorthand for 'Required Rating' for the personal/team ratings in Arena S4
	AL["Random Heroic Reward"] = "随机英雄副本奖励";

	--Minor Labels for loot table descriptions
	AL["Original WoW"] = "旧大陆";
	AL["Burning Crusade"] = "燃烧的远征";
	AL["Wrath of the Lich King"] = "巫妖王之怒";
	AL["Entrance"] = "入口";
	AL["Season 2"] = "第二季联赛";
	AL["Season 3"] = "第三季联赛";
	AL["Season 4"] = "第四季联赛";
	AL["Dungeon Set 1"] = "地下城套装1";
	AL["Dungeon Set 2"] = "地下城套装2";
	AL["Dungeon Set 3"] = "地下城套装3";
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
	AL["10 Man"] = "10人";
	AL["25 Man"] = "25人";
	AL["10/25 Man"] = "10/25人";
	AL["Epic Set"] = "史诗级套装";
	AL["Rare Set"] = "精良级套装";
	AL["Fire"] = "火";
	AL["Water"] = "水";
	AL["Wind"] = "风";
	AL["Earth"] = "地";
	AL["Master Angler"] = "钓鱼大师";
	AL["Fire Resistance Gear"] = "火焰抗性装备";
	AL["Arcane Resistance Gear"] = "奥术抗性装备";
	AL["Nature Resistance Gear"] = "自然抗性装备";
	AL["Frost Resistance Gear"] = "冰霜抗性装备";
	AL["Shadow Resistance Gear"] = "暗影抗性装备";

	--Labels for loot table sections
	AL["Additional Heroic Loot"] = "额外的英雄副本掉落";
	AL["Heroic Mode"] = "英雄模式";
	AL["Normal Mode"] = "普通模式";
	AL["Raid"] = "团队";
  	AL["Hard Mode"] = "困难模式";
	AL["Bonus Loot"] = "奖励掉落";
	AL["One Drake Left"] = "剩余一条幼龙";
	AL["Two Drakes Left"] = "剩余两条幼龙";
	AL["Three Drakes Left"] = "剩余三条幼龙";
	AL["Arena Reward"] = "竞技场奖励";
	AL["Phase 1"] = "第一阶段";
	AL["Phase 2"] = "第二阶段";
	AL["Phase 3"] = "第三阶段";
	AL["First Prize"] = "第一名奖励";
	AL["Rare Fish Rewards"] = "稀有鱼种奖励";
	AL["Rare Fish"] = "稀有鱼种";
	AL["Unattainable Tabards"] = "无法获得的战袍";
	AL["Heirloom"] = "传家宝";
	AL["Weapons"] = "武器";
	AL["Accessories"] = "杂物";
	AL["Alone in the Darkness"] = "黑暗中的独影";
	AL["Call of the Grand Crusade"] = "大十字军的试炼";
	AL["A Tribute to Skill (25)"] = "对技艺的嘉奖";
	AL["A Tribute to Mad Skill (45)"] = "对精湛技艺的嘉奖";
	AL["A Tribute to Insanity (50)"] = "对疯狂的嘉奖";
	AL["A Tribute to Immortality"] = "对不朽的嘉奖";
	AL["Low Level"] = "较低等级";
	AL["High Level"] = "较高等级";

	--Loot Table Names
	AL["Scholomance Sets"] = "通灵学院套装";
	AL["PvP Accessories (Level 60)"] = "PvP奖励杂物 (等级 60)";
	AL["PvP Accessories - Alliance (Level 60)"] = "PvP奖励杂物 - 联盟 (等级 60)";
	AL["PvP Accessories - Horde (Level 60)"] = "PvP奖励杂物 - 部落 (等级 60)";
	AL["PvP Weapons (Level 60)"] = "PvP奖励武器 (等级 60)";
	AL["PvP Accessories (Level 70)"] = "PvP奖励杂物 (等级 70)";
	AL["PvP Weapons (Level 70)"] = "PvP奖励武器 (等级 60)";
	AL["PvP Reputation Sets (Level 70)"] = "PvP声望套装 (等级 70)";
	AL["Arena Season 2 Weapons"] = "竞技场第二季武器";
	AL["Arena Season 3 Weapons"] = "竞技场第三季武器";
	AL["Arena Season 4 Weapons"] = "竞技场第四季武器";
	AL["Level 30-39"] = "等级 30-39";
	AL["Level 40-49"] = "等级 40-49";
	AL["Level 50-60"] = "等级 50-60";
	AL["Heroic"] = "英雄模式";
	AL["Summon"] = "召唤";
	AL["Random"] = "随机";
	AL["Tier 8 Sets"] = "T8 套装";
	AL["Tier 9 Sets"] = "T9 套装";
	AL["Tier 10 Sets"] = "T10 套装";
	AL["Furious Gladiator Sets"] = "狂怒角斗士套装";
	AL["Relentless Gladiator Sets"] = "无情角斗士套装";
	AL["Brew of the Month Club"] = "每月啤酒俱乐部";

	--Extra Text in Boss lists
	AL["Set: Embrace of the Viper"] = "套装：毒蛇的拥抱";
	AL["Set: Defias Leather"] = "套装：迪菲亚皮甲";
	AL["Set: The Gladiator"] = "套装：角斗士";
	AL["Set: Chain of the Scarlet Crusade"] = "套装：血色十字军链甲";
	AL["Set: The Postmaster"] = "套装：邮差";
	AL["Set: Necropile Raiment"] = "套装：骨堆";
	AL["Set: Cadaverous Garb"] = "套装：苍白";
	AL["Set: Bloodmail Regalia"] = "套装：血链";
	AL["Set: Deathbone Guardian"] = "套装：亡者之骨";
	AL["Set: Dal'Rend's Arms"] = "套装：雷德双刀";
	AL["Set: Spider's Kiss"] = "套装：蜘蛛之吻";
	AL["AQ20 Class Sets"] = "安其拉废墟职业套装";
	AL["AQ Enchants"] = "安其拉掉落的附魔公式";
	AL["AQ40 Class Sets"] = "安其拉神殿职业套装";
	AL["AQ Opening Quest Chain"] = "安其拉之门任务奖励";
	AL["ZG Class Sets"] = "祖尔格拉布职业套装";
	AL["ZG Enchants"] = "祖尔格拉布的附魔";
	AL["Class Books"] = "职业书籍";
	AL["Tribute Run"] = "贡品";
	AL["Dire Maul Books"] = "厄运之槌书籍";
	AL["Random Boss Loot"] = "首领随机掉落物品";
	AL["BT Patterns/Plans"] = "黑暗神殿掉落的图纸";
	AL["Hyjal Summit Designs"] = "海加尔峰掉落的图纸";
	AL["SP Patterns/Plans"] = "太阳之井高地掉落图纸";
	AL["Ulduar Formula/Patterns/Plans"] = "奥杜尔公式/图样/设计图";
	AL["Trial of the Crusader Patterns/Plans"] = "十字军的试炼图样/设计图";
	AL["Legendary Items for Kael'thas Fight"] = "凯尔萨斯一役使用到的传奇物品";

	--Pets
	AL["Pets"] = "宠物";
	AL["Promotional"] = "促销";
	AL["Pet Store"] = "宠物商店";
	AL["Merchant Sold"] = "商人贩卖";
	AL["Rare"] = "稀有";
	AL["Achievement"] = "成就";
	AL["Faction"] = "阵营";
	AL["Dungeon/Raid"] = "副本/团队";

	--Mounts
	AL["Achievement Reward"] = "成就奖励";
	AL["Alliance Flying Mounts"] = "联盟飞行坐骑";
	AL["Alliance Mounts"] = "联盟坐骑";
	AL["Horde Flying Mounts"] = "部落飞行坐骑";
	AL["Horde Mounts"] = "部落坐骑";
	AL["Card Game Mounts"] = "套卡奖励坐骑";
	AL["Crafted Mounts"] = "精制坐骑";
	AL["Event Mounts"] = "事件奖励坐骑";
	AL["Neutral Faction Mounts"] = "中立阵营坐骑";
	AL["PvP Mounts"] = "PvP 坐骑";
	AL["Alliance PvP Mounts"] = "联盟 PvP 坐骑";
	AL["Horde PvP Mounts"] = "部落 PvP 坐骑";
	AL["Halaa PvP Mounts"] = "哈剌 PvP 坐骑";
	AL["Promotional Mounts"] = "特定商业促销坐骑";
	AL["Rare Mounts"] = "稀有坐骑";

	--Darkmoon Faire
	AL["Darkmoon Faire Rewards"] = "暗月马戏团奖励";
	AL["Low Level Decks"] = "低级卡片";
	AL["Original and BC Trinkets"] = "旧大陆和燃烧远征饰品";
	AL["WotLK Trinkets"] = "巫妖王之怒饰品";
		
	--Card Game Decks and descriptions
	AL["Loot Card Items"] = "刮刮卡奖品";
	AL["UDE Items"] = "UDE积分奖品";

	-- First set
	AL["Heroes of Azeroth"] = "艾泽拉斯英雄传";
	AL["Landro Longshot"] = "远射兰铎";
	AL["Thunderhead Hippogryph"] = "雷首角鹰兽";
	AL["Saltwater Snapjaw"] = "海水钳嘴龟";

	-- Second set
	--AL["Through The Dark Portal"] = true;
	AL["King Mukla"] = "穆克拉";
	AL["Rest and Relaxation"] = "休息与放松";
	AL["Fortune Telling"] = "算命";

	-- Third set
	--AL["Fires of Outland"] = true;
	AL["Spectral Tiger"] = "幽灵虎";
	--AL["Gone Fishin'"] = true;
	AL["Goblin Gumbo"] = "地精杂烩";

	-- Fourth set
	--AL["March of the Legion"] = true;
	AL["Kiting"] = "风筝";
	AL["Robotic Homing Chicken"] = "自动导航机器小鸡";
	AL["Paper Airplane"] = "纸飞机";

	-- Fifth set
	--AL["Servants of the Betrayer"] = true;
	AL["X-51 Nether-Rocket"] = "X-51虚空火箭";
	AL["Personal Weather Machine"] = "个人天气制造机";
	AL["Papa Hummel's Old-fashioned Pet Biscuit"] = "修默老爹的宠物饼干";

	-- Sixth set
	--AL["Hunt for Illidan"] = true;
	AL["The Footsteps of Illidan"] = "伊利丹的脚步";
	--AL["Disco Inferno!"] = true;
	--AL["Ethereal Plunderer"] = true;

	-- Seventh set
	--AL["Drums of War"] = true;
	--AL["The Red Bearon"] = true;
	--AL["Owned!"] = true;
	--AL["Slashdance"] = true;

	-- Eighth set
	--AL["Blood of Gladiators"] = true;
	--AL["Sandbox Tiger"] = true;
	--AL["Center of Attention"] = true;
	--AL["Foam Sword Rack"] = true;

	-- Ninth set
	--AL["Fields of Honor"] = true;
	--AL["Path of Cenarius"] = true;
	--AL["Pinata"] = true;
	--AL["El Pollo Grande"] = true;

	-- Tenth set
	--AL["Scourgewar"] = true;
	--AL["Tiny"] = true;
	--AL["Tuskarr Kite"] = true;
	--AL["Spectral Kitten"] = true;

	-- Eleventh set
	--AL["Wrathgate"] = true;
	--AL["Statue Generator"] = true;
	--AL["Landro's Gift"] = true;
	--AL["Blazing Hippogryph"] = true;

	-- Twelvth set
	--AL["Icecrown"] = true;
	--AL["Wooly White Rhino"] = true;
	--AL["Ethereal Portal"] = true;
	--AL["Paint Bomb"] = true;

	--Battleground Brackets
	AL["BG/Open PvP Rewards"] = "燃烧远征开放 PvP 奖励";
	AL["Misc. Rewards"] = "其他奖励";
	AL["Level 20-39 Rewards"] = "等级20-39奖励";
	AL["Level 20-29 Rewards"] = "等级20-29奖励";
	AL["Level 30-39 Rewards"] = "等级30-39奖励";
	AL["Level 40-49 Rewards"] = "等级40-49奖励";
	AL["Level 60 Rewards"] = "等级60奖励";

	--Brood of Nozdormu Paths
	AL["Path of the Conqueror"] = "征服者之路";
	AL["Path of the Invoker"] = "祈求者之路";
	AL["Path of the Protector"] = "保护者之路";

	--Violet Eye Paths
	AL["Path of the Violet Protector"] = "紫罗兰庇护者之路";
	AL["Path of the Violet Mage"] = "紫罗兰大法师之路";
	AL["Path of the Violet Assassin"] = "紫罗兰刺客之路";
	AL["Path of the Violet Restorer"] = "紫罗兰治愈者之路";

	-- Ashen Verdict Paths
	--AL["Path of Courage"] = true;
	--AL["Path of Destruction"] = true;
	--AL["Path of Vengeance"] = true;
	--AL["Path of Wisdom"] = true;

	--AQ Opening Event
	AL["Red Scepter Shard"] = "红色节杖碎片";
	AL["Blue Scepter Shard"] = "蓝色节杖碎片";
	AL["Green Scepter Shard"] = "绿色节杖碎片";
	AL["Scepter of the Shifting Sands"] = "流沙节杖";
	
	--World PvP
	AL["Hellfire Fortifications"] = "防御工事";
	AL["Twin Spire Ruins"] = "双塔废墟";
	AL["Spirit Towers"] = "灵魂之塔";
	AL["Halaa"] = "哈兰";
	AL["Venture Bay"] = "风险湾";

	--Karazhan Opera Event Headings
	AL["Shared Drops"] = "共享掉落";
	AL["Romulo & Julianne"] = "罗密欧与朱丽叶";
	AL["Wizard of Oz"] = "绿野仙踪";
	AL["Red Riding Hood"] = "小红帽";

	--Karazhan Animal Boss Types
	AL["Spider"] = "蜘蛛";
	AL["Darkhound"] = "黑暗猎犬";
	AL["Bat"] = "蝙蝠";
	
	--ZG Tokens
	AL["Primal Hakkari Kossack"] = "原始哈卡莱套索";
	AL["Primal Hakkari Shawl"] = "原始哈卡莱披肩";
	AL["Primal Hakkari Bindings"] = "原始哈卡莱护腕";
	AL["Primal Hakkari Sash"] = "原始哈卡莱腰带";
	AL["Primal Hakkari Stanchion"] = "原始哈卡莱直柱";
	AL["Primal Hakkari Aegis"] = "原始哈卡莱之盾";
	AL["Primal Hakkari Girdle"] = "原始哈卡莱束带";
	AL["Primal Hakkari Armsplint"] = "原始哈卡莱护臂";
	AL["Primal Hakkari Tabard"] = "原始哈卡莱徽章";

	--AQ20 Tokens
	AL["Qiraji Ornate Hilt"] = "其拉装饰刀柄";
	AL["Qiraji Martial Drape"] = "其拉军用披风";
	AL["Qiraji Magisterial Ring"] = "其拉将领戒指";
	AL["Qiraji Ceremonial Ring"] = "其拉典礼戒指";
	AL["Qiraji Regal Drape"] = "其拉帝王披风";
	AL["Qiraji Spiked Hilt"] = "其拉尖刺刀柄";
	
	--AQ40 Tokens
	AL["Qiraji Bindings of Dominance"] = "其拉统御腕轮";
	AL["Qiraji Bindings of Command"] = "其拉命令腕轮";
	AL["Vek'nilash's Circlet"] = "维克尼拉斯的头饰";
	AL["Vek'lor's Diadem"] = "维克洛尔的王冠";
	AL["Ouro's Intact Hide"] = "奥罗的外皮";
	AL["Skin of the Great Sandworm"] = "巨型沙虫的皮";
	AL["Husk of the Old God"] = "上古之神的外鞘";
	AL["Carapace of the Old God"] = "上古之神的甲壳";

	-- Blacksmithing Mail Crafted Sets
	AL["Bloodsoul Embrace"] = "血魂的拥抱";
	AL["Fel Iron Chain"] = "魔铁链甲";

	--Blacksmithing Crafted Sets
	AL["Imperial Plate"] = "君王板甲";
	AL["The Darksoul"] = "黑暗之魂";
	AL["Fel Iron Plate"] = "魔铁板甲";
	AL["Adamantite Battlegear"] = "精金战甲";
	AL["Flame Guard"] = "烈焰卫士";
	AL["Enchanted Adamantite Armor"] = "魔化精金套装";
	AL["Khorium Ward"] = "氪金套装";
	AL["Faith in Felsteel"] = "魔钢的信仰";
	AL["Burning Rage"] = "钢铁之怒";
	--AL["Ornate Saronite Battlegear"] = true;
	--AL["Savage Saronite Battlegear"] = true;

	--Leatherworking Crafted Sets
	AL["Volcanic Armor"] = "火山";
	AL["Ironfeather Armor"] = "铁羽护甲";
	AL["Stormshroud Armor"] = "雷暴";
	AL["Devilsaur Armor"] = "魔暴龙护甲";
	AL["Blood Tiger Harness"] = "血虎";
	AL["Primal Batskin"] = "原始蝙蝠皮套装";
	AL["Wild Draenish Armor"] = "野性德莱尼套装";
	AL["Thick Draenic Armor"] = "厚重德莱尼套装";
	AL["Fel Skin"] = "魔能之肤";
	AL["Strength of the Clefthoof"] = "裂蹄之力";
	AL["Primal Intent"] = "原始打击";
	AL["Windhawk Armor"] = "风鹰";
	--AL["Borean Embrace"] = true;
	--AL["Iceborne Embrace"] = true;
	--AL["Eviscerator's Battlegear"] = true;
	--AL["Overcaster Battlegear"] = true;	

	-- Leatherworking Crafted Mail Sets
	AL["Green Dragon Mail"] = "绿龙锁甲";
	AL["Blue Dragon Mail"] = "蓝龙锁甲";
	AL["Black Dragon Mail"] = "黑龙锁甲";
	AL["Scaled Draenic Armor"] = "缀鳞德拉诺套装";
	AL["Felscale Armor"] = "魔鳞套装";
	AL["Felstalker Armor"] = "魔能猎手";
	AL["Fury of the Nether"] = "虚空之怒";
	AL["Netherscale Armor"] = "虚空之鳞";
	AL["Netherstrike Armor"] = "虚空打击";
	--AL["Frostscale Binding"] = true;
	--AL["Nerubian Hive"] = true;
	--AL["Stormhide Battlegear"] = true;
	--AL["Swiftarrow Battlefear"] = true;
	
	--Tailoring Crafted Sets
	AL["Bloodvine Garb"] = "血藤";
	AL["Netherweave Vestments"] = "灵纹套装";
	AL["Imbued Netherweave"] = "魔化灵纹套装";
	AL["Arcanoweave Vestments"] = "奥法交织套装";
	AL["The Unyielding"] = "不屈的力量";
	AL["Whitemend Wisdom"] = "白色治愈";
	AL["Spellstrike Infusion"] = "法术打击";
	AL["Battlecast Garb"] = "战斗施法套装";
	AL["Soulcloth Embrace"] = "灵魂布之拥";
	AL["Primal Mooncloth"] = "原始月布";
	AL["Shadow's Embrace"] = "暗影之拥";
	AL["Wrath of Spellfire"] = "魔焰之怒";
	--AL["Frostwoven Power"] = true;
	--AL["Duskweaver"] = true;
	--AL["Frostsavage Battlegear"] = true;

	--Classic WoW Sets
	AL["Defias Leather"] = "迪菲亚皮甲";
	AL["Embrace of the Viper"] = "毒蛇的拥抱";
	AL["Chain of the Scarlet Crusade"] = "血色十字军链甲";
	AL["The Gladiator"] = "角斗士";
	AL["Ironweave Battlesuit"] = "铁纹作战套装";
	AL["Necropile Raiment"] = "骨堆";
	AL["Cadaverous Garb"] = "苍白";
	AL["Bloodmail Regalia"] = "血链";
	AL["Deathbone Guardian"] = "亡者之骨";
	AL["The Postmaster"] = "邮差";
	AL["Shard of the Gods"] = "天神碎片";
	AL["Zul'Gurub Rings"] = "祖尔格拉布戒指";
	AL["Major Mojo Infusion"] = "极效魔精套装";
	AL["Overlord's Resolution"] = "督军的决心";
	AL["Prayer of the Primal"] = "远古祷言";
	AL["Zanzil's Concentration"] = "赞吉尔的专注";
	AL["Spirit of Eskhandar"] = "艾斯卡达尔之魂";
	AL["The Twin Blades of Hakkari"] = "哈卡莱双刃";
	AL["Primal Blessing"] = "原始祝福";
	AL["Dal'Rend's Arms"] = "雷德双刀";
	AL["Spider's Kiss"] = "蜘蛛之吻";
	
	--The Burning Crusade Sets
	AL["Latro's Flurry"] = "拉托恩的狂怒";
	AL["The Twin Stars"] = "双子星";
	AL["The Fists of Fury"] = "愤怒之拳";
	AL["The Twin Blades of Azzinoth"] = "艾辛洛斯双刃";

	--Wrath of the Lich King Sets
	AL["Raine's Revenge"] = "蕾妮的复仇";
	--AL["Purified Shard of the Gods"] = true;
	--AL["Shiny Shard of the Gods"] = true;

	--Recipe origin strings
	AL["Trainer"] = "训练师";
	AL["Discovery"] = "领悟";
	AL["World Drop"] = "世界掉落";
	AL["Drop"] = "掉落";
	AL["Vendor"] = "商人";
	AL["Quest"] = "任务";
	AL["Crafted"] = "制造";

	--Scourge Invasion
	AL["Scourge Invasion"] = "天灾入侵";
	AL["Scourge Invasion Sets"] = "天灾入侵套装";
	AL["Blessed Regalia of Undead Cleansing"] = "神圣的亡灵净化法衣";
	AL["Undead Slayer's Blessed Armor"] = "神圣的亡灵毁灭护甲";
	AL["Blessed Garb of the Undead Slayer"] = "神圣的亡灵毁灭套装";
	AL["Blessed Battlegear of Undead Slaying"] = "神圣的亡灵毁灭战甲";
	AL["Prince Tenris Mirkblood"] = "特里斯·黯血王子";

	--ZG Sets
	AL["Haruspex's Garb"] = "占卜师套装";
	AL["Predator's Armor"] = "捕猎者套装";
	AL["Illusionist's Attire"] = "幻术师套装";
	AL["Freethinker's Armor"] = "思考者护甲";
	AL["Confessor's Raiment"] = "忏悔者衣饰";
	AL["Madcap's Outfit"] = "狂妄者套装";
	AL["Augur's Regalia"] = "预言者套装";
	AL["Demoniac's Threads"] = "恶魔师护甲";
	AL["Vindicator's Battlegear"] = "辩护者重甲";

	--AQ20 Sets
	AL["Symbols of Unending Life"] = "不灭的生命";
	AL["Trappings of the Unseen Path"] = "隐秘的通途";
	AL["Trappings of Vaulted Secrets"] = "魔法的秘密";
	AL["Battlegear of Eternal Justice"] = "永恒的公正";
	AL["Finery of Infinite Wisdom"] = "无尽的智慧";
	AL["Emblems of Veiled Shadows"] = "笼罩的阴影";
	AL["Gift of the Gathering Storm"] = "聚集的风暴";
	AL["Implements of Unspoken Names"] = "禁断的邪语";
	AL["Battlegear of Unyielding Strength"] = "坚定的力量";
	
	--AQ40 Sets
	AL["Genesis Raiment"] = "起源套装";
	AL["Striker's Garb"] = "攻击者";
	AL["Enigma Vestments"] = "神秘套装";
	AL["Avenger's Battlegear"] = "复仇者";
	AL["Garments of the Oracle"] = "神谕者";
	AL["Deathdealer's Embrace"] = "死亡执行者的拥抱";
	AL["Stormcaller's Garb"] = "风暴召唤者";
	AL["Doomcaller's Attire"] = "厄运召唤者";
	AL["Conqueror's Battlegear"] = "征服者";

	--Dungeon 1 Sets
	AL["Wildheart Raiment"] = "野性之心";
	AL["Beaststalker Armor"] = "野兽追猎者";
	AL["Magister's Regalia"] = "博学者的徽记";
	AL["Lightforge Armor"] = "光铸护甲";
	AL["Vestments of the Devout"] = "虔诚";
	AL["Shadowcraft Armor"] = "迅影";
	AL["The Elements"] = "元素";
	AL["Dreadmist Raiment"] = "鬼雾";
	AL["Battlegear of Valor"] = "勇气";
	
	--Dungeon 2 Sets
	AL["Feralheart Raiment"] = "狂野之心";
	AL["Beastmaster Armor"] = "兽王";
	AL["Sorcerer's Regalia"] = "巫师";
	AL["Soulforge Armor"] = "魂铸";
	AL["Vestments of the Virtuous"] = "坚贞";
	AL["Darkmantle Armor"] = "暗幕";
	AL["The Five Thunders"] = "五雷";
	AL["Deathmist Raiment"] = "死雾";
	AL["Battlegear of Heroism"] = "英勇";

	--Dungeon 3 Sets
	AL["Hallowed Raiment"] = "圣徒";
	AL["Incanter's Regalia"] = "魔咒师";
	AL["Mana-Etched Regalia"] = "法力蚀刻魔装";
	AL["Oblivion Raiment"] = "湮灭";
	AL["Assassination Armor"] = "刺杀";
	AL["Moonglade Raiment"] = "月光林地";
	AL["Wastewalker Armor"] = "废土行者";
	AL["Beast Lord Armor"] = "巨兽之王";
	AL["Desolation Battlegear"] = "荒芜战甲";
	AL["Tidefury Raiment"] = "潮汐之怒";
	AL["Bold Armor"] = "鲁莽套装";
	AL["Doomplate Battlegear"] = "末日板甲";
	AL["Righteous Armor"] = "正义";

	--Tier 1 Sets
	AL["Cenarion Raiment"] = "塞纳里奥";
	AL["Giantstalker Armor"] = "巨人追猎者";
	AL["Arcanist Regalia"] = "奥术师";
	AL["Lawbringer Armor"] = "秩序之源";
	AL["Vestments of Prophecy"] = "预言";
	AL["Nightslayer Armor"] = "夜幕杀手";
	AL["The Earthfury"] = "大地之怒";
	AL["Felheart Raiment"] = "恶魔之心";
	AL["Battlegear of Might"] = "力量";

	--Tier 2 Sets
	AL["Stormrage Raiment"] = "怒风";
	AL["Dragonstalker Armor"] = "巨龙追猎者";
	AL["Netherwind Regalia"] = "灵风";
	AL["Judgement Armor"] = "审判";
	AL["Vestments of Transcendence"] = "卓越";
	AL["Bloodfang Armor"] = "血牙";
	AL["The Ten Storms"] = "无尽风暴";
	AL["Nemesis Raiment"] = "复仇";
	AL["Battlegear of Wrath"] = "愤怒";

	--Tier 3 Sets
	AL["Dreamwalker Raiment"] = "梦游者";
	AL["Cryptstalker Armor"] = "地穴追猎者";
	AL["Frostfire Regalia"] = "霜火";
	AL["Redemption Armor"] = "救赎";
	AL["Vestments of Faith"] = "信仰";
	AL["Bonescythe Armor"] = "骨镰";
	AL["The Earthshatterer"] = "碎地者";
	AL["Plagueheart Raiment"] = "瘟疫之心";
	AL["Dreadnaught's Battlegear"] = "无畏";

	--Tier 4 Sets
	AL["Malorne Harness"] = "玛洛恩甲胄";
	AL["Malorne Raiment"] = "玛洛恩圣装";
	AL["Malorne Regalia"] = "玛洛恩法衣";
	AL["Demon Stalker Armor"] = "恶魔追猎者";
	AL["Aldor Regalia"] = "奥尔多魔装";
	AL["Justicar Armor"] = "公正护甲";
	AL["Justicar Battlegear"] = "公正战甲";
	AL["Justicar Raiment"] = "公正圣装";
	AL["Incarnate Raiment"] = "化身圣装";
	AL["Incarnate Regalia"] = "化身法衣";
	AL["Netherblade Set"] = "虚空刀锋";
	AL["Cyclone Harness"] = "飓风甲胄";
	AL["Cyclone Raiment"] = "飓风圣装";
	AL["Cyclone Regalia"] = "飓风法衣";
	AL["Voidheart Raiment"] = "虚空之心";
	AL["Warbringer Armor"] = "战神护甲";
	AL["Warbringer Battlegear"] = "战神战甲";

	--Tier 5 Sets
	AL["Nordrassil Harness"] = "诺达希尔甲胄";
	AL["Nordrassil Raiment"] = "诺达希尔圣装";
	AL["Nordrassil Regalia"] = "诺达希尔法衣";
	AL["Rift Stalker Armor"] = "裂隙追猎者";
	AL["Tirisfal Regalia"] = "提瑞斯法";
	AL["Crystalforge Armor"] = "晶铸护甲";
	AL["Crystalforge Battlegear"] = "晶铸战甲";
	AL["Crystalforge Raiment"] = "晶铸圣装";
	AL["Avatar Raiment"] = "神使圣装";
	AL["Avatar Regalia"] = "神使法衣";
	AL["Deathmantle Set"] = "死亡阴影";
	AL["Cataclysm Harness"] = "灾难甲胄";
	AL["Cataclysm Raiment"] = "灾难圣装";
	AL["Cataclysm Regalia"] = "灾难法衣";
	AL["Corruptor Raiment"] = "腐蚀者";
	AL["Destroyer Armor"] = "毁灭者护甲";
	AL["Destroyer Battlegear"] = "毁灭者战甲";

	--Tier 6 Sets
	AL["Thunderheart Harness"] = "雷霆之心甲胄";
	AL["Thunderheart Raiment"] = "雷霆之心圣服";
	AL["Thunderheart Regalia"] = "雷霆之心法衣";
	AL["Gronnstalker's Armor"] = "戈隆追猎者";
	AL["Tempest Regalia"] = "风暴";
	AL["Lightbringer Armor"] = "光明使者护甲";
	AL["Lightbringer Battlegear"] = "光明使者战甲";
	AL["Lightbringer Raiment"] = "光明使者圣服";
	AL["Vestments of Absolution"] = "赦免法衣";
	AL["Absolution Regalia"] = "赦免圣装";
	AL["Slayer's Armor"] = "刺杀者";
	AL["Skyshatter Harness"] = "破天甲胄";
	AL["Skyshatter Raiment"] = "破天圣服";
	AL["Skyshatter Regalia"] = "破天法衣";
	AL["Malefic Raiment"] = "凶星";
	AL["Onslaught Armor"] = "冲锋护甲";
	AL["Onslaught Battlegear"] = "冲锋战甲";

	--Tier 7 Sets
	AL["Scourgeborne Battlegear"] = "天灾苦痛战甲";
	AL["Scourgeborne Plate"] = "天灾苦痛铠甲";
	AL["Dreamwalker Garb"] = "梦游者套装";
	AL["Dreamwalker Battlegear"] = "梦游者战甲";
	AL["Dreamwalker Regalia"] = "梦游者法衣";
	AL["Cryptstalker Battlegear"] = "地穴追猎者战甲";
	AL["Frostfire Garb"] = "霜火套装";
	AL["Redemption Regalia"] = "救赎圣甲";
	AL["Redemption Battlegear"] = "救赎战甲";
	AL["Redemption Plate"] = "救赎铠甲";
	AL["Regalia of Faith"] = "信仰法衣";
	AL["Garb of Faith"] = "信仰套装";
	AL["Bonescythe Battlegear"] = "骨镰战甲";
	AL["Earthshatter Garb"] = "碎地者套装";
	AL["Earthshatter Battlegear"] = "碎地者战甲";
	AL["Earthshatter Regalia"] = "碎地者法衣";
	AL["Plagueheart Garb"] = "瘟疫之心套装";
	AL["Dreadnaught Battlegear"] = "无畏战甲";
	AL["Dreadnaught Plate"] = "无畏铠甲";

	-- Tier 8 Sets
	--AL["Darkruned Battlegear"] = true;
	--AL["Darkruned Plate"] = true;
	--AL["Nightsong Garb"] = true;
	--AL["Nightsong Battlegear"] = true;
	--AL["Nightsong Regalia"] = true;
	--AL["Scourgestalker Battlegear"] = true;
	--AL["Kirin Tor Garb"] = true;
	--AL["Aegis Regalia"] = true;
	--AL["Aegis Battlegear"] = true;
	--AL["Aegis Plate"] = true;
	--AL["Sanctification Regalia"] = true;
	--AL["Sanctification Garb"] = true;
	--AL["Terrorblade Battlegear"] = true;
	--AL["Worldbreaker Garb"] = true;
	--AL["Worldbreaker Battlegear"] = true;
	--AL["Worldbreaker Regalia"] = true;
	--AL["Deathbringer Garb"] = true;
	--AL["Siegebreaker Battlegear"] = true;
	--AL["Siegebreaker Plate"] = true;

	-- Tier 9 Sets
	--AL["Malfurion's Garb"] = true;
	--AL["Malfurion's Battlegear"] = true;
	--AL["Malfurion's Regalia"] = true;
	--AL["Runetotem's Garb"] = true;
	--AL["Runetotem's Battlegear"] = true;
	--AL["Runetotem's Regalia"] = true;
	--AL["Windrunner's Battlegear"] = true;
	--AL["Windrunner's Pursuit"] = true;
	--AL["Khadgar's Regalia"] = true;
	--AL["Sunstrider's Regalia"] = true;
	--AL["Turalyon's Garb"] = true;
	--AL["Turalyon's Battlegear"] = true;
	--AL["Turalyon's Plate"] = true;
	--AL["Liadrin's Garb"] = true;
	--AL["Liadrin's Battlegear"] = true;
	--AL["Liadrin's Plate"] = true;
	--AL["Velen's Regalia"] = true;
	--AL["Velen's Raiment"] = true;
	--AL["Zabra's Regalia"] = true;
	--AL["Zabra's Raiment"] = true;
	--AL["VanCleef's Battlegear"] = true;
	--AL["Garona's Battlegear"] = true;
	--AL["Nobundo's Garb"] = true;
	--AL["Nobundo's Battlegear"] = true;
	--AL["Nobundo's Regalia"] = true;
	--AL["Thrall's Garb"] = true;
	--AL["Thrall's Battlegear"] = true;
	--AL["Thrall's Regalia"] = true;
	--AL["Kel'Thuzad's Regalia"] = true;
	--AL["Gul'dan's Regalia"] = true;
	--AL["Wrynn's Battlegear"] = true;
	--AL["Wrynn's Plate"] = true;
	--AL["Hellscream's Battlegear"] = true;
	--AL["Hellscream's Plate"] = true;
	--AL["Thassarian's Battlegear"] = true;
	--AL["Koltira's Battlegear"] = true;
	--AL["Thassarian's Plate"] = true;
	--AL["Koltira's Plate"] = true;

	-- Tier 10 Sets
	--AL["Lasherweave's Garb"] = true;
	--AL["Lasherweave's Battlegear"] = true;
	--AL["Lasherweave's Regalia"] = true;
	--AL["Ahn'Kahar Blood Hunter's Battlegear"] = true;
	--AL["Bloodmage's Regalia"] = true;
	--AL["Lightsworn Garb"] = true;
	--AL["Lightsworn Plate"] = true;
	--AL["Lightsworn Battlegear"] = true;
	--AL["Crimson Acolyte's Regalia"] = true;
	--AL["Crimson Acolyte's Raiment"] = true;
	--AL["Shadowblade's Battlegear"] = true;
	--AL["Frost Witch's Garb"] = true;
	--AL["Frost Witch's Battlegear"] = true;
	--AL["Frost Witch's Regalia"] = true;
	--AL["Dark Coven's Garb"] = true;
	--AL["Ymirjar Lord's Battlegear"] = true;
	--AL["Ymirjar Lord's Plate"] = true;
	--AL["Scourgelord's Battlegear"] = true;
	--AL["Scourgelord's Plate"] = true;

	-- Arathi Basin Sets - Alliance
	AL["The Highlander's Intent"] = "高地人的专注";
	AL["The Highlander's Purpose"] = "高地人的毅力";
	AL["The Highlander's Will"] = "高地人的意志";
	AL["The Highlander's Determination"] = "高地人的果断";
	AL["The Highlander's Fortitude"] = "高地人的坚韧";
	AL["The Highlander's Resolution"] = "高地人的决心";
	AL["The Highlander's Resolve"] = "高地人的执着";

	--Arathi Basin Sets - Horde
	AL["The Defiler's Intent"] = "污染者的专注";
	AL["The Defiler's Purpose"] = "污染者的毅力";
	AL["The Defiler's Will"] = "污染者的意志";
	AL["The Defiler's Determination"] = "污染者的果断";
	AL["The Defiler's Fortitude"] = "污染者的坚韧";
	AL["The Defiler's Resolution"] = "污染者的决心";

	--PvP Level 60 Rare Sets - Alliance
	AL["Lieutenant Commander's Refuge"] = "少校的庇护";
	AL["Lieutenant Commander's Pursuance"] = "少校的职责";
	AL["Lieutenant Commander's Arcanum"] = "少校的秘密";
	AL["Lieutenant Commander's Redoubt"] = "少校的壁垒";
	AL["Lieutenant Commander's Investiture"] = "少校的授权";
	AL["Lieutenant Commander's Guard"] = "少校的护卫";
	AL["Lieutenant Commander's Stormcaller"] = "少校的震撼暴";
	AL["Lieutenant Commander's Dreadgear"] = "少校的鬼纹";
	AL["Lieutenant Commander's Battlearmor"] = "少校的战铠";

	--PvP Level 60 Rare Sets - Horde
	AL["Champion's Refuge"] = "勇士的庇护";
	AL["Champion's Pursuance"] = "勇士的职责";
	AL["Champion's Arcanum"] = "勇士的秘密";
	AL["Champion's Redoubt"] = "勇士的壁垒";
	AL["Champion's Investiture"] = "勇士的授权";
	AL["Champion's Guard"] = "勇士的套装";
	AL["Champion's Stormcaller"] = "勇士的风暴";
	AL["Champion's Dreadgear"] = "勇士的鬼纹";
	AL["Champion's Battlearmor"] = "勇士的战铠";

	--PvP Level 60 Epic Sets - Alliance
	AL["Field Marshal's Sanctuary"] = "元帅的圣装";
	AL["Field Marshal's Pursuit"] = "元帅的猎装";
	AL["Field Marshal's Regalia"] = "元帅的法衣";
	AL["Field Marshal's Aegis"] = "元帅的庇护";
	AL["Field Marshal's Raiment"] = "元帅的神服";
	AL["Field Marshal's Vestments"] = "元帅的制服";
	AL["Field Marshal's Earthshaker"] = "元帅的震撼";
	AL["Field Marshal's Threads"] = "元帅的魔装";
	AL["Field Marshal's Battlegear"] = "元帅的战甲";

	--PvP Level 60 Epic Sets - Horde
	AL["Warlord's Sanctuary"] = "督军的圣装";
	AL["Warlord's Pursuit"] = "督军的猎装";
	AL["Warlord's Regalia"] = "督军的法衣";
	AL["Warlord's Aegis"] = "督军的庇护";
	AL["Warlord's Raiment"] = "督军的神服";
	AL["Warlord's Vestments"] = "督军的制服";
	AL["Warlord's Earthshaker"] = "督军的震撼";
	AL["Warlord's Threads"] = "督军的魔装";
	AL["Warlord's Battlegear"] = "督军的战甲";

	--Outland Faction Reputation PvP Sets
	AL["Dragonhide Battlegear"] = "龙皮套装";
	AL["Wyrmhide Battlegear"] = "蟒皮套装";
	AL["Kodohide Battlegear"] = "科多皮套装";
	AL["Stalker's Chain Battlegear"] = "潜伏者的链甲套装";
	AL["Evoker's Silk Battlegear"] = "祈求者的丝质套装";
	AL["Crusader's Scaled Battledgear"] = "十字军的板鳞甲套装";
	AL["Crusader's Ornamented Battledgear"] = "十字军的雕饰板甲套装";
	AL["Satin Battlegear"] = "绸缎套装";
	AL["Mooncloth Battlegear"] = "月布套装";
	AL["Opportunist's Battlegear"] = "机遇者的套装";
	AL["Seer's Linked Battlegear"] = "先知的鳞甲套装";
	AL["Seer's Mail Battlegear"] = "先知的锁甲套装";
	AL["Seer's Ringmail Battlegear"] = "先知的环甲套装";
	AL["Dreadweave Battlegear"] = "鬼纹套装";
	AL["Savage's Plate Battlegear"] = "残暴者的板甲套装";

	--Arena Epic Sets
	AL["Gladiator's Sanctuary"] = "角斗士的圣装";
	AL["Gladiator's Wildhide"] = "角斗士的野性之皮";
	AL["Gladiator's Refuge"] = "角斗士的庇护";
	AL["Gladiator's Pursuit"] = "角斗士的猎装";
	AL["Gladiator's Regalia"] = "角斗士的法衣";
	AL["Gladiator's Aegis"] = "角斗士的保护";
	AL["Gladiator's Vindication"] = "角斗士的辩护";
	AL["Gladiator's Redemption"] = "角斗士的救赎";
	AL["Gladiator's Raiment"] = "角斗士的神服";
	AL["Gladiator's Investiture"] = "角斗士的天职";
	AL["Gladiator's Vestments"] = "角斗士的套装";
	AL["Gladiator's Earthshaker"] = "角斗士的震撼";
	AL["Gladiator's Thunderfist"] = "角斗士的雷霆之拳";
	AL["Gladiator's Wartide"] = "角斗士的战争之潮";
	AL["Gladiator's Dreadgear"] = "角斗士的鬼纹";
	AL["Gladiator's Felshroud"] = "角斗士的魔能套装";
	AL["Gladiator's Battlegear"] = "角斗士的战甲";
	AL["Gladiator's Desecration"] = "角斗士的亵渎";

	--Level 80 PvP Weapons
	AL["Savage Gladiator\'s Weapons"] = "野蛮角斗士的武器";
	AL["Deadly Gladiator\'s Weapons"] = "致命角斗士的武器";
	--AL["Furious Gladiator\'s Weapons"] = true;
	--AL["Relentless Gladiator\'s Weapons"] = true;
	--AL["Wrathful Gladiator\'s Weapons"] = true;

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

	--Specs
	AL["Balance"] = "平衡";
	AL["Feral"] = "野性战斗";
	AL["Restoration"] = "回复";
	AL["Holy"] = "神圣";
	AL["Protection"] = "防护";
	AL["Retribution"] = "惩戒";
	AL["Shadow"] = "暗影";
	AL["Elemental"] = "元素";
	AL["Enhancement"] = "增强";
	AL["Fury"] = "狂怒";
	AL["Demonology"] = "恶魔";
	AL["Destruction"] = "毁灭";
	AL["Tanking"] = "坦克";
	--AL["DPS"] = true;

	--Naxx Zones
	AL["Construct Quarter"] = "构造区";
	AL["Arachnid Quarter"] = "蜘蛛区";
	AL["Military Quarter"] = "军事区";
	AL["Plague Quarter"] = "瘟疫区";
	AL["Frostwyrm Lair"] = "冰霜巨龙的巢穴";

	--NPCs missing from BabbleBoss
	AL["Trash Mobs"] = "普通怪物";
	AL["Dungeon Set 2 Summonable"] = "地下城套装2任务首领";
	AL["Highlord Kruul"] = "魔王库鲁尔";
	AL["Theldren"] = "塞尔德林";
	AL["Sothos and Jarien"] = "索托斯/亚雷恩";
	AL["Druid of the Fang"] = "尖牙德鲁伊";
	AL["Defias Strip Miner"] = "迪菲亚赤膊矿工";
	AL["Defias Overseer/Taskmaster"] = "迪菲亚监工/工头";
	AL["Scarlet Defender/Myrmidon"] = "血色防御者/仆从";
	AL["Scarlet Champion"] = "血色勇士";
	AL["Scarlet Centurion"] = "血色百夫长";
	AL["Scarlet Trainee"] = "血色预备兵";
	AL["Herod/Mograine"] = "赫洛德/莫格莱尼";
	AL["Scarlet Protector/Guardsman"] = "血色保卫者/卫兵";
	AL["Shadowforge Flame Keeper"] = "暗炉持火者";
	AL["Olaf"] = "奥拉夫";
	AL["Eric 'The Swift'"] = "艾瑞克";
	AL["Shadow of Doom"] = "末日之影";
	AL["Bone Witch"] = "骨巫";
	AL["Lumbering Horror"] = "笨拙的憎恶";
	AL["Avatar of the Martyred"] = "殉难者的化身";
	AL["Yor"] = "尤尔";
	AL["Nexus Stalker"] = "节点潜行者";
	AL["Auchenai Monk"] = "奥金尼僧侣";
	AL["Cabal Fanatic"] = "秘教狂热者";
	AL["Unchained Doombringer"] = "摆脱束缚的厄运使者";
	AL["Crimson Sorcerer"] = "红衣法术师";
	AL["Thuzadin Shadowcaster"] = "图萨丁暗影法师";
	AL["Crimson Inquisitor"] = "红衣审查者";
	AL["Crimson Battle Mage"] = "红衣战斗法师";
	AL["Ghoul Ravener"] = "食尸抢夺者";
	AL["Spectral Citizen"] = "鬼魂市民";
	AL["Spectral Researcher"] = "鬼灵研究员";
	AL["Scholomance Adept"] = "通灵学院专家";
	AL["Scholomance Dark Summoner"] = "通灵学院黑暗召唤师";
	AL["Blackhand Elite"] = "黑手精英";
	AL["Blackhand Assassin"] = "黑手刺客";
	AL["Firebrand Pyromancer"] = "火印炎术师";
	AL["Firebrand Invoker"] = "火印祈求者";
	AL["Firebrand Grunt"] = "火印步兵";
	AL["Firebrand Legionnaire"] = "火印军团战士";
	AL["Spirestone Warlord"] = "尖石军阀";
	AL["Spirestone Mystic"] = "尖石秘法师";
	AL["Anvilrage Captain"] = "铁怒上尉";
	AL["Anvilrage Marshal"] = "铁怒队长";
	AL["Doomforge Arcanasmith"] = "厄炉魔匠";
	AL["Weapon Technician"] = "武器技师";
	AL["Doomforge Craftsman"] = "厄炉工匠";
	AL["Murk Worm"] = "黑暗虫";
	AL["Atal'ai Witch Doctor"] = "阿塔莱巫医";
	AL["Raging Skeleton"] = "暴怒的骷髅";
	AL["Ethereal Priest"] = "虚灵牧师";
	AL["Sethekk Ravenguard"] = "塞泰克鸦人卫士";
	AL["Time-Lost Shadowmage"] = "迷失的暗影法师";
	AL["Coilfang Sorceress"] = "盘牙巫师";
	AL["Coilfang Oracle"] = "盘牙先知";
	AL["Shattered Hand Centurion"] = "碎手百夫长";
	AL["Eredar Deathbringer"] = "艾瑞达死亡使者";
	AL["Arcatraz Sentinel"] = "禁魔监狱斥候";
	AL["Gargantuan Abyssal"] = "巨型深渊火魔";
	AL["Sunseeker Botanist"] = "寻日者植物学家";
	AL["Sunseeker Astromage"] = "寻日者星术师";
	AL["Durnholde Rifleman"] = "敦霍尔德火枪手";
	AL["Rift Keeper/Rift Lord"] = "裂隙守卫者/领主";
	AL["Crimson Templar"] = "赤红圣殿骑士";
	AL["Azure Templar"] = "碧蓝圣殿骑士";
	AL["Hoary Templar"] = "苍白圣殿骑士";
	AL["Earthen Templar"] = "土色圣殿骑士";
	AL["The Duke of Cynders"] = "灰烬公爵";
	AL["The Duke of Fathoms"] = "深渊公爵";
	AL["The Duke of Zephyrs"] = "微风公爵";
	AL["The Duke of Shards"] = "碎石公爵";
	AL["Aether-tech Assistant"] = "以太技师助理";
	AL["Aether-tech Adept"] = "资深以太技师";
	AL["Aether-tech Master"] = "高级以太技师";
	AL["Trelopades"] = "特雷洛帕兹";
	AL["King Dorfbruiser"] = "多弗布鲁瑟国王";
	AL["Gorgolon the All-seeing"] = "全视者格苟尔隆";
	AL["Matron Li-sahar"] = "里萨哈";
	AL["Solus the Eternal"] = "永恒者索鲁斯";
	AL["Balzaphon"] = "巴尔萨冯";
	AL["Lord Blackwood"] = "布莱克伍德公爵";
	AL["Revanchion"] = "雷瓦克安";
	AL["Scorn"] = "瑟克恩";
	AL["Sever"] = "塞沃尔";
	AL["Lady Falther'ess"] = "法瑟蕾丝夫人";
	AL["Smokywood Pastures Vendor"] = "烟林牧场商人";
	AL["Shartuul"] = "沙图尔";
	AL["Darkscreecher Akkarai"] = "黑暗尖啸者阿克卡莱";
	AL["Karrog"] = "卡尔洛格";
	AL["Gezzarak the Huntress"] = "猎手吉萨拉克";
	AL["Vakkiz the Windrager"] = "风怒者瓦克奇斯";
	AL["Terokk"] = "泰罗克";
	AL["Armbreaker Huffaz"] = "断臂者霍法斯";
	AL["Fel Tinkerer Zortan"] = "魔能工匠索尔坦";
	AL["Forgosh"] = "弗尔高什";
	AL["Gul'bor"] = "古尔博";
	AL["Malevus the Mad"] = "疯狂的玛尔弗斯";
	AL["Porfus the Gem Gorger"] = "掘钻者波弗斯";
	AL["Wrathbringer Laz-tarash"] = "天罚使者拉塔莱什";
	AL["Bash'ir Landing Stasis Chambers"] = "巴什伊尔码头静止间";
	AL["Templars"] = "圣殿骑士";
	AL["Dukes"] = "公爵";
	AL["High Council"] = "议会高层";
	AL["Headless Horseman"] = "无头骑士";
	AL["Barleybrew Brewery"] = "麦酒佳酿";
	AL["Thunderbrew Brewery"] = "雷酒佳酿";
	AL["Gordok Brewery"] = "戈多克佳酿";
	AL["Drohn's Distillery"] = "德罗恩的佳酿";
	AL["T'chali's Voodoo Brewery"] = "塔卡里的佳酿";
	AL["Scarshield Quartermaster"] = "裂盾军需官";
	AL["Overmaster Pyron"] = "征服者派隆";
	AL["Father Flame"] = "烈焰之父";
	AL["Thomas Yance"] = "托马斯·杨斯";
	AL["Knot Thimblejack"] = "诺特·希姆加克";
	AL["Shen'dralar Provisioner"] = "辛德拉圣职者";
	AL["Namdo Bizzfizzle"] = "纳姆杜";
	AL["The Nameles Prophet"] = "无名预言者";
	AL["Zelemar the Wrathful"] = "愤怒者塞雷玛尔";
	AL["Henry Stern"] = "亨利·斯特恩";
	AL["Aggem Thorncurse"] = "阿格姆";
	AL["Roogug"] = "鲁古格";
	AL["Rajaxx's Captains"] = "拉贾克斯的副官";
	AL["Razorfen Spearhide"] = "剃刀沼泽刺鬃守卫";
	AL["Rethilgore"] = "雷希戈尔";
	AL["Kalldan Felmoon"] = "卡尔丹·暗月";
	AL["Magregan Deepshadow"] = "马格雷甘·深影";
	AL["Lord Ahune"] = "埃霍恩";
	AL["Coren Direbrew"] = "科伦·恐酒";
	AL["Don Carlos"] = "唐·卡洛斯";
	AL["Thomas Yance"] = "托马斯·杨斯";
	AL["Aged Dalaran Wizard"] = "老迈的达拉然巫师";
	AL["Cache of the Legion"] = "军团宝箱";
	AL["Rajaxx's Captains"] = "拉贾克斯的将军们";
	--AL["Felsteed"] = true;
	--AL["Shattered Hand Executioner"] = true;
	--AL["Commander Stoutbeard"] = true; -- Is in BabbleBoss
	--AL["Bjarngrim"] = true; -- Is in BabbleBoss
	--AL["Loken"] = true; -- Is in BabbleBoss
	--AL["Time-Lost Proto Drake"] = true;
	--AL["Faction Champions"] = true; -- if you have a better name, use it.
	--AL["Razzashi Raptor"] = true;
	--AL["Deviate Ravager/Deviate Guardian"] = true;
	--AL["Krick and Ick"]  = true;
	
	--Zones
	AL["World Drop"] = "世界掉落";
	AL["Sunwell Isle"] = "太阳之井";

	--Shortcuts for Bossname files
	AL["LBRS"] = "黑下";
	AL["UBRS"] = "黑上";
	AL["CoT1"] = "救萨尔";
	AL["CoT2"] = "18波";
	AL["Scholo"] = "通灵";
	AL["Strat"] = "斯坦索姆";
	AL["Serpentshrine"] = "毒蛇";
	AL["Avatar"] = "殉难者的化身";

	--Chests, etc
	AL["Dark Coffer"] = "黑暗宝箱";
	AL["The Secret Safe"] = "秘密保险箱";
	AL["The Vault"] = "黑色宝库";
	AL["Ogre Tannin Basket"] = "食人魔鞣酸篮";
	AL["Fengus's Chest"] = "芬古斯的箱子";
	AL["The Prince's Chest"] = "王子的箱子";
	AL["Doan's Strongbox"] = "杜安的保险箱";
	AL["Frostwhisper's Embalming Fluid"] = "莱斯·霜语的防腐液";
	AL["Unforged Rune Covered Breastplate"] = "未铸造的符文覆饰胸甲";
	AL["Malor's Strongbox"] = "玛洛尔的保险箱";
	AL["Unfinished Painting"] = "未完成的油画";
	AL["Felvine Shard"] = "魔藤碎片";
	AL["Baelog's Chest"] = "巴尔洛戈的箱子";
	AL["Lorgalis Manuscript"] = "洛迦里斯手稿";
	AL["Fathom Core"] = "深渊之核";
	AL["Conspicuous Urn"] = "显眼的石罐";
	AL["Gift of Adoration"] = "爱慕的礼物";
	AL["Box of Chocolates"] = "一盒巧克力";
	AL["Treat Bag"] = "糖果包";
	AL["Gaily Wrapped Present"] = "微微震动的礼物";
	AL["Festive Gift"] = "节日礼物";
	AL["Ticking Present"] = "条纹礼物盒";
	AL["Gently Shaken Gift"] = "精美的礼品";
	AL["Carefully Wrapped Present"] = "精心包裹的礼物";
	AL["Winter Veil Gift"] = "冬幕节礼物";
	AL["Smokywood Pastures Extra-Special Gift"] = "烟林牧场的超级特殊礼物";
	AL["Brightly Colored Egg"] = "复活节彩蛋";
	AL["Lunar Festival Fireworks Pack"] = "春节烟花包";
	AL["Lucky Red Envelope"] = "红包";
	AL["Small Rocket Recipes"] = "小型烟花设计图";
	AL["Large Rocket Recipes"] = "大型烟花设计图";
	AL["Cluster Rocket Recipes"] = "烟花束设计图";
	AL["Large Cluster Rocket Recipes"] = "大型烟花束设计图";
	AL["Timed Reward Chest"] = "限时击杀首领奖励";
	AL["Timed Reward Chest 1"] = "限时击杀首领奖励1";
	AL["Timed Reward Chest 2"] = "限时击杀首领奖励2";
	AL["Timed Reward Chest 3"] = "限时击杀首领奖励3";
	AL["Timed Reward Chest 4"] = "限时击杀首领奖励4";
	AL["The Talon King's Coffer"] = "利爪之王的宝箱";
	AL["Krom Stoutarm's Chest"] = "克罗姆·粗臂的箱子";
	AL["Garrett Family Chest"] = "加勒特的宝箱";
	AL["Reinforced Fel Iron Chest"] = "强化魔铁箱";
	AL["DM North Tribute Chest"] = "厄运之槌北区贡品";
	AL["The Saga of Terokk"] = "泰罗克的传说";
	AL["First Fragment Guardian"] = "第一块碎片的守护者";
	AL["Second Fragment Guardian"] = "第二块碎片的守护者";
	AL["Third Fragment Guardian"] = "第三块碎片的守护者";
	AL["Overcharged Manacell"] = "超载的魔法晶格";
	AL["Mysterious Egg"] = "神秘的卵";
	AL["Hyldnir Spoils"] = "海德尼尔礼品";
	AL["Ripe Disgusting Jar"] = "酿好的恶心罐装酒";
	AL["Cracked Egg"] = "破损的蛋壳";
	--AL["Small Spice Bag"] = true;
	--AL["Handful of Candy"] = true;
	--AL["Lovely Dress Box"] = true;
	--AL["Dinner Suit Box"] = true;
	--AL["Bag of Heart Candies"] = true;

	--The next 4 lines are the tooltip for the Server Query Button
	--The translation doesn't have to be literal, just re-write the
	--sentences as you would naturally and break them up into 4 roughly
	--equal lines.
	AL["Queries the server for all items"] = "向服务器查询本页";
	AL["on this page. The items will be"] = "中的所有物品链接";
	AL["refreshed when you next mouse"] = "物品将会在鼠标";
	AL["over them."] = "下次滑过时刷新";
	AL["The Minimap Button is generated by the FuBar Plugin."] = "小地图按钮是由FuBar插件生成的";
	AL["This is automatic, you do not need FuBar installed."] = "这是自动的，你不需要安装FuBar插件";

	--Help Frame
	AL["Help"] = "帮助";
	AL["AtlasLoot Help"] = "AtlasLoot帮助";
	AL["For further help, see our website and forums: "] = "要获得更多的帮助，请访问我们的网站和论坛：";
	AL["How to open the standalone Loot Browser:"] = "单独打开掉落浏览器的方法：";
	AL["If you have AtlasLootFu enabled, click the minimap button, or alternatively a button generated by a mod like Titan or FuBar.  Finally, you can type '/al' in the chat window."] = "如果你启用了AtlasLootFu，点击小地图按钮，或者由类似Titan或者FuBar的插件生成的按钮。再或者你可以在聊天框里输入“/al”";
	AL["How to view an 'unsafe' item:"] = "查看“不安全”的物品的方法：";
	AL["Unsafe items have a red border around the icon and are marked because you have not seen the item since the last patch or server restart. Right-click the item, then move your mouse back over the item or click the 'Query Server' button at the bottom of the loot page."] = "带红框的物品为“不安全物品”，意为自从上次打补丁或者服务器重启以来你没在游戏内见过该物品。你可以通过右击该物品或者点击页面下方的“向服务器查询”按钮来向服务器请求查询。";
	AL["How to view an item in the Dressing Room:"] = "在试衣间查看物品的方法：";
	AL["Simply Ctrl+Left Click on the item.  Sometimes the dressing room window is hidden behind the Atlas or AtlasLoot windows, so if nothing seems to happen move your Atlas or AtlasLoot windows and see if anything is hidden."] = "只需要Ctrl+左键点在物品上即可，如果没反应，挪动下Atlas或者AtlasLoot窗口看看是不是试衣间被挡住了。";
	AL["How to link an item to someone else:"] = "给其他人链接物品的方法：";
	AL["Shift+Left Click the item like you would for any other in-game item"] = "跟你链接游戏里其他物品一样，只需要Shift+左键即可";
	AL["How to add an item to the wishlist:"] = "将物品添加到需求表的方法：";
	AL["Alt+Left Click any item to add it to the wishlist."] = "Alt+左键点击可以把物品添加到需求表";
	AL["How to delete an item from the wishlist:"] = "从需求表中删除物品的方法：";
	AL["While on the wishlist screen, just Alt+Left Click on an item to delete it."] = "当处于需求表页面时，Alt+左键点击物品即可";
	AL["What else does the wishlist do?"] = "需求表还能干嘛？";
	AL["If you Left Click any item on the wishlist, you can jump to the loot page the item comes from.  Also, on a loot page any item already in your wishlist is marked with a yellow star."] = "点击需求表上的任意物品可以跳到该物品的来源页面。还有，在需求表中的物品，也会在它们的来源页面上有一个星号标记。";
	AL["HELP!! I have broken the mod somehow!"] = "救命！我貌似搞坏了插件……";
	AL["Use the reset buttons available in the options menu, or type '/al reset' in your chat window."] = "可以点击选项窗口里的相应按钮，或者在聊天框里输入“/al reset”";

	--Error Messages and warnings
	AL["AtlasLoot Error!"] = "AtlasLoot 发生错误！";
	AL["WishList Full!"] = "装备需求表已满！";
	AL[" added to the WishList."] = " 被添加到装备需求表";
	AL[" already in the WishList!"] = " 已经在装备需求表里了";
	AL[" deleted from the WishList."] = " 已从装备需求表删除";
	AL["No match found for"] = "未找到物品";
	AL[" is safe."] = "的连接是安全的。";
	AL["Server queried for "] = "已向服务器申请查询";
	AL[".  Right click on any other item to refresh the loot page."] = "。右键点击其他物品可刷新物品列表。";

	--Incomplete Table Registry error message
	AL[" not listed in loot table registry, please report this message to the AtlasLoot forums at http://www.atlasloot.net"] = "没有被列出，请将该错误信息发送到 AtlasLoot 官方论坛：http://www.atlasloot.net。";

	--LoD Module disabled or missing
	AL[" is unavailable, the following load on demand module is required: "] = "不可用，需要以下需求时载入型模块：";

	--LoD Module load sequence could not be completed
	AL["Status of the following module could not be determined: "] = "以下模块的类型不可被确定：";

	--LoD Module required has loaded, but loot table is missing
	AL[" could not be accessed, the following module may be out of date: "] = "无法进行操作，以下模块可能已过期：";

	--LoD module not defined
	AL["Loot module returned as nil!"] = "掉落模块不存在";

	--LoD module loaded successfully
	AL["sucessfully loaded."] = "已成功载入";

	--Need a big dataset for searching
	AL["Loading available tables for searching"] = "在已载入的物品数据中进行搜索";

	--All Available modules loaded
	AL["All Available Modules Loaded"] = "所有可用数据模块已载入";
	
	--First time user
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."] = "欢迎使用 Atlasloot Enhanced，请花少许时间进行参数设置";
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences for tooltips and links in the chat window.\n\n  This options screen can be reached again at any later time by typing '/atlasloot'."] = "欢迎使用 Atlasloot Enhanced。请花少许时间进来设置提示与物品连接的方式。\n\n  以后可以输入“/atlasloot”再次显示该设置窗口。";
	AL["Setup"] = "设置";

	--Old Atlas Detected
	AL["It has been detected that your version of Atlas does not match the version that Atlasloot is tuned for ("] = "AtlasLoot 检测到您正在使用的 Atlas 插件的版本与 AtlasLoot 需要的版本（";
	AL[").  Depending on changes, there may be the occasional error, so please visit http://www.atlasmod.com as soon as possible to update."] = "）不符。该情况下可能会频繁出现插件错误信息。鉴于此，请您立刻访问 http://www.atlasmod.com 或 http://www.dreamgen.cn 更新您的 Atlas 版本。";
	AL["OK"] = "确定";
	AL["Incompatible Atlas Detected"] = "检测到不兼容的 Atlas";

	--Unsafe item tooltip
	AL["Unsafe Item"] = "不安全的物品";
	AL["Item Unavailable"] = "物品不可用";
	AL["ItemID:"] = "itemID: ";
	AL["This item is not available on your server or your battlegroup yet."] = "该物品尚未在你所在的服务器或战场组中出现。";
	AL["This item is unsafe.  To view this item without the risk of disconnection, you need to have first seen it in the game world. This is a restriction enforced by Blizzard since Patch 1.10."] = "该物品连接不安全。若想得知此物品的属性又想避免掉线问题，您需要在游戏内见过一次该物品。这是暴雪在1.10版本中做出的强制性改动。";
	AL["You can right-click to attempt to query the server.  You may be disconnected."] = "您可以右键点击该物品以向服务器查询，但这样做有可能会与服务器断开连接。";

end
