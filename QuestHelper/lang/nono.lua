-- Please see enus.lua for reference.

QuestHelper_Translations.noNO =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "Norwegian",
  
  -- Messages used when starting.
  LOCALE_ERROR = "Språket i dine lagrede data passer ikke til språket på din WoW klient. For å bruke QuestHelper må du enten skifte språk, eller slette alle data ved å skrive %h(/qh purge)",
  ZONE_LAYOUT_ERROR = "QuestHelper nekter å starte, i frykt for å ødelegge lagret data. Vennligst vent på en oppdatering som støtter den nye sone layouten.",
  HOME_NOT_KNOWN = "Ditt hjem er ikke kjent. Når du har mulighet, prat med en innkeeper og tilbakestill det.",
  PRIVATE_SERVER = "QuestHelper støtter ikke private servere.",
  PLEASE_RESTART = "QuestHelper feilet ved oppstart. Vennligst lukk World of Warcraft helt og prøv igjen.",
  NOT_UNZIPPED_CORRECTLY = "QuestHelper ble installert feil. Vi anbefaler enten Curse Client eller 7zip for installasjon. Sjekk at undermapper er pakket ut.",
  PLEASE_SUBMIT = "(QuestHelper trenger din hjelp!) Om du har et par minutter, vær så venlig å besøk QuestHelper's hjemmeside på h%(http://www.quest-helper.com) og følg instruksjonene der om hvordan du deler den informasjonen du har samlet. Din informasjon gjør at QuestHelper forblir korrekt og oppdatert. Takk!",
  HOW_TO_CONFIGURE = "QuestHelper har ikke noen fungerende innstillinger, men kan konfigureres ved å skrive %h(/qh settings). Hjelp er tilgjengelig med %h(/qh help).",
  TIME_TO_UPDATE = "Det kan være en %h(ny QuestHelper versjon) tilgjengelig. Nye versjoner inkludere som regel nye tillegg, nye quest databaser, og feilrettinger. Vennligst oppdater!",
  
  -- Route related text.
  ROUTES_CHANGED = "Flyverutene for din karakter har blitt endret.",
  HOME_CHANGED = "Ditt hjem(hearthstone) har blitt endret.",
  TALK_TO_FLIGHT_MASTER = "Vennligst prat med den lokale flight masteren.",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "Takk.",
  WILL_RESET_PATH = "Vil nullstille ruteinformasjon.",
  UPDATING_ROUTE = "Oppdaterer rute.",
  
  -- Special tracker text
  QH_LOADING = "QuestHelper starter (%1%%)...",
  QH_FLIGHTPATH = "Gjennberegner flystigene (%1)...",
  QH_RECALCULATING = "Rekalkulerer rute",
  QUESTS_HIDDEN_1 = "Quester kan være skjult",
  QUESTS_HIDDEN_2 = "(\"/qh hidden\" for å liste)",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "Tilgjenelige språk:",
  LOCALE_CHANGED = "Språk endret til: %h1",
  LOCALE_UNKNOWN = "Språket %h1 er ikke kjent.",
  
  -- Words used for objectives.
  SLAY_VERB = "Drep",
  ACQUIRE_VERB = "Anskaffe",
  
  OBJECTIVE_REASON = "%1 %h2 for quest %h3.", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "%h1 for quest %h2.",
  OBJECTIVE_REASON_TURNIN = "Lever inn quest %h1.",
  OBJECTIVE_PURCHASE = "Kjøp fra %h.",
  OBJECTIVE_TALK = "Snakk med %h1.",
  OBJECTIVE_SLAY = "Drep %h1",
  OBJECTIVE_LOOT = "Plukk opp %h.",
  OBJECTIVE_OPEN = nil,
  
  OBJECTIVE_MONSTER_UNKNOWN = "ukjent monster",
  OBJECTIVE_ITEM_UNKNOWN = "ukjent gjennstand",
  
  ZONE_BORDER_SIMPLE = "grense",
  
  -- Stuff used in objective menus.
  PRIORITY = "Prioritet",
  PRIORITY1 = "Høyest",
  PRIORITY2 = "Høy",
  PRIORITY3 = "Normal",
  PRIORITY4 = "Lav",
  PRIORITY5 = "lavest",
  SHARING = "Deling",
  SHARING_ENABLE = "Del",
  SHARING_DISABLE = "Ikke Del",
  IGNORE = "Ignorér",
  IGNORE_LOCATION = "Ignorer dette sted",
  
  IGNORED_PRIORITY_TITLE = "Den valgte prioriteten blir ignorert.",
  IGNORED_PRIORITY_FIX = "Angi samme prioritet til blokkerte objektiver.",
  IGNORED_PRIORITY_IGNORE = "jeg setter prioriteringene selv.",
  
  -- "/qh find"
  RESULTS_TITLE = "Søkeresultater",
  NO_RESULTS = "Det er ingen!",
  CREATED_OBJ = "Laget: %1",
  REMOVED_OBJ = "Fjernet: %1",
  USER_OBJ = "Bruker objektiv: %h1",
  UNKNOWN_OBJ = "Jeg vet ikke hvor du skal dra for det objektivet.",
  INACCESSIBLE_OBJ = "QuestHelper er ute av stand til å finne ett område for %h1. Vi har lagt til ett \"nærmest-umulig-å-finne område til objektivlisten. Hvis du finner et brukbart område for dette, vennligst send dine data! (%h(/qh submit)) ",
  FIND_REMOVE = "Stopp dette objektet",
  FIND_NOT_READY = "Questhelper har ikke fullført å lade. Venligst vent et par minutter og prøv igjen",
  FIND_CUSTOM_LOCATION = "Eget kartsted",
  FIND_USAGE = nil,
  
  -- Shared objectives.
  PEER_TURNIN = "Vent på at %h1 skal levere inn %h2.",
  PEER_LOCATION = "Hjelp %h1 å nå lokasjonen %h2.",
  PEER_ITEM = "Hjelp %1 å skaffe %h2.",
  PEER_OTHER = "Hjelp %1 med !h2.",
  
  PEER_NEWER = "%h1 bruker en nyere protokoll versjon. Du bør oppgradere.",
  PEER_OLDER = "%h1 bruker en eldre protokoll versjon.",
  
  UNKNOWN_MESSAGE = "Ukjent beskjed '%1' fra '%2'.",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "Skjulte Objektiver",
  HIDDEN_NONE = "Det er ingen objektiver som er skjult.",
  DEPENDS_ON_SINGLE = "Kommer an på '%1'.",
  DEPENDS_ON_COUNT = "Kommer an på %1 skjulte oppdrag.",
  DEPENDS_ON = "Avhænger av filtrert mål",
  FILTERED_LEVEL = "Filtrért grunnet level",
  FILTERED_GROUP = "Filtrért grunnet gruppestørrelse.",
  FILTERED_ZONE = "Filtrért grunnet Sone.",
  FILTERED_COMPLETE = "Filtrért grunnet utført quest.",
  FILTERED_BLOCKED = "Filtrért grunnet tidligere uferdige objektiver",
  FILTERED_UNWATCHED = "Filtrért grunnet quest ikke blir fulgt i Oppdragslogg",
  FILTERED_WINTERGRASP = "Filtrért da det er ett PVP Wintergrasp oppdrag.",
  FILTERED_RAID = "Filtrért fordi den ikke kan fullføres i et raid.",
  FILTERED_USER = "Du ba om å gjemme dette objektivet.",
  FILTERED_UNKNOWN = "Vet ikke hvordan det utføres.",
  
  HIDDEN_SHOW = "Vis.",
  HIDDEN_SHOW_NO = "Ikke visbart",
  HIDDEN_EXCEPTION = "Legg på unntak",
  DISABLE_FILTER = "Slå av filter: %1",
  FILTER_DONE = "ferdig",
  FILTER_ZONE = "sone",
  FILTER_LEVEL = "nivå",
  FILTER_BLOCKED = "blokkert",
  FILTER_WATCHED = "følgt",
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = nil,
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "Du har %h(ny informasjon) på %h1, og %h(oppdatert informasjon) på %h2.",
  NAG_SINGLE_NEW = "Du har %h(ny informasjon) på %h.",
  NAG_ADDITIONAL = "Du har %h(mere informasjon) om %h1.",
  NAG_POLLUTED = "Databasen din har blitt forurenset med informasjon fra en test eller privat server, og vil bli renset ved oppstart.",
  
  NAG_NOT_NEW = "Du har ingen informasjon som ikke allerede er i den statiske databasen.",
  NAG_NEW = "Du bør tenke på å dele dine data så andre kan dra nytte av dem.",
  NAG_INSTRUCTIONS = "Skriv %h(/qh submit) for instruksjoner om å sende data.",
  
  NAG_SINGLE_FP = "En flight master",
  NAG_SINGLE_QUEST = "1 quest",
  NAG_SINGLE_ROUTE = "En fly rute",
  NAG_SINGLE_ITEM_OBJ = "en ting oppdrag",
  NAG_SINGLE_OBJECT_OBJ = "et objekt objektiv",
  NAG_SINGLE_MONSTER_OBJ = "Et monster objektiv",
  NAG_SINGLE_EVENT_OBJ = "en hending objektiv",
  NAG_SINGLE_REPUTATION_OBJ = "Et rykte objektiv",
  NAG_SINGLE_PLAYER_OBJ = "Et spiller objektiv",
  
  NAG_MULTIPLE_FP = "%1 flight masters",
  NAG_MULTIPLE_QUEST = "%1 quester",
  NAG_MULTIPLE_ROUTE = "%1 fly rute",
  NAG_MULTIPLE_ITEM_OBJ = "%1 ting oppdrag",
  NAG_MULTIPLE_OBJECT_OBJ = "%1 objekt oppdrag",
  NAG_MULTIPLE_MONSTER_OBJ = "%1 monster oppdrag",
  NAG_MULTIPLE_EVENT_OBJ = "@",
  NAG_MULTIPLE_REPUTATION_OBJ = "%1 rykte objektiv",
  NAG_MULTIPLE_PLAYER_OBJ = "%1 spiller objektiver",
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "%1's framgang:",
  TRAVEL_ESTIMATE = "Estimert flytid:",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "Besøk %h1 på vei til:",
  FLIGHT_POINT = "%1 fly punkt",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = "Venstreklikk: %1 ruteinformasjon.",
  QH_BUTTON_TOOLTIP2 = "Høyreklikk: Vis Innstillinger.",
  QH_BUTTON_SHOW = "Vis",
  QH_BUTTON_HIDE = "Skjul",

  MENU_CLOSE = "Lukk Meny",
  MENU_SETTINGS = "Innstillinger",
  MENU_ENABLE = "Slå På",
  MENU_DISABLE = "Slå Av",
  MENU_OBJECTIVE_TIPS = "%1 Objektivtips",
  MENU_TRACKER_OPTIONS = "Oppdragsfølger",
  MENU_QUEST_TRACKER = "%1 Oppdragsfølger",
  MENU_TRACKER_LEVEL = "%1 Oppragsnivå",
  MENU_TRACKER_QCOLOUR = "%1 Farger for oppdragets vanskelighetsgrad ",
  MENU_TRACKER_OCOLOUR = "%1 Farger for Objektivfremgang",
  MENU_TRACKER_SCALE = "Skala for Oppdragsfølger",
  MENU_TRACKER_RESET = "Tilbakestill Posisjon",
  MENU_FLIGHT_TIMER = "%1 Flytid",
  MENU_ANT_TRAILS = "%1 Maurspor",
  MENU_WAYPOINT_ARROW = "%1 Objektivpil",
  MENU_MAP_BUTTON = "%1 Kartknapp",
  MENU_ZONE_FILTER = "%1 Sone filter",
  MENU_DONE_FILTER = "%1 Utført Filter",
  MENU_BLOCKED_FILTER = "%1 Blokkerte Filter",
  MENU_WATCHED_FILTER = "%1 Overvåket Filter",
  MENU_LEVEL_FILTER = "%1 Nivåfilter",
  MENU_LEVEL_OFFSET = "Nivåfilter Offset",
  MENU_ICON_SCALE = "Ikonskala",
  MENU_FILTERS = "Filtre",
  MENU_PERFORMANCE = "Rutens arbeidsskala",
  MENU_LOCALE = "Språk",
  MENU_PARTY = "Gruppe",
  MENU_PARTY_SHARE = "%1 Objektivdeling",
  MENU_PARTY_SOLO = "%1 Overse Gruppe",
  MENU_HELP = "Hjelp",
  MENU_HELP_SLASH = "Slash kommandoer",
  MENU_HELP_CHANGES = "Endringslogg",
  MENU_HELP_SUBMIT = "Sende Data",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "Overvåket av QuestHelper",
  TOOLTIP_QUEST = "For Quest %h1.",
  TOOLTIP_PURCHASE = "Kjøp %h1.",
  TOOLTIP_SLAY = "Drep for %h1.",
  TOOLTIP_LOOT = "Bytte for %h1.",
  TOOLTIP_OPEN = nil,
  
  -- Settings
  SETTINGS_ARROWLINK_ON = "Bruker %h1 for visning av mål.",
  SETTINGS_ARROWLINK_OFF = "Bruker ikke %h1 for visning av mål.",
  SETTINGS_ARROWLINK_ARROW = "QuestHelper Pil",
  SETTINGS_ARROWLINK_CART = "Cartographer Waypoints",
  SETTINGS_ARROWLINK_TOMTOM = "TomTom",
  SETTINGS_PRECACHE_ON = "Precache er %h(slåt på)",
  SETTINGS_PRECACHE_OFF = "Precache er %h(slåt av)",
  
  SETTINGS_MENU_ENABLE = "Slå på",
  SETTINGS_MENU_DISABLE = "Slå av",
  SETTINGS_MENU_CARTWP = "%1 Cartographer Pil",
  SETTINGS_MENU_TOMTOM = "%1 TomTom Pil",
  
  SETTINGS_MENU_ARROW_LOCK = "Lås",
  SETTINGS_MENU_ARROW_ARROWSCALE = "Pil størrelse",
  SETTINGS_MENU_ARROW_TEXTSCALE = "Tekst størrelse",
  SETTINGS_MENU_ARROW_RESET = "reset",
  
  SETTINGS_MENU_INCOMPLETE = nil,
  
  SETTINGS_RADAR_ON = nil,
  SETTINGS_RADAR_OFF = nil,
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "yards",
  DISTANCE_METRES = "%h1 meter"
 }

