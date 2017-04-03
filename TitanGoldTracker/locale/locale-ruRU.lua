local L = LibStub("AceLocale-3.0"):NewLocale("Titan_GoldTracker","ruRU")
if not L then return end

	L["TITAN_GOLDTRACKER_TOOLTIPTEXT"] = "Всего золота";
	L["TITAN_GOLDTRACKER_ITEMNAME"] = "Слежение за Золотом";
	L["TITAN_GOLDTRACKER_CLEAR_DATA_TEXT"] = "Очистить базу данных";
	L["TITAN_GOLDTRACKER_RESET_SESS_TEXT"] = "Сбросить текущий сеанс";
	L["TITAN_GOLDTRACKER_DB_CLEARED"] = "Титан: Слежение за Золотом - База данных очищена.";
	L["TITAN_GOLDTRACKER_SESSION_RESET"] = "Титан: Слежение за Золотом - Сеан сброшен.";
	L["TITAN_GOLDTRACKER_MENU_TEXT"] = "Слежение за Золотом";
	L["TITAN_GOLDTRACKER_TOOLTIP"] = "Информация о золоте";
	L["TITAN_GOLDTRACKER_TOGGLE_PLAYER_TEXT"] = "Отображать золото у игрока";
	L["TITAN_GOLDTRACKER_TOGGLE_ALL_TEXT"] = "Отображать золото на сервера";
	L["TITAN_GOLDTRACKER_SESS_EARNED"] = "Заработано за данный сеанс";
	L["TITAN_GOLDTRACKER_PERHOUR_EARNED"] = "Заработано за час";
	L["TITAN_GOLDTRACKER_SESS_LOST"] = "Потрачено за данный сеанс";
	L["TITAN_GOLDTRACKER_PERHOUR_LOST"] = "Потрачено за час";
	L["TITAN_GOLDTRACKER_STATS_TITLE"] = "Статистика сеанса";
	L["TITAN_GOLDTRACKER_TTL_GOLD"] = "Всего золота";
	L["TITAN_GOLDTRACKER_START_GOLD"] = "Начальное количество золота";
	L["TITAN_GOLDTRACKER_TOGGLE_SORT_GOLD"] = "Сортировать по золоту";
	L["TITAN_GOLDTRACKER_TOGGLE_SORT_NAME"] = "Сортировать по имени";
	L["TITAN_GOLDTRACKER_TOGGLE_GPH_SHOW"] = "Отображать золото за час";
	L["TITAN_GOLDTRACKER_TOGGLE_GPH_HIDE"] = "Скрыть золота за час";

	L["TITAN_GOLDTRACKER_TOGGLE_PLAYER_SHOW"] = "Отображать данного персонажа";
	L["TITAN_GOLDTRACKER_TOGGLE_PLAYER_HIDE"] = "Скрыть данного персонажа";
	L["TITAN_GOLDTRACKER_STATUS_PLAYER_SHOW"] = "видимый";
	L["TITAN_GOLDTRACKER_STATUS_PLAYER_HIDE"] = "скрыт";
	L["TITAN_GOLDTRACKER_DELETE_PLAYER"] = "Удалить персонажа";
	L["TITAN_GOLDTRACKER_FACTION_PLAYER_ALLY"] = "Альянс";
	L["TITAN_GOLDTRACKER_FACTION_PLAYER_HORDE"] = "Орда";
	L["TITAN_GOLDTRACKER_CLEAR_DATA_WARNING"] = GREEN_FONT_COLOR_CODE.."Внимание: "..FONT_COLOR_CODE_CLOSE.."Данное действие уничтожит вашу базу данных Gold Trackerа. Если вы хотите продолжить, жмите 'Принять', если нет, жмите 'Отмена' или клавишу 'Escape'.";