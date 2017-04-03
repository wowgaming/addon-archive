Proximo = LibStub("AceAddon-3.0"):NewAddon("Proximo", "AceEvent-3.0", "AceConsole-3.0", "AceTimer-3.0", "AceHook-3.0", "AceComm-3.0")
local Proximo = Proximo
local L = LibStub("AceLocale-3.0"):GetLocale("Proximo", true)
local TG = LibStub:GetLibrary("TalentGuess-1.0"):Register()
local db

Proximo.title = "Proximo"
Proximo.version = GetAddOnMetadata(Proximo.title, "Version")

local prox_list = {}
local unit = 1
local current_unit = 0
local max_unit_size = 5
local arena_start = false
local mainassist = "target"
local mainassistset = false

--LUA calls
local pairs = pairs
local tonumber = tonumber
local gsub = gsub
local string_format = string.format
local string_find = string.find
local string_split = string.split
local string_match = string.match

--Blizzard API
local UnitName = UnitName
local UnitClass = UnitClass
local UnitHealth = UnitHealth
local UnitPowerType = UnitPowerType
local UnitSex = UnitSex
local UnitRace = UnitRace
local UnitMana = UnitMana
local UnitManaMax = UnitManaMax
local UnitExists = UnitExists
local UnitCanAttack = UnitCanAttack
local UnitIsPlayer = UnitIsPlayer
local UnitIsVisible = UnitIsVisible
local UnitIsConnected = UnitIsConnected
local UnitIsCharmed = UnitIsCharmed
local InCombatLockdown = InCombatLockdown
local GetNumPartyMembers = GetNumPartyMembers
local GetPlayerBuff = GetPlayerBuff
local GetPlayerBuffTexture = GetPlayerBuffTexture
local GetRealmName = GetRealmName
local IsInInstance = IsInInstance
local UNKNOWNOBJECT = UNKNOWNOBJECT
local SendAddonMessage = SendAddonMessage
local GetWorldStateUIInfo = GetWorldStateUIInfo

--combat log locals
Proximo.COMBAT_EVENTS = {
  ["UNIT_DIED"] = "DEATH",
  ["UNIT_DESTROYED"] = "DEATH",
}
local COMBAT_EVENTS = Proximo.COMBAT_EVENTS
local CombatLog_Object_IsA = CombatLog_Object_IsA
local COMBATLOG_OBJECT_NONE = COMBATLOG_OBJECT_NONE
local COMBATLOG_FILTER_HOSTILE_PLAYERS = COMBATLOG_FILTER_HOSTILE_PLAYERS

----------------------
--table caching
local new, del
do
  local list = setmetatable({}, {__mode='k'})
  function new(...)
    local t = next(list)
    if t then
      list[t] = nil
      for i = 1, select('#', ...) do
        t[i] = select(i, ...)
      end
      return t
    else
      return { ... }
    end
  end
  function del(t)
    for k in pairs(t) do
      t[k] = nil
    end
    list[t] = true
    return nil
  end
end

local function in_arena_zone()
  if select(2, IsInInstance()) == "arena" then
    return true
  end
end

local function in_bg_zone()
  if select(2,IsInInstance()) == "pvp" and db.useinbg then
    return true
  end
end

local function has_arena_started()
  if not arena_start and (in_arena_zone() or in_bg_zone())then
    local name, rank, icon
    for i = 1, 16 do
      name, rank, icon = UnitBuff("player", i, "HELPFUL")
      if icon and icon:match("Spell_Nature_WispSplode") then
        arena_start = false
        return
      end
    end
    arena_start = true
  end
end

local function valid_unit(unitid)
  if arena_start and UnitExists(unitid) and UnitName(unitid) and UnitIsPlayer(unitid) and UnitCanAttack("player",unitid) and not UnitIsCharmed(unitid) and not UnitIsCharmed("player") then
    return true
  end
end

local function cleanname(name, flags)
  local rname = select(1, string_split("-", name))
  return rname
end

function Proximo:Refresh()
  db = self.db.profile
  self:UpdateFrame()
end

----------------------
--On start
function Proximo:OnInitialize()
  self.db = LibStub("AceDB-3.0"):New("ProximoDB", self:GetDefaultConfig())
  self:SetupOptions()
  --callbacks for profile changes
  self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
  self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
  self.db.RegisterCallback(self, "OnProfileReset", "Refresh")
  --local the profile table
  db = self.db.profile
end

----------------------
--Disabled
function Proximo:OnDisable()
  self:ResetList()
  if self.frame then
    self.frame:Hide()
  end
end

----------------------
--Loaded
function Proximo:OnEnable()
  self:RegisterEvent("PLAYER_ENTERING_WORLD")
  self:RegisterComm(self.title)
end

----------------------
--Player Zoned
function Proximo:PLAYER_ENTERING_WORLD(event)
  arena_start = false
  mainassistset = false
  self:ResetList()
  self:ZoneCheck()
end

----------------------
--Combat events
function Proximo:COMBAT_LOG_EVENT_UNFILTERED(arg1, timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
  --check for events we care about
  local etype = COMBAT_EVENTS[event]
  if not etype then return end

  --see if its to an enemy
  local toEnemyPlayer, fromEnemyPlayer, fromTarget, fromFocus
  if (destName and not CombatLog_Object_IsA(destFlags, COMBATLOG_OBJECT_NONE) ) then
    toEnemyPlayer = CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_HOSTILE_PLAYERS)
    destName = cleanname(destName)
  end
  if (sourceName and not CombatLog_Object_IsA(sourceFlags, COMBATLOG_OBJECT_NONE) ) then
    fromEnemyPlayer = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_HOSTILE_PLAYERS)
    fromTarget = CombatLog_Object_IsA(sourceFlags, COMBATLOG_OBJECT_TARGET)
    fromFocus = CombatLog_Object_IsA(sourceFlags, COMBATLOG_OBJECT_FOCUS)
    sourceName = cleanname(sourceName)
  end

  --if not from a enemy type we care about, then end
  if not toEnemyPlayer and not fromEnemyPlayer then return end

  local spellId, spellName, texture, time
  ------------buff/debuff gain----------------
  if etype == "BUFF" then
    if toEnemyPlayer and prox_list[destName] then
      spellId, spellName = select(1, ...)
      texture = select(3, GetSpellInfo(spellId))
      self:AuraApplied(prox_list[destName].unit, destName, prox_list[destName].class, spellName, texture)
    end
  ------------buff/debuff lose----------------
  elseif etype == "FADE" then
    if toEnemyPlayer and prox_list[destName] then
      spellId, spellName = select(1, ...)
      texture = select(3, GetSpellInfo(spellId))
      self:AuraRemoved(prox_list[destName].unit, destName, prox_list[destName].class, spellName, texture)
    end
  ------------spell start----------------
  elseif etype == "CASTSTART" then
    if not fromTarget and not fromFocus and fromEnemyPlayer and prox_list[sourceName] then
      spellId, spellName = select(1, ...)
      time = select(7, GetSpellInfo(spellId)) / 1000
      self:SpellStart(prox_list[sourceName].unit, spellName, time, 1)
    end
  ------------spell end----------------
  elseif etype == "CASTEND" then
    if not fromTarget and not fromFocus and fromEnemyPlayer and prox_list[sourceName] then
      self:HandleSpellEnd(prox_list[sourceName].unit, 1)
    end
  ------------interrupt----------------
  elseif etype == "INTERRUPT" then
    if toEnemyPlayer and prox_list[destName] then
      self:HandleSpellEnd(prox_list[destName].unit, 1)
    end
  ------------deaths----------------
  elseif etype == "DEATH" then
    if toEnemyPlayer and prox_list[destName] then
      prox_list[destName].health = 0
      prox_list[destName].mana = 0
      if db.death then
        local announcement = string_format(ERR_PLAYER_DIED_S, destName)
        self:SendAnnouncement(announcement, 1, .1, .1)
        if db.deathsound then
          PlaySound("LEVELUP")
        end
      end
    end
  end
end

----------------------
--Zone Check
function Proximo:ZoneCheck()
  if InCombatLockdown() then
    self:ScheduleTimer("ZoneCheck", 1, self)
    return
  end
  if in_arena_zone() or in_bg_zone() then
    if self.frame==nil then
      self:MakeFrame()
    end
    self.frame:Show()
    self:RegisterEvent("UNIT_HEALTH")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
    self:RegisterEvent("PLAYER_TARGET_CHANGED")
    self:RegisterEvent("PLAYER_FOCUS_CHANGED")
    if db.mana then self:RegisterEvent("UNIT_MANA") end
    if db.auras then self:RegisterAuras() end
    if db.spell then self:RegisterSpells() end
    if db.talents then
      TG:EnableCollection()
      TG:RegisterCallback(self, "TalentsGuessChanged")
    end
    self:ScheduleRepeatingTimer("FrameRefresh", .1, self)
    self:ScheduleRepeatingTimer("PartyTargets", 1, self)
    if in_arena_zone() then self:ScheduleRepeatingTimer("Sync", 1, self) end
    --enable nameplate tracking if they are on
    if NAMEPLATES_ON then
      self:CreateUnitUpdate()
    end
  else
    self:UnregisterEvent("UNIT_HEALTH")
    self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
    self:UnregisterEvent("PLAYER_TARGET_CHANGED")
    self:UnregisterEvent("PLAYER_FOCUS_CHANGED")
    self:UnregisterEvent("UNIT_MANA")
    self:UnregisterAuras()
    self:UnregisterSpells()
    self:CancelAllTimers()
    TG:DisableCollection()
    if NAMEPLATES_ON then
      self:StopUnitUpdate()
    end
    if self.frame then self.frame:Hide() end
  end
end


----------------------
--Add a unit to local list
function Proximo:AddToList(name, server, class, race, sex, health, mana)
  if not name or name == UNKNOWNOBJECT then return end
  local announcement = name.." - "..self:GetLocalClass(class)
  local t = new()
  t.server = server
  t.race = race
  t.sex = sex
  t.class = class
  t.health = health
  t.lhealth = 100
  t.mana = mana
  t.click = false
  t.unit = unit
  self:RemoveFromList(unit)
  prox_list[name] = t
  --setup frame class
  self:FrameClass(self.frame.buttons[unit],class, db.mana)
  --setup frame race
  if db.race then
    self:SetRaceIcon(self.frame.buttons[unit].raceicon, race, sex)
  end
  --update unit count
  current_unit = unit
  unit = unit + 1
  if unit > max_unit_size then unit = 1 end
  --update frame size (incase we get more than party size)
  self:UpdateFrameHeight()
  --send announcement
  self:SendAnnouncement(announcement, self:GetClassColor(class))
end

----------------------
--Reset local list
function Proximo:ResetList()
  for k, v in pairs(prox_list) do
    prox_list[k] = del(v)
  end
  unit = 1
  self:FrameClean()
end

----------------------
--Remove a unit from list
function Proximo:RemoveFromList(unit)
  for k, v in pairs(prox_list) do
    if v.unit == unit then
      prox_list[k] = del(v)
    end
  end
end

----------------------
--get local list
function Proximo:GetList()
  return prox_list
end

----------------------
--get local arena start flag
function Proximo:ArenaStarted()
  return arena_start
end

----------------------
--Check unit for updates
function Proximo:CheckUnitIDChanges(unitid)
  if valid_unit(unitid) then
    local name, server = UnitName(unitid)
    local health, mana = UnitHealth(unitid), 0
    local talentname = name
    if server then
      talentname = talentname.."-"..server
    else
      server = GetRealmName()
    end
    --if display mana and they have mana, set mana values
    if db.mana and UnitPowerType(unitid) == 0 then
      mana = math.floor((UnitMana(unitid)/UnitManaMax(unitid)) * 100)
    end
    --if a new player
    if not prox_list[name] then
      local class = select(2, UnitClass(unitid))
      local race = select(2, UnitRace(unitid))
      local sex = UnitSex(unitid)
      self:AddToList(name, server, class, race, sex, health, mana, nil)
    else
      prox_list[name].health = health
      prox_list[name].mana = mana
    end
    --if display talents
    if db.talents and not prox_list[name].talents then
      local t1, t2, t3 = TG:GetTalents(talentname)
      local talents = string_format("%d/%d/%d", t1 or 0, t2 or 0, t3 or 0)
      prox_list[name].talents = talents
    end
  end
end

----------------------
--Talent Guess Changed
function Proximo:TalentsGuessChanged()
  for k, v in pairs(prox_list) do
    local talentname, server = k, v.server
    if server ~= GetRealmName() then
      talentname = talentname.."-"..server
    end
    local t1, t2, t3 = TG:GetTalents(talentname)
    local talents = string_format("%d/%d/%d", t1 or 0, t2 or 0, t3 or 0)
    prox_list[k].talents = talents
  end
end

----------------------
--Mouse over event
function Proximo:UPDATE_MOUSEOVER_UNIT(event)
  self:CheckUnitIDChanges("mouseover")
end

----------------------
--Target changed event
function Proximo:PLAYER_TARGET_CHANGED(event)
  self:CheckUnitIDChanges("target")
end

----------------------
--Focus changed event
function Proximo:PLAYER_FOCUS_CHANGED(event)
  self:CheckUnitIDChanges("focus")
end

----------------------
--Unit Health event
function Proximo:UNIT_HEALTH(event, arg1)
  if arg1=="target" or arg1=="focus" then
    self:CheckUnitIDChanges(arg1)
  end
end

----------------------
--Unit Mana event
function Proximo:UNIT_MANA(event, arg1)
 if arg1=="target" or arg1=="focus" then
   self:CheckUnitIDChanges(arg1)
 end
end

----------------------
--Scan party for target updates
function Proximo:PartyTargets()
  local party
  if not in_bg_zone() then
    for i=1, GetNumPartyMembers() do
      party = "party"..i.."target"
      self:CheckUnitIDChanges(party)
      --update party targets
      self:UpdatePartyTarget(i, party)
    end
  end
  --update arena_start flags and frame size
  if not arena_start then
    has_arena_started()
    self:UpdateFrameHeight()
  end
  --update MA while arena has not started
  if not arena_start and not mainassistset then
    self:SetMainAssist(db.ma)
  end
end

----------------------
--Set the MA based on a name
function Proximo:SetMainAssist(ma)
  if mainassistset then return end
  if UnitName("player") == ma or in_bg_zone() then
    mainassist = "target"
    mainassistset = true
  else
    local party
    for i=1, GetNumPartyMembers() do
      party = "party"..i
      if UnitName(party) == ma then
        mainassist = party.."target"
        mainassistset = true
        return
      end
    end
  end
end

----------------------
--Send Comm message to Prox clients
function Proximo:SendProxComm(data)
  self:SendCommMessage(self.title, data, "PARTY", nil, "ALERT")
end

----------------------
--Receive a comm message
function Proximo:OnCommReceived(prefix, message, distribution, sender)
  if prefix == self.title and sender ~= UnitName("player") then
    local method, data = string_match(message, "([^:]+)%:(.+)")
    self[method](self, sender, string_split(",", data))
  end
end

----------------------
--Sync all data with clients
function Proximo:Sync()
  if arena_start and db.sync then
    for k, v in pairs(prox_list) do
      -- if any values we care about changed, sent sync
      if not v.synchealth or not v.syncmana or v.health ~= v.synchealth or v.syncmana ~= v.mana then
        self:SendProxComm(string_format("%s:%s,%s,%s,%s,%d,%d,%d,%s", "ReceiveSync", k, v.server, v.class, v.race or "", v.sex or 1, v.health, v.mana, ""))
        v.synchealth, v.syncmana = v.health, v.mana
      end
    end
  end
end

----------------------
--Receive a sync
function Proximo:ReceiveSync(sender, name, server, class, race, sex, health, mana)
  --convert strings to desired types
  sex, health, mana = tonumber(sex), tonumber(health), tonumber(mana)
  --if arena has started
  if arena_start and db.sync then
    --add if new name
    if not prox_list[name] then
      self:AddToList(name, server, class, race, sex, health, mana)
    --don't sync health for your target or focus (you will always have best data)
    elseif UnitName("target") ~= name and UnitName("focus") ~= name then
      --only update if you don't see them as dead, wait for client to see them as alive
      if prox_list[name].health ~= 0 then
        prox_list[name].health = health
      end
      if prox_list[name].mana ~= 0 then
        prox_list[name].mana = mana
      end
    end
  end
end

----------------------
--Receive a MA
function Proximo:ReceiveMainAssist(sender, ma)
  db.ma = ma
  mainassistset = false
  self:SetMainAssist(ma)
  self:Print(L["MainAssist"]..": "..ma)
end

----------------------
--Receive a version check
function Proximo:ReceiveVersion(sender)
  self:SendProxComm("ReceiveVersionResponse:"..self.version)
end

----------------------
--Receive a version check response
function Proximo:ReceiveVersionResponse(sender, version)
  self:Print(L["VersionCheck"]..": "..sender.." - "..version)
end

----------------------
--Refresh the frame display
function Proximo:FrameRefresh()
  local name, lname, class, health, mana, unit, colortext, alpha, button, talents
  --update each frame
  for k, v in pairs(prox_list) do
    name, class, health, mana, unit, talents = k, v.class, v.health, v.mana, v.unit, v.talents
    button = self.frame.buttons[unit]
    alpha, colortext = 0, "|cFFFFFFFF"
    --set colors
    if health <= 0 then
      colortext = "|cFF444444"
      button.icon:SetAlpha(.33)
      if button.raceicon then button.raceicon:SetAlpha(.33) end
      if button.aura then self:AuraFade(button.aura) end
      if button.spell then self:SpellEnd(button.spell) end
    else
      if health <= 33 then
        colortext = "|cFFFF0000"
      elseif health <= 66 then
        colortext = "|cFFFFFF00"
      end
      if button.icon:GetAlpha(1) ~= 1 then button.icon:SetAlpha(1) end
      if button.raceicon and button.raceicon:GetAlpha(1) ~= 1 then button.raceicon:SetAlpha(1) end
    end
    --update status bar
    button.healthBar:SetValue(health)
    button.healthtext:SetText(string_format("%s%d%s|r", colortext, health, "%"))
    --class
    if db.classtext then
      lname = name.." - "..self:GetLocalClass(class)
    else
      lname = name
    end
    --talents
    if talents and db.talents then
      lname = lname.." ("..talents..")"
    end
    --update macros if not updated already and not in combat
    if not v.click and not InCombatLockdown() then
      self:UpdateClicks(button, db.leftclick, "macrotext1", name, db.leftspellname)
      self:UpdateClicks(button, db.rightclick, "macrotext2", name, db.rightspellname)
      self:UpdateClicks(button, db.mouse3click, "macrotext3", name, db.mouse3spellname)
      self:UpdateClicks(button, db.mouse4click, "macrotext4", name, db.mouse4spellname)
      self:UpdateClicks(button, db.mouse5click, "macrotext5", name, db.mouse5spellname)
      v.click = 1
    end
    --Update unit text
    if v.click then
      button:SetAlpha(1)
      button.text:SetText(colortext..lname.."|r")
    else
      button:SetAlpha(.66)
      button.text:SetText(colortext.."** "..lname.." **|r")
    end
    --update mana bar
    if db.mana and button.manaBar then
      button.manaBar:SetValue(mana)
      if mana > 0 and not button.manaBar:IsVisible() then button.manaBar:Show() end
    end
    --update highlight
    if UnitName(mainassist) == name then alpha = 1 end
    button.healthBar.highlight:SetBackdropBorderColor(db.highlightcolor.r,db.highlightcolor.g,db.highlightcolor.b,alpha)
    --update selected target
    if db.highlighttar then
      if UnitName("target") == name then
        button.healthBar.selected:Show()
      else
        button.healthBar.selected:Hide()
      end
    end
    --update low health announcement
    if db.lowhealth then
      if (health ~= 0) and (health <= 20) and (v.lhealth > 20) then
        self:SendAnnouncement(name.." ("..L["LowHealth"]..")", .8, .3, .3)
        if db.lowhealthsound then
          PlaySound("RaidWarning")
        end
      end
      v.lhealth = health
    end
  end
end

----------------------
--update a buttons clicks
function Proximo:UpdateClicks(button, option, type, name, spell)
  if option == "target" then
    button:SetAttribute(type, "/script PlaySound(\"igMainMenuOptionCheckBoxOn\")\n/targetexact "..name)
  elseif option == "focus" then
    button:SetAttribute(type, "/targetexact "..name.."\n/focus\n/targetlasttarget")
  elseif option == "spell" and spell and spell ~= "" then
    button:SetAttribute(type, "/targetexact "..name.."\n/cast "..spell)
  elseif option == "macro" then
    --add name, fix raw string break to line breaks
    local macro = gsub(gsub(gsub(spell, "*t", name), ";", "\n"), "\\n", "\n")
    button:SetAttribute(type, macro)
  end
end

----------------------
--Scan party for target updates
function Proximo:UpdatePartyTarget(num, target)
  if db.partytargets then
    local name, unit, button
    --update each frame
    for k, v in pairs(prox_list) do
      name, unit = k, v.unit
      button = self.frame.buttons[unit]
      if UnitExists(target) and UnitName(target) == name then
        local r,g,b = self:GetClassColor(select(2, UnitClass("party"..num)))
        button.partytargets[num]:SetStatusBarColor(r,g,b,1)
        button.partytargets[num]:SetValue(1)
      else
        button.partytargets[num]:SetValue(0)
      end
      if not button.partytargets[num]:IsVisible() then button.partytargets[num]:Show() end
    end
  end
end

----------------------
--Get Max unit
function Proximo:GetMaxUnit()
  if db.grow and not in_bg_zone() then
    local asize, hsize = 0, 0
    if type(string_match(select(3,GetWorldStateUIInfo(1)) or "0", "%d")) == "number" then
      asize = string_match(select(3,GetWorldStateUIInfo(1)) or "0", "%d")
    end
    if type(string_match(select(3,GetWorldStateUIInfo(2)) or "0", "%d")) == "number" then
      hsize = string_match(select(3,GetWorldStateUIInfo(2)) or "0", "%d")
    end
    local psize = GetNumPartyMembers()+1
    local partysize = max(asize, hsize, psize)
    local unit = current_unit
    unit = unit > partysize and unit or partysize
    return unit
  else
    return max_unit_size
  end
end