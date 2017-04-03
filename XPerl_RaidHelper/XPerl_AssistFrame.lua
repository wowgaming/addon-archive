-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

local conf
XPerl_RequestConfig(function(new) conf = new end, "$Revision: 374 $")

local myClass
local playerAggro, petAggro
local doUpdate					-- In cases where we get multiple UNIT_TARGET events in 1 frame, we just set a flag and do during OnUpdate
local friendlyUnitList = {"player", "pet"}
local enemyUnitList = {}			-- Players with mobs targetted that target me
local wholeEnemyUnitList = {}			-- Players with mobs targetted
local currentPlayerAggro = {}

-- XPerl_Assists_OnLoad(self)
function XPerl_Assists_OnLoad(self)
	self:SetMinResize(170,40)
	self:SetMaxResize(1000,600)

	self:RegisterEvent("VARIABLES_LOADED")
	self:RegisterEvent("UNIT_TARGET")
	self:RegisterEvent("RAID_ROSTER_UPDATE")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_DEAD")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")

	self:SetScript("OnEvent", XPerl_Assists_OnEvent)
	self:SetScript("OnMouseDown", XPerl_Assists_MouseDown)
	self:SetScript("OnMouseUp", XPerl_Assists_MouseUp)

	XPerl_Assists_OnLoad = nil
end

-- XPerl_SetFrameSides
function XPerl_SetFrameSides()
	if (XPerl_Assists_Frame.LastSetView and XPerl_Assists_Frame.LastSetView[1] == XPerlConfigHelper.AssistsFrame and XPerl_Assists_Frame.LastSetView[2] == XPerlConfigHelper.TargettingFrame) then
		-- Frames the same from last time
		return
	end

	if (XPerlConfigHelper.AssistsFrame == 1 or XPerlConfigHelper.TargettingFrame == 1) then
        	XPerl_Assists_Frame:Show()

		XPerl_Target_Targetting_ScrollFrame:ClearAllPoints()
		XPerl_Target_Assists_ScrollFrame:ClearAllPoints()

		if (XPerlConfigHelper.AssistsFrame == 1 and XPerlConfigHelper.TargettingFrame == 1) then
			XPerl_Target_Targetting_ScrollFrame:SetPoint("TOPLEFT", 4, -5)
			XPerl_Target_Targetting_ScrollFrame:SetPoint("BOTTOMRIGHT", XPerl_Assists_Frame, "BOTTOM", -0.5, 5)
			XPerl_Target_Targetting_ScrollFrame:Show()

			XPerl_Target_Assists_ScrollFrame:SetPoint("TOPLEFT", XPerl_Assists_Frame, "TOP", 0.5, -5)
			XPerl_Target_Assists_ScrollFrame:SetPoint("BOTTOMRIGHT", -4, 5)
			XPerl_Target_Assists_ScrollFrame:Show()

			XPerlScrollSeperator:Show()
			XPerlScrollSeperator:ClearAllPoints()
			XPerlScrollSeperator:SetPoint("TOPLEFT", XPerl_Target_Targetting_ScrollFrame, "TOPRIGHT", 0, 0)
			XPerlScrollSeperator:SetPoint("BOTTOMRIGHT", XPerl_Target_Assists_ScrollFrame, "BOTTOMLEFT", 0, 0)
		else
			XPerlScrollSeperator:Hide()

			if (XPerlConfigHelper.AssistsFrame == 1) then
				XPerl_Target_Assists_ScrollFrame:SetPoint("TOPLEFT", 4, -5)
				XPerl_Target_Assists_ScrollFrame:SetPoint("BOTTOMRIGHT", -4, 5)
				XPerl_Target_Assists_ScrollFrame:Show()
				XPerl_Target_Targetting_ScrollFrame:Hide()
			else
				XPerl_Target_Targetting_ScrollFrame:SetPoint("TOPLEFT", 4, -5)
				XPerl_Target_Targetting_ScrollFrame:SetPoint("BOTTOMRIGHT", -4, 5)
				XPerl_Target_Targetting_ScrollFrame:Show()
				XPerl_Target_Assists_ScrollFrame:Hide()
			end
		end
	else
        	XPerl_Assists_Frame:Hide()
	end

	XPerl_Assists_Frame.LastSetView = {XPerlConfigHelper.AssistsFrame, XPerlConfigHelper.TargettingFrame}
end

-- ToggleAssistsFrame()
function XPerl_ToggleAssistsFrame(param)
	if (param == "assists") then
		if (XPerlConfigHelper.AssistsFrame == 1) then
			XPerlConfigHelper.AssistsFrame = 0
		else
			XPerlConfigHelper.AssistsFrame = 1
		end
	else
		if (XPerlConfigHelper.TargettingFrame == 1) then
			XPerlConfigHelper.TargettingFrame = 0
		else
			XPerlConfigHelper.TargettingFrame = 1
		end
	end
end

-- XPerl_AssistsView_Close
function XPerl_AssistsView_Open()
	XPerlConfigHelper.AssistsFrame = 1
	XPerlConfigHelper.TargettingFrame = 1
	XPerl_SetFrameSides()
	return true
end

function XPerl_AssistsView_Close()
	XPerlConfigHelper.AssistsFrame = 0
	XPerlConfigHelper.TargettingFrame = 0
	XPerl_SetFrameSides()
end

-- SortByClass(t1, t2)
local function SortByClass(t1, t2)
	if (t1[2] == t2[2]) then
		return t1[1] < t2[1]
	else
		local t1c = t1[2]
		local t2c = t2[2]
		if (t1c == myClass) then
			t1c = "A"..t1c
		elseif (t1c ~= "") then
			t1c = "B"..t1c
		else
			t1c = "Z"
		end
		if (t2c == myClass) then
			t2c = "A"..t2c
		elseif (t2c ~= "") then
			t2c = "B"..t2c
		else
			t1c = "Z"
		end

		return t1c..t1[1] < t2c..t2[1]
	end
end

-- XPerl_MakeAssistsString
function XPerl_MakeAssistsString(List, title)
	local text = title

	if (List ~= nil) then
		local lastClass
		local any = false
		local nAssists = #List
		if (nAssists > 0) then
			text = text.." "..nAssists
		end
		text = text.."\13"

		sort(List, SortByClass)

		for i,unit in ipairs(List) do
			if (not any) then
				if (unit[2] == "") then
					text = text.."|c00FF0000"..unit[1]
				else
					text = text..XPerlColourTable[unit[2]]..unit[1]
				end
				lastClass, any = unit[2], true
			else
				if (lastClass) then
					if (unit[2] == "" or lastClass ~= unit[2]) then
						lastClass = unit[2]

						if (unit[2] == "") then
							text = text.."\r|c00FF0000"..unit[1]
						else
							text = text.."\r"..XPerlColourTable[unit[2]]..unit[1]
						end
					else
						text = text.." "..unit[1]
					end
				else
					text = text.." "..unit[1]

					lastClass = unit[2]
				end
			end
		end
	end

	return (text)
end

-- FillList
local function FillList(List, cFrame, title)
	local text = XPerl_MakeAssistsString(List, title)
	_G["XPerl_Target_Assists_ScrollChild_"..cFrame.."Text"]:SetText(text)
end

-- XPerl_ShowAssists()
function XPerl_ShowAssists()
	if (XPerlConfigHelper.AssistsFrame == 1 or XPerlConfigHelper.TargettingFrame == 1) then
		if (XPerlConfigHelper.AssistsFrame == 1 and XPerl_Assists_Frame.assists ~= nil) then
			FillList(XPerl_Assists_Frame.assists, "Assists", XPERL_TOOLTIP_ASSISTING)
		end

		if (XPerlConfigHelper.TargettingFrame == 1 and XPerl_Assists_Frame.targetting ~= nil) then
			local title
			if (#XPerl_Assists_Frame.targetting > 0 and XPerl_Assists_Frame.targetting[1][2] == "") then
				title = XPERL_TOOLTIP_ENEMYONME
			else
				if (XPerlConfigHelper.TargetCountersSelf == 0) then
					title = XPERL_TOOLTIP_ALLONME
				else
					title = XPERL_TOOLTIP_HEALERS
				end
			end

			FillList(XPerl_Assists_Frame.targetting, "Targetting", title)
		end
	end
end

-- XPerl_Assists_MouseDown
function XPerl_Assists_MouseDown(self, button, param)
	if (button == "LeftButton") then
		if (not XPerlConfigHelper or not XPerlConfigHelper.AssistPinned or (IsAltKeyDown() and IsControlKeyDown() and IsShiftKeyDown())) then
			--if (param and (param == "TOPLEFT" or param == "BOTTOMLEFT" or param == "BOTTOMRIGHT")) then
			--	self:StartSizing(param)
			--else
				XPerl_Assists_FrameAnchor:StartMoving()
			--end
		end

	elseif (button == "RightButton") then
		local n = self:GetName()
		if (n and strfind (n, "XPerl_Target_Assists_ScrollChild_Targetting")) then
			param = "targetFrame"
		end

		if (param and param == "targetFrame") then
			if (XPerlConfigHelper.TargetCountersSelf == 1) then
				XPerlConfigHelper.TargetCountersSelf = 0
			else
				XPerlConfigHelper.TargetCountersSelf = 1
			end
			XPerl_UpdateAssists()
			XPerl_ShowAssists()
		end
	end
end

-- XPerl_Assists_MouseUp
function XPerl_Assists_MouseUp(self, button)

	--XPerl_Assists_Frame:StopMovingOrSizing()
	XPerl_Assists_FrameAnchor:StopMovingOrSizing()
	if (XPerl_SavePosition) then
		XPerl_SavePosition(XPerl_Assists_FrameAnchor)
	end

	-- XPerl_RegisterScalableFrame(self, XPerl_Assists_FrameAnchor, nil, nil, nil, true, true)
end

-- MakeFriendlyUnitList
local function MakeFriendlyUnitList()

	local start, prefix, total
	if (GetNumRaidMembers() > 0) then
		start, prefix, total = 1, "raid", GetNumRaidMembers()
	else
		start, prefix, total = 0, "party", GetNumPartyMembers()
	end

	--friendlyUnitList = {"player", "pet"}
	XPerl_FreeTable(friendlyUnitList)
	friendlyUnitList = XPerl_GetReusableTable()
	tinsert(friendlyUnitList, "player")
	tinsert(friendlyUnitList, "pet")

	local name, petname
	for i = start,total do
		if (i == 0) then
			name, petname = "player", "pet"
		else
			name, petname = prefix..i, prefix.."pet"..i
		end

		if (not UnitIsUnit(name, "player")) then
			if (UnitExists(name)) then
				tinsert(friendlyUnitList, name)
			end
			if (UnitExists(petname)) then
				tinsert(friendlyUnitList, petname)
			end
		end
	end
end

-- Events
function XPerl_Assists_OnEvent(self, event, unit)
	if (event == "PLAYER_TARGET_CHANGED" or (event == "UNIT_TARGET" and not UnitIsUnit(unit, "player"))) then
		doUpdate = true
	elseif (event == "VARIABLES_LOADED") then
		MakeFriendlyUnitList()
		XPerl_UpdateAssists()
		XPerl_ShowAssists()
		if (XPerl_SavePosition) then
			XPerl_SavePosition(XPerl_Assists_FrameAnchor, true)
		end

		if (XPerlConfigHelper.sizeAssistsX) then
			self:SetWidth(XPerlConfigHelper.sizeAssistsX)
			self:SetHeight(XPerlConfigHelper.sizeAssistsY)
		end

		XPerl_RegisterScalableFrame(self, XPerl_Assists_FrameAnchor, nil, nil, nil, true, true)
		self.corner.onSizeChanged = function(self, x, y)
			XPerlConfigHelper.sizeAssistsX = x
			XPerlConfigHelper.sizeAssistsY = y
		end
		XPerlAssistPin:SetButtonTex()

	elseif (event == "RAID_ROSTER_UPDATE" or event == "PARTY_MEMBERS_CHANGED") then
		MakeFriendlyUnitList()
		doUpdate = true

	elseif (event == "PLAYER_DEAD" or event == "PLAYER_REGEN_ENABLED") then
		XPerl_FreeTable(currentPlayerAggro)
		currentPlayerAggro = XPerl_GetReusableTable()
		if (XPerl_Highlight) then
			XPerl_Highlight:ClearAll("AGGRO")
		end
		XPerl_UpdateAssists()
		XPerl_ShowAssists()

	elseif (event == "PLAYER_ENTERING_WORLD") then
		if (XPerl_Highlight) then
			XPerl_Highlight:ClearAll("AGGRO")
		end
		MakeFriendlyUnitList()
		doUpdate = true
	end
end

-- XPerl_Assists_OnUpdate
local UpdateTime = 0
function XPerl_Assists_OnUpdate(self, arg1)
	
	UpdateTime = arg1 + UpdateTime
	if (doUpdate or UpdateTime >= 0.2) then
		if (doUpdate or #enemyUnitList > 0) then
			doUpdate = false
			XPerl_UpdateAssists()
			XPerl_ShowAssists()
		end
		UpdateTime = 0
	end
end

---------------------------------
-- Targetting counters         --
---------------------------------

local assists
local targetting

-- XPerl_FoundEnemyBefore
local function XPerl_FoundEnemyBefore(FoundEnemy, name)
	for previous in pairs(FoundEnemy) do
		if (UnitIsUnit(previous.."target", name.."target")) then
			return true
		end
	end
	return false
end

-- XPerl_AddEnemy
local function XPerl_AddEnemy(anyEnemy, FoundEnemy, name)
	local namet = name.."target"
	local namett = namet.."target"
	if (not XPerl_FoundEnemyBefore(wholeEnemyUnitList, name)) then
		if (UnitExists(namet)) then
			wholeEnemyUnitList[name] = true

			if (XPerl_Highlight and conf and conf.highlight.AGGRO) then
				if (UnitInRaid(namett) or UnitInParty(namett)) then
					currentPlayerAggro[UnitName(namett)] = UnitGUID(namett)
				end
			end
		end
	end

	if (UnitIsUnit("player", namett)) then
		if (not XPerl_FoundEnemyBefore(FoundEnemy, name)) then
			if (not playerAggro and XPerlConfigHelper.AggroWarning == 1) then
				playerAggro = true
				XPerl_AggroPlayer:Show()
			end

			FoundEnemy[name] = true
			local n = XPerl_GetReusableTable()
			n[1] = UnitName(namet)
			n[2] = ""
			tinsert(targetting, n)
			--tinsert(targetting, {UnitName(namet), ""})
			return true
		end

	-- 1.8.3 Added check to see if mob is targetting our target, and add to that list
	elseif (UnitExists("target") and UnitIsUnit("target", namett)) then
		-- We can still use the FoundEnemy list, because it's not too important if
		-- we're targetting ourself and the mob doesn't show on both self and target lists
		if (not XPerl_FoundEnemyBefore(FoundEnemy, name)) then
			FoundEnemy[name] = true
			local n = XPerl_GetReusableTable()
			n[1] = UnitName(namet)
			n[2] = ""
			--tinsert(assists, {UnitName(namet), ""})
			return true
		end

	elseif (not petAggro and XPerlConfigHelper.AggroWarning == 1 and UnitExists(namett) and UnitIsUnit("pet", namett)) then
		petAggro = true
		--petFadeStart = GetTime()
		XPerl_AggroPet:Show()
	end

	return false
end

local HealerClasses = {PRIEST = true, SHAMAN = true, PALADIN = true, DRUID = true}

-- XPerl_UpdateAssists
function XPerl_UpdateAssists()

	XPerl_FreeTable(wholeEnemyUnitList)
	wholeEnemyUnitList = XPerl_GetReusableTable()

	local oldPlayerAggro = currentPlayerAggro
	currentPlayerAggro = XPerl_GetReusableTable()
	--if (XPerl_Highlight) then
	--	XPerl_Highlight:ClearAll("AGGRO")
	--end

	if (XPerlConfigHelper.TargetCounters == 0) then
		if (XPerl_Target_AssistFrame) then XPerl_Target_AssistFrame:Hide(); end
		if (XPerl_Player_TargettingFrame) then XPerl_Player_TargettingFrame:Hide(); end
		return
	end

	local selfFlag = XPerlConfigHelper.TargetCountersSelf == 1
	local enemyFlag = XPerlConfigHelper.TargetCountersEnemy == 1
	local assistCount, targettingCount, anyEnemy = 0, 0, false
	local start,i,total,prefix,name,petname

	local FoundEnemy = XPerl_GetReusableTable()

	-- Re-use all the old tables from last pass
	assists = XPerl_Assists_Frame.assists
	targetting = XPerl_Assists_Frame.targetting
	if (assists) then
		for k,v in pairs(assists) do
			XPerl_FreeTable(v)
			assists[k] = nil
		end
	end
	if (targetting) then
		for k,v in pairs(targetting) do
			XPerl_FreeTable(v)
			targetting[k] = nil
		end
	end
	XPerl_FreeTable(assists)
	XPerl_FreeTable(targetting)

	-- Get new tables
	assists = XPerl_GetReusableTable()
	targetting = XPerl_GetReusableTable()
	XPerl_Assists_Frame.assists, XPerl_Assists_Frame.targetting = assists, targetting

	playerAggro, petAggro = false, false

	local targetname = UnitName("target")
	for i,name in pairs(friendlyUnitList) do
		if (UnitExists(name.."target") and not UnitIsDeadOrGhost(name)) then
			local class, engClass = UnitClass(name)

			if (targetname) then
				if (UnitIsUnit("target", name.."target")) then
					assistCount = assistCount + 1
					local n = XPerl_GetReusableTable()
					n[1] = UnitName(name)
					n[2] = engClass
					tinsert(assists, n)
					--tinsert (assists, {UnitName(name), engClass})
				end
			end

			-- 0 for Anyone, 1 for Healers
			if (not selfFlag or HealerClasses[engClass]) then
				if (UnitIsUnit("player", name.."target")) then
					targettingCount = targettingCount + 1
					local n = XPerl_GetReusableTable()
					n[1] = UnitName(name)
					n[2] = engClass
					tinsert(targetting, n)
					--tinsert(targetting, {UnitName(name), engClass})
				end
			end

			-- Count enemy targetting us?
			if (enemyFlag) then
				if (UnitCanAttack("player", name.."target")) then	-- not UnitIsFriend("player", name.."target")) then
					if (XPerl_AddEnemy(anyEnemy, FoundEnemy, name)) then
						anyEnemy = true
						targettingCount = targettingCount + 1
					end
				end
			end
		end
	end

	if (enemyFlag) then
		if (not UnitIsFriend("player", "focus")) then
			if (UnitIsUnit("player", "focustarget")) then
				if (XPerl_Highlight and conf and conf.highlight.AGGRO) then
					currentPlayerAggro[UnitName("player")] = UnitGUID("player")
				end

				if (not XPerl_FoundEnemyBefore(FoundEnemy, "focus")) then
					if (not playerAggro and XPerlConfigHelper.AggroWarning == 1) then
						playerAggro = true
						XPerl_AggroPlayer:Show()
					end

					FoundEnemy["focus"] = true
					local n = XPerl_GetReusableTable()
					n[1] = UnitName("focus")
					n[2] = ""
					tinsert(targetting, n)
					--tinsert(targetting, {UnitName("focus"), ""})
					return true
				end
			end
		end
	end

	if (GetNumPartyMembers() == 0 and GetNumRaidMembers() == 0) then
		-- Don't show it if we're on our own... we know we have aggro..
		playerAggro, petAggro = false, false
	end

	if (playerAggro or petAggro) then
		XPerl_Aggro:Show()
	end

	enemyUnitList = FoundEnemy

	if (XPerl_Highlight and conf and conf.highlight.AGGRO) then
		for k,v in pairs(oldPlayerAggro) do
			if (not currentPlayerAggro[k]) then
				XPerl_Highlight:Remove(v, "AGGRO")
			end
		end
		for k,v in pairs(currentPlayerAggro) do
			if (not oldPlayerAggro[k]) then
				XPerl_Highlight:Add(v, "AGGRO", 0)
			end
		end
	end

	if (XPerlConfigHelper.ShowTargetCounters == 1) then
		if (XPerl_Player_TargettingFrame) then
			if (XPerl_Player) then
				local conf = (conf and conf.colour.border) or (XPerlConfigHelper and XPerlConfigHelper.BorderColour) or {r = 0.5, g = 0.5, b = 0.5}

				if (anyEnemy) then
					XPerl_Player_TargettingFrame:SetBackdropBorderColor(1, 0.2, 0.2, conf.a)
				else
					XPerl_Player_TargettingFrame:SetBackdropBorderColor(conf.r, conf.g, conf.b, conf.a)
				end

				if (targettingCount == 0) then
					XPerl_Player_TargettingFrametext:SetTextColor(1,0.5,0.5)
				elseif (targettingCount > 5) then
					XPerl_Player_TargettingFrametext:SetTextColor(0.5,1,0.5)
				else
					XPerl_Player_TargettingFrametext:SetTextColor(0.5,0.5,1)
				end

				XPerl_Player_TargettingFrame:SetText(targettingCount)
				XPerl_Player_TargettingFrame:Show()
			else
				XPerl_Player_TargettingFrame:Hide()
			end
		end

		if (XPerl_Target_AssistFrame) then
			if (XPerl_Target) then
				if (assistCount < 2) then
					XPerl_Target_AssistFrametext:SetTextColor(1,0.5,0.5)
				elseif (assistCount > (#friendlyUnitList / 2)) then
					XPerl_Target_AssistFrametext:SetTextColor(0.5,1,0.5)
				else
					XPerl_Target_AssistFrametext:SetTextColor(0.5,0.5,1)
				end

				if (targetname) then
					XPerl_Target_AssistFrame:SetText(assistCount)
				end
				XPerl_Target_AssistFrame:Show()
			else
				XPerl_Target_AssistFrame:Hide()
			end
		end
	else
		XPerl_Player_TargettingFrame:Hide()
		XPerl_Target_AssistFrame:Hide()
	end

	XPerl_FreeTable(oldPlayerAggro)
	XPerl_FreeTable(FoundEnemy)
end

-- XPerl_Assists_GetFriendlyUnitList
function XPerl_Assists_GetEnemyUnitList()
	return wholeEnemyUnitList
end

-- XPerl_StartAssists
function XPerl_StartAssists()
	local _
	_, myClass = UnitClass("player")

	XPerlColourTable.pet = "|c008080FF"

	if (XPerl_RegisterPerlFrames) then
		XPerl_RegisterPerlFrames(XPerl_Assists_Frame)
	end

	XPerl_SetFrameSides()
end

-- XPerl_RefreshAggro
function XPerl_RefreshAggro(self)
	if (playerAggro) then
		XPerl_AggroPlayer:SetVertexColor(1, 0, 0, 1)
	else
		if (self.playerFadeStart) then
			local elapsed = GetTime() - self.playerFadeStart
			if (elapsed < 1) then
				XPerl_AggroPlayer:SetVertexColor(0, 1, 0, 1 - elapsed)
			else
				XPerl_AggroPlayer:Hide()
				self.playerFadeStart = nil
				if (not XPerl_AggroPet:IsShown()) then
					self:Hide()
				end
			end
		else
			self.playerFadeStart = GetTime()
		end
	end
	if (petAggro) then
		XPerl_AggroPet:SetVertexColor(1, 0, 0, 1)
	else
		if (self.petFadeStart) then
			local elapsed = GetTime() - self.petFadeStart
			if (elapsed < 1) then
				XPerl_AggroPet:SetVertexColor(0, 1, 0, 1 - elapsed)
			else
				XPerl_AggroPet:Hide()
				self.petFadeStart = nil
				if (not XPerl_AggroPlayer:IsShown()) then
					self:Hide()
				end
			end
		else
			self.petFadeStart = GetTime()
		end
	end
end
