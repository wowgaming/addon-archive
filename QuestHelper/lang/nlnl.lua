-- Please see enus.lua for reference.

QuestHelper_Translations.nlNL =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "Nederlands",
  
  -- Messages used when starting.
  LOCALE_ERROR = "De taal van je opgeslagen data komt niet overeen met de taal van je WoW client. Om QuestHelper te gebruiken moet je of de taal herstellen, of de data verwijderen door het volgende te typen: %h(/qh purge).",
  ZONE_LAYOUT_ERROR = "Je gebruikt een oude versie van QuestHelper. Je zult moeten updaten op http://www.questhelp.us om het te blijven gebruiken. Je gebruikt momenteel versie %1.",
  HOME_NOT_KNOWN = "Je thuislocatie is niet bekend. Praat als je de kans krijgt met je innkeeper om hem bekend te maken.",
  PRIVATE_SERVER = "Privéservers worden niet door QuestHelper ondersteund.",
  PLEASE_RESTART = "QuestHelper is niet goed opgestart. Start World of Warcraft opnieuw op en probeer het nogmaals. Als dit probleem blijft bestaan, moet je QuestHelper wellicht opnieuw installeren.",
  NOT_UNZIPPED_CORRECTLY = "QuestHelper is niet goed geinstalleerd. we raden aan om de Curse Client of 7zip te gebruiken voor de installatie. Controleer of de sub-mappen zijn uitgepakt.",
  PLEASE_SUBMIT = "%h(QuestHelper heeft jouw hulp nodig!) Als je even tijd hebt, ga dan naar de QuestHelper website %h(http://www.questhelp.us) en volg de instrcuties om je verzamelde data in te sturen. Jouw data helpt om QuestHelper werkend en up-to-date te houden. Alvast bedankt!",
  HOW_TO_CONFIGURE = "QuestHelper heeft nog geen werkend instellingsvenster, maar kan geconfigureerd worden door %h(/qh settings) te typen. Hulp is beschikbaar via %h(/qh help).",
  TIME_TO_UPDATE = "Er zou een %h(nieuwe QuestHelper versie) beschikbaar kunnen zijn. Nieuwere versies hebben meestal nieuwe opties, nieuwe questdatabases en bugfixes. Update alsjeblieft!",
  
  -- Route related text.
  ROUTES_CHANGED = "De vliegroutes van je karakter zijn veranderd.",
  HOME_CHANGED = "Je thuislocatie is veranderd.",
  TALK_TO_FLIGHT_MASTER = "Praat alsjeblieft met de plaatselijke flightmaster.",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "Bedankt.",
  WILL_RESET_PATH = "Routes worden opnieuw ingesteld.",
  UPDATING_ROUTE = "Route wordt ververst.",
  
  -- Special tracker text
  QH_LOADING = "QuestHelper wordt geladen (%1%)...",
  QH_FLIGHTPATH = "Vliegpaden herberekenen (%1%)...",
  QH_RECALCULATING = "Route herberekenen (%1%)...",
  QUESTS_HIDDEN_1 = "Wellicht zijn er quests verborgen",
  QUESTS_HIDDEN_2 = "(rechtermuisknop om te tonen)",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "Beschikbare Talen:",
  LOCALE_CHANGED = "Taal veranderd in: %h1",
  LOCALE_UNKNOWN = "De taal %h1 is onbekend.",
  
  -- Words used for objectives.
  SLAY_VERB = "Dood",
  ACQUIRE_VERB = "Verwerven",
  
  OBJECTIVE_REASON = "%1 %h2 for quest %h3.", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "%h1 for quest %h2.",
  OBJECTIVE_REASON_TURNIN = "Lever quest %h1 in.",
  OBJECTIVE_PURCHASE = "Koop van %h1.",
  OBJECTIVE_TALK = "Praat met %h1.",
  OBJECTIVE_SLAY = "Dood %h1.",
  OBJECTIVE_LOOT = "Loot %h1.",
  OBJECTIVE_OPEN = "Open %h1.",
  
  OBJECTIVE_MONSTER_UNKNOWN = "onbekend monster",
  OBJECTIVE_ITEM_UNKNOWN = "onbekend voorwerp",
  
  ZONE_BORDER_SIMPLE = "de grens van %1",
  
  -- Stuff used in objective menus.
  PRIORITY = "Prioriteit",
  PRIORITY1 = "Hoogste",
  PRIORITY2 = "Hoog",
  PRIORITY3 = "Normaal",
  PRIORITY4 = "Laag",
  PRIORITY5 = "Laagste",
  SHARING = "Delen",
  SHARING_ENABLE = "Deel",
  SHARING_DISABLE = "Niet delen",
  IGNORE = "Negeer",
  IGNORE_LOCATION = "Negeer deze locatie",
  
  IGNORED_PRIORITY_TITLE = "De geselecteerde prioriteit zou worden genegeerd.",
  IGNORED_PRIORITY_FIX = "Apply same priority to the blocking objectives.",
  IGNORED_PRIORITY_IGNORE = "Ik stel zelf de prioriteiten in.",
  
  -- "/qh find"
  RESULTS_TITLE = "Zoekresultaten",
  NO_RESULTS = "Geen resultaten!",
  CREATED_OBJ = "Aangemaakt: %1",
  REMOVED_OBJ = "Verwijderd: %1",
  USER_OBJ = "Eigen Doel: %h1",
  UNKNOWN_OBJ = "Geen idee waar je dat doel kunt vinden.",
  INACCESSIBLE_OBJ = "QuestHelper heeft geen bruikbare locatie gevonden voor %h1. We hebben een zo-goed-als-onmogelijk-te-vinden locatie aan de doelenlijst toegevoegd. Als je een bruikbare versie van dit object vind, deel dan je data! (%h( /qh submit))",
  FIND_REMOVE = "Annuleer doel",
  FIND_NOT_READY = "QuestHelper is nog niet klaar met laden. Wacht een minuut en probeer het nogmaals.",
  FIND_CUSTOM_LOCATION = "Eigen locatie",
  FIND_USAGE = "Vind werkt niet indien je het niet vertelt wat het moet vinden. Probeer %h (/qh help) voor instructies.",
  
  -- Shared objectives.
  PEER_TURNIN = "Wacht op %h1 om %h2 in te leveren.",
  PEER_LOCATION = "Help %h1 reach a location in %h2.",
  PEER_ITEM = "Help %1 om %h2 te verkrijgen.",
  PEER_OTHER = "Help %1 met %h2.",
  
  PEER_NEWER = "%h1 gebruikt een niewere versie van het protocol. Het is misschien tijd om te upgraden.",
  PEER_OLDER = "%h1 gebruikt een oudere versie van het protocol.",
  
  UNKNOWN_MESSAGE = "Unknown message type '%1' from '%2'.",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "Verborgen Doelen",
  HIDDEN_NONE = "Er zijn geen doelen voor je verborgen",
  DEPENDS_ON_SINGLE = "Is afhankelijk van '%1'",
  DEPENDS_ON_COUNT = "Is afhankelijk van %1 verborgen doelen",
  DEPENDS_ON = "Is afhankelijk van gefilterde doelen",
  FILTERED_LEVEL = "Gefilterd vanwege level",
  FILTERED_GROUP = "Gefilterd vanwege grootte van groep",
  FILTERED_ZONE = "Gefilterd vanwege zone",
  FILTERED_COMPLETE = "Gefilterd omdat het al is voltooid",
  FILTERED_BLOCKED = "Gefilterd vanwege een onvoltooid vereisd doel",
  FILTERED_UNWATCHED = "Gefilterd omdat het niet gevolgd wordt in de Quest Log",
  FILTERED_WINTERGRASP = "Gefilterd omdat het een PvP Wintergrasp quest is",
  FILTERED_RAID = "Gefilterd omdat het niet voltooid kan worden in een raid",
  FILTERED_USER = "Je hebt dit doel verborgen",
  FILTERED_UNKNOWN = "Geen idee hoe dit te voltooien",
  
  HIDDEN_SHOW = "Toon",
  HIDDEN_SHOW_NO = "Niet toonbaar",
  HIDDEN_EXCEPTION = "Voeg uitzondering toe",
  DISABLE_FILTER = "Filter uitzetten: %1",
  FILTER_DONE = "voltooid",
  FILTER_ZONE = "zone",
  FILTER_LEVEL = "level",
  FILTER_BLOCKED = "geblokkeerd",
  FILTER_WATCHED = "volg",
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = "Vink aan om deze achievement aan Questhelper toe te voegen.",
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "Je hebt %h(new information) over %h1, en %h(updated information) over %h2.",
  NAG_SINGLE_NEW = "Je hebt %h(new information) over %h1.",
  NAG_ADDITIONAL = "Je hebt %h op %h1.",
  NAG_POLLUTED = "Je database is vervuild met informatie van een test of privéserver en wordt geleegd bij het opstarten.",
  
  NAG_NOT_NEW = "Je hebt geen nieuwe informatie voor de database.",
  NAG_NEW = "Misschien wil je je informatie delen zodat anderen er van kunnen profiteren.",
  NAG_INSTRUCTIONS = "Type %h(/qh submit) voor instructies over het insturen van data.",
  
  NAG_SINGLE_FP = "een flightmaster",
  NAG_SINGLE_QUEST = "een quest",
  NAG_SINGLE_ROUTE = "een vliegroute",
  NAG_SINGLE_ITEM_OBJ = "een voorwerp doel",
  NAG_SINGLE_OBJECT_OBJ = "een object doel",
  NAG_SINGLE_MONSTER_OBJ = "een monster doel",
  NAG_SINGLE_EVENT_OBJ = "een gebeurtenis doel",
  NAG_SINGLE_REPUTATION_OBJ = "een reputatie doel",
  NAG_SINGLE_PLAYER_OBJ = "een speler doel",
  
  NAG_MULTIPLE_FP = "%1 flightmasters",
  NAG_MULTIPLE_QUEST = "%1 quests",
  NAG_MULTIPLE_ROUTE = "%1 vlieg routes",
  NAG_MULTIPLE_ITEM_OBJ = "%1 voorwerp doelen",
  NAG_MULTIPLE_OBJECT_OBJ = "%1 object doelen",
  NAG_MULTIPLE_MONSTER_OBJ = "%1 monster doelen",
  NAG_MULTIPLE_EVENT_OBJ = "%1 gebeurtenis doelen",
  NAG_MULTIPLE_REPUTATION_OBJ = "%1 reputatie doelen",
  NAG_MULTIPLE_PLAYER_OBJ = "%1 speler doelen",
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "%1's voortgang:",
  TRAVEL_ESTIMATE = "Geschatte reistijd:",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "Bezoek %h1 onderweg naar:",
  FLIGHT_POINT = "%1 flightpoint",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = "Linkermuisknop: %1 route informatie.",
  QH_BUTTON_TOOLTIP2 = "Rechtermuisknop: Toon Instellingen.",
  QH_BUTTON_SHOW = "Toon",
  QH_BUTTON_HIDE = "Verberg",

  MENU_CLOSE = "Sluit Menu",
  MENU_SETTINGS = "Instellingen",
  MENU_ENABLE = "Activeer",
  MENU_DISABLE = "Deactiveer",
  MENU_OBJECTIVE_TIPS = "%1 Doel Tooltips",
  MENU_TRACKER_OPTIONS = "Quest Tracker",
  MENU_QUEST_TRACKER = "%1 Quest Tracker",
  MENU_TRACKER_LEVEL = "%1 Quest Levels",
  MENU_TRACKER_QCOLOUR = "%1 Kleur: Quest Moeilijkheid",
  MENU_TRACKER_OCOLOUR = "%1 Kleur: Doel Voortgang",
  MENU_TRACKER_SCALE = "Tracker Grootte",
  MENU_TRACKER_RESET = "Herstel Positie",
  MENU_FLIGHT_TIMER = "%1 Vluchttijd",
  MENU_ANT_TRAILS = "%1 Ant Trails",
  MENU_WAYPOINT_ARROW = "%1 Wegwijzer Pijl",
  MENU_MAP_BUTTON = "%1 Kaart Knop",
  MENU_ZONE_FILTER = "%1 Zone Filter",
  MENU_DONE_FILTER = "%1 Voltooid Filter",
  MENU_BLOCKED_FILTER = "%1 Geblokkeerde Filter",
  MENU_WATCHED_FILTER = "%1 Volg Filter",
  MENU_LEVEL_FILTER = "%1 Level Filter",
  MENU_LEVEL_OFFSET = "Level Filter Delta",
  MENU_ICON_SCALE = "Icoon Grootte",
  MENU_FILTERS = "Filters",
  MENU_PERFORMANCE = "Werkdruk van Route",
  MENU_LOCALE = "Taal",
  MENU_PARTY = "Groep",
  MENU_PARTY_SHARE = "%1 Doelen Delen",
  MENU_PARTY_SOLO = "%1 Negeer Groep",
  MENU_HELP = "Help",
  MENU_HELP_SLASH = "Slash Commands",
  MENU_HELP_CHANGES = "Wijzigingen Log",
  MENU_HELP_SUBMIT = "Opsturen van Data",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "Gevolgt door QuestHelper",
  TOOLTIP_QUEST = "Voor Quest %h1.",
  TOOLTIP_PURCHASE = "Koop %h1.",
  TOOLTIP_SLAY = "Dood voor %h1.",
  TOOLTIP_LOOT = "Loot voor %h1.",
  TOOLTIP_OPEN = "Open voor %h1.",
  
  -- Settings
  SETTINGS_ARROWLINK_ON = "%h1 zal gebruikt worden om doelen aan te geven.",
  SETTINGS_ARROWLINK_OFF = "%h1 zal niet gebruikt worden om doelen aan te geven.",
  SETTINGS_ARROWLINK_ARROW = "QuestHelper Pijl",
  SETTINGS_ARROWLINK_CART = "Cartographer Waypoints",
  SETTINGS_ARROWLINK_TOMTOM = "TomTom",
  SETTINGS_PRECACHE_ON = "Precache is %h(enabled).",
  SETTINGS_PRECACHE_OFF = "Precache is %h(disabled).",
  
  SETTINGS_MENU_ENABLE = "Aanzetten",
  SETTINGS_MENU_DISABLE = "Uitzetten",
  SETTINGS_MENU_CARTWP = "%1 Cartographer Pijl",
  SETTINGS_MENU_TOMTOM = "%1 TomTom Pijl",
  
  SETTINGS_MENU_ARROW_LOCK = "Vastzetten",
  SETTINGS_MENU_ARROW_ARROWSCALE = "Pijl Grootte",
  SETTINGS_MENU_ARROW_TEXTSCALE = "Tekst Grootte",
  SETTINGS_MENU_ARROW_RESET = "Herstel",
  
  SETTINGS_MENU_INCOMPLETE = "Onvoltooide Quests",
  
  SETTINGS_RADAR_ON = "Minimap radar is druk bezig! (biep, biep, biep)",
  SETTINGS_RADAR_OFF = "Minimap radar is niet druk bezig. (whirrrrr, plof)",
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "%h1 yards",
  DISTANCE_METRES = "%h1 meters"
 }

