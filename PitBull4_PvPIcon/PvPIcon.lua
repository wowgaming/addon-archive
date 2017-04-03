if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_PvPIcon requires PitBull4")
end

local L = PitBull4.L

local PitBull4_PvPIcon = PitBull4:NewModule("PvPIcon", "AceEvent-3.0")

PitBull4_PvPIcon:SetModuleType("indicator")
PitBull4_PvPIcon:SetName(L["PvP icon"])
PitBull4_PvPIcon:SetDescription(L["Show an icon on the unit frame when the unit is in PvP mode."])
PitBull4_PvPIcon:SetDefaults({
	attach_to = "root",
	location = "edge_top_right",
	position = 1,
})

function PitBull4_PvPIcon:OnEnable()
	self:RegisterEvent("UPDATE_FACTION")
	self:RegisterEvent("PLAYER_FLAGS_CHANGED")
	self:RegisterEvent("UNIT_FACTION")
end

function PitBull4_PvPIcon:GetTexture(frame)
	local unit = frame.unit
	
	if UnitIsPVPFreeForAll(unit) then
		return [[Interface\TargetingFrame\UI-PVP-FFA]]
	end
	
	if not UnitIsPVP(unit) then
		return nil
	end
	
	return [[Interface\TargetingFrame\UI-PVP-]] .. (UnitFactionGroup(unit) or UnitFactionGroup("player"))
end

local FRIENDLY_CLASSIFICATIONS = {
	player = true,
	pet = true,
	party = true,
	partypet = true,
	raid = true,
	raidpet = true,
	targettarget = true,
}
local OPPOSITE_PLAYER_FACTION = {
	["Horde"] = "Alliance",
	["Alliance"] = "Horde",
}
function PitBull4_PvPIcon:GetExampleTexture(frame)
	local classification = frame.classification
	if classification == "focus" then
		return [[Interface\TargetingFrame\UI-PVP-FFA]]
	end
	
	local player_faction = UnitFactionGroup("player")
	
	if FRIENDLY_CLASSIFICATIONS[classification] or (frame.guid and UnitIsFriend("player", frame.unit)) then
		return [[Interface\TargetingFrame\UI-PVP-]] .. player_faction
	else
		return [[Interface\TargetingFrame\UI-PVP-]] .. OPPOSITE_PLAYER_FACTION[player_faction]
	end
end

local tex_coords = {
	[ [[Interface\TargetingFrame\UI-PVP-FFA]] ] = {0.05, 0.605, 0.015, 0.57},
	[ [[Interface\TargetingFrame\UI-PVP-Horde]] ] = {0.08, 0.58, 0.045, 0.545},
	[ [[Interface\TargetingFrame\UI-PVP-Alliance]] ] = {0.07, 0.58, 0.06, 0.57},
}

function PitBull4_PvPIcon:GetTexCoord(frame, texture)
	local tex_coord = tex_coords[texture]
	return tex_coord[1], tex_coord[2], tex_coord[3], tex_coord[4]
end
PitBull4_PvPIcon.GetExampleTexCoord = PitBull4_PvPIcon.GetTexCoord

function PitBull4_PvPIcon:UPDATE_FACTION(event, unit)
	if not unit then
		unit = "player"
	end
	self:UpdateForUnitID(unit)
	local unit_pet = PitBull4.Utils.GetBestUnitID(unit .. "pet")
	if unit_pet then
		self:UpdateForUnitID(unit_pet)
	end
end
PitBull4_PvPIcon.PLAYER_FLAGS_CHANGED = PitBull4_PvPIcon.UPDATE_FACTION
PitBull4_PvPIcon.UNIT_FACTION = PitBull4_PvPIcon.UPDATE_FACTION
