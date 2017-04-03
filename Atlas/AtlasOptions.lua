--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005-2010 Dan Gilbert <dan.b.gilbert@gmail.com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

function AtlasOptions_Toggle()
	if InterfaceOptionsFrame:IsVisible() then
		InterfaceOptionsFrame:Hide();
	else
		InterfaceOptionsFrame_OpenToCategory("Atlas");
	end
end

function AtlasOptions_AutoSelectToggle()
	if(AtlasOptions.AtlasAutoSelect) then
		AtlasOptions.AtlasAutoSelect = false;
	else
		AtlasOptions.AtlasAutoSelect = true;
	end
	AtlasOptions_Init();
end

function AtlasOptions_RightClickToggle()
	if(AtlasOptions.AtlasRightClick) then
		AtlasOptions.AtlasRightClick = false;
	else
		AtlasOptions.AtlasRightClick = true;
	end
	AtlasOptions_Init();
end

function AtlasOptions_AcronymsToggle()
	if(AtlasOptions.AtlasAcronyms) then
		AtlasOptions.AtlasAcronyms = false;
	else
		AtlasOptions.AtlasAcronyms = true;
	end
	AtlasOptions_Init();
	Atlas_Refresh();
end

function AtlasOptions_ClampedToggle()
	if(AtlasOptions.AtlasClamped) then
		AtlasOptions.AtlasClamped = false;
	else
		AtlasOptions.AtlasClamped = true;
	end
	AtlasFrame:SetClampedToScreen(AtlasOptions.AtlasClamped);
	AtlasOptions_Init();
	Atlas_Refresh();
end

function AtlasOptions_CtrlToggle()
	if(AtlasOptions.AtlasCtrl) then
		AtlasOptions.AtlasCtrl = false;
	else
		AtlasOptions.AtlasCtrl = true;
	end
	AtlasOptions_Init();
	Atlas_Refresh();
end

local function Reset_Dropdowns()
	AtlasOptions.AtlasZone = 1;
	AtlasOptions.AtlasType = 1;
	Atlas_PopulateDropdowns();
	Atlas_Refresh();
	AtlasFrameDropDownType_OnShow();
	AtlasFrameDropDown_OnShow();
end

function AtlasOptions_Reset()
	Atlas_FreshOptions();
	AtlasOptions_ResetPosition(); --also calls AtlasOptions_Init()
	Reset_Dropdowns(); --also calls Atlas_Refresh()
	AtlasButton_Init();
	Atlas_UpdateLock();
end

function AtlasOptions_OnLoad(panel)
	panel.name = "Atlas";
	panel.default = AtlasOptions_Reset;
	InterfaceOptions_AddCategory(panel);
end

function AtlasOptions_Init()
	AtlasOptionsFrameToggleButton:SetChecked(AtlasOptions.AtlasButtonShown);
	AtlasOptionsFrameAutoSelect:SetChecked(AtlasOptions.AtlasAutoSelect);
	AtlasOptionsFrameRightClick:SetChecked(AtlasOptions.AtlasRightClick);
	AtlasOptionsFrameAcronyms:SetChecked(AtlasOptions.AtlasAcronyms);
	AtlasOptionsFrameClamped:SetChecked(AtlasOptions.AtlasClamped);
	AtlasOptionsFrameCtrl:SetChecked(AtlasOptions.AtlasCtrl);
	AtlasOptionsFrameSliderButtonPos:SetValue(AtlasOptions.AtlasButtonPosition);
	AtlasOptionsFrameSliderButtonRad:SetValue(AtlasOptions.AtlasButtonRadius);
	AtlasOptionsFrameSliderAlpha:SetValue(AtlasOptions.AtlasAlpha);
	AtlasOptionsFrameSliderScale:SetValue(AtlasOptions.AtlasScale);
	AtlasOptionsFrameDropDownCats_OnShow();
end

function AtlasOptions_ResetPosition()
	AtlasFrame:ClearAllPoints();
	AtlasFrame:SetPoint("TOPLEFT", 0, -104);
	AtlasOptions.AtlasButtonPosition = 356;
	AtlasOptions.AtlasButtonRadius = 78;
	AtlasOptions.AtlasAlpha = 1.0;
	AtlasOptions.AtlasScale = 1.0;
	AtlasOptions_Init();
end

function AtlasOptions_SetupSlider(text, mymin, mymax, step)
	this:SetMinMaxValues(mymin, mymax);
	getglobal(this:GetName().."Low"):SetText(mymin);
	getglobal(this:GetName().."High"):SetText(mymax);
	this:SetValueStep(step);
end

local function round(num, idp)
   local mult = 10 ^ (idp or 0);
   return math.floor(num * mult + 0.5) / mult;
end

function AtlasOptions_UpdateSlider(text)
	getglobal(this:GetName().."Text"):SetText("|cffffd200"..text.." ("..round(this:GetValue(),2)..")");
end


function AtlasOptionsFrameDropDownCats_Initialize()

	local i;
	for i = 1, getn(Atlas_DropDownLayouts_Order), 1 do
		info = {
			text = Atlas_DropDownLayouts_Order[i];
			func = AtlasOptionsFrameDropDownCats_OnClick;
		};
		UIDropDownMenu_AddButton(info);
		i = i + 1;
	end
	
end


function AtlasOptionsFrameDropDownCats_OnShow()
	UIDropDownMenu_Initialize(AtlasOptionsFrameDropDownCats, AtlasOptionsFrameDropDownCats_Initialize);
	UIDropDownMenu_SetSelectedID(AtlasOptionsFrameDropDownCats, AtlasOptions.AtlasSortBy);
	UIDropDownMenu_SetWidth(AtlasOptionsFrameDropDownCats, 100);
end

function AtlasOptionsFrameDropDownCats_OnClick()
	local thisID = this:GetID();
	UIDropDownMenu_SetSelectedID(AtlasOptionsFrameDropDownCats, thisID);
	AtlasOptions.AtlasSortBy = thisID;
	Reset_Dropdowns();
end

