QuestHelper_File["tooltip.lua"] = "1.4.1"
QuestHelper_Loadtime["tooltip.lua"] = GetTime()

if QuestHelper_File["tooltip.lua"] == "Development Version" then
  qh_hackery_nosuppress = true
end



local function DoTooltip(self, data, lines, prefix)
  local indent = 1
  
  if prefix then
    self:AddLine(("  "):rep(indent) .. prefix, 1, 1, 1)
    indent = indent + 1
  end
  
  --QuestHelper:TextOut(QuestHelper:StringizeTable(data))
  --QuestHelper:TextOut(QuestHelper:StringizeTable(lines))
  for _, v in ipairs(lines) do
    self:AddLine(("  "):rep(indent) .. v, 1, 1, 1)
    indent = indent + 1
  end
  self:AddLine(("  "):rep(indent) .. data.desc, 1, 1, 1)
  QuestHelper:AppendObjectiveProgressToTooltip(data, self, nil, indent + 1)
end

local function DoTooltipDefault(self, qname, text)
  self:AddLine("  " .. QHFormat("TOOLTIP_SLAY", text), 1, 1, 1)
  self:AddLine("    " .. QHFormat("TOOLTIP_QUEST", qname), 1, 1, 1)
end

local ctts = {}

-- Format:
-- { ["monster@@1234"] = {{"Slay for blah blah blah"}, (Objective)} }
-- ("Slay for" is frequently an empty table)
function QH_Tooltip_Canned_Add(tooltips)
  for k, v in pairs(tooltips) do
    local typ, id = k:match("([^@]+)@@([^@]+)")
    --[[print(k)
    for tk, tv in pairs(v[1]) do
      print("    ", 1, tk, tv)
    end
    for tk, tv in pairs(v[2]) do
      print("    ", 2, tk, tv)
    end]]
    QuestHelper: Assert(typ and id, k)
    if not ctts[typ] then ctts[typ] = {} end
    if not ctts[typ][id] then ctts[typ][id] = {} end
    QuestHelper: Assert(not ctts[typ][id][v[2]])
    ctts[typ][id][v[2]] = v[1]
  end
end
function QH_Tooltip_Canned_Remove(tooltips)
  for k, v in pairs(tooltips) do
    local typ, id = k:match("([^@]+)@@([^@]+)")
    QuestHelper: Assert(typ and id, k)
    QuestHelper: Assert(ctts[typ][id][v[2]])
    ctts[typ][id][v[2]] = nil
    
    local cleanup = true
    for _, _ in pairs(ctts[typ][id]) do
      cleanup = false
    end
    
    if cleanup then
      ctts[typ][id] = nil
    end
  end
end

local deferences = {}
local deference_default = {}  -- this is just a unique value that we can use to lookup

-- think about what we want out of this
-- If it matches quest/objective, we suppress it and show our canned text
-- If it matches quest, but has unknown objectives, we suppress it and show some synthesized "Canned thing, for Quest Blahblahblah"

-- tooltips is the same slay/objective pair in the above thing
function QH_Tooltip_Defer_Add(questname, objective, tooltips)
  --print("defer add", questname, objective)
  local objo = objective
  if not objective then objective = deference_default end
  
  if not deferences[questname] then deferences[questname] = {} end
  if not deferences[questname][objective] then deferences[questname][objective] = {} end
  
  for k, v in pairs(deferences[questname][objective]) do
    QuestHelper: Assert(v ~= tooltips)
  end
  table.insert(deferences[questname][objective], tooltips)
  
  --print("adding", questname, objective)
end
function QH_Tooltip_Defer_Remove(questname, objective, tooltips)
  local objo = objective
  if not objective then objective = deference_default end
  
  --print("remove", questname, objective)
  --print("removing", questname, objective, deferences[questname][objective])
  QuestHelper: Assert(deferences[questname][objective], string.format("%s %s %s", tostring(questname), tostring(objective), tostring(objo)))
  
  local remmed = false
  for k, v in pairs(deferences[questname][objective]) do
    if v == tooltips then
      table.remove(deferences[questname][objective], k)
      remmed = true
      break
    end
  end
  QuestHelper: Assert(remmed)
  
  if #deferences[questname][objective] == 0 then
    deferences[questname][objective] = nil
  end
  
  local cleanup = true
  for _ in pairs(deferences[questname]) do
    cleanup = false
  end
  
  if cleanup then
    deferences[questname] = nil
  end
end
function QH_Tooltip_Defer_Dump()
  for k, v in pairs(deferences) do
    print(k)
    for t, m in pairs(v) do
      print("  ", t, #m)
    end
  end
end

-- TODO: move this into some common file, I hate that I'm duplicating them but I just want this to work. entire codebase will need a going-over soon
local function IsMonsterGUID(guid)
  QuestHelper: Assert(#guid == 18, "guid len " .. guid) -- 64 bits, plus the 0x prefix
  QuestHelper: Assert(guid:sub(1, 2) == "0x", "guid 0x-prefix " .. guid)
  return guid:sub(5, 5) == "3" or guid:sub(5, 5) == "5"
end

local function GetMonsterType(guid)
  QuestHelper: Assert(#guid == 18, "guid len " .. guid) -- 64 bits, plus the 0x prefix
  QuestHelper: Assert(guid:sub(1, 2) == "0x", "guid 0x-prefix " .. guid)
  QuestHelper: Assert(guid:sub(5, 5) == "3" or guid:sub(5, 5) == "5", "guid 3-prefix " .. guid)  -- It *shouldn't* be a player or a pet by the time we've gotten here. If so, something's gone wrong.
  if GetBuildInfo():sub(1, 3) == "3.2" then
    return tonumber(guid:sub(9, 12), 16)  -- here's our actual identifier
  else
    return tonumber(guid:sub(7, 10), 16)  -- 3.3 and in the future, including 0.3.0
  end
end

local function GetItemType(link, vague)
  return tonumber(string.match(link,
    (vague and "" or "^") .. "|cff%x%x%x%x%x%x|Hitem:(%d+):[%d:-]+|h%[[^%]]*%]|h|r".. (vague and "" or "$") 
  ))
end

local function CopyOver(to, from)
  to:SetFont(from:GetFont())
  to:SetFontObject(from:GetFontObject())
  to:SetText(from:GetText())
  to:SetTextColor(from:GetTextColor())
  to:SetSpacing(from:GetSpacing())
  to:SetShadowOffset(from:GetShadowOffset())
  to:SetShadowColor(from:GetShadowColor())
  to:Show()
end

local sigil_bar = CreateFrame("Frame", GameTooltip)
sigil_bar:SetFrameStrata("TOOLTIP")
sigil_bar:SetPoint("LEFT", GameTooltip, "LEFT", 10, 0)
sigil_bar:SetPoint("RIGHT", GameTooltip, "RIGHT", -10, 0)
sigil_bar:SetHeight(0.5)
sigil_bar:SetFrameLevel(10)
sigil_bar:Hide()

local sigil_bar_filler = sigil_bar:CreateTexture()
sigil_bar_filler:SetTexture(1, 1, 1)
sigil_bar_filler:SetAllPoints()

local sigil = GameTooltip:CreateTexture()
sigil:SetParent(sigil_bar)
sigil:SetHeight(16)
sigil:SetWidth(16)
--sigil:SetPoint("CENTER", 0, 0)
sigil:SetTexture("Interface\\AddOns\\QuestHelper\\sigil")
sigil:SetPoint("TOPRIGHT", sigil_bar, "BOTTOMRIGHT", 2, -2)
local sigil_text
local sigil_item

local bar_split = 10

local fixes_src = {}
local fixes_returnto = {}
local fixes_from = {}

local function FixBlizzTooltip()
  for k = 1, #fixes_src do
    for i = 1, fixes_src[k]:GetNumPoints() do
      local point, relative, rlpoint, x, y = fixes_src[k]:GetPoint(i)
      if point == "TOPLEFT" then
        --print("recombining", y, fixes_returnto[k], y == fixes_from[k], fixes_from[k])
        y = fixes_returnto[k]
        fixes_src[k]:SetPoint(point, relative, rlpoint, x, y)
      end
    end
  end
  
  wipe(fixes_src)
  wipe(fixes_returnto)
  wipe(fixes_from)
end

local function cachechange(src, targ, dist, absolute)
  for i = 1, src:GetNumPoints() do
    local point, relative, rlpoint, x, y = src:GetPoint(i)
    if point == "TOPLEFT" and relative == targ then
      table.insert(fixes_src, src)
      table.insert(fixes_returnto, y)
      if absolute then y = dist else y = y - dist end
      table.insert(fixes_from, y)
      --print("caching", fixes_returnto[#fixes_returnto], y)
      src:SetPoint(point, relative, rlpoint, x, y)
    end
  end
end

local function StripBlizzQHTooltipClone(ttp)
  --do return end
  if not UnitExists("mouseover") then return end
  
  
  local changed = false
  local removed = 0
  
  local qobj = nil
  local qobj_name = nil
  
  local done = QuestHelper:CreateTable("tooltip")
  
  local linemax
  do
    local line = 2
    while _G["GameTooltipTextLeft" .. line] and _G["GameTooltipTextLeft" .. line]:IsShown() do
      linemax = line
      line = line + 1
    end
  end
  
  for line = 2, linemax do
    local r, g, b, a = _G["GameTooltipTextLeft" .. line]:GetTextColor()
    r, g, b, a = math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5), math.floor(a * 255 + 0.5)
    
    if qh_tooltip_print_a_lot then print(thistext, r, g, b, a, qobj) end
    
    local thistext = _G["GameTooltipTextLeft" .. line]:GetText()
    local hideme
    local thistextm = thistext:match(" %- (.*)")
    
    --print(thistext, thistextm)
    if qh_hackery_tooltip_verbosity then print(thistext, r, g, b, a, dereferences[thistext] and true or false, qobj and qobj[thistextm] and true or false, thistextm) end
    
    if r == 255 and g == 210 and b == 0 and a == 255 and deferences[thistext] then
      qobj = deferences[thistext]
      qobj_name = thistext
      hideme = true
    elseif r == 255 and g == 255 and b == 255 and a == 255 and qobj and thistextm and qobj[thistextm] then
      if not done[qobj[thistextm]] then
        done[qobj[thistextm]] = true -- Blizzard, why do you show duplicates of your *own quest objectives*?
        local ite = qobj[thistextm][1]
        QuestHelper: Assert(ite)
        
        local ttsplat = thistextm:match("(.*): ([0-9]+)/([0-9]+)")
        if ttsplat == ttp:GetUnit() then
          ttsplat = nil
        end
        DoTooltip(ttp, ite[2], ite[1], ttsplat and QHFormat("TOOLTIP_SLAY", ttsplat))
        hideme = true
      end
    elseif r == 255 and g == 255 and b == 255 and a == 255 and qobj and thistextm and not qobj[thistextm] and thistextm:find(":") then
      hideme = true -- it parses as an objective, but we don't know about it, so it's probably a completed objective. todo: actually store completed objectives.
    elseif r == 255 and g == 255 and b == 255 and a == 255 and qobj and thistextm and not thistextm:find(":") then  -- Blizzard cleverly does not suppress tooltips when the user has finished getting certain items, so we do instead
      DoTooltipDefault(ttp, qobj_name, thistextm)
      hideme = true
    end
  
    if hideme and not qh_hackery_nosuppress then
      _G["GameTooltipTextLeft" .. line]:SetText(nil)
      _G["GameTooltipTextLeft" .. line]:SetHeight(0)
      cachechange(_G["GameTooltipTextLeft" .. line], _G["GameTooltipTextLeft" .. (line - 1)], 1, true)
      changed = true
      removed = removed + 1
    end
  end
  
  if changed then
    ttp:Show()
  end
  
  local qhstart = linemax + 1
  if _G["GameTooltipTextLeft" .. qhstart] and _G["GameTooltipTextLeft" .. qhstart]:IsShown() then
    sigil_item = _G["GameTooltipTextLeft" .. qhstart]
    sigil_text = sigil_item:GetText()
    cachechange(sigil_item, _G["GameTooltipTextLeft" .. (qhstart - 1)], bar_split, false)
    sigil_bar:SetPoint("TOP", sigil_item, "TOP", 0, bar_split / 2)
    --sigil_bar:SetParent(sigil_item)
    --sigil:SetPoint("TOP", sigil_item, "TOP", 0, 3)
    --sigil:SetPoint("LEFT", GameTooltip, "LEFT")
    sigil_bar:Show()
    bar_boost = true
  end

  
  QuestHelper:ReleaseTable(done)
  
  return removed
end

local glob_strip = 0
function CreateTooltip(self)
  FixBlizzTooltip()
  
  glob_strip = 0
  bar_boost = nil
  
  if QuestHelper_Pref.tooltip then
    local inu, ilink = self:GetItem()
    local un, ulink = self:GetUnit()
    if ulink then ulink = UnitGUID(ulink) end
    
    --[[
    if ilink then
      local ite = tostring(GetItemType(ilink))
      
      if ctts["item"] and ctts["item"][ite] then
        DoTooltip(self, ctts["item"][ite])
      end
      
      self:Show()
    end]]
    
    if qh_tooltip_print_a_lot then print("wut", ulink, IsMonsterGUID(ulink)) print(ulink) print(IsMonsterGUID(ulink)) end
    if ulink and IsMonsterGUID(ulink) then
      if qh_tooltip_print_a_lot then print("huhwuzat") print(QH_filter_hints) end
      
      glob_strip = StripBlizzQHTooltipClone(self) or 0
      
      local ite = tostring(GetMonsterType(ulink))
      
      if ctts["monster"] and ctts["monster"][ite] then
        for data, lines in pairs(ctts["monster"][ite]) do
          DoTooltip(self, data, lines)
        end
      end
      
      self:Show()
    end
  end
end

local unit_to_adjust = nil

-- SmoothQuest and possibly others
QH_AddNotifier(GetTime() + 5, function ()
  local ottsu = GameTooltip:GetScript("OnTooltipSetUnit")
  QH_Hook(GameTooltip, "OnTooltipSetUnit", function (self, ...)
    if qh_tooltip_print_a_lot then print("lol") end
    CreateTooltip(self)
    if ottsu then QH_Hook_NotMyFault(ottsu, self, ...) end
    unit_to_adjust = self:GetUnit()
  end, "tooltip OnTooltipSetUnit")

  local ottsi = GameTooltip:GetScript("OnTooltipSetItem")
  QH_Hook(GameTooltip, "OnTooltipSetItem", function (self, ...)
    QH_Hook_NotMyFault(CreateTooltip, self)
    if ottsi then return QH_Hook_NotMyFault(ottsi, self, ...) end
  end, "tooltip OnTooltipSetItem")

  local ttsx = GameTooltip:GetScript("OnUpdate")
  QH_Hook(GameTooltip, "OnUpdate", function (self, ...)
    if sigil_bar:IsShown() then
      sigil_bar:SetAlpha(GameTooltip:GetAlpha())
      if not (sigil_bar:IsShown() and sigil_item and sigil_item:GetText() == sigil_text) then
        sigil_bar:Hide()
        FixBlizzTooltip()
      end
    end
    if ttsx then QH_Hook_NotMyFault(ttsx, self, ...) end
    if (glob_strip > 0 or bar_boost) and unit_to_adjust and unit_to_adjust == self:GetUnit() then
      self:SetHeight(self:GetHeight() - glob_strip * 3 + (bar_boost and bar_split or 0)) -- maaaaaagic
      unit_to_adjust = nil
    end
  end, "tooltip OnUpdate")
end)
