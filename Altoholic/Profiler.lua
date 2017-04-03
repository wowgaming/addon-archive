-- Simple code profiler, inspired by Chapter 1.14 (p120-130) of Game Programming Gems 1 
-- Ported from C++ to Lua by Thaoky. It will most likely evolve as my needs change.

local addonName = "Altoholic"
local addon = _G[addonName]

addon.Profiler = {}

local ns = addon.Profiler		-- ns = namespace

local samples
local startProfile
local level			-- for the code hierarchy, unused for now, but already valid, will be useful when Dumping into a real frame
local count			-- to sort samples

function ns:Init() 
	samples = samples or {}
	wipe(samples)
	startProfile = GetTime()
	level = 0
	count = 0
end

function ns:Begin(name)
	samples[name] = samples[name] or {}
	local p = samples[name]
	
	p.startTime = GetTime() 
	if p.numPasses then						-- if numPasses exists, it's an existing entry, update it and exit
		p.numPasses = p.numPasses + 1
		return
	end

	p.accumulator = 0
	p.duration = 0
	p.numPasses = 1
	
	p.level = level
	level = level + 1
	count = count + 1
	p.position = count
end

function ns:End(name)
	local p = samples[name]
	if not p then return end
	
	p.duration = GetTime() - p.startTime 
	p.minTime = p.minTime or p.duration
	if p.duration < p.minTime then			-- new min ?
		p.minTime = p.duration
	end
	
	p.maxTime = p.maxTime or p.duration		-- new max ?
	if p.duration > p.maxTime then
		p.maxTime = p.duration
	end
	
	p.accumulator = p.accumulator + p.duration 
	level = level - 1
end

function ns:Dump() 
	local view = {}
	
	for k, _ in pairs(samples) do
		table.insert(view, k)
	end
	
	sort(view, function(a, b)
		return samples[a].position < samples[b].position
	end) 

	addon:Print("Profiler Samples") 
	addon:Print("   Avg   |   Min   |   Max   |  Num  |  Name") 
	for _, name in ipairs(view) do
		local v = samples[name]
		addon:Print(format(" %.1f ms | %.1f ms | %.1f ms | %d | %s",
			(v.accumulator/v.numPasses)*1000, v.minTime*1000, v.maxTime*1000, v.numPasses, name))
	end 
end

function ns:GetSampleDuration(name) 
	local p = samples[name] 
	return p and p.duration or 0 
end
