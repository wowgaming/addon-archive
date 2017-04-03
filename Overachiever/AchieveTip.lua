
local L = OVERACHIEVER_STRINGS

local AbbreviateLargeQuantities = true

local PlayerGUID

local spaced  -- tracked to avoid adding an empty line (" ") when unnecessary
local lLineText
local DEFAULTCOLORS = { r = 0.741, g = 1, b = 0.467 }
local GREEN = { r = 0.25, g = 0.75, b = 0.25 }
local GREY = { r = 0.5, g = 0.5, b = 0.5 }
local lLineColors = DEFAULTCOLORS

local function isLastLineEmpty(tooltip)
-- This check is needed because default achievement tooltips are inconsistent:
-- Some put an extra blank line at the end; others don't.
  local n, i = tooltip:GetName(), tooltip:NumLines()
  local left = _G[n.."TextLeft"..i]
  left = left:GetText() or ""
  left = strtrim(left)
  if (left ~= "") then  return false;  end
  local right = _G[n.."TextRight"..i]
  right = right:GetText() or ""
  right = strtrim(right)
  return (right == "")
end

local function addline(tooltip, textL, textR, colors)
  if (not spaced) then
    if (not isLastLineEmpty(tooltip)) then  tooltip:AddLine(" ");  end
    spaced = true
  end
  colors = colors or DEFAULTCOLORS
  if (textR == true) then
    if (lLineText) then
      tooltip:AddLine(lLineText, lLineColors.r, lLineColors.g, lLineColors.b)
      lLineText = nil
    end
    tooltip:AddLine( (textL or " "), colors.r, colors.g, colors.b )
  elseif (textR) then
    if (lLineText) then
      if (textL) then
        tooltip:AddLine(lLineText, lLineColors.r, lLineColors.g, lLineColors.b)
        lLineColors = colors
      else
        textL = lLineText
      end
      lLineText = nil
    end
    tooltip:AddDoubleLine( (textL or " "), textR, lLineColors.r, lLineColors.g, lLineColors.b, colors.r, colors.g, colors.b )
  elseif (textL) then  -- and not textR
    if (lLineText) then
      tooltip:AddDoubleLine(lLineText, textL, lLineColors.r, lLineColors.g, lLineColors.b, colors.r, colors.g, colors.b)
      lLineText = nil
    else
      lLineText, lLineColors = textL, colors
    end
  else  -- not textL and not textR
    if (lLineText) then
      tooltip:AddLine(lLineText, lLineColors.r, lLineColors.g, lLineColors.b)
      lLineText = nil
    end
  end
end

local function addline_format(tooltip, label, value, labelR, valueR)
  local textL = value and "|cff7eff00"..label..":|r "..value
  local textR = valueR and "|cff7eff00"..labelR..":|r "..valueR
  addline(tooltip, textL, textR)
end

local function getProgressString(q, t, qs)
  if (qs and strfind(qs, "/")) then  return qs;  end
  if (t > 1) then
    if (AbbreviateLargeQuantities) then
      q = q < 1000 and q or floor(q / 1000).."k"
      t = t < 1000 and t or floor(t / 1000).."k"
    end
    return q.."/"..t;
  end
end

local function AppendProgressToTooltip(tooltip, id, GUID)
  local text = (PlayerGUID == GUID) and L.PROGRESS or L.YOURPROGRESS;
  local _, _, completed, quantity, totalQuantity, _, _, _, quantityString = GetAchievementCriteriaInfo(id, 1);
  quantityString = getProgressString(quantity, totalQuantity, quantityString)
  if (quantityString) then
    addline_format(tooltip, text, quantityString)
    return (completed or select(4,GetAchievementInfo(id)))
  end
end

local function InsertProgressInTooltip(tooltip, id)
  local line, text
  local name, maxlines = tooltip:GetName(), tooltip:NumLines()
  -- Start checking at 6 in case the ach. description matches the crit. desc., unless there are so few lines that
  -- the crit. description likely isn't showing anyway.
  local linenum = maxlines <= 6 and 2 or 6
  local criteriaString, _, completed, quantity, totalQuantity, quantityString
  local inserted, insertfailed
  for crit=1,GetAchievementNumCriteria(id) do
    criteriaString, _, completed, quantity, totalQuantity, _, _, _, quantityString = GetAchievementCriteriaInfo(id, crit);
    if (not completed) then
      quantityString = getProgressString(quantity, totalQuantity, quantityString)
      if (quantityString) then
        while linenum <= maxlines do
          line = _G[name.."TextLeft"..linenum]
          text = line:GetText()
          if (text ~= criteriaString) then
            line = _G[name.."TextRight"..linenum]
            text = line:GetText()
            if (text == criteriaString) then
              linenum = linenum + 1
            end
          end
          if (text == criteriaString) then
            line:SetText(text.." ("..quantityString..")")
            inserted = true
            break;
          end
          linenum = linenum + 1
        end
        if (not inserted) then  insertfailed = true;  end
      end
    end
  end
  return not insertfailed;
end

local function AppendCriteriaProgress(tooltip, id)
  addline(tooltip, "|cff7eff00"..L.YOURPROGRESS..":|r", true)
  local criteriaString, _, completed, quantity, totalQuantity, quantityString
  for crit=1,GetAchievementNumCriteria(id) do
    criteriaString, _, completed, quantity, totalQuantity, _, _, _, quantityString = GetAchievementCriteriaInfo(id, crit);
    if (completed) then
      quantityString = ""
    else
      quantityString = getProgressString(quantity, totalQuantity, quantityString)
      quantityString = quantityString and " ("..quantityString..")" or ""
    end
    addline( tooltip, criteriaString..quantityString, nil, (completed and GREEN or GREY) )
  end
  addline(tooltip)
end

function Overachiever.ExamineAchievementTip(tooltip, link)
  if ( tooltip:NumLines() > 0 and (Overachiever_Settings.Tooltip_ShowProgress or
       Overachiever_Settings.Tooltip_ShowProgress_Other or Overachiever_Settings.Tooltip_ShowID) ) then
    local _, _, id = strfind(link, "achievement:(.+):")
    if (id) then
      PlayerGUID = PlayerGUID or strsub(UnitGUID("player"), 3)
      local GUID
      id, GUID = strsplit(":", id);
      if (Overachiever.DEBUG_NoPlayerGUID) then  GUID = "NotMe";  end
      id = tonumber(id)
      if (id) then
        spaced, lLineText = nil, nil
        local progresscompleted
        if ( (PlayerGUID == GUID and Overachiever_Settings.Tooltip_ShowProgress) or
             (PlayerGUID ~= GUID and Overachiever_Settings.Tooltip_ShowProgress_Other) ) then
          if (PlayerGUID ~= GUID and select(4,GetAchievementInfo(id))) then
          -- Link from someone else to an achievement you completed:
            local _, _, _, _, m, d, y = GetAchievementInfo(id)
            addline_format(tooltip, L.YOURPROGRESS, L.COMPLETEDATE:format(d, m, y))
            progresscompleted = true
          else
            local inserted
            local numcrit = GetAchievementNumCriteria(id)
            if (PlayerGUID == GUID and numcrit > 1) then
              inserted = InsertProgressInTooltip(tooltip, id)
            end
            if (not inserted) then
              if (numcrit < 1) then
                if (PlayerGUID ~= GUID) then
                  addline_format(tooltip, L.YOURPROGRESS, L.INCOMPLETE)
                end
              elseif (numcrit == 1) then
                progresscompleted = AppendProgressToTooltip(tooltip, id, GUID)
              elseif (PlayerGUID ~= GUID) then
                AppendCriteriaProgress(tooltip, id)
              end
            end
          end
        end
        if (Overachiever_Settings.Tooltip_ShowID) then
          addline_format(tooltip, nil, nil, "ID", id)
        end
        addline(tooltip)  -- Handle whatever hasn't actually been added to the tooltip yet.
        if (progresscompleted) then
          tooltip:AddTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready");
        end
        tooltip:Show()
      end
    end
  end
end
