IceClassPowerCounter = IceCore_CreateClass(IceElement)

IceClassPowerCounter.prototype.runeHeight = 22
IceClassPowerCounter.prototype.runeWidth = 36
IceClassPowerCounter.prototype.numRunes = 3
IceClassPowerCounter.prototype.lastNumReady = 0
IceClassPowerCounter.prototype.runeCoords = {}
IceClassPowerCounter.prototype.runeShineFadeSpeed = 0.4

-- Constructor --
function IceClassPowerCounter.prototype:init(name)
	assert(name ~= nil, "ClassPowerCounter cannot be instantiated directly - supply a name from the child class and pass it up.")
	IceClassPowerCounter.super.prototype.init(self, name)

	self.scalingEnabled = true
end

-- 'Public' methods -----------------------------------------------------------


-- OVERRIDE
function IceClassPowerCounter.prototype:GetOptions()
	local opts = IceClassPowerCounter.super.prototype.GetOptions(self)

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
		max = 300,
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
		min = -500,
		max = 500,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 31
	}

	opts["hideBlizz"] = {
		type = "toggle",
		name = "Hide Blizzard Frame",
		desc = "Hides Blizzard frame and disables all events related to it.\n\nNOTE: Blizzard attaches this UI to the player's unitframe, so if you have that hidden in PlayerHealth, then this won't do anything.",
		get = function()
			return self.moduleSettings.hideBlizz
		end,
		set = function(info, value)
			self.moduleSettings.hideBlizz = value
			if (value) then
				self:HideBlizz()
			else
				self:ShowBlizz()
			end
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 32
	}

	opts["displayMode"] = {
		type = 'select',
		name = 'Display mode',
		desc = "Choose whether you'd like a graphical or numeric representation of the runes.\n\nNOTE: The color of 'Numeric' mode can be controlled by the HolyPowerNumeric color.",
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.runeMode)
		end,
		set = function(info, v)
			self.moduleSettings.runeMode = info.option.values[v]
			self:SetDisplayMode()
			self:UpdateRunePower()
		end,
		values = { "Graphical", "Numeric" },
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 34
	}

	opts["runeGap"] = {
		type = 'range',
		name = 'Rune gap',
		desc = 'Spacing between each rune (only works for graphical mode)',
		min = 0,
		max = 100,
		step = 1,
		get = function()
			return self.moduleSettings.runeGap
		end,
		set = function(info, v)
			self.moduleSettings.runeGap = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		hidden = function()
			return self.moduleSettings.runeMode ~= "Graphical"
		end,
		order = 34.1
	}

	opts["runeOrientation"] = {
		type = 'select',
		name = 'Rune orientation',
		desc = 'Whether the runes should draw side-by-side or on top of one another',
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.displayMode)
		end,
		set = function(info, v)
			self.moduleSettings.displayMode = info.option.values[v]
			self:Redraw()
		end,
		values = { "Horizontal", "Vertical" },
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		hidden = function()
			return self.moduleSettings.runeMode ~= "Graphical"
		end,
		order = 35
	}

	opts["inactiveDisplayMode"] = {
		type = 'select',
		name = 'Inactive mode',
		desc = "This controls what happens to runes that are inactive. Darkened means they are visible but colored black, Hidden means they are not displayed.",
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.inactiveDisplayMode)
		end,
		set = function(info, v)
			self.moduleSettings.inactiveDisplayMode = info.option.values[v]
			self:SetDisplayMode()
			self:UpdateRunePower()
		end,
		values = { "Darkened", "Hidden" },
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		hidden = function()
			return self.moduleSettings.runeMode ~= "Graphical"
		end,
		order = 36
	}

	opts["flashWhenReady"] = {
		type = "toggle",
		name = "Flash when ready",
		desc = "Shows a flash behind each holy rune when it becomes available.",
		get = function()
			return self.moduleSettings.flashWhenBecomingReady
		end,
		set = function(info, value)
			self.moduleSettings.flashWhenBecomingReady = value
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		hidden = function()
			return self.moduleSettings.runeMode ~= "Graphical"
		end,
		order = 37
	}

	return opts
end


-- OVERRIDE
function IceClassPowerCounter.prototype:GetDefaultSettings()
	local defaults =  IceClassPowerCounter.super.prototype.GetDefaultSettings(self)

	defaults["vpos"] = 0
	defaults["hpos"] = 10
	defaults["runeFontSize"] = 20
	defaults["runeMode"] = "Graphical"
	defaults["usesDogTagStrings"] = false
	defaults["hideBlizz"] = false
	defaults["alwaysFullAlpha"] = false
	defaults["displayMode"] = "Horizontal"
	defaults["runeGap"] = 0
	defaults["flashWhenBecomingReady"] = true
	defaults["inactiveDisplayMode"] = "Darkened"

	return defaults
end


-- OVERRIDE
function IceClassPowerCounter.prototype:Redraw()
	IceClassPowerCounter.super.prototype.Redraw(self)

	self:CreateFrame()
end


-- OVERRIDE
function IceClassPowerCounter.prototype:Enable(core)
	IceClassPowerCounter.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_POWER", "UpdateRunePower")
	self:RegisterEvent("UNIT_DISPLAYPOWER", "UpdateRunePower")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateRunePower")

	if (self.moduleSettings.hideBlizz) then
		self:HideBlizz()
	end
end

function IceClassPowerCounter.prototype:Disable(core)
	IceClassPowerCounter.super.prototype.Disable(self, core)

	if self.moduleSettings.hideBlizz then
		self:ShowBlizz()
	end
end

function IceClassPowerCounter.prototype:UpdateRunePower()
	local numReady = UnitPower("player", self.unitPower)

	if self.moduleSettings.runeMode == "Graphical" then
		for i=1, self.numRunes do
			if i <= numReady then
				self.frame.graphical[i].rune:SetVertexColor(1, 1, 1)

				if self.moduleSettings.inactiveDisplayMode == "Hidden" then
					self.frame.graphical[i]:Show()
				end

				if i > self.lastNumReady and self.moduleSettings.flashWhenBecomingReady then
					local fadeInfo={
						mode = "IN",
						timeToFade = self.runeShineFadeSpeed,
						finishedFunc = function() self:ShineFinished(i) end,
						finishedArg1 = i
					}
					UIFrameFade(self.frame.graphical[i].shine, fadeInfo);
				end
			else
				if self.moduleSettings.inactiveDisplayMode == "Darkened" then
					self.frame.graphical[i].rune:SetVertexColor(0, 0, 0)
				elseif self.moduleSettings.inactiveDisplayMode == "Hidden" then
					self.frame.graphical[i]:Hide()
				end
			end
		end
	elseif self.moduleSettings.runeMode == "Numeric" then
		self.frame.numeric:SetText(tostring(numReady))
		self.frame.numeric:SetTextColor(self:GetColor(self.numericColor))
	end

	self.lastNumReady = numReady

	if (self.moduleSettings.hideBlizz) then
		self:HideBlizz()
	end
end

function IceClassPowerCounter.prototype:ShineFinished(rune)
	UIFrameFadeOut(self.frame.graphical[rune].shine, self.runeShineFadeSpeed);
end

function IceClassPowerCounter.prototype:GetRuneTexture(rune)
	assert(true, "Must override GetRuneTexture in child classes")
end


function IceClassPowerCounter.prototype:CreateFrame()
	IceClassPowerCounter.super.prototype.CreateFrame(self)

	self.frame:SetFrameStrata("BACKGROUND")
	self.frame:SetWidth(self.runeWidth*self.numRunes)
	self.frame:SetHeight(self.runeHeight)
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOP", self.parent, "BOTTOM", self.moduleSettings.hpos, self.moduleSettings.vpos)

	self:CreateRuneFrame()

	self:SetDisplayMode()
end

function IceClassPowerCounter.prototype:SetDisplayMode()
	if self.moduleSettings.runeMode == "Graphical" then
		self.frame.numeric:Hide()
		for i=1, self.numRunes do
			self.frame.graphical[i]:Show()
		end
	elseif self.moduleSettings.runeMode == "Numeric" then
		self.frame.numeric:Show()
		for i=1, self.numRunes do
			self.frame.graphical[i]:Hide()
		end
	end
end

function IceClassPowerCounter.prototype:CreateRuneFrame()
	-- create numeric runes
	self.frame.numeric = self:FontFactory(self.moduleSettings.runeFontSize, nil, self.frame.numeric)

	self.frame.numeric:SetWidth(50)
	self.frame.numeric:SetJustifyH("CENTER")

	self.frame.numeric:SetPoint("TOP", self.frame, "TOP", 0, 0)
	self.frame.numeric:Hide()

	if (not self.frame.graphical) then
		self.frame.graphical = {}
	end

	for i=1, self.numRunes do
		self:CreateRune(i)
	end
end

function IceClassPowerCounter.prototype:CreateRune(i)
	-- create runes
	if (not self.frame.graphical[i]) then
		self.frame.graphical[i] = CreateFrame("Frame", nil, self.frame)
		self.frame.graphical[i].rune = self.frame.graphical[i]:CreateTexture(nil, "LOW")
		self.frame.graphical[i].rune:SetAllPoints(self.frame.graphical[i])
		self.frame.graphical[i].shine = self.frame.graphical[i]:CreateTexture(nil, "OVERLAY")

		self:SetupRuneTexture(i)
		self.frame.graphical[i].rune:SetVertexColor(0, 0, 0)
	end

	self.frame.graphical[i]:SetFrameStrata("BACKGROUND")
	self.frame.graphical[i]:SetWidth(self.runeWidth)
	self.frame.graphical[i]:SetHeight(self.runeHeight)

	if self.moduleSettings.displayMode == "Horizontal" then
		self.frame.graphical[i]:SetPoint("TOPLEFT", (i-1) * (self.runeWidth-5) + (i-1) + ((i-1) * self.moduleSettings.runeGap), 0)
	else
		self.frame.graphical[i]:SetPoint("TOPLEFT", 0, -1 * ((i-1) * (self.runeHeight-5) + (i-1) + ((i-1) * self.moduleSettings.runeGap)))
	end

	self.frame.graphical[i]:Hide()

	self.frame.graphical[i].shine:SetTexture("Interface\\ComboFrame\\ComboPoint")
	self.frame.graphical[i].shine:SetBlendMode("ADD")
	self.frame.graphical[i].shine:SetTexCoord(0.5625, 1, 0, 1)
	self.frame.graphical[i].shine:ClearAllPoints()
	self.frame.graphical[i].shine:SetPoint("CENTER", self.frame.graphical[i], "CENTER")
	self.frame.graphical[i].shine:SetWidth(self.runeWidth + 25)
	self.frame.graphical[i].shine:SetHeight(self.runeHeight + 10)
	self.frame.graphical[i].shine:Hide()
end

function IceClassPowerCounter.prototype:SetupRuneTexture(rune)
	if not rune or rune < 1 or rune > #self.runeCoords then
		return
	end

	self.frame.graphical[rune].rune:SetTexture(self:GetRuneTexture(rune))
	local a,b,c,d = unpack(self.runeCoords[rune])
	self.frame.graphical[rune].rune:SetTexCoord(a, b, c, d)
end

function IceClassPowerCounter.prototype:GetAlphaAdd()
	return 0.15
end

function IceClassPowerCounter.prototype:TargetChanged()
	IceClassPowerCounter.super.prototype.TargetChanged(self)
	-- sort of a hack fix...if "ooc" alpha is set to 0, then the runes frame is all jacked up when the user spawns in
	-- need to re-run CreateFrame in order to setup the frame properly. not sure why :(
	self:Redraw()
end

function IceClassPowerCounter.prototype:InCombat()
	IceClassPowerCounter.super.prototype.InCombat(self)
	self:Redraw()
end

function IceClassPowerCounter.prototype:OutCombat()
	IceClassPowerCounter.super.prototype.OutCombat(self)
	self:Redraw()
end

function IceClassPowerCounter.prototype:CheckCombat()
	IceClassPowerCounter.super.prototype.CheckCombat(self)
	self:Redraw()
end

function IceClassPowerCounter.prototype:HideBlizz()
	assert(true, "Must override HideBlizz in child classes.")
end
