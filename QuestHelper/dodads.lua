QuestHelper_File["dodads.lua"] = "1.4.1"
QuestHelper_Loadtime["dodads.lua"] = GetTime()

local ofs = 0.000723339 * (GetScreenHeight()/GetScreenWidth() + 1/3) * 70.4;
local radius = ofs / 1.166666666666667;
local Minimap = _G.Minimap

-- These conversions are nasty, and this entire section needs a serious cleanup.
local function convertLocation(p)
  return QuestHelper.Astrolabe:FromAbsoluteContinentPosition(p.c, p.x, p.y)
end

local function convertLocationToScreen(p, c, z)
  local pc, _, px, py = convertLocation(p)
  local ox, oy = QuestHelper.Astrolabe:TranslateWorldMapPosition(pc, 0, px, py, c, z)
  --QuestHelper:TextOut(string.format("%f/%f/%f to %f/%f/%f to %f/%f %f/%f", p.c, p.x, p.y, pc, px, py, c, z, ox, oy))
  return ox, oy
end

local function convertRawToScreen(tc, x, y, c, z)
  local rc, _, rx, ry = QuestHelper.Astrolabe:FromAbsoluteContinentPosition(tc, x, y)
  return QuestHelper.Astrolabe:TranslateWorldMapPosition(rc, 0, rx, ry, c, z)
end

local scrolf = CreateFrame("SCROLLFRAME", nil, WorldMapButton)
scrolf:SetFrameLevel(WorldMapButton:GetFrameLevel()+1)
scrolf:SetAllPoints()
scrolf:SetFrameStrata("FULLSCREEN")

QuestHelper.map_overlay = CreateFrame("FRAME", nil, scrolf)
scrolf:SetScrollChild(QuestHelper.map_overlay)
QuestHelper.map_overlay:SetAllPoints()

QuestHelper.map_overlay_uncropped = scrolf

local function ClampLine(x1, y1, x2, y2)
  if x1 and y1 and x2 and y2 then
    local x_div, y_div = (x2-x1), (y2-y1)
    local x_0 = y1-x1/x_div*y_div
    local x_1 = y1+(1-x1)/x_div*y_div
    local y_0 = x1-y1/y_div*x_div
    local y_1 = x1+(1-y1)/y_div*x_div
    
    if y1 < 0 then
      x1 = y_0
      y1 = 0
    end
    
    if y2 < 0 then
      x2 = y_0
      y2 = 0
    end
    
    if y1 > 1 then
      x1 = y_1
      y1 = 1
    end
    
    if y2 > 1 then
      x2 = y_1
      y2 = 1
    end
    
    if x1 < 0 then
      y1 = x_0
      x1 = 0
    end
    
    if x2 < 0 then
      y2 = x_0
      x2 = 0
    end
    
    if x1 > 1 then
      y1 = x_1
      x1 = 1
    end
    
    if x2 > 1 then
      y2 = x_1
      x2 = 1
    end
    
    if x1 >= 0 and x2 >= 0 and y1 >= 0 and y2 >= 0 and x1 <= 1 and x2 <= 1 and y1 <= 1 and y2 <= 1 then
      return x1, y1, x2, y2
    end
  end
end

local poi = {}
local poi_changed = false

local poi_dodads = {}

function QH_POI_Reset()
  while poi[1] do
    QuestHelper:ReleaseTable(table.remove(poi))
  end
  poi_changed = true
end
function QH_POI_Add(p, x, y, d)
  local tab = QuestHelper:CreateTable("dodads_poi")
  tab.p = p
  tab.x = x
  tab.y = y
  tab.desc = d
  table.insert(poi, tab)
  poi_changed = true
end


local walker_loc

function QuestHelper:CreateWorldMapWalker()
  if not self.Astrolabe or not QuestHelper then return end
  QuestHelper: Assert(self == QuestHelper)
  QuestHelper: Assert(self.Astrolabe)
  
  local walker = CreateFrame("Button", nil, QuestHelper.map_overlay)
  walker_loc = walker
  walker:SetWidth(0)
  walker:SetHeight(0)
  walker:SetPoint("CENTER", QuestHelper.map_overlay, "TOPLEFT", 0, 0)
  walker:Show()
  
  walker.phase = 0.0
  walker.dots = {}
  walker.points = {}
  walker.origin = {}
  walker.frame = self
  walker.map_dodads = {}
  walker.used_map_dodads = 0
  
  function walker:OnUpdate(elapsed)
    if poi_changed then self:RouteChanged() end   -- bzzzzt
    
    local out = 0
    
    if QuestHelper_Pref.show_ants then
      local points = self.points
      
      self.phase = self.phase + elapsed * 0.66
      while self.phase > 1 do self.phase = self.phase - 1 end
      
      local w, h = QuestHelper.map_overlay:GetWidth(), -QuestHelper.map_overlay:GetHeight()
      
      local c, z = QuestHelper.Astrolabe:GetCurrentVirtualMapCZ()
      
      local last_x, last_y = self.frame.Astrolabe:TranslateWorldMapPosition(self.frame.c, self.frame.z, self.frame.x, self.frame.y, c, z)
      local remainder = self.phase
      
      for i, pos in ipairs(points) do
        local new_x, new_y = unpack(pos)
        local x1, y1, x2, y2 = ClampLine(last_x, last_y, new_x, new_y)
        last_x, last_y = new_x, new_y
        
        if x1 then
          local len = math.sqrt((x1-x2)*(x1-x2)*16/9+(y1-y2)*(y1-y2))
          
          if len > 0.0001 then
            local interval = .025/len
            local p = remainder*interval
            
            while p < 1 do
              out = out + 1
              local dot = self.dots[out]
              if not dot then
                dot = QuestHelper:CreateDotTexture(self)
                dot:SetDrawLayer("BACKGROUND")
                self.dots[out] = dot
              end
              
              dot:ClearAllPoints()
              dot:SetPoint("CENTER", QuestHelper.map_overlay, "TOPLEFT", x1*w*(1-p)+x2*w*p, y1*h*(1-p)+y2*h*p)
              
              p = p + interval
            end
            
            remainder = (p-1)/interval
          end
        end
      end
    end
    
    while #self.dots > out do
      QuestHelper:ReleaseTexture(table.remove(self.dots))
    end
  end
  
  function walker:RouteChanged(route)
    if route then self.route = route end -- we cache it so we can refer to it later when the world map changes
    if not self.route then return end
    
    local dbgstr = string.format("%s %s %s %s", tostring(self), tostring(self.frame), tostring(QuestHelper), tostring(QuestHelper and QuestHelper.Astrolabe))
    QuestHelper: Assert(self.frame == QuestHelper, dbgstr)
    QuestHelper: Assert(QuestHelper.Astrolabe, dbgstr)
    
    if self.next_item then
      self.next_item:MarkAsNext(false)
      self.next_item = nil
    end
    
    if self.frame.Astrolabe.WorldMapVisible then
      local points = self.points
      local cur = self.frame.pos
      
      while #points > 0 do self.frame:ReleaseTable(table.remove(points)) end
      
      local c, z = QuestHelper.Astrolabe:GetCurrentVirtualMapCZ()
      
      for i, obj in ipairs(self.route) do
        --QuestHelper:TextOut(string.format("%s", tostring(obj)))
        
        --[[
        local t = QuestHelper:CreateTable()
        t[1], t[2] = convertLocationToScreen(obj.loc, c, z)
        
        table.insert(list, t)]]
        
        -- We're ignoring travel time for now.
        --[[
        travel_time = travel_time + 60
        obj.travel_time = travel_time]]
        if i > 1 then -- skip the start location
          local t = self.frame:CreateTable()
          t[1], t[2] = convertLocationToScreen(obj.loc, c, z)
          
          table.insert(points, t)
          
          --if lotsup then print(obj.ignore, obj.loc.x, obj.loc.y, obj.loc.c) end
        end
        --QuestHelper:TextOut(string.format("%s/%s/%s to %s/%s", tostring(obj.c), tostring(obj.x), tostring(obj.y), tostring(t[1]), tostring(t[2])))
      end
      --lotsup = false
      
      local cur_dodad = 1
      for i = 2, #self.route do -- 2 because we're skipping the player
        if not self.route[i].ignore or qh_hackery_show_all_map_nodes then
          local dodad = self.map_dodads[cur_dodad]
          if not dodad then
            self.map_dodads[cur_dodad] = self.frame:CreateWorldMapDodad(self.route[i], i == 2)
          else
            self.map_dodads[cur_dodad]:SetObjective(self.route[i], i == 2)
          end
          
          if cur_dodad == 1 then
            self.map_dodads[cur_dodad]:MarkAsNext(true)
            self.next_item = self.map_dodads[cur_dodad]
          end
          cur_dodad = cur_dodad + 1
        end
      end

      if cur_dodad <= self.used_map_dodads then for i = cur_dodad,self.used_map_dodads do
        self.map_dodads[i]:SetObjective(nil, false)
      end end

      self.used_map_dodads = cur_dodad - 1
      
      while #poi > #poi_dodads do
        table.insert(poi_dodads, self.frame:CreateWorldMapMinidad())
      end
      
      for i = 1, #poi do
        poi_dodads[i]:SetPosition(poi[i])
      end
      for i = #poi + 1, #poi_dodads do
        poi_dodads[i]:SetPosition()
      end
    end
  end
  
  QH_Event("WORLD_MAP_UPDATE", function () walker:RouteChanged() end)
  
  QH_Hook(walker, "OnUpdate", walker.OnUpdate)
  
  return walker
end



function QuestHelper:GetOverlapObjectives(obj)
  local w, h = self.map_overlay:GetWidth(), self.map_overlay:GetHeight()
  local c, z = QuestHelper.Astrolabe:GetCurrentVirtualMapCZ()
  
  local list = self.overlap_list
  
  if not list then
    list = {}
    self.overlap_list = list
  else
    while table.remove(list) do end
  end
  
  local cx, cy = GetCursorPosition()
  
  local es = QuestHelper.map_overlay:GetEffectiveScale()
  local ies = 1/es
  
  cx, cy = (cx-self.map_overlay:GetLeft()*es)*ies, (self.map_overlay:GetTop()*es-cy)*ies
  
  local s = 10*QuestHelper_Pref.scale
  
  for i, o in ipairs(walker_loc.route) do
    --QuestHelper: Assert(o, string.format("nil dodads pos issue, o %s", tostring(o)))
    --QuestHelper: Assert(o.pos, string.format("nil dodads pos issue, pos %s", QuestHelper:StringizeTable(o)))
    if not o.ignore or qh_hackery_show_all_map_nodes then
      if o == obj then
        table.insert(list, o)
      else
        local x, y = convertLocationToScreen(o.loc, c, z)
        
        if x and y and x > 0 and y > 0 and x < 1 and y < 1 then
          x, y = x*w, y*h
          
          if cx >= x-s and cy >= y-s and cx <= x+s and cy <= y+s then
            table.insert(list, o)
          end
        end
      end
    end
  end
  
  table.sort(list, function(a, b) return (a.distance or 0) < (b.distance or 0) end)
  
  return list
end

function QuestHelper:AppendObjectiveProgressToTooltip(o, tooltip, font, depth)
  if o.progress then
    local prog_sort_table = {}
  
    local theme = self:GetColourTheme()
    
    local indent = ("  "):rep(depth or 0)
    
    for user, progress in pairs(o.progress) do
      table.insert(prog_sort_table, user)
    end
    
    table.sort(prog_sort_table, function(a, b)
      if o.progress[a][3] < o.progress[b][3] then
        return true
      elseif o.progress[a][3] == o.progress[b][3] then
        return a < b
      end
      return false
    end)
    
    for i, u in ipairs(prog_sort_table) do
      tooltip:AddDoubleLine(indent..QHFormat("PEER_PROGRESS", u),
                            self:ProgressString(o.progress[u][1].."/"..o.progress[u][2],
                            o.progress[u][3]), unpack(theme.tooltip))
      
      if font then
        local last, name = tooltip:NumLines(), tooltip:GetName()
        local left, right = _G[name.."TextLeft"..last], _G[name.."TextRight"..last]
        
        left:SetFont(font, 13)
        right:SetFont(font, 13)
      end
    end
    
    while table.remove(prog_sort_table) do end
  end
end

function QuestHelper:AppendObjectiveToTooltip(o)
  local theme = self:GetColourTheme()
  
  QuestHelper: Assert(o.map_desc)
  for _, v in ipairs(o.map_desc) do
    self.tooltip:AddLine(v, unpack(theme.tooltip))
    self.tooltip:GetPrevLines():SetFont(self.font.serif, 14)
  end
  
  if o.map_desc_chain then
    self:AppendObjectiveToTooltip(o.map_desc_chain)
  else
    self:AppendObjectiveProgressToTooltip(o, self.tooltip, QuestHelper.font.sans)
    
    if QuestHelper_Pref.travel_time then
      self.tooltip:AddDoubleLine(QHText("TRAVEL_ESTIMATE"), QHFormat("TRAVEL_ESTIMATE_VALUE", o.distance or 0), unpack(theme.tooltip))
      self.tooltip:GetPrevLines():SetFont(self.font.sans, 11)
    end
  end
end

globx = 0.5
globy = 0.5

function QH_Append_NextObjective(menu)
  local obj = QuestHelper.minimap_marker.obj
  if not obj then return end
  
  QuestHelper:AddObjectiveOptionsToMenu(obj, menu)
end

local function rightclick_menu(obj)
  if obj then
    local menu = QuestHelper:CreateMenu()
    local list = QuestHelper:GetOverlapObjectives(obj)
    local item
    
    if #list > 1 then
      QuestHelper:CreateMenuTitle(menu, "Objectives")
      
      for i, o in ipairs(list) do
        local submenu = QuestHelper:CreateMenu()
        item = QuestHelper:CreateMenuItem(menu, o.map_desc[1])
        item:SetSubmenu(submenu)
        item:AddTexture(QuestHelper:CreateIconTexture(item, o.icon_id or 8), true)
        QuestHelper:AddObjectiveOptionsToMenu(o, submenu)
      end
    else
      QuestHelper:CreateMenuTitle(menu, obj.map_desc[1])
      QuestHelper:AddObjectiveOptionsToMenu(obj, menu)
    end
    
    menu:ShowAtCursor()
  end
end

function QuestHelper:CreateWorldMapDodad(objective, nxt)
  local icon = CreateFrame("Button", nil, QuestHelper.map_overlay)
  icon:SetFrameStrata("FULLSCREEN")
  
  function icon:SetTooltip(list)
    QuestHelper.tooltip:SetOwner(self, "ANCHOR_CURSOR")
    QuestHelper.tooltip:ClearLines()
    
    local first = true
    
    for i, o in ipairs(list) do
      if first then
        first = false
      else
        QuestHelper.tooltip:AddLine("|c80ff0000  .  .  .  .  .  .|r")
        QuestHelper.tooltip:GetPrevLines():SetFont(QuestHelper.font.sans, 8)
      end
      
      QuestHelper:AppendObjectiveToTooltip(o)
    end
    
    QuestHelper.tooltip:Show()
  end
  
  function icon:MarkAsNext(nxt)
    self.next = nxt
    
    QH_Hook(self, "OnUpdate", self.OnUpdate)
  end
  
  function icon:SetObjective(objective, nxt)
    self:SetHeight(20*QuestHelper_Pref.scale)
    self:SetWidth(20*QuestHelper_Pref.scale)
    
    if self.dot then
      QuestHelper:ReleaseTexture(self.dot)
      self.dot = nil
    end
    
    if self.bg then
      QuestHelper:ReleaseTexture(self.bg)
      self.bg = nil
    end
    
    if objective then
      self.objective = objective
      
      if nxt then
        self.bg = QuestHelper:CreateIconTexture(self, 13)
      elseif objective.map_highlight then
        self.bg = QuestHelper:CreateIconTexture(self, 14)
      else
        self.bg = QuestHelper:CreateIconTexture(self, 16)
      end
      
      self.dot = QuestHelper:CreateIconTexture(self, objective.icon_id or 8)
      
      self.bg:SetDrawLayer("BACKGROUND")
      self.bg:SetAllPoints()
      self.dot:SetPoint("TOPLEFT", self, "TOPLEFT", 3*QuestHelper_Pref.scale, -3*QuestHelper_Pref.scale)
      self.dot:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -3*QuestHelper_Pref.scale, 3*QuestHelper_Pref.scale)
      
      QuestHelper.Astrolabe:PlaceIconOnWorldMap(QuestHelper.map_overlay, self, convertLocation(objective.loc))
      --QuestHelper.Astrolabe:PlaceIconOnWorldMap(QuestHelper.map_overlay, self, 0, 0, globx, globy)
    else
      self.objective = nil
      self:Hide()
      self.next = false
      self:OnUpdate(0)
    end
  end
  
  local triangle_r, triangle_g, triangle_b = 1.0, 0.3, 0
  local triangle_opacity = 0.6
  
  function icon:CreateTriangles(solid, tritarget, tristartat, linetarget, linestartat, parent)
    local c, z = QuestHelper.Astrolabe:GetCurrentVirtualMapCZ()
    
    local function makeline(ax, ay, bx, by)
      local tri = linetarget[linestartat]
      if not tri then
        tri = CreateLine(parent)
        table.insert(linetarget, tri)
      end
      linestartat = linestartat + 1
      
      tri:SetLine(ax, ay, bx, by)
      tri:SetVertexColor(0, 0, 0, 0)
      tri:Show()
    end
    
    for _, v in ipairs(solid) do
      local adjx, adjy = v[1], v[2]
      local x, y = convertRawToScreen(v.continent, v[1], v[2], c, z)
      --print("matchup", c, v.continent, x, y)
      if x and y then
        local lx, ly = convertRawToScreen(v.continent, adjx + v[3], adjy + v[4], c, z)
        local linemode = false
        
        local lidx = 5
        while lidx <= #v do
          if type(v[lidx]) == "string" then
            if v[lidx] == "d" then
              QuestHelper: Assert(type(lidx) == "number") -- what
              lidx = lidx + 1
              x, y = convertRawToScreen(v.continent, adjx + v[lidx], adjy + v[lidx + 1], c, z)
              lx, ly = convertRawToScreen(v.continent, adjx + v[lidx + 2], adjy + v[lidx + 3], c, z)
              lidx = lidx + 4
            elseif v[lidx] == "l" then
              linemode = true
              lidx = lidx + 1
              x, y = convertRawToScreen(v.continent, adjx + v[lidx], adjy + v[lidx + 1], c, z)
              lx, ly = x, y
              lidx = lidx + 2
            else
              QuestHelper: Assert(false)
            end
          else
            if not linemode then
              local tx, ty = convertRawToScreen(v.continent, adjx + v[lidx], adjy + v[lidx + 1], c, z)
              
              local tri = tritarget[tristartat]
              if not tri then
                tri = CreateTriangle(parent)
                table.insert(tritarget, tri)
              end
              tristartat = tristartat + 1
              
              tri:SetTriangle(x, y, lx, ly, tx, ty)
              tri:SetVertexColor(0, 0, 0, 0)
              tri:Show()
              
              lx, ly = tx, ty
              lidx = lidx + 2
            else
              local tx, ty = convertRawToScreen(v.continent, adjx + v[lidx], adjy + v[lidx + 1], c, z)
              
              makeline(x, y, tx, ty)
              
              x, y = tx, ty
              lidx = lidx + 2
            end
          end
        end
        
        if linemode then
          makeline(x, y, lx, ly)
        end
      end
    end
    
    return tristartat, linestartat
  end
  
  function icon:SetGlow(list)
    local w, h = QuestHelper.map_overlay:GetWidth(), QuestHelper.map_overlay:GetHeight()
    local c, z = QuestHelper.Astrolabe:GetCurrentVirtualMapCZ()
    local zw = QuestHelper.Astrolabe:GetZoneWidth(c, z)
    
    local solids = {}
    
    local gid = 1
    for _, v in ipairs(list) do 
      --print(v.cluster, v.cluster and v.cluster.solid)
      if v.cluster and v.cluster.solid then
        --print("solidified", #v.cluster.solid)
        solids[v.cluster.solid] = true
      else
        local x, y = convertLocationToScreen(v.loc, c, z)
        if x and y then
          if not self.glow_list then
            self.glow_list = QuestHelper:CreateTable()
          end
          local glo = self.glow_list[gid]
          if not glo then
            glo = QuestHelper:CreateGlowTexture(self)
            self.glow_list[gid] = glo
          end
          gid = gid + 1
          
          glo:SetPoint("CENTER", QuestHelper.map_overlay, "TOPLEFT", x*w, -y*h)
          glo:SetVertexColor(triangle_r, triangle_g, triangle_b, 1)
          glo:SetWidth(h / 20)
          glo:SetHeight(h / 20)
          glo:Show()
        end
      end
    end
    
    local tid = 1
    local lid = 1
    
    for k, _ in pairs(solids) do
      if not self.triangle_list then
        self.triangle_list = QuestHelper:CreateTable()
      end
      if not self.line_list then
        self.line_list = QuestHelper:CreateTable()
      end
      
      tid, lid = self:CreateTriangles(k, self.triangle_list, tid, self.line_list, lid, QuestHelper.map_overlay)
    end
    -- call triangle maker here!
    
    if self.triangle_list then
      while #self.triangle_list >= tid do
        ReleaseTriangle(table.remove(self.triangle_list))
      end
      
      if #self.triangle_list == 0 then
        QuestHelper:ReleaseTable(self.triangle_list)
        self.triangle_list = nil
      end
    end
    
    if self.glow_list then
      while #self.glow_list >= gid do
        QuestHelper:ReleaseTexture(table.remove(self.glow_list))
      end
      
      if #self.glow_list == 0 then
        QuestHelper:ReleaseTable(self.glow_list)
        self.glow_list = nil
      end
    end
    
    if self.line_list then
      while #self.line_list >= lid do
        ReleaseLine(table.remove(self.line_list))
      end
      
      if #self.line_list == 0 then
        QuestHelper:ReleaseTable(self.line_list)
        self.line_list = nil
      end
    end
  end
  
  icon.show_glow = false
  icon.glow_pct = 0.0
  icon.phase = 0.0
  icon.old_count = 0
  
  function icon:OnUpdate(elapsed)
    self.phase = (self.phase + elapsed)%6.283185307179586476925286766559005768394338798750211641949889185
    
    if self.next and self.objective and self.objective.cluster.solid and QuestHelper_Pref.zones == "next" then
      
      local c, z = QuestHelper.Astrolabe:GetCurrentVirtualMapCZ()
      if self.tri_c ~= c or self.tri_z ~= z then
        -- not entirely happy with this being here, but, welp
        if not self.local_triangle_list then
          self.local_triangle_list = QuestHelper:CreateTable()
        end
        if not self.local_line_list then
          self.local_line_list = QuestHelper:CreateTable()
        end
        
        local tid, lid = self:CreateTriangles(self.objective.cluster.solid, self.local_triangle_list, 1, self.local_line_list, 1, QuestHelper.map_overlay)
        
        if self.local_triangle_list then
          while #self.local_triangle_list >= tid do
            ReleaseTriangle(table.remove(self.local_triangle_list))
          end
        end
        
        if self.local_line_list then
          while #self.local_line_list >= lid do
            ReleaseLine(table.remove(self.local_line_list))
          end
        end
      end
      
      self.tri_c, self.tri_z = c, z
    else
      if self.local_triangle_list then
        while #self.local_triangle_list > 0 do
          ReleaseTriangle(table.remove(self.local_triangle_list))
        end
        QuestHelper:ReleaseTable(self.local_triangle_list)
        self.local_triangle_list = nil
      end
      
      if self.local_line_list then
        while #self.local_line_list > 0 do
          ReleaseLine(table.remove(self.local_line_list))
        end
        QuestHelper:ReleaseTable(self.local_line_list)
        self.local_line_list = nil
      end
      
      self.tri_c, self.tri_z = nil, nil
    end
    
    if self.old_count > 0 then
      local list = QuestHelper:GetOverlapObjectives(self.objective)
      
      if #list ~= self.old_count then
        self:SetTooltip(list)
        self.old_count = #list
        self:SetGlow(list)
      end
    end
    
    if self.show_glow then
      self.glow_pct = math.min(1, self.glow_pct+elapsed*1.5)
    else
      self.glow_pct = math.max(0, self.glow_pct-elapsed*0.5)
      
      if self.glow_pct == 0 then
        if self.triangle_list then
          while #self.triangle_list > 0 do
            ReleaseTriangle(table.remove(self.triangle_list))
          end
          QuestHelper:ReleaseTable(self.triangle_list)
          self.triangle_list = nil
        end
        
        if self.glow_list then
          while #self.glow_list > 0 do
            QuestHelper:ReleaseTexture(table.remove(self.glow_list))
          end
          QuestHelper:ReleaseTable(self.glow_list)
          self.glow_list = nil
        end
        
        if self.line_list then
          while #self.line_list > 0 do
            ReleaseLine(table.remove(self.line_list))
          end
          QuestHelper:ReleaseTable(self.line_list)
          self.line_list = nil
        end
        
        if not self.next then
          QH_Hook(self, "OnUpdate", nil)
        end
      end
    end
    
    if self.triangle_list then
      for _, tri in ipairs(self.triangle_list) do
        tri:SetVertexColor(triangle_r, triangle_g, triangle_b, self.glow_pct*triangle_opacity/2)
      end
    end
    if self.line_list then
      for _, tri in ipairs(self.line_list) do
        tri:SetVertexColor(triangle_r, triangle_g, triangle_b, self.glow_pct*triangle_opacity)
      end
    end
    if self.glow_list then
      for _, tri in ipairs(self.glow_list) do
        tri:SetVertexColor(triangle_r, triangle_g, triangle_b, self.glow_pct*triangle_opacity)
      end
    end
    if self.local_triangle_list then
      for _, tri in ipairs(self.local_triangle_list) do
        tri:SetVertexColor(triangle_b, triangle_g, triangle_r, triangle_opacity/2)
      end
    end
    if self.local_line_list then
      for _, tri in ipairs(self.local_line_list) do
        tri:SetVertexColor(triangle_b, triangle_g, triangle_r, triangle_opacity)
      end
    end
  end
  
  function icon:OnEnter()
    local list = QuestHelper:GetOverlapObjectives(self.objective)
    self:SetTooltip(list)
    self.old_count = #list
    
    icon.show_glow = true
    
    self:SetGlow(list)
    
    QH_Hook(self, "OnUpdate", self.OnUpdate)
  end
  
  function icon:OnLeave()
    QuestHelper.tooltip:Hide()
    self.show_glow = false
    self.old_count = 0
  end
  
  function icon:OnEvent()
    if self.objective then
      QuestHelper.Astrolabe:PlaceIconOnWorldMap(QuestHelper.map_overlay, self, convertLocation(self.objective.loc))
    else
      self.objective = nil
      self:Hide()
    end
  end
  
  function icon:OnClick()
    rightclick_menu(self.objective)
  end
  
  QH_Hook(icon, "OnClick", icon.OnClick)
  QH_Hook(icon, "OnEnter", icon.OnEnter)
  QH_Hook(icon, "OnLeave", icon.OnLeave)
  QH_Hook(icon, "OnEvent", icon.OnEvent)
  
  icon:RegisterForClicks("RightButtonUp")
  
  QH_Event("WORLD_MAP_UPDATE", function () icon:OnEvent() end)
  
  icon:SetObjective(objective, nxt)
  return icon
end


function QuestHelper:CreateWorldMapMinidad(objective, nxt)
  local icon = CreateFrame("Button", nil, QuestHelper.map_overlay)
  icon:SetFrameStrata("FULLSCREEN")
    
  function icon:SetPosition(objective)
    self:SetHeight(16*QuestHelper_Pref.scale)
    self:SetWidth(16*QuestHelper_Pref.scale)
    
    if self.dot then
      QuestHelper:ReleaseTexture(self.dot)
      self.dot = nil
    end
    
    if objective then
      self.objective = objective
      
      self.dot = QuestHelper:CreateIconTexture(self, 15)
      self.dot:SetAllPoints()
      self.dot:SetDrawLayer("BACKGROUND")
      
      QuestHelper.Astrolabe:PlaceIconOnWorldMap(QuestHelper.map_overlay, self, QuestHelper.Astrolabe:FromAbsoluteContinentPosition(QuestHelper_ParentLookup[self.objective.p], self.objective.x, self.objective.y))
    else
      self.objective = nil
      self:Hide()
    end
  end
  
  
  function icon:OnEnter()
    local list = QuestHelper:GetOverlapObjectives(self.objective)
    self.old_count = #list
    QuestHelper.tooltip:SetOwner(self, "ANCHOR_CURSOR")
    QuestHelper.tooltip:ClearLines()
    
    QuestHelper.tooltip:AddLine(self.objective.desc)
    
    QuestHelper.tooltip:Show()
  end
  
  function icon:OnLeave()
    QuestHelper.tooltip:Hide()
  end
  
  function icon:OnEvent()
    if self.objective then
      QuestHelper.Astrolabe:PlaceIconOnWorldMap(QuestHelper.map_overlay, self, QuestHelper.Astrolabe:FromAbsoluteContinentPosition(QuestHelper_ParentLookup[self.objective.p], self.objective.x, self.objective.y))
    else
      self.objective = nil
      self:Hide()
    end
  end
  
  --function icon:OnClick()
    --rightclick_menu(self.objective)
  --end
  
  --QH_Hook(icon, "OnClick", icon.OnClick)
  QH_Hook(icon, "OnEnter", icon.OnEnter)
  QH_Hook(icon, "OnLeave", icon.OnLeave)
  QH_Hook(icon, "OnEvent", icon.OnEvent)
  
  --icon:RegisterForClicks("RightButtonUp")
  
  QH_Event("WORLD_MAP_UPDATE", function () icon:OnEvent() end)
  
  icon:SetPosition(objective)
  return icon
end

local callbacks = {}
local last_c, last_z, last_x, last_y, last_desc

function QuestHelper:AddWaypointCallback(func, ...)
  local cb = self:CreateTable()
  callbacks[cb] = true
  local len = select("#", ...)
  cb.len = len
  cb.func = func
  for i = 1,len do cb[i] = select(i, ...) end
  cb[len+1] = last_c
  cb[len+2] = last_z
  cb[len+3] = last_x
  cb[len+4] = last_y
  cb[len+5] = last_desc
  
  if last_c then
    func(unpack(cb, 1, len+5))
  end
  
  return cb
end

function QuestHelper:RemoveWaypointCallback(cb)
  callbacks[cb] = nil
  self:ReleaseTable(cb)
end

function QuestHelper:InvokeWaypointCallbacks(c, z, x, y, desc)
  QuestHelper: Assert(not c or type(c) == "number")
  QuestHelper: Assert(not z or type(z) == "number")
  QuestHelper: Assert(not x or type(x) == "number")
  QuestHelper: Assert(not y or type(y) == "number")
  if c == last_c and z == last_z and desc == last_desc and not x and not y then x, y = last_x, last_y end -- sometimes we may not have up-to-date location, but could still in theory be pointing at the same spot
  
  if not c or (x and y) then
    if c ~= last_c or z ~= last_z or x ~= last_x or y ~= last_y or desc ~= last_desc then
      last_c, last_z, last_x, last_y, last_desc = c, z, x, y, desc
      for cb in pairs(callbacks) do
        local len = cb.len
        cb[len+1] = c
        cb[len+2] = z
        cb[len+3] = x
        cb[len+4] = y
        cb[len+5] = desc
        cb.func(unpack(cb, 1, len+5))
      end
    end
  end
end

function QuestHelper:SetMinimapObject(minimap)
	Minimap = minimap
	QuestHelper.Astrolabe:SetMinimapObject(minimap)
	QuestHelper.minimap_marker:SetParent(minimap)
	QuestHelper.Astrolabe.processingFrame:SetParent(minimap)
end

--[[ Small parts of the arrow rendering code are thanks to Tomtom, with the following license:

-------------------------------------------------------------------------
  Copyright (c) 2006-2007, James N. Whitehead II
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:

      * Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
      * Redistributions in binary form must reproduce the above
        copyright notice, this list of conditions and the following
        disclaimer in the documentation and/or other materials provided
        with the distribution.
      * The name or alias of the copyright holder may not be used to endorse 
        or promote products derived from this software without specific prior
        written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
---------------------------------------------------------------------------]]

function QuestHelper:CreateMipmapDodad()
  local icon = CreateFrame("Button", nil, Minimap)
  icon:Hide()
  icon.recalc_timeout = 0
  
  icon.arrow = icon:CreateTexture("BACKGROUND")
  icon.arrow:SetHeight(40)
  icon.arrow:SetWidth(40)
  icon.arrow:SetPoint("CENTER", 0, 0)
  icon.arrow:SetTexture("Interface\\AddOns\\QuestHelper\\MinimapArrow")
  icon.arrow:Hide()
  
  icon.phase = 0
  icon.target = {0, 0, 0, 0}
  
  icon.bg = QuestHelper:CreateIconTexture(icon, 16)
  icon.bg:SetDrawLayer("BACKGROUND")
  icon.bg:SetAllPoints()
  
  function icon:OnUpdate(elapsed)
    local c, z, x, y, textdesc
    if self.obj then
      c, z = QuestHelper.collect_rc, QuestHelper.collect_rz
      if c and z then
        x, y = convertLocationToScreen(self.obj.loc, c, z)
      end
    
      if self.obj.map_desc_chain then
        -- the first line will just be an "enroute" line
        textdesc = (self.obj.arrow_desc or self.obj.map_desc[1]) .. "\n" .. (self.obj.map_desc_chain.arrow_desc or self.obj.map_desc_chain.map_desc[1])
      else
        textdesc = (self.obj.arrow_desc or self.obj.map_desc[1])
      end
      
      if self.obj.arrow_desc then
        textdesc = self.obj.arrow_desc
      end
    end
    
    QuestHelper: Assert(not c or type(c) == "number")
    QuestHelper: Assert(not z or type(z) == "number")
    
    -- Deal with waypoint callbacks
    if QuestHelper_Pref.hide or UnitIsDeadOrGhost("player") and not QuestHelper.InBrokenInstance then
      QuestHelper:InvokeWaypointCallbacks()
    else
      QuestHelper:InvokeWaypointCallbacks(c, z, x, y, textdesc)
    end
    
    if self.obj and not QuestHelper.InBrokenInstance then
      self:Show() -- really only triggers if the non-broken-instance code is being poked
      
      if not QuestHelper_Pref.hide and QuestHelper.Astrolabe:PlaceIconOnMinimap(self, convertLocation(self.obj.loc)) ~= -1 then
        local edge = QuestHelper.Astrolabe:IsIconOnEdge(self)
        
        if edge then
          self.arrow:Show()
          self.dot:Hide()
          self.bg:Hide()
        else
          self.arrow:Hide()
          self.dot:Show()
          self.bg:Show()
          
          self.dot:SetAlpha(QuestHelper_Pref.mini_opacity)
          self.bg:SetAlpha(QuestHelper_Pref.mini_opacity)
        end
        
        if edge then
          local angle = QuestHelper.Astrolabe:GetDirectionToIcon(self)
          if GetCVar("rotateMinimap") == "1" then
            angle = angle + QuestHelper.Astrolabe:GetFacing()
          end
          
          if elapsed then
            if self.phase > 6.283185307179586476925 then
              self.phase = self.phase-6.283185307179586476925+elapsed*3.5
            else
              self.phase = self.phase+elapsed*3.5
            end
          end
          
          local scale = 1.0 + 0.1 * math.sin(self.phase)
        
          local x, y = scale * math.sin(angle + 3.14159 * 0.75) * math.sqrt(0.5), scale * math.cos(angle + 3.14159 * 0.75) * math.sqrt(0.5)
          self.arrow:SetTexCoord(0.5 - x, 0.5 + y, 0.5 + y, 0.5 + x, 0.5 - y, 0.5 - x, 0.5 + x, 0.5 - y)
        end
      else
        self:Hide()
      end
    else
      self:Hide()
    end
  end
  
  function icon:SetObjective(obj)
    self:SetHeight(20*QuestHelper_Pref.scale)
    self:SetWidth(20*QuestHelper_Pref.scale)
    
    if obj ~= self.obj then
      self.obj = obj
      
      self.recalc_timeout = 0
      
      if self.dot then QuestHelper:ReleaseTexture(self.dot) self.dot = nil end
      
      if self.obj then
        self.dot = QuestHelper:CreateIconTexture(self, self.obj.icon_id or 8)
        self.dot:SetPoint("TOPLEFT", icon, "TOPLEFT", 2, -2)
        self.dot:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", -2, 2)
      end
      
      self:OnUpdate(0)
    end
  end
  
  function icon:OnEnter()
    if self.obj then
      QuestHelper.tooltip:SetOwner(self, "ANCHOR_CURSOR")
      QuestHelper.tooltip:ClearLines()
      
      --[[if self.target[5] then
        QuestHelper.tooltip:AddLine(QHFormat("WAYPOINT_REASON", self.target[5]), unpack(QuestHelper:GetColourTheme().tooltip))
        QuestHelper.tooltip:GetPrevLines():SetFont(QuestHelper.font.serif, 14)
      end]]
      
      QuestHelper:AppendObjectiveToTooltip(self.obj)
      QuestHelper.tooltip:Show()
    end
  end
  
  function icon:OnLeave()
    QuestHelper.tooltip:Hide()
  end
  
  function icon:OnClick()
    rightclick_menu(self.obj)
  end
  
  function icon:OnEvent()
    if self.obj then
      self:Show()
    else
      self:Hide()
    end
  end
  
  QH_Hook(icon, "OnUpdate", icon.OnUpdate)
  QH_Hook(icon, "OnEnter", icon.OnEnter)
  QH_Hook(icon, "OnLeave", icon.OnLeave)
  QH_Hook(icon, "OnClick", icon.OnClick)
  
  icon:RegisterForClicks("RightButtonUp")
  
  QH_Event("PLAYER_ENTERING_WORLD", function () icon:OnEvent() end)
  
  return icon
end
