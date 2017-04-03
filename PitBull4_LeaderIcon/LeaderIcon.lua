if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_LeaderIcon requires PitBull4")
end

local L = PitBull4.L

local PitBull4_LeaderIcon = PitBull4:NewModule("LeaderIcon", "AceEvent-3.0", "AceTimer-3.0")

PitBull4_LeaderIcon:SetModuleType("indicator")
PitBull4_LeaderIcon:SetName(L["Leader icon"])
PitBull4_LeaderIcon:SetDescription(L["Show an icon on the unit frame when the unit is the group leader."])
PitBull4_LeaderIcon:SetDefaults({
	attach_to = "root",
	location = "edge_top_left",
	position = 1,
})

local leader_guid

function PitBull4_LeaderIcon:OnEnable()
	self:RegisterEvent("PARTY_LEADER_CHANGED")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED")
end

function PitBull4_LeaderIcon:GetTexture(frame)
	if frame.guid == leader_guid then
		return [[Interface\GroupFrame\UI-Group-LeaderIcon]]
	else
		return nil
	end
end

function PitBull4_LeaderIcon:GetExampleTexture(frame)
	return [[Interface\GroupFrame\UI-Group-LeaderIcon]]
end

function PitBull4_LeaderIcon:GetTexCoord(frame, texture)
	return 0.1, 0.84, 0.14, 0.88
end
PitBull4_LeaderIcon.GetExampleTexCoord = PitBull4_LeaderIcon.GetTexCoord

local function update_leader_guid()
	local raid_size = GetNumRaidMembers()
	if raid_size > 0 then
		-- in a raid
		if IsRaidLeader() then
			-- player is the leader
			leader_guid = UnitGUID("player")
		else
			-- find the unit that is the leader
			for i = 1, raid_size do
				local _, rank = GetRaidRosterInfo(i)
				if rank == 2 then
					leader_guid = UnitGUID("raid"..i)
					break
				end
			end
		end
	else
		local party_size = GetNumPartyMembers()
		if party_size > 0 then
			-- in a party
			if IsPartyLeader() then
				-- player is the leader
				leader_guid = UnitGUID("player")
			else
				leader_guid = UnitGUID("party"..GetPartyLeaderIndex())
			end
		else
			-- not in a raid or a party
			leader_guid = nil
		end
	end
	PitBull4_LeaderIcon:UpdateAll()
end

function PitBull4_LeaderIcon:PARTY_LEADER_CHANGED()
	self:ScheduleTimer(update_leader_guid, 0.1)
end
PitBull4_LeaderIcon.PARTY_MEMBERS_CHANGED = PitBull4_LeaderIcon.PARTY_LEADER_CHANGED
