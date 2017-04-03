QuestHelper_File["textviewer.lua"] = "1.4.1"
QuestHelper_Loadtime["textviewer.lua"] = GetTime()

local viewer

local function viewer_cancelmove(self)
  if self.isMoving then
    self:StopMovingOrSizing()
    self.isMoving = false
  end
end

local function viewer_mousedown(self, button)
  if button == "LeftButton" then
    self:StartMoving()
    self.isMoving = true
  end
end

local function viewer_closebutton(self)
  for i = 1, #viewer.text do
    viewer.text[i]:SetText("")
  end
  viewer:Hide()
end

local frammis = {}

function QuestHelper:ShowText(text, title, width, border, divide)
  local border = border or 8
  local divide = divide or 4
  
  if type(text) == "string" then text = {text} end
  
  if not frammis[border] then frammis[border] = {} end
  viewer = frammis[border][divide]
  local suffix = string.format("_%d_%d", border, divide)
  
  if not viewer then
    viewer = CreateFrame("Frame", "QuestHelperTextViewer", nil) -- With no parent, this will always be visible.
    viewer:SetFrameStrata("FULLSCREEN_DIALOG")
    viewer:SetPoint("CENTER", UIParent)
    viewer:EnableMouse(true)
    viewer:SetMovable(true)
    QH_Hook(viewer, "OnMouseDown", viewer_mousedown)
    QH_Hook(viewer, "OnMouseUp", viewer_cancelmove)
    QH_Hook(viewer, "OnHide", viewer_cancelmove)
    
    -- This will cause it to be hidden if Esc is pressed.
    table.insert(UISpecialFrames, viewer:GetName())
    
    viewer.title = viewer:CreateFontString()
    viewer.title:SetFont(self.font.serif, 14)
    viewer.title:SetPoint("TOPLEFT", viewer, border, -border)
    viewer.title:SetPoint("RIGHT", viewer, -border, 0)
    
    viewer:SetBackdrop({
      bgFile = "Interface/Tooltips/UI-Tooltip-Background",
      edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
      edgeSize = 16,
      tile = true,
      tileSize = 16,
      insets = { left = 4, right = 4, top = 4, bottom = 4 }})
    viewer:SetBackdropColor(0, 0, 0, 0.8)
    viewer:SetBackdropBorderColor(1, 1, 1, 0.7)
    
    viewer.scrollframe = CreateFrame("ScrollFrame", "QuestHelperTextViewer_ScrollFrame" .. suffix, viewer, "UIPanelScrollFrameTemplate")
    
    viewer.scrollframe:SetPoint("LEFT", viewer, "LEFT", border, 0)
    viewer.scrollframe:SetPoint("TOP", viewer.title, "BOTTOM", 0, -divide)

    viewer.scrollbar = _G["QuestHelperTextViewer_ScrollFrame" .. suffix .. "ScrollBar"]
    --QuestHelperTextViewer_ScrollFrameThumbTexture = self:CreateIconTexture(viewer.scrollbar, 26)  -- Use the snazzy blue thumb
    viewer.scrollbar:SetBackdrop({                      -- Note: These settings are coppied from UIPanelScrollBarTemplateLightBorder in UIPanelTemplates.xml
      edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
      edgeSize = 12,
      tileSize = 16,
      insets = { left = 0, right = 0, top = 5, bottom = 5 }})

    viewer.closebutton = CreateFrame("Button", "QuestHelperTextViewer_CloseButton" .. suffix, viewer, "UIPanelCloseButton")
    viewer.closebutton:SetPoint("TOPRIGHT", viewer)
    QH_Hook(viewer.closebutton, "OnClick", viewer_closebutton)
    
    viewer.frame = CreateFrame("Frame", "QuestHelperTextViewer_Frame" .. suffix, viewer.scrollframe)
    viewer.scrollframe:SetScrollChild(viewer.frame)
    
    viewer.text = {}
  end
  
  local maxw = 0
  for i = 1, #text do
    if not viewer.text[i] then
      viewer.text[i] = viewer.frame:CreateFontString()
      viewer.text[i]:SetFont(self.font.sans, 12)
      viewer.text[i]:SetJustifyH("LEFT")
      if i > 1 then
        viewer.text[i]:SetPoint("TOPLEFT", viewer.text[i - 1], "BOTTOMLEFT")
      else
        viewer.text[i]:SetPoint("TOPLEFT", viewer.frame)
      end
    end
    
    viewer.text[i]:Show()
    viewer.text[i]:SetText(text[i] or "No text.")
    
    maxw = math.max(maxw, viewer.text[i]:GetStringWidth())
  end
  
  for i = #text + 1, #viewer.text do
    viewer.text[i]:Hide()
  end
  
  viewer:Show()
  viewer.title:SetText(title or "QuestHelper")
  viewer.scrollframe:SetVerticalScroll(0)
  
  local w = width or math.min(600, math.max(100, maxw))
  for i = 1, #viewer.text do
    viewer.text[i]:SetWidth(w)
  end
  viewer:SetWidth(w+border * 2)
  viewer.scrollframe:SetWidth(w)
  viewer.frame:SetWidth(w)
  
  local toth = 0
  for i = 1, #text do
    toth = toth + viewer.text[i]:GetHeight()
  end
  local h = math.max(10, toth)
  local title_h = viewer.title:GetHeight()
  
  if h > 400 then
    viewer.frame:SetHeight(400)
    viewer.scrollframe:SetHeight(400)
    viewer:SetHeight(420+title_h+border * 2+divide)
    viewer:SetWidth(w+border * 2 + 22)
    viewer.scrollbar:Show()
  else
    viewer.frame:SetHeight(h)
    viewer.scrollframe:SetHeight(h)
    viewer:SetHeight(h+border * 2 + divide+title_h)
    viewer.scrollbar:Hide()
    --[[
    WoW Bug: For some reason, setting the thumb texture on the scrollbar causes the following scenario:
      1. Display the viewer with scrollable text (eg /qh)
      2. Display the viewer with smaller text (eg /qh help filter)
    The second time the viewer is displayed, the close button doesn't show its normal state.
    When you hover over it, the glow appears.  If you press the left button over it, the depressed state appears.
    If you drag off of it, then release, the normal state appears, and the button is fine until you repeat 1 & 2.
    ]]
    viewer.closebutton:SetButtonState("PUSHED")   -- Workaround: there's a wierd quirk that's causing it to not show sometimes...
    viewer.closebutton:SetButtonState("NORMAL")   -- Workaround, part 2
  end
  
  frammis[border][divide] = viewer
  
end
