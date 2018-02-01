local EavesDrop = EavesDrop
local db
local chardb

local OUTGOING = 1
local INCOMING = -1
local CRIT = 2
local NONCRIT = -2

local L = LibStub("AceLocale-3.0"):GetLocale("EavesDrop", true)
local sort_table
local display_type = OUTGOING
local display_sub_type = "hit"
local arrHistoryFrames  = {}
local arrDisplaySize = 10

local string_format = string.format

----------------------
-- append date and time to event
local function geteventtime(arg1)
  return string.format('|cffffffff%s|r\n%s', date('%x %I:%M:%S'), arg1 or '')
end

------------------------------
--Copy table to table
--Taken from AceDB. Using till AceDB support character to character
local function copyTable(from, to)
	setmetatable(to, nil)
	for k,v in pairs(from) do
		if type(k) == "table" then
			k = copyTable({}, k)
		end
		if type(v) == "table" then
			v = copyTable({}, v)
		end
		to[k] = v
	end
	setmetatable(to, from)
	return to
end

----------------------
-- track highest stats
function EavesDrop:SetDisplay(type, sub_type)
  display_type = type
  display_sub_type = sub_type
  --reset sorted table
  sort_table = nil
  FauxScrollFrame_SetOffset(EavesDropHistoryScrollBar,0)
  EavesDrop:ScrollBar_Update()
end

----------------------
-- track highest stats
function EavesDrop:TrackStat(type, hitheal, spell, icon, school, amount, crit, message)
  -- if its not enabled
  if db["HISTORY"] == false then
    return false
  end

  local key, critkey
  --set key
  if (type == OUTGOING) or (hitheal == "heal") then
    key = spell or MELEE_ATTACK
  else
    key = school or MELEE_ATTACK
  end

  --set crit type
  if (crit) then
    critkey = CRIT
  else
    critkey = NONCRIT
  end

  --check if type exists
  if (chardb[type][hitheal] == nil) then
    chardb[type][hitheal] = {}
  end
  --check if skill/key exists
  if (chardb[type][hitheal][key] == nil) then
    chardb[type][hitheal][key] = {
      [CRIT] = {},
      [NONCRIT] = {},
    }
    --reset sorted table
    sort_table = nil
  end
  --see if its a higher event
  if ((chardb[type][hitheal][key][critkey].amount == nil) or (amount >chardb[type][hitheal][key][critkey].amount)) then
    chardb[type][hitheal][key][critkey].amount = amount
    chardb[type][hitheal][key][critkey].time = geteventtime(message)
    chardb[type][hitheal][key].icon = icon
    self:ScrollBar_Update()
    return true
  end
  return false
end

----------------------
-- update scroll bar settings
function EavesDrop:ScrollBar_Update()
  local i,j,k, idx, skill, hit, crit, row, key, value, texture, tip1,tip2
  local offset = FauxScrollFrame_GetOffset(EavesDropHistoryScrollBar)
  --get table size, getn doesn't work cause not an array
  local size = 0
  local current_table = chardb[display_type][display_sub_type]
  --if not sorted, sort now
  if (sort_table == nil) then
    sort_table = {}
    if current_table then
      table.foreach(current_table, function (k) table.insert (sort_table, k) end )
    end
    table.sort(sort_table)
  end
  size = #sort_table
  --get update
  FauxScrollFrame_Update(EavesDropHistoryScrollBar, size, 10, 16)
  --loop thru each display item
  for i=1,arrDisplaySize do
    row = arrHistoryFrames[i].row
    texture = arrHistoryFrames[i].texture
    skill = arrHistoryFrames[i].skill
    hit = arrHistoryFrames[i].hit
    crit = arrHistoryFrames[i].crit
    idx = offset+i
    if idx<=size then
      k,key = next(sort_table)
      for j=2,idx do
        k,key = next(sort_table, k)
      end
      texture:SetTexture(current_table[key].icon)
      texture:SetTexCoord(.1,.9,.1,.9)
      skill:SetText(key)
      hit:SetText(current_table[key][NONCRIT].amount)
      crit:SetText(current_table[key][CRIT].amount)
      tip1 = current_table[key][NONCRIT].time or ""
      tip2 = current_table[key][CRIT].time or ""
      row.tooltipText = tip1.."\n\n"..tip2
      row.tooltipText1 = tip1
      row.tooltipText2 = tip2
      row:Show()
    else
      row:Hide()
    end
  end
end

----------------------
-- Reset all history
function EavesDrop:ResetHistory()
  self.chardb:ResetProfile()
  self:SetDisplay(OUTGOING, "hit")
end

----------------------
-- Setup history UI
function EavesDrop:SetupHistory()
  --setup table for history frame objects
  for i=1, arrDisplaySize do
    arrHistoryFrames[i] = {}
    arrHistoryFrames[i].row = getglobal(string_format("EavesDropHistoryEvent%d", i))
    arrHistoryFrames[i].texture = getglobal(string_format("EavesDropHistoryEvent%d_Texture", i))
    arrHistoryFrames[i].skill = getglobal(string_format("EavesDropHistoryEvent%d_Skill", i))
    arrHistoryFrames[i].hit = getglobal(string_format("EavesDropHistoryEvent%d_Hit", i))
    arrHistoryFrames[i].crit = getglobal(string_format("EavesDropHistoryEvent%d_Crit", i))
  end
  --local the profile table
  db = self.db.profile
  chardb = self.chardb.profile
  --Labels
  EavesDropHistoryFrameSkillText:SetText(L["Skill"])
  EavesDropHistoryFrameAmountCritText:SetText(L["Crit"])
  EavesDropHistoryFrameAmountNormalText:SetText(L["Normal"])
  r,g,b,a = db["LABELC"].r, db["LABELC"].g, db["LABELC"].b, db["LABELC"].a
  EavesDropHistoryFrameSkillText:SetTextColor(r,g,b,a)
  EavesDropHistoryFrameAmountCritText:SetTextColor(r,g,b,a)
  EavesDropHistoryFrameAmountNormalText:SetTextColor(r,g,b,a)
  --Buttons
  EavesDropHistoryFrameOutgoingHit.tooltipText = L["OutgoingDamage"]
  EavesDropHistoryFrameOutgoingHeal.tooltipText = L["OutgoingHeals"]
  EavesDropHistoryFrameIncomingHit.tooltipText = L["IncomingDamge"]
  EavesDropHistoryFrameIncomingHeal.tooltipText = L["IncomingHeals"]
  EavesDropHistoryButton.tooltipText = L["History"]
  EavesDropHistoryFrameResetText:SetText(L["Reset"])
  --Frame
  local r,g,b,a = db["FRAME"].r, db["FRAME"].g, db["FRAME"].b, db["FRAME"].a
  EavesDropHistoryFrame:SetBackdropColor(r, g, b, a)
  EavesDropHistoryTopBar:SetGradientAlpha("VERTICAL", r*.1, g*.1, b*.1, 0, r*.2, g*.2, b*.2, a)
  EavesDropHistoryBottomBar:SetGradientAlpha("VERTICAL", r*.2, g*.2, b*.2, a, r*.1, g*.1, b*.1, 0)
  r,g,b,a = db["BORDER"].r, db["BORDER"].g, db["BORDER"].b, db["BORDER"].a
  EavesDropHistoryFrame:SetBackdropBorderColor(r, g, b, a)
  --position frame (have to schedule cause UI scale is still 1 for some reason during init)
  self:ScheduleTimer("PlaceHistoryFrame", .1, self)

  if EavesDropStatsDB.global and EavesDropStatsDB.global.Stats then
    copyTable(EavesDropStatsDB.global.Stats, chardb)
    EavesDropStatsDB.global = nil
  end
end

function EavesDrop:PlaceHistoryFrame()
  local frame, x, y = EavesDropHistoryFrame, db.hx, db.hy
  frame:ClearAllPoints()
  if x==0 and y==0 then
    frame:SetPoint("CENTER", UIParent, "CENTER")
  else
    local es = frame:GetEffectiveScale()
    frame:SetPoint("TOPLEFT", UIParent, "CENTER", x/es, y/es)
  end
end