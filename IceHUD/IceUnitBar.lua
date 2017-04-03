IceUnitBar = IceCore_CreateClass(IceBarElement)

IceUnitBar.prototype.unit = nil
IceUnitBar.prototype.alive = nil
IceUnitBar.prototype.tapped = nil

IceUnitBar.prototype.health = nil
IceUnitBar.prototype.maxHealth = nil
IceUnitBar.prototype.healthPercentage = nil
IceUnitBar.prototype.mana = nil
IceUnitBar.prototype.maxMana = nil
IceUnitBar.prototype.manaPercentage = nil
IceUnitBar.prototype.scaleHPColorInst = nil
IceUnitBar.prototype.scaleMPColorInst = nil

IceUnitBar.prototype.unitClass = nil
IceUnitBar.prototype.hasPet = nil

IceUnitBar.prototype.noFlash = nil

-- Constructor --
function IceUnitBar.prototype:init(name, unit)
	IceUnitBar.super.prototype.init(self, name)
	assert(unit, "IceUnitBar 'unit' is nil")

	self:SetUnit(unit)
	self.noFlash = false

	self:SetDefaultColor("Dead", 0.5, 0.5, 0.5)
	self:SetDefaultColor("Tapped", 0.8, 0.8, 0.8)

	self:SetDefaultColor("ScaledHealthColor", 0, 1, 0)
	self:SetDefaultColor("MaxHealthColor", 0, 255, 0)
	self:SetDefaultColor("MidHealthColor", 255, 255, 0)
	self:SetDefaultColor("MinHealthColor", 255, 0, 0)

	self:SetDefaultColor("ScaledManaColor", 0, 0, 1)
	self:SetDefaultColor("MaxManaColor", 0, 0, 255)
	self:SetDefaultColor("MidManaColor", 125, 0, 255)
	self:SetDefaultColor("MinManaColor", 255, 0, 255)

	self.scaleHPColorInst = { r = 0, g = 255, b = 0 }
	self.scaleMPColorInst = { r = 0, g = 0, b = 255 }
end

function IceUnitBar.prototype:SetUnit(unit)
	self.unit = unit
	_, self.unitClass = UnitClass(self.unit)
end

-- OVERRIDE
function IceUnitBar.prototype:GetDefaultSettings()
	local settings = IceUnitBar.super.prototype.GetDefaultSettings(self)

	settings["lowThreshold"] = 0
	settings["lowThresholdFlash" ] = true
	settings["lowThresholdColor"] = false
	settings["scaleHealthColor"] = true
	settings["scaleManaColor"] = true

	return settings
end


-- OVERRIDE
function IceUnitBar.prototype:GetOptions()
	local opts = IceUnitBar.super.prototype.GetOptions(self)

	opts["lowThreshold"] =
	{
		type = 'range',
		name =  'Low Threshold',
		desc = 'Threshold of pulsing the bar (0 means never) (for player applies only to mana, not rage/energy/runic power)',
		get = function()
			return self.moduleSettings.lowThreshold
		end,
		set = function(info, value)
			self.moduleSettings.lowThreshold = value
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		min = 0,
		max = 1,
		step = 0.05,
		isPercent = true,
		order = 30.091
	}
	opts["lowThresholdFlash"] = {
		type = 'toggle',
		name = 'Flash bar below Low Threshold',
		desc = 'Flashes the bar when it is below the Low Threshold specified above',
		width = 'double',
		get = function()
			return self.moduleSettings.lowThresholdFlash
		end,
		set = function(info, v)
			self.moduleSettings.lowThresholdFlash = v
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 30.092
	}
	opts["lowThresholdColor"] = {
		type = "toggle",
		name = "Low Threshold color",
		desc = "Colors the bar minColor when % is < lowThreshold (requires scaleColor to be enabled)",
		get = function()
			return self.moduleSettings.lowThresholdColor
		end,
		set = function(info, value)
			self.moduleSettings.lowThresholdColor = value
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or not (self.moduleSettings.scaleHealthColor and self.moduleSettings.scaleManaColor)
		end,
		order = 30.093
	}

	return opts
end


-- 'Public' methods -----------------------------------------------------------

function IceUnitBar.prototype:Enable()
	IceUnitBar.super.prototype.Enable(self)

	self:RegisterEvent("PLAYER_UNGHOST", "Alive")
	self:RegisterEvent("PLAYER_ALIVE", "Alive")
	self:RegisterEvent("PLAYER_DEAD", "Dead")

	self.alive = not UnitIsDeadOrGhost(self.unit)
	self.combat = UnitAffectingCombat(self.unit)
end


-- OVERRIDE
function IceUnitBar.prototype:Redraw()
	IceUnitBar.super.prototype.Redraw(self)

	if (self.moduleSettings.enabled) then
		self:Update(self.unit)
	end
end





-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function IceUnitBar.prototype:CreateFrame()
	IceUnitBar.super.prototype.CreateFrame(self)

	self:CreateFlashFrame()
end

-- Creates the low amount warning frame
function IceUnitBar.prototype:CreateFlashFrame()
	if not (self.flashFrame) then
		self.flashFrame = CreateFrame("Frame", nil, self.frame)
	end

	self.flashFrame:SetFrameStrata("BACKGROUND")
	self.flashFrame:SetWidth(self.settings.barWidth + (self.moduleSettings.widthModifier or 0))
	self.flashFrame:SetHeight(self.settings.barHeight)


	if not (self.flashFrame.flash) then
		self.flashFrame.flash = self.flashFrame:CreateTexture(nil, "BACKGROUND")
	end

	self.flashFrame.flash:SetTexture(IceElement.TexturePath .. self:GetMyBarTexture())
	self.flashFrame.flash:SetBlendMode("ADD")
	self.flashFrame.flash:SetAllPoints(self.flashFrame)

	--self:SetScale(self.flashFrame.flash, 1)
	self.flashFrame:SetAlpha(0)

	self.flashFrame:ClearAllPoints()
	self.flashFrame:SetPoint("BOTTOM", self.frame, "BOTTOM", 0, 0)

	if (self.moduleSettings.side == IceCore.Side.Left) then
		self.flashFrame.flash:SetTexCoord(1, 0, 0, 1)
	else
		self.flashFrame.flash:SetTexCoord(0, 1, 0, 1)
	end
end


-- OVERRIDE
function IceUnitBar.prototype:Update()
	IceUnitBar.super.prototype.Update(self)

	self.tapped = UnitIsTapped(self.unit) and (not UnitIsTappedByPlayer(self.unit))

	self.health = UnitHealth(self.unit)
	self.maxHealth = UnitHealthMax(self.unit)
	self.healthPercentage = self.maxHealth ~= 0 and (self.health/self.maxHealth) or 0

	self.mana = UnitPower(self.unit)
	self.maxMana = UnitPowerMax(self.unit)
	self.manaPercentage = self.maxMana ~= 0 and (self.mana/self.maxMana) or 0

	_, self.unitClass = UnitClass(self.unit)

	if( self.moduleSettings.scaleHealthColor ) then
		if self.healthPercentage > 0.5 then
			self:SetScaledColor(self.scaleHPColorInst, self.healthPercentage * 2 - 1, self.settings.colors["MaxHealthColor"], self.settings.colors["MidHealthColor"])
		else
			self:SetScaledColor(self.scaleHPColorInst, self.healthPercentage * 2, self.settings.colors["MidHealthColor"], self.settings.colors["MinHealthColor"])
		end

		self.settings.colors["ScaledHealthColor"] = self.scaleHPColorInst
	end

	if( self.moduleSettings.scaleManaColor ) then
		if self.manaPercentage > 0.5 then
			self:SetScaledColor(self.scaleMPColorInst, self.manaPercentage * 2 - 1, self.settings.colors["MaxManaColor"], self.settings.colors["MidManaColor"])
		else
			self:SetScaledColor(self.scaleMPColorInst, self.manaPercentage * 2, self.settings.colors["MidManaColor"], self.settings.colors["MinManaColor"])
		end

		self.settings.colors["ScaledManaColor"] = self.scaleMPColorInst
	end

	-- This looks slightly quirky. Basically the easiest way for me to achieve this is to have lowThresholdColor override
	-- the scaled color. You'll need to switch them both on to get things to work.
	if( self.moduleSettings.lowThresholdColor ) then
		if( self.healthPercentage < self.moduleSettings.lowThreshold ) then
			self.settings.colors[ "ScaledHealthColor" ] = self.settings.colors[ "MinHealthColor" ]
		else
			self.settings.colors[ "ScaledHealthColor" ] = self.settings.colors[ "MaxHealthColor" ]
		end
		if( self.manaPercentage < self.moduleSettings.lowThreshold ) then
			self.settings.colors[ "ScaledManaColor" ] = self.settings.colors[ "MinManaColor" ]
		else
			self.settings.colors[ "ScaledManaColor" ] = self.settings.colors[ "MaxManaColor" ]
		end
	end
end


function IceUnitBar.prototype:Alive()
	-- instead of maintaining a state for 3 different things
	-- (dead, dead/ghost, alive) just afford the extra function call here
	self.alive = not UnitIsDeadOrGhost(self.unit)
	self:Update(self.unit)
end


function IceUnitBar.prototype:Dead()
	self.alive = false
	self:Update(self.unit)
end


-- OVERRIDE
function IceUnitBar.prototype:UpdateBar(scale, color, alpha)
	IceUnitBar.super.prototype.UpdateBar(self, scale, color, alpha)

	if (not self.flashFrame) then
		-- skip if flashFrame hasn't been created yet
		return
	end

	self.flashFrame.flash:SetVertexColor(self:GetColor(color))

	if (self.moduleSettings.lowThreshold > 0 and
		self.moduleSettings.lowThresholdFlash and
		self.moduleSettings.lowThreshold >= scale and self.alive and
		not self.noFlash) then
			self.flashFrame:SetScript("OnUpdate", function() self:OnFlashUpdate() end)
	else
		self.flashFrame:SetScript("OnUpdate", nil)
		self.flashFrame:SetAlpha(0)
	end
end


function IceUnitBar.prototype:OnFlashUpdate()
	local time = GetTime()
	local decimals = time - math.floor(time)

	if (decimals > 0.5) then
		decimals = 1 - decimals
	end

	decimals = decimals*1.1 -- add more dynamic to the color change

	self.flashFrame:SetAlpha(decimals)
end


function IceUnitBar.prototype:SetScaleColorEnabled(enabled)
	self.moduleSettings.scaleColor = enabled
end


