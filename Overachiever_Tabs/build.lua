
local L = OVERACHIEVER_STRINGS


local isAchievementInUI = Overachiever.IsAchievementInUI

local tabs, tabselected
local LeftFrame

local function emptyfunc() end

local ACHIEVEMENTUI_FONTHEIGHT

local FilterByTab = {}
local orig_AchievementFrame_SetFilter = AchievementFrame_SetFilter

AchievementFrame_SetFilter = function(value, tabswitch)
  if (not tabswitch) then
    local frame = tabselected or AchievementFrameAchievements
    FilterByTab[frame] = value
    Overachiever_Tabs_Settings.AchFilters[frame:GetName()] = value
  end
  if (not Overachiever.NoAlterSetFilter and (tabswitch or tabselected)) then
    local orig_SetValue = AchievementFrameAchievementsContainerScrollBar.SetValue
    AchievementFrameAchievementsContainerScrollBar.SetValue = emptyfunc
    orig_AchievementFrame_SetFilter(value)
    AchievementFrameAchievementsContainerScrollBar.SetValue = orig_SetValue
  else
    return orig_AchievementFrame_SetFilter(value)
  end
end


local function getFrameOfButton(button)
  return button:GetParent():GetParent():GetParent()
end

local function clearSelection(frame)
-- Based on AchievementFrameAchievements_ClearSelection().
  AchievementButton_ResetObjectives();
  for _, button in next, frame.buttons do
    button:Collapse();
    if ( not button:IsMouseOver() ) then
      button.highlight:Hide();
    end
    button.selected = nil;
    if ( not button.tracked:GetChecked() ) then
      button.tracked:Hide();
    end
    button.description:Show();
    button.hiddenDescription:Hide();
  end

  frame.selection = nil;
end

local function selectButton(button)
-- Based on AchievementFrameAchievements_SelectButton().
  local achievements = getFrameOfButton(button);

  achievements.selection = button.id;
  achievements.selectionIndex = button.index;
  button.selected = true;
end

local function isPreviousAchievementInUI(id)
  id = GetPreviousAchievement(id)
  if (id) then
    if (isAchievementInUI(id)) then  return true;  end
    return isPreviousAchievementInUI(id)
  end
end

local function displayAchievement(button, frame, achievement, index, selectionID)
-- This function is based on AchievementButton_DisplayAchievement, with only a few alterations as needed.
  local id, name, points, completed, month, day, year, description, flags, icon, rewardText
  if (achievement) then
    id, name, points, completed, month, day, year, description, flags, icon, rewardText = GetAchievementInfo(achievement);
  end
  if ( not id ) then
    button:Hide();
    return;
  else
    button:Show();
  end

  button.index = index;
  button.element = true;

  if ( button.id ~= id ) then
    button.id = id;
    button.label:SetWidth(ACHIEVEMENTBUTTON_LABELWIDTH);
    button.label:SetText(name)

    if ( GetPreviousAchievement(id) ) then
      -- If this is a progressive achievement, show the total score.
      AchievementShield_SetPoints(AchievementButton_GetProgressivePoints(id), button.shield.points, AchievementPointsFont, AchievementPointsFontSmall);
    else
      AchievementShield_SetPoints(points, button.shield.points, AchievementPointsFont, AchievementPointsFontSmall);
    end
    if ( points > 0 ) then
      button.shield.icon:SetTexture([[Interface\AchievementFrame\UI-Achievement-Shields]]);
    else
      button.shield.icon:SetTexture([[Interface\AchievementFrame\UI-Achievement-Shields-NoPoints]]);
    end
    button.description:SetText(description);
    button.hiddenDescription:SetText(description);
    button.numLines = ceil(button.hiddenDescription:GetHeight() / ACHIEVEMENTUI_FONTHEIGHT);
    button.icon.texture:SetTexture(icon);
    if ( completed and not button.completed ) then
      button.completed = true;
      button.dateCompleted:SetText(string.format(SHORTDATE, day, month, year));
      button.dateCompleted:Show();
      button:Saturate();
    elseif ( completed ) then
      button.dateCompleted:SetText(string.format(SHORTDATE, day, month, year));
    else
      button.completed = nil;
      button.dateCompleted:Hide();
      button:Desaturate();
      -- Overachiever color customization:
      local RecentReminders = Overachiever.RecentReminders
      -- Make sure Overachiever.RecentReminders_Check() was called before displayAchievement(...) for this:
      if (RecentReminders and RecentReminders[id]) then
        local name = button:GetName()
        --button:SetBackdropBorderColor(.8, .5, .5)
        _G[name .. "Background"]:SetTexture("Interface\\AddOns\\Overachiever_Tabs\\ParchmentDesaturateGreen")
        _G[name.."Glow"]:SetVertexColor(.13, .52, .17)
      elseif (not isAchievementInUI(id)) then
        local name = button:GetName()
        --button:SetBackdropBorderColor(.8, .5, .5)
        if (isPreviousAchievementInUI(id)) then
          _G[name .. "Background"]:SetTexture("Interface\\AddOns\\Overachiever_Tabs\\ParchmentDesaturateBlue")
          _G[name.."Glow"]:SetVertexColor(.22, .17, .43)
        else
          _G[name .. "Background"]:SetTexture("Interface\\AddOns\\Overachiever_Tabs\\ParchmentDesaturateRed")
          _G[name.."Glow"]:SetVertexColor(.52, .17, .13)
        end
      end
    end

    if ( rewardText == "" ) then
      button.reward:Hide();
      button.rewardBackground:Hide();
    else
      button.reward:SetText(rewardText);
      button.reward:Show();
      button.rewardBackground:Show();
      if ( button.completed ) then
        button.rewardBackground:SetVertexColor(1, 1, 1);
      else
        button.rewardBackground:SetVertexColor(0.35, 0.35, 0.35);
      end
    end

    if ( IsTrackedAchievement(id) ) then
      button.check:Show();
      button.label:SetWidth(button.label:GetStringWidth() + 4);
      button.tracked:SetChecked(true);
      button.tracked:Show();
    else
      button.check:Hide();
      button.tracked:SetChecked(false);
      button.tracked:Hide();
    end
  end

  if ( id == selectionID ) then
    frame.selection = button.id;
    frame.selectionIndex = button.index;
    button.selected = true;
    button.highlight:Show();
    local height = AchievementButton_DisplayObjectives(button, button.id, button.completed);
    if ( height == ACHIEVEMENTBUTTON_COLLAPSEDHEIGHT ) then
      button:Collapse();
    else
      button:Expand(height);
    end
    if ( not completed ) then
      button.tracked:Show();
    end
  elseif ( button.selected ) then
    button.selected = nil;
    if ( not button:IsMouseOver() ) then
      button.highlight:Hide();
    end
    button:Collapse();
    button.description:Show();
    button.hiddenDescription:Hide();
  end

  return id;
end

local sortList
do
  local getret

  local function sortList_simple(a, b)
    local aV = select(getret, GetAchievementInfo(a))
    local bV = select(getret, GetAchievementInfo(b))
    if (aV == nil) then
      a, getret = tostringall(a, getret)
      error("nil value found while sorting: ID="..a..", getret="..getret)
    elseif (bV == nil) then
      b, getret = tostringall(b, getret)
      error("nil value found while sorting: ID="..b..", getret="..getret)
    end

    -- If values are the same, fall back to alphabetical order by name:
    if (aV == bV) then
      local aID, bID
      aID, aV = GetAchievementInfo(a)
      bID, bV = GetAchievementInfo(b)
      -- If names are the same, fall back to ID:
      if (aV == bV) then
        aV, bV = aID, bID
      end
    end
    if (type(aV) == "string") then
    -- Handle things so, e.g., "200 Daily Quests Complete" comes before "1000 Daily Quests Complete":
      local numA, textA = aV:match("([^%s]+) (.+)")
      numA = tonumber(numA)
      if (numA) then
        local numB, textB = bV:match("([^%s]+) (.+)")
        numB = tonumber(numB)
        if (numB) then
          if (numA ~= numB) then  return numA < numB;  end
          return textA < textB
        end
      end
    end
    return aV < bV
  end

  local function sortList_date(a, b)
    local aM, aD, aY = select(5, GetAchievementInfo(a))
    local bM, bD, bY = select(5, GetAchievementInfo(b))
    if (aM and bM) then  -- Both achievements are completed
      if (aY < bY) then
        return true
      elseif (aY > bY) then
        return false
      elseif (aM < bM) then
        return true
      elseif (aM > bM) then
        return false
      elseif (aD < bD) then
        return true
      elseif (aD > bD) then
        return false
      end
    elseif (aM) then  -- A is complete; B is not
      return true
    elseif (bM) then  -- B is complete; A is not
      return false
    end
    -- If dates are the same or neither is complete, fall back to alphabetical order by name:
    getret = 2
    return sortList_simple(a, b)
  end

  function sortList(list, mode)
    if (#list < 2) then
      return list
    elseif (mode == 1) then  -- Date completed
      sort(list, sortList_date)
    elseif (mode == 2) then  -- Points
      getret = 3;
      sort(list, sortList_simple)
    elseif (mode == 3) then  -- ID
      sort(list)  -- ID already given in the table, so default sort can handle this.
    else  -- Name (mode 0, default)
      getret = 2
      sort(list, sortList_simple)
    end
  end
end

local FilteredList, FilteredList_current
local function applyAchievementFilter(list, completed, built, checkprev, critlist)
  FilteredList = FilteredList or {}
  local list2 = FilteredList[list]
  if (list2) then
    if (built and FilteredList_current[list] == completed) then  return list2;  end
    wipe(list2)
  else
    FilteredList[list] = {}
    list2 = FilteredList[list]
  end
  local count, _, c = 0
  for i,id in pairs(list) do  -- Using pairs instead of ipairs so we can safely nil things out.
    if (critlist and critlist[id]) then
      _, _, c = GetAchievementCriteriaInfo(id, critlist[id])
    else
      _, _, _, c = GetAchievementInfo(id)
    end
    if (c == completed) then
      count = count + 1
      list2[count] = id
    elseif (checkprev and completed) then
    -- If we're listing complete achievements and this one is incomplete but it's in a series where the previous
    -- one is complete, then we can display that one instead. This option is used by the Suggestions tab.
      local prev = GetPreviousAchievement(id)
      if (prev) then
        _, _, _, c = GetAchievementInfo(prev)
        -- We don't need to go any deeper than one previous, since the Suggestions by default finds the first
        -- incomplete one (or the last one in the series, if all are complete).
        if (c) then
          count = count + 1
          list2[count] = prev
        end
      end
    end
  end
  FilteredList_current = FilteredList_current or {}
  FilteredList_current[list] = completed
  return list2
end

local function updateAchievementsList(frame)
  local list, sorted = frame.AchList, frame.AchList_sorted
  if (ACHIEVEMENTUI_SELECTEDFILTER == AchievementFrame_GetCategoryNumAchievements_Complete) then
    list = applyAchievementFilter(list, true, sorted, frame.AchList_checkprev, frame.AchList_criteria)
  elseif (ACHIEVEMENTUI_SELECTEDFILTER == AchievementFrame_GetCategoryNumAchievements_Incomplete) then
    list = applyAchievementFilter(list, false, sorted, frame.AchList_checkprev, frame.AchList_criteria)
  end
  if (not sorted) then
    sortList(list, frame.sort)
    frame.AchList_sorted = true
  end
-- This function based on AchievementFrameAchievements_Update in Blizzard_AchievementUI.lua.
  local scrollFrame = frame.scrollFrame
  local offset = HybridScrollFrame_GetOffset(scrollFrame);
  local buttons = scrollFrame.buttons;
  local numAchievements = #list
  local numButtons = #buttons;

  local selection = frame.selection;
  if ( selection ) then
    AchievementButton_ResetObjectives();
  end

  local extraHeight = scrollFrame.largeButtonHeight or ACHIEVEMENTBUTTON_COLLAPSEDHEIGHT

  Overachiever.RecentReminders_Check()
  local displayedHeight, index = 0;
  for i = 1, numButtons do
    index = i + offset
    displayAchievement(buttons[i], frame, list[index], index, selection);
    displayedHeight = displayedHeight + buttons[i]:GetHeight();
  end

  local totalHeight = numAchievements * ACHIEVEMENTBUTTON_COLLAPSEDHEIGHT;
  totalHeight = totalHeight + (extraHeight - ACHIEVEMENTBUTTON_COLLAPSEDHEIGHT);

  HybridScrollFrame_Update(scrollFrame, totalHeight, displayedHeight);

  if ( selection ) then
    frame.selection = selection;
  else
    HybridScrollFrame_CollapseButton(scrollFrame);
  end
  
  if (frame.SetNumListed) then  frame.SetNumListed(#list);  end
end

local function forceUpdate(frame, keepSelection, fromHook)
-- Based on AchievementFrameAchievements_ForceUpdate:
  if ( not keepSelection and frame.selection ) then
    local nextID = GetNextAchievement(frame.selection);
    local id, _, _, completed = GetAchievementInfo(frame.selection);
    if ( nextID and completed ) then
      frame.selection = nil;
    end
  end
  if (not fromHook) then
  -- Don't do these when called by forceUpdate_all because they are handled by
  -- AchievementFrameAchievements_ForceUpdate and shouldn't occur again:
    AchievementFrameAchievementsObjectives:Hide();
    AchievementFrameAchievementsObjectives.id = nil;
  end

  local buttons = frame.scrollFrame.buttons;
  for i, button in next, buttons do
    button.id = nil;
  end

  frame.AchList_sorted = nil
  if (frame:IsShown()) then  updateAchievementsList(frame);  end
end

local function forceUpdate_all()
  for k,tab in ipairs(tabs) do
    forceUpdate(tab.frame, nil, true)
  end
end

local function tabUnselect()
  tabselected = nil
  for k,tab in ipairs(tabs) do
    tab.text:SetPoint("CENTER", tab, "CENTER", 0, -3)
  end
end

local function tabOnClick(self, button)
  self.text:SetPoint("CENTER", self, "CENTER", 0, -5)
  local i, tab = 0
  repeat
    i = i + 1
    tab = _G["AchievementFrameTab"..i]
    if (tab and tab ~= self) then
      tab.text:SetPoint("CENTER", tab, "CENTER", 0, -3)
    end
  until (not tab)
  -- Don't play sound when this is a silentDisplay or Overachiever.OpenTab_frame call.
  if (button) then  PlaySound("igCharacterInfoTab");  end

  if (self.flash and UIFrameIsFading(self.flash)) then
    UIFrameFlashRemoveFrame(self.flash)
    self.flash:Hide()
  end

  tabselected = self.frame
  AchievementFrame_ShowSubFrame(self.frame, LeftFrame)
  LeftFrame.label:SetText(self:GetText())
  AchievementFrameWaterMark:SetTexture(self.watermark)
  PanelTemplates_Tab_OnClick(self, AchievementFrame)
  updateAchievementsList(self.frame)
end

local function silentDisplay(button)
  tabOnClick(getFrameOfButton(button).tab)
end

local orig_compheader_OnShow
local function compheader_OnShow(...)
  -- Prevent comparison portrait from reverting to player's when you switch tabs while comparing achievements:
  if (not tabselected) then  orig_compheader_OnShow(...);  end
end

local function achbtnOnClick(self, button)
  local id = self.id
  if ( IsControlKeyDown() and (GetPreviousAchievement(id) or isAchievementInUI(id, true)) ) then
    Overachiever.UI_SelectAchievement(id, silentDisplay, self)
    return;
  elseif (Overachiever_WatchFrame and IsAltKeyDown()) then
    Overachiever_WatchFrame.SetAchWatchList(id, tabselected ~= Overachiever_WatchFrame)
    return;
  end
  -- This section based on the AchievementButton_OnClick function in Blizzard_AchievementUI.lua:
  if (IsModifiedClick()) then
    if ( IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow() ) then
      local achievementLink = GetAchievementLink(self.id);
      if ( achievementLink ) then
        ChatEdit_InsertLink(achievementLink);
      end
    elseif ( IsModifiedClick("QUESTWATCHTOGGLE") ) then
      AchievementButton_ToggleTracking(self.id);
    end
    return;
  end

  local frame = getFrameOfButton(self)
  if ( self.selected ) then
    if ( not self:IsMouseOver() ) then
      self.highlight:Hide();
    end
    clearSelection(frame)
    HybridScrollFrame_CollapseButton(frame.scrollFrame);
    updateAchievementsList(frame);
    return;
  end
  clearSelection(frame)
  selectButton(self);
  Overachiever.RecentReminders_Check()
  displayAchievement(self, frame, self.id, self.index, self.id)
  HybridScrollFrame_ExpandButton(frame.scrollFrame, ((self.index - 1) * ACHIEVEMENTBUTTON_COLLAPSEDHEIGHT), self:GetHeight());
  updateAchievementsList(frame)
end

local redir_btn_tinsert
local function post_AchievementButton_OnLoad(self)
  if (redir_btn_tinsert) then
    self:SetScript("OnClick", achbtnOnClick)
    tinsert(redir_btn_tinsert, self);
    -- Undo the last addition to the table normally used (we don't want our buttons listed there):
    tremove(AchievementFrameAchievements.buttons);
    
    if ( not ACHIEVEMENTUI_FONTHEIGHT ) then
      local _, fontHeight = self.description:GetFont();
      ACHIEVEMENTUI_FONTHEIGHT = fontHeight;
    end
  end
end

local function ListFrame_OnShow(self)
  self.panel:Show()
  AchievementFrame_SetFilter( FilterByTab[self] or ACHIEVEMENT_FILTER_ALL, true )
end

local function ListFrame_OnHide(self)
  self.panel:Hide()
end


function Overachiever.BuildNewTab(name, text, watermark, helptip, loadFunc, filter)
  local numtabs, tab = 0
  repeat
    numtabs = numtabs + 1
  until (not _G["AchievementFrameTab"..numtabs])
  tab = CreateFrame("Button", "AchievementFrameTab"..numtabs, AchievementFrame, "AchievementFrameTabButtonTemplate")
  tab:SetText(text)
  tab:SetPoint("LEFT", "AchievementFrameTab"..numtabs-1, "RIGHT", -5, 0)
  tab:SetID(numtabs)
  PanelTemplates_SetNumTabs(AchievementFrame, numtabs)

  local frame = CreateFrame("Frame", name, AchievementFrame)
  frame:SetWidth(504); frame:SetHeight(440)
  frame:SetPoint("TOPLEFT", AchievementFrameAchievements, "TOPLEFT", 0, 0)
  frame:SetPoint("BOTTOM", AchievementFrameAchievements, "BOTTOM")
  local frameBG = frame:CreateTexture("$parentBackground", "BACKGROUND")
  frameBG:SetTexture("Interface\\AchievementFrame\\UI-Achievement-AchievementBackground")
  frameBG:SetPoint("TOPLEFT", frame, "TOPLEFT", 3, -3)
  frameBG:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -3, 3)
  local frameBGDarken = frame:CreateTexture(nil, "ARTWORK")
  frameBGDarken:SetAllPoints(frameBG)
  frameBGDarken:SetTexture(0, 0, 0, 0.75)
  local frameBorder = CreateFrame("Frame", nil, frame)
  frameBorder:SetAllPoints(frame)
  frameBorder:SetBackdrop( {
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 5, right = 5, top = 5, bottom = 5 }
  } )
  frameBorder:SetBackdropBorderColor(ACHIEVEMENTUI_GOLDBORDER_R, ACHIEVEMENTUI_GOLDBORDER_G, ACHIEVEMENTUI_GOLDBORDER_B, ACHIEVEMENTUI_GOLDBORDER_A)
  frameBorder:SetFrameLevel(frameBorder:GetFrameLevel()+1)

  local scrollframe = CreateFrame("ScrollFrame", "$parentContainer", frame, "HybridScrollFrameTemplate")
  scrollframe:SetWidth(504); scrollframe:SetHeight(440)
  scrollframe:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -3)
  scrollframe:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 5)
  local scrollbar = CreateFrame("Slider", "$parentScrollBar", scrollframe, "HybridScrollBarTemplate")
  scrollbar:SetPoint("TOPLEFT", scrollframe, "TOPRIGHT", 1, -16)
  scrollbar:SetPoint("BOTTOMLEFT", scrollframe, "BOTTOMRIGHT", 1, 12)
  frame.scrollFrame = scrollframe

  scrollbar.Show =
    function (self)
      frame:SetWidth(504);
      for _, button in next, frame.buttons do
        button:SetWidth(496);
      end
      getmetatable(self).__index.Show(self);
    end

  scrollbar.Hide =
    function (self)
      frame:SetWidth(530);
      for _, button in next, frame.buttons do
        button:SetWidth(522);
      end
      getmetatable(self).__index.Hide(self);
    end

  tinsert(ACHIEVEMENTFRAME_SUBFRAMES, name)

  tab.watermark, tab.loadFunc = watermark, loadFunc
  tab.frame = frame
  frame.tab = tab
  frame.helptip = helptip

  tab:SetScript("OnClick", tabOnClick)
  if (not tabs) then
    tabs = {}
    hooksecurefunc("AchievementFrameBaseTab_OnClick", tabUnselect)
    hooksecurefunc("AchievementFrameComparisonTab_OnClick", tabUnselect)
    orig_compheader_OnShow = AchievementFrameComparisonHeader:GetScript("OnShow")
    AchievementFrameComparisonHeader:SetScript("OnShow", compheader_OnShow)
    hooksecurefunc("AchievementButton_OnLoad", post_AchievementButton_OnLoad)
    hooksecurefunc("AchievementFrameAchievements_ForceUpdate", forceUpdate_all)
  end
  tabs[#(tabs)+1] = tab
  frame.AchList = {}
  frame.ForceUpdate = forceUpdate

  scrollframe.update = function() updateAchievementsList(frame) end;  -- Needed in this fashion for HybridScrollFrame_SetOffset calls.
  _G[name.."ContainerScrollBarBG"]:Show()
  frame.buttons = {}
  redir_btn_tinsert = frame.buttons
  HybridScrollFrame_CreateButtons(scrollframe, "AchievementTemplate", 0, -2);
  redir_btn_tinsert = nil
  Overachiever.UI_HookAchButtons(frame.buttons, scrollbar)

  local panel = CreateFrame("Frame", nil, LeftFrame)
  panel:SetPoint("TOPLEFT", LeftFrame.label, "BOTTOMLEFT", 0, -6)
  panel:SetPoint("RIGHT", LeftFrame, "RIGHT")
  panel:SetPoint("BOTTOM", LeftFrame, "BOTTOM")
  panel:Hide()
  frame.panel = panel
  frame:Hide()
  frame:SetScript("OnShow", ListFrame_OnShow)
  frame:SetScript("OnHide", ListFrame_OnHide)
  
  FilterByTab[frame] = filter

  return frame, panel
end

function Overachiever.OpenTab_frame(frame)
  tabOnClick(frame.tab)
end


local function HelpIcon_OnEnter(self)
  self.tex:SetTexture("Interface\\AddOns\\Overachiever_Tabs\\HelpIconHighlight")
  GameTooltip:SetOwner(self, "ANCHOR_NONE")
  GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 10, 0)
  GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
  GameTooltip:AddLine(self.tip:format(tabselected.tab:GetText()), 1, 1, 1)
  --GameTooltip:AddLine(" ")
  GameTooltip:AddLine(tabselected.helptip, nil, nil, nil, 1)
  GameTooltip:AddLine(" ")
  GameTooltip:AddLine(L.TAB_HELP, nil, nil, nil, 1)
  GameTooltip:Show()
end

local function HelpIcon_OnLeave(self)
  self.tex:SetTexture("Interface\\AddOns\\Overachiever_Tabs\\HelpIcon")
  GameTooltip:Hide()
end

local function LeftFrame_OnShow(self)
  AchievementFrameCategoriesContainer:Hide()
  AchievementFrameCategoriesContainerScrollBar:Hide()
  AchievementFrameFilterDropDown:Show()
  AchievementFrameHeaderRightDDLInset:Show()
end

local function LeftFrame_OnHide(self)
  AchievementFrameCategoriesContainer:Show()
  if (not AchievementFrameAchievements:IsShown()) then
    AchievementFrameFilterDropDown:Hide()
    AchievementFrameHeaderRightDDLInset:Hide()
  end
  if (not Overachiever.NoAlterSetFilter) then
    AchievementFrame_SetFilter( FilterByTab[AchievementFrameAchievements] or ACHIEVEMENT_FILTER_ALL, true )
  end
end

local function LeftFrame_OnEvent_CRITERIA_UPDATE()
  for k,tab in ipairs(tabs) do
    local frame = tab.frame
    if ( frame.selection and tabselected == frame ) then
-- Based on part of AchievementFrameAchievements_OnEvent.
      local id = AchievementFrameAchievementsObjectives.id;
      local button = AchievementFrameAchievementsObjectives:GetParent();
      AchievementFrameAchievementsObjectives.id = nil;
      AchievementButton_DisplayObjectives(button, id, button.completed);
      updateAchievementsList(frame)
      return; -- This only needs to happen once, no matter which frame it is that's currently shown.
    end
  end
end


do
  LeftFrame = CreateFrame("Frame", "Overachiever_LeftFrame", AchievementFrameCategories)
  LeftFrame:SetPoint("TOPLEFT", AchievementFrameCategories, "TOPLEFT", 9, -5)
  LeftFrame:SetPoint("TOPRIGHT", AchievementFrameCategories, "TOPRIGHT", -9, -5)
  LeftFrame:SetPoint("BOTTOM", AchievementFrameCategories, "BOTTOM", 0, 8)

  local label = LeftFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
  label:SetPoint("TOPLEFT", LeftFrame, "TOPLEFT", 1, -6)
  label:SetText("Overachiever")
  LeftFrame.label = label

  local HelpIcon = CreateFrame("Frame", nil, LeftFrame)
  HelpIcon:SetWidth(32); HelpIcon:SetHeight(32)
  HelpIcon:SetPoint("LEFT", label, "RIGHT", 4, 0)
  local tex = HelpIcon:CreateTexture(nil, "BACKGROUND")
  tex:SetTexture("Interface\\AddOns\\Overachiever_Tabs\\HelpIcon")
  tex:SetPoint("CENTER", HelpIcon, "CENTER", 0, 0)
  HelpIcon.tex = tex
  HelpIcon:EnableMouse(true)
  HelpIcon:SetScript("OnEnter", HelpIcon_OnEnter)
  HelpIcon:SetScript("OnLeave", HelpIcon_OnLeave)
  HelpIcon.tip = GetAddOnMetadata("Overachiever", "Title")..": %s"
  HelpIcon:SetScale(0.85)

  LeftFrame:Hide()
  LeftFrame:SetScript("OnShow", LeftFrame_OnShow)
  LeftFrame:SetScript("OnHide", LeftFrame_OnHide)

  tinsert(ACHIEVEMENTFRAME_SUBFRAMES, "Overachiever_LeftFrame")

  LeftFrame:RegisterEvent("ADDON_LOADED")
  LeftFrame:SetScript("OnEvent", function(self, event, arg1)
    if (arg1 == "Overachiever_Tabs") then
      self:UnregisterEvent("ADDON_LOADED")
      self:RegisterEvent("CRITERIA_UPDATE")
      self:SetScript("OnEvent", LeftFrame_OnEvent_CRITERIA_UPDATE)

      Overachiever_Tabs_Settings = Overachiever_Tabs_Settings or {}
      local v = Overachiever_Tabs_Settings
      local oldver = v.Version
      v.Version = GetAddOnMetadata("Overachiever_Tabs", "Version")
      if (oldver == v.Version) then  oldver = false;  end

      v.AchFilters = v.AchFilters or {}
      local AchFilters = v.AchFilters
      if (AchFilters["AchievementFrameAchievements"]) then
        AchievementFrame_SetFilter(AchFilters["AchievementFrameAchievements"])
      end
      if (tabs) then
        local name
        for k,tab in ipairs(tabs) do
          name = tab.frame:GetName()
          if (AchFilters[name]) then  FilterByTab[tab.frame] = AchFilters[name];  end
          if (tab.loadFunc) then
            tab.loadFunc(v, oldver)
            tab.loadFunc = nil
          end
        end
      end
    end
  end)
end

-- Meta-criteria creation intercept (in addition to the base Overachiever intercept):
local function MetaCriteriaOnClick(self)
  local id = self.id
  if (id and (GetPreviousAchievement(id) or isAchievementInUI(id, true)) ) then
    Overachiever.UI_SelectAchievement(id, silentDisplay, self:GetParent():GetParent())
  end
end
local orig_AchievementButton_GetMeta = AchievementButton_GetMeta
local function new_AchievementButton_GetMeta(...)
  local frame = orig_AchievementButton_GetMeta(...)
  frame:SetScript("OnClick", MetaCriteriaOnClick)
  return frame;
end
AchievementButton_GetMeta = new_AchievementButton_GetMeta

-- Meta-criteria recolor:
local function recolor_AchievementObjectives_DisplayCriteria(objectivesFrame, id)
  if (not id or GetPreviousAchievement(id) or isAchievementInUI(id, true)) then  return;  end
  local metaCriteria, index = AchievementFrameMeta1, 1
  while (metaCriteria and metaCriteria:IsShown()) do
    if (not GetPreviousAchievement(metaCriteria.id) and not isAchievementInUI(metaCriteria.id, true)) then
      metaCriteria.label:SetTextColor(.9, .4, .4, 1)
    end
    index = index + 1
    metaCriteria = _G["AchievementFrameMeta"..index]
  end
end
hooksecurefunc("AchievementObjectives_DisplayCriteria", recolor_AchievementObjectives_DisplayCriteria)


-- Flashing tab:
function Overachiever.FlashTab(tab)
  if (tabselected and tabselected.tab == tab) then  return;  end
  local flash = tab.flash
  if (not flash) then
    flash = CreateFrame("Frame", tab:GetName().."Flash", tab)
    flash:SetPoint("TOPLEFT", "$parentLeft", "TOPLEFT")
    flash:SetPoint("BOTTOMRIGHT", "$parentRight", "BOTTOMRIGHT")
    local tex = flash:CreateTexture("$parentBackground", "BACKGROUND")
    tex:SetTexture("Interface\\AddOns\\Overachiever_Tabs\\TabHighlight")
    tex:SetBlendMode("ADD")
    tex:SetPoint("TOPLEFT", flash, "TOPLEFT", 7, 8)
    tex:SetPoint("BOTTOMRIGHT", flash, "BOTTOMRIGHT", -3, -3)
    tab.flash = flash
  end
  if (UIFrameIsFading(flash)) then  UIFrameFlashRemoveFrame(flash);  end
  UIFrameFlash(flash, 0.35, 0.35, 0.9, nil, 0.05, 0.15)
end
