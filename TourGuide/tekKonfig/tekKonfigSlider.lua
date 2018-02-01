
local lib, oldminor = LibStub:NewLibrary("tekKonfig-Slider", 2)
if not lib then return end


local GameTooltip = GameTooltip
local function HideTooltip() GameTooltip:Hide() end
local function ShowTooltip(self)
	if self.tiptext then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(self.tiptext, nil, nil, nil, nil, true)
	end
end


local HorizontalSliderBG = {
	bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
	edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
	edgeSize = 8, tile = true, tileSize = 8,
	insets = {left = 3, right = 3, top = 6, bottom = 6}
}


-- Create a slider.
-- All args optional, parent recommended
-- If lowvalue and highvalue are strings it is assumed they are % values
-- and the % is parsed and set as decimal values for min/max
function lib.new(parent, label, lowvalue, highvalue, ...)
	local container = CreateFrame("Frame", nil, parent)
	container:SetWidth(144)
	container:SetHeight(17+12+10)
	if select(1, ...) then container:SetPoint(...) end

	local slider = CreateFrame("Slider", nil, container)
	slider:SetPoint("LEFT")
	slider:SetPoint("RIGHT")
	slider:SetHeight(17)
	slider:SetHitRectInsets(0, 0, -10, -10)
	slider:SetOrientation("HORIZONTAL")
	slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal") -- Dim: 32x32... can't find API to set this?
	slider:SetBackdrop(HorizontalSliderBG)

	local text = slider:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	text:SetPoint("BOTTOM", slider, "TOP")
	text:SetText(label)

	local low = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	low:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", -4, 3)
	low:SetText(lowvalue)

	local high = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	high:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", 4, 3)
	high:SetText(highvalue)

	if type(lowvalue) == "string" then slider:SetMinMaxValues(tonumber((lowvalue:gsub("%%", "")))/100, tonumber((highvalue:gsub("%%", "")))/100)
	else slider:SetMinMaxValues(lowvalue, highvalue) end

	-- Tooltip bits
	slider:SetScript("OnEnter", ShowTooltip)
	slider:SetScript("OnLeave", HideTooltip)

	return slider, text, container, low, high
end
