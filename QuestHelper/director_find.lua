QuestHelper_File["director_find.lua"] = "1.4.1"
QuestHelper_Loadtime["director_find.lua"] = GetTime()

local function getitall(name)
  local segments = {}
  for i = 1, #name - 1 do
    local sub = name:sub(i, i + 1):lower()
    if not sub:find(" ") then
      local dbi = DB_GetItem("find", sub:byte(1) * 256 + sub:byte(2), true)
      --print("inserting", sub)
      if not dbi then return {} end
      segments[dbi] = true
    end
  end
  
  local segwork = {}
  for k in pairs(segments) do
    table.insert(segwork, {k, 1, k[1]})
  end
  
  local found = {}
  
  while true do
    local lowest = segwork[1][3]
    local highest = segwork[1][3]
    local lid = 1
    for i = 2, #segwork do
      local v = segwork[i][3]
      --print("loop", i, lowest, highest, v, segwork[i][2])
      if v < lowest then
        --print("lower")
        lowest, lid = v, i
      end
      if v > highest then
        --print("higher")
        highest = v
      end
    end
    
    if lowest == highest then
      table.insert(found, lowest)
      segwork[1][2] = segwork[1][2] + 1
      if not segwork[1][1][segwork[1][2]] then break end
      segwork[1][3] = segwork[1][3] + segwork[1][1][segwork[1][2]]
    else
      while segwork[lid][3] < highest do
        segwork[lid][2] = segwork[lid][2] + 1
        if not segwork[lid][1][segwork[lid][2]] then break end
        segwork[lid][3] = segwork[lid][3] + segwork[lid][1][segwork[lid][2]]
      end
    end
    
    if not segwork[lid][1][segwork[lid][2]] then break end
  end
  
  return found
end

local function generate_objective(dbi)
  local clooster = {}

  local why = {desc = dbi.name, tracker_desc = dbi.name}
  for _, v in ipairs(dbi.loc) do
    QuestHelper: Assert(QuestHelper_ParentLookup)
    QuestHelper: Assert(QuestHelper_ParentLookup[v.p], v.p)
    table.insert(clooster, {loc = {x = v.x, y = v.y, c = QuestHelper_ParentLookup[v.p], p = v.p}, cluster = clooster, tracker_hidden = true, why = why, map_desc = {QuestHelper:HighlightText(dbi.name)}, tracker_desc = dbi.name, map_suppress_ignore = true, map_custom_menu = function (menu) QuestHelper:CreateMenuItem(menu, QHText("FIND_REMOVE")):SetFunction(function () QH_Route_ClusterRemove(clooster) end) end})
  end
  
  QH_Route_ClusterAdd(clooster)
end

local msfires = {desc = QHText("FIND_CUSTOM_LOCATION"), tracker_desc = QHText("FIND_CUSTOM_LOCATION")}

function QH_FindName(name)
  local locd = name:match("^loc (.+)")
  if locd then
    -- I just know some guy's gonna get pissed off because he was trying to find "loc crocolisk" or something, but screw him
    local locx, locy, locz
    
    locx, locy = locd:match("^(%d+) (%d+)$")
    if locx and locy then
      locx, locy = tonumber(locx), tonumber(locy)
      locz = QuestHelper_NameLookup[QuestHelper_IndexLookup[QuestHelper.routing_c][QuestHelper.routing_z]]
    end
    
    if not locx then
      locz, locx, locy = locd:match("^(.+) (%d+) (%d+)$")
      locx, locy = tonumber(locx), tonumber(locy)
    end
    
    if locz then
      for z, nam in pairs(QuestHelper_NameLookup) do
        if nam:lower():find(locz:lower()) then
          locz = z
          break
        end
      end
      
      if type(locz) == "number" then
        local ec, ez = unpack(QuestHelper_ZoneLookup[locz])
        local c, x, y = QuestHelper.Astrolabe:GetAbsoluteContinentPosition(ec, ez, locx / 100, locy / 100)
        local node = {loc = {x = x, y = y, p = locz, c = QuestHelper_ParentLookup[locz]}, why = msfires, map_desc = {QHText("FIND_CUSTOM_LOCATION")}, tracker_desc = QHText("FIND_CUSTOM_LOCATION"), tracker_hidden = true}
        local cluster = {node}
        node.cluster = cluster
        
        node.map_suppress_ignore = true
        node.map_custom_menu = function (menu) QuestHelper:CreateMenuItem(menu, QHText("FIND_REMOVE")):SetFunction(function () QH_Route_ClusterRemove(cluster) end) end
        
        QH_Route_ClusterAdd(cluster)
      end
    end
  else
    if not DB_Ready() then
      QuestHelper:TextOut(QHText("FIND_NOT_READY"))
      return
    end
    
    if #name < 2 then
      QuestHelper:TextOut(QHText("FIND_USAGE"))
      return
    end
    
    local found = getitall(name)
    
    local mennix = QuestHelper:CreateMenu()
    QuestHelper:CreateMenuTitle(mennix, QHText("RESULTS_TITLE"))
   
    local made_item = false
    
    local found_db = {}
    local has_name = {}
    local needs_postfix = {}
    
    for _, v in ipairs(found) do
      local dbi = DB_GetItem("monster", v)
      --[[ assert(dbi) ]]
      
      if dbi.loc then
        table.insert(found_db, dbi)
        
        if has_name[dbi.name] then needs_postfix[dbi.name] = true end
        has_name[dbi.name] = true
      end
    end
    
    table.sort(found_db, function (a, b) return a.name < b.name end)
    
    for _, v in ipairs(found_db) do
      made_item = true
    
      local name = v.name
      
      if needs_postfix[name] then name = name .. " (" .. QuestHelper_NameLookup[v.loc[1].p] .. ")" end
      
      local opt = QuestHelper:CreateMenuItem(mennix, name)
      opt:SetFunction(generate_objective, v)
    end
    
    if not made_item then
      QuestHelper:CreateMenuItem(mennix, QHText("NO_RESULTS"))
    end
    
    mennix:ShowAtCursor()
  end
end
