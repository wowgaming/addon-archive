--[[--------------------------------------------------------------------
	GridStatusMana.lua
	GridStatus module for tracking unit mana.
----------------------------------------------------------------------]]

local _, ns = ...
local L = ns.L

local GridRoster = Grid:GetModule("GridRoster")
local GridStatus = Grid:GetModule("GridStatus")

local GridStatusMana = GridStatus:NewModule("GridStatusMana")
GridStatusMana.menuName = L["Mana"]

GridStatusMana.defaultDB = {
	debug = false,
	alert_lowMana = {
		text = L["Low Mana"],
		enable = true,
		color = { r = .5, g = .5, b = 1, a = 1 },
		priority = 40,
		threshold = 10,
		range = false,
	},
}

GridStatusMana.options = false

local low_manaOptions = {
	["threshold"] = {
		type = "range",
		name = L["Mana threshold"],
		desc = L["Set the percentage for the low mana warning."],
		max = 100,
		min = 0,
		step = 1,
		get = function ()
			      return GridStatusMana.db.profile.alert_lowMana.threshold
		      end,
		set = function (v)
			      GridStatusMana.db.profile.alert_lowMana.threshold = v
		      end,
	},
}

function GridStatusMana:OnInitialize()
	self.super.OnInitialize(self)
	self:RegisterStatus("alert_lowMana", L["Low Mana warning"], low_manaOptions, true)
end

function GridStatusMana:OnStatusEnable(status)
	if status == "alert_lowMana" then
		self:RegisterEvent("Grid_UnitJoined")
		self:RegisterEvent("UNIT_MANA", "UpdateUnit")
		self:UpdateAllUnits()
	end
end

function GridStatusMana:OnStatusDisable(status)
	if status == "alert_lowMana" then
		self:UnregisterEvent("Grid_UnitJoined")
		self:UnregisterEvent("UNIT_MANA")
		self.core:SendStatusLostAllUnits("alert_lowMana")
	end
end

function GridStatusMana:Grid_UnitJoined(guid, unitid)
	if unitid then
		self:UpdateUnit(unitid)
	end
end

function GridStatusMana:UpdateAllUnits()
	for guid, unitid in GridRoster:IterateRoster() do
		self:UpdateUnit(unitid)
	end
end

function GridStatusMana:UpdateUnit(unitid)
	local guid = UnitGUID(unitid)
	if not GridRoster:IsGUIDInRaid(guid) then return end
	local powerType, powerTypeName = UnitPowerType(unitid)

	-- mana user and is alive
	if powerType == 0 and not UnitIsDeadOrGhost(unitid) then
		local cur, max = UnitMana(unitid), UnitManaMax(unitid)

		local mana_percent = (cur / max * 100)
		local threshold = self.db.profile.alert_lowMana.threshold

		self:StatusLowMana(guid, mana_percent <= threshold)
	else
		self:StatusLowMana(guid, false)
	end
end

function GridStatusMana:StatusLowMana(guid, gained)
	local settings = self.db.profile.alert_lowMana

	-- return if this option isnt enabled
	if not settings.enable then return end

	if gained then
		GridStatus:SendStatusGained(guid, "alert_lowMana",
			settings.priority,
			(settings.range and 40),
			settings.color,
			settings.text,
			nil,
			nil,
			settings.icon)
	else
		GridStatus:SendStatusLost(guid, "alert_lowMana")
	end
end
