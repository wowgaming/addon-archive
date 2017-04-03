-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

local cast
local MonUnits = {}			-- Fixed list of all monitor units
local TableUnits = {}			-- Dynamic list of units indexed by raid id, changed on attr change
XPerlRaidMonConfig = {}
local config = XPerlRaidMonConfig

XPerl_SetModuleRevision("$Revision: 374 $")

XPERL_RAIDMON_UNIT_WIDTH_MIN = 50
XPERL_RAIDMON_UNIT_WIDTH_MAX = 150
XPERL_RAIDMON_UNIT_HEIGHT_MIN = 9
XPERL_RAIDMON_UNIT_HEIGHT_MAX = 20
XPERL_RAIDMON_TARGET_WIDTH_MIN = 50
XPERL_RAIDMON_TARGET_WIDTH_MAX = 150

local castColours = {
	main    = {r = 1.0, g = 0.7, b = 0.0},
	channel = {r = 0.0, g = 1.0, b = 0.0},
	success = {r = 0.0, g = 1.0, b = 0.0},
	failure = {r = 1.0, g = 0.0, b = 0.0}
}

-- XPerl_RaidMonitor_OnLoad
function XPerl_RaidMonitor_OnLoad(self)

	cast = self
	XPerl_RaidMonitor_Init(self)

	self:RegisterEvent("VARIABLES_LOADED")
	self:SetScript("OnEvent", XPerl_RaidMonitor_OnEvent)
	self:SetScript("OnUpdate", self.OnUpdate)

	if (XPerl_RegisterPerlFrames) then
		XPerl_RegisterPerlFrames(XPerl_RaidMonitor_Frame)
	end

	if (XPerl_SavePosition) then
		XPerl_SavePosition(XPerl_RaidMonitor_Anchor, true)
	end

	XPerl_RegisterScalableFrame(self, XPerl_RaidMonitor_Anchor)

	XPerl_RaidMonitor_OnLoad = nil
end

-- ScaleBarColour
local function ScaleBarColour(self, perc, cOrder)
	if (not cOrder) then
		cOrder = "rgb"
	end

	local c = {0, 0, 0}
	if (perc < 0.5) then
		c[strfind(cOrder, "r")] = 1
		c[strfind(cOrder, "g")] = 2 * perc
		c[strfind(cOrder, "b")] = 0
	else
		c[strfind(cOrder, "r")] = 2 * (1 - perc)
		c[strfind(cOrder, "g")] = 1
		c[strfind(cOrder, "b")] = 0
	end

	self:SetStatusBarColor(unpack(c))
	self.bg:SetVertexColor(c[1], c[2], c[3], 0.5)
end

-- CastBar_OnUpdate
local function CastBar_OnUpdate(self)

	if (self.casting) then
		local status = GetTime()
		if (status > self.maxValue) then
			self.castBar:SetStatusBarColor(castColours.success.r, castColours.success.g, castColours.success.b)
			self.casting = nil

			status = self.maxValue
			self.castBar:SetValue(status)

			self.fadeOut = 1
			return
		end
		self.castBar:SetValue(status)

		local sparkPosition = ((status - self.startTime) / (self.maxValue - self.startTime)) * self.castBar:GetWidth()
		if ( sparkPosition < 0 ) then
			sparkPosition = 0
		end
		self.castBar.spark:SetPoint("CENTER", self.castBar, "LEFT", sparkPosition, 1)

	elseif (self.channeling) then
		local time = GetTime()
		if (time >= self.endTime) then
			self.channeling = nil

			self.holdTime = 0
			self.fadeOut = 1
			return
		end
		local barValue = self.startTime + (self.endTime - time)
		self.castBar:SetValue( barValue )

		local sparkPosition = ((barValue - self.startTime) / (self.endTime - self.startTime)) * self.castBar:GetWidth()
		self.castBar.spark:SetPoint("CENTER", self.castBar, "LEFT", sparkPosition, 1)

	elseif (self.fadeOut) then
		local alpha = self.castBar:GetAlpha() - CASTING_BAR_ALPHA_STEP
		if (alpha > 0) then
			self.castBar:SetAlpha(alpha)
			self.bar.name:SetAlpha(1 - alpha)
			self.bar.name:Show()
		else
			self.bar.name:SetAlpha(1)
			self.bar.name:Show()
			self.fadeOut = nil
			self.castBar:Hide()
		end
	end
end

-- UpdateTarget
local function UpdateTarget(self)
	local id = SecureButton_GetUnit(self)
	if (id) then
		local subid = strmatch(id, "^(raid%d+)")
		if (UnitIsUnit("player", subid)) then
			id = "target"
		end

		local name, reason
		if (not UnitIsConnected(subid)) then
			reason = XPERL_LOC_OFFLINE
		elseif (UnitIsDead(subid)) then
			reason = XPERL_LOC_DEAD
		elseif (UnitIsGhost(subid)) then
			reason = XPERL_LOC_GHOST
		elseif (not UnitIsVisible(subid)) then
			reason = XPERL_LOC_OOR
		else
			name = UnitName(id)
			if (not name) then
				reason = XPERL_NO_TARGET
			end
		end

		if (not name) then
			self.bar.name:SetText(reason)
			self.bar.name:SetTextColor(0.5, 0.5, 0.5)

			self.bar:SetMinMaxValues(0, 1)
			self.bar:SetValue(0)
			self.bar:SetStatusBarColor(0, 0, 0)
			self.bar.bg:SetVertexColor(0, 0, 0, 0.5)
		else
			self.bar.name:SetText(name)
			if (UnitIsUnit("target", id)) then
				self.bar.name:SetTextColor(0, 1, 0)
			else
				self.bar.name:SetTextColor(0.5, 0.5, 0.5)
			end

			local hp, hpMax = UnitHealth(id), UnitHealthMax(id)
			self.bar:SetMinMaxValues(0, hpMax)
			self.bar:SetValue(hp)

			local class = select(2, UnitClass(id))
			if (class) then
				local c = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
				if (c) then
					self.bar:SetStatusBarColor(c.r, c.g, c.b)
					self.bar.bg:SetVertexColor(c.r, c.g, c.b, 0.5)
				end
			end
		end
	end
end

-- UpdateUnit
local function UpdateUnit(self)
	local id = SecureButton_GetUnit(self)
	if (id) then
		self.bar.name:SetText(UnitName(id))

		self.powerType = UnitPowerType(id)
		self.mana, self.manaMax = UnitMana(id), UnitManaMax(id)
		self.bar:SetMinMaxValues(0, self.manaMax)
		self.bar:SetValue(self.mana)

		if (UnitInParty(id)) then
			self.groupedIcon:Show()
		else
			self.groupedIcon:Hide()
		end

		if (not UnitIsConnected(id) or UnitIsDeadOrGhost(id) or not UnitIsVisible(id)) then
			self.bar:SetStatusBarColor(0.5, 0.5, 0.5)
			self.bar.bg:SetVertexColor(0.5, 0.5, 0.5, 0.5)
		else
			ScaleBarColour(self.bar, self.mana / self.manaMax, "rbg")
		end

		local class = select(2, UnitClass(id))
		if (class) then
			local c = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
			if (c) then
				self.bar.name:SetTextColor(c.r, c.g, c.b)
			end
		end

		UpdateTarget(self.target)
	end
end

-- UpdateAllUnits()
local function UpdateAllUnits()
	for k,v in pairs(MonUnits) do
		UpdateUnit(v)
	end
end

-- SetTableUnit(value, self)
local function SetTableUnit(value, self)
	for k,v in pairs(TableUnits) do
		if (v == self) then
			TableUnits[k] = nil
		end
	end

	TableUnits[value] = self
end

-- onAttrChanged
local function onAttrChanged(self, name, value)
	if (name == "unit") then
		if (value) then
			self:SetAttribute("unit2", value)
			SetTableUnit(value, self)
			UpdateUnit(self)
			self.doneMana = false
		end
	end
end

-- XPerl_MTList_ChildUnits
function XPerl_CastMon_ChildUnits(self)
	self.mana, self.manaMax = 1, 1

	self:SetScript("OnShow", UpdateUnit)
	XPerl_RegisterHighlight(self, 3)
	XPerl_RegisterClickCastFrame(self)
	XPerl_RegisterClickCastFrame(self.target)

	self:SetScript("OnAttributeChanged", onAttrChanged)

	local class = select(2, UnitClass("player"))
	if (class == "DRUID") then
		self:SetAttribute("type2", "spell")
		self:SetAttribute("spell2", XPERL_MONITOR_INNERVATE)
	elseif (class == "SHAMAN") then
		self:SetAttribute("type2", "spell")
		self:SetAttribute("spell2", XPERL_MONITOR_MANATIDE)
	end

	self.target:SetWidth(config.TargetWidth)
	self.target:SetHeight(config.UnitHeight)

	tinsert(MonUnits, self)
end

-- cast:OnEvent
function XPerl_RaidMonitor_OnEvent(self, event, a, b, c, d, e)
--if (a == "raid2") then ChatFrame2:AddMessage(event) end
	local e = self[event]
	if (e) then
		e(self, a, b, c, d, e)
	end
end

-- XPerl_Monitor_MakeAction
function XPerl_Monitor_MakeAction(self, str, type)
	if (str == "target") then
		return XPERL_MONITOR_CLICKTARGET
	elseif (str == "spell") then
		local b
		if (type == 1) then
			b = "LeftButton"
		else
			b = "RightButton"
		end
		local spell = SecureButton_GetModifiedAttribute(self, "spell", b)
		if (spell) then
			return string.format(XPERL_MONITOR_CLICKCAST, spell)
		end
	end
end

-- Encapsulated stuff
function XPerl_RaidMonitor_Init(self)

	self.updateTimer = 0

-- cast:DoButtons
function cast:DoButtons(disable)
	if (disable or InCombatLockdown()) then
		self.Buttons.Totals:Disable()
		self.Buttons.Close:Disable()
	else
		self.Buttons.Totals:Enable()
		self.Buttons.Close:Enable()
	end

	self.Buttons.Pin:SetButtonTex()
	self.Buttons.Totals:SetButtonTex()
end

-- cast:VARIABLES_LOADED
function cast:VARIABLES_LOADED()
	config = XPerlRaidMonConfig
	self:Vars()
	self:DoButtons()
	self:SetupAlpha()
	self:Init()

	cast.VARIABLES_LOADED = nil
end

-- cast:RAID_ROSTER_UPDATE
function cast:RAID_ROSTER_UPDATE()
	self:SetFrameSizes()
	UpdateAllUnits()
end

-- cast:PARTY_MEMBERS_CHANGED
function cast:PARTY_MEMBERS_CHANGED()
	UpdateAllUnits()
end

-- cast:ManaTotals
function cast:ManaTotals()
	self.doneMana = true

	local manaTotal, count, manaHigh, manaLow, allTotal = 0, 0, 0, 0, 0
	for i = 1,GetNumRaidMembers() do
		local v = self.area:GetAttribute("child"..i)
		if (not v) then	break end
		if (v.powerType == 0 and v:IsShown()) then
			local unit = v:GetAttribute("unit")
			if (UnitIsConnected(unit) and not UnitIsDeadOrGhost(unit)) then
				local perc
				if (v.manaMax == 0) then
					perc = 0
				else
					perc = 100 / v.manaMax * v.mana
				end

				if (perc >= config.HighMana) then
					manaHigh = manaHigh + 1
				end

				if (perc <= config.LowMana) then
					manaLow = manaLow + 1
				end

				manaTotal = manaTotal + perc
				count = count + 1
			end
		end
		allTotal = allTotal + 1
	end

	if (count == 0) then
		manaHigh = 0
		manaLow = 0
		manaTotal = 100
		count = 1
	end

	manaTotal = manaTotal / count

	local st = self.totals
	st.RaidMana:SetValue(manaTotal)
	st.HighMana:SetMinMaxValues(0, count)
	st.HighMana:SetValue(manaHigh)
	st.LowMana:SetMinMaxValues(0, count)
	st.LowMana:SetValue(manaLow)

	st.RaidMana.name:SetFormattedText("%d%%", manaTotal)
	st.HighMana.name:SetText(manaHigh)
	st.LowMana.name:SetText(manaLow)

	ScaleBarColour(st.RaidMana, manaTotal / 100, "rbg")
	ScaleBarColour(st.HighMana, manaHigh / count, "rbg")
	ScaleBarColour(st.LowMana, 1 - (manaLow / count), "rbg")
end

-- cast:HealthTotals()
function cast:HealthTotals()
	self.doneHealth = true

	local totalHealth = 0
	local total = 0
	for i = 1,GetNumRaidMembers() do
		local id = "raid"..i
		if (UnitIsConnected(id)) then
			local hp, hpMax = UnitHealth(id), UnitHealthMax(id)
			totalHealth = totalHealth + (100 * hp / hpMax)
			total = total + 1
		end
	end
	totalHealth = totalHealth / total

	self.totals.RaidHealth:SetValue(totalHealth)
	self.totals.RaidHealth.name:SetFormattedText("%d%%", totalHealth)
	ScaleBarColour(self.totals.RaidHealth, totalHealth / 100)
end

-- cast:UNIT_MANA
function cast:UNIT_MANA(unit)
	local u = TableUnits[unit]
	if (u) then
		local id = SecureButton_GetUnit(u)
		if (id) then
			u.powerType = UnitPowerType(id)
			u.mana, u.manaMax = UnitMana(id), UnitManaMax(id)
			u.bar:SetMinMaxValues(0, u.manaMax)
			u.bar:SetValue(u.mana)
			ScaleBarColour(u.bar, u.mana / u.manaMax, "rbg")
			self.doneMana = false
		end
	end
end

cast.UNIT_MAXMANA = cast.UNIT_MANA
cast.UNIT_RAGE = cast.UNIT_MANA
cast.UNIT_MAXRAGE = cast.UNIT_MANA
cast.UNIT_ENERGY = cast.UNIT_MANA
cast.UNIT_MAXENERGY = cast.UNIT_MANA
cast.UNIT_RUNIC_POWER = cast.UNIT_MANA
cast.UNIT_MAXRUNIC_POWER = cast.UNIT_MANA

-- cast:PLAYER_REGEN_DISABLED
function cast:PLAYER_REGEN_DISABLED()
	self:DoButtons(true)
end

-- cast:PLAYER_REGEN_ENABLED
function cast:PLAYER_REGEN_ENABLED()
	self:DoButtons()
end

-- cast:PLAYER_ENTERING_WORLD
function cast:PLAYER_ENTERING_WORLD()
	self:SetFrameSizes()
end

-- cast:UNIT_SPELLCAST_START
function cast:UNIT_SPELLCAST_START(unit)
	local bar = TableUnits[unit]
	if (bar and bar:IsShown()) then
		local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitCastingInfo(unit)
		if (name) then
			bar.castBar.name:SetText(name)
			bar.castBar.icon:SetTexture(texture)
			bar.castBar.spark:Show()
			bar.bar.name:Hide()
			bar.startTime = startTime / 1000
			bar.maxValue = endTime / 1000
			bar.castBar:SetStatusBarColor(castColours.main.r, castColours.main.g, castColours.main.b)
			bar.castBar:SetMinMaxValues(bar.startTime, bar.maxValue)
			bar.castBar:SetValue(bar.startTime)
			bar.castBar:Show()
			bar.castBar:SetAlpha(1)
			bar.holdTime = 0
			bar.casting = 1
			bar.channeling = nil
			bar.fadeOut = nil
		end
	end
end

-- cast:UNIT_SPELLCAST_STOP
function cast:UNIT_SPELLCAST_STOP(unit)
	local bar = TableUnits[unit]
	if (bar and bar:IsShown()) then
		if (bar.casting) then
			--bar.bar:SetValue(bar.maxValue)
			--bar.bar:SetStatusBarColor(castColours.success.r, castColours.success.g, castColours.success.b)
			bar.castBar.spark:Hide()
			bar.casting = nil
			bar.channeling = nil
			bar.fadeOut = true
		end
	end
end

-- cast:UNIT_SPELLCAST_FAILED
function cast:UNIT_SPELLCAST_FAILED(unit)
	local bar = TableUnits[unit]
	if (bar and bar:IsShown()) then
		bar.castBar.name:SetText(FAILED)
		bar.castBar:SetValue(bar.maxValue or 1)
		bar.castBar:SetStatusBarColor(castColours.failure.r, castColours.failure.g, castColours.failure.b)
		bar.castBar.spark:Hide()
		bar.casting = nil
		bar.channeling = nil
		bar.fadeOut = true
	end
end

-- cast:UNIT_SPELLCAST_INTERRUPTED
function cast:UNIT_SPELLCAST_INTERRUPTED(unit)
	local bar = TableUnits[unit]
	if (bar and bar:IsShown()) then
		bar.castBar.name:SetText(SPELL_FAILED_INTERRUPTED)
		bar.castBar:SetValue(bar.maxValue or 1)
		bar.castBar:SetStatusBarColor(castColours.failure.r, castColours.failure.g, castColours.failure.b)
		bar.castBar.spark:Hide()
		bar.casting = nil
		bar.channeling = nil
		bar.fadeOut = true
	end
end

-- cast:UNIT_SPELLCAST_SUCCEEDED
function cast:UNIT_SPELLCAST_SUCCEEDED(unit)
	local bar = TableUnits[unit]
	if (bar and bar:IsShown()) then
		bar.castBar:SetValue(bar.maxValue or 1)
		bar.castBar:SetStatusBarColor(castColours.success.r, castColours.success.g, castColours.success.b)
		bar.casting = nil
		bar.channeling = nil
		bar.fadeOut = true
		bar.castBar:SetAlpha(1)
	end
end

-- cast:UNIT_SPELLCAST_DELAYED
function cast:UNIT_SPELLCAST_DELAYED(unit)
	local bar = TableUnits[unit]
	if (bar and bar:IsShown()) then
		local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitCastingInfo(unit)
		if (name) then
			bar.startTime = startTime / 1000
			bar.maxValue = endTime / 1000
			bar.castBar:SetMinMaxValues(bar.startTime, bar.maxValue)
		end
	end
end

-- cast:UNIT_SPELLCAST_CHANNEL_START
function cast:UNIT_SPELLCAST_CHANNEL_START(unit)
	local bar = TableUnits[unit]
	if (bar and bar:IsShown()) then
		local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitChannelInfo(unit)
		if (name) then
			bar.castBar:SetStatusBarColor(castColours.channel.r, castColours.channel.g, castColours.channel.b)
			bar.castBar.name:SetText(name)
			bar.castBar.spark:Show()
			bar.bar.name:Hide()
			bar.castBar.icon:SetTexture(texture)
			bar.maxValue = 1
			bar.startTime = startTime / 1000
			bar.endTime = endTime / 1000
			bar.castBar:SetMinMaxValues(bar.startTime, bar.endTime)
			bar.castBar:SetValue(bar.endTime)
			bar.casting = nil
			bar.fadeOut = nil
			bar.channeling = 1
			bar.castBar:Show()
			bar.castBar:SetAlpha(1)
		end
	end
end

-- cast:UNIT_SPELLCAST_CHANNEL_UPDATE
function cast:UNIT_SPELLCAST_CHANNEL_UPDATE(unit)
	local bar = TableUnits[unit]
	if (bar and bar:IsShown()) then
		local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitChannelInfo(unit)
		if (name) then
			bar.startTime = startTime / 1000
			bar.endTime = endTime / 1000
			bar.maxValue = bar.startTime
			bar.castBar:SetMinMaxValues(bar.startTime, bar.endTime)
		end
	end
end

-- cast:UNIT_SPELLCAST_CHANNEL_STOP
function cast:UNIT_SPELLCAST_CHANNEL_STOP(unit)
	local bar = TableUnits[unit]
	if (bar and bar:IsShown()) then
		if (bar.channeling) then
			bar.castBar:SetValue(bar.maxValue)
			bar.castBar:SetStatusBarColor(castColours.success.r, castColours.success.g, castColours.success.b)
			bar.castBar.spark:Hide()
			bar.casting = nil
			bar.channeling = nil
			bar.fadeOut = true
		end
	end
end

-- cast:UNIT_TARGET
function cast:UNIT_TARGET(unit)
	local bar = TableUnits[unit]
	if (bar and bar:IsShown()) then
		UpdateTarget(bar.target)
	end
end

-- cast:PLAYER_TARGET_CHANGED
function cast:PLAYER_TARGET_CHANGED()
	self:OnUpdate(1)
end

-- cast:UNIT_HEALTH
function cast:UNIT_HEALTH(unit)
	self.doneHealth = nil
	local bar = self:GetTarget(unit)
	if (bar and bar:IsShown()) then
		UpdateTarget(bar)
	end
end

cast.UNIT_HEALTHMAX = cast.UNIT_HEALTH

-- cast:OnUpdate
function cast:OnUpdate(elapsed)

	for k,v in pairs(MonUnits) do
		CastBar_OnUpdate(v)
	end

	self.updateTimer = self.updateTimer + elapsed
	if (self.updateTimer > 1) then
		self.updateTimer = 0
		for k,v in pairs(MonUnits) do
			UpdateTarget(v.target)
		end
	end

	if (not self.doneHealth) then
		self:HealthTotals()
	end

	if (not self.doneMana) then
		self:ManaTotals()
	end
end

-- cast:Vars
function cast:Vars()

	local function DefaultVar(name, value)
		if (config[name] == nil or (type(value) ~= type(config[name]))) then
			config[name] = value
		end
	end

	if (type(config.classes) ~= "table") then
		config.classes = {PRIEST = true, DRUID = true, SHAMAN = true, PALADIN = true}
	end

	DefaultVar("UnitWidth", 120)
	DefaultVar("UnitHeight", 12)
	DefaultVar("TargetWidth", 80)

	DefaultVar("LowMana", 20)
	DefaultVar("HighMana", 80)

	DefaultVar("Tooltips", 1)
	DefaultVar("Scale", 1)
	DefaultVar("Alpha", 1)
	DefaultVar("BackgroundAlpha", 0.8)
end

-- SetTargetConfig
local function SetTargetConfig(self)
	self.target:SetAttribute("useparent-unit", true)
	self.target:SetAttribute("unitsuffix", "target")
	self.target:SetAttribute("type", "target")
	self.target:SetWidth(config.TargetWidth)
	self.target:SetHeight(config.UnitHeight)
end

-- cast:Init
function cast:Init()
	if (InCombatLockdown()) then
		tinsert(XPerl_OutOfCombatQueue, {cast.Init, self})
		return
	end

	self.area:UnregisterEvent("UNIT_NAME_UPDATE")	-- Fix for WoW 2.1 UNIT_NAME_UPDATE issue

	self.area = _G[self:GetName().."Area"]

	if (config.GrowUp) then
		self.area:SetAttribute("point", "BOTTOM")
	else
		self.area:SetAttribute("point", nil)
	end

	self.area:SetAttribute("template", "XPerl_RaidMonitor_UnitTemplate")
	self.area:SetAttribute("templateType", "Button")
	self.area:SetAttribute("sortOrder", "NAME")
	self.area:SetAttribute("groupBy", "CLASS")		-- For API version 20003
	self.area:SetAttribute("groupingOrder", "PRIEST,DRUID,SHAMAN,PALADIN,MAGE,WARLOCK,HUNTER,ROGUE,WARRIOR,DEATHKNIGHT")

	self.area.initialConfigFunction = function(self)
		-- This is the only place we're allowed to set attributes whilst in combat
		self:SetAttribute("*type1", "target")
		self:SetAttribute("initial-height", config.UnitHeight)
		self:SetAttribute("initial-width", config.UnitWidth)

		if (InCombatLockdown()) then
			tinsert(XPerl_OutOfCombatQueue, {SetTargetConfig, self})
		else
			SetTargetConfig(self)
		end
	end

	local classes = {}
	for k,v in pairs(config.classes) do
		if (v) then
			tinsert(classes, k)
		end
	end

	self.area:SetAttribute("groupFilter", table.concat(classes, ","))

	if (config.enabled == 1) then
		self:Show()
		self.area:Show()
		self:SetFrameSizes()
	else
		self:Hide()
	end
end

-- cast:GetTarget
function cast:GetTarget(unit)
	for k,v in pairs(MonUnits) do
		local id = v:GetAttribute("unit")
		if (id and UnitIsUnit(id.."target", unit)) then
			return v.target
		end
	end
end

-- cast:SetUnitSizes
function cast:SetUnitSizes()
	if (InCombatLockdown()) then
		tinsert(XPerl_OutOfCombatQueue, {cast.SetUnitSizes, self})
		return
	end

	local unitWidth = config.UnitWidth
	local unitHeight = config.UnitHeight
	local targetWidth = config.TargetWidth

	self.area:SetWidth(unitWidth)

	for k,v in pairs(MonUnits) do
		v:SetWidth(unitWidth)
		v:SetHeight(unitHeight)
		v.target:SetWidth(targetWidth)
		v.target:SetHeight(unitHeight)
	end
end

-- cast:EnableDisable()
function cast:EnableDisable()

	local events = {"UNIT_MANA", "UNIT_MAXMANA", "UNIT_RAGE", "UNIT_MAXRAGE", "UNIT_ENERGY", "UNIT_MAXENERGY",
			"UNIT_HEALTH", "UNIT_HEALTHMAX", "UNIT_TARGET", "PLAYER_TARGET_CHANGED",
			"UNIT_SPELLCAST_START", "UNIT_SPELLCAST_STOP", "UNIT_SPELLCAST_FAILED", "UNIT_SPELLCAST_INTERRUPTED",
			"UNIT_SPELLCAST_DELAYED", "UNIT_SPELLCAST_CHANNEL_START", "UNIT_SPELLCAST_SUCCEEDED",
			"UNIT_SPELLCAST_CHANNEL_UPDATE", "UNIT_SPELLCAST_CHANNEL_STOP", "PLAYER_ENTERING_WORLD", "RAID_ROSTER_UPDATE",
			"PLAYER_REGEN_DISABLED", "PLAYER_REGEN_ENABLED", "PARTY_MEMBERS_CHANGED"}

	for k,v in pairs(events) do
		if (self:IsShown()) then
			self:RegisterEvent(v)
		else
			self:UnregisterEvent(v)
		end
	end
end

-- cast:SetupAlpha
function cast:SetupAlpha()
	self:SetAlpha(config.Alpha)
	self:SetBackdropColor(0, 0, 0, config.BackgroundAlpha)
	self:SetBackdropBorderColor(0.5, 0.5, 0.5, config.BackgroundAlpha)
end

-- cast:SetFrameSizes
function cast:SetFrameSizes()
	if (InCombatLockdown()) then
		tinsert(XPerl_OutOfCombatQueue, {cast.SetFrameSizes, self})
		return
	end

	local count = 0
	for i = 1,GetNumRaidMembers() do
		if (config.classes[select(2, UnitClass("raid"..i))]) then
			count = count + 1
		end
	end

	self.area:SetHeight(config.UnitHeight * count)
	self:SetWidth(config.UnitWidth + config.TargetWidth + 8)

	local h = config.UnitHeight * count + 20
	if (config.Totals) then
		self:SetHeight(h + 52)
		self.totals:Show()
	else
		self:SetHeight(h)
		self.totals:Hide()
	end

	XPerl_RegisterScalableFrame(self, XPerl_RaidMonitor_Anchor, nil, nil, config.GrowUp)

	self:ClearAllPoints()
	self.area:ClearAllPoints()
	self.titleBar:ClearAllPoints()
	self.totals:ClearAllPoints()
	self.totals.sep:ClearAllPoints()
	if (config.GrowUp) then
		XPerl_SwitchAnchor(XPerl_RaidMonitor_Anchor, "BOTTOMLEFT")
		self:SetPoint("BOTTOMLEFT", 0, 0)
		self.titleBar:SetPoint("BOTTOMLEFT", 3, 3)
		self.titleBar:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", -3, 13)
		self.area:SetPoint("BOTTOMLEFT", 4, 15)
		self.totals:SetPoint("BOTTOMLEFT", self.area, "TOPLEFT", 0, 6)
		self.totals:SetPoint("TOPRIGHT", -4, -4)
		self.totals.sep:SetPoint("TOPLEFT", self.totals, "BOTTOMLEFT", 0, -1)
		self.totals.sep:SetPoint("BOTTOMRIGHT", self.totals, "BOTTOMRIGHT", 0, -5)
	else
		XPerl_SwitchAnchor(XPerl_RaidMonitor_Anchor, "TOPLEFT")
		self:SetPoint("TOPLEFT", 0, 0)
		self.titleBar:SetPoint("TOPLEFT", 3, -3)
		self.titleBar:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -3, -13)
		self.area:SetPoint("TOPLEFT", 4, -15)
		self.totals:SetPoint("TOPLEFT", self.area, "BOTTOMLEFT", 0, -6)
		self.totals:SetPoint("BOTTOMRIGHT", -4, 4)
		self.totals.sep:SetPoint("BOTTOMLEFT", self.totals, "TOPLEFT", 0, 1)
		self.totals.sep:SetPoint("TOPRIGHT", self.totals, "TOPRIGHT", 0, 5)
	end

	if (count > 0 and config.enabled == 1) then
		if (not self:IsShown()) then
			self.doneHealth = nil
			self:Show()
		end
		self.area:Show()
	else
		self:Hide()
	end

	self:EnableDisable()
end


	XPerl_RaidMonitor_Init = nil

-- Encapsulation end
end
