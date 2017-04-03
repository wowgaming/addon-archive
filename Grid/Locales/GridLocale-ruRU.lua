--[[--------------------------------------------------------------------
	GridLocale-ruRU.lua
	Russian (Русский) localization for Grid.
----------------------------------------------------------------------]]

if GetLocale() ~= "ruRU" then return end
local _, ns = ...
ns.L = {

--{{{ GridCore
	["Debugging"] = "Отладка",
	["Module debugging menu."] = "Меню модуля отладки",
	["Debug"] = "Отладка",
	["Toggle debugging for %s."] = "Показать отладку для  %s.",
	["Configure"] =  "Настройка",
	["Configure Grid"] = "Настройка Grid",
	["Hide minimap icon"] = "Скрыть иконку на миникарте",
	["Grid is disabled: use '/grid standby' to enable."] = "Grid отключен: для включения введите '/grid standby'",
--	["Enable dual profile"] = "",
--	["Automatically swap profiles when switching talent specs."] = "",
--	["Dual profile"] = "",
--	["Select the profile to swap with the current profile when switching talent specs."] = "",
--}}}

--{{{ GridFrame
	["Frame"] = "Фреймы",
	["Options for GridFrame."] = "Опции фреймов Grid",

	["Show Tooltip"] = "Показывать подсказки",
	["Show unit tooltip.  Choose 'Always', 'Never', or 'OOC'."] = "Показывать подсказку единицы.  Выберите 'Всегда', 'Никогда', или 'Вне боя'.",
	["Always"] = "Всегда",
	["Never"] = "Никогда",
	["OOC"] = "Вне боя",
	["Center Text Length"] = "Длина текста в центре",
	["Number of characters to show on Center Text indicator."] = "Количество символов для отображения текста в центре.",
	["Invert Bar Color"] = "Обратить цвет полос",
	["Swap foreground/background colors on bars."] = "Поменять местами цвет фасада/фона полос",
	["Healing Bar Opacity"] = "Прозрачность полосы лечения",
	["Sets the opacity of the healing bar."] = "Установить прозрачность полосы лечения.",

	["Indicators"] = "Индикаторы",
	["Border"] = "Граница",
	["Health Bar"] = "Полоса здоровья",
	["Health Bar Color"] = "Цвет полосы здоровья",
	["Healing Bar"] = "Полоса лечения",
	["Center Text"] = "Текст в центре",
	["Center Text 2"] = "Текст в центре 2",
	["Center Icon"] = "Иконка в центре",
	["Top Left Corner"] = "Верхний левый угол",
	["Top Right Corner"] = "Верхний правый угол",
	["Bottom Left Corner"] = "Нижний левый угол",
	["Bottom Right Corner"] = "Нижний правый угол",
	["Frame Alpha"] = "Прозрачность фреймов",

	["Options for %s indicator."] = "Опции для %s индикаторов.",
	["Statuses"] = "Статусы",
	["Toggle status display."] = "Переключить статус на дисплее.",

	-- Advanced options
	["Advanced"] = "Дополнительно",
	["Advanced options."] = "Дополнительные опции",
	["Enable %s indicator"] = "Включить %s индикатор",
	["Toggle the %s indicator."] = "Показать %s индикатор.",
	["Frame Width"] = "Ширина Фреймов",
	["Adjust the width of each unit's frame."] = "Настроить ширину фреймов.",
	["Frame Height"] = "Высота Фреймов",
	["Adjust the height of each unit's frame."] = "Настроить высоту фреймов.",
	["Frame Texture"] = "Текстура Фреймов",
	["Adjust the texture of each unit's frame."] = "Настроить текстуру игровых фреймов.",
	["Border Size"] = "Размер границ",
	["Adjust the size of the border indicators."] = "Настроить размер гриниц индикаторов.",
	["Corner Size"] = "Размер Углов",
	["Adjust the size of the corner indicators."] = "Настроить размер углов индикаторов.",
	["Enable Mouseover Highlight"] = "Выделение при наведении мышки.",
	["Toggle mouseover highlight."] = "Вкл/Выкл выделение при наведении курсора мыши.",
	["Font"] = "Шрифт",
	["Adjust the font settings"] = "Настройка параметров шрифта",
	["Font Size"] = "Размер шрифта",
	["Adjust the font size."] = "Настройка размера шрифта",
	["Font Outline"] = "Контур шрифта",
	["Adjust the font outline."] = "Настройка контура шрифта",
	["None"] = "нету",
	["Thin"] = "Тонкий",
	["Thick"] = "Толстый",
	["Orientation of Frame"] = "Ориентация фреймов",
	["Set frame orientation."] = "Установить ориеетацию фреймов",
	["Orientation of Text"] = "Ориентация текста",
	["Set frame text orientation."] = "Установить ориентацию текста фреймов",
	["Vertical"] = "Вертикально",
	["Horizontal"] = "Горизонтально",
	["Icon Size"] = "Размер иконки",
	["Adjust the size of the center icon."] = "Настройка размера значка в центре",
	["Icon Border Size"] = "Размер границы значка",
	["Adjust the size of the center icon's border."] = "Настраивает размер границы значка в центре.",
	["Icon Stack Text"] = "Текст множества значков",
	["Toggle center icon's stack count text."] = "Показывать количество значков в множестве",
	["Icon Cooldown Frame"] = "Фрейм перерыва (cooldown) значка",
	["Toggle center icon's cooldown frame."] = "Показывать фрейм перерыва значка в центре",
--}}}

--{{{ GridLayout
	["Layout"] = "Расположение",
	["Options for GridLayout."] = "Опции для GridLayout",

	["Drag this tab to move Grid."] = "Перетаскивая этот ярлык вы перемстите Grid.",
	["Lock Grid to hide this tab."] = "Закрепить Grid чтобы скрыть данный ярлык.",
	["Alt-Click to permanantly hide this tab."] = "Alt-Клик скрывает данный ярлык.",

	-- Layout options
	["Show Frame"] = "Отображение фреймов",

	["Solo Layout"] = "Расположение в соло",
	["Select which layout to use when not in a party."] = "Выбрать какое расположение использовать не находясь в группе.",
	["Party Layout"] = "Расположение группы",
	["Select which layout to use when in a party."] = "Выбрать какое расположение использовать в группе.",
	["25 Player Raid Layout"] = "Расположение для 25 игроков",
	["Select which layout to use when in a 25 player raid."] = "Выбрать какое расположение использовать в рейде для 25 игроков.",
	["10 Player Raid Layout"] = "Расположение для 10 игроков",
	["Select which layout to use when in a 10 player raid."] = "Выбрать какое расположение использовать в рейде для 10 игроков.",
	["Battleground Layout"] = "Расположение на ПС",
	["Select which layout to use when in a battleground."] = "Выбрать какое расположение использовать на полях сражений.",
	["Arena Layout"] = "Расположение на арене",
	["Select which layout to use when in an arena."] = "Выбрать какое расположение использовать на арене.",
	["Horizontal groups"] = "Группы горизонтально",
	["Switch between horzontal/vertical groups."] = "Переключить между группы вертикально/горизонтально.",
	["Clamped to screen"] = "В пределах экрана",
	["Toggle whether to permit movement out of screen."] = "Не позволять перемещать окно за пределы экрана",
	["Frame lock"] = "Закрепить фреймы",
	["Locks/unlocks the grid for movement."] = "Закрепляет/открепляет окно для передвижения",
	["Click through the Grid Frame"] = "Выбирать через окно Grid",
	["Allows mouse click through the Grid Frame."] = "Разрешает мышкой кликать сквозь окно Grid",

	["Center"] = "Центр",
	["Top"] = "Вверху",
	["Bottom"] = "Внизу",
	["Left"] = "Слева",
	["Right"] = "Справа",
	["Top Left"] = "Вверху Слева",
	["Top Right"] = "Вверху Справа",
	["Bottom Left"] = "Внизу Слева",
	["Bottom Right"] = "Внизу Справа",

	-- Display options
	["Padding"] = "Заполнение",
	["Adjust frame padding."] = "Настроить заполнение фреймов",
	["Spacing"] = "Интервалы",
	["Adjust frame spacing."] = "Настроить интервалы между фреймами",
	["Scale"] = "Масштаб",
	["Adjust Grid scale."] = "Настроиь масштаб Grid",
	["Border"] = "Граница",
	["Adjust border color and alpha."] = "Настроить цвет границы и прозрачность",
	["Border Texture"] = "Текстуры границы",
	["Choose the layout border texture."] = "Выбор текстуры границы.",
	["Background"] = "Фон",
	["Adjust background color and alpha."] = "Настроить цвет фона и прозрачность",
	["Pet color"] = "Цвет питомцев",
	["Set the color of pet units."] = "Установить цвет питомцев.",
	["Pet coloring"] = "Окраска питомцев",
	["Set the coloring strategy of pet units."] = "Установиь стратегию окраски питомцев.",
	["By Owner Class"] = "По классу владельца",
	["By Creature Type"] = "По типу существа",
	["Using Fallback color"] = "Использовать истинный цвет",
	["Beast"] = "Животное",
	["Demon"] = "Демон",
	["Humanoid"] = "Гуманоид",
	["Undead"] = "Нежить",
	["Dragonkin"] = "Дракон",
	["Elemental"] = "Элементаль",
	["Not specified"] = "Не указано",
	["Colors"] = "Цвета",
	["Color options for class and pets."] = "Опции окраски для классов и питомцев",
	["Fallback colors"] = "Цвета неизветсных",
	["Color of unknown units or pets."] = "Цвет неизвестных единиц или питомцев",
	["Unknown Unit"] = "Неизвестная единица",
	["The color of unknown units."] = "Цвет неизвестной единицы",
	["Unknown Pet"] = "Неизвестные питомцы",
	["The color of unknown pets."] = "Цвет неизветсных питомцев",
	["Class colors"] = "Цвет классов",
	["Color of player unit classes."] = "Цвет классов персонажей",
	["Creature type colors"] = "Цвет типов созданий",
	["Color of pet unit creature types."] = "Цвет типов питомцев созданий",
	["Color for %s."] = "Цвет для %s.",

	-- Advanced options
	["Advanced"] = "Дополнительно",
	["Advanced options."] = "Дополнительные настройки.",
	["Layout Anchor"] = "Пометка расположения",
	["Sets where Grid is anchored relative to the screen."] = "Установить пометку где будет находиться Grid на экране",
	["Group Anchor"] = "Пометка группы",
	["Sets where groups are anchored relative to the layout frame."] = "Установить пометку где будет находиться группа на экране",
	["Reset Position"] = "Сбросить Позицию",
	["Resets the layout frame's position and anchor."] = "Сбросить положение фреймов и пометок",
	["Hide tab"] = "Скрыть ярлык",
	["Do not show the tab when Grid is unlocked."] = "Не отображать ярлык когда Grid откреплен.",
--}}}

--{{{ GridLayoutLayouts
	["None"] = "Нет",
	["By Group 5"] = "Для Группы из 5 чел.",
	["By Group 5 w/Pets"] = "Для Группы из 5 чел. с питомцами",
	["By Group 10"] = "Для Группы из 10 чел.",
	["By Group 10 w/Pets"] = "Для Группы из 10 чел. с питомцами",
	["By Group 15"] = "Для Группы из 15 чел.",
	["By Group 15 w/Pets"] = "Для Группы из 15 чел. с питомцами",
	["By Group 25"] = "Для Группы из 25 чел.",
	["By Group 25 w/Pets"] = "Для Группы из 25 чел. с питомцами",
	["By Group 25 w/Tanks"] = "Для Группы из 25 чел. с танками",
	["By Group 40"] = "Для Группы из 40 чел.",
	["By Group 40 w/Pets"] = "Для Группы из 40 чел. с питомцами",
	["By Class 10 w/Pets"] = "По классам из 10 чел",
	["By Class 25 w/Pets"] = "По классам из 25 чел",
--}}}

--{{{ GridLDB
--	["Click to open the options in a GUI window."] = "",
--	["Right-Click to open the options in a drop-down menu."] = "",
--}}}

--{{{ GridRange
	-- used for getting spell range from tooltip
	["(%d+) yd range"] = "Радиус действия: (%d+) м",
--}}}

--{{{ GridStatus
	["Status"] = "Статус",
	["Options for %s."] = "Опции для %s.",
	["Reset class colors"] = "Сбросс окраски классов",
	["Reset class colors to defaults."] = "Сбросить окраску классов на значение по умолчанию.",

	-- module prototype
	["Status: %s"] = "Статус: %s",
	["Color"] = "Цвет",
	["Color for %s"] = "Цвет для %s",
	["Priority"] = "Приоритет",
	["Priority for %s"] = "Приоритет для %s",
	["Range filter"] = "Фильтр радиуса",
	["Range filter for %s"] = "Фильтр радиуса для %s",
	["Enable"] = "Включено",
	["Enable %s"] = "Включено %s",
--}}}

--{{{ GridStatusAggro
	["Aggro"] = "Агро",
	["Aggro alert"] = "Сигнал Агро",
	["High Threat color"] = "Цвет наивысшей угрозы",
	["Color for High Threat."] = "Окраска наивысшей угрозы.",
	["Aggro color"] = "Цвет агро",
	["Color for Aggro."] = "Окраска агро",
	["Tanking color"] = "Цвет танкования",
	["Color for Tanking."] = "Окраска танкования",
	["Threat"] = "Угроза",
	["Show more detailed threat levels."] = "Отображение более подробного уровеня угрозы.",
	["High"] = "Наивысшая",
	["Tank"] = "Танк",
--}}}

--{{{ GridStatusAuras
	["Auras"] = "Ауры",
	["Debuff type: %s"] = "Тип Дебаффа: %s",
	["Poison"] = "Яды",
	["Disease"] = "Болезнь",
	["Magic"] = "Магия",
	["Curse"] = "Проклятье",
	["Ghost"] = "Призрак",
	["Buffs"] = "Баффы",
	["Debuff Types"] = "Типы дебаффов",
	["Debuffs"] = "Дебаффы",
	["Add new Buff"] = "Добавить новый бафф",
	["Adds a new buff to the status module"] = "Добавляет новый бафф в можуль статуса",
	["<buff name>"] = "<имя баффа>",
	["Add new Debuff"] = "Добавить новый дебафф",
	["Adds a new debuff to the status module"] = "Добавляет новый дебафф в модуль статуса",
	["<debuff name>"] = "<имя дебаффа>",
	["Delete (De)buff"] = "Удалить бафф/дебафф",
	["Deletes an existing debuff from the status module"] = "Удаляет выбранный дебафф в модуле статуса модуль",
	["Remove %s from the menu"] = "Удалите %s из меню",
	["Debuff: %s"] = "Дебафф: %s",
	["Buff: %s"] = "Бафф: %s",
	["Class Filter"] = "Фильтр классов",
	["Show status for the selected classes."] = "Показывает статус для выбранных классов.",
	["Show on %s."] = "Показать на %s.",
	["Show if mine"] = "Показать если моё",
	["Display status only if the buff was cast by you."] = "Показывать статус только если баффы применяются на вас",
	["Show if missing"] = "Показывать если пропущен",
	["Display status only if the buff is not active."] = "Показывать статус только если баффы не активны",
	["Filter Abolished units"] = "Фильтр персонажей находящихся под исцелением",
	["Skip units that have an active Abolish buff."] = "Пропускает персонажей на которых есть активные баффы исцеления.",
	["Show duration"] = "Длительность",
	["Show the time remaining, for use with the center icon cooldown."] = "Показывать в центре иконки остаток времени.",
--}}}

--{{{ GridStatusHeals
	["Heals"] = "Лечения",
	["Incoming heals"] = "Поступающее лечения",
	["Ignore Self"] = "Игнорировать себя",
	["Ignore heals cast by you."] = "Игнорировать свои лечебные заклинания",
	["Heal filter"] = "Фильтр исцеления",
	["Show incoming heals for the selected heal types."] = "Показывает входящее исцеления для выбранного типа исцеления.",
	["Direct heals"] = "Прямое исцеление",
	["Include direct heals."] = "Включить прямое исцеление.",
	["Channeled heals"] = "Потоковое исцеление",
	["Include channeled heals."] = "Включить потоковое исцеление.",
	["HoT heals"] = "Исцеление за время",
	["Include heal over time effects."] = "Включить исцеление за время (ХоТы).",
--}}}

--{{{ GridStatusHealth
	["Low HP"] = "Мало ЗД",
	["DEAD"] = "ТРУП",
	["FD"] = "ПМ",
	["Offline"] = "Оффлайн",
	["Unit health"] = "Здоровье единицы",
	["Health deficit"] = "Дефицит здоровья",
	["Low HP warning"] = "Предупреждение Мало ЗД",
	["Feign Death warning"] = "Предупреждение о Симуляции смерти",
	["Death warning"] = "Предупреждение о смерти",
	["Offline warning"] = "Предупреждение об оффлайне",
	["Health"] = "Здоровье",
	["Show dead as full health"] = "Показывать мертвых как-будто с полным здоровьем",
	["Treat dead units as being full health."] = "расматривать данные единицы как имеющие полное здоровье.",
	["Use class color"] = "Использовать цвет классов",
	["Color health based on class."] = "Цвет полосы здоровья в зависимости от класса",
	["Health threshold"] = "Порог здоровья",
	["Only show deficit above % damage."] = "Показывать дефицит только после % урона.",
	["Color deficit based on class."] = "Цвет дефицита в зависимости от класса",
	["Low HP threshold"] = "Порог \"Мало ЗД\"",
	["Set the HP % for the low HP warning."] = "Установить % для предупреждения о том что у единицы мало здоровья.",
--}}}

--{{{ GridStatusMana
	["Mana"] = "Мана",
	["Low Mana"] = "Мало маны",
	["Mana threshold"] = "Порог маны",
	["Set the percentage for the low mana warning."] = "Установить процент для предупреждения об окончании маны.",
	["Low Mana warning"] = "Предупреждение о заканчивающейся мане",
--}}}

--{{{ GridStatusName
	["Unit Name"] = "Имя единицы",
	["Color by class"] = "Цвет по классу",
--}}}

--{{{ GridStatusRange
	["Range"] = "Расстояние",
	["Range check frequency"] = "Частота проверки растояния",
	["Seconds between range checks"] = "Частота проверки в секундах",
	["More than %d yards away"] = "Дальше чем %d м.",
	["%d yards"] = "%d м.",
	["Text"] = "Текст",
	["Text to display on text indicators"] = "Отображаемый текст в индикаторе",
	["<range>"] = "<range>",
--}}}

--{{{ GridStatusReadyCheck
	["Ready Check"] = "Проверка готовности",
	["Set the delay until ready check results are cleared."] = "Установите задержку,временной простой перед очисткой результатов проверки готовности.",
	["Delay"] = "Задержка",
	["?"] = "?",
	["R"] = "R",
	["X"] = "X",
	["AFK"] = "Отсутствует",
	["Waiting color"] = "Ожидиние",
	["Color for Waiting."] = "Окраска ожидающих",
	["Ready color"] = "Готовности",
	["Color for Ready."] = "Окраска готовых",
	["Not Ready color"] = "НеЕ готов",
	["Color for Not Ready."] = "Окраска не готовых",
	["AFK color"] = "Отсутствие",
	["Color for AFK."] = "Окраска отсутствующих",
--}}}

--{{{ GridStatusTarget
	["Target"] = "Цель",
	["Your Target"] = "Ваша цель",
--}}}

--{{{ GridStatusVehicle
	["In Vehicle"] = "На транспорте",
	["Driving"] = "Управляет",
--}}}

--{{{ GridStatusVoiceComm
	["Voice Chat"] = "Голосовой чат",
	["Talking"] = "Говорит",
--}}}

}