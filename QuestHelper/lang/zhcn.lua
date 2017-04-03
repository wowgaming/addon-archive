-- Please see enus.lua for reference.

QuestHelper_Translations.zhCN =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "简体中文",
  
  -- Messages used when starting.
  LOCALE_ERROR = "您存储的语言设定与本机的魔兽世界的区域语言设定不相符。如果要继续使用QuestHelper，请您将语言设定回原来的设定值，或是输入%h(/qh purge)来删除",
  ZONE_LAYOUT_ERROR = "本插件拒绝继续执行以免破坏您的存储资料。请等候下一个此新区域可用的版本再使用最新版本的插件",
  HOME_NOT_KNOWN = "目前无法得知您炉石设定的城镇。您可以与旅店老板交谈获取炉石并设定位置。",
  PRIVATE_SERVER = "QuestHelper 不支持私服。",
  PLEASE_RESTART = "QuestHelper 启动失败无法载入，请完全退出魔兽世界再试试。",
  NOT_UNZIPPED_CORRECTLY = "QuestHelper没有被正确安装，我们建议使用Curse客户端或者7zip解压安装，请确定子目录都解压安装了。",
  PLEASE_SUBMIT = nil,
  HOW_TO_CONFIGURE = "输入 /qh settings 可进入QuestHelper GUI设置界面，或输入/qh help 查看指令。",
  TIME_TO_UPDATE = "可能有%h（新版本QuestHelper）可供使用，新的版本通常包含新的功能，新的任务资料库和BUG修正。请您及时更新版本！",
  
  -- Route related text.
  ROUTES_CHANGED = "您角色的飞行路径信息已经更新。",
  HOME_CHANGED = "您的炉石位置已经变更",
  TALK_TO_FLIGHT_MASTER = "请与本地的飞行管理员交谈。",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "谢谢您。",
  WILL_RESET_PATH = "将重设路径信息",
  UPDATING_ROUTE = "更新路线",
  
  -- Special tracker text
  QH_LOADING = "QestHelper正在载入（%1%%）...",
  QH_FLIGHTPATH = "重新计算飞行路线中 (%1%)...",
  QH_RECALCULATING = nil,
  QUESTS_HIDDEN_1 = "任务可能已隐藏",
  QUESTS_HIDDEN_2 = "(“/qh hidden“ 到列表“）",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "可使用的了语种",
  LOCALE_CHANGED = "变更语种为：%1",
  LOCALE_UNKNOWN = "%h1 未知语种",
  
  -- Words used for objectives.
  SLAY_VERB = "杀死",
  ACQUIRE_VERB = "需要",
  
  OBJECTIVE_REASON = "任务 %h3 需要 %1 %h2", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "任务 %h2 需要 %h1",
  OBJECTIVE_REASON_TURNIN = "归还任务 %h1.",
  OBJECTIVE_PURCHASE = "从 %h1 购买",
  OBJECTIVE_TALK = "与 %h1 交谈.",
  OBJECTIVE_SLAY = "击杀 %h1.",
  OBJECTIVE_LOOT = "拾取 %h1.",
  OBJECTIVE_OPEN = nil,
  
  OBJECTIVE_MONSTER_UNKNOWN = "未知的怪物",
  OBJECTIVE_ITEM_UNKNOWN = "未知的物品",
  
  ZONE_BORDER_SIMPLE = nil,
  
  -- Stuff used in objective menus.
  PRIORITY = "优先度",
  PRIORITY1 = "最高",
  PRIORITY2 = "高",
  PRIORITY3 = "一般",
  PRIORITY4 = "低",
  PRIORITY5 = "最低",
  SHARING = "分享中",
  SHARING_ENABLE = "分享",
  SHARING_DISABLE = "不分享",
  IGNORE = "忽略",
  IGNORE_LOCATION = "忽略这个地点目标",
  
  IGNORED_PRIORITY_TITLE = "您选择的优先次序将被忽略",
  IGNORED_PRIORITY_FIX = "将同样的优先次序设定套用到被勾选的项目上",
  IGNORED_PRIORITY_IGNORE = "我想要自己设定任务执行的优先次序",
  
  -- "/qh find"
  RESULTS_TITLE = "搜索结果",
  NO_RESULTS = "抱歉，查无资料！",
  CREATED_OBJ = "制造了 %1",
  REMOVED_OBJ = "移除： %1",
  USER_OBJ = "玩家目的：%h1",
  UNKNOWN_OBJ = "我不知道您应该前往哪个目的",
  INACCESSIBLE_OBJ = nil,
  FIND_REMOVE = nil,
  FIND_NOT_READY = nil,
  FIND_CUSTOM_LOCATION = nil,
  FIND_USAGE = nil,
  
  -- Shared objectives.
  PEER_TURNIN = "等待 %h1 接受任务 %h2.",
  PEER_LOCATION = "帮助 %h1 到达 %h2.",
  PEER_ITEM = "帮助 %1 获得 %h2.",
  PEER_OTHER = "协助 %1 由 %h2.",
  
  PEER_NEWER = "%h1 使用了较新的版本，您应该更新了。",
  PEER_OLDER = "%h1 使用了较旧的版本。",
  
  UNKNOWN_MESSAGE = "未知信息 '%1' 從 '%2'.",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "隐藏的目标",
  HIDDEN_NONE = "您没有设定任何隐藏物件",
  DEPENDS_ON_SINGLE = "根据 ‘%1’",
  DEPENDS_ON_COUNT = "根据 %1 隐藏目标",
  DEPENDS_ON = "依赖已经过滤掉的目标任务",
  FILTERED_LEVEL = "由登记过滤",
  FILTERED_GROUP = nil,
  FILTERED_ZONE = "有区域过滤",
  FILTERED_COMPLETE = "由完成度过滤",
  FILTERED_BLOCKED = "由先前未完成的目标过滤",
  FILTERED_UNWATCHED = "隐藏未设定任务追踪的任务",
  FILTERED_WINTERGRASP = nil,
  FILTERED_RAID = nil,
  FILTERED_USER = "您已设定此物件为隐藏",
  FILTERED_UNKNOWN = "不知道如何完成任务",
  
  HIDDEN_SHOW = "显示",
  HIDDEN_SHOW_NO = nil,
  HIDDEN_EXCEPTION = nil,
  DISABLE_FILTER = "关闭过滤：%1",
  FILTER_DONE = "完成",
  FILTER_ZONE = "地区",
  FILTER_LEVEL = "登记",
  FILTER_BLOCKED = "封锁",
  FILTER_WATCHED = nil,
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = nil,
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "您有%h（新的）%h1资料，并且%h（更新了）%h2资料。",
  NAG_SINGLE_NEW = "您有 %h（新的信息）在 %h1.",
  NAG_ADDITIONAL = "您有 %h（附加信息） 在 %h1",
  NAG_POLLUTED = "您的资料库因私人或测试服务器的资讯不正确，将在启动时清除",
  
  NAG_NOT_NEW = "在您的静态资料库找不到没有可以使用的资料",
  NAG_NEW = "建议您将资料与其他使用者共享",
  NAG_INSTRUCTIONS = "输入 %h(/qh submit) 可以查看提交记录数据的介绍",
  
  NAG_SINGLE_FP = "一个飞行管理员",
  NAG_SINGLE_QUEST = "一个任务",
  NAG_SINGLE_ROUTE = "一条飞行路径",
  NAG_SINGLE_ITEM_OBJ = "一个道具目标",
  NAG_SINGLE_OBJECT_OBJ = "一个物件目标",
  NAG_SINGLE_MONSTER_OBJ = "一个怪物目标",
  NAG_SINGLE_EVENT_OBJ = "一个事件目标",
  NAG_SINGLE_REPUTATION_OBJ = "一个声望目标",
  NAG_SINGLE_PLAYER_OBJ = "一个玩家目标",
  
  NAG_MULTIPLE_FP = "%1 飞行管理员",
  NAG_MULTIPLE_QUEST = "%1 任务资讯",
  NAG_MULTIPLE_ROUTE = "%1 飞行路径",
  NAG_MULTIPLE_ITEM_OBJ = "%1 道具目标",
  NAG_MULTIPLE_OBJECT_OBJ = "%1 物件目标",
  NAG_MULTIPLE_MONSTER_OBJ = "%1 怪物目标",
  NAG_MULTIPLE_EVENT_OBJ = "%1 事件目标",
  NAG_MULTIPLE_REPUTATION_OBJ = "%1 声望目标",
  NAG_MULTIPLE_PLAYER_OBJ = "%1 玩家目标",
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "%1 目前的进度",
  TRAVEL_ESTIMATE = "预估飞行时间为：",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "查探 %h1 相邻路径至：",
  FLIGHT_POINT = "%1 飞行点",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = "左键： %1路径信息",
  QH_BUTTON_TOOLTIP2 = "右键： 显示设定菜单",
  QH_BUTTON_SHOW = "显示",
  QH_BUTTON_HIDE = "隐藏",

  MENU_CLOSE = "关闭选单",
  MENU_SETTINGS = "设定",
  MENU_ENABLE = "按此开启",
  MENU_DISABLE = "按此关闭",
  MENU_OBJECTIVE_TIPS = "%1 任务目标提示",
  MENU_TRACKER_OPTIONS = "“任务追踪",
  MENU_QUEST_TRACKER = "%1 任务追踪",
  MENU_TRACKER_LEVEL = "%1 任务等级",
  MENU_TRACKER_QCOLOUR = "%1 任务难度着色",
  MENU_TRACKER_OCOLOUR = "%1 任务进度色彩变化",
  MENU_TRACKER_SCALE = "追踪器大小",
  MENU_TRACKER_RESET = "重置位置",
  MENU_FLIGHT_TIMER = "%1 飞行计时器",
  MENU_ANT_TRAILS = "%1 蚂蚁拖曳踪迹",
  MENU_WAYPOINT_ARROW = "%1 路径指南针",
  MENU_MAP_BUTTON = "%1 地图按钮",
  MENU_ZONE_FILTER = "%1 任务区域过滤",
  MENU_DONE_FILTER = "%1 已完成任务过滤",
  MENU_BLOCKED_FILTER = "%1 封锁过滤",
  MENU_WATCHED_FILTER = "%1 监视过滤",
  MENU_LEVEL_FILTER = "%1 任务等级过滤",
  MENU_LEVEL_OFFSET = "关闭等级过滤",
  MENU_ICON_SCALE = "图标比例",
  MENU_FILTERS = "过滤",
  MENU_PERFORMANCE = "路径效率",
  MENU_LOCALE = "语种",
  MENU_PARTY = "小队",
  MENU_PARTY_SHARE = "%1 任务共享",
  MENU_PARTY_SOLO = "%1 忽略组队",
  MENU_HELP = "帮助",
  MENU_HELP_SLASH = "命令行说明",
  MENU_HELP_CHANGES = "更新记录",
  MENU_HELP_SUBMIT = "提交记录数据",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "使用 QuestHelper 查看",
  TOOLTIP_QUEST = "为了任务 %h1.",
  TOOLTIP_PURCHASE = "购买 %h1.",
  TOOLTIP_SLAY = "击杀为了 %h1.",
  TOOLTIP_LOOT = "拾取为 %h1.",
  TOOLTIP_OPEN = nil,
  
  -- Settings
  SETTINGS_ARROWLINK_ON = nil,
  SETTINGS_ARROWLINK_OFF = nil,
  SETTINGS_ARROWLINK_ARROW = nil,
  SETTINGS_ARROWLINK_CART = nil,
  SETTINGS_ARROWLINK_TOMTOM = nil,
  SETTINGS_PRECACHE_ON = nil,
  SETTINGS_PRECACHE_OFF = nil,
  
  SETTINGS_MENU_ENABLE = nil,
  SETTINGS_MENU_DISABLE = nil,
  SETTINGS_MENU_CARTWP = nil,
  SETTINGS_MENU_TOMTOM = nil,
  
  SETTINGS_MENU_ARROW_LOCK = nil,
  SETTINGS_MENU_ARROW_ARROWSCALE = nil,
  SETTINGS_MENU_ARROW_TEXTSCALE = nil,
  SETTINGS_MENU_ARROW_RESET = nil,
  
  SETTINGS_MENU_INCOMPLETE = nil,
  
  SETTINGS_RADAR_ON = nil,
  SETTINGS_RADAR_OFF = nil,
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "%h1 码距离",
  DISTANCE_METRES = nil
 }

