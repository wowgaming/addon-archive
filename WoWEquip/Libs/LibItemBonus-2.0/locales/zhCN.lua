if GetLocale() ~= "zhCN" then return end

local lib = LibStub("LibItemBonus-2.0")

if not lib._LOADING then return end

local ALL_RESISTS = {"ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}
local ALL_STATS = {"STR", "AGI", "STA", "INT", "SPI"}
local HEAL_AND_DMG = {"HEAL", "DMG"}

lib.patterns = {
	NAMES = {
		STR = "力量",
		AGI = "敏捷",
		STA = "耐力",
		INT = "智力",
		SPI = "精神",
		ARMOR = "护甲",
		BASE_ARMOR = "基础护甲",
		ARMOR_BONUS = "护甲加成",

		ARCANERES = "奥术抗性",
		FIRERES = "火焰抗性",
		NATURERES = "自然抗性",
		FROSTRES = "冰霜抗性",
		SHADOWRES = "暗影抗性",

		FISHING = "钓鱼技能",
		MINING = "采矿",
		HERBALISM = "草药学",
		SKINNING = "剥皮",
		DEFENSE = "防御",

		BLOCK = "格挡",
		BLOCKVALUE = "格挡值",
		DODGE = "躲避",
		PARRY = "招架",
		ATTACKPOWER = "攻击强度",
		ATTACKPOWERUNDEAD = "对亡灵生物的攻击强度",
		ATTACKPOWERBEAST = "对野兽的攻击强度",
		ATTACKPOWERFERAL = "野性战斗强度",
		CRIT = "近战致命等级",
		RANGEDATTACKPOWER = "远程攻击强度",
		RANGEDCRIT = "远程攻击致命等级",
		TOHIT = "命中等级",
		IGNOREARMOR = "无视护甲",
		THREATREDUCTION = "仇恨降低",

		DMG = "法术伤害",
		DMGUNDEAD = "对亡灵生物的法术伤害",
		ARCANEDMG = "奥术伤害",
		FIREDMG = "火焰伤害",
		FROSTDMG = "冰霜伤害",
		HOLYDMG = "神圣伤害",
		NATUREDMG = "自然伤害",
		SHADOWDMG = "暗影伤害",
		SPELLCRIT = "法术致命等级",
		SPELLTOHIT = "法术命中等级",
		SPELLPEN = "法术穿透",
		HEAL = "治疗量",
		HOLYCRIT = "神圣暴击等级",

		HEALTHREG = "生命恢复",
		MANAREG = "法力恢复",
		HEALTH = "生命值",
		MANA = "法力值",

		CR_WEAPON = "武器等级",
		CR_DEFENSE = "防御等级",
		CR_DODGE = "躲避等级",
		CR_PARRY = "招架等级",
		CR_BLOCK = "格挡等级",
		CR_HIT = "命中等级",
		CR_CRIT = "致命一击等级",
		CR_HASTE = "攻击速度等级",
		CR_SPELLHIT = "法术命中等级",
		CR_SPELLCRIT = "法术致命一击等级",
		CR_SPELLHASTE = "法术加速等级",
		CR_RESILIENCE = "韧性",
		CR_WEAPON_AXE = "单手斧技能等级",
		CR_WEAPON_DAGGER = "匕首技能等级",
		CR_WEAPON_MACE = "单手锤技能等级",
		CR_WEAPON_SWORD = "单手剑技能等级",
		CR_WEAPON_SWORD_2H = "双手剑技能等级",
		SNARERES = "减速和定身的抗性",
	},

	PATTERNS_SKILL_RATING = {
		{ pattern = "使你的(.*)等级提高%d" },
		{ pattern = "(.*)等级提高(%d+)" },
		{ pattern = "提高你的(.*)等级(%d+)" },
		{ pattern = "提高(.*)提高(%d+)" },
		--add
		{ pattern = "使你的(.*)等级提高%d点" },
		{ pattern = "(.*)等级提高(%d+)点" },
		{ pattern = "提高你的(.*)等级(%d+)点" },
		{ pattern = "提高(.*)提高(%d+)点" },
	},

	SKILL_NAMES = {
		["命中"] = "CR_HIT",
		["爆击"] = "CR_CRIT",
		["远程爆击"] = "CR_RANGEDCRIT",
		["防御"] = "CR_DEFENSE",
		["法术爆击等级"] = "CR_SPELLCRIT",
		["韧性"] = "CR_RESILIENCE",
		["法术命中"] = "CR_SPELLHIT",
		["躲闪"] = "CR_DODGE",
		["格挡"] = "CR_BLOCK",
		["招架"] = "CR_PARRY",
		["单手斧技能"] = "CR_WEAPON_AXE",
		["匕首技能"] = "CR_WEAPON_DAGGER",
		["单手锤技能"] = "CR_WEAPON_MACE",
		["单手剑技能"] = "CR_WEAPON_SWORD",
		["双手剑技能"] = "CR_WEAPON_SWORD_2H",
		["野性战斗技能"] = "CR_WEAPON_FERAL",
		["盾牌格挡"] = "CR_BLOCK",
		["急速"] = "CR_HASTE",
		["法术"] = "CR_SPELLHASTE",
		["徒手技能"] = "CR_WEAPON_FIST",
		["拳套技能"] = "CR_WEAPON_FIST",
		["弩技能"] = "CR_WEAPON_CROSSBOW",
		["枪技能"] = "CR_WEAPON_GUN",
		["弓技能"] = "CR_WEAPON_BOW",
		["法杖技能"] = "CR_WEAPON_STAFF",
		["双手锤技能"] = "CR_WEAPON_MACE_2H",
		["双手斧技能"] = "CR_WEAPON_AXE_2H",
		["精准"] = "CR_EXPERTISE",
	},

	--重新校订
	PATTERNS_PASSIVE = {
		{ pattern = "使钓鱼技能%+(%d+)点", effect = "FISHING" },
		{ pattern = "剥皮技能提高(%d+)点", effect = "SKINNING" },
		{ pattern = "使攻击强度提高(%d+)点", effect = {"ATTACKPOWER","RANGEDATTACKPOWER"} },
		{ pattern = "+(%d+)攻击强度", effect = {"ATTACKPOWER","RANGEDATTACKPOWER"} },
		{ pattern = "+(%d+)远程攻击强度", effect = "RANGEDATTACKPOWER" },

		{ pattern = "远程攻击强度提高(%d+)点", effect = "RANGEDATTACKPOWER" },
		{ pattern = "使你的格挡等级提高(%d+)点", effect = "BLOCK" },
		{ pattern = "提高你的盾牌格挡等级(%d+)", effect = "BLOCK" },
		{ pattern = "使你的闪躲等级提高(%d+)", effect = "DODGE" },
		{ pattern = "使你的韧性等级提高(%d+)", effect = "RESILIENCE" },
		{ pattern = "使你的招架等级提高(%d+)点", effect = "PARRY" },

		{ pattern = "法术爆击等级提高(%d+)", effect = "SPELLCRIT" },
		{ pattern = "使你的法术爆击等级提高(%d+)点", effect = "SPELLCRIT" },
		{ pattern = "使你的爆击等级提高(%d+)点", effect = {"CRIT","RANGEDCRIT"} },
		{ pattern = "爆击等级提高(%d+)", effect = {"CRIT","RANGEDCRIT"} },
		{ pattern = "使你的法术穿透提高(%d+)点", effect = "PENETRATION" },
		{ pattern = "使你的神圣系法术的爆击机率提高(%d+)%%", effect = "HEALCRIT" },

		{ pattern = "使你的神圣系法术的爆击机率提高(%d+)%%", effect = "HOLYCRIT" },
		{ pattern = "使你的神圣法术的爆击的机率提高(%d+)%%", effect = "HOLYCRIT" },
		{ pattern = "提高奥术法术和效果所造成的伤害，最多(%d+)点", effect = "ARCANEDMG" },
		{ pattern = "提高奥术法术和效果所造成的伤害，最多(%d+)点", effect = "ARCANEDMG" },
		{ pattern = "提高火焰法术和效果所造成的伤害，最多(%d+)点", effect = "FIREDMG" },
		{ pattern = "提高冰霜法术和效果所造成的伤害，最多(%d+)点", effect = "FROSTDMG" },

		{ pattern = "提高神圣法术和效果所造成的伤害，最多(%d+)点", effect = "HOLYDMG" },
		{ pattern = "提高自然法术和效果所造成的伤害，最多(%d+)点", effect = "NATUREDMG" },
		{ pattern = "提高暗影法术和效果所造成的伤害，最多(%d+)点", effect = "SHADOWDMG" },
		{ pattern = "使奥术法术和效果所造成的伤害提高最多(%d+)点", effect = "ARCANEDMG" },
		{ pattern = "使奥术法术所造成的伤害提高最多(%d+)点", effect = "ARCANEDMG" },
		{ pattern = "使火焰法术和效果所造成的伤害提高最多(%d+)点", effect = "FIREDMG" },

		{ pattern = "使火焰法术所造成的伤害提高最多(%d+)点", effect = "FIREDMG" },
		{ pattern = "使冰霜法术和效果所造成的伤害提高最多(%d+)点", effect = "FROSTDMG" },
		{ pattern = "使冰霜法术所造成的伤害提高最多(%d+)点", effect = "FROSTDMG" },
		{ pattern = "使神圣法术和效果所造成的伤害提高最多(%d+)点", effect = "HOLYDMG" },
		{ pattern = "使神圣法术所造成的伤害提高最多(%d+)点", effect = "HOLYDMG" },
		{ pattern = "使自然法术和效果所造成的伤害提高最多(%d+)点", effect = "NATUREDMG" },

		{ pattern = "使自然法术所造成的伤害提高最多(%d+)点", effect = "NATUREDMG" },
		{ pattern = "使暗影法术和效果所造成的伤害提高最多(%d+)点", effect = "SHADOWDMG" },
		{ pattern = "使暗影法术所造成的伤害提高最多(%d+)点", effect = "SHADOWDMG" },
		{ pattern = "使治疗法术和效果所回复的生命值提高(%d+)点", effect = "HEAL" },
		{ pattern = "使治疗法术和效果所回复的生命力提高(%d+)点", effect = "HEAL" },
		{ pattern = "使法术所造成的治疗效果提高最多(%d+)点", effect = "HEAL" },

		{ pattern = "提高法术和魔法效果所造成的治疗效果，最多(%d+)点", effect = "HEAL" },
		{ pattern = "使所有法术和魔法效果所造成的伤害和治疗效果提高最多(%d+)点", effect = "DMG" },
		{ pattern = "使所有法术和魔法效果所造成的伤害和治疗效果提高最多(%d+)点", effect = "HEAL" },
		{ pattern = "每+%d+秒恢复(%d+)点生命值", effect = "HEALTHREG" },
		{ pattern = "每+%d+秒回复(%d+)点生命值", effect = "HEALTHREG" },
		{ pattern = "每+%d+秒%+(%d+)生命值", effect = "HEALTHREG" },

		{ pattern = "每+%d+秒恢复(%d+)点法力值", effect = "MANAREG" },
		{ pattern = "每+%d+秒回复(%d+)点法力值", effect = "MANAREG" },
		{ pattern = "每+%d+秒%+(%d+)法力值", effect = "MANAREG" },
		{ pattern = "使你的命中等级提高(%d+)点", effect = "TOHIT" },
		{ pattern = "提高命中等级(%d+)", effect = "TOHIT" },
		{ pattern = "使你的生命值和法力值回复提高(%d+)点", effect = {"HEALTHREG", "MANAREG"} },

		{ pattern = "使你的生命值和法力值回复提高(%d+)点", effect = {"HEALTHREG", "MANAREG"} },
		{ pattern = "防御等级提高(%d+)", effect = "DEFENSE" },
		{ pattern = "使防御等级提高(%d+)点", effect = "DEFENSE" },
		{ pattern = "使你的法术命中等级提高(%d+)点", effect = "SPELLTOHITLV" },
		{ pattern = "使你的盾牌格挡值提高(%d+)点", effect = "BLOCKAMT" },
		{ pattern = "使你盾牌的格挡值提高(%d+)点", effect = "BLOCKAMT" },

		{ pattern = "击中目标后有(%d+)%%的机率获得1次额外的攻击机会", effect = "XTRAHIT" },
		{ pattern = "使目标遭到重创，对其造成(%d+)点伤害", effect = "HIT_WOUND" },
		{ pattern = "向目标射出一支暗影箭，对其造成%d+到(%d+)点暗影伤害", effect = "HIT_SHADOW" },
		{ pattern = "向敌人发射一支暗影箭，对其造成(%d+)点暗影伤害", effect = "HIT_SHADOW" },
		{ pattern = "发射一枚火球攻击目标，对其造成%d+到(%d+)点火焰伤害，并在%d+秒内造成额外的%d+点伤害", effect = "HIT_FIRE" },
		{ pattern = "发射一枚火球攻击目标，对其造成%d+到%d+点火焰伤害，并在%d+秒内造成额外的(%d+)点伤害", effect = "HIT_FIRE_EX" },

		{ pattern = "对亡灵生物的攻击强度提高(%d+)点", effect = "UNDEADAP" },
		{ pattern = "攻击亡灵生物时+(%d+)点攻击强度", effect = "UNDEADAP" },
		{ pattern = "提高法术和魔法效果对亡灵生物所造成的伤害，最多(%d+)点", effect = "UNDEADDMG" },
		{ pattern = "法术和魔法效果对亡灵造成的伤害提高最多(%d+)点", effect = "UNDEADDMG" },
		{ pattern = "使魔法和法术效果对亡灵造成的伤害提高最多(%d+)点", effect = "UNDEADDMG" },
		{ pattern = "对恶魔的攻击强度提高(%d+) 点", effect = "ATTACKPOWEREVIL" },

	},

	SEPARATORS = { "/", "和", ",", "。", " 持续 ", "&", "及", "并", "，", },

	--需校订
	GENERIC_PATTERNS = {
		["^%+?(%d+)%%?(.*)$"]	= true,
		["^(.*)%+ ?(%d+)%%?$"]	= false,
		["^(.*): ?(%d+)$"]		= false
	},

	PATTERNS_GENERIC_LOOKUP = {
		["所有属性"] = ALL_STATS,
		["力量"] = "STR",

		["敏捷"] = "AGI",
		["耐力"] = "STA",
		["智力"] = "INT",
		["精神"] = "SPI",
		["所有抗性"] = ALL_RESISTS,
		["钓鱼技能"] = "FISHING",

		["钓鱼技能提高"] = "FISHING",
		["採矿"] = "MINING",
		["草药学"] = "HERBALISM",
		["剥皮"] = "SKINNING",
		["防御等级"] = "DEFENSE",
		["攻击强度"] = "ATTACKPOWER",

		["对亡灵生物的攻击强度"] = "ATTACKPOWERUNDEAD",
		["闪躲等级"] = "DODGE",
		["格挡机率等级"] = "BLOCK",
		["盾牌格挡"] = "BLOCKVALUE",
		["格挡值"] = "BLOCKVALUE",
		["命中等级"] = "TOHIT",

		["法术命中等级"] = "SPELLTOHIT",
		["远程攻击强度"] = "RANGEDATTACKPOWER",
		["治疗法术"] = "HEAL",
		["治疗"] = "HEAL",
		["治疗和法术伤害"] = HEAL_AND_DMG,
		["法术治疗和伤害"] = HEAL_AND_DMG,

		["法术伤害和治疗"] = HEAL_AND_DMG,
		["伤害及治疗法术"] = HEAL_AND_DMG,
		["法术伤害及治疗"] = HEAL_AND_DMG,
		["法术伤害"] = "DMG",
		["爆击"] = "CRIT",
		["爆击等级"] = "CRIT",

		["生命值"] = "HEALTH",
		["法力值"] = "MANA",
		["护甲"] = "BASE_ARMOR",
		["韧性等级"] = "CR_RESILIENCE",
		["法术穿透等级"] = "SPELLPEN",
		["法力值恢复"] = "MANAREG",

		["武器伤害"] = "WEPDMG",

	},

	PATTERNS_GENERIC_STAGE1 = {
		{ pattern = "奥术", 	effect = "ARCANE" },
		{ pattern = "奥术", 	effect = "ARCANE" },

		{ pattern = "火焰", 	effect = "FIRE" },
		{ pattern = "冰霜", 	effect = "FROST" },
		{ pattern = "神圣", 	effect = "HOLY" },
		{ pattern = "暗影",	effect = "SHADOW" },
		{ pattern = "阴影",	effect = "SHADOW" },
		{ pattern = "自然", 	effect = "NATURE" }

	},

	PATTERNS_GENERIC_STAGE2 = {
		{ pattern = "抗性", 	effect = "RES" },
		{ pattern = "伤害", 	effect = "DMG" }
	},


	PATTERNS_OTHER = {
		{ pattern = "强化%(%+(%d+)护甲%)", effect = "ARMOR_BONUS" },
		{ pattern = "每%d秒回复(%d+)点法力值", effect = "MANAREG" },

		{ pattern = "初级巫师之油", effect = HEAL_AND_DMG, value = 8 },
		{ pattern = "次级巫师之油", effect = HEAL_AND_DMG, value = 16 },
		{ pattern = "巫师之油", effect = HEAL_AND_DMG, value = 24 },

		{ pattern = "卓越巫师之油", effect = {"DMG", "HEAL", "SPELLCRIT"}, value = {36, 36, 1} },

		{ pattern = "初级法力值之油", effect = "MANAREG", value = 4 },
		{ pattern = "次级法力值之油", effect = "MANAREG", value = 8 },
		{ pattern = "卓越法力值之油", effect = { "MANAREG", "HEAL"}, value = {12, 25} },

		{ pattern = "每%d秒恢复(%d+)点法力值", effect = "MANAREG" },

		{ pattern = "鱼饵 %+(%d+)（%d分钟）", effect = "FISHING" },
		{ pattern = "每%d秒回复(%d+)点生命值", effect = "HEALTHREG" },
		{ pattern = "每%d秒恢复(%d+)点生命值", effect = "HEALTHREG" },
		{ pattern = "赞达拉力量徽记", effect = "ATTACKPOWER", value = 30 },
		{ pattern = "赞达拉魔精徽记", effect = {"DMG", "HEAL"}, value = 18 },
		{ pattern = "赞达拉宁静徽记", effect = "HEAL", value = 33 },

		{ pattern = "瞄准镜（%+(%d+) 伤害）", effect = "RANDMG" },
		{ pattern = "瞄准镜（%+(%d+) 爆击等级）", effect = "RANDMG" },
		{ pattern = "对亡灵%+(%d+)法术伤害（%d分钟）", effect = "UNDEADDMG"},
		{ pattern = "%+(%d+) 命中等级", effect = "HIT"},
		{ pattern = "%+30 远程命中等级", effect = "CR_RANGEDHIT", value = 30 },
	},
}
