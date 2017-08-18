local L =  LibStub:GetLibrary("AceLocale-3.0"):NewLocale("Talented", "koKR")
if not L then return end

L["Talented - Talent Editor"] = "Talented - 특성 편집기"

L["Layout options"] = "외형 설정"
--~ L["Options that change the visual layout of Talented."] = "Talented 창의 외형을 변경합니다."
L["Icon offset"] = "아이콘 간격"
L["Distance between icons."] = "아이콘간의 간격 설정"
L["Frame scale"] = "특성창 크기"
L["Overall scale of the Talented frame."] = "Talented 창의 전체 크기 비율."

L["Options"] = "설정"
L["General Options for Talented."] = "Talented의 일반 설정."
L["Always edit"] = "항상 특성 편집 허용"
L["Always allow templates and the current build to be modified, instead of having to Unlock them first."] = "잠금 상태로 시작하지 않고 항상 현재 특성 및 템플릿의 특성 편집을 허용합니다."
L["Confirm Learning"] = "확인하고 배우기"
L["Ask for user confirmation before learning any talent."] = "특성을 배우기전에 사용자에게 확인 요청을 합니다."
--~ L["Don't Confirm when applying"] = "확인하지 않고 적용"
--~ L["Don't ask for user confirmation when applying full template."] = "템플릿 특성 전체를 적용할때 사용자에게 확인 요청을 하지 않습니다."
L["Always try to learn talent"] = "항상 배우기 시도"
L["Always call the underlying API when a user input is made, even when no talent should be learned from it."] = "배울것이 없어도 항상 배우기를 시도합니다."
L["Talent cap"] = "최대 특성 포인트 제한"
L["Restrict templates to a maximum of %d points."] = "템플릿의 최대 특성 포인트를 %d로 제한합니다."
L["Level restriction"] = "레벨 제한"
L["Show the required level for the template, instead of the number of points."] = "배운 특성 포인트 대신 템플릿 적용에 필요한 최소 레벨을 보여줍니다."
--~ L["Load outdated data"] = "구버전 데이타 로딩"
--~ L["Load Talented_Data, even if outdated."] = "구버전의 Talented_Data를 불러옵니다."
L["Hook Inspect UI"] = "살펴보기 UI 가로채기"
L["Hook the Talent Inspection UI."] = "특성 살펴보기 UI로 대체합니다."
L["Output URL in Chat"] = "대화창에 URL 출력"
L["Directly outputs the URL in Chat instead of using a Dialog."] = "별도의 복사 창을 사용하지 않고 대화창에 URL을 바로 출력합니다."

L["Inspected Characters"] = "살펴보기 한 캐릭터"
--~ L["Talent trees of inspected characters."] = "살펴보기 한 캐릭터의 특성"
L["Edit template"] = "템플릿 편집"
L["Edit talents"] = "특성 편집"
L["Toggle edition of the template."] = "템플릿의 편집 모드 토글"
L["Toggle editing of talents."] = "특성의 편집 모드 토글"

L["Templates"] = "템플릿"
L["Actions"] = "동작"
L["You can edit the name of the template here. You must press the Enter key to save your changes."] = "이 템플릿의 이름을 편집할 수 있습니다. 변경 값을 저장하려면 엔터키를 누르십시오."

L["Remove all talent points from this tree."] = "본 트리의 모든 특성 포인트를 제거합니다."
L["%s (%d)"] = "%s (%d)"
L["Level %d"] = "%d 레벨"
L["%d/%d"] = "%d/%d"
--~ L["Right-click to unlearn"] = "우클릭으로 배우기 취소"
L["Effective tooltip information not available"] = "유효한 툴팁 정보가 없습니다"
L["You have %d talent |4point:points; left"] = "남은 특성 포인트: %d"
L["Are you sure that you want to learn \"%s (%d/%d)\" ?"] = "정말로 배우겠습니까 \"%s (%d/%d)\" ?"

--~ L["Open the Talented options panel."] = "Talented 설정 창을 엽니다."

--~ L["View Current Spec"] = "현재 특성 보기"
L["View the Current spec in the Talented frame."] = "Talented 창에 현재 특성을 보여줍니다."
--~ L["View Alternate Spec"] = "대체 특성 보기"
L["Switch to this Spec"] = "이 특성으로 전환"
L["View Pet Spec"] = "소환수 특성 보기"

L["New Template"] = "새로운 템플릿"
L["Empty"] = "<이름 입력>"

L["Apply template"] = "템플릿 적용"
L["Copy template"] = "템플릿 복사"
L["Delete template"] = "템플릿 삭제"
L["Set as target"] = "대상으로 지정"
L["Clear target"] = "대상 해제"

L["Sorry, I can't apply this template because you don't have enough talent points available (need %d)!"] = "남은 특성 포인트가 충분하지 않기 때문에 이 템플릿은 적용할 수 없습니다 (%d 필요)!"
L["Sorry, I can't apply this template because it doesn't match your pet's class!"] = "소환수의 종류가 템플릿과 일치하지 않기 때문에 이 템플릿은 적용할 수 없습니다!"
L["Sorry, I can't apply this template because it doesn't match your class!"] = "당신의 직업이 템플릿과 일치하지 않기 때문에 이 템플릿은 적용할 수 없습니다!"
L["Nothing to do"] = "아무것도 할 수 없음"
--~ L["Talented cannot perform the required action because it does not have the required talent data available for class %s. You should inspect someone of this class."] = "Talented가 %s 직업의 특성 데이타를 가지고 있지 않기 때문에 요구한 동작을 수행할수 없습니다. (같은 직업의 캐릭터를 살펴보기 해야 합니다)"
--~ L["You must install the Talented_Data helper addon for this action to work."] = "이 동작을 수행하려면 먼저 Talented_Data 애드온이 설치되어야 합니다."
--~ L["You can download it from http://files.wowace.com/ ."] = "http://files.wowace.com/ 에서 다운 받으실 수 있습니다."

L["Inspection of %s"] = "%s의 살펴보기"
L["Select %s"] = "%s 선택"
L["Copy of %s"] = "%s의 사본"
L["Target: %s"] = "대상: %s"
L["Imported"] = "가져옴"

L["Please wait while I set your talents..."] = "특성을 적용하는 동안 기다리십시오..."
L["The given template is not a valid one!"] = "해당 템플릿은 유효하지 않습니다!"
L["Error while applying talents! Not enough talent points!"] = "특성을 적용하는 중 오류 발생! 특성 포인트가 충분하지 않습니다!"
L["Error while applying talents! some of the request talents were not set!"] = "특성을 적용하는 중 오류 발생! 요청한 특성 중 일부는 설정할 수 없습니다!"
L["Error! Talented window has been closed during template application. Please reapply later."] = "오류! 템플릿을 적용하는 중에 Talented 창이 닫혔습니다. 나중에 다시 적용하십시오."
L["Talent application has been cancelled. %d talent points remaining."] = "특성 적용이 취소되었습니다. 특성 포인트가 %d 남았습니다."
L["Template applied successfully, %d talent points remaining."] = "템플릿 적용 성공, 특성 포인트가 %d 남았습니다."
--~ L["Talented_Data is outdated. It was created for %q, but current build is %q. Please update."] = "구버전의 Talented_Data 입니다. %q용으로 만들어진 것 입니다. 현재 빌드는 %q 입니다. 업데이트 하시기 바랍니다."
--~ L["Loading outdated data. |cffff1010WARNING:|r Recent changes in talent trees might not be included in this data."] = "구버전 데이타 로딩... |cffff1010경고:|r 이 특성 데이타에는 최근 변경 사항이 포함되어 있지 않을 수 있습니다."
L["\"%s\" does not appear to be a valid URL!"] = "\"%s\"는 유효한 URL이 아닙니다!"

L["Import template ..."] = "템플릿 가져오기 ..."
L["Enter the complete URL of a template from Blizzard talent calculator or wowhead."] = "블리자드 또는 wowhead 특성 계산기에 의한 템플릿 URL을 입력하십시오."

L["Export template"] = "템플릿 내보내기"
L["Blizzard Talent Calculator"] = "블리자드 특성 계산기"
L["Wowhead Talent Calculator"] = "Wowhead 특성 계산기"
L["Wowdb Talent Calculator"] = "Wowdb 특성 계산기"
L["MMO Champion Talent Calculator"] = "MMO Champion 특성 계산기"
--~ L["http://www.worldofwarcraft.com/info/classes/%s/talents.html?tal=%s"] = "http://www.worldofwarcraft.co.kr/info/basics/classes/%s/talents.html?%s"
L["http://www.wowarmory.com/talent-calc.xml?%s=%s&tal=%s"] = "http://kr.wowarmory.com/talent-calc.xml?%s=%s&tal=%s"
L["http://www.wowhead.com/talent#%s"] = "http://www.wowhead.com/talent#%s"
L["http://www.wowhead.com/petcalc#%s"] = "http://www.wowhead.com/petcalc#%s"
L["Send to ..."] = "... 에게 보내기"
L["Enter the name of the character you want to send the template to."] = "템플릿을 보내고자 하는 캐릭터의 이름을 입력하십시오."
L["Do you want to add the template \"%s\" that %s sent you ?"] = "\"%s\" 이름으로 %s님이 보낸 템플릿을 추가하시겠습니까?"

--~ L["Pet"] = "소환수"
L["Options ..."] = "설정 ..."

L["URL:"] = "URL:"
L["Talented has detected an incompatible change in the talent information that requires an update to Talented. Talented will now Disable itself and reload the user interface so that you can use the default interface."] = "Talented는 특성 정보가 호환되지 않고 변경되었음을 감지하여 Talented의 업데이트를 요구합니다. Talented는 스스로 사용을 중지시키고 기본 인터페이스를 사용할 수 있는 사용자 인터페이스로 다시 불러들입니다."
L["WARNING: Talented has detected that its talent data is outdated. Talented will work fine for your class for this session but may have issue with other classes. You should update Talented if you can."] = "경고 : 오래된 특성 데이터를 Talented에서 발견했습니다. Talented가 일부 당신의 직업에 대해서는 잘 작동하지만, 다른 직업은 문제가 있을 수 있습니다. 가능하면 당신은 Talented를 업데이트 해야합니다."
L["View glyphs of alternate Spec"] = "대체 특성의 문양 보기"
L[" (alt)"] = " (alt)"
L["The following templates are no longer valid and have been removed:"] = "다음의 템플릿은 더 이상 유효하지 않으므로 삭제됨:"
L["The template '%s' is no longer valid and has been removed."] = "'%s' 템플릿은 더 이상 유효하지 않아 삭제되었습니다."
L["The template '%s' had inconsistencies and has been fixed. Please check it before applying."] = "'%s' 템플릿에 잘못된 부분이 있어 수정되었습니다. 적용하기 전 반드시 확인하십시오."

L["Lock frame"] = "창 고정"
L["Can not apply, unknown template \"%s\""] = "적용할 수 없음, 알 수 없는 템플릿 \"%s\""

L["Glyph frame policy on spec swap"] = "특성 변경에 따른 문양 창 방식"
L["Select the way the glyph frame handle spec swaps."] = "특성 변경 시 문양 창을 다룰 방법을 선택하세요."
L["Keep the shown spec"] = "보여진 특성으로 유지"
L["Swap the shown spec"] = "보여진 특성으로 변경"
L["Always show the active spec after a change"] = "변경 후 활성화된 특성으로 항상 보기"

L["General options"] = "일반 설정"
L["Glyph frame options"] = "문양 창 설정"
L["Display options"] = "화면 설정"
L["Add bottom offset"] = "하단 공간 추가"
L["Add some space below the talents to show the bottom information."] = "특성 정보를 하단에 표시하기 위해 아래쪽에 일정 공간을 추가합니다."

L["Right-click to activate this spec"] = "오른쪽 클릭으로 이 특성 활성화"

--~ L["Mode of operation."] = true

--~ L["Toggle editing of the template."] = true
--~ L["Apply the current template to your character."] = true
--~ L["Are you sure that you want to apply the current template's talents?"] = true
--~ L["Delete the current template."] = true
--~ L["Are you sure that you want to delete this template?"] = true
--~ L["Import a template from Blizzard's talent calculator."] = true
--~ L["<full url of the template>"] = true
--~ L["Export this template to your current chat channel."] = true
--~ L["Write template link"] = true
--~ L["Write a link to the current template in chat."] = true
--~ L["New empty template"] = true
--~ L["Create a new template from scratch."] = true
--~ L["Copy current talent spec"] = true
--~ L["Create a new template from your current spec."] = true
--~ L["Copy from %s"] = true
--~ L["Create a new template from %s."] = true
--~ L["Talented - Template \"%s\" - %s :"] = true
--~ L["%s :"] = true
--~ L["_ %s"] = true
--~ L["_ %s (%d/%d)"] = true
--~ L["Options of Talented"] = true
--~ L["Options for Talented."] = true
--~ L["CHAT_COMMANDS"] = { "/talented" }
--~ L["Back to normal mode"] = true
--~ L["Return to the normal talents mode."] = true
--~ L["Switch to template mode"] = true
--~ L["Export the template."] = true
--~ L["Export to chat"] = true
--~ L["Export as URL"] = true
--~ L["Send the template to another Talented user."] = true
--~ L["<name>"] = true
--~ L["Export the template as a URL."] = true
--~ L["Export the template as a URL to the official talent calculator"] = true
--~ L["Export the template as a URL to the wowhead talent calculator."] = true
--~ L["Export the template as a URL to the wowdb talent calculator."] = true
--~ L["Default to edit"] = true
--~ L["Always show templates and talent in edit mode by default."] = true
--~ L["Set this template as the target template, so that you may use it as a guide in normal mode."] = true
--~ L["Talented Links options."] = true
--~ L["Color Template"] = true
--~ L["Toggle the Template color on and off."] = true
--~ L["Set Color"] = true
--~ L["Change the color of the Template."] = true
--~ L["Query Talent Spec"] = true
--~ L["From Rock"] = true
--~ L["Received talent information from LibRock."] = true
--~ L["Query"] = "Query user"
--~ L["Request a player's talent spec."] = true
--~ L["Query group"] = true
--~ L["Request talent information for your whole group (party or raid)."] = true
--~ L["Clone selected"] = true
--~ L["Make a copy of the current template."] = true
