TidyPlatesUtility = {}


-------------------------------------------------------------------------------------
--  General
-------------------------------------------------------------------------------------
local function copytable(original)
	local duplicate = {}
	for key, value in pairs(original) do
		if type(value) == "table" then duplicate[key] = copytable(value)
		else duplicate[key] = value end
	end
	return duplicate
end

local function mergetable(master, mate)
	local merged = {}
	local matedata
	for key, value in pairs(master) do
		if type(value) == "table" then 
			matedata = mate[key]
			if type(matedata) == "table" then merged[key] = mergetable(value, matedata) 
			else merged[key] = copytable(value) end
		else 
			matedata = mate[key]
			if matedata == nil then merged[key] = master[key] 
			else merged[key] = matedata end
		end
	end
	return merged
end

local function updatetable(original, added)
	-- Check for exist
	if not (original or added) then return original end
	if not (type(original) == 'table' and type(added) == 'table' ) then return original end
	local originalval

	for index, var in pairs(original) do
		if type(var) == "table" then original[index] = updatetable(var, added[index]) or var
		else 
			--original[index] = added[index] or original[index] 
			if added[index] ~= nil then
				original[index] = added[index] 
			else original[index] = original[index] end
		
		end
	end
	return original
end

local function valueToString(value)
    if value ~= nil then
        if value >= 1000000 then return format('%.1fm', value / 1000000)
        elseif value >= 1000 then return format('%.1fk', value / 1000)
        else return value end
    end
end

TidyPlatesUtility.abbrevNumber = valueToString
TidyPlatesUtility.copyTable = copytable
TidyPlatesUtility.mergeTable = mergetable
TidyPlatesUtility.updateTable = updatetable

-- Threat
local function GetRelativeThreat(unit)
	if not UnitExists(unit) then return end
	local _, group, size, index, unitid
	local playerthreat, leaderthreat, tempthreat, petthreat, leadername  = 0,0,0,0, nil
	-- Request Player Threat
	_, _,  playerthreat, _, _ = UnitDetailedThreatSituation("player", unit)
	-- Request Pet Threat
	if HasPetUI() then 
		_, _,  petthreat, _, _ = UnitDetailedThreatSituation("pet", unit)
		leaderthreat = petthreat or 0
		leadername = "pet" 
	end
	-- Get Group Type
	if UnitInRaid("player") then group = "raid"; size = GetNumRaidMembers() - 1
	elseif UnitInParty("player") then group = "party"; size = GetNumPartyMembers()
	else group = nil end
	-- Cycle through Group, picking highest threat holder
	if group then
		for index = 1, size do
			unitid = group..index
			_, _, tempthreat , _, _ = UnitDetailedThreatSituation(unitid, unit)
			if tempthreat and tempthreat > leaderthreat then 
				leaderthreat = tempthreat 
				leadername = unitid
				end
		end
	end
	
	if playerthreat and leaderthreat then
		--if playerthreat == 100 then return playerthreat + (100-leaderthreat), leadername
		if playerthreat == 100 then return playerthreat + (100-leaderthreat), nil
		else return playerthreat, leadername end
	else return end
end
TidyPlatesUtility.GetRelativeThreat = GetRelativeThreat

------------------------------------------------------------------
-- Panel Helpers (Used to create interface panels)
------------------------------------------------------------------

local function CreatePanelFrame(self, reference, listname, title)
	local panelframe = CreateFrame( "Frame", reference, UIParent);
	panelframe.name = listname
	panelframe.Label = panelframe:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
	panelframe.Label:SetPoint("TOPLEFT", panelframe, "TOPLEFT", 16, -16)
	panelframe.Label:SetHeight(15)
	panelframe.Label:SetWidth(350)
	panelframe.Label:SetJustifyH("LEFT")
	panelframe.Label:SetJustifyV("TOP")
	panelframe.Label:SetText(title or listname)
	return panelframe
end
-- [[
local function CreateDescriptionFrame(self, reference, parent, title, text)
	local descframe = CreateFrame( "Frame", reference, parent);
	descframe:SetHeight(15)
	descframe:SetWidth(200)

	descframe.Label = descframe:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	descframe.Label:SetAllPoints()
	descframe.Label:SetJustifyH("LEFT")
	descframe.Label:SetText(title)

	descframe.Description = descframe:CreateFontString(nil, 'ARTWORK', 'GameFontWhiteSmall')
	descframe.Description:SetPoint("TOPLEFT")
	descframe.Description:SetPoint("BOTTOMRIGHT")
	descframe.Description:SetJustifyH("LEFT")
	descframe.Description:SetJustifyV("TOP")
	descframe.Description:SetText(text)
	--
	return descframe
end
--]]
local function CreateCheckButton(self, reference, parent, label)
	local checkbutton = CreateFrame( "CheckButton", reference, parent, "InterfaceOptionsCheckButtonTemplate" )
	_G[reference.."Text"]:SetText(label)
	checkbutton.GetValue = function() if checkbutton:GetChecked() then return true else return false end end
	checkbutton.SetValue = checkbutton.SetChecked

	return checkbutton
end

local function CreateRadioButtons(self, reference, parent, numberOfButtons, defaultButton, spacing, list, label)
	local index
	local radioButtonSet = {}
	
	for index = 1, numberOfButtons do
		radioButtonSet[index] = CreateFrame( "CheckButton", reference..index, parent, "UIRadioButtonTemplate" )
		radioButtonSet[index].Label = _G[reference..index.."Text"]
		radioButtonSet[index].Label:SetText(list[index] or " ")
		radioButtonSet[index].Label:SetWidth(250)
		radioButtonSet[index].Label:SetJustifyH("LEFT")
		
		if index > 1 then 
			radioButtonSet[index]:SetPoint("TOP", radioButtonSet[index-1], "BOTTOM", 0, -(spacing or 10)) 
		end
		
		radioButtonSet[index]:SetScript("OnClick", function (self) 
			local button
			for button = 1, numberOfButtons do radioButtonSet[button]:SetChecked(false) end
			self:SetChecked(true)
		end)
	end
	
	radioButtonSet.GetChecked = function() 
		local index
		for index = 1, numberOfButtons do
			if radioButtonSet[index]:GetChecked() then return index end
		end
	end
	
	radioButtonSet.SetChecked = function(self, number) 
		local index
		for index = 1, numberOfButtons do radioButtonSet[index]:SetChecked(false) end
		radioButtonSet[number]:SetChecked(true)
	end
	
	--if label then
	--	dropdown.Label = dropdown:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	--	dropdown.Label:SetPoint("TOPLEFT", 18, 18)
	--	dropdown.Label:SetText(label)
	--end
	
	radioButtonSet[defaultButton]:SetChecked(true)
	radioButtonSet.GetValue = radioButtonSet.GetChecked
	radioButtonSet.SetValue = radioButtonSet.SetChecked
	
	return radioButtonSet
end

local function CreateSliderFrame(self, reference, parent, label, val, minval, maxval, step, mode)
	local slider = CreateFrame("Slider", reference, parent, 'OptionsSliderTemplate')
	slider:SetWidth(100)
	slider:SetHeight(15)
	--
	slider:SetMinMaxValues(minval or 0, maxval or 1)
	slider:SetValueStep(step or .1)
	slider:SetValue(val or .5)
	slider:SetOrientation("HORIZONTAL")
	slider:Enable()
	-- Labels
	slider.Label = slider:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	slider.Label:SetPoint("TOPLEFT", -5, 18)
	slider.Low = _G[reference.."Low"]
	slider.High = _G[reference.."High"]
	slider.Label:SetText(label or "")

	-- Value
	slider.Value = slider:CreateFontString(nil, 'ARTWORK', 'GameFontWhite')
	slider.Value:SetPoint("BOTTOM", 0, -10)
	slider.Value:SetWidth(50)
	--slider.Value
	if mode and mode == "ACTUAL" then
		slider.Value:SetText(tostring(ceil(val)))
		slider:SetScript("OnValueChanged", function() 
			local v = tostring(ceil(slider:GetValue()))
			slider.Value:SetText(v) 
		end)
		slider.Low:SetText(ceil(minval or 0))
		slider.High:SetText(ceil(maxval or 1))
	else
		slider.Value:SetText(tostring(ceil(100*(val or .5))))
		slider:SetScript("OnValueChanged", function() 
			slider.Value:SetText(tostring(ceil(100*slider:GetValue())).."%") 
		end)
		slider.Low:SetText(ceil((minval or 0)*100).."%")
		slider.High:SetText(ceil((maxval or 1)*100).."%")
	end

	--slider.tooltipText = "Slider"
	return slider
end
		
-- http://www.wowwiki.com/UI_Object_UIDropDownMenu
-- item.fontObject
local function CreateDropdownFrame(self, reference, parent, menu, default, label, byName)
	local dropdown = CreateFrame("Frame", reference, parent, "UIDropDownMenuTemplate" )
	local index, item
	dropdown.Text = _G[reference.."Text"]
	dropdown.Text:SetText(menu[default].text)
	dropdown.Text:SetWidth(100)
	--
	if label then
		dropdown.Label = dropdown:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
		dropdown.Label:SetPoint("TOPLEFT", 18, 18)
		dropdown.Label:SetText(label)
	end
	--
	
	dropdown.Value = default
	
	dropdown.initialize = function(self, level)		-- Injects the init function into the template
		-- if not level == 1 then return end
		for index, item in pairs(menu) do
			item.func = function(self) dropdown.Text:SetText(item.text); dropdown.Value = index  end
			UIDropDownMenu_AddButton(item, level)
			--UIDropDownMenu_AddButton(item)
		end 
	end
	
	dropdown.SetValue = function (self, value) 
		if byName then dropdown.Text:SetText(value) else 
			dropdown.Text:SetText(menu[value].text); dropdown.Value = value 
		end
	end
	
	dropdown.GetValue = function () 
		if byName then return dropdown.Text:GetText() else
			return dropdown.Value 
		end
	end
	
	--dropdown.tooltipText = "Dropdown"
	return dropdown
end

-- [[ COLOR
local CreateColorBox
do
	local ShowColorPicker
	do
		local swatchframe
		local function ChangeColor(cancel)
			local a, r, g, b
			if cancel then 
				r,g,b,a = unpack(ColorPickerFrame.previousValues )
				swatchframe:SetBackdropColor(r,g,b,a)
			else
				a, r, g, b = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB();
				swatchframe:SetBackdropColor(r,g,b,1-a)
			end
		end

		function ShowColorPicker(targetframe)
			swatchframe = targetframe
			local r,g,b,a = swatchframe:GetBackdropColor()
			ColorPickerFrame.previousValues  = {r,g,b,a}
			ColorPickerFrame:SetColorRGB(r,g,b);
			ColorPickerFrame.hasOpacity = true
			ColorPickerFrame.opacity = 1 - a
			ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = 	ChangeColor, ChangeColor, ChangeColor;
			ColorPickerFrame:Hide(); -- Need to run the OnShow handler.
			ColorPickerFrame:Show();
		end
	end
	function CreateColorBox(self, reference, parent, label, r, g, b, a)
		local colorbox = CreateFrame("Button", reference, parent)
		colorbox:SetWidth(24)
		colorbox:SetHeight(24)
		colorbox:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameColorSwatch", 
												edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
												tile = false, tileSize = 16, edgeSize = 8, 
												insets = { left = 1, right = 1, top = 1, bottom = 1 }});
		colorbox:SetBackdropColor(r, g, b, a);
		colorbox:SetScript("OnClick",function() ShowColorPicker(colorbox) end)
		--
		colorbox.Label = colorbox:CreateFontString(nil, 'ARTWORK', 'GameFontWhiteSmall')
		colorbox.Label:SetPoint("TOPLEFT", colorbox, "TOPRIGHT", 4, -7)
		colorbox.Label:SetText(label)
		
		colorbox.GetValue = function() local color = {}; color.r, color.g, color.b, color.a = colorbox:GetBackdropColor(); return color end
		colorbox.SetValue = function(self, color) colorbox:SetBackdropColor(color.r, color.g, color.b, color.a); end
		--colorbox.tooltipText = "Colorbox"
		return colorbox
	end
end

PanelHelpers = {}

PanelHelpers.CreatePanelFrame = CreatePanelFrame
PanelHelpers.CreateDescriptionFrame = CreateDescriptionFrame
PanelHelpers.CreateCheckButton = CreateCheckButton
PanelHelpers.CreateRadioButtons = CreateRadioButtons
PanelHelpers.CreateSliderFrame = CreateSliderFrame
PanelHelpers.CreateDropdownFrame = CreateDropdownFrame
PanelHelpers.CreateColorBox = CreateColorBox

TidyPlatesUtility.PanelHelpers = PanelHelpers



local function StartMovement(frame)
	-- Store Original Point to frame.OriginalAnchor
	frame:StartMoving()
	local OriginalAnchor = frame.OriginalAnchor
	
	if not OriginalAnchor.point then 
		OriginalAnchor.point, OriginalAnchor.relativeTo, OriginalAnchor.relativePoint, 
			OriginalAnchor.xOfs, OriginalAnchor.yOfs = frame:GetPoint(1)
		print("Starting Movement from, ", OriginalAnchor.xOfs,  OriginalAnchor.yOfs)
	end
		
	
	-- Store Current Screen-RelativePosition to frame.NewAnchor
end

local function FinishMovement(frame)
	-- Store New Screen-RelativePosition to frame.NewAnchor
	local NewAnchor = frame.NewAnchor
	local OriginalAnchor = frame.OriginalAnchor
	NewAnchor.point, NewAnchor.relativeTo, NewAnchor.relativePoint,
		NewAnchor.xOfs, NewAnchor.yOfs = frame:GetPoint(1)
	print(frame:GetName(), " has been moved, " , NewAnchor.xOfs - OriginalAnchor.xOfs, " , ", NewAnchor.yOfs - OriginalAnchor.yOfs)
	frame:StopMovingOrSizing()
	-- Process the 
end

local function EnableFreePositioning(frame)
	-- http://www.wowwiki.com/API_Frame_StartMoving
	-- point, relativeTo, relativePoint, xOfs, yOfs = MyRegion:GetPoint(n)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetScript("OnMouseDown", StartMovement)
	frame:SetScript("OnMouseUp", FinishMovement)
	frame.OriginalAnchor = {}
	frame.NewAnchor = {}
end

PanelHelpers.EnableFreePositioning = EnableFreePositioning




--[[

	PanelHelpers.CreateItemList
	
	- Update the item list
	- Create/Sort list of names in an array
	
	* Item
	CreateFrame			Frame
	CreateFontstring	Name
	CreateTexture		Highlight
	CreateFrame			DeleteButton
	
	* List
	CreateScrollFrame
	CreateChildFrame
	
	Items go in Child Frame
	Child frame is anchored to the first and last item
	
	* Add Item Box
	CreateFrame
	CreateFrame		EditBox
	CreateFrame		AddButton
	
	UpdateItems
	items are stored in an ItemList array, which can be cleared.
	
	









--]]






--[[
 
local frame = CreateFrame("Frame", "DragFrame2", UIParent)
frame:SetMovable(true)
frame:EnableMouse(true)
frame:SetScript("OnMouseDown", frame.StartMoving)
frame:SetScript("OnMouseUp", frame.StopMovingOrSizing)

-- The code below makes the frame visible, and is not necessary to enable dragging.
frame:SetPoint("CENTER"); frame:SetWidth(64); frame:SetHeight(64);
local tex = frame:CreateTexture("ARTWORK");
tex:SetAllPoints();
tex:SetTexture(1.0, 0.5, 0); tex:SetAlpha(0.5);

--]]



--[[
do
	local function OnClickSelect(self) 
		
	end
		
	local function AddListItem(self, itemname, itemdata)
		
		
		local item = CreateFrame("Frame", nil, self.Content)
		item.Label = = item:CreateFontString(nil, "OVERLAY")
		
		-- Create or REUSE frame
		-- create a frame
		-- create highlight region
		-- create text region
		
		-- Scale Frame
		-- Set Anchors
		-- Scale Contents Frame
		
		-- Store parent list information
		
		-- Add OnClick Handler (OnSelect)
	end
	
	local function DeleteItem(self, itemname) 
		
	end
	
	local function UpdateList(self)
		self:SetScrollChild(self.Content)
	end
	
	local function GetSelectedItem(self) end
	

	function PanelHelpers:CreateScrollList(reference, parent, label, targetTable)
		local self = CreateFrame("ScrollFrame",reference, parent)
		local self.Content = CreateFrame("Frame", reference.."_Contents", scrollListWindow)
		
		-- Setup Visible Item List
		self.Content.Items = {}
		self.Content.ItemCount = 0
		self.Content.SelectedIndex = 0 
		
		-- Setup Default Options
		-- Register Functions
		
	end

end

--]]

--[[

	UIPanelScrollFrameTemplate
	or
	UIPanelScrollFrameTemplate2

--]]



--[[
			<OnEnter>
				if ( self.tooltipText ) then
					GameTooltip:SetOwner(self, self.tooltipOwnerPoint or "ANCHOR_RIGHT");
					GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
				end
				if ( self.tooltipRequirement ) then
					GameTooltip:AddLine(self.tooltipRequirement, 1.0, 1.0, 1.0, 1.0);
					GameTooltip:Show();
				end
			</OnEnter>
			<OnLeave>
				GameTooltip:Hide();
			</OnLeave>
--]]

















