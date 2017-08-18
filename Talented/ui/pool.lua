local rawget = rawget
local rawset = rawset
local setmetatable = setmetatable
local pairs = pairs
local ipairs = ipairs

local Pool = {
	pools = {},
	sets = {},
}

function Pool:new()
	local pool = setmetatable({ used = {}, available = {} }, self)
	self.pools[pool] = true
	return pool
end

function Pool:changeSet(name)
	if not self.sets[name] then
		self.sets[name] = {}
	end
	assert(self.sets[name])
	self.set = name
	self:clearSet(name)
end

function Pool:clearSet(name)
	local set = self.sets[name]
	assert(set)
	for widget, pool in pairs(set) do
		assert(pool.used[widget])
		widget:Hide()
		pool.used[widget] = nil
		pool.available[widget] = true
		set[widget] = nil
	end
end

function Pool:AddToSet(widget, pool)
	self.sets[self.set][widget] = pool
end

Pool.__index = {
	next = function (self)
		local widget = next(self.available)
		if not widget then return end
		self.available[widget] = nil
		self.used[widget] = true
		widget:Show()
		Pool:AddToSet(widget, self)
		return widget
	end,
	push = function (self, widget)
		self.used[widget] = true
		Pool:AddToSet(widget, self)
	end,
}

Talented.Pool = Pool
