

WidgetWarlock = {}


WidgetWarlock.TooltipBorderBG = {
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	edgeSize = 16,
	insets = {left = 4, right = 4, top = 4, bottom = 4}
}


function WidgetWarlock.SummonCheckBox(size, parent, ...)
	local check = CreateFrame("CheckButton", nil, parent)
	check:SetWidth(size)
	check:SetHeight(size)
	if select(1, ...) then check:SetPoint(...) end

	check:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
	check:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
	check:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
	check:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")

	return check
end


function WidgetWarlock.SummonTexture(parent, layer, w, h, texture, ...)
	local tex = parent:CreateTexture(nil, layer)
	if w then tex:SetWidth(w) end
	if h then tex:SetHeight(h) end
	tex:SetTexture(texture)
	if select(1, ...) then tex:SetPoint(...) end
	return tex
end


function WidgetWarlock.SummonFontString(parent, layer, inherit, text, ...)
	local fs = parent:CreateFontString(nil, layer, inherit)
	fs:SetText(text)
	if select(1, ...) then fs:SetPoint(...) end
	return fs
end


-----------------------
--      Fade In      --
-----------------------

local fadetimes = setmetatable({}, {__index = function() return 1 end})
local elapsed = setmetatable({}, {__index = function() return 0 end})


function WidgetWarlock.SetFadeTime(frame, time)
	assert(frame, "No frame passed")
	assert(type(time) == "number", "Time must be a number")
	assert(time > 0, "Time must be positive")
	fadetimes[frame] = time
end


function WidgetWarlock.FadeIn(frame, elap)
	elapsed[frame] = elapsed[frame] + elap
	if elapsed[frame] > fadetimes[frame] then
		frame:SetScript("OnUpdate", nil)
		frame:SetAlpha(1)
		elapsed[frame] = 0
	else frame:SetAlpha(elapsed[frame]/fadetimes[frame]) end
end


--------------------------
--      Scroll Bar      --
--------------------------

function WidgetWarlock.ConjureScrollBar(parent, hasborder)
	local f = CreateFrame("Slider", nil, parent)
	f:SetWidth(16)

	local upbutt = CreateFrame("Button", nil, f, "UIPanelScrollUpButtonTemplate")
	upbutt:SetPoint("BOTTOM", f, "TOP")

	local downbutt = CreateFrame("Button", nil, f, "UIPanelScrollDownButtonTemplate")
	downbutt:SetPoint("TOP", f, "BOTTOM")

	f:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	local thumb = f:GetThumbTexture()
	thumb:SetHeight(16)
	thumb:SetWidth(16)
	thumb:SetTexCoord(0.25, 0.75, 0.25, 0.75)

	if hasborder then
		local uptext = f:CreateTexture(nil, "BACKGROUND")
		uptext:SetWidth(31)
		uptext:SetHeight(256)
		uptext:SetPoint("TOPLEFT", upbutt, "TOPLEFT", -7, 5)
		uptext:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar")
		uptext:SetTexCoord(0, 0.484375, 0, 1.0)

		local downtex = f:CreateTexture(nil, "BACKGROUND")
		downtex:SetWidth(31)
		downtex:SetHeight(106)
		downtex:SetPoint("BOTTOMLEFT", downbutt, "BOTTOMLEFT", -7, -3)
		downtex:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar")
		downtex:SetTexCoord(0.515625, 1.0, 0, 0.4140625)
	end

	return f, upbutt, downbutt
end
