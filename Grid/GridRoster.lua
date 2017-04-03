--[[--------------------------------------------------------------------
	GridRoster.lua
	Keeps track of GUID <-> name <-> unitID mappings for party/raid members.
----------------------------------------------------------------------]]

local GridRoster = Grid:NewModule("GridRoster")

GridRoster.defaultDB = {
	party_state = "solo",
}

--
local UnitExists = UnitExists
local UnitName = UnitName
local UnitGUID = UnitGUID

-- roster[attribute_name][guid] = value
local roster = {
	name = {},
	realm = {},
	unitid = {},
	guid = {},
}

-- for debugging
GridRoster.roster = roster

--
local my_realm = GetRealmName()

-- unit tables
local party_units = {}
local raid_units = {}
local pet_of_unit = {}
local owner_of_unit = {}

do
	-- populate unit tables
	local function register_unit(tbl, unit, pet)
		table.insert(tbl, unit)
		pet_of_unit[unit] = pet
		owner_of_unit[pet] = unit
	end

	register_unit(party_units, "player", "pet")

	for i = 1, MAX_PARTY_MEMBERS do
		register_unit(party_units, ("party%d"):format(i),
					  ("partypet%d"):format(i))
	end

	for i = 1, MAX_RAID_MEMBERS do
		register_unit(raid_units, ("raid%d"):format(i),
					  ("raidpet%d"):format(i))
	end
end

function GridRoster:OnInitialize()
	-- empty roster
	for attr, attr_tbl in pairs(roster) do
		for k in pairs(attr_tbl) do
			attr_tbl[k] = nil
		end
	end
end

function GridRoster:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UNIT_PET", "UpdateRoster")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED", "UpdateRoster")
	self:RegisterEvent("RAID_ROSTER_UPDATE", "UpdateRoster")

	self:RegisterEvent("UNIT_NAME_UPDATE", "UpdateRoster")
	self:RegisterEvent("UNIT_PORTRAIT_UPDATE", "UpdateRoster")

	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "PartyTransitionCheck")

	self:UpdateRoster()
end

function GridRoster:GetGUIDByName(name, realm)
	if realm == my_realm or realm == "" then realm = nil end
	for guid, unit_name in pairs(roster.name) do
		if name == unit_name and roster.realm[guid] == realm then
			return guid
		end
	end
end

function GridRoster:GetNameByGUID(guid)
	return roster.name[guid], roster.realm[guid]
end

function GridRoster:GetGUIDByFullName(full_name)
	local name, realm = full_name:match("^([^%-]+)%-(.*)$")
	return self:GetGUIDByName(name or full_name, realm)
end

function GridRoster:GetFullNameByGUID(guid)
	local name, realm = self:GetNameByGUID(guid)

	if realm then
		return name .. "-" .. realm
	else
		return name
	end
end

function GridRoster:GetUnitidByGUID(guid)
	return roster.unitid[guid]
end

function GridRoster:GetOwnerUnitidByGUID(guid)
	local unitid = roster.unitid[guid]
	return owner_of_unit[unitid]
end

function GridRoster:GetPetUnitidByUnitid(unitid)
	return pet_of_unit[unitid]
end

function GridRoster:GetOwnerUnitidByUnitid(unitid)
	return owner_of_unit[unitid]
end

function GridRoster:IsGUIDInRaid(guid)
	return roster.guid[guid] ~= nil
end

function GridRoster:IterateRoster()
	return pairs(roster.unitid)
end

-- roster updating
do
	local units_to_remove = {}
	local units_added = {}
	local units_updated = {}

	local function UpdateUnit(unit)
		local name, realm = UnitName(unit)
		local guid = UnitGUID(unit)

		if guid then
			if realm == "" then realm = nil end

			if units_to_remove[guid] then
				units_to_remove[guid] = nil

				local old_name = roster.name[guid]
				local old_realm = roster.realm[guid]
				local old_unitid = roster.unitid[guid]

				if old_name ~= name or old_realm ~= realm or
					old_unitid ~= unit then
					units_updated[guid] = true
				end
			else
				units_added[guid] = true
			end

			roster.name[guid] = name
			roster.realm[guid] = realm
			roster.unitid[guid] = unit
			roster.guid[guid] = guid
		end
	end

	function GridRoster:PLAYER_ENTERING_WORLD()
		local old_state = self.db.profile.party_state
		-- handle jumping from one BG to another
		-- arenas too, just to be safe
		if old_state == "bg" or old_state == "arena" then
			self.db.profile.party_state = "solo"
		end

		return self:UpdateRoster()
	end

	function GridRoster:UpdateRoster()
		for guid, unit in pairs(roster.unitid) do
			units_to_remove[guid] = true
		end

		local units
		if GetNumRaidMembers() == 0 then
			units = party_units
		else
			units = raid_units
		end

		for _, unit in ipairs(units) do
			if unit and UnitExists(unit) then
				UpdateUnit(unit)

				local unitpet = pet_of_unit[unit]
				if unitpet and UnitExists(unitpet) then
					UpdateUnit(unitpet)
				end
			end
		end

		local updated = false

		for guid in pairs(units_to_remove) do
			updated = true
			self:TriggerEvent("Grid_UnitLeft", guid)

			for attr, attr_tbl in pairs(roster) do
				attr_tbl[guid] = nil
			end

			units_to_remove[guid] = nil
		end

		self:PartyTransitionCheck()

		for guid in pairs(units_added) do
			updated = true
			self:TriggerEvent("Grid_UnitJoined", guid, roster.unitid[guid])

			units_added[guid] = nil
		end

		for guid in pairs(units_updated) do
			updated = true
			self:TriggerEvent("Grid_UnitChanged", guid, roster.unitid[guid])

			units_updated[guid] = nil
		end

		if updated then
			self:TriggerEvent("Grid_RosterUpdated")
		end
	end
end

-- Party transitions
do
	GridRoster.party_states = {
		'solo',
		'party',
		'heroic_raid',
		'raid',
		'bg',
		'arena',
	}

	local function GetPartyState()
		local _, instance_type = IsInInstance()

		if instance_type == "arena" then
			return "arena"
		end

		if instance_type == "pvp" then
			return "bg"
		end

		if GetNumRaidMembers() > 0 then
			if instance_type == "none" and GetZonePVPInfo() == "combat" then
				return "bg"
			end
			if instance_type == "raid" then
				local _, _, _, _, max_players = GetInstanceInfo()
				return max_players > 10 and "heroic_raid" or "raid"
			else
				local raid_difficulty = GetRaidDifficulty()
				return (raid_difficulty == 2 or raid_difficulty == 4) and "heroic_raid" or "raid"
			end
		end

		if GetNumPartyMembers() > 0 then
			return "party"
		end

		return "solo"
	end

	function GridRoster:PartyTransitionCheck()
		local current_state = GetPartyState()
		local old_state = self.db.profile.party_state

		if current_state ~= old_state then
			self.db.profile.party_state = current_state
			self:TriggerEvent("Grid_PartyTransition", current_state, old_state)
		end
	end

	function GridRoster:GetPartyState()
		return self.db.profile.party_state
	end
end