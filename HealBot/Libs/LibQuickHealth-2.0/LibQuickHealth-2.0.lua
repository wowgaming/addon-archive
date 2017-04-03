--[[
Features:
LibQuickHealth-2.0 is a library that provides more up to date health data than the default Blizz events and functions.
In addition to the standard UNIT_HEALTH event, the library listens to combat log events (CLEU) to update health values. 
CLEU events fire more often than UNIT_HEALTH, and allow the library to get around the ~300ms throttling of UNIT_HEALTH updates.
The interesting CLEU events are those containing health differences (damage and heals). Normally, when UNIT_HEALTH fires,
those differences add up to the value reported by Blizz's UnitHealth. But sometimes, when a unit takes damage according to the CLEU,
that damage is processed *after* the next UNIT_HEALTH event.
This is called "pending damage". One of the features of LibQuickHealth-2.0 (and an improvement over 1.0) is to detect pending damage,
and incorporate it into the health values that are presented to players.

Limitations:
1.) Sometimes there are combat log entries like this: -6000 (damage), +5000 (heal).
But what really happened on the server was that the heal occured first.
If at least part of this heal was overheal, the prediction (-6000+5000 = -1000) is way off,
because what happened is for example +50 heal first(4950 overheal), and then 6000 damage,
for a total of +50-6000 = -5950. No AddOn could possibly prevent or predict this, but luckily these cases are very rare. 
However, if you see something like this happening (tank at ~100%, then takes damage instantly followed by a heal),
you should know that this heal might have been overheal. So don't cancel your heal. ;)

2.) If the maximum health changes, pending damage is completely ignored. Example: The tank is at 11001/18000,
takes 9001 damage and uses Last Stand at the same time.
Your client might tell you now that the tank health is 16401/23400 (+30% health and max health),
because that 9k hit was not yet processed (pending damage).
What the library does is: Show the tank at 11001/18000, then at 11001-9001 = 2000/18000, then at 16401/23400,
because pending damage is ignored. But on the server, the tank has only 16401-9001 = 7400/23400 health!
This looks very similar to the case before: The tank takes damage, but shortly afterwards that damage is (magically) undone.
Again, if you see this, don't cancel your heal!

3.) Bloodrush. There's no combat log entry for the health lost.
I believe the health cost depends on the caster level and race, but I don't know the exact formula.

4.) Exceptionally large HP5 values. There are no combat log entries for HP5 ticks, which occur every 2 seconds.
The library assumes that the health regen in combat is between 0 and 50 HP5, i.e. HP5 ticks between 0 and 20.
Common HP5 values: Demon skin/armor <=18 (24 talented?), Elixir of Major Fortitude 10, Enchant Boots - Vitality 4.
Less common: Dreaming Glory 30 (buff from herbalism), and a few level 60 items. 
So the library might get confused by two things: Small amounts of pending damage (20 or less), and Warlocks with herbalism...

Usage:
The library supports two events, UnitHealthUpdated and HealthUpdated.
The difference is that HealthUpdated fires for
guids, and UnitHealthUpdated fires for unitIDs.
UnitHealthUpdated replaces not only UNIT_HEALTH, but also UNIT_MAXHEALTH.
That means even if only the max health changes (but not the health),
UnitHealthUpdated (and HealthUpdated) will fire. QuickHealth.UnitHealth replaces Blizz's UnitHealth. See example 2 below.

To start listening to the event, do QuickHealth.RegisterCallback(YourAddonTableHere, "HealthUpdated", HandlerMethodHere).
The "HealthUpdated" callback triggers with 5 arguments: self, event, guid, health, healthMax (first two passed by the callbackhandler).
The "UnitHealthUpdated" callback triggers with 5 arguments: self, event, unitID, health, healthMax.
Additionaly, QuickHealth.UnitHealth(unitID) can be called to get what QuickHealth thinks is the current health.

Example 1: Using UnitHealthUpdated.
	local QuickHealth = LibStub("LibQuickHealth-2.0")
	local MyAddon = {}
	function MyAddon:Initialize()
		-- Note: It's QuickHealth.RegisterCallback(), not QuickHealth:RegisterCallback().
		QuickHealth.RegisterCallback(MyAddon, "UnitHealthUpdated", "UnitHealthUpdated")
	end
	function MyAddon:UnitHealthUpdated(event, unitID, health, healthMax)
		assert(event == "UnitHealthUpdated")
		ChatFrame1:AddMessage(format("%s HealthUpdated %i/%i", unitID, health, healthMax))
		assert(health==QuickHealth.UnitHealth(unitID))
	end


Example 2: Making LibQuickHealth an optional dependency.
	local QuickHealth = LibStub and LibStub("LibQuickHealth-2.0", true) -- don't error if not found
	local UnitHealth = QuickHealth and QuickHealth.UnitHealth or UnitHealth
	MyAddon = ...
	function MyAddon:Initialize()
		if QuickHealth then
			-- Add QuickHealth support. Register for the event and add a simple adapter method.
			QuickHealth.RegisterCallback(MyAddon, "UnitHealthUpdated", "UnitHealthUpdated")
			function MyAddon:UnitHealthUpdated(event, unitID)
				self:UpdateStuff(unitID)
			end
		else
			-- Assuming it's an Ace addon.
			MyAddon:RegisterEvent("UNIT_HEALTH", "UpdateStuff")
			MyAddon:RegisterEvent("UNIT_MAXHEALTH", "UpdateStuff")
		end
	end
	function MyAddon:UpdateStuff(unitID)
		local hp, max = UnitHealth(unitID), UnitHealthMax(unitID)
		-- do something with hp and max
	end


Example 3: Using HealthUpdated.
	local QuickHealth = LibStub("LibQuickHealth-2.0")
	local MyAddon = {}
	function MyAddon:Initialize()
		QuickHealth.RegisterCallback(MyAddon, "HealthUpdated", "HealthUpdated")
	end
	function MyAddon:HealthUpdated(event, guid, health, healthMax)
		assert(event == "HealthUpdated")
		ChatFrame1:AddMessage(format("%s HealthUpdated %i/%i", guid, health, healthMax))
	end

--]]

local MAJOR, MINOR = "LibQuickHealth-2.0", 3
local QuickHealth, oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not QuickHealth then
	return
end

local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local tremove = tremove
local tinsert = tinsert

local healthFromGUID = {}
local healthMaxFromGUID = {}
local healthQueueFromGUID = {}

-- Public API functions.
--[[--------------------------------------------------------------------
UnitHealth("unitID")
Notes:
	Returns the health of the unit.
	Uses function notation instead of method notation to make it easy 
	to replace Blizz's UnitHealth.
Arguments: 
	string - UnitID of the unit to get health for.
Example:
	-- AddOns can use the following to optionally support LQH:
	local QuickHealth = LibStub and LibStub("LibQuickHealth-2.0", true)
	local UnitHealth = QuickHealth and QuickHealth.UnitHealth or UnitHealth
----------------------------------------------------------------------]]
function QuickHealth.UnitHealth(unitID)
	local guid = UnitGUID(unitID)
	return guid and healthFromGUID[guid] or UnitHealth(unitID)
end

--[[--------------------------------------------------------------------
:GetHealth("unitID" or "GUID")
Notes:
	Returns the health of the unit.
Arguments: 
	string - UnitID or GUID of the unit to get health for.
Example:
	local QuickHealth = LibStub("LibQuickHealth-2.0")
	local health = QuickHealth:GetHealth("player")
	assert( health == QuickHealth:GetHealth( UnitGUID("player") ) )
----------------------------------------------------------------------]]
function QuickHealth:GetHealth(unitID)
	local guid = unitID
	local health = healthFromGUID[guid]
	if not health then
		guid = UnitGUID(unitID)
		health = guid and healthFromGUID[guid]
	end
	return health or UnitHealth(unitID)
end

-- #NODOC
function QuickHealth:UnitHealthQueue(unitID)
	local guid = unitID
	local queue = healthQueueFromGUID[guid]
	if not queue then
		guid = UnitGUID(unitID)
		queue = guid and healthQueueFromGUID[guid]
	end
	if queue then
		return unpack(queue)
	end
end

---------------------------------------------------------------------------------------------------
-- Implementation.
QuickHealth.events = QuickHealth.events or LibStub("CallbackHandler-1.0"):New(QuickHealth)
local events = QuickHealth.events

QuickHealth.eventHandlers = QuickHealth.eventHandlers or {}
local eventHandlers = QuickHealth.eventHandlers
local eventFrame
local initialized

if QuickHealth.eventFrame then
	eventFrame = QuickHealth.eventFrame
else
	eventFrame = CreateFrame("Frame")
	QuickHealth.eventFrame = eventFrame
	eventFrame:SetScript("OnEvent", function(self, event, ...) eventHandlers[event](...) end)
end

local function clear(array)
	for i=#array,1,-1 do
		array[i]=nil
	end
end

local HealthUpdatedRegistered
local HealthUpdatedDebugRegistered
local UnitHealthUpdatedRegistered

local GetFrameNumber
do
	local counter = 0
	function GetFrameNumber() 
		return counter 
	end
	local function IncrementCounter()
		counter = counter+1 
	end

	-- When an addon starts listening to HealthUpdated we register our events and actually start doing something
	function QuickHealth.events:OnUsed(target, event)
		eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		eventFrame:RegisterEvent("UNIT_MAXHEALTH")
		eventFrame:RegisterEvent("UNIT_HEALTH")
		eventFrame:RegisterEvent("PLAYER_UNGHOST")
		eventFrame:RegisterEvent("PLAYER_ALIVE")

		if event == "HealthUpdated" then
			HealthUpdatedRegistered = true
		elseif event == "HealthUpdatedDebug" then
			-- Debug counter to know what events fired in the same frame.
			counter = 0
			eventFrame:SetScript("OnUpdate", IncrementCounter)
			HealthUpdatedDebugRegistered = true
		elseif event == "UnitHealthUpdated" then
			eventFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
			eventFrame:RegisterEvent("RAID_ROSTER_UPDATE")
			eventFrame:RegisterEvent("UNIT_PET")
			eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
			eventFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
			--eventFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

			UnitHealthUpdatedRegistered = true
		end

		if not initialized then
			eventHandlers.PLAYER_LOGIN()
		end
		if not initialized then
			eventFrame:RegisterEvent("PLAYER_LOGIN")
		end
	end

	-- Unregister the events and empty the healthtable
	function QuickHealth.events:OnUnused(target, event)
		if event == "HealthUpdated" then
			HealthUpdatedRegistered = nil
		elseif event == "HealthUpdatedDebug" then
			counter = nil
			eventFrame:SetScript("OnUpdate", nil)
			HealthUpdatedDebugRegistered = nil
		elseif event == "UnitHealthUpdated" then
			eventFrame:UnregisterEvent("PARTY_MEMBERS_CHANGED")
			eventFrame:UnregisterEvent("RAID_ROSTER_UPDATE")
			eventFrame:UnregisterEvent("UNIT_PET")
			eventFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
			eventFrame:UnregisterEvent("PLAYER_FOCUS_CHANGED")
			--eventFrame:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
			UnitHealthUpdatedRegistered = nil
		end

		if not (HealthUpdatedRegistered or UnitHealthUpdatedRegistered or HealthUpdatedDebugRegistered) then
			eventFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			eventFrame:UnregisterEvent("UNIT_MAXHEALTH")
			eventFrame:UnregisterEvent("UNIT_HEALTH")
			eventFrame:UnregisterEvent("PLAYER_UNGHOST")
			eventFrame:UnregisterEvent("PLAYER_ALIVE")
		end
	end
end

-- Initialization.
function eventHandlers.PLAYER_LOGIN()
	if UnitGUID("player") and tonumber(UnitGUID('player'))>0 then
		eventHandlers.RAID_ROSTER_UPDATE()
		if healthFromGUID[guid] then
			initialized = true
			eventHandlers.PLAYER_LOGIN = nil
		end
	end
end

-- Map that will contain the units of every guid.
local unitIDsFromGUID = {}
local UpdateSpecial = {}
do
	-- Create event handlers for the special unitIDs target and focus.
	-- While mouseover is special too, UPDATE_MOUSEOVER_UNIT is incredibly stupid, and
	-- doesn't fire when UnitExists('mouseover') becomes nil, or when we mouseover a 
	-- unitframe. So we ignore CLEUs for mouseover, and just dispatch UNIT_HEALTH and UNIT_MAXHEALTH.
	for unitID, event in pairs({target="PLAYER_TARGET_CHANGED", focus="PLAYER_FOCUS_CHANGED"}) do
		-- This GUID tells us in where to find unitID.
		-- If oldGUID is set, unitIDsFromGUID[oldGUID] contains unitID.
		local oldGUID 
		eventHandlers[event] = function()
			local newGUID = UnitGUID(unitID)
			if newGUID == oldGUID then
				return
			end
			-- Remove unitID from the table.
			local unitIDs = oldGUID and unitIDsFromGUID[oldGUID]
			if unitIDs then
				for i=#unitIDs,1,-1 do
					if unitIDs[i]==unitID then
						tremove(unitIDs, i)
						break
					end
				end
			end
			-- Add the unitID to the table. If the unit is tracked, there's a table for it already.
			unitIDs = newGUID and unitIDsFromGUID[newGUID]
			if unitIDs then
				tinsert(unitIDs, unitID)
				oldGUID = newGUID
			else
				oldGUID = nil
			end
		end
		-- Bug fix: When we recreate all tables in MapGUIDs below, we cannot rely on oldGUID to tell us
		-- where to find unitID. We need to insert unitID even if oldGUID==UnitGUID(unitID).
		UpdateSpecial[unitID] = function()
			local newGUID = UnitGUID(unitID)
			unitIDs = newGUID and unitIDsFromGUID[newGUID]
			if unitIDs then
				tinsert(unitIDs, unitID)
				oldGUID = newGUID
			else
				oldGUID = nil
			end
		end
	end
end


do
	local updatedUnitIDs = {
		"player", "pet", 
	}
	for i=1,4 do
		tinsert(updatedUnitIDs, 'party'..i)
		tinsert(updatedUnitIDs, 'partypet'..i)
	end
	for i=1,40 do
		tinsert(updatedUnitIDs, 'raid'..i)
		tinsert(updatedUnitIDs, 'raidpet'..i)
	end

	local UpdateTarget, UpdateFocus = UpdateSpecial.target, UpdateSpecial.focus

	-- Generate the map guid->unitIDs.
	local function MapGUIDs()
		for key in pairs(unitIDsFromGUID) do
			unitIDsFromGUID[key] = nil
		end
		for i,unitID in ipairs(updatedUnitIDs) do
			local guid = UnitGUID(unitID)
			if guid then
				if healthFromGUID[guid] then
					healthFromGUID[guid] = nil
					healthMaxFromGUID[guid] = nil
					healthQueueFromGUID[guid] = nil
				end
				if not unitIDsFromGUID[guid] then
					unitIDsFromGUID[guid] = {}
				end
				tinsert(unitIDsFromGUID[guid], unitID)
			end
		end
		UpdateTarget()
		UpdateFocus()
	end
	eventHandlers.PARTY_MEMBERS_CHANGED = MapGUIDs
	eventHandlers.RAID_ROSTER_UPDATE = MapGUIDs
	eventHandlers.UNIT_PET = MapGUIDs
end

-- TODO Remove
QuickHealth.guidmap = unitIDsFromGUID

local MAX_QUEUE_SIZE = 5
local MAX_HP5_TICK = 20 -- 50 HP5

local function processUH(guid, unitHealth, unitHealthMax)
	if unitHealthMax == 100 then
		-- We might get here for unitID == target
		if healthFromGUID[guid] then
			healthFromGUID[guid] = nil
			healthMaxFromGUID[guid] = nil
			healthQueueFromGUID[guid] = nil
		end
		return
	end
	
	-- Get the current health from our table.
	local health = healthFromGUID[guid]
	if not health then
		-- Fill the health & healthMax tables and init an empty queue table.
		healthFromGUID[guid] = unitHealth
		healthMaxFromGUID[guid] = unitHealthMax
		healthQueueFromGUID[guid] = {}
		if HealthUpdatedRegistered then
			events:Fire("HealthUpdated", guid, unitHealth, unitHealthMax)
		end
		if UnitHealthUpdatedRegistered then
			local unitIDs = unitIDsFromGUID[guid]
			if unitIDs then
				for i=1,#unitIDs do
					events:Fire("UnitHealthUpdated", unitIDs[i], unitHealth, unitHealthMax)
				end
			end
		end
		return
	end

	local healthMax = healthMaxFromGUID[guid]
	local healthQueue = healthQueueFromGUID[guid]
	local fire
	if healthMax ~= unitHealthMax then
		-- TODO If healthMax changes, one of three things can happen:
		-- 1. health doesn't change (except if health>unitHealthMax ofc)
		-- 2. health changes by unitHealthMax-healthMax
		-- 3. health/healthMax doesn't change: h1/m1 = h2/m2, h2 = h1*m2/m1, h2-h1 = h1*(m2/m1-1)
		healthMax = unitHealthMax
		healthMaxFromGUID[guid] = unitHealthMax
		-- For now, just reset and hope it's correct. 
		health = unitHealth
		healthFromGUID[guid] = unitHealth
		fire = true
	end

	-- Ex unitHealth = 104, health = 100
	local discrepancy = unitHealth - health
	if discrepancy == 0 then
		clear(healthQueue)
	elseif #healthQueue==0 then
		health = unitHealth
		healthFromGUID[guid] = unitHealth
		fire = true
	elseif 0<discrepancy and discrepancy<=MAX_HP5_TICK then
		clear(healthQueue)
		health = unitHealth
		healthFromGUID[guid] = health
		fire = true
	else
		local noexplanation = true
		fire = true

		--local numdamage = #healthQueue--0
		local pendingDamage
		local healthChanged
		do
			-- Case 1: The last damage entries are pending.
			-- Ex. health = 1000-200-100+250 = 950, healthMax = 1000, unitHealth = 1000, 
			-- queue = (-200, -100, +250) = (-200, +200, -100) -> (-100)
			local pending = 0
			local overheal = 0
			for i=#healthQueue, 1, -1 do
				local amount = healthQueue[i]
				-- We assume that amount is pending, so it didn't count yet.
				-- Ex. i=2: healthBeforePending = 1000-(-100) = 1100
				pending = pending + amount
				local healthBeforePending = health - pending
				-- Check for possible OHs.
				if healthBeforePending > healthMax then
					-- Ex. i=2: healthBeforePending=1000
					overheal = overheal + healthBeforePending-healthMax
					healthBeforePending = healthMax
				end
				local diff = unitHealth - healthBeforePending
				if 0<=diff and diff<=MAX_HP5_TICK then
					noexplanation = nil
					if diff>0 or overheal>0 then
						-- If we get here, our explanation is that an HP5 tick occured.
						healthChanged = true
					end
					pendingDamage = pending
					break
				end
			end
		end

		if noexplanation and --[[numdamage]] #healthQueue>1 then
			-- Case 2: A single damage entry is pending, but not the last one.
			for i=#healthQueue, 1, -1 do
				local amount = healthQueue[i]
				-- See what happens if amount is pending.
				local healthBeforePending = health - amount
				-- Check for OH.
				if healthBeforePending>healthMax then
					healthBeforePending = healthMax
				end
				local diff = unitHealth - healthBeforePending
				if 0<=diff and diff<=MAX_HP5_TICK then
					noexplanation = nil
					if diff>0 then
						-- If we get here, our explanation is that an HP5 tick occured.
						healthChanged = true
					end
					pendingDamage = amount
					break
				end
			end
		end

		if pendingDamage then
			-- Remove everything except the pending damage.
			healthQueue[1] = pendingDamage
			for j=#healthQueue, 2, -1 do
				healthQueue[j]=nil
			end
			if healthChanged then
				health = unitHealth + pendingDamage
				healthFromGUID[guid] = health
			end
		else
			-- Case 3: Nothing's pending, but the order of the combat log entries might have been wrong.
			-- If this results in more overheal than predicted, our prediction was wrong.
			-- We can't do anything about that. Just reset.
			-- Examples: 
			-- 19,179: (-a,+b,-c,+d) = (+b OH, -a, -c, +d) -> ()
			-- 19,1169: (-a,+b) = (+b OH,-a) -> ()
			-- 19,1426: (-a,-b,+c) = (-a,+c OH,-b) -> ()
			-- 19,1253: (-a pending, +b) = (+b OH, -a) -> ()
			-- 19,1942: (-a pending, +b,+c) = (+b,+c OH, -a) -> ()   [can't be (+b OH,-a,+c)]
			clear(healthQueue)
			health = unitHealth
			healthFromGUID[guid] = unitHealth
		end
	end

	if fire then
		if HealthUpdatedRegistered then
			events:Fire("HealthUpdated", guid, health, healthMax)
		end
		if UnitHealthUpdatedRegistered then
			local unitID = unitIDsFromGUID[guid]
			if unitID then
				for i=1,#unitID do
					events:Fire("UnitHealthUpdated", unitID[i], health, healthMax)
				end
			end
		end
	end
end

-- Amount is just the raw value from the combat log, including overheal.
local function processCLEU(guid, amount, amountMax)
	local health = healthFromGUID[guid]
	if not health then return end
	local healthQueue = healthQueueFromGUID[guid]
	local healthMax = healthMaxFromGUID[guid]

	if amountMax then
		healthMax = healthMax+amountMax
		healthMaxFromGUID[guid] = healthMax
	end

	local healthDiff = amount
	if health+amount>healthMax then
		healthDiff = healthMax-health
	end

	if healthDiff~=0 then
		if healthDiff<0 then
			-- We don't need to keep track of heals, because they cannot be pending anyways.
			tinsert(healthQueue, healthDiff)
			if #healthQueue>MAX_QUEUE_SIZE then
				local first = tremove(healthQueue, 1)
				healthQueue[1] = healthQueue[1]+first
			end
		end
		health = health+healthDiff
		healthFromGUID[guid] = health
		if HealthUpdatedRegistered then
			events:Fire("HealthUpdated", guid, health, healthMax)
		end
		if UnitHealthUpdatedRegistered then
			local unitID = unitIDsFromGUID[guid]
			if unitID then
				for i=1,#unitID do
					events:Fire("UnitHealthUpdated", unitID[i], health, healthMax)
				end
			end
		end
	end
end

eventHandlers.CLEU = processCLEU
eventHandlers.UH = processUH


function eventHandlers.PLAYER_UNGHOST()
	local guid = UnitGUID("player")
	healthFromGUID[guid] = nil
	healthMaxFromGUID[guid] = nil
	healthQueueFromGUID[guid] = nil

	eventHandlers.UNIT_HEALTH("player")
end

function eventHandlers.PLAYER_ALIVE()
	eventHandlers.PLAYER_UNGHOST()
end

local isSpecialUnitID = {
	target = true,
	focus = true,
	mouseover = true,
}
function eventHandlers.UNIT_HEALTH(unitID)
	if isSpecialUnitID[unitID] then 
		-- If a unitID is special, we only need to fire here if we wouldn't fire anyways.
		-- We don't ever track mouseover, and we don't track target or focus if they are outsiders.
		if UnitHealthUpdatedRegistered and (unitID=='mouseover' or not healthFromGUID[UnitGUID(unitID)]) then
			events:Fire("UnitHealthUpdated", unitID, UnitHealth(unitID), UnitHealthMax(unitID))
		end
		-- We can always return here. Even if we didn't fire yet, we get another UNIT_HEALTH 
		-- for another unitID like player/party/raid in the same frame.
		return
	end

	local unitHealth, unitHealthMax = UnitHealth(unitID), UnitHealthMax(unitID)
	if HealthUpdatedDebugRegistered then
		events:Fire("HealthUpdatedDebug", UnitGUID(unitID), 1, GetTime(), GetFrameNumber(), unitHealth, unitHealthMax)
	end

	--processUH(UnitGUID(unitID), unitHealth, unitHealthMax)
	local guid = UnitGUID(unitID)
	processUH(guid, unitHealth, unitHealthMax)

	if UnitIsDeadOrGhost(unitID) then
		if healthFromGUID[guid] then
			healthFromGUID[guid] = nil
			healthMaxFromGUID[guid] = nil
			healthQueueFromGUID[guid] = nil
		end
	end
end

function eventHandlers.UNIT_MAXHEALTH(unitID)
	if isSpecialUnitID[unitID] then 
		if UnitHealthUpdatedRegistered and (unitID=='mouseover' or not healthFromGUID[UnitGUID(unitID)]) then
			events:Fire("UnitHealthUpdated", unitID, UnitHealth(unitID), UnitHealthMax(unitID))
		end
		return
	end
	local unitHealth, unitHealthMax = UnitHealth(unitID), UnitHealthMax(unitID)
	if HealthUpdatedDebugRegistered then
		events:Fire("HealthUpdatedDebug", UnitGUID(unitID), 2, GetTime(), GetFrameNumber(), unitHealth, unitHealthMax)
	end

	processUH(UnitGUID(unitID), unitHealth, unitHealthMax)
end

-- For an event to be interesting, the unitFlags have to match *both* of the following bitsets. The reason we can't just combine
-- them into one bitset is that raid totems have COMBATLOG_OBJECT_AFFILIATION_RAID set, but not PLAYER or PET.
local flagRaid = bit.bor(COMBATLOG_OBJECT_AFFILIATION_MINE, COMBATLOG_OBJECT_AFFILIATION_PARTY, COMBATLOG_OBJECT_AFFILIATION_RAID)
local flagPlayerPets = bit.bor(COMBATLOG_OBJECT_TYPE_PLAYER, COMBATLOG_OBJECT_TYPE_PET)
local bitband = bit.band
function eventHandlers.COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
	local amount
	local amountMax
	local guid
	
	if bitband(destFlags, flagRaid)>0 and bitband(destFlags, flagPlayerPets)>0 then
		-- We only care about damage or healing, check for either of those and react accordingly
		if(event == "SWING_DAMAGE") then --autoattack dmg
			amount = -(...) -- putting in braces will autoselect the first arg, no need to use select(1, ...)
		elseif(event == "SPELL_PERIODIC_DAMAGE" or event == "SPELL_DAMAGE"
			or event == "DAMAGE_SPLIT" or event == "DAMAGE_SHIELD") then -- all kinds of spelldamage
			amount = -select(4, ...)
		elseif(event == "SPELL_HEAL" or event == "SPELL_PERIODIC_HEAL") then --healing
			amount = select(4, ...)
		elseif(event == "ENVIRONMENTAL_DAMAGE") then --environmental damage
			amount = -select(2, ...)
--[[
		else
			local applied = event == "SPELL_AURA_APPLIED"
			if applied or event == "SPELL_AURA_REMOVED" then
				local spellID = (...)
				if spellID == 469 then
					-- TODO Commanding Shout
					local health = healthFromGUID[destGUID]
					if health then
						local healthMax = healthMaxFromGUID[destGUID]
						local p = health/healthMax
						if applied then
							amount = math.floor((healthMax+1080)*p + 0.5)
							amountMax = 1080
						else
							amount = math.floor((healthMax-1080)*p + 0.5)
							amountMax = -1080
						end
					end
				end
			end
--]]
		end
		guid = destGUID
	elseif bitband(sourceFlags, flagRaid)>0 and bitband(sourceFlags, flagPlayerPets)>0 then
		if event == "SPELL_CAST_SUCCESS" then
			local spellID = (...)
			if spellID==12975 then
				-- Last Stand. This should be pretty exact because healthMax doesn't change.
				local healthMax = healthMaxFromGUID[sourceGUID]
				if healthMax then
					amount = math.floor(0.3 * healthMax + 0.5)
					amountMax = amount
				end
--[[
			elseif spellID==2687 then
				-- TODO Bloodrage
				amount = -711
--]]
			end
		end
		guid = sourceGUID
	end

	if amount then
		if HealthUpdatedDebugRegistered then
			events:Fire("HealthUpdatedDebug", guid, 3, GetTime(), GetFrameNumber(), amount, amountMax)
		end
		processCLEU(guid, amount, amountMax)
	end
end
