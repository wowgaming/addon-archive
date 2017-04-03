--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-koKR.lua - Localized string constants (ko-KR).              *
  ****************************************************************************]]


if ( GetLocale() ~= "koKR" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/koKR/
local _NPCScan = select( 2, ... );
_NPCScan.L = setmetatable( {
	NPCs = setmetatable( {
		[ 18684 ] = "외톨이 브로가즈",
		[ 32491 ] = "잃어비린 시간의 원시비룡",
		[ 33776 ] = "곤드리아",
		[ 35189 ] = "스콜",
		[ 38453 ] = "아크튜리스",
	}, { __index = _NPCScan.L.NPCs; } );

	BUTTON_FOUND = "NPC 탐색!",
	CACHED_FORMAT = "다음 NPC들은 이미 캐쉬에 저장되어 있습니다: %s.",
	CACHED_LONG_FORMAT = "다음 NPC들은 이미 캐쉬에 저장되어 있습니다. |cff808080“/npcscan”|r 으로 메뉴에서 해당 NPC를 삭제하거나, WoW를 종료하고 캐쉬를 비우십시오.",
	CACHED_WORLD_FORMAT = "다음 NPC들 %2$s 은 이미 캐쉬되어 있습니다: %1$s.",
	CACHELIST_ENTRY_FORMAT = "|cff808080“%s”|r",
	CACHELIST_SEPARATOR = ", ",
	CMD_ADD = "ADD",
	CMD_CACHE = "CACHE",
	CMD_CACHE_EMPTY = "탐색하려는 NPC 중 캐쉬된 NPC는 없습니다.",
	CMD_HELP = "명령어: |cff808080“/npcscan add <NpcID> <이름>”|r, |cff808080“/npcscan remove <NpcID or 이름>”|r, |cff808080“/npcscan cache”|r - 캐쉬된 NPC를 보여줍니다. |cff808080“/npcscan”|r - 옵션 메뉴를 보여줍니다.",
	CMD_REMOVE = "REMOVE",
	CMD_REMOVENOTFOUND_FORMAT = "NPC |cff808080“%s”|r가 존재하지 않습니다.",
	CONFIG_ALERT = "경보 옵션",
	CONFIG_ALERT_SOUND = "경보시 사용할 소리",
	CONFIG_ALERT_SOUND_DEFAULT = "|cffffd200기본|r",
	CONFIG_ALERT_SOUND_DESC = "NPC가 탐색되었을 때 재생할 사운드 파일을 선택해주세요. |cff808080“SharedMedia”|r 애드온이 설치되어 있다면, 다른 소리 파일도 사용할 수 있습니다.",
	CONFIG_ALERT_UNMUTE = "경보시에는 음향효과 꺼짐 무시",
	CONFIG_ALERT_UNMUTE_DESC = "음향효과를 꺼 두었다면, NPC를 탐색하게 되었을 때 음향효과를 자동으로 켭니다.",
	CONFIG_CACHEWARNINGS = "로그인 / 큰 지역 이동시 캐쉬 내용 알림",
	CONFIG_CACHEWARNINGS_DESC = "로그인시나 큰 지역을 이동시 이미 캐쉬된 NPC가 있다면, 해당 NPC들이 탐색되지 않음을 알립니다.",
	CONFIG_DESC = "_NPCScan에서 NPC를 탐색하였을때의 경보 옵션을 설정할 수 있습니다.",
	CONFIG_TEST = "탐색시 경보 테스트",
	CONFIG_TEST_DESC = "탐색시 경보가 어떻게 보여지는지 테스트합니다.",
	CONFIG_TEST_HELP_FORMAT = "Target 버튼을 클릭하거나 _NPCScan에 할당해둔 단축키를 눌러 탐색된 NPC를 선택할 수 있습니다. Hold |cffffffff<%s>|r 키를 누른 상태로 Target 버튼을 드래그하여 이동시킬 수 있습니다. 만약 NPC가 전투중에 탐색되었다면, Target버튼은 전투가 끝난 후 활성화 됩니다.",
	CONFIG_TEST_NAME = "당신! (테스트)",
	CONFIG_TITLE = "_|cffCCCC88NPCScan|r",
	FOUND_FORMAT = "탐색 |cff808080“%s”|r!",
	FOUND_TAMABLE_FORMAT = "탐색 |cff808080“%s”|r!  |cffff2020(메모: 길들일 수 있는 몹입니다.)|r",
	FOUND_TAMABLE_WRONGZONE_FORMAT = "|cffff2020가짜 경보|r 탐색된 길들일 수 있는 몹 |cff808080“%s”|r / %s instead / %s (ID %d); 은 사냥꾼의 야수입니다.",
	PRINT_FORMAT = "_|cffCCCC88NPCScan|r: %s",
	SEARCH_ACHIEVEMENTADDFOUND = "이미 완료한 업적에 포함되어 있는 NPC도 검색",
	SEARCH_ACHIEVEMENTADDFOUND_DESC = "이미 완료한 업적에 포함되어 있는 NPC를 계속 탐색합니다.",
	SEARCH_ACHIEVEMENT_DISABLED = "비활성화됨",
	SEARCH_ADD = "+",
	SEARCH_ADD_DESC = "새로운 NPC를 추가하거나, 변경된 내용을 저장합니다.",
	SEARCH_ADD_TAMABLE_FORMAT = "메모: |cff808080“%s”|r 는 길들일 수 있습니다. 이미 길들여진 사냥꾼의 야수를 보게된다면 가짜 경보가 발생할 수 있습니다.",
	SEARCH_CACHED = "캐쉬됨",
	SEARCH_COMPLETED = "완료",
	SEARCH_DESC = "이 표에서 탐색하려는 NPC와 업적에 관련된 몹을 추가 / 삭제할 수 있습니다.",
	SEARCH_ID = "NPC ID:",
	SEARCH_ID_DESC = "탐색할 NPC의 ID입니다.  WowHead.com과 같은 싸이트를 통하여 찾을 수 있습니다.",
	SEARCH_NAME = "이름:",
	SEARCH_NAME_DESC = "NPC에 붙일 이름입니다. 내부적으로 NPC ID를 사용하므로, 희귀몹의 실제 이름과 일치하지 않아도 됩니다.",
	SEARCH_NPCS = "직접 추가",
	SEARCH_NPCS_DESC = "업적에 관계 없이 아무 NPC나 ID를 등록하여 탐색할 수 있습니다.",
	SEARCH_REMOVE = "-",
	SEARCH_TITLE = "탐색",
	SEARCH_WORLD = "큰 지역",
	SEARCH_WORLD_DESC = "지역을 한정하여 조금 더 효율적으로 탐색할 수 있도록 합니다.  큰 지역의 이름이나 던전 이름을 사용할 수 있습니다. (대소문자 정확하게)",
	SEARCH_WORLD_FORMAT = "(%s)",
}, { __index = _NPCScan.L; } );


_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = [=[마지막으로 탐색된 NPC 타겟
|cff808080(_NPCScan에서 탐색이 되어 경보가 되었을 때)|r]=];