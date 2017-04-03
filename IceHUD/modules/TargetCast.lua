local TargetCast = IceCore_CreateClass(IceCastBar)

TargetCast.prototype.notInterruptible = false

-- Constructor --
function TargetCast.prototype:init()
	TargetCast.super.prototype.init(self, "TargetCast")

	self:SetDefaultColor("CastNotInterruptible", 1, 0, 0)

	self.unit = "target"
end

function TargetCast.prototype:Enable(core)
	TargetCast.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE", "SpellCastInterruptible")
	self:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE", "SpellCastNotInterruptible")
end


function TargetCast.prototype:SpellCastInterruptible()
	self.notInterruptible = false
	self:Redraw()
end

function TargetCast.prototype:SpellCastNotInterruptible()
	self.notInterruptible = true
	self:Redraw()
end

function TargetCast.prototype:UpdateBar(scale, color, alpha)
	TargetCast.super.prototype.UpdateBar(self, scale, color, alpha)

	if self.moduleSettings.displayNonInterruptible and self.notInterruptible then
		self.barFrame.bar:SetVertexColor(self:GetColor("CastNotInterruptible"))
	end
end


-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function TargetCast.prototype:GetDefaultSettings()
	local settings = TargetCast.super.prototype.GetDefaultSettings(self)

	settings["side"] = IceCore.Side.Right
	settings["offset"] = 3
	settings["flashInstants"] = "Never"
	settings["flashFailures"] = "Never"
	settings["shouldAnimate"] = false
	settings["hideAnimationSettings"] = true
	settings["usesDogTagStrings"] = false
	settings["displayNonInterruptible"] = true

	return settings
end


-- OVERRIDE
function TargetCast.prototype:TargetChanged(unit)
	TargetCast.super.prototype.TargetChanged(self, unit)

	if not (self.target) then
		self:StopBar()
		return
	end

	local spell, _, _, _, _, _, _, _, notInterruptibleCast = UnitCastingInfo(self.unit)
	if (spell) then
		self.notInterruptible = notInterruptibleCast
		self:StartBar(IceCastBar.Actions.Cast)
		return
	end

	local channel, _, _, _, _, _, _, notInterruptibleChannel = UnitChannelInfo(self.unit)
	if (channel) then
		self.notInterruptible = notInterruptibleChannel
		self:StartBar(IceCastBar.Actions.Channel)
		return
	end

	self:StopBar()
end


function TargetCast.prototype:GetOptions()
	local opts = TargetCast.super.prototype.GetOptions(self)

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

	opts["displayNonInterruptible"] = {
		type = 'toggle',
		name = 'Display non-interruptible color',
		desc = 'Toggles whether or not to show the CastNonInterruptible color for this bar when a cast is non-interruptible',
		width = 'double',
		get = function()
			return self.moduleSettings.displayNonInterruptible
		end,
		set = function(info, v)
			self.moduleSettings.displayNonInterruptible = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 30
	}

	return opts
end

function TargetCast.prototype:StartBar(action, message)
	local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castId, notInterruptible = UnitCastingInfo(self.unit)
	if not (spell) then
		spell, rank, displayName, icon, startTime, endTime, isTradeSkill, notInterruptible = UnitChannelInfo(self.unit)
	end

	if not spell then
		return
	end

	self.notInterruptible = notInterruptible

	TargetCast.super.prototype.StartBar(self, action, message)
end

-------------------------------------------------------------------------------


-- Load us up
IceHUD.TargetCast = TargetCast:new()
