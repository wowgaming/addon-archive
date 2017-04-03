QuestHelper_File["collect_merger.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_merger.lua"] = GetTime()


local function Add(self, data, stoprepeat)  -- NOTE: if you're getting errors about adding tables, you probably did Merger:Add instead of Merger.Add
  if stoprepeat and #self > 0 and string.sub(self[#self], -#data) == data then return end
  table.insert(self, data)
  for i = #self - 1, 1, -1 do
    if string.len(self[i]) > string.len(self[i + 1]) then break end
    self[i] = self[i] .. table.remove(self, i + 1)
  end
end
local function Finish(self, data)
  for i = #self - 1, 1, -1 do
    self[i] = self[i] .. table.remove(self)
  end
  return self[1] or ""
end

QH_Merger_Add = Add
QH_Merger_Finish = Finish

function QH_Collect_Merger_Init(_, API)
  API.Utility_Merger = {Add = Add, Finish = Finish}
end
