
--
--  TjSharedMediaDropDown.lua
--    by Tuhljin
--
--

local THIS_VERSION = 0.03

if (not TjSharedMediaDropDown or TjSharedMediaDropDown.Version < THIS_VERSION) then
  assert(TjDropDownMenu, "TjSharedMediaDropDown requires TjDropDownMenu library.")
  local SharedMedia = LibStub:GetLibrary("LibSharedMedia-3.0")
  assert(SharedMedia, "TjSharedMediaDropDown requires LibSharedMedia-3.0.")

  TjSharedMediaDropDown = TjSharedMediaDropDown or {}
  local SMDD = TjSharedMediaDropDown
  SMDD.Version = THIS_VERSION;

  SMDD.menus = SMDD.menus or {}
  local menus = SMDD.menus
  SMDD.emptyList = SMDD.emptyList or { { text = NONE, value = 0, checked = 1 } }
  local emptyList = SMDD.emptyList
  SMDD.menurev = SMDD.menurev or {}
  local menurev = SMDD.menurev
  
  local internal_SetMenu

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

  local function getList(mediatype, refresh)
    local menuList = menus[mediatype]
    local rev = menurev[mediatype] or 0
    if (refresh) then
      wipe(menuList)
    elseif (menuList) then
      return menuList, rev;
    else
      menus[mediatype] = {}
      menuList = menus[mediatype]
    end
    local mediaList = SharedMedia:List(mediatype)
    if (not mediaList) then
      copytab(emptyList, menuList)
    else
      local blizztab
      for i,mt in ipairs(mediaList) do
        if (mt == "None" or mt == NONE) then
          tinsert(menuList, 1, { text = mt, value = 0 })
        elseif (strsub(mt, 1, 10) == "Blizzard: ") then
          if (not blizztab) then
            blizztab = {}
            menuList[#(menuList)+1] = { text = "Blizzard:", menuList = blizztab,
                                        keepShownOnClick = 1, hasArrow = 1, TjDDM_notCheckable = 1 }
          end
          blizztab[#(blizztab)+1] = { text = strsub(mt, 11), value = mt }
        else
          menuList[#(menuList)+1] = { text = mt, value = mt }
        end
      end
    end
    if (not SMDD.regcallback) then
      SharedMedia.RegisterCallback(SMDD, "LibSharedMedia_Registered");
      SMDD.regcallback = true
    end
    rev = rev + 1
    menurev[mediatype] = rev  -- Increment this menu's revision number
    return menuList, rev
  end


  local function OpenMenu_hook(self, ...)
    if (self.TjSMDD.mediatype) then
      local mediatype = self.TjSMDD.mediatype
      if (menurev[mediatype] > self.TjSMDD.menurev[mediatype]) then  -- A newer revision of this menu exists
        local value = self:GetSelectedValue()
        local list, rev = getList(mediatype)
        local menuList = wipe(self.TjDDM.menuList)
        copytab(list, menuList)
        internal_SetMenu = true
        self:SetMenu()  -- Setup menu functions
        self.TjSMDD.menurev[mediatype] = rev  -- New revision in place.
        self:SetSelectedValue(value)  -- Restore selected value
      end
    end
    self.TjSMDD.OpenMenu_orig(self, ...)
  end

  local function SetMenu_hook(self, ...)
    if (internal_SetMenu) then
      internal_SetMenu = nil
    else
      self.TjSMDD.mediatype = nil
    end
    self.TjSMDD.SetMenu_orig(self, ...)
  end

  local function Fetch(self)
    local mediatype = self.TjSMDD.mediatype
    if (mediatype) then
      return SharedMedia:Fetch(mediatype, self:GetSelectedValue())
    end
  end

  local function ConvertToSMDD(dropdown, mediatype, menuList)
    local list, rev = getList(mediatype)
    menuList = menuList or {}
    copytab(list, menuList)
    dropdown:SetMenu(menuList, true)
    dropdown.TjSMDD = {}
    dropdown.TjSMDD.mediatype = mediatype
    dropdown.TjSMDD.menus = {}
    dropdown.TjSMDD.menus[mediatype] = menuList
    dropdown.TjSMDD.menurev = {}
    dropdown.TjSMDD.menurev[mediatype] = rev

    dropdown.TjSMDD.SetMenu_orig = dropdown.SetMenu
    dropdown.SetMenu = SetMenu_hook
    dropdown.TjSMDD.OpenMenu_orig = dropdown.OpenMenu
    dropdown.OpenMenu = OpenMenu_hook

    dropdown.SetMediaType = SMDD.SetMediaType
    dropdown.Fetch = Fetch
  end

  -- LibSharedMedia Callback
  function SMDD:LibSharedMedia_Registered(event, mediatype, name)
    if (menurev[mediatype]) then
      getList(mediatype, true)
    end
  end


-- API
---------

  function SMDD.SetMediaType(frame, mediatype, replaceMenu)
    if (type(frame) ~= "table" or type(mediatype) ~= "string" or (replaceMenu and type(replaceMenu) ~= "table")) then
      error("Invalid argument(s). Usage: TjSharedMediaDropDown.SetMediaType(frame, string[, table]) -or- frame:SetMediaType(string[, table])")
    end
    assert(frame.TjDDM, "SetMediaType(): Invalid argument. Frame must be a primary dropdown frame created by TjDropDownMenu or TjSharedMediaDropDown.")
    mediatype = strlower(mediatype)
    if (not frame.TjSMDD) then
      local menuList = replaceMenu and wipe(replaceMenu) or nil
      ConvertToSMDD(frame, mediatype, menuList);
    elseif (frame.TjSMDD.mediatype == mediatype) then
      return;
    else
      local menuList = frame.TjSMDD.menus[mediatype]
      if (menuList) then
        frame.TjSMDD.mediatype = mediatype
        internal_SetMenu = true
        frame:SetMenu(menuList)
      else
        local list, rev = getList(mediatype)
        menuList = replaceMenu and wipe(replaceMenu) or {}
        copytab(list, menuList)
        frame.TjSMDD.menus[mediatype] = menuList
        frame.TjSMDD.menurev[mediatype] = rev
        frame.TjSMDD.mediatype = mediatype
        frame.TjDDM.selectedValue = nil
        internal_SetMenu = true
        frame:SetMenu(menuList, true)
      end
    end
  end

  function SMDD.CreateSMDropDown(name, parent, mediatype, x, y, displayMode, autoHideDelay, EasyMenuSubFunc)
    if (name ~= nil and type(name) ~= "string") then
      error("CreateSMDropDown(): Argument 1 invalid (name). Expected string or nil. Got "..type(name)..".")
    elseif (type(mediatype) ~= "string") then
      error("CreateSMDropDown(): Argument 3 invalid (mediatype). Expected string. Got "..type(mediatype)..".")
    end
    mediatype = strlower(mediatype)
    local menuList = {}
    local frame = TjDropDownMenu.CreateDropDown(name, parent, menuList, x, y, displayMode, autoHideDelay, EasyMenuSubFunc)
    ConvertToSMDD(frame, mediatype, menuList)
    return frame
  end


-- Register with TjOptions
-----------------------------

  if (TjOptions and TjOptions.RegisterItemType) then
    local function CreateSMDD_a(name, parent, data, arg)
      data.menu = {}
      data.width = data.width or 170
    end

    local function CreateSMDD_b(frame, handletip, xOffset, yOffset, btmBuffer, name, parent, data, arg)
      data.mediatype = data.mediatype or "background"
      SMDD.SetMediaType(frame, data.mediatype, data.menu)
    end

    TjOptions.RegisterItemType("sharedmedia", THIS_VERSION, "dropdown",
      { create_prehook = CreateSMDD_a, create_posthook = CreateSMDD_b })
  end

end
