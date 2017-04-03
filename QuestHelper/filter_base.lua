QuestHelper_File["filter_base.lua"] = "1.4.1"
QuestHelper_Loadtime["filter_base.lua"] = GetTime()

local avg_level = UnitLevel("player")
local count = 1

function QH_Filter_Group_Sync()
  avg_level = UnitLevel("player")
  count = 1
  
  if not QuestHelper_Pref.solo then
    if GetNumRaidMembers() > 0 then
      avg_level = 0
      count = 0
      -- we is in a raid
      for i = 1, 40 do
        local liv = UnitLevel(string.format("raid%d", i))
        if liv >= 1 then
          avg_level = avg_level + liv
          count = count + 1
        end
      end
    elseif GetNumPartyMembers() > 0 then
      -- we is in a party
      for i = 1, 4 do
        local liv = UnitLevel(string.format("party%d", i))
        if liv >= 1 then
          avg_level = avg_level + liv
          count = count + 1
        end
      end
    end
  end
  
  if count == 0 then -- welp
    QuestHelper:TextOut("This should never, ever happen. Please tell Zorba about it!")
    QuestHelper: Assert(false)
    avg_level = UnitLevel("player")
    count = 1
  end
  
  avg_level = avg_level / count
end

--[[
1
2 +2
3 +2
4 +2
5 +2 (+2 if dungeonflagged)
+6 and on: +15 (total of +25, the goal here is that, with default settings, lv60 raids shouldn't show up at lv80)
]]

local function VirtualLevel(avg_level, count, dungeonflag)
  QuestHelper: Assert(avg_level)
  if dungeonflag == nil and count == 5 then dungeonflag = true end -- "nil" is kind of "default"
  if count > 5 then dungeonflag = true end
  
  if count <= 5 then avg_level = avg_level + 2 * count - 2 end
  if count >= 5 and dungeonflag then avg_level = avg_level + 2 end
  if count > 5 then avg_level = avg_level + 15 end
  
  return avg_level
end

local filter_quest_level = QH_MakeFilter("filter_quest_level", function(obj)
  if not QuestHelper_Pref.filter_level then return end
  
  if not obj.type_quest then return end -- yeah it's fine
  
  if obj.type_quest.objectives > 0 and obj.cluster.type_quest_finish then return end
  
  local qtx
  if obj.type_quest.variety == GROUP then
    if obj.type_quest.groupsize > 0 then
      qtx = VirtualLevel(obj.type_quest.level, obj.type_quest.groupsize, false)
    else
      qtx = VirtualLevel(obj.type_quest.level, 5, false)  -- meh
    end
  elseif obj.type_quest.variety == LFG_TYPE_DUNGEON or obj.type_quest.variety == DUNGEON_DIFFICULTY2 then
    qtx = VirtualLevel(obj.type_quest.level, 5, true)
  elseif obj.type_quest.variety == LFG_TYPE_RAID then
    qtx = VirtualLevel(obj.type_quest.level, 25, true)
  else
    qtx = VirtualLevel(obj.type_quest.level, 1, false)
  end
  
  if qtx > VirtualLevel(avg_level, count) + QuestHelper_Pref.level then return true end -- bzzt
end, {friendly_reason = QHText("FILTERED_LEVEL"), friendly_name = "level"})

local filter_quest_group = QH_MakeFilter("filter_quest_group", function(obj)
  if not QuestHelper_Pref.filter_group then return end
  
  if not obj.type_quest then return end -- yeah it's fine
  if obj.type_quest.objectives > 0 and obj.cluster.type_quest_finish then return end
  if count > 1 and not QuestHelper_Pref.solo then return end
  
  local expected_players = 1
  if obj.type_quest.variety == GROUP then
    if obj.type_quest.groupsize > 0 then
      expected_players = obj.type_quest.groupsize
    else
      expected_players = 5
    end
  elseif obj.type_quest.variety == LFG_TYPE_DUNGEON or obj.type_quest.variety == ITEM_HEROIC then
    expected_players = 5
  elseif obj.type_quest.variety == LFG_TYPE_RAID then
    expected_players = 10
  end
  
  if expected_players > QuestHelper_Pref.filter_group_param then return true end
end, {friendly_reason = QHText("FILTERED_GROUP"), friendly_name = "group"})

local filter_quest_wintergrasp = QH_MakeFilter("filter_quest_wintergrasp", function(obj)
  if not QuestHelper_Pref.filter_wintergrasp then return end
  
  if not obj.type_quest then return end
  if obj.type_quest.objectives > 0 and obj.cluster.type_quest_finish then return end
  
  if QuestHelper.collect_rc and QuestHelper.collect_rz and QuestHelper_IndexLookup[QuestHelper.collect_rc] and QuestHelper_IndexLookup[QuestHelper.collect_rc][QuestHelper.collect_rz] == 74 then return end
  
  --print(obj.loc.p, obj.type_quest.variety, PVP, obj.type_quest.variety == PVP, obj.loc.p == 74 and obj.type_quest.variety == PVP)
  
  if obj.loc.p == 74 and obj.type_quest.variety == PVP then return true end
end, {friendly_reason = QHText("FILTERED_WINTERGRASP"), friendly_name = "wintergrasp"})

local filter_quest_done = QH_MakeFilter("filter_quest_done", function(obj)
  if not QuestHelper_Pref.filter_done then return end
  
  if not obj.type_quest then return end -- yeah it's fine
  if not obj.type_quest.done then return true end -- bzzt
end, {friendly_reason = QHText("FILTERED_COMPLETE"), friendly_name = "done"})

local filter_quest_watched = QH_MakeFilter("filter_quest_watched", function(obj)
  if not QuestHelper_Pref.filter_watched then return end
  
  if not obj.type_quest or not obj.type_quest.index then return end
  
  return not IsQuestWatched(obj.type_quest.index)
end, {friendly_reason = QHText("FILTERED_UNWATCHED"), friendly_name = "watched"})

local filter_quest_raid_accessible = QH_MakeFilter("filter_quest_raid_accessible", function(obj)
  if not QuestHelper_Pref.filter_raid_accessible then return end
  
  if not obj.type_quest then return end -- yeah it's fine
  if obj.type_quest.objectives > 0 and obj.cluster.type_quest_finish then return end  -- you can turn in non-raid quests while in a raid
  
  if obj.type_quest.variety == LFG_TYPE_RAID then return end  -- these are always okay
  if obj.type_quest.variety == PVP then return end -- these seem to be okay
  
  if not qh_hackery_fakeraid and GetNumRaidMembers() == 0 then return end -- s'all good, we're not in a raid anyway
  
  return true -- oh shit we're in a raid
end, {friendly_reason = QHText("FILTERED_RAID"), friendly_name = "raidaccessible"})

-- Delay because of beql which is a bitch.
QH_AddNotifier(GetTime() + 5, function ()
  local aqw_orig = AddQuestWatch -- yoink
  AddQuestWatch = function(...)
    QH_Route_Filter_Rescan("filter_quest_watched")
    return aqw_orig(...)
  end
  local rqw_orig = RemoveQuestWatch -- yoink
  RemoveQuestWatch = function(...)
    QH_Route_Filter_Rescan("filter_quest_watched")
    return rqw_orig(...)
  end
end)


local filter_zone = QH_MakeFilter("filter_zone", function(obj)
  if not QuestHelper_Pref.filter_zone then return end

  return obj.loc.p ~= QuestHelper.i
end, {friendly_reason = QHText("FILTERED_ZONE"), friendly_name = "zone"})

local filter_blocked = QH_MakeFilter("filter_blocked", function(obj, blocked)
  if not QuestHelper_Pref.filter_blocked then return end
  
  return blocked
end, {friendly_reason = QHText("FILTERED_BLOCKED"), friendly_name = "blocked"})

QH_Route_RegisterFilter(filter_quest_level, "filter_quest_level")
QH_Route_RegisterFilter(filter_quest_done, "filter_quest_done")
QH_Route_RegisterFilter(filter_quest_watched, "filter_quest_watched")
QH_Route_RegisterFilter(filter_quest_group, "filter_quest_group")
QH_Route_RegisterFilter(filter_quest_wintergrasp, "filter_quest_wintergrasp")
QH_Route_RegisterFilter(filter_quest_raid_accessible, "filter_quest_raid_accessible")
QH_Route_RegisterFilter(filter_zone, "filter_zone")
QH_Route_RegisterFilter(filter_blocked, "filter_blocked")




function qh_hackery_wackyland_enable()
  QH_WACKYLAND = true
  local filter_wackyland = QH_MakeFilter("filter_wackyland", function(obj)
    return math.random() < 0.5
  end, {friendly_reason = "wacky", friendly_name = "wacky"})
  QH_Route_RegisterFilter(filter_wackyland, "filter_wackyland")
end
