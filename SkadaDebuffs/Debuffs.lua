local L = LibStub("AceLocale-3.0"):GetLocale("Skada", false)

local Skada = Skada

local mod = Skada:NewModule(L["Debuff uptimes"], "AceTimer-3.0")
local auramod = Skada:NewModule(L["Debuff spell list"])

-- This is highly inefficient. Come up with something better.
local function tick_spells(set)
	for i, player in ipairs(set.players) do
		for spellname, spell in pairs(player.auras) do
			if spell.active > 0 then
				spell.uptime = spell.uptime + 1
				player.uptime = player.uptime + 1
			end
		end
	end
end

-- Adds 1s to the uptime of all currently active spells.
-- A spell is considered active if at least 1 instance of it is still active.
-- We determine this by incrementing or subtracting from a counter.
-- This is less messy than fooling around with the aura events.
function mod:Tick()
	if Skada.current then
	
		tick_spells(Skada.current)
		tick_spells(Skada.total)
	end
end

local function log_auraapply(set, aura)
	if set then
		
		-- Get the player.
		local player = Skada:get_player(set, aura.playerid, aura.playername)
		if player then
			-- Add aura to player if it does not exist.
			-- If it does exist, increment our counter of active instances by 1
			if not player.auras[aura.spellname] then
				player.auras[aura.spellname] = {id = aura.spellid, name = aura.spellname, active = 1, uptime = 0}
			else
				player.auras[aura.spellname].active = player.auras[aura.spellname].active + 1
			end
		end
		
	end
end

local function log_auraremove(set, aura)
	if set then
		
		-- Get the player.
		local player = Skada:get_player(set, aura.playerid, aura.playername)
		if player then
			-- If aura does not exist, we know nothing about it and ignore it.
			-- If it does exist and we know of 1 or more active instances, subtract 1 from our counter.
			if player.auras[aura.spellname] then
				local a = player.auras[aura.spellname]
				if a.active > 0 then
					a.active = a.active - 1
				end
			end
		end
		
	end
end

local aura = {}

local function AuraApplied(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	local spellId, spellName, spellSchool, auraType = ...
	if auraType == "DEBUFF" then

		aura.playerid = srcGUID
		aura.playername = srcName
		aura.spellid = spellId
		aura.spellname = spellName
		aura.auratype = auraType
		
		Skada:FixPets(aura)
		log_auraapply(Skada.current, aura)
		log_auraapply(Skada.total, aura)
	end
end

local function AuraRemoved(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	local spellId, spellName, spellSchool, auraType = ...
	if auraType == "DEBUFF" then
	
		aura.playerid = srcGUID
		aura.playername = srcName
		aura.spellid = spellId
		aura.spellname = spellName
		aura.auratype = auraType
	
		Skada:FixPets(aura)
		log_auraremove(Skada.current, aura)
		log_auraremove(Skada.total, aura)
	end
end

local function len(t)
	local l = 0
	for i,j in pairs(t) do
		l = l + 1
	end
	return l
end

function mod:Update(win, set)
	local nr = 1
	local max = 0

	for i, player in ipairs(set.players) do
		local auras = len(player.auras)
		if auras > 0 then
			-- Calculate player max possible uptime.
			local maxtime = Skada:PlayerActiveTime(set, player)
			
			-- Now divide by the number of spells to get the average uptime.
			local uptime = player.uptime / auras
			
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			
			d.id = player.id
			d.value = uptime
			d.label = player.name
			d.valuetext = ("%02.1f%% / %u"):format(uptime / maxtime * 100, auras)
			d.class = player.class

			if uptime > max then
				max = uptime
			end
			
			nr = nr + 1
		end
	end
	
	win.metadata.maxvalue = max
end

function auramod:Enter(win, id, label)
	auramod.playerid = id
	auramod.title = label..L["'s Debuffs"]
end

-- Detail view of a player.
function auramod:Update(win, set)
	-- View spells for this player.
	local nr = 1
	local max = 0
	local player = Skada:find_player(set, self.playerid)
	
	if player then
		-- Calculate player max possible uptime.
		local maxtime = Skada:PlayerActiveTime(set, player)
		
		win.metadata.maxvalue = maxtime
		for spellname, spell in pairs(player.auras) do
			
			local uptime = spell.uptime

			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			
			d.id = spell.name
			d.value = uptime
			d.label = spell.name
			d.icon = select(3, GetSpellInfo(spell.id))
			d.valuetext = ("%02.1f%%"):format(uptime / maxtime * 100)
			
			nr = nr + 1
		end
	end
	
end

function mod:OnEnable()
	mod.metadata 		= {showspots = 1, click1 = auramod}
	auramod.metadata 	= {}

	Skada:RegisterForCL(AuraApplied, 'SPELL_AURA_APPLIED', {src_is_interesting = true})
	Skada:RegisterForCL(AuraRemoved, 'SPELL_AURA_REMOVED', {src_is_interesting = true})
	
	self:ScheduleRepeatingTimer("Tick", 1)

	Skada:AddMode(self)
end

function mod:OnDisable()
	Skada:RemoveMode(self)
end

function mod:AddToTooltip(set, tooltip)
end

-- Called by Skada when a new player is added to a set.
function mod:AddPlayerAttributes(player)
	if not player.auras then
		player.auras = {}
		player.uptime = 0
	end
end

-- Called by Skada when a new set is created.
function mod:AddSetAttributes(set)
end