QuestHelper_File["routing_core.lua"] = "1.4.1"
QuestHelper_Loadtime["routing_core.lua"] = GetTime()

local debug_output = (QuestHelper_File["routing_core.lua"] == "Development Version")

--[[

let's think about clustering

Easiest way to pass in clusters, as we've already observed, is to just have a "cluster object" to pass in as an addition. This isn't a node, and we don't want to require "clusters" when people just want to add a single node. It isn't an objective either - it's a group of objectives, because when we return a route, we return a series of objectives.

So, "add cluster" is intrinsically different.

The next question, though, is how we link things. I'm liking the idea of the same ol' "link cluster X to cluster Y" thing. I think it's a good idea to create a list of "start nodes", though.

We're going to restrict it so that dependencies can only be done with clusters, just for the sake of my sanity.
This will also probably make it easier to ignore single parts of clusters, since we can do so by just tweaking the cluster definitions. I think this works.

I think this works tomorrow.

]]

--[[

hey hey ignoring is complicated so let's discuss that!

Problem: One item can be ignored by multiple modules. Further problem: One item can be "de-ignored" explicitly by the player. Further further problem: either clusters or items can be ignored.

Current solution: We provide "ignore" and "unignore" functions that take a cluster and an identifier. Ignoring only stacks if the identifier is unique. If X depends on Y, and Y is ignored, then X is implicitly ignored.

Later, we'll provide something similar on items (or just dump items entirely? it's not like they're used for anything)

]]

local QH_Timeslice_Yield = QH_Timeslice_Yield -- performance hack :(
local mpow = math.pow
local pairs, ipairs = pairs, ipairs
local random = math.random

local OptimizationHackery = false

if OptimizationHackery then debug_output = false end -- :ughh:


-- Ant colony optimization. Moving from X to Y has the quality (Distance[x,y]^alpha)*(Weight[x,y]^beta). Sum all available qualities, then choose weighted randomly.
-- Weight adjustment: Weight[x,y] = Weight[x,y]*weightadj + sum(alltravels)(1/distance_of_travel)    (note: this is somewhat out of date)

-- Configuration
  local PheremonePreservation = 0.98 -- must be within 0 and 1 exclusive
  local AntCount = 20 -- number of ants to run before doing a pheremone pass

    -- Weighting for the various factors
  local WeightFactor = 0.61
  local DistanceFactor = -2.5
  local DistanceDeweight = 1.4 -- Add this to all distances to avoid sqrt(-1) deals
  
  -- Small amount to add to all weights to ensure it never hits, and to make sure things can still be chosen after a lot of iterations
  local UniversalBonus = 0.06
-- End configuration

local Notifier
local DistBatch

-- Node storage and data structures
  local CurrentNodes = 1
  local ActiveNodes = {1}
  local DeadNodes = {}
  
  local NodeIgnored = {[1] = {}}
  local NodeIgnoredCount = {[1] = 0}
  
  -- Clusters
  local Cluster = {} -- Goes from cluster ID to node IDs
  local ClusterLookup = {} -- Goes from node ID to cluster ID
  local ClusterTableLookup = {} -- Goes from the actual cluster table to the cluster ID
  local ClusterDead = {} -- List of dead clusters that can be reclaimed
  
  local ClusterIgnored = {} -- key-to-table-of-reasons-ignored
  local ClusterIgnoredCount = {}
  local ClusterIgnoredNodeActive = {}
  
  local ClusterPriority = {}
  local Priorities = {}
  local PriorityCount = {}
  
  local DependencyLinks = {}  -- Every cluster that cluster X depends on
  local DependencyLinksReverse = {}  -- Every cluster that is depended on by cluster X
  local DependencyCounts = {}  -- How many different nodes cluster X depends on

  local StartNode = {ignore = true, loc = {x = 37690, y = 19671, p = 25, c = 0}}  -- Ironforge mailbox :)

  local NodeLookup = {[StartNode] = 1}
  local NodeList = {[1] = StartNode}
  local Distance = {{0}}
  local Weight = {{0}}
  
  local DistanceWaiting = {} -- which node indices are waiting for distance data
  
  weight_ave = 0.001
-- End node storage and data structures

local early_exit = false

--[[
----------------------------------
Here's that wacky storage system.
----------------------------------]]

local function unsigned2b(c)
  if c > 65535 then -- ughh. again.
    print(c)
    c = 65535
  end
  
  if not (c < 65536) then
    print(c)
  end
  QuestHelper: Assert(c < 65536)
  
  QuestHelper: Assert(bit.mod(c, 256))
  QuestHelper: Assert(bit.rshift(c, 8))
  local strix = strchar(bit.mod(c, 256), bit.rshift(c, 8))
  QuestHelper: Assert(#strix == 2)
  return strix
end

-- L
local loopcount = 0
local function Storage_Loop()
  loopcount = loopcount + 1
end
local function Storage_LoopFlush()
  if loopcount > 0 then
    QH_Merger_Add(QH_Collect_Routing_Dump, "L" .. unsigned2b(loopcount) .. "L")
    loopcount = 0
  end
end

-- -
local function Storage_Distance_StoreFromIDToAll(id)
  if not QH_Collect_Routing_Dump then return end
  Storage_LoopFlush()
  
  QH_Merger_Add(QH_Collect_Routing_Dump, "-" .. unsigned2b(id))
  for _, v in ipairs(ActiveNodes) do
    QH_Merger_Add(QH_Collect_Routing_Dump, unsigned2b(Distance[id][v]))
  end
  QH_Merger_Add(QH_Collect_Routing_Dump, "-")
end

-- X
local function Storage_Distance_StoreCrossID(id)
  if not QH_Collect_Routing_Dump then return end
  Storage_LoopFlush()
  
  QH_Merger_Add(QH_Collect_Routing_Dump, "X")
  for _, v in ipairs(ActiveNodes) do
    QH_Merger_Add(QH_Collect_Routing_Dump, unsigned2b(Distance[id][v]))
    if v ~= id then QH_Merger_Add(QH_Collect_Routing_Dump, unsigned2b(Distance[v][id])) end
  end
  QH_Merger_Add(QH_Collect_Routing_Dump, "X")
end

-- #
local function Storage_Distance_StoreAll()
  if not QH_Collect_Routing_Dump then return end
  Storage_LoopFlush()
  
  QH_Merger_Add(QH_Collect_Routing_Dump, "#")
  for _, v in ipairs(ActiveNodes) do
    for _, w in ipairs(ActiveNodes) do
      QH_Merger_Add(QH_Collect_Routing_Dump, unsigned2b(Distance[v][w]))
    end
  end
  QH_Merger_Add(QH_Collect_Routing_Dump, "#")
end

-- A
local function Storage_NodeAdded(id)
  if not QH_Collect_Routing_Dump then return end
  Storage_LoopFlush()
  
  QH_Merger_Add(QH_Collect_Routing_Dump, "A" .. unsigned2b(id))
  Storage_Distance_StoreCrossID(id)
  QH_Merger_Add(QH_Collect_Routing_Dump, "A")
end

-- R
local function Storage_NodeRemoved(id)
  if not QH_Collect_Routing_Dump then return end
  Storage_LoopFlush()
  
  QH_Merger_Add(QH_Collect_Routing_Dump, "R" .. unsigned2b(id) .. "R")
end

-- C
local function Storage_ClusterCreated(id)
  if not QH_Collect_Routing_Dump then return end
  Storage_LoopFlush()
  
  QH_Merger_Add(QH_Collect_Routing_Dump, "C" .. unsigned2b(id) .. unsigned2b(#Cluster[id]))
  for _, v in ipairs(Cluster[id]) do
    QH_Merger_Add(QH_Collect_Routing_Dump, unsigned2b(v))
  end
  QH_Merger_Add(QH_Collect_Routing_Dump, "C")
end

-- D
local function Storage_ClusterDestroyed(id)
  if not QH_Collect_Routing_Dump then return end
  Storage_LoopFlush()
  
  QH_Merger_Add(QH_Collect_Routing_Dump, "D" .. unsigned2b(id) .. "D")
end

-- >
local function Storage_ClusterDependency(from, to)
  if not QH_Collect_Routing_Dump then return end
  Storage_LoopFlush()
  
  QH_Merger_Add(QH_Collect_Routing_Dump, ">" .. unsigned2b(from) .. unsigned2b(to) .. ">")
end

--[[
----------------------------------
and here's the other end of the wacky storage system
----------------------------------]]

-- we may need to play with these
local QH_Route_Core_NodeAdd_Internal
local QH_Route_Core_NodeRemove_Internal

if OptimizationHackery then
  function Unstorage_SetDists(newdists)
    local tc = 1
    QuestHelper: Assert(#newdists == #ActiveNodes * #ActiveNodes)
    for _, v in ipairs(ActiveNodes) do
      for _, w in ipairs(ActiveNodes) do
        Distance[v][w] = newdists[tc]
        tc = tc + 1
      end
    end
    QuestHelper: Assert(tc - 1 == #newdists)
  end
  
  function Unstorage_SetDistsX(pivot, newdists)
    local tc = 1
    QuestHelper: Assert(#newdists == #ActiveNodes * 2 - 1)
    for _, v in ipairs(ActiveNodes) do
      Distance[pivot][v] = newdists[tc]
      tc = tc + 1
      if v ~= pivot then
        Distance[v][pivot] = newdists[tc]
        tc = tc + 1
      end
    end
    QuestHelper: Assert(tc - 1 == #newdists)
  end
  
  function Unstorage_SetDistsLine(pivot, newdists)
    local tc = 1
    QuestHelper: Assert(#newdists == #ActiveNodes)
    
    if pivot == 1 then
      if last_best and #last_best > 1 then
        last_best.distance = last_best.distance - Distance[last_best[1]][last_best[2]]
      end
    end
    
    for _, v in ipairs(ActiveNodes) do
      Distance[pivot][v] = newdists[tc]
      tc = tc + 1
    end
    QuestHelper: Assert(tc - 1 == #newdists)
    
    if pivot == 1 then
      if last_best and #last_best > 1 then
        last_best.distance = last_best.distance + Distance[last_best[1]][last_best[2]]
      end
    end
  end
  
  function Unstorage_Add(nod)
    QH_Route_Core_NodeAdd_Internal({}, nod)
  end
  
  function Unstorage_Remove(nod)
    QH_Route_Core_NodeRemove_Internal({}, nod)
  end
  
  function Unstorage_ClusterAdd(nod, tab)
    QH_Route_Core_ClusterAdd({}, nod)
    for _, v in ipairs(tab) do
      QuestHelper: Assert(NodeList[v])
      ClusterLookup[v] = nod
      table.insert(Cluster[nod], v)
    end
  end
  
  function Unstorage_ClusterRemove(nod)
    QH_Route_Core_ClusterRemove({}, nod)
  end
  
  function Unstorage_Link(a, b)
    QH_Route_Core_ClusterRequires(a, b, true)
  end
  
  function Unstorage_Nastyscan()
    for _, v in ipairs(ActiveNodes) do
      for _, w in ipairs(ActiveNodes) do
        QuestHelper: Assert(Distance[v][w])
        QuestHelper: Assert(Weight[v][w])
      end
    end
  end
  
  function Unstorage_Magic(tab)
    local touched = {}
    
    PheremonePreservation = tab.PheremonePreservation  QuestHelper: Assert(PheremonePreservation)   touched.PheremonePreservation = true
    AntCount = tab.AntCount  QuestHelper: Assert(AntCount)   touched.AntCount = true
    WeightFactor = tab.WeightFactor  QuestHelper: Assert(WeightFactor)   touched.WeightFactor = true
    DistanceFactor = tab.DistanceFactor  QuestHelper: Assert(DistanceFactor)   touched.DistanceFactor = true
    DistanceDeweight = tab.DistanceDeweight  QuestHelper: Assert(DistanceDeweight)   touched.DistanceDeweight = true
    UniversalBonus = tab.UniversalBonus  QuestHelper: Assert(UniversalBonus)   touched.UniversalBonus = true
    
    for k, v in pairs(tab) do
      QuestHelper: Assert(touched[k])
    end
  end
end

--[[
----------------------------------
here ends the butt of the wacky storage system. yeah, that's right. I said butt. Butt. Hee hee. Butt.
----------------------------------]]

function QH_Route_Core_EarlyExit()
  early_exit = true
  QH_Timeslice_Bump("new_routing", 50)
end

function QH_Route_Core_NodeCount()
  return #ActiveNodes
end

function QH_Route_Core_TraverseNodes(func)
  for _, v in ipairs(ActiveNodes) do
    if v ~= 1 then
      local blocked = false
      if ClusterLookup[v] and DependencyLinks[ClusterLookup[v]] and #DependencyLinks[ClusterLookup[v]] > 0 then blocked = true end
      --print("nlx", NodeList[v], blocked)
      func(NodeList[v], blocked)
    end
  end
end

function QH_Route_Core_TraverseClusters(func)
  for k, v in pairs(ClusterTableLookup) do
    func(k)
  end
end

function QH_Route_Core_IgnoredReasons_Cluster(clust, func)
  for k, _ in pairs(ClusterIgnored[ClusterTableLookup[clust]]) do
    if type(k) == "table" then
      func(k)
    end
  end
end

function QH_Route_Core_IgnoredReasons_Node(node, func)
  for k, _ in pairs(NodeIgnored[NodeLookup[node]]) do
    if type(k) == "table" then
      func(k)
    end
  end
end

function QH_Route_Core_Ignored_Cluster(clust)
  return ClusterIgnoredCount[ClusterTableLookup[clust]] ~= 0
end

function QH_Route_Core_Ignored_Cluster_Active(clust)
  return ClusterIgnoredNodeActive[ClusterTableLookup[clust]]
end

-- fuck floating-point
local function almost(a, b)
  if a == b then return true end
  if type(a) ~= "number" or type(b) ~= "number" then return false end
  if a == 0 or b == 0 then return false end
  return math.abs(a / b - 1) < 0.0001
end

-- Initialization
function QH_Route_Core_Init(PathNotifier, DistanceBatch)
  Notifier = PathNotifier
  DistBatch = DistanceBatch
  QuestHelper: Assert(Notifier)
  QuestHelper: Assert(DistBatch)
end
-- End initialization

local last_best = nil
local last_best_tweaked = false

local function ValidateNumber(x)
  QuestHelper: Assert(x == x)
  QuestHelper: Assert(x ~= math.huge)
  QuestHelper: Assert(x ~= -math.huge)
end

local function GetWeight(x, y)
  if x == y then return 0.00000000001 end -- sigh
  --local idx = GetIndex(x, y)
  --local revidx = GetIndex(y, x)
  if not Weight[x][y] or not Distance[x][y] then
    RTO(string.format("%d/%d %d", x, y, CurrentNodes))
    QuestHelper: Assert(x <= CurrentNodes)
    QuestHelper: Assert(y <= CurrentNodes)
    QuestHelper: Assert(false)
  end
  local weight = mpow(Weight[x][y], WeightFactor) * mpow(Distance[x][y] + DistanceDeweight, DistanceFactor)
  --print(Weight[idx], Weight[revidx], bonus, WeightFactor, Distance[idx], DistanceFactor)
  --ValidateNumber(weight)
  return weight
end

-- Realtime splice
  local function DespliceCN(cluster, node)
    QuestHelper: Assert(not cluster or not node)
    QuestHelper: Assert(cluster or node)
    if not last_best then return end
    
    local ct = 0
    for i = 2, #last_best do
      if last_best[i] and (last_best[i] == node or ClusterLookup[last_best[i]] == cluster) then
        -- Splice it out!
        last_best.distance = last_best.distance - Distance[last_best[i - 1]][last_best[i]]
        if i ~= #last_best then
          last_best.distance = last_best.distance - Distance[last_best[i]][last_best[i + 1]]
        end
        table.remove(last_best, i)
        if i ~= #last_best + 1 then
          last_best.distance = last_best.distance + Distance[last_best[i - 1]][last_best[i]]
        end
        
        ct = ct + 1
        i = i - 1
      end
    end
    
    last_best_tweaked = true
    
    --QuestHelper:TextOut("Despliced with " .. ct)
  end
  
  local function SpliceIn(index, touched)
    QuestHelper: Assert(index)
    QuestHelper: Assert(last_best)
    if touched[index] then return end
    
    QH_Timeslice_Yield()
    
    -- First, try to splice everything it depends on
    if DependencyLinks[index] then for _, v in ipairs(DependencyLinks[index]) do
      if SpliceIn(v, touched) then
        return true
      end
    end end
    
    local dl_lookup = QuestHelper:CreateTable("splice dl lookup")
    local dlr_lookup = QuestHelper:CreateTable("splice dlr lookup")
    if DependencyLinks[index] then for _, v in ipairs(DependencyLinks[index]) do dl_lookup[v] = true end end
    if DependencyLinksReverse[index] then for _, v in ipairs(DependencyLinksReverse[index]) do dlr_lookup[v] = true end end
    
    local start_bound = 2
    local end_bound
    
    -- Next, figure out where it can go
    for i = 2, #last_best do
      --print(index, last_best[i], ClusterLookup[last_best[i]], dl_lookup[ClusterLookup[last_best[i]]], dlr_lookup[ClusterLookup[last_best[i]]], ClusterPriority[ClusterLookup[last_best[i]]], ClusterPriority[index])
      if dl_lookup[ClusterLookup[last_best[i]]] then start_bound = i + 1 end
      if dlr_lookup[ClusterLookup[last_best[i]]] and not end_bound then end_bound = i end
      if ClusterPriority[ClusterLookup[last_best[i]]] < ClusterPriority[index] then start_bound = i + 1 end
      if ClusterPriority[ClusterLookup[last_best[i]]] > ClusterPriority[index] and not end_bound then end_bound = i end
    end
    if not end_bound then end_bound = #last_best + 1 end
    --QuestHelper: TextOut(string.format("Placed cluster %d between %d and %d", index, start_bound, end_bound))
    
    if end_bound < start_bound then
      -- arrrrgh
      -- this should never happen, but I don't want it to show up all the time, sooooo
      QuestHelper_ErrorCatcher_ExplicitError(false, string.format("Routing paradox: %d and %d, panicking and restarting", start_bound, end_bound))
      return true
    end
    
    -- Figure out the best place to put it
    local best_spot = nil
    local best_node = nil
    local best_cost = nil
    for i = start_bound, end_bound do
      for _, nindex in ipairs(Cluster[index]) do
        if NodeIgnoredCount[nindex] == 0 then
          local tcost = Distance[last_best[i - 1]][nindex]  -- Cost of that-node-to-this-one
          if i <= #last_best then
            tcost = tcost + Distance[nindex][last_best[i]] - Distance[last_best[i - 1]][last_best[i]]
          end
          if not best_cost or tcost < best_cost then
            best_spot, best_node, best_cost = i, nindex, tcost
          end
        end
      end
    end
    
    QuestHelper: Assert(best_spot)
    table.insert(last_best, best_spot, best_node)
    last_best.distance = last_best.distance + best_cost
    
    touched[index] = true
    last_best_tweaked = true
    
    QuestHelper:ReleaseTable(dl_lookup)
    QuestHelper:CreateTable(dlr_lookup)
  end
-- end realtime splice

-- Yeah, this function, right here? This is QH's brain. This is the only thing in all of Questhelper that actually generates routes. THIS IS IT.
local function RunAnt()
  local route = NewRoute()
  route[1] = 1
  route.distance = 0
  
  local dependencies = QuestHelper:CreateTable("route_core_dependencies")
  
  local needed = QuestHelper:CreateTable("route_core_needed")
  local needed_count = 0
  local needed_ready_count = 0
  
  for k, v in pairs(DependencyCounts) do
    dependencies[k] = v
    QuestHelper: Assert(dependencies[k] >= 0)
  end
  
  local curloc = 1
  
  local gwc = QuestHelper:CreateTable("route_core_gwc")
  
  TestShit()
  
  for k, v in ipairs(Priorities) do
    if Priorities[k + 1] then
      QuestHelper: Assert(Priorities[k] < Priorities[k + 1])
    end
  end
  
  for _, current_pri in ipairs(Priorities) do
    
    -- Here is we add the new batch of nodes
    for _, v in ipairs(ActiveNodes) do
      QH_Timeslice_Yield()
      if v ~= 1 then -- if it's ignored, then we just plain don't do anything
        local clustid = ClusterLookup[v]
        QuestHelper: Assert(clustid)
        
        if ClusterPriority[clustid] < current_pri then
          QuestHelper: Assert(dependencies[clustid] == -1 or NodeIgnoredCount[v] > 0 or ClusterIgnoredCount[clustid] >= 0)
        elseif ClusterPriority[clustid] == current_pri then
          if NodeIgnoredCount[v] == 0 and ClusterIgnoredCount[clustid] == 0 then
            local need = false
            
            QuestHelper: Assert(dependencies[clustid])
            if dependencies[clustid] == 0 then
              needed[v] = true
              needed_ready_count = needed_ready_count + 1
            end
            
            needed_count = needed_count + 1
          end
        else
          QuestHelper: Assert(dependencies[clustid] ~= -1, clustid)
        end
      end
    end
    
    if not (needed_ready_count > 0 or needed_count == 0) then
      QuestHelper: Assert(needed_ready_count > 0 or needed_count == 0, string.format("%d %d", needed_ready_count, needed_count))  -- I should really rig this to output stuff of this sort more easily
    end
    
    while needed_count > 0 do
      QH_Timeslice_Yield()
      if early_exit then if debug_output then QuestHelper:TextOut("early exit") end return end
      QuestHelper: Assert(needed_ready_count > 0)
      
      local accumulated_weight = 0
      local tweight = 0
      for k, _ in pairs(needed) do
        local tw = GetWeight(curloc, k)
        gwc[k] = tw
        accumulated_weight = accumulated_weight + tw
      end
    
      tweight = accumulated_weight
      accumulated_weight = accumulated_weight * random()
      
      QH_Timeslice_Yield()
      if early_exit then if debug_output then QuestHelper:TextOut("early exit") end return end
      
      local nod = nil
      for k, _ in pairs(needed) do
        accumulated_weight = accumulated_weight - gwc[k]
        if accumulated_weight < 0 then
          nod = k
          break
        end
      end
      
      if not nod then
        RTO(string.format("no nod :( %f/%f", accumulated_weight, tweight))
        for k, _ in pairs(needed) do
          nod = k
          break
        end
      end
      
      -- Now we've chosen stuff. Bookkeeping.
      local clust = ClusterLookup[nod]
      QuestHelper: Assert(clust)
      
      -- Obliterate other cluster items. Guaranteed to be at the same priority level.
      for _, v in pairs(Cluster[clust]) do
        if NodeIgnoredCount[v] == 0 then
          needed[v] = nil
          needed_count = needed_count - 1
          needed_ready_count = needed_ready_count - 1
        end
      end
      
      -- Dependency links.
      if DependencyLinksReverse[clust] then for _, v in ipairs(DependencyLinksReverse[clust]) do
        dependencies[v] = dependencies[v] - 1
        QuestHelper: Assert(dependencies[v] >= 0)
        if dependencies[v] == 0 and ClusterIgnoredCount[v] == 0 and ClusterPriority[v] == current_pri then
          for _, v in pairs(Cluster[v]) do
            if NodeIgnoredCount[v] == 0 then
              needed[v] = true
              needed_ready_count = needed_ready_count + 1
            end
          end
        end
      end end
      
      QuestHelper: Assert(dependencies[clust] == 0)
      QuestHelper: Assert(ClusterPriority[clust] == current_pri)
      dependencies[clust] = -1
      
      --print(needed_count, needed_ready_count)
      
      route.distance = route.distance + Distance[curloc][nod]
      table.insert(route, nod)
      curloc = nod
    end
    
    QuestHelper: Assert(needed_ready_count == 0 and needed_count == 0)
  end

  QuestHelper:ReleaseTable(gwc)  
  QuestHelper:ReleaseTable(dependencies)
  QuestHelper:ReleaseTable(needed)
  
  return route
end

-- Lots of doublechecks to make sure our route is both sane and complete
local function CheckRoute(route)
  --print("starting check")
  
  QuestHelper: Assert(route[1] == 1)  -- starting at the beginning
  
  local td = 0
  for i = 1, #route - 1 do
    td = td + Distance[route[i]][route[i + 1]]
  end
  --print(td, route.distance)
  QuestHelper: Assert(abs(td - route.distance) < 5 or abs(td / route.distance - 1) < 0.0001)
  
  local seen = QuestHelper:CreateTable("check seen")
  
  local cpri = nil
  for i = 1, #route do
    QuestHelper: Assert(NodeIgnoredCount[route[i]] == 0)
    
    local clust = ClusterLookup[route[i]]
    if clust then
      --print("seeing cluster ", clust, cpri, ClusterPriority[clust])
      QuestHelper: Assert(ClusterIgnoredCount[clust] == 0)
      QuestHelper: Assert(not seen[clust])
      seen[clust] = true
      QuestHelper: Assert(not cpri or cpri <= ClusterPriority[clust])
      cpri = ClusterPriority[clust]
      
      if DependencyLinks[clust] then for _, v in ipairs(DependencyLinks[clust]) do QuestHelper: Assert(seen[v]) end end
      if DependencyLinksReverse[clust] then for _, v in ipairs(DependencyLinksReverse[clust]) do QuestHelper: Assert(not seen[v]) end end
    end
  end
  
  for k, v in pairs(ClusterIgnoredCount) do
    QuestHelper: Assert(not seen[k] == (ClusterIgnoredCount[k] > 0))
  end
  
  QuestHelper:ReleaseTable(seen)
  
  --print("ending check")
end

local function BetterRoute(route)
  CheckRoute(route)
  local rt = {}
  for k, v in ipairs(route) do
    rt[k] = NodeList[v]
  end
  rt.distance = route.distance -- this is probably temporary
  Notifier(rt)
end

local QH_Route_Core_DistanceClear_Local -- sigh
-- Core process function
function QH_Route_Core_Process()
  early_exit = false
  --QuestHelper:TextOut("Startprocess")
  
  Storage_Loop()
  
  --QuestHelper:TextOut("Pathing")
  
  -- First we check to see if we need to add more distances, and if so, we do so
  
  local route_tweak_progress
  local better_route_progress
  do
    local refreshcount = 0
    for k, v in pairs(DistanceWaiting) do
      refreshcount = refreshcount + 1
    end
    
    --[[ assert(not QuestHelper.route_change_progress) ]]
    
    if refreshcount > 0 then
      QuestHelper.route_change_progress = QuestHelper.CreateLoadingCounter()
      
      route_tweak_progress = QuestHelper.route_change_progress:MakeSubcategory(0.1)
      better_route_progress = QuestHelper.route_change_progress:MakeSubcategory(0.2)
      
      if debug_output then QuestHelper:TextOut(string.format("Refreshing %d", refreshcount)) end
      if refreshcount >= #ActiveNodes / 2 then
        -- Refresh everything!
        QH_Route_Core_DistanceClear_Local(QuestHelper.route_change_progress:MakeSubcategory(0.7))
      else
        local resynch_progress = QuestHelper.route_change_progress:MakeSubcategory(0.7)
        
        local tlnod = QuestHelper:CreateTable("routecore distance tlnod")
        for _, v in ipairs(ActiveNodes) do
          table.insert(tlnod, NodeList[v])
        end
        
        local ct = 0
        for idx, _ in pairs(DistanceWaiting) do ct = ct + 1 end
        
        local ctd = 0
        for idx, _ in pairs(DistanceWaiting) do
          -- Refresh a subset of things.
          local forward = DistBatch(NodeList[idx], tlnod)
          local backward = DistBatch(NodeList[idx], tlnod, true)
          
          for k, v in ipairs(ActiveNodes) do
            Distance[idx][v] = forward[k]
            Distance[v][idx] = backward[k]
          end
          
          QuestHelper:ReleaseTable(forward)
          QuestHelper:ReleaseTable(backward)
          
          ctd = ctd + 1
          resynch_progress:SetPercentage(ctd / ct)
        end
        QuestHelper:ReleaseTable(tlnod)
      end
      QuestHelper:ReleaseTable(DistanceWaiting)
      DistanceWaiting = QuestHelper:CreateTable("routecore distance waiting")
    end
  end
  
  --QuestHelper:TextOut("Inserting/removing")
  
  -- Next we see if last_best needs tweaking
  if last_best then
    local touched_clusts = QuestHelper:CreateTable("routing touched")
    for i = 2, #last_best do
      local clust = ClusterLookup[last_best[i]]
      QuestHelper: Assert(clust)
      QuestHelper: Assert(not touched_clusts[clust])
      touched_clusts[clust] = true
    end
    
    if not route_tweak_progress then
      --[[ assert(not QuestHelper.route_change_progress) ]]
      QuestHelper.route_change_progress = QuestHelper.CreateLoadingCounter()
      route_tweak_progress = QuestHelper.route_change_progress:MakeSubcategory(0.1)
      better_route_progress = QuestHelper.route_change_progress:MakeSubcategory(0.9)
    end
    
    local ct = 0
    for k, _ in pairs(Cluster) do ct = ct + 1 end
    
    local ctd = 0
    for k, _ in pairs(Cluster) do
      local exists = touched_clusts[k]
      local ignored = (ClusterIgnoredCount[k] ~= 0)
      QuestHelper: Assert(not (ignored and exists)) -- something went wrong, item should have been removed
      
      if not ignored and not exists then
        -- here we go
        if SpliceIn(k, touched_clusts) then
          last_best = nil
          break
        end
        last_best_tweaked = true
      end
      
      ctd = ctd + 1
      route_tweak_progress:SetPercentage(ctd / ct)
    end
    QuestHelper:ReleaseTable(touched_clusts)
  end
  
  --QuestHelper:TextOut("Posting")
  
  if last_best_tweaked and last_best then
    --QuestHelper:TextOut("Pushing tweaked")
    BetterRoute(last_best, better_route_progress)
    last_best_tweaked = false
  end
  
  QH_Timeslice_Bump_Reset("new_routing")
  
  QuestHelper.route_change_progress = nil
  
  local worst = 0
  
  local best_is_local = false
  
  --QuestHelper:TextOut("Anting")
  
  local trouts = QuestHelper:CreateTable("routing_core_trouts")
  for x = 1, AntCount do
    if early_exit then if debug_output then QuestHelper:TextOut("early exit") end return end -- get money fuck routing
    local ant = RunAnt()
    if ant then table.insert(trouts, ant) end
    if early_exit then if debug_output then QuestHelper:TextOut("early exit") end return end
    --if last_best then RTO(string.format("Path generated: %s vs %s", PathToString(trouts[#trouts]), PathToString(last_best))) end
    if not last_best or last_best.distance > trouts[#trouts].distance then
      if last_best and not best_is_local then QuestHelper:ReleaseTable(last_best) end
      
      best_is_local = true
      last_best = trouts[#trouts]
      BetterRoute(last_best)
    end
    
    worst = math.max(worst, trouts[#trouts].distance)
    
    QH_Timeslice_Yield()
  end
  
  --QuestHelper:TextOut("Cleanup")
  
  local scale
  if worst == last_best.distance then
    scale = 1
  else
    scale = 1 / (worst - last_best.distance)
  end
  
  QH_Timeslice_Yield()
  
  for _, x in ipairs(ActiveNodes) do
    local wx = Weight[x]
    for _, y in ipairs(ActiveNodes) do
      --local idx = GetIndex(x, y)
      wx[y] = wx[y] * PheremonePreservation + UniversalBonus
      --ValidateNumber(Weight[idx])
    end
  end
  
  QH_Timeslice_Yield()
  
  for _, x in ipairs(trouts) do
    local amount = 1 / x.distance
    for y = 1, #x - 1 do
      --local idx = GetIndex(x[y], x[y + 1])
      Weight[x[y]][x[y + 1]] = Weight[x[y]][x[y + 1]] + amount
      --ValidateNumber(Weight[idx])
    end
  end
  
  QH_Timeslice_Yield()
  
  local weitotal = 0
  local weicount = 0
  for _, x in ipairs(ActiveNodes) do
    local wx = Weight[x]
    for _, y in ipairs(ActiveNodes) do
      --local idx = GetIndex(x, y)
      weitotal = weitotal + wx[y]
      weicount = weicount + 1
    end
  end
  
  QH_Timeslice_Yield()
  
  weight_ave = weitotal / weicount
  
  for k, v in pairs(trouts) do
    if v ~= last_best then
      QuestHelper:ReleaseTable(v)
    end
  end
  QuestHelper:ReleaseTable(trouts)
  
  QH_Timeslice_Yield()  -- "heh"
  
  --QuestHelper:TextOut("Done")
end
-- End core loop

function QH_Core_Bump()
  for _, x in ipairs(ActiveNodes) do
    local wx = Weight[x]
    for _, y in ipairs(ActiveNodes) do
      wx[y] = weight_ave
    end
  end
  QH_Route_Core_EarlyExit()
end

-- Ignore/unignore
  local function RecursiveIgnoreCount(clustid, accum)
    if accum == 0 then return end
    --print(clustid, accum)
    
    if ClusterIgnoredCount[clustid] == 0 then QuestHelper: Assert(accum > 0) DespliceCN(clustid) end
    ClusterIgnoredCount[clustid] = ClusterIgnoredCount[clustid] + accum
    if ClusterIgnoredCount[clustid] == 0 then QuestHelper: Assert(accum < 0) end  -- Item being added, we'll handle this at the beginning of run
    
    if DependencyLinksReverse[clustid] then
      for _, v in pairs(DependencyLinksReverse[clustid]) do
        RecursiveIgnoreCount(v, accum)
      end
    end
  end
  
  local function Internal_IgnoreCluster(clustid, reason)
    QuestHelper: Assert(clustid)
    
    if not ClusterIgnored[clustid][reason] then
      ClusterIgnored[clustid][reason] = true
      RecursiveIgnoreCount(clustid, 1)
    end
  end
  
  local function Internal_UnignoreCluster(clustid, reason)
    QuestHelper: Assert(clustid)
    if ClusterIgnored[clustid][reason] then
      ClusterIgnored[clustid][reason] = nil
      RecursiveIgnoreCount(clustid, -1)
    end
  end
  
  function QH_Route_Core_IgnoreCluster(clust, reason)
    QuestHelper: Assert(type(reason) == "table")
    local clustid = ClusterTableLookup[clust]
    if not clustid then
      -- This can just happen due to the lag introduced by the controller, so, whatever
      --QuestHelper:TextOut("Attempted to ignore a cluster that no longer exists")
      return
    end
    
    Internal_IgnoreCluster(clustid, reason)
  end
  
  function QH_Route_Core_UnignoreCluster(clust, reason)
    QuestHelper: Assert(type(reason) == "table")
    local clustid = ClusterTableLookup[clust]
    if not clustid then
      -- This can just happen due to the lag introduced by the controller, so, whatever
      --QuestHelper:TextOut("Attempted to unignore a cluster that no longer exists")
      return
    end
    Internal_UnignoreCluster(clustid, reason)
  end
    
  function QH_Route_Core_IgnoreNode(node, reason)
    QuestHelper: Assert(type(reason) == "table")
    local nid = NodeLookup[node]
    if not nid then
      -- This can just happen due to the lag introduced by the controller, so, whatever 
      --QuestHelper:TextOut("Attempted to ignore a node that no longer exists")
      return
    end
    
    QuestHelper: Assert(nid)
    
    if not NodeIgnored[nid][reason] then
      NodeIgnored[nid][reason] = true
      
      NodeIgnoredCount[nid] = NodeIgnoredCount[nid] + 1
      if NodeIgnoredCount[nid] == 1 then
        DespliceCN(nil, nid)
        
        if ClusterLookup[nid] then
          local cloost = ClusterLookup[nid]
          
          ClusterIgnoredNodeActive[cloost] = ClusterIgnoredNodeActive[cloost] - 1
          if ClusterIgnoredNodeActive[cloost] == 0 then
            Internal_IgnoreCluster(cloost, "internal_node_ignored")
          end
        end
      end
    end
  end
  
  function QH_Route_Core_UnignoreNode(node, reason)
    QuestHelper: Assert(type(reason) == "table")
    local nid = NodeLookup[node]
    if not nid then
      -- This can just happen due to the lag introduced by the controller, so, whatever
      --QuestHelper:TextOut("Attempted to unignore a node that no longer exists")
      return
    end
    
    QuestHelper: Assert(nid)
    
    if NodeIgnored[nid][reason] then
      NodeIgnored[nid][reason] = nil
      
      NodeIgnoredCount[nid] = NodeIgnoredCount[nid] - 1
      if NodeIgnoredCount[nid] == 0 then
        -- Item being added
        
        if ClusterLookup[nid] then
          -- Item being added
          ClusterIgnoredNodeActive[ClusterLookup[nid]] = ClusterIgnoredNodeActive[ClusterLookup[nid]] + 1
          if ClusterIgnoredNodeActive[ClusterLookup[nid]] == 1 then
            Internal_UnignoreCluster(ClusterLookup[nid], "internal_node_ignored")
          end
        end
      end
    end
  end
  
  local QH_Route_Core_UnignoreCluster = QH_Route_Core_UnignoreCluster -- we're just saving this so it doesn't get splattered
-- End ignore/unignore

-- Node allocation and deallocation
  -- this is only separate so we can use it for the crazy optimization hackery
  local function Expand()
    for _, v in ipairs(Distance) do
      table.insert(v, 0)
    end
    for _, v in ipairs(Weight) do
      table.insert(v, 0)
    end
    table.insert(Distance, {})
    table.insert(Weight, {})
    
    for k = 1, CurrentNodes + 1 do
      table.insert(Distance[#Distance], 0)
      table.insert(Weight[#Weight], 0)
    end
    
    CurrentNodes = CurrentNodes + 1
  end
  
  -- This is pretty bad overall. Going from 0 nodes to N nodes is an O(n^3) operation. Eugh. Todo: allocate more than one at a time?
  local function AllocateExtraNode()
    if #DeadNodes > 0 then
      local nod = table.remove(DeadNodes)
      table.insert(ActiveNodes, nod)
      table.sort(ActiveNodes)
      return nod
    end
    
    -- We always allocate on the end, so we know this is safe.
    Expand()
    
    table.insert(DeadNodes, CurrentNodes)
    return AllocateExtraNode() -- ha ha
  end

  -- Set the start location
  function QH_Route_Core_SetStart(stt)
    -- We do some kind of ghastly things here.
    --TestShit()
    if last_best and #last_best > 1 then
      last_best.distance = last_best.distance - Distance[last_best[1]][last_best[2]]
    end
    
    NodeLookup[StartNode] = nil
    NodeList[1] = stt
    StartNode = stt
    NodeLookup[StartNode] = 1
    
    local tlnod = QuestHelper:CreateTable("routecore setstart tlnod")
    
    for _, v in ipairs(ActiveNodes) do
      if v ~= 1 then
        table.insert(tlnod, NodeList[v])
      end
    end
    
    local forward = DistBatch(NodeList[1], tlnod)
    
    local ct = 1
    for _, v in ipairs(ActiveNodes) do
      if v ~= 1 then
        QuestHelper: Assert(forward[ct])
        Distance[1][v] = forward[ct]
        ct = ct + 1
        
        Distance[v][1] = 65500 -- this should never be used anyway
      end
    end
    
    if last_best and #last_best > 1 then
      last_best.distance = last_best.distance + Distance[last_best[1]][last_best[2]]
    end
    
    QuestHelper:ReleaseTable(forward)
    QuestHelper:ReleaseTable(tlnod)
    
    Storage_Distance_StoreFromIDToAll(1)
    --TestShit()
    -- TODO: properly deallocate old startnode?
  end
  
  QH_Route_Core_NodeAdd_Internal = function (nod, used_idx)
    --QuestHelper:TextOut(tostring(nod))
    --TestShit()
    QuestHelper: Assert(nod)
    if NodeLookup[nod] then
      -- ughhh
      QuestHelper: Assert(not NodeLookup[nod], QuestHelper:StringizeTable(nod))
    end
    
    local idx
    if used_idx then
      QuestHelper: Assert(OptimizationHackery)
      QuestHelper: Assert(not NodeList[used_idx])
      idx = used_idx
      table.insert(ActiveNodes, used_idx)
      table.sort(ActiveNodes)
      if not Distance[idx] then Expand() QuestHelper: Assert(Distance[idx]) end
    else
      idx = AllocateExtraNode()
    end
    
    --RTO("|cffFF8080AEN: " .. tostring(idx))
    NodeLookup[nod] = idx
    NodeList[idx] = nod
    
    NodeIgnored[idx] = {}
    NodeIgnoredCount[idx] = 0
    
    for _, v in ipairs(ActiveNodes) do
      Weight[v][idx] = weight_ave
      Weight[idx][v] = weight_ave
    end
    
    DistanceWaiting[idx] = true
    
    -- Item being added
    
    return idx
  end

  -- Remove a node with the given location
  QH_Route_Core_NodeRemove_Internal = function (nod, used_idx)
    --TestShit()
    QuestHelper: Assert(nod)
    
    local idx
    if used_idx then
      QuestHelper: Assert(OptimizationHackery)
      QuestHelper: Assert(NodeList[used_idx])
      idx = used_idx
    else
      QuestHelper: Assert(NodeLookup[nod])
      idx = NodeLookup[nod]
    end
    
    --RTO("|cffFF8080RFN: " .. tostring(NodeLookup[nod]))
    NodeList[idx] = nil
    table.insert(DeadNodes, idx)
    local oas = #ActiveNodes
    for k, v in pairs(ActiveNodes) do if v == idx then table.remove(ActiveNodes, k) break end end -- this is pretty awful
    QuestHelper: Assert(#ActiveNodes < oas)
    NodeLookup[nod] = nil
    -- We don't have to modify the table itself, some sections are just "dead".
    --TestShit()
    
    DistanceWaiting[idx] = nil -- just in case we haven't updated it in the intervening time
    
    -- If we're a standalone node, nothing depends on us. If we're part of a cluster, the cluster's getting smoked anyway.
    NodeIgnored[idx] = nil
    NodeIgnoredCount[idx] = nil
    
    DespliceCN(nil, idx)
    
    return idx
  end
-- End node allocation and deallocation

function QH_Route_Core_ClusterAdd(clust, clustid_used)
  local clustid
  if clustid_used then
    QuestHelper: Assert(OptimizationHackery)
    QuestHelper: Assert(not Cluster[clustid_used])
    clustid = clustid_used
  else
    QuestHelper: Assert(#clust > 0)
    clustid = table.remove(ClusterDead)
    if not clustid then clustid = #Cluster + 1 end
  end
  
  if debug_output then QuestHelper:TextOut(string.format("Adding cluster %d", clustid)) end
  
  Cluster[clustid] = {}
  ClusterTableLookup[clust] = clustid
  
  ClusterIgnored[clustid] = {}
  ClusterIgnoredCount[clustid] = 0
  ClusterIgnoredNodeActive[clustid] = #clust
  
  ClusterPriority[clustid] = 0
  if not PriorityCount[0] then table.insert(Priorities, 0) table.sort(Priorities) end
  PriorityCount[0] = (PriorityCount[0] or 0) + 1
  
  -- if we're doing hackery, clust will just be an empty table and we'll retrofit stuff later
  for _, v in ipairs(clust) do
    local idx = QH_Route_Core_NodeAdd_Internal(v)
    Storage_NodeAdded(idx)
    ClusterLookup[idx] = clustid
    table.insert(Cluster[clustid], idx)
  end
  
  DependencyCounts[clustid] = 0
  
  Storage_ClusterCreated(clustid)
end

function QH_Route_Core_ClusterRemove(clust, clustid_used)
  local clustid
  if clustid_used then
    QuestHelper: Assert(OptimizationHackery)
    QuestHelper: Assert(Cluster[clustid_used])
    clustid = clustid_used
    
    for _, v in ipairs(Cluster[clustid]) do
      QH_Route_Core_NodeRemove_Internal({}, v)
      ClusterLookup[v] = nil
    end
  else
    clustid = ClusterTableLookup[clust]
  end

  do
    local ct = 0
    local abort
    repeat
      QuestHelper: Assert(ct < 100)
      abort = true
      for k, v in pairs(ClusterIgnored[clustid]) do
        abort = false
        Internal_UnignoreCluster(clustid, k)
        ct = ct + 1
        break
      end
    until abort
    -- Imagine a->b->c. a is ignored, and b is deleted. This decouples a from c (todo: should it?) but we need to reduce c's ignore count appropriately so it's unignored.
    RecursiveIgnoreCount(clustid, -ClusterIgnoredCount[clustid])
    QuestHelper: Assert(ClusterIgnoredCount[clustid] == 0)
  end

  if debug_output then QuestHelper:TextOut(string.format("Removing cluster %d", clustid)) end
  
  for _, v in ipairs(clust) do
    local idx = QH_Route_Core_NodeRemove_Internal(v)
    ClusterLookup[idx] = nil
  end
  
  DependencyCounts[clustid] = nil
  
  if DependencyLinks[clustid] then
    for k, v in pairs(DependencyLinks[clustid]) do
      for m, f in pairs(DependencyLinksReverse[v]) do
        if f == clustid then
          if debug_output then QuestHelper:TextOut(string.format("Unlinking cluster %d needs %d", clustid, v)) end
          table.remove(DependencyLinksReverse[v], m)
          break
        end
      end
    end
  end
  DependencyLinks[clustid] = nil
  
  if DependencyLinksReverse[clustid] then
    for k, v in pairs(DependencyLinksReverse[clustid]) do
      for m, f in pairs(DependencyLinks[v]) do
        if f == clustid then
          if debug_output then QuestHelper:TextOut(string.format("Unlinking cluster %d needs %d", v, clustid)) end
          table.remove(DependencyLinks[v], m)
          DependencyCounts[v] = DependencyCounts[v] - 1
          break
        end
      end
    end
  end
  DependencyLinksReverse[clustid] = nil
  
  Cluster[clustid] = nil
  ClusterTableLookup[clust] = nil
  table.insert(ClusterDead, clustid)
  
  ClusterIgnored[clustid] = nil
  ClusterIgnoredCount[clustid] = nil
  ClusterIgnoredNodeActive[clustid] = nil
  
  local pri = ClusterPriority[clustid]
  PriorityCount[pri] = PriorityCount[pri] - 1
  if PriorityCount[pri] == 0 then
    PriorityCount[pri] = nil
    
    for k, v in ipairs(Priorities) do
      if v == pri then
        Priorities[k] = Priorities[#Priorities]
        table.remove(Priorities)
        table.sort(Priorities)
        break
      end
    end
  end
  ClusterPriority[clustid] = nil
  
  Storage_ClusterDestroyed(clustid)
end

local QH_Route_Core_SetClusterPriority_Internal

-- Add a note that node 1 requires node 2.
function QH_Route_Core_ClusterRequires(a, b, hackery)
  local aidx
  local bidx
  if hackery then
    QuestHelper: Assert(OptimizationHackery)
    QuestHelper: Assert(Cluster[a])
    QuestHelper: Assert(Cluster[b])
    aidx, bidx = a, b
  else
    aidx = ClusterTableLookup[a]
    bidx = ClusterTableLookup[b]
  end
  QuestHelper: Assert(aidx)
  QuestHelper: Assert(bidx)
  QuestHelper: Assert(aidx ~= bidx)
  
  if debug_output then QuestHelper:TextOut(string.format("Linking cluster %d needs %d", aidx, bidx)) end
  
  DependencyCounts[aidx] = DependencyCounts[aidx] + 1
  
  if not DependencyLinks[aidx] then DependencyLinks[aidx] = {} end
  table.insert(DependencyLinks[aidx], bidx)
  
  if not DependencyLinksReverse[bidx] then DependencyLinksReverse[bidx] = {} end
  table.insert(DependencyLinksReverse[bidx], aidx)
  
  DespliceCN(aidx)
  DespliceCN(bidx)
  
  Storage_ClusterDependency(aidx, bidx)
  
  QH_Route_Core_SetClusterPriority_Internal(bidx, ClusterPriority[bidx], true)
end

function QH_Route_Core_GetClusterPriority(clust)
  return ClusterPriority[ClusterTableLookup[clust]]
end

function QH_Route_Core_SetClusterPriority_Internal(clustid, new_pri, force)
  QuestHelper: Assert(clustid)
  if not force and ClusterPriority[clustid] == new_pri then return end
  --QuestHelper:TextOut(string.format("Setting %d to %d", clustid, new_pri))
  
  local pri = ClusterPriority[clustid]
  QuestHelper: Assert(pri)
  PriorityCount[pri] = PriorityCount[pri] - 1
  if PriorityCount[pri] == 0 then
    PriorityCount[pri] = nil
    
    for k, v in ipairs(Priorities) do
      if v == pri then
        Priorities[k] = Priorities[#Priorities]
        table.remove(Priorities)
        table.sort(Priorities)
        break
      end
    end
  end
  
  ClusterPriority[clustid] = new_pri
  if not PriorityCount[new_pri] then table.insert(Priorities, new_pri) table.sort(Priorities) end
  PriorityCount[new_pri] = (PriorityCount[new_pri] or 0) + 1
  
  DespliceCN(clustid)
  
  -- NOTE: These are recursive functions. It is vitally important that these not be called if nothing is changing, and it is vitally important that we change the local node first, otherwise we'll get infinite recursion and explosions. Or even EXPLOISIONS.
  
  -- Clusters that this one depends on. Must happen first (i.e. have a smaller or equal priority)
  if DependencyLinks[clustid] then for _, v in ipairs(DependencyLinks[clustid]) do
    if ClusterPriority[v] > new_pri then QH_Route_Core_SetClusterPriority_Internal(v, new_pri) end
  end end
  
  -- Clusters that depend on this one. Must happen last (i.e. have a greater or equal priority)
  if DependencyLinksReverse[clustid] then for _, v in ipairs(DependencyLinksReverse[clustid]) do
    if ClusterPriority[v] < new_pri then QH_Route_Core_SetClusterPriority_Internal(v, new_pri) end
  end end
end

function QH_Route_Core_SetClusterPriority(clust, new_pri)
  QuestHelper: Assert(clust)
  local clustid = ClusterTableLookup[clust]
  
  if clustid then QH_Route_Core_SetClusterPriority_Internal(clustid, new_pri) end
end

-- Wipe and re-cache all distances.
function QH_Route_Core_DistanceClear(progress)  
  local tlnod = {}
  for _, v in ipairs(ActiveNodes) do
    table.insert(tlnod, NodeList[v])
  end

  for ani, idx in ipairs(ActiveNodes) do
    local forward = DistBatch(NodeList[idx], tlnod, false, true)
    
    for k, v in ipairs(ActiveNodes) do
      Distance[idx][v] = forward[k]
    end
    
    if QuestHelper.loading_preroll and #ActiveNodes > 1 then QuestHelper.loading_preroll:SetPercentage(ani / #ActiveNodes) end
    
    if progress then progress:SetPercentage(ani / #ActiveNodes) end
  end
  
  if last_best then
    last_best.distance = 0
    for i = 1, #last_best - 1 do
      last_best.distance = last_best.distance + Distance[last_best[i]][last_best[i + 1]]
    end
  end
  
  Storage_Distance_StoreAll()
end
QH_Route_Core_DistanceClear_Local = QH_Route_Core_DistanceClear

function findin(tab, val)
  local ct = 0
  for k, v in pairs(tab) do
    if v == val then ct = ct + 1 end
  end
  return ct == 1
end

function TestShit()
--[[
  for x = 1, #ActiveNodes do
    local ts = ""
    for y = 1, #ActiveNodes do
      ts = ts .. string.format("%f ", Distance[GetIndex(ActiveNodes[x], ActiveNodes[y])])
    end
    RTO(ts)
  end
  ]]
  
  --[[
  RTO("Lookup table")
  for x = 1, #ActiveNodes do
    RTO(tostring(ActiveNodes[x]))
  end
  RTO("Lookup table done")
  ]]
  
  --[=[
  local fail = false
  for x = 1, #ActiveNodes do
    for y = 2, #ActiveNodes do
      if not (almost(Dist(NodeList[ActiveNodes[x]], NodeList[ActiveNodes[y]]), Distance[ActiveNodes[x]][ActiveNodes[y]])) then
        RTO(string.format("%d/%d (%d/%d) should be %f, is %f", x, y, ActiveNodes[x], ActiveNodes[y], Dist(NodeList[ActiveNodes[x]], NodeList[ActiveNodes[y]]),Distance[ActiveNodes[x]][ActiveNodes[y]]))
        fail = true
      end
    end
  end]=]
  
  for k, v in pairs(DependencyLinks) do
    QuestHelper: Assert(#v == DependencyCounts[k])
  end
  
  for k, v in pairs(DependencyCounts) do
    QuestHelper: Assert(v == (DependencyLinks[k] and #DependencyLinks[k] or 0))
  end
  
  for k, v in pairs(DependencyLinks) do
    for _, v2 in pairs(v) do
      QuestHelper: Assert(findin(DependencyLinksReverse[v2], k))
      QuestHelper: Assert(ClusterPriority[v2] <= ClusterPriority[k])
    end
  end
  
  for k, v in pairs(DependencyLinksReverse) do
    for _, v2 in pairs(v) do
      QuestHelper: Assert(findin(DependencyLinks[v2], k))
      QuestHelper: Assert(ClusterPriority[v2] >= ClusterPriority[k])
    end
  end
  
  QuestHelper: Assert(not fail)
end

--[=[
function HackeryDump()
  local st = "{"
  for k, v in pairs(ActiveNodes) do
    if v ~= 1 then
      st = st .. string.format("{c = %d, x = %f, y = %f}, ", NodeList[k].loc.c, NodeList[k].loc.x, NodeList[k].loc.y)
    end
  end
  st = st .. "}"
  QuestHelper: Assert(false, st)
end]=]

-- weeeeee
