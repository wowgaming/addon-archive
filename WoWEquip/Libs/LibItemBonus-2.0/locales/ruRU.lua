if GetLocale() ~= "ruRU" then return end

local lib = LibStub("LibItemBonus-2.0")

if not lib._LOADING then return end


	local ALL_RESISTS = {"ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}
	local ALL_STATS = {"STR", "AGI", "STA", "INT", "SPI"}
lib.patterns = {
	NAMES = {
		STR = "Сила",
		AGI = "Ловкость",
		STA = "Выносливость",
		INT = "Интеллект",
		SPI = "Дух",
		ARMOR = "Броня",
		BASE_ARMOR = "Базовая броня",
		ARMOR_BONUS = "Бонус к броне",

		ARCANERES = "Устойчивость к тайной магии",
		FIRERES = "Устойчивость к огню",
		NATURERES = "Устойчивость к силам природы",
		FROSTRES = "Устойчивость к льду",
		SHADOWRES = "Устойчивость к темной магии",

		FISHING = "Рыбалка",
		MINING = "Мининг",
		HERBALISM = "Травничество",
		SKINNING = "Снятие шкур",
		DEFENSE = "Защита",

		BLOCK = "Шанс блока",
		BLOCKVALUE = "Величина блока",
		DODGE = "Уклонение",
		PARRY = "Парирование",
		ATTACKPOWER = "Сила атаки",
		ATTACKPOWERUNDEAD = "Сила атаки против нежити",
		ATTACKPOWERBEAST = "Сила атаки против животных",
		ATTACKPOWERFERAL = "Сила атаки в формах (ферал)",
		CRIT = "Критический удар",
		RANGEDATTACKPOWER = "Сила атаки дальнего боя",
		RANGEDCRIT = "Крит дальнего боя",
		TOHIT = "Меткость",
		THREATREDUCTION = "Снижение угрозы",

		SPELLPOWER = "Мощь заклинаний",
		SPELLCRIT = "Крит заклинаниями",
		SPELLTOHIT = "Меткость заклинаний",
		SPELLPEN = "Проникновение заклинаний",
		HOLYCRIT = "Крит святой магией",

		HEALTHREG = "Реген здоровья",
		MANAREG = "Реген маны",
		HEALTH = "Здоровье",
		MANA = "Мана",

		CR_WEAPON = "Weapon rating",
		CR_DEFENSE = "Рейтниг защиты",
		CR_DODGE = "Рейтинг уклонения",
		CR_PARRY = "Рейтинг парирования",
		CR_BLOCK = "Рейтинг блока",
		CR_HIT = "Рейтинг меткости",
		CR_CRIT = "Рейтинг критического удара",
		CR_HASTE = "Рейтинг скорости боя",
		CR_EXPERTISE = "Рейтинг мастерства",
		CR_RESILIENCE = "Рейтинг устойчивости",
		CR_WEAPON_AXE = "Axe skill rating",
		CR_WEAPON_DAGGER = "Dagger skill rating",
		CR_WEAPON_MACE = "Mace skill rating",
		CR_WEAPON_SWORD = "Sword skill rating",
		CR_WEAPON_SWORD_2H = "Two-Handed Swords skill rating",
		CR_ARMOR_PENETRATION = "рейтинг пробивания брони",

		SNARERES = "Snare and Root effects Resistance",

	---				DMGUNDEAD = "Дамаг заклинаниями против нежити",
	---				ARCANEDMG = "Дамаг тайной магией",
	---				FIREDMG = "Дамаг огнем",
	---				FROSTDMG = "Дамаг льдом",
	---				HOLYDMG = "Дамаг святой магией",
	---				NATUREDMG = "Дамаг силами природы",
	---				SHADOWDMG = "Дамаг темной магией",
	---				HEAL = "Хил",
	},

	PATTERNS_SKILL_RATING = {
	--	{ pattern = "Increases your (.*) rating by (%d+)" },
		{ pattern = "Увеличивает рейтинг (.*) на (%d+)" },
		{ pattern = "Увеличение на (%d+) ед%. (.*)" },
	--	{ pattern = "Improves your (.*) rating by (%d+)" },
		{ pattern = "%+(%d+) к рейтингу (.*)", invert = false},
		{ pattern = "%+(%d+) к (.*)", invert = false},
		{ pattern = "Рейтинг (.*) %+(%d+)" },
		{ pattern = "увеличение рейтинга (.*) на (%d+)" },
	--	{ pattern = "(.*):%+(%d+)"},
	},

	SKILL_NAMES = {
---		["меткости (заклинания)"] = "CR_SPELLHIT",
		["меткости"] = "CR_HIT",
---		["критического удара (заклинания)"] = "CR_SPELLCRIT",
		["критического удара"] = "CR_CRIT",
		["крит. удара оруж. ближнего боя"] = "CR_CRIT",
		["проникающей способности заклинаний на%."] = "SPELLPEN",
		["проникающей способности заклинаний"] = "SPELLPEN",
		["критического урона атак дальнего боя"] = "CR_RANGEDCRIT",
		["защиты"] = "CR_DEFENSE",
		["устойчивости"] = "CR_RESILIENCE",
		["уклонения"] = "CR_DODGE",
		["блокирования щитом"] = "CR_BLOCK",
		["парирования"] = "CR_PARRY",
		["axe skill"] = "CR_WEAPON_AXE",
		["dagger skill"] = "CR_WEAPON_DAGGER",
		["mace skill"] = "CR_WEAPON_MACE",
		["sword skill"] = "CR_WEAPON_SWORD",
		["two-handed sword skill"] = "CR_WEAPON_SWORD_2H",
		["feral combat skill"] = "CR_WEAPON_FERAL",
		["блокирования щитом"] = "CR_BLOCK",
---		["скорости боя (заклинания)"] = "CR_SPELLHASTE",
		["скорости боя"] = "CR_HASTE",
		["unarmed skill"] = "CR_WEAPON_FIST",
		["fist skill"] = "CR_WEAPON_FIST",
		["crossbow skill"] = "CR_WEAPON_CROSSBOW",
		["gun skill"] = "CR_WEAPON_GUN",
		["bow skill"] = "CR_WEAPON_BOW",
		["staff skill"] = "CR_WEAPON_STAFF",
		["two-handed maces skill"] = "CR_WEAPON_MACE_2H",
		["two-handed axes skill"] = "CR_WEAPON_AXE_2H",
		["мастерства"] = "CR_EXPERTISE",
		["пробивания брони"] = "CR_ARMOR_PENETRATION",
	},


	PATTERNS_PASSIVE = {
		{ pattern = "Увеличение силы атаки в дальнем бою на на (%d+) ед%.", effect = "RANGEDATTACKPOWER" },
		{ pattern = "Увеличение показателя блока щитом на (%d+) ед%.", effect = "BLOCKVALUE" },
--~ 		{ pattern = "Increases attack power by (%d+) when fighting Undead%.", effect = "ATTACKPOWERUNDEAD", nofinish = true },
--~ 		{ pattern = "Increases attack power by (%d+) when fighting Beasts%.", effect = "ATTACKPOWERBEAST" },
--~ 		{ pattern = "Increases attack power by (%d+) when fighting Demons%.", effect = "ATTACKPOWERDEMON" },
--~ 		{ pattern = "Increases attack power by (%d+) when fighting Elementals%.", effect = "ATTACKPOWERELEMENTAL" }, -- 18310
--~ 		{ pattern = "Increases attack power by (%d+) when fighting Dragonkin%.", effect = "ATTACKPOWERDRAGON" }, -- 19961
--~ 		{ pattern = "Increases attack power by (%d+) when fighting Undead and Demons%.", effect = {"ATTACKPOWERUNDEAD", "ATTACKPOWERDEMON"}, nofinish = true }, -- 23206
		{ pattern = "Восполнение (%d+) ед%. здоровья раз в 5 сек%.", effect = "HEALTHREG" },
		{ pattern = "Восполнение (%d+) ед%. здоровья каждые 5 сек%.", effect = "HEALTHREG" },
		{ pattern = "Восполнение (%d+) ед%. маны раз в 5 сек%.", effect = "MANAREG" },
		{ pattern = "%+(%d+) ед%. маны каждые 5 секунд", effect = "MANAREG" },
		{ pattern = "(%d+) ед%. маны каждые 5 секунд", effect = "MANAREG" },
		{ pattern = "Эффективность брони противника против ваших атак снижена на (%d+) ед%.", effect = "IGNOREARMOR" },

		{ pattern = "%+(%d+) к урону от темной магии", effect = "SHADOWDMG" },

---				{ pattern = "Увеличение урона, наносимого заклинаниями и эффектами тайной магии, на (%d+) ед%.", effect = "ARCANEDMG" },
---				{ pattern = "Увеличение наносимого урона от заклинаний и эффектов огня не более чем на (%d+) ед%.", effect = "FIREDMG" },
---				{ pattern = "Увеличение урона, наносимого заклинаниями и эффектами льда, на (%d+) ед%.", effect = "FROSTDMG" },
---				{ pattern = "Увеличение урона, наносимого заклинаниями и эффектами светлой магии, на (%d+) ед%.", effect = "HOLYDMG" },
---				{ pattern = "Увеличение урона, наносимого заклинаниями и эффектами сил природы, на (%d+) ед%.", effect = "NATUREDMG" },
---				{ pattern = "Увеличение урона, наносимого заклинаниями и эффектами темной магии, на (%d+) ед%.", effect = "SHADOWDMG" },
---				{ pattern = "Increases healing done by spells and effects by up to (%d+)%.", effect = "HEAL" },
---				{ pattern = "Увеличение исцеляющих эффектов на (%d+) ед%. и урона от всех магических заклинаний и эффектов на (%d+) ед%.", effect = HEAL_AND_DMG },
---				{ pattern = "Увеличение урона и целительного действия магических заклинаний и эффектов не более чем на (%d+) ед.", effect = HEAL_AND_DMG },
---				{ pattern = "Increases damage done to Undead by magical spells and effects by up to (%d+)%.", effect = "DMGUNDEAD", nofinish = true },
---				{ pattern = "Increases damage done to Demons by magical spells and effects by up to (%d+)%.", effect = "DMGDEMON" },
---				{ pattern = "Increases damage done to Undead and Demons by magical spells and effects by up to (%d+)%.", effect = {"DMGUNDEAD", "DMGDEMON"}, nofinish = true },

		-- Atiesh related patterns
---				{ pattern = "Increases your spell damage by up to (%d+) and your healing by up to (%d+)%.", effect = {"DMG", "HEAL"} },
---				{ pattern = "Increases healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%.", effect = "HEAL" },
---				{ pattern = "Increases damage and healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%.", effect = HEAL_AND_DMG },
--~ 		{ pattern = "Restores (%d+) mana per 5 seconds to all party members within %d+ yards%.", effect = "MANAREG" },
--~ 		{ pattern = "Increases the spell critical chance of all party members within %d+ yards by (%d+)%%%.", effect = "SPELLCRIT" },

		-- Added for HealPoints
--~ 		{ pattern = "Allow (%d+)%% of your Mana regeneration to continue while casting%.", effect = "CASTINGREG"},
--~ 		{ pattern = "Reduces the casting time of your Regrowth spell by 0%.(%d+) sec%.", effect = "CASTINGREGROWTH"},
--~ 		{ pattern = "Reduces the casting time of your Holy Light spell by 0%.(%d+) sec%.", effect = "CASTINGHOLYLIGHT"},
--~ 		{ pattern = "Reduces the casting time of your Healing Touch spell by 0%.(%d+) sec%.", effect = "CASTINGHEALINGTOUCH"},
--~ 		{ pattern = "%-0%.(%d+) sec to the casting time of your Flash Heal spell%.", effect = "CASTINGFLASHHEAL"},
--~ 		{ pattern = "%-0%.(%d+) seconds on the casting time of your Chain Heal spell%.", effect = "CASTINGCHAINHEAL"},
--~ 		{ pattern = "Increases the duration of your Rejuvenation spell by (%d+) sec%.", effect = "DURATIONREJUV"},
--~ 		{ pattern = "Increases the duration of your Renew spell by (%d+) sec%.", effect = "DURATIONRENEW"},
--~ 		{ pattern = "Increases your normal health and mana regeneration by (%d+)%.", effect = "MANAREGNORMAL"},
--~ 		{ pattern = "Increases the amount healed by Chain Heal to targets beyond the first by (%d+)%%%.", effect = "IMPCHAINHEAL"},
--~ 		{ pattern = "Increases healing done by Rejuvenation by up to (%d+)%.", effect = "IMPREJUVENATION"},
--~ 		{ pattern = "Increases healing done by Lesser Healing Wave by up to (%d+)%.", effect = "IMPLESSERHEALINGWAVE"},
--~ 		{ pattern = "Increases healing done by Flash of Light by up to (%d+)%.", effect = "IMPFLASHOFLIGHT"},
--~ 		{ pattern = "After casting your Healing Wave or Lesser Healing Wave spell%, gives you a 25%% chance to gain Mana equal to (%d+)%% of the base cost of the spell%.", effect = "REFUNDHEALINGWAVE"},
--~ 		{ pattern = "Your Healing Wave will now jump to additional nearby targets%. Each jump reduces the effectiveness of the heal by (%d+)%%%, and the spell will jump to up to two additional targets%.", effect = "JUMPHEALINGWAVE"},
--~ 		{ pattern = "Reduces the mana cost of your Healing Touch%, Regrowth%, Rejuvenation and Tranquility spells by (%d+)%%%.", effect = "CHEAPERDRUID"},
--~ 		{ pattern = "On Healing Touch critical hits%, you regain (%d+)%% of the mana cost of the spell%.", effect = "REFUNDHTCRIT"},
--~ 		{ pattern = "Reduces the mana cost of your Renew spell by (%d+)%%%.", effect = "CHEAPERRENEW"},

		{ pattern = "Увеличение на (%d+) ед%. проникающей способности заклинаний на%.", effect = "SPELLPEN" },
		{ pattern = "Увеличивает силу заклинаний на (%d+)%.", effect = "SPELLPOWER" },
		{ pattern = "Увеличивает силу заклинаний на (%d+) ед%.", effect = "SPELLPOWER" },
		{ pattern = "Увеличивает силу атаки на (%d+)%.", effect = "ATTACKPOWER" },
		{ pattern = "Увеличивает силу атаки на (%d+) ед%. в облике кошки, медведя, лютого медведя или лунного совуха%.", effect = "ATTACKPOWERFERAL" },
--~ 		{ pattern = "Restores (%d+) health every 4 sec%.", effect = "HEALTHREG" }, -- 6461 (typo ?)
		{ pattern = "Увеличение уровня эффективного действия незаметности на (%d+)%.", effect = "STEALTH" },
--~ 		{ pattern = "Increases ranged attack speed by (%d+)%%%.", effect = "RANGED_SPEED_BONUS" }, -- bags are not scanned
--~ 		{ pattern = "Gives (%d+) additional stamina to party members within %d+ yards%.", effect = "STA" }, -- 4248
--~ 		{ pattern = "Increases swim speed by (%d+)%%%.", effect = "SWIMSPEED" }, -- 7052
		{ pattern = "Увеличение скорости верхового животного на (%d+)%%%.", effect = "MOUNTSPEED" }, -- 11122
		{ pattern = "Увеличение скорости передвижения в облике птицы и облике стремительной птицы на (%d+)%%%.", effect = "MOUNTSPEED" }, -- 11122
--~ 		{ pattern = "Increases run speed by (%d+)%%%.", effect = "RUNSPEED" }, -- 13388
--~ 		{ pattern = "Decreases your chance to parry an attack by (%d+)%%%.", effect = "NEGPARRY" }, -- 7348
--~ 		{ pattern = "Increases your chance to resist Stun and Fear effects by (%d+)%%%.", effect = {"STUNRESIST", "FEARRESIST"} }, -- 17759
--~ 		{ pattern = "Increases your chance to resist Fear effects by (%d+)%%%.", effect = "FEARRESIST" }, -- 28428, 28429, 28430
--~ 		{ pattern = "Increases your chance to resist Stun and Disorient effects by (%d+)%%%.", effect = {"STUNRESIST", "DISORIENTRESIST"} }, -- 23839
--~ 		{ pattern = "Increases mount speed by (%d+)%%%.", effect = "MOUNTSPEED" }, -- 25653
--~ 		{ pattern = "Reduces melee damage taken by (%d+)%.", effect = "MELEETAKEN" }, -- 31154
--~ 		{ pattern = "Spell Damage received is reduced by (%d+)%.", effect = "DMGTAKEN" }, -- 22191
		{ pattern = "Прицел %(%+(%d+) к рейтингу критического удара%)", effect = "CR_RANGEDCRIT" },
		{ pattern = "Оснащение лука или огнестрельного оружия прицелом, повышающим рейтинг критического урона на (%d+) ед%.", effect = "CR_RANGEDCRIT" },

		-- metagem bonuses (thanks Lerkur)
--~ 		{ pattern = "%+(%d+) к ловкости и на (%d+)%% увеличенный критический урон", effect = {"AGI", "CRITDMG"} },
--~ 		{ pattern = "%+(%d+) Spell Critical & (%d+)%% Increased Critical Damage", effect = {"CR_SPELLCRIT", "SPELLCRITDMG"} },
--~ 		{ pattern = "%+(%d+) Defense Rating & %+(%d+)%% Shield Block Value", effect = {"CR_DEFENSE", "MOD_BLOCKVALUE"} },
	--	{ pattern = "%+(%d+) к интеллекту и вероятность восполнить ману при применении заклинаний", effect = {"INT"} },
---				{ pattern = "%+(%d+) к урону от заклинаний и %+(%d+)%% к интеллекту", effect = {"HEAL_AND_DMG", "MOD_INT"} },
	--	{ pattern = "%+(%d+) к силе атаки и небольшое увеличение скорости бега", effect = {"ATTACKPOWER"} },
	},

	SEPARATORS = { "/", ",", "&", " и "},

	GENERIC_PATTERNS = {
		["^(.+): %+(%d+)$"] = false,
		["^(.+): (%d+)$"] = false,
		["^%+?(%d+)% к ?(.*)"]	= true,
		["^%+?(%d+)% ?(.*)"]	= true,
	--	["^%+?(%d+)%%?(.*)"]	= true,
		["^(.*)%+?(%d+)%%?"]	= true,
	--	["^(.*):%+?(%d+)$"]	= true,
		["^(.*): %+(%d+)$"] = false,
		["^(.*): (%d+)$"] = false,
	},

	PATTERNS_GENERIC_LOOKUP = {
		["ко всем характеристикам"] = ALL_STATS,
		["сила"] = "STR",
		["к силе"] = "STR",
		["силе"] = "STR",
		["ловкость"] = "AGI",
		["ловкости"] = "AGI",
		["выносливость"] = "STA",
		["к выносливости"] = "STA",
		["выносливости"] = "STA",
		["интеллект"] = "INT",
		["к интеллекту"] = "INT",
		["интеллекту"] = "INT",
		["дух"] = "SPI",
		["духу"] = "SPI",
		["к духу"] = "SPI",
		["сопротивление всем видам магии"] = ALL_RESISTS,
		["к cиле атаки"] = "ATTACKPOWER",
		["к ловкости"] = "AGI",
		["к броне"] = "ARMOR_BONUS",
		["Рыбная ловля"] = "FISHING",
--~ 	["Fishing Lure"] = "FISHING",
--~ 	["Increased Fishing"] = "FISHING",
--~ 	["Mining"] = "MINING",
--~ 	["Herbalism"] = "HERBALISM",
--~ 	["Skinning"] = "SKINNING",
		["защиты"] = "CR_DEFENSE",
--~ 	["Increased Defense"] = "DEFENSE",

		["Сила атаки"] = "ATTACKPOWER",
		["Силу атаки"] = "ATTACKPOWER",
		["cиле атаки"] = "ATTACKPOWER",
		["к силе атаки"] = "ATTACKPOWER",
--~ 	["Attack Power when fighting Undead"] = "ATTACKPOWERUNDEAD",
---		["к силе заклинаний"] = {"DMG", "HEAL"},
		["к силе заклинаний"]= "SPELLPOWER",
		["уклонение"] = "DODGE",-- не трогаю
		["блокирование"] = "BLOCKVALUE",
		["увеличение показателя блока щитом"] = "BLOCKVALUE",
		["Рейтинг блокирования щитом"] = "CR_BLOCK",			--	["SPELLTOHIT"] = "SPELLTOHIT", -- не трогаю
---		["Hit"] = "TOHIT",
		["к рейтингу меткости"] = "CR_HIT",
---		["Blocking"] = "BLOCK",
		["Сила атаки в дальнем бою"] = "RANGEDATTACKPOWER",
		["здоровья каждые 5 сек"] = "HEALTHREG",
		["здоровья раз в 5 сек"] = "HEALTHREG",
		["к урону от заклинаний"] = {"DMG", "HEAL"},
		["к урону от заклинаний и лечению"] = {"DMG", "HEAL"},
		["к здоровью"] = "HEALTH",
		["мана"] = "MANA",
		["Броня"] = "BASE_ARMOR",
---		["Reinforced Armor"] = "ARMOR_BONUS",
		["Устойчивости"] = "CR_RESILIENCE",
		["к мастерству"] = "CR_EXPERTISE",
		["к проникающей способности заклинаний"] = "SPELLPEN",
		["к рейтингу меткости"] = "CR_HIT",
		["к рейтингу защиты"] = "CR_DEFENSE",
		["к рейтингу устойчивости"] = "CR_RESILIENCE",
		["к рейтингу критического удара"] = "CR_CRIT",
		["критического удара"] = "CR_CRIT",
		["критического эффекта"] = "CR_CRIT",
		["к рейтингу уклонения"] = "CR_DODGE",
		["к рейтингу парирования"] = "CR_PARRY",
		["к рейтингу скорости боя"] = "CR_HASTE",
		["маны в 5 сек"] = "MANAREG",
		["маны каждые 5 сек"] = "MANAREG",
		["маны каждые 5 секунд"] = "MANAREG",
		["к восполнению маны"] = "MANAREG",
		["ед%. маны каждые 5 секунд"] = "MANAREG",

		["урон оружия"] = "MELEEDMG",
		["урон оружия ближнего боя"] = "MELEEDMG", -- наугад написал )
		["ко всем видам сопротивления"] = ALL_RESISTS,
---		["Reduced Threat"] = "THREATREDUCTION",
---		["Two-Handed Axe Skill Rating"] = "CR_WEAPON_AXE_2H",
		["к сопротивлению оглушению"] = "STUNRESIST",
		["единицы урона в секунду%)"] = "WEPDMG",
	},

	PATTERNS_GENERIC_STAGE1 = {
		{ pattern = "тайной магии", 	effect = "ARCANE" },
		{ pattern = "магии огня", 	effect = "FIRE" },
		{ pattern = "огню", 	effect = "FIRE" },
		{ pattern = "магии льда", 	effect = "FROST" },
		{ pattern = "светлой магии", 	effect = "HOLY" },
		{ pattern = "темной магии",	effect = "SHADOW" },
		{ pattern = "тьмы",	effect = "SHADOW" },
		{ pattern = "тьма",	effect = "SHADOW" },
		{ pattern = "Nature", 	effect = "NATURE" }
	},

	PATTERNS_GENERIC_STAGE2 = {
		{ pattern = "к сопротивлению", 	effect = "RES" },
		{ pattern = "устойчивость", 	effect = "RES" },
---		{ pattern = "силу заклинаний", 	effect = "SPELLPOWER" },


	--	{ pattern = "Effects", 	effect = "DMG" },
	},

	PATTERNS_OTHER = {
--~ 		{ pattern = "Reinforced %(%+(%d+) Armor%)", effect = "ARMOR_BONUS" },
--~ 		{ pattern = "Mana Regen (%d+) per 5 sec%.", effect = "MANAREG" },

--~ 		{ pattern = "Minor Wizard Oil", effect = "SPELLPOWER", value = 8 },
--~ 		{ pattern = "Lesser Wizard Oil", effect = "SPELLPOWER", value = 16 },
--~ 		{ pattern = "Wizard Oil", effect = "SPELLPOWER", value = 24 },
--~ 		{ pattern = "Brilliant Wizard Oil", effect = {"SPELLPOWER", "SPELLCRIT"}, value = {36, 36, 1} },

--~ 		{ pattern = "Minor Mana Oil", effect = "MANAREG", value = 4 },
--~ 		{ pattern = "Lesser Mana Oil", effect = "MANAREG", value = 8 },
--~ 		{ pattern = "Brilliant Mana Oil", effect = { "MANAREG", "HEAL"}, value = {12, 25} },

		{ pattern = "Сверхпрочная этерниевая леска", effect = "FISHING", value = 5 },
		{ pattern = "Живучесть", effect = {"MANAREG", "HEALTHREG"}, value = {4, 4} },
		{ pattern = "Душелед", effect = {"FROSTSPELLPOWER", "SHADOWSPELLPOWER"}, value = {54, 54} },
		{ pattern = "Солнечный огонь", effect = {"ARCANESPELLPOWER", "FIRESPELLPOWER"}, value = {50, 50} },
		{ pattern = "Свирепость", effect = "ATTACKPOWER", value = 70 },
		{ pattern = "Верный шаг", effect = {"CR_HIT", "SNARERES"}, value = {10, 5} },
--~ 		{ pattern = "Increases defense rating by 5, Shadow resistance by 10 and your normal health regeneration by 3%.", effect = {"CR_DEFENSE", "SHADOWRES", "HEALTHREG_P"}, value = {5, 10, 3} },
		{ pattern = "%+2%% угрозы", effect = "THREATREDUCTION", value = -2 },
		{ pattern = "Скрытность", effect = "THREATREDUCTION", value = 2 },

--~ 		{ pattern = "Allows underwater breathing%.", effect = "UNDERWATER", value = 1 }, -- 10506
--~ 		{ pattern = "Increases your lockpicking skill slightly%.", effect = "LOCKPICK", value = 1 },
--~ 		{ pattern = "Moderately increases your stealth detection%.", effect = "STEALTHDETECT", value = 18 }, -- 10501
--~ 		{ pattern = "Slightly increases your stealth detection%.", effect = "STEALTHDETECT", value = 10 }, -- 22863, 23280, 31333
--~ 		{ pattern = "Immune to Disarm%.", effect = "DISARMIMMUNE", value = 1 }, -- 12639
--~ 		{ pattern = "Minor increase to running and swimming speed%.", effect = {"RUNSPEED", "SWIMSPEED"}, value = {8,8} }, -- 19685
--~ 		{ pattern = "Reduces damage from falling%.", effect = "SLOWFALL", value = 1 }, -- 19982
--~ 		{ pattern = "Increases movement speed and life regeneration rate%.", effect = {"RUNSPEED", "HEALTHREG"}, value = {8,20} }, -- 13505
		{ pattern = "Небольшое увеличение скорости%.", effect = "RUNSPEED", value = 8 }, -- 20048, 25835, 29512
--~ 		{ pattern = "Increases your stealth slightly%.", effect = "STEALTH", value = 3 }, -- 21758
--~ 		{ pattern = "Increases your effective stealth level%.", effect = "STEALTH", value = 8 }, -- 22003, 23073
--~ 		{ pattern = "Increases spell power slightly%.", effect = "SPELLPOWER", value = 6 }, -- 30804

--				{ pattern = "Impress others with your fashion sense%.", effect = "IMPRESS", value = 1 }, -- 10036
--				{ pattern = "Increases your Mojo%.", effect = "MOJO", value = 1 }, -- 23717
	},
}
