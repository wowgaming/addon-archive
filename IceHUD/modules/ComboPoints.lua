local ComboPoints = IceCore_CreateClass(IceElement)

ComboPoints.prototype.comboSize = 20

-- Constructor --
function ComboPoints.prototype:init()
	ComboPoints.super.prototype.init(self, "ComboPoints")

	self:SetDefaultColor("ComboPoints", 1, 1, 0)
	self.scalingEnabled = true
end



-- 'Public' methods -----------------------------------------------------------


-- OVERRIDE
function ComboPoints.prototype:GetOptions()
	local opts = ComboPoints.super.prototype.GetOptions(self)

	opts["headerLookAndFeel"] = {
		type = 'header',
		name = 'Look and Feel',
		order = 29.9
	}

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

	opts["comboFontSize"] = {
		type = "range",
		name = "Combo Points Font Size",
		desc = "Combo Points Font Size",
		get = function()
			return self.moduleSettings.comboFontSize
		end,
		set = function(info, v)
			self.moduleSettings.comboFontSize = v
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

	opts["comboMode"] = {
		type = 'select',
		name = "Display Mode",
		desc = "Show graphical or numeric combo points",
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.comboMode)
		end,
		set = function(info, v)
			self.moduleSettings.comboMode = info.option.values[v]
			self:CreateComboFrame(true)
			self:Redraw()
			IceHUD:NotifyOptionsChange()
		end,
		values = { "Numeric", "Graphical Bar", "Graphical Circle", "Graphical Glow", "Graphical Clean Circle" },
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 33
	}

	opts["graphicalLayout"] = {
		type = 'select',
		name = 'Layout',
		desc = 'How the graphical combo points should be displayed',
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.graphicalLayout)
		end,
		set = function(info, v)
			self.moduleSettings.graphicalLayout = info.option.values[v]
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or self.moduleSettings.comboMode == "Numeric"
		end,
		values = {"Horizontal", "Vertical"},
		order = 33.1
	}

	opts["comboGap"] = {
		type = 'range',
		name = 'Combo gap',
		desc = 'Spacing between each combo point (only works for graphical mode)',
		min = 0,
		max = 100,
		step = 1,
		get = function()
			return self.moduleSettings.comboGap
		end,
		set = function(info, v)
			self.moduleSettings.comboGap = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or self.moduleSettings.comboMode == "Numeric"
		end,
		order = 33.2
	}

	opts["gradient"] = {
		type = "toggle",
		name = "Change color",
		desc = "1 combo point: yellow, 5 combo points: red",
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
function ComboPoints.prototype:GetDefaultSettings()
	local defaults =  ComboPoints.super.prototype.GetDefaultSettings(self)
	defaults["vpos"] = 0
	defaults["hpos"] = 0
	defaults["comboFontSize"] = 20
	defaults["comboMode"] = "Numeric"
	defaults["gradient"] = false
	defaults["usesDogTagStrings"] = false
	defaults["alwaysFullAlpha"] = true
	defaults["graphicalLayout"] = "Horizontal"
	defaults["comboGap"] = 0
	return defaults
end


-- OVERRIDE
function ComboPoints.prototype:Redraw()
	ComboPoints.super.prototype.Redraw(self)

	self:CreateFrame()
	self:UpdateComboPoints()
end


-- OVERRIDE
function ComboPoints.prototype:Enable(core)
	ComboPoints.super.prototype.Enable(self, core)

	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateComboPoints")
	if IceHUD.WowVer >= 30000 then
		self:RegisterEvent("UNIT_COMBO_POINTS", "UpdateComboPoints")
		self:RegisterEvent("UNIT_ENTERED_VEHICLE", "UpdateComboPoints")
		self:RegisterEvent("UNIT_EXITED_VEHICLE", "UpdateComboPoints")
	else
		self:RegisterEvent("PLAYER_COMBO_POINTS", "UpdateComboPoints")
	end

	if self.moduleSettings.comboMode == "Graphical" then
		self.moduleSettings.comboMode = "Graphical Bar"
	end

	self:CreateComboFrame(true)
end



-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function ComboPoints.prototype:CreateFrame()
	ComboPoints.super.prototype.CreateFrame(self)

	self.frame:SetFrameStrata("BACKGROUND")
	if self.moduleSettings.graphicalLayout == "Horizontal" then
		self.frame:SetWidth(self.comboSize*5)
		self.frame:SetHeight(1)
	else
		self.frame:SetWidth(1)
		self.frame:SetHeight(self.comboSize*5)
	end
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOP", self.parent, "BOTTOM", self.moduleSettings.hpos, self.moduleSettings.vpos)

	self:Show(true)

	self:CreateComboFrame()
end



function ComboPoints.prototype:CreateComboFrame(forceTextureUpdate)
	-- create numeric combo points
	self.frame.numeric = self:FontFactory(self.moduleSettings.comboFontSize, nil, self.frame.numeric)

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

		if forceTextureUpdate then
			if self.moduleSettings.comboMode == "Graphical Bar" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboBG")
			elseif self.moduleSettings.comboMode == "Graphical Circle" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboRoundBG")
			elseif self.moduleSettings.comboMode == "Graphical Glow" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboGlowBG")
			elseif self.moduleSettings.comboMode == "Graphical Clean Circle" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboCleanCurvesBG")
			end
		end

		self.frame.graphicalBG[i]:SetFrameStrata("BACKGROUND")
		self.frame.graphicalBG[i]:SetWidth(self.comboSize)
		self.frame.graphicalBG[i]:SetHeight(self.comboSize)
		if self.moduleSettings.graphicalLayout == "Horizontal" then
			self.frame.graphicalBG[i]:SetPoint("TOPLEFT", ((i-1) * (self.comboSize-5)) + (i-1) + ((i-1) * self.moduleSettings.comboGap), 0)
		else
			self.frame.graphicalBG[i]:SetPoint("TOPLEFT", 0, -1 * (((i-1) * (self.comboSize-5)) + (i-1) + ((i-1) * self.moduleSettings.comboGap)))
		end
		self.frame.graphicalBG[i]:SetAlpha(0.15)
		self.frame.graphicalBG[i].texture:SetVertexColor(self:GetColor("ComboPoints"))

		self.frame.graphicalBG[i]:Hide()
	end

	-- create combo points
	for i = 1, 5 do
		if (not self.frame.graphical[i]) then
			local frame = CreateFrame("Frame", nil, self.frame)
			self.frame.graphical[i] = frame
			frame.texture = frame:CreateTexture()
			frame.texture:SetAllPoints(frame)
		end

		if forceTextureUpdate then
			if self.moduleSettings.comboMode == "Graphical Bar" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "Combo")
			elseif self.moduleSettings.comboMode == "Graphical Circle" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "ComboRound")
			elseif self.moduleSettings.comboMode == "Graphical Glow" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "ComboGlow")
			elseif self.moduleSettings.comboMode == "Graphical Clean Circle" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "ComboCleanCurves")
			end
		end

		self.frame.graphical[i]:SetFrameStrata("LOW")
		self.frame.graphical[i]:SetAllPoints(self.frame.graphicalBG[i])

		local r, g, b = self:GetColor("ComboPoints")
		if (self.moduleSettings.gradient) then
			g = g - (0.15*i)
		end
		self.frame.graphical[i].texture:SetVertexColor(r, g, b)

		self.frame.graphical[i]:Hide()
	end
end

function ComboPoints.prototype:UpdateComboPoints()
	local points
	if IceHUD.IceCore:IsInConfigMode() then
		points = 5
	elseif IceHUD.WowVer >= 30000 then
		-- Parnic: apparently some fights have combo points while the player is in a vehicle?
		local isInVehicle = UnitHasVehicleUI("player")
		points = GetComboPoints(isInVehicle and "vehicle" or "player", "target")
	else
		points = GetComboPoints("target")
	end

	if (points == 0) then
		points = nil
	end

	if (self.moduleSettings.comboMode == "Numeric") then
		local r, g, b = self:GetColor("ComboPoints")
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
-- Parnic: removed the rogue-/druid-only restriction since the Malygos fight needs combo points on the drakes
--local _, unitClass = UnitClass("player")
--if (unitClass == "DRUID" or unitClass == "ROGUE") then
	IceHUD.ComboPoints = ComboPoints:new()
--end
