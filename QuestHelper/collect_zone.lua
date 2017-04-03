QuestHelper_File["collect_zone.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_zone.lua"] = GetTime()

local debug_output = false
if QuestHelper_File["collect_zone.lua"] == "Development Version" then debug_output = true end

local QHCZ

local GetLoc
local Merger

local function DoZoneUpdate(label, debugverbose)
  local zname = string.format("%s@@%s@@%s", GetZoneText(), GetRealZoneText(), GetSubZoneText()) -- I don't *think* any zones will have a @@ in them :D
  if zname == "@@@@" then return end -- denied
  if not QHCZ[zname] then QHCZ[zname] = {} end
  if not QHCZ[zname][label] then QHCZ[zname][label] = {} end
  local znl = QHCZ[zname][label]
  
  if debugverbose and debug_output then
    --QuestHelper:TextOut("zoneupdate " .. zname .. " type " .. label)
  end
  
  QHCZ[zname].mapname = GetMapInfo()
  
  local loc = GetLoc()
  if loc == "€\000\000\000€\000\000\000€€€" then return end -- this is kind of the "null value"
  
  Merger.Add(znl, loc, true)
end

local function OnEvent()
  DoZoneUpdate("border", true)
end

local lastupdate = 0
local function OnUpdate()
  if lastupdate + 15 <= GetTime() then
    DoZoneUpdate("update")
    lastupdate = GetTime()
  end
end

function QH_Collect_Zone_Init(QHCData, API)
  do return end -- we really don't need this anymore
  
  if not QHCData.zone then QHCData.zone = {} end
  QHCZ = QHCData.zone
  
  QH_Event("ZONE_CHANGED", OnEvent)
  QH_Event("ZONE_CHANGED_INDOORS", OnEvent)
  QH_Event("ZONE_CHANGED_NEW_AREA", OnEvent)
  
  API.Registrar_OnUpdateHook(OnUpdate)
  
  GetLoc = API.Callback_LocationBolusCurrent
  QuestHelper: Assert(GetLoc)
  
  Merger = API.Utility_Merger
  QuestHelper: Assert(Merger)
end
