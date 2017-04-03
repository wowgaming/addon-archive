QuestHelper_File["mapbutton.lua"] = "1.4.1"
QuestHelper_Loadtime["mapbutton.lua"] = GetTime()

--[[
   mapbutton.lua

   This module contains code to place a button on the Map Frame, and provides the
   functionality of that button.

   Currently Functionality:
   - Left click on button is equivalent to /qh hide
   - Right-click on button shows Settings menu
   - Button has tooltip to that effect
   - Button serves as hook to detect when map is hidden, in order to hide active menus (if any).

   History:
      4-20-2008     Nesher      Created
      4-24-2008     Smariot     Added right-click menu
      4-24-2008     Nesher      Localized settings menu.  Added hook to hide menus when World Map is hidden.
--]]

-------------------------------------------------------------------------------------
-- Display a Settings menu.  Used from the map button's right-click, and from /qh settings.
function QuestHelper:DoSettingsMenu()
    local menu = QuestHelper:CreateMenu()
    self:CreateMenuTitle(menu, QHText("MENU_SETTINGS"))
    
    self:CreateMenuItem(menu, QHText("SETTINGS_MENU_INCOMPLETE")):SetFunction(QH_Incomplete)
                    
    arrowmenu = self:CreateMenu()
    QH_Arrow_PopulateMenu(arrowmenu)
    self:CreateMenuItem(menu, QHText("SETTINGS_ARROWLINK_ARROW")):SetSubmenu(arrowmenu)
    
    -- Cartographer Waypoints
    if Cartographer_Waypoints then
      self:CreateMenuItem(menu, QHFormat("SETTINGS_MENU_CARTWP", QuestHelper_Pref.cart_wp_new and QHText("MENU_DISABLE") or QHText("MENU_ENABLE")))
                    :SetFunction(self.ToggleCartWP, self)
    end
    
    -- TomTom
    if TomTom then
      self:CreateMenuItem(menu, QHFormat("SETTINGS_MENU_TOMTOM", QuestHelper_Pref.tomtom_wp_new and QHText("MENU_DISABLE") or QHText("MENU_ENABLE")))
                    :SetFunction(self.ToggleTomTomWP, self)
    end
    
    
    -- Flight Timer
    self:CreateMenuItem(menu, QHFormat("MENU_FLIGHT_TIMER", QuestHelper_Pref.flight_time and QHText("MENU_DISABLE") or QHText("MENU_ENABLE")))
                    :SetFunction(self.ToggleFlightTimes, self)
    
    -- Ant Trails
    self:CreateMenuItem(menu, QHFormat("MENU_ANT_TRAILS", QuestHelper_Pref.show_ants and QHText("MENU_DISABLE") or QHText("MENU_ENABLE")))
                    :SetFunction(self.ToggleAnts, self)
    
    -- Objective Tooltips
    self:CreateMenuItem(menu, QHFormat("MENU_OBJECTIVE_TIPS", QuestHelper_Pref.tooltip and QHText("MENU_DISABLE") or QHText("MENU_ENABLE")))
                    :SetFunction(self.ToggleTooltip, self)
    
    -- Options regarding party members.
    local submenu = self:CreateMenu()
    self:CreateMenuItem(submenu, QHFormat("MENU_PARTY_SHARE", QuestHelper_Pref.share and QHText("MENU_DISABLE") or QHText("MENU_ENABLE")))
                 :SetFunction(self.ToggleShare, self)
    self:CreateMenuItem(submenu, QHFormat("MENU_PARTY_SOLO", QuestHelper_Pref.solo and QHText("MENU_DISABLE") or QHText("MENU_ENABLE")))
                 :SetFunction(self.ToggleSolo, self)
    self:CreateMenuItem(menu, QHText("MENU_PARTY")):SetSubmenu(submenu)
    
    -- Map frame button
    --[[self:CreateMenuItem(menu, QHFormat("MENU_MAP_BUTTON", QuestHelper_Pref.map_button and QHText("MENU_DISABLE") or QHText("MENU_ENABLE")))
                    :SetFunction(self.ToggleMapButton, self)]]

    -- Icon Scale
    submenu = self:CreateMenu()
    for pct = 50,120,10 do
      local item = self:CreateMenuItem(submenu, pct.."%")
      local tex = self:CreateIconTexture(item, 10)
      item:SetFunction(QuestHelper.genericSetScale, QuestHelper, "scale", "icon scale", .5, 3, pct.."%")
      item:AddTexture(tex, true)
      tex:SetVertexColor(1, 1, 1, QuestHelper_Pref.scale == pct*0.01 and 1 or 0)
    end
    self:CreateMenuItem(menu, QHText("MENU_ICON_SCALE")):SetSubmenu(submenu)
    
    -- Hidden Objectives
    submenu = self:CreateMenu()
    QH_PopulateHidden(submenu)
    self:CreateMenuItem(menu, QHText("HIDDEN_TITLE")):SetSubmenu(submenu)
    
    -- Tracker Options
    submenu = self:CreateMenu()
    self:CreateMenuItem(submenu, QHFormat("MENU_QUEST_TRACKER", QuestHelper_Pref.track and QHText("MENU_DISABLE") or QHText("MENU_ENABLE")))
                    :SetFunction(self.ToggleTrack, self)
    --[[
    self:CreateMenuItem(submenu, QHFormat("MENU_TRACKER_LEVEL", QuestHelper_Pref.track_level and QHText("MENU_DISABLE") or QHText("MENU_ENABLE")))
                    :SetFunction(self.ToggleTrackLevel, self)
    self:CreateMenuItem(submenu, QHFormat("MENU_TRACKER_QCOLOUR", QuestHelper_Pref.track_qcolour and QHText("MENU_DISABLE") or QHText("MENU_ENABLE")))
                    :SetFunction(self.ToggleTrackQColour, self)
    self:CreateMenuItem(submenu, QHFormat("MENU_TRACKER_OCOLOUR", QuestHelper_Pref.track_ocolour and QHText("MENU_DISABLE") or QHText("MENU_ENABLE")))
                    :SetFunction(self.ToggleTrackOColour, self)
                    ]]
    local submenu2 = self:CreateMenu()
    for pct = 60,120,10 do
      local item = self:CreateMenuItem(submenu2, pct.."%")
      local tex = self:CreateIconTexture(item, 10)
      item:SetFunction(self.TrackerScale, QuestHelper, pct.."%")
      item:AddTexture(tex, true)
      tex:SetVertexColor(1, 1, 1, QuestHelper_Pref.track_scale == pct*0.01 and 1 or 0)
    end
    self:CreateMenuItem(submenu, QHText("MENU_TRACKER_SCALE")):SetSubmenu(submenu2)
    self:CreateMenuItem(submenu, QHText("MENU_TRACKER_RESET"))
                    :SetFunction(self.ResetTrackerPosition, self)
    self:CreateMenuItem(menu, QHText("MENU_TRACKER_OPTIONS")):SetSubmenu(submenu)
    
    -- Filters
    submenu = self:CreateMenu()
    self:CreateMenuItem(submenu, QHFormat("MENU_ZONE_FILTER", QuestHelper_Pref.filter_zone and QHText("MENU_DISABLE") or QHText("MENU_ENABLE")))
                    :SetFunction(self.Filter, self, "ZONE")
    self:CreateMenuItem(submenu, QHFormat("MENU_DONE_FILTER", QuestHelper_Pref.filter_done and QHText("MENU_DISABLE") or QHText("MENU_ENABLE")))
                    :SetFunction(self.Filter, self, "DONE")
    self:CreateMenuItem(submenu, QHFormat("MENU_BLOCKED_FILTER", QuestHelper_Pref.filter_blocked and QHText("MENU_DISABLE") or QHText("MENU_ENABLE")))
                    :SetFunction(self.Filter, self, "BLOCKED")
    self:CreateMenuItem(submenu, QHFormat("MENU_WATCHED_FILTER", QuestHelper_Pref.filter_watched and QHText("MENU_DISABLE") or QHText("MENU_ENABLE")))
                    :SetFunction(self.Filter, self, "WATCHED")
    self:CreateMenuItem(submenu, QHFormat("MENU_LEVEL_FILTER", QuestHelper_Pref.filter_level and QHText("MENU_DISABLE") or QHText("MENU_ENABLE")))
                    :SetFunction(self.Filter, self, "LEVEL")
    submenu2 = self:CreateMenu()
    self:CreateMenuItem(submenu, QHText("MENU_LEVEL_OFFSET")):SetSubmenu(submenu2)
    
    for offset = -5,5 do
      local menu = self:CreateMenuItem(submenu2, (offset > 0 and "+" or "")..offset)
      menu:SetFunction(self.LevelOffset, self, offset)
      local tex = self:CreateIconTexture(item, 10)
      menu:AddTexture(tex, true)
      tex:SetVertexColor(1, 1, 1, QuestHelper_Pref.level == offset and 1 or 0)
    end
    self:CreateMenuItem(menu, QHText("MENU_FILTERS")):SetSubmenu(submenu)
    
    submenu = self:CreateMenu()
    for scale = 0.2,2,0.2 do
      local menu = self:CreateMenuItem(submenu, (scale*100).."%")
      menu:SetFunction(QuestHelper.genericSetScale, QuestHelper, "perf_scale_2", "performance factor", .1, 5, scale)
      local tex = self:CreateIconTexture(item, 10)
      menu:AddTexture(tex, true)
      tex:SetVertexColor(1, 1, 1, QuestHelper_Pref.perf_scale_2 == scale and 1 or 0)
    end
    self:CreateMenuItem(menu, QHText("MENU_PERFORMANCE")):SetSubmenu(submenu)
    
    -- Locale
    submenu = self:CreateMenu()
    for loc, tbl in pairs(QuestHelper_Translations) do
      local item = self:CreateMenuItem(submenu, (tbl.LOCALE_NAME or "???").." ["..loc.."]")
      local tex = self:CreateIconTexture(item, 10)
      item:SetFunction(self.SetLocale, self, loc)
      item:AddTexture(tex, true)
      tex:SetVertexColor(1, 1, 1, QuestHelper_Pref.locale == loc and 1 or 0)
    end
    local item = self:CreateMenuItem(menu, QHText("MENU_LOCALE"))
    --item:AddTexture(self:CreateIconTexture(item, 25), true) -- Add Globe icon to locale menu.
    item:SetSubmenu(submenu)
    
    -- Stuff to read.
    submenu = self:CreateMenu()
    self:CreateMenuItem(submenu, QHText("MENU_HELP_SLASH")):SetFunction(self.Help, self)
    self:CreateMenuItem(submenu, QHText("MENU_HELP_CHANGES")):SetFunction(self.ChangeLog, self)
    self:CreateMenuItem(submenu, QHText("MENU_HELP_SUBMIT")):SetFunction(self.Submit, self)
    self:CreateMenuItem(menu, QHText("MENU_HELP")):SetSubmenu(submenu)
    
    menu:ShowAtCursor()
end

-------------------------------------------------------------------------------------
-- Handle clicks on the button
function QuestHelperWorldMapButton_OnClick(self, clicked)

  -- Left button toggles whether QuestHelper is displayed (and hence active)
  if clicked == "LeftButton" then
    QuestHelper:ToggleHide()

    -- Refresh the tooltip to match.  Presumably it's showing - how else could the button get clicked?
    -- Note: if I'm wrong about my assumption, this could leave the tooltip stranded until user mouses
    -- back over the button, but I don't think that's too serious.
    QuestHelperWorldMapButton_OnEnter(self)
  elseif clicked == "RightButton" and not QuestHelper_Pref.hide then
    QuestHelper:DoSettingsMenu()
  end
end

-------------------------------------------------------------------------------------
-- Display or update the tooltip
function QuestHelperWorldMapButton_OnEnter(self)
    local theme = QuestHelper:GetColourTheme()

    QuestHelper.tooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", self:GetWidth(), -5)
    QuestHelper.tooltip:ClearLines()
    QuestHelper.tooltip:AddLine(QHFormat("QH_BUTTON_TOOLTIP1", QHText(QuestHelper_Pref.hide and "QH_BUTTON_SHOW" or "QH_BUTTON_HIDE")),
                                unpack(theme.tooltip))
    QuestHelper.tooltip:GetPrevLines():SetFont(QuestHelper.font.serif, 12)
    if not QuestHelper_Pref.hide then
        -- Add the settings menu tooltip when it's available
        QuestHelper.tooltip:AddLine(QHText("QH_BUTTON_TOOLTIP2"), unpack(theme.tooltip))
        QuestHelper.tooltip:GetPrevLines():SetFont(QuestHelper.font.serif, 12)
    end
    QuestHelper.tooltip:Show()
end

-------------------------------------------------------------------------------------
-- Handle when the world map gets hidden: hide the active menu if any.
function QuestHelper_WorldMapHidden()
  if QuestHelper.active_menu then
    QuestHelper.active_menu:DoHide()
    if QuestHelper.active_menu.auto_release then
      QuestHelper.active_menu = nil
    end
  end
end


-------------------------------------------------------------------------------------
-- Set up the Map Button
function QuestHelper:InitMapButton()
  
  if not self.MapButton then
    -- Create the button
    local button = CreateFrame("Button", "QuestHelperWorldMapButton", WorldMapButton, "UIPanelButtonTemplate")
    
    -- Assign the font QuestHelper selected for the currect locale.
    if button.GetFont then
      button:SetFont(self.font.serif, select(2, button:GetFont()))
    end
    
    -- Set up the button
    button:SetText(QHText("QH_BUTTON_TEXT"))
    local width = button:GetTextWidth() + 30
    if width < 110 then
        width = 110
    end
    button:SetWidth(width)
    button:SetHeight(22)
    
    -- Desaturate the button texture if QuestHelper is disabled.
    -- This line is also in QuestHelper:ToggleHide
    button:GetNormalTexture():SetDesaturated(QuestHelper_Pref.hide)
    
    -- Add event handlers to provide Tooltip
    QH_Hook(button, "OnEnter", QuestHelperWorldMapButton_OnEnter)
    QH_Hook(button, "OnLeave", function(this)
        QuestHelper.tooltip:Hide()
    end)

    -- Add Click handler
    QH_Hook(button, "OnClick", QuestHelperWorldMapButton_OnClick)
    button:RegisterForClicks("LeftButtonUp", "RightButtonUp")

    -- Add Hide handler, so we can dismiss any menus when map is closed
    QH_Hook(button, "OnHide", QuestHelper_WorldMapHidden)

    -- Position it on the World Map frame
--~     if Cartographer then
--~         -- If Cartographer is in use, coordinate with their buttons.
            -- Trouble is, this makes Cartographer's buttons conflict with the Zone Map dropdown.
            -- Re-enable this if Cartographer ever learns to work with the Zone Map dropdown.
--~         Cartographer:AddMapButton(button, 3)
--~     else
        -- Otherwise, just put it in the upper right corner
        button:SetPoint("TOPRIGHT", WorldMapButton, "TOPRIGHT", -10, -10)
        button:SetFrameLevel(WorldMapButton:GetFrameLevel()+1)
        button:SetFrameStrata("FULLSCREEN")
--    end

    -- Save the button so we can reference it later if need be
    self.MapButton = button
  else
    -- User must be toggling the button.  We've already got it, so just show it.
    self.MapButton:Show()
  end
end

----------------------------------------------------------------------------------
-- Hide the map button
function QuestHelper:HideMapButton()
  if self.MapButton then
    self.MapButton:Hide()
  end
end
