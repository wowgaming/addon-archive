--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-ruRU.lua - Localized string constants (ru-RU).              *
  ****************************************************************************]]


if ( GetLocale() ~= "ruRU" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/ruRU/
local _NPCScan = select( 2, ... );
_NPCScan.L = setmetatable( {
	NPCs = setmetatable( {
		[ 18684 ] = "Бро'Газ Без Клана",
		[ 32491 ] = "Затерянный во времени протодракон",
		[ 33776 ] = "Гондрия",
		[ 35189 ] = "Сколл",
		[ 38453 ] = "Арктур",
	}, { __index = _NPCScan.L.NPCs; } );

	BUTTON_FOUND = "Найден НИП!",
	CACHED_FORMAT = "Следующие юниты уже находятся в кэше: %s.",
	CACHED_LONG_FORMAT = "Следующие юниты уже находятся в кэше. Попробуйте удалить их с помощью команды |cff808080“/npcscan”|r или сбросить их очистив ваш кэш: %s.",
	CACHED_WORLD_FORMAT = "Следующий(ие) %2$s юнит(ы) уже находятся в кэше: %1$s.",
	CACHELIST_ENTRY_FORMAT = "|cff808080“%s”|r",
	CACHELIST_SEPARATOR = ", ",
	CMD_ADD = "ADD",
	CMD_CACHE = "CACHE",
	CMD_HELP = "Команды |cff808080“/npcscan add <IDНИПа> <Название>”|r, |cff808080“/npcscan remove <IDНИПа или название>”|r, |cff808080“/npcscan cache”|r выводит список существ из кеша, и просто |cff808080“/npcscan”|r открывает меню настроек.",
	CMD_REMOVE = "REMOVE",
	CMD_REMOVENOTFOUND_FORMAT = "НИП |cff808080“%s”|r не найден.",
	CONFIG_ALERT = "Настройки сигнала",
	CONFIG_ALERT_SOUND = "Звуковой файл сигнала",
	CONFIG_ALERT_SOUND_DEFAULT = "|cffffd200По умолчанию|r",
	CONFIG_ALERT_SOUND_DESC = "Выберите звуковой файл, который будет проигрываться при обнаружении НИПа. Дополнительные звуки могут быть добавлены через модификацию |cff808080“SharedMedia”|r.",
	CONFIG_ALERT_UNMUTE = "Включить звук для звукового сигнала",
	CONFIG_ALERT_UNMUTE_DESC = "Если у вас приглушённый звук в игре, то ето позволяет кратко проиграть звук при обнаружении НИПа.",
	CONFIG_CACHEWARNINGS = "Выводить напоминания о кеше при входе/изменении мира",
	CONFIG_DESC = "Эти параметры позволяют настроить для вас способ оповещения _NPCScan, при обнаружении им редкого НИПа.",
	CONFIG_TEST = "Тест сигнала обнаружения",
	CONFIG_TEST_DESC = "Имитирует оповещение |cff808080“Найден НИП!|r, которое информирует вас что имеено надо искать.",
	CONFIG_TEST_NAME = "Вы! (Тест)",
	CONFIG_TITLE = "_|cffCCCC88NPCScan|r",
	FOUND_FORMAT = "Найдено: |cff808080“%s”|r!",
	FOUND_TAMABLE_FORMAT = "Найдено: |cff808080“%s”|r!  |cffff2020(Заметка: приручаемое существо, может быть только питомцем.)|r",
	FOUND_TAMABLE_WRONGZONE_FORMAT = "|cffff2020False alarm:|r Найдено приручаемое существо |cff808080“%s”|r в %s вмесо %s (ID %d); Определенно питомец.",
	PRINT_FORMAT = "_|cffCCCC88NPCScan|r: %s",
	SEARCH_ACHIEVEMENTADDFOUND = "Поиск по завершенным НИПам для достижений",
	SEARCH_ACHIEVEMENTADDFOUND_DESC = "Продолжать поиск всех НИПов для достижений, даже если они больше не нужны.",
	SEARCH_ACHIEVEMENT_DISABLED = "Отключено",
	SEARCH_ADD = "+",
	SEARCH_ADD_DESC = "Добавить нового НИПа или сохранить изменения в уже существующего.",
	SEARCH_ADD_TAMABLE_FORMAT = "Заметка: |cff808080“%s”|r - приручаемое, при его обнаружении как прирученый питомец охотника будет воспроизводиться ложная тревога.",
	SEARCH_CACHED = "В кеше",
	SEARCH_COMPLETED = "Готово",
	SEARCH_DESC = "Эта таблица позволяет добавить или удалить из поиска НИПов и достижения.",
	SEARCH_ID = "ID НИПа:",
	SEARCH_ID_DESC = "ID НИПа для поиска.  Данное значение можно найти на таких сайтах как Wowhead.com.",
	SEARCH_NAME = "Название:",
	SEARCH_NAME_DESC = "Ярлык НИПа. Он не должна совпадать с реальным названием НИПа.",
	SEARCH_NPCS = "Свои НИПы",
	SEARCH_NPCS_DESC = "Добавить к отслеживанию любого НИПа, даже если он не относится к достижениям.",
	SEARCH_REMOVE = "-",
	SEARCH_TITLE = "Поиск",
	SEARCH_WORLD = "Мир:",
	SEARCH_WORLD_FORMAT = "(%s)",
}, { __index = _NPCScan.L; } );