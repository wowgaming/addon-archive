-- Please see enus.lua for reference.

QuestHelper_Translations.deDE =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "Deutsch",
  
  -- Messages used when starting.
  LOCALE_ERROR = "Die Sprache deiner gespeicherten Daten stimmt nicht mit der Sprache deines WoW-Clients überein. Du musst die Sprache umstellen oder die Daten mit %h(/qh purge) löschen, um QuestHelper zu verwenden.",
  ZONE_LAYOUT_ERROR = "Das Addon wird nicht ausgeführt, um deine gespeicherten Daten nicht zu beschädigen. Warte auf einen Patch, der in der Lage ist, das neue Zonenlayout zu verarbeiten!",
  HOME_NOT_KNOWN = "Dein Heimatort ist nicht bekannt. Sprich bei der nächsten Gelegenheit mit einem Gastwirt, um ihn neu zu setzen.",
  PRIVATE_SERVER = "QuestHelper unterstützt keine privaten Server.",
  PLEASE_RESTART = "Beim Starten von QuestHelper ist ein Fehler aufgetreten. Beende World of Warcraft vollständig und versuche es erneut.",
  NOT_UNZIPPED_CORRECTLY = "QuestHelper wurde nicht ordnungsgemäß installiert. Wir empfehlen den Curse-Client oder 7zip für die Installation. Achte darauf, dass Unterverzeichnisse entpackt werden.",
  PLEASE_SUBMIT = "%h(QuestHelper braucht deine Unterstützung!) Wenn du ein paar Minuten Zeit hast, ruf die QuestHelper-Homepage %h(http://www.questhelp.us) auf und führe die Anweisungen aus, um deine gesammelten Daten zu übermitteln. Deine Daten halten QuestHelper auf dem aktuellen Stand. Vielen Dank!",
  HOW_TO_CONFIGURE = "QuestHelper hat noch keine funktionierende Einstellungsseite. Du kannst es konfigurieren, indem du %h(/qh settings) eingibst. Mit %h(/qh help) rufst du die Hilfe auf.",
  TIME_TO_UPDATE = "Möglicherweise ist eine %h(neue QuestHelper-Version) verfügbar. Neue Versionen umfassen gewöhnlich neue Funktionen, neue Questdatenbanken und Bugfixes. Du solltest ein Update durchführen!",
  
  -- Route related text.
  ROUTES_CHANGED = "Die Flugstrecken für deinen Charakter wurden verändert.",
  HOME_CHANGED = "Dein Heimatort wurde geändert.",
  TALK_TO_FLIGHT_MASTER = "Sprich mit dem örtlichen Flugmeister.",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "Danke.",
  WILL_RESET_PATH = "Informationen zur Wegfindung werden zurückgesetzt.",
  UPDATING_ROUTE = "Strecke wird neu berechnet.",
  
  -- Special tracker text
  QH_LOADING = "QuestHelper wird geladen... (%1%)",
  QH_FLIGHTPATH = "Flugstrecken werden neu berechnet... (%1%)",
  QH_RECALCULATING = "Route wird neu berechnet (%1)",
  QUESTS_HIDDEN_1 = "Quests sind vielleicht ausgeblendet.",
  QUESTS_HIDDEN_2 = "(Rechtsklick zum Auflisten)",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "Verfügbare Sprachen:",
  LOCALE_CHANGED = "Sprache geändert in: %h1",
  LOCALE_UNKNOWN = "Die Sprache %h1 ist nicht bekannt.",
  
  -- Words used for objectives.
  SLAY_VERB = "Töte",
  ACQUIRE_VERB = "Erbeute",
  
  OBJECTIVE_REASON = "%1 %h2 für die Quest %h3.", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "%h1 für die Quest %h2.",
  OBJECTIVE_REASON_TURNIN = "Gib die Quest %h1 ab.",
  OBJECTIVE_PURCHASE = "Kaufen von %h1.",
  OBJECTIVE_TALK = "Sprich mit %h1.",
  OBJECTIVE_SLAY = "Töte %h1.",
  OBJECTIVE_LOOT = "Erbeute %h1.",
  OBJECTIVE_OPEN = "Öffne %h1.",
  
  OBJECTIVE_MONSTER_UNKNOWN = "unbekanntes Monster",
  OBJECTIVE_ITEM_UNKNOWN = "unbekanntes Objekt",
  
  ZONE_BORDER_SIMPLE = "Grenze %1",
  
  -- Stuff used in objective menus.
  PRIORITY = "Priorität",
  PRIORITY1 = "Am höchsten",
  PRIORITY2 = "Hoch",
  PRIORITY3 = "Normal",
  PRIORITY4 = "Niedrig",
  PRIORITY5 = "Am niedrigsten",
  SHARING = "Teilen",
  SHARING_ENABLE = "Teilen",
  SHARING_DISABLE = "Nicht teilen",
  IGNORE = "Ignorieren",
  IGNORE_LOCATION = "Diesen Ort ignorieren",
  
  IGNORED_PRIORITY_TITLE = "Die ausgewählte Priorität würde ignoriert werden.",
  IGNORED_PRIORITY_FIX = "Den blockierenden Zielen dieselbe Priorität zuweisen.",
  IGNORED_PRIORITY_IGNORE = "Ich werde die Prioritäten selbst festlegen.",
  
  -- "/qh find"
  RESULTS_TITLE = "Suchergebnisse",
  NO_RESULTS = "Es gibt keine!",
  CREATED_OBJ = "Erstellt: %1",
  REMOVED_OBJ = "Gelöscht: %1",
  USER_OBJ = "Benutzerziel: %h1",
  UNKNOWN_OBJ = "QuestHelper weiß nicht, wo du für dieses Ziel hingehen solltest.",
  INACCESSIBLE_OBJ = "QuestHelper konnte keinen sinnvollen Ort für %h1 finden. Wir haben deiner Aufgabenliste einen möglicherweise nicht zu findenden Ort hinzugefügt. Wenn du eine nützliche Version dieses Objekts findest, sende deine Daten bitte ein!",
  FIND_REMOVE = "Ziel aufgeben",
  FIND_NOT_READY = "QuestHelper ist noch nicht vollständig geladen. Bitte eine Minute warten und dann nocheinmal probieren.",
  FIND_CUSTOM_LOCATION = "Benutzerdefinierte Kartenposition",
  FIND_USAGE = "Find klappt nicht, wenn du nicht angibst, was gefunden werden soll. Versuche %h(/qh help) für Anweisungen.",
  
  -- Shared objectives.
  PEER_TURNIN = "Warte auf %h1, um %h2 abzugeben.",
  PEER_LOCATION = "Hilf %h1, einen Ort in %h2 zu erreichen.",
  PEER_ITEM = "Hilf %1, %h2 zu erwerben.",
  PEER_OTHER = "Unterstütze %1 bei %h2.",
  
  PEER_NEWER = "%h1 verwendet eine neuere Protokollversion. Vielleicht ist es Zeit zum Aktualisieren.",
  PEER_OLDER = "%h1 verwendet eine ältere Protokollversion.",
  
  UNKNOWN_MESSAGE = "Unbekannter Nachrichtentyp '%1' von '%2'.",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "Versteckte Ziele",
  HIDDEN_NONE = "Es sind keine Ziele ausgeblendet.",
  DEPENDS_ON_SINGLE = "Ist abhängig von: '%1'.",
  DEPENDS_ON_COUNT = "Ist abhängig von %1 versteckten Ziel(en).",
  DEPENDS_ON = "Ist abhängig von gefilterten Zielen.",
  FILTERED_LEVEL = "Wegen der Stufe gefiltert.",
  FILTERED_GROUP = "Wegen der Gruppengröße gefiltert.",
  FILTERED_ZONE = "Wegen des Gebiets gefiltert.",
  FILTERED_COMPLETE = "Gefiltert, weil abgeschlossen.",
  FILTERED_BLOCKED = "Wegen nicht abgeschlossenem vorherigen Ziel gefiltert.",
  FILTERED_UNWATCHED = "Wird nicht im Questprotokoll verfolgt und wurde deshalb gefiltert.",
  FILTERED_WINTERGRASP = "Gefiltert, weil Tausendwinter-PvP-Quest.",
  FILTERED_RAID = "Gefiltert, weil nicht in einem Schlachtzug machbar.",
  FILTERED_USER = "Du hast dieses Ziel ausgeblendet.",
  FILTERED_UNKNOWN = "Der Lösungsweg ist unbekannt.",
  
  HIDDEN_SHOW = "Anzeigen",
  HIDDEN_SHOW_NO = "Nicht anzeigbar",
  HIDDEN_EXCEPTION = "Ausnahme hinzufügen",
  DISABLE_FILTER = "Filter deaktivieren: %1",
  FILTER_DONE = "erledigt",
  FILTER_ZONE = "Gebiet",
  FILTER_LEVEL = "Stufe",
  FILTER_BLOCKED = "blockiert",
  FILTER_WATCHED = "beobachtet",
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = "Klicken, um diesen Erfolg zu QuestHelper hinzuzufügen.",
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "Du hast %h(neue Informationen) zu %h1 und %h(aktualisierte Informationen) zu %h2.",
  NAG_SINGLE_NEW = "Du hast %h(neue Informationen) zu %h1.",
  NAG_ADDITIONAL = "Du hast %h(zusätzliche Informationen) zu %h1.",
  NAG_POLLUTED = "In deiner Datenbank befinden sich Informationen von einem Testserver oder privaten Server. Sie wird beim Starten bereinigt.",
  
  NAG_NOT_NEW = "Du hast keine Informationen, die nicht bereits in der statischen Datenbank sind.",
  NAG_NEW = "Du solltest in Betracht ziehen, deine Daten zu teilen, damit andere davon profitieren können.",
  NAG_INSTRUCTIONS = "Gib %h(/qh submit) ein, um Anweisungen zum Einsenden von Daten zu erhalten.",
  
  NAG_SINGLE_FP = "einem Flugmeister",
  NAG_SINGLE_QUEST = "einer Quest",
  NAG_SINGLE_ROUTE = "einer Flugroute",
  NAG_SINGLE_ITEM_OBJ = "einem Gegenstandsziel",
  NAG_SINGLE_OBJECT_OBJ = "einem Objektziel",
  NAG_SINGLE_MONSTER_OBJ = "einem Monsterziel",
  NAG_SINGLE_EVENT_OBJ = "einem Ereignisziel",
  NAG_SINGLE_REPUTATION_OBJ = "einem Rufziel",
  NAG_SINGLE_PLAYER_OBJ = "einem Spielerziel",
  
  NAG_MULTIPLE_FP = "%1 Flugmeister",
  NAG_MULTIPLE_QUEST = "%1 Quests",
  NAG_MULTIPLE_ROUTE = "%1 Flugstrecken",
  NAG_MULTIPLE_ITEM_OBJ = "%1 Gegenstandszielen",
  NAG_MULTIPLE_OBJECT_OBJ = "%1 Objektzielen",
  NAG_MULTIPLE_MONSTER_OBJ = "%1 Monsterzielen",
  NAG_MULTIPLE_EVENT_OBJ = "%1 Ereigniszielen",
  NAG_MULTIPLE_REPUTATION_OBJ = "%1 Rufzielen",
  NAG_MULTIPLE_PLAYER_OBJ = "%1 Spielerzielen",
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "%1's Fortschritte:",
  TRAVEL_ESTIMATE = "Geschätzte Reisezeit:",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "Besuche %h1 auf dem Weg zu:",
  FLIGHT_POINT = "%1 Flugpunkt",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = "Linksklick: Reiseweginformationen %1.",
  QH_BUTTON_TOOLTIP2 = "Rechtsklick: Einstellungsmenü anzeigen.",
  QH_BUTTON_SHOW = "anzeigen",
  QH_BUTTON_HIDE = "ausblenden",

  MENU_CLOSE = "Menü schließen",
  MENU_SETTINGS = "Einstellungen",
  MENU_ENABLE = "aktivieren",
  MENU_DISABLE = "deaktivieren",
  MENU_OBJECTIVE_TIPS = "Ziel-Tooltipps %1",
  MENU_TRACKER_OPTIONS = "Quest Tracker",
  MENU_QUEST_TRACKER = "%1 Quest Tracker",
  MENU_TRACKER_LEVEL = "%1 Quest Levels",
  MENU_TRACKER_QCOLOUR = "Farben für Questschwierigkeit %1",
  MENU_TRACKER_OCOLOUR = "Farben für Zielfortschritt %1",
  MENU_TRACKER_SCALE = "Trackergröße",
  MENU_TRACKER_RESET = "Position zurücksetzen",
  MENU_FLIGHT_TIMER = "Flugzeit %1",
  MENU_ANT_TRAILS = "Ameisenspuren %1",
  MENU_WAYPOINT_ARROW = "Wegpunktpfeil %1",
  MENU_MAP_BUTTON = "Kartenknopf %1",
  MENU_ZONE_FILTER = "Gebietsfilter %1",
  MENU_DONE_FILTER = "Erledigt-Filter %1",
  MENU_BLOCKED_FILTER = "Blockiert-Filter %1",
  MENU_WATCHED_FILTER = "Beobachtet-Filter %1",
  MENU_LEVEL_FILTER = "%1 Level Filter",
  MENU_LEVEL_OFFSET = "Bereich für den Stufenfilter",
  MENU_ICON_SCALE = "Symbolgröße",
  MENU_FILTERS = "Filter",
  MENU_PERFORMANCE = "Verfügbare Leistung für die Streckenberechnung",
  MENU_LOCALE = "Sprache",
  MENU_PARTY = "Gruppe",
  MENU_PARTY_SHARE = "Teilen von Zielen %1",
  MENU_PARTY_SOLO = "Gruppe ignorieren %1",
  MENU_HELP = "Hilfe",
  MENU_HELP_SLASH = "Slash-Befehle",
  MENU_HELP_CHANGES = "Change Log",
  MENU_HELP_SUBMIT = "Daten einsenden",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "Von QuestHelper beobachtet",
  TOOLTIP_QUEST = "Für die Quest %h1.",
  TOOLTIP_PURCHASE = "Kaufe %h1.",
  TOOLTIP_SLAY = "Töte für %h1.",
  TOOLTIP_LOOT = "Erbeute für %h1.",
  TOOLTIP_OPEN = "Öffne für %h1.",
  
  -- Settings
  SETTINGS_ARROWLINK_ON = "%h1 wird zur Zieldarstellung verwendet.",
  SETTINGS_ARROWLINK_OFF = "%h1 wird nicht zur Zieldarstellung verwendet.",
  SETTINGS_ARROWLINK_ARROW = "QuestHelper-Richtungspfeil",
  SETTINGS_ARROWLINK_CART = "Cartographer-Wegpunkte",
  SETTINGS_ARROWLINK_TOMTOM = "TomTom",
  SETTINGS_PRECACHE_ON = "Vorabspeichern wurde %h(aktiviert).",
  SETTINGS_PRECACHE_OFF = "Vorabspeichern wurde %h(deaktiviert).",
  
  SETTINGS_MENU_ENABLE = "aktivieren",
  SETTINGS_MENU_DISABLE = "deaktivieren",
  SETTINGS_MENU_CARTWP = "Cartographer-Pfeil %1",
  SETTINGS_MENU_TOMTOM = "TomTom-Pfeil %1",
  
  SETTINGS_MENU_ARROW_LOCK = "Sperren",
  SETTINGS_MENU_ARROW_ARROWSCALE = "Pfeilgröße",
  SETTINGS_MENU_ARROW_TEXTSCALE = "Textgröße",
  SETTINGS_MENU_ARROW_RESET = "Zurücksetzen",
  
  SETTINGS_MENU_INCOMPLETE = "Unvollständige Quests",
  
  SETTINGS_RADAR_ON = "Minimap-Radar eingeschaltet! (piep, piep, piep)",
  SETTINGS_RADAR_OFF = "Minimap-Radar ausgeschaltet. (wiiiiie, klick)",
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "%h1 Yard",
  DISTANCE_METRES = "%h1 Meter"
 }

