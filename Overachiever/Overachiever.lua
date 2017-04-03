
--
--  Overachiever
--    by Tuhljin
--


-- Overachiever_Debug = true

local THIS_VERSION = GetAddOnMetadata("Overachiever", "Version")
local THIS_TITLE = GetAddOnMetadata("Overachiever", "Title")

local ACHINFO_NAME = 2

Overachiever = {};

local L = OVERACHIEVER_STRINGS

local CATEGORIES_ALL, CATEGORY_EXPLOREROOT, CATEGORIES_EXPLOREZONES
local OptionsPanel
local MadeDraggable_AchFrame, MadeDragSave_AchFrame


local function copytab(from, to)
  for k,v in pairs(from) do
    if(type(v) == "table") then
      to[k] = {}
      copytab(v, to[k]);
    else
      to[k] = v;
    end
  end
end


local function chatprint(msg, premsg)
  premsg = premsg or "["..THIS_TITLE.."]"
  DEFAULT_CHAT_FRAME:AddMessage("|cff7eff00"..premsg.."|r "..msg, 0.741, 1, 0.467);
end

local function BuildCategoryInfo()
  Overachiever.UI_GetValidCategories()
  CATEGORY_EXPLOREROOT = GetAchievementCategory(OVERACHIEVER_ACHID.WorldExplorer);
  CATEGORIES_EXPLOREZONES = {};
  local name, parentID
  for i,id in ipairs(CATEGORIES_ALL) do
    name, parentID = GetCategoryInfo(id)
    if (parentID == CATEGORY_EXPLOREROOT) then
      CATEGORIES_EXPLOREZONES[#(CATEGORIES_EXPLOREZONES) + 1] = id;
    end
  end
end

local function getSelectedAchievement(ignoreTab, ignoreFilter)
  if (AchievementFrame and (ignoreTab or AchievementFrame.selectedTab == 1)) then
    if (ignoreFilter or ACHIEVEMENTUI_SELECTEDFILTER == AchievementFrame_GetCategoryNumAchievements_All) then
      return AchievementFrameAchievements.selection
    end
    local id = AchievementFrameAchievements.selection
    local _, _, _, complete = GetAchievementInfo(id)
    if ((complete and ACHIEVEMENTUI_SELECTEDFILTER == AchievementFrame_GetCategoryNumAchievements_Complete) or
        (not complete and ACHIEVEMENTUI_SELECTEDFILTER == AchievementFrame_GetCategoryNumAchievements_Incomplete)) then
      return id
    end
  end
end

local function expandCategory(category)
-- Based on part of AchievementFrame_SelectAchievement() in Blizzard_AchievementUI.lua
  for i, entry in next, ACHIEVEMENTUI_CATEGORIES do
    if ( entry.id == category ) then
      entry.collapsed = false;
    elseif ( entry.parent == category ) then
      entry.hidden = false;
    end
  end
  AchievementFrameCategories_Update()
end

local function isAchievementInUI(id, checkNext)
-- Return true if the achievement should be found in the standard UI
  if (checkNext) then
    local nextID, completed = GetNextAchievement(id)
    if (nextID and completed) then
      local newID;
      while ( nextID and completed ) do
        newID, completed = GetNextAchievement(nextID);
        if ( completed ) then
          nextID = newID;
        end
      end
      id = nextID;
    end
  end
  local cat = GetAchievementCategory(id)
  for i=1,GetCategoryNumAchievements(cat) do
    if (GetAchievementInfo(cat, i) == id) then  return true;  end
  end
end

local function openToAchievement(id, canToggleTracking)
  assert( (type(id)=="number"), "Invalid achievement ID." )
  if (GetPreviousAchievement(id) or isAchievementInUI(id, true)) then
    local sel
    if (not AchievementFrame or not AchievementFrame:IsShown()) then
      ToggleAchievementFrame()
    elseif (canToggleTracking) then
      sel = getSelectedAchievement()
    end
    if (sel == id) then
      AchievementButton_ToggleTracking(id)
    else
      Overachiever.UI_SelectAchievement(id)
    end
  else
    UIErrorsFrame:AddMessage(L.MSG_ACHNOTFOUND, 1.0, 0.1, 0.1, 1.0)
    --chatprint(L.MSG_ACHNOTFOUND)
  end
end

local function getCategoryID(name)
  local n
  for i,id in ipairs(CATEGORIES_ALL) do
    n = GetCategoryInfo(id)
    if (n == name) then  return id;  end
  end
end

local getAchievementID_cat, getAchievementID_tab
do
  local found
  
  local function get_arg1_argN(n, arg1, ...)
    return arg1, select(n-1, ...)
  end

  function getAchievementID_cat(category, argnum, pattern, anyCase, getAll)
  -- Go over a given category, looking only at achievements that would normally be listed in the UI for the
  -- player character at this time:
    if (getAll) then  found = found and wipe(found) or {};  end
    if (anyCase) then  pattern = strlower(pattern);  end
    local id, ret, anyFound
    for i=1,GetCategoryNumAchievements(category) do
      id, ret = get_arg1_argN(argnum, GetAchievementInfo(category, i))
      if (anyCase) then  ret = strlower(ret);  end
      if ( strfind(ret, pattern, 1, true) ) then
        if (getAll) then
          found[#(found) + 1] = id;
          anyFound = true
        else
          return id;
        end
      end
    end
    if (anyFound) then
      return found;
    end
  end

  function getAchievementID_tab(tab, argnum, pattern, anyCase, getAll)
  -- Look at achievements whose IDs are in a given table:
    if (getAll) then  found = found and wipe(found) or {};  end
    if (anyCase) then  pattern = strlower(pattern);  end
    local ret, anyFound
    for i,id in ipairs(tab) do
      ret = select(argnum, GetAchievementInfo(id))
      if (anyCase) then  ret = strlower(ret);  end
      if ( strfind(ret, pattern, 1, true) ) then
        if (getAll) then
          found[#(found) + 1] = id;
          anyFound = true
        else
          return id;
        end
      end
    end
    if (anyFound) then
      return found;
    end
  end

end

local function getAchievementID(list, argnum, pattern, anyCase)
  list = list or CATEGORIES_ALL
  if (type(list) == "table") then
    local id
    for i,cat in ipairs(list) do
      id = getAchievementID_cat(cat, argnum, pattern, anyCase)
      if (id) then  return id;  end
    end
  elseif (type(list) == "number") then
    return getAchievementID_cat(list, argnum, pattern, anyCase)
  elseif (type(list) == "string") then
    local cat = getCategoryID(list)
    assert(cat, "Category not found.")
    return getAchievementID_cat(cat, argnum, pattern, anyCase)
  end
end

local searchResults
local function SearchAchievements(list, argnum, pattern, anyCase)
  list = list or CATEGORIES_ALL
  if (type(list) == "table") then
    -- Reuse table to avoid garbage generation
    searchResults = searchResults and wipe(searchResults) or {}
    local tab, anyFound
    for i,cat in ipairs(list) do
      tab = getAchievementID_cat(cat, argnum, pattern, anyCase, true)
      if (tab) then
        for _,v in ipairs(tab) do
          searchResults[#(searchResults) + 1] = v;
          anyFound = true
        end
      end
    end
    if (anyFound) then
      return searchResults;
    end
  elseif (type(list) == "number") then
    return getAchievementID_cat(list, argnum, pattern, anyCase, true)
  elseif (type(list) == "string") then
    local cat = getCategoryID(list)
    assert(cat, "Category not found.")
    return getAchievementID_cat(cat, argnum, pattern, anyCase, true)
  end
end

local function SearchAchievements_tab(list, argnum, pattern, anyCase)
  searchResults = searchResults and wipe(searchResults) or {}
  local tab, anyFound
  for k,sublist in pairs(list) do
    tab = getAchievementID_tab(sublist, argnum, pattern, anyCase, true)
    if (tab) then
      for _,v in ipairs(tab) do
        searchResults[#(searchResults) + 1] = v;
        anyFound = true
      end
    end
  end
  if (anyFound) then  return searchResults;  end
end


local function canTrackAchievement(id, allowCompleted)
  if ( GetNumTrackedAchievements() < WATCHFRAME_MAXACHIEVEMENTS and
       (allowCompleted or not select(4, GetAchievementInfo(id))) ) then
    return true
  end
end

local function setTracking(id, allowCompleted)
  if (canTrackAchievement(id, allowCompleted)) then
    AddTrackedAchievement(id)
    if (AchievementFrameAchievements_ForceUpdate) then
      AchievementFrameAchievements_ForceUpdate()
    end
    return true
  end
end


-- ACHIEVEMENT ID LOOKUP
--------------------------

local getAllAchievements --, getAllAchievementsInCat
do
  local ALL_ACHIEVEMENTS
  function getAllAchievements()
  -- Retrieve an array of all achievement IDs, including those not normally listed in the UI for this character.
    if (ALL_ACHIEVEMENTS) then  return ALL_ACHIEVEMENTS;  end
    local catlookup = {}
    for i,c in ipairs(CATEGORIES_ALL) do
      catlookup[c] = true
    end
    ALL_ACHIEVEMENTS = {}
    local gap, i, size, id = 0, 0, 0
    --local debug_largestgap = 0
    repeat
      i = i + 1
      id = GetAchievementInfo(i)
      if (id) then
        --if (gap > debug_largestgap) then debug_largestgap = gap; print("high gap:",debug_largestgap); end
        gap = 0
        if (catlookup[GetAchievementCategory(id)]) then  size = size + 1; ALL_ACHIEVEMENTS[size] = id;  end
      else
        gap = gap + 1
      end
    until (gap > 1000) -- 1000 is arbitrary. As of this writing, the largest gap is 79, but this is more future-safe.
    --print("last ach ID:",ALL_ACHIEVEMENTS[size], "/ size:",size)
    catlookup = nil
    return ALL_ACHIEVEMENTS
  end

  --[[
  local ALL_ACHIEVEMENTS_BYCAT
  function getAllAchievementsInCat(cat)
    ALL_ACHIEVEMENTS_BYCAT = ALL_ACHIEVEMENTS_BYCAT or {}
    if (ALL_ACHIEVEMENTS_BYCAT[cat]) then  return ALL_ACHIEVEMENTS_BYCAT[cat];  end
    local tab, size, list = {}, 0, getAllAchievements()
    for i,id in ipairs(list) do
      if (GetAchievementCategory(id) == cat) then  size = size + 1; tab[size] = id;  end
    end
    ALL_ACHIEVEMENTS_BYCAT[cat] = tab
    return tab
  end
  --]]
end

local function BuildCriteriaLookupTab(...)
-- To be called in this fashion: BuildCriteriaLookupTab( <criteriaType1>, <table1>, <saveCriteriaNumber1>[, <criteriaType2>, <table2>, <saveCriteriaNumber2>[, ...]] )
  local num = select("#", ...)
  local list = getAllAchievements()
  local _, critType, assetID, a, tab, savenum
  for x,id in ipairs(list) do
    for i=1,GetAchievementNumCriteria(id) do
      _, critType, _, _, _, _, _, assetID = GetAchievementCriteriaInfo(id, i)

      for arg=1,num,3 do
        a, tab, savenum = select(arg, ...)
        if (critType == a) then
          if (tab[assetID]) then
            local v = tab[assetID]
            if (type(v) == "table") then
              local size = #v
              v[size+1] = id
              if (savenum) then  v[size+2] = i;  end
            else
              tab[assetID] = { v, id }  -- Safe to assume savenum isn't true since this wasn't already a table
            end
          else
            if (savenum) then
              tab[assetID] = { id, i }
            else
              tab[assetID] = id
            end
          end
        end
      end

    end
  end
end

local AchLookup_metaach, AchLookup_kill
local function BuildCriteriaLookupTab_check()
  local meta = not AchLookup_metaach and Overachiever_Settings.UI_RequiredForMetaTooltip
  local kill = not AchLookup_kill and Overachiever_Settings.CreatureTip_killed
  if (meta and kill) then
    AchLookup_metaach, AchLookup_kill = {}, {}
    BuildCriteriaLookupTab(8, AchLookup_metaach, nil, 0, AchLookup_kill, true)
    Overachiever.AchLookup_kill = AchLookup_kill
  elseif (meta) then
    AchLookup_metaach = {}
    BuildCriteriaLookupTab(8, AchLookup_metaach)
  elseif (kill) then
    AchLookup_kill = {}
    BuildCriteriaLookupTab(0, AchLookup_kill, true)
    Overachiever.AchLookup_kill = AchLookup_kill
  end
end


-- DRAGGABLE FRAMES
---------------------

local function CheckDraggable_AchFrame(self, key, val, clicked, LoadPos)
  if (AchievementFrame) then
    -- Check if draggable:
    if (Overachiever_Settings.Draggable_AchFrame) then
      if (not MadeDraggable_AchFrame) then
        TjDragIt.EnableDragging(AchievementFrame, AchievementFrameHeader, AchievementFrameCategoriesContainer,
                                AchievementFrameAchievementsContainer, AchievementFrameStatsContainer,
                                Overachiever_SearchFrameContainer, Overachiever_SuggestionsFrameContainer,
                                Overachiever_WatchFrameContainer)
        MadeDraggable_AchFrame = true
      end
    elseif (MadeDraggable_AchFrame) then
      TjDragIt.DisableDragging(AchievementFrame, AchievementFrameHeader, AchievementFrameCategoriesContainer,
                               AchievementFrameAchievementsContainer, AchievementFrameStatsContainer,
                               Overachiever_SearchFrameContainer, Overachiever_SuggestionsFrameContainer)
      MadeDraggable_AchFrame = nil
    end
    if (key and AchievementFrame:IsShown()) then
    -- If option may have been changed by the user, frame needs to be hidden before changing its attributes.
      HideUIPanel(AchievementFrame)
    end
    -- Check if position saved:
    if (Overachiever_Settings.DragSave_AchFrame) then
      if (not MadeDragSave_AchFrame) then
        if (not Overachiever_CharVars.Pos_AchievementFrame) then
          Overachiever_CharVars.Pos_AchievementFrame = Overachiever_CharVars_Default and Overachiever_CharVars_Default.Pos_AchievementFrame or {}
        end
        TjDragIt.EnablePositionSaving(AchievementFrame, Overachiever_CharVars.Pos_AchievementFrame, LoadPos)
        AchievementFrame:SetAttribute("UIPanelLayout-enabled", false);
        MadeDragSave_AchFrame = true
      end
    elseif (MadeDragSave_AchFrame) then
      TjDragIt.DisablePositionSaving(AchievementFrame)
      AchievementFrame:SetAttribute("UIPanelLayout-enabled", true);
      MadeDragSave_AchFrame = nil
    end
  end
end

local orig_AchievementFrame_OnShow, orig_AchievementFrame_area

local function AchievementUI_FirstShown_post()
  Overachiever.MainFrame:Hide()
  -- Delayed setting the area attribute until now so that if Blizzard_AchievementUI was loaded just before the
  -- AchievementFrame is to be shown, AchievementFrame wouldn't be set as the current UI panel by code in
  -- UIParent.lua, which causes problems when we don't want it to interact with other UI panels in the standard
  -- way. (Set now instead of leaving it out because the player may want it to interact normally again later.)
  if (orig_AchievementFrame_area) then
    UIPanelWindows["AchievementFrame"].area = orig_AchievementFrame_area
    AchievementFrame:SetAttribute("UIPanelLayout-area", orig_AchievementFrame_area);
    orig_AchievementFrame_area = nil
  end
  CheckDraggable_AchFrame(nil, nil, nil, nil, true)
  if (not Overachiever_Settings.DragSave_AchFrame) then
  -- If we aren't saving the position, then re-open the frame to put it in the standard place. (It'll do this
  -- automatically from now on.)
    local prevfunc = AchievementFrame:GetScript("OnHide")
    AchievementFrame:SetScript("OnHide", nil)
    HideUIPanel(AchievementFrame)
    AchievementFrame:SetScript("OnHide", prevfunc)
    prevfunc = AchievementFrame:GetScript("OnShow")
    AchievementFrame:SetScript("OnShow", nil)
    ShowUIPanel(AchievementFrame)
    AchievementFrame:SetScript("OnShow", prevfunc)
  end
end

local function AchievementUI_FirstShown(...)
  AchievementFrame:SetScript("OnShow", orig_AchievementFrame_OnShow)
  --[[ Pre-3.1 method:
  AchievementFrame_OnShow = orig_AchievementFrame_OnShow
  --]]
  orig_AchievementFrame_OnShow = nil
  -- Delayed call to AchievementUI_FirstShown_post() - let everything else process first:
  Overachiever.MainFrame:Show()
  -- Call original function:
  AchievementFrame_OnShow(...)
  AchievementUI_FirstShown = nil
end


-- ACHIEVEMENT HYPERLINK HOOK
-------------------------------

--local orig_SetItemRef = SetItemRef
local orig_ChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow
ChatFrame_OnHyperlinkShow = function(self, link, text, button, ...)
  if (strsub(link, 1, 11) == "achievement") then
    if (IsControlKeyDown()) then
      local id = strsplit(":", strsub(link, 13));
      id = tonumber(id)
      openToAchievement(id, true)
      return;
    elseif (IsAltKeyDown()) then
      if (not AchievementFrame) then  AchievementFrame_LoadUI();  end
      if (Overachiever_WatchFrame) then
        local id = strsplit(":", strsub(link, 13));
        id = tonumber(id)
        Overachiever_WatchFrame.SetAchWatchList(id, true)
        return;
      end
    end
  end
  return orig_ChatFrame_OnHyperlinkShow(self, link, text, button, ...)
end

-- ACHIEVEMENT TRACKER CHANGES
--------------------------------

local orig_WatchFrameLinkButtonTemplate_OnLeftClick = WatchFrameLinkButtonTemplate_OnLeftClick

WatchFrameLinkButtonTemplate_OnLeftClick = function(self, ...)
  if (self.type == "ACHIEVEMENT") then
    CloseDropDownMenus()
    if (IsShiftKeyDown()) then
      if ( ChatEdit_GetActiveWindow() ) then
        ChatEdit_InsertLink(GetAchievementLink(self.index));
      else
        ChatFrame_OpenChat(GetAchievementLink(self.index));
      end
    else
    -- We prefer an openToAchievement() call instead of a direct AchievementFrame_SelectAchievement() call, so
    -- we do this here instead of calling orig_WatchFrameLinkButtonTemplate_OnLeftClick():
      openToAchievement(self.index)
    end
    return;
  end
  orig_WatchFrameLinkButtonTemplate_OnLeftClick(self, ...)
end

WatchFrame_OpenAchievementFrame = function(button, arg1, arg2, checked)
-- Take over reaction to clicking "Open Achievement" in the watch frame's right-click popup menu, preventing
-- lock ups if tracking an achievement not in the UI as well as using openToAchievement(), which we prefer, instead of
-- a direct AchievementFrame_SelectAchievement() call.
  openToAchievement(arg1)
end

local function TrackerBtnOnEnter(self)
  if (self.type ~= "ACHIEVEMENT") then  return;  end
  GameTooltip:SetOwner(self, "ANCHOR_NONE")
  local x, y = self:GetCenter()
  local w = UIParent:GetWidth() / 3
  if (x > w) then
    GameTooltip:SetPoint("TOPRIGHT", self, "TOPLEFT", -2, 0)
  else
    GameTooltip:SetPoint("TOP", self, "TOP", 0, 0)
    GameTooltip:SetPoint("LEFT", WatchFrame, "RIGHT", -8, 0)
  end
  GameTooltip:SetHyperlink( GetAchievementLink(self.index) )
end

local function TrackerBtnOnLeave()
  GameTooltip:Hide()
end

-- Hook current Watch Frame Link Buttons:
for k, v in pairs(WATCHFRAME_LINKBUTTONS) do
  v.OverachieverHooked = true
  v:HookScript("OnEnter", TrackerBtnOnEnter)
  v:HookScript("OnLeave", TrackerBtnOnLeave)
end

-- Hook future Watch Frame Link Buttons when they are created:
setmetatable(WATCHFRAME_LINKBUTTONS, { __newindex = function(t, k, v)
  rawset(t, k, v)
  if (not v.OverachieverHooked) then
    v.OverachieverHooked = true
    v:HookScript("OnEnter", TrackerBtnOnEnter)
    v:HookScript("OnLeave", TrackerBtnOnLeave)
  end
end })


local function getExplorationAch(zonesOnly, ...)
  local id, cat
  for i = select("#", ...), 1, -1 do
    id = select(i, ...)
    cat = GetAchievementCategory(id)
    if (cat == CATEGORY_EXPLOREROOT) then
      if (not zonesOnly) then  return id;  end
    else
      local _, parentID = GetCategoryInfo(cat)
      if (parentID == CATEGORY_EXPLOREROOT) then
        if ( not zonesOnly or
             -- Eliminate achievements in the category that aren't really "exploration":
             (id ~= OVERACHIEVER_ACHID.MediumRare and id ~= OVERACHIEVER_ACHID.BloodyRare and
              id ~= OVERACHIEVER_ACHID.NorthernExposure and id ~= OVERACHIEVER_ACHID.Frostbitten) ) then
          return id
        end
      end
    end
  end
end

local AutoTrackedAch_explore

local function AutoTrackCheck_Explore(noClearing)
-- noClearing will evaluate to true when called through TjOptions since it passes an object for this first arg.
  if (Overachiever_Settings.Explore_AutoTrack) then
    local id
    if (not IsInInstance()) then
      local zone = GetRealZoneText()
      if (zone and zone ~= "") then
        id = Overachiever.ExploreZoneIDLookup(zone) or
             getAchievementID(CATEGORIES_EXPLOREZONES, ACHINFO_NAME, zone, true)
      end
    end
    if (id) then
      local tracked
      if (GetNumTrackedAchievements() > 0) then
        tracked = AutoTrackedAch_explore and IsTrackedAchievement(AutoTrackedAch_explore) and AutoTrackedAch_explore or
                  getExplorationAch(true, GetTrackedAchievements())
      end
      if (tracked) then
        RemoveTrackedAchievement(tracked)
        if (setTracking(id, Overachiever_Settings.Explore_AutoTrack_Completed)) then
          AutoTrackedAch_explore = id
        else
          -- If didn't successfully track new achievement, track previous achievement again:
          AddTrackedAchievement(tracked)
        end
      else
        if (setTracking(id, Overachiever_Settings.Explore_AutoTrack_Completed)) then
          AutoTrackedAch_explore = id
        end
      end
    elseif (not noClearing and AutoTrackedAch_explore and IsTrackedAchievement(AutoTrackedAch_explore)) then
      RemoveTrackedAchievement(AutoTrackedAch_explore)
      AutoTrackedAch_explore = nil
    end
  end
end


-- META-CRITERIA TOOLTIP
--------------------------

local orig_AchievementButton_GetMeta

local function MetaCriteriaOnEnter(self)
  if (self.id) then
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
    local link = GetAchievementLink(self.id)
    GameTooltip:SetHyperlink(link)
    if (GameTooltip:GetBottom() < self:GetTop()) then
      GameTooltip:ClearAllPoints()
      GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
    end
  -- If for some reason the ID isn't there but a date completed is (something that probably shouldn't happen), fall
  -- back to the way tooltips were handled in Blizzard_AchievementUI.xml's MetaCriteriaTemplate:
  elseif ( self.date ) then
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    GameTooltip:AddLine(string.format(ACHIEVEMENT_META_COMPLETED_DATE, self.date), 1, 1, 1);
    GameTooltip:Show();
  end
end

local function new_AchievementButton_GetMeta(...)
  local frame = orig_AchievementButton_GetMeta(...)
  frame:SetScript("OnEnter", MetaCriteriaOnEnter)
  return frame;
end


-- TOOLTIP FOR UI'S ACHIEVEMENT BUTTONS
-----------------------------------------

local achbtnOnEnter, achbtnOnLeave, achBtnRedisplay
local AddAchListToTooltip
do
  local button
  local r_sel, g_sel, b_sel = 0.741, 1, 0.467
  local r_com, g_com, b_com = 0.25, 0.75, 0.25
  local r_inc, g_inc, b_inc = 0.6, 0.6, 0.6
  local temptab

  function AddAchListToTooltip(tooltip, list)
    if (type(list) == "table") then
      local _, name, completed, anycomplete
      temptab = temptab or {}
      for i,ach in ipairs(list) do
        _, name, _, completed = GetAchievementInfo(ach)
        if (completed) then
          anycomplete = true
        else
          completed = false  -- nil becomes false for use in temptab.
        end
        temptab[name] = temptab[name] or completed
        -- It being complete takes precedence, since if the name was already used, but this time it's complete,
        -- the previous one must've been for the other faction.
      end
      for name,completed in pairs(temptab) do
        if (completed) then
          tooltip:AddLine(name, r_com, g_com, b_com)
          tooltip:AddTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready");
        else
          tooltip:AddLine(name, 1, 1, 1) --, r_inc, g_inc, b_inc)
          if (anycomplete) then
            tooltip:AddTexture(""); -- fake texture to push the text over
          end
        end
      end
      wipe(temptab)
    else
      local _, name, _, completed = GetAchievementInfo(list)
      if (completed) then
        tooltip:AddLine(name, r_com, g_com, b_com)
        tooltip:AddTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready");
      else
        tooltip:AddLine(name, 1, 1, 1) --, r_inc, g_inc, b_inc)
      end
    end
  end

  function achbtnOnEnter(self)
    button = self
    local id, tipset = self.id

    if (Overachiever_Settings.UI_SeriesTooltip and (GetNextAchievement(id) or GetPreviousAchievement(id))) then
      GameTooltip:SetOwner(self, "ANCHOR_NONE")
      GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 8, 0)
      GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
      tipset = true
      GameTooltip:AddLine(L.SERIESTIP)
      GameTooltip:AddLine(" ")
      local ach = GetPreviousAchievement(id)
      local first, _, name, anycomplete
      while (ach) do  -- Find first achievement in the series:
        first = ach
        ach = GetPreviousAchievement(ach)
      end
      ach = first or id
      local completed = select(4, GetAchievementInfo(ach))
      while (ach) do
        _, name = GetAchievementInfo(ach)
        if (ach == id) then
          GameTooltip:AddLine(name, r_sel, g_sel, b_sel)
        elseif (completed) then
          GameTooltip:AddLine(name, r_com, g_com, b_com)
        else
          GameTooltip:AddLine(name, r_inc, g_inc, b_inc)
        end
        if (completed) then
          GameTooltip:AddTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready");
          anycomplete = true
        elseif (anycomplete) then
          GameTooltip:AddTexture(""); -- fake texture to push the text over
        end
        ach, completed = GetNextAchievement(ach)
      end
      GameTooltip:AddLine(" ")
    end

    if (Overachiever_Settings.UI_RequiredForMetaTooltip and AchLookup_metaach[id]) then
      if (not tipset) then
        GameTooltip:SetOwner(self, "ANCHOR_NONE")
        GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 8, 0)
        GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
        tipset = true
      end
      GameTooltip:AddLine(L.REQUIREDFORMETATIP)
      GameTooltip:AddLine(" ")
      AddAchListToTooltip(GameTooltip, AchLookup_metaach[id])
      GameTooltip:AddLine(" ")
    end

    if (Overachiever_Settings.Tooltip_ShowID) then
      if (not tipset) then
        GameTooltip:SetOwner(self, "ANCHOR_NONE")
        GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 8, 0)
        GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
        tipset = true
      end
      if (GameTooltip:NumLines() > 0) then
        GameTooltip:AddDoubleLine(" ", "|cff7eff00ID:|r "..id, nil, nil, nil, 0.741, 1, 0.467)
      else
        GameTooltip:AddLine("|cff7eff00ID:|r "..id, 0.741, 1, 0.467)
      end
    end

    if (tipset) then
      GameTooltip:Show()
      return true
    end
  end

  function achbtnOnLeave(self)
    button = nil
    GameTooltip:Hide()
  end

  -- This function is needed to handle cases where OnEnter isn't triggered again because the frame scrolls down
  -- but the cursor remains on the same button:
  function achBtnRedisplay()
    if (button) then
      if (not achbtnOnEnter(button)) then
        GameTooltip:Hide()
      end
    end
  end
end


-- GLOBAL FUNCTIONS
-----------------------

function Overachiever.OnEvent(self, event, arg1, ...)
  if (event == "PLAYER_ENTERING_WORLD") then
    Overachiever.MainFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
    Overachiever.MainFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

    BuildCategoryInfo()
    BuildCategoryInfo = nil

    local oldver
    OptionsPanel, oldver = Overachiever.CreateOptions(THIS_TITLE, BuildCriteriaLookupTab_check, AutoTrackCheck_Explore, CheckDraggable_AchFrame)
    Overachiever.CreateOptions = nil

    if (oldver and oldver ~= THIS_VERSION) then
      Overachiever_Settings.Version = THIS_VERSION
      local def, settings = Overachiever.DefaultSettings, Overachiever_Settings
      -- Remove options no longer in this version:
      for k,v in pairs(settings) do
        if (def[k] == nil) then  settings[k] = nil;  end
      end
      -- Add options new to this version, set to default:
      for k,v in pairs(def) do
        if (settings[k] == nil) then  settings[k] = v;  end
      end

      if (tonumber(oldver) < 0.40 and Overachiever_CharVars_Default) then
        Overachiever_CharVars_Default.Pos_AchievementWatchFrame = nil
      end
    end

    if (Overachiever_CharVars) then
      oldver = tonumber(Overachiever_CharVars.Version)
      if (oldver < 0.40) then  Overachiever_CharVars.Pos_AchievementWatchFrame = nil;  end
      if (oldver < 0.55) then  Overachiever_CharVars.TrackedAch = nil;  end  -- No longer necessary as between-session objective tracking is now done by WoW itself.

     --[[  No longer necessary as this is now done by WoW itself:
      local tracked = Overachiever_CharVars.TrackedAch
      if (tracked and GetNumTrackedAchievements() == 0) then
      -- Resume tracking from last session:
        if (type(tracked) == "table") then
          for i,id in ipairs(tracked) do
            AddTrackedAchievement(id)
          end
        else
          AddTrackedAchievement(tracked)
        end
      end
     --]]
    else
      Overachiever_CharVars = {};
    end
    Overachiever_CharVars.Version = THIS_VERSION

    AutoTrackCheck_Explore(true)

    GameTooltip:HookScript("OnTooltipSetUnit", Overachiever.ExamineSetUnit)
    GameTooltip:HookScript("OnShow", Overachiever.ExamineOneLiner)
    GameTooltip:HookScript("OnTooltipSetItem", Overachiever.ExamineItem)
    ItemRefTooltip:HookScript("OnTooltipSetItem", Overachiever.ExamineItem)
    hooksecurefunc(ItemRefTooltip, "SetHyperlink", Overachiever.ExamineAchievementTip)
    hooksecurefunc(GameTooltip, "SetHyperlink", Overachiever.ExamineAchievementTip)

    Overachiever.BuildItemLookupTab()
    Overachiever.BuildItemLookupTab = nil
    BuildCriteriaLookupTab_check()

  elseif (event == "ZONE_CHANGED_NEW_AREA") then
    AutoTrackCheck_Explore()

  elseif (event == "TRACKED_ACHIEVEMENT_UPDATE") then
    local criteriaID, elapsed, duration = ...
    if (duration and elapsed < duration) then
      Overachiever.RecentReminders[arg1] = time()
      if (Overachiever_Settings.Tracker_AutoTimer and
          not setTracking(arg1) and AutoTrackedAch_explore and IsTrackedAchievement(AutoTrackedAch_explore)) then
        -- If failed to track this, remove an exploration achievement that was auto-tracked and try again:
        RemoveTrackedAchievement(AutoTrackedAch_explore)
        if (not setTracking(arg1)) then
          -- If still didn't successfully track new achievement, track previous achievement again:
          AddTrackedAchievement(AutoTrackedAch_explore)
        end
      end
    end

  elseif (event == "ADDON_LOADED" and arg1 == "Blizzard_AchievementUI") then
    Overachiever.MainFrame:UnregisterEvent("ADDON_LOADED")
    -- Meta-criterea creation intercept:
    orig_AchievementButton_GetMeta = AchievementButton_GetMeta
    AchievementButton_GetMeta = new_AchievementButton_GetMeta
    -- Add "series" tooltip to default achievement buttons:
    Overachiever.UI_HookAchButtons(AchievementFrameAchievements.buttons, AchievementFrameAchievementsContainerScrollBar)
    -- Allow closing frame with Escape even when UIPanelLayout-enabled is set to false:
    tinsert(UISpecialFrames, "AchievementFrame");

    -- Make main achievement UI draggable:
    -- - Prevent UIParent.lua from seeing area field (or it'll do things that mess up making the frame draggable).
    orig_AchievementFrame_area = UIPanelWindows["AchievementFrame"].area
    UIPanelWindows["AchievementFrame"].area = nil
    -- - Hook the first OnShow call to complete this. (Not done now in case saved variables aren't ready or the frame
    --   isn't showing right away.)
    orig_AchievementFrame_OnShow = AchievementFrame:GetScript("OnShow")
    AchievementFrame:SetScript("OnShow", AchievementUI_FirstShown)
    --[[ Pre-3.1 method:
    orig_AchievementFrame_OnShow = AchievementFrame_OnShow
    AchievementFrame_OnShow = AchievementUI_FirstShown
    --]]

  elseif (event == "PLAYER_LOGOUT") then
    if (Overachiever_CharVars.Pos_AchievementFrame) then
    -- Set standard location for this frame for other characters that don't have positions saved yet:
      Overachiever_CharVars_Default = Overachiever_CharVars_Default or {}
      Overachiever_CharVars_Default.Pos_AchievementFrame = Overachiever_CharVars.Pos_AchievementFrame
    end
   --[[  No longer necessary as this is now done by WoW itself:
    -- Remember tracked achievements:
    local num = GetNumTrackedAchievements()
    if (num > 0) then
      if (num == 1) then
        Overachiever_CharVars.TrackedAch = GetTrackedAchievements()
      else
        Overachiever_CharVars.TrackedAch = { GetTrackedAchievements() }
      end
    else
      Overachiever_CharVars.TrackedAch = nil
    end
   --]]

  end
end

function Overachiever.SearchForAchievement(isCustomList, searchList, argnum, msg, toChat, givelist, retTable)
-- If isCustomList is false (or nil), searchList should either be nil or an array of achievement category ID numbers.
-- If isCustomList is true, searchList should be an array of achievement ID numbers.
-- If isCustomList is 2, searchList should be a table containing such arrays.
  if (not searchList) then  isCustomList = nil;  end
  if (not givelist and not toChat) then
    if (isCustomList) then
      if (isCustomList == 2) then
        local id
        for k,sublist in pairs(searchList) do
          id = getAchievementID_tab(sublist, argnum, msg, true)
          if (id) then  return id;  end
        end
        return;
      else
        return getAchievementID_tab(searchList, argnum, msg, true)
      end
    else
      return getAchievementID(searchList, argnum, msg, true)
    end
  end
  local tab
  if (isCustomList) then
    if (isCustomList == 2) then
      tab = SearchAchievements_tab(searchList, argnum, msg, true)
    else
      tab = getAchievementID_tab(searchList, argnum, msg, true, true)
    end
  else
    tab = SearchAchievements(searchList, argnum, msg, true)
  end
  if (tab) then
    local id = tab[1]
    if (toChat) then  chatprint(L.MSG_OPENINGTO..GetAchievementLink(id));  end
    local tab2
    if (givelist) then
      tab2 = type(retTable) == "table" and wipe(retTable) or {}
      copytab(tab, tab2)
      if (not toChat) then  return tab2;  end
    end
    local size = #(tab)
    if (size == 2) then
      chatprint(L.MSG_ONEFOUND..GetAchievementLink(tab[2]))
    elseif (size > 2) then
      chatprint(L.MSG_NUMFOUNDLIST:format(size-1))
      local a, b, c
      for i=2,size,3 do
        a, b, c = tab[i], tab[i+1], tab[i+2]
        a, b, c = GetAchievementLink(a), b and GetAchievementLink(b), c and GetAchievementLink(c)
        if (b) then  a = a.."  --  "..b;  end
        if (c) then  a = a.."  --  "..c;  end
        chatprint(a, "-- ")
      end
    end
    return tab2 or id
  elseif (toChat) then
    chatprint(L.MSG_NAMENOTFOUND:format(msg))
  end
end

function Overachiever.OpenTab(name)
  if (not AchievementFrame or not AchievementFrame:IsShown()) then
    ToggleAchievementFrame()
  end
  local frame = _G[name]
  if (frame) then  Overachiever.OpenTab_frame(frame);  end
end

function Overachiever.UI_SelectAchievement(id, failFunc, ...)
  AchievementFrameBaseTab_OnClick(1)
  Overachiever.NoAlterSetFilter = true
  local retOK, ret1 = pcall(AchievementFrame_SelectAchievement, id)
  Overachiever.NoAlterSetFilter = nil
  if (retOK) then
    local category = GetAchievementCategory(id)
    local _, parentID = GetCategoryInfo(category)
    if (parentID == -1) then
      expandCategory(category)
    end
  else
    chatprint(L.MSG_ACHNOTFOUND)
    if (Overachiever_Debug) then
      chatprint(ret1, "[Error]")
    elseif (failFunc) then
      failFunc(...)
    else
    -- Open to summary to hide potentially problematic (though interesting) listing of irregular achievements:
      AchievementCategoryButton_OnClick(AchievementFrameCategoriesContainerButton1)
    end
  end
end

function Overachiever.UI_HookAchButtons(buttons, scrollbar)
  for i,button in ipairs(buttons) do
    button:HookScript("OnEnter", achbtnOnEnter)
    button:HookScript("OnLeave", achbtnOnLeave)
  end
  scrollbar:HookScript("OnValueChanged", achBtnRedisplay)
end

function Overachiever.UI_GetValidCategories()
  CATEGORIES_ALL = CATEGORIES_ALL or GetCategoryList()
  return CATEGORIES_ALL
end

Overachiever.IsAchievementInUI = isAchievementInUI;
Overachiever.OpenToAchievement = openToAchievement;
Overachiever.GetAllAchievements = getAllAchievements;
Overachiever.BuildCriteriaLookupTab = BuildCriteriaLookupTab;
Overachiever.AddAchListToTooltip = AddAchListToTooltip;


-- SLASH COMMANDS
-------------------

local function slashHandler(msg, self, silent, func_nomsg)
  if (msg == "") then
    func_nomsg = func_nomsg or ToggleAchievementFrame
    func_nomsg();
  else
    if (strsub(msg, 1,1) == "#") then
      local id = tonumber(strsub(msg, 2))
      if (id) then
        if (GetAchievementInfo(id)) then
          if (not silent) then  chatprint(L.MSG_OPENINGTO..GetAchievementLink(id));  end
          openToAchievement(id)
        elseif (not silent) then
          chatprint(L.MSG_INVALIDID);
        end
        return;
      end
    end
    local id = Overachiever.SearchForAchievement(nil, nil, ACHINFO_NAME, msg, not silent)
    if (id) then  openToAchievement(id);  end
  end
end

local function openOptions()
  InterfaceOptionsFrame_OpenToCategory(OptionsPanel)
end

SLASH_Overachiever1 = "/oa";
SlashCmdList["Overachiever"] = function (msg, self)  slashHandler(msg, self, nil, openOptions);  end

SLASH_Overachiever_silent1 = "/oasilent";
SLASH_Overachiever_silent2 = "/oas";
SlashCmdList["Overachiever_silent"] = function(msg, self)  slashHandler(msg, self, true, openOptions);  end;

SLASH_Overachiever_silentAch1 = "/achsilent";
SLASH_Overachiever_silentAch2 = "/achs";
SlashCmdList["Overachiever_silentAch"] = function(msg, self)  slashHandler(msg, self, true);  end;

-- Replace the original slash command handler for /ach, /achieve, /achievement, and /achievements:
SlashCmdList["ACHIEVEMENTUI"] = slashHandler;


-- LOCALIZATION ASSIST
--------------------------

if (Overachiever_Debug) then

  function Overachiever.Debug_GetKillCriteriaAchs()
    if (not Overachiever.AchLookup_kill) then  return;  end
    local tab, _, a = {}
    for k,v in pairs(Overachiever.AchLookup_kill) do
      for i = 1, #v, 2 do
        _, a = GetAchievementInfo( v[i] )
        tab[a] = (tab[a] or 0) + 1
      end
    end
    return tab
  end

  -- Achievement and criteria data gathering:

  function Overachiever.Debug_GetAchData()
    local tab = Overachiever_Settings.Debug_AchData
    if (not tab) then  Overachiever_Settings.Debug_AchData = {};  tab = Overachiever_Settings.Debug_AchData;  end
    local _, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText
    local critString, critType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString, critID
    for k,id in pairs(OVERACHIEVER_ACHID) do
      _, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText = GetAchievementInfo(id)
      tab[id] = { Name = Name, Description = Description, RewardText = RewardText }
      tab[id].Criteria = {}
      local crit = tab[id].Criteria
      for i=1,GetAchievementNumCriteria(id) do
        critString, critType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString, critID = GetAchievementCriteriaInfo(id, i)
        if (not strfind(quantityString, "/")) then  quantityString = nil;  end
        crit[i] = { critString = critString, quantityString = quantityString }
      end
    end
    chatprint("Achievement/criteria data gathered. Reload the interface or log out to output to saved variables file.")
  end

  -- Zone data gathering:

  local ZoneID

  local function BuildZoneIDTable_z(connum, num, zonename, next, ...)
    num = num + 1
    ZoneID[zonename] = {}
    ZoneID[zonename].C = connum
    ZoneID[zonename].Z = num
    if (next) then
      BuildZoneIDTable_z(connum, num, next, ...)
    end
  end

  -- Intended first call: BuildZoneIDTable(0, GetMapContinents());
  local function BuildZoneIDTable(num, conname, next, ...)
    num = num + 1
    --print("BuildZoneIDTable: "..conname.." ("..num..")")
    BuildZoneIDTable_z(num, 0, GetMapZones(num))
    if (next) then
      BuildZoneIDTable(num, next, ...)
    end
  end

  -- /run Overachiever.Debug_GetExplorationData(true)
  function Overachiever.Debug_GetExplorationData(testAchMatch, saveZoneIDs)
    if (not ZoneID and (testAchMatch or saveZoneIDs)) then
      ZoneID = {}
      BuildZoneIDTable(0, GetMapContinents());
      chatprint("Zone data gathered.")
    end
    if (saveZoneIDs) then  Overachiever_Settings.Debug_ZoneData = ZoneID;  end

    local tab = {}
    local catname, id, name, trimname
    for _, category in ipairs(CATEGORIES_EXPLOREZONES) do
      catname = GetCategoryInfo(category)
      tab[catname] = {}
      for i=1,GetCategoryNumAchievements(category) do
        id, name = GetAchievementInfo(category, i)
        if (testAchMatch) then
          trimname = strsub(name,9) -- Cut off "Explore " - meant for use with English client only
          if (trimname and ZoneID[trimname]) then
            name = trimname
          else
            chatprint("Achievement name doesn't match a zone: "..name)
            name = "!! "..name
          end
        end
        tab[catname][name] = id;
      end
    end
    Overachiever_Settings.Debug_ExplorationData = tab
    chatprint("Exploration Achievement data gathered. Reload the interface or log out to output to saved variables file.")
  end

end


-- FRAME INITIALIZATION
--------------------------

Overachiever.MainFrame = CreateFrame("Frame")
Overachiever.MainFrame:Hide()
Overachiever.MainFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
Overachiever.MainFrame:RegisterEvent("ADDON_LOADED")
--Overachiever.MainFrame:RegisterEvent("ACHIEVEMENT_EARNED")
Overachiever.MainFrame:RegisterEvent("TRACKED_ACHIEVEMENT_UPDATE")
Overachiever.MainFrame:RegisterEvent("PLAYER_LOGOUT")

Overachiever.MainFrame:SetScript("OnEvent", Overachiever.OnEvent)
Overachiever.MainFrame:SetScript("OnUpdate", AchievementUI_FirstShown_post)
