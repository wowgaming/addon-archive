-- Please see enus.lua for reference.

QuestHelper_Translations.svSE =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "Svenska",
  
  -- Messages used when starting.
  LOCALE_ERROR = "Språket för dina sparade data matchar inte språket för din WoW klient. För att använda QuestHelper, måste du antingen ändra tillbaka språket, eller radera datan genom att skriva %h(/qh purge).",
  ZONE_LAYOUT_ERROR = "Din version av QuestHelper är utgången och du behöver uppdatera på http://www.quest-helper.com för att den ska fortsätta fungera. Din nuvarende version är %1.",
  HOME_NOT_KNOWN = "Ditt hem är okänt. När du får chansen, prata med din innkeeper för att nollställa det.",
  PRIVATE_SERVER = "QuestHelper stödjer inte privata servrar.",
  PLEASE_RESTART = "Det uppstod ett fel vid start av QuestHelper. Vänligen avsluta World of Warcraft helt och försök igen.",
  NOT_UNZIPPED_CORRECTLY = "QuestHelper blev felaktigt installerat. Vi rekomenderar att du antingen använder Curse Client eller 7zip för att installera. Säkerställ att underkataloger blir extraherade.",
  PLEASE_SUBMIT = "%h(QuestHelper behöver din hjälp!) Om du har ett par minuter, besök gärna QuestHelper's hemsida på %h(http://www.questhelp.us) och följ instruktionerna för att lämna in din insamlade data. Din insamlade data håller QuestHelper uppdaterad. Tack!",
  HOW_TO_CONFIGURE = "QuestHelper har ingen fungerande inställningssida, men kan konfigureras genom att skriva %h(/qh settings). Hjälp är tillgänglig med %h(/qh help).",
  TIME_TO_UPDATE = "Det kan finnas en ny version av %h(ny QuestHelper-version). Nya versionen inkluderar oftast nya funktioner, databaser och buggfixar. Uppdatera nu!",
  
  -- Route related text.
  ROUTES_CHANGED = "Flygvägen för din karaktär har ändrats",
  HOME_CHANGED = "Ditt hem har ändrats.",
  TALK_TO_FLIGHT_MASTER = "Var vänlig prata med den lokala flygmästaren.",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "Tack.",
  WILL_RESET_PATH = "Kommer återställa vägvisnings-information",
  UPDATING_ROUTE = "Uppdaterar väg.",
  
  -- Special tracker text
  QH_LOADING = "QuestHelper laddas (%1%)...",
  QH_FLIGHTPATH = "Räknar om flygplatserna",
  QH_RECALCULATING = "Omräknar rutt (%1%) ...",
  QUESTS_HIDDEN_1 = "Uppdrag är kanske gömda",
  QUESTS_HIDDEN_2 = "(högerklicka för lista)",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "Tillgängliga språk:",
  LOCALE_CHANGED = "Språk ändrat till: %h1",
  LOCALE_UNKNOWN = "Språket %h1 är okänt",
  
  -- Words used for objectives.
  SLAY_VERB = "Döda",
  ACQUIRE_VERB = "Få tag på",
  
  OBJECTIVE_REASON = "%1 %h2 för uppdraget %h3.", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "%h1 för uppdraget %h2.",
  OBJECTIVE_REASON_TURNIN = "Lämna in uppdraget %h1.",
  OBJECTIVE_PURCHASE = "Köp från %h1.",
  OBJECTIVE_TALK = "Prata med %h1.",
  OBJECTIVE_SLAY = "Döda %h1.",
  OBJECTIVE_LOOT = "Samla %h1",
  OBJECTIVE_OPEN = "Öppna",
  
  OBJECTIVE_MONSTER_UNKNOWN = "Okänt monster",
  OBJECTIVE_ITEM_UNKNOWN = "Okänt objekt",
  
  ZONE_BORDER_SIMPLE = "%1 gräns",
  
  -- Stuff used in objective menus.
  PRIORITY = "Prioritet",
  PRIORITY1 = "Högsta",
  PRIORITY2 = "Hög",
  PRIORITY3 = "Normal",
  PRIORITY4 = "Låg",
  PRIORITY5 = "Lägsta",
  SHARING = "Dela",
  SHARING_ENABLE = "Dela",
  SHARING_DISABLE = "Dela inte",
  IGNORE = "Ignorera",
  IGNORE_LOCATION = "Ignonera denna plats",
  
  IGNORED_PRIORITY_TITLE = "Den valda prioriteten skulle ignoreras.",
  IGNORED_PRIORITY_FIX = "Godkänn samma prioritet till det blockerade uppdraget.",
  IGNORED_PRIORITY_IGNORE = "Jag sätter prioriteterna själv.",
  
  -- "/qh find"
  RESULTS_TITLE = "Sök resultat",
  NO_RESULTS = "Det finns inga!",
  CREATED_OBJ = "Skapad: %1",
  REMOVED_OBJ = "Borttagen: %1",
  USER_OBJ = "Användar-uppdrag %1",
  UNKNOWN_OBJ = "Jag vet inte vart jag ska gå för det uppdraget.",
  INACCESSIBLE_OBJ = "QuestHelper har inte lyckats hitta en användbar plats för %h1. Vi har lagt till en troligtvis-omöjlig-att-hitta plats i din uppdrags-lista. Om du hittar en användbar version av detta uppdrag, vänligen dela med dig! (%h(/qh submit))",
  FIND_REMOVE = "Avbryt mål",
  FIND_NOT_READY = "QuestHelper har inte laddat klat än. Var god vänta en minut och försök igen.",
  FIND_CUSTOM_LOCATION = "Anpassad kartplats",
  FIND_USAGE = "Hitta fungerar inte om du inte specificerar vad som ska hittas. Tryck %h (/qh help) för instruktioner.",
  
  -- Shared objectives.
  PEER_TURNIN = "Vänta på att %h1 ska lämna in %h2.",
  PEER_LOCATION = "Hjälp %h1 nå en plats i %h2.",
  PEER_ITEM = "Hjälp %1 få tag på %h2.",
  PEER_OTHER = "Hjälp %1 med %h2.",
  
  PEER_NEWER = "%h1 använder en nyare version av protokollet. Det är kanske tid att uppgradera",
  PEER_OLDER = "%h1 använder en äldre version av protokollet.",
  
  UNKNOWN_MESSAGE = "Okänt meddelande av typen '%1' från '%2'",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "Gömda Uppdrag",
  HIDDEN_NONE = "Inga uppdrag är gömda för dig",
  DEPENDS_ON_SINGLE = "Beroende av '%1'",
  DEPENDS_ON_COUNT = "Beroende av %1 gömda uppdrag",
  DEPENDS_ON = "Beror på filtrerade objekt",
  FILTERED_LEVEL = "Filtrerad på grund av nivå.",
  FILTERED_GROUP = "Filtrerad på grund av grupp storlek",
  FILTERED_ZONE = "Filtrerad på grund av zon",
  FILTERED_COMPLETE = "Filtrerad på grund av fullgjort",
  FILTERED_BLOCKED = "Filtrerad på grund av att föregående uppdrag inte är klart",
  FILTERED_UNWATCHED = "Filtreras på grund av att den inte följs i uppdrags-loggen",
  FILTERED_WINTERGRASP = "Filtrerad på grund av att det är ett PvP Wintergrasp uppdrag",
  FILTERED_RAID = "Filtrerad på grund av du inte är kompitabel i raid.",
  FILTERED_USER = "Du har begärt att detta uppdrag ska vara gömt",
  FILTERED_UNKNOWN = "Vet inte hur man klarar av",
  
  HIDDEN_SHOW = "Visa",
  HIDDEN_SHOW_NO = "Ej visningsbar",
  HIDDEN_EXCEPTION = "Lägg till undantag",
  DISABLE_FILTER = "Inaktivera filter: %1",
  FILTER_DONE = "avklarad",
  FILTER_ZONE = "zon",
  FILTER_LEVEL = "nivå",
  FILTER_BLOCKED = "blockerad",
  FILTER_WATCHED = "bevakad",
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = "Kryssa i för att lägga till denna milstolpen till QuestHelper",
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "Du har %h(ny information) på %h1, och %h(uppdaterad information) på %h2.",
  NAG_SINGLE_NEW = "Du har (ny information) om",
  NAG_ADDITIONAL = "Du har (information) om",
  NAG_POLLUTED = "Din databas har blivit nedskräpad med information från en test- eller privat server, och kommer rensas vid uppstart.",
  
  NAG_NOT_NEW = "Du har ingen information som inte redan finns i static databasen",
  NAG_NEW = "Du ska kanske dela med av dina data så andra kan ha nytta av dom",
  NAG_INSTRUCTIONS = "Skriv (/qh submit) för instruktioner om hur du sänder data",
  
  NAG_SINGLE_FP = "en flygmästare",
  NAG_SINGLE_QUEST = "ett uppdrag",
  NAG_SINGLE_ROUTE = "en flyg väg",
  NAG_SINGLE_ITEM_OBJ = "ett sak-uppdrag",
  NAG_SINGLE_OBJECT_OBJ = "ett objekts-uppdrag",
  NAG_SINGLE_MONSTER_OBJ = "ett monster-uppdrag",
  NAG_SINGLE_EVENT_OBJ = "ett händelse-uppdrag",
  NAG_SINGLE_REPUTATION_OBJ = "ett anseende-uppdrag",
  NAG_SINGLE_PLAYER_OBJ = "ett spelar-uppdrag",
  
  NAG_MULTIPLE_FP = "%1 flygmästare",
  NAG_MULTIPLE_QUEST = "Uppdrag",
  NAG_MULTIPLE_ROUTE = "Flyg vägar",
  NAG_MULTIPLE_ITEM_OBJ = "%1 sak-uppdrag",
  NAG_MULTIPLE_OBJECT_OBJ = "%1 objekt-uppdrag",
  NAG_MULTIPLE_MONSTER_OBJ = "%1 monster-uppdrag",
  NAG_MULTIPLE_EVENT_OBJ = "%1 händelse uppdrag",
  NAG_MULTIPLE_REPUTATION_OBJ = "%1 anseende-uppdrag",
  NAG_MULTIPLE_PLAYER_OBJ = "%1 spelar-uppdrag",
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "%1's framsteg:",
  TRAVEL_ESTIMATE = "Beräknad restid:",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "Besök %h1 på väg till:",
  FLIGHT_POINT = "Flygplats",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = "Vänster-klicka: %1 rutt-information",
  QH_BUTTON_TOOLTIP2 = "Höger-klicka: Visa menyn Inställningar.",
  QH_BUTTON_SHOW = "Visa",
  QH_BUTTON_HIDE = "Dölj",

  MENU_CLOSE = "Stäng Meny",
  MENU_SETTINGS = "Inställningar",
  MENU_ENABLE = "Aktivera",
  MENU_DISABLE = "Avaktivera",
  MENU_OBJECTIVE_TIPS = "Uppdrag tips",
  MENU_TRACKER_OPTIONS = "Uppdrags sökare",
  MENU_QUEST_TRACKER = "Uppdrags sökare",
  MENU_TRACKER_LEVEL = "%1 Uppdragsnivåer",
  MENU_TRACKER_QCOLOUR = "Uppdrags svårighets färger",
  MENU_TRACKER_OCOLOUR = "%1 Uppdrags framstegs-färger",
  MENU_TRACKER_SCALE = "Spårarens skala",
  MENU_TRACKER_RESET = "Återställ position",
  MENU_FLIGHT_TIMER = "%1 Flygtimer",
  MENU_ANT_TRAILS = "%1 Myr Spår",
  MENU_WAYPOINT_ARROW = "%1 Vägmärkes-pil",
  MENU_MAP_BUTTON = "Kartknapp",
  MENU_ZONE_FILTER = "Områdes filter",
  MENU_DONE_FILTER = "%1 Filtret Färdigt",
  MENU_BLOCKED_FILTER = "%1 Blockerat Filter",
  MENU_WATCHED_FILTER = "%1 Övervaknings-filter",
  MENU_LEVEL_FILTER = "%1 Nivå Filter",
  MENU_LEVEL_OFFSET = "Nivå Filter Offset",
  MENU_ICON_SCALE = "Ikon skala",
  MENU_FILTERS = "Filter",
  MENU_PERFORMANCE = "Ändra arbetsbördans skala",
  MENU_LOCALE = "Språk",
  MENU_PARTY = "Grupp",
  MENU_PARTY_SHARE = "Dela Uppdrag",
  MENU_PARTY_SOLO = "%1 Ignorera grupp",
  MENU_HELP = "Hjälp",
  MENU_HELP_SLASH = "Slash-kommandon",
  MENU_HELP_CHANGES = "Ändringslista",
  MENU_HELP_SUBMIT = "Skicka data",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "Övervakad av Questhelper",
  TOOLTIP_QUEST = "För uppdraget %h1.",
  TOOLTIP_PURCHASE = "Köp %h1.",
  TOOLTIP_SLAY = "Döda för %h1.",
  TOOLTIP_LOOT = "Plocka för %h1.",
  TOOLTIP_OPEN = "Öppna för",
  
  -- Settings
  SETTINGS_ARROWLINK_ON = "Kommer använda %h1 för att visa objektiv",
  SETTINGS_ARROWLINK_OFF = "Kommer inte använda %h1 för att visa objektiv",
  SETTINGS_ARROWLINK_ARROW = "QuestHelper Pil",
  SETTINGS_ARROWLINK_CART = "Cartographer checkpoint",
  SETTINGS_ARROWLINK_TOMTOM = "TomTom Go",
  SETTINGS_PRECACHE_ON = "Precache minne har blivit %h aktiverad",
  SETTINGS_PRECACHE_OFF = "Precache minne har blivit %h avstängd",
  
  SETTINGS_MENU_ENABLE = "Aktivera",
  SETTINGS_MENU_DISABLE = "Avaktivera",
  SETTINGS_MENU_CARTWP = "%1 Cartographer pil",
  SETTINGS_MENU_TOMTOM = "%1 TomTom Arrow",
  
  SETTINGS_MENU_ARROW_LOCK = "Lås",
  SETTINGS_MENU_ARROW_ARROWSCALE = "Storlek på pil",
  SETTINGS_MENU_ARROW_TEXTSCALE = "Storlek på text",
  SETTINGS_MENU_ARROW_RESET = "Återställ",
  
  SETTINGS_MENU_INCOMPLETE = "Oklarade Uppdrag",
  
  SETTINGS_RADAR_ON = "Minikartans radar bunden! (beep, beep, beep)",
  SETTINGS_RADAR_OFF = "Minikartans radar obunden. (whirrrrr, clunk)",
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "%h1 yards",
  DISTANCE_METRES = "%h1 meter"
 }

