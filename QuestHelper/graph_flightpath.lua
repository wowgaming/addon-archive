QuestHelper_File["graph_flightpath.lua"] = "1.4.1"
QuestHelper_Loadtime["graph_flightpath.lua"] = GetTime()

-- Name to Name, gives {time, accurate}
QH_Flight_Distances = {}
QH_Flight_Destinations = {}

local rlevel = nil
local cwf = nil

function QH_debug_flightpath()
  print(rlevel, cwf)
end

function QH_redo_flightpath()
  QuestHelper: Assert(DB_Ready())
  
  local globby
  if QuestHelper.loading_flightpath then
    globby = QuestHelper.loading_flightpath
  else
    QuestHelper.flightpathing = QuestHelper.CreateLoadingCounter()
    globby = QuestHelper.flightpathing
  end
  
  local load_earlyload = globby:MakeSubcategory(1)
  local load_preroll = globby:MakeSubcategory(1)
  local load_floyd = globby:MakeSubcategory(1)
  local load_postroll = globby:MakeSubcategory(0.1)
  
  load_preroll:SetPercentage(0)
  
  -- First, let's figure out if the player can fly.
  -- The logic we're using: if he has 225 or 300, then he can fly in Outland. If he's got Cold Weather Flying and those levels, he can fly in Northrend.
  if true then
    local ridingLevel = (select(4,GetAchievementInfo(892)) and 300) or (select(4,GetAchievementInfo(890)) and 225) or (select(4,GetAchievementInfo(889)) and 150) or (select(4,GetAchievementInfo(891)) and 75) or 0 -- this is thanks to Maldivia, who is a fucking genius
    local has_cwf = not not GetSpellInfo(GetSpellInfo(54197))
    
    local speed
    local cull
    if ridingLevel == 225 then
      speed = 17.5
      cull = false
    elseif ridingLevel == 300 then
      speed = 27
      cull = true
    end
    
    if ridingLevel >= 225 then
      QH_Graph_Flyplaneset(3, speed, cull) -- Outland
    end
    
    if ridingLevel >= 225 and has_cwf then
      QH_Graph_Flyplaneset(4, speed, cull) -- Northrend
    end
    
    rlevel = ridingLevel
    cwf = has_cwf
  else
    QuestHelper:TextOut("Horrible QH hack, mount flight disabled, please inform Zorba if this is in a release version")
  end
  
  local flightids = DB_ListItems("flightmasters")
  local flightdb = {}
  
  local has = {}
  local has_count = 0
  
  local fidcount = 0
  for k, v in pairs(flightids) do
    flightdb[v] = DB_GetItem("flightmasters", v, true, true)
    if QuestHelper_KnownFlightRoutes[flightdb[v].name] then
      has[k] = true
      has_count = has_count + 1
    end
    
    fidcount = fidcount + 1
    load_earlyload:SetPercentage(fidcount / QuestHelper:TableSize(flightids))
  end
  
  local adjacency = {}
  
  local important = {}
  
  QH_Timeslice_Yield()
  
  local has_seen = 0
  for k, v in pairs(has) do
    local tdb = DB_GetItem("flightpaths", k, true, true)
    if tdb then
      for dest, dat in pairs(tdb) do
        if has[dest] then
          for _, route in ipairs(dat) do
            local passes = true
            if route.path then for _, intermed in ipairs(route.path) do
              if not has[intermed] then passes = false break end
            end end
            
            if passes then
              --QuestHelper:TextOut(string.format("Found link between %s and %s, cost %f", flightdb[k].name, flightdb[dest].name, route.distance))
              if not adjacency[k] then adjacency[k] = {} end
              if not adjacency[dest] then adjacency[dest] = {} end
              QuestHelper: Assert(not (adjacency[k][dest] and adjacency[k][dest].time))
              adjacency[k][dest] = {time = route.distance, dist = route.distance, original = true}
              
              -- no such thing as strongly asymmetric routes
              -- note that we're only hitting up adjacency here, because we don't have "time info"
              if not adjacency[dest][k] then
                adjacency[dest][k] = {dist = route.distance * 1.1, original = true} -- It's original because, in theory, we may end up basing other links on this one. It's still not time-authoritative, though.
              end
              
              important[k] = true
              important[dest] = true
              break
            end
          end
        end
      end
      DB_ReleaseItem(tdb)
    end
    
    has_seen = has_seen + 1
    load_preroll:SetPercentage(has_seen / has_count)
  end
  
  QH_Timeslice_Yield()
  
  local imp_flat = {}
  local flightmasters = {}
  for k, v in pairs(important) do
    table.insert(imp_flat, k)
    if flightdb[k].mid then
      local fmx = DB_GetItem("monster", flightdb[k].mid, true, true)
      if fmx and fmx.loc then
        flightmasters[k] = QuestHelper:CreateTable("flightmaster cachey")
        for tk, v in pairs(fmx.loc[1]) do
          if not tk:match("__.*") then
            flightmasters[k][tk] = v
            --[[ QuestHelper:Assert(type(tk) ~= "table") ]]
            --[[ QuestHelper:Assert(type(v) ~= "table") ]]
          end
        end
      else
        --QuestHelper:TextOut(string.format("Missing flightmaster location for node %d/%s", k, tostring(flightdb[k].name)))
      end
      if fmx then DB_ReleaseItem(fmx) end
    else
      --QuestHelper:TextOut(string.format("Missing flightmaster for node %d/%s", k, tostring(flightdb[k].name)))
    end
  end
  table.sort(imp_flat)
  
  for _, v in ipairs(imp_flat) do
    adjacency[v] = adjacency[v] or {}
  end
  
  for idx, pivot in ipairs(imp_flat) do
    QH_Timeslice_Yield()
    for _, i in ipairs(imp_flat) do
      for _, j in ipairs(imp_flat) do
        if adjacency[i][pivot] and adjacency[pivot][j] then
          local cst = adjacency[i][pivot].dist + adjacency[pivot][j].dist
          if not adjacency[i][j] or adjacency[i][j].dist > cst then
            if not adjacency[i][j] then adjacency[i][j] = {} end
            adjacency[i][j].dist = cst
            adjacency[i][j].original = nil
          end
        end
      end
    end
    
    load_floyd:SetPercentage(idx / #imp_flat)
  end
  
  QH_Timeslice_Yield()
  
  do
    local clustaken = {}
    
    for src, t in pairs(adjacency) do
      if not clustaken[src] then
        local tcst = {}
        local tcct = 0
        local ctd = {}
        table.insert(ctd, src)
        
        while #ctd > 0 do
          local ite = table.remove(ctd)
          QuestHelper: Assert(not clustaken[ite] or tcst[ite])
          
          if not tcst[ite] then
            clustaken[ite] = true
            tcst[ite] = true
            for _, dst in pairs(imp_flat) do
              if adjacency[ite][dst] and not tcst[dst] then
                table.insert(ctd, dst)
              end
            end
            
            tcct = tcct + 1
          end
        end
        
        --QuestHelper: TextOut(string.format("Starting with %d, cluster of %d", src, tcct))
      end
    end
  end
  
  QH_Graph_Plane_Destroylinks("flightpath")
  
  -- reset!
  QH_Flight_Distances = {}
  QH_Flight_Destinations = {}
  
  for src, t in pairs(adjacency) do
    QH_Timeslice_Yield()
    
    for dest, dat in pairs(t) do
      do
        local fms = flightmasters[src]
        local fmd = flightmasters[dest]
        if fms and fmd then
          local fmsc = QuestHelper_ParentLookup[fms.p]
          local fmdc = QuestHelper_ParentLookup[fmd.p]
          QuestHelper: Assert(fmsc == fmdc)
        end
      end
      
      if not QH_Flight_Destinations[dest] and flightmasters[dest] then
        local fmd = flightmasters[dest]
        QH_Flight_Destinations[flightdb[dest].name] = {x = fmd.x, y = fmd.y, c = QuestHelper_ParentLookup[fmd.p], p = fmd.p}
      end
      
      do
        local sname = flightdb[src].name
        local dname = flightdb[dest].name
        
        if not QH_Flight_Distances[sname] then QH_Flight_Distances[sname] = {} end
        QuestHelper: Assert(not QH_Flight_Distances[sname][dname])
        QH_Flight_Distances[sname][dname] = {adjacency[src][dest].dist, not adjacency[src][dest].original}
      end
      
      if dat.original and not (src > dest and adjacency[dest][src] and adjacency[dest][src].original) then
        local fms = flightmasters[src]
        local fmd = flightmasters[dest]
        if fms and fmd then
          local snode = {x = fms.x, y = fms.y, c = QuestHelper_ParentLookup[fms.p], p = fms.p, map_desc = {QHFormat("WAYPOINT_REASON", QHFormat("FLIGHT_POINT", flightdb[src].name))}, condense_class = "flightpath"}
          local dnode = {x = fmd.x, y = fmd.y, c = QuestHelper_ParentLookup[fmd.p], p = fmd.p, map_desc = {QHFormat("WAYPOINT_REASON", QHFormat("FLIGHT_POINT", flightdb[dest].name))}, condense_class = "flightpath"}
          
          local ret = adjacency[dest][src] and adjacency[dest][src].original and adjacency[dest][src].dist
          QH_Graph_Plane_Makelink("flightpath", snode, dnode, dat.dist, ret)
        end
      end
    end
  end
  
  for _, v in pairs(flightdb) do
    DB_ReleaseItem(v)
  end
  for _, v in pairs(flightmasters) do
    QuestHelper:ReleaseTable(v)
  end
  
  load_postroll:SetPercentage(1)
  
  if not QuestHelper.loading_flightpath then
    QuestHelper.flightpathing = nil
  end
  
  QH_Graph_Plane_Refresh()
end
