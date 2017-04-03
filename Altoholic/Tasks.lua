-- Simple task manager
-- Written by : Thaoky, EU-Marécages de Zangar

local addon = Altoholic
addon.Tasks = {}

function addon.Tasks:Init()
	self.List = self.List or {}
	wipe(self.List)
end

function addon.Tasks:OnUpdate(elapsed)
	for name, task in pairs(self.List) do
		task.delay = task.delay - elapsed
		if task.delay <= 0 then
			if task.func then
				if not task.func(task.owner, elapsed) then
					-- execute the task, if it doesn't return anything, delete it.
					-- if it does, keep it in the list, and execute it in every pass (set a delay of 0).
					-- if necessary, reschedule by updating the delay
					-- The function is responsible for returning the right value
					self:Remove(name)
				end
			end
		end
	end
end

function addon.Tasks:Add(name, delay, func, owner)
	if not self.List[name] then
		self.List[name] = {}
	end

	local p = self.List[name]
	p.delay = delay						-- time before executing the task
	p.func = func							-- function pointer to the task
	p.owner = owner						-- owner (table or frame)
end

function addon.Tasks:Remove(name)
	local p = self.List[name]
	if p then
		wipe(p)
		self.List[name] = nil
	end
end

function addon.Tasks:Get(name)
	return self.List[name]
end

function addon.Tasks:Reschedule(name, delay)
	local p = self.List[name]
	if p then
		p.delay = delay						-- time before executing the task
	end	
end
