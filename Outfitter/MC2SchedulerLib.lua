local _, Addon = ...

----------------------------------------
Addon.SchedulerLib =
----------------------------------------
{
	Version = 1,
	
	EventFrame = CreateFrame("Frame", nil, UIParent),
	
	HasTasks = false,
	NeedSorted = false,
	Tasks = {},
	
	IteratorIndex = nil,
	IteratorCount = nil,
}

Addon.SchedulerLib.EventFrame.SchedulerLib = Addon.SchedulerLib
Addon.SchedulerLib.EventFrame:SetScript("OnUpdate", function (self, elapsed) self.SchedulerLib:OnUpdate(elapsed) end)

function Addon.SchedulerLib:ScheduleTask(pDelay, pFunction, pParam, pTaskName)
	if type(pFunction) ~= "function" then
		error("Attempt to schedule an invalid function (passed "..type(pFunction).." instead)")
	end
	
	local vTask =
	{
		Time = GetTime() + pDelay,
		Function = pFunction,
		Param = pParam,
		Name = pTaskName,
	}
	
	self:InsertTask(vTask)
end

function Addon.SchedulerLib:RescheduleTask(pDelay, pFunction, pParam, pTaskName)
	self:UnscheduleTask(pFunction, pParam)
	self:ScheduleTask(pDelay, pFunction, pParam, pTaskName)
end

function Addon.SchedulerLib:ScheduleUniqueTask(pDelay, pFunction, pParam, pTaskName)
	if self:FindTask(pFunction, pParam) then
		return
	end
	
	self:ScheduleTask(pDelay, pFunction, pParam, pTaskName)
end

function Addon.SchedulerLib:ScheduleRepeatingTask(pInterval, pFunction, pParam, pInitialDelay, pTaskName)
	local vTask =
	{
		Interval = pInterval,
		Function = pFunction,
		Param = pParam,
		Name = pTaskName,
	}
	
	if pInitialDelay then
		vTask.Time = GetTime() + pInitialDelay
	else
		vTask.Time = GetTime() + pInterval
	end
	
	self:InsertTask(vTask)
end

function Addon.SchedulerLib:ScheduleUniqueRepeatingTask(pInterval, pFunction, pParam, pInitialDelay, pTaskName)
	if self:FindTask(pFunction, pParam) then
		return
	end
	
	self:ScheduleRepeatingTask(pInterval, pFunction, pParam, pInitialDelay, pTaskName)
end

function Addon.SchedulerLib:SetTaskInterval(pInterval, pFunction, pParam)
	local vTask, vIndex = self:FindTask(pFunction, pParam)
	
	if not vTask then
		return
	end
	
	if vTask.Interval == pInterval then
		return
	end
	
	if vTask.Interval then
		vTask.Time = vTask.Time - vTask.Interval
	end
	
	vTask.Interval = pInterval

	if vTask.Interval then
		vTask.Time = vTask.Time + vTask.Interval
	end
	
	self.NeedSorted = true
end

function Addon.SchedulerLib:SetTaskDelay(pDelay, pFunction, pParam)
	local vTask, vIndex = self:FindTask(pFunction, pParam)
	
	if not vTask then
		return
	end
	
	vTask.Time = GetTime() + pDelay
	
	self.NeedSorted = true
end

function Addon.SchedulerLib:InsertTask(pTask)
	if not pTask then
		error("Inserting a nil task")
	end
	
	table.insert(self.Tasks, pTask)
	
	self.NeedSorted = true
	
	if not self.HasTasks then
		self.EventFrame:Show()
		self.HasTasks = true
	end
end

function Addon.SchedulerLib:UnscheduleAllTasks(pFunction, pParam)
	while self:UnscheduleTask(pFunction, pParam) do
	end
end

function Addon.SchedulerLib:UnscheduleTask(pFunction, pParam)
	local vTask, vIndex = self:FindTask(pFunction, pParam)
	
	if not vTask then
		return false
	end
	
	table.remove(self.Tasks, vIndex)
	
	if self.IteratorIndex
	and vIndex < self.IteratorIndex then
		self.IteratorIndex = self.IteratorIndex - 1
	end
	
	if #self.Tasks == 0 then
		self.HasTasks = false
		self.EventFrame:Hide()
	end
	
	return true
end

function Addon.SchedulerLib:FindTask(pFunction, pParam)
	for vIndex, vTask in ipairs(self.Tasks) do
		if (pFunction == nil or vTask.Function == pFunction)
		and (pParam == nil or vTask.Param == pParam) then
			return vTask, vIndex
		end
	end -- for
end

function Addon.SchedulerLib:OnUpdate(pElapsed)
	-- Prevent from re-entering
	
	if self.OnUpdateRunning then
		-- self:TestMessage("OnUpdate already running")
		return
	end
	
	self.OnUpdateRunning = true
	
	for vIndex, vTask in ipairs(self.Tasks) do
		vTask.DidRun = false
	end
	
	self:OnUpdate2(pElapsed)
	
	self.OnUpdateRunning = false
end

function Addon.SchedulerLib:OnUpdate2(pElapsed)
	local vTime = GetTime()
	
	if self.PerfMonitor then
		self.PerfMonitor:FunctionEnter(vTime)
	end
	
	--
	
	if self.NeedSorted then
		self.NeedSorted = false
		table.sort(self.Tasks, self.CompareTasks)
	end
	
	self.IteratorIndex = 1
	
	while self.IteratorIndex <= #self.Tasks do
		local vTask = self.Tasks[self.IteratorIndex]
		
		if not vTask then
			Addon:ErrorMessage("nil task at index "..self.IteratorIndex)
			table.remove(self.Tasks, self.IteratorIndex)
		elseif vTask.DidRun then
			-- Ignore it
			
			self.IteratorIndex = self.IteratorIndex + 1
		else
			if vTask.Time > vTime then
				break
			end
			
			-- Re-schedule or remove one-shot tasks before calling their function
			-- in case the function decides it wants to remove the task too
			
			if vTask.Interval == nil then
				table.remove(self.Tasks, self.IteratorIndex)
			
			-- Repeat tasks just need a new time calculated
			
			else
				vTask.Time = vTask.Time + vTask.Interval
				
				if vTask.Interval > 0 then
					self.NeedSorted = true
				end
				
				self.IteratorIndex = self.IteratorIndex + 1
			end
			
			-- Call the function
			
			-- Addon:DebugMessage("Calling task %s", vTask.Name or "anonymous")
			
			if not vTask.Disabled then
				local vResult, vMessage
				
				vTask.DidRun = true
				
				if vTask.Param ~= nil then
					vTask.Function(vTask.Param, vTime)
				else
					vTask.Function(vTime)
				end
			end
		end
	end -- while
	
	self.IteratorIndex = nil
	
	if #self.Tasks == 0 then
		self.HasTasks = false
		self.EventFrame:Hide()
	end
	
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

function Addon.SchedulerLib.CompareTasks(pTask1, pTask2)
	return pTask1.Time < pTask2.Time
end
