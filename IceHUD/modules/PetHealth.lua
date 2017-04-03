local PetHealth = IceCore_CreateClass(IceUnitBar)

PetHealth.prototype.happiness = nil


-- Constructor --
function PetHealth.prototype:init()
	PetHealth.super.prototype.init(self, "PetHealth", "pet")

	self:SetDefaultColor("PetHealthHappy", 37, 164, 30)
	self:SetDefaultColor("PetHealthContent", 164, 164, 30)
	self:SetDefaultColor("PetHealthUnhappy", 164, 30, 30)

	self.scalingEnabled = true
end


-- OVERRIDE
function PetHealth.prototype:GetDefaultSettings()
	local settings = PetHealth.super.prototype.GetDefaultSettings(self)

	settings["side"] = IceCore.Side.Left
	settings["offset"] = -1
	settings.scale = 0.7
	settings["textVerticalOffset"] = 4
	settings["upperText"] = "[PercentHP:Round]"
	settings["lowerText"] = ""
	settings["barVerticalOffset"] = 35
	settings["allowMouseInteraction"] = false

	return settings
end


-- OVERRIDE
--[[
function PetHealth.prototype:CreateFrame()
	PetHealth.super.prototype.CreateFrame(self)

	local point, relativeTo, relativePoint, xoff, yoff = self.frame.bottomUpperText:GetPoint()
	if (point == "TOPLEFT") then
		point = "BOTTOMLEFT"
	else
		point = "BOTTOMRIGHT"
	end

	self.frame.bottomUpperText:ClearAllPoints()
	self.frame.bottomUpperText:SetPoint(point, relativeTo, relativePoint, 0, 0)
end
]]

function PetHealth.prototype:Enable(core)
	PetHealth.super.prototype.Enable(self, core)

	self:RegisterEvent("PET_UI_UPDATE",	 "CheckPet");
	self:RegisterEvent("PLAYER_PET_CHANGED", "CheckPet");
	self:RegisterEvent("PET_BAR_CHANGED", "CheckPet");
	self:RegisterEvent("UNIT_PET", "CheckPet");

	self:RegisterEvent("UNIT_HEALTH", "UpdateEvent")
	self:RegisterEvent("UNIT_MAXHEALTH", "UpdateEvent")

	if IceHUD.WowVer >= 40000 then
		self:RegisterEvent("UNIT_POWER", "PetHappiness")
	else
		self:RegisterEvent("UNIT_HAPPINESS", "PetHappiness")
	end

	self.frame:SetAttribute("unit", self.unit)
	RegisterUnitWatch(self.frame)

	self:CheckPet()
end

function PetHealth.prototype:Disable(core)
	PetHealth.super.prototype.Disable(self, core)
	UnregisterUnitWatch(self.frame)
end

function PetHealth.prototype:PetHappiness(event, unit, powertype)
	if (unit and (unit ~= self.unit)) then
		return
	end

	if IceHUD.WowVer >= 40000 and (powertype == nil or powertype ~= "HAPPINESS") then
		return
	end

	self.happiness = GetPetHappiness()
	self.happiness = self.happiness or 3 -- '3' means happy
	self:Update(unit)
end


function PetHealth.prototype:CheckPet()
	if (UnitExists(self.unit)) then
		self:PetHappiness(nil, self.unit, "HAPPINESS")
		self:Update(self.unit)
	end
end


function PetHealth.prototype:UpdateEvent(event, unit)
	self:Update(unit)
end

function PetHealth.prototype:Update(unit)
	PetHealth.super.prototype.Update(self)
	if (unit and (unit ~= self.unit)) then
		return
	end

	local color = "PetHealthHappy"
	if (self.happiness == 2) then
		color = "PetHealthContent"
	elseif(self.happiness == 1) then
		color = "PetHealthUnhappy"
	end

	if (self.moduleSettings.scaleHealthColor) then
		color = "ScaledHealthColor"
	end

	if not (self.alive) then
		color = "Dead"
	end

	if (self.maxHealth > 0) then
		self:UpdateBar(self.healthPercentage, color)
	end

	if not IceHUD.IceCore:ShouldUseDogTags() then
		self:SetBottomText1(math.floor(self.healthPercentage * 100))
	end
end


-- OVERRIDE
function PetHealth.prototype:GetOptions()
	local opts = PetHealth.super.prototype.GetOptions(self)

	opts["scaleHealthColor"] = {
		type = "toggle",
		name = "Color bar by health %",
		desc = "Colors the health bar from MaxHealthColor to MinHealthColor based on current health %",
		get = function()
			return self.moduleSettings.scaleHealthColor
		end,
		set = function(info, value)
			self.moduleSettings.scaleHealthColor = value
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 41
	}

	opts["allowClickTarget"] = {
		type = 'toggle',
		name = 'Allow click-targeting',
		desc = 'Whether or not to allow click targeting/casting for this bar (Note: does not work properly with HiBar, have to click near the base of the bar)',
		get = function()
			return self.moduleSettings.allowMouseInteraction
		end,
		set = function(info, v)
			self.moduleSettings.allowMouseInteraction = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 42,
	}

	return opts
end

function PetHealth.prototype:CreateBackground()
	PetHealth.super.prototype.CreateBackground(self)

	if not self.frame.button then
		self.frame.button = CreateFrame("Button", "IceHUD_PetClickFrame", self.frame, "SecureUnitButtonTemplate")
	end

	self.frame.button:ClearAllPoints()
	-- Parnic - kinda hacky, but in order to fit this region to multiple types of bars, we need to do this...
	--          would be nice to define this somewhere in data, but for now...here we are
	if self:GetMyBarTexture() == "HiBar" then
		self.frame.button:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", 0, 0)
		self.frame.button:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMRIGHT", -1 * self.frame:GetWidth(), 0)
	else
		if self.moduleSettings.side == IceCore.Side.Left then
			self.frame.button:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -6, 0)
			self.frame.button:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMRIGHT", -1 * self.frame:GetWidth() / 3, 0)
		else
			self.frame.button:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 6, 0)
			self.frame.button:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -1 * self.frame:GetWidth() / 1.5, 0)
		end
	end

	self:EnableClickTargeting(self.moduleSettings.allowMouseInteraction)
end

function PetHealth.prototype:EnableClickTargeting(bEnable)
	if bEnable then
		self.frame.button:EnableMouse(true)
		self.frame.button:RegisterForClicks("LeftButtonUp")
		self.frame.button:SetAttribute("type1", "target")
		self.frame.button:SetAttribute("unit", self.unit)

		-- set up click casting
		ClickCastFrames = ClickCastFrames or {}
		ClickCastFrames[self.frame.button] = true

-- Parnic - debug code for showing the clickable region on this bar
--		self.frame.button:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
--						edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
--						tile = false,
--						insets = { left = 0, right = 0, top = 0, bottom = 0 }});
--		self.frame.button:SetBackdropColor(0,0,0,1);
	else
		self.frame.button:EnableMouse(false)
		self.frame.button:RegisterForClicks()
	end
end

-- Load us up
IceHUD.PetHealth = PetHealth:new()
