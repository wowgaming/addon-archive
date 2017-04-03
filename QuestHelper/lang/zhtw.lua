-- Please see enus.lua for reference.

QuestHelper_Translations.zhTW =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "繁體中文",
  
  -- Messages used when starting.
  LOCALE_ERROR = "你所儲存的語言設定，與本機的魔獸世界的區域語言設定並不符合。如要繼續使用QuestHelper，請您將語言設定改回原本的設定值，或是輸入%h(/qh purge)來刪除。",
  ZONE_LAYOUT_ERROR = "本插件拒絕繼續執行，以避免破壞你所儲存的資料。請您等候下一個可以處理此新區域資料的版本推出後，再使用最新版本的本插件",
  HOME_NOT_KNOWN = "目前無法得知您爐石所設定的城鎮。當您有機會經過旅店的時候，請您與旅店老闆談話，並設置您的爐石位置。",
  PRIVATE_SERVER = "本插件不支援私服",
  PLEASE_RESTART = "QuestHelper 啟始失敗無法載入, 請完全退出魔獸世界再試試.",
  NOT_UNZIPPED_CORRECTLY = "Quest Helper未正確安裝，我們建議使用Curse客戶端或者7Zip解壓縮程式來安裝。請確定子目錄皆有解壓縮。",
  PLEASE_SUBMIT = nil,
  HOW_TO_CONFIGURE = "輸入 /qh settings 可進入QuestHelper GUI設定頁面, 或輸入 /qh help 查看指令.",
  TIME_TO_UPDATE = "可能有%h(新的QuestHelper版本) 可供使用，新的版本通常包含新功能、新任務資料庫以及BUG的修正。請更新您的版本！",
  
  -- Route related text.
  ROUTES_CHANGED = "你角色的飛行路徑資訊已經更新了。",
  HOME_CHANGED = "您的爐石位置已經變更",
  TALK_TO_FLIGHT_MASTER = "請您與本地的飛行管理員談話。",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "感謝您。",
  WILL_RESET_PATH = "將重新擬定路徑的資訊",
  UPDATING_ROUTE = "更新路線",
  
  -- Special tracker text
  QH_LOADING = "QestHelper正在載入（%1%%）...",
  QH_FLIGHTPATH = "重新計算飛行路線中 (%1%)...",
  QH_RECALCULATING = nil,
  QUESTS_HIDDEN_1 = "任務可能已隱藏",
  QUESTS_HIDDEN_2 = "(“/qh 隱藏“ 於列表中“）",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "可使用的語系：",
  LOCALE_CHANGED = "變更語系為： %h1",
  LOCALE_UNKNOWN = "%h1 是個未知的語系",
  
  -- Words used for objectives.
  SLAY_VERB = "殺死",
  ACQUIRE_VERB = "需要",
  
  OBJECTIVE_REASON = "任務 %h3 需要 %1%h2", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "任務 %h2 需要 %h1",
  OBJECTIVE_REASON_TURNIN = "歸還任務 %h1",
  OBJECTIVE_PURCHASE = "從 %h1 購得",
  OBJECTIVE_TALK = "與 %1 交談",
  OBJECTIVE_SLAY = "殺死 %h1",
  OBJECTIVE_LOOT = "拾取 %h1",
  OBJECTIVE_OPEN = nil,
  
  OBJECTIVE_MONSTER_UNKNOWN = "未知的怪物",
  OBJECTIVE_ITEM_UNKNOWN = "未知的物品",
  
  ZONE_BORDER_SIMPLE = nil,
  
  -- Stuff used in objective menus.
  PRIORITY = "優先度",
  PRIORITY1 = "最高",
  PRIORITY2 = "高",
  PRIORITY3 = "一般",
  PRIORITY4 = "低",
  PRIORITY5 = "最低",
  SHARING = "分享中",
  SHARING_ENABLE = "分享",
  SHARING_DISABLE = "不分享",
  IGNORE = "忽略",
  IGNORE_LOCATION = "忽略這個地點",
  
  IGNORED_PRIORITY_TITLE = "您選擇的優先次序將被忽略",
  IGNORED_PRIORITY_FIX = "將同樣的優先次序設定，套用到被勾選的項目上",
  IGNORED_PRIORITY_IGNORE = "我想要自己設定任務執行的優先次序",
  
  -- "/qh find"
  RESULTS_TITLE = "搜尋結果",
  NO_RESULTS = "抱歉，查無資料",
  CREATED_OBJ = "製造了 %1",
  REMOVED_OBJ = "移除： %1",
  USER_OBJ = "玩家目的: %h1",
  UNKNOWN_OBJ = "我不知道您應該前往哪個目的.",
  INACCESSIBLE_OBJ = "QuestHelper無法針對 %h1 有用的地點，已經在您的任務目標列表中註明無法找到‧如果您找到相關正確資料請上傳分享! (%h(/qh submit))",
  FIND_REMOVE = nil,
  FIND_NOT_READY = nil,
  FIND_CUSTOM_LOCATION = nil,
  FIND_USAGE = nil,
  
  -- Shared objectives.
  PEER_TURNIN = "等待%h1 接受任務 %h2.",
  PEER_LOCATION = "幫助 %h1 到達 %h2.",
  PEER_ITEM = "幫助 %1 獲得 %h2.",
  PEER_OTHER = "協助 %1 藉由 %h2.",
  
  PEER_NEWER = "%h1使用了較新的版本,你應該更新了",
  PEER_OLDER = "%h1使用了較舊的版本",
  
  UNKNOWN_MESSAGE = "無法得知的訊息 '%1' 從 '%2'.",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "隱藏的目標",
  HIDDEN_NONE = "你並未設定有任何隱藏的物件",
  DEPENDS_ON_SINGLE = "根據 '%1'",
  DEPENDS_ON_COUNT = "根據 %1 隱藏目標",
  DEPENDS_ON = "依據已過濾的目標",
  FILTERED_LEVEL = "由等級過濾",
  FILTERED_GROUP = nil,
  FILTERED_ZONE = "由區域過濾",
  FILTERED_COMPLETE = "由完成度過濾",
  FILTERED_BLOCKED = "以先前未完成的目標過濾",
  FILTERED_UNWATCHED = "隱藏未設定任務追蹤的任務",
  FILTERED_WINTERGRASP = nil,
  FILTERED_RAID = nil,
  FILTERED_USER = "您已設定此物件為隱藏",
  FILTERED_UNKNOWN = "不知道如何完成任務",
  
  HIDDEN_SHOW = "顯示",
  HIDDEN_SHOW_NO = "不顯示",
  HIDDEN_EXCEPTION = "添加排除清單",
  DISABLE_FILTER = "關閉過濾： %1",
  FILTER_DONE = "完成",
  FILTER_ZONE = "地區",
  FILTER_LEVEL = "等級",
  FILTER_BLOCKED = "封鎖",
  FILTER_WATCHED = "已查閱",
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = nil,
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "您有%h(新的)%h1資料，並且%h(更新了)%h2資料。",
  NAG_SINGLE_NEW = "您有 %h(新的) %h1 %h(資料)",
  NAG_ADDITIONAL = "你有 %h(附加訊息) 於 %h1.",
  NAG_POLLUTED = "您的資料庫因私人或測試伺服器的資訊而不正確，並將在啓動時清除",
  
  NAG_NOT_NEW = "在您的靜態資料庫中，找不到沒有可以使用的資料",
  NAG_NEW = "建議您將你的資料分享出來，分享給其他使用者。",
  NAG_INSTRUCTIONS = "請您輸入%h(/qh sumbit)的指令，可以查看教您如何將任務資料庫分享出來的說明.",
  
  NAG_SINGLE_FP = "一為飛行管理員",
  NAG_SINGLE_QUEST = "一個任務",
  NAG_SINGLE_ROUTE = "一條飛行路徑",
  NAG_SINGLE_ITEM_OBJ = "一個道具目標",
  NAG_SINGLE_OBJECT_OBJ = "一個物件目標",
  NAG_SINGLE_MONSTER_OBJ = "一個怪物目標",
  NAG_SINGLE_EVENT_OBJ = "一個事件目標",
  NAG_SINGLE_REPUTATION_OBJ = "一個聲望目標",
  NAG_SINGLE_PLAYER_OBJ = "一位玩家目標",
  
  NAG_MULTIPLE_FP = "%1 飛行管理員",
  NAG_MULTIPLE_QUEST = "%1 任務資訊",
  NAG_MULTIPLE_ROUTE = "%1 飛行路徑",
  NAG_MULTIPLE_ITEM_OBJ = "%1 道具目標",
  NAG_MULTIPLE_OBJECT_OBJ = "%1 物件目標",
  NAG_MULTIPLE_MONSTER_OBJ = "%1 怪物目標",
  NAG_MULTIPLE_EVENT_OBJ = "%1 事件目標",
  NAG_MULTIPLE_REPUTATION_OBJ = "%1 聲望目標",
  NAG_MULTIPLE_PLAYER_OBJ = "玩家目標",
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "%1 目前的進度",
  TRAVEL_ESTIMATE = "預估飛行時間為：",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "探查 %h1 相鄰規劃路線至:",
  FLIGHT_POINT = "%1 飛行點",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = "左鍵： %1 路線訊息",
  QH_BUTTON_TOOLTIP2 = "右鍵： 顯示設定選單",
  QH_BUTTON_SHOW = "顯示",
  QH_BUTTON_HIDE = "隱藏",

  MENU_CLOSE = "關閉選單",
  MENU_SETTINGS = "設定",
  MENU_ENABLE = "按此開啟",
  MENU_DISABLE = "按此關閉",
  MENU_OBJECTIVE_TIPS = "%1 任務目標提示",
  MENU_TRACKER_OPTIONS = "\"任務追蹤\"",
  MENU_QUEST_TRACKER = "%1 任務追蹤",
  MENU_TRACKER_LEVEL = "%1 任務等級",
  MENU_TRACKER_QCOLOUR = "%1 依適合等級為任務添上顏色變化",
  MENU_TRACKER_OCOLOUR = "%1 依目前進度為任務添上顏色變化",
  MENU_TRACKER_SCALE = "追蹤器的大小",
  MENU_TRACKER_RESET = "重置位置",
  MENU_FLIGHT_TIMER = "%1 飛行計時器",
  MENU_ANT_TRAILS = "%1 建議路線",
  MENU_WAYPOINT_ARROW = "%1 路徑指南針",
  MENU_MAP_BUTTON = "%1 地圖按鈕",
  MENU_ZONE_FILTER = "%1 任務區域過濾",
  MENU_DONE_FILTER = "%1 任務完成過濾",
  MENU_BLOCKED_FILTER = "%1 封鎖過濾",
  MENU_WATCHED_FILTER = "過濾中",
  MENU_LEVEL_FILTER = "%1 任務等級的過濾",
  MENU_LEVEL_OFFSET = "關閉等級過濾",
  MENU_ICON_SCALE = "圖示比例",
  MENU_FILTERS = "過濾",
  MENU_PERFORMANCE = "路徑的效率",
  MENU_LOCALE = "語系",
  MENU_PARTY = "小隊",
  MENU_PARTY_SHARE = "分享 %1 任務",
  MENU_PARTY_SOLO = "%1 忽略組隊",
  MENU_HELP = "說明",
  MENU_HELP_SLASH = "詳細指令說明",
  MENU_HELP_CHANGES = "更新紀錄",
  MENU_HELP_SUBMIT = "如何將任務資料寄給作者",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "使用 QuestHelper 觀看",
  TOOLTIP_QUEST = "為了任務 %h1.",
  TOOLTIP_PURCHASE = "購買 %h1.",
  TOOLTIP_SLAY = "殺死為了 %h1.",
  TOOLTIP_LOOT = "收集為了 %h1.",
  TOOLTIP_OPEN = nil,
  
  -- Settings
  SETTINGS_ARROWLINK_ON = "將使用 %h1 顯示標的.",
  SETTINGS_ARROWLINK_OFF = "將不使用 %h1 顯示標的.",
  SETTINGS_ARROWLINK_ARROW = "QuestHelper 箭頭指標",
  SETTINGS_ARROWLINK_CART = "採用 Cartographer 導航",
  SETTINGS_ARROWLINK_TOMTOM = "採用 TomTom 導航",
  SETTINGS_PRECACHE_ON = "預載功能(Precache)已 %h(啟用). ",
  SETTINGS_PRECACHE_OFF = "預載功能(Precache)已 %h(停用). ",
  
  SETTINGS_MENU_ENABLE = "啟用",
  SETTINGS_MENU_DISABLE = "停用",
  SETTINGS_MENU_CARTWP = "%1 Cartographer 導航指標",
  SETTINGS_MENU_TOMTOM = "%1 TomTom 導航指標",
  
  SETTINGS_MENU_ARROW_LOCK = "鎖定",
  SETTINGS_MENU_ARROW_ARROWSCALE = "箭頭指標大小",
  SETTINGS_MENU_ARROW_TEXTSCALE = "字體大小",
  SETTINGS_MENU_ARROW_RESET = "重置",
  
  SETTINGS_MENU_INCOMPLETE = nil,
  
  SETTINGS_RADAR_ON = nil,
  SETTINGS_RADAR_OFF = nil,
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "%h1 碼距離",
  DISTANCE_METRES = "%h1 公尺"
 }

