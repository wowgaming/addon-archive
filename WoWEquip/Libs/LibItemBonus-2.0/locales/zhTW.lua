if GetLocale() ~= "zhTW" then return end

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
        ARMOR = "強化護甲",
        BASE_ARMOR = "基礎護甲",
        ARMOR_BONUS = "額外護甲",

        ARCANERES = "秘法抗性",
        FIRERES = "火焰抗性",
        NATURERES = "自然抗性",
        FROSTRES = "冰霜抗性",
        SHADOWRES = "暗影抗性",

        FISHING = "釣魚技能",
        MINING = "採礦",
        HERBALISM = "草藥學",
        SKINNING = "剝皮",
        DEFENSE = "防禦",

        BLOCK = "格擋",
        BLOCKVALUE = "格擋值",
        DODGE = "閃躲",
        PARRY = "招架",
        ATTACKPOWER = "近戰攻擊強度",
        ATTACKPOWERUNDEAD = "對不死生物的攻擊強度",
        ATTACKPOWERBEAST = "對野獸的攻擊強度",
        ATTACKPOWERFERAL = "野性戰鬥強度",
        CRIT = "近戰致命一擊機率",
        RANGEDATTACKPOWER = "遠程攻擊強度",
        RANGEDCRIT = "遠程攻擊致命一擊機率",
        TOHIT = "近戰命中機率",
        IGNOREARMOR = "無視護甲",
        THREATREDUCTION = "降低威脅值",

        DMG = "法術傷害",
        DMGUNDEAD = "對不死生物的法術傷害",
        ARCANEDMG = "秘法傷害",
        FIREDMG = "火焰傷害",
        FROSTDMG = "冰霜傷害",
        HOLYDMG = "神聖傷害",
        NATUREDMG = "自然傷害",
        SHADOWDMG = "暗影傷害",
        SPELLCRIT = "法術致命一擊機率",
        SPELLTOHIT = "法術命中機率",
        SPELLPEN = "法術穿透",
        HEAL = "治療量",
        HOLYCRIT = "神聖致命一擊等級",

        HEALTHREG = "生命恢復",
        MANAREG = "法力恢復",
        HEALTH = "生命值",
        MANA = "法力值",

        CR_WEAPON = "武器等級",
        CR_DEFENSE = "防禦等級",
        CR_DODGE = "躲避等級",
        CR_PARRY = "招架等級",
        CR_BLOCK = "格擋機率等級",
        CR_HIT = "命中等級",
        CR_CRIT = "致命一擊等級",
        CR_HASTE = "加速等級",
        CR_SPELLHIT = "法術命中等級",
        CR_SPELLCRIT = "法術致命一擊等級",
        CR_SPELLHASTE = "法術加速等級",
        CR_RESILIENCE = "韌性等級",
        CR_EXPERTISE = "熟練等級",
        CR_ARMOR_PENETRATION = "護甲穿透等級",
        CR_WEAPON_AXE = "單手斧技能",
        CR_WEAPON_DAGGER = "匕首技能",
        CR_WEAPON_MACE = "單手錘技能",
        CR_WEAPON_SWORD = "單手劍技能",
        CR_WEAPON_SWORD_2H = "雙手劍技能",
        SNARERES = "緩速和定身的抗性",
    },

    PATTERNS_SKILL_RATING = {
        { pattern = "使你的(.*)等級提高(%d+)點。", false },
        { pattern = "使你的(.*)等級提高(%d+)", false },
        { pattern = "提高你的(.*)等級(%d+)點", false },
        { pattern = "提高你的(.*)等級(%d+)", false },
        { pattern = "提高(.*)等級(%d+)點", false },
        { pattern = "提高(.*)等級(%d+)", false },
        { pattern = "提高(%d+)點(.*)等級。", false },
    },

    SKILL_NAMES = {
        ["命中"] = "CR_HIT",
        ["致命一擊"] = "CR_CRIT",
        ["遠程攻擊致命一擊"] = "CR_RANGEDCRIT",
        ["防禦"] = "CR_DEFENSE",
        ["法術致命一擊"] = "CR_SPELLCRIT",
        ["韌性"] = "CR_RESILIENCE",
        ["法術命中"] = "CR_SPELLHIT",
        ["閃躲"] = "CR_DODGE",
        ["格檔"] = "CR_BLOCK",
        ["盾牌格檔"] = "CR_BLOCK",
        ["招架"] = "CR_PARRY",
        ["單手斧技能"] = "CR_WEAPON_AXE",
        ["匕首技能"] = "CR_WEAPON_DAGGER",
        ["單手錘技能"] = "CR_WEAPON_MACE",
        ["單手劍技能"] = "CR_WEAPON_SWORD",
        ["雙手劍技能"] = "CR_WEAPON_SWORD_2H",
        ["野性戰鬥技能"] = "CR_WEAPON_FERAL",
        ["加速"] = "CR_HASTE",
        ["法術加速"] = "CR_SPELLHASTE",
        ["施法加速"] = "CR_SPELLHASTE",
        ["法力恢復"] = "MANAREG",
        ["武器傷害"] = "MELEEDMG",
        ["徒手戰鬥"] = "CR_WEAPON_FIST",
        ["拳套技能"] = "CR_WEAPON_FIST",
        ["弩技能"] = "CR_WEAPON_CROSSBOW",
        ["槍械技能"] = "CR_WEAPON_GUN",
        ["弓技能"] = "CR_WEAPON_BOW",
        ["法杖技能"] = "CR_WEAPON_STAFF",
        ["雙手錘技能"] = "CR_WEAPON_MACE_2H",
        ["雙手斧技能"] = "CR_WEAPON_AXE_2H",
        ["熟練"] = "CR_EXPERTISE",
        ["護甲穿透"] = "CR_ARMOR_PENETRATION",
    },

    PATTERNS_PASSIVE = {
        { pattern = "法術致命一擊等級提高(%d+)點。", effect = "SPELLCRIT" },
        { pattern = "使你的法術致命一擊等級提高(%d+)點。", effect = "SPELLCRIT" },
        { pattern = "使你的致命一擊等級提高(%d+)點。", effect = {"CR_CRIT","CR_RANGEDCRIT"} },
        { pattern = "致命一擊等級提高(%d+)點。", effect = {"CR_CRIT","CR_RANGEDCRIT"} },
        { pattern = "使你的法術穿透力提高(%d+)點。", effect = "SPELLPEN" },
        { pattern = "使你的神聖系法術的致命一擊和極效治療機率提高(%d+)點。", effect = "HEALCRIT" },

        { pattern = "使你的神聖系法術的致命一擊和極效治療機率提高(%d+)點。", effect = "HOLYCRIT" },
        { pattern = "使你的神聖法術的致命一擊的機率提高(%d+)點。", effect = "HOLYCRIT" },
        { pattern = "提高秘法法術和效果所造成的傷害，最多(%d+)點。", effect = "ARCANEDMG" },
        { pattern = "提高秘法法術和效果所造成的傷害，最多(%d+)點。", effect = "ARCANEDMG" },
        { pattern = "提高火焰法術和效果所造成的傷害，最多(%d+)點。", effect = "FIREDMG" },
        { pattern = "提高冰霜法術和效果所造成的傷害，最多(%d+)點。", effect = "FROSTDMG" },

        { pattern = "提高神聖法術和效果所造成的傷害，最多(%d+)點。", effect = "HOLYDMG" },
        { pattern = "提高自然法術和效果所造成的傷害，最多(%d+)點。", effect = "NATUREDMG" },
        { pattern = "提高暗影法術和效果所造成的傷害，最多(%d+)點。", effect = "SHADOWDMG" },
        { pattern = "使秘法法術和效果所造成的傷害提高最多(%d+)點。", effect = "ARCANEDMG" },
        { pattern = "使秘法法術所造成的傷害提高最多(%d+)點。", effect = "ARCANEDMG" },
        { pattern = "使火焰法術和效果所造成的傷害提高最多(%d+)點。", effect = "FIREDMG" },

        { pattern = "使火焰法術所造成的傷害提高最多(%d+)點。", effect = "FIREDMG" },
        { pattern = "使冰霜法術和效果所造成的傷害提高最多(%d+)點。", effect = "FROSTDMG" },
        { pattern = "使冰霜法術所造成的傷害提高最多(%d+)點。", effect = "FROSTDMG" },
        { pattern = "使神聖法術和效果所造成的傷害提高最多(%d+)點。", effect = "HOLYDMG" },
        { pattern = "使神聖法術所造成的傷害提高最多(%d+)點。", effect = "HOLYDMG" },
        { pattern = "使自然法術和效果所造成的傷害提高最多(%d+)點。", effect = "NATUREDMG" },

        { pattern = "使自然法術所造成的傷害提高最多(%d+)點。", effect = "NATUREDMG" },
        { pattern = "使暗影法術和效果所造成的傷害提高最多(%d+)點。", effect = "SHADOWDMG" },
        { pattern = "使暗影法術所造成的傷害提高最多(%d+)點。", effect = "SHADOWDMG" },
        { pattern = "使治療法術和效果所回復的生命值提高(%d+)點。", effect = "HEAL" },
        { pattern = "使治療法術和效果所回復的生命力提高(%d+)點。", effect = "HEAL" },
        { pattern = "使法術和魔法效果所造成的治療效果提高最多(%d+)點。", effect = "HEAL" },
        { pattern = "使法術和魔法效果所造成的治療效果提高最多(%d+)點，法術傷害提高最多(%d+)點。", effect = HEAL_AND_DMG },

        { pattern = "提高法術和魔法效果所造成的治療效果，最多(%d+)點。", effect = "HEAL" },
        { pattern = "使所有法術和魔法效果所造成的傷害和治療效果提高最多(%d+)點。", effect = HEAL_AND_DMG },

        { pattern = "使你的生命值和法力值回復提高(%d+)點。", effect = {"HEALTHREG", "MANAREG"} },

        { pattern = "使你的生命力和法力回復提高(%d+)點。", effect = {"HEALTHREG", "MANAREG"} },
        { pattern = "防禦等級提高(%d+)點。", effect = "CR_DEFENSE" },
        { pattern = "使防禦等級提高(%d+)點。", effect = "CR_DEFENSE" },
        { pattern = "使你的法術命中等級提高(%d+)點。", effect = "CR_SPELLHIT" },
        { pattern = "使你的盾牌格擋值提高(%d+)點。", effect = "BLOCKVALUE" },
        { pattern = "使你盾牌的格擋值提高(%d+)點。", effect = "BLOCKVALUE" },

        { pattern = "擊中目標後有(%d+)%%的機率獲得1次額外的攻擊機會。", effect = "XTRAHIT" },
        { pattern = "使目標遭到重創，對其造成(%d+)點傷害。", effect = "HIT_WOUND" },
        { pattern = "向目標射出一支暗影箭，對其造成%d+到(%d+)點暗影傷害。", effect = "HIT_SHADOW" },
        { pattern = "向敵人發射一支暗影箭，對其造成(%d+)點暗影傷害。", effect = "HIT_SHADOW" },
        { pattern = "發射一枚火球攻擊目標，對其造成%d+到(%d+)點火焰傷害，並在%d+秒內造成額外的%d+點傷害。", effect = "HIT_FIRE" },
        { pattern = "發射一枚火球攻擊目標，對其造成%d+到%d+點火焰傷害，並在%d+秒內造成額外的(%d+)點傷害。", effect = "HIT_FIRE_EX" },

        { pattern = "對不死生物的攻擊強度提高(%d+)點。", effect = "UNDEADAP" },
        { pattern = "攻擊不死生物時+(%d+)點攻擊強度。", effect = "UNDEADAP" },
        { pattern = "提高法術生命和魔法效果對不死生物所造成的傷害，最多(%d+)點。", effect = "UNDEADDMG" },
        { pattern = "法術和魔法效果對亡靈造成的傷害提高最多(%d+)點。", effect = "UNDEADDMG" },
        { pattern = "使魔法和法術效果對亡靈造成的傷害提高最多(%d+)點。", effect = "UNDEADDMG" },
        { pattern = "對惡魔的攻擊強度提高(%d+) 點。", effect = "ATTACKPOWEREVIL" },
        { pattern = "你的攻擊無視目標(%d+)點護甲值。", effect = "IGNOREARMOR" },
        { pattern = "降低(%d+)%威脅值", effect = "THREATREDUCTION" },

        -- 給HealPoints用的
--				{ pattern = "Allow (%d+)%% of your Mana regeneration to continue while casting%.", effect = "CASTINGREG"},
        { pattern = "使你癒合法術的施法時間降低0%.(%d+)秒。", effect = "CASTINGREGROWTH"},
        { pattern = "使你的聖光術的施法時間減少0%.(%d+)秒。", effect = "CASTINGHOLYLIGHT"},
        { pattern = "使你的治療之觸的施法時間減少0%.(%d+)秒。", effect = "CASTINGHEALINGTOUCH"},
        { pattern = "使你的快速治療法術的施法時間減少0%.(%d+)秒。", effect = "CASTINGFLASHHEAL"},
        { pattern = "治療鏈法術的施法時間減少0%.(%d+)秒。", effect = "CASTINGCHAINHEAL"},
        { pattern = "使你回春術的持續時間延長(%d+)秒。", effect = "DURATIONREJUV"},
        { pattern = "使你恢復術的持續時間延長(%d+)秒。", effect = "DURATIONRENEW"},
--				{ pattern = "Increases your normal health and mana regeneration by (%d+)%.", effect = "MANAREGNORMAL"},
        { pattern = "使治療鍊對第一個以後的目標所造成的治療效果提高(%d+)%%。", effect = "IMPCHAINHEAL"},
        { pattern = "增加回春術所造成的治療效果，最多(%d+)點。", effect = "IMPREJUVENATION"},
        { pattern = "使次級治療波的治療效果最多提高(%d+)點。", effect = "IMPLESSERHEALINGWAVE"},
        { pattern = "提高聖光閃現的治療效果最多(%d+)點。", effect = "IMPFLASHOFLIGHT"},
        { pattern = "在你施放了治療波或次級治療波法術之後，有25%的機率獲得該法術所消耗的法力的(%d+)。", effect = "REFUNDHEALINGWAVE"},
        { pattern = "你的治療波會治療一個額外的目標。治療波每次跳躍後的治療效果都會降低(%d+)%%，並治療最多2個額外的目標。", effect = "JUMPHEALINGWAVE"},
        { pattern = "使你治療之觸、回春術、癒合和寧靜所消耗的法力降低(%d+)%%。", effect = "CHEAPERDRUID"},
        { pattern = "當治療之觸產生極效治療效果後，獲得(%d+)%%施放治療之觸所需的法力。", effect = "REFUNDHTCRIT"},
        { pattern = "使你恢復法術所需要的法力降低(%d+)%%%.。", effect = "CHEAPERRENEW"},

        { pattern = "使你的潛行等級提高(%d+)點。", effect = "STEALTH" },
        { pattern = "游泳速度提高(%d+)%%。", effect = "SWIMSPEED" }, -- 7052
        { pattern = "使坐騎速度提高(%d+)%%。", effect = "MOUNTSPEED" }, -- 11122, 25653
        { pattern = "使你的奔跑速度提高(%d+)%%。", effect = "RUNSPEED" }, -- 13388
        { pattern = "使你招架攻擊的機率降低(%d+)%%。", effect = "NEGPARRY" }, -- 7348
        { pattern = "使你抵抗昏迷和恐懼效果的機率提高(%d+)%%。", effect = {"STUNRESIST", "FEARRESIST"} }, -- 17759
        { pattern = "使你抵抗恐懼效果的機率提高(%d+)%%。", effect = "FEARRESIST" }, -- 28428, 28429, 28430
        { pattern = "使你抵抗昏迷和困惑效果的機率提高(%d+)%%。", effect = {"STUNRESIST", "DISORIENTRESIST"} }, -- 23839
        { pattern = "所承受的近戰傷害降低(%d+)點。", effect = "MELEETAKEN" }, -- 31154
        { pattern = "所受到的法術傷害降低(%d+)點。", effect = "DMGTAKEN" }, -- 22191

        -- 阿泰絲專用
        { pattern = "使你的法術傷害提高最多(%d+)點，以及你的治療效果最多(%d+)點", effect = {"DMG", "HEAL"} },
        { pattern = "使周圍半徑%d+碼範圍內隊友的所有法術和魔法效果所造成的治療效果提高最多(%d+)點", effect = "HEAL" },
        { pattern = "使周圍半徑%d+碼範圍內隊友的所有法術和魔法效果所造成的傷害和治療效果提高最多(%d+)點", effect = HEAL_AND_DMG },
        { pattern = "使周圍半徑%d+碼範圍內的隊友每5秒恢復(%d+)點法力", effect = "MANAREG" },
        { pattern = "使半徑%d+碼範圍內所有小隊成員的法術致命一擊等級提高(%d+)點", effect = "SPELLCRIT" },

        -- 變換寶石的加成
        { pattern = "+(%d+)敏捷和提高(%d+)%%致命一擊傷害", effect = {"AGI", "CRITDMG"} },
        { pattern = "+(%d+)法術致命一擊等級和提高(%d+)%%致命一擊傷害", effect = {"CR_SPELLCRIT", "SPELLCRITDMG"} },
    },

    SEPARATORS = { "及", "和", "並", "。", },

    GENERIC_PATTERNS = {
        ["使你的(.+)提高(%d+)點"]	= false,
        ["^使(.+)提高(%d+)點$"]	= false,
        ["^使(.+)提高(%d+)$"]	= false,
        ["^(.+)提高(%d+)點$"]	= false,
        ["^(.+)提高(%d+)$"]	= false,
        ["^提高(%D+)(%d+)點$"]	= false,
        ["^提高(%D+)(%d+)$"]	= false,
        ["^%+?(%d+)點(%D*)$"]	= true,
        ["^%+?(%d+) ?(%D*)$"]		= true,
        ["^(.*)%+ ?(%d+)%%?$"]	= false,
        ["^(.*): ?(%d+)$"]		= false,
        ["^每5秒恢復(%d+)(點.*)$"]		= true,
        ["^降低(%d+)%%(.*)$"]		= true,
        ["^提高(%d+)點(%D+)。$"]	= true,
    },

    PATTERNS_GENERIC_LOOKUP = {
        ["所有屬性"] = ALL_STATS,
        ["力量"] = "STR",
        ["敏捷"] = "AGI",
        ["耐力"] = "STA",
        ["智力"] = "INT",
        ["精神"] = "SPI",

        ["所有抗性"] = ALL_RESISTS,

        ["釣魚技能"] = "FISHING",
        ["釣魚技能提高"] = "FISHING",

        ["採礦"] = "MINING",
        ["草藥學"] = "HERBALISM",
        ["剝皮"] = "SKINNING",
        ["防禦等級"] = "DEFENSE",

        ["攻擊強度"] = "ATTACKPOWER",
        ["對不死生物的攻擊強度"] = "ATTACKPOWERUNDEAD",

        ["閃躲等級"] = "DODGE",
        ["格擋機率等級"] = "BLOCK",
        ["格擋等級"] = "BLOCK",
        ["盾牌格擋"] = "BLOCKVALUE",
        ["格擋值"] = "BLOCKVALUE",
        ["遠程攻擊強度"] = "RANGEDATTACKPOWER",

        ["治療法術"] = "HEAL",
        ["治療"] = "HEAL",
        ["法術傷害"] = "DMG",
        ["法術能量"] = "DMG",
        ["治療和法術傷害"] = HEAL_AND_DMG,
        ["法術治療和傷害"] = HEAL_AND_DMG,
        ["法術傷害和治療"] = HEAL_AND_DMG,
        ["傷害及治療法術"] = HEAL_AND_DMG,
        ["法術傷害及治療"] = HEAL_AND_DMG,
        ["點生命力"] = "HEALTHREG",
        ["點法力"] = "MANAREG",

        ["生命力"] = "HEALTH",
        ["法力"] = "MANA",
        ["護甲"] = "BASE_ARMOR",
        ["額外護甲"] = "ARMOR_BONUS",
        ["韌性等級"] = "CR_RESILIENCE",
        ["法術致命一擊"] = "CR_SPELLCRIT",
        ["法術致命一擊等級"] = "CR_SPELLCRIT",
        ["法術穿透等級"] = "SPELLPEN",
        ["法術穿透力"] = "SPELLPEN",
        ["命中等級"] = "CR_HIT",
        ["防禦等級"] = "CR_DEFENSE",
        ["韌性等級"] = "CR_RESILIENCE",
        ["致命一擊"] = "CR_CRIT",
        ["致命一擊等級"] = "CR_CRIT",
        ["閃躲等級"] = "CR_DODGE",
        ["招架等級"] = "CR_PARRY",
        ["法術致命一擊"] = "CR_SPELLCRIT",
        ["法術致命一擊等級"] = "CR_SPELLCRIT",
        ["法術命中等級"] = "CR_SPELLHIT",
        ["加速等級"] = "CR_HASTE",
        ["護甲穿透等級"] = "CR_ARMOR_PENETRATION",
        ["法力恢復"] = "MANAREG",
        ["所有抗性"] = ALL_RESISTS,
        ["減低威脅值"] = "THREATREDUCTION",
        ["威脅值"] = "THREATREDUCTION",
    },

    PATTERNS_GENERIC_STAGE1 = {
        { pattern = "秘法", 	effect = "ARCANE" },
        { pattern = "秘法", 	effect = "ARCANE" },

        { pattern = "火焰", 	effect = "FIRE" },
        { pattern = "冰霜", 	effect = "FROST" },
        { pattern = "神聖", 	effect = "HOLY" },
        { pattern = "暗影",	effect = "SHADOW" },
        { pattern = "陰影",	effect = "SHADOW" },
        { pattern = "自然", 	effect = "NATURE" }

    },

    PATTERNS_GENERIC_STAGE2 = {
        { pattern = "抗性", 	effect = "RES" },
        { pattern = "傷害", 	effect = "DMG" }
    },


    PATTERNS_OTHER = {
        { pattern = "+(%d+)強化護甲", effect = "ARMOR_BONUS" },
        { pattern = "每5秒回復(%d+)點法力", effect = "MANAREG" },
        { pattern = "每5秒恢復(%d+)點法力", effect = "MANAREG" },

        { pattern = "初級巫師之油", effect = HEAL_AND_DMG, value = 8 },
        { pattern = "次級巫師之油", effect = HEAL_AND_DMG, value = 16 },
        { pattern = "巫師之油", effect = HEAL_AND_DMG, value = 24 },
        { pattern = "卓越巫師之油", effect = {"DMG", "HEAL", "SPELLCRIT"}, value = {36, 36, 1} },

        { pattern = "初級法力之油", effect = "MANAREG", value = 4 },
        { pattern = "次級法力之油", effect = "MANAREG", value = 8 },
        { pattern = "卓越法力之油", effect = { "MANAREG", "HEAL"}, value = {12, 25} },

        { pattern = "恆金漁線", effect = "FISHING", value = 5 },
        { pattern = "活力", effect = {"MANAREG", "HEALTHREG"}, value = {4, 4} },
        { pattern = "靈魂冰霜", effect = {"FROSTDMG", "SHADOWDMG"}, value = {54, 54} },
        { pattern = "烈日火焰", effect = {"ARCANEDMG", "FIREDMG"}, value = {50, 50} },
        { pattern = "野性", effect = "ATTACKPOWER", value = 70 },
        { pattern = "穩固", effect = {"CR_HIT", "SNARERES"}, value = {10, 5} },
        { pattern = "使防禦等級提高5點，暗影抗性提高10點和一般的生命力恢復速度提高3點。", effect = {"CR_DEFENSE", "SHADOWRES", "HEALTHREG_P"}, value = {5, 10, 3} }, --10779
        { pattern = "%+2%% 仇恨", effect = "THREATREDUCTION", value = -2 },
        { pattern = "狡詐", effect = "THREATREDUCTION", value = 2 },

        { pattern = "使你可以在水下呼吸。", effect = "UNDERWATER", value = 1 }, -- 10506
        { pattern = "使你的開鎖技能提高5點。", effect = "LOCKPICK", value = 5 },
        { pattern = "中度地提高你的偵測潛行能力。", effect = "STEALTHDETECT", value = 18 }, -- 10501
        { pattern = "使你偵測潛行的能力略微提高。", effect = "STEALTHDETECT", value = 10 }, -- 22863, 23280, 31333
--				{ pattern = "繳械持續時間縮短(%d+)%%。", effect = "DISARMIMMUNE"}, -- 12639
        { pattern = "略微提高奔跑和游泳速度。", effect = {"RUNSPEED", "SWIMSPEED"}, value = {8,8} }, -- 19685
        { pattern = "減少從高處墜落所受的傷害。", effect = "SLOWFALL", value = 1 }, -- 19982
        { pattern = "使移動速度和生命力恢復速度提高。", effect = {"RUNSPEED", "HEALTHREG"}, value = {8,20} }, -- 13505
        { pattern = "略微提高移動速度。", effect = "RUNSPEED", value = 8 }, -- 20048, 25835, 29512
        { pattern = "略微提高潛行效果。", effect = "STEALTH", value = 3 }, -- 21758
        { pattern = "使你的潛行等級提高。", effect = "STEALTH", value = 8 }, -- 22003, 23073
        { pattern = "使法術傷害以及治療效果略微提高。", effect = HEAL_AND_DMG, value = 6 }, -- 30804

        { pattern = "贊達拉力量徽記", effect = "ATTACKPOWER", value = {30, 30} },
        { pattern = "贊達拉魔精徽記", effect = {"DMG", "HEAL"}, value = 18 },
        { pattern = "贊達拉寧靜徽記", effect = "HEAL", value = 33 },

        { pattern = "瞄準鏡%(%+(%d+)致命一擊等級%)", effect = "CR_RANGEDCRIT" },
        { pattern = "瞄準鏡（%+(%d+) ?傷害）", effect = "RANDMG" },
    },
}
