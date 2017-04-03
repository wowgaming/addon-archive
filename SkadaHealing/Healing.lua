local L = LibStub("AceLocale-3.0"):GetLocale("Skada", false)

local Skada = Skada

local mod = Skada:NewModule(L["Healing"])
local spellsmod = Skada:NewModule(L["Healing spell list"])
local healedmod = Skada:NewModule(L["Healed players"])

local function log_heal(set, heal)
	-- Get the player from set.
	local player = Skada:get_player(set, heal.playerid, heal.playername)
	if player then
		-- Subtract overhealing
		local amount = math.max(0, heal.amount - heal.overhealing)

		-- Add to player total.
		player.healing = player.healing + amount
		player.overhealing = player.overhealing + heal.overhealing
		
		-- Also add to set total damage.
		set.healing = set.healing + amount
		set.overhealing = set.overhealing + heal.overhealing
		
		-- Create recipient if it does not exist.
		if not player.healed[heal.dstName] then
			player.healed[heal.dstName] = {class = select(2, UnitClass(heal.dstName)), amount = 0}
		end
		
		-- Add to recipient healing.
		player.healed[heal.dstName].amount = player.healed[heal.dstName].amount + amount
		
		-- Create spell if it does not exist.
		if not player.healingspells[heal.spellname] then
			player.healingspells[heal.spellname] = {id = heal.spellid, name = heal.spellname, hits = 0, healing = 0, overhealing = 0, critical = 0, min = 0, max = 0}
		end
		
		-- Get the spell from player.
		local spell = player.healingspells[heal.spellname]
		
		spell.healing = spell.healing + amount
		if heal.critical then
			spell.critical = spell.critical + 1
		end
		spell.overhealing = spell.overhealing + heal.overhealing
		
		spell.hits = (spell.hits or 0) + 1
		
		if not spell.min or amount < spell.min then
			spell.min = amount
		end
		if not spell.max or amount > spell.max then
			spell.max = amount
		end
	end
end

local heal = {}

local function SpellHeal(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	-- Healing
	local spellId, spellName, spellSchool, samount, soverhealing, absorbed, scritical = ...
	
	heal.dstName = dstName
	heal.playerid = srcGUID
	heal.playername = srcName
	heal.spellid = spellId
	heal.spellname = spellName
	heal.amount = samount
	heal.overhealing = soverhealing
	heal.critical = scritical
	
	Skada:FixPets(heal)
	log_heal(Skada.current, heal)
	log_heal(Skada.total, heal)
end

local function getHPS(set, player)
	local totaltime = Skada:PlayerActiveTime(set, player)
	
	return player.healing / math.max(1,totaltime)
end

function mod:Update(win, set)
	local nr = 1
	local max = 0

	for i, player in ipairs(set.players) do
		if player.healing > 0 then
			
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			
			d.id = player.id
			d.label = player.name
			d.value = player.healing
			
			d.valuetext = Skada:FormatValueText(
											Skada:FormatNumber(player.healing), self.metadata.columns.Healing,
											string.format("%02.1f", getHPS(set, player)), self.metadata.columns.HPS,
											string.format("%02.1f%%", player.healing / set.healing * 100), self.metadata.columns.Percent
										)
			d.class = player.class
			
			if player.healing > max then
				max = player.healing
			end
			
			nr = nr + 1
		end
	end
	
	win.metadata.maxvalue = max
end

local function spell_tooltip(win, id, label, tooltip)
	local player = Skada:find_player(win:get_selected_set(), spellsmod.playerid)
	if player then
		local spell = player. healingspells[label]
		if spell then
			tooltip:AddLine(player.name.." - "..label)
			if spell.max and spell.min then
				tooltip:AddDoubleLine(L["Minimum hit:"], Skada:FormatNumber(spell.min), 255,255,255,255,255,255)
				tooltip:AddDoubleLine(L["Maximum hit:"], Skada:FormatNumber(spell.max), 255,255,255,255,255,255)
			end
			tooltip:AddDoubleLine(L["Average hit:"], Skada:FormatNumber(spell.healing / spell.hits), 255,255,255,255,255,255)
			if spell.hits then
				tooltip:AddDoubleLine(L["Critical"]..":", ("%02.1f%%"):format(spell.critical / spell.hits * 100), 255,255,255,255,255,255)
			end
			if spell.hits then
				tooltip:AddDoubleLine(L["Overhealing"]..":", ("%02.1f%%"):format(spell.overhealing / (spell.overhealing + spell.healing) * 100), 255,255,255,255,255,255)
			end
		end
	end
end

function spellsmod:Enter(win, id, label)
	spellsmod.playerid = id
	spellsmod.title = label..L["'s Healing"]
end

-- Spell view of a player.
function spellsmod:Update(win, set)
	-- View spells for this player.
		
	local player = Skada:find_player(set, self.playerid)
	local nr = 1
	local max = 0
	
	if player then
		
		for spellname, spell in pairs(player.healingspells) do
		
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			
			d.id = spell.id
			d.label = spell.name
			d.value = spell.healing
			d.valuetext = Skada:FormatValueText(
											Skada:FormatNumber(spell.healing), self.metadata.columns.Healing,
											string.format("%02.1f%%", spell.healing / player.healing * 100), self.metadata.columns.Percent
										)
			d.icon = select(3, GetSpellInfo(spell.id))
			
			if spell.healing > max then
				max = spell.healing
			end
			
			nr = nr + 1
		end
	end
	
	win.metadata.maxvalue = max
end

function healedmod:Enter(win, id, label)
	healedmod.playerid = id
	healedmod.title = L["Healed by"].." "..label
end

-- Healed players view of a player.
function healedmod:Update(win, set)
	local player = Skada:find_player(set, healedmod.playerid)
	local nr = 1
	local max = 0
	
	if player then
		for name, heal in pairs(player.healed) do
			if heal.amount > 0 then
		
				local d = win.dataset[nr] or {}
				win.dataset[nr] = d
				
				d.id = name
				d.label = name
				d.value = heal.amount
				d.class = heal.class
				d.valuetext = Skada:FormatValueText(
												Skada:FormatNumber(heal.amount), self.metadata.columns.Healing,
												string.format("%02.1f%%", heal.amount / player.healing * 100), self.metadata.columns.Percent
											)
				if heal.amount > max then
					max = heal.amount
				end
				
				nr = nr + 1
			end
		end
	end
	
	win.metadata.maxvalue = max
end

function mod:OnEnable()
	mod.metadata		= {showspots = true, click1 = spellsmod, click2 = healedmod, columns = {Healing = true, HPS = true, Percent = true}}
	spellsmod.metadata	= {tooltip = spell_tooltip, columns = {Healing = true, Percent = true}}
	healedmod.metadata 	= {showspots = true, columns = {Healing = true, Percent = true}}
	
	Skada:RegisterForCL(SpellHeal, 'SPELL_HEAL', {src_is_interesting = true})
	Skada:RegisterForCL(SpellHeal, 'SPELL_PERIODIC_HEAL', {src_is_interesting = true})

	Skada:AddMode(self)
end

function mod:OnDisable()
	Skada:RemoveMode(self)
end

function mod:AddToTooltip(set, tooltip)
	local endtime = set.endtime
	if not endtime then
		endtime = time()
	end
	local raidhps = set.healing / (endtime - set.starttime + 1)
 	GameTooltip:AddDoubleLine(L["HPS"], ("%02.1f"):format(raidhps), 1,1,1)
end

function mod:GetSetSummary(set)
	return Skada:FormatNumber(set.healing)
end

-- Called by Skada when a new player is added to a set.
function mod:AddPlayerAttributes(player)
	if not player.healed then
		player.healed = {}			-- Stored healing per recipient
	end
	if not player.healing then
		player.healing = 0			-- Total healing
		player.healingspells = {}	-- Healing spells
		player.overhealing = 0		-- Overheal total
	end
end

-- Called by Skada when a new set is created.
function mod:AddSetAttributes(set)
	if not set.healing then
		set.healing = 0
		set.overhealing = 0
	end
end
