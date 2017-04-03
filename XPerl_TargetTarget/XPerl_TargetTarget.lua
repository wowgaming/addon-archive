-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

local conf
XPerl_RequestConfig(function(new)
				conf = new
				if (XPerl_TargetTarget) then XPerl_TargetTarget.conf = conf.targettarget end
				if (XPerl_TargetTargetTarget) then XPerl_TargetTargetTarget.conf = conf.targettargettarget end
				if (XPerl_FocusTarget) then XPerl_FocusTarget.conf = conf.focustarget end
				if (XPerl_PetTarget) then XPerl_PetTarget.conf = conf.pettarget end
			end, "$Revision: 302 $")

local UnitName = UnitName
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitIsConnected = UnitIsConnected
local UnitIsGhost = UnitIsGhost
local UnitIsDead = UnitIsDead
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitMana = UnitMana
local UnitManaMax = UnitManaMax
local UnitPowerType = UnitPowerType
local GetNumRaidMembers = GetNumRaidMembers
local GetDifficultyColor = GetDifficultyColor or GetQuestDifficultyColor

local buffSetup

-- XPerl_TargetTarget_OnLoad
function XPerl_TargetTarget_OnLoad(self)
	self:RegisterForClicks("AnyUp")
	self:RegisterForDrag("LeftButton")
	XPerl_SetChildMembers(self)

	self.tutorialPage = 9

	-- Events
	self:RegisterEvent("RAID_TARGET_UPDATE")
	if (self == XPerl_TargetTarget) then
		self.tutorialPage = 8
		self.parentid = "target"
		self.partyid = "targettarget"
		--self:RegisterEvent("UNIT_TARGET")
		self:RegisterEvent("PLAYER_TARGET_CHANGED")
		self:SetScript("OnUpdate", XPerl_TargetTarget_OnUpdate)
	elseif (self == XPerl_FocusTarget) then
		self.parentid = "focus"
		self.partyid = "focustarget"
		self:RegisterEvent("UNIT_TARGET")
		self:SetScript("OnUpdate", XPerl_TargetTarget_OnUpdate)
	elseif (self == XPerl_PetTarget) then
		self.parentid = "pet"
		self.partyid = "pettarget"
		self:RegisterEvent("UNIT_TARGET")
		self:SetScript("OnUpdate", XPerl_TargetTarget_OnUpdate)
	else
		self.parentid = "targettarget"
		self.partyid = "targettargettarget"
		self:SetScript("OnUpdate", XPerl_TargetTargetTarget_OnUpdate)
	end

	XPerl_SecureUnitButton_OnLoad(self, self.partyid, XPerl_ShowGenericMenu)
	XPerl_SecureUnitButton_OnLoad(self.nameFrame, self.partyid, XPerl_ShowGenericMenu)

	--RegisterUnitWatch(self)

	local BuffOnUpdate, DebuffOnUpdate, BuffUpdateTooltip, DebuffUpdateTooltip
	BuffUpdateTooltip = XPerl_Unit_SetBuffTooltip
	DebuffUpdateTooltip = XPerl_Unit_SetDeBuffTooltip

	if (buffSetup) then
		self.buffSetup = buffSetup
	else
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
			debuffSizeMod = 0.2,
			debuffAnchor1 = function(self, b) b:SetPoint("TOPLEFT", 0, 0) end,
		}
		self.buffSetup.buffAnchor1 = self.buffSetup.debuffAnchor1
		buffSetup = self.buffSetup
	end

	self.targetname = ""
	self.time, self.targethp, self.targetmana, self.lastUpdate = 0, 0, 0, 0

	--XPerl_InitFadeFrame(self)
	XPerl_RegisterHighlight(self.highlight, 2)
	XPerl_RegisterPerlFrames(self, {self.nameFrame, self.statsFrame, self.levelFrame})

	if (XPerlDB) then
		self.conf = XPerlDB[self.partyid]
	end

	XPerl_Highlight:Register(XPerl_TargetTarget_HighlightCallback, self)

	if (self == XPerl_TargetTarget) then
		XPerl_RegisterOptionChanger(XPerl_TargetTarget_Set_Bits, "TargetTarget")
	end

	if (XPerl_TargetTarget and XPerl_FocusTarget and XPerl_PetTarget and XPerl_TargetTargetTarget) then
		XPerl_TargetTarget_OnLoad = nil
	end
end

-- XPerl_TargetTarget_HighlightCallback
function XPerl_TargetTarget_HighlightCallback(self, updateGUID)
	if (UnitGUID(self.partyid) == updateGUID and UnitIsFriend("player", self.partyid)) then
		XPerl_Highlight:SetHighlight(self, updateGUID)
	end
end

-------------------------
-- The Update Function --
-------------------------
function XPerl_TargetTarget_UpdatePVP(self)
	local pvp = self.conf.pvpIcon and (UnitIsPVP(self.partyid) and UnitFactionGroup(self.partyid)) or (UnitIsPVPFreeForAll(self.partyid) and "FFA")
	if (pvp) then
		self.nameFrame.pvpIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..pvp)
		self.nameFrame.pvpIcon:Show()
	else
		self.nameFrame.pvpIcon:Hide()
	end
end

-- XPerl_TargetTarget_Buff_UpdateAll
local function XPerl_TargetTarget_Buff_UpdateAll(self)
	if (self.conf.buffs.enable) then
		self.buffFrame:Show()
		XPerl_Targets_BuffUpdate(self)
	else
		self.buffFrame:Hide()
	end
end

-- XPerl_TargetTarget_RaidIconUpdate
local function XPerl_TargetTarget_RaidIconUpdate(self)
	local frameRaidIcon = self.nameFrame.raidIcon
	local frameNameFrame = self.nameFrame

	XPerl_Update_RaidIcon(frameRaidIcon, self.partyid)

	frameRaidIcon:ClearAllPoints()
	if (conf.target.raidIconAlternate) then
		frameRaidIcon:SetHeight(16)
		frameRaidIcon:SetWidth(16)
		frameRaidIcon:SetPoint("CENTER", frameNameFrame, "TOPRIGHT", -5, -4)
	else
		frameRaidIcon:SetHeight(32)
		frameRaidIcon:SetWidth(32)
		frameRaidIcon:SetPoint("CENTER", frameNameFrame, "CENTER", 0, 0)
	end
end

-- XPerl_TargetTarget_UpdateDisplay
function XPerl_TargetTarget_UpdateDisplay(self,force)

	local partyid = self.partyid
	if (self.conf.enable and UnitExists(self.parentid) and UnitIsConnected(partyid)) then
		self.targetname = UnitName(partyid)
		if (self.targetname ~= nil) then
			local t = GetTime()
			if (not force and t < self.lastUpdate + 0.3) then
				return
			end
			XPerl_Highlight:RemoveHighlight(self)
			self.lastUpdate = t

			XPerl_TargetTarget_UpdatePVP(self)

			-- Save these 2, so we know whether to update the frame later
			self.targethp = UnitHealth(partyid)
			self.targetmana = UnitMana(partyid)
			self.afk = UnitIsAFK(partyid) and conf.showAFK

			XPerl_SetUnitNameColor(self.nameFrame.text, partyid)

			if (self.conf.level) then
				local TargetTargetlevel = UnitLevel(partyid)
				local color = GetDifficultyColor(TargetTargetlevel)

				self.levelFrame.text:Show()
				self.levelFrame.skull:Hide()
				if (TargetTargetLevel == -1) then
					if (UnitClassification(partyid) == "worldboss") then
						TargetTargetLevel = "Boss"
					else
						self.levelFrame.text:Hide()
						self.levelFrame.skull:Show()
					end
				elseif (strfind(UnitClassification(partyid) or "", "elite")) then
					TargetTargetlevel = TargetTargetlevel.."+"
					self.levelFrame:SetWidth(33)
				else
					self.levelFrame:SetWidth(27)
				end

				self.levelFrame.text:SetText(TargetTargetlevel)

				if (TargetTargetLevel == "Boss") then
					self.levelFrame:SetWidth(self.levelFrame.text:GetStringWidth() + 6)
					color = {r = 1, g = 0, b = 0}
				end

				self.levelFrame.text:SetTextColor(color.r, color.g, color.b)
			end

			-- Set name - Must do after level as the NameFrame can change size just above here.
			local TargetTargetname = self.targetname
			self.nameFrame.text:SetText(TargetTargetname)

			-- Set health
			XPerl_Target_SetHealth(self)

			-- Set mana
			if (not self.statsFrame.greyMana) then
				XPerl_Target_SetManaType(self)
			end
			XPerl_Target_SetMana(self)

			XPerl_TargetTarget_RaidIconUpdate(self)

			--XPerl_Targets_BuffPositions(self)		-- Moved to option set to save garbage production
			XPerl_TargetTarget_Buff_UpdateAll(self)

			XPerl_UpdateSpellRange(self, partyid)
			XPerl_Highlight:SetHighlight(self, UnitGUID(partyid))
			return
		end
	end

	self.targetname = ""
	XPerl_Highlight:RemoveHighlight(self)
end

-- XPerl_TargetTarget_Update_Control
local function XPerl_TargetTarget_Update_Control(self)
	if (UnitIsVisible(self.partyid) and UnitIsCharmed(self.partyid)) then
		self.nameFrame.warningIcon:Show()
	else
		self.nameFrame.warningIcon:Hide()
	end
end

-- XPerl_TargetTarget_Update_Combat
local function XPerl_TargetTarget_Update_Combat(self)
	if (UnitAffectingCombat(self.partyid)) then
		self.nameFrame.combatIcon:Show()
	else
		self.nameFrame.combatIcon:Hide()
	end
end

-- SmallUpdate
local function SmallUpdate(self)

end

-- XPerl_TargetTarget_OnUpdate
function XPerl_TargetTarget_OnUpdate(self, elapsed)

	local partyid = self.partyid
	local newHP = UnitHealth(partyid)
	local newMana = UnitMana(partyid)
	local newAFK = UnitIsAFK(partyid)

	if ((newHP ~= self.targethp) or (newMana ~= self.targetmana) or (newAFK ~= self.afk)) then
		XPerl_TargetTarget_UpdateDisplay(self)
	else
		self.time = elapsed + self.time
       	if (self.time >= 0.2) then
			XPerl_TargetTarget_Update_Combat(self)
			XPerl_TargetTarget_Update_Control(self)
			XPerl_TargetTarget_UpdatePVP(self)
			XPerl_TargetTarget_Buff_UpdateAll(self)
			XPerl_SetUnitNameColor(self.nameFrame.text, partyid)
			XPerl_UpdateSpellRange(self, partyid)
			XPerl_Highlight:SetHighlight(self, UnitGUID(partyid))
			self.time = 0
		end
	end
end

-- XPerl_TargetTargetTarget_OnUpdate
function XPerl_TargetTargetTarget_OnUpdate(self, elapsed)

	local newName = UnitName(self.partyid)

	if (not newName) then
		newName = ""
		newHP = 0
		newMana = 0
	end

	if (self == XPerl_TargetTargetTarget and newName ~= self.targetname) then
		XPerl_NoFadeBars(true)
		XPerl_TargetTarget_UpdateDisplay(self,true)
		XPerl_NoFadeBars()
		return
	end

	XPerl_TargetTarget_OnUpdate(self, elapsed)
end

-------------------
-- Event Handler --
-------------------
function XPerl_TargetTarget_OnEvent(self, event, arg1, ...)

	if (event == "RAID_TARGET_UPDATE") then
		XPerl_TargetTarget_RaidIconUpdate(self)

	elseif (event == "PLAYER_TARGET_CHANGED") then
		XPerl_TargetTarget_UpdateDisplay(self, true)

	elseif (event == "UNIT_TARGET") then
		if (arg1 == "target" and self == XPerl_TargetTarget) then
			XPerl_NoFadeBars(true)
			XPerl_TargetTarget_UpdateDisplay(self, true)
			XPerl_NoFadeBars()
		elseif (arg1 == "focus" and self == XPerl_FocusTarget) then
			XPerl_NoFadeBars(true)
			XPerl_TargetTarget_UpdateDisplay(self, true)
			XPerl_NoFadeBars()
		elseif (arg1 == "pet" and self == XPerl_PetTarget) then
			XPerl_NoFadeBars(true)
			XPerl_TargetTarget_UpdateDisplay(self, true)
			XPerl_NoFadeBars()
		end
	end
end

-- XPerl_TargetTarget_Update
function XPerl_TargetTarget_Update()
	local offset = -3
	if (self.conf.buffs.enable) then
		if (UnitExists("targettarget")) then
			if (XPerl_UnitBuff("targettarget", 1)) then
				if (offset == -3) then
					offset = 0
				end
				offset = offset + 20
				if (UnitBuff("targettarget", 9)) then
					offset = offset + 20
				end
			end
			if (XPerl_UnitDebuff("targettarget", 1)) then
				if (offset == -3) then
					offset = 0
				end
				offset = offset + 24
			end
		end
	end
end

-- EnableDisable
local function EnableDisable(self)
	if (self.conf.enable) then
		if (not self.virtual) then
			RegisterUnitWatch(self)
		end
	else
		UnregisterUnitWatch(self)
		self:Hide()
	end
end

-- XPerl_TargetTarget_SetWidth
function XPerl_TargetTarget_SetWidth(self)

	self.conf.size.width = max(0, self.conf.size.width or 0)
	local bonus = self.conf.size.width

	if (self.conf.percent) then
		self:SetWidth(160 + bonus)
		self.nameFrame:SetWidth(160 + bonus)
		self.statsFrame:SetWidth(160 + bonus)
		self.statsFrame.healthBar.percent:Show()
		self.statsFrame.manaBar.percent:Show()
	else
		self:SetWidth(128 + bonus)
		self.nameFrame:SetWidth(128 + bonus)
		self.statsFrame:SetWidth(128 + bonus)
		self.statsFrame.healthBar.percent:Hide()
		self.statsFrame.manaBar.percent:Hide()
	end

	self.conf.scale = self.conf.scale or 0.8
	self:SetScale(self.conf.scale)

	XPerl_SavePosition(self, true)

	XPerl_StatsFrameSetup(self)
end

-- Set
local function Set(self)
	if (self.conf.level) then
		self.levelFrame:Show()
		self.levelFrame:SetWidth(27)
	else
		self.levelFrame:Hide()
	end

	if (self.conf.mana) then
		self.statsFrame.manaBar:Show()
		self.statsFrame:SetHeight(40)
	else
		self.statsFrame.manaBar:Hide()
		self.statsFrame:SetHeight(30)
	end

	if (self.conf.values) then
		self.statsFrame.healthBar.text:Show()
		self.statsFrame.manaBar.text:Show()
	else
		self.statsFrame.healthBar.text:Hide()
		self.statsFrame.manaBar.text:Hide()
	end

	self.buffFrame:ClearAllPoints()
	if (self.conf.buffs.above) then
		self.buffFrame:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 2, 0)
	else
		self.buffFrame:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 2, 0)
	end
	self.buffOptMix = nil
	self.conf.buffs.size = tonumber(self.conf.buffs.size) or 20

	XPerl_SetBuffSize(self)

	XPerl_TargetTarget_SetWidth(self)

	XPerl_ProtectedCall(EnableDisable, self)

	if (self:IsShown()) then
		XPerl_TargetTarget_UpdateDisplay(self, true)
	end
end

-- XPerl_TargetTarget_Set_Bits
function XPerl_TargetTarget_Set_Bits()
	if (not XPerl_TargetTarget) then
		return
	end

	if (conf.targettargettarget.enable) then
		if (not XPerl_TargetTargetTarget) then
			local ttt = CreateFrame("Button", "XPerl_TargetTargetTarget", UIParent, "XPerl_TargetTarget_Template")

			ttt:SetPoint("TOPLEFT", XPerl_TargetTarget.statsFrame, "TOPRIGHT", 5, 0)
		end
	end

	if (conf.focustarget.enable) then
		if (not XPerl_FocusTarget) then
			local ttt = CreateFrame("Button", "XPerl_FocusTarget", UIParent, "XPerl_TargetTarget_Template")

			ttt:SetPoint("TOPLEFT", XPerl_Focus.levelFrame, "TOPRIGHT", 5, 0)
		end
	end

	if (conf.pettarget.enable and XPerl_Player_Pet) then
		if (not XPerl_PetTarget) then
			local pt = CreateFrame("Button", "XPerl_PetTarget", XPerl_Player_Pet, "XPerl_TargetTarget_Template")

			pt:SetPoint("BOTTOMLEFT", XPerl_Player_Pet.statsFrame, "BOTTOMRIGHT", 5, 0)
		end
	end

	Set(XPerl_TargetTarget)
	if (XPerl_TargetTargetTarget) then
		Set(XPerl_TargetTargetTarget)
	end
	if (XPerl_FocusTarget) then
		Set(XPerl_FocusTarget)
	end
	if (XPerl_PetTarget) then
		Set(XPerl_PetTarget)
	end
end
