--[[--------------------------------------------------------------------
	GridStatusVehicle.lua
	GridStatus module for showing when a unit is driving a vehicle with a UI.
----------------------------------------------------------------------]]

local _, ns = ...
local L = ns.L
local GridRoster = Grid:GetModule("GridRoster")

local GridRoster = Grid:GetModule("GridRoster")

local GridStatusVehicle = Grid:GetModule("GridStatus"):NewModule("GridStatusVehicle")
GridStatusVehicle.menuName = L["In Vehicle"]

GridStatusVehicle.defaultDB = {
	debug = false,
	alert_vehicleui = {
		text = L["Driving"],
		enable = false,
		color = { r = 0.8, g = 0.8, b = 0.8, a = 0.7 },
		priority = 50,
		range = false,
	},
}

GridStatusVehicle.options = false

function GridStatusVehicle:OnInitialize()
	self.super.OnInitialize(self)
	self:RegisterStatus("alert_vehicleui", L["In Vehicle"], nil, true)
end

function GridStatusVehicle:OnStatusEnable(status)
	if status == "alert_vehicleui" then
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateAllUnits")
		self:RegisterEvent("UNIT_ENTERED_VEHICLE", "UpdateUnit")
		self:RegisterEvent("UNIT_EXITED_VEHICLE", "UpdateUnit")

		self:UpdateAllUnits()
	end
end

function GridStatusVehicle:OnStatusDisable(status)
	if status == "alert_vehicleui" then
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		self:UnregisterEvent("UNIT_ENTERED_VEHICLE")
		self:UnregisterEvent("UNIT_EXITED_VEHICLE")

		self.core:SendStatusLostAllUnits("alert_vehicleui")
	end
end

function GridStatusVehicle:UpdateAllUnits()
	for guid, unitid in GridRoster:IterateRoster() do
		self:UpdateUnit(unitid)
	end
end

function GridStatusVehicle:UpdateUnit(unitid)
	local pet_unitid = GridRoster:GetPetUnitidByUnitid(unitid)
	if not pet_unitid then return end

	local guid = UnitGUID(pet_unitid)

	if UnitHasVehicleUI(unitid) then
		local settings = self.db.profile.alert_vehicleui
		self.core:SendStatusGained(guid, "alert_vehicleui",
			settings.priority, (settings.range and 40),
			settings.color,
			settings.text,
			nil,
			nil,
			settings.icon)
	else
		self.core:SendStatusLost(guid, "alert_vehicleui")
	end
end
