local theme = TidyPlatesThemeList["Grey/DPS"]
TidyPlatesGreyDPSSavedVariables = {}
---------------
-- Helpers
---------------
local copytable = TidyPlatesUtility.copyTable
local updatetable = TidyPlatesUtility.updateTable
local PanelHelpers = TidyPlatesUtility.PanelHelpers

------------------------------------------------------------------
-- Interface Options Panel
------------------------------------------------------------------
local TextModes = { { text = "None", notCheckable = 1 },
					{ text = "Percent", notCheckable = 1 } ,
					{ text = "Actual", notCheckable = 1 } ,
					{ text = "Deficit", notCheckable = 1 } ,
					{ text = "Total & Percent", notCheckable = 1 } ,
					{ text = "Plus-and-Minus", notCheckable = 1 } ,
					}

-- Main Panel
local panel = PanelHelpers:CreatePanelFrame( "TidyPlatesGreyDPS_InterfaceOptionsPanel", "Grey/DPS" )
--panel.parent = "Tidy Plates"
panel.parent = "Tidy Plates: Grey"
panel:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", insets = { left = 2, right = 2, top = 2, bottom = 2 },})
panel:SetBackdropColor(0.05, 0.05, 0.05, .7)

local column1, column2 = -90, -100
-------------------
-- Opacity
-------------------
-- Non-Targets Opacity Slider
panel.OpacityNonTarget = PanelHelpers:CreateSliderFrame("TidyPlatesGreyDPS_OpacityNonTargets", panel, "Non-Target Opacity:", .5, 0, 1, .1)
panel.OpacityNonTarget:SetPoint("CENTER", -35+column1, 133)
-- Hide Neutral Units Checkbox
panel.OpacityHideNeutral = PanelHelpers:CreateCheckButton("TidyPlatesGreyDPS__OpacityHideNeutral", panel, "Hide Neutral Units")
panel.OpacityHideNeutral:SetPoint("CENTER", -81+column1, 95)
-- Hide Non-Elites Checkbox
panel.OpacityHideNonElites = PanelHelpers:CreateCheckButton("TidyPlatesGreyDPS_OpacityHideNonElites", panel, "Hide Non-Elites")
panel.OpacityHideNonElites:SetPoint("CENTER", -81+column1, 71)
-------------------
-- Scale
-------------------
-- General Scale
local adjustGeneral = 25
panel.ScaleGeneral = PanelHelpers:CreateSliderFrame("TidyPlatesGreyDPS_ScaleGeneral", panel, "General Scale:", 1, .5, 2, .1)
panel.ScaleGeneral:SetPoint("CENTER", -35+column1, 34-adjustGeneral)
-- Aggro'd Units Scale
panel.ScaleDanger = PanelHelpers:CreateSliderFrame("TidyPlatesGreyDPS_ScaleGaner", panel, "Aggro Danger Scale:", 1.5, 1, 2, .1)
panel.ScaleDanger:SetPoint("CENTER", -35+column1, -24-adjustGeneral)
-- Hide Non-Elites Checkbox
panel.ScaleIgnoreNonElite = PanelHelpers:CreateCheckButton("TidyPlatesGreyDPS_ScaleIgnoreNonElite", panel, "Ignore Non-Elites")
panel.ScaleIgnoreNonElite:SetPoint("CENTER", -81+column1, -62-adjustGeneral)
-------------------
-- Threat Widget
-------------------
-- Description
local widgetx, widgety = 175, 80
panel.WidgetDesc = PanelHelpers:CreateDescriptionFrame("TidyPlatesGreyDPS_WidgetDesc", panel, "Widgets:", "")
panel.WidgetDesc:SetPoint("CENTER", -11+column1+widgetx+22, -136+widgety+62)

-- Selection Box
panel.WidgetSelect = PanelHelpers:CreateCheckButton("TidyPlatesGreyDPS_WidgetSelect", panel, "Selection Box")
panel.WidgetSelect:SetPoint("CENTER", -74+column1+widgetx, -99+widgety)
-- Tug-o'-Threat
panel.WidgetTug = PanelHelpers:CreateCheckButton("TidyPlatesGreyDPS_WidgetTug", panel, "Tug-o'-Threat")
panel.WidgetTug:SetPoint("CENTER", -74+column1+widgetx, -123+widgety)
-- Combo Points
panel.WidgetCombo = PanelHelpers:CreateCheckButton("TidyPlatesGreyDPS_WidgetCombo", panel, "Combo Points")
panel.WidgetCombo:SetPoint("CENTER", -74+column1+widgetx, -147+widgety)
-- Debuffs
panel.WidgetDebuff = PanelHelpers:CreateCheckButton("TidyPlatesGreyDPS_WidgetDebuff", panel, "Short Debuffs")
panel.WidgetDebuff:SetPoint("CENTER", -74+column1+widgetx, -171+widgety)
-- Level
panel.LevelText = PanelHelpers:CreateCheckButton("TidyPlatesGreyDPS_LevelText", panel, "Unit Level")
panel.LevelText:SetPoint("CENTER", -74+column1+widgetx, -195+widgety)

-------------------
-- Aggro
-------------------
panel.AggroDesc = PanelHelpers:CreateDescriptionFrame("TidyPlatesGreyDPS_AggroDesc", panel, "Aggro Indicators:", "")
panel.AggroDesc:SetPoint("CENTER", 170+column2+26, 92+58)

-- Health Bar
panel.AggroHealth = PanelHelpers:CreateCheckButton("TidyPlatesGreyDPS_AggroHealth", panel, "Health Bar Color")
panel.AggroHealth:SetPoint("CENTER", 112+column2, 126)
-- Border
panel.AggroBorder = PanelHelpers:CreateCheckButton("TidyPlatesGreyDPS_AggroBorder", panel, "Border Glow")
panel.AggroBorder:SetPoint("CENTER", 112+column2, 102)
-- Safe Units
panel.AggroSafeColor = PanelHelpers:CreateColorBox("TidyPlatesGreyDPS_AggroSafeColor", panel, "Safe Color", 0, .5, 1, 1)
panel.AggroSafeColor:SetPoint("CENTER", 137+column2, 71)
-- Aggro'd Units
panel.AggroDangerColor = PanelHelpers:CreateColorBox("TidyPlatesGreyDPS_AggroDangerColor", panel, "Aggro Danger Color", 0, .5, 1, 1)
panel.AggroDangerColor:SetPoint("CENTER", 137+column2, 44)

-------------------
-- Health Text
-------------------
-- Health Text
panel.HealthText = PanelHelpers:CreateDropdownFrame("TidyPlatesGreyDPS_HealthText", panel, TextModes, 1, "Health Text Mode:")
panel.HealthText:SetPoint("CENTER", -87+column1, -160)
-------------------
-- Apply Button
-------------------
panel.apply = CreateFrame("Button", "TidyPlatesGreyDPS_ApplyButton", panel, "UIPanelButtonTemplate2")
panel.apply:SetPoint("BOTTOMRIGHT", panel, -15, 15)
panel.apply:SetText("Apply")
panel.apply:SetWidth(80)

local function UpdateThemeOptions()
	theme.options.showAggroGlow = TidyPlatesGreyDPSVariables.AggroBorder
	theme.threatcolor.LOW = TidyPlatesGreyDPSVariables.AggroSafeColor
	theme.threatcolor.MEDIUM = TidyPlatesGreyDPSVariables.AggroDangerColor
	theme.threatcolor.HIGH = TidyPlatesGreyDPSVariables.AggroDangerColor
	theme.options.showLevel = TidyPlatesGreyDPSVariables.LevelText
	if theme.options.showLevel then theme.name = { width = 88, }
	else theme.name = { width = 100, } end
	-- Force Style Update
	TidyPlates:ReloadTheme()
end

local function GetPanelValues()
	local index, value
	for index, value in pairs(TidyPlatesGreyDPSVariables) do
		TidyPlatesGreyDPSVariables[index] = panel[index]:GetValue()
		TidyPlatesGreyDPSSavedVariables[index] = TidyPlatesGreyDPSVariables[index]
	end
end

local function SetPanelValues()
	local index, value
	for index, value in pairs(TidyPlatesGreyDPSVariables) do
		panel[index]:SetValue(TidyPlatesGreyDPSVariables[index])
	end
end

local function GetSavedVariables()
	local index, value
	TidyPlatesGreyDPSVariables = updatetable(TidyPlatesGreyDPSVariables, TidyPlatesGreyDPSSavedVariables)
end

-- Update Variables
panel.okay = function ()
	GetPanelValues()
	TidyPlates:ForceUpdate()
	UpdateThemeOptions()
end

panel.apply:SetScript("OnClick",panel.okay)
panel.refresh = SetPanelValues

-- Login
panel:SetScript("OnEvent", function(self, event, ...) 
	if event == "PLAYER_LOGIN" then 
		InterfaceOptions_AddCategory(panel)
	elseif event == "PLAYER_ENTERING_WORLD" then -- "PLAYER_ENTERING_WORLD"
		GetSavedVariables()
		UpdateThemeOptions()
	end
	
end)

panel:RegisterEvent("PLAYER_LOGIN")
panel:RegisterEvent("PLAYER_ENTERING_WORLD")

-- Slash Command
function slash_TidyDPS(arg)	InterfaceOptionsFrame_OpenToCategory(panel) end
SLASH_GREYDPS1 = '/greydps'
SlashCmdList['GREYDPS'] = slash_TidyDPS;


