QuestHelper_File["collect_traveled.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_traveled.lua"] = GetTime()

local debug_output = false
if QuestHelper_File["collect_traveled.lua"] == "Development Version" then debug_output = true end

--[[

Meaningful symbols it generates:

%d,%d,%d,%d|COMPRESSED

First four values: continent ID as per client, X coordinate in yards as per client via Astrolabe, Y coordinate in yards as per client via Astrolabe, faction ID (Alliance/Horde)
Compressed data is complicated lzw'ed hideousness.
Version number is probably contained in the |, I'll change that when I need to change meaning.
User is assumed to start facing right, all turns are 90 degrees.

Allowed values, post-lookup-table listed below, are:

^ - forward
< - turn left and move forward
> - turn right and move forward
v - turn around and move forward
C - combo indicator, each one indicates that another next UDLR is part of a single move (the toggles are zero-time anyway)
S - swim toggle
X - taxi toggle
M - mount toggle
Y - flying mount toggle
D - dead/ghost toggle

]]

local QHCT
local Merger
local LZW
local Bolus

local cc, cx, cy, cd = nil, nil, nil, nil
local flags = {}

local nx, ny = nil, nil

local function round(x) return math.floor(x + 0.5) end
local function dist(x, y) return math.abs(x) + math.abs(y) end  -- fuck it, manhattan distance

-- ++ is turning right
local dx = {1, 0, -1, 0}
local dy = {0, 1, 0, -1}

local function InitWorking()
  QHCT.working = {}
  QHCT.working.prefix = ""
end

local function AddDataPrefix(data)
  QHCT.working.prefix = QHCT.working.prefix .. data
end

local function AddData(data)
  Merger.Add(QHCT.working, data)
end

local function FinishData()
  return Merger.Finish(QHCT.working)
end

local function TestDirection(nd, kar)
  if nd < 1 then nd = nd + 4 end
  if nd > 4 then nd = nd - 4 end
  
  if dist(cx + dx[nd] - nx , cy + dy[nd] - ny) < dist(cx - nx, cy - ny) then
    AddData(kar)
    cd = nd
    cx = cx + dx[cd]
    cy = cy + dy[cd]
    return true
  else
    return false
  end
end

local function CompressAndComplete(ki)
  --QuestHelper:TextOut(string.format("%d tokens", #QHCT.compressing[ki].data))
  local tim = GetTime()
  local lzwed = LZW.Compress_Dicts(QHCT.compressing[ki].data, "^<>vCSXMYD")
  if debug_output then
    QuestHelper:TextOut(string.format("%d tokens: compressed to %d in %f", #QHCT.compressing[ki].data, #lzwed, GetTime() - tim))
  end
  
  if not QHCT.done then QHCT.done = {} end
  table.insert(QHCT.done, QHCT.compressing[ki].prefix .. lzwed)
  QHCT.compressing[ki] = nil
end

local function CompressFromKey(ki)
  QH_Timeslice_Add(function () CompressAndComplete(ki) end, "lzw")
end

local function CompileData()
  local data = FinishData()
  local prefix = QHCT.working.prefix
  
  InitWorking()
  
  if #data > 0 then
    if not QHCT.compressing then QHCT.compressing = {} end
    local ki = GetTime()
    while QHCT.compressing[ki] do ki = ki + 1 end -- if this ever triggers, I'm shocked
    
    QHCT.compressing[ki] = {data = data, prefix = prefix}
    
    CompressFromKey(ki)
  end
end

local function AppendFlag(flagval, flagid)
  flagval = not not flagval
  flags[flagid] = not not flags[flagid]
  if flagval ~= flags[flagid] then
    if debug_output then
      --QuestHelper:TextOut(string.format("Status toggle %s", flagid))
    end
    flags[flagid] = flagval
    AddData(flagid)
  end
end

local function QH_Collect_Traveled_Point(c, x, y, rc, rz)
  if not c or not x or not y then return end
  
  nx, ny = round(x), round(y)
  if c ~= cc or dist(nx - cx, ny - cy) > 10 then
    if debug_output then
      QuestHelper:TextOut(string.format("finishing thanks to differences, %s,%s,%s vs %s,%s,%s (%s)", tostring(cc), tostring(cx), tostring(cy), tostring(c), tostring(nx), tostring(ny), cc and tostring(dist(nx - cx, ny - cy)) or "lol"))
    end
    CompileData()
    
    cc, cx, cy, cd = c, nx, ny, 1
    swim, mount, flying, taxi = false, false, false, false
    AddDataPrefix(Bolus(c, x, y, rc, rz) .. strchar(tostring(QuestHelper:PlayerFaction()))) -- The playerfaction can be removed, as it's now encoded in the collection shard. Not removing it for compatibility reasons.
  end
  
  AppendFlag(IsMounted(), 'M')
  AppendFlag(IsFlying(), 'Y')
  AppendFlag(IsSwimming(), 'S')
  AppendFlag(UnitOnTaxi("player"), 'X')
  AppendFlag(UnitIsDeadOrGhost("player"), 'D')
  
  for x = 1, dist(nx - cx, ny - cy) - 1 do
    AddData('C')
  end
  
  -- first we go forward as much as is reasonable
  while TestDirection(cd, '^') do end
  
  if TestDirection(cd + 1, '>') then -- if we can go right, we do so, then we go forward again
    while TestDirection(cd, '^') do end
    -- In theory, if the original spot was back-and-to-the-right of us, we could need to go right *again* and then forward *again*. So we do.
    if TestDirection(cd + 1, '>') then
      while TestDirection(cd, '^') do end
    end
  elseif TestDirection(cd - 1, '<') then -- the same logic applies for left.
    while TestDirection(cd, '^') do end
    if TestDirection(cd - 1, '<') then
      while TestDirection(cd, '^') do end
    end
  else
    -- And we also test back, just in case.
    if TestDirection(cd + 2, 'v') then
      while TestDirection(cd, '^') do end
    end
  end
  
  QuestHelper: Assert(cx == nx and cy == ny)
  -- Done!
end

local GetRawLocation

local function OnUpdate()
  QH_Collect_Traveled_Point(GetRawLocation())
end

function QH_Collect_Traveled_Init(QHCData, API)
-- We're actually just going to disable this for now.
--[[
  Merger = API.Utility_Merger
  QuestHelper: Assert(Merger) -- I need to get rid of this stupid space hack someday
  
  LZW = API.Utility_LZW
  QuestHelper: Assert(LZW)
  
  Bolus = API.Callback_LocationBolus
  QuestHelper: Assert(Bolus)
  
  if not QHCData.traveled then QHCData.traveled = {} end
  QHCT = QHCData.traveled
  
  if not QHCT.working then InitWorking() end
  
  if QHCT.compressing then for k, v in pairs(QHCT.compressing) do
    CompressFromKey(k)
  end end
  
  GetRawLocation = API.Callback_RawLocation
  API.Registrar_OnUpdateHook(OnUpdate)]]
end

--[[
function hackeryflush()
  CompileData()
  cc = nil
end
]]
