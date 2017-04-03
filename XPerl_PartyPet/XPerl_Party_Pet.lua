-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

local XPerl_Party_Pet_Events = {}
local conf, pconf, petconf
XPerl_PartyPetFrames = {}
local PartyPetFrames = XPerl_PartyPetFrames
XPerl_RequestConfig(function(New) conf = New
			pconf = New.party
			petconf = New.partypet
			for k,v in pairs(PartyPetFrames) do
				v.conf = pconf
			end
		end, "$Revision: 374 $")

local new, del, copy = XPerl_GetReusableTable, XPerl_FreeTable, XPerl_CopyTable

local AllPetFrames = {}
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

local XPerl_Player_Pet_HighlightCallback

----------------------
-- Loading Function --
----------------------
function XPerl_Party_Pet_OnLoadEvents(self)
	self.time = 0

	--self:RegisterEvent("PARTY_MEMBERS_CHANGED")
	local events = {"UNIT_COMBAT", "UNIT_FACTION", "UNIT_AURA", "UNIT_DYNAMIC_FLAGS", "UNIT_FLAGS",
			"UNIT_HEALTH", "UNIT_MAXHEALTH", "PLAYER_ENTERING_WORLD"}

	for k,v in pairs(events) do
		self:RegisterEvent(v)
	end

	-- Set here to reduce amount of function calls made
	self:SetScript("OnEvent", XPerl_Party_Pet_OnEvent)
	self:SetScript("OnUpdate", XPerl_Party_Pet_OnUpdate)

	XPerl_RegisterOptionChanger(XPerl_Party_Pet_Set_Bits, "PartyPet")

	XPerl_Highlight:Register(XPerl_Party_Pet_HighlightCallback, self)

	XPerl_Party_Pet_OnLoadEvents = nil
end

local XPerl_Party_Pet_UpdateGUIDs
do
	local guids
	-- XPerl_Party_Pet_UpdateGUIDs
	function XPerl_Party_Pet_UpdateGUIDs()
		del(guids)
		guids = new()
		for i = 1,GetNumPartyMembers() do
			local id = "partypet"..i
			if (UnitExists(id)) then
				guids[UnitGUID(id)] = PartyPetFrames[id]
			end
		end
	end

	-- XPerl_Party_Pet_GetUnitFrameByGUID
	function XPerl_Party_Pet_GetUnitFrameByGUID(guid)
		return guids and guids[guid]
	end

	-- XPerl_Party_Pet_HighlightCallback
	function XPerl_Party_Pet_HighlightCallback(self, updateGUID)
		local f = guids and guids[updateGUID]
		if (f) then
			XPerl_Highlight:SetHighlight(f, updateGUID)
		end
	end
end

-- XPerl_Party_Pet_GetUnitFrameByUnit
function XPerl_Party_Pet_GetUnitFrameByUnit(unitid)
	return PartyPetFrames[unitid]
end

-- CheckVisiblity()
local function CheckVisiblity()
	local on
	for i,frame in pairs(PartyPetFrames) do
		if (frame:IsShown()) then
			on = true
		end
	end

	if (on) then
		XPerl_Party_Pet_EventFrame:Show()
	else
		XPerl_Party_Pet_EventFrame:Hide()
	end
end

-- XPerl_Party_Pet_OnLoad
function XPerl_Party_Pet_OnLoad(self)
	XPerl_SetChildMembers(self)

	tinsert(AllPetFrames, self)

	local BuffOnUpdate, DebuffOnUpdate, BuffUpdateTooltip, DebuffUpdateTooltip
	BuffUpdateTooltip = XPerl_Unit_SetBuffTooltip
	DebuffUpdateTooltip = XPerl_Unit_SetDeBuffTooltip

	if (self:GetID() > 1) then
		self.buffSetup = XPerl_partypet1.buffSetup
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
			debuffSizeMod = 0,
			debuffAnchor1 = function(self, b)
						local relation = self.buffFrame.buff and self.buffFrame.buff[1]
						if (not relation) then
							relation = XPerl_GetBuffButton(self, 1, 0, 1)
						end
						if (relation) then
							if (pconf.flip) then
								b:SetPoint("TOPRIGHT", relation, "BOTTOMRIGHT", 0, 0)
							else
								b:SetPoint("TOPLEFT", relation, "BOTTOMLEFT", 0, 0)
							end
						else
							if (pconf.flip) then
								b:SetPoint("TOPRIGHT", 0, -14)
							else
								b:SetPoint("TOPLEFT", 0, -14)
							end
						end
					end,
			buffAnchor1 =	function(self, b)
						if (pconf.flip) then
							b:SetPoint("TOPRIGHT", 0, 0)
						else
							b:SetPoint("TOPLEFT", 0, 0)
						end
					end,
		}
	end

	XPerl_SecureUnitButton_OnLoad(self)
	XPerl_SecureUnitButton_OnLoad(self.nameFrame)

	self:SetAttribute("useparent-unit", true)
	self:SetAttribute("unitsuffix", "pet")
	self.nameFrame:SetAttribute("useparent-unit", true)
	self.nameFrame:SetAttribute("unitsuffix", "pet")

	XPerl_RegisterHighlight(self.highlight, 2)
	XPerl_RegisterPerlFrames(self, {self.nameFrame, self.statsFrame})

	self.FlashFrames = {self.nameFrame, self.statsFrame}

	self:SetScript("OnShow",
		function(self)
			self.conf = conf.partypet
			CheckVisiblity()
			XPerl_Party_Pet_UpdateDisplay(self)
			XPerl_Party_SetDebuffLocation(self:GetParent())
		end)
	self:SetScript("OnHide",
		function(self)
			CheckVisiblity()
			XPerl_Party_SetDebuffLocation(self:GetParent())
		end)

	self.time = 0
	self.tutorialPage = 5

	if (XPerlDB) then
		self.conf = conf.partypet
	end

	--XPerl_Party_Pet_Set_Bits1(self)
end

-- XPerl_Party_Pet_CheckPet
-- returns true if full update required (frame shown)

-- XPerl_Party_Pet_UpdateName
local function XPerl_Party_Pet_UpdateName(self)
	if (self.partyid) then
		local Partypetname = UnitName(self.partyid)
		if (Partypetname ~= nil) then
			self.nameFrame.text:SetText(Partypetname)
			if (UnitIsPVP(self.ownerid)) then
				self.nameFrame.text:SetTextColor(0,1,0)
			else
				self.nameFrame.text:SetTextColor(0.5,0.5,1)
			end
		end
	end
end

-- XPerl_Party_Pet_UpdateHealth
function XPerl_Party_Pet_UpdateHealth(self)
	if (not self.partyid) then
		return
	end

	local Partypethealth, Partypethealthmax = XPerl_UnitHealth(self.partyid), UnitHealthMax(self.partyid)
	local healthPct = Partypethealth / Partypethealthmax
	local phealthPct = format("%3.0f", healthPct * 100)

	self.statsFrame.healthBar:SetMinMaxValues(0, Partypethealthmax)
	self.statsFrame.healthBar:SetValue(Partypethealth)
	XPerl_ColourHealthBar(self, healthPct)

	XPerl_SetExpectedHealth(self)

	if (UnitIsDead(self.partyid)) then
		self.statsFrame:SetGrey()
		self.statsFrame.healthBar.text:SetText(XPERL_LOC_DEAD)
	else
		if (pconf.healerMode.enable) then
			if (pconf.healerMode.type == 1) then
				self.statsFrame.healthBar.text:SetFormattedText("%d/%d", Partypethealth - Partypethealthmax, Partypethealthmax)
			else
				self.statsFrame.healthBar.text:SetText(Partypethealth - Partypethealthmax)
			end
		else
			self.statsFrame.healthBar.text:SetFormattedText("%d%%",(100*(Partypethealth / Partypethealthmax))+0.5)
		end

		self.statsFrame.healthBar.text:Show()

		if (self.statsFrame.greyMana) then
			self.statsFrame.greyMana = nil
			XPerl_SetManaBarType(self)
		end
	end
end

-- XPerl_Party_UpdateHealthByUnitID
function XPerl_Party_Pet_UpdateHealthByUnitID(unit)
	local f = PartyPetFrames[unit]
	if (f) then
		XPerl_Party_Pet_UpdateHealth(f)
	end
end

-- XPerl_Party_Pet_UpdateMana
local function XPerl_Party_Pet_UpdateMana(self)
	if (self.partyid) then
		local Partypetmana = UnitMana(self.partyid)
		local Partypetmanamax = UnitManaMax(self.partyid)

		self.statsFrame.manaBar:SetMinMaxValues(0, Partypetmanamax)
		self.statsFrame.manaBar:SetValue(Partypetmana)

		pmanaPct = (Partypetmana * 100.0) / Partypetmanamax
		pmanaPct =  format("%3.0f", pmanaPct)
		if (UnitPowerType(self.partyid) >= 1) then
			self.statsFrame.manaBar.text:SetText(Partypetmana)
		else
			self.statsFrame.manaBar.text:SetFormattedText("%d%%",(100*(Partypetmana / Partypetmanamax))+0.5)
		end
	end
end

--------------------
-- Buff Functions --
--------------------

-- XPerl_Party_Pet_Buff_UpdateAll
function XPerl_Party_Pet_Buff_UpdateAll(self)
	if (self.partyid) then
		if (petconf.buffs.enable) then
			if (UnitExists(self.partyid)) then
				self.buffFrame:Show()
				if (XPerlDB) then
					if (not self.conf) then
						self.conf = conf.partypet
					end
	
					XPerl_Unit_UpdateBuffs(self, nil, nil, petconf.buffs.castble, petconf.debuffs.curable)
				end
			else
				self.buffFrame:Hide()
			end
		else
			self.buffFrame:Hide()
		end

		XPerl_CheckDebuffs(self, self.partyid)
	end
end

-- XPerl_Party_Pet_UpdateDisplayAll
function XPerl_Party_Pet_UpdateDisplayAll()
	for i,frame in pairs(PartyPetFrames) do
		if (frame:IsShown()) then
			XPerl_Party_Pet_UpdateDisplay(frame)
		end
	end
end

-- XPerl_Party_Pet_UpdateDisplay
function XPerl_Party_Pet_UpdateDisplay(self)
	if (self.partyid) then
		XPerl_Party_Pet_UpdateName(self)
		XPerl_Party_Pet_UpdateHealth(self)
		XPerl_Unit_UpdateLevel(self)
		XPerl_SetManaBarType(self)
		XPerl_Party_Pet_UpdateMana(self)
		XPerl_Party_Pet_UpdateCombat(self)
		XPerl_Party_Pet_Buff_UpdateAll(self)
		XPerl_UpdateSpellRange(self)
	end
end

--------------------
-- Click Handlers --
--------------------

-- XPerl_Party_Pet_Update_Control
local function XPerl_Party_Pet_Update_Control(self)
	if (self.partyid and UnitIsVisible(self.partyid) and UnitIsCharmed(self.partyid) and not UnitUsingVehicle(self.ownerid)) then
		self.nameFrame.warningIcon:Show()
	else
		self.nameFrame.warningIcon:Hide()
	end
end

-- XPerl_Party_Pet_UpdateCombat
function XPerl_Party_Pet_UpdateCombat(self)
	if (self.partyid and UnitIsVisible(self.partyid) and UnitAffectingCombat(self.partyid)) then
		self.nameFrame.level:Hide()
		self.nameFrame.combatIcon:Show()
	else
		self.nameFrame.combatIcon:Hide()
		if (petconf.level) then
			self.nameFrame.level:Show()
		end
	end
	XPerl_Party_Pet_Update_Control(self)
end

-- XPerl_Party_Pet_CombatFlash
local function XPerl_Party_Pet_CombatFlash(self, elapsed, argNew, argGreen)
	if (XPerl_CombatFlashSet (self, elapsed, argNew, argGreen)) then
		XPerl_CombatFlashSetFrames(self)
	end
end

-- XPerl_Party_Pet_OnUpdate
function XPerl_Party_Pet_OnUpdate(self, elapsed)
	for i,f in pairs(PartyPetFrames) do
		if (f:IsShown()) then
			if (f.PlayerFlash) then
				XPerl_Party_Pet_CombatFlash(f, arg1, false)
			end
			f.time = f.time + elapsed
			if (f.time > 0.2) then
				f.time = 0
				XPerl_UpdateSpellRange(f, nil, false)
			end
		end
	end
end

-------------------
-- Event Handler --
-------------------

-- XPerl_Party_Pet_OnEvent
function XPerl_Party_Pet_OnEvent(self, event, unit, ...)
	local func = XPerl_Party_Pet_Events[event]
	if (func) then
		if (strfind(event, "^UNIT_")) then
			local f = PartyPetFrames[unit]
			if (f) then
				func(f, ...)
			end
		else
			func(unit, ...)
		end
	else
XPerl_ShowMessage("EXTRA EVENT")
	end
end

-- UNIT_COMBAT
function XPerl_Party_Pet_Events:UNIT_COMBAT()
	if (arg2 == "HEAL") then
		XPerl_Party_Pet_CombatFlash(self, 0, true, true)
	elseif (arg4 and arg4 > 0) then
		XPerl_Party_Pet_CombatFlash(self, 0, true)
	end
end

-- PLAYER_ENTERING_WORLD
function XPerl_Party_Pet_Events:PLAYER_ENTERING_WORLD()
	XPerl_Party_Pet_UpdateGUIDs()
end
XPerl_Party_Pet_Events.PARTY_MEMBERS_CHANGED = XPerl_Party_Pet_Events.PLAYER_ENTERING_WORLD
XPerl_Party_Pet_Events.UNIT_PET = XPerl_Party_Pet_Events.PLAYER_ENTERING_WORLD

-- UNIT_FLAGS
function XPerl_Party_Pet_Events:UNIT_FLAGS()
	XPerl_Party_Pet_UpdateCombat(self)
end

XPerl_Party_Pet_Events.UNIT_DYNAMIC_FLAGS = XPerl_Party_Pet_Events.UNIT_FLAGS

-- UNIT_NAME_UPDATE
function XPerl_Party_Pet_Events:UNIT_NAME_UPDATE()
	XPerl_Party_Pet_UpdateGUIDs()
	XPerl_Party_Pet_UpdateName(self)
end

-- UNIT_FACTION
function XPerl_Party_Pet_Events:UNIT_FACTION()
	XPerl_Party_Pet_UpdateName(self)
	XPerl_Party_Pet_UpdateCombat(self)
end

-- UNIT_LEVEL
function XPerl_Party_Pet_Events:UNIT_LEVEL()
	XPerl_Unit_UpdateLevel(self)
end

-- UNIT_HEALTH
function XPerl_Party_Pet_Events:UNIT_HEALTH()
	XPerl_Party_Pet_UpdateHealth(self)
end

-- UNIT_MAXHEALTH
function XPerl_Party_Pet_Events:UNIT_MAXHEALTH()
	XPerl_Party_Pet_UpdateHealth(self)
	XPerl_Unit_UpdateLevel(self)
end

-- UNIT_AURA
function XPerl_Party_Pet_Events:UNIT_AURA()
	XPerl_Party_Pet_Buff_UpdateAll(self)
end

-- UNIT_DISPLAYPOWER
function XPerl_Party_Pet_Events:UNIT_DISPLAYPOWER()
	XPerl_SetManaBarType(self)
end

-- UNIT_MANA
function XPerl_Party_Pet_Events:UNIT_MANA()
	XPerl_Party_Pet_UpdateMana(self)
end

XPerl_Party_Pet_Events.UNIT_MAXMANA	= XPerl_Party_Pet_Events.UNIT_MANA
XPerl_Party_Pet_Events.UNIT_RAGE	= XPerl_Party_Pet_Events.UNIT_MANA
XPerl_Party_Pet_Events.UNIT_MAXRAGE	= XPerl_Party_Pet_Events.UNIT_MANA
XPerl_Party_Pet_Events.UNIT_FOCUS	= XPerl_Party_Pet_Events.UNIT_MANA
XPerl_Party_Pet_Events.UNIT_MAXFOCUS	= XPerl_Party_Pet_Events.UNIT_MANA
XPerl_Party_Pet_Events.UNIT_ENERGY	= XPerl_Party_Pet_Events.UNIT_MANA
XPerl_Party_Pet_Events.UNIT_MAXENERGY	= XPerl_Party_Pet_Events.UNIT_MANA

-- EnableDisable()
local function EnableDisable(self)
	if (petconf.enable) then
		RegisterUnitWatch(self)
	else
		UnregisterUnitWatch(self)
		self:Hide()
	end
end

-- XPerl_Party_Pet_Set_Bits1
function XPerl_Party_Pet_Set_Bits1(self)
	if (not self:GetParent()) then
		self:SetParent(_G["XPerl_party"..self:GetID()])
	end

	if (petconf.name) then
		self.nameFrame:Show()
		self.nameFrame:SetHeight(20)
	else
		self.nameFrame:Hide()
		self.nameFrame:SetHeight(4)
	end

	if (petconf.mana) then
		self:SetHeight(50)
		self.statsFrame:SetHeight(33)
		self.statsFrame.manaBar:Show()
		if (petconf.percent) then
			self.statsFrame.manaBar.text:Show()
		else
			self.statsFrame.manaBar.text:Hide()
		end
	else
		self:SetHeight(40)
		self.statsFrame:SetHeight(23)
		self.statsFrame.manaBar:Hide()
	end

	if (petconf.level) then
		self.nameFrame.level:Show()
	else
		self.nameFrame.level:Hide()
	end

	self:SetScale(petconf.scale)

	XPerl_StatsFrameSetup(self)

	if (self:IsShown()) then
		XPerl_Party_Pet_UpdateDisplay(self)
	end

	local function SetAllBuffs(self, buffs)
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
					v:SetPoint("TOPRIGHT", prev, prevAnchor, 0, 0)
				else
					v:SetPoint("TOPLEFT", prev, prevAnchor, 0, 0)
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

	SetAllBuffs(self.buffFrame, self.buffFrame.debuff)
	SetAllBuffs(self.buffFrame, self.buffFrame.buff)
	local b = self.buffFrame.buff and self.buffFrame.buff[1]
	local d = self.buffFrame.debuff and self.buffFrame.debuff[1]
	if (b and d) then
		if (pconf.flip) then
			d:SetPoint("TOPRIGHT", b, "BOTTOMRIGHT", 0, 0)
		else
			d:SetPoint("TOPLEFT", b, "BOTTOMLEFT", 0, 0)
		end
	end

	XPerl_ProtectedCall(EnableDisable, self)
end

-- XPerl_Party_Pet_Set_Bits
function XPerl_Party_Pet_Set_Bits()
	for k,v in pairs(AllPetFrames) do
		XPerl_Party_Pet_Set_Bits1(v)
	end

	local function RegisterEvents(self, enable, events)
		for k,v in pairs(events) do
			if (enable) then
				self:RegisterEvent(v)
			else
				self:UnregisterEvent(v)
			end
		end
	end

	RegisterEvents(XPerl_Party_Pet_EventFrame, petconf.mana, {"UNIT_RAGE", "UNIT_MAXRAGE", "UNIT_ENERGY", "UNIT_MAXENERGY",
										"UNIT_MANA", "UNIT_MAXMANA", "UNIT_DISPLAYPOWER"})
	RegisterEvents(XPerl_Party_Pet_EventFrame, petconf.name, {"UNIT_NAME_UPDATE"})
	RegisterEvents(XPerl_Party_Pet_EventFrame, petconf.name and petconf.level, {"UNIT_LEVEL"})
end
