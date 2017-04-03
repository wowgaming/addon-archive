-- **************************************************************************
-- * TitanClock.lua
-- *
-- * By: TitanMod, Dark Imakuni, Adsertor and the Titan Development Team
-- *     (HonorGoG, jaketodd422, joejanko, Lothayer, Tristanian)
-- **************************************************************************

-- ******************************** Constants *******************************
TITAN_CLOCK_ID = "Clock";
local TITAN_CLOCK_FORMAT_12H = "12H";
local TITAN_CLOCK_FORMAT_24H = "24H";
local TITAN_CLOCK_FRAME_SHOW_TIME = 0.5;
local _G = getfenv(0);
-- ******************************** Variables *******************************
local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true)
local AceTimer = LibStub("AceTimer-3.0")
local ClockTimer = nil;
local updateTable = {TITAN_CLOCK_ID, TITAN_PANEL_UPDATE_ALL };
-- ******************************** Functions *******************************

-- **************************************************************************
-- NAME : TitanPanelClockButton_OnLoad()
-- DESC : Registers the plugin upon it loading
-- **************************************************************************
function TitanPanelClockButton_OnLoad(self)
	self.registry = {
		id = TITAN_CLOCK_ID,
		category = "Built-ins",
		version = TITAN_VERSION,
		menuText = L["TITAN_CLOCK_MENU_TEXT"],
		buttonTextFunction = "TitanPanelClockButton_GetButtonText",
		tooltipTitle = L["TITAN_CLOCK_TOOLTIP"],
		tooltipTextFunction = "TitanPanelClockButton_GetTooltipText",
		controlVariables = {
			ShowIcon = false,
			ShowLabelText = true,
			ShowRegularText = false,
			ShowColoredText = true,
			DisplayOnRightSide = true,
		},
		savedVariables = {
			OffsetHour = 0,
			Format = TITAN_CLOCK_FORMAT_12H,
			TimeMode = "Server",
			ShowLabelText = false,
			ShowColoredText = false,
			DisplayOnRightSide = 1,
			HideGameTimeMinimap = false,
		}
	};
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
end

local function TitanPanelClockButton_GetColored(text)
	local label = "";
	if (TitanGetVar(TITAN_CLOCK_ID, "ShowColoredText")) then
		label = TitanUtils_GetGreenText(text)
	else
		label = TitanUtils_GetHighlightText(text)
	end
	return label;
end

-- **************************************************************************
-- NAME : TitanPanelClockButton_OnShow()
-- DESC : Create repeating timer when plugin is visible
-- **************************************************************************
function TitanPanelClockButton_OnShow()
	if not ClockTimer then
		ClockTimer = AceTimer.ScheduleRepeatingTimer("TitanPanelClock", TitanPanelPluginHandle_OnUpdate, 30, updateTable)
	end
end

-- **************************************************************************
-- NAME : TitanPanelClockButton_OnHide()
-- DESC : Destroy repeating timer when plugin is hidden
-- **************************************************************************
function TitanPanelClockButton_OnHide()
	AceTimer.CancelTimer("TitanPanelClock", ClockTimer, true)
	ClockTimer = nil;     
end


function TitanPanelClockButton_OnEvent(self, event, ...)
	if (event == "PLAYER_ENTERING_WORLD") and TitanGetVar(TITAN_CLOCK_ID, "HideGameTimeMinimap") then
		if GameTimeFrame then GameTimeFrame:Hide() end
	end
end


function TitanPanelClockButton_OnClick(self, button)
	if button == "LeftButton" and IsShiftKeyDown() then
		TitanUtils_CloseAllControlFrames();
		if (TitanPanelRightClickMenu_IsVisible()) then
				TitanPanelRightClickMenu_Close();
		end
		ToggleCalendar()
	else
		TitanPanelButton_OnClick(self, button);
	end
end

-- **************************************************************************
-- NAME : TitanPanelClockButton_GetButtonText()
-- DESC : Display time on button based on set variables
-- **************************************************************************
function TitanPanelClockButton_GetButtonText()
	local clocktime = "";	
	local labeltext = "";
	if TitanGetVar(TITAN_CLOCK_ID, "TimeMode") == "Server" then
		_,clocktime = TitanPanelClockButton_GetTime("Server", 0)
		labeltext = TitanGetVar(TITAN_CLOCK_ID, "ShowLabelText") and TitanPanelClockButton_GetColored("(S) ")	or ""	
	elseif TitanGetVar(TITAN_CLOCK_ID, "TimeMode") == "ServerAdjusted" then
		_,clocktime = TitanPanelClockButton_GetTime ("Server", TitanGetVar(TITAN_CLOCK_ID, "OffsetHour"))
		labeltext = TitanGetVar(TITAN_CLOCK_ID, "ShowLabelText") and TitanPanelClockButton_GetColored("(A) ")	or ""
	elseif TitanGetVar(TITAN_CLOCK_ID, "TimeMode") == "Local" then
		_,clocktime = TitanPanelClockButton_GetTime ("Local", 0)
		labeltext = TitanGetVar(TITAN_CLOCK_ID, "ShowLabelText") and TitanPanelClockButton_GetColored("(L) ")	or ""
	end
	return labeltext, clocktime
end


function TitanPanelClockButton_GetTime(displaytype, offset)
	 -- Calculate the hour/minutes considering the offset
   	 local hour, minute = GetGameTime();                
     local twentyfour = "";
     local offsettime = string.format("%s", offset);
     local offsethour = 0;
     local offsetmin = 0;
     local s, e, id = string.find(offsettime, '%.5');
     
   if displaytype == "Server" then

     if (s ~= nil) then     			
          offsethour = string.sub(offsettime, 1, s);
          offsetmin = string.sub(offsettime, s+1);          
          if offsetmin == "" or offsetmin == nil then offsetmin = "0"; end
          if offsethour == "" or offsethour == nil then offsethour = "0"; end
     
          offsethour = tonumber(offsethour);
          if (tonumber(offsettime) < 0) then offsetmin = tonumber("-" .. offsetmin); end
                    
          minute = minute + (offsetmin*6);
          
          if (minute > 59) then               
               minute = minute - 60;               
               offsethour = offsethour + 1;
          elseif (minute < 0) then
               minute = 60 + minute;
               offsethour = offsethour - 1;
          end
     else     			
          offsethour = offset;
     end
     
   else
   -- no offset for local time
   	hour, minute = tonumber(date("%H")), tonumber(date("%M"));
   	offsethour = 0;
   end  
          
     hour = hour + offsethour;
     
     if (hour > 23) then
          hour = hour - 24;
     elseif (hour < 0) then
          hour = 24 + hour;
     end

     -- Calculate the display text based on format 12H/24H 
     if (TitanGetVar(TITAN_CLOCK_ID, "Format") == TITAN_CLOCK_FORMAT_12H) then
          local isAM;
          if (hour >= 12) then
               isAM = false;
               hour = hour - 12;
          else
               isAM = true;
          end
          if (hour == 0) then
               hour = 12;
          end
          if (isAM) then
               return nil, format(TEXT(TIME_TWELVEHOURAM), hour, minute);
          else
               return nil, format(TEXT(TIME_TWELVEHOURPM), hour, minute);
          end
     else
          twentyfour = format(TEXT(TIME_TWENTYFOURHOURS), hour, minute);
          if (hour < 10) then
               twentyfour = "0" .. twentyfour
          end
     
          return nil, twentyfour;
     end
     
end

-- **************************************************************************
-- NAME : TitanPanelClockButton_GetTooltipText()
-- DESC : Display tooltip text
-- **************************************************************************
function TitanPanelClockButton_GetTooltipText()
		 local _, clockTimeLocal = TitanPanelClockButton_GetTime ("Local", 0)
		 local _, clockTimeServer = TitanPanelClockButton_GetTime ("Server", 0)
		 local _, clockTimeServerAdjusted = TitanPanelClockButton_GetTime ("Server", TitanGetVar(TITAN_CLOCK_ID, "OffsetHour")) 
		 local clockTimeLocalLabel = L["TITAN_CLOCK_TOOLTIP_LOCAL_TIME"].."\t"..TitanUtils_GetHighlightText(clockTimeLocal)
		 local clockTimeServerLabel = L["TITAN_CLOCK_TOOLTIP_SERVER_TIME"].."\t"..TitanUtils_GetHighlightText(clockTimeServer)
		 local clockTimeServerAdjustedLabel = "";
		 if TitanGetVar(TITAN_CLOCK_ID, "OffsetHour") ~= 0 then
		 	clockTimeServerAdjustedLabel = L["TITAN_CLOCK_TOOLTIP_SERVER_ADJUSTED_TIME"].."\t"..TitanUtils_GetHighlightText(clockTimeServerAdjusted).."\n"
		 end
     local clockText = TitanPanelClock_GetOffsetText(TitanGetVar(TITAN_CLOCK_ID, "OffsetHour"));
     return ""..
     			clockTimeLocalLabel.."\n"..
     			clockTimeServerLabel.."\n"..
     			clockTimeServerAdjustedLabel..
          L["TITAN_CLOCK_TOOLTIP_VALUE"].."\t"..TitanUtils_GetHighlightText(clockText).."\n"..
          TitanUtils_GetGreenText(L["TITAN_CLOCK_TOOLTIP_HINT1"]).."\n"..
          TitanUtils_GetGreenText(L["TITAN_CLOCK_TOOLTIP_HINT2"]).."\n"..
          TitanUtils_GetGreenText(L["TITAN_CLOCK_TOOLTIP_HINT3"]);
end

-- **************************************************************************
-- NAME : TitanPanelClockControlSlider_OnEnter()
-- DESC : Display slider tooltip
-- **************************************************************************
function TitanPanelClockControlSlider_OnEnter(self)
     self.tooltipText = TitanOptionSlider_TooltipText(L["TITAN_CLOCK_CONTROL_TOOLTIP"], TitanPanelClock_GetOffsetText(TitanGetVar(TITAN_CLOCK_ID, "OffsetHour")));
     GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
     GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
     TitanUtils_StopFrameCounting(self:GetParent());
end

-- **************************************************************************
-- NAME : TitanPanelClockControlSlider_OnLeave()
-- DESC : Hide slider tooltip
-- **************************************************************************
function TitanPanelClockControlSlider_OnLeave(self)
     self.tooltipText = nil;
     GameTooltip:Hide();
     TitanUtils_StartFrameCounting(self:GetParent(), TITAN_CLOCK_FRAME_SHOW_TIME);
end

-- **************************************************************************
-- NAME : TitanPanelClockControlSlider_OnShow()
-- DESC : Display slider tooltip options
-- **************************************************************************
function TitanPanelClockControlSlider_OnShow(self)
     _G[self:GetName().."Text"]:SetText(TitanPanelClock_GetOffsetText(TitanGetVar(TITAN_CLOCK_ID, "OffsetHour")));
     _G[self:GetName().."High"]:SetText(L["TITAN_CLOCK_CONTROL_LOW"]);
     _G[self:GetName().."Low"]:SetText(L["TITAN_CLOCK_CONTROL_HIGH"]);
     self:SetMinMaxValues(-12, 12);
     self:SetValueStep(0.5);
     self:SetValue(0 - TitanGetVar(TITAN_CLOCK_ID, "OffsetHour"));

     local position = TitanUtils_GetRealPosition(TITAN_CLOCK_ID);
     local scale = TitanPanelGetVar("Scale");
     
     --TitanPanelClockControlFrame:SetPoint("BOTTOMRIGHT", "TitanPanel" .. TitanUtils_GetWhichBar(TITAN_CLOCK_ID) .."Button", "TOPRIGHT", 0, 0);
     if (position == TITAN_PANEL_PLACE_TOP) then 
          TitanPanelClockControlFrame:ClearAllPoints();
          if TitanGetVar(TITAN_CLOCK_ID, "DisplayOnRightSide") == 1 then
          	TitanPanelClockControlFrame:SetPoint("TOPLEFT", "TitanPanel" .. TitanUtils_GetWhichBar(TITAN_CLOCK_ID) .."Button", "BOTTOMLEFT", UIParent:GetRight() - TitanPanelClockControlFrame:GetWidth(), -4);
          else
          	TitanPanelClockControlFrame:SetPoint("TOPLEFT", "TitanPanel" ..TITAN_CLOCK_ID.."Button", "BOTTOMLEFT", -10, -4 * scale);
          	-- Adjust frame position if it's off the screen
						local offscreenX, offscreenY = TitanUtils_GetOffscreen(TitanPanelClockControlFrame);
						if ( offscreenX == -1 ) then
							TitanPanelClockControlFrame:SetPoint("TOPLEFT", "TitanPanel" ..TITAN_CLOCK_ID.."Button", "BOTTOMLEFT", 0, 0);					
						elseif ( offscreenX == 1 ) then
							TitanPanelClockControlFrame:SetPoint("TOPRIGHT", "TitanPanel" ..TITAN_CLOCK_ID.."Button", "BOTTOMRIGHT", 0, 0);
						end          	
          end
     else
          TitanPanelClockControlFrame:ClearAllPoints();
          if TitanGetVar(TITAN_CLOCK_ID, "DisplayOnRightSide") == 1 then
          	TitanPanelClockControlFrame:SetPoint("BOTTOMLEFT", "TitanPanel" .. TitanUtils_GetWhichBar(TITAN_CLOCK_ID) .."Button", "TOPLEFT", UIParent:GetRight() - TitanPanelClockControlFrame:GetWidth(), 0);
          else
          	TitanPanelClockControlFrame:SetPoint("BOTTOMLEFT", "TitanPanel" ..TITAN_CLOCK_ID.."Button", "TOPLEFT", -10, 4 * scale);
          	-- Adjust frame position if it's off the screen
						local offscreenX, offscreenY = TitanUtils_GetOffscreen(TitanPanelClockControlFrame);
						if ( offscreenX == -1 ) then
							TitanPanelClockControlFrame:SetPoint("BOTTOMLEFT", "TitanPanel" ..TITAN_CLOCK_ID.."Button", "TOPLEFT", 0, 0);
						elseif ( offscreenX == 1 ) then
							TitanPanelClockControlFrame:SetPoint("BOTTOMRIGHT", "TitanPanel" ..TITAN_CLOCK_ID.."Button", "TOPRIGHT", 0, 0);							
						end
          end
     end

end

-- **************************************************************************
-- NAME : TitanPanelClockControlSlider_OnValueChanged(arg1)
-- DESC : Display slider tooltip text
-- VARS : arg1 = positive or negative change to apply
-- **************************************************************************
function TitanPanelClockControlSlider_OnValueChangedWheel(self, a1)
     _G[self:GetName().."Text"]:SetText(TitanPanelClock_GetOffsetText(0 - self:GetValue()));
     local tempval = self:GetValue();     
     
     if a1 == -1 then     
          self:SetValue(tempval + 0.5);
     end
     
     if a1 == 1 then     
          self:SetValue(tempval - 0.5);
     end     
     
     TitanSetVar(TITAN_CLOCK_ID, "OffsetHour", 0 - self:GetValue());
     local realmName = GetCVar("realmName");
     if ( ServerTimeOffsets[realmName] ) then
          ServerTimeOffsets[realmName] = TitanGetVar(TITAN_CLOCK_ID, "OffsetHour");
     end
     TitanPanelButton_UpdateButton(TITAN_CLOCK_ID);

     -- Update GameTooltip
     if (self.tooltipText) then
          self.tooltipText = TitanOptionSlider_TooltipText(L["TITAN_CLOCK_CONTROL_TOOLTIP"], TitanPanelClock_GetOffsetText(TitanGetVar(TITAN_CLOCK_ID, "OffsetHour")));
          GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
     end
end


function TitanPanelClockControlSlider_OnValueChanged(self, a1)
     _G[self:GetName().."Text"]:SetText(TitanPanelClock_GetOffsetText(0 - self:GetValue()));          
     TitanSetVar(TITAN_CLOCK_ID, "OffsetHour", 0 - self:GetValue());
     local realmName = GetCVar("realmName");
     if ( ServerTimeOffsets[realmName] ) then
          ServerTimeOffsets[realmName] = TitanGetVar(TITAN_CLOCK_ID, "OffsetHour");
     end
     TitanPanelButton_UpdateButton(TITAN_CLOCK_ID);

     -- Update GameTooltip
     if (self.tooltipText) then
          self.tooltipText = TitanOptionSlider_TooltipText(L["TITAN_CLOCK_CONTROL_TOOLTIP"], TitanPanelClock_GetOffsetText(TitanGetVar(TITAN_CLOCK_ID, "OffsetHour")));
          GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
     end
end

-- **************************************************************************
-- NAME : TitanPanelClockControlCheckButton_OnShow() 
-- DESC : Define clock hour options
-- **************************************************************************
function TitanPanelClockControlCheckButton_OnShow(self)     
     TitanPanelClockControlCheckButtonText:SetText(L["TITAN_CLOCK_CHECKBUTTON"]);
     
     if (TitanGetVar(TITAN_CLOCK_ID, "Format") == TITAN_CLOCK_FORMAT_24H) then
          self:SetChecked(1);
     else
          self:SetChecked(0);
     end
end

-- **************************************************************************
-- NAME : TitanPanelClockControlCheckButton_OnClick()
-- DESC : Toggle clock hour option
-- **************************************************************************
function TitanPanelClockControlCheckButton_OnClick(self, button)
     if (self:GetChecked()) then
          TitanSetVar(TITAN_CLOCK_ID, "Format", TITAN_CLOCK_FORMAT_24H);
     else
          TitanSetVar(TITAN_CLOCK_ID, "Format", TITAN_CLOCK_FORMAT_12H);
     end
     local realmName = GetCVar("realmName");
     if ( ServerHourFormat[realmName] ) then
          ServerHourFormat[realmName] = TitanGetVar(TITAN_CLOCK_ID, "Format");
     end

     TitanPanelButton_UpdateButton(TITAN_CLOCK_ID);
end

-- **************************************************************************
-- NAME : TitanPanelClockControlCheckButton_OnEnter()
-- DESC : Display clock hour option tooltip
-- **************************************************************************
function TitanPanelClockControlCheckButton_OnEnter(self)
     self.tooltipText = L["TITAN_CLOCK_CHECKBUTTON_TOOLTIP"];
     GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
     GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
     TitanUtils_StopFrameCounting(self:GetParent());
end

-- **************************************************************************
-- NAME : TitanPanelClockControlCheckButton_OnLeave()
-- DESC : Hide clock hour option tooltip
-- **************************************************************************
function TitanPanelClockControlCheckButton_OnLeave(self)
     self.tooltipText = nil;
     GameTooltip:Hide();
     TitanUtils_StartFrameCounting(self:GetParent(), TITAN_CLOCK_FRAME_SHOW_TIME);
end

-- **************************************************************************
-- NAME : TitanPanelClock_GetOffsetText(offset)
-- DESC : Get hour offset value and return
-- VARS : offset = hour offset from server time
-- **************************************************************************
function TitanPanelClock_GetOffsetText(offset)
     if (offset > 0) then
          return TitanUtils_GetGreenText("+" .. tostring(offset));
     elseif (offset < 0) then
     			return TitanUtils_GetRedText(tostring(offset));
     else
          return TitanUtils_GetHighlightText(tostring(offset));
     end
end

-- **************************************************************************
-- NAME : TitanPanelClockControlFrame_OnLoad()
-- DESC : Create clock option frame
-- **************************************************************************
function TitanPanelClockControlFrame_OnLoad(self)
     _G[self:GetName().."Title"]:SetText(L["TITAN_CLOCK_CONTROL_TITLE"]);
     self:SetBackdropBorderColor(1, 1, 1);
     self:SetBackdropColor(0, 0, 0, 1);
end

-- **************************************************************************
-- NAME : TitanPanelClockControlFrame_OnUpdate(elapsed)
-- DESC : If dropdown is visible, see if its timer has expired.  If so, hide frame
-- VARS : elapsed = <research>
-- **************************************************************************
function TitanPanelClockControlFrame_OnUpdate(self, elapsed)
     TitanUtils_CheckFrameCounting(self, elapsed);
end

-- **************************************************************************
-- NAME : TitanPanelRightClickMenu_PrepareClockMenu()
-- DESC : Generate clock right click menu options
-- **************************************************************************
function TitanPanelRightClickMenu_PrepareClockMenu()
     TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_CLOCK_ID].menuText);
     
     local info = {};
     info.text = L["TITAN_CLOCK_MENU_LOCAL_TIME"];
     info.func = function() TitanSetVar(TITAN_CLOCK_ID, "TimeMode", "Local") TitanPanelButton_UpdateButton(TITAN_CLOCK_ID) end
     info.checked = function() return TitanGetVar(TITAN_CLOCK_ID, "TimeMode") == "Local" end
     UIDropDownMenu_AddButton(info);
     
     info = {};     
     info.text = L["TITAN_CLOCK_MENU_SERVER_TIME"];
     info.func = function() TitanSetVar(TITAN_CLOCK_ID, "TimeMode", "Server") TitanPanelButton_UpdateButton(TITAN_CLOCK_ID) end
     info.checked = function() return TitanGetVar(TITAN_CLOCK_ID, "TimeMode") == "Server" end
     UIDropDownMenu_AddButton(info);
     
     info = {};     
     info.text = L["TITAN_CLOCK_MENU_SERVER_ADJUSTED_TIME"];
     info.func = function() TitanSetVar(TITAN_CLOCK_ID, "TimeMode", "ServerAdjusted") TitanPanelButton_UpdateButton(TITAN_CLOCK_ID) end
     info.checked = function() return TitanGetVar(TITAN_CLOCK_ID, "TimeMode") == "ServerAdjusted" end
     UIDropDownMenu_AddButton(info);
     
     TitanPanelRightClickMenu_AddSpacer();     
     
     info = {};
     info.text = L["TITAN_CLOCK_MENU_HIDE_GAMETIME"];
     info.func = TitanPanelClockButton_ToggleGameTimeFrameShown;
     info.checked = TitanGetVar(TITAN_CLOCK_ID, "HideGameTimeMinimap");
     info.keepShownOnClick = 1;
     UIDropDownMenu_AddButton(info);
     
     info = {};
     info.text = L["TITAN_CLOCK_MENU_DISPLAY_ON_RIGHT_SIDE"];
     info.func = TitanPanelClockButton_ToggleRightSideDisplay;     
     info.checked = TitanGetVar(TITAN_CLOCK_ID, "DisplayOnRightSide");
     UIDropDownMenu_AddButton(info);
     
     TitanPanelRightClickMenu_AddToggleLabelText(TITAN_CLOCK_ID);
     TitanPanelRightClickMenu_AddToggleColoredText(TITAN_CLOCK_ID);

     TitanPanelRightClickMenu_AddSpacer();
     TitanPanelRightClickMenu_AddCommand(L["TITAN_PANEL_MENU_HIDE"], TITAN_CLOCK_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

-- **************************************************************************
-- NAME : TitanPanelClockButton_ToggleRightSideDisplay()
-- DESC : Add clock button to bar
-- **************************************************************************
function TitanPanelClockButton_ToggleRightSideDisplay()
     TitanToggleVar(TITAN_CLOCK_ID, "DisplayOnRightSide");
     TITAN_PANEL_SELECTED = TitanUtils_GetWhichBar(TITAN_CLOCK_ID);
     TitanPanel_RemoveButton(TITAN_CLOCK_ID);
     --TitanDebug(TITAN_PANEL_SELECTED);
     TitanPanel_AddButton(TITAN_CLOCK_ID);     
end

function TitanPanelClockButton_ToggleGameTimeFrameShown()
	TitanToggleVar(TITAN_CLOCK_ID, "HideGameTimeMinimap");
		if GameTimeFrame and GameTimeFrame:GetName() then
			if TitanGetVar(TITAN_CLOCK_ID, "HideGameTimeMinimap") then
				GameTimeFrame:Hide()
			else
				GameTimeFrame:Show()
			end
		end
end