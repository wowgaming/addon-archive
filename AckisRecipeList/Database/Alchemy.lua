--[[
************************************************************************
Alchemy.lua
Alchemy data for all of Ackis Recipe List
************************************************************************
File date: 2010-01-15T03:12:04Z 
File revision: 2801 
Project revision: 2817
Project version: v1.0-r2818
************************************************************************
Please see http://www.wowace.com/addons/arl/ for more information.
************************************************************************
This source code is released under All Rights Reserved.
************************************************************************
]]--

local MODNAME = "Ackis Recipe List"
local addon	= LibStub("AceAddon-3.0"):GetAddon(MODNAME)
local L	= LibStub("AceLocale-3.0"):GetLocale(MODNAME)

--------------------------------------------------------------------------------------------------------------------
-- Item "rarity"
--------------------------------------------------------------------------------------------------------------------
local R_COMMON, R_UNCOMMON, R_RARE, R_EPIC, R_LEGENDARY, R_ARTIFACT = 1, 2, 3, 4, 5, 6

--------------------------------------------------------------------------------------------------------------------
-- Origin
--------------------------------------------------------------------------------------------------------------------
local GAME_ORIG, GAME_TBC, GAME_WOTLK = 0, 1, 2

--------------------------------------------------------------------------------------------------------------------
-- Filter flags
--------------------------------------------------------------------------------------------------------------------
local F_ALLIANCE, F_HORDE, F_TRAINER, F_VENDOR, F_INSTANCE, F_RAID = 1, 2, 3, 4, 5, 6
local F_SEASONAL, F_QUEST, F_PVP, F_WORLD_DROP, F_MOB_DROP, F_DISC = 7, 8, 9, 10, 11, 12
local F_DK, F_DRUID, F_HUNTER, F_MAGE, F_PALADIN, F_PRIEST, F_SHAMAN, F_ROGUE, F_WARLOCK, F_WARRIOR = 21, 22, 23, 24, 25, 26, 27, 28, 29, 30
local F_IBOE, F_IBOP, F_IBOA, F_RBOE, F_RBOP, F_RBOA = 36, 37, 38, 40, 41, 42
local F_DPS, F_TANK, F_HEALER, F_CASTER = 51, 52, 53, 54
local F_CLOTH, F_LEATHER, F_MAIL, F_PLATE, F_CLOAK, F_TRINKET, F_RING, F_NECK, F_SHIELD = 56, 57, 58, 59, 60, 61, 62, 63, 64
local F_1H, F_2H, F_AXE, F_SWORD, F_MACE, F_POLEARM, F_DAGGER = 66, 67, 68, 69, 70, 71, 72
local F_STAFF, F_WAND, F_THROWN, F_BOW, F_XBOW, F_AMMO, F_FIST, F_GUN = 73, 74, 75, 76, 77, 78, 79, 80

--------------------------------------------------------------------------------------------------------------------
-- Acquire types
--------------------------------------------------------------------------------------------------------------------
local A_TRAINER, A_VENDOR, A_MOB, A_QUEST, A_SEASONAL, A_REPUTATION, A_WORLD_DROP, A_CUSTOM = 1, 2, 3, 4, 5, 6, 7, 8


local initialized = false
local num_recipes = 0

function addon:InitAlchemy(RecipeDB)

	if initialized then
		return num_recipes
	end

	initialized = true

	--------------------------------------------------------------------------------------------------------------------
	-- Counter and wrapper function
	--------------------------------------------------------------------------------------------------------------------
	local function AddRecipe(SpellID, Skill, ItemID, Rarity, Game, Orange, Yellow, Green, Gray)
		num_recipes = num_recipes + 1
		self:addTradeSkill(RecipeDB, SpellID, Skill, ItemID, Rarity, 51304, nil, Game, Orange, Yellow, Green, Gray)
	end

	-- Elixir of Lion's Strength -- 2329
	AddRecipe(2329,1,2454,1,GAME_ORIG,1,55,75,95)
	self:addTradeFlags(RecipeDB,2329, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41, F_DPS)
	self:addTradeAcquire(RecipeDB,2329,8,8)

	-- Minor Healing Potion -- 2330
	AddRecipe(2330,1,118,1,GAME_ORIG,1,55,75,95)
	self:addTradeFlags(RecipeDB,2330, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,2330,8,8)

	-- Minor Mana Potion -- 2331
	AddRecipe(2331,25,2455,1,GAME_ORIG,25,65,85,105)
	self:addTradeFlags(RecipeDB,2331, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,2331,1,1215,1,1246,1,1386,1,1470,1,2132,1,2391,1,2837,1,3009,1,3184,1,3347,1,3603,1,4160,1,4611,1,5177,1,5499,1,7948,1,16161,1,16588,1,16642,1,16723,1,17215,1,18802,1,19052,1,27029,1,3964,1,33608,1,33674,1,27023,1,4900)

	-- Minor Rejuvenation Potion -- 2332
	AddRecipe(2332,40,2456,1,GAME_ORIG,40,70,90,110)
	self:addTradeFlags(RecipeDB,2332, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,2332,1,1215,1,1246,1,1386,1,1470,1,2132,1,2391,1,2837,1,3009,1,3184,1,3347,1,3603,1,4160,1,4611,1,5177,1,5499,1,7948,1,16161,1,16588,1,16642,1,16723,1,17215,1,18802,1,19052,1,27029,1,3964,1,33608,1,33674,1,27023,1,4900)

	-- Elixir of Lesser Agility -- 2333
	AddRecipe(2333,140,3390,2,GAME_ORIG,140,165,185,205)
	self:addTradeFlags(RecipeDB,2333, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE,51)
	self:addTradeAcquire(RecipeDB,2333,7,2)

	-- Elixir of Minor Fortitude -- 2334
	AddRecipe(2334,50,2458,1,GAME_ORIG,50,80,100,120)
	self:addTradeFlags(RecipeDB,2334, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,2334,1,1215,1,1246,1,1386,1,1470,1,2132,1,2391,1
	,2837,1,3009,1,3184,1,3347,1,3603,1,4160,1,4611,1,5177,1,5499,1,7948
	,1,16161,1,16588,1,16642,1,16723,1
	,17215,1,18802,1,19052,1,27029,1,3964,1,33608,1,33674,1,27023,1,4900)

	-- Swiftness Potion -- 2335
	AddRecipe(2335,60,2459,2,GAME_ORIG,60,90,110,130)
	self:addTradeFlags(RecipeDB,2335, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,2335,7,2)

	-- Lesser Healing Potion -- 2337
	AddRecipe(2337,55,858,1,GAME_ORIG,55,85,105,125)
	self:addTradeFlags(RecipeDB,2337, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,2337,1,1215,1,1246,1,1386,1,1470,1,2132,1,2391,1
	,2837,1,3009,1,3184,1,3347,1,3603,1,4160,1,4611,1,5177,1,5499,1,7948
	,1,16161,1,16588,1,16642,1,16723,1
	,17215,1,18802,1,19052,1,27029,1,3964,1,33608,1,33674,1,27023,1,4900)

	-- Weak Troll's Blood Elixir -- 3170
	AddRecipe(3170,15,3382,1,GAME_ORIG,15,60,80,100)
	self:addTradeFlags(RecipeDB,3170, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,3170,1,1215,1,1246,1,1386,1,1470,1,2132,1,2391,1
	,2837,1,3009,1,3184,1,3347,1,3603,1,4160,1,4611,1,5177,1,5499,1,7948
	,1,16161,1,16588,1,16642,1,16723,1,17215,1,18802,1,19052,1,27029,1,3964,1,33608,1,33674,1,27023,1,4900)

	-- Elixir of Wisdom -- 3171
	AddRecipe(3171,90,3383,1,GAME_ORIG,90,120,140,160)
	self:addTradeFlags(RecipeDB,3171, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,3171,1,1386,1,2391,1,2837,1,3009,1,3347,1,4160,
	1,4611,1,5177,1,5499,1,7948,1,16588,1,16642,1,16723,1,18802,1,19052,
	1,27029,1,3603,1,1470,1,3964,1,2132,1,3184,1,33608,1,33674,1,27023,1,4900,1,1215,
	1,16161)

	-- Minor Magic Resistance Potion -- 3172
	AddRecipe(3172,110,3384,1,GAME_ORIG,110,135,155,175)
	self:addTradeFlags(RecipeDB,3172, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB, 3172, A_WORLD_DROP, R_COMMON)

	-- Lesser Mana Potion -- 3173
	AddRecipe(3173,120,3385,1,GAME_ORIG,120,145,165,185)
	self:addTradeFlags(RecipeDB,3173, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,3173,1,1386,1,2391,1,2837,1,3009,1,3347,1,3964,1
	,4160,1,4611,1,5177,1,5499,1,7948,1,16588,1,16642,1,16723,1,18802,1
	,19052,1,27029,1,3603,1,1470,1,2132,1,3184,1,33608,1,33674,1,27023,1,4900,1,1215,1
	,16161)

	-- Potion of Curing -- 3174
	AddRecipe(3174,120,3386,1,GAME_ORIG,120,145,165,185)
	self:addTradeFlags(RecipeDB, 3174, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB, 3174, A_WORLD_DROP, R_COMMON)

	-- Limited Invulnerability Potion -- 3175
	AddRecipe(3175,250,3387,2,GAME_ORIG,250,275,295,315)
	self:addTradeFlags(RecipeDB, 3175, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB, 3175, A_WORLD_DROP, R_UNCOMMON)

	-- Strong Troll's Blood Elixir -- 3176
	AddRecipe(3176,125,3388,1,GAME_ORIG,125,150,170,190)
	self:addTradeFlags(RecipeDB,3176, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,3176,1,1386,1,2391,1,2837,1,3009,1,3347,1,3964,1
	,4160,1,4611,1,5177,1,5499,1,7948,1,16588,1,16642,1,16723,1,18802,1
	,19052,1,27029,1,3603,1,1470,1,2132,1,3184,1,33608,1,33674,1,27023,1,4900,1,1215,1
	,16161)

	-- Elixir of Defense -- 3177
	AddRecipe(3177,130,3389,1,GAME_ORIG,130,155,175,195)
	self:addTradeFlags(RecipeDB,3177, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,52)
	self:addTradeAcquire(RecipeDB,3177,1,1386,1,2391,1,2837,1,3009,1,3347,1,3964,1
	,4160,1,4611,1,5177,1,5499,1,7948,1,16588,1,16642,1,16723,1,18802,1
	,19052,1,27029,1,3603,1,1470,1,2132,1,3184,1,33608,1,33674,1,27023,1,4900,1,1215,1
	,16161)

	-- Elixir of Ogre's Strength -- 3188
	AddRecipe(3188, 150, 3391, R_COMMON, GAME_ORIG, 150, 175, 195, 215)
	self:addTradeFlags(RecipeDB,3188, F_ALLIANCE, F_HORDE, F_TRAINER, F_WORLD_DROP, F_IBOE, F_RBOE, F_DPS)
	self:addTradeAcquire(RecipeDB,3188, A_WORLD_DROP, R_COMMON)

	-- Elixir of Minor Agility -- 3230
	AddRecipe(3230,50,2457,2,GAME_ORIG,50,80,100,120)
	self:addTradeFlags(RecipeDB,3230, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE, F_DPS)
	self:addTradeAcquire(RecipeDB, 3230, A_WORLD_DROP, R_UNCOMMON)

	-- Healing Potion -- 3447
	AddRecipe(3447,110,929,1,GAME_ORIG,110,135,155,175)
	self:addTradeFlags(RecipeDB,3447, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,3447,1,1386,1,2391,1,2837,1,3009,1,3347,1,3964,1
	,4160,1,4611,1,5177,1,5499,1,7948,1,16588,1,16642,1,16723,1,18802,1
	,19052,1,27029,1,3603,1,1470,1,2132,1,3184,1,33608,1,33674,1,27023,1,4900,1,1215,1
	,16161)

	-- Lesser Invisibility Potion -- 3448
	AddRecipe(3448,165,3823,1,GAME_ORIG,165,185,205,225)
	self:addTradeFlags(RecipeDB,3448, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,3448,1,1386,1,4160,1,4611,1,7948,1,16588,1,18802
	,1,19052,1,16642,1,27029,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,3964,
	1,2132,1,3184,1,33608,1,33674,1,2391,1,27023,1,4900,1,1215,1,5499,1,16161)

	-- Elixir of Fortitude -- 3450
	AddRecipe(3450,175,3825,1,GAME_ORIG,175,195,215,235)
	self:addTradeFlags(RecipeDB,3450, F_ALLIANCE, F_HORDE, F_TRAINER, F_WORLD_DROP,F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,3450,7,1,1,1386,1,4160,1,4611,1,7948,1,16588,1,
	18802,1,19052,1,16642,1,27029,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,
	3964,1,2132,1,3184,1,33608,1,33674,1,2391,1,27023,1,4900,1,1215,1,5499,1,16161)

	-- Mighty Troll's Blood Elixir -- 3451
	AddRecipe(3451,180,3826,1,GAME_ORIG,180,200,220,240)
	self:addTradeFlags(RecipeDB,3451, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,3451,7,1)

	-- Mana Potion -- 3452
	AddRecipe(3452,160,3827,1,GAME_ORIG,160,180,200,220)
	self:addTradeFlags(RecipeDB,3452, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,3452,1,1386,1,4160,1,4611,1,7948,1,16588,1,18802
	,1,19052,1,16642,1,27029,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,3964,
	1,2132,1,3184,1,33608,1,33674,1,2391,1,27023,1,4900,1,1215,1,5499,1,16161)

	-- Elixir of Detect Lesser Invisibility -- 3453
	AddRecipe(3453,195,3828,2,GAME_ORIG,195,215,235,255)
	self:addTradeFlags(RecipeDB,3453, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,3453,7,2)

	-- Frost Oil -- 3454
	AddRecipe(3454,200,3829,2,GAME_ORIG,200,220,240,260)
	self:addTradeFlags(RecipeDB,3454, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,3454,2,2480)

	-- Discolored Healing Potion -- 4508
	AddRecipe(4508,50,4596,2,GAME_ORIG,50,80,100,120)
	self:addTradeFlags(RecipeDB,4508,2,8,F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,4508,4,429)

	-- Lesser Stoneshield Potion -- 4942
	AddRecipe(4942,215,4623,1,GAME_ORIG,215,230,250,270)
	self:addTradeFlags(RecipeDB,4942,1,2,8,F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,4942,4,715)

	-- Rage Potion -- 6617
	AddRecipe(6617,60,5631,1,GAME_ORIG,60,90,110,130)
	self:addTradeFlags(RecipeDB,6617, F_ALLIANCE, F_HORDE, F_QUEST, F_DRUID,F_WARRIOR,F_IBOE, F_RBOE,51,52)
	self:addTradeAcquire(RecipeDB,6617,2,1669,2,1685,2,3335,2,3499)

	-- Great Rage Potion -- 6618
	AddRecipe(6618,175,5633,1,GAME_ORIG,175,195,215,235)
	self:addTradeFlags(RecipeDB,6618, F_ALLIANCE, F_HORDE, F_QUEST, F_DRUID,F_WARRIOR,F_IBOE, F_RBOE,51,52)
	self:addTradeAcquire(RecipeDB,6618,2,3335,2,4226)

	-- Elixir of Water Breathing -- 7179
	AddRecipe(7179,90,5996,1,GAME_ORIG,90,120,140,160)
	self:addTradeFlags(RecipeDB,7179, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,7179,1,1386,1,2391,1,2837,1,3009,1,3347,1,4160,
	1,4611,1,5177,1,5499,1,7948,1,16588,1,16642,1,16723,1,18802,1,19052,
	1,27029,1,3603,1,1470,1,3964,1,2132,1,3184,1,33608,1,33674,1,27023,1,4900,1,1215,
	1,16161)

	-- Greater Healing Potion -- 7181
	AddRecipe(7181,155,1710,1,GAME_ORIG,155,175,195,215)
	self:addTradeFlags(RecipeDB,7181, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,7181,1,1386,1,4160,1,4611,1,7948,1,16588,1,18802
	,1,19052,1,16642,1,27029,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,3964,
	1,2132,1,3184,1,33608,1,33674,1,2391,1,27023,1,4900,1,1215,1,5499,1,16161)

	-- Elixir of Minor Defense -- 7183
	AddRecipe(7183,1,5997,1,GAME_ORIG,1,55,75,95)
	self:addTradeFlags(RecipeDB,7183,1,3,F_IBOE, 41,52)
	self:addTradeAcquire(RecipeDB,7183,8,8)

	-- Holy Protection Potion -- 7255
	AddRecipe(7255,100,6051,1,GAME_ORIG,100,130,150,170)
	self:addTradeFlags(RecipeDB,7255, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,7255,2,1685,2,3134,2,3490)

	-- Shadow Protection Potion -- 7256
	AddRecipe(7256,135,6048,1,GAME_ORIG,135,160,180,200)
	self:addTradeFlags(RecipeDB,7256, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,7256,2,2393,2,3956)

	-- Fire Protection Potion -- 7257
	AddRecipe(7257,165,6049,1,GAME_ORIG,165,210,230,250)
	self:addTradeFlags(RecipeDB,7257, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,7257,2,4083,2,2380)

	-- Frost Protection Potion -- 7258
	AddRecipe(7258,190,6050,1,GAME_ORIG,190,205,225,245)
	self:addTradeFlags(RecipeDB,7258, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,7258,2,2812,2,2848)

	-- Nature Protection Potion -- 7259
	AddRecipe(7259,190,6052,1,GAME_ORIG,190,210,230,250)
	self:addTradeFlags(RecipeDB,7259, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,7259,2,2848,2,8157,2,8158,2,5594)

	-- Blackmouth Oil -- 7836
	AddRecipe(7836,80,6370,1,GAME_ORIG,80,80,90,100)
	self:addTradeFlags(RecipeDB,7836, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,7836,1,1386,1,2391,1,2837,1,3009,1,3347,1,4160,
	1,4611,1,5177,1,5499,1,7948,1,16588,1,16642,1,16723,1,18802,1,19052,
	1,27029,1,3603,1,1470,1,3964,1,2132,1,3184,1,33608,1,33674,1,27023,1,4900,1,1215,1
	,16161)

	-- Fire Oil -- 7837
	AddRecipe(7837,130,6371,1,GAME_ORIG,130,150,160,170)
	self:addTradeFlags(RecipeDB,7837, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,7837,1,1386,1,2391,1,2837,1,3009,1,3347,1,3964,1
	,4160,1,4611,1,5177,1,5499,1,7948,1,16588,1,16642,1,16723,1,18802,1
	,19052,1,27029,1,3603,1,1470,1,2132,1,3184,1,33608,1,33674,1,27023,1,4900,1,1215,1
	,16161)

	-- Swim Speed Potion -- 7841
	AddRecipe(7841,100,6372,1,GAME_ORIG,100,130,150,170)
	self:addTradeFlags(RecipeDB,7841, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,7841,1,1386,1,2391,1,2837,1,3009,1,3347,1,4160,
	1,4611,1,5177,1,5499,1,7948,1,16588,1,16642,1,16723,1,18802,1,19052,
	1,27029,1,3603,1,1470,1,3964,1,2132,1,3184,1,33608,1,33674,1,27023,1,4900,1,1215,
	1,16161)

	-- Elixir of Firepower -- 7845
	AddRecipe(7845,140,6373,1,GAME_ORIG,140,165,185,205)
	self:addTradeFlags(RecipeDB,7845, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,53,54)
	self:addTradeAcquire(RecipeDB,7845,1,1386,1,2391,1,2837,1,3009,1,3347,1,3964,1
	,4160,1,4611,1,5177,1,5499,1,7948,1,16588,1,16642,1,16723,1,18802,1
	,19052,1,27029,1,3603,1,1470,1,2132,1,3184,1,33608,1,33674,1,27023,1,4900,1,1215,1
	,16161)

	-- Elixir of Giant Growth -- 8240
	AddRecipe(8240,90,6662,2,GAME_ORIG,90,120,140,160)
	self:addTradeFlags(RecipeDB,8240, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE,51)
	self:addTradeAcquire(RecipeDB,8240,7,2)

	-- Greater Mana Potion -- 11448
	AddRecipe(11448,205,6149,1,GAME_ORIG,205,220,240,260)
	self:addTradeFlags(RecipeDB,11448, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,11448,1,1386,1,4160,1,4611,1,7948,1,16588,1,
	18802,1,19052,1,16642,1,27029,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,
	3964,1,2132,1,3184,1,33608,1,33674,1,2391,1,27023,1,4900,1,1215,1,5499,1,16161)

	-- Elixir of Agility -- 11449
	AddRecipe(11449,185,8949,1,GAME_ORIG,185,205,225,245)
	self:addTradeFlags(RecipeDB,11449, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,51)
	self:addTradeAcquire(RecipeDB,11449,1,1386,1,4160,1,4611,1,7948,1,16588,1,
	18802,1,19052,1,16642,1,27029,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,
	3964,1,2132,1,3184,1,33608,1,33674,1,2391,1,27023,1,4900,1,1215,1,5499,1,16161)

	-- Elixir of Greater Defense -- 11450
	AddRecipe(11450,195,8951,1,GAME_ORIG,195,215,235,255)
	self:addTradeFlags(RecipeDB,11450, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,52)
	self:addTradeAcquire(RecipeDB,11450,1,1386,1,4160,1,4611,1,7948,1,16588,1,
	18802,1,19052,1,16642,1,27029,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,
	3964,1,2132,1,3184,1,33608,1,33674,1,2391,1,27023,1,4900,1,1215,1,5499,1,16161)

	-- Oil of Immolation -- 11451
	AddRecipe(11451,205,8956,1,GAME_ORIG,205,220,240,260)
	self:addTradeFlags(RecipeDB,11451, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,11451,1,1386,1,4160,1,4611,1,7948,1,16588,1,
	18802,1,19052,1,16642,1,27029,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,
	3964,1,2132,1,3184,1,33608,1,33674,1,2391,1,27023,1,4900,1,1215,1,5499,1,16161)

	-- Restorative Potion -- 11452
	AddRecipe(11452,210,9030,1,GAME_ORIG,210,225,245,265)
	self:addTradeFlags(RecipeDB,11452,1,2,8,F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,11452,4,2203,4,2501)

	-- Magic Resistance Potion -- 11453
	AddRecipe(11453,210,9036,2,GAME_ORIG,210,225,245,265)
	self:addTradeFlags(RecipeDB,11453, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,11453,7,2)

	-- Goblin Rocket Fuel -- 11456
	AddRecipe(11456,210,9061,1,GAME_ORIG,210,225,245,265)
	self:addTradeFlags(RecipeDB,11456, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,11456,8,9)

	-- Superior Healing Potion -- 11457
	AddRecipe(11457,215,3928,1,GAME_ORIG,215,230,250,270)
	self:addTradeFlags(RecipeDB,11457, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,11457,1,1386,1,4160,1,4611,1,7948,1,16588,1,
	18802,1,19052,1,16642,1,27029,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,
	3964,1,2132,1,3184,1,33608,1,33674,1,2391,1,27023,1,4900,1,1215,1,5499,1,16161)

	-- Wildvine Potion -- 11458
	AddRecipe(11458,225,9144,2,GAME_ORIG,225,240,260,280)
	self:addTradeFlags(RecipeDB,11458, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,11458,7,2)

	-- Philosopher's Stone -- 11459
	AddRecipe(11459,225,9149,1,GAME_ORIG,225,240,260,280)
	self:addTradeFlags(RecipeDB,11459, F_ALLIANCE, F_HORDE, F_QUEST, 37,41,53,54,61)
	self:addTradeAcquire(RecipeDB,11459,2,5594)

	-- Elixir of Detect Undead -- 11460
	AddRecipe(11460,230,9154,1,GAME_ORIG,230,245,265,285)
	self:addTradeFlags(RecipeDB,11460, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,11460,1,1386,1,7948,1,16588,1,18802,1,19052,1,
	4611,1,4160,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,3964,1,2132,1,3184
	,1,33608,1,16642,1,33674,1,2391,1,27023,1,27029,1,4900,1,1215,1,5499,1,16161)

	-- Arcane Elixir -- 11461
	AddRecipe(11461,235,9155,1,GAME_ORIG,235,250,270,290)
	self:addTradeFlags(RecipeDB,11461, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,53,54)
	self:addTradeAcquire(RecipeDB,11461,1,1386,1,7948,1,16588,1,18802,1,19052,1,
	4611,1,4160,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,3964,1,2132,1,3184
	,1,33608,1,16642,1,33674,1,2391,1,27023,1,27029,1,4900,1,1215,1,5499,1,16161)

	-- Invisibility Potion -- 11464
	AddRecipe(11464,235,9172,2,GAME_ORIG,235,250,270,290)
	self:addTradeFlags(RecipeDB,11464, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,11464,7,2)

	-- Elixir of Greater Intellect -- 11465
	AddRecipe(11465,235,9179,1,GAME_ORIG,235,250,270,290)
	self:addTradeFlags(RecipeDB,11465, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,11465,1,1386,1,7948,1,16588,1,18802,1,19052,1,
	4611,1,4160,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,3964,1,2132,1,3184
	,1,33608,1,16642,1,33674,1,2391,1,27023,1,27029,1,4900,1,1215,1,5499,1,16161)

	-- Gift of Arthas -- 11466
	AddRecipe(11466,240,9088,2,GAME_ORIG,240,255,275,295)
	self:addTradeFlags(RecipeDB,11466, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,11466,3,1783,3,1791)

	-- Elixir of Greater Agility -- 11467
	AddRecipe(11467,240,9187,1,GAME_ORIG,240,255,275,295)
	self:addTradeFlags(RecipeDB,11467, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,51)
	self:addTradeAcquire(RecipeDB,11467,1,1386,1,7948,1,16588,1,18802,1,19052,1,
	4611,1,4160,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,3964,1,2132,1,3184
	,1,33608,1,16642,1,33674,1,2391,1,27023,1,27029,1,4900,1,1215,1,5499,1,16161)

	-- Elixir of Dream Vision -- 11468
	AddRecipe(11468,240,9197,2,GAME_ORIG,240,255,275,295)
	self:addTradeFlags(RecipeDB,11468, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,11468,7,2)

	-- Elixir of Giants -- 11472
	AddRecipe(11472,245,9206,2,GAME_ORIG,245,260,280,300)
	self:addTradeFlags(RecipeDB,11472, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE,51)
	self:addTradeAcquire(RecipeDB,11472,7,2)

	-- Ghost Dye -- 11473
	AddRecipe(11473,245,9210,1,GAME_ORIG,245,260,280,300)
	self:addTradeFlags(RecipeDB,11473, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,11473,2,8157,2,8158)

	-- Elixir of Shadow Power -- 11476
	AddRecipe(11476,250,9264,2,GAME_ORIG,250,265,285,305)
	self:addTradeFlags(RecipeDB,11476, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOE,53,54)
	self:addTradeAcquire(RecipeDB,11476,2,1313,2,4610)

	-- Elixir of Demonslaying -- 11477
	AddRecipe(11477,250,9224,1,GAME_ORIG,250,265,285,305)
	self:addTradeFlags(RecipeDB,11477, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOE,51)
	self:addTradeAcquire(RecipeDB,11477,2,8177,2,8178)

	-- Elixir of Detect Demon -- 11478
	AddRecipe(11478,250,9233,1,GAME_ORIG,250,265,285,305)
	self:addTradeFlags(RecipeDB,11478, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,11478,1,1386,1,7948,1,16588,1,18802,1,19052,1,
	4611,1,4160,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,3964,1,2132,1,3184
	,1,33608,1,16642,1,33674,1,2391,1,27023,1,27029,1,4900,1,1215,1,5499,1,16161)

	-- Transmute: Iron to Gold -- 11479
	AddRecipe(11479,225,3577,1,GAME_ORIG,225,240,260,280)
	self:addTradeFlags(RecipeDB,11479, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,11479,2,5594)

	-- Transmute: Mithril to Truesilver -- 11480
	AddRecipe(11480,225,6037,1,GAME_ORIG,225,240,260,280)
	self:addTradeFlags(RecipeDB,11480, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,11480,2,5594)

	-- Catseye Elixir -- 12609
	AddRecipe(12609,200,10592,1,GAME_ORIG,200,220,240,260)
	self:addTradeFlags(RecipeDB,12609, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,12609,1,1386,1,4160,1,4611,1,7948,1,16588,1,
	18802,1,19052,1,16642,1,27029,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,
	3964,1,2132,1,3184,1,33608,1,33674,1,2391,1,27023,1,4900,1,1215,1,5499,1,16161)

	-- Dreamless Sleep Potion -- 15833
	AddRecipe(15833,230,12190,1,GAME_ORIG,230,245,265,285)
	self:addTradeFlags(RecipeDB,15833, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,15833,1,1386,1,7948,1,16588,1,18802,1,19052,1,
	4611,1,4160,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,3964,1,2132,1,3184
	,1,33608,1,16642,1,33674,1,2391,1,27023,1,27029,1,4900,1,1215,1,5499,1,16161)

	-- Transmute: Arcanite -- 17187
	AddRecipe(17187,275,12360,1,GAME_ORIG,275,275,282,290)
	self:addTradeFlags(RecipeDB,17187, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,17187,2,5594)

	-- Stonescale Oil -- 17551
	AddRecipe(17551,250,13423,1,GAME_ORIG,250,250,255,260)
	self:addTradeFlags(RecipeDB,17551, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,17551,1,1386,1,7948,1,16588,1,18802,1,19052,1,
	4611,1,4160,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,3964,1,2132,1,3184
	,1,33608,1,16642,1,33674,1,2391,1,27023,1,27029,1,4900,1,1215,1,5499,1,16161)

	-- Mighty Rage Potion -- 17552
	AddRecipe(17552,255,13442,2,GAME_ORIG,255,270,290,310)
	self:addTradeFlags(RecipeDB,17552, F_ALLIANCE, F_HORDE, F_TRAINER, F_DRUID,F_WARRIOR,F_IBOE, F_RBOE,51,52)
	self:addTradeAcquire(RecipeDB,17552,1,1386,1,7948,1,16588,1,18802,1,19052,1,
	4611,1,4160,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,3964,1,2132,1,3184
	,1,33608,1,16642,1,33674,1,2391,1,27023,1,27029,1,4900,1,1215,1,5499,1,16161)

	-- Superior Mana Potion -- 17553
	AddRecipe(17553,260,13443,1,GAME_ORIG,260,275,295,315)
	self:addTradeFlags(RecipeDB,17553, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,17553,1,1386,1,7948,1,16588,1,18802,1,19052,1,
	4611,1,4160,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,3964,1,2132,1,3184
	,1,33608,1,16642,1,33674,1,2391,1,27023,1,27029,1,4900,1,1215,1,5499,1,16161)

	-- Elixir of Superior Defense -- 17554
	AddRecipe(17554,265,13445,1,GAME_ORIG,265,280,300,320)
	self:addTradeFlags(RecipeDB,17554, F_ALLIANCE, F_HORDE, F_TRAINER, F_QUEST ,F_IBOE, F_RBOE,52)
	self:addTradeAcquire(RecipeDB,17554,2,5178,2,3348)

	-- Elixir of the Sages -- 17555
	AddRecipe(17555,270,13447,2,GAME_ORIG,270,285,305,325)
	self:addTradeFlags(RecipeDB,17555, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOE,53,54)
	self:addTradeAcquire(RecipeDB,17555,1,1386,1,7948,1,16588,1,18802,1,19052,1,
	4611,1,4160,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,3964,1,2132,1,3184
	,1,33608,1,16642,1,33674,1,2391,1,27023,1,27029,1,4900,1,1215,1,5499,1,16161)

	-- Major Healing Potion -- 17556
	AddRecipe(17556,275,13446,1,GAME_ORIG,275,290,310,330)
	self:addTradeFlags(RecipeDB,17556, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,17556,1,1386,1,7948,1,16588,1,18802,1,19052,1,
	4611,1,4160,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,3964,1,2132,1,3184
	,1,33608,1,16642,1,33674,1,2391,1,27023,1,27029,1,4900,1,1215,1,5499,1,16161)

	-- Elixir of Brute Force -- 17557
	AddRecipe(17557,275,13453,2,GAME_ORIG,275,290,310,330)
	self:addTradeFlags(RecipeDB,17557, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOE,51)
	self:addTradeAcquire(RecipeDB,17557,1,1386,1,7948,1,16588,1,18802,1,19052,1,
	4611,1,4160,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,3964,1,2132,1,3184
	,1,33608,1,16642,1,33674,1,2391,1,27023,1,27029,1,4900,1,1215,1,5499,1,16161)

	-- Transmute: Air to Fire -- 17559
	AddRecipe(17559,275,7078,2,GAME_ORIG,275,275,282,290)
	self:addTradeFlags(RecipeDB,17559, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,96)
	self:addTradeAcquire(RecipeDB,17559,6,529,2,10856,6,529,2,10857,6,529,2,11536)

	-- Transmute: Fire to Earth -- 17560
	AddRecipe(17560,275,7076,2,GAME_ORIG,275,275,282,290)
	self:addTradeFlags(RecipeDB,17560,F_ALLIANCE, F_HORDE,4,F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,17560,2,9499)

	-- Transmute: Earth to Water -- 17561
	AddRecipe(17561,275,7080,2,GAME_ORIG,275,275,282,290)
	self:addTradeFlags(RecipeDB,17561, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,99)
	self:addTradeAcquire(RecipeDB,17561,6,576,1,11557)

	-- Transmute: Water to Air -- 17562
	AddRecipe(17562,275,7082,2,GAME_ORIG,275,275,282,290)
	self:addTradeFlags(RecipeDB,17562, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,17562,2,11278)

	-- Transmute: Undeath to Water -- 17563
	AddRecipe(17563,275,7080,2,GAME_ORIG,275,275,282,290)
	self:addTradeFlags(RecipeDB,17563, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,17563,7,2)

	-- Transmute: Water to Undeath -- 17564
	AddRecipe(17564,275,12808,2,GAME_ORIG,275,275,282,290)
	self:addTradeFlags(RecipeDB,17564, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,17564,7,2)

	-- Transmute: Life to Earth -- 17565
	AddRecipe(17565,275,7076,2,GAME_ORIG,275,275,282,290)
	self:addTradeFlags(RecipeDB,17565, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,17565,7,2)

	-- Transmute: Earth to Life -- 17566
	AddRecipe(17566,275,12803,2,GAME_ORIG,275,275,282,290)
	self:addTradeFlags(RecipeDB,17566, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,17566,7,2)

	-- Greater Stoneshield Potion -- 17570
	AddRecipe(17570,280,13455,2,GAME_ORIG,280,295,315,335)
	self:addTradeFlags(RecipeDB,17570, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,17570,7,2)

	-- Elixir of the Mongoose -- 17571
	AddRecipe(17571,280,13452,2,GAME_ORIG,280,295,315,335)
	self:addTradeFlags(RecipeDB,17571, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, F_RBOE,51)
	self:addTradeAcquire(RecipeDB,17571,3,6201,3,7106)

	-- Purification Potion -- 17572
	AddRecipe(17572,285,13462,2,GAME_ORIG,285,300,320,340)
	self:addTradeFlags(RecipeDB,17572, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,17572,1,1386,1,7948,1,16588,1,18802,1,19052,1,
	4611,1,4160,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,3964,1,2132,1,3184
	,1,33608,1,16642,1,33674,1,2391,1,27023,1,27029,1,4900,1,1215,1,5499,1,16161)

	-- Greater Arcane Elixir -- 17573
	AddRecipe(17573,285,13454,2,GAME_ORIG,285,300,320,340)
	self:addTradeFlags(RecipeDB,17573, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOE,53,54)
	self:addTradeAcquire(RecipeDB,17573,1,1386,1,7948,1,16588,1,18802,1,19052,1,
	4611,1,4160,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,3964,1,2132,1,3184
	,1,33608,1,16642,1,33674,1,2391,1,27023,1,27029,1,4900,1,1215,1,5499,1,16161)

	-- Greater Fire Protection Potion -- 17574
	AddRecipe(17574,290,13457,2,GAME_ORIG,290,305,325,345)
	self:addTradeFlags(RecipeDB,17574,1,2,5,F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,17574,3,9262,3,9264)

	-- Greater Frost Protection Potion -- 17575
	AddRecipe(17575,290,13456,2,GAME_ORIG,290,305,325,345)
	self:addTradeFlags(RecipeDB,17575, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,17575,3,7428)

	-- Greater Nature Protection Potion -- 17576
	AddRecipe(17576,290,13458,2,GAME_ORIG,290,305,325,345)
	self:addTradeFlags(RecipeDB,17576, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,17576,3,1812,3,1813)

	-- Greater Arcane Protection Potion -- 17577
	AddRecipe(17577,290,13461,2,GAME_ORIG,290,305,325,345)
	self:addTradeFlags(RecipeDB,17577, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,17577,3,7437)

	-- Greater Shadow Protection Potion -- 17578
	AddRecipe(17578,290,13459,2,GAME_ORIG,290,305,325,345)
	self:addTradeFlags(RecipeDB,17578, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,17578,3,8546,3,8550)

	-- Major Mana Potion -- 17580
	AddRecipe(17580,295,13444,2,GAME_ORIG,295,310,330,350)
	self:addTradeFlags(RecipeDB,17580, F_ALLIANCE, F_HORDE, F_QUEST, 5,F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,17580,3,1853,2,11278)

	-- Alchemist's Stone -- 17632
	AddRecipe(17632,350,13503,1,GAME_ORIG,350,365,372,380)
	self:addTradeFlags(RecipeDB,17632, F_ALLIANCE, F_HORDE, F_VENDOR, 37,41,53,54, F_TRINKET, 111)
	self:addTradeAcquire(RecipeDB,17632,6,935,3,21432)

	-- Flask of Petrification -- 17634
	AddRecipe(17634,300,13506,2,GAME_ORIG,300,315,322,330)
	self:addTradeFlags(RecipeDB,17634, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,17634,7,2)

	-- Flask of the Titans -- 17635
	AddRecipe(17635,300,13510,2,1,300,315,322,330)
	self:addTradeFlags(RecipeDB,17635, F_ALLIANCE, F_HORDE, F_VENDOR, 5,F_IBOE, 41,111, F_TANK)
	self:addTradeAcquire(RecipeDB,17635,3,10363,6,935,4,21432)

	-- Flask of Distilled Wisdom -- 17636
	AddRecipe(17636,300,13511,2,1,300,315,322,330)
	self:addTradeFlags(RecipeDB,17636, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,103, F_CASTER, F_HEALER)
	self:addTradeAcquire(RecipeDB,17636,6,942,4,17904,3,10813)

	-- Flask of Supreme Power -- 17637
	AddRecipe(17637,300,13512,2,1,300,315,322,330)
	self:addTradeFlags(RecipeDB,17637, F_ALLIANCE, F_HORDE, F_QUEST, 5,F_IBOE, 41,53,54,106)
	self:addTradeAcquire(RecipeDB,17637,3,10508,6,989,4,21643)

	-- Flask of Chromatic Resistance -- 17638
	AddRecipe(17638,300,13513,2,1,300,315,322,330)
	self:addTradeFlags(RecipeDB,17638, F_ALLIANCE, F_HORDE, F_QUEST, 5,F_IBOE, 41,
	107)
	self:addTradeAcquire(RecipeDB,17638,3,10339,6,1011,4,21655)

	-- Elixir of Frost Power -- 21923
	AddRecipe(21923,190,17708,1,GAME_ORIG,190,210,230,250)
	self:addTradeFlags(RecipeDB,21923,1,2,7,F_IBOE, F_RBOE,53,54)
	self:addTradeAcquire(RecipeDB,21923,5,1)

	-- Major Rejuvenation Potion -- 22732
	AddRecipe(22732,300,18253,3,GAME_ORIG,300,310,320,330)
	self:addTradeFlags(RecipeDB,22732,1,2,6,F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,22732,8,26)

	-- Elixir of Greater Water Breathing -- 22808
	AddRecipe(22808,215,18294,1,GAME_ORIG,215,230,250,270)
	self:addTradeFlags(RecipeDB,22808, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,22808,1,1386,1,4160,1,4611,1,7948,1,16588,1,
	18802,1,19052,1,16642,1,27029,1,3603,1,16723,1,3347,1,3009,1,2837,1,5177,1,1470,1,
	3964,1,2132,1,3184,1,33608,1,33674,1,2391,1,27023,1,4900,1,1215,1,16161)

	-- Gurubashi Mojo Madness -- 24266
	AddRecipe(24266,300,19931,3,GAME_ORIG,300,315,322,330)
	self:addTradeFlags(RecipeDB,24266,1,2,6,F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,24266,8,11)

	-- Mageblood Elixir -- 24365
	AddRecipe(24365,275,20007,1,GAME_ORIG,275,290,310,330)
	self:addTradeFlags(RecipeDB,24365, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,
	100)
	self:addTradeAcquire(RecipeDB,24365,6,270,3,14921)

	-- Greater Dreamless Sleep Potion -- 24366
	AddRecipe(24366,275,20002,1,GAME_ORIG,275,290,310,330)
	self:addTradeFlags(RecipeDB,24366, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,
	100)
	self:addTradeAcquire(RecipeDB,24366,6,270,1,14921)

	-- Living Action Potion -- 24367
	AddRecipe(24367,285,20008,1,GAME_ORIG,285,300,320,340)
	self:addTradeFlags(RecipeDB,24367, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,
	100)
	self:addTradeAcquire(RecipeDB,24367,6,270,4,14921)

	-- Major Troll's Blood Elixir -- 24368
	AddRecipe(24368,290,20004,1,GAME_ORIG,290,305,325,345)
	self:addTradeFlags(RecipeDB,24368, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,
	100)
	self:addTradeAcquire(RecipeDB,24368,6,270,2,14921)

	-- Transmute: Elemental Fire -- 25146
	AddRecipe(25146,300,7068,1,GAME_ORIG,300,301,305,310)
	self:addTradeFlags(RecipeDB,25146, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,98)
	self:addTradeAcquire(RecipeDB,25146,6,59,1,12944)

	-- Elixir of Greater Firepower -- 26277
	AddRecipe(26277,250,21546,2,GAME_ORIG,250,265,285,305)
	self:addTradeFlags(RecipeDB,26277, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, F_RBOE,53,54)
	self:addTradeAcquire(RecipeDB,26277,3,5844,3,5846,3,8637)

	-- Elixir of Camouflage -- 28543
	AddRecipe(28543,305,22823,1,1,305,320,327,335)
	self:addTradeFlags(RecipeDB,28543, F_ALLIANCE, F_HORDE, F_TRAINER, 4,F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,28543,2,16588,2,16641,2,16705,2,18802)

	-- Elixir of Major Strength -- 28544
	AddRecipe(28544,305,22824,1,1,305,320,327,335)
	self:addTradeFlags(RecipeDB,28544, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,51)
	self:addTradeAcquire(RecipeDB,28544,1,16588,1,18802,1,19052,1,27029,1,33608,1,
	33674,1,27023)

	-- Elixir of Healing Power -- 28545
	AddRecipe(28545,310,22825,1,1,310,325,332,340)
	self:addTradeFlags(RecipeDB,28545, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,53,54)
	self:addTradeAcquire(RecipeDB,28545,1,16588,1,18802,1,19052,1,27029,1,33608,1,
	33674,1,27023)

	-- Sneaking Potion -- 28546
	AddRecipe(28546,315,22826,1,1,315,330,337,345)
	self:addTradeFlags(RecipeDB,28546, F_ALLIANCE, F_HORDE, F_VENDOR, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,28546,2,18017,2,19042)

	-- Elixir of Major Frost Power -- 28549
	AddRecipe(28549,320,22827,1,1,320,335,342,350)
	self:addTradeFlags(RecipeDB,28549, F_ALLIANCE, F_HORDE, F_TRAINER, 4,F_IBOE, F_RBOE,53,54)
	self:addTradeAcquire(RecipeDB,28549,2,18005,2,18017)

	-- Insane Strength Potion -- 28550
	AddRecipe(28550,320,22828,2,1,320,335,342,350)
	self:addTradeFlags(RecipeDB,28550, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE,51)
	self:addTradeAcquire(RecipeDB,28550,7,2)

	-- Super Healing Potion -- 28551
	AddRecipe(28551,325,22829,1,1,325,340,347,355)
	self:addTradeFlags(RecipeDB,28551, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,28551,1,16588,1,18802,1,19052,1,27029,1,33608,1,
	33674,1,27023)

	-- Elixir of the Searching Eye -- 28552
	AddRecipe(28552,325,22830,2,1,325,340,347,355)
	self:addTradeFlags(RecipeDB,28552, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,28552,7,2)

	-- Elixir of Major Agility -- 28553
	AddRecipe(28553,330,22831,1,1,330,345,352,360)
	self:addTradeFlags(RecipeDB,28553, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,51,104)
	self:addTradeAcquire(RecipeDB,28553,6,946,2,17657,6,947,2,17585)

	-- Shrouding Potion -- 28554
	AddRecipe(28554,335,22871,2,1,335,350,357,365)
	self:addTradeFlags(RecipeDB,28554, F_ALLIANCE, F_HORDE, F_VENDOR, F_IBOE, 41, 113)
	self:addTradeAcquire(RecipeDB,28554,6,970,4,18382)

	-- Super Mana Potion -- 28555
	AddRecipe(28555,340,22832,1,1,340,355,362,370)
	self:addTradeFlags(RecipeDB,28555, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,28555,2,18005,2,19837)

	-- Elixir of Major Firepower -- 28556
	AddRecipe(28556,345,22833,2,1,345,360,367,375)
	self:addTradeFlags(RecipeDB,28556, F_ALLIANCE, F_HORDE, F_TRAINER, 4,F_IBOE, 41,53,54,110)
	self:addTradeAcquire(RecipeDB,28556,6,934,3,19331)

	-- Elixir of Major Defense -- 28557
	AddRecipe(28557,345,22834,1,1,345,360,367,375)
	self:addTradeFlags(RecipeDB,28557, F_ALLIANCE, F_HORDE, F_TRAINER, 4,F_IBOE, F_RBOE,52)
	self:addTradeAcquire(RecipeDB,28557,2,18005,2,19837)

	-- Elixir of Major Shadow Power -- 28558
	AddRecipe(28558,350,22835,2,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,28558, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,53
	,54,107)
	self:addTradeAcquire(RecipeDB,28558,6,1011,3,21655)

	-- Major Dreamless Sleep Potion -- 28562
	AddRecipe(28562,350,22836,1,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,28562, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,28562,2,19042,2,19837)

	-- Heroic Potion -- 28563
	AddRecipe(28563,350,22837,2,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,28563, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE,51)
	self:addTradeAcquire(RecipeDB,28563,7,2)

	-- Haste Potion -- 28564 -- THERE'S 2 VERSIONS?
	AddRecipe(28564,350,22838,2,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,28564, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,28564,3,24664)

	-- Destruction Potion -- 28565
	AddRecipe(28565,350,22839,2,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,28565, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE,53,54)
	self:addTradeAcquire(RecipeDB,28565,7,2)

	-- Transmute: Primal Air to Fire -- 28566
	AddRecipe(28566,350,21884,2,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,28566, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,111)
	self:addTradeAcquire(RecipeDB,28566,6,935,3,21432)

	-- Transmute: Primal Earth to Water -- 28567
	AddRecipe(28567,350,21885,2,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,28567, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,113)
	self:addTradeAcquire(RecipeDB,28567,6,970,3,18382)

	-- Transmute: Primal Fire to Earth -- 28568
	AddRecipe(28568,350,22452,2,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,28568, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,108)
	self:addTradeAcquire(RecipeDB,28568,6,978,3,20240)

	-- Transmute: Primal Water to Air -- 28569
	AddRecipe(28569,350,22451,2,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,28569, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,103)
	self:addTradeAcquire(RecipeDB,28569,6,942,3,17904)

	-- Elixir of Major Mageblood -- 28570
	AddRecipe(28570,355,22840,2,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,28570, F_ALLIANCE, F_HORDE, F_WORLD_DROP, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,28570,7,2)

	-- Major Fire Protection Potion -- 28571
	AddRecipe(28571,360,22841,2,1,360,375,377,380)
	self:addTradeFlags(RecipeDB,28571,1,2,5,F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,28571,3,19168,3,19221)

	-- Major Frost Protection Potion -- 28572
	AddRecipe(28572,360,22842,2,1,360,375,377,380)
	self:addTradeFlags(RecipeDB,28572,1,2,5,11,F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,28572,3,18344)

	-- Major Nature Protection Potion -- 28573
	AddRecipe(28573,360,22844,1,1,360,375,377,380)
	self:addTradeFlags(RecipeDB,28573, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,
	103)
	self:addTradeAcquire(RecipeDB,28573,6,942,4,17904)

	-- Major Arcane Protection Potion -- 28575
	AddRecipe(28575,360,22845,2,1,360,375,377,380)
	self:addTradeFlags(RecipeDB,28575, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,28575,3,17150)

	-- Major Shadow Protection Potion -- 28576
	AddRecipe(28576,360,22846,2,1,360,375,377,380)
	self:addTradeFlags(RecipeDB,28576, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,28576,3,21302)

	-- Major Holy Protection Potion -- 28577
	AddRecipe(28577,360,22847,2,1,360,375,377,380)
	self:addTradeFlags(RecipeDB,28577, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,28577,3,19973)

	-- Elixir of Empowerment -- 28578   -- THERE'S 2 VERSIONS?
	AddRecipe(28578,365,22848,2,1,365,375,377,380)
	self:addTradeFlags(RecipeDB,28578, F_ALLIANCE, F_HORDE, F_TRAINER, 11,F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,28578,3,24664)

	-- Ironshield Potion -- 28579
	AddRecipe(28579,365,22849,2,1,365,375,377,380)
	self:addTradeFlags(RecipeDB,28579,1,2,5,F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,28579,3,17862)

	-- Transmute: Primal Shadow to Water -- 28580
	AddRecipe(28580,370,21885,2,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,28580, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,28580,8,3)

	-- Transmute: Primal Water to Shadow -- 28581
	AddRecipe(28581,370,22456,2,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,28581, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,28581,8,3)

	-- Transmute: Primal Mana to Fire -- 28582
	AddRecipe(28582,370,21884,2,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,28582, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,28582,8,3)

	-- Transmute: Primal Fire to Mana -- 28583
	AddRecipe(28583,370,22457,2,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,28583, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,28583,8,3)

	-- Transmute: Primal Life to Earth -- 28584
	AddRecipe(28584,370,22452,2,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,28584, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,28584,8,3)

	-- Transmute: Primal Earth to Life -- 28585
	AddRecipe(28585,370,21886,2,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,28585, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,28585,8,3)

	-- Super Rejuvenation Potion -- 28586
	AddRecipe(28586,375,22850,1,1,375,375,377,380)
	self:addTradeFlags(RecipeDB,28586, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,28586,8,2)

	-- Flask of Fortification -- 28587
	AddRecipe(28587,375,22851,1,1,375,375,377,380)
	self:addTradeFlags(RecipeDB,28587, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, 41,52)
	self:addTradeAcquire(RecipeDB,28587,8,1)

	-- Flask of Mighty Restoration -- 28588
	AddRecipe(28588,375,22853,1,1,375,375,377,380)
	self:addTradeFlags(RecipeDB,28588, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,28588,8,1)

	-- Flask of Relentless Assault -- 28589
	AddRecipe(28589,375,22854,1,1,375,375,377,380)
	self:addTradeFlags(RecipeDB,28589, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, 41,51)
	self:addTradeAcquire(RecipeDB,28589,8,1)

	-- Flask of Blinding Light -- 28590
	AddRecipe(28590,375,22861,1,1,375,375,377,380)
	self:addTradeFlags(RecipeDB,28590, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, 41,53,54)
	self:addTradeAcquire(RecipeDB,28590,8,1)

	-- Flask of Pure Death -- 28591
	AddRecipe(28591,375,22866,1,1,375,375,377,380)
	self:addTradeFlags(RecipeDB,28591, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, 41,53,54)
	self:addTradeAcquire(RecipeDB,28591,8,1)

	-- Transmute: Primal Might -- 29688
	AddRecipe(29688,350,23571,2,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,29688, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,29688,2,16641,2,16705,2,19074)

	-- Transmute: Earthstorm Diamond -- 32765
	AddRecipe(32765,350,25867,1,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,32765, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,
	103)
	self:addTradeAcquire(RecipeDB,32765,6,942,2,17904)

	-- Transmute: Skyfire Diamond -- 32766
	AddRecipe(32766,350,25868,1,1,350,365,372,380)
	self:addTradeFlags(RecipeDB,32766, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,
	104)
	self:addTradeAcquire(RecipeDB,32766,6,946,2,17657,6,947,2,17585)

	-- Volatile Healing Potion -- 33732
	AddRecipe(33732,300,28100,1,1,300,315,322,330)
	self:addTradeFlags(RecipeDB,33732, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,33732,1,16588,1,18802,1,19052,1,27029,1,33608,1,
	33674,1,27023)

	-- Unstable Mana Potion -- 33733
	AddRecipe(33733,310,28101,1,1,310,325,332,340)
	self:addTradeFlags(RecipeDB,33733, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,33733,1,16588,1,18802,1,19052,1,27029,1,33608,1,
	33674,1,27023)

	-- Onslaught Elixir -- 33738
	AddRecipe(33738,300,28102,1,1,300,315,322,330)
	self:addTradeFlags(RecipeDB,33738, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,51)
	self:addTradeAcquire(RecipeDB,33738,1,16588,1,18802,1,19052,1,27029,1,33608,1,
	33674,1,27023)

	-- Adept's Elixir -- 33740
	AddRecipe(33740,300,28103,1,GAME_ORIG,300,315,322,330)
	self:addTradeFlags(RecipeDB,33740, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,53,54)
	self:addTradeAcquire(RecipeDB,33740,1,16588,1,18802,1,19052,1,27029,1,33608,1,
	33674,1,27023)

	-- Elixir of Mastery -- 33741
	AddRecipe(33741,315,28104,1,1,315,330,337,345)
	self:addTradeFlags(RecipeDB,33741, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,33741,1,16588,1,18802,1,19052,1,27029,1,33608,1,
	33674,1,27023)

	-- Mercurial Stone -- 38070
	AddRecipe(38070,325,31080,1,1,325,340,347,355)
	self:addTradeFlags(RecipeDB,38070, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP,61)
	self:addTradeAcquire(RecipeDB,38070,1,16588,1,18802,1,19052,1,27029,1,33608,1,
	33674,1,27023)

	-- Fel Strength Elixir -- 38960
	AddRecipe(38960,335,31679,3,1,335,350,357,365)
	self:addTradeFlags(RecipeDB,38960, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, 41,51)
	self:addTradeAcquire(RecipeDB,38960,3,19740,3,19755,3,21302,3,21314)

	-- Fel Mana Potion -- 38961
	AddRecipe(38961,360,31677,3,1,360,375,377,380)
	self:addTradeFlags(RecipeDB,38961, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, 41,53,54)
	self:addTradeAcquire(RecipeDB,38961,3,19792,3,19795,3,19796,3,19806,3,22016,3,
	22017,3,22018,3,22076,3,22093)

	-- Fel Regeneration Potion -- 38962
	AddRecipe(38962,345,31676,3,1,345,360,367,375)
	self:addTradeFlags(RecipeDB,38962, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,38962,3,19754,3,19756,3,20878,3,20887)

	-- Elixir of Major Fortitude -- 39636
	AddRecipe(39636,310,32062,1,1,310,325,332,340)
	self:addTradeFlags(RecipeDB,39636, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,39636,1,16588,1,18802,1,19052,1,27029,1,33608,1,
	33674,1,27023)

	-- Earthen Elixir -- 39637
	AddRecipe(39637,320,32063,1,1,320,335,342,350)
	self:addTradeFlags(RecipeDB,39637, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, 41,
	103)
	self:addTradeAcquire(RecipeDB,39637,6,942,2,17904)

	-- Elixir of Draenic Wisdom -- 39638
	AddRecipe(39638,320,32067,1,1,320,335,342,350)
	self:addTradeFlags(RecipeDB,39638, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,53,54)
	self:addTradeAcquire(RecipeDB,39638,1,16588,1,18802,1,19052,1,27029,1,33608,1,
	33674,1,27023)

	-- Elixir of Ironskin -- 39639
	AddRecipe(39639,330,32068,1,1,330,345,352,360)
	self:addTradeFlags(RecipeDB,39639, F_ALLIANCE, F_HORDE, F_QUEST, 9,F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,39639,2,18821,2,18822)

	-- Cauldron of Major Arcane Protection -- 41458
	AddRecipe(41458,360,32839,1,1,360,360,370,380)
	self:addTradeFlags(RecipeDB,41458, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,41458,8,4)

	-- Cauldron of Major Fire Protection -- 41500
	AddRecipe(41500,360,32849,1,1,360,360,370,380)
	self:addTradeFlags(RecipeDB,41500, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,41500,8,4)

	-- Cauldron of Major Frost Protection -- 41501
	AddRecipe(41501,360,32850,1,1,360,360,370,380)
	self:addTradeFlags(RecipeDB,41501, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,41501,8,4)

	-- Cauldron of Major Nature Protection -- 41502
	AddRecipe(41502,360,32851,1,1,360,360,370,380)
	self:addTradeFlags(RecipeDB,41502, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,41502,8,4)

	-- Cauldron of Major Shadow Protection -- 41503
	AddRecipe(41503,360,32852,1,1,360,360,370,380)
	self:addTradeFlags(RecipeDB,41503, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,41503,8,4)

	-- Flask of Chromatic Wonder -- 42736
	AddRecipe(42736,375,33208,2,1,375,390,397,405)
	self:addTradeFlags(RecipeDB,42736, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOE,
	114)
	self:addTradeAcquire(RecipeDB,42736,6,967,2,18255)

	-- Mad Alchemist's Potion -- 45061
	AddRecipe(45061,325,34440,1,1,325,335,342,350)
	self:addTradeFlags(RecipeDB,45061, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,45061,1,16588,1,18802,1,19052,1,27023,1,27029,1,
	33608,1,33674)

	-- Guardian's Alchemist Stone -- 47046
	AddRecipe(47046,375,35748,1,1,375,380,385,390)
	self:addTradeFlags(RecipeDB,47046, F_ALLIANCE, F_HORDE, F_QUEST, 37,41,52,61,112)
	self:addTradeAcquire(RecipeDB,47046,6,1077,4,25032)

	-- Sorcerer's Alchemist Stone -- 47048
	AddRecipe(47048,375,35749,1,1,375,380,385,390)
	self:addTradeFlags(RecipeDB,47048, F_ALLIANCE, F_HORDE, F_QUEST, 37,41,53,54,61,112)
	self:addTradeAcquire(RecipeDB,47048,6,1077,4,25032)

	-- Redeemer's Alchemist Stone -- 47049
	AddRecipe(47049,375,35750,1,1,375,380,385,390)
	self:addTradeFlags(RecipeDB,47049, F_ALLIANCE, F_HORDE, F_QUEST, 37,41,53,54,61,112)
	self:addTradeAcquire(RecipeDB,47049,6,1077,4,25032)

	-- Assassin's Alchemist Stone -- 47050
	AddRecipe(47050,375,35751,1,1,375,380,385,390)
	self:addTradeFlags(RecipeDB,47050, F_ALLIANCE, F_HORDE, F_QUEST, 37,41,51,61,112)
	self:addTradeAcquire(RecipeDB,47050,6,1077,4,25032)

	-- Transmute: Eternal Life to Shadow -- 53771
	AddRecipe(53771,405,35627,2,2,405,405,415,425)
	self:addTradeFlags(RecipeDB,53771, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53771,8,19)

	-- Transmute: Eternal Life to Fire -- 53773
	AddRecipe(53773,405,36860,2,2,405,405,415,425)
	self:addTradeFlags(RecipeDB,53773, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53773,8,19)

	-- Transmute: Eternal Fire to Water -- 53774
	AddRecipe(53774,405,35622,2,2,405,405,415,425)
	self:addTradeFlags(RecipeDB,53774, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53774,8,19)

	-- Transmute: Eternal Fire to Life -- 53775
	AddRecipe(53775,405,35625,2,2,405,405,415,425)
	self:addTradeFlags(RecipeDB,53775, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53775,8,19)

	-- Transmute: Eternal Air to Water -- 53776
	AddRecipe(53776,405,35622,2,2,405,405,415,425)
	self:addTradeFlags(RecipeDB,53776, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53776,8,19)

	-- Transmute: Eternal Air to Earth -- 53777
	AddRecipe(53777,405,35624,2,2,405,405,415,425)
	self:addTradeFlags(RecipeDB,53777, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53777,8,19)

	-- Transmute: Eternal Shadow to Earth -- 53779
	AddRecipe(53779,405,35624,2,2,405,405,415,425)
	self:addTradeFlags(RecipeDB,53779, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53779,8,19)

	-- Transmute: Eternal Shadow to Life -- 53780
	AddRecipe(53780,405,35625,2,2,405,405,415,425)
	self:addTradeFlags(RecipeDB,53780, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53780,8,19)

	-- Transmute: Eternal Earth to Air -- 53781
	AddRecipe(53781,405,35623,2,2,405,405,415,425)
	self:addTradeFlags(RecipeDB,53781, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53781,8,19)

	-- Transmute: Eternal Earth to Shadow -- 53782
	AddRecipe(53782,405,35627,2,2,405,405,415,425)
	self:addTradeFlags(RecipeDB,53782, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53782,8,19)

	-- Transmute: Eternal Water to Air -- 53783
	AddRecipe(53783,405,35623,2,2,405,405,415,425)
	self:addTradeFlags(RecipeDB,53783, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53783,8,19)

	-- Transmute: Eternal Water to Fire -- 53784
	AddRecipe(53784,405,36860,2,2,405,405,415,425)
	self:addTradeFlags(RecipeDB,53784, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53784,8,19)

	-- Pygmy Oil -- 53812
	AddRecipe(53812,375,40195,1,2,375,380,385,390)
	self:addTradeFlags(RecipeDB,53812, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53812,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Runic Healing Potion -- 53836
	AddRecipe(53836,405,33447,1,2)
	self:addTradeFlags(RecipeDB,53836, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53836,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Runic Mana Potion -- 53837
	AddRecipe(53837,410,33448,1,2)
	self:addTradeFlags(RecipeDB,53837, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53837,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Resurgent Healing Potion -- 53838
	AddRecipe(53838,350,39671,1,2)
	self:addTradeFlags(RecipeDB,53838, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53838,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Icy Mana Potion -- 53839
	AddRecipe(53839,360,40067,1,2)
	self:addTradeFlags(RecipeDB,53839, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53839,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Elixir of Mighty Agility -- 53840
	AddRecipe(53840,395,39666,1,2)
	self:addTradeFlags(RecipeDB,53840, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,51)
	self:addTradeAcquire(RecipeDB,53840,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Wrath Elixir -- 53841
	AddRecipe(53841,355,40068,1,2)
	self:addTradeFlags(RecipeDB,53841, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,51)
	self:addTradeAcquire(RecipeDB,53841,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Spellpower Elixir -- 53842
	AddRecipe(53842,365,40070,1,2)
	self:addTradeFlags(RecipeDB,53842, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,53,54)
	self:addTradeAcquire(RecipeDB,53842,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Elixir of Spirit -- 53847
	AddRecipe(53847,385,40072,1,2)
	self:addTradeFlags(RecipeDB,53847, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,53,54)
	self:addTradeAcquire(RecipeDB,53847,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Guru's Elixir -- 53848
	AddRecipe(53848,375,40076,1,2)
	self:addTradeFlags(RecipeDB,53848, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53848,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Crazy Alchemist's Potion -- 53895
	AddRecipe(53895,400,40077,1,2)
	self:addTradeFlags(RecipeDB,53895, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53895,8,18)

	-- Elixir of Mighty Fortitude -- 53898
	AddRecipe(53898,390,40078,1,2)
	self:addTradeFlags(RecipeDB,53898, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53898,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Lesser Flask of Toughness -- 53899
	AddRecipe(53899,375,40079,1,2)
	self:addTradeFlags(RecipeDB,53899, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53899,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Potion of Nightmares -- 53900
	AddRecipe(53900,380,40081,1,2)
	self:addTradeFlags(RecipeDB,53900, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53900,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Flask of the Frost Wyrm -- 53901
	AddRecipe(53901,435,40082,1,2)
	self:addTradeFlags(RecipeDB,53901, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,53,54)
	self:addTradeAcquire(RecipeDB,53901,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Flask of Stoneblood -- 53902
	AddRecipe(53902,435,40083,1,2)
	self:addTradeFlags(RecipeDB,53902, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53902,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Flask of Endless Rage -- 53903
	AddRecipe(53903,435,40084,1,2)
	self:addTradeFlags(RecipeDB,53903, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,51)
	self:addTradeAcquire(RecipeDB,53903,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Powerful Rejuvenation Potion -- 53904
	AddRecipe(53904,400,40087,1,2)
	self:addTradeFlags(RecipeDB,53904, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53904,8,18)

	-- Indestructible Potion -- 53905
	AddRecipe(53905,395,40093,1,2)
	self:addTradeFlags(RecipeDB,53905, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53905,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Mighty Arcane Protection Potion -- 53936
	AddRecipe(53936,400,40213,2,2)
	self:addTradeFlags(RecipeDB,53936, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53936,3,32297,3,31702)

	-- Mighty Frost Protection Potion -- 53937
	AddRecipe(53937,400,40215,2,2)
	self:addTradeFlags(RecipeDB,53937, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53937,3,32289)

	-- Mighty Shadow Protection Potion -- 53938
	AddRecipe(53938,400,40217,2,2)
	self:addTradeFlags(RecipeDB,53938, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53938,3,32349)

	-- Mighty Fire Protection Potion -- 53939
	AddRecipe(53939,400,40214,2,2)
	self:addTradeFlags(RecipeDB,53939, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53939,3,30921)

	-- Mighty Nature Protection Potion -- 53942
	AddRecipe(53942,400,40216,2,2)
	self:addTradeFlags(RecipeDB,53942, F_ALLIANCE, F_HORDE, F_MOB_DROP, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,53942,3,32290)

	-- Flask of Pure Mojo -- 54213
	AddRecipe(54213,435,40404,1,2)
	self:addTradeFlags(RecipeDB,54213, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,54213,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Elixir of Mighty Strength -- 54218
	AddRecipe(54218,385,40073,1,2)
	self:addTradeFlags(RecipeDB,54218, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, 41,51)
	self:addTradeAcquire(RecipeDB,54218,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Elixir of Protection -- 54220
	AddRecipe(54220,400,40097,1,2)
	self:addTradeFlags(RecipeDB,54220, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,54220,8,18)

	-- Potion of Speed -- 54221
	AddRecipe(54221,400,40211,1,2)
	self:addTradeFlags(RecipeDB,54221, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,54221,8,18)

	-- Potion of Wild Magic -- 54222
	AddRecipe(54222,400,40212,1,2)
	self:addTradeFlags(RecipeDB,54222, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, 41,53,54)
	self:addTradeAcquire(RecipeDB,54222,8,18)

	-- Elixir of Mighty Mageblood -- 56519
	AddRecipe(56519,400,40109,1,2)
	self:addTradeFlags(RecipeDB,56519, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,56519,8,18)

	-- Transmute: Skyflare Diamond -- 57425
	AddRecipe(57425,430,41266,3,2)
	self:addTradeFlags(RecipeDB,57425, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,57425,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Transmute: Earthsiege Diamond -- 57427
	AddRecipe(57427,425,41334,3,2)
	self:addTradeFlags(RecipeDB,57427, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,57427,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Endless Mana Potion -- 58868
	AddRecipe(58868,410,43570,1,2)
	self:addTradeFlags(RecipeDB,58868, F_ALLIANCE, F_HORDE, F_TRAINER, 37,41)
	self:addTradeAcquire(RecipeDB,58868,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Endless Healing Potion -- 58871
	AddRecipe(58871,410,43569,1,2)
	self:addTradeFlags(RecipeDB,58871, F_ALLIANCE, F_HORDE, F_TRAINER, 37,41)
	self:addTradeAcquire(RecipeDB,58871,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Transmute: Titanium -- 60350
	AddRecipe(60350,395,41163,2,2)
	self:addTradeFlags(RecipeDB,60350, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,60350,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Elixir of Accuracy -- 60354
	AddRecipe(60354,400,44325,1,2,400,415,422,430)
	self:addTradeFlags(RecipeDB,60354, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,60354,8,18)

	-- Elixir of Deadly Strikes -- 60355
	AddRecipe(60355,400,44327,1,2)
	self:addTradeFlags(RecipeDB,60355, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,60355,8,18)

	-- Elixir of Mighty Defense -- 60356
	AddRecipe(60356,400,44328,1,2)
	self:addTradeFlags(RecipeDB,60356, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, 41,52)
	self:addTradeAcquire(RecipeDB,60356,8,18)

	-- Elixir of Expertise -- 60357
	AddRecipe(60357,400,44329,1,2)
	self:addTradeFlags(RecipeDB,60357, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, 41,51)
	self:addTradeAcquire(RecipeDB,60357,8,18)

	-- Elixir of Armor Piercing -- 60365
	AddRecipe(60365,400,44330,1,2)
	self:addTradeFlags(RecipeDB,60365, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, 41,51)
	self:addTradeAcquire(RecipeDB,60365,8,18)

	-- Elixir of Lightning Speed -- 60366
	AddRecipe(60366,400,44331,1,2)
	self:addTradeFlags(RecipeDB,60366, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,60366,8,18)

	-- Elixir of Mighty Thoughts -- 60367
	AddRecipe(60367,395,44332,1,2)
	self:addTradeFlags(RecipeDB,60367, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,60367,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Mercurial Alchemist Stone -- 60396
	AddRecipe(60396,400,44322,3,2)
	self:addTradeFlags(RecipeDB,60396, F_ALLIANCE, F_HORDE, F_TRAINER, 37,41,53,54,61)
	self:addTradeAcquire(RecipeDB,60396,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Indestructible Alchemist Stone -- 60403
	AddRecipe(60403,400,44323,3,2)
	self:addTradeFlags(RecipeDB,60403, F_ALLIANCE, F_HORDE, F_TRAINER, 37,41,52,61)
	self:addTradeAcquire(RecipeDB,60403,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Mighty Alchemist Stone -- 60405
	AddRecipe(60405,400,44324,3,2)
	self:addTradeFlags(RecipeDB,60405, F_ALLIANCE, F_HORDE, F_TRAINER, 37,41,51,61)
	self:addTradeAcquire(RecipeDB,60405,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Northrend Alchemy Research -- 60893
	AddRecipe(60893,400,nil,1,2)
	self:addTradeFlags(RecipeDB,60893, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,60893,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Shadow Oil -- 3449
	AddRecipe(3449,165,3824,1,2,165,190,210,230)
	self:addTradeFlags(RecipeDB,3449, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,3449,2,2481,2,4878)

	-- Free Action Potion -- 6624
	AddRecipe(6624,150,5634,1,2,150,175,195,215)
	self:addTradeFlags(RecipeDB,6624, F_ALLIANCE, F_HORDE, F_QUEST, F_IBOE, F_RBOE)
	self:addTradeAcquire(RecipeDB,6624,2,3348,2,5178,2,4226)

	-- Elixir of Water Walking -- 62410
	AddRecipe(62410,400,8827,1,2)
	self:addTradeFlags(RecipeDB,62410, F_ALLIANCE, F_HORDE, F_DISC, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,62410,8,18)

	-- Ethereal Oil -- 62409
	AddRecipe(62409,375,44958,1,2)
	self:addTradeFlags(RecipeDB,62409, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,62409,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Lesser Flask of Resistance -- 62213
	AddRecipe(62213,385,44939,1,2)
	self:addTradeFlags(RecipeDB,62213, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,62213,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Elixir of Minor Accuracy -- 63732
	AddRecipe(63732,135,45621,1,2,135,160,180,200)
	self:addTradeFlags(RecipeDB,63732, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,63732,1,1386,1,2391,1,2837,1,3009,1,3347,1,4160,
	1,4611,1,5177,1,5499,1,7948,1,16588,1,16642,1,16723,1,18802,1,19052,
	1,27029,1,3603,1,1470,1,3964,1,2132,1,3184,1,33608,1,33674,1,27023,1,4900,1,1215,
	1,16161)

	-- Transmute: Ametrine -- 66658
	AddRecipe(66658,450,36931,1,2,450,450,452,465)
	self:addTradeFlags(RecipeDB,66658, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,66658,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Transmute: Cardinal Ruby -- 66659
	AddRecipe(66659,450,36919,1,2,450,450,452,465)
	self:addTradeFlags(RecipeDB,66659,1,2,8,F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,66659,4,14151)

	-- Transmute: King's Amber -- 66660
	AddRecipe(66660,450,36922,1,2,450,450,452,465)
	self:addTradeFlags(RecipeDB,66660, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,66660,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Transmute: Dreadstone -- 66662
	AddRecipe(66662,450,36928,1,2,450,450,452,465)
	self:addTradeFlags(RecipeDB,66662, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,66662,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Transmute: Majestic Zircon -- 66663
	AddRecipe(66663,450,36925,1,2,450,450,452,465)
	self:addTradeFlags(RecipeDB,66663, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,66663,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Transmute: Eye of Zul -- 66664
	AddRecipe(66664,450,36934,1,2,450,450,452,465)
	self:addTradeFlags(RecipeDB,66664, F_ALLIANCE, F_HORDE, F_TRAINER, F_IBOE, F_RBOP)
	self:addTradeAcquire(RecipeDB,66664,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	-- Flask of the North -- 67025
	AddRecipe(67025,425,47499,1,2,425,440,445,450)
	self:addTradeFlags(RecipeDB,67025, F_ALLIANCE, F_HORDE, F_TRAINER, 37,41,51)
	self:addTradeAcquire(RecipeDB,67025,1,26903,1,26951,1,26975,1,26987,1,28703,1,
	33588)

	return num_recipes

end
