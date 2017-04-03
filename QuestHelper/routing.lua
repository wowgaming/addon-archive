QuestHelper_File["routing.lua"] = "1.4.1"
QuestHelper_Loadtime["routing.lua"] = GetTime()

-- Create module
QuestHelper.Routing = {}
local Routing = QuestHelper.Routing
Routing.qh = QuestHelper

-- Constants:
local improve_margin = 1e-8

-- Module Status:
local work_done = 0

local function CalcObjectivePriority(obj)
  local priority = obj.priority
  
  for o in pairs(obj.before) do
    if o.watched then
      priority = math.min(priority, CalcObjectivePriority(o))
    end
  end
  
  obj.real_priority = priority
  return priority
end

local Route = {}
Route.__index = Route
Routing.Route = Route       -- Make it available as a member

-- This should pass on all routes. If it does not, *things need to be fixed*. No, commenting tests out is not an adequate response - this *must* pass. Eventually this will get rolled into the unsucky Route class.
function Route:sanity()
  
  local assert = assert
  
  if QuestHelper.Error then
    assert = function(a, b)
      if not a then
        QuestHelper:TextOut("Route:sanity(): id="..self.id.."; best_route="..Routing.best_route.id)
        QuestHelper:Error(b or "Assertion Failed")
      end
    end
  end
  
  local l = 0
  
  --QuestHelper:TextOut(QuestHelper:StringizeTable(self))
  for i = 0,#self-1 do
    --QuestHelper:TextOut(tostring(i))
    --QuestHelper:TextOut(QuestHelper:StringizeTable(self[i]))
    --QuestHelper:TextOut(tostring(self[i].len))
    --[[ assert(self[i].len) ]]
    l = l + self[i].len
  end
  
  --QuestHelper:TextOut("sd: "..l.." rd: "..self.distance)
  --[[ assert(math.abs(l-self.distance) < 0.0001, string.format("compare %f vs %f", l, self.distance)) ]]
  
  for i, info in ipairs(self) do
    --[[ assert(self.index[info.obj] == i) ]]
    --[[ assert(info.pos) ]]
  end
  
  for obj, i in pairs(self.index) do
    --[[ assert(self[i].obj == obj) ]]
  end
  
  for i = 1, #self-1 do
    local l = QuestHelper:ComputeTravelTime(self[i].pos, self[i+1].pos, true)
    --[[ assert(math.abs(l-self[i].len) < 0.0001, "Compare at "..i..": "..l.." vs "..self[i].len) ]]
  end
  
  return true
end

function Route:findObjectiveRange(obj, passes)

  --[[
  lines = {}
  table.insert(lines, string.format("QuestHelper objectiverange for %s (pri %d)", obj.obj, obj.real_priority))
  for i = 1, #self do
    table.insert(lines, string.format("%d %d %d --- %d %d %d (vs %s, %d)", obj.real_priority > self[i].obj.real_priority and 1 or 0, obj.after[self[i].obj] and 1 or 0, self[i].obj.before[obj] and 1 or 0, obj.real_priority < self[i].obj.real_priority and 1 or 0, obj.before[self[i].obj] and 1 or 0, self[i].obj.after[obj] and 1 or 0, self[i].obj.obj, self[i].obj.real_priority))
  end]]
  
  local mn = #self
  while mn >= 1 do
    if obj.real_priority > self[mn].obj.real_priority or obj.after[self[mn].obj] or self[mn].obj.before[obj] then break end
    mn = mn - 1
  end
  
  mn = mn + 1 -- we went too far, actually
  
  local mx = 1
  while mx < #self + 1 do
    if obj.real_priority < self[mx].obj.real_priority or obj.before[self[mx].obj] or self[mx].obj.after[obj] then break end
    mx = mx + 1
  end
  
  --table.insert(lines, string.format("temp results is %d %d", mn, mx))
  
  if mx < mn then -- well, technically, there's no place we can put this. So we guess wildly. Eventually it'll sanify itself. We hope.
    local mid = math.ceil((mx + mn) / 2)
    mx = mid
    mn = mid
  end
  
  --table.insert(lines, string.format("overall: %d %d", mn, mx))
  
  --[[
  if passes and passes > 90 then  
    for k, v in pairs(lines) do QuestHelper:TextOut(v) end
    QuestHelper:TextOut(string.format("overall: %d %d", mn, mx))
  end
  ]]
  
  --[[
  local omn, omx = self:OldFindObjectiveRange(obj)
  
  if mn ~= omn or mx ~= omx then
    for k, v in pairs(lines) do QuestHelper:TextOut(v) end
    QuestHelper:TextOut(string.format("overall: %d %d vs %d %d", mn, mx, omn, omx))
    lolcrash = (lolcrash or 0) + 1
  end]]
  
  return mn, mx, lines
  
end

function Route:addObjectiveFast(obj)
  --[[ assert(self:sanity()) ]]
  local indexes = self.index
  local len = #self
  local info = QuestHelper:CreateTable()
  --[[ assert(not indexes[obj]) ]]
  
  info.obj = obj
  
  if len == 0 then
    local d
    self[1] = info
    indexes[obj] = 1
    d, info.pos = obj:TravelTime(self[0].pos, true)
    self[0].len = d
    self.distance = d
    return 1
  end
  
  local player_pos = QuestHelper.pos
  local pos = obj.location
  local c, x, y = pos[1].c, pos[3], pos[4]
  
  local mn, mx = self:findObjectiveRange(obj)
  local index, distsqr
  
  for i = mn, math.min(mx, len) do
    local p = self[i].pos
    if c == p[1].c then
      local u, v = p[3]-x, p[4]-y
      local d2 = u*u+v*v
      if not index or d2 < distsqr then
        index, distsqr = i, d2
      end
    end
  end
  
  if not index then
    -- No nodes with the same continent already.
    -- If the same continent as the player, add to start of list, otherwise add to end of the list.
    index = c == player_pos[1].c and mx or mx
  end
  
  -- The next question, do I insert at that point, or do I insert after it?
  if index ~= mx and index <= len then
    local p1 = self[index].pos
    
    if p1[1].c == c then
      local p0
      
      if index == 1 then
        p0 = player_pos
      else
        p0 = self[index-1].pos
      end
      
      local oldstart, newstart
      
      if p0[1].c == c then
        local u, v = p0[3]-x, p0[4]-y
        newstart = math.sqrt(u*u+v*v)
        u, v = p0[3]-p1[3], p0[4]-p1[4]
        oldstart = math.sqrt(u*u+v*v)
      else
        newstart = 0
        oldstart = 0
      end
      
      local p2
      if index ~= len then
        p2 = self[index+1].pos
      end
      
      local oldend, newend
      if p2 and p2[1].c == c then
        local u, v = p2[3]-x, p2[4]-y
        newend = math.sqrt(u*u+v*v)
        u, v = p2[3]-p1[3], p2[4]-p1[4]
        oldend = math.sqrt(u*u+v*v)
      else
        newend = 0
        oldend = 0
      end
      
      if oldstart+newend < newstart+oldend then
        index = index + 1
      end
      
    end
  end
  
  QH_Timeslice_Yield() -- The above checks don't require much effort.
  
  if index > len then
    local previnfo = self[index-1]
    --[[ assert(previnfo) ]]
    local d
    d, info.pos = obj:TravelTime(previnfo.pos)
    --[[ assert(info.pos) ]]
    QH_Timeslice_Yield()
    previnfo.len = d
    self.distance = self.distance + d
  else
    local d1, d2
    
    local previnfo = self[index-1]
    d1, d2, info.pos = obj:TravelTime2(previnfo.pos, self[index].pos, previnfo.no_cache)
    
    info.len = d2
    self.distance = self.distance + (d1 - previnfo.len + d2)
    previnfo.len = d1
    
    QH_Timeslice_Yield()
  end
  
  -- Finally, insert the objective.
  table.insert(self, index, info)
  indexes[obj] = index
  
  -- Fix indexes of shifted elements.
  for i = index+1,len+1 do
    local obj = self[i].obj
    --[[ assert(indexes[obj] == i-1) ]]
    indexes[obj] = i
  end
  
  --[[ assert(self:sanity()) ]]
  
  return index
end

function Route:addObjectiveBest(obj, old_index, old_distance)
  --[[ assert(self:sanity()) ]]
  
  local indexes = self.index
  local len = #self
  local info = QuestHelper:CreateTable()
  --[[ assert(not indexes[obj]) ]]
  
  info.obj = obj
  
  if len == 0 then
    indexes[obj] = 1
    self.distance, info.pos = obj:TravelTime(self[0].pos, true)
    info.len = 0
    self[0].len = self.distance
    self[1] = info
    return 1
  end
  
  local sanityfixed = nil -- If we've done something to improve the sanity of the overall path, i.e. force the path into a situation where it's no longer trying to turn in quests before the quest has been completed, then we definitely want to accept this path overall. Before, this wasn't a problem, since this function was so unstable that it would randomly change the path anyway, and it doesn't *break* things once they're fixed. Now that we have a check that this function actually *improves* the path, we need a slightly more complicated definition of "improve". Ideally, that shouldn't be necessary, but for now it is (until, at least, this function actually puts things in the best location, and that will have to wait until the get-optimal-path functions actually get optimal paths.)
  
  local best_index, best_delta, best_d1, best_d2, best_p
  local no_cache, prev_pos, prev_len
  local mn, mx = self:findObjectiveRange(obj)
  
  if old_index and mn <= old_index and old_index <= mx then
    -- We're trying to re-evaluate it, and it could remain in the same place.
    -- So that place is our starting best known place.
    best_index, best_delta = old_index, old_distance - self.distance
    
    if best_delta < 0 then
      -- Somehow, removing the objective actually made the route worse...
      -- Just re-figure things from scratch.
      -- TODO: THIS SHOULD NEVER HAPPEN dear god find out what's causing this and stop it
      --QuestHelper:TextOut("made route worse wtf")
      best_index, best_delta = nil, nil
    end
  end
  
  local pinfo = self[mn-1]
  no_cache, prev_pos, prev_len = pinfo.no_cache, pinfo.pos, pinfo.len
  
  for i = mn, math.min(mx, len) do
    --[[ assert(prev_pos == self[i-1].pos) ]]
    
    local info = self[i]
    local pos = info.pos
    
    local d1, d2, p = obj:TravelTime2(prev_pos, pos, no_cache)
    
    QH_Timeslice_Yield()
    
    local delta = d1 + d2 - prev_len
    
    if not best_index or ((delta + improve_margin) < best_delta) or ((i == best_index) and not best_d1) then
      -- Best so far is:
      --  * First item we reach
      --  * Better than previous best
      --  * We're looking at our best already.  But we just got here; how could this be best?
      --    If this was our prior location and we didn't find anything better earlier in the route,
      --    that's how.  Save the specifics, 'cause we didn't compute them when setting up.
      best_index, best_delta, best_d1, best_d2, best_p = i, delta, d1, d2, p
    end
    
    prev_pos = pos
    prev_len = info.len
    no_cache = false
  end
  
  if mx > len then
    --[[ assert(mx == len+1) ]]
    --[[ assert(prev_pos == self[len].pos) ]]
    local delta, p = obj:TravelTime(prev_pos, no_cache)
    
    QH_Timeslice_Yield()
    
    if not best_index or ((delta + improve_margin) < best_delta) or ((mx == best_index) and not best_d1) then
      info.pos = p
      info.len = 0
      self[len].len = delta
      self.distance = self.distance + delta
      table.insert(self, info)
      indexes[obj] = mx
      
      --[[ assert(self:sanity()) ]]
      
      return mx
    end
  end

  info.pos = best_p
  info.len = best_d2
  
  local pinfo = self[best_index-1]
  self.distance = self.distance + (best_d1 - pinfo.len + best_d2)
  pinfo.len = best_d1
  
  table.insert(self, best_index, info)
  
  -- --[[ QuestHelper:Assert(math.abs(QuestHelper:ComputeTravelTime(self[best_index-1].pos, self[best_index].pos) - self[best_index-1].len) < 0.0001, "aaaaargh") ]]
  --[[    -- I don't think this is necessary now that TravelTime2 explicitly does this internally, but I'm keeping it anyway.
  self.distance = self.distance - self[best_index-1].len
  self[best_index-1].len = QuestHelper:ComputeTravelTime(self[best_index-1].pos, self[best_index].pos, true)
  self.distance = self.distance + self[best_index-1].len
  ]]
  
  indexes[obj] = best_index
  
  for i = best_index+1,len+1 do
    --[[ assert(indexes[self[i].obj] == i-1) ]]
    indexes[self[i].obj] = i
  end
  
  if not old_index or (mn > old_index or old_index > mx) and mn <= best_index and best_index <= mx then
    -- if we didn't have an old index, or our old index was out of bounds and our best index is in bounds, then we've done something Majorly Good and we should be using this path even if the old one was faster
    sanityfixed = 1
  end
  
  --[[ assert(self:sanity()) ]]
  
  return best_index, sanityfixed
end

function Route:removeObjective(obj)
  --[[ assert(self:sanity()) ]]
  
  local indexes = self.index
  local index = indexes[obj]
  local old_distance = self.distance
  
  --[[ assert(index) ]]
  local info = self[index]
  --[[ assert(info.obj == obj) ]]
  
  --[[
  Removing end item: subtract last distance, nothing to recalculate
  Removing other item: recalculate location of next objective, between prior position and objective after next
  Special case: if there is no location after next, just recalc location of next objective
  --]]
  if index == #self then
    self.distance = self.distance - self[index-1].len
    self[index-1].len = 0
  else
    local pinfo = self[index-1]
    local info1 = self[index+1]
    local info2 = self[index+2]
    local no_cache = (index == 1)
    
    local d1, d2
    
    if info2 then
      d1, d2, info1.pos = info1.obj:TravelTime2(pinfo.pos, info2.pos, no_cache)
      QH_Timeslice_Yield()
      self.distance = self.distance - pinfo.len - info.len - info1.len + d1 + d2
      info1.len = d2
    else
      d1, info1.pos = info1.obj:TravelTime(pinfo.pos, no_cache)
      QH_Timeslice_Yield()
      self.distance = self.distance - pinfo.len - info.len + d1
    end
    
    pinfo.len = d1
  end
  
  QuestHelper:ReleaseTable(info)
  indexes[obj] = nil
  table.remove(self, index)
  
  for i = index,#self do
    -- Fix indexes of shifted elements.
    local obj = self[i].obj
    --[[ assert(indexes[obj] == i+1) ]]
    indexes[obj] = i
  end
  
  --[[ assert(self:sanity()) ]]
--  --[[ assert(self.distance <= old_distance) ]]
  
  return index
end

local links = {}
local seen = {}

function Route:breed(route_map)
  local indexes = self.index
  local len = #self
  
  local info
  local r
  
  local prev_pos = QuestHelper.pos
  --[[ assert(self[0].pos == prev_pos) ]]
  
  -- Pick which objective goes first, selecting from first objective of each route,
  -- and scaling by the route's fitness and distance from player, with a random adjustment factor.
  -- While we're at it, record some data about the fitness of adjacent objectives
  for route in pairs(route_map) do
    --[[ assert(route:sanity()) ]]
    local fit = route.fitness
    local pos = route[1].pos
    local w
    
    if prev_pos[1].c == pos[1].c then
      local u, v = prev_pos[3]-pos[3], prev_pos[4]-pos[4]
      w = math.sqrt(u*u+v*v)
    else
      w = 500
    end
    
    w = fit * math.random() / w
    
    if not info or w > r then
      info, r = route[1], w
    end
    
    for i = 1,len do
      local obj = route[i].obj
      local tbl = links[obj]
      if not tbl then
        tbl = QuestHelper:CreateTable()
        links[obj] = tbl
      end
      
      if i ~= 1 then
        local info = route[i-1]
        local obj2 = info.obj
        tbl[info] = (tbl[info] or 0) + fit
      end
      
      if i ~= len then
        local info = route[i+1]
        local obj2 = info.obj
        if obj.real_priority <= obj2.real_priority or obj.before[obj2] then
          tbl[info] = (tbl[info] or 0) + fit
        end
      end
    end
    
    QH_Timeslice_Yield()
  end
  
  -- Record info for the 'Player Position' objective, so we don't mess it up later
  seen[self[0].obj] = self[0].pos
  
  -- Record the objective that we chose to put first
  local obj = info.obj
  indexes[obj] = 1
  seen[obj] = info.pos      -- Save its position, because we don't want to clobber any of the info objects yet
  prev_pos = info.pos
  
  last = links[obj]
  links[obj] = nil
  
  -- Scan the rest of the places in the route, and pick objectives to go there
  for index = 2,len do
    info = nil
    local c = 1
    
    -- Scan the list of scores from the prior objective
    for i, weight in pairs(last) do
      if links[i.obj] then
        -- Only consider an item if we have scores for that item
        local w
        local pos = i.pos
        if prev_pos[1].c == pos[1].c then
          local u, v = prev_pos[3]-pos[3], prev_pos[4]-pos[4]
          w = math.sqrt(u*u+v*v)
        else
          w = 500
        end
        
        w = weight * math.random() / w
        
        if not info or w > r then
          info, r = i, w
        end
      end
      c = c + 1
    end
    
    -- In case we had no valid scores, scan the remaining objectives and score by distance
    if not info then
      for obj in pairs(links) do
        local pos = obj.pos
        local w
        if prev_pos[1] == pos[1] then
          -- Same zone
          local u, v = prev_pos[3]-pos[3], prev_pos[4]-pos[4]
          w = math.sqrt(u*u+v*v)
        elseif prev_pos[1].c == pos[1].c then
          -- Same continent. -- Assume twices as long.
          local u, v = prev_pos[3]-pos[3], prev_pos[4]-pos[4]
          w = 2*math.sqrt(u*u+v*v)
        else
          -- Different continent. Assume fixed value of 5 minutes.
          w = 300
        end
        
        w = math.random() / w
        
        if not info or w > r then
          local route = next(route_map)
          info, r = route[route.index[obj]], w
        end
      end
      
      --[[ assert(info) ]]
    end
    
    -- Add the selected item to the route
    obj = info.obj
    indexes[obj] = index
    prev_pos = info.pos
    seen[obj] = prev_pos
    --[[ assert(info.obj == obj) ]]
    
    -- Get the scores table for this objective, clear it out, discard the scores from the prior objective, and save these scores for next time around
    local link = links[obj]
    links[obj] = nil
    QuestHelper:ReleaseTable(last)
    last = link
    
    QH_Timeslice_Yield()
  end
  
  -- Clean up the last table
  QuestHelper:ReleaseTable(last)
  
  -- Now that we've got our objectives lined up, fill in the info objects with the positions we saved
  for obj, i in pairs(indexes) do
    --[[ assert(seen[obj]) ]]
    local info = self[i]
    info.obj, info.pos = obj, seen[obj]
    seen[obj] = nil
  end
  
  -- Now randomly randomize some of the route (aka mutation)
  while math.random() > 0.3 do
    local l = math.floor(math.random()^1.6*(len-1))+1
    local i = math.random(1, len-l)
    local j = i+l
    
    -- Reverse a chunk of the route
    for k = 0, j-i-1 do
      self[i+k], self[j-k] = self[j-k], self[i+k]
    end
  end
  
  -- But wait, after all that some objectives might violate the rules.  Make sure the route follows
  -- the rules.

  -- There's some horrifying ugly here. The "before" and "after" links are not properly updated simultaneously. This means that X can be flagged as after Y without Y being flagged as before X. Making things worse (because, oh man, things had to be made worse!) this means that X might have a lower priority than Y despite needing to happen before it. Urgh.
  -- Since the entire thing is internally inconsistent anyway, we're just gonna try to consistentize it.
  
  local valid_items = {}
  for k, v in ipairs(self) do
    valid_items[v.obj] = true
  end
  for k, v in ipairs(self) do
    for b in pairs(v.obj.before) do
      if valid_items[b] then
        b.after[v.obj] = true
      end
    end
    for a in pairs(v.obj.after) do
      if valid_items[a] then
        a.before[v.obj] = true
      end
    end
  end
  
  -- Because priorities might have been changed in here, we next make absolutely sure we have up-to-date priorities.
  for k, v in ipairs(self) do
    CalcObjectivePriority(v.obj)
  end
  
  -- Have I mentioned I hate this codebase yet?
  -- Because I do.
  -- Just, you know.
  -- FYI.

  local invalid = true
  local invalid_passes = 0
  --local output_strings = {}
  while invalid do
  
    invalid_passes = invalid_passes + 1
    
    --[[if invalid_passes >= 100 then
      for k, v in pairs(output_strings) do
        QuestHelper:TextOut(v)
      end
    end]]
    
    if invalid_passes >= 100 then
      -- ugh
      QuestHelper.mutation_passes_exceeded = true
      break
    end
    QuestHelper: Assert(invalid_passes <= 100, "Too many mutation passes needed to preserve sanity, something has gone Horribly Wrong, please report this as a bug (you will probably need to restart WoW for QH to continue working, sorry about that)")  -- space is so it works in the real code
    
    invalid = false
    local i = 1
    --[[for i = 1, #self do
      local mn, mx = self:findObjectiveRange(self[i].obj, invalid_passes)
      table.insert(output_strings, string.format("%d is mn mx %d %d (%s)", i, mn, mx, self[i].obj.obj))
    end]]
    while i <= #self do
      -- Make sure all the objectives have valid positions in the list.
      local info = self[i]
      local mn, mx, tabi = self:findObjectiveRange(info.obj, invalid_passes)
      --if invalid_passes > 90 then for k, v in pairs(tabi) do table.insert(output_strings, v) end end
      if i < mn then
        -- In theory, 'i' shouldn't be increased here, as the next
        -- element will be shifted down into the current position.
        
        -- However, it is possible for an infinite loop to be created
        -- by this, with a small range of objectives constantly
        -- being shifted.
        
        -- So, I mark the route as invalid and go through it another time.
        -- It's probably still possible to get into an infinite loop,
        -- but it seems much less likely.
        
        table.insert(self, mn, info)
        table.remove(self, i)
        invalid = true
        --table.insert(output_strings, string.format("shifting %d into %d", i, mn))
      elseif i > mx then
        table.remove(self, i)
        table.insert(self, mx, info)
        invalid = true
        --table.insert(output_strings, string.format("shifting %d into %d", i, mx))
      end
      i = i + 1
    end
    --table.insert(output_strings, "pass done")
  end
  
  -- Now that we've chosen a route, re-calculate the cost of each leg of the route
  local distance = 0
  local prev_info = self[0]
  local next_info = self[1]
  local prev_pos = prev_info.pos
  local next_pos = next_info.pos
  --[[ assert(prev_pos) ]]
  --[[ assert(next_pos) ]]
  
  QH_Timeslice_Yield()
  
  for i = 1, len-1 do
    local d1, d2
    local pos
    local info = next_info
    next_info = self[i+1]
    next_pos = next_info.pos
    
    indexes[info.obj] = i
    
    d1, d2, pos = info.obj:TravelTime2(prev_pos, next_pos, prev_info.no_cache)
    --[[ assert(pos) ]]
    QH_Timeslice_Yield()
    
    prev_info.len = d1
    info.len = d2
    info.pos = pos
    distance = distance + d1
    
    prev_info = info
    prev_pos = pos
  end
  
  self.distance = distance + prev_info.len
  
  indexes[self[len].obj] = len
  self[len].len = 0
  
  --[[ assert(self:sanity()) ]]
end

function Route:pathResetBegin()
  for i, info in ipairs(self) do
    local pos = info.pos
    info[1], info[2], info[3] = pos[1].c, pos[3], pos[4]
  end
end

function Route:pathResetEnd()
  for i, info in ipairs(self) do
    -- Try to find a new position for this objective, near where we had it originally.
    local p, d = nil, 0
    
    local a, b, c = info[1], info[2], info[3]
    
    for z, pl in pairs(info.obj.p) do
      for i, point in ipairs(pl) do
        if a == point[1].c then
          local x, y = b-point[3], c-point[4]
          local d2 = x*x+y*y
          if not p or d2 < d then
            p, d = point, d2
          end
        end
      end
    end
    
    -- Assuming that there will still be positions on the same continents as before, i.e., locations are only added and not removed.
    --[[ assert(p) ]]
    
    info.pos = p
  end
  
  self:recalculateDistances()
end

function Route:recalculateDistances()
  
  self.distance = 0
  for i = 0, #self-1 do
    self[i].len = QuestHelper:ComputeTravelTime(self[i].pos, self[i+1].pos)
    self.distance = self.distance + self[i].len
  end
end

function Routing:RoutingSetup()
  Routing.map_walker = self.qh:CreateWorldMapWalker()
  Routing.add_swap = {}
  Routing.routes = {}
  
  local routes = Routing.routes
  local pos = QuestHelper.pos
  local PlayerObjective = self.qh:NewObjectiveObject()  -- Pseudo-objective which reflects player's current position.  Always at index 0 of each route.
  PlayerObjective.pos = pos
  PlayerObjective.cat = "loc"       -- A special case of a location
  PlayerObjective.obj = "Player's current position"     -- Player shouldn't see this, so no need to localize
  PlayerObjective.icon_id = 6     -- Don't think we'll need these; just filling them in for completeness
  PlayerObjective.o = {pos=pos}
  PlayerObjective.fb = {}
  
  for i = 1,15 do -- Create some empty routes to use for our population.
    local new_rt = { index={ [PlayerObjective]=0 },
                     distance=0,
                     [0]={ obj=PlayerObjective, pos=pos, len=0, no_cache=true },  -- Player's current position is always objective #0
                     id=i       -- So I can keep track of which route is which; only for debugging.
                    }
    setmetatable(new_rt, Route)
    routes[new_rt] = true
  end
  
  -- All the routes are the same right now, so it doesn't matter which we're considering the best.
  self.best_route = next(routes)
  self.recheck_position = 1
  
end

function Routing:RouteUpdateRoutine()
  local qh = QuestHelper
  local map_walker = Routing.map_walker
  local minimap_dodad = qh.minimap_dodad
  
  local route = qh.route
  local to_add, to_remove, add_swap = qh.to_add, qh.to_remove, self.add_swap
  
  local routes = self.routes
  local pos = qh.pos
  
  local best_route = self.best_route
  
  local last_cache_clear = GetTime()
  
  ------ EVIL HACK OF DEBUG
  
  if false then
    while GetTime() < last_cache_clear + 5 do
      coroutine.yield()
    end
    
    if qh.target then
      -- We know the player will be at the target location at target_time, so fudge the numbers
      -- to pretend we're traveling there.
      
      pos[1], pos[3], pos[4] = qh.target[1], qh.target[3], qh.target[4]
      local extra_time = math.max(0, qh.target_time-time())
      for i, t in ipairs(qh.target[2]) do
        pos[2][i] = t+extra_time
      end
    else
      if not pos[1] -- Need a valid position, in case the player was dead when they loaded the game.
        or not UnitIsDeadOrGhost("player") then
        -- Don't update the player's position if they're dead, assume they'll be returning to their corpse.
        pos[3], pos[4] = qh.Astrolabe:TranslateWorldMapPosition(qh.c, qh.z, qh.x, qh.y, qh.c, 0)
        --[[ assert(pos[3]) ]]
        --[[ assert(pos[4]) ]]
        pos[1] = qh.zone_nodes[qh.i]
        pos[3], pos[4] = pos[3] * qh.continent_scales_x[qh.c], pos[4] * qh.continent_scales_y[qh.c]
        
        for i, n in ipairs(pos[1]) do
          if not n.x then
            for i, j in pairs(n) do qh:TextOut("[%q]=%s %s", i, type(j), tostring(j) or "???") end
            --[[ assert(false) ]]
          end
          
          local a, b = n.x-pos[3], n.y-pos[4]
          pos[2][i] = math.sqrt(a*a+b*b)
        end
      end
    end
    
    local obj = next(to_add)
    
    QuestHelper:TextOut("dbghack")
    QuestHelper:TextOut(QuestHelper:StringizeTable(to_add))
    obj.filter_zone = false
    obj.filter_watched = false
    QuestHelper:TextOut(QuestHelper:StringizeTable(obj))
    QuestHelper:TextOut(tostring(obj:Known()))
    obj:PrepareRouting()
    QuestHelper:TextOut(QuestHelper:StringizeTable(obj))
    
    QuestHelper:TextOut("o")
    QuestHelper:TextOut(QuestHelper:StringizeTable(obj.o))
    
    QuestHelper:TextOut("pp")
    QuestHelper:TextOut(QuestHelper:StringizeTable(obj.pos))
    QuestHelper:TextOut(QuestHelper:StringizeTable(obj.p))
    QuestHelper:TextOut(tostring(obj:Known()))
    
    local index = best_route:addObjectiveBest(obj)
    obj.pos = best_route[index].pos
    
    QuestHelper:TextOut(QuestHelper:StringizeTable(obj.pos))
    
    QuestHelper:TextOut(qh:ComputeTravelTime(pos, obj.pos))
    
    Error()
  end
  
  ------ EVIL HACK OF DEBUG
  
  while true do
    -- Clear caches out a bit
    if GetTime() + 15 >= last_cache_clear then
      qh:CacheCleanup()
      last_cache_clear = GetTime()
    end
    
    -- Update the player's position data.
    if qh.target then
      -- We know the player will be at the target location at target_time, so fudge the numbers
      -- to pretend we're traveling there.
      
      pos[1], pos[3], pos[4] = qh.target[1], qh.target[3], qh.target[4]
      local extra_time = math.max(0, qh.target_time-time())
      for i, t in ipairs(qh.target[2]) do
        pos[2][i] = t+extra_time
      end
    else
      if not pos[1] -- Need a valid position, in case the player was dead when they loaded the game.
        or not UnitIsDeadOrGhost("player") then
        -- Don't update the player's position if they're dead, assume they'll be returning to their corpse.
        pos[3], pos[4] = qh.Astrolabe:TranslateWorldMapPosition(qh.c, qh.z, qh.x, qh.y, qh.c, 0)
        --[[ assert(pos[3]) ]]
        --[[ assert(pos[4]) ]]
        pos[1] = qh.zone_nodes[qh.i]
        pos[3], pos[4] = pos[3] * qh.continent_scales_x[qh.c], pos[4] * qh.continent_scales_y[qh.c]
        
        for i, n in ipairs(pos[1]) do
          if not n.x then
            for i, j in pairs(n) do qh:TextOut("[%q]=%s %s", i, type(j), tostring(j) or "???") end
            --[[ assert(false) ]]
          end
          
          local a, b = n.x-pos[3], n.y-pos[4]
          pos[2][i] = math.sqrt(a*a+b*b)
        end
      end
    end
    
    local changed = false
    
    if #route > 0 then
      if self.recheck_position > #route then self.recheck_position = 1 end
      local o = route[self.recheck_position]
      
      --[[ assert(o.zones) ]]
      o.filter_zone = o.zones[pos[1].i] == nil
      o.filter_watched = not o:IsWatched()
      
      if not o:Known() then
        -- Objective was probably made to depend on an objective that we don't know about yet.
        -- We add it to both lists, because although we need to remove it, we need it added again when we can.
        -- This creates an inconsistancy, but it'll get fixed in the removal loop before anything has a chance to
        -- explode from it.
        
        to_remove[o] = true
        to_add[o] = true
      else
        if o.swap_before then
          qh:ReleaseTable(o.before)
          o.before = o.swap_before
          o.swap_before = nil
        end
        
        if o.swap_after then
          qh:ReleaseTable(o.after)
          o.after = o.swap_after
          o.swap_after = nil
        end
        
        if o.is_sharing ~= o.want_share then
          o.is_sharing = o.want_share
          
          if o.want_share then
            qh:DoShareObjective(o)
          else
            qh:DoUnshareObjective(o)
          end
        end
        
        CalcObjectivePriority(o)
        
        -- Make sure the objective in best_route is still in a valid position.
        -- Won't worry about other routes, they should forced into valid configurations by breeding.
        
         -- This is a temporary, horrible hack - we want to do a "best" test without actually clobbering our old route, so we're making a new temporary one to jam our route in for now. In theory, AddObjectiveBest should, I don't know, add it in the *best place*, but at the moment it does not necessarily, thus this nastiness.
        local aobt = {}
        setmetatable(aobt, getmetatable(best_route))
        for k, v in pairs(best_route) do
          aobt[k] = v
        end
        aobt.index = {}
        for k, v in ipairs(best_route) do
          -- arglbargl
          aobt[k] = QuestHelper:CreateTable("AOBT idiocy")
          for t, q in pairs(v) do
            aobt[k][t] = q
          end
          aobt.index[aobt[k].obj] = k
        end
        if aobt[0] then
          aobt[0] = QuestHelper:CreateTable("AOBT idiocy")
          for t, q in pairs(best_route[0]) do
            aobt[0][t] = q
          end
        end
        -- Actually duplicating a route is irritatingly hard (this is another thing which will be fixed eventually dammit)
        
        --[[ assert(aobt:sanity()) ]]
        --[[ assert(best_route:sanity()) ]]
        
        local old_distance, old_index = best_route.distance, best_route:removeObjective(o)
        local old_real_distance = (best_route.distance or 0) + (best_route[1] and qh:ComputeTravelTime(pos, best_route[1].pos) or 0)  -- part of hack
        local new_index, sanityfixed = best_route:addObjectiveBest(o, old_index, old_distance)
        local new_real_distance = (best_route.distance or 0) + (best_route[1] and qh:ComputeTravelTime(pos, best_route[1].pos) or 0)  -- part of hack
        -- not sure if best_route.distance can ever be nil or not, I was just getting errors I couldn't find for a while and ended up with that test included when I fixed the real error
        
        if new_real_distance < old_real_distance or sanityfixed then -- More of the temporary hack
          -- If we're using the new path . . .
        
          if old_index > new_index then
            old_index, new_index = new_index, old_index
          end
          
          for i = math.max(1, old_index-1), new_index do
            local info = best_route[i]
            local obj = info.obj
            obj.pos = info.pos
            route[i] = obj
          end
          
          
          if old_index ~= new_index then
            if old_index == 1 then
              minimap_dodad:SetObjective(route[1])
            end
            
            changed = true
          end
          
          -- . . . release our backup path
          for k, v in ipairs(aobt) do QuestHelper:ReleaseTable(v) end
          QuestHelper:ReleaseTable(aobt[0])
        else  -- hack (everything in this conditional besides the above chunk is a horrible hack)
          -- If we're using the old path . . .
          -- . . . release the *internals* of the new path, then copy everything over. Eugh.
          for k, v in ipairs(best_route) do QuestHelper:ReleaseTable(v) end
          QuestHelper:ReleaseTable(best_route[0])
          while #best_route > 0 do table.remove(best_route) end
          for k, v in pairs(aobt) do best_route[k] = v end  -- hack
          setmetatable(aobt, Route)
          --[[ assert(best_route:sanity()) ]]
        end  -- hack
        
        -- this chunk of code used to live up by old_index ~= new_index, but it obviously no longer does. should probably be moved back once Best works again
        -- Maybe the bug he's referring to is the one I'm fighting with in this chunk of code? Hey dude, if you find a bug, *fix the damn bug don't work around it*
        --if old_index == new_index then
          -- We don't advance recheck_position unless the node doesn't get moved.
          -- TODO: As the this code is apparently bugged, it's gotten into an infinite loop of constantly swapping
          -- and hence never advancing. As a work around for now, we'll always advance.
          -- THIS IS A GREAT IDEA
        --else
        self.recheck_position = self.recheck_position + 1
        
      end
    end
    
    -- Remove any waypoints if needed.
    while true do
      local obj = next(to_remove)
      if not obj then break end
      to_remove[obj] = nil
      
      if obj.is_sharing then
        obj.is_sharing = false
        qh:DoUnshareObjective(obj)
      end
      
      for r in pairs(routes) do
        if r == best_route then
          local index = r:removeObjective(obj)
          table.remove(route, index)
          if index == 1 then
            minimap_dodad:SetObjective(route[1])
          end
        else
          r:removeObjective(obj)
        end
      end
      
      obj:DoneRouting()
      
      changed = true
    end
    
    -- Add any waypoints if needed
    while true do
      local obj = next(to_add)
      if not obj then break end
      to_add[obj] = nil
      
      obj.filter_zone = obj.zones and obj.zones[pos[1].i] == nil
      obj.filter_watched = not obj:IsWatched()
      
      if obj:Known() then
        obj:PrepareRouting()
        
        obj.filter_zone = obj.zones[pos[1].i] == nil
        
        if obj.filter_zone and QuestHelper_Pref.filter_zone then
          -- Not going to add it, wrong zone.
          obj:DoneRouting()
          add_swap[obj] = true
        else
          if not obj.is_sharing and obj.want_share then
            obj.is_sharing = true
            qh:DoShareObjective(obj)
          end
          
          CalcObjectivePriority(obj)
          
          for r in pairs(routes) do
            if r == best_route then
              local index = r:addObjectiveBest(obj)
              obj.pos = r[index].pos
              table.insert(route, index, obj)
              if index == 1 then
                minimap_dodad:SetObjective(route[1])
              end
            else
              r:addObjectiveFast(obj)
            end
          end
          
          changed = true
        end
      else
        add_swap[obj] = true
      end
    end
    
    for obj in pairs(add_swap) do
      -- If one of the objectives we were considering adding was removed, it would be in both lists.
      -- That would be bad. We can't remove it because we haven't actually added it yet, so
      -- handle that special case here.
      if to_remove[obj] then
        to_remove[obj] = nil
        to_add[obj] = nil
        add_swap[obj] = nil
      end
    end
    
    to_add, add_swap = add_swap, to_add
    qh.to_add = to_add
    self.add_swap = add_swap
    
    if #best_route > 1 then
      -- If there is 2 or more objectives, randomly combine routes to (hopefully) create something better than we had before.
      
      -- Calculate best_route first, so that if other routes are identical, we don't risk swapping with them and
      -- updating the map_walker.
      local best, max_fitness = best_route, 1/(qh:ComputeTravelTime(pos, best_route[1].pos) + best_route.distance)
      best_route.fitness = max_fitness
      
      QH_Timeslice_Yield()
      
      for r in pairs(routes) do
        if r ~= best_route then
          local fit = 1/(qh:ComputeTravelTime(pos, r[1].pos)+r.distance)
          r.fitness = fit
          if fit > max_fitness then
            best, max_fitness = r, fit
          end
          QH_Timeslice_Yield()
        end
      end
      
      local to_breed, score
      
      for r in pairs(routes) do
        if r ~= best then
          local s = math.random()*r.fitness
          if not to_breed or s < score then
            to_breed, score = r, s
          end
        end
      end
      
      to_breed:breed(routes)
      
      if 1/(qh:ComputeTravelTime(pos, to_breed[1].pos)+to_breed.distance+improve_margin) > max_fitness then
        best = to_breed
      end
      
      QH_Timeslice_Yield()
      
      if best ~= best_route then
        
        --[[ assert(best:sanity()) ]]
        --[[ assert(best_route:sanity()) ]]
        
        best_route = best
        self.best_route = best_route
        
        for i, info in ipairs(best) do
          local obj = info.obj
          obj.pos = info.pos
          route[i] = obj
        end
        
        minimap_dodad:SetObjective(route[1])
        
        changed = true
      end
    end
    
    if qh.defered_flight_times then
      qh:buildFlightTimes()
      qh.defered_flight_times = false
      --[[ assert(qh.defered_graph_reset) ]]
    end
    
    if qh.defered_graph_reset then
      QH_Timeslice_Yield()
      
      for r in pairs(routes) do
        r:pathResetBegin()
      end
      
      qh.graph_in_limbo = true
      qh:ResetPathing()
      qh.graph_in_limbo = false
      qh.defered_graph_reset = false
      
      for r in pairs(routes) do
        r:pathResetEnd()
      end
      
      for i, info in ipairs(best_route) do
        local obj = info.obj
        obj.pos = info.pos
        route[i] = obj
      end
      best_route:recalculateDistances()
      
      minimap_dodad:SetObjective(route[1])
      
      QuestHelper:SetTargetLocationRecalculate()
      
      for r in pairs(routes) do
        --[[ assert(r:sanity()) ]]
      end
      best_route:sanity()
      
      QH_Timeslice_Yield()
    end
    
    if changed then
      map_walker:RouteChanged()
    end
    
    --[[ assert(#route == #best_route) ]]
    
    -- temporary hack to cause more errors
    --qh.defered_graph_reset = true
    --qh.defered_flight_times = true
    
    QH_Timeslice_Yield()
  end
end

function Routing:Initialize()
  self:RoutingSetup()
  
  QH_Timeslice_Add(function() Routing:RouteUpdateRoutine() end, "routing")
  QH_Timeslice_Toggle("routing", false)
  
  --[[
  if coroutine.coco then
    -- coco allows yielding across c boundries, which allows me to use xpcall to get
    -- stack traces for coroutines without calls to yield resulting in thermal nuclear meltdown.
    
    -- This isn't part of WoW, I was using it in my driver program: Development/routetest
    
    update_route = coroutine.create(
      function()
        local state, err = xpcall(
          function()
            Routing:RouteUpdateRoutine()
          end,
        function (err)
          if debugstack then
            return tostring(err).."\n"..debugstack(2)
          else
            return debug.traceback(tostring(err), 2)
          end
        end)
        
        if not state then
          error(err, 0)
        end
      end)
  else
    update_route = coroutine.create(function() Routing:RouteUpdateRoutine() end)
  end
  ]]
end
