IceCustomHealth = IceCore_CreateClass(IceTargetHealth)
IceCustomHealth.prototype.scheduledEvent = nil

-- Constructor --
function IceCustomHealth.prototype:init()
	IceCustomHealth.super.prototype.init(self, "IceCustomHealth", "focustarget")

-- these aren't working...don't know why
--[[	self:SetDefaultColor("CustomHealthHostile", 231, 31, 36)
	self:SetDefaultColor("CustomHealthFriendly", 46, 223, 37)
	self:SetDefaultColor("CustomHealthNeutral", 210, 219, 87)
]]--
end

function IceCustomHealth.prototype:GetDefaultSettings()
	local settings = IceCustomHealth.super.prototype.GetDefaultSettings(self)

	settings["side"] = IceCore.Side.Left
	settings["offset"] = -3
	settings["classColor"] = false
	settings["barVerticalOffset"] = 0
	settings["scale"] = 1
	settings["customBarType"] = "Health"
	settings["unitToTrack"] = "focustarget"

	return settings
end


-- OVERRIDE
function IceCustomHealth.prototype:GetOptions()
	local opts = IceCustomHealth.super.prototype.GetOptions(self)

	opts["hideBlizz"] = nil

	opts["customHeader"] = {
		type = 'header',
		name = "Custom bar settings",
		order = 30.1,
	}

	opts["deleteme"] = {
		type = 'execute',
		name = 'Delete me',
		desc = 'Deletes this custom module and all associated settings. Cannot be undone!',
		func = function()
			local dialog = StaticPopup_Show("ICEHUD_DELETE_CUSTOM_MODULE")
			if dialog then
				dialog.data = self
			end
		end,
		order = 20.1,
	}

	opts["name"] = {
		type = 'input',
		name = 'Bar name',
		desc = 'The name of this bar (must be unique!).\n\nRemember to press ENTER after filling out this box with the name you want or it will not save.',
		get = function()
			return self.elementName
		end,
		set = function(info, v)
			if v~= "" then
				IceHUD.IceCore:RenameDynamicModule(self, v)
			end
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		usage = "<a name for this bar>",
		order = 30.3,
	}

	opts["unitToTrack"] = {
		type = 'input',
		name = 'Unit to track',
		desc = 'Enter which unit that this bar should be monitoring the health of (e.g.: focustarget, pettarget, etc.)\n\nRemember to press ENTER after filling out this box with the name you want or it will not save.',
		get = function()
			return self.moduleSettings.unitToTrack
		end,
		set = function(info, v)
			v = string.lower(v)
			self.moduleSettings.unitToTrack = v
			self:SetUnit(v)
			self:Redraw()
			self:CheckCombat()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 30.4,
	}

	return opts
end


function IceCustomHealth.prototype:Enable(core)
	self.registerEvents = false
	IceCustomHealth.super.prototype.Enable(self, core)

	self:SetUnit(self.moduleSettings.unitToTrack)
	self:CreateFrame()

	self.scheduledEvent = self:ScheduleRepeatingTimer("Update", IceHUD.IceCore:UpdatePeriod())
end

function IceCustomHealth.prototype:Disable(core)
	IceCustomHealth.super.prototype.Disable(self, core)

	self:CancelTimer(self.scheduledEvent, true)
end

function IceCustomHealth.prototype:Update(unit)
	self.color = "CustomHealthFriendly" -- friendly > 4

	local reaction = UnitReaction(self.unit, "player")

	if (reaction and (reaction == 4)) then
		self.color = "CustomHealthNeutral"
	elseif (reaction and (reaction < 4)) then
		self.color = "CustomHealthHostile"
	end

	if (self.moduleSettings.classColor) and (not self.moduleSettings.npcHostilityColor or UnitPlayerControlled("target")) then
		self.color = self.unitClass
	end

	if (self.moduleSettings.scaleHealthColor) then
		self.color = "ScaledHealthColor"
	end

	if (self.tapped) then
		self.color = "Tapped"
	end

	if not self:IsVisible() then
		RegisterUnitWatch(self.frame)
	end

	--self.determineColor = false
	IceCustomHealth.super.prototype.Update(self, unit)
end

function IceCustomHealth.prototype:SetUnit(unit)
	IceCustomHealth.super.prototype.SetUnit(self, unit)
	if self.frame ~= nil and self.frame.button ~= nil then
		self.frame.button:SetAttribute("unit", self.unit)
	end
	self:RegisterFontStrings()
end
