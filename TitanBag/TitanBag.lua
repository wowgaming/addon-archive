-- **************************************************************************
-- * TitanBag.lua
-- *
-- * By: TitanMod, Dark Imakuni, Adsertor and the Titan Development Team
-- *     (HonorGoG, jaketodd422, joejanko, Lothayer, Tristanian)
-- **************************************************************************

-- ******************************** Constants *******************************
local _G = getfenv(0);
local TITAN_BAG_ID = "Bag";
local TITAN_BAG_THRESHOLD_TABLE = {
     Values = { 0.5, 0.75 },
     Colors = { GREEN_FONT_COLOR, NORMAL_FONT_COLOR, RED_FONT_COLOR },
}
local updateTable = {TITAN_BAG_ID, TITAN_PANEL_UPDATE_BUTTON} ;
-- ******************************** Variables *******************************
local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true)
local AceTimer = LibStub("AceTimer-3.0")
local BagTimer
-- ******************************** Functions *******************************

-- **************************************************************************
-- NAME : TitanPanelBagButton_OnLoad()
-- DESC : Registers the plugin upon it loading
-- **************************************************************************
function TitanPanelBagButton_OnLoad(self)
	self.registry = {
		id = TITAN_BAG_ID,
		--          builtIn = 1,
		category = "Built-ins",
		version = TITAN_VERSION,
		menuText = L["TITAN_BAG_MENU_TEXT"],
		buttonTextFunction = "TitanPanelBagButton_GetButtonText", 
		tooltipTitle = L["TITAN_BAG_TOOLTIP"],
		tooltipTextFunction = "TitanPanelBagButton_GetTooltipText", 
		icon = "Interface\\AddOns\\TitanBag\\TitanBag",
		iconWidth = 16,
		controlVariables = {
			ShowIcon = true,
			ShowLabelText = true,
			ShowRegularText = false,
			ShowColoredText = true,
			DisplayOnRightSide = false
		},
		savedVariables = {
			ShowUsedSlots = 1,
			ShowDetailedInfo = false,
			CountAmmoPouchSlots = false,
			CountShardBagSlots = false,
			CountProfBagSlots = false,
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredText = 1,               
		}
	};     

	self:RegisterEvent("PLAYER_ENTERING_WORLD");
end

-- **************************************************************************
-- NAME : TitanPanelBagButton_OnEvent()
-- DESC : Parse events registered to plugin and act on them
-- **************************************************************************
function TitanPanelBagButton_OnEvent(self, event, ...)
	if (event == "PLAYER_ENTERING_WORLD") and (not self:IsEventRegistered("BAG_UPDATE")) then
		self:RegisterEvent("BAG_UPDATE");          
	end

	if event == "BAG_UPDATE" then
		-- Create the only when the event is active
		self:SetScript("OnUpdate", TitanPanelBagButton_OnUpdate)
	end
--[[
	if event == "BAG_UPDATE" then
		-- Throw a timer to update the button 3 seconds after the initial event to avoid "spammy" events     	
		if not BagTimer then     		     		     			
			BagTimer = AceTimer.ScheduleTimer("TitanPanelBag", TitanPanelBagButton_OnUpdate, 3, updateTable)
		end
	end
--]]
end

function TitanPanelBagButton_OnUpdate(self)
	-- update the button
	TitanPanelPluginHandle_OnUpdate(updateTable)
	-- remove until the next bag event
	self:SetScript("OnUpdate", nil)
end
--[[
function TitanPanelBagButton_OnUpdate(table)
	TitanPanelPluginHandle_OnUpdate(table)	    
	AceTimer.CancelAllTimers("TitanPanelBag")
	BagTimer = nil; 
end
--]]
-- **************************************************************************
-- NAME : TitanPanelBagButton_OnClick(button)
-- DESC : Opens all bags on a LeftClick
-- VARS : button = value of action
-- **************************************************************************
function TitanPanelBagButton_OnClick(self, button)
	if (button == "LeftButton") then
		OpenAllBags();
	end
end

-- **************************************************************************
-- NAME : TitanPanelBagButton_GetButtonText(id)
-- DESC : Calculate bag space logic then display data on button
-- VARS : id = button ID
-- **************************************************************************
function TitanPanelBagButton_GetButtonText(id)
	local button, id = TitanUtils_GetButton(id, true);
	local totalSlots, usedSlots, availableSlots;
	local useme;

	totalSlots = 0;
	usedSlots = 0;
	for bag = 0, 4 do
		if TitanGetVar(TITAN_BAG_ID, "CountAmmoPouchSlots") and TitanBag_IsAmmoPouch(GetBagName(bag)) then
			useme = 1;
		elseif TitanGetVar(TITAN_BAG_ID, "CountShardBagSlots") and TitanBag_IsShardBag(GetBagName(bag)) then
			useme = 1;
		elseif TitanGetVar(TITAN_BAG_ID, "CountProfBagSlots") and TitanBag_IsProfBag(GetBagName(bag)) then
			useme = 1;
		elseif not TitanBag_IsAmmoPouch(GetBagName(bag)) and not TitanBag_IsShardBag(GetBagName(bag)) 
			and not TitanBag_IsProfBag(GetBagName(bag)) then
			useme = 1;
		else
			useme = 0;
		end

		if useme == 1 then
			local size = GetContainerNumSlots(bag);
			if (size and size > 0) then
				totalSlots = totalSlots + size;
				for slot = 1, size do
					if (GetContainerItemInfo(bag, slot)) then
						usedSlots = usedSlots + 1;
					end
				end
			end
		end
	end
	availableSlots = totalSlots - usedSlots;

	local bagText, bagRichText, color;
	if (TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots")) then
		bagText = format(L["TITAN_BAG_FORMAT"], usedSlots, totalSlots);
	else
		bagText = format(L["TITAN_BAG_FORMAT"], availableSlots, totalSlots);
	end

	if ( TitanGetVar(TITAN_BAG_ID, "ShowColoredText") ) then     
		color = TitanUtils_GetThresholdColor(TITAN_BAG_THRESHOLD_TABLE, usedSlots / totalSlots);
		bagRichText = TitanUtils_GetColoredText(bagText, color);
	else
		bagRichText = TitanUtils_GetHighlightText(bagText);
	end

	return L["TITAN_BAG_BUTTON_LABEL"], bagRichText;
end

-- **************************************************************************
-- NAME : TitanPanelBagButton_GetTooltipText()
-- DESC : Display tooltip text
-- **************************************************************************
function TitanPanelBagButton_GetTooltipText()
	local totalSlots, usedSlots, availableSlots;
	local returnstring = "";

	if TitanGetVar(TITAN_BAG_ID, "ShowDetailedInfo") then
		returnstring = "\n";
		if TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots") then
			returnstring = returnstring..TitanUtils_GetNormalText(L["TITAN_BAG_MENU_TEXT"])
				..":\t"..TitanUtils_GetNormalText(L["TITAN_BAG_USED_SLOTS"])..":\n";
		else
			returnstring = returnstring..TitanUtils_GetNormalText(L["TITAN_BAG_MENU_TEXT"])
				..":\t"..TitanUtils_GetNormalText(L["TITAN_BAG_FREE_SLOTS"])..":\n";
		end
		 
		for bag = 0, 4 do
			totalSlots = GetContainerNumSlots(bag) or 0;
			availableSlots = GetContainerNumFreeSlots(bag) or 0;
			usedSlots = totalSlots - availableSlots;
			local itemlink  = bag > 0 and GetInventoryItemLink("player", ContainerIDToInventoryID(bag)) 
				or TitanUtils_GetHighlightText(L["TITAN_BAG_BACKPACK"]).. FONT_COLOR_CODE_CLOSE;


			if itemlink then
				itemlink = string.gsub( itemlink, "%[", "" );
				itemlink = string.gsub( itemlink, "%]", "" );
			end

			if bag > 0 and not GetInventoryItemLink("player", ContainerIDToInventoryID(bag)) then
				itemlink = nil;
			end

			local bagText, bagRichText, color;
			if (TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots")) then
				bagText = format(L["TITAN_BAG_FORMAT"], usedSlots, totalSlots);
			else
				bagText = format(L["TITAN_BAG_FORMAT"], availableSlots, totalSlots);
			end

			if ( TitanGetVar(TITAN_BAG_ID, "ShowColoredText") ) then     
				if totalSlots == 0 then
					color = TitanUtils_GetThresholdColor(TITAN_BAG_THRESHOLD_TABLE, 1 );
				else
					color = TitanUtils_GetThresholdColor(TITAN_BAG_THRESHOLD_TABLE, usedSlots / totalSlots);
				end
				bagRichText = TitanUtils_GetColoredText(bagText, color);
			else
				bagRichText = TitanUtils_GetHighlightText(bagText);
			end

			if itemlink then
				returnstring = returnstring..itemlink.."\t"..bagRichText.."\n";				
			end
		end
		returnstring = returnstring.."\n";
	end
	return returnstring..TitanUtils_GetGreenText(L["TITAN_BAG_TOOLTIP_HINTS"]);
end

-- **************************************************************************
-- NAME : TitanPanelRightClickMenu_PrepareBagMenu()
-- DESC : Display rightclick menu options
-- **************************************************************************
function TitanPanelRightClickMenu_PrepareBagMenu()
		 local info
		 
		 -- level 2
	if _G["UIDROPDOWNMENU_MENU_LEVEL"] == 2 then
		if _G["UIDROPDOWNMENU_MENU_VALUE"] == "Options" then
			TitanPanelRightClickMenu_AddTitle(L["TITAN_PANEL_MENU_OPTIONS"], _G["UIDROPDOWNMENU_MENU_LEVEL"])
			info = {};
			info.text = L["TITAN_BAG_MENU_SHOW_USED_SLOTS"];
			info.func = TitanPanelBagButton_ShowUsedSlots;
			info.checked = TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots");
			UIDropDownMenu_AddButton(info, _G["UIDROPDOWNMENU_MENU_LEVEL"]);

			info = {};
			info.text = L["TITAN_BAG_MENU_SHOW_AVAILABLE_SLOTS"];
			info.func = TitanPanelBagButton_ShowAvailableSlots;
			info.checked = TitanUtils_Toggle(TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots"));
			UIDropDownMenu_AddButton(info, _G["UIDROPDOWNMENU_MENU_LEVEL"]);
		  
			info = {};
			info.text = L["TITAN_BAG_MENU_SHOW_DETAILED"];
			info.func = TitanPanelBagButton_ShowDetailedInfo;
			info.checked = TitanGetVar(TITAN_BAG_ID, "ShowDetailedInfo");
			UIDropDownMenu_AddButton(info, _G["UIDROPDOWNMENU_MENU_LEVEL"]);
		end
		if _G["UIDROPDOWNMENU_MENU_VALUE"] == "IgnoreCont" then
			TitanPanelRightClickMenu_AddTitle(L["TITAN_BAG_MENU_IGNORE_SLOTS"], _G["UIDROPDOWNMENU_MENU_LEVEL"])
			info = {};
			info.text = L["TITAN_BAG_MENU_IGNORE_AMMO_POUCH_SLOTS"];
			info.func = TitanPanelBagButton_ToggleIgnoreAmmoPouchSlots;
			info.checked = TitanUtils_Toggle(TitanGetVar(TITAN_BAG_ID, "CountAmmoPouchSlots"));
			UIDropDownMenu_AddButton(info, _G["UIDROPDOWNMENU_MENU_LEVEL"]);

			info = {};
			info.text = L["TITAN_BAG_MENU_IGNORE_SHARD_BAGS_SLOTS"];
			info.func = TitanPanelBagButton_ToggleIgnoreShardBagSlots;
			info.checked = TitanUtils_Toggle(TitanGetVar(TITAN_BAG_ID, "CountShardBagSlots"));
			UIDropDownMenu_AddButton(info, _G["UIDROPDOWNMENU_MENU_LEVEL"]);

			info = {};
			info.text = L["TITAN_BAG_MENU_IGNORE_PROF_BAGS_SLOTS"];
			info.func = TitanPanelBagButton_ToggleIgnoreProfBagSlots;
			info.checked = TitanUtils_Toggle(TitanGetVar(TITAN_BAG_ID, "CountProfBagSlots"));
			UIDropDownMenu_AddButton(info, _G["UIDROPDOWNMENU_MENU_LEVEL"]);
		end
		return
	end
	
	-- level 1
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_BAG_ID].menuText);

	info = {};
	info.text = L["TITAN_PANEL_MENU_OPTIONS"];
	info.value = "Options"
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = L["TITAN_BAG_MENU_IGNORE_SLOTS"];
	info.value = "IgnoreCont"
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();     
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_BAG_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_BAG_ID);
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_BAG_ID);
	TitanPanelRightClickMenu_AddSpacer();     
	TitanPanelRightClickMenu_AddCommand(L["TITAN_PANEL_MENU_HIDE"], TITAN_BAG_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

-- **************************************************************************
-- NAME : TitanPanelBagButton_ShowUsedSlots()
-- DESC : Set option to show used slots
-- **************************************************************************
function TitanPanelBagButton_ShowUsedSlots()
	TitanSetVar(TITAN_BAG_ID, "ShowUsedSlots", 1);
	TitanPanelButton_UpdateButton(TITAN_BAG_ID);
end

-- **************************************************************************
-- NAME : TitanPanelBagButton_ShowAvailableSlots()
-- DESC : Set option to show available slots
-- **************************************************************************
function TitanPanelBagButton_ShowAvailableSlots()
	TitanSetVar(TITAN_BAG_ID, "ShowUsedSlots", nil);
	TitanPanelButton_UpdateButton(TITAN_BAG_ID);
end

-- **************************************************************************
-- NAME : TitanPanelBagButton_ToggleIgnoreAmmoPouchSlots()
-- DESC : Set option to count ammo pouch slots
-- **************************************************************************
function TitanPanelBagButton_ToggleIgnoreAmmoPouchSlots()
	TitanToggleVar(TITAN_BAG_ID, "CountAmmoPouchSlots");
	TitanPanelButton_UpdateButton(TITAN_BAG_ID);
end

-- **************************************************************************
-- NAME : TitanPanelBagButton_ToggleIgnoreShardBagSlots()
-- DESC : Set option to count shard bag slots
-- **************************************************************************
function TitanPanelBagButton_ToggleIgnoreShardBagSlots()
	TitanToggleVar(TITAN_BAG_ID, "CountShardBagSlots");
	TitanPanelButton_UpdateButton(TITAN_BAG_ID);
end

-- **************************************************************************
-- NAME : TitanPanelBagButton_ToggleIgnoreProfBagSlots()
-- DESC : Set option to count profession bag slots
-- **************************************************************************
function TitanPanelBagButton_ToggleIgnoreProfBagSlots()
	TitanToggleVar(TITAN_BAG_ID, "CountProfBagSlots");
	TitanPanelButton_UpdateButton(TITAN_BAG_ID);
end


function TitanPanelBagButton_ShowDetailedInfo()
	TitanToggleVar(TITAN_BAG_ID, "ShowDetailedInfo");
end

-- **************************************************************************
-- NAME : TitanBag_IsAmmoPouch(name)
-- DESC : Test to see if bag is an ammo pouch
-- VARS : name = item name
-- **************************************************************************
function TitanBag_IsAmmoPouch(name)
	if (name) then
		for index, value in pairs(L["TITAN_BAG_AMMO_POUCH_NAMES"]) do
			if (string.find(name, value)) then
				return true;
			end
		end
	end
	return false;
end

-- **************************************************************************
-- NAME : TitanBag_IsShardBag(name)
-- DESC : Test to see if bag is a shard bag
-- VARS : name = item name
-- **************************************************************************
function TitanBag_IsShardBag(name)
	if (name) then
		for index, value in pairs(L["TITAN_BAG_SHARD_BAG_NAMES"]) do
			if (string.find(name, value)) then
				return true;
			end
		end
	end
	return false;
end

-- **************************************************************************
-- NAME : TitanBag_IsProfBag(name)
-- DESC : Test to see if bag is a profession bag
-- VARS : name = item name
-- **************************************************************************
function TitanBag_IsProfBag(name)
	if (name) then
		for index, value in pairs(L["TITAN_BAG_PROF_BAG_NAMES"]) do
			if (string.find(name, value, 1, true)) then
				return true;
			end
		end
	end
	return false;
end