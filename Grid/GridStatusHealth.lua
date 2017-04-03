--[[--------------------------------------------------------------------
	GridStatusHealth.lua
	GridStatus module for tracking unit health.
----------------------------------------------------------------------]]

local _, ns = ...
local L = ns.L

local GridRoster = Grid:GetModule("GridRoster")

local GridStatusHealth = Grid:GetModule("GridStatus"):NewModule("GridStatusHealth")
GridStatusHealth.menuName = L["Health"]

GridStatusHealth.defaultDB = {
	debug = false,
	unit_health = {
		enable = true,
		color = { r = 1, g = 1, b = 1, a = 1 },
		priority = 30,
		range = false,
		deadAsFullHealth = true,
		useClassColors = true,
	},
	unit_healthDeficit = {
		enable = true,
		color = { r = 1, g = 1, b = 1, a = 1 },
		priority = 30,
		threshold = 80,
		range = false,
		useClassColors = true,
	},
	alert_lowHealth = {
		text = L["Low HP"],
		enable = true,
		color = { r = 1, g = 1, b = 1, a = 1 },
		priority = 30,
		threshold = 80,
		range = false,
	},
	alert_death = {
		text = L["DEAD"],
		enable = true,
		color = { r = 0.5, g = 0.5, b = 0.5, a = 1 },
		icon = "Interface\\TargetingFrame\\UI-TargetingFrame-Skull",
		priority = 50,
		range = false,
	},
	alert_feignDeath = {
		text = L["FD"],
		enable = true,
		color = { r = 0.5, g = 0.5, b = 0.5, a = 1 },
		icon = "Interface\\Icons\\Ability_Rogue_FeignDeath",
		priority = 55,
		range = false,
	},
	alert_offline = {
		text = L["Offline"],
		enable = true,
		color = { r = 1, g = 1, b = 1, a = 0.6 },
		priority = 60,
		range = false,
	},
}

GridStatusHealth.extraOptions = {
	["deadAsFullHealth"] = {
		type = "toggle",
		name = L["Show dead as full health"],
		desc = L["Treat dead units as being full health."],
		order = 101,
		get = function ()
				return GridStatusHealth.db.profile.unit_health.deadAsFullHealth
			end,
		set = function (v)
				GridStatusHealth.db.profile.unit_health.deadAsFullHealth = v
				GridStatusHealth:UpdateAllUnits()
			end,
	},
}

local healthOptions = {
	["enable"] = false, -- you can't disable this
	["useClassColors"] = {
		type = "toggle",
		name = L["Use class color"],
		desc = L["Color health based on class."],
		get = function ()
				return GridStatusHealth.db.profile.unit_health.useClassColors
			end,
		set = function (v)
				GridStatusHealth.db.profile.unit_health.useClassColors = v
				GridStatusHealth:UpdateAllUnits()
			end,
	},
}

local healthDeficitOptions = {
	["threshold"] = {
		type = "range",
		name = L["Health threshold"],
		desc = L["Only show deficit above % damage."],
		max = 100,
		min = 0,
		step = 1,
		get = function ()
				return GridStatusHealth.db.profile.unit_healthDeficit.threshold
			end,
		set = function (v)
				GridStatusHealth.db.profile.unit_healthDeficit.threshold = v
				GridStatusHealth:UpdateAllUnits()
			end,
	},
	["useClassColors"] = {
		type = "toggle",
		name = L["Use class color"],
		desc = L["Color deficit based on class."],
		get = function ()
				return GridStatusHealth.db.profile.unit_healthDeficit.useClassColors
			end,
		set = function (v)
				GridStatusHealth.db.profile.unit_healthDeficit.useClassColors = v
				GridStatusHealth:UpdateAllUnits()
			end,
	},
}

local low_healthOptions = {
	["threshold"] = {
		type = "range",
		name = L["Low HP threshold"],
		desc = L["Set the HP % for the low HP warning."],
		max = 100,
		min = 0,
		step = 1,
		get = function ()
				return GridStatusHealth.db.profile.alert_lowHealth.threshold
			end,
		set = function (v)
				GridStatusHealth.db.profile.alert_lowHealth.threshold = v
				GridStatusHealth:UpdateAllUnits()
			end,
	},
}

function GridStatusHealth:OnInitialize()
	self.super.OnInitialize(self)

	self:RegisterStatus("unit_health", L["Unit health"], healthOptions)
	self:RegisterStatus("unit_healthDeficit", L["Health deficit"], healthDeficitOptions)
	self:RegisterStatus("alert_lowHealth", L["Low HP warning"], low_healthOptions)
	self:RegisterStatus("alert_death", L["Death warning"], nil, true)
	self:RegisterStatus("alert_feignDeath", L["Feign Death warning"], nil, true)
	self:RegisterStatus("alert_offline", L["Offline warning"], nil, true)
end

-- you can't disable the unit_health status, so no need to ever unregister
function GridStatusHealth:OnEnable()
	self:RegisterEvent("Grid_UnitJoined")

	self:RegisterEvent("UNIT_HEALTH", "UpdateUnit")
	self:RegisterEvent("UNIT_MAXHEALTH", "UpdateUnit")
	self:RegisterEvent("UNIT_AURA", "UpdateUnit")

	self:RegisterEvent("UNIT_NAME_UPDATE", "UpdateUnit")

	self:RegisterEvent("RAID_ROSTER_UPDATE", "UpdateAllUnits")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED", "UpdateAllUnits")

	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateAllUnits")
	self:RegisterEvent("Grid_ColorsChanged", "UpdateAllUnits")
end

function GridStatusHealth:OnStatusEnable(status)
	self:UpdateAllUnits()
end

function GridStatusHealth:OnStatusDisable(status)
	self.core:SendStatusLostAllUnits(status)
end

function GridStatusHealth:Reset()
	self.super.Reset(self)
	self:UpdateAllUnits()
end

function GridStatusHealth:UpdateAllUnits()
	for guid, unitid in GridRoster:IterateRoster() do
		self:Grid_UnitJoined(guid, unitid)
	end
end

function GridStatusHealth:Grid_UnitJoined(guid, unitid)
	if unitid then
		self:UpdateUnit(unitid, true)
		self:UpdateUnit(unitid)
	end
end

function GridStatusHealth:UpdateUnit(unitid, ignoreRange)
	local guid = UnitGUID(unitid)

	if not GridRoster:IsGUIDInRaid(guid) then
		return
	end

	local cur, max = UnitHealth(unitid), UnitHealthMax(unitid)

	local healthSettings = self.db.profile.unit_health
	local deficitSettings = self.db.profile.unit_healthDeficit
	local healthPriority = healthSettings.priority
	local deficitPriority = deficitSettings.priority

	if UnitIsDeadOrGhost(unitid) then
		self:StatusDeath(guid, true)
		self:StatusFeignDeath(guid, false)
		self:StatusLowHealth(guid, false)
		if healthSettings.deadAsFullHealth then
			cur = max
		end
	else
		self:StatusDeath(guid, false)
		self:StatusFeignDeath(guid, UnitIsFeignDeath(unitid))
		self:StatusLowHealth(guid, self:IsLowHealth(cur, max))
	end

	self:StatusOffline(guid, not UnitIsConnected(unitid))

	local healthText
	local deficitText

	if cur < max then
		if cur > 999 then
			healthText = string.format("%.1fk", cur / 1000)
		else
			healthText = string.format("%d", cur)
		end

		local deficit = max - cur
		if deficit > 999 then
			deficitText = string.format("-%.1fk", deficit / 1000)
		else
			deficitText = string.format("-%d", deficit)
		end
	else
		healthPriority = 1
		deficitPriority = 1
	end

	if (cur / max * 100) <= deficitSettings.threshold then
		self.core:SendStatusGained(guid, "unit_healthDeficit",
			deficitPriority,
			(deficitSettings.range and 40),
			(deficitSettings.useClassColors and self.core:UnitColor(guid) or deficitSettings.color),
			deficitText,
			cur, max,
			deficitSettings.icon)
	else
		self.core:SendStatusLost(guid, "unit_healthDeficit")
	end

	self.core:SendStatusGained(guid, "unit_health",
		healthPriority,
		(not ignoreRange and healthSettings.range and 40),
		(healthSettings.useClassColors and self.core:UnitColor(guid) or healthSettings.color),
		healthText,
		cur, max,
		healthSettings.icon)
end

function GridStatusHealth:IsLowHealth(cur, max)
	return (cur / max * 100) <= self.db.profile.alert_lowHealth.threshold
end

function GridStatusHealth:StatusLowHealth(guid, gained)
	local settings = self.db.profile.alert_lowHealth

	-- return if this option isnt enabled
	if not settings.enable then return end

	if gained then
		self.core:SendStatusGained(guid, "alert_lowHealth",
			settings.priority,
			(settings.range and 40),
			settings.color,
			settings.text,
			nil,
			nil,
			settings.icon)
	else
		self.core:SendStatusLost(guid, "alert_lowHealth")
	end
end

function GridStatusHealth:StatusDeath(guid, gained)
	local settings = self.db.profile.alert_death

	if not guid then return end

	-- return if this option isnt enabled
	if not settings.enable then return end

	if gained then
		-- trigger death event for other modules as wow isnt firing a death event
		self:TriggerEvent("Grid_UnitDeath", guid)
		self.core:SendStatusGained(guid, "alert_death",
			settings.priority,
			(settings.range and 40),
			settings.color,
			settings.text,
			(self.db.profile.unit_health.deadAsFullHealth and 100 or 0),
			100,
			settings.icon)
	else
		self.core:SendStatusLost(guid, "alert_death")
	end
end

function GridStatusHealth:StatusFeignDeath(guid, gained)
	local settings = self.db.profile.alert_feignDeath

	if not name then return end

	-- return if this option isnt enabled
	if not settings.enable then return end

	if gained then
		self.core:SendStatusGained(guid, "alert_feignDeath",
			settings.priority,
			(settings.range and 40),
			settings.color,
			settings.text,
			(self.db.profile.unit_health.deadAsFullHealth and 100 or 0),
			100,
			settings.icon)
	else
		self.core:SendStatusLost(guid, "alert_feignDeath")
	end
end

function GridStatusHealth:StatusOffline(guid, gained)
	local settings = self.db.profile.alert_offline

	if not guid then return end

	if gained then
		-- trigger offline event for other modules
		self:TriggerEvent("Grid_UnitOffline", guid)
		self.core:SendStatusGained(guid, "alert_offline",
			settings.priority,
			(settings.range and 40),
			settings.color,
			settings.text,
			nil,
			nil,
			settings.icon)
	else
		self.core:SendStatusLost(guid, "alert_offline")
	end
end
