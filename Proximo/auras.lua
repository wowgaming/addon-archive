local Proximo = Proximo

local COMBAT_EVENTS = Proximo.COMBAT_EVENTS

local spellname = function(id)
  local name = GetSpellInfo(id)
  return name
end

local spell_list = {
  --druid
  [spellname(33786)] = 6, --Cyclone
  [spellname(339)] = 10, --Entangling Roots
  [spellname(2637)] = 10, --Hibernate
  --hunter
  [spellname(34692)] = 18, --The Beast Within
  [spellname(3355)] = 10, --Freezing Trap Effect
  --mage
  [spellname(45438)] = 10, --Ice Block
  [spellname(118)] = 10, --Polymorph
  [spellname(122)] = 8, --Frost Nova
  --[spellname(28272)] = 10, --Polymorph: Pig
  --[spellname(28271)] = 10, --Polymorph: Turtle
  --paladin
  [spellname(642)] = 12, --Divine Shield
  [spellname(1022)] = 10, --Blessing of Protection
  [spellname(1044)] = 10, --Blessing of Freedom
  --priest
  [spellname(33206)] = 8, --Pain Suppression
  [spellname(8122)] = 8, --Psychic Scream
  --rogue
  [spellname(6770)] = 10, --Sap
  [spellname(2094)] = 10, --Blind
  --shaman
  [spellname(2825)] = 40, --Bloodlust
  [spellname(32182)] = 40, --Heroism
  --warlock
  [spellname(5782)] =10, --Fear
  [spellname(6789)] = 3, --Death Coil
  [spellname(6358)] =10, --Seduction
  [spellname(5484)] = 8, --Howl of Terror
  --warrior
  [spellname(5246)] = 8, --Intimidating Shout
  --generic
  [spellname(746)] = 8, --First Aid
  [spellname(12051)] = 8, --Evocation
}

function Proximo:RegisterAuras()
  COMBAT_EVENTS["SPELL_AURA_APPLIED"] = "BUFF"
  COMBAT_EVENTS["SPELL_PERIODIC_AURA_APPLIED"] = "BUFF"
  COMBAT_EVENTS["SPELL_AURA_APPLIED_DOSE"] = "BUFF"
  COMBAT_EVENTS["SPELL_PERIODIC_AURA_APPLIED_DOSE"] = "BUFF"
  COMBAT_EVENTS["SPELL_AURA_REMOVED"] = "FADE"
  COMBAT_EVENTS["SPELL_PERIODIC_AURA_REMOVED"] = "FADE"
  COMBAT_EVENTS["SPELL_AURA_REMOVED_DOSE"] = "FADE"
  COMBAT_EVENTS["SPELL_PERIODIC_AURA_REMOVED_DOSE"] = "FADE"
end

function Proximo:UnregisterAuras()
  COMBAT_EVENTS["SPELL_AURA_APPLIED"] = nil
  COMBAT_EVENTS["SPELL_PERIODIC_AURA_APPLIED"] = nil
  COMBAT_EVENTS["SPELL_AURA_APPLIED_DOSE"] = nil
  COMBAT_EVENTS["SPELL_PERIODIC_AURA_APPLIED_DOSE"] = nil
  COMBAT_EVENTS["SPELL_AURA_REMOVED"] = nil
  COMBAT_EVENTS["SPELL_PERIODIC_AURA_REMOVED"] = nil
  COMBAT_EVENTS["SPELL_AURA_REMOVED_DOSE"] = nil
  COMBAT_EVENTS["SPELL_PERIODIC_AURA_REMOVED_DOSE"] = nil
end

function Proximo:AuraApplied(unit, name, class, spell, icon)
  if spell_list[spell] then
    self:HandleAuraGain(unit, icon, spell_list[spell])
    if self.db.profile.announceauragain then
      local announcement = name..": ++ "..spell.."++"
      local r, g, b = self:GetClassColor(class)
      self:SendAnnouncement(announcement, r, g, b, icon)
    end
  end
end

function Proximo:AuraRemoved(unit, name, class, spell, icon)
  if spell_list[spell] then
    self:HandleAuraFade(unit, icon)
    if self.db.profile.announceaurafade then
      local announcement = name..": -- "..spell.."--"
      local r, g, b = self:GetClassColor(class)
      self:SendAnnouncement(announcement, r, g, b, icon)
    end
  end
end

function Proximo:HandleAuraGain(unit, icon, time)
  local frame = self.frame.buttons[unit].aura
  frame.icon:SetTexture(icon)
  frame.icon:SetTexCoord(0,0,0,1,1,0,1,1)
  frame.text:SetText(time)
  frame.time = time
  frame:Show()
end

function Proximo:HandleAuraFade(unit, icon)
  local frame = self.frame.buttons[unit].aura
  if frame.icon:GetTexture() == icon then
    self:AuraFade(frame)
  end
end

function Proximo:AuraFade(frame)
  frame.icon:SetTexture(nil)
  frame.text:SetText(nil)
  frame.time = nil
  frame:Hide()
end