local Power = {}
ShadowUF:RegisterModule(Power, "powerBar", ShadowUF.L["Power bar"], true)

local function updatePower(self, elapsed)
	local currentPower = UnitPower(self.parent.unit)
	if( currentPower == self.currentPower ) then return end
	self.currentPower = currentPower

	self:SetValue(currentPower)
	for _, fontString in pairs(self.parent.fontStrings) do
		if( fontString.fastPower ) then
			fontString:UpdateTags()
		end
	end
end

function Power:OnEnable(frame)
	frame.powerBar = frame.powerBar or ShadowUF.Units:CreateBar(frame)
		
	frame:RegisterUnitEvent("UNIT_MANA", self, "Update")
	frame:RegisterUnitEvent("UNIT_RAGE", self, "Update")
	frame:RegisterUnitEvent("UNIT_ENERGY", self, "Update")
	frame:RegisterUnitEvent("UNIT_FOCUS", self, "Update")
	frame:RegisterUnitEvent("UNIT_RUNIC_POWER", self, "Update")
	frame:RegisterUnitEvent("UNIT_MAXMANA", self, "Update")
	frame:RegisterUnitEvent("UNIT_MAXRAGE", self, "Update")
	frame:RegisterUnitEvent("UNIT_MAXENERGY", self, "Update")
	frame:RegisterUnitEvent("UNIT_MAXFOCUS", self, "Update")
	frame:RegisterUnitEvent("UNIT_MAXRUNIC_POWER", self, "Update")
	frame:RegisterUnitEvent("UNIT_DISPLAYPOWER", self, "UpdateColor")

	frame:RegisterUpdateFunc(self, "UpdateColor")
	frame:RegisterUpdateFunc(self, "Update")
end

function Power:OnLayoutApplied(frame)
	-- Enable predicted updates which requires polling in an OnUpdate to get more up to date values
	if( frame.visibility.powerBar ) then
		if( ShadowUF.db.profile.units[frame.unitType].powerBar.predicted ) then
			frame.powerBar:SetScript("OnUpdate", updatePower)
		else
			frame.powerBar:SetScript("OnUpdate", nil)
		end
	end
end

function Power:OnDisable(frame)
	frame:UnregisterAll(self)
end

function Power:UpdateColor(frame)
	local color = ShadowUF.db.profile.powerColors[select(2, UnitPowerType(frame.unit))] or ShadowUF.db.profile.powerColors.MANA
	
	if( not ShadowUF.db.profile.units[frame.unitType].powerBar.invert ) then
		frame.powerBar:SetStatusBarColor(color.r, color.g, color.b, ShadowUF.db.profile.bars.alpha)
		if( not frame.powerBar.background.overrideColor ) then
			frame.powerBar.background:SetVertexColor(color.r, color.g, color.b, ShadowUF.db.profile.bars.backgroundAlpha)
		end
	else
		frame.powerBar.background:SetVertexColor(color.r, color.g, color.b, ShadowUF.db.profile.bars.alpha)

		color = frame.powerBar.background.overrideColor
		if( not color ) then
			frame.powerBar:SetStatusBarColor(0, 0, 0, 1 - ShadowUF.db.profile.bars.backgroundAlpha)
		else
			frame.powerBar:SetStatusBarColor(color.r, color.g, color.b, ShadowUF.db.profile.bars.backgroundAlpha)
		end
	end
end

function Power:Update(frame)
	frame.powerBar.currentPower = UnitPower(frame.unit)
	frame.powerBar:SetMinMaxValues(0, UnitPowerMax(frame.unit))
	frame.powerBar:SetValue(UnitIsDeadOrGhost(frame.unit) and 0 or not UnitIsConnected(frame.unit) and 0 or frame.powerBar.currentPower)
end