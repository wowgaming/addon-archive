if GetLocale() ~= "koKR" then return end

local lib = LibStub("LibItemBonus-2.0")

if not lib._LOADING then return end

local ALL_RESISTS = {"ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}
local ALL_STATS = {"STR", "AGI", "STA", "INT", "SPI"}

lib.patterns = {
	NAMES = {
		STR = "힘",
		AGI = "민첩성",
		STA = "체력",
		INT = "지능",
		SPI = "정신력",
		ARMOR = "방어도",
		BASE_ARMOR = "기본 방어도",
		ARMOR_BONUS = "향상되는 방어도",

		ARCANERES = "비전 저항력",
		FIRERES = "화염 저항력",
		NATURERES = "자연 저항력",
		FROSTRES = "냉기 저항력",
		SHADOWRES = "암흑 저항력",

		FISHING = "낚시",
		MINING = "채광",
		HERBALISM = "약초 채집",
		SKINNING = "무두질",
		DEFENSE = "방어 숙련",

		BLOCK = "방패 막기",
		BLOCKVALUE = "피해 방어량",
		DODGE = "회피",
		PARRY = "무기 막기",
		ATTACKPOWER = "전투력",
		ATTACKPOWERUNDEAD = "언데드에 대한 전투력",
		ATTACKPOWERBEAST = "야수에 대한 전투력",
		ATTACKPOWERFERAL = "야수 변신시 전투력",
		CRIT = "치명타 적중률",
		RANGEDATTACKPOWER = "원거리 전투력",
		RANGEDCRIT = "원거리 치명타 적중률",
		TOHIT = "적중률",
		THREATREDUCTION = "위협 수준 감소",

		SPELLPOWER = "주문력",
		SPELLCRIT = "주문 극대화율",
		SPELLTOHIT = "주문 적중율",
		SPELLPEN = "대상 저항 감소",
		HOLYCRIT = "신성계 주문 극대화율",

		HEALTHREG = "생명력 회복",
		MANAREG = "마나 회복",
		HEALTH = "생명력",
		MANA = "마나",

		CR_WEAPON = "무기 숙련도",
		CR_DEFENSE = "방어 숙련도",
		CR_DODGE = "회피 숙련도",
		CR_PARRY = "무기 막기 숙련도",
		CR_BLOCK = "방패 막기 숙련도",
		CR_HIT = "적중도",
		CR_CRIT = "치명타 적중도",
		CR_HASTE = "가속도",
		CR_EXPERTISE = "숙련도",
		CR_RESILIENCE = "탄력도",
		CR_WEAPON_AXE = "도끼류 숙련도",
		CR_WEAPON_DAGGER = "단검류 숙련도",
		CR_WEAPON_MACE = "둔기류 숙련도",
		CR_WEAPON_SWORD = "도검류 숙련도",
		CR_WEAPON_SWORD_2H = "양손 도검류 숙련도",
		CR_ARMOR_PENETRATION = "방어구 관통력",
		SNARERES = "감속 및 이동 방해 효과", -- check
	},

	PATTERNS_SKILL_RATING = {
		{ pattern = "(.*)가 (%d+)만큼 증가합니다" },
		{ pattern = "(.*)이 (%d+)만큼 증가합니다" },
--		{ pattern = "Increases (.*) rating by (%d+)" },
--		{ pattern = "Improves your (.*) rating by (%d+)" },
--		{ pattern = "Improves (.*) rating by (%d+)" },
	},

	SKILL_NAMES = {
		["적중도"] = "CR_HIT",
		["치명타 및 주문 극대화 적중도"] = "CR_CRIT",
		["원거리 치명타 적중도"] = "CR_RANGEDCRIT",
		["방어 숙련도"] = "CR_DEFENSE",
		["탄력도"] = "CR_RESILIENCE",
		["회피 숙련도"] = "CR_DODGE",
		["방패 막기 숙련도"] = "CR_BLOCK",
		["무기 막기 숙련도"] = "CR_PARRY",
		["도끼류 숙련도"] = "CR_WEAPON_AXE",
		["단검류 숙련도"] = "CR_WEAPON_DAGGER",
		["둔기류 숙련도"] = "CR_WEAPON_MACE",
		["도검류 숙련도"] = "CR_WEAPON_SWORD",
		["양손 도검류 숙련도"] = "CR_WEAPON_SWORD_2H",
		["야생 전투 숙련도"] = "CR_WEAPON_FERAL",
		["방패 막기"] = "CR_BLOCK",
		["가속도"] = "CR_HASTE",
		["맨손 전투 숙련도"] = "CR_WEAPON_FIST",  -- unarmed skill
		["장착 무기류 숙련도"] = "CR_WEAPON_FIST",
		["석궁류 숙련도"] = "CR_WEAPON_CROSSBOW",
		["총기류 숙련도"] = "CR_WEAPON_GUN",
		["활류 숙련도"] = "CR_WEAPON_BOW",
		["지팡이류 숙련도"] = "CR_WEAPON_STAFF",
		["양손 둔기류 숙련도"] = "CR_WEAPON_MACE_2H",
		["양손 도끼류 숙련도"] = "CR_WEAPON_AXE_2H",
		["숙련도"] = "CR_EXPERTISE",
		["방어구 관통력"] = "CR_ARMOR_PENETRATION",
	},


	PATTERNS_PASSIVE = {
		{ pattern = "원거리 전투력이 (%d+)만큼 증가합니다%.", effect = "RANGEDATTACKPOWER" },
		{ pattern = "방패의 피해 방어량이 (%d+)만큼 증가합니다%.", effect = "BLOCKVALUE" },
		{ pattern = "언데드 공격 시 전투력이 (%d+)만큼 증가합니다%.", effect = "ATTACKPOWERUNDEAD", nofinish = true },
		{ pattern = "야수 공격 시 전투력이 (%d+)만큼 증가합니다%.", effect = "ATTACKPOWERBEAST" },
		{ pattern = "악마 공격 시 전투력이 (%d+)만큼 증가합니다%.", effect = "ATTACKPOWERDEMON" },
		{ pattern = "정령 공격 시 전투력이 (%d+)만큼 증가합니다%.", effect = "ATTACKPOWERELEMENTAL" }, -- 18310
		{ pattern = "용족 공격 시 전투력이 (%d+)만큼 증가합니다%.", effect = "ATTACKPOWERDRAGON" }, -- 19961
		{ pattern = "언데드와 악마 공격 시 전투력이 (%d+)만큼 증가합니다%.", effect = {"ATTACKPOWERUNDEAD", "ATTACKPOWERDEMON"}, nofinish = true }, -- 23206
		{ pattern = "매 5초마다 (%d+)의 생명력이 회복됩니다%.", effect = "HEALTHREG" },
		{ pattern = "매 5초마다 (%d+)의 생명력을 재생시킵니다%.", effect = "HEALTHREG" }, -- 833, 17743
		{ pattern = "매 5초마다 (%d+)의 마나가 회복됩니다%.", effect = "MANAREG" },

		-- Atiesh related patterns
		{ pattern = "주위 %d+미터 반경 내에 있는 모든 파티원의 마나가 매 5초마다 (%d+)만큼 회복됩니다%.", effect = "MANAREG" },
		{ pattern = "주위 %d+미터 반경에 있는 모든 파티원의 주문 극대화 확률이 (%d+)%%만큼 증가합니다%.", effect = "SPELLCRIT" },

		-- Added for HealPoints
		{ pattern = "시전 중에도 평소의 (%d+)%%에 달하는 속도로 마나가 회복됩니다%.", effect = "CASTINGREG"},
		{ pattern = "재생의 시전 시간이 0%.(%d+)초만큼 단축됩니다%.", effect = "CASTINGREGROWTH"},
		{ pattern = "성스러운 빛의 시전 시간이 0%.(%d+)초 만큼 단축됩니다%.", effect = "CASTINGHOLYLIGHT"},
		{ pattern = "치유의 손길의 시전 시간이 0%.(%d+)초 만큼 단축됩니다%.", effect = "CASTINGHEALINGTOUCH"},
		{ pattern = "순간 치유의 시전 시간이 0%.(%d+)초만큼 단축됩니다%.", effect = "CASTINGFLASHHEAL"},
		{ pattern = "연쇄 치유의 시전 시간이 0%.(%d+)초만큼 단축됩니다%.", effect = "CASTINGCHAINHEAL"},
		{ pattern = "회복의 지속시간이 (%d+)만큼 증가합니다%.", effect = "DURATIONREJUV"},
		{ pattern = "소생의 지속시간이 (%d+)초만큼 증가합니다%.", effect = "DURATIONRENEW"},
		{ pattern = "평상시 생명력과 마나의 회복 속도를 (%d+)만큼 향상시킵니다%.", effect = "MANAREGNORMAL" },
		{ pattern = "연쇄 치유 사용 시 처음 회복되는 대상 외에 치유되는 생명력이 각각 (%d+)%%만큼 증가합니다%.", effect = "IMPCHAINHEAL"},
		{ pattern = "회복에 의한 치유량이 최대 (%d+)까지 증가합니다%.", effect = "IMPREJUVENATION"},
		{ pattern = "하급 치유의 물결에 의한 치유량이 최대 (%d+)까지 증가합니다%.", effect = "IMPLESSERHEALINGWAVE"},
		{ pattern = "빛의 섬광에 의한 치유량이 최대 (%d+)만큼 증가합니다%.", effect = "IMPFLASHOFLIGHT"},
		{ pattern = "치유의 물결이나 하급 치유의 물결 시전 후 25%%의 확률로 소비된 마나의 (%d+)%%를 다시 회복합니다%.", effect = "REFUNDHEALINGWAVE"},
		{ pattern = "치유의 물결 사용 시 추가로 주위 아군을 연쇄적으로 회복시킵니다%. 대상이 바뀔 때마다 치유 효과는 (%d+)%%씩 감소됩니다%. 최대 2명의 추가 대상에게 효력을 미칩니다%.", effect = "JUMPHEALINGWAVE"},
		{ pattern = "치유의 손길%, 재생%, 회복%, 평온에 소비되는 마나가 (%d+)%%만큼 감소합니다%.", effect = "CHEAPERDRUID"},
		{ pattern = "치유의 손길이 극대화 효과를 발휘할 시 주문에 소비된 마나의 (%d+)%%만큼을 회복합니다%.", effect = "REFUNDHTCRIT"},
		{ pattern = "소생에 소비되는 마나가 (%d+)%%만큼 감소합니다%.", effect = "CHEAPERRENEW"},

		{ pattern = "주문 관통력이 (%d+)만큼 증가합니다%.", effect = "SPELLPEN" },
		{ pattern = "주문력이 (%d+)만큼 증가합니다%.", effect = "SPELLPOWER" },
		{ pattern = "전투력이 (%d+)만큼 증가합니다%.", effect = "ATTACKPOWER" },
		{ pattern = "표범, 광포한 곰, 곰, 달빛야수 변신 상태일 때 전투력이 (%d+)만큼 증가합니다%.", effect = "ATTACKPOWERFERAL" },
		{ pattern = "매 4초마다 (%d+)의 생명력이 회복됩니다%.", effect = "HEALTHREG" }, -- 6461 (typo ?)
		{ pattern = "은신의 효과 레벨이 (%d+)만큼 증가합니다%.", effect = "STEALTH" },
		{ pattern = "원거리 무기 공격 속도가 (%d+)%%만큼 증가합니다%.", effect = "RANGED_SPEED_BONUS" }, -- bags are not scanned
		{ pattern = "%d+미터 반경 내의 파티원의 체력을 (%d+)만큼 증가시킵니다%.", effect = "STA" }, -- 4248
		{ pattern = "수영 속도가 (%d+)%%만큼 증가합니다.%.", effect = "SWIMSPEED" }, -- 7052
		{ pattern = "탈것의 속도가 (%d+)%%만큼 증가합니다", effect = "MOUNTSPEED" }, -- 11122
		{ pattern = "달리기 속도가 (%d+)%%만큼 증가합니다%.", effect = "RUNSPEED" }, -- 13388
		{ pattern = "무기 막기 확률이 (%d+)%%만큼 감소합니다%.", effect = "NEGPARRY" }, -- 7348
		{ pattern = "기절과 공포에 저항할 확률이 (%d+)%%만큼 증가합니다%.", effect = {"STUNRESIST", "FEARRESIST"} }, -- 17759
		{ pattern = "공포에 저항할 확률이 (%d+)%%만큼 증가합니다%.", effect = "FEARRESIST" }, -- 28428, 28429, 28430
		{ pattern = "기절 및 방향 감각 상실 효과를 저항할 확률이 (%d+)%%만큼 증가합니다%.", effect = {"STUNRESIST", "DISORIENTRESIST"} }, -- 23839
		{ pattern = "탈것의 속도가 (%d+)%%만큼 증가합니다%.", effect = "MOUNTSPEED" }, -- 25653
		{ pattern = "근접 피해 (%d+)만큼 감소%.", effect = "MELEETAKEN" }, -- 31154
		{ pattern = "받는 주문 피해가 (%d+)만큼 감소합니다%.", effect = "DMGTAKEN" }, -- 22191
		{ pattern = "원거리 치명타 적중도가 %(%+(%d+)만큼 증가합니다%.)", effect = "CR_RANGEDCRIT" },

		-- metagem bonuses (thanks Lerkur)
--		{ pattern = "%+(%d+) Agility & (%d+)%% Increased Critical Damage", effect = {"AGI", "CRITDMG"} },
--		{ pattern = "%+(%d+) Defense Rating & %+(%d+)%% Shield Block Value", effect = {"CR_DEFENSE", "MOD_BLOCKVALUE"} },
	},

	SEPARATORS = { "/", ",", "&", " and " },

	GENERIC_PATTERNS = {
		["^%+?(%d+)%%?(.*)$"]	= true,
		["^(.*)%+ ?(%d+)%%?$"]	= false,
		["^(.*): ?(%d+)$"]		= false
	},

	PATTERNS_GENERIC_LOOKUP = {
		["모든 능력치"] = ALL_STATS,
		["힘"] = "STR",
		["민첩성"] = "AGI",
		["체력"] = "STA",
		["지능"] = "INT",
		["정신력"] = "SPI",

		["모든 저항력"] = ALL_RESISTS,

		["낚시"] = "FISHING",
		["낚시용 미끼"] = "FISHING",
		["낚시 숙련도"] = "FISHING",
		["채광"] = "MINING",
		["약초 채집"] = "HERBALISM",
		["무두질"] = "SKINNING",
		["방어 숙련도"] = "CR_DEFENSE",
		["방어 숙련도 증가"] = "DEFENSE",

		["전투력"] = "ATTACKPOWER",
		["언데드 공격 시 전투력"] = "ATTACKPOWERUNDEAD",

		["회피율"] = "DODGE",
		["방어율"] = "BLOCKVALUE",
		["방패 피해 방어량"] = "BLOCKVALUE",
		["방패 막기 숙련도"] = "CR_BLOCK",
		["적중률"] = "TOHIT",
		["방어율"] = "BLOCK",  -- Blocking
		["원거리 전투력"] = "RANGEDATTACKPOWER",
		["5초당 생명력 회복"] = "HEALTHREG",
		["치명타"] = "CRIT",
		["치명타 공격"] = "CRIT",
		["생명력"] = "HEALTH",
		["HP"] = "HEALTH",
		["마나"] = "MANA",
		["방어도"] = "BASE_ARMOR",
		["방어도 보강"] = "ARMOR_BONUS",
		["탄력성"] = "CR_RESILIENCE",
		["주문 관통력"] = "SPELLPEN",
		["적중도"] = "CR_HIT",
		["방어 숙련도"] = "CR_DEFENSE",
		["탄력도"] = "CR_RESILIENCE",
		["숙련도"] = "CR_EXPERTISE",
		["극대화 적중도"] = "CR_CRIT",  -- Crit Rating
--		["Critical Rating"] = "CR_CRIT",
		["치명타 적중도"] = "CR_CRIT",
		["회피 숙련도"] = "CR_DODGE",
		["무기 막기 숙련도"] = "CR_PARRY",
		["가속도"] = "CR_HASTE",
		["5초당 마나 회복"] = "MANAREG",
		["마나 회복량이 5초당"] = "MANAREG",  -- Mana per 5 Seconds
		["마나 회복량 5초당"] = "MANAREG",  -- Mana every 5 seconds
		["5초당 마나 회복량"] = "MANAREG",
		["매 5초마나 마나 회복"] = "MANAREG",  -- mana per 5 sec
		["5초당 마나 회복"] = "MANAREG",
		["마나 회복량"] = "MANAREG",
		["근접 공격력"] = "MELEEDMG",
		["무기 공격력"] = "MELEEDMG",
		["모든 저항"] = ALL_RESISTS,
		["위협 감소"] = "THREATREDUCTION",
		["양손 도끼류 숙련도"] = "CR_WEAPON_AXE_2H",
		["기절 저항력"] = "STUNRESIST",
		["주문력"] = "SPELLPOWER",
	},

	PATTERNS_GENERIC_STAGE1 = {
		{ pattern = "비전", 	effect = "ARCANE" },
		{ pattern = "화염", 	effect = "FIRE" },
		{ pattern = "냉기", 	effect = "FROST" },
		{ pattern = "신성", 	effect = "HOLY" },
		{ pattern = "암흑", 	effect = "SHADOW" },
		{ pattern = "자연", 	effect = "NATURE" }
	},

	PATTERNS_GENERIC_STAGE2 = {
		{ pattern = "저항",	effect = "RES" },
		{ pattern = "피해", 	effect = "SPELLPOWER" },
	},

	PATTERNS_OTHER = {
--		{ pattern = "방어도 %(%+(%d+)만큼 증가%)", effect = "ARMOR_BONUS" },
		{ pattern = "5초당 (%d+)의 마나가 회복됩니다%.", effect = "MANAREG" },

		{ pattern = "최하급 마술사 오일", effect = "SPELLPOWER", value = 8 },
		{ pattern = "하급 마술사 오일", effect = "SPELLPOWER", value = 16 },
		{ pattern = "마술사 오일", effect = "SPELLPOWER", value = 24 },
		{ pattern = "반짝이는 마술사 오일", effect = {"SPELLPOWER", "SPELLCRIT"}, value = {36, 1} },

		{ pattern = "최하급 마나 오일", effect = "MANAREG", value = 4 },
		{ pattern = "하급 마나 오일", effect = "MANAREG", value = 8 },
		{ pattern = "반짝이는 마나 오일", effect = { "MANAREG", "HEAL"}, value = {12, 25} },

		{ pattern = "에터니움 낚시줄", effect = "FISHING", value = 5 },
		{ pattern = "활력", effect = {"MANAREG", "HEALTHREG"}, value = {4, 4} },
		{ pattern = "냉기의 영혼", effect = {"FROSTSPELLPOWER", "SHADOWSPELLPOWER"}, value = {54, 54} },
		{ pattern = "태양의 불꽃", effect = {"ARCANESPELLPOWER", "FIRESPELLPOWER"}, value = {50, 50} },
		{ pattern = "전투력", effect = "ATTACKPOWER", value = 70 },
		{ pattern = "침착함", effect = {"CR_HIT", "SNARERES"}, value = {10, 5} }, -- check
		{ pattern = "방어도가 5만큼, 암흑 저항력이 10만큼 증가하고 5초마다 3의 생명력이 회복됩니다.", effect = {"CR_DEFENSE", "SHADOWRES", "HEALTHREG_P"}, value = {5, 10, 3} },  -- Increases defense rating by 5, Shadow resistance by 10 and your normal health regeneration by 3%.
		{ pattern = "위협 수준을 %+2%%만큼", effect = "THREATREDUCTION", value = -2 },  -- %+2%% Threat
		{ pattern = "미묘함", effect = "THREATREDUCTION", value = 2 },

		{ pattern = "물속에서 숨쉴 수 있도록 해줍니다%.", effect = "UNDERWATER", value = 1 }, -- 10506
		{ pattern = "자물쇠 따기 숙련도가 약간 증가합니다%.", effect = "LOCKPICK", value = 1 },
		{ pattern = "은신 감지 능력이 약간 증가합니다%.", effect = "STEALTHDETECT", value = 18 }, -- 10501
		{ pattern = "은신 감지가 증가합니다%.", effect = "STEALTHDETECT", value = 10 }, -- 22863, 23280, 31333
		{ pattern = "무장 해제에 면역이 됩니다%.", effect = "DISARMIMMUNE", value = 1 }, -- 12639
		{ pattern = "달리기 속도가 약간 증가합니다%.", effect = {"RUNSPEED", "SWIMSPEED"}, value = {8,8} }, -- 19685
		{ pattern = "낙하 피해가 감소됩니다%.", effect = "SLOWFALL", value = 1 }, -- 19982
		{ pattern = "이동 속도와 생명력 회복 속도가 증가합니다%.", effect = {"RUNSPEED", "HEALTHREG"}, value = {8,20} }, -- 13505
		{ pattern = "달리기 속도가 약간 증가합니다%.", effect = "RUNSPEED", value = 8 }, -- 20048, 25835, 29512
		{ pattern = "은신 능력이 약간 증가합니다%.", effect = "STEALTH", value = 3 }, -- 21758
		{ pattern = "은신 효과가 증가합니다%.", effect = "STEALTH", value = 8 }, -- 22003, 23073
		{ pattern = "주문력이 약간 증가합니다%.", effect = "SPELLPOWER", value = 6 }, -- 30804

--		{ pattern = "멋진 패션 감각으로 주위를 감동시킵니다%.", effect = "IMPRESS", value = 1 }, -- 10036
--		{ pattern = "모조를 증가시킵니다%.", effect = "MOJO", value = 1 }, -- 23717
	},
}
