local Indicators = {list = {"status", "pvp", "leader", "masterLoot", "raidTarget", "happiness", "ready", "role", "lfdRole"}}
local leavingWorld

ShadowUF:RegisterModule(Indicators, "indicators", ShadowUF.L["Indicators"])

function Indicators:UpdateHappiness(frame)
	if( not frame.indicators.happiness or not frame.indicators.happiness.enabled ) then return end

	local happiness = GetPetHappiness()
	if( not happiness ) then
		frame.indicators.happiness:Hide()
	elseif( happiness == 3 ) then
		frame.indicators.happiness:SetTexCoord(0, 0.1875, 0, 0.359375)
		frame.indicators.happiness:Show()
	elseif( happiness == 2 ) then
		frame.indicators.happiness:SetTexCoord(0.1875, 0.375, 0, 0.359375)
		frame.indicators.happiness:Show()
	elseif( happiness == 1 ) then
		frame.indicators.happiness:SetTexCoord(0.375, 0.5625, 0, 0.359375)
		frame.indicators.happiness:Show()
	end
end

function Indicators:UpdateMasterLoot(frame)
	if( not frame.indicators.masterLoot or not frame.indicators.masterLoot.enabled ) then return end

	local lootType, partyID, raidID = GetLootMethod()
	if( lootType ~= "master" ) then
		frame.indicators.masterLoot:Hide()
	elseif( ( partyID and partyID == 0 and UnitIsUnit(frame.unit, "player") ) or ( partyID and partyID > 0 and UnitIsUnit(frame.unit, ShadowUF.partyUnits[partyID]) ) or ( raidID and raidID > 0 and UnitIsUnit(frame.unit, ShadowUF.raidUnits[raidID]) ) ) then
		frame.indicators.masterLoot:Show()
	else
		frame.indicators.masterLoot:Hide()
	end
end
			
function Indicators:UpdateRaidTarget(frame)
	if( not frame.indicators.raidTarget or not frame.indicators.raidTarget.enabled ) then return end

	if( UnitExists(frame.unit) and GetRaidTargetIndex(frame.unit) ) then
		SetRaidTargetIconTexture(frame.indicators.raidTarget, GetRaidTargetIndex(frame.unit))
		frame.indicators.raidTarget:Show()
	else
		frame.indicators.raidTarget:Hide()
	end
end

function Indicators:UpdateLFDRole(frame, event)
	if( not frame.indicators.lfdRole or not frame.indicators.lfdRole.enabled ) then return end
	
	local isTank, isHealer, isDamage = UnitGroupRolesAssigned(frame.unitOwner)
	if( isTank ) then
		frame.indicators.lfdRole:SetTexCoord(0, 19/64, 22/64, 41/64)
		frame.indicators.lfdRole:Show()
	elseif( isHealer ) then
		frame.indicators.lfdRole:SetTexCoord(20/64, 39/64, 1/64, 20/64)
		frame.indicators.lfdRole:Show()
	elseif( isDamage ) then
		frame.indicators.lfdRole:SetTexCoord(20/64, 39/64, 22/64, 41/64)
		frame.indicators.lfdRole:Show()
	else
		frame.indicators.lfdRole:Hide()
	end	
end

function Indicators:UpdateRole(frame, event)
	if( not frame.indicators.role or not frame.indicators.role.enabled ) then return end
	
	if( leavingWorld or not UnitInRaid(frame.unit) and not UnitInParty(frame.unit) ) then
		frame.indicators.role:Hide()
	elseif( GetPartyAssignment("MAINTANK", frame.unit) ) then
		frame.indicators.role:SetTexture("Interface\\GroupFrame\\UI-Group-MainTankIcon")
		frame.indicators.role:Show()
	elseif( GetPartyAssignment("MAINASSIST", frame.unit) ) then
		frame.indicators.role:SetTexture("Interface\\GroupFrame\\UI-Group-MainAssistIcon")
		frame.indicators.role:Show()
	else
		frame.indicators.role:Hide()
	end
end

function Indicators:UpdateLeader(frame)
	self:UpdateMasterLoot(frame)
	self:UpdateRole(frame)
	self:UpdateLFDRole(frame)
	if( not frame.indicators.leader or not frame.indicators.leader.enabled ) then return end

	if( UnitIsPartyLeader(frame.unit) ) then
		frame.indicators.leader:Show()
	else
		frame.indicators.leader:Hide()
	end
end

function Indicators:UpdatePVPFlag(frame)
	if( not frame.indicators.pvp or not frame.indicators.pvp.enabled ) then return end

	if( UnitIsPVP(frame.unit) and UnitFactionGroup(frame.unit) ) then
		frame.indicators.pvp:SetTexture(string.format("Interface\\TargetingFrame\\UI-PVP-%s", UnitFactionGroup(frame.unit)))
		frame.indicators.pvp:Show()
	elseif( UnitIsPVPFreeForAll(frame.unit) ) then
		frame.indicators.pvp:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA")
		frame.indicators.pvp:Show()
	else
		frame.indicators.pvp:Hide()
	end
end

-- Non-player units do not give events when they enter or leave combat, so polling is necessary
local function combatMonitor(self, elapsed)
	self.timeElapsed = self.timeElapsed + elapsed
	if( self.timeElapsed < 1 ) then return end
	self.timeElapsed = self.timeElapsed - 1
	
	if( UnitAffectingCombat(self.parent.unit) ) then
		self.status:Show()
	else
		self.status:Hide()
	end
end

-- It looks like the combat check for players is a bit buggy when they are in a vehicle, so swap it to also check polling
function Indicators:CheckVehicle(frame)
	frame.indicators.timeElapsed = 0
	frame.indicators:SetScript("OnUpdate", frame.inVehicle and combatMonitor or nil)
end

function Indicators:UpdateStatus(frame)
	if( not frame.indicators.status or not frame.indicators.status.enabled ) then return end

	if( UnitAffectingCombat(frame.unitOwner) ) then
		frame.indicators.status:SetTexCoord(0.50, 1.0, 0.0, 0.49)
		frame.indicators.status:Show()
	elseif( frame.unitRealType == "player" and IsResting() ) then
		frame.indicators.status:SetTexCoord(0.0, 0.50, 0.0, 0.421875)
		frame.indicators.status:Show()
	else
		frame.indicators.status:Hide()
	end
end

-- Ready check fading once the check complete
local function fadeReadyStatus(self, elapsed)
	self.timeLeft = self.timeLeft - elapsed
	self.ready:SetAlpha(self.timeLeft / self.startTime)
	
	if( self.timeLeft <= 0 ) then
		self:SetScript("OnUpdate", nil)

		self.ready.status = nil
		self.ready:Hide()
	end
end

local FADEOUT_TIME = 6
function Indicators:UpdateReadyCheck(frame, event)
	if( not frame.indicators.ready or not frame.indicators.ready.enabled ) then return end

	-- We're done, and should fade it out if it's shown
	if( event == "READY_CHECK_FINISHED" ) then
		if( not frame.indicators.ready:IsShown() ) then return end
		
		-- Create the central timer frame if ones not already made
		if( not self.fadeTimer ) then
			self.fadeTimer = CreateFrame("Frame", nil)
			self.fadeTimer.fadeList = {}
			self.fadeTimer:Hide()
			self.fadeTimer:SetScript("OnUpdate", function(self, elapsed)
				local hasTimer
				for frame, timeLeft in pairs(self.fadeList) do
					hasTimer = true
					
					self.fadeList[frame] = timeLeft - elapsed
					frame:SetAlpha(self.fadeList[frame] / FADEOUT_TIME)
					
					if( self.fadeList[frame] <= 0 ) then
						self.fadeList[frame] = nil
						frame:Hide()
					end
				end
				
				if( not hasTimer ) then self:Hide() end
			end)
		end
		
		-- Start the timer
		self.fadeTimer.fadeList[frame.indicators.ready] = FADEOUT_TIME
		self.fadeTimer:Show()
		
		-- Player never responded so they are AFK
		if( frame.indicators.ready.status == "waiting" ) then
			frame.indicators.ready:SetTexture("Interface\\RaidFrame\\ReadyCheck-NotReady")
		end
		return
	end
	
	-- Have a state change in ready status
	local status = GetReadyCheckStatus(frame.unit)
	if( not status ) then
		frame.indicators.ready.status = nil
		frame.indicators.ready:Hide()
		return
	end
	
	if( status == "ready" ) then
		frame.indicators.ready:SetTexture(READY_CHECK_READY_TEXTURE)
	elseif( status == "notready" ) then
		frame.indicators.ready:SetTexture(READY_CHECK_NOT_READY_TEXTURE)
	elseif( status == "waiting" ) then
		frame.indicators.ready:SetTexture(READY_CHECK_WAITING_TEXTURE)
	end

	frame.indicators:SetScript("OnUpdate", nil)
	frame.indicators.ready.status = status
	frame.indicators.ready:SetAlpha(1.0)
	frame.indicators.ready:Show()
end

function Indicators:OnEnable(frame)
	-- Forces the indicators to be above the bars/portraits/etc
	if( not frame.indicators ) then
		frame.indicators = CreateFrame("Frame", nil, frame)
		frame.indicators:SetFrameLevel(frame.topFrameLevel + 1)
	end
	
	-- Now lets enable all the indicators
	local config = ShadowUF.db.profile.units[frame.unitType]
	if( config.indicators.status and config.indicators.status.enabled ) then
		frame:RegisterUpdateFunc(self, "UpdateStatus")
		frame.indicators.status = frame.indicators.status or frame.indicators:CreateTexture(nil, "OVERLAY")
		frame.indicators.status:SetTexture("Interface\\CharacterFrame\\UI-StateIcon")
		frame.indicators.timeElapsed = 0
		frame.indicators.parent = frame

		if( frame.unitType == "player" ) then
			frame:RegisterUpdateFunc(self, "CheckVehicle")
			frame:RegisterNormalEvent("PLAYER_REGEN_ENABLED", self, "UpdateStatus")
			frame:RegisterNormalEvent("PLAYER_REGEN_DISABLED", self, "UpdateStatus")
			frame:RegisterNormalEvent("PLAYER_UPDATE_RESTING", self, "UpdateStatus")
			frame:RegisterNormalEvent("UPDATE_FACTION", self, "UpdateStatus")
		else
			frame.indicators.status:SetTexCoord(0.50, 1.0, 0.0, 0.49)
			frame.indicators:SetScript("OnUpdate", combatMonitor)
		end
	elseif( frame.indicators.status ) then
		frame.indicators:SetScript("OnUpdate", nil)
	end
		
	if( config.indicators.pvp and config.indicators.pvp.enabled ) then
		frame:RegisterUnitEvent("PLAYER_FLAGS_CHANGED", self, "UpdatePVPFlag")
		frame:RegisterUnitEvent("UNIT_FACTION", self, "UpdatePVPFlag")
		frame:RegisterUpdateFunc(self, "UpdatePVPFlag")

		frame.indicators.pvp = frame.indicators.pvp or frame.indicators:CreateTexture(nil, "OVERLAY")
	end
	
	if( config.indicators.leader and config.indicators.leader.enabled ) then
		frame:RegisterNormalEvent("PARTY_LEADER_CHANGED", self, "UpdateLeader")
		frame:RegisterUpdateFunc(self, "UpdateLeader")

		frame.indicators.leader = frame.indicators.leader or frame.indicators:CreateTexture(nil, "OVERLAY")
		frame.indicators.leader:SetTexture("Interface\\GroupFrame\\UI-Group-LeaderIcon")
	end
		
	if( config.indicators.masterLoot and config.indicators.masterLoot.enabled ) then
		frame:RegisterNormalEvent("PARTY_LOOT_METHOD_CHANGED", self, "UpdateMasterLoot")
		frame:RegisterNormalEvent("RAID_ROSTER_UPDATE", self, "UpdateMasterLoot")
		frame:RegisterUpdateFunc(self, "UpdateMasterLoot")

		frame.indicators.masterLoot = frame.indicators.masterLoot or frame.indicators:CreateTexture(nil, "OVERLAY")
		frame.indicators.masterLoot:SetTexture("Interface\\GroupFrame\\UI-Group-MasterLooter")
	end

	if( config.indicators.role and config.indicators.role.enabled ) then
		frame:RegisterUpdateFunc(self, "UpdateRole")

		frame.indicators.role = frame.indicators.role or frame.indicators:CreateTexture(nil, "OVERLAY")
		frame.indicators.role:SetTexture("Interface\\GroupFrame\\UI-Group-MainAssistIcon")
		
		-- Silly hack to fix the fact that Blizzard bugged an API and causes "<unit> is not in your party" errors
		if( not self.leavingFrame ) then
			self.leavingFrame = CreateFrame("Frame")
			self.leavingFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
			self.leavingFrame:RegisterEvent("PLAYER_LEAVING_WORLD")
			self.leavingFrame:SetScript("OnEvent", function(self, event)
				if( event == "PLAYER_LEAVING_WORLD" ) then
					leavingWorld = true
				else
					leavingWorld = nil
					
					for frame in pairs(ShadowUF.Units.frameList) do
						if( frame:IsVisible() and frame.indicators and frame.indicators.role and frame.indicators.role.enabled ) then
							Indicators:UpdateRole(frame)
						end
					end
				end
			end)
		end
	end
			
	if( config.indicators.raidTarget and config.indicators.raidTarget.enabled ) then
		frame:RegisterNormalEvent("RAID_TARGET_UPDATE", self, "UpdateRaidTarget")
		frame:RegisterUpdateFunc(self, "UpdateRaidTarget")
		
		frame.indicators.raidTarget = frame.indicators.raidTarget or frame.indicators:CreateTexture(nil, "OVERLAY")
		frame.indicators.raidTarget:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	end

	if( config.indicators.ready and config.indicators.ready.enabled ) then
		frame:RegisterNormalEvent("READY_CHECK", self, "UpdateReadyCheck")
		frame:RegisterNormalEvent("READY_CHECK_CONFIRM", self, "UpdateReadyCheck")
		frame:RegisterNormalEvent("READY_CHECK_FINISHED", self, "UpdateReadyCheck")
		frame:RegisterUpdateFunc(self, "UpdateReadyCheck")
		
		frame.indicators.ready = frame.indicators.ready or frame.indicators:CreateTexture(nil, "OVERLAY")
	end
	
	if( config.indicators.happiness and config.indicators.happiness.enabled ) then
		frame:RegisterUnitEvent("UNIT_HAPPINESS", self, "UpdateHappiness")
		frame:RegisterUpdateFunc(self, "UpdateHappiness")
		
		frame.indicators.happiness = frame.indicators.happiness or frame.indicators:CreateTexture(nil, "OVERLAY")
		frame.indicators.happiness:SetTexture("Interface\\PetPaperDollFrame\\UI-PetHappiness")
	end
	
	if( config.indicators.lfdRole and config.indicators.lfdRole.enabled ) then
		if( frame.unit == "player" ) then
			frame:RegisterNormalEvent("PLAYER_ROLES_ASSIGNED", self, "UpdateLFDRole")
		end
		
		frame.indicators.lfdRole = frame.indicators.lfdRole or frame.indicators:CreateTexture(nil, "OVERLAY")
		frame.indicators.lfdRole:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES")
	end

	-- As they all share the function, register it as long as one is active
	if( frame.indicators.leader or frame.indicators.masterLoot or frame.indicators.role or ( frame.unit ~= "player" and frame.indicators.lfdRole ) ) then
		frame:RegisterNormalEvent("PARTY_MEMBERS_CHANGED", self, "UpdateLeader")
	end
end

function Indicators:OnDisable(frame)
	frame:UnregisterAll(self)

	for _, key in pairs(self.list) do
		if( frame.indicators[key] ) then
			frame.indicators[key].enabled = nil
			frame.indicators[key]:Hide()
		end
	end
end

function Indicators:OnLayoutApplied(frame, config)
	if( frame.visibility.indicators ) then
		self:OnDisable(frame)
		self:OnEnable(frame)
		
		for _, key in pairs(self.list) do
			local indicator = frame.indicators[key]
			if( indicator and config.indicators[key].enabled and config.indicators[key].size ) then
				indicator.enabled = true
				indicator:SetHeight(config.indicators[key].size)
				indicator:SetWidth(config.indicators[key].size)
				ShadowUF.Layout:AnchorFrame(frame, indicator, config.indicators[key])
			elseif( indicator ) then
				indicator.enabled = nil
				indicator:Hide()
			end
		end
		
		-- Disable the polling
		if( config.indicators.status and not config.indicators.status.enabled and frame.indicators.status ) then
			frame.indicators:SetScript("OnUpdate", nil)
		end
	end
end