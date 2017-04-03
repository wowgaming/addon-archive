local L = LibStub("AceLocale-3.0"):GetLocale("Skada", false)

local Skada = Skada

local mod = Skada:NewModule(L["Damage taken"])
local playermod = Skada:NewModule(L["List of damaging spells"])
local spelloverview = Skada:NewModule(L["Damage taken by spell"])
local spellplayers = Skada:NewModule(L["List of damaged players"])

local function log_damage_taken(set, dmg)
	-- Get the player.
	local player = Skada:get_player(set, dmg.playerid, dmg.playername)
	if player then
		-- Also add to set total damage taken.
		set.damagetaken = set.damagetaken + dmg.amount
		
		-- Add spell to player if it does not exist.
		if not player.damagetakenspells[dmg.spellname] then
			player.damagetakenspells[dmg.spellname] = {id = dmg.spellid, name = dmg.spellname, damage = 0}
		end
		
		-- Add to player total damage.
		player.damagetaken = player.damagetaken + dmg.amount
		
		-- Get the spell from player.
		local spell = player.damagetakenspells[dmg.spellname]
		spell.id = dmg.spellid
		spell.damage = spell.damage + dmg.amount
	end
end

local dmg = {}

local function SpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	local spellId, spellName, spellSchool, samount, soverkill, sschool, sresisted, sblocked, sabsorbed, scritical, sglancing, scrushing = ...
	
	dmg.playerid = dstGUID
	dmg.playername = dstName
	dmg.spellid = spellId
	dmg.spellname = spellName
	dmg.amount = samount
	
	log_damage_taken(Skada.current, dmg)
	log_damage_taken(Skada.total, dmg)
end

local function SwingDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	-- White melee.
	local samount, soverkill, sschool, sresisted, sblocked, sabsorbed, scritical, sglancing, scrushing = ...
	
	dmg.playerid = dstGUID
	dmg.playername = dstName
	dmg.spellid = 6603
	dmg.spellname = L["Attack"]
	dmg.amount = samount

	log_damage_taken(Skada.current, dmg)
	log_damage_taken(Skada.total, dmg)
end

function spelloverview:Update(win,set)
	local max = 0
	
	-- Aggregate the data.
	local tmp = {}
	for i, player in ipairs(set.players) do
		if player.damagetaken > 0 then
			for name, spell in pairs(player.damagetakenspells) do
				if not tmp[name] then
					tmp[name] = {id = spell.id, damage = spell.damage}
				else
					tmp[name].damage = tmp[name].damage + spell.damage
				end
			end
		end
	end
	
	local nr = 1
	for name, spell in pairs(tmp) do
		local d = win.dataset[nr] or {}
		win.dataset[nr] = d

		d.label = name
		d.value = spell.damage
		d.valuetext = Skada:FormatNumber(spell.damage)..(" (%02.1f%%)"):format(spell.damage / set.damagetaken * 100)
		d.id = name
		d.icon = select(3, GetSpellInfo(spell.id))
		
		if spell.damage > max then
			max = spell.damage
		end
		nr = nr + 1
	end
	win.metadata.maxvalue = max	
end

function spellplayers:Enter(win, id, label)
	spellplayers.spellname = id
	spellplayers.title = label.." "..L["targets"]
end

function spellplayers:Update(win, set)
	local max = 0
	
	local nr = 1
	for i, player in ipairs(set.players) do
		if player.damagetaken > 0 and player.damagetakenspells[self.spellname] then
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d

			d.label = player.name
			d.value = player.damagetakenspells[self.spellname].damage
			d.valuetext = Skada:FormatNumber(player.damagetakenspells[self.spellname].damage)
			d.id = player.id
			d.class = player.class
			
			if player.damagetakenspells[self.spellname].damage > max then
				max = player.damagetakenspells[self.spellname].damage
			end
			nr = nr + 1
		end
	end
	
	win.metadata.maxvalue = max
end


function mod:Update(win, set)
	local max = 0
	
	local nr = 1
	for i, player in ipairs(set.players) do
		if player.damagetaken > 0 then
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d

			d.label = player.name
			d.value = player.damagetaken
			d.valuetext = Skada:FormatNumber(player.damagetaken)..(" (%02.1f%%)"):format(player.damagetaken / set.damagetaken * 100)
			d.id = player.id
			d.class = player.class
			
			if player.damagetaken > max then
				max = player.damagetaken
			end
			nr = nr + 1
		end
	end
	
	win.metadata.maxvalue = max
end

function playermod:Enter(win, id, label)
	playermod.playerid = id
	playermod.title = label..L["'s Damage taken"]
end

-- Detail view of a player.
function playermod:Update(win, set)
	-- View spells for this player.
		
	local player = Skada:find_player(set, self.playerid)
	
	local nr = 1
	if player then
		for spellname, spell in pairs(player.damagetakenspells) do
				
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			
			d.label = spellname
			d.value = spell.damage
			d.icon = select(3, GetSpellInfo(spell.id))
			d.id = spellname
			d.valuetext = Skada:FormatNumber(spell.damage)..(" (%02.1f%%)"):format(spell.damage / player.damagetaken * 100)
			
			nr = nr + 1
		end
		
		-- Sort the possibly changed bars.
		win.metadata.maxvalue = player.damagetaken
	end
end

function mod:OnEnable()
	playermod.metadata 		= {}
	mod.metadata 			= {click1 = playermod, showspots = true}
	spelloverview.metadata	= {click1 = spellplayers, showspots = true}

	Skada:RegisterForCL(SpellDamage, 'SPELL_DAMAGE', {dst_is_interesting_nopets = true})
	Skada:RegisterForCL(SpellDamage, 'SPELL_PERIODIC_DAMAGE', {dst_is_interesting_nopets = true})
	Skada:RegisterForCL(SpellDamage, 'SPELL_BUILDING_DAMAGE', {dst_is_interesting_nopets = true})
	Skada:RegisterForCL(SpellDamage, 'RANGE_DAMAGE', {dst_is_interesting_nopets = true})
	
	Skada:RegisterForCL(SwingDamage, 'SWING_DAMAGE', {dst_is_interesting_nopets = true})

	Skada:AddMode(self)
	Skada:AddMode(spelloverview)
end

function mod:OnDisable()
	Skada:RemoveMode(self)
end

-- Called by Skada when a new player is added to a set.
function mod:AddPlayerAttributes(player)
	if not player.damagetaken then
		player.damagetaken = 0
		player.damagetakenspells = {}
	end
end

-- Called by Skada when a new set is created.
function mod:AddSetAttributes(set)
	if not set.damagetaken then
		set.damagetaken = 0
	end
end

function mod:GetSetSummary(set)
	return Skada:FormatNumber(set.damagetaken)
end