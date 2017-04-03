---------------
-- Class Widget
---------------
local classWidgetPath = "Interface\\Addons\\TidyPlates\\Widgets\\ClassWidget\\"

local function UpdateClassWidget(self, unit)
		if unit.class and unit.class ~= "UNKNOWN" then
			self.Icon:SetTexture(classWidgetPath..unit.class) 
			self:Show()
		else self:Hide() end
end

local function CreateClassWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(16); frame:SetHeight(16)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetPoint("CENTER",frame)
	frame.Icon:SetWidth(24)
	frame.Icon:SetHeight(24)
	frame:Hide()
	frame.Update = UpdateClassWidget
	return frame
end

TidyPlatesWidgets.CreateClassWidget = CreateClassWidget