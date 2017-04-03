if GetLocale() == "koKR" then	
	Outfitter.cTitle = "Outfitter"
	Outfitter.cTitleVersion = Outfitter.cTitle.." "..Outfitter.cVersion

	Outfitter.cSingleItemFormat = "%s"
	Outfitter.cTwoItemFormat = "%s and %s"
	Outfitter.cMultiItemFormat = "%s{{, %s}} and %s"
	
	Outfitter.cNameLabel = "이름:"
	Outfitter.cCreateUsingTitle = "최적화:"
	Outfitter.cUseCurrentOutfit = "현재 장비 세트 사용"
	Outfitter.cUseEmptyOutfit = "빈 장비 세트 생성"

	Outfitter.cOutfitterTabTitle = "Outfitter"
	Outfitter.cOptionsTabTitle = "옵션"
	Outfitter.cAboutTabTitle = "정보"

	Outfitter.cNewOutfit = "신규 장비 세트"
	Outfitter.cRenameOutfit = "장비 세트 이름 변경"

	Outfitter.cCompleteOutfits = "완비 세트"
	Outfitter.cPartialOutfits = "부분 세트"
	Outfitter.cAccessoryOutfits = "액세서리"
	Outfitter.cSpecialOutfits = "특수 조건"
	Outfitter.cOddsNEndsOutfits = "나머지 장비들"

	Outfitter.cGlobalCategory = "특별 세트"
	Outfitter.cNormalOutfit = "평상시"
	Outfitter.cNakedOutfit = "벗기"

	Outfitter.cFishingOutfit = "낚시"
	Outfitter.cHerbalismOutfit = "약초 채집"
	Outfitter.cMiningOutfit = "채광"
	Outfitter.cLockpickingOutfit = "Lockpicking"
	Outfitter.cSkinningOutfit = "무두질"
	Outfitter.cFireResistOutfit = "화염 저항"
	Outfitter.cNatureResistOutfit = "자연 저항"
	Outfitter.cShadowResistOutfit = "암흑 저항"
	Outfitter.cArcaneResistOutfit = "비전 저항"
	Outfitter.cFrostResistOutfit = "냉기 저항"

	Outfitter.cArgentDawnOutfit = "은빛 여명회"
	Outfitter.cRidingOutfit = "말타기"
	Outfitter.cDiningOutfit = "음식 먹기"
	Outfitter.cBattlegroundOutfit = "전장"
	Outfitter.cABOutfit = "전장: 아라시 분지"
	Outfitter.cAVOutfit = "전장: 알터랙 계곡"
	Outfitter.cWSGOutfit = "전장: 전쟁노래 협곡"
	Outfitter.cArenaOutfit = "전장: 투기장"
	Outfitter.cEotSOutfit = "전장: 폭풍의 눈"
	Outfitter.cCityOutfit = "마을 주변"
	Outfitter.cSwimmingOutfit = "수영"
	Outfitter.cArgentTournamentOutfit = "Argent Tournament"
	Outfitter.cMultiphaseSurveyOutfit = "The Multiphase Survey"
	Outfitter.cSpellcastOutfit = "Spellcast"

	Outfitter.cMountSpeedFormat = "이동 속도 (%d+)%%만큼 증가"; -- For detecting when mounted
	Outfitter.cFlyingMountSpeedFormat = "비행 속도 (%d+)%%만큼 증가"; -- For detecting when mounted

	Outfitter.cBagsFullError = "가방이 가득 차서 %s|1을;를; 벗을 수 없습니다."
	Outfitter.cDepositBagsFullError = "가방이 가득 차서 %s|1을;를; 벗을 수 없습니다."
	Outfitter.cWithdrawBagsFullError = "가방이 가득 차서 %s|1을;를; 벗을 수 없습니다."
	Outfitter.cItemNotFoundError = "%s 아이템을 찾을 수 없습니다."
	Outfitter.cItemAlreadyUsedError = "%s|1은;는; 이미 다른 슬롯에서 사용중이므로 %s 슬롯에 착용할 수 없습니다."
	Outfitter.cAddingItem = "%s|1을;를; %s 세트에 추가합니다."
	Outfitter.cNameAlreadyUsedError = "오류: 사용중인 이름입니다."
	Outfitter.cNoItemsWithStatError = "경고: 해당 능력을 가진 아이템이 없습니다."

	Outfitter.cEnableAll = "모두 활성화"
	Outfitter.cEnableNone = "모두 비활성화"

	Outfitter.cConfirmDeleteMsg = "%s 세트를 삭제 하시겠습니까?"
	Outfitter.cConfirmRebuildMsg = "%s 세트를 재구성 하시겠습니까?"
	Outfitter.cRebuild = "재구성"

	Outfitter.cSilverwingHold = "Silverwing Hold"
	Outfitter.cWarsongLumberMill = "Warsong Lumber Mill"

	Outfitter.cTotalStatsName = "모든 능력치"
	Outfitter.cItemLevelName = "Item Level"

	Outfitter.cOptionsTitle = "Outfitter 옵션"
	Outfitter.cShowMinimapButton = "미니맵 버튼 표시"
	Outfitter.cShowMinimapButtonOnDescription = "미니맵 버튼을 사용하지 않으려면 이 설정을 끄십시오."
	Outfitter.cShowMinimapButtonOffDescription = "미니맵 버튼을 사용하려면 이 설정을 켜십시오."
	Outfitter.cAutoSwitch = "장비 자동-교환"
	Outfitter.cAutoSwitchOnDescription = "장비를 자동적으로 변경하지 않으려면 이 설정을 끄십시오."
	Outfitter.cAutoSwitchOffDescription = "장비를 자동으로 변경하려면 이 설정을 켜십시오."
	Outfitter.cTooltipInfo = "툴팁 표시"
	Outfitter.cTooltipInfoOnDescription = "툴팁에 '사용처:' 정보를 표시하지 않으려면 이 설정을 끄십시오. (착용장비에 마우스을 올렸을 때 프레임율을 향상 시킵니다.)"
	Outfitter.cTooltipInfoOffDescription = "툴팁에 '사용처:' 정보를 표시하려면 이 설정을 켜십시오."
	Outfitter.cOutfitDisplay = "Outfit display"
	Outfitter.cShowHotkeyMessages = "단축키로 변경할때 보여주기"
	Outfitter.cShowHotkeyMessagesOnDescription = "단축키로 세트를 변경할때 메시지를 보지 않으려면 이 설정을 끄십시오."
	Outfitter.cShowHotkeyMessagesOffDescription = "단축키로 세트를 변경할때 메시지를 보려면 이 설정을 켜십시오."

	Outfitter.cEquipOutfitMessageFormat = "Outfitter: %s 장비됨"
	Outfitter.cUnequipOutfitMessageFormat = "Outfitter: %s 해제됨"

	Outfitter.cURL = "wobbleworks.com"
	Outfitter.cAboutTitle = "Outfitter 정보"
	Outfitter.cAuthor = "Designed and written by John Stephen and Bruce Quinton with contributions by %s"
	Outfitter.cTestersTitle = "Outfitter testers"
	Outfitter.cSpecialThanksTitle = "Special thanks to"
	Outfitter.cTranslationCredit = "Translations by %s"
	Outfitter.cURL = "wobbleworks.com"

	Outfitter.cOpenOutfitter = "Outfitter 열기"

	Outfitter.cArgentDawnOutfitDescription = "이 세트는 역병지대에 있을 때 자동으로 착용 됩니다."
	Outfitter.cRidingOutfitDescription = "이 세트는 탈것을 탈 때 자동으로 착용 됩니다."
	Outfitter.cDiningOutfitDescription = "이 세트는 음식을 먹거나 음료를 마실 때 자동으로 착용 됩니다."
	Outfitter.cBattlegroundOutfitDescription = "이 세트는 전장에 있을 때 자동으로 착용 됩니다."
	Outfitter.cArathiBasinOutfitDescription = "이 세트는 아라시 분지에 있을 때 자동으로 착용 됩니다."
	Outfitter.cAlteracValleyOutfitDescription = "이 세트는 알터랙 계곡에 있을 때 자동으로 착용 됩니다."
	Outfitter.cWarsongGulchOutfitDescription = "이 세트는 전쟁노래 협곡에 있을 때 자동으로 착용 됩니다."
	Outfitter.cEotSOutfitDescription = "이 세트는 폭풍의 눈에 있을 때 자동으로 착용 됩니다."
	Outfitter.cCityOutfitDescription = "이 세트는 우호적인 대도시에 있을 때 자동으로 착용 됩니다."
	Outfitter.cSwimmingOutfitDescription = "이 세트는 수영할 때 자동적으로 장착됩니다."

	Outfitter.cKeyBinding = "단축키"

	BINDING_HEADER_OUTFITTER_TITLE = Outfitter.cTitle
	BINDING_NAME_OUTFITTER_OUTFIT = "Outfitter 열기"

	BINDING_NAME_OUTFITTER_OUTFIT1  = "세트 1"
	BINDING_NAME_OUTFITTER_OUTFIT2  = "세트 2"
	BINDING_NAME_OUTFITTER_OUTFIT3  = "세트 3"
	BINDING_NAME_OUTFITTER_OUTFIT4  = "세트 4"
	BINDING_NAME_OUTFITTER_OUTFIT5  = "세트 5"
	BINDING_NAME_OUTFITTER_OUTFIT6  = "세트 6"
	BINDING_NAME_OUTFITTER_OUTFIT7  = "세트 7"
	BINDING_NAME_OUTFITTER_OUTFIT8  = "세트 8"
	BINDING_NAME_OUTFITTER_OUTFIT9  = "세트 9"
	BINDING_NAME_OUTFITTER_OUTFIT10 = "세트 10"
	
	Outfitter.cShow = "보이기"
	Outfitter.cHide = "숨기기"
	Outfitter.cDontChange = "Don't change"
	
	Outfitter.cHelm = "투구"
	Outfitter.cCloak = "망토"
	Outfitter.cPlayerTitle = "Title"

	Outfitter.cMore = "More"
	
	Outfitter.cAutomation = "Automation"
	
	Outfitter.cDisableOutfit = "세트 사용 안함"
	Outfitter.cDisableOutfitInBG = "전장에서 사용 안함"
	Outfitter.cDisableOutfitInCombat = "전투중 사용 안함"
	Outfitter.cDisableOutfitInAQ40 = "안퀴라즈 사원 내 사용 안함"
	Outfitter.cDisableOutfitInNaxx = "낙스라마스 내 사용 안함"
	Outfitter.cDisabledOutfitName = "%s (사용 안함)"
	
	Outfitter.cOutfitBar = "Outfit Bar"
	Outfitter.cShowInOutfitBar = "Show in outfit bar"
	Outfitter.cChangeIcon = "Choose icon..."
	
	Outfitter.cMinimapButtonTitle = "미니맵 버튼"
	Outfitter.cMinimapButtonDescription = "클릭 : 세트 선택, 드래그 : 미니맵 버튼 이동"

	Outfitter.cClassName.DRUID = "드루이드"
	Outfitter.cClassName.HUNTER = "사냥꾼"
	Outfitter.cClassName.MAGE = "마법사"
	Outfitter.cClassName.PALADIN = "성기사"
	Outfitter.cClassName.PRIEST = "사제"
	Outfitter.cClassName.ROGUE = "도적"
	Outfitter.cClassName.SHAMAN = "주술사"
	Outfitter.cClassName.WARLOCK = "흑마법사"
	Outfitter.cClassName.WARRIOR = "전사"
	
	Outfitter.cBattleStance = "전투 태세"
	Outfitter.cDefensiveStance = "방어 태세"
	Outfitter.cBerserkerStance = "광폭 태세"

	Outfitter.cWarriorBattleStance = "전사: 전투 태세"
	Outfitter.cWarriorDefensiveStance = "전사: 방어 태세"
	Outfitter.cWarriorBerserkerStance = "전사: 광폭 태세"

	Outfitter.cDruidBearForm = "드루이드: 곰 변신"
	Outfitter.cDruidCatForm = "드루이드: 표범 변신"
	Outfitter.cDruidAquaticForm = "드루이드: 바다표범 변신"
	Outfitter.cDruidTravelForm = "드루이드: 치타 변신"
	Outfitter.cDruidMoonkinForm = "드루이드: 달빛야수 변신"
	Outfitter.cDruidFlightForm = "드루이드: 폭풍까마귀 변신"
	Outfitter.cDruidSwiftFlightForm = "드루이드: 빠른 폭풍까마귀 변신"
	Outfitter.cDruidTreeOfLifeForm = "드루이드: 생명의 나무"
	Outfitter.cDruidProwl = "드루이드: 숨기"
	Outfitter.cProwl = "숨기"
	
	Outfitter.cPriestShadowform = "사제: 어둠의 형상"

	Outfitter.cRogueStealth = "도적: 은신"

	Outfitter.cShamanGhostWolf = "주술사: 늑대 정령"

	Outfitter.cHunterMonkey = "사냥꾼: 원숭이의 상"
	Outfitter.cHunterHawk =  "사냥꾼: 매의 상"
	Outfitter.cHunterCheetah =  "사냥꾼: 치타의 상"
	Outfitter.cHunterPack =  "사냥꾼: 치타 무리의 상"
	Outfitter.cHunterBeast =  "사냥꾼: 야수의 상"
	Outfitter.cHunterWild =  "사냥꾼: 야생의 상"
	Outfitter.cHunterViper = "사냥꾼: 독사의 상"

	Outfitter.cMageEvocate = "마법사: 환기"

	Outfitter.cCompleteCategoryDescription = "모든 슬롯의 아이템에 관한 설정이 들어있는 완전한 장비 세트입니다."
	Outfitter.cPartialCategoryDescription = "Mix-n-match의 장비 세트는 전부가 아닌 일부 슬롯만 가집니다. 장비 세트가 선택되면 이전에 선택되었던 보조 장비 세트 또는 Mix-n-match 세트를 대체하면서, 완비 세트에서 해당 아이템만을 교체합니다."
	Outfitter.cAccessoryCategoryDescription = "보조 장비의 장비 세트는 전부가 아닌 일부 슬롯만 가집니다. Mix-n-match와는 다르게 이전에 선택되었던 보조 장비 세트 또는 Mix-n-match 세트를 대체하지 않고 추가로 완비 세트에서 해당 아이템을 교체합니다."
	Outfitter.cSpecialCategoryDescription = "특수 조건의 장비 세트는 해당하는 조건을 충족시킬 경우 자동으로 착용됩니다."
	Outfitter.cOddsNEndsCategoryDescription = "나머지 장비들의 아이템들은 장비 세트에 한번도 사용되지 않은 아이템들입니다."

	Outfitter.cRebuildOutfitFormat = "%s 재구성"

	Outfitter.cSlotEnableTitle = "슬롯 활성화"
	Outfitter.cSlotEnableDescription = "슬롯을 활성화 하면 해당 장비 세트를 사용할때 같이 변경됩니다."

	Outfitter.cFinger0SlotName = "첫번째 손가락"
	Outfitter.cFinger1SlotName = "두번째 손가락"

	Outfitter.cTrinket0SlotName = "첫번째 장신구"
	Outfitter.cTrinket1SlotName = "두번째 장신구"

	Outfitter.cOutfitCategoryTitle = "카테고리"
	Outfitter.cBankCategoryTitle = "은행"
	Outfitter.cDepositToBank = "모든 아이템을 은행으로"
	Outfitter.cDepositUniqueToBank = "특정 아이템을 은행으로"
	Outfitter.cDepositOthersToBank = "Deposit other outfits to bank"
	Outfitter.cWithdrawFromBank = "은행으로부터 아이템 회수"
	Outfitter.cWithdrawOthersFromBank = "Withdraw other outfits from bank"
	
	Outfitter.cMissingItemsLabel = "찾을 수 없는 아이템: "
	Outfitter.cBankedItemsLabel = "은행에 있는 아이템: "

	Outfitter.cResistCategory = "저항"
	Outfitter.cTradeCategory = "전문기술"

	Outfitter.cTankPoints = "탱크 포인트"
	Outfitter.cCustom = "사용자 설정"

	Outfitter.cScript = "스크립트"
	Outfitter.cDisableScript = "스크립트 비활성화"
	Outfitter.cEditScriptTitle = "%s 세트에 대한 스크립트"
	Outfitter.cEditScriptEllide = "스크립트 편집..."
	Outfitter.cEventsLabel = "이벤트:"
	Outfitter.cScriptLabel = "스크립트:"
	Outfitter.cSetCurrentItems = "현재 아이템으로 갱신"
	Outfitter.cConfirmSetCurrentMsg = "%s|1을;를; 현재 착용 장비를 사용하여 갱신하시겠습니까? 주의: 세트에 현재 활성화된 슬롯만 갱신됩니다. -- 적용후 추가적으로 슬롯을 변경할 수 있습니다."
	Outfitter.cSetCurrent = "갱신"
	Outfitter.cTyping = "입력..."
	Outfitter.cScriptErrorFormat = "%d 라인 오류: %s"
	Outfitter.cExtractErrorFormat = "%[문자열 \"장비 스크립트\"%]:(%d+):(.*)"
	Outfitter.cPresetScript = "미리 정의된 스크립트:"
	Outfitter.cCustomScript = "사용자 정의"
	Outfitter.cSettings = "설정"
	Outfitter.cSource = "원본"
	Outfitter.cInsertFormat = "<- %s"

	Outfitter.cNone = "없음"
	Outfitter.cUseTooltipLineFormat = "^사용 효과:.*"
	Outfitter.cUseDurationTooltipLineFormat = "^사용 효과: (%d+) seconds"

	Outfitter.cAutoChangesDisabled = "Automated changes are now disabled"
	Outfitter.cAutoChangesEnabled = "Automated changes are now enabled"
	
	-- OutfitterFu strings
	
	Outfitter.cFuHint = "Outfitter 창을 열려면 좌-클릭하세요."
	Outfitter.cFuHideMissing = "불일치 숨기기"
	Outfitter.cFuHideMissingDesc = "일치 하지 않는 아이템을 숨깁니다."
	Outfitter.cFuRemovePrefixes = "접두사 제거"
	Outfitter.cFuRemovePrefixesDesc = "FuBar에 짧은 글자를 표시하기 위해 세트 이름의 접두사를 제거합니다."
	Outfitter.cFuMaxTextLength = "최대 글자 길이"
	Outfitter.cFuMaxTextLengthDesc = "FuBar에 표시할 글자의 최대 길이입니다."
	Outfitter.cFuHideMinimapButton = "Hide minimap button"
	Outfitter.cFuHideMinimapButtonDesc = "Hide Outfitter's minimap button."
	Outfitter.cFuInitializing = "초기화"

	Outfitter.cStoreOnServer = "Store outfit on server"
	Outfitter.cStoreOnServerOnDescription = "Turn off to remove this outfit from the server and store it locally instead.  It will no longer be available from other computers."
	Outfitter.cStoreOnServerOffDescription = "Turn on to store this outfit on the server so that it's available from any computer.  You may only store 10 outfits on the server."
	Outfitter.cTooManyServerOutfits = "You cannot store more than %d outfits on the server."
	
	Outfitter.cNoItemsWithStat = "Couldn't generate an outfit because no items with that stat were found"
end
