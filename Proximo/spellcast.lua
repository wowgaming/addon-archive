local Proximo = Proximo
local prox_list

local COMBAT_EVENTS = Proximo.COMBAT_EVENTS

local GetTime = GetTime
local UnitName = UnitName
local UnitCastingInfo = UnitCastingInfo
local UnitChannelInfo = UnitChannelInfo

function Proximo:RegisterSpells()
  COMBAT_EVENTS["SPELL_CAST_START"] = "CASTSTART"
  COMBAT_EVENTS["SPELL_SUMMON"] = "CASTSTART"
  COMBAT_EVENTS["SPELL_CREATE"] = "CASTSTART"
  COMBAT_EVENTS["SPELL_CAST_SUCCESS"] = "CASTEND"
  COMBAT_EVENTS["SPELL_CAST_FAILED"] = "CASTEND"
  COMBAT_EVENTS["SPELL_INTERRUPT"] = "INTERRUPT"
  self:RegisterEvent("UNIT_SPELLCAST_START")
  self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", "UNIT_SPELLCAST_START")
  self:RegisterEvent("UNIT_SPELLCAST_STOP")
  self:RegisterEvent("UNIT_SPELLCAST_FAILED", "UNIT_SPELLCAST_STOP")
  self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "UNIT_SPELLCAST_STOP")
  self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "UNIT_SPELLCAST_STOP")
  self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_INTERRUPTED", "UNIT_SPELLCAST_STOP")
  self:RegisterEvent("UNIT_SPELLCAST_DELAYED")
  self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "UNIT_SPELLCAST_DELAYED")
  if not prox_list then prox_list = self:GetList() end
end

function Proximo:UnregisterSpells()
  COMBAT_EVENTS["SPELL_CAST_START"] = nil
  COMBAT_EVENTS["SPELL_SUMMON"] = nil
  COMBAT_EVENTS["SPELL_CREATE"] = nil
  COMBAT_EVENTS["SPELL_CAST_SUCCESS"] = nil
  COMBAT_EVENTS["SPELL_CAST_FAILED"] = nil
  COMBAT_EVENTS["SPELL_INTERRUPT"] = nil
  self:UnregisterEvent("UNIT_SPELLCAST_START")
  self:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START")
  self:UnregisterEvent("UNIT_SPELLCAST_STOP")
  self:UnregisterEvent("UNIT_SPELLCAST_FAILED")
  self:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
  self:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
  self:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_INTERRUPTED")
  self:UnregisterEvent("UNIT_SPELLCAST_DELAYED")
  self:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
end

function Proximo:UNIT_SPELLCAST_START(event, unit)
  if unit ~= "target" and unit ~= "focus" then return end
  local name = UnitName(unit)
  if not prox_list[name] then return end

  local stype, spell, rank, displayName, icon, startTime, endTime
  if event == "UNIT_SPELLCAST_START" then
    stype, spell, rank, displayName, icon, startTime, endTime = 1, UnitCastingInfo(unit)
  else
    stype, spell, rank, displayName, icon, startTime, endTime = 2, UnitChannelInfo(unit)
  end
  if endTime then
    endTime = endTime / 1000
    self:SpellStart(prox_list[name].unit, spell, endTime-GetTime(), stype)
  end
end

function Proximo:UNIT_SPELLCAST_STOP(event, unit)
  if unit ~= "target" and unit ~= "focus" then return end
  local stype = 1
  if strfind(event, "CHANNEL") then stype = 2 end
  local name = UnitName(unit)
  if prox_list[name] then
    self:HandleSpellEnd(prox_list[name].unit, stype)
  end
end

function Proximo:UNIT_SPELLCAST_DELAYED(event, unit)
  if unit ~= "target" and unit ~= "focus" then return end
  local name = UnitName(unit)
  if not prox_list[name] then return end

  local spell, rank, displayName, icon, startTime, endTime
  if event == "UNIT_SPELLCAST_DELAYED" then
    spell, rank, displayName, icon, startTime, endTime = UnitCastingInfo(unit)
  else
    spell, rank, displayName, icon, startTime, endTime = UnitChannelInfo(unit)
  end
  if endTime then
    endTime = endTime / 1000
    self:SpellUpdate(prox_list[name].unit, endTime-GetTime())
  end
end

function Proximo:SpellStart(unit, spell, time, stype)
  local frame = self.frame.buttons[unit].spellBar
  frame.time = 0
  frame.maxtime = time
  frame.spell = spell
  frame.stype = stype
  if self.db.profile.spelltime then
    frame.format = "%s (%.1f)"
  else
    frame.format = "%s"
  end
  frame.text:SetFormattedText(frame.format, spell, 0)
  frame:SetMinMaxValues(0, time)
  frame:SetValue(0)
  frame:Show()
end

function Proximo:SpellUpdate(unit, timetoend)
  local frame = self.frame.buttons[unit].spellBar
  if frame.time and frame.maxtime then
    frame.time = frame.maxtime - timetoend
  end
end

function Proximo:HandleSpellEnd(unit, stype)
  local frame = self.frame.buttons[unit].spellBar
  if frame.stype == stype then
    self:SpellEnd(frame)
  end
end

function Proximo:SpellEnd(frame)
  frame.time = nil
  frame.maxtime = nil
  frame.spell = nil
  frame.stype = nil
  frame.format = nil
  frame.text:SetText(nil)
  frame:SetMinMaxValues(0, 0)
  frame:SetValue(0)
  frame:Hide()
end