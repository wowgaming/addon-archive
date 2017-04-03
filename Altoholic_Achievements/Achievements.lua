local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BF = LibStub("LibBabble-Faction-3.0"):GetLookupTable()

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local TEAL		= "|cFF00FF9A"
local YELLOW	= "|cFFFFFF00"
local ORANGE	= "|cFFFF7F00"
local GRAY		= "|cFF909090"

-- category ids
local CAT_GENERAL										= 92
local CAT_QUESTS										= 96
local CAT_QUESTS_WOW									= 14861
local CAT_QUESTS_BC									= 14862
local CAT_QUESTS_WOTLK								= 14863
local CAT_EXPLORATION_OUTLAND						= 14779
local CAT_EXPLORATION_NORTHREND					= 14780
local CAT_PVP											= 95
local CAT_PVP_ARENA									= 165
local CAT_PVP_ALTERAC								= 14801
local CAT_PVP_ARATHI									= 14802
local CAT_PVP_WARSONG								= 14804
local CAT_PVP_SOTA									= 14881
local CAT_PVP_WINTERGRASP							= 14901
local CAT_PVP_CONQUEST								= 15003
local CAT_DUNGEONS									= 168
local CAT_DUNGEONS_WOTLK							= 14806
local CAT_DUNGEONS_WOTLKHEROIC					= 14921
local CAT_DUNGEONS_ULDUAR10						= 14961
local CAT_DUNGEONS_ULDUAR25						= 14962
local CAT_DUNGEONS_CRUSADE10						= 15001
local CAT_DUNGEONS_CRUSADE25						= 15002
local CAT_DUNGEONS_ICECROWN10						= 15041
local CAT_DUNGEONS_ICECROWN25						= 15042
local CAT_PROFESSIONS								= 169
local CAT_PROFESSIONS_COOKING						= 170
local CAT_PROFESSIONS_FISHING						= 171
local CAT_PROFESSIONS_FIRSTAID					= 172
local CAT_REPUTATIONS								= 201
local CAT_REPUTATIONS_BC							= 14865
local CAT_REPUTATIONS_WOTLK						= 14866
local CAT_EVENTS										= 155
local CAT_EVENTS_LUNARFESTIVAL					= 160
local CAT_EVENTS_LOVEISINTHEAIR					= 187
local CAT_EVENTS_NOBLEGARDEN						= 159
local CAT_EVENTS_MIDSUMMER							= 161
local CAT_EVENTS_BREWFEST							= 162
local CAT_EVENTS_HALLOWSEND						= 158
local CAT_EVENTS_PILGRIMSBOUNTY					= 14981
local CAT_EVENTS_WINTERVEIL						= 156
local CAT_EVENTS_ARGENTTOURNAMENT				= 14941
local CAT_FEATS										= 81

-- list of achievements, per category. The list is obviously comma-separated, and faction specific achievements are under the form "alliance:horde"
-- note: if the achievement name is different (eg: "for the alliance!" & "for the horde") do NOT treat them as combined achievements: they should appear on different lines in the UI.
local SortedAchievements = {
	-- To improve readability, these categories will be pre-sorted, even partially, in order to list achievements
	-- in a meaningful order (regardless of localization), as a pure alphabetical order is not always relevant, ex: 10, 100, 1000, 25, 250..etc 
	-- these arrays will thus be used as the first lines in the view, and the complement will be sorted alphabetically.
	
	-- levels, got my mind on my money, riding skill, mounts, pets, tabards
	[CAT_GENERAL] = "6,7,8,9,10,11,12,13,1176,1177,1178,1180,1181,891,889,890,892,2141,2142,2143,2536:2537,1017,15,1248,1250,2516,621,1020,1021",
	[CAT_QUESTS] = "503,504,505,506,507,508,32,978,973,974,975,976,977",		-- quests completed,  daily quests completed
	[CAT_QUESTS_WOW] = "1676:1677,1678:1680,940",
	[CAT_QUESTS_BC] = "1189:1271,1190,1191:1272,1192:1273,1193,1194,1195,1262:1274,1275,939,1276",
	[CAT_QUESTS_WOTLK] = "33:1358,34:1356,35:1359,37:1357,36,39,38,40,41:1360",
	[CAT_EXPLORATION_OUTLAND] = "862,863,867,866,865,843,864,1311,1312",
	[CAT_EXPLORATION_NORTHREND] = "1263,1264,1265,1266,1267,1457,1268,1269,1270,2256,2257",
	[CAT_PVP] = "238,513,515,516,512,509,239,869,870",				-- honorable kills
	[CAT_PVP_ARENA] = "397,398,875,876,399,400,401,1159,402,403,405,1160,406,407,404,1161",
	[CAT_PVP_WINTERGRASP] = "2085,2086,2087,2088,2089",			-- Stone keeper shards
	[CAT_DUNGEONS] = "3838,3839,3840,3841,3842,3843,3844,3876,4316,1283,1285,1284,1287,1286,1288,1289,2136,2137,2138,1658,2957,2958,4016,4017,4602,4603,4476,4477,4478",
	[CAT_DUNGEONS_CRUSADE10] = "3808,3809,3810,4080",
	[CAT_DUNGEONS_CRUSADE25] = "3817,3818,3819",
	[CAT_PROFESSIONS] = "116,731,732,733,734",							-- professional journeyman, etc..
	[CAT_PROFESSIONS_COOKING] = "121,122,123,124,125,1999,2000,2001,2002,1795,1796,1797,1798,1799,1777,1778,1779",			-- level, dalaran awards, num recipes, northrend gourmet
	[CAT_PROFESSIONS_FISHING] = "126,127,128,129,130,1556,1557,1558,1559,1560,1561,2094,2095,1957,2096",						-- level, num fishes, dalaran coins
	[CAT_PROFESSIONS_FIRSTAID] = "131,132,133,134,135",					-- journeyman, expert, artisan, master, grand master
	[CAT_REPUTATIONS] = "522,523,524,521,520,519,518,1014,1015",		-- exalted reputations
	[CAT_EVENTS_LUNARFESTIVAL] = "605,606,607,608,609",				-- coins of ancestry
	[CAT_EVENTS_ARGENTTOURNAMENT] = "2756,2758,2777,2760,2779,2762,2780,2763,2781,2764,2778,2761,2782,2770,2817,2783,2765,2784,2766,2785,2767,2786,2768,2787,2769,2788,2771,2816",
}

local UnsortedAchievements = {
	[CAT_GENERAL] = "16,545,546,556,557,558,559,705,964,1165,1187,1206,1244,1254,1832,1833,1956,2076,2077,2078,2084,2097,2556,2557,2716",
	[CAT_QUESTS] = "31,941,1182,1576,1681:1682",
	[CAT_QUESTS_WOTLK] = "547,561,938,961,962,1277,1428,1596",
--	[CAT_EXPLORATION_OUTLAND] = fully sorted
--	[CAT_EXPLORATION_NORTHREND] = fully sorted
	[CAT_PVP] = "227,229,230:1175,231,245,246:1005,247,388:1006,389,396,603,604,610,611,612,613,614,615,616,617,618,619,700,701,714,727,907,908:909,1157,2016:2017",
	[CAT_PVP_ARENA] = "408,409,699,1162,1174,2090,2091,2092,2093",
	[CAT_PVP_ALTERAC] = "221,582,219,218,225:1164,706,873,708,709,224:1151,1167:1168,707,220,226,223,1166,222",
	[CAT_PVP_ARATHI] = "583,584,165,155,154,73,711,159,1169:1170,158,1153,161,156,710,157,162",
	[CAT_PVP_WINTERGRASP] = "1717,1718,1721,1722,1723,1727,1737:2476,1751,1752:2776,1755,2080,2199,3136,3137,3836,3837,4585,4586",
	[CAT_PVP_SOTA] = "2191,1766,2189,1763,1757:2200,2190,1764,2193,2194:2195,1762:2192,1765,1310,1309,1308,1761",
	[CAT_PVP_WARSONG] = "199,872,204,1172:1173,203,1251,1259,200,202:1502,207,713,206:1252,201,168,167,166,712",
	[CAT_PVP_CONQUEST] = "3848,3849,3853,3854,3852,3856:4256,3847,3855,3845,3777,3776,3857:3957,3851:4177,3850,3846:4176",
	[CAT_DUNGEONS_WOTLK] = "481,480,482,484,486,485,479,4516,4518,478,487,4517,483,4296:3778,477,488",
	[CAT_DUNGEONS_WOTLKHEROIC] = "2153,2155,2046,3802,2039,2154,2037,2151,1816,2041,4524,4525,2045,1871,1866,1860,1297,492,491,493,495,497,496,500,4519,4521,490,498,4520,494,4298:4297,489,499,3804,2036,2157,2040,1834,1865,1873,1868,2156,2057,1919,2038,2044,2152,2042,2058,4522,2150,1817,3803,2043,4523,1867,1862,2056,1296,4526,1864,1872",
	[CAT_DUNGEONS_ULDUAR10] = "2919,3159,2945,2947,2903,2961,2980,3006,2985,2953,2971,3008,3097,3180,2982,2967,3004,3012,3058,3316,2927,2939,2941,2940,3182,2963,3181,2973,2955,3015,2923,3009,3177,3178,3179,3176,2979,2937,2931,2934,2933,3076,3138,2915,3036,3158,3056,2913,2914,2959,2989,2996,2925,2911,2977,2969,2930,3003,2909,2888,2892,2890,2894,2886,3014,2907,3157,3141,2905,2975,2951",
	[CAT_DUNGEONS_ULDUAR25] = "2921,3164,2946,2948,2962,2981,2904,3007,2984,2954,2972,3010,3098,3189,2983,2968,3005,3013,3059,2928,2942,2944,2943,3184,2965,3188,2974,2956,3016,2924,3011,3185,3186,3187,3183,3118,2938,2932,2936,2935,3077,2995,2917,3037,3163,3057,2918,2916,2960,3237,2997,2926,2912,2978,2970,2929,3002,2910,2889,2893,2891,2895,2887,3017,2908,3161,3162,2906,2976,2952",
	[CAT_DUNGEONS_CRUSADE10] = "3917,3918,3936,3798,3799,3800,3996,3797",
	[CAT_DUNGEONS_CRUSADE25] = "3916,3812,3937,3814,3815,3816,3997,3813",
	[CAT_DUNGEONS_ICECROWN10] = "4580,4583,4601,4534,4538,4532,4577,4535,4636,4628,4630,4631,4629,4536,4537,4578,4581,4539,4579,4531,4529,4527,4530,4582,4528",
	[CAT_DUNGEONS_ICECROWN25] = "4620,4621,4610,4614,4608,4615,4611,4637,4632,4634,4635,4633,4612,4613,4616,4622,4618,4619,4604,4606,4607,4597,4584,4617,4605",
	[CAT_PROFESSIONS] = "730,735",
	[CAT_PROFESSIONS_COOKING] = "877,906,1563:1784,1780,1781,1782:1783,1785,1800,1801,1998,3296",
	[CAT_PROFESSIONS_FISHING] = "144,150,153,306,560,726,878,905,1225,1243,1257,1516,1517,1836,1837,1958,3217,3218",
	[CAT_PROFESSIONS_FIRSTAID] = "137,141",
	[CAT_REPUTATIONS] = "762,942:943,945,948,953",
	[CAT_REPUTATIONS_BC] = "896,893,902,894,901,899,898,903,1638,958,764:763,900,959,960,897",
	[CAT_REPUTATIONS_WOTLK] = "950,2083,2082,1009,952,1010,947,4598,1008,951,1012:1011,1007,949",
	[CAT_EVENTS] = "1684:1683,3456,1707:1693,1793,1656:1657,1692:1691,2797:2798,3478:3656,3457,1039,1038,913,2144:2145",
	[CAT_EVENTS_LUNARFESTIVAL] = "626,910,911,912,914,915,937,1281,1396,1552",
	[CAT_EVENTS_LOVEISINTHEAIR] = "1701,260,1695,1699,1279:1280,1704,1291,1694,1703,1697:1698,1700,1188,1702,1696,4624",
	[CAT_EVENTS_NOBLEGARDEN] = "2576,2418,2417,2436,249,2416,2676,2421:2420,2422,2419:2497,248",
	[CAT_EVENTS_MIDSUMMER] = "271,1037,1035,1028:1031,1029:1032,1030:1033,1025,1026,1027,1022,1023,1024,263,1145,1034:1036,272",
	[CAT_EVENTS_BREWFEST] = "2796,1183,295,293,1936,1186,1260,303,1184:1203,1185",
	[CAT_EVENTS_HALLOWSEND] = "284,255,291,1261,288,1040:1041,292,981,979,283,289,972,970:971,966:967,963:965,969:968",
	[CAT_EVENTS_PILGRIMSBOUNTY] = "3579,3576:3577,3556:3557,3580:3581,3596:3597,3558,3582,3578,3559",
	[CAT_EVENTS_WINTERVEIL] = "277,1690,4436:4437,1686:1685,1295,1282,1689,1687,273,1255:259,279,1688,252",
	[CAT_EVENTS_ARGENTTOURNAMENT] = "3676,2773,2836,3736,3677,4596,2772",
	[CAT_FEATS] = "411,412,414,415,416,418,419,420,424,425,426,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,454,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471:453,472,473,662,663,664,665,683,684,725,729,871,879,880,881,882,883,884,885,886,887,888,980,1205,1292,1293,1400,1402,1404,1405,1406,1407,1408,1409,1410,1411,1412,1413,1414,1415,1416,1417,1418,1419,1420,1421,1422,1423,1424,1425,1426,1427,1436,1463,1636,1637,1705,1706,2018,2019,2079,2081,2116,2316,2336,2357,2358,2359,2398,2456,2496,3096,3117,3142,3259,3336,3356,3357,3436,3496,3536,3618,3636,3756,3757,3758,3896,4078,4079:4156,4400,4496,4576,4599,4600,4623,4625,4626,4627",
}

local AchievementsList = {}

local function SortByName(a, b)
	if type(a) == "string" then
		a = strsplit(":", a)
		a = tonumber(a)
	end
	if type(b) == "string" then
		b = strsplit(":", b)
		b = tonumber(b)
	end

	local nameA = select(2, GetAchievementInfo(a)) or ""
	local nameB = select(2, GetAchievementInfo(b)) or ""
	return nameA < nameB
end

local function AddAchievementToCategory(categoryID, achievement)
	-- if the achievement is a number or a string that can be converted to a number, add it as a number
	-- else add it as a string . This will be the case for faction specific achievements. 
	--	ex: "122:123" would mean that 122 is the alliance version of the achievement, and 123 the horde version
	table.insert(AchievementsList[categoryID], tonumber(achievement) or achievement)
end

local function BuildCategoryList(categoryID)
	-- each category is a sub-table of the reference table.
	AchievementsList[categoryID] = {}

	--	if this category does not contain series or faction specific achievements : use the game's list
	if not SortedAchievements[categoryID] and not UnsortedAchievements[categoryID] then
		local id
		for i = 1, GetCategoryNumAchievements(categoryID) do
			id = GetAchievementInfo(categoryID, i)
			AddAchievementToCategory(categoryID, id)
		end
		table.sort(AchievementsList[categoryID], SortByName)
		return
	end
	
	--	otherwise : use the list of sorted achievements .. 
	if SortedAchievements[categoryID] then
		for achievement in SortedAchievements[categoryID]:gmatch("([^,]+)") do
			AddAchievementToCategory(categoryID, achievement)
		end
	end
	
	-- .. then add the unsorted ones after they've been sorted alphabetically.
	if UnsortedAchievements[categoryID] then
		local remaining = {}
		for achievement in UnsortedAchievements[categoryID]:gmatch("([^,]+)") do
			table.insert(remaining, tonumber(achievement) or achievement)
		end
		table.sort(remaining, SortByName)	-- sort remaining achievements by name ..
		
		for _, achievement in pairs(remaining) do		
			AddAchievementToCategory(categoryID, achievement)
		end
	end
end

local function BuildReferenceTable()
	-- based on the list of achievements that should be sorted in a predefined order, and the remaining achievements (ordered alphabetically, with the influence of localized named), create a reference table
	-- that will allow easy use of categories/lists which support both factions.
	
	local cats = GetCategoryList()
	for _, categoryID in ipairs(cats) do
		local _, parentID = GetCategoryInfo(categoryID)
		
		if parentID == -1 then		-- add categories, followed by their respective sub-categories
			BuildCategoryList(categoryID)
			
			for _, subCatID in ipairs(cats) do
				local _, subCatParentID = GetCategoryInfo(subCatID)
				if subCatParentID == categoryID then
					BuildCategoryList(subCatID)
				end
			end
		end
	end
end

-- now that this part of the UI is LoD, this can be called here
BuildReferenceTable()

SortedAchievements = nil
UnsortedAchievements = nil
BuildReferenceTable = nil
BuildCategoryList = nil
AddAchievementToCategory = nil
SortByName = nil

AltoholicTabAchievements_NotStarted:SetText("\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t" .. L["Not started"])
AltoholicTabAchievements_Partial:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Waiting:14\124t" .. L["Started"])
AltoholicTabAchievements_Completed:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t" .. COMPLETE)

local function GetCategorySize(categoryID)
	if type(AchievementsList[categoryID]) == "table" then
		return #AchievementsList[categoryID]
	end
	return 0
end

local function GetAchievementFactionInfo(categoryID, index)
	if type(AchievementsList[categoryID]) == "table" then
		local achievement = AchievementsList[categoryID][index]
		
		if type(achievement) == "number" then
			return achievement								-- return achievement ID
		elseif type(achievement) == "string" then
			local ally, horde = strsplit(":", achievement)
			return tonumber(ally), tonumber(horde)		-- return alliance ach id, horde ach id
		end
	end
end

local CRITERIA_COMPLETE_ICON = "\124TInterface\\AchievementFrame\\UI-Achievement-Criteria-Check:14\124t"

local function ButtonOnEnter(frame)
	if not frame.CharName then return end
	
	local DS = DataStore
	local realm, account = addon:GetCurrentRealm()
	local character = DS:GetCharacter(frame.CharName, realm, account)
	
	local achievementID = frame.id
	local _, achName, points, _, _, _, _, description, _, _, rewardText = GetAchievementInfo(achievementID);
	
	AltoTooltip:SetOwner(frame, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	AltoTooltip:AddDoubleLine(DS:GetColoredCharacterName(character), achName)
	AltoTooltip:AddLine(WHITE .. description, 1, 1, 1, 1, 1);
	AltoTooltip:AddLine(WHITE .. ACHIEVEMENT_TITLE .. ": " .. YELLOW .. points);
	AltoTooltip:AddLine(" ");

	local isStarted, isComplete = DS:GetAchievementInfo(character, achievementID)
	
	if isComplete then
		AltoTooltip:AddLine(format("%s: %s", WHITE .. STATUS, GREEN .. COMPLETE ));
	elseif isStarted then
		local numCompletedCriteria = 0
		local numCriteria = GetAchievementNumCriteria(achievementID)
		
		for criteriaIndex = 1, numCriteria do	-- browse all criterias
			local criteriaString, criteriaType, _, _, reqQuantity, _, _, assetID = GetAchievementCriteriaInfo(achievementID, criteriaIndex);
			if criteriaType == CRITERIA_TYPE_ACHIEVEMENT and assetID then		-- if criteria is another achievement
				_, criteriaString = GetAchievementInfo(assetID);
			end
			
			local isCriteriaStarted, isCriteriaComplete, quantity = DS:GetCriteriaInfo(character, achievementID, criteriaIndex)

			local icon = ""
			local color = GRAY

			if isCriteriaComplete then
				icon = CRITERIA_COMPLETE_ICON
				numCompletedCriteria = numCompletedCriteria + 1
				color = GREEN
			elseif isCriteriaStarted then
				if tonumber(quantity) > 0 then
					criteriaString = criteriaString .. WHITE
				end
				
				if criteriaType == 62 or criteriaType == 67 then		-- this type is an amount of gold, format it as such, make something more generic later on if necessary
					quantity = addon:GetMoneyString(tonumber(quantity))
					reqQuantity = addon:GetMoneyString(tonumber(reqQuantity))
					criteriaString = format(" - %s (%s/%s)", criteriaString, quantity..WHITE, reqQuantity..WHITE)
				else
					criteriaString = format(" - %s (%s/%s)", criteriaString, quantity, reqQuantity)
				end
			else
				criteriaString = format(" - %s", criteriaString)
			end
			
			AltoTooltip:AddLine(format("%s%s%s", icon, color, criteriaString))
		end
		
		if numCriteria > 1 then
			AltoTooltip:AddLine(" ");
			AltoTooltip:AddLine(format("%s: %s%d/%d", WHITE..STATUS, GREEN, numCompletedCriteria, numCriteria));
		end
	else
		for i = 1, GetAchievementNumCriteria(achievementID) do	-- write all criterias in gray
			local criteriaString, criteriaType, _, _, _, _, _, assetID = GetAchievementCriteriaInfo(achievementID, i);
			if criteriaType == CRITERIA_TYPE_ACHIEVEMENT and assetID then		-- if criteria is another achievement
				_, criteriaString = GetAchievementInfo(assetID);
			end
		
			AltoTooltip:AddLine(GRAY .. " - " .. criteriaString);
		end
	end
	
	if strlen(rewardText) > 0 then		-- not nil if empty, so test the length of the string
		AltoTooltip:AddLine(" ");
		AltoTooltip:AddLine(GREEN .. rewardText);
	end

	if isStarted or isComplete then
		AltoTooltip:AddLine(" ");
		AltoTooltip:AddLine(GREEN .. L["Shift+Left click to link"]);
	end
	-- AltoTooltip:AddLine(GREEN .. "id : " .. achievementID);			-- debug
	
	AltoTooltip:Show();
end

local function ButtonOnClick(frame, button)
	if not frame.CharName then return end
	
	if ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		local chat = ChatEdit_GetLastActiveWindow()
	
		if chat:IsShown() then
			local realm, account = addon:GetCurrentRealm()
			local character = DataStore:GetCharacter(frame.CharName, realm, account)
			local achievementID = frame.id

			local link = DataStore:GetAchievementLink(character, achievementID)
			if link then 
				chat:Insert(link)
			end		
		end
	end
end

addon.Achievements = {}

local ns = addon.Achievements		-- ns = namespace

local currentCategoryID

function ns:SetCategory(categoryID)
	currentCategoryID = categoryID
end

function ns:Update()
	local VisibleLines = 8
	local frame = "AltoholicFrameAchievements"
	local entry = frame.."Entry"
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local categorySize = GetCategorySize(currentCategoryID)
	
	local realm, account = addon:GetCurrentRealm()
	local character
	
	AltoholicTabAchievementsStatus:SetText(format("%s: %s", ACHIEVEMENTS, GREEN..categorySize ))
	
	for i=1, VisibleLines do
		local line = i + offset
		if line <= categorySize then	-- if the line is visible
			local achievementID
			local allianceID, hordeID = GetAchievementFactionInfo(currentCategoryID, line)
			local _, achName = GetAchievementInfo(allianceID)		-- use the alliance name if a
			
			_G[entry..i.."Name"]:SetText(WHITE .. achName)
			_G[entry..i.."Name"]:SetJustifyH("LEFT")
			_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
			
			for j = 1, 10 do
				local itemName = entry.. i .. "Item" .. j;
				local itemButton = _G[itemName]
				
				local classButton = _G["AltoholicFrameClassesItem" .. j]
				if classButton.CharName then
					character = DataStore:GetCharacter(classButton.CharName, realm, account)
					
					itemButton:SetScript("OnEnter", ButtonOnEnter)
					itemButton:SetScript("OnClick", ButtonOnClick)
					
					if hordeID and DataStore:GetCharacterFaction(character) ~= "Alliance" then
						achievementID = hordeID
					else
						achievementID = allianceID
					end
					
					local itemTexture = _G[itemName .. "_Background"]
					
					local _, _, _, _, _, _, _, _, _, achImage = GetAchievementInfo(achievementID)
					itemTexture:SetTexture(achImage)
					
					local isStarted, isComplete = DataStore:GetAchievementInfo(character, achievementID)
					
					if isComplete then
						itemTexture:SetVertexColor(1.0, 1.0, 1.0);
						_G[itemName .. "Name"]:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t")
					elseif isStarted then
						itemTexture:SetVertexColor(0.9, 0.6, 0.2);
						_G[itemName .. "Name"]:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Waiting:14\124t")
					else
						itemTexture:SetVertexColor(0.4, 0.4, 0.4);
						_G[itemName .. "Name"]:SetText("\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t")
					end
					
					itemButton.CharName = classButton.CharName
					itemButton.id = achievementID
					itemButton:Show()
				else
					itemButton:Hide()
					itemButton.CharName = nil
					itemButton.id = nil
				end
			end

			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end

	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], categorySize, VisibleLines, 41);
end
