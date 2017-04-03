
--
--  TjOptions.lua
--    by Tuhljin
--
--  Library for easy creation and management of Interface Options panels. TjOptions provides built-in support for a
--  few variations on some basic item types (checkboxes, labels) and an extensible, modular system for supporting
--  other items.
--
--  See TjOptions.txt for documentation.
--

local THIS_VERSION = 0.41

if (not TjOptions or TjOptions.Version < THIS_VERSION) then
  TjOptions = TjOptions or {};
  local TjOptions = TjOptions
  local oldver = TjOptions.Version or 0
  TjOptions.Version = THIS_VERSION;

  local type = type

  TjOptions.Panels = TjOptions.Panels or {}
  local Panels = TjOptions.Panels;
  TjOptions.numItems, TjOptions.numScrollFrames = TjOptions.numItems or 0, TjOptions.numScrollFrames or 0
  TjOptions.itemFuncs = TjOptions.itemFuncs or {}
  local itemFuncs = TjOptions.itemFuncs;
  TjOptions.itemRev = TjOptions.itemRev or {}
  local itemRev = TjOptions.itemRev
  TjOptions.itemAlias = TjOptions.itemAlias or {}
  local itemAlias = TjOptions.itemAlias
  
  if (oldver < 0.33) then
    TjOptions.itemMeta = {
      __index = function(self, key)  return rawget(self, itemAlias[key]);  end,
    }
    setmetatable(itemFuncs, TjOptions.itemMeta)
    setmetatable(itemRev, TjOptions.itemMeta)
  end

  local ItemGlobalName = "TjOptionsItemNumber"  -- Used to give unique global names to items that don't specify one.
  local ScrollFrameGlobalName = "TjOptionsScrollFrame"
  local defaultSound = "igCharacterInfoTab";

  local errorlog
  local function panelerror(panel, text, multishow)
    errorlog = errorlog or {}
    local id = panel.name..":"..text
    if (multishow or not errorlog[id]) then  -- Some errors shown only once per session.
      errorlog[id] = 1
      print('|cffff1919Error in TjOptions panel "'..panel.name..'":', text)
    end
  end

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

  local function copyvars(panel, tab, reverse)
    local from = reverse and tab or panel.TjOpt_tab.variables
    local to = not reverse and tab or panel.TjOpt_tab.variables
    local v, f
    for i,item in ipairs(panel.TjOpt_tab.items) do
      v = item.variable
      if (v) then
        f = from[v]
        if (type(f) == "table") then
          to[v] = type(to[v]) == "table" and wipe(to[v]) or {}
          copytab(f, to[v])
        else
          to[v] = f
        end
      end
    end
  end

  local BuiltItemsList
  local function getBuiltItemsList(itemType)
    BuiltItemsList = BuiltItemsList or {}
    if (not BuiltItemsList[itemType]) then
      local list, obj = {}
      for n,panel in pairs(Panels) do
        if (panel.TjOpt_built) then
          for i,item in ipairs(panel.TjOpt_tab.items) do
            if (item.type == itemType) then
              obj = _G[ item.name ]
              if (obj) then  list[#(list)+1] = obj;  end
            end
          end
        end
      end
      BuiltItemsList[itemType] = list
    end
    return BuiltItemsList[itemType];
  end

  local function GetPanel(obj)
    local panel = obj:GetParent()
    -- If scrolling frame is used, the main panel frame is a few levels up from the object:
    if (panel.TjOpt_isScrollChild) then  return panel:GetParent():GetParent();  end
    return panel;
  end

  local function GetItems(panel)
    if (panel.TjOpt_scrollchild) then  return panel.TjOpt_scrollchild:GetChildren();  end
    return panel:GetChildren();
  end


-- ITEM FUNCTIONS TABLE CALLS
--------------------------------

  local function itemCall_recursive_get(itemType, key, maxdepth, count)
  -- Go back through inheritance until key is found, line of inheritance ends, or maxdepth is reached.
    count = (count or 0) + 1
    if (maxdepth and count > maxdepth) then  return;  end
    if (count > 99) then
      error("Too many calls to itemCall_recursive_get. Inheritance loop likely. Stopped at ("..strjoin(", ",tostringall(itemType, key, maxdepth, count))..").")
    end
    local tab = itemFuncs[itemType]
    local v = tab[key]
    if (v ~= nil) then  return v, count;  end
    if (tab.inherit) then  return itemCall_recursive_get(tab.inherit, key, maxdepth, count);  end
  end

  local function numargs(num, arg1, arg2, arg3, arg4)
    if (num < 1) then
      return; -- Not a return of nil, but a return of nothing. There is a difference.
    elseif (num == 1) then
      return arg1
    elseif (num == 2) then
      return arg1, arg2
    elseif (num == 3) then
      return arg1, arg2, arg3
    else
      return arg1, arg2, arg3, arg4
    end
  end

  local function itemCall_handlehooks(depth, itemType, fname, func, lastargsub, lastarg, ...)
    local tab = itemFuncs[itemType]
    local npre, npost = fname.."_prehook", fname.."_posthook"
    local prehook, posthook = tab[npre], tab[npost]
    if (tab.inherit and depth > 0) then
      prehook = prehook or itemCall_recursive_get(tab.inherit, npre, depth)
      posthook = posthook or itemCall_recursive_get(tab.inherit, npost, depth)
    end

    local num = select("#", ...)
    local arg1, arg2, arg3, arg4 = ...
    if (lastargsub) then
      if (num == 1) then
        arg1 = lastarg;
      elseif (num == 2) then
        arg2 = lastarg;
      elseif (num == 3) then
        arg3 = lastarg;
      elseif (num == 4) then
        arg4 = lastarg;
      end
    end

    if (prehook) then
      local cont, ret1, ret2, ret3, ret4 = prehook( numargs(num, arg1, arg2, arg3, arg4) )
      if (cont == false) then  -- prehook says not to continue
        return;
      elseif (cont == true) then  -- prehook says to use substituted arguments
        arg1, arg2, arg3, arg4 = ret1, ret2, ret3, ret4
      end
    end

    if (not posthook) then  return func( numargs(num, arg1, arg2, arg3, arg4) );  end
    local ret1, ret2, ret3, ret4, ret5 = func( numargs(num, arg1, arg2, arg3, arg4) )

    local useret, ret1b, ret2b, ret3b, ret4b, ret5b
    if (fname == "create") then
      useret, ret1b, ret2b, ret3b, ret4b, ret5b = posthook( ret1, ret2, ret3, ret4, ret5, numargs(num, arg1, arg2, arg3, arg4) )
    elseif (fname == "getvalue") then
      useret, ret1b, ret2b, ret3b, ret4b, ret5b = posthook( ret1, numargs(num, arg1, arg2, arg3, arg4) )
    else
      useret, ret1b, ret2b, ret3b, ret4b, ret5b = posthook( numargs(num, arg1, arg2, arg3, arg4) )
    end
    if (useret == true) then
      return ret1b, ret2b, ret3b, ret4b, ret5b
    else
      return ret1, ret2, ret3, ret4, ret5
    end
  end

  local function itemCall(itemType, fname, ...)
    local tab = itemFuncs[itemType]
    local func = tab[fname]
    if (type(func) == "function") then  return true, itemCall_handlehooks(0, itemType, fname, func, nil, nil, ...);  end
    if (func ~= nil or not tab.inherit) then  return;  end
    local depth
    func, depth = itemCall_recursive_get(tab.inherit, fname)
    if (type(func == "function")) then
      local arg = select(-1, ...)  -- Get the last argument (*_arg) from the ellipses
      if (arg ~= nil) then  return true, itemCall_handlehooks(depth, itemType, fname, func, nil, nil, ...);  end
      arg = itemCall_recursive_get(tab.inherit, fname.."_arg", depth);
      return true, itemCall_handlehooks(depth, itemType, fname, func, true, arg, ...)
    end
  end


-- PANEL ITEM INTERACTION
----------------------------

  local function ItemOnEnter(self)
    local tip = self.TjOpt_tab.tooltip
    if (tip) then
      GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
      GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b);
      if (type(tip) == "string") then
        local wrap = self.TjOpt_tab.tooltipWrap
        if (wrap == nil) then
          wrap = GetPanel(self).TjOpt_tab.tooltipWrap
          if (wrap == nil) then  wrap = 1;  end
        end
        GameTooltip:AddLine(tip, nil, nil, nil, wrap);
        if (self.TjOpt_tab.tooltip2) then
         GameTooltip:AddLine(self.TjOpt_tab.tooltip2, nil, nil, nil, wrap)
        end
      elseif (type(tip) == "function") then
        tip(self, GameTooltip)
      end
      GameTooltip:Show()
    end
  end

  local function ItemOnLeave(self)
    GameTooltip:Hide();
  end

  local function sendOnChange(obj, key, val, interaction)
    local func = obj.TjOpt_tab.OnChange or GetPanel(obj).TjOpt_tab.OnChange
    if (type(func) == "function") then
      interaction = not not interaction  -- Make sure interaction is a boolean
      if (interaction and GetPanel(obj):IsChangeInProgress()) then  interaction = false;  end
      func(obj, key, val, interaction)
    end
  end

  local function sendOnChange_recursive(vars, obj, ...)
    if (obj) then
      if (obj.TjOpt_tab) then
        local key = obj.TjOpt_tab.variable
        sendOnChange(obj, key, vars[key])
      end
      sendOnChange_recursive(vars, ...)
    end
  end

  local function LoadVar(obj, vars)
    if (obj.TjOpt_tab and obj.TjOpt_tab.variable) then
      local v, t = vars[obj.TjOpt_tab.variable], obj.TjOpt_tab.type
      local callsuccess = itemCall(t, "setvalue", obj, v, obj.TjOpt_tab, itemFuncs[t].setvalue_arg)
      if (not callsuccess) then
        panelerror(GetPanel(obj), 'Could not set value of item of type "'..t..'".')
      end
    end
  end

  local function LoadVars_recursive(vars, obj, ...)
    if (obj) then
      LoadVar(obj, vars)
      LoadVars_recursive(vars, ...)
    end
  end

  local function SaveVar(obj, valgiven, val)
    if (obj.TjOpt_tab and obj.TjOpt_tab.variable) then
      local vars = GetPanel(obj).TjOpt_tab.variables
      if (vars) then
        if (not valgiven) then
          local t, callsuccess = obj.TjOpt_tab.type
          callsuccess, val = itemCall(t, "getvalue", obj, obj.TjOpt_tab, itemFuncs[t].getvalue_arg)
          if (not callsuccess) then
            panelerror(GetPanel(obj), 'Could not get value from item of type "'..t..'".')
            return;
          end
        end
        -- Prevent nil value from causing inconsistencies if copytab function is used:
        if (val == nil) then  val = false;  end

        local key = obj.TjOpt_tab.variable
        vars[key] = val
        return key, val;
      end
    end
  end


  -- FOCUS/TAB SYSTEM:

  local function panelClearFocus(panel)
    if (panel.TjOpt_FocusList and panel:IsShown()) then
      for i,obj in ipairs(panel.TjOpt_FocusList) do
        if (obj:HasFocus()) then
          obj:ClearFocus()
          return;
        end
      end
    end
  end

  function TjOptions.HandleTabbing(obj)
    local list = GetPanel(obj).TjOpt_FocusList
    local size = list and #list
    if (not list or size < 2) then  return;  end
    local index
    for i,tabobj in ipairs(list) do  -- Find current object's position in the list:
      if (tabobj == obj) then
        index = i
        break;
      end
    end
    if (not index) then  return;  end  -- Object not in the list.

    local adjust, target = IsShiftKeyDown() and -1 or 1
    repeat
      index = index + adjust
      if (index < 1) then
        index = size
      elseif (index > size) then
        index = 1
      end
      target = list[index]
    until ( target == obj or ((not target.IsVisible or target:IsVisible()) and
            (not target.IsEnabled or target:IsEnabled())) )

    target:SetFocus()
    return target
  end


-- BUILD PANEL CONTENTS
--------------------------

  local function BuildPanelContents(panel)
    panel.TjOpt_built = true;
    local tab = panel.TjOpt_tab
    if (tab.title) then
      panel.titleLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
      panel.titleLabel:SetPoint("TOPLEFT", panel, "TOPLEFT", 16, -16);
      panel.titleLabel:SetText(tab.title);
      if (tab.titleCenter) then
        panel.titleLabel:SetWidth(382)
        panel.titleLabel:SetJustifyH("CENTER")
      end
    end

    local workpanel
    if (tab.scrolling) then
      local scrollname = type(tab.scrolling) == "string" and tab.scrolling or ScrollFrameGlobalName..(TjOptions.numScrollFrames + 1)
      local scrollframe = CreateFrame("ScrollFrame", scrollname, panel, "UIPanelScrollFrameTemplate")
      TjOptions.numScrollFrames = TjOptions.numScrollFrames + 1
      scrollframe:SetWidth(382)
      if (panel.titleLabel) then
        scrollframe:SetHeight(398 - panel.titleLabel:GetHeight())
        scrollframe:SetPoint("TOPLEFT", panel.titleLabel, "TOPLEFT", -16, -21)
      else
        scrollframe:SetHeight(410)
        scrollframe:SetPoint("TOPLEFT", panel, "TOPLEFT", 0, -9)
      end

      -- Create scrollbar background:
      local scrollbarBG = _G[scrollname.."ScrollBar"]:CreateTexture("$parentBackground", "BACKGROUND")
      scrollbarBG:SetTexture(0.025, 0.025, 0.025, 0.5)
      scrollbarBG:SetAllPoints()

      local scrollchild = CreateFrame("Frame", nil, scrollframe)
      scrollchild:SetHeight(370)
      scrollchild:SetWidth(370)
      scrollchild:SetPoint("TOPLEFT", scrollframe, "TOPLEFT")
      scrollframe:SetScrollChild(scrollchild)
      panel.TjOpt_scrollchild = scrollchild
      scrollchild.TjOpt_isScrollChild = true

      workpanel = scrollchild
    else
      workpanel = panel
    end

    local spacing, column1Offset = tab.itemspacing or 6
    local callsuccess, obj, handletip, obj_offx, obj_offy, obj_buffer, focusable
    local relativeObj, column1ready, t, n
    local xOffset_total, lastobj_offx, lastobj_offy, nextoffy = 0, 0, 0, 0

    for i, v in ipairs(tab.items) do
      t = v.type
      if (not t) then  v.type, t = "checkbox", "checkbox";  end
      n = v.name or ItemGlobalName..(TjOptions.numItems + 1)
      if ( _G[n] ~= nil ) then
        if (v.name) then
          panelerror(panel, 'Could not create item instance named "'..n..'". Global is already in use.', true)
          n = nil
        else
        -- Someone's used our automatically-generated global name! Most likely a create method or posthook didn't
        -- return the frame, either due to a bug or because it decided not to give the object to us for some reason.
          local count, n2 = 0
          repeat
            count = count + 1
            n2 = n.."_"..count
          until ( _G[n2] == nil )
          n = n2
        end
      end
      if (n) then
        if (itemFuncs[t]) then
          callsuccess, obj, handletip, obj_offx, obj_offy, obj_buffer, focusable = itemCall(t, "create", n, workpanel, v, itemFuncs[t].create_arg)
          if (not callsuccess) then
            panelerror(panel, 'Item type "'..t..'" create method failed.')
          end
        else
          panelerror(panel, 'Item type "'..t..'" not registered with TjOptions.')
        end
        if (obj) then
          TjOptions.numItems = TjOptions.numItems + 1
          v.name = n
          obj.TjOpt_tab = v
          obj_offx, obj_offy, obj_buffer = obj_offx or 0, obj_offy or 0, obj_buffer or 0
          if (handletip) then
            obj:SetScript("OnEnter", ItemOnEnter)
            obj:SetScript("OnLeave", ItemOnLeave)
          end

          local column, x, y = v.column
          column = column and type(column) == "number" and column or 1
          if (column == 1) then
            x = obj_offx - lastobj_offx
            if (v.xOffset) then
              x = x - xOffset_total + v.xOffset + (column1Offset or tab.column1Offset or 0)
              xOffset_total = v.xOffset
            elseif (not column1Offset) then
              column1Offset = tab.column1Offset or 0
              x = x + column1Offset
            end
            y = obj_offy - nextoffy - (v.topBuffer or 0)
            nextoffy = obj_buffer + (v.btmBuffer or 0)
          else
            x = obj_offx + (v.xOffset or 0) + (tab["column"..column.."Offset"] or 180) - xOffset_total
            y = obj_offy - (v.topBuffer or 0)
          end

          if (focusable) then
            local list = panel.TjOpt_FocusList or {}
            panel.TjOpt_FocusList = list
            list[#list+1] = obj
            obj:SetScript("OnTabPressed", TjOptions.HandleTabbing)
          end

          if (column1ready) then
            if (column == 1) then
              obj:SetPoint("TOPLEFT", relativeObj, "BOTTOMLEFT", x, y - spacing)
              relativeObj, lastobj_offx, lastobj_offy = obj, obj_offx, obj_offy
            else
              obj:SetPoint("TOPLEFT", relativeObj, "TOPLEFT", x - lastobj_offx, y - lastobj_offy)
            end
          else
            if (relativeObj) then
              if (column == 1) then
                obj:SetPoint("TOPLEFT", relativeObj, "BOTTOMLEFT", x, y - spacing)
              else
                obj:SetPoint("TOPLEFT", relativeObj, "TOPLEFT", x - lastobj_offx, y - lastobj_offy)
              end
            elseif (tab.scrolling) then
              obj:SetPoint("TOPLEFT", workpanel, "TOPLEFT", x + 14, y - 5)
            elseif (panel.titleLabel) then
              obj:SetPoint("TOPLEFT", panel.titleLabel, "BOTTOMLEFT", x - 2, y - 12)
            else
              obj:SetPoint("TOPLEFT", workpanel, "TOPLEFT", x + 14, y - 16)
            end
            relativeObj = obj
            if (column == 1) then
              column1ready = true
              lastobj_offx, lastobj_offy = obj_offx, obj_offy
            else
              lastobj_offx, lastobj_offy = x, obj_offy
            end
          end

          if (BuiltItemsList and BuiltItemsList[t]) then  --If iterator-helper table for this item type exists
            tinsert(BuiltItemsList[t], obj)               --then add the newly built item to the list.
          end
        end
      end
      obj = nil;
    end

    local func = tab.OnBuild
    if (type(func) == "function") then
      func(panel)
    end
    if (tab.variables) then
    -- Remember current settings in case Cancel is pressed. (Happens after OnBuild in case that changed something.)
      tab.cancelTo = {}
      --copytab(tab.variables, tab.cancelTo);
      copyvars(panel, tab.cancelTo)
    end
  end


-- PANEL USE FUNCTIONS
-------------------------

  local function OpenGroup(self)
    local panel = self.TjOpt_panel
    if (type(panel) == "string") then  panel = Panels[panel];  end
    if (type(panel) == "table") then
      if (self.TjOpt_sound) then  PlaySound(self.TjOpt_sound);  end
      InterfaceOptionsFrame_OpenToCategory(panel)
    end
  end

  local function funcOnShow(self)
    if (not self.TjOpt_built) then  BuildPanelContents(self);  end
    self:LoadVariables()
    self.TjOpt_possiblechange = true
    local func = self.TjOpt_tab.OnShow
    if (type(func) == "function") then  func(self);  end
  end

  local function funcOkay(self)
    if (self.TjOpt_possiblechange) then
      panelClearFocus(self)  -- Needed before copyvars below since some items change their values when focus is lost.
      if (self.TjOpt_built and self.TjOpt_tab.variables) then
        -- Remember current settings in case Cancel is pressed after panel is shown again.
        --copytab(self.TjOpt_tab.variables, self.TjOpt_tab.cancelTo);
        copyvars(self, self.TjOpt_tab.cancelTo);
      end
      self.TjOpt_possiblechange = nil
      local func = self.TjOpt_tab.OnOkay
      if (type(func) == "function") then  func(self);  end
    end
  end

  local function funcCancel(self)
    if (self.TjOpt_possiblechange) then
      panelClearFocus(self)  -- Needed before copyvars below since some items change their values when focus is lost.
      if (self.TjOpt_tab.cancelTo) then
        self.TjOpt_tab.isCanceling = true
        -- Revert to previous settings.
        --copytab(self.TjOpt_tab.cancelTo, self.TjOpt_tab.variables);
        copyvars(self, self.TjOpt_tab.cancelTo, true);
        sendOnChange_recursive(self.TjOpt_tab.variables, GetItems(self))
        self.TjOpt_tab.isCanceling = nil
      end
      self.TjOpt_possiblechange = nil
      local func = self.TjOpt_tab.OnCancel
      if (type(func) == "function") then  func(self);  end
    end
  end

  local function funcDefault(self)
    panelClearFocus(self)  -- Needed before copyvars below since some items change their values when focus is lost.
    if (self.TjOpt_tab.defaults) then
      self.TjOpt_tab.isDefaulting = true
      if (not self.TjOpt_built) then  BuildPanelContents(self);  end

      --copytab(self.TjOpt_tab.defaults, self.TjOpt_tab.variables);
      copyvars(self, self.TjOpt_tab.defaults, true);

      self:LoadVariables()  -- This has switched between being necessary and being redundant (due to OnShow being
      -- called automatically) multiple times as the beta has progressed. Leaving it in for now; test it after WotLK
      -- has been released for a while.
      sendOnChange_recursive(self.TjOpt_tab.variables, GetItems(self))
      self.TjOpt_tab.isDefaulting = nil
      if (InterfaceOptionsFrame:IsShown()) then
        self.TjOpt_possiblechange = true
      else
      -- Remember current settings if Interface Options frame isn't shown.
      -- (Allow Cancel to revert this change if it is shown.)
        --copytab(self.TjOpt_tab.variables, self.TjOpt_tab.cancelTo);
        copyvars(self, self.TjOpt_tab.cancelTo);
      end
    end
    local func = self.TjOpt_tab.OnDefault
    if (type(func) == "function") then  func(self);  end
  end


-- PANEL API
---------------

  local function LoadVariables(self)
    if (self.TjOpt_built and self.TjOpt_tab.variables) then
      self.TjOpt_tab.isLoading = true
      LoadVars_recursive(self.TjOpt_tab.variables, GetItems(self))
      self.TjOpt_tab.isLoading = nil
    end
  end

-- Call in one of two ways:  myPanelGroup:SetDefaultPanel("PanelName")  -OR-
--                           myPanelGroup:SetDefaultPanel(PanelFrame)
  local function SetDefaultPanel(self, panel)
    if (type(panel) ~= "string" and type(panel) ~= "table") then
      error("SetDefaultPanel(): Invalid argument. Expected string or table; got "..type(panel)..".")
    end
    self.TjOpt_panel = panel
  end

-- Call like so:  myPanelGroup:SetSound("SoundFile")
-- Use nil as the arg for no sound. Use an empty string ("") to use the default sound.
  local function SetSound(self, sound)
    if (sound ~= nil and type(sound) ~= "string") then
      error("SetSound(): Invalid argument. Expected string or nil; got "..type(sound)..".")
    end
    if (sound == "") then  sound = defaultSound;  end
    self.TjOpt_sound = sound
  end

  local function IsChangeInProgress(self)
    local c, d, l = self.TjOpt_tab.isCanceling, self.TjOpt_tab.isDefaulting, self.TjOpt_tab.isLoading
    return (c or d or l), c, d, l;
  end


-- PANEL CREATION API
------------------------

  function TjOptions.CreatePanel(name, parent, isDefaultInGroup, tab)
    if (type(tab) == "nil" and type(isDefaultInGroup) == "table") then
      tab = isDefaultInGroup;
      isDefaultInGroup = nil;
    end
    if (type(tab) ~= "table" or type(name) ~= "string" or (type(parent) ~= "nil" and type(parent) ~= "string")) then
      error("Invalid arg(s). Usage: TjOptions.CreatePanel(stringName, stringParentPanelName/nil, [isDefaultInGroup (boolean/any),] tablePanelLayout)")
    elseif (Panels[name]) then
      error("TjOptions.CreatePanel(): A panel named '"..name.."' already exists.")
    elseif (isDefaultInGroup and parent and not Panels[parent]) then
      error("TjOptions.CreatePanel(): Cannot set as default in group because given parent was not found in TjOptions data.")
    elseif (type(tab.items) ~= "table" or not tab.items[1]) then
      error("TjOptions.CreatePanel(): Table invalid - 'items' key missing or invalid.")
    end

    local vars, createdvars = tab.variables
    if (type(vars) == "string") then
      local globalname = vars
      vars = _G[globalname]
      if (type(vars) ~= "table") then
        vars = {}
        if (type(tab.defaults) == "table") then  copytab(tab.defaults, vars);  end
        _G[globalname] = vars
        createdvars = true
      end
      tab.variables = vars
    elseif (vars and type(vars) ~= "table") then
      error("TjOptions.CreatePanel(): Table invalid - If 'variables' key is used, it must be a table or a string.")
    end

    local panel = CreateFrame("Frame")
    panel.name = name
    panel.parent = parent
    panel.okay = funcOkay
    panel.cancel = funcCancel
    panel.default = funcDefault
    panel.TjOpt_tab = tab
    panel.LoadVariables = LoadVariables
    panel.IsChangeInProgress = IsChangeInProgress
    panel:SetScript("OnShow", funcOnShow)
    if (parent and Panels[parent] and (isDefaultInGroup or not Panels[parent].TjOpt_panel)) then
      Panels[parent].TjOpt_panel = panel;
    end
    Panels[name] = panel
    InterfaceOptions_AddCategory(panel)

    if (vars) then
      if (createdvars) then  return panel, false;  end
      return panel, vars.Version
    end
    return panel
  end

  function TjOptions.CreatePanelGroup(name, parent, isDefaultInGroup, sound)
    if (type(name) ~= "string" or (type(parent) ~= "nil" and type(parent) ~= "string") or (type(sound) ~= "nil" and type(sound) ~= "string")) then
      error("Invalid arg(s). Usage: TjOptions.CreatePanelGroup(stringName, stringParentPanelName/nil[, isDefaultInGroup (boolean/any)[, stringSoundFile]])")
    elseif (Panels[name]) then
      error("TjOptions.CreatePanelGroup(): A panel named '"..name.."' already exists.")
    elseif (isDefaultInGroup and parent and not Panels[parent]) then
      error("TjOptions.CreatePanelGroup(): Cannot set as default in group because given parent was not found in TjOptions data.")
    end

    local panel = CreateFrame("Frame")
    panel.name = name
    panel.parent = parent
    panel.SetDefaultPanel = SetDefaultPanel
    panel.SetSound = SetSound
    panel:SetSound(sound)
    panel:SetScript("OnShow", OpenGroup)
    if (parent and Panels[parent] and (isDefaultInGroup or not Panels[parent].TjOpt_panel)) then
      Panels[parent].TjOpt_panel = panel;
    end
    Panels[name] = panel
    InterfaceOptions_AddCategory(panel)
    return panel;
  end


-- ITEM TYPE REGISTRATION API
--------------------------------

  -- registered = TjOptions.RegisterItemType( itemType, revision, [inherit,] funcList[, updateFunc] )
  function TjOptions.RegisterItemType(itemType, revision, inherit, funcList, updateFunc)
    if ((type(inherit) == "table" or type(inherit) == "function") and updateFunc == nil) then
    -- Handle omission of inherit arg:
      updateFunc = funcList
      funcList = inherit
      inherit = nil
    end
    if (type(itemType) ~= "string" or type(revision) ~= "number" or (inherit and type(inherit) ~= "string") or (type(funcList) ~= "table" and type(funcList) ~= "function") or (updateFunc and type(updateFunc) ~= "function")) then
      error("Invalid arg(s). Usage: TjOptions.RegisterItemType(string itemType, number revision, [string inherit,] funcList (table or function)[, function updateFunc])")
    end
    if (inherit) then
      assert(inherit ~= itemType, 'TjOptions.RegisterItemType(): Could not inherit from item type "'..inherit..'": Cannot inherit from self.')
      assert(itemFuncs[inherit], 'TjOptions.RegisterItemType(): Could not inherit from item type "'..inherit..'": Type not found.')
    elseif (type(funcList) == "table" and type(funcList.create) ~= "function") then
      error("TjOptions.RegisterItemType(): Cannot register an item type that does not have a funcList.create function.")
    end
    local oldrev = itemRev[itemType]
    if (oldrev and oldrev >= revision) then  return false;  end
    if (type(funcList) == "function") then  funcList = { create = funcList };  end

    itemFuncs[itemType], itemRev[itemType] = funcList, revision
    if (inherit) then  itemFuncs[itemType].inherit = inherit;  end

    if (oldrev and updateFunc) then
      local tab = getBuiltItemsList(itemType)
      for i,frame in ipairs(tab) do
        updateFunc(frame, oldrev, frame.TjOpt_tab)
      end
    end

    return true;
  end

  function TjOptions.SetItemTypeAlias(alias, itemType)
    if (type(alias) ~= "string" or type(itemType) ~= "string") then
      error("Invalid arg(s). Usage: TjOptions.SetItemTypeAlias(string alias, string itemType)")
    end
    if (itemRev[itemType] and not itemAlias[alias]) then
      itemAlias[alias] = itemType
      return true
    end
  end

  function TjOptions.GetItemTypeRevision(itemType)
    return itemRev[itemType]
  end

  function TjOptions.BuiltItemsIterator(itemType)
    assert(type(itemType) == "string", "Invalid arg. Usage: TjOptions.BuiltItemsIterator( string itemType )")
    local tab = getBuiltItemsList(itemType)
    return ipairs(tab)
  end

  function TjOptions.ItemChanged(itemFrame, ...)
    local num = select("#", ...)
    local key, val, noUser
    if (type(itemFrame) == "boolean") then
      noUser = itemFrame
      itemFrame = select(1, ...)
      key, val = SaveVar(itemFrame, (num > 1), select(2, ...))
    else
      key, val = SaveVar(itemFrame, (num > 0), ...)
    end
    sendOnChange(itemFrame, key, val, not noUser)
  end


-- STANDARD ITEM TYPES
-------------------------

  local function CheckboxOnClick(self)
    if ( self:GetChecked() ) then
      PlaySound("igMainMenuOptionCheckBoxOn");
    else
      PlaySound("igMainMenuOptionCheckBoxOff");
    end
    TjOptions.ItemChanged(self)
  end

  --SETVALUE: setvalue(self, val, data, arg)

  local function SetCheckboxVal(self, val)
    if (val) then
      self:SetChecked(1);
    else
      self:SetChecked(0);
    end
  end

  --GETVALUE: value = getvalue(self, data, arg)

  local function GetCheckboxVal(self)
    if (self:GetChecked()) then  return true;  else  return false;  end
  end

  --CREATE: frame, handletip, xOffset, yOffset, btmBuffer = create(name, parent, data, arg)

  local function CreateCheckbox(name, parent, data, template)
    template = template or "InterfaceOptionsCheckButtonTemplate"
    local frame = CreateFrame("CheckButton", name, parent, template)
    frame:SetScript("OnClick", CheckboxOnClick)
    local label = _G[name.."Text"]
    if (label) then
      label:SetText(data.text)  -- nil is a valid value here.
      local w = data.width or label:GetWidth()
      frame:SetHitRectInsets(0, w * -1, 0, 0)
    else
      frame:SetHitRectInsets(0, (data.width or 0) * -1, 0, 0)
    end
    return frame, true;
  end

  local function CreateLabel(name, parent, data, font)
    font = data.font or font or "GameFontNormal"
    local label = parent:CreateFontString(name, "ARTWORK", font);
    if (data.width) then  label:SetWidth(data.width);  end
    if (data.justifyH) then  label:SetJustifyH(data.justifyH);  end
    label:SetText(data.text);
    return label, nil, 0, -2, 2;
  end

  local function CreateLabel_wrap(name, parent, data, font)
    data.justifyH = data.justifyH or "LEFT"
    data.width = data.width or 370
  end

  -- Register built-in item types:
  TjOptions.RegisterItemType("checkbox", THIS_VERSION,
    { create = CreateCheckbox, getvalue = GetCheckboxVal, setvalue = SetCheckboxVal })
  TjOptions.RegisterItemType("checkboxsmall", THIS_VERSION, "checkbox", { create_arg = "InterfaceOptionsSmallCheckButtonTemplate" })
  TjOptions.RegisterItemType("checkboxnolabel", THIS_VERSION, "checkbox", { create_arg = "OptionsBaseCheckButtonTemplate" })
  TjOptions.RegisterItemType("label", THIS_VERSION, CreateLabel)
  TjOptions.RegisterItemType("labelwhite", THIS_VERSION, "label", { create_arg = "GameFontHighlight" })
  TjOptions.RegisterItemType("labelwrap", THIS_VERSION, "label", { create_prehook = CreateLabel_wrap })
  TjOptions.RegisterItemType("labelwrapwhite", THIS_VERSION, "labelwrap", { create_arg = "GameFontHighlight" })
  TjOptions.SetItemTypeAlias("labelnorm", "label")

  -- Backward compatibility:
  if (not itemRev["dropdown"]) then
    local function DropdownOnSelect(self, val, oldval)
      if (val ~= oldval) then  TjOptions.ItemChanged(self, val);  end
    end

    local function SetDropDownVal(self, val)
      if (self:GetSelectedValue() ~= val) then
        self:SetSelectedValue(val)
      end
    end

    local function GetDropDownVal(self)
      return self:GetSelectedValue()
    end

    local function CreateDropDown(name, parent, data)
      assert(TjDropDownMenu, "TjDropDownMenu library not found.");
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

    TjOptions.RegisterItemType("dropdown", 0, { create = CreateDropDown, getvalue = GetDropDownVal, setvalue = SetDropDownVal })
  end

end
