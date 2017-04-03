-- Please see enus.lua for reference.

QuestHelper_Translations.esMX =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "Español",
  
  -- Messages used when starting.
  LOCALE_ERROR = "El idioma de sus datos guardados no coincide con el idioma del cliente Wow. Para utilizar QuestHelper tendrá que cambiar la configuración regional de vuelta, o borre los datos tecleando %h(/qh purge).",
  ZONE_LAYOUT_ERROR = "Me niego a ejecutarme, por temor a dañar sus datos guardados. Por favor, espere a un nuevo parche que será capaz de manejar el nuevo diseño de zona.",
  HOME_NOT_KNOWN = "Se desconoce la posición de su hogar. Cuando pueda, por favor, hable con su posadero para restaurarla.",
  PRIVATE_SERVER = "QuestHelper no funciona en Servidores Privados",
  PLEASE_RESTART = "Hubo un error iniciando QuestHelper. Por favor salga completamente del World of Warcraft e intente nuevamente.",
  NOT_UNZIPPED_CORRECTLY = "Quest Helper se ha instalado incorrectamente. Recomendamos usar o el Curse Client o Zip.7 para instalarlo.  Asegurese que los subdirectorios son extraidos",
  PLEASE_SUBMIT = "%h (QuestHelper necesita tu ayuda!) Si tienes algunso minutos, por favor dirigete a la página principal de QuestHelper en %h(http://www.questhelp.us) y sigue las intrucciones para enviar tus datos coleccionados. Tus datos mantienen QuestHelper al día y en funcionamiento.",
  HOW_TO_CONFIGURE = "Como configurar.",
  TIME_TO_UPDATE = "Hay una nueva version Quest Helper %v disponible. Nuevas versiones incluyen normalmente nuevas funciones,nueva base de datos de misiones, y fija errores. Actualicese !!",
  
  -- Route related text.
  ROUTES_CHANGED = "Las rutas de vuelo de su personaje han sido modificadas.",
  HOME_CHANGED = "Su hogar ha sido modificado.",
  TALK_TO_FLIGHT_MASTER = "Por favor, hable con el maestro de vuelo local.",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "Gracias.",
  WILL_RESET_PATH = "Se restablecerá la información de rutas.",
  UPDATING_ROUTE = "Actualizando ruta.",
  
  -- Special tracker text
  QH_LOADING = "Cargando Quest Helper (%1%%)...",
  QH_FLIGHTPATH = "Cargando Rutas de Vuelo (%1%)...",
  QH_RECALCULATING = nil,
  QUESTS_HIDDEN_1 = " Ques que pueden estar ocultas",
  QUESTS_HIDDEN_2 = "(\"/qh hidden\" para listar)",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "Idiomas disponibles:",
  LOCALE_CHANGED = "Idioma cambiado a: %h1",
  LOCALE_UNKNOWN = "El idioma %h1 es desconocido.",
  
  -- Words used for objectives.
  SLAY_VERB = "Matar",
  ACQUIRE_VERB = "Adquirir",
  
  OBJECTIVE_REASON = "%1 %h2 para la misión %h3.", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "%h1 para la misión %h2.",
  OBJECTIVE_REASON_TURNIN = "Regresa a la misión %h1.",
  OBJECTIVE_PURCHASE = "Compre de %h1.",
  OBJECTIVE_TALK = "Habla con %h1.",
  OBJECTIVE_SLAY = "Matar %h1.",
  OBJECTIVE_LOOT = "Recoger de %h1.",
  OBJECTIVE_OPEN = nil,
  
  OBJECTIVE_MONSTER_UNKNOWN = "Monstruo Desconocido.",
  OBJECTIVE_ITEM_UNKNOWN = "Item Desconocido.",
  
  ZONE_BORDER_SIMPLE = nil,
  
  -- Stuff used in objective menus.
  PRIORITY = "Prioridad",
  PRIORITY1 = "La más alta",
  PRIORITY2 = "Alta",
  PRIORITY3 = "Normal",
  PRIORITY4 = "Baja",
  PRIORITY5 = "La más baja",
  SHARING = "Compartiendo",
  SHARING_ENABLE = "Compartir",
  SHARING_DISABLE = "No Compartir",
  IGNORE = "Ignorar",
  IGNORE_LOCATION = "Ignorar este Objeto.",
  
  IGNORED_PRIORITY_TITLE = "La prioridad seleccionada podria ser ignorada.",
  IGNORED_PRIORITY_FIX = "Aplique la misma prioridad a los objetivos bloqueados. ",
  IGNORED_PRIORITY_IGNORE = "Voy a fijar las prioridades por mi mismo.",
  
  -- "/qh find"
  RESULTS_TITLE = "Resultados de la búsqueda",
  NO_RESULTS = "¡No hay ninguno!",
  CREATED_OBJ = "Creado: %1",
  REMOVED_OBJ = "Eliminado: %1",
  USER_OBJ = "Objetivo de Usuario: %h1",
  UNKNOWN_OBJ = "No sé dónde hay que ir para ese objetivo.",
  INACCESSIBLE_OBJ = "QuestHelper ha sido incapaz de encontrar una ubicación útil para %h1. Hemos añadido una ubicación probablemente imposible de encontrar a su lista de objetivos. ¡Si usted encuentra una ubicación útil de este objeto, por favor envie sus datos! (%h(/qh submit))",
  FIND_REMOVE = nil,
  FIND_NOT_READY = nil,
  FIND_CUSTOM_LOCATION = nil,
  FIND_USAGE = nil,
  
  -- Shared objectives.
  PEER_TURNIN = "Espere a %h1 a que entregue %h2.",
  PEER_LOCATION = "Ayuda a %1 a llegar a su destino en %h2.",
  PEER_ITEM = "Ayuda a %1 a adquirir %h2.",
  PEER_OTHER = "Ayuda a %1 con %h2.",
  
  PEER_NEWER = "%h1 está utilizando una nueva versión de protocolo. Tal vez sea el momento de actualizarse.",
  PEER_OLDER = "%h1 está utilizando una versión más antigua del protocolo.",
  
  UNKNOWN_MESSAGE = "Tipo de mensaje desconocido '%1' desde '%2'.",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "Objetivos ocultos",
  HIDDEN_NONE = "No tiene objetivos ocultos.",
  DEPENDS_ON_SINGLE = "Depende de '%1'.",
  DEPENDS_ON_COUNT = "Depende de los objetivos ocultos %1.",
  DEPENDS_ON = "Depende de %1.",
  FILTERED_LEVEL = "Filtrado por Nivel.",
  FILTERED_GROUP = "Filtrado por tamaño de grupo",
  FILTERED_ZONE = "Filtrado por zona.",
  FILTERED_COMPLETE = "Filtrado debido a completados.",
  FILTERED_BLOCKED = "Filtrado debido al objetivo anterior incompleto.",
  FILTERED_UNWATCHED = "Filtrado debido a que no se está dando seguimiento en el registro de misiones",
  FILTERED_WINTERGRASP = nil,
  FILTERED_RAID = nil,
  FILTERED_USER = "Pidió que este objetivo se ocultara.",
  FILTERED_UNKNOWN = "No se cómo completarlo.",
  
  HIDDEN_SHOW = "Mostrar.",
  HIDDEN_SHOW_NO = "No se puede Mostrar.",
  HIDDEN_EXCEPTION = "Agregar Execpción.",
  DISABLE_FILTER = "Desactivar el filtro: %1",
  FILTER_DONE = "Hecho",
  FILTER_ZONE = "Zona",
  FILTER_LEVEL = "Nivel",
  FILTER_BLOCKED = "Bloqueado",
  FILTER_WATCHED = "Observado.",
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = nil,
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "Tiene %h(nueva información) sobre %h1, y %h(información actualicada) sobre %h2.",
  NAG_SINGLE_NEW = "Tiene %h(nueva información) sobre %h1.",
  NAG_ADDITIONAL = "Tiene %h(información adicional) sobre %h1.",
  NAG_POLLUTED = "Su base de datos ha sido contaminada con información de un servidor de prueba o un servidor privado, la limpiaremos al iniciar.",
  
  NAG_NOT_NEW = "No tiene ninguna información que no este ya en la base de datos estatica.",
  NAG_NEW = "Podría considerar la posibilidad de compartir sus datos para que otros puedan beneficiarse.",
  NAG_INSTRUCTIONS = "Teclee %h(/qh submit) para obtener instrucciones sobre la presentación de datos.",
  
  NAG_SINGLE_FP = "un maestro de vuelo",
  NAG_SINGLE_QUEST = "una misión",
  NAG_SINGLE_ROUTE = "una ruta de vuelo",
  NAG_SINGLE_ITEM_OBJ = "un elemento (objetivo)",
  NAG_SINGLE_OBJECT_OBJ = "un objeto (objetivo)",
  NAG_SINGLE_MONSTER_OBJ = "un monstruo (objetivo)",
  NAG_SINGLE_EVENT_OBJ = "un evento (objetivo)",
  NAG_SINGLE_REPUTATION_OBJ = "una reputación (objetivo)",
  NAG_SINGLE_PLAYER_OBJ = "un personaje (objetivo)",
  
  NAG_MULTIPLE_FP = "%1 maestros de vuelo",
  NAG_MULTIPLE_QUEST = "%1 misiones",
  NAG_MULTIPLE_ROUTE = "%1 rutas de vuelo",
  NAG_MULTIPLE_ITEM_OBJ = "%1 elementos (objetivo)",
  NAG_MULTIPLE_OBJECT_OBJ = "%1 objetivos (objetivo)",
  NAG_MULTIPLE_MONSTER_OBJ = "%1 monstruos (objetivo)",
  NAG_MULTIPLE_EVENT_OBJ = "%1 eventos (objetivo)",
  NAG_MULTIPLE_REPUTATION_OBJ = "%1 reputaciones (objetivo)",
  NAG_MULTIPLE_PLAYER_OBJ = "%1 objetivos del jugador",
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "Progreso de %1:",
  TRAVEL_ESTIMATE = "Tiempo estimado de viaje:",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "Visita %h1 de camino a:",
  FLIGHT_POINT = "Ruta de vuelo a %1.",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = "Click-Izquierdo: %1 informacion de Ruta.",
  QH_BUTTON_TOOLTIP2 = "Click-Derecho: Muestra menu de configuración.",
  QH_BUTTON_SHOW = "Mostrar",
  QH_BUTTON_HIDE = "Ocultar",

  MENU_CLOSE = "Cerrar Menu",
  MENU_SETTINGS = "Configuración",
  MENU_ENABLE = "Activar",
  MENU_DISABLE = "Desactivar",
  MENU_OBJECTIVE_TIPS = "%1 Consejos de la Misión",
  MENU_TRACKER_OPTIONS = "Rastreador de Misión",
  MENU_QUEST_TRACKER = "%1 Rastreador de Misión",
  MENU_TRACKER_LEVEL = "%1 Niveles de Misión",
  MENU_TRACKER_QCOLOUR = "%1 Colores de Dificultad de Misión",
  MENU_TRACKER_OCOLOUR = "%1 Colores Pregresivos de Objetivos",
  MENU_TRACKER_SCALE = "Escala del Rastreador",
  MENU_TRACKER_RESET = "Reiniciar Posición",
  MENU_FLIGHT_TIMER = "%1 Temporizador de Vuelo",
  MENU_ANT_TRAILS = "%1 Rastro de Hormigas",
  MENU_WAYPOINT_ARROW = "%1 Flecha (de Dirección)",
  MENU_MAP_BUTTON = "%1 Botón del Mapa",
  MENU_ZONE_FILTER = "%1 Filtro de zona",
  MENU_DONE_FILTER = "%1 Filtro Aplicado",
  MENU_BLOCKED_FILTER = "%1 Bloqueo de Filtro",
  MENU_WATCHED_FILTER = "%1 Filtro Mostrado",
  MENU_LEVEL_FILTER = "%1 Filtro de Nivel.",
  MENU_LEVEL_OFFSET = "Margen del Filtro de Nivel",
  MENU_ICON_SCALE = "Tamaño del Icono",
  MENU_FILTERS = "Filtros",
  MENU_PERFORMANCE = "Escala de la Carga de Trabajo de la Ruta",
  MENU_LOCALE = "Idioma",
  MENU_PARTY = "Grupo",
  MENU_PARTY_SHARE = "%1 Compartir Objetivo",
  MENU_PARTY_SOLO = "%1 Ignorar Grupo",
  MENU_HELP = "Ayuda",
  MENU_HELP_SLASH = "Comandos Slash",
  MENU_HELP_CHANGES = "Registro de cambios",
  MENU_HELP_SUBMIT = "Enviar Datos",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "Visto por QuestHelper",
  TOOLTIP_QUEST = "Para la Misión %h1.",
  TOOLTIP_PURCHASE = "Comprar %h1.",
  TOOLTIP_SLAY = "Matar para %h1.",
  TOOLTIP_LOOT = "Botín para %h1.",
  TOOLTIP_OPEN = nil,
  
  -- Settings
  SETTINGS_ARROWLINK_ON = "Se usará %h1 para mostrar objetivos",
  SETTINGS_ARROWLINK_OFF = "No se usará %h1 para mostrar objetivos.",
  SETTINGS_ARROWLINK_ARROW = "QuestHelper flecha",
  SETTINGS_ARROWLINK_CART = "coordenadas del Cartographer",
  SETTINGS_ARROWLINK_TOMTOM = "TomTom",
  SETTINGS_PRECACHE_ON = nil,
  SETTINGS_PRECACHE_OFF = nil,
  
  SETTINGS_MENU_ENABLE = "Activar",
  SETTINGS_MENU_DISABLE = "Desactivar",
  SETTINGS_MENU_CARTWP = nil,
  SETTINGS_MENU_TOMTOM = nil,
  
  SETTINGS_MENU_ARROW_LOCK = "Bloquear",
  SETTINGS_MENU_ARROW_ARROWSCALE = "Escala de flecha",
  SETTINGS_MENU_ARROW_TEXTSCALE = "Escala de texto",
  SETTINGS_MENU_ARROW_RESET = "Reiniciar",
  
  SETTINGS_MENU_INCOMPLETE = nil,
  
  SETTINGS_RADAR_ON = nil,
  SETTINGS_RADAR_OFF = nil,
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "%h1 yardas",
  DISTANCE_METRES = "%h1 metros"
 }

