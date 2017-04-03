local ComboPointsBar = IceCore_CreateClass(IceBarElement)

function ComboPointsBar.prototype:init()
	ComboPointsBar.super.prototype.init(self, "ComboPointsBar")

	self:SetDefaultColor("ComboPointsBarMin", 1, 1, 0)
	self:SetDefaultColor("ComboPointsBarMax", 0, 1, 0)
end

function ComboPointsBar.prototype:GetOptions()
	local opts = ComboPointsBar.super.prototype.GetOptions(self)

	opts["alwaysDisplay"] = {
		type = "toggle",
		name = "Always display bar",
		desc = "Whether this bar should hide when the player has 0 combo points or stay visible",
		get = function()
			return self.moduleSettings.alwaysDisplay
		end,
		set = function(info, v)
			self.moduleSettings.alwaysDisplay = v
			self:UpdateComboPoints()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 31
	}

	return opts
end

function ComboPointsBar.prototype:GetDefaultSettings()
	local defaults =  ComboPointsBar.super.prototype.GetDefaultSettings(self)
	defaults.textVisible['lower'] = false
	defaults.offset = 8
	defaults.enabled = false
	defaults.alwaysDisplay = false
	return defaults
end

function ComboPointsBar.prototype:Enable(core)
	ComboPointsBar.super.prototype.Enable(self, core)

	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateComboPoints")
	if IceHUD.WowVer >= 30000 then
		self:RegisterEvent("UNIT_COMBO_POINTS", "UpdateComboPoints")
		self:RegisterEvent("UNIT_ENTERED_VEHICLE", "UpdateComboPoints")
		self:RegisterEvent("UNIT_EXITED_VEHICLE", "UpdateComboPoints")
	else
		self:RegisterEvent("PLAYER_COMBO_POINTS", "UpdateComboPoints")
	end
end

function ComboPointsBar.prototype:CreateFrame()
	ComboPointsBar.super.prototype.CreateFrame(self)

	self:UpdateComboPoints()
end

function ComboPointsBar.prototype:UpdateComboPoints()
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

	if points == nil or points == 0 then
		self:Show(self.moduleSettings.alwaysDisplay)
		self:UpdateBar(0, "undef")
	else
		self:Show(true)
		local color = {}
		self:SetScaledColor(color, (points - 1) / 4.0, self.settings.colors["ComboPointsBarMax"], self.settings.colors["ComboPointsBarMin"])
		self:UpdateBar(points / 5.0, "undef")
		self.barFrame.bar:SetVertexColor(color.r, color.g, color.b, 1)
	end

	self:SetBottomText1(points or "0")
end

IceHUD.ComboPointsBar = ComboPointsBar:new()
