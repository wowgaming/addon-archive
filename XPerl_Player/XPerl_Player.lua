-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

local XPerl_Player_Events = {}
local isOutOfControl = nil
local playerClass, playerName
local conf, pconf
XPerl_RequestConfig(function(new) conf = new pconf = conf.player if (XPerl_Player) then XPerl_Player.conf = conf.player end end, "$Revision: 380 $")
local perc1F = "%.1f"..PERCENT_SYMBOL
local percD = "%d"..PERCENT_SYMBOL

local format = format
local GetNumRaidMembers = GetNumRaidMembers
local UnitIsDead = UnitIsDead
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitIsGhost = UnitIsGhost
local UnitIsAFK = UnitIsAFK
local UnitMana = UnitMana
local UnitManaMax = UnitManaMax
local UnitName = UnitName
local UnitPower = UnitPower
local UnitPowerType = UnitPowerType
local XPerl_SetHealthBar = XPerl_SetHealthBar

local XPerl_Player_InitDK
local XPerl_Player_InitWarlock

local XPerl_PlayerStatus_OnUpdate
local XPerl_Player_HighlightCallback

----------------------
-- Loading Function --
----------------------
function XPerl_Player_OnLoad(self)
	XPerl_SetChildMembers(self)
	self.partyid = "player"

	XPerl_BlizzFrameDisable(PlayerFrame)

	CombatFeedback_Initialize(self, self.hitIndicator.text, 30)

	XPerl_SecureUnitButton_OnLoad(self, "player", nil, PlayerFrameDropDown, PlayerFrame.menu)
	XPerl_SecureUnitButton_OnLoad(self.nameFrame, "player", nil, PlayerFrameDropDown, PlayerFrame.menu)

	self:RegisterEvent("VARIABLES_LOADED")

	self.EnergyLast = 0
	self.tutorialPage = 2
	self:SetScript("OnUpdate", XPerl_Player_OnUpdate)
	self:SetScript("OnEvent", XPerl_Player_OnEvent)
	self:SetScript("OnShow", XPerl_Unit_UpdatePortrait)
	self.time = 0

	self.nameFrame.pvp:SetScript("OnUpdate",
		function(self, elapsed)
			if (IsPVPTimerRunning()) then
				local timeLeft = GetPVPTimer()
				if (timeLeft > 0 and timeLeft < 300000) then		-- 5 * 60 * 1000
					timeLeft = floor(timeLeft / 1000)
					self.timer:Show()
					self.timer:SetFormattedText("%d:%02d", timeLeft / 60, timeLeft % 60)
					return
				end
			end
			self.timer:Hide()
		end)

	XPerl_Player_InitDK(self)
	XPerl_Player_SetupDK(self)

	--Only initalize this function if it's cataclym client.
	if is_cata then
		XPerl_Player_InitWarlock(self)
	end

	XPerl_RegisterHighlight(self.highlight, 3)
	XPerl_RegisterPerlFrames(self, {self.nameFrame, self.statsFrame, self.levelFrame, self.portraitFrame, self.groupFrame, self.runes})

	self.FlashFrames = {self.portraitFrame, self.nameFrame,
				self.levelFrame, self.statsFrame, self.runes}

	XPerl_RegisterOptionChanger(XPerl_Player_Set_Bits, self)
	XPerl_Highlight:Register(XPerl_Player_HighlightCallback, self)
	--self.IgnoreHighlightStates = {AGGRO = true}

	if (XPerlDB) then
		self.conf = XPerlDB.player
	end

	XPerl_Player_OnLoad = nil
end

-- XPerl_Player_HighlightCallback(updateName)
function XPerl_Player_HighlightCallback(self, updateGUID)
	if (updateGUID == UnitGUID("player")) then
		XPerl_Highlight:SetHighlight(self, updateGUID)
	end
end

-- UpdateAssignedRoles
local function UpdateAssignedRoles(self)
	local unit = self.partyid
	local icon = self.nameFrame.roleIcon
	local isTank, isHealer, isDamage
	local isInstance = select(2, IsInInstance())
	if (select(2, IsInInstance()) == "party") then
		-- No point getting it otherwise, as they can be wrong. Usually the values you had
		-- from previous instance if you're running more than one with the same people
		
		-- According to http://forums.worldofwarcraft.com/thread.html?topicId=26560499864
		-- this is the new way to check for roles
		if select(4, _G.GetBuildInfo()) >= 40000 then
			role = UnitGroupRolesAssigned(unit)
			isTank = false;
			isHealer = false;
			isDamage = false;
			if role == "TANK" then
				isTank = true
			elseif role == "HEALER" then
				isHealer = true
			elseif role == "DAMAGER" then
				isDamage = true
			end
		else
			isTank, isHealer, isDamage = UnitGroupRolesAssigned("player")
		end
		
	end
	
	-- role icons option check by playerlin
        if (conf.xperlOldroleicons) then
                if isTank then
                        icon:SetTexture("Interface\\GroupFrame\\UI-Group-MainTankIcon")
                        icon:Show()
                elseif isHealer then
                        icon:SetTexture("Interface\\Addons\\XPerl\\Images\\XPerl_RoleHealer_old")
                        icon:Show()
                elseif isDamage then
                        icon:SetTexture("Interface\\GroupFrame\\UI-Group-MainAssistIcon")
                        icon:Show()
                else
                        icon:Hide()
                end
        else
                if isTank then
                        icon:SetTexture("Interface\\Addons\\XPerl\\Images\\XPerl_RoleTank")
                        icon:Show()
                elseif isHealer then
                        icon:SetTexture("Interface\\Addons\\XPerl\\Images\\XPerl_RoleHealer")
                        icon:Show()
                elseif isDamage then
                        icon:SetTexture("Interface\\Addons\\XPerl\\Images\\XPerl_RoleDamage")
                        icon:Show()
                else
                        icon:Hide()
                end
        end

end

-------------------------
-- The Update Function --
-------------------------

local function XPerl_Player_CombatFlash(self, elapsed, argNew, argGreen)
	if (XPerl_CombatFlashSet(self, elapsed, argNew, argGreen)) then
		XPerl_CombatFlashSetFrames(self)
	end
end

-- XPerl_Player_UpdateManaType
local function XPerl_Player_UpdateManaType(self)
	XPerl_SetManaBarType(self)
end

-- XPerl_Player_UpdateLeader()
function XPerl_Player_UpdateLeader(self)
	local nf = self.nameFrame

	-- Loot Master
	local method, index
	if (UnitInParty("party1") or UnitInRaid("player")) then
		method, index = GetLootMethod()
	end
	if (method == "master" and index == 0) then
		nf.masterIcon:Show()
	else
		nf.masterIcon:Hide()
	end

	-- Leader
	if (IsPartyLeader()) then
		nf.leaderIcon:Show()
	else
		nf.leaderIcon:Hide()
	end

	UpdateAssignedRoles(self)

	if (pconf and pconf.partyNumber and GetNumRaidMembers() > 0) then
		for i = 1,GetNumRaidMembers() do
			local name, rank, subgroup = GetRaidRosterInfo(i)
			if (UnitIsUnit("raid"..i, "player")) then
				if (pconf.withName) then
					nf.group:SetFormattedText(XPERL_RAID_GROUPSHORT, subgroup)
					nf.group:Show()
					self.groupFrame:Hide()
					return
				else
					self.groupFrame.text:SetFormattedText(XPERL_RAID_GROUP, subgroup)
					self.groupFrame:Show()
					nf.group:Hide()
					return
				end
			end
		end
	end

	nf.group:Hide()
	self.groupFrame:Hide()
end

-- XPerl_Player_UpdateCombat
local function XPerl_Player_UpdateCombat(self)
	local nf = self.nameFrame
	if (UnitAffectingCombat(self.partyid)) then
		nf.text:SetTextColor(1,0,0)
		nf.combatIcon:SetTexCoord(0.5, 1.0, 0.0, 0.5)
		nf.combatIcon:Show()
	else
		if (self.partyid ~= "player") then
			local c = conf.colour.reaction.none
			nf.text:SetTextColor(c.r, c.g, c.b, conf.transparency.text)
		else
			XPerl_ColourFriendlyUnit(nf.text, self.partyid)
		end

		if (IsResting()) then
			nf.combatIcon:SetTexCoord(0, 0.5, 0.0, 0.5)
			nf.combatIcon:Show()
		else
			nf.combatIcon:Hide()
		end
	end
end

-- XPerl_Player_UpdateName()
local function XPerl_Player_UpdateName(self)
	playerName = UnitName(self.partyid)
	self.nameFrame.text:SetText(playerName)
	XPerl_Player_UpdateCombat(self)
end

-- XPerl_Player_UpdateClass
local function XPerl_Player_UpdateClass(self)
	playerClass = select(2, UnitClass(self.partyid))
	playerName = UnitName(self.partyid)
	local l, r, t, b = XPerl_ClassPos(playerClass)
	self.classFrame.tex:SetTexCoord(l, r, t, b)

	if (pconf.classIcon) then
		self.classFrame:Show()
	else
		self.classFrame:Hide()
	end
end

-- XPerl_Player_UpdateRep
local function XPerl_Player_UpdateRep(self)
	if (pconf and pconf.repBar) then
		local rb = self.statsFrame.repBar
		if (rb) then
			local name, reaction, min, max, value = GetWatchedFactionInfo()
			local color

			if (name) then
				color = FACTION_BAR_COLORS[reaction]
			else
				name = XPERL_LOC_NONEWATCHED
				max = 1
				min = 0
				value = 0
				color = FACTION_BAR_COLORS[4]
			end

			value = value - min
			max = max - min
			min = 0

			rb:SetMinMaxValues(min, max)
			rb:SetValue(value)

			rb:SetStatusBarColor(color.r, color.g, color.b, 1)
			rb.bg:SetVertexColor(color.r, color.g, color.b, 0.25)

			local perc = (value * 100) / max
			rb.percent:SetFormattedText(perc1F, perc)

			rb.tex:SetTexCoord(0, perc/100, 0, 1)

			if (max == 1) then
				rb.text:SetText(name)
			else
				rb.text:SetFormattedText("%d/%d", value, max)
			end
		end
	end
end

-- XPerl_Player_UpdateXP
local function XPerl_Player_UpdateXP(self)
	if (pconf.xpBar) then
		local xpBar = self.statsFrame.xpBar
		if (xpBar) then
			local restBar = self.statsFrame.xpRestBar
			local playerxp = UnitXP("player")
			local playerxpmax = UnitXPMax("player")
			local playerxprest = GetXPExhaustion() or 0
			xpBar:SetMinMaxValues(0, playerxpmax)
			restBar:SetMinMaxValues(0, playerxpmax)
			xpBar:SetValue(playerxp)

			local w = xpBar:GetRight() - xpBar:GetLeft()
			for mode = 1,3 do
				local suffix
				if (playerxprest > 0) then
					if (mode == 1) then
						suffix = format(" +%d", playerxprest)
					elseif (mode == 2) then
						if (playerxprest >= 1000000) then
							suffix = format(" +%.1fM", playerxprest / 1000000)
						else
							suffix = format(" +%.1fK", playerxprest / 1000)
						end
					else
						if (playerxprest >= 1000000) then
							suffix = format(" +%dM", playerxprest / 1000000)
						else
							suffix = format(" +%dK", playerxprest / 1000)
						end
					end

					color = {r = 0.3, g = 0.3, b = 1}
				else
					color = {r = 0.6, g = 0, b = 0.6}
				end

				if (pconf.xpDeficit) then
					XPerl_SetValuedText(xpBar.text, playerxp - playerxpmax, playerxpmax, suffix)
				else
					XPerl_SetValuedText(xpBar.text, playerxp, playerxpmax, suffix)
				end
				if (xpBar.text:GetStringWidth() <= w) then
					break
				end
			end

			xpBar:SetStatusBarColor(color.r, color.g, color.b, 1)
			xpBar.bg:SetVertexColor(color.r, color.g, color.b, 0.25)
			xpBar.tex:SetTexCoord(0, (playerxp * 100 / playerxpmax), 0, 1)

			restBar:SetValue(playerxp + playerxprest)
			restBar:SetStatusBarColor(color.r, color.g, color.b, 0.5)
			restBar.tex:SetTexCoord(0, (playerxp * 100 / playerxpmax), 0, 1)
			restBar.bg:SetVertexColor(color.r, color.g, color.b, 0.5)
			xpBar.percent:SetFormattedText(percD, (playerxp * 100) / playerxpmax)
		end
	end
end

-- XPerl_Player_UpdatePVP
local function XPerl_Player_UpdatePVP(self)
	-- PVP Status settings
	local nf = self.nameFrame
	if (UnitAffectingCombat(self.partyid)) then
		nf.text:SetTextColor(1,0,0)
	else
		XPerl_ColourFriendlyUnit(nf.text, "player")
	end

	local pvp = pconf.pvpIcon and (UnitIsPVP("player") and UnitFactionGroup("player")) or (UnitIsPVPFreeForAll("player") and "FFA")
	if (pvp) then
		nf.pvp.icon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..pvp)
		nf.pvp:Show()
	else
		nf.pvp:Hide()
	end
end

-- XPerl_Player_DruidBarUpdate
local function XPerl_Player_DruidBarUpdate(self)
	local manaPct
	local druidBar = self.statsFrame.druidBar

	local maxMana = UnitPowerMax("player", 0)
	local currMana = UnitPower("player", 0)

	druidBar:SetMinMaxValues(0, maxMana or 1)
	druidBar:SetValue(currMana or 0)
	druidBar.text:SetFormattedText("%d/%d", ceil(currMana or 0), maxMana or 1)

	druidBar.percent:SetFormattedText(percD, currMana * 100 / maxMana)

	local druidBarExtra
	if (UnitPowerType(self.partyid) > 0) then
		druidBar.text:Show()
		if (pconf.percent) then
			druidBar.percent:Show()
		end
		druidBar:Show()
		druidBar:SetHeight(10)
		druidBarExtra = 1
	else
		druidBar.percent:Hide()
		druidBar.text:Hide()
		druidBar:Hide()
		druidBar:SetHeight(1)
		druidBarExtra = 0
	end

	local h = 40 + ((druidBarExtra + (pconf.repBar or 0) + (pconf.xpBar or 0)) * 10)
	if (pconf.extendPortrait and not InCombatLockdown()) then
		self.portraitFrame:SetHeight(62 + druidBarExtra * 10 + (((pconf.xpBar or 0) + (pconf.repBar or 0)) * 10))
	end
	self.statsFrame:SetHeight(h)
	XPerl_StatsFrameSetup(self, {druidBar, self.statsFrame.xpBar, self.statsFrame.repBar})
	if (XPerl_Player_Buffs_Position) then
		XPerl_Player_Buffs_Position(self)
	end
end

-- XPerl_Player_UpdateMana
local function XPerl_Player_UpdateMana(self)
	local mb = self.statsFrame.manaBar
	local playermana = UnitMana(self.partyid)
	local playermanamax = UnitManaMax(self.partyid)
	mb:SetMinMaxValues(0, playermanamax)
	mb:SetValue(playermana)

	mb.text:SetFormattedText("%d/%d", playermana, playermanamax)
	if (UnitPowerType(self.partyid) >= 1) then
		mb.percent:SetText(playermana)
	else
		mb.percent:SetFormattedText(percD, (playermana * 100.0) / playermanamax)
	end
	
	mb.tex:SetTexCoord(0, max(0, (playermana / playermanamax)), 0, 1)
	
	if (not self.statsFrame.greyMana) then
		if (pconf.values) then
			mb.text:Show()
		end
		if (pconf.percent) then
			mb.percent:Show()
		end
	end

	if (playerClass == "DRUID") then
		XPerl_Player_DruidBarUpdate(self)
	end
end

local spiritOfRedemption = GetSpellInfo(27827)

-- XPerl_Player_UpdateHealth
function XPerl_Player_UpdateHealth(self)
	local partyid = self.partyid
	local sf = self.statsFrame
	local hb = sf.healthBar
	local playerhealth, playerhealthmax = XPerl_UnitHealth(partyid), UnitHealthMax(partyid)

	XPerl_SetHealthBar(self, playerhealth, playerhealthmax)

	local greyMsg
	if (UnitIsDead(partyid)) then
		--if (UnitIsFeignDeath("player")) then
		--	greyMsg = XPERL_LOC_FEIGNDEATH
		--else
			greyMsg = XPERL_LOC_DEAD
		--end

	elseif (UnitIsGhost(partyid)) then
		greyMsg = XPERL_LOC_GHOST

	elseif (UnitIsAFK("player") and conf.showAFK) then
		greyMsg = CHAT_MSG_AFK

	elseif (UnitBuff(partyid, spiritOfRedemption)) then
		greyMsg = XPERL_LOC_DEAD

	end

	if (greyMsg) then
		if (pconf.percent) then
			hb.percent:SetText(greyMsg)
			hb.percent:Show()
		else
			hb.text:SetText(greyMsg)
			hb.text:Show()
		end

		sf:SetGrey()
	else
		if (sf.greyMana) then
			if (not pconf.values) then
				hb.text:Hide()
			end

			sf.greyMana = nil
			XPerl_Player_UpdateManaType(self)
		end
	end

	XPerl_PlayerStatus_OnUpdate(self, playerhealth, playerhealthmax)
end

-- XPerl_Player_UpdateLevel
local function XPerl_Player_UpdateLevel(self)
	self.levelFrame.text:SetText(UnitLevel(self.partyid))
end

-- XPerl_PlayerStatus_OnUpdate
function XPerl_PlayerStatus_OnUpdate(self, val, max)
	if (pconf.fullScreen.enable) then
		local testLow = pconf.fullScreen.lowHP / 100
		local testHigh = pconf.fullScreen.highHP / 100

		if (val and max) then
			local test = val / max

			if ( test <= testLow and not XPerl_LowHealthFrame.frameFlash and not UnitIsDeadOrGhost("player")) then
				XPerl_FrameFlash(XPerl_LowHealthFrame)
			elseif ( (test >= testHigh and XPerl_LowHealthFrame.frameFlash) or UnitIsDeadOrGhost("player") ) then
				XPerl_FrameFlashStop(XPerl_LowHealthFrame, "out")
			end
			return
		else
			if (not UnitOnTaxi("player")) then
				if (isOutOfControl and not XPerl_OutOfControlFrame.frameFlash and not UnitOnTaxi("player")) then
					XPerl_FrameFlash(XPerl_OutOfControlFrame)
				elseif (not isOutOfControl and XPerl_OutOfControlFrame.frameFlash) then
					XPerl_FrameFlashStop(XPerl_OutOfControlFrame, "out")
				end
				return
			end
		end
	end

	if (XPerl_LowHealthFrame.frameFlash) then
		XPerl_FrameFlashStop(XPerl_LowHealthFrame)
	end
	if (XPerl_OutOfControlFrame.frameFlash) then
		XPerl_FrameFlashStop(XPerl_OutOfControlFrame)
	end
end

-- XPerl_Player_OnUpdate
function XPerl_Player_OnUpdate(self, elapsed)
	CombatFeedback_OnUpdate(self, elapsed)
	if (self.PlayerFlash) then
		XPerl_Player_CombatFlash(self, elapsed, false)
	end

	XPerl_Player_UpdateMana(self)
	
	-- Attempt to fix "not-updating bug", suggested by Taylla @ Curse
	-- comment 1st, 2nd and 4th line.
	-- if (self.updateAFK) then
	-- 	self.updateAFK = nil
	        XPerl_Player_UpdateHealth(self)
	-- end	

	if (IsResting() and UnitLevel("player") < MAX_PLAYER_LEVEL) then
		self.restingDelay = (self.restingDelay or 2) - elapsed
		if (self.restingDelay <= 0) then
			self.restingDelay = 2
			XPerl_Player_UpdateXP(self)
		end
	end

	if (self.updateAFK) then
		self.updateAFK = nil
		XPerl_Player_UpdateHealth(self)
	end
end

-- XPerl_Player_UpdateBuffs
local function XPerl_Player_UpdateBuffs(self)
	XPerl_CheckDebuffs(self, self.partyid)

	if (playerClass == "DRUID") then
		XPerl_Player_UpdateMana(self)
	end

	if (pconf.fullScreen.enable) then
		if (isOutOfControl and not UnitOnTaxi("player")) then
			XPerl_PlayerStatus_OnUpdate(self)
		end
	end
end

-- XPerl_Player_UpdateDisplay
function XPerl_Player_UpdateDisplay (self)
	XPerl_Player_UpdateXP(self)
	XPerl_Player_UpdateRep(self)
	XPerl_Player_UpdateManaType(self)
	XPerl_Player_UpdateLevel(self)
	XPerl_Player_UpdateName(self)
	XPerl_Player_UpdateClass(self)
	XPerl_Player_UpdatePVP(self)
	XPerl_Player_UpdateCombat(self)
	XPerl_Player_UpdateLeader(self)
	XPerl_Player_UpdateMana(self)
	XPerl_Player_UpdateHealth(self)
	XPerl_Player_UpdateBuffs(self)
	XPerl_Unit_UpdatePortrait(self)
end

-- EVENTS AND STUFF

-------------------
-- Event Handler --
-------------------
function XPerl_Player_OnEvent(self, event, arg1, ...)
	if (strsub(event, 1, 5) == "UNIT_") then
	 	if (arg1 == "player" or arg1 == "vehicle") then
			XPerl_Player_Events[event](self, ...)
		end
	else
		XPerl_Player_Events[event](self, event, arg1, ...)
	end
end

-- PLAYER_ENTERING_WORLD
function XPerl_Player_Events:PLAYER_ENTERING_WORLD()
	self.updateAFK = true
	if (UnitHasVehicleUI("player")) then
		self.partyid = "vehicle"
		self:SetAttribute("unit", "vehicle")
		if (XPerl_ArcaneBar_SetUnit) then
			XPerl_ArcaneBar_SetUnit(self.nameFrame, "vehicle")
		end
	else
		self.partyid = "player"
		self:SetAttribute("unit", "player")
		if (XPerl_ArcaneBar_SetUnit) then
			XPerl_ArcaneBar_SetUnit(self.nameFrame, "player")
		end
	end

	local events = {"UNIT_RAGE", "UNIT_MAXRAGE", "UNIT_MAXENERGY", "UNIT_MAXMANA", "UNIT_MAXRUNIC_POWER",
			"UNIT_HEALTH", "UNIT_MAXHEALTH", "UNIT_LEVEL", "UNIT_DISPLAYPOWER", "UNIT_NAME_UPDATE",
			"UNIT_SPELLMISS", "UNIT_FACTION", "UNIT_PORTRAIT_UPDATE", "UNIT_FLAGS", "PLAYER_FLAGS_CHANGED",
			"UNIT_SPELLCAST_SUCCEEDED", "UNIT_ENTERED_VEHICLE", "UNIT_EXITED_VEHICLE",
			"UNIT_SPELLCAST_SENT", "PLAYER_TALENT_UPDATE"}

	--XPerl_UnitEvents(self, XPerl_Player_Events, {"UNIT_SPELLMISS", "UNIT_FACTION", "UNIT_PORTRAIT_UPDATE",
	--						"UNIT_FLAGS", "PLAYER_FLAGS_CHANGED", "UNIT_SPELLCAST_SUCCEEDED"})
	--XPerl_RegisterBasics(self, XPerl_Player_Events)

	for i,e in pairs(events) do
		self:RegisterEvent(e)
	end

	XPerl_Player_UpdateDisplay(self)
end

-- UNIT_COMBAT
function XPerl_Player_Events:UNIT_COMBAT(...)
	if (arg1 == self.partyid) then
		if (pconf.hitIndicator and pconf.portrait) then
			if (arg2 ~= "HEAL" or UnitHealth(self.partyid) < UnitHealthMax(self.partyid)) then
				CombatFeedback_OnCombatEvent(self, ...)
			end
		end

		if (arg2 == "HEAL") then
			XPerl_Player_CombatFlash(self, elapsed, true, true)
		elseif (arg4 and arg4 > 0) then
			XPerl_Player_CombatFlash(self, elapsed, true)
		end
	end
end

-- UNIT_SPELLMISS
function XPerl_Player_Events:UNIT_SPELLMISS(...)
	if (pconf.hitIndicator and pconf.portrait) then
		if (arg1 == self.partyid) then
			CombatFeedback_OnSpellMissEvent(self, ...)
		end
	end
end

-- UNIT_PORTRAIT_UPDATE
function XPerl_Player_Events:UNIT_PORTRAIT_UPDATE()
	XPerl_Unit_UpdatePortrait(self)
end

-- VARIABLES_LOADED
function XPerl_Player_Events:VARIABLES_LOADED()
	self.doubleCheckAFK = 2		-- Check during 2nd UPDATE_FACTION, which are the last guarenteed events to come after logging in
	self:UnregisterEvent("VARIABLES_LOADED")

	local events = {"PLAYER_ENTERING_WORLD", "PARTY_MEMBERS_CHANGED", "PARTY_LEADER_CHANGED",
			"PARTY_LOOT_METHOD_CHANGED", "RAID_ROSTER_UPDATE", "PLAYER_UPDATE_RESTING", "PLAYER_REGEN_ENABLED",
			"PLAYER_REGEN_DISABLED", "PLAYER_ENTER_COMBAT", "PLAYER_LEAVE_COMBAT", "PLAYER_DEAD",
			"UPDATE_FACTION", "UNIT_AURA", "PLAYER_CONTROL_LOST", "PLAYER_CONTROL_GAINED",
			"UNIT_COMBAT"}

	for i,eventE in pairs(events) do
		self:RegisterEvent(eventE)
	end

	XPerl_Player_Events.VARIABLES_LOADED = nil
end

-- PARTY_LOOT_METHOD_CHANGED
function XPerl_Player_Events:PARTY_LOOT_METHOD_CHANGED()
	XPerl_Player_UpdateLeader(self)
end
XPerl_Player_Events.PARTY_MEMBERS_CHANGED	= XPerl_Player_Events.PARTY_LOOT_METHOD_CHANGED
XPerl_Player_Events.PARTY_LEADER_CHANGED	= XPerl_Player_Events.PARTY_LOOT_METHOD_CHANGED
XPerl_Player_Events.RAID_ROSTER_UPDATE		= XPerl_Player_Events.PARTY_LOOT_METHOD_CHANGED

-- UNIT_HEALTH, UNIT_MAXHEALTH
function XPerl_Player_Events:UNIT_HEALTH()
	XPerl_Player_UpdateHealth(self)
end
XPerl_Player_Events.UNIT_MAXHEALTH = XPerl_Player_Events.UNIT_HEALTH
XPerl_Player_Events.PLAYER_DEAD    = XPerl_Player_Events.UNIT_HEALTH

function XPerl_Player_Events:UNIT_SPELLCAST_SENT(spell, rank, targetName, castID)
	if (pconf.energyTicker and spell and UnitPowerMax(self.partyid, 0) > 0) then
		self.tickerPrevMana = UnitPower(self.partyid, 0)
		self:UnregisterEvent("UNIT_MANA")
	end
end

-- checkUsedMana
local function checkUsedMana(self)
	if (self.tickerPrevMana and UnitPower(self.partyid, 0) < self.tickerPrevMana) then
		local diffTime = GetTime() - self.tickerCastTime
		self.statsFrame.energyTicker:SetValue(diffTime)
		self.statsFrame.energyTicker:Show()
		return true
	end
end

-- UNIT_SPELLCAST_SUCCEEDED
function XPerl_Player_Events:UNIT_SPELLCAST_SUCCEEDED(spell, rank, castID)
	if (pconf.energyTicker and spell and UnitPowerMax(self.partyid, 0) > 0) then
		self.tickerCastTime = GetTime()
		if (not checkUsedMana(self)) then
			self.waitForManaReduction = true
			self:RegisterEvent("UNIT_MANA")
		end
	end
end

-- UNIT_MANA
function XPerl_Player_Events:UNIT_MANA()
	XPerl_Player_UpdateMana(self)

	if (self.waitForManaReduction) then
		checkUsedMana(self)

		self.waitForManaReduction = nil
		self.tickerPrevMana = nil
		self.tickerCastTime = nil
		self:UnregisterEvent("UNIT_MANA")
	end
end

-- UNIT_MAXMANA
function XPerl_Player_Events:UNIT_MAXMANA()
	XPerl_Player_UpdateMana(self)
end

XPerl_Player_Events.UNIT_RAGE			= XPerl_Player_Events.UNIT_MAXMANA
XPerl_Player_Events.UNIT_MAXRAGE		= XPerl_Player_Events.UNIT_RAGE
XPerl_Player_Events.UNIT_RUNIC_POWER	= XPerl_Player_Events.UNIT_MAXMANA
XPerl_Player_Events.UNIT_MAXRUNIC_POWER	= XPerl_Player_Events.UNIT_RUNIC_POWER
XPerl_Player_Events.UNIT_ENERGY			= XPerl_Player_Events.UNIT_MAXMANA
XPerl_Player_Events.UNIT_MAXENERGY		= XPerl_Player_Events.UNIT_ENERGY

-- UNIT_DISPLAYPOWER
function XPerl_Player_Events:UNIT_DISPLAYPOWER()
	XPerl_Player_UpdateManaType(self)
	XPerl_Player_UpdateMana(self)
end

-- UNIT_NAME_UPDATE
function XPerl_Player_Events:UNIT_NAME_UPDATE()
	XPerl_Player_UpdateName(self)
end

-- UNIT_LEVEL
function XPerl_Player_Events:UNIT_LEVEL()
	XPerl_Player_UpdateLevel(self)
	XPerl_Player_UpdateXP(self)
end
XPerl_Player_Events.PLAYER_LEVEL_UP = XPerl_Player_Events.UNIT_LEVEL

-- PLAYER_XP_UPDATE
function XPerl_Player_Events:PLAYER_XP_UPDATE()
	XPerl_Player_UpdateXP(self)
end

-- UPDATE_FACTION
function XPerl_Player_Events:UPDATE_FACTION()
	XPerl_Player_UpdateRep(self)

	if (self.doubleCheckAFK) then
		if (conf and pconf) then
			self.doubleCheckAFK = self.doubleCheckAFK - 1
			if (self.doubleCheckAFK <= 0) then
				XPerl_Player_UpdateHealth(self)
				self.doubleCheckAFK = nil
			end
		end
	end
end

-- UNIT_FACTION
function XPerl_Player_Events:UNIT_FACTION()
	XPerl_Player_UpdateHealth(self)
	XPerl_Player_UpdatePVP(self)
	XPerl_Player_UpdateCombat(self)
end
XPerl_Player_Events.UNIT_FLAGS = XPerl_Player_Events.UNIT_FACTION

function XPerl_Player_Events:PLAYER_FLAGS_CHANGED(unit)
	XPerl_Player_UpdateHealth(self)
end

-- PLAYER_TALENT_UPDATE
function XPerl_Player_Events:PLAYER_TALENT_UPDATE()
	XPerl_Player_UpdateMana(self)
	if (playerClass == "DRUID") then
		XPerl_Player_DruidBarUpdate(self)
	end
end

-- PLAYER_ENTER_COMBAT, PLAYER_LEAVE_COMBAT
function XPerl_Player_Events:PLAYER_ENTER_COMBAT()
	XPerl_Player_UpdateCombat(self)
end
XPerl_Player_Events.PLAYER_LEAVE_COMBAT = XPerl_Player_Events.PLAYER_ENTER_COMBAT

-- PLAYER_REGEN_ENABLED
function XPerl_Player_Events:PLAYER_REGEN_ENABLED()
	XPerl_Player_UpdateCombat(self)

	if (self:GetAttribute("unit") ~= self.partyid) then
		self:SetAttribute("unit", self.partyid)
		XPerl_Player_UpdateDisplay(self)
	end
end

-- PLAYER_REGEN_DISABLED
function XPerl_Player_Events:PLAYER_REGEN_DISABLED()
	XPerl_Player_UpdateCombat(self)
end

function XPerl_Player_Events:PLAYER_UPDATE_RESTING()
	XPerl_Player_UpdateCombat(self)
	XPerl_Player_UpdateXP(self)
end

function XPerl_Player_Events:UNIT_AURA()
	XPerl_Player_UpdateBuffs(self)
end

-- PLAYER_CONTROL_LOST
function XPerl_Player_Events:PLAYER_CONTROL_LOST()
	if (pconf.fullScreen.enable and not UnitOnTaxi("player")) then
		isOutOfControl = 1
	end
end

-- PLAYER_CONTROL_GAINED
function XPerl_Player_Events:PLAYER_CONTROL_GAINED()
	isOutOfControl = nil
	if (pconf.fullScreen.enable) then
		XPerl_PlayerStatus_OnUpdate(self)
	end
end

-- UNIT_ENTERED_VEHICLE
function XPerl_Player_Events:UNIT_ENTERED_VEHICLE(showVehicle)
	if (showVehicle) then
		self.partyid = "vehicle"
		if (XPerl_ArcaneBar_SetUnit) then
			XPerl_ArcaneBar_SetUnit(self.nameFrame, "vehicle")
		end
		if (not InCombatLockdown()) then
			self:SetAttribute("unit", "vehicle")
		end
		XPerl_Player_UpdateDisplay(self)
	end
end

-- UNIT_EXITED_VEHICLE
function XPerl_Player_Events:UNIT_EXITED_VEHICLE()
	if (self.partyid ~= "player") then
		self.partyid = "player"
		if (XPerl_ArcaneBar_SetUnit) then
			XPerl_ArcaneBar_SetUnit(self.nameFrame, "player")
		end
		if (not InCombatLockdown()) then
			self:SetAttribute("unit", "player")
		end
		XPerl_Player_UpdateDisplay(self)
	end
end

-- XPerl_Player_Energy_TickWatch
function XPerl_Player_Energy_OnUpdate(self, elapsed)
	local sparkPosition

	local val = self:GetValue() + elapsed
	if (val > 5) then
		self:Hide()
	else
		self:SetValue(val)
		sparkPosition = self:GetWidth() * (val / 5)
	end

	self.spark:SetPoint("CENTER", self, "LEFT", sparkPosition, 0)
end

-- XPerl_Player_SetWidth
function XPerl_Player_SetWidth(self)

	pconf.size.width = max(0, pconf.size.width or 0)
	if (pconf.percent) then
		self.nameFrame:SetWidth(160 + pconf.size.width)
		self.statsFrame:SetWidth(160 + pconf.size.width)
		self.statsFrame.healthBar.percent:Show()
		self.statsFrame.manaBar.percent:Show()

		if (self.statsFrame.xpBar) then
			self.statsFrame.xpBar.percent:Show()
		end
		if (self.statsFrame.repBar) then
			self.statsFrame.repBar.percent:Show()
		end
	else
		self.nameFrame:SetWidth(128 + pconf.size.width)
		self.statsFrame:SetWidth(128 + pconf.size.width)
		self.statsFrame.healthBar.percent:Hide()
		self.statsFrame.manaBar.percent:Hide()
		if (self.statsFrame.xpBar) then
			self.statsFrame.xpBar.percent:Hide()
		end
		if (self.statsFrame.repBar) then
			self.statsFrame.repBar.percent:Hide()
		end
	end

	local h = 40 + ((((self.statsFrame.druidBar and self.statsFrame.druidBar:IsShown()) or 0) + (pconf.repBar or 0) + (pconf.xpBar or 0)) * 10)
	self.statsFrame:SetHeight(h)

	self:SetWidth((pconf.portrait or 0) * 62 + (pconf.percent or 0) * 32 + 124 + pconf.size.width)
	self:SetScale(pconf.scale)

	XPerl_StatsFrameSetup(self, {self.statsFrame.druidBar, self.statsFrame.xpBar, self.statsFrame.repBar})
	if (XPerl_Player_Buffs_Position) then
		XPerl_Player_Buffs_Position(self)
	end

	XPerl_Player_UpdateHealth(self)
	XPerl_Player_UpdateMana(self)
	XPerl_Player_UpdateXP(self)

	XPerl_SavePosition(self, true)
	XPerl_RestorePosition(self)
end

-- CreateBar(self, name)
local function CreateBar(self, name)
	local f = CreateFrame("StatusBar", self.statsFrame:GetName()..name, self.statsFrame, "XPerlStatusBar")
	f:SetPoint("TOPLEFT", self.statsFrame.manaBar, "BOTTOMLEFT", 0, 0)
	f:SetHeight(10)
	self.statsFrame[name] = f
	f:SetWidth(112)
	return f
end

-- MakeEnergyTicker
local function MakeEnergyTicker(self)
	local f = CreateFrame("StatusBar", self.statsFrame:GetName().."energyTicker", self.statsFrame.manaBar)
	self.statsFrame.energyTicker = f
	f:SetPoint("TOPLEFT", self.statsFrame.manaBar, "BOTTOMLEFT", 0, 0)
	f:SetPoint("BOTTOMRIGHT", self.statsFrame.manaBar, "BOTTOMRIGHT", 0, -2)
	f:SetStatusBarTexture("Interface\\Addons\\XPerl\\Images\\XPerl_FrameBack")
	f:SetHeight(2)
	--f:SetFrameLevel(self.statsFrame.manaBar:GetFrameLevel() + 1)
	f:Hide()

	f.spark = f:CreateTexture(nil, "OVERLAY")
	f.spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	f.spark:SetBlendMode("ADD")
	f.spark:SetWidth(12)
	f.spark:SetHeight(12)
	f.spark:SetPoint("CENTER", 0, 0)

	f:SetStatusBarColor(0.4, 0.7, 1)
	f.spark:SetVertexColor(0.4, 0.7, 1)
	f:SetMinMaxValues(0, 5)

	f.EnergyTime = 0
	f:SetScript("OnUpdate", XPerl_Player_Energy_OnUpdate)

	MakeEnergyTicker = nil
end

-- MakeDruidBar()
local function MakeDruidBar(self)
	local f = CreateBar(self, "druidBar")
	local c = conf.colour.bar.mana
	f:SetStatusBarColor(c.r, c.g, c.b)
	f.bg:SetVertexColor(c.r, c.g, c.b, 0.25)
	MakeDruidBar = nil
end

-- MakeXPBars
local function MakeXPBars(self)
	local f = CreateBar(self, "xpBar")
	local f2 = CreateBar(self, "xpRestBar")

	f2:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
	f2:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0)

	MakeXPBars = nil
end

-- XPerl_Player_SetTotems
function XPerl_Player_SetTotems(self, ...)
	if (pconf.totems and pconf.totems.enable) then
		TotemFrame:SetParent(XPerl_Player)
		TotemFrame:ClearAllPoints()
		TotemFrame:SetPoint("TOP", XPerl_Player, "BOTTOM", pconf.totems.offsetX, pconf.totems.offsetY)
	else
		TotemFrame:SetParent(PlayerFrame)
		TotemFrame:ClearAllPoints()
		TotemFrame:SetPoint("TOPLEFT", PlayerFrame, "BOTTOMLEFT", 99, 38)
	end
end

-- XPerl_Player_Set_Bits()
function XPerl_Player_Set_Bits(self)
	if (XPerl_ArcaneBar_RegisterFrame and not self.nameFrame.castBar) then
		XPerl_ArcaneBar_RegisterFrame(self.nameFrame, UnitHasVehicleUI("player") and "vehicle" or "player")
	end

	if (pconf.portrait) then
		self.portraitFrame:Show()
		self.portraitFrame:SetWidth(60)
	else
		self.portraitFrame:Hide()
		self.portraitFrame:SetWidth(3)
	end

	if (pconf.level) then
		self.levelFrame:Show()
		self:RegisterEvent("PLAYER_LEVEL_UP")
	else
		self.levelFrame:Hide()
	end

	XPerl_Player_UpdateClass(self)

	if (pconf.repBar) then
		if (not self.statsFrame.repBar) then
			CreateBar(self, "repBar")
		end

		self.statsFrame.repBar:Show()
	else
		if (self.statsFrame.repBar) then
			self.statsFrame.repBar:Hide()
		end
	end

	if (pconf.energyTicker) then
		if (not self.statsFrame.energyTicker) then
			MakeEnergyTicker(self)
		end
	end

	if (playerClass == "DRUID" and not self.statsFrame.druidBar) then
		MakeDruidBar(self)
	else
		MakeDruidBar = nil
	end

	if (pconf.xpBar) then
		if (not self.statsFrame.xpBar) then
			MakeXPBars(self)
		end

		self.statsFrame.xpBar:Show()
		self.statsFrame.xpRestBar:Show()

		self:RegisterEvent("PLAYER_XP_UPDATE")
	else
		if (self.statsFrame.xpBar) then
			self.statsFrame.xpBar:Hide()
			self.statsFrame.xpRestBar:Hide()
		end

		self:UnregisterEvent("PLAYER_XP_UPDATE")
	end

	if (pconf.values) then
		self.statsFrame.healthBar.text:Show()
		self.statsFrame.manaBar.text:Show()
		if (self.statsFrame.xpBar) then
			self.statsFrame.xpBar.text:Show()
		end
		if (self.statsFrame.repBar) then
			self.statsFrame.repBar.text:Show()
		end
	else
		self.statsFrame.healthBar.text:Hide()
		self.statsFrame.manaBar.text:Hide()
		if (self.statsFrame.xpBar) then
			self.statsFrame.xpBar.text:Hide()
		end
		if (self.statsFrame.repBar) then
			self.statsFrame.repBar.text:Hide()
		end
	end

	XPerl_Player_SetWidth(self)

	local h1 = self.nameFrame:GetHeight() + self.statsFrame:GetHeight() - 2
	local h2 = self.portraitFrame:GetHeight()
	XPerl_SwitchAnchor(self, "TOPLEFT")
	self:SetHeight(max(h1, h2))

	self.highlight:ClearAllPoints()
	if (pconf.extendPortrait or (self.runes and pconf.showRunes and pconf.dockRunes)) then
		self.portraitFrame:SetHeight(62 + (((pconf.xpBar or 0) + (pconf.repBar or 0)) * 10))
		--self.highlight:SetPoint("TOPLEFT", self.levelFrame, "TOPLEFT", 0, 0)
		--self.highlight:SetPoint("BOTTOMRIGHT", self.statsFrame, "BOTTOMRIGHT", 0, 0)
	else
		self.portraitFrame:SetHeight(62)
		--self.highlight:SetPoint("BOTTOMLEFT", self.classFrame, "BOTTOMLEFT", -2, -2)
		--self.highlight:SetPoint("TOPRIGHT", self.nameFrame, "TOPRIGHT", 0, 0)
	end

	XPerl_Player_SetupDK(self)

	self.highlight:ClearAllPoints()
	if (not pconf.level and not pconf.classIcon and (not XPerlConfigHelper or XPerlConfigHelper.ShowTargetCounters == 0)) then
		self.highlight:SetPoint("TOPLEFT", self.portraitFrame, "TOPLEFT", 0, 0)
	else
		self.highlight:SetPoint("TOPLEFT", self.levelFrame, "TOPLEFT", 0, 0)
	end
	self.highlight:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)

	if (playerClass == "SHAMAN") then
		if (not pconf.totems) then
			pconf.totems = {
				enable = true,
				offsetX = 0,
				offsetY = 0
			}
		end

		if (not self.totemHooked) then
			self.totemHooked = true
			hooksecurefunc("TotemFrame_Update", XPerl_Player_SetTotems)
		end
	end
	
	self:SetAlpha(conf.transparency.frame)

	self.buffOptMix = nil
	XPerl_Player_UpdateDisplay(self)

	if (XPerl_Player_BuffSetup) then
		if (self.buffFrame) then
			self.buffOptMix = nil
			XPerl_Player_BuffSetup(XPerl_Player)
		end
	end

	if (XPerl_Voice) then
		XPerl_Voice:Register(self)
	end

	UpdateAssignedRoles(self)
end

-- XPerl_Player_InitWarlock
function XPerl_Player_InitWarlock(self)
	local myClass = select(2,UnitClass("player"))
	
	if myClass == "WARLOCK"  then
		self.shards= CreateFrame("Frame", "XPerl_Runes", self)
		
		self.shards:SetMovable(true)
		self.shards:RegisterForDrag("LeftButton")
		self.shards:SetScript("OnDragStart",
			function(self)
				if (not pconf.dockRunes) then
					self:StartMoving()
				end
			end)
		self.shards:SetScript("OnDragStop",
			function(self)
				if (not pconf.dockRunes) then
					self:StopMovingOrSizing()
					XPerl_SavePosition(self)
				end
			end)

		self.shards.unit = ShardBarFrame:GetParent().unit
			
		ShardBarFrame:SetParent(self.shards)
		ShardBarFrame:ClearAllPoints()
		ShardBarFrame:SetPoint("TOPLEFT", 3, 0)
		ShardBarFrame:SetPoint("BOTTOMRIGHT", 15, 5)
		ShardBarFrame:Show()
				
		self.shards:Show()
		
		self.shards:SetPoint("TOPLEFT", self.statsFrame, "BOTTOMLEFT", 5, 2)
		self.shards:SetPoint("BOTTOMRIGHT", self.statsFrame, "BOTTOMRIGHT", 0, -20)

	end
	
	XPerl_Player_InitWarlock = nil
end

-- XPerl_Player_InitDK
function XPerl_Player_InitDK(self)
	if (select(2, UnitClass("player")) == "DEATHKNIGHT") then
		if (not RuneFrame or RuneFrame:GetParent() ~= UIParent or not RuneFrame:IsShown()) then
			-- Only hijack runes if not already done so by another mod
			return
		end

		local p, f, r, x, y = RuneFrame:GetPoint(1)
		if (f ~= PlayerFrame or p ~= "TOP" or r ~= "BOTTOM") then
			-- More safety checking before we fudge it
			return
		end

		self.runes = CreateFrame("Frame", "XPerl_Runes", self)
		self.runes:SetPoint("TOPLEFT", self.portraitFrame, "BOTTOMLEFT", 0, 2)
		self.runes:SetPoint("BOTTOMRIGHT", self.statsFrame, "BOTTOMRIGHT", 0, -30)

		self.runes:SetMovable(true)
		self.runes:RegisterForDrag("LeftButton")
		self.runes:SetScript("OnDragStart",
			function(self)
				if (not pconf.dockRunes) then
					self:StartMoving()
				end
			end)
		self.runes:SetScript("OnDragStop",
			function(self)
				if (not pconf.dockRunes) then
					self:StopMovingOrSizing()
					XPerl_SavePosition(self)
				end
			end)

		local bgDef = {bgFile = "Interface\\Addons\\XPerl\\Images\\XPerl_FrameBack",
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				tile = true, tileSize = 32, edgeSize = 12,
				insets = { left = 3, right = 3, top = 3, bottom = 3 }
			}
		self.runes:SetBackdrop(bgDef)
		self.runes:SetBackdropColor(0, 0, 0, 0.8)
		self.runes:SetBackdropBorderColor(1, 1, 1, 1)
		self.runes.list = {}

		RuneFrame:SetParent(self.runes)
		RuneFrame:ClearAllPoints()
		RuneFrame:SetPoint("TOPLEFT", 5, -5)
		RuneFrame:SetPoint("BOTTOMRIGHT", -5, 5)

		-- If client is Cata 4.0 or later, use new code.
		if select(4, _G.GetBuildInfo()) >= 40000 then
				RuneButtonIndividual1:Hide()
				RuneButtonIndividual2:Hide()
				RuneButtonIndividual3:Hide()
				RuneButtonIndividual4:Hide()
				RuneButtonIndividual5:Hide()
				RuneButtonIndividual6:Hide()
		
		else
		-- Else use 3.x code instead, make sure it didn't display nothing on 3.x.
			for i = 1,6 do
				local rune = RuneFrame.runes[i]
				if (rune) then
					rune:Hide()
				end
			end
			RuneFrame.runes = {}
		end

		local prev
		local idSwitch = {1, 2, 5, 6, 3, 4}		-- Non sequential rune IDs.. gg
		for i = 1,6 do
			local rune = CreateFrame("Button", "XPerl_RuneButtonIndividual"..i, RuneFrame, "XPerl_RuneButtonIndividualTemplate")
			self.runes.list[i] = rune
			rune:EnableMouse(false)

			-- god only knows why blizzard did this...
			rune:SetID(idSwitch[i])

			if (i > 1) then
				rune:SetPoint("LEFT", prev, "RIGHT", 4 + ((i % 2) * 16), 0)
			else
				rune:SetPoint("LEFT", 10, 0)
			end
			prev = rune
		end

	end
	
	XPerl_Player_InitDK = nil
end

-- XPerl_Player_SetupDK
function XPerl_Player_SetupDK(self)
	if (self.runes) then
		if (not pconf or pconf.showRunes) then
			self.runes:Show()

			self.runes:ClearAllPoints()

			if (not pconf or pconf.dockRunes) then
				self.runes:SetPoint("TOPLEFT", self.portraitFrame, "BOTTOMLEFT", 0, 2)
				self.runes:SetPoint("BOTTOMRIGHT", self.statsFrame, "BOTTOMRIGHT", 0, -30)
			else
				self.runes:SetPoint("TOPLEFT", self.portraitFrame, "BOTTOMLEFT", 0, 2)
				self.runes:SetWidth(214)
				self.runes:SetHeight(32)
				XPerl_RestorePosition(self.runes)
			end

			for i = 1,6 do
				local rune = _G["XPerl_RuneButtonIndividual"..i]
				self.runes.list[i] = rune
				rune:ClearAllPoints()
				rune:SetWidth(22)
				rune:SetHeight(22)

				if (self.runes:GetWidth() >= 200) then	-- pconf.portrait) then
					if (i > 1) then
						rune:SetPoint("LEFT", prev, "RIGHT", 4 + ((i % 2) * 16), 0)
					else
						rune:SetPoint("LEFT", 10, 0)
					end
				else
					if (i > 1) then
						rune:SetPoint("LEFT", prev, "RIGHT", 1 + ((i % 2) * 5), 0)
					else
						rune:SetPoint("LEFT", 1, 0)
					end
				end
				prev = rune
			end

		else
			self.runes:Hide()
		end
	end
end
