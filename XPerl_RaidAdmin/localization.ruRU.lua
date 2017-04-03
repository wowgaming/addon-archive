--Russian localization file
--Translated by StingerSoft
if (GetLocale() == "ruRU") then
XPERL_ADMIN_TITLE	= XPerl_ShortProductName.." Рейд Админ"

XPERL_MSG_PREFIX	= "|c00C05050X-Perl|r "
XPERL_COMMS_PREFIX	= "X-Perl"

-- Raid Admin
XPERL_BUTTON_ADMIN_PIN		= "Закрепить Окно"
XPERL_BUTTON_ADMIN_LOCKOPEN	= "Блокировка открытого окна"
XPERL_BUTTON_ADMIN_SAVE1	= "Сохр-ть Список"
XPERL_BUTTON_ADMIN_SAVE2	= "Сохраняет текущий список с определённым именем. Если имя не заданно, будет использоваться текущее время вместо имени"
XPERL_BUTTON_ADMIN_LOAD1	= "Загр-ть Список"
XPERL_BUTTON_ADMIN_LOAD2	= "Загружает выбранный список. Любые участники рейда кто не сохранён в списке будут заменены вместо других с соответствующим классом"
XPERL_BUTTON_ADMIN_DELETE1	= "Удалить Список"
XPERL_BUTTON_ADMIN_DELETE2	= "Удалить выбранный список"
XPERL_BUTTON_ADMIN_STOPLOAD1 = "Остановить загрузку"
XPERL_BUTTON_ADMIN_STOPLOAD2 = "Прекратить процедуру загрузки списка"

XPERL_LOAD					= "Загр-ть"

XPERL_SAVED_ROSTER		    = "Сохр-ть список с названием '%s'"
XPERL_ADMIN_DIFFERENCES		= "%d отличие с текущим списком"
XPERL_NO_ROSTER_NAME_GIVEN	= "Не задано имя списка"
XPERL_NO_ROSTER_CALLED		= "Нет списка с названием '%s'"

-- Item Checker
XPERL_CHECK_TITLE			= XPerl_ShortProductName.." Предмет контроль"

XPERL_RAID_TOOLTIP_NOCTRA	= "CTRA не найдено"
XPERL_CHECK_NAME			= "Имя"

XPERL_CHECK_DROPITEMTIP1	= "Добытые вещи"
XPERL_CHECK_DROPITEMTIP2	= "Предмет может быть перетащен в фрейм и добавлен в список запрашиваемых вещей.\rВы можете использовать простую команду /raitem  и предметы будут добавлены сюда в будущем."
XPERL_CHECK_QUERY_DESC1		= "Запрос"
XPERL_CHECK_QUERY_DESC2		= "Выполнить проверку предметов (/raitem) на все выбранные предметы\rЗапрос всегда выдаст информацию о текущей прочности, устойчивости и реагентах"
XPERL_CHECK_LAST_DESC1		= "Последний"
XPERL_CHECK_LAST_DESC2		= "Пере-отметить предметы последнего поиска"
XPERL_CHECK_ALL_DESC1		= ALL
XPERL_CHECK_ALL_DESC2		= "Отметить все предметы"
XPERL_CHECK_NONE_DESC1		= NONE
XPERL_CHECK_NONE_DESC2		= "Снять отметку со всех предметов"
XPERL_CHECK_DELETE_DESC1	= DELETE
XPERL_CHECK_DELETE_DESC2	= "Навсегда удалить все отмеченные предметы из списка"
XPERL_CHECK_REPORT_DESC1	= "Сообщить"
XPERL_CHECK_REPORT_DESC2	= "Показать уведомление выбранных результатов в рейд чат"
XPERL_CHECK_REPORT_WITH_DESC1	= "С"
XPERL_CHECK_REPORT_WITH_DESC2	= "Уведомить людей с предметом (или не одетым) в рейд чат. Если сканирования снаряжения було выполнено, то результаты будут заменены."
XPERL_CHECK_REPORT_WITHOUT_DESC1= "Без"
XPERL_CHECK_REPORT_WITHOUT_DESC2= "Уведомить людей без предмета (или имеющих задействованый предмет) в рейд чат"
XPERL_CHECK_SCAN_DESC1		= "Скан"
XPERL_CHECK_SCAN_DESC2		= "Будет проверен каждый в рейде в пределах досягаемости, для просмотра выбранного снаряжения и отображения его в списке. Дальше 10ярд от рейда не попадут в проверку."
XPERL_CHECK_SCANSTOP_DESC1	= "Стоп Скан"
XPERL_CHECK_SCANSTOP_DESC2	= "Остановить сканирование снаряжения игроков для выбранного предмета"
XPERL_CHECK_REPORTPLAYER_DESC1	= "Доложить игроку"
XPERL_CHECK_REPORTPLAYER_DESC2	= "Доложить выбранным игрокам детали предмета или статус в рейд чат"

XPERL_CHECK_BROKEN		= "Сломанный"
XPERL_CHECK_REPORT_DURABILITY	= "Средняя прочность Рейда: %d%% и %d людей с общим количеством сломанных вещей %d"
XPERL_CHECK_REPORT_PDURABILITY	= "%s's Прочность: %d%% с %d сломанных вещей"
XPERL_CHECK_REPORT_RESISTS	= "Средняя устойчивость Рейда: %d "..SPELL_SCHOOL2_CAP..", %d "..SPELL_SCHOOL3_CAP..", %d "..SPELL_SCHOOL4_CAP..", %d "..SPELL_SCHOOL5_CAP..", %d "..SPELL_SCHOOL6_CAP
XPERL_CHECK_REPORT_PRESISTS	= "%s's Устойчивость: %d "..SPELL_SCHOOL2_CAP..", %d "..SPELL_SCHOOL3_CAP..", %d "..SPELL_SCHOOL4_CAP..", %d "..SPELL_SCHOOL5_CAP..", %d "..SPELL_SCHOOL6_CAP
XPERL_CHECK_REPORT_WITH		= " - с: "
XPERL_CHECK_REPORT_WITHOUT	= " - без: "
XPERL_CHECK_REPORT_WITH_EQ	= " - с (или не задействован): "
XPERL_CHECK_REPORT_WITHOUT_EQ	= " - без (или задействован): "
XPERL_CHECK_REPORT_EQUIPED	= " : одето: "
XPERL_CHECK_REPORT_NOTEQUIPED	= " : НЕ одето: "
XPERL_CHECK_REPORT_ALLEQUIPED	= "Все уже %s задействованы"
XPERL_CHECK_REPORT_ALLEQUIPEDOFF= "Все уже %s задействованы, но %d игрок(оа) в не сети"
XPERL_CHECK_REPORT_PITEM	= "%s имеет %d %s в инвентаре"
XPERL_CHECK_REPORT_PEQUIPED	= "%s уже %s задействован"
XPERL_CHECK_REPORT_PNOTEQUIPED	= "%s НЕ ИМЕЕТ %s одетым"
XPERL_CHECK_REPORT_DROPDOWN	= "Канал вывода"
XPERL_CHECK_REPORT_DROPDOWN_DESC= "Выберите канал вывода для результатов Предмет контроля"

XPERL_CHECK_REPORT_WITHSHORT	= " : %d с"
XPERL_CHECK_REPORT_WITHOUTSHORT	= " : %d без"
XPERL_CHECK_REPORT_EQUIPEDSHORT	= " : %d одето"
XPERL_CHECK_REPORT_NOTEQUIPEDSHORT	= " : %d НЕ одето"
XPERL_CHECK_REPORT_OFFLINE	= " : %d не в сети"
XPERL_CHECK_REPORT_TOTAL	= " : %d Всего предметов"
XPERL_CHECK_REPORT_NOTSCANNED	= " : %d не-проверено"

XPERL_CHECK_LASTINFO		= "Последние данные получены %sназад"

XPERL_CHECK_AVERAGE		= "Средний"
XPERL_CHECK_TOTALS		= "Всего"
XPERL_CHECK_EQUIPED		= "Одето"

XPERL_CHECK_SCAN_MISSING	= "Производится сканирование предметов игроков. (%d не просканировано)"

XPERL_REAGENTS			= {PRIEST = "Священная свеча", MAGE = "Порошок чар", DRUID = "Дикий шипокорень",
					SHAMAN = "Крест", WARLOCK = "Осколок души", PALADIN = "Символ божественности",
					ROGUE = "Воспламеняющийся порошок"}

XPERL_CHECK_REAGENTS		= "Реагенты"

-- Roster Text
XPERL_ROSTERTEXT_TITLE		= XPerl_ShortProductName.." Текст списка"
XPERL_ROSTERTEXT_GROUP		= "Группа %d"
XPERL_ROSTERTEXT_GROUP_DESC	= "Использовать имена для группы %d"
XPERL_ROSTERTEXT_SAMEZONE	= "Только одинаковые зоны"
XPERL_ROSTERTEXT_SAMEZONE_DESC	= "Включает только имена игроков которые находятся в той-же зоне что и вы"
XPERL_ROSTERTEXT_HELP		= "Нажмите Ctrl-C для копирования текста в буфер"
XPERL_ROSTERTEXT_TOTAL		= "Всего: %d"
XPERL_ROSTERTEXT_SETN		= "%d человек"
XPERL_ROSTERTEXT_SETN_DESC	= "Авто выбор группы для рейда %d человек "
XPERL_ROSTERTEXT_TOGGLE		= "Тумблер"
XPERL_ROSTERTEXT_TOGGLE_DESC	= "Переключатель выбранной группы"
XPERL_ROSTERTEXT_SORT		= "Сорт"
XPERL_ROSTERTEXT_SORT_DESC	= "Сортировать по имени вместо группа+имя"

end
