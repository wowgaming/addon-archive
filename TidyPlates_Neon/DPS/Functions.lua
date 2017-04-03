local WidgetLib = TidyPlatesWidgets
local LocalVars = TidyPlatesNeonDPSVariables
local theme = TidyPlatesThemeList["Neon/DPS"]
local valueToString = TidyPlatesUtility.abbrevNumber


---------------
-- Target Widget
---------------
local targetwidgetimage = "Interface\\Addons\\TidyPlates_Neon\\Media\\Neon_Select"
local function CreateTargetWidget(frame)
	local icon = frame.bars.healthbar:CreateTexture(nil, 'BACKGROUND')
	icon:SetTexture(targetwidgetimage)
	icon:SetWidth(128)
	icon:SetHeight(32)
	icon:Hide()
	icon.SetTarget = function (self, value) 
		if value then icon:Show() else icon:Hide() end 
	end
	return icon
end

---------------
-- Locator Widget
---------------
--[[
	local HandleEvent, EventWatch, lastMouseover

	function HandleEvent()
		
		if UnitIsUnit("mouseover", "pet") or UnitInRaid("mouseover") or UnitInParty("mouseover") then
			
			lastMouseover = UnitName("mouseover")
			print("Mouseover", lastMouseover)
		else lastMouseover = nil end
	end

	EventWatch = CreateFrame("Frame")
	EventWatch:SetScript("OnEvent", HandleEvent)
	EventWatch:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
--]]

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
	--Level
	function (health, healthmax, level) return level end,
}

local function HealthTextDelegate(unit)  
	return HealthTextFunctions[LocalVars.HealthText](unit.health, unit.healthmax, unit.level)
end

---------------
-- Graphics Delegates
---------------
local function DPSScale(unit)
	--if unit.name == "Relikan" then return 1.4 end

	if InCombatLockdown() and unit.reaction == "HOSTILE" and  unit.threatSituation ~= "LOW" and unit.type == "NPC" then
		if LocalVars.ScaleIgnoreNonElite then
			if unit.isElite then return LocalVars.ScaleDanger end
		else return LocalVars.ScaleDanger end 
	-- TESTING
	--elseif unit.reaction == "FRIENDLY" then
	--	if unit.name == UnitName("mouseover") and not unit.isMouseover then return LocalVars.ScaleGeneral*1.3 end
	-- TESTING
	end
	return LocalVars.ScaleGeneral
end
	
local function DPSAlpha(unit)

	if unit.isTarget then return 1
	else 	
		if unit.name == "Fanged Pit Viper" then return 0 end
		if LocalVars.OpacityHideNeutral and unit.reaction == "NEUTRAL" then return 0 end
		if LocalVars.OpacityHideNonElites and not unit.isElite then return 0 end
		if not UnitExists("target") then return 1 end
		return LocalVars.OpacityNonTarget, true
	end
	

end

local currentcolor
local function HealthColorDelegate(unit)
	if InCombatLockdown() and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
	--if InCombatLockdown() and unit.reaction ~= "FRIENDLY" then
			if unit.threatSituation ~= "LOW"  then 
				currentcolor = LocalVars.AggroDangerColor
				return currentcolor.r, currentcolor.g, currentcolor.b
			else 
				currentcolor = LocalVars.AggroSafeColor
				return currentcolor.r, currentcolor.g, currentcolor.b 
			end

	end
	return unit.red, unit.green, unit.blue
end

---------------
-- Widgets
---------------

local DEBUFFMODE_ALL, DEBUFFMODE_FILTER = 1, 2

local function DebuffFilter(debuff)
	if LocalVars.WidgetDebuffMode == DEBUFFMODE_FILTER then
		if LocalVars.WidgetDebuffList[debuff.name] then return true end
	else return true end
	--if debuff.duration < 50  then return true end
end


local function OnInitializeDelegate(plate)
	-- Tug-o-Threat
	if LocalVars.WidgetTug then
		if not plate.widgets.WidgetTug then 
			plate.widgets.WidgetTug = WidgetLib.CreateThreatLineWidget(plate)
			plate.widgets.WidgetTug:SetPoint("CENTER", plate, 0, 4)
			plate.widgets.WidgetTug._LowColor = LocalVars.TugWidgetLooseColor
			plate.widgets.WidgetTug._HighColor = LocalVars.TugWidgetAggroColor
		end
	end
	
	-- Target Selection Box
	if LocalVars.WidgetSelect then
		if not plate.widgets.targetbox then 
			plate.widgets.targetbox = CreateTargetWidget(plate)
			plate.widgets.targetbox:SetPoint("CENTER", 0, 0)
		end
	end
	
	-- Threat Wheel
	if LocalVars.WidgetWheel then
		if not plate.widgets.WidgetWheel then 
			plate.widgets.WidgetWheel = WidgetLib.CreateThreatWheelWidget(plate)
			--plate.widgets.WidgetWheel:SetPoint("CENTER", plate, 30, 18)
			plate.widgets.WidgetWheel:SetPoint("CENTER", plate, 36, 12)
		end
	end
	
	-- Combo Point Wheel
	if LocalVars.WidgetCombo then
		if not plate.widgets.WidgetCombo then 
			plate.widgets.WidgetCombo = WidgetLib.CreateComboPointWidget(plate)
			plate.widgets.WidgetCombo:SetPoint("CENTER", plate, 0, 10)
			plate.widgets.WidgetCombo:SetFrameLevel(plate:GetFrameLevel()+2)
		end
	end	
	
	-- Short Debuffs
	if LocalVars.WidgetDebuff then
		if not plate.widgets.AuraIcon then
			plate.widgets.AuraIcon =  WidgetLib.CreateAuraWidget(plate)
			--plate.widgets.AuraIcon:SetPoint("CENTER", plate, 0, 28)
			plate.widgets.AuraIcon:SetPoint("CENTER", plate, 15, 20)
			plate.widgets.AuraIcon:SetFrameLevel(plate:GetFrameLevel())
			
						
			-- For Filtering
			plate.widgets.AuraIcon.Filter = DebuffFilter
			
		end
	end
	-- Class 
	if LocalVars.WidgetClassIcon and (not plate.widgets.ClassWidget) then 
		plate.widgets.ClassWidget = WidgetLib.CreateClassWidget(plate)
		plate.widgets.ClassWidget:SetPoint("TOP", plate, 0, 3)
		plate.widgets.ClassWidget:SetScale(1.2)
	end
		-- Range
	if LocalVars.WidgetRange and (not plate.widgets.RangeWidget) then
			plate.widgets.RangeWidget = WidgetLib.CreateRangeWidget(plate)
			plate.widgets.RangeWidget:SetPoint("CENTER", 0, 0)
	end
	
	--[[
	if not plate.widgets.BossDebuffWidget then 
		plate.widgets.BossDebuffWidget = WidgetLib.CreateBossDebuffWidget(plate)
		plate.widgets.BossDebuffWidget:SetPoint("CENTER", plate, 0, 10)
	end
	--]]
end


local function OnUpdateDelegate(plate, unit)
	-- Tug-o-Threat
	if LocalVars.WidgetTug then plate.widgets.WidgetTug:Update(unit) end
	-- Target Selection Box
	if LocalVars.WidgetSelect then plate.widgets.targetbox:SetTarget(unit.isTarget) end
	-- Short Debuffs
	if LocalVars.WidgetDebuff then plate.widgets.AuraIcon:Update(unit) 	end
	-- Combo Points
	if LocalVars.WidgetCombo then plate.widgets.WidgetCombo:Update(unit) end
	-- Range
	if LocalVars.WidgetRange then plate.widgets.RangeWidget:Update(unit) end
	-- Threat Wheel
	if LocalVars.WidgetWheel then plate.widgets.WidgetWheel:Update(unit) end
	-- Class Icon
	if LocalVars.WidgetClassIcon then plate.widgets.ClassWidget:Update(unit) end
	
	--plate.widgets.BossDebuffWidget:Update(unit)
end

---------------
-- Function Assignment - DPS Mode
---------------
theme.SetSpecialText = SpellTextDelegate
theme.SetSpecialText2 = HealthTextDelegate
theme.SetScale = DPSScale
theme.SetAlpha = DPSAlpha
theme.OnUpdate = OnUpdateDelegate
theme.OnInitialize = OnInitializeDelegate
theme.SetHealthbarColor = HealthColorDelegate




