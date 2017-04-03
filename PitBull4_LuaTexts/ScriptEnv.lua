-- ScriptEnv.lua: Utility functions for use in Lua scripts for LuaTexts.
if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
local L = PitBull4.L
local PitBull4_LuaTexts = PitBull4:GetModule("LuaTexts")

-- Pre 3.2.0 compatability support
local wow_320 = select(4, GetBuildInfo()) >= 30200
local GetQuestDifficultyColor
if not wow_320 then
	GetQuestDifficultyColor = _G.GetDifficultyColor
else
	GetQuestDifficultyColor = _G.GetQuestDifficultyColor
end

-- The ScriptEnv table serves as the environment that the scripts run
-- under LuaTexts run under.  The functions included in it are accessible
-- to this scripts as though they were local functions to it.  Functions
-- that they call will not have access to these functions.  
local ScriptEnv = setmetatable({}, {__index = _G})
PitBull4_LuaTexts.ScriptEnv = ScriptEnv

local mouseover_check_cache = PitBull4_LuaTexts.mouseover_check_cache
local spell_cast_cache = PitBull4_LuaTexts.spell_cast_cache
local power_cache = PitBull4_LuaTexts.power_cache
local cast_data = PitBull4_LuaTexts.cast_data
local to_update = PitBull4_LuaTexts.to_update
local afk_cache = PitBull4_LuaTexts.afk_cache
local dnd_cache = PitBull4_LuaTexts.dnd_cache
local offline_cache = PitBull4_LuaTexts.offline_cache
local dead_cache = PitBull4_LuaTexts.dead_cache
local offline_times = PitBull4_LuaTexts.offline_times
local afk_times = PitBull4_LuaTexts.afk_times
local dnd = PitBull4_LuaTexts.dnd
local dead_times = PitBull4_LuaTexts.dead_times


-- The following functions exist to provide a method to help people moving
-- from LibDogTag.  They implement the functionality that exists in some of
-- the tags in LibDogTag.  Tags that are identical to Blizzard API calls are
-- not included and you should use the API call.  Some of them do not implement
-- all of the features of the relevent tag in LibDogTag.  People interested in
-- contributing new functions should open a ticket on the PitBull4 project as
-- a patch to the LuaTexts module.  In general tags that are simplistic work
-- on other tags should be generalized (e.g. Percent instead of PercentHP and PercentMP)
-- or should simply not exist.  A major design goal is to avoid inefficient code.
-- Functions which encourage inefficient code design will not be accepted.

-- A number of these functions are borrowed or adapted from the code implmenting
-- similar tags in DogTag.  Permission to do so granted by ckknight.

local UnitToLocale = {player = L["Player"], target = L["Target"], pet = L["%s's pet"]:format(L["Player"]), focus = L["Focus-target"], mouseover = L["Mouse-over"]}
setmetatable(UnitToLocale, {__index=function(self, unit)
	if unit:find("pet$") then
		local nonPet = unit:sub(1, -4)
		self[unit] = L["%s's pet"]:format(self[nonPet])
		return self[unit]
	elseif not unit:find("target$") then
		if unit:find("^party%d$") then
			local num = unit:match("^party(%d)$")
			self[unit] = L["Party member #%d"]:format(num)
			return self[unit]
		elseif unit:find("^raid%d%d?$") then
			local num = unit:match("^raid(%d%d?)$")
			self[unit] = L["Raid member #%d"]:format(num)
			return self[unit]
		elseif unit:find("^partypet%d$") then
			local num = unit:match("^partypet(%d)$")
			self[unit] = UnitToLocale["party" .. num .. "pet"]
			return self[unit]
		elseif unit:find("^raidpet%d%d?$") then
			local num = unit:match("^raidpet(%d%d?)$")
			self[unit] = UnitToLocale["raid" .. num .. "pet"]
			return self[unit]
		end
		self[unit] = unit
		return unit
	end
	local nonTarget = unit:sub(1, -7)
	self[unit] = L["%s's target"]:format(self[nonTarget])
	return self[unit]
end})

local function VehicleName(unit)
	local name = UnitName(unit:gsub("vehicle", "pet")) or UnitName(unit) or L["Vehicle"]
	local owner_unit = unit:gsub("vehicle", "")
	if owner_unit == "" then
		owner_unit = "player"
	end
	local owner = UnitName(owner_unit)
	if owner then
		return L["%s's %s"]:format(owner, name)
	else
		return name
	end
end
ScriptEnv.VehicleName = VehicleName

local function Name(unit)
	if unit ~= "player" and not UnitExists(unit) then
		return UnitToLocale[unit]
	else
		if unit:match("%d*pet%d*$") then
			local vehicle = unit:gsub("pet", "vehicle")
			if UnitIsUnit(unit, vehicle) then
				return VehicleName(vehicle)
			end
		elseif unit:match("%d*vehicle%d*$") then
			return VehicleName(unit)
		end
	end
	return UnitName(unit) 
end
ScriptEnv.Name = Name

local L_DAY_ONELETTER_ABBR    = DAY_ONELETTER_ABBR:gsub("%s*%%d%s*", "")
local L_HOUR_ONELETTER_ABBR   = HOUR_ONELETTER_ABBR:gsub("%s*%%d%s*", "")
local L_MINUTE_ONELETTER_ABBR = MINUTE_ONELETTER_ABBR:gsub("%s*%%d%s*", "")
local L_SECOND_ONELETTER_ABBR = SECOND_ONELETTER_ABBR:gsub("%s*%%d%s*", "")
local L_DAYS_ABBR = DAYS_ABBR:gsub("%s*%%d%s*","")
local L_HOURS_ABBR = HOURS_ABBR:gsub("%s*%%d%s*","")
local L_MINUTES_ABBR = MINUTES_ABBR:gsub("%s*%%d%s*","")
local L_SECONDS_ABBR = SECONDS_ABBR:gsub("%s*%%d%s*","")

local t = {}
local function FormatDuration(number, format)
	local negative = ""
	if number < 0 then
		number = -number
		negative = "-"
	end

	if not format then
		format = 'c'
	else
		format = format:sub(1, 1):lower()
	end

	if format == "e" then
		if number == 1/0 then
			return negative .. "***"
		end

		t[#t+1] = negative

		number = math.floor(number + 0.5)

		local first = true

		if number >= 60*60*24 then
			local days = math.floor(number / (60*60*24))
			number = number % (60*60*24)
			t[#t+1] = ("%.0f"):format(days)
			t[#t+1] = " "
			t[#t+1] = _L_DAYS_ABBR
			first = false
		end

		if number >= 60*60 then
			local hours = math.floor(number / (60*60))
			number = number % (60*60)
			if not first then
				t[#t+1] = " "
			else
				first = false
			end
			t[#t+1] = hours
			t[#t+1] = " "
			t[#t+1] = L_HOURS_ABBR
		end

		if number >= 60 then
			local minutes = math.floor(number / 60)
			number = number % 60
			if not first then
				t[#t+1] = " "
			else
				first = false
			end
			t[#t+1] = minutes
			t[#t+1] = " "
			t[#t+1] = L_MINUTES_ABBR
		end

		if number >= 1 or first then
			local seconds = number
			if not first then
				t[#t+1] = " "
			else
				first = false
			end
			t[#t+1] = seconds
			t[#t+1] = " "
			t[#t+1] = L_SECONDS_ABBR
		end
		local s = table.concat(t)
		wipe(t)
		return s
	elseif format == "f" then
		if number == 1/0 then
			return negative .. "***"
		elseif number >= 60*60*24 then
			return ("%s%.0f%s %02d%s %02d%s %02d%s"):format(negative, math.floor(number/86400), L_DAY_ONELETTER_ABBR, number/3600 % 24, L_HOUR_ONELETTER_ABBR, number/60 % 60, L_MINUTE_ONELETTER_ABBR, number % 60, L_SECOND_ONELETTER_ABBR)
		elseif number >= 60*60 then
			return ("%s%d%s %02d%s %02d%s"):format(negative, number/3600, L_HOUR_ONELETTER_ABBR, number/60 % 60, L_MINUTE_ONELETTER_ABBR, number % 60, L_SECOND_ONELETTER_ABBR)
		elseif number >= 60 then
			return ("%s%d%s %02d%s"):format(negative, number/60, L_MINUTE_ONELETTER_ABBR, number % 60, L_SECOND_ONELETTER_ABBR)
		else
			return ("%s%d%s"):format(negative, number, L_SECOND_ONELETTER_ABBR)
		end
	elseif format == "s" then
		if number == 1/0 then
			return negative .. "***"
		elseif number >= 2*60*60*24 then
			return ("%s%.1f %s"):format(negative, number/86400, L_DAYS_ABBR)
		elseif number >= 2*60*60 then
			return ("%s%.1f %s"):format(negative, number/3600, L_HOURS_ABBR)
		elseif number >= 2*60 then
			return ("%s%.1f %s"):format(negative, number/60, L_MINUTES_ABBR)
		elseif number >= 3 then
			return ("%s%.0f %s"):format(negative, number, L_SECONDS_ABBR)
		else
			return ("%s%.1f %s"):format(negative, number, L_SECONDS_ABBR)
		end
	else
		if number == 1/0 then
			return ("%s**%d **:**:**"):format(negative, L_DAY_ONELETTER_ABBR)
		elseif number >= 60*60*24 then
			return ("%s%.0f%s %d:%02d:%02d"):format(negative, math.floor(number/86400), L_DAY_ONELETTER_ABBR, number/3600 % 24, number/60 % 60, number % 60)
		elseif number >= 60*60 then
			return ("%s%d:%02d:%02d"):format(negative, number/3600, number/60 % 60, number % 60)
		else
			return ("%s%d:%02d"):format(negative, number/60 % 60, number % 60)
		end
	end
end
ScriptEnv.FormatDuration = FormatDuration

-- Depends upon the local t = {} above FormatDuration
local function SeparateDigits(number, thousands, decimal)
	if not thousands then
		thousands = ','
	end
	if not decimal then
		decimal = '.'
	end
	local int = math.floor(number)
	local rest = number % 1
	if int == 0 then
		t[#t+1] = 0
	else
		local digits = math.log10(int)
		local segments = math.floor(digits / 3)
		t[#t+1] = math.floor(int / 1000^segments)
		for i = segments-1, 0, -1 do
			t[#t+1] = thousands
			t[#t+1] = ("%03d"):format(math.floor(int / 1000^i) % 1000)
		end
	end
	if rest ~= 0 then
		t[#t+1] = decimal
		rest = math.floor(rest * 10^6)
		while rest % 10 == 0 do
			rest = rest / 10
		end
		t[#t+1] = rest
	end
	local s = table.concat(t)
	wipe(t)
	return s
end
ScriptEnv.SeparateDigits = SeparateDigits

local function Angle(value)
	if value and value ~= '' then
		return '<',value,'>'
	else
		return '','',''
	end
end
ScriptEnv.Angle = Angle

local function Paren(value)
	if value and value ~= '' then
		return '(',value,')'
	else
		return '','',''
	end
end
ScriptEnv.Paren = Paren

local function UpdateIn(seconds)
	local font_string = ScriptEnv.font_string
	local current_timer = to_update[font_string]
	if not current_timer or current_timer > seconds then
		to_update[font_string] = seconds
	end
end
ScriptEnv.UpdateIn = UpdateIn

local function IsAFK(unit)
	afk_cache[ScriptEnv.font_string] = true
	return not not afk_times[UnitGUID(unit)]
end
ScriptEnv.IsAFK = IsAFK

local function AFKDuration(unit)
	local afk = afk_times[UnitGUID(unit)]
	afk_cache[ScriptEnv.font_string] = true
	if afk then
		UpdateIn(0.25)
		return GetTime() - afk
	end
end
ScriptEnv.AFKDuration = AFKDuration

local function AFK(unit)
	local afk = AFKDuration(unit)
	if afk then
		return _G.AFK..' ('..FormatDuration(afk)..')'
	end
end
ScriptEnv.AFK = AFK

local function IsDND(unit)
	dnd_cache[ScriptEnv.font_string] = true
	return not not dnd_times[UnitGUID(unit)]
end
ScriptEnv.IsDND = IsDND

local function DND(unit)
	dnd_cache[ScriptEnv.font_string] = true
	if dnd[UnitGUID(unit)] then
		return _G.DND
	end
end
ScriptEnv.DND = DND

local HOSTILE_REACTION = 2
local NEUTRAL_REACTION = 4
local FRIENDLY_REACTION = 5

local function HostileColor(unit)
	local r, g, b
	if not unit then
		r, g, b = 0.8, 0.8, 0.8 --UNKNOWN 
	else
		if UnitIsPlayer(unit) or UnitPlayerControlled(unit) then
			if UnitCanAttack(unit, "player") then
				-- they can attack me
				if UnitCanAttack("player", unit) then
					-- and I can attack them
					r, g, b = unpack(PitBull4.ReactionColors[HOSTILE_REACTION])
				else
					-- but I can't attack them
					r, g, b = unpack(PitBull4.ReactionColors.civilian)
				end
			elseif UnitCanAttack("player", unit) then
				-- they can't attack me, but I can attack them
				r, g, b = unpack(PitBull4.ReactionColors[NEUTRAL_REACTION])
			elseif UnitIsPVP(unit) then
				-- on my team
				r, g, b = unpack(PitBull4.ReactionColors[FRIENDLY_REACTION])
			else
				-- either enemy or friend, no violance
				r, g, b = unpack(PitBull4.ReactionColors.civilian)
			end
		elseif (UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit)) or UnitIsDead(unit) then
			r, g, b = 0.5, 0.5, 0.5 -- TODO: We really need this to be globally configurable. 
		else
			local reaction = UnitReaction(unit, "player")
			if reaction then
				if reaction >= 5 then
					r, g, b = unpack(PitBull4.ReactionColors[FRIENDLY_REACTION])
				elseif reaction == 4 then
					r, g, b = unpack(PitBull4.ReactionColors[NEUTRAL_REACTION])
				else
					r, g, b = unpack(PitBull4.ReactionColors[HOSTILE_REACTION]) 
				end
			else
				r, g, b = 0.8, 0.8, 0.8 --UNKNOWN
			end
		end
	end
	return r * 255, g * 255, b * 255
end
ScriptEnv.HostileColor = HostileColor

local function ClassColor(unit)
	local r, g, b = 0.8, 0.8, 0.8 --UNKNOWN
	local _, class = UnitClass(unit)
	local t = PitBull4.ClassColors[class]
	if t then
		r, g, b = t[1], t[2], t[3]
	end
	return r * 255, g * 255, b * 255
end
ScriptEnv.ClassColor = ClassColor

local function DifficultyColor(unit)
	local level
	level = UnitLevel(unit)
	if level <= 0 then
		level = 99
	end
	local color = GetQuestDifficultyColor(level)
	return color.r * 255, color.g * 255, color.b * 255
end
ScriptEnv.DifficultyColor = DifficultyColor

local function AggroColor(unit)
	local r, g, b = UnitSelectionColor(unit)
	return r * 255, g * 255, b * 255
end
ScriptEnv.AggroColor = AggroColor

local classification_lookup = {
	rare = L["Rare"],
	rareelite = L["Rare-Elite"],
	elite = L["Elite"],
	worldboss = L["Boss"]
}

local function Classification(unit)
	return classification_lookup[PitBull4.Utils.BetterUnitClassification(unit)]
end
ScriptEnv.Classification = Classification

local ShortClassification_abbrev = {
	[L["Rare"]] = L["Rare_short"],
	[L["Rare-Elite"]] = L["Rare-Elite_short"],
	[L["Elite"]] = L["Elite_short"],
	[L["Boss"]] = L["Boss_short"]
}

local function ShortClassification(arg)
	local short = ShortClassification_abbrev[arg]
	if not short and PitBull4.Utils.GetBestUnitID(arg) then
		-- If it's empty then maybe arg is a unit
		short = ShortClassification_abbrev[Classification(arg)]
	end
	return short
end
ScriptEnv.ShortClassification = ShortClassification

local function Class(unit)
	if UnitIsPlayer(unit) then
		return UnitClass(unit) or UNKNOWN
	else
		return UnitClassBase(unit) or UNKNOWN
	end
end
ScriptEnv.Class = Class

local ShortClass_abbrev = {
	[L["Priest"]] = L["Priest_short"],
	[L["Mage"]] = L["Mage_short"],
	[L["Shaman"]] = L["Shaman_short"],
	[L["Paladin"]] = L["Paladin_short"],
	[L["Warlock"]] = L["Warlock_short"],
	[L["Druid"]] = L["Druid_short"],
	[L["Rogue"]] = L["Rogue_short"],
	[L["Hunter"]] = L["Hunter_short"],
	[L["Warrior"]] = L["Warrior_short"],
	[L["Death Knight"]] = L["Death Knight_short"],
	[L["Priest_female"]] = L["Priest_short"],
	[L["Mage_female"]] = L["Mage_short"],
	[L["Shaman_female"]] = L["Shaman_short"],
	[L["Paladin_female"]] = L["Paladin_short"],
	[L["Warlock_female"]] = L["Warlock_short"],
	[L["Druid_female"]] = L["Druid_short"],
	[L["Rogue_female"]] = L["Rogue_short"],
	[L["Hunter_female"]] = L["Hunter_short"],
	[L["Warrior_female"]] = L["Warrior_short"],
	[L["Death Knight_female"]] = L["Death Knight_short"],
}

local function ShortClass(arg)
	local short = ShortClass_abbrev[arg]
	if not short and PitBull4.Utils.GetBestUnitID(arg) then
		-- If it's empty then maybe arg is a unit
		short = ShortClass_abbrev[Class(arg)]
	end
	return short
end
ScriptEnv.ShortClass = ShortClass

local function Level(unit)
	local level = UnitLevel(unit)
	if level <= 0 then
		level = '??'
	end
	return level
end
ScriptEnv.Level = Level

local function Creature(unit)
	return UnitCreatureFamily(unit) or UnitCreatureType(unit) or UNKNOWN
end
ScriptEnv.Creature = Creature

local function SmartRace(unit)
	if UnitIsPlayer(unit) then
		local race = UnitRace(unit)
		return race or UNKNOWN
	else
		return Creature(unit)
	end
end
ScriptEnv.SmartRace = SmartRace

local ShortRace_abbrev = {
	[L["Blood Elf"]] = L["Blood Elf_short"],
	[L["Draenei"]] = L["Draenei_short"],
	[L["Dwarf"]] = L["Dwarf_short"],
	[L["Gnome"]] = L["Gnome_short"],
	[L["Human"]] = L["Human_short"],
	[L["Night Elf"]] = L["Night Elf_short"],
	[L["Orc"]] = L["Orc_short"],
	[L["Tauren"]] = L["Tauren_short"],
	[L["Troll"]] = L["Troll_short"],
	[L["Undead"]] = L["Undead_short"],
	[L["Blood Elf_female"]] = L["Blood Elf_short"],
	[L["Draenei_female"]] = L["Draenei_short"],
	[L["Dwarf_female"]] = L["Dwarf_short"],
	[L["Gnome_female"]] = L["Gnome_short"],
	[L["Human_female"]] = L["Human_short"],
	[L["Night Elf_female"]] = L["Night Elf_short"],
	[L["Orc_female"]] = L["Orc_short"],
	[L["Tauren_female"]] = L["Tauren_short"],
	[L["Troll_female"]] = L["Troll_short"],
	[L["Undead_female"]] = L["Undead_short"],
}

local function ShortRace(arg)
	local short = ShortRace_abbrev[arg]
	if not short and PitBull4.Utils.GetBestUnitID(arg) then
		-- If it's empty then maybe arg is a unit
		short = ShortRace_abbrev[UnitRace(arg)]
	end
	return short
end
ScriptEnv.ShortRace = ShortRace

local function IsPet(unit)
	return not UnitIsPlayer(unit) and (UnitPlayerControlled(unit) or UnitPlayerOrPetInRaid(unit))
end
ScriptEnv.IsPet = IsPet

local function OfflineDuration(unit)
	local offline = offline_times[UnitGUID(unit)]
	offline_cache[ScriptEnv.font_string] = true
	if offline then
		UpdateIn(0.25)
		return GetTime() - offline
	end
end
ScriptEnv.OfflineDuration = OfflineDuration

local function Offline(unit)
 	local offline = OfflineDuration(unit)
	if offline then
		return L["Offline"]..' ('..FormatDuration(offline)..')'
	end
end
ScriptEnv.Offline = Offline

local function IsOffline(unit)
	offline_cache[ScriptEnv.font_string] = true
	return not not offline_times[UnitGUID(unit)]
end
ScriptEnv.IsOffline = IsOffline

local function DeadDuration(unit)
	local dead_time = dead_times[UnitGUID(unit)]
	dead_cache[ScriptEnv.font_string] = true
	if dead_time then
		UpdateIn(0.25)
		return GetTime() - dead_time
	end
end
ScriptEnv.DeadDuration = DeadDuration

local function Dead(unit)
	local dead_time = DeadDuration(unit) 
	local dead_type = (UnitIsGhost(unit) and L["Ghost"]) or (UnitIsDead(unit) and L["Dead"])
	if dead_time and dead_type then
		return dead_type..' ('..FormatDuration(dead_time)..')'
	elseif dead_type then
		return dead_type
	end
end
ScriptEnv.Dead = Dead 

local MOONKIN_FORM = GetSpellInfo(24858)
local AQUATIC_FORM = GetSpellInfo(1066)
local FLIGHT_FORM = GetSpellInfo(33943)
local SWIFT_FLIGHT_FORM = GetSpellInfo(40120)
local TRAVEL_FORM = GetSpellInfo(783)
local TREE_OF_LIFE, SHAPESHIFT = GetSpellInfo(33891)

local function DruidForm(unit)
	local _, class = UnitClass(unit)
	if class ~= "DRUID" then
		return nil
	end
	local power = UnitPowerType(unit)
	if power == 1 then
		return L["Bear"]
	elseif power == 3 then
		return L["Cat"]
	elseif UnitAura(unit,MOONKIN_FORM,SHAPESHIFT) then
		return L["Moonkin"]
	elseif UnitAura(unit,TREE_OF_LIFE,SHAPESHIFT) then
		return L["Tree"]
	elseif UnitAura(unit,TRAVEL_FORM,SHAPESHIFT) then
		return L["Travel"]
	elseif UnitAura(unit,AQUATIC_FORM,SHAPESHIFT) then
		return L["Aquatic"]
	elseif UnitAura(unit,SWIFT_FLIGHT_FORM,SHAPESHIFT) or UnitAura(unit,SWIFT_FLIGHT_FORM,SHAPESHFIT) then
		return L["Flight"]
	end
end
ScriptEnv.DruidForm = DruidForm

local DIVINE_INTERVENTION = GetSpellInfo(19752)
local function Status(unit)
	return Offline(unit) or UnitAura(unit,DIVINE_INTERVENTION) or (UnitIsFeignDeath(unit) and L["Feigned Death"]) or Dead(unit)
end
ScriptEnv.Status = Status

local function HP(unit)
	local hp = UnitHealth(unit)
	if hp == 1 and UnitIsGhost(unit) then
		return 0
	end
	return hp
end
ScriptEnv.HP = HP

-- Just use the Blizzard API no change needed
-- only reason this is here is for symmetry,
-- it feels weird to have HP (which we need
-- to avoid the hp = 1 while dead crap), but
-- not have MaxHP
local MaxHP = UnitHealthMax
ScriptEnv.MaxHP = MaxHP

local function Power(unit, power_type)
	local power = UnitPower(unit, power_type)
	
	-- Detect mana texts for player and pet units, cache the power
	-- and mark the font_strings for faster updating.  Allows
	-- smoothing updating of PowerBars.
	local guid = UnitGUID(unit)
	if power_type == nil or UnitPowerType(unit) == power_type then
		if guid == ScriptEnv.player_guid then
			ScriptEnv.player_power = power
		  power_cache[ScriptEnv.font_string] = true
		elseif guid == UnitGUID("pet") then
			ScriptEnv.pet_power = power
			power_cache[ScriptEnv.font_string] = true
		end
	end

	return power
end
ScriptEnv.Power = Power

-- more symmetry
local MaxPower = UnitPowerMax
ScriptEnv.MaxPower = MaxPower

local function Round(number, digits)
	if not digits then
		digits = 0
	end
	local mantissa = 10^digits
	local norm = number*mantissa + 0.5
	local norm_floor = math.floor(norm)
	if norm == norm_floor and (norm_floor % 2) == 1 then
		return (norm_floor-1) / mantissa
	else
		return norm_floor / mantissa
	end
end
ScriptEnv.Round = Round

local function Short(value,format)
	if type(value) == "number" then
		local fmt
		if value >= 10000000 or value <= -10000000 then
			fmt = "%.1fm"
			value = value / 1000000
		elseif value >= 1000000 or value <= -1000000 then
			fmt = "%.2fm"
			value = value / 1000000
		elseif value >= 100000 or value <= -100000 then
			fmt = "%.0fk"
			value = value / 1000
		elseif value >= 10000 or value <= -10000 then
			fmt = "%.1fk"
			value = value / 1000
		else
			fmt = "%d"
			value = math.floor(value+0.5)
		end
		if format then
			return fmt:format(value)
		else
			return fmt, value
		end
	else
		local fmt_a, fmt_b
		local a,b = value:match("^(%d+)/(%d+)$")
		if a then
			a, b = tonumber(a), tonumber(b)
			if a >= 10000000 or a <= -10000000 then
				fmt_a = "%.1fm"
				a = a / 1000000
			elseif a >= 1000000 or a <= -1000000 then
				fmt_a = "%.2fm"
				a = a / 1000000
			elseif a >= 100000 or a <= -100000 then
				fmt_a = "%.0fk"
				a = a / 1000
			elseif a >= 10000 or a <= -10000 then
				fmt_a = "%.1fk"
				a = a / 1000
			end
			if b >= 10000000 or b <= -10000000 then
				fmt_b = "%.1fm"
				b = b / 1000000
			elseif b >= 1000000 or b <= -1000000 then
				fmt_b = "%.2fm"
				b = b / 1000000
			elseif b >= 100000 or b <= -100000 then
				fmt_b = "%.0fk"
				b = b / 1000
			elseif b >= 10000 or b <= -10000 then
				fmt_b = "%.1fk"
				b = b / 1000
			end
			if format then
				return (fmt_a.."/"..fmt_b):format(a,b)
			else
				return fmt_a.."/"..fmt_b,a,b
			end
		else
			return value
		end
	end
end
ScriptEnv.Short = Short

local function VeryShort(value,format)
	if type(value) == "number" then
		local fmt
		if value >= 1000000 or value <= -1000000 then
			fmt = "%.0fm"
			value = value / 1000000
		elseif value >= 1000 or value <= -1000 then
			fmt = "%.0fk"
			value = value / 1000
		else
			fmt = "%.0f"
		end
		if format then
			return fmt:format(value)
		else
			return fmt, value
		end
	else
		local a,b = value:match("^(%d+)/(%d+)")
		if a then
			local fmt_a, fmt_b
			a, b = tonumber(a), tonumber(b)
			if b >= 1000000 or b <= -1000000 then
				fmt_b = "%.0fm"
				b = b / 1000000
			elseif b >= 1000 or b <= -1000 then
				fmt_b = "%.0fk"
				b = b / 1000
			end
			if a >= 1000000 or a <= -1000000 then
				fmt_a = "%.0fm"
				a = a / 1000000
			elseif a >= 1000 or a <= -1000 then
				fmt_a = "%.0fk"
				a = a / 1000
			end
			if format then
				return (fmt_a.."/"..fmt_b):format(a,b)
			else
				return fmt_a.."/"..fmt_b,a,b
			end
		else
			return value
		end
	end
end
ScriptEnv.VeryShort = VeryShort

local function IsMouseOver()
	local font_string = ScriptEnv.font_string
	local frame = font_string.frame
	mouseover_check_cache[font_string] = frame
	return PitBull4_LuaTexts.mouseover == frame 
end
ScriptEnv.IsMouseOver = IsMouseOver

local function Combos(unit, target)
	if unit and target then
		return GetComboPoints(unit, target)
	else
		return GetComboPoints(UnitHasVehicleUI("player") and "vehicle" or "player", "target")
	end
end
ScriptEnv.Combos = Combos

local function ComboSymbols(symbol, unit, target)
	if not symbol then
		symbol = '@'
	end
	return string.rep(symbol,Combos(unit,target))
end
ScriptEnv.ComboSymbols = ComboSymbols

local function Percent(x, y)
	if y ~= 0 then
		return Round(x / y * 100,1)
	else
		return 0
	end
end
ScriptEnv.Percent = Percent

local function XP(unit)
	if unit == "player" then
		return UnitXP(unit)
	elseif unit == "pet" or unit == "playerpet" then
		return GetPetExperience()
	else
		return 0
	end
end
ScriptEnv.XP = XP

local function MaxXP(unit)
	if unit == "player" then
		return UnitXPMax(unit)
	elseif unit == "pet" or unit == "playerpet" then
		local _, max = GetPetExperience()
		return max
	else
		return 0
	end
end
ScriptEnv.MaxXP = MaxXP

local function RestXP(unit)
	if unit == "player" then
		return GetXPExhaustion() or 0
	else
		return 0
	end
end
ScriptEnv.RestXP = RestXP

local function ThreatPair(unit)
	if UnitIsFriend("player", unit) then
		if UnitExists("target") then
			return unit, "target"
		else
			return
		end
	else
		return "player", unit
	end
end
ScriptEnv.ThreatPair = ThreatPair

local function ThreatStatusColor(status)
	local r, g, b = GetThreatStatusColor(status)
	return r * 255, g * 255, b * 255
end
ScriptEnv.ThreatStatusColor = ThreatStatusColor

local function CastData(unit)
	spell_cast_cache[ScriptEnv.font_string] = true
	return cast_data[UnitGUID(unit)]
end
ScriptEnv.CastData = CastData

local function Alpha(number)
	if number > 1 then
		number = 1
	elseif number < 0 then
		number = 0
	end
	PitBull4_LuaTexts.alpha = number
end
ScriptEnv.Alpha = Alpha

local function Outline()
	PitBull4_LuaTexts.outline = "OUTLINE"
end
ScriptEnv.Outline = Outline

local function ThickOutline()
	PitBull4_LuaTexts.outline = "OUTLINE, THICKOUTLINE"
end
ScriptEnv.ThickOutline = ThickOutline

local function abbreviate(text)
	local b = text:byte(1)
	if b <= 127 then
		return text:sub(1, 1)
	elseif b <= 223 then
		return text:sub(1, 2)
	elseif b <= 239 then
		return text:sub(1, 3)
	else
		return text:sub(1, 4)
	end
end
local function Abbreviate(value)
    if value:find(" ") then
      return value:gsub(" *([^ ]+) *", abbreviate)
    else
      return value
    end
end
ScriptEnv.Abbreviate = Abbreviate

local function PVPDuration(unit)
	if unit and not UnitIsUnit(unit,"player") then return end
  if IsPVPTimerRunning() then
		UpdateIn(0.25)
		return GetPVPTimer()/1000
	end
end
ScriptEnv.PVPDuration = PVPDuration

local function HPColor(cur, max)
	local perc = cur / max
	local r1, g1, b1
	local r2, g2, b2
	if perc <= 0.5 then
		perc = perc * 2
		r1, g1, b1 = 1, 0, 0  -- TODO: Let these be configurable?
		r2, g2, b2 = 1, 1, 0 
	else
		perc = perc * 2 - 1
		r1, g1, b1 = 1, 1, 0 
		r2, g2, b2 = 0, 1, 0 
	end
	local r, g, b = r1 + (r2 - r1)*perc, g1 + (g2 - g1)*perc, b1 + (b2 - b1)*perc
	if r < 0 then
		r = 0
	elseif r > 1 then
		r = 1
	end
	if g < 0 then
		g = 0
	elseif g > 1 then
		g = 1
	end
	if b < 0 then
		b = 0
	elseif b > 1 then
		b = 1
	end
	return r * 255, g * 255, b * 255
end
ScriptEnv.HPColor = HPColor

local function PowerColor(power_type)
	local color = PitBull4.PowerColors[power_type]
	local r,g,b
	if color then
		r, g, b = color[1],color[2],color[3]
	else
		r, g, b = 0.7, 0.7, 0.7
	end
	return r * 255, g * 255, b * 255
end
ScriptEnv.PowerColor = PowerColor

local function ReputationColor(reaction)
  local color = FACTION_BAR_COLORS[reaction]
	if color then
		return color.r * 255, color.g * 255, color.b * 255
	end
end
ScriptEnv.ReputationColor = ReputationColor

local function ConfigMode()
	local font_string = ScriptEnv.font_string
	local frame = font_string.frame
	if frame.force_show then
		return '{'..font_string.luatexts_name..'}'
	end
end
ScriptEnv.ConfigMode = ConfigMode
