--[[

Skillet: A tradeskill window replacement.
Copyright (c) 2007 Robert Clark <nogudnik@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

]]--

-- If you are doing localization and would like your name added here, please feel free
-- to do so, or let me know and I will be happy to add you to the credits
-- Korean translation by Next96 :)

local L = AceLibrary("AceLocale-2.2"):new("Skillet")

L:RegisterTranslations("koKR", function() return {
	["Skillet Trade Skills"]					= "Skillet 전문기술", -- default message
	["Create"]							= "제작",
	["Queue All"]							= "전부 예약",
	["Create All"]							= "전부 제작",
	["Create"]							= "제작",
	["Queue"]							= "예약",
	["Enchant"]							= "마법부여",
	["Rescan"]							= "재조사",
	["Number of items to queue/create"]				= "에약/제작 가능한 갯수",
	["buyable"]							= "구매가능",
	["reagents in inventory"]					= "가방에 있는 재료로 제작",
	["bank"]							= "은행", -- "reagents in bank"
	["alts"]							= "다른 캐릭터", -- "reagents on alts"
	["can be created from reagents in your inventory"]		= "가방에 있는 재료로 제작할 수 있음",
	["can be created from reagents in your inventory and bank"]	= "가방과 은행에 있는 재료료 제작할 수 있음",
	["can be created from reagents on all characters"]		= "모든 캐릭터에 있는 재료로 제작할 수 있음",
	["Scanning tradeskill"]						= "전문기술 조사",
	["Scan completed"]						= "조사가 완료되었습니다.",
	["Filter"]							= "필터링",
	["Hide uncraftable"]						= "제작할 수 없는 아이템 숨기기",
	["Hide trivial"]						= "회색 제작템 숨기기",
	["Options"]							= "설정",
	["Notes"]							= "메모",
	["Purchased"]							= "구매",
	["Total spent"]							= "총 소비",
	["This merchant sells reagents you need!"]			= "이 상인은 제작에 필요한 재료를 판매하고 있습니다.",
	["Buy Reagents"]						= "재료 구매",
	["click here to add a note"]					= "클릭하면 메모를 남길 수 있습니다.",
	["not yet cached"]						= "캐쉬가 없습니다.",

	-- Options
	["About"]					= "정보",
	["ABOUTDESC"]					= "Skillet 정보 표시",
	["Config"]					= "설정",
	["CONFIGDESC"]					= "Skillet 설정을 엽니다.",
	["Shopping List"]				= "쇼핑 리스트",
	["SHOPPINGLISTDESC"]				= "쇼핑 리스트를 표시합니다.",

	["Features"]					= "기능",
	["FEATURESDESC"]				= "Skillet 기능 설정",
	["VENDORBUYBUTTONNAME"]				= "상인에게 구매 버튼 표시",
	["VENDORBUYBUTTONDESC"]				= "재료가 부족할 때 상인을 만나면 구매할 수 있는 버튼을 표시합니다.",
	["VENDORAUTOBUYNAME"]				= "재료 자동 구매",
	["VENDORAUTOBUYDESC"]				= "재료가 부족할 경우 상인을 만나면 자동으로 필요한 만큼의 재료를 구매합니다.",
	["SHOWITEMNOTESTOOLTIPNAME"]			= "사용자 툴팁 추가",
	["SHOWITEMNOTESTOOLTIPDESC"]			= "재료나 제작템에 사용자의 툴팁을 적을 수 있습니다.",
	["SHOWDETAILEDRECIPETOOLTIPNAME"]		= "제조법의 상세 툴팁 표시",
	["SHOWDETAILEDRECIPETOOLTIPDESC"]		= "전문기술 창에 마우스를 가져다 대면 상세 풀팁을 표시합니다.",
	["LINKCRAFTABLEREAGENTSNAME"]			= " 다른 재료 클릭으로 제작",
	["LINKCRAFTABLEREAGENTSDESC"]			= "현재 제조법에 필요한 다른 재료를 클릭하면 자동으로 제작합니다.",
	["QUEUECRAFTABLEREAGENTSNAME"]			= "다른 재료 예약 제작",
	["QUEUECRAFTABLEREAGENTSDESC"]			= "현재 제조법에 필요한 다른 재료를 클릭 예약하여 자동으로 제작합니다.",
	["DISPLAYSHOPPINGLISTATBANKNAME"]		= "은행창에 쇼핑리스트 표시",
	["DISPLAYSHOPPINGLISTATBANKDESC"]		= "은챙창에 제작에 필요한 재료를 쇼핑리스트에 표시합니다.",
	["DISPLAYSGOPPINGLISTATAUCTIONNAME"]		= "경매창에 쇼핑리스트 표시",
	["DISPLAYSGOPPINGLISTATAUCTIONDESC"]		= "경매창에 제작에 필요한 재료를 쇼핑리스트를 표시합니다.",

	["Appearance"]					= "보기",
	["APPEARANCEDESC"]				= "Skillet 보기 설정",
	["DISPLAYREQUIREDLEVELNAME"]			= "요구 레벨 표시",
	["DISPLAYREQUIREDLEVELDESC"]			= "제작템의 최소 요구 레벨을 표시합니다. (제조법의 앞에 표시)",
	["Transparency"]				= "투명도",
	["TRANSPARAENCYDESC"]				= "전문기술 창의 투명도를 조정합니다.",

	-- New in version 1.6
	["Shopping List"]						= "쇼핑 리스트",
	["Retrieve"]							= "회수",
	["Include alts"]						= "다른캐릭터 포함",

	-- New in vesrsion 1.9
	["Start"]							= "시작",
	["Pause"]							= "중지",
	["Clear"]							= "초기화",
	["None"]							= "없음",
	["By Name"]							= "이름",
	["By Difficulty"]						= "숙련도",
	["By Level"]							= "레벨",
	["Scale"]							= "크기",
	["SCALEDESC"]							= "전문기술 창의 크기를 설정합니다.(기본값:1.0)",
	["Could not find bag space for"]				= "가방에 빈공간이 없습니다.",
	["SORTASC"]							= "높은 숙련도",
	["SORTDESC"]							= "낮은 숙련도",
	["By Quality"]							= "품질",

	-- New in version 1.10
	["Inventory"]							= "인벤토리",
	["INVENTORYDESC"]						= "인벤토리 정보",
	["Supported Addons"]						= "지원가능 애드온",
	["Selected Addon"]						= "선택한 애드온",
	["Library"]							= "라이브러리",
	["SUPPORTEDADDONSDESC"]						= "지원되는 애드온에서 아이템의 갯수를 표시합니다.",
	["SHOWBANKALTCOUNTSNAME"]					= "다른 캐릭터의 은행아이템도 포함",
	["SHOWBANKALTCOUNTSDESC"]					= "제작 아이템 수량을 계산하여 보여줄 때, 다른 캐릭터의 은행에 소지하고 있는 아이템도 포함하여 표시합니다.",
	["ENHANCHEDRECIPEDISPLAYNAME"]					= "글자로 숙련도 표시",
	["ENHANCHEDRECIPEDISPLAYDESC"]					= "가능하면 제조법 이름에 제조법의 숙련도도 표시됩니다.",
	["SHOWCRAFTCOUNTSNAME"]						= "제작 수량 보기",
	["SHOWCRAFTCOUNTSDESC"]						= "제작 가능한 수량을 표시합니다. 총 가능한 수량은 아닙니다.",
		
	 -- New in version 1.11
    ["Crafted By"]                  = "제작자",
	
	-- New in version 1.10-LS
	["craftable"]					= "제작가능",
	["No Data"]						= "데이터 없음",
	
	["DISPLAYSHOPPINGLISTATGUILDBANKNAME"]			= "길드은행에서 쇼핑리스트를 표시합니다.",
    ["DISPLAYSHOPPINGLISTATGUILDBANKDESC"]			= "가방에는 없지만 제조법을 보고 제작할 때 필요한 아이템을 쇼핑리스트에 표시합니다.",

	["By Item Level"]                    = "아이템레벨",
	["By Skill Level"]                    = "숙련도",
	
	["Blizzard"]					= "블리자드",			-- as in, the company name
	["Process"]						= "진행",
} end)