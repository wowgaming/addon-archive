--[[
************************************************************************
Smelting.lua
Smelting data for all of Ackis Recipe List
************************************************************************
File date: 2010-01-24T16:17:55Z 
File revision: 2806 
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

function addon:InitSmelting(RecipeDB)

	if initialized then
		return num_recipes
	end

	initialized = true

	--------------------------------------------------------------------------------------------------------------------
	-- Counter and wrapper function
	--------------------------------------------------------------------------------------------------------------------
	local function AddRecipe(SpellID, Skill, ItemID, Rarity, Game, Orange, Yellow, Green, Gray)
		num_recipes = num_recipes + 1
		self:addTradeSkill(RecipeDB, SpellID, Skill, ItemID, Rarity, 32606, nil, Game, Orange, Yellow, Green, Gray)
	end

	-- Smelt Copper -- 2657
	AddRecipe(2657,1,2840,1,0,1,25,47,70)
	self:addTradeFlags(RecipeDB,2657,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,2657,8,8)

	-- Smelt Silver -- 2658
	AddRecipe(2658,75,2842,1,0,75,115,122,130)
	self:addTradeFlags(RecipeDB,2658,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,2658,1,1681,1,1701,1,3001,1,3137,1,3175,1,3357,1,3555,1,4254,1,4598,1,5392,
	1,5513,1,6297,1,8128,1,16663,1,16752,1,17488,1,18747,1,18779,1,18804,1,26999,1,33617,1,28698,1,26962,1,26976,
	1,33682,1,26912)

	-- Smelt Bronze -- 2659
	AddRecipe(2659,65,2841,1,0,0,65,90,115)
	self:addTradeFlags(RecipeDB,2659,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,2659,1,1681,1,1701,1,3001,1,3137,1,3175,1,3357,1,3555,1,4254,1,4598,1,5392,
	1,5513,1,6297,1,8128,1,16663,1,16752,1,17488,1,18747,1,18779,1,18804,1,26999,1,33617,1,28698,1,26962,1,26976,
	1,33682,1,26912)

	-- Smelt Tin -- 3304
	AddRecipe(3304,65,3576,1,0,0,65,70,75)
	self:addTradeFlags(RecipeDB,3304,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3304,1,1681,1,1701,1,3001,1,3137,1,3175,1,3357,1,3555,1,4254,1,4598,1,5392,
	1,5513,1,6297,1,8128,1,16663,1,16752,1,17488,1,18747,1,18779,1,18804,1,26999,1,33617,1,28698,1,26962,1,26976,
	1,33682,1,26912)

	-- Smelt Iron -- 3307
	AddRecipe(3307,125,3575,1,0,125,130,145,160)
	self:addTradeFlags(RecipeDB,3307,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3307,1,1681,1,1701,1,3001,1,3137,1,3175,1,3357,1,3555,1,4254,1,4598,1,5392,
	1,5513,1,6297,1,8128,1,16663,1,16752,1,17488,1,18747,1,18779,1,18804,1,26999,1,33617,1,28698,1,26962,1,26976,
	1,33682,1,26912)

	-- Smelt Gold -- 3308
	AddRecipe(3308,155,3577,1,0,155,170,177,185)
	self:addTradeFlags(RecipeDB,3308,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3308,1,1681,1,1701,1,3001,1,3137,1,3175,1,3357,1,3555,1,4254,1,4598,1,5392,
	1,5513,1,6297,1,8128,1,16663,1,16752,1,17488,1,18747,1,18779,1,18804,1,26999,1,33617,1,28698,1,26962,1,26976,
	1,33682,1,26912)

	-- Smelt Steel -- 3569
	AddRecipe(3569,165,3859,1,0,0,0,0,165)
	self:addTradeFlags(RecipeDB,3569,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3569,1,1681,1,1701,1,3001,1,3137,1,3175,1,3357,1,3555,1,4254,1,4598,1,5392,
	1,5513,1,6297,1,8128,1,16663,1,16752,1,17488,1,18747,1,18779,1,18804,1,26999,1,33617,1,28698,1,26962,1,26976,
	1,33682,1,26912)

	-- Smelt Mithril -- 10097
	AddRecipe(10097,175,3860,1,0,0,175,202,230)
	self:addTradeFlags(RecipeDB,10097,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,10097,1,1681,1,1701,1,3001,1,3137,1,3175,1,3357,1,3555,1,4254,1,4598,1,5392,
	1,5513,1,6297,1,8128,1,16663,1,16752,1,17488,1,18747,1,18779,1,18804,1,26999,1,33617,1,28698,1,26962,1,26976,
	1,33682,1,26912)

	-- Smelt Truesilver -- 10098
	AddRecipe(10098,230,6037,1,0,230,235,242,250)
	self:addTradeFlags(RecipeDB,10098,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,10098,1,1681,1,1701,1,3001,1,3137,1,3175,1,3357,1,3555,1,4254,1,4598,1,5392,
	1,5513,1,6297,1,8128,1,16663,1,16752,1,17488,1,18747,1,18779,1,18804,1,26999,1,33617,1,28698,1,26962,1,26976,
	1,33682,1,26912)

	-- Smelt Dark Iron -- 14891
	AddRecipe(14891,230,11371,1,0,230,300,305,310)
	self:addTradeFlags(RecipeDB,14891,1,2,8,36,41)
	self:addTradeAcquire(RecipeDB,14891,4,4083)

	-- Smelt Thorium -- 16153
	AddRecipe(16153,230,12359,1,0,230,250,270,290)
	self:addTradeFlags(RecipeDB,16153,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,16153,1,1681,1,1701,1,3001,1,3137,1,3175,1,3357,1,3555,1,4254,1,4598,1,5392,
	1,5513,1,6297,1,8128,1,16663,1,16752,1,17488,1,18747,1,18779,1,18804,1,26999,1,33617,1,28698,1,26962,1,26976,
	1,33682,1,26912)

	-- Smelt Elementium -- 22967
	AddRecipe(22967,300,17771,5,0,300,350,362,375)
	self:addTradeFlags(RecipeDB,22967,1,2,6,11,36,41)
	self:addTradeAcquire(RecipeDB,22967,3,14401)

	-- Smelt Fel Iron -- 29356
	AddRecipe(29356,300,23445,1,1,0,300,307,315)
	self:addTradeFlags(RecipeDB,29356,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,29356,1,18747,1,18779,1,26999,1,33617,1,28698,1,26962,1,26976,1,33682,1,26912)

	-- Smelt Adamantite -- 29358
	AddRecipe(29358,325,23446,1,1,0,325,332,340)
	self:addTradeFlags(RecipeDB,29358,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,29358,1,18747,1,18779,1,26999,1,33617,1,28698,1,26962,1,26976,1,33682,1,26912)

	-- Smelt Eternium -- 29359
	AddRecipe(29359,350,23447,1,1,0,350,357,365)
	self:addTradeFlags(RecipeDB,29359,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,29359,1,18747,1,18779,1,26999,1,33617,1,28698,1,26962,1,26976,1,33682,1,26912)

	-- Smelt Felsteel -- 29360
	AddRecipe(29360,350,23448,1,1,0,350,357,375)
	self:addTradeFlags(RecipeDB,29360,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,29360,1,18747,1,18779,1,26999,1,33617,1,28698,1,26962,1,26976,1,33682,1,26912)

	-- Smelt Khorium -- 29361
	AddRecipe(29361,375,23449,1,1,0,0,0,375)
	self:addTradeFlags(RecipeDB,29361,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,29361,1,18747,1,18779,1,26999,1,33617,1,28698,1,26962,1,26976,1,33682,1,26912)

	-- Smelt Hardened Adamantite -- 29686
	AddRecipe(29686,375,23573,1,1,0,0,0,375)
	self:addTradeFlags(RecipeDB,29686,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,29686,1,18747,1,18779,1,26999,1,33617,1,28698,1,26962,1,26976,1,33682,1,26912)

	-- Earth Shatter -- 35750
	AddRecipe(35750,300,22573,1,1,0,0,0,300)
	self:addTradeFlags(RecipeDB,35750,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,35750,1,18747,1,18779,1,26999,1,33617,1,28698,1,26962,1,26976,1,33682,1,26912)

	-- Fire Sunder -- 35751
	AddRecipe(35751,300,22574,1,1,0,0,0,300)
	self:addTradeFlags(RecipeDB,35751,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,35751,1,18747,1,18779,1,26999,1,33617,1,28698,1,26962,1,26976,1,33682,1,26912)

	-- Smelt Cobalt -- 49252
	AddRecipe(49252,350,36916,1,2,0,350,362,375)
	self:addTradeFlags(RecipeDB,49252,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,49252,1,26912,1,26962,1,26976,1,26999,1,28698)

	-- Smelt Saronite -- 49258
	AddRecipe(49258,400,36913,1,2,0,0,0,400)
	self:addTradeFlags(RecipeDB,49258,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,49258,1,26912,1,26962,1,26976,1,26999,1,28698)

	-- Smelt Titansteel -- 55208
	AddRecipe(55208,450,37663,2,2,0,0,0,450)
	self:addTradeFlags(RecipeDB,55208,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,55208,1,26912,1,26962,1,26976,1,26999,1,28698)

	-- Smelt Titanium -- 55211
	AddRecipe(55211,450,41163,2,2,0,0,0,450)
	self:addTradeFlags(RecipeDB,55211,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,55211,1,26912,1,26962,1,26976,1,26999,1,28698)

	-- Smelt Hardened Khorium -- 46353
	AddRecipe(46353,375,35128,3,1,0,0,0,375)
	self:addTradeFlags(RecipeDB,46353,1,2,6,36,41)
	self:addTradeAcquire(RecipeDB,46353,8,24)
	
	-- Smelt Enchanted Thorium -- 70524
	AddRecipe(70524,250,12655,1,2,250,250,255,260)
	self:addTradeFlags(RecipeDB,70524,1,2,F_TRAINER,36,41)
	self:addTradeAcquire(RecipeDB,70524,A_TRAINER,28698)

	return num_recipes

end
