local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BF = LibStub("LibBabble-Faction-3.0"):GetLookupTable()

if GetLocale() ~= "ruRU" then return end

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

-- This table contains a list of suggestions to get to the next level of reputation, craft or skill
addon.Suggestions = {
	[L["Riding"]] = {
		{ 75, "Ученик в деле верховой езды (20 урв): |cFFFFFFFF4g\n|cFFFFD700Стандартные верховые животные/nобучаются в столицах: |cFFFFFFFF1з" },
		{ 150, "Подмастерьем в деле верховой езды (40 урв): |cFFFFFFFF50g\n|cFFFFD700Эпические верховые животные/nобучаются в столицах: |cFFFFFFFF10з" },
		{ 225, "Умельцем в деле верховой езды (60 урв): |cFFFFFFFF600g\n|cFFFFD700Летающие верховые животные в Долине Призрачной Луны: |cFFFFFFFF50з" },
		{ 300, "Профессионалом в деле верховой езды (70 урв): |cFFFFFFFF5000g\n|cFFFFD700Эпические летающие верховые животные в Долине Призрачной Луны: |cFFFFFFFF200з" }
	},
	
	-- source : http://forums.worldofwarcraft.com/thread.html?topicId=102789457&sid=1
	-- ** Primary professions **
	[BI["Tailoring"]] = {
		{ 50, "До 50: Рулон льняной ткани" },
		{ 70, "До 70: Льняная сумка" },
		{ 75, "До 75: Усиленная льняная накидка" },
		{ 105, "До 105: Рулон шерсти" },
		{ 110, "До 110: Серая шерстяная рубашка"},
		{ 125, "До 125: Шерстяные наплечники с двойным швом" },
		{ 145, "До 145: Рулон шелка" },
		{ 160, "До 160: Лазурный шелковый капюшон" },
		{ 170, "До 170: Шелковая головная повязка" },
		{ 175, "До 175: Церемониальная белая рубашка" },
		{ 185, "До 185: Рулон магической ткани" },
		{ 205, "До 205: Багровый шелковый жилет" },
		{ 215, "До 215: Багровые шелковые кюлоты" },
		{ 220, "До 220: Черные поножи из магической ткани\nили Черный жилет из магической ткани" },
		{ 230, "До 230: Черные перчатки из магической ткани" },
		{ 250, "До 250: Черная повязка из магической ткани\nили Черные наплечники из магической ткани" },
		{ 260, "До 260: Рулон рунической ткани" },
		{ 275, "До 275: Пояс из рунической ткани" },
		{ 280, "До 280: Сумка из рунической ткани" },
		{ 300, "До 300: Перчатки из рунической ткани" },
		{ 325, "До 325: Рулоны ткани Пустоты\n|cFFFFD700Не продовайте их, пожже они вам понадобятся|r" },
		{ 340, "До 340: Рулоны прочной ткани Пустоты\n|cFFFFD700Не продовайте их, пожже они вам понадобятся|r" },
		{ 350, "До 350: Сапоги из ткани Пустоты\n|cFFFFD700Распылите их на Чародейскую пыль|r" },
		{ 375, "До 375: Рулоны ледяной ткани" },
		{ 380, "До 380: Ледотканые сапоги" },
		{ 395, "До 395: Ледотканый шлем" },
		{ 405, "До 405: Клобук из сумеречной ткани" },
		{ 410, "До 410: Напульсники из сумеречной ткани" },
		{ 415, "До 415: Перчатки из сумеречной ткани" },
		{ 425, "До 425: Иссиня-черная ткань, Лунный тюль, или Чароткань\nСумка из ледяной ткани" },
		{ 450, "До 450: Изготовьте любую вещь для получения очка,\nв зависимости от ваших потребностей" }
	},
	[BI["Leatherworking"]] = {
		{ 35, "До 35: Накладки из тонкой кожи" },
		{ 55, "До 55: Обработанная легкая шкура" },
		{ 85, "До 85: Тисненые кожаные перчатки" },
		{ 100, "До 100: Тонкий кожаный пояс" },
		{ 120, "До 120: Обработанная средняя шкура" },
		{ 125, "До 125: Тонкий кожаный пояс" },
		{ 150, "До 150: Темный кожаный пояс" },
		{ 160, "До 160: Обработанная тяжелая шкура" },
		{ 170, "До 170: Накладки из толстой кожи" },
		{ 180, "До 180: Мглистые кожаные поножи\nили Штаны стража" },
		{ 195, "До 195: Варварские наплечники" },
		{ 205, "До 205: Мглистые наручи" },
		{ 220, "До 220: Накладки из плотной кожи" },
		{ 225, "До 225: Ночная головная повязка" },
		{ 250, "До 250: Зависит от вашей специализации\nНочная головная повязка/мундир/штаны (сила стихий)\nЖесткая кираса из чешуи скорпида/перчатки (чешуя дракона)\nКомплект из Черепашьего панциря (традиции предков)" },
		{ 260, "До 260: Ночные сапоги" },
		{ 270, "До 270: Гибельные кожаные рукавицы" },
		{ 285, "До 285: Гибельные кожаные наручи" },
		{ 300, "До 300: Гибельная кожаная головная повязка" },
		{ 310, "До 310: Узловатая кожа" },
		{ 320, "До 320: Перчатки дренейского дикаря" },
		{ 325, "До 325: Утолщенные дренейские сапоги" },
		{ 335, "До 335: Толстая узловатая кожа\n|cFFFFD700Не продовайте их, пожже они вам понадобятся" },
		{ 340, "До 340: Утолщенная дренейская безрукавка" },
		{ 350, "До 350: Скверночешуйчатая кираса" },
		{ 375, "До 375: Накладки из борейской кожи" },
		{ 385, "До 385: Арктические сапоги" },
		{ 395, "До 395: Арктический пояс" },
		{ 400, "До 400: Арктические накулачники" },
		{ 405, "До 405: Нерубские накладки для поножей" },
		{ 410, "До 410: Any Черный нагрудник или поножи" },
		{ 425, "До 425: Любую Меховую подкладку\nСумки для профессий" },
		{ 450, "До 450: Изготовте любую вещь для получения очка,\nв зависимости от ваших потребностей" }
	},
	[BI["Engineering"]] = {
		{ 40, "До 40: Грубое взрывчатое вещество" },
		{ 50, "До 50: Горсть медных винтов" },
		{ 51, "Изготовьте один Тангенциальный вращатель" },
		{ 65, "До 65: Медные трубы" },
		{ 75, "До 75: Грубый огнестрел" },
		{ 95, "До 95: Низкосортное взрывчатое вещество" },
		{ 105, "До 105: Серебряные контакты" },
		{ 120, "До 120: Бронзовые трубкы" },
		{ 125, "До 125: Небольшие бронзовые бомбы" },
		{ 145, "До 145: Тяжелое взрывчатое вещество" },
		{ 150, "До 150: Большие бронзовые бомбы" },
		{ 175, "До 175: Синие, Зеленые или Красные петарды" },
		{ 176, "Изготовьте один Шлицевой гироинструмент" },
		{ 190, "До 190: Твердое взрывчатое вещество" },
		{ 195, "До 195: Большие железные бомбы" },
		{ 205, "До 205: Мифриловые трубы" },
		{ 210, "До 210: Нестабильные пусковые устройства" },
		{ 225, "До 225: Бронебойные мифриловые пули" },
		{ 235, "До 235: Мифриловую обшивку" },
		{ 245, "До 245: Фугасные бомбы" },
		{ 250, "До 250: Мифриловый гиро-патрон" },
		{ 260, "До 260: Концентрированное взрывчатое вещество" },
		{ 290, "До 290: Ториевое устройство" },
		{ 300, "До 300: Ториевые трубы\nили Ториевые патроны (дешевле)" },
		{ 310, "До 310: Обшивка из оскверненного железа,\nГорсть винтов из оскверненного железа,\n и Взрывчатое вещество стихий\n|cFFFFD700Не продовайте их, пожже они вам понадобятся|r" },
		{ 320, "До 320: Бомбы из оскверненного железа" },
		{ 335, "До 335: Мушкеты из оскверненного железа" },
		{ 350, "До 350: Белые дымовые сигнальные ракеты" },
		{ 375, "До 375: Кобальтовые осколочные бомбы" },
		{ 430, "До 430: Детали для набора лечебных(маны) инъекций\nВы будете в них нуждается долгое время" },
		{ 435, "До 435: Детали для набора инъекций маны" },
		{ 450, "До 450: Изготовьте любую вещь для получения очка,\nв зависимости от ваших потребностей" }
	},
	[BI["Jewelcrafting"]] = {
		{ 20, "До 20: Delicate Copper Wire" },
		{ 30, "До 30: Rough Stone Statue" },
		{ 50, "До 50: Tigerseye Band" },
		{ 75, "До 75: Bronze Setting" },
		{ 80, "До 80: Solid Bronze Ring" },
		{ 90, "До 90: Elegant Silver Ring" },
		{ 110, "До 110: Ring of Silver Might" },
		{ 120, "До 120: Heavy Stone Statue" },
		{ 150, "До 150: Pendant of the Agate Shield\nor Golden Dragon Ring" },
		{ 180, "До 180: Mithril Filigree" },
		{ 200, "До 200: Engraved Truesilver Ring" },
		{ 210, "До 210: Citrine Ring of Rapid Healing" },
		{ 225, "До 225: Aquamarine Signet" },
		{ 250, "До 250: Thorium Setting" },
		{ 255, "До 255: Red Ring of Destruction" },
		{ 265, "До 265: Truesilver Healing Ring" },
		{ 275, "До 275: Simple Opal Ring" },
		{ 285, "До 285: Sapphire Signet" },
		{ 290, "До 290: Diamond Focus Ring" },
		{ 300, "До 300: Emerald Lion Ring" },
		{ 310, "До 310: Any green quality gem" },
		{ 315, "До 315: Fel Iron Blood Ring\nor any green quality gem" },
		{ 320, "До 320: Any green quality gem" },
		{ 325, "До 325: Azure Moonstone Ring" },
		{ 335, "До 335: Mercurial Adamantite (required later)\nor any green quality gem" },
		{ 350, "До 350: Heavy Adamantite Ring" },
		{ 355, "До 355: Any blue quality gem" },
		{ 360, "До 360: World drop recipes like:\nLiving Ruby Pendant\nor Thick Felsteel Necklace" },
		{ 365, "До 365: Ring of Arcane Shielding\nThe Sha'tar - Уважение" },
		{ 375, "До 375: Transmute diamonds\nWorld drops (blue quality)\nПочтение с Sha'tar, Honor Hold, Thrallmar" }
	},
	[BI["Enchanting"]] = {
		{ 2, "До 2: Рунический медный жезл" },
		{ 75, "До 75: Чары для наручей - здоровье I" },
		{ 85, "До 85: Чары для наручей - отражение I" },
		{ 100, "До 100: Чары для наручей - выносливость I" },
		{ 101, "Изготовьте один Рунический серебряный жезл" },
		{ 105, "До 105: Чары для наручей - выносливость I" },
		{ 120, "До 120: Большой магический жезл" },
		{ 130, "До 130: Чары для щита - выносливость I" },
		{ 150, "До 150: Чары для наручей - выносливость II" },
		{ 151, "Изготовьте один Рунический золотой жезл" },
		{ 160, "До 160: Чары для наручей - выносливость II" },
		{ 165, "До 165: Чары для щита - выносливость II" },
		{ 180, "До 180: Чары для наручей - дух III" },
		{ 200, "До 200: Чары для наручей - сила III" },
		{ 201, "Изготовьте один Рунический жезл истинного серебра" },
		{ 205, "До 205: Чары для наручей - сила III" },
		{ 225, "До 225: Чары для плаща - защита II" },
		{ 235, "До 235: Чары для перчаток - ловкость I" },
		{ 245, "До 245: Чары для нагрудника - здоровье V" },
		{ 250, "До 250: Чары для наручей - сила IV" },
		{ 270, "До 270: Простое масло маны\nРецепт продается в Силитусе" },
		{ 290, "До 290: Чары для щита - выносливость IV\nили Чары для обуви - выносливость IV" },
		{ 291, "Изготовьте один Рунический арканитовый жезл" },
		{ 300, "До 300: Чары для плаща - защита III" },
		{ 301, "Изготовьте один Рунический жезл из оскверненного железа" },
		{ 305, "До 305: Чары для плаща - защита III" },
		{ 315, "До 315: Чары для наручей - штурм II" },
		{ 325, "До 325: Чары для плаща - броня III\nили Чары для перчаток - штурм I" },
		{ 335, "До 335: Чары для нагрудника - дух" },
		{ 340, "До 340: Чары для щита - выносливость V" },
		{ 345, "До 345: Превосходное волшебное масло\nИзготавливайте до 350, если у вас есть достаточно матерьяла" },
		{ 350, "До 350: Чары для перчаток - сила III" },
		{ 351, "Изготовьте один Рунический адамантитовый жезл" },
		{ 360, "До 360: Чары для перчаток - сила III" },
		{ 370, "До 370: Чары для перчаток - точные удары\nТребуется Почтение с Кенарийской экспедицией" },
		{ 375, "До 375: Чары для кольца - целительная сила\nТребуется Почтение с Ша'таром" }
	},
	[BI["Blacksmithing"]] = {	
		{ 25, "До 25: Rough Sharpening Stones" },
		{ 45, "До 45: Rough Grinding Stones" },
		{ 75, "До 75: Copper Chain Belt" },
		{ 80, "До 80: Coarse Grinding Stones" },
		{ 100, "До 100: Runed Copper Belt" },
		{ 105, "До 105: Silver Rod" },
		{ 125, "До 125: Rough Bronze Leggings" },
		{ 150, "До 150: Heavy Grinding Stone" },
		{ 155, "До 155: Golden Rod" },
		{ 165, "До 165: Green Iron Leggings" },
		{ 185, "До 185: Green Iron Bracers" },
		{ 200, "До 200: Golden Scale Bracers" },
		{ 210, "До 210: Solid Grinding Stone" },
		{ 215, "До 215: Golden Scale Bracers" },
		{ 235, "До 235: Steel Plate Helm\nor Mithril Scale Bracers (cheaper)\nRecipe in Aerie Peak (A) or Stonard (H)" },
		{ 250, "До 250: Mithril Coif\nor Mothril Spurs (cheaper)" },
		{ 260, "До 260: Dense Sharpening Stones" },
		{ 270, "До 270: Thorium Belt or Bracers (cheaper)\nEarthforged Leggings (Armorsmith)\nLight Earthforged Blade (Swordsmith)\nLight Emberforged Hammer (Hammersmith)\nLight Skyforged Axe (Axesmith)" },
		{ 295, "До 295: Imperial Plate Bracers" },
		{ 300, "До 300: Imperial Plate Boots" },
		{ 305, "До 305: Fel Weightstone" },
		{ 320, "До 320: Fel Iron Plate Belt" },
		{ 325, "До 325: Fel Iron Plate Boots" },
		{ 330, "До 330: Lesser Rune of Warding" },
		{ 335, "До 335: Fel Iron Breastplate" },
		{ 340, "До 340: Adamantite Cleaver\nSold in Shattrah, Silvermoon, Exodar" },
		{ 345, "До 345: Lesser Rune of Shielding\nSold in Wildhammer Stronghold and Thrallmar" },
		{ 350, "До 350: Adamantite Cleaver" },
		{ 360, "До 360: Adamantite Weightstone\nRequires Cenarion Expedition - Уважение" },
		{ 370, "До 370: Felsteel Gloves (Auchenai Crypts)\nFlamebane Gloves (Aldor - Уважение)\nEnchanted Adamantite Belt (Scryer - Дружелюбие)" },
		{ 375, "До 375: Felsteel Gloves (Auchenai Crypts)\nFlamebane Breastplate (Aldor - Почтение)\nEnchanted Adamantite Belt (Scryer - Дружелюбие)" },
		{ 385, "До 385: Cobalt Gauntlets" },
		{ 393, "До 393: Spiked Cobalt Shoulders\nor Chestpiece" },
		{ 395, "До 395: Spiked Cobalt Gauntlets" },
		{ 400, "До 400: Spiked Cobalt Belt" },
		{ 410, "До 410: Spiked Cobalt Bracers" },
	},
	[BI["Alchemy"]] = {	
		{ 60, "До 60: Minor Healing Potion" },
		{ 110, "До 110: Lesser Healing Potion" },
		{ 140, "До 140: Healing Potion" },
		{ 155, "До 155: Lesser Mana Potion" },
		{ 185, "До 185: Greater Healing Potion" },
		{ 210, "До 210: Elixir of Agility" },
		{ 215, "До 215: Elixir of Greater Defense" },
		{ 230, "До 230: Superior Healing Potion" },
		{ 250, "До 250: Elixir of Detect Undead" },
		{ 265, "До 265: Elixir of Greater Agility" },
		{ 285, "До 285: Superior Mana Potion" },
		{ 300, "До 300: Major Healing Potion" },
		{ 315, "До 315: Volatile Healing Potion\nor Major Mana Potion" },
		{ 350, "До 350: Mad Alchemists's Potion\nTurns yellow at 335, but cheap to make" },
		{ 375, "До 375: Major Dreamless Sleep Potion\nSold in Allerian Stronghold (A)\nor Thunderlord Stronghold (H)" }
	},
	[L["Mining"]] = {
		{ 65, "До 65: Mine Copper\nAvailable in all starting zones" },
		{ 125, "До 125: Mine Tin, Silver, Incendicite and Lesser Bloodstone\n\nMine Incendicite at Thelgen Rock (Wetlands)\nEasy leveling up to 125" },
		{ 175, "До 175: Mine Iron and Gold\nDesolace, Ashenvale, Badlands, Arathi Highlands,\nAlterac Mountains, Stranglethorn Vale, Swamp of Sorrows" },
		{ 250, "До 250: Mine Mithril and Truesilver\nBlasted Lands, Searing Gorge, Badlands, The Hinterlands,\nWestern Plaguelands, Azshara, Winterspring, Felwood, Stonetalon Mountains, Tanaris" },
		{ 300, "До 300: Mine Thorium \nUn’goro Crater, Azshara, Winterspring, Blasted Lands\nSearing Gorge, Burning Steppes, Eastern Plaguelands, Western Plaguelands" },
		{ 330, "До 330: Mine Fel Iron\nHellfire Peninsula, Zangarmarsh" },
		{ 375, "До 375: Mine Fel Iron and Adamantite\nTerrokar Forest, Nagrand\nBasically everywhere in Outland" }
	},
	[L["Herbalism"]] = {
		{ 50, "До 50: Собираем Сребролист и Мироцвет\nДоступны в начальных зонах" },
		{ 70, "До 70: Собираем Магороза и Земляной корень\nСтепи, Западный Край, Серебряный бор, Лок Модан" },
		{ 100, "До 100: Собираем Остротерн\nСеребряный бор, Сумеречный лес, Темные берега,\nЛок Модан, Красногорье" },
		{ 115, "До 115: Собираем Синячник\nЯсеневый лес, Когтистые горы, Южные степи\nЛок Модан, Красногорье" },
		{ 125, "До 125: Собираем Дикий сталецвет\nКогтистые горы, Нагорье Арати, Тернистая долина\nЮжные степи, Тысяча Игл" },
		{ 160, "До 160: Собираем Королевская кровь\nЯсеневый лес, Когтистые горы, Болотина,\nПредгорья Хилсбрада, Болото Печали" },
		{ 185, "До 185: Собираем Бледнолист\nБолото Печали" },
		{ 205, "До 205: Собираем Кадгаров ус\nВнутренние земли, Нагорье Арати, Болото Печали" },
		{ 230, "До 230: Собираем Огнецвет\nТлеющее ущелье, Выжженные земли, Танарис" },
		{ 250, "До 250: Собираем Солнечник\nОскверненный лес, Фералас, Азшара\nВнутренние земли" },
		{ 270, "До 270: Собираем Кровь Грома\nОскверненный лес, Выжженные земли,\nMannoroc Coven in Пустоши" },
		{ 285, "До 285: Собираем Снолист\nКратер Ун'Горо, Азшара" },
		{ 300, "До 300: Собираем Чумоцвет\nВосточные и Западные Чумные земли, Оскверненный лес\nили Ледяной зев в Зимних Ключах" },
		{ 330, "До 330: Собираем Сквернопля\nПолуостров Адского Пламени, Зангартопь" },
		{ 375, "До 375: Все остальные цветы доступные в запределье\nВ основном в Зангартопе и в Лесу Тероккар" }
	},
	[L["Skinning"]] = {
		{ 375, "До 375: Разделите ваш текущий уровень на 5,\nи снемайте шкуру с животных полученного уровня" }
	},

	-- source: http://www.elsprofessions.com/inscription/leveling.html
	[L["Inscription"]] = {
		{ 18, "До 18: Ivory Ink" },
		{ 35, "До 35: Scroll of Intellect, Spirit or Stamina" },
		{ 50, "До 50: Moonglow Ink\nSave if for Minor Inscription Research" },
		{ 75, "До 75: Scroll of Recall, Armor Vellum" },
		{ 79, "До 79: Midnight Ink" },
		{ 80, "До 80: Minor Inscription Research" },
		{ 85, "До 85: Glyph of Backstab, Frost Nova\nRejuvenation, ..." },
		{ 87, "До 87: Hunter's Ink" },
		{ 90, "До 90: Glyph of Corruption, Flame Shock\nRapid Charge, Wrath" },
		{ 100, "До 100: Glyph of Ice Armor, Maul\nSerpent Sting" },
		{ 104, "До 104: Lion's Ink" },
		{ 105, "До 105: Glyph of Arcane Shot, Arcane Explosion" },
		{ 110, "До 110: Glyph of Eviscerate, Holy Light, Fade" },
		{ 115, "До 115: Glyph of Fire Nova Totem\nHealth Funel, Rending" },
		{ 120, "До 120: Glyph of Arcane Missiles, Healing Touch" },
		{ 125, "До 125: Glyph of Expose Armor\nFlash Heal, Judgment" },
		{ 130, "До 130: Dawnstar Ink" },
		{ 135, "До 135: Glyph of Blink\nImmolation, Moonfire" },
		{ 140, "До 140: Glyph of Lay on Hands\nGarrote, Inner Fire" },
		{ 142, "До 142: Glyph of Sunder Armor\nImp, Lightning Bolt" },
		{ 150, "До 150: Strange Tarot" },
		{ 155, "До 155: Jadefire Ink" },
		{ 160, "До 160: Scroll of Stamina III" },
		{ 165, "До 165: Glyph of Gouge, Renew" },
		{ 170, "До 170: Glyph of Shadow Bolt\nStrength of Earth Totem" },
		{ 175, "До 175: Glyph of Overpower" },
		{ 177, "До 177: Royal Ink" },
		{ 183, "До 183: Scroll of Agility III" },
		{ 185, "До 185: Glyph of Cleansing\nShadow Word: Pain" },
		{ 190, "До 190: Glyph of Insect Swarm\nFrost Shock, Sap" },
		{ 192, "До 192: Glyph of Revenge\nVoidwalker" },
		{ 200, "До 200: Arcane Tarot" },
		{ 204, "До 204: Celestial Ink" },
		{ 210, "До 210: Armor Vellum II" },
		{ 215, "До 215: Glyph of Smite, Sinister Strike" },
		{ 220, "До 220: Glyph of Searing Pain\nHealing Stream Totem" },
		{ 225, "До 225: Glyph of Starfire\nBarbaric Insults" },
		{ 227, "До 227: Fiery Ink" },
		{ 230, "До 230: Scroll of Agility IV" },
		{ 235, "До 235: Glyph of Dispel Magic" },
		{ 250, "До 250: Weapon Vellum II" },
		{ 255, "До 255: Scroll of Stamina V" },
		{ 260, "До 260: Scroll of Spirit V" },
		{ 265, "До 265: Glyph of Freezing Trap, Shred" },
		{ 270, "До 270: Glyph of Exorcism, Bone Shield" },
		{ 275, "До 275: Glyph of Fear Ward, Frost Strike" },
		{ 285, "До 285: Ink of the Sky" },
		{ 295, "До 295: Glyph of Execution\nSprint, Death Grip" },
		{ 300, "До 300: Scroll of Spirit VI" },
		{ 304, "До 304: Ethereal Ink" },
		{ 305, "До 305: Glyph of Plague Strike\nEarthliving Weapon, Flash of Light" },
		{ 310, "До 310: Glyph of Feint" },
		{ 315, "До 315: Glyph of Rake, Rune Tap" },
		{ 320, "До 320: Glyph of Holy Nova, Rapid Fire" },
		{ 325, "До 325: Glyph of Blood Strike, Sweeping Strikes" },
		{ 327, "До 327: Darkflame Ink" },
		{ 330, "До 330: Glyph of Mage Armor, Succubus" },
		{ 335, "До 335: Glyph of Scourge Strike, Windfury Weapon" },
		{ 340, "До 340: Glyph of Arcane Power, Seal of Command" },
		{ 345, "До 345: Glyph of Ambush, Death Strike" },
		{ 350, "До 350: Glyph of Whirlwind" },
		{ 350, "До 350: Glyph of Mind Flay, Banish" },
		
		{ 450, "До 450: Not yet implemented" }
	},

	-- source: http://www.almostgaming.com/wowguides/world-of-warcraft-lockpicking-guide
	[L["Lockpicking"]] = {
		{ 85, "До 85: Thieves Training\nAtler Mill, Redridge Moutains (A)\nShip near Ratchet (H)" },
		{ 150, "До 150: Chest near the boss of the poison quest\nWestfall (A) or The Barrens (H)" },
		{ 185, "До 185: Murloc camps (Wetlands)" },
		{ 225, "До 225: Sar'Theris Strand (Desolace)\n" },
		{ 250, "До 250: Angor Fortress (Badlands)" },
		{ 275, "До 275: Slag Pit (Searing Gorge)" },
		{ 300, "До 300: Lost Rigger Cove (Tanaris)\nBay of Storms (Azshara)" },
		{ 325, "До 325: Feralfen Village (Zangarmarsh)" },
		{ 350, "До 350: Kil'sorrow Fortress (Nagrand)\nPickpocket the Boulderfists in Nagrand" }
	},
	
	-- ** Secondary professions **
	[BI["First Aid"]] = {
		{ 40, "До 40: Linen Bandages" },
		{ 80, "До 80: Heavy Linen Bandages\nBecome Journeyman at 50" },
		{ 115, "До 115: Wool Bandages" },
		{ 150, "До 150: Heavy Wool Bandages\nGet Expert First Aid book at 125\nBuy the 2 manuals in Stromguarde (A) or Brackenwall Village (H)" },
		{ 180, "До 180: Silk Bandages" },
		{ 210, "До 210: Heavy Silk Bandages" },
		{ 240, "До 240: Mageweave Bandages\nFirst Aid quest at level 35\nTheramore Isle (A) or Hammerfall (H)" },
		{ 260, "До 260: Heavy Mageweave Bandages" },
		{ 290, "До 290: Runecloth Bandages" },
		{ 330, "До 330: Heavy Runecloth Bandages\nBuy Master First Aid book\nTemple of Telhamat (A) or Falcon Watch (H)" },
		{ 360, "До 360: Netherweave Bandages\nBuy the book in the Temple of Telhamat (A) or in Falcon Watch (H)" },
		{ 375, "До 375: Heavy Netherweave Bandages\nBuy the book in the Temple of Telhamat (A) or in Falcon Watch (H)" }
	},
	[BI["Cooking"]] = {
		{ 40, "До 40: Хлеб с пряностями"	},
		{ 85, "До 85: Копченая медвежатина, Пирожок с мясом краба" },
		{ 100, "До 100: Cooked Crab Claw (A)\nDig Rat Stew (H)" },
		{ 125, "До 125: Dig Rat Stew (H)\nSeasoned Wolf Kabob (A)" },
		{ 175, "До 175: Curiously Tasty Omelet (A)\nHot Lion Chops (H)" },
		{ 200, "До 200: Roast Raptor" },
		{ 225, "До 225: Spider Sausage\n\n|cFFFFFFFFCooking quest:\n|cFFFFD70012 Giant Eggs,\n10 Zesty Clam Meat,\n20 Alterac Swiss " },
		{ 275, "До 275: Monster Omelet\nor Tender Wolf Steaks" },
		{ 285, "До 285: Runn Tum Tuber Surprise\nDire Maul (Pusillin)" },
		{ 300, "До 300: Smoked Desert Dumplings\nQuest in Silithus" },
		{ 325, "До 325: Ravager Dogs, Buzzard Bites" },
		{ 350, "До 350: Roasted Clefthoof\nWarp Burger, Talbuk Steak" },
		{ 375, "До 375: Crunchy Serpent\nMok'nathal Treats" }
	},	
	-- source: http://www.wowguideonline.com/fishing.html
	[BI["Fishing"]] = {
		{ 50, "До 50: Любая начальная зона" },
		{ 75, "До 75:\nВ каналах Штормграда\nВ прудах Оргриммара" },
		{ 150, "До 150: В реке Предгорья Хилсбрада" },
		{ 225, "До 225: Книга Рыболов-умелец продается в Пиратской бухте\nРыбачьте в Пустоши или Нагорьях Арати" },
		{ 250, "До 250: Внутренние земли, Танарис\n\n|cFFFFFFFFРыболовное задание в Пылевых топях\n|cFFFFD700Синий плавник Гибельного берега (Тернистая долина)\nФералас-ахи (Река Вердантис, Фералас)\nУдарник Сартериса (Северное побережье Сар'Терис, Пустоши)\nМахи-махи с Тростникового берега (Береговая линия Болот Печали)" },
		{ 260, "До 260: Оскверненный лес" },
		{ 300, "До 300: Азшара" },
		{ 330, "До 330: Рыбачьте на востоке Зангартопи\nКнига Рыболов-мастер у Кенарийской экспедиция" },
		{ 345, "До 345: Рыбачьте на западе Зангартопи" },
		{ 360, "До 360: Лес Тероккар" },
		{ 375, "До 375: Лесу Тероккар, в Скеттисе\nНужено летающее верховое животное" }
	},
	
	-- suggested leveling zones, compiled by Thaoky, based on too many sources to list + my own leveling experience on Alliance side
	["Leveling"] = {
		{ 10, "До 10: Любая начальная зона" },
		{ 20, "До 20: "  .. BZ["Loch Modan"] .. "\n" .. BZ["Westfall"] .. "\n" .. BZ["Darkshore"] .. "\n" .. BZ["Bloodmyst Isle"] 
						.. "\n" .. BZ["Silverpine Forest"] .. "\n" .. BZ["The Barrens"] .. "\n" .. BZ["Ghostlands"]},
		{ 25, "До 25: " .. BZ["Wetlands"] .. "\n" .. BZ["Redridge Mountains"] .. "\n" .. BZ["Ashenvale"] 
						.. "\n" .. BZ["The Barrens"] .. "\n" .. BZ["Stonetalon Mountains"] .. "\n" .. BZ["Hillsbrad Foothills"] },
		{ 28, "До 28: " .. BZ["Duskwood"] .. "\n" .. BZ["Wetlands"] .. "\n" .. BZ["Ashenvale"] 
						.. "\n" .. BZ["Stonetalon Mountains"] .. "\n" .. BZ["Thousand Needles"] },
		{ 31, "До 31: " .. BZ["Duskwood"] .. "\n" .. BZ["Thousand Needles"] .. "\n" .. BZ["Ashenvale"] },
		{ 35, "До 35: " .. BZ["Thousand Needles"] .. "\n" .. BZ["Stranglethorn Vale"] .. "\n" .. BZ["Alterac Mountains"] 
						.. "\n" .. BZ["Arathi Highlands"] .. "\n" .. BZ["Desolace"] },
		{ 40, "До 40: " .. BZ["Stranglethorn Vale"] .. "\n" .. BZ["Desolace"] .. "\n" .. BZ["Badlands"]
						.. "\n" .. BZ["Dustwallow Marsh"] .. "\n" .. BZ["Swamp of Sorrows"] },
		{ 43, "До 43: " .. BZ["Tanaris"] .. "\n" .. BZ["Stranglethorn Vale"] .. "\n" .. BZ["Badlands"] 
						.. "\n" .. BZ["Dustwallow Marsh"] .. "\n" .. BZ["Swamp of Sorrows"] },
		{ 45, "До 45: " .. BZ["Tanaris"] .. "\n" .. BZ["Feralas"] .. "\n" .. BZ["The Hinterlands"] },
		{ 48, "До 48: " .. BZ["Tanaris"] .. "\n" .. BZ["Feralas"] .. "\n" .. BZ["The Hinterlands"] .. "\n" .. BZ["Searing Gorge"] },
		{ 51, "До 51: " .. BZ["Tanaris"] .. "\n" .. BZ["Azshara"] .. "\n" .. BZ["Blasted Lands"] 
						.. "\n" .. BZ["Searing Gorge"] .. "\n" .. BZ["Un'Goro Crater"] .. "\n" .. BZ["Felwood"] },
		{ 55, "До 55: " .. BZ["Un'Goro Crater"] .. "\n" .. BZ["Felwood"] .. "\n" .. BZ["Burning Steppes"]
						.. "\n" .. BZ["Blasted Lands"] .. "\n" .. BZ["Western Plaguelands"] },
		{ 58, "До 58: " .. BZ["Winterspring"] .. "\n" .. BZ["Burning Steppes"] .. "\n" .. BZ["Western Plaguelands"] 
						.. "\n" .. BZ["Eastern Plaguelands"] .. "\n" .. BZ["Silithus"] },
		{ 60, "До 60: " .. BZ["Winterspring"] .. "\n" .. BZ["Eastern Plaguelands"] .. "\n" .. BZ["Silithus"] },
		{ 62, "До 62: " .. BZ["Hellfire Peninsula"] },
		{ 64, "До 64: " .. BZ["Zangarmarsh"] .. "\n" .. BZ["Terokkar Forest"]},
		{ 65, "До 65: " .. BZ["Terokkar Forest"] },
		{ 66, "До 66: " .. BZ["Terokkar Forest"] .. "\n" .. BZ["Nagrand"]},
		{ 67, "До 67: " .. BZ["Nagrand"]},
		{ 68, "До 68: " .. BZ["Blade's Edge Mountains"]},
		{ 70, "До 70: " .. BZ["Blade's Edge Mountains"] .. "\n" .. BZ["Netherstorm"] .. "\n" .. BZ["Shadowmoon Valley"]},
		{ 72, "До 72: " .. BZ["Howling Fjord"] .. "\n" .. BZ["Borean Tundra"]},
		{ 74, "До 74: " .. BZ["Grizzly Hills"] .. "\n" .. BZ["Dragonblight"]},
		{ 76, "До 76: " .. BZ["Dragonblight"] .. "\n" .. BZ["Zul'Drak"]},
		{ 78, "До 78: " .. BZ["Zul'Drak"] .. "\n" .. BZ["Sholazar Basin"]},
		{ 80, "До 80: " .. BZ["The Storm Peaks"] .. "\n" .. BZ["Icecrown"]},
	},

	-- Reputation levels
	-- -42000 = "Hated"
	-- -6000 = "Hostile"
	-- -3000 = "Unfriendly"
	-- 0 = "Neutral"
	-- 3000 = "Friendly"
	-- 9000 = "Honored"
	-- 21000 = "Revered"
	-- 42000 = "Exalted"
	
	-- Outland factions: source: http://www.mmo-champion.com/
	[BF["The Aldor"]] = {
		{ 0, "До Равнодушия:\n" .. WHITE .. "[Ядовитая железа Смертеплета]|r +250 реп\n\n"
				.. YELLOW .. "Жуткопалый скрытень,\nЖуткопалая черная вдова\n"
				.. WHITE .. "(Лес Тероккар)" },
		{ 9000, "До Уважения:\n" .. WHITE .. "[Знак Кил'джедена]|r\n+25 реп" },
		{ 42000, "До Превознесения:\n" .. WHITE .. "[Знак Саргераса]|r +25 реп за знак\n" 
				.. GREEN .. "[Латные перчатки Скверны]|r +350 реп (+1 Святая пыль)"       }
	},
	[BF["The Scryers"]] = {
		{ 0, "До Равнодушия:\n" .. WHITE .. "[Глаз гладкоспинного василиска]|r +250 реп\n\n"
				.. YELLOW .. "Стальноспинный окаменитель,\nВлажночешуйчатый пожиратель,\nГладкоспинный василиск\n"
				.. WHITE .. "(Лес Тероккар)" },
		{ 9000, "До Уважения:\n" .. WHITE .. "[Перстень Огнекрылов]|r\n+25 реп" },
		{ 42000, "До Превознесения:\n" .. WHITE .. "[Перстень Ярости Солнца]|r +25 реп за перстень\n" 
				.. GREEN .. "[Чародейский фолиант]|r +350 реп (+1 Чародейская руна)"       }
	},
	[BF["Netherwing"]] = {
		{ 3000, "До Дружелюбие, повторяйте слудующие задания:\n\n" 
				.. YELLOW .. "Медленная смерть (Ежедневный)|r 250 реп\n"
				.. YELLOW.. "Пыльца хаотического пыльника (Ежедневный)|r 250 реп\n"
				.. YELLOW.. "Кристаллы Крыльев Пустоты (Ежедневный)|r 250 реп\n"
				.. YELLOW.. "Недружелюбные небеса (Ежедневный)|r 250 реп\n"
				.. YELLOW.. "Большая Охота (Повторяемый)|r 250 реп" },
		{ 9000, "До Уважения, повторяйте слудующие задания:\n\n" 
				.. YELLOW .. "Ты – инспектор: как делать все правильно|r 350 реп\n"
				.. YELLOW .. "Ботиранг: Лекарство для ... (Ежедневный)|r 350 реп\n"
				.. YELLOW .. "Собрать по кусочкам... (Ежедневный)|r 350 реп\n"
				.. YELLOW .. "Драконы – это не самое страшное (Ежедневный)|r 350 реп\n"
				.. YELLOW .. "Спятившие и очень опасные...|r 350 реп\n" },
		{ 21000, "До Почтения, повторяйте слудующие задания:\n\n" 
				.. YELLOW .. "Покорить Покорителя|r 500 реп\n" 
				.. YELLOW .. "Разрушение Сумеречного Портала (Ежедневный)|r 500 реп\n"
				.. YELLOW .. "Race quests 500 each for first 5, 1000 for 6th\n" },
		{ 42000, "До Превознесения, повторяйте слудующие задания:\n\n" 
				.. YELLOW .. "Самая Опасная Ловушка (Ежедневный) (группа на 3)|r 500 реп" }
	},
	[BF["Honor Hold"]] = {
		{ 9000, "До Уважения:\n\n" 
				.. YELLOW .. "Задания на Полуострове Адского Пламени\n"
				.. GREEN .. "Бастионы Адского Пламени |r(Обычный)\n"
				.. GREEN .. "Кузня Крови |r(Обычный)" },		
		{ 42000, "До Превознесения:\n\n" 
				.. GREEN .. "Разрушенные залы |r(Обычный & Героический)\n"
				.. GREEN .. "Бастионы Адского Пламени |r(Героический)\n"
				.. GREEN .. "Кузня Крови |r(Героический)" }
	},
	[BF["Thrallmar"]] = {
		{ 9000, "До Уважения:\n\n" 
				.. YELLOW .. "Задания на Полуострове Адского Пламени\n"
				.. GREEN .. "Бастионы Адского Пламени |r(Обычный)\n"
				.. GREEN .. "Кузня Крови |r(Обычный)" },	
		{ 42000, "До Превознесения:\n\n" 
				.. GREEN .. "Разрушенные залы |r(Обычный & Героический)\n"
				.. GREEN .. "Бастионы Адского Пламени |r(Героический)\n"
				.. GREEN .. "Кузня Крови |r(Героический)" }
	},
	[BF["Cenarion Expedition"]] = {
		{ 3000, "До Дружелюбия:\n\n" 
				.. WHITE .. "Наги из клана Темного Гребня и Кровавой Чешуи (+5 реп)\n"
				.. YELLOW .. "Задания в Зангартопе\n"
				.. "|rПройдите любое подземелье " .. GREEN .. "Резервуара|r\n\n"
				.. WHITE .. "Храните [Неопознанные части растений] на потом" },	
		{ 9000, "До Уважения:\n\n" 
				.. WHITE .. "Сдайте [Неопознанные части растений] x240\n"
				.. YELLOW .. "Задания в Зангартопе\n"
				.. "|rПройдите любое подземелье " .. GREEN .. "Резервуара|r" },
		{ 42000, "До Превознесения:\n\n" 
				.. WHITE .. "Сдавайте [Оружие Змеиного Зуба] +75 реп\n\n"
				.. GREEN .. "Паровое подземелье |r(Обычное)\n"
				.. GREEN .. "Любое подземелье Резервуара |r(Героическое)" }
	},
	[BF["Keepers of Time"]] = {
		{ 42000, "До Превознесения:\n\n" 
				.. "|rПройдите " .. GREEN .. "Старые предгорья Хилсбрада|r и " .. GREEN .. "Черные топи|r\n\n"
				.. YELLOW .. "Храните задания на потом:\nЦепь заданий в Старые предгорья Хилсбрада = 5000 реп\nв Черные топи = 8000 реп" }
	},
	[BF["The Sha'tar"]] = {
		{ 42000, "До Превознесения:\n\n" 
				.. GREEN .. "Ботаника |r(Обычный & Героический)\n"
				.. GREEN .. "Механар |r(Обычный & Героический)\n"
				.. GREEN .. "Аркатрац |r(Обычный & Героический)\n" }
	},	
	[BF["Lower City"]] = {
		{ 9000, "До Уважения:\n\n" 
				.. WHITE .. "Сдавайте [Перо араккоа] x30 (+250 реп)\n"
				.. GREEN .. "Темный лабиринт |r(Обычный)\n"
				.. GREEN .. "Аукенайские гробницы |r(Обычный)\n"
				.. GREEN .. "Сетеккские залы |r(Обычный)" },
		{ 42000, "До Превознесения:\n\n" 
				.. GREEN .. "Темный лабиринт |r(Обычный & Героический)\n"
				.. GREEN .. "Аукенайские гробницы |r(Героический)\n"
				.. GREEN .. "Сетеккские залы |r(Героический)" }
	},	
	[BF["The Consortium"]] = {
		{ 3000, "До Дружелюбия:\n\n" 
				.. "|rСдавайте [Осколок кристалла Ошу'гуна] +250 реп\n"
				.. "Сдавайте [Пара бивней] +250 реп\n\n"
				.. GREEN .. "Гробницы Маны |r(Обычный)" },
		{ 9000, "До Уважения:\n\n" 
				.. "|rСдавайте [Обсидиановые боевые бусы] +250 реп\n\n"
				.. GREEN .. "Гробницы Маны |r(Обычный)" },
		{ 42000, "До Превознесения:\n\n" 
				.. "|rСдавайте [Знак отличия братства Заксис] +250 реп\n"
				.. "|rСдавайте [Обсидиановые боевые бусы] +250 реп\n\n"
				.. GREEN .. "Гробницы Маны |r(Героический)" }
	}

	-- Northrend factions
}
