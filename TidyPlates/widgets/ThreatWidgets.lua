
--local threatfont = "Interface\\Addons\\TidyPlates\\Media\\LiberationSans-Regular.ttf"
local threatfont =					"FONTS\\arialn.ttf"
---------------
-- General Functions
---------------

local function SetFade(frame)
	if GetTime() > frame.FadeTime then
		frame:Hide()
		frame:SetScript("OnUpdate", nil)
	end
end

-- /script print(RaidTankList)
-- /script print(select(RaidTankList)
local RaidTankList = {}
local IsPlayerTank = false
local IsPlayerInRaid = false
local function IsRaidTank(unitid)
	if UnitIsUnit("pet", unitid) then return true end		-- Testing
	
	return RaidTankList[UnitName(unitid)]
end

---------------
-- Threat Functions
---------------
local function GetThreatSegment(threat)
	if not threat then return nil end
	if threat > 133 then return "HIGHTANK"
	elseif threat > 116 then return "MEDIUMTANK"
	elseif threat > 100 then return "LOWTANK"
	elseif threat > 83 then return "HIGHDPS"
	elseif threat > 66 then return "MEDIUMDPS"
	else return "LOWDPS"  end
end

local GetRelativeThreat = TidyPlatesUtility.GetRelativeThreat

---------------
-- Roster Monitor
---------------
do
	local function UpdateRoster()
		local index, size
		if UnitInRaid("player") then
			size = GetNumRaidMembers() - 1
			for index = 1, size do
				local raidid = "raid"..tostring(index)
				local isAssigned = GetPartyAssignment("MAINTANK", raidid)
				if isAssigned then RaidTankList[UnitName(raidid)] = true 
				else RaidTankList[UnitName(raidid)] = nil end
			end			
		else wipe(RaidTankList)
		end
		
		IsPlayerInRaid = UnitInRaid("player")
		IsPlayerTank = GetPartyAssignment("MAINTANK", "player")
		
	end

	local RosterMonitor  = CreateFrame("Frame")
	RosterMonitor:RegisterEvent("RAID_ROSTER_UPDATE")
	RosterMonitor:RegisterEvent("PARTY_MEMBERS_CHANGED")
	RosterMonitor:RegisterEvent("PARTY_CONVERTED_TO_RAID")
	RosterMonitor:RegisterEvent("PLAYER_ENTERING_WORLD")

	RosterMonitor:SetScript("OnEvent", UpdateRoster)
end
	
	
---------------
-- Threat Circle Widget
---------------
do
	local threatSpinnerWidgetArt = "Interface\\Addons\\TidyPlates\\Widgets\\ThreatSpinner\\SpinnerArt"

	local THREATWIDGET_SEGMENT_ART = {
		HIGHTANK = 		{.75,1,.5,1},
		MEDIUMTANK = 	{.5,.75,.5,1},
		LOWTANK = 		{.25,.5,.5,1},
		HIGHDPS = 		{0,.25,.5,1},
		MEDIUMDPS = 	{.75,1,0,.5},
		LOWDPS = 		{.5,.75,0,.5},
		UNKNOWN = 		{.25,.5,0,.5},
	}

	local function UpdateThreatWheelWidget(frame, unit)
		local unitid
		if unit.reaction == "FRIENDLY" or (not InCombatLockdown()) then frame:Hide(); return end
		if unit.isTarget and UnitExists("target") then unitid = "target"
		elseif unit.isMouseover then unitid = "mouseover" end
		
		if unitid and unit.guid then
			local threat, topholder = GetRelativeThreat(unitid) 
			local threatsegment = GetThreatSegment(threat)
			if threatsegment then
				-- Set Indicator
				frame:Show()
				--frame.ThreatIcon:SetTexture(THREATWIDGET_SEGMENT_ART[threatsegment])
				frame.ThreatIcon:SetTexCoord(unpack(THREATWIDGET_SEGMENT_ART[threatsegment]))
				frame.ThreatText:SetText(floor(threat))
				if topholder then frame.TargetText:SetText(UnitName(topholder))
				else frame.TargetText:SetText("") end
				-- Set Fading
				frame:Show()
				frame.FadeTime = GetTime() + 3
				frame:HideIn(frame.FadeTime)
			else frame:Hide() end
		elseif (GetTime() > frame.FadeTime) then frame:Hide() end
	end

	local function CreateThreatWheelWidget(parent)
		local frame = CreateFrame("Frame", nil, parent)
		frame:SetWidth(64)
		frame:SetHeight(64)
		-- Icon
		frame.ThreatIcon = frame:CreateTexture(nil, "OVERLAY")
		frame.ThreatIcon:SetAllPoints(frame)
		frame.ThreatIcon:SetTexture(threatSpinnerWidgetArt)
		-- Threat Text
		frame.ThreatText = frame:CreateFontString(nil, "OVERLAY")
		frame.ThreatText:SetFont(threatfont, 8, "NONE")
		frame.ThreatText:SetPoint("CENTER",frame.ThreatIcon,"CENTER", -1, 0)
		frame.ThreatText:SetWidth(20)
		frame.ThreatText:SetHeight(20)
		-- Target Text
		frame.TargetText = frame:CreateFontString(nil, "OVERLAY")
		frame.TargetText:SetFont(threatfont, 8, "NONE")
		frame.TargetText:SetShadowOffset(1, -1)
		frame.TargetText:SetShadowColor(0,0,0,1)
		frame.TargetText:SetPoint("BOTTOM",frame,"TOP", 1, -25)
		frame.TargetText:SetWidth(50)
		frame.TargetText:SetHeight(20)
		-- Setup
		frame.HideIn = TidyPlatesWidgets.HideIn
		frame.FadeTime = 0
		frame:Hide()
		frame.Update = UpdateThreatWheelWidget
		return frame
	end

	TidyPlatesWidgets.CreateThreatWheelWidget = CreateThreatWheelWidget
end


---------------
-- Threat Line Widget
---------------
do
	local ThreatLineTexCoord = {
		None = 		{.75,1,0,1},
		Line = 		{0,.25,0,1},
		Right = 	{.5,.75,0,1},
		Left = 		{.25,.5,0,1},
		-- = 		{0,.25,0,1},
	}

	local art = "Interface\\Addons\\TidyPlates\\Widgets\\ThreatLine\\ThreatLineUnified"
	local threatcolor
	
	local function UpdateThreatLineWidget(frame, unit)
		local unitid
		if unit.reaction == "FRIENDLY" or (not InCombatLockdown()) then frame:Hide(); return end
		if unit.isTarget and UnitExists("target") then unitid = "target"
		elseif unit.isMouseover then unitid = "mouseover" end
		
		if unitid and unit.guid then
			local threat, topholder = GetRelativeThreat(unitid) 
			local middledot, outerdot = "Left", "Right"
			if threat and threat > 0 then
				local lineAnchor, dotAnchor, lineWidth = "RIGHT", "LEFT", 0
				-- Get Positions and Size
				if threat > 100 then
					-- While tanking
					lineWidth = ceil((threat - 100)/2)
					lineAnchor, dotAnchor = "LEFT", "RIGHT"
					threatcolor = frame._HighColor
					frame.TargetText:SetText("")
				else 
					-- While NOT tanking
					lineWidth = ceil((100 - threat)/2)
					threatcolor = frame._LowColor
					middledot, outerdot = "Right", "Left"
				end
				if topholder then 
					if (IsPlayerTank or (not IsPlayerInRaid)) and frame._ShowTargetOf then 
						frame.TargetText:SetText(UnitName(topholder))
					end
					if IsRaidTank(topholder) then 
						threatcolor = frame._TankedColor
						frame.TargetText:SetTextColor(0, .9, .1, 1)
					else frame.TargetText:SetTextColor(1,1, 1, 1) end
				else frame.TargetText:SetText("") end
				-- Set Size
				frame.Line:ClearAllPoints()
				frame.Line:SetPoint(lineAnchor, frame.Middle, "CENTER")
				frame.Line:SetWidth(lineWidth)
				frame.Dot:ClearAllPoints()
				frame.Dot:SetPoint("CENTER", frame.Line, dotAnchor)
				-- Set Colors
				frame.Dot:SetVertexColor(threatcolor.r, threatcolor.g, threatcolor.b)
				frame.Line:SetVertexColor(threatcolor.r, threatcolor.g, threatcolor.b)
				frame.Middle:SetVertexColor(threatcolor.r, threatcolor.g, threatcolor.b)
				-- Set Textures
				frame.Middle:SetTexCoord(unpack(ThreatLineTexCoord[middledot])) --SetTexture(artpath..middledot.."Dot")
				frame.Dot:SetTexCoord(unpack(ThreatLineTexCoord[outerdot])) --SetTexture(artpath..outerdot.."Dot")
				-- Set Fading
				frame:Show()
				frame.FadeTime = GetTime() + 2
				frame:HideIn(frame.FadeTime)
			else frame:Hide() end
		elseif (GetTime() > frame.FadeTime) then frame:Hide() end
	end

	local function SetThreatLineWidgetTexture(self, texture)
		if texture then 
			self.Middle:SetTexture(texture) 
			self.Dot:SetTexture(texture) 
			self.Line:SetTexture(texture) 
		end
	end
	
	--local function SetThreatLineColors(self,) end

	local function CreateThreatLineWidget(parent)
		local frame = CreateFrame("Frame", nil, parent)
		frame:SetWidth(100)
		frame:SetHeight(24)
		-- Threat Center
		frame.Middle = frame:CreateTexture(nil, "OVERLAY")
		frame.Middle:SetTexture(art)
		frame.Middle:SetPoint("CENTER")
		frame.Middle:SetWidth(32)
		frame.Middle:SetHeight(32)
		-- Threat Dot
		frame.Dot = frame:CreateTexture(nil, "OVERLAY")
		frame.Dot:SetTexture(art)
		frame.Dot:SetWidth(32)
		frame.Dot:SetHeight(32)
		-- Threat Line
		frame.Line = frame:CreateTexture(nil, "OVERLAY")
		frame.Line:SetTexture(art)
		frame.Line:SetTexCoord(unpack(ThreatLineTexCoord["Line"]))
		frame.Line:SetWidth(32)
		frame.Line:SetHeight(32)
		-- Target Text
		frame.TargetText = frame:CreateFontString(nil, "OVERLAY")
		--frame.TargetText:SetFont(threatfont, 9, "NONE")
		frame.TargetText:SetFont(threatfont, 8, "OUTLINE")
		--frame.TargetText:SetPoint("BOTTOM",frame.Dot,"TOP", 0, -15)
		frame.TargetText:SetPoint("BOTTOM",frame.Dot,"TOP", 0, -17)
		frame.TargetText:SetShadowOffset(1, -1)
		frame.TargetText:SetShadowColor(0,0,0,1)
		frame.TargetText:SetWidth(50)
		frame.TargetText:SetHeight(20)
		-- Mechanics/Setup
		frame.HideIn = TidyPlatesWidgets.HideIn
		frame.FadeTime = 0
		frame:Hide()
		frame.Update = UpdateThreatLineWidget
		frame.SetWidgetTexture = SetThreatLineWidgetTexture
		-- Customization
		frame._LowColor = { r = .14, g = .75, b = 1}
		frame._TankedColor = { r = 0, g = .9, b = .1}
		frame._HighColor = {r = 1, g = .67, b = .14}
		frame._ShowTargetOf = true
		return frame
	end
	
	TidyPlatesWidgets.CreateThreatLineWidget = CreateThreatLineWidget
end

---------------
-- Tanked Widget
---------------

--[[

do
	
	local SAFEICON, DANGERICON, UNKNICON = 1, 2, 3
	local artpath = "Interface\\Addons\\TidyPlates\\widgets\\MainTanked\\"
	local TargetList = {}
	
	-- This is a hack way to do it, but it'll work till I get a proper watcher frame
	local function UpdateTargetList()
		local index, groupsize, grouptype, unitid, guid
		
		if UnitInRaid("player") then
			groupsize = GetNumRaidMembers()
			grouptype = "raid"
		elseif UnitInParty("player") then
			groupsize = GetNumPartyMembers()
			grouptype = "party"
		--else	-- if player has a pet?
		--	TargetList[UnitGUID("pettarget")] = "pet"
		else return	false end
		
		if TargetList then wipe(TargetList) end
		
		for index = 1, groupsize do
			unitid = grouptype..groupsize.."target"
			guid = UnitGUID(unitid)
			if guid then TargetList[guid] = unitid end
		end
		return true
	end
	
	local function ShowIconIndex(self, index)
		if index == 1 then		-- Safe
			self.UnknIcon:Hide()
			self.SafeIcon:Show()
			self.DangerIcon:Hide()	
		elseif index == 2 then	-- Danger
			self.UnknIcon:Hide()
			self.SafeIcon:Hide()
			self.DangerIcon:Show()	
		elseif index == 3 then	-- Unknown
			self.UnknIcon:Show()
			self.SafeIcon:Hide()
			self.DangerIcon:Hide()	
		end
	end
	
	local function UpdateTankedWidget(frame, unit)
		local unitid, targetUnitid, targetName
		
		--if InCombatLockdown() and unit.reaction ~= "FRIENDLY" then
		if unit.reaction ~= "FRIENDLY" then
			frame:Show()
		else 
			--frame:ShowIconIndex(UNKNICON) 
			--frame:Show()
			frame:Hide()
			return
		end
		
		if unit.isTarget then 
			unitid = "target"
		elseif unit.isMouseover then
			unitid = "mouseover"
		else 
			if not UpdateTargetList() then return end 
		end
		
		--print(GetTime(), "Tanked Widget", unitid or TargetList[unit.guid])
		
		-- A) If the unit is a target or mouseover..
		if unitid and unit.guid then
			targetUnitid = unitid.."target"
			if UnitExists(targetUnitid) then 
				if IsRaidTank(targetUnitid) then -- or (unit.threatSituation == "HIGH") then 
					--print(GetTime(), "Showing SAFEICON for ", unitid)
					frame:ShowIconIndex(SAFEICON)
				else 
					--print(GetTime(), "Showing DANGERICON for ", unitid)
					frame:ShowIconIndex(DANGERICON)  
				end
				
			else 
				--print(GetTime(), "Showing UNKNICON for ", unitid)
				frame:ShowIconIndex(UNKNICON) 
				--frame:Hide() 
			end
			return
		-- B) If the unit is a target of someone else...
		elseif unit.guid and TargetList[unit.guid] then
			targetUnitid = TargetList[unit.guid].."target"
			if IsRaidTank(targetUnitid) then 
				--print(GetTime(), "Showing SAFEICON for GUID")
				frame:ShowIconIndex(SAFEICON) 
			else 
				--print(GetTime(), "Showing DANGERICON for GUID")
				frame:ShowIconIndex(DANGERICON) 
			end
			return
		-- C) Unit is unknown  -- DANGERICON, SAFEICON, UNKNICON
		else
			--print(GetTime(), "Showing UNKNICON")
			frame:ShowIconIndex(UNKNICON) 
		end
	end

	local function CreateTankedWidget(parent)		
		-- Init Widget
		local frame = CreateFrame("Frame", nil, parent)
		frame.FadeTime = 0
		frame:SetWidth(32)
		frame:SetHeight(32)
		-- Safe Icon
		frame.SafeIcon = frame:CreateTexture(nil, "OVERLAY")
		frame.SafeIcon:SetTexture(artpath.."Dot")
		frame.SafeIcon:SetAllPoints(frame)
		frame.SafeIcon:Show()
		-- Danger Icon
		frame.DangerIcon = frame:CreateTexture(nil, "OVERLAY")
		frame.DangerIcon:SetTexture(artpath.."Arrow")
		frame.DangerIcon:SetAllPoints(frame)
		frame.DangerIcon:Hide()
		-- Unknown Icon
		frame.UnknIcon = frame:CreateTexture(nil, "OVERLAY")
		frame.UnknIcon:SetTexture(artpath.."Question")
		frame.UnknIcon:SetAllPoints(frame)
		frame.UnknIcon:Hide()
		-- Update
		frame.HideIn = TidyPlatesWidgets.HideIn
		frame.Update = UpdateTankedWidget
		frame.ShowIconIndex = ShowIconIndex
		frame:Hide()
		return frame
	end
	
	TidyPlatesWidgets.CreateTankedWidget = CreateTankedWidget
end
--]]


-- [[
do
	
	
	local artpath = "Interface\\Addons\\TidyPlates\\widgets\\MainTanked\\"
	
	local function UpdateTankedWidget(frame, unit)
		local unitid, targetname
		if unit.reaction == "FRIENDLY" or (not InCombatLockdown())  then frame:Hide(); return end
		if unit.isTarget then unitid = "target"
		elseif unit.isMouseover then unitid = "mouseover" end

		if unitid and unit.guid then
			tot = unitid.."target"
			if UnitExists(tot) then 
				frame.FadeTime = GetTime() + 2
				frame:HideIn(frame.FadeTime)
				frame:Show()
				
				if IsRaidTank(tot) or (unit.threatSituation == "HIGH") then frame.tank:Show(); frame.squishy:Hide()
				else frame.tank:Hide(); frame.squishy:Show() end
				
			else frame:Hide() end
		elseif (GetTime() > frame.FadeTime) then frame:Hide() end
		--]]
	end

	local function CreateTankedWidget(parent)		

		-- Init Widget
		local frame = CreateFrame("Frame", nil, parent)
		frame.FadeTime = 0
		frame:SetWidth(26)
		frame:SetHeight(26)
		-- Tank Icon
		frame.tank = frame:CreateTexture(nil, "OVERLAY")
		frame.tank:SetTexture(artpath.."Shield")
		frame.tank:SetAllPoints(frame)
		frame.tank:Hide()
		-- Squishy Icon
		frame.squishy = frame:CreateTexture(nil, "OVERLAY")
		frame.squishy:SetTexture(artpath.."Knife")
		frame.squishy:SetAllPoints(frame)
		frame.squishy:Hide()
		-- Update
		frame.HideIn = TidyPlatesWidgets.HideIn
		frame.Update = UpdateTankedWidget
		frame:Hide()
		return frame
	end
	
	TidyPlatesWidgets.CreateTankedWidget = CreateTankedWidget
end
--]]




