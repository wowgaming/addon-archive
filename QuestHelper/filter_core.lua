QuestHelper_File["filter_core.lua"] = "1.4.1"
QuestHelper_Loadtime["filter_core.lua"] = GetTime()

function QH_MakeFilter(name, func, params)
  QuestHelper: Assert(params.friendly_reason)
  QuestHelper: Assert(params.friendly_name)
  return {
    Process = function(self, item, ...)
      if self.exceptions[item] then return false end
      return func(item, ...)
    end,
    name = name,
    friendly_reason = params.friendly_reason,
    friendly_name = params.friendly_name,
    exceptions = setmetatable({}, {__mode="k"}),
    AddException = function(self, except)
      self.exceptions[except] = true
    end,
    Disable = function (self)
      QuestHelper_Pref["filter_" .. self.friendly_name] = false -- hackery
    end
  }
end
