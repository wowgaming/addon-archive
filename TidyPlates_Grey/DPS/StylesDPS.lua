-----------------------------------------------------
-- Tidy Plates: Grey\DPS - Theme Definition
-----------------------------------------------------
TidyPlatesThemeList["Grey/DPS"] = {}

---------------
-- Config
---------------
TidyPlatesGreyDPSVariables = {
	OpacityNonTarget = .5,
	OpacityHideNeutral = false,
	OpacityHideNonElites = false,
	ScaleGeneral = 1,
	ScaleDanger = 1.5,
	ScaleIgnoreNonElite = false,
	WidgetTug = true,
	WidgetCombo = false,
	WidgetSelect = true,
	WidgetDebuff = false,
	LevelText = false,
	HealthText = 1,
	AggroHealth = false,
	AggroBorder = true,								
	AggroSafeColor = {r = .6, g = 1, b = 0, a = 1,},
	AggroDangerColor = {r = 1, g = 0, b = 0, a= 1,},
}

---------------
-- Style Assignment (Uses default boxy art)
---------------
local theme = TidyPlatesThemeList["Grey/DPS"]

theme.hitbox = { width = 140, height = 35, }
theme.name = { width = 100, }
theme.options = { showLevel = false, showSpecialText = true, showSpecialText2 = true, showAggroGlow = true, }
theme.threatcolor = {
	LOW = {r = .6, g = 1, b = 0, a = 1,},
	MEDIUM = {r = .6, g = 1, b = 0, a = 1,},
	HIGH = {r = 1, g = 0, b = 0, a= 1,},  }







