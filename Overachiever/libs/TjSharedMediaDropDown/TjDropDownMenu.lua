
--
--  TjDropDownMenu.lua
--    by Tuhljin
--
--  Alternative drop down menu system. A simple way to implement dropdown menus where one and only one thing should
--  be checked. Supports nested menus as well (but again, only one thing can be checked across the entire menu).
--
--  Since version 0.51, TjDropDownMenu registers itself with the TjOptions library. See "Use with TjOptions" below.
--
--  Not all features are documented at this time. Basic API is as follows.
--
--  dropdown = TjDropDownMenu.CreateDropDown(name, parent, menuList[, x, y[, displayMode, [autoHideDelay[,
--                                           EasyMenuSubFunc]]]])
--    Creates a new dropdown component, returning the primary frame of this component.
--    Arguments:
--      name             String or nil. The global name to be used for the new primary frame. If nil, TjDDM will use
--                       an automatically generated name (since the frame cannot be anonymous).
--      parent           Frame. The parent for the new dropdown frame.
--      menuList         Table. This should use the same format as the menuList table that might be given to the
--                       EasyMenu function. See http://www.wowwiki.com/API_EasyMenu. Additional TjDDM-specific notes
--                       about this table are given in the next section.
--      x, y             Integer or nil. The x and y offsets used to adjust the placement of the dropdown menu when
--                       the dropdown button is clicked. TjDDM automatically places the menu in a location deemed
--                       suitable for most situations, so leaving these as nil or setting them to 0 uses that
--                       location while other numbers adjust the offset from there.
--      displayMode      The display mode, either nil or the string "MENU".
--      autoHideDelay    Number or nil. Purportedly used to tell popup menus to automatically hide after this many
--                       seconds. However, it is currently unused by the EasyMenu system TjDDM normally relies on.
--      EasyMenuSubFunc  Function or nil. The function to use in order to display the popup menu. If omitted, as
--                       should usually be the case, EasyMenu is used. This argument exists in order to support
--                       EasyMenu wrapper systems, such as that provided by WorldMap_StaticPopup.lua (a library by
--                       Tuhljin, currently packaged with the addon Intel).
--
--  In the following, the dropdown variable is the primary frame as returned by TjDropDownMenu.CreateDropDown().
--
--  Tooltip use: TjDDM normally uses the currently selected entry's tooltip, if it has one, when the cursor is over
--  the dropdown frame. Set your dropdown's .tooltip (and optionally .tooltip2) properties to a string to display a
--  specific tooltip on mouseover. Set .tooltip to 0 to show no tooltip. If .tooltip is a function, it is called
--  after the tooltip's owner is set and is ready to have text added to it. The item's frame is passed as the first
--  argument and the tooltip object is passed as the second argument. Your function doesn't need to show the tooltip
--  ("GameTooltip:Show()") since that will be done for you by TjDDM.
--
--  dropdown:OnSelect(OnSelectFunc)
--    Assign a function to be called when the dropdown's currently selected value changes. When called, the function
--    is passed four arguments, in this order:
--      dropdown     Frame. The primary dropdown frame.
--      value        Any. The new selected value.
--      oldvalue     Any. The previous value.
--      tab          Table. The portion of the menuList table associated with the selection. For example:
--                   { text = "Option A", tooltipTitle = "Option A", tooltipText = "Use option A", value = 1 }
--
--  dropdown:OnMenuOpen(OnMenuOpenFunc)
--    Assign a function to be called when the dropdown's menu is about to be displayed (such as when the dropdown
--    button is clicked). This can be useful for editing the menu on demand. When called, the function is passed two
--    arguments:
--      dropdown     Frame. The primary dropdown frame.
--      menuList     Table. The menu currently assigned to this dropdown.
--
--  dropdown:SetLabel(text, font)
--    Creates a label above the dropdown, if it doesn't already exist, and sets its text to that given. If the label
--    didn't exist, then font is used to determine which game font to use: If it's a string, that is the font used;
--    if font is true, then "GameFontHighlight" is used; otherwise, "GameFontNormal" is used.
--
--  dropdown:SetSelectedValue(value[, checkNoAutoSetupEntries])
--    Sets the dropdown menu's currently selected value. This should be the value from one of the entries in the
--    dropdown's menuList. The dropdown's text is automatically updated. If checkNoAutoSetupEntries is true, then
--    entries in the table that were excluded from TjDDM's automatic setup method (those that use the NO_TjDDM_Setup
--    field) can be selected. Returns true if an entry with the given value was found and selected.
--
--  dropdown:Disable()
--    Disables the dropdown menu, graying-out the selection text and label (if any) and disabling the dropdown
--    button.
--
--  dropdown:Enable()
--    Enables the dropdown menu, reversing changes made through a dropdown:Disable() call.
--
--  dropdown:IsEnabled()
--    Returns true if the dropdown is enabled, as related to the dropdown:Enable() or dropdown:Disable() methods.
--
--  dropdown:OpenMenu()
--    Display the dropdown's menu, as if the dropdown button was clicked. Can be called even if the dropdown is
--    disabled. Note that the menu will be closed instead if it is already open.
--
--  dropdown:SetOffset(x, y)
--    Set the offset to be used when displaying the menu, as per the x and y arguments of
--    TjDropDownMenu.CreateDropDown().
--
--  dropdown:SetAutoHideDelay(autoHideDelay)
--    Set the dropdown's autoHideDelay as per the argument to TjDropDownMenu.CreateDropDown().
--
--  dropdown:SetDropDownWidth(width)
--    Set the width of the dropdown's selection-display area to the given integer. This doesn't change the width of
--    the other frames associated with the dropdown.
--
--  dropdown:SetText(text)
--    Set the text of the selection-display area. Note that this text is normally automatically set to the text
--    associated with the currently selected value.
--
--  dropdown:GetOffset(), dropdown:GetAutoHideDelay(), dropdown:GetDropDownWidth(), dropdown:GetText(),
--  dropdown:GetSelectedValue()
--    These functions return the dropdown's current offset (x, y), autoHideDelay, selection-display area width,
--    selection text, and selected value, respectively.
--
--  dropdown:SetMenu([menuList[, doSetup]])
--    Changes the menuList used by the dropdown. Returns true if the new menu has a valid selected entry. (If not,
--    you may want to make a SetSelectedValue call after the SetMenu call.) This function is useful not only for
--    switching between static menus but also for allowing menus to be edited dynamically. (Dynamically edited menus
--    menus may not work as expected otherwise.) To use for this purpose, call the function immediately after edits
--    are complete. If the edited menu is the current menu used by the dropdown, pass no arguments; if the menu is
--    not currently used by the dropdown but now should be, pass the menuList table for the first argument and use
--    true as the second argument. This causes TjDDM to go over the menuList to set it up for use. (If making
--    multiple changes to the menu at once, try to call SetMenu after the last change has been made.)
--
--  Additional notes about menuList tables
--  --------------------------------------
--
--  Be sure that all checkable entries have a "value" property that is unique for that menu (including submenus). If
--  no value is given, TjDDM will assign one, but authors will generally find it more useful to use preset values.
--
--  Use "NO_TjDDM_Setup = 1" (w/o quotes) in menu table entries to prevent that entry from being touched even if you
--  want other parts of the table automatically altered.
--
--  There are a few problems with using the menu properties notClickable and notCheckable (not due to TjDDM, but in
--  general), so an alternative for those items you don't want to be checked is presented: TjDDM_notCheckable. (Set
--  to 1 in the menu table entry to use.) It can be used as you see fit, but the primary intent was for it to be
--  paired with keepShownOnClick for those entries that hold a sub-menu via the menuList property.
--
--  Use with TjOptions
--  ------------------
--
--  TjDropDownMenu automatically registers the item type "dropdown" with the TjOptions library. Version 0.32 or
--  later is required. Make sure that TjOptions.lua is included in your TOC or XML file BEFORE TjDropDownMenu.lua.
--
--  Item Fields - dropdown:
--    Three additional fields are available for dropdown menu items. The menu field is required.
--    menu          Table. Used as the third argument in TjDropDownMenu.CreateDropDown().
--    width         Integer. The width of the primary portion of the dropdown frame.
--    displayMode   String. The display mode of the dropdown menu. Usually left nil or set to "MENU" (w/o quotes).
--
--  If you use the tooltip item fields, they will be used instead of those found in the menu when the cursor is over
--  the dropdown frame. Set tooltip to 0 show no tooltip. (The menu table's fields will still be used for the
--  dropped-down list itself.)
--
--


local THIS_VERSION = 0.55

if (not TjDropDownMenu or TjDropDownMenu.Version < THIS_VERSION) then
  TjDropDownMenu = TjDropDownMenu or {};
  TjDropDownMenu.Version = THIS_VERSION;

  local xOffset, yOffset = 9, 7             -- Base offset (where offset of 0, 0 would put the menu frame).
  local xOffset_MENU, yOffset_MENU = 17, 5  -- Base offset for displayMode "MENU"
  local generateNewMenuFrameForAll = nil;   -- Set to true to generate a new menuFrame object for every dropdown.
     -- Otherwise, those of the same displayMode are shared. This is a static option, to be set here in the Lua only
     -- (not meant to be changed dynamically).
  
  local TEXTCUTOFF = 10   -- How much of the dropdown Middle frame's width to reduce from the display text's width.

  local menuFrameList
  if (not generateNewMenuFrameForAll) then
    menuFrameList = {};
  end

  TjDropDownMenu.NumCreated = TjDropDownMenu.NumCreated or 0
  local hooksComplete, TjMenuOpen, prevTjMenuOpen, clickedButton;

  local function SelectEntry(dropdown, tab, fromClick)
    tab.checked = 1
    local oldvalue = dropdown.TjDDM.selectedValue
    dropdown.TjDDM.selectedValue = tab.value
    dropdown:SetText(tab.text)

    local callFunc = dropdown.TjDDM.OnSelectFunc
    if (type(callFunc) == "function") then
      if (not fromClick) then  dropdown.TjDDM.thisOnChange_noUser = true; end
      callFunc(dropdown, tab.value, oldvalue, tab);
      dropdown.TjDDM.thisOnChange_noUser = nil
    end
  end


-- AUTOMATIC FUNCTION SETUP FOR MENU ITEMS
----------------------------------------------

  local function RefreshMenu(frame, useValue, dropdownLevel)
    assert(frame, "RefreshMenu: frame not found")
  -- Largely taken from UIDropDownMenu_Refresh in UIDropDownMenu.lua, which didn't do things quite right for us.
  -- Comments in this function taken from there as well, except those starting with "TjDDM."
    local button, checked, checkImage, normalText, width;
    local maxWidth = 0;
    if ( not dropdownLevel ) then
      dropdownLevel = UIDROPDOWNMENU_MENU_LEVEL;
    end

    -- Just redraws the existing menu
    for i=1, UIDROPDOWNMENU_MAXBUTTONS do
      button = _G["DropDownList"..dropdownLevel.."Button"..i];
      checked = nil;
      -- See if checked or not
      -- TjDDM: This is what we changed: It now properly knows what is checked (that is, what was just clicked).
      if ( button == clickedButton ) then
          checked = 1;
      end

      -- If checked show check image
      checkImage = _G["DropDownList"..dropdownLevel.."Button"..i.."Check"];
      if ( checked ) then
        if ( useValue ) then
          UIDropDownMenu_SetText(frame, button.value);
        else
          UIDropDownMenu_SetText(frame, button:GetText());
        end
        button:LockHighlight();
        checkImage:Show();
      else
        button:UnlockHighlight();
        checkImage:Hide();
      end

      if ( button:IsShown() ) then
        normalText = _G[button:GetName().."NormalText"];
        -- Determine the maximum width of a button
        width = normalText:GetWidth() + 40;
        -- Add padding if has and expand arrow or color swatch
        if ( button.hasArrow or button.hasColorSwatch ) then
          width = width + 10;
        end
        if ( button.notCheckable ) then
          width = width - 30;
        end
        if ( width > maxWidth ) then
          maxWidth = width;
        end
      end
    end
    for i=1, UIDROPDOWNMENU_MAXBUTTONS do
      button = _G["DropDownList"..dropdownLevel.."Button"..i];
      button:SetWidth(maxWidth);
    end
    _G["DropDownList"..dropdownLevel]:SetWidth(maxWidth+15);

    -- TjDDM: Added the following to recursively refresh lower levels.
    if (dropdownLevel > 1) then
      RefreshMenu(frame, useValue, dropdownLevel - 1);
    end
  end

  local function ClearChecks(menuList, includeChildren)
    for _, tab in ipairs(menuList) do
      if (type(tab) == "table" and not tab.NO_TjDDM_Setup) then
        tab.checked = nil
        if (includeChildren and type(tab.menuList) == "table") then
          ClearChecks(tab.menuList, true)
        end
      end
    end
  end

  local function menuItemClick(self, tab, _, checked)
    local prevchecked = checked
    local dropdown
    if (TjMenuOpen) then
      dropdown = _G[TjMenuOpen]
    else
      dropdown = _G[prevTjMenuOpen]
    end

    if (tab.TjDDM_notCheckable) then
      checked = nil;
      tab.checked = nil;
      _G[clickedButton:GetName().."Check"]:Hide();
    elseif (not checked or tab.keepShownOnClick) then
    -- Overrides default keepShownOnClick functionality, which toggles between checked and unchecked.
      ClearChecks(dropdown.TjDDM.menuList, true)
      checked = 1
      SelectEntry(dropdown, tab, true)
    end

    if (TjMenuOpen and not tab.keepShownOnClick) then
    -- If the menu is still open even though this entry should close its part of the menu, it must have been in
    -- a submenu, so close the rest of it.
      CloseMenus()
    end

    if (TjMenuOpen and not tab.TjDDM_notCheckable) then
      local menuFrame;
      if (generateNewMenuFrameForAll) then
        menuFrame = dropdown.TjDDM.menuFrame;
      else
        menuFrame = menuFrameList[dropdown.TjDDM.menuFrameType];
      end
      RefreshMenu(menuFrame)
    end

    local prevfunc = tab.TjDDM.prevfunc
    if (type(prevfunc) == "function") then
      -- Note that we pass the possibly-altered checked as the 3rd arg and the original value for it as the 4th.
      prevfunc(tab.TjDDM.prevarg1, tab.TjDDM.prevarg2, checked, prevchecked)
    end
  end

  local function SetupFunctions(dropdown, menuList, valueNum, foundchecked)
    valueNum = valueNum or 0
    for _, tab in ipairs(menuList) do
      if (type(tab) == "table" and not tab.NO_TjDDM_Setup) then
        if (not tab.TjDDM and not tab.isTitle and not tab.notClickable) then
          tab.TjDDM = {};
          tab.TjDDM.prevfunc = tab.func;
          tab.TjDDM.prevarg1 = tab.arg1;
          tab.TjDDM.prevarg2 = tab.arg2;
          tab.func = menuItemClick;
          tab.arg1 = tab;
          tab.arg2 = nil;

          if (foundchecked) then
            tab.checked = nil;
          elseif (tab.checked) then
            foundchecked = true  -- Found an entry already set as checked (not the default set below)
            dropdown.TjDDM.selectedValue = tab.value;
            dropdown:SetText(tab.text)
          end

          valueNum = valueNum + 1;
          if (tab.value == nil) then
            tab.value = "*TjDDM autovalue* "..valueNum
          end

          -- Find first valid entry for default selected value:
          if (not dropdown.TjDDM.selectedValue and not tab.TjDDM_notCheckable) then
            dropdown.TjDDM.selectedValue = tab.value;
            dropdown:SetText(tab.text)
            tab.checked = 1;
          end
        end
        -- Iterate over child menus:
        if (type(tab.menuList) == "table") then
          SetupFunctions(dropdown, tab.menuList, valueNum, foundchecked)
        end
      end
    end
  end


-- OTHER FUNCTIONS
----------------------------------------------

  local function findEntryByValue(menuList, value, checkNoAutoSetupEntries)
    for _, tab in ipairs(menuList) do
      if ( type(tab) == "table" and (checkNoAutoSetupEntries or not tab.NO_TjDDM_Setup) ) then
        if (tab.value == value) then
          return tab;
        end
        if (type(tab.menuList) == "table") then
          local tab2 = findEntryByValue(tab.menuList, value, checkNoAutoSetupEntries)
          if (tab2) then  -- If recursive call found the entry, return it.
            return tab2;
          end
        end
      end
    end
  end

  local function findSelectedEntry(menuList, checkNoAutoSetupEntries)
    local tab2
    for _, tab in ipairs(menuList) do
      if ( type(tab) == "table" and (checkNoAutoSetupEntries or not tab.NO_TjDDM_Setup) ) then
        if (tab.checked) then
          return tab;
        end
        if (type(tab.menuList) == "table") then
          tab2 = findSelectedEntry(tab.menuList, checkNoAutoSetupEntries)
          if (tab2) then  -- If recursive call found the entry, return it.
            return tab2;
          end
        end
      end
    end
  end

  local function MenuHidden()
    prevTjMenuOpen = TjMenuOpen;
    TjMenuOpen = nil;
  end

  local orig_UIDropDownMenuButton_OnClick;
  local function hooked_UIDropDownMenuButton_OnClick(self, ...)
    if (TjMenuOpen) then
      clickedButton = self;
    else
      clickedButton = nil;
    end
    orig_UIDropDownMenuButton_OnClick(self, ...)
  end

  local function isSetupComplete(menuList)
    -- Examine the menuList to see if any of its entries have a TjDDM sub-entry, which indicates SetupFunctions
    -- has run on this menuList.
    for i,tab in ipairs(menuList) do
      if (type(tab) == "table") then
        if (tab.TjDDM) then  return true;  end
        -- Iterate over child menus:
        if (type(tab.menuList) == "table") then
          local check = isSetupComplete(tab.menuList)
          if (check) then  return true;  end
        end
      end
    end
  end


  local function SetOffset(frame, x, y)
    frame.TjDDM.x = x;
    frame.TjDDM.y = y;
  end

  local function GetOffset(frame)
    return frame.TjDDM.x, frame.TjDDM.y;
  end

  local function SetAutoHideDelay(frame, delay)
    frame.TjDDM.autoHideDelay = delay;
  end

  local function GetAutoHideDelay(frame)
    return frame.TjDDM.autoHideDelay;
  end

  local function SetDropDownWidth(frame, width)
    _G[frame:GetName().."Middle"]:SetWidth(width)
    _G[frame:GetName().."Text"]:SetWidth(width - TEXTCUTOFF)
    frame:SetWidth(width+8)
  end

  local function GetDropDownWidth(frame, ...)
    return _G[frame:GetName().."Middle"]:GetWidth()
  end

  local function SetText(frame, ...)
    _G[frame:GetName().."Text"]:SetText(...)
  end

  local function GetText(frame)
    return _G[frame:GetName().."Text"]:GetText()
  end

  local function GetSelectedValue(frame)
    return frame.TjDDM.selectedValue;
  end

  local function SetSelectedValue(frame, value, checkNoAutoSetupEntries)
  -- Set third arg to true to include entries with NO_TjDDM_Setup properties.
    local tab = findEntryByValue(frame.TjDDM.menuList, value, checkNoAutoSetupEntries);
    if (tab) then
      ClearChecks(frame.TjDDM.menuList, true)
      SelectEntry(frame, tab)
      return true
    end
  end

  local function SetLabel(frame, text, font)
    if (type(text) ~= "string") then
      error("SetLabel(): Invalid argument. Expected string. Got "..type(text)..".")
    end
    if (not frame.TjDDM.label) then
      font = type(font) == "string" and font or font and "GameFontHighlight" or "GameFontNormal"
      frame.TjDDM.label = frame:CreateFontString(frame:GetName().."Label", "ARTWORK", font);
      frame.TjDDM.label:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 16, 3);
      frame.TjDDM.label_font = font
    end
    frame.TjDDM.label:SetText(text);
  end

  local function OnSelect(frame, func)
    frame.TjDDM.OnSelectFunc = func;
  end
  
  local function OnMenuOpen(frame, func)
    frame.TjDDM.OnMenuOpenFunc = func;
  end

  local function SetMenu(dropdown, menuList, doSetup)
    if (menuList) then  dropdown.TjDDM.menuList = menuList;  end
    if (not menuList or doSetup or not isSetupComplete(dropdown.TjDDM.menuList)) then
      SetupFunctions(dropdown, dropdown.TjDDM.menuList)
    end
    local tab = findSelectedEntry(dropdown.TjDDM.menuList)
    if (tab) then
      ClearChecks(dropdown.TjDDM.menuList, true)
      SelectEntry(dropdown, tab)
      return true
    end
  end

  local function Enable(frame)
    local name = frame:GetName()
    _G[name.."Button"]:Enable()
    _G[name.."Text"]:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
    if (frame.TjDDM.label) then
      if (frame.TjDDM.label_font == "GameFontHighlight") then
        frame.TjDDM.label:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
      else
        frame.TjDDM.label:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
      end
    end
    frame.TjDDM.enabled = true
  end

  local function Disable(frame)
    local name = frame:GetName()
    _G[name.."Button"]:Disable()
    local r, g, b = GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b
    _G[name.."Text"]:SetVertexColor(r, g, b) -- :SetTextColor(r, g, b)
    if (frame.TjDDM.label) then
      frame.TjDDM.label:SetVertexColor(r, g, b) -- :SetTextColor(r, g, b)
    end
    frame.TjDDM.enabled = nil
    if (TjMenuOpen == name) then
      CloseMenus()
    end
  end

  local function IsEnabled(frame)
    return frame.TjDDM.enabled;
  end


  local function OnEnter(self)
    if (self.tooltip) then
      local tip = self.tooltip
      if (tip ~= 0) then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
        GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b);
        if (type(tip) == "string") then
          GameTooltip:AddLine(tip, nil, nil, nil, 1);
          if (self.tooltip2) then
            GameTooltip:AddLine(self.tooltip2, nil, nil, nil, 1)
          end
        elseif (type(tip) == "function") then
          tip(self, GameTooltip)
        end
        GameTooltip:Show()
      end
    else
      local tab = findEntryByValue(self.TjDDM.menuList, self.TjDDM.selectedValue, true);  -- Get current selected entry's table
      if (tab.tooltipTitle) then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
        GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b);
        GameTooltip:SetText(tab.tooltipTitle, 1, 1, 1)
        if (tab.tooltipText) then
          GameTooltip:AddLine(tab.tooltipText, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
          GameTooltip:Show()
        end
      end
    end
  end

  local function OnLeave()
    GameTooltip:Hide()
  end

  local function OpenMenu(dropdown)
    if (not TjMenuOpen or TjMenuOpen ~= dropdown:GetName()) then
      local callFunc = dropdown.TjDDM.OnMenuOpenFunc
      if (type(callFunc) == "function") then
        callFunc(dropdown, dropdown.TjDDM.menuList);
      end

      local menuFrame;
      if (generateNewMenuFrameForAll) then
        menuFrame = dropdown.TjDDM.menuFrame;
      else
        menuFrame = menuFrameList[dropdown.TjDDM.menuFrameType];
      end

      local x, y = dropdown.TjDDM.x or 0, dropdown.TjDDM.y or 0;
      if (dropdown.TjDDM.displayMode == "MENU") then
        x, y = x + xOffset_MENU, y + yOffset_MENU
      else
        x, y = x + xOffset, y + yOffset
      end

      if (not hooksComplete) then
        DropDownList1:HookScript("OnHide", MenuHidden);
        orig_UIDropDownMenuButton_OnClick = UIDropDownMenuButton_OnClick;
        UIDropDownMenuButton_OnClick = hooked_UIDropDownMenuButton_OnClick;
        hooksComplete = true
      end

      local menuFunc = dropdown.TjDDM.EasyMenuSubFunc or EasyMenu;
      -- If using another function, it should take the same arguments as EasyMenu does or problems may occur.

      menuFunc(dropdown.TjDDM.menuList, menuFrame, dropdown, x, y, dropdown.TjDDM.displayMode, dropdown.TjDDM.autoHideDelay);
      -- arg order: menuList, menuFrame, anchor, x, y, displayMode, autoHideDelay
      TjMenuOpen = dropdown:GetName();   -- Do this after menuFunc or it will be set to nil by MenuHidden().
    else
      CloseMenus()
    end
  end


-- API
---------

  function TjDropDownMenu.DropBtnOnClick(self)
    PlaySound("igMainMenuOptionCheckBoxOn");
    self:GetParent():OpenMenu();
  end

  function TjDropDownMenu.CreateDropDown(name, parent, menuList, x, y, displayMode, autoHideDelay, EasyMenuSubFunc)
  -- Note that autoHideDelay is currently unused by EasyMenu, though it lists it as an argument.
  -- Perhaps a use for it will be implemented in the future.
    if (name ~= nil and type(name) ~= "string") then
      error("TjDropDownMenu.CreateDropDown(): Argument 1 invalid (name). Expected string or nil. Got "..type(name)..".")
    elseif (type(menuList) ~= "table") then
      error("TjDropDownMenu.CreateDropDown(): Argument 3 invalid (menuList). Expected table. Got "..type(type)..".")
    end

    TjDropDownMenu.NumCreated = TjDropDownMenu.NumCreated + 1;
    name = name or "TjDropDownMenu_Num"..TjDropDownMenu.NumCreated
    local dropdown = CreateFrame("Frame", name, parent, "UIDropDownMenuTemplate")
    dropdown.TjDDM = {};
    dropdown.TjDDM.menuList = menuList;
    dropdown.TjDDM.x = x;
    dropdown.TjDDM.y = y;
    dropdown.TjDDM.displayMode = displayMode;
    dropdown.TjDDM.autoHideDelay = autoHideDelay;
    dropdown.TjDDM.EasyMenuSubFunc = EasyMenuSubFunc;
    dropdown.TjDDM.enabled = true

    if (generateNewMenuFrameForAll) then
      dropdown.TjDDM.menuFrame = CreateFrame("Frame", name.."_TjDropDownMenuFrame", parent, "UIDropDownMenuTemplate")
    else
      displayMode = displayMode or 0
      dropdown.TjDDM.menuFrameType = displayMode
      if (not menuFrameList[displayMode]) then
        menuFrameList[displayMode] = CreateFrame("Frame", "TjDropDownMenu_SharedMenuFrame_"..displayMode, parent, "UIDropDownMenuTemplate")
      end
    end

    _G[name.."Button"]:SetScript("OnClick", TjDropDownMenu.DropBtnOnClick)
    dropdown:SetScript("OnEnter", OnEnter)
    dropdown:SetScript("OnLeave", OnLeave)
    dropdown:EnableMouse(true)

    -- Set functions to call in this style: MyDropDownFrame:FunctionName(...)
    dropdown.SetOffset = SetOffset;
    dropdown.GetOffset = GetOffset;
    dropdown.SetAutoHideDelay = SetAutoHideDelay;
    dropdown.GetAutoHideDelay = GetAutoHideDelay;
    dropdown.SetDropDownWidth = SetDropDownWidth;
    dropdown.GetDropDownWidth = GetDropDownWidth;
    dropdown.SetText = SetText;
    dropdown.GetText = GetText;
    dropdown.GetSelectedValue = GetSelectedValue;
    dropdown.SetSelectedValue = SetSelectedValue;
    dropdown.OnSelect = OnSelect;
    dropdown.OnMenuOpen = OnMenuOpen;
    dropdown.SetLabel = SetLabel;
    dropdown.SetMenu = SetMenu;
    dropdown.Enable = Enable;
    dropdown.Disable = Disable;
    dropdown.IsEnabled = IsEnabled;
    dropdown.OpenMenu = OpenMenu;
    
    _G[name.."Text"]:SetWidth( _G[name.."Middle"]:GetWidth() - TEXTCUTOFF )

    SetupFunctions(dropdown, dropdown.TjDDM.menuList)

    return dropdown;
  end


-- Register with TjOptions
-----------------------------

  if (TjOptions and TjOptions.Version >= 0.32) then
    local function DropdownOnSelect(self, val, oldval)
      if (val ~= oldval) then
        if (self.TjDDM.thisOnChange_noUser) then  -- If the last change wasn't triggered by the player
          TjOptions.ItemChanged(true, self, val);
        else
          TjOptions.ItemChanged(self, val);
        end
      end
    end

    local function SetDropDownVal(self, val)
      if (self:GetSelectedValue() ~= val) then
        self:SetSelectedValue(val)
      end
    end

    local function CreateDropDownItem(name, parent, data)
      assert(data.menu, "Required item field missing: menu.");
      local obj = TjDropDownMenu.CreateDropDown(name, parent, data.menu, nil, nil, data.displayMode, 5);
      obj:SetDropDownWidth(data.width or 85)
      obj:OnSelect(DropdownOnSelect)
      obj.tooltip, obj.tooltip2 = data.tooltip, data.tooltip2
      local offy = -4
      if (data.text) then
        obj:SetLabel(data.text)
        offy = -17
      end
      return obj, nil, -13, offy;
    end

    TjOptions.RegisterItemType("dropdown", THIS_VERSION,
      { create = CreateDropDownItem, getvalue = GetSelectedValue, setvalue = SetDropDownVal })
  end


end
