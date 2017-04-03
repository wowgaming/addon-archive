-- Please see enus.lua for reference.

QuestHelper_Translations.daDK =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "Dansk",
  
  -- Messages used when starting.
  LOCALE_ERROR = "Sproget i dine gemte data stemmer ikke med sproget til WoW klienten. For at bruge QuestHelper skal du enten ændre sproget tilbage, eller slette dataerne ved at skrive %h(/qh purge).",
  ZONE_LAYOUT_ERROR = "Din udgave af QuestHelper er ikke den nyeste og du bliver nød til at opdatere på http://www.questhelp.us for at den fortsat skal fungere. Du bruger i øjeblikket version %1.",
  HOME_NOT_KNOWN = "Dit hjem er ukendt. Tal venligst med din innkeeper ved førstkommende lejlighed og nulstil det.",
  PRIVATE_SERVER = "QuestHelper understøtter ikke private servere.",
  PLEASE_RESTART = "Der opstod en fejl ved start af QuestHelper. Afslutte World of Warcraft helt og prøv igen.",
  NOT_UNZIPPED_CORRECTLY = "QuestHelper er blevet installeret forkert. Vi anbefaler enten at bruge Curse Client eller 7zip til installering. Vær sikker på at undermapper bliver udpakket.",
  PLEASE_SUBMIT = "Brug et par minutter på at besøge hjemmesiden for QuestHelper (http://www.questhelp.us), og følg instruktionerne til hvordan du kan indsende dine indsamlede data. Dine data hjælper med at holde QuestHelper opdateret. På forhånd tak!",
  HOW_TO_CONFIGURE = "QuestHelper har endnu ikke en egentlig indstillingsside, men kan konfigureres ved at skrive %h(/qh settings). Få hjælp ved at skrive %h(/qh help).",
  TIME_TO_UPDATE = "Der er evt. en %h(ny QuestHelper version) klar. Nye versioner kan indeholde nye funktioner, nye quest databaser, og fejlrettelser. Opdater venligst!",
  
  -- Route related text.
  ROUTES_CHANGED = "Dine flyveruter er blevet ændret.",
  HOME_CHANGED = "Dit hjem er blevet ændret.",
  TALK_TO_FLIGHT_MASTER = "Snak med din lokale flyveleder.",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "Tak.",
  WILL_RESET_PATH = "Ruteinformation vil blive nulstillet.",
  UPDATING_ROUTE = "Opdaterer rute.",
  
  -- Special tracker text
  QH_LOADING = "QuestHelper indlæser (%1%%)...",
  QH_FLIGHTPATH = "Genberegner flyveruter (%1%)...",
  QH_RECALCULATING = "Omregner Ruten (%1%)...",
  QUESTS_HIDDEN_1 = "Der er evt. skjulte quests",
  QUESTS_HIDDEN_2 = "(\"/qh hidden\" for liste)",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "Tilgængelige sprog:",
  LOCALE_CHANGED = "Sprog er ændret til: %h1",
  LOCALE_UNKNOWN = "Sproget %h1 er ikke kendt.",
  
  -- Words used for objectives.
  SLAY_VERB = "Dræb",
  ACQUIRE_VERB = "Få fat i",
  
  OBJECTIVE_REASON = "%1 %h2 til quest %h3.", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "%h1 til quest %h2.",
  OBJECTIVE_REASON_TURNIN = "Aflever quest %h1.",
  OBJECTIVE_PURCHASE = "Køb fra %h1.",
  OBJECTIVE_TALK = "Snak med %h1.",
  OBJECTIVE_SLAY = "Dræb %h1.",
  OBJECTIVE_LOOT = "Plyndr %h1.",
  OBJECTIVE_OPEN = "Åben %h1.",
  
  OBJECTIVE_MONSTER_UNKNOWN = "Ukendt monster",
  OBJECTIVE_ITEM_UNKNOWN = "Ukendt genstand",
  
  ZONE_BORDER_SIMPLE = "%1 grænse",
  
  -- Stuff used in objective menus.
  PRIORITY = "Prioritet",
  PRIORITY1 = "Højeste",
  PRIORITY2 = "Høj",
  PRIORITY3 = "Normal",
  PRIORITY4 = "Lav",
  PRIORITY5 = "Laveste",
  SHARING = "Deler",
  SHARING_ENABLE = "Del",
  SHARING_DISABLE = "Del ikke",
  IGNORE = "Ignore",
  IGNORE_LOCATION = "Ignorer dette område",
  
  IGNORED_PRIORITY_TITLE = "Den valgte prioritet bliver ignoreret.",
  IGNORED_PRIORITY_FIX = "Sæt samme prioritet til de(t) blokerende mål.",
  IGNORED_PRIORITY_IGNORE = "Jeg sætter selv prioriterne.",
  
  -- "/qh find"
  RESULTS_TITLE = "Søgeresultat",
  NO_RESULTS = "Der er ingen!",
  CREATED_OBJ = "Oprettet: %1",
  REMOVED_OBJ = "Fjernet: %1",
  USER_OBJ = "Brugermål: %h1",
  UNKNOWN_OBJ = "Jeg ved ikke, hvor du skal gå hen med dette mål.",
  INACCESSIBLE_OBJ = "QuestHelper kan ikke finde en brugbar position til %h1. Der er tilføjet en (formodenligt) utilgengængelig position til din liste. Indsend venligst dine data, hvis du finder en brugbar udgave af målet! (%h(/q submit)) ",
  FIND_REMOVE = "Afsluttet Mål",
  FIND_NOT_READY = "QuestHelper er ikke færdig med at loade endnu. Vent Venligst et par minutter og prøv igen.",
  FIND_CUSTOM_LOCATION = "Tilpasset kort placering",
  FIND_USAGE = "Søg virker ikke, hvis du ikke fortæller hvad den skal finde. Prøv %h(/qh help) for vejledning.",
  
  -- Shared objectives.
  PEER_TURNIN = "Vent på at %h1 afleverer %h2.",
  PEER_LOCATION = "Hjælp %h1 med at nå et sted i %h2.",
  PEER_ITEM = "Hjælp %1 med at få fat i %h2.",
  PEER_OTHER = "Hjælp %1 med %h2.",
  
  PEER_NEWER = "%h1 bruger en nyere protokolversion. Måske det er på tide at opgradere.",
  PEER_OLDER = "%h1 bruger en ældre protokolversion.",
  
  UNKNOWN_MESSAGE = "Ukendt beskedtype '%1' fra '%2'.",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "Skjulte Mål",
  HIDDEN_NONE = "Der er ingen mål skjult for dig.",
  DEPENDS_ON_SINGLE = "Afhænger af '%1'.",
  DEPENDS_ON_COUNT = "Afhænger af %1 skjulte mål.",
  DEPENDS_ON = "Afhænger af filtrerede opgaver",
  FILTERED_LEVEL = "Filtreret på grund af level.",
  FILTERED_GROUP = "Filteret på grund af gruppestørrelse.",
  FILTERED_ZONE = "Filtreret på grund af område.",
  FILTERED_COMPLETE = "Filtreret da det er afsluttet.",
  FILTERED_BLOCKED = "Filtreret på grund af forudgående mål der ikke er afsluttet",
  FILTERED_UNWATCHED = "Filtreret da det ikke bliver sporet i quest loggen",
  FILTERED_WINTERGRASP = "Filteret da det er en Wintergrasp PvP quest.",
  FILTERED_RAID = "','kk",
  FILTERED_USER = "Du har anmodet om, at dette mål bliver skjult.",
  FILTERED_UNKNOWN = "Ved ikke hvordan det afsluttes.",
  
  HIDDEN_SHOW = "Vis.",
  HIDDEN_SHOW_NO = "Kan ikke vises",
  HIDDEN_EXCEPTION = "Tilføj undtagelse",
  DISABLE_FILTER = "Slå filter fra: %1",
  FILTER_DONE = "færdig",
  FILTER_ZONE = "område",
  FILTER_LEVEL = "level",
  FILTER_BLOCKED = "blokeret",
  FILTER_WATCHED = "Set",
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = "Kontrol at tilføje denne achievement til QuestHelper.",
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "Du har %h(ny information) til %h1 og %h(opdateret information) til %h2.",
  NAG_SINGLE_NEW = "Du har %h(ny information) om %h1.",
  NAG_ADDITIONAL = "Du har %h(yderligere information) om %h1.",
  NAG_POLLUTED = "Din database er blevet forurenet med information fra en test eller privat server, og vil blive slettet ved opstart.",
  
  NAG_NOT_NEW = "Du har ingen information, som ikke allerede er i den faste database.",
  NAG_NEW = "Du bør overveje, at dele dine data, så andre kan få glæde af dem.",
  NAG_INSTRUCTIONS = "Skriv %h(/qh submit) for at se hvordan du kan indsende data.",
  
  NAG_SINGLE_FP = "en flyveleder",
  NAG_SINGLE_QUEST = "en quest",
  NAG_SINGLE_ROUTE = "en flyverute",
  NAG_SINGLE_ITEM_OBJ = "et genstandsmål",
  NAG_SINGLE_OBJECT_OBJ = "et genstandsmål",
  NAG_SINGLE_MONSTER_OBJ = "et monstermål",
  NAG_SINGLE_EVENT_OBJ = "et begivenhedsmål",
  NAG_SINGLE_REPUTATION_OBJ = "et omdømmemål",
  NAG_SINGLE_PLAYER_OBJ = "et spillermål",
  
  NAG_MULTIPLE_FP = "%1 flyveledere",
  NAG_MULTIPLE_QUEST = "%1 quests",
  NAG_MULTIPLE_ROUTE = "%1 flyveruter",
  NAG_MULTIPLE_ITEM_OBJ = "%1 genstandsmål",
  NAG_MULTIPLE_OBJECT_OBJ = "%1 objektmål",
  NAG_MULTIPLE_MONSTER_OBJ = "%1 monstermål",
  NAG_MULTIPLE_EVENT_OBJ = "%1 begivenhedsmål",
  NAG_MULTIPLE_REPUTATION_OBJ = "%1 omdømmemål",
  NAG_MULTIPLE_PLAYER_OBJ = "%1 spillermål",
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "%1s fremskridt:",
  TRAVEL_ESTIMATE = "Anslået rejsetid:",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "Besøg %h1 på vej til:",
  FLIGHT_POINT = "%1 flight point",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = "Venstreklik: %1 ruteoplysninger.",
  QH_BUTTON_TOOLTIP2 = "Højreklik: Vis Indstillingsmenu.",
  QH_BUTTON_SHOW = "Vis",
  QH_BUTTON_HIDE = "Skjul",

  MENU_CLOSE = "Luk Menu",
  MENU_SETTINGS = "Indstillinger",
  MENU_ENABLE = "Aktiver",
  MENU_DISABLE = "Deaktiver",
  MENU_OBJECTIVE_TIPS = "%1 Mål Tooltips",
  MENU_TRACKER_OPTIONS = "Quest Tracker",
  MENU_QUEST_TRACKER = "%1 Quest Tracker",
  MENU_TRACKER_LEVEL = "%1 Quest Levels",
  MENU_TRACKER_QCOLOUR = "%1 Farver for Sværhedsgrads af Quest",
  MENU_TRACKER_OCOLOUR = "%1 Farver for Opnåelse af Mål",
  MENU_TRACKER_SCALE = "Tracker Skalering",
  MENU_TRACKER_RESET = "Nulstil Placering",
  MENU_FLIGHT_TIMER = "%1 Flyvetid",
  MENU_ANT_TRAILS = "%1 Myrespor",
  MENU_WAYPOINT_ARROW = "%1 Rutepunkt Pil",
  MENU_MAP_BUTTON = "%1 Kortknap",
  MENU_ZONE_FILTER = "%1 Zone Filter",
  MENU_DONE_FILTER = "%1 Færdig Filter",
  MENU_BLOCKED_FILTER = "%1 Blokeret Filter",
  MENU_WATCHED_FILTER = "%1 Overvåget Filter",
  MENU_LEVEL_FILTER = "%1 Level Filter",
  MENU_LEVEL_OFFSET = "Level Filter Offset",
  MENU_ICON_SCALE = "Ikonskalering",
  MENU_FILTERS = "Filtre",
  MENU_PERFORMANCE = "Skaler Rute Beregning",
  MENU_LOCALE = "Sprog",
  MENU_PARTY = "Gruppe",
  MENU_PARTY_SHARE = "%1 Mål Deling",
  MENU_PARTY_SOLO = "%1 Ignorer Gruppe",
  MENU_HELP = "Hjælp",
  MENU_HELP_SLASH = "Kommandoer",
  MENU_HELP_CHANGES = "Ændringer",
  MENU_HELP_SUBMIT = "Sender data",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "Fulgt af QuestHelper",
  TOOLTIP_QUEST = "Til Questen %h1.",
  TOOLTIP_PURCHASE = "Køb %h1.",
  TOOLTIP_SLAY = "Dræb for at få %h1.",
  TOOLTIP_LOOT = "Plyndr for at få %h1.",
  TOOLTIP_OPEN = "Åben fir %h1.",
  
  -- Settings
  SETTINGS_ARROWLINK_ON = "Bruger %h1 til at vise opgaver",
  SETTINGS_ARROWLINK_OFF = "Bruger ikke %h1 til at vise opgaver",
  SETTINGS_ARROWLINK_ARROW = "QuestHelper pil",
  SETTINGS_ARROWLINK_CART = "Cartographer Knudepunkter",
  SETTINGS_ARROWLINK_TOMTOM = "TomTom",
  SETTINGS_PRECACHE_ON = "Precache er slået %h.",
  SETTINGS_PRECACHE_OFF = "Precache er slået %h.",
  
  SETTINGS_MENU_ENABLE = "Sæt til",
  SETTINGS_MENU_DISABLE = "Slå fra",
  SETTINGS_MENU_CARTWP = "%1 Cartographer pil",
  SETTINGS_MENU_TOMTOM = "%1 TomTom pil",
  
  SETTINGS_MENU_ARROW_LOCK = "Lås",
  SETTINGS_MENU_ARROW_ARROWSCALE = "Pil størrelse",
  SETTINGS_MENU_ARROW_TEXTSCALE = "Tekst størrelse",
  SETTINGS_MENU_ARROW_RESET = "Reset",
  
  SETTINGS_MENU_INCOMPLETE = "Ufuldstændig Quests",
  
  SETTINGS_RADAR_ON = "Minimap radar startet! (bip, bip, bip)",
  SETTINGS_RADAR_OFF = "Minimap radar stoppet.",
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "%h1 yards",
  DISTANCE_METRES = "%h1 Meter"
 }

