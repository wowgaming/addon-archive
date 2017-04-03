
------------------------------
-- Combo Point Widget
------------------------------
local comboWidgetPath = "Interface\\Addons\\TidyPlates\\Widgets\\ComboWidget\\"
local COMBO_ART = { "1", "2", "3", "4", "5", }

local function UpdateComboPointFrame(frame, unit)
		local points 
		if UnitExists("target") and unit.isTarget then points = GetComboPoints("player", "target") end
		if points and points > 0 then 
			frame.Icon:SetTexture(comboWidgetPath..COMBO_ART[points]) 
			frame:Show()
		else frame:Hide() end	
end

local ComboWatcher = CreateFrame("Frame", nil, WorldFrame )
local isEnabled = false

local function ComboWatcherHandler(frame, event, unitid)
	--print(event, unitid)
	TidyPlates:Update()
	--if unitid == "target" then TidyPlates:Update() end
end

local function EnableComboWatcher(arg)
	if arg then ComboWatcher:SetScript("OnEvent", ComboWatcherHandler)
		ComboWatcher:RegisterEvent("UNIT_COMBO_POINTS")
	else ComboWatcher:SetScript("OnEvent", nil) 
		ComboWatcher:UnregisterEvent("UNIT_COMBO_POINTS")
	end
	isEnabled = true
end

local function CreateComboPointWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetHeight(32)
	frame:SetWidth(64)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateComboPointFrame
	
	if not isEnabled then EnableComboWatcher(true) end
	
	return frame
end

TidyPlatesWidgets.CreateComboPointWidget = CreateComboPointWidget