-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

local ArcaneBars = {}

local conf
XPerl_RequestConfig(function(new) conf = new end, "$Revision: 374 $")

-- Registers frame to spellcast events.

local barColours = {
	main = {r = 1.0, g = 0.7, b = 0.0},
	channel = {r = 0.0, g = 1.0, b = 0.0},
	success = {r = 0.0, g = 1.0, b = 0.0},
	failure = {r = 1.0, g = 0.0, b = 0.0}
}

local events = {"UNIT_SPELLCAST_START", "UNIT_SPELLCAST_STOP", "UNIT_SPELLCAST_FAILED",
		"UNIT_SPELLCAST_INTERRUPTED", "UNIT_SPELLCAST_DELAYED", "UNIT_SPELLCAST_CHANNEL_START",
		"UNIT_SPELLCAST_CHANNEL_UPDATE", "UNIT_SPELLCAST_CHANNEL_STOP", "PLAYER_ENTERING_WORLD"}

-- enableToggle
local function enableToggle(self, value)
	if (value) then
		if (not self.Enabled) then
			for i,event in pairs(events) do
				self:RegisterEvent(""..event)
			end

			self:SetScript("OnUpdate", XPerl_ArcaneBar_OnUpdate)
			if (self.unit == "target") then
				self:RegisterEvent("PLAYER_TARGET_CHANGED")
			elseif (self.unit == "focus") then
				self:RegisterEvent("PLAYER_FOCUS_CHANGED")
			elseif (strfind(self.unit, "^party")) then
				self:RegisterEvent("PARTY_MEMBER_ENABLE")
				self:RegisterEvent("PARTY_MEMBER_DISABLE")
			end
			self.Enabled = 1
		end
	else
		if (self.Enabled) then
			self:UnregisterAllEvents()
			self:SetScript("OnUpdate", nil)
			self.Enabled = nil
			self:Hide()
		end
	end
end

-- overrideToggle
local function overrideToggle(value)
	local pconf = ArcaneBars.player
	if (pconf) then
		if (value) then
			if (pconf.bar.Overrided) then
				for i,event in pairs(events) do
					CastingBarFrame:RegisterEvent(event)
				end
				pconf.bar.Overrided = nil
			end
		else
			if (not pconf.bar.Overrided) then
				CastingBarFrame:Hide()
				CastingBarFrame:UnregisterAllEvents()
				pconf.bar.Overrided = 1
			end
		end
	end
end

-- ActiveCasting
-- See if we're probably still casting a spell, even though some other spell END event occured
local function ActiveCasting(self)			
	local t = GetTime() * 1000
	local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill
	if (event == "UNIT_SPELLCAST_STOP") then
		name, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitCastingInfo(self.unit)
	else
		name, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitChannelInfo(self.unit)
	end
	if (name and endTime > t + 500) then
		return true
	end
end

--------------------------------------------------
--
-- Event/Update Handlers
--
--------------------------------------------------

-- XPerl_ArcaneBar_OnEvent
function XPerl_ArcaneBar_OnEvent(self, event, newarg1)
	if (event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_FOCUS_CHANGED" or event == "PARTY_MEMBER_ENABLE" or event == "PARTY_MEMBER_DISABLE") then
		local nameChannel = UnitChannelInfo(self.unit)
		local nameSpell = UnitCastingInfo(self.unit)
		if (nameChannel) then
			event = "UNIT_SPELLCAST_CHANNEL_START"
			newarg1 = self.unit
		elseif (nameSpell) then
			event = "UNIT_SPELLCAST_START"
			newarg1 = self.unit
		else
			self:Hide()
			self.castTimeText:Hide()
			self.barParentName:SetAlpha(conf.transparency.text)
			self.barParentName:Show()
			return
		end
	end

	if (newarg1 ~= self.unit) then
		return
	end

	if (event == "UNIT_SPELLCAST_START") then
		local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitCastingInfo(self.unit)
		if ( not name or (not self.showTradeSkills and isTradeSkill)) then
			self:Hide()
			return
		end

		self:SetStatusBarColor(barColours.main.r, barColours.main.g, barColours.main.b, conf.transparency.frame)
		self.spellText:SetText(name:gsub(" %- No Text", ""))
		self.barParentName:Hide()
		self.barSpark:Show()
		self.startTime = startTime / 1000
		self.maxValue = endTime / 1000
		self:SetMinMaxValues(self.startTime, self.maxValue)
		self:SetValue(self.startTime)
		self:SetAlpha(0.8)
		self.holdTime = 0
		self.casting, self.channeling, self.fadeOut, self.flash = 1, nil, nil, nil
		self:Show()
		self.delaySum = 0
		if (conf.player.castBar.castTime) then
			self.castTimeText:Show()
		else
			self.castTimeText:Hide()
		end

	elseif ((event == "UNIT_SPELLCAST_STOP" and self.casting) or (event == "UNIT_SPELLCAST_CHANNEL_STOP" and self.channeling)) then
		if (not ActiveCasting(self)) then
			self.delaySum = 0
			self.sign = "+"
			self.castTimeText:Hide()
			if (not self:IsVisible()) then
				self:Hide()
			end
			if (self:IsShown()) then
				self:SetValue(self.maxValue)
				self:SetStatusBarColor(barColours.success.r, barColours.success.g, barColours.success.b, conf.transparency.frame)
				self.barSpark:Hide()
				self.barFlash:SetAlpha(0.0)
				self.barFlash:Show()
				self.casting = nil
				self.channeling = nil
				if (not self.fadeOut or event == "UNIT_SPELLCAST_CHANNEL_STOP") then
					self.flash = 1
				end
				self.fadeOut = 1
				self.holdTime = 0
			end
		end

	elseif (event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_INTERRUPTED") then
		if (self:IsShown() and not ActiveCasting(self)) then
			if (event == "UNIT_SPELLCAST_FAILED") then
				self.spellText:SetText(FAILED)
			else
				self.spellText:SetText(SPELL_FAILED_INTERRUPTED)
			end

			self:SetValue(self.maxValue)
			self:SetStatusBarColor(barColours.failure.r, barColours.failure.g, barColours.failure.b, conf.transparency.frame)
			self.barSpark:Hide()
			self.casting = nil
			self.channeling = nil
			if (not self.fadeOut) then
				self.flash = 1
			end
			self.fadeOut = 1
			self.holdTime = GetTime() + CASTING_BAR_HOLD_TIME
		end

	elseif (event == "UNIT_SPELLCAST_DELAYED") then
		if (self:IsShown()) then
			local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitCastingInfo(self.unit)
			if (not name or (not self.showTradeSkills and isTradeSkill)) then
				-- if there is no name, there is no bar
				self:Hide()
				return;
			end
			self.startTime = startTime / 1000
			self.maxValue = endTime / 1000
			self:SetMinMaxValues(self.startTime, self.maxValue)
		end

	elseif (event == "UNIT_SPELLCAST_CHANNEL_START") then
		local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitChannelInfo(self.unit)
		if (not name or (not self.showTradeSkills and isTradeSkill)) then
			-- if there is no name, there is no bar
			self:Hide()
			return
		end

		self:SetStatusBarColor(barColours.channel.r, barColours.channel.g, barColours.channel.b, conf.transparency.frame)
		self.barSpark:Show()
		self.barParentName:Hide()
		self.spellText:SetText(name:gsub(" %- No Text", ""))
		self.maxValue = 1
		self.startTime = startTime / 1000
		self.endTime = endTime / 1000
		self:SetMinMaxValues(self.startTime, self.endTime)
		self:SetValue(self.endTime)
		self:SetAlpha(1.0)
		self.holdTime = 0
		self.casting, self.channeling, self.fadeOut, self.flash = nil, 1, nil, nil
		self:Show()
		self.delaySum = 0
		if (conf.player.castBar.castTime) then
			self.castTimeText:Show()
		else
			self.castTimeText:Hide()
		end

	elseif (event == "UNIT_SPELLCAST_CHANNEL_UPDATE") then
		if (self:IsShown()) then
			local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitChannelInfo(self.unit)
			if (not name or (not self.showTradeSkills and isTradeSkill)) then
				-- if there is no name, there is no bar
				self:Hide()
				return;
			end
			self.startTime = startTime / 1000
			self.endTime = endTime / 1000
			self.maxValue = self.startTime
			self:SetMinMaxValues(self.startTime, self.endTime)
		end
	end

	if (not self:IsShown()) then
		self.castTimeText:Hide()
		self.barParentName:SetAlpha(conf.transparency.text)
		self.barParentName:Show()
	end
end

local function ShowPrecast(self, side)
	if (self.precast) then
	 	if (conf.player.castBar.precast) then
			local lag = min(1000, select(3, GetNetStats()))
			if (lag < 10) then
				self.precast:Hide()
			else
				local total = self.maxValue - self.startTime
				local width = self:GetWidth() / ((total * 1000) / lag)

				self.precast:ClearAllPoints()
				self.precast:SetPoint(side)
				self.precast:SetWidth(width)
				self.precast:SetHeight(self:GetHeight())
				self.precast:Show()
			end
		else
			self.precast:Hide()
		end
	end
end

-- XPerl_ArcaneBar_OnUpdate
function XPerl_ArcaneBar_OnUpdate(self, elapsed)
	local getTime = GetTime()
	local current_time = self.maxValue - getTime
	if (self.channeling) then
		current_time = self.endTime - getTime
	end
	if (current_time < 0) then
		current_time = 0
	end
	local text = format("%.1f", current_time)

	self.castTimeText:SetText(text)
        
	if (self.casting) then
		local status = getTime
		if (status > self.maxValue) then
			status = self.maxValue
			self.tex:SetTexCoord(0,1,0,1)
			self.casting = nil
			self.barFlash:SetAlpha(0.0)
			self.barFlash:Show()
			if (not self.fadeOut) then
				self.flash = 1
			end
			self.holdTime = 0
			self.fadeOut = 1
			return
		end
		
		self.tex:SetTexCoord(0, (status - self.startTime) / (self.maxValue - self.startTime), 0, 1)
		self:SetValue(status)
		self.barFlash:Hide()

		local sparkPosition = ((status - self.startTime) / (self.maxValue - self.startTime)) * self:GetWidth()
		if (sparkPosition < 0) then
			sparkPosition = 0
		end
		self.barSpark:SetPoint("CENTER", self, "LEFT", sparkPosition, 1)

		ShowPrecast(self, "RIGHT")

	elseif (self.channeling) then
		local time = getTime
		if (time > self.endTime) then
			time = self.endTime
		end
		if (time == self.endTime) then
			self.channeling = nil
			self.barFlash:SetAlpha(0.0)
			self.barFlash:Show()
			if (not self.fadeOut) then
				self.flash = 1
			end
			self.holdTime = 0
			self.fadeOut = 1
			return
		end
		local barValue = self.startTime + (self.endTime - time)		
		self.tex:SetTexCoord(0, (barValue - self.startTime) / (self.endTime - self.startTime), 0, 1)
		self:SetValue( barValue )
		self.barFlash:Hide()

		local sparkPosition = ((barValue - self.startTime) / (self.endTime - self.startTime)) * self:GetWidth()
		self.barSpark:SetPoint("CENTER", self, "LEFT", sparkPosition, 1)

		ShowPrecast(self, "LEFT")

	elseif (getTime < self.holdTime) then
		return

	elseif (self.flash) then
		local alpha = self.barFlash:GetAlpha() + elapsed * 3	-- CASTING_BAR_FLASH_STEP
		if (alpha < 1) then
			self.barFlash:SetAlpha(alpha)
		else
			self.flash = nil
		end

	elseif (self.fadeOut) then
		local alpha = self:GetAlpha() - elapsed * 2			-- CASTING_BAR_ALPHA_STEP
		if (alpha > 0) then
			self:SetAlpha(alpha)
			self.barParentName:SetAlpha((1 - alpha) * conf.transparency.text)
			self.barParentName:Show()
		else
			self.fadeOut = nil
			self:Hide()
		end
	end

	if (not self:IsShown()) then
		self.castTimeText:Hide()
		self.barParentName:SetAlpha(conf.transparency.text)
		self.barParentName:Show()
	end
end

-- XPerl_ArcaneBar_OnLoad
function XPerl_ArcaneBar_OnLoad(self)
	XPerl_SetChildMembers(self)

	self.barFlash.tex:SetTexture("Interface\\AddOns\\XPerl\\Images\\XPerl_ArcaneBarFlash")
	self.tex:SetTexture("Interface\\AddOns\\XPerl\\Images\\XPerl_StatusBar")
	self.tex:SetHorizTile(false)
	self.tex:SetVertTile(false)
	
	self.casting = nil
	self.holdTime = 0

	XPerl_RegisterBar(self)
end

-- XPerl_ArcaneBar_Set
function XPerl_ArcaneBar_Set()
	if (conf) then
		for k,v in pairs(ArcaneBars) do
			if (v.optFrame and v.optFrame.conf and v.optFrame.conf.castBar) then
				enableToggle(v.bar, v.optFrame.conf.castBar.enable)

				v.bar.castTimeText:ClearAllPoints()
				if (v.optFrame.conf.castBar.inside) then
					v.bar.castTimeText:SetPoint("RIGHT", v.bar, "RIGHT", -2, 0)
					v.bar.castTimeText:SetJustifyH("RIGHT")
				else
					v.bar.castTimeText:SetPoint("LEFT", v.bar, "RIGHT", 2, 0)
					v.bar.castTimeText:SetJustifyH("LEFT")
				end
			end
		end

		overrideToggle(conf.player.castBar.original)
	end
end

-- SetArcaneBar
local function SetArcaneBar(value, new)
	for k,v in pairs(ArcaneBars) do
		if (v.bar == new.bar) then
			ArcaneBars[k] = nil
		end
	end

	ArcaneBars[value] = new
end

-- XPerl_MakePreCast
local function XPerl_MakePreCast(self)
	local tex = XPerl_GetBarTexture()
	self.precast = self:CreateTexture(nil, "ARTWORK")
	self.precast:SetTexture(tex)
	self.precast:SetPoint("RIGHT")
	self.precast:SetWidth(1)
	self.precast:Hide()
	self.precast:SetBlendMode("ADD")
	self.precast:SetVertexColor(1, 0, 0)	--SetGradient("HORIZONTAL", 0, 0, 1, 1, 0, 0)
	XPerl_MakePreCast = nil
end

-- XPerl_ArcaneBar_RegisterFrame
function XPerl_ArcaneBar_RegisterFrame(self, unit)
	local f = self.castBar
	if (not f) then
		f = CreateFrame("StatusBar", self:GetName().."CastBar", self, "XPerl_ArcaneBarTemplate")
		self.castBar = f
	end

	if (unit == "player") then
		XPerl_MakePreCast(f)
	end

	f.unit = unit
	f.showTradeSkills = true
	f.barParentName = self.text
	f:SetPoint("TOPLEFT", 4, -4)
	f:SetPoint("BOTTOMRIGHT", -4, 4)

	SetArcaneBar(unit, {bar = f, optFrame = self:GetParent()})

	XPerl_ArcaneBar_Set()
end

-- XPerl_ArcaneBar_SetUnit
function XPerl_ArcaneBar_SetUnit(self, unit)
	if (self.castBar) then
		self.castBar.unit = unit
	end
end

XPerl_RegisterOptionChanger(XPerl_ArcaneBar_Set)
