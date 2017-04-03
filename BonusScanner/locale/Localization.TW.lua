--Chinese traditional translated by Juha.
local L = LibStub("AceLocale-3.0"):NewLocale("BonusScanner","zhTW")
if not L then return end
-- bonus names
L["BONUSSCANNER_NAMES"] = {
--Base Stats
	STR 		= "力量",
	AGI 		= "敏捷",
	STA 		= "耐力",
	INT 		= "智力",
	SPI 		= "精神",
	ARMOR 		= "護甲",

--Resistances
	ARCANERES 	= "秘法抗性",	
	FIRERES 	= "火焰抗性",
	NATURERES 	= "自然抗性",
	FROSTRES 	= "冰霜抗性",
	SHADOWRES 	= "暗影抗性",

--SKills
	FISHING 	= "釣魚",
	MINING 		= "採礦",
	HERBALISM 	= "草藥",
	SKINNING 	= "剝皮",
	DEFENSE 	= "防禦",
	EXPERTISE = "熟練等級",
	
--Abilities
	BLOCK 		= "格擋等級",
	BLOCKVALUE	= "格檔值",
	DODGE 		= "閃躲等級",
	PARRY 		= "招架等級",
	RESILIENCE = "韌性等級", 
	DMGWPN = "武器傷害提高", -- Might of Cenarius etc.
	RANGEDDMG = "遠程武器傷害",
	ARMORPEN = "無視護甲",
	
-- DPS
	DPSMAIN = "Main Weapon(s) DPS",
	DPSRANGED = "Ranged Weapon DPS",
	DPSTHROWN = "Thrown Weapon DPS",	
	
--Attack Power
	ATTACKPOWER 		= "攻擊強度",
	ATTACKPOWERUNDEAD	= "對不死生物的攻擊強度",
	ATTACKPOWERFERAL	= "野性形態攻擊強度",
	RANGEDATTACKPOWER 	= "遠程攻擊強度",
	
--Critical
	CRIT 		= "致命等級",
	RANGEDCRIT 	= "遠程致命等級",
	--HOLYCRIT 	= "神聖法術爆擊",  --沒有其他可用的相關參數

--Hit
	TOHIT 		= "命中等級",
	RANGEDHIT	= "遠程命中等級",

--Haste
	HASTE = "加速等級",
	
--Spell Damage/healing
	DMGUNDEAD	= "對不死生物的法術傷害",
	ARCANEDMG 	= "秘法傷害",
	FIREDMG 	= "火焰傷害",
	FROSTDMG 	= "冰霜傷害",
	HOLYDMG 	= "神聖傷害",
	NATUREDMG 	= "自然傷害",
	SHADOWDMG 	= "暗影傷害",
	SPELLPEN 	= "法術穿透力",
  SPELLPOW = "法術能量", 

--Regen
	HEALTHREG 	= "生命力恢復",
	MANAREG 	= "法力恢復",

--Health/mana
	HEALTH 		= "生命力",
	MANA 		= "法力",
	
--Extra bonuses
  THREATREDUCTION = "% 威脅值(降低)",
  THREATINCREASE = "% 威脅值(提高)",
  INCRCRITDMG = "% 致命一擊傷害(提高)",
  SPELLREFLECT = "% 法術反射",
  STUNRESIST = "% 昏迷抗性",
  PERCINT = "% 智力",  --v2.4
  PERCBLOCKVALUE = "% 盾牌格檔值",  --v2.4

-- WOTLK Metagems
  PERCARMOR = "% 裝備提供的護甲值",
  PERCMANA ="% 法力",
  PERCREDSPELLDMG = "% 法術傷害(降低)", 
  PERCSNARE = "% 緩速及定身持續時間縮短",
  PERCSILENCE = "% 沉默持續時間縮短",
  PERCFEAR = "% 恐懼持續時間縮短",
  PERCSTUN = "% 昏迷持續時間縮短",
  PERCCRITHEALING = "% 極效治療效果",  
};

-- equip and set bonus prefixes:
--L["BONUSSCANNER_PREFIX_EQUIP"] = "裝備: "; --no longer used but kept in case Blizzard decides to alter its own global string referring to this
L["BONUSSCANNER_PREFIX_SET"] = "套裝:";
L["BONUSSCANNER_PREFIX_SOCKET"] = "插槽加成:";
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
L["BONUSSCANNER_SEPARATORS"] = { "/", "和", ",", "。", " 持續 ", "&", "及", "並", "，", };

-- passive bonus patterns. checked against lines which start with above prefixes
L["BONUSSCANNER_PATTERNS_PASSIVE"] = {
--Skills
	{ pattern = "使防禦等級提高(%d+)點。",             effect = "DEFENSE" }, --jmlsteele
  { pattern = "使你的韌性等級提高(%d+)點。", effect = "RESILIENCE" }, 
  { pattern = "使你的熟練等級提高(%d+)。", effect = "EXPERTISE" },
  { pattern = "%+(%d+)點釣魚技能。", effect = "FISHING" },

-- Abilities
	{ pattern = "使你的格擋等級提高(%d+)點。", effect = "BLOCK" },
	{ pattern = "提高你的盾牌格擋等級(%d+)點。", effect = "BLOCK" }, 
	{ pattern = "使你盾牌的格擋值提高(%d+)點。", effect = "BLOCKVALUE" },
	{ pattern = "使你的閃躲等級提高(%d+)點。", effect = "DODGE" },
	{ pattern = "使你的招架等級提高(%d+)點。", effect = "PARRY" },
	{ pattern = "%+(%d+)武器傷害", effect = "DMGWPN" },

--Crit
	{ pattern = "使你的致命一擊等級提高(%d+)點。", effect = "CRIT" },
	{ pattern = "提高致命一擊等級(%d+)點。", effect = "CRIT" }, 
	{ pattern = "提高近戰致命一擊等級(%d+)點。", effect = "CRIT" },
	{ pattern = "使你的遠程攻擊致命一擊等級提高(%d+)點。", effect = "RANGEDCRIT" },
		
--Damage/Heal/Spell Power
  { pattern = "提高(%d+)點法術能量。", effect = "SPELLPOW" }, 
  { pattern = "提高法術能量(%d+)點。", effect = "SPELLPOW" }, 
  { pattern = "提高(%d+)點暗影法術能量。", effect = "SHADOWDMG" }, 
  { pattern = "提高(%d+)點秘法法術能量。", effect = "ARCANEDMG" }, 
  { pattern = "提高(%d+)點火焰法術能量。", effect = "FIREDMG" }, 
  { pattern = "提高(%d+)點冰霜法術能量。", effect = "FROSTDMG" }, 
  { pattern = "使神聖法術能量提高(%d+)點。", effect = "HOLYDMG" }, 
  { pattern = "提高(%d+)點自然法術能量。", effect = "NATUREDMG" },
	--{ pattern = "Increases damage and healing done by magical spells and effects slightly%.", effect = {"HEAL", "DMG"}, value = {6, 6} },
	{ pattern = "提高(%d+)點對不死生物的法術能量。", effect = "DMGUNDEAD" },
	
	-- Multibonus Equip patterns
	{ pattern = "使半徑%d+碼範圍內所有小隊成員的法術致命一擊等級提高(%d+)點。", effect = "SPELLPOW" },
    --{ pattern = "使法術和魔法效果所造成的治療效果提高最多(%d+)點，法術傷害提高最多(%d+)點。", effect = {"HEAL", "DMG"} },
	--{ pattern = "使你寵物的抗性提高130點並提高你的法術傷害最多(%d+)點。", effect = "DMG" }, -- Void Star Talisman
	--{ pattern = "使你的法術傷害提高最多(%d+)點，以及你的治療效果最多(%d+)點。", effect = {"DMG","HEAL"} },	-- Atiesh patterns
	--{ pattern = "使周圍半徑%d+碼範圍內隊友的所有法術和魔法效果所造成的治療效果提高最多(%d+)點。", effect = "HEAL" },	-- Atiesh patterns
	--{ pattern = "使周圍半徑%d+碼範圍內隊友的所有法術和魔法效果所造成的傷害和治療效果提高最多(%d+)點。", effect = {"HEAL", "DMG"} },	-- Atiesh patterns
	{ pattern = "使周圍半徑%d+碼範圍內的隊友每5秒恢復(%d+)點法力。", effect = "MANAREG" },	-- Atiesh patterns
	{ pattern = "使半徑%d+碼範圍內所有小隊成員的法術致命一擊等級提高(%d+)點。", effect = "SPELLCRIT" },	-- Atiesh patterns
	{ pattern = "使防禦等級提高(%d+)點，暗影抗性提高(%d+)點和一般的生命力恢復速度提高(%d+)點。", effect = {"DEFENSE", "SHADOWRES", "HEALTHREG"} }, --10779
		
--Attack power
	{ pattern = "提高攻擊強度(%d+)點。", effect = "ATTACKPOWER" },
	{ pattern = "使近戰和遠程攻擊強度提高(%d+)點。", effect = {"ATTACKPOWER","RANGEDATTACKPOWER"} }, -- Andonisus, Reaper of Souls pattern
	{ pattern = "%+(%d+) 遠程攻擊強度。 ", effect = "RANGEDATTACKPOWER" },
    { pattern = "遠程攻擊強度提高(%d+)點。", effect = "RANGEDATTACKPOWER" },
  { pattern = "在獵豹、熊、巨熊和梟獸形態下的攻擊強度提高(%d+)點。", effect = "ATTACKPOWERFERAL" },
  { pattern = "對不死生物的攻擊強度提高(%d+)點。", effect = "ATTACKPOWERUNDEAD" },
  { pattern = "%+(%d+) 對不死生物的攻擊強度", effect = "ATTACKPOWERUNDEAD" },
  
--Regen
	{ pattern = "每5秒恢復(%d+)點生命力。", effect = "HEALTHREG" }, 
--	{ pattern = "Restores (%d+) health every 5 sec%.", effect = "HEALTHREG" },  -- both versions ('per' and 'every') seem to be used
	{ pattern = "每5秒恢復(%d+)點法力。", effect = "MANAREG" },
--	{ pattern = "Restores (%d+) mana every 5 sec%.", effect = "MANAREG" },
	
--Hit
	{ pattern = "使你的命中等級提高(%d+)點。", effect = "TOHIT" },
	{ pattern = "提高命中等級(%d+)點。", effect = "TOHIT" }, 
	
--Haste
	{ pattern = "提高加速等級(%d+)點。", effect = "HASTE" },
		
--Penetration
	{ pattern = "降低你施法目標的魔法抗性(%d+)點。", effect = "SPELLPEN" },
	{ pattern = "使你的法術穿透力提高(%d+)點。", effect = "SPELLPEN" },
	{ pattern = "提高(%d+)點護甲穿透等級。", effect = "ARMORPEN" },
	--{ pattern = "Increases armor penetration rating by (%d+)%.", effect = "ARMORPEN" }	
	
};

-- generic patterns have the form "+xx bonus" or "bonus +xx" or even "xx bonus" with an optional % sign after the value.

-- first the generic bonus string is looked up in the following table
L["BONUSSCANNER_PATTERNS_GENERIC_LOOKUP"] = {
	["所有屬性"] 		= {"STR", "AGI", "STA", "INT", "SPI"},
--	["to All Stats"] 			= {"STR", "AGI", "STA", "INT", "SPI"},
	["力量"]			= "STR",
	["敏捷"]			= "AGI",
	["耐力"]			= "STA",
	["智力"]			= "INT",
	["精神"] 			= "SPI",

	["全部抗性"] 		= { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"},
	["所有抗性"] 		= { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"},
	["抵抗全部"] 		= { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"},
	["點所有魔法抗性"] = { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}, -- [鋸齒黑曜石之盾] ID:22198

	["釣魚"]				= "FISHING",
	["魚餌"]		= "FISHING",
	["點釣魚技能"]	= "FISHING",
	["採礦"]				= "MINING",
	["草藥學"]			= "HERBALISM",
	["剝皮"]			= "SKINNING",
	["防禦"]				= "DEFENSE",
	["防禦等級提高"]	= "DEFENSE",

	["攻擊強度"] 		= "ATTACKPOWER",
--  ["對不死生物的攻擊強度"] 		= "ATTACKPOWERUNDEAD",
	["獵豹、熊、巨熊和梟獸形態下的攻擊強度提高"] = "ATTACKPOWERFERAL",
	["武器傷害"] = "DMGWPN",
	
	-- TBC Patterns Generic/Gems/Sockets
	
	["法術能量"] = "SPELLPOW",
	["致命一擊等級"] = "CRIT",
--	["Critical strike rating"] = "CRIT",
--	["Critical Rating"] = "CRIT",
--	["Crit Rating"] = "CRIT",
	["遠程攻擊致命一擊"] = "RANGEDCRIT",
	["法術穿透力"] = "SPELLPEN",
	["護甲穿透等級"] = "ARMORPEN",	
	["防禦等級"] = "DEFENSE",
	["加速等級"] = "HASTE",
--	["Mana per 5 Seconds"] = "MANAREG",
--	["mana per 5 seconds"] = "MANAREG",
--	["Mana every 5 Sec"] = "MANAREG",
--	["Mana every 5 seconds"] = "MANAREG",
--	["Mana restored per 5 seconds"] = "MANAREG",
--	["Mana Per 5 sec"] = "MANAREG",
--	["mana per 5 sec"] = "MANAREG",
--	["Mana per 5 Sec"] = "MANAREG",
--	["Mana per 5 sec"] = "MANAREG",
	["閃躲等級"] 		= "DODGE",
	["招架等級"] 		= "PARRY",
	["韌性等級"] = "RESILIENCE",
	["點韌性等級"] = "RESILIENCE",
	["物理傷害"] = "DMGWPN",
	["傷害法術"] = "DMG",
	["熟練等級"] = "EXPERTISE",
	
	-- End TBC Patterns

	["躲閃"] 				= "DODGE",
	["格檔"]				= "BLOCKVALUE",
	["格擋值"]		= "BLOCKVALUE",
	["格檔等級"]		= "BLOCK",
--	["Blocking"]		= "BLOCK",
	["命中"] 				= "TOHIT",
	["命中等級"] = "TOHIT",	
	["遠程命中等級"] = "RANGEDHIT",
	["遠程攻擊強度"] = "RANGEDATTACKPOWER",
	["遠程攻擊強度"]	= "RANGEDATTACKPOWER", -- Experimental for TBC
--	["Health per 5 sec"]	= "HEALTHREG",
--	["health every 5 sec"]	= "HEALTHREG",
	["治療"] 		= "HEAL",
	["治療法術"] 	= "HEAL",
	["治療效果"] 	= "HEAL",
	["提高治療效果"] 	= "HEAL",
--	["mana every 5 sec"] 	= "MANAREG",
	["法力恢復"]		= "MANAREG",
	["致命"] 		= "CRIT",
	["致命一擊"] 		= "CRIT",
	["生命力"]		= "HEALTH",
--	["HP"]			= "HEALTH",
	["法力"]		= "MANA",
	["護甲"]		= "ARMOR",
	["護甲值"]		= "ARMOR",
	["強化"]	= "ARMOR",
	["韌性"]			= "RESILIENCE",

	-- Patterns for color coded/special lines
	
	["降低威脅值"] = "THREATREDUCTION",
	["威脅值"] = "THREATREDUCTION",
	["致命一擊傷害"] = "INCRCRITDMG",
	["法術反射"] = "SPELLREFLECT",
	["昏迷抗性"] = "STUNRESIST",
	--["Stun Resist"] = "STUNRESIST",
	["盾牌格擋值"] = "PERCBLOCKVALUE",
	--["Increased Armor Value from Items"] = "PERCARMOR",  --2% Increased Armor Value from Items, 提高2%裝備提供的護甲值
	--["Reduce Spell Damage Taken by"] = "PERCREDSPELLDMG",  --Reduce Spell Damage Taken by 2%, 減少2%法術傷害
	--["Silence Duration Reduced by"] = "PERCSILENCE",  --Silence Duration Reduced by 10%, 縮短10%沉默持續時間
	--["Fear Duration Reduced by"] = "PERCFEAR",  --Fear Duration Reduced by 10%, 縮短10%恐懼持續時間
	--["Stun Duration Reduced by"] = "PERCSTUN",  --Stun Duration Reduced by 10%, 縮短10%昏迷持續時間
	--["Root Duration by"] = "PERCSNARE",  --Reduces Snare/Root Duration by 10%, 縮短10%緩速及定身持續時間
	["極效治療效果"] = "PERCCRITHEALING",
};	

-- next we try to match against one pattern of stage 1 and one pattern of stage 2 and concatenate the effect strings
L["BONUSSCANNER_PATTERNS_GENERIC_STAGE1"] = {
	{ pattern = "秘法", 	effect = "ARCANE" },	
	{ pattern = "火焰", 	effect = "FIRE" },	
	{ pattern = "冰霜", 	effect = "FROST" },	
	{ pattern = "神聖", 	effect = "HOLY" },	
	{ pattern = "暗影",	effect = "SHADOW" },	
	{ pattern = "自然", 	effect = "NATURE" }
}; 	

L["BONUSSCANNER_PATTERNS_GENERIC_STAGE2"] = {
	{ pattern = "抗性", 	effect = "RES" },	
	{ pattern = "傷害", 	effect = "DMG" },
	{ pattern = "效果", 	effect = "DMG" },
}; 	

-- finally if we got no match, we match against some special enchantment patterns.
L["BONUSSCANNER_PATTERNS_OTHER"] = {
-- Infused Amethyst
	--{ pattern = "%+(%d+)法術能量和%+(%d+)耐力", effect = {"SPELLPOW", "STA"} },

-- special patterns that cannot be handled any other way
  { pattern = "%+21致命一擊等級和2%%法力", effect = {"CRIT", "PERCMANA"}, value = {21, 2} },
  --{ pattern = "%+12致命一擊等級和縮短15%%緩速及定身持續時間", effect = {"CRIT", "PERCSNARE"}, value = {12, 15} },
  --{ pattern = "%+21致命一擊等級和縮短15%%緩速及定身持續時間", effect = {"CRIT", "PERCSNARE"}, value = {21, 15} },
  --{ pattern = "%+14法術能量和%+2%%智力", effect = {"SPELLPOW", "PERCINT"}, value = {14, 2} }, 
  --{ pattern = "%+25法術能量和%+2%%智力", effect = {"SPELLPOW", "PERCINT"}, value = {25, 2} },	
  --{ pattern = "%+18耐力和縮短15%%昏迷持續時間", effect = {"STA", "PERCSTUN"}, value = {18, 15} },
  --{ pattern = "%+18法術能量和每5秒恢復4點法力", effect = {"SPELLPOW", "MANAREG"}, value = {18, 4} },
  --{ pattern = "%+24法術能量和每5秒恢復6點法力", effect = {"SPELLPOW", "MANAREG"}, value = {24, 6}  },
  
-- rest of custom patterns
	--{ pattern = "每5秒恢復(%d+)點法力。", effect = "MANAREG" },
	{ pattern = "%+(%d+)強化護甲", effect = "ARMOR" }, --Reinforced (+40 Armor)	+40強化護甲
	{ pattern = "%+(%d+)%%威脅值", effect = "THREATINCREASE" },
	{ pattern = "瞄準鏡%(%+(%d+)致命一擊等級%)", effect = "CRIT" },
	{ pattern = "瞄準鏡%(%+(%d+)傷害%)", effect = "RANGEDDMG" },
	
	--自訂
	{ pattern = "每5秒恢復(%d+)點法力", effect = "MANAREG" },
  { pattern = "%+(%d+)法術能量和%+(%d+)%%智力", effect = {"SPELLPOW", "PERCINT"} },	
  { pattern = "%+(%d+)法術能量和降低(%d+)%%威脅值", effect = {"SPELLPOW", "THREATINCREASE"} },
	{ pattern = "%+(%d+)耐力和提高(%d+)%%裝備提供的護甲值", effect = {"STA", "PERCARMOR"} },
	{ pattern = "%+(%d+)耐力和減少(%d+)%%法術傷害", effect = {"STA", "PERCREDSPELLDMG"} },
	{ pattern = "%+(%d+)法術能量和縮短(%d+)%%沉默持續時間", effect = {"SPELLPOW", "PERCSILENCE"} },
	{ pattern = "%+(%d+)致命一擊等級和縮短(%d+)%%恐懼持續時間", effect = {"CRIT", "PERCFEAR"} },
	{ pattern = "%+(%d+)耐力和縮短(%d+)%%昏迷持續時間", effect = {"STA", "PERCSTUN"} },
	{ pattern = "%+(%d+)攻擊強度和縮短(%d+)%%昏迷持續時間", effect = {"ATTACKPOWER", "PERCSTUN"} },
	{ pattern = "%+(%d+)法術能量和縮短(%d+)%%昏迷持續時間", effect = {"SPELLPOW", "PERCSTUN"} },
	{ pattern = "%+(%d+)致命一擊等級和縮短(%d+)%%緩速及定身持續時間", effect = {"CRIT", "PERCSNARE"} },

	--以下英文已刪除
	{ pattern = "初級巫師之油", effect = {"SPELLPOW"}, value = 8 },
	{ pattern = "次級巫師之油", effect = {"SPELLPOW"}, value = 16 },
	{ pattern = "巫師之油", effect = {"SPELLPOW"}, value = 24 },
	{ pattern = "卓越巫師之油", effect = {"SPELLPOW", "SPELLCRIT"}, value = {36, 14} },
	{ pattern = "超強巫師之油", effect = {"SPELLPOW"}, value = 42 },

	{ pattern = "初級法力之油", effect = "MANAREG", value = 4 },
	{ pattern = "次級法力之油", effect = "MANAREG", value = 8 },
	{ pattern = "卓越法力之油", effect = {"MANAREG", "SPELLPOW"}, value = {12, 25} },
	{ pattern = "超強法力之油", effect = "MANAREG", value = 14 },
};

-- localized strings
L["BONUSSCANNER_BONUSSUM_LABEL"] = "裝備加成統計";
L["BONUSSCANNER_TOOLTIP_STRING"] = "BonusScanner 統計加成提示訊息 ";
L["BONUSSCANNER_TOOLTIPGEMS_STRING"] = "寶石顏色數量 ";
L["BONUSSCANNER_BASICLINKID_STRING"] = "基本 Itemlink ID 的 ";
L["BONUSSCANNER_EXTENDEDLINKID_STRING"] = "延伸 Itemlink ID 的 ";
L["BONUSSCANNER_TOOLTIP_ENABLED"] = "啟用";
L["BONUSSCANNER_TOOLTIP_DISABLED"] = "關閉";
L["BONUSSCANNER_IBONUS_LABEL"] = "物品加成 / ";
L["BONUSSCANNER_NOBONUS_LABEL"] = "沒有偵測到任何加成。";
L["BONUSSCANNER_CUREQ_LABEL"] = "目前裝備的加成效果";
L["BONUSSCANNER_CUREQDET_LABEL"] = "目前裝備的詳細加成效果";
L["BONUSSCANNER_OOR_LABEL"] = " 超出距離。";
L["BONUSSCANNER_GEMCOUNT_LABEL"] = "數量 ";
L["BONUSSCANNER_INVALIDTAR_LABEL"] = "無目標可檢視。";
L["BONUSSCANNER_SELTAR_LABEL"] = "請選擇先一個目標。";
L["BONUSSCANNER_SLOT_LABEL"] = "插槽";
L["BONUSSCANNER_FAILEDPARSE_LABEL"] = "伺服器中無此物品的暫存或者未得到驗證。";
L["BONUSSCANNER_CACHESUMMARY_LABEL"] = "BonusScanner 物品暫存: ";
L["BONUSSCANNER_CACHECLEAR_LABEL"] = "BonusScanner 物品暫存已清除。";
L["BONUSSCANNER_SPECIAL1_LABEL"] = " 致命一擊機率";
L["BONUSSCANNER_SPECIAL2_LABEL"] = " 閃躲/招架";
L["BONUSSCANNER_SPECIAL3_LABEL"] = " 近戰";
L["BONUSSCANNER_SPECIAL4_LABEL"] = " 法術";
L["BONUSSCANNER_SPECIAL5_LABEL"] = " 遠程/法術";
L["BONUSSCANNER_ITEMID_LABEL"] = "物品 ID: |cffffffff";
L["BONUSSCANNER_ILVL_LABEL"] = "物品 Level: |cffffffff";
L["BONUSSCANNER_ENCHANTID_LABEL"] = "附魔 ID: |cffffffff";
L["BONUSSCANNER_GEM1ID_LABEL"] = "寶石 1 ID: |cffffffff";
L["BONUSSCANNER_GEM2ID_LABEL"] = "寶石 2 ID: |cffffffff";
L["BONUSSCANNER_GEM3ID_LABEL"] = "寶石 3 ID: |cffffffff";
L["BONUSSCANNER_GEMRED_LABEL"] = "紅色寶石";
L["BONUSSCANNER_GEMBLUE_LABEL"] = "藍色寶石";
L["BONUSSCANNER_GEMYELLOW_LABEL"] = "黃色寶石";
L["BONUSSCANNER_GEMPRISM_LABEL"] = "Prismatic";
L["BONUSSCANNER_AVERAGE_ILVL_LABEL"] = "平均物品等級";
L["BONUSSCANNER_NEEDS_RELOADUI_LABEL"] = "配置的改變會在插件重載后生效";
L["BONUSSCANNER_LDB_PLUGIN_LABEL"] = "BonusScanner LDB 模組 ";
--bonus categories
L["BONUSSCANNER_CAT_ATT"] = "屬性";
L["BONUSSCANNER_CAT_RES"] = "抗性";
L["BONUSSCANNER_CAT_SKILL"] = "技能";
L["BONUSSCANNER_CAT_BON"] = "近戰和遠程攻擊";
L["BONUSSCANNER_CAT_SBON"] = "法術";
L["BONUSSCANNER_CAT_OBON"] = "生命力與法力值";
L["BONUSSCANNER_CAT_EBON"] = "特殊加成";
L["BONUSSCANNER_CAT_GEMS"] = "寶石插槽";
--slash command text
L["BONUSSCANNER_SLASH_STRING1"] = GREEN_FONT_COLOR_CODE.."BonusScanner 物品加成統計";
L["BONUSSCANNER_SLASH_STRING1a"] = "|cffffffff 作者 Crowley, Archarodim, jmsteele, Tristanian";
L["BONUSSCANNER_SLASH_STRING2"] = LIGHTYELLOW_FONT_COLOR_CODE.."用法: |cffffffff/bscan {show | details | tooltip | tooltip gems | itembasic | itemextend | broker | clearcache | target | target <player> | <itemlink> | <itemlink> <player> | <slotname>}";
L["BONUSSCANNER_SLASH_STRING3"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."show: |cffffffff顯示當前裝備的所有加成統計.";
L["BONUSSCANNER_SLASH_STRING4"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."details: |cffffffff顯示詳細的各類統計.";
L["BONUSSCANNER_SLASH_STRING5"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."tooltip: [";
L["BONUSSCANNER_SLASH_STRING5a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffff在提示上顯示加成.";
L["BONUSSCANNER_SLASH_STRING14"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."tooltip gems: [";
L["BONUSSCANNER_SLASH_STRING14a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffff在提示上顯示寶石顏色.";
L["BONUSSCANNER_SLASH_STRING12"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."itembasic: [";
L["BONUSSCANNER_SLASH_STRING12a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffff在提示上顯示物品的ID和等級.";
L["BONUSSCANNER_SLASH_STRING13"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."itemextend: [";
L["BONUSSCANNER_SLASH_STRING13a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffff在提示上顯示物品的附魔和寶石ID.";
L["BONUSSCANNER_SLASH_STRING15"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."broker: [";
L["BONUSSCANNER_SLASH_STRING15a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffff 控制 LDB 插件的狀態，其用來顯示角色的統計信息.";
L["BONUSSCANNER_SLASH_STRING11"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."clearcache: |cffffffff清除緩存.";
L["BONUSSCANNER_SLASH_STRING6"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."target: |cffffffff顯示你目標的加成統計(必須在距離內).";
L["BONUSSCANNER_SLASH_STRING7"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."target <player>: |cffffffff把你當前目標的加成數據密語給指定人.";
L["BONUSSCANNER_SLASH_STRING8"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<itemlink>: |cffffffff顯示鏈接物品的加成(用Shift-Click插入鏈接).";
L["BONUSSCANNER_SLASH_STRING9"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<itemlink> <player>: |cffffffff把你當前鏈接的加成數據密語給指定人.";
L["BONUSSCANNER_SLASH_STRING10"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<slotname>: |cffffffff顯示指定類別的加成統計.";