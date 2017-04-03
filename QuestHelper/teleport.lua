QuestHelper_File["teleport.lua"] = "1.4.1"
QuestHelper_Loadtime["teleport.lua"] = GetTime()

function QuestHelper:CreateTeleportInfo()
  local info = self:CreateTable()
  info.node = self:CreateTable()
  info.reag = self:CreateTable()
  return info
end

function QuestHelper:ReleaseTeleportInfo(info)
  for _, data in pairs(info.node) do
    self:ReleaseTable(data)
  end
  
  self:ReleaseTable(info.node)
  self:ReleaseTable(info.reag)
  self:ReleaseTable(info)
end

function QuestHelper:TeleportInfoClear(info)
  for node, data in pairs(info.node) do
    self:ReleaseTable(data)
    info.node[node] = nil
  end
  
  for id in pairs(info.reag) do
    info.reag[id] = nil
  end
end

function QuestHelper:SetTeleportInfoTarget(info,
                                           node, -- The world graph node this will take us to.
                                           start, -- The last time this spell was used.
                                           duration, -- How long the spell cooldown is.
                                           cast, -- How long does the spell take to cast.
                                           reagent_id) -- What reagent is consumed by using the spell (can be nil)
  local data = info.node[node]
  if not data then data = self:CreateTable() info.node[node] = data end
  
  data[1], data[2], data[3], data[4] = start, duration, cast, reagent_id
end

function QuestHelper:SetTeleportInfoReagent(info, reagent_id, count)
  if count > 0 then
   info.reag[reagent_id] = count
  else
    info.reag[reagent_id] = nil
  end
end

function QuestHelper:TeleportInfoUseNode(info, node, time_delta)
  local data = info.node[node]
  if data then
    self:TextOut("Used "..(node.name or "unnamed node").." in path.")
    
    data[1] = GetTime()+time_delta
    if data[3] then
      local count = info.reag[data[3]] or 0
      count = count - 1
      if count > 1 then
        info.reag[data[4]] = count
      else
        info.reag[data[4]] = nil
      end
    end
  end
end

function QuestHelper:TeleportInfoTransfer(original, dest)
  for key in pairs(dest.node) do
    if not original.node[key] then
      self:ReleaseTable(dest.node[key])
      dest.node[key] = nil
    end
  end
  
  for key, data in pairs(original.node) do
    local data2 = dest.node[key]
    if not data2 then
      data2 = self:CreateTable()
      dest.node[key] = data2
    end
    data2[1], data2[2], data2[3], data2[4] = data[1], data[2], data[3], data[4]
  end
  
  for key in pairs(dest.reag) do
    if not original.reag[key] then
      dest.reag[key] = nil
    end
  end
  
  for key, value in pairs(original.reag) do
    dest.reag[key] = value
  end
end

function QuestHelper:TeleportInfoAddGraphPoints(info, graph, end_list, time_delta)
  for node, data in pairs(info.node) do
    if data[1]+data[2] >= time_delta+GetTime() and (not data[4] or (data[4] and info.reag[data[4]])) then
      self:TextOut("Considering "..(node.name or "unnamed node").." for use in pathing.")
      graph:AddStartNode(node, data[3], end_list)
    end
  end
end

QuestHelper.teleport_info = QuestHelper:CreateTeleportInfo()
