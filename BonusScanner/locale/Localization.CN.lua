-- Chinese simplified translated by yeachan.
local L = LibStub("AceLocale-3.0"):NewLocale("BonusScanner","zhCN")
if not L then return end
-- bonus names
L["BONUSSCANNER_NAMES"] = {
--Base Stats
	STR     = "力量",
	AGI 		= "敏捷",
	STA 		= "耐力",
	INT 		= "智力",
	SPI 		= "精神",
	ARMOR   	= "护甲",

--Resistances
	ARCANERES = "奥术抗性",	
	FIRERES 	= "火焰抗性",
	NATURERES = "自然抗性",
	FROSTRES 	= "冰霜抗性",
	SHADOWRES = "暗影抗性",

--Skills
	FISHING 	= "钓鱼",
	MINING 		= "采矿",
	HERBALISM = "草药学",
	SKINNING 	= "剥皮",
	DEFENSE 	= "防御等级",
	EXPERTISE = "精准等级",
	
--Abilities
	BLOCK		= "盾牌格挡等级",
	BLOCKVALUE	= "格挡值",
	DODGE 		= "躲闪等级",
	PARRY 		= "招架等级",
	RESILIENCE = "韧性等级", 
	DMGWPN = "提高近战伤害", 
	RANGEDDMG = "远程武器伤害",
	ARMORPEN = "护甲穿透等级",

-- DPS
	DPSMAIN = "主武器 DPS",
	DPSRANGED = "远程武器 DPS",
	DPSTHROWN = "投掷武器 DPS",

--Attack Power
	ATTACKPOWER	= "攻击强度",
	ATTACKPOWERUNDEAD	= "对亡灵攻击强度",
	ATTACKPOWERFERAL	= "野性形态攻击强度",
	RANGEDATTACKPOWER = "远程攻击强度",
	
--Critical
	CRIT 		= "爆击等级",	
	RANGEDCRIT 	= "远程爆击等级",
	--HOLYCRIT 	= "神圣爆击等级", -- Investigation

--Hit
	TOHIT 		= "命中等级",
	RANGEDHIT	= "远程命中等级",	
  
--Haste
	HASTE = "急速等级",

--Spell Damage/healing
	DMGUNDEAD	= "对亡灵法术强度",
	ARCANEDMG 	= "奥术伤害",
	FIREDMG 	= "火焰伤害",
	FROSTDMG 	= "冰霜伤害",
	HOLYDMG 	= "神圣伤害",
	NATUREDMG 	= "自然伤害",
	SHADOWDMG 	= "暗影伤害",
	SPELLPEN 	= "法术穿透",
  SPELLPOW = "法术强度", 

--Regen
	HEALTHREG 	= "生命值回复",
	MANAREG 	= "法力回复",

--Health/mana
	HEALTH = "生命值",
	MANA = "法力值",
	
--Extra bonuses
  THREATREDUCTION = "% 减少威胁",
  THREATINCREASE = "% 提高威胁",
  INCRCRITDMG = "% 提高爆击伤害",
  SPELLREFLECT = "% 法术反射",
  STUNRESIST = "% 抵抗昏迷",
  PERCINT = "% 提高智力",
  PERCBLOCKVALUE = "% 盾牌格挡值",
 
-- WOTLK Metagems
  PERCARMOR = "% 提高由物品获得的护甲值",
  PERCMANA ="% 提高法力值",
  PERCREDSPELLDMG = "% 降低受到的法术伤害",
  PERCSNARE = "% 减少诱捕/缠绕时间",
  PERCSILENCE = "% 减少沉默时间",
  PERCFEAR = "% 减少恐惧时间",
  PERCSTUN = "% 减少昏迷时间",
  PERCCRITHEALING = "% 提高治疗爆击",  
};

-- equip and set bonus prefixes:
--L["BONUSSCANNER_PREFIX_EQUIP"] = "装备: "; --no longer used but kept in case Blizzard decides to alter its own global string referring to this
L["BONUSSCANNER_PREFIX_SET"] = "套装：";
L["BONUSSCANNER_PREFIX_SOCKET"] = "镶孔奖励：";
L["BONUSSCANNER_WEAPON_SPEED"] = "速度";
-- translation needed !
L["BONUSCANNER_GEM_STRINGS"] = {
	-- red
	["matches a red socket"] = { red = 1, yellow = 0, blue = 0, prismatic = 0},
	-- blue
	["matches a blue socket"] = { red = 0, yellow = 0, blue = 1, prismatic = 0},
	-- yellow
	["matches a yellow socket"] = { red = 0, yellow = 1, blue = 0, prismatic = 0},
	-- purple
	["matches a red or blue socket"] = { red = 1, yellow = 0, blue = 1, prismatic = 0},
	["matches a blue or red socket"] = { red = 1, yellow = 0, blue = 1, prismatic = 0},
	-- green
	["matches a blue or yellow socket"] = { red = 0, yellow = 1, blue = 1, prismatic = 0},
	["matches a yellow or blue socket"] = { red = 0, yellow = 1, blue = 1, prismatic = 0},
	-- orange
	["matches a red or yellow socket"] = { red = 1, yellow = 1, blue = 0, prismatic = 0},
	["matches a yellow or red socket"] = { red = 1, yellow = 1, blue = 0, prismatic = 0},
	-- prismatic
	["matches any socket"] = { red = 0, yellow = 0, blue = 0, prismatic = 1},
	["matches a red, yellow or blue socket"] = { red = 0, yellow = 0, blue = 0, prismatic = 1}
}

-- Enchant separators
L["BONUSSCANNER_GLOBAL_SEP"] = "+";
L["BONUSSCANNER_SEPARATORS"] = { "/", "，", "，", "，" };

-- passive bonus patterns. checked against lines which start with above prefixes
L["BONUSSCANNER_PATTERNS_PASSIVE"] = {
--Skills
	{ pattern = "防御等级提高(%d+)。", effect = "DEFENSE" }, --jmlsteele
  { pattern = "韧性等级提高(%d+)。", effect = "RESILIENCE" }, 
  { pattern = "使你的精准等级提高(%d+)。", effect = "EXPERTISE" },
  { pattern = "钓鱼技能提高(%d+)点。", effect = "FISHING" }, -- fishing poles

-- Abilities
	{ pattern = "使你的格挡等级提高(%d+)。", effect = "BLOCK" },
	{ pattern = "使你的盾牌格挡等级提高(%d+)。", effect = "BLOCK" },
	{ pattern = "使你的盾牌格挡值提高(%d+)点。", effect = "BLOCKVALUE" },
	{ pattern = "使你的躲闪等级提高(%d+)。", effect = "DODGE" },
	{ pattern = "使你的招架等级提高(%d+)。", effect = "PARRY" },
	{ pattern = "%+(%d+)武器伤害。", effect = "DMGWPN" }, -- Might of Cenarius...

--Crit
	{ pattern = "使你的爆击等级提高(%d+)%。", effect = "CRIT" },
	{ pattern = "爆击等级提高(%d+)%。", effect = "CRIT" }, 
	{ pattern = "提高近战爆击等级(%d+)%。", effect = "CRIT" },
	{ pattern = "使你的远程攻击爆击等级提高(%d+)%。", effect = "RANGEDCRIT" },
	
--Damage/Heal/Spell Power
  { pattern = "法术强度提高(%d+)%点。", effect = "SPELLPOW" }, 
  { pattern = "使你的法术强度提高(%d+)%点。", effect = "SPELLPOW" }, 
  { pattern = "暗影法术强度提高(%d+)点。", effect = "SHADOWDMG" }, 
  { pattern = "奥术法术强度提高(%d+)点。", effect = "ARCANEDMG" }, 
  { pattern = "火焰法术强度提高(%d+)点。", effect = "FIREDMG" }, 
  { pattern = "冰霜法术强度提高(%d+)点。", effect = "FROSTDMG" }, 
  { pattern = "神圣法术强度提高(%d+)点。", effect = "HOLYDMG" }, 
  { pattern = "自然法术强度提高(%d+)点。", effect = "NATUREDMG" },
	{ pattern = "略微提高法术强度。", effect = "SPELLPOW", value = 6 },
	{ pattern = "对亡灵的法术强度提高(%d+)点", effect = "DMGUNDEAD" },
	
	-- Multibonus Equip patterns
	{ pattern = "使周围半径%d+码范围内的所有小队成员的法术强度提高(%d+)点。", effect = "SPELLPOW" },	
	{ pattern = "使你宠物的抗性提高130点并提高你的法术强度(%d+)点。", effect = "SPELLPOW" }, -- Void Star Talisman
	--{ pattern = "Increases healing done by up to (%d+) and damage done by up to (%d+) for all magical spells and effects%.", effect = {"HEAL","DMG"} },
	--{ pattern = "Increases your spell damage by up to (%d+) and your healing by up to (%d+)%.", effect = {"DMG","HEAL"} },
	--{ pattern = "Increases healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%. ", effect = "HEAL" },
	--{ pattern = "Increases damage and healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%.", effect = {"HEAL", "DMG"} },
	{ pattern = "使周围半径%d+码范围内的所有小队成员每5秒恢复(%d+)点法力值。", effect = "MANAREG" },
	{ pattern = "使周围半径%d+码范围内的所有小队成员的法术爆击等级提高(%d+)%。", effect = "CRIT" }, --SPELLCRIT
	{ pattern = "使防御等级提高(%d+)点，暗影抗性提高(%d+)点和生命力恢复速度提高(%d+)。", effect = {"DEFENSE", "SHADOWRES", "HEALTHREG"} },  --more info needed
	
--Attack power
	{ pattern = "攻击强度提高(%d+)点。", effect = "ATTACKPOWER" },
	{ pattern = "使你的近战和远程攻击强度提高(%d+)点。", effect = {"ATTACKPOWER","RANGEDATTACKPOWER"} }, -- Andonisus, Reaper of Souls pattern
	{ pattern = "+(%d+)点远程攻击强度。", effect = "RANGEDATTACKPOWER" },
	{ pattern = "远程攻击强度提高(%d+)点。", effect = "RANGEDATTACKPOWER" },
  { pattern = "在猎豹、熊、巨熊和枭兽形态下的攻击强度提高(%d+)点。", effect = "ATTACKPOWERFERAL" },
  { pattern = "与亡灵作战时的攻击强度提高(%d+)点。", effect = "ATTACKPOWERUNDEAD" },
  { pattern = "与亡灵作战时的攻击强度提高(%d+)点。", effect = "ATTACKPOWERUNDEAD" },
  
--Regen
	{ pattern = "每5秒恢复(%d+)点生命值。", effect = "HEALTHREG" }, 
	{ pattern = "每5秒恢复(%d+)点生命值。", effect = "HEALTHREG" },  -- both versions ('per' and 'every') seem to be used
	{ pattern = "每5秒恢复(%d+)点法力值。", effect = "MANAREG" },
	{ pattern = "每5秒恢复(%d+)点法力值。", effect = "MANAREG" },
	
--Hit
	{ pattern = "使你的命中等级提高(%d+)。", effect = "TOHIT" },
	{ pattern = "命中等级提高(%d+)。", effect = "TOHIT" }, 	
	
--Haste
	{ pattern = "急速等级提高(%d+)。", effect = "HASTE" },
		
--Penetration
--{ pattern = "Decreases the magical resistances of your spell targets by (%d+)。", effect = "SPELLPEN" }, --no need
	{ pattern = "使你的法术穿透提高(%d+)。", effect = "SPELLPEN" },	
	{ pattern = "使你的护甲穿透提高(%d+)。", effect = "ARMORPEN" },
	{ pattern = "护甲穿透等级提高(%d+)。", effect = "ARMORPEN" }	
};

-- generic patterns have the form "+xx bonus" or "bonus +xx" or even "xx bonus" with an optional % sign after the value.

-- first the generic bonus string is looked up in the following table
L["BONUSSCANNER_PATTERNS_GENERIC_LOOKUP"] = {
	["所有属性"] 			= {"STR", "AGI", "STA", "INT", "SPI"},
--["to All Stats"] 			= {"STR", "AGI", "STA", "INT", "SPI"},
	["力量"]			= "STR",
	["敏捷"]			= "AGI",
	["耐力"]			= "STA",
	["智力"]			= "INT",
	["精神"] 			= "SPI",

	["所有抗性"] 	= { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}, -- obsidian items id:22195
	["所有魔法抗性"] 	= { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}, -- prismatic gems

	["钓鱼"]		= "FISHING",
	["鱼饵"]	= "FISHING",
	["使钓鱼技能提高"]	= "FISHING", --LibStatLogic-1.1
	["点钓鱼技能"]	= "FISHING",	
	["采矿"]		= "MINING",
	["草药学"]		= "HERBALISM",
	["剥皮"]		= "SKINNING",
	["防御"]		= "DEFENSE",
	["增加防御"]	= "DEFENSE", --LibStatLogic-1.1

	["攻击强度"] 	= "ATTACKPOWER",
  ["与亡灵作战时的攻击强度"] 		= "ATTACKPOWERUNDEAD",
  ["与亡灵和恶魔作战时的攻击强度"] = "ATTACKPOWERUNDEAD", --deamon needed
	["在猎豹、熊、巨熊和枭兽形态下的攻击强度"] = "ATTACKPOWERFERAL",
	["武器伤害"] = "DMGWPN",
	
	-- TBC/Wotlk Patterns Generic/Gems/Sockets
	
	["法术强度"] = "SPELLPOW",
	["爆击等级"] = "CRIT",
--["爆击等级"] = "CRIT",
--["爆击等级"] = "CRIT",
--["爆击等级"] = "CRIT",
	["远程爆击等级"] = "RANGEDCRIT",
	["法术穿透"] = "SPELLPEN",
	["护甲穿透等级"] = "ARMORPEN",	
	["防御等级"] = "DEFENSE",
	["急速等级"] = "HASTE",
	["每5秒法力"] = "MANAREG",
	["每5秒法力"] = "MANAREG",
	["每5秒法力"] = "MANAREG",
	["每5秒法力"] = "MANAREG",
	["每5秒法力"] = "MANAREG",
	["每5秒法力"] = "MANAREG",
	["每5秒法力"] = "MANAREG",
	["每5秒法力"] = "MANAREG",
	["每5秒法力"] = "MANAREG",
	["躲闪等级"] 		= "DODGE",
	["招架等级"] 		= "PARRY",
	["韧性等级"] = "RESILIENCE",
	["近战伤害"] = "DMGWPN",
	["精准等级"] = "EXPERTISE",
	
	-- End TBC Patterns
	
	["躲闪"] 		= "DODGE",
	["格挡"]		= "BLOCKVALUE",
	["格挡值"]		= "BLOCKVALUE",
	["格挡等级"]		= "BLOCK",
	["盾牌格挡"]		= "BLOCK",
	["命中"] 		= "TOHIT",
	["命中等级"] = "TOHIT",	
	["远程命中等级"] = "RANGEDHIT",
	["远程攻击强度"]	= "RANGEDATTACKPOWER",
	["远程攻击强度"]	= "RANGEDATTACKPOWER", -- Experimental for TBC
	["每5秒生命值"]	= "HEALTHREG",
	["每5秒生命值"]	= "HEALTHREG",
	["治疗"] = "HEAL",
  ["治疗法术"] 	= "HEAL",   --no need
  ["提高治疗效果"] 	= "HEAL",  --no need
  ["每5秒法力"] 	= "MANAREG",
	["法力回复"]		= "MANAREG",
	["爆击"]		= "CRIT",
--["Critical Hit"]	= "CRIT",
	["生命值"]		= "HEALTH",
	["生命值"]			= "HEALTH",
	["法力值"]		= "MANA",
	["护甲"]		= "ARMOR",
	["加固"]	= "ARMOR",
	["韧性"]			= "RESILIENCE",
	
	-- Patterns for color coded/special lines
	
	["威胁"] = "THREATREDUCTION", --not sure
	["爆击伤害"] = "INCRCRITDMG",
	["法术反射"] = "SPELLREFLECT",
  ["抵抗昏迷"] = "STUNRESIST",
--["Stun Resist"] = "STUNRESIST",
	["赌牌格挡值"] = "PERCBLOCKVALUE",
	["由物品获得的护甲值提高"] = "PERCARMOR",
	["受到的法术伤害降低"] = "PERCREDSPELLDMG",	
	["沉默时间"] = "PERCSILENCE",
	["恐惧时间"] = "PERCFEAR",
	["昏迷时间"] = "PERCSTUN",
	["诱捕时间"] = "PERCSNARE",
	["治疗爆击效果提高"] = "PERCCRITHEALING",
};	

-- next we try to match against one pattern of stage 1 and one pattern of stage 2 and concatenate the effect strings
L["BONUSSCANNER_PATTERNS_GENERIC_STAGE1"] = {
	{ pattern = "奥术", 	effect = "ARCANE" },	
	{ pattern = "火焰", 	effect = "FIRE" },	
	{ pattern = "冰霜", 	effect = "FROST" },	
	{ pattern = "神圣", 	effect = "HOLY" },	
	{ pattern = "暗影",	effect = "SHADOW" },	
	{ pattern = "自然", 	effect = "NATURE" }
}; 	

L["BONUSSCANNER_PATTERNS_GENERIC_STAGE2"] = {
	{ pattern = "抗性", 	effect = "RES" },	
	{ pattern = "伤害", 	effect = "DMG" },
	{ pattern = "效果", 	effect = "DMG" }
}; 	

-- finally if we got no match, we match against some special enchantment patterns.
L["BONUSSCANNER_PATTERNS_OTHER"] = {
-- Infused Amethyst
	{ pattern = "%+(%d+) 法术强度，%+(%d+) 耐力", effect = {"SPELLPOW", "STA"} },
	
-- special patterns that cannot be handled any other way
  { pattern = "%+21 爆击等级，%+2%% 法力值", effect = {"CRIT", "PERCMANA"}, value = {21, 2} }, --no need
  { pattern = "%+12 爆击等级，%-10% 诱捕/缠绕时间", effect = {"CRIT", "PERCSNARE"}, value = {12, 10} },
	{ pattern = "%+21 爆击等级，%-15%%诱捕/缠绕时间", effect = {"CRIT", "PERCSNARE"}, value = {21, 15} },
	{ pattern = "%+14 法术强度，%+2%% 智力", effect = {"SPELLPOW", "PERCINT"}, value = {14, 2} },
	{ pattern = "%+25 法术强度，%+2%% 智力", effect = {"SPELLPOW", "PERCINT"}, value = {25, 2} },	
	{ pattern = "%+18 耐力，%-15%% 昏迷时间", effect = {"STA", "PERCSTUN"}, value = {18, 15} },
  { pattern = "%+18 法术强度，每5秒法力回复%+4", effect = {"SPELLPOW", "MANAREG"}, value = {18, 4} }, -- which gem？
  { pattern = "%+24 法术强度，每5秒法力回复%+6", effect = {"SPELLPOW", "MANAREG"}, value = {24, 6} },
  { pattern = "%+61 法术强度，每5秒法力回复%+6", effect = {"SPELLPOW", "MANAREG"}, value = {61, 6} },
  { pattern = "%+2%% 威胁，%+10 招架等级", effect = {"THREATINCREASE","PARRY"}, value = {2 , 10} },
	
-- rest of custom patterns
  { pattern = "在猎豹、熊、巨熊和枭兽形态下的攻击强度提高(%d+)点。", effect = "ATTACKPOWERFERAL" },
	{ pattern = "每5秒恢复(%d+)点法力值", effect = "MANAREG" },
	{ pattern = "%+(%d+)护甲", effect = "ARMOR" },
	{ pattern = "%+(%d+)%%威胁", effect = "THREATINCREASE" },
	{ pattern = "瞄准镜%（%+(%d+) 爆击等级%）", effect = "CRIT" },
	{ pattern = "瞄准镜%（%+(%d+) 伤害%）", effect = "RANGEDDMG" },
};

-- localized strings
L["BONUSSCANNER_BONUSSUM_LABEL"] = "装备加成统计";
L["BONUSSCANNER_TOOLTIP_STRING"] = "BonusScanner统计提示信息";
L["BONUSSCANNER_TOOLTIPGEMS_STRING"] = "宝石颜色统计";
L["BONUSSCANNER_BASICLINKID_STRING"] = "基础的物品链接ID";
L["BONUSSCANNER_EXTENDEDLINKID_STRING"] = "扩展的物品链接ID";
L["BONUSSCANNER_TOOLTIP_ENABLED"] = "启用";
L["BONUSSCANNER_TOOLTIP_DISABLED"] = "禁用";
L["BONUSSCANNER_IBONUS_LABEL"] = "物品加成";
L["BONUSSCANNER_NOBONUS_LABEL"] = "没有任何加成.";
L["BONUSSCANNER_CUREQ_LABEL"] = "当前装备属性加成";
L["BONUSSCANNER_CUREQDET_LABEL"] = "当前详细的装备属性加成";
L["BONUSSCANNER_OOR_LABEL"] = "超出距离.";
L["BONUSSCANNER_GEMCOUNT_LABEL"] = "数量";
L["BONUSSCANNER_INVALIDTAR_LABEL"] = "目标无法统计.";
L["BONUSSCANNER_SELTAR_LABEL"] = "请先选一个目标.";
L["BONUSSCANNER_SLOT_LABEL"] = "插槽";
L["BONUSSCANNER_FAILEDPARSE_LABEL"] = "物品未被缓存或者服务器尚未出现.";
L["BONUSSCANNER_CACHESUMMARY_LABEL"] = "BonusScanner物品缓存: ";
L["BONUSSCANNER_CACHECLEAR_LABEL"] = "BonusScanner物品缓存已清除.";
L["BONUSSCANNER_SPECIAL1_LABEL"] = " 爆击率";
L["BONUSSCANNER_SPECIAL2_LABEL"] = " 躲闪/招架";
L["BONUSSCANNER_SPECIAL3_LABEL"] = " 近战";
L["BONUSSCANNER_SPECIAL4_LABEL"] = " 法术";
L["BONUSSCANNER_SPECIAL5_LABEL"] = " 远程/法术";
L["BONUSSCANNER_ITEMID_LABEL"] = "物品 ID: |cffffffff";
L["BONUSSCANNER_ILVL_LABEL"] = "物品等级: |cffffffff";
L["BONUSSCANNER_ENCHANTID_LABEL"] = "附魔 ID: |cffffffff";
L["BONUSSCANNER_GEM1ID_LABEL"] = "宝石1 ID: |cffffffff";
L["BONUSSCANNER_GEM2ID_LABEL"] = "宝石2 ID: |cffffffff";
L["BONUSSCANNER_GEM3ID_LABEL"] = "宝石3 ID: |cffffffff";
L["BONUSSCANNER_GEMRED_LABEL"] = "红";
L["BONUSSCANNER_GEMBLUE_LABEL"] = "蓝";
L["BONUSSCANNER_GEMYELLOW_LABEL"] = "黄";
L["BONUSSCANNER_GEMPRISM_LABEL"] = "Prismatic";
L["BONUSSCANNER_AVERAGE_ILVL_LABEL"] = "平均物品等级";
L["BONUSSCANNER_NEEDS_RELOADUI_LABEL"] = "更改会在插件重载后生效.";
L["BONUSSCANNER_LDB_PLUGIN_LABEL"] = "BonusScanner LDB 模块 ";
--bonus categories
L["BONUSSCANNER_CAT_ATT"] = "属性";
L["BONUSSCANNER_CAT_RES"] = "抗性";
L["BONUSSCANNER_CAT_SKILL"] = "技能";
L["BONUSSCANNER_CAT_BON"] = "近战/远程攻击";
L["BONUSSCANNER_CAT_SBON"] = "法术";
L["BONUSSCANNER_CAT_OBON"] = "生命和法力值";
L["BONUSSCANNER_CAT_EBON"] = "特殊加成";
L["BONUSSCANNER_CAT_GEMS"] = "宝石插槽";
--slash command text
L["BONUSSCANNER_SLASH_STRING1"] = GREEN_FONT_COLOR_CODE.."BonusScanner 物品加成统计";
L["BONUSSCANNER_SLASH_STRING1a"] = "|cffffffff 作者 Crowley, Archarodim, jmsteele, Tristanian";
L["BONUSSCANNER_SLASH_STRING2"] = LIGHTYELLOW_FONT_COLOR_CODE.."用法: |cffffffff/bscan {show | details | tooltip | tooltip gems | itembasic | itemextend | broker | clearcache | target | target <player> | <itemlink> | <itemlink> <player> | <slotname>}";
L["BONUSSCANNER_SLASH_STRING3"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."show: |cffffffff显示当前装备的所有加成统计.";
L["BONUSSCANNER_SLASH_STRING4"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."details: |cffffffff显示详细的各类统计.";
L["BONUSSCANNER_SLASH_STRING5"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."tooltip: [";
L["BONUSSCANNER_SLASH_STRING5a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffff在提示上显示加成.";
L["BONUSSCANNER_SLASH_STRING14"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."tooltip gems: [";
L["BONUSSCANNER_SLASH_STRING14a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffff在提示上显示宝石颜色.";
L["BONUSSCANNER_SLASH_STRING12"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."itembasic: [";
L["BONUSSCANNER_SLASH_STRING12a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffff在提示上显示物品的ID和等级.";
L["BONUSSCANNER_SLASH_STRING13"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."itemextend: [";
L["BONUSSCANNER_SLASH_STRING13a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffff在提示上显示物品的附魔和宝石ID.";
L["BONUSSCANNER_SLASH_STRING15"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."broker: [";
L["BONUSSCANNER_SLASH_STRING15a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffff 控制 LDB 插件的状态，其用来显示角色的统计信息.";
L["BONUSSCANNER_SLASH_STRING11"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."clearcache: |cffffffff清除缓存.";
L["BONUSSCANNER_SLASH_STRING6"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."target: |cffffffff显示你目标的加成统计(必须在距离内).";
L["BONUSSCANNER_SLASH_STRING7"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."target <player>: |cffffffff把你当前目标的加成数据密语给指定人.";
L["BONUSSCANNER_SLASH_STRING8"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<itemlink>: |cffffffff显示链接物品的加成(用Shift-Click插入链接).";
L["BONUSSCANNER_SLASH_STRING9"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<itemlink> <player>: |cffffffff把你当前链接的加成数据密语给指定人.";
L["BONUSSCANNER_SLASH_STRING10"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<slotname>: |cffffffff显示指定类别的加成统计.";