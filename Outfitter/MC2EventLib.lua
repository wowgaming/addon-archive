local _, Addon = ...

Addon.EventLib =
{
	Version = 1,
	Handlers = {},
	Iterators = {},
	EventFrame = CreateFrame("FRAME", nil, UIParent),
}

function Addon.EventLib:DispatchEvent(pEventID, ...)
	local vHandlers = self.Handlers[pEventID]
	
	if not vHandlers then
		return
	end
	
	local vIterator = self.Iterators[pEventID]
	
	if vIterator then
		return
	end
	
	-- Addon:DebugMessage("Dispatching event %s", pEventID)
	
	vIterator = {Index = 1, Count = #vHandlers}
	
	self.Iterators[pEventID] = vIterator
	
	while vIterator.Index <= vIterator.Count do
		local vHandler = vHandlers[vIterator.Index]
		
		if vHandler.Blind then
			if vHandler.RefParam ~= nil then
				vHandler.Function(vHandler.RefParam, ...)
			else
				vHandler.Function(...)
			end
		else
			if vHandler.RefParam ~= nil then
				vHandler.Function(vHandler.RefParam, pEventID, ...)
			else
				vHandler.Function(pEventID, ...)
			end
		end
		
		vIterator.Index = vIterator.Index + 1
	end
	
	self.Iterators[pEventID] = nil

	if self.PerfMonitor then
		local vEndTime = GetTime()
		
		self.PerfMonitor:FunctionExit(vEndTime)
		
		if not self.LastDumpTime
		or vEndTime - self.LastDumpTime > 2 then
			self.LastDumpTime = vEndTime
			
			self.PerfMonitor:DumpValue()
		end
	end
end

function Addon.EventLib:RegisterEvent(pEventID, pFunction, pRefParam, pBlind)
	if not pFunction then
		error(string.format("Attempted to register a nil function pointer for event %s", pEventID or "unknown"))
	end
	
	local vIsRegistered, vIndex = self:EventIsRegistered(pEventID, pFunction, pRefParam)
	
	if vIsRegistered then
		error(string.format("Attempted to register a handler twice for %s", pEventID))
	end
	
	local vHandlers = self.Handlers[pEventID]
	
	if not vHandlers then
		vHandlers = {}
		self.Handlers[pEventID] = vHandlers
		
		if self.EventFrame then
			self.EventFrame:RegisterEvent(pEventID)
		end
	end
	
	local vHandler =
	{
		Function = pFunction,
		RefParam = pRefParam,
		Blind = pBlind,
	}
	
	table.insert(vHandlers, vHandler)
end

function Addon.EventLib:EventIsRegistered(pEventID, pFunction, pRefParam)
	local vHandlers = self.Handlers[pEventID]
	
	if not vHandlers then
		return false
	end
	
	for vIndex, vHandler in ipairs(vHandlers) do
		if (not pFunction or vHandler.Function == pFunction)
		and (not pRefParam or vHandler.RefParam == pRefParam) then
			return true, vIndex
		end
	end
	
	return false
end

function Addon.EventLib:UnregisterEvent(pEventID, pFunction, pRefParam)
	local vIsRegistered, vIndex = self:EventIsRegistered(pEventID, pFunction, pRefParam)
	
	if not vIsRegistered then
		return
	end
	
	local vHandlers = self.Handlers[pEventID]
	
	table.remove(vHandlers, vIndex)
	
	if #vHandlers == 0 then
		self.Handlers[pEventID] = nil
		
		if self.EventFrame then
			self.EventFrame:UnregisterEvent(pEventID)
		end
	end
	
	local vIterator = self.Iterators[pEventID]
	
	if vIterator then
		if vIndex <= vIterator.Index then
			vIterator.Index = vIterator.Index - 1
		end
		
		vIterator.Count = vIterator.Count - 1
	end
end

function Addon.EventLib:UnregisterAllEvents(pFunction, pRefParam)
	for vEventID, vHandlers in pairs(self.Handlers) do
		self:UnregisterEvent(vEventID, pFunction, pRefParam)
	end
end

Addon.EventLib.EventFrame.EventLib = Addon.EventLib

Addon.EventLib.HardwareEvents =
{
	["TRADE_SKILL_SHOW"] = true,
	["TRADE_SKILL_CLOSE"] = true,
}

Addon.EventLib.EventFrame:SetScript("OnEvent", function (pFrame, pEvent, ...)
	local vHadHWEvent = Addon.HasHWEvent
	Addon.HasHWEvent = Addon.HasHWEvent or Addon.EventLib.HardwareEvents[pEvent]
	pFrame.EventLib:DispatchEvent(pEvent, ...)
	Addon.HasHWEvent = vHadHWEvent
end)
