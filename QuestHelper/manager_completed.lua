QuestHelper_File["manager_completed.lua"] = "1.4.1"
QuestHelper_Loadtime["manager_completed.lua"] = GetTime()

local completed_active = false
local rescan

function QH_Incomplete()
  if QueryQuestsCompleted then
    completed_active = not completed_active
    if completed_active then
      QuestHelper:TextOut("Activating incomplete quest list. Please check your map.")
    else
      QuestHelper:TextOut("Deactivating incomplete quest list.")
    end
    rescan()
  else
    QuestHelper:TextOut("This feature isn't available until the WoW 3.3 patch. Sorry!")
  end
end

if not QueryQuestsCompleted then return end


local quests = {}

local temp_notifications = {}

function QH_GetCompletedTable()
  return quests
end

local notifications = {}

function QH_AddCompletionNotifier(func)
  table.insert(notifications, func)
end

local function notify()
  for _, v in ipairs(notifications) do
    v(quests)
  end
end

local poll_again = true
local poll_timeout = GetTime() + 30
local poll_first = true

QH_Event("QUEST_QUERY_COMPLETE", function ()
  quests = GetQuestsCompleted() -- entertainingly, we actually want exactly the output of this. How convenient! Blizzard does things right <3 forever
  
  notify()
end)

local GetQuestReward_Orig = GetQuestReward
GetQuestReward = function (...)
  poll_again = true
  GetQuestReward_Orig(...)
end

QH_OnUpdate(function()
  if poll_again and poll_timeout < GetTime() then
    QueryQuestsCompleted()
    --print("QQC")
    poll_again = false
    poll_first = false
  end
end, "quest_completed")



-- now over here we're rigging up something to scatter waypoints all over the goddamn map
-- we're just tossing them out like sprinkles
-- neon lozenges, scattered upon the ground
-- colors across the leaves, sucrose stars hangin' out across the foliage
-- here comes a squirrel
-- oh look it is eating the candy! how adorable
-- we should take it home and keep it as a pet
-- now you understand waypoints.
-- Aloha.
local waypoint_zone

function rescan()
  if not waypoint_zone then return end
  if not QuestHelper.Astrolabe.WorldMapVisible then return end
  
  QH_POI_Reset()
  
  if not completed_active then return end
  
  local questlist = DB_GetItem("questlist", waypoint_zone, true)
  if not questlist then return end
  
  local donequests = QH_GetCompletedTable()
  
  for _, v in ipairs(questlist) do
    if donequests[v] then
      --print("Done:", v)
    else
      --print("Not done:", v)
      local ql = DB_GetItem("quest", v)
      --print(ql.start)
      --print(ql.start.loc)
      --print(ql.start.loc[1])
      QH_POI_Add(waypoint_zone, ql.start.loc[1].x, ql.start.loc[1].y, string.format("%s (quest #%d)", ql.name or "(unknown quest name)", v))
    end
  end
end
QH_AddCompletionNotifier(rescan)

QH_Event("WORLD_MAP_UPDATE", function ()
  local c, z = QuestHelper.Astrolabe:GetCurrentVirtualMapCZ()
  --print(c, z)
  if not QuestHelper_IndexLookup[c] or not QuestHelper_IndexLookup[c][z] then return end
  QuestHelper: Assert(QuestHelper_IndexLookup[c])
  QuestHelper: Assert(QuestHelper_IndexLookup[c][z])
  waypoint_zone = QuestHelper_IndexLookup[c][z]
  
  rescan()
end)
