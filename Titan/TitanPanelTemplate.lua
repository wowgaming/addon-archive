-- Globals
TITAN_PANEL_UPDATE_BUTTON = 1;
TITAN_PANEL_UPDATE_TOOLTIP = 2;
TITAN_PANEL_UPDATE_ALL = 3;
TitanTooltipOrigScale = 1;
TitanTooltipScaleSet = 0;

-- Constants
local TITAN_PANEL_LABEL_SEPARATOR = "  "
local TITAN_PANEL_BUTTON_WIDTH_CHANGE_TOLERANCE = 10;
local TITAN_PANEL_BUTTON_TYPE_TEXT = 1;
local TITAN_PANEL_BUTTON_TYPE_ICON = 2;
local TITAN_PANEL_BUTTON_TYPE_COMBO = 3;
local TITAN_PANEL_BUTTON_TYPE_CUSTOM = 4;
local pluginOnEnter = nil;

-- Library instances
local AceTimer = LibStub("AceTimer-3.0")
local LibQTip = nil
local _G = getfenv(0);
local InCombatLockdown	= _G.InCombatLockdown;

function TitanOptionSlider_TooltipText(text, value) 
	return text .. GREEN_FONT_COLOR_CODE .. value .. FONT_COLOR_CODE_CLOSE;
end

function TitanPanelButton_OnLoad(self, isChildButton)
	-- ensure that 'self' passed is a valid frame reference
	TitanUtils_PluginToRegister(self, isChildButton)
end

function TitanPanelPluginHandle_OnUpdate(table, oldarg)
local id, updateType = nil
-- set the id and updateType
-- old method
if table and type(table) == "string" and oldarg then
	id = table
	updateType = oldarg
end
-- new method
if table and type(table) == "table" and table[1] then id = table[1] end
if table and type(table) == "table" and table[2] then updateType = table[2] end

-- id is required
	if id then
			if updateType == TITAN_PANEL_UPDATE_BUTTON or updateType == TITAN_PANEL_UPDATE_ALL then
 				TitanPanelButton_UpdateButton(id)
			end

			if (updateType == TITAN_PANEL_UPDATE_TOOLTIP or updateType == TITAN_PANEL_UPDATE_ALL) and MouseIsOver(_G["TitanPanel"..id.."Button"]) then			
				if TitanPanelRightClickMenu_IsVisible() or TITAN_PANEL_MOVING == 1 then return end
   			TitanPanelButton_SetTooltip(_G["TitanPanel"..id.."Button"], id)   			
			end
	end
end

function TitanPanelDetectPluginMethod(id, isChildButton)
-- Script handlers for button movement
if not id then return end
local TitanPluginframe = _G["TitanPanel"..id.."Button"];
	if isChildButton then
    TitanPluginframe = _G[id];
  end
		
	TitanPluginframe:SetScript("OnDragStart", function(self)
		if not IsShiftKeyDown() and not IsControlKeyDown() and not IsAltKeyDown() then			
			if isChildButton then
    		TitanPanelButton_OnDragStart(self, true);
    	else
    		TitanPanelButton_OnDragStart(self);
  		end
  	end
		end)
	
	TitanPluginframe:SetScript("OnDragStop", function(self)		
		if isChildButton then
			TitanPanelButton_OnDragStop(self, true)
		else    	 		    	 		
    	TitanPanelButton_OnDragStop(self);
		end		
	 end)
	
end

function TitanPanelButton_OnShow(self)
local id = nil;
-- ensure that the 'self' passed is a valid frame reference
	if self and self:GetName() then
		id = TitanUtils_GetButtonID(self:GetName());
	end
	if (id) then		
		TitanPanelButton_UpdateButton(id, 1);
	end 
end

function TitanPanelButton_OnClick(self, button, isChildButton)
local id
-- ensure that the 'self' passed is a valid frame reference
	if self and self:GetName() then
		id = TitanUtils_Ternary(isChildButton, TitanUtils_GetParentButtonID(self:GetName()), TitanUtils_GetButtonID(self:GetName()));
	end
	
	if id then
		local controlFrame = TitanUtils_GetControlFrame(id);
		local rightClickMenu = _G["TitanPanelRightClickMenu"];
	
		if (button == "LeftButton") then
			local isControlFrameShown;
			if (not controlFrame) then
				isControlFrameShown = false;
			elseif (controlFrame:IsVisible()) then
				isControlFrameShown = false;
			else
				isControlFrameShown = true;
			end
			
			TitanUtils_CloseAllControlFrames();	
			TitanPanelRightClickMenu_Close();	
		
			local position = TitanPanelGetVar("Position");
			local scale = TitanPanelGetVar("Scale");
			if (isControlFrameShown) then
				local buttonCenter = (self:GetLeft() + self:GetRight()) / 2 * scale;
				local controlFrameRight = buttonCenter + controlFrame:GetWidth() / 2;
				if ( position == TITAN_PANEL_PLACE_TOP ) then 
					controlFrame:ClearAllPoints();
					controlFrame:SetPoint("TOP", "UIParent", "TOPLEFT", buttonCenter, -24 * scale);	
					
					-- Adjust control frame position if it's off the screen
					local offscreenX, offscreenY = TitanUtils_GetOffscreen(controlFrame);
					if ( offscreenX == -1 ) then
						controlFrame:ClearAllPoints();
						controlFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 0, -24 * scale);	
					elseif ( offscreenX == 1 ) then
						controlFrame:ClearAllPoints();
						controlFrame:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", 0, -24 * scale);	
					end							
				else
					controlFrame:ClearAllPoints();
					controlFrame:SetPoint("BOTTOM", "UIParent", "BOTTOMLEFT", buttonCenter, 24 * scale); 

					-- Adjust control frame position if it's off the screen
					local offscreenX, offscreenY = TitanUtils_GetOffscreen(controlFrame);
					if ( offscreenX == -1 ) then
						controlFrame:ClearAllPoints();
						controlFrame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, 24 * scale);	
					elseif ( offscreenX == 1 ) then
						controlFrame:ClearAllPoints();
						controlFrame:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", 0, 24 * scale);	
					end							
				end
				
				controlFrame:Show();
			end	
		elseif (button == "RightButton") then
			TitanUtils_CloseAllControlFrames();	
		
			-- Show RightClickMenu anyway
			if (TitanPanelRightClickMenu_IsVisible()) then
				TitanPanelRightClickMenu_Close();
			end
			-- Initialize the DropDown Menu if not already initialized
			if not self.TitanMenuInit and self:GetName() then
				TitanRightClickMenu_OnLoad(_G[self:GetName().."RightClickMenu"])
				self.TitanMenuInit = true
			end
			TitanPanelRightClickMenu_Toggle(self, isChildButton);
		end

		GameTooltip:Hide();
	end
end

function TitanPanelButton_OnEnter(self, isChildButton)
local id = nil;
-- ensure that the 'self' passed is a valid frame reference
	if self and self:GetName() then
		id = TitanUtils_Ternary(isChildButton, TitanUtils_GetParentButtonID(self:GetName()), TitanUtils_GetButtonID(self:GetName()));
	end
	
	if (id) then
		 AceTimer.CancelAllTimers("TitanAutoHider");
		local controlFrame = TitanUtils_GetControlFrame(id);
		if (controlFrame and controlFrame:IsVisible()) then
			return;
		elseif (TitanPanelRightClickMenu_IsVisible()) then
			return;
		else			
			if TITAN_PANEL_MOVING == 0 then
				TitanPanelButton_SetTooltip(self, id);
			end
			if self.isMoving then
				GameTooltip:Hide();				
			end
		end	
	end
end

function TitanPanelButton_OnLeave(self, isChildButton)
local id = nil;
-- ensure that the 'self' passed is a valid frame reference
	if self and self:GetName() then
		id = TitanUtils_Ternary(isChildButton, TitanUtils_GetParentButtonID(self:GetName()), TitanUtils_GetButtonID(self:GetName()));
	end
	
	if (id) then
		GameTooltip:Hide();		
		-- routine to handle autohide
		local plugin = TitanUtils_GetCurrentIndex(TitanPanelSettings.Buttons,id);
		if (TitanPanelGetVar("AutoHide")) and TitanPanelSettings.Location[plugin] == "Bar" then
		 AceTimer.ScheduleRepeatingTimer("TitanAutoHider", Handle_OnUpdateAutoHide, 0.5)
		end
		if (TitanPanelGetVar("AuxAutoHide")) and TitanPanelSettings.Location[plugin] == "AuxBar" then
		AceTimer.ScheduleRepeatingTimer("TitanAutoHider", Handle_OnUpdateAutoHide, 0.5)
		end
	end
	   if not TitanPanelGetVar("DisableTooltipFont") then
			-- reset original Tooltip Scale
			GameTooltip:SetScale(TitanTooltipOrigScale);
			TitanTooltipScaleSet = 0;
		 end		 
end

function TitanPanelButton_UpdateButton(id, setButtonWidth) 
	local button, id = TitanUtils_GetButton(id);
	-- safeguard to avoid errors
	if not TitanUtils_IsPluginRegistered(id) then return end
	
	if ( TitanPanelButton_IsText(id) ) then
		-- Update textButton
		TitanPanelButton_SetButtonText(id);
		TitanPanelButton_SetTextButtonWidth(id, setButtonWidth);	
		
	elseif ( TitanPanelButton_IsIcon(id) ) then
		-- Update iconButton
		TitanPanelButton_SetButtonIcon(id);
		TitanPanelButton_SetIconButtonWidth(id);	
		
	elseif ( TitanPanelButton_IsCombo(id) ) then
		-- Update comboButton
		TitanPanelButton_SetButtonText(id);
		TitanPanelButton_SetButtonIcon(id);
		TitanPanelButton_SetComboButtonWidth(id, setButtonWidth);
	end
end

function TitanPanelButton_UpdateTooltip(self)
if not self then return end
	if (GameTooltip:IsOwned(self)) then
		local id = TitanUtils_GetButtonID(self:GetName());
		TitanPanelButton_SetTooltip(self, id);
	end
end

-- id is required
function TitanPanelButton_SetButtonText(id) 
	if (id and TitanUtils_IsPluginRegistered(id)) then
		local button = TitanUtils_GetButton(id);
		local buttonText = _G[button:GetName().."Text"];
		local buttonTextFunction = _G[TitanUtils_GetPlugin(id).buttonTextFunction];
		if (buttonTextFunction) then
			local label1, value1, label2, value2, label3, value3, label4, value4 = buttonTextFunction(id);
			local text = "";
			if ( label1 and not ( label2 or label3 or label4 or value1 or value2 or value3 or value4 ) ) then
				text = label1;
			elseif (TitanGetVar(id, "ShowLabelText")) then
				if (label1 or value1) then
					text = TitanUtils_ToString(label1)..TitanUtils_ToString(value1);
					if (label2 or value2) then
						text = text..TITAN_PANEL_LABEL_SEPARATOR..TitanUtils_ToString(label2)..TitanUtils_ToString(value2);
						if (label3 or value3) then
							text = text..TITAN_PANEL_LABEL_SEPARATOR..TitanUtils_ToString(label3)..TitanUtils_ToString(value3);
							if (label4 or value4) then
								text = text..TITAN_PANEL_LABEL_SEPARATOR..TitanUtils_ToString(label4)..TitanUtils_ToString(value4);
							end
						end
					end
				end
			else
				if (value1) then
					text = TitanUtils_ToString(value1);
					if (value2) then
						text = text..TITAN_PANEL_LABEL_SEPARATOR..TitanUtils_ToString(value2);
						if (value3) then
							text = text..TITAN_PANEL_LABEL_SEPARATOR..TitanUtils_ToString(value3);
							if (value4) then
								text = text..TITAN_PANEL_LABEL_SEPARATOR..TitanUtils_ToString(value4);
							end
						end
					end
				end
			end
			buttonText:SetText(text);
		end	
	end
end

-- id is required
function TitanPanelButton_SetButtonIcon(id, iconCoords, iconR, iconG, iconB) 	
	if (id and TitanUtils_IsPluginRegistered(id)) then
		local button = TitanUtils_GetButton(id);
		local icon = _G[button:GetName().."Icon"];
		local iconTexture = TitanUtils_GetPlugin(id).icon;
		local iconWidth = TitanUtils_GetPlugin(id).iconWidth;
		
		if (iconTexture) and icon then
			icon:SetTexture(iconTexture);
		end
		if (iconWidth) and icon then
			icon:SetWidth(iconWidth);
		end
		
		-- support for iconCoords, iconR, iconG, iconB attributes		
		if iconCoords and icon then
			icon:SetTexCoord(unpack(iconCoords))
		end		
		if iconR and iconG and iconB and icon then
			icon:SetVertexColor(iconR, iconG, iconB)
		end
		
	end
end

-- id is required
function TitanPanelButton_SetTextButtonWidth(id, setButtonWidth) 
	if (id) then
		local button = TitanUtils_GetButton(id);
		local text = _G[button:GetName().."Text"];
		if ( setButtonWidth or
				button:GetWidth() == 0 or 
				button:GetWidth() - text:GetWidth() > TITAN_PANEL_BUTTON_WIDTH_CHANGE_TOLERANCE or 
				button:GetWidth() - text:GetWidth() < -TITAN_PANEL_BUTTON_WIDTH_CHANGE_TOLERANCE ) then
			button:SetWidth(text:GetWidth());
			TitanPanelButton_Justify();
		end
	end
end

-- id is required
function TitanPanelButton_SetIconButtonWidth(id) 
	if (id) then
		local button = TitanUtils_GetButton(id);
		local icon = _G[button:GetName().."Icon"];
		if ( TitanUtils_GetPlugin(id).iconButtonWidth ) then
			button:SetWidth(TitanUtils_GetPlugin(id).iconButtonWidth);
		end		
	end
end

-- id is required
function TitanPanelButton_SetComboButtonWidth(id, setButtonWidth) 
	if (id) then
		local button = TitanUtils_GetButton(id);
		local text = _G[button:GetName().."Text"];
		local icon = _G[button:GetName().."Icon"];
		local iconWidth, iconButtonWidth, newButtonWidth;
		
		-- Get icon button width
		iconButtonWidth = 0;
		if ( TitanUtils_GetPlugin(id).iconButtonWidth ) then
			iconButtonWidth = TitanUtils_GetPlugin(id).iconButtonWidth;
		elseif ( icon:GetWidth() ) then
			iconButtonWidth = icon:GetWidth();
		end

		if ( TitanGetVar(id, "ShowIcon") and ( iconButtonWidth ~= 0 ) ) then
			icon:Show();
			text:ClearAllPoints();
			text:SetPoint("LEFT", icon:GetName(), "RIGHT", 2, 1);
			
			newButtonWidth = text:GetWidth() + iconButtonWidth + 2;
		else
			icon:Hide();
			text:ClearAllPoints();
			text:SetPoint("LEFT", button:GetName(), "Left", 0, 1);
			
			newButtonWidth = text:GetWidth();
		end
		
		if ( setButtonWidth or
				button:GetWidth() == 0 or 
				button:GetWidth() - newButtonWidth > TITAN_PANEL_BUTTON_WIDTH_CHANGE_TOLERANCE or 
				button:GetWidth() - newButtonWidth < -TITAN_PANEL_BUTTON_WIDTH_CHANGE_TOLERANCE ) then
			button:SetWidth(newButtonWidth);
			TitanPanelButton_Justify();
		end			
	end
end

-- id is required
function TitanPanelButton_SetTooltip(self, id)
-- ensure that the 'self' passed is a valid frame reference
if not self:GetName() then return end
   self.tooltipCustomFunction = nil;
	if (id and TitanUtils_IsPluginRegistered(id)) then
		local plugin = TitanUtils_GetPlugin(id);		
		if ( plugin.tooltipCustomFunction ) then
			self.tooltipCustomFunction = plugin.tooltipCustomFunction;
			TitanTooltip_SetPanelTooltip(self, id);
		elseif ( plugin.tooltipTitle ) then
			self.tooltipTitle = plugin.tooltipTitle;			
			local tooltipTextFunc = _G[plugin.tooltipTextFunction];
			if ( tooltipTextFunc ) then
				self.tooltipText = tooltipTextFunc();
			end
			TitanTooltip_SetPanelTooltip(self, id);
		end
	end
end

function TitanPanelButton_GetType(id)
	-- id is required
	if (not id) then
		return;
	end
	
	local button = TitanUtils_GetButton(id);
	local type;
	if button then
		local text = _G[button:GetName().."Text"];
		local icon = _G[button:GetName().."Icon"];

		if (text and icon) then
			type = TITAN_PANEL_BUTTON_TYPE_COMBO;
		elseif (text and not icon) then
			type = TITAN_PANEL_BUTTON_TYPE_TEXT;
		elseif (not text and icon) then
			type = TITAN_PANEL_BUTTON_TYPE_ICON;
		elseif (not text and not icon) then
			type = TITAN_PANEL_BUTTON_TYPE_CUSTOM;
		end
	else
		type = TITAN_PANEL_BUTTON_TYPE_COMBO;
	end
	
	return type;
end

function TitanPanelButton_IsText(id) 
	if (TitanPanelButton_GetType(id) == TITAN_PANEL_BUTTON_TYPE_TEXT) then
		return 1;
	end
end

function TitanPanelButton_IsIcon(id)
	if (TitanPanelButton_GetType(id) == TITAN_PANEL_BUTTON_TYPE_ICON) then
		return 1;
	end
end

function TitanPanelButton_IsCombo(id)
	if (TitanPanelButton_GetType(id) == TITAN_PANEL_BUTTON_TYPE_COMBO) then
		return 1;
	end
end

function TitanPanelButton_IsCustom(id)
	if (TitanPanelButton_GetType(id) == TITAN_PANEL_BUTTON_TYPE_CUSTOM) then
		return 1;
	end
end


function TitanPanelButton_OnDragStart(self, ChildButton)
	if TitanPanelGetVar("LockButtons") or InCombatLockdown() then return end
	
	local frname = self;
	if ChildButton then	  
		frname = self:GetParent();
	end	
	  local i,j;
	  for i, j in pairs(TitanPanelSettings.Buttons) do
	  local pluginid = _G["TitanPanel"..TitanPanelSettings.Buttons[i].."Button"];
	  if pluginid then pluginid:ClearAllPoints() end
	  end
		frname:StartMoving();
		frname.isMoving = true;		
		TitanUtils_CloseAllControlFrames();
			if (TitanPanelRightClickMenu_IsVisible()) then
				TitanPanelRightClickMenu_Close();
			end
		if AceLibrary and AceLibrary:HasInstance("Dewdrop-2.0") then AceLibrary("Dewdrop-2.0"):Close() end
		if AceLibrary and AceLibrary:HasInstance("Tablet-2.0") then AceLibrary("Tablet-2.0"):Close() end
		GameTooltip:Hide();
		-- LibQTip-1.0 support code
		LibQTip = LibStub("LibQTip-1.0", true)
		if LibQTip then
			local key, tip
				for key, tip in LibQTip:IterateTooltips() do
					if tip then
						local _, relativeTo = tip:GetPoint()
							if relativeTo and relativeTo:GetName() == self:GetName() then
								tip:Hide()
								break
							end
					end
				end
		end
		-- /LibQTip-1.0 support code
		TITAN_PANEL_MOVE_ADDON = TitanUtils_GetButtonID(self:GetName());
		if ChildButton then
		  TITAN_PANEL_MOVE_ADDON = TitanUtils_GetButtonID(self:GetParent():GetName());
		end
		TITAN_PANEL_MOVING = 1;
		pluginOnEnter = self:GetScript("OnEnter")
		self:SetScript("OnEnter", nil)
end

function TitanPanelButton_OnDragStop(self, ChildButton)
  if TitanPanelGetVar("LockButtons") then return end
  local nonmovableFrom = false;
  local nonmovableTo = false;
	local frname = self;
	if ChildButton then	  
		frname = self:GetParent();
	end
	if TITAN_PANEL_MOVING == 1 then
		frname:StopMovingOrSizing();
		frname.isMoving = false;
		TITAN_PANEL_MOVING = 0;
		
		local i,j;
	  for i, j in pairs(TitanPanelSettings.Buttons) do
	  local pluginid = _G["TitanPanel"..TitanPanelSettings.Buttons[i].."Button"];
	  	if (pluginid and MouseIsOver(pluginid)) and frname ~= pluginid then
	  		TITAN_PANEL_DROPOFF_ADDON = TitanPanelSettings.Buttons[i];	  		
	  	end
	  end
		
		-- hopefully this will be deprecated...
		for i, _ in ipairs(TITAN_PANEL_NONMOVABLE_PLUGINS) do
		  if TITAN_PANEL_MOVE_ADDON == TITAN_PANEL_NONMOVABLE_PLUGINS[i] then
		   nonmovableFrom = true;
		  end
		  if TITAN_PANEL_DROPOFF_ADDON == TITAN_PANEL_NONMOVABLE_PLUGINS[i] then
		   nonmovableTo = true;
		  end
		end
		
		-- switching sides is not allowed
		if (nonmovableTo == true and nonmovableFrom == false) or (nonmovableTo == false and nonmovableFrom == true) then
			TITAN_PANEL_DROPOFF_ADDON = nil;
		end
		
		-- switching sides is not allowed
		local from_on_right = (TitanGetVar(TITAN_PANEL_MOVE_ADDON, "DisplayOnRightSide") or false)
		local to_on_right = (TitanGetVar(TITAN_PANEL_MOVE_ADDON, "DisplayOnRightSide") or false)
		if (to_on_right == true and from_on_right == false) or (to_on_right == false and from_on_right == true) then
			TITAN_PANEL_DROPOFF_ADDON = nil;
		end
		
		local dropoff = TitanUtils_GetCurrentIndex(TitanPanelSettings.Buttons,TITAN_PANEL_DROPOFF_ADDON);
		local pickup = TitanUtils_GetCurrentIndex(TitanPanelSettings.Buttons,TITAN_PANEL_MOVE_ADDON);
		local dropoffbar = TitanUtils_GetWhichBar(TITAN_PANEL_DROPOFF_ADDON);
		local pickupbar = TitanUtils_GetWhichBar(TITAN_PANEL_MOVE_ADDON);

		if dropoff ~= nil and dropoff ~= "" then
			TitanPanelSettings.Buttons[dropoff] = TITAN_PANEL_MOVE_ADDON;
			TitanPanelSettings.Location[dropoff] = dropoffbar;
			TitanPanelSettings.Buttons[pickup] = TITAN_PANEL_DROPOFF_ADDON;
			TitanPanelSettings.Location[pickup] = pickupbar;
		end	
		
			TitanPanel_InitPanelButtons();
			TITAN_PANEL_MOVE_ADDON = nil;
			TITAN_PANEL_DROPOFF_ADDON = nil;			
			if pluginOnEnter then self:SetScript("OnEnter", pluginOnEnter) end
			pluginOnEnter = nil;
	end
end

-- Former TitanTooltip.lua (merged)
-- Set both the parent and the position of GameTooltip
function TitanTooltip_SetOwnerPosition(parent, anchorPoint, relativeToFrame, relativePoint, xOffset, yOffset)
	GameTooltip:SetOwner(parent, "ANCHOR_NONE");
	GameTooltip:SetPoint(anchorPoint, relativeToFrame, relativePoint, xOffset, yOffset);
	-- set alpha (transparency) for the Game Tooltip
	local red, green, blue = GameTooltip:GetBackdropColor();
	local red2, green2, blue2 = GameTooltip:GetBackdropBorderColor();
	GameTooltip:SetBackdropColor(red,green,blue,TitanPanelGetVar("TooltipTrans"));
	GameTooltip:SetBackdropBorderColor(red2,green2,blue2,TitanPanelGetVar("TooltipTrans"));
	-- set font size for the Game Tooltip
	if not TitanPanelGetVar("DisableTooltipFont") then
		if TitanTooltipScaleSet < 1 then
		TitanTooltipOrigScale = GameTooltip:GetScale();
		TitanTooltipScaleSet = TitanTooltipScaleSet + 1;
		end
		GameTooltip:SetScale(TitanPanelGetVar("TooltipFont"));
	end
end

function TitanTooltip_SetGameTooltip(self)
	if ( self.tooltipCustomFunction ) then
		self.tooltipCustomFunction();
	elseif ( self.tooltipTitle ) then
		GameTooltip:SetText(self.tooltipTitle, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);	
		if ( self.tooltipText ) then
			TitanTooltip_AddTooltipText(self.tooltipText);
		end
	end

	GameTooltip:Show();
end

function TitanTooltip_SetPanelTooltip(self, id)
	if not TitanPanelGetVar("ToolTipsShown") or (TitanPanelGetVar("HideTipsInCombat") and InCombatLockdown()) then return end
	if not self.tooltipCustomFunction and not self.tooltipTitle then return end

	-- Set GameTooltip
	local button = TitanUtils_GetButton(id);
	local position = TitanPanelGetVar("Position");
	local scale = TitanPanelGetVar("Scale");	
	local offscreenX, offscreenY;
	local i = TitanPanel_GetButtonNumber(id);

	if (TitanPanelSettings.Location[i] == "Bar") then 
		if position == TITAN_PANEL_PLACE_TOP then
			TitanTooltip_SetOwnerPosition(button, "TOPLEFT", button:GetName(), "BOTTOMLEFT", -10, -4 * scale);
			TitanTooltip_SetGameTooltip(self);
	
			-- Adjust GameTooltip position if it's off the screen
			offscreenX, offscreenY = TitanUtils_GetOffscreen(GameTooltip);
			if ( offscreenX == -1 ) then
				TitanTooltip_SetOwnerPosition(button, "TOPLEFT", "TitanPanelBarButton", "BOTTOMLEFT", 0, 0);
				TitanTooltip_SetGameTooltip(self);
			elseif ( offscreenX == 1 ) then
				TitanTooltip_SetOwnerPosition(button, "TOPRIGHT", "TitanPanelBarButton", "BOTTOMRIGHT", 0, 0);
				TitanTooltip_SetGameTooltip(self);	
			end	
		else
			TitanTooltip_SetOwnerPosition(button, "BOTTOMLEFT", button:GetName(), "TOPLEFT", -10, 4 * scale);
			TitanTooltip_SetGameTooltip(self);
	
			-- Adjust GameTooltip position if it's off the screen
			offscreenX, offscreenY = TitanUtils_GetOffscreen(GameTooltip);
			if ( offscreenX == -1 ) then
				TitanTooltip_SetOwnerPosition(button, "BOTTOMLEFT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", "TOPLEFT", 0, 0);
				TitanTooltip_SetGameTooltip(self);	
			elseif ( offscreenX == 1 ) then
				TitanTooltip_SetOwnerPosition(button, "BOTTOMRIGHT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", "TOPRIGHT", 0, 0);
				TitanTooltip_SetGameTooltip(self);	
			end
		end
	else
		TitanTooltip_SetOwnerPosition(button, "BOTTOMLEFT", button:GetName(), "TOPLEFT", -10, 4 * scale);
		TitanTooltip_SetGameTooltip(self);
	
		-- Adjust GameTooltip position if it's off the screen
		offscreenX, offscreenY = TitanUtils_GetOffscreen(GameTooltip);
		if ( offscreenX == -1 ) then
			TitanTooltip_SetOwnerPosition(button, "BOTTOMLEFT", "TitanPanelAuxBarButton", "TOPLEFT", 0, 0);
			TitanTooltip_SetGameTooltip(self);	
		elseif ( offscreenX == 1 ) then
			TitanTooltip_SetOwnerPosition(button, "BOTTOMRIGHT", "TitanPanelAuxBarButton", "TOPRIGHT", 0, 0);
			TitanTooltip_SetGameTooltip(self);	
		end
	end
end

function TitanTooltip_AddTooltipText(text)
	if ( text ) then
		-- Append a "\n" to the end 
		if ( string.sub(text, -1, -1) ~= "\n" ) then
			text = text.."\n";
		end
		
		for text1, text2 in string.gmatch(text, "([^\t\n]*)\t?([^\t\n]*)\n") do
			if ( text2 ~= "" ) then
				GameTooltip:AddDoubleLine(text1, text2);
			elseif ( text1 ~= "" ) then
				GameTooltip:AddLine(text1);
			else
				GameTooltip:AddLine("\n");
			end			
		end
	end
end