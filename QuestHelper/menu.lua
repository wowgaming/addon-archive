QuestHelper_File["menu.lua"] = "1.4.1"
QuestHelper_Loadtime["menu.lua"] = GetTime()

QuestHelper.active_menu = nil

local menuBorderInset = 4
local menuBackdrop = {
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    edgeSize = 16,
    tile = true,
    tileSize = 16,
    insets = { left = menuBorderInset, right = menuBorderInset, top = menuBorderInset, bottom = menuBorderInset }}
local menuBackdropColor = { 0, 0, 0, 0.65 }
local menuBackdropBorderColor = { 1, 1, 1, 0.7 }

local function Menu_AddItem(self, item)
  item:ClearAllPoints()
  item:SetParent(self)
  item:SetPoint("TOPLEFT", self, "TOPLEFT")
  item.parent = self
  table.insert(self.items, item)
end

local function Menu_SetCloseFunction(self, ...)
  self.func_arg = {...}
  self.func = table.remove(self.func_arg, 1)
end

local function Menu_OnUpdate(self, elapsed)
  if self.showing then
    self.show_phase = self.show_phase + elapsed * 5.0
    if self.show_phase > 1 then
      self.show_phase = 1
      QH_Hook(self, "OnUpdate", nil)
    end
  else
    self.show_phase = self.show_phase - elapsed * 3.0
    if self.show_phase < 0 then
      self.show_phase = 0
      QH_Hook(self, "OnUpdate", nil)
      self:Hide()
      if self.func then
        self.func(unpack(self.func_arg))
      end
      if self.auto_release then
        QuestHelper:ReleaseMenu(self)
        return
      end
    end
  end
  
  self:SetAlpha(self.show_phase)
end

local function Menu_DoShow(self)
  self.showing = true
  
  local w, h = 0, 0
  
  for i, c in ipairs(self.items) do
    local cw, ch = c:GetSize()
    w = math.max(w, cw)
    h = h + ch
  end
  
  local y = menuBorderInset
  
  self:SetWidth(w+2*menuBorderInset)
  self:SetHeight(h+2*menuBorderInset)
  self:Show()
  QH_Hook(self, "OnUpdate", self.OnUpdate)
  
  for i, c in ipairs(self.items) do
    local cw, ch = c:GetSize()
    c:ClearAllPoints()
    c:SetSize(w, ch)
    c:SetPoint("TOPLEFT", self, "TOPLEFT", menuBorderInset, -y)
    y = y + ch
  end
  
  if self.parent then
    self.level = self.parent.parent.level + #self.parent.parent.items + 1
    self:SetFrameStrata(self.parent:GetFrameStrata())   -- It should be sufficient to just set all to "TOOLTIP", but this seemed more versatile...
  else
    -- When there's no world map, or the world map is in a window, the menus
    -- are un-parented.  So make sure they're at a sufficient strata to be seen.
    self:SetFrameStrata("TOOLTIP")
  end
  
  self:SetFrameLevel(self.level)
  
  for i, n in ipairs(self.items) do
    n.level = self.level+i
    n:SetFrameLevel(n.level)
    n:SetFrameStrata(self:GetFrameStrata())
    n:DoShow()
  end
end

local function Menu_DoHide(self)
  self.showing = false
  QH_Hook(self, "OnUpdate", self.OnUpdate)
  
  if self.active_item then
    self.active_item.highlighting = false
    QH_Hook(self.active_item, "OnUpdate", self.active_item.OnUpdate)
  end
  
  for i, n in ipairs(self.items) do
    n:DoHide()
  end
end

local function Menu_ShowAtCursor(self, auto_release)
  auto_release = (auto_release == nil) and true or auto_release
  self.auto_release = auto_release

  -- Add a 'Close Menu' item to the end of the menu, if it's not there already
  if not self.close_item then
    self.close_item = QuestHelper:CreateMenuItem(self, QHText("MENU_CLOSE"))
    self.close_item:SetFunction( function() self:DoHide() end )
  end

  -- Set up the menu position, parentage, etc
  local x, y = GetCursorPosition()
  
  local parent = not UIParent:IsVisible() and QuestHelper.map_overlay_uncropped or UIParent
  self:SetParent(parent)
  self.level = (parent or UIParent):GetFrameLevel()+10
  self:ClearAllPoints()
  
  -- Need to call DoShow before setting the position so that the width and height will have been calculated.
  self:DoShow()
  
  -- I declare this math horrible and convoluted.
  local scale = parent and parent:GetEffectiveScale() or 1
  x, y = math.max(0, math.min(x-self:GetWidth()/2*scale, UIParent:GetRight()*UIParent:GetEffectiveScale()-self:GetWidth()*scale)) / scale,
         math.min(UIParent:GetTop()*UIParent:GetEffectiveScale(), math.max(self:GetHeight(), y+5)) / scale
  
  self:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
  
  if QuestHelper.active_menu and QuestHelper.active_menu ~= self then
    QuestHelper.active_menu:DoHide()
  end
  
  QuestHelper.active_menu = self
end


function QuestHelper:CreateMenu()
  local menu = self:CreateFrame(UIParent)
  menu:Hide()
  
  menu.items = self:CreateTable()
  menu:SetMovable(true)
  menu:SetFrameStrata("TOOLTIP") -- A good default, but we usually re-parent the menus, which clobbers this.
  menu:SetBackdrop(menuBackdrop)
  menu:SetBackdropColor(unpack(menuBackdropColor))
  menu:SetBackdropBorderColor(unpack(menuBackdropBorderColor))
  
  menu.AddItem = Menu_AddItem
  menu.SetCloseFunction = Menu_SetCloseFunction
  menu.OnUpdate = Menu_OnUpdate
  menu.DoShow = Menu_DoShow
  menu.DoHide = Menu_DoHide
  menu.ShowAtCursor = Menu_ShowAtCursor
  
  menu.show_phase = 0
  menu.showing = false
  menu.level = 2
  menu:SetFrameLevel(menu.level)
  
  return menu
end

function QuestHelper:ReleaseMenu(menu)
  while #menu.items > 0 do
    local item = table.remove(menu.items)
    self:ReleaseMenuItem(item)
  end
  
  if self.active_menu == menu then
    self.active_menu = nil
  end
  
  self:ReleaseTable(menu.items)
  self:ReleaseFrame(menu)
end

local function MenuItem_AddTexture(self, tex, before)
  if before then
    table.insert(self.lchildren, 1, tex)
  else
    table.insert(self.rchildren, tex)
  end
end

local function MenuItem_DoShow(self)
  self.showing = true
  QH_Hook(self, "OnUpdate", self.OnUpdate)
  self:Show()
end

local function MenuItem_DoHide(self)
  if self.submenu then
    self.submenu:DoHide()
  end
  
  self.showing = false
  QH_Hook(self, "OnUpdate", self.OnUpdate)
end

local function MenuItem_OnUpdate(self, elapsed)
  local done_update = true
  
  if self.highlighting then
    self.highlight_phase = self.highlight_phase + elapsed * 3.0
    if self.highlight_phase > 1 then
      self.highlight_phase = 1
    else
      done_update = false
    end
  else
    self.highlight_phase = self.highlight_phase - elapsed
    if self.highlight_phase < 0 then
      self.highlight_phase = 0
    else
      done_update = false
    end
  end
  
  if self.showing then
    self.show_phase = self.show_phase + elapsed * 5.0
    if self.show_phase > 1 then
      self.show_phase = 1
    else
      done_update = false
    end
  else
    self.show_phase = self.show_phase - elapsed * 5.0
    if self.show_phase < 0 then
      self.show_phase = 0
      self.highlight_phase = 0
      self:Hide()
      done_update = true
    else
      done_update = false
    end
  end
  
  self:Shade(self.show_phase, self.highlight_phase)
  
  if done_update then
    QH_Hook(self, "OnUpdate", nil)
  end
end

local function MenuItem_Shade(self, s, h)
  local theme = QuestHelper:GetColourTheme()
  
  local ih = 1-h
  
  self.text:SetTextColor(ih*theme.menu_text[1]+h*theme.menu_text_highlight[1],
                         ih*theme.menu_text[2]+h*theme.menu_text_highlight[2],
                         ih*theme.menu_text[3]+h*theme.menu_text_highlight[3], 1)
  
  self.text:SetShadowColor(0, 0, 0, ih)
  self.text:SetShadowOffset(1, -1)
  
  self.background:SetVertexColor(ih*theme.menu[1]+h*theme.menu_highlight[1],
                                 ih*theme.menu[2]+h*theme.menu_highlight[2],
                                 ih*theme.menu[3]+h*theme.menu_highlight[3], h*0.3+0.4)
  
  self:SetAlpha(s)
end

local function MenuItem_SetFunction(self, ...)
  self.func_arg = {...}
  self.func = table.remove(self.func_arg, 1)
end

local function MenuItem_SetSubmenu(self, menu)
  --[[ assert(not self.submenu and menu) ]]
  menu:ClearAllPoints()
  menu:SetParent(self)
  menu:SetPoint("TOPLEFT", self, "TOPLEFT")
  menu.parent = self
  self.submenu = menu
  self:AddTexture(QuestHelper:CreateIconTexture(self, 9))
end

local function MenuItem_OnEnter(self)
  self.highlighting = true
  QH_Hook(self, "OnUpdate", self.OnUpdate)
  
  if self.parent.active_item and self.parent.active_item ~= self then
    self.parent.active_item.highlighting = false
    QH_Hook(self.parent.active_item, "OnUpdate", self.parent.active_item.OnUpdate)
  end
  
  self.parent.active_item = self
  
  if self.parent.submenu and self.parent.submenu ~= self.submenu then
    self.parent.submenu:DoHide()
    self.parent.submenu = nil
  end
  
  if self.submenu then
    self.parent.submenu = self.submenu
    self.submenu:ClearAllPoints()
    
    local v, h1, h2 = "TOP", "LEFT", "RIGHT"
    
    self.submenu:DoShow()
    
    if self:GetRight()+self.submenu:GetWidth() > UIParent:GetRight()*UIParent:GetEffectiveScale() then
      h1, h2 = h2, h1
    end
    
    if self:GetBottom()-self.submenu:GetHeight() < 0 then
      v = "BOTTOM"
    end
    
    self.submenu:SetPoint(v..h1, self, v..h2)
    self.submenu:DoShow()
  end
end

local function MenuItem_GetSize(self)
  self.text:SetParent(UIParent) -- Remove the text's parent so that it doesn't inherit scaling and mess up the dimensions.
  self.text:ClearAllPoints()
  self.text:SetWidth(0)
  self.text:SetHeight(0)
  
  self.text_w = self.text:GetStringWidth()+20
  if self.text_w >= 320 then
    -- Clamp width to 320, then ballance the two rows (using a binary search)
    self.text:SetWidth(320)
    self.text_h = self.text:GetHeight()+1
    local mn, mx = 100, 321
    while mn ~= mx do
      local w = math.floor((mn+mx)*0.5)
      self.text:SetWidth(w-1)
      if self.text:GetHeight() <= self.text_h then
        mx = w
      else
        mn = w+1
      end
    end
    
    self.text_w = mn+1
    self.text:SetWidth(self.text_w)
  else
    self.text:SetWidth(self.text_w)
    self.text_h = self.text:GetHeight()+1
  end
  
  self.text:SetParent(self)
  
  local w, h = self.text_w+4, self.text_h+4
  
  for i, f in ipairs(self.lchildren) do
    w = w + f:GetWidth() + 4
    h = math.max(h, f:GetHeight() + 4)
  end
  
  for i, f in ipairs(self.rchildren) do
    w = w + f:GetWidth() + 4
    h = math.max(h, f:GetHeight() + 4)
  end
  
  self.needed_width = w
  
  return w, h
end

local function MenuItem_SetSize(self, w, h)
  self:SetWidth(w)
  self:SetHeight(h)
  
  local x = 0
  
  for i, f in ipairs(self.lchildren) do
    local cw, ch = f:GetWidth(), f:GetHeight()
    
    f:ClearAllPoints()
    f:SetPoint("TOPLEFT", self, "TOPLEFT", x+2, -(h-ch)*0.5)
    x = x + cw + 4
  end
  
  local x1 = x
  x = w
  
  for i, f in ipairs(self.rchildren) do
    local cw, ch = f:GetWidth(), f:GetHeight()
    f:ClearAllPoints()
    x = x - cw - 4
    f:SetPoint("TOPLEFT", self, "TOPLEFT", x+2, -(h-ch)*0.5)
  end
  
  self.text:ClearAllPoints()
  self.text:SetPoint("TOPLEFT", self, "TOPLEFT", x1+((x-x1)-self.text_w)*0.5, -(h-self.text_h)*0.5)
end

local function MenuItem_OnClick(self, btn)
  if btn == "RightButton" then
    local parent = self.parent
    while parent.parent do
      parent = parent.parent
    end
    parent:DoHide()
  elseif btn == "LeftButton" and self.func then
    self.func(unpack(self.func_arg))
    local parent = self.parent
    while parent.parent do
      parent = parent.parent
    end
    parent:DoHide()
  end
end

function QuestHelper:CreateMenuItem(menu, text)
  item = self:CreateFrame(menu)
  item:Hide()
  
  item.lchildren = self:CreateTable()
  item.rchildren = self:CreateTable()
  item.text = self:CreateText(item, text)
  item.background = self:CreateTexture(item, 1, 1, 1, 1)
  item.background:SetDrawLayer("BACKGROUND")
  item.background:SetAllPoints()
  item.background:SetVertexColor(0, 0, 0, 0)
  
  item.showing = false
  item.highlighting = false
  item.show_phase = 0
  item.highlight_phase = 0
  
  item.AddTexture = MenuItem_AddTexture
  item.DoShow = MenuItem_DoShow
  item.DoHide = MenuItem_DoHide
  item.OnUpdate = MenuItem_OnUpdate
  item.Shade = MenuItem_Shade
  item.SetFunction = MenuItem_SetFunction
  item.SetSubmenu = MenuItem_SetSubmenu
  item.OnEnter = MenuItem_OnEnter
  item.GetSize = MenuItem_GetSize
  item.SetSize = MenuItem_SetSize
  item.OnClick = MenuItem_OnClick
  
  item:RegisterForClicks("LeftButtonUp", "RightButtonDown")
  QH_Hook(item, "OnEnter", item.OnEnter)
  QH_Hook(item, "OnClick", item.OnClick)
  
  menu:AddItem(item)
  
  return item
end

function QuestHelper:ReleaseMenuItem(item)
  item:Hide()
  
  while #item.lchildren > 0 do
    local child = table.remove(item.lchildren)
    self:ReleaseTexture(child)
  end
  
  while #item.rchildren > 0 do
    local child = table.remove(item.rchildren)
    self:ReleaseTexture(child)
  end
  
  if item.submenu then
    self:ReleaseMenu(item.submenu)
    item.submenu = nil
  end
  
  self:ReleaseTable(item.lchildren)
  self:ReleaseTable(item.rchildren)
  self:ReleaseText(item.text)
  self:ReleaseTexture(item.background)
  self:ReleaseFrame(item)
end

local function MenuTitle_OnDragStart(self)
  local parent = self.parent
  
  while parent.parent do
    parent = parent.parent
  end
  
  parent:StartMoving()
end

local function MenuTitle_OnDragStop(self)
  local parent = self.parent
  
  while parent.parent do
    parent = parent.parent
  end
  
  parent:StopMovingOrSizing()
end

local function MenuTitle_Shade(self, s, h)
  local theme = QuestHelper:GetColourTheme()
  
  local ih = 1-h
  
  self.text:SetTextColor(ih*theme.menu_title_text[1]+h*theme.menu_title_text_highlight[1],
                         ih*theme.menu_title_text[2]+h*theme.menu_title_text_highlight[2],
                         ih*theme.menu_title_text[3]+h*theme.menu_title_text_highlight[3], 1)
  
  self.background:SetVertexColor(ih*theme.menu_title[1]+h*theme.menu_title_highlight[1],
                                 ih*theme.menu_title[2]+h*theme.menu_title_highlight[2],
                                 ih*theme.menu_title[3]+h*theme.menu_title_highlight[3], h*0.3+0.4)
  
  self.text:SetShadowColor(0, 0, 0, 1)
  self.text:SetShadowOffset(1, -1)
  
  self:SetAlpha(s)
end

local function MenuTitle_OnClick(self)
  local parent = self.parent
  
  while parent.parent do
    parent = parent.parent
  end
  
  parent:DoHide()
end

function QuestHelper:CreateMenuTitle(menu, title)
  local item = self:CreateMenuItem(menu, title)
  
  local f1, f2 = self:CreateTexture(item, "Interface\\AddOns\\QuestHelper\\Art\\Fluff.tga"),
                 self:CreateTexture(item, "Interface\\AddOns\\QuestHelper\\Art\\Fluff.tga")
  
  f1:SetTexCoord(0, 1, 0, .5)
  f1:SetWidth(20)
  f1:SetHeight(10)
  f2:SetTexCoord(0, 1, .5, 1)
  f2:SetWidth(20)
  f2:SetHeight(10)
  
  item:AddTexture(f1, true)
  item:AddTexture(f2, false)
  
  item.OnDragStart = MenuTitle_OnDragStart
  item.OnDragStop = MenuTitle_OnDragStop
  item.Shade = MenuTitle_Shade
  item.OnClick = MenuTitle_OnClick
  
  item:RegisterForClicks("RightButtonDown")
  QH_Hook(item, "OnClick", item.OnClick)
  QH_Hook(item, "OnDragStart", item.OnDragStart)
  QH_Hook(item, "OnDragStop", item.OnDragStop)
  item:RegisterForDrag("LeftButton")
  
  item.text:SetFont(QuestHelper.font.fancy, 11)
end
