-- Thanks to haste for the original tagging code, which I then mostly ripped apart and stole!
local Tags = {afkStatus = {}, offlineStatus = {}, customEvents = {}}
local tagPool, functionPool, temp, regFontStrings, frequentUpdates, frequencyCache = {}, {}, {}, {}, {}, {}
local L = ShadowUF.L

ShadowUF.Tags = Tags

-- Register the associated events with all the tags
function Tags:RegisterEvents(parent, fontString, tags)
	-- Strip parantheses and anything inside them
	for tag in string.gmatch(tags, "%[(.-)%]") do
		-- The reason the original %b() match won't work, with [( ()group())] (or any sort of tag with ( or )
		-- was breaking the logic and stripping the entire tag, this is a quick fix to stop that.
		local tagKey = select(2, string.match(tag, "(%b())([%w%p]+)(%b())"))
		if( not tagKey ) then tagKey = select(2, string.match(tag, "(%b())([%w%p]+)")) end
		if( not tagKey ) then tagKey = string.match(tag, "([%w%p]+)(%b())") end
		
		tag = tagKey or tag
		
		local tagEvents = Tags.defaultEvents[tag] or ShadowUF.db.profile.tags[tag] and ShadowUF.db.profile.tags[tag].events
		if( tagEvents ) then
			for event in string.gmatch(tagEvents, "%S+") do
				if( self.customEvents[event] ) then
					self.customEvents[event]:EnableTag(parent, fontString)
					fontString[event] = true
				elseif( Tags.eventType[event] ~= "unitless" or ShadowUF.Units.unitEvents[event] ) then
					parent:RegisterUnitEvent(event, fontString, "UpdateTags")
				else
					parent:RegisterNormalEvent(event, fontString, "UpdateTags")
				end
				
				-- The power and health bars will handle updating tags with this flag set
				fontString.fastPower = fontString.fastPower or Tags.eventType[event] == "power"
				fontString.fastHealth = fontString.fastHealth or Tags.eventType[event] == "health"
			end
		end
	end
end

-- This pretty much means a tag was updated in some way (or deleted) so we have to do a full update to get the new values shown
function Tags:Reload()
	-- Kill cached functions, ugly I know but it ensures its fully updated with the new data
	table.wipe(functionPool)
	table.wipe(ShadowUF.tagFunc)
	table.wipe(tagPool)
	
	-- Now update frames
	for fontString, tags in pairs(regFontStrings) do
		self:Register(fontString.parent, fontString, tags)
		fontString.parent:RegisterUpdateFunc(fontString, "UpdateTags")
		fontString:UpdateTags()
	end
end

-- Frequent updates
local freqFrame = CreateFrame("Frame")
freqFrame:SetScript("OnUpdate", function(self, elapsed)
	for fontString, timeLeft in pairs(frequentUpdates) do
		if( fontString.parent:IsVisible() ) then
			frequentUpdates[fontString] = timeLeft - elapsed
			if( frequentUpdates[fontString] <= 0 ) then
				frequentUpdates[fontString] = fontString.frequentStart
				fontString:UpdateTags()
			end
		end
	end
end)
freqFrame:Hide()

-- Register a font string with the tag system
function Tags:Register(parent, fontString, tags, resetCache)
	-- Unregister the font string first if we did register it already
	if( fontString.UpdateTags ) then
		self:Unregister(fontString)
	end
	
	fontString.parent = parent
	regFontStrings[fontString] = tags
	
	-- Use the cached polling time if we already saved it
	-- as we won't be rececking everything next call
	local pollTime = frequencyCache[tags]
	if( pollTime ) then
		frequentUpdates[fontString] = pollTime
		fontString.frequentStart = pollTime
		freqFrame:Show()
	end
	
	local updateFunc = not resetCache and tagPool[tags]
	if( not updateFunc ) then
		-- Using .- prevents supporting tags such as [foo ([)]. Supporting that and having a single pattern
		local formattedText = string.gsub(string.gsub(tags, "%%", "%%%%"), "[[].-[]]", "%%s")
		local args = {}
		
		for tag in string.gmatch(tags, "%[(.-)%]") do
			-- Tags that use pre or appends "foo(|)" etc need special matching, which is what this will handle
			local cachedFunc = not resetCache and functionPool[tag] or ShadowUF.tagFunc[tag]
			if( not cachedFunc ) then
				local hasPre, hasAp = true, true
				local tagKey = select(2, string.match(tag, "(%b())([%w%p]+)(%b())"))
				if( not tagKey ) then hasPre, hasAp = true, false tagKey = select(2, string.match(tag, "(%b())([%w%p]+)")) end
				if( not tagKey ) then hasPre, hasAp = false, true tagKey = string.match(tag, "([%w%p]+)(%b())") end
				
				frequencyCache[tag] = tagKey and (self.defaultFrequents[tagKey] or ShadowUF.db.profile.tags[tagKey] and ShadowUF.db.profile.tags[tagKey].frequency)
				local tagFunc = tagKey and ShadowUF.tagFunc[tagKey]
				if( tagFunc ) then
					local startOff, endOff = string.find(tag, tagKey)
					local pre = hasPre and string.sub(tag, 2, startOff - 2)
					local ap = hasAp and string.sub(tag, endOff + 2, -2)
					
					if( pre and ap ) then
						cachedFunc = function(...)
							local str = tagFunc(...)
							if( str ) then return pre .. str .. ap end
						end
					elseif( pre ) then
						cachedFunc = function(...)
							local str = tagFunc(...)
							if( str ) then return pre .. str end
						end
					elseif( ap ) then
						cachedFunc = function(...)
							local str = tagFunc(...)
							if( str ) then return str .. ap end
						end
					end
					
					functionPool[tag] = cachedFunc
				end
			end
			
			-- Figure out what the lowest update frequency for this font string and use it
			local pollTime = self.defaultFrequents[tag] or frequencyCache[tag]
			if( ShadowUF.db.profile.tags[tag] and ShadowUF.db.profile.tags[tag].frequency ) then
				pollTime = ShadowUF.db.profile.tags[tag].frequency
			end
			
			if( pollTime and ( not fontString.frequentStart or fontString.frequentStart > pollTime ) ) then
				frequencyCache[tags] = pollTime
				frequentUpdates[fontString] = pollTime
				fontString.frequentStart = pollTime
				freqFrame:Show()
			end
			
			-- It's an invalid tag, simply return the tag itself wrapped in brackets
			if( not cachedFunc ) then
				functionPool[tag] = functionPool[tag] or function() return string.format("[%s-error]", tag) end
				cachedFunc = functionPool[tag]
			end
			
			table.insert(args, cachedFunc)
		end
		
		-- Create our update function now
		updateFunc = function(fontString)
			for id, func in pairs(args) do
				temp[id] = func(fontString.parent.unit, fontString.parent.unitOwner, fontString) or ""
			end
			
			fontString:SetFormattedText(formattedText, unpack(temp))
		end

		tagPool[tags] = updateFunc
	end
		
	-- And give other frames an easy way to force an update
	fontString.UpdateTags = updateFunc

	-- Register any needed event
	self:RegisterEvents(parent, fontString, tags)
end

function Tags:Unregister(fontString)
	regFontStrings[fontString] = nil
	frequentUpdates[fontString] = nil
	
	-- Kill frequent updates if they aren't needed anymore
	local hasFrequent
	for k in pairs(frequentUpdates) do
		hasFrequent = true
		break
	end
	
	if( not hasFrequent ) then
		freqFrame:Hide()
	end
	
	-- Unregister it as using HC
	for key, module in pairs(self.customEvents) do
		if( fontString[key] ) then
			fontString[key] = nil
			module:DisableTag(fontString.parent, fontString)
		end
	end
		
	-- Kill any tag data
	fontString.parent:UnregisterAll(fontString)
	fontString.fastPower = nil
	fontString.fastHealth = nil
	fontString.frequentStart = nil
	fontString.UpdateTags = nil
	fontString:SetText("")
end

-- Helper functions for tags, the reason I store it in ShadowUF is it's easier to type ShadowUF than ShadowUF.modules.Tags, and simpler for users who want to implement it.
function ShadowUF:Hex(r, g, b)
	if( type(r) == "table" ) then
		if( r.r ) then
			r, g, b = r.r, r.g, r.b
		else
			r, g, b = unpack(r)
		end
	end

	return string.format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
end

function ShadowUF:FormatLargeNumber(number)
	if( number < 9999 ) then
		return number
	elseif( number < 999999 ) then
		return string.format("%.1fk", number / 1000)
	elseif( number < 99999999 ) then
		return string.format("%.2fm", number / 1000000)
	end
	
	return string.format("%dm", number / 1000000)
end

function ShadowUF:SmartFormatNumber(number)
	if( number < 999999 ) then
		return number
	elseif( number < 99999999 ) then
		return string.format("%.2fm", number / 1000000)
	end
	
	return string.format("%dm", number / 1000000)
end

function ShadowUF:GetClassColor(unit)
	if( not UnitIsPlayer(unit) ) then
		return nil
	end
	
	local class = select(2, UnitClass(unit))
	return class and ShadowUF:Hex(ShadowUF.db.profile.classColors[class])
end

function ShadowUF:FormatShortTime(seconds)
	if( seconds >= 3600 ) then
		return string.format("%dh", seconds / 3600)
	elseif( seconds >= 60 ) then
		return string.format("%dm", seconds / 60)
	end

	return string.format("%ds", seconds)
end

-- Name abbreviation
local function abbreviateName(text)
	return string.sub(text, 1, 1) .. "."
end

Tags.abbrevCache = setmetatable({}, {
	__index = function(tbl, val)
		val = string.gsub(val, "([^%s]+) ", abbreviateName)
		rawset(tbl, val, val)
		return val
end})

-- Going to have to start using an env wrapper for tags I think
local Druid = {}
Druid.CatForm, Druid.Shapeshift = GetSpellInfo(768)
Druid.MoonkinForm = GetSpellInfo(24858)
Druid.TravelForm = GetSpellInfo(783)
Druid.BearForm = GetSpellInfo(5487)
Druid.TreeForm = GetSpellInfo(33891)
Druid.DireBearForm = GetSpellInfo(9634)
Druid.AquaticForm = GetSpellInfo(1066)
Druid.SwiftFlightForm = GetSpellInfo(40120)
Druid.FlightForm = GetSpellInfo(33943)
ShadowUF.Druid = Druid

Tags.defaultTags = {
	["hp:color"] = [[function(unit, unitOwner)
		return ShadowUF:Hex(ShadowUF.modules.healthBar.getGradientColor(unit))
	end]],
	["short:druidform"] = [[function(unit, unitOwner)
		if( select(2, UnitClass(unit)) ~= "DRUID" ) then return nil end
		
		local Druid = ShadowUF.Druid
		if( UnitAura(unit, Druid.CatForm, Druid.Shapeshift) ) then
			return ShadowUF.L["C"]
		elseif( UnitAura(unit, Druid.TreeForm, Druid.Shapeshift) ) then
			return ShadowUF.L["T"]
		elseif( UnitAura(unit, Druid.MoonkinForm, Druid.Shapeshift) ) then
			return ShadowUF.L["M"]
		elseif( UnitAura(unit, Druid.DireBearForm, Druid.Shapeshift) or UnitAura(unit, Druid.BearForm, Druid.Shapeshift) ) then
			return ShadowUF.L["B"]
		elseif( UnitAura(unit, Druid.SwiftFlightForm, Druid.Shapeshift) or UnitAura(unit, Druid.FlightForm, Druid.Shapeshift) ) then
			return ShadowUF.L["F"]
		elseif( UnitAura(unit, Druid.TravelForm, Druid.Shapeshift) ) then
			return ShadowUF.L["T"]
		elseif( UnitAura(unit, Druid.AquaticForm, Druid.Shapeshift) ) then
			return ShadowUF.L["A"]
		end
	end]],
	["druidform"] = [[function(unit, unitOwner)
		if( select(2, UnitClass(unit)) ~= "DRUID" ) then return nil end
		
		local Druid = ShadowUF.Druid
		if( UnitAura(unit, Druid.CatForm, Druid.Shapeshift) ) then
			return ShadowUF.L["Cat"]
		elseif( UnitAura(unit, Druid.TreeForm, Druid.Shapeshift) ) then
			return ShadowUF.L["Tree"]
		elseif( UnitAura(unit, Druid.MoonkinForm, Druid.Shapeshift) ) then
			return ShadowUF.L["Moonkin"]
		elseif( UnitAura(unit, Druid.DireBearForm, Druid.Shapeshift) or UnitAura(unit, Druid.BearForm, Druid.Shapeshift) ) then
			return ShadowUF.L["Bear"]
		elseif( UnitAura(unit, Druid.SwiftFlightForm, Druid.Shapeshift) or UnitAura(unit, Druid.FlightForm, Druid.Shapeshift) ) then
			return ShadowUF.L["Flight"]
		elseif( UnitAura(unit, Druid.TravelForm, Druid.Shapeshift) ) then
			return ShadowUF.L["Travel"]
		elseif( UnitAura(unit, Druid.AquaticForm, Druid.Shapeshift) ) then
			return ShadowUF.L["Aquatic"]
		end
	end]],
	["guild"] = [[function(unit, unitOwner)
		return GetGuildInfo(unitOwner)
	end]],
	["abbrev:name"] = [[function(unit, unitOwner)
		local name = UnitName(unitOwner) or UNKNOWN
		return string.len(name) > 10 and ShadowUF.Tags.abbrevCache[name] or name
	end]],
	["unit:situation"] = [[function(unit, unitOwner)
		local state = UnitThreatSituation(unit)
		if( state == 3 ) then
			return ShadowUF.L["Aggro"]
		elseif( state == 2 ) then
			return ShadowUF.L["High"]
		elseif( state == 1 ) then
			return ShadowUF.L["Medium"]
		end
	end]],
	["situation"] = [[function(unit, unitOwner)
		local state = UnitThreatSituation("player", "target")
		if( state == 3 ) then
			return ShadowUF.L["Aggro"]
		elseif( state == 2 ) then
			return ShadowUF.L["High"]
		elseif( state == 1 ) then
			return ShadowUF.L["Medium"]
		end
	end]],
	["unit:color:sit"] = [[function(unit, unitOwner)
		local state = UnitThreatSituation(unit)
		
		return state and state > 0 and ShadowUF:Hex(GetThreatStatusColor(state))
	end]],
	["unit:color:aggro"] = [[function(unit, unitOwner)
		local state = UnitThreatSituation(unit)
		
		return state and state >= 3 and ShadowUF:Hex(GetThreatStatusColor(state))
	end]],
	["color:sit"] = [[function(unit, unitOwner)
		local state = UnitThreatSituation("player", "target")
		
		return state and state > 0 and ShadowUF:Hex(GetThreatStatusColor(state))
	end]],
	["color:aggro"] = [[function(unit, unitOwner)
		local state = UnitThreatSituation("player", "target")
		
		return state and state >= 3 and ShadowUF:Hex(GetThreatStatusColor(state))
	end]],
	--["unit:scaled:threat"] = [[function(unit, unitOwner, fontString)
	--	local scaled = select(3, UnitDetailedThreatSituation(unit))
	--	return scaled and string.format("%d%%", scaled)
	--end]],
	["scaled:threat"] = [[function(unit, unitOwner)
		local scaled = select(3, UnitDetailedThreatSituation("player", "target"))
		return scaled and string.format("%d%%", scaled)
	end]],
	["general:sit"] = [[function(unit, unitOwner)
		local state = UnitThreatSituation("player")
		if( state == 3 ) then
			return ShadowUF.L["Aggro"]
		elseif( state == 2 ) then
			return ShadowUF.L["High"]
		elseif( state == 1 ) then
			return ShadowUF.L["Medium"]
		end
	end]],
	["color:gensit"] = [[function(unit, unitOwner)
		local state = UnitThreatSituation("player")
		
		return state and state > 0 and ShadowUF:Hex(GetThreatStatusColor(state))
	end]],
	["status:time"] = [[function(unit, unitOwner)
		local offlineStatus = ShadowUF.Tags.offlineStatus
		if( not UnitIsConnected(unitOwner) ) then
			offlineStatus[unitOwner] = offlineStatus[unitOwner] or GetTime()
			return string.format(ShadowUF.L["Off:%s"], ShadowUF:FormatShortTime(GetTime() - offlineStatus[unitOwner]))
		end
		
		offlineStatus[unitOwner] = nil
	end]],
	["afk:time"] = [[function(unit, unitOwner)
		if( not UnitIsConnected(unitOwner) ) then return end
		
		local afkStatus = ShadowUF.Tags.afkStatus
		local status = UnitIsAFK(unitOwner) and ShadowUF.L["AFK:%s"] or UnitIsDND(unitOwner) and ShadowUF.L["DND:%s"]
		if( status ) then
			afkStatus[unitOwner] = afkStatus[unitOwner] or GetTime()
			return string.format(status, ShadowUF:FormatShortTime(GetTime() - afkStatus[unitOwner]))
		end
		
		afkStatus[unitOwner] = nil
	end]],
	["pvp:time"] = [[function(unit, unitOwner)
		if( GetPVPTimer() >= 300000 ) then
			return nil
		end
		
		return string.format(ShadowUF.L["PVP:%s"], ShadowUF:FormatShortTime(GetPVPTimer() / 1000))
	end]],
	["afk"] = [[function(unit, unitOwner, fontString)
		return UnitIsAFK(unitOwner) and ShadowUF.L["AFK"] or UnitIsDND(unitOwner) and ShadowUF.L["DND"]
	end]],
	["close"] = [[function(unit, unitOwner) return "|r" end]],
	["smartrace"] = [[function(unit, unitOwner)
		return UnitIsPlayer(unit) and ShadowUF.tagFunc.race(unit) or ShadowUF.tagFunc.creature(unit)
	end]],
	["reactcolor"] = [[function(unit, unitOwner)
		local color
		if( not UnitIsFriend(unit, "player") and UnitPlayerControlled(unit) ) then
			if( UnitCanAttack("player", unit) ) then
				color = ShadowUF.db.profile.healthColors.hostile
			else
				color = ShadowUF.db.profile.healthColors.enemyUnattack
			end
		elseif( UnitReaction(unit, "player") ) then
			local reaction = UnitReaction(unit, "player")
			if( reaction > 4 ) then
				color = ShadowUF.db.profile.healthColors.friendly
			elseif( reaction == 4 ) then
				color = ShadowUF.db.profile.healthColors.neutral
			elseif( reaction < 4 ) then
				color = ShadowUF.db.profile.healthColors.hostile
			end
		end
		
		return color and ShadowUF:Hex(color)
	end]],
	["class"] = [[function(unit, unitOwner)
		return UnitIsPlayer(unit) and UnitClass(unit)
	end]],
	["classcolor"] = [[function(unit, unitOwner) return ShadowUF:GetClassColor(unit) end]],
	["creature"] = [[function(unit, unitOwner) return UnitCreatureFamily(unit) or UnitCreatureType(unit) end]],
	["curhp"] = [[function(unit, unitOwner)
		if( UnitIsDead(unit) ) then
			return ShadowUF.L["Dead"]
		elseif( UnitIsGhost(unit) ) then
			return ShadowUF.L["Ghost"]
		elseif( not UnitIsConnected(unit) ) then
			return ShadowUF.L["Offline"]
		end

		return ShadowUF:FormatLargeNumber(UnitHealth(unit))
	end]],
	["colorname"] = [[function(unit, unitOwner)
		local color = ShadowUF:GetClassColor(unitOwner)
		local name = UnitName(unitOwner) or UNKNOWN
		if( not color ) then
			return name
		end
	
		return string.format("%s%s|r", color, name)
	end]],
	["curpp"] = [[function(unit, unitOwner) 
		if( UnitPowerMax(unit) <= 0 ) then
			return nil
		elseif( UnitIsDeadOrGhost(unit) ) then
			return 0
		end
		
		return ShadowUF:FormatLargeNumber(UnitPower(unit))
	end]],
	["curmaxhp"] = [[function(unit, unitOwner)
		if( UnitIsDead(unit) ) then
			return ShadowUF.L["Dead"]
		elseif( UnitIsGhost(unit) ) then
			return ShadowUF.L["Ghost"]
		elseif( not UnitIsConnected(unit) ) then
			return ShadowUF.L["Offline"]
		end
		
		return string.format("%s/%s", ShadowUF:FormatLargeNumber(UnitHealth(unit)), ShadowUF:FormatLargeNumber(UnitHealthMax(unit)))
	end]],
	["smart:curmaxhp"] = [[function(unit, unitOwner)
		if( UnitIsDead(unit) ) then
			return ShadowUF.L["Dead"]
		elseif( UnitIsGhost(unit) ) then
			return ShadowUF.L["Ghost"]
		elseif( not UnitIsConnected(unit) ) then
			return ShadowUF.L["Offline"]
		end
		
		return string.format("%s/%s", ShadowUF:SmartFormatNumber(UnitHealth(unit)), ShadowUF:SmartFormatNumber(UnitHealthMax(unit)))
	end]],
	["absolutehp"] = [[function(unit, unitOwner)
		if( UnitIsDead(unit) ) then
			return ShadowUF.L["Dead"]
		elseif( UnitIsGhost(unit) ) then
			return ShadowUF.L["Ghost"]
		elseif( not UnitIsConnected(unit) ) then
			return ShadowUF.L["Offline"]
		end
		
		return string.format("%s/%s", UnitHealth(unit), UnitHealthMax(unit))
	end]],
	["abscurhp"] = [[function(unit, unitOwner)
		if( UnitIsDead(unit) ) then
			return ShadowUF.L["Dead"]
		elseif( UnitIsGhost(unit) ) then
			return ShadowUF.L["Ghost"]
		elseif( not UnitIsConnected(unit) ) then
			return ShadowUF.L["Offline"]
		end
		
		return UnitHealth(unit)
	end]],
	["absmaxhp"] = [[function(unit, unitOwner) return UnitHealthMax(unit) end]],
	["abscurpp"] = [[function(unit, unitOwner)
		if( UnitPowerMax(unit) <= 0 ) then
			return nil
		elseif( UnitIsDeadOrGhost(unit) ) then
			return 0
		end	
	
		return UnitPower(unit)
	end]],
	["absmaxpp"] = [[function(unit, unitOwner)
		local power = UnitPowerMax(unit)
		return power > 0 and power or nil
	end]],
	["absolutepp"] = [[function(unit, unitOwner)
		local maxPower = UnitPowerMax(unit)
		local power = UnitPower(unit)
		if( UnitIsDeadOrGhost(unit) ) then
			return string.format("0/%s", maxPower)
		elseif( maxPower <= 0 ) then
			return nil
		end
		
		return string.format("%s/%s", power, maxPower)
	end]],
	["curmaxpp"] = [[function(unit, unitOwner)
		local maxPower = UnitPowerMax(unit)
		local power = UnitPower(unit)
		if( UnitIsDeadOrGhost(unit) ) then
			return string.format("0/%s", ShadowUF:FormatLargeNumber(maxPower))
		elseif( maxPower <= 0 ) then
			return nil
		end
		
		return string.format("%s/%s", ShadowUF:FormatLargeNumber(power), ShadowUF:FormatLargeNumber(maxPower))
	end]],
	["smart:curmaxpp"] = [[function(unit, unitOwner)
		local maxPower = UnitPowerMax(unit)
		local power = UnitPower(unit)
		if( UnitIsDeadOrGhost(unit) ) then
			return string.format("0/%s", maxPower)
		elseif( maxPower <= 0 ) then
			return nil
		end
		
		return string.format("%s/%s", ShadowUF:SmartFormatNumber(power), ShadowUF:SmartFormatNumber(maxPower))
	end]],
	["levelcolor"] = [[function(unit, unitOwner)
		local level = UnitLevel(unit)
		if( level < 0 and UnitClassification(unit) == "worldboss" ) then
			return nil
		end
		
		if( UnitCanAttack("player", unit) ) then
			local color = ShadowUF:Hex(GetQuestDifficultyColor(level > 0 and level or 99))
			if( not color ) then
				return level > 0 and level or "??"
			end
			
			return color .. (level > 0 and level or "??") .. "|r"
		else
			return level
		end
	end]],
	["faction"] = [[function(unit, unitOwner) return UnitFactionGroup(unitOwner) end]],
	["level"] = [[function(unit, unitOwner)
		local level = UnitLevel(unit)
		return level > 0 and level or UnitClassification(unit) ~= "worldboss" and "??" or nil
	end]],
	["maxhp"] = [[function(unit, unitOwner) return ShadowUF:FormatLargeNumber(UnitHealthMax(unit)) end]],
	["maxpp"] = [[function(unit, unitOwner)
		local power = UnitPowerMax(unit)
		if( power <= 0 ) then
			return nil
		elseif( UnitIsDeadOrGhost(unit) ) then
			return 0
		end
		
		return ShadowUF:FormatLargeNumber(power)
	end]],
	["missinghp"] = [[function(unit, unitOwner)
		if( UnitIsDead(unit) ) then
			return ShadowUF.L["Dead"]
		elseif( UnitIsGhost(unit) ) then
			return ShadowUF.L["Ghost"]
		elseif( not UnitIsConnected(unit) ) then
			return ShadowUF.L["Offline"]
		end

		local missing = UnitHealthMax(unit) - UnitHealth(unit)
		if( missing <= 0 ) then return nil end
		return "-" .. ShadowUF:FormatLargeNumber(missing) 
	end]],
	["missingpp"] = [[function(unit, unitOwner)
		local power = UnitPowerMax(unit)
		if( power <= 0 ) then
			return nil
		end

		local missing = power - UnitPower(unit)
		if( missing <= 0 ) then return nil end
		return "-" .. ShadowUF:FormatLargeNumber(missing)
	end]],
	["def:name"] = [[function(unit, unitOwner)
		local deficit = ShadowUF.tagFunc.missinghp(unit, unitOwner)
		if( deficit ) then return deficit end
		
		return ShadowUF.tagFunc.name(unit, unitOwner)
	end]],
	["name"] = [[function(unit, unitOwner) return UnitName(unitOwner) or UNKNOWN end]],
	["server"] = [[function(unit, unitOwner)
		local server = select(2, UnitName(unitOwner))
		return server ~= "" and server or nil
	end]],
	["perhp"] = [[function(unit, unitOwner)
		local max = UnitHealthMax(unit)
		if( max <= 0 or UnitIsDead(unit) or UnitIsGhost(unit) or not UnitIsConnected(unit) ) then
			return "0%"
		end
		
		return math.floor(UnitHealth(unit) / max * 100 + 0.5) .. "%"
	end]],
	["perpp"] = [[function(unit, unitOwner)
		local maxPower = UnitPowerMax(unit)
		if( maxPower <= 0 ) then
			return nil
		elseif( UnitIsDeadOrGhost(unit) or not UnitIsConnected(unit) ) then
			return "0%"
		end
		
		return string.format("%d%%", math.floor(UnitPower(unit) / maxPower * 100 + 0.5))
	end]],
	["plus"] = [[function(unit, unitOwner) local classif = UnitClassification(unit) return (classif == "elite" or classif == "rareelite") and "+" end]],
	["race"] = [[function(unit, unitOwner) return UnitRace(unit) end]],
	["rare"] = [[function(unit, unitOwner) local classif = UnitClassification(unit) return (classif == "rare" or classif == "rareelite") and ShadowUF.L["Rare"] end]],
	["sex"] = [[function(unit, unitOwner) local sex = UnitSex(unit) return sex == 2 and ShadowUF.L["Male"] or sex == 3 and ShadowUF.L["Female"] end]],
	["smartclass"] = [[function(unit, unitOwner) return UnitIsPlayer(unit) and ShadowUF.tagFunc.class(unit) or ShadowUF.tagFunc.creature(unit) end]],
	["status"] = [[function(unit, unitOwner)
		if( UnitIsDead(unit) ) then
			return ShadowUF.L["Dead"]
		elseif( UnitIsGhost(unit) ) then
			return ShadowUF.L["Ghost"]
		elseif( not UnitIsConnected(unit) ) then
			return ShadowUF.L["Offline"]
		end
	end]],
	["cpoints"] = [[function(unit, unitOwner)
		local points = GetComboPoints(ShadowUF.playerUnit)
		if( points == 0 ) then
			points = GetComboPoints(ShadowUF.playerUnit, ShadowUF.playerUnit)
		end
		
		return points > 0 and points
	end]],
	["smartlevel"] = [[function(unit, unitOwner)
		local classif = UnitClassification(unit)
		if( classif == "worldboss" ) then
			return ShadowUF.L["Boss"]
		else
			local plus = ShadowUF.tagFunc.plus(unit)
			local level = ShadowUF.tagFunc.level(unit)
			if( plus ) then
				return level .. plus
			else
				return level
			end
		end
	end]],
	["dechp"] = [[function(unit, unitOwner) return string.format("%.1f%%", (UnitHealth(unit) / UnitHealthMax(unit)) * 100) end]],
	["classification"] = [[function(unit, unitOwner)
		local classif = UnitClassification(unit)
		if( classif == "rare" ) then
			return ShadowUF.L["Rare"]
		elseif( classif == "rareelite" ) then
			return ShadowUF.L["Rare Elite"]
		elseif( classif == "elite" ) then
			return ShadowUF.L["Elite"]
		elseif( classif == "worldboss" ) then
			return ShadowUF.L["Boss"]
		end
		
		return nil
	end]],
	["shortclassification"] = [[function(unit, unitOwner)
		local classif = UnitClassification(unit)
		return classif == "rare" and "R" or classif == "rareelite" and "R+" or classif == "elite" and "+" or classif == "worldboss" and "B"
	end]],
	["group"] = [[function(unit, unitOwner)
		if( GetNumRaidMembers() == 0 ) then return nil end
		local name, server = UnitName(unitOwner)
		if( server and server ~= "" ) then
			name = string.format("%s-%s", name, server)
		end
		
		for i=1, GetNumRaidMembers() do
			local raidName, _, group = GetRaidRosterInfo(i)
			if( raidName == name ) then
				return group
			end
		end
		
		return nil
	end]],
	["druid:curpp"] = [[function(unit, unitOwner)
		if( select(2, UnitClass(unit)) ~= "DRUID" ) then return nil end
		local powerType = UnitPowerType(unit)
		if( powerType ~= 1 and powerType ~= 3 ) then return nil end
		return ShadowUF:FormatLargeNumber(UnitPower(unit, 0))
	end]],
	["druid:abscurpp"] = [[function(unit, unitOwner)
		if( select(2, UnitClass(unit)) ~= "DRUID" ) then return nil end
		local powerType = UnitPowerType(unit)
		if( powerType ~= 1 and powerType ~= 3 ) then return nil end
		return UnitPower(unit, 0)
	end]],
	["druid:curmaxpp"] = [[function(unit, unitOwner)
		if( select(2, UnitClass(unit)) ~= "DRUID" ) then return nil end
		local powerType = UnitPowerType(unit)
		if( powerType ~= 1 and powerType ~= 3 ) then return nil end
		
		local maxPower = UnitPowerMax(unit, 0)
		local power = UnitPower(unit, 0)
		if( UnitIsDeadOrGhost(unit) ) then
			return string.format("0/%s", ShadowUF:FormatLargeNumber(maxPower))
		elseif( maxPower == 0 and power == 0 ) then
			return nil
		end
		
		return string.format("%s/%s", ShadowUF:FormatLargeNumber(power), ShadowUF:FormatLargeNumber(maxPower))
	end]],
	["druid:absolutepp"] = [[function(unit, unitOwner)
		if( select(2, UnitClass(unit)) ~= "DRUID" ) then return nil end
		local powerType = UnitPowerType(unit)
		if( powerType ~= 1 and powerType ~= 3 ) then return nil end
		return UnitPower(unit, 0)
	end]],
	["abs:incheal"] = [[function(unit, unitOwner, fontString)
		return fontString.incoming and string.format("%d", fontString.incoming)
	end]],
	["incheal"] = [[function(unit, unitOwner, fontString)
		return fontString.incoming and ShadowUF:FormatLargeNumber(fontString.incoming) or nil
	end]],
	["incheal:name"] = [[function(unit, unitOwner, fontString)
		return fontString.incoming and string.format("+%d", fontString.incoming) or ShadowUF.tagFunc.name(unit, unitOwner)
	end]],
	["unit:raid:targeting"] = [[function(unit, unitOwner, fontString)
		if( GetNumRaidMembers() == 0 ) then return nil end
		local guid = UnitGUID(unit)
		if( not guid ) then return "0" end
		
		local total = 0
		for i=1, GetNumRaidMembers() do
			local unit = ShadowUF.raidUnits[i]
			if( UnitGUID(ShadowUF.unitTarget[unit]) == guid ) then
				total = total + 1
			end
		end		
		return total
	end]],
	["unit:raid:assist"] = [[function(unit, unitOwner, fontString)
		if( GetNumRaidMembers() == 0 ) then return nil end
		local guid = UnitGUID(ShadowUF.unitTarget[unit])
		if( not guid ) then return "--" end
		
		local total = 0
		for i=1, GetNumRaidMembers() do
			local unit = ShadowUF.raidUnits[i]
			if( UnitGUID(ShadowUF.unitTarget[unit]) == guid ) then
				total = total + 1
			end
		end		
		return total
	end]],
}

-- Default tag events
Tags.defaultEvents = {
	["hp:color"]			= "UNIT_HEALTH UNIT_MAXHEALTH",
	["short:druidform"]		= "UNIT_AURA",
	["druidform"]			= "UNIT_AURA",
	["guild"]				= "UNIT_NAME_UPDATE", -- Not sure when this data is available, guessing
	["abs:incheal"]			= "HEALCOMM",
	["incheal:name"]		= "HEALCOMM",
	["incheal"]				= "HEALCOMM",
	["afk"]					= "PLAYER_FLAGS_CHANGED", -- Yes, I know it's called PLAYER_FLAGS_CHANGED, but arg1 is the unit including non-players.
	["afk:time"]			= "PLAYER_FLAGS_CHANGED",
	["status:time"]			= "UNIT_MANA",
	["pvp:time"]			= "PLAYER_FLAGS_CHANGED",
	["curhp"]               = "UNIT_HEALTH",
	["abscurhp"]			= "UNIT_HEALTH",
	["curmaxhp"]			= "UNIT_HEALTH UNIT_MAXHEALTH",
	["absolutehp"]			= "UNIT_HEALTH UNIT_MAXHEALTH",
	["smart:curmaxhp"]		= "UNIT_HEALTH UNIT_MAXHEALTH",
	["curpp"]               = "UNIT_ENERGY UNIT_FOCUS UNIT_MANA UNIT_RAGE UNIT_RUNIC_POWER UNIT_DISPLAYPOWER",
	["abscurpp"]            = "UNIT_ENERGY UNIT_FOCUS UNIT_MANA UNIT_RAGE UNIT_RUNIC_POWER UNIT_DISPLAYPOWER UNIT_MAXENERGY UNIT_MAXFOCUS UNIT_MAXMANA UNIT_MAXRAGE UNIT_MAXRUNIC_POWERR",
	["curmaxpp"]			= "UNIT_ENERGY UNIT_FOCUS UNIT_MANA UNIT_RAGE UNIT_RUNIC_POWER UNIT_DISPLAYPOWER UNIT_MAXENERGY UNIT_MAXFOCUS UNIT_MAXMANA UNIT_MAXRAGE UNIT_MAXRUNIC_POWER",
	["absolutepp"]			= "UNIT_ENERGY UNIT_FOCUS UNIT_MANA UNIT_RAGE UNIT_RUNIC_POWER UNIT_DISPLAYPOWER UNIT_MAXENERGY UNIT_MAXFOCUS UNIT_MAXMANA UNIT_MAXRAGE UNIT_MAXRUNIC_POWER",
	["smart:curmaxpp"]		= "UNIT_ENERGY UNIT_FOCUS UNIT_MANA UNIT_RAGE UNIT_RUNIC_POWER UNIT_DISPLAYPOWER UNIT_MAXENERGY UNIT_MAXFOCUS UNIT_MAXMANA UNIT_MAXRAGE UNIT_MAXRUNIC_POWER",
	["druid:curpp"]  	    = "UNIT_MANA UNIT_DISPLAYPOWER",
	["druid:abscurpp"]      = "UNIT_MANA UNIT_DISPLAYPOWER",
	["druid:curmaxpp"]		= "UNIT_MANA UNIT_MAXMANA UNIT_DISPLAYPOWER",
	["druid:absolutepp"]	= "UNIT_MANA UNIT_MAXMANA UNIT_DISPLAYPOWER",
	["level"]               = "UNIT_LEVEL PLAYER_LEVEL_UP",
	["levelcolor"]			= "UNIT_LEVEL PLAYER_LEVEL_UP",
	["maxhp"]               = "UNIT_MAXHEALTH",
	["def:name"]			= "UNIT_NAME_UPDATE UNIT_MAXHEALTH UNIT_HEALTH",
	["absmaxhp"]			= "UNIT_MAXHEALTH",
	["maxpp"]               = "UNIT_MAXENERGY UNIT_MAXFOCUS UNIT_MAXMANA UNIT_MAXRAGE UNIT_MAXRUNIC_POWER",
	["absmaxpp"]			= "UNIT_MAXENERGY UNIT_MAXFOCUS UNIT_MAXMANA UNIT_MAXRAGE UNIT_MAXRUNIC_POWER",
	["missinghp"]           = "UNIT_HEALTH UNIT_MAXHEALTH",
	["missingpp"]           = "UNIT_MAXENERGY UNIT_MAXFOCUS UNIT_MAXMANA UNIT_MAXRAGE UNIT_ENERGY UNIT_FOCUS UNIT_MANA UNIT_RAGE UNIT_MAXRUNIC_POWER UNIT_RUNIC_POWER",
	["name"]                = "UNIT_NAME_UPDATE",
	["abbrev:name"]			= "UNIT_NAME_UPDATE",
	["server"]				= "UNIT_NAME_UPDATE",
	["colorname"]			= "UNIT_NAME_UPDATE",
	["perhp"]               = "UNIT_HEALTH UNIT_MAXHEALTH",
	["perpp"]               = "UNIT_MAXENERGY UNIT_MAXFOCUS UNIT_MAXMANA UNIT_MAXRAGE UNIT_ENERGY UNIT_FOCUS UNIT_MANA UNIT_RAGE UNIT_MAXRUNIC_POWER UNIT_RUNIC_POWER",
	["status"]              = "UNIT_HEALTH PLAYER_UPDATE_RESTING",
	["smartlevel"]          = "UNIT_LEVEL PLAYER_LEVEL_UP UNIT_CLASSIFICATION_CHANGED",
	["cpoints"]             = "UNIT_COMBO_POINTS PLAYER_TARGET_CHANGED",
	["rare"]                = "UNIT_CLASSIFICATION_CHANGED",
	["classification"]      = "UNIT_CLASSIFICATION_CHANGED",
	["shortclassification"] = "UNIT_CLASSIFICATION_CHANGED",
	["dechp"]				= "UNIT_HEALTH UNIT_MAXHEALTH",
	["group"]				= "RAID_ROSTER_UPDATE",
	["unit:color:aggro"]	= "UNIT_THREAT_SITUATION_UPDATE",
	["color:aggro"]			= "UNIT_THREAT_SITUATION_UPDATE",
	["situation"]			= "UNIT_THREAT_SITUATION_UPDATE",
	["color:sit"]			= "UNIT_THREAT_SITUATION_UPDATE",
	["scaled:threat"]		= "UNIT_THREAT_SITUATION_UPDATE",
	["general:sit"]			= "UNIT_THREAT_SITUATION_UPDATE",
	["color:gensit"]		= "UNIT_THREAT_SITUATION_UPDATE",
	["unit:scaled:threat"]	= "UNIT_THREAT_SITUATION_UPDATE",
	["unit:color:sit"]		= "UNIT_THREAT_SITUATION_UPDATE",
	["unit:situation"]		= "UNIT_THREAT_SITUATION_UPDATE",
}
	
-- Default update frequencies for tag updating, used if it's needed to override the update speed
-- or it can't be purely event based
Tags.defaultFrequents = {
	["afk"] = 1,
	["afk:time"] = 1,
	["status:time"] = 1,
	["pvp:time"] = 1,
	["scaled:threat"] = 1,
	["unit:scaled:threat"] = 1,
	["unit:raid:targeting"] = 0.50,
	["unit:raid:assist"] = 0.50,
}

-- Default tag categories
Tags.defaultCategories = {
	["hp:color"]			= "health",
	["abs:incheal"]			= "health",
	["incheal"]				= "health",
	["incheal:name"]		= "health",
	["smart:curmaxhp"]		= "health",
	["smart:curmaxpp"]		= "health",
	["afk"]					= "status",
	["afk:time"]			= "status",
	["status:time"]			= "status",
	["pvp:time"]			= "status",
	["cpoints"]				= "misc",
	["smartlevel"]			= "classification",
	["classification"]		= "classification",
	["shortclassification"]	= "classification",
	["rare"]				= "classification",
	["plus"]				= "classification",
	["sex"]					= "misc",
	["smartclass"]			= "classification",
	["smartrace"]			= "classification",
	["status"]				= "status",
	["race"]				= "classification",
	["level"]				= "classification",
	["maxhp"]				= "health",
	["maxpp"]				= "power",
	["missinghp"]			= "health",
	["missingpp"]			= "power",
	["name"]				= "misc",
	["abbrev:name"]			= "misc",
	["server"]				= "misc",
	["perhp"]				= "health",
	["perpp"]				= "power",
	["class"]				= "classification",
	["classcolor"]			= "classification",
	["creature"]			= "classification",
	["short:druidform"]		= "classification",
	["druidform"]			= "classification",
	["curhp"]				= "health",
	["curpp"]				= "power",
	["curmaxhp"]			= "health",
	["curmaxpp"]			= "power",
	["levelcolor"]			= "classification",
	["def:name"]			= "health",
	["faction"]				= "classification",
	["colorname"]			= "misc",
	["guild"]				= "misc",
	["absolutepp"]			= "power",
	["absolutehp"]			= "health",
	["absmaxhp"]			= "health",
	["abscurhp"]			= "health",
	["absmaxpp"]			= "power",
	["abscurpp"]			= "power",
	["reactcolor"]			= "classification",
	["dechp"]				= "health",
	["group"]				= "misc",
	["close"]				= "misc",
	["druid:curpp"]         = "power",
	["druid:abscurpp"]      = "power",
	["druid:curmaxpp"]		= "power",
	["druid:absolutepp"]	= "power",
	["situation"]			= "playerthreat",
	["color:sit"]			= "playerthreat",
	["scaled:threat"]		= "playerthreat",
	["general:sit"]			= "playerthreat",
	["color:gensit"]		= "playerthreat",
	["color:aggro"]			= "playerthreat",
	["unit:scaled:threat"]	= "threat",
	["unit:color:sit"]		= "threat",
	["unit:situation"]		= "threat",
	["unit:color:aggro"]	= "threat",
	["unit:raid:assist"]	= "raid",
	["unit:raid:targeting"] = "raid",
}
	
-- Default tag help
Tags.defaultHelp = {
	["hp:color"]			= L["Color code based on percentage of HP left on the unit, this works the same way as the color by health option. But for text instead of the entire bar."],
	["guild"]				= L["Show's the units guild name if they are in a guild."],
	["short:druidform"]		= L["Short version of [druidform], C = Cat, B = Bear, F = Flight and so on."],
	["druidform"]			= L["Returns the units current form if they are a druid, Cat for Cat Form, Moonkin for Moonkin and so on."],
	["abs:incheal"]			= L["Absolute incoming heal value, if 10,000 healing is incoming it will show 10,000."],
	["incheal"]				= L["Shorten incoming heal value, if 13,000 healing is incoming it will show 13k."],
	["incheal:name"]		= L["If the unit has heals incoming, it will show the absolute incoming heal value, otherwise it will show the units name."],
	["smart:curmaxhp"]		= L["Smart number formating for [curmaxhp], numbers below 1,000,000 are left as is, numbers above 1,000,000 will use the short version such as 1m."],
	["smart:curmaxpp"]		= L["Smart number formating for [curmaxpp], numbers below 1,000,000 are left as is, numbers above 1,000,000 will use the short version such as 1m."],
	["pvp:time"]			= L["Shows how long until your PVP flag drops, will not show if the flag is manually on or you are in a hostile zone.|n|nThis will only work for yourself, you cannot use it to see the time left on your party or raid."],
	["afk:time"]			= L["Shows how long an unit has been AFK or DND."],
	["status:time"]			= L["Shows how long an unit has been offline."],
	["afk"]					= L["Shows AFK, DND or nothing depending on the units away status."],
	["cpoints"]				= L["Total number of combo points you have on your target."],
	["smartlevel"]			= L["Smart level, returns Boss for bosses, +50 for a level 50 elite mob, or just 80 for a level 80."],
	["classification"]		= L["Units classification, Rare, Rare Elite, Elite, Boss, nothing is shown if they aren't any of those."],
	["shortclassification"]	= L["Short classifications, R for Rare, R+ for Rare Elite, + for Elite, B for boss, nothing is shown if they aren't any of those."],
	["rare"]				= L["Returns Rare if the unit is a rare or rare elite mob."],
	["plus"]				= L["Returns + if the unit is an elite or rare elite mob."],
	["sex"]					= L["Returns the units sex."],
	["smartclass"]			= L["If the unit is a player then class is returned, if it's a NPC then the creature type."],
	["smartrace"]			= L["If the unit is a player then race is returned, if it's a NPC then the creature type."],
	["status"]				= L["Shows Offline, Dead, Ghost or nothing depending on the units current status."],
	["race"]				= L["Units race, Blood Elf, Tauren, Troll (unfortunately) and so on."],
	["level"]				= L["Level without any coloring."],
	["maxhp"]				= L["Max health, uses a short format, 17750 is formatted as 17.7k, values below 10000 are formatted as is."],
	["maxpp"]				= L["Max power, uses a short format, 16000 is formatted as 16k, values below 10000 are formatted as is."],
	["missinghp"]			= L["Amount of health missing, if none is missing nothing is shown. Uses a short format, -18500 is shown as -18.5k, values below 10000 are formatted as is."],
	["missingpp"]			= L["Amount of power missing,  if none is missing nothing is shown. Uses a short format, -13850 is shown as 13.8k, values below 10000 are formatted as is."],
	["name"]				= L["Unit name"],
	["server"]				= L["Unit server, if they are from your server then nothing is shown."],
	["perhp"]				= L["Returns current health as a percentage, if the unit is dead or offline than that is shown instead."],
	["perpp"]				= L["Returns current power as a percentage."],
	["class"]				= L["Class name without coloring, use [classcolor][class][close] if you want the class name to be colored by class."],
	["classcolor"]			= L["Color code for the class, use [classcolor][class][close] if you want the class text to be colored by class"],
	["creature"]			= L["Creature type, returns Felguard if the unit is a Felguard, Wolf if it's a Wolf and so on."],
	["curhp"]				= L["Current health, uses a short format, 11500 is formatted as 11.5k, values below 10000 are formatted as is."],
	["curpp"]				= L["Current power, uses a short format, 12750 is formatted as 12.7k, values below 10000 are formatted as is."],
	["curmaxhp"]			= L["Current and maximum health, formatted as [curhp]/[maxhp], if the unit is dead or offline then that is shown instead."],
	["curmaxpp"]			= L["Current and maximum power, formatted as [curpp]/[maxpp]."],
	["levelcolor"]			= L["Returns the color code based off of the units level compared to yours. If you cannot attack them then no color is returned."],
	["def:name"]			= L["When the unit is mising health, the [missinghp] tag is shown, when they are at full health then the [name] tag is shown. This lets you see -1000 when they are missing 1000 HP, but their name when they are not missing any."],
	["faction"]				= L["Units alignment, Thrall will return Horde, Magni Bronzebeard will return Alliance."],
	["colorname"]			= L["Unit name colored by class."],
	["absolutepp"]			= L["Shows current and maximum power in absolute form, 18000 power will be showed as 18000 power."],
	["absolutehp"]			= L["Shows current and maximum health in absolute form, 17500 health will be showed as 17500 health."],
	["absmaxhp"]			= L["Shows maximum health in absolute form, 14000 health is showed as 14000 health."],
	["abscurhp"]			= L["Shows current health value in absolute form meaning 15000 health is shown as 15000."],
	["absmaxpp"]			= L["Shows maximum power in absolute form, 13000 power is showed as 13000 power."],
	["abscurpp"]			= L["Shows current power value in absolute form, 15000 power will be displayed as 1500 still."],
	["reactcolor"]			= L["Reaction color code, use [reactcolor][name][close] to color the units name by their reaction."],
	["dechp"]				= L["Shows the units health as a percentage rounded to the first decimal, meaning 61 out of 110 health is shown as 55.4%."],
	["abbrev:name"]			= L["Abbreviates unit names above 10 characters, \"Dark Rune Champion\" becomes \"D.R.Champion\" and \"Dark Rune Commoner\" becomes \"D.R.Commoner\"."],
	["group"]				= L["Shows current group number of the unit."],
	["close"]				= L["Closes a color code, prevents colors from showing up on text that you do not want it to."],
	["druid:curpp"]         = string.format(L["Works the same as %s, but this is only shown if the unit is in Cat or Bear form."], "currpp"),
	["druid:abscurpp"]      = string.format(L["Works the same as %s, but this is only shown if the unit is in Cat or Bear form."], "abscurpp"),
	["druid:curmaxpp"]		= string.format(L["Works the same as %s, but this is only shown if the unit is in Cat or Bear form."], "curmaxpp"),
	["druid:absolutepp"]	= string.format(L["Works the same as %s, but this is only shown if the unit is in Cat or Bear form."], "absolutepp"),
	["situation"]			= L["Returns text based on your threat situation with your target: Aggro for Aggro, High for being close to taking aggro, and Medium as a general warning to be wary."],
	["color:sit"]			= L["Returns a color code of the threat situation with your target: Red for Aggro, Orange for High threat and Yellow to be careful."],
	["scaled:threat"]		= L["Returns a scaled threat percent of your aggro on your current target, always 0 - 100%."],
	["general:sit"]			= L["Returns text based on your general threat situation on all units: Aggro for Aggro, High for being near to pulling aggro and Medium as a general warning."],
	["color:gensit"]		= L["Returns a color code of your general threat situation on all units: Red for Aggro, Orange for High threat and Yellow to watch out."],
	["unit:scaled:threat"]	= L["Returns the scaled threat percentage for the unit, if you put this on a party member you would see the percentage of how close they are to getting any from any hostile mobs. Always 0 - 100%.|nThis cannot be used on target of target or focus target types of units."],
	["unit:color:sit"]		= L["Returns the color code for the units threat situation in general: Red for Aggro, Orange for High threat and Yellow to watch out.|nThis cannot be used on target of target or focus target types of units."],
	["unit:situation"]		= L["Returns text based on the units general threat situation: Aggro for Aggro, High for being close to taking aggro, and Medium as a warning to be wary.|nThis cannot be used on target of target or focus target types of units."],
	["unit:color:aggro"]	= L["Same as [unit:color:sit] except it only returns red if the unit has aggro, rather than transiting from yellow -> orange -> red."],
	["color:aggro"]			= L["Same as [color:sit] except it only returns red if you have aggro, rather than transiting from yellow -> orange -> red."],
	["unit:raid:targeting"]	= L["How many people in your raid are targeting the unit, for example if you put this on yourself it will show how many people are targeting you. This includes you in the count!"],
	["unit:raid:assist"]	= L["How many people are assisting the unit, for example if you put this on yourself it will show how many people are targeting your target. This includes you in the count!"],
}

Tags.defaultNames = {
	["incheal:name"]		= L["Incoming heal/Name"],
	["unit:scaled:threat"]	= L["Unit scaled threat"],
	["unit:color:sit"]		= L["Unit colored situation"],
	["unit:situation"]		= L["Unit situation name"],
	["hp:color"]			= L["Health color"],
	["guild"]				= L["Guild name"],
	["druidform"]			= L["Druid form"],
	["short:druidform"]		= L["Druid form (Short)"],
	["abs:incheal"]			= L["Incoming heal (Absolute)"],
	["incheal"]				= L["Incoming heal (Short)"],
	["abbrev:name"]			= L["Name (Abbreviated)"],
	["smart:curmaxhp"]		= L["Cur/Max HP (Smart)"],
	["smart:curmaxpp"]		= L["Cur/Max PP (Smart)"],
	["pvp:time"]			= L["PVP timer"],
	["afk:time"]			= L["AFK timer"],
	["status:time"]			= L["Offline timer"],
	["afk"]					= L["AFK status"],
	["cpoints"]				= L["Combo points"],
	["smartlevel"]			= L["Smart level"],
	["classification"]		= L["Classificaiton"],
	["shortclassification"]	= L["Short classification"],
	["rare"]				= L["Rare indicator"],
	["plus"]				= L["Short elite indicator"],
	["sex"]					= L["Sex"],
	["smartclass"]			= L["Class (Smart)"],
	["smartrace"]			= L["Race (Smart)"],
	["status"]				= L["Status"],
	["race"]				= L["Race"],
	["level"]				= L["Level"],
	["maxhp"]				= L["Max HP (Short)"],
	["maxpp"]				= L["Max power (Short)"],
	["missinghp"]			= L["Missing HP (Short)"],
	["missingpp"]			= L["Missing power (Short)"],
	["name"]				= L["Unit name"],
	["server"]				= L["Unit server"],
	["perhp"]				= L["Percent HP"],
	["perpp"]				= L["Percent power"],
	["class"]				= L["Class"],
	["classcolor"]			= L["Class color tag"],
	["creature"]			= L["Creature type"],
	["curhp"]				= L["Current HP (Short)"],
	["curpp"]				= L["Current Power (Short)"],
	["curmaxhp"]			= L["Cur/Max HP (Short)"],
	["curmaxpp"]			= L["Cur/Max Power (Short)"],
	["levelcolor"]			= L["Level (Colored)"],
	["def:name"]			= L["Deficit/Unit Name"],
	["faction"]				= L["Unit faction"],
	["colorname"]			= L["Unit name (Class colored)"],
	["absolutepp"]			= L["Cur/Max power (Absolute)"],
	["absolutehp"]			= L["Cur/Max HP (Absolute)"],
	["absmaxhp"]			= L["Max HP (Absolute)"],
	["abscurhp"]			= L["Current HP (Absolute)"],
	["absmaxpp"]			= L["Max power (Absolute)"],
	["abscurpp"]			= L["Current power (Absolute)"],
	["reactcolor"]			= L["Reaction color tag"],
	["dechp"]				= L["Decimal percent HP"],
	["group"]				= L["Group number"],
	["close"]				= L["Close color"],
	["druid:curpp"]         = L["Current power (Druid)"],
	["druid:abscurpp"]      = L["Current power (Druid/Absolute)"],
	["druid:curmaxpp"]		= L["Cur/Max power (Druid)"],
	["druid:absolutepp"]	= L["Current health (Druid/Absolute)"],
	["situation"]			= L["Threat situation"],
	["color:sit"]			= L["Color code for situation"],
	["scaled:threat"]		= L["Scaled threat percent"],
	["general:sit"]			= L["General threat situation"],
	["color:gensit"]		= L["Color code for general situation"],
	["color:aggro"]			= L["Color code on aggro"],
	["unit:color:aggro"]	= L["Unit color code on aggro"],
	["unit:raid:targeting"]	= L["Raid targeting unit"],
	["unit:raid:assist"]	= L["Raid assisting unit"],
}

-- List of event types
Tags.eventType = {
	["UNIT_ENERGY"] = "power",
	["UNIT_FOCUS"] = "power",
	["UNIT_MANA"] = "power",
	["UNIT_RAGE"] = "power",
	["UNIT_RUNIC_POWER"] = "power",
	["UNIT_HEALTH"] = "health",
	["UNIT_MAXHEALTH"] = "health",
	["RAID_ROSTER_UPDATE"] = "unitless",
	["RAID_TARGET_UPDATE"] = "unitless",
	["PLAYER_TARGET_CHANGED"] = "unitless",
	["PARTY_MEMBERS_CHANGED"] = "unitless",
	["PARTY_LEADER_CHANGED"] = "unitless",
	["PLAYER_ENTERING_WORLD"] = "unitless",
	["PLAYER_XP_UPDATE"] = "unitless",
	["PLAYER_TOTEM_UPDATE"] = "unitless",
	["PLAYER_LEVEL_UP"] = "unitless",
	["UPDATE_EXHAUSTION"] = "unitless",
	["PLAYER_UPDATE_RESTING"] = "unitless",
	["UNIT_COMBO_POINTS"] = "unitless",
}

-- Tag groups that have a special filter that can't be used on certain units, like the threat API's
Tags.unitBlacklist = {
	["threat"]	= "%w+target",
}

-- Single tags that can only be used on a single unit
Tags.unitRestrictions = {
	["pvp:time"] = "player",	
}

-- Event scanner to automatically figure out what events a tag will need
local function loadAPIEvents()
	if( Tags.APIEvents ) then return end
	Tags.APIEvents = {
		["InCombatLockdown"]		= "PLAYER_REGEN_ENABLED PLAYER_REGEN_DISABLED",
		["UnitLevel"]				= "UNIT_LEVEL",
		["UnitName"]				= "UNIT_NAME_UPDATE",
		["UnitClassification"]		= "UNIT_CLASSIFICATION_CHANGED",
		["UnitFactionGroup"]		= "UNIT_FACTION PLAYER_FLAGS_CHANGED",
		["UnitHealth%("]			= "UNIT_HEALTH",
		["UnitHealthMax"]			= "UNIT_MAXHEALTH",
		["UnitPower%("]				= "UNIT_ENERGY UNIT_FOCUS UNIT_MANA UNIT_RAGE UNIT_RUNIC_POWER",
		["UnitPowerMax"]			= "UNIT_MAXENERGY UNIT_MAXFOCUS UNIT_MAXMANA UNIT_MAXRAGE UNIT_MAXRUNIC_POWER",
		["UnitPowerType"]			= "UNIT_DISPLAYPOWER",
		["UnitIsDead"]				= "UNIT_HEALTH",
		["UnitIsGhost"]				= "UNIT_HEALTH",
		["UnitIsConnected"]			= "UNIT_HEALTH",
		["UnitIsAFK"]				= "PLAYER_FLAGS_CHANGED",
		["UnitIsDND"]				= "PLAYER_FLAGS_CHANGED",
		["UnitIsPVP"]				= "PLAYER_FLAGS_CHANGED UNIT_FACTION",
		["UnitIsPartyLeader"]		= "PARTY_LEADER_CHANGED PARTY_MEMBERS_CHANGED",
		["UnitIsPVPFreeForAll"]		= "PLAYER_FLAGS_CHANGED UNIT_FACTION",
		["UnitCastingInfo"]			= "UNIT_SPELLCAST_START UNIT_SPELLCAST_STOP UNIT_SPELLCAST_FAILED UNIT_SPELLCAST_INTERRUPTED UNIT_SPELLCAST_DELAYED",
		["UnitChannelInfo"]			= "UNIT_SPELLCAST_CHANNEL_START UNIT_SPELLCAST_CHANNEL_STOP UNIT_SPELLCAST_CHANNEL_INTERRUPTED UNIT_SPELLCAST_CHANNEL_UPDATE",
		["UnitAura"]				= "UNIT_AURA",
		["UnitBuff"]				= "UNIT_AURA",
		["UnitDebuff"]				= "UNIT_AURA",
		["UnitXPMax"]				= "UNIT_PET_EXPERIENCE PLAYER_XP_UPDATE PLAYER_LEVEL_UP",
		["UnitXP%("]				= "UNIT_PET_EXPERIENCE PLAYER_XP_UPDATE PLAYER_LEVEL_UP",
		["GetTotemInfo"]			= "PLAYER_TOTEM_UPDATE",
		["GetXPExhaustion"]			= "UPDATE_EXHAUSTION",
		["GetWatchedFactionInfo"]	= "UPDATE_FACTION",
		["GetRuneCooldown"]			= "RUNE_POWER_UPDATE",
		["GetRuneType"]				= "RUNE_TYPE_UPDATE",
		["GetRaidTargetIndex"]		= "RAID_TARGET_UPDATE",
		["GetComboPoints"]			= "UNIT_COMBO_POINTS",
		["GetNumPartyMembers"]		= "PARTY_MEMBERS_CHANGED",
		["GetNumRaidMembers"]		= "RAID_ROSTER_UPDATE",
		["GetRaidRosterInfo"]		= "RAID_ROSTER_UPDATE",
		["GetPetHappiness"]			= "UNIT_HAPPINESS",
		["GetReadyCheckStatus"]		= "READY_CHECK READY_CHECK_CONFIRM READY_CHECK_FINISHED",
		["GetLootMethod"]			= "PARTY_LOOT_METHOD_CHANGED",
		["GetThreatStatusColor"]	= "UNIT_THREAT_SITUATION_UPDATE",
		["UnitThreatSituation"]		= "UNIT_THREAT_SITUATION_UPDATE",
		["UnitDetailedThreatSituation"] = "UNIT_THREAT_SITUATION_UPDATE",
	}
end
		
-- Scan the actual tag code to find the events it uses
local alreadyScanned = {}
function Tags:IdentifyEvents(code, parentTag)
	-- Already scanned this tag, prevents infinite recursion
	if( parentTag and alreadyScanned[parentTag] ) then
		return ""
	-- Flagged that we already took care of this
	elseif( parentTag ) then
		alreadyScanned[parentTag] = true
	else
		for k in pairs(alreadyScanned) do alreadyScanned[k] = nil end
		loadAPIEvents()
	end
			
	-- Scan our function list to see what APIs are used
	local eventList = ""
	for func, events in pairs(self.APIEvents) do
		if( string.match(code, func) ) then
			eventList = eventList .. events .. " " 
		end
	end
	
	-- Scan if they use any tags, if so we need to check them as well to see what content is used
	for tag in string.gmatch(code, "tagFunc\.(%w+)%(") do
		local code = ShadowUF.Tags.defaultTags[tag] or ShadowUF.db.profile.tags[tag] and ShadowUF.db.profile.tags[tag].func
		eventList = eventList .. " " .. self:IdentifyEvents(code, tag)
	end
	
	-- Remove any duplicate events
	if( not parentTag ) then
		local tagEvents = {}
		for event in string.gmatch(string.trim(eventList), "%S+") do
			tagEvents[event] = true
		end
		
		eventList = ""
		for event in pairs(tagEvents) do
			eventList = eventList .. event .. " "
		end
	end
		
	-- And give them our nicely outputted data
	return string.trim(eventList or "")
end


-- Checker function, makes sure tags are all happy
--[===[@debug@
function Tags:Verify()
	local fine = true
	for tag, events in pairs(self.defaultEvents) do
		if( not self.defaultTags[tag] ) then
			print(string.format("Found event for %s, but no tag associated with it.", tag))
			fine = nil
		end
	end
	
	for tag, data in pairs(self.defaultTags) do
		if( not self.defaultTags[tag] ) then
			print(string.format("Found tag for %s, but no event associated with it.", tag))
			fine = nil
		end
		
		if( not self.defaultHelp[tag] ) then
			print(string.format("Found tag for %s, but no help text associated with it.", tag))
			fine = nil
		end
		
		if( not self.defaultNames[tag] ) then
			print(string.format("Found tag for %s, but no name associated with it.", tag))
			fine = nil
		end
		
		if( not self.defaultCategories[tag] ) then
			print(string.format("Found tag for %s, but no category associated with it.", tag))
			fine = nil
		end
		
		local funct, msg = loadstring("return " .. data)
		if( not funct and msg ) then
			print(string.format("Failed to load tag %s.", tag))
			print(msg)
			fine = nil
		else
			funct("player")
		end
	end
		
	if( fine ) then
		print("Verified tags, everything is fine.")
	end
end
--@end-debug@]===]
