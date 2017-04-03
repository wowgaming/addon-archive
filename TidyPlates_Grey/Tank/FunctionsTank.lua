local WidgetLib = TidyPlatesWidgets
local LocalVars = TidyPlatesGreyTankVariables
local theme = TidyPlatesThemeList["Grey/Tank"]
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

local function HealthTextDelegate(unit)  
	return HealthTextFunctions[LocalVars.HealthText](unit.health, unit.healthmax)
end

---------------
-- Graphics Delegates
---------------
local function TankScale(unit)
	if InCombatLockdown() and unit.reaction == "HOSTILE" and  unit.threatSituation ~= "HIGH" and unit.type == "NPC" then
		if LocalVars.ScaleIgnoreNonElite then
			if unit.isElite then return LocalVars.ScaleLoose end
		else return LocalVars.ScaleLoose end 
	end
	return LocalVars.ScaleGeneral
end
	
local function TankAlpha(unit)
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
			local loose, tanking = LocalVars.AggroLooseColor, LocalVars.AggroTankedColor
			if unit.threatSituation ~= "HIGH" then return loose.r, loose.g, loose.b
				else return tanking.r, tanking.g, tanking.b end 
			end
	end
	return unit.red, unit.green, unit.blue
end

---------------
-- Widgets
---------------
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


local function OnInitializeDelegate(plate)
	-- Tug-o-Threat
	if LocalVars.WidgetTug then
		if not plate.widgets.WidgetTug then 
			plate.widgets.WidgetTug = WidgetLib.CreateThreatLineWidget(plate)
			plate.widgets.WidgetTug:SetPoint("CENTER", plate, 0, 18)
		end
	end
	-- Threat Wheel
	if LocalVars.WidgetWheel then
		if not plate.widgets.WidgetWheel then 
			plate.widgets.WidgetWheel = WidgetLib.CreateThreatWheelWidget(plate)
			plate.widgets.WidgetWheel:SetPoint("CENTER", plate, 30, 18)
		end
	end
	-- Target Selection Box
	if LocalVars.WidgetSelect then
		if not plate.widgets.targetbox then 
			plate.widgets.targetbox = CreateTargetbox(plate)
			plate.widgets.targetbox:SetPoint("CENTER", 0, -5)
		end
	end
	-- Tanked Icon
	if LocalVars.WidgetTanked then
		if not plate.widgets.WidgetTanked then
			plate.widgets.WidgetTanked =  WidgetLib.CreateTankedWidget(plate)
			plate.widgets.WidgetTanked:SetPoint("CENTER", plate, 37, 17)
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


local function OnUpdateDelegate(plate, unit)
	-- Tug-o-Threat
	if LocalVars.WidgetTug then plate.widgets.WidgetTug:Update(unit) end
	-- Threat Wheel
	if LocalVars.WidgetWheel then plate.widgets.WidgetWheel:Update(unit) end
	-- Target Selection Box
	if LocalVars.WidgetSelect then plate.widgets.targetbox:SetTarget(unit.isTarget ) end
	-- Tanked Icon
	if LocalVars.WidgetTanked then plate.widgets.WidgetTanked:Update(unit) end	
	-- Short Debuffs
	if LocalVars.WidgetDebuff then plate.widgets.WidgetDebuff:Update(unit) end
end

---------------
-- Function Assignment - Tank Mode
---------------
theme.SetSpecialText = HealthTextDelegate
theme.SetSpecialText2 = SpellTextDelegate
theme.SetScale = TankScale
theme.SetAlpha = TankAlpha
theme.OnUpdate = OnUpdateDelegate
theme.OnInitialize = OnInitializeDelegate
theme.SetHealthbarColor = HealthColorDelegate





