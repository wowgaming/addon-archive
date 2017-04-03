-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

local XPerl_Party_Events = {}
local checkRaidNextUpdate
local PartyFrames = {}
local startupDone
local conf, pconf
XPerl_RequestConfig(function(new)
			conf = new
			pconf = new.party
			for k,v in pairs(PartyFrames) do
				v.conf = pconf
			end
		end, "$Revision: 402 $")

local percD = "%d"..PERCENT_SYMBOL

local format = format
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
local partyHeader
local partyAnchor

local XPerl_Party_HighlightCallback

----------------------
-- Loading Function --
----------------------
function XPerl_Party_Events_OnLoad(self)
	-- Added UNIT_POWER/UNIT_MAXPOWER to events list for 4.0 (By PlayerLin)
	local events = {"PLAYER_ENTERING_WORLD", "PARTY_MEMBER_ENABLE", "PARTY_MEMBER_DISABLE", "RAID_ROSTER_UPDATED", "PARTY_MEMBERS_CHANGED",
			"UNIT_COMBAT", "UNIT_SPELLMISS", "UNIT_FACTION", "UNIT_DYNAMIC_FLAGS", "UNIT_FLAGS", "UNIT_AURA", "UNIT_PORTRAIT_UPDATE",
			"UNIT_TARGET", "UNIT_RAGE", "UNIT_MAXRAGE", "UNIT_ENERGY", "UNIT_MAXENERGY", "UNIT_MANA", "UNIT_MAXMANA", "UNIT_RUNIC_POWER", "UNIT_MAXRUNIC_POWER",
			"UNIT_POWER", "UNIT_MAXPOWER", "UNIT_HEALTH", "UNIT_MAXHEALTH", "UNIT_LEVEL", "UNIT_DISPLAYPOWER", "UNIT_NAME_UPDATE", "PLAYER_FLAGS_CHANGED",
			"RAID_TARGET_UPDATE", "READY_CHECK", "READY_CHECK_CONFIRM", "READY_CHECK_FINISHED", "PLAYER_LOGIN", "UNIT_THREAT_LIST_UPDATE",
			"PLAYER_TARGET_CHANGED"}
	for i,event in pairs(events) do
		self:RegisterEvent(event)
	end

	partyHeader:UnregisterEvent("UNIT_NAME_UPDATE")			-- IMPORTANT! Fix for WoW 2.1 UNIT_NAME_UPDATE lockup issues
	UIParent:UnregisterEvent("RAID_ROSTER_UPDATE")			-- IMPORTANT! Stops raid framerate lagging when members join/leave/zone

	for i = 1,4 do
		XPerl_BlizzFrameDisable(getglobal("PartyMemberFrame"..i))
	end

	self:SetScript("OnEvent", XPerl_Party_OnEvent)
	XPerl_RegisterOptionChanger(XPerl_Party_Set_Bits)
	XPerl_Highlight:Register(XPerl_Party_HighlightCallback, self)

	XPerl_Party_Events_OnLoad = nil
end

-- XPerl_Party_HighlightCallback
function XPerl_Party_HighlightCallback(self, updateGUID)
	local f = XPerl_Party_GetUnitFrameByGUID(updateGUID)
	if (f) then
		XPerl_Highlight:SetHighlight(f, updateGUID)
	end
end

-- SetFrameArray
local function SetFrameArray(self, value)
	for k,v in pairs(PartyFrames) do
		if (v == self) then
			PartyFrames[k] = nil
			if (XPerl_PartyPetFrames) then
				local petid = "partypet"..strmatch(k, "^party(%d)")
				if (XPerl_PartyPetFrames[petid]) then
					XPerl_PartyPetFrames[petid].partyid = nil
					XPerl_PartyPetFrames[petid].ownerid = nil
					XPerl_PartyPetFrames[petid] = nil
				end
			end
		end
	end

	self.partyid = value
	if (value) then
		self.targetid = value.."target"
		PartyFrames[value] = self
		if (XPerl_PartyPetFrames and self.petFrame) then
			local petid = "partypet"..strmatch(value, "^party(%d)")
			XPerl_PartyPetFrames[petid] = self.petFrame
			self.petFrame.partyid = petid
			self.petFrame.ownerid = value
		end
	end
end

-- onAttrChanged
local function onAttrChanged(self, name, value)
	if (name == "unit") then
		if (value and value ~= "party0") then
			SetFrameArray(self, value)
			if (self.partyid ~= value or self.lastName ~= UnitName(value)) then
				if (conf) then
					XPerl_Party_UpdateDisplay(self, true)
				end
				if (XPerl_ArcaneBar_RegisterFrame) then
					XPerl_ArcaneBar_RegisterFrame(self.nameFrame, value)
				end
			end
		else
			SetFrameArray(self)
		end
	end
end

-- XPerl_Party_OnLoad
function XPerl_Party_OnLoad(self)
	XPerl_SetChildMembers(self)
	self.targetFrame.statsFrame = self.targetFrame.healthBar	-- So the healthbar fades as part of pseudo statsFrame

	partyHeader = XPerl_Party_SecureHeader
	partyAnchor = XPerl_Party_Anchor

	local id = strmatch(self:GetName(), ".+(%d)")
	self:SetID(tonumber(id))
	setglobal("XPerl_party"..self:GetID(), self)

	if (self:GetID() > 1) then
		self.buffSetup = XPerl_party1.buffSetup
	else
		local BuffOnUpdate, DebuffOnUpdate, BuffUpdateTooltip, DebuffUpdateTooltip
		BuffUpdateTooltip = XPerl_Unit_SetBuffTooltip
		DebuffUpdateTooltip = XPerl_Unit_SetDebuffTooltip

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
			debuffSizeMod = 0.4,
			debuffAnchor1 = function(self, b)
				if (pconf.flip) then
					b:SetPoint("RIGHT", self.statsFrame, "LEFT", 0, 0)
				else
					b:SetPoint("LEFT", self.statsFrame, "RIGHT", 0, 0)
				end
			end,
			buffAnchor1 = function(self, b)
				if (pconf.flip) then
					b:SetPoint("TOPRIGHT", self.buffFrame, "TOPRIGHT", 0, 0)
				else
					b:SetPoint("TOPLEFT", self.buffFrame, "TOPLEFT", 0, 0)
				end
			end,
		}
	end

	partyHeader:SetAttribute("child"..self:GetID(), self)
	self.partyid = "party"..self:GetID()
	PartyFrames[self.partyid] = self

	self.hitIndicator.text:SetPoint("CENTER", self.portraitFrame, "CENTER", 0, 0)
	CombatFeedback_Initialize(self, self.hitIndicator.text, 30)

	XPerl_SecureUnitButton_OnLoad(self, self.partyid, nil, getglobal("PartyMemberFrame"..self:GetID().."DropDown"), getglobal("PartyMemberFrame" .. self:GetID()).menu)
	XPerl_SecureUnitButton_OnLoad(self.nameFrame, self.partyid, nil, getglobal("PartyMemberFrame"..self:GetID().."DropDown"), getglobal("PartyMemberFrame" .. self:GetID()).menu)

	self.time = 0
	self.flagsCheck = 0

	XPerl_RegisterHighlight(self.highlight, 3)
	XPerl_RegisterHighlight(self.targetFrame, 3)
	XPerl_RegisterPerlFrames(self, {self.nameFrame, self.statsFrame, self.portraitFrame, self.levelFrame, self.targetFrame})

	self.FlashFrames = {self.nameFrame, self.levelFrame, self.statsFrame, self.portraitFrame}

	self:SetScript("OnUpdate", XPerl_Party_OnUpdate)
	self:SetScript("OnAttributeChanged", onAttrChanged)
	self:SetScript("OnShow", XPerl_Party_UpdateDisplay)		-- 	XPerl_Unit_UpdatePortrait)

	self.targetFrame:SetScript("OnUpdate", XPerl_Party_Target_OnUpdate)

	if (XPerlDB) then
		self.conf = XPerlDB.party
	end

	--XPerl_Party_Set_Bits1(self)

	if (XPerl_party1 and XPerl_party2 and XPerl_party3 and XPerl_party4) then
		XPerl_Party_OnLoad = nil
	end
end

-- ShowHideValues
local function ShowHideValues(self)
	if (pconf.values) then
		self.statsFrame.healthBar.text:Show()
		self.statsFrame.manaBar.text:Show()
	else
		if (not self.hideValues) then
			self.statsFrame.healthBar.text:Hide()
			self.statsFrame.manaBar.text:Hide()
		end
	end
end

local spiritOfRedemption = GetSpellInfo(27827)

-- XPerl_Party_UpdateHealth
function XPerl_Party_UpdateHealth(self)
	if (not self.conf) then
		return
	end
	local partyid = self.partyid
	local Partyhealth, Partyhealthmax = XPerl_UnitHealth(partyid), UnitHealthMax(partyid)
	local reason

	if (self.feigning and not UnitIsFeignDeath(partyid)) then
		self.feigning = nil
	end

	XPerl_SetHealthBar(self, Partyhealth, Partyhealthmax)

	if (not UnitIsConnected(partyid)) then
		reason = XPERL_LOC_OFFLINE
	else
		if (self.feigning and conf.showFD) then
			reason = XPERL_LOC_FEIGNDEATH

		elseif (self.afk and conf.showAFK) then
			reason = CHAT_MSG_AFK

		elseif (UnitIsDead(partyid)) then
			reason = XPERL_LOC_DEAD

		elseif (UnitIsGhost(partyid)) then
			reason = XPERL_LOC_GHOST

		elseif ((Partyhealth==1) and (Partyhealthmax==1)) then
			reason = XPERL_LOC_UPDATING

		elseif (UnitBuff(partyid, spiritOfRedemption)) then
			reason = XPERL_LOC_DEAD

		end
	end

	ShowHideValues(self)
	if (reason) then
		if (pconf.percent) then
			local old = self.statsFrame.healthBar.percent:GetText()
			self.statsFrame.healthBar.percent:SetText(reason)

			if (self.statsFrame.healthBar.percent:GetStringWidth() > (self.statsFrame:GetWidth() - self.statsFrame.healthBar:GetWidth() - 8)) then
				self.statsFrame.healthBar.percent:SetText(old)
				self.statsFrame.healthBar.text:SetText(reason)
				self.statsFrame.healthBar.text:Show()
			else
				self.statsFrame.healthBar.percent:Show()
			end
		else
			self.statsFrame.healthBar.text:SetText(reason)
			self.statsFrame.healthBar.text:Show()
		end

		self.statsFrame:SetGrey()
	else
		if (self.statsFrame.greyMana) then
			self.statsFrame.greyMana = nil
			XPerl_SetManaBarType(self)
		end
	end
end

-- XPerl_Party_UpdatePlayerFlags(self)
local function XPerl_Party_UpdatePlayerFlags(self)
	if (UnitIsAFK(self.partyid) and conf.showAFK) then
		if (not self.afk) then
			change = true
			self.afk = GetTime()
			self.dnd = nil
		end
	elseif (UnitIsDND(self.partyid)) then
		if (self.afk) then
			change = true
			self.afk = nil
		end
	else
		if (self.afk or self.dnd) then
			self.afk, self.dnd = nil, nil
			change = true
		end
	end

	if (change) then
		XPerl_Party_UpdateHealth(self)
	end
end

--------------------
-- Buff Functions --
--------------------

-- XPerl_Party_SetDebuffLocation
function XPerl_Party_SetDebuffLocation(self)
	local debuff1 = self.buffFrame.debuff and self.buffFrame.debuff[1]
	if (debuff1) then
		debuff1:ClearAllPoints()

		if (pconf.debuffs.below) then
			local buff1 = self.buffFrame.buff and self.buffFrame.buff[1]
			if (not buff1) then
				if (pconf.flip) then
					debuff1:SetPoint("TOPRIGHT", self.buffFrame, "TOPRIGHT", 0, -20)
				else
					debuff1:SetPoint("TOPLEFT", self.buffFrame, "TOPLEFT", 0, -20)
				end
			else
				if (pconf.flip) then
					debuff1:SetPoint("TOPRIGHT", buff1, "BOTTOMRIGHT", 0, -2)
				else
					debuff1:SetPoint("TOPLEFT", buff1, "BOTTOMLEFT", 0, -2)
				end
			end
		else
			if (self.petFrame and self.petFrame:IsVisible()) then
				if (pconf.flip) then
					debuff1:SetPoint("TOPRIGHT", self.petFrame.nameFrame, "TOPRIGHT", 0, -4)
				else
					debuff1:SetPoint("TOPLEFT", self.petFrame.nameFrame, "TOPRIGHT", 0, -4)
				end
			else
				if (pconf.flip) then
					debuff1:SetPoint("TOPRIGHT", self.statsFrame, "TOPLEFT", 0, -4)
				else
					debuff1:SetPoint("TOPLEFT", self.statsFrame, "TOPRIGHT", 0, -4)
				end
			end

			if (pconf.debuffs.halfSize) then
				local buffWidth = debuff1:GetWidth() * debuff1:GetScale()
				local selfWidth = self:GetWidth() * self:GetScale()
				local maxDebuffWidth = floor(selfWidth / buffWidth)
				local prev
				if (self.perlDebuffs > maxDebuffWidth) then
					self.debuffFrame:SetScale(0.5)

					local Anchor, aHalf, aPrev
					if (pconf.flip) then
						Anchor = "TOPRIGHT"
						aHalf = "BOTTOMRIGHT"
						aPrev = "TOPLEFT"
					else
						Anchor = "TOPLEFT"
						aHalf = "BOTTOMLEFT"
						aPrev = "TOPRIGHT"
					end

					local halfPoint = ceil(self.perlBuffs / 2)
					for k,v in pairs(self.buffFrame.debuff) do
						if (prev) then
							v:ClearAllPoints()
							if (k == halfPoint) then
								v:SetPoint(Anchor, debuff1, aHalf, 0, 0)
							else
								v:SetPoint(Anchor, prev, aPrev, 0, 0)
							end
						end
						prev = v
					end
				else
					self.debuffFrame:SetScale(1)

					local prev
					for k,v in pairs(self.buffFrame.debuff) do
						if (prev) then
							v:ClearAllPoints()
							v:SetPoint("TOPLEFT", prev, "TOPRIGHT", 0, 0)
						end
						prev = v
					end
				end
			else
				self.debuffFrame:SetScale(1)
			end
		end
	end
end

-- XPerl_Party_BuffPositions
local function XPerl_Party_BuffPositions(self)
	if (self.conf) then
		if (pconf.debuffs.below) then
			if (pconf.buffs.wrap) then
				XPerl_Unit_BuffPositions(self, self.buffFrame.buff, self.buffFrame.debuff, self.conf.buffs.size, self.conf.debuffs.size)
			end
		else
			-- Debuffs handled seperately by legacy code, so just do buffs
			if (pconf.buffs.wrap) then
				XPerl_Unit_BuffPositions(self, self.buffFrame.buff, nil, self.conf.buffs.size)
			end
			XPerl_Party_SetDebuffLocation(self)
		end
	end
end

-- XPerl_Party_Buff_UpdateAll
local function XPerl_Party_Buff_UpdateAll(self)
	if (self.conf) then
		if (not pconf.buffs.enable and not pconf.debuffs.enable) then
			self.buffFrame:Hide()
			self.debuffFrame:Hide()
		else
			XPerl_Unit_UpdateBuffs(self, nil, nil, pconf.buffs.castable, pconf.debuffs.curable)
			XPerl_Party_BuffPositions(self)
		end
	
		if (select(2, UnitClass(self.partyid)) == "HUNTER") then
			local feigning = UnitIsFeignDeath(self.partyid)
			if (feigning ~= self.feigning) then
				self.feigning = feigning
				XPerl_Party_UpdateHealth(self)
			end
		end
	
		XPerl_CheckDebuffs(self, self.partyid)
	end
end

-------------------------
-- The Update Function --
-------------------------
local function XPerl_Party_CombatFlash(self, elapsed, argNew, argGreen)
	if (XPerl_CombatFlashSet(self, elapsed, argNew, argGreen)) then
		XPerl_CombatFlashSetFrames(self)
	end
end

-- XPerl_Party_UpdateName
local function XPerl_Party_UpdateName(self)
	local Partyname = UnitName(self.partyid)
	self.lastName = Partyname
	if (Partyname) then
		self.nameFrame.text:SetFontObject(GameFontNormal)
		self.nameFrame.text:SetText(Partyname)

		if (self.nameFrame.text:GetStringWidth() > self.nameFrame:GetWidth() - 4) then
			self.nameFrame.text:SetFontObject(GameFontNormalSmall)
		end

		XPerl_ColourFriendlyUnit(self.nameFrame.text, self.partyid)
	end
end

-- UpdateAssignedRoles
local function UpdateAssignedRoles(self)
	local unit = self.partyid
	local icon = self.nameFrame.roleIcon
	local isTank, isHealer, isDamage
	if (select(2, IsInInstance()) == "party") then
		-- No point getting it otherwise, as they can be wrong. Usually the values you had
		-- from previous instance if you're running more than one with the same people
		
		-- According to http://forums.worldofwarcraft.com/thread.html?topicId=26560499864
		-- this is the new way to check for roles
		-- Port this from XPerl_Player.lua by PlayerLin
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
			isTank, isHealer, isDamage = UnitGroupRolesAssigned(unit)
		end
	end

	icon:ClearAllPoints()
	if (self.nameFrame.masterIcon:IsShown()) then
		icon:SetPoint("LEFT", self.nameFrame.masterIcon, "RIGHT")
	elseif (self.nameFrame.leaderIcon:IsShown()) then
		icon:SetPoint("LEFT", self.nameFrame.leaderIcon, "RIGHT")
	else
		icon:SetPoint("TOPLEFT", 5, 5)
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

-- UpdateAllAssignedRoles
local function UpdateAllAssignedRoles()
	for unit,frame in pairs(PartyFrames) do
		if (frame:IsShown()) then
			UpdateAssignedRoles(frame)
		end
	end
end

-- XPerl_Party_UpdateLeader
local function XPerl_Party_UpdateLeader(self)
	if ("party"..GetPartyLeaderIndex() == self.partyid) then
		self.nameFrame.leaderIcon:Show()
	else
		self.nameFrame.leaderIcon:Hide()
	end

	local lootMethod
	local lootMaster
	lootMethod, lootMaster = GetLootMethod()
	if (self.partyid == "party"..(lootMaster or "nil")) then
		self.nameFrame.masterIcon:Show()
	else
		self.nameFrame.masterIcon:Hide()
	end

	UpdateAssignedRoles(self)
end

-- XPerl_Party_UpdatePVP
local function XPerl_Party_UpdatePVP(self)
	local pvp = pconf.pvpIcon and (UnitIsPVP(self.partyid) and UnitFactionGroup(self.partyid)) or (UnitIsPVPFreeForAll(self.partyid) and "FFA")
	if (pvp) then
		self.nameFrame.pvpIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..pvp)
		self.nameFrame.pvpIcon:Show()
	else
		self.nameFrame.pvpIcon:Hide()
	end
end

-- XPerl_Party_UpdateCombat
function XPerl_Party_UpdateCombat(self)
	if (UnitIsVisible(self.partyid)) then
		if (UnitAffectingCombat(self.partyid)) then
			self.nameFrame.combatIcon:Show()
		else
			self.nameFrame.combatIcon:Hide()
		end

		if (UnitIsCharmed(self.partyid)) then
			self.nameFrame.warningIcon:Show()
		else
			self.nameFrame.warningIcon:Hide()
		end
	else
		self.nameFrame.combatIcon:Hide()
		self.nameFrame.warningIcon:Hide()
	end
end

-- XPerl_Party_UpdateClass
local function XPerl_Party_UpdateClass(self)
	if (UnitIsPlayer(self.partyid)) then
		local l, r, t, b = XPerl_ClassPos(select(2, UnitClass(self.partyid)))
		self.levelFrame.classTexture:SetTexCoord(l, r, t, b)
	end

	if (pconf.classIcon) then
		self.levelFrame.classTexture:Show()
	else
		self.levelFrame.classTexture:Hide()
	end
end

-- XPerl_Party_UpdateMana
local function XPerl_Party_UpdateMana(self)
	if (self.afk and not UnitIsAFK(self.partyid)) then
		XPerl_Party_UpdatePlayerFlags(self)
	end

	local Partymana = UnitMana(self.partyid)
	local Partymanamax = UnitManaMax(self.partyid)

	if (Partymanamax == 1 and Partymana > Partymanamax) then
		Partymanamax = Partymana
	end

	self.statsFrame.manaBar:SetMinMaxValues(0, Partymanamax)
	self.statsFrame.manaBar:SetValue(Partymana)

	if (UnitPowerType(self.partyid)>=1) then
		self.statsFrame.manaBar.percent:SetText(Partymana)
	else
		self.statsFrame.manaBar.percent:SetFormattedText(percD, 100 * max(0, Partymana / Partymanamax))
	end

	--if (pconf.values) then
	--	self.statsFrame.manaBar.text:Show()
	--else
	--	self.statsFrame.manaBar.text:Hide()
	--end

	self.statsFrame.manaBar.text:SetFormattedText("%d/%d", Partymana, Partymanamax)

	if (not UnitIsConnected(self.partyid)) then
		self.statsFrame.healthBar.text:SetText(XPERL_LOC_OFFLINE)
		if (not self.statsFrame.greyMana) then
			self.statsFrame:SetGrey()
		end
	end
end

-- XPerl_Party_UpdateRange
local function XPerl_Party_UpdateRange(self, overrideUnit)
	local partyid = overrideUnit or self.partyid
	if (partyid) then
		if (not pconf.range30yard or CheckInteractDistance(self.partyid, 1) or not UnitIsConnected(self.partyid)) then
			self.nameFrame.rangeIcon:Hide()
		else
			self.nameFrame.rangeIcon:Show()
			self.nameFrame.rangeIcon:SetAlpha(1)
		end
		if (UnitInVehicle(self.partyid) and pconf.range30yard) then--Not sure if this is proper way to do it, so this pretty much forces anyone in a vehicle to show out of range.
			self.nameFrame.rangeIcon:Show()
			self.nameFrame.rangeIcon:SetAlpha(1)
		end
	end
end

-- XPerl_Party_SingleGroup
function XPerl_Party_SingleGroup()
	local num = GetNumRaidMembers()
	if (num > 5) then
		return
	end
	for i = 1,num do
		local name, rank, group = GetRaidRosterInfo(i)
		if (group > 1) then
			return
		end
	end
	return true
end

-- CheckRaid
local function CheckRaid()
	if (InCombatLockdown()) then
		tinsert(XPerl_OutOfCombatQueue, CheckRaid)
	else
		partyAnchor:StopMovingOrSizing()

		local singleGroup = XPerl_Party_SingleGroup()
		if (not pconf or (pconf.inRaid or (pconf.smallRaid and singleGroup) or GetNumRaidMembers() == 0)) then
			if (not partyHeader:IsShown()) then
				partyHeader:Show()
			end
		else
			if (partyHeader:IsShown()) then
				partyHeader:Hide()
			end
		end
	end
end

-- XPerl_Party_TargetUpdateHealth
local function XPerl_Party_TargetUpdateHealth(self)
	local tf = self.targetFrame
	local hp, hpMax = UnitHealth(self.targetid), UnitHealthMax(self.targetid)
	tf.lastHP, tf.lastHPMax = hp, hpMax
	tf.lastUpdate = GetTime()

	tf.healthBar:SetMinMaxValues(0, hpMax)
	tf.healthBar:SetValue(hp)
	tf.healthBar.text:SetFormattedText(percD, 100 * hp / hpMax)	-- XPerl_Percent[floor(100 * hp / hpMax)])
	tf.healthBar.text:Show()

	if (UnitIsDeadOrGhost(self.targetid)) then
		tf.healthBar:SetStatusBarColor(0.5, 0.5, 0.5, 1)
		tf.healthBar.bg:SetVertexColor(0.5, 0.5, 0.5, 0.5)
		if (UnitIsDead(self.targetid)) then
			tf.healthBar.text:SetText(XPERL_LOC_DEAD)
		else
			tf.healthBar.text:SetText(XPERL_LOC_GHOST)
		end
	else
		--XPerl_ColourHealthBar(self.targetFrame, hp / hpMax, self.targetid)
		XPerl_SetSmoothBarColor(self.targetFrame.healthBar, hp / hpMax)
	end

	if (UnitAffectingCombat(self.targetid)) then
        tf.combatIcon:SetTexCoord(0.5, 1.0, 0.0, 0.5)
        tf.combatIcon:Show()
	else
        tf.combatIcon:Hide()
	end

	if (pconf.pvpIcon and UnitIsPVP(self.targetid)) then
		tf.pvpIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..(UnitFactionGroup(self.targetid) or "FFA"))
		tf.pvpIcon:Show()
	else
		tf.pvpIcon:Hide()
	end
end

-- XPerl_Party_TargetRaidIcon
local function XPerl_Party_TargetRaidIcon(self)
	XPerl_Update_RaidIcon(self.targetFrame.raidIcon, self.partyid.."target")
end

-- XPerl_Party_UpdateTarget
local function XPerl_Party_UpdateTarget(self)
	if (pconf.target.enable) then
		if (self.targetid and UnitIsConnected(self.partyid) and UnitExists(self.partyid) and UnitIsVisible(self.partyid)) then
			local targetname = UnitName(self.targetid)
			if (targetname and targetname ~= UNKNOWNOBJECT) then
				self.targetFrame.text:SetText(targetname)
				XPerl_SetUnitNameColor(self.targetFrame.text, self.targetid)
				XPerl_Party_TargetUpdateHealth(self)
				XPerl_Party_TargetRaidIcon(self)
			end
		end
	end
end

-- XPerl_Party_OnUpdate
function XPerl_Party_OnUpdate(self, elapsed)
	if (not self.partyid) then
		return
	end

	CombatFeedback_OnUpdate(self, elapsed)

	if (self.PlayerFlash) then
		XPerl_Party_CombatFlash(self, arg1, false)
	end

	self.time = self.time + elapsed
	if (self.time >= 0.2) then
		self.time = 0
		local partyid = self.partyid

		self.flagsCheck = self.flagsCheck + 1
		if (self.flagsCheck > 25) then
			self.flagsCheck = 0
			XPerl_Party_UpdatePlayerFlags(self)
		end

		if (pconf.target.large and self.targetFrame:IsVisible()) then
			local hp, hpMax = UnitHealth(self.targetid), UnitHealthMax(self.targetid)
			if (hp ~= self.targetFrame.lastHP or hpMax ~= self.targetFrame.lastHPMax or GetTime() > self.targetFrame.lastUpdate + 5000) then
				XPerl_Party_TargetUpdateHealth(self)
			end
		end

		XPerl_Party_UpdateRange(self, partyid)

		XPerl_UpdateSpellRange(self, partyid)
		XPerl_UpdateSpellRange(self.targetFrame, self.targetid)

		if (checkRaidNextUpdate) then
			checkRaidNextUpdate = checkRaidNextUpdate - 1
			if (checkRaidNextUpdate <= 0) then
				checkRaidNextUpdate = nil
				CheckRaid()

				-- Due to a bug in the API (WoW 2.0.1), GetPartyLeaderIndex() can often claim
				-- that party1 is the leader, even when they're not. So, we do a delayed check
				-- after a party change
				for i,frame in pairs(PartyFrames) do
					if (frame.partyid) then
						XPerl_Party_UpdateLeader(frame)
					end
				end
			end
		end
	end
end

-- XPerl_Party_Target_OnUpdate
function XPerl_Party_Target_OnUpdate(self, elapsed)
	self.time = elapsed + (self.time or 0)
	if (self.time >= 0.5) then
		self.time = 0
		XPerl_Party_UpdateTarget(self:GetParent())
	end
end

-- XPerl_Party_UpdateDisplayAll
function XPerl_Party_UpdateDisplayAll()
	for i,frame in pairs(PartyFrames) do
		if (frame.partyid) then
			XPerl_Party_UpdateDisplay(frame)
		end
	end
end

-- XPerl_Party_UpdateDisplay
function XPerl_Party_UpdateDisplay(self, less)
	if (self.conf and self.partyid and UnitExists(self.partyid)) then
		self.afk, self.dnd = nil,nil
		XPerl_Party_UpdateName(self)
		XPerl_Party_UpdateLeader(self)
		XPerl_Party_UpdateClass(self)

		if (not less) then
			XPerl_SetManaBarType(self)
			XPerl_Party_UpdateMana(self)
			XPerl_Party_UpdateHealth(self)
			XPerl_Unit_UpdateLevel(self)
		end

		XPerl_Party_UpdatePlayerFlags(self)
       	XPerl_Party_UpdateCombat(self)
		XPerl_Party_UpdatePVP(self)
		XPerl_Unit_UpdatePortrait(self)
		XPerl_Party_Buff_UpdateAll(self)
		XPerl_Party_UpdateTarget(self)
		XPerl_Unit_UpdateReadyState(self)
		XPerl_UpdateSpellRange(self, self.partyid)
	end
end

-------------------
-- Event Handler --
-------------------
function XPerl_Party_OnEvent(self, event, unit, ...)
	local func = XPerl_Party_Events[event]
	if (func) then
		if (strfind(event, "^UNIT_") and event ~= "UNIT_THREAT_LIST_UPDATE") then
			local f = PartyFrames[unit]
			if (f) then
				func(f, ...)
			end
		else
			func(self, unit, ...)
		end
	else
XPerl_ShowMessage("EXTRA EVENT")
	end
end

-- PARTY_LEADER_CHANGED
function XPerl_Party_Events:PARTY_LEADER_CHANGED()
	for i,frame in pairs(PartyFrames) do
		if (frame.partyid) then
			XPerl_Party_UpdateLeader(frame)
		end
	end
end

XPerl_Party_Events.PARTY_LOOT_METHOD_CHANGED	= XPerl_Party_Events.PARTY_LEADER_CHANGED

-- RAID_TARGET_UPDATE
function XPerl_Party_Events:RAID_TARGET_UPDATE()
	for i,frame in pairs(PartyFrames) do
		if (frame.partyid) then
			XPerl_Party_TargetRaidIcon(frame)
		end
	end
end

-- READY_CHECK
function XPerl_Party_Events:READY_CHECK(a, b, c)
	for i,frame in pairs(PartyFrames) do
		if (frame.partyid) then
			XPerl_Unit_UpdateReadyState(frame)
		end
	end
end

XPerl_Party_Events.READY_CHECK_CONFIRM = XPerl_Party_Events.READY_CHECK
XPerl_Party_Events.READY_CHECK_FINISHED = XPerl_Party_Events.READY_CHECK

-- UNIT_COMBAT
function XPerl_Party_Events:UNIT_COMBAT()
	if (pconf.hitIndicator and pconf.portrait) then
		CombatFeedback_OnCombatEvent(self, arg2, arg3, arg4, arg5)
	end

	XPerl_Party_UpdateCombat(self)
	if (arg2 == "HEAL") then
		XPerl_Party_CombatFlash(self, 0, true, true)
	elseif (arg4 and arg4 > 0) then
		XPerl_Party_CombatFlash(self, 0, true)
	end
end

-- UNIT_SPELLMISS
function XPerl_Party_Events:UNIT_SPELLMISS()
	if (pconf.hitIndicator and pconf.portrait) then
		CombatFeedback_OnSpellMissEvent(self, arg2)
	end
end

-- UNIT_HEALTH, UNIT_MAXHEALTH
function XPerl_Party_Events:UNIT_HEALTH()
	XPerl_Party_UpdateHealth(self)
end

-- PARTY_MEMBER_ENABLE
function XPerl_Party_Events:PARTY_MEMBER_ENABLE()
	for k,v in pairs(PartyFrames) do
		if (v.partyid) then
			XPerl_Party_UpdateDisplay(v)
		end
		--v.afk, v.dnd = nil,nil
		--XPerl_Party_UpdateHealth(v)
		--XPerl_Party_UpdatePlayerFlags(v)
		--XPerl_Party_UpdateCombat(v)
		--XPerl_Party_UpdateTarget(v)
		--XPerl_Party_Buff_UpdateAll(v)	-- 2.2.5 added this because Blizzard aren't sending an update event when you gain/lose buff timers for ppl who go out of range
	end
end

XPerl_Party_Events.PARTY_MEMBER_DISABLE	= XPerl_Party_Events.PARTY_MEMBER_ENABLE

-- UNIT_MAXHEALTH
function XPerl_Party_Events:UNIT_MAXHEALTH()
	XPerl_Party_UpdateHealth(self)
	XPerl_Unit_UpdateLevel(self)	-- Level not available until we've received maxhealth
	XPerl_Party_UpdateClass(self)
end

local function updatePartyThreat(immediate)
	for unitid,frame in pairs(PartyFrames) do
		if (frame:IsShown()) then
			XPerl_Unit_ThreatStatus(frame, nil, immediate)
		end
	end
end

function XPerl_Party_Events:UNIT_THREAT_LIST_UPDATE(unit)
	if (unit == "target") then
		updatePartyThreat()
	end
end

function XPerl_Party_Events:PLAYER_TARGET_CHANGED()
	updatePartyThreat(true)
end

-- PLAYER_ENTERING_WORLD
function XPerl_Party_Events:PLAYER_ENTERING_WORLD()
	UIParent:UnregisterEvent("RAID_ROSTER_UPDATE")	-- Re-do, in case
	if (not startupDone) then
		startupDone = true
		XPerl_ProtectedCall(XPerl_Party_SetInitialAttributes)
		CheckRaid()
	end
	XPerl_Party_Events:PARTY_MEMBER_ENABLE()
end

-- RAID_ROSTER_UPDATED
function XPerl_Party_Events:RAID_ROSTER_UPDATED()
	CheckRaid()
end

-- XPerl_Party_GetUnitFrameByUnit
function XPerl_Party_GetUnitFrameByUnit(unitid)
	return PartyFrames[unitid]
end

do
	local rosterGuids
	-- XPerl_Party_GetUnitFrameByGUID
	function XPerl_Party_GetUnitFrameByGUID(guid)
		local unitid = rosterGuids and rosterGuids[guid]
		if (unitid) then
			return PartyFrames[unitid]
		end
	end

	local function BuildGuidMap()
		if (GetNumPartyMembers() > 0) then
			rosterGuids = XPerl_GetReusableTable()
			for i = 1,GetNumPartyMembers() do
				local guid = UnitGUID("party"..i)
				if (guid) then
					rosterGuids[guid] = "party"..i
				end
			end
		else
			rosterGuids = XPerl_FreeTable(rosterGuids)
		end
	end

	function XPerl_Party_Events:PARTY_MEMBERS_CHANGED()
		BuildGuidMap()
		checkRaidNextUpdate = 3
		CheckRaid()
		UpdateAllAssignedRoles()
	end
end

XPerl_Party_Events.PLAYER_LOGIN = XPerl_Party_Events.PARTY_MEMBERS_CHANGED

-- UNIT_PORTRAIT_UPDATE
function XPerl_Party_Events:UNIT_PORTRAIT_UPDATE()
	XPerl_Unit_UpdatePortrait(self)
end

-- WoW 4.0 UNIT_POWER change. (Added by PlayerLin)
-- New UNIT_Power shit for 4.0 and later.

-- UNIT_POWER / UNIT_MAXPOWER (4.0 and later only)
function XPerl_Party_Events:UNIT_POWER()
        XPerl_Party_UpdateMana(self)
end

XPerl_Party_Events.UNIT_MAXPOWER = XPerl_Party_Events.UNIT_POWER

-- WoW 3.3.5 or older.
-- UNIT_MANA
function XPerl_Party_Events:UNIT_MANA()
	XPerl_Party_UpdateMana(self)
end

XPerl_Party_Events.UNIT_MAXMANA		= XPerl_Party_Events.UNIT_MANA
XPerl_Party_Events.UNIT_RAGE		= XPerl_Party_Events.UNIT_MANA
XPerl_Party_Events.UNIT_MAXRAGE		= XPerl_Party_Events.UNIT_MANA
XPerl_Party_Events.UNIT_ENERGY		= XPerl_Party_Events.UNIT_MANA
XPerl_Party_Events.UNIT_MAXENERGY	= XPerl_Party_Events.UNIT_MANA
XPerl_Party_Events.UNIT_RUNIC_POWER = XPerl_Party_Events.UNIT_MANA
XPerl_Party_Events.UNIT_MAXRUNIC_POWER = XPerl_Party_Events.UNIT_MANA

-- UNIT_DISPLAYPOWER
function XPerl_Party_Events:UNIT_DISPLAYPOWER()
	XPerl_SetManaBarType(self)
	XPerl_Party_UpdateMana(self)
end

-- PLAYER_FLAGS_CHANGED()
function XPerl_Party_Events:PLAYER_FLAGS_CHANGED(unit)
	local f = PartyFrames[unit]
	if (f) then
		XPerl_Party_UpdatePlayerFlags(f)
	end
end

-- UNIT_NAME_UPDATE
function XPerl_Party_Events:UNIT_NAME_UPDATE()
	XPerl_Party_UpdateName(self)
	XPerl_Party_UpdateHealth(self)		-- Flags, class etc. not available until the first UNIT_NAME_UPDATE
	XPerl_Party_UpdateClass(self)
end

-- UNIT_LEVEL
function XPerl_Party_Events:UNIT_LEVEL()
	XPerl_Unit_UpdateLevel(self)
end

-- UNIT_AURA
function XPerl_Party_Events:UNIT_AURA()
	XPerl_Party_Buff_UpdateAll(self)
end

-- UNIT_FACTION
function XPerl_Party_Events:UNIT_FACTION(unit)
	XPerl_Party_UpdateName(self)
	XPerl_Party_UpdateCombat(self)
	XPerl_Party_UpdatePVP(self)
	XPerl_Unit_ThreatStatus(self)
end

XPerl_Party_Events.UNIT_FLAGS = XPerl_Party_Events.UNIT_FACTION
XPerl_Party_Events.UNIT_DYNAMIC_FLAGS = XPerl_Party_Events.UNIT_FACTION

function XPerl_Party_Events:UNIT_TARGET()
	XPerl_Party_UpdateTarget(self)
	updatePartyThreat(true)
end

---- Moving stuff ----
-- XPerl_Party_GetGap
function XPerl_Party_GetGap()
	--return floor(floor((XPerl_party1:GetBottom() - XPerl_party2:GetTop() + 0.01) * 100) / 100)
	return pconf.spacing
end

-- XPerl_Party_SetGap
function XPerl_Party_SetGap(newGap)
	if (type(newGap) ~= "number") then
		return
	end
	pconf.spacing = newGap
	XPerl_Party_SetMainAttributes()
	XPerl_Party_Virtual(true)
end

-- CalcWidth
local function CalcWidth(self)
	--return XPerl_party1Highlight:GetWidth()

	local w = self.statsFrame:GetWidth() or 0

	if (pconf and pconf.portrait) then
		w = w + (self.portraitFrame:GetWidth() or 0) - 2

		if (pconf.level or pconf.classIcon) then
			w = w + (self.levelFrame:GetWidth() or 0) - 2
		end
	else
		w = w + (self.levelFrame:GetWidth() or 0) - 2
	end

	return w
end

-- CalcHeight
local function CalcHeight(self)
	--return XPerl_party1Highlight:GetHeight()

	if (pconf and pconf.portrait) then
		return self.portraitFrame:GetHeight() + 1
	end

	local h = self.statsFrame:GetHeight()

	if (pconf and pconf.name) then
		h = h + self.nameFrame:GetHeight() - 2
	end

	return h
end

-- XPerl_Party_SetWidth
function XPerl_Party_SetWidth(self)

	pconf.size.width = max(0, pconf.size.width or 0)

	local width = (36 * (pconf.percent or 0)) + 106;	-- 136 enabled, 106 disabled
	self.statsFrame:SetWidth(width + pconf.size.width)
	self:SetWidth(CalcWidth(self))

	self.nameFrame:SetWidth(106 + (pconf.size.width / 2))

	XPerl_StatsFrameSetup(self)
end

-- XPerl_Party_Set_Bits
function XPerl_Party_Set_Bits1(self)
	if (InCombatLockdown()) then
		tinsert(XPerl_OutOfCombatQueue, {XPerl_Party_Set_Bits1, self})
		return
	end

	self.portraitFrame:ClearAllPoints()
	self.nameFrame:ClearAllPoints()
	self.levelFrame:ClearAllPoints()
	self.statsFrame:ClearAllPoints()
	self.levelFrame.classTexture:ClearAllPoints()
	self.levelFrame.text:ClearAllPoints()
	self.highlight:ClearAllPoints()

	if (not pconf.portrait) then
		self.portraitFrame:Hide()

		self.levelFrame:SetWidth(30)
		self.levelFrame:SetHeight(41)

		if (pconf.flip) then
			self.nameFrame:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 0)
			self.levelFrame:SetPoint("TOPRIGHT", self.nameFrame, "BOTTOMRIGHT", 0, 3)
			self.statsFrame:SetPoint("TOPRIGHT", self.levelFrame, "TOPLEFT", 2, 0)

			self.levelFrame.text:SetPoint("BOTTOM", self.levelFrame, "BOTTOM", 0, 4)
			self.levelFrame.classTexture:SetPoint("TOPRIGHT", self.levelFrame, "TOPRIGHT", -5, -5)

			self.buffFrame:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", -2, 0)

			self.highlight:SetPoint("TOPRIGHT", self.nameFrame, "TOPRIGHT", 0, 0)
			self.highlight:SetPoint("BOTTOMLEFT", self.statsFrame, "BOTTOMLEFT", 0, 0)
		else
			self.nameFrame:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
			self.levelFrame:SetPoint("TOPLEFT", self.nameFrame, "BOTTOMLEFT", 0, 3)
			self.statsFrame:SetPoint("TOPLEFT", self.levelFrame, "TOPRIGHT", -2, 0)

			self.levelFrame.text:SetPoint("BOTTOM", self.levelFrame, "BOTTOM", 0, 4)
			self.levelFrame.classTexture:SetPoint("TOPLEFT", self.levelFrame, "TOPLEFT", 5, -5)

			self.buffFrame:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 2, 0)

			self.highlight:SetPoint("TOPLEFT", self.nameFrame, "TOPLEFT", 0, 0)
			self.highlight:SetPoint("BOTTOMRIGHT", self.statsFrame, "BOTTOMRIGHT", 0, 0)
		end
	else
		self.portraitFrame:Show()

		self.levelFrame:SetWidth(27)
		self.levelFrame:SetHeight(22)

		if (pconf.flip) then
			self.levelFrame:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 0)
			self.portraitFrame:SetPoint("TOPRIGHT", self.levelFrame, "TOPLEFT", 2, 0)
			self.nameFrame:SetPoint("TOPRIGHT", self.portraitFrame, "TOPLEFT", 2, 0)
			self.statsFrame:SetPoint("TOPRIGHT", self.nameFrame, "BOTTOMRIGHT", 0, 3)

			self.levelFrame.text:SetPoint("CENTER", 0, 0)
			self.levelFrame.classTexture:SetPoint("BOTTOMLEFT", self.portraitFrame, "BOTTOMRIGHT", 0, 3)

			self.buffFrame:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", -2, 0)

			self.highlight:SetPoint("TOPRIGHT", self.levelFrame, "TOPRIGHT", 0, 0)
			self.highlight:SetPoint("BOTTOMLEFT", self.statsFrame, "BOTTOMLEFT", 0, 0)
		else
			self.levelFrame:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
			self.portraitFrame:SetPoint("TOPLEFT", self.levelFrame, "TOPRIGHT", -2, 0)
			self.nameFrame:SetPoint("TOPLEFT", self.portraitFrame, "TOPRIGHT", -2, 0)
			self.statsFrame:SetPoint("TOPLEFT", self.nameFrame, "BOTTOMLEFT", 0, 3)

			self.levelFrame.text:SetPoint("CENTER", 0, 0)
			self.levelFrame.classTexture:SetPoint("BOTTOMRIGHT", self.portraitFrame, "BOTTOMLEFT", 0, 3)

			self.buffFrame:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 2, 0)

			self.highlight:SetPoint("TOPLEFT", self.levelFrame, "TOPLEFT", 0, 0)
			self.highlight:SetPoint("BOTTOMRIGHT", self.statsFrame, "BOTTOMRIGHT", 0, 0)
		end
	end

	if (pconf.level) then
		self.levelFrame.text:Show()
		self.levelFrame:Show()

		if (pconf.portrait) then
			self.levelFrame:SetWidth(27)
		else
			self.levelFrame:SetWidth(30)
		end
	else
		self.levelFrame.text:Hide()
	end

	if (pconf.classIcon) then
		self.levelFrame.classTexture:Show()
		self.levelFrame:Show()

		if (pconf.portrait) then
			self.levelFrame:SetWidth(27)
		else
			self.levelFrame:SetWidth(30)
		end
	else
		self.levelFrame.classTexture:Hide()

		if (not pconf.level) then
			self.levelFrame:SetWidth(2)
			self.levelFrame:Hide()
		end
	end

	ShowHideValues(self)

	if (pconf.percent) then
		self.statsFrame.healthBar.percent:Show()
		self.statsFrame.manaBar.percent:Show()
	else
		self.statsFrame.healthBar.percent:Hide()
		self.statsFrame.manaBar.percent:Hide()
	end

	local height = ((pconf.name or 0) * 22) + 2;		-- 24 when enabled, 2 when disabled

	self.targetFrame:ClearAllPoints()
	self.nameFrame:SetHeight(height)

	if (pconf.name) then
		self.nameFrame:Show()
		if (pconf.flip) then
			self.targetFrame:SetPoint("BOTTOMRIGHT", self.nameFrame, "BOTTOMLEFT", 2, 0)
		else
			self.targetFrame:SetPoint("BOTTOMLEFT", self.nameFrame, "BOTTOMRIGHT", -2, 0)
		end
	else
		self.nameFrame:Hide()
		if (pconf.flip) then
			self.targetFrame:SetPoint("TOPRIGHT", self.statsFrame, "BOTTOMRIGHT", 2, 0)
		else
			self.targetFrame:SetPoint("TOPLEFT", self.statsFrame, "BOTTOMLEFT", -2, 0)
		end
	end

	if (pconf.target.large) then
		self.targetFrame.healthBar.text:SetTextColor(1, 1, 1)
		self.targetFrame:SetHeight(28)
		self.targetFrame.healthBar:Show()
	else
		self.targetFrame:SetHeight(20)
		self.targetFrame.healthBar:Hide()
	end

	self.targetFrame:SetWidth(pconf.target.size)

	pconf.buffs.size = tonumber(pconf.buffs.size) or 20
	XPerl_SetBuffSize(self)

	local function SetAllBuffs(self, buffs, debuff)
		local prevAnchor
		if (pconf.flip) then
			prevAnchor = "TOPRIGHT"
		else
			prevAnchor = "TOPLEFT"
		end
		if (buffs) then
			local prev = self
			for k,v in pairs(buffs) do
				v:ClearAllPoints()
				if (pconf.flip) then
					v:SetPoint("TOPRIGHT", prev, prevAnchor, -(1 + debuff), 0)
				else
					v:SetPoint("TOPLEFT", prev, prevAnchor, 1 + debuff, 0)
				end
				prev = v
				if (pconf.flip) then
					prevAnchor = "TOPLEFT"
				else
					prevAnchor = "TOPRIGHT"
				end
			end
		end
	end

	if (not pconf.debuffs.halfSize) then
		self.debuffFrame:SetScale(1)
	end
	SetAllBuffs(self.debuffFrame, self.buffFrame.debuff, 1)
	SetAllBuffs(self.buffFrame, self.buffFrame.buff, 0)

	self.buffOptMix = nil
	self.debuffFrame:SetScale(1)
	XPerl_Party_BuffPositions(self)

	XPerl_Party_SetWidth(self)

	if (pconf.target.enable) then
		RegisterUnitWatch(self.targetFrame)
	else
		UnregisterUnitWatch(self.targetFrame)
		self.targetFrame:Hide()
	end

	if (self:IsShown()) then
		XPerl_Party_UpdateDisplay(self)
	end

	--XPerl_SetTextTransparencyFrame(self)

	--if (conf.ShowPartyPets == 1 and XPerl_PartyPetFrames) then
	--	if (not self.petFrame) then
	--		self.petFrame = CreateFrame("Button", "XPerl_partypet"..self:GetID(), self, "XPerl_Party_Pet_FrameTemplate")
	--	end

	self.petFrame = getglobal("XPerl_partypet"..self:GetID())
	if (self.petFrame) then
		self.petFrame:ClearAllPoints()
		if (pconf.flip) then
			self.petFrame:SetPoint("TOPRIGHT", self.statsFrame, "TOPLEFT", 2, 0)
		else
			self.petFrame:SetPoint("TOPLEFT", self.statsFrame, "TOPRIGHT", -2, 0)
		end
	end

	if (XPerl_Voice) then
		XPerl_Voice:Register(self, true)
	end
end

-- XPerl_Party_SetInitialAttributes()
function XPerl_Party_SetInitialAttributes()

	--partyHeader.initialConfigFunction = function(self)
	--	-- This is the only place we're allowed to set attributes whilst in combat
	--
	--	self:SetAttribute("*type1", "target")
	--	self:SetAttribute("type2", "menu")
	--	self.menu = XPerl_ShowGenericMenu
	--	XPerl_RegisterClickCastFrame(self)
	--
	--	-- Does AllowAttributeChange work for children?
	--	self.nameFrame:SetAttribute("useparent-unit", true)
	--	self.nameFrame:SetAttribute("*type1", "target")
	--	self.nameFrame:SetAttribute("type2", "menu")
	--	self.nameFrame.menu = XPerl_ShowGenericMenu
	--	XPerl_RegisterClickCastFrame(self.nameFrame)
	--
	--	--self:SetAttribute("initial-height", CalcHeight())
	--	--self:SetAttribute("initial-width", CalcWidth())
	--end

	partyHeader:Hide()
	XPerl_Party_SetMainAttributes()
	CheckRaid()
end

-- XPerl_Party_SetMainAttributes
function XPerl_Party_SetMainAttributes()

	partyAnchor:StopMovingOrSizing()

	partyHeader:ClearAllPoints()
	if (pconf.anchor == "TOP") then
		partyHeader:SetPoint("TOPLEFT", partyAnchor, "TOPLEFT", 0, 0)
		partyHeader:SetAttribute("xOffset", 0)
		partyHeader:SetAttribute("yOffset", -pconf.spacing)
	elseif (pconf.anchor == "LEFT") then
		partyHeader:SetPoint("TOPLEFT", partyAnchor, "TOPLEFT", 0, 0)
		partyHeader:SetAttribute("xOffset", pconf.spacing)
		partyHeader:SetAttribute("yOffset", 0)
	elseif (pconf.anchor == "BOTTOM") then
		partyHeader:SetPoint("BOTTOMLEFT", partyAnchor, "BOTTOMLEFT", 0, 0)
		partyHeader:SetAttribute("xOffset", 0)
		partyHeader:SetAttribute("yOffset", pconf.spacing)
	elseif (pconf.anchor == "RIGHT") then
		partyHeader:SetPoint("BOTTOMRIGHT", partyAnchor, "BOTTOMRIGHT", 0, 0)
		partyHeader:SetAttribute("xOffset", -pconf.spacing)
		partyHeader:SetAttribute("yOffset", 0)
	end

	partyHeader:SetAttribute("point", pconf.anchor or "TOP")
end

-- XPerl_Party_Virtual
function XPerl_Party_Virtual(on)
	local virtual = XPerl_Party_AnchorVirtual
	if (on) then
		local w = CalcWidth(XPerl_party1)
		local h = CalcHeight(XPerl_party1)

		virtual:ClearAllPoints()
		if (pconf.anchor == "TOP") then
			virtual:SetPoint("TOPLEFT", partyAnchor, "TOPLEFT", 0, 0)
			virtual:SetHeight((h * 4) + (pconf.spacing * 3))
			virtual:SetWidth(w)

		elseif (pconf.anchor == "LEFT") then
			virtual:SetPoint("TOPLEFT", partyAnchor, "TOPLEFT", 0, 0)
			virtual:SetHeight(h)
			virtual:SetWidth(w * 4 + (pconf.spacing * 3))

		elseif (pconf.anchor == "BOTTOM") then
			virtual:SetPoint("BOTTOMLEFT", partyAnchor, "BOTTOMLEFT", 0, 0)
			virtual:SetHeight((h * 4) + (pconf.spacing * 3))
			virtual:SetWidth(w)

		elseif (pconf.anchor == "RIGHT") then
			virtual:SetPoint("TOPRIGHT", partyAnchor, "TOPRIGHT", 0, 0)
			virtual:SetHeight(h)
			virtual:SetWidth(w * 4 + (pconf.spacing * 3))
		end

		virtual:SetBackdropColor(0, 0, 0, 1)
		virtual:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
		virtual:Lower()
		virtual:Show()
	else
		virtual:Hide()
	end
end

-- XPerl_Party_Set_Bits
function XPerl_Party_Set_Bits()
	if (InCombatLockdown()) then
		tinsert(XPerl_OutOfCombatQueue, XPerl_Party_Set_Bits)
		return
	end

	partyAnchor:SetScale(pconf.scale)
	XPerl_SavePosition(partyAnchor, true)

	if (XPerlDB) then
		conf = XPerlDB
		pconf = XPerlDB.party
		for k,v in pairs(PartyFrames) do
			v.conf = pconf
			XPerl_Party_Set_Bits1(v)
		end
	end

	if (startupDone) then
		partyHeader:Hide()
		XPerl_Party_SetMainAttributes()
		CheckRaid()
	end
	XPerl_Party_SetInitialAttributes()

	if (XPerl_Party_AnchorVirtual:IsShown()) then
		XPerl_Party_Virtual(true)
	end
	UpdateAllAssignedRoles()
end
