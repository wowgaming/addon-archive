local TargetTargetHealth = IceCore_CreateClass(IceTargetHealth)
TargetTargetHealth.prototype.scheduledEvent = nil

local SelfDisplayModeOptions = {"Color as SelfColor", "Hide", "Normal"}


-- Constructor --
function TargetTargetHealth.prototype:init()
	TargetTargetHealth.super.prototype.init(self, "TargetTargetHealth", "targettarget")

	self:SetDefaultColor("TargetTargetHealthHostile", 231, 31, 36)
	self:SetDefaultColor("TargetTargetHealthFriendly", 46, 223, 37)
	self:SetDefaultColor("TargetTargetHealthNeutral", 210, 219, 87)
	self:SetDefaultColor("SelfColor", 255, 255, 255)
end

function TargetTargetHealth.prototype:GetDefaultSettings()
	local settings = TargetTargetHealth.super.prototype.GetDefaultSettings(self)

	settings["side"] = IceCore.Side.Right
	settings["offset"] = 12
	settings["classColor"] = false
	settings["selfColor"] = { r = 0, g = 0, b = 1 }
	settings["selfDisplayMode"] = "Color as SelfColor"
	settings["upperText"] = "[PercentHP:Round]"
	settings["lowerText"] = "[(HP:Round \"/\" MaxHP:Round):HPColor:Bracket]"
	settings["barVerticalOffset"] = 35
	settings["scale"] = 0.7
	settings["enabled"] = false
	settings["hideBlizz"] = false

	return settings
end


-- OVERRIDE
function TargetTargetHealth.prototype:GetOptions()
	local opts = TargetTargetHealth.super.prototype.GetOptions(self)

	opts["hideBlizz"] = nil

	opts["selfDisplayMode"] = {
		type = 'select',
		name = "Self Display Mode",
		desc = "What this bar should do whenever the player is the TargetOfTarget\n\nNOTE: When this is set to 'hide', then click-targeting is not available due to Blizzard's restrictions",
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.selfDisplayMode)
		end,
		set = function(info, value)
			self.moduleSettings.selfDisplayMode = info.option.values[value]
			if info.option.values[value] == "Hide" then
				self.moduleSettings.allowMouseInteraction = false
				self.DisplayClickTargetOption = false
				UnregisterUnitWatch(self.frame)
			else
				RegisterUnitWatch(self.frame)
				self.DisplayClickTargetOption = true
			end
			IceHUD:NotifyOptionsChange()
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		values = SelfDisplayModeOptions,
		order = 44,
	}

	opts["selfColor"] = {
		type = "color",
		name = "Self Color",
		desc = "Set the color of the TargetTarget bar if you are your target's target.",
		get = function()
			return self.moduleSettings.selfColor.r, self.moduleSettings.selfColor.g, self.moduleSettings.selfColor.b
		end,
		set = function(info, r, g, b)
			self.moduleSettings.selfColor = { r = r, g = g, b = b }
			IceHUD.IceCore:SetColor("SelfColor", r, g, b)
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		hasAlpha = false,
		order = 45,
	}

	return opts
end


function TargetTargetHealth.prototype:Enable(core)
	self.registerEvents = false
	TargetTargetHealth.super.prototype.Enable(self, core)

	if self.moduleSettings.selfDisplayMode == "Hide" then
		UnregisterUnitWatch(self.frame)
		self.DisplayClickTargetOption = false
		self.moduleSettings.allowMouseInteraction = false
		self:EnableClickTargeting(false)
	end

	if self.moduleSettings.useSelfColor ~= nil then
		if self.moduleSettings.useSelfColor == true then
			self.moduleSettings.selfDisplayMode = "Color as SelfColor"
		else
			self.moduleSettings.selfDisplayMode = "Normal"
		end

		self.moduleSettings.useSelfColor = nil
	end

	self.scheduledEvent = self:ScheduleRepeatingTimer("Update", 0.1, "targettarget")
end

function TargetTargetHealth.prototype:Disable(core)
	TargetTargetHealth.super.prototype.Disable(self, core)

	self:CancelTimer(self.scheduledEvent, true)
end

function TargetTargetHealth.prototype:Update(unit)
	self.color = "TargetTargetHealthFriendly" -- friendly > 4

	local reaction = UnitReaction(self.unit, "player")

	if (reaction and (reaction == 4)) then
		self.color = "TargetTargetHealthNeutral"
	elseif (reaction and (reaction < 4)) then
		self.color = "TargetTargetHealthHostile"
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

	if UnitIsUnit("player", self.unit) then
		if self.moduleSettings.selfDisplayMode == "Color as SelfColor" then
			self.color = "SelfColor"
		elseif self.moduleSettings.selfDisplayMode == "Hide" then
			self:Show(false)
			return
		end
	end

	if self.moduleSettings.selfDisplayMode == "Hide" then
		self:Show(UnitExists(self.unit))
	end

	self.determineColor = false
	TargetTargetHealth.super.prototype.Update(self, unit)
end

-- Load us up
IceHUD.TargetTargetHealth = TargetTargetHealth:new()
