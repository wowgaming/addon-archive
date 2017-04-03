-- Please see enus.lua for reference.

QuestHelper_Translations.roRO =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = nil,
  
  -- Messages used when starting.
  LOCALE_ERROR = nil,
  ZONE_LAYOUT_ERROR = nil,
  HOME_NOT_KNOWN = nil,
  PRIVATE_SERVER = nil,
  PLEASE_RESTART = nil,
  NOT_UNZIPPED_CORRECTLY = nil,
  PLEASE_SUBMIT = nil,
  HOW_TO_CONFIGURE = nil,
  TIME_TO_UPDATE = nil,
  
  -- Route related text.
  ROUTES_CHANGED = nil,
  HOME_CHANGED = nil,
  TALK_TO_FLIGHT_MASTER = nil,
  TALK_TO_FLIGHT_MASTER_COMPLETE = nil,
  WILL_RESET_PATH = nil,
  UPDATING_ROUTE = nil,
  
  -- Special tracker text
  QH_LOADING = nil,
  QH_FLIGHTPATH = nil,
  QH_RECALCULATING = nil,
  QUESTS_HIDDEN_1 = nil,
  QUESTS_HIDDEN_2 = nil,
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = nil,
  LOCALE_CHANGED = nil,
  LOCALE_UNKNOWN = nil,
  
  -- Words used for objectives.
  SLAY_VERB = nil,
  ACQUIRE_VERB = "Luat",
  
  OBJECTIVE_REASON = nil, -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = nil,
  OBJECTIVE_REASON_TURNIN = nil,
  OBJECTIVE_PURCHASE = nil,
  OBJECTIVE_TALK = nil,
  OBJECTIVE_SLAY = nil,
  OBJECTIVE_LOOT = nil,
  OBJECTIVE_OPEN = nil,
  
  OBJECTIVE_MONSTER_UNKNOWN = nil,
  OBJECTIVE_ITEM_UNKNOWN = nil,
  
  ZONE_BORDER_SIMPLE = nil,
  
  -- Stuff used in objective menus.
  PRIORITY = nil,
  PRIORITY1 = nil,
  PRIORITY2 = nil,
  PRIORITY3 = nil,
  PRIORITY4 = nil,
  PRIORITY5 = nil,
  SHARING = nil,
  SHARING_ENABLE = nil,
  SHARING_DISABLE = nil,
  IGNORE = "Ignora",
  IGNORE_LOCATION = nil,
  
  IGNORED_PRIORITY_TITLE = nil,
  IGNORED_PRIORITY_FIX = nil,
  IGNORED_PRIORITY_IGNORE = nil,
  
  -- "/qh find"
  RESULTS_TITLE = nil,
  NO_RESULTS = nil,
  CREATED_OBJ = "Creat",
  REMOVED_OBJ = nil,
  USER_OBJ = nil,
  UNKNOWN_OBJ = nil,
  INACCESSIBLE_OBJ = nil,
  FIND_REMOVE = nil,
  FIND_NOT_READY = nil,
  FIND_CUSTOM_LOCATION = nil,
  FIND_USAGE = nil,
  
  -- Shared objectives.
  PEER_TURNIN = nil,
  PEER_LOCATION = nil,
  PEER_ITEM = nil,
  PEER_OTHER = nil,
  
  PEER_NEWER = nil,
  PEER_OLDER = nil,
  
  UNKNOWN_MESSAGE = nil,
  
  -- Hidden objectives.
  HIDDEN_TITLE = "Obiective ascunse",
  HIDDEN_NONE = "Nu exista obiective ascunse.",
  DEPENDS_ON_SINGLE = "Depinde de '%1'.",
  DEPENDS_ON_COUNT = "Depinde de %1 obiective ascunse.",
  DEPENDS_ON = nil,
  FILTERED_LEVEL = nil,
  FILTERED_GROUP = nil,
  FILTERED_ZONE = nil,
  FILTERED_COMPLETE = nil,
  FILTERED_BLOCKED = nil,
  FILTERED_UNWATCHED = nil,
  FILTERED_WINTERGRASP = nil,
  FILTERED_RAID = nil,
  FILTERED_USER = "Ai cerut ca acest obiectiv sa fie ascuns.",
  FILTERED_UNKNOWN = "Nu stiu cum sa termin.",
  
  HIDDEN_SHOW = "Arata.",
  HIDDEN_SHOW_NO = nil,
  HIDDEN_EXCEPTION = "Adauga exceptie",
  DISABLE_FILTER = "Dezactiveaza filtrul: %1",
  FILTER_DONE = "Terminat",
  FILTER_ZONE = "Zona",
  FILTER_LEVEL = "Nivel",
  FILTER_BLOCKED = "Blocat",
  FILTER_WATCHED = nil,
  
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
  NAG_SINGLE_QUEST = nil,
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
  TRAVEL_ESTIMATE = nil,
  TRAVEL_ESTIMATE_VALUE = nil,
  WAYPOINT_REASON = nil,
  FLIGHT_POINT = nil,

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = nil,
  QH_BUTTON_TOOLTIP1 = nil,
  QH_BUTTON_TOOLTIP2 = nil,
  QH_BUTTON_SHOW = nil,
  QH_BUTTON_HIDE = nil,

  MENU_CLOSE = "Inchide meniul",
  MENU_SETTINGS = "Setari",
  MENU_ENABLE = "Porneste",
  MENU_DISABLE = "Opreste",
  MENU_OBJECTIVE_TIPS = nil,
  MENU_TRACKER_OPTIONS = nil,
  MENU_QUEST_TRACKER = nil,
  MENU_TRACKER_LEVEL = nil,
  MENU_TRACKER_QCOLOUR = nil,
  MENU_TRACKER_OCOLOUR = nil,
  MENU_TRACKER_SCALE = nil,
  MENU_TRACKER_RESET = "Reseteaza pozitia",
  MENU_FLIGHT_TIMER = nil,
  MENU_ANT_TRAILS = nil,
  MENU_WAYPOINT_ARROW = nil,
  MENU_MAP_BUTTON = nil,
  MENU_ZONE_FILTER = nil,
  MENU_DONE_FILTER = nil,
  MENU_BLOCKED_FILTER = "Filtru Blocat",
  MENU_WATCHED_FILTER = nil,
  MENU_LEVEL_FILTER = nil,
  MENU_LEVEL_OFFSET = nil,
  MENU_ICON_SCALE = nil,
  MENU_FILTERS = nil,
  MENU_PERFORMANCE = nil,
  MENU_LOCALE = "Local",
  MENU_PARTY = "Grup",
  MENU_PARTY_SHARE = nil,
  MENU_PARTY_SOLO = nil,
  MENU_HELP = "Ajutor",
  MENU_HELP_SLASH = nil,
  MENU_HELP_CHANGES = nil,
  MENU_HELP_SUBMIT = nil,
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = nil,
  TOOLTIP_QUEST = nil,
  TOOLTIP_PURCHASE = nil,
  TOOLTIP_SLAY = nil,
  TOOLTIP_LOOT = nil,
  TOOLTIP_OPEN = nil,
  
  -- Settings
  SETTINGS_ARROWLINK_ON = nil,
  SETTINGS_ARROWLINK_OFF = nil,
  SETTINGS_ARROWLINK_ARROW = nil,
  SETTINGS_ARROWLINK_CART = nil,
  SETTINGS_ARROWLINK_TOMTOM = nil,
  SETTINGS_PRECACHE_ON = nil,
  SETTINGS_PRECACHE_OFF = nil,
  
  SETTINGS_MENU_ENABLE = nil,
  SETTINGS_MENU_DISABLE = nil,
  SETTINGS_MENU_CARTWP = nil,
  SETTINGS_MENU_TOMTOM = nil,
  
  SETTINGS_MENU_ARROW_LOCK = nil,
  SETTINGS_MENU_ARROW_ARROWSCALE = nil,
  SETTINGS_MENU_ARROW_TEXTSCALE = nil,
  SETTINGS_MENU_ARROW_RESET = nil,
  
  SETTINGS_MENU_INCOMPLETE = nil,
  
  SETTINGS_RADAR_ON = nil,
  SETTINGS_RADAR_OFF = nil,
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = nil,
  DISTANCE_METRES = nil
 }

