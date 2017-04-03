local L = LibStub("AceLocale-3.0"):GetLocale("Skada", false)

local Skada = Skada

local mod = Skada:NewModule(L["Deaths"])
local deathlog = Skada:NewModule(L["Death log"])

local function log_resurrect(set, playerid, playername)
	local player = Skada:get_player(set, playerid, playername)
	wipe(player.deathlog)
end

local function log_deathlog(set, playerid, playername, spellid, spellname, amount, timestamp)
	local player = Skada:get_player(set, playerid, playername)
	
	table.insert(player.deathlog, 1, {["spellid"] = spellid, ["spellname"] = spellname, ["amount"] = amount, ["ts"] = timestamp, hp = UnitHealth(playername)})
	
	-- Max health.
	if player.maxhp == 0 then
		player.maxhp = UnitHealthMax(playername)
	end
	
	-- Trim.
	while table.maxn(player.deathlog) > 15 do table.remove(player.deathlog) end
end

local function log_death(set, playerid, playername, timestamp)
	local player = Skada:get_player(set, playerid, playername)
	
	-- Add to player deaths.
	player.deaths = player.deaths + 1
	
	-- Set timestamp for death.
	player.deathts = timestamp
	
	-- Also add to set deaths.
	set.deaths = set.deaths + 1
end

local function UnitDied(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	if not UnitIsFeignDeath(dstName) then	-- Those pesky hunters
		log_death(Skada.current, dstGUID, dstName, timestamp)
		log_death(Skada.total, dstGUID, dstName, timestamp)
	end
end

local function SpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	-- Spell damage.
	local spellId, spellName, spellSchool, samount, soverkill, sschool, sresisted, sblocked, sabsorbed, scritical, sglancing, scrushing = ...
	
	dstGUID, dstName = Skada:FixMyPets(dstGUID, dstName)
	if srcName then
		log_deathlog(Skada.current, dstGUID, dstName, spellId, srcName..L["'s "]..spellName, 0-samount, timestamp)
	else
		log_deathlog(Skada.current, dstGUID, dstName, spellId, spellName, 0-samount, timestamp)
	end
end

local function SwingDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	-- White melee.
	local samount, soverkill, sschool, sresisted, sblocked, sabsorbed, scritical, sglancing, scrushing = ...
	local spellid = 6603
	local spellname = L["Attack"]
	
	dstGUID, dstName = Skada:FixMyPets(dstGUID, dstName)
	if srcName then
		log_deathlog(Skada.current, dstGUID, dstName, spellid, srcName..L["'s "]..spellname, 0-samount, timestamp)
	else
		log_deathlog(Skada.current, dstGUID, dstName, spellid, spellname, 0-samount, timestamp)
	end
end

local function SpellHeal(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	-- Healing
	local spellId, spellName, spellSchool, samount, soverhealing, absorbed, scritical = ...
	smount = min(0, samount - soverhealing)
	
	srcGUID, srcName = Skada:FixMyPets(srcGUID, srcName)
	dstGUID, dstName = Skada:FixMyPets(dstGUID, dstName)
	log_deathlog(Skada.current, dstGUID, dstName, spellId, srcName..L["'s "]..spellName, samount, timestamp)
end

local function Resurrect(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	-- Clear deathlog for this player.
	log_resurrect(Skada.current, dstGUID, dstName)
end

-- Death meter.
function mod:Update(win, set)
	local nr = 1
	local max = 0
	
	for i, player in ipairs(set.players) do
		if player.deaths > 0 then
		
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			
			d.id = player.id
			d.value = player.deathts
			if player.deaths > 1 then
				d.label = player.name.." ("..player.deaths..")"
			else
				d.label = player.name
			end
			d.class = player.class
			d.valuetext = date("%H:%M:%S", player.deathts)
			if player.deathts > max then
				max = player.deathts
			end
			
			nr = nr + 1
		end
	end
	
	win.metadata.maxvalue = max
end

function deathlog:Enter(win, id, label)
	deathlog.playerid = id
	deathlog.title = label..L["'s Death"]
end

local green = {r = 0, g = 255, b = 0, a = 1}
local red = {r = 255, g = 0, b = 0, a = 1}

-- Death log.
function deathlog:Update(win, set)
	local player = Skada:get_player(set, self.playerid)
	
	if player and player.deathlog then
		local nr = 1
		
		-- Sort logs.
		table.sort(player.deathlog, function(a,b) return a and b and a.ts > b.ts end)
		
		-- Add a fake entry for the actual death.
		local d = win.dataset[nr] or {}
		win.dataset[nr] = d
		d.id = nr
		d.label = date("%H:%M:%S", player.deathts).. ": "..string.format(L["%s dies"], player.name)
		d.ts = player.deathts
		d.value = 0
		d.valuetext = ""
		d.icon = select(3, GetSpellInfo(5384)) -- Feign Death icon.
		
		nr = nr + 1
		
		for i, log in ipairs(player.deathlog) do
			local diff = tonumber(log.ts) - tonumber(player.deathts)
			-- Ignore hits older than 30s before death.
			if diff > -30 then
			
				local d = win.dataset[nr] or {}
				win.dataset[nr] = d
				
				d.id = nr
				d.label = ("%2.2f"):format(diff) .. ": "..log.spellname
				d.ts = log.ts
				d.value = log.hp or 0
				d.icon = select(3, GetSpellInfo(log.spellid))
				
				local change = Skada:FormatNumber(math.abs(log.amount))
				if log.amount > 0 then
					change = "+"..change
				else
					change = "-"..change
				end
				
				d.valuetext = Skada:FormatValueText(
												change, self.metadata.columns.Change,
												Skada:FormatNumber(log.hp or 0), self.metadata.columns.Health,
												string.format("%02.1f%%", (log.hp or 1) / (player.maxhp or 1) * 100), self.metadata.columns.Percent
											)
											
				if log.amount > 0 then
					d.color = green
				else
					d.color = red
				end
				
				nr = nr + 1
			end
		end
		
		win.metadata.maxvalue = player.maxhp
	end
end

function mod:OnEnable()
	mod.metadata 		= {click1 = deathlog}
	deathlog.metadata 	= {ordersort = true, columns = {Change = true, Health = false, Percent = true}}

	Skada:RegisterForCL(UnitDied, 'UNIT_DIED', {dst_is_interesting_nopets = true})
	
	Skada:RegisterForCL(SpellDamage, 'SPELL_DAMAGE', {dst_is_interesting_nopets = true})
	Skada:RegisterForCL(SpellDamage, 'SPELL_PERIODIC_DAMAGE', {dst_is_interesting_nopets = true})
	Skada:RegisterForCL(SpellDamage, 'SPELL_BUILDING_DAMAGE', {dst_is_interesting_nopets = true})
	Skada:RegisterForCL(SpellDamage, 'RANGE_DAMAGE', {dst_is_interesting_nopets = true})
	
	Skada:RegisterForCL(SwingDamage, 'SWING_DAMAGE', {dst_is_interesting_nopets = true})

	Skada:RegisterForCL(SpellHeal, 'SPELL_HEAL', {dst_is_interesting_nopets = true})
	Skada:RegisterForCL(SpellHeal, 'SPELL_PERIODIC_HEAL', {dst_is_interesting_nopets = true})

	Skada:RegisterForCL(Resurrect, 'SPELL_RESURRECT', {dst_is_interesting_nopets = true})

	Skada:AddMode(self)
end

function mod:OnDisable()
	Skada:RemoveMode(self)
end

-- Called by Skada when a set is complete.
function mod:SetComplete(set)
	-- Clean; remove logs from all who did not die.
	for i, player in ipairs(set.players) do
		if player.deaths == 0 then
			wipe(player.deathlog)
			player.deathlog = nil
		end
	end
end

function mod:AddToTooltip(set, tooltip)
 	GameTooltip:AddDoubleLine(L["Deaths"], set.deaths, 1,1,1)
end

function mod:GetSetSummary(set)
	return set.deaths
end

-- Called by Skada when a new player is added to a set.
function mod:AddPlayerAttributes(player)
	if not player.deaths then
		player.deaths = 0
		player.maxhp = 0
		player.deathts = 0
		player.deathlog = {}
	end
end

-- Called by Skada when a new set is created.
function mod:AddSetAttributes(set)
	if not set.deaths then
		set.deaths = 0
	end
end