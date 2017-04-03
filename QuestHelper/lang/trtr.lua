-- Please see enus.lua for reference.

QuestHelper_Translations.trTR =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "Türkçe",
  
  -- Messages used when starting.
  LOCALE_ERROR = "Kayitli verilerinizin dili WoW dilinizle ayni degil.",
  ZONE_LAYOUT_ERROR = "Kaydedilmis verilerinize hasar vermekten korkmaksizin çalismayi reddediyorum. Lütfen yeni bölgeyi kontrol edebilecek bir güncelleme çikana kadar bekleyin.",
  HOME_NOT_KNOWN = "Belirli bir konaklama yeriniz yok, firsat buldugunuzda barmen ile konusarak bir yer belirleyin.",
  PRIVATE_SERVER = "QuestHelper özel sunucuları desteklemiyor.",
  PLEASE_RESTART = "QuestHelper başlatılırken hata oluştu. Lütfen World Of Warcraft'tan tamamen çıkın ve yeniden deneyin.",
  NOT_UNZIPPED_CORRECTLY = nil,
  PLEASE_SUBMIT = nil,
  HOW_TO_CONFIGURE = "QuestHelper şimdilik bir özelleştirme sayfasına sahip değil, ama özelleştirmek için %h(/qh settings) yazın. %h(/qh help) yardım alabilirsiniz.",
  TIME_TO_UPDATE = "%h(yeni sürüm QuestHelper) kullanılabilir. Yeni sürüm yeni özellikler içerir, yeni veritabanı, ve iyileştirmeler. Lütfen güncelleyin!",
  
  -- Route related text.
  ROUTES_CHANGED = "Uçus noktalariniza bakilarak eklenti veritabani güncellendi.",
  HOME_CHANGED = "Konaklama yeriniz degisti.",
  TALK_TO_FLIGHT_MASTER = "Bölgenizdeki uçus kaptani ile görüsün.",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "Tesekkürler.",
  WILL_RESET_PATH = "Rota bilgileri sifirlandi.",
  UPDATING_ROUTE = "Rota Güncelleniyor.",
  
  -- Special tracker text
  QH_LOADING = "QuestHelper yükleniyor (%1%%)...",
  QH_FLIGHTPATH = nil,
  QH_RECALCULATING = nil,
  QUESTS_HIDDEN_1 = nil,
  QUESTS_HIDDEN_2 = nil,
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "Kullanilabilir diller:",
  LOCALE_CHANGED = "Dil %h1 olarak degistirildi.",
  LOCALE_UNKNOWN = "%h1 dili bilinmiyor.",
  
  -- Words used for objectives.
  SLAY_VERB = "Öldür",
  ACQUIRE_VERB = "topla",
  
  OBJECTIVE_REASON = "%h3 görevi için %h2 %h1.", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "%h2 görevi için %h1.",
  OBJECTIVE_REASON_TURNIN = "%h1 görevini tamamla.",
  OBJECTIVE_PURCHASE = "%h1 satin al.",
  OBJECTIVE_TALK = "%h1 ile konus.",
  OBJECTIVE_SLAY = "%h1 öldür.",
  OBJECTIVE_LOOT = "%h1 topla",
  OBJECTIVE_OPEN = nil,
  
  OBJECTIVE_MONSTER_UNKNOWN = nil,
  OBJECTIVE_ITEM_UNKNOWN = nil,
  
  ZONE_BORDER_SIMPLE = nil,
  
  -- Stuff used in objective menus.
  PRIORITY = "Öncelik",
  PRIORITY1 = "En yüksek",
  PRIORITY2 = "Yüksek",
  PRIORITY3 = "Normal",
  PRIORITY4 = "Düsük",
  PRIORITY5 = "En düsük",
  SHARING = "Paylasim",
  SHARING_ENABLE = "Paylas.",
  SHARING_DISABLE = "Paylasma.",
  IGNORE = "Dikkate alma",
  IGNORE_LOCATION = nil,
  
  IGNORED_PRIORITY_TITLE = "Seçilmis öncelik dikkate alinmayacak.",
  IGNORED_PRIORITY_FIX = "Engellenen islere ayni önceligi uygula.",
  IGNORED_PRIORITY_IGNORE = "Öncelikleri ben ayarlayacagim",
  
  -- "/qh find"
  RESULTS_TITLE = "Arama sonuçlari",
  NO_RESULTS = "Hiçbir sonuç bulunamadi!",
  CREATED_OBJ = "Olusturulan: %1",
  REMOVED_OBJ = "Silinen: %1",
  USER_OBJ = "Kullanici görevi: %h1",
  UNKNOWN_OBJ = "Bu görev için nereye gitmen gerektigini bilmiyorum.",
  INACCESSIBLE_OBJ = nil,
  FIND_REMOVE = nil,
  FIND_NOT_READY = nil,
  FIND_CUSTOM_LOCATION = nil,
  FIND_USAGE = nil,
  
  -- Shared objectives.
  PEER_TURNIN = "%h1 e %h2 görevini tamamlamasini bekle.",
  PEER_LOCATION = "%h1 e %h2 içindeki bölgeye ulasmasina yardim et.",
  PEER_ITEM = "%1 e %h2 toplamasina yardim et.",
  PEER_OTHER = "%h2 için %h1 e yardimci ol.",
  
  PEER_NEWER = "%h1 daha yeni bir versiyon kullaniyor. Güncelleme yapmayi düsünebilirsiniz.",
  PEER_OLDER = "%h1 daha eski bir versiyon kullaniyor",
  
  UNKNOWN_MESSAGE = "'%2' tarafindan '%1', bilinmeyen mesaj tarzi.",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "Gizli görevler",
  HIDDEN_NONE = "Sizden gizlenen görev bulunmamakta.",
  DEPENDS_ON_SINGLE = "'%1' durumuna bagli.",
  DEPENDS_ON_COUNT = "%1 gizli görevlerin durumuna bagli.",
  DEPENDS_ON = nil,
  FILTERED_LEVEL = "Seviyeniz nedeniyle filtrelendi.",
  FILTERED_GROUP = nil,
  FILTERED_ZONE = "Bölge nedeniyle filtrelendi.",
  FILTERED_COMPLETE = "Tamamlandigi için filtrelendi.",
  FILTERED_BLOCKED = "Bitirilmemiş bir görev yüzünden filtrelendi.",
  FILTERED_UNWATCHED = nil,
  FILTERED_WINTERGRASP = nil,
  FILTERED_RAID = nil,
  FILTERED_USER = "Bu görevin gizlenmesini istediniz.",
  FILTERED_UNKNOWN = "Nasil bitirilecegi bilinmiyor.",
  
  HIDDEN_SHOW = "Göster.",
  HIDDEN_SHOW_NO = nil,
  HIDDEN_EXCEPTION = nil,
  DISABLE_FILTER = "Filtrelemeyi kapat: %1",
  FILTER_DONE = "Tamamlandi",
  FILTER_ZONE = "bölge",
  FILTER_LEVEL = "seviye",
  FILTER_BLOCKED = "Engellendi.",
  FILTER_WATCHED = nil,
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = nil,
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "%h1 yeni bilgileriniz ve %h2 güncellemeleriniz var %h(%s3).",
  NAG_SINGLE_NEW = "%h1 için yeni bilgilere sahipsiniz.",
  NAG_ADDITIONAL = "%h1 için daha daha fazla yeni bilgiye sahipsiniz.",
  NAG_POLLUTED = nil,
  
  NAG_NOT_NEW = "Veritabaninda bulunmayan yeni bir bilgiye sahip degilsiniz.",
  NAG_NEW = "Diger oyuncularin da faydalanabilmesi için bilgilerinizi paylasabilirsiniz.",
  NAG_INSTRUCTIONS = "Veri gönderiminin nasıl yapılacağını öğrenmek için %h yazınız",
  
  NAG_SINGLE_FP = "uçuş kaptanı",
  NAG_SINGLE_QUEST = "Görev",
  NAG_SINGLE_ROUTE = "bir uçuş rotası",
  NAG_SINGLE_ITEM_OBJ = "bir eşya görevi",
  NAG_SINGLE_OBJECT_OBJ = nil,
  NAG_SINGLE_MONSTER_OBJ = "bir yaratık görevi",
  NAG_SINGLE_EVENT_OBJ = "Bir olay görevi",
  NAG_SINGLE_REPUTATION_OBJ = "bir reputation görevi",
  NAG_SINGLE_PLAYER_OBJ = nil,
  
  NAG_MULTIPLE_FP = "%1 uçuş kaptanları",
  NAG_MULTIPLE_QUEST = "%1 Görevler",
  NAG_MULTIPLE_ROUTE = "%1 Uçuş Rotaları",
  NAG_MULTIPLE_ITEM_OBJ = "%1 Esya Görevleri.",
  NAG_MULTIPLE_OBJECT_OBJ = nil,
  NAG_MULTIPLE_MONSTER_OBJ = "%1 Yaratık Görevleri.",
  NAG_MULTIPLE_EVENT_OBJ = "%1 ",
  NAG_MULTIPLE_REPUTATION_OBJ = "%1 Reputation Görevleri",
  NAG_MULTIPLE_PLAYER_OBJ = nil,
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "%1 in ilerleyisi:",
  TRAVEL_ESTIMATE = "Kalan tahmini zaman:",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "Yolda %h1 e ugra:",
  FLIGHT_POINT = nil,

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = "Sol Tık: rota bilgisi tespiti %1",
  QH_BUTTON_TOOLTIP2 = "Sag Tık: Ayar menusunu acar.",
  QH_BUTTON_SHOW = "Goster.",
  QH_BUTTON_HIDE = "Sakla.",

  MENU_CLOSE = "Menuyu Kapat",
  MENU_SETTINGS = "Ayarlar",
  MENU_ENABLE = "Aktifleştir.",
  MENU_DISABLE = "Deaktifleştir.",
  MENU_OBJECTIVE_TIPS = "Nesne İpuçları",
  MENU_TRACKER_OPTIONS = "Quest Takipçisi",
  MENU_QUEST_TRACKER = "%1 Quest Takipcisi.",
  MENU_TRACKER_LEVEL = "%1 Quest Aşamaları.",
  MENU_TRACKER_QCOLOUR = "%1 Quest Zorluk Renkleri",
  MENU_TRACKER_OCOLOUR = "%1 Görev Gidişat Renkleri.",
  MENU_TRACKER_SCALE = "Takipçi boyutu",
  MENU_TRACKER_RESET = "Pozisyonu Sıfırla",
  MENU_FLIGHT_TIMER = "%1 Uçuş süresi",
  MENU_ANT_TRAILS = "Karinca Yolu",
  MENU_WAYPOINT_ARROW = "%1 Aranokta Oku.",
  MENU_MAP_BUTTON = "%1 Harita Butonlari",
  MENU_ZONE_FILTER = "%1 Alan Filtresi",
  MENU_DONE_FILTER = "%1 Tamamlanmış Filtre.",
  MENU_BLOCKED_FILTER = "%1 Engellenmiş Filtre",
  MENU_WATCHED_FILTER = "%1 Izleme Filtresi",
  MENU_LEVEL_FILTER = "%1 Seviye Filtresi",
  MENU_LEVEL_OFFSET = "Level Filtre Ofseti",
  MENU_ICON_SCALE = "Simgelerin büyüklüğü",
  MENU_FILTERS = "Filtreler",
  MENU_PERFORMANCE = nil,
  MENU_LOCALE = "Dil",
  MENU_PARTY = "Party",
  MENU_PARTY_SHARE = "%1 Gorev Paylasimi.",
  MENU_PARTY_SOLO = "%1 Party'i gormezden gel.",
  MENU_HELP = "Yardım",
  MENU_HELP_SLASH = "Chat komutları",
  MENU_HELP_CHANGES = "Sürüm Notları",
  MENU_HELP_SUBMIT = "Veri gönderimi",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "QuestHelper tarafından izlenen.",
  TOOLTIP_QUEST = "Quest %h1 için.",
  TOOLTIP_PURCHASE = "%h1 için satın al.",
  TOOLTIP_SLAY = "%h1 için öldür.",
  TOOLTIP_LOOT = "%h1 için yağmala.",
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
  DISTANCE_YARDS = nil,
  DISTANCE_METRES = nil
 }

