-- Please see enus.lua for reference.

QuestHelper_Translations.ptPT =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "Português",
  
  -- Messages used when starting.
  LOCALE_ERROR = "A localização dos seus dados (língua), não coincide com a localização desta instalação do WoW. Para usar o QuestHelper precisa de reverter para a localização original, ou apagar os dados escrevendo %h(/qh purge).",
  ZONE_LAYOUT_ERROR = "Recuso-me a trabalhar, com medo de corromper os seus dados guardados. Por favor aguarde por uma actualização que seja capaz de lidar com a nova estrutura da zona.",
  HOME_NOT_KNOWN = "O seu alojamento não é conhecido. Quando puder, fale com um hospedeiro de uma estalagem e reactive-o.",
  PRIVATE_SERVER = "O QuestHelper não suporta servidores privados.",
  PLEASE_RESTART = "Houve um erro ao iniciar o QuestHelper. Por favor saia totalmente do World of Warcraft e tente novamente. Se este problema se mantiver, pode mecessitar de reinstalar o QuestHelper.",
  NOT_UNZIPPED_CORRECTLY = "O QuestHelper foi instalado incorrectamente. Nós recomendamos o uso do Curse Client ou do 7zip para instalar. Reveja se as sub-directórias foram extraídas.",
  PLEASE_SUBMIT = "%h (QuestHelper precisa da sua ajuda!) Se você tiver alguns minutos, por favor vá até a Homepage do QuestHelper em %h (http://www.questhelp.us) e siga as instruções para apresentar os dados colhidos. Seus dados mantém o Quest Helper certo e atualizado. Obrigado!",
  HOW_TO_CONFIGURE = "O QuestHelper ainda não tem uma pagina de configuração funcional, mas pode ser configurado escrevendo %h(/qh settings). Ajuda está disponivel com %h(/qh help).",
  TIME_TO_UPDATE = "Poderá haver uma %h(nova versão do QuestHelper) disponivel. Novas versões normalmente incluem novas funcionalidades, nova base de dados para as quests, correcção de erros. Por favor actualize!",
  
  -- Route related text.
  ROUTES_CHANGED = "As rotas de voo para o seu personagem foram alteradas.",
  HOME_CHANGED = "O seu alojamento foi modificado.",
  TALK_TO_FLIGHT_MASTER = "Por favor fale com o mestre de voo.",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "Obrigado.",
  WILL_RESET_PATH = "Reescrevendo informação das rotas.",
  UPDATING_ROUTE = "Reescrevendo rota.",
  
  -- Special tracker text
  QH_LOADING = "QuestHelper está a carregar (%1%%)...",
  QH_FLIGHTPATH = "Recalculando caminhos aéreos (%1%)...",
  QH_RECALCULATING = nil,
  QUESTS_HIDDEN_1 = "Quests podem estar escondidas.",
  QUESTS_HIDDEN_2 = "(\"/qh hidden\" para listar(escondidas)",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "Localizações Disponíveis:",
  LOCALE_CHANGED = "Localização alterada para: %h1",
  LOCALE_UNKNOWN = "Localização %h1 não é conhecida.",
  
  -- Words used for objectives.
  SLAY_VERB = "Matar",
  ACQUIRE_VERB = "Obter",
  
  OBJECTIVE_REASON = "%1 %h2 para a missão %h3.", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "%h1 para a missão %h2.",
  OBJECTIVE_REASON_TURNIN = "Entregar a missão %h1.",
  OBJECTIVE_PURCHASE = "Aquirir de %h1.",
  OBJECTIVE_TALK = "Falar com %h1.",
  OBJECTIVE_SLAY = "Matar %h1.",
  OBJECTIVE_LOOT = "Pilhar %h1.",
  OBJECTIVE_OPEN = nil,
  
  OBJECTIVE_MONSTER_UNKNOWN = "monstro desconhecido",
  OBJECTIVE_ITEM_UNKNOWN = "Iten desconhecido",
  
  ZONE_BORDER_SIMPLE = "%1 borda",
  
  -- Stuff used in objective menus.
  PRIORITY = "Prioridade",
  PRIORITY1 = "Altíssima",
  PRIORITY2 = "Alta",
  PRIORITY3 = "Normal",
  PRIORITY4 = "Baixa",
  PRIORITY5 = "Baixíssima",
  SHARING = "Partilhando",
  SHARING_ENABLE = "Partilhar",
  SHARING_DISABLE = "Não Partilhar",
  IGNORE = "Ignorar",
  IGNORE_LOCATION = "Ignorar esta localização",
  
  IGNORED_PRIORITY_TITLE = "A prioridade seleccionada iria ser ignorada.",
  IGNORED_PRIORITY_FIX = "Aplicar a mesma prioridade aos objectivos sobrepostos.",
  IGNORED_PRIORITY_IGNORE = "Eu mesmo irei configurar as prioridades.",
  
  -- "/qh find"
  RESULTS_TITLE = "Resultados de procura",
  NO_RESULTS = "Não existe nada!",
  CREATED_OBJ = "Criado: %1",
  REMOVED_OBJ = "Removido: %1",
  USER_OBJ = "Objectivo do Personagem: %h1",
  UNKNOWN_OBJ = "Não sei para onde deve ir para esse objectivo.",
  INACCESSIBLE_OBJ = "O QuestHelper não foi capaz de encontrar uma localização útil para %h1. Nós adicionamos uma localização \"quase impossível de encontrar\" à sua lista de objectivos. Se encontrar uma versão útil deste objecto, por favor envie os seus dados!",
  FIND_REMOVE = nil,
  FIND_NOT_READY = "QuestHelper ainda não terminou de carregar. Por favor espere um minuto e tente outra vez.",
  FIND_CUSTOM_LOCATION = nil,
  FIND_USAGE = nil,
  
  -- Shared objectives.
  PEER_TURNIN = "Aguardar que %h1 entregue %h2.",
  PEER_LOCATION = "Ajudar %h1 a alcançar uma localização em %h2.",
  PEER_ITEM = "Ajudar %1 a obter %h2.",
  PEER_OTHER = "Acompanhar %1 com %h2.",
  
  PEER_NEWER = "%h1 está a usar uma nova versão de protocolo. Está na altura de actualizar o QuestHelper.",
  PEER_OLDER = "%h1 está a usar uma versão antiga de protocolo.",
  
  UNKNOWN_MESSAGE = "Tipo de mensagem desconhecido '%1' de '%2'.",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "Objectivos Ocultos",
  HIDDEN_NONE = "Não existem objectivos ocultos de si.",
  DEPENDS_ON_SINGLE = "Depende de '%1'.",
  DEPENDS_ON_COUNT = "Depende de %1 objectivos ocultos.",
  DEPENDS_ON = "Depende de objectivos filtrados",
  FILTERED_LEVEL = "Filtrado devido ao nível.",
  FILTERED_GROUP = "Filtrado por causa do tamanho de grupo.",
  FILTERED_ZONE = "Filtrado devido à zona.",
  FILTERED_COMPLETE = "Filtrado pois está completo.",
  FILTERED_BLOCKED = "Filtrado devido a um objectivo anterior incompleto.",
  FILTERED_UNWATCHED = "Filtrado por não estar a ser monitorizado pelo Quest Log",
  FILTERED_WINTERGRASP = "Filtrado por ser uma Quest PvP Wintergrasp",
  FILTERED_RAID = nil,
  FILTERED_USER = "Pediu para esconder este objectivo.",
  FILTERED_UNKNOWN = "Não sei como se completa.",
  
  HIDDEN_SHOW = "Mostrar.",
  HIDDEN_SHOW_NO = "Escondido",
  HIDDEN_EXCEPTION = "Adicionar exepção",
  DISABLE_FILTER = "Desligar filtro: %1",
  FILTER_DONE = "terminado",
  FILTER_ZONE = "zona",
  FILTER_LEVEL = "nível",
  FILTER_BLOCKED = "bloqueado",
  FILTER_WATCHED = "vigiado",
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = nil,
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "Tem %h(nova informação) sobre %h1, e %h(informação actualizada) sobre %h2.",
  NAG_SINGLE_NEW = "Tem %h(nova informação) em %h1.",
  NAG_ADDITIONAL = "Tem %h(informação adicional) sobre %h1.",
  NAG_POLLUTED = "A sua base de dados foi poluida por informação de um servidor privado ou de testes, e será apagada ao reiniciar.",
  
  NAG_NOT_NEW = "Não possui nenhuma informação que ainda não exista na base de dados estática.",
  NAG_NEW = "Deverá considerar partilhar os seus dados, de modo a que outros deles possam beneficiar.",
  NAG_INSTRUCTIONS = "Escreva %h(/qh submit) para instruções de como submeter os dados.",
  
  NAG_SINGLE_FP = "um mestre de voo",
  NAG_SINGLE_QUEST = "uma missão",
  NAG_SINGLE_ROUTE = "uma rota de voo",
  NAG_SINGLE_ITEM_OBJ = "um objectivo de item",
  NAG_SINGLE_OBJECT_OBJ = "um objectivo de objecto",
  NAG_SINGLE_MONSTER_OBJ = "um objectivo de monstro",
  NAG_SINGLE_EVENT_OBJ = "um objectivo de evento",
  NAG_SINGLE_REPUTATION_OBJ = "um objectivo de reputação",
  NAG_SINGLE_PLAYER_OBJ = "um objectivo do jogador",
  
  NAG_MULTIPLE_FP = "%1 mestres de voo",
  NAG_MULTIPLE_QUEST = "%1 missões",
  NAG_MULTIPLE_ROUTE = "%1 rotas de voo",
  NAG_MULTIPLE_ITEM_OBJ = "%1 objectivos de itens",
  NAG_MULTIPLE_OBJECT_OBJ = "%1 objectivos de objectos",
  NAG_MULTIPLE_MONSTER_OBJ = "%1 objectivos de monstros",
  NAG_MULTIPLE_EVENT_OBJ = "%1 objectivos de eventos",
  NAG_MULTIPLE_REPUTATION_OBJ = "%1 objectivos para reputação",
  NAG_MULTIPLE_PLAYER_OBJ = "%1 objectivos de jogadores",
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "%1 progresso:",
  TRAVEL_ESTIMATE = "Tempo estimado de viagem:",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "Visitar %h1 em caminho para:",
  FLIGHT_POINT = "%1 Ponto de voo",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = "Clique Esquerdo: %1 informação de rotas.",
  QH_BUTTON_TOOLTIP2 = "Clique Direito: Mostrar menu de Opções.",
  QH_BUTTON_SHOW = "Mostar",
  QH_BUTTON_HIDE = "Ocultar",

  MENU_CLOSE = "Fechar Menu",
  MENU_SETTINGS = "Opções",
  MENU_ENABLE = "Ligar",
  MENU_DISABLE = "Desligar",
  MENU_OBJECTIVE_TIPS = "%1 Dicas nos Objectivos",
  MENU_TRACKER_OPTIONS = "Monitor de Missões",
  MENU_QUEST_TRACKER = "%1 Monitor de Missões",
  MENU_TRACKER_LEVEL = "%1 Níveis das Missões",
  MENU_TRACKER_QCOLOUR = "%1 Cor da Dificuldade das Missões",
  MENU_TRACKER_OCOLOUR = "%1 Cor do Progresso nas Missões",
  MENU_TRACKER_SCALE = "Escala do Monitor",
  MENU_TRACKER_RESET = "Restaurar Posição",
  MENU_FLIGHT_TIMER = "%1 Tempo de Voo",
  MENU_ANT_TRAILS = "%1 Linhas Tracejadas",
  MENU_WAYPOINT_ARROW = "%1 Seta de Direcção",
  MENU_MAP_BUTTON = "%1 Botão no Mapa",
  MENU_ZONE_FILTER = "%1 Filtro de Zona",
  MENU_DONE_FILTER = "%1 Filtro de Termidadas",
  MENU_BLOCKED_FILTER = "%1 Filtro de Bloqueadas",
  MENU_WATCHED_FILTER = "%1 Filtros Vigiados",
  MENU_LEVEL_FILTER = "%1 Filtro de Nível",
  MENU_LEVEL_OFFSET = "Margem do Filtro de Nível",
  MENU_ICON_SCALE = "Escala dos Icones",
  MENU_FILTERS = "Filtros",
  MENU_PERFORMANCE = "Esforço ao Traçar Rotas",
  MENU_LOCALE = "Local",
  MENU_PARTY = "Grupo",
  MENU_PARTY_SHARE = "%1 Partilha de Objectivos",
  MENU_PARTY_SOLO = "%1 Ignorar Grupo",
  MENU_HELP = "Ajuda",
  MENU_HELP_SLASH = "Comandos de Barra",
  MENU_HELP_CHANGES = "Lista de Alterações",
  MENU_HELP_SUBMIT = "Submetendo Dados",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "Monitorado pelo QuestHelper",
  TOOLTIP_QUEST = "Para a Missão %h1.",
  TOOLTIP_PURCHASE = "Adquirir %h1.",
  TOOLTIP_SLAY = "Matar para %h1.",
  TOOLTIP_LOOT = "Pilhar por %h1.",
  TOOLTIP_OPEN = nil,
  
  -- Settings
  SETTINGS_ARROWLINK_ON = "Usar %h1 para mostar os objectivos",
  SETTINGS_ARROWLINK_OFF = "Não usar %h1 para mostar os objectivos",
  SETTINGS_ARROWLINK_ARROW = "Seta do Questhelper",
  SETTINGS_ARROWLINK_CART = "Pontos Chave do Cartographer",
  SETTINGS_ARROWLINK_TOMTOM = "TomTom",
  SETTINGS_PRECACHE_ON = "Precache foi %h (activado)",
  SETTINGS_PRECACHE_OFF = "Precache foi %h (desactivado)",
  
  SETTINGS_MENU_ENABLE = "Ligado",
  SETTINGS_MENU_DISABLE = "Desligado",
  SETTINGS_MENU_CARTWP = "%1 Seta Cartographer",
  SETTINGS_MENU_TOMTOM = "%1 Seta TomTom",
  
  SETTINGS_MENU_ARROW_LOCK = "Travar",
  SETTINGS_MENU_ARROW_ARROWSCALE = "Tamanho da Seta",
  SETTINGS_MENU_ARROW_TEXTSCALE = "Tamanho do Texto",
  SETTINGS_MENU_ARROW_RESET = "Reiniciar",
  
  SETTINGS_MENU_INCOMPLETE = nil,
  
  SETTINGS_RADAR_ON = nil,
  SETTINGS_RADAR_OFF = nil,
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "%h1 jardas de distância",
  DISTANCE_METRES = "%h1 metros de distância"
 }

