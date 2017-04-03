if (GetLocale() == "zhTW") then

PowaAuras.Anim[0] = "[無]";
PowaAuras.Anim[1] = "靜止";
PowaAuras.Anim[2] = "閃光效果";
PowaAuras.Anim[3] = "生長效果";
PowaAuras.Anim[4] = "脈搏效果";
PowaAuras.Anim[5] = "氣泡效果";
PowaAuras.Anim[6] = "水滴效果";
PowaAuras.Anim[7] = "漏電效果";
PowaAuras.Anim[8] = "收縮效果";
PowaAuras.Anim[9] = "火焰效果";
PowaAuras.Anim[10] = "盤旋效果";

PowaAuras.BeginAnimDisplay[0] = "[無]";
PowaAuras.BeginAnimDisplay[1] = "由小放大";
PowaAuras.BeginAnimDisplay[2] = "由大漸小";
PowaAuras.BeginAnimDisplay[3] = "逐漸清晰";
PowaAuras.BeginAnimDisplay[4] = "左邊進入";
PowaAuras.BeginAnimDisplay[5] = "左上進入";
PowaAuras.BeginAnimDisplay[6] = "上部進入";
PowaAuras.BeginAnimDisplay[7] = "右上進入";
PowaAuras.BeginAnimDisplay[8] = "右邊進入";
PowaAuras.BeginAnimDisplay[9] = "右下進入";
PowaAuras.BeginAnimDisplay[10] = "下部進入";
PowaAuras.BeginAnimDisplay[11] = "左下進入";
PowaAuras.BeginAnimDisplay[12] = "彈跳進入";

PowaAuras.EndAnimDisplay[0] = "[無]";
PowaAuras.EndAnimDisplay[1] = "放大消失";
PowaAuras.EndAnimDisplay[2] = "縮小消失";
PowaAuras.EndAnimDisplay[3] = "淡化消失";
PowaAuras.EndAnimDisplay[4] = "旋轉漸隱";
PowaAuras.EndAnimDisplay[5] = "旋轉縮小"; 

PowaAuras.Sound[0] = "[無]";

PowaAuras:MergeTables(PowaAuras.Text, 
{
	welcome = "輸入 /powa 打開特效編輯器.",

	aucune = "無",
	aucun = "無",
	largeur = "寬度",
	hauteur = "高度",
	mainHand = "主手",
	offHand = "副手",
	bothHands = "雙手",

	DebuffType =
	{
		Magic   = "魔法",
		Disease = "疾病",
		Curse   = "詛咒",
		Poison  = "中毒",
	},

	DebuffCatType =
	{
		[PowaAuras.DebuffCatType.CC] = "CC", --- need confirm this translation. by doomiris
		[PowaAuras.DebuffCatType.Silence] = "沈默",
		[PowaAuras.DebuffCatType.Snare] = "誘捕",
		[PowaAuras.DebuffCatType.Stun] = "昏迷",
		[PowaAuras.DebuffCatType.Root] = "無法行動",
		[PowaAuras.DebuffCatType.Disarm] = "繳械",
		[PowaAuras.DebuffCatType.PvE] = "PvE",
	},
	
	AuraType =
	{
		[PowaAuras.BuffTypes.Buff] = "Buff",
		[PowaAuras.BuffTypes.Debuff] = "Debuff",
		[PowaAuras.BuffTypes.AoE] = "AOE法術",
		[PowaAuras.BuffTypes.TypeDebuff] = "Debuff類型",
		[PowaAuras.BuffTypes.Enchant] = "武器強化",
		[PowaAuras.BuffTypes.Combo] = "連擊點數",
		[PowaAuras.BuffTypes.ActionReady] = "技能冷卻",
		[PowaAuras.BuffTypes.Health] = "生命值",
		[PowaAuras.BuffTypes.Mana] = "魔法值",
		[PowaAuras.BuffTypes.EnergyRagePower] = "怒氣/能量/符文能量", 
		[PowaAuras.BuffTypes.Aggro] = "獲得仇恨",
		[PowaAuras.BuffTypes.PvP] = "PvP標誌",
		[PowaAuras.BuffTypes.Stance] = "姿態",
		[PowaAuras.BuffTypes.SpellAlert] = "法術預警",  
		[PowaAuras.BuffTypes.OwnSpell] = "自身技能",  
		[PowaAuras.BuffTypes.StealableSpell] = "可偷取法術",
		[PowaAuras.BuffTypes.PurgeableSpell] = "可凈化法術",
	},
	
	-- main
	nomEnable = "啟用",
	aideEnable = "啟用/禁用所有PowerAuras特效",

	nomDebug = "調試模式",
	aideDebug = "打開調試模式後,將在聊天窗口顯示特效的觸發條件等信息",
	ListePlayer = "分類",
	ListeGlobal = "全局",
	aideMove = "移動特效",
	aideCopy = "復制特效",
	nomRename = "重命名",
	aideRename = "重命名我的特效分類名",
	nomTest = "測試",
	nomHide = "全部隱藏",
	nomEdit = "編輯",
	nomNew = "新建",
	nomDel = "刪除",
	nomImport = "導入", 
	nomExport = "導出", 
	nomImportSet = "批量導入", 
	nomExportSet = "批量導出", 
	aideImport = "把特效字串粘貼(Ctrl+v)在此編輯框內,然後點擊\'接受\'按鈕",
	aideExport = "復制(Ctrl+c)此編輯框內的特效字串,與其它人分享你的特效", 
	aideImportSet = "把批量特效字串粘貼(Ctrl+v)在此編輯框內,然後點擊\'接受\'按鈕,註意:批量導入時將會刪除本頁所有現有特效",
	aideExportSet = "復制(Ctrl+c)此編輯框內的特效字串,將此頁內所有特效與其它人分享",
	aideDel = "刪除所選特效(必須按住Ctrl鍵才能使用此功能)",
	nomMove = "移動",
	nomCopy = "復制",
	nomPlayerEffects = "我的特效",
	nomGlobalEffects = "通用特效",
	aideEffectTooltip = "按住Shift鍵點擊圖標以啟用/禁用該特效",

	-- editor
	nomSound = "播放聲音",
	aideSound = "特效觸發時播放聲音",
	nomCustomSound = "自定義聲音文件:",
	aideCustomSound = "輸入聲音文件名稱,如cookie.mp3 註意:你需要在遊戲啟動前把聲音文件放入Sounds文件夾下,目前僅支持mp3和wav格式.",

	nomTexture = "當前材質",
	aideTexture = "顯示特效使用的材質.你可以修改相應文件夾內的.tga 文件來增加特效",

	nomAnim1 = "動畫效果",
	nomAnim2 = "輔助效果",
	aideAnim1 = "是否為所選材質使用動畫效果",
	aideAnim2 = "此動畫效果以較低不透明度顯示,為了不過多占用屏幕同一時間只顯示一個輔助效果",

	nomDeform = "拉伸",
	aideDeform = "在高度或寬度方向拉伸材質",

	aideColor = "點擊此處修改材質顏色",
	aideFont = "點擊此處來選擇字體,點擊OK按鈕使你的選擇生效", 
	aideMultiID = "此處輸入其它特效的ID,以執行聯合檢查.多個ID號須用'/'分隔. 特效ID可以在某個特效的鼠標提示中第一行找到,如:[2],2就是此特效ID", 
	aideTooltipCheck = "此處輸入用於激活特效的某個狀態的鼠標提示文字",

	aideBuff = "此處輸入用於激活特效的buff的名字,或名字中的幾個連續文字.如果使用分隔符,也可以輸入多個buff的名字.例如輸入: 能量灌註/奧術能量",
	aideBuff2 = "此處輸入用於激活特效的debuff的名字,或名字中的幾個連續文字.如果使用分隔符,也可以輸入多個debuff的名字.例如輸入: 墮落治療/燃燒刺激",
	aideBuff3 = "此處輸入用於激活特效的debuff的類型名稱,或名稱中的幾個連續文字.如果使用分隔符,也可以輸入多個debuff類型的名稱.例如輸入: 魔法/詛咒/中毒/疾病",
	aideBuff4 = "此處輸入用於激活特效的AOE法術的名字,AOE法術名字可以在戰鬥記錄中找到.例如輸入:邪惡光環/火焰之雨/暴風雪",
	aideBuff5 = "此處輸入用於激活特效的武器臨時附魔效果.另外你可以通過前置'main/'或者'off/'來指明主副手位置(例如: main/致殘毒藥,表示檢測主手上的這種毒藥)", 
	aideBuff6 = "此處輸入用於激活特效的連擊點數.例如輸入: 1或者1/2/3或者0/4/5等等自由組合",
	aideBuff7 = "此處輸入用於激活特效的動作條上的動作名,或名字中的幾個連續文字,當此動作完全冷卻時此效果觸發.例如輸入:贊達拉英雄護符/法力之潮圖騰/心靈專註",
	aideBuff8 = "此處輸入用於激活特效的法術名稱,或名稱中的一部分,或者是你技能書中的技能,也可以輸入一個技能ID",
	
	aideSpells = "此處輸入用於激活法術預警特效的法術名稱", 
	aideStacks = "輸入用於激活特效的操作符及疊加數量，只能輸入一個操作符，例如：'<5' '>3' '=11' '!5' '>=0' '<=6' '2-8'", 

	aideStealableSpells = "此處輸入可偷取的法術名稱(用 * 將檢測所有可被偷取的法術).",
	aidePurgeableSpells = "此處輸入可凈化的法術名稱(用 * 將檢測所有可被凈化的法術).",

	aideUnitn = "此處輸入用於激活特效的特定成員名稱,必須處於同一團隊",
	aideUnitn2 = "僅用於團隊/隊伍模式",    

	aideMaxTex = "定義特效編輯器使用的材質數量,如果你增加了自定義材質請修改此值.",
	aideAddEffect = "新增加一個特效",
	aideWowTextures = "使用遊戲內置材質",
	aideTextAura = "使用文字做為特效材質(圖形材質將被禁用)", 
	aideRealaura = "清晰光環",
	aideCustomTextures = "使用自定義材質,例如: Flamme.tga(自定義材質需保存在custom文件夾下)",
	aideRandomColor = "每次激活時使用隨機顏色",

	aideTexMode = "材質透明度反向顯示",
	
	nomActivationBy = "激活條件",

	nomOwnTex = "使用技能圖標", 
	aideOwnTex = "使用buff/debuff或技能的默認圖標做為材質", 
	nomStacks = "疊加", --no longer used?

	nomUpdateSpeed = "更新速度",
	nomSpeed = "運動速度",
	nomFPS = "全局動畫幀數",
	nomTimerUpdate = "計時器更新速度",
	nomBegin = "進場效果",
	nomEnd = "結束效果",
	nomSymetrie = "對稱性",
	nomAlpha = "不透明度",
	nomPos = "位置",
	nomTaille = "大小",

	nomExact = "精確匹配名稱",
	nomThreshold = "觸發極限",
	aideThreshInv = "選中此項可反轉觸發邏輯. 生命值/法力值: 默認=低於指定值時觸發特效 / 選中此項後=高於指定值時觸發特效. 能量/怒氣/符文能量: 默認=高於指定值時觸發特效 / 選中此項後=低於指定值時觸發特效",
	nomThreshInv = "</>", 
	nomStance = "姿態",

	nomMine = "自己施放的", 
	aideMine = "選中此項則僅檢測由玩家自己施放的buff/debuff", 
	nomDispellable = "自己可以驅散的",
	aideDispellable = "選中此項則僅檢測可被驅散的buff",
	nomCanInterrupt = "可打斷",
	aideCanInterrupt = "選中此項則僅檢測可被打斷的技能",

	nomPlayerSpell = "施法狀態",
	aidePlayerSpell = "檢測玩家是否正在詠唱一個法術",

	nomCheckTarget = "敵方目標",
	nomCheckFriend = "友方目標",
	nomCheckParty = "團隊目標",
	nomCheckFocus = "焦點目標",
	nomCheckRaid = "團隊成員",
	nomCheckGroupOrSelf = "團隊/小隊或自己",
	nomCheckGroupAny = "任何人", 
	nomCheckOptunitn = "特定成員",

	aideTarget = "此buff/debuff僅存在於敵方目標上",
	aideTargetFriend = "此buff/debuff僅存在於友方目標上",
	aideParty = "此buff/debuff僅存在於小隊中",
	aideGroupOrSelf = "選中此項後將僅對團隊或小隊成員(包括自己)進行檢測",
	aideFocus = "此buff/debuff僅存在焦點目標上",
	aideRaid = "此buff/debuff僅存在於團隊中",
	aideGroupAny = "選中此項後,當任何一個小隊/團隊成員有此buff/debuff就觸發特效. 不選中此項(默認狀態),則檢查到所有人都有此buff/debuff才觸發特效", 
	aideOptunitn = "此buff/debuff僅存在於團隊/小隊中的特定成員身上",
	aideExact = "選中此項將精確匹配buff/debuff名稱",
	aideStance = "選擇用於觸發特效的姿態",

	aideShowSpinAtBeginning= "起始動畫結束後使其做360度旋轉",
	nomCheckShowSpinAtBeginning = "動畫結束後旋轉",

	nomCheckShowTimer = "顯示",
	nomTimerDuration = "延遲消失",
	aideTimerDuration = "目標上的buff/debuff計時器延遲到此時間結束後再消失(0為禁用)",
	aideShowTimer = "為此效果顯示計時器",
	aideSelectTimer = "選擇使用何種計時器來顯示持續時間",
	aideSelectTimerBuff = "選擇使用何種計時器來顯示持續時間(僅用於玩家buff)",
	aideSelectTimerDebuff = "選擇使用何種計時器來顯示持續時間(僅用於玩家debuff)",

	nomCheckShowStacks = "疊加次數",

	nomCheckInverse = "不存在",
	aideInverse = "選中此項後,僅當buff/debuff不存在時顯示此特效",	

	nomCheckIgnoreMaj = "忽略大小寫",	
	aideIgnoreMaj = "選中此項將忽略buff/debuff名字的大小寫字母(供英文玩家使用,中國玩家不需要修改此項)",

	nomDuration = "延遲消失",
	aideDuration = "特效延遲到此時間結束後再消失(0為禁用)",

	nomCentiemes = "顯示百分位",
	nomDual = "顯示兩個計時器",
	nomHideLeadingZeros = "隱藏前置零位,如:08秒顯示為8秒",
	nomTransparent = "使用透明材質",
	nomUpdatePing = "刷新提示",
	nomClose = "關閉",
	nomEffectEditor = "特效編輯器",
	nomAdvOptions = "選項",
	nomMaxTex = "最大可用材質",
	nomTabAnim = "動畫",
	nomTabActiv = "條件",
	nomTabSound = "聲音",
	nomTabTimer = "計時器",
	nomTabStacks = "疊加", 
	nomWowTextures = "使用內置材質",
	nomCustomTextures = "使用自定義材質",
	nomTextAura = "文字材質", 
	nomRealaura = "清晰光環",
	nomRandomColor = "隨機顏色",
	nomTexMode = "光暈效果",

	nomTalentGroup1 = "主天賦",
	aideTalentGroup1 = "選中此項後,僅當你處於主天賦狀態下才觸發此特效",
	nomTalentGroup2 = "副天賦",
	aideTalentGroup2 = "選中此項後,僅當你處於副天賦狀態下才觸發此特效",

	nomReset = "重置編輯器位置",	
	nomPowaShowAuraBrowser = "顯示特效瀏覽器",
	
	nomDefaultTimerTexture = "默認計時器材質",
	nomTimerTexture = "計時器材質",
	nomDefaultStacksTexture = "默認疊加次數材質",
	nomStacksTexture = "疊加次數材質",
	
	Enabled = "已啟用",
	Default = "默認",

	Ternary = {
		combat = "戰鬥狀態",
		inRaid = "團隊狀態",
		inParty = "小隊狀態",
		isResting = "休息狀態",
		ismounted = "騎乘狀態",
		inVehicle = "載具狀態",
		isAlive= "存活狀態",
	},

	nomWhatever = "忽略",
	aideTernary = "設置這些狀態將影響特效顯示的方式",
	TernaryYes = {
		combat = "在戰鬥狀態時觸發",
		inRaid = "在團隊狀態時觸發",
		inParty = "在小隊狀態時觸發",
		isResting = "在休息狀態時觸發",
		ismounted = "在騎乘狀態時觸發",
		inVehicle = "在載具狀態時觸發",
		isAlive= "在存活狀態時觸發",
	},
	TernaryNo = {
		combat = "非戰鬥狀態時觸發",
		inRaid = "非團隊狀態時觸發",
		inParty = "非小隊狀態時觸發",
		isResting = "非休息狀態時觸發",
		ismounted = "非騎乘狀態時觸發",
		inVehicle = "非載具狀態時觸發",
		isAlive= "在死亡狀態時觸發",
	},
	TernaryAide = {
		combat = "此效果受戰鬥狀態影響",
		inRaid = "此效果受團隊狀態影響",
		inParty = "此效果受小隊狀態影響",
		isResting = "此效果受休息狀態影響",
		ismounted = "此效果受騎乘狀態影響",
		inVehicle = "此效果受載具狀態影響",
		isAlive= "此效果受存活狀態影響",
	},

	nomTimerInvertAura = "超時顛倒材質",
	aidePowaTimerInvertAuraSlider = "特效持續時間超過設定值時將材質顛倒(0 為禁用)",
	nomTimerHideAura = "隱藏特效",
	aidePowaTimerHideAuraSlider = "隱藏特效和計時器,直到持續時間超過設定值(0 為禁用)",

	aideTimerRounding = "選中此項時將對計時器取整",
	nomTimerRounding = "取整",

	aideGTFO = "使用首領技能來匹配AOE法術預警檢測",
	nomGTFO = "首領AOE法術",

	nomIgnoreUseable = "顯示冷卻中的法術",
	aideIgnoreUseable = "忽略可用的法術(僅檢測冷卻中的法術)",

	-- Diagnostic reason text, these have substitutions (using $1, $2 etc) to allow for different sententance constructions
	nomReasonShouldShow = "應該顯示特效,因為$1",
	nomReasonWontShow   = "不會顯示特效,因為$1",
	
	nomReasonMulti = "所有匹配特征 $1", --$1=Multiple match ID list
	
	nomReasonDisabled = "Power Auras 被禁用了",
	nomReasonGlobalCooldown = "忽略了全局冷卻時間(GCD)",
	
	nomReasonBuffPresent = "$1 獲得了 $2 $3", --$1=Target $2=BuffType, $3=BuffName (e.g. "Unit4 has Debuff Misery")
	nomReasonBuffMissing = "$1 沒有獲得 $2 $3", --$1=Target $2=BuffType, $3=BuffName (e.g. "Unit4 doesn't have Debuff Misery")
	nomReasonBuffFoundButIncomplete = "$2 $3 作用在$1上,但是\n$4", --$1=Target $2=BuffType, $3=BuffName, $4=IncompleteReason (e.g. "Debuff Sunder Armor found for Target but\nStacks<=2")
	
	nomReasonOneInGroupHasBuff     = "$1 獲得了 $2 $3",            --$1=GroupId   $2=BuffType, $3=BuffName (e.g. "Raid23 has Buff Blessing of Kings")
	nomReasonNotAllInGroupHaveBuff = "不是所有$1的成員都獲得了$2 $3", --$1=GroupType $2=BuffType, $3=BuffName (e.g. "Not all in Raid have Buff Blessing of Kings")
	nomReasonAllInGroupHaveBuff    = "所有$1的成員都獲得了$2 $3",     --$1=GroupType $2=BuffType, $3=BuffName (e.g. "All in Raid have Buff Blessing of Kings")
	nomReasonNoOneInGroupHasBuff   = "沒有$1的成員獲得了$2 $3",  --$1=GroupType $2=BuffType, $3=BuffName (e.g. "No one in Raid has Buff Blessing of Kings")

	nomReasonBuffPresentTimerInvert = "Buff出現, 計時器倒置",
	nomReasonBuffFound              = "Buff出現",
	nomReasonStacksMismatch         = "疊加次數=$1 但預設值是$2", --$1=Actual Stack count, $2=Expected Stack logic match (e.g. ">=0")

	nomReasonAuraMissing = "特效丟失",
	nomReasonAuraOff     = "特效被禁用",
	nomReasonAuraBad     = "特效損壞",
	
	nomReasonNotForTalentSpec = "在此套天賦下特效不會觸發",
	
	nomReasonPlayerDead     = "玩家死亡",
	nomReasonPlayerAlive    = "玩家存活",
	nomReasonNoTarget       = "沒有目標",
	nomReasonTargetPlayer   = "目標是你",
	nomReasonTargetDead     = "目標死亡",
	nomReasonTargetAlive    = "目標存活",
	nomReasonTargetFriendly = "友好的目標",
	nomReasonTargetNotFriendly = "敵對的目標",
	
	nomReasonNotInCombat = "不在戰鬥狀態",
	nomReasonInCombat = "在戰鬥狀態",
	
	nomReasonInParty = "在小隊中",
	nomReasonInRaid = "在團隊中",
	nomReasonNotInParty = "不在小隊中",
	nomReasonNotInRaid = "不在團隊中",
	nomReasonNoFocus = "沒有焦點目標",	
	nomReasonNoCustomUnit = "找不到你定義的單位:$1,不在隊伍\團隊中,或攜帶寵物",

	nomReasonNotMounted = "不在騎乘",
	nomReasonMounted = "騎乘狀態",		
	nomReasonNotInVehicle = "不在載具中",
	nomReasonInVehicle = "在載具中",		
	nomReasonNotResting = "不在休息狀態",
	nomReasonResting = "休息狀態",		
	nomReasonStateOK = "狀態正常",

	nomReasonInverted        = "$1 (被倒置)", -- $1 is the reason, but the inverted flag is set so the logic is reversed
	
	nomReasonSpellUsable     = "法術 $1 可用",
	nomReasonSpellNotUsable  = "法術 $1 不可用",
	nomReasonSpellNotReady   = "法術 $1 沒有準備好, 在冷卻中, 計時器倒置",
	nomReasonSpellNotEnabled = "法術 $1 沒有啟用",
	nomReasonSpellNotFound   = "法術 $1 沒有找到",
	nomReasonSpellOnCooldown = "Spell $1 on Cooldown",
	
	nomReasonStealablePresent = "$1 有可偷取的法術 $2", --$1=Target $2=SpellName (e.g. "Focus has Stealable spell Blessing of Wisdom")
	nomReasonNoStealablePresent = "沒有在任何目標上找到可偷取法術 $1", --$1=SpellName (e.g. "Nobody has Stealable spell Blessing of Wisdom")
	nomReasonRaidTargetStealablePresent = "團隊目標$1有可偷取的法術 $2", --$1=RaidId $2=SpellName (e.g. "Raid21Target has Stealable spell Blessing of Wisdom")
	nomReasonPartyTargetStealablePresent = "小隊目標$1有可偷取的法術 $2", --$1=PartyId $2=SpellName (e.g. "Party4Target has Stealable spell Blessing of Wisdom")
	
	nomReasonPurgeablePresent = "$1 有可凈化的法術 $2", --$1=Target $2=SpellName (e.g. "Focus has Purgeable spell Blessing of Wisdom")
	nomReasonNoPurgeablePresent = "沒有在任何目標上找到可凈化的法術 $1", --$1=SpellName (e.g. "Nobody has Purgeable spell Blessing of Wisdom")
	nomReasonRaidTargetPurgeablePresent = "團隊目標$1有可凈化的法術 $2", --$1=RaidId $2=SpellName (e.g. "Raid21Target has Purgeable spell Blessing of Wisdom")
	nomReasonPartyTargetPurgeablePresent = "小隊目標$1有可凈化的法術 $2", --$1=PartyId $2=SpellName (e.g. "Party4Target has Purgeable spell Blessing of Wisdom")

	nomReasonAoETrigger = "檢測到AoE法術 $1", -- $1=AoE spell name
	nomReasonAoENoTrigger = "沒有檢測到AoE法術 $1", -- $1=AoE spell match
	
	nomReasonEnchantMainInvert = "找到主手武器強化效果 $1, 計時器倒置", -- $1=Enchant match
	nomReasonEnchantMain = "找到主手武器強化效果 $1", -- $1=Enchant match
	nomReasonEnchantOffInvert = "找到副手武器強化效果 $1, 計時器倒置"; -- $1=Enchant match
	nomReasonEnchantOff = "找到副手武器強化效果 $1", -- $1=Enchant match
	nomReasonNoEnchant = "沒有在任何武器上找到強化效果 $1", -- $1=Enchant match

	nomReasonNoUseCombo = "你沒有使用連擊點數",
	nomReasonComboMatch = "目前連擊點數是$1,與設置值$2相匹配",-- $1=Combo Points, $2=Combo Match
	nomReasonNoComboMatch = "目前連擊點數是$1,與設置值$2不匹配",-- $1=Combo Points, $2=Combo Match

	nomReasonActionNotFound = "沒有在動作條上找到此技能",
	nomReasonActionReady = "技能可用了",
	nomReasonActionNotReadyInvert = "技能不可用(冷卻中), 計時器倒置",
	nomReasonActionNotReady = "技能不可用(冷卻中)",
	nomReasonActionlNotEnabled = "技能沒有啟用",
	nomReasonActionNotUsable = "技能不可用",

	nomReasonYouAreCasting = "你正在施放法術$1", -- $1=Casting match
	nomReasonYouAreNotCasting = "你沒有施放法術 $1", -- $1=Casting match
	nomReasonTargetCasting = "目標正在施放法術 $1", -- $1=Casting match
	nomReasonFocusCasting = "焦點目標正在施放法術 $1", -- $1=Casting match
	nomReasonRaidTargetCasting = "團隊目標$1正在施放法術 $2", --$1=RaidId $2=Casting match
	nomReasonPartyTargetCasting = "小隊目標$1正在施放法術 $2", --$1=PartyId $2=Casting match
	nomReasonNoCasting = "沒有任何人的目標在施放法術 $1", -- $1=Casting match
	
	nomReasonStance = "當前姿態$1, 與設置值$2相匹配", -- $1=Current Stance, $2=Match Stance
	nomReasonNoStance = "當前姿態$1, 與設置值$2不匹配", -- $1=Current Stance, $2=Match Stance

	ReasonStat = {
		Health     = {MatchReason="$1 生命值低",          NoMatchReason="$1 生命值不夠低"},
		Mana       = {MatchReason="$1 法術值低",            NoMatchReason="$1法術值不夠低"},
		RageEnergy = {MatchReason="$1 能量值低",		 NoMatchReason="$1 能量值不夠低"},
		Aggro      = {MatchReason="$1 獲得仇恨",           NoMatchReason="$1 沒有獲得仇恨"},
		PvP        = {MatchReason="$1 PVP狀態",        NoMatchReason="$1 不在PVP狀態"},
	},

});

end
