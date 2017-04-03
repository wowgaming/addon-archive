-- Based on RecountGuessedAbsorbs by Elsia

local L = LibStub("AceLocale-3.0"):GetLocale("Skada", false)

local Skada = Skada
local mod = Skada:NewModule(L["Absorbs"])
local playermod = Skada:NewModule(L["Absorb details"])
local combined = Skada:NewModule(L["Absorbs and healing"])

-- This bit shamelessly copied straight from RecountGuessedAbsorbs - thanks!
local AbsorbSpellDuration = 
{
	-- Death Knight
	[48707] = 5, -- Anti-Magic Shell (DK) Rank 1 -- Does not currently seem to show tracable combat log events. It shows energizes which do not reveal the amount of damage absorbed
	[51052] = 10, -- Anti-Magic Zone (DK)( Rank 1 (Correct spellID?)
		-- Does DK Spell Deflection show absorbs in the CL?
	[51271] = 20, -- Unbreakable Armor (DK)
	[77535] = 10, -- Blood Shield (DK)
	-- Druid
	[62606] = 10, -- Savage Defense proc. (Druid) Tooltip of the original spell doesn't clearly state that this is an absorb, but the buff does.
	-- Mage
	[11426] = 60, -- Ice Barrier (Mage) Rank 1
	[13031] = 60,
	[13032] = 60,
	[13033] = 60,
	[27134] = 60,
	[33405] = 60,
	[43038] = 60,
	[43039] = 60, -- Rank 8
	[6143] = 30, -- Frost Ward (Mage) Rank 1
	[8461] = 30, 
	[8462] = 30,  
	[10177] = 30,  
	[28609] = 30,
	[32796] = 30,
	[43012] = 30, -- Rank 7
	[1463] = 60, --  Mana shield (Mage) Rank 1
	[8494] = 60,
	[8495] = 60,
	[10191] = 60,
	[10192] = 60,
	[10193] = 60,
	[27131] = 60,
	[43019] = 60,
	[43020] = 60, -- Rank 9
	[543] = 30 , -- Fire Ward (Mage) Rank 1
	[8457] = 30,
	[8458] = 30,
	[10223] = 30,
	[10225] = 30,
	[27128] = 30,
	[43010] = 30, -- Rank 7
	-- Paladin
	[58597] = 6, -- Sacred Shield (Paladin) proc (Fixed, thanks to Julith)
	-- Priest
	[17] = 30, -- Power Word: Shield (Priest) Rank 1
	[592] = 30,
	[600] = 30,
	[3747] = 30,
	[6065] = 30,
	[6066] = 30,
	[10898] = 30,
	[10899] = 30,
	[10900] = 30,
	[10901] = 30,
	[25217] = 30,
	[25218] = 30,
	[48065] = 30,
	[48066] = 30, -- Rank 14
	[47509] = 12, -- Divine Aegis (Priest) Rank 1
	[47511] = 12,
	[47515] = 12, -- Divine Aegis (Priest) Rank 3 (Some of these are not actual buff spellIDs)
	[47753] = 12, -- Divine Aegis (Priest) Rank 1
	[54704] = 12, -- Divine Aegis (Priest) Rank 1
	[47788] = 10, -- Guardian Spirit  (Priest) (50 nominal absorb, this may not show in the CL)
	-- Warlock
	[7812] = 30, -- Sacrifice (warlock) Rank 1
	[19438] = 30,
	[19440] = 30,
	[19441] = 30,
	[19442] = 30,
	[19443] = 30,
	[27273] = 30,
	[47985] = 30,
	[47986] = 30, -- rank 9
	[6229] = 30, -- Shadow Ward (warlock) Rank 1
	[11739] = 30,
	[11740] = 30,
	[28610] = 30,
	[47890] = 30,
	[47891] = 30, -- Rank 6
	-- Consumables
	[29674] = 86400, -- Lesser Ward of Shielding
	[29719] = 86400, -- Greater Ward of Shielding (these have infinite duration, set for a day here :P)
	[29701] = 86400,
	[28538] = 120, -- Major Holy Protection Potion
	[28537] = 120, -- Major Shadow
	[28536] = 120, --  Major Arcane
	[28513] = 120, -- Major Nature
	[28512] = 120, -- Major Frost
	[28511] = 120, -- Major Fire
	[7233] = 120, -- Fire
	[7239] = 120, -- Frost
	[7242] = 120, -- Shadow Protection Potion
	[7245] = 120, -- Holy
	[6052] = 120, -- Nature Protection Potion
	[53915] = 120, -- Mighty Shadow Protection Potion
	[53914] = 120, -- Mighty Nature Protection Potion
	[53913] = 120, -- Mighty Frost Protection Potion
	[53911] = 120, -- Mighty Fire
	[53910] = 120, -- Mighty Arcane
	[17548] = 120, --  Greater Shadow
	[17546] = 120, -- Greater Nature
	[17545] = 120, -- Greater Holy
	[17544] = 120, -- Greater Frost
	[17543] = 120, -- Greater Fire
	[17549] = 120, -- Greater Arcane
	[28527] = 15, -- Fel Blossom
	[29432] = 3600, -- Frozen Rune usage (Naxx classic)
	-- Item usage
	[36481] = 4, -- Arcane Barrier (TK Kael'Thas) Shield
	[57350] = 6, -- Darkmoon Card: Illusion
	[17252] = 30, -- Mark of the Dragon Lord (LBRS epic ring) usage
	[25750] = 15, -- Defiler's Talisman/Talisman of Arathor Rank 1
	[25747] = 15,
	[25746] = 15,
	[23991] = 15,
	[31000] = 300, -- Pendant of Shadow's End Usage
	[30997] = 300, -- Pendant of Frozen Flame Usage
	[31002] = 300, -- Pendant of the Null Rune
	[30999] = 300, -- Pendant of Withering
	[30994] = 300, -- Pendant of Thawing
	[31000] = 300, -- 
	[23506]= 20, -- Arena Grand Master Usage (Aura of Protection)
	[12561] = 60, -- Goblin Construction Helmet usage
	[31771] = 20, -- Runed Fungalcap usage
	[21956] = 10, -- Mark of Resolution usage
	[29506] = 20, -- The Burrower's Shell
	[4057] = 60, -- Flame Deflector
	[4077] = 60, -- Ice Deflector
	[39228] = 20, -- Argussian Compass (may not be an actual absorb)
	-- Item procs
	[27779] = 30, -- Divine Protection - Priest dungeon set 1/2  Proc
	[11657] = 20, -- Jang'thraze (Zul Farrak) proc
	[10368] = 15, -- Uther's Strength proc
	[37515] = 15, -- Warbringer Armor Proc
	[42137] = 86400, -- Greater Rune of Warding Proc
	[26467] = 30, -- Scarab Brooch proc
	[26470] = 8, -- Scarab Brooch proc (actual)
	[27539] = 6, -- Thick Obsidian Breatplate proc
	[28810] = 30, -- Faith Set Proc Armor of Faith
	[54808] = 12, -- Noise Machine proc Sonic Shield 
	[55019] = 12, -- Sonic Shield (one of these too ought to be wrong)
	[64411] = 15, -- Blessing of the Ancient (Val'anyr Hammer of Ancient Kings equip effect)
	[64413] = 8, -- Val'anyr, Hammer of Ancient Kings proc Protection of Ancient Kings
	-- Misc
	[40322] = 30, -- Teron's Vengeful Spirit Ghost - Spirit Shield
	-- Boss abilities
	[65874] = 15, -- Twin Val'kyr's Shield of Darkness 175000
	[67257] = 15, -- 300000
	[67256] = 15, -- 700000
	[67258] = 15, -- 1200000
	[65858] = 15, -- Twin Val'kyr's Shield of Lights 175000
	[67260] = 15, -- 300000
	[67259] = 15, -- 700000
	[67261] = 15, -- 1200000
}

local shields = {}

local function AuraApplied(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	local spellId, spellName, spellSchool, auraType = ...
	if AbsorbSpellDuration[spellId] then
	
		shields[dstName] = shields[dstName] or {}
		shields[dstName][spellId] = shields[dstName][spellId] or {}
		shields[dstName][spellId][srcName] = timestamp + AbsorbSpellDuration[spellId]
		
	end
end

local function AuraRemoved(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	local spellId, spellName, spellSchool, auraType = ...
	if AbsorbSpellDuration[spellId] then
	
		if shields[dstName] and shields[dstName][spellId] and shields[dstName][spellId][dstName] then
			-- As advised in RecountGuessedAbsorbs, do not remove shields straight away as an absorb can come after the aura removed event.
			shields[dstName][spellId][dstName] = timestamp + 0.1
		end
	
	end
end

local function log_absorb(set, srcName, dstName, absorbed)
	-- Get the player.
	local player = Skada:get_player(set, UnitGUID(srcName), UnitName(srcName))
	if player then
		player.totalabsorbs = player.totalabsorbs + absorbed
		player.absorbs[dstName] = (player.absorbs[dstName] or 0) + absorbed
		set.absorbs = set.absorbs + absorbed
	end
end

local function consider_absorb(absorbed, dstName, srcName, timestamp)
	local mintime = nil
	local found_shield_src
	for shield_id, spells in pairs(shields[dstName]) do
		for shield_src, ts in pairs(spells) do
			if ts - timestamp > 0 and (mintime == nil or ts - timestamp < mintime) then
				found_shield_src = shield_src
			end
		end
	end
	
	if found_shield_src then

		log_absorb(Skada.current, found_shield_src, dstName, absorbed)
		log_absorb(Skada.total, found_shield_src, dstName, absorbed)
		
	end
end

local function SwingDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	local samount, soverkill, sschool, sresisted, sblocked, absorbed, scritical, sglancing, scrushing = ...
	if absorbed and absorbed > 0 and dstName and shields[dstName] and srcName then
		--Skada:Print(dstName.." absorbed "..absorbed.." from "..srcName)
		consider_absorb(absorbed, dstName, srcName, timestamp)
	end
end

local function SpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	local spellId, spellName, spellSchool, samount, soverkill, sschool, sresisted, sblocked, absorbed, scritical, sglancing, scrushing = ...
	if absorbed and absorbed > 0 and dstName and shields[dstName] and srcName then
		--Skada:Print(dstName.." absorbed "..absorbed.." from "..srcName)
		consider_absorb(absorbed, dstName, srcName, timestamp)
	end
end

local function SpellMissed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	local spellId, spellName, spellSchool, misstype, amount = ...
	if misstype == "ABSORB" and amount > 0 and dstName and shields[dstName] and srcName then
		--Skada:Print(dstName.." absorbed "..absorbed.." from "..srcName.." (MISS)")
		consider_absorb(amount, dstName, srcName, timestamp)
	end
end

local function SwingMissed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	SpellMissed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, nil, nil, nil, ...)
end

function mod:Update(win, set)
	local nr = 1
	local max = 0

	for i, player in ipairs(set.players) do
		if player.totalabsorbs > 0 then
		
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			
			d.id = player.id
			d.value = player.totalabsorbs
			d.label = player.name
			d.valuetext = Skada:FormatNumber(player.totalabsorbs)..(" (%02.1f%%)"):format(player.totalabsorbs / set.absorbs * 100)
			d.class = player.class

			if player.totalabsorbs > max then
				max = player.totalabsorbs
			end
			
			nr = nr + 1
		end
	end
	
	win.metadata.maxvalue = max
end

function playermod:Enter(win, id, label)
	playermod.playerid = id
	playermod.title = label..L["'s Absorbs"]
end

function playermod:Update(win, set)
	local player = Skada:find_player(set, self.playerid)
	
	local nr = 1
	local max = 0
	
	if player then
	
		for dstName, absorbed in pairs(player.absorbs) do
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			
			d.id = dstName
			d.value = absorbed
			d.label = dstName
			d.valuetext = Skada:FormatNumber(absorbed)..(" (%02.1f%%)"):format(absorbed / player.totalabsorbs * 100)
			d.class = select(2, UnitClass(dstName))

			if absorbed > max then
				max = absorbed
			end
			
			nr = nr + 1
		end
		
		win.metadata.maxvalue = max
		
	end
end

function combined:Update(win, set)
	local nr = 1
	local max = 0

	for i, player in ipairs(set.players) do
		if player.totalabsorbs > 0 or player.healing > 0 then
		
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			
			d.id = player.id
			d.value = player.totalabsorbs + (player.healing or 0)
			d.label = player.name
			d.valuetext = Skada:FormatNumber(player.totalabsorbs + (player.healing or 0))..(" (%02.1f%%)"):format((player.totalabsorbs + (player.healing or 0)) / (set.absorbs + (set.healing or 0)) * 100)
			d.class = player.class

			if (player.totalabsorbs + player.healing) > max then
				max = player.totalabsorbs + player.healing
			end
			
			nr = nr + 1
		end
	end
	
	win.metadata.maxvalue = max
end

function mod:OnEnable()
	combined.metadata 	= {showspots = 1, click1 = playermod}
	mod.metadata 		= {showspots = 1, click1 = playermod}
	playermod.metadata 	= {}

	Skada:RegisterForCL(AuraApplied, 'SPELL_AURA_REFRESH', {src_is_interesting_nopets = true})
	Skada:RegisterForCL(AuraApplied, 'SPELL_AURA_APPLIED', {src_is_interesting_nopets = true})
	Skada:RegisterForCL(AuraRemoved, 'SPELL_AURA_REMOVED', {src_is_interesting_nopets = true})
	Skada:RegisterForCL(SpellDamage, 'DAMAGE_SHIELD', {dst_is_interesting_nopets = true})
	Skada:RegisterForCL(SpellDamage, 'SPELL_DAMAGE', {dst_is_interesting_nopets = true})
	Skada:RegisterForCL(SpellDamage, 'SPELL_PERIODIC_DAMAGE', {dst_is_interesting_nopets = true})
	Skada:RegisterForCL(SpellDamage, 'SPELL_BUILDING_DAMAGE', {dst_is_interesting_nopets = true})
	Skada:RegisterForCL(SpellDamage, 'RANGE_DAMAGE', {dst_is_interesting_nopets = true})
	Skada:RegisterForCL(SwingDamage, 'SWING_DAMAGE', {dst_is_interesting_nopets = true})
	Skada:RegisterForCL(SpellMissed, 'SPELL_MISSED', {dst_is_interesting_nopets = true})
	Skada:RegisterForCL(SpellMissed, 'SPELL_PERIODIC_MISSED', {dst_is_interesting_nopets = true})
	Skada:RegisterForCL(SpellMissed, 'SPELL_BUILDING_MISSED', {dst_is_interesting_nopets = true})
	Skada:RegisterForCL(SpellMissed, 'RANGE_MISSED', {dst_is_interesting_nopets = true})
	Skada:RegisterForCL(SwingMissed, 'SWING_MISSED', {dst_is_interesting_nopets = true})
	
	Skada:AddMode(self)
	Skada:AddMode(combined)
end

function mod:OnDisable()
	Skada:RemoveMode(self)
	Skada:RemoveMode(combined)
end

function mod:AddToTooltip(set, tooltip)
end

function mod:GetSetSummary(set)
	return Skada:FormatNumber(set.absorbs)
end

function combined:GetSetSummary(set)
	return Skada:FormatNumber(set.absorbs + set.healing)
end

-- Called by Skada when a new player is added to a set.
function mod:AddPlayerAttributes(player)
	if not player.absorbs then
		player.absorbs = {}
		player.totalabsorbs = 0
	end
end

-- Called by Skada when a new set is created.
-- Conveniently this is when a new fight starts, so we can clear our shield cache.
function mod:AddSetAttributes(set)
	if not set.absorbs then
		set.absorbs = 0
	end
	shields = {}
end
