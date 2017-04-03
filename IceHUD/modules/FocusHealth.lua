local FocusHealth = IceCore_CreateClass(IceUnitBar)

FocusHealth.prototype.color = nil


-- Constructor --
function FocusHealth.prototype:init()
	FocusHealth.super.prototype.init(self, "FocusHealth", "focus")

	self:SetDefaultColor("FocusHealthHostile", 231, 31, 36)
	self:SetDefaultColor("FocusHealthFriendly", 46, 223, 37)
	self:SetDefaultColor("FocusHealthNeutral", 210, 219, 87)
end


function FocusHealth.prototype:GetDefaultSettings()
	local settings = FocusHealth.super.prototype.GetDefaultSettings(self)

	settings["enabled"] = false
	settings["side"] = IceCore.Side.Right
	settings["offset"] = -1
	settings["scale"] = 0.7
	settings["classColor"] = false
	settings["hideBlizz"] = false
	settings["upperText"] = "[PercentHP:Round]"
	settings["lowerText"] = ""
	settings["raidIconOnTop"] = true
	settings["showRaidIcon"] = true
	settings["raidIconXOffset"] = 12
	settings["raidIconYOffset"] = 0
	settings["lockIconAlpha"] = false
	settings["abbreviateHealth"] = true
	settings["barVerticalOffset"] = 35
	settings["allowMouseInteraction"] = false

	return settings
end


-- OVERRIDE
function FocusHealth.prototype:GetOptions()
	local opts = FocusHealth.super.prototype.GetOptions(self)

	opts["classColor"] = {
		type = "toggle",
		name = "Class color bar",
		desc = "Use class color as the bar color instead of reaction color",
		get = function()
			return self.moduleSettings.classColor
		end,
		set = function(info, value)
			self.moduleSettings.classColor = value
			self:Update(self.unit)
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 41
	}

	opts["hideBlizz"] = {
		type = "toggle",
		name = "Hide Blizzard Frame",
		desc = "Hides Blizzard Focus frame and disables all events related to it",
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
		order = 42
	}

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
		order = 43
	}

	opts["iconSettings"] = {
		type = 'group',
		name = '|c'..self.configColor..'Icon Settings|r',
		args = {
			showRaidIcon = {
				type = "toggle",
				name = "Show Raid Icon",
				desc = "Whether or not to show the raid icon above this bar",
				get = function()
					return self.moduleSettings.showRaidIcon
				end,
				set = function(info, value)
					self.moduleSettings.showRaidIcon = value
					self:UpdateRaidFocusIcon()
				end,
				disabled = function()
					return not self.moduleSettings.enabled
				end,
				order = 50.1
			},

			lockIconAlpha = {
				type = "toggle",
				name = "Lock raid icon to 100% alpha",
				desc = "With this enabled, the raid icon is always 100% alpha, regardless of the bar's alpha. Otherwise, it assumes the bar's alpha level.",
				width = 'double',
				get = function()
					return self.moduleSettings.lockIconAlpha
				end,
				set = function(info, value)
					self.moduleSettings.lockIconAlpha = value
					self:Redraw()
				end,
				disabled = function()
					return not self.moduleSettings.enabled
				end,
				order = 51
			},

			raidIconOnTop = {
				type = "toggle",
				name = "Draw Raid Icon On Top",
				desc = "Whether to draw the raid icon in front of or behind this bar",
				get = function()
					return self.moduleSettings.raidIconOnTop
				end,
				set = function(info, value)
					self.moduleSettings.raidIconOnTop = value
					self:UpdateRaidFocusIcon()
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.showRaidIcon
				end,
				order = 52
			},

			raidIconXOffset = {
				type = "range",
				name = "Raid Icon X Offset",
				desc = "How far to push the raid icon right or left",
				min = -300,
				max = 300,
				step = 1,
				get = function()
					return self.moduleSettings.raidIconXOffset
				end,
				set = function(info, value)
					self.moduleSettings.raidIconXOffset = value
					self:SetRaidIconPlacement()
					self:Redraw()
				end,
				disabled = function()
					return not self.moduleSettings.enabled
				end,
				order = 53
			},

			raidIconYOffset = {
				type = "range",
				name = "Raid Icon Y Offset",
				desc = "How far to push the raid icon up or down",
				min = -300,
				max = 300,
				step = 1,
				get = function()
					return self.moduleSettings.raidIconYOffset
				end,
				set = function(info, value)
					self.moduleSettings.raidIconYOffset = value
					self:SetRaidIconPlacement()
					self:Redraw()
				end,
				disabled = function()
					return not self.moduleSettings.enabled
				end,
				order = 54
			},
		},
	}

	opts["shortenHealth"] = {
		type = 'toggle',
		name = 'Abbreviate health',
		desc = 'If this is checked, then a health value of 1100 will display as 1.1k, otherwise it shows the number\n\nNote: this only applies if you are NOT using DogTag',
		get = function()
			return self.moduleSettings.abbreviateHealth
		end,
		set = function(info, v)
			self.moduleSettings.abbreviateHealth = v
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 40.1
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
		order = 43,
	}

	return opts
end


function FocusHealth.prototype:Enable(core)
	FocusHealth.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_HEALTH", "UpdateEvent")
	self:RegisterEvent("UNIT_MAXHEALTH", "UpdateEvent")
	self:RegisterEvent("UNIT_FLAGS", "UpdateEvent")
	self:RegisterEvent("UNIT_FACTION", "UpdateEvent")
	self:RegisterEvent("RAID_TARGET_UPDATE", "UpdateRaidFocusIcon")
	self:RegisterEvent("PLAYER_FOCUS_CHANGED", "UpdateFocus")

	if (self.moduleSettings.hideBlizz) then
		self:HideBlizz()
	end

	self:CreateRaidIconFrame()

	self:Update(self.unit)

	-- for showing/hiding the frame based on unit visibility
	self.frame:SetAttribute("unit", self.unit)
	RegisterUnitWatch(self.frame)
end

function FocusHealth.prototype:CreateBackground()
	FocusHealth.super.prototype.CreateBackground(self)

	if not self.frame.button then
		self.frame.button = CreateFrame("Button", "IceHUD_FocusClickFrame", self.frame, "SecureUnitButtonTemplate")
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

function FocusHealth.prototype:EnableClickTargeting(bEnable)
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

function FocusHealth.prototype:UpdateFocus()
	self:Update(self.unit)
end

function FocusHealth.prototype:Disable(core)
	FocusHealth.super.prototype.Disable(self, core)

	if self.moduleSettings.hideBlizz then
		self:ShowBlizz()
	end
end

function FocusHealth.prototype:UpdateEvent(event, unit)
	self:Update(unit)
end

function FocusHealth.prototype:Update(unit)
	FocusHealth.super.prototype.Update(self)
	if (unit and (unit ~= self.unit)) then
		return
	end

	if not (UnitExists(unit)) then
		self:Show(false)
		return
	else
		self:Show(true)
	end

	self:UpdateRaidFocusIcon()

	self.color = "FocusHealthFriendly" -- friendly > 4

	local reaction = UnitReaction(self.unit, "player")
	if (reaction and (reaction == 4)) then
		self.color = "FocusHealthNeutral"
	elseif (reaction and (reaction < 4)) then
		self.color = "FocusHealthHostile"
	end

	if (self.moduleSettings.classColor) then
		self.color = self.unitClass
	end

	if (self.moduleSettings.scaleHealthColor) then
		self.color = "ScaledHealthColor"
	end

	if (self.tapped) then
		self.color = "Tapped"
	end

	self:UpdateBar(self.healthPercentage, self.color)

	if not IceHUD.IceCore:ShouldUseDogTags() then
		self:SetBottomText1(math.floor(self.healthPercentage * 100))

		if self.moduleSettings.abbreviateHealth then
			self.health = self:Round(self.health)
			self.maxHealth = self:Round(self.maxHealth)
		end

		if (self.maxHealth ~= 100) then
			self:SetBottomText2(self:GetFormattedText(self.health, self.maxHealth), self.color)
		else
			self:SetBottomText2()
		end
	end

	if self.frame.raidIcon then
		self.frame.raidIcon:SetAlpha(self.moduleSettings.lockIconAlpha and 1 or self.alpha)
	end
end


function FocusHealth.prototype:CreateRaidIconFrame()
	if (not self.frame.raidIcon) then
		self.frame.raidIcon = CreateFrame("Frame", nil, self.frame)
	end

	if (not self.frame.raidIcon.icon) then
		self.frame.raidIcon.icon = self.frame.raidIcon:CreateTexture(nil, "BACKGROUND")
		self.frame.raidIcon.icon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	end

	self:SetRaidIconPlacement()
	self.frame.raidIcon:SetWidth(16)
	self.frame.raidIcon:SetHeight(16)

	self.frame.raidIcon.icon:SetAllPoints(self.frame.raidIcon)
	SetRaidTargetIconTexture(self.frame.raidIcon.icon, 0)
	self.frame.raidIcon:Hide()
end

function FocusHealth.prototype:SetRaidIconPlacement()
	self.frame.raidIcon:ClearAllPoints()
	self.frame.raidIcon:SetPoint("BOTTOM", self.frame, "TOPLEFT", self.moduleSettings.raidIconXOffset, self.moduleSettings.raidIconYOffset)
end


function FocusHealth.prototype:UpdateRaidFocusIcon()
	if self.moduleSettings.raidIconOnTop then
		self.frame.raidIcon:SetFrameStrata("MEDIUM")
	else
		self.frame.raidIcon:SetFrameStrata("LOW")
	end

	if not (UnitExists(self.unit)) or not self.moduleSettings.showRaidIcon then
		self.frame.raidIcon:Hide()
		return
	end

	local index = GetRaidTargetIndex(self.unit);

	if (index and (index > 0)) then
		SetRaidTargetIconTexture(self.frame.raidIcon.icon, index)
		self.frame.raidIcon:Show()
	else
		self.frame.raidIcon:Hide()
	end
end


function FocusHealth.prototype:Round(health)
	if (health > 1000000) then
		return self:MathRound(health/1000000, 1) .. "M"
	end
	if (health > 1000) then
		return self:MathRound(health/1000, 1) .. "k"
	end
	return health
end


function FocusHealth.prototype:MathRound(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num  * mult + 0.5) / mult
end

function FocusHealth.prototype:ShowBlizz()
	FocusFrame:Show()

	FocusFrame:GetScript("OnLoad")(FocusFrame)
end


function FocusHealth.prototype:HideBlizz()
	FocusFrame:Hide()

	FocusFrame:UnregisterAllEvents()
end

-- Load us up
IceHUD.FocusHealth = FocusHealth:new()
