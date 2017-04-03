QuestHelper_File["collect_flight.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_flight.lua"] = GetTime()

local debug_output = false
if QuestHelper_File["collect_flight.lua"] == "Development Version" then debug_output = true end

local QHCFM
local QHCFT

local IsMonsterGUID
local GetMonsterType

local function GetRoute(currentname, endnode)
  local path = currentname .. "@@" .. TaxiNodeName(endnode)
  
  local links = GetNumRoutes(endnode)
  if links > 50 then  -- links is apparently sometimes 999998. Why? I could not say. It is a mystery. Hopefully this will show up in the datafiles and I'll be able to debug it.
    return path, string.format("@@@ WACKYLAND %s %d @@@", TaxiNodeGetType(endnode), links)
  end
  
  local route = ""
  for j = 1, links - 1 do
    if #route > 0 then route = route .. "@@" end
    route = route .. string.format("%f:%f", TaxiGetDestX(endnode, j), TaxiGetDestY(endnode, j))
  end
  
  return path, route
end

local function GetCurrentname()
  QuestHelper: Assert(NumTaxiNodes() < 150, tostring(NumTaxiNodes())) -- hmm what
  for i = 1, NumTaxiNodes() do if TaxiNodeGetType(i) == "CURRENT" then return TaxiNodeName(i) end end
end

local path, route
local start_time
local phase = "IDLE"

local real_TakeTaxiNode = TakeTaxiNode
TakeTaxiNode = function(id)
  path, route = GetRoute(GetCurrentname(), id)
  
  phase = "PENDING"
  
  start_time = GetTime()
  
  real_TakeTaxiNode(id)
end

local function TaximapOpened()
  -- Figure out who we have targeted and what our location name is
  local currentname = GetCurrentname()
  if not currentname then return end  -- must not actually have opened the map
  
  QuestHelper: Assert(NumTaxiNodes() < 100)
  for i = 1, NumTaxiNodes() do
    local name, type = TaxiNodeName(i), TaxiNodeGetType(i)
    if not QHCFM[name] then QHCFM[name] = {} end
    QHCFM[name].x, QHCFM[name].y = TaxiNodePosition(i)
    if type == "CURRENT" then
      local guid = UnitGUID("target")
      if guid and IsMonsterGUID(guid) then QHCFM[name].master = GetMonsterType(guid) end
    end
    
    if type ~= "CURRENT" then
      local path, route = GetRoute(currentname, i)
      if not QHCFT[path] then QHCFT[path] = {} end
      if not QHCFT[path][route] then QHCFT[path][route] = true end
    end
  end
end

local function OnUpdate()
  if UnitOnTaxi("player") then
    if phase == "PENDING" then
      start_time = GetTime()
      phase = "FLYING"
    end
  else
    if phase == "PENDING" then
      if GetTime() > start_time + 5 then -- something has gone wrong, abort
        phase = "IDLE"
        path, route, start_time = nil, nil, nil
      end
    elseif phase == "FLYING" then
      -- yaay
      QHCFT[path][route] = (type(QHCFT[path][route]) == "number" and QHCFT[path][route] or 0) + (GetTime() - start_time)
      QHCFT[path][route .. "##count"] = (QHCFT[path][route .. "##count"] or 0) + 1
      phase = "IDLE"
      path, route, start_time = nil, nil, nil
    end
  end
end

function QH_Collect_Flight_Init(QHCData, API)
  if not QHCData.flight_master then QHCData.flight_master = {} end
  if not QHCData.flight_times then QHCData.flight_times = {} end
  QHCFM, QHCFT = QHCData.flight_master, QHCData.flight_times
  
  IsMonsterGUID = API.Utility_IsMonsterGUID
  GetMonsterType = API.Utility_GetMonsterType
  QuestHelper: Assert(IsMonsterGUID)
  QuestHelper: Assert(GetMonsterType)

  QH_Event("TAXIMAP_OPENED", TaximapOpened)
  
  API.Registrar_OnUpdateHook(OnUpdate)
end
