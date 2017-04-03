QuestHelper_File["timeslice.lua"] = "1.4.1"
QuestHelper_Loadtime["timeslice.lua"] = GetTime()

local debug_output = (QuestHelper_File["timeslice.lua"] == "Development Version")

-- Any non-local item here is part of an available public interface.

local coroutine_running = false
local coroutine_stop_time = 0
local coroutine_list = {}
local coroutine_route_pass = 1

local coroutine_verbose = false

local coroutine_time_used = {}
local coroutine_power_up = GetTime()

local coroutine_time_exceeded = 0

function QH_Timeslice_DumpPerf()
  local sortable = {}
  for k, v in pairs(coroutine_time_used) do
    table.insert(sortable, {name = k, amount = v})
  end
  table.sort(sortable, function(a, b) return a.name < b.name end)
  for _, v in pairs(sortable) do
    QuestHelper:TextOut(string.format("%s: %f", QuestHelper:HighlightText(v.name), v.amount))
  end
  QuestHelper:TextOut(string.format("%s: %f", QuestHelper:HighlightText("poweron"), GetTime() - coroutine_power_up))
end

local last_stack = nil
local yield_ct = 0
local GetTime = GetTime
local unyieldable = 0
function QH_Timeslice_PushUnyieldable()
  unyieldable = unyieldable + 1
end
function QH_Timeslice_PopUnyieldable()
  unyieldable = unyieldable - 1
  QuestHelper: Assert(unyieldable >= 0)
end
function QH_Timeslice_Yield()
  if unyieldable > 0 then return end
  if coroutine_running then
    -- Check if we've run our alotted time
    yield_ct = yield_ct + 1
    if GetTime() > coroutine_stop_time then
      local sti = debugstack(2, 5, 5) -- string.gsub(debugstack(2, 1, 1), "\n.*", "")
      if qh_loud_and_annoying and GetTime() > coroutine_stop_time + 0.0015 then
        print(yield_ct, (GetTime() - coroutine_stop_time) * 1000, "took too long", sti, "------ from", last_stack, "------")
      end
      
      -- As a safety, reset stop time to 0.  If somehow we fail to set it next time,
      -- we'll be sure to yield promptly.
      coroutine_stop_time = 0
      coroutine.yield()
      last_stack = sti
      yield_ct = 0
    end
  end
end

function QH_Timeslice_Bonus(quantity)
  if coroutine_verbose then QuestHelper:TextOut(string.format("timeslice: %d bonus", quantity)) end
  coroutine_route_pass = coroutine_route_pass + quantity
end

local prioritize = {
  preinit = {101},
  init = {100},
  criteria = {10},
  lzw = {-5},
  compress = {-8, 5},
  new_routing = {-10},
}

local bumped_priority = {}

function QH_Timeslice_Add(workfunc, name)
  QuestHelper: Assert(workfunc)
  QuestHelper: Assert(name)
  local priority = prioritize[name] and prioritize[name][1] or 0
  local sharding = prioritize[name] and prioritize[name][2] or 1
  if coroutine_verbose then QuestHelper:TextOut(string.format("timeslice: %s added (%s, %d)", name, tostring(workfunc), priority)) end
  local ncoro = coroutine.create(workfunc)
  QuestHelper: Assert(ncoro)
  table.insert(coroutine_list, {priority = priority, sharding = sharding, name = name, coro = ncoro, active = true})
end

function QH_Timeslice_Toggle(name, flag)
  --if coroutine_verbose then QuestHelper:TextOut(string.format("timeslice: %s toggled to %s", name, tostring(not not flag))) end
  for _, v in pairs(coroutine_list) do
    if v.name == name then v.active = flag end
  end
end

local started = false

function QH_Timeslice_Doneinit()
  if not started then
    if debug_output then
      QuestHelper:TextOut("Done with initialization step")
    end
    
    QuestHelper.loading_main = nil
    QuestHelper.loading_flightpath = nil
    QuestHelper.loading_preroll = nil
  
    collectgarbage("collect") -- fuuuuuck youuuuuuuu
  end
  
  started = true
end

function QH_Timeslice_Bump(type, newpri)
  bumped_priority[type] = newpri
end
function QH_Timeslice_Bump_Reset(type)
  bumped_priority[type] = nil
end

local startacu = GetTime()
local totalacu = 0
local lacu = 0

--[[function qhtacureset()
  startacu = GetTime()
  totalacu = 0
  lacu = 0
end]]

local thrown_away_excess = 0
local total_used = 0

function QH_Timeslice_Work(time_used, time_this_frame, bonus_time, verbose)
  -- There's probably a better way to do this, but. Eh. Lua.
  QuestHelper: Assert(unyieldable == 0)
  
  local coro = nil
  local key = nil
  local cpri = nil
  for k, v in pairs(coroutine_list) do
    if v.active then
      --if v.sharding then QuestHelper:TextOut(string.format("%d mod %d is %d, %s", time(), v.sharding, bit.mod(time(), v.sharding), tostring(bit.mod(time(), v.sharding) == 0))) end
      local pri = bumped_priority[v.name] or v.priority
      if (not v.sharding or bit.mod(time(), v.sharding) == 0) and (not coro or (pri > cpri)) then
        coro = v
        key = k
        cpri = pri
      end
    end
  end
  
  if coro then
    --if coroutine_verbose then QuestHelper:TextOut(string.format("timeslice: %s running", coro.name)) end
    
    if coroutine.status(coro.coro) == "dead" then   -- Someone was claiming to get an infinite loop with this. I don't see how it's possible, but this should at least fix the infinite loop.
      coroutine_list[key] = nil
    end
      QuestHelper: Assert(coroutine.status(coro.coro) ~= "dead")
    
    local slicefactor = (QuestHelper_Pref.hide and 0.01 or (QuestHelper_Pref.perf_scale_2 * math.min(coroutine_route_pass, 5)))
    if not started then slicefactor = 5 * QuestHelper_Pref.perfload_scale * math.min(coroutine_route_pass, 5) end  -- the init process gets much higher priority so we get done with it faster
    local time_to_use = slicefactor * time_this_frame * 0.075 -- We want to use 7.5% of the system CPU
    if InCombatLockdown() then time_to_use = time_to_use / 5 end
    local coroutine_intended_stop_time = time_to_use
    coroutine_stop_time = coroutine_intended_stop_time - coroutine_time_exceeded - time_used + bonus_time
    coroutine_route_pass = coroutine_route_pass - 5
    if coroutine_route_pass <= 0 then coroutine_route_pass = 1 end
    
    if verbose then
      print(string.format("time_to_use %f, time_already_used %f, bonus_time %f, coroutine_time_exceeded %f, total_time_to_use %f", time_to_use, time_used, bonus_time, coroutine_time_exceeded, coroutine_stop_time))
      print(string.format("thrown_away_excess %f, used %f, maxi %f", thrown_away_excess, total_used, slicefactor * 0.075 * 5))
    end
    
    local start = GetTime()
    coroutine_stop_time, coroutine_intended_stop_time = coroutine_stop_time + start, coroutine_intended_stop_time + start
    local state, err = true, nil -- default values for "we're fine"
    
    totalacu = totalacu + math.max(0, coroutine_stop_time - start)
    --[[if lacu + 0.1 < totalacu then
      lacu = totalacu
      print(string.format("%f realtime, %f runtime, %f%%", start - startacu, totalacu, (totalacu / (start - startacu)) * 100))
    end]]
    
    if start < coroutine_stop_time then -- We don't want to just return on failure because we want to credit the exceeded time properly.
      coroutine_running = true
      QuestHelper: Assert(unyieldable == 0)
      state, err = coroutine.resume(coro.coro)
      QuestHelper: Assert(unyieldable == 0)
      coroutine_running = false
    end
    local stop = GetTime()
    
    local total = stop - start
    local coroutine_this_cycle_exceeded = stop - coroutine_intended_stop_time -- may be either positive or negative
    
    local origcte = coroutine_time_exceeded + coroutine_this_cycle_exceeded
    coroutine_time_exceeded = min(origcte, slicefactor * 0.075 * 5)  -- honestly, waiting for more than five seconds to recover from a stutter is just dumb
    thrown_away_excess = thrown_away_excess + (origcte - coroutine_time_exceeded)
    total_used = total_used + total
    
    coroutine_time_used[coro.name] = (coroutine_time_used[coro.name] or 0) + total
    
    if not state then
      if coroutine_verbose then QuestHelper:TextOut(string.format("timeslice: %s errored", coro.name)) end
      QuestHelper_ErrorCatcher_ExplicitError(true, err, "", string.format("(Coroutine error in %s)\n", coro.name))
    end
    
    QuestHelper: Assert(coro.coro)
    if coroutine.status(coro.coro) == "dead" then
      if coroutine_verbose then QuestHelper:TextOut(string.format("timeslice: %s complete", coro.name)) end
      coroutine_list[key] = nil
    end
  else
    if coroutine_verbose then QuestHelper:TextOut(string.format("timeslice: no available tasks")) end
  end
end

function QH_Timeslice_Increment(quantity, name)
  local an = "(nc) " .. name
  coroutine_time_used[an] = (coroutine_time_used[an] or 0) + quantity
end
