QuestHelper_File["radar.lua"] = "1.4.1"
QuestHelper_Loadtime["radar.lua"] = GetTime()

local tick = GetTime()

local anchor = nil

local rc = nil

local map = {}

local widgets = {}
local lwidth = 1.5
local lheight = 1.5
local quieted = true

local texparent = CreateFrame("Frame")

local grid = 3

QH_OnUpdate(function()
  if not QuestHelper_Pref.radar then
    if not quieted then
      for _, v in ipairs(widgets) do
        v[3] = nil
        v[1]:Hide()
      end
      quieted = true
    end
    return
  end
  quieted = false
  
  if not rc then rc = LibStub("LibRangeCheck-2.0") end
  
  if tick <= GetTime() then
    tick = tick + 1
    if tick < GetTime() then
      tick = GetTime()
    end
    
    local targ = UnitGUID("target")
    if targ ~= anchor or UnitIsDead("target") then
      for _, v in pairs(map) do QuestHelper:ReleaseTable(v) end
      wipe(map)
      for _, v in ipairs(widgets) do
        v[3] = nil
        v[1]:Hide()
      end
      anchor = targ
    end
    
    local minRange, maxRange = rc:GetRange('target')
    
    if minRange then
      if not maxRange then maxRange = 120 end
      
      minRange = math.max(0, minRange - 1)
      maxRange = maxRange + 1
      
      local mnr, mxr = minRange * minRange, maxRange * maxRange
      local px, py = QuestHelper.routing_ax, QuestHelper.routing_ay
      
      -- first we blur
      local newmap = QuestHelper:CreateTable("radar")
      for x, d in pairs(map) do
        if not newmap[x - grid] then newmap[x - grid] = QuestHelper:CreateTable("radar") end
        if not newmap[x] then newmap[x] = QuestHelper:CreateTable("radar") end
        if not newmap[x + grid] then newmap[x + grid] = QuestHelper:CreateTable("radar") end
        
        for y, v in pairs(d) do
          newmap[x - grid][y - grid] = (newmap[x - grid][y - grid] or 0) + v
          newmap[x - grid][y] = (newmap[x - grid][y] or 0) + v * 2
          newmap[x - grid][y + grid] = (newmap[x - grid][y + grid] or 0) + v
          newmap[x][y - grid] = (newmap[x][y - grid] or 0) + v * 2
          newmap[x][y] = (newmap[x][y] or 0) + v * 4
          newmap[x][y + grid] = (newmap[x][y + grid] or 0) + v * 2
          newmap[x + grid][y - grid] = (newmap[x + grid][y - grid] or 0) + v
          newmap[x + grid][y] = (newmap[x + grid][y] or 0) + v * 2
          newmap[x + grid][y + grid] = (newmap[x + grid][y + grid] or 0) + v
        end
        
        QuestHelper:ReleaseTable(d)
      end
      QuestHelper:ReleaseTable(map)
      map = newmap
      
      
      -- then we crop
      local highest = 0
      local newmap = QuestHelper:CreateTable("radar")
      for x, d in pairs(map) do
        local newk = QuestHelper:CreateTable("radar")
        local something = false
        local dx = px - x
        dx = dx * dx
        for y, v in pairs(d) do
          local dy = py - y
          dy = dy * dy
          --print(dx + dy, mnr, mxr)
          if dx + dy >= mnr and dx + dy <= mxr then
            newk[y] = v
            highest = max(highest, v)
            something = true
          end
        end
        
        if something then
          newmap[x] = newk
        end
        QuestHelper:ReleaseTable(d)
      end
      QuestHelper:ReleaseTable(map)
      map = newmap
      
      -- then we normalize
      if highest > 0 then
        highest = 1 / highest -- I don't know if mult is faster in lua or not, but it often is
        for x, d in pairs(map) do
          for y, v in pairs(d) do
            d[y] = v * highest
          end
        end
      end
      
      -- then we add
      -- probably a more efficient way to do this
      px, py = math.floor(px / grid + 0.5) * grid, math.floor(py / grid + 0.5) * grid
      for dx = 0, maxRange, grid do
        for dy = 0, maxRange, grid do
          local ofs = dx * dx + dy * dy
          if ofs >= mnr and ofs <= mxr then
            if not map[px + dx] then map[px + dx] = QuestHelper:CreateTable("radar") end
            if not map[px - dx] then map[px - dx] = QuestHelper:CreateTable("radar") end
            map[px + dx][py + dy] = (map[px + dx][py + dy] or 0) + 0.001
            if dx > 0 then
              map[px - dx][py + dy] = (map[px - dx][py + dy] or 0) + 0.001
              if dy > 0 then
                map[px - dx][py - dy] = (map[px - dx][py - dy] or 0) + 0.001
              end
            end
            if dy > 0 then
              map[px + dx][py - dy] = (map[px + dx][py - dy] or 0) + 0.001
            end
          end
        end
      end
      
      -- then we post
      local widgetofs = 1
      for x, d in pairs(map) do
        for y, v in pairs(d) do
          if v > 0.1 then
            local widg = widgets[widgetofs]
            if not widg then
              widg = {texparent:CreateTexture()}
              table.insert(widgets, widg)
              widg[1]:SetWidth(lwidth)
              widg[1]:SetHeight(lheight)
            end
            widgetofs = widgetofs + 1
            
            widg[1]:SetTexture(0, 1, 0, math.min(1, v * 1.2))
            widg[1]:Show()
            widg[2] = x
            widg[3] = y
          end
        end
      end
      
      for rem = widgetofs, #widgets do
        widgets[rem][1]:Hide()
        widgets[rem][3] = nil
      end
    end
  end
  
  -- here we replace the widgets
  
  local rotatey = (GetCVar("rotateMinimap") == "0") and 0 or GetPlayerFacing()
  rotatey = rotatey * 180 / 3.14159
  
  local mapdiam = QuestHelper.Astrolabe:GetMapDiameter()
  local minimap = QuestHelper.Astrolabe:GetMinimapObject()
  local mapwid, maphei = minimap:GetWidth(), minimap:GetHeight()
  
  local xds, yds = mapwid / mapdiam, maphei / mapdiam
  
  local nwidth, nheight = xds * grid, yds * grid
  if nwidth ~= lwidth or nheight ~= lheight then
    for _, widg in pairs(widgets) do
      widg[1]:SetWidth(nwidth)
      widg[1]:SetHeight(nheight)
    end
  end
  lwidth, lheight = nwidth, nheight
  
  local xdx, xdy, ydx, ydy = cos(rotatey), -sin(rotatey), -sin(rotatey), -cos(rotatey)  -- this will be wrong, but I'll figure it out
  xdx, ydx = xdx * xds, ydx * xds
  xdy, ydy = xdy * yds, ydy * yds
  
  local px, py = QuestHelper.routing_ax, QuestHelper.routing_ay
  
  for _, v in pairs(widgets) do
    if not v[3] then break end
    
    local dx, dy = v[2] - px, v[3] - py
    
    v[1]:SetPoint("CENTER", Minimap, "CENTER", dx * xdx + dy * ydx, dx * xdy + dy * ydy)
    --print("placing", dx * xdx + dy * ydx, dx * xdy + dy * ydy)
  end
end, "radar")



if ( minimapRotationEnabled ) then
		minimapRotationOffset = -Astrolabe.GetFacing()
	end
