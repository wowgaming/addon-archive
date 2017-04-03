QuestHelper_File["flightpath.lua"] = "1.4.1"
QuestHelper_Loadtime["flightpath.lua"] = GetTime()

local real_TakeTaxiNode = TakeTaxiNode
local real_TaxiNodeOnButtonEnter= TaxiNodeOnButtonEnter

--[[ assert(type(real_TakeTaxiNode) == "function") ]]
--[[ assert(type(real_TaxiNodeOnButtonEnter) == "function") ]]

local function LookupName(x, y)
  local best, d2
  for i = 1,NumTaxiNodes() do
    local u, v = TaxiNodePosition(i)
    u = u - x
    v = v - y
    u = u*u+v*v
    if not best or u < d2 then
      best, d2 = TaxiNodeName(i), u
    end
  end
  
  return best
end

local function getRoute(id)
  for i = 1,NumTaxiNodes() do
    if GetNumRoutes(i) == 0 then
      local routes = GetNumRoutes(id)
      if routes and routes > 0 and routes < 100 then
        local origin, dest = TaxiNodeName(i), TaxiNodeName(id)
        local path_hash = 0
        
        if routes > 1 then
          local path_str = ""
          
          for j = 1,routes-1 do
            path_str = string.format("%s/%s", path_str, LookupName(TaxiGetDestX(id, j), TaxiGetDestY(id, j)))
          end
          
          path_hash = QuestHelper:HashString(path_str)
        end
        
        return origin, dest, path_hash
      end
    end
  end
end

local function getSrcDest(id)
  local snode
  for i = 1, NumTaxiNodes() do
    if GetNumRoutes(i) == 0 then
      snode = TaxiNodeName(i)
      break
    end
  end
  local dnode = TaxiNodeName(id)
  return snode, dnode
end

local function getEtaEstimate(snode, dnode)
  local eta, estimate = nil, false
  if QH_Flight_Distances[snode] and QH_Flight_Distances[snode][dnode] then
    eta, estimate = unpack(QH_Flight_Distances[snode][dnode])
  end
  return eta, estimate
end

TaxiNodeOnButtonEnter = function(btn, ...)
  QuestHelper: Assert(btn)
  local rv = real_TaxiNodeOnButtonEnter(btn, ...)
  
  if QuestHelper_Pref.flight_time then
    local index = btn:GetID()
    if TaxiNodeGetType(index) == "REACHABLE" then
      
      local snode, dnode = getSrcDest(index)
      
      local eta, estimate = getEtaEstimate(snode, dnode)
      
      if eta then -- Going to replace the tooltip.
        GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
        GameTooltip:ClearLines()
        GameTooltip:AddLine(TaxiNodeName(index), "", 1.0, 1.0, 1.0)
        GameTooltip:AddDoubleLine(QHText("TRAVEL_ESTIMATE"), (estimate and "|cffffffff≈|r " or "")..QHFormat("TRAVEL_ESTIMATE_VALUE", eta))
        local cost = TaxiNodeCost(index)
        if cost > 0 then
          SetTooltipMoney(GameTooltip, cost)
        end
        GameTooltip:Show()
      end
    end
  end
  
  return rv
end

TakeTaxiNode = function(id)
  local src, dest = getSrcDest(id)
  
  if src then
    local flight_data = QuestHelper.flight_data
    if not flight_data then
      flight_data = QuestHelper:CreateTable()
      QuestHelper.flight_data = flight_data
    end
    
    flight_data.src = src
    flight_data.dest = dest
    flight_data.start_time = nil
    flight_data.end_time = nil
    flight_data.end_time_estimate = nil
  end
  
  real_TakeTaxiNode(id)
end

function QuestHelper:getFlightInstructor(area)
  local fi_table = QuestHelper_FlightInstructors_Local[self.faction]
  if fi_table then
    local npc = fi_table[area]
    if npc then
      return npc
    end
  end
  
  local static = QuestHelper_StaticData[QuestHelper_Locale]
  
  if static then
    fi_table = static.flight_instructors and static.flight_instructors[self.faction]
    if fi_table then
      return fi_table[area]
    end
  end
end

local function getTime(tbl, orig, dest, hash)
  tbl = tbl and tbl[orig]
  tbl = tbl and tbl[dest]
  return tbl and tbl[hash] ~= true and tbl[hash]
end

-- Okay, I think I've figured out what this is. Given fi1 and fi2, the standard horrifying "canonical/fallback" stuff that all this code does . . .
-- For each pair of "origin/dest" in tbl, determine if there is a direct path. (If there is, the hash will be 0.)
-- If so, find the flightpath distance and the "walking" distance. Add up walking and flightpath separately, and return the sums.
local function getWalkToFlight(tbl, fi1, fi2)
  local f, w = 0, 0
  
  if tbl then
    for origin, list in pairs(tbl) do
      for dest, hashlist in pairs(list) do
        if type(hashlist[0]) == "number" then
          local npc1, npc2 = (fi1 and fi1[origin]) or (fi2 and fi2[origin]), (fi1 and fi1[dest]) or (fi2 and fi2[dest])
          if npc1 and npc2 then
            local obj1, obj2 = QuestHelper:GetObjective("monster", npc1), QuestHelper:GetObjective("monster", npc2)
            obj1:PrepareRouting(true, {failable = true})
            obj2:PrepareRouting(true, {failable = true})
            
            local pos1, pos2 = obj1:Position(), obj2:Position()
            
            if pos1 and pos2 then
              local x, y = pos1[3]-pos2[3], pos1[4]-pos2[4]
              w = w + math.sqrt(x*x+y*y)
              f = f + hashlist[0]
            end
            
            obj2:DoneRouting()
            obj1:DoneRouting()
          end
        end
      end
    end
  end
  
  return f, w
end

-- Determines the general multiple faster than flying is than walking.
function QuestHelper:computeWalkToFlightMult()
  local l = QuestHelper_FlightRoutes_Local[self.faction]
  local s = QuestHelper_StaticData[self.locale]
  s = s and s.flight_routes
  s = s and s[self.faction]
  
  local fi1 = QuestHelper_FlightInstructors_Local[self.faction]
  local fi2 = QuestHelper_StaticData[self.locale]
  fi2 = fi2 and fi2.flight_instructors
  fi2 = fi2 and fi2[self.faction]
  
  local f1, w1 = getWalkToFlight(l, fi1, fi2)
  local f2, w2 = getWalkToFlight(s, fi1, fi2)
  return (f1+f2+0.032876)/(w1+w2+0.1)
end

function QuestHelper:computeLinkTime(origin, dest, hash, fallback)
  -- Only works for directly connected flight points.
  if origin == dest then
    return 0
  end
  
  local l = QuestHelper_FlightRoutes_Local[self.faction]
  local s = QuestHelper_StaticData[self.locale]
  s = s and s.flight_routes
  s = s and s[self.faction]
  
  hash = hash or 0
  
  -- Will try to lookup flight time there, failing that, will use the time from there to here.
  local t = getTime(l, origin, dest, hash) or getTime(s, origin, dest, hash) or
            getTime(l, dest, origin, hash) or getTime(s, dest, origin, hash) or fallback
  
  if t == nil then -- Don't have any recored information on this flight time, will estimate based on distances.
    l = QuestHelper_FlightInstructors_Local[self.faction]
    s = QuestHelper_StaticData[self.locale]
    s = s and s.flight_instructors
    s = s and s[self.faction]
    
    local npc1, npc2 = (l and l[origin]) or (s and s[origin]),
                       (l and l[dest]) or (s and s[dest])
    
    if npc1 and npc2 then
      local obj1, obj2 = self:GetObjective("monster", npc1), self:GetObjective("monster", npc2)
      obj1:PrepareRouting(true)
      obj2:PrepareRouting(true)
      
      local pos1, pos2 = obj1:Position(), obj2:Position()
      
      if pos1 and pos2 then
        local x, y = pos1[3]-pos2[3], pos1[4]-pos2[4]
        
        t = math.sqrt(x*x+y*y)*self.flight_scalar
      end
      
      obj2:DoneRouting()
      obj1:DoneRouting()
    end
  end
  
  if t and type(t) ~= "number" then
    QuestHelper:AppendNotificationError("2008-10-11 computelinktime is not a number", string.format("%s %s", type(t), fallback and type(fallback) or "(nil)"))
    return nil
  end
  return t
end

local moonglade_fp = nil

function QuestHelper:addLinkInfo(data, flight_times)
  if data then
    if select(2, UnitClass("player")) ~= "DRUID" then
      -- As only druids can use the flight point in moonglade, we need to figure out
      -- where it is so we can ignore it.
      
      if not moonglade_fp then
        
        local fi_table = QuestHelper_FlightInstructors_Local[self.faction]
        
        if fi_table then for area, npc in pairs(fi_table) do
          local npc_obj = self:GetObjective("monster", npc)
          npc_obj:PrepareRouting(true, {failable = true})
          local pos = npc_obj:Position()
          if pos and QuestHelper_IndexLookup[pos[1].c][pos[1].z] == 20 and string.find(area, ",") then -- I'm kind of guessing here
            moonglade_fp = area
            npc_obj:DoneRouting()
            break
          end
          npc_obj:DoneRouting()
        end end
        
        if not moonglade_fp then
          fi_table = QuestHelper_StaticData[QuestHelper_Locale]
          fi_table = fi_table and fi_table.flight_instructors and fi_table.flight_instructors[self.faction]
          
          if fi_table then for area, npc in pairs(fi_table) do
            local npc_obj = self:GetObjective("monster", npc)
            npc_obj:PrepareRouting(true, {failable = true})
            local pos = npc_obj:Position()
            if pos and QuestHelper_IndexLookup[pos[1].c][pos[1].z] == 20 and string.find(area, ",") then
              moonglade_fp = area
              npc_obj:DoneRouting()
              break
            end
            npc_obj:DoneRouting()
          end end
        end
        
        if not moonglade_fp then
          -- This will always be unknown for the session, even if you call buildFlightTimes again
          -- but if it's unknown then you won't be able to
          -- get the waypoint this session since you're not a druid
          -- so its all good.
          moonglade_fp = "unknown"
        end
      end
    end
    
    for origin, list in pairs(data) do
      local tbl = flight_times[origin]
      if not tbl then
        tbl = self:CreateTable("Flightpath AddLinkInfo origin table")
        flight_times[origin] = tbl
      end
      
      for dest, hashs in pairs(list) do
        if origin ~= moonglade_fp and QuestHelper_KnownFlightRoutes[dest] and hashs[0] then
          local tbl2 = tbl[dest]
          if not tbl2 then
            local t = self:computeLinkTime(origin, dest)
            if t then
              tbl2 = self:CreateTable("Flightpath AddLinkInfo origin->dest data table")
              tbl[dest] = tbl2
              tbl2[1] = t
              tbl2[2] = dest
            end
          end
        end
      end
    end
  end
end

local visited = {}

local function getDataTime(ft, origin, dest)
  local str = nil
  local data = ft[origin][dest]
  local t = data[1]
  
  for key in pairs(visited) do visited[key] = nil end
  
  while true do
    local n = data[2]
    
    -- We might be asked about a route that visits the same point multiple times, and
    -- since this is effectively a linked list, we need to check for this to avoid
    -- infinite loops.
    if visited[n] then return end
    visited[n] = true
    
    local temp = QuestHelper:computeLinkTime(origin, n, str and QuestHelper:HashString(str) or 0, false)
    
    if temp then
      t = temp + (n == dest and 0 or ft[n][dest][1])
    end
    
    if n == dest then break end
    str = string.format("%s/%s", str or "", n)
    data = ft[n][dest]
  end
  
  return t
end

-- Used for loading status results. This is a messy solution.
QuestHelper_Flight_Updates = 0
QuestHelper_Flight_Updates_Current = 0

function QuestHelper:buildFlightTimes()
  self.flight_scalar = self:computeWalkToFlightMult()
  
  local flight_times = self.flight_times
  if not flight_times then
    flight_times = self:CreateTable()
    self.flight_times = flight_times
  end
  
  for key, list in pairs(flight_times) do
    self:ReleaseTable(list)
    flight_times[key] = nil
  end
  
  local l = QuestHelper_FlightRoutes_Local[self.faction]
  local s = QuestHelper_StaticData[self.locale]
  s = s and s.flight_routes
  s = s and s[self.faction]
  
  self:addLinkInfo(l, flight_times)
  self:addLinkInfo(s, flight_times)
  
  QuestHelper_Flight_Updates_Current = 0
  
  -- This appears to set up flight_times so it gives directions from any node to any other node. I'm not sure what the getDataTime() call is all about, and I'm also not sure what dat[2] is for. In any case, I don't see anything immediately suspicious about this, just dubious.
  local cont = true
  while cont do
    cont = false
    local origin = nil
    while true do
      origin = next(flight_times, origin)
      if not origin then break end
      local list = flight_times[origin]
      
      for dest, data in pairs(list) do
        QuestHelper_Flight_Updates_Current = QuestHelper_Flight_Updates_Current + 1
        if flight_times[dest] then for dest2, data2 in pairs(flight_times[dest]) do
          if dest2 ~= origin then
            local dat = list[dest2]
            
            if not dat then
              dat = self:CreateTable()
              dat[1], dat[2] = data[1]+data2[1], dest
              list[dest2] = dat
              dat[1] = getDataTime(flight_times, origin, dest2)
              
              if not dat[1] then
                self:ReleaseTable(dat)
                list[dest2] = nil
              else
                cont = true
              end
            else
              local o1, o2 = dat[1], dat[2] -- Temporarly replace old data for the sake of looking up its time.
              if o2 ~= dest then
                dat[1], dat[2] = data[1]+data2[1], dest
                local t2 = getDataTime(flight_times, origin, dest2)
                
                if t2 and t2 < o1 then
                  dat[1] = t2
                  cont = true
                else
                  dat[1], dat[2] = o1, o2
                end
              end
            end
          end
        end end
        QH_Timeslice_Yield()
      end
    end
  end
  
  QuestHelper_Flight_Updates = QuestHelper_Flight_Updates_Current
  
  -- Replace the tables with simple times.
  for orig, list in pairs(flight_times) do
    for dest, data in pairs(list) do
      local t = data[1]
      self:ReleaseTable(data)
      list[dest] = t
    end
  end
end

function QuestHelper:taxiMapOpened()
  for i = 1,NumTaxiNodes() do
    local name = TaxiNodeName(i)
    if not QuestHelper_KnownFlightRoutes[name] then
      QuestHelper_KnownFlightRoutes[name] = true
      self:TextOut("New flight master: " .. name)
      QH_Route_FlightPathRecalc()
    end
  end
end

local elapsed = 0
local function flight_updater(frame, delta)
  elapsed = elapsed + delta
  if elapsed > 1 then
    elapsed = elapsed - 1
    local data = QuestHelper.flight_data
    if data then
      frame:SetText(string.format("%s: %s", QuestHelper:HighlightText(select(3, string.find(data.dest, "^(.-),")) or data.dest),
                                            QuestHelper:TimeString(math.max(0, data.end_time_estimate-time()))))
    else
      frame:Hide()
      QH_Hook(frame, "OnUpdate", nil)
    end
  end
end

function QuestHelper:flightBegan()
  if self.flight_data and not self.flight_data.start_time then
    self.flight_data.start_time = GetTime()
    local src, dest = self.flight_data.src, self.flight_data.dest
    
    
    local eta, estimate = getEtaEstimate(src, dest)
    
    --[[
    local npc = self:getFlightInstructor(self.flight_data.dest) -- Will inform QuestHelper that we're going to be at this NPC in whenever.
    if npc then
      local npc_obj = self:GetObjective("monster", npc)
      npc_obj:PrepareRouting(true)
      local pos = npc_obj:Position()
      if pos then
        local c, z = pos[1].c, pos[1].z
        local x, y = self.Astrolabe:TranslateWorldMapPosition(c, 0,
                                                              pos[3]/self.continent_scales_x[c],
                                                              pos[4]/self.continent_scales_y[c], c, z)
        
        self:SetTargetLocation(QuestHelper_IndexLookup[c][z], x, y, eta)
        
      end
      npc_obj:DoneRouting()
    end]]
    
    do
      local loc = QH_Flight_Destinations[dest]
      if loc then -- sometimes we just don't have a loc, I think due to flightpath recalculations going on right then
        QuestHelper.routing_ac, QuestHelper.routing_ax, QuestHelper.routing_ay, QuestHelper.routing_c, QuestHelper.routing_z = QuestHelper_ParentLookup[loc.p], loc.x, loc.y, QuestHelper_ZoneLookup[loc.p][1], QuestHelper_ZoneLookup[loc.p][2]
      end
    end
    
    if eta and QuestHelper_Pref.flight_time then
      self.flight_data.end_time_estimate = time() + eta
      self:PerformCustomSearch(flight_updater) -- Reusing the search status indicator to display ETA for flight.
    end
  end
end

function QuestHelper:flightEnded(interrupted)
  local flight_data = self.flight_data
  if flight_data and not flight_data.end_time then
    flight_data.end_time = GetTime()
    
    self:UnsetTargetLocation()
    self:StopCustomSearch()
  end
end
