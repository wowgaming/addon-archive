
--
--  Overachiever - Tabs: Watch.lua
--    by Tuhljin
--
--  If you don't wish to use the watch tab, feel free to delete this file or rename it (e.g. to Watch_unused.lua).
--  The addon's other features will work regardless.
--

local L = OVERACHIEVER_STRINGS


local VARS, CurrentWatchList, DestinationWatchList
local frame, panel, sortdrop, listdrop, deflistdrop, destlistdrop
local listdrop_menu, deflistdrop_menu, destlistdrop_menu, listdrop_OnSelect, deflistdrop_OnSelect, destlistdrop_OnSelect
local NewListBtn, DeleteListBtn, CopyDestCheckbox, CopyDestAchAnim, NoneWatchedLabel
local Refresh, skipRefresh

local THIS_REALM, THIS_PC = GetRealmName(), UnitName("player")

local function SortDrop_OnSelect(self, value)
  VARS.WatchSort = value
  frame.sort = value
  frame:ForceUpdate(true)
end

local function OnLoad(v, oldver)
  VARS = v
  sortdrop:SetSelectedValue(VARS.WatchSort or 0)

  -- Create standard lists:
  VARS.WatchLists_Realms = VARS.WatchLists_Realms or {}
  VARS.WatchLists_Realms[THIS_REALM] = VARS.WatchLists_Realms[THIS_REALM] or {}
  VARS.WatchLists_Realms[THIS_REALM][THIS_PC] = VARS.WatchLists_Realms[THIS_REALM][THIS_PC] or {}
  VARS.WatchLists_General = VARS.WatchLists_General or {}
  VARS.WatchLists = VARS.WatchLists or {}
  if (not VARS.WatchedList) then
    VARS.WatchedList = 0
  elseif (oldver == nil) then  -- If prior to v0.56 (which introduced version tracking for these settings):
    for id in pairs(VARS.WatchedList) do  -- Migrate to new table:
      VARS.WatchLists_General[id] = true
    end
    VARS.WatchedList = 0
  end

  -- With existing items, set usable references for menu's OnSelect function (for listdrop_menu) and the GameTooltip_AddNewbieTip hook below (for listdrop_menu and deflist_menu):
  listdrop_menu[1].Overachiever_list = VARS.WatchLists_General
  listdrop_menu[2].Overachiever_list = VARS.WatchLists_Realms[THIS_REALM][THIS_PC]
  deflistdrop_menu[1].Overachiever_list = VARS.WatchLists_General
  deflistdrop_menu[2].Overachiever_list = VARS.WatchLists_Realms[THIS_REALM][THIS_PC]
  -- Add custom lists to dropdown menus:
  for name,tab in pairs(VARS.WatchLists) do
    tinsert(listdrop_menu, {  text = name, value = name, tooltipTitle = name, Overachiever_list = tab  })
    tinsert(deflistdrop_menu, {  text = name, value = name, tooltipTitle = name, Overachiever_list = tab  })
  end
  -- Add realm/character lists to dropdown menu:
  for rname,rtab in pairs(VARS.WatchLists_Realms) do
    local menuList, num = {}, 0
    for cname,tab in pairs(rtab) do
      if (rname ~= THIS_REALM or cname ~= THIS_PC) then  -- Don't add the current character; it is included in the first tier of the menu.
        tinsert(menuList, {  text = cname, value = "~^"..rname..":"..cname, tooltipTitle = cname, Overachiever_list = tab  })
        num = num + 1
      end
    end
    if (num > 0) then
      tinsert(listdrop_menu, {  text = rname, value = "~^"..rname, hasArrow = true, TjDDM_notCheckable = 1, keepShownOnClick = 1, menuList = menuList  })
    end
  end

  skipRefresh = true
  listdrop:SetMenu()
  deflistdrop:SetMenu()
  listdrop:OnSelect(listdrop_OnSelect) -- Put before SetSelectedValue so CurrentWatchList can be set easily.
  listdrop:SetSelectedValue(VARS.WatchedList == 1 and "~^"..THIS_REALM..":"..THIS_PC or VARS.WatchedList)
  deflistdrop:SetSelectedValue(VARS.WatchedList)
  deflistdrop:OnSelect(deflistdrop_OnSelect)
  destlistdrop:OnSelect(destlistdrop_OnSelect)
  skipRefresh = nil

  CurrentWatchList = CurrentWatchList or VARS.WatchLists_General  -- Default, in case the list we looked for doesn't exist.
  DestinationWatchList = VARS.WatchLists_General
  
  -- If using Global or the current character's character-specific list, it cannot be deleted, only cleared:
  if (VARS.WatchedList == 0 or VARS.WatchedList == 1) then  DeleteListBtn:SetText(L.WATCH_CLEAR);  end

  frame:RegisterEvent("PLAYER_LOGOUT")
end

frame, panel = Overachiever.BuildNewTab("Overachiever_WatchFrame", L.WATCH_TAB,
                 "Interface\\AddOns\\Overachiever_Tabs\\WatchWatermark", L.WATCH_HELP, OnLoad)

sortdrop = TjDropDownMenu.CreateDropDown("Overachiever_WatchFrameSortDrop", panel, {
  {
    text = L.TAB_SORT_NAME,
    value = 0
  },
  {
    text = L.TAB_SORT_COMPLETE,
    value = 1
  },
  {
    text = L.TAB_SORT_POINTS,
    value = 2
  },
  {
    text = L.TAB_SORT_ID,
    value = 3
  };
})
sortdrop:SetLabel(L.TAB_SORT, true)
sortdrop:SetPoint("TOPLEFT", panel, "TOPLEFT", -16, -22)
sortdrop:OnSelect(SortDrop_OnSelect)

function frame.SetNumListed(num)
  if (num > 0) then
    if (NoneWatchedLabel) then  NoneWatchedLabel:Hide();  end
  elseif (not NoneWatchedLabel) then
    NoneWatchedLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    NoneWatchedLabel:SetPoint("TOP", frame, "TOP", 0, -189)
    NoneWatchedLabel:SetText(L.WATCH_EMPTY)
    NoneWatchedLabel:SetWidth(490)
  else
    NoneWatchedLabel:Show()
  end
end


function Refresh()
  if (skipRefresh) then  return;  end
  local list, count = frame.AchList, 0
  wipe(list)
  for id in pairs(CurrentWatchList) do
    count = count + 1
    list[count] = id
  end
  Overachiever_WatchFrameContainerScrollBar:SetValue(0)
  frame:ForceUpdate(true)
end

panel:SetScript("OnShow", Refresh)

function frame.SetAchWatchList(id, add)
  if (not add and frame:IsVisible() and IsShiftKeyDown()) then
    if (CopyDestCheckbox:GetChecked()) then
      DestinationWatchList[id] = true
      PlaySound("igMainMenuOptionCheckBoxOn")
      if (not CopyDestAchAnim) then
        CopyDestAchAnim = CreateFrame("Model", "Overachiever_WatchFrameModelTest", panel)
        CopyDestAchAnim:Hide()
        CopyDestAchAnim:SetModel("Interface\\ItemAnimations\\ForcedBackpackItem.mdx")
        CopyDestAchAnim:SetScript("OnAnimFinished", function(self)  self:Hide();  end);
        CopyDestAchAnim:SetPoint("BOTTOMRIGHT", destlistdrop, 5, -14)
        --CopyDestAchAnim:SetWidth(30);  CopyDestAchAnim:SetHeight(30);
      end
      local texture = select(10, GetAchievementInfo(id))
      if (texture) then
      	CopyDestAchAnim:ReplaceIconTexture(texture);
      	CopyDestAchAnim:SetSequence(0);
      	CopyDestAchAnim:SetSequenceTime(0, 0);
      	CopyDestAchAnim:Show();
      end
    end
    return;
  end
  if (add) then
    CurrentWatchList[id] = true
    PlaySound("igMainMenuOptionCheckBoxOn")
  else
    CurrentWatchList[id] = nil
    PlaySound("igMainMenuOptionCheckBoxOff")
  end
  if (frame:IsShown()) then
    Refresh()
  else
    Overachiever.FlashTab(frame.tab)
  end
end

local orig_AchievementButton_OnClick = AchievementButton_OnClick
AchievementButton_OnClick = function(self, ignoreModifiers, ...)
  if (not ignoreModifiers and IsAltKeyDown()) then
    frame.SetAchWatchList(self.id, true)
    return;
  end
  return orig_AchievementButton_OnClick(self, ignoreModifiers, ...)
end



-- SUPPORT MULTIPLE WATCH LISTS
----------------------------------------------------

local function disableListChange()
  listdrop:Disable()
  NewListBtn:Disable()
  DeleteListBtn:Disable()
end

local function enableListChange()
  listdrop:Enable()
  NewListBtn:Enable()
  DeleteListBtn:Enable()
end

local function TjPopupHelper_EditBoxOnEnterPressed(self, ...)
-- Tj: Even if enterClicksFirstButton is 1, OnAccept isn't used when enter is pressed when using an editbox. This
-- function should help prune redundant code (a problem you can see in spades if you examine FrameXML\StaticPopup.lua).
-- To use, set this function to be your popup dialog's EditBoxOnEnterPressed value. Then, use OnAccept as normal.
	local frame = self:GetParent()
	if (frame.button1:IsEnabled() == 0) then  return;  end  -- Don't proceed if the button is disabled.
	local OnAccept = StaticPopupDialogs[frame.which].OnAccept
	local ret = OnAccept(frame, ...)
	frame:Hide()
	return ret
end

StaticPopupDialogs["OVERACHIEVER_WATCH_NEWLIST"] = {
	text = L.WATCH_POPUP_NEWLIST,
	button1 = ACCEPT,
	button2 = CANCEL,
	hasEditBox = 1,
	enterClicksFirstButton = 1,
	OnAccept = function(self)
		local name = strtrim(self.editBox:GetText())
		VARS.WatchLists[name] = {}
		tinsert(listdrop_menu, {  text = name, value = name, tooltipTitle = name, Overachiever_list = VARS.WatchLists[name]  })
		tinsert(deflistdrop_menu, {  text = name, value = name, tooltipTitle = name, Overachiever_list = VARS.WatchLists[name]  })
		listdrop:SetMenu()
		deflistdrop:SetMenu()
		listdrop:SetSelectedValue(name)
	end,
	OnShow = function(self)
		self.button1:Disable();
		self.editBox:SetFocus();
	end,
	OnHide = function(self)
		ChatEdit_FocusActiveWindow();
		self.editBox:SetText("");
	end,
	EditBoxOnEnterPressed = TjPopupHelper_EditBoxOnEnterPressed,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide();
	end,
	EditBoxOnTextChanged = function (self)
		local parent = self:GetParent()
		local name = strtrim(parent.editBox:GetText())
		-- Disallow strings that are empty, have already been used, or start with characters reserved for our character-specific indicator:
		if (name == "" or VARS.WatchLists[name] or strsub(name, 1, 2) == "~^") then
			parent.button1:Disable()
		else
			parent.button1:Enable()
		end
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["OVERACHIEVER_WATCH_DELETELIST"] = {
	text = L.WATCH_POPUP_DELETELIST,
	button1 = YES,
	button2 = NO,
	OnShow = function(self)
		disableListChange()
		-- If using Global or the current character's character-specific list, it cannot be deleted, only cleared:
		if (CurrentWatchList == VARS.WatchLists_General or CurrentWatchList == VARS.WatchLists_Realms[THIS_REALM][THIS_PC]) then
			self.text:SetText(L.WATCH_POPUP_CLEARLIST)
		else
			self.text:SetText(L.WATCH_POPUP_DELETELIST)
		end
	end,
	OnHide = enableListChange,
	OnAccept = function(self)
		-- If using Global or the current character's character-specific list, it cannot be deleted, only cleared:
		if (CurrentWatchList == VARS.WatchLists_General or CurrentWatchList == VARS.WatchLists_Realms[THIS_REALM][THIS_PC]) then
			wipe(CurrentWatchList)
			Refresh()
		else
			local deltab, delval = CurrentWatchList, listdrop:GetSelectedValue()
			if (deflistdrop:GetSelectedValue() == delval) then
				deflistdrop:SetSelectedValue(0)
			end
			if (destlistdrop:GetSelectedValue() == delval) then
				CopyDestCheckbox:SetChecked(false)
				destlistdrop:Disable()
				destlistdrop:SetSelectedValue(0)
			end
			listdrop:SetSelectedValue(VARS.WatchedList == 1 and "~^"..THIS_REALM..":"..THIS_PC or VARS.WatchedList)
			if (strsub(delval, 1, 2) == "~^") then  -- If this is a character-specific list:
				local rname, cname = strsplit(":", delval, 2)
				local realm = strsub(rname, 3)
				-- Remove actual list:
				VARS.WatchLists_Realms[realm][cname] = nil
				-- If there aren't any keys remaining for that realm, remove its table:
				if (next(VARS.WatchLists_Realms[realm]) == nil) then
					VARS.WatchLists_Realms[realm] = nil
				end
				-- Remove menu item for the list:
				for i,tab in ipairs(listdrop_menu) do
					if (tab.value == rname) then  -- Find realm listing with its submenu
						local cnum = 0
						for n,rtab in ipairs(tab.menuList) do  -- Find character in that realm
							if (rtab.value == delval) then
								tremove(tab.menuList, n)
							else
								cnum = cnum + 1
							end
						end
						-- If there aren't any items remaining for that realm, remove the parent item:
						if (cnum == 0) then
							tremove(listdrop_menu, i)
						end
						break;
					end
				end
			else
				-- Remove actual list:
				VARS.WatchLists[delval] = nil
				-- Remove menu item for the list:
				for i,tab in ipairs(listdrop_menu) do
					if (tab.value == delval) then
						tremove(listdrop_menu, i)
						break;
					end
				end
				-- Remove option for setting as default:
				for i,tab in ipairs(deflistdrop_menu) do
					if (tab.value == delval) then
						tremove(deflistdrop_menu, i)
						break;
					end
				end
				deflistdrop:SetMenu()
			end
			listdrop:SetMenu()
		end
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};

listdrop_menu = {  {  text = L.WATCH_LIST_GLOBAL, value = 0, tooltipTitle = L.WATCH_LIST_GLOBAL  },  {  text = THIS_PC, value = "~^"..THIS_REALM..":"..THIS_PC, tooltipTitle = THIS_PC  };  }
listdrop = TjDropDownMenu.CreateDropDown("Overachiever_WatchFrameListDrop", panel, listdrop_menu)
listdrop:SetLabel(L.WATCH_DISPLAYEDLIST, true)
listdrop:SetPoint("TOPLEFT", sortdrop, "BOTTOMLEFT", 0, -18)
listdrop:SetDropDownWidth(158)
listdrop.tooltip = 0

NewListBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
NewListBtn:SetWidth(43); NewListBtn:SetHeight(21)
NewListBtn:SetPoint("TOPLEFT", listdrop, "BOTTOMLEFT", 16, -3)
NewListBtn:SetText(L.WATCH_NEW)
NewListBtn:SetScript("OnClick", function()
  StaticPopup_Show("OVERACHIEVER_WATCH_NEWLIST")
end);

DeleteListBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
DeleteListBtn:SetWidth(51); DeleteListBtn:SetHeight(21)
DeleteListBtn:SetPoint("LEFT", NewListBtn, "RIGHT", 4, 0)
DeleteListBtn:SetText(L.WATCH_DELETE)
DeleteListBtn:SetScript("OnClick", function()
  StaticPopup_Show("OVERACHIEVER_WATCH_DELETELIST")
end);

deflistdrop_menu = {  {  text = L.WATCH_LIST_GLOBAL, value = 0, tooltipTitle = L.WATCH_LIST_GLOBAL  },  {  text = L.WATCH_LIST_PERCHAR, value = 1, tooltipTitle = THIS_PC  };  }
deflistdrop = TjDropDownMenu.CreateDropDown("Overachiever_WatchFrameDefListDrop", panel, deflistdrop_menu)
deflistdrop:SetLabel(L.WATCH_DEFAULTLIST, true)
--deflistdrop:SetPoint("TOPLEFT", listdrop, "BOTTOMLEFT", 0, -18)
deflistdrop:SetPoint("TOPLEFT", NewListBtn, "BOTTOMLEFT", -16, -22)
deflistdrop:SetDropDownWidth(158)
deflistdrop.tooltip = L.WATCH_DEFAULTLIST_TIP

CopyDestCheckbox = CreateFrame("CheckButton", "Overachiever_WatchFrameCopyDestCheckbox", panel, "InterfaceOptionsCheckButtonTemplate")
CopyDestCheckbox:SetPoint("TOPLEFT", deflistdrop, "BOTTOMLEFT", 14, -12)
Overachiever_WatchFrameCopyDestCheckboxText:SetText(L.WATCH_COPY)
CopyDestCheckbox:SetHitRectInsets(0, -1 * min(Overachiever_WatchFrameCopyDestCheckboxText:GetWidth() + 8, 155), 0, 0)
CopyDestCheckbox:SetScript("OnEnter", function(self)
  GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
  GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
  GameTooltip:SetText(L.WATCH_COPY_TIP, nil, nil, nil, nil, 1)
end)
CopyDestCheckbox:SetScript("OnLeave", GameTooltip_Hide)
CopyDestCheckbox:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    PlaySound("igMainMenuOptionCheckBoxOn");
    destlistdrop:Enable()
  else
    PlaySound("igMainMenuOptionCheckBoxOff");
    destlistdrop:Disable()
  end
end);

destlistdrop_menu = {  {  text = L.WATCH_LIST_GLOBAL, value = 0, tooltipTitle = L.WATCH_LIST_GLOBAL  };  }
destlistdrop = TjDropDownMenu.CreateDropDown("Overachiever_WatchFrameDestinationListDrop", panel, destlistdrop_menu)
destlistdrop:SetPoint("TOPLEFT", CopyDestCheckbox, "BOTTOMLEFT", -14, 2)
destlistdrop:SetDropDownWidth(158)
destlistdrop.tooltip = 0
destlistdrop:Disable()

destlistdrop:OnMenuOpen(function(self, menuList)
  wipe(menuList)
  for i,tab in ipairs(listdrop_menu) do
    if (tab.menuList) then
      local sub = {}
      menuList[i] = {  text = tab.text, value = tab.value, hasArrow = true, TjDDM_notCheckable = 1, keepShownOnClick = 1, menuList = sub  }
      for k,v in ipairs(tab.menuList) do
        sub[k] = {  text = v.text, value = v.value, tooltipTitle = v.tooltipTitle, Overachiever_list = v.Overachiever_list  };
      end
    else
      menuList[i] = {  text = tab.text, value = tab.value, tooltipTitle = tab.tooltipTitle, Overachiever_list = tab.Overachiever_list  }
    end
  end
  if (not self:SetMenu()) then
    local val = self:GetSelectedValue() or 0
    if (not self:SetSelectedValue(val)) then
      self:SetSelectedValue(0)
    end
  end
end);


function listdrop_OnSelect(self, value, oldvalue, tab)
  CurrentWatchList = tab.Overachiever_list
  -- If using Global or the current character's character-specific list, it cannot be deleted, only cleared:
  if (CurrentWatchList == VARS.WatchLists_General or CurrentWatchList == VARS.WatchLists_Realms[THIS_REALM][THIS_PC]) then
    DeleteListBtn:SetText(L.WATCH_CLEAR)
  else
    DeleteListBtn:SetText(L.WATCH_DELETE)
  end
  Refresh()
end

function deflistdrop_OnSelect(self, value)
  VARS.WatchedList = value
end

function destlistdrop_OnSelect(self, value, oldvalue, tab)
  DestinationWatchList = tab.Overachiever_list
end

-- A trick to get default-UI-style tooltip like the function AchievementFrameCategory_StatusBarTooltip() displays:
hooksecurefunc("GameTooltip_AddNewbieTip", function(self, text, ...)
  if (not self.arg1 or not self.arg1.Overachiever_list) then  return;  end
  GameTooltip:Hide()

  local numAchievements, numCompleted, _, completed = 0, 0
  for id in pairs(self.arg1.Overachiever_list) do
    _, _, _, completed = GetAchievementInfo(id)
    if (completed) then  numCompleted = numCompleted + 1;  end
    numAchievements = numAchievements + 1
  end
  local numCompletedText = numAchievements > 0 and numCompleted.."/"..numAchievements or L.WATCH_EMPTY_SHORT

  -- Based on AchievementFrameCategory_StatusBarTooltip():
  --GameTooltip_SetDefaultAnchor(GameTooltip, self);
  GameTooltip:SetOwner(self, "ANCHOR_NONE")
  GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 10, 9)
  GameTooltip:SetMinimumWidth(128, 1);
  GameTooltip:SetText(text, 1, 1, 1, nil, 1);
  GameTooltip_ShowStatusBar(GameTooltip, 0, numAchievements, numCompleted, numCompletedText);
  GameTooltip:Show();
end);

frame:SetScript("OnEvent", function()  -- React to "PLAYER_LOGOUT" event:
  -- Remove unused character-specific watch lists:
  local cnum
  for realm,rtab in pairs(VARS.WatchLists_Realms) do
    cnum = 0
    for char,ctab in pairs (rtab) do
      if (next(ctab) == nil) then  -- If there aren't any keys in the table, remove it.
        rtab[char] = nil
      else
        cnum = cnum + 1
      end
    end
    if (cnum == 0) then  VARS.WatchLists_Realms[realm] = nil;  end
  end
end);


--[[
-- /run Overachiever.Debug_DumpWatch()
function Overachiever.Debug_DumpWatch()
  local tab = {}
  for id in pairs(CurrentWatchList) do
    tab[#tab+1] = id
  end
  sort(tab)
  local s = "{ "..strjoin(", ", unpack(tab)).." }"
  print(s)
  error(s)
end
--]]
