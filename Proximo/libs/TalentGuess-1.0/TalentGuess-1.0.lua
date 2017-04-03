local major = "TalentGuess-1.0"
local minor = tonumber(string.match("$Revision: 703$", "(%d+)") or 1)

assert(LibStub, string.format("%s requires LibStub.", major))

local Talents = LibStub:NewLibrary(major, minor)
if( not Talents ) then return end

local L = {
	["BAD_ARGUMENT"] = "bad argument #%d for '%s' (%s expected, got %s)",
	["MUST_CALL"] = "You must call '%s' from a registered %s object.",
	["NO_DATA"] = "%s requires TalentGuessData-1.0, make sure you installed the library correctly.",
	["BAD_FUNCTION"] = "Bad function passed to '%s', doesn't seem to exist.",
	["BAD_CLASS"] = "No class '%s' found in '%s'.",
}

-- Load the latest data
local Data = LibStub:GetLibrary("TalentGuessData-1.0", true)
assert(Data, string.format(L["NO_DATA"], major))

Talents.spells = Data.Spells
Talents.callbacks = Talents.callbacks or {}
Talents.enemySpellRecords = Talents.enemySpellRecords or {}
Talents.totalRegistered = Talents.totalRegistered or 0
Talents.registeredObjs = Talents.registeredObjs or {}
Talents.frame = Talents.frame or CreateFrame("Frame")

local enemySpellRecords = Talents.enemySpellRecords
local registeredObjs = Talents.registeredObjs
local callbacks = Talents.callbacks
local talentPoints, checkBuffs, castOnly = {}, {}, {}
local methods = {"EnableCollection", "DisableCollection", "GetTalents", "GetUsed", "RegisterCallback", "UnregisterCallback"}

-- Validation for passed arguments
local function assert(level, condition, message)
	if( not condition ) then
		error(message, level)
	end
end

local function argcheck(value, num, ...)
	if( type(num) ~= "number" ) then
		error(L["BAD_ARGUMENT"]:format(2, "argcheck", "number", type(num)), 1)
	end

	for i=1,select("#", ...) do
		if( type(value) == select(i, ...) ) then return end
	end

	local types = string.join(", ", ...)
	local name = string.match(debugstack(2,2,0), ": in function [`<](.-)['>]")
	error(L["BAD_ARGUMENT"]:format(num, name, types, type(value)), 3)
end

-- PUBLIC METHODS
function Talents:Register()
	Talents.totalRegistered = Talents.totalRegistered + 1
	local id = Talents.totalRegistered
	
	registeredObjs[id] = {}
	registeredObjs[id].id = id
	registeredObjs[id].collecting = false
	
	for _, func in pairs(methods) do
		registeredObjs[id][func] = Talents[func]
	end
	
	return registeredObjs[id]
end

function Talents.EnableCollection(self)
	assert(3, self.id and registeredObjs[self.id], string.format(L["MUST_CALL"], "EnableCollection", major))
	
	registeredObjs[self.id].collecting = true
	Talents:CheckCollecting()
end

function Talents.DisableCollection(self)
	assert(3, self.id and registeredObjs[self.id], string.format(L["MUST_CALL"], "DisableCollection", major))
	
	registeredObjs[self.id].collecting = false
	Talents:CheckCollecting()
end

function Talents.RegisterCallback(self, handler, func)
	argcheck(handler, 2, "table", "function", "string")
	argcheck(func, 3, "string", "nil")	
	assert(3, self.id and registeredObjs[self.id], string.format(L["MUST_CALL"], "RegisterCallback", major))
	
	if( type(handler) == "table" and type(func) == "string" ) then
		assert(3, handler[func], string.format(L["BAD_FUNCTION"], "RegisterCallback"))
		callbacks[handler] = func
	elseif( type(handler) == "function" ) then
		assert(3, handler, string.format(L["BAD_FUNCTION"], "RegisterCallback"))
		callbacks[handler] = true
	elseif( type(handler) == "string" ) then
		assert(3, getglobal(handler), string.format(L["BAD_FUNCTION"], "RegisterCallback"))
		callbacks[handler] = true
	end
end

function Talents.UnregisterCallback(self, handler, func)
	argcheck(handler, 2, "table", "function", "string")
	argcheck(func, 3, "string", "nil")
	assert(3, self.id and registeredObjs[self.id], string.format(L["MUST_CALL"], "UnregisterCallback", major))

	callbacks[handler] = nil
end

-- Return our guess at their talents
function Talents.GetTalents(self, name)
	assert(3, self.id and registeredObjs[self.id], string.format(L["MUST_CALL"], "GetTalents", major))
	argcheck(name, 2, "string")
	
	if( not enemySpellRecords[name] ) then
		return nil
	end
	
	talentPoints[1] = 0
	talentPoints[2] = 0
	talentPoints[3] = 0
	
	for spellID in pairs(enemySpellRecords[name]) do
		local treeNum, points, isBuff
		if( Talents.spells[spellID] ) then
			treeNum, points, isBuff, isCast = string.split(":", Talents.spells[spellID])
		end
		
		treeNum = tonumber(treeNum)
		points = tonumber(points)
		
		if( talentPoints[treeNum] < points ) then
			talentPoints[treeNum] = points
		end
	end
	
	return talentPoints[1], talentPoints[2], talentPoints[3]
end

-- Returns the abilities used for this person
function Talents.GetUsed(self, name)
	assert(3, self.id and registeredObjs[self.id], string.format(L["MUST_CALL"], "GetUsed", major))
	argcheck(name, 2, "string")
	
	if( not enemySpellRecords[name] ) then
		return nil
	end
	
	local spellsUsed = {[1] = {}, [2] = {}, [3] = {}}
	for spellID in pairs(enemySpellRecords[name]) do
		local treeNum, points, isBuff
		if( Talents.spells[spellID] ) then
			treeNum, points, isBuff, isCast = string.split(":", Talents.spells[spellID])
		end
		
		treeNum = tonumber(treeNum)
		points = tonumber(points)
		
		spellsUsed[treeNum][spellID] = points
	end
	
	return spellsUsed[1], spellsUsed[2], spellsUsed[3]
end

-- PRIVATE METHODS
-- Add a new spell record for this person
local function addSpell(spellID, guid, name)
	if( not enemySpellRecords[name] ) then
		enemySpellRecords[name] = {}
	elseif( enemySpellRecords[name][spellID] ) then
		return
	end
	

	enemySpellRecords[name][spellID] = true

	-- New spellID added, trigger callbacks
	for handler, func in pairs(callbacks) do
		if( type(handler) == "table" ) then
			handler[func](handler, name, spellID)
		elseif( type(handler) == "string" ) then
			getglobal(handler)(name, spellID)
		elseif( type(handler) == "function" ) then
			handler(name, spellID)
		end
	end
end

-- Buff scan for figuring out talents if we need to
local function PLAYER_TARGET_CHANGED()
	-- Make sure it's a valid unit
	if( not UnitExists("target") or not UnitIsPlayer("target") or not UnitIsEnemy("player", "target") or UnitIsCharmed("target") or UnitIsCharmed("player") ) then
		return
	end

	local fullName, server = UnitName("target")
	if( server and server ~= "" ) then
		fullName = string.format("%s-%s", fullName, server)
	end
	
	local id = 0

	while( true ) do
		id = id + 1
		local name, rank = UnitBuff("target", id)
		if( not name ) then break end
		
		local spellID = checkBuffs[name .. (rank or "")]
		if( spellID ) then
			addSpell(spellID, UnitGUID("target"), fullName)
		end
	end
end

-- WOTLK BUFF SCANNING
local function PLAYER_TARGET_CHANGED_WOTLK()
	-- Make sure it's a valid unit
	if( not UnitExists("target") or not UnitIsPlayer("target") or not UnitIsEnemy("player", "target") or UnitIsCharmed("target") or UnitIsCharmed("player") ) then
		return
	end

	local fullName, server = UnitName("target")
	if( server and server ~= "" ) then
		fullName = string.format("%s-%s", fullName, server)
	end
	
	local buffID = 1
	while( true ) do
		local name, rank = UnitAura("target", buffID, "HARMFUL")
		if( not name ) then break end
		buffID = buffID + 1
		
		local spellID = checkBuffs[name .. (rank or "")]
		if( spellID ) then
			addSpell(spellID, UnitGUID("target"), fullName)
		end
	end
end

-- Data recording!
local COMBATLOG_OBJECT_TYPE_PLAYER = COMBATLOG_OBJECT_TYPE_PLAYER
local COMBATLOG_OBJECT_REACTION_HOSTILE	= COMBATLOG_OBJECT_REACTION_HOSTILE
local ENEMY_AFFILIATION = bit.bor(COMBATLOG_OBJECT_REACTION_HOSTILE, COMBATLOG_OBJECT_TYPE_PLAYER)

local eventsRegistered = {["SPELL_AURA_APPLIED"] = true, ["SPELL_ENERGIZE"] = true, ["SPELL_HEAL"] = true, ["SPELL_SUMMON"] = true, ["SPELL_CAST_SUCCESS"] = true, ["SPELL_CAST_START"] = true}
local function COMBAT_LOG_EVENT_UNFILTERED(timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
	if( not eventsRegistered[eventType] ) then
		return
	end
	
	-- Make sure it's a spell we want
	local spellID = ...
	if( not Talents.spells[spellID] ) then
		return
	end
	
	-- Enemy gained a buff, have to see destFlags and a special check
	if( eventType == "SPELL_AURA_APPLIED" ) then
		if( not castOnly[spellID] and bit.band(destFlags, ENEMY_AFFILIATION) == ENEMY_AFFILIATION and select(4, ...) == "BUFF" ) then
			addSpell(spellID, destGUID, destName)
		end

	-- Everything else shares the same sourceFlags check, and we use eventsRegistered to make sure it's one we want, soo small optimization
	elseif( bit.band(sourceFlags, ENEMY_AFFILIATION) == ENEMY_AFFILIATION ) then
		addSpell(spellID, sourceGUID, sourceName)
	end
end

-- Event handler
local function OnEvent(self, event, ...)
	if( event == "COMBAT_LOG_EVENT_UNFILTERED" ) then
		COMBAT_LOG_EVENT_UNFILTERED(...)
	elseif( event == "PLAYER_TARGET_CHANGED" ) then
		if( not IS_WRATH_BUILD ) then
			PLAYER_TARGET_CHANGED(...)
		else
			PLAYER_TARGET_CHANGED_WOTLK(...)
		end
	end
end

-- Check if we need to enable, or disable the event
function Talents:CheckCollecting()
	for _, obj in pairs(registeredObjs) do
		if( obj.collecting ) then
			Talents.frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			Talents.frame:RegisterEvent("PLAYER_TARGET_CHANGED")
			return
		end
	end
	
	Talents.frame:UnregisterAllEvents()
end

Talents.frame:SetScript("OnEvent", OnEvent)
Talents:CheckCollecting()

-- Cache our list of buffs that we should scan when targeting
for spellID, data in pairs(Talents.spells) do
	local treeNum, points, isBuff, isCast = string.split(":", data)
	if( isBuff == "true" ) then
		local name, rank = GetSpellInfo(spellID)
		if( name ) then
			checkBuffs[name .. (rank or "")] = spellID
		end
	end
	
	if( isCast == "true" ) then
		castOnly[spellID] = true
	end
end
