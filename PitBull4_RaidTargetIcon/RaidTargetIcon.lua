if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_RaidTargetIcon requires PitBull4")
end

local L = PitBull4.L

local PitBull4_RaidTargetIcon = PitBull4:NewModule("RaidTargetIcon", "AceEvent-3.0", "AceTimer-3.0")

PitBull4_RaidTargetIcon:SetModuleType("indicator")
PitBull4_RaidTargetIcon:SetName(L["Raid target icon"])
PitBull4_RaidTargetIcon:SetDescription(L["Show an icon on the unit frame based on which Raid Target it is."])
PitBull4_RaidTargetIcon:SetDefaults({
	attach_to = "root",
	location = "edge_top",
	position = 1,
})

function PitBull4_RaidTargetIcon:OnEnable()
	self:RegisterEvent("RAID_TARGET_UPDATE")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED")
end

function PitBull4_RaidTargetIcon:GetTexture(frame)
	local unit = frame.unit
	
	local index = GetRaidTargetIndex(unit)
	
	if not index then
		return nil
	end
	
	return [[Interface\TargetingFrame\UI-RaidTargetingIcon_]] .. index
end

function PitBull4_RaidTargetIcon:GetExampleTexture(frame)
	local unit = frame.unit or frame:GetName()
	
	local index = unit:match(".*(%d+)")
	if index then
		index = index+0
	else
		index = 0
	end
	index = index + #unit + unit:byte()
	
	index = (index % 8) + 1
	
	return [[Interface\TargetingFrame\UI-RaidTargetingIcon_]] .. index
end

function PitBull4_RaidTargetIcon:RAID_TARGET_UPDATE()
	self:UpdateAll()
end

function PitBull4_RaidTargetIcon:PARTY_MEMBERS_CHANGED()
	self:ScheduleTimer("UpdateAll", 0.1)
end
