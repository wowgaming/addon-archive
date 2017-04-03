if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_VisualHeal requires PitBull4")
end

-- CONSTANTS ----------------------------------------------------------------

local EPSILON = 1e-5

-----------------------------------------------------------------------------

local L = PitBull4.L
local LibHealComm

local PitBull4_VisualHeal = PitBull4:NewModule("VisualHeal", "AceEvent-3.0")

PitBull4_VisualHeal:SetModuleType("custom")
PitBull4_VisualHeal:SetName(L["Visual heal"])
PitBull4_VisualHeal:SetDescription(L["Visualises healing done by you and your group members before it happens."])
PitBull4_VisualHeal:SetDefaults({
	show_overheal = true,
	}, {
	incoming_color = { 0.4, 0.6, 0.4, 0.75 },
	outgoing_color = { 0, 1, 0, 1 },
	outgoing_color_overheal = { 1, 0, 0, 0.65 },
	auto_luminance = true,
})

function PitBull4_VisualHeal:OnEnable()
	if not LibHealComm then
		LoadAddOn("LibHealComm-4.0")
		LibHealComm = LibStub("LibHealComm-4.0", true)
	end
	if not LibHealComm then
		error(L["PitBull4_VisualHeal requires the library LibHealComm-4.0 to be available."])
	end
	
	LibHealComm.RegisterCallback(self, "HealComm_HealStarted")
	LibHealComm.RegisterCallback(self, "HealComm_HealUpdated")
	LibHealComm.RegisterCallback(self, "HealComm_HealStopped")
	LibHealComm.RegisterCallback(self, "HealComm_HealDelayed")
	LibHealComm.RegisterCallback(self, "HealComm_ModifierChanged")
	LibHealComm.RegisterCallback(self, "HealComm_GUIDDisappeared")
	
	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("UNIT_MAXHEALTH", "UNIT_HEALTH")
end

function PitBull4_VisualHeal:OnDisable()
	LibHealComm.UnregisterAllCallbacks(self)
end

local function clamp(value, min, max)
	if value < min then
		return min
	elseif value > max then
		return max
	else
		return value
	end
end

local REVERSE_POINT = {
	LEFT = "RIGHT",
	RIGHT = "LEFT",
	TOP = "BOTTOM",
	BOTTOM = "TOP",
}

local player_guid = UnitGUID("player")
local player_is_casting = false
local player_healing_guids = {}
local player_end_time = nil

function PitBull4_VisualHeal:UpdateFrame(frame)
	local health_bar = frame.HealthBar
	local unit = frame.unit
	local guid = frame.guid
	if not health_bar or not LibHealComm or not unit or not guid then
		return self:ClearFrame(frame)
	end

	local current_time = GetTime()
	local time_band = 4 -- default to a 4 second window
	if player_is_casting and player_healing_guids[guid] then
		time_band = math.min(player_end_time - current_time, 4)
	end

	local player_healing = LibHealComm:GetHealAmount(guid, LibHealComm.ALL_HEALS, current_time + time_band, player_guid)
	local others_healing = LibHealComm:GetOthersHealAmount(guid, LibHealComm.ALL_HEALS, current_time + time_band)
	
	-- Bail out early if nothing going on for this unit
	if not player_healing and not others_healing then
		return self:ClearFrame(frame)
	end
	
	local heal_modifier = LibHealComm:GetHealModifier(guid)

	local unit_health_max = UnitHealthMax(unit)
	local current_percent = UnitHealth(unit) / unit_health_max

	local others_percent = others_healing and heal_modifier * others_healing / unit_health_max or 0
	local player_percent = player_healing and heal_modifier * player_healing / unit_health_max or 0
	if others_percent <= 0 and player_percent <= 0 then
		return self:ClearFrame(frame)
	end
	
	local bar = frame.VisualHeal
	if not bar then
		bar = PitBull4.Controls.MakeBetterStatusBar(health_bar)
		frame.VisualHeal = bar
		bar:SetBackgroundAlpha(0)
	end

	local show_overheal = PitBull4.Options.GetLayoutDB(self).show_overheal

	-- If the user has selected to not show overheal we make sure to not set a value that goes beyond 100%.
	if not show_overheal and ((others_percent+current_percent) > 1) then
		others_percent = 1 - current_percent
	end

	bar:SetValue(math.min(others_percent, 1))

	if not show_overheal and ((player_percent+others_percent+current_percent) > 1) then
		player_percent = 1 - (others_percent+current_percent)
	end

	bar:SetExtraValue(player_percent)
	bar:SetTexture(health_bar:GetTexture())
	
	local deficit = health_bar.deficit
	local orientation = health_bar.orientation
	local reverse = health_bar.reverse
	bar:SetOrientation(orientation)
	bar:SetReverse(deficit ~= reverse)
	
	bar:ClearAllPoints()
	local point, attach, attach_frame
	if orientation == "HORIZONTAL" then
		point, attach = "LEFT", "RIGHT"
		bar:SetWidth(health_bar:GetWidth())
		bar:SetHeight(0)
		bar:SetPoint("TOP", health_bar, "TOP")
		bar:SetPoint("BOTTOM", health_bar, "BOTTOM")
	else
		point, attach = "BOTTOM", "TOP"
		bar:SetHeight(health_bar:GetHeight())
		bar:SetWidth(0)
		bar:SetPoint("LEFT", health_bar, "LEFT")
		bar:SetPoint("RIGHT", health_bar, "RIGHT")
	end
	
	if deficit then
		point, attach = attach, point
		attach_frame = health_bar.bg
	else
		attach_frame = health_bar.fg
	end
	
	if reverse then
		point, attach = REVERSE_POINT[point], REVERSE_POINT[attach]
	end
	
	bar:SetPoint(point, attach_frame, attach)
	
	local db = self.db.profile.global
	
	if others_percent > 0 then
		local r, g, b, a = unpack(db.incoming_color)
		bar:SetColor(r, g, b)
		bar:SetNormalAlpha(a)
	end
	
	if player_percent > 0 then
		local waste = clamp((current_percent + others_percent + player_percent - 1) / player_percent, 0, 1)
		
		local r, g, b, a = unpack(db.outgoing_color)
		if waste > 0 then
			local r2, g2, b2, a2 = unpack(db.outgoing_color_overheal)
			
			local inverse_waste = 1 - waste
			r = r * inverse_waste + r2 * waste
			g = g * inverse_waste + g2 * waste
			b = b * inverse_waste + b2 * waste
			a = a * inverse_waste + a2 * waste
		end
		
		if db.auto_luminance then
			local high = math.max(r, g, b, EPSILON)
			r, g, b = r / high, g / high, b / high
		end
		
		bar:SetExtraColor(r, g, b)
		bar:SetExtraAlpha(a)
	end
	
	return true
end

function PitBull4_VisualHeal:UNIT_HEALTH(event, unit)
	self:UpdateForUnitID(unit)
end

function PitBull4_VisualHeal:ClearFrame(frame)
	if not frame.VisualHeal then
		return false
	end
	
	frame.VisualHeal = frame.VisualHeal:Delete()
	return true
end

PitBull4_VisualHeal.OnHide = PitBull4_VisualHeal.ClearFrame

function PitBull4_VisualHeal:HealComm_HealStarted(event, caster_guid, spell_id, heal_type, end_time, ...)
	if caster_guid == player_guid and bit.band(heal_type,LibHealComm.DIRECT_HEALS) ~= 0 then
		player_is_casting = true
		wipe(player_healing_guids)
		for i=1,select('#',...) do
			player_healing_guids[select(i,...)] = true
		end
		player_end_time = end_time
	end
	
	for frame in PitBull4:IterateFramesForGUIDs(...) do
		self:Update(frame)
	end
end

function PitBull4_VisualHeal:HealComm_HealUpdated(event, caster_guid, spell_id, heal_type, end_time, ...)
	for frame in PitBull4:IterateFramesForGUIDs(...) do
		self:Update(frame)
	end
end

function PitBull4_VisualHeal:HealComm_HealDelayed(event, caster_guid, spell_id, heal_type, end_time, ...)
	if caster_guid == player_guid then
		player_end_time = end_time
	end
	
	for frame in PitBull4:IterateFramesForGUIDs(...) do
		self:Update(frame)
	end
end

function PitBull4_VisualHeal:HealComm_HealStopped(event, caster_guid, spell_id, heal_type, interrupted, ...)
	if caster_guid == player_guid and bit.band(heal_type,LibHealComm.DIRECT_HEALS) ~= 0 then
		player_is_casting = false
	end
	
	for frame in PitBull4:IterateFramesForGUIDs(...) do
		self:Update(frame)
	end
end

function PitBull4_VisualHeal:HealComm_ModifierChanged(event, guid)
	self:UpdateForGUID(guid)
end

function PitBull4_VisualHeal:HealComm_GUIDDisappeared(event, guid)
	self:UpdateForGUID(guid)
end

PitBull4_VisualHeal:SetColorOptionsFunction(function(self)
	local function get(info)
		return unpack(self.db.profile.global[info[#info]])
	end
	local function set(info, r, g, b, a)
		local color = self.db.profile.global[info[#info]]
		color[1], color[2], color[3], color[4] = r, g, b, a
		self:UpdateAll()
	end
	return 'incoming_color', {
		type = 'color',
		name = L['Incoming color'],
		desc = L['The color of the bar that shows incoming heals from other players.'],
		get = get,
		set = set,
		hasAlpha = true,
		width = 'double',
	},
	'outgoing_color', {
		type = 'color',
		name = L['Outgoing color (no overheal)'],
		desc = L['The color of the bar that shows your own heals, when no overhealing is due.'],
		get = get,
		set = set,
		hasAlpha = true,
		width = 'double',
	},
	'outgoing_color_overheal', {
		type = 'color',
		name = L['Outgoing color (overheal)'],
		desc = L['The color of the bar that shows your own heals, when full overhealing is due.'],
		get = get,
		set = set,
		hasAlpha = true,
		width = 'double',
	},
	'auto_luminance', {
		type = 'toggle',
		name = L["Auto-luminance"],
		desc = L["Automatically adjust the luminance of the color of the outgoing heal bar to max."],
		get = function(info)
			return self.db.profile.global.auto_luminance
		end,
		set = function(info, value)
			self.db.profile.global.auto_luminance = value
			self:UpdateAll()
		end,
		width = 'double',
	},
	function(info)
		self.db.profile.global.incoming_color = { 0.4, 0.6, 0.4, 0.75 }
		self.db.profile.global.outgoing_color = { 0, 1, 0, 1 }
		self.db.profile.global.outgoing_color_overheal = { 1, 0, 0, 0.65 }
		self.db.profile.global.auto_luminance = true
	end
end)

PitBull4_VisualHeal:SetLayoutOptionsFunction(function(self) 
	local function disabled(info)
		return not PitBull4.Options.GetLayoutDB(self).enabled
	end

	return 'show_overheal', {
		type = 'toggle',
		name = L['Show overheals'],
		desc = L['Show overheals past the end of the health bar.'],
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).show_overheal
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).show_overheal = value
		end,
		disabled = disabled,
	}
end)
