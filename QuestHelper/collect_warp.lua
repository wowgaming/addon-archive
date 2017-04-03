QuestHelper_File["collect_warp.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_warp.lua"] = GetTime()

local debug_output = false
if QuestHelper_File["collect_warp.lua"] == "Development Version" then debug_output = true end

local QHCW

local GetLoc
local Merger
local RawLocation

local lastloc_bolus
local last_delayed, last_rc, last_rz, last_rx, last_ry
local last_valid

local last_warp = 0

local function valid(d, rc, rz, rx, ry)
  return not d and rc and rz and rx and ry
end

local function OnUpdate()
  local bolus = GetLoc()
  local now_delayed, now_rc, now_rz, now_rx, now_ry = RawLocation()
  local now_valid = valid(RawLocation())
  
  if last_valid and now_valid then
    local leapy = false
    if last_rc ~= now_rc or last_rz ~= now_rz then
      leapy = true
    else
      local dx, dy = last_rx - now_rx, last_ry - now_ry
      dx, dy = dx * dx, dy * dy
      if dx + dy > 0.01 * 0.01 then
        leapy = true
      end
    end
    
    if leapy then
      if debug_output then QuestHelper:TextOut("Warpy!") end
    end
    
    if last_warp + 10 < GetTime() and leapy then
      if debug_output then QuestHelper:TextOut("REAL Warpy!") end
      Merger.Add(QHCW, lastloc_bolus .. bolus)
      last_warp = GetTime()
    end
  end
  
  lastloc_bolus = bolus
  
  last_delayed, last_rc, last_rz, last_rx, last_ry, last_valid = now_delayed, now_rc, now_rz, now_rx, now_ry, now_valid
end

function QH_Collect_Warp_Init(QHCData, API)
  if not QHCData.warp then QHCData.warp = {} end
  QHCW = QHCData.warp
  
  API.Registrar_OnUpdateHook(OnUpdate)
  
  GetLoc = API.Callback_LocationBolusCurrent
  QuestHelper: Assert(GetLoc)
  
  RawLocation = API.Callback_Location_Raw
  QuestHelper: Assert(RawLocation)
  
  Merger = API.Utility_Merger
  QuestHelper: Assert(Merger)
end
