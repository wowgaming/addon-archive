-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

if (GetLocale() == "koKR") then
	XPERL_MINIMAP_HELP1	= "|c00FFFFFF좌클릭|r 하시면 설정창이 나옵니다. (그리고 |c0000FF00프레임 고정|r이 풀립니다.)"
	XPERL_MINIMAP_HELP2	= "|c00FFFFFF우클릭|r 으로 버튼을 드래그해서 이동가능합니다."
	XPERL_MINIMAP_HELP3	= "\r실제 공대원: |c00FFFF80%d|r\r실제 파티원: |c00FFFF80%d|r"
	XPERL_MINIMAP_HELP4	= "\r당신은 실제 파티/공격대장 입니다."
	XPERL_MINIMAP_HELP5	= "|c00FFFFFFALT|r : X-Perl 메모리 사용량"
	XPERL_MINIMAP_HELP6	= "|c00FFFFFF+SHIFT|r : 접속 후 X-Perl 메모리 사용량"

	XPERL_MINIMENU_OPTIONS	= "설정"
	XPERL_MINIMENU_ASSIST	= "어시스트 창 표시"
	XPERL_MINIMENU_CASTMON	= "시전 현황 표시"
	XPERL_MINIMENU_RAIDAD	= "공격대 관리 표시"
	XPERL_MINIMENU_ITEMCHK	= "아이템 체커 표시"
	XPERL_MINIMENU_RAIDBUFF = "공격대 버프"
	XPERL_MINIMENU_ROSTERTEXT="명부 글자"
	XPERL_MINIMENU_RAIDSORT = "공격대 정렬"
	XPERL_MINIMENU_RAIDSORT_GROUP = "파티별 정렬"
	XPERL_MINIMENU_RAIDSORT_CLASS = "직업별 정렬"

	XPERL_TYPE_NOT_SPECIFIED = "무엇인가"
	XPERL_TYPE_BOSS		= "보스"
	XPERL_TYPE_RAREPLUS	= "희귀 정예"
	XPERL_TYPE_ELITE	= "정예"
	XPERL_TYPE_RARE		= "희귀"

	XPERL_LOC_ZONE_SERPENTSHRINE_CAVERN = "불뱀 제단"
	XPERL_LOC_ZONE_BLACK_TEMPLE = "검은 사원"
	XPERL_LOC_ZONE_HYJAL_SUMMIT = "하이잘 정상"
	XPERL_LOC_ZONE_KARAZHAN = "카라잔"
	XPERL_LOC_ZONE_SUNWELL_PLATEAU = "태양샘 고원"
	XPERL_LOC_ZONE_ULDUAR = "울두아르"
	XPERL_LOC_ZONE_TRIAL_OF_THE_CRUSADER = "십자군의 시험장"
	XPERL_LOC_ZONE_ICECROWN_CITADEL = "얼음왕관 성채"
	XPERL_LOC_ZONE_RUBY_SANCTUM = "루비 성소"

	XPERL_LOC_GHOST		= "유령"
	XPERL_LOC_FEIGNDEATH	= "죽은척하기"
	XPERL_LOC_RESURRECTED	= "부활"
	XPERL_LOC_SS_AVAILABLE	= "영혼석 있음"
	XPERL_LOC_UPDATING	= "업데이트"
	XPERL_LOC_ACCEPTEDRES	= "수락됨"
	XPERL_RAID_GROUP	= "%d 파티"
	XPERL_RAID_GROUPSHORT	= "%d파"

	XPERL_LOC_NONEWATCHED	= "발견된 사항 없음"

	XPERL_LOC_STATUSTIP	= "상태 강조: "		-- Tooltip explanation of status highlight on unit
	XPERL_LOC_STATUSTIPLIST = {
		HOT = "주기적인 치유",
		AGGRO = "어그로",
		MISSING = "당신의 직업 버프 누락",
		HEAL = "치유 중",
		SHIELD = "보호막"
	}

	XPERL_OK		= "확인"
	XPERL_CANCEL		= "취소"

	XPERL_LOC_LARGENUMDIV	= 1000
	XPERL_LOC_LARGENUMTAG	= "K"
	XPERL_LOC_HUGENUMDIV	= 1000000
	XPERL_LOC_HUGENUMTAG	= "M"

	BINDING_HEADER_XPERL = "X-Perl 단축키 설정"
	BINDING_NAME_TOGGLERAID = "공격대 창 켜기/끄기"
	BINDING_NAME_TOGGLERAIDSORT = "공격대 정렬 직업별/파티별"
	BINDING_NAME_TOGGLERAIDPETS = "공격대 소환수창 켜기/끄기"
	BINDING_NAME_TOGGLEOPTIONS = "설정창 열기/닫기"
	BINDING_NAME_TOGGLEBUFFTYPE = "버프/디버프/없음 변경"
	BINDING_NAME_TOGGLEBUFFCASTABLE = "시전가능/해제가능 변경"
	BINDING_NAME_TEAMSPEAKMONITOR = "음성대화 현황"
	BINDING_NAME_TOGGLERANGEFINDER = "거리 측정 켜기/끄기"

	XPERL_KEY_NOTICE_RAID_BUFFANY = "모든 버프/디버프 표시"
	XPERL_KEY_NOTICE_RAID_BUFFCURECAST = "오직 시전가능/해제가능 한 버프 또는 디버프만 표시"
	XPERL_KEY_NOTICE_RAID_BUFFS = "공격대 버프 표시"
	XPERL_KEY_NOTICE_RAID_DEBUFFS = "공격대 디버프 표시"
	XPERL_KEY_NOTICE_RAID_NOBUFFS = "공격대 버프 표시안함"

	XPERL_DRAGHINT1		= "창 비율을 조절하려면 |c00FFFFFF클릭|r하세요."
	XPERL_DRAGHINT2		= "창 크기를 조절하려면 |c00FFFFFFSHIFT+클릭|r하세요."

-- 사용법
	XPerlUsageNameList	= {XPerl = "코어", XPerl_Player = "플레이어", XPerl_PlayerPet = "소환수", XPerl_Target = "대상", XPerl_TargetTarget = "대상의 대상", XPerl_Party = "파티", XPerl_PartyPet = "파티 소환수", XPerl_RaidFrames = "공격대 창", XPerl_RaidHelper = "공격대 도우미", XPerl_RaidAdmin = "공격대 관리", XPerl_TeamSpeak = "음성대화 현황", XPerl_RaidMonitor = "공격대 현황", XPerl_RaidPets = "공격대 소환수", XPerl_ArcaneBar = "아케인 바", XPerl_PlayerBuffs = "플레이어 버프", XPerl_GrimReaper = "Grim Reaper"}
	XPERL_USAGE_MEMMAX	= "UI 메모리 최대값 : %d"
	XPERL_USAGE_MODULES	= "모듈: "
	XPERL_USAGE_NEWVERSION	= "*새로운 버전"
	XPERL_USAGE_AVAILABLE	= "%s |c00FFFFFF%s|r : 다운로드 가능"


	XPERL_CMD_HELP			= "|c00FFFF80사용법: |c00FFFFFF/xperl menu | lock | unlock | config list | config delete <서버> <이름>"
	XPERL_CANNOT_DELETE_CURRENT 	= "현재 설정은 삭제할 수 없습니다."
	XPERL_CONFIG_DELETED		= "%s/%s 설정이 삭제되었습니다."
	XPERL_CANNOT_FIND_DELETE_TARGET = "삭제할 설정을 찾을 수 없습니다. (%s/%s)"
	XPERL_CANNOT_DELETE_BADARGS 	= "서버명과 플레이어 이름을 입력하세요."
	XPERL_CONFIG_LIST		= "설정 목록:"
	XPERL_CONFIG_CURRENT		= " (현재)"

	XPERL_RAID_TOOLTIP_WITHBUFF	= "버프있음: (%s)"
	XPERL_RAID_TOOLTIP_WITHOUTBUFF	= "버프없음: (%s)"
	XPERL_RAID_TOOLTIP_BUFFEXPIRING	= "%s의 %s %s 이내 사라짐"	-- Name, buff name, time to expire
	
	XPerl_DefaultRangeSpells.ANY = {item = "두꺼운 황천매듭 붕대"}
end
