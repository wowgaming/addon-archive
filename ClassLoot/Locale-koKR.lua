local L = LibStub("AceLocale-3.0"):NewLocale("ClassLoot", "koKR", false)

if L then
	-- Slash Commands
	L["Check an item (Local)"] = "아이템 확인 (자신에게만 출력)"
	L["Check an item (Guild)"] = "아이템 확인 (길드)"
	L["Check an item (Raid)"] = "아이템 확인 (공격대)"
	L["Display ClassLoot for an item locally"] = "아이템에 대한 ClassLoot을 자신에게만 출력"
	L["Display ClassLoot for an item in guild chat"] = "아이템에 대한 ClassLoot을 길드 대화로 출력"
	L["Display ClassLoot for an item in raid chat"] = "아이템에 대한 ClassLoot을 공격대 대화로 출력"
	L["<item link>"] = "<아이템 링크>"
	
	-- Info Messages
	L["Version"] = "버전"
	L["Last updated"] = "마지막 업데이트"
	
	-- Error Messages
	L["could not be found"] = "찾을 수 없습니다."
	L["Not in a guild!"] = "길드에 속해 있지 않습니다!"
	L["Not in a raid!"] = "공격대에 속해 있지 않습니다!"
	
	-- Output Messages
	L["ClassLoot info for"] = "ClassLoot 정보 -"
	L["Dropped in"] = "획득처 :"
	L["by"] = "-"
	
	-- Tooltip Stuff
	L["Boss"] = "보스"
	L["Instance"] = "인던"
	
	-- Interface Options
	L["Enable ClassLoot Tooltips"] = "ClassLoot 툴팁 활성화"
	L["Display Boss Name"] = "보스 이름 표시"
	L["Display Instance Name"] = "인던 이름 표시"
	
	-- Misc Translations
	L["Tank"] = "탱커"
	L["DPS"] = "딜러"
	L["Trash Mobs"] = "일반몹"
	L["World Bosses"] = "월드 보스"
	--L["Timed Event"] = true
end
