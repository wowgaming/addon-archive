-------------------------------------------------------------------------------
-- MrTrader
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------

local MenuSpacer = {
	text = "",
	isTitle = true,
}

local CloseButton = {
	text = MRTLoc["Close"];
	func = function() CloseDropDownMenus() end;
}

function MrTrader:InitializeMenu()
	local LDB = LibStub("LibDataBroker-1.1", true);
	if LDB then
		self.dropdown = CreateFrame("Frame", "MrTraderMenu", UIParent, "UIDropDownMenuTemplate");
		UIDropDownMenu_SetWidth(self.dropdown, 140);
	
		self.launcherobj = LDB:NewDataObject("MrTrader", {
	    	type = "launcher",
			label = "MrTrader",
	    	icon = "Interface\\Addons\\MrTrader\\MrTrader",
	    	OnClick = function(clickedframe, button)
	        	MrTrader:OpenMenu(clickedframe, button);
	    	end,
			OnTooltipShow = function(tip)
				if not tip or not tip.AddLine then return end
				tip:AddLine(MRTLoc["MrTrader"])
				tip:AddLine(MRTLoc["Click to open menu."], 1, 1, 1)
			end,
		})
	end
end

function MrTrader:OpenMenu(frame, button)
	if button == "LeftButton" then
		local func = function(menu, level) MrTrader:InitializeMenuContent(menu, level) end;
		UIDropDownMenu_Initialize(self.dropdown, func, "MENU");
		-- UIDropDownMenu_SetAnchor(self.dropdown, 0, 0, "TOPRIGHT", frame, "TOPLEFT"); 
		ToggleDropDownMenu(1, nil, self.dropdown, frame, 0, 0);
		-- Menu:Open(frame, "children", function() MrTrader:UpdateMenu() end);
	end
end

function MrTrader:InitializeMenuContent(menu, level)
	MrTrader:QuerySkills();
	local skillTable = MrTrader:GetSkillTable();
	local characterCount = MrTrader:TableSize(skillTable);
	local currentPlayer = UnitName("player");
	local currentFaction = UnitFactionGroup("player");
	local info = {};
	
	if( level == 1 ) then
		if( skillTable[currentPlayer] ) then
			characterCount = characterCount - 1;
			
			info.text = MRTLoc["Tradeskills"];
			info.isTitle = 1;
			UIDropDownMenu_AddButton(info, level);
		
			wipe(info);
			for skillID, skillLink in pairs(skillTable[currentPlayer]) do
				local skillName, _, skillIcon = GetSpellInfo(skillID);
				if( skillName ) then
					local tooltip = MRTLoc["Click to open tradeskill window."];
					if skillLink then
						tooltip = MRTLoc["Click to open tradeskill window. Shift-click to link tradeskill."];
					end
			
					info.text = skillName;
					info.icon = skillIcon;
					info.tooltipTitle = skillName;
					info.tooltipText = tooltip;
					info.func = function() MrTrader:OpenLink(skillName, skillLink, true); end;
					UIDropDownMenu_AddButton(info, level);
				end
			end
		
			UIDropDownMenu_AddButton(MenuSpacer, level);
			if MrTrader:CharacterIsIgnored(currentPlayer) then
				wipe(info);
				info.text = MRTLoc["Unignore"];
				info.tooltipTitle = MRTLoc["Unignore"];
				info.tooltipText = MRTLoc["Unignore this character and show on all other characters."];
				info.func = function() MrTrader:UnignoreCharacter(currentPlayer); end;
				UIDropDownMenu_AddButton(info, level);
					
				UIDropDownMenu_AddButton(MenuSpacer, level);	
			end
		end
		
		if( characterCount > 0 ) then
			wipe(info);
			info.text = MRTLoc["Tradeskills"];
			info.isTitle = 1;
			UIDropDownMenu_AddButton(info, level);
			
			wipe(info);
			for playerName, skillList in pairs(skillTable) do
				-- Find out if we need to display this character, and if it is in the same faction
				local sameFaction = true;
				if skillList["faction"] and skillList["faction"] ~= currentFaction then
					sameFaction = false;
				end
				local shouldDisplay = sameFaction or self.db.profile.showOppositeFaction;
				local shouldDisplay = shouldDisplay and not MrTrader:CharacterIsIgnored(playerName);
				local shouldDisplay = shouldDisplay and (playerName ~= currentPlayer);

				if( shouldDisplay ) then
					info.text = playerName;
					info.value = playerName;
					info.hasArrow = true;
					if( not sameFaction ) then
						info.colorCode = "|cFFFF6666";
					else
						info.colorCode = nil;
					end
					UIDropDownMenu_AddButton(info, level);
				end
			end
			
			UIDropDownMenu_AddButton(MenuSpacer, level);
		end

		UIDropDownMenu_AddButton(CloseButton, level);
	elseif( level == 2 ) then
		local playerName = UIDROPDOWNMENU_MENU_VALUE;
		
		for skillID, skillLink in pairs(skillTable[playerName]) do
			local showSkill = false;
			local skillName, _, skillIcon = GetSpellInfo(skillID);
			local tooltip = MRTLoc["Tradeskill cannot be linked, and is unavailable."];
			if skillLink then
				tooltip = MRTLoc["Click to open tradeskill window. Shift-click to link tradeskill."];
			end
			if skillName then
				showSkill = self.tradeskills[skillID].primary or self.db.profile.showSecondarySkills;
			end
			if skillName and showSkill then
				info.text = skillName;
				info.tooltipTitle = skillName;
				info.tooltipText = tooltip;
				info.icon = skillIcon;
				info.disabled = not skillLink;
				info.func = function() 
								MrTrader:OpenLink(skillName, skillLink, false); 
								CloseDropDownMenus();
							end;
				UIDropDownMenu_AddButton(info, level);
			end
		end

		UIDropDownMenu_AddButton(MenuSpacer, level);

		wipe(info);
		info.text = MRTLoc["Remove"];
		info.tooltipTitle = MRTLoc["Remove"];
		info.tooltipText = MRTLoc["Click to remove from the list, shift-click to ignore this character permanently."];
		info.func = function()
				if IsShiftKeyDown() then
					MrTrader:IgnoreCharacter(playerName);
				else
					MrTrader:RemoveCharacter(playerName);
				end
			end;
		UIDropDownMenu_AddButton(info, level);
	end
end

function MrTrader:OpenLink(name, link, isCurrentPlayer)
	if IsShiftKeyDown() then
		if not ChatEdit_InsertLink(link) then
			ChatFrameEditBox:Show();
			ChatEdit_InsertLink(link);
		end
	else
		if isCurrentPlayer then
			CastSpellByName(name);
		else
			-- Open link via chat window
			local chatLink = string.gsub(link, "|", ":");
			local _, startIndex = string.find(chatLink, ":H");
			local endIndex = string.find(chatLink, ":h");
			chatLink = string.sub(chatLink, startIndex + 1, endIndex - 1);
			ChatFrame_OnHyperlinkShow(nil, chatLink, link, "LeftButton");
		end
	end
end