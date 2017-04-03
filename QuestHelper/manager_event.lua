QuestHelper_File["manager_event.lua"] = "1.4.1"
QuestHelper_Loadtime["manager_event.lua"] = GetTime()

-- zorba why does this file exist, are you a terrible person? you are a terrible person aren't you
-- yep, I'm a terrible person

-- File exists to centralize all the event hooks in one place. QH should never (rarely) eat CPU without going through this file. As a nice side effect, I can use this to measure when QH is using CPU. yaaaaay

local next_started = false

local time_used = 0

local EventRegistrar = {}

local OnUpdate_Keyed = {}

local qh_event_frame = CreateFrame("Frame")



function QH_Hook_NotMyFault(func, ...)
  return func(...)
end

local function wraptime(ident, func, ...)
  if QuestHelper then QuestHelper: Assert(ident) end
  local st, qhh_nmf
  local qhh_adj = 0
  if qh_loud_and_annoying then
    qhh_nmf = QH_Hook_NotMyFault
    QH_Hook_NotMyFault = function(func, ...)
      local zst = GetTime()
      --print("a", GetTime())
      return (function(...)
        --print("c", GetTime(), GetTime() - zst, qhh_adj)
        qhh_adj = qhh_adj + (GetTime() - zst)
        --print(qhh_adj)
        return ...
      end)(func(...))
    end
    st = GetTime()
  end
  func(...)
  if qh_loud_and_annoying then
    if GetTime() - st - qhh_adj > 0.0025 then
      QuestHelper: TextOut(string.format("Took way too long, %4f, at %s (adjusted by %4f)", (GetTime() - st - qhh_adj) * 1000, ident, qhh_adj * 1000))
    end
    QH_Hook_NotMyFault = qhh_nmf
  end
end

local function OnEvent(_, event, ...)
  if not next_started then next_started, time_used = true, 0 end
  
  if not qh_hackery_eventless and EventRegistrar[event] then 
    local tstart = GetTime()
    for _, v in pairs(EventRegistrar[event]) do
      wraptime(v.id, v.func, ...)
    end
    time_used = time_used + (GetTime() - tstart)
  end
end

qh_event_frame:UnregisterAllEvents()
qh_event_frame:RegisterAllEvents() -- I wonder what the performance penalty of this actually is
qh_event_frame:SetScript("OnEvent", OnEvent)

function QH_Event(event, func, identifier)
  QuestHelper: Assert(func)
  if type(event) == "table" then
    for _, v in ipairs(event) do
      QH_Event(v, func, identifier)
    end
  else
    if not identifier then identifier = "(unknown event " .. event .. ")" end
    if not EventRegistrar[event] then
      --qh_event_frame:RegisterEvent(event)
      EventRegistrar[event] = {}
    end
    table.insert(EventRegistrar[event], {func = func, id = identifier})
  end
end

local tls = GetTime()

-- I'm just putting this here so I can stop rewriting it

--[[
Try "/script qh_hackery_no_work = true". See if that fixes things.

Whether it does or not, log out, log back in, then do "/qh hackery_event_timing = true". Wait a few seconds, then take a screenshot. Post that here.
]]

local last_frame = GetTime()
local time_per_frame = 0.01 -- Assume 100fps so we don't fuck with people's framerate

local OnUpdate = {}
local OnUpdateHigh = {}
local function OnUpdateTrigger(_, ...)
  if not QuestHelper then return end
  
  if not next_started then next_started, time_used = true, 0 end
  
  do
    local tstart = GetTime()
    for _, v in pairs(OnUpdateHigh) do
      wraptime(v.id, v.func, ...)
    end
    
    for _, v in pairs(OnUpdate) do
      if v.func then wraptime(v.id, v.func, ...) end
    end
    time_used = time_used + (GetTime() - tstart)
  end
  
  local tframe = GetTime()
  local tplf = tframe - last_frame
  tplf = math.min(time_per_frame + 0.1, tplf)
  local tplf_weight = tplf * 20
  time_per_frame = (time_per_frame * (1 / (tplf_weight + 0.0005)) + tplf) / (1 + 1 / (tplf_weight + 0.0005))
  
  QuestHelper: Assert(time_per_frame > 0 and time_per_frame < 10000)  -- hmmm
  
  local verbose = false
  if qh_hackery_event_timing and tls < GetTime() - 1 then
    tls = GetTime()
    print(string.format("Avg TPF %f, current TPLF %f, time_used %f, this adjustment %f, bonus time %f", time_per_frame, tplf, time_used, time_per_frame - tplf - time_used, math.min(time_per_frame - tplf, (time_per_frame - tplf) * 0.8, 0.05)))
    verbose = true
  end
  if not qh_hackery_no_work then
    QH_Timeslice_Work(time_used, time_per_frame, math.min(time_per_frame - tplf, (time_per_frame - tplf) * 0.8, 0.05), verbose)
  end
  last_frame = GetTime()
  
  next_started = false
end

function QH_OnUpdate(func, identifier)
  if not identifier then identifier = "(unknown onupdate)" end
  table.insert(OnUpdate, {func = func, id = identifier})
end

function QH_OnUpdate_High(func, identifier)
  if not identifier then identifier = "(unknown high-onupdate)" end
  table.insert(OnUpdateHigh, {func = func, id = identifier})
end

qh_event_frame:SetScript("OnUpdate", OnUpdateTrigger)


function QH_Hook(target, hookname, func, identifier)
  if not identifier then identifier = string.format("(unknown hook %s/%s)", hookname, tostring(target)) end
  if hookname == "OnUpdate" then
    if not func then
      OnUpdate[target] = nil
    else
      OnUpdate[target] = {func = function (...) func(target, ...) end, id = identifier}
    end
  else
    if not func then
      target:SetScript(hookname, nil)
    else
      target:SetScript(hookname, function (...) wraptime(identifier, func, ...) end)
    end
  end
end
