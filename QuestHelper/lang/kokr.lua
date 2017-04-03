-- Please see enus.lua for reference.

QuestHelper_Translations.koKR =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "한국어",
  
  -- Messages used when starting.
  LOCALE_ERROR = "저장된 데이터의 지역화 언어가 WoW 클라이언트의 지역과 맞지 않습니다. QuestHelper를 사용하려면 지역화 언어를 되돌리거나 %h(/qh purge)를 입력하여 데이터를 지울 필요가 있습니다.",
  ZONE_LAYOUT_ERROR = "저장된 데이터와 충돌의 위험이 있기 때문에 애드온을 실행하지 않습니다. 새로운 지역을 처리할 수 있는 패치가 나올 때까지 기다려 주세요.",
  HOME_NOT_KNOWN = "귀환 장소를 알 수 없습니다. 기회가 될 때, 여관주인에게 말을 걸어 재설정하세요.",
  PRIVATE_SERVER = "QuestHelper는 해적서버를 지원하지 않습니다.",
  PLEASE_RESTART = "QuestHelper를 시작하지 못했습니다. 월드 오브 워크래프트를 완전히 종료하고 다시 시도하세요.",
  NOT_UNZIPPED_CORRECTLY = "QuestHelper가 제대로 설치되지 않았습니다. Curse 클라이언트나 7zip을 이용한 설치를 권장합니다. 하위 폴더가 설치되었는지 확인하세요.",
  PLEASE_SUBMIT = nil,
  HOW_TO_CONFIGURE = "QuestHelper는 아직 설정 페이지가 없지만, %h(/qh settings)를 입력창에 입력하여 설정할 수 있습니다. 도움말은 %h(/qh help)를 입력하세요.",
  TIME_TO_UPDATE = "새로운 %h 버전이 업데이트 되었습니다. 새 버전에서는 보통 새로운 모습, 추가된 퀘스트 그리고 버그가 수정됩니다. 업데이트 하세요!",
  
  -- Route related text.
  ROUTES_CHANGED = "당신의 비행 경로가 변경되었습니다.",
  HOME_CHANGED = "귀환 장소가 변경되었습니다.",
  TALK_TO_FLIGHT_MASTER = "이 지역의 비행 조련사와 대화하세요.",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "완료",
  WILL_RESET_PATH = "이동 정보가 재설정 됩니다.",
  UPDATING_ROUTE = "경로 재설정",
  
  -- Special tracker text
  QH_LOADING = "QuestHelper를 불러오는 중 (%1%%)...",
  QH_FLIGHTPATH = "비행 경로 재계산중 (%1%)...",
  QH_RECALCULATING = nil,
  QUESTS_HIDDEN_1 = "감춰둔 퀘스트가 있을 지 모름",
  QUESTS_HIDDEN_2 = "(목록은 \"/qh hidden\")",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "사용 가능한 지역화 언어:",
  LOCALE_CHANGED = "지역화 언어 변경됨: %h1",
  LOCALE_UNKNOWN = "지역화 언어 %h1|1을;를; 찾을 수 없음.",
  
  -- Words used for objectives.
  SLAY_VERB = "처치",
  ACQUIRE_VERB = "획득",
  
  OBJECTIVE_REASON = "%h3 퀘스트 - %h2 %1", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "%h2 퀘스트 - %h1",
  OBJECTIVE_REASON_TURNIN = "%h1 퀘스트.",
  OBJECTIVE_PURCHASE = "%h1|1으로;로;부터 구입하라.",
  OBJECTIVE_TALK = "%h1|1과;와; 대화하라.",
  OBJECTIVE_SLAY = "%h1|1을;를; 처치하라.",
  OBJECTIVE_LOOT = "%h1|1을;를; 획득하라.",
  OBJECTIVE_OPEN = nil,
  
  OBJECTIVE_MONSTER_UNKNOWN = "알 수 없는 몬스터",
  OBJECTIVE_ITEM_UNKNOWN = "알 수 없는 아이템",
  
  ZONE_BORDER_SIMPLE = nil,
  
  -- Stuff used in objective menus.
  PRIORITY = "중요도",
  PRIORITY1 = "매우 높음",
  PRIORITY2 = "높음",
  PRIORITY3 = "보통",
  PRIORITY4 = "낮음",
  PRIORITY5 = "매우 낮음",
  SHARING = "공유",
  SHARING_ENABLE = "공유함",
  SHARING_DISABLE = "공유 안함",
  IGNORE = "무시",
  IGNORE_LOCATION = "이 지역은 무시",
  
  IGNORED_PRIORITY_TITLE = "선택된 중요도는 무시될 것입니다.",
  IGNORED_PRIORITY_FIX = "차단된 퀘스트에 동일한 중요도를 적용하세요.",
  IGNORED_PRIORITY_IGNORE = "나는 나 스스로 중요도를 설정 할 것입니다.",
  
  -- "/qh find"
  RESULTS_TITLE = "검색 결과",
  NO_RESULTS = "결과를 찾을 수 없습니다!",
  CREATED_OBJ = "생성: %1",
  REMOVED_OBJ = "삭제: %1",
  USER_OBJ = "사용자 목적: %h1",
  UNKNOWN_OBJ = "목적 달성을 위해 어디로 가야하는지 알 수 없습니다.",
  INACCESSIBLE_OBJ = "QuestHelper는 %h1의 위치를 찾지 못했습니다. 우리는 가장 가능성 있는 위치를 목표에 추가했습니다. 만약 이 목표에 대해 정확한 정보를 알고 계시다면 당신의 데이터를 보내주세요! %h(/qh submit))",
  FIND_REMOVE = nil,
  FIND_NOT_READY = nil,
  FIND_CUSTOM_LOCATION = nil,
  FIND_USAGE = nil,
  
  -- Shared objectives.
  PEER_TURNIN = "%h2|1을;를; 진행하기 위해 %h1|1을;를; 기다리세요.",
  PEER_LOCATION = "%h1|1을;를; 도와 %h2|1으로;로; 이동하라.",
  PEER_ITEM = "%1|1을;를; 도와 %h2|1을;를; 획득하라.",
  PEER_OTHER = "%1|1과;와; 함께 %h2|1을;를; 도와라.",
  
  PEER_NEWER = "%h1|1은;는; 새로운 프로토콜 버전을 사용하였습니다. 업그레이드할 때가 되었습니다.",
  PEER_OLDER = "%h1|1은;는; 오래된 프로토콜 버전을 사용하였습니다.",
  
  UNKNOWN_MESSAGE = "'%2'|1으로;로;부터 받은 '%1'|1은;는; 알 수 없는 메세지 타입.",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "감춘 퀘스트",
  HIDDEN_NONE = "감춰둔 퀘스트가 없습니다.",
  DEPENDS_ON_SINGLE = "'%1'에 의존함.",
  DEPENDS_ON_COUNT = "%1은 감춘 목적에 의존함.",
  DEPENDS_ON = "분류된 목적에 의존함.",
  FILTERED_LEVEL = "레벨에 따라 분류됨.",
  FILTERED_GROUP = "그룹 크기에 따라 분류됨.",
  FILTERED_ZONE = "지역에 따라 분류됨.",
  FILTERED_COMPLETE = "완성도에 따라 분류됨.",
  FILTERED_BLOCKED = "이전 퀘스트를 달성하지 못해 분류됨.",
  FILTERED_UNWATCHED = "퀘스트 목록에 추적되지 않아 분류됨.",
  FILTERED_WINTERGRASP = "겨울손아귀 PvP 퀘스트에 의해 분류됨.",
  FILTERED_RAID = nil,
  FILTERED_USER = "당신의 요청에 의해 이 퀘스트는 감춰짐.",
  FILTERED_UNKNOWN = "완료 방법을 알 수 없음.",
  
  HIDDEN_SHOW = "보기.",
  HIDDEN_SHOW_NO = "보지 않기",
  HIDDEN_EXCEPTION = "예외 추가",
  DISABLE_FILTER = "분류 비활성화: %1",
  FILTER_DONE = "완료",
  FILTER_ZONE = "지역",
  FILTER_LEVEL = "레벨",
  FILTER_BLOCKED = "차단됨",
  FILTER_WATCHED = "추적됨",
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = nil,
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "%h1|1과;와; %h2의 정보 그리고, %h(%s3)지역의 정보를 갱신하였습니다.",
  NAG_SINGLE_NEW = "당신은 %h(새로운 정보)를 %h1에게서 얻었습니다.",
  NAG_ADDITIONAL = "당신은 %h(추가적인 정보)를 %h1에게서 얻었습니다.",
  NAG_POLLUTED = "당신의 데이터베이스는 테스트 또는 개인 서버의 정보로부터 오염되었습니다. 그리고 시작 시 제거될 것입니다.",
  
  NAG_NOT_NEW = "당신의 전역 데이터베이스에 어떠한 정보도 가지고 있지 않습니다.",
  NAG_NEW = "다른 사람에게 도움이 될 지도 모르니 당신의 데이터 공유를 고려해 보십시오.",
  NAG_INSTRUCTIONS = "%h(/qh submit)을 입력하여 데이터를 보내는 방법을 알아보세요.",
  
  NAG_SINGLE_FP = "비행 조련사",
  NAG_SINGLE_QUEST = "퀘스트",
  NAG_SINGLE_ROUTE = "비행 경로",
  NAG_SINGLE_ITEM_OBJ = "목표 아이템",
  NAG_SINGLE_OBJECT_OBJ = "목표 목적",
  NAG_SINGLE_MONSTER_OBJ = "목표 몬스터",
  NAG_SINGLE_EVENT_OBJ = "목표 이벤트",
  NAG_SINGLE_REPUTATION_OBJ = "목표 평판",
  NAG_SINGLE_PLAYER_OBJ = "목표 플레이어",
  
  NAG_MULTIPLE_FP = "비행 조련사 %1",
  NAG_MULTIPLE_QUEST = "퀘스트 %1",
  NAG_MULTIPLE_ROUTE = "비행 경로 %1",
  NAG_MULTIPLE_ITEM_OBJ = "목표 아이템 %1",
  NAG_MULTIPLE_OBJECT_OBJ = "목표 목적 %1",
  NAG_MULTIPLE_MONSTER_OBJ = "목표 몬스터 %1",
  NAG_MULTIPLE_EVENT_OBJ = "목표 이벤트 %1",
  NAG_MULTIPLE_REPUTATION_OBJ = "목표 평판 %1",
  NAG_MULTIPLE_PLAYER_OBJ = "목표 플레이어 %1",
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "%1의 진행상황:",
  TRAVEL_ESTIMATE = "예상 이동 시간:",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "다음 경유 장소 %h1 방문:",
  FLIGHT_POINT = "%1 비행 지점",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = "좌-클릭: 경로 정보 %1.",
  QH_BUTTON_TOOLTIP2 = "우-클릭: 설정 메뉴 표시.",
  QH_BUTTON_SHOW = "표시",
  QH_BUTTON_HIDE = "숨김",

  MENU_CLOSE = "메뉴 닫기",
  MENU_SETTINGS = "설정",
  MENU_ENABLE = "켜기",
  MENU_DISABLE = "끄기",
  MENU_OBJECTIVE_TIPS = "목표 툴팁 %1",
  MENU_TRACKER_OPTIONS = "퀘스트 추적기",
  MENU_QUEST_TRACKER = "퀘스트 추적기 %1",
  MENU_TRACKER_LEVEL = "퀘스트 레벨 %1",
  MENU_TRACKER_QCOLOUR = "퀘스트 난이도 색상 %1",
  MENU_TRACKER_OCOLOUR = "퀘스트 진행 색상 %1",
  MENU_TRACKER_SCALE = "추적기 크기",
  MENU_TRACKER_RESET = "위치 초기화",
  MENU_FLIGHT_TIMER = "비행 타이머 %1",
  MENU_ANT_TRAILS = "점선 경로 %1",
  MENU_WAYPOINT_ARROW = "경유지 화살표 %1",
  MENU_MAP_BUTTON = "지도 버튼 %1",
  MENU_ZONE_FILTER = "지역 분류 %1",
  MENU_DONE_FILTER = "완료 분류 %1",
  MENU_BLOCKED_FILTER = "차단된 분류 %1",
  MENU_WATCHED_FILTER = "추적된 분류 %1",
  MENU_LEVEL_FILTER = "레벨 분류 %1",
  MENU_LEVEL_OFFSET = "레벨 분류 레벨",
  MENU_ICON_SCALE = "아이콘 크기",
  MENU_FILTERS = "필터",
  MENU_PERFORMANCE = "프레임당 작업량",
  MENU_LOCALE = "지역화 언어",
  MENU_PARTY = "파티",
  MENU_PARTY_SHARE = "퀘스트 공유 %1",
  MENU_PARTY_SOLO = "파티 무시 %1",
  MENU_HELP = "도움말",
  MENU_HELP_SLASH = "슬래쉬 명령어",
  MENU_HELP_CHANGES = "변경된 목록",
  MENU_HELP_SUBMIT = "데이터 보내기",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "QuestHelper로 추적됨",
  TOOLTIP_QUEST = "%h1 퀘스트.",
  TOOLTIP_PURCHASE = "%h1|1을;를; 구입하라.",
  TOOLTIP_SLAY = "%h1|1을;를; 처치하라.",
  TOOLTIP_LOOT = "%h1|1을;를; 획득하라.",
  TOOLTIP_OPEN = nil,
  
  -- Settings
  SETTINGS_ARROWLINK_ON = "목표 표시를 %h1|1으로;로; 사용합니다.",
  SETTINGS_ARROWLINK_OFF = "목표 표시를 %h1|1으로;로; 사용하지 않습니다.",
  SETTINGS_ARROWLINK_ARROW = "QuestHelper 화살표",
  SETTINGS_ARROWLINK_CART = "Cartographer 웨이포인트",
  SETTINGS_ARROWLINK_TOMTOM = "TomTom",
  SETTINGS_PRECACHE_ON = "%h(사용함)으로 임시 저장되었습니다.",
  SETTINGS_PRECACHE_OFF = "%h(사용 안함)으로 임시 저장되었습니다.",
  
  SETTINGS_MENU_ENABLE = "사용함",
  SETTINGS_MENU_DISABLE = "사용 안함",
  SETTINGS_MENU_CARTWP = "Cartographer 화살표 %1",
  SETTINGS_MENU_TOMTOM = "TomTom 화살표 %1",
  
  SETTINGS_MENU_ARROW_LOCK = "잠금",
  SETTINGS_MENU_ARROW_ARROWSCALE = "화살표 크기",
  SETTINGS_MENU_ARROW_TEXTSCALE = "글자 크기",
  SETTINGS_MENU_ARROW_RESET = "초기화",
  
  SETTINGS_MENU_INCOMPLETE = nil,
  
  SETTINGS_RADAR_ON = nil,
  SETTINGS_RADAR_OFF = nil,
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "%h1 미터",
  DISTANCE_METRES = "%h1 미터"
 }

