SexyMap.borderPresets = {				
	["Blue Rune Circles"] = {
		borders = {
			{
				["a"] = 1,
				["r"] = 0.3098039215686275,
				["name"] = "Rune 1",
				["b"] = 1,
				["scale"] = 1.4,
				["rotSpeed"] = -16,
				["g"] = 0.4784313725490196,
				["texture"] = "SPELLS\\AURARUNE256.BLP",
			}, -- [1]
			{
				["a"] = 0.3799999952316284,
				["r"] = 0.196078431372549,
				["rotSpeed"] = 4,
				["b"] = 1,
				["scale"] = 2.1,
				["name"] = "Rune 2",
				["g"] = 0.2901960784313725,
				["texture"] = "SPELLS\\AuraRune_A.blp",
			}, -- [2]
			{
				["a"] = 0.3,
				["name"] = "Fade",
				["b"] = 1,
				["scale"] = 1.6,
				["r"] = 0,
				["g"] = 0.2235294117647059,
				["texture"] = "SPELLS\\T_VFX_HERO_CIRCLE.BLP",
			}, -- [3]
		},
		shape = "Textures\\MinimapMask"
	},
	["Blue Rune Diamond"] = {
		borders = {
			{
				["a"] = 1,
				["hNudge"] = -1,
				["rotSpeed"] = 0,
				["b"] = 1,
				["scale"] = 1.62,
				["g"] = 0.3450980392156863,
				["vNudge"] = 0,
				["rotation"] = 0,
				["name"] = "Rune",
				["drawLayer"] = "BACKGROUND",
				["r"] = 0,
				["texture"] = "SPELLS\\AuraRune256b.blp",
			}, -- [1]
			{
				["a"] = 0.06999999284744263,
				["r"] = 0.3294117647058824,
				["scale"] = 2.1,
				["g"] = 0.5333333333333333,
				["vNudge"] = 0,
				["drawLayer"] = "ARTWORK",
				["name"] = "Inner Circle",
				["disableRotation"] = true,
				["b"] = 1,
				["texture"] = "Interface\\GLUES\\MODELS\\UI_Tauren\\gradientCircle.blp",
			}, -- [2]
		},
		shape = "Interface\\AddOns\\SexyMap\\shapes\\diamond"
	},
	["Burning Sun"] = {
		borders = {
			{
				["a"] = 1,
				["b"] = 0.04313725490196078,
				["name"] = "Main",
				["r"] = 1,
				["scale"] = 1.82,
				["rotSpeed"] = 21,
				["g"] = 0.2901960784313725,
				["texture"] = "PARTICLES\\GENERICGLOW5.BLP",
			}, -- [1]
			{
				["a"] = 1,
				["b"] = 0.3529411764705882,
				["name"] = "Second",
				["r"] = 1,
				["scale"] = 1.62,
				["rotSpeed"] = -18,
				["g"] = 0.8705882352941177,
				["texture"] = "PARTICLES\\GENERICGLOW5.BLP",
			}, -- [2]
			{
				["a"] = 0.449999988079071,
				["name"] = "Tint",
				["b"] = 0.3254901960784314,
				["scale"] = 1.35,
				["r"] = 1,
				["g"] = 0.6705882352941176,
				["texture"] = "SPELLS\\T_VFX_HERO_CIRCLE.BLP",
			}, -- [3]	
		},
		shape = "Textures\\MinimapMask"
	},
	["Jewels"] = {
		borders = {
			{
				["a"] = 1,
				["b"] = 0.7058823529411764,
				["scale"] = 0.8800000000000001,
				["g"] = 0.6392156862745098,
				["disableRotation"] = true,
				["name"] = "Square",
				["blendMode"] = "DISABLE",
				["drawLayer"] = "BACKGROUND",
				["r"] = 0.615686274509804,
				["texture"] = "TILESET\\EXPANSION01\\EVERSONG\\SwathSmallStones.blp",
			}, -- [1]
			{
				["a"] = 1,
				["hNudge"] = 0,
				["rotSpeed"] = 118,
				["r"] = 0.6823529411764706,
				["scale"] = 0.8800000000000001,
				["g"] = 0.8666666666666667,
				["vNudge"] = 0,
				["disableRotation"] = true,
				["name"] = "Square Glow",
				["blendMode"] = "ADD",
				["rotation"] = 66,
				["drawLayer"] = "BORDER",
				["b"] = 1,
				["texture"] = "Interface\\Minimap\\Ping\\ping5.blp",
			}, -- [2]
		},
		shape = "Interface\\AddOns\\SexyMap\\shapes\\squareFuzzy"
	},
	["Blue Square Glow"] = {
		borders = {
			{
				["a"] = 1,
				["hNudge"] = 0,
				["rotSpeed"] = 10,
				["r"] = 0.3411764705882353,
				["scale"] = 0.73,
				["g"] = 0.4705882352941176,
				["vNudge"] = 0,
				["disableRotation"] = true,
				["name"] = "Square Overlay",
				["blendMode"] = "ADD",
				["b"] = 1,
				["drawLayer"] = "ARTWORK",
				["rotation"] = 66,
				["texture"] = "World\\GENERIC\\ACTIVEDOODADS\\WORLDTREEPORTALS\\TWISTEDNETHER8.BLP",
			}, -- [1]
			{
				["a"] = 1,
				["hNudge"] = 0,
				["rotSpeed"] = -14,
				["b"] = 1,
				["scale"] = 1.9,
				["g"] = 0.7215686274509804,
				["vNudge"] = 5,
				["disableRotation"] = true,
				["name"] = "Circle 2",
				["drawLayer"] = "BACKGROUND",
				["r"] = 0.3607843137254902,
				["blendMode"] = "ADD",
				["texture"] = "World\\GENERIC\\ACTIVEDOODADS\\INSTANCEPORTAL\\GENERICGLOW2.BLP",
			}, -- [2]
		},
		shape = "Interface\\BUTTONS\\WHITE8X8"
	},
	["Rustic"] = {
		["borders"] = {
		},
		["backdrop"] = {
			["show"] = true,
			["textureColor"] = {
				["a"] = 1,
				["r"] = 1,
				["g"] = 0.9215686274509803,
				["b"] = 0.6627450980392157,
			},
			["settings"] = {
				["edgeSize"] = 28,
				["edgeFile"] = "Interface\\LFGFrame\\LFGBorder.blp",
				["tile"] = false,
				["bgFile"] = "World\\EXPANSION02\\DOODADS\\Ulduar\\UL_SpinningRoomRings_Ring07.blp",
				["insets"] = {
					["top"] = 9,
					["right"] = 9,
					["left"] = 9,
					["bottom"] = 9,
				},
			},
			["borderColor"] = {
				["a"] = 1,
				["r"] = 1,
				["g"] = 0.7607843137254902,
				["b"] = 0.7176470588235294,
			},
			["scale"] = 1.25,
		},
		["shape"] = "SPELLS\\T_VFX_BORDER",
	},	
	Parchment = {
		borders = {
			{
				["a"] = 1,
				["b"] = 1,
				["scale"] = 0.8200000000000001,
				["g"] = 1,
				["disableRotation"] = true,
				["blendMode"] = "DISABLE",
				["r"] = 1,
				["drawLayer"] = "BACKGROUND",
				["name"] = "Parchment",
				["texture"] = "Interface\\AchievementFrame\\UI-Achievement-Parchment.blp",
			}, -- [1]
			{
				["a"] = 0.3799999952316284,
				["r"] = 0.2,
				["scale"] = 0.9000000000000001,
				["g"] = 0.09803921568627451,
				["drawLayer"] = "BACKGROUND",
				["name"] = "Tint",
				["blendMode"] = "BLEND",
				["b"] = 0,
				["texture"] = "Interface\\BUTTONS\\WHITE8X8.BLP",
			}, -- [2]
			{
				["disableRotation"] = true,
				["r"] = 0.6313725490196078,
				["name"] = "Parchment 2",
				["b"] = 0.6313725490196078,
				["scale"] = 0.8200000000000001,
				["a"] = 1,
				["g"] = 0.6313725490196078,
				["texture"] = "Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal.blp",
			}, -- [3]		
		},
		shape = "Interface\\AddOns\\SexyMap\\shapes\\squareFuzzy"
	},
	["Stargate"] = {
		["shape"] = "Textures\\MinimapMask",
		["borders"] = {
			{
				["a"] = 1,
				["rotSpeed"] = -16,
				["b"] = 1,
				["scale"] = 1.4,
				["g"] = 0.6862745098039216,
				["name"] = "Rune 1",
				["playerRotation"] = "normal",
				["r"] = 0.5764705882352941,
				["texture"] = "SPELLS\\AURARUNE256.BLP",
			}, -- [1]
			{
				["a"] = 0.3799999952316284,
				["rotSpeed"] = 0,
				["b"] = 1,
				["playerRotation"] = "none",
				["g"] = 0.6588235294117647,
				["rotation"] = 105,
				["name"] = "Rune 2",
				["scale"] = 2.05,
				["r"] = 0.2823529411764706,
				["texture"] = "SPELLS\\AuraRune_A.blp",
			}, -- [2]
			{
				["a"] = 0.3,
				["name"] = "Fade",
				["b"] = 1,
				["scale"] = 1.6,
				["r"] = 0,
				["g"] = 0.2235294117647059,
				["texture"] = "SPELLS\\T_VFX_HERO_CIRCLE.BLP",
			}, -- [3]
			{
				["a"] = 1,
				["rotSpeed"] = -6,
				["name"] = "Rune 3",
				["b"] = 0.3529411764705882,
				["scale"] = 1.65,
				["r"] = 0.1137254901960784,
				["g"] = 0.1686274509803922,
				["texture"] = "SPELLS\\AuraRune_B.blp",
			}, -- [4]
		},
	},
	["Simple Square"] = {
		["borders"] = {
		},
		["backdrop"] = {
			["show"] = true,
			["textureColor"] = {
			},
			["settings"] = {
				["edgeSize"] = 17,
				["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
				["bgFile"] = "Interface\\Tooltips\\UI-Tooltip-Background",
				["tile"] = false,
				["insets"] = {
					["top"] = 4,
					["right"] = 4,
					["left"] = 4,
					["bottom"] = 4,
				},
			},
			["borderColor"] = {
			},
			["scale"] = 1.07,
		},
		["shape"] = "Interface\\BUTTONS\\WHITE8X8",
	},
	["Rogue"] = {
		["borders"] = {
			{
				["a"] = 1,
				["rotSpeed"] = -8,
				["name"] = "Rogue Rune 2",
				["b"] = 0,
				["scale"] = 2.13,
				["r"] = 0.1450980392156863,
				["g"] = 0.00392156862745098,
				["texture"] = "SPELLS\\RogueRune2.blp",
			}, -- [1]
			{
				["a"] = 1,
				["r"] = 0.6,
				["scale"] = 0.8900000000000001,
				["g"] = 0.2078431372549019,
				["disableRotation"] = true,
				["blendMode"] = "ADD",
				["name"] = "Glow",
				["b"] = 0.09411764705882353,
				["texture"] = "SPELLS\\White-Circle.blp",
			}, -- [2]
		},
		["backdrop"] = {
			["show"] = false,
			["textureColor"] = {
			},
			["settings"] = {
				["bgFile"] = "Interface\\Tooltips\\UI-Tooltip-Background",
				["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
				["tile"] = false,
				["edgeSize"] = 16,
				["insets"] = {
					["top"] = 4,
					["right"] = 4,
					["left"] = 4,
					["bottom"] = 4,
				},
			},
			["borderColor"] = {
			},
			["scale"] = 1,
		},
		["shape"] = "Textures\\MinimapMask",
	},
	["Ruins"] = {
		["borders"] = {
		},
		["backdrop"] = {
			["show"] = true,
			["textureColor"] = {
				["a"] = 1,
				["b"] = 1,
				["g"] = 1,
				["r"] = 1,
			},
			["settings"] = {
				["bgFile"] = "World\\ENVIRONMENT\\DOODAD\\STRANGLETHORN\\TROLLRUINS\\TEX\\GARY\\GP_SNKNTMP_ATARBORDER.blp",
				["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border.blp",
				["tile"] = false,
				["edgeSize"] = 23,
				["insets"] = {
					["top"] = 5,
					["right"] = 5,
					["left"] = 5,
					["bottom"] = 5,
				},
			},
			["borderColor"] = {
				["a"] = 1,
				["b"] = 0.7254901960784314,
				["g"] = 0.8627450980392157,
				["r"] = 1,
			},
			["scale"] = 1.42,
		},
		["shape"] = "Interface\\AddOns\\SexyMap\\shapes\\squareFuzzy",
	},
	["Wood Framed"] = {
		["borders"] = {
		},
		["backdrop"] = {
			["show"] = true,
			["textureColor"] = {
				["a"] = 1,
				["b"] = 1,
				["g"] = 1,
				["r"] = 1,
			},
			["settings"] = {
				["bgFile"] = "Interface\\AchievementFrame\\UI-Achievement-StatsBackground.blp",
				["edgeFile"] = "Interface\\AchievementFrame\\UI-Achievement-WoodBorder.blp",
				["tile"] = false,
				["edgeSize"] = 28,
				["insets"] = {
					["top"] = 4,
					["right"] = 4,
					["left"] = 4,
					["bottom"] = 4,
				},
			},
			["borderColor"] = {
				["a"] = 1,
				["b"] = 0.7254901960784314,
				["g"] = 0.8627450980392157,
				["r"] = 1,
			},
			["scale"] = 1.17,
		},
		["shape"] = "Interface\\AddOns\\SexyMap\\shapes\\squareFuzzy",
	},	
	["Emerald Portal by Korryna"] = {
		["borders"] = {
			{
				["a"] = 1,
				["hNudge"] = 2,
				["rotSpeed"] = 8,
				["r"] = 0,
				["scale"] = 1.17,
				["g"] = 0.4745098039215686,
				["vNudge"] = -1,
				["blendMode"] = "ADD",
				["name"] = "Moss Ring CW",
				["b"] = 0.01568627450980392,
				["texture"] = "XTEXTURES\\splash\\splash.blp",
			}, -- [1]
			{
				["a"] = 1,
				["r"] = 1,
				["scale"] = 1.6,
				["g"] = 0.9725490196078431,
				["drawLayer"] = "BACKGROUND",
				["blendMode"] = "ADD",
				["name"] = "Outer Glow",
				["b"] = 0.3490196078431372,
				["texture"] = "Textures\\moonglare.blp",
			}, -- [2]
			{
				["a"] = 0.09000003337860107,
				["blendMode"] = "ADD",
				["name"] = "Map Glow",
				["b"] = 0.4431372549019608,
				["scale"] = 1.07,
				["r"] = 0.807843137254902,
				["g"] = 1,
				["texture"] = "Textures\\Moon02Glare.blp",
			}, -- [3]
			{
				["a"] = 0.7199999988079071,
				["hNudge"] = 41,
				["rotSpeed"] = 41,
				["b"] = 1,
				["scale"] = 1.22,
				["g"] = 0.8705882352941177,
				["vNudge"] = 38,
				["drawLayer"] = "OVERLAY",
				["blendMode"] = "ADD",
				["rotation"] = 45,
				["disableRotation"] = false,
				["r"] = 0.1725490196078431,
				["name"] = "Glare UR",
				["texture"] = "SPELLS\\AURA_01.blp",
			}, -- [4]
			{
				["a"] = 0.2599999904632568,
				["hNudge"] = -57,
				["rotSpeed"] = -8,
				["b"] = 0.05098039215686274,
				["scale"] = 0.8400000000000001,
				["g"] = 0.4156862745098039,
				["vNudge"] = 32,
				["blendMode"] = "ADD",
				["r"] = 0,
				["name"] = "Nature Rune UL",
				["texture"] = "SPELLS\\Nature_Rune_128.blp",
			}, -- [5]
			{
				["a"] = 0.1800000071525574,
				["hNudge"] = 39,
				["rotSpeed"] = 8,
				["b"] = 0.1176470588235294,
				["scale"] = 0.8700000000000001,
				["g"] = 0.4313725490196079,
				["vNudge"] = -45,
				["name"] = "Nature Rune LR",
				["r"] = 0.4823529411764706,
				["texture"] = "SPELLS\\Nature_Rune_128.blp",
			}, -- [6]
			{
				["a"] = 0.1200000047683716,
				["hNudge"] = 53,
				["rotSpeed"] = -13,
				["b"] = 0.7764705882352941,
				["scale"] = 0.78,
				["g"] = 1,
				["vNudge"] = 39,
				["name"] = "Nature Rune UR",
				["r"] = 0.2941176470588235,
				["texture"] = "SPELLS\\Nature_Rune_128.blp",
			}, -- [7]
			{
				["a"] = 0.09000003337860107,
				["hNudge"] = -48,
				["rotSpeed"] = -6,
				["b"] = 0.4352941176470588,
				["scale"] = 0.8500000000000001,
				["g"] = 1,
				["vNudge"] = -45,
				["name"] = "Nature Rune LL",
				["r"] = 0.7607843137254902,
				["texture"] = "SPELLS\\Nature_Rune_128.blp",
			}, -- [8]
			{
				["a"] = 0.14000004529953,
				["rotSpeed"] = -14,
				["name"] = "Nature Rune Large CCW",
				["b"] = 0.07450980392156863,
				["scale"] = 1.81,
				["r"] = 0.09019607843137255,
				["g"] = 0.3372549019607843,
				["texture"] = "SPELLS\\Nature_Rune_128.blp",
			}, -- [9]
			{
				["a"] = 0.6599999964237213,
				["rotSpeed"] = -1,
				["b"] = 0.01568627450980392,
				["scale"] = 1.45,
				["g"] = 0.4666666666666667,
				["drawLayer"] = "BACKGROUND",
				["blendMode"] = "BLEND",
				["r"] = 0,
				["name"] = "Edge Shimmer CCW",
				["texture"] = "SPELLS\\SHOCKWAVE_INVERTGREY.BLP",
			}, -- [10]
			{
				["a"] = 0.5800000131130219,
				["rotSpeed"] = 2,
				["b"] = 0.06666666666666667,
				["scale"] = 1.46,
				["g"] = 0.3098039215686275,
				["drawLayer"] = "BORDER",
				["name"] = "Edge Shimmer CW",
				["r"] = 0.02352941176470588,
				["texture"] = "SPELLS\\SHOCKWAVE_INVERTGREY.BLP",
			}, -- [11]
			{
				["a"] = 0.5,
				["rotSpeed"] = 0,
				["b"] = 1,
				["scale"] = 1.58,
				["g"] = 1,
				["rotation"] = 231,
				["blendMode"] = "BLEND",
				["r"] = 1,
				["drawLayer"] = "BACKGROUND",
				["name"] = "Background Leaves",
				["texture"] = "SPELLS\\TREANTLEAVES.BLP",
			}, -- [12]
		},
		["backdrop"] = {
			["show"] = false,
			["textureColor"] = {
			},
			["settings"] = {
				["bgFile"] = "Interface\\Tooltips\\UI-Tooltip-Background",
				["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
				["tile"] = false,
				["edgeSize"] = 16,
				["insets"] = {
					["top"] = 4,
					["right"] = 4,
					["left"] = 4,
					["bottom"] = 4,
				},
			},
			["borderColor"] = {},
			["scale"] = 1,
		},
		["shape"] = "Textures\\MinimapMask",
	},
	["Shamanism by Jaygoody"] = {
		["borders"] = {
			{
				["a"] = 1,
				["hNudge"] = 65,
				["b"] = 1,
				["scale"] = 0.4,
				["g"] = 1,
				["vNudge"] = 65,
				["disableRotation"] = true,
				["name"] = "Rune Earth",
				["r"] = 1,
				["texture"] = "World\\GENERIC\\PASSIVEDOODADS\\ShamanStone\\SHAMANSTONEEARTH.blp",
			}, -- [1]
			{
				["disableRotation"] = true,
				["hNudge"] = -65,
				["name"] = "Rune Air",
				["scale"] = 0.35,
				["texture"] = "World\\GENERIC\\PASSIVEDOODADS\\ShamanStone\\ShamanStoneAir.blp",
				["vNudge"] = -65,
			}, -- [2]
			{
				["a"] = 1,
				["hNudge"] = 65,
				["b"] = 1,
				["scale"] = 0.35,
				["g"] = 0.984313725490196,
				["vNudge"] = -65,
				["disableRotation"] = true,
				["name"] = "Rune Water",
				["r"] = 0.4392156862745098,
				["texture"] = "World\\GENERIC\\PASSIVEDOODADS\\ShamanStone\\ShamanStoneWater.blp",
			}, -- [3]
			{
				["a"] = 1,
				["hNudge"] = -65,
				["r"] = 1,
				["scale"] = 0.35,
				["g"] = 1,
				["vNudge"] = 65,
				["disableRotation"] = true,
				["name"] = "Rune Fire",
				["b"] = 1,
				["texture"] = "World\\GENERIC\\PASSIVEDOODADS\\ShamanStone\\ShamanStoneFlame.blp",
			}, -- [4]
			{
				["a"] = 1,
				["rotSpeed"] = 9,
				["b"] = 1,
				["scale"] = 1.79,
				["g"] = 1,
				["drawLayer"] = "BORDER",
				["name"] = "Outer Rings",
				["disableRotation"] = false,
				["rotation"] = 184,
				["r"] = 1,
				["blendMode"] = "ADD",
				["texture"] = "SPELLS\\Shockwave4.blp",
			}, -- [5]
			{
				["a"] = 0.75,
				["rotSpeed"] = 10,
				["b"] = 1,
				["scale"] = 1.12,
				["g"] = 0.5568627450980392,
				["drawLayer"] = "BORDER",
				["name"] = "Outer Glow",
				["disableRotation"] = true,
				["r"] = 0,
				["blendMode"] = "ADD",
				["texture"] = "World\\ENVIRONMENT\\DOODAD\\GENERALDOODADS\\ELEMENTALRIFTS\\Shockwave_blue.blp",
			}, -- [6]
			{
				["a"] = 0.3700000047683716,
				["name"] = "Edge Radiance",
				["rotSpeed"] = -1,
				["b"] = 0,
				["scale"] = 1.49,
				["r"] = 1,
				["g"] = 0.6313725490196078,
				["texture"] = "SPELLS\\SHOCKWAVE_INVERTGREY.BLP",
			}, -- [7]
			{
				["a"] = 0.5,
				["hNudge"] = -65,
				["b"] = 0,
				["g"] = 0.2313725490196079,
				["vNudge"] = 65,
				["drawLayer"] = "BACKGROUND",
				["name"] = "Glow Fire",
				["disableRotation"] = true,
				["r"] = 1,
				["texture"] = "SPELLS\\GENERICGLOW64.BLP",
			}, -- [8]
			{
				["a"] = 0.4700000286102295,
				["hNudge"] = -65,
				["b"] = 0.9333333333333334,
				["scale"] = 1.11,
				["g"] = 0,
				["vNudge"] = -65,
				["drawLayer"] = "BACKGROUND",
				["name"] = "Glow Air",
				["disableRotation"] = false,
				["r"] = 1,
				["texture"] = "SPELLS\\GENERICGLOW64.BLP",
			}, -- [9]
			{
				["a"] = 0.5100000202655792,
				["hNudge"] = 65,
				["r"] = 0,
				["scale"] = 1.11,
				["g"] = 0.04705882352941176,
				["vNudge"] = -65,
				["drawLayer"] = "BACKGROUND",
				["name"] = "Glow Water",
				["b"] = 1,
				["texture"] = "SPELLS\\GENERICGLOW64.BLP",
			}, -- [10]
			{
				["a"] = 0.4000000357627869,
				["hNudge"] = 65,
				["b"] = 0,
				["scale"] = 1.1,
				["g"] = 1,
				["vNudge"] = 65,
				["drawLayer"] = "BACKGROUND",
				["name"] = "Glow Earth",
				["r"] = 0.2588235294117647,
				["texture"] = "SPELLS\\GENERICGLOW64.BLP",
			}, -- [11]
		},
		["backdrop"] = {
			["show"] = false,
			["textureColor"] = {
			},
			["settings"] = {
				["bgFile"] = "Interface\\Tooltips\\UI-Tooltip-Background",
				["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
				["tile"] = false,
				["edgeSize"] = 16,
				["insets"] = {
					["top"] = 4,
					["right"] = 4,
					["left"] = 4,
					["bottom"] = 4,
				},
			},
			["borderColor"] = {
			},
			["scale"] = 1,
		},
		["shape"] = "Textures\\MinimapMask",
	},
}