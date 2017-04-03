--[[
    This file is part of Decursive.
    
    Decursive (v 2.5.1-6-gd3885c5) add-on for World of Warcraft UI
    Copyright (C) 2006-2007-2008-2009 John Wellesz (archarodim AT teaser.fr) ( http://www.2072productions.com/?to=decursive.php )

    This is the continued work of the original Decursive (v1.9.4) by Quu
    "Decursive 1.9.4" is in public domain ( www.quutar.com )

    Decursive is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Decursive is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Decursive.  If not, see <http://www.gnu.org/licenses/>.
--]]
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Korean localization
-------------------------------------------------------------------------------

--[=[
--                      YOUR ATTENTION PLEASE
--
--         !!!!!!! TRANSLATORS TRANSLATORS TRANSLATORS !!!!!!!
--
--    Thank you very much for your interest in translating Decursive.
--    Do not edit those files. Use the localization interface available at the following address:
--
--      ################################################################
--      #  http://wow.curseforge.com/projects/decursive/localization/  #
--      ################################################################
--
--    Your translations made using this interface will be automatically included in the next release.
--
--]=]

local addonName, T = ...;
-- big ugly scary fatal error message display function {{{
if not T._FatalError then
-- the beautiful error popup : {{{ -
StaticPopupDialogs["DECURSIVE_ERROR_FRAME"] = {
    text = "|cFFFF0000Decursive Error:|r\n%s",
    button1 = "OK",
    OnAccept = function()
        return false;
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    showAlert = 1,
    }; -- }}}
T._FatalError = function (TheError) StaticPopup_Show ("DECURSIVE_ERROR_FRAME", TheError); end
end
-- }}}
if not T._LoadedFiles or not T._LoadedFiles["enUS.lua"] then
    if not DecursiveInstallCorrupted then T._FatalError("Decursive installation is corrupted! (enUS.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end

-------------------------------------------------------------------------------
-- Korean localization
-------------------------------------------------------------------------------

local L = LibStub("AceLocale-3.0"):NewLocale("Decursive", "koKR");

if not L then
    T._LoadedFiles["koKR.lua"] = "2.5.1-6-gd3885c5";
    return;
end;

L["ABOLISH_CHECK"] = "해제 전 \"해제 주문\" 검사"
L["ABOUT_AUTHOREMAIL"] = "제작자 이메일"
L["ABOUT_CREDITS"] = "공로자"
L["ABOUT_LICENSE"] = "라이센스"
L["ABOUT_NOTES"] = "쏠로, 파티, 공격대를 위한 고급화된 필터링과 시스템 우선권으로 고통들의 표시와 제거를 합니다."
L["ABOUT_OFFICIALWEBSITE"] = "공식 웹사이트"
L["ABOUT_SHAREDLIBS"] = "공유된 라이브러리들"
L["ABSENT"] = "(%s) 자리비움"
L["AFFLICTEDBY"] = "%s에 걸림"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "표시할 대상의 수 : "
L["ANCHOR"] = "Decursive 글자 위치"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "작은 유닛 프레임 표시/숨김"
L["BINDING_NAME_DCRPRADD"] = "대상을 우선순위 목록에 추가"
L["BINDING_NAME_DCRPRCLEAR"] = "우선순위 목록 초기화"
L["BINDING_NAME_DCRPRLIST"] = "우선순위 목록 출력"
L["BINDING_NAME_DCRPRSHOW"] = "우선순위 목록 표시/숨김"
L["BINDING_NAME_DCRSHOW"] = [=[Decursive 메인바 표시/숨김
(실시간 목록 고정위치)]=]
L["BINDING_NAME_DCRSHOWOPTION"] = "고정 창 설정 표시"
L["BINDING_NAME_DCRSKADD"] = "대상을 제외 목록에 추가"
L["BINDING_NAME_DCRSKCLEAR"] = "제외 목록 초기화"
L["BINDING_NAME_DCRSKLIST"] = "제외 목록 출력"
L["BINDING_NAME_DCRSKSHOW"] = "제외 목록 표시/숨김"
L["BLACK_LENGTH"] = "블랙리스트 추가 시간(초) : "
L["BLACKLISTED"] = "블랙리스트됨"
L["CHARM"] = "변이"
L["CLASS_HUNTER"] = "사냥꾼"
L["CLEAR_PRIO"] = "C"
L["CLEAR_SKIP"] = "C"
L["COLORALERT"] = "'%s'|1이;가; 필요할때의 알림 색상을 설정합니다."
L["COLORCHRONOS"] = "크로노미터"
L["COLORCHRONOS_DESC"] = "크로노미터의 색상을 설정합니다."
L["COLORSTATUS"] = "MUF 상태가 '%s'일때 색상을 설정합니다."
L["CTRL"] = "Ctrl"
L["CURE_PETS"] = "소환수 탐색과 해제"
L["CURSE"] = "저주"
L["DEBUG_REPORT_HEADER"] = [=[|cFF11FF33Archarodim+DcrReport@teaser.fr로 이 창의 내용을 보고해 주십시오|r
|cFF009999(CTRL+A키로 모두 선택하고 CTRL+C키로 당신의 클립보드 내 문자를 넣어 사용하십시오)|r
또한 당신이 눈치챈 Decursive의 어떠한 이상 증상도 보고서에 알리십시오.
]=]
L["DECURSIVE_DEBUG_REPORT"] = "**** |cFFFF0000Decursive 디버그 보고서|r ****"
L["DECURSIVE_DEBUG_REPORT_NOTIFY"] = [=[디버그 보고서가 유효합니다!
|cFFFF0000/dcr general report|r를 입력해 그것을 확인합니다.]=]
L["DECURSIVE_DEBUG_REPORT_SHOW"] = "디버그 보고서 유효함!"
L["DECURSIVE_DEBUG_REPORT_SHOW_DESC"] = "개발자의 확인이 필요한 디버그 보고서 보기..."
L["DEFAULT_MACROKEY"] = "NONE"
L["DEV_VERSION_ALERT"] = [=[당신은 Decursive의 개발자 버전을 사용중입니다.

만약 당신이 새로운 지원들/수정들, 게임중 디버그 보고서 보내기, 개발자에게 문제점 보내기 위해 테스트에 참여하고 싶지않다면 '이 버전을 사용하지 마십시오.' 그리고 curse.com의 최종 '안정화' 버전을 다운로드 하십시오.

이 메세지는 버전마다 한번씩만 표시됩니다.

Decursive의 개발자 버전은 플레이어가 게임을 시작 할 때 경고가 표시됩니다.]=]
L["DEV_VERSION_EXPIRED"] = [=[본 Decursive의 개발자 버전은 만료되었습니다.
마지막 개발자 버전을 다운로드하거나 CURSE.COM 또는 WOWACE.COM에서 현재 안정화 배포판을 사용해 주십시오.
이 경고는 2일간 항상 표시됩니다.

알림: Decursive의 만료된 개발 버전으로 접속 시 사용자에게 매번 표시됩니다.]=]
L["DEWDROPISGONE"] = "거기엔 Ace3에 대해 상응하는 DewDrop이 없습니다. Alt+우-클릭으로 설정판을 여십시오."
L["DISABLEWARNING"] = [=[Decursive 사용이 중지되었습니다!

다시 사용하려면, |cFFFFAA44/DCR ENABLE|r를 입력하세요.]=]
L["DISEASE"] = "질병"
L["DONOT_BL_PRIO"] = "우선순위 블랙리스트 제외"
L["FAILEDCAST"] = [=[|cFF22FFFF%s %s|r|1으로;로; %s |cFFAA0000치료 실패|r
|cFF00AAAA%s|r]=]
L["FOCUSUNIT"] = "주시대상"
L["FUBARMENU"] = "FuBar 메뉴"
L["FUBARMENU_DESC"] = "FuBar 아이콘에 관련된 옵션을 설정합니다."
L["GLOR1"] = "Glorfindal의 추억속에"
L["GLOR2"] = [=[Decursive는 돌아올 수 없는 길을 떠난 Bertrand의 추억에 바칩니다.
그는 언제나 기억될 것입니다.]=]
L["GLOR3"] = [=[Bertrand Sense를 기억하며
1969 - 2007]=]
L["GLOR4"] = [=[사랑과 우정은 그들은 언제 어디에서나 얻을 수 있습니다, World of Warcraft에서 Glorfindal을 만났던 사람들은 훌륭히 책임감있고 카리스마 넘치는 지도자로 알고 있었습니다.

그는 게임 속 삶에 있어서, 모든 이들과 그의 친구들에게 헌신적이고, 사심없고, 관대하였고, 열정적인 사람이었습니다.

그는 가상 세계 속의 단지 익명 플레이어로써 훗날 38의 나이에 떠나갔지만, 진정한 친구들이라면 그를 영원히 그리워 할 것입니다.]=]
L["GLOR5"] = "그는 언제나 기억될 것입니다..."
L["HANDLEHELP"] = "작은 유닛 프레임(MUFs) 모두 이동"
L["HIDE_LIVELIST"] = "실시간 목록 숨김"
L["HIDE_MAIN"] = "Decursive 창 숨김"
L["HIDESHOW_BUTTONS"] = "버튼 표시/숨김"
L["HLP_LEFTCLICK"] = "좌-클릭"
L["HLP_LL_ONCLICK_TEXT"] = [=[실시간 목록을 클릭하는 것은 WoW 2.0 이후 사용할 수 없습니다. Decursive 폴더에 위치한 "Readme.txt" 읽어 보세요...
(해당 목록을 이동하려면 /dcrshow 혹은 ALT-좌-클릭하세요.)]=]
L["HLP_MIDDLECLICK"] = "가운데-클릭"
L["HLP_NOTHINGTOCURE"] = "치료할 것이 없습니다!"
L["HLP_RIGHTCLICK"] = "우-클릭"
L["HLP_USEXBUTTONTOCURE"] = "해당 디버프를 치료하려면 \"%s\" 버튼을 사용하세요"
L["HLP_WRONGMBUTTON"] = "잘못된 마우스 버튼입니다!"
L["IGNORE_STEALTH"] = "은신 대상 무시"
L["IS_HERE_MSG"] = "Decursive가 초기화 되었습니다. 옵션을 설정하세요."
L["LIST_ENTRY_ACTIONS"] = [=[|cFF33AA33[CTRL]|r 클릭: 해당 플레이어 제거
|cFF33AA33좌|r-클릭: 해당 플레이어를 위로
|cFF33AA33우|r-클릭: 해당 플레이어를 아래로
|cFF33AA33[SHIFT] 좌|r-클릭: 해당 플레이어를 최상위로
|cFF33AA33[SHIFT] 우|r-클릭: 해당 플레이어를 최하위로]=]
L["MACROKEYALREADYMAPPED"] = [=[경고: Decursive 매크로에 지정한 [%s]키는 '%s'|1을;를; 위해 지정되어 있습니다.
당신이 매크로에 다른 키를 지정하면 Decursive는 이전 설정을 복원할 것입니다.]=]
L["MACROKEYMAPPINGFAILED"] = "[%s] 키는 Decursive 매크로로 지정할 수 없습니다!"
L["MACROKEYMAPPINGSUCCESS"] = "[%s] 키가 Decursive 매크로로 성공적으로 지정되었습니다."
L["MACROKEYNOTMAPPED"] = "Decursive 마우스오버 매크로는 지정된 키가 없습니다, '매크로' 설정을 보시면 키를 지정할 수 있습니다!"
L["MAGIC"] = "마법"
L["MAGICCHARMED"] = "마법 정화"
L["MISSINGUNIT"] = "잘못된 대상"
L["NORMAL"] = "정상"
L["NOSPELL"] = "이용가능한 주문이 없습니다."
L["OPT_ABOLISHCHECK_DESC"] = "'해제' 주문을 가진 대상을 표시하고 치유 할 지를 선택합니다."
L["OPT_ABOUT"] = "관하여"
L["OPT_ADDDEBUFF"] = "목록에 디버프 추가"
L["OPT_ADDDEBUFF_DESC"] = "이 목록에 새로운 디버프 추가"
L["OPT_ADDDEBUFFFHIST"] = "최근의 디버프 추가"
L["OPT_ADDDEBUFFFHIST_DESC"] = "예전에 사용된 디버프를 추가합니다."
L["OPT_ADDDEBUFF_USAGE"] = "<디버프명>"
L["OPT_ADVDISP"] = "고급 표시 설정"
L["OPT_ADVDISP_DESC"] = "각 MUF 사이 간격 설정을 위해 테두리와 가운데 구분의 투명도를 설정할 수 있습니다."
L["OPT_AFFLICTEDBYSKIPPED"] = "%s - %s에 걸리면 무시합니다."
L["OPT_ALWAYSIGNORE"] = "비전투시에도 항상 무시"
L["OPT_ALWAYSIGNORE_DESC"] = "선택 시 해당 디버프는 전투 중이 아닐때도 무시됩니다."
L["OPT_AMOUNT_AFFLIC_DESC"] = "실시간 목록에 표시할 유닛의 최대 수를 지정합니다."
L["OPT_ANCHOR_DESC"] = "사용자 정의 메세지창의 고정위치를 표시합니다."
L["OPT_AUTOHIDEMFS"] = "자동숨김"
L["OPT_AUTOHIDEMFS_DESC"] = "선택하면 언제 MUF창을 숨겨둘지 설정합니다."
L["OPT_BLACKLENTGH_DESC"] = "블랙리스트에 등록할 시간을 지정합니다."
L["OPT_BORDERTRANSP"] = "테두리 투명도"
L["OPT_BORDERTRANSP_DESC"] = "테두리의 투명도를 설정합니다."
L["OPT_CENTERTRANSP"] = "가운데 투명도"
L["OPT_CENTERTRANSP_DESC"] = "가운데의 투명도를 설정합니다."
L["OPT_CHARMEDCHECK_DESC"] = "선택 시 지배에 걸린 대상을 표시하고 변이합니다."
L["OPT_CHATFRAME_DESC"] = "Decursive의 메세지가 기본 대화창에 표시됩니다."
L["OPT_CHECKOTHERPLAYERS"] = "다른 플레이어 확인"
L["OPT_CHECKOTHERPLAYERS_DESC"] = "당신이 현재 속한 길드 또는 그룹 플레이어의 Decursive 버전을 표시합니다. (Decursive 2.4.6 이전 버전은 표시할 수 없습니다.)"
L["OPT_CREATE_VIRTUAL_DEBUFF"] = "가상 테스트 디버프 생성"
L["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = "디버프 발생 시 어떻게 보여지는 지를 표시하도록 합니다."
L["OPT_CUREPETS_DESC"] = "소환수를 관리하고 해제합니다."
L["OPT_CURINGOPTIONS"] = "해제 옵션"
L["OPT_CURINGOPTIONS_DESC"] = "해제의 다양한 형태를 설정합니다."
L["OPT_CURINGOPTIONS_EXPLANATION"] = [=[
당신이 치료를 원하는 재난의 유형을 선택, 선택하지 않은 유형은 Decursive에서 완전히 무시될 것입니다.

재난의 우선 순위는 녹색 숫자로 정의됩니다. 이것은 몇 가지 영향을 미칠 것입니다:
- 플레이어에 여러 종류의 디버프가 걸려있으면 Decursive가 먼저 표시 할 지.
- 당신이 디버프를 치료하려 어떤 마우스 버튼을 클릭 할 지.(첫째 주문은 좌-클릭, 둘째는 우-클릭, 등...)

여기에 모든 설명이 기술되어 있습니다(참조 요망):
http://www.wowace.com/addons/decursive/]=]
L["OPT_CURINGORDEROPTIONS"] = "해제 순서 설정"
L["OPT_CURSECHECK_DESC"] = "체크 시 저주에 걸린 대상을 표시하고 치료합니다."
L["OPT_DEBCHECKEDBYDEF"] = [=[
기본값으로 설정됨]=]
L["OPT_DEBUFFENTRY_DESC"] = "해당 디버프에 걸렸을 때 전투 중 무시할 직업을 선택하세요."
L["OPT_DEBUFFFILTER"] = "디버프 필터링"
L["OPT_DEBUFFFILTER_DESC"] = "이름과 직업에 의해 필터링 할 디버프를 선택합니다."
L["OPT_DISABLEMACROCREATION"] = "매크로 생성 사용안함"
L["OPT_DISABLEMACROCREATION_DESC"] = "Decursive 매크로를 더 이상 생성 또는 유지할 수 없습니다."
L["OPT_DISEASECHECK_DESC"] = "선택 시 질병에 걸린 대상을 표시하고 치료합니다."
L["OPT_DISPLAYOPTIONS"] = "디스플레이 옵션"
L["OPT_DONOTBLPRIO_DESC"] = "우선순위에 등록된 유닛은 블랙리스트에 추가하지 않습니다."
L["OPT_ENABLEDEBUG"] = "디버깅 사용"
L["OPT_ENABLEDEBUG_DESC"] = "디버깅 출력 사용"
L["OPT_ENABLEDECURSIVE"] = "Decursive 사용"
L["OPT_FILTEROUTCLASSES_FOR_X"] = "당신이 전투중인 동안 %q로 지정된 클래스는 무시됩니다."
L["OPT_GENERAL"] = "기본 설정"
L["OPT_GROWDIRECTION"] = "MUF 표시 반전"
L["OPT_GROWDIRECTION_DESC"] = "MUF를 하단에서 상단으로 표시합니다."
L["OPT_HIDELIVELIST_DESC"] = "숨긴다면 해제된 대상의 정보를 표시합니다."
L["OPT_HIDEMFS_GROUP"] = "솔로/파티"
L["OPT_HIDEMFS_GROUP_DESC"] = "MUF창을 공격대에 속해있지 않을 때 숨겨둡니다."
L["OPT_HIDEMFS_NEVER"] = "사용안함"
L["OPT_HIDEMFS_NEVER_DESC"] = "MUF창의 자동숨김을 사용하지 않습니다."
L["OPT_HIDEMFS_SOLO"] = "솔로"
L["OPT_HIDEMFS_SOLO_DESC"] = "MUF창을 파티나 공격대에 속해있지 않을 때 숨겨둡니다."
L["OPT_IGNORESTEALTHED_DESC"] = "은신한 대상을 무시합니다."
L["OPTION_MENU"] = "Decursive 설정 메뉴"
L["OPT_LIVELIST"] = "실시간 목록"
L["OPT_LIVELIST_DESC"] = "실시간 목록에 대한 설정입니다."
L["OPT_LLALPHA"] = "실시간 목록 투명도"
L["OPT_LLALPHA_DESC"] = "Decursive 메인바와 실시간 목록의 투명도를 변경합니다. (메인바가 표시되어 있어야 함)"
L["OPT_LLSCALE"] = "실시간 목록 크기"
L["OPT_LLSCALE_DESC"] = "Decursive 메인바와 실시간 목록의 크기를 설정합니다. (메인바가 표시되어 있어야 함)"
L["OPT_LVONLYINRANGE"] = "범위 내 대상"
L["OPT_LVONLYINRANGE_DESC"] = "해제 범위 내 대상만 실시간 목록에 표시합니다."
L["OPT_MACROBIND"] = "매크로 단축키 설정"
L["OPT_MACROBIND_DESC"] = [=['Decursive' 매크로를 호출 할 키를 지정합니다.

키를 누르고 키보드의 'Enter'키를 누르면 새롭게 지정된 키가 저장됩니다.(당신의 마우스 커서가 편집 구역내에 있어야 합니다)]=]
L["OPT_MACROOPTIONS"] = "매크로 설정"
L["OPT_MACROOPTIONS_DESC"] = "Decursive에 의해 생성된 매크로의 동작을 설정합니다."
L["OPT_MAGICCHARMEDCHECK_DESC"] = "체크 시 지배에 걸린 대상을 표시하고 치료합니다."
L["OPT_MAGICCHECK_DESC"] = "체크 시 마법에 걸린 대상을 표시하고 치료합니다."
L["OPT_MAXMFS"] = "표시할 최대 유닛"
L["OPT_MAXMFS_DESC"] = "표시할 작은 유닛 프레임의 최대 갯수를 지정합니다."
L["OPT_MESSAGES"] = "메세지"
L["OPT_MESSAGES_DESC"] = "메세지 표시에 대한 설정입니다."
L["OPT_MFALPHA"] = "투명도"
L["OPT_MFALPHA_DESC"] = "디버프의 걸린 대상이 없을 때 MUF의 투명도를 지정합니다."
L["OPT_MFPERFOPT"] = "성능 설정"
L["OPT_MFREFRESHRATE"] = "갱신 주기"
L["OPT_MFREFRESHRATE_DESC"] = "갱신할 시간 간격(한번에 1 혹은 그 이상 작은 유닛 프레임을 갱신할 수 있습니다.)"
L["OPT_MFREFRESHSPEED"] = "갱신 속도"
L["OPT_MFREFRESHSPEED_DESC"] = "한번에 갱신할 작은 유닛 프레임의 갯수"
L["OPT_MFSCALE"] = "작은 유닛 프레임의 크기"
L["OPT_MFSCALE_DESC"] = "작은 유닛 프레임의 크기를 설정합니다."
L["OPT_MFSETTINGS"] = "작은 유닛 프레임 설정"
L["OPT_MFSETTINGS_DESC"] = "작은 유닛 프레임에 대한 설정입니다."
L["OPT_MUFMOUSEBUTTONS"] = "마우스 버튼"
L["OPT_MUFMOUSEBUTTONS_DESC"] = "각 MUF의 경고색을 위해 당신이 사용하고자하는 마우스 버튼을 설정합니다."
L["OPT_MUFSCOLORS"] = "색상"
L["OPT_MUFSCOLORS_DESC"] = "작은 유닛 프레임의 색상을 변경합니다."
L["OPT_NOKEYWARN"] = "키 없음 경고"
L["OPT_NOKEYWARN_DESC"] = "지정된 키가 없다면 경고 문구를 표시합니다."
L["OPT_NOSTARTMESSAGES"] = "환영 메세지 사용안함"
L["OPT_NOSTARTMESSAGES_DESC"] = "매일 로그인 시 대화창에 Decursive가 출력하는 3개의 메세지를 제거합니다."
L["OPT_PLAYSOUND_DESC"] = "해제 가능한 디버프 발견시 효과음을 재생합니다."
L["OPT_POISONCHECK_DESC"] = "체크 시 독에 걸린 대상을 표시하고 치료합니다."
L["OPT_PRINT_CUSTOM_DESC"] = "Decursive의 메세지가 사용자 정의 대화창에 표시됩니다."
L["OPT_PRINT_ERRORS_DESC"] = "오류를 표시합니다."
L["OPT_PROFILERESET"] = "프로필 초기화..."
L["OPT_RANDOMORDER_DESC"] = "대상을 무작위로 표시하고 치료합니다.(비추천)"
L["OPT_READDDEFAULTSD"] = "기본 디버프 재추가"
L["OPT_READDDEFAULTSD_DESC1"] = [=[해당 목록에 누락된 Decursive의 기본 디버프를 추가합니다.
설정은 변하지 않습니다.]=]
L["OPT_READDDEFAULTSD_DESC2"] = "Decursive의 모든 기본 디버프는 해당 목록에 있습니다."
L["OPT_REMOVESKDEBCONF"] = [=[정말로 Decursive의 디버프 제외 목록에서
'%s'|1을;를; 제거 하시겠습니까?]=]
L["OPT_REMOVETHISDEBUFF"] = "해당 디버프 제거"
L["OPT_REMOVETHISDEBUFF_DESC"] = "제외 목록에서 '%s' 제거"
L["OPT_RESETDEBUFF"] = "해당 디버프 초기화"
L["OPT_RESETDTDCRDEFAULT"] = "'%s' Decursive 기본으로 초기화"
L["OPT_RESETMUFMOUSEBUTTONS"] = "초기화"
L["OPT_RESETMUFMOUSEBUTTONS_DESC"] = "기본값으로 할당된 마우스 버튼을 초기화합니다."
L["OPT_RESETOPTIONS"] = "기본값으로 설정 초기화"
L["OPT_RESETOPTIONS_DESC"] = "현재 프로필을 기본값으로 초기화합니다."
L["OPT_RESTPROFILECONF"] = [=[정말로 '(%s) %s'
프로필을 기본 설정으로
초기화 하시겠습니까?]=]
L["OPT_REVERSE_LIVELIST_DESC"] = "실시간 목록을 아래에서 위로 생성합니다."
L["OPT_SCANLENGTH_DESC"] = "각 탐색의 시간 간격을 지정합니다."
L["OPT_SHOWBORDER"] = "직업 색상 테두리 표시"
L["OPT_SHOWBORDER_DESC"] = "MUF에 유닛의 직업에 따른 색상을 테두리로 표시합니다."
L["OPT_SHOWCHRONO"] = "크로노미터 표시"
L["OPT_SHOWCHRONO_DESC"] = "유닛이 주문에 걸린 이후 경과된 초의 숫자를 표시합니다."
L["OPT_SHOWCHRONOTIMElEFT"] = "남은 시간"
L["OPT_SHOWCHRONOTIMElEFT_DESC"] = "경과한 시간 대신 남은 시간을 표시합니다."
L["OPT_SHOWHELP"] = "도움말 표시"
L["OPT_SHOWHELP_DESC"] = "작은 유닛 프레임에 마우스를 올리면 정보 툴팁을 표시합니다."
L["OPT_SHOWMFS"] = "작은 유닛 프레임(MUF) 표시"
L["OPT_SHOWMFS_DESC"] = "클릭으로 해제하려면 반드시 활성화 되어야 합니다."
L["OPT_SHOWMINIMAPICON"] = "미니맵 아이콘"
L["OPT_SHOWMINIMAPICON_DESC"] = "미니맵 아이콘을 표시합니다."
L["OPT_SHOW_STEALTH_STATUS"] = "은신 상태 보기"
L["OPT_SHOW_STEALTH_STATUS_DESC"] = "플레이어가 은신중이면, 그 MUF는 특정한 색상을 갖게 될 것임"
L["OPT_SHOWTOOLTIP_DESC"] = "실시간 목록과 작은 유닛 프레임에 디버프에 대한 자세한 툴팁을 표시합니다."
L["OPT_STICKTORIGHT"] = "MUF창 오른쪽으로 정렬"
L["OPT_STICKTORIGHT_DESC"] = "MUF창은 오른쪽에서 왼쪽으로 증가되며 동작은 자동적으로 이루어질 것입니다."
L["OPT_TIECENTERANDBORDER"] = "가운데와 테두리의 투명도"
L["OPT_TIECENTERANDBORDER_OPT"] = "체크 시 테두리의 투명도가 가운데 투명도의 절반이 됩니다."
L["OPT_TIE_LIVELIST_DESC"] = "실시간 목록을 아래에서 위로 생성합니다."
L["OPT_TIEXYSPACING"] = "수평/수직 간격"
L["OPT_TIEXYSPACING_DESC"] = "MUF의 수평과 수직 간격이 같아 집니다."
L["OPT_UNITPERLINES"] = "한줄에 표시할 유닛의 갯수"
L["OPT_UNITPERLINES_DESC"] = "한줄에 표시할 작은 유닛 프레임의 최대 갯수를 지정합니다."
L["OPT_USERDEBUFF"] = "해당 디버프는 Decursive의 기본 디버프가 아닙니다."
L["OPT_XSPACING"] = "수평 간격"
L["OPT_XSPACING_DESC"] = "MUF 사이의 수평 간격을 설정합니다."
L["OPT_YSPACING"] = "수직 간격"
L["OPT_YSPACING_DESC"] = "MUF 사이의 수직 간격을 설정합니다."
L["PLAY_SOUND"] = "효과음 재생"
L["POISON"] = "독"
L["POPULATE"] = "p"
L["POPULATE_LIST"] = "Decursive 목록에 빠른 추가"
L["PRINT_CHATFRAME"] = "기본 대화창에 메세지 표시"
L["PRINT_CUSTOM"] = "Decursive 창에 메세지 표시"
L["PRINT_ERRORS"] = "오류 메세지 출력"
L["PRIORITY_LIST"] = "Decursive 우선순위 목록"
L["PRIORITY_SHOW"] = "P"
L["RANDOM_ORDER"] = "무작위 해제"
L["REVERSE_LIVELIST"] = "실시간 목록 표시 반전"
L["SCAN_LENGTH"] = "실시간 탐색 시간(초) : "
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "Decursive 창 표시, /dcrshow 명령어를 입력하세요."
L["SHOW_TOOLTIP"] = "디버프 걸린 대상의 툴팁 표시"
L["SKIP_LIST_STR"] = "Decursive 제외 목록"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "%s 주문 발견!"
L["STEALTHED"] = "은신상태"
L["STR_CLOSE"] = "닫기"
L["STR_DCR_PRIO"] = "Decursive 우선순위"
L["STR_DCR_SKIP"] = "Decursive 제외"
L["STR_GROUP"] = "파티 "
L["STR_OPTIONS"] = "Decursive 설정"
L["STR_OTHER"] = "기타"
L["STR_POP"] = "추가 목록"
L["STR_QUICK_POP"] = "빠른 추가"
L["SUCCESSCAST"] = "|cFF22FFFF%s %s|r|1으로;로; %s |cFF00AA00치료 성공!|r"
L["TARGETUNIT"] = "대상"
L["TIE_LIVELIST"] = "실시간 목록 표시를 DCR 창과 함께 표시"
L["TOOFAR"] = "거리 벗어남"
L["UNITSTATUS"] = "상태: "



T._LoadedFiles["koKR.lua"] = "2.5.1-6-gd3885c5";
