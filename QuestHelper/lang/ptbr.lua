-- Please see enus.lua for reference.

QuestHelper_Translations.ptBR =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "Português",
  
  -- Messages used when starting.
  LOCALE_ERROR = "O idioma que você salvou seus dados não são compatíveis com o idioma do seu cliente do WoW. Para usar o QuestHelper você precisará voltar o idioma, ou deletar os dados digitando %h(/qh purge).",
  ZONE_LAYOUT_ERROR = "Sua versão do QuestHelper está desatualizada, e você terá que atualizar em http://www.questhelp.us para que ela continue a funcionar. Você está usando atualmente a versão %1.",
  HOME_NOT_KNOWN = "A sua casa é desconhecida. Quando tiver uma chance, por favor, fale com um dono de taberna e resete-a.",
  PRIVATE_SERVER = "QuestHelper não suporta servidores privados.",
  PLEASE_RESTART = "Ocorreu um erro ao iniciar o QuestHelper. Por favor feche completamente o World of Warcraft e tente de novo.",
  NOT_UNZIPPED_CORRECTLY = "QuestHelper foi instalado incorretamente. Recomendamos que use o Curse Cliente ou 7zip para instalar. Verifica se as subpastas foram extraidas.",
  PLEASE_SUBMIT = "%h(QuestHelper precisa da sua ajuda!) Se você possui alguns minutos, por favor vá a página do QuestHelper em %h(http:http://www.questhelp.us) e siga as instruções para submeter os dados coletados. Os seus dados mantém o QuestHelper correto e atualizado.",
  HOW_TO_CONFIGURE = "O QuestHelper ainda não tem uma página de configurações funcionando, mas pode ser configurado digitando %h (/qh settings). A ajuda está disponível através de %h(/qh help). ",
  TIME_TO_UPDATE = "Pode haver uma %h disponível. Novas versões normalmente incluem novas características, novo banco de dados de quest, e erros concertados. Por favor, atualize!",
  
  -- Route related text.
  ROUTES_CHANGED = "As rotas de vôo para o seu personagem foram alteradas.",
  HOME_CHANGED = "A sua casa mudou.",
  TALK_TO_FLIGHT_MASTER = "Por favor fale com o mestre de vôo local.",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "Obrigado.",
  WILL_RESET_PATH = "Irá resetar a informação do caminho.",
  UPDATING_ROUTE = "Atualizando rotas.",
  
  -- Special tracker text
  QH_LOADING = "QuestHelper está carregando (%1%%)...",
  QH_FLIGHTPATH = "Recalculando pontos de vôo",
  QH_RECALCULATING = nil,
  QUESTS_HIDDEN_1 = "Quests podem estar escondida.",
  QUESTS_HIDDEN_2 = "(\"/qh hidden\" para listar(quests escondidas)",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "Idiomas disponíveis: ",
  LOCALE_CHANGED = "Idioma alterado para: %h1",
  LOCALE_UNKNOWN = "Idioma %1 desconhecido.",
  
  -- Words used for objectives.
  SLAY_VERB = "Mate",
  ACQUIRE_VERB = "Adquirir",
  
  OBJECTIVE_REASON = "%1 %h2 para a quest %h3.", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "%h1 para a quest %h2.",
  OBJECTIVE_REASON_TURNIN = "Complete a quest %h1.",
  OBJECTIVE_PURCHASE = "Comprado de %h1.",
  OBJECTIVE_TALK = "Fale com %h1.",
  OBJECTIVE_SLAY = "Mate %h1.",
  OBJECTIVE_LOOT = "Loot %1.",
  OBJECTIVE_OPEN = nil,
  
  OBJECTIVE_MONSTER_UNKNOWN = "Monstro Desconhecido",
  OBJECTIVE_ITEM_UNKNOWN = "Item desconhecido",
  
  ZONE_BORDER_SIMPLE = "%1 borda",
  
  -- Stuff used in objective menus.
  PRIORITY = "Prioridade",
  PRIORITY1 = "Mais alta",
  PRIORITY2 = "Alta",
  PRIORITY3 = "Normal",
  PRIORITY4 = "Baixa",
  PRIORITY5 = "Mais baixa",
  SHARING = "Compartilhando",
  SHARING_ENABLE = "Compartilhar",
  SHARING_DISABLE = "Não compartilhar",
  IGNORE = "Ignore",
  IGNORE_LOCATION = "Ignorar esta localização",
  
  IGNORED_PRIORITY_TITLE = "A prioridade seleccionada será ignorada.",
  IGNORED_PRIORITY_FIX = "Aplique a mesma prioridade aos objectivos bloqueados.",
  IGNORED_PRIORITY_IGNORE = "Eu mesmo irei definir as prioridades.",
  
  -- "/qh find"
  RESULTS_TITLE = "Resultados da busca",
  NO_RESULTS = "Não existe nenhum!",
  CREATED_OBJ = "Criado: %1",
  REMOVED_OBJ = "Removido: %1",
  USER_OBJ = "Objetivo do usuário: %h1",
  UNKNOWN_OBJ = "Eu não sei onde você deve ir para este objetivo.",
  INACCESSIBLE_OBJ = "QuestHelper não conseguiu encontrar a correcta localização para %h1. Foi adicionado uma \"provavelmente-impossível-de-encontrar\" localização á sua lista de objectivos. Se encontrar ",
  FIND_REMOVE = nil,
  FIND_NOT_READY = nil,
  FIND_CUSTOM_LOCATION = nil,
  FIND_USAGE = nil,
  
  -- Shared objectives.
  PEER_TURNIN = "Espere por %h1 para completar em %h2.",
  PEER_LOCATION = "Ajude %h1 a chegar no lugar  em %h2.",
  PEER_ITEM = "Ajude %1 a adquirir %h2.",
  PEER_OTHER = "Ajude %1 com %h2.",
  
  PEER_NEWER = "%h1 está usando um protocolo mais novo. Talvez seja hora de atualizar.",
  PEER_OLDER = "%1 está usando um protocolo antigo.",
  
  UNKNOWN_MESSAGE = "Mensagem desconhecida tipo '%1' de '%2'.",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "Objectivos Escondidos",
  HIDDEN_NONE = "Não existem objectivos escondidos.",
  DEPENDS_ON_SINGLE = "Depende de '%1'.",
  DEPENDS_ON_COUNT = "Depende de %1 objetivos ocultos.",
  DEPENDS_ON = "Depende de objetos filtrados",
  FILTERED_LEVEL = "Filtrado por causa do nível.",
  FILTERED_GROUP = "Filtrado graças ao tamanho do grupo.",
  FILTERED_ZONE = "Filtrado por causa da zona.",
  FILTERED_COMPLETE = "Filtrado porque está completo.",
  FILTERED_BLOCKED = "Filtrado por causa de um objetivo anterior incompleto",
  FILTERED_UNWATCHED = "Filtrado por não ter sido Roteado no Quest Log ",
  FILTERED_WINTERGRASP = "Filtrado por ser uma quest de PvP em Wintergrasp.",
  FILTERED_RAID = "Filtrado devido a não poder ser completo num raid.",
  FILTERED_USER = "Você requisitou que este objectivo fosse escondido.",
  FILTERED_UNKNOWN = "Não sei como completar.",
  
  HIDDEN_SHOW = "Exibir.",
  HIDDEN_SHOW_NO = "Não mostravél",
  HIDDEN_EXCEPTION = "Adicionar excepção",
  DISABLE_FILTER = "Filtro desactivado: %1",
  FILTER_DONE = "concluído",
  FILTER_ZONE = "zona",
  FILTER_LEVEL = "level",
  FILTER_BLOCKED = "bloqueado",
  FILTER_WATCHED = "vigiado",
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = nil,
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "Você tem %h(novas informações) em %h1, e %h(informações atualizadas) em %h2.",
  NAG_SINGLE_NEW = "Você tem %h(novas informações) em %h1.",
  NAG_ADDITIONAL = "Você tem %h(informações adicionais) em %h1.",
  NAG_POLLUTED = "A sua Base de dados foi corrompida com informação de um servidor privado ou de teste, e será apagada ao iniciar.",
  
  NAG_NOT_NEW = "Não tem nenhuma informação que não exista no banco de dados estático.",
  NAG_NEW = "Deve considerar compartilhar os seus dados para que outros possam beneficiar.",
  NAG_INSTRUCTIONS = "Digite %h(/qh submit) para instruções em como enviar os dados.",
  
  NAG_SINGLE_FP = "um mestre de vôo",
  NAG_SINGLE_QUEST = "uma quest",
  NAG_SINGLE_ROUTE = "uma rota de vôo",
  NAG_SINGLE_ITEM_OBJ = "um item de objetivo",
  NAG_SINGLE_OBJECT_OBJ = "um objeto de objetivo",
  NAG_SINGLE_MONSTER_OBJ = "um monstro de objetivo",
  NAG_SINGLE_EVENT_OBJ = "um evento de objetivo",
  NAG_SINGLE_REPUTATION_OBJ = "uma reputação de objetivo",
  NAG_SINGLE_PLAYER_OBJ = "objectivo de jogador",
  
  NAG_MULTIPLE_FP = "%1 mestres de vôo",
  NAG_MULTIPLE_QUEST = "%1 quests",
  NAG_MULTIPLE_ROUTE = "%1 rotas de vôo",
  NAG_MULTIPLE_ITEM_OBJ = "%1 itens (objetivo)",
  NAG_MULTIPLE_OBJECT_OBJ = "%1 objetos (objetivo)",
  NAG_MULTIPLE_MONSTER_OBJ = "%1 monstros (objetivo)",
  NAG_MULTIPLE_EVENT_OBJ = "%1 Eventos (objetivo)",
  NAG_MULTIPLE_REPUTATION_OBJ = "%1 reputação (objetivo)",
  NAG_MULTIPLE_PLAYER_OBJ = "%1 jogador (objetivo)",
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "Progresso do %1:",
  TRAVEL_ESTIMATE = "Tempo de vôo estimado:",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "Visite %h1 para a rota até:",
  FLIGHT_POINT = "Ponto de vôo",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = "Botão esquerdo: %1 informações da rota.",
  QH_BUTTON_TOOLTIP2 = "Botão direito: Exibir o menu de opções.",
  QH_BUTTON_SHOW = "Exibir",
  QH_BUTTON_HIDE = "Esconder",

  MENU_CLOSE = "Fechar menu",
  MENU_SETTINGS = "Opções",
  MENU_ENABLE = "Ativado",
  MENU_DISABLE = "Desativado",
  MENU_OBJECTIVE_TIPS = "%1 Dicas de Objetivos",
  MENU_TRACKER_OPTIONS = "Roteador de Quest",
  MENU_QUEST_TRACKER = "%1 Roteador de Quest",
  MENU_TRACKER_LEVEL = "%1 Levels de Quest",
  MENU_TRACKER_QCOLOUR = "%1 Cores de dificuldade das Quests.",
  MENU_TRACKER_OCOLOUR = "%1 Cores de progresso do objetivo",
  MENU_TRACKER_SCALE = "Escala do Roteador",
  MENU_TRACKER_RESET = "Resetar Posição",
  MENU_FLIGHT_TIMER = "%1 Tempo de vôo",
  MENU_ANT_TRAILS = "%1 rastro de formigas",
  MENU_WAYPOINT_ARROW = "%1 Seta de caminho",
  MENU_MAP_BUTTON = "%1 Botão mapa",
  MENU_ZONE_FILTER = "%1 Filtro da zona",
  MENU_DONE_FILTER = "%1 filtro feito",
  MENU_BLOCKED_FILTER = "%1 filtro bloqueado",
  MENU_WATCHED_FILTER = "%1 Filtro de Observação",
  MENU_LEVEL_FILTER = "%1 Filtro de nível",
  MENU_LEVEL_OFFSET = "Margem do filtro de level",
  MENU_ICON_SCALE = "Escala do ícone",
  MENU_FILTERS = "Filtros",
  MENU_PERFORMANCE = "Escala da carga de trabalho da rota",
  MENU_LOCALE = "Idioma",
  MENU_PARTY = "Grupo",
  MENU_PARTY_SHARE = "%1 Compartilhamento de Objetivo",
  MENU_PARTY_SOLO = "%1 Ignorar Grupo",
  MENU_HELP = "Ajuda",
  MENU_HELP_SLASH = "Atalhos",
  MENU_HELP_CHANGES = "Log de mudanças",
  MENU_HELP_SUBMIT = "Enviando dados",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "Observado por QuestHelper",
  TOOLTIP_QUEST = "Para Quest %h1.",
  TOOLTIP_PURCHASE = "Compre %h1.",
  TOOLTIP_SLAY = "Mate para %h1.",
  TOOLTIP_LOOT = "Loot para %h1.",
  TOOLTIP_OPEN = nil,
  
  -- Settings
  SETTINGS_ARROWLINK_ON = "Usará %h1 para mostrar objetivos.",
  SETTINGS_ARROWLINK_OFF = "Não usará %h1 para mostrar objetivos.",
  SETTINGS_ARROWLINK_ARROW = "Seta QuestHelper",
  SETTINGS_ARROWLINK_CART = "Cartographer Waypoints",
  SETTINGS_ARROWLINK_TOMTOM = "TomTom",
  SETTINGS_PRECACHE_ON = "Prechache foi %h (ativado).",
  SETTINGS_PRECACHE_OFF = "Precache foi %h (desativado).",
  
  SETTINGS_MENU_ENABLE = "Abilitado",
  SETTINGS_MENU_DISABLE = "Desabilidado",
  SETTINGS_MENU_CARTWP = "%1 Seta Cartographer",
  SETTINGS_MENU_TOMTOM = "%1 Seta TomTom",
  
  SETTINGS_MENU_ARROW_LOCK = "Travar",
  SETTINGS_MENU_ARROW_ARROWSCALE = "Tamanho da Seta",
  SETTINGS_MENU_ARROW_TEXTSCALE = "Tamanho do Texto",
  SETTINGS_MENU_ARROW_RESET = "Ressetar",
  
  SETTINGS_MENU_INCOMPLETE = nil,
  
  SETTINGS_RADAR_ON = nil,
  SETTINGS_RADAR_OFF = nil,
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "%h1 jardas",
  DISTANCE_METRES = "%h1 metros"
 }

