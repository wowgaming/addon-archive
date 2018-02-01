local ClassIcon = {
        DRUID = "Interface/Icons/INV_Misc_MonsterClaw_04",
        WARLOCK = "Interface/Icons/Spell_Nature_FaerieFire",
        HUNTER = "Interface/Icons/INV_Weapon_Bow_07",
        MAGE = "Interface/Icons/INV_Staff_13",
        PRIEST = "Interface/Icons/INV_Staff_30",
        WARRIOR = "Interface/Icons/INV_Sword_27",
        SHAMAN = "Interface/Icons/Spell_Nature_BloodLust",
        PALADIN = "Interface/Icons/Ability_ThunderBolt",
        ROGUE = "Interface/AddOns/ChatIcons/images/UI-CharacterCreate-Classes_Rogue",
		DEATHKNIGHT = "Interface/Icons/Spell_Deathknight_ClassIcon"
}

local function CreateDropDownMenu(name,parent,x,y)

  local f = CreateFrame("Frame", name, parent, "UIDropDownMenuTemplate") 
  f:SetPoint("TOPLEFT", parent, "TOPLEFT",x,y)
  UIDropDownMenu_SetWidth(f, 180)  

  
  f.Text = f:CreateFontString(nil, "OVERLAY","GameFontNormal")
  f.Text:SetPoint("TOPLEFT",f,"TOPLEFT",-50,-5)
  
  return f

end

local function DropDownMenuItem_OnClick(dropdownbutton)
	UIDropDownMenu_SetSelectedValue(dropdownbutton.owner, dropdownbutton.value) 

	local Profile = Healium_GetProfile()
	
	for i=1, Healium_MaxClassSpells, 1 do
		if (dropdownbutton.owner == HealiumDropDown[i]) then
			for j=0, Healium_MaxClassSpells - 1, 1 do
				if (dropdownbutton.value == j) then
					Profile.SpellNames[i] = Healium_Spell.Name[j+1]
					Profile.SpellIcons[i] = Healium_Spell.Icon[j+1]
				end
			end
		end
	end
	
	Healium_UpdateButtonIcons()
	Healium_UpdateButtonSpells()	
end

-- Function called when the menu is opened, responsible for adding menu buttons
local function DropDownMenu_Init(self,level)

	level = level or 1  
	local info = UIDropDownMenu_CreateInfo() 
	
	local DropDown = self
	UIDropDownMenu_SetSelectedValue(DropDown , nil)
	local spell = UIDropDownMenu_GetText(DropDown)
	
	for k, v in ipairs (Healium_Spell.Name) do
		info.text = Healium_Spell.Name[k] 
		info.value = k-1
		info.func = DropDownMenuItem_OnClick
		info.owner = DropDown
		info.checked = nil 
		info.icon = Healium_Spell.Icon[k]
		if (info.icon) then
			UIDropDownMenu_AddButton(info, level) 
			if Healium_Spell.Name[k] == spell then
				UIDropDownMenu_SetSelectedValue(DropDown , k-1)	
			end
		end
	end
  
end

local function SoundDropDownMenuItem_OnClick(dropdownbutton)
	UIDropDownMenu_SetSelectedValue(dropdownbutton.owner, dropdownbutton.value) 
	Healium.DebufAudioFile = dropdownbutton.value
	Healium_InitDebuffSound()
	Healium_PlayDebuffSound()
end

local function SoundDropDownMenu_Init(self, level)
	level = level or 1  
	local info = UIDropDownMenu_CreateInfo() 
	
	UIDropDownMenu_SetSelectedValue(self , nil)
	local sound = UIDropDownMenu_GetText(self)
	
	for k, v in ipairs (Healium_Sounds) do
		local this_sound = next(v, nill)
		info.text = this_sound
		info.value = this_sound
		info.func = SoundDropDownMenuItem_OnClick
		info.owner = self
		info.checked = nil 
		UIDropDownMenu_AddButton(info, level) 
		if this_sound == sound then
			UIDropDownMenu_SetSelectedValue(self, this_sound)	
		end
	end
end


local function UpdateRangeCheckSliderText(self)
    self.Text:SetText("Range Check Frequency: |cFFFFFFFF".. format("%.1f",self:GetValue()) .. " Hz")
end

function Healium_SetButtonCount(count)
  HealiumMaxButtonSlider.Text:SetText("Show |cFFFFFFFF"..count.. "|r Buttons")
  Healium_GetProfile().ButtonCount = count
  Healium_UpdateButtonVisibility()
end

local function MaxButtonSlider_Update(self)
	Healium_SetButtonCount(self:GetValue())
end

local function TooltipsCheck_OnClick(self)
	Healium.ShowToolTips = self:GetChecked() or false
end

local function PercentageCheck_OnClick(self)
	Healium.ShowPercentage = self:GetChecked() or false
	Healium_UpdatePercentageVisibility()
end

local function ClassColorCheck_OnClick(self)
	Healium.UseClassColors = self:GetChecked() or false
	Healium_UpdateClassColors()
end

local function ShowBuffsCheck_OnClick(self)
	Healium.ShowBuffs = self:GetChecked() or false
	Healium_UpdateShowBuffs()
end

local function RangeCheckCheck_OnClick(self)
	Healium.DoRangeChecks = self:GetChecked() or false
end

local function EnableCooldownsCheck_OnClick(self)
	Healium.EnableCooldowns = self:GetChecked() or false
end

local function HideCloseButtonCheck_OnClick(self)
	Healium.HideCloseButton = self:GetChecked() or false
	Healium_UpdateCloseButtons()
end

local function HideCaptionsCheck_OnClick(self)
	Healium.HideCaptions = self:GetChecked() or false
	Healium_UpdateHideCaptions()
end

local function LockFramePositionsCheck_OnClick(self)
	Healium.LockFrames = self:GetChecked() or false
end

local function EnableCliqueCheck_OnClick(self)
	Healium.EnableClique = self:GetChecked() or false
	Healium_UpdateEnableClique()
end

local function ShowManaCheck_OnClick(self)
	Healium.ShowMana = self:GetChecked() or false
	Healium_UpdateShowMana()
end

local function UpdateEnableDebuffsControls(self)
	local color 
	if self:GetChecked() then
		color = NORMAL_FONT_COLOR
	else
		color = GRAY_FONT_COLOR
	end
	
	for _,j in ipairs(self.children) do
		j:SetTextColor(color.r, color.g, color.b)
	end

end

local function EnableDebuffsCheck_OnClick(self)
	UpdateEnableDebuffsControls(self)
	Healium.EnableDebufs = self:GetChecked() or false
	Healium_UpdateEnableDebuffs()
end

local function EnableDebuffAudioCheck_OnClick(self)
	Healium.EnableDebufAudio = self:GetChecked() or false
end

local function EnableDebuffHealthbarHighlightingCheck_OnClick(self)
	Healium.EnableDebufHealthbarHighlighting = self:GetChecked() or false
	Healium_UpdateEnableDebuffs()
end

local function EnableDebuffButtonHighlightingCheck_OnClick(self)
	Healium.EnableDebufButtonHighlighting = self:GetChecked() or false
	Healium_UpdateEnableDebuffs()
end

local function EnableDebuffHealthbarColoringCheck_OnClick(self)
	Healium.EnableDebufHealthbarColoring = self:GetChecked() or false
	Healium_UpdateEnableDebuffs()
end

local function ScaleSlider_OnValueChanged(self)
	Healium.Scale = self:GetValue()
	Healium_SetScale()
	self.Text:SetText("Scale: |cFFFFFFFF".. format("%.1f",Healium.Scale))
end

local function RangeCheckSlider_OnValueChanged(self)
	Healium.RangeCheckPeriod = 1.0 / self:GetValue()
	UpdateRangeCheckSliderText(self)
end

function Healium_ShowConfigPanel()
    if (InterfaceOptionsFrame:IsVisible()) then
      InterfaceOptionsFrame:Hide()
     else
	  InterfaceOptionsFrame_OpenToCategory(Healium_AddonName)
    end
end

-- Used to update the config panel controls when the profile changes
function Healium_Update_ConfigPanel()
	local Profile = Healium_GetProfile()
	
	HealiumMaxButtonSlider:SetValue(Healium_GetProfile().ButtonCount)
	
	for i=1, Healium_MaxButtons, 1 do    
	  UIDropDownMenu_SetText(HealiumDropDown[i], Profile.SpellNames[i])
	end
end

function Healium_CreateConfigPanel(Class, Version)
--	Healium_DebugPrint("Begin Healium_CreateAddonOptionFrame()")
	local Profile = Healium_GetProfile()
	
	local panel = CreateFrame("Frame", nil, UIParent)
	panel.name = Healium_AddonName
	panel.okay = function (self)self.originalValue = MY_VARIABLE end    -- [[ When the player clicks okay, set the original value to the current setting ]] --
	panel.cancel = function (self) MY_VARIABLE = self.originalValue end    -- [[ When the player clicks cancel, set the current setting to the original value ]] --
	InterfaceOptions_AddCategory(panel)

	local scrollframe = CreateFrame("ScrollFrame", "HealiumPanelScrollFrame", panel, "UIPanelScrollFrameTemplate") 
	local framewidth = InterfaceOptionsFramePanelContainer:GetWidth()
	local frameheight = InterfaceOptionsFramePanelContainer:GetHeight() 
	scrollframe:SetPoint("TOPLEFT", panel, "TOPLEFT", 10, -25)
	scrollframe:SetWidth(framewidth-45)
	scrollframe:SetHeight(frameheight-45)
	scrollframe:Show()
	
    scrollframe.scrollbar = _G["HealiumPanelScrollFrameScrollBar"]   
    scrollframe.scrollbar:SetBackdrop({   
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",   
        edgeSize = 8,   
        tileSize = 32,   
        insets = { left = 0, right =0, top =5, bottom = 5 }})   
	
	
	local scrollchild = CreateFrame("Frame", "$parentScrollChild", scrollframe)
	scrollframe:SetScrollChild(scrollchild)	

	-- The Height and Width here are important.  The Width will control placement of the class icon since it attaches to TOPRIGHT of scrollchild.
	scrollchild:SetHeight(frameheight - 45)	
	scrollchild:SetWidth(framewidth - 45)
	scrollchild:Show()
	
	-- Title text
	local TitleText = scrollchild:CreateFontString(nil, "OVERLAY","GameFontNormalLarge")
	TitleText:SetJustifyH("LEFT")
	TitleText:SetPoint("TOPLEFT", 10, -10)
	TitleText:SetText(Healium_AddonColoredName .. Version)
	-- Title subtext
	local TitleSubText = scrollchild:CreateFontString(nil, "OVERLAY","GameFontNormalSmall")
	TitleSubText:SetJustifyH("LEFT")
	TitleSubText:SetPoint("TOPLEFT", 10, -30)
	TitleSubText:SetText("Welcome to the " .. Healium_AddonColoredName .. "  options screen.|nUse the scrollbar to access more options.")
	TitleSubText:SetTextColor(1,1,1,1) 
  
	-- Create the Class Icon 
  	local HealiumClassIcon = CreateFrame("Frame", "HealiumClassIcon" ,scrollchild)
	HealiumClassIcon:SetPoint("TOPRIGHT",-20,0)
	HealiumClassIconTexture = HealiumClassIcon:CreateTexture(nil, "BACKGROUND")
	HealiumClassIconTexture:SetAllPoints()
	HealiumClassIconTexture:SetTexture(ClassIcon[Class])
	HealiumClassIcon:SetHeight(60)
	HealiumClassIcon:SetWidth(60)
	HealiumClassIcon.Text = HealiumClassIcon:CreateFontString(nil, "OVERLAY","GameFontNormalLarge")
	HealiumClassIcon.Text:SetText(strupper(Class))
	HealiumClassIcon.Text:SetPoint("CENTER",0,-38)
	HealiumClassIcon.Text:SetTextColor(1,1,0.2,1)

 	
	-- ToolTips Check Button
    local TooltipsCheck = CreateFrame("CheckButton","$parentShowTooltipCheckButton",scrollchild,"OptionsCheckButtonTemplate")
	TooltipsCheck:SetPoint("TOPLEFT",5,-70)	
    
    TooltipsCheck.Text = TooltipsCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
	TooltipsCheck.Text:SetPoint("LEFT", TooltipsCheck, "RIGHT", 0)
    TooltipsCheck.Text:SetText("Show Button ToolTips")
	
    TooltipsCheck:SetScript("OnClick", TooltipsCheck_OnClick)
	TooltipsCheck.tooltipText = "Shows spell tooltips when hovering the mouse over the " .. Healium_AddonColoredName .. " buttons."

	-- ShowMana Check Button
    local ShowManaCheck = CreateFrame("CheckButton","$parentShowManaButton",scrollchild,"OptionsCheckButtonTemplate")
    ShowManaCheck:SetPoint("TOPLEFT", TooltipsCheck, "BOTTOMLEFT", 0, 0)
    
    ShowManaCheck.Text = ShowManaCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
	ShowManaCheck.Text:SetPoint("LEFT", ShowManaCheck, "RIGHT", 0)
    ShowManaCheck.Text:SetText("Show Mana")
	
	ShowManaCheck:SetScript("OnClick", ShowManaCheck_OnClick)
	ShowManaCheck.tooltipText = "Shows the unit's mana."

	
	-- Percentage Check button
    local PercentageCheck = CreateFrame("CheckButton","$parentShowTooltipCheckButton",scrollchild,"OptionsCheckButtonTemplate")
    PercentageCheck:SetPoint("TOPLEFT", ShowManaCheck, "BOTTOMLEFT", 0, 0)
    
    PercentageCheck.Text = PercentageCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
	PercentageCheck.Text:SetPoint("LEFT", PercentageCheck, "RIGHT", 0)
    PercentageCheck.Text:SetText("Show Health Percentage")
	
	PercentageCheck:SetScript("OnClick", PercentageCheck_OnClick)
	PercentageCheck.tooltipText = "Shows the unit's health as a percentage on the right side of the health bar."
	
	-- ClassColor Check button
    local ClassColorCheck = CreateFrame("CheckButton","$parentClassColorCheckButton",scrollchild,"OptionsCheckButtonTemplate")
    ClassColorCheck:SetPoint("TOPLEFT", PercentageCheck, "BOTTOMLEFT", 0, 0)
    
    ClassColorCheck.Text = ClassColorCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
	ClassColorCheck.Text:SetPoint("LEFT", ClassColorCheck, "RIGHT", 0)
    ClassColorCheck.Text:SetText("Use Class Colors")
	
    ClassColorCheck:SetScript("OnClick", ClassColorCheck_OnClick)
	ClassColorCheck.tooltipText = "Colors the healthbar based on the unit's class instead of green/yellow/red based on it's current health."
	
	-- Hide Close Check button
    local HideCloseButtonCheck = CreateFrame("CheckButton","$parentHideCloseCheckButton",scrollchild,"OptionsCheckButtonTemplate")
    HideCloseButtonCheck:SetPoint("TOPLEFT", ClassColorCheck, "BOTTOMLEFT", 0, 0)
    
    HideCloseButtonCheck.Text = HideCloseButtonCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
	HideCloseButtonCheck.Text:SetPoint("LEFT", HideCloseButtonCheck, "RIGHT", 0)
    HideCloseButtonCheck.Text:SetText("Hide Close Buttons")

	HideCloseButtonCheck:SetScript("OnClick", HideCloseButtonCheck_OnClick)	
	HideCloseButtonCheck.tooltipText = "Hides the X (close) button on the upper-right of the " .. Healium_AddonColoredName ..	" caption bar."

	-- Hide Captions Check button
    local HideCaptionsCheck = CreateFrame("CheckButton","$parentHideCaptionsCheckButton",scrollchild,"OptionsCheckButtonTemplate")
    HideCaptionsCheck:SetPoint("TOPLEFT", HideCloseButtonCheck, "BOTTOMLEFT", 0, 0)
    
    HideCaptionsCheck.Text = HideCaptionsCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
	HideCaptionsCheck.Text:SetPoint("LEFT", HideCaptionsCheck, "RIGHT", 0)
    HideCaptionsCheck.Text:SetText("Hide Captions")

	HideCaptionsCheck:SetScript("OnClick", HideCaptionsCheck_OnClick)	
	HideCaptionsCheck.tooltipText = "Automatically hides the caption bar of "  .. Healium_AddonColoredName .. " frames when the mouse leaves the caption."
	
	-- Lock Frame Positions Check button
    local LockFramePositionsCheck = CreateFrame("CheckButton","$parentLockFramePositionsCheckButton",scrollchild,"OptionsCheckButtonTemplate")
    LockFramePositionsCheck:SetPoint("TOPLEFT", HideCaptionsCheck, "BOTTOMLEFT", 0, 0)
    
    LockFramePositionsCheck.Text = LockFramePositionsCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
	LockFramePositionsCheck.Text:SetPoint("LEFT", LockFramePositionsCheck, "RIGHT", 0)
    LockFramePositionsCheck.Text:SetText("Lock Frame Positions")

	LockFramePositionsCheck:SetScript("OnClick", LockFramePositionsCheck_OnClick)	
	LockFramePositionsCheck.tooltipText = "Prevents dragging of any " .. Healium_AddonColoredName .. " frames."	
	

	-- Enable Clique check button
    local EnableCliqueCheck = CreateFrame("CheckButton","$parentEnableCliqueCheckButton",scrollchild,"OptionsCheckButtonTemplate")
    EnableCliqueCheck:SetPoint("TOPLEFT", LockFramePositionsCheck, "BOTTOMLEFT", 0, 0)
    
    EnableCliqueCheck.Text = EnableCliqueCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
	EnableCliqueCheck.Text:SetPoint("LEFT", EnableCliqueCheck, "RIGHT", 0)
    EnableCliqueCheck.Text:SetText("Enable Clique Support")

	EnableCliqueCheck:SetScript("OnClick", EnableCliqueCheck_OnClick)	
	EnableCliqueCheck.tooltipText = "Allows use of the Clique addon on the healthbar.  Clique will override the ability to LeftClick to target the unit unless you configure Clique to do that, which it can."	
	
	
 	-- Dropdown menus
	local ButtonConfigTitleText = scrollchild:CreateFontString(nil, "OVERLAY","GameFontNormalLarge")
	ButtonConfigTitleText:SetJustifyH("LEFT")
	ButtonConfigTitleText:SetPoint("TOPLEFT", EnableCliqueCheck, "BOTTOMLEFT", 0, -20)
	ButtonConfigTitleText:SetText("Button Configuration")	
	
	local ButtonConfigTitleSubText = scrollchild:CreateFontString(nil, "OVERLAY","GameFontNormalSmall")
	ButtonConfigTitleSubText:SetJustifyH("LEFT")
	ButtonConfigTitleSubText:SetPoint("TOPLEFT", ButtonConfigTitleText, "BOTTOMLEFT", 0, 0)
	ButtonConfigTitleSubText:SetText("Click the dropdowns to configure each button.|nYou may now drag and drop directly from the spellbook|nonto buttons to configure them, including buffs!")
	ButtonConfigTitleSubText:SetTextColor(1,1,1,1) 	
	
	local y = -350
	local y_inc = 20
	
	for i=1, Healium_MaxButtons, 1 do
		HealiumDropDown[i] = CreateDropDownMenu("HealiumDropDown[" .. i .. "]",scrollchild,60,y)
		y = y - y_inc
		HealiumDropDown[i].Text:SetText("Button " .. i)
--		HealiumDropDown[i].tooltipText = Healium_AddonColoredName .. " button"
	end


	-- Slider for controling how many buttons to show
    HealiumMaxButtonSlider = CreateFrame("Slider","$parentMaxButtonSlider",scrollchild,"OptionsSliderTemplate")
    HealiumMaxButtonSlider:SetWidth(128)
    HealiumMaxButtonSlider:SetHeight(16)
          
    HealiumMaxButtonSlider:SetPoint("TOPLEFT", 220, -110)
      
    HealiumMaxButtonSlider:SetMinMaxValues(0,Healium_MaxButtons)
    HealiumMaxButtonSlider:SetValueStep(1)
    HealiumMaxButtonSlider:SetValue(Healium_GetProfile().ButtonCount)
	HealiumMaxButtonSlider.tooltipText = "How many " .. Healium_AddonColoredName .. " buttons to show."
      
    HealiumMaxButtonSlider.Text = HealiumMaxButtonSlider:CreateFontString(nil, "BACKGROUND","GameFontNormalLarge")
    HealiumMaxButtonSlider.Text:SetPoint("CENTER", 0, 17)
    HealiumMaxButtonSlider.Text:SetText("Show |cFFFFFFFF"..HealiumMaxButtonSlider:GetValue().. "|r Buttons")
      
    _G[HealiumMaxButtonSlider:GetName().."Low"]:SetText("0")
    _G[HealiumMaxButtonSlider:GetName().."High"]:SetText(Healium_MaxButtons)
      
    HealiumMaxButtonSlider:SetScript("OnValueChanged",MaxButtonSlider_Update)
    HealiumMaxButtonSlider:Show()
  
    -- Slider for Scaling
    local ScaleSlider = CreateFrame("Slider","HealiumScaleSlider",scrollchild,"OptionsSliderTemplate")
    ScaleSlider:SetWidth(100)
    ScaleSlider:SetHeight(16)
    
    _G[ScaleSlider:GetName().."Low"]:SetText("Small")
    _G[ScaleSlider:GetName().."High"]:SetText("Large")
    
    ScaleSlider:SetMinMaxValues(0.6,1.5)
    ScaleSlider:SetValueStep(0.1)
    ScaleSlider:SetValue(Healium.Scale)
    
    ScaleSlider:SetPoint("TOPLEFT", HealiumMaxButtonSlider, "BOTTOMLEFT", 0, -30)
    
    ScaleSlider.Text = ScaleSlider:CreateFontString(nil, "BACKGROUND","GameFontNormalLarge")
    ScaleSlider.Text:SetPoint("CENTER", -5, 17)
    ScaleSlider.Text:SetText("Scale: |cFFFFFFFF".. format("%.1f",ScaleSlider:GetValue()))
 
    ScaleSlider:SetScript("OnValueChanged", ScaleSlider_OnValueChanged)
	ScaleSlider.tooltipText = "Sets the scale of all " .. Healium_AddonColoredName .. " frames."

	-- Show Frames Settings
	local ShowFramesTitleText = scrollchild:CreateFontString(nil, "OVERLAY","GameFontNormalLarge")
	ShowFramesTitleText:SetJustifyH("LEFT")
	ShowFramesTitleText:SetPoint("TOPLEFT", HealiumDropDown[Healium_MaxButtons].Text, "BOTTOMLEFT", 0, -30)
	ShowFramesTitleText:SetText("Show Frames")	
	
	local ShowFramesTitleSubText = scrollchild:CreateFontString(nil, "OVERLAY","GameFontNormalSmall")
	ShowFramesTitleSubText:SetJustifyH("LEFT")
	ShowFramesTitleSubText:SetPoint("TOPLEFT", ShowFramesTitleText, "BOTTOMLEFT", 0, 0)
	ShowFramesTitleSubText:SetText("Check each frame to show.")
	ShowFramesTitleSubText:SetTextColor(1,1,1,1) 
	
	-- Show Party Check
    Healium_ShowPartyCheck = CreateFrame("CheckButton","$parentShowPartyCheckButton",scrollchild,"OptionsCheckButtonTemplate")
    Healium_ShowPartyCheck:SetPoint("TOPLEFT",ShowFramesTitleSubText, "BOTTOMLEFT", 0, -10)
	Healium_ShowPartyCheck.tooltipText = "Shows the Party " .. Healium_AddonColoredName .. " frame."
    Healium_ShowPartyCheck.Text = Healium_ShowPartyCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
    Healium_ShowPartyCheck.Text:SetPoint("LEFT", Healium_ShowPartyCheck, "RIGHT", 0)
    Healium_ShowPartyCheck.Text:SetText("Party")
    
    Healium_ShowPartyCheck:SetScript("OnClick",function()
        Healium.ShowPartyFrame = Healium_ShowPartyCheck:GetChecked() or false
		Healium_ShowHidePartyFrame()
    end)

	-- Show Pets Check
    Healium_ShowPetsCheck = CreateFrame("CheckButton","$parentShowPetsCheckButton",scrollchild,"OptionsCheckButtonTemplate")
    Healium_ShowPetsCheck:SetPoint("TOPLEFT",Healium_ShowPartyCheck, "BOTTOMLEFT", 0, 0)
	Healium_ShowPetsCheck.tooltipText = "Shows the Pets " .. Healium_AddonColoredName .. " frame."	
    Healium_ShowPetsCheck.Text = Healium_ShowPetsCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
    Healium_ShowPetsCheck.Text:SetPoint("LEFT", Healium_ShowPetsCheck, "RIGHT", 0)
    Healium_ShowPetsCheck.Text:SetText("Pets")
    
    Healium_ShowPetsCheck:SetScript("OnClick",function()
        Healium.ShowPetsFrame = Healium_ShowPetsCheck:GetChecked() or false
		Healium_ShowHidePetsFrame()
    end)

	-- Show Me Check
    Healium_ShowMeCheck = CreateFrame("CheckButton","$parentShowMeCheckButton",scrollchild,"OptionsCheckButtonTemplate")
    Healium_ShowMeCheck:SetPoint("TOPLEFT",Healium_ShowPetsCheck, "BOTTOMLEFT", 0, 0)
	Healium_ShowMeCheck.tooltipText = "Shows the Me " .. Healium_AddonColoredName .. " frame."		
    Healium_ShowMeCheck.Text = Healium_ShowMeCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
    Healium_ShowMeCheck.Text:SetPoint("LEFT", Healium_ShowMeCheck, "RIGHT", 0)
    Healium_ShowMeCheck.Text:SetText("Me")
    
    Healium_ShowMeCheck:SetScript("OnClick",function()
        Healium.ShowMeFrame = Healium_ShowMeCheck:GetChecked() or false
		Healium_ShowHideMeFrame()
    end)
	
	-- Show Friends Check
    Healium_ShowFriendsCheck = CreateFrame("CheckButton","$parentShowFriendsCheckButton",scrollchild,"OptionsCheckButtonTemplate")
    Healium_ShowFriendsCheck:SetPoint("TOPLEFT",Healium_ShowMeCheck, "BOTTOMLEFT", 0, 0)
	Healium_ShowFriendsCheck.tooltipText = "Shows the Friends " .. Healium_AddonColoredName .. " frame."		
    Healium_ShowFriendsCheck.Text = Healium_ShowFriendsCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
    Healium_ShowFriendsCheck.Text:SetPoint("LEFT", Healium_ShowFriendsCheck, "RIGHT", 0)
    Healium_ShowFriendsCheck.Text:SetText("Friends")
    
    Healium_ShowFriendsCheck:SetScript("OnClick",function()
        Healium.ShowFriendsFrame = Healium_ShowFriendsCheck:GetChecked() or false
		Healium_ShowHideFriendsFrame()
    end)	
	
	-- Show Group 1 Check
    Healium_ShowGroup1Check = CreateFrame("CheckButton","$parentShowGroup1CheckButton",scrollchild,"OptionsCheckButtonTemplate")
    Healium_ShowGroup1Check:SetPoint("TOPLEFT",Healium_ShowFriendsCheck, "BOTTOMLEFT", 0, 0)
	Healium_ShowGroup1Check.tooltipText = "Shows the Group 1 " .. Healium_AddonColoredName .. " frame."		
    Healium_ShowGroup1Check.Text = Healium_ShowGroup1Check:CreateFontString(nil, "BACKGROUND","GameFontNormal")
    Healium_ShowGroup1Check.Text:SetPoint("LEFT", Healium_ShowGroup1Check, "RIGHT", 0)
    Healium_ShowGroup1Check.Text:SetText("Group 1")
    
    Healium_ShowGroup1Check:SetScript("OnClick",function()
        Healium.ShowGroupFrames[1] = Healium_ShowGroup1Check:GetChecked() or false
		Healium_ShowHideGroupFrame(1)		
    end)	
	
	-- Show Group 2 Check
    Healium_ShowGroup2Check = CreateFrame("CheckButton","$parentShowGroup2CheckButton",scrollchild,"OptionsCheckButtonTemplate")
    Healium_ShowGroup2Check:SetPoint("TOPLEFT",Healium_ShowGroup1Check, "BOTTOMLEFT", 0, 0)
	Healium_ShowGroup2Check.tooltipText = "Shows the Group 2 " .. Healium_AddonColoredName .. " frame."			
    Healium_ShowGroup2Check.Text = Healium_ShowGroup2Check:CreateFontString(nil, "BACKGROUND","GameFontNormal")
    Healium_ShowGroup2Check.Text:SetPoint("LEFT", Healium_ShowGroup2Check, "RIGHT", 0)
    Healium_ShowGroup2Check.Text:SetText("Group 2")
    
    Healium_ShowGroup2Check:SetScript("OnClick",function()
        Healium.ShowGroupFrames[2] = Healium_ShowGroup2Check:GetChecked() or false
		Healium_ShowHideGroupFrame(2)
    end)		
	
	-- Show Group 3 Check
    Healium_ShowGroup3Check = CreateFrame("CheckButton","$parentShowGroup3CheckButton",scrollchild,"OptionsCheckButtonTemplate")
    Healium_ShowGroup3Check:SetPoint("TOPLEFT",Healium_ShowGroup2Check, "BOTTOMLEFT", 0, 0)
	Healium_ShowGroup3Check.tooltipText = "Shows the Group 3 " .. Healium_AddonColoredName .. " frame."			
    Healium_ShowGroup3Check.Text = Healium_ShowGroup3Check:CreateFontString(nil, "BACKGROUND","GameFontNormal")
    Healium_ShowGroup3Check.Text:SetPoint("LEFT", Healium_ShowGroup3Check, "RIGHT", 0)
    Healium_ShowGroup3Check.Text:SetText("Group 3")
    
    Healium_ShowGroup3Check:SetScript("OnClick",function()
        Healium.ShowGroupFrames[3] = Healium_ShowGroup3Check:GetChecked() or false
		Healium_ShowHideGroupFrame(3)		
    end)		

	-- Show Group 4 Check
    Healium_ShowGroup4Check = CreateFrame("CheckButton","$parentShowGroup4CheckButton",scrollchild,"OptionsCheckButtonTemplate")
    Healium_ShowGroup4Check:SetPoint("TOPLEFT",Healium_ShowGroup3Check, "BOTTOMLEFT", 0, 0)
	Healium_ShowGroup4Check.tooltipText = "Shows the Group 4 " .. Healium_AddonColoredName .. " frame."			
    Healium_ShowGroup4Check.Text = Healium_ShowGroup4Check:CreateFontString(nil, "BACKGROUND","GameFontNormal")
    Healium_ShowGroup4Check.Text:SetPoint("LEFT", Healium_ShowGroup4Check, "RIGHT", 0)
    Healium_ShowGroup4Check.Text:SetText("Group 4")
    
    Healium_ShowGroup4Check:SetScript("OnClick",function()
        Healium.ShowGroupFrames[4]= Healium_ShowGroup4Check:GetChecked() or false
		Healium_ShowHideGroupFrame(4)		
    end)			
	
	-- Show Group 5 Check
    Healium_ShowGroup5Check = CreateFrame("CheckButton","$parentShowGroup5CheckButton",scrollchild,"OptionsCheckButtonTemplate")
    Healium_ShowGroup5Check:SetPoint("TOPLEFT",Healium_ShowGroup4Check, "BOTTOMLEFT", 0, 0)
	Healium_ShowGroup5Check.tooltipText = "Shows the Group 5 " .. Healium_AddonColoredName .. " frame."			
    Healium_ShowGroup5Check.Text = Healium_ShowGroup5Check:CreateFontString(nil, "BACKGROUND","GameFontNormal")
    Healium_ShowGroup5Check.Text:SetPoint("LEFT", Healium_ShowGroup5Check, "RIGHT", 0)
    Healium_ShowGroup5Check.Text:SetText("Group 5")
    
    Healium_ShowGroup5Check:SetScript("OnClick",function()
        Healium.ShowGroupFrames[5] = Healium_ShowGroup5Check:GetChecked() or false
		Healium_ShowHideGroupFrame(5)
    end)		

	-- Show Group 6 Check
    Healium_ShowGroup6Check = CreateFrame("CheckButton","$parentShowGroup6CheckButton",scrollchild,"OptionsCheckButtonTemplate")
    Healium_ShowGroup6Check:SetPoint("TOPLEFT",Healium_ShowGroup5Check, "BOTTOMLEFT", 0, 0)
	Healium_ShowGroup6Check.tooltipText = "Shows the Group 6 " .. Healium_AddonColoredName .. " frame."			
    Healium_ShowGroup6Check.Text = Healium_ShowGroup6Check:CreateFontString(nil, "BACKGROUND","GameFontNormal")
    Healium_ShowGroup6Check.Text:SetPoint("LEFT", Healium_ShowGroup6Check, "RIGHT", 0)
    Healium_ShowGroup6Check.Text:SetText("Group 6")
    
    Healium_ShowGroup6Check:SetScript("OnClick",function()
        Healium.ShowGroupFrames[6] = Healium_ShowGroup6Check:GetChecked() or false
		Healium_ShowHideGroupFrame(6)
    end)	
	
	-- Show Group 7 Check
    Healium_ShowGroup7Check = CreateFrame("CheckButton","$parentShowGroup7CheckButton",scrollchild,"OptionsCheckButtonTemplate")
    Healium_ShowGroup7Check:SetPoint("TOPLEFT",Healium_ShowGroup6Check, "BOTTOMLEFT", 0, 0)
	Healium_ShowGroup7Check.tooltipText = "Shows the Group 7 " .. Healium_AddonColoredName .. " frame."			
    Healium_ShowGroup7Check.Text = Healium_ShowGroup7Check:CreateFontString(nil, "BACKGROUND","GameFontNormal")
    Healium_ShowGroup7Check.Text:SetPoint("LEFT", Healium_ShowGroup7Check, "RIGHT", 0)
    Healium_ShowGroup7Check.Text:SetText("Group 7")
    
    Healium_ShowGroup7Check:SetScript("OnClick",function()
        Healium.ShowGroupFrames[7] = Healium_ShowGroup7Check:GetChecked() or false
		Healium_ShowHideGroupFrame(7)		
    end)	
	
	-- Show Group 8 Check
    Healium_ShowGroup8Check = CreateFrame("CheckButton","$parentShowGroup8CheckButton",scrollchild,"OptionsCheckButtonTemplate")
    Healium_ShowGroup8Check:SetPoint("TOPLEFT",Healium_ShowGroup7Check, "BOTTOMLEFT", 0, 0)
	Healium_ShowGroup8Check.tooltipText = "Shows the Group 8 " .. Healium_AddonColoredName .. " frame."			
    Healium_ShowGroup8Check.Text = Healium_ShowGroup8Check:CreateFontString(nil, "BACKGROUND","GameFontNormal")
    Healium_ShowGroup8Check.Text:SetPoint("LEFT", Healium_ShowGroup8Check, "RIGHT", 0)
    Healium_ShowGroup8Check.Text:SetText("Group 8")
    
    Healium_ShowGroup8Check:SetScript("OnClick",function()
        Healium.ShowGroupFrames[8] = Healium_ShowGroup8Check:GetChecked() or false
		Healium_ShowHideGroupFrame(8)
    end)		
	
    Healium_ShowTanksCheck = CreateFrame("CheckButton","$parentShowTanksCheckButton",scrollchild,"OptionsCheckButtonTemplate")
    Healium_ShowTanksCheck:SetPoint("TOPLEFT",Healium_ShowGroup8Check, "BOTTOMLEFT", 0, 0)
	Healium_ShowTanksCheck.tooltipText = "Shows the Tanks " .. Healium_AddonColoredName .. " frame."			
    Healium_ShowTanksCheck.Text = Healium_ShowTanksCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
    Healium_ShowTanksCheck.Text:SetPoint("LEFT", Healium_ShowTanksCheck, "RIGHT", 0)
    Healium_ShowTanksCheck.Text:SetText("Tanks")
    
    Healium_ShowTanksCheck:SetScript("OnClick",function()
        Healium.ShowTanksFrame = Healium_ShowTanksCheck:GetChecked() or false
		Healium_ShowHideTanksFrame()
    end)			
	
	-- Debuff Warnings
	local DebuffWarningsTitleText = scrollchild:CreateFontString(nil, "OVERLAY","GameFontNormalLarge")
	DebuffWarningsTitleText:SetJustifyH("LEFT")
	DebuffWarningsTitleText:SetPoint("TOPLEFT", Healium_ShowTanksCheck, "BOTTOMLEFT", 0, -30)
	DebuffWarningsTitleText:SetText("Debuff Warnings")
	
	local DebuffWarningsSubText = scrollchild:CreateFontString(nil, "OVERLAY","GameFontNormalSmall")
	DebuffWarningsSubText:SetJustifyH("LEFT")
	DebuffWarningsSubText:SetPoint("TOPLEFT", DebuffWarningsTitleText, "BOTTOMLEFT", 0, 0)
	DebuffWarningsSubText:SetText("Debuff warnings are audible and visual indicators that|nnotify you when you can cure a debuff on a player.")
	DebuffWarningsSubText:SetTextColor(1,1,1,1) 

	
	-- Enable Debuffs check button
    local EnableDebuffsCheck = CreateFrame("CheckButton","$parentEnableDebuffsCheckButton",scrollchild,"OptionsCheckButtonTemplate")
	EnableDebuffsCheck.children = { }
    EnableDebuffsCheck:SetPoint("TOPLEFT", DebuffWarningsSubText, "BOTTOMLEFT", 0, -10)
    
    EnableDebuffsCheck.Text = EnableDebuffsCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
	EnableDebuffsCheck.Text:SetPoint("LEFT", EnableDebuffsCheck, "RIGHT", 0)
    EnableDebuffsCheck.Text:SetText("Enable Debuff Warnings")

	EnableDebuffsCheck:SetScript("OnClick", EnableDebuffsCheck_OnClick)	
	EnableDebuffsCheck.tooltipText = "Enables debuff warnings"

	-- Enable Debuff Healthbar coloring check button 
	
	local EnableDebufHealthbarColoringCheck	= CreateFrame("CheckButton","$parentEnableDebuffHealthbarColoringCheckButton",scrollchild,"OptionsCheckButtonTemplate")
    EnableDebufHealthbarColoringCheck:SetPoint("TOPLEFT", EnableDebuffsCheck, "BOTTOMLEFT", 20, 0)
    
    EnableDebufHealthbarColoringCheck.Text = EnableDebufHealthbarColoringCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
	EnableDebufHealthbarColoringCheck.Text:SetPoint("LEFT", EnableDebufHealthbarColoringCheck, "RIGHT", 0)
    EnableDebufHealthbarColoringCheck.Text:SetText("Healthbar Coloring")
	table.insert(EnableDebuffsCheck.children, EnableDebufHealthbarColoringCheck.Text)
	
	EnableDebufHealthbarColoringCheck:SetScript("OnClick", EnableDebuffHealthbarColoringCheck_OnClick)	
	EnableDebufHealthbarColoringCheck.tooltipText = "Enables coloring of the healthbar of a player that has a debuff which you can cure"
	
	
	-- Enable Debuff Healthbar highlighting check button
    local EnableDebuffHealthbarHighlightingCheck = CreateFrame("CheckButton","$parentEnableDebuffHealthbarHighlightingCheck",scrollchild,"OptionsCheckButtonTemplate")
    EnableDebuffHealthbarHighlightingCheck:SetPoint("TOPLEFT", EnableDebufHealthbarColoringCheck, "BOTTOMLEFT", 0, 0)
    
    EnableDebuffHealthbarHighlightingCheck.Text = EnableDebuffHealthbarHighlightingCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
	EnableDebuffHealthbarHighlightingCheck.Text:SetPoint("LEFT", EnableDebuffHealthbarHighlightingCheck, "RIGHT", 0)
    EnableDebuffHealthbarHighlightingCheck.Text:SetText("Healthbar Highlight Warning")
	table.insert(EnableDebuffsCheck.children, EnableDebuffHealthbarHighlightingCheck.Text)
	
	EnableDebuffHealthbarHighlightingCheck:SetScript("OnClick", EnableDebuffHealthbarHighlightingCheck_OnClick)	
	EnableDebuffHealthbarHighlightingCheck.tooltipText = "Enables highlighting of the healthbar of a player that has a debuff which you can cure"


	-- Enable Debuff Button highlighting check button
    local EnableDebuffButtonHighlightingCheck = CreateFrame("CheckButton","$parentEnableDebuffButtonHighlightingCheck",scrollchild,"OptionsCheckButtonTemplate")
    EnableDebuffButtonHighlightingCheck:SetPoint("TOPLEFT", EnableDebuffHealthbarHighlightingCheck, "BOTTOMLEFT", 0, 0)
    
    EnableDebuffButtonHighlightingCheck.Text = EnableDebuffButtonHighlightingCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
	EnableDebuffButtonHighlightingCheck.Text:SetPoint("LEFT", EnableDebuffButtonHighlightingCheck, "RIGHT", 0)
    EnableDebuffButtonHighlightingCheck.Text:SetText("Button Highlight Warning")
	table.insert(EnableDebuffsCheck.children, EnableDebuffButtonHighlightingCheck.Text)
	
	EnableDebuffButtonHighlightingCheck:SetScript("OnClick", EnableDebuffButtonHighlightingCheck_OnClick)	
	EnableDebuffButtonHighlightingCheck.tooltipText = "Enables highlighting of buttons which have been assigned a spell that can cure a debuff on a player"

	-- Enable Debuff Audio check button
    local EnableDebuffAudioCheck = CreateFrame("CheckButton","$parentEnableDebuffAudioCheckButton",scrollchild,"OptionsCheckButtonTemplate")
    EnableDebuffAudioCheck:SetPoint("TOPLEFT", EnableDebuffButtonHighlightingCheck, "BOTTOMLEFT", 0, 0)
    
    EnableDebuffAudioCheck.Text = EnableDebuffAudioCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
	EnableDebuffAudioCheck.Text:SetPoint("LEFT", EnableDebuffAudioCheck, "RIGHT", 0)
    EnableDebuffAudioCheck.Text:SetText("Audio Warning")
	table.insert(EnableDebuffsCheck.children, EnableDebuffAudioCheck.Text)
	
	EnableDebuffAudioCheck:SetScript("OnClick", EnableDebuffAudioCheck_OnClick)	
	EnableDebuffAudioCheck.tooltipText = "Enables an audio warning when a player has a debuff which you can cure, and is within 40yds"
	
	-- Sound drop down
	local SoundDropDown = CreateFrame("Frame", "$parentSoundDropDown", scrollchild, "UIDropDownMenuTemplate") 
	SoundDropDown:SetPoint("TOPLEFT", EnableDebuffAudioCheck, "BOTTOMLEFT",65, 0)
	SoundDropDown.Text = SoundDropDown:CreateFontString(nil, "OVERLAY","GameFontNormal")
	SoundDropDown.Text:SetText("Audio File")
	SoundDropDown.Text:SetPoint("TOPLEFT",SoundDropDown,"TOPLEFT",-60,-5)
	UIDropDownMenu_Initialize(SoundDropDown, SoundDropDownMenu_Init)
	table.insert(EnableDebuffsCheck.children, SoundDropDown.Text)	
	
	-- Play sound button
	local PlayButton = CreateFrame("Button", "$parentPlaySoundButton", scrollchild, "UIPanelButtonTemplate")
	PlayButton:SetText("Play")
	PlayButton:SetWidth(54)
	PlayButton:SetHeight(22)
	PlayButton:SetPoint("LEFT", SoundDropDown, "RIGHT", 120, 0)
	PlayButton:SetScript("OnClick", Healium_PlayDebuffSound)
	
	-- CPU Intensive Settings text
	local UpdatingTitleText = scrollchild:CreateFontString(nil, "OVERLAY","GameFontNormalLarge")
	UpdatingTitleText:SetJustifyH("LEFT")
	UpdatingTitleText:SetPoint("TOPLEFT", EnableDebuffAudioCheck, "BOTTOMLEFT", -20, -60)
	UpdatingTitleText:SetText("CPU Intensive Settings")

	local UpdatingTitleSubText = scrollchild:CreateFontString(nil, "OVERLAY","GameFontNormalSmall")
	UpdatingTitleSubText:SetJustifyH("LEFT")
	UpdatingTitleSubText:SetPoint("TOPLEFT", UpdatingTitleText, "BOTTOMLEFT", 0, 0)
	UpdatingTitleSubText:SetText("Enabling these settings may cause extra lag.")
	UpdatingTitleSubText:SetTextColor(1,1,1,1) 
	
    -- EnableColldowns Check Button
    local EnableCooldownsCheck = CreateFrame("CheckButton","$parentEnableCooldownsCheckButton",scrollchild,"OptionsCheckButtonTemplate")
    EnableCooldownsCheck:SetPoint("TOPLEFT", UpdatingTitleSubText, "BOTTOMLEFT", 0, -10)
    EnableCooldownsCheck.tooltipText = "Enables cooldown animations on the " .. Healium_AddonColoredName .. " buttons."
	
    EnableCooldownsCheck.Text = EnableCooldownsCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
    EnableCooldownsCheck.Text:SetPoint("LEFT", EnableCooldownsCheck, "RIGHT", 0)
    EnableCooldownsCheck.Text:SetText("Enable Cooldowns")
    EnableCooldownsCheck:SetScript("OnClick", EnableCooldownsCheck_OnClick)
	

	-- RangeCheck Check Button
    local RangeCheckCheck = CreateFrame("CheckButton","$parentRangeCheckButton",scrollchild,"OptionsCheckButtonTemplate")
    RangeCheckCheck:SetPoint("TOPLEFT",EnableCooldownsCheck, "BOTTOMLEFT", 0, 0)
    RangeCheckCheck.tooltipText = "Enables range checks on the " .. Healium_AddonColoredName .. " buttons."
	
    RangeCheckCheck.Text = RangeCheckCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
    RangeCheckCheck.Text:SetPoint("LEFT", RangeCheckCheck, "RIGHT", 0)
    RangeCheckCheck.Text:SetText("Enable Range Checks")
    RangeCheckCheck:SetScript("OnClick",RangeCheckCheck_OnClick)
	
	-- RangeCheck Slider
	local RangeCheckSlider = CreateFrame("Slider","$parentRangeCheckSlider",scrollchild,"OptionsSliderTemplate")
    RangeCheckSlider:SetWidth(180)
    RangeCheckSlider:SetHeight(16)
    
    _G[RangeCheckSlider:GetName().."Low"]:SetText("Slower\n(Less CPU)")
    _G[RangeCheckSlider:GetName().."High"]:SetText("Faster\n(More CPU)")
    
    RangeCheckSlider:SetMinMaxValues(.5,5.0)
    RangeCheckSlider:SetValueStep(0.1)
    RangeCheckSlider:SetValue(1.0/Healium.RangeCheckPeriod)
    
    RangeCheckSlider:SetPoint("TOPLEFT", RangeCheckCheck.Text, "TOPRIGHT", 15, 0)
    RangeCheckSlider.tooltipText = "Controls how often to do range cheks.  The further to the right, the more often range checks are performed and the more CPU it will use."
	
    RangeCheckSlider.Text = RangeCheckSlider:CreateFontString(nil, "BACKGROUND","GameFontNormalSmall")
    RangeCheckSlider.Text:SetPoint("CENTER", -5, 17)
    UpdateRangeCheckSliderText(RangeCheckSlider)
    
    RangeCheckSlider:SetScript("OnValueChanged", RangeCheckSlider_OnValueChanged)
	
	-- ShowBuffs check
	local ShowBuffsCheck = CreateFrame("CheckButton","$parentShowBuffsCheckButton",scrollchild,"OptionsCheckButtonTemplate")
    ShowBuffsCheck:SetPoint("TOPLEFT",RangeCheckCheck, "BOTTOMLEFT", 0, 0)
    ShowBuffsCheck.tooltipText = "Shows the buffs and HOTs you have personally cast on the player to the left of the healthbar.  It will only show spells that are configured in " .. Healium_AddonColoredName .. "."
	
    ShowBuffsCheck.Text = ShowBuffsCheck:CreateFontString(nil, "BACKGROUND","GameFontNormal")
    ShowBuffsCheck.Text:SetPoint("LEFT", ShowBuffsCheck, "RIGHT", 0)
    ShowBuffsCheck.Text:SetText("Show Buffs")
	ShowBuffsCheck:SetScript("OnClick", ShowBuffsCheck_OnClick);

    -- About Frame
    local AboutTitle = CreateFrame("Frame","",scrollchild)
    AboutTitle:SetFrameStrata("TOOLTIP")
    AboutTitle:SetWidth(160)
    AboutTitle:SetHeight(20)
    
    AboutTitle.Text = AboutTitle:CreateFontString(nil, "BACKGROUND","GameFontNormalLarge")
    AboutTitle.Text:SetPoint("TOPLEFT",ShowBuffsCheck, "BOTTOMLEFT", 0, -30)
    AboutTitle.Text:SetText("About " .. Healium_AddonColoredName)
    
    local AboutFrame = CreateFrame("Frame","AboutHealium",scrollchild)
    AboutFrame:SetWidth(340)
    AboutFrame:SetHeight(80)
    AboutFrame:SetPoint("TOPLEFT", AboutTitle.Text, "BOTTOMLEFT", 0, 0)

    AboutFrame:SetBackdrop({bgFile = "",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }})

    AboutFrame.Text = AboutFrame:CreateFontString(nil, "BACKGROUND","GameFontNormal")
    AboutFrame.Text:SetWidth(330)
    AboutFrame.Text:SetJustifyH("LEFT")
    AboutFrame.Text:SetPoint("TOPLEFT", 7,-10)
    AboutFrame.Text:SetText(Healium_AddonColoredName .. Version .. " |cFFFFFFFFCreated by Engy of Area 52.|n|n|cFFFFFFFFOriginally based on FB Heal Box, which was created by Dourd of Argent Dawn EU.")

	-- Init Config Panel controls
	for i=1, Healium_MaxButtons, 1 do
		UIDropDownMenu_Initialize(HealiumDropDown[i], DropDownMenu_Init)
	end
	
	Healium_Update_ConfigPanel()
	
	TooltipsCheck:SetChecked(Healium.ShowToolTips)		
	ShowManaCheck:SetChecked(Healium.ShowMana)
	PercentageCheck:SetChecked(Healium.ShowPercentage)
	ClassColorCheck:SetChecked(Healium.UseClassColors)
	ShowBuffsCheck:SetChecked(Healium.ShowBuffs)
	RangeCheckCheck:SetChecked(Healium.DoRangeChecks)
	EnableCooldownsCheck:SetChecked(Healium.EnableCooldowns)	
	HideCloseButtonCheck:SetChecked(Healium.HideCloseButton)
	HideCaptionsCheck:SetChecked(Healium.HideCaptions)
	LockFramePositionsCheck:SetChecked(Healium.LockFrames)
	EnableDebuffsCheck:SetChecked(Healium.EnableDebufs)
	EnableCliqueCheck:SetChecked(Healium.EnableClique)
	EnableDebuffAudioCheck:SetChecked(Healium.EnableDebufAudio)
	EnableDebuffHealthbarHighlightingCheck:SetChecked(Healium.EnableDebufHealthbarHighlighting)
	EnableDebuffButtonHighlightingCheck:SetChecked(Healium.EnableDebufButtonHighlighting)
	EnableDebufHealthbarColoringCheck:SetChecked(Healium.EnableDebufHealthbarColoring)
	
	UIDropDownMenu_SetText(SoundDropDown, Healium.DebufAudioFile)
	
	Healium_ShowPartyCheck:SetChecked(Healium.ShowPartyFrame)
	Healium_ShowPetsCheck:SetChecked(Healium.ShowPetsFrame)
	Healium_ShowMeCheck:SetChecked(Healium.ShowMeFrame)
	Healium_ShowFriendsCheck:SetChecked(Healium.ShowFriendsFrame)
	Healium_ShowTanksCheck:SetChecked(Healium.ShowTanksFrame)
	Healium_ShowGroup1Check:SetChecked(Healium.ShowGroupFrames[1])
	Healium_ShowGroup2Check:SetChecked(Healium.ShowGroupFrames[2])
	Healium_ShowGroup3Check:SetChecked(Healium.ShowGroupFrames[3])
	Healium_ShowGroup4Check:SetChecked(Healium.ShowGroupFrames[4])
	Healium_ShowGroup5Check:SetChecked(Healium.ShowGroupFrames[5])
	Healium_ShowGroup6Check:SetChecked(Healium.ShowGroupFrames[6])
	Healium_ShowGroup7Check:SetChecked(Healium.ShowGroupFrames[7])
	Healium_ShowGroup8Check:SetChecked(Healium.ShowGroupFrames[8])
	
	ScaleSlider:SetValue(Healium.Scale)
	RangeCheckSlider:SetValue(1.0/Healium.RangeCheckPeriod)
	
	UpdateEnableDebuffsControls(EnableDebuffsCheck)

end
