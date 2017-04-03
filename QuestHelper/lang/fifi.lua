-- Please see enus.lua for reference.

QuestHelper_Translations.fiFI =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "Englanti",
  
  -- Messages used when starting.
  LOCALE_ERROR = nil,
  ZONE_LAYOUT_ERROR = "Questhelperisi on vanhentunut, käy päivittämässä se osoitteessa http://www.quest-helper.com, mikäli haluat sen toimivan. Tämän hetkinen versiosi on %1.",
  HOME_NOT_KNOWN = "Kotisi sijainti ei ole tiedossa. Kun mahdollista, puhu majatalon pitäjälle antaaksesi tiedon.",
  PRIVATE_SERVER = "QuestHelper ei tue yksityispalvelimia",
  PLEASE_RESTART = "virhe käynnistettäessä QuestHelperiä. sulje World of Warcraft ja yritä uudelleen.",
  NOT_UNZIPPED_CORRECTLY = nil,
  PLEASE_SUBMIT = nil,
  HOW_TO_CONFIGURE = "QuestHelperillä ei vielä ole toimivaa asetus sivua, mutta asetuksia voi muuttaa kirjoittamalla %h(/qh settings). Ohjeita saat kirjoittamalla %h(/qh help).",
  TIME_TO_UPDATE = "QuestHelperistä voi olla uusi versio saatavilla (%h(new QuestHelper version). Uudet versiot yleensä sisältävät uusia ominaisuuksia, uusia tehtävä tietokantoja ja bugien korjauksia. Päivitä omasi!",
  
  -- Route related text.
  ROUTES_CHANGED = nil,
  HOME_CHANGED = "kotisi on vaihdettu",
  TALK_TO_FLIGHT_MASTER = "Puhu paikalliselle lento mestarille.",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "kiitos",
  WILL_RESET_PATH = "Nollaa reititys tietoja.",
  UPDATING_ROUTE = "Päivittää reittiä.",
  
  -- Special tracker text
  QH_LOADING = "ladataan QuestHelper (%1%)...",
  QH_FLIGHTPATH = nil,
  QH_RECALCULATING = nil,
  QUESTS_HIDDEN_1 = "tehtäviä piilotettu",
  QUESTS_HIDDEN_2 = "(kirjoita \"/qh hidden\" nähdäksesi kaikki)",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "Valittavat kielet",
  LOCALE_CHANGED = "Kieli vaihdettu: %h1",
  LOCALE_UNKNOWN = "Kieltä %h1 ei tunneta.",
  
  -- Words used for objectives.
  SLAY_VERB = "tapa",
  ACQUIRE_VERB = "poimi",
  
  OBJECTIVE_REASON = nil, -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = nil,
  OBJECTIVE_REASON_TURNIN = nil,
  OBJECTIVE_PURCHASE = nil,
  OBJECTIVE_TALK = "Puhu %h1:lle",
  OBJECTIVE_SLAY = "Tapa %h1.",
  OBJECTIVE_LOOT = "Kerää %h1.",
  OBJECTIVE_OPEN = nil,
  
  OBJECTIVE_MONSTER_UNKNOWN = "tuntematon vihollinen",
  OBJECTIVE_ITEM_UNKNOWN = "tuntematon esine",
  
  ZONE_BORDER_SIMPLE = "%1 raja",
  
  -- Stuff used in objective menus.
  PRIORITY = "tärkeysaste",
  PRIORITY1 = "korkein",
  PRIORITY2 = "korkea",
  PRIORITY3 = "normaali",
  PRIORITY4 = "matala",
  PRIORITY5 = "matalin",
  SHARING = "jakaminen",
  SHARING_ENABLE = "jaa",
  SHARING_DISABLE = "elä jaa",
  IGNORE = "piilota",
  IGNORE_LOCATION = "Piilota tämä sijainti",
  
  IGNORED_PRIORITY_TITLE = "Valittu tärkeysaste piilotettu",
  IGNORED_PRIORITY_FIX = "Käytä samaa prioriteettiä estäviin tehtäviin.",
  IGNORED_PRIORITY_IGNORE = "Määritän tärkeysasteen itse",
  
  -- "/qh find"
  RESULTS_TITLE = "hakutulokset",
  NO_RESULTS = nil,
  CREATED_OBJ = "tee",
  REMOVED_OBJ = nil,
  USER_OBJ = "Käyttäjän tehtävä: %h1",
  UNKNOWN_OBJ = "En tiedä mihin sinun tulisi mennä tuota tehtävää varten.",
  INACCESSIBLE_OBJ = "QuestHelper ei ole löytänyt käyttökelpoista sijaintia %h1lle. Olemme lisänneet luultavasti-mahdoton-löytää sijainnin tehtävä listaasi. Jos löydät toimivan version tästä objectista, ole hyvä ja jaa tietosi! (%h(/qh submit))",
  FIND_REMOVE = nil,
  FIND_NOT_READY = nil,
  FIND_CUSTOM_LOCATION = nil,
  FIND_USAGE = nil,
  
  -- Shared objectives.
  PEER_TURNIN = nil,
  PEER_LOCATION = nil,
  PEER_ITEM = nil,
  PEER_OTHER = nil,
  
  PEER_NEWER = "%h1 käyttää uudempaa versiota. päivitä QuestHelper.",
  PEER_OLDER = "%h1 käyttää vanhempaa versiota.",
  
  UNKNOWN_MESSAGE = "Tuntematon viesti tyyppiä '%1' '%2:sta'",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "Piilotetut tehtävät",
  HIDDEN_NONE = "ei piilotettuja objekteja",
  DEPENDS_ON_SINGLE = "Riippuu '1%'",
  DEPENDS_ON_COUNT = "Riippuu %1:sta piilotetusta tehtävästä",
  DEPENDS_ON = "Riippuu suodatetuista tehtävistä",
  FILTERED_LEVEL = "Suoratettu tason takia.",
  FILTERED_GROUP = "Suodatettu ryhmän koon takia.",
  FILTERED_ZONE = "Suodatettu alueen takia.",
  FILTERED_COMPLETE = "Suodatettu valmiuden takia.",
  FILTERED_BLOCKED = "Suodatettu keskeneräisen aikaisemman tehtävän takia.",
  FILTERED_UNWATCHED = "Suodatettu koska ei ole seurannassa Quest Logissa.",
  FILTERED_WINTERGRASP = "Suodatettu koska tehtävä on Wintergraspin PVP tehtävä.",
  FILTERED_RAID = nil,
  FILTERED_USER = "Pyysit tämän tehtävän piilottamista.",
  FILTERED_UNKNOWN = "Tuntematon",
  
  HIDDEN_SHOW = "näytä",
  HIDDEN_SHOW_NO = "ei näytettävissä",
  HIDDEN_EXCEPTION = "Lisää poikkeus",
  DISABLE_FILTER = "Poista suodin käytöstä",
  FILTER_DONE = "tehty",
  FILTER_ZONE = "alue",
  FILTER_LEVEL = "lvl",
  FILTER_BLOCKED = "estetty",
  FILTER_WATCHED = "seurattu",
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = nil,
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = nil,
  NAG_SINGLE_NEW = nil,
  NAG_ADDITIONAL = nil,
  NAG_POLLUTED = nil,
  
  NAG_NOT_NEW = nil,
  NAG_NEW = nil,
  NAG_INSTRUCTIONS = nil,
  
  NAG_SINGLE_FP = nil,
  NAG_SINGLE_QUEST = "tehtävä",
  NAG_SINGLE_ROUTE = nil,
  NAG_SINGLE_ITEM_OBJ = nil,
  NAG_SINGLE_OBJECT_OBJ = nil,
  NAG_SINGLE_MONSTER_OBJ = nil,
  NAG_SINGLE_EVENT_OBJ = nil,
  NAG_SINGLE_REPUTATION_OBJ = nil,
  NAG_SINGLE_PLAYER_OBJ = nil,
  
  NAG_MULTIPLE_FP = nil,
  NAG_MULTIPLE_QUEST = nil,
  NAG_MULTIPLE_ROUTE = nil,
  NAG_MULTIPLE_ITEM_OBJ = nil,
  NAG_MULTIPLE_OBJECT_OBJ = nil,
  NAG_MULTIPLE_MONSTER_OBJ = nil,
  NAG_MULTIPLE_EVENT_OBJ = nil,
  NAG_MULTIPLE_REPUTATION_OBJ = nil,
  NAG_MULTIPLE_PLAYER_OBJ = nil,
  
  -- Stuff used by dodads.
  PEER_PROGRESS = nil,
  TRAVEL_ESTIMATE = "Arvioitu matkustusaika",
  TRAVEL_ESTIMATE_VALUE = nil,
  WAYPOINT_REASON = "Käy %h1ssa matkalla:",
  FLIGHT_POINT = "%1: lentopiste",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = nil,
  QH_BUTTON_TOOLTIP2 = "hiiren oikea painike: näytä asetukset",
  QH_BUTTON_SHOW = "näytä",
  QH_BUTTON_HIDE = "piilota",

  MENU_CLOSE = "Sulje",
  MENU_SETTINGS = "Asetukset",
  MENU_ENABLE = "Ota Käyttöön",
  MENU_DISABLE = "Poista käytöstä",
  MENU_OBJECTIVE_TIPS = nil,
  MENU_TRACKER_OPTIONS = "Tehtävän seurain",
  MENU_QUEST_TRACKER = "%1 tehtävän seurain",
  MENU_TRACKER_LEVEL = "%1 Tehtävän tasot",
  MENU_TRACKER_QCOLOUR = nil,
  MENU_TRACKER_OCOLOUR = "%1 Keskenäisen tavoitteen värit",
  MENU_TRACKER_SCALE = nil,
  MENU_TRACKER_RESET = nil,
  MENU_FLIGHT_TIMER = "%1 Lentoaika",
  MENU_ANT_TRAILS = "%1 Reittiviivat",
  MENU_WAYPOINT_ARROW = "%1 välietappi nuoli",
  MENU_MAP_BUTTON = "%1 Karttanappi",
  MENU_ZONE_FILTER = "alue suodin",
  MENU_DONE_FILTER = "%1 valmiit suodin",
  MENU_BLOCKED_FILTER = "1% Estetty suodin",
  MENU_WATCHED_FILTER = "1% 'seuratut' suodin",
  MENU_LEVEL_FILTER = "%1 tason suodatus",
  MENU_LEVEL_OFFSET = "Tasosuotimen poikkeama",
  MENU_ICON_SCALE = "Ikonien koko",
  MENU_FILTERS = "Suotimet",
  MENU_PERFORMANCE = "Reitin työmäärän koko",
  MENU_LOCALE = nil,
  MENU_PARTY = "Ryhmä",
  MENU_PARTY_SHARE = "%1 tehtävien jakaminen",
  MENU_PARTY_SOLO = "%1 ryhmän huomiotta jättäminen",
  MENU_HELP = "Apua",
  MENU_HELP_SLASH = "Tekstikomennot",
  MENU_HELP_CHANGES = "Muutosloki",
  MENU_HELP_SUBMIT = "Datan jakaminen",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "QuestHelperin seuraama.",
  TOOLTIP_QUEST = "Tehtävää %h1 varten.",
  TOOLTIP_PURCHASE = "Osta %h1",
  TOOLTIP_SLAY = "tapa %h1:lle",
  TOOLTIP_LOOT = "kerää %h1:ltä",
  TOOLTIP_OPEN = nil,
  
  -- Settings
  SETTINGS_ARROWLINK_ON = nil,
  SETTINGS_ARROWLINK_OFF = nil,
  SETTINGS_ARROWLINK_ARROW = "QuestHelper nuoli",
  SETTINGS_ARROWLINK_CART = nil,
  SETTINGS_ARROWLINK_TOMTOM = "TomTom",
  SETTINGS_PRECACHE_ON = nil,
  SETTINGS_PRECACHE_OFF = nil,
  
  SETTINGS_MENU_ENABLE = "salli",
  SETTINGS_MENU_DISABLE = "estä",
  SETTINGS_MENU_CARTWP = "%1 Cartographerin nuoli",
  SETTINGS_MENU_TOMTOM = nil,
  
  SETTINGS_MENU_ARROW_LOCK = "lukitse",
  SETTINGS_MENU_ARROW_ARROWSCALE = "nuolen koko",
  SETTINGS_MENU_ARROW_TEXTSCALE = "Tekstin koko",
  SETTINGS_MENU_ARROW_RESET = "nollaa",
  
  SETTINGS_MENU_INCOMPLETE = nil,
  
  SETTINGS_RADAR_ON = nil,
  SETTINGS_RADAR_OFF = nil,
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "%h1 jaardia",
  DISTANCE_METRES = "%h1 metriä"
 }

