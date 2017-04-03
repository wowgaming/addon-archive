QuestHelper_File["collect_notifier.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_notifier.lua"] = GetTime()

local NotificationsPending = {}

local function OnUpdate()
  while #NotificationsPending > 0 and GetTime() >= NotificationsPending[1].time do
    NotificationsPending[1].func()
    table.remove(NotificationsPending, 1) -- okay okay n^2 deal with it
  end
end

local function AddItem(time, func)
  QuestHelper: Assert(time)
  QuestHelper: Assert(func)
  table.insert(NotificationsPending, {time = time, func = func})
  table.sort(NotificationsPending, function (a, b) return a.time < b.time end)  -- haha who cares about efficiency anyway, NOT ME that is for certain
end

function QH_Collect_Notifier_Init(_, API)
  API.Utility_Notifier = AddItem
  
  API.Registrar_OnUpdateHook(OnUpdate)
end

-- grrrr
QH_AddNotifier = AddItem
