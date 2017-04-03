-- Please see enus.lua for reference.

QuestHelper_Translations.elEL =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "Ελληνικά",
  
  -- Messages used when starting.
  LOCALE_ERROR = "Η γλώσσα των σωσμένων δεδομένων σας δεν ταιριάζει με αυτήν της eγκατάστασης του WoW.Αλλάξτε την γλώσσα ή σβήστε τα δεδομένα με την εντολή %h(/qh purge). ",
  ZONE_LAYOUT_ERROR = "Αρνούμαστε να εκτελέσουμε την εφαρμογή από φόβο μην αλλοιωθούν τα σωσμένα δεδομένα σας.Παρακαλώ αναμείνατε για μία ανανέωση που θα μπορεί να σας οδηγήσει στην νέα ζώνη. Μπορείτε να γράψεται /console reloadui . Μπορεί αυτό να λύσει το πρόβλημα.",
  HOME_NOT_KNOWN = "Το σπίτι σας δεν είναι γνωστό. Όταν έχετε την ευκαιρία, μιλήστε στον ξενοδόχο για να επιστρέψει στην αρχική ου θέση.",
  PRIVATE_SERVER = "To QuestHelper δεν υποστηρίζει ιδιωτικούς κόσμους.",
  PLEASE_RESTART = "Ένα λάθος συναίβει στην έναρξη του βοηθού αποστολών.Επανεκκινήστe το παιχνίδι ή γράψτε /console reloadui .",
  NOT_UNZIPPED_CORRECTLY = "To QuestHelper δεν εγκαταστάθηκε σωστά. Δοκιμάστε πάλι και κάντε σωστή εξαγωγή με το Zip.",
  PLEASE_SUBMIT = "%h(Το QuestHelper χρειαζετε την βοηθεια σας!) Εαν διαθετετε μερικα λεπτα, παρακαλω μπειτε στην κεντρικη σελιδα του QuestHelper στο %h(http://www.questhelp.us) και ακολουθηστε τις οδηγιες για να προσφερετε τα μαζεμενα δεδομενα σας. Τα δεδομενα σας βοηθανε το QuestHelper να παραμενει σωστο και ενημερωμενο. Σας ευχαριστω.",
  HOW_TO_CONFIGURE = "To QuestHelper δεν έχει σελίδα με ρυθμίσης, αλλά μπορεί να ρυθμιστή γράφοντας %h(/qh settings). Για βοήθεια γράψε %h(/qh help).",
  TIME_TO_UPDATE = "Μπορεί να υπάρχει μία %h(νέα εκδοση τού QuestHelper). Οι νέες εκδόσεις συχνά σε βοηθούν σε πιο πολλά quest.",
  
  -- Route related text.
  ROUTES_CHANGED = "Οι διαδρομές πτήσεις έχουν αλλάξει για τον χαρακτήρα σας.",
  HOME_CHANGED = "Το σπίτι σας άλλαξε.",
  TALK_TO_FLIGHT_MASTER = "Παρακαλώ μιλήστε στον κοντινότερο οδηγό πτήσης",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "Ευχαριστώ.",
  WILL_RESET_PATH = "Θα ξαναφορτώσει τις πληροφορίες διαδρομής.",
  UPDATING_ROUTE = "Ανανέωση διαδρομής.",
  
  -- Special tracker text
  QH_LOADING = "Φόρτωση Quest Helper (%1%%)...",
  QH_FLIGHTPATH = "Υπολόγισμα των σημείων πτήσης",
  QH_RECALCULATING = nil,
  QUESTS_HIDDEN_1 = "Οι αποστολές μπορεί να είναι κρυμμένες",
  QUESTS_HIDDEN_2 = "(\"/qh hidden\" για να δεις τις κρυφές)",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "Διαθέσιμες Γλωσσες:",
  LOCALE_CHANGED = "Η γλώσσα άλλαξε σε: %h1",
  LOCALE_UNKNOWN = "Η γλωσσα %h1 δεν είναι γνωστή.",
  
  -- Words used for objectives.
  SLAY_VERB = "Σκότωσε",
  ACQUIRE_VERB = "Αποκτήστε",
  
  OBJECTIVE_REASON = "%1 %h2 για την αποστολή %h3.", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "%h1 για την αποστολή %h2.",
  OBJECTIVE_REASON_TURNIN = "Επιστρέψτε την αποστολή  %h1.",
  OBJECTIVE_PURCHASE = "Αγόρασε από %h1.",
  OBJECTIVE_TALK = "Μίλα στον %h1.",
  OBJECTIVE_SLAY = "Σκότωσε %h1.",
  OBJECTIVE_LOOT = "Λάφυρα %h1.",
  OBJECTIVE_OPEN = nil,
  
  OBJECTIVE_MONSTER_UNKNOWN = "Άγνωστο τέρας",
  OBJECTIVE_ITEM_UNKNOWN = "Άγνωστο αντικείμενο",
  
  ZONE_BORDER_SIMPLE = "%1 οριο",
  
  -- Stuff used in objective menus.
  PRIORITY = "Προτεραιότητα",
  PRIORITY1 = "Υψηλότερη",
  PRIORITY2 = "Υψηλή",
  PRIORITY3 = "Κανονική",
  PRIORITY4 = "Χαμηλή",
  PRIORITY5 = "Χαμηλότερη",
  SHARING = "Διανομή",
  SHARING_ENABLE = "Διαμοίρασε",
  SHARING_DISABLE = "Μην Διανέμεις",
  IGNORE = "Αγνοήστε",
  IGNORE_LOCATION = "Αγνόησε αυτήν την τοποθεσία",
  
  IGNORED_PRIORITY_TITLE = "Η επιλεγμένη προτεραιότητα θα αγνοηθεί.",
  IGNORED_PRIORITY_FIX = "Εφαρμόστε ίδια προτεραιότητα στους κρυφούς στόχους.",
  IGNORED_PRIORITY_IGNORE = "Θα θέσω τις προτεραιότητες μόνος μου.",
  
  -- "/qh find"
  RESULTS_TITLE = "Αποτελέσματα Αναζήτησης",
  NO_RESULTS = "Δεν υπάρχει κανένα!",
  CREATED_OBJ = "Δημιουργήθηκαν: %1 ",
  REMOVED_OBJ = "Αφαιρέθηκε: %1",
  USER_OBJ = "Στόχοι Χρήστη: %h1",
  UNKNOWN_OBJ = "Δεν γνωρίζουμε που πρέπει να πάτε για αυτό τον στόχο.",
  INACCESSIBLE_OBJ = "To QuestHelper δεν μπόρεσε να βρεί μια χρήσιμη τοποθεσία για %h1. Προσθέσαμε μια απίθανη τοποθεσία στην λίστα στόχων. Έαν βρείτε μια τοποθεσία χρήσιμη για αυτό των στόχο παρακαλούμε δημοσιεύστε αυτήν! (%h(/qh submit)) ",
  FIND_REMOVE = nil,
  FIND_NOT_READY = nil,
  FIND_CUSTOM_LOCATION = nil,
  FIND_USAGE = nil,
  
  -- Shared objectives.
  PEER_TURNIN = "Περίμενε τον %h1 να επιστρέψει το %h2.",
  PEER_LOCATION = "Βοήθησε τον %h1 να φτάσει την τοποθεσιά στο %h2.",
  PEER_ITEM = "Βοήθησε τον %1 να αποκτήσει %h2.",
  PEER_OTHER = "Βοήθησε τον %1 με το %h2.",
  
  PEER_NEWER = "Ο %h1 χρησιμοποιεί μία νεότερη έκδοση. Ήρθε η ώρα να ενημερώσεις και εσύ την δική σου.",
  PEER_OLDER = "Ο %h1 χρησιμοποιεί μία παλαιότερη έκδοση.",
  
  UNKNOWN_MESSAGE = "Άγνωστος τύπος μηνύματος '%1' από '%2'.",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "Κρυφός Στόχος",
  HIDDEN_NONE = "Δεν υπάρχουν στόχοι που να είναι κρυφοί.",
  DEPENDS_ON_SINGLE = "Εξαρτώμενο από '%1'",
  DEPENDS_ON_COUNT = "Εξαρτώμενο απο %1 κρυφούς στόχους.",
  DEPENDS_ON = "Εξαρτώμενο απο φιλτραρισμένους στόχους.",
  FILTERED_LEVEL = "Φιλτραρίστηκε λόγω επιπέδου.",
  FILTERED_GROUP = "Φιλτραρισμένο λόγω μεγέθους της ομάδας",
  FILTERED_ZONE = "Φιλτραρίστηκε λόγω ζώνης.",
  FILTERED_COMPLETE = "Φιλτραρίστηκε διότι ολοκληρώθηκε.",
  FILTERED_BLOCKED = "Φιλτραρίστηκε διότι ο πρωτεύων στόχος δεν έχει ολοκληρωθεί",
  FILTERED_UNWATCHED = "Φιλτραρίστηκε διότι δεν ακολουθείται απο το Αρχείο Αποστολών",
  FILTERED_WINTERGRASP = "Φιλτραρισμένο επειδή είναι PvP αποστολή της Wintergrasp",
  FILTERED_RAID = nil,
  FILTERED_USER = "Ζητήσατε αυτός ο στόχος να είναι κρυφός.",
  FILTERED_UNKNOWN = "Δεν γνωρίζουμε πως να ολοκληρωθεί.",
  
  HIDDEN_SHOW = "Εμφανισε.",
  HIDDEN_SHOW_NO = "Δεν μπορεί να εμφανιστεί.",
  HIDDEN_EXCEPTION = "Προσθήκη εξαίρεσης",
  DISABLE_FILTER = "Απενεργοποίηση φίλτρου: %1",
  FILTER_DONE = "Ολοκληρώθηκε",
  FILTER_ZONE = "Ζώνη",
  FILTER_LEVEL = "Επίπεδο",
  FILTER_BLOCKED = "Μπλοκαρισμένο",
  FILTER_WATCHED = "Παρακολουθούμενα",
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = nil,
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "Έχετε %h(νέες πληροφορίες) στο %h1, και %h(ενημερωμένες πληροφορίες) στο %h2.",
  NAG_SINGLE_NEW = "Έχετε %h(νέες πληροφορίες) στο %h1.",
  NAG_ADDITIONAL = "Έχετε %h(πρόσθετες πληροφορίες) στο %h1",
  NAG_POLLUTED = "Η βάση δεδομένων σου έχει πληροφορίες απο δοκιμαστικό ή ιδιωτικό κόσμο, θα καθαριστεί με την εκκίνηση.",
  
  NAG_NOT_NEW = "Δεν έχεις κάποια δεδομένα που να μην είναι ήδη στην στατική βάση δεδομένων.",
  NAG_NEW = "Πρέπει να διανήμεις τα δεδομένα σου για να επωφεληθουν και άλλοι.",
  NAG_INSTRUCTIONS = "Πληκτρολόγησε %h(/qh submit) για οδηγίες στο πώς να δημοσιεύσεις τα δεδομένα σου.",
  
  NAG_SINGLE_FP = "ένας οδηγός πτήσης",
  NAG_SINGLE_QUEST = "μία αποστολή",
  NAG_SINGLE_ROUTE = "μία διαδρομή πτήσης",
  NAG_SINGLE_ITEM_OBJ = "ένα στοιχείο για τον στόχο",
  NAG_SINGLE_OBJECT_OBJ = "ένα αντικέιμενο για τον στόχο",
  NAG_SINGLE_MONSTER_OBJ = "ένα τέρας για τον στόχο",
  NAG_SINGLE_EVENT_OBJ = "ένα γεγονός για τον στόχο",
  NAG_SINGLE_REPUTATION_OBJ = "μόνο φήμη για τον στόχο",
  NAG_SINGLE_PLAYER_OBJ = "ένας παίκτης για τον στόχο",
  
  NAG_MULTIPLE_FP = "%1 οδηγός πτήσης",
  NAG_MULTIPLE_QUEST = "%1 Αποστολές",
  NAG_MULTIPLE_ROUTE = "%1 διαδρομές πτήσης",
  NAG_MULTIPLE_ITEM_OBJ = "%1 στοιχείο για στόχους",
  NAG_MULTIPLE_OBJECT_OBJ = "%1 αντικείμενο για στόχους",
  NAG_MULTIPLE_MONSTER_OBJ = "%1 τέρας για στόχους",
  NAG_MULTIPLE_EVENT_OBJ = "%1 στόχοι γεγονότων",
  NAG_MULTIPLE_REPUTATION_OBJ = "%1 φήμη για τους στόχους",
  NAG_MULTIPLE_PLAYER_OBJ = "%1 παίκτης για στόχους",
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "Η πρόοδος του %1:",
  TRAVEL_ESTIMATE = "Εκτιμώμενος χρόνος ταξιδίου:",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "Επισκευθείτε %h1 στην διαδρομή προς:",
  FLIGHT_POINT = "%1 σημείο πτήσης",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "To QuestHelper",
  QH_BUTTON_TOOLTIP1 = "Αριστερό Κλικ: %1 πληροφορίες διαδρομής.",
  QH_BUTTON_TOOLTIP2 = "Δεξί Κλικ: Δείξε το Μενού Ρυθμίσεων",
  QH_BUTTON_SHOW = "Δείξε",
  QH_BUTTON_HIDE = "Απόκρυψε",

  MENU_CLOSE = "Κλείσιμο του μενού",
  MENU_SETTINGS = "Ρυθμίσεις",
  MENU_ENABLE = "Ενεργοποίηση",
  MENU_DISABLE = "Απενεργοποίηση",
  MENU_OBJECTIVE_TIPS = "%1 Βοήθεια Στόχων",
  MENU_TRACKER_OPTIONS = "Καταγραφέας Αποστολης ",
  MENU_QUEST_TRACKER = "%1 Καταγραφέας Αποστολης ",
  MENU_TRACKER_LEVEL = "%1 Επίπεδα Αποστολής",
  MENU_TRACKER_QCOLOUR = "%1 Χρώματα Δυσκολίας Αποστολών",
  MENU_TRACKER_OCOLOUR = "%1 Χρώματα Πρόοδου Στόχων",
  MENU_TRACKER_SCALE = "Μέγεθος Καταγραφέα",
  MENU_TRACKER_RESET = "Επαναφορά Θέσης",
  MENU_FLIGHT_TIMER = "%1 Χρόνος Πτήσης",
  MENU_ANT_TRAILS = "%1 ίχνη διαδρομής.",
  MENU_WAYPOINT_ARROW = "%1 Βέλος Σημείου Ενδιαφέροντος",
  MENU_MAP_BUTTON = "%1 Κουμπί Χάρτη",
  MENU_ZONE_FILTER = "%1 Φίλτρο Ζώνης",
  MENU_DONE_FILTER = "%1 Φίλτρο Ολοκρήρωσης",
  MENU_BLOCKED_FILTER = "%1 μπλοκαρισμένο φίλτρο",
  MENU_WATCHED_FILTER = "%1 Φίλτρο Παρακολουθούμενων",
  MENU_LEVEL_FILTER = "%1 Φίλτρο Επιπέδου",
  MENU_LEVEL_OFFSET = "Κλίμακα Φίλτρο Επιπέδου ",
  MENU_ICON_SCALE = "Μέγεθος Εικονιδίων",
  MENU_FILTERS = "Φίλτρα",
  MENU_PERFORMANCE = "Μέγεθος Φόρτου Διαδρομής",
  MENU_LOCALE = "Γλώσσα",
  MENU_PARTY = "Ομάδα",
  MENU_PARTY_SHARE = "%1 Διανομή Στόχων",
  MENU_PARTY_SOLO = "%1 Aγνόηση Ομάδας",
  MENU_HELP = "Βοήθεια",
  MENU_HELP_SLASH = "Εντολές με κάθετο. \" / \"",
  MENU_HELP_CHANGES = "Αρχείο Αλλαγών",
  MENU_HELP_SUBMIT = "Δημοσίευση Δεδομένων",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "Παρακολουθείται από το QuestHelper.",
  TOOLTIP_QUEST = "Για την Αποστολή %h1.",
  TOOLTIP_PURCHASE = "Αγόρασε %h1.",
  TOOLTIP_SLAY = "Σκότωσε για το %h1.",
  TOOLTIP_LOOT = "Λάφυρα για τον %h1.",
  TOOLTIP_OPEN = nil,
  
  -- Settings
  SETTINGS_ARROWLINK_ON = "Θα χρησιμοποιήσουμε %h1 για να δείξουμε τους στόχους.",
  SETTINGS_ARROWLINK_OFF = "Δεν θα χρησιμοποιήσουμε %h1 για να δείξουμε τους στόχους.",
  SETTINGS_ARROWLINK_ARROW = "Βέλος του QuestHelper",
  SETTINGS_ARROWLINK_CART = "Δρομολογια του Cartographer.",
  SETTINGS_ARROWLINK_TOMTOM = "TomTom",
  SETTINGS_PRECACHE_ON = "Το Precache εχει ενεργοποιηθει.",
  SETTINGS_PRECACHE_OFF = "Το Precache εχει απενεργοποιηθει.",
  
  SETTINGS_MENU_ENABLE = "Ενεργοποίηση",
  SETTINGS_MENU_DISABLE = "Απενεργοποίηση",
  SETTINGS_MENU_CARTWP = "%1 Βέλος του Cartographer",
  SETTINGS_MENU_TOMTOM = "%1 Βέλος του TomTom",
  
  SETTINGS_MENU_ARROW_LOCK = "Κλείδωμα",
  SETTINGS_MENU_ARROW_ARROWSCALE = "Μέγεθος Βέλους",
  SETTINGS_MENU_ARROW_TEXTSCALE = "Μέγεθος κειμένου",
  SETTINGS_MENU_ARROW_RESET = "Επαναφορά",
  
  SETTINGS_MENU_INCOMPLETE = nil,
  
  SETTINGS_RADAR_ON = nil,
  SETTINGS_RADAR_OFF = nil,
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "%h1 γιάρδες",
  DISTANCE_METRES = "%h1 μέτρα"
 }

