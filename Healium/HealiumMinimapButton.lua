local MiniMapTexture = "Interface/Icons/Spell_Holy_LayOnHands"  -- Holy Light

function Healium_CreateMiniMapButton()
  local button = CreateFrame("Button", "HealiumMiniMap", Minimap)
  button:SetFrameStrata("MEDIUM")

  button.icon = button:CreateTexture("icon","BACKGROUND")
  button.overlay = button:CreateTexture("icon","OVERLAY")
  button.icon:SetAllPoints()
  button.overlay:SetAllPoints()

  local highlight = button:CreateTexture(nil, "HIGHLIGHT")
  highlight:SetBlendMode("ADD")
  highlight:SetPoint("CENTER", button, "CENTER", -1, -1)
  highlight:SetWidth(34)
  highlight:SetHeight(34)
  
  button:SetPushedTexture("Interface/Buttons/UI-Quickslot-Depress")
  
  highlight:SetTexture("Interface/Minimap/UI-Minimap-ZoomButton-Highlight")
  
  local tex = button:CreateTexture("MinimapButtonOverlay", "OVERLAY")
  tex:SetTexture("Interface/Minimap/MiniMap-TrackingBorder")
  tex:SetPoint("TOPLEFT", button, "TOPLEFT", -8, 6)
  tex:SetWidth(54)
  tex:SetHeight(54)

  button.icon:SetTexture(MiniMapTexture)

  button:EnableMouse(1)
  button:RegisterForDrag("RightButton")
  button:RegisterForClicks("LeftButtonUp")
  button:SetHeight(18)
  button:SetWidth(18)
  
  button:SetPoint("TOPLEFT","Minimap","TOPLEFT",62-(80*cos(5)),(80*sin(5))-62)
  
  button:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:SetText(Healium_AddonColor .. Healium_AddonName .. "|r |n|cFF55FF55Left Mouse |cFFFFFFFF" .. Healium_AddonName .. " Menu|n|cFF55FF55Right Mouse |cFFFFFFFFMove Button|n|cFF55FF55Shift & Left Mouse |cFFFFFFFF Toggle Frames")
    GameTooltip:Show()
  end)
  
   button:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
  end)
  
  -- [ Lua Only Approach For Making Dragable Frames (With Right Mouse Only) ]
  button:SetMovable(true)
  button:EnableMouse(true)
  local OnMouseDown = function(self) if(IsMouseButtonDown("RightButton")) then self:StartMoving() end end
  button:SetScript("OnMouseDown", OnMouseDown)
  button:SetScript("OnMouseUp",function(self) self:StopMovingOrSizing() end)

  button:SetScript("OnClick",function(self)  -------------------------
  
  if not (IsShiftKeyDown()) then
	ToggleDropDownMenu(1, nil, HealiumMenu, self, 0, 0)
  end
    
  if (IsShiftKeyDown()) then
	Healium_ToggleAllFrames()
  end
    
  end) ------------------------------------------------------------------
  
  Healium_MMButton = button
  
end