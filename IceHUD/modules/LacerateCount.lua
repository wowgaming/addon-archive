local LacerateCount = IceCore_CreateClass(IceElement)

LacerateCount.prototype.lacerateSize = 20

-- Constructor --
function LacerateCount.prototype:init()
	LacerateCount.super.prototype.init(self, "LacerateCount")

	self:SetDefaultColor("LacerateCount", 1, 1, 0)
	self.scalingEnabled = true
end



-- 'Public' methods -----------------------------------------------------------


-- OVERRIDE
function LacerateCount.prototype:GetOptions()
	local opts = LacerateCount.super.prototype.GetOptions(self)

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

	opts["hpos"] = {
		type = "range",
		name = "Horizontal Position",
		desc = "Horizontal Position",
		get = function()
			return self.moduleSettings.hpos
		end,
		set = function(info, v)
			self.moduleSettings.hpos = v
			self:Redraw()
		end,
		min = -700,
		max = 700,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 31
	}

	opts["lacerateFontSize"] = {
		type = "range",
		name = "Lacerate Count Font Size",
		desc = "Lacerate Count Font Size",
		get = function()
			return self.moduleSettings.lacerateFontSize
		end,
		set = function(info, v)
			self.moduleSettings.lacerateFontSize = v
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

	opts["lacerateMode"] = {
		type = 'select',
		name = "Display Mode",
		desc = "Show graphical or numeric lacerates",
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.lacerateMode)
		end,
		set = function(info, v)
			self.moduleSettings.lacerateMode = info.option.values[v]
			self:CreateLacerateFrame(true)
			self:Redraw()
			IceHUD:NotifyOptionsChange()
		end,
		values = { "Numeric", "Graphical Bar", "Graphical Circle", "Graphical Glow", "Graphical Clean Circle" },
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 33
	}

	opts["lacerateGap"] = {
		type = 'range',
		name = 'Lacerate gap',
		desc = 'Spacing between each lacerate count (only works for graphical mode)',
		min = 0,
		max = 100,
		step = 1,
		get = function()
			return self.moduleSettings.lacerateGap
		end,
		set = function(info, v)
			self.moduleSettings.lacerateGap = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or self.moduleSettings.lacerateMode == "Numeric"
		end,
		order = 33.2
	}

	opts["gradient"] = {
		type = "toggle",
		name = "Change color",
		desc = "1 lacerate: yellow, 5 lacerates: red",
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
function LacerateCount.prototype:GetDefaultSettings()
	local defaults =  LacerateCount.super.prototype.GetDefaultSettings(self)
	defaults["vpos"] = -20
	defaults["hpos"] = 0
	defaults["lacerateFontSize"] = 20
	defaults["lacerateMode"] = "Numeric"
	defaults["gradient"] = false
	defaults["usesDogTagStrings"] = false
	defaults["alwaysFullAlpha"] = true
	defaults["lacerateGap"] = 0
	return defaults
end


-- OVERRIDE
function LacerateCount.prototype:Redraw()
	LacerateCount.super.prototype.Redraw(self)

	self:CreateFrame()
	self:UpdateLacerateCount()
end


-- OVERRIDE
function LacerateCount.prototype:Enable(core)
	LacerateCount.super.prototype.Enable(self, core)

	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateLacerateCount")
	self:RegisterEvent("UNIT_AURA", "UpdateLacerateCount")

	if self.moduleSettings.lacerateMode == "Graphical" then
		self.moduleSettings.lacerateMode = "Graphical Bar"
	end

	self:CreateLacerateFrame(true)
end



-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function LacerateCount.prototype:CreateFrame()
	LacerateCount.super.prototype.CreateFrame(self)

	self.frame:SetFrameStrata("BACKGROUND")
	self.frame:SetWidth(self.lacerateSize*5)
	self.frame:SetHeight(1)
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOP", self.parent, "BOTTOM", self.moduleSettings.hpos, self.moduleSettings.vpos)

	self:Show(true)

	self:CreateLacerateFrame()
end



function LacerateCount.prototype:CreateLacerateFrame(doTextureUpdate)
	-- create numeric lacerates
	self.frame.numeric = self:FontFactory(self.moduleSettings.lacerateFontSize, nil, self.frame.numeric)

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
			if self.moduleSettings.lacerateMode == "Graphical Bar" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboBG")
			elseif self.moduleSettings.lacerateMode == "Graphical Circle" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboRoundBG")
			elseif self.moduleSettings.lacerateMode == "Graphical Glow" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboGlowBG")
			elseif self.moduleSettings.lacerateMode == "Graphical Clean Circle" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboCleanCurvesBG")
			end
		end

		self.frame.graphicalBG[i]:SetFrameStrata("BACKGROUND")
		self.frame.graphicalBG[i]:SetWidth(self.lacerateSize)
		self.frame.graphicalBG[i]:SetHeight(self.lacerateSize)
		self.frame.graphicalBG[i]:SetPoint("TOPLEFT", (i-1) * (self.lacerateSize-5) + (i-1) + ((i-1) * self.moduleSettings.lacerateGap), 0)
		self.frame.graphicalBG[i]:SetAlpha(0.15)
		self.frame.graphicalBG[i].texture:SetVertexColor(self:GetColor("LacerateCount"))

		self.frame.graphicalBG[i]:Hide()
	end

	-- create lacerates
	for i = 1, 5 do
		if (not self.frame.graphical[i]) then
			local frame = CreateFrame("Frame", nil, self.frame)
			self.frame.graphical[i] = frame
			frame.texture = frame:CreateTexture()
			frame.texture:SetAllPoints(frame)
		end

		if doTextureUpdate then
			if self.moduleSettings.lacerateMode == "Graphical Bar" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "Combo")
			elseif self.moduleSettings.lacerateMode == "Graphical Circle" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "ComboRound")
			elseif self.moduleSettings.lacerateMode == "Graphical Glow" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "ComboGlow")
			elseif self.moduleSettings.lacerateMode == "Graphical Clean Circle" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "ComboCleanCurves")
			end
		end

		self.frame.graphical[i]:SetFrameStrata("BACKGROUND")
		self.frame.graphical[i]:SetAllPoints(self.frame.graphicalBG[i])

		local r, g, b = self:GetColor("LacerateCount")
		if (self.moduleSettings.gradient) then
			g = g - (0.15*i)
		end
		self.frame.graphical[i].texture:SetVertexColor(r, g, b)

		self.frame.graphical[i]:Hide()
	end
end


function LacerateCount.prototype:UpdateLacerateCount()
	local points
	if IceHUD.IceCore:IsInConfigMode() then
		points = 5
	else
		points = IceHUD:GetDebuffCount("target", "Ability_Druid_Lacerate", true)
	end

	if (points == 0) then
		points = nil
	end

	if (self.moduleSettings.lacerateMode == "Numeric") then
		local r, g, b = self:GetColor("LacerateCount")
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
if (unitClass == "DRUID") then
	IceHUD.LacerateCount = LacerateCount:new()
end
