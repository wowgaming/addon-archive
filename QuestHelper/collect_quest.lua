QuestHelper_File["collect_quest.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_quest.lua"] = GetTime()

local debug_output = false
if QuestHelper_File["collect_quest.lua"] == "Development Version" then debug_output = true end

local IsMonsterGUID
local GetMonsterType

local GetQuestType
local GetItemType

local GetLoc
local GetSpecBolus

local QHCQ

local deebey

local function RegisterQuestData(category, location, GetQuestLogWhateverInfo)
  local index = 1
  local localspot
  while true do
    local ilink = GetQuestLogItemLink(category, index)
    if not ilink then break end
    
    if not localspot then if not location["items_" .. category] then location["items_" .. category] = {} end localspot = location["items_" .. category] end
    
    local name, tex, num, qual, usa = GetQuestLogWhateverInfo(index)
    localspot[GetItemType(ilink)] = num
    
    --QuestHelper:TextOut(string.format("%s:%d - %d %s %s", category, index, num, tostring(ilink), tostring(name)))
    
    index = index + 1
  end
end

local complete_suffix = string.gsub(string.gsub(string.gsub(ERR_QUEST_OBJECTIVE_COMPLETE_S, "%%s", ""), "%)", "%%)"), "%(", "%%(")
function pin()
  QuestHelper:TextOut("^.*: (%d+)/(%d+)(" .. complete_suffix .. ")?$")
end

-- qlookup[questname][objectivename] = {{qid = qid, objid = objid}}
local qlookups = {}

local function ScanQuests()
  
  local selected
  local index = 1
  
  local dbx = {}
  
  qlookups = {}
  
  while true do
    if not GetQuestLogTitle(index) then break end
    
    local qlink = GetQuestLink(index)
    if qlink then
      --QuestHelper:TextOut(qlink)
      --QuestHelper:TextOut(string.gsub(qlink, "|", "||"))
      local id, level = GetQuestType(qlink)
      local title, _, tag, groupcount, _, _, _, daily = GetQuestLogTitle(index)
      
      if not qlookups[title] then qlookups[title] = {} end  -- gronk
      
      --QuestHelper:TextOut(string.format("%s - %d %d", qlink, id, level))
      
      if not QHCQ[id] then
      --if true then
        if not selected then selected = GetQuestLogSelection() end
        SelectQuestLogEntry(index)
        
        QHCQ[id] = {}
        QHCQ[id].level = level
        
        RegisterQuestData("reward", QHCQ[id], GetQuestLogRewardInfo)
        RegisterQuestData("choice", QHCQ[id], GetQuestLogChoiceInfo)
        
        --QuestHelper:TextOut(string.format("%d", GetNumQuestLeaderBoards(index)))
        for i = 1, GetNumQuestLeaderBoards(index) do
          local desc, type = GetQuestLogLeaderBoard(i, index)
          QHCQ[id][string.format("criteria_%d_text", i)] = desc
          QHCQ[id][string.format("criteria_%d_type", i)] = type
          --QuestHelper:TextOut(string.format("%s, %s", desc, type))
        end
        
        QHCQ[id].name = title
        QHCQ[id].tag = tag
        QHCQ[id].groupcount = (groupcount or -1)
        QHCQ[id].daily = (not not daily)
        
        if GetQuestLogSpecialItemInfo then
          local typ = GetQuestLogSpecialItemInfo(index)
          if typ then typ = GetItemType(typ) end
          QHCQ[id].special_item = typ or false
        end
      end
      
      dbx[id] = {}
      
      
      --QuestHelper:TextOut(string.format("%d", GetNumQuestLeaderBoards(index)))
      
      for i = 1, GetNumQuestLeaderBoards(index) do
        local desc, _, done = GetQuestLogLeaderBoard(i, index)
        
        if not qlookups[title][desc] then qlookups[title][desc] = {} end
        table.insert(qlookups[title][desc], {qid = id, obj = i})
        
        -- If we wanted to parse everything here, we'd do something very complicated.
        -- Fundamentally, we don't. We only care if numeric values change or if something goes from "not done" to "done".
        -- Luckily, the patterns are identical in all cases for this (I think.)
        local have, needed = string.match(desc, "^.*: (%d+)/(%d+)$")
        have = tonumber(have)
        needed = tonumber(needed)
        
        --[[QuestHelper:TextOut(desc)
        QuestHelper:TextOut("^.*: (%d+)/(%d+)(" .. complete_suffix .. ")?$")
        QuestHelper:TextOut(string.gsub(desc, complete_suffix, ""))
        QuestHelper:TextOut(string.format("%s %s", tostring(have), tostring(needed)))]]
        if not have or not needed then
          have = done and 1 or 0
          needed = 1  -- okay so we don't really use this unless we're debugging, shut up >:(
        end
        
        dbx[id][i] = have
      end
    end
    
    index = index + 1
  end
  
  if selected then SelectQuestLogEntry(selected) end  -- abort abort bzzt bzzt bzzt awoooooooga dive, dive, dive
  
  return dbx
end

local eventy = {}

local function Looted(message)
  local ltype = GetItemType(message, true)
  table.insert(eventy, {time = GetTime(), event = string.format("I%di", ltype)})
  --if debug_output then QuestHelper:TextOut(string.format("Added event %s", string.format("I%di", ltype))) end
end

local function Combat(_, event, _, _, _, guid)
  if event ~= "UNIT_DIED" then return end
  if not IsMonsterGUID(guid) then return end
  local mtype = GetMonsterType(guid, true)
  table.insert(eventy, {time = GetTime(), event = string.format("M%dm", mtype)})
  --if debug_output then QuestHelper:TextOut(string.format("Added event %s", string.format("M%dm", mtype))) end
end

local changed = false
local first = true

local function Init()
  first = true
end

local function LogChanged()
  changed = true
end

local function WatchUpdate()  -- we're currently ignoring the ID of the quest that was updated for simplicity's sake.
  changed = true
end

local function AppendMember(tab, key, dat)
  tab[key] = (tab[key] or "") .. dat
end

local function StartOrEnd(se, id)
  local targuid = UnitGUID("target")
  local chunk = ""
  if targuid and IsMonsterGUID(targuid) then
    chunk = string.format("M%dm", GetMonsterType(targuid))
  end
  chunk = chunk .. GetLoc()
  
  AppendMember(QHCQ[id], se, chunk)
  AppendMember(QHCQ[id], se .. "_spec", GetSpecBolus())
end

local abandoncomplete = ""
local abandoncomplete_timestamp = nil

local GetQuestReward_Orig = GetQuestReward
GetQuestReward = function (...)
  abandoncomplete = "complete"
  abandoncomplete_timestamp = GetTime()
  GetQuestReward_Orig(...)
end

local AbandonQuest_Orig = AbandonQuest
AbandonQuest = function ()
  abandoncomplete = "abandon"
  abandoncomplete_timestamp = GetTime()
  AbandonQuest_Orig()
end

local function UpdateQuests()

  do  -- this should once and for all fix this issue
    local foverride = true
    for _, _ in pairs(deebey) do
      foverride = false
    end
    if UnitLevel("player") == 1 then
      foverride = false
    end
    if foverride then foverride = true end
  end
  
  if first then deebey = ScanQuests() first = false end
  if not changed then return end
  changed = false
  
  local tim = GetTime()
  
  local noobey = ScanQuests()
  
  local traverse = {}
  
  local dsize, nsize = QuestHelper:TableSize(deebey), QuestHelper:TableSize(noobey)
  
  for k, _ in pairs(deebey) do traverse[k] = true end
  for k, _ in pairs(noobey) do traverse[k] = true end
  
  --[[
  if QuestHelper:TableSize(deebey) ~= QuestHelper:TableSize(noobey) then
    QuestHelper:TextOut(string.format("%d %d", QuestHelper:TableSize(deebey), QuestHelper:TableSize(noobey)))
  end]]
  
  while #eventy > 0 and eventy[1].time < GetTime() - 1 do table.remove(eventy, 1) end -- slurp
  local token
  local debugtok
  
  local diffs = 0
  
  for k, _ in pairs(traverse) do
    if not deebey[k] then
      -- Quest was acquired
      if debug_output then QuestHelper:TextOut(string.format("Acquired! Questid %d", k)) end
      StartOrEnd("start", k)
      diffs = diffs + 1
      
    elseif not noobey[k] then
      -- Quest was dropped or completed
      if abandoncomplete == "complete" and abandoncomplete_timestamp + 30 >= GetTime() then
        if debug_output then QuestHelper:TextOut(string.format("Completed! Questid %d", k)) end
        StartOrEnd("end", k)
        abandoncomplete = ""
      else
        if debug_output then QuestHelper:TextOut(string.format("Dropped! Questid %d", k)) end
      end
      
      diffs = diffs + 1
      
    else
      QuestHelper: Assert(#deebey[k] == #noobey[k], string.format("%d vs %d, %d", #deebey[k], #noobey[k], k))
      for i = 1, #deebey[k] do
      
      --[[
        if not (noobey[k][i] >= deebey[k][i]) then
          QuestHelper:TextOut(string.format("%s, %s", type(noobey[k][i]), type(deebey[k][i])))
          QuestHelper:TextOut(string.format("%d, %d", noobey[k][i], deebey[k][i]))
          for index = 1, 100 do
            local qlink = GetQuestLink(index)
            if qlink then qlink = GetQuestType(qlink) end
            if qlink == k then
              QuestHelper:TextOut(GetQuestLogLeaderBoard(i, index))
            end
          end
        end
        QuestHelper: Assert(noobey[k][i] >= deebey[k][i]) -- man I hope this is true]]  -- This entire section can fail if people throw away quest items, or if quest items have a duration that expires. Sigh.
        
        if noobey[k][i] > deebey[k][i] then
          if not token then
            token = ""
            for k, v in pairs(eventy) do token = token .. v.event end
            debugtok = token
            token = token .. "L" .. GetLoc() .. "l"
          end
          
          local ttok = token
          if noobey[k][i] - 1 ~= deebey[k][i] then
            ttok = string.format("C%dc", noobey[k][i] - deebey[k][i]) .. ttok
          end
          
          AppendMember(QHCQ[k], string.format("criteria_%d_satisfied", i), ttok)
          
          if debug_output then QuestHelper:TextOut(string.format("Updated! Questid %d item %d count %d tok %s", k, i, noobey[k][i] - deebey[k][i], debugtok)) end
          diffs = diffs + 1
        end
      end
    end
  end
  
  deebey = noobey
  
  --QuestHelper: Assert(diffs <= 5, string.format("excessive quest diffs - delta is %d, went from %d to %d", diffs, dsize, nsize))
  --QuestHelper:TextOut(string.format("done in %f", GetTime() - tim))
end

local enable_quest_hints = GetBuildInfo():match("0%.1%..*") or (GetBuildInfo():match("3%..*") and not GetBuildInfo():match("3%.0%..*"))
QH_filter_hints = false

local function MouseoverUnit()
  QH_filter_hints = false
  if not enable_quest_hints then return end
  
  if GameTooltip:GetUnit() and UnitExists("mouseover") and UnitIsVisible("mouseover") and not UnitIsPlayer("mouseover") and not UnitPlayerControlled("mouseover") then
    local guid = UnitGUID("mouseover")
    
    if not IsMonsterGUID(guid) then return end
    
    guid = GetMonsterType(guid)
    
    if GetQuestLogSpecialItemInfo then
      for _, v in pairs(qlookups) do
        for _, block in pairs(v) do
          for _, tv in ipairs(block) do
            if not QHCQ[tv.qid][string.format("criteria_%d_monster_true", tv.obj)] then
              QHCQ[tv.qid][string.format("criteria_%d_monster_true", tv.obj)] = {}
              QHCQ[tv.qid][string.format("criteria_%d_monster_false", tv.obj)] = {}
            end
            
            QHCQ[tv.qid][string.format("criteria_%d_monster_false", tv.obj)][guid] = (QHCQ[tv.qid][string.format("criteria_%d_monster_false", tv.obj)][guid] or 0) + 1
          end
        end
      end
    
      local line = 2
      local qs
      local qe
      
      while _G["GameTooltipTextLeft" .. line] and _G["GameTooltipTextLeft" .. line]:IsShown() do
        local r, g, b, a = _G["GameTooltipTextLeft" .. line]:GetTextColor()
        r, g, b, a = math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5), math.floor(a * 255 + 0.5)
        --print(r, g, b, a)
        
        if r == 255 and g == 210 and b == 0 and a == 255 then
          if not qs then qs = line end
        else
          if qs and not qe then qe = line end
        end
        line = line + 1
      end
      
      if qs and not qe then qe = line end
      if qe then qe = qe - 1 end
      
      if qs and qe then
        local cquest = nil
        
        QH_filter_hints = true
        
        for i = qs, qe do
          local lin = _G["GameTooltipTextLeft" .. i]:GetText()
          
          if cquest and cquest[lin] then
            local titem_block = cquest[lin]
            for _, titem in pairs(titem_block) do
              QHCQ[titem.qid][string.format("criteria_%d_monster_false", titem.obj)][guid] = (QHCQ[titem.qid][string.format("criteria_%d_monster_false", titem.obj)][guid] or 0) - 1
              QHCQ[titem.qid][string.format("criteria_%d_monster_true", titem.obj)][guid] = (QHCQ[titem.qid][string.format("criteria_%d_monster_true", titem.obj)][guid] or 0) + 1
            end
          elseif qlookups[lin] then
            cquest = qlookups[lin]
          else
            QH_filter_hints = false
            --QuestHelper: Assert()
          end
        end
      end
    end
  end
end

function QH_Collect_Quest_Init(QHCData, API)
  if not QHCData.quest then QHCData.quest = {} end
  QHCQ = QHCData.quest
  
  GetQuestType = API.Utility_GetQuestType
  GetItemType = API.Utility_GetItemType
  IsMonsterGUID = API.Utility_IsMonsterGUID
  GetMonsterType = API.Utility_GetMonsterType
  GetSpecBolus = API.Utility_GetSpecBolus
  QuestHelper: Assert(GetQuestType)
  QuestHelper: Assert(GetItemType)
  QuestHelper: Assert(IsMonsterGUID)
  QuestHelper: Assert(GetMonsterType)
  QuestHelper: Assert(GetSpecBolus)
  
  GetLoc = API.Callback_LocationBolusCurrent
  QuestHelper: Assert(GetLoc)
  
  deebey = ScanQuests()
  
  QH_Event("UNIT_QUEST_LOG_CHANGED", LogChanged)
  QH_Event("QUEST_LOG_UPDATE", UpdateQuests)
  QH_Event("QUEST_WATCH_UPDATE", WatchUpdate)
  
  QH_Event("CHAT_MSG_LOOT", Looted)
  QH_Event("COMBAT_LOG_EVENT_UNFILTERED", Combat)
  
  API.Registrar_TooltipHook(MouseoverUnit)
  
  -- Here's a pile of events that seem to trigger during startup that also don't seem like would trigger while questing.
  -- We'll lose a few quest updates from this, but that's OK.
  QH_Event("PLAYER_ENTERING_WORLD", Init)
  QH_Event("UNIT_MODEL_CHANGED", Init)
  QH_Event("GUILDBANK_UPDATE_WITHDRAWMONEY", Init)
  QH_Event("UPDATE_TICKET", Init)
end
