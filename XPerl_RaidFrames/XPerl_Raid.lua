-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

local XPerl_Raid_Events = {}
local RaidGroupCounts = {0,0,0,0,0,0,0,0,0,0}
local myGroup = 0
local FrameArray = {}		-- List of raid frames indexed by raid ID
local RaidPositions = {}	-- Back-matching of unit names to raid ID
local ResArray = {}		-- List of currently active resserections in progress
local buffUpdates = {}		-- Queue for buff updates after a roster change
local raidLoaded
local rosterUpdated
local percD = "%d"..PERCENT_SYMBOL
local lastNamesList, lastName, lastWith, lastNamesCount		-- Stores with/without buff list (OnUpdate optimization)
local fullyInitiallized

local new, del, copy = XPerl_GetReusableTable, XPerl_FreeTable, XPerl_CopyTable

local format = format
local strsub = strsub
local GetNumRaidMembers = GetNumRaidMembers
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitIsConnected = UnitIsConnected
local UnitIsDead = UnitIsDead
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitIsGhost = UnitIsGhost
local UnitMana = UnitMana
local UnitManaMax = UnitManaMax
local UnitName = UnitName
local UnitPowerType = UnitPowerType
local XPerl_UnitBuff = XPerl_UnitBuff
local XPerl_UnitDebuff = XPerl_UnitDebuff
local XPerl_CheckDebuffs = XPerl_CheckDebuffs
local XPerl_ColourFriendlyUnit = XPerl_ColourFriendlyUnit
local XPerl_ColourHealthBar = XPerl_ColourHealthBar

-- TODO - Watch for:   ERR_FRIEND_OFFLINE_S = "%s has gone offline."

local conf, rconf
XPerl_RequestConfig(function(newConf) conf = newConf rconf = conf.raid end, "$Revision: 398 $")

XPERL_RAIDGRP_PREFIX	= "XPerl_Raid_Grp"

-- Hold some raid roster information (AFK, DND etc.)
-- Is also stored between sessions to maintain timers and flags
XPerl_Roster = {}

-- Uses some variables from FrameXML\RaidFrame.lua:
-- MAX_RAID_MEMBERS = 40
-- NUM_RAID_GROUPS = 8
-- MEMBERS_PER_RAID_GROUP = 5

local localGroups = LOCALIZED_CLASS_NAMES_MALE
local WoWclassCount = 0
for k,v in pairs(localGroups) do WoWclassCount = WoWclassCount + 1 end

local resSpells  = {
	[GetSpellInfo(2006)] = true,			-- Resurrection
	[GetSpellInfo(2008)] = true,			-- Ancestral Spirit
	[GetSpellInfo(20484)] = true,			-- Rebirth
	[GetSpellInfo(7328)] = true,			-- Redemption
	[GetSpellInfo(50769)] = true,			-- Revive
}

local hotSpells = XPERL_HIGHLIGHT_SPELLS.hotSpells

----------------------
-- Loading Function --
----------------------

local raidHeaders = {}

-- XPerl_Raid_OnLoad
function XPerl_Raid_OnLoad(self)
	-- Added UNIT_POWER/UNIT_MAXPOWER to events list for 4.0 (By PlayerLin)
	local events = {"CHAT_MSG_ADDON",	-- "CHAT_MSG_RAID", "CHAT_MSG_RAID_LEADER", "CHAT_MSG_PARTY",
			"PLAYER_ENTERING_WORLD", "VARIABLES_LOADED", "RAID_ROSTER_UPDATE", "UNIT_FACTION",
			"UNIT_DYNAMIC_FLAGS", "UNIT_FLAGS", "UNIT_AURA", "UNIT_POWER", "UNIT_MAXPOWER",
			"UNIT_HEALTH", "UNIT_MAXHEALTH", "UNIT_NAME_UPDATE", "PLAYER_FLAGS_CHANGED",
			"UNIT_COMBAT", "UNIT_SPELLCAST_START", "UNIT_SPELLCAST_STOP", "UNIT_SPELLCAST_FAILED",
			"UNIT_SPELLCAST_INTERRUPTED", "READY_CHECK", "READY_CHECK_CONFIRM", "READY_CHECK_FINISHED",
			"RAID_TARGET_UPDATE", "PLAYER_LOGIN"
			}
	for i,event in pairs(events) do
		self:RegisterEvent(event)
	end

	for i = 1,WoWclassCount do			-- Fix for WoW 2.1 UNIT_NAME_UPDATE issue
		_G["XPerl_Raid_Grp"..i]:UnregisterEvent("UNIT_NAME_UPDATE")
		tinsert(raidHeaders, _G[XPERL_RAIDGRP_PREFIX..i])
	end

	self.time = 0
	self.Array = {}

	XPerl_RegisterOptionChanger(function()
		if (raidLoaded) then
			XPerl_RaidTitles()
		end

		XPerl_Raid_Set_Bits(XPerl_Raid_Frame)

		if (raidLoaded) then
			SkipHighlightUpdate = true
			XPerl_Raid_UpdateDisplayAll()
			SkipHighlightUpdate = nil
		end
	end, "Raid")

	XPerl_Raid_OnLoad = nil
end

-- XPerl_Raid_HeaderOnLoad
function XPerl_Raid_HeaderOnLoad(self)
	self:RegisterForDrag("LeftButton")
	self.text = _G[self:GetName().."TitleText"]
	self.virtual = _G[self:GetName().."Virtual"]
	XPerl_RegisterUnitText(self.text)
	--XPerl_SavePosition(self, true)
end

-- CreateManaBar
local function CreateManaBar(self)
	local sf = self.statsFrame
	sf.manaBar = CreateFrame("StatusBar", sf:GetName().."manaBar", sf, "XPerlRaidStatusBar")
	sf.manaBar:SetScale(0.7)
	sf.manaBar:SetWidth(70)
	sf.manaBar:SetPoint("TOPLEFT", sf.healthBar, "BOTTOMLEFT", 0, 0)
	sf.manaBar:SetPoint("BOTTOMRIGHT", sf.healthBar, "BOTTOMRIGHT", 0, -7)
	sf.manaBar:SetStatusBarColor(0, 0, 1)
end

-- Setup1RaidFrame
local function Setup1RaidFrame(self)
	if (rconf.mana) then
		if (not self.statsFrame.manaBar) then
			CreateManaBar(self)
		end

		if (not InCombatLockdown()) then
			self:SetHeight(43)
		end
		self.statsFrame:SetHeight(26)
		self.statsFrame.manaBar:Show()
	else
		if (not InCombatLockdown()) then
			self:SetHeight(38)
		end
		self.statsFrame:SetHeight(21)
		if (self.statsFrame.manaBar) then
			self.statsFrame.manaBar:Hide()
		end
	end

	if (rconf.percent) then
		self.statsFrame.healthBar.text:Show()
		if (self.statsFrame.manaBar) then
			self.statsFrame.manaBar.text:Show()
		end
	else
		self.statsFrame.healthBar.text:Hide()
		if (self.statsFrame.manaBar) then
			self.statsFrame.manaBar.text:Hide()
		end
	end

	if (XPerl_Voice) then
		XPerl_Voice:Register(self, true)
	end
end

-- XPerl_MainTankSet_OnClick
function XPerl_MainTankSet_OnClick(self, value)
	if (self.value[1] == "Main Tanks") then				-- Must be 'this'
		if (self.value[4]) then
			SendAddonMessage("CTRA", "R "..self.value[2], "RAID")
		else
			SendAddonMessage("CTRA", "SET "..self.value[3].." "..self.value[2], "RAID")
		end
	end
	CloseMenus()
end

-- XPerl_RaidFrameDropDown_Initialize
function XPerl_RaidFrameDropDown_Initialize(self, ct)
	if (type(ct) ~= "table") then
		ct = nil
	end

	local info
	if (XPerl_MainTanks and type(UIDROPDOWNMENU_MENU_VALUE) == "table" and UIDROPDOWNMENU_MENU_VALUE[1] == "Main Tanks") then
		info = UIDropDownMenu_CreateInfo()
		info.text = XPERL_RAID_DROPDOWN_MAINTANKS
		info.isTitle = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
		for i = 1,10 do
			info = UIDropDownMenu_CreateInfo()
			info.notCheckable = 1
			if (XPerl_MainTanks[i] and XPerl_MainTanks[i][2] == UIDROPDOWNMENU_MENU_VALUE[2]) then
				info.text = format("|c00FFFF80"..XPERL_RAID_DROPDOWN_REMOVEMT.."|r", i)
				info.value = {UIDROPDOWNMENU_MENU_VALUE[1], UIDROPDOWNMENU_MENU_VALUE[2], i, 1}
			else
				info.text = format(XPERL_RAID_DROPDOWN_SETMT, i)
				info.value = {UIDROPDOWNMENU_MENU_VALUE[1], UIDROPDOWNMENU_MENU_VALUE[2], i}
			end
			info.func = XPerl_MainTankSet_OnClick
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
		end
		return
	end

	RaidFrameDropDown_Initialize(self)

	if (UIDROPDOWNMENU_MENU_LEVEL > 1) then
		return
	end

	local titleDone
	if (DropDownList1.numButtons == 0 and (IsRaidOfficer() or (ct and CT_RATab_AutoPromotions))) then
		titleDone = true
		info = UIDropDownMenu_CreateInfo()
		info.text = self.name
		if (self.server) then
			info.text = info.text.."-"..self.server
		end
		info.isTitle = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info)
	end

	if (IsRaidOfficer() and XPerl_MainTanks) then
		if (not titleDone and DropDownList1.numButtons > 0) then
			-- We want our MT option above the Cancel option, so we trick the menu into thinking it's got 1 less button
			DropDownList1.numButtons = DropDownList1.numButtons - 1
		end

		info = UIDropDownMenu_CreateInfo()
		info.text = XPERL_RAID_DROPDOWN_MAINTANKS
		info.value = {"Main Tanks", self.name, self.id}			-- Must be 'this'
		info.hasArrow = 1
		info.dist = 0
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info)

		-- Re-add the cancel button after our MT option
		info = UIDropDownMenu_CreateInfo()
		info.text = XPERL_CANCEL
		info.value = "CANCEL"
		info.owner = "RAID"
		info.func = UnitPopup_OnClick
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info)
	end

	if (ct and CT_RATab_AutoPromotions) then
		info = UIDropDownMenu_CreateInfo()
		info.text = XPERL_RAID_AUTOPROMOTE
		info.checked = CT_RATab_AutoPromotions[self.name]	-- Must be 'this'
		info.value = self.id					-- Must be 'this'
		info.func = CT_RATab_AutoPromote_OnClick
		UIDropDownMenu_AddButton(info)
	end
end

-- ShowPopup
function XPerl_Raid_ShowPopup(self)
	local me = self
	if (not self.nameFrame and self:GetParent().nameFrame == self) then
		me = self:GetParent()
	end

	HideDropDownMenu(1)
	FriendsDropDown.initialize = XPerl_RaidFrameDropDown_Initialize
	FriendsDropDown.displayMode = "MENU"

	FriendsDropDown.unit = SecureButton_GetUnit(me)
	FriendsDropDown.name, FriendsDropDown.server = UnitName(FriendsDropDown.unit)
	FriendsDropDown.id = tonumber(strmatch(FriendsDropDown.unit, "(%d+)"))

	XPerl_ShouldHideSetFocus = true
	ToggleDropDownMenu(1, nil, FriendsDropDown, me.statsFrame:GetName(), 0, 0)
	XPerl_ShouldHideSetFocus = nil
end

-- SetFrameArray
local function SetFrameArray(self, value)
	for k,v in pairs(FrameArray) do
		if (v == self) then
			FrameArray[k] = nil
			break
		end
	end

	self.partyid = value

	if (value) then
		FrameArray[value] = self
	end
end

-- XPerl_Raid_UpdateName
local function XPerl_Raid_UpdateName(self)
	local partyid = self:GetAttribute("unit")
	if (not partyid) then
		partyid = SecureButton_GetUnit(self)
		if (not partyid) then
			self.lastName, self.lastID = nil, nil
			return
		end
	end



	local name = UnitName(partyid)
	self.lastName, self.lastID = name, partyid -- These stored, so we can at least make a small effort in reducing workload on attribute changes.

	if (name) then
		self.nameFrame.text:SetText(name)

		if (self.pet) then
			local color = conf.ColourReactionNone
			self.nameFrame.text:SetTextColor(color.r, color.g, color.b)
		else
			XPerl_ColourFriendlyUnit(self.nameFrame.text, partyid)
		end
	end
end

-- XPerl_Raid_CheckFlags
local function XPerl_Raid_CheckFlags(partyid)

	local unitName = UnitName(partyid)
	local resser

	for i,name in pairs(ResArray) do
		if (name == unitName) then
			resser = i
			break
		end
	end

	if (resser) then
		-- Verify they're dead..
		if (UnitIsDeadOrGhost(partyid)) then
			return {flag = resser..XPERL_RAID_RESSING, bgcolor = {r = 0, g = 0.5, b = 1}}
		end

		ResArray[resser] = nil
	end

	local unitInfo = XPerl_Roster[unitName]
	if (unitInfo) then
		if (unitInfo.ressed) then
			if (UnitIsDead(partyid)) then
				if (unitInfo.ressed == 2) then
					return {flag = XPERL_LOC_SS_AVAILABLE, bgcolor = {r = 0, g = 1, b = 0.5}}
				elseif (unitInfo.ressed == 3) then
					return {flag = XPERL_LOC_ACCEPTEDRES, bgcolor = {r = 0, g = 0.5, b = 1}}
				else
					return {flag = XPERL_LOC_RESURRECTED, bgcolor = {r = 0, g = 0.5, b = 1}}
				end
			else
				unitInfo.ressed = nil
				XPerl_Raid_UpdateManaType(FrameArray[partyid], true)
			end

		elseif (unitInfo.afk) then
			if (UnitIsAFK(partyid)) then
				if (conf.showAFK) then
					return {flag = XPERL_RAID_AFK}
				end
			else
				unitInfo.afk = nil
			end
		end
	end
end

-- XPerl_Raid_UpdateManaType
function XPerl_Raid_UpdateManaType(self, skipFlags)
	if (rconf.mana) then
		local partyid = self:GetAttribute("unit")
		if (not partyid) then
			partyid = SecureButton_GetUnit(self)
			if (not partyid) then
				return
			end
			return
		end

		local flags
		if (not skipFlags) then
			flags = XPerl_Raid_CheckFlags(partyid)
		end
		if (not flags) then
			XPerl_SetManaBarType(self)
		end
	end
end

-- XPerl_Raid_ShowFlags
local function XPerl_Raid_ShowFlags(self, flags)
	local r, g, b
	local flag
	if (type(flags) == "string") then
		flag = flags
		flags = nil
	else
		flag = flags.flag
	end

	if (flags and flags.bgcolor) then
		r, g, b = flags.bgcolor.r, flags.bgcolor.g, flags.bgcolor.b
	else
		r, g, b = 0.5, 0.5, 0.5
	end

	self.statsFrame:SetGrey(r, g, b)

	if (flags and flags.color) then
		r, g, b = flags.color.r, flags.color.g, flags.color.b
	else
		r, g, b = 1, 1, 1
	end

	self.statsFrame.healthBar.text:SetText(flag)
	self.statsFrame.healthBar.text:SetTextColor(r, g, b)
	self.statsFrame.healthBar.text:Show()
	del(flags)
end

local spiritOfRedemption = GetSpellInfo(27827)

-- XPerl_Raid_UpdateHealth
function XPerl_Raid_UpdateHealth(self)


	local partyid = self.partyid
	if (not partyid) then
		return
	end

	local health = XPerl_UnitHealth(partyid)
	local healthmax = UnitHealthMax(partyid)

	if (health > healthmax) then
		-- New glitch with 1.12.1
		if (UnitIsDeadOrGhost(partyid)) then
			health = 0
		else
			health = healthmax
		end
	end

	self.statsFrame.healthBar:SetMinMaxValues(0, healthmax)
	if (conf.bar.inverse) then
		self.statsFrame.healthBar:SetValue(healthmax - health)
	else
		self.statsFrame.healthBar:SetValue(health)
	end

	if (not rconf.percent) then
		if (self.statsFrame.healthBar.text:IsShown()) then
			self.statsFrame.healthBar.text:Hide()
		end
	end

	XPerl_SetExpectedHealth(self)

	local name = UnitName(partyid)
	local myRoster = XPerl_Roster[name]
	if (name and UnitIsConnected(partyid)) then
		self.disco = nil
		if (myRoster and myRoster.fd) then
			if (not UnitIsFeignDeath(partyid)) then
				myRoster.fd = nil
			end
		end

		local flags = XPerl_Raid_CheckFlags(partyid)
		if (flags) then
			XPerl_Raid_ShowFlags(self, flags)

			if (UnitIsDeadOrGhost(partyid)) then
				self.dead = true
				XPerl_Raid_UpdateName(self)
			end
			return

		elseif (UnitBuff(partyid, spiritOfRedemption)) then
			self.dead = true
			XPerl_Raid_ShowFlags(self, XPERL_LOC_DEAD)
			XPerl_Raid_UpdateName(self)

		elseif (UnitIsDead(partyid) or (myRoster and myRoster.fd and conf.showFD)) then
			if (myRoster and myRoster.fd) then
				XPerl_NoFadeBars(true)
				self.statsFrame.healthBar.text:SetText(XPERL_LOC_FEIGNDEATH)
				self.statsFrame:SetGrey()
				XPerl_NoFadeBars()
			else
				self.dead = true
				XPerl_Raid_ShowFlags(self, XPERL_LOC_DEAD)
				XPerl_Raid_UpdateName(self)
			end

		elseif (UnitIsGhost(partyid)) then
			self.dead = true
			XPerl_Raid_ShowFlags(self, XPERL_LOC_GHOST)
			XPerl_Raid_UpdateName(self)

		else
			if (self.dead or (myRoster and ((myRoster.fd and conf.showFD) or myRoster.ressed))) then
				XPerl_Raid_UpdateManaType(self, true)
			end
			self.dead = nil

			local percentHp = health / healthmax
			if (rconf.healerMode.enable) then
				self.statsFrame.healthBar.text:SetText(-(healthmax - health))
			else
				if (rconf.values) then
					self.statsFrame.healthBar.text:SetFormattedText("%d/%d", health, healthmax)
				else
					self.statsFrame.healthBar.text:SetFormattedText(percD, (percentHp + 0.005) * 100)
				end
			end

			-- XPerl_SetSmoothBarColor(self.statsFrame.healthBar, percentHp)
			XPerl_ColourHealthBar(self, percentHp, partyid)

			if (self.statsFrame.greyMana) then
				self.statsFrame.greyMana = nil
				if (myRoster) then
					myRoster.resCount = nil
					myRoster.ressed = nil
				end
				XPerl_Raid_UpdateManaType(self, true)
			end
		end
	else
		self.disco = true
		self.dead = nil
		XPerl_Raid_ShowFlags(self, XPERL_LOC_OFFLINE)

		if (name and myRoster and not myRoster.offline) then
			myRoster.offline = GetTime()
			myRoster.afk = nil
			myRoster.dnd = nil
		end
	end
end

-- XPerl_Raid_UpdateMana
local function XPerl_Raid_UpdateMana(self)
	if (rconf.mana) then
		if (not self.statsFrame.manaBar) then
			CreateManaBar(self)
		end

		local partyid = self.partyid
		if (not partyid) then
			return
		end

		local mana = UnitMana(partyid)
		local manamax = UnitManaMax(partyid)

		if (rconf.manaPercent and UnitPowerType(partyid) == 0 and not self.pet) then
			if (rconf.values) then			-- TODO rconf.manavalues
			 	self.statsFrame.manaBar.text:SetFormattedText("%d/%d", mana, manamax)
		 	else
		 		local pmanaPct = (mana * 100.0) / manamax
				self.statsFrame.manaBar.text:SetFormattedText(percD, pmanaPct)	-- XPerl_Percent[floor(pmanaPct)])
			end
		else
			self.statsFrame.manaBar.text:SetText("")
		end

		self.statsFrame.manaBar:SetMinMaxValues(0, manamax)
		self.statsFrame.manaBar:SetValue(mana)
	end
end

-- onAttrChanged
local function onAttrChanged(self, name, value)
	if (name == "unit") then
		if (value) then
			SetFrameArray(self, value)
			if (self.lastID ~= value or self.lastName ~= UnitName(value)) then
				XPerl_Raid_UpdateDisplay(self)
			end
		else
			buffUpdates[self] = nil
			SetFrameArray(self)
			self.lastID = nil
			self.lastName = nil
		end
	end
end

-- XPerl_Raid_Single_OnLoad
function XPerl_Raid_Single_OnLoad(self)
	XPerl_SetChildMembers(self)
	self:RegisterForClicks("AnyUp")

	self.edgeFile = "Interface\\Addons\\XPerl\\images\\XPerl_ThinEdge"
	self.edgeSize = 10
	self.edgeInsets = 2

	XPerl_RegisterHighlight(self.highlight, 2)

	XPerl_RegisterPerlFrames(self, {self.nameFrame, self.statsFrame})
	self.FlashFrames = {self.nameFrame, self.statsFrame}

	--self:SetScript("OnAttributeChanged", onAttrChanged)
	--XPerl_RegisterClickCastFrame(self)
	--XPerl_RegisterClickCastFrame(self.nameFrame)
end

-- XPerl_Raid_CombatFlash
local function XPerl_Raid_CombatFlash(self, elapsed, argNew, argGreen)
	if (XPerl_CombatFlashSet(self, elapsed, argNew, argGreen)) then
		XPerl_CombatFlashSetFrames(self)
	end
end

-- XPerl_GetRaidPosition
function XPerl_GetRaidPosition(findName)
	return RaidPositions[findName]
end

-- XPerl_Raid_GetUnitFrameByName
function XPerl_Raid_GetUnitFrameByName(findName)
	-- Used by teamspeak module
	local id = RaidPositions[findName]
	if (id) then
		return FrameArray[id]
	end
end

-- XPerl_Raid_GetUnitFrameByName
function XPerl_Raid_GetUnitFrameByUnit(unit)
	return FrameArray[unit]
end

-- XPerl_Raid_GetFrameArray
function XPerl_Raid_GetFrameArray()
	return FrameArray
end

-- UpdateUnitByName
local function UpdateUnitByName(name,flagsOnly)
	local id = RaidPositions[name]
	if (id) then
		local frame = FrameArray[id]
		if (frame and frame:IsShown()) then
			if (flagsOnly) then
				XPerl_Raid_UpdateHealth(frame)
			else
				XPerl_Raid_UpdateDisplay(frame)
			end
		end
	end
end

-- XPerl_Raid_HighlightCallback(updateName)
local function XPerl_Raid_HighlightCallback(self, updateGUID)
	local f = XPerl_Raid_GetUnitFrameByGUID(updateGUID)
	if (f) then
		XPerl_Highlight:SetHighlight(f, updateGUID)
	end
end

-- GetBuffButton(self, buffnum, debuff, createIfAbsent)
-- debuff must be 1 or 0, as it's used in size calc
local buffIconCount = 0
local function GetBuffButton(self, buffnum, createIfAbsent)

	local button = self.buffFrame.buff and self.buffFrame.buff[buffnum]

	if (not button and createIfAbsent) then
		buffIconCount = buffIconCount + 1
		button = CreateFrame("Button", "XPerlRBuff"..buffIconCount, self.buffFrame, "XPerl_BuffTemplate")
		button:SetID(buffnum)

		if (not self.buffFrame.buff) then
			self.buffFrame.buff = {}
		end
		self.buffFrame.buff[buffnum] = button

		button:SetHeight(10)
		button:SetWidth(10)

		button.icon:SetTexCoord(0.078125, 0.921875, 0.078125, 0.921875)

		button:SetScript("OnEnter", XPerl_Raid_SetBuffTooltip)
		button:SetScript("OnLeave", function()
						lastNamesList, lastName, lastWith = nil, nil, nil
						XPerl_PlayerTipHide()
					end)
	end

	return button
end

-- GetShowCast
local function GetShowCast(self)
	if (rconf.buffs.enable) then
		return "b", (rconf.buffs.castable == 1) and "RAID"
	elseif (rconf.debuffs.enable) then
		return "d", (rconf.buffs.castable == 1) and "RAID"
	end
end

-- UpdateBuffs
local function UpdateBuffs(self)
	local partyid = self.partyid
	if (not partyid) then
		return
	end

	local bf = self.buffFrame

	XPerl_CheckDebuffs(self, partyid)
	XPerl_ColourFriendlyUnit(self.nameFrame.text, partyid)

	local buffCount = 0
	local maxBuff = 8 - ((abs(1 - (rconf.mana or 0)) * 2) * (rconf.buffs.right or 0))

	local show, cureCast = GetShowCast(self)
	self.debuffsForced = nil
	if (show) then
		if (show == "b") then
			if (rconf.buffs.untilDebuffed) then
				local name, rank, buff = XPerl_UnitDebuff(partyid, 1, cureCast, true)
				if (name) then
					self.debuffsForced = true
					show = "d"
				end
			end
		end

		for buffnum=1,maxBuff do
			local name, rank, buff
			if (show == "b") then
				name, rank, buff = XPerl_UnitBuff(partyid, buffnum, cureCast, true)
			else
				name, rank, buff = XPerl_UnitDebuff(partyid, buffnum, cureCast, true)
			end
			local button = GetBuffButton(self, buffnum, buff)	-- 'buff' flags whether to create icon
			if (button) then
				if (buff) then
					buffCount = buffCount + 1

					button.icon:SetTexture(buff)
					if (not button:IsShown()) then
						button:Show()
					end
				else
					if (button:IsShown()) then
						button:Hide()
					end
				end
			end
		end
		for buffnum=maxBuff+1,8 do
			local button = bf.buff and bf.buff[buffnum]
			if (button) then
				if (button:IsShown()) then
	 				button:Hide()
				end
			end
		end
	end

	if (buffCount > 0) then
		bf:ClearAllPoints()
		if (not bf:IsShown()) then
			bf:Show()
		end
		local id = self:GetID()

		if (rconf.buffs.right) then
			bf:SetPoint("BOTTOMLEFT", self.statsFrame, "BOTTOMRIGHT", -1, 1)

			if (rconf.buffs.inside) then
				if (buffCount > 3 + (rconf.mana or 0)) then
					self.statsFrame:SetWidth(60)
				else
					self.statsFrame:SetWidth(70)
				end
			else
				self.statsFrame:SetWidth(80)
			end

			bf.buff[1]:ClearAllPoints()
			bf.buff[1]:SetPoint("BOTTOMLEFT", 0, 0)
			for i = 2,buffCount do
				if (i > buffCount) then break end

				local buffI = bf.buff[i]
				buffI:ClearAllPoints()

				if (i == 4 + (rconf.mana or 0)) then
					if (rconf.buffs.inside) then
						buffI:SetPoint("BOTTOMLEFT", 0, 0)
						bf.buff[1]:SetPoint("BOTTOMLEFT", buffI, "BOTTOMRIGHT", 0, 0)
					else
						buffI:SetPoint("BOTTOMLEFT", bf.buff[i-(4 - abs(1 - (rconf.mana or 0)))], "BOTTOMRIGHT", 0, 0)
					end
				else
					buffI:SetPoint("BOTTOMLEFT", bf.buff[i - 1], "TOPLEFT", 0, 0)
				end
			end
		else
			self.statsFrame:SetWidth(80)

			bf:SetPoint("TOPLEFT", self.statsFrame, "BOTTOMLEFT", 0, 1)

			local prevBuff
			for i = 1,buffCount do
	  			local buff = bf.buff[i]
				buff:ClearAllPoints()
				if (prevBuff) then
					buff:SetPoint("TOPLEFT", prevBuff, "TOPRIGHT", 0, 0)
				else
					buff:SetPoint("TOPLEFT", 0, 0)
				end
				prevBuff = buff
			end
		end
	else
		self.statsFrame:SetWidth(80)
		if (bf:IsShown()) then
			bf:Hide()
		end
	end

	local myRoster = XPerl_Roster[UnitName(partyid)]
	if (myRoster) then
		local _,class = UnitClass(partyid)
		if (class == "HUNTER") then
			if (UnitIsFeignDeath(partyid)) then
				if (not myRoster.fd) then
					myRoster.fd = GetTime()
					XPerl_Raid_UpdateHealth(self)
				end
			elseif (myRoster.fd) then
				myRoster.fd = nil
				XPerl_Raid_UpdateHealth(self)
			end
		end
	end
end

------------------
-- Buffs stuffs --
------------------

-- XPerl_Raid_UpdateCombat
local function XPerl_Raid_UpdateCombat(self)
	local partyid = self.partyid
	if (not partyid) then
		return
	end
	if (UnitExists(partyid) and UnitAffectingCombat(partyid)) then
		self.nameFrame.combatIcon:Show()
	else
		self.nameFrame.combatIcon:Hide()
	end
	if (UnitIsVisible(partyid) and UnitIsCharmed(partyid)) then
		self.nameFrame.warningIcon:Show()
	else
		self.nameFrame.warningIcon:Hide()
	end
end

-- XPerl_Raid_UpdatePlayerFlags(self)
local function XPerl_Raid_UpdatePlayerFlags(self, partyid,...)
	
	if (not partyid) then

		partyid = self:GetAttribute("unit")
	end



	local f = FrameArray[partyid]
	if (f) then

		self = f

		local unitName = UnitName(partyid)
		if (unitName) then
			local unitInfo = XPerl_Roster[unitName]
			if (unitInfo) then
				local change
				if (UnitIsAFK(partyid)) then
					if (not unitInfo.afk) then
						change = true
						unitInfo.afk = GetTime()
						unitInfo.dnd = nil
					end
				elseif (UnitIsDND(partyid)) then
					if (not unitInfo.dnd) then
						change = true
						unitInfo.dnd = GetTime()
						unitInfo.afk = nil
					end
				else
					if (unitInfo.afk or unitInfo.dnd) then
						unitInfo.afk, unitInfo.dnd = nil, nil
						change = true
					end
				end

				if (change) then
					local flags = XPerl_Raid_CheckFlags(partyid)
					if (flags) then
						XPerl_Raid_ShowFlags(self, flags)
					else
						XPerl_Raid_UpdateMana(self)
						XPerl_Raid_UpdateHealth(self)
					end
				end
			end
		end
	end
end

-- XPerl_Raid_ShowRaidGroup
--local function XPerl_Raid_ShowRaidGroup(show)
--	if (rconf.group[show] and rconf.enable and (show < 9 or rconf.sortByClass)) then
--		raidHeaders[show]:Show()
--	else
--		raidHeaders[show]:Hide()
--	end
--end

-- XPerl_Raid_OnUpdate
function XPerl_Raid_OnUpdate(self, elapsed)
	if (rosterUpdated) then
		rosterUpdated = nil
		if (not InCombatLockdown()) then
			XPerl_Raid_Position(self)
		end
		if (XPerl_Custom) then
			XPerl_Custom:UpdateUnits()
		end
		if (GetNumRaidMembers() == 0) then
			ResArray = {}
			XPerl_Roster = {}
			buffUpdates = {}
			return
		end
	end

	local updateHighlights, someUpdate
	local enemyUnitList

	self.time = self.time + elapsed
	if (self.time >= 0.2) then
		self.time = 0
		someUpdate = true
	end

	for i,frame in pairs(FrameArray) do
		if (frame:IsShown()) then
			if (frame.PlayerFlash) then
				XPerl_Raid_CombatFlash(frame, arg1, false)
			end

			if (someUpdate) then
				local unit = frame.partyid	-- frame:GetAttribute("unit")
				if (unit) then
					local name = UnitName(unit)
					if (name) then
						local myRoster = XPerl_Roster[name]
						if (myRoster) then
							if (frame.statsFrame.greyMana) then
								if (myRoster.offline and UnitIsConnected(unit)) then
									XPerl_Raid_UpdateHealth(frame)
								end
							else
								if (not myRoster.offline and not UnitIsConnected(unit)) then
									XPerl_Raid_UpdateHealth(frame)
								end
							end
						end
					end

					XPerl_UpdateSpellRange(frame, unit, true)
				end
			end
		end
	end

	local i = 1
	for k,v in pairs(buffUpdates) do
		UpdateBuffs(k)
		buffUpdates[k] = nil
		i = i + 1
		if (i > 5) then
			break
		end
	end

	fullyInitiallized = true
end

-- XPerl_Raid_RaidTargetUpdate
local function XPerl_Raid_RaidTargetUpdate(self)
	local icon = self.nameFrame.raidIcon
	local raidIcon = GetRaidTargetIndex(self.partyid)

	if (raidIcon) then
		if (not icon) then
			icon = self.nameFrame:CreateTexture(nil, "OVERLAY")
			self.nameFrame.raidIcon = icon
			icon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
			icon:SetPoint("LEFT")
			icon:SetWidth(16)
			icon:SetHeight(16)
		else
			icon:Show()
		end
		SetRaidTargetIconTexture(icon, raidIcon)
	elseif (icon) then
		icon:Hide()
	end
end

-------------------------
-- The Update Function --
-------------------------
function XPerl_Raid_UpdateDisplayAll()
	for k,v in pairs(FrameArray) do
		if (v:IsShown()) then
			XPerl_Raid_UpdateDisplay(v)
		end
	end
end

-- XPerl_Raid_UpdateDisplay
function XPerl_Raid_UpdateDisplay(self)
	-- Health must be updated after mana, since ctra flag checks are done here.
	if (rconf.mana) then
		XPerl_Raid_UpdateManaType(self)
		XPerl_Raid_UpdateMana(self)
	end
	XPerl_Raid_UpdatePlayerFlags(self)
	XPerl_Raid_UpdateHealth(self)		-- <<< -- AFTER MANA -- <<< --
	XPerl_Raid_UpdateName(self)
	XPerl_Raid_UpdateCombat(self)
	XPerl_Unit_UpdateReadyState(self)
	XPerl_Raid_RaidTargetUpdate(self)

	buffUpdates[self] = true		-- UpdateBuffs(self)

	if (not SkipHighlightUpdate) then
		XPerl_Highlight:SetHighlight(self)
	end

	if (XPerl_Voice) then
		XPerl_Voice:UpdateVoice(self)
	end
end

-- HideShowRaid
function XPerl_Raid_HideShowRaid()
	local singleGroup
	if (XPerl_Party_SingleGroup) then
		if (conf.party.smallRaid and fullyInitiallized) then
			singleGroup = XPerl_Party_SingleGroup()
		end
	end
	
	local enable = rconf.enable
	if (enable) then
		if (select(2, IsInInstance()) == "pvp") then
			enable = not rconf.notInBG
		end
	end

	for i = 1,WoWclassCount do
		if (rconf.group[i] == 1 and enable and (i < 9 or rconf.sortByClass) and not singleGroup) then
			if (not raidHeaders[i]:IsShown()) then
				raidHeaders[i]:Show()
			end
		else
			if (raidHeaders[i]:IsShown()) then
				raidHeaders[i]:Hide()
			end
		end
	end
end

-------------------
-- Event Handler --
-------------------

-- XPerl_Raid_OnEvent
function XPerl_Raid_OnEvent(self, event, unit, ...)
	local func = XPerl_Raid_Events[event]
	if (func) then
		if (strfind(event, "^UNIT_")) then
			local f = FrameArray[unit]
			if (f) then
				func(f, unit, ...)
			end
		else
			func(self, unit, ...)
		end
	else
XPerl_ShowMessage("EXTRA EVENT")
	end
end

-- VARIABLES_LOADED
function XPerl_Raid_Events:VARIABLES_LOADED()
	self:UnregisterEvent("VARIABLES_LOADED")

	if (GetNumRaidMembers() == 0) then
		ResArray = {}
		XPerl_Roster = {}
	else
		local myRoster = XPerl_Roster[UnitName("player")]
		if (myRoster) then
			myRoster.afk, myRoster.dnd, myRoster.ressed, myRoster.resCount = nil, nil, nil, nil
		end
	end

	XPerl_Highlight:Register(XPerl_Raid_HighlightCallback, self)

	XPerl_Raid_Events.VARIABLES_LOADED = nil
end

-- XPerl_Raid_Events:PLAYER_ENTERING_WORLDsmall()
function XPerl_Raid_Events:PLAYER_ENTERING_WORLDsmall()
	-- Force a re-draw. Events not processed for anything that happens during
	-- the small time you zone. Some display anomolies can occur from this
	XPerl_Raid_UpdateDisplayAll()

	if (IsInInstance()) then
		LoadAddOn("XPerl_CustomHighlight")
	end
end

-- PLAYER_ENTERING_WORLD
function XPerl_Raid_Events:PLAYER_ENTERING_WORLD()
	--self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	
	XPerl_Raid_ChangeAttributes()
	XPerl_RaidTitles()

	raidLoaded = true
	rosterUpdated = nil

	if (GetNumRaidMembers() > 0) then
		XPerl_Raid_Frame:Show()
	end

	if (IsInInstance()) then
		LoadAddOn("XPerl_CustomHighlight")
	end

	XPerl_Raid_Events.PLAYER_ENTERING_WORLD = XPerl_Raid_Events.PLAYER_ENTERING_WORLDsmall
	XPerl_Raid_Events.PLAYER_ENTERING_WORLDsmall = nil
end

do
	local rosterGuids
	-- XPerl_Raid_GetUnitFrameByGUID
	function XPerl_Raid_GetUnitFrameByGUID(guid)
		local unitid = rosterGuids and rosterGuids[guid]
		if (unitid) then
			return FrameArray[unitid]
		end
	end

	local function BuildGuidMap()
		if (GetNumRaidMembers() > 0) then
			rosterGuids = new()
			for i = 1,GetNumRaidMembers() do
				local guid = UnitGUID("raid"..i)
				if (guid) then
					rosterGuids[guid] = "raid"..i
				end
			end
		else
			rosterGuids = del(rosterGuids)
		end
	end

	-- RAID_ROSTER_UPDATE
	function XPerl_Raid_Events:RAID_ROSTER_UPDATE()
		rosterUpdated = true		-- Many roster updates can occur during 1 video frame, so we'll check everything at end of last one
		BuildGuidMap()
		if (GetNumRaidMembers() > 0) then
			XPerl_Raid_Frame:Show()
		end
	end
	
	function XPerl_Raid_Events:PLAYER_LOGIN()
		BuildGuidMap()
	end
end

-- UNIT_FLAGS
function XPerl_Raid_Events:UNIT_FLAGS()
	XPerl_Raid_UpdateCombat(self)
end

XPerl_Raid_Events.UNIT_DYNAMIC_FLAGS = XPerl_Raid_Events.UNIT_FLAGS

function XPerl_Raid_Events:PLAYER_FLAGS_CHANGED(unit,...)
	XPerl_Raid_UpdatePlayerFlags(self, unit,...)
end

-- UNIT_FACTION
function XPerl_Raid_Events:UNIT_FACTION()
	XPerl_Raid_UpdateCombat(self)
	XPerl_Raid_UpdateName(self)
end

-- UNIT_COMBAT
function XPerl_Raid_Events:UNIT_COMBAT()
	if (arg2 == "HEAL") then
		XPerl_Raid_CombatFlash(self, 0, true, true)
	elseif (arg4 and arg4 > 0) then
		XPerl_Raid_CombatFlash(self, 0, true)
	end
end

-- UNIT_HEALTH
function XPerl_Raid_Events:UNIT_HEALTH()
	XPerl_Raid_UpdateHealth(self)
	XPerl_Raid_UpdateCombat(self)
end
XPerl_Raid_Events.UNIT_MAXHEALTH = XPerl_Raid_Events.UNIT_HEALTH

function XPerl_Raid_Events:UNIT_DISPLAYPOWER()
	XPerl_Raid_UpdateManaType(self)
	XPerl_Raid_UpdateMana(self)
end

-- WoW 4.0 UNIT_POWER shit (Added by PlayerLin)

function XPerl_Raid_Events:UNIT_POWER()
	if (rconf.mana) then
		XPerl_Raid_UpdateMana(self)
	end
end

XPerl_Raid_Events.UNIT_MAXPOWER   = XPerl_Raid_Events.UNIT_POWER

-- WoW 3.3.5 and older.
-- UNIT_MANA
function XPerl_Raid_Events:UNIT_MANA()
	if (rconf.mana) then
		XPerl_Raid_UpdateMana(self)
	end
end
XPerl_Raid_Events.UNIT_MAXMANA   = XPerl_Raid_Events.UNIT_MANA
XPerl_Raid_Events.UNIT_RAGE      = XPerl_Raid_Events.UNIT_MANA
XPerl_Raid_Events.UNIT_MAXRAGE   = XPerl_Raid_Events.UNIT_MANA
XPerl_Raid_Events.UNIT_ENERGY    = XPerl_Raid_Events.UNIT_MANA
XPerl_Raid_Events.UNIT_MAXENERGY = XPerl_Raid_Events.UNIT_MANA
XPerl_Raid_Events.UNIT_RUNIC_POWER = XPerl_Raid_Events.UNIT_MANA
XPerl_Raid_Events.UNIT_MAXRUNIC_POWER = XPerl_Raid_Events.UNIT_MANA

-- UNIT_NAME_UPDATE
function XPerl_Raid_Events:UNIT_NAME_UPDATE()
	XPerl_Raid_UpdateName(self)
	XPerl_Raid_UpdateHealth(self)			-- Added 16th May 2007 - Seems they now fire name update to indicate some change in state.
end

-- UNIT_AURA
function XPerl_Raid_Events:UNIT_AURA()
	lastNamesList, lastName, lastWith = nil, nil, nil
	UpdateBuffs(self)
end

-- READY_CHECK
function XPerl_Raid_Events:READY_CHECK(a, b, c)
	for i,frame in pairs(FrameArray) do
		if (frame.partyid) then
			XPerl_Unit_UpdateReadyState(frame)
		end
	end
end

XPerl_Raid_Events.READY_CHECK_CONFIRM = XPerl_Raid_Events.READY_CHECK
XPerl_Raid_Events.READY_CHECK_FINISHED = XPerl_Raid_Events.READY_CHECK

-- RAID_TARGET_UPDATE
function XPerl_Raid_Events:RAID_TARGET_UPDATE()
	for i,frame in pairs(FrameArray) do
		if (frame.partyid) then
			XPerl_Raid_RaidTargetUpdate(frame)
		end
	end
end

-- SetRes
local function SetResStatus(resserName, resTargetName, ignoreCounter)

	--frame.beingRessed = true
	local resEnd

	if (resTargetName) then
		ResArray[resserName] = resTargetName
	else
		resEnd = true

		for i,name in pairs(ResArray) do
			if (i == resserName) then
				resTargetName = name
				break
			end
		end

		ResArray[resserName] = nil
	end

	if (resTargetName) then
		local myRoster = XPerl_Roster[resTargetName]
		if (myRoster) then
			if (resEnd and not ignoreCounter) then
				myRoster.ressed = 1
				myRoster.resCount = (myRoster.resCount or 0) + 1
			end
			UpdateUnitByName(resTargetName, true)
		end
	end
end

-- UNIT_SPELLCAST_START
function XPerl_Raid_Events:UNIT_SPELLCAST_START(unit, spell, rank)
	if (ResArray[UnitName(unit)]) then
		-- Flagged as ressing, finish their old cast
		SetResStatus(UnitName(unit))
	end

	local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitCastingInfo(unit)
	if (resSpells[name]) then
		local u = unit.."target"
		if (UnitExists(u) and UnitIsDead(u)) then
			SetResStatus(UnitName(unit), UnitName(u))
		end
	end
end

-- UNIT_SPELLCAST_STOP
function XPerl_Raid_Events:UNIT_SPELLCAST_STOP(unit)
	if (unit) then
		SetResStatus(UnitName(unit))
	end
end

-- UNIT_SPELLCAST_FAILED
function XPerl_Raid_Events:UNIT_SPELLCAST_FAILED(unit)
	if (unit) then
		SetResStatus(UnitName(unit), nil, true)
	end
end

XPerl_Raid_Events.UNIT_SPELLCAST_INTERRUPTED = XPerl_Raid_Events.UNIT_SPELLCAST_FAILED

-- Direct string matches can be done via table lookup
local QuickFuncs = {
	--AFK	= function(m)	m.afk = GetTime(); m.dnd = nil; end,
	--UNAFK	= function(m)	m.afk = nil; end,
	--DND	= function(m)	m.dnd = GetTime(); m.afk = nil; end,
	--UNDND	= function(m)	m.dnd = nil; end,
	RESNO	= function(m,n) SetResStatus(n) end,
	RESSED	= function(m)	m.ressed = 1; end,
	CANRES	= function(m)	m.ressed = 2; end,
	NORESSED= function(m)
		if (m.ressed) then
			m.ressed = 3
		else
			m.ressed = nil
		end
		m.resCount = nil
	end,
	SR	= XPerl_SendModules
}

-- DurabilityCheck(msg, author)
-- Quick DUR check for those people who don't have oRA2 and CTRA installed
-- No, I'm not going to replace either mod
local XPerl_DurabilityCheck
do
	local tip
	function XPerl_DurabilityCheck(author)
		local durPattern = gsub(DURABILITY_TEMPLATE, "(%%%d-$-d)", "(%%d+)")
		local cur, max, broken = 0, 0, 0
		if (not tip) then
			tip = CreateFrame("GameTooltip", "XPerlDurCheckTooltip")
		end

		tip:SetOwner(self, "ANCHOR_RIGHT")
		tip:ClearAllPoints()
		tip:SetPoint("TOP", UIParent, "BOTTOM", -200, 0)
		for i = 1, 18 do
			if (GetInventoryItemBroken("player", i)) then
				broken = broken + 1
			end

			tip:SetInventoryItem("player", i)

			for j = 1,tip:NumLines() do
				local line = _G[tip:GetName().."TextLeft"..j]
				if (line) then
					local text = line:GetText()
					if (text) then
						local imin, imax = strmatch(text, durPattern)
						if (imin and imax) then
							imin, imax = tonumber(imin), tonumber(imax)
							cur = cur + imin
							max = max + imax
							break
						end
					end
				end
			end
		end

		tip:Hide()

		SendAddonMessage("CTRA", format("DUR %s %s %s %s", cur, max, broken, author), "RAID")
	end
end

-- XPerl_ItemCheckCount
local function XPerl_ItemCheckCount(itemName, author)
	local count = GetItemCount(itemName)
	if (count and count > 0) then
		SendAddonMessage("CTRA", "ITM "..count.." "..itemName.." "..author, "RAID")
	end
end

-- XPerl_ResistsCheck
local function XPerl_ResistsCheck(unitName)
	local str = ""
	for i = 2, 6 do
		str = str.." "..select(2, UnitResistance("player", i))
	end
	SendAddonMessage("CTRA", format("RST%s %s", str, unitName), "RAID")
end

-- ProcessCTRAMessage
local function ProcessCTRAMessage(unitName, msg)
	local myRoster = XPerl_Roster[unitName]

	if (not myRoster) then
		return
	end

	local update = true

	local func = QuickFuncs[msg]
	if (func) then
--ChatFrame7:AddMessage("QuickFuncs["..msg.."]")
		func(myRoster, unitName)
	else
		if (strsub(msg, 1, 4) == "RES ") then
			SetResStatus(unitName, strsub(msg, 5))
			return

		elseif (strsub(msg, 1, 3) == "CD ") then
			local num, cooldown = strmatch(msg, "^CD (%d+) (%d+)$")
			if ( num == "1" ) then
				myRoster.Rebirth = GetTime() + tonumber(cooldown)*60
			elseif ( num == "2" ) then
				myRoster.Reincarnation = GetTime() + tonumber(cooldown)*60
			elseif ( num == "3" ) then
				myRoster.Soulstone = GetTime() + tonumber(cooldown)*60
			end
			update = nil

		elseif (strsub(msg, 1, 2) == "V ") then
			myRoster.version = strsub(msg, 3)
			update = nil

		elseif (msg == "DURC") then
			if (not CT_RA_VersionNumber and not oRA) then
				XPerl_DurabilityCheck(unitName)
			end

		elseif (msg == "RSTC") then
			if (not CT_RA_VersionNumber and not oRA) then
				XPerl_ResistsCheck(unitName)
			end

		elseif (strsub(msg, 1, 4) == "ITMC") then
			if (not CT_RA_VersionNumber and not oRA) then
				local itemName = strmatch(msg, "^ITMC (.+)$")
				if (itemName) then
					XPerl_ItemCheckCount(itemName, unitName)
				end
			end
		else
			update = nil
		end
	end

	if (update) then
		UpdateUnitByName(unitName, true)
	end
end

-- ProcessoRAMessage
local function ProcessoRAMessage(unitName, msg)
	local myRoster = XPerl_Roster[unitName]

	if (not myRoster) then
		return
	end

	if (strsub(msg, 1, 5) == "oRAV ") then
		myRoster.oRAversion = strsub(msg, 6)
	end
end

-- XPerl_Raid_Events:CHAT_MSG_RAID
-- Check for AFK/DND flags in chat
--function XPerl_Raid_Events:CHAT_MSG_RAID()
--	local myRoster = XPerl_Roster[arg4]
--	if (myRoster) then
--		if (arg6 == "AFK") then
--			if (not myRoster.afk) then
--				myRoster.afk = GetTime()
--				myRoster.dnd = nil
--			end
--		elseif (arg6 == "DND") then
--			if (not myRoster.dnd) then
--				myRoster.dnd = GetTime()
--				myRoster.afk = nil
--			end
--		else
--			myRoster.dnd, myRoster.afk = nil, nil
--		end
--	end
--end
--XPerl_Raid_Events.CHAT_MSG_RAID_LEADER = XPerl_Raid_Events.CHAT_MSG_RAID
--XPerl_Raid_Events.CHAT_MSG_PARTY = XPerl_Raid_Events.CHAT_MSG_RAID

-- XPerl_ParseCTRA
function XPerl_ParseCTRA(sender, msg, func)
	local arr = new(strsplit("#", msg))
	for i,subMsg in pairs(arr) do
		func(sender, subMsg)
	end
	del(arr)
end

-- CHAT_MSG_ADDON
function XPerl_Raid_Events:CHAT_MSG_ADDON(prefix, msg, channel, sender)
	if (channel == "RAID") then
		if (prefix == "CTRA") then
			XPerl_ParseCTRA(sender, msg, ProcessCTRAMessage)
		elseif (prefix == "oRA") then
			XPerl_ParseCTRA(sender, msg, ProcessoRAMessage)
		end
	end
end

-- SetRaidRoster
local function SetRaidRoster()
	local NewRoster = new()

	del(RaidPositions)
	RaidPositions = new()

	del(RaidGroupCounts)
	RaidGroupCounts = new(0,0,0,0,0,0,0,0,0,0)

	for i = 1,GetNumRaidMembers() do
		local name, rank, group, level, class, fileName = GetRaidRosterInfo(i)

		if (name) then
			local unit = "raid"..i
			RaidPositions[name] = unit

			if (UnitIsUnit(unit, "player")) then
				myGroup = group
			end

			if (rconf.sortByClass) then
				for j = 1,WoWclassCount do
					if (rconf.class[j].name == fileName and rconf.class[j].enable) then
						RaidGroupCounts[j] = RaidGroupCounts[j] + 1
						break
					end
				end
			else
				RaidGroupCounts[group] = RaidGroupCounts[group] + 1
			end

			local r = XPerl_Roster[name]
			if (r) then
				NewRoster[name] = r
				XPerl_Roster[name] = nil
				r.afk = UnitIsAFK(unit) and GetTime() or nil
				r.dnd = UnitIsDND(unit) and GetTime() or nil
			else
				NewRoster[name] = new()
			end
		end
	end

	if (GetNumRaidMembers() > 0) then
		XPerl_Raid_Frame:Show()
	else
		XPerl_Raid_Frame:Hide()
	end

	del(XPerl_Roster, true)
	XPerl_Roster = NewRoster
end

-- XPerl_RaidGroupCounts()
function XPerl_RaidGroupCounts()
	return RaidGroupCounts
end

-- XPerl_Raid_Position
function XPerl_Raid_Position(self)
	SetRaidRoster()
	XPerl_RaidTitles()

	if (conf.party.smallRaid and fullyInitiallized and not InCombatLockdown()) then
		XPerl_Raid_HideShowRaid()
	end
end

--------------------
-- Click Handlers --
--------------------

-- XPerl_ScaleRaid
function XPerl_ScaleRaid()
	for frame = 1,WoWclassCount do
		local f = _G["XPerl_Raid_Title"..frame]
		if (f) then
			f:SetScale(rconf.scale)
		end
	end
end

-- XPerl_RaidTitles
function XPerl_RaidTitles()
	local singleGroup
	if (XPerl_Party_SingleGroup) then
		if (conf.party.smallRaid and fullyInitiallized) then
			singleGroup = XPerl_Party_SingleGroup()
		end
	end

	local c
	for i = 1,WoWclassCount do
		local confClass = rconf.class[i].name
		local frame = _G["XPerl_Raid_Title"..i]
		local titleFrame = frame.text
		local virtualFrame = frame.virtual

		if (not rconf.sortByClass and myGroup == i) then
			c = HIGHLIGHT_FONT_COLOR
		else
			c = NORMAL_FONT_COLOR
		end
		titleFrame:SetTextColor(c.r, c.g, c.b)

		if (rconf.sortByClass) then
			if (LOCALIZED_CLASS_NAMES_MALE[confClass]) then
				titleFrame:SetText(LOCALIZED_CLASS_NAMES_MALE[confClass])
			else
				titleFrame:SetText(localGroups[confClass])
			end
		else
			titleFrame:SetFormattedText(XPERL_RAID_GROUP, i)
		end

		local enable = rconf.enable
		if (enable) then
			if (select(2, IsInInstance()) == "pvp") then
				enable = not rconf.notInBG
			end
		end

		if (XPerlLocked == 0 or (RaidGroupCounts[i] > 0 and enable and rconf.group[i] and not singleGroup)) then
			if (XPerlLocked == 0 or rconf.titles) then
				if (not titleFrame:IsShown()) then
					titleFrame:Show()
				end
			else
				if (titleFrame:IsShown()) then
					titleFrame:Hide()
				end
			end

			if (XPerlLocked == 0) then
				local rows = conf.sortByClass and RaidGroupCounts[i] or 5
				virtualFrame:ClearAllPoints()
				if (rconf.anchor == "TOP") then
					virtualFrame:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 0)
					virtualFrame:SetHeight(((rconf.mana or 0) * rows + 38) * rows + (rconf.spacing * (rows - 1)))
					virtualFrame:SetWidth(80)

				elseif (rconf.anchor == "LEFT") then
					virtualFrame:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 0)
					virtualFrame:SetHeight((rconf.mana or 0) * 5 + 38)
					virtualFrame:SetWidth(80 * rows + (rconf.spacing * (rows - 1)))

				elseif (rconf.anchor == "BOTTOM") then
					virtualFrame:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 0)
					virtualFrame:SetHeight(((rconf.mana or 0) * rows + 38) * rows + (rconf.spacing * (rows - 1)))
					virtualFrame:SetWidth(80)

				elseif (rconf.anchor == "RIGHT") then
					virtualFrame:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", 0, 0)
					virtualFrame:SetHeight((rconf.mana or 0) * 5 + 38)
					virtualFrame:SetWidth(80 * rows + (rconf.spacing * (rows - 1)))
				end

				virtualFrame:SetBackdropColor(conf.colour.frame.r, conf.colour.frame.g, conf.colour.frame.b, conf.colour.frame.a)
				virtualFrame:SetBackdropBorderColor(conf.colour.border.r, conf.colour.border.g, conf.colour.border.b, 1)
				virtualFrame:Show()
			else
				virtualFrame:Hide()
			end
		else
			if (virtualFrame:IsShown()) then
				virtualFrame:Hide()
			end
			if (titleFrame:IsShown()) then
				titleFrame:Hide()
			end
		end
	end

	XPerl_ProtectedCall(XPerl_EnableRaidMouse)

	if (XPerl_RaidPets_Align) then
		XPerl_ProtectedCall(XPerl_RaidPets_Align)
	end
end

-- XPerl_EnableRaidMouse()
function XPerl_EnableRaidMouse()
	for i = 1,WoWclassCount do
		local frame = _G["XPerl_Raid_Title"..i]
		if (XPerlLocked == 0) then
			frame:EnableMouse(true)
		else
			frame:EnableMouse(false)
		end
	end
end

-- XPerl_Raid_SetBuffTooltip
function XPerl_Raid_SetBuffTooltip(self)
	if (conf.tooltip.enableBuffs and XPerl_TooltipModiferPressed(true)) then
		if (not conf.tooltip.hideInCombat or not InCombatLockdown()) then
			local parentUnit = self:GetParent():GetParent()
			local partyid = SecureButton_GetUnit(parentUnit)
			if (not partyid) then
				return
			end

			GameTooltip:SetOwner(self,"ANCHOR_BOTTOMRIGHT",30,0)

			local show, cureCast = GetShowCast(parentUnit)
			if (parentUnit.debuffsForced) then
				show = "d"
			end
			if (show == "b") then
				XPerl_TooltipSetUnitBuff(GameTooltip, partyid, self:GetID(), cureCast, true)
			elseif (show == "d") then
				XPerl_TooltipSetUnitDebuff(GameTooltip, partyid, self:GetID(), cureCast, true)
			end
		end
	end
end

------- XPerl_ToggleRaidBuffs -------
-- Raid Buff Key Binding function --
function XPerl_ToggleRaidBuffs(castable)

	if (castable) then
		if (rconf.buffs.castable == 1) then
			rconf.buffs.castable = 0
			XPerl_Notice(XPERL_KEY_NOTICE_RAID_BUFFANY)
		else
			rconf.buffs.castable = 1
			XPerl_Notice(XPERL_KEY_NOTICE_RAID_BUFFCURECAST)
		end
	else
		if (rconf.buffs.enable) then
			rconf.buffs.enable = nil
			rconf.debuffs.enable = 1
			XPerl_Notice(XPERL_KEY_NOTICE_RAID_DEBUFFS)

		elseif (rconf.debuffs.enable) then
			rconf.buffs.enable = nil
			rconf.debuffs.enable = nil
			XPerl_Notice(XPERL_KEY_NOTICE_RAID_NOBUFFS)

		else
			rconf.buffs.enable = 1
			rconf.debuffs.enable = nil
			XPerl_Notice(XPERL_KEY_NOTICE_RAID_BUFFS)
		end
	end

	for k,v in pairs(FrameArray) do
		if (v:IsShown()) then
			XPerl_Raid_UpdateDisplay(v)
		end
	end
end

-- XPerl_ToggleRaidSort
function XPerl_ToggleRaidSort(New)
	if (not XPerl_Options or not XPerl_Options:IsShown()) then
		if (not InCombatLockdown()) then
			if (New) then
				conf.sortByClass = New == 1
			else
				if (conf.sortByClass) then
					conf.sortByClass = nil
				else
					conf.sortByClass = 1
				end
			end
			XPerl_Raid_ChangeAttributes()
			XPerl_Raid_Position()
			XPerl_Raid_Set_Bits(XPerl_Raid_Frame)
		end
	end
end

-- GetCombatRezzerList()
local normalRezzers = {PRIEST = true, SHAMAN = true, PALADIN = true}
local function GetCombatRezzerList()

	local anyCombat = 0
	local anyAlive = 0
	for i = 1,GetNumRaidMembers() do
		local unit = "raid"..i
		if (normalRezzers[select(2, UnitClass(unit))]) then
			if (UnitAffectingCombat(unit)) then
				anyCombat = anyCombat + 1
			end
			if (not UnitIsDeadOrGhost(unit) and UnitIsConnected(unit)) then
				anyAlive = anyAlive + 1
			end
		end
	end

	-- We only need to know about battle rezzers if any normal rezzers are in combat
	if (anyCombat > 0 or anyAlive < 3) then
		local ret = new()
		local t = GetTime()

		for i = 1,GetNumRaidMembers() do
			local raidid = "raid"..i
			if (not UnitIsDeadOrGhost(raidid) and UnitIsVisible(raidid)) then
				local name, rank, subgroup, level, _, fileName, zone, online, isDead = GetRaidRosterInfo(i)

				local good
				if (not UnitAffectingCombat(raidid)) then
					if (fileName == "PRIEST" or fileName == "SHAMAN" or fileName == "PALADIN") then
						tinsert(ret, {["name"] = name, class = fileName, cd = 0})
					end
				else
					if (fileName == "DRUID") then
						local myRoster = XPerl_Roster[name]

						if (myRoster) then
							if (myRoster.Rebirth and myRoster.Rebirth - t <= 0) then
								myRoster.Rebirth = nil		-- Check for expired cooldown
							end
							if (myRoster.Rebirth) then
								if (myRoster.Rebirth - t < 120) then
									tinsert(ret, {["name"] = name, class = fileName, cd = myRoster.Rebirth - t})
								end
							else
								tinsert(ret, {["name"] = name, class = fileName, cd = 0})
							end
						end
					end
				end
			end
		end

		if (#ret > 0) then
			sort(ret, function(a,b) return a.cd < b.cd end)

			local list = ""
			for k,v in ipairs(ret) do
				local name = XPerlColourTable[v.class]..v.name.."|r"

				if (v.cd > 0) then
					name = name.." (in "..SecondsToTime(v.cd)..")"
				end

				if (list == "") then
					list = name
				else
					list = list..", "..name
				end
			end
			del(ret)
			return list
		else
			del(ret)
			return "|c00FF0000"..NONE.."|r"
		end
	end

	if (anyAlive == 0) then
		return "|c00FF0000"..NONE.."|r"
	elseif (anyCombat == 0) then
		return "|c00FFFFFF"..ALL.."|r"
	end
end

-- XPerl_RaidTipExtra
function XPerl_RaidTipExtra(unitid)

	if (UnitInRaid(unitid)) then
		local unitName = UnitName(unitid)
		local zone
		local name, rank, subgroup, level, class, fileName, zone, online, isDead

		for i = 1,GetNumRaidMembers() do
			name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i)
			if (name == unitName) then
				break
			end
			zone = ""
		end

		local stats = XPerl_Roster[unitName]
		if (stats) then
			local t = GetTime()

			if (stats.version) then
				if (stats.oRAversion) then
					GameTooltip:AddLine("CTRA "..stats.version.." (oRA "..stats.oRAversion..")", 1, 1, 1)
				else
					GameTooltip:AddLine("CTRA "..stats.version, 1, 1, 1)
				end
			else
				GameTooltip:AddLine(XPERL_RAID_TOOLTIP_NOCTRA, 0.7, 0.7, 0.7)
			end

			if (stats.offline and UnitIsConnected(unitid)) then
				stats.offline = nil
			end
			if (stats.afk and not UnitIsAFK(unitid)) then
				stats.afk = nil
			end
			if (stats.dnd and not UnitIsDND(unitid)) then
				stats.dnd = nil
			end

			if (stats.offline) then
				GameTooltip:AddLine(format(XPERL_RAID_TOOLTIP_OFFLINE, SecondsToTime(t - stats.offline)))

			elseif (stats.afk) then
				GameTooltip:AddLine(format(XPERL_RAID_TOOLTIP_AFK, SecondsToTime(t - stats.afk)))

			elseif (stats.dnd) then
				GameTooltip:AddLine(format(XPERL_RAID_TOOLTIP_DND, SecondsToTime(t - stats.dnd)))

			elseif (stats.fd) then
				if (not UnitIsDead(unitid)) then
					stats.fd = nil
				else
					local x = stats.fd + 360 - t
					if (x > 0) then
						GameTooltip:AddLine(format(XPERL_RAID_TOOLTIP_DYING, SecondsToTime(x)))
					end
				end
			end

			if (stats.Rebirth) then
				if (stats.Rebirth - t > 0) then
					GameTooltip:AddLine(format(XPERL_RAID_TOOLTIP_REBIRTH, SecondsToTime(stats.Rebirth - t)))
				else
					stats.Rebirth = nil
				end

			elseif (stats.Reincarnation) then
				if (stats.Reincarnation - t > 0) then
					GameTooltip:AddLine(format(XPERL_RAID_TOOLTIP_ANKH, SecondsToTime(stats.Reincarnation - t)))
				else
					stats.Reincarnation = nil
				end

			elseif (stats.Soulstone) then
				if (stats.Soulstone - t > 0) then
					GameTooltip:AddLine(format(XPERL_RAID_TOOLTIP_SOULSTONE, SecondsToTime(stats.Soulstone - t)))
				else
					stats.Soulstone = nil
				end
			end

			if (UnitIsDeadOrGhost(unitid) and not UnitIsFeignDeath(unitid)) then
				if (stats.resCount) then
					GameTooltip:AddLine(XPERL_LOC_RESURRECTED.." x"..stats.resCount)
				end

				local Rezzers = GetCombatRezzerList()
				if (Rezzers) then
					GameTooltip:AddLine(XPERL_RAID_RESSER_AVAIL..Rezzers, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
				end
			end
		end

		GameTooltip:Show()
	end
end

-- initialConfigFunction
local function initialConfigFunction(self)
	-- This is the only place we're allowed to set attributes whilst in combat
	
	self:SetScript("OnAttributeChanged", onAttrChanged)
	XPerl_RegisterClickCastFrame(self)
	XPerl_RegisterClickCastFrame(self.nameFrame)

	Setup1RaidFrame(self)

	self:SetAttribute("*type1", "target")
	self:SetAttribute("type2", "menu")
	self.menu = XPerl_Raid_ShowPopup

	-- Does AllowAttributeChange work for children?
	self.nameFrame:SetAttribute("useparent-unit", true)
	self.nameFrame:SetAttribute("*type1", "target")
	self.nameFrame:SetAttribute("type2", "menu")
	self.nameFrame.menu = XPerl_Raid_ShowPopup

	if (rconf.mana) then
		self:SetAttribute("initial-height", 43)
	else
		self:SetAttribute("initial-height", 38)
	end
end

-- SetMainHeaderAttributes
local function SetMainHeaderAttributes(self)

	self:Hide()

	self.initialConfigFunction = initialConfigFunction

	if (rconf.sortAlpha) then
		self:SetAttribute("sortMethod", "NAME")
	else
		self:SetAttribute("sortMethod", nil)
	end

	self:SetAttribute("point", rconf.anchor)
	self:SetAttribute("minWidth", 80)
	self:SetAttribute("minHeight", 10)
	local titleFrame = self:GetParent()
	self:ClearAllPoints()
	if (rconf.anchor == "TOP") then
		self:SetPoint("TOP", titleFrame, "BOTTOM", 0, 0)
		self:SetAttribute("xOffset", 0)
		self:SetAttribute("yOffset", -rconf.spacing)
	elseif (rconf.anchor == "LEFT") then
		self:SetPoint("TOPLEFT", titleFrame, "BOTTOMLEFT", 0, 0)
		self:SetAttribute("xOffset", rconf.spacing)
		self:SetAttribute("yOffset", 0)
	elseif (rconf.anchor == "BOTTOM") then
		self:SetPoint("BOTTOM", titleFrame, "TOP", 0, 0)
		self:SetAttribute("xOffset", 0)
		self:SetAttribute("yOffset", rconf.spacing)
	elseif (rconf.anchor == "RIGHT") then
		self:SetPoint("TOPRIGHT", titleFrame, "BOTTOMRIGHT", 0, 0)
		self:SetAttribute("xOffset", -rconf.spacing)
		self:SetAttribute("yOffset", 0)
	end
end

-- XPerl_Raid_SetAttributes
function XPerl_Raid_ChangeAttributes()

	if (InCombatLockdown()) then
		tinsert(XPerl_OutOfCombatQueue, XPerl_Raid_ChangeAttributes)
		return
	end

	rconf.anchor = (rconf and rconf.anchor) or "TOP"

	local function DefaultRaidClasses()
		return {
			{enable = true, name = "WARRIOR"},
			{enable = true, name = "DEATHKNIGHT"},
			{enable = true, name = "ROGUE"},
			{enable = true, name = "HUNTER"},
			{enable = true, name = "MAGE"},
			{enable = true, name = "WARLOCK"},
			{enable = true, name = "PRIEST"},
			{enable = true, name = "DRUID"},
			{enable = true, name = "SHAMAN"},
			{enable = true, name = "PALADIN"},
		}
	end

	local function GroupFilter(n)
		if (rconf.sortByClass) then
			if (not rconf.class[n]) then
				rconf.class = DefaultRaidClasses()
			end
			if (rconf.class[n].enable) then
				return rconf.class[n].name
			end
			return ""
		else
			local f
			if (rconf.group[n]) then
				f = tostring(n)
			end

			for i = 1,WoWclassCount do
				if (not rconf.class[i]) then
					invalid = true
				end
			end
			if (invalid) then
				rconf.class = DefaultRaidClasses()
			end

			for i = 1,WoWclassCount do
				if (rconf.class[i].enable) then
					if (not f) then
						f = rconf.class[i].name
					else
						f = f..","..rconf.class[i].name
					end
				end
			end
			return f
		end
	end

	for i = 1,rconf.sortByClass and WoWclassCount or 8 do
		local groupHeader = raidHeaders[i]

		-- Hide this when we change attributes, so the whole re-calc is only done once, instead of for every attribute change
		groupHeader:Hide()

		groupHeader:SetAttribute("strictFiltering", not rconf.sortByClass)
		groupHeader:SetAttribute("groupFilter", GroupFilter(i))
		SetMainHeaderAttributes(groupHeader)
	end

	XPerl_Raid_HideShowRaid()
end

-- XPerl_Raid_Set_Bits
function XPerl_Raid_Set_Bits(self)
	if (raidLoaded) then
		XPerl_ProtectedCall(XPerl_Raid_HideShowRaid)
	end
	SkipHighlightUpdate = nil

	XPerl_ScaleRaid()

	for i = 1,WoWclassCount do
		XPerl_SavePosition(_G["XPerl_Raid_Title"..i], true)
	end

	for i,frame in pairs(FrameArray) do
		Setup1RaidFrame(frame)
	end

	local manaEvents = {"UNIT_DISPLAYPOWER", "UNIT_RAGE", "UNIT_MAXRAGE", "UNIT_ENERGY", "UNIT_MAXENERGY", "UNIT_MANA", "UNIT_MAXMANA", "UNIT_RUNIC_POWER", "UNIT_MAXRUNIC_POWER"}
	for i,event in pairs(manaEvents) do
		if (rconf.mana) then
			self:RegisterEvent(event)
		else
			self:UnregisterEvent(event)
		end
	end
	SkipHighlightUpdate = nil

	if (GetNumRaidMembers() > 0) then
		XPerl_Raid_Frame:Show()
	end
end
