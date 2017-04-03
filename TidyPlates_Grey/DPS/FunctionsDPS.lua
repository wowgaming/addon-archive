local WidgetLib = TidyPlatesWidgets
local LocalVars = TidyPlatesGreyDPSVariables
local theme = TidyPlatesThemeList["Grey/DPS"]
local valueToString = TidyPlatesUtility.abbrevNumber

---------------
-- Text Delegates
---------------

local function SpellTextDelegate(unit)
	local spellname
	if unit.isCasting then 
		spellname = UnitCastingInfo("target") or UnitChannelInfo("target")
		return spellname
	else return "" end
end

local HealthTextFunctions = {
	--HEALTH_NONE
	function (health, healthmax) return "" end,
	--HEALTH_PCT
	function (health, healthmax) if health ~= healthmax then return ceil(100*(health/healthmax)).."%" else return nil end end,
	--HEALTH_TOTAL
	function (health, healthmax) return valueToString(health) end,
	--HEALTH_DEF
	function (health, healthmax) if health ~= healthmax then return "-"..valueToString(healthmax - health) end end,
	--HEALTH_TOT_PCT
	function (health, healthmax) return valueToString(health).." / "..valueToString(healthmax).." ("..ceil(100*(health/healthmax)).."%)" end,
	--Health_Total_Pct_Def
	function (health, healthmax) return "+"..valueToString(health).." ("..ceil(100*(health/healthmax)).."%) -"..valueToString(healthmax - health) end,
}


local function HealthTextDelegate(unit) return HealthTextFunctions[LocalVars.HealthText](unit.health, unit.healthmax)end

---------------
-- Graphics Delegates
---------------
local function DpsScale(unit)
	if InCombatLockdown() and unit.reaction ~= "FRIENDLY" and  unit.threatSituation ~= "LOW" and unit.type == "NPC" then
		if LocalVars.ScaleIgnoreNonElite then
			if unit.isElite then return LocalVars.ScaleDanger end
		else return LocalVars.ScaleDanger end 
	end
	return LocalVars.ScaleGeneral
end
	
local function DpsAlpha(unit)
	if unit.isTarget then return 1
	else 	
		if unit.name == "Fanged Pit Viper" then return 0 end
		if LocalVars.OpacityHideNeutral and unit.reaction == "NEUTRAL" then return 0 end
		if LocalVars.OpacityHideNonElites and not unit.isElite then return 0 end
		if not UnitExists("target") then return 1 end
		return LocalVars.OpacityNonTarget, true
	end
end


local function HealthColorDelegate(unit)	
	if  LocalVars.AggroHealth then
		if InCombatLockdown() and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
			local danger, safe = LocalVars.AggroDangerColor, LocalVars.AggroSafeColor
			if unit.threatSituation ~= "LOW" then return danger.r, danger.g, danger.b
				else return safe.r, safe.g, safe.b end 
			end
	end
	return unit.red, unit.green, unit.blue
end

---------------
-- Widgets
---------------

-- Custom Widget
local function CreateTargetbox(frame)
	local icon = frame:CreateTexture(nil, 'OVERLAY', frame)
	icon:SetTexture("Interface\\Addons\\TidyPlates_Grey\\Media\\TargetBox")
	icon:SetWidth(128)
	icon:SetHeight(64)
	icon:Hide()
	icon.SetTarget = function (self, value) 
		if value then icon:Show() else icon:Hide() end 
	end
	return icon
end

-- Init widgets
local function OnInitializeDelegate(plate)
	-- Tug-o-Threat
	if LocalVars.WidgetTug then
		if not plate.widgets.WidgetTug then 		
			plate.widgets.WidgetTug = WidgetLib.CreateThreatLineWidget(plate)
			plate.widgets.WidgetTug:SetPoint("CENTER", plate, 0, 18)
		end
	end
	-- Combo Point Wheel
	if LocalVars.WidgetCombo then
		if not plate.widgets.WidgetCombo then 
			plate.widgets.WidgetCombo = WidgetLib.CreateComboPointWidget(plate)
			--plate.widgets.WidgetCombo:SetPoint("CENTER", plate, 25, 27)
			plate.widgets.WidgetCombo:SetPoint("CENTER", plate, 0, 27)
			plate.widgets.WidgetCombo:SetFrameLevel(plate:GetFrameLevel()+2)
		end
	end	
	-- Target Selection Box
	if LocalVars.WidgetSelect then
		if not plate.widgets.WidgetSelect then 
			plate.widgets.WidgetSelect = CreateTargetbox(plate)
			plate.widgets.WidgetSelect:SetPoint("CENTER", 0, -5)
		end
	end
	
	-- Short Debuffs
	if LocalVars.WidgetDebuff then
		if not plate.widgets.WidgetDebuff then 
			plate.widgets.WidgetDebuff = WidgetLib.CreateAuraWidget(plate)
			plate.widgets.WidgetDebuff:SetPoint("CENTER", plate, 15, 35)
			plate.widgets.WidgetDebuff:SetFrameLevel(plate:GetFrameLevel())
			--plate.widgets.WidgetDebuff:SetScale(.85)
		end
	end
	
end

-- Update widgets
local function OnUpdateDelegate(plate, unit)
	-- Tug-o-Threat
	if LocalVars.WidgetTug then plate.widgets.WidgetTug:Update(unit) end
	-- Combo Point Wheel
	if LocalVars.WidgetCombo then plate.widgets.WidgetCombo:Update(unit) end	
	-- Target Selection Box
	if LocalVars.WidgetSelect then plate.widgets.WidgetSelect:SetTarget(unit.isTarget) end
	-- Short Debuffs
	if LocalVars.WidgetDebuff then plate.widgets.WidgetDebuff:Update(unit) end
end

---------------
-- Function Assignment - Tank Mode
---------------
theme.SetSpecialText = HealthTextDelegate
theme.SetSpecialText2 = SpellTextDelegate
theme.SetScale = DpsScale
theme.SetAlpha = DpsAlpha
theme.OnUpdate = OnUpdateDelegate
theme.OnInitialize = OnInitializeDelegate
theme.SetHealthbarColor = HealthColorDelegate





