if (GetLocale() == "koKR") then

PowaAuras.Anim[0] = "[보이지 않음]";
PowaAuras.Anim[1] = "공전";
PowaAuras.Anim[2] = "점멸";
PowaAuras.Anim[3] = "성장";
PowaAuras.Anim[4] = "파동";
PowaAuras.Anim[5] = "거품";
PowaAuras.Anim[6] = "낙수";
PowaAuras.Anim[7] = "전기장";
PowaAuras.Anim[8] = "꽁무니";
PowaAuras.Anim[9] = "화염";
PowaAuras.Anim[10] = "궤도";
PowaAuras.Anim[11] = "Spin Clockwise";
PowaAuras.Anim[12] = "Spin Anti-Clockwise";

PowaAuras.BeginAnimDisplay[0] = "[없음]";
PowaAuras.BeginAnimDisplay[1] = "확대";
PowaAuras.BeginAnimDisplay[2] = "축소";
PowaAuras.BeginAnimDisplay[3] = "불투명도만";
PowaAuras.BeginAnimDisplay[4] = "좌측";
PowaAuras.BeginAnimDisplay[5] = "상단-좌측";
PowaAuras.BeginAnimDisplay[6] = "상단";
PowaAuras.BeginAnimDisplay[7] = "상단-우측";
PowaAuras.BeginAnimDisplay[8] = "우측";
PowaAuras.BeginAnimDisplay[9] = "하단-우측";
PowaAuras.BeginAnimDisplay[10] = "하단";
PowaAuras.BeginAnimDisplay[11] = "하단-좌측";
PowaAuras.BeginAnimDisplay[12] = "Bounce";

PowaAuras.EndAnimDisplay[0] = "[없음]";
PowaAuras.EndAnimDisplay[1] = "확대";
PowaAuras.EndAnimDisplay[2] = "축소";
PowaAuras.EndAnimDisplay[3] = "불투명도만";
PowaAuras.EndAnimDisplay[4] = "Spin"; --- untranslated
PowaAuras.EndAnimDisplay[5] = "Spin In"; --- untranslated

PowaAuras.Sound[0] = NONE;
PowaAuras.Sound[30] = NONE;

PowaAuras:MergeTables(PowaAuras.Text, 
{
	welcome = "옵션을 볼려면 /powa를 입력하십시오.",

	aucune = "없음",
	aucun = "없음",
	largeur = "너비",
	hauteur = "높이",
	mainHand = "주무기",
	offHand = "보조 무기",
	bothHands = "둘다",

	DebuffType =
	{
		Magic = "마법",
		Disease = "질병",
		Curse = "저주",
		Poison = "독",
	},

	DebuffCatType =
	{
		[PowaAuras.DebuffCatType.CC] = "군중제어",
		[PowaAuras.DebuffCatType.Silence] = "침묵",
		[PowaAuras.DebuffCatType.Snare] = "덫",
		[PowaAuras.DebuffCatType.Stun] = "기절",
		[PowaAuras.DebuffCatType.Root] = "올가미",
		[PowaAuras.DebuffCatType.Disarm] = "무장해제",
		[PowaAuras.DebuffCatType.PvE] = "PvE",
	},
	
	AuraType =
	{
		[PowaAuras.BuffTypes.Buff] = "버프",
		[PowaAuras.BuffTypes.Debuff] = "디버프",
		[PowaAuras.BuffTypes.AoE] = "AOE 디버프",
		[PowaAuras.BuffTypes.TypeDebuff] = "디버프의 유형",
		[PowaAuras.BuffTypes.Enchant] = "무기 강화",
		[PowaAuras.BuffTypes.Combo] = "연계 점수",
		[PowaAuras.BuffTypes.ActionReady] = "사용 가능한 행동",
		[PowaAuras.BuffTypes.Health] = "생명력",
		[PowaAuras.BuffTypes.Mana] = "마나",
		[PowaAuras.BuffTypes.EnergyRagePower] = "분노/기력/룬",
		[PowaAuras.BuffTypes.Aggro] = "어그로",
		[PowaAuras.BuffTypes.PvP] = "PvP",
		[PowaAuras.BuffTypes.Stance] = "태세",
		[PowaAuras.BuffTypes.SpellAlert] = "주문 경고", 
		[PowaAuras.BuffTypes.OwnSpell] = "나의 주문", 
		[PowaAuras.BuffTypes.StealableSpell] = "훔치기 가능한 주문", 
		[PowaAuras.BuffTypes.PurgeableSpell] = "제거가능한 주문",
		[PowaAuras.BuffTypes.Static] = "Static Aura",
		[PowaAuras.BuffTypes.Totems] = "Totems",
		[PowaAuras.BuffTypes.Pet] = "Pet",
		[PowaAuras.BuffTypes.Runes] = "Runes",
		[PowaAuras.BuffTypes.Slots] = "Equipment Slots",
		[PowaAuras.BuffTypes.Items] = "Named Items",
		[PowaAuras.BuffTypes.Tracking] = "Tracking",
		[PowaAuras.BuffTypes.GTFO] = "GTFO Alert",
	},

	Relative = 
	{
		NONE        = "Free", 
		TOPLEFT     = "Top-Left", 
		TOP         = "Top", 
		TOPRIGHT    = "Top-Right", 
		RIGHT       = "Right", 
		BOTTOMRIGHT = "BottomRight", 
		BOTTOM      = "Bottom", 
		BOTTOMLEFT  = "Bottom-Left", 
		LEFT        = "Left", 
		CENTER      = "Center",
	},
	
	Slots =
	{
		Ammo = "Ammo",
		Back = "Back",
		Chest = "Chest",
		Feet = "Feet",
		Finger0 = "Finger1",
		Finger1 = "Finger2",
		Hands = "Hands",
		Head = "Head",
		Legs = "Legs",
		MainHand = "MainHand",
		Neck = "Neck",
		Ranged = "Ranged",
		SecondaryHand = "OffHand",
		Shirt = "Shirt",
		Shoulder = "Shoulder",
		Tabard = "Tabard",
		Trinket0 = "Trinket1",
		Trinket1 = "Trinket2",
		Waist = "Waist",
		Wrist = "Wrist",	
	},
	-- main
	nomEnable = "Power Auras 활성화",
	aideEnable = "모든 Power Auras 효과를 활성화합니다.",

	nomDebug = "디버그 메시지 활성화",
	aideDebug = "디버그 메시지를 활성화합니다.",
	ListePlayer = "페이지",
	ListeGlobal = "공통",
	aideMove = "여기로 효과를 이동시킵니다.",
	aideCopy = "여기로 효과를 복사합니다.",
	nomRename = "이름 변경",
	aideRename = "선택된 효과의 페이지의 이름을 변경합니다.",
	nomTest = "테스트",
	nomHide = "모두 숨기기",
	nomEdit = "편집",
	nomNew = "새로",
	nomDel = "삭제",
	nomImport = "들여오기",
	nomExport = "내보내기",
	nomImportSet = "설정 가져오기", 
	nomExportSet = "설정 내보내기", 
	aideImport = "오라 구문열을 붙여넣기 하려면 Ctrl-V를 누르고 \'승낙\'을 누르십시오.",
	aideExport = "공유하기 위해 오라 구문열을 복사하려면 Ctrl-C를 누르십시오.",
	aideImportSet = "오라 설정 구문열을 붙여넣기 하려면 Ctrl-V를 누르고 \'승낙\'을 누르십시오.",
	aideExportSet = "공유하기 위해 모든 오라 구문열을 복사하려면 Ctrl-C를 누르십시오.",
	aideDel = "선택된 효과를 제거합니다(이 버튼을 작동되게 하려면 CTRL을 누르십시오).",
	nomMove = "이동",
	nomCopy = "복사",
	nomPlayerEffects = "캐릭터별 효과",
	nomGlobalEffects = "공통 효과",
	aideEffectTooltip = "(효과 켜기/끄기를 전환하려면 Shift-클릭하십시오)",

	-- editor
	nomSound = "재생할 소리",
	aideSound = "애니메이션 시작시 소리를 재생합니다.",
	nomCustomSound = "혹은 소리 파일:",
	aideCustomSound = "게임을 시작하기 전에, Sounds 폴더내의 소리 파일의 이름을 아래의 빈칸에 입력하십시오. mp3 및 wav 확장자를 지원합니다. (예: 'cookie.mp3' ;)",

	nomTexture = "텍스쳐",
	aideTexture = "보여지게 될 텍스쳐를 선택합니다. 애드온 폴더내의 Aura#.tga 파일의 변경을 통해 텍스쳐를 쉽게 바꿀 수 있습니다.",

	nomAnim1 = "주 애니메이션",
	nomAnim2 = "보조 애니메이션",
	aideAnim1 = "다양한 효과와 더불어 텍스쳐에 움직임을 부여할 지 여부를 선택합니다.",
	aideAnim2 = "이 애니메이션은 주 애니메이션보다는 덜 불투명하게 보여지게 됩니다. 화면의 과부하를 줄이기 위해 한개의 보조 애니메이션만이 동시에 보여지게 된다는 점에 주의 하십시오.",

	nomDeform = "형태 변경",
	aideDeform = "텍스쳐를 높이 혹은 너비로 늘립니다.",

	aideColor = "텍스쳐의 색상을 변경하려면 여기를 클릭하십시오.",
	aideFont = "글꼴을 선택하려면 여기를 클릭하십시오. 선택한 것을 적용하려면 '확인'을 누르십시오.",
	aideMultiID = "체크한 것과 연결시키기 위해 다른 오라 ID를 여기에 입력합니다. 다중 ID는 '/'로 구별지워져야만 합니다. 오라 ID는 오라 툴팁의 첫번째 줄에서 [#]로 찾을 수 있습니다.",
	aideTooltipCheck = "Also check the tooltip starts with this text",

	aideBuff = "여기에 이 효과를 활성/비활성화해야만 하는 버프의 이름을, 혹은 이름의 일부분을 입력합니다. 구분되어 있어야 할 이름이라면 각각의 이름을 ('/'로 분리해) 입력할 수 있습니다(예: Super Buff/Power).",
	aideBuff2 = "여기에 이 효과를 활성/비활성화해야만 하는 디버프의 이름을, 혹은 이름의 일부분을 입력합니다. 구분되어 있어야 할 이름이라면 각각의 이름을 ('/'로 분리해) 입력할 수 있습니다(예: Dark Disease/Plague).",
	aideBuff3 = "여기에 이 효과를 활성/비활성화해야만 하는 디버프의 유형(독, 질병, 저주, 마법, 군중제어, 침묵, 기절, 덫, 올가미 혹은 없음)을 입력합니다. 디버프 각각의 유형을 ('/'로 분리해) 입력할 수도 있습니다(예: 질병/독).",
	aideBuff4 = "여기에 이 효과에 적용해야만 하는 효과의 범위 이름(AOE)을 입력합니다(예를 들면 불의 비와 같은 경우입니다. 이 효과의 범위(AOE)의 이름을 전투 기록에서 찾을 수 있습니다).",
	aideBuff5 = "여기에 이 효과를 활성화해야만 하는 일시적인 무기 강화를 입력합니다 : 선택적으로 주무기 혹은 보조무기 장착 칸을 지정하기 위해 '주무기', '보조 무기' 혹은 양 무기에 대해 '둘다'(예: 주무기/crippling).",
	aideBuff6 = "여기에 이 효과를 활성화해야만 하는 연계 점수의 숫자를 입력합니다(예 : 1 혹은 1/2/3 혹은 0/4/5 등등...).",
	aideBuff7 = "여기에 단축 행동바에 있는 행동의 이름을, 혹은 이름의 일부분을 입력합니다. 이 행동이 사용 가능한 경우에 효과는 활성화될 것입니다.",
	aideBuff8 = "여기에 마법책에 있는 주문의 이름을, 혹은 이름의 일부분을 입력합니다. 주문의 ID를 입력하여도 됩니다(예: 12345).",

	aideSpells = "여기에 주문 경고 오라를 적용할 주문의 이름을 입력합니다.",
	aideStacks = "여기에 이 효과를 활성/비활성화하는데 요구되는 연산자와 중첩 횟수를 입력합니다. 연산자를 사용한 경우에만 작동합니다! 예: '<5' '>3' '=11' '!5' '>=0' '<=6' '2<>8'",

	aideStealableSpells = "마법훔치기를 할 주문명을 여기에 입력하시요. (use * for any stealable spell).", 
	aidePurgeableSpells = "정화할 주문명을 여기에 입력하시요. (use * for any purgeable spell).", 

	aideUnitn = "여기에 이 효과를 활성/비활성화해야만 하는 유닛의 이름을 입력합니다. 공격대 혹은 그룹에 속해 있는 유닛의 이름만 입력할 수 있습니다.",
	aideUnitn2 = "공격대/그룹에 한해",

	aideMaxTex = "효과 편집기에 가능한 텍스쳐의 최대 갯수를 정의 합니다. 애드온 폴더에 텍스쳐를 추가하려면(AURA1.tga에서 AURA50.tga까지 이름과 함께), 여기에 올바른 갯수를 지시해야만 합니다.",
	aideAddEffect = "편집을 위한 효과를 추가합니다.",
	aideWowTextures = "이 효과에 대해 Power Auras 폴더내의 텍스쳐 대신에 WoW의 텍스쳐를 사용하려면 이 옵션에 체크하십시오.",
	aideTextAura = "텍스쳐 대신에 문자를 입력하려면 이 옵션에 체크하십시오.",
	aideRealaura = "활성 오오라",
	aideCustomTextures = "하위 폴더 'Custom'에 있는 텍스쳐를 사용하려면 이 옵션에 체크하십시오. 아래에 텍스쳐의 이름을 기입해야만 합니다(예: myTexture.tga)",
	aideRandomColor = "이 효과를 알리기 위해 활성화되는 매 시간마다 무작위 색상을 사용하려면 이 옵션에 체크하십시오.",

	aideTexMode = "불투명한 텍스쳐를 사용하려면 이 옵션을 체크 해제하십시오. 기본적으로 가장 어두운 색상이 더욱 반투명합니다.",

	nomActivationBy = "활성화:",

	nomOwnTex = "자신의 텍스쳐 사용",
	aideOwnTex = "기본 텍스쳐 대신에 자신의 디/버프 혹은 능력 텍스쳐를 사용합니다.",
	nomStacks = "중첩",

	nomUpdateSpeed = "Update speed",
	nomSpeed = "애니메이션 속도",
	nomFPS = "Global Animation FPS",
	nomTimerUpdate = "Timer update speed",
	nomBegin = "시작 애니메이션",
	nomEnd = "종료 애니메이션",
	nomSymetrie = "좌우 대칭",
	nomAlpha = "불투명도",
	nomPos = "위치",
	nomTaille = "크기",

	nomExact = "정확한 이름",
	nomThreshold = "한계치",
	aideThreshInv = "한계치 값을 뒤집으려면 이 옵션에 체크하십시오. 생명력/마나: 기본 = 낮음 경고/체크시 = 높음 경고. 기력/분노/마력: 기본 = 높음 경고/체크시 = 낮음 경고",
	nomThreshInv = "</>",
	nomStance = "태세",

	nomMine = "나에 의해 시전된",
	aideMine = "플레이어에 의해 시전된 버프/디버프에 한해 테스트하려면 이곳에 체크하십시오.",
	nomDispellable = "내가 해제할 수 있는",
	aideDispellable = "Check to show only buffs that are dispellable", --- untranslated
	nomCanInterrupt = "Can be Interrupted",
	aideCanInterrupt = "Check to show only for spells that can be Interrupted", --- untranslated

	nomPlayerSpell = "Player Casting", --- untranslated
	aidePlayerSpell = "Check if Player is casting a spell", --- untranslated

	nomCheckTarget = "적대적 대상",
	nomCheckFriend = "우호적 대상",
	nomCheckParty = "파티원",
	nomCheckFocus = "주시 대상",
	nomCheckRaid = "공격대원",
	nomCheckGroupOrSelf = "공격대/파티원 혹은 자신",
	nomCheckGroupAny = "특정",
	nomCheckOptunitn = "유닛 이름",

	aideTarget = "적대적 대상에 한해 테스트하려면 이곳에 체크하십시오.",
	aideTargetFriend = "우호적 대상에 한해 테스트하려면 이곳에 체크하십시오.",
	aideParty = "파티원에 한해 테스트하려면 이곳에 체크하십시오.",
	aideGroupOrSelf = "파티 혹은 공격대원 혹은 자신에 한해 테스트하려면 이곳에 체크하십시오.",
	aideFocus = "주시 대상에 한해 테스트하려면 이곳에 체크하십시오.",
	aideRaid = "공격대원에 한해 테스트하려면 이곳에 체크하십시오.",
	aideGroupAny = "'특정' 파티/공격대원에 대해 버프를 테스트하려면 이곳에 체크하십시오. 비체크시: '모든' 파티/공격대원에 대해 버프가 테스트됩니다.",
	aideOptunitn = "공격대/그룹에 속해 있는 특정 캐릭터에 한해 테스트하려면 이곳에 체크하십시오.",
	aideExact = "버프/디버프/행동의 정확한 이름을 테스트하려면 이곳에 체크하십시오.",
	aideStance = "이벤트에 적용할 태세, 오라 혹은 변신을 선택하십시오.",

	aideShowSpinAtBeginning= "At the end of the begin animation show a 360 degree spin",
	nomCheckShowSpinAtBeginning = "Show Spin after begin animation ends",

	nomCheckShowTimer = "보이기",
	nomTimerDuration = "지속시간",
	aideTimerDuration = "대상에 대해 버프/디버프 지속시간을 시연하기 위해서 타이머를 보여줍니다(비활성화하려면 0)",
	aideShowTimer = "이 효과의 타이머를 보여주려면 이곳에 체크하십시오.",
	aideSelectTimer = "지속시간을 보여줄 타이머를 선택합니다.",
	aideSelectTimerBuff = "지속시간을 보여줄 타이머를 선택합니다(이중 하나는 플레이어의 버프를 위해 남겨둔 상태입니다).",
	aideSelectTimerDebuff = "지속시간을 보여줄 타이머를 선택합니다(이중 하나는 플레이어의 디버프를 위해 남겨둔 상태입니다).",

	nomCheckShowStacks = "보이기",

	nomCheckInverse = "비활성화시 보이기",
	aideInverse = "버프/디버프가 비활성화되어 있는 경우에만 이 효과를 보여주려면 여기에 체크하십시오.",

	nomCheckIgnoreMaj = "대문자 무시",
	aideIgnoreMaj = "버프/디버프 이름의 대/소문자를 무시하려면 여기에 체크하십시오.",

	nomDuration = "애니메이션 지속시간",
	aideDuration = "이 시간 이후로 이 효과는 나타나지 않습니다(비활성화 하려면 0)",

	nomCentiemes = "초 백단위 보이기",
	nomDual = "타이머 두개 보이기",
	nomHideLeadingZeros = "0일때 숨기기",
	nomTransparent = "반투명한 텍스쳐 사용",
	nomUpdatePing = "Animate on refresh",
	nomClose = "닫기",
	nomEffectEditor = "효과 편집기",
	nomAdvOptions = "확장 옵션",
	nomMaxTex = "가능한 텍스쳐의 최대 갯수",
	nomTabAnim = "애니메이션",
	nomTabActiv = "활성화",
	nomTabSound = "소리",
	nomTabTimer = "타이머",
	nomTabStacks = "중첩",
	nomWowTextures = "WoW 텍스쳐",
	nomCustomTextures = "사용자 텍스쳐",
	nomTextAura = "문자 오라",
	nomRealaura = "활성 오라",
	nomRandomColor = "무작위 색상",
	nomTexMode = "빛남",

	nomTalentGroup1 = "특성 전문화 1",
	aideTalentGroup1 = "첫번째 특성을 전문화한 경우에만 이 효과를 보여줍니다.",
	nomTalentGroup2 = "특성 전문화 2",
	aideTalentGroup2 = "두번째 특성을 전문화한 경우에만 이 효과를 보여줍니다.",

	nomReset = "편집창 위치 초기화",	
	nomPowaShowAuraBrowser = "Aura Browser 보이기",
	
	nomDefaultTimerTexture = "타이머 텍스쳐 기본값",
	nomTimerTexture = "타이머 텍스쳐",
	nomDefaultStacksTexture = "충첩 텍스쳐 기본값",
	nomStacksTexture = "중첩 텍스쳐",
	
	Enabled = "활성화",
	Default = "기본값",

	Ternary = {
		combat = "전투 중",
		inRaid = "공격대 중",
		inParty = "파티 중",
		isResting = "휴식 중",
		ismounted = "탈것 중",
		inVehicle = "운송수단 중",
		isAlive= "살아 있을 때",
	},

	nomWhatever = "무시",
	aideTernary = "오라표시 조건을 설정",
	TernaryYes = {
		combat = "오직 전투중일 때",
		inRaid = "오직 공격대에 속해 있을 때",
		inParty = "오직 5인 파티에 속해 있을 때",
		isResting = "오직 휴식상태일 때",
		ismounted = "오직 탈것 상태일 때",
		inVehicle = "오직 운송수단 타고 있을 때",
		isAlive= "오직 살아 있을 때만",
	},
	TernaryNo = {
		combat = "전투중이 아닐 때",
		inRaid = "공격대가 아닐 때",
		inParty = "파티가 아닐 때",
		isResting = "휴식 상태가 아닐 때",
		ismounted = "탈것을 탄 상태가 아닐 때",
		inVehicle = "운송수단을 타고 있지 않을 때",
		isAlive= "죽었을 때",
	},
	TernaryAide = {
		combat = "전투 상황에 의한 효능 상태.",
		inRaid = "공격대 상황에 의한 효능 상태.",
		inParty = "파티 상황에 의한 효능 상태.",
		isResting = "휴식상황에 의한 효능 상태.",
		ismounted = "탈것 상황에 의한 효능 상태.",
		inVehicle = "운송수단 상황에 의한 효능 상태.",
		isAlive= "살아 있는 상황에 의한 효능 상태.",
	},

	nomTimerInvertAura = "시간 이하일 때 오라 반전",
	aidePowaTimerInvertAuraSlider = "제한시간보다 지속시간이 적을 때 오라 반전(0일 때 비활성화)",
	nomTimerHideAura = "오라 숨김 & 상기 시간까지",
	aidePowaTimerHideAuraSlider = "제한 시간보다 지속시간이 더 중요할 때 오라와 시간 숨김 (0일 때 비활성화)",

	aideTimerRounding = "When checked will round the timer up",
	nomTimerRounding = "Round Timer Up",

	aideGTFO = "Use GTFO (Boss) spell matches for AoE detection",
	nomGTFO = "Use GTFO for AoE",

	nomIgnoreUseable = "Display Only Depends on Cooldown",
	aideIgnoreUseable = "Ignores if spell is usable (just uses cooldown)",

	-- Diagnostic reason text, these have substitutions (using $1, $2 etc) to allow for different sententance constructions
	nomReasonShouldShow = "Should show because $1",
	nomReasonWontShow   = "Won't show because $1",
	
	nomReasonMulti = "All multiples match $1", --$1=Multiple match ID list
	
	nomReasonDisabled = "Power Auras Disabled",
	nomReasonGlobalCooldown = "Ignore Global Cooldown",
	
	nomReasonBuffPresent = "$1 has $2 $3", --$1=Target $2=BuffType, $3=BuffName (e.g. "Unit4 has Debuff Misery")
	nomReasonBuffMissing = "$1 doesn't have $2 $3", --$1=Target $2=BuffType, $3=BuffName (e.g. "Unit4 doesn't have Debuff Misery")
	nomReasonBuffFoundButIncomplete = "$2 $3 found for $1 but\n$4", --$1=Target $2=BuffType, $3=BuffName, $4=IncompleteReason (e.g. "Debuff Sunder Armor found for Target but\nStacks<=2")
	
	nomReasonOneInGroupHasBuff     = "$1 has $2 $3",            --$1=GroupId   $2=BuffType, $3=BuffName (e.g. "Raid23 has Buff Blessing of Kings")
	nomReasonNotAllInGroupHaveBuff = "Not all in $1 have $2 $3", --$1=GroupType $2=BuffType, $3=BuffName (e.g. "Not all in Raid have Buff Blessing of Kings")
	nomReasonAllInGroupHaveBuff    = "All in $1 have $2 $3",     --$1=GroupType $2=BuffType, $3=BuffName (e.g. "All in Raid have Buff Blessing of Kings")
	nomReasonNoOneInGroupHasBuff   = "No one in $1 has $2 $3",  --$1=GroupType $2=BuffType, $3=BuffName (e.g. "No one in Raid has Buff Blessing of Kings")

	nomReasonBuffPresentTimerInvert = "Buff present, timer invert",
	nomReasonBuffFound              = "Buff present",
	nomReasonStacksMismatch         = "Stacks = $1 expecting $2", --$1=Actual Stack count, $2=Expected Stack logic match (e.g. ">=0")

	nomReasonAuraMissing = "Aura missing",
	nomReasonAuraOff     = "Aura off",
	nomReasonAuraBad     = "Aura bad",
	
	nomReasonNotForTalentSpec = "Aura not active for this talent spec",
	
	nomReasonPlayerDead     = "Player is DEAD",
	nomReasonPlayerAlive    = "Player is Alive",
	nomReasonNoTarget       = "No Target",
	nomReasonTargetPlayer   = "Target is you",
	nomReasonTargetDead     = "Target is Dead",
	nomReasonTargetAlive    = "Target is Alive",
	nomReasonTargetFriendly = "Target is Friendly",
	nomReasonTargetNotFriendly = "Target not Friendly",
	
	nomReasonNotInCombat = "Not in combat",
	nomReasonInCombat = "In combat",
	
	nomReasonInParty = "In Party",
	nomReasonInRaid = "In Raid",
	nomReasonNotInParty = "Not in Party",
	nomReasonNotInRaid = "Not in Raid",
	nomReasonNoFocus = "No focus",	
	nomReasonNoCustomUnit = "Can't find custom unit not in party, raid or with pet unit=$1",

	nomReasonNotMounted = "Not Mounted",
	nomReasonMounted = "Mounted",		
	nomReasonNotInVehicle = "Not In Vehicle",
	nomReasonInVehicle = "In Vehicle",		
	nomReasonNotResting = "Not Resting",
	nomReasonResting = "Resting",		
	nomReasonStateOK = "State OK",

	nomReasonInverted        = "$1 (inverted)", -- $1 is the reason, but the inverted flag is set so the logic is reversed
	
	nomReasonSpellUsable     = "Spell $1 usable",
	nomReasonSpellNotUsable  = "Spell $1 not usable",
	nomReasonSpellNotReady   = "Spell $1 Not Ready, on cooldown, timer invert",
	nomReasonSpellNotEnabled = "Spell $1 not enabled ",
	nomReasonSpellNotFound   = "Spell $1 not found",
	nomReasonSpellOnCooldown = "Spell $1 on Cooldown",
	
	nomReasonStealablePresent = "$1 has Stealable spell $2", --$1=Target $2=SpellName (e.g. "Focus has Stealable spell Blessing of Wisdom")
	nomReasonNoStealablePresent = "Nobody has Stealable spell $1", --$1=SpellName (e.g. "Nobody has Stealable spell Blessing of Wisdom")
	nomReasonRaidTargetStealablePresent = "Raid$1Target has has Stealable spell $2", --$1=RaidId $2=SpellName (e.g. "Raid21Target has Stealable spell Blessing of Wisdom")
	nomReasonPartyTargetStealablePresent = "Party$1Target has has Stealable spell $2", --$1=PartyId $2=SpellName (e.g. "Party4Target has Stealable spell Blessing of Wisdom")
	
	nomReasonPurgeablePresent = "$1 has Purgeable spell $2", --$1=Target $2=SpellName (e.g. "Focus has Purgeable spell Blessing of Wisdom")
	nomReasonNoPurgeablePresent = "Nobody has Purgeable spell $1", --$1=SpellName (e.g. "Nobody has Purgeable spell Blessing of Wisdom")
	nomReasonRaidTargetPurgeablePresent = "Raid$1Target has has Purgeable spell $2", --$1=RaidId $2=SpellName (e.g. "Raid21Target has Purgeable spell Blessing of Wisdom")
	nomReasonPartyTargetPurgeablePresent = "Party$1Target has has Purgeable spell $2", --$1=PartyId $2=SpellName (e.g. "Party4Target has Purgeable spell Blessing of Wisdom")

	nomReasonAoETrigger = "AoE $1 triggered", -- $1=AoE spell name
	nomReasonAoENoTrigger = "AoE no trigger for $1", -- $1=AoE spell match
	
	nomReasonEnchantMainInvert = "Main Hand $1 enchant found, timer invert", -- $1=Enchant match
	nomReasonEnchantMain = "Main Hand $1 enchant found", -- $1=Enchant match
	nomReasonEnchantOffInvert = "Off Hand $1 enchant found, timer invert"; -- $1=Enchant match
	nomReasonEnchantOff = "Off Hand $1 enchant found", -- $1=Enchant match
	nomReasonNoEnchant = "No enchant found on weapons for $1", -- $1=Enchant match

	nomReasonNoUseCombo = "You do not use combo points",
	nomReasonComboMatch = "Combo points $1 match $2",-- $1=Combo Points, $2=Combo Match
	nomReasonNoComboMatch = "Combo points $1 no match with $2",-- $1=Combo Points, $2=Combo Match

	nomReasonActionNotFound = "not found on Action Bar",
	nomReasonActionReady = "Action Ready",
	nomReasonActionNotReadyInvert = "Action Not Ready (on cooldown), timer invert",
	nomReasonActionNotReady = "Action Not Ready (on cooldown)",
	nomReasonActionlNotEnabled = "Action not enabled",
	nomReasonActionNotUsable = "Action not usable",

	nomReasonYouAreCasting = "You are casting $1", -- $1=Casting match
	nomReasonYouAreNotCasting = "You are not casting $1", -- $1=Casting match
	nomReasonTargetCasting = "Target casting $1", -- $1=Casting match
	nomReasonFocusCasting = "Focus casting $1", -- $1=Casting match
	nomReasonRaidTargetCasting = "Raid$1Target casting $2", --$1=RaidId $2=Casting match
	nomReasonPartyTargetCasting = "Party$1Target casting $2", --$1=PartyId $2=Casting match
	nomReasonNoCasting = "Nobody's target casting $1", -- $1=Casting match
	
	nomReasonStance = "Current Stance $1, matches $2", -- $1=Current Stance, $2=Match Stance
	nomReasonNoStance = "Current Stance $1, does not match $2", -- $1=Current Stance, $2=Match Stance

	ReasonStat = {
		Health     = {MatchReason="$1 Health low",          NoMatchReason="$1 Health not low enough"},
		Mana       = {MatchReason="$1 Mana low",            NoMatchReason="$1 Mana not low enough"},
		RageEnergy = {MatchReason="$1 EnergyRagePower low", NoMatchReason="$1 EnergyRagePower not low enough"},
		Aggro      = {MatchReason="$1 has aggro",           NoMatchReason="$1 does not have aggro"},
		PvP        = {MatchReason="$1 PvP flag set",        NoMatchReason="$1 PvP flag not set"},
	},

});

end
