local SunderCount = IceCore_CreateClass(IceElement)

SunderCount.prototype.sunderSize = 20

-- Constructor --
function SunderCount.prototype:init()
	SunderCount.super.prototype.init(self, "SunderCount")

	self:SetDefaultColor("SunderCount", 1, 1, 0)
	self.scalingEnabled = true
end



-- 'Public' methods -----------------------------------------------------------


-- OVERRIDE
function SunderCount.prototype:GetOptions()
	local opts = SunderCount.super.prototype.GetOptions(self)

	opts["vpos"] = {
		type = "range",
		name = "Vertical Position",
		desc = "Vertical Position",
		get = function()
			return self.moduleSettings.vpos
		end,
		set = function(info, v)
			self.moduleSettings.vpos = v
			self:Redraw()
		end,
		min = -300,
		max = 200,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 31
	}

	opts["sunderFontSize"] = {
		type = "range",
		name = "Sunder Count Font Size",
		desc = "Sunder Count Font Size",
		get = function()
			return self.moduleSettings.sunderFontSize
		end,
		set = function(info, v)
			self.moduleSettings.sunderFontSize = v
			self:Redraw()
		end,
		min = 10,
		max = 40,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 32
	}

	opts["sunderMode"] = {
		type = 'select',
		name = "Display Mode",
		desc = "Show graphical or numeric sunders",
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.sunderMode)
		end,
		set = function(info, v)
			self.moduleSettings.sunderMode = info.option.values[v]
			self:CreateSunderFrame(true)
			self:Redraw()
			IceHUD:NotifyOptionsChange()
		end,
		values = { "Numeric", "Graphical Bar", "Graphical Circle", "Graphical Glow", "Graphical Clean Circle" },
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 33
	}

	opts["sunderGap"] = {
		type = 'range',
		name = 'Sunder gap',
		desc = 'Spacing between each sunder count (only works for graphical mode)',
		min = 0,
		max = 100,
		step = 1,
		get = function()
			return self.moduleSettings.sunderGap
		end,
		set = function(info, v)
			self.moduleSettings.sunderGap = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or self.moduleSettings.sunderMode == "Numeric"
		end,
		order = 33.2
	}

	opts["gradient"] = {
		type = "toggle",
		name = "Change color",
		desc = "1 sunder: yellow, 5 sunders: red",
		get = function()
			return self.moduleSettings.gradient
		end,
		set = function(info, v)
			self.moduleSettings.gradient = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 34
	}

	return opts
end


-- OVERRIDE
function SunderCount.prototype:GetDefaultSettings()
	local defaults =  SunderCount.super.prototype.GetDefaultSettings(self)
	defaults["vpos"] = 0
	defaults["sunderFontSize"] = 20
	defaults["sunderMode"] = "Numeric"
	defaults["gradient"] = false
	defaults["usesDogTagStrings"] = false
	defaults["alwaysFullAlpha"] = true
	defaults["sunderGap"] = 0
	return defaults
end


-- OVERRIDE
function SunderCount.prototype:Redraw()
	SunderCount.super.prototype.Redraw(self)

	self:CreateFrame()
	self:UpdateSunderCount()
end


-- OVERRIDE
function SunderCount.prototype:Enable(core)
	SunderCount.super.prototype.Enable(self, core)

	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateSunderCount")
	self:RegisterEvent("UNIT_AURA", "UpdateSunderCount")

	if self.moduleSettings.sunderMode == "Graphical" then
		self.moduleSettings.sunderMode = "Graphical Bar"
	end

	self:CreateSunderFrame(true)
end



-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function SunderCount.prototype:CreateFrame()
	SunderCount.super.prototype.CreateFrame(self)

	self.frame:SetFrameStrata("BACKGROUND")
	self.frame:SetWidth(self.sunderSize*5)
	self.frame:SetHeight(1)
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOP", self.parent, "BOTTOM", 0, self.moduleSettings.vpos)

	self:Show(true)

	self:CreateSunderFrame()
end



function SunderCount.prototype:CreateSunderFrame(doTextureUpdate)
	-- create numeric sunders
	self.frame.numeric = self:FontFactory(self.moduleSettings.sunderFontSize, nil, self.frame.numeric)

	self.frame.numeric:SetWidth(50)
	self.frame.numeric:SetJustifyH("CENTER")

	self.frame.numeric:SetPoint("TOP", self.frame, "TOP", 0, 0)
	self.frame.numeric:Show()

	if (not self.frame.graphicalBG) then
		self.frame.graphicalBG = {}
		self.frame.graphical = {}
	end

	-- create backgrounds
	for i = 1, 5 do
		if (not self.frame.graphicalBG[i]) then
			local frame = CreateFrame("Frame", nil, self.frame)
			self.frame.graphicalBG[i] = frame
			frame.texture = frame:CreateTexture()
			frame.texture:SetAllPoints(frame)
		end

		if doTextureUpdate then
			if self.moduleSettings.sunderMode == "Graphical Bar" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboBG")
			elseif self.moduleSettings.sunderMode == "Graphical Circle" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboRoundBG")
			elseif self.moduleSettings.sunderMode == "Graphical Glow" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboGlowBG")
			elseif self.moduleSettings.sunderMode == "Graphical Clean Circle" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboCleanCurvesBG")
			end
		end

		self.frame.graphicalBG[i]:SetFrameStrata("BACKGROUND")
		self.frame.graphicalBG[i]:SetWidth(self.sunderSize)
		self.frame.graphicalBG[i]:SetHeight(self.sunderSize)
		self.frame.graphicalBG[i]:SetPoint("TOPLEFT", (i-1) * (self.sunderSize-5) + (i-1) + ((i-1) * self.moduleSettings.sunderGap), 0)
		self.frame.graphicalBG[i]:SetAlpha(0.15)
		self.frame.graphicalBG[i].texture:SetVertexColor(self:GetColor("SunderCount"))

		self.frame.graphicalBG[i]:Hide()
	end

	-- create sunders
	for i = 1, 5 do
		if (not self.frame.graphical[i]) then
			local frame = CreateFrame("Frame", nil, self.frame)
			self.frame.graphical[i] = frame
			frame.texture = frame:CreateTexture()
			frame.texture:SetAllPoints(frame)
		end

		if doTextureUpdate then
			if self.moduleSettings.sunderMode == "Graphical Bar" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "Combo")
			elseif self.moduleSettings.sunderMode == "Graphical Circle" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "ComboRound")
			elseif self.moduleSettings.sunderMode == "Graphical Glow" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "ComboGlow")
			elseif self.moduleSettings.sunderMode == "Graphical Clean Circle" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "ComboCleanCurves")
			end
		end

		self.frame.graphical[i]:SetFrameStrata("BACKGROUND")
		self.frame.graphical[i]:SetAllPoints(self.frame.graphicalBG[i])

		local r, g, b = self:GetColor("SunderCount")
		if (self.moduleSettings.gradient) then
			g = g - (0.15*i)
		end
		self.frame.graphical[i].texture:SetVertexColor(r, g, b)

		self.frame.graphical[i]:Hide()
	end
end


function SunderCount.prototype:UpdateSunderCount()
	local points
	if IceHUD.IceCore:IsInConfigMode() then
		points = 5
	else
		points = IceHUD:GetDebuffCount("target", "Ability_Warrior_Sunder")
	end

	if (points == 0) then
		points = nil
	end

	if (self.moduleSettings.sunderMode == "Numeric") then
		local r, g, b = self:GetColor("SunderCount")
		if (self.moduleSettings.gradient and points) then
			g = g - (0.15*points)
		end
		self.frame.numeric:SetTextColor(r, g, b, 0.7)

		self.frame.numeric:SetText(points)
	else
		self.frame.numeric:SetText()

		for i = 1, table.getn(self.frame.graphical) do
			if (points ~= nil) then
				self.frame.graphicalBG[i]:Show()
			else
				self.frame.graphicalBG[i]:Hide()
			end

			if (points ~= nil and i <= points) then
				self.frame.graphical[i]:Show()
			else
				self.frame.graphical[i]:Hide()
			end
		end
	end
end


-- Load us up
local _, unitClass = UnitClass("player")
if (unitClass == "WARRIOR") then
	IceHUD.SunderCount = SunderCount:new()
end
