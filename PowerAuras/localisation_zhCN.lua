if (GetLocale() == "zhCN") then

PowaAuras.Anim[0] = "[无]";
PowaAuras.Anim[1] = "静止";
PowaAuras.Anim[2] = "闪光效果";
PowaAuras.Anim[3] = "生长效果";
PowaAuras.Anim[4] = "脉搏效果";
PowaAuras.Anim[5] = "气泡效果";
PowaAuras.Anim[6] = "水滴效果";
PowaAuras.Anim[7] = "漏电效果";
PowaAuras.Anim[8] = "收缩效果";
PowaAuras.Anim[9] = "火焰效果";
PowaAuras.Anim[10] = "盘旋效果";

PowaAuras.BeginAnimDisplay[0] = "[无]";
PowaAuras.BeginAnimDisplay[1] = "由小放大";
PowaAuras.BeginAnimDisplay[2] = "由大渐小";
PowaAuras.BeginAnimDisplay[3] = "逐渐清晰";
PowaAuras.BeginAnimDisplay[4] = "左边进入";
PowaAuras.BeginAnimDisplay[5] = "左上进入";
PowaAuras.BeginAnimDisplay[6] = "上部进入";
PowaAuras.BeginAnimDisplay[7] = "右上进入";
PowaAuras.BeginAnimDisplay[8] = "右边进入";
PowaAuras.BeginAnimDisplay[9] = "右下进入";
PowaAuras.BeginAnimDisplay[10] = "下部进入";
PowaAuras.BeginAnimDisplay[11] = "左下进入";
PowaAuras.BeginAnimDisplay[12] = "弹跳进入";

PowaAuras.EndAnimDisplay[0] = "[无]";
PowaAuras.EndAnimDisplay[1] = "放大消失";
PowaAuras.EndAnimDisplay[2] = "缩小消失";
PowaAuras.EndAnimDisplay[3] = "淡化消失";
PowaAuras.EndAnimDisplay[4] = "旋转渐隐";
PowaAuras.EndAnimDisplay[5] = "旋转缩小"; 

PowaAuras.Sound[0] = "[无]";

PowaAuras:MergeTables(PowaAuras.Text, 
{
	welcome = "输入 /powa 打开特效编辑器.",

	aucune = "无",
	aucun = "无",
	largeur = "宽度",
	hauteur = "高度",
	mainHand = "主手",
	offHand = "副手",
	bothHands = "双手",

	DebuffType =
	{
		Magic   = "魔法",
		Disease = "疾病",
		Curse   = "诅咒",
		Poison  = "中毒",
	},

	DebuffCatType =
	{
		[PowaAuras.DebuffCatType.CC] = "CC", --- need confirm this translation. by doomiris
		[PowaAuras.DebuffCatType.Silence] = "沉默",
		[PowaAuras.DebuffCatType.Snare] = "诱捕",
		[PowaAuras.DebuffCatType.Stun] = "昏迷",
		[PowaAuras.DebuffCatType.Root] = "无法行动",
		[PowaAuras.DebuffCatType.Disarm] = "缴械",
		[PowaAuras.DebuffCatType.PvE] = "PvE",
	},
	
	AuraType =
	{
		[PowaAuras.BuffTypes.Buff] = "Buff",
		[PowaAuras.BuffTypes.Debuff] = "Debuff",
		[PowaAuras.BuffTypes.AoE] = "AOE法术",
		[PowaAuras.BuffTypes.TypeDebuff] = "Debuff类型",
		[PowaAuras.BuffTypes.Enchant] = "武器强化",
		[PowaAuras.BuffTypes.Combo] = "连击点数",
		[PowaAuras.BuffTypes.ActionReady] = "技能冷却",
		[PowaAuras.BuffTypes.Health] = "生命值",
		[PowaAuras.BuffTypes.Mana] = "魔法值",
		[PowaAuras.BuffTypes.EnergyRagePower] = "怒气/能量/符文能量", 
		[PowaAuras.BuffTypes.Aggro] = "获得仇恨",
		[PowaAuras.BuffTypes.PvP] = "PvP标志",
		[PowaAuras.BuffTypes.Stance] = "姿态",
		[PowaAuras.BuffTypes.SpellAlert] = "法术预警",  
		[PowaAuras.BuffTypes.OwnSpell] = "自身技能",  
		[PowaAuras.BuffTypes.StealableSpell] = "可偷取法术",
		[PowaAuras.BuffTypes.PurgeableSpell] = "可净化法术",
	},
	
	-- main
	nomEnable = "启用",
	aideEnable = "启用/禁用所有PowerAuras特效",

	nomDebug = "调试模式",
	aideDebug = "打开调试模式后,将在聊天窗口显示特效的触发条件等信息",
	ListePlayer = "分类",
	ListeGlobal = "全局",
	aideMove = "移动特效",
	aideCopy = "复制特效",
	nomRename = "重命名",
	aideRename = "重命名我的特效分类名",
	nomTest = "测试",
	nomHide = "全部隐藏",
	nomEdit = "编辑",
	nomNew = "新建",
	nomDel = "删除",
	nomImport = "导入", 
	nomExport = "导出", 
	nomImportSet = "批量导入", 
	nomExportSet = "批量导出", 
	aideImport = "把特效字串粘贴(Ctrl+v)在此编辑框内,然后点击\'接受\'按钮",
	aideExport = "复制(Ctrl+c)此编辑框内的特效字串,与其它人分享你的特效", 
	aideImportSet = "把批量特效字串粘贴(Ctrl+v)在此编辑框内,然后点击\'接受\'按钮,注意:批量导入时将会删除本页所有现有特效",
	aideExportSet = "复制(Ctrl+c)此编辑框内的特效字串,将此页内所有特效与其它人分享",
	aideDel = "删除所选特效(必须按住Ctrl键才能使用此功能)",
	nomMove = "移动",
	nomCopy = "复制",
	nomPlayerEffects = "我的特效",
	nomGlobalEffects = "通用特效",
	aideEffectTooltip = "按住Shift键点击图标以启用/禁用该特效",

	-- editor
	nomSound = "播放声音",
	aideSound = "特效触发时播放声音",
	nomCustomSound = "自定义声音文件:",
	aideCustomSound = "输入声音文件名称,如cookie.mp3 注意:你需要在游戏启动前把声音文件放入Sounds文件夹下,目前仅支持mp3和wav格式.",

	nomTexture = "当前材质",
	aideTexture = "显示特效使用的材质.你可以修改相应文件夹内的.tga 文件来增加特效",

	nomAnim1 = "动画效果",
	nomAnim2 = "辅助效果",
	aideAnim1 = "是否为所选材质使用动画效果",
	aideAnim2 = "此动画效果以较低不透明度显示,为了不过多占用屏幕同一时间只显示一个辅助效果",

	nomDeform = "拉伸",
	aideDeform = "在高度或宽度方向拉伸材质",

	aideColor = "点击此处修改材质颜色",
	aideFont = "点击此处来选择字体,点击OK按钮使你的选择生效", 
	aideMultiID = "此处输入其它特效的ID,以执行联合检查.多个ID号须用'/'分隔. 特效ID可以在某个特效的鼠标提示中第一行找到,如:[2],2就是此特效ID", 
	aideTooltipCheck = "此处输入用于激活特效的某个状态的鼠标提示文字",

	aideBuff = "此处输入用于激活特效的buff的名字,或名字中的几个连续文字.如果使用分隔符,也可以输入多个buff的名字.例如输入: 能量灌注/奥术能量",
	aideBuff2 = "此处输入用于激活特效的debuff的名字,或名字中的几个连续文字.如果使用分隔符,也可以输入多个debuff的名字.例如输入: 堕落治疗/燃烧刺激",
	aideBuff3 = "此处输入用于激活特效的debuff的类型名称,或名称中的几个连续文字.如果使用分隔符,也可以输入多个debuff类型的名称.例如输入: 魔法/诅咒/中毒/疾病",
	aideBuff4 = "此处输入用于激活特效的AOE法术的名字,AOE法术名字可以在战斗记录中找到.例如输入:邪恶光环/火焰之雨/暴风雪",
	aideBuff5 = "此处输入用于激活特效的武器临时附魔效果.另外你可以通过前置'main/'或者'off/'来指明主副手位置(例如: main/致残毒药,表示检测主手上的这种毒药)", 
	aideBuff6 = "此处输入用于激活特效的连击点数.例如输入: 1或者1/2/3或者0/4/5等等自由组合",
	aideBuff7 = "此处输入用于激活特效的动作条上的动作名,或名字中的几个连续文字,当此动作完全冷却时此效果触发.例如输入:赞达拉英雄护符/法力之潮图腾/心灵专注",
	aideBuff8 = "此处输入用于激活特效的法术名称,或名称中的一部分,或者是你技能书中的技能,也可以输入一个技能ID",
	
	aideSpells = "此处输入用于激活法术预警特效的法术名称", 
	aideStacks = "输入用于激活特效的操作符及叠加数量，只能输入一个操作符，例如：'<5' '>3' '=11' '!5' '>=0' '<=6' '2-8'", 

	aideStealableSpells = "此处输入可偷取的法术名称(用 * 将检测所有可被偷取的法术).",
	aidePurgeableSpells = "此处输入可净化的法术名称(用 * 将检测所有可被净化的法术).",

	aideUnitn = "此处输入用于激活特效的特定成员名称,必须处于同一团队",
	aideUnitn2 = "仅用于团队/队伍模式",    

	aideMaxTex = "定义特效编辑器使用的材质数量,如果你增加了自定义材质请修改此值.",
	aideAddEffect = "新增加一个特效",
	aideWowTextures = "使用游戏内置材质",
	aideTextAura = "使用文字做为特效材质(图形材质将被禁用)", 
	aideRealaura = "清晰光环",
	aideCustomTextures = "使用自定义材质,例如: Flamme.tga(自定义材质需保存在custom文件夹下)",
	aideRandomColor = "每次激活时使用随机颜色",

	aideTexMode = "材质透明度反向显示",
	
	nomActivationBy = "激活条件",

	nomOwnTex = "使用技能图标", 
	aideOwnTex = "使用buff/debuff或技能的默认图标做为材质", 
	nomStacks = "叠加", --no longer used?

	nomUpdateSpeed = "更新速度",
	nomSpeed = "运动速度",
	nomFPS = "全局动画帧数",
	nomTimerUpdate = "计时器更新速度",
	nomBegin = "进场效果",
	nomEnd = "结束效果",
	nomSymetrie = "对称性",
	nomAlpha = "不透明度",
	nomPos = "位置",
	nomTaille = "大小",

	nomExact = "精确匹配名称",
	nomThreshold = "触发极限",
	aideThreshInv = "选中此项可反转触发逻辑. 生命值/法力值: 默认=低于指定值时触发特效 / 选中此项后=高于指定值时触发特效. 能量/怒气/符文能量: 默认=高于指定值时触发特效 / 选中此项后=低于指定值时触发特效",
	nomThreshInv = "</>", 
	nomStance = "姿态",

	nomMine = "自己施放的", 
	aideMine = "选中此项则仅检测由玩家自己施放的buff/debuff", 
	nomDispellable = "自己可以驱散的",
	aideDispellable = "选中此项则仅检测可被驱散的buff",
	nomCanInterrupt = "可打断",
	aideCanInterrupt = "选中此项则仅检测可被打断的技能",

	nomPlayerSpell = "施法状态",
	aidePlayerSpell = "检测玩家是否正在咏唱一个法术",

	nomCheckTarget = "敌方目标",
	nomCheckFriend = "友方目标",
	nomCheckParty = "团队目标",
	nomCheckFocus = "焦点目标",
	nomCheckRaid = "团队成员",
	nomCheckGroupOrSelf = "团队/小队或自己",
	nomCheckGroupAny = "任何人", 
	nomCheckOptunitn = "特定成员",

	aideTarget = "此buff/debuff仅存在于敌方目标上",
	aideTargetFriend = "此buff/debuff仅存在于友方目标上",
	aideParty = "此buff/debuff仅存在于小队中",
	aideGroupOrSelf = "选中此项后将仅对团队或小队成员(包括自己)进行检测",
	aideFocus = "此buff/debuff仅存在焦点目标上",
	aideRaid = "此buff/debuff仅存在于团队中",
	aideGroupAny = "选中此项后,当任何一个小队/团队成员有此buff/debuff就触发特效. 不选中此项(默认状态),则检查到所有人都有此buff/debuff才触发特效", 
	aideOptunitn = "此buff/debuff仅存在于团队/小队中的特定成员身上",
	aideExact = "选中此项将精确匹配buff/debuff名称",
	aideStance = "选择用于触发特效的姿态",

	aideShowSpinAtBeginning= "起始动画结束后使其做360度旋转",
	nomCheckShowSpinAtBeginning = "动画结束后旋转",

	nomCheckShowTimer = "显示",
	nomTimerDuration = "延迟消失",
	aideTimerDuration = "目标上的buff/debuff计时器延迟到此时间结束后再消失(0为禁用)",
	aideShowTimer = "为此效果显示计时器",
	aideSelectTimer = "选择使用何种计时器来显示持续时间",
	aideSelectTimerBuff = "选择使用何种计时器来显示持续时间(仅用于玩家buff)",
	aideSelectTimerDebuff = "选择使用何种计时器来显示持续时间(仅用于玩家debuff)",

	nomCheckShowStacks = "叠加次数",

	nomCheckInverse = "不存在",
	aideInverse = "选中此项后,仅当buff/debuff不存在时显示此特效",	

	nomCheckIgnoreMaj = "忽略大小写",	
	aideIgnoreMaj = "选中此项将忽略buff/debuff名字的大小写字母(供英文玩家使用,中国玩家不需要修改此项)",

	nomDuration = "延迟消失",
	aideDuration = "特效延迟到此时间结束后再消失(0为禁用)",

	nomCentiemes = "显示百分位",
	nomDual = "显示两个计时器",
	nomHideLeadingZeros = "隐藏前置零位,如:08秒显示为8秒",
	nomTransparent = "使用透明材质",
	nomUpdatePing = "刷新提示",
	nomClose = "关闭",
	nomEffectEditor = "特效编辑器",
	nomAdvOptions = "选项",
	nomMaxTex = "最大可用材质",
	nomTabAnim = "动画",
	nomTabActiv = "条件",
	nomTabSound = "声音",
	nomTabTimer = "计时器",
	nomTabStacks = "叠加", 
	nomWowTextures = "使用内置材质",
	nomCustomTextures = "使用自定义材质",
	nomTextAura = "文字材质", 
	nomRealaura = "清晰光环",
	nomRandomColor = "随机颜色",
	nomTexMode = "光晕效果",

	nomTalentGroup1 = "主天赋",
	aideTalentGroup1 = "选中此项后,仅当你处于主天赋状态下才触发此特效",
	nomTalentGroup2 = "副天赋",
	aideTalentGroup2 = "选中此项后,仅当你处于副天赋状态下才触发此特效",

	nomReset = "重置编辑器位置",	
	nomPowaShowAuraBrowser = "显示特效浏览器",
	
	nomDefaultTimerTexture = "默认计时器材质",
	nomTimerTexture = "计时器材质",
	nomDefaultStacksTexture = "默认叠加次数材质",
	nomStacksTexture = "叠加次数材质",
	
	Enabled = "已启用",
	Default = "默认",

	Ternary = {
		combat = "战斗状态",
		inRaid = "团队状态",
		inParty = "小队状态",
		isResting = "休息状态",
		ismounted = "骑乘状态",
		inVehicle = "载具状态",
		isAlive= "存活状态",
	},

	nomWhatever = "忽略",
	aideTernary = "设置这些状态将影响特效显示的方式",
	TernaryYes = {
		combat = "在战斗状态时触发",
		inRaid = "在团队状态时触发",
		inParty = "在小队状态时触发",
		isResting = "在休息状态时触发",
		ismounted = "在骑乘状态时触发",
		inVehicle = "在载具状态时触发",
		isAlive= "在存活状态时触发",
	},
	TernaryNo = {
		combat = "非战斗状态时触发",
		inRaid = "非团队状态时触发",
		inParty = "非小队状态时触发",
		isResting = "非休息状态时触发",
		ismounted = "非骑乘状态时触发",
		inVehicle = "非载具状态时触发",
		isAlive= "在死亡状态时触发",
	},
	TernaryAide = {
		combat = "此效果受战斗状态影响",
		inRaid = "此效果受团队状态影响",
		inParty = "此效果受小队状态影响",
		isResting = "此效果受休息状态影响",
		ismounted = "此效果受骑乘状态影响",
		inVehicle = "此效果受载具状态影响",
		isAlive= "此效果受存活状态影响",
	},

	nomTimerInvertAura = "超时颠倒材质",
	aidePowaTimerInvertAuraSlider = "特效持续时间超过设定值时将材质颠倒(0 为禁用)",
	nomTimerHideAura = "隐藏特效",
	aidePowaTimerHideAuraSlider = "隐藏特效和计时器,直到持续时间超过设定值(0 为禁用)",

	aideTimerRounding = "选中此项时将对计时器取整",
	nomTimerRounding = "取整",

	aideGTFO = "使用首领技能来匹配AOE法术预警检测",
	nomGTFO = "首领AOE法术",

	nomIgnoreUseable = "显示冷却中的法术",
	aideIgnoreUseable = "忽略可用的法术(仅检测冷却中的法术)",

	-- Diagnostic reason text, these have substitutions (using $1, $2 etc) to allow for different sententance constructions
	nomReasonShouldShow = "应该显示特效,因为$1",
	nomReasonWontShow   = "不会显示特效,因为$1",
	
	nomReasonMulti = "所有匹配特征 $1", --$1=Multiple match ID list
	
	nomReasonDisabled = "Power Auras 被禁用了",
	nomReasonGlobalCooldown = "忽略了全局冷却时间(GCD)",
	
	nomReasonBuffPresent = "$1 获得了 $2 $3", --$1=Target $2=BuffType, $3=BuffName (e.g. "Unit4 has Debuff Misery")
	nomReasonBuffMissing = "$1 没有获得 $2 $3", --$1=Target $2=BuffType, $3=BuffName (e.g. "Unit4 doesn't have Debuff Misery")
	nomReasonBuffFoundButIncomplete = "$2 $3 作用在$1上,但是\n$4", --$1=Target $2=BuffType, $3=BuffName, $4=IncompleteReason (e.g. "Debuff Sunder Armor found for Target but\nStacks<=2")
	
	nomReasonOneInGroupHasBuff     = "$1 获得了 $2 $3",            --$1=GroupId   $2=BuffType, $3=BuffName (e.g. "Raid23 has Buff Blessing of Kings")
	nomReasonNotAllInGroupHaveBuff = "不是所有$1的成员都获得了$2 $3", --$1=GroupType $2=BuffType, $3=BuffName (e.g. "Not all in Raid have Buff Blessing of Kings")
	nomReasonAllInGroupHaveBuff    = "所有$1的成员都获得了$2 $3",     --$1=GroupType $2=BuffType, $3=BuffName (e.g. "All in Raid have Buff Blessing of Kings")
	nomReasonNoOneInGroupHasBuff   = "没有$1的成员获得了$2 $3",  --$1=GroupType $2=BuffType, $3=BuffName (e.g. "No one in Raid has Buff Blessing of Kings")

	nomReasonBuffPresentTimerInvert = "Buff出现, 计时器倒置",
	nomReasonBuffFound              = "Buff出现",
	nomReasonStacksMismatch         = "叠加次数=$1 但预设值是$2", --$1=Actual Stack count, $2=Expected Stack logic match (e.g. ">=0")

	nomReasonAuraMissing = "特效丢失",
	nomReasonAuraOff     = "特效被禁用",
	nomReasonAuraBad     = "特效损坏",
	
	nomReasonNotForTalentSpec = "在此套天赋下特效不会触发",
	
	nomReasonPlayerDead     = "玩家死亡",
	nomReasonPlayerAlive    = "玩家存活",
	nomReasonNoTarget       = "没有目标",
	nomReasonTargetPlayer   = "目标是你",
	nomReasonTargetDead     = "目标死亡",
	nomReasonTargetAlive    = "目标存活",
	nomReasonTargetFriendly = "友好的目标",
	nomReasonTargetNotFriendly = "敌对的目标",
	
	nomReasonNotInCombat = "不在战斗状态",
	nomReasonInCombat = "在战斗状态",
	
	nomReasonInParty = "在小队中",
	nomReasonInRaid = "在团队中",
	nomReasonNotInParty = "不在小队中",
	nomReasonNotInRaid = "不在团队中",
	nomReasonNoFocus = "没有焦点目标",	
	nomReasonNoCustomUnit = "找不到你定义的单位:$1,不在队伍\团队中,或携带宠物",

	nomReasonNotMounted = "不在骑乘",
	nomReasonMounted = "骑乘状态",		
	nomReasonNotInVehicle = "不在载具中",
	nomReasonInVehicle = "在载具中",		
	nomReasonNotResting = "不在休息状态",
	nomReasonResting = "休息状态",		
	nomReasonStateOK = "状态正常",

	nomReasonInverted        = "$1 (被倒置)", -- $1 is the reason, but the inverted flag is set so the logic is reversed
	
	nomReasonSpellUsable     = "法术 $1 可用",
	nomReasonSpellNotUsable  = "法术 $1 不可用",
	nomReasonSpellNotReady   = "法术 $1 没有准备好, 在冷却中, 计时器倒置",
	nomReasonSpellNotEnabled = "法术 $1 没有启用",
	nomReasonSpellNotFound   = "法术 $1 没有找到",
	nomReasonSpellOnCooldown = "Spell $1 on Cooldown",
	
	nomReasonStealablePresent = "$1 有可偷取的法术 $2", --$1=Target $2=SpellName (e.g. "Focus has Stealable spell Blessing of Wisdom")
	nomReasonNoStealablePresent = "没有在任何目标上找到可偷取法术 $1", --$1=SpellName (e.g. "Nobody has Stealable spell Blessing of Wisdom")
	nomReasonRaidTargetStealablePresent = "团队目标$1有可偷取的法术 $2", --$1=RaidId $2=SpellName (e.g. "Raid21Target has Stealable spell Blessing of Wisdom")
	nomReasonPartyTargetStealablePresent = "小队目标$1有可偷取的法术 $2", --$1=PartyId $2=SpellName (e.g. "Party4Target has Stealable spell Blessing of Wisdom")
	
	nomReasonPurgeablePresent = "$1 有可净化的法术 $2", --$1=Target $2=SpellName (e.g. "Focus has Purgeable spell Blessing of Wisdom")
	nomReasonNoPurgeablePresent = "没有在任何目标上找到可净化的法术 $1", --$1=SpellName (e.g. "Nobody has Purgeable spell Blessing of Wisdom")
	nomReasonRaidTargetPurgeablePresent = "团队目标$1有可净化的法术 $2", --$1=RaidId $2=SpellName (e.g. "Raid21Target has Purgeable spell Blessing of Wisdom")
	nomReasonPartyTargetPurgeablePresent = "小队目标$1有可净化的法术 $2", --$1=PartyId $2=SpellName (e.g. "Party4Target has Purgeable spell Blessing of Wisdom")

	nomReasonAoETrigger = "检测到AoE法术 $1", -- $1=AoE spell name
	nomReasonAoENoTrigger = "没有检测到AoE法术 $1", -- $1=AoE spell match
	
	nomReasonEnchantMainInvert = "找到主手武器强化效果 $1, 计时器倒置", -- $1=Enchant match
	nomReasonEnchantMain = "找到主手武器强化效果 $1", -- $1=Enchant match
	nomReasonEnchantOffInvert = "找到副手武器强化效果 $1, 计时器倒置"; -- $1=Enchant match
	nomReasonEnchantOff = "找到副手武器强化效果 $1", -- $1=Enchant match
	nomReasonNoEnchant = "没有在任何武器上找到强化效果 $1", -- $1=Enchant match

	nomReasonNoUseCombo = "你没有使用连击点数",
	nomReasonComboMatch = "目前连击点数是$1,与设置值$2相匹配",-- $1=Combo Points, $2=Combo Match
	nomReasonNoComboMatch = "目前连击点数是$1,与设置值$2不匹配",-- $1=Combo Points, $2=Combo Match

	nomReasonActionNotFound = "没有在动作条上找到此技能",
	nomReasonActionReady = "技能可用了",
	nomReasonActionNotReadyInvert = "技能不可用(冷却中), 计时器倒置",
	nomReasonActionNotReady = "技能不可用(冷却中)",
	nomReasonActionlNotEnabled = "技能没有启用",
	nomReasonActionNotUsable = "技能不可用",

	nomReasonYouAreCasting = "你正在施放法术$1", -- $1=Casting match
	nomReasonYouAreNotCasting = "你没有施放法术 $1", -- $1=Casting match
	nomReasonTargetCasting = "目标正在施放法术 $1", -- $1=Casting match
	nomReasonFocusCasting = "焦点目标正在施放法术 $1", -- $1=Casting match
	nomReasonRaidTargetCasting = "团队目标$1正在施放法术 $2", --$1=RaidId $2=Casting match
	nomReasonPartyTargetCasting = "小队目标$1正在施放法术 $2", --$1=PartyId $2=Casting match
	nomReasonNoCasting = "没有任何人的目标在施放法术 $1", -- $1=Casting match
	
	nomReasonStance = "当前姿态$1, 与设置值$2相匹配", -- $1=Current Stance, $2=Match Stance
	nomReasonNoStance = "当前姿态$1, 与设置值$2不匹配", -- $1=Current Stance, $2=Match Stance

	ReasonStat = {
		Health     = {MatchReason="$1 生命值低",          NoMatchReason="$1 生命值不够低"},
		Mana       = {MatchReason="$1 法术值低",            NoMatchReason="$1法术值不够低"},
		RageEnergy = {MatchReason="$1 能量值低",		 NoMatchReason="$1 能量值不够低"},
		Aggro      = {MatchReason="$1 获得仇恨",           NoMatchReason="$1 没有获得仇恨"},
		PvP        = {MatchReason="$1 PVP状态",        NoMatchReason="$1 不在PVP状态"},
	},

});

end
