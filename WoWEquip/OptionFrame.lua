----------------------------------------------------------------------------------------
-- WoWEquip file for the Save/Load/Send/Compare Frame

local WoWEquip = LibStub("AceAddon-3.0"):GetAddon("WoWEquip")
local L = LibStub("AceLocale-3.0"):GetLocale("WoWEquip", false)


----------------------------------------------------------------------------------------
-- Option Frame Helper Functions

local function WoWEquip_SetNewBackgroundColor()
	local r, g, b = ColorPickerFrame:GetColorRGB()
	local a = 1.0 - OpacitySliderFrame:GetValue()
	WoWEquip:SetBackgroundColor(r, g, b, a)
end

local function WoWEquip_SetOldBackgroundColor(colortable)		
	WoWEquip:SetBackgroundColor(colortable.r, colortable.g, colortable.b, colortable.a)
end

--[[
local function WoWEquip_SetNewBackdropBorderColor()
	local r, g, b = ColorPickerFrame:GetColorRGB()
	local a = 1.0 - OpacitySliderFrame:GetValue()
	WoWEquip:SetBackdropBorderColor(r, g, b, a)
end

local function WoWEquip_SetOldBackdropBorderColor(colortable)		
	WoWEquip:SetBackdropBorderColor(colortable.r, colortable.g, colortable.b, colortable.a)
end
]]

local function swatchOnEnter(self)
	self.texture:SetTexture(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
end

local function swatchOnLeave(self)
	self.texture:SetTexture(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
end


----------------------------------------------------------------------------------------
-- Create the frames used by the Option Frame window

do
	-- Create the WoWEquip Options frame
	local WoWEquip_OptionFrame = CreateFrame("Frame", "WoWEquip_OptionFrame")
	WoWEquip_OptionFrame:Hide()
	WoWEquip.OptionFrame = WoWEquip_OptionFrame

	-- Title text
	WoWEquip_OptionFrame.titleText = WoWEquip_OptionFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	WoWEquip_OptionFrame.titleText:SetPoint("TOPLEFT", 16, -16)
	WoWEquip_OptionFrame.titleText:SetText(WoWEquip.versionstring)

	-- Lock Window checkbox
	CreateFrame("CheckButton", "WoWEquip_OptionFrame_LockWindow", WoWEquip_OptionFrame, "InterfaceOptionsCheckButtonTemplate")
	WoWEquip_OptionFrame_LockWindow:SetPoint("TOPLEFT", 16, -35)
	WoWEquip_OptionFrame_LockWindow:SetHitRectInsets(0, -300, 0, 0)
	WoWEquip_OptionFrame_LockWindowText:SetText(L["Lock WoWEquip windows from being moved"])
	WoWEquip_OptionFrame_LockWindow:SetScript("OnClick", function(self, button, down)
		local db = WoWEquip.db.global
		db.LockWindow = not db.LockWindow
		self:SetChecked(db.LockWindow)
	end)

	-- Preserve enchants checkbox
	CreateFrame("CheckButton", "WoWEquip_OptionFrame_PreserveEnchant", WoWEquip_OptionFrame, "InterfaceOptionsCheckButtonTemplate")
	WoWEquip_OptionFrame_PreserveEnchant:SetPoint("TOPLEFT", WoWEquip_OptionFrame_LockWindow, "BOTTOMLEFT", 0, 0)
	WoWEquip_OptionFrame_PreserveEnchant:SetHitRectInsets(0, -300, 0, 0)
	WoWEquip_OptionFrame_PreserveEnchantText:SetText(L["Keep previous enchant when equipping a new item"])
	WoWEquip_OptionFrame_PreserveEnchant:SetScript("OnClick", function(self, button, down)
		local db = WoWEquip.db.global
		db.PreserveEnchant = not db.PreserveEnchant
		self:SetChecked(db.PreserveEnchant)
	end)

	-- Change Background Colour button
	local WoWEquip_OptionFrame_BGColorButton = CreateFrame("Button", nil, WoWEquip_OptionFrame)
	WoWEquip_OptionFrame_BGColorButton:SetWidth(18)
	WoWEquip_OptionFrame_BGColorButton:SetHeight(18)
	WoWEquip_OptionFrame_BGColorButton:SetNormalTexture("Interface\\ChatFrame\\ChatFrameColorSwatch")
	WoWEquip_OptionFrame_BGColorButton:SetPoint("TOPLEFT", WoWEquip_OptionFrame_PreserveEnchant, "BOTTOMLEFT", 3, -5)
	WoWEquip_OptionFrame_BGColorButton.text = WoWEquip_OptionFrame_BGColorButton:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	WoWEquip_OptionFrame_BGColorButton.text:SetPoint("LEFT", WoWEquip_OptionFrame_BGColorButton, "RIGHT", 0, 0)
	WoWEquip_OptionFrame_BGColorButton.text:SetWidth(155)
	WoWEquip_OptionFrame_BGColorButton.text:SetHeight(18)
	WoWEquip_OptionFrame_BGColorButton.text:SetJustifyH("LEFT")
	WoWEquip_OptionFrame_BGColorButton.text:SetText(L["Background Color"])
	WoWEquip_OptionFrame_BGColorButton.texture = WoWEquip_OptionFrame_BGColorButton:CreateTexture(nil, "BACKGROUND")
	WoWEquip_OptionFrame_BGColorButton.texture:SetWidth(16)
	WoWEquip_OptionFrame_BGColorButton.texture:SetHeight(16)
	WoWEquip_OptionFrame_BGColorButton.texture:SetPoint("CENTER")
	WoWEquip_OptionFrame_BGColorButton.texture:SetTexture(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	WoWEquip_OptionFrame_BGColorButton:SetScript("OnEnter", swatchOnEnter)
	WoWEquip_OptionFrame_BGColorButton:SetScript("OnLeave", swatchOnLeave)
	WoWEquip_OptionFrame_BGColorButton:SetScript("OnClick", function(self, button, down)
		local db = WoWEquip.db.global
		-- These 2 lines fix a bug for an uninitialised OpacitySliderFrame
		-- returning and saving a value of 0 on SetColorRGB and SetValue
		ColorPickerFrame.opacityFunc = nil
		OpacitySliderFrame:SetValue(1.0 - db.a)

		ColorPickerFrame.func = WoWEquip_SetNewBackgroundColor
		ColorPickerFrame.hasOpacity = 1
		ColorPickerFrame.opacityFunc = WoWEquip_SetNewBackgroundColor
		ColorPickerFrame.opacity = 1.0 - db.a
		ColorPickerFrame.previousValues = {r = db.r, g = db.g, b = db.b, a = db.a}
		ColorPickerFrame.cancelFunc = WoWEquip_SetOldBackgroundColor
		ColorPickerFrame:SetColorRGB(db.r, db.g, db.b)
		ShowUIPanel(ColorPickerFrame)
	end)
	WoWEquip_OptionFrame.BGColorButton = WoWEquip_OptionFrame_BGColorButton

	--[[
	-- Change Border Colour button
	local WoWEquip_OptionFrame_BBGColorButton = CreateFrame("Button", nil, WoWEquip_OptionFrame)
	WoWEquip_OptionFrame_BBGColorButton:SetWidth(18)
	WoWEquip_OptionFrame_BBGColorButton:SetHeight(18)
	WoWEquip_OptionFrame_BBGColorButton:SetNormalTexture("Interface\\ChatFrame\\ChatFrameColorSwatch")
	WoWEquip_OptionFrame_BBGColorButton:SetPoint("TOPLEFT", WoWEquip_OptionFrame_PreserveEnchant, "BOTTOMLEFT", 183, -5)
	WoWEquip_OptionFrame_BBGColorButton.text = WoWEquip_OptionFrame_BBGColorButton:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	WoWEquip_OptionFrame_BBGColorButton.text:SetPoint("LEFT", WoWEquip_OptionFrame_BBGColorButton, "RIGHT", 0, 0)
	WoWEquip_OptionFrame_BBGColorButton.text:SetWidth(155)
	WoWEquip_OptionFrame_BBGColorButton.text:SetHeight(18)
	WoWEquip_OptionFrame_BBGColorButton.text:SetJustifyH("LEFT")
	WoWEquip_OptionFrame_BBGColorButton.text:SetText(L["Border Color"])
	WoWEquip_OptionFrame_BBGColorButton.texture = WoWEquip_OptionFrame_BBGColorButton:CreateTexture(nil, "BACKGROUND")
	WoWEquip_OptionFrame_BBGColorButton.texture:SetWidth(16)
	WoWEquip_OptionFrame_BBGColorButton.texture:SetHeight(16)
	WoWEquip_OptionFrame_BBGColorButton.texture:SetPoint("CENTER")
	WoWEquip_OptionFrame_BBGColorButton.texture:SetTexture(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	WoWEquip_OptionFrame_BBGColorButton:SetScript("OnEnter", swatchOnEnter)
	WoWEquip_OptionFrame_BBGColorButton:SetScript("OnLeave", swatchOnLeave)
	WoWEquip_OptionFrame_BBGColorButton:SetScript("OnClick", function(self)
		local db = WoWEquip.db.global
		-- These 2 lines fix a bug for an uninitialised OpacitySliderFrame
		-- returning and saving a value of 0 on SetColorRGB and SetValue
		ColorPickerFrame.opacityFunc = nil
		OpacitySliderFrame:SetValue(1.0 - db.ba)

		ColorPickerFrame.func = WoWEquip_SetNewBackdropBorderColor
		ColorPickerFrame.hasOpacity = 1
		ColorPickerFrame.opacityFunc = WoWEquip_SetNewBackdropBorderColor
		ColorPickerFrame.opacity = 1.0 - db.ba
		ColorPickerFrame.previousValues = {r = db.br, g = db.bg, b = db.bb, a = db.ba}
		ColorPickerFrame.cancelFunc = WoWEquip_SetOldBackdropBorderColor
		ColorPickerFrame:SetColorRGB(db.br, db.bg, db.bb)
		ShowUIPanel(ColorPickerFrame)
	end)
	WoWEquip_OptionFrame.BBGColorButton = WoWEquip_OptionFrame_BBGColorButton
	]]

	-- Transparency slider
	CreateFrame("Slider", "WoWEquip_TransparencySlider", WoWEquip_OptionFrame, "OptionsSliderTemplate")
	WoWEquip_TransparencySlider:SetWidth(300)
	WoWEquip_TransparencySlider:SetHeight(16)
	--WoWEquip_TransparencySlider:SetPoint("TOP", WoWEquip_OptionFrame_BBGColorButton, "BOTTOMLEFT", 0, -30)
	WoWEquip_TransparencySlider:SetPoint("TOP", WoWEquip_OptionFrame_PreserveEnchant, "BOTTOMLEFT", 183, -53)
	WoWEquip_TransparencySliderText:SetText(L["WoWEquip Transparency"])
	WoWEquip_TransparencySliderLow:SetText("25%")
	WoWEquip_TransparencySliderHigh:SetText("100%")
	WoWEquip_TransparencySlider:SetMinMaxValues(25, 100)
	WoWEquip_TransparencySlider:SetValueStep(1)
	WoWEquip_TransparencySlider:SetScript("OnValueChanged", function(self, value)
		WoWEquip_TransparencySliderText:SetFormattedText("%s: %d%%", L["WoWEquip Transparency"], value)
		WoWEquip.db.global.Transparency = value
		WoWEquip_Frame:SetAlpha(value / 100)
	end)

	-- Scale slider
	CreateFrame("Slider", "WoWEquip_ScaleSlider", WoWEquip_OptionFrame, "OptionsSliderTemplate")
	WoWEquip_ScaleSlider:SetWidth(300)
	WoWEquip_ScaleSlider:SetHeight(16)
	WoWEquip_ScaleSlider:SetPoint("TOP", WoWEquip_TransparencySlider, "BOTTOM", 0, -30)
	WoWEquip_ScaleSliderText:SetText(L["WoWEquip Scaling"])
	WoWEquip_ScaleSliderLow:SetText("50%")
	WoWEquip_ScaleSliderHigh:SetText("150%")
	WoWEquip_ScaleSlider:SetMinMaxValues(50, 150)
	WoWEquip_ScaleSlider:SetValueStep(1)
	WoWEquip_ScaleSlider:SetScript("OnValueChanged", function(self, value)
		WoWEquip_ScaleSliderText:SetFormattedText("%s: %d%%", L["WoWEquip Scaling"], value)
		WoWEquip.db.global.Scale = value
		WoWEquip_Frame:SetScale(value / 100)
	end)

	-- Dressing Room Scale slider
	CreateFrame("Slider", "WoWEquip_DRScaleSlider", WoWEquip_OptionFrame, "OptionsSliderTemplate")
	WoWEquip_DRScaleSlider:SetWidth(300)
	WoWEquip_DRScaleSlider:SetHeight(16)
	WoWEquip_DRScaleSlider:SetPoint("TOP", WoWEquip_ScaleSlider, "BOTTOM", 0, -30)
	WoWEquip_DRScaleSliderText:SetText(L["Attached Dressing Room Scaling"])
	WoWEquip_DRScaleSliderLow:SetText("50%")
	WoWEquip_DRScaleSliderHigh:SetText("150%")
	WoWEquip_DRScaleSlider:SetMinMaxValues(50, 150)
	WoWEquip_DRScaleSlider:SetValueStep(1)
	WoWEquip_DRScaleSlider:SetScript("OnValueChanged", function(self, value)
		WoWEquip_DRScaleSliderText:SetFormattedText("%s: %d%%", L["Attached Dressing Room Scaling"], value)
		WoWEquip.db.global.DRScale = value
		if WoWEquip_Frame:IsShown() and DressUpFrame:IsShown() then
			DressUpFrame:SetScale(WoWEquip.db.global.DRScale / 100)
			WoWEquip:UpdateDressUpModel()
		end
	end)

	-- Extra Width slider
	CreateFrame("Slider", "WoWEquip_ExtraWidthSlider", WoWEquip_OptionFrame, "OptionsSliderTemplate")
	WoWEquip_ExtraWidthSlider:SetWidth(300)
	WoWEquip_ExtraWidthSlider:SetHeight(16)
	WoWEquip_ExtraWidthSlider:SetPoint("TOP", WoWEquip_DRScaleSlider, "BOTTOM", 0, -30)
	WoWEquip_ExtraWidthSliderText:SetText(L["Add extra width to WoWEquip"])
	WoWEquip_ExtraWidthSliderLow:SetText("0")
	WoWEquip_ExtraWidthSliderHigh:SetText("128")
	WoWEquip_ExtraWidthSlider:SetMinMaxValues(0, 128)
	WoWEquip_ExtraWidthSlider:SetValueStep(1)
	WoWEquip_ExtraWidthSlider:SetScript("OnValueChanged", function(self, value)
		WoWEquip_ExtraWidthSliderText:SetFormattedText("%s: %d", L["Add extra width to WoWEquip"], value)
		WoWEquip.db.global.AddWidth = value
		WoWEquip:SetExtraWidth(value)
	end)

	-- Update the Option Frame on show
	WoWEquip_OptionFrame:SetScript("OnShow", function(self)
		local db = WoWEquip.db.global
		WoWEquip_OptionFrame_LockWindow:SetChecked(db.LockWindow)
		WoWEquip_OptionFrame_PreserveEnchant:SetChecked(db.PreserveEnchant)
		WoWEquip_OptionFrame_BGColorButton:GetNormalTexture():SetVertexColor(db.r, db.g, db.b, db.a)
		--WoWEquip_OptionFrame_BBGColorButton:GetNormalTexture():SetVertexColor(db.br, db.bg, db.bb, db.ba)
		WoWEquip_TransparencySlider:SetValue(db.Transparency)
		WoWEquip_ScaleSlider:SetValue(db.Scale)
		WoWEquip_DRScaleSlider:SetValue(db.DRScale)
		WoWEquip_ExtraWidthSlider:SetValue(db.AddWidth)
	end)

	-- Add to Blizzard Interface Options
	WoWEquip_OptionFrame.name = WoWEquip.versionstring
	InterfaceOptions_AddCategory(WoWEquip_OptionFrame)
end

-- vim: ts=4 noexpandtab
