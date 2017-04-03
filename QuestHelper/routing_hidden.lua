QuestHelper_File["routing_hidden.lua"] = "1.4.1"
QuestHelper_Loadtime["routing_hidden.lua"] = GetTime()

local NodeChainIgnored = {
  name = "routing_core_internal_node_ignored",
  no_exception = true,
  no_disable = true,
  friendly_reason = QHText("DEPENDS_ON"),
}

function QH_PopulateHidden(menu)
  local part_of_cluster = {}
  
  local ignore_reasons = {}
  
  QH_Route_TraverseClusters(
    function (clust)
      local igcount = {}
      
      for _, v in ipairs(clust) do
        part_of_cluster[v] = true
        
        QH_Route_IgnoredReasons_Node(v, function (reason)
          igcount[reason] = (igcount[reason] or 0) + 1
        end)
      end
      
      QH_Route_IgnoredReasons_Cluster(clust, function (reason)
        igcount[reason] = #clust
      end)
      
      for k, v in pairs(igcount) do
        if not ignore_reasons[clust[1]] then ignore_reasons[clust[1]] = {} end
        table.insert(ignore_reasons[clust[1]], {reason = k, partial = (v ~= #clust), items = clust})
      end
      
      if not ignore_reasons[clust[1]] then
        if QH_Route_Ignored_Cluster(clust) then
          ignore_reasons[clust[1]] = {{reason = NodeChainIgnored, partial = false, items = clust}} -- hmm what
        end
      end
    end
  )
  
  QH_Route_TraverseNodes(
    function (node)
      if part_of_cluster[node] then return end
      
      QH_Route_IgnoredReasons_Node(node, function(reason)
        if not ignore_reasons[node] then ignore_reasons[node] = {} end
        table.insert(ignore_reasons[node], {reason = reason, partial = false, items = {node}})
      end)
    end
  )
  
  local ignore_sorty = {}
  
  for k, v in pairs(ignore_reasons) do
    table.insert(ignore_sorty, {objective = k, ignores = v})
  end
  
  table.sort(ignore_sorty, function (a, b)
    if a.objective.type_quest and b.objective.type_quest then
      --if a.objective.type_quest.level ~= b.objective.type_quest.level then return a.objective.type_quest.level < b.objective.type_quest.level end
      return a.objective.type_quest.title < b.objective.type_quest.title
    elseif a.objective.type_quest then return true
    elseif b.objective.type_quest then return false
    else
      -- meh
      return false
    end
  end)
  -- we'll sort this eventually
  
  for _, v in ipairs(ignore_sorty) do
    local ignored = QuestHelper:CreateMenuItem(menu, v.objective.hidden_desc or v.objective.map_desc[1])
    
    local ignored_menu = QuestHelper:CreateMenu()
    ignored:SetSubmenu(ignored_menu)
    
        
    local no_exception = false
    for _, ign in ipairs(v.ignores) do
      if ign.reason.no_exception then
        no_exception = true
      end
    end
    
    if not no_exception then
      local show = QuestHelper:CreateMenuItem(ignored_menu, QHText("HIDDEN_SHOW"))
      show:SetFunction(function ()
        for _, ign in ipairs(v.ignores) do
          for _, v in ipairs(ign.items) do
            ign.reason:AddException(v)
          end
        end
        QH_Route_Filter_Rescan() -- DO IT ALL
      end)
    else
      local show = QuestHelper:CreateMenuItem(ignored_menu, QHText("HIDDEN_SHOW_NO"))
    end
    
    for _, ign in ipairs(v.ignores) do
      local thisitem = QuestHelper:CreateMenuItem(ignored_menu, ign.reason.friendly_reason)
      
      if not ign.reason.no_exception or not ign.reason.no_disable then
        local deign_menu = QuestHelper:CreateMenu()
        thisitem:SetSubmenu(deign_menu)
        
        if not ign.reason.no_exception then
          local exception = QuestHelper:CreateMenuItem(deign_menu, QHText("HIDDEN_EXCEPTION"))
          exception:SetFunction(function ()
            for _, v in ipairs(ign.items) do
              ign.reason:AddException(v)
            end
            QH_Route_Filter_Rescan(ign.reason.name)
          end)
        end
        
        if not ign.reason.no_disable then
          local disable = QuestHelper:CreateMenuItem(deign_menu, QHFormat("DISABLE_FILTER", ign.reason.friendly_name))
          disable:SetFunction(function () ign.reason:Disable() QH_Route_Filter_Rescan(ign.reason.name) end)
        end
      end
    end
  end
end

function QH_Hidden_Menu()
  local menu = QuestHelper:CreateMenu()
  QuestHelper:CreateMenuTitle(menu, QHText("HIDDEN_TITLE"))
  
  QH_PopulateHidden(menu)
  
  menu:ShowAtCursor()
end
