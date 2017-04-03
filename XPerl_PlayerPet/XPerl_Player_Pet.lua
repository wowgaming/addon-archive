-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

local XPerl_Player_Pet_Events = {}
local conf, pconf
XPerl_RequestConfig(function(new)
			conf = new
			pconf = new.pet
			if (XPerl_Player_Pet) then
				XPerl_Player_Pet.conf = pconf
			end
		end, "$Revision: 394 $")

local XPerl_Player_Pet_HighlightCallback

-- Set_FOM_FeedButton
-- Set Feed'O'Matic button to same location as happy icon
-- We do a convoluted method here rather than attaching it to the happiness frame,
-- because it's an action button which would lock the Happiness frame during combat
local function Set_FOM_FeedButton()
	FOM_FeedButton:SetParent(UIParent)
	FOM_FeedButton:SetScale(XPerl_Player_Pet.happyFrame:GetScale())

	FOM_FeedButton:ClearAllPoints()
	if (pconf.name or pconf.portrait) then
		FOM_FeedButton:SetPoint("BOTTOMRIGHT", XPerl_Player_Pet.portraitFrame, "BOTTOMLEFT", 2, 0)
	else
		FOM_FeedButton:SetPoint("BOTTOMRIGHT", XPerl_Player_Pet.statsFrame, "BOTTOMLEFT", 2, 0)
	end
	FOM_FeedButton:SetHeight(XPerl_Player_Pet.happyFrame:GetHeight())
	FOM_FeedButton:SetWidth(XPerl_Player_Pet.happyFrame:GetWidth())

	FOM_FeedButton:Show()
end

-- XPerl_Player_Pet_OnLoad
function XPerl_Player_Pet_OnLoad(self)
	XPerl_SetChildMembers(self)
	self.partyid = "pet"
	self.tutorialPage = 6

	XPerl_BlizzFrameDisable(PetFrame)

	local BuffOnUpdate, DebuffOnUpdate, BuffUpdateTooltip, DebuffUpdateTooltip
	BuffUpdateTooltip = XPerl_Unit_SetBuffTooltip
	DebuffUpdateTooltip = XPerl_Unit_SetDeBuffTooltip

	self.buffSetup = {
		buffScripts = {
			OnEnter = XPerl_Unit_SetBuffTooltip,
			OnUpdate = BuffOnUpdate,
			OnLeave = XPerl_PlayerTipHide,
		},
		debuffScripts = {
			OnEnter = XPerl_Unit_SetDeBuffTooltip,
			OnUpdate = DebuffOnUpdate,
			OnLeave = XPerl_PlayerTipHide,
		},
		updateTooltipBuff = BuffUpdateTooltip,
		updateTooltipDebuff = DebuffUpdateTooltip,
		debuffParent = true,
		debuffSizeMod = 0.3,
		debuffAnchor1 = function(self, b)
					local buff1 = XPerl_GetBuffButton(self, 1, 0, 1)
					if (pconf.buffs.above) then
						b:SetPoint("BOTTOMLEFT", buff1, "TOPLEFT", 0, 0)
					else
						b:SetPoint("TOPLEFT", buff1, "BOTTOMLEFT", 0, 0)
					end
					self.buffSetup.debuffAnchor1 = nil
				end,
		buffAnchor1 = function(self, b)
					if (pconf.buffs.above) then
						b:SetPoint("BOTTOMLEFT", 0, 0)
					else
						b:SetPoint("TOPLEFT", 0, 0)
					end
					self.buffSetup.buffAnchor1 = nil
				end,
	}

	CombatFeedback_Initialize(self, self.hitIndicator.text, 30)

	XPerl_SecureUnitButton_OnLoad(self, "pet", nil, PetFrameDropDown, PetFrame.menu)
	XPerl_SecureUnitButton_OnLoad(self.nameFrame, "pet", nil, PetFrameDropDown, PetFrame.menu)

	--RegisterUnitWatch(self)
        --Added UNIT_POWER/UNIT_MAXPOWER shit on events list by PlayerLin
	local events = {"UNIT_RAGE", "UNIT_MAXRAGE", "UNIT_MAXENERGY", "UNIT_MAXMANA", "UNIT_MAXRUNIC_POWER",
					"UNIT_HEALTH", "UNIT_MAXHEALTH", "UNIT_LEVEL", "UNIT_POWER",
					"UNIT_MAXPOWER", "UNIT_DISPLAYPOWER", "UNIT_NAME_UPDATE",
					"UNIT_MANA", "UNIT_ENERGY", "UNIT_RUNIC_POWER", "UNIT_FACTION", "UNIT_PORTRAIT_UPDATE",
					"UNIT_FLAGS", "UNIT_DYNAMIC_FLAGS", "UNIT_AURA",
					"UNIT_PET", "PET_ATTACK_START", "UNIT_COMBAT", "UNIT_SPELLMISS", "VARIABLES_LOADED",
					"PLAYER_REGEN_ENABLED", "PLAYER_ENTERING_WORLD", "UNIT_ENTERED_VEHICLE", "UNIT_EXITED_VEHICLE",
					"UNIT_THREAT_LIST_UPDATE", "PLAYER_TARGET_CHANGED", "UNIT_TARGET"}
	for i,event in pairs(events) do
		self:RegisterEvent(event)
	end

	--XPerl_UnitEvents(self, XPerl_Player_Pet_Events, {"UNIT_FACTION", "UNIT_PORTRAIT_UPDATE", "UNIT_FLAGS", "UNIT_DYNAMIC_FLAGS",
	--					"UNIT_AURA"})
	--XPerl_RegisterBasics(self, XPerl_Player_Pet_Events)

	self.time = 0

	-- Set here to reduce amount of function calls made
	self:SetScript("OnEvent", XPerl_Player_Pet_OnEvent)
	self:SetScript("OnUpdate", XPerl_Player_Pet_OnUpdate)
	if (FOM_FeedButton) then
		self:SetScript("OnShow",
			function(self)
				XPerl_Unit_UpdatePortrait(self)
				XPerl_ProtectedCall(Set_FOM_FeedButton)
			end)
	else
		self:SetScript("OnShow", XPerl_Unit_UpdatePortrait)
	end

	if (XPerl_ArcaneBar_RegisterFrame) then
		XPerl_ArcaneBar_RegisterFrame(self.nameFrame, UnitHasVehicleUI("player") and "player" or "pet")
	end

	XPerl_RegisterHighlight(self.highlight, 2)
	XPerl_RegisterPerlFrames(self, {self.nameFrame, self.statsFrame, self.portraitFrame, self.levelFrame, self.happyFrame})
	self.FlashFrames = {self.nameFrame, self.levelFrame, self.statsFrame, self.portraitFrame}

	XPerl_RegisterOptionChanger(XPerl_Player_Pet_Set_Bits, self)

	XPerl_Highlight:Register(XPerl_Player_Pet_HighlightCallback, self)

	if (XPerlDB) then
		self.conf = XPerlDB.pet
	end

	self.GetBuffSpacing = function(self)
		local w = self.statsFrame:GetWidth()
		if (self.portraitFrame and self.portraitFrame:IsShown()) then
			w = w - 2 + self.portraitFrame:GetWidth()
		end
		if (not self.buffSpacing) then
			self.buffSpacing = XPerl_GetReusableTable()
		end
		self.buffSpacing.rowWidth = w
		self.buffSpacing.smallRowHeight = 0
		self.buffSpacing.smallRowWidth = w
	end
	XPerl_Player_Pet_OnLoad = nil
end

-- XPerl_Player_Pet_HighlightCallback
function XPerl_Player_Pet_HighlightCallback(self, updateGUID)
	if (updateGUID == UnitGUID("pet")) then
		XPerl_Highlight:SetHighlight(self, updateGUID)
	end
end

-- XPerl_Player_Pet_UpdateName
local function XPerl_Player_Pet_UpdateName(self)
	local petname = UnitName(self.partyid)

	if (petname == UNKNOWN) then
		self.nameFrame.text:SetText("")
	else
		self.nameFrame.text:SetText(petname)
	end

	if (self.partyid == "pet") then
		local c = conf.colour.reaction.none
		self.nameFrame.text:SetTextColor(c.r, c.g, c.b, conf.transparency.text)
	elseif (not UnitIsFriend("player", "pet")) then		-- Pet or you charmed
		local c = conf.colour.reaction.enemy
		self.nameFrame.text:SetTextColor(c.r, c.g, c.b, conf.transparency.text)
	else
		XPerl_ColourFriendlyUnit(self.nameFrame.text, self.partyid)
	end
end

-- XPerl_Player_Pet_UpdateLevel
local function XPerl_Player_Pet_UpdateLevel(self)
	XPerl_Unit_UpdateLevel(self)
	local petxp, petxpmax = GetPetExperience()
	self.statsFrame.xpBar:SetStatusBarColor(0.3, 0.3, 1, 1)
	self.statsFrame.xpBar.bg:SetVertexColor(0.3, 0.3, 1, 0.25)
	self.statsFrame.xpBar:SetMinMaxValues(0, petxpmax)
	self.statsFrame.xpBar:SetValue(petxp)
end

-- XPerl_Player_Pet_UpdateHealth
function XPerl_Player_Pet_UpdateHealth(self)
	local pethealth = XPerl_UnitHealth(self.partyid)
	local pethealthmax = UnitHealthMax(self.partyid)

	XPerl_SetHealthBar(self, pethealth, pethealthmax)

	if (UnitIsDead(self.partyid)) then
		self.statsFrame.healthBar.text:SetText(XPERL_LOC_DEAD)
		self.statsFrame.manaBar.text:Hide()
	end
end

-- XPerl_Player_Pet_UpdateMana()
local function XPerl_Player_Pet_UpdateMana(self)
	local petmana = UnitMana(self.partyid)
	local petmanamax = UnitManaMax(self.partyid)

	self.statsFrame.manaBar:SetMinMaxValues(0, petmanamax)
	self.statsFrame.manaBar:SetValue(petmana)

	self.statsFrame.manaBar.text:SetFormattedText("%d/%d", petmana, petmanamax)

	if (pconf.values) then
		self.statsFrame.manaBar.text:Show()
	end
end

-- XPerl_Player_Pet_CombatFlash
local function XPerl_Player_Pet_CombatFlash(self, elapsed, argNew, argGreen)
	if (XPerl_CombatFlashSet(self, elapsed, argNew, argGreen)) then
		XPerl_CombatFlashSetFrames(self)
	end
end

-- XPerl_Player_Pet_OnUpdate
function XPerl_Player_Pet_OnUpdate(self, elapsed)
	CombatFeedback_OnUpdate(self, elapsed)
	if (self.PlayerFlash) then
		XPerl_Player_Pet_CombatFlash(self, arg1, false)
	end
end

--------------------
-- Buff Functions --
--------------------
local function XPerl_Player_Pet_Buff_UpdateAll(self)
	if (UnitExists(self.partyid)) then
		XPerl_Unit_UpdateBuffs(self)
		XPerl_Unit_BuffPositions(self, self.buffFrame.buff, self.buffFrame.debuff, self.conf.buffs.size, self.conf.debuffs.size)
		XPerl_CheckDebuffs(self, self.partyid)
	end
end

---------------
-- Happiness --
---------------
local lastHappy
function XPerl_Player_Pet_SetHappiness(self)
	local happiness, damagePercentage = GetPetHappiness()
	if (not happiness) then
		happiness = 3
	end

	local icon = self.happyFrame.icon
	icon.tex:SetTexCoord(0.5625 - (0.1875 * happiness), 0.75 - (0.1875 * happiness), 0, 0.359375)

	if (pconf.happiness.enable and (not pconf.happiness.onlyWhenSad or happiness < 3)) then
		self.happyFrame:Show()

		icon.tooltip = _G["PET_HAPPINESS"..happiness]
		icon.tooltipDamage = format(PET_DAMAGE_PERCENTAGE, damagePercentage)

		if (pconf.happiness.flashWhenSad and happiness < 3) then
			XPerl_FrameFlash(self.happyFrame)
		else
			XPerl_FrameFlashStop(self.happyFrame)
		end
	else
		XPerl_FrameFlashStop(self.happyFrame)
		self.happyFrame:Hide()
	end
end

-- XPerl_Player_Pet_Update_Control
local function XPerl_Player_Pet_Update_Control(self)
	if (UnitIsCharmed(self.partyid) and not UnitInVehicle("player")) then
		self.nameFrame.warningIcon:Show()
	else
		self.nameFrame.warningIcon:Hide()
	end
end

-- XPerl_Player_Pet_UpdateCombat
local function XPerl_Player_Pet_UpdateCombat(self)
	if (UnitExists(self.partyid)) then
		if (UnitAffectingCombat(self.partyid)) then
			self.nameFrame.combatIcon:Show()
		else
			self.nameFrame.combatIcon:Hide()
		end
		XPerl_Player_Pet_Update_Control(self)
	end
end

-- XPerl_Player_Pet_UpdateDisplay
function XPerl_Player_Pet_UpdateDisplay(self)
	XPerl_Unit_UpdatePortrait(self)
	XPerl_Player_Pet_UpdateName(self)
	XPerl_Player_Pet_UpdateHealth(self)
	XPerl_SetManaBarType(self)
	XPerl_Player_Pet_UpdateMana(self)
	XPerl_Player_Pet_UpdateLevel(self)
	if (XPerl_Player_Pet_SetHappiness) then
		XPerl_Player_Pet_SetHappiness(self)
	end
	XPerl_Player_Pet_Buff_UpdateAll(self)
	XPerl_Player_Pet_UpdateCombat(self)
end

-------------------
-- Event Handler --
-------------------
function XPerl_Player_Pet_OnEvent(self, event, unit, ...)
	local func = XPerl_Player_Pet_Events[event]
	if (func) then
		if (strfind(event, "^UNIT_")) then
			if (unit == self.partyid and not strfind(event, "VEHICLE") and event ~= "UNIT_THREAT_LIST_UPDATE") then
				func(self, ...)
			else
				func(self, unit, ...)
			end
		else
			func(self, unit, ...)
		end
	else
XPerl_ShowMessage("EXTRA EVENT")
	end
end

-- VARIABLES_LOADED
function XPerl_Player_Pet_Events:VARIABLES_LOADED()
	if (select(2, UnitClass("player")) == "HUNTER") then
		-- added UNIT_POWER event check for 4.0 by PlayerLin, thanks Brounks.
		XPerl_UnitEvents(self, XPerl_Player_Pet_Events, {"UNIT_FOCUS", "UNIT_MAXFOCUS", "UNIT_PET_EXPERIENCE", "UNIT_HAPPINESS", "UNIT_POWER"})
	else
		-- the UNIT_POWER shit must 'nil'ed when Player Pet isn't exist.
		XPerl_Player_Pet_Events.UNIT_HAPPINESS = nil
		XPerl_Player_Pet_SetHappiness = nil
	end

	XPerl_Player_Pet_Events.VARIABLES_LOADED = nil
end

-- UNIT_AURA
function XPerl_Player_Pet_Events:UNIT_AURA()
	XPerl_Player_Pet_Buff_UpdateAll(self)
end

-- UNIT_PET
function XPerl_Player_Pet_Events:UNIT_PET()
	if (conf) then		-- DK can issue very early UNIT_PET, long before PEW. We refresh on entering world regardless
		XPerl_Player_Pet_UpdateDisplay(XPerl_Player_Pet)
	end
end

XPerl_Player_Pet_Events.PET_STABLE_SHOW = XPerl_Player_Pet_Events.UNIT_PET

-- UNIT_NAME_UPDATE
function XPerl_Player_Pet_Events:UNIT_NAME_UPDATE()
	XPerl_Player_Pet_UpdateName(self)
end

-- UNIT_PORTRAIT_UPDATE
function XPerl_Player_Pet_Events:UNIT_PORTRAIT_UPDATE()
	XPerl_Unit_UpdatePortrait(self)
end

-- UNIT_HEALTH, UNIT_MAXHEALTH
function XPerl_Player_Pet_Events:UNIT_HEALTH()
	XPerl_Player_Pet_UpdateHealth(self)
end

XPerl_Player_Pet_Events.UNIT_MAXHEALTH = XPerl_Player_Pet_Events.UNIT_HEALTH

-- Ticket 727 Player Pet frame's happiness not update fix.
-- Ticket 735 Player Pet frame's power bar fix.
-- Thanks Brounks pointed out again... -.- By PlayerLin

-- UNIT_POWER/UNIT_MAXPOWER shit for 4.0 and later.
-- All power bars and Pet Happiness will firing UNIT_POWER/UNIT_MAXPOWER shit.
-- And SetHappiness shit too for Pet Happiness updating!
function XPerl_Player_Pet_Events:UNIT_POWER()
	XPerl_Player_Pet_UpdateMana(self)
	if (XPerl_Player_Pet_SetHappiness) then
		XPerl_Player_Pet_SetHappiness(self)
	end
	XPerl_Player_Pet_UpdateCombat(self)
end

XPerl_Player_Pet_Events.UNIT_MAXPOWER = XPerl_Player_Pet_Events.UNIT_POWER

-- UNIT_RAGE / others for 3.3.5 and older.

function XPerl_Player_Pet_Events:UNIT_RAGE()
	XPerl_Player_Pet_UpdateMana(self)
end

XPerl_Player_Pet_Events.UNIT_MAXRAGE		= XPerl_Player_Pet_Events.UNIT_RAGE
XPerl_Player_Pet_Events.UNIT_ENERGY		= XPerl_Player_Pet_Events.UNIT_RAGE
XPerl_Player_Pet_Events.UNIT_MAXENERGY		= XPerl_Player_Pet_Events.UNIT_RAGE
XPerl_Player_Pet_Events.UNIT_MANA		= XPerl_Player_Pet_Events.UNIT_RAGE
XPerl_Player_Pet_Events.UNIT_MAXMANA		= XPerl_Player_Pet_Events.UNIT_RAGE
XPerl_Player_Pet_Events.UNIT_FOCUS		= XPerl_Player_Pet_Events.UNIT_RAGE
XPerl_Player_Pet_Events.UNIT_MAXFOCUS		= XPerl_Player_Pet_Events.UNIT_RAGE
XPerl_Player_Pet_Events.UNIT_MAXRUNIC_POWER	= XPerl_Player_Pet_Events.UNIT_RAGE
XPerl_Player_Pet_Events.UNIT_RUNIC_POWER	= XPerl_Player_Pet_Events.UNIT_RAGE

-- UNIT_HAPPINESS (Same as for 3.3.5 and older)
-- Happiness events come while you have a pet up, each 2 secs
function XPerl_Player_Pet_Events:UNIT_HAPPINESS()
	--XPerl_Player_Pet_UpdateDisplay();	-- Update all, fixes bug with stables in 1.11
	XPerl_Player_Pet_SetHappiness(self)
	XPerl_Player_Pet_UpdateCombat(self)
end

-- UNIT_LEVEL
function XPerl_Player_Pet_Events:UNIT_LEVEL()
	XPerl_Player_Pet_UpdateLevel(self)
end

XPerl_Player_Pet_Events.UNIT_PET_EXPERIENCE = XPerl_Player_Pet_Events.UNIT_LEVEL

-- UNIT_DISPLAYPOWER
function XPerl_Player_Pet_Events:UNIT_DISPLAYPOWER()
	XPerl_SetManaBarType(self)
end

-- PET_ATTACK_START
function XPerl_Player_Pet_Events:PET_ATTACK_START()
	XPerl_Player_Pet_UpdateCombat(XPerl_Player_Pet)
end

-- UNIT_COMBAT
function XPerl_Player_Pet_Events:UNIT_COMBAT(...)
	if (arg1 == self.partyid) then
		if (pconf.hitIndicator and pconf.portrait) then
			CombatFeedback_OnCombatEvent(self, ...)
		end

		if (arg2 == "HEAL") then
			XPerl_Player_Pet_CombatFlash(XPerl_Player_Pet, 0, true, true)
		elseif (arg4 and arg4 > 0) then
			XPerl_Player_Pet_CombatFlash(XPerl_Player_Pet, 0, true)
		end
	end
end

-- UNIT_SPELLMISS
function XPerl_Player_Pet_Events:UNIT_SPELLMISS()
	if (arg1 == self.partyid) then
		if (pconf.hitIndicator and pconf.portrait) then
			CombatFeedback_OnSpellMissEvent(self, arg2)
		end
	end
end

-- UNIT_DYNAMIC_FLAGS
function XPerl_Player_Pet_Events:UNIT_FACTION()
	XPerl_Player_Pet_UpdateName(self)
	XPerl_Player_Pet_UpdateCombat(self)
end

XPerl_Player_Pet_Events.UNIT_FLAGS = XPerl_Player_Pet_Events.UNIT_FACTION
XPerl_Player_Pet_Events.UNIT_DYNAMIC_FLAGS = XPerl_Player_Pet_Events.UNIT_FACTION

-- PLAYER_REGEN_ENABLED
function XPerl_Player_Pet_Events:PLAYER_REGEN_ENABLED()
	if (self:GetAttribute("unit") ~= self.partyid) then
		self:SetAttribute("unit", self.partyid)
	end
end

-- PLAYER_ENTERING_WORLD
function XPerl_Player_Pet_Events:PLAYER_ENTERING_WORLD()
	if (UnitHasVehicleUI("player")) then
		self.partyid = "player"
		self:SetAttribute("unit", "player")
	else
		self.partyid = "pet"
		self:SetAttribute("unit", "pet")
	end
end

-- UNIT_ENTERED_VEHICLE
function XPerl_Player_Pet_Events:UNIT_ENTERED_VEHICLE(unit, showVehicle)
	if (unit == "player" and showVehicle) then
		self.partyid = "player"
		if (XPerl_ArcaneBar_SetUnit) then
			XPerl_ArcaneBar_SetUnit(self.nameFrame, "player")
		end
		if (not InCombatLockdown()) then
			self:SetAttribute("unit", "player")
		end
		XPerl_Player_Pet_UpdateDisplay(self)
	else
		XPerl_Player_Pet_Events.UNIT_EXITED_VEHICLE(self, unit)
	end
end

-- UNIT_EXITED_VEHICLE
function XPerl_Player_Pet_Events:UNIT_EXITED_VEHICLE(unit)
	if (unit == "player") then
		if (self.partyid ~= "pet") then
			self.partyid = "pet"
			if (XPerl_ArcaneBar_SetUnit) then
				XPerl_ArcaneBar_SetUnit(self.nameFrame, "pet")
			end
			if (not InCombatLockdown()) then
				self:SetAttribute("unit", "pet")
			end
			XPerl_Player_Pet_UpdateDisplay(self)
		end
	end
end

function XPerl_Player_Pet_Events:UNIT_THREAT_LIST_UPDATE(unit)
	if (unit == "target") then
		XPerl_Unit_ThreatStatus(self)
	end
end

function XPerl_Player_Pet_Events:PLAYER_TARGET_CHANGED()
	XPerl_Unit_ThreatStatus(self, nil, true)
end
XPerl_Player_Pet_Events.UNIT_TARGET = XPerl_Player_Pet_Events.PLAYER_TARGET_CHANGED

-- PLAYER_REGEN_DISABLED
local virtual
function XPerl_Player_Pet_Events:PLAYER_REGEN_DISABLED()
	if (virtual) then
		virtual = nil
		RegisterUnitWatch(XPerl_Player_Pet)
		if (UnitExists("pet")) then
			XPerl_Player_Pet:Show()
			XPerl_Player_Pet_UpdateDisplay(XPerl_Player_Pet)
		else
			XPerl_Player_Pet:Hide()
		end

		if (XPerl_PetTarget) then
			RegisterUnitWatch(XPerl_PetTarget)
			if (UnitExists("pettarget")) then
				XPerl_PetTarget:Show()
				XPerl_TargetTarget_UpdateDisplay(XPerl_PetTarget)
			else
				XPerl_PetTarget:Hide()
			end
		end
	end
end

-- XPerl_Player_Pet_SetWidth
function XPerl_Player_Pet_SetWidth(self)
	pconf.size.width = max(0, pconf.size.width or 0)
	self.statsFrame:SetWidth(80 + pconf.size.width)
	self.nameFrame:SetWidth(80 + pconf.size.width)
	self:SetScale(pconf.scale)
	XPerl_StatsFrameSetup(self, {self.statsFrame.xpBar}, 2)
	XPerl_SavePosition(self, true)
end

-- XPerl_Player_Pet_Virtual
function XPerl_Player_Pet_Virtual(show)
	if (not InCombatLockdown()) then
		if (show) then
			if (not virtual) then
				virtual = true
				XPerl_Player_Pet:RegisterEvent("PLAYER_REGEN_DISABLED")
				UnregisterUnitWatch(XPerl_Player_Pet)
				XPerl_Player_Pet:Show()
				XPerl_Player_Pet.nameFrame.text:SetText(PET)

				if (XPerl_PetTarget) then
					XPerl_PetTarget.virtual = true
					UnregisterUnitWatch(XPerl_PetTarget)
					XPerl_PetTarget:Show()
					XPerl_PetTarget.nameFrame.text:SetText(PET.." "..TARGET)
				end
			end
		else
			if (virtual) then
				virtual = nil
				RegisterUnitWatch(XPerl_Player_Pet)
				if (XPerl_PetTarget) then
					XPerl_PetTarget.virtual = nil
					if (XPerl_PetTarget.conf.enable) then
						RegisterUnitWatch(XPerl_PetTarget)
						XPerl_PetTarget:Hide()
					end
				end
				XPerl_Player_Pet:UnregisterEvent("PLAYER_REGEN_DISABLED")
			end
		end
	end
end

-- XPerl_Player_Pet_Set_Bits
function XPerl_Player_Pet_Set_Bits(self)
	if (not virtual) then
		RegisterUnitWatch(self)
	end

	if (pconf.portrait) then
		self.portraitFrame:Show()
		self.portraitFrame:SetWidth(50)
	else
		self.portraitFrame:Hide()
		self.portraitFrame:SetWidth(3)
	end

	if (pconf.name) then
		self.nameFrame:Show()
		self.nameFrame:SetHeight(24)
	else
		self.nameFrame:Hide()
		self.nameFrame:SetHeight(2)
	end

	if (pconf.name or pconf.portrait) then
		self.happyFrame:SetPoint("BOTTOMRIGHT", self.portraitFrame, "BOTTOMLEFT", 2, 0)

		if (pconf.level) then
			self.levelFrame:SetPoint("TOPRIGHT", self.portraitFrame, "TOPLEFT", 2, 0)
		end
	else
		self.happyFrame:SetPoint("BOTTOMRIGHT", self.statsFrame, "BOTTOMLEFT", 2, 0)

		if (pconf.level) then
			self.levelFrame:SetPoint("TOPRIGHT", self.happyFrame, "TOPLEFT", 2, 0)
		end
	end

	if (FOM_FeedButton) then
		Set_FOM_FeedButton()
	end

	if (pconf.xpBar) then
		self.statsFrame.xpBar:Show()
		self.statsFrame:SetHeight(44)
	else
		self.statsFrame.xpBar:Hide()
		self.statsFrame:SetHeight(34)
	end

	if (pconf.level) then
		self.levelFrame:Show()
	else
		self.levelFrame:Hide()
	end

	self.buffOptMix = nil
	self.buffFrame:ClearAllPoints()
	if (pconf.buffs.above) then
		if (pconf.portrait) then
			self.buffFrame:SetPoint("BOTTOMLEFT", self.portraitFrame, "TOPLEFT", 3, 0)
		else
			self.buffFrame:SetPoint("BOTTOMLEFT", self.nameFrame, "TOPLEFT", 3, 0)
		end
	else
		if (not pconf.extendPortrait and (pconf.xpBar or not pconf.portrait or not pconf.name)) then
			self.buffFrame:SetPoint("TOPLEFT", self.statsFrame, "BOTTOMLEFT", 3, 0)
		else
			self.buffFrame:SetPoint("TOPLEFT", self.portraitFrame, "BOTTOMLEFT", 3, 0)
		end
	end

	if (pconf.values) then
		self.statsFrame.healthBar.text:Show()
		self.statsFrame.manaBar.text:Show()
	else
		self.statsFrame.healthBar.text:Hide()
		self.statsFrame.manaBar.text:Hide()
	end

	self.portraitFrame:SetHeight(56 + ((pconf.extendPortrait and pconf.xpBar) or 0) * 10)

	self.highlight:ClearAllPoints()
	if (pconf.portrait or pconf.name) then
		self.highlight:SetPoint("BOTTOMLEFT", self.portraitFrame)
	else
		self.highlight:SetPoint("BOTTOMLEFT", self.statsFrame)
	end
	self.highlight:SetPoint("TOPRIGHT", self.nameFrame)

	pconf.buffs.size = tonumber(pconf.buffs.size) or 20
	XPerl_SetBuffSize(self)

	XPerl_Player_Pet_SetWidth(self)

	if (self:IsShown()) then
		XPerl_Player_Pet_UpdateDisplay(self)
	end
end
