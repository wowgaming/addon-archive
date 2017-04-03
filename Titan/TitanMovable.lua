-- Globals
TITAN_PANEL_PLACE_TOP = 1;
TITAN_PANEL_PLACE_BOTTOM = 2;

local TitanMovableModule = LibStub("AceAddon-3.0"):NewAddon("TitanMovable", "AceHook-3.0", "AceTimer-3.0")
local _G = getfenv(0);
local InCombatLockdown	= _G.InCombatLockdown;

--Determines the optimal magic number based on resolution
local menuBarTop = 55;
local width, height = string.match((({GetScreenResolutions()})[GetCurrentResolution()] or ""), "(%d+).-(%d+)");
	if ( tonumber(width) / tonumber(height ) > 4/3 ) then
		--Widescreen resolution
		menuBarTop = 75;
	end


local TitanMovable = {};
local TitanMovableData = {
	PlayerFrame = {frameName = "PlayerFrame", frameArchor = "TOPLEFT", xArchor = "LEFT", y = -4, position = TITAN_PANEL_PLACE_TOP},
	TargetFrame = {frameName = "TargetFrame", frameArchor = "TOPLEFT", xArchor = "LEFT", y = -4, position = TITAN_PANEL_PLACE_TOP},
	PartyMemberFrame1 = {frameName = "PartyMemberFrame1", frameArchor = "TOPLEFT", xArchor = "LEFT", y = -128, position = TITAN_PANEL_PLACE_TOP},
	TicketStatusFrame = {frameName = "TicketStatusFrame", frameArchor = "TOPRIGHT", xArchor = "RIGHT", y = 0, position = TITAN_PANEL_PLACE_TOP},
	TemporaryEnchantFrame = {frameName = "TemporaryEnchantFrame", frameArchor = "TOPRIGHT", xArchor = "RIGHT", y = -13, position = TITAN_PANEL_PLACE_TOP},
	ConsolidatedBuffs = {frameName = "ConsolidatedBuffs", frameArchor = "TOPRIGHT", xArchor = "RIGHT", y = -13, position = TITAN_PANEL_PLACE_TOP},
	BuffFrame = {frameName = "BuffFrame", frameArchor = "TOPRIGHT", xArchor = "RIGHT", y = -13, position = TITAN_PANEL_PLACE_TOP},
	MinimapCluster = {frameName = "MinimapCluster", frameArchor = "TOPRIGHT", xArchor = "RIGHT", y = 0, position = TITAN_PANEL_PLACE_TOP},
	WorldStateAlwaysUpFrame = {frameName = "WorldStateAlwaysUpFrame", frameArchor = "TOP", xArchor = "CENTER", y = -15, position = TITAN_PANEL_PLACE_TOP},
	MainMenuBar = {frameName = "MainMenuBar", frameArchor = "BOTTOM", xArchor = "CENTER", y = 0, position = TITAN_PANEL_PLACE_BOTTOM},
	MultiBarRight = {frameName = "MultiBarRight", frameArchor = "BOTTOMRIGHT", xArchor = "RIGHT", y = 98, position = TITAN_PANEL_PLACE_BOTTOM},
	VehicleMenuBar = {frameName = "VehicleMenuBar", frameArchor = "BOTTOM", xArchor = "CENTER", y = 0, position = TITAN_PANEL_PLACE_BOTTOM},	
}

function TitanMovableFrame_AdjustBlizzardFrames()
	if not InCombatLockdown() then
		Titan_FCF_UpdateDockPosition();
		Titan_FCF_UpdateCombatLogPosition();
		Titan_ContainerFrames_Relocate();
	end
end

function TitanMovableFrame_CheckFrames(position)
	local top, bottom, panelYOffset, frameTop;
	
	TitanMovable = {};
		
	if (position == TITAN_PANEL_PLACE_TOP) then
	
		panelYOffset = TitanMovable_GetPanelYOffset(TITAN_PANEL_PLACE_TOP, TitanPanelGetVar("BothBars"));
		
		-- Move PlayerFrame		
			frameTop = TitanMovableFrame_GetOffset(PlayerFrame, "TOP");
			top = -4 + panelYOffset;
			TitanMovableFrame_CheckTopFrame(frameTop, top, PlayerFrame:GetName())
			
		-- Move TargetFrame		
			frameTop = TitanMovableFrame_GetOffset(TargetFrame, "TOP");
			top = -4 + panelYOffset;
			TitanMovableFrame_CheckTopFrame(frameTop, top, TargetFrame:GetName())		

		-- Move PartyMemberFrame		
			frameTop = TitanMovableFrame_GetOffset(PartyMemberFrame1, "TOP");
			top = -128 + panelYOffset;
			TitanMovableFrame_CheckTopFrame(frameTop, top, PartyMemberFrame1:GetName())

		-- Move TicketStatusFrame
		if TitanPanelGetVar("TicketAdjust") then
			frameTop = TitanMovableFrame_GetOffset(TicketStatusFrame, "TOP");
			top = 0 + panelYOffset;
			TitanMovableFrame_CheckTopFrame(frameTop, top, TicketStatusFrame:GetName())
		end
		
		-- Move TemporaryEnchantFrame. Seems this will be deprecated in the future in favor of BuffFrame ...
		frameTop = TitanMovableFrame_GetOffset(TemporaryEnchantFrame, "TOP");
		if TicketStatusFrame:IsVisible() then
			top = 0 - TicketStatusFrame:GetHeight() + panelYOffset;
		else
			top = -13 + panelYOffset;
		end
		TitanMovableFrame_CheckTopFrame(frameTop, top, TemporaryEnchantFrame:GetName())
	
		-- Move MinimapCluster
		if not CleanMinimap then
		 if not TitanPanelGetVar("MinimapAdjust") then
			frameTop = TitanMovableFrame_GetOffset(MinimapCluster, "TOP");
			top = 0 + panelYOffset; 		
			TitanMovableFrame_CheckTopFrame(frameTop, top, MinimapCluster:GetName())
		 end
		end
		-- Move BuffFrame
		frameTop = TitanMovableFrame_GetOffset(BuffFrame, "TOP");
		if BuffFrame:IsVisible() then
			top = 0 - BuffFrame:GetHeight() + panelYOffset;
		else
			top = -13 + panelYOffset;
		end
		TitanMovableFrame_CheckTopFrame(frameTop, top, BuffFrame:GetName())
		TitanMovableFrame_CheckTopFrame(frameTop, top, ConsolidatedBuffs:GetName())

		-- Move WorldStateAlwaysUpFrame				
			frameTop = TitanMovableFrame_GetOffset(WorldStateAlwaysUpFrame, "TOP");
			top = -15 + panelYOffset; 		
			TitanMovableFrame_CheckTopFrame(frameTop, top, WorldStateAlwaysUpFrame:GetName());

	elseif (position == TITAN_PANEL_PLACE_BOTTOM) then

		panelYOffset = TitanMovable_GetPanelYOffset(TITAN_PANEL_PLACE_BOTTOM, TitanPanelGetVar("BothBars"));
		
		-- Move MainMenuBar		
			bottom = 0 + panelYOffset;
			frameBottom = TitanMovableFrame_GetOffset(MainMenuBar, "BOTTOM");
			TitanMovableFrame_CheckBottomFrame(frameBottom, bottom, MainMenuBar:GetName());
	
		-- Move MultiBarRight
		bottom = 98 + panelYOffset;
		frameBottom = TitanMovableFrame_GetOffset(MultiBarRight, "BOTTOM");
		TitanMovableFrame_CheckBottomFrame(frameBottom, bottom, MultiBarRight:GetName());
		
		-- Move VehicleMenuBar		
			TitanMovableFrame_CheckBottomFrame(_, _, VehicleMenuBar:GetName());
	end

end

function TitanMovableFrame_MoveFrames(position, override)
	local frameData, frame, frameName, frameArchor, xArchor, y, xOffset, yOffset, panelYOffset;
	
	if not InCombatLockdown() then
		for index, value in pairs(TitanMovable) do						
			frameData = TitanMovableData[value];
			if frameData then
				frame = _G[frameData.frameName];
				frameName = frameData.frameName;
				frameArchor = frameData.frameArchor;
			end

			if frame and (not frame:IsUserPlaced()) then
				xArchor = frameData.xArchor;
				y = frameData.y;
				
				panelYOffset = TitanMovable_GetPanelYOffset(frameData.position, TitanPanelGetVar("BothBars"), override);
				xOffset = TitanMovableFrame_GetOffset(frame, xArchor);
				
				-- properly adjust buff frame(s) if GM Ticket is visible
				if (frameName == "TemporaryEnchantFrame" or frameName == "ConsolidatedBuffs")
					and TicketStatusFrame:IsVisible() and TitanPanelGetVar("TicketAdjust") then
					yOffset = (-TicketStatusFrame:GetHeight()) + panelYOffset
				else
					yOffset = y + panelYOffset;
				end

				-- properly adjust MinimapCluster if its border is hidden
				if frameName == "MinimapCluster" and MinimapBorderTop and not MinimapBorderTop:IsShown() then					
					yOffset = yOffset + (MinimapBorderTop:GetHeight() * 3/5) - 5
				end
				
				-- adjust the MainMenuBar according to its scale
				if  frameName == "MainMenuBar" and MainMenuBar:IsVisible() then
				local framescale = MainMenuBar:GetScale() or 1;
				    yOffset =  yOffset / framescale;
				end
				
				-- account for Reputation Status Bar (doh)
				local playerlevel = UnitLevel("player");
				if frameName == "MultiBarRight" and ReputationWatchStatusBar:IsVisible() and playerlevel < _G["MAX_PLAYER_LEVEL"] then
					yOffset = yOffset + 8;
				end
				
				
				frame:ClearAllPoints();		
				frame:SetPoint(frameArchor, "UIParent", frameArchor, xOffset, yOffset);
			else
				--Leave frame where it is as it has been moved by a user
			end			
			updateContainerFrameAnchors();
		end
	end
end

function TitanMovableFrame_GetOffset(frame, point)	
	if frame and point then
		if point == "LEFT" and frame:GetLeft() and UIParent:GetLeft() then
			return frame:GetLeft() - UIParent:GetLeft();
		elseif point == "RIGHT" and frame:GetRight() and UIParent:GetRight() then
			return frame:GetRight() - UIParent:GetRight();			
		elseif point == "TOP" and frame:GetTop() and UIParent:GetTop() then
			return frame:GetTop() - UIParent:GetTop();
		elseif point == "BOTTOM" and frame:GetBottom() and UIParent:GetBottom() then
			return frame:GetBottom() - UIParent:GetBottom();
		elseif point == "CENTER" and frame:GetLeft() and frame:GetRight() and UIParent:GetLeft() and UIParent:GetRight() then
		   local framescale = frame and frame.GetScale and frame:GetScale() or 1;
			return (frame:GetLeft()* framescale + frame:GetRight()* framescale - UIParent:GetLeft() - UIParent:GetRight()) / 2;
		end
	end	
	return 0;
end

function TitanMovable_GetPanelYOffset(framePosition, bothbars, override)
	local barPosition = TitanPanelGetVar("Position");
	local barnumber = 0;

	if override then
		if framePosition == TITAN_PANEL_PLACE_TOP then
			if TitanPanelGetVar("ScreenAdjust") then
				return 0;
			end
		elseif framePosition == TITAN_PANEL_PLACE_BOTTOM and bothbars == nil then
			if TitanPanelGetVar("ScreenAdjust") then
				return 0;
			end
		elseif framePosition == TITAN_PANEL_PLACE_BOTTOM and bothbars == 1 then
			if TitanPanelGetVar("AuxScreenAdjust") then
				return 0;
			end
		else
			return 0;
		end
	end
	
	if bothbars ~= nil then
		barPosition = framePosition;
	else
		barPosition = TitanPanelGetVar("Position");
	end
	
	barnumber = TitanUtils_GetDoubleBar(bothbars, framePosition);
	
	local scale = TitanPanelGetVar("Scale");
	if scale and framePosition and barPosition and framePosition == barPosition then
		if  framePosition == TITAN_PANEL_PLACE_TOP then
			return (-24 * scale)*(barnumber);
		elseif framePosition == TITAN_PANEL_PLACE_BOTTOM then
			return (24 * scale)*(barnumber);
		end
	end
	return 0;
end

function TitanMovableFrame_CheckTopFrame(frameTop, top, frameName)
	table.insert(TitanMovable, frameName)
end

function TitanMovableFrame_CheckBottomFrame(frameBottom, bottom, frameName)
	table.insert(TitanMovable, frameName)
end

function Titan_TicketStatusFrame_OnShow()  -- always check the routine we are overriding!
	-- The Blizz routine moved the buffs the the right. This keeps them where they were to avoid
	-- odd placement of the temp & consolidated buffs. Depending on the exact steps used the 
	-- placement of temp buffs is inconsistent (likely Blizz but more testing needed)
	local panelYOffset = TitanMovable_GetPanelYOffset(TITAN_PANEL_PLACE_TOP, TitanPanelGetVar("BothBars"));
	if not InCombatLockdown() or (InCombatLockdown() and not TemporaryEnchantFrame:IsProtected()) then
		if not TitanPanelGetVar("ScreenAdjust") and TitanPanelGetVar("TicketAdjust") then
			ConsolidatedBuffs:SetPoint("TOPRIGHT", TicketStatusFrame:GetParent(), "TOPRIGHT", -180, (-TicketStatusFrame:GetHeight() + panelYOffset));
		else
			ConsolidatedBuffs:SetPoint("TOPRIGHT", TicketStatusFrame:GetParent(), "TOPRIGHT", -180, (-TicketStatusFrame:GetHeight()));
		end
	end
	TitanMovableFrame_CheckFrames(1);
	TitanMovableFrame_MoveFrames(1, TitanPanelGetVar("ScreenAdjust"));
--	ConsolidatedBuffs:SetPoint("TOPRIGHT", self:GetParent(), "TOPRIGHT", -205, (-self:GetHeight()));
end

function Titan_TicketStatusFrame_OnHide()
	local panelYOffset = TitanMovable_GetPanelYOffset(TITAN_PANEL_PLACE_TOP, TitanPanelGetVar("BothBars"));
	if not GMChatStatusFrame or not GMChatStatusFrame:IsShown() then -- this is to replicate Blizzard's check in FrameXML/HelpFrame.xml
		if not InCombatLockdown() or (InCombatLockdown() and not TemporaryEnchantFrame:IsProtected()) then
			if not TitanPanelGetVar("ScreenAdjust") then
				ConsolidatedBuffs:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -180, -13 + panelYOffset);
			else
				ConsolidatedBuffs:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -180, -13);
			end
		end
	end
	TitanMovableFrame_CheckFrames(1);
	TitanMovableFrame_MoveFrames(1, TitanPanelGetVar("ScreenAdjust"));
--[[
	if( not GMChatStatusFrame or not GMChatStatusFrame:IsShown() ) then
		ConsolidatedBuffs:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -180, -13);
	end
--]]
end

function Titan_FCF_UpdateDockPosition()
 if not TitanPanelGetVar("LogAdjust") then return end
	if not InCombatLockdown() or (InCombatLockdown() and not _G["DEFAULT_CHAT_FRAME"]:IsProtected()) then
		local panelYOffset = TitanMovable_GetPanelYOffset(TITAN_PANEL_PLACE_BOTTOM, TitanPanelGetVar("BothBars"));
		local scale = TitanPanelGetVar("Scale");
		if scale then
			panelYOffset = panelYOffset + (24 * scale) -- after 3.3.5 an additional adjust was needed. why? idk
		end

--[[
		if _G["DEFAULT_CHAT_FRAME"]:IsUserPlaced() then
			if _G["SIMPLE_CHAT"] ~= "1" then return end
		end
		
		local chatOffset = 85 + panelYOffset;
		if GetNumShapeshiftForms() > 0 or HasPetUI() or PetHasActionBar() then
			if MultiBarBottomLeft:IsVisible() then
				chatOffset = chatOffset + 55;
			else
				chatOffset = chatOffset + 15;
			end
		elseif MultiBarBottomLeft:IsVisible() then
			chatOffset = chatOffset + 15;
		end
		_G["DEFAULT_CHAT_FRAME"]:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 32, chatOffset);
		FCF_DockUpdate();
--]]
	if ( DEFAULT_CHAT_FRAME:IsUserPlaced() ) then
		return;
	end
	
	local chatOffset = 85 + panelYOffset; -- Titan
	if ( GetNumShapeshiftForms() > 0 or HasPetUI() or PetHasActionBar() ) then
		if ( MultiBarBottomLeft:IsShown() ) then
			chatOffset = chatOffset + 55;
		else
			chatOffset = chatOffset + 15;
		end
	elseif ( MultiBarBottomLeft:IsShown() ) then
		chatOffset = chatOffset + 15;
	end
	DEFAULT_CHAT_FRAME:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 32, chatOffset);
	FCF_DockUpdate();

	end
end

function Titan_FCF_UpdateCombatLogPosition()
--[[
 if not TitanPanelGetVar("LogAdjust") then return end
	if not InCombatLockdown() or (InCombatLockdown() and not ChatFrame1:IsProtected() and not ChatFrame2:IsProtected()) then
		local panelYOffset = TitanMovable_GetPanelYOffset(TITAN_PANEL_PLACE_BOTTOM, TitanPanelGetVar("BothBars"));

		local point1, _, relativePoint1, xOfs1, _ = ChatFrame1:GetPoint()
		local point2, relativeTo, relativePoint2, xOfs2, yOfs2 = ChatFrame2:GetPoint()		  
		  
			--local xOffset = 0;
		  local yOffset = 85 + panelYOffset;
			local yOffset2 = 85 + panelYOffset;
			if MultiBarBottomLeft:IsShown() then
				yOffset = yOffset + 20;
				yOffset2 = yOffset2 + 50;
				if GetNumShapeshiftForms() > 0 or HasPetUI() or PetHasActionBar() then 
				else
				yOffset2 = yOffset2 - 50;
				yOffset2 = yOffset2 + 15;
				end
			elseif MultiBarBottomRight:IsShown() then
				yOffset = yOffset + 20;
				yOffset2 = yOffset2 + 50;
				if GetNumShapeshiftForms() > 0 or HasPetUI() or PetHasActionBar() then 
				else
				yOffset2 = yOffset2 - 50;
				yOffset2 = yOffset2 + 15;
				end
			else
				yOffset = yOffset + 5;
				yOffset2 = yOffset2 + 15;
			end
		 -- account for Reputation Status Bar (doh)
		  local playerlevel = UnitLevel("player");
			if ReputationWatchStatusBar:IsVisible() and playerlevel < _G["MAX_PLAYER_LEVEL"] then
		  	yOffset = yOffset + 8;
				yOffset2 = yOffset2 + 8;
		  end
		  -- account for MultiCastActionBarFrame (Shaman Bar)
		  if HasMultiCastActionBar() then yOffset2 = yOffset2 + 38 end
	
			--ChatFrame1:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 32, yOffset2);
			--ChatFrame2:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", xOffset, yOffset);
			if point1 == "BOTTOMLEFT" and relativePoint1 == "BOTTOMLEFT" then
				ChatFrame1:SetPoint(point1, "UIParent", relativePoint1, xOfs1, yOffset2);
			end
			if relativeTo == nil and point2 == "BOTTOMRIGHT" and relativePoint2 == "BOTTOMRIGHT" then
				ChatFrame2:SetPoint(point2, "UIParent", relativePoint2, xOfs2, yOffset);
			end
	end
--]]
end


function Titan_ContainerFrames_Relocate()
	if not TitanPanelGetVar("BagAdjust") then return end
		local panelYOffset = TitanMovable_GetPanelYOffset(TITAN_PANEL_PLACE_BOTTOM, TitanPanelGetVar("BothBars"), 1);
		local TITAN_CONTAINER_OFFSET_Y = _G["CONTAINER_OFFSET_Y"]
		local TITAN_CONTAINER_OFFSET_X = _G["CONTAINER_OFFSET_X"]
		-- Get the Blizzard offsets from the relevant table
		local BlizzContainerYoffs, BlizzContainerYoffsABoffs = 0, 0
		if _G["UIPARENT_MANAGED_FRAME_POSITIONS"]["CONTAINER_OFFSET_Y"].yOffset then
			BlizzContainerYoffs = _G["UIPARENT_MANAGED_FRAME_POSITIONS"]["CONTAINER_OFFSET_Y"].yOffset
		end
		if _G["UIPARENT_MANAGED_FRAME_POSITIONS"]["CONTAINER_OFFSET_Y"].bottomEither then
			BlizzContainerYoffsABoffs = _G["UIPARENT_MANAGED_FRAME_POSITIONS"]["CONTAINER_OFFSET_Y"].bottomEither
		end
		-- experimental fixes
		-- Update bag anchor
		if MultiBarBottomRight:IsShown() or MultiBarBottomLeft:IsShown() then
			TITAN_CONTAINER_OFFSET_Y = menuBarTop + BlizzContainerYoffs + BlizzContainerYoffsABoffs + panelYOffset;
		elseif not MultiBarBottomRight:IsVisible() and not MultiBarBottomLeft:IsVisible() then
			TITAN_CONTAINER_OFFSET_Y = menuBarTop + BlizzContainerYoffs + panelYOffset;
		else
		  TITAN_CONTAINER_OFFSET_Y = 70 + panelYOffset;
		end
		
		-- account for Reputation Status Bar (doh)		
		local playerlevel = UnitLevel("player");
		if ReputationWatchStatusBar:IsVisible() and playerlevel < _G["MAX_PLAYER_LEVEL"] then
		  TITAN_CONTAINER_OFFSET_Y = TITAN_CONTAINER_OFFSET_Y + 9;
		end
		
		if MultiBarLeft:IsShown() then
			TITAN_CONTAINER_OFFSET_X = 93;
		elseif MultiBarRight:IsShown() then
			TITAN_CONTAINER_OFFSET_X = 48;
		else
			TITAN_CONTAINER_OFFSET_X = 0;
		end
		
	-- WoW 3.2 : This is basically a modified version of Blizzard's own function to move the container frames without tainting the global offset vars
	-- Very ugly but its the only way for the new Shaman bar to function properly
	local frame, xOffset, yOffset, screenHeight, freeScreenHeight, leftMostPoint, column;
  local screenWidth = GetScreenWidth()
  local containerScale = 1;
  local leftLimit = 0;
  if BankFrame:IsShown() then leftLimit = BankFrame:GetRight() - 25 end

  while containerScale > _G["CONTAINER_SCALE"] do
    screenHeight = GetScreenHeight() / containerScale;
    -- Adjust the start anchor for bags depending on the multibars
    xOffset = TITAN_CONTAINER_OFFSET_X / containerScale;
    yOffset = TITAN_CONTAINER_OFFSET_Y / containerScale;
    -- freeScreenHeight determines when to start a new column of bags
    freeScreenHeight = screenHeight - yOffset;
    leftMostPoint = screenWidth - xOffset;
    column = 1;
    local frameHeight;
    for index, frameName in ipairs(ContainerFrame1.bags) do
      frameHeight = _G[frameName]:GetHeight();
      if freeScreenHeight < frameHeight then
        -- Start a new column
        column = column + 1;
        leftMostPoint = screenWidth - ( column * _G["CONTAINER_WIDTH"] * containerScale ) - xOffset;
        freeScreenHeight = screenHeight - yOffset;
      end
      freeScreenHeight = freeScreenHeight - frameHeight - _G["VISIBLE_CONTAINER_SPACING"];
    end
    if leftMostPoint < leftLimit then
      containerScale = containerScale - 0.01;
    else
      break;
    end
  end

  if containerScale < _G["CONTAINER_SCALE"] then containerScale = _G["CONTAINER_SCALE"] end

  screenHeight = GetScreenHeight() / containerScale;
  -- Adjust the start anchor for bags depending on the multibars
  xOffset = TITAN_CONTAINER_OFFSET_X / containerScale;
  yOffset = TITAN_CONTAINER_OFFSET_Y / containerScale;
  -- freeScreenHeight determines when to start a new column of bags
  freeScreenHeight = screenHeight - yOffset;
  column = 0;
  for index, frameName in ipairs(ContainerFrame1.bags) do
    frame = _G[frameName];
    frame:SetScale(containerScale);
    if index == 1 then
      -- First bag
      frame:SetPoint("BOTTOMRIGHT", frame:GetParent(), "BOTTOMRIGHT", -xOffset, yOffset );
    elseif freeScreenHeight < frame:GetHeight() then
      -- Start a new column
      column = column + 1;
      freeScreenHeight = screenHeight - yOffset;
      frame:SetPoint("BOTTOMRIGHT", frame:GetParent(), "BOTTOMRIGHT", -(column * _G["CONTAINER_WIDTH"]) - xOffset, yOffset );
    else
      -- Anchor to the previous bag
      frame:SetPoint("BOTTOMRIGHT", ContainerFrame1.bags[index - 1], "TOPRIGHT", 0, _G["CONTAINER_SPACING"]);
    end
    freeScreenHeight = freeScreenHeight - frame:GetHeight() - _G["VISIBLE_CONTAINER_SPACING"];
  end

end

function Titan_ManageFramesNew()
-- Move frames
 	Titan_FCF_UpdateCombatLogPosition(); 	
 
		   if (TitanPanelGetVar("BothBars") and not TitanPanelGetVar("AuxScreenAdjust")) or (TitanPanelGetVar("Position") == 2 and not TitanPanelGetVar("ScreenAdjust")) then
		   	TitanMovableFrame_CheckFrames(TITAN_PANEL_PLACE_BOTTOM);
			 	TitanMovableFrame_MoveFrames(TITAN_PANEL_PLACE_BOTTOM, TitanPanelGetVar("AuxScreenAdjust"));
			 	Titan_ContainerFrames_Relocate();
			 end
end

local function Titan_ManageTopFramesVehicle()
	TitanMovableFrame_CheckFrames(1);
	TitanMovableFrame_MoveFrames(1, TitanPanelGetVar("ScreenAdjust"));
end

local function Titan_ManageVehicles()		
		TitanMovableModule:CancelAllTimers()
		TitanMovableModule:ScheduleTimer(Titan_ManageTopFramesVehicle, 2)
		TitanMovableModule:ScheduleTimer(Titan_ManageFramesNew, 2)
end

function Titan_AdjustScale()		
	TitanPanel_SetScale();
	
	TitanPanel_ClearAllBarTextures()
	TitanPanel_CreateBarTextures()

	TitanPanel_SetPosition("TitanPanelBarButton", TitanPanelGetVar("Position"));
	TitanPanel_SetTexture("TitanPanelBarButton", TitanPanelGetVar("Position"));
	TitanPanel_CreateBarTextures()
	TitanPanel_SetTexture("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
	-- Handle AutoHide
	if (TitanPanelGetVar("AutoHide")) then TitanPanelBarButton_Hide("TitanPanelBarButton", TitanPanelGetVar("Position")) end
	if (TitanPanelGetVar("AuxAutoHide")) then TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM) end
	TitanPanel_RefreshPanelButtons();
end

local function Titan_AdjustUIScale()	
	-- Refresh panel scale and buttons	
	Titan_AdjustScale()
end


-- Titan Hooks
-- Overwrite Blizzard Frame positioning functions
--[
TitanMovableModule:SecureHook(TicketStatusFrame, "Show", Titan_TicketStatusFrame_OnShow)
TitanMovableModule:SecureHook(TicketStatusFrame, "Hide", Titan_TicketStatusFrame_OnHide)
TitanMovableModule:SecureHook("FCF_UpdateDockPosition", Titan_FCF_UpdateDockPosition)
--TitanMovableModule:SecureHook("FCF_UpdateCombatLogPosition", Titan_FCF_UpdateCombatLogPosition)
TitanMovableModule:SecureHook("updateContainerFrameAnchors", Titan_ContainerFrames_Relocate)
TitanMovableModule:SecureHook(WorldMapFrame, "Hide", Titan_ManageFramesNew)
TitanMovableModule:SecureHook("UIParent_ManageFramePositions", Titan_ManageFramesNew)
TitanMovableModule:SecureHook("VehicleSeatIndicator_SetUpVehicle", Titan_ManageVehicles)
TitanMovableModule:SecureHook("VehicleSeatIndicator_UnloadTextures", Titan_ManageVehicles)
-- Properly Adjust UI Scale if set
-- Note: These are the least intrusive hooks we could think of, to properly adjust the Titan Bar(s)
-- without having to resort to a SetCvar secure hook. Any addon using SetCvar should make sure to use the 3rd
-- argument in the API call and trigger the CVAR_UPDATE event with an appropriate argument so that other addons
-- can detect this behavior and fire their own functions (where applicable).
TitanMovableModule:SecureHook("VideoOptionsFrameOkay_OnClick", Titan_AdjustUIScale)
TitanMovableModule:SecureHook(VideoOptionsFrame, "Hide", Titan_AdjustUIScale)
--]]
--[[
hooksecurefunc(TicketStatusFrame, "Show", Titan_TicketStatusFrame_OnShow) -- HelpFrame.xml
hooksecurefunc(TicketStatusFrame, "Hide", Titan_TicketStatusFrame_OnHide) -- HelpFrame.xml
hooksecurefunc("FCF_UpdateDockPosition", Titan_FCF_UpdateDockPosition) -- FloatingChatFrame
--hooksecurefunc("FCF_UpdateCombatLogPosition", Titan_FCF_UpdateCombatLogPosition)
hooksecurefunc("updateContainerFrameAnchors", Titan_ContainerFrames_Relocate) -- ContainerFrame.lua
hooksecurefunc(WorldMapFrame, "Hide", Titan_ManageFramesNew) -- WorldMapFrame.lua
hooksecurefunc("UIParent_ManageFramePositions", Titan_ManageFramesNew) -- UIParent.lua
hooksecurefunc("VehicleSeatIndicator_SetUpVehicle", Titan_ManageVehicles) -- VehicleMenuBar.lua
hooksecurefunc("VehicleSeatIndicator_UnloadTextures", Titan_ManageVehicles) -- VehicleMenuBar.lua
-- Properly Adjust UI Scale if set
-- Note: These are the least intrusive hooks we could think of, to properly adjust the Titan Bar(s)
-- without having to resort to a SetCvar secure hook. Any addon using SetCvar should make sure to use the 3rd
-- argument in the API call and trigger the CVAR_UPDATE event with an appropriate argument so that other addons
-- can detect this behavior and fire their own functions (where applicable).
hooksecurefunc("VideoOptionsFrameOkay_OnClick", Titan_AdjustUIScale) -- VideoOptionsFrame.lua
hooksecurefunc(VideoOptionsFrame, "Hide", Titan_AdjustUIScale) -- VideoOptionsFrame.xml
--]]