if not ACP then return end

if (GetLocale() == "koKR") then
ACP:UpdateLocale( {
   ["Reload your User Interface?"] = "당신의 사용자 인터페이스를 재시작 하시겠습니까?",
   ["Save the current addon list to [%s]?"] = "현재 애드온 목록을 [%s]로 저장 하시겠습니까?",
   ["Enter the new name for [%s]:"] = "[%s]의 새로운 이름 입력:",
   ["Addons [%s] Saved."] = "애드온 [%s]를 저장합니다.",
   ["Addons [%s] Unloaded."] = "애드온 [%s]를 삭제합니다.",
   ["Addons [%s] Loaded."] = "애드온 [%s]를 불려옵니다.",
   ["Addons [%s] renamed to [%s]."] = "애드온 [%s]를 [%s]로 이름을 변경합니다.",
   ["Loaded on demand."] = "사용시 자동 실행",
   ["AddOns"] = "애드온",
   ["Load"] = "실행",
   ["Disable All"] = "모두 미사용",
   ["Enable All"] = "모두 사용",
   ["ReloadUI"] = "재시작",
   ["Sets"] = "세트",
   ["No information available."] = "알려진 정보가 없습니다.",
   ["Loaded"] = "실행됨",
	["Recursive"] = "반복",
	["Loadable OnDemand"] = "불러올때 실행",
	["Disabled on reloadUI"] = "ReloadUI 해야 사용안함",
	["Default"] = "기본값";
	["Set "] = "세트 ";
	["Save"] = "저장하기";
	["Load"] = "불러오기";
	["Add to current selection"] = "현재 선택 추가";
	["Remove from current selection"] = "현재 선택 삭제";
	["Rename"] = "이름바꾸기";
	["Use SHIFT to override the current enabling of dependancies behaviour."] = "SHIFT키를 사용하여 실행하는데 우선권을 가집니다.",
    ["Click to enable protect mode. Protected addons will not be disabled"] = "클릭하면 보호모드가 실행됩니다. 보호된 애드온은 사용하지 않도록 합니다.",
    ["when performing a reloadui."]="ReloadUI를 했을 때",
    ["ACP: Some protected addons aren't loaded. Reload now?"]="ACP: 몇몇 보호된 애드온은 실행하지 않습니다. 리로드 하시겠습니까?",
	["Active Embeds"] = "임베드 활성화",
	["Memory Usage"] = "메모리 사용량",
   
		["Blizzard_AchievementUI"] = "Blizzard: 업적",
   ["Blizzard_AuctionUI"] = "Blizzard: 경매장",
		["Blizzard_BarbershopUI"] = "Blizzard: 이발소",
   ["Blizzard_BattlefieldMinimap"] = "Blizzard: 전장 미니맵",
   ["Blizzard_BindingUI"] = "Blizzard: 단축키",
		["Blizzard_Calendar"] = "Blizzard: 달력",
		["Blizzard_CombatLog"] = "Blizzard: 전투로그",
   ["Blizzard_CombatText"] = "Blizzard: 전투메시지",
		["Blizzard_FeedbackUI"] = "Blizzard: 피드백",
		["Blizzard_GlyphUI"] = "Blizzard: 문양",
   ["Blizzard_GMSurveyUI"] = "Blizzard: GM 요청",
		["Blizzard_GuildBankUI"] = "Blizzard: 길드창고",
   ["Blizzard_InspectUI"] = "Blizzard: 살펴보기",
   ["Blizzard_ItemSocketingUI"] = "Blizzard: 보석세공",
   ["Blizzard_MacroUI"] = "Blizzard: 매크로",
   ["Blizzard_RaidUI"] = "Blizzard: 공격대",
   ["Blizzard_TalentUI"] = "Blizzard: 특성",
		["Blizzard_TimeManager"] = "Blizzard: 시계",
		["Blizzard_TokenUI"] = "Blizzard: 토큰",
   ["Blizzard_TradeSkillUI"] = "Blizzard: 전문기술",
   ["Blizzard_TrainerUI"] = "Blizzard: 기술숙련",
		["Blizzard_VehicleUI"] = "Blizzard: 탈 것",
	
	["*** Enabling <%s> %s your UI ***"] = "*** 애드온 <%s> %s 사용 ***";
	["*** Unknown Addon <%s> Required ***"] = "*** 알 수 없는 <%s> 애드온 요구 ***";
	["LoD Child Enable is now %s"] = "LoD Child Enable is now %s";
	["Recursive Enable is now %s"] = "Recursive Enable is now %s";
	["Addon <%s> not valid"] = "<%s> 애드온이 정확하지 않습니다.",
	["Reload"] = "재실행";
	["Author"] = "제작자";
	["Version"] = "버전";
	["Status"] = "상태";
	["Dependencies"] = "요구사항";
	["Embeds"] = "임베드";
} )
end