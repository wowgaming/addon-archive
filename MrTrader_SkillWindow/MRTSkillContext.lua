-------------------------------------------------------------------------------
-- MrTrader 
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------

MRTSkillContext = {};

local MenuSpacer = {
	text = "",
	isTitle = true,
}

local CloseButton = {
	text = MRTLoc["Close"];
	func = function() CloseDropDownMenus() end;
}

function MRTSkillContext:DisplaySkillContext(dropdown, skillID)
	dropdown.skillID = skillID;
	
	local func = function(menu, level) MRTSkillContext:InitializeSkillContext(menu, level) end;
	UIDropDownMenu_Initialize(dropdown, func, "MENU");

	ToggleDropDownMenu(1, nil, dropdown, "cursor", 0, 0);
end

function MRTSkillContext:DisplayFilterContext(dropdown, filterRef)
	dropdown.filterRef = filterRef;
	
	local func = function(menu, level) MRTSkillContext:InitializeFilterContext(menu, level) end;
	UIDropDownMenu_Initialize(dropdown, func, "MENU");

	ToggleDropDownMenu(1, nil, dropdown, "cursor", 0, 0);
end

function MRTSkillContext:InitializeSkillContext(menu, level)
	if( menu.skillID == nil ) then
		return;
	end

	local skillIndex = menu.skillID;
	local skillName, _, numAvailable, _, altVerb = GetTradeSkillInfo(skillIndex);
	local info = {};
	
	info.text = skillName;
	info.isTitle = 1;
	UIDropDownMenu_AddButton(info, level);
	
	
	if( not IsTradeSkillLinked() ) then
		wipe(info);
		info.text = altVerb or CREATE;
		info.func = function()
						if ( (not PartialPlayTime()) and (not NoPlayTime()) ) then
							DoTradeSkill(skillIndex, 1);
							MRTSkillInputBox:ClearFocus();
						end
		   			end;
		UIDropDownMenu_AddButton(info, level);
		
		if( not altVerb ) then
			info.text = CREATE_ALL;
			info.func = function()
							if ( (not PartialPlayTime()) and (not NoPlayTime()) ) then
								MRTSkillInputBox:SetNumber(numAvailable);
								DoTradeSkill(skillIndex, numAvailable);
								MRTSkillInputBox:ClearFocus();
							end
						end;
			UIDropDownMenu_AddButton(info, level);
		end	
	end
	
	UIDropDownMenu_AddButton(MenuSpacer, level);
	
	wipe(info);
	info.text = MRTLoc["Favorite Groups"];
	info.isTitle = 1;
	UIDropDownMenu_AddButton(info, level);
	
	local skillSpellID = MrTrader:MatchPartialCraftSkillName(GetTradeSkillLine())
	local favorites = MrTrader:GetFavoritesForSkill(skillSpellID);
	
	wipe(info);
	if( favorites ) then
		for categoryName, categoryItems in pairs(favorites) do
			local skillSpell = MrTrader:GetSpellIDForRecipe(GetTradeSkillRecipeLink(skillIndex));
			local isIncluded = categoryItems[skillSpell] ~= nil;
			
			info.text = "  " .. categoryName;
			info.checked = isIncluded;
			info.keepShownOnClick = 1;
			info.func = function ()
							if( categoryItems[skillSpell] == nil ) then
								MrTrader:AddFavoriteToSkill(skillSpellID, categoryName, skillSpell);
							else
								MrTrader:DelFavoriteFromSkill(skillSpellID, categoryName, skillSpell);
							end
							
							MRTSkillWindow:Update();
						end;
			
			UIDropDownMenu_AddButton(info, level);
		end
	end
	
	wipe(info);
	info.text = MRTLoc["Add to New Favorite Group..."];
	info.func = function ()
					MRTNewCategoryFrame.referenceSkill = skillIndex;
					MRTNewCategoryFrame:Show();
				end;
	UIDropDownMenu_AddButton(info, level);
	
	UIDropDownMenu_AddButton(MenuSpacer, level);
	UIDropDownMenu_AddButton(CloseButton, level);
end

function MRTSkillContext:InitializeFilterContext(menu, level)
	if( menu.filterRef == nil ) then
		return;
	end
	
	local filter = menu.filterRef;
	local info = {};
	local hasItems = false;

	if( filter.title ) then
		info.text = filter.title;
		info.isTitle = 1;
		UIDropDownMenu_AddButton(info, level);
	end

	wipe(info);
	if( filter.filterType == "favorite" and filter.filterIndex == "__all" ) then
		hasItems = true;
		
		info.text = MRTLoc["New Favorite Group"];
		info.func = function()
						MRTNewCategoryFrame.referenceSkill = nil;
						MRTNewCategoryFrame:Show();
					end;
		UIDropDownMenu_AddButton(info, level);
	elseif( filter.filterType == "favorite" ) then
		hasItems = true;
		
		info.text = MRTLoc["Remove Favorite Group"];
		info.func = function()
						MrTrader:DelFavoriteCategoryFromSkill(MrTrader:MatchPartialCraftSkillName(GetTradeSkillLine()), filter.filterIndex);
		
						MRTSkillWindow:PopulateFilterTree();
						MRTSkillWindow:Update();
					end;
		UIDropDownMenu_AddButton(info, level);
	end

	if( hasItems ) then
		UIDropDownMenu_AddButton(MenuSpacer, level);
	end

	UIDropDownMenu_AddButton(CloseButton, level);
end