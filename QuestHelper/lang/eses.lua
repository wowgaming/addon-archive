-- Please see enus.lua for reference.

QuestHelper_Translations.esES =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "Español",
  
  -- Messages used when starting.
  LOCALE_ERROR = "El idioma de su datos guardados no coincide con el idioma del cliente Wow. Para utilizar QuestHelper tendrá que cambiar la configuración regional de vuelta, o borrar los datos tecleando %h(/qh purge).",
  ZONE_LAYOUT_ERROR = "Me niego a ejecutarme, por temor a dañar sus datos guardados. Por favor, espere a un nuevo parche que será capaz de manejar el nuevo diseño de zona.",
  HOME_NOT_KNOWN = "Se desconoce la posición de su hogar. Cuando pueda, por favor, hable con su posadero para restaurarla.",
  PRIVATE_SERVER = "QuestHelper no soporta servidores privados.",
  PLEASE_RESTART = "Se ha producido un error al iniciar QuestHelper. Por favor, sal de completamente de World of Warcraft e inténtalo de nuevo.",
  NOT_UNZIPPED_CORRECTLY = "QuestHelper se instaló incorrectamente. Se recomienda usar Curse Client o 7zip para instalar. Aseguresé de que los subdirectorios son descomprimidos.",
  PLEASE_SUBMIT = "%h (¡QuestHelper necesita su ayuda! Si tiene unos pocos minutos, por favor dirijase a la página web de QuestHelper %h(http://www.questhelp.us) y siga las instrucciones para enviar sus datos. Sus datos mantienen QestHelper correctamente y actualizado. ¡Gracias!",
  HOW_TO_CONFIGURE = "QuestHelper no tiene aun una pagina de opciones, pero puede ser configurado escribiendo \"/qh settings\". Para más ayuda \"/qh help\"",
  TIME_TO_UPDATE = "Puede que haya una %h (nueva versión de QuestHelper) disponible . Las nuevas versiones suelen incluir nuevas funcionalidades, bases de datos y arreglan errores. ¡Por favor, actualice!",
  
  -- Route related text.
  ROUTES_CHANGED = "Las rutas de vuelo de su personaje han sido alteradas.",
  HOME_CHANGED = "Su hogar ha sido modificado.",
  TALK_TO_FLIGHT_MASTER = "Por favor, hable con el maestro de vuelo local.",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "Gracias.",
  WILL_RESET_PATH = "Se restablecerá la información de rutas.",
  UPDATING_ROUTE = "Actualizando ruta.",
  
  -- Special tracker text
  QH_LOADING = "Cargando QuestHelper (%1%%)...",
  QH_FLIGHTPATH = "Recalculando rutas de vuelo (%1%)...",
  QH_RECALCULATING = "Recalculando ruta(%1%)... ",
  QUESTS_HIDDEN_1 = "Puede haber misiones ocultas",
  QUESTS_HIDDEN_2 = "(\"/qh hidden\" para mostrarlas)",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "Idiomas Disponibles:",
  LOCALE_CHANGED = "Idioma cambiado a: %h1",
  LOCALE_UNKNOWN = "El Idioma %h1 es desconocido.",
  
  -- Words used for objectives.
  SLAY_VERB = "Matar",
  ACQUIRE_VERB = "Adquirir",
  
  OBJECTIVE_REASON = "%1 %h2 para la misión %h3.", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "%h1 para la misión %h2.",
  OBJECTIVE_REASON_TURNIN = "Regresa a la misión %h1.",
  OBJECTIVE_PURCHASE = "Compra de %h1.",
  OBJECTIVE_TALK = "Habla con %h1.",
  OBJECTIVE_SLAY = "Matar %h1.",
  OBJECTIVE_LOOT = "Recoger de %h1.",
  OBJECTIVE_OPEN = "Abrir %h1.",
  
  OBJECTIVE_MONSTER_UNKNOWN = "monstruo desconocido",
  OBJECTIVE_ITEM_UNKNOWN = "objeto desconocido",
  
  ZONE_BORDER_SIMPLE = "%1 frontera",
  
  -- Stuff used in objective menus.
  PRIORITY = "Prioridad",
  PRIORITY1 = "La más Alta",
  PRIORITY2 = "Alta",
  PRIORITY3 = "Normal",
  PRIORITY4 = "Baja",
  PRIORITY5 = "La más baja",
  SHARING = "Compartiendo",
  SHARING_ENABLE = "Compartir",
  SHARING_DISABLE = "No Compartir",
  IGNORE = "Ignorar",
  IGNORE_LOCATION = "Ignore esta posicion",
  
  IGNORED_PRIORITY_TITLE = "La prioridad seleccionada podria ser ignorada.",
  IGNORED_PRIORITY_FIX = "Aplique la misma prioridad a los objetivos de bloqueo.",
  IGNORED_PRIORITY_IGNORE = "Voy a fijarme las prioridades a mí mismo.",
  
  -- "/qh find"
  RESULTS_TITLE = "Resultados de la búsqueda",
  NO_RESULTS = "¡No hay ninguno!",
  CREATED_OBJ = "Creado: %1",
  REMOVED_OBJ = "Eliminado: %1",
  USER_OBJ = "Objetivo de Usuario: %h1",
  UNKNOWN_OBJ = "No sé dónde hay que ir para ese objetivo.",
  INACCESSIBLE_OBJ = "QuestHelper ha sido incapaz de encontrar la ubicación de %h1. Se ha añadido una ubicacion \"imposible de encontrar\" en tu lista de objetivos. Si encuentras una versión alternativa de este objeto, por favor, remítelo (%h(/qh submit))",
  FIND_REMOVE = "Cancelar objetivo",
  FIND_NOT_READY = "QuestHelper no a cargado todavia. Por favor espera un minuto e intentalo de nuevo",
  FIND_CUSTOM_LOCATION = "Localizacion personalizada del mapa",
  FIND_USAGE = "Find no funciona si no le dices que buscar. Prueba %h(/qh help) para instrucciones.",
  
  -- Shared objectives.
  PEER_TURNIN = "Espere a %h1 a que entregue %h2.",
  PEER_LOCATION = "Ayuda a %h1 a alcanzar un lugar en %h2.",
  PEER_ITEM = "Ayuda a %1 a adquirir %h2",
  PEER_OTHER = "Ayudar a %1 con %h2.",
  
  PEER_NEWER = "%h1 está utilizando una nueva versión de QuestHelper. Tal vez sea el momento de actualizarlo.",
  PEER_OLDER = "%h1 está utilizando una versión mas antigua del QuestHelper.",
  
  UNKNOWN_MESSAGE = "Tipo de mensaje desconocido '%1' desde '%2'.",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "Objetivos Ocultos",
  HIDDEN_NONE = "No tiene objetivos ocultos",
  DEPENDS_ON_SINGLE = "Depende de '%1'.",
  DEPENDS_ON_COUNT = "Depende de los objetivos ocultos %1.",
  DEPENDS_ON = "Depende de los objetivos filtrados",
  FILTERED_LEVEL = "Filtrado debido al nivel.",
  FILTERED_GROUP = "Filtrada debido a el tamaño del grupo.",
  FILTERED_ZONE = "Filtrado debido a la zona.",
  FILTERED_COMPLETE = "Filtrado debido a completados.",
  FILTERED_BLOCKED = "Filtrado debido al objetivo anterior incompleto",
  FILTERED_UNWATCHED = "Filtrado, debido a que no está traqueado en el log de quests",
  FILTERED_WINTERGRASP = "Filtrada por ser una quest PVP de Conquista del Invierno.",
  FILTERED_RAID = "Filtrada debido a no ser completada en una raid",
  FILTERED_USER = "Pidió que este objetivo se ocultara.",
  FILTERED_UNKNOWN = "Desconozco cómo completarlo.",
  
  HIDDEN_SHOW = "Mostrar.",
  HIDDEN_SHOW_NO = "No mostrable",
  HIDDEN_EXCEPTION = "Añade excepcion",
  DISABLE_FILTER = "Desactivar el filtro: %1",
  FILTER_DONE = "hecho",
  FILTER_ZONE = "zona",
  FILTER_LEVEL = "nivel",
  FILTER_BLOCKED = "bloqueado",
  FILTER_WATCHED = "mostrado",
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = "Marcar para añadir esta tarea a QuestHelper.",
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "Tiene %h(nueva información) sobre %h1, y %h(información actualizada) sobre %h2.",
  NAG_SINGLE_NEW = "Tiene %h(nueva información) sobre %h1.",
  NAG_ADDITIONAL = "Tiene %h(información adicional) sobre %h1.",
  NAG_POLLUTED = "Tu base de datos ha sido contaminada debido a un test o a un servidor privado, y será limpiada al reiniciar.",
  
  NAG_NOT_NEW = "No tiene ninguna información que no estén ya en la base de datos estáticos.",
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
  NAG_SINGLE_PLAYER_OBJ = "un jugador (objetivo)",
  
  NAG_MULTIPLE_FP = "%1 maestros de vuelo",
  NAG_MULTIPLE_QUEST = "%1 misiones",
  NAG_MULTIPLE_ROUTE = "%1 rutas de vuelo",
  NAG_MULTIPLE_ITEM_OBJ = "%1 elementos (objetivo)",
  NAG_MULTIPLE_OBJECT_OBJ = "%1 objetos (objetivo)",
  NAG_MULTIPLE_MONSTER_OBJ = "%1 monstruos (objetivo)",
  NAG_MULTIPLE_EVENT_OBJ = "%1 eventos (objetivo)",
  NAG_MULTIPLE_REPUTATION_OBJ = "%1 reputaciones (objetivo)",
  NAG_MULTIPLE_PLAYER_OBJ = "%1 objetivos del jugador",
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "Progreso de %1:",
  TRAVEL_ESTIMATE = "Tiempo estimado de viaje:",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "Visita %h1 de camino a:",
  FLIGHT_POINT = "punto de vuelo %1",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = "Click-Izquierdo: %1 informacion de Ruta.",
  QH_BUTTON_TOOLTIP2 = "Click-Derecho: Muestra menu de configuración.",
  QH_BUTTON_SHOW = "Mostrar",
  QH_BUTTON_HIDE = "Ocultar",

  MENU_CLOSE = "Cerrar Menu",
  MENU_SETTINGS = "Configuracion",
  MENU_ENABLE = "Activar",
  MENU_DISABLE = "Desactivar",
  MENU_OBJECTIVE_TIPS = "%1 Bocadillos de Misión",
  MENU_TRACKER_OPTIONS = "Rastreader de Misión",
  MENU_QUEST_TRACKER = "%1 Rastreador de Misión",
  MENU_TRACKER_LEVEL = "%1 Niveles de Misión",
  MENU_TRACKER_QCOLOUR = "%1 Colores Dificultad de Misión",
  MENU_TRACKER_OCOLOUR = "%1 Colores Progreso de Objetivo",
  MENU_TRACKER_SCALE = "Escala del Rastreador",
  MENU_TRACKER_RESET = "Reiniciar Posición",
  MENU_FLIGHT_TIMER = "%1 Temporizador de Vuelo",
  MENU_ANT_TRAILS = "%1 Rastro de Hormigas",
  MENU_WAYPOINT_ARROW = "%1 Flecha de Punto de Ruta",
  MENU_MAP_BUTTON = "%1 Botón del Mapa",
  MENU_ZONE_FILTER = "%1 Filtro de Zona",
  MENU_DONE_FILTER = "%1 Filtro de Hecho",
  MENU_BLOCKED_FILTER = "%1 Filtro de Bloqueado",
  MENU_WATCHED_FILTER = "%1 Vistos usando Filtración",
  MENU_LEVEL_FILTER = "%1 Filtro de Nivel",
  MENU_LEVEL_OFFSET = "Margen del Filtro de Nivel",
  MENU_ICON_SCALE = "Escala del Icono",
  MENU_FILTERS = "Filtros",
  MENU_PERFORMANCE = "Escala de Ruta de Trabajo",
  MENU_LOCALE = "Idioma",
  MENU_PARTY = "Grupo",
  MENU_PARTY_SHARE = "%1 Compartir Objetivo",
  MENU_PARTY_SOLO = "%1 Ignorar Grupo",
  MENU_HELP = "Ayuda",
  MENU_HELP_SLASH = "Comandos Slash",
  MENU_HELP_CHANGES = "Registro de Cambios",
  MENU_HELP_SUBMIT = "Enviar Datos",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "Visto por QuestHelper",
  TOOLTIP_QUEST = "Para Misión %h1.",
  TOOLTIP_PURCHASE = "Comprar %h1.",
  TOOLTIP_SLAY = "Matar para %h1.",
  TOOLTIP_LOOT = "Botín para %h1.",
  TOOLTIP_OPEN = "Abrir para %h1",
  
  -- Settings
  SETTINGS_ARROWLINK_ON = "Usara %h1 para mostrar objetivos.",
  SETTINGS_ARROWLINK_OFF = "No usara %h1 para mostrar objetivos.",
  SETTINGS_ARROWLINK_ARROW = "Flecha de QuestHelper",
  SETTINGS_ARROWLINK_CART = "Puntos de ruta de Cartographer",
  SETTINGS_ARROWLINK_TOMTOM = "TomTom",
  SETTINGS_PRECACHE_ON = "Precarga ha sido %h(activada).",
  SETTINGS_PRECACHE_OFF = "Precarga ha sido %h(desactivada).",
  
  SETTINGS_MENU_ENABLE = "Activar",
  SETTINGS_MENU_DISABLE = "Desactivar",
  SETTINGS_MENU_CARTWP = "Flecha de %1 cartógrafos",
  SETTINGS_MENU_TOMTOM = "Flecha de %1 TomTom",
  
  SETTINGS_MENU_ARROW_LOCK = "Bloquear",
  SETTINGS_MENU_ARROW_ARROWSCALE = "Escala de la flecha",
  SETTINGS_MENU_ARROW_TEXTSCALE = "Escala del texto",
  SETTINGS_MENU_ARROW_RESET = "Resetear",
  
  SETTINGS_MENU_INCOMPLETE = "Misiones Incompletas",
  
  SETTINGS_RADAR_ON = "Minimap radar conectado! (beep, beep, beep)",
  SETTINGS_RADAR_OFF = "Minimap radar desconectado. (whirrrrr, clunk)",
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "%h1 Yardas",
  DISTANCE_METRES = "%h1 Metros"
 }

