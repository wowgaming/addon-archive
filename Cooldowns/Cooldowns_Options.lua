
---------------------------------------------------
-- Global vars
---------------------------------------------------

YarkoCooldowns_SavedVars = {};

---------------------------------------------------
-- Local vars
---------------------------------------------------


---------------------------------------------------
-- YarkoCooldowns.OptionsSetup
---------------------------------------------------
function YarkoCooldowns.OptionsSetup()
	if (not YarkoCooldowns_SavedVars.Tenths) then
		YarkoCooldowns.OptionsDefault();
	end
	InterfaceOptions_AddCategory(YarkoCooldowns_OptionsPanel);
end


---------------------------------------------------
-- YarkoCooldowns.OptionsDefault
---------------------------------------------------
function YarkoCooldowns.OptionsDefault()
	YarkoCooldowns_SavedVars.MainColor = YarkoCooldowns.CopyColors(YarkoCooldowns.DefaultMainColor);
	YarkoCooldowns_SavedVars.FlashColor = YarkoCooldowns.CopyColors(YarkoCooldowns.DefaultFlashColor);
	YarkoCooldowns_SavedVars.FontLocation = YarkoCooldowns.DefaultFontLocation;
	YarkoCooldowns_SavedVars.FontFile = YarkoCooldowns.DefaultFontFile;
	YarkoCooldowns_SavedVars.FontHeight = YarkoCooldowns.DefaultFontHeight;
	YarkoCooldowns_SavedVars.Shadow = YarkoCooldowns.DefaultShadow;
	YarkoCooldowns_SavedVars.Outline = YarkoCooldowns.DefaultOutline;
	YarkoCooldowns_SavedVars.Tenths = YarkoCooldowns.DefaultTenths;
	YarkoCooldowns_SavedVars.BelowTwo = YarkoCooldowns.DefaultBelowTwo;
	YarkoCooldowns_SavedVars.Seconds = YarkoCooldowns.DefaultSeconds;
	
	YarkoCooldowns.UpdateCooldowns();
end


---------------------------------------------------
-- YarkoCooldowns.OptionsRefresh
---------------------------------------------------
function YarkoCooldowns.OptionsRefresh()
	YarkoCooldowns_OptionsPanelMainColorNormalTexture:SetVertexColor(YarkoCooldowns_SavedVars.MainColor.r, 
		YarkoCooldowns_SavedVars.MainColor.g, YarkoCooldowns_SavedVars.MainColor.b);
	YarkoCooldowns_OptionsPanelFlashColorNormalTexture:SetVertexColor(YarkoCooldowns_SavedVars.FlashColor.r, 
		YarkoCooldowns_SavedVars.FlashColor.g, YarkoCooldowns_SavedVars.FlashColor.b);
	YarkoCooldowns_OptionsPanelFontLocation:SetText(YarkoCooldowns_SavedVars.FontLocation);
	YarkoCooldowns_OptionsPanelFontLocation:SetCursorPosition(0);
	YarkoCooldowns_OptionsPanelFontFile:SetText(YarkoCooldowns_SavedVars.FontFile);
	YarkoCooldowns_OptionsPanelFontFile:SetCursorPosition(0);
	YarkoCooldowns_OptionsPanelFontHeight:SetNumber(YarkoCooldowns_SavedVars.FontHeight);
	YarkoCooldowns_OptionsPanelFontHeight:SetCursorPosition(0);
	YarkoCooldowns_OptionsPanelShadow:SetChecked(YarkoCooldowns_SavedVars.Shadow == "Y");
    UIDropDownMenu_Initialize(YarkoCooldowns_OptionsPanelOutline, YarkoCooldowns.OutlineDropDownInit);
	UIDropDownMenu_SetSelectedValue(YarkoCooldowns_OptionsPanelOutline, YarkoCooldowns_SavedVars.Outline);
	YarkoCooldowns_OptionsPanelTenths:SetChecked(YarkoCooldowns_SavedVars.Tenths == "Y");
	YarkoCooldowns_OptionsPanelBelowTwo:SetChecked(YarkoCooldowns_SavedVars.BelowTwo == "Y");
	YarkoCooldowns_OptionsPanelSeconds:SetText(YarkoCooldowns_SavedVars.Seconds);
	YarkoCooldowns_OptionsPanelSeconds:SetCursorPosition(0);
end


---------------------------------------------------
-- YarkoCooldowns.OptionsOkay
---------------------------------------------------
function YarkoCooldowns.OptionsOkay()
	YarkoCooldowns_SavedVars.MainColor.r, YarkoCooldowns_SavedVars.MainColor.g, 
		YarkoCooldowns_SavedVars.MainColor.b 
		= YarkoCooldowns_OptionsPanelMainColorNormalTexture:GetVertexColor();
	YarkoCooldowns_SavedVars.FlashColor.r, YarkoCooldowns_SavedVars.FlashColor.g, 
		YarkoCooldowns_SavedVars.FlashColor.b 
		= YarkoCooldowns_OptionsPanelFlashColorNormalTexture:GetVertexColor();
	YarkoCooldowns_SavedVars.FontLocation = YarkoCooldowns_OptionsPanelFontLocation:GetText();
	YarkoCooldowns_SavedVars.FontFile = YarkoCooldowns_OptionsPanelFontFile:GetText();
	YarkoCooldowns_SavedVars.FontHeight = YarkoCooldowns_OptionsPanelFontHeight:GetNumber();
	YarkoCooldowns_SavedVars.Shadow = ((YarkoCooldowns_OptionsPanelShadow:GetChecked() and "Y") or "N");
	YarkoCooldowns_SavedVars.Outline = UIDropDownMenu_GetSelectedValue(YarkoCooldowns_OptionsPanelOutline);
	YarkoCooldowns_SavedVars.Tenths = ((YarkoCooldowns_OptionsPanelTenths:GetChecked() and "Y") or "N");
	YarkoCooldowns_SavedVars.BelowTwo = ((YarkoCooldowns_OptionsPanelBelowTwo:GetChecked() and "Y") or "N");
	YarkoCooldowns_SavedVars.Seconds = YarkoCooldowns_OptionsPanelSeconds:GetNumber();
		
	if (YarkoCooldowns_SavedVars.FontHeight < 4) then
		YarkoCooldowns_SavedVars.FontHeight = 4;
	end
	
	if (YarkoCooldowns_SavedVars.FontHeight > 72) then
		YarkoCooldowns_SavedVars.FontHeight = 72;
	end
	
	if (YarkoCooldowns_SavedVars.Seconds > 120) then
		YarkoCooldowns_SavedVars.Seconds = 120;
	end

	if (YarkoCooldowns_SavedVars.Seconds < 10) then
		YarkoCooldowns_SavedVars.Seconds = 10;
	end
	
	YarkoCooldowns.UpdateCooldowns();
end


---------------------------------------------------
-- YarkoCooldowns.OutlineDropDownInit
---------------------------------------------------
function YarkoCooldowns.OutlineDropDownInit(self)
	local info = UIDropDownMenu_CreateInfo();
	
	info.text = YARKOCOOLDOWNS_CONFIG_NONE;
	info.value = 1;
	info.func = YarkoCooldowns.OutlineDropDownOnClick;
	info.checked = nil;
	UIDropDownMenu_AddButton(info);
	
	info.text = YARKOCOOLDOWNS_CONFIG_NORMAL;
	info.value = 2;
	info.func = YarkoCooldowns.OutlineDropDownOnClick;
	info.checked = nil;
	UIDropDownMenu_AddButton(info);
	
	info.text = YARKOCOOLDOWNS_CONFIG_THICK;
	info.value = 3;
	info.func = YarkoCooldowns.OutlineDropDownOnClick;
	info.checked = nil;
	UIDropDownMenu_AddButton(info);
end


---------------------------------------------------
-- YarkoCooldowns.OutlineDropDownOnClick
---------------------------------------------------
function YarkoCooldowns.OutlineDropDownOnClick(self)
	UIDropDownMenu_SetSelectedValue(YarkoCooldowns_OptionsPanelOutline, self.value);
end


---------------------------------------------------
-- YarkoCooldowns.SwatchOnClick
---------------------------------------------------
function YarkoCooldowns.SwatchOnClick(self)
	local info = {};
	info.extraInfo = _G[self:GetName().."NormalTexture"];
	info.r, info.g, info.b = info.extraInfo:GetVertexColor();
	info.swatchFunc = YarkoCooldowns.SetColor;
	OpenColorPicker(info);
end


---------------------------------------------------
-- YarkoCooldowns.SetColor
---------------------------------------------------
function YarkoCooldowns.SetColor()
	if (not ColorPickerFrame:IsVisible()) then
		ColorPickerFrame.extraInfo:SetVertexColor(ColorPickerFrame:GetColorRGB());
	end
end


---------------------------------------------------
-- YarkoCooldowns.UpdateCooldowns
---------------------------------------------------
function YarkoCooldowns.UpdateCooldowns()
	local index, value;
	
	for index, value in ipairs(YarkoCooldowns.CounterFrames) do
		YarkoCooldowns.UpdateFont(value);
	end
end


---------------------------------------------------
-- YarkoCooldowns.CopyColors
---------------------------------------------------
function YarkoCooldowns.CopyColors(object)
	local tbl = {};
	
	tbl.r = object.r;
	tbl.g = object.g;
	tbl.b = object.b;
	
	return tbl;
end
