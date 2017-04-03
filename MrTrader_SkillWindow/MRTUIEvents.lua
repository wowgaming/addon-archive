-------------------------------------------------------------------------------
-- MrTrader 
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------

function MRTSkillWindow_OnSkillClick(self, button)
	if ( IsShiftKeyDown() ) then
		HandleModifiedItemClick(GetTradeSkillRecipeLink(self:GetID()));
	else
		MRTSkillWindow:SelectSkill(self, button);
	end
end

function MRTSkillWindow_OnFilterClick(self, button)
	if(button == "LeftButton") then
		MRTSkillWindow:SelectFilter(self.filterRef);
	elseif(button == "RightButton") then
		MRTSkillContext:DisplayFilterContext(self);
	end
end

function MRTSkillWindow_OnShow()
	-- Empty
end

function MRTSkillWindow_OnHide()
	CloseTradeSkill();
	MRTNewCategoryFrame:Hide();
end

function MRTSkillWindow_OnDecrementClick()
	if ( MRTSkillInputBox:GetNumber() > 0 ) then
		MRTSkillInputBox:SetNumber(MRTSkillInputBox:GetNumber() - 1);
	end
end

function MRTSkillWindow_OnIncrementClick()
	if ( MRTSkillInputBox:GetNumber() < 100 ) then
		MRTSkillInputBox:SetNumber(MRTSkillInputBox:GetNumber() + 1);
	end
end

function MRTSkillWindow_OnQueueToggle(checkbutton, button)
	if( checkbutton:GetChecked() ) then
		MRTQueueWindow:Show();
	else
		MRTQueueWindow:Close();
	end
end

function MRTSkillWindow_OnEnterSkillIcon(item)
	if ( strmatch(item:GetName(), "MRTSkillButton(%d+)") ) then
		if( MrTrader:ShouldDisplaySkillListTooltip() ) then
			GameTooltip:SetOwner(MRTSkillFrame);
			--GameTooltip_SetDefaultAnchor(GameTooltip, item);
			--GameTooltip:SetOwner(item, "ANCHOR_BOTTOMRIGHT");
			GameTooltip:SetHyperlink(GetTradeSkillRecipeLink(item:GetID()));
			GameTooltip:ClearAllPoints();
			GameTooltip:SetPoint("TOPLEFT", MRTSkillFrame, "TOPRIGHT", 0, -10);
			--GameTooltip:SetTradeSkillItem(item:GetID());
		end
	elseif ( MRTSkillWindow.selectedSkill ~= 0 ) then
		GameTooltip:SetOwner(item, "ANCHOR_RIGHT");
		GameTooltip:SetTradeSkillItem(MRTSkillWindow.selectedSkill);
	end
	CursorUpdate(item);
end

function MRTSkillWindow_OnSearchTextChange(field)
	local text = field:GetText();
	
	if ( text == SEARCH ) then
		SetTradeSkillItemNameFilter("");
		return;
	end

	local minLevel, maxLevel;
	local approxLevel = strmatch(text, "^~(%d+)");
	if ( approxLevel ) then
		minLevel = approxLevel - 2;
		maxLevel = approxLevel + 2;
	else
		minLevel, maxLevel = strmatch(text, "^(%d+)%s*-*%s*(%d*)$");
	end
	if ( minLevel ) then
		if ( maxLevel == "" or maxLevel < minLevel ) then
			maxLevel = minLevel;
		end
		SetTradeSkillItemNameFilter(nil);
		SetTradeSkillItemLevelFilter(minLevel, maxLevel);
	else
		SetTradeSkillItemLevelFilter(0, 0);
		SetTradeSkillItemNameFilter(text);
	end	
	
	MRTSkillWindow_Update();
end

function MRTSkillWindow_Update()
	MRTSkillWindow:ParseSkillList();
	MRTSkillWindow:UpdateSkillList();
end

function MRTSkillWindow_UpdateFilters()
	MRTSkillWindow:UpdateCategories();
end

function MRTSkillWindow_UpdateHeaders()
	MRTSkillWindow:UpdateHeader();
end

-----
-- New Category Dialog
-----
function MRTNewCategoryFrame_Cancel()
	MRTNewCategoryFrame:Hide();
end

function MRTNewCategoryFrame_Okay()
	local categoryName = MRTNewCategoryFrameCategoryName:GetText();

	if( categoryName == "" or categoryName == nil ) then
		return;
	end

	local tradeskillSpellID = MrTrader:MatchPartialCraftSkillName(GetTradeSkillLine());
	local favorites = MrTrader:GetFavoritesForSkill(tradeskillSpellID);
	
	if( favorites ~= nil and favorites[categoryName] == nil ) then
		MrTrader:AddFavoriteCategoryToSkill(tradeskillSpellID, categoryName);

		if( MRTNewCategoryFrame.referenceSkill ) then
			-- Set the reference skill up in the new category			
			local skillSpellID = MrTrader:GetSpellIDForRecipe(GetTradeSkillRecipeLink(MRTNewCategoryFrame.referenceSkill));
			MrTrader:AddFavoriteToSkill(tradeskillSpellID, categoryName, skillSpellID);
		end
	end
	
	MRTSkillWindow:PopulateFilterTree();
	MRTSkillWindow:Update();
	MRTNewCategoryFrame:Hide();
end