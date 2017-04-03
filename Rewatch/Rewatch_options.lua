-- AddOn by Daîsey, Argent Dawn, Europe. Please give me credit when you want to redistribute or modify this addon! Contact: coenvdwel@planet.nl
-- Coen van der Wel, Eindhoven, the Netherlands.


function rewatch_CreateOptions()
	-- create the options frame
	rewatch_options = CreateFrame("FRAME", "Rewatch_Options", UIParent); rewatch_options.name = "Rewatch";
	rewatch_options2 = CreateFrame("FRAME", "Rewatch_Options2", UIParent); rewatch_options2.name = "Advanced"; rewatch_options2.parent = "Rewatch";
	rewatch_options3 = CreateFrame("FRAME", "Rewatch_Options3", UIParent); rewatch_options3.name = "Highlighting"; rewatch_options3.parent = "Rewatch";
	-- slider
	local alphaSliderT = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	alphaSliderT:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 10, -10); alphaSliderT:SetText(rewatch_loc["gcdText"]);
	local alphaSlider = CreateFrame("SLIDER", "Rewatch_AlphaSlider", rewatch_options, "OptionsSliderTemplate");
	alphaSlider:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 235, -10); alphaSlider:SetMinMaxValues(0, 1); alphaSlider:SetValueStep(0.1);
	getglobal("Rewatch_AlphaSliderLow"):SetText(rewatch_loc["invisible"]); getglobal("Rewatch_AlphaSliderHigh"):SetText(rewatch_loc["visible"]);
	-- slider two
	local OORalphaSliderT = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	OORalphaSliderT:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 10, -40); OORalphaSliderT:SetText(rewatch_loc["OORText"]);
	local OORalphaSlider = CreateFrame("SLIDER", "Rewatch_OORAlphaSlider", rewatch_options, "OptionsSliderTemplate");
	OORalphaSlider:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 235, -40); OORalphaSlider:SetMinMaxValues(0, 1); OORalphaSlider:SetValueStep(0.1);
	getglobal("Rewatch_OORAlphaSliderLow"):SetText(rewatch_loc["invisible"]); getglobal("Rewatch_OORAlphaSliderHigh"):SetText(rewatch_loc["visible"]);
	-- health bar color
	local healthCPT = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	healthCPT:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 15, -90); healthCPT:SetText(rewatch_loc["healthback"]);
	local healthCP = CreateFrame("BUTTON", "Rewatch_HealthCP", rewatch_options); healthCP:SetWidth(18); healthCP:SetHeight(18);
	healthCP:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = 1, tileSize = 5, edgeSize = 5, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	healthCP:SetBackdropColor(rewatch_loadInt["HealthColor"].r, rewatch_loadInt["HealthColor"].g, rewatch_loadInt["HealthColor"].b, 0.8);
	healthCP:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 213, -90);
	healthCP:SetScript("OnClick", function() ColorPickerFrame:Hide(); ColorPickerFrame.func = rewatch_UpdateHColor; ColorPickerFrame:SetColorRGB(rewatch_loadInt["HealthColor"].r, rewatch_loadInt["HealthColor"].g, rewatch_loadInt["HealthColor"].b); ColorPickerFrame.hasOpacity = false; ColorPickerFrame.opacityFunc = nil; ColorPickerFrame:Show(); end);
	local healthCPR = CreateFrame("BUTTON", "Rewatch_HealthCPR", rewatch_options, "OptionsButtonTemplate"); healthCPR:SetText(rewatch_loc["reset"]);
	healthCPR:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 235, -88); healthCPR:SetScript("OnClick", function() rewatch_loadInt["HealthColor"] = { r=0; g=0.7; b=0}; rewatch_load["HealthColor"] = rewatch_loadInt["HealthColor"]; rewatch_UpdateSwatch(); end);
	-- frame color
	local frameCPT = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	frameCPT:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 15, -110); frameCPT:SetText(rewatch_loc["frameback"]);
	local frameCP = CreateFrame("BUTTON", "Rewatch_FrameCP", rewatch_options); frameCP:SetWidth(18); frameCP:SetHeight(18);
	frameCP:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = 1, tileSize = 5, edgeSize = 5, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	frameCP:SetBackdropColor(rewatch_loadInt["FrameColor"].r, rewatch_loadInt["FrameColor"].g, rewatch_loadInt["FrameColor"].b, rewatch_loadInt["FrameColor"].a); frameCP:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 213, -110);
	frameCP:SetScript("OnClick", function() ColorPickerFrame:Hide(); OpacitySliderFrame:SetValue((1-rewatch_loadInt["FrameColor"].a)); ColorPickerFrame.opacityFunc = rewatch_UpdateFColor; ColorPickerFrame.func = rewatch_UpdateFColor; ColorPickerFrame:SetColorRGB(rewatch_loadInt["FrameColor"].r, rewatch_loadInt["FrameColor"].g, rewatch_loadInt["FrameColor"].b); ColorPickerFrame.hasOpacity = true; ColorPickerFrame.opacity = (1-rewatch_loadInt["FrameColor"].a); OpacitySliderFrame:SetValue((1-rewatch_loadInt["FrameColor"].a)); ColorPickerFrame:Show(); end);
	local frameCPR = CreateFrame("BUTTON", "Rewatch_FrameCPR", rewatch_options, "OptionsButtonTemplate"); frameCPR:SetText(rewatch_loc["reset"]);
	frameCPR:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 235, -108); frameCPR:SetScript("OnClick", function() rewatch_loadInt["FrameColor"] = { r=0; g=0; b=0; a=0.3}; rewatch_load["FrameColor"] = rewatch_loadInt["FrameColor"]; rewatch_UpdateSwatch(); for i=1,rewatch_i-1 do local val = rewatch_bars[i]; if(val) then val["Frame"]:SetBackdropColor(rewatch_loadInt["FrameColor"].r, rewatch_loadInt["FrameColor"].g, rewatch_loadInt["FrameColor"].b, rewatch_loadInt["FrameColor"].a); end; end; end);
	-- frame mark color
	local mframeCP = CreateFrame("BUTTON", "Rewatch_MFrameCP", rewatch_options); mframeCP:SetWidth(18); mframeCP:SetHeight(18);
	mframeCP:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = 1, tileSize = 5, edgeSize = 5, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	mframeCP:SetBackdropColor(rewatch_loadInt["MarkFrameColor"].r, rewatch_loadInt["MarkFrameColor"].g, rewatch_loadInt["MarkFrameColor"].b, rewatch_loadInt["MarkFrameColor"].a); mframeCP:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 195, -110);
	mframeCP:SetScript("OnClick", function() ColorPickerFrame:Hide(); OpacitySliderFrame:SetValue((1-rewatch_loadInt["MarkFrameColor"].a)); ColorPickerFrame.opacityFunc = rewatch_UpdateMFColor; ColorPickerFrame.func = rewatch_UpdateMFColor; ColorPickerFrame:SetColorRGB(rewatch_loadInt["MarkFrameColor"].r, rewatch_loadInt["MarkFrameColor"].g, rewatch_loadInt["MarkFrameColor"].b); ColorPickerFrame.hasOpacity = true; ColorPickerFrame.opacity = (1-rewatch_loadInt["MarkFrameColor"].a); OpacitySliderFrame:SetValue((1-rewatch_loadInt["MarkFrameColor"].a)); ColorPickerFrame:Show(); end);
	-- bar colors
	local barCPT_lb = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	barCPT_lb:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 15, -130); barCPT_lb:SetText(rewatch_loc["barback"].." "..rewatch_loc["lifebloom"]);
	local barCPT_rej = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	barCPT_rej:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 15, -150); barCPT_rej:SetText(rewatch_loc["barback"].." "..rewatch_loc["rejuvenation"]);
	local barCPT_reg = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	barCPT_reg:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 15, -170); barCPT_reg:SetText(rewatch_loc["barback"].." "..rewatch_loc["regrowth"]);
	local barCPT_wg = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	barCPT_wg:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 15, -190); barCPT_wg:SetText(rewatch_loc["barback"].." "..rewatch_loc["wildgrowth"]);
	--[[lb stack colors]]--
	local barCP_lb = CreateFrame("BUTTON", "Rewatch_BarCP"..rewatch_loc["lifebloom"], rewatch_options); barCP_lb:SetWidth(18); barCP_lb:SetHeight(18);
	barCP_lb:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = 1, tileSize = 5, edgeSize = 5, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	barCP_lb:SetBackdropColor(rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"]].r, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"]].g, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"]].b, 0.8); barCP_lb:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 177, -130);
	barCP_lb:SetScript("OnClick", function() ColorPickerFrame:Hide(); ColorPickerFrame.func = rewatch_UpdateBLBColor; ColorPickerFrame:SetColorRGB(rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"]].r, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"]].g, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"]].b); ColorPickerFrame.hasOpacity = false; ColorPickerFrame.opacityFunc = nil; ColorPickerFrame:Show(); end);
	local barCP_lb2 = CreateFrame("BUTTON", "Rewatch_BarCP"..rewatch_loc["lifebloom"].."2", rewatch_options); barCP_lb2:SetWidth(18); barCP_lb2:SetHeight(18);
	barCP_lb2:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = 1, tileSize = 5, edgeSize = 5, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	barCP_lb2:SetBackdropColor(rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."2"].r, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."2"].g, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."2"].b, 0.8); barCP_lb2:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 195, -130);
	barCP_lb2:SetScript("OnClick", function() ColorPickerFrame:Hide(); ColorPickerFrame.func = rewatch_UpdateBLB2Color; ColorPickerFrame:SetColorRGB(rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."2"].r, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."2"].g, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."2"].b); ColorPickerFrame.hasOpacity = false; ColorPickerFrame.opacityFunc = nil; ColorPickerFrame:Show(); end);
	local barCP_lb3 = CreateFrame("BUTTON", "Rewatch_BarCP"..rewatch_loc["lifebloom"].."3", rewatch_options); barCP_lb3:SetWidth(18); barCP_lb3:SetHeight(18);
	barCP_lb3:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = 1, tileSize = 5, edgeSize = 5, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	barCP_lb3:SetBackdropColor(rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."3"].r, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."3"].g, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."3"].b, 0.8); barCP_lb3:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 213, -130);
	barCP_lb3:SetScript("OnClick", function() ColorPickerFrame:Hide(); ColorPickerFrame.func = rewatch_UpdateBLB3Color; ColorPickerFrame:SetColorRGB(rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."3"].r, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."3"].g, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."3"].b); ColorPickerFrame.hasOpacity = false; ColorPickerFrame.opacityFunc = nil; ColorPickerFrame:Show(); end);
	--[[/lb stack colors]]--
	local barCP_rej = CreateFrame("BUTTON", "Rewatch_BarCP"..rewatch_loc["rejuvenation"], rewatch_options); barCP_rej:SetWidth(18); barCP_rej:SetHeight(18);
	barCP_rej:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = 1, tileSize = 5, edgeSize = 5, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	barCP_rej:SetBackdropColor(rewatch_loadInt["BarColor"..rewatch_loc["rejuvenation"]].r, rewatch_loadInt["BarColor"..rewatch_loc["rejuvenation"]].g, rewatch_loadInt["BarColor"..rewatch_loc["rejuvenation"]].b, 0.8); barCP_rej:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 213, -150);
	barCP_rej:SetScript("OnClick", function() ColorPickerFrame:Hide(); ColorPickerFrame.func = rewatch_UpdateBREJColor; ColorPickerFrame:SetColorRGB(rewatch_loadInt["BarColor"..rewatch_loc["rejuvenation"]].r, rewatch_loadInt["BarColor"..rewatch_loc["rejuvenation"]].g, rewatch_loadInt["BarColor"..rewatch_loc["rejuvenation"]].b); ColorPickerFrame.hasOpacity = false; ColorPickerFrame.opacityFunc = nil; ColorPickerFrame:Show(); end);
	local barCP_reg = CreateFrame("BUTTON", "Rewatch_BarCP"..rewatch_loc["regrowth"], rewatch_options); barCP_reg:SetWidth(18); barCP_reg:SetHeight(18);
	barCP_reg:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = 1, tileSize = 5, edgeSize = 5, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	barCP_reg:SetBackdropColor(rewatch_loadInt["BarColor"..rewatch_loc["regrowth"]].r, rewatch_loadInt["BarColor"..rewatch_loc["regrowth"]].g, rewatch_loadInt["BarColor"..rewatch_loc["regrowth"]].b, 0.8); barCP_reg:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 213, -170);
	barCP_reg:SetScript("OnClick", function() ColorPickerFrame:Hide(); ColorPickerFrame.func = rewatch_UpdateBREWColor; ColorPickerFrame:SetColorRGB(rewatch_loadInt["BarColor"..rewatch_loc["regrowth"]].r, rewatch_loadInt["BarColor"..rewatch_loc["regrowth"]].g, rewatch_loadInt["BarColor"..rewatch_loc["regrowth"]].b); ColorPickerFrame.hasOpacity = false; ColorPickerFrame.opacityFunc = nil; ColorPickerFrame:Show(); end);
	local barCP_wg = CreateFrame("BUTTON", "Rewatch_BarCP"..rewatch_loc["wildgrowth"], rewatch_options); barCP_wg:SetWidth(18); barCP_wg:SetHeight(18);
	barCP_wg:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = 1, tileSize = 5, edgeSize = 5, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	barCP_wg:SetBackdropColor(rewatch_loadInt["BarColor"..rewatch_loc["wildgrowth"]].r, rewatch_loadInt["BarColor"..rewatch_loc["wildgrowth"]].g, rewatch_loadInt["BarColor"..rewatch_loc["wildgrowth"]].b, 0.8); barCP_wg:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 213, -190);
	barCP_wg:SetScript("OnClick", function() ColorPickerFrame:Hide(); ColorPickerFrame.func = rewatch_UpdateBWGColor; ColorPickerFrame:SetColorRGB(rewatch_loadInt["BarColor"..rewatch_loc["wildgrowth"]].r, rewatch_loadInt["BarColor"..rewatch_loc["wildgrowth"]].g, rewatch_loadInt["BarColor"..rewatch_loc["wildgrowth"]].b); ColorPickerFrame.hasOpacity = false; ColorPickerFrame.opacityFunc = nil; ColorPickerFrame:Show(); end);
	-- reset buttons
	local barCPR_lb = CreateFrame("BUTTON", "Rewatch_BarCPR", rewatch_options, "OptionsButtonTemplate"); barCPR_lb:SetText(rewatch_loc["reset"]);
	barCPR_lb:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 235, -128); barCPR_lb:SetScript("OnClick", function()
		rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"]] = { r=0.6; g=0; b=0}; rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."2"] = { r=1; g=0.5; b=0}; rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."3"] = { r=0; g=0; b=0.8};
		rewatch_load["BarColor"..rewatch_loc["lifebloom"]] = rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"]]; rewatch_load["BarColor"..rewatch_loc["lifebloom"].."2"] = rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."2"]; rewatch_load["BarColor"..rewatch_loc["lifebloom"].."3"] = rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."3"]; rewatch_UpdateSwatch();
	end);
	local barCPR_rej = CreateFrame("BUTTON", "Rewatch_BarCPR", rewatch_options, "OptionsButtonTemplate"); barCPR_rej:SetText(rewatch_loc["reset"]);
	barCPR_rej:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 235, -148); barCPR_rej:SetScript("OnClick", function() rewatch_loadInt["BarColor"..rewatch_loc["rejuvenation"]] = { r=0.85; g=0.15; b=0.80}; rewatch_load["BarColor"..rewatch_loc["rejuvenation"]] = rewatch_loadInt["BarColor"..rewatch_loc["rejuvenation"]]; rewatch_UpdateSwatch(); end);
	local barCPR_reg = CreateFrame("BUTTON", "Rewatch_BarCPR", rewatch_options, "OptionsButtonTemplate"); barCPR_reg:SetText(rewatch_loc["reset"]);
	barCPR_reg:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 235, -168); barCPR_reg:SetScript("OnClick", function() rewatch_loadInt["BarColor"..rewatch_loc["regrowth"]] = { r=0.05; g=0.3; b=0.1}; rewatch_load["BarColor"..rewatch_loc["regrowth"]] = rewatch_loadInt["BarColor"..rewatch_loc["regrowth"]]; rewatch_UpdateSwatch(); end);
	local barCPR_wg = CreateFrame("BUTTON", "Rewatch_BarCPR", rewatch_options, "OptionsButtonTemplate"); barCPR_wg:SetText(rewatch_loc["reset"]);
	barCPR_wg:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 235, -188); barCPR_wg:SetScript("OnClick", function() rewatch_loadInt["BarColor"..rewatch_loc["wildgrowth"]] = { r=0.5; g=0.8; b=0.3}; rewatch_load["BarColor"..rewatch_loc["wildgrowth"]] = rewatch_loadInt["BarColor"..rewatch_loc["wildgrowth"]]; rewatch_UpdateSwatch(); end);
	-- left options
	local hideCBT = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	hideCBT:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 50, -220); hideCBT:SetText(rewatch_loc["hide"]);
	local hideCB = CreateFrame("CHECKBUTTON", "Rewatch_HideCB", rewatch_options, "OptionsCheckButtonTemplate");
	hideCB:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 10, -213);
	hideCB:SetHitRectInsets(0, -75, 0, 0);
	local soloHideCBT = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	soloHideCBT:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 140, -220); soloHideCBT:SetText(rewatch_loc["hideSolo"]);
	local soloHideCB = CreateFrame("CHECKBUTTON", "Rewatch_SoloHideCB", rewatch_options, "OptionsCheckButtonTemplate");
	soloHideCB:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 110, -213);
	soloHideCB:SetHitRectInsets(0, -75, 0, 0);
	local hideButtonsCBT = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	hideButtonsCBT:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 50, -240); hideButtonsCBT:SetText(rewatch_loc["hideButtons"]);
	local hideButtonsCB = CreateFrame("CHECKBUTTON", "Rewatch_HideButtonsCB", rewatch_options, "OptionsCheckButtonTemplate");
	hideButtonsCB:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 10, -233);
	hideButtonsCB:SetScript("OnClick", function(self) rewatch_ChangedDimentions = true; end);
	local autoGroupCBT = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	autoGroupCBT:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 50, -260); autoGroupCBT:SetText(rewatch_loc["autoAdjust"]);
	local autoGroupCB = CreateFrame("CHECKBUTTON", "Rewatch_AutoGroupCB", rewatch_options, "OptionsCheckButtonTemplate");
	autoGroupCB:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 10, -253);
	local lockCBT = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	lockCBT:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 50, -280); lockCBT:SetText(rewatch_loc["lockMain"]);
	local lockCB = CreateFrame("CHECKBUTTON", "Rewatch_LockCB", rewatch_options, "OptionsCheckButtonTemplate");
	lockCB:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 10, -273);
	lockCB:SetHitRectInsets(0, -75, 0, 0);
	local labelsCBT = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	labelsCBT:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 50, -300); labelsCBT:SetText(rewatch_loc["labelsOrTimers"]);
	local labelsCB = CreateFrame("CHECKBUTTON", "Rewatch_LabelsCB", rewatch_options, "OptionsCheckButtonTemplate");
	labelsCB:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 10, -293);
	labelsCB:SetScript("OnClick", function(self) rewatch_ChangedDimentions = true; end);
	local lockPCBT = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	lockPCBT:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 140, -280); lockPCBT:SetText(rewatch_loc["lockPlayers"]);
	local lockPCB = CreateFrame("CHECKBUTTON", "Rewatch_LockPCB", rewatch_options, "OptionsCheckButtonTemplate");
	lockPCB:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 110, -273);
	lockPCB:SetHitRectInsets(0, -75, 0, 0);
	local wgCBT = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	wgCBT:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 50, -320); wgCBT:SetText(rewatch_loc["talentedwg"]);
	local wgCB = CreateFrame("CHECKBUTTON", "Rewatch_WGCB", rewatch_options, "OptionsCheckButtonTemplate");
	wgCB:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 10, -313);
	wgCB:SetScript("OnClick", function(self) rewatch_ChangedDimentions = true; end);
	local ttCBT = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	ttCBT:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 50, -340); ttCBT:SetText(rewatch_loc["showtooltips"]);
	local ttCB = CreateFrame("CHECKBUTTON", "Rewatch_TTCB", rewatch_options, "OptionsCheckButtonTemplate");
	ttCB:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 10, -333);
	-- text
	local detail1 = rewatch_options:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	detail1:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 10, -370); detail1:SetWidth(250); detail1:SetText(rewatch_loc["optiondetails"]);
	-- dimentions
	local slideHBHT = rewatch_options2:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	slideHBHT:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 10, -30); slideHBHT:SetText(rewatch_loc["healthbarHeight"]);
	local slideHBH = CreateFrame("SLIDER", "Rewatch_SlideHBH", rewatch_options2, "OptionsSliderTemplate");
	slideHBH:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 213, -30); slideHBH:SetMinMaxValues(5, 50); slideHBH:SetValueStep(1);
	slideHBH:SetScript("OnValueChanged", function(self) rewatch_ChangedDimentions = true; getglobal("Rewatch_SlideHBHText"):SetText(math.floor(self:GetValue()+0.5)); end);
	getglobal("Rewatch_SlideHBHLow"):SetText("5"); getglobal("Rewatch_SlideHBHHigh"):SetText("50");
	local slideCBWT = rewatch_options2:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	slideCBWT:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 10, -60); slideCBWT:SetText(rewatch_loc["castbarWidth"]);
	local slideCBW = CreateFrame("SLIDER", "Rewatch_SlideCBW", rewatch_options2, "OptionsSliderTemplate");
	slideCBW:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 213, -60); slideCBW:SetMinMaxValues(50, 150); slideCBW:SetValueStep(1);
	slideCBW:SetScript("OnValueChanged", function(self) rewatch_ChangedDimentions = true; getglobal("Rewatch_SlideCBWText"):SetText(math.floor(self:GetValue()+0.5)); end);
	getglobal("Rewatch_SlideCBWLow"):SetText("50"); getglobal("Rewatch_SlideCBWHigh"):SetText("150");
	local slideCBHT = rewatch_options2:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	slideCBHT:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 10, -90); slideCBHT:SetText(rewatch_loc["castbarHeight"]);
	local slideCBH = CreateFrame("SLIDER", "Rewatch_SlideCBH", rewatch_options2, "OptionsSliderTemplate");
	slideCBH:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 213, -90); slideCBH:SetMinMaxValues(5, 50); slideCBH:SetValueStep(1);
	slideCBH:SetScript("OnValueChanged", function(self) rewatch_ChangedDimentions = true; getglobal("Rewatch_SlideCBHText"):SetText(math.floor(self:GetValue()+0.5)); end);
	getglobal("Rewatch_SlideCBHLow"):SetText("5"); getglobal("Rewatch_SlideCBHHigh"):SetText("50");
	local slideCBMT = rewatch_options2:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	slideCBMT:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 10, -120); slideCBMT:SetText(rewatch_loc["castbarMargin"]);
	local slideCBM = CreateFrame("SLIDER", "Rewatch_SlideCBM", rewatch_options2, "OptionsSliderTemplate");
	slideCBM:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 213, -120); slideCBM:SetMinMaxValues(0, 10); slideCBW:SetValueStep(1);
	slideCBM:SetScript("OnValueChanged", function(self) rewatch_ChangedDimentions = true; getglobal("Rewatch_SlideCBMText"):SetText(math.floor(self:GetValue()+0.5)); end);
	getglobal("Rewatch_SlideCBMLow"):SetText("0"); getglobal("Rewatch_SlideCBMHigh"):SetText("10");
	local slideBWT = rewatch_options2:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	slideBWT:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 10, -150); slideBWT:SetText(rewatch_loc["buttonWidth"]);
	local slideBW = CreateFrame("SLIDER", "Rewatch_SlideBW", rewatch_options2, "OptionsSliderTemplate");
	slideBW:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 213, -150); slideBW:SetMinMaxValues(10, 100); slideBW:SetValueStep(1);
	slideBW:SetScript("OnValueChanged", function(self) rewatch_ChangedDimentions = true; getglobal("Rewatch_SlideBWText"):SetText(math.floor(self:GetValue()+0.5)); end);
	getglobal("Rewatch_SlideBWLow"):SetText("10"); getglobal("Rewatch_SlideBWHigh"):SetText("100");
	local slideBHT = rewatch_options2:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	slideBHT:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 10, -180); slideBHT:SetText(rewatch_loc["buttonHeight"]);
	local slideBH = CreateFrame("SLIDER", "Rewatch_SlideBH", rewatch_options2, "OptionsSliderTemplate");
	slideBH:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 213, -180); slideBH:SetMinMaxValues(10, 100); slideBH:SetValueStep(1);
	slideBH:SetScript("OnValueChanged", function(self) rewatch_ChangedDimentions = true; getglobal("Rewatch_SlideBHText"):SetText(math.floor(self:GetValue()+0.5)); end);
	getglobal("Rewatch_SlideBHLow"):SetText("10"); getglobal("Rewatch_SlideBHHigh"):SetText("100");
	local slideBMT = rewatch_options2:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	slideBMT:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 10, -210); slideBMT:SetText(rewatch_loc["buttonMargin"]);
	local slideBM = CreateFrame("SLIDER", "Rewatch_SlideBM", rewatch_options2, "OptionsSliderTemplate");
	slideBM:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 213, -210); slideBM:SetMinMaxValues(0, 10); slideBW:SetValueStep(1);
	slideBM:SetScript("OnValueChanged", function(self) rewatch_ChangedDimentions = true; getglobal("Rewatch_SlideBMText"):SetText(math.floor(self:GetValue()+0.5)); end);
	getglobal("Rewatch_SlideBMLow"):SetText("0"); getglobal("Rewatch_SlideBMHigh"):SetText("10");
	local slideSBT = rewatch_options2:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	slideSBT:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 10, -240); slideSBT:SetText(rewatch_loc["sidebarWidth"]);
	local slideSB = CreateFrame("SLIDER", "Rewatch_SlideSB", rewatch_options2, "OptionsSliderTemplate");
	slideSB:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 213, -240); slideSB:SetMinMaxValues(0, 10); slideSB:SetValueStep(1);
	slideSB:SetScript("OnValueChanged", function(self) rewatch_ChangedDimentions = true; getglobal("Rewatch_SlideSBText"):SetText(math.floor(self:GetValue()+0.5)); end);
	getglobal("Rewatch_SlideSBLow"):SetText("0"); getglobal("Rewatch_SlideSBHigh"):SetText("10");
	-- deficit
	local hdtt = rewatch_options2:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	hdtt:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 10, -270); hdtt:SetText(rewatch_loc["deficitThreshold"]);
	local hdt = CreateFrame("SLIDER", "Rewatch_HDT", rewatch_options2, "OptionsSliderTemplate");
	hdt:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 213, -270); hdt:SetMinMaxValues(-1, 10); hdt:SetValueStep(1);
	hdt:SetScript("OnValueChanged", function(self) getglobal("Rewatch_HDTText"):SetText(math.floor(self:GetValue()+0.5).."k"); end);
	getglobal("Rewatch_HDTLow"):SetText("-1"); getglobal("Rewatch_HDTHigh"):SetText("10k");
	local hdtext = rewatch_options2:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	hdtext:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 50, -300); hdtext:SetText(rewatch_loc["showDeficit"]);
	local hd = CreateFrame("CHECKBUTTON", "Rewatch_HDCB", rewatch_options2, "OptionsCheckButtonTemplate");
	hd:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 10, -293);
	local hdnlt = rewatch_options2:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	hdnlt:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 250, -300); hdnlt:SetText(rewatch_loc["deficitNewLine"]);
	local hdnl = CreateFrame("CHECKBUTTON", "Rewatch_HDNLCB", rewatch_options2, "OptionsCheckButtonTemplate");
	hdnl:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 210, -293);
	-- num bars width
	local nbwt = rewatch_options2:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	nbwt:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 10, -330); nbwt:SetText(rewatch_loc["numFramesWide"]);
	local nbw = CreateFrame("SLIDER", "Rewatch_NBW", rewatch_options2, "OptionsSliderTemplate");
	nbw:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 213, -330); nbw:SetMinMaxValues(1, 25); nbw:SetValueStep(1);
	nbw:SetScript("OnValueChanged", function(self) rewatch_ChangedDimentions = true; getglobal("Rewatch_NBWText"):SetText(math.floor(self:GetValue()+0.5)); end);
	getglobal("Rewatch_NBWLow"):SetText("1"); getglobal("Rewatch_NBWHigh"):SetText("25");
	-- name cutting
	local nct = rewatch_options2:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	nct:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 10, -360); nct:SetText(rewatch_loc["maxNameLength"]);
	local ncw = CreateFrame("SLIDER", "Rewatch_NCW", rewatch_options2, "OptionsSliderTemplate");
	ncw:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 213, -360); ncw:SetMinMaxValues(0, 25); ncw:SetValueStep(1);
	ncw:SetScript("OnValueChanged", function(self) rewatch_ChangedDimentions = true; getglobal("Rewatch_NCWText"):SetText(math.floor(self:GetValue()+0.5)); end);
	getglobal("Rewatch_NCWLow"):SetText("(0 = Show all)"); getglobal("Rewatch_NCWHigh"):SetText("25");
	local applyBTN = CreateFrame("BUTTON", "Rewatch_ApplyBTN", rewatch_options2, "OptionsButtonTemplate"); applyBTN:SetText("Apply"); applyBTN:SetWidth(115);
	applyBTN:SetPoint("TOPLEFT", rewatch_options2, "TOPLEFT", 10, -390); applyBTN:SetScript("OnClick", function() rewatch_Clear(); rewatch_changed = true; rewatch_ChangedDimentions = false; end);
	-- buttons
	local buffCheckBTN = CreateFrame("BUTTON", "Rewatch_BuffCheckBTN", rewatch_options, "OptionsButtonTemplate"); buffCheckBTN:SetText(rewatch_loc["buffCheck"]);
	buffCheckBTN:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 235, -253); buffCheckBTN:SetScript("OnClick", rewatch_BuffCheck); buffCheckBTN:SetWidth(115);
	local sortBTN = CreateFrame("BUTTON", "Rewatch_BuffCheckBTN", rewatch_options, "OptionsButtonTemplate"); sortBTN:SetText(rewatch_loc["sortList"]); sortBTN:SetWidth(115);
	sortBTN:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 235, -273); sortBTN:SetScript("OnClick", function() if(rewatch_loadInt["AutoGroup"] == 0) then rewatch_Message(rewatch_loc["nosort"]); else rewatch_Clear(); rewatch_changed = true; rewatch_Message(rewatch_loc["sorted"]); end; end);
	local clearBTN = CreateFrame("BUTTON", "Rewatch_BuffCheckBTN", rewatch_options, "OptionsButtonTemplate"); clearBTN:SetText(rewatch_loc["clearList"]); clearBTN:SetWidth(115);
	clearBTN:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 235, -293); clearBTN:SetScript("OnClick", function() rewatch_Clear(); rewatch_Message(rewatch_loc["cleared"]); end);
	local reposBTN = CreateFrame("BUTTON", "Rewatch_RepositionBTN", rewatch_options, "OptionsButtonTemplate"); reposBTN:SetText(rewatch_loc["reposition"]); reposBTN:SetWidth(115);
	reposBTN:SetPoint("TOPLEFT", rewatch_options, "TOPLEFT", 235, -313); reposBTN:SetScript("OnClick", function() rewatch_f[1]:ClearAllPoints(); rewatch_f[1]:SetPoint("CENTER", UIParent); rewatch_Message(rewatch_loc["repositioned"]); end);
	-- custom highlighting
	local cht = rewatch_options3:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	cht:SetPoint("TOPLEFT", rewatch_options3, "TOPLEFT", 10, -10); cht:SetText("Low risk");
	local ch = CreateFrame("EDITBOX", "Rewatch_Highlighting", rewatch_options3);
	ch:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = nil, tile = false, tileSize = 1, edgeSize = 3, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	ch:SetPoint("TOPLEFT", rewatch_options3, "TOPLEFT", 10, -30);
	ch:SetPoint("BOTTOMLEFT", rewatch_options3, "BOTTOMLEFT", 10, 10);
	ch:SetWidth(140); ch:SetMultiLine(true); ch:SetAutoFocus(nil);
	ch:SetFont("Interface\\AddOns\\DebugLib\\VeraMono.TTF", 11);
	ch:SetFontObject(GameFontHighlight);
	local ch2t = rewatch_options3:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	ch2t:SetPoint("TOPLEFT", rewatch_options3, "TOPLEFT", 155, -10); ch2t:SetText("Medium risk");
	local ch2 = CreateFrame("EDITBOX", "Rewatch_Highlighting2", rewatch_options3);
	ch2:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = nil, tile = false, tileSize = 1, edgeSize = 3, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	ch2:SetPoint("TOPLEFT", rewatch_options3, "TOPLEFT", 155, -30);
	ch2:SetPoint("BOTTOMRIGHT", rewatch_options3, "BOTTOMRIGHT", -155, 10);
	ch2:SetMultiLine(true); ch2:SetAutoFocus(nil);
	ch2:SetFont("Interface\\AddOns\\DebugLib\\VeraMono.TTF", 11);
	ch2:SetFontObject(GameFontHighlight);
	local ch3t = rewatch_options3:CreateFontString("$parentText", "ARTWORK", "GameFontHighlightSmall");
	ch3t:SetPoint("TOPLEFT", rewatch_options3, "TOPRIGHT", -155, -10); ch3t:SetText("OMGOMGOMG");
	local ch3 = CreateFrame("EDITBOX", "Rewatch_Highlighting3", rewatch_options3);
	ch3:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = nil, tile = false, tileSize = 1, edgeSize = 3, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	ch3:SetPoint("TOPRIGHT", rewatch_options3, "TOPRIGHT", -10, -30);
	ch3:SetPoint("BOTTOMRIGHT", rewatch_options3, "BOTTOMRIGHT", -10, 10);
	ch3:SetWidth(140); ch3:SetMultiLine(true); ch3:SetAutoFocus(nil);
	ch3:SetFont("Interface\\AddOns\\DebugLib\\VeraMono.TTF", 11);
	ch3:SetFontObject(GameFontHighlight);
	-- handlers
	rewatch_options.okay = function(self) rewatch_OptionsFromData(false); if(rewatch_ChangedDimentions) then rewatch_Clear(); rewatch_changed = true; rewatch_Message(rewatch_loc["sorted"]); rewatch_ChangedDimentions = false; end; end;
	rewatch_options.cancel = function(self) rewatch_OptionsFromData(true); end;
	rewatch_options.default = function(self) rewatch_version, rewatch_load = nil, nil; rewatch_loadInt["Loaded"] = false; end;
	InterfaceOptions_AddCategory(rewatch_options); InterfaceOptions_AddCategory(rewatch_options2); InterfaceOptions_AddCategory(rewatch_options3);
end;

-- function set set the options frame values
-- get: boolean if the function will get data (true) or set data (false) from the options frame
-- return: void
function rewatch_OptionsFromData(get)
	-- get the childeren elements
	local children = { rewatch_options:GetChildren() };
	for _, child in ipairs(children) do
		-- if it's the slider, set or get his data
		if(child:GetName() == "Rewatch_AlphaSlider") then
			if(get) then child:SetValue(rewatch_loadInt["GcdAlpha"]);
			else rewatch_load["GcdAlpha"], rewatch_loadInt["GcdAlpha"] = child:GetValue(), child:GetValue(); end;
		-- if it's the OOR slider, set or get his data
		elseif(child:GetName() == "Rewatch_OORAlphaSlider") then
			if(get) then child:SetValue(rewatch_loadInt["OORAlpha"]);
			else rewatch_load["OORAlpha"], rewatch_loadInt["OORAlpha"] = child:GetValue(), child:GetValue(); end;
		-- if it's the autogroup checkbutton, set or get his data
		elseif(child:GetName() == "Rewatch_AutoGroupCB") then
			if(get) then if(rewatch_loadInt["AutoGroup"] == 1) then child:SetChecked(true); else child:SetChecked(false); end;
			else if(child:GetChecked()) then rewatch_load["AutoGroup"], rewatch_loadInt["AutoGroup"] = 1, 1;
				else
					if(rewatch_loadInt["AutoGroup"] == 1) then rewatch_load["AutoGroup"], rewatch_loadInt["AutoGroup"] = 0, 0; rewatch_changed = true;
					else rewatch_load["AutoGroup"], rewatch_loadInt["AutoGroup"] = 0, 0; end;
				end; end;
		-- if it's the hidesolo checkbutton, set or get his data
		elseif(child:GetName() == "Rewatch_SoloHideCB") then
			if(get) then if(rewatch_loadInt["HideSolo"] == 1) then child:SetChecked(true); else child:SetChecked(false); end;
			else if(child:GetChecked()) then rewatch_load["HideSolo"], rewatch_loadInt["HideSolo"] = 1, 1;
				else rewatch_load["HideSolo"], rewatch_loadInt["HideSolo"] = 0, 0; end; end;
		-- if it's the hide buttons checkbutton, set or get his data
		elseif(child:GetName() == "Rewatch_HideButtonsCB") then
			if(get) then if(rewatch_loadInt["ShowButtons"] == 0) then child:SetChecked(true); else child:SetChecked(false); end;
			else if(child:GetChecked()) then rewatch_load["ShowButtons"], rewatch_loadInt["ShowButtons"] = 0, 0;
				else rewatch_load["ShowButtons"], rewatch_loadInt["ShowButtons"] = 1, 1; end; end;
		-- if it's the hide checkbutton, set or get his data
		elseif(child:GetName() == "Rewatch_HideCB") then
			if(get) then if(rewatch_loadInt["Hide"] == 1) then child:SetChecked(true); else child:SetChecked(false); end;
			else if(child:GetChecked()) then rewatch_load["Hide"], rewatch_loadInt["Hide"] = 1, 1;
				else rewatch_load["Hide"], rewatch_loadInt["Hide"] = 0, 0; end; end;
		-- if it's the wild growth checkbox, set or get this data
		elseif(child:GetName() == "Rewatch_WGCB") then
			if(get) then if(rewatch_loadInt["WildGrowth"] == 1) then child:SetChecked(true); else child:SetChecked(false); end;
			else if(child:GetChecked()) then rewatch_load["WildGrowth"], rewatch_loadInt["WildGrowth"] = 1, 1;
				else rewatch_load["WildGrowth"], rewatch_loadInt["WildGrowth"] = 0, 0; end; end;
		-- if it's the tooltip checkbox, set or get this data
		elseif(child:GetName() == "Rewatch_TTCB") then
			if(get) then if(rewatch_loadInt["ShowTooltips"] == 1) then child:SetChecked(true); else child:SetChecked(false); end;
			else if(child:GetChecked()) then rewatch_load["ShowTooltips"], rewatch_loadInt["ShowTooltips"] = 1, 1;
				else rewatch_load["ShowTooltips"], rewatch_loadInt["ShowTooltips"] = 0, 0; end; end;
		-- if it's the lock checkbox, set or get this data
		elseif(child:GetName() == "Rewatch_LockCB") then
			if(get) then if(rewatch_loadInt["Lock"]) then child:SetChecked(true); else child:SetChecked(false); end;
			else if(child:GetChecked()) then rewatch_loadInt["Lock"] = true; else rewatch_loadInt["Lock"] = false; end; end;
		-- if it's the lock players checkbox, set or get this data
		elseif(child:GetName() == "Rewatch_LockPCB") then
			if(get) then if(rewatch_loadInt["LockP"]) then child:SetChecked(true); else child:SetChecked(false); end;
			else if(child:GetChecked()) then rewatch_loadInt["LockP"] = true; else rewatch_loadInt["LockP"] = false; end; end;
		-- if it's the lock checkbox, set or get this data
		elseif(child:GetName() == "Rewatch_LabelsCB") then
			if(get) then if(rewatch_loadInt["Labels"] == 1) then child:SetChecked(true); else child:SetChecked(false); end;
			else if(child:GetChecked()) then rewatch_load["Labels"] = 1; rewatch_loadInt["Labels"] = 1; else rewatch_loadInt["Labels"] = 0; rewatch_load["Labels"] = 0; end; end;
		end;
	end;
	-- dimentions
	children = { rewatch_options2:GetChildren() };
	for _, child in ipairs(children) do
		if(child:GetName() == "Rewatch_SlideHBH") then
			if(get) then child:SetValue(rewatch_loadInt["HealthBarHeight"]); getglobal("Rewatch_SlideHBHText"):SetText(rewatch_loadInt["HealthBarHeight"]);
			else rewatch_load["HealthBarHeight"], rewatch_loadInt["HealthBarHeight"] = math.floor(child:GetValue()+0.5), math.floor(child:GetValue()+0.5); end;
		elseif(child:GetName() == "Rewatch_SlideCBW") then
			if(get) then child:SetValue(rewatch_loadInt["SpellBarWidth"]); getglobal("Rewatch_SlideCBWText"):SetText(rewatch_loadInt["SpellBarWidth"]);
			else rewatch_load["SpellBarWidth"], rewatch_loadInt["SpellBarWidth"] = math.floor(child:GetValue()+0.5), math.floor(child:GetValue()+0.5); end;
		elseif(child:GetName() == "Rewatch_SlideCBH") then
			if(get) then child:SetValue(rewatch_loadInt["SpellBarHeight"]); getglobal("Rewatch_SlideCBHText"):SetText(rewatch_loadInt["SpellBarHeight"]);
			else rewatch_load["SpellBarHeight"], rewatch_loadInt["SpellBarHeight"] = math.floor(child:GetValue()+0.5), math.floor(child:GetValue()+0.5); end;
		elseif(child:GetName() == "Rewatch_SlideCBM") then
			if(get) then child:SetValue(rewatch_loadInt["SpellBarMargin"]); getglobal("Rewatch_SlideCBMText"):SetText(rewatch_loadInt["SpellBarMargin"]);
			else rewatch_load["SpellBarMargin"], rewatch_loadInt["SpellBarMargin"] = math.floor(child:GetValue()+0.5), math.floor(child:GetValue()+0.5); end;
		elseif(child:GetName() == "Rewatch_SlideBW") then
			if(get) then child:SetValue(rewatch_loadInt["SmallButtonWidth"]); getglobal("Rewatch_SlideBWText"):SetText(rewatch_loadInt["SmallButtonWidth"]);
			else rewatch_load["SmallButtonWidth"], rewatch_loadInt["SmallButtonWidth"] = math.floor(child:GetValue()+0.5), math.floor(child:GetValue()+0.5); end;
		elseif(child:GetName() == "Rewatch_SlideBH") then
			if(get) then child:SetValue(rewatch_loadInt["SmallButtonHeight"]); getglobal("Rewatch_SlideBHText"):SetText(rewatch_loadInt["SmallButtonHeight"]);
			else rewatch_load["SmallButtonHeight"], rewatch_loadInt["SmallButtonHeight"] = math.floor(child:GetValue()+0.5), math.floor(child:GetValue()+0.5); end;
		elseif(child:GetName() == "Rewatch_SlideBM") then
			if(get) then child:SetValue(rewatch_loadInt["SmallButtonMargin"]); getglobal("Rewatch_SlideBMText"):SetText(rewatch_loadInt["SmallButtonMargin"]);
			else rewatch_load["SmallButtonMargin"], rewatch_loadInt["SmallButtonMargin"] = math.floor(child:GetValue()+0.5), math.floor(child:GetValue()+0.5); end;
		elseif(child:GetName() == "Rewatch_SlideSB") then
			if(get) then child:SetValue(rewatch_loadInt["SideBar"]); getglobal("Rewatch_SlideSBText"):SetText(rewatch_loadInt["SideBar"]);
			else rewatch_load["SideBar"], rewatch_loadInt["SideBar"] = math.floor(child:GetValue()+0.5), math.floor(child:GetValue()+0.5); end;
		elseif(child:GetName() == "Rewatch_HDT") then
			if(get) then child:SetValue(rewatch_loadInt["DeficitThreshold"]); getglobal("Rewatch_HDTText"):SetText(rewatch_loadInt["DeficitThreshold"].."k");
			else rewatch_load["DeficitThreshold"], rewatch_loadInt["DeficitThreshold"] = math.floor(child:GetValue()+0.5), math.floor(child:GetValue()+0.5); end;
		elseif(child:GetName() == "Rewatch_HDCB") then
			if(get) then if(rewatch_loadInt["HealthDeficit"] > 0) then child:SetChecked(true); else child:SetChecked(false); end;
			else if(child:GetChecked()) then rewatch_load["HealthDeficit"], rewatch_loadInt["HealthDeficit"] = 1, 1;
				else rewatch_load["HealthDeficit"], rewatch_loadInt["HealthDeficit"] = 0, 0; end; end;
		elseif(child:GetName() == "Rewatch_HDNLCB") then
			if(get) then if(rewatch_loadInt["HealthDeficit"] > 1) then child:SetChecked(true); else child:SetChecked(false); end;
			else if(child:GetChecked()) then rewatch_load["HealthDeficit"], rewatch_loadInt["HealthDeficit"] = max(rewatch_load["HealthDeficit"]*2, 0), max(rewatch_loadInt["HealthDeficit"]*2, 0);
			end; end;
		elseif(child:GetName() == "Rewatch_NBW") then
			if(get) then child:SetValue(rewatch_loadInt["NumFramesWide"]); getglobal("Rewatch_NBWText"):SetText(rewatch_loadInt["NumFramesWide"]);
			else rewatch_load["NumFramesWide"], rewatch_loadInt["NumFramesWide"] = math.floor(child:GetValue()+0.5), math.floor(child:GetValue()+0.5); end;
		elseif(child:GetName() == "Rewatch_NCW") then
			if(get) then child:SetValue(rewatch_loadInt["NameCharLimit"]); getglobal("Rewatch_NCWText"):SetText(rewatch_loadInt["NameCharLimit"]);
			else rewatch_load["NameCharLimit"], rewatch_loadInt["NameCharLimit"] = math.floor(child:GetValue()+0.5), math.floor(child:GetValue()+0.5); end;
		end;
	end;
	-- custom highlighting
	children = { rewatch_options3:GetChildren() };
	for _, child in ipairs(children) do
		if(child:GetName() == "Rewatch_Highlighting") then
			if(get) then
				child:SetText(""); if(rewatch_loadInt["Highlighting"]) then for i, s in ipairs(rewatch_loadInt["Highlighting"]) do if(i > 1) then child:Insert("\n"); end; child:Insert(s); end; end;
			else
				rewatch_loadInt["Highlighting"] = {};
				local s, pos = child:GetText(), 0;
				for st, sp in function() return string.find(s, "\n", pos, true) end do
					table.insert(rewatch_loadInt["Highlighting"], string.sub(s, pos, st-1)); pos = sp + 1;
				end; table.insert(rewatch_loadInt["Highlighting"], string.sub(s, pos));
				rewatch_load["Highlighting"] = rewatch_loadInt["Highlighting"];
			end;
		elseif(child:GetName() == "Rewatch_Highlighting2") then
			if(get) then
				child:SetText(""); if(rewatch_loadInt["Highlighting2"]) then for i, s in ipairs(rewatch_loadInt["Highlighting2"]) do if(i > 1) then child:Insert("\n"); end; child:Insert(s); end; end;
			else
				rewatch_loadInt["Highlighting2"] = {};
				local s, pos = child:GetText(), 0;
				for st, sp in function() return string.find(s, "\n", pos, true) end do
					table.insert(rewatch_loadInt["Highlighting2"], string.sub(s, pos, st-1)); pos = sp + 1;
				end; table.insert(rewatch_loadInt["Highlighting2"], string.sub(s, pos));
				rewatch_load["Highlighting2"] = rewatch_loadInt["Highlighting2"];
			end;
		elseif(child:GetName() == "Rewatch_Highlighting3") then
			if(get) then
				child:SetText(""); if(rewatch_loadInt["Highlighting3"]) then for i, s in ipairs(rewatch_loadInt["Highlighting3"]) do if(i > 1) then child:Insert("\n"); end; child:Insert(s); end; end;
			else
				rewatch_loadInt["Highlighting3"] = {};
				local s, pos = child:GetText(), 0;
				for st, sp in function() return string.find(s, "\n", pos, true) end do
					table.insert(rewatch_loadInt["Highlighting3"], string.sub(s, pos, st-1)); pos = sp + 1;
				end; table.insert(rewatch_loadInt["Highlighting3"], string.sub(s, pos));
				rewatch_load["Highlighting3"] = rewatch_loadInt["Highlighting3"];
			end;
		end;
	end;
	-- apply changes
	if(not get) then
		rewatch_UpdateOffset();
		for _, cd in ipairs(rewatch_gcds) do cd:SetAlpha(rewatch_loadInt["GcdAlpha"]); end;
		if(((rewatch_i == 2) and (rewatch_loadInt["HideSolo"] == 1)) or (rewatch_loadInt["Hide"] == 1)) then rewatch_f[1]:Hide(); else rewatch_ShowFrame(); end;
	end;
end;

-- update a bar color and it's swatch
-- return: void
function rewatch_UpdateBLBColor()
	local rc, gc, bc = ColorPickerFrame:GetColorRGB(); rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"]] = { r=rc, g=gc, b=bc };
	rewatch_load["BarColor"..rewatch_loc["lifebloom"]] = rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"]]; rewatch_UpdateSwatch();
end;
function rewatch_UpdateBLB2Color()
	local rc, gc, bc = ColorPickerFrame:GetColorRGB(); rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."2"] = { r=rc, g=gc, b=bc };
	rewatch_load["BarColor"..rewatch_loc["lifebloom"].."2"] = rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."2"]; rewatch_UpdateSwatch();
end;
function rewatch_UpdateBLB3Color()
	local rc, gc, bc = ColorPickerFrame:GetColorRGB(); rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."3"] = { r=rc, g=gc, b=bc };
	rewatch_load["BarColor"..rewatch_loc["lifebloom"].."3"] = rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."3"]; rewatch_UpdateSwatch();
end;
function rewatch_UpdateBREJColor()
	local rc, gc, bc = ColorPickerFrame:GetColorRGB(); rewatch_loadInt["BarColor"..rewatch_loc["rejuvenation"]] = { r=rc, g=gc, b=bc };
	rewatch_load["BarColor"..rewatch_loc["rejuvenation"]] = rewatch_loadInt["BarColor"..rewatch_loc["rejuvenation"]]; rewatch_UpdateSwatch();
end;
function rewatch_UpdateBREWColor()
	local rc, gc, bc = ColorPickerFrame:GetColorRGB(); rewatch_loadInt["BarColor"..rewatch_loc["regrowth"]] = { r=rc, g=gc, b=bc };
	rewatch_load["BarColor"..rewatch_loc["regrowth"]] = rewatch_loadInt["BarColor"..rewatch_loc["regrowth"]]; rewatch_UpdateSwatch();
end;
function rewatch_UpdateBWGColor()
	local rc, gc, bc = ColorPickerFrame:GetColorRGB(); rewatch_loadInt["BarColor"..rewatch_loc["wildgrowth"]] = { r=rc, g=gc, b=bc };
	rewatch_load["BarColor"..rewatch_loc["wildgrowth"]] = rewatch_loadInt["BarColor"..rewatch_loc["wildgrowth"]]; rewatch_UpdateSwatch();
end;

-- update the frame color and it's swatch
-- return: void
function rewatch_UpdateFColor()
	local rc, gc, bc = ColorPickerFrame:GetColorRGB();
	local ac = 1-OpacitySliderFrame:GetValue();
	rewatch_loadInt["FrameColor"] = { r=rc, g=gc, b=bc, a=ac};
	rewatch_load["FrameColor"] = rewatch_loadInt["FrameColor"];
	for i=1,rewatch_i-1 do local val = rewatch_bars[i]; if(val) then val["Frame"]:SetBackdropColor(rewatch_loadInt["FrameColor"].r, rewatch_loadInt["FrameColor"].g, rewatch_loadInt["FrameColor"].b, rewatch_loadInt["FrameColor"].a); end; end;
	rewatch_UpdateSwatch();
end;

-- update the mark frame color and it's swatch
-- return: void
function rewatch_UpdateMFColor()
	local rc, gc, bc = ColorPickerFrame:GetColorRGB();
	local ac = 1-OpacitySliderFrame:GetValue();
	rewatch_loadInt["MarkFrameColor"] = { r=rc, g=gc, b=bc, a=ac};
	rewatch_load["MarkFrameColor"] = rewatch_loadInt["MarkFrameColor"];
	for i=1,rewatch_i-1 do local val = rewatch_bars[i]; if(val) then if(val["Mark"]) then rewatch_SetFrameBG(i); end; end; end;
	rewatch_UpdateSwatch();
end;

-- update the healthbar color and it's swatch
-- return: void
function rewatch_UpdateHColor()
	local rc, gc, bc = ColorPickerFrame:GetColorRGB();
	rewatch_loadInt["HealthColor"] = { r=rc, g=gc, b=bc, a=ac};
	rewatch_load["HealthColor"] = rewatch_loadInt["HealthColor"];
	rewatch_UpdateSwatch();
end;

-- update the swatches
-- return: void
function rewatch_UpdateSwatch()
	local children = { rewatch_options:GetChildren() };
	for _, child in ipairs(children) do
		-- if it's the framecolor colorpicker, get this data
		if(child:GetName() == "Rewatch_FrameCP") then
			child:SetBackdropColor(rewatch_loadInt["FrameColor"].r, rewatch_loadInt["FrameColor"].g, rewatch_loadInt["FrameColor"].b, rewatch_loadInt["FrameColor"].a);
		-- if it's the framecolor colorpicker, get this data
		elseif(child:GetName() == "Rewatch_MFrameCP") then
			child:SetBackdropColor(rewatch_loadInt["MarkFrameColor"].r, rewatch_loadInt["MarkFrameColor"].g, rewatch_loadInt["MarkFrameColor"].b, rewatch_loadInt["MarkFrameColor"].a);
		-- if it's the framecolor colorpicker, get this data
		elseif(child:GetName() == "Rewatch_HealthCP") then
			child:SetBackdropColor(rewatch_loadInt["HealthColor"].r, rewatch_loadInt["HealthColor"].g, rewatch_loadInt["HealthColor"].b, rewatch_loadInt["HealthColor"].a);
		-- if it's a barcolor colorpicker, get that data
		elseif(child:GetName() == "Rewatch_BarCP"..rewatch_loc["lifebloom"]) then
			child:SetBackdropColor(rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"]].r, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"]].g, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"]].b, 0.8);
		elseif(child:GetName() == "Rewatch_BarCP"..rewatch_loc["lifebloom"].."2") then
			child:SetBackdropColor(rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."2"].r, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."2"].g, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."2"].b, 0.8);
		elseif(child:GetName() == "Rewatch_BarCP"..rewatch_loc["lifebloom"].."3") then
			child:SetBackdropColor(rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."3"].r, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."3"].g, rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."3"].b, 0.8);
		elseif(child:GetName() == "Rewatch_BarCP"..rewatch_loc["rejuvenation"]) then
			child:SetBackdropColor(rewatch_loadInt["BarColor"..rewatch_loc["rejuvenation"]].r, rewatch_loadInt["BarColor"..rewatch_loc["rejuvenation"]].g, rewatch_loadInt["BarColor"..rewatch_loc["rejuvenation"]].b, 0.8);
		elseif(child:GetName() == "Rewatch_BarCP"..rewatch_loc["regrowth"]) then
			child:SetBackdropColor(rewatch_loadInt["BarColor"..rewatch_loc["regrowth"]].r, rewatch_loadInt["BarColor"..rewatch_loc["regrowth"]].g, rewatch_loadInt["BarColor"..rewatch_loc["regrowth"]].b, 0.8);
		elseif(child:GetName() == "Rewatch_BarCP"..rewatch_loc["wildgrowth"]) then
			child:SetBackdropColor(rewatch_loadInt["BarColor"..rewatch_loc["wildgrowth"]].r, rewatch_loadInt["BarColor"..rewatch_loc["wildgrowth"]].g, rewatch_loadInt["BarColor"..rewatch_loc["wildgrowth"]].b, 0.8);
		end;
	end;
end;