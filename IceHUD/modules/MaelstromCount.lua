local MaelstromCount = IceCore_CreateClass(IceElement)

MaelstromCount.prototype.maelstromSize = 20

-- Constructor --
function MaelstromCount.prototype:init()
	MaelstromCount.super.prototype.init(self, "MaelstromCount")

	self:SetDefaultColor("MaelstromCount", 1, 1, 0)
	self.scalingEnabled = true
end



-- 'Public' methods -----------------------------------------------------------


-- OVERRIDE
function MaelstromCount.prototype:GetOptions()
	local opts = MaelstromCount.super.prototype.GetOptions(self)

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

	opts["maelstromFontSize"] = {
		type = "range",
		name = "Maelstrom Count Font Size",
		desc = "Maelstrom Count Font Size",
		get = function()
			return self.moduleSettings.maelstromFontSize
		end,
		set = function(info, v)
			self.moduleSettings.maelstromFontSize = v
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

	opts["maelstromMode"] = {
		type = 'select',
		name = "Display Mode",
		desc = "Show graphical or numeric maelstroms",
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.maelstromMode)
		end,
		set = function(info, v)
			self.moduleSettings.maelstromMode = info.option.values[v]
			self:CreateMaelstromFrame(true)
			self:Redraw()
			IceHUD:NotifyOptionsChange()
		end,
		values = { "Numeric", "Graphical Bar", "Graphical Circle", "Graphical Glow", "Graphical Clean Circle" },
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 33
	}

	opts["maelstromGap"] = {
		type = 'range',
		name = 'Maelstrom gap',
		desc = 'Spacing between each maelstrom point (only works for graphical mode)',
		min = 0,
		max = 100,
		step = 1,
		get = function()
			return self.moduleSettings.maelstromGap
		end,
		set = function(info, v)
			self.moduleSettings.maelstromGap = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or self.moduleSettings.maelstromMode == "Numeric"
		end,
		order = 33.2
	}

	opts["gradient"] = {
		type = "toggle",
		name = "Change color",
		desc = "1 maelstrom: yellow, 5 maelstroms: red",
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
function MaelstromCount.prototype:GetDefaultSettings()
	local defaults =  MaelstromCount.super.prototype.GetDefaultSettings(self)
	defaults["vpos"] = 0
	defaults["maelstromFontSize"] = 20
	defaults["maelstromMode"] = "Numeric"
	defaults["gradient"] = false
	defaults["usesDogTagStrings"] = false
	defaults["alwaysFullAlpha"] = true
	defaults["maelstromGap"] = 0
	return defaults
end


-- OVERRIDE
function MaelstromCount.prototype:Redraw()
	MaelstromCount.super.prototype.Redraw(self)

	self:CreateFrame()
	self:UpdateMaelstromCount()
end


-- OVERRIDE
function MaelstromCount.prototype:Enable(core)
	MaelstromCount.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_AURA", "UpdateMaelstromCount")

	self:CreateMaelstromFrame(true)
end



-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function MaelstromCount.prototype:CreateFrame()
	MaelstromCount.super.prototype.CreateFrame(self)

	self.frame:SetFrameStrata("BACKGROUND")
	self.frame:SetWidth(self.maelstromSize*5)
	self.frame:SetHeight(1)
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOP", self.parent, "BOTTOM", 0, self.moduleSettings.vpos)

	self:Show(true)

	self:CreateMaelstromFrame()
end



function MaelstromCount.prototype:CreateMaelstromFrame(doTextureUpdate)
	-- create numeric maelstroms
	self.frame.numeric = self:FontFactory(self.moduleSettings.maelstromFontSize, nil, self.frame.numeric)

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
			if self.moduleSettings.maelstromMode == "Graphical Bar" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboBG")
			elseif self.moduleSettings.maelstromMode == "Graphical Circle" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboRoundBG")
			elseif self.moduleSettings.maelstromMode == "Graphical Glow" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboGlowBG")
			elseif self.moduleSettings.maelstromMode == "Graphical Clean Circle" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboCleanCurvesBG")
			end
		end

		self.frame.graphicalBG[i]:SetFrameStrata("BACKGROUND")
		self.frame.graphicalBG[i]:SetWidth(self.maelstromSize)
		self.frame.graphicalBG[i]:SetHeight(self.maelstromSize)
		self.frame.graphicalBG[i]:SetPoint("TOPLEFT", (i-1) * (self.maelstromSize-5) + (i-1) + ((i-1) * self.moduleSettings.maelstromGap), 0)
		self.frame.graphicalBG[i]:SetAlpha(0.15)
		self.frame.graphicalBG[i].texture:SetVertexColor(self:GetColor("MaelstromCount"))

		self.frame.graphicalBG[i]:Hide()
	end

	-- create maelstroms
	for i = 1, 5 do
		if (not self.frame.graphical[i]) then
			local frame = CreateFrame("Frame", nil, self.frame)
			self.frame.graphical[i] = frame
			frame.texture = frame:CreateTexture()
			frame.texture:SetAllPoints(frame)
		end

		if doTextureUpdate then
			if self.moduleSettings.maelstromMode == "Graphical Bar" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "Combo")
			elseif self.moduleSettings.maelstromMode == "Graphical Circle" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "ComboRound")
			elseif self.moduleSettings.maelstromMode == "Graphical Glow" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "ComboGlow")
			elseif self.moduleSettings.maelstromMode == "Graphical Clean Circle" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "ComboCleanCurves")
			end
		end

		self.frame.graphical[i]:SetFrameStrata("BACKGROUND")
		self.frame.graphical[i]:SetAllPoints(self.frame.graphicalBG[i])

		local r, g, b = self:GetColor("MaelstromCount")
		if (self.moduleSettings.gradient) then
			g = g - (0.15*i)
		end
		self.frame.graphical[i].texture:SetVertexColor(r, g, b)

		self.frame.graphical[i]:Hide()
	end
end


function MaelstromCount.prototype:UpdateMaelstromCount(event, unit)
	if unit and unit ~= "player" then
		return
	end

	local points
	if IceHUD.IceCore:IsInConfigMode() then
		points = 5
	else
		points = IceHUD:GetBuffCount("player", "Spell_Shaman_MaelstromWeapon")
	end

	if (points == 0) then
		points = nil
	end

	if (self.moduleSettings.maelstromMode == "Numeric") then
		local r, g, b = self:GetColor("MaelstromCount")
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
if (unitClass == "SHAMAN") then
	IceHUD.MaelstromCount = MaelstromCount:new()
end
