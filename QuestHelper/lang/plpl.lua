-- Please see enus.lua for reference.

QuestHelper_Translations.plPL =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "Polski",
  
  -- Messages used when starting.
  LOCALE_ERROR = "Lokalizacja zapisanych danych nie pasuje do lokalizacji Twojego klienta WoW. Aby korzystać z QuestHelper'a musisz albo przywrócić lokalizację, albo usunąć dane, wpisując %h (/qh purge).",
  ZONE_LAYOUT_ERROR = "Odmawiam uruchomienia, gdyż boje się uszkodzenia zapisanych danych. Proszę, poczekaj na aktualizację, która będzie w stanie obsłużyć nowy wygląd strefy.",
  HOME_NOT_KNOWN = "Twoje miejsce zamieszkania nie jest znane. Kiedy będziesz mógł, porozmawiaj z karczmarzem (Innkeeper) i ustaw miejsce zamieszkania.",
  PRIVATE_SERVER = "QuestHelper nie obsługuje prywatnych serwerów.",
  PLEASE_RESTART = "Podczas uruchamiania QuestHelper'a wystąpił błąd. Proszę całkowicie wyjść z World of Warcraft i spróbować uruchomić go ponownie.",
  NOT_UNZIPPED_CORRECTLY = "QuestHelper został nieprawidłowo zainstalowany. Do instalacji zalecamy stosowanie klienta Curse lub 7zip. Upewnij się, że podkatalogi są wyodrębnione.",
  PLEASE_SUBMIT = "%h(Quest Helper potrzebuje twojej pomocy!) Jezeli masz kilka minut,udaj sie na strone Quest Helpera %h(http://www.questhelp.us)i zastosuj sie do instrukcji w celu podzielenia sie swoimi danymi.Twoje dane aktualizuja Quest Helpera i poprawiaja bledy. Dziekuje!",
  HOW_TO_CONFIGURE = "QuestHelper nie ma jeszcze gotowej strony ustawień, ale może być skonfigurowany poprzez komendę %h(/qh settings). Pomoc jest udzielana poprzez %h(/qh help).",
  TIME_TO_UPDATE = "Mogła wyjść nowa wersja QuestHelper'a. Nowa wersja zazwyczaj zawiera nowe opcje, nową bazę zadań, oraz naprawione błędy. Proszę, zaktualizuj!",
  
  -- Route related text.
  ROUTES_CHANGED = "Trasy lotów Twojej postaci zostały zmienione.",
  HOME_CHANGED = "Twoje miejsce zamieszkania zostało zmienione.",
  TALK_TO_FLIGHT_MASTER = "Porozmawiaj z lokalnym Flight Masterem.",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "Dziękuję.",
  WILL_RESET_PATH = "Resetuję informacje o trasie.",
  UPDATING_ROUTE = "Odswieżanie trasy.",
  
  -- Special tracker text
  QH_LOADING = "Ładowanie QuestHelper'a (%1%)...",
  QH_FLIGHTPATH = "Obliczanie ścieżek lotów (%1%)...",
  QH_RECALCULATING = nil,
  QUESTS_HIDDEN_1 = "Zadania mogą być ukryte",
  QUESTS_HIDDEN_2 = "(wpisz \"/qh hidden\", aby zobaczyć listę)",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "Dostępne lokalizacje:",
  LOCALE_CHANGED = "Lokalizacja zmieniona na: %h1",
  LOCALE_UNKNOWN = "Lokalizacja %h1 jest nieznana.",
  
  -- Words used for objectives.
  SLAY_VERB = "Zabij",
  ACQUIRE_VERB = "Uzyskaj",
  
  OBJECTIVE_REASON = "%1 %h2 do zadania %h3.", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "%h1 do zadania %h2.",
  OBJECTIVE_REASON_TURNIN = "Oddaj zadanie do %h1.",
  OBJECTIVE_PURCHASE = "Kup od %h1.",
  OBJECTIVE_TALK = "Porozmawiaj z %h1.",
  OBJECTIVE_SLAY = "Zabij %h1.",
  OBJECTIVE_LOOT = "Zbierz %h1.",
  OBJECTIVE_OPEN = nil,
  
  OBJECTIVE_MONSTER_UNKNOWN = "nieznany potwór",
  OBJECTIVE_ITEM_UNKNOWN = "nieznany przedmiot",
  
  ZONE_BORDER_SIMPLE = nil,
  
  -- Stuff used in objective menus.
  PRIORITY = "Priorytet",
  PRIORITY1 = "Najwyższy",
  PRIORITY2 = "Wysoki",
  PRIORITY3 = "Normalny",
  PRIORITY4 = "Niski",
  PRIORITY5 = "Najniższy",
  SHARING = "Udostępniane",
  SHARING_ENABLE = "Udostępniaj",
  SHARING_DISABLE = "Nie udostępniaj",
  IGNORE = "Ignoruj",
  IGNORE_LOCATION = "Zignoruj tą lokalizację",
  
  IGNORED_PRIORITY_TITLE = "Zaznaczony priorytet będzie ignorowany.",
  IGNORED_PRIORITY_FIX = "Zastosuj ten sam priorytet do blokowanych celów.",
  IGNORED_PRIORITY_IGNORE = "Sam ustwię priorytet.",
  
  -- "/qh find"
  RESULTS_TITLE = "Wyniki wyszukiwania",
  NO_RESULTS = "Nic nie znaleziono!",
  CREATED_OBJ = "Utworzono: %1",
  REMOVED_OBJ = "Usunięto: %1",
  USER_OBJ = "Cel użytkownika: %h1",
  UNKNOWN_OBJ = "Nie wiem gdzie masz się udać, aby osiagnąć swój cel.",
  INACCESSIBLE_OBJ = "QuestHelper nie był w stanie znaleźć lokalizacji %h1. Zostało to dodane do listy lokalizacji niemożliwych do odnalezienia. Jeśli znajdziesz użyteczną wesję tego obiektu, proszę o przesłanie danych. (%h(/qh submit))",
  FIND_REMOVE = nil,
  FIND_NOT_READY = nil,
  FIND_CUSTOM_LOCATION = nil,
  FIND_USAGE = nil,
  
  -- Shared objectives.
  PEER_TURNIN = "Poczekaj na %h1, aby oddał %h2.",
  PEER_LOCATION = "Pomóż %h1 dotrzeć do %h2.",
  PEER_ITEM = "Pomóż %1 zdobyć %h2.",
  PEER_OTHER = "Pomóż %1 w %h2.",
  
  PEER_NEWER = "%h1 używa nowszej wersji protokołu. Być może czas na uaktualnienie.",
  PEER_OLDER = "%h1 używa starszej wersji protokołu.",
  
  UNKNOWN_MESSAGE = "Nieznany typ wiadomości '%1' od '%2'.",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "Ukryte cele",
  HIDDEN_NONE = "Nie ma ukrytych celów",
  DEPENDS_ON_SINGLE = "Zależy od '%1'",
  DEPENDS_ON_COUNT = "Zależy od %1 ukrytych zadań",
  DEPENDS_ON = "Zależy od filtrowanych zadań",
  FILTERED_LEVEL = "Filtr ukrył zadanie, gdyż masz za niski poziom",
  FILTERED_GROUP = "Filtr ukrył liczebność grupy",
  FILTERED_ZONE = "Ukryte z powodu strefy",
  FILTERED_COMPLETE = "Zadanie wypełnione, filtr je ukrył",
  FILTERED_BLOCKED = "Ukryte przez filtr z powodu niewykonanego ważniejszego zadani",
  FILTERED_UNWATCHED = "Zadanie ukryte, gdyż nie jest śledzone w dzienniku zadań",
  FILTERED_WINTERGRASP = "Filtr ukrył zadanie PvP Wintergrasp",
  FILTERED_RAID = nil,
  FILTERED_USER = "Ustawiłeś to zadanie jako ukryte",
  FILTERED_UNKNOWN = "Program nie wie, jak ukończyć zadanie",
  
  HIDDEN_SHOW = "Pokaż",
  HIDDEN_SHOW_NO = "Nie pokazywalne",
  HIDDEN_EXCEPTION = "Dodaj wyjątek",
  DISABLE_FILTER = "Zablokuj filtry: %1",
  FILTER_DONE = "zrobione",
  FILTER_ZONE = "strefa",
  FILTER_LEVEL = "poziom",
  FILTER_BLOCKED = "zablokowane",
  FILTER_WATCHED = "obserwowane",
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = nil,
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "Masz %h(nową informację) w %h1, i %h(zaktualizowaną informację) w %h2.",
  NAG_SINGLE_NEW = "Masz %h(nową informację) w %h1.",
  NAG_ADDITIONAL = "Masz %h(dodatkowych informacji) na %h1.",
  NAG_POLLUTED = "Twoja baza danych została skażona informacjami z testowego lub prywatnego serwera, dlatego zostanie wyczyszczona podczas startu.",
  
  NAG_NOT_NEW = "Nie masz żadnych informacji, które nie znajdują się już w statycznej bazie danych.",
  NAG_NEW = "Możesz rozważyć udostępnienie swoich danych, aby inni mogli z nich skorzystać.",
  NAG_INSTRUCTIONS = "Napisz %h(/qh submit), aby uzyskać instrukcje dotyczące wysyłania danych.",
  
  NAG_SINGLE_FP = "flight master",
  NAG_SINGLE_QUEST = "zadanie",
  NAG_SINGLE_ROUTE = "trasa lotu",
  NAG_SINGLE_ITEM_OBJ = "cel przedmiotu",
  NAG_SINGLE_OBJECT_OBJ = "cel objektu",
  NAG_SINGLE_MONSTER_OBJ = "cel potworów",
  NAG_SINGLE_EVENT_OBJ = "cel wydarzenia",
  NAG_SINGLE_REPUTATION_OBJ = "cel reputacji",
  NAG_SINGLE_PLAYER_OBJ = "cel gracza",
  
  NAG_MULTIPLE_FP = "%1 Flight Masterzy",
  NAG_MULTIPLE_QUEST = "%1 zadania",
  NAG_MULTIPLE_ROUTE = "%1 trasy lotu",
  NAG_MULTIPLE_ITEM_OBJ = "%1 cele przedmiotu",
  NAG_MULTIPLE_OBJECT_OBJ = "%1 cele objektu",
  NAG_MULTIPLE_MONSTER_OBJ = "%1 cele potworów",
  NAG_MULTIPLE_EVENT_OBJ = "%1 cele wydarzenia",
  NAG_MULTIPLE_REPUTATION_OBJ = "% cele reputacji",
  NAG_MULTIPLE_PLAYER_OBJ = "%1 cele gracza",
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "postęp %1:",
  TRAVEL_ESTIMATE = "Pozostały czas podróży:",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "Udaj sie do %1 w drodze do:",
  FLIGHT_POINT = "%1 punkt lotu",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = "LPM: %1 informacje o trasie.",
  QH_BUTTON_TOOLTIP2 = "PPM: Pokaż menu ustawień.",
  QH_BUTTON_SHOW = "Pokaż",
  QH_BUTTON_HIDE = "Ukryj",

  MENU_CLOSE = "Zamknij menu",
  MENU_SETTINGS = "Ustawienia",
  MENU_ENABLE = "Włącz",
  MENU_DISABLE = "Wyłącz",
  MENU_OBJECTIVE_TIPS = "%1 Podpowiedzi do zadań",
  MENU_TRACKER_OPTIONS = "Zaznaczanie zadań",
  MENU_QUEST_TRACKER = "Zaznaczanie zadań",
  MENU_TRACKER_LEVEL = "%1 Poziomy zadań",
  MENU_TRACKER_QCOLOUR = "%1 Kolory trudności zadań",
  MENU_TRACKER_OCOLOUR = "%1 Kolory postępu w zadaniach",
  MENU_TRACKER_SCALE = "Rozmiar wyszukiwania",
  MENU_TRACKER_RESET = "Zresetuj pozycję",
  MENU_FLIGHT_TIMER = "%1 Czas lotu",
  MENU_ANT_TRAILS = "%1 \"Szlak Mrówek\"",
  MENU_WAYPOINT_ARROW = "%1 Strzałka punktu orientacyjnego",
  MENU_MAP_BUTTON = "%1 Przycisk mapy",
  MENU_ZONE_FILTER = "% Filtr strefy",
  MENU_DONE_FILTER = "%1 Zrobione filtry",
  MENU_BLOCKED_FILTER = "%1 Zablokowane filtry",
  MENU_WATCHED_FILTER = "%1 Obserwowane filtry",
  MENU_LEVEL_FILTER = "%1 Filtr poziomu",
  MENU_LEVEL_OFFSET = "Zakres filtru poziomu",
  MENU_ICON_SCALE = "Skala Ikon",
  MENU_FILTERS = "Filtry",
  MENU_PERFORMANCE = "Obciążenie skali trasy",
  MENU_LOCALE = "Lokalizacja",
  MENU_PARTY = "Party",
  MENU_PARTY_SHARE = "%1 Udostepniaj zadania",
  MENU_PARTY_SOLO = "%1 Ignoruj grupę",
  MENU_HELP = "Pomoc",
  MENU_HELP_SLASH = "Komendy",
  MENU_HELP_CHANGES = "Lista zmian",
  MENU_HELP_SUBMIT = "Wysyłanie danych",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "Obserwowany przez QuestHelper'a",
  TOOLTIP_QUEST = "Do zadania %h1.",
  TOOLTIP_PURCHASE = "Kup %h1.",
  TOOLTIP_SLAY = "Zabij do %h1.",
  TOOLTIP_LOOT = "Zbierz dla %h1.",
  TOOLTIP_OPEN = nil,
  
  -- Settings
  SETTINGS_ARROWLINK_ON = "Używaj %h1 do pokazywania celów.",
  SETTINGS_ARROWLINK_OFF = "Nie używaj %h1 do pokazywania celów.",
  SETTINGS_ARROWLINK_ARROW = "Strzałka QuestHelper'a",
  SETTINGS_ARROWLINK_CART = "Kartograf punktów orintacyjnych",
  SETTINGS_ARROWLINK_TOMTOM = "TomTom",
  SETTINGS_PRECACHE_ON = "Wstępne buforowanie zostało %h(włączone).",
  SETTINGS_PRECACHE_OFF = "Wstępne buforowanie zostało %h(wyłączone).",
  
  SETTINGS_MENU_ENABLE = "Włącz",
  SETTINGS_MENU_DISABLE = "Wyłącz",
  SETTINGS_MENU_CARTWP = "%1 Strzałka kartografa",
  SETTINGS_MENU_TOMTOM = "%1 Strzałka TomToma",
  
  SETTINGS_MENU_ARROW_LOCK = "Zablokuj",
  SETTINGS_MENU_ARROW_ARROWSCALE = "Rozmiar strzałki",
  SETTINGS_MENU_ARROW_TEXTSCALE = "Rozmiar tekstu",
  SETTINGS_MENU_ARROW_RESET = "Zresetuj",
  
  SETTINGS_MENU_INCOMPLETE = nil,
  
  SETTINGS_RADAR_ON = nil,
  SETTINGS_RADAR_OFF = nil,
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "%h1 jardów",
  DISTANCE_METRES = "%h1 metrów"
 }

