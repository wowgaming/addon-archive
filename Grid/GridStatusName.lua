--[[--------------------------------------------------------------------
	GridStatusName.lua
	GridStatus module for tracking unit names.
----------------------------------------------------------------------]]

local _, ns = ...
local L = ns.L

local GridRoster = Grid:GetModule("GridRoster")

local GridStatusName = Grid:GetModule("GridStatus"):NewModule("GridStatusName")
GridStatusName.menuName = L["Unit Name"]

GridStatusName.defaultDB = {
	debug = false,
	unit_name = {
		text = L["Unit Name"],
		enable = true,
		color = { r = 1, g = 1, b = 1, a = 1 },
		priority = 1,
		class = true,
		range = false,
	},
}

GridStatusName.options = false

local nameOptions = {
	["class"] = {
		type = 'toggle',
		name = L["Use class color"],
		desc = L["Color by class"],
		get = function() return GridStatusName.db.profile.unit_name.class end,
		set = function()
			GridStatusName.db.profile.unit_name.class = not GridStatusName.db.profile.unit_name.class
			GridStatusName:UpdateAllUnits()
		end,
	},
}

function GridStatusName:OnInitialize()
	self.super.OnInitialize(self)
	self:RegisterStatus("unit_name", L["Unit Name"], nameOptions, true)
end

function GridStatusName:OnStatusEnable(status)
	if status == "unit_name" then
		self:RegisterEvent("UNIT_NAME_UPDATE", "UpdateUnit")
		self:RegisterEvent("UNIT_PORTRAIT_UPDATE", "UpdateUnit")
		self:RegisterEvent("UNIT_ENTERED_VEHICLE", "UpdateVehicle")
		self:RegisterEvent("UNIT_EXITED_VEHICLE", "UpdateVehicle")
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateAllUnits")
		self:RegisterEvent("Grid_UnitJoined", "UpdateGUID")
		self:RegisterEvent("Grid_UnitChanged", "UpdateGUID")
		self:RegisterEvent("Grid_UnitLeft", "UpdateGUID")

		self:RegisterEvent("Grid_ColorsChanged", "UpdateAllUnits")
		self:UpdateAllUnits()
	end
end

function GridStatusName:OnStatusDisable(status)
	if status == "unit_name" then
		self:UnregisterEvent("UNIT_NAME_UPDATE")
		self:UnregisterEvent("UNIT_PORTRAIT_UPDATE")
		self:UnregisterEvent("UNIT_ENTERED_VEHICLE")
		self:UnregisterEvent("UNIT_EXITED_VEHICLE")
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		self:UnregisterEvent("Grid_UnitJoined")
		self:UnregisterEvent("Grid_UnitChanged")
		self:UnregisterEvent("Grid_UnitLeft")
		self:UnregisterEvent("Grid_ColorsChanged")

		self.core:SendStatusLostAllUnits("unit_name")
	end
end

function GridStatusName:Reset()
	self.super.Reset(self)
	self:UpdateAllUnits()
end

function GridStatusName:UpdateVehicle(unitid)
	self:UpdateUnit(unitid)
	local pet_unit = unitid .. "pet"
	if UnitExists(pet_unit) then
		self:UpdateUnit(pet_unit)
	end
end

function GridStatusName:UpdateUnit(unitid)
	self:UpdateGUID(UnitGUID(unitid))
end

function GridStatusName:UpdateGUID(guid)
	local settings = self.db.profile.unit_name

	local name = GridRoster:GetNameByGUID(guid)

	if not name or not settings.enable then return end

	-- set text
	local text = name

	local show_owner_name = true
	if show_owner_name then
		local unitid = GridRoster:GetUnitidByGUID(guid)
		local owner_unitid = GridRoster:GetOwnerUnitidByUnitid(unitid)

		-- does this unit have an owner?
		-- is the owner driving a vehicle?
		if owner_unitid and UnitHasVehicleUI(owner_unitid) then
			local owner_guid = UnitGUID(owner_unitid)
			local owner_name = GridRoster:GetNameByGUID(owner_guid)

			text = owner_name
		end
	end

	-- set color
	local color = settings.class and self.core:UnitColor(guid) or settings.color

	self.core:SendStatusGained(guid, "unit_name",
		settings.priority,
		nil,
		color,
		text)
end

function GridStatusName:UpdateAllUnits()
	for guid, unitid in GridRoster:IterateRoster() do
		self:UpdateGUID(guid)
	end
end
