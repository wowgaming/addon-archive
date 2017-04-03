--[[

Skillet: A tradeskill window replacement.
Copyright (c) 2007 Robert Clark <nogudnik@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

]]--

local L = AceLibrary("AceLocale-2.2"):new("Skillet")

L:RegisterTranslations("ruRU", function() return {
	["Skillet Trade Skills"] 		= "Skillet Trade Skills", -- default message
	["Create"] 				 		= "Создать",
	["Queue All"]					= "Всё в очередь",
	["Create All"]					= "Создать Все",
	["Create"]						= "Создать",
	["Queue"]						= "В очередь",
	["Enchant"]						= "Зачаровать",
	["Rescan"]                      = "Обновить",
	["Number of items to queue/create"]	= "Число вещей в очереди/создать",
	["buyable"]						= "покупаемые",
	["reagents in inventory"]		= "реагенты в инвентаре",
	["bank"]						= "банк", -- "reagents in bank"
	["alts"]						= "альты", -- "reagents on alts"
	["can be created from reagents in your inventory"] = "может быть создан из реагентов в вашем инвентаре",
	["can be created from reagents in your inventory and bank"] = "может быть создан из реагентов в вашем инвентаре и банке",
	["can be created from reagents on all characters"] = "может быть создан из реагентов на всех ваших чарах",
	["Scanning tradeskill"]			= "Сканирование профессии",
	["Scan completed"]              = "Скан окончен",
	["Filter"]						= "Фильтр",
	["Hide uncraftable"]			= "Скрыть не создаваемые",
	["Hide trivial"]				= "Скрыть низкоуровневые",
	["Options"]						= "Опции",
	["Notes"]						= "Заметка",
	["Purchased"]					= "Покупаемые",
	["Total spent"]					= "Всего затрат",
	["This merchant sells reagents you need!"] = "Вам нужен этот торговец реагентов!",
	["Buy Reagents"]				= "Купить реагенты",
	["click here to add a note"]	= "Кликни чтобы добавить заметку",
	["not yet cached"]              = "еще не скеширавано",

    -- Options
	["About"]						= "О Skillet",
	["ABOUTDESC"]					= "Информация о Skillet",
	["Config"]						= "Настройки",
	["CONFIGDESC"]					= "Открыть окно настройки для Skillet",
	["Shopping List"]					= "Список закупок",
	["SHOPPINGLISTDESC"]				= "Открыть список закупок",

	["Features"]					= "Cвойства",
	["FEATURESDESC"]					= "Необязательные свойства которые могут быть включены или выключены",
	["VENDORBUYBUTTONNAME"]				= "Кнопка покупок реагентов у торговца",
	["VENDORBUYBUTTONDESC"]				= "Отображать кнопку при разговоре с торговцем, это позволит вам осмотреть все нужные реагенты для всех ваших рецептах в очереди.",
	["VENDORAUTOBUYNAME"]				= "Автоматически купить реагенты",
	["VENDORAUTOBUYDESC"]				= "Если у вас в очереди есть рецепт/вещи то во время разговора с тогровцем который продаёт что нибудь нужное для вашего рецепта, оно будет куплено автоматически.",
	["SHOWITEMNOTESTOOLTIPNAME"]			= "Добавить заметки в подсказку",
	["SHOWITEMNOTESTOOLTIPDESC"]			= "Добавляет заметку которую вы написали в подсказку данного предмета",
	["SHOWDETAILEDRECIPETOOLTIPNAME"]			= "Детальную подсказку для рецептов",
	["SHOWDETAILEDRECIPETOOLTIPDESC"]			= "Отображать детальную подсказку при наведении курсора мыши на рецепт в левой части окна",
	["LINKCRAFTABLEREAGENTSNAME"]			= "Сделать реагенты кликабельными",
	["LINKCRAFTABLEREAGENTSDESC"]			= "Если вы можете создать реагент, необходимый для текущего рецепта, кликнув по реагент вы перейдёте на его рецепт.",
	["QUEUECRAFTABLEREAGENTSNAME"]			= "В очередь создаваемые реагенты",
	["QUEUECRAFTABLEREAGENTSDESC"]			= "Если вы можете создать реагент, необходимый для текущего рецепта, и у вас из не хватает, то данный реагент будет добавлен в очередь.",
	["DISPLAYSHOPPINGLISTATBANKNAME"]			= "Отображать список закупок в банке",
	["DISPLAYSHOPPINGLISTATBANKDESC"]			= "Отображать список закупок вещей которые нужны для создания рецепта находящегося в очереди, вещей которых нет в ваших сумках.",
	["DISPLAYSGOPPINGLISTATAUCTIONNAME"]		= "Отображать список закупок на аукционе",
	["DISPLAYSGOPPINGLISTATAUCTIONDESC"]		= "Отображать список закупок вещей которые нужны для создания рецепта находящегося в очереди, вещей которых нет в ваших сумках.",

	["Appearance"]					= "Внешний вид",
	["APPEARANCEDESC"]					= "Настройки внешнего вида.",
	["DISPLAYREQUIREDLEVELNAME"]			= "Отображать требуемый уровень",
	["DISPLAYREQUIREDLEVELDESC"]			= "Если предмет для создания требует определённый уровень умения, то этот уровень будет отображаться вместе с рецептом.",
	["Transparency"]					= "Прозрачность",
	["TRANSPARAENCYDESC"]				= "Прозрачность главного окна профессий",

    -- New in version 1.6
	["Shopping List"]               = "Список закупок",
	["Retrieve"]                    = "Отыскивать",
	["Include alts"]                = "Включать альтов",

    -- New in vesrsion 1.9
	["Start"]                       = "Начать",
	["Pause"]                       = "Пауза",
	["Clear"]                       = "Очистить",
	["None"]                        = "Нету",
	["By Name"]                     = "По имени",
	["By Difficulty"]               = "По сложности",
	["By Level"]                    = "По уровню",
	["Scale"]                       = "Масштаб",
	["SCALEDESC"]                   = "Масштаб окна профессий (по умолчанию 1.0)",
	["Could not find bag space for"] = "Нету места в сумках для",
	["SORTASC"]                     = "Сортировать список рецептов от наивысшего (верх) до низкого (низ)",
	["SORTDESC"]                    = "Сортировать список рецептов от низкого (низ) до наивысшего (верх)",
	["By Quality"]                  = "По качеству",

    -- New in version 1.10
	["Inventory"]                   = "Инвентарь",
	["INVENTORYDESC"]               = "Информация инвентаря",
	["Supported Addons"]            = "Поддерживаемые аддоны",
	["Selected Addon"]              = "Выбранные аддоны",
	["Library"]                     = "Библиотека",
	["SUPPORTEDADDONSDESC"]         = "Поддерживаемые модификации которые могут/уже используются для отслеживания инвентаря",
	["SHOWBANKALTCOUNTSNAME"]       = "Включая содержимое банка и инвентаря альтов",
	["SHOWBANKALTCOUNTSDESC"]       = "Когда подсчитывается и отображается число создаваемых предметов, в подсчет предметов включается содержимое банка и с инвентаря других ваших персонажей.",
	["ENHANCHEDRECIPEDISPLAYNAME"]  = "Отображать сложность рецепта текстом",
	["ENHANCHEDRECIPEDISPLAYDESC"]  = "Если включено, то к названию рецепта будет добавлен символ '+', в зависимости от уровня сложности их количество будет увеличиваться тем самым указания на сложность рецепта.",
	["SHOWCRAFTCOUNTSNAME"]         = "Отображать число создаваемого",
	["SHOWCRAFTCOUNTSDESC"]         = "Показывать сколько раз вы можете создать вещь, а не общее число производимых предметов",

    -- New in version 1.11
	["Crafted By"]                  = "Изготовлено",
} end)