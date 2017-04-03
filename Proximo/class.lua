local Proximo = Proximo
local PC = LibStub("AceLocale-3.0"):GetLocale("ProximoClass", true)

local RAID_CLASS_COLORS = RAID_CLASS_COLORS

-- race values taken from Examiner. For females, add 0.5 to "top" and "bottom".
local raceIcons = {
  ["Human"]   =   { 0/8, 1/8, 0/4, 1/4 },
  ["Dwarf"]   =   { 1/8, 2/8, 0/4, 1/4 },
  ["Gnome"]   =   { 2/8, 3/8, 0/4, 1/4 },
  ["NightElf"]  = { 3/8, 4/8, 0/4, 1/4 },
  ["Draenei"]   = { 4/8, 5/8, 0/4, 1/4 },
  ["Tauren"]    = { 0/8, 1/8, 1/4, 2/4 },
  ["Scourge"]   = { 1/8, 2/8, 1/4, 2/4 },
  ["Troll"]   =   { 2/8, 3/8, 1/4, 2/4 },
  ["Orc"]     =   { 3/8, 4/8, 1/4, 2/4 },
  ["BloodElf"]  = { 4/8, 5/8, 1/4, 2/4 },
};

--general code taken from BabbleClass-2.2
function Proximo:GetClassColor(class)
  class = string.upper(class)
  if RAID_CLASS_COLORS and RAID_CLASS_COLORS[class] then
    return RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
  else
    return 0.5, 0.5, 0.5
  end
end

--general code taken from BabbleClass-2.2
function Proximo:GetHexColor(r,g,b)
  return string.format("%02x%02x%02x", r * 255, g * 255, b * 255)
end

function Proximo:GetLocalClass(class)
  return PC[class]
end

function Proximo:FrameClass(frame,class,mana)
  local r,g,b = self:GetClassColor(class)
  frame.healthBar:SetStatusBarColor(r,g,b,1)
  frame.healthBar.bg:SetVertexColor(r,g,b)
  frame.healthBar.bg:Show()
  self:SetClassIcon(frame.icon, class)
  if frame.manaBar then
    if mana and class ~= "WARRIOR" and class ~= "ROGUE" then
      frame.manaBar:Show()
    else
      frame.manaBar:Hide()
    end
  end
end

function Proximo:SetClassIcon(texture, classname)
  local class = CLASS_BUTTONS[classname]
  if class and class[1] and class[2] and class[3] and class[4] then
    texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
    texture:SetTexCoord(class[1], class[2], class[3], class[4])
  else
    texture:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    texture:SetTexCoord(0,0,0,1,1,0,1,1)
  end
end

function Proximo:SetRaceIcon(texture, racename, sex)
  local race = raceIcons[racename]
  local sexoffset = (sex == 3 and 0.5 or 0)
  if race and race[1] and race[2] and race[3] and race[4] then
    texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races")
    texture:SetTexCoord(race[1], race[2], race[3]+sexoffset, race[4]+sexoffset)
  else
    texture:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    texture:SetTexCoord(0,0,0,1,1,0,1,1)
  end
end

function Proximo:SetAllRaceIcon()
  for k, v in pairs(self:GetList()) do
    self:SetRaceIcon(self.frame.buttons[v.unit].raceicon, v.race, v.sex)
  end
end

----------------------
--Send announcement
local c = {} --temp table to hold colors
function Proximo:SendAnnouncement(message, r,g,b, icon)
  local announce = self.db.profile.announce
  if announce == "disabled" then 
    return
  end
  if announce == "chat" then
    self:Print("|cff"..self:GetHexColor(r,g,b)..message.."|r")
  elseif announce == "sct" and SCT then
    c.r, c.g, c.b = r,g,b
    SCT:DisplayCustomEvent(message, c, 1, 1, 1, icon)
  elseif announce == "msbt" and MikSBT then
    MikSBT.DisplayMessage(message, MikSBT.DISPLAYTYPE_NOTIFICATION, true, r*255,g*255,b*255)
  elseif announce == "party" then
    SendChatMessage(message, "PARTY")
  elseif announce == "fct" and CombatText_AddMessage then 
    CombatText_AddMessage(message, COMBAT_TEXT_SCROLL_FUNCTION, r, g, b, "crit")
  else
    c.r, c.g, c.b = r,g,b
    RaidNotice_AddMessage(RaidBossEmoteFrame, message, c)
  end
end
