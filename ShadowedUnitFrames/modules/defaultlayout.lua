local L = ShadowUF.L
local playerClass = select(2, UnitClass("player"))

local function finalizeData(config, useMerge)
	local self = ShadowUF
	-- Merges all of the parentUnit options into the child if they weren't set.
	-- if it's a table, it recurses inside the table and copies any nil values in too
	local function mergeToChild(parent, child, forceMerge)
		for key, value in pairs(parent) do
			if( type(child[key]) == "table" ) then
				mergeToChild(value, child[key], forceMerge)
			elseif( type(value) == "table" ) then
				child[key] = CopyTable(value)
			elseif( forceMerge or ( value ~= nil and child[key] == nil ) ) then
				child[key] = value
			end
		end
	end

	-- This makes sure that the unit has no values it shouldn't, for example if the defaults do not set incHeal for targettarget
	-- and I try to set incHeal table here, then it'll remove it since it can't do that.
	local function verifyTable(tbl, checkTable)
		for key, value in pairs(tbl) do
			if( type(value) == "table" ) then
				if( not checkTable[key] ) then
					tbl[key] = nil
				else
					for subKey, subValue in pairs(value) do
						if( type(subValue) == "table" ) then
							verifyTable(value, checkTable[key])
						end
					end
				end
			end
		end
	end
	
	-- Set everything
	for unit, child in pairs(config.units) do
		if( self.defaults.profile.units[unit] ) then
			if( not useMerge or ( useMerge and not self.db.profile.units[unit].enabled and self.db.profile.units[unit].height == 0 and self.db.profile.units[unit].width == 0 and self.db.profile.positions[unit].anchorPoint == "" and self.db.profile.positions[unit].point == "" ) ) then
				-- Merge the primary parent table
				mergeToChild(config.parentUnit, child)
				-- Strip any invalid tables
				verifyTable(child, self.defaults.profile.units[unit])
				-- Merge it in
				mergeToChild(child, self.db.profile.units[unit], true)
				
				-- Merge position in too
				if( useMerge and self.db.profile.positions[unit].point == "" and self.db.profile.positions[unit].relativePoint == "" and self.db.profile.positions[unit].anchorPoint == "" and self.db.profile.positions[unit].x == 0 and self.db.profile.positions[unit].y == 0 ) then
					self.db.profile.positions[unit] = config.positions[unit]
				end
			end
		end
	end

	self.db.profile.loadedLayout = true
	
	if( not useMerge ) then
		config.parentUnit = nil
		config.units = nil
		
		for key, data in pairs(config) do
			self.db.profile[key] = data
		end
	end
end

function ShadowUF:LoadDefaultLayout(useMerge)
	local config = {}
	config.bars = {
		texture = "Minimalist",
		spacing = -1.25,
		alpha = 1.0,
		backgroundAlpha = 0.20,
	}
	config.auras = {
		borderType = "light",
	}
	config.backdrop = {
		tileSize = 1,
		edgeSize = 5,
		clip = 1,
		inset = 3,
		backgroundTexture = "Chat Frame",
		backgroundColor = {r = 0, g = 0, b = 0, a = 0.80},
		borderTexture = "None",
		borderColor = {r = 0.30, g = 0.30, b = 0.50, a = 1},
	}
	config.hidden = {
		cast = false, runes = true, buffs = false, party = true, player = true, pet = true, target = true, focus = true, boss = true, arena = true
	}
	config.font = {
		name = "Myriad Condensed Web",
		size = 11,
		extra = "",
		shadowColor = {r = 0, g = 0, b = 0, a = 1.0},
		shadowX = 0.80,
		shadowY = -0.80,
	}
	
	-- Some localizations do not work with Myriad Condensed Web, need to automatically swap it to a localization that will work for it
	local SML = LibStub:GetLibrary("LibSharedMedia-3.0")
	if( GetLocale() == "koKR" or GetLocale() == "zhCN" or GetLocale() == "zhTW" or GetLocale() == "ruRU" ) then
		config.font.name = SML.DefaultMedia.font
	end
	
	config.classColors = {
		HUNTER = {r = 0.67, g = 0.83, b = 0.45},
		WARLOCK = {r = 0.58, g = 0.51, b = 0.79},
		PRIEST = {r = 1.0, g = 1.0, b = 1.0},
		PALADIN = {r = 0.96, g = 0.55, b = 0.73},
		MAGE = {r = 0.41, g = 0.8, b = 0.94},
		ROGUE = {r = 1.0, g = 0.96, b = 0.41},
		DRUID = {r = 1.0, g = 0.49, b = 0.04},
		SHAMAN = {r = 0.14, g = 0.35, b = 1.0},
		WARRIOR = {r = 0.78, g = 0.61, b = 0.43},
		DEATHKNIGHT = {r = 0.77, g = 0.12 , b = 0.23},
		PET = {r = 0.20, g = 0.90, b = 0.20},
		VEHICLE = {r = 0.23, g = 0.41, b = 0.23},
	}
	config.powerColors = {
		MANA = {r = 0.30, g = 0.50, b = 0.85}, 
		RAGE = {r = 0.90, g = 0.20, b = 0.30},
		FOCUS = {r = 1.0, g = 0.85, b = 0}, 
		ENERGY = {r = 1.0, g = 0.85, b = 0.10}, 
		HAPPINESS = {r = 0.50, g = 0.90, b = 0.70},
		RUNES = {r = 0.50, g = 0.50, b = 0.50}, 
		RUNIC_POWER = {b = 0.60, g = 0.45, r = 0.35},
		AMMOSLOT = {r = 0.85, g = 0.60, b = 0.55},
		FUEL = {r = 0.85, g = 0.47, b = 0.36},
	}
	config.healthColors = {
		tapped = {r = 0.5, g = 0.5, b = 0.5},
		red = {r = 0.90, g = 0.0, b = 0.0},
		green = {r = 0.20, g = 0.90, b = 0.20},
		static = {r = 0.70, g = 0.20, b = 0.90},
		yellow = {r = 0.93, g = 0.93, b = 0.0},
		inc = {r = 0, g = 0.35, b = 0.23},
		enemyUnattack = {r = 0.60, g = 0.20, b = 0.20},
		hostile = {r = 0.90, g = 0.0, b = 0.0},
		friendly = {r = 0.20, g = 0.90, b = 0.20},
		neutral = {r = 0.93, g = 0.93, b = 0.0},
		offline = {r = 0.50, g = 0.50, b = 0.50}
	}
	config.castColors = {
		channel = {r = 0.25, g = 0.25, b = 1.0},
		cast = {r = 1.0, g = 0.70, b = 0.30},
		interrupted = {r = 1, g = 0, b = 0},
		uninterruptible = {r = 0.71, g = 0, b = 1},
		finished = {r = 0.10, g = 1.0, b = 0.10},
	}
	config.xpColors = {
		normal = {r = 0.58, g = 0.0, b = 0.55},
		rested = {r = 0.0, g = 0.39, b = 0.88},
	}
	
	config.positions = {
		targettargettarget = {anchorPoint = "RC", anchorTo = "#SUFUnittargettarget", x = 0, y = 0}, 
		targettarget = {anchorPoint = "TL", anchorTo = "#SUFUnittarget", x = 0, y = 0}, 
		focustarget = {anchorPoint = "TL", anchorTo = "#SUFUnitfocus", x = 0, y = 0},
		party = {point = "TOPLEFT", anchorTo = "#SUFUnitplayer", relativePoint = "TOPLEFT", movedAnchor = "TL", x = 0, y = -60}, 
		focus = {anchorPoint = "RB", anchorTo = "#SUFUnittarget", x = 35, y = -4}, 
		target = {anchorPoint = "RC", anchorTo = "#SUFUnitplayer", x = 50, y = 0}, 
		player = {point = "TOPLEFT", anchorTo = "UIParent", relativePoint = "TOPLEFT", y = -25, x = 20}, 
		pet = {anchorPoint = "TL", anchorTo = "#SUFUnitplayer", x = 0, y = 0}, 
		pettarget = {anchorPoint = "C", anchorTo = "UIParent", x = 0, y = 0}, 
		partypet = {anchorPoint = "RB", anchorTo = "$parent", x = 0, y = 0},
		partytarget = {anchorPoint = "RT", anchorTo = "$parent", x = 0, y = 0},
		raid = {anchorPoint = "C", anchorTo = "UIParent", x = 0, y = 0},
		raidpet = {anchorPoint = "C", anchorTo = "UIParent", x = 0, y = 0},
		maintank = {anchorPoint = "C", anchorTo = "UIParent", x = 0, y = 0},
		maintanktarget = {anchorPoint = "RT", anchorTo = "$parent", x = 0, y = 0},
		mainassist = {anchorPoint = "C", anchorTo = "UIParent", x = 0, y = 0},
		mainassisttarget = {anchorPoint = "RT", anchorTo = "$parent", x = 0, y = 0},
		arena = {anchorPoint = "C", anchorTo = "UIParent", point = "", relativePoint = "", x = 0, y = 0},
		arenapet = {anchorPoint = "RB", anchorTo = "$parent", x = 0, y = 0},
		arenatarget = {anchorPoint = "RT", anchorTo = "$parent", x = 0, y = 0},
		boss = {anchorPoint = "C", anchorTo = "UIParent", point = "", relativePoint = "", x = 0, y = 0},
		bosstarget = {anchorPoint = "RB", anchorTo = "$parent", x = 0, y = 0},
	}
	
	-- Parent unit options that all the children will inherit unless they override it
	config.parentUnit = {
		portrait = {enabled = false, type = "3D", alignment = "LEFT", width = 0.22, height = 0.50, order = 15, fullBefore = 0, fullAfter = 100},
		auras = {
			buffs = {enabled = false, anchorPoint = "BL", size = 16, perRow = 10, x = 0, y = 0},
			debuffs = {enabled = false, anchorPoint = "BL", size = 16, perRow = 10, x = 0, y = 0},
		},
		text = {
			{width = 0.50, name = L["Left text"], anchorTo = "$healthBar", anchorPoint = "CLI", x = 3, y = 0, size = 0},
			{width = 0.60, name = L["Right text"], anchorTo = "$healthBar", anchorPoint = "CRI", x = -3, y = 0, size = 0},

			{width = 0.50, name = L["Left text"], anchorTo = "$powerBar", anchorPoint = "CLI", x = 3, y = 0, size = 0},
			{width = 0.60, name = L["Right text"], anchorTo = "$powerBar", anchorPoint = "CRI", x = -3, y = 0, size = 0},

			{width = 1, name = L["Text"], anchorTo = "$emptyBar", anchorPoint = "CLI", x = 3, y = 0, size = 0},
		},
		indicators = {
			raidTarget = {anchorTo = "$parent", anchorPoint = "C", size = 20, x = 0, y = 0},
			masterLoot = {anchorTo = "$parent", anchorPoint = "TL", size = 12, x = 16, y = -10},
			leader = {anchorTo = "$parent", anchorPoint = "TL", size = 14, x = 2, y = -12},
			pvp = {anchorTo = "$parent", anchorPoint = "TR", size = 22, x = 11, y = -21},
			ready = {anchorTo = "$parent", anchorPoint = "LC", size = 24, x = 35, y = 0},
			role = {anchorTo = "$parent", anchorPoint = "TL", size = 14, x = 30, y = -11},
			status = {anchorTo = "$parent", anchorPoint = "LB", size = 16, x = 12, y = -2},
			lfdRole = {enabled = true, anchorPoint = "BR", size = 14, x = 3, y = 14, anchorTo = "$parent"}
		},
		highlight = {size = 10},
		combatText = {anchorTo = "$parent", anchorPoint = "C", x = 0, y = 0},
		emptyBar = {background = true, height = 1, reactionType = "none", order = 0},
		healthBar = {background = true, colorType = "class", reactionType = "npc", height = 1.20, order = 10},
		powerBar = {background = true, height = 1.0, order = 20},
		druidBar = {background = true, height = 0.40, order = 25},
		xpBar = {background = true, height = 0.25, order = 55},
		castBar = {background = true, height = 0.60, order = 40, icon = "HIDE", name = {enabled = true, size = 0, anchorTo = "$parent", rank = true, anchorPoint = "CLI", x = 1, y = 0}, time = {enabled = true, size = 0, anchorTo = "$parent", anchorPoint = "CRI", x = -1, y = 0}},
		runeBar = {background = false, height = 0.40, order = 70},
		totemBar = {background = false, height = 0.40, order = 70},
	}
	
	-- Units configuration
	config.units = {
		raid = {
			width = 100,
			height = 30,
			scale = 0.85,
			unitsPerColumn = 8,
			maxColumns = 8,
			columnSpacing = 5,
			groupsPerRow = 8,
			groupSpacing = 0,
			attribPoint = "TOP",
			attribAnchorPoint = "LEFT",
			healthBar = {reactionType = "none"},
			powerBar = {height = 0.30},
			incHeal = {cap = 1},
			indicators = {
				pvp = {anchorTo = "$parent", anchorPoint = "BL", size = 22, x = 0, y = 11},
				masterLoot = {anchorTo = "$parent", anchorPoint = "TR", size = 12, x = -2, y = -10},
				role = {enabled = false, anchorTo = "$parent", anchorPoint = "BR", size = 14, x = 0, y = 14},
				ready = {anchorTo = "$parent", anchorPoint = "LC", size = 24, x = 25, y = 0},
			},
			text = {
				{text = "[(()afk() )][name]"},
				{text = "[missinghp]"},
				{text = ""},
				{text = ""},
				{text = "[(()afk() )][name]"},
			},
		},
		raidpet = {
			width = 90,
			height = 30,
			scale = 0.85,
			unitsPerColumn = 8,
			maxColumns = 8,
			columnSpacing = 5,
			groupsPerRow = 8,
			groupSpacing = 0,
			attribPoint = "TOP",
			attribAnchorPoint = "LEFT",
			healthBar = {reactionType = "none"},
			powerBar = {height = 0.30},
			incHeal = {cap = 1},
			indicators = {
				pvp = {anchorTo = "$parent", anchorPoint = "BL", size = 22, x = 0, y = 11},
				masterLoot = {anchorTo = "$parent", anchorPoint = "TR", size = 12, x = -2, y = -10},
				role = {enabled = false, anchorTo = "$parent", anchorPoint = "BR", size = 14, x = 0, y = 14},
				ready = {anchorTo = "$parent", anchorPoint = "LC", size = 24, x = 25, y = 0},
			},
			text = {
				{text = "[name]"},
				{text = "[missinghp]"},
				{text = ""},
				{text = ""},
				{text = "[name]"},
			},
		},
		
	player = {
			width = 190,
			height = 45,
			scale = 1.0,
			portrait = {enabled = true, fullAfter = 50},
			castBar = {order = 60},
			xpBar = {order = 55},
			runeBar = {enabled = true, order = 70},
			totemBar = {enabled = true, order = 70},
			auras = {
				buffs = {enabled = false, maxRows = 1, temporary = playerClass == "ROGUE" or playerClass == "SHAMAN"},
				debuffs = {enabled = false, maxRows = 1},
			},
			text = {
				{text = "[(()afk() )][name][( ()group())]"},
				{text = "[curmaxhp]"},
				{text = "[perpp]"},
				{text = "[curmaxpp]"},
				{text = "[(()afk() )][name][( ()group())]"},
			},
		},
		party = {
			width = 190,
			height = 45,
			scale = 1.0,
			attribPoint = "TOP",
			attribAnchorPoint = "LEFT",
			unitsPerColumn = 5,
			columnSpacing = 30,
			portrait = {enabled = true, fullAfter = 50},
			castBar = {order = 60},
			offset = 23,
			auras = {
				buffs = {enabled = true, maxRows = 1},
				debuffs = {enabled = true, maxRows = 1},
			},
			text = {
				{text = "[(()afk() )][name]"},
				{text = "[curmaxhp]"},
				{text = "[level( )][perpp]"},
				{text = "[curmaxpp]"},
				{text = "[(()afk() )][name]"},
			},
		},
		boss = {
			enabled = true,
			width = 160,
			height = 40,
			scale = 1.0,
			attribPoint = "TOP",
			attribAnchorPoint = "LEFT",
			offset = 20,
			auras = {
				buffs = {enabled = true, maxRows = 1, perRow = 8},
				debuffs = {enabled = true, maxRows = 1, perRow = 8},
			},
			text = {
				{text = "[name]"},
				{text = "[curmaxhp]"},
				{text = "[perpp]"},
				{text = "[curmaxpp]"},
				{text = "[name]"},
			},
			portrait = {enabled = false},
		},
		bosstarget = {
			width = 90,
			height = 25,
			scale = 1.0,
			powerBar = {height = 0.60},
			text = {
				{text = "[name]"},
				{text = "[curhp]"},
				{text = ""},
				{text = ""},
				{text = "[name]"},
			},
		},
		arena = {
			width = 170,
			height = 45,
			scale = 1.0,
			attribPoint = "TOP",
			attribAnchorPoint = "LEFT",
			portrait = {enabled = false, fullAfter = 50},
			castBar = {order = 60},
			offset = 25,
			auras = {
				buffs = {enabled = true, maxRows = 1, perRow = 9},
				debuffs = {enabled = true, maxRows = 1, perRow = 9},
			},
			text = {
				{text = "[name]"},
				{text = "[curmaxhp]"},
				{text = "[perpp]"},
				{text = "[curmaxpp]"},
				{text = "[name]"},
			},
		},
		arenapet = {
			width = 90,
			height = 25,
			scale = 1.0,
			powerBar = {height = 0.60},
			text = {
				{text = "[name]"},
				{text = "[curhp]"},
				{text = ""},
				{text = ""},
				{text = "[name]"},
			},
		},
		arenatarget = {
			width = 90,
			height = 25,
			scale = 1.0,
			powerBar = {height = 0.60},
			indicators = {
				pvp = {anchorTo = "$parent", anchorPoint = "BL", size = 22, x = 0, y = 11},
			},
			text = {
				{text = "[name]"},
				{text = "[curhp]"},
				{text = ""},
				{text = ""},
				{text = "[name]"},
			},
		},
		maintank = {
			width = 150,
			height = 40,
			scale = 1.0,
			attribPoint = "TOP",
			attribAnchorPoint = "LEFT",
			offset = 5,
			unitsPerColumn = 5,
			maxColumns = 1,
			columnSpacing = 5,
			incHeal = {cap = 1},
			portrait = {enabled = false, fullAfter = 50},
			castBar = {order = 60},
			auras = {
				buffs = {enabled = false},
				debuffs = {enabled = false},
			},
			text = {
				{text = "[(()afk() )][name]"},
				{text = "[curmaxhp]"},
				{text = "[perpp]"},
				{text = "[curmaxpp]"},
				{text = "[(()afk() )][name]"},
			},
		},
		maintanktarget = {
			width = 150,
			height = 40,
			scale = 1.0,
			auras = {
				buffs = {enabled = false},
				debuffs = {enabled = false},
			},
			text = {
				{text = "[(()afk() )][name]"},
				{text = "[curmaxhp]"},
				{text = "[classification( )][perpp]", width = 0.50},
				{text = "[curmaxpp]", anchorTo = "$powerBar", width = 0.60},
				{text = "[(()afk() )][name]"},
			},
		},
		mainassist = {
			width = 150,
			height = 40,
			scale = 1.0,
			attribPoint = "TOP",
			attribAnchorPoint = "LEFT",
			offset = 5,
			unitsPerColumn = 5,
			maxColumns = 1,
			columnSpacing = 5,
			incHeal = {cap = 1},
			portrait = {enabled = false, fullAfter = 50},
			castBar = {order = 60},
			auras = {
				buffs = {enabled = false},
				debuffs = {enabled = false},
			},
			text = {
				{text = "[(()afk() )][name]"},
				{text = "[curmaxhp]"},
				{text = "[level( )][perpp]"},
				{text = "[curmaxpp]"},
				{text = "[(()afk() )][name]"},
			},
		},
		mainassisttarget = {
			width = 150,
			height = 40,
			scale = 1.0,
			auras = {
				buffs = {enabled = false},
				debuffs = {enabled = false},
			},
			text = {
				{text = "[(()afk() )][name]"},
				{text = "[curmaxhp]"},
				{text = "[level( )][classification( )][perpp]", width = 0.50},
				{text = "[curmaxpp]", anchorTo = "$powerBar", width = 0.60},
				{text = "[(()afk() )][name]"},
			},
		},
		partypet = {
			width = 90,
			height = 25,
			scale = 1.0,
			powerBar = {height = 0.60},
			text = {
				{text = "[name]"},
				{text = "[curhp]"},
				{text = ""},
				{text = ""},
				{text = "[name]"},
			},
		},
		partytarget = {
			width = 90,
			height = 25,
			scale = 1.0,
			powerBar = {height = 0.60},
			indicators = {
				pvp = {anchorTo = "$parent", anchorPoint = "BL", size = 22, x = 0, y = 11},
			},
			text = {
				{text = "[name]"},
				{text = "[curhp]"},
				{text = ""},
				{text = ""},
				{text = "[name]"},
			},
		},
		target = {
			width = 190,
			height = 45,
			scale = 1.0,
			portrait = {enabled = true, alignment = "RIGHT", fullAfter = 50},
			castBar = {order = 60},
			comboPoints = {anchorTo = "$parent", order = 60, anchorPoint = "BR", x = -3, y = 8, size = 14, spacing = -4, growth = "LEFT", isBar = true},
			indicators = {
				lfdRole = {enabled = false}
			},
			auras = {
				buffs = {enabled = true},
				debuffs = {enabled = true},
			},
			text = {
				{text = "[(()afk() )][name]"},
				{text = "[curmaxhp]"},
				{text = "[level( )][classification( )][perpp]", width = 0.50},
				{text = "[curmaxpp]", anchorTo = "$powerBar", width = 0.60},
				{text = "[(()afk() )][name]"},
			},
		},
		pet = {
			width = 190,
			height = 30,
			scale = 1.0,
			powerBar = {height = 0.70},
			healthBar = {reactionType = "none"},
			portrait = {enabled = false, fullAfter = 50},
			castBar = {order = 60},
			indicators = {
				happiness = {enabled = false, anchorTo = "$parent", anchorPoint = "BR", size = 14, x = 3, y = 13},
			},
			text = {
				{text = "[name]"},
				{text = "[curmaxhp]"},
				{text = "[perpp]"},
				{text = "[curmaxpp]"},
				{text = "[name]"},
			},
		},
		pettarget = {
			width = 190,
			height = 30,
			scale = 1.0,
			powerBar = {height = 0.70},
			indicators = {
			},
			text = {
				{text = "[name]"},
				{text = "[curmaxhp]"},
				{text = "[perpp]"},
				{text = "[curmaxpp]"},
				{text = "[name]"},
			},
		},
		focus = {
			width = 120,
			height = 28,
			scale = 1.0,
			powerBar = {height = 0.60},
			portrait = {enabled = false, fullAfter = 50},
			castBar = {order = 60},
			indicators = {
				lfdRole = {enabled = false},
			},
			text = {
				{text = "[(()afk() )][name]"},
				{text = "[curhp]"},
				{text = "[perpp]"},
				{text = "[curpp]"},
				{text = "[(()afk() )][name]"},
			},
		},
		focustarget = {
			width = 120,
			height = 25,
			scale = 1.0,
			powerBar = {height = 0.60},
			portrait = {alignment = "RIGHT"},
			indicators = {
				pvp = {anchorTo = "$parent", anchorPoint = "BL", size = 22, x = -3, y = 11},
			},
			text = {
				{text = "[(()afk() )][name]"},
				{text = "[curhp]"},
				{text = ""},
				{text = ""},
				{text = "[(()afk() )][name]"},
			},
		},
		targettarget = {
			width = 110,
			height = 30,
			scale = 1.0,
			powerBar = {height = 0.6},
			portrait = {alignment = "RIGHT"},
			indicators = {
				pvp = {anchorTo = "$parent", anchorPoint = "BL", size = 22, x = -3, y = 11},
			},
			text = {
				{text = "[name]"},
				{text = "[curhp]"},
				{text = "[perpp]"},
				{text = "[curpp]"},
			},
		},
		targettargettarget = {
			width = 80,
			height = 30,
			scale = 1.0,
			powerBar = {height = 0.6},
			portrait = {alignment = "RIGHT"},
			indicators = {
				pvp = {anchorTo = "$parent", anchorPoint = "BL", size = 22, x = -3, y = 11},
			},
			text = {
				{text = "[name]", width = 1.0},
				{text = ""},
				{text = ""},
				{text = ""},
			},
		},
	}
	
	finalizeData(config, useMerge)
end
	
