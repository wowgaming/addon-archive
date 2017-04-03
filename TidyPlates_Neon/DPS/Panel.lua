local theme = TidyPlatesThemeList["Neon/DPS"]
TidyPlatesNeonDPSSavedVariables = {}
local DPSPanel

--/run for i in pairs(TidyPlatesNeonDPSVariables.WidgetDebuffList) do print("Debuff: "..i) end; for i in pairs(TidyPlatesNeonDPSSavedVariables.WidgetDebuffList) do print("Debuff: "..i) end

---------------
-- Helpers
---------------
local CopyTable = TidyPlatesUtility.copyTable
--local mergeTable = TidyPlatesUtility.mergeTable
--local updatetable = TidyPlatesUtility.updateTable
local PanelHelpers = TidyPlatesUtility.PanelHelpers

local function UpdateTable(original, update)
	for index, value in pairs(update) do
		if value then
			if type(value) == "table" then 
				original[index] = CopyTable(value)
			else
				original[index] = value
			end
		end
	end
end

local function SplitToTable( ... )
	local t = {}
	local index, line
	for index = 1, select("#", ...) do
		line = select(index, ...)
		if line ~= "" then t[line] = true end
	end
	return t
end

local function TableToString(t)
	local str = ""
	for i in pairs(t) do
		if str then str = "\n" ..str else str = "" end
		str = (tostring(i))..str
	end
	return str
end

------------------------------------------------------------------
-- Interface Options Panel
------------------------------------------------------------------
local TextModes = { { text = "None", notCheckable = 1 },
					{ text = "Percent", notCheckable = 1 } ,
					{ text = "Actual", notCheckable = 1 } ,
					{ text = "Defecit", notCheckable = 1 } ,
					{ text = "Total & Percent", notCheckable = 1 } ,
					{ text = "Plus-and-Minus", notCheckable = 1 } ,
					{ text = "Level", notCheckable = 1 } ,
					}
					
local RangeModes = { { text = "9 yards" } , 
					{ text = "15 yards" } ,
					{ text = "28 yards" } ,
					{ text = "40 yards" } ,
					}
					
local DebuffModes = { 
					{ text = "Show All", notCheckable = 1 } ,
					{ text = "Filter", notCheckable = 1 } , 
					--{ text = "Show All, Except...", notCheckable = 1 } ,
					}
-------------------
-- Main Panel
-------------------
local rootpanel = PanelHelpers:CreatePanelFrame( "TidyPlatesNeonRoot_InterfaceOptionsPanel", "Tidy Plates: Neon" )
	
local function CreateInterfacePanel( Name, Title, Parent, VariableTarget )  
	local panel = PanelHelpers:CreatePanelFrame( Name.."_InterfaceOptionsPanel", Title )
	panel.name = Title
	if Parent then panel.parent = Parent end
	panel:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", insets = { left = 2, right = 2, top = 2, bottom = 2 },})
	panel:SetBackdropColor(0.05, 0.05, 0.05, .7)

	-------------------
	-- Apply Button
	-------------------
	panel.ApplyButton = CreateFrame("Button", Name.."_ApplyButton", panel, "UIPanelButtonTemplate2")
	panel.ApplyButton:SetPoint("BOTTOMRIGHT", panel, -9, 12)
	panel.ApplyButton:SetText("Apply")
	panel.ApplyButton:SetWidth(120)

	-------------------
	-- Scroll Box
	-------------------
	panel.ScrollFrame = CreateFrame("ScrollFrame",Name.."_Scrollframe", panel, "UIPanelScrollFrameTemplate")
	panel.ScrollFrame:SetPoint("TOPLEFT", 16, -40 )
	panel.ScrollFrame:SetPoint("BOTTOMRIGHT", -32 , 48 )
		
	
	local ScrollFrameBorder = CreateFrame("Frame", "ScrollFrameBorder", panel.ScrollFrame )
	ScrollFrameBorder:SetPoint("TOPLEFT", -4, 5)
	ScrollFrameBorder:SetPoint("BOTTOMRIGHT", 3, -5)
	ScrollFrameBorder:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
												edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
												tile = true, tileSize = 16, edgeSize = 16, 
												insets = { left = 4, right = 4, top = 4, bottom = 4 }
												});
	ScrollFrameBorder:SetBackdropColor(0.05, 0.05, 0.05, 0)
	ScrollFrameBorder:SetBackdropBorderColor(0.2, 0.2, 0.2, 1)
	
	panel.MainFrame = CreateFrame("Frame")
	panel.MainFrame:SetWidth(412)
	panel.MainFrame:SetHeight(500)
	
	panel.ScrollFrame:SetScrollChild(panel.MainFrame)

	panel.Column1 = CreateFrame("Frame", Name.."_Column1", panel.MainFrame)
	panel.Column1:SetPoint("TOPLEFT", 8,0)
	panel.Column1:SetPoint("BOTTOMRIGHT", panel.MainFrame, "BOTTOM")

	panel.Column2 = CreateFrame("Frame", Name.."_Column2", panel.MainFrame)
	panel.Column2:SetPoint("TOPRIGHT", -16, 0)
	panel.Column2:SetPoint("BOTTOMLEFT", panel.MainFrame, "BOTTOM", -16, 0)

	local Column1, Column2 = panel.Column1, panel.Column2

	-------------------
	-- Opacity
	-------------------
	-- Non-Targets Opacity Slider
	panel.OpacityNonTarget = PanelHelpers:CreateSliderFrame(Name.."_OpacityNonTargets", Column1, "Non-Target Opacity:", .5, 0, 1, .1)
	panel.OpacityNonTarget:SetPoint("LEFT")
	panel.OpacityNonTarget:SetPoint("TOP", 32, -32)
	-- Hide Neutral Units Checkbox
	panel.OpacityHideNeutral = PanelHelpers:CreateCheckButton(Name.."_OpacityHideNeutral", Column1, "Hide Neutral Units")
	panel.OpacityHideNeutral:SetPoint("LEFT")
	panel.OpacityHideNeutral:SetPoint("TOP", panel.OpacityNonTarget, "BOTTOM", 0,-10)
	-- Hide Non-Elites Checkbox
	panel.OpacityHideNonElites = PanelHelpers:CreateCheckButton(Name.."_OpacityHideNonElites", Column1, "Hide Non-Elites")
	panel.OpacityHideNonElites:SetPoint("LEFT")
	panel.OpacityHideNonElites:SetPoint("TOP", panel.OpacityHideNeutral, "BOTTOM", 0,0)
	-------------------
	-- Scale
	-------------------
	-- General Scale
	panel.ScaleGeneral = PanelHelpers:CreateSliderFrame(Name.."_ScaleGeneral", Column1, "General Scale:", 1, .5, 2, .1)
	panel.ScaleGeneral:SetPoint("LEFT")
	panel.ScaleGeneral:SetPoint("TOP", panel.OpacityHideNonElites, "BOTTOM", 0,-32)
	-- Loose Units Scale
	panel.ScaleDanger = PanelHelpers:CreateSliderFrame(Name.."_ScaleLoose", Column1, "Aggro Scale:", 1.5, 1, 2, .1)
	panel.ScaleDanger:SetPoint("LEFT")
	panel.ScaleDanger:SetPoint("TOP", panel.ScaleGeneral, "BOTTOM", 0,-40)
	-- Hide Non-Elites Checkbox
	panel.ScaleIgnoreNonElite = PanelHelpers:CreateCheckButton(Name.."_ScaleIgnoreNonElite", Column1, "Ignore Non-Elites")
	panel.ScaleIgnoreNonElite:SetPoint("LEFT")
	panel.ScaleIgnoreNonElite:SetPoint("TOP", panel.ScaleDanger, "BOTTOM",0, -12)

	-------------------
	-- Aggro
	-------------------
	panel.AggroDesc = Column1:CreateFontString(Name.."_WidgetDesc", 'ARTWORK', 'GameFontNormal')
	panel.AggroDesc:SetHeight(15)
	panel.AggroDesc:SetWidth(200)
	panel.AggroDesc:SetText("Aggro Indicator Colors:")
	panel.AggroDesc:SetJustifyH("LEFT")

	panel.AggroDesc:SetPoint("LEFT", -5, 0)
	panel.AggroDesc:SetPoint("TOP", panel.ScaleIgnoreNonElite, "BOTTOM", 0,-16)

	-- Loose Units
	panel.AggroSafeColor = PanelHelpers:CreateColorBox(Name.."_AggroSafeColor", Column1, "Safe Color", 0, .5, 1, 1)
	panel.AggroSafeColor:SetPoint("LEFT", 24)
	panel.AggroSafeColor:SetPoint("TOP", panel.AggroDesc, "BOTTOM", 0,-8)

	-- Tanked Units
	panel.AggroDangerColor = PanelHelpers:CreateColorBox(Name.."_AggroDangerColor", Column1, "Danger Color", 0, .5, 1, 1)
	panel.AggroDangerColor:SetPoint("LEFT", 24)
	panel.AggroDangerColor:SetPoint("TOP", panel.AggroSafeColor, "BOTTOM", 0,-6)


	-------------------
	-- Health Text
	-------------------
	panel.HealthText = PanelHelpers:CreateDropdownFrame(Name.."_HealthText", Column1, TextModes, 1, "Health Text Mode:")
	panel.HealthText:ClearAllPoints()
	panel.HealthText:SetPoint("LEFT", Column1, -16, 0)
	panel.HealthText:SetPoint("TOP", panel.AggroDangerColor, "BOTTOM", 0, -32)

	-------------------
	-- Widgets
	-------------------

	-- Description
	panel.WidgetDesc = Column2:CreateFontString(Name.."_WidgetDesc", 'ARTWORK', 'GameFontNormal')
	panel.WidgetDesc:SetText("Indicators & Widgets:")
	panel.WidgetDesc:SetJustifyH("LEFT")
	panel.WidgetDesc:SetPoint("LEFT", -5)
	panel.WidgetDesc:SetPoint("TOP", 0, -15)
	
	-- Level
	panel.LevelText = PanelHelpers:CreateCheckButton(Name.."_WidgetLevelText", Column2, "Level Text")
	panel.LevelText:SetPoint("LEFT")
	panel.LevelText:SetPoint("TOP", panel.WidgetDesc, "BOTTOM", 0, -10)
	
	
	-- Class Icon
	panel.WidgetClassIcon = PanelHelpers:CreateCheckButton(Name.."_WidgetClassIcon", Column2, "Enemy Class Icon")
	panel.WidgetClassIcon:SetPoint("LEFT")
	panel.WidgetClassIcon:SetPoint("TOP", panel.LevelText, "BOTTOM", 0, -4)
	

	-- Selection Box
	panel.WidgetSelect = PanelHelpers:CreateCheckButton(Name.."_WidgetSelect", Column2, "Selection Box")
	panel.WidgetSelect:SetPoint("LEFT")
	panel.WidgetSelect:SetPoint("TOP", panel.WidgetClassIcon, "BOTTOM", 0, -4)

	-- Tug-o'-Threat
	panel.WidgetTug = PanelHelpers:CreateCheckButton(Name.."_WidgetTug", Column2, "Tug-o'-Threat")
	panel.WidgetTug:SetPoint("LEFT")
	panel.WidgetTug:SetPoint("TOP", panel.WidgetSelect, "BOTTOM", 0, -4)

	-- Loose/Safe Color
	panel.TugWidgetLooseColor = PanelHelpers:CreateColorBox(Name.."_TugWidgetLooseColor", Column2, "Safe Color", 0, .5, 1, 1)
	panel.TugWidgetLooseColor:ClearAllPoints()
	panel.TugWidgetLooseColor:SetPoint("LEFT", Column2, 24,0)
	panel.TugWidgetLooseColor:SetPoint("TOP", panel.WidgetTug, "BOTTOM", 0, -2)

	-- Aggro'd Color
	panel.TugWidgetAggroColor = PanelHelpers:CreateColorBox(Name.."_TugWidgetAggroColor", Column2, "Aggro Color", 0, .5, 1, 1)
	panel.TugWidgetAggroColor:ClearAllPoints()
	panel.TugWidgetAggroColor:SetPoint("LEFT", Column2, 24,0)
	panel.TugWidgetAggroColor:SetPoint("TOP", panel.TugWidgetLooseColor, "BOTTOM", 0, -4)


	-- Threat Wheel
	panel.WidgetWheel = PanelHelpers:CreateCheckButton(Name.."_WidgetWheel", Column2, "Threat Wheel")
	panel.WidgetWheel:SetPoint("LEFT")
	panel.WidgetWheel:SetPoint("TOP", panel.TugWidgetAggroColor, "BOTTOM", 0, -4)


	-- Combo Points
	panel.WidgetCombo = PanelHelpers:CreateCheckButton(Name.."_WidgetCombo", Column2, "Combo Points")
	panel.WidgetCombo:SetPoint("LEFT")
	panel.WidgetCombo:SetPoint("TOP", panel.WidgetWheel, "BOTTOM", 0, -8)

	-- Group Range
	panel.WidgetRange = PanelHelpers:CreateCheckButton(Name.."_WidgetRange", Column2, "Range Watcher")
	panel.WidgetRange:SetPoint("LEFT")
	panel.WidgetRange:SetPoint("TOP", panel.WidgetCombo, "BOTTOM", 0, -4)
								
	-- Range
	panel.RangeMode = PanelHelpers:CreateDropdownFrame(Name.."_RangeModeDropdown", Column2, RangeModes, 1, "")
	panel.RangeMode:SetPoint("LEFT")
	panel.RangeMode:SetPoint("TOP", panel.WidgetRange, "BOTTOM", 0, 0)



	-- Short Debuffs
	panel.WidgetDebuff = PanelHelpers:CreateCheckButton(Name.."_WidgetDebuff", Column2, "Debuff Tracker")
	panel.WidgetDebuff:SetPoint("LEFT")
	panel.WidgetDebuff:SetPoint("TOP", panel.RangeMode, "BOTTOM", 0, -4)


	-- [[ -----------------
	-- Debuff Tracker List
								
	panel.WidgetDebuffMode = PanelHelpers:CreateDropdownFrame("DebuffModeDropdown", Column2, DebuffModes, 1, "")
	panel.WidgetDebuffMode:SetPoint("LEFT")
	panel.WidgetDebuffMode:SetPoint("TOP", panel.WidgetDebuff, "BOTTOM", 0, 0)

	local DebuffScrollFrame = CreateFrame("ScrollFrame","DebuffScrollFrame", Column2, "UIPanelScrollFrameTemplate")
	DebuffScrollFrame:SetPoint("LEFT", 18, 0)
	DebuffScrollFrame:SetPoint("TOP", panel.WidgetDebuffMode, "BOTTOM", 0, -2)
	DebuffScrollFrame:SetHeight(75)
	DebuffScrollFrame:SetWidth(108)

	local DebuffEditBoxBorder = CreateFrame("Frame", "DebuffEditBoxBorder", DebuffScrollFrame )
	DebuffEditBoxBorder:SetPoint("TOPLEFT", 0, 5)
	DebuffEditBoxBorder:SetPoint("BOTTOMRIGHT", 3, -5)
	DebuffEditBoxBorder:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
												edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
												tile = true, tileSize = 16, edgeSize = 16, 
												insets = { left = 4, right = 4, top = 4, bottom = 4 }
												});
	DebuffEditBoxBorder:SetBackdropColor(0.05, 0.05, 0.05, 0)
	DebuffEditBoxBorder:SetBackdropBorderColor(0.2, 0.2, 0.2, 1)

	panel.WidgetDebuffList = CreateFrame("EditBox", "DebuffEditBoxList", DebuffScrollFrame)
	panel.WidgetDebuffList:SetWidth(102)
	panel.WidgetDebuffList:SetFont("Fonts\\FRIZQT__.TTF", 11, "NONE")
	panel.WidgetDebuffList:SetText("Unset")
	panel.WidgetDebuffList:SetAutoFocus(false)
	panel.WidgetDebuffList:SetTextInsets(6, 6, 0, 0)
	panel.WidgetDebuffList:SetMultiLine(true)
	
	function panel.WidgetDebuffList:GetValue() return SplitToTable(strsplit("\n", panel.WidgetDebuffList:GetText() )) end
	function panel.WidgetDebuffList:SetValue(value)  panel.WidgetDebuffList:SetText(TableToString(value)) end
	DebuffScrollFrame:SetScrollChild(panel.WidgetDebuffList)

	-- Class Icon
	--panel.WidgetClassIcon = PanelHelpers:CreateCheckButton(Name.."_WidgetClassIcon", Column2, "Enemy Class Icon")
	--panel.WidgetClassIcon:SetPoint("LEFT")
	--panel.WidgetClassIcon:SetPoint("TOP", DebuffScrollFrame, "BOTTOM", 0, -8)
	
	return panel
end
--]] -----------------

local function GetPanelValues(panel)
	local index
	for index in pairs(TidyPlatesNeonDPSVariables) do
		if panel[index] then
			TidyPlatesNeonDPSVariables[index] = panel[index]:GetValue()
			TidyPlatesNeonDPSSavedVariables[index] = TidyPlatesNeonDPSVariables[index]
		end
	end
end

local function SetPanelValues(panel)
	for index, value in pairs(TidyPlatesNeonDPSVariables) do
		if panel[index] then
			panel[index]:SetValue(value)
		end
	end
end

local function GetSavedVariables()
	local index, value
	UpdateTable(TidyPlatesNeonDPSVariables, TidyPlatesNeonDPSSavedVariables)
end

local function ApplySavedValues()
	GetSavedVariables()
	theme.options.showLevel = (TidyPlatesNeonDPSVariables.LevelText == true)
	TidyPlates:ForceUpdate()
end

local function ApplyPanelValues(panel)
	GetPanelValues(panel)
	theme.options.showLevel = (TidyPlatesNeonDPSVariables.LevelText == true)
	TidyPlates:ForceUpdate()
end

-- Login
DPSPanel = CreateInterfacePanel( "TidyPlatesNeonDPS", "Neon/DPS", "Tidy Plates: Neon", TidyPlatesNeonDPSVariables ) 
DPSPanel.ApplyButton:SetScript("OnClick", function() ApplyPanelValues(DPSPanel) end)
DPSPanel.okay = function() ApplyPanelValues(DPSPanel) end
DPSPanel.refresh = function() SetPanelValues(DPSPanel) end
		
DPSPanel:SetScript("OnEvent", function(self, event, ...) 
	if event == "PLAYER_LOGIN" then 
		InterfaceOptions_AddCategory(DPSPanel)
	elseif event == "PLAYER_ENTERING_WORLD" then 
		ApplySavedValues()
	end
	
end)
DPSPanel:RegisterEvent("PLAYER_LOGIN")
DPSPanel:RegisterEvent("PLAYER_ENTERING_WORLD")

-- Slash Command
function slash_NEONDPS(arg) InterfaceOptionsFrame_OpenToCategory(DPSPanel); end
SLASH_NEONDPS1 = '/neondps'
SlashCmdList['NEONDPS'] = slash_NEONDPS;


