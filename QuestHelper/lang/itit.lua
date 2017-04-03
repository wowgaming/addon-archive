-- Please see enus.lua for reference.

QuestHelper_Translations.itIT =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "Italiano",
  
  -- Messages used when starting.
  LOCALE_ERROR = "La lingua dei tuoi dati salvati non corrisponde alla lingua del tuo client WoW. Per usare QuestHelper dovrai cambiare nuovamente la lingua, o cancellare i dati col comando %h(/qh purge).",
  ZONE_LAYOUT_ERROR = "La tua versione di QuestHelper è vecchia, dovrai fare l'update in http://www.questhelp.us per fare che il programma continui a funzionare. Attualmente stai usando la versione %1",
  HOME_NOT_KNOWN = "La tua località base è sconosciuta. Appena puoi, parla con un locandiere per reimpostarla.",
  PRIVATE_SERVER = "QuestHelper non sopporta i server privati.",
  PLEASE_RESTART = "C'è stato un errore con l'avvio di QuestHelper. E' consigliabile chiudere World of Warcraft e riprovare.",
  NOT_UNZIPPED_CORRECTLY = "QuestHelper non è installato corretamente. Raccomandiamo di usare Curse Client o 7zip per installarlo. Assicurati che le sottodirectory sono esatte.",
  PLEASE_SUBMIT = "%h (QuestHelper ha bisogno del tuo aiuto!) Se hai qualche minuti, per favore va sul sito di QuestHelper all'indirizzo %h(http://www.questhelp.us) e segui le istruzioni per inviare i dati da te raccolti. Questi dati permettono a QuestHelper di mantenere dati aggiornati e corretti sulle quest. Grazie!",
  HOW_TO_CONFIGURE = "QuestHelper non è stato ancora settato,ma puo essere configurato scrivendo %h(/qh settings). L'aiuto è disponibile scrivendo %h(/qh help) ",
  TIME_TO_UPDATE = "Potrebbe esserci una %h(nuova versione di QuestHelper) disponibile. Le nuove versioni di solito includono nuove funzioni, nuovi database delle quest, e fix dei bug. Per favore aggiorna la versione di QuestHelper in uso!",
  
  -- Route related text.
  ROUTES_CHANGED = "I percorsi di volo del tuo personaggio sono stati modificati.",
  HOME_CHANGED = "La tua località base è stata cambiata.",
  TALK_TO_FLIGHT_MASTER = "Per favore parla con il flight master più vicino.",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "Grazie.",
  WILL_RESET_PATH = "Reimposterà le informazioni sul percorso.",
  UPDATING_ROUTE = "Sto aggiornando il percorso.",
  
  -- Special tracker text
  QH_LOADING = "QuestHelper si sta avviando (%1%%)...",
  QH_FLIGHTPATH = "Ricalcolo dei punti di volo (%1%)",
  QH_RECALCULATING = nil,
  QUESTS_HIDDEN_1 = "Le Quest potrebbero essere nascoste",
  QUESTS_HIDDEN_2 = "(scrivi \"/qh hidden\" per una lista)",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "Lingue disponibili:",
  LOCALE_CHANGED = "Lingua cambiata in: %h1",
  LOCALE_UNKNOWN = "La lingua %h1 è sconosciuta.",
  
  -- Words used for objectives.
  SLAY_VERB = "Uccidi",
  ACQUIRE_VERB = "Acquisire",
  
  OBJECTIVE_REASON = "%1 %h2 per la quest %h3", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "%h1 per la quest %h2.",
  OBJECTIVE_REASON_TURNIN = "Consegna la quest %h1.",
  OBJECTIVE_PURCHASE = "Compra da %h1.",
  OBJECTIVE_TALK = "Parla con %h1.",
  OBJECTIVE_SLAY = "Uccidi %h1.",
  OBJECTIVE_LOOT = "Raccogli %h1.",
  OBJECTIVE_OPEN = nil,
  
  OBJECTIVE_MONSTER_UNKNOWN = "Mostro sconosciuto",
  OBJECTIVE_ITEM_UNKNOWN = "Item sconosciuto",
  
  ZONE_BORDER_SIMPLE = "%1 frontiera",
  
  -- Stuff used in objective menus.
  PRIORITY = "Priorità",
  PRIORITY1 = "Altissima",
  PRIORITY2 = "Alta",
  PRIORITY3 = "Normale",
  PRIORITY4 = "Bassa",
  PRIORITY5 = "Bassissima",
  SHARING = "Condivisione",
  SHARING_ENABLE = "Condividi",
  SHARING_DISABLE = "Non condividere",
  IGNORE = "Ignora",
  IGNORE_LOCATION = "Ignora questa località",
  
  IGNORED_PRIORITY_TITLE = "La priorità selezionata verrà ignorata.",
  IGNORED_PRIORITY_FIX = "Applica la stessa priorità agli obiettivi bloccanti.",
  IGNORED_PRIORITY_IGNORE = "Imposterò le priorità per conto mio.",
  
  -- "/qh find"
  RESULTS_TITLE = "Risultati ricerca",
  NO_RESULTS = "Non ce ne sono!",
  CREATED_OBJ = "Creato: %1",
  REMOVED_OBJ = "Rimosso: %1",
  USER_OBJ = "Obiettivo personalizzato: %h1",
  UNKNOWN_OBJ = "Non so dove dovresti andare per quest'obiettivo.",
  INACCESSIBLE_OBJ = "QuestHelper è inabilitato a trovare una locazione utile per %h1. Abbiamo aggiunto una locazione impossibile da trovare. Se riesci a trovare questo obbiettivo,ti preghiamo di inviarci i tuoi dati! (%h(/qh submit))",
  FIND_REMOVE = nil,
  FIND_NOT_READY = nil,
  FIND_CUSTOM_LOCATION = nil,
  FIND_USAGE = nil,
  
  -- Shared objectives.
  PEER_TURNIN = "Attendere %h1 per consegnare %h2.",
  PEER_LOCATION = "Aiuta %h1 a raggiungere un sito in %h2.",
  PEER_ITEM = "Aiuta %h1 a procurarsi %h2.",
  PEER_OTHER = "Aiuta %1 con %h2",
  
  PEER_NEWER = "%h1 sta usando una versione più nuova del protocollo. Forse è il momento di aggiornare.",
  PEER_OLDER = "%h1 sta usando una versione più vecchia del protocollo.",
  
  UNKNOWN_MESSAGE = "Tipo di messaggio sconosciuto '%1' da '%2'.",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "Obiettivi nascosti",
  HIDDEN_NONE = "Non ci sono obiettivi nascosti.",
  DEPENDS_ON_SINGLE = "Dipende da '%1'",
  DEPENDS_ON_COUNT = "Dipende da %1 obiettivi nascosti.",
  DEPENDS_ON = "Dipende da un obiettivo filtrato",
  FILTERED_LEVEL = "Nascosto per il livello",
  FILTERED_GROUP = "Filtrato a causa della dimensione del gruppo",
  FILTERED_ZONE = "Nascosto per la zona",
  FILTERED_COMPLETE = "Nascosto dato che è stato completato",
  FILTERED_BLOCKED = "Nascosto per un obiettivo precedente incompleto",
  FILTERED_UNWATCHED = "Filtrato per non essere Mostrato nel Quest Log",
  FILTERED_WINTERGRASP = "Nascosto in quanto fare parte di una quest PvP di Wintergrasp",
  FILTERED_RAID = "Nascosto perchè non completabile in un raid",
  FILTERED_USER = "Hai richiesto che questo obiettivo venga nascosto.",
  FILTERED_UNKNOWN = "Non so come completare",
  
  HIDDEN_SHOW = "Mostra.",
  HIDDEN_SHOW_NO = "Non visibile",
  HIDDEN_EXCEPTION = "aggiungi eccezione",
  DISABLE_FILTER = "Disattiva filtro: %1",
  FILTER_DONE = "fatto",
  FILTER_ZONE = "zona",
  FILTER_LEVEL = "livello",
  FILTER_BLOCKED = "bloccato",
  FILTER_WATCHED = "seguito",
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = nil,
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "Hai %h(nuove informazioni) su %h1, e %h(informazioni aggiornate) su %h2.",
  NAG_SINGLE_NEW = "Hai %h(nuove informazioni) su %h1.",
  NAG_ADDITIONAL = "Hai %h(informazioni aggiuntive) su %h1.",
  NAG_POLLUTED = "Il tuo database è stato corrotto da informazioni provenienti da un server test o privato e saranno eliminate al prossimo avvio.",
  
  NAG_NOT_NEW = "Non hai nessuna informazione che non sia già nel database statico.",
  NAG_NEW = "Potresti prendere in considerazione la possibilità di condividere i tuoi dati così da permettere agli altri di beneficiarne.",
  NAG_INSTRUCTIONS = "Digita %h(/qh submit) per istruzioni sull'invio dei dati.",
  
  NAG_SINGLE_FP = "un flight master",
  NAG_SINGLE_QUEST = "una quest",
  NAG_SINGLE_ROUTE = "un percorso di volo",
  NAG_SINGLE_ITEM_OBJ = "un obiettivo oggetto",
  NAG_SINGLE_OBJECT_OBJ = "un obiettivo oggetto",
  NAG_SINGLE_MONSTER_OBJ = "un obiettivo mostro",
  NAG_SINGLE_EVENT_OBJ = "un obiettivo evento",
  NAG_SINGLE_REPUTATION_OBJ = "un obiettivo reputazione",
  NAG_SINGLE_PLAYER_OBJ = "obbiettivo personale",
  
  NAG_MULTIPLE_FP = "%1 flight master",
  NAG_MULTIPLE_QUEST = "%1 quest",
  NAG_MULTIPLE_ROUTE = "%1 percorsi di volo",
  NAG_MULTIPLE_ITEM_OBJ = "%1 obiettivi oggetto",
  NAG_MULTIPLE_OBJECT_OBJ = "%1 obiettivi oggetto",
  NAG_MULTIPLE_MONSTER_OBJ = "%1 obiettivi mostro",
  NAG_MULTIPLE_EVENT_OBJ = "%1 obiettivi evento",
  NAG_MULTIPLE_REPUTATION_OBJ = "%1 obiettivi reputazione",
  NAG_MULTIPLE_PLAYER_OBJ = "%1 obbiettivi personali",
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "Progresso di %1:",
  TRAVEL_ESTIMATE = "Tempo di viaggio stimato:",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "Visita %h1 nel percorso per:",
  FLIGHT_POINT = "%1 punto di volo",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = "Click sinistro: %1 informazioni sul percorso.",
  QH_BUTTON_TOOLTIP2 = "Click destro: visualizza il menu Impostazioni",
  QH_BUTTON_SHOW = "Visualizza",
  QH_BUTTON_HIDE = "Nascondi",

  MENU_CLOSE = "Chiudi menu",
  MENU_SETTINGS = "Impostazioni",
  MENU_ENABLE = "Attiva",
  MENU_DISABLE = "Disattiva",
  MENU_OBJECTIVE_TIPS = "%1 Etichette obiettivo",
  MENU_TRACKER_OPTIONS = "Tracker Quest",
  MENU_QUEST_TRACKER = "%1 Tracker Quest",
  MENU_TRACKER_LEVEL = "%1 Livelli quest",
  MENU_TRACKER_QCOLOUR = "%1 Colori difficoltà delle quest",
  MENU_TRACKER_OCOLOUR = "%1 Colori progresso degli obiettivi",
  MENU_TRACKER_SCALE = "Scala del tracker",
  MENU_TRACKER_RESET = "Reimposta posiziona",
  MENU_FLIGHT_TIMER = "%1 Timer di volo",
  MENU_ANT_TRAILS = "%1 Tratteggio",
  MENU_WAYPOINT_ARROW = "%1 Freccia direzionale",
  MENU_MAP_BUTTON = "%1 Pulsante sulla mappa",
  MENU_ZONE_FILTER = "%1 Filtro zona",
  MENU_DONE_FILTER = "%1 Filtrato",
  MENU_BLOCKED_FILTER = "%1 Filtro bloccato",
  MENU_WATCHED_FILTER = "%1 Filtro mostrato",
  MENU_LEVEL_FILTER = "%1 Filtro livello",
  MENU_LEVEL_OFFSET = "Scarto del filtro livello",
  MENU_ICON_SCALE = "Dimensione icone",
  MENU_FILTERS = "Filtri",
  MENU_PERFORMANCE = "Carico del calcolo percorso",
  MENU_LOCALE = "Lingua",
  MENU_PARTY = "Party",
  MENU_PARTY_SHARE = "%1 Condivisione obiettivo",
  MENU_PARTY_SOLO = "%1 Ignora party",
  MENU_HELP = "Aiuto",
  MENU_HELP_SLASH = "Comandi Barra",
  MENU_HELP_CHANGES = "Modifiche ultima versione",
  MENU_HELP_SUBMIT = "Invio dati",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "Controllato da QuestHelper",
  TOOLTIP_QUEST = "Per la quest %h1.",
  TOOLTIP_PURCHASE = "Compra %h1.",
  TOOLTIP_SLAY = "Uccidi per %h1",
  TOOLTIP_LOOT = "Raccogli per %h1.",
  TOOLTIP_OPEN = nil,
  
  -- Settings
  SETTINGS_ARROWLINK_ON = "Sarà utilizzata %h1 per visualizzare gli obiettivi",
  SETTINGS_ARROWLINK_OFF = "Non sarà utilizzata %h1 per visualizzare gli obiettivi",
  SETTINGS_ARROWLINK_ARROW = "Freccia di QuestHelper",
  SETTINGS_ARROWLINK_CART = "Waypoints di Cartographer",
  SETTINGS_ARROWLINK_TOMTOM = "TomTom",
  SETTINGS_PRECACHE_ON = "La Precache è stata %h(enabled).",
  SETTINGS_PRECACHE_OFF = "La Precache è stata %h(disabled).",
  
  SETTINGS_MENU_ENABLE = "Abilita",
  SETTINGS_MENU_DISABLE = "Disabilita",
  SETTINGS_MENU_CARTWP = "%1 Freccia di Cartographer",
  SETTINGS_MENU_TOMTOM = "%1 Freccia di TomTom",
  
  SETTINGS_MENU_ARROW_LOCK = "Blocca",
  SETTINGS_MENU_ARROW_ARROWSCALE = "Scala della freccia",
  SETTINGS_MENU_ARROW_TEXTSCALE = "Scala testo",
  SETTINGS_MENU_ARROW_RESET = "Resetta",
  
  SETTINGS_MENU_INCOMPLETE = nil,
  
  SETTINGS_RADAR_ON = nil,
  SETTINGS_RADAR_OFF = nil,
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "%h1 yards",
  DISTANCE_METRES = "%h1 metri"
 }

