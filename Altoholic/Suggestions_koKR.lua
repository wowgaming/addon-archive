local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BF = LibStub("LibBabble-Faction-3.0"):GetLookupTable()

if GetLocale() ~= "koKR" then return end

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

-- This table contains a list of suggestions to get to the next level of reputation, craft or skill
addon.Suggestions = {
	[L["Riding"]] = {
		{ 75, "수습 탈것 타기 기술 (30 레벨): |cFFFFFFFF35골\n|cFFFFD700수도 도시 안이나 근처에 있는 기본 탈것: |cFFFFFFFF10골" },
		{ 150, "중급 탈것 타기 기술 (60 레벨): |cFFFFFFFF600골\n|cFFFFD700수도 도시 안이나 근처에 있는 에픽 탈것: |cFFFFFFFF100골" },
		{ 225, "숙련 탈것 타기 기술 (70 레벨): |cFFFFFFFF800골\n|cFFFFD700어둠달 골짜기에 있는 나는 탈것: |cFFFFFFFF100골" },
		{ 300, "Artisan riding skill (70 레벨): |cFFFFFFFF5000골\n|cFFFFD700어둠달 골짜기에 있는 에픽 나는 탈것: |cFFFFFFFF200골" }
	},
	
	-- source : http://forums.worldofwarcraft.com/thread.html?topicId=102789457&sid=1
	-- ** Primary professions **
	[BI["Tailoring"]] = {
		{ 50, "50 까지: 리넨 두루마리" },
		{ 70, "70 까지: 리넨 가방" },
		{ 75, "75 까지: 질긴 리넨 단망토" },
		{ 105, "105 까지: 양모 두루마리" },
		{ 110, "110 까지: 회색 양모 셔츠"},
		{ 125, "125 까지: 이중 양모 어깨보호구" },
		{ 145, "145 까지: 비단 두루마리" },
		{ 160, "160 까지: 감청색 비단 두건" },
		{ 170, "170 까지: 비단 머리띠" },
		{ 175, "175 까지: 흰색 정장 셔츠" },
		{ 185, "185 까지: 마법 두루마리" },
		{ 205, "205 까지: 심홍색 비단 조끼" },
		{ 215, "215 까지: 심홍색 비단 바지" },
		{ 220, "220 까지: 검은 마법매듭 다리보호구\n또는 검은 마법매듭 조끼" },
		{ 230, "230 까지: 검은 마법매듭 장갑" },
		{ 250, "250 까지: 검은 마법매듭 머리띠\n또는 검은 마법매듭 어깨보호구" },
		{ 260, "260 까지: 룬무늬 두루마리" },
		{ 275, "275 까지: 룬무늬 허리띠" },
		{ 280, "280 까지: 룬매듭 가방" },
		{ 300, "300 까지: 룬매듭 장갑" },
		{ 325, "325 까지: 황천매듭 두루마리\n|cFFFFD700팔지 말 것, 향후 사용" },
		{ 340, "340 까지: 마력 깃든 황천매듭 두루마리\n|cFFFFD700팔지 말 것, 향후 사용" },
		{ 350, "350 까지: 황천매듭 장화\n|cFFFFD700마력 추출해서 신비한 수정 가루" },
		{ 375, "375 까지: 서리매듭 두루마리" },
		{ 380, "380 까지: 서리장식 장화" },
		{ 395, "395 까지: 서리장식 두건" },
		{ 405, "405 까지: 그늘매듭 두건" },
		{ 410, "410 까지: 그늘매듭 손목보호구" },
		{ 415, "415 까지: 그늘매듭 장갑" },
		{ 425, "425 까지: 황천매듭, 마력 깃든 황천매듭, 태초의 달빛매듭,\n서리매듭 가방" },
		{ 450, "450 까지: 필요한 것 위주로\n점수 얻을 수 있는 모든 것" }
	},
	[BI["Leatherworking"]] = {
		{ 35, "35 까지: 작은 방어구 키트" },
		{ 55, "55 까지: 얇은 경화 가죽" },
		{ 85, "85 까지: 새김무늬 가죽 장갑" },
		{ 100, "100 까지: 고급 가죽 허리띠" },
		{ 120, "120 까지: 일반 경화 가죽" },
		{ 125, "125 까지: 고급 가죽 허리띠" },
		{ 150, "150 까지: 암색 가죽 허리띠" },
		{ 160, "160 까지: 질긴 경화 가죽" },
		{ 170, "170 까지: 고급 방어구 키트" },
		{ 180, "180 까지: 거무스름한 가죽 다리보호구\n또는 수호 바지" },
		{ 195, "195 까지: 야만전사의 어깨보호구" },
		{ 205, "205 까지: 거무스름한 팔보호구" },
		{ 220, "220 까지: 두꺼운 방어구 키트" },
		{ 225, "225 까지: 밤하늘 머리띠" },
		{ 250, "250 까지: 선택한 전문화에 따라\n(원소)밤하늘 머리띠/튜닉/바지\n(용비늘)단단한 전갈 흉갑/장갑\n(전통)거북 껍질 세트" },
		{ 260, "260 까지: 밤하늘 장화" },
		{ 270, "270 까지: 악의의 가죽 건틀릿" },
		{ 285, "285 까지: 악의의 가죽 팔보호구" },
		{ 300, "300 까지: 악의의 가죽 머리띠" },
		{ 310, "310 까지: 톱니매듭 가죽" },
		{ 320, "320 까지: 야생의 드레나이 장갑" },
		{ 325, "325 까지: 두꺼운 드레나이 장화" },
		{ 335, "335 까지: 질긴톱니매듭가죽\n|cFFFFD700팔지 말 것, 향후 사용" },
		{ 340, "340 까지: 두꺼운 드레나이 조끼" },
		{ 350, "350 까지: 지옥껍질 흉갑" },
		{ 375, "375 까지: 북풍 방어구 키트" },
		{ 385, "385 까지: 북극의 장화" },
		{ 395, "395 까지: 북극의 허리띠" },
		{ 400, "400 까지: 북극의 손목보호구" },
		{ 405, "405 까지: 네루비안 다리 방어구 키트" },
		{ 410, "410 까지: 어두운 여러가지 흉갑 또는 다리보호구들" },
		{ 425, "425 까지: 여러가지 모피 안감\n전문기술 가방들" },
		{ 450, "450 까지: 필요한 것 위주로\n점수 얻을 수 있는 모든 것" }
	},
	[BI["Engineering"]] = {
		{ 40, "40 까지: 천연 화약" },
		{ 50, "50 까지: 구리 나사 한 줌" },
		{ 51, "만능 스패너 하나 제작" },
		{ 65, "65 까지: 구리관" },
		{ 75, "75 까지: 조잡한 붐스틱" },
		{ 95, "95 까지: 굵은 화약" },
		{ 105, "105 까지: 은 접지" },
		{ 120, "120 까지: 청동관" },
		{ 125, "125 까지: 소형 청동 폭탄" },
		{ 145, "145 까지: 강한 화약" },
		{ 150, "150 까지: 대형 청동 폭탄" },
		{ 175, "175 까지: 푸른, 녹색, 또는 붉은 폭죽" },
		{ 176, "자동회전 초정밀조율기 하나 제작" },
		{ 190, "190 까지: 조밀한 화약" },
		{ 195, "195 까지: 대형 철제 폭탄" },
		{ 205, "205 까지: 미스릴관" },
		{ 210, "210 까지: 유동성 제동장치" },
		{ 225, "225 까지: 고강도 미스릴 산탄" },
		{ 235, "235 까지: 미스릴 형틀" },
		{ 245, "245 까지: 고폭탄" },
		{ 250, "250 까지: 미스릴 회전탄" },
		{ 260, "260 까지: 강도 높은 화약" },
		{ 290, "290 까지: 토륨 부품" },
		{ 300, "300 까지: 토륨관\n또는 토륨 탄환 (더 저렴)" },
		{ 310, "310 까지: 지옥무쇠 형틀,\n지옥무쇠 나사 한 줌,\n 그리고 원소 화약\n향후 제작을 위해 모두 보관" },
		{ 320, "320 까지: 지옥무쇠 폭탄" },
		{ 335, "335 까지: 지옥무쇠 머스킷총" },
		{ 350, "350 까지: 백색 조명탄" },
		{ 375, "375 까지: 코발트 파편 폭탄" },
		{ 430, "430 까지: 마나, 치유 주사 도구\n오랫동안 필요하게 될 것임" },
		{ 435, "435 까지: 마나 주사 도구" },
		{ 450, "450 까지: 필요한 것 위주로,\n점수 얻을 수 있는 모든 것" }
	},
	[BI["Jewelcrafting"]] = {
		{ 20, "20 까지: 가느다른 구리 철사" },
		{ 30, "30 까지: 조잡한 돌 조각상" },
		{ 50, "50 까지: 호안석 고리" },
		{ 75, "75 까지: 청동 장식" },
		{ 80, "80 까지: 순 청동 반지" },
		{ 90, "90 까지: 세련된 은 반지" },
		{ 110, "110 까지: 힘의 은 반지" },
		{ 120, "120 까지: 단단한 돌 조각상" },
		{ 150, "150 까지: 보호의 태마노 팬던트\n또는 황금 용 반지" },
		{ 180, "180 까지: 미스릴 장식" },
		{ 200, "200 까지: 글자가 새겨진 진은 반지" },
		{ 210, "210 까지: 신속한 치유의 황수정 반지" },
		{ 225, "225 까지: 남옥 인장 반지" },
		{ 250, "250 까지: 토륨 장식" },
		{ 255, "255 까지: 파괴의 붉은 반지" },
		{ 265, "265 까지: 치유의 진은 반지" },
		{ 275, "275 까지: 간결한 오팔 반지" },
		{ 285, "285 까지: 사파이어 인장 반지" },
		{ 290, "290 까지: 다이아몬드 정신집중 반지" },
		{ 300, "300 까지: 에메랄드 사자 반지" },
		{ 310, "310 까지: 각종 녹색 등급 보석" },
		{ 315, "315 까지: 피의 지옥무쇠 반지\n또는 각종 녹색 등급 보석" },
		{ 320, "320 까지: 각종 녹색 등급 보석" },
		{ 325, "325 까지: 하늘월장석 반지" },
		{ 335, "335 까지: 수은 아다만타이트 (향후 필요)\n또는 각종 녹색 등급 보석" },
		{ 350, "350 까지: 무거운 아다만타이트 반지" },
		{ 355, "355 까지: 각종 파란색 등급 보석" },
		{ 360, "360 까지: 각종 월드 드랍 제조법, 예:\n생명의 루비 펜던트\n또는 두꺼운 지옥강철 목걸이" },
		{ 365, "365 까지: 비전 보호의 반지\n샤타르 평판 - 우호적" },
		{ 375, "375 까지: 다이아몬드들 변환\n월드 드랍 (파란색 등급)\n샤타르 - 매우 우호, 스랄마 - 우호적" },
		{ 400, "400 까지: 각종 녹색 등급 보석" },
		{ 420, "420 까지: 암흑력의 반지" },
	},
	[BI["Enchanting"]] = {
		{ 2, "2 까지: 룬문자 구리마법막대" },
		{ 75, "75 까지: 손목보호구 마법부여 - 최하급 생명력" },
		{ 85, "85 까지: 손목보호구 마법부여 - 최하급 회피" },
		{ 100, "100 까지: 손목보호구 마법부여 - 최하급 체력" },
		{ 101, "룬문자 은마법막대 하나 제작" },
		{ 105, "105 까지: 손목보호구 마법부여 - 최하급 체력" },
		{ 120, "120 까지: 상급 마술봉" },
		{ 130, "130 까지: 방패 마법부여 - 최하급 체력" },
		{ 150, "150 까지: 손목보호구 마법부여 - 하급 체력" },
		{ 151, "룬문자 금마법막대 하나 제작" },
		{ 160, "160 까지: 손목보호구 마법부여 - 하급 체력" },
		{ 165, "165 까지: 방패 마법부여 - 하급 체력" },
		{ 180, "180 까지: 손목보호구 마법부여 - 정신력" },
		{ 200, "200 까지: 손목보호구 마법부여 - 힘" },
		{ 201, "룬문자 진은마법막대 하나 제작" },
		{ 205, "205 까지: 손목보호구 마법부여 - 힘" },
		{ 225, "225 까지: 망토 마법부여 - 상급 보호" },
		{ 235, "235 까지: 장갑 마법부여 - 민첩성" },
		{ 245, "245 까지: 가슴보호구 마법부여 - 최상급 생명력" },
		{ 250, "250 까지: 손목보호구 마법부여 - 상급 힘" },
		{ 270, "270 까지: 하급 마나 오일\n주문식은 실리더스에서 판매" },
		{ 290, "290 까지: 방패 마법부여 - 상급 체력\n또는 장화 마법부여 - 상급 체력" },
		{ 291, "룬문자 아케이나이트막대 하나 제작" },
		{ 300, "300 까지: 망토 마법부여 - 최상급 보호" },
		{ 301, "룬문자 지옥무쇠막대 하나 제작" },
		{ 305, "305 까지: 망토 마법부여 - 최상급 보호" },
		{ 315, "315 까지: 손목보호구 마법부여 - 맹공" },
		{ 325, "325 까지: 망토 마법부여 - 일급 방어도\nor 장갑 마법부여 - 맹공" },
		{ 335, "335 까지: 가슴보호구 마법부여 - 일급 정신력" },
		{ 340, "340 까지: 방패 마법부여 - 일급 체력" },
		{ 345, "345 까지: 최상급 마술사 오일\n재료가 있다면 350 까지" },
		{ 350, "350 까지: 장갑 마법부여 - 일급 힘" },
		{ 351, "룬문자 아다만다이트 막대 하나 제작" },
		{ 360, "360 까지: 장갑 마법부여 - 일급 힘" },
		{ 370, "370 까지: 장갑 마법부여 - 주문 적중\n세나리온 원정대 - 매우 우호적" },
		{ 375, "375 까지: 반지 마법부여 - 치유 마법 강화\n샤타르 - 매우 우호적" },
		{ 376, "룬문자 이터늄 마법막대 하나 제작" },
		{ 380, "380 까지: 가슴보호구 마법부여 - 최상급 능력치" },
		{ 390, "390 까지: 무기 마법부여 - 상급 근력" },
	},
	[BI["Blacksmithing"]] = {	
		{ 25, "25 까지: 조잡한 숫돌" },
		{ 45, "45 까지: 조잡한 연마석" },
		{ 75, "75 까지: 구리 사슬 허리띠" },
		{ 80, "80 까지: 일반 연마석" },
		{ 100, "100 까지: 구리 룬문자 허리띠" },
		{ 105, "105 까지: 은마법막대" },
		{ 125, "125 까지: 청동 다리보호구" },
		{ 150, "150 까지: 단단한 연마석" },
		{ 155, "155 까지: 금마법막대" },
		{ 165, "165 까지: 녹색 철제 다리보호구" },
		{ 185, "185 까지: 녹색 철제 팔보호구" },
		{ 200, "200 까지: 황금 미늘 팔보호구" },
		{ 210, "210 까지: 견고한 연마석" },
		{ 215, "215 까지: 황금 미늘 팔보호구" },
		{ 235, "235 까지: 강철 판금 투구\n또는 미스릴 미늘 팔보호구 (더 저렴)\n제조법은 맹금의 봉우리(얼) 또는 스토나드(호)" },
		{ 250, "250 까지: 미스릴 코이프\n또는 미스릴 박차 (더 저렴)" },
		{ 260, "260 까지: 강도 톺은 숫돌" },
		{ 270, "270 까지: 토륨 허리띠 또는 팔보호구 (더 저렴)\n대지로 벼려낸 다리보호구(갑옷전문)\n대지로 벼려낸 검(검전문)\n불꽃으로 벼려낸 망치(둔기전문)\n하늘로 벼려낸 도끼(도끼전문)" },
		{ 295, "295 까지: 황제의 판금 팔보호구" },
		{ 300, "300 까지: 황제의 판금 장화" },
		{ 305, "305 까지: 지옥의 숫돌" },
		{ 320, "320 까지: 지옥무쇠 허리띠" },
		{ 325, "325 까지: 지옥무쇠 장화" },
		{ 330, "330 까지: 하급 수호의 룬" },
		{ 335, "335 까지: 지옥무쇠 흉갑" },
		{ 340, "340 까지: 아다만타이트 클레버\n샤트라, 실버문, 엑소다르에서 판매" },
		{ 345, "345 까지: 하급 수호의 보호막\n와일드해머 성채와 스랄마에서 판매" },
		{ 350, "350 까지: 아다만타이트 클레버" },
		{ 360, "360 까지: 아다만타이트 무게추\n세나리온 원정대 - 우호적 필요" },
		{ 370, "370 까지: 지옥강철 장갑 (아키나이 납골당)\n화염파멸 장갑 (알도르 사제회 - 우호적 필요)\n마력 깃든 아다만타이트 허리띠 (점술가 길드 - 약간 우호적)" },
		{ 375, "375 까지: 지옥강철 장갑 (아키나이 납골당)\n화염파멸 흉갑 (알도르 사제회 - 매우 우호 필요)\n마력 깃든 아다만타이트 허리띠 (점술가 길드 - 약간 우호적)" },
		{ 385, "385 까지: 코발트 건틀럿" },
		{ 393, "393 까지: 가시 박힌 코발트 어깨보호구\n또는 흉갑" },
		{ 395, "395 까지: 가시 박힌 코발트 건틀럿" },
		{ 400, "400 까지: 가시 박힌 코발트 허리띠" },
		{ 410, "410 까지: 가시 박힌 코발트 팔보호구" },
		{ 415, "415 까지: 달궈진 사로나이트 어깨보호구" },
		{ 420, "420 까지: 달궈진 사로나이트 팔보호구" },
		{ 430, "430 까지: 위압의 손보호대" },
		{ 445, "445 까지: 위압의 다리보호구" },
		{ 450, "450 까지: 각종 에픽" },
	},
	[BI["Alchemy"]] = {	
		{ 60, "60 까지: 최하급 치유 물약" },
		{ 110, "110 까지: 하급 치유 물약" },
		{ 140, "140 까지: 치유 물약" },
		{ 155, "155 까지: 하급 마나 물약" },
		{ 185, "185 까지: 상급 치유 물약" },
		{ 210, "210 까지: 민첩의 비약" },
		{ 215, "215 까지: 상급 방어의 비약" },
		{ 230, "230 까지: 최상급 치유 물약" },
		{ 250, "250 까지: 언데드 감지의 비약" },
		{ 265, "265 까지: 상급 민첩의 비약" },
		{ 285, "285 까지: 최상급 마나 물약" },
		{ 300, "300 까지: 일급 치유 물약" },
		{ 315, "315 까지: 신속 치유 물약\n또는 일급 마나 물약" },
		{ 350, "350 까지: Mad Alchemists's 물약\nTurns yellow at 335, but cheap to make" },
		{ 375, "375 까지: 일급 Dreamless Sleep 물약\nSold in Allerian Stronghold (A)\nor Thunderlord Stronghold (H)" }
	},
	[L["Mining"]] = {
		{ 65, "65 까지: 구리 채굴\n모든 시작 지역에서 가능" },
		{ 125, "125 까지: Mine Tin, Silver, Incendicite and 하급 Bloodstone\n\nMine Incendicite at Thelgen Rock (Wetlands)\nEasy leveling up to 125" },
		{ 175, "175 까지: Mine Iron and Gold\nDesolace, Ashenvale, Badlands, Arathi Highlands,\nAlterac Mountains, Stranglethorn Vale, Swamp of Sorrows" },
		{ 250, "250 까지: Mine Mithril and Truesilver\nBlasted Lands, Searing Gorge, Badlands, The Hinterlands,\nWestern Plaguelands, Azshara, Winterspring, Felwood, Stonetalon Mountains, Tanaris" },
		{ 300, "300 까지: Mine Thorium \nUn’goro Crater, Azshara, Winterspring, Blasted Lands\nSearing Gorge, Burning Steppes, Eastern Plaguelands, Western Plaguelands" },
		{ 330, "330 까지: Mine Fel Iron\nHellfire Peninsula, Zangarmarsh" },
		{ 375, "375 까지: Mine Fel Iron and Adamantite\nTerrokar Forest, Nagrand\nBasically everywhere in Outland" }
	},
	[L["Herbalism"]] = {
		{ 50, "50 까지: Collect Silverleaf and Peacebloom\nAvailable in all starting zones" },
		{ 70, "70 까지: Collect Mageroyal and Earthroot\nThe Barrens, Westfall, Silverpine Forest, Loch Modan" },
		{ 100, "100 까지: Collect Briarthorn\nSilverpine Forest, Duskwood, Darkshore,\nLoch Modan, Redridge Mountains" },
		{ 115, "115 까지: Collect Bruiseweed\nAshenvale, Stonetalon Mountains, Southern Barrens\nLoch Modan, Redridge Mountains" },
		{ 125, "125 까지: Collect Wild Steelbloom\nStonetalon Mountains, Arathi Highlands, Stranglethorn Vale\nSouthern Barrens, Thousand Needles" },
		{ 160, "160 까지: Collect Kingsblood\nAshenvale, Stonetalon Mountains, Wetlands,\nHillsbrad Foothills, Swamp of Sorrows" },
		{ 185, "185 까지: Collect Fadeleaf\nSwamp of Sorrows" },
		{ 205, "205 까지: Collect Khadgar's Whisker\nThe Hinterlands, Arathi Highlands, Swamp of Sorrows" },
		{ 230, "230 까지: Collect Firebloom\nSearing Gorge, Blasted Lands, Tanaris" },
		{ 250, "250 까지: Collect Sungrass\nFelwood, Feralas, Azshara\nThe Hinterlands" },
		{ 270, "270 까지: Collect Gromsblood\nFelwood, Blasted Lands,\nMannoroc Coven in Desolace" },
		{ 285, "285 까지: Collect Dreamfoil\nUn'goro Crater, Azshara" },
		{ 300, "300 까지: Collect Plagueblooms\nEastern & Western Plaguelands, Felwood\nor Icecaps in Winterspring" },
		{ 330, "330 까지: Collect Felweed\nHellfire Peninsula, Zangarmarsh" },
		{ 375, "375 까지: Any flower available in Outland\nFocus on Zangarmarsh & Terrokar Forest" }
	},
	[L["Skinning"]] = {
		{ 375, "375 까지: Divide your current skill level by 5,\nand skin mobs of that level" }
	},

	-- source: http://www.elsprofessions.com/inscription/leveling.html
	[L["Inscription"]] = {
		{ 18, "18 까지: Ivory Ink" },
		{ 35, "35 까지: Scroll of Intellect, 정신력 or 체력" },
		{ 50, "50 까지: Moonglow Ink\nSave if for 최하급 Inscription Research" },
		{ 75, "75 까지: Scroll of Recall, Armor Vellum" },
		{ 79, "79 까지: Midnight Ink" },
		{ 80, "80 까지: 최하급 Inscription Research" },
		{ 85, "85 까지: Glyph of Backstab, Frost Nova\nRejuvenation, ..." },
		{ 87, "87 까지: Hunter's Ink" },
		{ 90, "90 까지: Glyph of Corruption, Flame Shock\nRapid Charge, Wrath" },
		{ 100, "100 까지: Glyph of Ice Armor, Maul\nSerpent Sting" },
		{ 104, "104 까지: Lion's Ink" },
		{ 105, "105 까지: Glyph of Arcane Shot, Arcane Explosion" },
		{ 110, "110 까지: Glyph of Eviscerate, Holy Light, Fade" },
		{ 115, "115 까지: Glyph of Fire Nova Totem\n생명력 Funel, Rending" },
		{ 120, "120 까지: Glyph of Arcane Missiles, Healing Touch" },
		{ 125, "125 까지: Glyph of Expose Armor\nFlash Heal, Judgment" },
		{ 130, "130 까지: Dawnstar Ink" },
		{ 135, "135 까지: Glyph of Blink\nImmolation, Moonfire" },
		{ 140, "140 까지: Glyph of Lay on Hands\nGarrote, Inner Fire" },
		{ 142, "142 까지: Glyph of Sunder Armor\nImp, Lightning Bolt" },
		{ 150, "150 까지: Strange Tarot" },
		{ 155, "155 까지: Jadefire Ink" },
		{ 160, "160 까지: Scroll of 체력 III" },
		{ 165, "165 까지: Glyph of Gouge, Renew" },
		{ 170, "170 까지: Glyph of Shadow Bolt\nStrength of Earth Totem" },
		{ 175, "175 까지: Glyph of Overpower" },
		{ 177, "177 까지: Royal Ink" },
		{ 183, "183 까지: Scroll of 민첩성 III" },
		{ 185, "185 까지: Glyph of Cleansing\nShadow Word: Pain" },
		{ 190, "190 까지: Glyph of Insect Swarm\nFrost Shock, Sap" },
		{ 192, "192 까지: Glyph of Revenge\nVoidwalker" },
		{ 200, "200 까지: Arcane Tarot" },
		{ 204, "204 까지: Celestial Ink" },
		{ 210, "210 까지: Armor Vellum II" },
		{ 215, "215 까지: Glyph of Smite, Sinister Strike" },
		{ 220, "220 까지: Glyph of Searing Pain\nHealing Stream Totem" },
		{ 225, "225 까지: Glyph of Starfire\nBarbaric Insults" },
		{ 227, "227 까지: Fiery Ink" },
		{ 230, "230 까지: Scroll of 민첩성 IV" },
		{ 235, "235 까지: Glyph of Dispel Magic" },
		{ 250, "250 까지: Weapon Vellum II" },
		{ 255, "255 까지: Scroll of 체력 V" },
		{ 260, "260 까지: Scroll of 정신력 V" },
		{ 265, "265 까지: Glyph of Freezing Trap, Shred" },
		{ 270, "270 까지: Glyph of Exorcism, Bone Shield" },
		{ 275, "275 까지: Glyph of Fear Ward, Frost Strike" },
		{ 285, "285 까지: Ink of the Sky" },
		{ 295, "295 까지: Glyph of Execution\nSprint, Death Grip" },
		{ 300, "300 까지: Scroll of 정신력 VI" },
		{ 304, "304 까지: Ethereal Ink" },
		{ 305, "305 까지: Glyph of Plague Strike\nEarthliving Weapon, Flash of Light" },
		{ 310, "310 까지: Glyph of Feint" },
		{ 315, "315 까지: Glyph of Rake, Rune Tap" },
		{ 320, "320 까지: Glyph of Holy Nova, Rapid Fire" },
		{ 325, "325 까지: Glyph of Blood Strike, Sweeping Strikes" },
		{ 327, "327 까지: Darkflame Ink" },
		{ 330, "330 까지: Glyph of Mage Armor, Succubus" },
		{ 335, "335 까지: Glyph of Scourge Strike, Windfury Weapon" },
		{ 340, "340 까지: Glyph of Arcane Power, Seal of Command" },
		{ 345, "345 까지: Glyph of Ambush, Death Strike" },
		{ 350, "350 까지: Glyph of Whirlwind" },
		{ 360, "360 까지: Glyph of Mind Flay, Banish" },
		{ 365, "365 까지: Scroll of Intellect VII" },
		{ 370, "370 까지: Scroll of 힘 VII" },
		{ 375, "375 까지: Scroll of 민첩성 VII" },
		{ 380, "380 까지: Glyph of Focus, Strangulate" },
		{ 400, "400 까지: Northrend Inscription Research" },
		
		{ 450, "450 까지: Not yet implemented" }
	},

	-- source: http://www.almostgaming.com/wowguides/world-of-warcraft-lockpicking-guide
	[L["Lockpicking"]] = {
		{ 85, "85 까지: Thieves Training\nAtler Mill, Redridge Moutains (A)\nShip near Ratchet (H)" },
		{ 150, "150 까지: Chest near the boss of the poison quest\nWestfall (A) or The Barrens (H)" },
		{ 185, "185 까지: Murloc camps (Wetlands)" },
		{ 225, "225 까지: Sar'Theris Strand (Desolace)\n" },
		{ 250, "250 까지: Angor Fortress (Badlands)" },
		{ 275, "275 까지: Slag Pit (Searing Gorge)" },
		{ 300, "300 까지: Lost Rigger Cove (Tanaris)\nBay of Storms (Azshara)" },
		{ 325, "325 까지: Feralfen Village (Zangarmarsh)" },
		{ 350, "350 까지: Kil'sorrow Fortress (Nagrand)\nPickpocket the Boulderfists in Nagrand" }
	},
	
	-- ** Secondary professions **
	[BI["First Aid"]] = {
		{ 40, "40 까지: 리넨 붕대" },
		{ 80, "80 까지: 두꺼운 리넨 붕대\n50에 중급" },
		{ 115, "115 까지: 양모 붕대" },
		{ 150, "150 까지: 두꺼운 양모 붕대\n125에 숙련 응급치료 책\nBuy the 2 manuals in Stromguarde (A) or Brackenwall Village (H)" },
		{ 180, "180 까지: 비단 붕대" },
		{ 210, "210 까지: 두꺼운 비단 붕대" },
		{ 240, "240 까지: 마법 붕대\n레벨 35에 응급치료 퀘스트\n테라모어 섬 (얼) 또는 헤머폴 (호)" },
		{ 260, "260 까지: 두꺼운 마법 붕대" },
		{ 290, "290 까지: 룬매듭 붕대" },
		{ 330, "330 까지: 두꺼운 룬매듭 붕대\nBuy Master First Aid book\nTemple of Telhamat (A) or Falcon Watch (H)" },
		{ 360, "360 까지: 황천매듭 붕대\nBuy the book in the Temple of Telhamat (A) or in Falcon Watch (H)" },
		{ 375, "375 까지: 두꺼운 황천매듭 붕대\nBuy the book in the Temple of Telhamat (A) or in Falcon Watch (H)" }
	},
	[BI["Cooking"]] = {
		{ 40, "40 까지: 매콤한 빵"	},
		{ 85, "85 까지: 곰고기 숯불구이, 게살 케이크" },
		{ 100, "100 까지: 집게발 요리 (얼)\n들쥐 스튜 (호)" },
		{ 125, "125 까지: 들쥐 스튜 (호)\n양념 늑대 케밥 (얼)" },
		{ 175, "175 까지: 진기한 맛의 오믈렛 (얼)\n매운 사자 고기 (호)" },
		{ 200, "200 까지: 랩터 숯불구이" },
		{ 225, "225 까지: 거미 소시지\n\n|cFFFFFFFF요리 퀘스트:\n|cFFFFD70012 거대한 알,\n10 Zesty Clam Meat,\n20 알터렉 스위스 " },
		{ 275, "275 까지: 괴물 오믈렛\n또는 연한 늑대 스테이크" },
		{ 285, "285 까지: 룬툼 줄기 별미\nDire Maul (Pusillin)" },
		{ 300, "300 까지: 훈제 사막 경단\n실리더스에서 퀘스트" },
		{ 325, "325 까지: Ravager Dogs, Buzzard Bites" },
		{ 350, "350 까지: 갈래발굽 숯불구이\n차원의 버거, 탈부크 스테이크" },
		{ 375, "375 까지: Crunchy Serpent\nMok'nathal Treats" }
	},	
	-- source: http://www.wowguideonline.com/fishing.html
	[BI["Fishing"]] = {
		{ 50, "50 까지: 모든 시작 지역" },
		{ 75, "75 까지:\n스톰윈드 안 운하\n오그리마 안 연못The Pond in Orgrimmar" },
		{ 150, "150 까지: 힐스블래드 Foothills' river" },
		{ 225, "225 까지: 숙련 낚시 기술 책 구입 in Booty Bay\nFish in Desolace 또는 아라시 고원" },
		{ 250, "250 까지: Hinterlands, 타나리스\n\n|cFFFFFFFFFishing quest in Dustwallow Marsh\n|cFFFFD700Savage Coast Blue Sailfin (Stranglethorn Vale)\nFeralas Ahi (Verdantis River, Feralas)\nSer'theris Striker (Northern Sartheris Strand, Desolace)\nMisty Reed Mahi Mahi (Swamp of Sorrows coastline)" },
		{ 260, "260 까지: Felwood" },
		{ 300, "300 까지: 아즈라샤" },
		{ 330, "330 까지: 장가르 습지대 동부에 있는 물고기\n세나리온 원정대에 전문 낚시책" },
		{ 345, "345 까지: 장가르 습지대 서부" },
		{ 360, "360 까지: Terrokar Forest" },
		{ 375, "375 까지: Terrokar Forest, in altitude\nFlying mount required" }
	},
	
	-- suggested leveling zones, compiled by Thaoky, based on too many sources to list + my own leveling experience on Alliance side
	["Leveling"] = {
		{ 10, "10 까지: 모든 시작 지역" },
		{ 20, "20 까지: "  .. BZ["Loch Modan"] .. "\n" .. BZ["Westfall"] .. "\n" .. BZ["Darkshore"] .. "\n" .. BZ["Bloodmyst Isle"] 
						.. "\n" .. BZ["Silverpine Forest"] .. "\n" .. BZ["The Barrens"] .. "\n" .. BZ["Ghostlands"]},
		{ 25, "25 까지: " .. BZ["Wetlands"] .. "\n" .. BZ["Redridge Mountains"] .. "\n" .. BZ["Ashenvale"] 
						.. "\n" .. BZ["The Barrens"] .. "\n" .. BZ["Stonetalon Mountains"] .. "\n" .. BZ["Hillsbrad Foothills"] },
		{ 28, "28 까지: " .. BZ["Duskwood"] .. "\n" .. BZ["Wetlands"] .. "\n" .. BZ["Ashenvale"] 
						.. "\n" .. BZ["Stonetalon Mountains"] .. "\n" .. BZ["Thousand Needles"] },
		{ 31, "31 까지: " .. BZ["Duskwood"] .. "\n" .. BZ["Thousand Needles"] .. "\n" .. BZ["Ashenvale"] },
		{ 35, "35 까지: " .. BZ["Thousand Needles"] .. "\n" .. BZ["Stranglethorn Vale"] .. "\n" .. BZ["Alterac Mountains"] 
						.. "\n" .. BZ["Arathi Highlands"] .. "\n" .. BZ["Desolace"] },
		{ 40, "40 까지: " .. BZ["Stranglethorn Vale"] .. "\n" .. BZ["Desolace"] .. "\n" .. BZ["Badlands"]
						.. "\n" .. BZ["Dustwallow Marsh"] .. "\n" .. BZ["Swamp of Sorrows"] },
		{ 43, "43 까지: " .. BZ["Tanaris"] .. "\n" .. BZ["Stranglethorn Vale"] .. "\n" .. BZ["Badlands"] 
						.. "\n" .. BZ["Dustwallow Marsh"] .. "\n" .. BZ["Swamp of Sorrows"] },
		{ 45, "45 까지: " .. BZ["Tanaris"] .. "\n" .. BZ["Feralas"] .. "\n" .. BZ["The Hinterlands"] },
		{ 48, "48 까지: " .. BZ["Tanaris"] .. "\n" .. BZ["Feralas"] .. "\n" .. BZ["The Hinterlands"] .. "\n" .. BZ["Searing Gorge"] },
		{ 51, "51 까지: " .. BZ["Tanaris"] .. "\n" .. BZ["Azshara"] .. "\n" .. BZ["Blasted Lands"] 
						.. "\n" .. BZ["Searing Gorge"] .. "\n" .. BZ["Un'Goro Crater"] .. "\n" .. BZ["Felwood"] },
		{ 55, "55 까지: " .. BZ["Un'Goro Crater"] .. "\n" .. BZ["Felwood"] .. "\n" .. BZ["Burning Steppes"]
						.. "\n" .. BZ["Blasted Lands"] .. "\n" .. BZ["Western Plaguelands"] },
		{ 58, "58 까지: " .. BZ["Winterspring"] .. "\n" .. BZ["Burning Steppes"] .. "\n" .. BZ["Western Plaguelands"] 
						.. "\n" .. BZ["Eastern Plaguelands"] .. "\n" .. BZ["Silithus"] },
		{ 60, "60 까지: " .. BZ["Winterspring"] .. "\n" .. BZ["Eastern Plaguelands"] .. "\n" .. BZ["Silithus"] },
		{ 62, "62 까지: " .. BZ["Hellfire Peninsula"] },
		{ 64, "64 까지: " .. BZ["Zangarmarsh"] .. "\n" .. BZ["Terokkar Forest"]},
		{ 65, "65 까지: " .. BZ["Terokkar Forest"] },
		{ 66, "66 까지: " .. BZ["Terokkar Forest"] .. "\n" .. BZ["Nagrand"]},
		{ 67, "67 까지: " .. BZ["Nagrand"]},
		{ 68, "68 까지: " .. BZ["Blade's Edge Mountains"]},
		{ 70, "70 까지: " .. BZ["Blade's Edge Mountains"] .. "\n" .. BZ["Netherstorm"] .. "\n" .. BZ["Shadowmoon Valley"]},
		{ 72, "72 까지: " .. BZ["Howling Fjord"] .. "\n" .. BZ["Borean Tundra"]},
		{ 74, "74 까지: " .. BZ["Grizzly Hills"] .. "\n" .. BZ["Dragonblight"]},
		{ 76, "76 까지: " .. BZ["Dragonblight"] .. "\n" .. BZ["Zul'Drak"]},
		{ 78, "78 까지: " .. BZ["Zul'Drak"] .. "\n" .. BZ["Sholazar Basin"]},
		{ 80, "80 까지: " .. BZ["The Storm Peaks"] .. "\n" .. BZ["Icecrown"]},
	},

	-- Reputation levels
	-- -42000 = "Hated", "매우 적대적"
	-- -6000 = "Hostile", "적대적"
	-- -3000 = "Unfriendly", "약간 적대적"
	-- 0 = "Neutral", "중립적"
	-- 3000 = "Friendly", "약간 우호적"
	-- 9000 = "Honored", "우호적"
	-- 21000 = "Revered", "매우 우호적"
	-- 42000 = "Exalted", "확고한 동맹"
	
	-- Outland factions: source: http://www.mmo-champion.com/
	[BF["The Aldor"]] = {
		{ 0, "중립적 까지:\n" .. WHITE .. "[Dreadfang Venom Sac]|r +250 rep\n\n"
				.. YELLOW .. "Dreadfang Lurker,\nDreadfang Widow\n"
				.. WHITE .. "(Terrokar Forest)" },
		{ 9000, "우호적 까지:\n" .. WHITE .. "[Mark of Kil'jaeden]|r\n+25 rep" },
		{ 42000, "확고한 까지:\n" .. WHITE .. "[Mark of Sargeras]|r +25 rep per mark\n" 
				.. GREEN .. "[Fel Armament]|r +350 rep (+1 Holy Dust)"       }
	},
	[BF["The Scryers"]] = {
		{ 0, "중립적 까지:\n" .. WHITE .. "[Dampscale Basilisk Eye]|r +250 rep\n\n"
				.. YELLOW .. "Ironspine Petrifier,\nDampscale Devourer,\nDampscale Basilisk\n"
				.. WHITE .. "(Terrokar Forest)" },
		{ 9000, "우호적 까지:\n" .. WHITE .. "[Firewing Signet]|r\n+25 rep" },
		{ 42000, "확고한 까지:\n" .. WHITE .. "[Sunfury Signet]|r +25 rep per mark\n" 
				.. GREEN .. "[Arcane Tome]|r +350 rep (+1 Arcane Rune)"       }
	},
	[BF["Netherwing"]] = {
		{ 3000, "약간 우호적 까지, repeat these quests:\n\n" 
				.. YELLOW .. "A Slow Death (Daily)|r 250 rep\n"
				.. YELLOW.. "Netherdust Pollen (Daily)|r 250 rep\n"
				.. YELLOW.. "Netherwing crystal (Daily)|r 250 rep\n"
				.. YELLOW.. "Not so friendly skies (Daily)\n"
				.. YELLOW.. "Great Netherwing egg hunt (Repeatable)|r 250 rep" },
		{ 9000, "우호적 까지, repeat these quests:\n\n" 
				.. YELLOW .. "Overseeing and you: making the right choices|r 350 rep\n"
				.. YELLOW .. "The Booterang: A Cure ... (Daily)|r 350 rep\n"
				.. YELLOW .. "Picking up the pieces (Daily)|r 350 rep\n"
				.. YELLOW .. "Dragons are the least of our problems (Daily)|r 350 rep\n"
				.. YELLOW .. "Crazed & confused|r 350 rep\n" },
		{ 21000, "매우 우호적 까지, repeat these quests:\n\n" 
				.. YELLOW .. "Subduing the Subduer|r 500 rep\n" 
				.. YELLOW .. "Disrupting the Twiligth Generator (Daily)|r 500 rep\n"
				.. YELLOW .. "Race quests 500 each for first 5, 1000 for 6th\n" },
		{ 42000, "확고한 까지, repeat this quest:\n\n" 
				.. YELLOW .. "The greatest trap ever (Daily) (3 man group)|r 500 rep" }
	},
	[BF["Honor Hold"]] = {
		{ 9000, "우호적 까지:\n\n" 
				.. YELLOW .. "Quest in Hellfire Peninsula\n"
				.. GREEN .. "Hellfire Remparts |r(Normal)\n"
				.. GREEN .. "Blood Furnace |r(Normal)" },		
		{ 42000, "확고한 까지:\n\n" 
				.. GREEN .. "Shattered Halls |r(Normal & Heroic)\n"
				.. GREEN .. "Hellfire Remparts |r(Heroic)\n"
				.. GREEN .. "Blood Furnace |r(Heroic)" }
	},
	[BF["Thrallmar"]] = {
		{ 9000, "우호적 까지:\n\n" 
				.. YELLOW .. "Quest in Hellfire Peninsula\n"
				.. GREEN .. "Hellfire Remparts |r(Normal)\n"
				.. GREEN .. "Blood Furnace |r(Normal)" },		
		{ 42000, "확고한 까지:\n\n" 
				.. GREEN .. "Shattered Halls |r(Normal & Heroic)\n"
				.. GREEN .. "Hellfire Remparts |r(Heroic)\n"
				.. GREEN .. "Blood Furnace |r(Heroic)" }
	},
	[BF["Cenarion Expedition"]] = {
		{ 3000, "약간 우호적 까지:\n\n" 
				.. WHITE .. "Darkcrest & Bloodscale Nagas (+5 rep)\n"
				.. YELLOW .. "Quest in Zangarmarsh\n"
				.. "|rRun any " .. GREEN .. "Coilfang|r instance\n\n"
				.. WHITE .. "Keep [Unidentified Plant Parts] for later" },	
		{ 9000, "우호적 까지:\n\n" 
				.. WHITE .. "Turn in [Unidentified Plant Parts] x240\n"
				.. YELLOW .. "Quest in Zangarmarsh\n"
				.. "|rRun any " .. GREEN .. "Coilfang|r instance" },
		{ 42000, "확고한 까지:\n\n" 
				.. WHITE .. "Turn in [Coilfang Armaments] +75 rep\n\n"
				.. GREEN .. "Steamvault |r(Normal)\n"
				.. GREEN .. "Any Coilfang instance |r(Heroic)" }
	},
	[BF["Keepers of Time"]] = {
		{ 42000, "확고한 까지:\n\n" 
				.. "|rRun the " .. GREEN .. "Old Hillsbrad Foothills|r & " .. GREEN .. "The Black Morass\n\n"
				.. YELLOW .. "Keep quests for later:\nOld Hillsbrad quesline = 5000 rep\nBlack Morass questline = 8000 rep" }
	},
	[BF["The Sha'tar"]] = {
		{ 42000, "확고한 까지:\n\n" 
				.. GREEN .. "The Botanica |r(Normal & Heroic)\n"
				.. GREEN .. "The Mechanar |r(Normal & Heroic)\n"
				.. GREEN .. "The Arcatraz |r(Normal & Heroic)\n" }
	},	
	[BF["Lower City"]] = {
		{ 9000, "우호적 까지:\n\n" 
				.. WHITE .. "Turn in [Arrakoa Feather] x30 (+250 rep)\n"
				.. GREEN .. "Shadow Labyrinth |r(Normal)\n"
				.. GREEN .. "Auchenai Crypts |r(Normal)\n"
				.. GREEN .. "Sethekk Halls |r(Normal)" },
		{ 42000, "확고한 까지:\n\n" 
				.. GREEN .. "Shadow Labyrinth |r(Normal & Heroic)\n"
				.. GREEN .. "Auchenai Crypts |r(Heroic)\n"
				.. GREEN .. "Sethekk Halls |r(Heroic)" }
	},	
	[BF["The Consortium"]] = {
		{ 3000, "약간 우호적 까지:\n\n" 
				.. "|rTurn in [Oshu'gun Crystal Fragment] +250 rep\n"
				.. "Turn in [Pair of Ivory Tusks] +250 rep\n\n"
				.. GREEN .. "Mana-Tombs |r(Normal)" },
		{ 9000, "우호적 까지:\n\n" 
				.. "|rTurn in [Obsidian Warbeads] +250 rep\n\n"
				.. GREEN .. "Mana-Tombs |r(Normal)" },
		{ 42000, "확고한 까지:\n\n" 
				.. "|rTurn in [Zaxxis Insignia] +250 rep\n"
				.. "|rTurn in [Obsidian Warbeads] +250 rep\n\n"
				.. GREEN .. "Mana-Tombs |r(Heroic)" }
	}

	-- Northrend factions
}
