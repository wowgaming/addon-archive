-------------------------------------------------------------------------------
-- MrTrader 
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------

MRTSkillWindow = LibStub("AceAddon-3.0"):NewAddon("MrTrader_SkillWindow",
												  "AceEvent-3.0");

-- Constants
local MAX_TRADE_SKILL_REAGENTS = 8;
local NUM_FILTERS_TO_DISPLAY = 18;
local TRADE_SKILLS_DISPLAYED = 11;
local TRADE_SKILL_TEXT_WIDTH = 275;
MRTRADER_TRADE_SKILL_HEIGHT = 16;
MRTRADER_TRADE_SKILL_FILTER_HEIGHT = 20;

-- Coloring for trade skills
local TradeSkillTypeColor = { };
TradeSkillTypeColor["optimal"]	= { r = 1.00, g = 0.50, b = 0.25,	font = GameFontNormalLeftOrange };
TradeSkillTypeColor["medium"]	= { r = 1.00, g = 1.00, b = 0.00,	font = GameFontNormalLeftYellow };
TradeSkillTypeColor["easy"]		= { r = 0.25, g = 0.75, b = 0.25,	font = GameFontNormalLeftLightGreen };
TradeSkillTypeColor["trivial"]	= { r = 0.50, g = 0.50, b = 0.50,	font = GameFontNormalLeftGrey };
TradeSkillTypeColor["header"]	= { r = 1.00, g = 0.82, b = 0,		font = GameFontNormalLeft };

-- Colorblind Support
local TradeSkillTypePrefix = {
["optimal"] = " [+++] ",
["medium"] = " [++] ",
["easy"] = " [+] ",
["trivial"] = " ", 
["header"] = " ",
}

UIPanelWindows["MRTSkillFrame"] =	{ area = "left", pushable = 3 };

local L = LibStub("AceLocale-3.0"):GetLocale("MrTrader", true);

-----
-- XML Definitions
-----
MRTRADER_NEW_CATEGORY = MRTLoc["New Group"];
MRTRADER_NEW_FAVORITE_GROUP = MRTLoc["New Favorite Group"];
MRTRADER_NAME = MRTLoc["Name"];
MRT_QUEUE = MRTLoc["Queue"];
MRT_SHOW_QUEUE = MRTLoc["Show Queue"];
MRT_HIDE_QUEUE = MRTLoc["Hide Queue"];

-----
-- Functions
-----
function MRTSkillWindow:OnInitialize()
	-- Tradeskill window events
	self:RegisterEvent("TRADE_SKILL_UPDATE", "Update");
	self:RegisterEvent("TRADE_SKILL_CLOSE", "Close");
end

function MRTSkillWindow:Show()
	-- Make sure we dump the old tradeskill filter index.
	if( self.tradeskillID ) then
		MrTrader:StoreFilter(self.tradeskillID, self.filterCategory, self.filterSelection);
	end
	self.tradeskillID = MrTrader:MatchPartialCraftSkillName(GetTradeSkillLine(), true);

	-- Set the portrait to the icon for the tradeskill (the player portrait doesn't make much sense in Wrath)
	local _, _, skillIcon = GetSpellInfo(self.tradeskillID);
	SetPortraitToTexture(MRTSkillFramePortrait, skillIcon);

	MRTSkillWindow.filters = {};
	ShowUIPanel(MRTSkillFrame);
		
	FauxScrollFrame_SetOffset(MRTSkillListScrollFrame, 0);
	MRTSkillListScrollFrameScrollBar:SetMinMaxValues(0, 0); 
	MRTSkillListScrollFrameScrollBar:SetValue(0);
	
	MRTSkillWindow:SetSkillSelection(nil, 0);	
	
	self.filterCategory, self.filterSelection = MrTrader:RestoreFilter(self.tradeskillID);
	MRTSkillWindow:PopulateFilterTree();
		
	MRTSkillFrameEditBox:SetText(SEARCH);
	MRTSkillWindow_OnSearchTextChange(MRTSkillFrameEditBox);
	
	MRTSkillFrameAvailableFilterCheckButton:SetChecked(false);
	TradeSkillOnlyShowMakeable(MRTSkillFrameAvailableFilterCheckButton:GetChecked());
	
	MRTSkillWindow:Update();
	MRTUIUtils_WindowOnShow(MRTSkillFrame);
end

function MRTSkillWindow:Close()
	MrTrader:StoreFilter(self.tradeskillID, self.filterCategory, self.filterSelection);
	self.tradeskillID = nil;

	HideUIPanel(MRTSkillFrame);
end

function MRTSkillWindow:PopulateFilterTree()
	MRTSkillWindow.filters = {};
	
	tinsert(MRTSkillWindow.filters, 
		{
			title = MRTLoc["All Items"],
			filterType = "all",
			subgroups = {},
		});
	tinsert(MRTSkillWindow.filters, 
		{
			title = MRTLoc["Categories"],
			subgroups = {},
		});
	tinsert(MRTSkillWindow.filters, 
		{
			title = MRTLoc["Inventory Slots"],
			subgroups = {},
		});
		
	local groups = {GetTradeSkillSubClasses()};
	local numGroups = getn(groups);
	local parent = MRTSkillWindow.filters[2];
	for i=1, numGroups do
		tinsert(parent.subgroups, 
			{
				title = groups[i],
				filterType = "category",
				filterIndex = i,
			});
	end
	
	groups = {GetTradeSkillInvSlots()};
	numGroups = getn(groups);
	local parent = MRTSkillWindow.filters[3];
	for i=1, numGroups do
		tinsert(parent.subgroups, 
			{
				title = groups[i],
				filterType = "invslot",
				filterIndex = i,
			});
	end	
	
	tinsert(MRTSkillWindow.filters, 
		{
			title = MRTLoc["Difficulty"],
			subgroups = {},
		});
	parent = MRTSkillWindow.filters[4];
	tinsert(parent.subgroups, 
		{
			title = MRTLoc["Optimal"],
			filterType = "difficulty",
			filterIndex = "optimal",
		});
	tinsert(parent.subgroups, 
		{
			title = MRTLoc["Medium"],
			filterType = "difficulty",
			filterIndex = "medium",
		});
	tinsert(parent.subgroups, 
		{
			title = MRTLoc["Easy"],
			filterType = "difficulty",
			filterIndex = "easy",
		});
	tinsert(parent.subgroups, 
		{
			title = MRTLoc["Trivial"],
			filterType = "difficulty",
			filterIndex = "trivial",
		});
	
	
	tinsert(MRTSkillWindow.filters, 
		{
			title = MRTLoc["Favorites"],
			filterType = "favorite",
			filterIndex = "__all",
			subgroups = {},
		});
			
	local tradeskillSpellID = MrTrader:MatchPartialCraftSkillName(GetTradeSkillLine());
	local favorites = MrTrader:GetFavoritesForSkill(tradeskillSpellID);
	if( favorites and MrTrader:TableSize(favorites) > 0 ) then
		parent = MRTSkillWindow.filters[5];
		for categoryName, _ in pairs(favorites) do
			tinsert(parent.subgroups,
				{
					title = categoryName,
					filterType = "favorite",
					filterIndex = categoryName,
				})
		end
	end
	
	if( MRTSkillWindow.filterCategory ~= nil ) then
		local filterCategory = nil;
		local filterSelection = nil;
	
		for i=1, getn(MRTSkillWindow.filters) do
			if( MRTSkillWindow.filterCategory.title == MRTSkillWindow.filters[i].title and
				MRTSkillWindow.filterCategory.filterIndex == MRTSkillWindow.filters[i].filterIndex ) then
				filterCategory = MRTSkillWindow.filters[i];
				if( filterCategory.filterType ~= nil ) then
					filterSelection = MRTSkillWindow.filters[i];
				end
				
				if( MRTSkillWindow.filterSelection ~= nil ) then
					for j=1, getn(filterCategory.subgroups) do
						if( filterCategory.subgroups[j].title == MRTSkillWindow.filterSelection.title and
							filterCategory.subgroups[j].filterIndex == MRTSkillWindow.filterSelection.filterIndex ) then
							filterSelection = filterCategory.subgroups[j];
							break;
						end
					end
				end
				break;
			end
		end
		
		MRTSkillWindow.filterCategory = filterCategory;
		MRTSkillWindow.filterSelection = filterSelection;
	end
	
	if( MRTSkillWindow.filterCategory == nil ) then 
		MRTSkillWindow.filterCategory = MRTSkillWindow.filters[1];
		MRTSkillWindow.filterSelection = MRTSkillWindow.filters[1];
	end
	
	MRTSkillWindow:UpdateFilter();
end

function MRTSkillWindow:ParseSkillList()
	MRTSkillWindow.scannedSkillLists = {};
	MRTSkillWindow.scannedSkillLists["difficulty"] = {};
	MRTSkillWindow.scannedSkillLists["difficulty"]["optimal"] = {};
	MRTSkillWindow.scannedSkillLists["difficulty"]["medium"] = {};
	MRTSkillWindow.scannedSkillLists["difficulty"]["easy"] = {};
	MRTSkillWindow.scannedSkillLists["difficulty"]["trivial"] = {};
	MRTSkillWindow.scannedSkillLists["favorites"] = {};
	MRTSkillWindow.scannedSkillLists["favorites"]["__all"] = {};
	
	-- Setup for favorites
	local skillName = GetTradeSkillLine();
	local tradeskillSpellID = MrTrader:MatchPartialCraftSkillName(skillName);
	local favorites = MrTrader:GetFavoritesForSkill(tradeskillSpellID);

	if( favorites ) then
		for categoryName, _ in pairs(favorites) do
			MRTSkillWindow.scannedSkillLists["favorites"][categoryName] = {};
		end
	end

	-- Iterate through the filtered list and sort
	local serverCount = GetNumTradeSkills();
	for i=1, serverCount do
		local _, skillType = GetTradeSkillInfo(i);
		if( skillType ~= "header" ) then
			-- Add the item to a difficulty list
			tinsert(MRTSkillWindow.scannedSkillLists["difficulty"][skillType], i);
			
			-- Do a favorites check
			if( favorites ) then
				local inFavorites = false;
				local skillSpellID = MrTrader:GetSpellIDForRecipe(GetTradeSkillRecipeLink(i));
				for categoryName, categoryItems in pairs(favorites) do
					if( categoryItems[skillSpellID] == true ) then
						tinsert(MRTSkillWindow.scannedSkillLists["favorites"][categoryName], i);
						inFavorites = true;
					end
				end
			
				if( inFavorites == true ) then
					tinsert(MRTSkillWindow.scannedSkillLists["favorites"]["__all"], i);
				end
			end
		end
	end
end

function MRTSkillWindow:GetSkillList()
	local skillList = {};
	local serverCount = GetNumTradeSkills();
	
	-- Get the currently selected skill list if we have one
	if( MRTSkillWindow.filterSelection ~= nil ) then
		if( MRTSkillWindow.filterSelection.filterType == "difficulty" ) then
			return MRTSkillWindow.scannedSkillLists["difficulty"][MRTSkillWindow.filterSelection.filterIndex];
		elseif( MRTSkillWindow.filterSelection.filterType == "favorite" ) then
			return MRTSkillWindow.scannedSkillLists["favorites"][MRTSkillWindow.filterSelection.filterIndex];
		end
	end
	
	-- Otherwise, scan the current state of the server
	for i=1, serverCount do
		local _, skillType = GetTradeSkillInfo(i);
		if( skillType ~= "header" ) then
			tinsert(skillList, i);
		end
	end
	
	return skillList;
end

function MRTSkillWindow:SelectFilter(filter)
	if( filter == nil ) then
		return;
	end
	
	self.filterSelection = nil;
	-- Close everything up if they clicked on the filter category.
	if( filter == self.filterCategory ) then
		self.filterCategory = nil;
	else
		if( filter.subgroups ~= nil ) then
			self.filterCategory = filter;
		end

		if( filter.filterType ~= nil ) then
			self.filterSelection = filter;
		end

		MRTSkillWindow:UpdateFilter();
	end
		
	MRTSkillWindow:SetSkillSelection(nil, 0);
	MRTSkillWindow:Update();
end

function MRTSkillWindow:SelectSkill(skill, button)
	-- Do something here... maybe
	if ( button == "LeftButton" ) then
		MRTSkillWindow:SetSkillSelection(skill, skill:GetID());
		MRTSkillWindow:Update();
	elseif ( button == "RightButton" ) then
		MRTSkillContext:DisplaySkillContext(MRTSkillItemDropDown, skill:GetID());
	end
end

function MRTSkillWindow:SetSkillSelection(skillButton, skillID)
	MRTSkillWindow.selectedSkillButton = skillButton;
	MRTSkillWindow.selectedSkill = skillID;
	
	if ( MRTSkillWindow.selectedSkill > GetNumTradeSkills() ) then
		return;
	end

	-- Hide inappropriate controls when no skill is selected
	if ( MRTSkillWindow.selectedSkill == 0 ) then
		MRTSkillCreateButton:Hide();
		MRTSkillCreateAllButton:Hide();
		MRTSkillDecrementButton:Hide();
		MRTSkillInputBox:Hide();
		MRTSkillIncrementButton:Hide();
		MRTDetailScrollFrame:Hide();
		return;
	else
		MRTDetailScrollFrame:Show();
	end
	
	local skillName, skillType, numAvailable, isExpanded, altVerb = GetTradeSkillInfo(skillID);
	local craftable = 1;
	if( not skillName ) then
		craftable = nil;
	end
	
	local color = TradeSkillTypeColor[skillType];
	if ( color ) then
		MRTSkillHighlight:SetVertexColor(color.r, color.g, color.b);
	end
	
	-- Name and Cooldown
	MRTSkillName:SetText(skillName);
	if ( GetTradeSkillCooldown(skillID) ) then
		MRTSkillCooldown:SetText(COOLDOWN_REMAINING.." "..SecondsToTime(GetTradeSkillCooldown(skillID)));
	else
		MRTSkillCooldown:SetText("");
	end
	
	-- Icon and Number Made
	MRTSkillIcon:SetNormalTexture(GetTradeSkillIcon(skillID));
	local minMade, maxMade = GetTradeSkillNumMade(skillID);
	if ( maxMade > 1 ) then
		if ( minMade == maxMade ) then
			MRTSkillIconCount:SetText(minMade);
		else
			MRTSkillIconCount:SetText(minMade.."-"..maxMade);
		end
		if ( MRTSkillIconCount:GetWidth() > 39 ) then
			MRTSkillIconCount:SetText("~"..floor((minMade + maxMade)/2));
		end
	else
		MRTSkillIconCount:SetText("");
	end
	
	-- Reagents
	local numReagents = GetTradeSkillNumReagents(skillID);
	if(numReagents > 0) then
		MRTSkillReagentLabel:Show();
	else
		MRTSkillReagentLabel:Hide();
	end
	for i=1, numReagents, 1 do
		local reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(skillID, i);
		local reagent = _G["MRTSkillReagent"..i]
		local name = _G["MRTSkillReagent"..i.."Name"];
		local count = _G["MRTSkillReagent"..i.."Count"];
		if ( not reagentName or not reagentTexture ) then
			reagent:Hide();
		else
			reagent:Show();
			SetItemButtonTexture(reagent, reagentTexture);
			name:SetText(reagentName);
			-- Grayout items
			if ( playerReagentCount < reagentCount ) then
				SetItemButtonTextureVertexColor(reagent, 0.5, 0.5, 0.5);
				name:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
				craftable = nil;
			else
				SetItemButtonTextureVertexColor(reagent, 1.0, 1.0, 1.0);
				name:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			end
			if ( playerReagentCount >= 100 ) then
				playerReagentCount = "*";
			end
			count:SetText(playerReagentCount.." /"..reagentCount);
		end
	end
	-- Place reagent label
	local reagentToAnchorTo = numReagents;
	if ( (numReagents > 0) and (mod(numReagents, 2) == 0) ) then
		reagentToAnchorTo = reagentToAnchorTo - 1;
	end
	-- Hide unused reagents
	for i=numReagents + 1, MAX_TRADE_SKILL_REAGENTS, 1 do
		_G["MRTSkillReagent"..i]:Hide();
	end
	
	-- Tools
	local spellFocus = BuildColoredListString(GetTradeSkillTools(skillID));
	if ( spellFocus ) then
		MRTSkillRequirementLabel:Show();
		MRTSkillRequirementText:SetText(spellFocus);
	else
		MRTSkillRequirementLabel:Hide();
		MRTSkillRequirementText:SetText("");
	end
	
	-- Description
	if ( GetTradeSkillDescription(skillID) ) then
		MRTSkillDescription:SetText(GetTradeSkillDescription(skillID))
		MRTSkillReagentLabel:SetPoint("TOPLEFT", "MRTSkillDescription", "BOTTOMLEFT", 0, -10);
	else
		MRTSkillDescription:SetText(" ");
		MRTSkillReagentLabel:SetPoint("TOPLEFT", "MRTSkillDescription", "TOPLEFT", 0, 0);
	end
	
	-- Reset the number of items to be created
	MRTSkillInputBox:SetNumber(GetTradeskillRepeatCount());
	
	--Hide inapplicable buttons if we are inspecting. Otherwise show them
	if ( IsTradeSkillLinked() ) then
		MRTSkillCreateButton:Hide();
		MRTSkillCreateAllButton:Hide();
		MRTSkillDecrementButton:Hide();
		MRTSkillInputBox:Hide();
		MRTSkillIncrementButton:Hide();
	else
		--Change button names and show/hide them depending on if this tradeskill creates an item or casts something
		if ( not altVerb ) then
			--Its an item with 'Create'
			MRTSkillCreateAllButton:Show();
			MRTSkillDecrementButton:Show();
			MRTSkillInputBox:Show();
			MRTSkillIncrementButton:Show();
		else
			--Its something else
			MRTSkillCreateAllButton:Hide();
			MRTSkillDecrementButton:Hide();
			MRTSkillInputBox:Hide();
			MRTSkillIncrementButton:Hide();
		end
		
		MRTSkillCreateButton:SetText(altVerb or CREATE);
		MRTSkillCreateButton:Show();
    end

	MRTSkillWindow.numAvailable = numAvailable;
end

function MRTSkillWindow:Update()
	if( not MRTSkillFrame:IsVisible() ) then
		return;
	end

	-- Update Scan
	MRTSkillWindow:ParseSkillList();
	
	-- Update Display
	MRTSkillWindow:UpdateHeader();
	MRTSkillWindow:UpdateCategories();
	MRTSkillWindow:UpdateSkillList();
	MRTSkillWindow:SetSkillSelection(MRTSkillWindow.selectedSkillButton, MRTSkillWindow.selectedSkill);
end

function MRTSkillWindow:UpdateHeader()
	local name, rank, maxRank = GetTradeSkillLine();

	-- Title
	MRTSkillFrameTitleText:SetFormattedText(TRADE_SKILL_TITLE, name);
	
	-- Link Button
	if ( IsTradeSkillLinked() ) then
		MRTSkillLinkButton:Hide();
	else
		if ( GetTradeSkillListLink() ) then
			MRTSkillLinkButton:Show();
		else
			MRTSkillLinkButton:Hide();
		end
	end
	
	-- Rank Bar
	MRTSkillRankFrame:SetStatusBarColor(0.0, 0.0, 1.0, 0.5);
	MRTSkillRankFrameBackground:SetVertexColor(0.0, 0.0, 0.75, 0.5);
	MRTSkillRankFrame:SetMinMaxValues(0, maxRank);
	MRTSkillRankFrame:SetValue(rank);
	MRTSkillRankFrameSkillRank:SetText(rank.."/"..maxRank);
	
	-- Search Bar
	if ( rank < 75 ) and ( not IsTradeSkillLinked() ) then
		MRTSkillFrameEditBox:Hide();
		SetTradeSkillItemNameFilter("");	--In case they are switching from an inspect WITH a filter directly to their own without.
	else
		MRTSkillFrameEditBox:Show();
	end
end

function MRTSkillWindow:UpdateFilter() 
	local subclassFilter = 0;
	local invslotFilter = 0;

	if( self.filterSelection ~= nil ) then
		if( self.filterSelection.filterType == "invslot" ) then
			invslotFilter = MRTSkillWindow.filterSelection.filterIndex;
		elseif( self.filterSelection.filterType == "category" ) then
			subclassFilter = MRTSkillWindow.filterSelection.filterIndex;
		end
	end

	SetTradeSkillSubClassFilter(subclassFilter, 1, 1);
	SetTradeSkillInvSlotFilter(invslotFilter, 1, 1);
end

function MRTSkillWindow:UpdateCategories()
	if(MRTSkillWindow.filters == nil) then
		return;
	end
	
	-- Initialize the list of open filters
	OPEN_FILTER_LIST = {};

	local numGroups = getn(MRTSkillWindow.filters);
	for i=1, numGroups do
		local item = MRTSkillWindow.filters[i];
		if( MRTSkillWindow.filterCategory == item ) then
			tinsert(OPEN_FILTER_LIST, {item.title, "class", item, true});
			local numSubgroups = getn(item.subgroups);
			for j=1, numSubgroups do
				local subgroup = item.subgroups[j];
				if( MRTSkillWindow.filterSelection == subgroup ) then
					tinsert(OPEN_FILTER_LIST, {subgroup.title, "subclass", subgroup, true});			
				else
					tinsert(OPEN_FILTER_LIST, {subgroup.title, "subclass", subgroup, nil});							
				end
			end
		else
			tinsert(OPEN_FILTER_LIST, {item.title, "class", item, nil});			
		end
	end
	
	-- ScrollFrame update
	FauxScrollFrame_Update(MRTSkillFilterScrollFrame, getn(OPEN_FILTER_LIST), NUM_FILTERS_TO_DISPLAY, MRTRADER_TRADE_SKILL_FILTER_HEIGHT);
	local filterIndex = FauxScrollFrame_GetOffset(MRTSkillFilterScrollFrame) ;
	
	-- Display the list of open filters
	local button, index, info, isLast;
	index = FauxScrollFrame_GetOffset(MRTSkillFilterScrollFrame);
	for i=1, NUM_FILTERS_TO_DISPLAY do
		button = _G["MRTSkillFilterButton"..i];
		if ( getn(OPEN_FILTER_LIST) > NUM_FILTERS_TO_DISPLAY ) then
			button:SetWidth(136);
		else
			button:SetWidth(156);
		end

		index = index + 1;
		if ( index <= getn(OPEN_FILTER_LIST) ) then
			info = OPEN_FILTER_LIST[index];
			if ( info ) then
				MRTUIUtils_FilterButton_SetType(button, info[2], info[1], info[5]);
				button.filterRef = info[3];
				if ( info[4] ) then
					button:LockHighlight();
				else
					button:UnlockHighlight();
				end
				button:Show();
			end
		else
			button:Hide();
		end
	end
end

function MRTSkillWindow:UpdateSkillList()
	local skillList = MRTSkillWindow:GetSkillList();
	if( skillList == nil ) then
		return;
	end
	
	local numTradeSkills = getn(skillList);

	-- If we have no filter of any kind, then we need to empty the skill list
	if( MRTSkillWindow.filterSelection == nil ) then
		numTradeSkills = 0;
	end

	-- ScrollFrame update
	FauxScrollFrame_Update(MRTSkillListScrollFrame, numTradeSkills, TRADE_SKILLS_DISPLAYED, MRTRADER_TRADE_SKILL_HEIGHT, nil, nil, nil, MRTSkillHighlightFrame, 293, 316 );
	local skillIndex = FauxScrollFrame_GetOffset(MRTSkillListScrollFrame);
	local skillHighlighted = false;
	
	for i=1, TRADE_SKILLS_DISPLAYED do
		skillIndex = skillIndex + 1;
			
		skillButton = _G["MRTSkillButton"..i];
		skillButtonText = _G["MRTSkillButton"..i.."Text"];
		skillButtonCount = _G["MRTSkillButton"..i.."Count"];
		if( skillIndex <= numTradeSkills ) then
			local skillName, skillType, numAvailable = GetTradeSkillInfo(skillList[skillIndex]);
			skillButton:SetWidth(323);
			
			local color = TradeSkillTypeColor[skillType];
			if( color ) then
				skillButton:SetNormalFontObject(color.font);
				skillButtonCount:SetVertexColor(color.r, color.g, color.b);
				skillButton.r = color.r;
				skillButton.g = color.g;
				skillButton.b = color.b;
			end
			
			local skillNamePrefix = "";
			local skillNameSuffix = "";
			if ( ENABLE_COLORBLIND_MODE == "1" ) then
				skillNamePrefix = TradeSkillTypePrefix[skillType] or " ";
			end
			
			skillButton:SetID(skillList[skillIndex]);
			skillButton:Show();
			MRTUIUtils_SkillOnShow(skillButton);
			
			skillButton:SetNormalTexture("");
			_G["MRTSkillButton"..i.."Highlight"]:SetTexture("");
			
			if( numAvailable > 0 ) then
				skillButtonCount:SetText("["..numAvailable.."]");
				MRTSkillFrameDummyString:SetText(skillName);
				nameWidth = MRTSkillFrameDummyString:GetWidth();
				countWidth = skillButtonCount:GetWidth();
				skillButtonText:SetText(skillName);
				if ( nameWidth + 2 + countWidth > TRADE_SKILL_TEXT_WIDTH ) then
					skillButtonText:SetWidth(TRADE_SKILL_TEXT_WIDTH-2-countWidth);
				else
					skillButtonText:SetWidth(0);
				end
			else
				skillButton:SetText(skillNamePrefix..skillName..skillNameSuffix);
				skillButtonText:SetWidth(TRADE_SKILL_TEXT_WIDTH);
				skillButtonCount:SetText(skillCountPrefix);	
			end
			
			-- Place the highlight and lock the highlight state
			if ( MRTSkillWindow.selectedSkill == skillList[skillIndex] ) then
				MRTSkillHighlightFrame:SetPoint("TOPLEFT", "MRTSkillButton"..i, "TOPLEFT", 0, 0);
				MRTSkillHighlightFrame:Show();
				skillButtonCount:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
				skillButton:LockHighlight();
				skillButton.isHighlighted = true;
				skillHighlighted = true;
			else
				skillButton:UnlockHighlight();
				skillButton.isHighlighted = false;
			end
		else
			skillButton:Hide();
			MRTUIUtils_SkillOnHide(skillButton);
		end
	end
	
	if( skillHighlighted == false ) then
		MRTSkillHighlightFrame:Hide();
	end
end