-- Please see enus.lua for reference.

QuestHelper_Translations.csCZ =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "Cesky",
  
  -- Messages used when starting.
  LOCALE_ERROR = "Lokalizace vašich uložených dat neodpovídá lokalizaci vašeho WoW klienta. Pro použití QuestHelpera budete potřebovat změnit lokalizaci zpět, nebo smazat data pomocí %h(/qh purge).",
  ZONE_LAYOUT_ERROR = "Odmítl jsem spustit, ze strachu z poškození vašich uložených dat. Prosím počkejte na patch, který bude schopen zvládnout nové rozložení zón.",
  HOME_NOT_KNOWN = "Váš domov není znám. Jakmile to bude možné, prosím promluvte se svým innkeeperem a nastavte si ho.",
  PRIVATE_SERVER = "QuestHelper nepodporuje soukromé servery.",
  PLEASE_RESTART = "Došlo k chybě při startu QuestHelperu. Prosím ukončete World of Warcraft a zkuste to znovu.",
  NOT_UNZIPPED_CORRECTLY = "QuestHelper nebyl správně nainstalován. Doporučujeme použít buď Curse Clienta nebo 7zip k instalaci. Ujistěte se, že podadresáře jsou rozbaleny.",
  PLEASE_SUBMIT = "%h(QuestHelper potřebuje vaši pomoc!) Pokud máte pár minut, prosíme jděte na QuestHelper domovskou stránku %h(http://www.questhelp.us) kde postupujte dle instrukcí pro potvrzení vašich nasbíraných dat. Vaše data udržují QuestHelper v aktualizované podobě. Děkujeme!",
  HOW_TO_CONFIGURE = "QuestHelper dosud nemá fungující nastavení, ale může být nastaveno pomocí %h(/qh settings). Nápověda je dostupná pomocí %h(/qh help).",
  TIME_TO_UPDATE = "Může být dostupná %h(nová verze QuestHelperu). Nové verze obvykle obsahují nové funkce, nové questy v databázi a opravy bugů. Prosím aktualizujte!",
  
  -- Route related text.
  ROUTES_CHANGED = "Letové trasy pro vaši postavu byly upraveny.",
  HOME_CHANGED = "Váš domov byl změněn.",
  TALK_TO_FLIGHT_MASTER = "Promluvte si s lokálním flight masterem.",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "Díky.",
  WILL_RESET_PATH = "Informace cesty resetovány.",
  UPDATING_ROUTE = "Aktualizuji cestu.",
  
  -- Special tracker text
  QH_LOADING = "QuestHelper se načítá (%1%)...",
  QH_FLIGHTPATH = "Přapočítávám letové cíle (%1%)...",
  QH_RECALCULATING = "Přepočítávám trasu (%1%)...",
  QUESTS_HIDDEN_1 = "Questy mohou být skryty",
  QUESTS_HIDDEN_2 = "(\"/qh hidden\" pro seznam)",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "Dostupné lokalizace:",
  LOCALE_CHANGED = "Lokalizace změněna na: %h1",
  LOCALE_UNKNOWN = "Lokalizace %h1 není známa.",
  
  -- Words used for objectives.
  SLAY_VERB = "Zabijte",
  ACQUIRE_VERB = "Získejte",
  
  OBJECTIVE_REASON = "%1 %h2 do questu %h3.", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "%h1 do questu %h2.",
  OBJECTIVE_REASON_TURNIN = "Zastavte se u %h1.",
  OBJECTIVE_PURCHASE = "Kupte od %h1.",
  OBJECTIVE_TALK = "Promluvte s %h1.",
  OBJECTIVE_SLAY = "Zabijte %h1.",
  OBJECTIVE_LOOT = "lootněte %h1.",
  OBJECTIVE_OPEN = nil,
  
  OBJECTIVE_MONSTER_UNKNOWN = "neznámé monstrum",
  OBJECTIVE_ITEM_UNKNOWN = "neznámý předmět",
  
  ZONE_BORDER_SIMPLE = "%1 okraj",
  
  -- Stuff used in objective menus.
  PRIORITY = "Priorita",
  PRIORITY1 = "Nejvyšší",
  PRIORITY2 = "Vysoká",
  PRIORITY3 = "Normální",
  PRIORITY4 = "Nízká",
  PRIORITY5 = "Nejnižší",
  SHARING = "Sdílení",
  SHARING_ENABLE = "Povolit sdílení",
  SHARING_DISABLE = "Zakázat sdílení",
  IGNORE = "Ignorovat",
  IGNORE_LOCATION = "Ignorovat tuto lokaci",
  
  IGNORED_PRIORITY_TITLE = "Zvolená priorita bude ignorována.",
  IGNORED_PRIORITY_FIX = "Použít stejnou prioriru na blokované úkoly.",
  IGNORED_PRIORITY_IGNORE = "Nastavím si priority sám.",
  
  -- "/qh find"
  RESULTS_TITLE = "Výsledky hledání",
  NO_RESULTS = "Nejsou žádné!",
  CREATED_OBJ = "Vytvořeno: %1",
  REMOVED_OBJ = "Smazáno: %1",
  USER_OBJ = "Uživatelské úkoly: %h1",
  UNKNOWN_OBJ = "Nevím kam máte jít pro tento úkol.",
  INACCESSIBLE_OBJ = "QuestHelper nemohl nalézt použitelnou lokalizaci pro %h1. Přidali jsme pravděpodobně nenalezenou lokalizaci do vašeho seznamu úkolů. Pokud naleznete použitelnou verzi této lokalizace, prosím odešlete nám ji! (%h(/qh submit))",
  FIND_REMOVE = "Zrušit úkol",
  FIND_NOT_READY = "QuestHelper nedokončil načítání. Prosím počkejte chvíli a zkuste to znovu.",
  FIND_CUSTOM_LOCATION = "Vlastní umístění",
  FIND_USAGE = nil,
  
  -- Shared objectives.
  PEER_TURNIN = "Pockejte na %h1 pro %h2.",
  PEER_LOCATION = "Pomozte %h1 dosáhnout lokaci v %h2.",
  PEER_ITEM = "Pomozte %1 k získání %h2.",
  PEER_OTHER = "Pomozte %1 s %h2.",
  
  PEER_NEWER = "%h1 používá novější verzi protokolu. Mohl by to být čas na aktualizaci.",
  PEER_OLDER = "%h1 používá starší verzi protokolu.",
  
  UNKNOWN_MESSAGE = "Neznámý typ zprávy '%1' od '%2'.",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "Skryté úkoly",
  HIDDEN_NONE = "Žádné úkoly nejsou skryty",
  DEPENDS_ON_SINGLE = "Závisí na '%1'",
  DEPENDS_ON_COUNT = "Zavisí na %1 skrytých úkolech",
  DEPENDS_ON = "Závisí na filtrovaných úkolech",
  FILTERED_LEVEL = "Filtrováno kvůli levelu",
  FILTERED_GROUP = "Filtrováno kvůli velikosti party",
  FILTERED_ZONE = "Filtrováno kvůli zóně",
  FILTERED_COMPLETE = "Filtrováno kvůli úplnosti",
  FILTERED_BLOCKED = "Filtrováno kvůli nekompletnímu předešlému úkolu",
  FILTERED_UNWATCHED = "Filtrováno protože není sledováno v Quest Logu",
  FILTERED_WINTERGRASP = "Filtrováno kvůli PvP Wintergrasp questu",
  FILTERED_RAID = "Filtrováno protože nelze dokončit v raidu",
  FILTERED_USER = "Úkol skryt protože to chcete",
  FILTERED_UNKNOWN = "Nevím co je potřeba k dokončení.",
  
  HIDDEN_SHOW = "Zobraz",
  HIDDEN_SHOW_NO = "Nezobrazitelné",
  HIDDEN_EXCEPTION = "Přidat výjimku",
  DISABLE_FILTER = "Vypnout filtr: %1",
  FILTER_DONE = "hotovo",
  FILTER_ZONE = "zóna",
  FILTER_LEVEL = "level",
  FILTER_BLOCKED = "blokováno",
  FILTER_WATCHED = "sledovaný",
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = nil,
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "Máte %h(nové informace) na %h1, a %h(aktualizované informace) na %h2.",
  NAG_SINGLE_NEW = "Máte %h(nové informace) na %h1.",
  NAG_ADDITIONAL = "Máte %h(doplňující informace) na %h1.",
  NAG_POLLUTED = "Vaše databáze byla znečištěna informacemi z testovacích nebo soukromých serverů a bude vyčištěna po spuštění.",
  
  NAG_NOT_NEW = "Nemáte žádné informace, které nejsou v základní databázi.",
  NAG_NEW = "Uvažujte o sdílení vašich dat, aby z nich i ostatní mohli mít užitek.",
  NAG_INSTRUCTIONS = "Napište %h(/qh submit) pro instrukce k odeslání dat.",
  
  NAG_SINGLE_FP = "flight master",
  NAG_SINGLE_QUEST = "quest",
  NAG_SINGLE_ROUTE = "trasa letu",
  NAG_SINGLE_ITEM_OBJ = "úkol předmětu",
  NAG_SINGLE_OBJECT_OBJ = "úkol objektu",
  NAG_SINGLE_MONSTER_OBJ = "úkol monstra",
  NAG_SINGLE_EVENT_OBJ = "úkol akce",
  NAG_SINGLE_REPUTATION_OBJ = "úkol reputace",
  NAG_SINGLE_PLAYER_OBJ = "úkol hráče",
  
  NAG_MULTIPLE_FP = "%1 flight masters",
  NAG_MULTIPLE_QUEST = "%1 questy",
  NAG_MULTIPLE_ROUTE = "%1 letové trasy",
  NAG_MULTIPLE_ITEM_OBJ = "%1 úkoly předmětu",
  NAG_MULTIPLE_OBJECT_OBJ = "%1 úkoly objektu",
  NAG_MULTIPLE_MONSTER_OBJ = "%1 úkoly monster",
  NAG_MULTIPLE_EVENT_OBJ = "%1 úkoly akce",
  NAG_MULTIPLE_REPUTATION_OBJ = "%1 úkoly reputace",
  NAG_MULTIPLE_PLAYER_OBJ = "%1 úkoly hráče",
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "%1 stav:",
  TRAVEL_ESTIMATE = "Zbývající čas cesty:",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "Navštivte %h1 kde:",
  FLIGHT_POINT = "%1 letový bod",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = "Levý klik: %1 ukazatele cesty.",
  QH_BUTTON_TOOLTIP2 = "Pravý klik: Zobrazit nastavení.",
  QH_BUTTON_SHOW = "Zobrazit",
  QH_BUTTON_HIDE = "Skrýt",

  MENU_CLOSE = "Zavřít nabídku",
  MENU_SETTINGS = "Nastavení",
  MENU_ENABLE = "Zapnout",
  MENU_DISABLE = "Vypnout",
  MENU_OBJECTIVE_TIPS = "%1 nápovědu úkolů",
  MENU_TRACKER_OPTIONS = "Quest Tracker",
  MENU_QUEST_TRACKER = "%1 Quest Tracker",
  MENU_TRACKER_LEVEL = "%1 levely u questů",
  MENU_TRACKER_QCOLOUR = "%1 barvy questů dle obtížnosti",
  MENU_TRACKER_OCOLOUR = "%1 barvy postupu u úkolů",
  MENU_TRACKER_SCALE = "Měřítko Trackeru",
  MENU_TRACKER_RESET = "Resetovat pozici",
  MENU_FLIGHT_TIMER = "%1 čas letu",
  MENU_ANT_TRAILS = "%1 mravenčí cesty",
  MENU_WAYPOINT_ARROW = "%1 šipka cílového bodu",
  MENU_MAP_BUTTON = "%1 tlačítko na mapě",
  MENU_ZONE_FILTER = "%1 filtr lokací",
  MENU_DONE_FILTER = "%1 filtr dokončených",
  MENU_BLOCKED_FILTER = "%1 filtr blokovaných",
  MENU_WATCHED_FILTER = "%1 filtr sledovaných",
  MENU_LEVEL_FILTER = "%1 filtr dle levelu",
  MENU_LEVEL_OFFSET = "Odchylka levelu u filtru",
  MENU_ICON_SCALE = "Velikost ikony",
  MENU_FILTERS = "Filtrování",
  MENU_PERFORMANCE = "Měřítko pracovní trasy",
  MENU_LOCALE = "Lokalizace",
  MENU_PARTY = "Party",
  MENU_PARTY_SHARE = "%1 sdílení úkolů",
  MENU_PARTY_SOLO = "%1 ignorování party",
  MENU_HELP = "Nápověda",
  MENU_HELP_SLASH = "Lomítkové příkazy",
  MENU_HELP_CHANGES = "Seznam změn",
  MENU_HELP_SUBMIT = "Odeslání dat",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "Sledováno QuestHelperem",
  TOOLTIP_QUEST = "Pro quest %h1.",
  TOOLTIP_PURCHASE = "Kupte %h1.",
  TOOLTIP_SLAY = "Zabijte pro %h1.",
  TOOLTIP_LOOT = "Lootněte pro %h1.",
  TOOLTIP_OPEN = nil,
  
  -- Settings
  SETTINGS_ARROWLINK_ON = "Používat %h1 k zobrazení úkolů.",
  SETTINGS_ARROWLINK_OFF = "Nepoužívat %h1 k zobrazení úkolů.",
  SETTINGS_ARROWLINK_ARROW = "QuestHelper šipka",
  SETTINGS_ARROWLINK_CART = "Cartographer navigační body",
  SETTINGS_ARROWLINK_TOMTOM = "TomTom",
  SETTINGS_PRECACHE_ON = "Přednačítání bylo %h(zapnuto).",
  SETTINGS_PRECACHE_OFF = "Přednačítání bylo %h(vypnuto).",
  
  SETTINGS_MENU_ENABLE = "Zapnout",
  SETTINGS_MENU_DISABLE = "Vypnout",
  SETTINGS_MENU_CARTWP = "%1 šipka Cartographeru",
  SETTINGS_MENU_TOMTOM = "%1 navigační šipka",
  
  SETTINGS_MENU_ARROW_LOCK = "Zamknout",
  SETTINGS_MENU_ARROW_ARROWSCALE = "Velikost šipky",
  SETTINGS_MENU_ARROW_TEXTSCALE = "Velikost textu",
  SETTINGS_MENU_ARROW_RESET = "Resetovat",
  
  SETTINGS_MENU_INCOMPLETE = nil,
  
  SETTINGS_RADAR_ON = nil,
  SETTINGS_RADAR_OFF = nil,
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "%h1 yardu",
  DISTANCE_METRES = "%h1 metru"
 }

