-------------
-- CHINESE --
-------------
--
-- Note Healbot is missing a registered translator for this region, see Healbot's homepage for details.
-- URL: http://healbot.alturl.com (or  http://look4me.endoftheinternet.org/hb/)
--

if (GetLocale() == "zhTW") then

-------------------
-- Compatibility --
-------------------

HEALBOT_DRUID   = "德魯伊";
HEALBOT_HUNTER  = "獵人";
HEALBOT_MAGE    = "法師";
HEALBOT_PALADIN = "聖騎士";
HEALBOT_PRIEST  = "牧師";
HEALBOT_ROGUE   = "盜賊";
HEALBOT_SHAMAN  = "薩滿";
HEALBOT_WARLOCK = "術士";
HEALBOT_WARRIOR = "戰士";
HEALBOT_DEATHKNIGHT = "死亡騎士";

HEALBOT_HEAVY_NETHERWEAVE_BANDAGE = GetItemInfo(21991) or "厚霜紋繃帶";
HEALBOT_HEAVY_RUNECLOTH_BANDAGE   = GetItemInfo(14530) or "厚符文布繃帶";
HEALBOT_MAJOR_HEALING_POTION      = GetItemInfo(13446) or "極效治療藥水";
HEALBOT_PURIFICATION_POTION       = GetItemInfo(13462) or "淨化藥水";
HEALBOT_ANTI_VENOM                = GetItemInfo(6452) or "抗毒藥劑";
HEALBOT_POWERFUL_ANTI_VENOM       = GetItemInfo(19440) or "強力抗毒藥劑";
HEALBOT_ELIXIR_OF_POISON_RES      = GetItemInfo(3386) or "抗毒抗劑";

HEALBOT_FLASH_HEAL          = GetSpellInfo(2061) or "快速治療";
HEALBOT_FLASH_OF_LIGHT      = GetSpellInfo(19750) or "聖光閃現";
HEALBOT_GREATER_HEAL        = GetSpellInfo(2060) or "強效治療術";
HEALBOT_BINDING_HEAL        = GetSpellInfo(32546) or "束縛治療"--TBC spell
HEALBOT_PRAYER_OF_MENDING   = GetSpellInfo(33076) or "癒合禱言";
HEALBOT_HEALING_TOUCH       = GetSpellInfo(5185) or "治療之觸";
HEALBOT_HEAL                = GetSpellInfo(2054) or "治療術";
HEALBOT_HEALING_WAVE        = GetSpellInfo(331) or "治療波";
HEALBOT_RIPTIDE             = GetSpellInfo(61295) or "激流";
HEALBOT_HEALING_WAY         = GetSpellInfo(29206) or "治療之路";
HEALBOT_HOLY_LIGHT          = GetSpellInfo(635) or "聖光術";
HEALBOT_LESSER_HEAL         = GetSpellInfo(2050) or "次級治療術";
HEALBOT_LESSER_HEALING_WAVE = GetSpellInfo(8004) or "次級治療波";
HEALBOT_POWER_WORD_SHIELD   = GetSpellInfo(17) or "真言術:盾";
HEALBOT_REGROWTH            = GetSpellInfo(8936) or "癒合";
HEALBOT_RENEW               = GetSpellInfo(139) or "恢復";
HEALBOT_REJUVENATION        = GetSpellInfo(774) or "回春術";
HEALBOT_LIFEBLOOM           = GetSpellInfo(33763) or "生命之花";--tbc spell
HEALBOT_WILD_GROWTH         = GetSpellInfo(48438) or "野性痊癒";
HEALBOT_REVIVE              = GetSpellInfo(50769) or "復活";--
HEALBOT_TRANQUILITY         = GetSpellInfo(740) or "寧靜";
HEALBOT_SWIFTMEND           = GetSpellInfo(18562) or "迅癒";
HEALBOT_PRAYER_OF_HEALING   = GetSpellInfo(596) or "治療禱言";
HEALBOT_CHAIN_HEAL          = GetSpellInfo(1064) or "治療鍊";
HEALBOT_NOURISH             = GetSpellInfo(50464) or "滋補術";

HEALBOT_PAIN_SUPPRESSION      = GetSpellInfo(33206) or "痛苦鎮壓";
HEALBOT_POWER_WORD_FORTITUDE  = GetSpellInfo(1243) or "真言術:韌";
HEALBOT_PRAYER_OF_FORTITUDE   = GetSpellInfo(21562) or "堅韌禱言";
HEALBOT_DIVINE_SPIRIT         = GetSpellInfo(14752) or "神聖之靈";
HEALBOT_PRAYER_OF_SPIRIT      = GetSpellInfo(27681) or "精神禱言";
HEALBOT_SHADOW_PROTECTION     = GetSpellInfo(976) or "暗影防護";
HEALBOT_PRAYER_OF_SHADOW_PROTECTION = GetSpellInfo(27683) or "暗影防護禱言";
HEALBOT_INNER_FIRE            = GetSpellInfo(588) or "心靈之火";
HEALBOT_SHADOWFORM            = GetSpellInfo(15473) or "暗影型態";
HEALBOT_INNER_FOCUS           = GetSpellInfo(14751) or "心靈專注";
HEALBOT_TWIN_DISCIPLINES      = GetSpellInfo(47586) or "雙重戒律";
HEALBOT_SPIRITAL_HEALING      = GetSpellInfo(14898) or "精神治療";
HEALBOT_EMPOWERED_HEALING     = GetSpellInfo(33158) or "強力治療術";
HEALBOT_DIVINE_PROVIDENCE     = GetSpellInfo(47562) or "天佑之福";
HEALBOT_IMPROVED_RENEW        = GetSpellInfo(14908) or "強化恢復";
HEALBOT_FOCUSED_POWER         = GetSpellInfo(33186) or "能量專注";
HEALBOT_GENESIS               = GetSpellInfo(57810) or "生生不息";
HEALBOT_NURTURING_INSTINCT    = GetSpellInfo(33872) or "培育天性";
HEALBOT_IMPROVED_REJUVENATION = GetSpellInfo(17111) or "強化回春術";
HEALBOT_GIFT_OF_NATURE        = GetSpellInfo(17104) or "自然賜福";
HEALBOT_EMPOWERED_TOUCH       = GetSpellInfo(33879) or "強力之觸";
HEALBOT_EMPOWERED_REJUVENATION = GetSpellInfo(33886) or "強力回春術";
HEALBOT_HEALING_LIGHT         = GetSpellInfo(20237) or "治療之光";
HEALBOT_PURIFICATION          = GetSpellInfo(16178) or "淨化";
HEALBOT_IMPROVED_CHAIN_HEAL   = GetSpellInfo(30872) or "強化治療鍊";
HEALBOT_NATURES_BLESSING      = GetSpellInfo(30867) or "自然祝福";
HEALBOT_FEAR_WARD             = GetSpellInfo(6346) or "防護恐懼結界";
HEALBOT_ARCANE_INTELLECT      = GetSpellInfo(1459) or "秘法智力";
HEALBOT_ARCANE_BRILLIANCE     = GetSpellInfo(23028) or "秘法光輝";
HEALBOT_DALARAN_INTELLECT     = GetSpellInfo(61024) or "達拉然智力";
HEALBOT_DALARAN_BRILLIANCE    = GetSpellInfo(61316) or "達拉然光輝";
HEALBOT_FROST_ARMOR           = GetSpellInfo(168) or "霜甲術";
HEALBOT_ICE_ARMOR             = GetSpellInfo(7302) or "冰甲術";
HEALBOT_MAGE_ARMOR            = GetSpellInfo(6117) or "魔甲術";--check
HEALBOT_MOLTEN_ARMOR          = GetSpellInfo(30482) or "熔火護甲";--tbc
HEALBOT_DEMON_ARMOR           = GetSpellInfo(706) or "魔甲術";
HEALBOT_DEMON_SKIN            = GetSpellInfo(687) or "惡魔皮膚";
HEALBOT_FEL_ARMOR             = GetSpellInfo(28176) or "獄甲術";--tbc spell
HEALBOT_DAMPEN_MAGIC          = GetSpellInfo(604) or "魔法抑制";
HEALBOT_AMPLIFY_MAGIC         = GetSpellInfo(1008) or "魔法增效";
HEALBOT_DETECT_INV            = GetSpellInfo(132) or "偵測隱形";
HEALBOT_FOCUS_MAGIC           = GetSpellInfo(54646) or "魔法凝聚";

HEALBOT_LIGHTNING_SHIELD      = GetSpellInfo(324) or "閃電之盾";
HEALBOT_ROCKBITER_WEAPON      = GetSpellInfo(8017) or "石化武器";
HEALBOT_FLAMETONGUE_WEAPON    = GetSpellInfo(8024) or "火舌武器";
HEALBOT_EARTHLIVING_WEAPON    = GetSpellInfo(51730) or "大地生命武器";
HEALBOT_WINDFURY_WEAPON       = GetSpellInfo(8232) or "風怒武器";
HEALBOT_FROSTBRAND_WEAPON     = GetSpellInfo(8033) or "冰封武器";
HEALBOT_EARTH_SHIELD          = GetSpellInfo(974) or "大地之盾";--tbc spell
HEALBOT_WATER_SHIELD          = GetSpellInfo(52127) or "水之盾";

HEALBOT_MARK_OF_THE_WILD      = GetSpellInfo(1126) or "野性印記";
HEALBOT_GIFT_OF_THE_WILD      = GetSpellInfo(21849) or "野性賜福";
HEALBOT_THORNS                = GetSpellInfo(467) or "荊棘術";
HEALBOT_OMEN_OF_CLARITY       = GetSpellInfo(16864) or "清晰預兆";

HEALBOT_BEACON_OF_LIGHT         = GetSpellInfo(53563) or "聖光信標";
HEALBOT_LIGHT_BEACON            = GetSpellInfo(53651) or "聖光療源";
HEALBOT_SACRED_SHIELD           = GetSpellInfo(53601) or "崇聖護盾";
HEALBOT_SHEATH_OF_LIGHT         = GetSpellInfo(53501) or "聖光之鞘";
HEALBOT_BLESSING_OF_MIGHT       = GetSpellInfo(19740) or "力量祝福";
HEALBOT_BLESSING_OF_WISDOM      = GetSpellInfo(19742) or "智慧祝福";
HEALBOT_BLESSING_OF_SANCTUARY   = GetSpellInfo(20911) or "庇護祝福";
HEALBOT_BLESSING_OF_PROTECTION  = GetSpellInfo(41450) or "保護祝福";
HEALBOT_BLESSING_OF_KINGS       = GetSpellInfo(20217) or "王者祝福";
HEALBOT_HAND_OF_SALVATION       = GetSpellInfo(1038) or "拯救聖禦";
HEALBOT_GREATER_BLESSING_OF_MIGHT     = GetSpellInfo(25782) or "強效力量祝福";
HEALBOT_GREATER_BLESSING_OF_WISDOM    = GetSpellInfo(25894) or "強效智慧祝福";
HEALBOT_GREATER_BLESSING_OF_KINGS     = GetSpellInfo(25898) or "強效王者祝福";
HEALBOT_GREATER_BLESSING_OF_SANCTUARY = GetSpellInfo(25899) or "強效庇護祝福";
HEALBOT_SEAL_OF_RIGHTEOUSNESS   = GetSpellInfo(21084) or "正義聖印"
HEALBOT_SEAL_OF_BLOOD           = GetSpellInfo(31892) or "血之聖印"
HEALBOT_SEAL_OF_CORRUPTION      = GetSpellInfo(53736) or "腐化聖印"
HEALBOT_SEAL_OF_JUSTICE         = GetSpellInfo(20164) or "公正聖印"
HEALBOT_SEAL_OF_LIGHT           = GetSpellInfo(20165) or "光明聖印"
HEALBOT_SEAL_OF_VENGEANCE       = GetSpellInfo(31801) or "復仇聖印"
HEALBOT_SEAL_OF_WISDOM          = GetSpellInfo(20166) or "智慧聖印"
HEALBOT_SEAL_OF_COMMAND         = GetSpellInfo(20375) or "命令聖印"
HEALBOT_SEAL_OF_THE_MARTYR      = GetSpellInfo(53720) or "殉節聖印"
HEALBOT_RIGHTEOUS_FURY          = GetSpellInfo(25780) or "正義之怒"
HEALBOT_DEVOTION_AURA           = GetSpellInfo(465) or "虔誠光環"
HEALBOT_RETRIBUTION_AURA        = GetSpellInfo(7294) or "懲罰光環"
HEALBOT_CONCENTRATION_AURA      = GetSpellInfo(19746) or "專注光環"
HEALBOT_SHR_AURA                = GetSpellInfo(19876) or "暗影抗性光環"
HEALBOT_FRR_AURA                = GetSpellInfo(19888) or "冰霜抗性光環"
HEALBOT_FIR_AURA                = GetSpellInfo(19891) or "火焰抗性光環"
HEALBOT_CRUSADER_AURA           = GetSpellInfo(32223) or "十字軍光環"

HEALBOT_A_MONKEY           = GetSpellInfo(13163) or "靈猴守護"
HEALBOT_A_HAWK             = GetSpellInfo(13165) or "雄鷹守護"
HEALBOT_A_CHEETAH          = GetSpellInfo(5118) or "獵豹守護"
HEALBOT_A_BEAST            = GetSpellInfo(13161) or "野獸守護"
HEALBOT_A_PACK             = GetSpellInfo(13159) or "豹群守護"
HEALBOT_A_WILD             = GetSpellInfo(20043) or "野性守護"
HEALBOT_A_VIPER            = GetSpellInfo(34074) or "蝮蛇守護"
HEALBOT_A_DRAGONHAWK       = GetSpellInfo(61846) or "龍鷹守護"
HEALBOT_MENDPET            = GetSpellInfo(136) or "治療寵物"

HEALBOT_UNENDING_BREATH    = GetSpellInfo(5697) or "魔息術"

HEALBOT_RESURRECTION       = GetSpellInfo(2006) or "復活術";
HEALBOT_REDEMPTION         = GetSpellInfo(7328) or "救贖";
HEALBOT_REBIRTH            = GetSpellInfo(20484) or "復生";
HEALBOT_ANCESTRALSPIRIT    = GetSpellInfo(2008) or "先祖之魂";

HEALBOT_PURIFY             = GetSpellInfo(1152) or "純淨術";
HEALBOT_CLEANSE            = GetSpellInfo(4987) or "淨化術";
HEALBOT_CURE_POISON        = GetSpellInfo(8946) or "消毒術";
HEALBOT_REMOVE_CURSE       = GetSpellInfo(2782) or "解除詛咒";
HEALBOT_ABOLISH_POISON     = GetSpellInfo(2893) or "驅毒術";
HEALBOT_CURE_DISEASE       = GetSpellInfo(528) or "祛病術";
HEALBOT_ABOLISH_DISEASE    = GetSpellInfo(552) or "驅除疾病";
HEALBOT_DISPEL_MAGIC       = GetSpellInfo(527) or "驅散魔法";
HEALBOT_CLEANSE_SPIRIT	   = GetSpellInfo(51886) or "淨化靈魂";
HEALBOT_DISEASE            = "疾病";
HEALBOT_MAGIC              = "魔法";
HEALBOT_CURSE              = "詛咒";
HEALBOT_POISON             = "毒";

HEALBOT_DEBUFF_ANCIENT_HYSTERIA = "上古狂亂";
HEALBOT_DEBUFF_IGNITE_MANA      = "點燃法力";
HEALBOT_DEBUFF_TAINTED_MIND     = "污濁之魂";
HEALBOT_DEBUFF_VIPER_STING      = "蝮蛇釘刺";
HEALBOT_DEBUFF_SILENCE          = "沉默";
HEALBOT_DEBUFF_MAGMA_SHACKLES   = "熔巖鐐銬";
HEALBOT_DEBUFF_FROSTBOLT        = "寒冰箭";
HEALBOT_DEBUFF_HUNTERS_MARK     = "獵人印記";
HEALBOT_DEBUFF_SLOW             = "減速術";
HEALBOT_DEBUFF_ARCANE_BLAST     = "秘法衝擊";
HEALBOT_DEBUFF_IMPOTENCE        = "無能詛咒";--tbc spell
HEALBOT_DEBUFF_DECAYED_STR      = "力量衰減";
HEALBOT_DEBUFF_DECAYED_INT      = "智力衰減";--tbc Decayed Intellect
HEALBOT_DEBUFF_CRIPPLE          = "殘廢術";
HEALBOT_DEBUFF_CHILLED          = "冰凍";
HEALBOT_DEBUFF_CONEOFCOLD       = "冰錐術";
HEALBOT_DEBUFF_CONCUSSIVESHOT   = "震盪射擊";
HEALBOT_DEBUFF_THUNDERCLAP      = "雷霆一擊";
HEALBOT_DEBUFF_HOWLINGSCREECH   = "尖銳嚎叫";--tbc
HEALBOT_DEBUFF_DAZED            = "暈眩";
HEALBOT_DEBUFF_UNSTABLE_AFFL    = "痛苦動盪";--tbc
HEALBOT_DEBUFF_DREAMLESS_SLEEP  = "無夢睡眠";
HEALBOT_DEBUFF_GREATER_DREAMLESS = "強效昏睡";
HEALBOT_DEBUFF_MAJOR_DREAMLESS  = "極效昏睡";--tbc
HEALBOT_DEBUFF_FROST_SHOCK      = "冰霜震擊"
HEALBOT_DEBUFF_WEAKENED_SOUL    = "虛弱靈魂"

HEALBOT_RANK_1              = "(等級 1)";
HEALBOT_RANK_2              = "(等級 2)";
HEALBOT_RANK_3              = "(等級 3)";
HEALBOT_RANK_4              = "(等級 4)";
HEALBOT_RANK_5              = "(等級 5)";
HEALBOT_RANK_6              = "(等級 6)";
HEALBOT_RANK_7              = "(等級 7)";
HEALBOT_RANK_8              = "(等級 8)";
HEALBOT_RANK_9              = "(等級 9)";
HEALBOT_RANK_10             = "(等級 10)";
HEALBOT_RANK_11             = "(等級 11)";
HEALBOT_RANK_12             = "(等級 12)";
HEALBOT_RANK_13             = "(等級 13)";
HEALBOT_RANK_14             = "(等級 14)";
HEALBOT_RANK_15             = "(等級 15)";
HEALBOT_RANK_16             = "(等級 16)";
HEALBOT_RANK_17             = "(等級 17)";
HEALBOT_RANK_18             = "(等級 18)";

HB_SPELL_PATTERN_LESSER_HEAL         = "治療目標，恢復(%d+)到(%d+)點生命力";
HB_SPELL_PATTERN_HEAL                = "治療目標，恢復(%d+)到(%d+)點生命力";
HB_SPELL_PATTERN_GREATER_HEAL        = "施法緩慢的法術，可以為單一目標治療(%d+)到(%d+)點傷害";
HB_SPELL_PATTERN_FLASH_HEAL          = "治療友方目標(%d+)到(%d+)點生命力";
HB_SPELL_PATTERN_RENEW               = "治療目標，在(%d+)秒內恢復總計(%d+)點生命力";
HB_SPELL_PATTERN_RENEW1              = "治療目標，在(%d+)秒內恢復總計(%d+)到(%d+)點生命力";
HB_SPELL_PATTERN_RENEW2              = "不需要。";
HB_SPELL_PATTERN_RENEW3              = "不需要。";
HB_SPELL_PATTERN_SHIELD              = "可吸收(%d+)點傷害，持續(%d+)秒";
HB_SPELL_PATTERN_HEALING_TOUCH       = "治療友方目標，恢復(%d+)到(%d+)點生命力";
HB_SPELL_PATTERN_REGROWTH            = "治療友方目標，恢復(%d+)到(%d+)點生命力，並在(%d+)秒內恢復額外的(%d+)點生命力";
HB_SPELL_PATTERN_REGROWTH1           = "治療友方目標，恢復(%d+)到(%d+)點生命力，並在(%d+)秒內恢復額外的(%d+)到(%d+)點生命力";
HB_SPELL_PATTERN_HOLY_LIGHT          = "治療友方目標，恢復(%d+)到(%d+)點生命力";
HB_SPELL_PATTERN_FLASH_OF_LIGHT      = "治療友方目標，恢復(%d+)到(%d+)點生命力";
HB_SPELL_PATTERN_HEALING_WAVE        = "治療友方目標，恢復(%d+)到(%d+)點生命力";
HB_SPELL_PATTERN_LESSER_HEALING_WAVE = "治療友方目標，恢復(%d+)到(%d+)點生命力";
HB_SPELL_PATTERN_REJUVENATION        = "治療目標，在(%d+)秒內恢復總計(%d+)點生命力";
HB_SPELL_PATTERN_REJUVENATION1       = "治療目標，在(%d+)秒內恢復總計(%d+)到(%d+)點生命力";
HB_SPELL_PATTERN_REJUVENATION2       = "不需要。";
HB_SPELL_PATTERN_MEND_PET            = "正在治療寵物，在(%d+)秒內為其恢復(%d+)點生命力";

HB_TOOLTIP_MANA                    = "^(%d+)法力$";
HB_TOOLTIP_RANGE                   = "(%d+)碼距離";
HB_TOOLTIP_INSTANT_CAST            = "瞬發法術";
HB_TOOLTIP_CAST_TIME               = "(%d+.?%d*)秒施法時間";
HB_TOOLTIP_CHANNELED               = "需引導";
HB_TOOLTIP_OFFLINE                 = "離線";
HB_OFFLINE              = "離線"; -- has gone offline msg
HB_ONLINE               = "在線"; -- has come online msg
HB_HASLEFTRAID                   = "^([^%s]+)離開了團隊";
HB_HASLEFTPARTY                  = "^([^%s]+)離開了隊伍";
HB_YOULEAVETHEGROUP              = "你離開了隊伍。"
HB_YOULEAVETHERAID               = "你已經離開了這個團隊。"
HB_YOUJOINTHERAID                = "你加入了一個團隊。"
HB_YOUJOINTHEGROUP               = "你加入了隊伍。"

-----------------
-- Translation --
-----------------

HEALBOT_ADDON = "HealBot " .. HEALBOT_VERSION;
HEALBOT_LOADED = " 載入";

HEALBOT_ACTION_OPTIONS    = "設定";

HEALBOT_OPTIONS_TITLE         = HEALBOT_ADDON;
HEALBOT_OPTIONS_DEFAULTS      = "預設";
HEALBOT_OPTIONS_CLOSE         = "結束";
HEALBOT_OPTIONS_HARDRESET     = "重載 UI"
HEALBOT_OPTIONS_SOFTRESET     = "重置 HB"
HEALBOT_OPTIONS_INFO          = "訊息"
HEALBOT_OPTIONS_TAB_GENERAL   = "一般";
HEALBOT_OPTIONS_TAB_SPELLS    = "法術";
HEALBOT_OPTIONS_TAB_HEALING   = "治療";
HEALBOT_OPTIONS_TAB_CDC       = "驅散";
HEALBOT_OPTIONS_TAB_SKIN      = "面板";
HEALBOT_OPTIONS_TAB_TIPS      = "提示";
HEALBOT_OPTIONS_TAB_BUFFS     = "增益"

HEALBOT_OPTIONS_PANEL_TEXT    = "治療面板設定"
HEALBOT_OPTIONS_BARALPHA      = "動作條透明度";
HEALBOT_OPTIONS_BARALPHAINHEAL = "進入治療時透明度";
HEALBOT_OPTIONS_BARALPHAEOR   = "超出範圍時透明度";
HEALBOT_OPTIONS_ACTIONLOCKED  = "鎖定";
HEALBOT_OPTIONS_AUTOSHOW      = "關閉自動顯示";
HEALBOT_OPTIONS_PANELSOUNDS   = "使用音效提示";
HEALBOT_OPTIONS_HIDEOPTIONS   = "隱藏設定按鈕";
HEALBOT_OPTIONS_PROTECTPVP    = "防止意外進入PVP狀態";
HEALBOT_OPTIONS_HEAL_CHATOPT  = "聊天選項";

HEALBOT_OPTIONS_SKINTEXT      = "使用面板"
HEALBOT_SKINS_STD             = "標準"
HEALBOT_OPTIONS_SKINTEXTURE   = "材質"
HEALBOT_OPTIONS_SKINHEIGHT    = "高度"
HEALBOT_OPTIONS_SKINWIDTH     = "寬度"
HEALBOT_OPTIONS_SKINNUMCOLS   = "欄位編號"
HEALBOT_OPTIONS_SKINNUMHCOLS  = "在標題顯示編號"
HEALBOT_OPTIONS_SKINBRSPACE   = "直列間隔"
HEALBOT_OPTIONS_SKINBCSPACE   = "橫列間隔"
HEALBOT_OPTIONS_EXTRASORT     = "排列方式"
HEALBOT_SORTBY_NAME           = "名稱"
HEALBOT_SORTBY_CLASS          = "職業"
HEALBOT_SORTBY_GROUP          = "隊伍"
HEALBOT_SORTBY_MAXHEALTH      = "最大生命值"
HEALBOT_OPTIONS_NEWDEBUFFTEXT = "新Debuff"
HEALBOT_OPTIONS_DELSKIN       = "刪除"
HEALBOT_OPTIONS_NEWSKINTEXT   = "新面板"
HEALBOT_OPTIONS_SAVESKIN      = "儲存"
HEALBOT_OPTIONS_SKINBARS      = "動作條設定"
HEALBOT_OPTIONS_SKINPANEL     = "面板風格"
HEALBOT_SKIN_ENTEXT           = "啟用"
HEALBOT_SKIN_DISTEXT          = "關閉"
HEALBOT_SKIN_DEBTEXT          = "Debuff"
HEALBOT_SKIN_BACKTEXT         = "背景顏色"
HEALBOT_SKIN_BORDERTEXT       = "邊框顏色"
HEALBOT_OPTIONS_SKINFONT      = "字體"
HEALBOT_OPTIONS_SKINFHEIGHT   = "字體大小"
HEALBOT_OPTIONS_BARALPHADIS   = "關閉透明度"
HEALBOT_OPTIONS_SHOWHEADERS   = "顯示標題"

HEALBOT_OPTIONS_ITEMS  = "物品";
HEALBOT_OPTIONS_SPELLS = "法術";

HEALBOT_OPTIONS_COMBOCLASS    = "組合鍵設定";
HEALBOT_OPTIONS_CLICK         = "點擊";
HEALBOT_OPTIONS_SHIFT         = "Shift";
HEALBOT_OPTIONS_CTRL          = "Ctrl";
HEALBOT_OPTIONS_ENABLEHEALTHY = "總是使用已啟用的設定";

HEALBOT_OPTIONS_CASTNOTIFY1   = "關閉通知";
HEALBOT_OPTIONS_CASTNOTIFY2   = "通知自己";
HEALBOT_OPTIONS_CASTNOTIFY3   = "通知目標";
HEALBOT_OPTIONS_CASTNOTIFY4   = "通知隊伍";
HEALBOT_OPTIONS_CASTNOTIFY5   = "通知團隊";
HEALBOT_OPTIONS_CASTNOTIFY6   = "通知頻道";
HEALBOT_OPTIONS_CASTNOTIFYRESONLY = "只通知復活目標";
HEALBOT_OPTIONS_TARGETWHISPER = "治療時密語目標";

HEALBOT_OPTIONS_CDCBARS       = "色彩設定";
HEALBOT_OPTIONS_CDCSHOWHBARS  = "顯示生命條";
HEALBOT_OPTIONS_CDCSHOWABARS  = "顯示仇恨條";
HEALBOT_OPTIONS_CDCCLASS      = "監視職業";
HEALBOT_OPTIONS_CDCWARNINGS   = "Debuff警報";
HEALBOT_OPTIONS_SHOWDEBUFFICON = "顯示Debuff圖示";
HEALBOT_OPTIONS_SHOWDEBUFFWARNING = "有Debuff時顯示警告";
HEALBOT_OPTIONS_SOUNDDEBUFFWARNING = "有Debuff時音效提示";
HEALBOT_OPTIONS_SOUND         = "音效"
HEALBOT_OPTIONS_SOUND1        = "音效 1"
HEALBOT_OPTIONS_SOUND2        = "音效 2"
HEALBOT_OPTIONS_SOUND3        = "音效 3"

HEALBOT_OPTIONS_HEAL_BUTTONS  = "治療動作條:";
HEALBOT_OPTIONS_SELFHEALS     = "自我"
HEALBOT_OPTIONS_PETHEALS      = "寵物"
HEALBOT_OPTIONS_GROUPHEALS    = "小隊";
HEALBOT_OPTIONS_TANKHEALS     = "主坦";
HEALBOT_OPTIONS_TARGETHEALS   = "目標";
HEALBOT_OPTIONS_EMERGENCYHEALS= "額外";
HEALBOT_OPTIONS_ALERTLEVEL    = "OT警報等級設定";
HEALBOT_OPTIONS_EMERGFILTER   = "設定團隊框架";
HEALBOT_OPTIONS_EMERGFCLASS   = "設定分類治療";
HEALBOT_OPTIONS_COMBOBUTTON   = "按鈕";
HEALBOT_OPTIONS_BUTTONLEFT    = "左";
HEALBOT_OPTIONS_BUTTONMIDDLE  = "中";
HEALBOT_OPTIONS_BUTTONRIGHT   = "右";
HEALBOT_OPTIONS_BUTTON4       = "按鈕4";
HEALBOT_OPTIONS_BUTTON5       = "按鈕5";

HEALBOT_CLASSES_ALL     = "所有職業";
HEALBOT_CLASSES_MELEE   = "近戰";
HEALBOT_CLASSES_RANGES  = "遠程";
HEALBOT_CLASSES_HEALERS = "治療";
HEALBOT_CLASSES_CUSTOM  = "自定";

HEALBOT_OPTIONS_SHOWTOOLTIP     = "顯示提示";
HEALBOT_OPTIONS_SHOWDETTOOLTIP  = "顯示詳細法術訊息";
HEALBOT_OPTIONS_SHOWUNITTOOLTIP = "顯示目標訊息";
HEALBOT_OPTIONS_SHOWRECTOOLTIP  = "顯示建議的治療";
HEALBOT_OPTIONS_SHOWPDCTOOLTIP  = "顯示預設組合";--check
HEALBOT_TOOLTIP_POSDEFAULT      = "預設位置";
HEALBOT_TOOLTIP_POSLEFT         = "Healbot左側";
HEALBOT_TOOLTIP_POSRIGHT        = "Healbot右側";
HEALBOT_TOOLTIP_POSABOVE        = "Healbot上面";
HEALBOT_TOOLTIP_POSBELOW        = "Healbot下面";
HEALBOT_TOOLTIP_POSCURSOR       = "跟隨遊標";
HEALBOT_TOOLTIP_RECOMMENDTEXT   = "建議的治療";
HEALBOT_TOOLTIP_NONE            = "無可用";
HEALBOT_TOOLTIP_ITEMBONUS       = "法術能量";
HEALBOT_TOOLTIP_ACTUALBONUS     = "實際加成是";
HEALBOT_TOOLTIP_SHIELD          = "治療";
HEALBOT_TOOLTIP_LOCATION        = "位置";
HEALBOT_TOOLTIP_CORPSE          = "屍體 of "; --check
HEALBOT_WORDS_OVER              = "持續時間";
HEALBOT_WORDS_SEC               = "秒";
HEALBOT_WORDS_TO                = "到";
HEALBOT_WORDS_CAST              = "施放時間";
HEALBOT_WORDS_FOR               = "為";
HEALBOT_WORDS_UNKNOWN           = "未知";
HEALBOT_WORDS_YES               = "是";
HEALBOT_WORDS_NO                = "否";

HEALBOT_WORDS_NONE              = "無";
HEALBOT_OPTIONS_ALT             = "Alt";
HEALBOT_DISABLED_TARGET         = "目標";
HEALBOT_OPTIONS_SHOWCLASSONBAR  = "顯示職業名稱";
HEALBOT_OPTIONS_SHOWHEALTHONBAR = "顯示生命";
HEALBOT_OPTIONS_BARHEALTHINCHEALS = "包含進入治療";
HEALBOT_OPTIONS_BARHEALTH1      = "數值";
HEALBOT_OPTIONS_BARHEALTH2      = "百分比";
HEALBOT_OPTIONS_TIPTEXT         = "提示訊息";
HEALBOT_OPTIONS_BARINFOTEXT     = "動作條訊息";
HEALBOT_OPTIONS_POSTOOLTIP      = "啟用提示";
HEALBOT_OPTIONS_SHOWNAMEONBAR   = "顯示玩家名字";
HEALBOT_OPTIONS_BARCLASSCOLOUR	= "動作條按職業著色";
HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1 = "玩家名字按職業著色";
HEALBOT_OPTIONS_EMERGFILTERGROUPS   = "包含小隊";

HEALBOT_ONE   = "1";
HEALBOT_TWO   = "2";
HEALBOT_THREE = "3";
HEALBOT_FOUR  = "4";
HEALBOT_FIVE  = "5";
HEALBOT_SIX   = "6";
HEALBOT_SEVEN = "7";
HEALBOT_EIGHT = "8";

HEALBOT_OPTIONS_SETDEFAULTS    = "設定成預設選項";
HEALBOT_OPTIONS_SETDEFAULTSMSG = "重置所有設定為預設值";
HEALBOT_OPTIONS_RIGHTBOPTIONS  = "右擊面板打開設定";

HEALBOT_OPTIONS_HEADEROPTTEXT  = "標題設定";
HEALBOT_OPTIONS_ICONOPTTEXT    = "圖示設定";
HEALBOT_SKIN_HEADERBARCOL      = "動作條顏色";
HEALBOT_SKIN_HEADERTEXTCOL     = "字體顏色";
HEALBOT_OPTIONS_BUFFSTEXT1      = "設定施放Buff的技能";
HEALBOT_OPTIONS_BUFFSTEXT2      = "檢查成員";
HEALBOT_OPTIONS_BUFFSTEXT3      = "動作條顏色";
HEALBOT_OPTIONS_BUFF           = "Buff ";
HEALBOT_OPTIONS_BUFFSELF       = "對自己";
HEALBOT_OPTIONS_BUFFPARTY      = "對小隊";
HEALBOT_OPTIONS_BUFFRAID       = "對團隊";
HEALBOT_OPTIONS_MONITORBUFFS   = "監測缺少的Buff";
HEALBOT_OPTIONS_MONITORBUFFSC  = "戰鬥中同樣監測";
HEALBOT_OPTIONS_ENABLESMARTCAST  = "當結束戰鬥開啟智能施法視窗";
HEALBOT_OPTIONS_SMARTCASTSPELLS  = "包含法術";
HEALBOT_OPTIONS_SMARTCASTDISPELL = "解除 Debuff";
HEALBOT_OPTIONS_SMARTCASTBUFF    = "增加 Buff";
HEALBOT_OPTIONS_SMARTCASTHEAL    = "治療法術";
HEALBOT_OPTIONS_BAR2SIZE         = "法力條大小";
HEALBOT_OPTIONS_SETSPELLS        = "設定法術";
HEALBOT_OPTIONS_ENABLEDBARS     = "總是啟用動作條";
HEALBOT_OPTIONS_DISABLEDBARS    = "忽略時間極短的Debuff";
HEALBOT_OPTIONS_MONITORDEBUFFS  = "監測Debuff";
HEALBOT_OPTIONS_DEBUFFTEXT1     = "設定解Debuff的技能";

HEALBOT_OPTIONS_IGNOREDEBUFF         = "忽略的Debuff:";
HEALBOT_OPTIONS_IGNOREDEBUFFCLASS    = "職業忽略";
HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT = "減速效果";
HEALBOT_OPTIONS_IGNOREDEBUFFDURATION = "短時間";
HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM   = "無害效果";

HEALBOT_OPTIONS_RANGECHECKFREQ       = "距離檢測頻率";
HEALBOT_OPTIONS_RANGECHECKUNITS      = "在施法距離內尋找傷害最大及最小單位"

HEALBOT_OPTIONS_HIDEPARTYFRAMES      = "隱藏隊伍框體";
HEALBOT_OPTIONS_HIDEPLAYERTARGET     = "包含玩家和目標";
HEALBOT_OPTIONS_DISABLEHEALBOT       = "關閉HealBot視窗";

HEALBOT_OPTIONS_CHECKEDTARGET        = "檢查";

HEALBOT_ASSIST      = "協助";
HEALBOT_FOCUS       = "焦點";
HEALBOT_MENU        = "目錄";
HEALBOT_MAINTANK    = "主坦";
HEALBOT_MAINASSIST  = "主協助";

HEALBOT_TITAN_SMARTCAST      = "智能施法視窗";
HEALBOT_TITAN_MONITORBUFFS   = "監視Buff";
HEALBOT_TITAN_MONITORDEBUFFS = "監視Debuff"
HEALBOT_TITAN_SHOWBARS       = "顯示動作條";
HEALBOT_TITAN_EXTRABARS      = "額外動作條";
HEALBOT_BUTTON_TOOLTIP       = "左鍵 打開HealBot設定面板\n右鍵 (按住) 移動圖示";
HEALBOT_TITAN_TOOLTIP        = "左鍵 打開HealBot設定面板";
HEALBOT_OPTIONS_SHOWMINIMAPBUTTON = "顯示小地圖按鈕";
HEALBOT_OPTIONS_BARBUTTONSHOWHOT  = "顯示HoT圖示";
HEALBOT_OPTIONS_HOTONBAR     = "打開"
HEALBOT_OPTIONS_HOTOFFBAR    = "關閉"
HEALBOT_OPTIONS_HOTBARRIGHT  = "右邊"
HEALBOT_OPTIONS_HOTBARLEFT   = "左邊"

HEALBOT_OPTIONS_ENABLETARGETSTATUS = "當目標進入戰鬥，使用已啟用的設定"

HEALBOT_ZONE_AB = "阿拉希盆地";
HEALBOT_ZONE_AV = "奧特蘭克山谷";
HEALBOT_ZONE_ES = "暴風之眼";
HEALBOT_ZONE_WG = "戰歌峽谷";

HEALBOT_OPTION_AGGROTRACK = "仇恨提醒"
HEALBOT_OPTION_AGGROBAR = "閃爍條"
HEALBOT_OPTION_AGGROTXT = ">> 顯示文字 <<"
HEALBOT_OPTION_BARUPDFREQ = "閃爍頻率"
HEALBOT_OPTION_USEFLUIDBARS = "動態監視"
HEALBOT_OPTION_CPUPROFILE  = "使用CPU性能測試（插件CPU使用訊息）"
HEALBOT_OPTIONS_RELOADUIMSG = "該選項需要重載UI，現在重載嗎？"

HEALBOT_SELF_PVP              = "自身PvP"
HEALBOT_OPTIONS_ANCHOR        = "錨點"
HEALBOT_OPTIONS_TOPLEFT       = "左上"
HEALBOT_OPTIONS_BOTTOMLEFT    = "左下"
HEALBOT_OPTIONS_TOPRIGHT      = "右上"
HEALBOT_OPTIONS_BOTTOMRIGHT   = "右下"

HEALBOT_PANEL_BLACKLIST       = "黑名單"

HEALBOT_WORDS_REMOVEFROM      = "移除";
HEALBOT_WORDS_ADDTO           = "增加";
HEALBOT_WORDS_INCLUDE         = "包含";

HEALBOT_OPTIONS_TTALPHA       = "透明度"
HEALBOT_TOOLTIP_TARGETBAR     = "目標監視條"
HEALBOT_OPTIONS_MYTARGET      = "我的目標"

HEALBOT_DISCONNECTED_TEXT			= "<離線>"
HEALBOT_OPTIONS_SHOWUNITBUFFTIME    = "顯示我的增益";
HEALBOT_OPTIONS_TOOLTIPUPDATE       = "不斷更新提示";
HEALBOT_OPTIONS_BUFFSTEXTTIMER      = "在增益效果結束前顯示";
HEALBOT_OPTIONS_SHORTBUFFTIMER      = "短增益"
HEALBOT_OPTIONS_LONGBUFFTIMER       = "長增益"

HEALBOT_BALANCE       = "平衡"
HEALBOT_FERAL         = "野性戰鬥"--check
HEALBOT_RESTORATION   = "恢復"
HEALBOT_SHAMAN_RESTORATION = "恢復"
HEALBOT_ARCANE        = "秘法"
HEALBOT_FIRE          = "火焰"
HEALBOT_FROST         = "冰霜"
HEALBOT_DISCIPLINE    = "戒律"
HEALBOT_HOLY          = "神聖"
HEALBOT_SHADOW        = "暗影"
HEALBOT_ASSASSINATION = "刺殺"
HEALBOT_COMBAT        = "戰鬥"
HEALBOT_SUBTLETY      = "敏銳"
HEALBOT_ARMS          = "武器"
HEALBOT_FURY          = "狂怒"
HEALBOT_PROTECTION    = "防禦"
HEALBOT_BEASTMASTERY  = "野獸控制"
HEALBOT_MARKSMANSHIP  = "射擊"
HEALBOT_SURVIVAL      = "生存"
HEALBOT_RETRIBUTION   = "懲戒"
HEALBOT_ELEMENTAL     = "元素"
HEALBOT_ENHANCEMENT   = "增強"
HEALBOT_AFFLICTION    = "痛苦"
HEALBOT_DEMONOLOGY    = "惡魔學識"
HEALBOT_DESTRUCTION   = "毀滅"
HEALBOT_BLOOD         = "鮮血"
HEALBOT_UNHOLY        = "邪惡"

HEALBOT_OPTIONS_VISIBLERANGE = "當超過100碼距離禁用狀態條"
HEALBOT_OPTIONS_NOTIFY_HEAL_MSG  = "治療訊息"
HEALBOT_OPTIONS_NOTIFY_OTHER_MSG = "其他訊息"
HEALBOT_WORDS_YOU                = "你";
HEALBOT_NOTIFYHEALMSG            = "施放#s，為#n治療了#h點生命力";
HEALBOT_NOTIFYOTHERMSG           = "在#n身上施放了#s";

HEALBOT_OPTIONS_HOTPOSITION     = "圖示位置"
HEALBOT_OPTIONS_HOTSHOWTEXT     = "顯示圖示文本"
HEALBOT_OPTIONS_HOTTEXTCOUNT    = "次數"
HEALBOT_OPTIONS_HOTTEXTDURATION = "持續時間"
HEALBOT_OPTIONS_ICONSCALE       = "圖示縮放比例"
HEALBOT_OPTIONS_ICONTEXTSCALE   = "圖示文字縮放比例"

HEALBOT_SKIN_FLUID              = "流動"
HEALBOT_SKIN_VIVID              = "生動"
HEALBOT_SKIN_LIGHT              = "光亮"
HEALBOT_SKIN_SQUARE             = "方形"
HEALBOT_OPTIONS_AGGROBARSIZE    = "OT狀態條尺寸"
HEALBOT_OPTIONS_TARGETBARMODE   = "限制目標狀態條在預設定中"
HEALBOT_OPTIONS_DOUBLETEXTLINES = "兩排文字"
HEALBOT_OPTIONS_TEXTALIGNMENT   = "調整文字"
HEALBOT_OPTIONS_ENABLELIBQH     = "啟用快速治療函式庫 LibQuickHealth"
HEALBOT_VEHICLE                 = "載具"
HEALBOT_OPTIONS_UNIQUESPEC      = "為每個按鈕儲存獨特的法術技能"
HEALBOT_WORDS_ERROR		= "錯誤"
HEALBOT_SPELL_NOT_FOUND         = "找不到法術" --check

end