if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_LuaTexts requires PitBull4")
end

local L = PitBull4.L

local PitBull4_LuaTexts = PitBull4:NewModule("LuaTexts","AceEvent-3.0","AceHook-3.0")

local texts = {}
local no_update = {}
local event_cache = {}
local func_cache = {}
local power_cache = {}
PitBull4_LuaTexts.power_cache = power_cache
local mouseover_check_cache = {}
PitBull4_LuaTexts.mouseover_check_cache = mouseover_check_cache
local spell_cast_cache = {}
PitBull4_LuaTexts.spell_cast_cache = spell_cast_cache
local cast_data = {}
PitBull4_LuaTexts.cast_data = cast_data
local to_update = {}
PitBull4_LuaTexts.to_update = to_update
local afk_cache = {}
PitBull4_LuaTexts.afk_cache = afk_cache
local dnd_cache = {}
PitBull4_LuaTexts.dnd_cache = dnd_cache
local offline_cache = {}
PitBull4_LuaTexts.offline_cache = offline_cache
local dead_cache = {}
PitBull4_LuaTexts.dead_cache = dead_cache
local offline_times = {}
PitBull4_LuaTexts.offline_times = offline_times
local afk_times = {}
PitBull4_LuaTexts.afk_times = afk_times
local dnd = {}
PitBull4_LuaTexts.dnd = dnd
local dead_times = {}
PitBull4_LuaTexts.dead_times = dead_times
local player_guid
local predicted_power = true

local PROVIDED_CODES = {
	[L["Class"]] = {
		[L["Standard"]] = {
			events = {['UNIT_CLASSIFICATION_CHANGED']=true,['UNIT_LEVEL']=true,['UNIT_AURA']=true},
			code = [[
local dr,dg,db = DifficultyColor(unit)
local form = DruidForm(unit)
local classification = Classification(unit)
if UnitIsPlayer(unit) or (not UnitIsFriend(unit,"player") and not IsPet(unit)) then
  local cr,cg,cb = ClassColor(unit)
  if form then
    return "%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''
  else
    return "%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''
  end
else
  if form then
    return "%s%s|cff%02x%02x%02x%s|r (%s) %s",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''
  else
    return "%s%s|cff%02x%02x%02x%s|r %s",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''
  end
end]],
		},
		[L["Player classes only"]] = {
			events = {['UNIT_CLASSIFICATION_CHANGED']=true,['UNIT_LEVEL']=true,['UNIT_AURA']=true},
			code = [[
local dr,dg,db = DifficultyColor(unit)
local form = DruidForm(unit)
local classification = Classification(unit)
if UnitIsPlayer(unit) then
  local cr,cg,cb = ClassColor(unit)
  if form then
    return "%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''
  else
    return "%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''
  end
else
  if form then
    return "%s%s|cff%02x%02x%02x%s|r (%s) %s",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''
  else
    return "%s%s|cff%02x%02x%02x%s|r %s",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''
  end
end]],
		},
		[L["Short level and race"]] = {
			events = {['UNIT_CLASSIFICATION_CHANGED']=true,['UNIT_LEVEL']=true},
			code = [[
local dr,dg,db = DifficultyColor(unit)
return "|cff%02x%02x%02x%s%s|r %s",dr,dg,db,Level(unit),Classification(unit) and '+' or '',SmartRace(unit) or '']],
		},
		[L["Short"]] = {
			events = {},
			code = [[
if UnitIsPlayer(unit) then
  local cr,cg,cb = ClassColor(unit)
  return "|cff%02x%02x%02x%s|r",cr,cg,cb,Class(unit)
end]],
		},
	},
	[L["Health"]] = {
		[L["Absolute"]] = {
			events = {['UNIT_HEALTH']=true,['UNIT_MAXHEALTH']=true,['UNIT_AURA']=true},
			code = [[
local s = Status(unit)
if s then
  return s
end
return "%s/%s",HP(unit),MaxHP(unit)]],
		},
		[L["Absolute short"]] = {
			events = {['UNIT_HEALTH']=true,['UNIT_MAXHEALTH']=true,['UNIT_AURA']=true},
			code = [[
local s = Status(unit)
if s then
  return s
end
return "%s/%s",Short(HP(unit),true),Short(MaxHP(unit),true)]],
		},
		[L["Difference"]] = {
			events = {['UNIT_HEALTH']=true,['UNIT_MAXHEALTH']=true,['UNIT_AURA']=true},
			code = [[
local s = Status(unit)
if s then
  return s
end
local miss = MaxHP(unit) - HP(unit) 
if miss ~= 0 then
  return "-%d",miss
end]],
		},
		[L["Percent"]] = {
			events = {['UNIT_HEALTH']=true,['UNIT_MAXHEALTH']=true,['UNIT_AURA']=true},
			code = [[
local s = Status(unit)
if s then
  return s
end
return "%s%%",Percent(HP(unit),MaxHP(unit))]],
		},
		[L["Mini"]] = {
			events = {['UNIT_HEALTH']=true,['UNIT_MAXHEALTH']=true},
			code = [[
return VeryShort(HP(unit))]],
		},
		[L["Smart"]] = {
			events = {['UNIT_HEALTH']=true,['UNIT_MAXHEALTH']=true,['UNIT_AURA']=true},
			code = [[
local s = Status(unit)
if s then
  return s
end
local cur, max = HP(unit), MaxHP(unit)
if UnitIsFriend(unit,"player") then
  local miss = max - cur 
  if miss ~= 0 then
    return "|cffff7f7f%d|r",miss
  else
    return ''
  end
else
  return "%s/%s",Short(cur,true),Short(max,true)
end]],
		},
		[L["Absolute and percent"]] = {
			events = {['UNIT_HEALTH']=true,['UNIT_MAXHEALTH']=true,['UNIT_AURA']=true},
			code = [[
local s = Status(unit)
if s then
  return s
end
local cur, max = HP(unit), MaxHP(unit)
return "%s/%s || %s%%",Short(cur,true),Short(max,true),Percent(cur,max)]],
		},
		[L["Informational"]] = {
			events = {['UNIT_HEALTH']=true,['UNIT_MAXHEALTH']=true,['UNIT_AURA']=true},
			code = [[
local s = Status(unit)
if s then
  return s
end
local cur, max = HP(unit), MaxHP(unit)
if UnitIsFriend(unit,"player") then
  local miss = max - cur 
  if miss ~= 0 then
    return "|cffff7f7f%s|r || %s/%s || %s%%",Short(miss,true),Short(cur,true),Short(max,true),Percent(cur,max)
  end
end
return "%s/%s || %s%%",Short(cur,true),Short(max,true),Percent(cur,max)]],
		},
	},
	[L["Name"]] = {
		[L["Standard"]] = {
			events = {['UNIT_NAME_UPDATE']=true,['PLAYER_FLAGS_CHANGED'] = true},
			code = [[
return '%s %s%s%s',Name(unit),Angle(AFK(unit) or DND(unit))]],
		},
		[L["Hostility-colored"]] = {
			events = {['UNIT_NAME_UPDATE']=true,['PLAYER_FLAGS_CHANGED'] = true,['UNIT_FACTION']=true},
			code = [[
local r,g,b = HostileColor(unit)
return '|cff%02x%02x%02x%s|r %s%s%s',r,g,b,Name(unit),Angle(AFK(unit) or DND(unit))]],
		},
		[L["Class-colored"]] = {
			events = {['UNIT_NAME_UPDATE']=true,['PLAYER_FLAGS_CHANGED'] = true},
			code = [[
local r,g,b = ClassColor(unit)
return '|cff%02x%02x%02x%s|r %s%s%s',r,g,b,Name(unit),Angle(AFK(unit) or DND(unit))]],
		},
		[L["Long"]] = {
			events = {['UNIT_NAME_UPDATE']=true,['PLAYER_FLAGS_CHANGED'] = true,['UNIT_LEVEL']=true},
			code = [[
local r,g,b = ClassColor(unit)
return '%s |cff%02x%02x%02x%s|r %s%s%s',Level(unit),r,g,b,Name(unit),Angle(AFK(unit) or DND(unit))]],
		},
		[L["Long w/ Druid form"]] = {
			events = {['UNIT_NAME_UPDATE']=true,['PLAYER_FLAGS_CHANGED'] = true,['UNIT_LEVEL']=true,['UNIT_AURA']=true},
			code = [[
local r,g,b = ClassColor(unit)
local form = DruidForm(unit)
if form then
  return '%s |cff%02x%02x%02x%s|r (%s) %s%s%s',Level(unit),r,g,b,Name(unit),form,Angle(AFK(unit) or DND(unit))
else
  return '%s |cff%02x%02x%02x%s|r %s%s%s',Level(unit),r,g,b,Name(unit),Angle(AFK(unit) or DND(unit))
end]],
		},
	},
	[L["Power"]] = {
		[L["Absolute"]] = {
			events = {['UNIT_MANA']=true,['UNIT_RAGE']=true,['UNIT_FOCUS']=true,['UNIT_ENERGY']=true,['UNIT_RUNIC_POWER']=true,['UNIT_MAXMANA']=true,['UNIT_MAXRAGE']=true,['UNIT_MAXFOCUS']=true,['UNIT_MAXENERGY']=true,['UNIT_MAXRUNIC_POWER']=true,['UNIT_DISPLAYPOWER']=true},
			code = [[
local max = MaxPower(unit)
if max > 0 then
  return "%s/%s",Power(unit),max
end]],
		},
		[L["Absolute short"]] = {
			events = {['UNIT_MANA']=true,['UNIT_RAGE']=true,['UNIT_FOCUS']=true,['UNIT_ENERGY']=true,['UNIT_RUNIC_POWER']=true,['UNIT_MAXMANA']=true,['UNIT_MAXRAGE']=true,['UNIT_MAXFOCUS']=true,['UNIT_MAXENERGY']=true,['UNIT_MAXRUNIC_POWER']=true,['UNIT_DISPLAYPOWER']=true},
			code = [[
local max = MaxPower(unit)
if max > 0 then
  return "%s/%s",Short(Power(unit),true),Short(max,true)
end]],
		},
		[L["Difference"]] = {
			events = {['UNIT_MANA']=true,['UNIT_RAGE']=true,['UNIT_FOCUS']=true,['UNIT_ENERGY']=true,['UNIT_RUNIC_POWER']=true,['UNIT_MAXMANA']=true,['UNIT_MAXRAGE']=true,['UNIT_MAXFOCUS']=true,['UNIT_MAXENERGY']=true,['UNIT_MAXRUNIC_POWER']=true,['UNIT_DISPLAYPOWER']=true},
			code = [[
return "-%d",MaxPower(unit) - Power(unit)]],
		},
		[L["Percent"]] = {
			events = {['UNIT_MANA']=true,['UNIT_RAGE']=true,['UNIT_FOCUS']=true,['UNIT_ENERGY']=true,['UNIT_RUNIC_POWER']=true,['UNIT_MAXMANA']=true,['UNIT_MAXRAGE']=true,['UNIT_MAXFOCUS']=true,['UNIT_MAXENERGY']=true,['UNIT_MAXRUNIC_POWER']=true,['UNIT_DISPLAYPOWER']=true},
			code = [[
local max = MaxPower(unit)
if max > 0 then
  return "%s%%",Percent(Power(unit),max)
end]],
		},
		[L["Absolute and percent"]] = {
			events = {['UNIT_MANA']=true,['UNIT_RAGE']=true,['UNIT_FOCUS']=true,['UNIT_ENERGY']=true,['UNIT_RUNIC_POWER']=true,['UNIT_MAXMANA']=true,['UNIT_MAXRAGE']=true,['UNIT_MAXFOCUS']=true,['UNIT_MAXENERGY']=true,['UNIT_MAXRUNIC_POWER']=true,['UNIT_DISPLAYPOWER']=true},
			code = [[
local cur,max = Power(unit),MaxPower(unit)
if max > 0 then
  return "%s/%s || %s%%",cur,max,Percent(cur,max)
end]],
		},
		[L["Mini"]] = {
			events = {['UNIT_MANA']=true,['UNIT_RAGE']=true,['UNIT_FOCUS']=true,['UNIT_ENERGY']=true,['UNIT_RUNIC_POWER']=true,['UNIT_MAXMANA']=true,['UNIT_MAXRAGE']=true,['UNIT_MAXFOCUS']=true,['UNIT_MAXENERGY']=true,['UNIT_MAXRUNIC_POWER']=true,['UNIT_DISPLAYPOWER']=true},
			code = [[
local max = MaxPower(unit)
if max > 0 then
  return VeryShort(Power(unit))
end]],
		},
		[L["Smart"]] = {
			events = {['UNIT_MANA']=true,['UNIT_RAGE']=true,['UNIT_FOCUS']=true,['UNIT_ENERGY']=true,['UNIT_RUNIC_POWER']=true,['UNIT_MAXMANA']=true,['UNIT_MAXRAGE']=true,['UNIT_MAXFOCUS']=true,['UNIT_MAXENERGY']=true,['UNIT_MAXRUNIC_POWER']=true,['UNIT_DISPLAYPOWER']=true},
			code = [[
local miss = MaxPower(unit) - Power(unit)
if miss ~= 0 then
  return "|cff7f7fff%s|r",Short(miss,true)
end]],
		},
	},
	[L["Druid mana"]] = {
		[L["Absolute"]] = {
			events = {['UNIT_MANA']=true,['UNIT_MAXMANA']=true},
			code = [[
if UnitPowerType(unit) ~= 0 then
  return "%s/%s",Power(unit,0),MaxPower(unit,0)
end]],
		},
		[L["Absolute short"]] = {
			events = {['UNIT_MANA']=true,['UNIT_MAXMANA']=true},
			code = [[
if UnitPowerType(unit) ~= 0 then
  return "%s/%s",Short(Power(unit,0),true),Short(MaxPower(unit,0),true)
end]],
		},
		[L["Difference"]] = {
			events = {['UNIT_MANA']=true,['UNIT_MAXMANA']=true},
			code = [[
if UnitPowerType(unit) ~= 0 then
  return -(MaxPower(unit,0) - Power(unit,0))
end]],
		},
		[L["Percent"]] = {
			events = {['UNIT_MANA']=true,['UNIT_MAXMANA']=true},
			code = [[
if UnitPowerType(unit) ~= 0 then
  local max = MaxPower(unit,0)
  if max > 0 then
    return "%s%%",Percent(Power(unit,0),max)
  end
end]],
		},
		[L["Mini"]] = {
			events = {['UNIT_MANA']=true,['UNIT_MAXMANA']=true},
			code = [[
if UnitPowerType(unit) ~= 0 then
  return VeryShort(Power(unit,0))
end]],
		},
		[L["Smart"]] = {
			events = {['UNIT_MANA']=true,['UNIT_MAXMANA']=true},
			code = [[
if UnitPowerType(unit) ~= 0 then
  local miss = MaxPower(unit,0) - Power(unit,0)
  if miss ~= 0 then
    return "|cff7f7fff%s|r",Short(miss,true)
  end
end]],
		},
	},
	[L["Threat"]] = {
		[L["Percent"]] = {
			events = {['UNIT_THREAT_LIST_UPDATE']=true,['UNIT_THREAT_SITUATION_UPDATE']=true},
			code = [[
local unit_a,unit_b = ThreatPair(unit)
if unit_a and unit_b then
  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)
  if percent and percent ~= 0 then
    return "%s%%",Round(percent,1)
  end
end
return ConfigMode()]],
		},
		[L["Raw percent"]] = {
			events = {['UNIT_THREAT_LIST_UPDATE']=true,['UNIT_THREAT_SITUATION_UPDATE']=true},
			code = [[
local unit_a,unit_b = ThreatPair(unit)
if unit_a and unit_b then
  local _,_,_,raw_percent = UnitDetailedThreatSituation(unit_a, unit_b)
    if raw_percent and raw_percent ~= 0 then
    return "%s%%",Round(raw_percent,1)
  end
end
return ConfigMode()]],
		},
		[L["Colored percent"]] = {
			events = {['UNIT_THREAT_LIST_UPDATE']=true,['UNIT_THREAT_SITUATION_UPDATE']=true},
			code = [[
local unit_a,unit_b = ThreatPair(unit)
if unit_a and unit_b then
  local _,status,percent = UnitDetailedThreatSituation(unit_a, unit_b)
  if percent and percent ~= 0 then
    local r,g,b = ThreatStatusColor(status)
    return "|cff%02x%02x%02x%s%%|r",r,g,b,Round(percent,1)
  end
end
return ConfigMode()]],
		},
		[L["Colored raw percent"]] = {
			events = {['UNIT_THREAT_LIST_UPDATE']=true,['UNIT_THREAT_SITUATION_UPDATE']=true},
			code = [[
local unit_a,unit_b = ThreatPair(unit)
if unit_a and unit_b then
  local _,status,_,raw_percent = UnitDetailedThreatSituation(unit_a, unit_b)
  if raw_percent and raw_percent ~= 0 then
    local r,g,b = ThreatStatusColor(status)
    return "|cff%02x%02x%02x%s%%|r",r,g,b,Round(raw_percent,1)
  end
end
return ConfigMode()]],
		},
	},
	[L["Combo points"]] = {
		[L["Standard"]] = {
			events = {['UNIT_COMBO_POINTS']=true},
			code = [[
local combos = Combos()
if combos ~= 0 then
  return combos
end]],
		},
	},
	[L["Experience"]] = {
		[L["Standard"]] = {
			events = {['UNIT_PET_EXPERIENCE']=true,['PLAYER_XP_UPDATE']=true},
			code = [[
local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)
if rest then
  return "%s/%s (%s%%) R: %s%%",cur,max,Percent(cur,max),Percent(rest,max)
else
  return "%s/%s (%s%%)",cur,max,Percent(cur,max)
end]],
		},
		[L["On mouse-over"]] = {
			events = {['UNIT_PET_EXPERIENCE']=true,['PLAYER_XP_UPDATE']=true},
			code = [[
if IsMouseOver() then
  local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)
  if rest then
    return "%s/%s (%s%%) R: %s%%",cur,max,Percent(cur,max),Percent(rest,max)
  else
    return "%s/%s (%s%%)",cur,max,Percent(cur,max)
  end
end]],
		},
	},
	[L["Reputation"]] = {
		[L["Standard"]] = {
			events = {['UNIT_FACTION']=true,['UPDATE_FACTION']=true},
			code = [[
local name,_,min,max,value = GetWatchedFactionInfo()
if IsMouseOver() then
  return name or ConfigMode() 
else
  local bar_cur,bar_max = value-min,max-min
  return "%d/%d (%s%%)",bar_cur,bar_max,Percent(bar_cur,bar_max)
end]],
		},
	},
	[L["PVPTimer"]] = {
		[L["Standard"]] = {
			events = {['PLAYER_FLAGS_CHANGED']=true},
			code = [[
if unit == "player" then
  local pvp = PVPDuration()
  if pvp then
    return "|cffff0000%s|r",FormatDuration(pvp)
  end
end]],
		},
	},
	[L["Cast"]] = {
		[L["Standard name"]] = {
			events = {['UNIT_SPELLCAST_START']=true,['UNIT_SPELLCAST_CHANNEL_START']=true,['UNIT_SPELLCAST_STOP']=true,['UNIT_SPELLCAST_FAILED']=true,['UNIT_SPELLCAST_INTERRUPTED']=true,['UNIT_SPELLCAST_SUCCEEDED']=true,['UNIT_SPELLCAST_DELAYED']=true,['UNIT_SPELLCAST_CHANNEL_UPDATE']=true,['UNIT_SPELLCAST_CHANNEL_STOP']=true},
			code = [[
local cast_data = CastData(unit)
if cast_data then
  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target
  local stop_time,stop_duration = cast_data.stop_time
  if stop_time then
    stop_duration = GetTime() - stop_time
  end
  Alpha(-(stop_duration or 0) + 1)
  if stop_message then
    return stop_message
  elseif target then
    return "%s (%s)",spell,target
  else
    return spell 
  end
end
return ConfigMode()]],
		},
		[L["Standard time"]] = {
			events = {['UNIT_SPELLCAST_START']=true,['UNIT_SPELLCAST_CHANNEL_START']=true,['UNIT_SPELLCAST_STOP']=true,['UNIT_SPELLCAST_FAILED']=true,['UNIT_SPELLCAST_INTERRUPTED']=true,['UNIT_SPELLCAST_DELAYED']=true,['UNIT_SPELLCAST_CHANNEL_UPDATE']=true,['UNIT_SPELLCAST_CHANNEL_STOP']=true},
			code = [[
local cast_data = CastData(unit)
if cast_data then
  if not cast_data.stop_time then
    local delay,end_time = cast_data.delay, cast_data.end_time
    local duration
    if end_time then
      duration = end_time - GetTime()
    end
    if delay and delay ~= 0 then
      local delay_sign = '+'
      if delay < 0 then
        delay_sign = ''
      end
      if duration and duration >= 0 then
        return "|cffff0000%s%s|r %.1f",delay_sign,Round(delay,1),duration
      else
        return "|cffff0000%s%s|r",delay_sign,Round(delay,1)
      end
    elseif duration and duration >= 0 then
      return "%.1f",duration
    end
  end
end
return ConfigMode()]],
		},
	},
}

PitBull4_LuaTexts:SetModuleType("text_provider")
PitBull4_LuaTexts:SetName(L["Lua texts"])
PitBull4_LuaTexts:SetDescription(L["Text provider using Lua scripts to generate texts."])

do
	-- Build the event defaults
	local events = {
		-- Harcoded events basically the ones that aren't just unit=true ones
		['UNIT_PET_EXPERIENCE'] = {pet=true},
		['PLAYER_XP_UPDATE'] = {player=true},
		['UNIT_COMBO_POINTS'] = {all=true},
		['UPDATE_FACTION'] = {all=true},

		-- They pass the unit but they don't provide the pairing (e.g.
		-- the target changes) so we'll miss updates if we don't update
		-- every text on every one of these events.  /sigh
		['UNIT_THREAT_LIST_UPDATE'] = {all=true},
		['UNIT_THREAT_SITUATION_UPDATE'] = {all=true},
	}

	-- Iterate the provided codes to fill in all the rest
	for base, codes in pairs(PROVIDED_CODES) do
		for name, entry in pairs(codes) do
			for event in pairs(entry.events) do
				if not events[event] then
					events[event] = {unit=true}
				end
			end
		end
	end

	PitBull4_LuaTexts:SetDefaults({
		elements = {
			['**'] = {
				size = 1,
				attach_to = "root",
				location = "edge_top_left",
				position = 1,
				exists = false,
				code = "",
				events = {},
				enabled = true,
			}
		},
		first = true
	},
	{
		-- Global defaults
		events = events,
	})
end

-- These events should never have the event unregistered unless
-- the module is disabled.  In general they are needed for support
-- for things that cannot be cleaned on an as needed basis and
-- require very little actual processing time.
local protected_events = {
	['UNIT_SPELLCAST_SENT'] = true,
	['PARTY_MEMBERS_CHANGED'] = true,
}

local timerframe = CreateFrame("Frame")
PitBull4_LuaTexts.timerframe = timerframe
timerframe:Hide()

function PitBull4_LuaTexts:SetCVar()
	predicted_power = GetCVarBool("predictedPower")
end

-- Fix a typo in the original default event names. 
-- s/UNIT_HEALTHMAX/UNIT_MAXHEALTH/
local function fix_unit_healthmax()
	local sv = PitBull4.db:GetNamespace("LuaTexts").profiles
	for _,profile in pairs(sv) do
		if profile.global then
			local events = profile.global.events
			if events then
				local old_event = events.UNIT_HEALTHMAX
				if not events.UNIT_MAXHEALTH and old_event then
					events.UNIT_MAXHEALTH = old_event
					events.UNIT_HEALTHMAX = nil
				end
			end
		end
		local layouts = profile.layouts
		if layouts then
			for _,layout in pairs(layouts) do	
				local elements = layout.elements
				if elements then
					for _,text in pairs(elements)	do
						local events = text.events
						if events then
							local old_event = events.UNIT_HEALTHMAX
							if not events.UNIT_MAXHEALTH and old_event then
								events.UNIT_MAXHEALTH = old_event
								events.UNIT_HEALTHMAX = nil
							end
						end
					end
				end
			end
		end
	end
end

function PitBull4_LuaTexts:OnEnable()
	fix_unit_healthmax()

	-- UNIT_SPELLCAST_SENT has to always be registered so we can capture 
	-- additional data not always available.
	self:RegisterEvent("UNIT_SPELLCAST_SENT")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED")

	-- Cache the player's guid for later use
	player_guid = UnitGUID("player")
	PitBull4.LuaTexts.ScriptEnv.player_guid = player_guid

	self:SecureHook("SetCVar")
	self:SetCVar()

	timerframe:Show()
end

function PitBull4_LuaTexts:OnDisable()
	timerframe:Hide()
end

local function set_text(font_string, ...)
	local success = select(1,...) -- first arg is true if user code was successful
	if not success then
		geterrorhandler()(select(2,...))
		font_string:SetText("{err}")
	elseif select('#',...) > 1 and select(2,...) ~= nil then
		local success, err = pcall(font_string.SetFormattedText,font_string,select(2,...))
		if not success then
--			print(select(2,...))
			-- hack to add the name of the text that caused the error to the error message and
			-- to fix the ? for the name of the function we're calling.  xpcall would handle
			-- the latter for us but it requires a lot of overhead that's just not worth it.
			local output = "PitBull4_LuaTexts:"..font_string.frame.layout..":"..font_string.luatexts_name.." caused the following error:\n"..err:gsub("'%?'","'SetFormattedText'")
			geterrorhandler()(output)
			font_string:SetText("{err}")
		end
	else
		-- not enough parameters so just set an empty string
		font_string:SetText('')
	end
end

local lua_name = "Lua:"..L["Name"]
local function update_text(font_string, event)
	if not texts[font_string] then return end
	if no_update[font_string] then return end
	local code = font_string.db.code
	local frame = font_string.frame
	local name = font_string.luatexts_name
	local unit = frame.unit
	local func = func_cache[code]
	local ScriptEnv = PitBull4_LuaTexts.ScriptEnv
--	print(string.format("%q %q %q %q",name,font_string:GetName(),frame:GetName(),unit))

	if (frame.force_show and not frame.guid and name ~= L["Name"] and name ~= lua_name) or not unit then
		font_string:SetFormattedText("{%s}",font_string.luatexts_name)
		return
	end

	if not func then
		-- Doesn't exist in the cache so we build it
		local lua_string = 'return function(unit) '..code..' end'
		local lua_string_name = "PitBull4_LuaTexts:"..frame.layout..':'..font_string.luatexts_name
		local create_func, err = loadstring(lua_string,lua_string_name)
		if create_func then
			-- note the following call is always safe, the only actual code executing is the
			-- return of the function wrapper that's hard coded above.  So no error handling
			-- needed.
			func = create_func()
			setfenv(func,ScriptEnv)
			func_cache[code] = func
		else
			geterrorhandler()(err)
			font_string:SetText("{err}")
			return
		end
	end

	-- Put the font_string and event into the ScriptEnv before running the
	-- user function so we can have access to it without actually requiring
	-- it to be passed to our utility functions.
	ScriptEnv.font_string = font_string
	ScriptEnv.event = event

	-- Set alpha and outline to default values
	PitBull4_LuaTexts.alpha = 1
	PitBull4_LuaTexts.outline = nil

	set_text(font_string,pcall(func,unit))
	local font,size = font_string:GetFont()
	font_string:SetFont(font,size,PitBull4_LuaTexts.outline)
	font_string:SetAlpha(PitBull4_LuaTexts.alpha)
end

local next_spell, next_rank, next_target
function PitBull4_LuaTexts:UNIT_SPELLCAST_SENT(event, unit, spell, rank, target)
	if unit ~= "player" then return end

	next_spell = spell
	next_rank = rank and tonumber(rank:match("%d+"))
	next_target = target ~= "" and target or nil
end

local pool = setmetatable({}, {__mode='k'})
local function new()
	local t = next(pool)
	if t then
		pool[t] = nil
	else
		t = {}
	end
	return t
end

local function del(t)
	wipe(t)
	pool[t] = true
	return nil
end

local function copy(t)
	local n = {}
	for k,v in pairs(t) do
		n[k] = v
	end
	return n
end

local function update_cast_data(event, unit, event_spell, event_rank, event_cast_id)
	local guid = UnitGUID(unit)
	if not guid then return end
	local data = cast_data[guid]
	if not data then
		data = new()
		cast_data[guid] = data
	end

	local spell, rank, name, icon, start_time, end_time, is_trade_skill, cast_id, interrupt = UnitCastingInfo(unit)
	local channeling = false
	if not spell then
		spell, rank, name, icon, start_time, end_time, uninterruptble = UnitChannelInfo(unit)
		channeling = true
	end
	if spell then
		data.spell = spell
		rank = rank and tonumber(rank:match("%d+"))
		data.rank = rank
		local old_start = data.start_time
		start_time = start_time * 0.001
		data.start_time = start_time
		data.end_time = end_time * 0.001
		if event == "UNIT_SPELLCAST_DELAYED" or event == "UNIT_SPELLCAST_CHANNEL_UPDATE" then
			data.delay = (data.delay or 0) + (start_time - (old_start or start_time))
		else
			data.delay = 0
		end
		if guid == player_guid and spell == next_spell and rank == next_rank then
			data.target = next_target
		end
		data.casting = not channeling
		data.channeling = channeling
		data.fade_out = false
		data.interruptible = not uninterruptible
		if event ~= "UNIT_SPELLCAST_INTERRUPTED" then
			-- We can't update the cache of the cast_id on UNIT_SPELLCAST_INTERRUPTED  because
			-- for whatever reason it ends up giving us 0 inside this event.
			data.cast_id = cast_id
		end
		data.stop_time = nil
		data.stop_message = nil
		return
	end
	if not data.spell then
		cast_data[guid] = del(data)
		return
	end

	if data.cast_id == event_cast_id then
		-- The event was for the cast we're current casting
		if event == "UNIT_SELLCAST_FAILED" then
			data.stop_message = _G.FAILED
		elseif event == "UNIT_SPELLCAST_INTERRUPTED" then
			data.stop_message = _G.INTERRUPTED
		elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
			-- Sometimes the interrupt event happens just before the
			-- success event so clear the stop_message if we get succeded.
			data.stop_message = nil
		end
	end

	data.casting = false
	data.channeling = false
	data.fade_out = true
	if not data.stop_time then
		data.stop_time = GetTime()
	end
end

local tmp = {}
local function fix_cast_data()
	local frame
	local current_time = GetTime()
	for guid, data in pairs(cast_data) do
		tmp[guid] = data
	end
	for guid, data in pairs(tmp) do
		if data.casting then
			if current_time > data.end_time and player_guid ~= guid then
				data.casting = false
				data.fade_out = true
				data.stop_time = current_time
			end
		elseif data.channeling then
			if current_time > data.end_time then
				data.channeling = false
				data.fade_out = true
				data.stop_time = current_time
			end
		elseif data.fade_out then
			local alpha = 0
			local stop_time = data.stop_time
			if stop_time then
				alpha = stop_time - current_time + 1
			end

			if alpha <0 then
				cast_data[guid] = del(data)
			end
		else
			cast_data[guid] = del(date)
		end
		local found = false
		for font_string in pairs(spell_cast_cache) do
			if guid == font_string.frame.guid then
				found = true
				to_update[font_string] = 0 -- update now 
			end
		end
		if not found then
			if cast_data[guid] then
				cast_data[guid] = del(data)
			end
		end
	end
	wipe(tmp)
end

local group_members = {}
local first = true
local function update_timers()
	if first then
		first = false
		PitBull4_LuaTexts:PARTY_MEMBERS_CHANGED()
	end
	for unit, guid in pairs(group_members) do 
		if not UnitIsConnected(unit) then
			if not offline_times[guid] then
				offline_times[guid] = GetTime()
				for font_string in pairs(offline_cache) do
					if font_string.frame.guid == guid then
						to_update[font_string] = 0
					end
				end
			end
			afk_times[guid] = nil
			if dnd[guid] then
				dnd[guid] = nil
				for font_string in pairs(dnd_cache) do
					if font_string.frame.guid == guid then
						to_update[font_string] = 0
					end
				end
			end
		else
			offline_times[guid] = nil
			if UnitIsAFK(unit) then
				if not afk_times[guid] then
					afk_times[guid] = GetTime()
					for font_string in pairs(afk_cache) do
						if font_string.frame.guid == guid then
							to_update[font_string] = 0
						end
					end
				end
			else
				afk_times[guid] = nil
				local dnd_change = false
				if UnitIsDND(unit) then
					if not dnd[guid] then
						dnd[guid] = true
						dnd_change = true
					end
				else
					if dnd[guid] then
						dnd[guid] = nil
						dnd_change = true
					end
				end
				if dnd_change then
					for font_string in pairs(dnd_cache) do
						if font_string.frame.guid == guid then
							to_update[font_string] = 0
						end
					end
				end
			end
		end
		if UnitIsDeadOrGhost(unit) then
			if not dead_times[guid] then
				dead_times[guid] = GetTime()
				for font_string in pairs(dead_cache) do
					if font_string.frame.guid == guid then
						to_update[font_string] = 0
					end
				end
			end
		else
			dead_times[guid] = nil
		end
	end
end

function PitBull4_LuaTexts:PARTY_MEMBERS_CHANGED(event)
  local prefix, min, max = "raid", 1, GetNumRaidMembers()
	if max == 0 then
		prefix, min, max = "party", 0, GetNumPartyMembers()
	end
	if max == 0 then
		-- not in a raid or a party
		wipe(group_members)
		group_members["player"] = player_guid
		return
	end

	wipe(group_members)
	for i = min, max do
		local unit
		if i == 0 then
			unit = 'player'
		else
			unit = prefix .. i
		end
		local guid = UnitGUID(unit)
		group_members[unit] = guid

		if guid then
			tmp[guid] = true
		end
	end

	-- Cleanup any timers that reference people no longer in the party
	for guid in pairs(offline_times) do
		if not tmp[guid] then
			offline_times[guid] = nil
		end
	end
	for guid in pairs(dead_times) do
		if not tmp[guid] then
			dead_times[guid] = nil
		end
	end
	for guid in pairs(afk_times) do
		if not tmp[guid] then
			afk_times[guid] = nil
		end
	end
	wipe(tmp)
end

function PitBull4_LuaTexts:OnEvent(event, unit, ...)
	local event_entry = event_cache[event]
	if not event_entry then return end
	local event_config = self.db.profile.global.events[event]
	local all, by_unit, player, pet, guid

	if event_config then
		all, by_unit = event_config.all, event_config.unit
		player, pet = event_config.player, event_config.pet
	else
		-- Sucks but if for some reason the event entry is missing update all
		all = true
	end

	if unit then
		guid = UnitGUID(unit)
	end

	if event == "PLAYER_FLAGS_CHANGED" then
		update_timers()
	elseif string.sub(event,1,15) == "UNIT_SPELLCAST_" then
		-- spell casting events need to go through
		update_cast_data(event, unit, ...)
	end

	for font_string in pairs(event_entry) do
		local fs_guid = font_string.frame.guid
		if all or (by_unit and fs_guid == guid) or (player and fs_guid == player_guid) or (pet and fs_guid == UnitGUID("pet")) then
			update_text(font_string,event)	
		end
	end
end

-- Timed updates 
local timer = 0
timerframe:SetScript("OnUpdate", function(self, elapsed)
	local ScriptEnv = PitBull4_LuaTexts.ScriptEnv
	-- Fast updates for powerbars for player and pet frames
	if predicted_power and next(power_cache) then
		if UnitPower("player") ~= ScriptEnv.player_power then	
			for font_string in pairs(power_cache) do
				if font_string.frame.guid == player_guid then
					to_update[font_string] = 0 
				end
			end
		end
		if UnitPower("pet") ~= ScriptEnv.pet_power then
			local pet_guid = UnitGUID("pet")
			for font_string in pairs(power_cache) do
				if font_string.frame.guid == pet_guid then
					to_update[font_string] = 0 
				end
			end
		end
	end

  -- cast text
	fix_cast_data()

	-- If there are any font_strings with mouseover checks
	if next(mouseover_check_cache) then
		local old_mouseover = PitBull4_LuaTexts.mouseover
		local mouseover = GetMouseFocus()
		PitBull4_LuaTexts.mouseover = mouseover
		if old_mouseover ~= mouseover then 
			for font_string, frame in pairs(mouseover_check_cache) do
				if mouseover == frame or old_mouseover == frame then
					to_update[font_string] = 0 
				end
			end
		end
	end

	-- Update the timers once a second
	timer = timer + elapsed
	if timer > 1 then
		timer = 0
		update_timers()
	end

	-- Look for frames to update.  time values of less than
	-- or equal to zero update the frame, otherwise we simply
	-- subtract the elapsed time and update the time left.
	for font_string,time in pairs(to_update) do
		time = time - elapsed
		if time <= 0 then
			to_update[font_string] = nil
			update_text(font_string,"_timer")
		else
			to_update[font_string] = time
		end
	end
end)

function PitBull4_LuaTexts:OnNewLayout(layout)
	local layout_db = self.db.profile.layouts[layout]

	if not layout_db.first then
		return
	end
	layout_db.first = false

	local texts = layout_db.elements
	for k in pairs(texts) do
		texts[k] = nil
	end
	for name, data in pairs {
		["Lua:"..L["Name"]] = {
			code = PROVIDED_CODES[L['Name']][L['Standard']].code,
			events = copy(PROVIDED_CODES[L['Name']][L['Standard']].events),
			attach_to = "HealthBar",
			location = "left"
		},
		["Lua:"..L["Health"]] = {
			code = PROVIDED_CODES[L['Health']][L['Absolute and percent']].code,
			events = copy(PROVIDED_CODES[L['Health']][L['Absolute and percent']].events),
			attach_to = "HealthBar",
			location = "right"
		},
		["Lua:"..L["Class"]] = {
			code = PROVIDED_CODES[L['Class']][L['Standard']].code,
			events = copy(PROVIDED_CODES[L['Class']][L['Standard']].events),
			attach_to = "PowerBar",
			location = "left"
		},
		["Lua:"..L["Power"]] = {
			code = PROVIDED_CODES[L['Power']][L['Absolute']].code,
			events = copy(PROVIDED_CODES[L['Power']][L['Absolute']].events),
			attach_to = "PowerBar",
			location = "right"
		},
		["Lua:"..L["Reputation"]] = {
			code = PROVIDED_CODES[L['Reputation']][L['Standard']].code,
			events = copy(PROVIDED_CODES[L['Reputation']][L['Standard']].events),
			attach_to = "ReputationBar",
			location = "center"
		},
		["Lua:"..L["Cast"]] = {
			code = PROVIDED_CODES[L['Cast']][L['Standard name']].code,
			events = copy(PROVIDED_CODES[L['Cast']][L['Standard time']].events),
			attach_to = "CastBar",
			location = "left"
		},
		["Lua:"..L["Cast time"]] = {
			code = PROVIDED_CODES[L['Cast']][L['Standard time']].code,
			events = copy(PROVIDED_CODES[L['Cast']][L['Standard name']].events),
			attach_to = "CastBar",
			location = "right"
		},
		["Lua:"..L["Experience"]] = {
			code = PROVIDED_CODES[L['Experience']][L['Standard']].code,
			events = copy(PROVIDED_CODES[L['Experience']][L['Standard']].events),
			attach_to = "ExperienceBar",
			location = "center"
		},
		["Lua:"..L["Threat"]] = {
			code = PROVIDED_CODES[L['Threat']][L['Percent']].code,
			events = copy(PROVIDED_CODES[L['Threat']][L['Percent']].events),
			attach_to = "ThreatBar",
			location = "center"
		},
		["Lua:"..L["Druid mana"]] = {
			code = PROVIDED_CODES[L['Druid mana']][L['Absolute']].code,
			events = copy(PROVIDED_CODES[L['Druid mana']][L['Absolute']].events),
			attach_to = "DruidManaBar",
			location = "center"
		},
		["Lua:"..L["PVPTimer"]] = {
			code = PROVIDED_CODES[L["PVPTimer"]][L["Standard"]].code,
			events = copy(PROVIDED_CODES[L["PVPTimer"]][L["Standard"]].events),
			location = "out_right_top"
		},
	} do
		local text_db = texts[name]
		text_db.exists = true
		for k, v in pairs(data) do
			text_db[k] = v
		end
	end
end

function PitBull4_LuaTexts:AddFontString(frame, font_string, name, data)
	local db = font_string.db

	no_update[font_string] = nil
	font_string:Show()
	-- This font_string is already assigned to us.  So do nothing but
	-- update the text.
	if texts[font_string] then
		update_text(font_string,"_update")
		if spell_cast_cache[font_string]  then
			-- The actual object the frame is pointing at may have changed
			-- or this may be a wacky unit that we don't get events for so
			-- we need to check the cast info anyway.
			update_cast_data(nil,frame.unit)
		end
		return true
	end

	-- Setup the font_string
	texts[font_string] = true
	font_string.frame = frame
	font_string.luatexts_name = name
	for event,enabled in pairs(db.events) do
		if enabled then
			local event_entry = event_cache[event]
			if not event_entry then
				event_entry = {}
				event_cache[event] = event_entry
				self:RegisterEvent(event,"OnEvent")
			end
			event_entry[font_string] = true
		end
	end

	update_text(font_string,"_new")

	if spell_cast_cache[font_string] then
		-- If the font_string is looking to display spell cast
		-- info update the cast_data that we didn't have becuase
		-- we may not have had events for it turned on.  The
		-- timed update will actually draw the data on the frame
		-- later.
		update_cast_data(nil,frame.unit)
	end

	return true
end

function PitBull4_LuaTexts:RemoveFontString(font_string)
	-- Remove the font_string from the event_cache
	for event,entry in pairs(event_cache) do
		entry[font_string] = nil
		-- Nobody wants this event so stop watching it.
		if not next(entry) then
			if not protected_events[event] then
				self:UnregisterEvent(event)
			end
			event_cache[event] = nil
		end
	end

	power_cache[font_string] = nil
	mouseover_check_cache[font_string] = nil
	spell_cast_cache[font_string] = nil
	to_update[font_string] = nil
	afk_cache[font_string] = nil
	dnd_cache[font_string] = nil
	offline_cache[font_string] = nil
	dead_cache[font_string] = nil
	if not next(mouseover_check_cache) then
		self.mouseover = nil
	end

	font_string.frame = nil
	texts[font_string] = nil
end

-- When a frame is hidden stop updating any texts
-- attached to it.  When it is shown it will be
-- updated again and cause everything to be put
-- back.
function PitBull4_LuaTexts:OnHide(frame)
	for font_string in pairs(texts) do
		if font_string.frame == frame then
			no_update[font_string] = true
			power_cache[font_string] = nil
			mouseover_check_cache[font_string] = nil
			spell_cast_cache[font_string] = nil
			to_update[font_string] = nil
			afk_cache[font_string] = nil
			dnd_cache[font_string] = nil
			offline_cache[font_string] = nil
			dead_cache[font_string] = nil
			if not next(mouseover_check_cache) then
				self.mouseover = nil
			end
			font_string:Hide()
		end
	end
end

-- Handle updating after a config change
local function update()
	local layout = PitBull4.Options.GetCurrentLayout()

	for frame in PitBull4:IterateFramesForLayout(layout) do
		PitBull4_LuaTexts:ForceTextUpdate(frame)
	end
end

PitBull4_LuaTexts:SetLayoutOptionsFunction(function(self)
	local values = {}
	local value_key_to_entry = {}
	values[""] = L["Custom"]
	value_key_to_entry[""] = {
		code = "",
		events = {},
	}
	for base, codes in pairs(PROVIDED_CODES) do
		for name, entry in pairs(codes) do
			local key = ("%s: %s"):format(base, name)
			values[key] = key
			value_key_to_entry[key] = entry
		end
	end

	return 'default_codes', {
		type = 'select',
		name = L["Code"],
		desc = L["Some codes provided for you."],
		get = function(info)
			local db = PitBull4.Options.GetTextLayoutDB()
			local code = db.code 
			for k, preset_entry in pairs(value_key_to_entry) do
				if preset_entry.code == code then
					local preset_events = preset_entry.events
					local events = db.events
					local match = true
					for event,flag in pairs(events) do
						if preset_events[event] ~= flag then
							match = false
						end
					end
					for event,flag in pairs(preset_events) do
						if flag ~= events[event] then
							match = false
						end
					end
					if match then
						return k
					end
				end
			end
			return ""
		end,
		set = function(info, value)
			local entry = value_key_to_entry[value]
			local db = PitBull4.Options.GetTextLayoutDB()
			db.code = entry.code
			db.events = copy(entry.events)
		
			update()	
		end,
		values = values,
		width = 'double',
	}, 'code', {
		type = 'input',
		name = L["Code"],
		desc = L["Enter a Lua script."],
		get = function(info)
			return PitBull4.Options.GetTextLayoutDB().code:gsub("|","||")
		end,
		set = function(info, value)
			local db = PitBull4.Options.GetTextLayoutDB()
			func_cache[db.code] = nil
			db.code = value:gsub("||","|")
			update()	
		end,
		multiline = true,
		width = 'full',
	}, 'events', {
		type = 'multiselect',
		dialogControl = 'Dropdown',
		name = L["Events"],
		desc = L["Events to cause the text to update."],
		get = function(info,key)
			return PitBull4.Options.GetTextLayoutDB().events[key]
		end,
		set = function(info,key,value)
			local events = PitBull4.Options.GetTextLayoutDB().events
			events[key] = value
			update()	
		end,
		width = 'double',
		values = function(info)
			local t = {}
			for event in pairs(self.db.profile.global.events) do
				t[event] = event
			end
			return t
		end,
	}
end)
 
local CURRENT_EVENT
PitBull4_LuaTexts:SetGlobalOptionsFunction(function(self)
	local update_for_values = {
		all = L['All'],
		player = L['Player'],
		pet = L['Pet'],
		unit = L['Unit passed in arg1 of event'],
	}
	if not CURRENT_EVENT then
		CURRENT_EVENT = next(self.db.profile.global.events)
	end

	local function hidden(info)
		return not self.db.profile.global.enabled
	end

	return 'div', {
		type = 'header',
		name = '',
		desc = '',
		hidden = hidden, 
	}, 'current_event', {
		type = 'select',
		name = L['Current event'],
		desc = L['Change the current event you are editing.'],
		get = function(info)
			local events = self.db.profile.global.events
			if not rawget(events,CURRENT_EVENT) then
				CURRENT_EVENT = next(events)
			end
			return CURRENT_EVENT
		end,
		set = function(info, value)
			CURRENT_EVENT = value
		end,
		values = function(info)
			local t = {}
			local events = self.db.profile.global.events
			for k,v in pairs(events) do
				t[k] = k
			end
			return t
		end,
		hidden = hidden, 
		width = 'double',
	}, 'new_event', {
		type = 'input',
		name = L['New event'],
		desc = L['Add a new event to LuaTexts.'],
		get = function(info) return "" end,
		set = function(info, value)
			self.db.profile.global.events[value] = {unit=true}
			CURRENT_EVENT = value
		end,
		validate = function(info, value)
			if value:len() < 3 then
				return L["Must be at least 3 characters long."]
			end
			return true
		end,
		hidden = hidden, 
	}, 'edit_event', {
		type = 'group',
		name = L['Edit event'],
		desc = L['Edit which units the event triggers updates on.'],
		inline = true,
		hidden = hidden, 
		args = {
			delete = {
				type = 'execute',
				name = L['Delete'],
				desc = L['Delete current event.'],
				func = function(info)
					local events = self.db.profile.global.events
					events[CURRENT_EVENT] = nil
					CURRENT_EVENT = next(events)
				end,
				confirm = true,
				confirmText = L["Are you sure you want to delete this event?"],
			},
			update_for = {
				type = 'multiselect',
				name = L["Update for"],
				desc = L["Select the units that this event will trigger text updates on."],
				get = function(info,key)
					return self.db.profile.global.events[CURRENT_EVENT][key]
				end,
				set = function(invo,key,value)
					local event = self.db.profile.global.events[CURRENT_EVENT]
					event[key] = value
				end,
				values = update_for_values,
				width = 'double',
			},
		}
	}
end)

