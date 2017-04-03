
local copytable = TidyPlatesUtility.copyTable
local mergetable = TidyPlatesUtility.mergeTable
local PanelHelpers = TidyPlatesUtility.PanelHelpers

local activespec = "primary"

-------------------------------------------------------------------------------------
--  Default Options
-------------------------------------------------------------------------------------
TidyPlatesOptions = {primary = "Neon/Tank", secondary = "Neon/DPS", autohide = false}
local TidyPlatesOptionsDefaults = copytable(TidyPlatesOptions)
local TidyPlatesThemeNames, TidyPlatesThemeIndexes = {}, {}
if not TidyPlatesThemeList then TidyPlatesThemeList = {} end
TidyPlatesThemeNames[1] = "None"
TidyPlatesThemeIndexes["None"] = 1

-------------------------------------------------------------------------------------
-- Pre-Processor
-------------------------------------------------------------------------------------
local mergedTheme = {}
local function LoadTheme(incomingtheme) 
	local name, theme, style, stylename, newvalue
	wipe(mergedTheme)
	
	-- Load Values Via Theme Table (Rarely Used)
	if type(incomingtheme) == "table" then theme = incomingtheme
	-- Load Values Via Theme Name/String (Normal Operation) 
	elseif type(TidyPlatesThemeList) == "table" then 
		if type(incomingtheme) == 'string' then 
			theme = TidyPlatesThemeList[incomingtheme] 
		end
	end
	
	-- Check for valid theme
	if type(theme) == 'table' then 
		if theme.SetStyle and type(theme.SetStyle) == "function" then
			-- Multi-Style Theme
			for stylename, style in pairs(theme) do
				if type(style) == "table" then theme[stylename] = mergetable(TidyPlates.defaultTheme, style) end 
			end
		else 	
			-- Single-Style Theme
			for propertyname, oldvalue in pairs(TidyPlates.defaultTheme) do
				newvalue = theme[propertyname]
				if type(newvalue) == "table" then theme[propertyname] = mergetable(oldvalue, newvalue)
				else theme[propertyname] = copytable(oldvalue) end 	
			end
		end
		-- Choices: Overwrite incomingtheme as it's processed, or Overwrite after the processing is done
		TidyPlates:ActivateTheme(theme)	
	else
		TidyPlatesOptions[activespec] = "None"
		TidyPlates:ActivateTheme(TidyPlates.defaultTheme)
		return 
	end
	

end

function TidyPlates:ReloadTheme()
	LoadTheme(TidyPlatesOptions[activespec])
	TidyPlates:ForceUpdate()
end
	
-------------------------------------------------------------------------------------
-- Panel
-------------------------------------------------------------------------------------

local function UpdateThemeNames()
	local themecount = 1
	if type(TidyPlatesThemeList) == "table" then
		for themename, themepointer in pairs(TidyPlatesThemeList) do
			themecount = themecount + 1
			TidyPlatesThemeNames[themecount] = themename
			TidyPlatesThemeIndexes[themename] = themecount
		end
	end
end

local ApplyPanelSettings

local title = GetAddOnMetadata("TidyPlates", "title").." v"..GetAddOnMetadata("TidyPlates", "version")
local panel = PanelHelpers:CreatePanelFrame( "TidyPlatesInterfaceOptions", "Tidy Plates", title )
local helppanel = PanelHelpers:CreatePanelFrame( "TidyPlatesInterfaceOptionsHelp", "Troubleshooting" )

panel:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", insets = { left = 2, right = 2, top = 2, bottom = 2 },})
panel:SetBackdropColor(0.05, 0.05, 0.05, .7)
local firstShow = true
local dropmenu = {}

local function ActivateInterfacePanel()
	---- Note 
	local offset = -20
	panel.label = panel:CreateFontString(nil, 'ARTWORK') --, 'GameFontLarge'
	panel.label:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	panel.label:SetPoint("TOPLEFT", panel, "TOPLEFT", 35, -40)
	panel.label:SetWidth(340)
	panel.label:SetJustifyH("LEFT")
	panel.label:SetText(
		"Please choose a theme for your Primary and Secondary Specializations; "..
		"The appropriate theme will be automatically activated when you switch specs.")
	panel.label:SetTextColor(1,1,1,1)

	-- Theme Choices
	for index, name in pairs(TidyPlatesThemeNames) do dropmenu[index] = {text = name, notCheckable = 1 } end
	
	-- Primary Spec Dropdown
	panel.PrimarySpecTheme = PanelHelpers:CreateDropdownFrame("TidyPlatesChooserDropdown", panel, dropmenu, 1)
	panel.PrimarySpecTheme:SetPoint("TOPLEFT", 16, -80+offset)
	
	-- Secondary Spec Dropdown
	panel.SecondarySpecTheme = PanelHelpers:CreateDropdownFrame("TidyPlatesChooserDropdown2", panel, dropmenu, 1)
	panel.SecondarySpecTheme:SetPoint("TOPLEFT",panel.PrimarySpecTheme, "TOPRIGHT", 100, 0)
	
	-- Primary Label 
	panel.PrimaryLabel = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	panel.PrimaryLabel:SetPoint("BOTTOMLEFT", panel.PrimarySpecTheme,"TOPLEFT", 20, 5)
	panel.PrimaryLabel:SetWidth(170)
	panel.PrimaryLabel:SetJustifyH("LEFT")
	panel.PrimaryLabel:SetText("Primary Theme:")

	-- Secondary Label 
	panel.SecondaryLabel = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	panel.SecondaryLabel:SetPoint("BOTTOMLEFT", panel.SecondarySpecTheme,"TOPLEFT", 20, 5)
	panel.SecondaryLabel:SetWidth(170)
	panel.SecondaryLabel:SetJustifyH("LEFT")
	panel.SecondaryLabel:SetText("Secondary Theme:")

	-- Overlap:
	panel.AllowOverlap = PanelHelpers:CreateCheckButton("TidyPlatesOptions_Overlap", panel, "Allow Overlapping Nameplates")
	panel.AllowOverlap:SetPoint("TOPLEFT", panel.PrimarySpecTheme, "TOPLEFT", 16, -55)
	--panel.AllowOverlap:SetScript("OnShow", function(self) self:SetChecked( tonumber(GetCVar("nameplateAllowOverlap")) == 1) end)
	panel.AllowOverlap:SetScript("OnClick", function(self) 	if self:GetChecked() then SetCVar("nameplateAllowOverlap", 1) else SetCVar("nameplateAllowOverlap", 0) end end)
	
	
	-- [[ Autohide:
	panel.AutoHide = PanelHelpers:CreateCheckButton("TidyPlatesOptions_Autohide", panel, "Show/Hide Plates when Combat Starts and Ends")
	panel.AutoHide:SetPoint("TOPLEFT", panel.AllowOverlap, "TOPLEFT", 0, -35)
	--]]
	
	--[[
	-- Autoshow:
	panel.AutoShow = PanelHelpers:CreateCheckButton("TidyPlatesOptions_AutoShow", panel, "Show Enemy Nameplates when Combat Starts")
	panel.AutoShow:SetPoint("TOPLEFT", panel.AllowOverlap, "TOPLEFT", 0, -35)
	
	-- Autohide:
	panel.AutoHide = PanelHelpers:CreateCheckButton("TidyPlatesOptions_AutoHide", panel, "Hide Enemy Nameplates when Combat Ends")
	panel.AutoHide:SetPoint("TOPLEFT", panel.AutoShow, "TOPLEFT", 0, -35)
	--]]
	
	-- Apply Button
	panel.apply = CreateFrame("Button", "TidyPlatesApplyButton", panel, "UIPanelButtonTemplate2")
	panel.apply:SetPoint("TOPLEFT", panel.SecondarySpecTheme, "TOPRIGHT", 115, -2)
	panel.apply:SetText("Apply")
	panel.apply:SetWidth(80)
	
	--[[
	panel:SetScript("OnShow", function() 
		if firstShow then
			InterfaceOptionsFrame_OpenToCategory(helppanel) 
			InterfaceOptionsFrame_OpenToCategory(panel) 
			firstShow = false
		end
	end)
	--]]
	
	panel.apply:SetScript("OnClick", ApplyPanelSettings)
	panel.okay = ApplyPanelSettings

	panel.refresh = function ()
		panel.PrimarySpecTheme:SetValue(TidyPlatesThemeIndexes[TidyPlatesOptions.primary])
		panel.SecondarySpecTheme:SetValue(TidyPlatesThemeIndexes[TidyPlatesOptions.secondary])
		
		if tonumber(GetCVar("nameplateAllowOverlap")) == 1 then panel.AllowOverlap:SetChecked(true) else panel.AllowOverlap:SetChecked(false) end		
		panel.AutoHide:SetChecked(TidyPlatesOptions.autohide)
	end

	
	--PanelHelpers.EnableFreePositioning(panel.PrimarySpecTheme)		-- TESTING
	
	InterfaceOptions_AddCategory(panel);
end


helppanel.parent = "Tidy Plates"
helppanel:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", insets = { left = 2, right = 2, top = 2, bottom = 2 },})
helppanel:SetBackdropColor(0.05, 0.05, 0.05, .7)

local function ActivateHelpPanel()
	--[[ Description 
	helppanel.label = helppanel:CreateFontString(nil, 'ARTWORK') --, 'GameFontLarge'
	helppanel.label:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	helppanel.label:SetPoint("TOPLEFT", helppanel, "TOPLEFT", 35, -40)
	helppanel.label:SetWidth(325)
	helppanel.label:SetJustifyH("LEFT")
	helppanel.label:SetText("First, try these quick fixes:")
	helppanel.label:SetTextColor(1,1,1,1)
	
	--]]
	---- Button: Vkey alias 
	helppanel.vkeylabel = helppanel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal') --, 'GameFontLarge'
	--helppanel.vkeylabel:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	helppanel.vkeylabel:SetPoint("TOPLEFT", helppanel, "TOPLEFT", 35, -50)
	helppanel.vkeylabel:SetWidth(325)
	helppanel.vkeylabel:SetJustifyH("LEFT")
	helppanel.vkeylabel:SetText("Show Nameplates:|cFFFFFFFF You can also toggle nameplates on-and-off by using:"..
								" '|rV|cFFFFFFFF' for Enemies, '|rShift-V|cFFFFFFFF' for friends, and '|rControl-V|cFFFFFFFF' for both.")
	
	helppanel.vkey = CreateFrame("Button", "TidyPlatesHelpButton1", helppanel, "UIPanelButtonTemplate2")
	helppanel.vkey:SetPoint("TOPLEFT", helppanel.vkeylabel, "BOTTOMLEFT", 0, -8)
	helppanel.vkey:SetText("Show")
	helppanel.vkey:SetWidth(80)
	
	helppanel.vkey:SetScript("OnClick", function() 
		SetCVar("nameplateShowEnemies", 1)
		SetCVar("nameplateShowFriends", 1)
		TidyPlates:ForceUpdate()
	end)
	
	---- Button: Reset and Reload
	helppanel.resetreloadlabel = helppanel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal') --, 'GameFontLarge'
	--helppanel.resetreloadlabel:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	helppanel.resetreloadlabel:SetPoint("TOPLEFT", helppanel.vkey, "BOTTOMLEFT", 0, -20)
	helppanel.resetreloadlabel:SetWidth(325)
	helppanel.resetreloadlabel:SetJustifyH("LEFT")
	helppanel.resetreloadlabel:SetText("Reset Variables:|cFFFFFFFF This button will reset Tidy Plates variables, and reload the UI.  "..
										"Note: Using this button during combat is NOT a good idea. ")
	--helppanel.resetreloadlabel:SetTextColor(1,1,1,1)
	
	helppanel.resetreload = CreateFrame("Button", "TidyPlatesHelpButton2", helppanel, "UIPanelButtonTemplate2")
	helppanel.resetreload:SetPoint("TOPLEFT", helppanel.resetreloadlabel, "BOTTOMLEFT", 0, -8)
	helppanel.resetreload:SetText("Reset")
	helppanel.resetreload:SetWidth(80)
	
	helppanel.resetreload:SetScript("OnClick", function() 
		TidyPlatesOptions = copytable(TidyPlatesOptionsDefaults)
		LoadTheme(TidyPlatesOptions[activespec])
		ReloadUI()
	end)
	
	---- Note 
	helppanel.notes = helppanel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal') --, 'GameFontLarge'
	--helppanel.notes:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	helppanel.notes:SetPoint("TOPLEFT", helppanel.resetreload, "BOTTOMLEFT", 0, -45)
	helppanel.notes:SetWidth(325)
	helppanel.notes:SetJustifyH("LEFT")
	helppanel.notes:SetText("If issues persist, visit our page at Wowinterface.com "..
							"to file a bug report or to ask a question.  If you're "..
							"filing a bug, please use the 'Report Bug' button.")
	helppanel.notes:SetTextColor(1,1,1,1)

	InterfaceOptions_AddCategory(helppanel);
end


ApplyPanelSettings = function()
		TidyPlatesOptions.primary = TidyPlatesThemeNames[panel.PrimarySpecTheme.Value]
		TidyPlatesOptions.secondary = TidyPlatesThemeNames[panel.SecondarySpecTheme.Value]
				
		TidyPlatesOptions.autohide = panel.AutoHide:GetChecked()
		
		TidyPlates:UseAutoHide(TidyPlatesOptions.autohide) 
		LoadTheme(TidyPlatesOptions[activespec])
		-- Clear Widgets
		TidyPlatesWidgets:ResetWidgets()
		
		-- Update Appearance
		TidyPlates:ForceUpdate()
		
		if panel.AllowOverlap:GetChecked() then SetCVar("nameplateAllowOverlap", 1)
		else SetCVar("nameplateAllowOverlap", 0) end
		
end

-------------------------------------------------------------------------------------
-- Auto-Loader
-------------------------------------------------------------------------------------
local panelevents = {}

function panelevents:ACTIVE_TALENT_GROUP_CHANGED()
	if GetActiveTalentGroup(false, false) == 2 then activespec = "secondary" 
	else activespec = "primary" end
	LoadTheme(TidyPlatesOptions[activespec])
	TidyPlatesWidgets:ResetWidgets()
	TidyPlates:ForceUpdate()
end

function panelevents:PLAYER_LOGIN()
	TidyPlates:UseAutoHide(TidyPlatesOptions.autohide) 
	UpdateThemeNames()
	ActivateInterfacePanel()
	ActivateHelpPanel()
	panelevents:ACTIVE_TALENT_GROUP_CHANGED()
end

panel:SetScript("OnEvent", function(self, event, ...) panelevents[event]() end)
for eventname in pairs(panelevents) do panel:RegisterEvent(eventname) end

panel:RegisterEvent("PLAYER_LOGIN")

-------------------------------------------------------------------------------------
-- Slash Commands
-------------------------------------------------------------------------------------
TidyPlatesSlashCommands = {}
TidyPlatesSlashCommands.reset = function() print("Tidy Plates: Variables have been reset"); TidyPlatesOptions = copytable(TidyPlatesOptionsDefaults); LoadTheme(TidyPlatesOptions[activespec]) end

function slash_TidyPlates(arg)
	if type(TidyPlatesSlashCommands[arg]) == 'function' then 
		TidyPlatesSlashCommands[arg]() 
		TidyPlates:ForceUpdate()
	else InterfaceOptionsFrame_OpenToCategory(panel) end
end

SLASH_TIDYPLATES1 = '/tidyplates'
SlashCmdList['TIDYPLATES'] = slash_TidyPlates;

