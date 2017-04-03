local WidgetLib = TidyPlatesWidgets
local LocalVars = TidyPlatesNeonTankVariables
local theme = TidyPlatesThemeList["Neon/Tank"]
local valueToString = TidyPlatesUtility.abbrevNumber


---------------
-- Target Widget
---------------
local targetwidgetimage = "Interface\\Addons\\TidyPlates_Neon\\Media\\Neon_Select"
local function CreateTargetWidget(frame)
	local icon = frame.bars.healthbar:CreateTexture(nil, 'BACKGROUND', frame)
	icon:SetTexture(targetwidgetimage)
	icon:SetWidth(128)
	icon:SetHeight(32)
	icon:Hide()
	icon.SetTarget = function (self, value) 
		if value then icon:Show() else icon:Hide() end 
	end
	return icon
end

--[[
-- From grey
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
--]]

---------------
-- Text Delegates
---------------

local function SpellTextDelegate(unit)
	local spellname
	if unit.isCasting then 
		spellname = UnitCastingInfo("target") or UnitChannelInfo("target") or ""
		return spellname
	else return "" end
end

local HealthTextFunctions = {
	--HEALTH_NONE
	function (health, healthmax) return "" end,
	--HEALTH_PCT
	function (health, healthmax) if health ~= healthmax then return "%"..ceil(100*(health/healthmax)) else return nil end end,
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
local function TankScale(unit)
	
	
	if InCombatLockdown() and unit.reaction == "HOSTILE" and  unit.threatSituation ~= "HIGH" and unit.type == "NPC"  then
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

local currentcolor
local safecolor = {r = 0, g = 1, b = .2}
local unsafecolor = {r = 1, g = .2, b = 1}
local function HealthColorDelegate(unit)
	if LocalVars.AggroHealth then
		if InCombatLockdown() and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
				if unit.threatSituation ~= "HIGH" then 
					currentcolor = LocalVars.AggroLooseColor
					return currentcolor.r, currentcolor.g, currentcolor.b
				else 
					currentcolor = LocalVars.AggroTankedColor
					--[[ Testing Raid Filter
					if unit.isMouseover then 
						if GetPartyAssignment("MAINTANK", "mouseovertarget") then
						--if UnitName("mouseovertarget") == "Boognish" then currentcolor = safecolor
						else currentcolor = unsafecolor end 
					elseif unit.isTarget then
						if GetPartyAssignment("MAINTANK", "targettarget") then
						--if UnitName("targettarget") == "Boognish" then
							currentcolor = safecolor
						else currentcolor = unsafecolor end
					end
					--]]
					--				End testing Raid Filter
					return currentcolor.r, currentcolor.g, currentcolor.b 
				end
		end
	end
	return unit.red, unit.green, unit.blue
end

local function ThreatColorDelegate(unit)
	if LocalVars.AggroBorder then
		if InCombatLockdown() and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
			if unit.threatSituation ~= "HIGH" then 
				currentcolor = LocalVars.AggroLooseColor
				--print("HIGH")
				return currentcolor.r, currentcolor.g, currentcolor.b, 1
			end
		end
	end
	return 0, 0, 0, 0
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
	if LocalVars.WidgetTug and (not plate.widgets.WidgetTug) then 
			plate.widgets.WidgetTug = WidgetLib.CreateThreatLineWidget(plate)
			plate.widgets.WidgetTug:SetPoint("CENTER", plate, 0, 4)
			plate.widgets.WidgetTug._LowColor = LocalVars.TugWidgetLooseColor
			plate.widgets.WidgetTug._HighColor = LocalVars.TugWidgetAggroColor
			plate.widgets.WidgetTug._TankedColor = LocalVars.TugWidgetSafeColor
	end
	
	-- Target Selection Box
	if LocalVars.WidgetSelect and (not plate.widgets.targetbox) then 
			plate.widgets.targetbox = CreateTargetWidget(plate)
			plate.widgets.targetbox:SetPoint("CENTER", 0, 0)
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
	
	-- Threat Wheel
	if LocalVars.WidgetWheel then
		if not plate.widgets.WidgetWheel then 
			plate.widgets.WidgetWheel = WidgetLib.CreateThreatWheelWidget(plate)
			--plate.widgets.WidgetWheel:SetPoint("CENTER", plate, 30, 18)
			plate.widgets.WidgetWheel:SetPoint("CENTER", plate, 36, 12)
		end
	end
	
	-- Range
	if LocalVars.WidgetRange and (not plate.widgets.Range) then
			plate.widgets.Range = WidgetLib.CreateRangeWidget(plate)
			plate.widgets.Range:SetPoint("CENTER", 0, 0)
	end
	-- Mob Note
	--[[
	if LocalVars.WidgetMobNote and (not plate.widgets.NoteWidget) then 
		plate.widgets.NoteWidget = WidgetLib.CreateNoteWidget(plate)
		plate.widgets.NoteWidget:SetPoint("CENTER", plate, 0, 42)
	end
	--]]
	
		-- Combo Point Wheel
	if LocalVars.WidgetCombo then
		if not plate.widgets.WidgetCombo then 
			plate.widgets.WidgetCombo = WidgetLib.CreateComboPointWidget(plate)
			plate.widgets.WidgetCombo:SetPoint("CENTER", plate, 0, 10)
			plate.widgets.WidgetCombo:SetFrameLevel(plate:GetFrameLevel()+2)
		end
	end	
	
	-- Testing
	--plate.widgets.BossWidget = WidgetLib.CreateBossDebuffWidget(plate)
	--plate.widgets.BossWidget:SetPoint("CENTER", 0, 10)

	
end

local RangeModeRef = { 9, 15, 28, 40 }

local function OnUpdateDelegate(plate, unit)	
	-- Tug-o-Threat
	if LocalVars.WidgetTug then plate.widgets.WidgetTug:Update(unit) end
	-- Target Selection Box
	if LocalVars.WidgetSelect then plate.widgets.targetbox:SetTarget(unit.isTarget) end
	-- Short Debuffs
	if LocalVars.WidgetDebuff then plate.widgets.AuraIcon:Update(unit) 	end
	-- Range Check
	if LocalVars.WidgetRange then plate.widgets.Range:Update(unit,RangeModeRef[LocalVars.RangeMode]) end
	-- Threat Wheel
	if LocalVars.WidgetWheel then plate.widgets.WidgetWheel:Update(unit) end
	-- Class Icon
	if LocalVars.WidgetClassIcon then plate.widgets.ClassWidget:Update(unit) end
	-- Combo Points
	if LocalVars.WidgetCombo then plate.widgets.WidgetCombo:Update(unit) end
	
	--plate.widgets.BossWidget:Update()
end

local function ContextDelegate(unit)
	print(unit.name, unit.guid)
end

---------------
-- Function Assignment - Tank Mode
---------------
theme.SetSpecialText = SpellTextDelegate
theme.SetSpecialText2 = HealthTextDelegate
theme.SetScale = TankScale
theme.SetAlpha = TankAlpha
theme.OnUpdate = OnUpdateDelegate
theme.OnInitialize = OnInitializeDelegate
theme.SetHealthbarColor = HealthColorDelegate
theme.SetThreatColor = ThreatColorDelegate
--theme.OnContextUpdate = ContextDelegate




