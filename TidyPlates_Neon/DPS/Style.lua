-----------------------------------------------------
-- Tidy Plates: Neon/DPS - Theme Definition
-----------------------------------------------------
TidyPlatesThemeList["Neon/DPS"] = {}

---------------
-- Config
---------------
TidyPlatesNeonDPSVariables = {
	OpacityNonTarget = .5,
	OpacityHideNeutral = false,
	OpacityHideNonElites = false,
	ScaleGeneral = 1,
	ScaleDanger = 1.2,
	ScaleIgnoreNonElite = false,
	WidgetTug = true,
	WidgetSelect = true,
	WidgetCombo = false,
	WidgetDebuff = true,
	WidgetDebuffList = { ["Rip"] = true, ["Rake"] = true, },
	WidgetDebuffMode = 1,
	WidgetRange	= false,
	WidgetWheel = false,
	WidgetClassIcon = false,
	RangeMode = 1,
	HealthText = 1,
	LevelText = false,
	TugWidgetLooseColor = { r = .14, g = .75, b = 1},
	TugWidgetAggroColor = {r = 1, g = .67, b = .14},
	AggroSafeColor = {r = 15/255, g = 133/255, b = 255/255},
	AggroDangerColor = {r = 255/255, g = 128/255, b = 0,},
}


---------------
-- Style Assignment (Uses default art)
---------------
local artpath = "Interface\\Addons\\TidyPlates_Neon\\Media\\"
local castadjust = -21
local nameadjust = -8
local theme = TidyPlatesThemeList["Neon/DPS"]

theme.hitbox = {
	width = 105,
	height = 20,
}

theme.frame = {
	x = 0,
	y = 4,
}

theme.healthborder = {
	texture		 =				artpath.."Neon_HealthOverlay",
	glowtexture =					artpath.."Neon_Highlight",
	elitetexture =					artpath.."Neon_HealthOverlayEliteStar",
	width = 128,
	height = 32,
	y = 0,
}

theme.raidicon = {
	width = 32,
	height = 32,
	x = -48,
	y = 0,
	anchor = "CENTER",
}

theme.healthbar = {
	texture =					 artpath.."Neon_Bar",
	width = 100,
	height = 32,
	x = 0,
	y = 0,
}

theme.castborder = {
	texture =					artpath.."Neon_CastOverlayBlue",
	width = 128,
	height = 32,
	x = 0,
	y = castadjust,
}

theme.castnostop = {
	texture =					artpath.."Neon_CastOverlayRed",
	width = 128,
	height = 32,
	x = 0,
	y = castadjust,
}


theme.castbar = {
	texture =					 artpath.."Neon_Bar",
	width = 100,
	height = 32,
	x = 0,
	y = castadjust,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
}

theme.threatborder = {
	texture =				artpath.."Neon_Empty",
	elitetexture =			artpath.."Neon_Empty",
	width = 8,
	height = 8,
}

theme.spellicon = {
	width = 17,
	height = 17,
	x = 26,
	y = -3+castadjust,
	anchor = "CENTER",
}

theme.name = {
	size = 11,
	width = 150,
	height = 11,
	x = 0,
	y = nameadjust,
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	shadow = true,
}

theme.level = {
	size = 9,
	width = 22,
	height = 11,
	x = 5,
	y = 5,
	align = "LEFT",
	anchor = "LEFT",
	vertical = "CENTER",
	flags = "OUTLINE",
	shadow = false,
}

theme.dangerskull = {
	width = 14,
	height = 14,
	x = 5,
	y = 5,
	anchor = "LEFT",
}

theme.specialText = {
	size = 11,
	width = 150,
	height = 11,
	x = 26,
	y = -19+castadjust,
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	shadow = true,
}

theme.specialText2 = {
	size = 9,
	width = 150,
	height = 11,
	x = 0,
	y = 1,
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	shadow = false,
	flags = "OUTLINE",
}

theme.options = {
	showName = true,
	showLevel = false,
	showDangerSkull = true,
	showSpecialText = true,
	showSpecialText2 = true,
	showSpecialArt = true,
	useCustomHealthbarColor = true,
	forceAlpha = true,
}






