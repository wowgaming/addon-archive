if not ACP then return end

if (GetLocale() == "ruRU") then
	ACP:UpdateLocale( {
	["Reload your User Interface?"] = "Перезагрузить пользовательский интерфейс?",
	["Save the current addon list to [%s]?"] = "Сохранить текущий список модификаций в [%s]?",
	["Enter the new name for [%s]:"] = "Введите новое имя для [%s]:",
	["Addons [%s] Saved."] = "Модификации [%s] сохранены.",
	["Addons [%s] Unloaded."] = "Модификации [%s] выгружены.",
	["Addons [%s] Loaded."] = "Модификации [%s] загружены.",
	["Addons [%s] renamed to [%s]."] = "Модификации [%s] переименованны в [%s].",
	["Loaded on demand."] = "Загружен по требованию.",
	["AddOns"] = "Модификации",
	["Load"] = "Загрузить",
	["Disable All"] = "Откл. все",
	["Enable All"] = "Вкл. все",
	["ReloadUI"] = "Перез. ПИ",
	["Sets"] = "Наб.",
	["No information available."] = "Информация недоступна.",
	["Loaded"] = "Загружен",
	["Recursive"] = "Рекурсия",
	["Loadable OnDemand"] = "Загружаемый по требованию",
	["Disabled on reloadUI"] = "Отключен во время перез. ПИ",
	["Default"] = "По умолчанию";
	["Set "] = "Набор ";
	["Save"] = "Сохранить";
	["Load"] = "Загрузить";
	["Add to current selection"] = "Добавить в текущее выделение";
	["Remove from current selection"] = "Убрать из текущего выделения";
	["Rename"] = "Переименовать";
	["Use SHIFT to override the current enabling of dependancies behaviour."] = "Используйте SHIFT чтобы изменить поведение зависимостей.",
	["Click to enable protect mode. Protected addons will not be disabled"] = "Щелкните чтобы включить защищенный режим. Защищенные модификации не будут отключены",
	["when performing a reloadui."]="когда производиться перезагрузка ПИ.",
	["ACP: Some protected addons aren't loaded. Reload now?"]="ACP: Некоторые защищенные модификации не загруженны. Перезагрузить сейчас?",
	["Active Embeds"] = "Активные встроенные",
	["Memory Usage"] = "Использование памяти",
	["Close"] = "Закрыть",
		
	["Blizzard_AchievementUI"] = "Blizzard: Достижения",
	["Blizzard_AuctionUI"] = "Blizzard: Аукцион",
	["Blizzard_BarbershopUI"] = "Blizzard: Парикмахерская",
	["Blizzard_BattlefieldMinimap"] = "Blizzard: Миникарта поля боя",
	["Blizzard_BindingUI"] = "Blizzard: Привязка ПИ",
	["Blizzard_Calendar"] = "Blizzard: Календарь",
	["Blizzard_CombatLog"] = "Blizzard: Журнал поля боя",
	["Blizzard_CombatText"] = "Blizzard: Текст поля боя",
	["Blizzard_FeedbackUI"] = "Blizzard: Обратная связь",
	["Blizzard_GlyphUI"] = "Blizzard: Значки",
	["Blizzard_GMSurveyUI"] = "Blizzard: GM опрос",
	["Blizzard_GuildBankUI"] = "Blizzard: Банк гильдии",
	["Blizzard_InspectUI"] = "Blizzard: Осмотр",
	["Blizzard_ItemSocketingUI"] = "Blizzard: Соединение элементов",
	["Blizzard_MacroUI"] = "Blizzard: Макросы",
	["Blizzard_RaidUI"] = "Blizzard: Рейд",
	["Blizzard_TalentUI"] = "Blizzard: Таланты",
	["Blizzard_TimeManager"] = "Blizzard: Управление временем",
	["Blizzard_TokenUI"] = "Blizzard: Сивол",
	["Blizzard_TradeSkillUI"] = "Blizzard: Торговля",
	["Blizzard_TrainerUI"] = "Blizzard: Инструктор",
	["Blizzard_VehicleUI"] = "Blizzard: Транспорт",
		
	["*** Enabling <%s> %s your UI ***"] = "*** Включаю <%s> %s вашего ПИ ***";
	["*** Unknown Addon <%s> Required ***"] = "*** Неизвест. модиф. <%s> требуется ***";
	["LoD Child Enable is now %s"] = "Дочерний ЗпТ теперь включен %s";
	["Recursive Enable is now %s"] = "Рекурсия теперь включена %s";
	["Addon <%s> not valid"] = "Модификация <%s> неисправна",
	["Reload"] = "Перезагрузить";
	["Author"] = "Автор";
	["Version"] = "Версия";
	["Status"] = "Статус";
	["Dependencies"] = "Зависимости";
	["Embeds"] = "Встроенные";
	} )
end
