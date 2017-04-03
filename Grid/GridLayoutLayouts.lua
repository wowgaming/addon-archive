--[[--------------------------------------------------------------------
	GridLayoutLayouts.lua
	Registers some layouts with GridLayout.
----------------------------------------------------------------------]]

local _, ns = ...
local L = ns.L

local GridLayout = Grid:GetModule("GridLayout")

GridLayout:AddLayout(L["None"], {})

GridLayout:AddLayout(L["By Group 5"], {
	defaults = {
		-- nameList = "",
		-- groupFilter = "",
		-- sortMethod = "INDEX", -- or "NAME"
		-- sortDir = "ASC", -- or "DESC"
		-- strictFiltering = false,
		-- unitsPerColumn = 5, -- treated specifically to do the right thing when available
		-- maxColumns = 5, -- mandatory if unitsPerColumn is set, or defaults to 1
		-- isPetGroup = true, -- special case, not part of the Header API
	},
	[1] = {
		showParty = true,
		showRaid = false,
		sortMethod = "INDEX",
	},
})

GridLayout:AddLayout(L["By Group 5 w/Pets"], {
	[1] = {
		showParty = true,
		showRaid = false,
		sortMethod = "INDEX",
	},
	[2] = {
		showParty = true,
		showRaid = false,
		sortMethod = "INDEX",

		isPetGroup = true,
		unitsPerColumn = 5,
		maxColumns = 5,
	},
})

GridLayout:AddLayout(L["By Group 10"], {
	[1] = {
		groupFilter = "1",
	},
	[2] = {
		groupFilter = "2",
	},
})

GridLayout:AddLayout(L["By Group 10 w/Pets"], {
	[1] = {
		groupFilter = "1",
	},
	[2] = {
		groupFilter = "2",
	},
	[3] = {
		groupFilter = "1,2",
		isPetGroup = true,
		unitsPerColumn = 5,
		maxColumns = 5,
	},
})

GridLayout:AddLayout(L["By Group 15"], {
	[1] = {
		groupFilter = "1",
	},
	[2] = {
		groupFilter = "2",
	},
	[3] = {
		groupFilter = "3",
	},
})

GridLayout:AddLayout(L["By Group 15 w/Pets"], {
	[1] = {
		groupFilter = "1",
	},
	[2] = {
		groupFilter = "2",
	},
	[3] = {
		groupFilter = "3",
	},
	[4] = {
		groupFilter = "1,2,3",
		isPetGroup = true,
		unitsPerColumn = 5,
		maxColumns = 5,
	},
})

GridLayout:AddLayout(L["By Group 25"], {
	[1] = {
		groupFilter = "1",
	},
	[2] = {
		groupFilter = "2",
	},
	[3] = {
		groupFilter = "3",
	},
	[4] = {
		groupFilter = "4",
	},
	[5] = {
		groupFilter = "5",
	},
})

GridLayout:AddLayout(L["By Group 25 w/Pets"], {
	[1] = {
		groupFilter = "1",
	},
	[2] = {
		groupFilter = "2",
	},
	[3] = {
		groupFilter = "3",
	},
	[4] = {
		groupFilter = "4",
	},
	[5] = {
		groupFilter = "5",
	},
	[6] = {
		groupFilter = "1,2,3,4,5",
		isPetGroup = true,
		unitsPerColumn = 5,
		maxColumns = 5,
	},
})

GridLayout:AddLayout(L["By Group 25 w/Tanks"], {
	[1] = {
		groupFilter = "MAINTANK,MAINASSIST",
		groupingOrder = "MAINTANK,MAINASSIST",
	},
	-- spacer
	[2] = {
		groupFilter = "",
	},
	[3] = {
		groupFilter = "1",
	},
	[4] = {
		groupFilter = "2",
	},
	[5] = {
		groupFilter = "3",
	},
	[6] = {
		groupFilter = "4",
	},
	[7] = {
		groupFilter = "5",
	}
})

GridLayout:AddLayout(L["By Group 40"], {
	[1] = {
		groupFilter = "1",
	},
	[2] = {
		groupFilter = "2",
	},
	[3] = {
		groupFilter = "3",
	},
	[4] = {
		groupFilter = "4",
	},
	[5] = {
		groupFilter = "5",
	},
	[6] = {
		groupFilter = "6",
	},
	[7] = {
		groupFilter = "7",
	},
	[8] = {
		groupFilter = "8",
	},
})

GridLayout:AddLayout(L["By Group 40 w/Pets"], {
	[1] = {
		groupFilter = "1",
	},
	[2] = {
		groupFilter = "2",
	},
	[3] = {
		groupFilter = "3",
	},
	[4] = {
		groupFilter = "4",
	},
	[5] = {
		groupFilter = "5",
	},
	[6] = {
		groupFilter = "6",
	},
	[7] = {
		groupFilter = "7",
	},
	[8] = {
		groupFilter = "8",
	},
	[9] = {
		groupFilter = "1,2,3,4,5,6,7,8",
		isPetGroup = true,
		unitsPerColumn = 5,
		maxColumns = 8,
	},
})

GridLayout:AddLayout(L["By Class 10"], {
	[1] = {
		groupFilter = "1,2",
		groupBy = "CLASS",
		groupingOrder = "WARRIOR,DEATHKNIGHT,ROGUE,PALADIN,DRUID,SHAMAN,PRIEST,MAGE,WARLOCK,HUNTER",
		unitsPerColumn = 5,
		maxColumns = 2,
	},
})

GridLayout:AddLayout(L["By Class 10 w/Pets"], {
	[1] = {
		groupFilter = "1,2",
		groupBy = "CLASS",
		groupingOrder = "WARRIOR,DEATHKNIGHT,ROGUE,PALADIN,DRUID,SHAMAN,PRIEST,MAGE,WARLOCK,HUNTER",
		unitsPerColumn = 5,
		maxColumns = 2,
	},
	[2] = {
		isPetGroup = true,
		groupFilter = "1,2",
		groupBy = "CLASS",
		groupingOrder = "HUNTER,WARLOCK,DEATHKNIGHT,PRIEST,MAGE,DRUID,SHAMAN,WARRIOR,ROGUE,PALADIN",
		unitsPerColumn = 5,
		maxColumns = 2,
	},
})

GridLayout:AddLayout(L["By Class 25"], {
	[1] = {
		groupFilter = "1,2,3,4,5",
		groupBy = "CLASS",
		groupingOrder = "WARRIOR,DEATHKNIGHT,ROGUE,PALADIN,DRUID,SHAMAN,PRIEST,MAGE,WARLOCK,HUNTER",
		unitsPerColumn = 5,
		maxColumns = 5,
	},
})

GridLayout:AddLayout(L["By Class 25 w/Pets"], {
	[1] = {
		groupFilter = "1,2,3,4,5",
		groupBy = "CLASS",
		groupingOrder = "WARRIOR,DEATHKNIGHT,ROGUE,PALADIN,DRUID,SHAMAN,PRIEST,MAGE,WARLOCK,HUNTER",
		unitsPerColumn = 5,
		maxColumns = 5,
	},
	[2] = {
		isPetGroup = true,
		groupFilter = "1,2,3,4,5",
		groupBy = "CLASS",
		groupingOrder = "HUNTER,WARLOCK,DEATHKNIGHT,PRIEST,MAGE,DRUID,SHAMAN,WARRIOR,ROGUE,PALADIN",
		unitsPerColumn = 5,
		maxColumns = 5,
	},
})
