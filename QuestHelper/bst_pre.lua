--[====[

-- Crazy profiling madness
-- sed -i s/{/QH_RegisterTable{/g `ls | grep lua | grep -v static`

-- This is grimness so we can just apply the filter indiscriminately

local QHRT
QH_RegisterTable = function(...) return QHRT(...) end

local QH_RegisterTable = function(...) return ... end

QHT_Types = setmetatable({}, {__mode="k"})

QHRT = function(tab, override, tag)
  if not override then --[[ assert(not QHT_Types[tab]) ]] end
  QHT_Types[tab] = tag or string.gsub(debugstack(2, 1, 1), "\n.*", "")
  return tab
end
function QH_CTprint(sum)
  local typ = {}
  for k, v in pairs(sum) do
    table.insert(typ, {k = k, v = v})
  end
  
  table.sort(typ, function(a, b) return a.v < b.v end)
  
  for _, v in pairs(typ) do
    if v.v > 0 then
      print(v.v, v.k)
    end
  end
end
function QH_CTacu()
  local sum = {}
  for k, v in pairs(QHT_Types) do
    sum[v] = (sum[v] or 0) + 1
  end
  
  return sum
end

function QH_CheckTables()
  local before = QH_CTacu()
  collectgarbage("collect")
  local after = QH_CTacu()
  
  local sum = {}
  for k, v in pairs(before) do sum[k] = (before[k] or 0) - (after[k] or 0) end
  for k, v in pairs(after) do sum[k] = (before[k] or 0) - (after[k] or 0) end
  QH_CTprint(sum)
end
function QH_PrintTables()
  QH_CTprint(QH_CTacu())
end

]====]

QuestHelper_File = {}
QuestHelper_Loadtime = {}
QuestHelper_File["bst_pre.lua"] = "1.4.1"
QuestHelper_Loadtime["bst_pre.lua"] = GetTime()
