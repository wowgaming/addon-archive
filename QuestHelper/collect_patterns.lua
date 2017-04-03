QuestHelper_File["collect_patterns.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_patterns.lua"] = GetTime()

local patterns = {}

function MakePattern(label, newpat)
  if not newpat then newpat = ".*" end
  if not patterns[label] then patterns[label] = "^" .. string.gsub(_G[label], "%%s", newpat) .. "$" end
end

function MakeNumberSnag(label)
  if not patterns[label] then patterns[label] = string.gsub(_G[label], "%%d", "([0-9,.]+)") end
end

function QH_Collect_Patterns_Init(QHCData, API)
  API.Patterns = patterns
  API.Patterns_Register = MakePattern
  API.Patterns_RegisterNumber = MakeNumberSnag
end
