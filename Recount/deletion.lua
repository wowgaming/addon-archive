-- Elsia: For delete on instance entry
-- Deletes data whenever a new, not the same instance is entered. This should safe-guard against corpse-run-reenters and the like.
local revision = tonumber(string.sub("$Revision: 1115 $", 12, -3))
local Recount = _G.Recount
if Recount.Version < revision then Recount.Version = revision end

local UnitIsGhost = UnitIsGhost
local GetNumRaidMembers = GetNumRaidMembers
local GetNumPartyMembers = GetNumPartyMembers

function Recount:DetectInstanceChange() -- Elsia: With thanks to Loggerhead

--	local zone = GetRealZoneText()
 	local zone = GetInstanceInfo() -- Elsia; GetInstanceInfo() is robust at PEW!

	if zone == nil or zone == "" then
		-- zone hasn't been loaded yet, try again in 5 secs.
		self:ScheduleTimer("DetectInstanceChange",5)
		return
	end

	if UnitIsGhost(Recount.PlayerName) then
		return
	end
--[[	local groupType

	if Recount.inRaid then
	   groupType = 2
	elseif Recount.inGroup then
	   groupType = 1
	else
	   groupType = 0
	end

	local inInstance, instanceType = IsInInstance()
	if Recount.SetZoneGroupFilter and not UnitIsGhost(Recount.PlayerName) then Recount:SetZoneGroupFilter(instanceType, groupType) end -- Use zone-based filters.
--]]
	Recount:UpdateZoneGroupFilter()

	if not Recount.db.profile.AutoDeleteNewInstance then return end
	
	local ct = 0; for k,v in pairs(Recount.db2.combatants) do ct = ct + 1; break; end
	if ct==0 then -- Elsia: Already deleted
		return
	end

	local inInstance, instanceType = IsInInstance()
	
	if inInstance and (not Recount.db.profile.DeleteNewInstanceOnly or Recount.db.profile.LastInstanceName ~= zone) and Recount.CurrentDataCollect then
		if Recount.db.profile.ConfirmDeleteInstance == true then
--			Recount:DPrint("Instance based deletion: Old: "..Recount.db.profile.LastInstanceName.." New: "..zone)
			Recount:ShowReset() -- Elsia: Confirm & Delete!
		else
			Recount:ResetData()		-- Elsia: Delete!
		end
		Recount.db.profile.LastInstanceName = zone -- Elsia: We'll set the instance even if the user opted to not delete...
	end
end

-- Elsia: For delete on join raid/group

function Recount:PartyMembersChanged()

	local ct = 0; for k,v in pairs(Recount.db2.combatants) do ct = ct + 1; break; end
	local NumRaidMembers = GetNumRaidMembers()
	local NumPartyMembers = GetNumPartyMembers()

	if ct~=0 and Recount.db.profile.DeleteJoinRaid and not Recount.inRaid and NumRaidMembers > 0 and Recount.CurrentDataCollect then
		if Recount.db.profile.ConfirmDeleteRaid then
--			Recount:DPrint("Raid based deletion")
			Recount:ShowReset() -- Elsia: Confirm & Delete!
		else
			Recount:ResetData()		-- Elsia: Delete!
		end
		
		if Recount.RequestVersion then Recount:RequestVersion() end -- Elsia: If LazySync is present request version when entering raid
	end

	if ct~=0 and Recount.db.profile.DeleteJoinGroup and not Recount.inGroup and NumPartyMembers > 0 and NumRaidMembers == 0 and Recount.CurrentDataCollect then
		if Recount.db.profile.ConfirmDeleteGroup then
--			Recount:DPrint("Group based deletion")
			Recount:ShowReset() -- Elsia: Confirm & Delete!
		else
			Recount:ResetData()		-- Elsia: Delete!
		end

		if Recount.RequestVersion then Recount:RequestVersion() end -- Elsia: If LazySync is present request version when entering party
	end
	
	local change = false
	
	if NumPartyMembers > 0 then -- Elsia: This seems to be always true -> or UnitInParty("player")
		change = not Recount.inGroup
		Recount.inGroup = true
	else
		change = Recount.inGroup
		Recount.inGroup = false
	end

	if NumRaidMembers > 0 or UnitInRaid("player") then
		change = change or not Recount.inRaid
	   Recount.inRaid = true
	else
		change = change or Recount.inRaid
		Recount.inRaid = false
	end

	if change then
		Recount:UpdateZoneGroupFilter()
	end
	
	if Recount.GroupCheck then Recount:GroupCheck() end -- Elsia: Reevaluate group flagging on group changes.
end

function Recount:InitPartyBasedDeletion()
	local NumRaidMembers = GetNumRaidMembers()
	local NumPartyMembers = GetNumPartyMembers()

	Recount.inGroup = false
	Recount.inRaid = false

	if NumPartyMembers > 0 and NumRaidMembers == 0 then Recount.inGroup = true end
	if NumRaidMembers > 0 then Recount.inRaid = true end

	Recount:RegisterEvent("PARTY_MEMBERS_CHANGED","PartyMembersChanged")
	
	Recount:RegisterEvent("RAID_ROSTER_UPDATE","PartyMembersChanged")
	Recount:UpdateZoneGroupFilter()
end

function Recount:ReleasePartyBasedDeletion()
	if Recount.db.profile.DeleteJoinGroup == false and Recount.db.profile.DeleteJoinRaid == false then
		Recount:UnregisterEvent("PARTY_MEMBERS_CHANGED")
		Recount:UnregisterEvent("RAID_ROSTER_UPDATE")
	end
end
