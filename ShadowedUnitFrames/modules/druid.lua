local Druid = {}
ShadowUF:RegisterModule(Druid, "druidBar", ShadowUF.L["Druid mana bar"], true, "DRUID")

function Druid:OnEnable(frame)
	frame.druidBar = frame.druidBar or ShadowUF.Units:CreateBar(frame)

	frame:RegisterUnitEvent("UNIT_MAXMANA", self, "Update")
	frame:RegisterUnitEvent("UNIT_MANA", self, "Update")
	frame:RegisterUnitEvent("UNIT_DISPLAYPOWER", self, "PowerChanged")
	
	frame:RegisterUpdateFunc(self, "PowerChanged")
	frame:RegisterUpdateFunc(self, "Update")
end

function Druid:OnDisable(frame)
	frame:UnregisterAll(self)
end

function Druid:OnLayoutApplied(frame)
	if( frame.visibility.druidBar ) then
		local color = ShadowUF.db.profile.powerColors.MANA
		
		if( not ShadowUF.db.profile.units[frame.unitType].druidBar.invert ) then
			frame.druidBar:SetStatusBarColor(color.r, color.g, color.b, ShadowUF.db.profile.bars.alpha)
			if( not frame.druidBar.background.overrideColor ) then
				frame.druidBar.background:SetVertexColor(color.r, color.g, color.b, ShadowUF.db.profile.bars.backgroundAlpha)
			end
		else
			frame.druidBar.background:SetVertexColor(color.r, color.g, color.b, ShadowUF.db.profile.bars.alpha)

			color = frame.druidBar.background.overrideColor or color
			frame.druidBar:SetStatusBarColor(color.r, color.g, color.b, ShadowUF.db.profile.bars.backgroundAlpha)
		end
	end
end

-- While power type is mana, show the bar once it is mana hide it.
function Druid:PowerChanged(frame)
	local powerType = UnitPowerType(frame.unit)
	ShadowUF.Layout:SetBarVisibility(frame, "druidBar", powerType == 1 or powerType == 3)
end

function Druid:Update(frame)
	frame.druidBar:SetMinMaxValues(0, UnitPowerMax(frame.unit, 0))
	frame.druidBar:SetValue(UnitIsDeadOrGhost(frame.unit) and 0 or not UnitIsConnected(frame.unit) and 0 or UnitPower(frame.unit, 0))
end
