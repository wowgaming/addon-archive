local TargetTargetCast = IceCore_CreateClass(IceCastBar)
TargetTargetCast.prototype.scheduledEvent = nil

local SelfDisplayModeOptions = {"Hide", "Normal"}

-- Constructor --
function TargetTargetCast.prototype:init()
	TargetTargetCast.super.prototype.init(self, "TargetTargetCast")

	self.unit = "targettarget"
end


-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function TargetTargetCast.prototype:GetDefaultSettings()
	local settings = TargetTargetCast.super.prototype.GetDefaultSettings(self)

	settings["side"] = IceCore.Side.Right
	settings["offset"] = 13
	settings["flashInstants"] = "Never"
	settings["flashFailures"] = "Never"
	settings["shouldAnimate"] = false
	settings["hideAnimationSettings"] = true
	settings["usesDogTagStrings"] = false
	settings["enabled"] = false
	settings["barVerticalOffset"] = 35
	settings["scale"] = 0.7
	settings["selfDisplayMode"] = "Normal"

	return settings
end


-- OVERRIDE
function TargetTargetCast.prototype:Enable(core)
	TargetTargetCast.super.prototype.Enable(self, core)

	self.scheduledEvent = self:ScheduleRepeatingTimer("UpdateTargetTarget", 0.1)
end

function TargetTargetCast.prototype:Disable(core)
	TargetTargetCast.super.prototype.Disable(self, core)

	self:CancelTimer(self.scheduledEvent, true)
end

function TargetTargetCast.prototype:UpdateTargetTarget()
	if not (UnitExists(self.unit)) then
		self:StopBar()
		return
	end

	if self.moduleSettings.selfDisplayMode == "Hide" and UnitIsUnit("player", self.unit) then
		self:StopBar()
		return
	end

	local spell = UnitCastingInfo(self.unit)
	if (spell) then
		self:StartBar(IceCastBar.Actions.Cast)
		return
	end

	local channel = UnitChannelInfo(self.unit)
	if (channel) then
		self:StartBar(IceCastBar.Actions.Channel)
		return
	end

	self:StopBar()
end


function TargetTargetCast.prototype:GetOptions()
	local opts = TargetTargetCast.super.prototype.GetOptions(self)

	opts["barVisible"] = {
		type = 'toggle',
		name = 'Bar visible',
		desc = 'Toggle bar visibility',
		get = function()
			return self.moduleSettings.barVisible['bar']
		end,
		set = function(info, v)
			self.moduleSettings.barVisible['bar'] = v
			if v then
				self.barFrame:Show()
			else
				self.barFrame:Hide()
			end
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 28
	}

	opts["bgVisible"] = {
		type = 'toggle',
		name = 'Bar background visible',
		desc = 'Toggle bar background visibility',
		get = function()
			return self.moduleSettings.barVisible['bg']
		end,
		set = function(info, v)
			self.moduleSettings.barVisible['bg'] = v
			if v then
				self.frame.bg:Show()
			else
				self.frame.bg:Hide()
			end
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 29
	}

	opts["selfDisplayMode"] = {
		type = 'select',
		name = "Self Display Mode",
		desc = "What this bar should do whenever the player is the TargetOfTarget",
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.selfDisplayMode)
		end,
		set = function(info, value)
			self.moduleSettings.selfDisplayMode = info.option.values[value]
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		values = SelfDisplayModeOptions,
		order = 44,
	}

	return opts
end

-------------------------------------------------------------------------------


-- Load us up
IceHUD.TargetTargetCast = TargetTargetCast:new()
