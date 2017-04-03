-- **************************************************************************
-- * TitanCoords.lua
-- *
-- * By: TitanMod, Dark Imakuni, Adsertor and the Titan Development Team
-- *     (HonorGoG, jaketodd422, joejanko, Lothayer, Tristanian)
-- **************************************************************************

-- ******************************** Constants *******************************
local _G = getfenv(0);
local TITAN_COORDS_ID = "Coords";
local OFFSET_X = 0.0022  --  0.0022;
local OFFSET_Y = -0.0262  --  -0.0262;
local cachedX = 0
local cachedY = 0
local updateTable = {TITAN_COORDS_ID, TITAN_PANEL_UPDATE_BUTTON};
-- ******************************** Variables *******************************
local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true)
local AceTimer = LibStub("AceTimer-3.0")
local CoordsTimer = nil;
-- ******************************** Functions *******************************

-- **************************************************************************
-- NAME : TitanPanelCoordsButton_OnLoad()
-- DESC : Registers the plugin upon it loading
-- **************************************************************************
function TitanPanelCoordsButton_OnLoad(self)
     self.registry = { 
          id = TITAN_COORDS_ID,
--          builtIn = 1,
			category = "Built-ins",
          version = TITAN_VERSION,
          menuText = L["TITAN_COORDS_MENU_TEXT"],
          buttonTextFunction = "TitanPanelCoordsButton_GetButtonText",
          tooltipTitle = L["TITAN_COORDS_TOOLTIP"],
          tooltipTextFunction = "TitanPanelCoordsButton_GetTooltipText",
          icon = "Interface\\AddOns\\TitanCoords\\TitanCoords",
          iconWidth = 16,
		controlVariables = {
			ShowIcon = true,
			ShowLabelText = true,
			ShowRegularText = false,
			ShowColoredText = true,
			DisplayOnRightSide = false
		},
          savedVariables = {
               ShowZoneText = 1,
               ShowCoordsOnMap = 1,
               ShowLocOnMiniMap = 1,
               ShowIcon = 1,
               ShowLabelText = 1,
               ShowColoredText = 1,
               CoordsFormat1 = 1,
               CoordsFormat2 = false,
               CoordsFormat3 = false
          }
     };

     self:RegisterEvent("ZONE_CHANGED");
     self:RegisterEvent("ZONE_CHANGED_INDOORS");
     self:RegisterEvent("ZONE_CHANGED_NEW_AREA");
     self:RegisterEvent("MINIMAP_ZONE_CHANGED");
     self:RegisterEvent("PLAYER_ENTERING_WORLD");
end

-- **************************************************************************
-- NAME : TitanPanelCoordsButton_OnShow()
-- DESC : Display button when plugin is visible
-- **************************************************************************
function TitanPanelCoordsButton_OnShow()
	SetMapToCurrentZone();
	TitanPanelCoords_HandleUpdater();
end

-- **************************************************************************
-- NAME : TitanPanelCoordsButton_OnHide()
-- DESC : Destroy repeating timer when plugin is hidden
-- **************************************************************************
function TitanPanelCoordsButton_OnHide()
	AceTimer.CancelTimer("TitanPanelCoords", CoordsTimer, true)
	CoordsTimer = nil;
end

-- **************************************************************************
-- NAME : TitanPanelCoordsButton_GetButtonText(id)
-- DESC : Calculate coordinates and then display data on button
-- VARS : id = button ID
-- **************************************************************************
function TitanPanelCoordsButton_GetButtonText(id)		 
     local button, id = TitanUtils_GetButton(id, true);

     button.px, button.py = GetPlayerMapPosition("player");
     -- cache coordinates for update checking later on
     cachedX = button.px;
     cachedY = button.py;
     if button.px == nil then button.px = 0 end
     if button.py == nil then button.py = 0 end
     local locationText = "";
     if (TitanGetVar(TITAN_COORDS_ID, "CoordsFormat1")) then     
         locationText = format(L["TITAN_COORDS_FORMAT"], 100 * button.px, 100 * button.py);
     elseif (TitanGetVar(TITAN_COORDS_ID, "CoordsFormat2")) then
         locationText = format(L["TITAN_COORDS_FORMAT2"], 100 * button.px, 100 * button.py);
     elseif (TitanGetVar(TITAN_COORDS_ID, "CoordsFormat3")) then
         locationText = format(L["TITAN_COORDS_FORMAT3"], 100 * button.px, 100 * button.py);
     end
          
     if button.px == 0 and button.py == 0 then
     		locationText = "";
     end
     
     if (TitanGetVar(TITAN_COORDS_ID, "ShowZoneText")) then     
          if (TitanUtils_ToString(button.subZoneText) == '') then
               locationText = TitanUtils_ToString(button.zoneText)..' '..locationText;
          else
               locationText = TitanUtils_ToString(button.subZoneText)..' '..locationText;
          end
     else
     	if button.px == 0 and button.py == 0 then
     		locationText = L["TITAN_COORDS_NO_COORDS"];
     	end
     end

     local locationRichText;
     if (TitanGetVar(TITAN_COORDS_ID, "ShowColoredText")) then     
          if (TitanPanelCoordsButton.isArena) then
               locationRichText = TitanUtils_GetRedText(locationText);          
          elseif (TitanPanelCoordsButton.pvpType == "friendly") then
               locationRichText = TitanUtils_GetGreenText(locationText);
          elseif (TitanPanelCoordsButton.pvpType == "hostile") then
               locationRichText = TitanUtils_GetRedText(locationText);
          elseif (TitanPanelCoordsButton.pvpType == "contested") then
               locationRichText = TitanUtils_GetNormalText(locationText);
          else
               locationRichText = TitanUtils_GetNormalText(locationText);
          end
     else
          locationRichText = TitanUtils_GetHighlightText(locationText);
     end

     return L["TITAN_COORDS_BUTTON_LABEL"], locationRichText;
end

-- **************************************************************************
-- NAME : TitanPanelCoordsButton_GetTooltipText()
-- DESC : Display tooltip text
-- **************************************************************************
function TitanPanelCoordsButton_GetTooltipText()
     local pvpInfoRichText;

     pvpInfoRichText = "";
     if (TitanPanelCoordsButton.pvpType == "sanctuary") then
          pvpInfoRichText = TitanUtils_GetGreenText(SANCTUARY_TERRITORY);
     elseif (TitanPanelCoordsButton.pvpType == "arena") then
          TitanPanelCoordsButton.subZoneText = TitanUtils_GetRedText(TitanPanelCoordsButton.subZoneText);
          pvpInfoRichText = TitanUtils_GetRedText(CONTESTED_TERRITORY);
     elseif (TitanPanelCoordsButton.pvpType == "friendly") then
          pvpInfoRichText = TitanUtils_GetGreenText(format(FACTION_CONTROLLED_TERRITORY, TitanPanelCoordsButton.factionName));
     elseif (TitanPanelCoordsButton.pvpType == "hostile") then
          pvpInfoRichText = TitanUtils_GetRedText(format(FACTION_CONTROLLED_TERRITORY, TitanPanelCoordsButton.factionName));
     elseif (TitanPanelCoordsButton.pvpType == "contested") then
          pvpInfoRichText = TitanUtils_GetRedText(CONTESTED_TERRITORY);
     else
          --pvpInfoRichText = TitanUtils_GetNormalText(CONTESTED_TERRITORY);
     end

     return ""..
          L["TITAN_COORDS_TOOLTIP_ZONE"].."\t"..TitanUtils_GetHighlightText(TitanPanelCoordsButton.zoneText).."\n"..
          TitanUtils_Ternary((TitanPanelCoordsButton.subZoneText == ""), "", L["TITAN_COORDS_TOOLTIP_SUBZONE"].."\t"..TitanUtils_GetHighlightText(TitanPanelCoordsButton.subZoneText).."\n")..          
          TitanUtils_Ternary((pvpInfoRichText == ""), "", L["TITAN_COORDS_TOOLTIP_PVPINFO"].."\t"..pvpInfoRichText.."\n")..
          "\n"..
          TitanUtils_GetHighlightText(L["TITAN_COORDS_TOOLTIP_HOMELOCATION"]).."\n"..
          L["TITAN_COORDS_TOOLTIP_INN"].."\t"..TitanUtils_GetHighlightText(GetBindLocation()).."\n"..
          TitanUtils_GetGreenText(L["TITAN_COORDS_TOOLTIP_HINTS_1"]).."\n"..
          TitanUtils_GetGreenText(L["TITAN_COORDS_TOOLTIP_HINTS_2"]);
end

-- **************************************************************************
-- NAME : TitanPanelCoordsButton_OnEvent()
-- DESC : Parse events registered to plugin and act on them
-- **************************************************************************
function TitanPanelCoordsButton_OnEvent(self, event, ...)     
	if event == "PLAYER_ENTERING_WORLD" then
		if not TitanGetVar(TITAN_COORDS_ID, "ShowLocOnMiniMap") and MinimapBorderTop and MinimapBorderTop:IsShown() then
			TitanPanelCoordsButton_LocOnMiniMap()
		end
	end
	SetMapToCurrentZone();
	TitanPanelCoordsButton_UpdateZoneInfo(self);
	TitanPanelPluginHandle_OnUpdate(updateTable);
	TitanPanelCoords_HandleUpdater();
end

-- function to throttle down unnecessary updates
function TitanPanelCoordsButton_CheckForUpdate()
	local tempx, tempy = GetPlayerMapPosition("player");
		if tempx ~= cachedX or tempy ~= cachedY then
			TitanPanelPluginHandle_OnUpdate(updateTable);
		end
end

-- **************************************************************************
-- NAME : TitanPanelCoords_HandleUpdater()
-- DESC : Check to see if you are inside an instance
-- **************************************************************************
function TitanPanelCoords_HandleUpdater()	
		if TitanPanelCoordsButton:IsVisible() and not CoordsTimer then
		 CoordsTimer = AceTimer.ScheduleRepeatingTimer("TitanPanelCoords", TitanPanelCoordsButton_CheckForUpdate, 0.5)		 
		end
end

-- **************************************************************************
-- NAME : TitanPanelCoordsButton_OnClick(button)
-- DESC : Copies coordinates to chat line for shift-LeftClick
-- VARS : button = value of action
-- **************************************************************************
function TitanPanelCoordsButton_OnClick(self, button)
	if (button == "LeftButton" and IsShiftKeyDown()) then
		local activeWindow = ChatEdit_GetActiveWindow();
		if ( activeWindow ) then
			if (TitanGetVar(TITAN_COORDS_ID, "CoordsFormat1")) then
				message = TitanUtils_ToString(self.zoneText).." "..
				format(L["TITAN_COORDS_FORMAT"], 100 * self.px, 100 * self.py);
			elseif (TitanGetVar(TITAN_COORDS_ID, "CoordsFormat2")) then
				message = TitanUtils_ToString(self.zoneText).." "..
				format(L["TITAN_COORDS_FORMAT2"], 100 * self.px, 100 * self.py);
			elseif (TitanGetVar(TITAN_COORDS_ID, "CoordsFormat3")) then
				message = TitanUtils_ToString(self.zoneText).." "..
				format(L["TITAN_COORDS_FORMAT3"], 100 * self.px, 100 * self.py);
			end
			activeWindow:Insert(message);
		end
	end
end

-- **************************************************************************
-- NAME : TitanPanelCoordsButton_UpdateZoneInfo()
-- DESC : Update data on button
-- **************************************************************************
function TitanPanelCoordsButton_UpdateZoneInfo(self)
     self.zoneText = GetZoneText();
     self.subZoneText = GetSubZoneText();
     --self.minimapZoneText = GetMinimapZoneText();
     self.pvpType, _, self.factionName = GetZonePVPInfo();
end

-- **************************************************************************
-- NAME : TitanPanelRightClickMenu_PrepareCoordsMenu()
-- DESC : Display rightclick menu options
-- **************************************************************************
function TitanPanelRightClickMenu_PrepareCoordsMenu()
		 local info
		 
		 -- level 2
	if _G["UIDROPDOWNMENU_MENU_LEVEL"] == 2 then
		if _G["UIDROPDOWNMENU_MENU_VALUE"] == "Options" then
			TitanPanelRightClickMenu_AddTitle(L["TITAN_PANEL_MENU_OPTIONS"], _G["UIDROPDOWNMENU_MENU_LEVEL"]);
			info = {};
     	info.text = L["TITAN_COORDS_MENU_SHOW_ZONE_ON_PANEL_TEXT"];
     	info.func = TitanPanelCoordsButton_ToggleDisplay;
     	info.checked = TitanGetVar(TITAN_COORDS_ID, "ShowZoneText");
     	UIDropDownMenu_AddButton(info, _G["UIDROPDOWNMENU_MENU_LEVEL"]);

     	info = {};
     	info.text = L["TITAN_COORDS_MENU_SHOW_COORDS_ON_MAP_TEXT"];
     	info.func = TitanPanelCoordsButton_ToggleCoordsOnMap;
     	info.checked = TitanGetVar(TITAN_COORDS_ID, "ShowCoordsOnMap");
     	UIDropDownMenu_AddButton(info, _G["UIDROPDOWNMENU_MENU_LEVEL"]);
     
     	info = {};
     	info.text = L["TITAN_COORDS_MENU_SHOW_LOC_ON_MINIMAP_TEXT"];
     	info.func = TitanPanelCoordsButton_ToggleLocOnMiniMap;
     	info.checked = TitanGetVar(TITAN_COORDS_ID, "ShowLocOnMiniMap");
     	info.disabled = InCombatLockdown()
     	UIDropDownMenu_AddButton(info, _G["UIDROPDOWNMENU_MENU_LEVEL"]);
		end
		if _G["UIDROPDOWNMENU_MENU_VALUE"] == "CoordFormat" then
			TitanPanelRightClickMenu_AddTitle(L["TITAN_COORDS_FORMAT_COORD_LABEL"], _G["UIDROPDOWNMENU_MENU_LEVEL"]);
			info = {};
		 	info.text = L["TITAN_COORDS_FORMAT_LABEL"];
     	info.func = function()
     		TitanSetVar(TITAN_COORDS_ID, "CoordsFormat1", 1);
     		TitanSetVar(TITAN_COORDS_ID, "CoordsFormat2", nil);
     		TitanSetVar(TITAN_COORDS_ID, "CoordsFormat3", nil);
     		TitanPanelButton_UpdateButton(TITAN_COORDS_ID);
     	end
     	info.checked = TitanGetVar(TITAN_COORDS_ID, "CoordsFormat1");
     	UIDropDownMenu_AddButton(info, _G["UIDROPDOWNMENU_MENU_LEVEL"]);
     
     	info = {};
		 	info.text = L["TITAN_COORDS_FORMAT2_LABEL"];
     	info.func = function()
     		TitanSetVar(TITAN_COORDS_ID, "CoordsFormat1", nil);
     		TitanSetVar(TITAN_COORDS_ID, "CoordsFormat2", 1);
     		TitanSetVar(TITAN_COORDS_ID, "CoordsFormat3", nil);
     		TitanPanelButton_UpdateButton(TITAN_COORDS_ID);
     	end
     	info.checked = TitanGetVar(TITAN_COORDS_ID, "CoordsFormat2");
     	UIDropDownMenu_AddButton(info, _G["UIDROPDOWNMENU_MENU_LEVEL"]);
     
     	info = {};
		 	info.text = L["TITAN_COORDS_FORMAT3_LABEL"];
     	info.func = function()
     		TitanSetVar(TITAN_COORDS_ID, "CoordsFormat1", nil);
     		TitanSetVar(TITAN_COORDS_ID, "CoordsFormat2", nil);
     		TitanSetVar(TITAN_COORDS_ID, "CoordsFormat3", 1);
     		TitanPanelButton_UpdateButton(TITAN_COORDS_ID);
     	end
     	info.checked = TitanGetVar(TITAN_COORDS_ID, "CoordsFormat3");
     	UIDropDownMenu_AddButton(info, _G["UIDROPDOWNMENU_MENU_LEVEL"]);
		end
		return
	end
		 
		 -- level 1
		 TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_COORDS_ID].menuText);
     
		 info = {};
	 	 info.text = L["TITAN_PANEL_MENU_OPTIONS"];
	 	 info.value = "Options"
	 	 info.hasArrow = 1;
   	 UIDropDownMenu_AddButton(info);
		 
		 info = {};
	 	 info.text = L["TITAN_COORDS_FORMAT_COORD_LABEL"];
	 	 info.value = "CoordFormat"
	 	 info.hasArrow = 1;
   	 UIDropDownMenu_AddButton(info);

     TitanPanelRightClickMenu_AddSpacer();
     TitanPanelRightClickMenu_AddToggleIcon(TITAN_COORDS_ID);
     TitanPanelRightClickMenu_AddToggleLabelText(TITAN_COORDS_ID);
     TitanPanelRightClickMenu_AddToggleColoredText(TITAN_COORDS_ID);
     TitanPanelRightClickMenu_AddSpacer();
     TitanPanelRightClickMenu_AddCommand(L["TITAN_PANEL_MENU_HIDE"], TITAN_COORDS_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

-- **************************************************************************
-- NAME : TitanPanelCoordsButton_ToggleDisplay()
-- DESC : Set option to show zone text
-- **************************************************************************
function TitanPanelCoordsButton_ToggleDisplay()
     TitanToggleVar(TITAN_COORDS_ID, "ShowZoneText");
     TitanPanelButton_UpdateButton(TITAN_COORDS_ID);     
end

-- **************************************************************************
-- NAME : TitanPanelCoordsButton_ToggleCoordsOnMap()
-- DESC : Set option to show coordinates on map
-- **************************************************************************
function TitanPanelCoordsButton_ToggleCoordsOnMap()
     TitanToggleVar(TITAN_COORDS_ID, "ShowCoordsOnMap");
     if (TitanGetVar(TITAN_COORDS_ID, "ShowCoordsOnMap")) then
          TitanMapCursorCoords:Show();
          TitanMapPlayerCoords:Show();
     else
          TitanMapCursorCoords:Hide();
          TitanMapPlayerCoords:Hide();
     end
end


function TitanPanelCoordsButton_ToggleLocOnMiniMap()
	TitanToggleVar(TITAN_COORDS_ID, "ShowLocOnMiniMap");
	TitanPanelCoordsButton_LocOnMiniMap()
end

function TitanPanelCoordsButton_LocOnMiniMap()
	if TitanGetVar(TITAN_COORDS_ID, "ShowLocOnMiniMap") then
		MinimapBorderTop:Show()
--		MinimapToggleButton:Show()
		MinimapZoneTextButton:Show()
	else
		MinimapBorderTop:Hide()
--		MinimapToggleButton:Hide()
		MinimapZoneTextButton:Hide()		
	end
	-- adjust MiniMap frame if needed
	TitanMovableFrame_CheckFrames(1);
	TitanMovableFrame_MoveFrames(1, TitanPanelGetVar("ScreenAdjust"));
end

-- **************************************************************************
-- NAME : TitanPanelCoordsButton_ToggleColor()
-- DESC : Set option to show colored text
-- **************************************************************************
function TitanPanelCoordsButton_ToggleColor()
     TitanToggleVar(TITAN_COORDS_ID, "ShowColoredText");
     TitanPanelButton_UpdateButton(TITAN_COORDS_ID);
end

-- **************************************************************************
-- NAME : TitanMapFrame_OnUpdate()
-- DESC : Update coordinates on map
-- **************************************************************************
function TitanMapFrame_OnUpdate(self, elapsed)
	if not (TitanGetVar(TITAN_COORDS_ID, "ShowCoordsOnMap")) then
		return;
	end
		-- using :Hide / :Show prevents coords from running
		--	TitanMapFrame:Hide() -- hide parent

	-- always calc the player position
	self.px, self.py = GetPlayerMapPosition("player");
	if self.px == nil then self.px = 0 end
	if self.py == nil then self.py = 0 end
	if self.px == 0 and self.py == 0 then
		playerCoordsText = L["TITAN_COORDS_NO_COORDS"]
	else
		if (TitanGetVar(TITAN_COORDS_ID, "CoordsFormat1")) then     				
			playerCoordsText = format(L["TITAN_COORDS_FORMAT"], 100 * self.px, 100 * self.py);
		elseif (TitanGetVar(TITAN_COORDS_ID, "CoordsFormat2")) then
			playerCoordsText = format(L["TITAN_COORDS_FORMAT2"], 100 * self.px, 100 * self.py);
		elseif (TitanGetVar(TITAN_COORDS_ID, "CoordsFormat3")) then
			playerCoordsText = format(L["TITAN_COORDS_FORMAT3"], 100 * self.px, 100 * self.py);
		end
		playerCoordsText = format(L["TITAN_COORDS_FORMAT3"], 100 * self.px, 100 * self.py);
	end
	TitanMapPlayerCoords:SetText(format(L["TITAN_COORDS_MAP_PLAYER_COORDS_TEXT"], TitanUtils_GetHighlightText(playerCoordsText)));

	--adjust the frame as needed
	if ( WorldMapFrame.sizedDown ) then
		TitanMapPlayerCoords:SetPoint("BOTTOMLEFT", WorldMapDetailFrame, "BOTTOMLEFT", 5, -20);
	else
		TitanMapPlayerCoords:SetPoint("BOTTOMLEFT", WorldMapPositioningGuide, "BOTTOMLEFT", 20, 10);
	end

	-- calc cursor position on the map
	local cursorCoordsText, playerCoordsText;
	local x, y = GetCursorPosition();
	x = x / WorldMapDetailFrame:GetEffectiveScale();
	y = y / WorldMapDetailFrame:GetEffectiveScale();

	local centerX, centerY = WorldMapDetailFrame:GetCenter();
	local width = WorldMapDetailFrame:GetWidth();
	local height = WorldMapDetailFrame:GetHeight();
	local cx = ((x - (centerX - (width/2))) / width) -- OFFSET_X 
	local cy = ((centerY + (height/2) - y ) / height) --  OFFSET_Y 

	if (TitanGetVar(TITAN_COORDS_ID, "CoordsFormat1")) then     				
		cursorCoordsText = format(L["TITAN_COORDS_FORMAT"], 100 * cx, 100 * cy);
	elseif (TitanGetVar(TITAN_COORDS_ID, "CoordsFormat2")) then
		cursorCoordsText = format(L["TITAN_COORDS_FORMAT2"], 100 * cx, 100 * cy);
	elseif (TitanGetVar(TITAN_COORDS_ID, "CoordsFormat3")) then
		cursorCoordsText = format(L["TITAN_COORDS_FORMAT3"], 100 * cx, 100 * cy);
	end
		
	TitanMapCursorCoords:SetText(format(L["TITAN_COORDS_MAP_CURSOR_COORDS_TEXT"], TitanUtils_GetHighlightText(cursorCoordsText)));
end
