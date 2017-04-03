--[[
************************************************************************
Engineering.lua
Engineering data for all of Ackis Recipe List
************************************************************************
File date: 2010-01-20T06:00:10Z 
File revision: 2803 
Project revision: 2817
Project version: v1.0-r2818
************************************************************************
Please see http://www.wowace.com/addons/arl/ for more information.
************************************************************************
This source code is released under All Rights Reserved.
************************************************************************
]]--

local MODNAME = "Ackis Recipe List"
local addon = LibStub("AceAddon-3.0"):GetAddon(MODNAME)
local L = LibStub("AceLocale-3.0"):GetLocale(MODNAME)

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

-------------------------------------------------------------------------------
-- Reputation Filter flags
-------------------------------------------------------------------------------
local F_ARGENTDAWN, F_CENARION_CIRCLE, F_THORIUM_BROTHERHOOD, F_TIMBERMAW_HOLD, F_ZANDALAR = 96, 97, 98, 99, 100
local F_ALDOR, F_ASHTONGUE, F_CENARION_EXPEDITION, F_HELLFIRE, F_CONSORTIUM = 101, 102, 103, 104, 105
local F_KOT, F_LOWERCITY, F_NAGRAND, F_SCALE_SANDS, F_SCRYER, F_SHATAR = 106, 107, 108, 109, 110
local F_SHATTEREDSUN, F_SPOREGGAR, F_VIOLETEYE = 111, 112, 113, 114
local F_ARGENTCRUSADE, F_FRENZYHEART, F_EBONBLADE, F_KIRINTOR, F_HODIR = 115, 116, 117, 118, 119
local F_KALUAK, F_ORACLES, F_WYRMREST, F_WRATHCOMMON1, F_WRATHCOMMON2 = 120, 121, 122, 123, 124
local F_WRATHCOMMON3, F_WRATHCOMMON4, F_WRATHCOMMON5, F_ASHEN_VERDICT = 125, 126, 127, 128

--------------------------------------------------------------------------------------------------------------------
-- Acquire types
--------------------------------------------------------------------------------------------------------------------
local A_TRAINER, A_VENDOR, A_MOB, A_QUEST, A_SEASONAL, A_REPUTATION, A_WORLD_DROP, A_CUSTOM = 1, 2, 3, 4, 5, 6, 7, 8

--------------------------------------------------------------------------------------------------------------------
-- Reputation Acquire Flags
--------------------------------------------------------------------------------------------------------------------
local R_WINTERSPRING = 589

--------------------------------------------------------------------------------------------------------------------
-- Reputation Levels
--------------------------------------------------------------------------------------------------------------------
local FRIENDLY = 1
local HONORED = 2
local REVERED = 3
local EXALTED = 4

local initialized = false
local num_recipes = 0

function addon:InitEngineering(RecipeDB)

	if (initialized) then
		return num_recipes
	end

	initialized = true

	--------------------------------------------------------------------------------------------------------------------
	-- Counter and wrapper function
	--------------------------------------------------------------------------------------------------------------------
	local function AddRecipe(SpellID, Skill, ItemID, Rarity, Game, Orange, Yellow, Green, Gray, Specialty)
		num_recipes = num_recipes + 1
		self:addTradeSkill(RecipeDB, SpellID, Skill, ItemID, Rarity, 4036, Specialty, Game, Orange, Yellow, Green, Gray)
	end

	-- Rough Blasting Powder -- 3918
	AddRecipe(3918,1,4357,1,GAME_ORIG,1,20,30,40)
	self:addTradeFlags(RecipeDB,3918,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3918,8,8)

	-- Rough Dynamite -- 3919
	AddRecipe(3919,1,4358,1,GAME_ORIG,1,30,45,60)
	self:addTradeFlags(RecipeDB,3919,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3919,8,8)

	-- Crafted Light Shot -- 3920
	AddRecipe(3920,1,8067,1,GAME_ORIG,1,30,45,60)
	self:addTradeFlags(RecipeDB,3920,1,2,3,36,41,78)
	self:addTradeAcquire(RecipeDB,3920,8,8)

	-- Handful of Copper Bolts -- 3922
	AddRecipe(3922,30,4359,1,GAME_ORIG,30,45,52,60)
	self:addTradeFlags(RecipeDB,3922,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3922,1,1702,1,3290,1,3494,1,5174,1,5518,1,8736,1,11017,1,11025,
	1,11037,1,16726,1,17222,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,33586,
	1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,26955)

	-- Rough Copper Bomb -- 3923
	AddRecipe(3923,30,4360,1,GAME_ORIG,30,60,75,90)
	self:addTradeFlags(RecipeDB,3923,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3923,1,1702,1,3290,1,3494,1,5174,1,5518,1,8736,1,11017,1,11025,
	1,11031,1,11037,1,16726,1,17222,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,
	1,33586,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,26955)

	-- Copper Tube -- 3924
	AddRecipe(3924,50,4361,1,GAME_ORIG,50,80,95,110)
	self:addTradeFlags(RecipeDB,3924,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3924,1,1702,1,3290,1,3494,1,5174,1,5518,1,8736,1,11017,1,11025,
	1,11031,1,11037,1,16726,1,17222,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,
	1,33586,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,26955)

	-- Rough Boomstick -- 3925
	AddRecipe(3925,50,4362,1,GAME_ORIG,50,80,95,110)
	self:addTradeFlags(RecipeDB,3925,1,2,3,36,41,80)
	self:addTradeAcquire(RecipeDB,3925,1,1702,1,3290,1,3494,1,5174,1,5518,1,8736,1,11017,1,11025,
	1,11031,1,11037,1,16726,1,17222,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,
	1,33586,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,26955)

	-- Copper Modulator -- 3926
	AddRecipe(3926,65,4363,1,GAME_ORIG,65,95,110,125)
	self:addTradeFlags(RecipeDB,3926,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3926,1,1702,1,3290,1,3494,1,5174,1,5518,1,8736,1,11017,1,11025,
	1,11031,1,11037,1,16726,1,17222,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,
	1,33586,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,26955)

	-- Mechanical Squirrel -- 3928
	AddRecipe(3928,75,4401,2,GAME_ORIG,75,105,120,135)
	self:addTradeFlags(RecipeDB,3928,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,3928,7,2)

	-- Coarse Blasting Powder -- 3929
	AddRecipe(3929,75,4364,1,GAME_ORIG,75,85,90,95)
	self:addTradeFlags(RecipeDB,3929,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3929,1,1702,1,3290,1,3494,1,5174,1,5518,1,8736,1,11017,1,11025,
	1,11031,1,11037,1,16726,1,17222,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,
	1,33586,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,26955)

	-- Crafted Heavy Shot -- 3930
	AddRecipe(3930,75,8068,1,GAME_ORIG,75,85,90,95)
	self:addTradeFlags(RecipeDB,3930,1,2,3,36,41,78)
	self:addTradeAcquire(RecipeDB,3930,1,1702,1,3290,1,3494,1,5174,1,5518,1,8736,1,11017,1,11025,
	1,11031,1,11037,1,16726,1,17222,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,
	1,33586,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,26955)

	-- Coarse Dynamite -- 3931
	AddRecipe(3931,75,4365,1,GAME_ORIG,75,90,97,105)
	self:addTradeFlags(RecipeDB,3931,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3931,1,1702,1,3290,1,3494,1,5174,1,5518,1,8736,1,11017,1,11025,
	1,11031,1,11037,1,16726,1,17222,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,
	1,33586,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,26955)

	-- Target Dummy -- 3932
	AddRecipe(3932,85,4366,1,GAME_ORIG,85,115,130,145)
	self:addTradeFlags(RecipeDB,3932,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3932,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,
	1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Small Seaforium Charge -- 3933
	AddRecipe(3933,100,4367,2,GAME_ORIG,100,130,145,160)
	self:addTradeFlags(RecipeDB,3933,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,3933,7,2)

	-- Flying Tiger Goggles -- 3934
	AddRecipe(3934,100,4368,1,GAME_ORIG,100,130,145,160)
	self:addTradeFlags(RecipeDB,3934,1,2,3,36,41,53,54,56)
	self:addTradeAcquire(RecipeDB,3934,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,
	1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Deadly Blunderbuss -- 3936
	AddRecipe(3936,105,4369,1,GAME_ORIG,105,130,142,155)
	self:addTradeFlags(RecipeDB,3936,1,2,3,36,41,80)
	self:addTradeAcquire(RecipeDB,3936,1,1676,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,1,19576,
	1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Large Copper Bomb -- 3937
	AddRecipe(3937,105,4370,1,GAME_ORIG,105,105,130,155)
	self:addTradeFlags(RecipeDB,3937,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3937,1,1676,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,1,19576,
	1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Bronze Tube -- 3938
	AddRecipe(3938,105,4371,1,GAME_ORIG,105,105,130,155)
	self:addTradeFlags(RecipeDB,3938,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3938,1,1676,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,1,19576,
	1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Lovingly Crafted Boomstick -- 3939
	AddRecipe(3939,120,4372,1,GAME_ORIG,120,145,157,170)
	self:addTradeFlags(RecipeDB,3939,1,2,4,36,41,80)
	self:addTradeAcquire(RecipeDB,3939,2,2682,2,6730)

	-- Shadow Goggles -- 3940
	AddRecipe(3940,120,4373,2,GAME_ORIG,120,145,157,170)
	self:addTradeFlags(RecipeDB,3940,1,2,10,36,40,53,54,56)
	self:addTradeAcquire(RecipeDB,3940,7,2)

	-- Small Bronze Bomb -- 3941
	AddRecipe(3941,120,4374,1,GAME_ORIG,120,120,145,170)
	self:addTradeFlags(RecipeDB,3941,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3941,1,1676,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,1,19576,
	1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Whirring Bronze Gizmo -- 3942
	AddRecipe(3942,125,4375,1,GAME_ORIG,125,125,150,175)
	self:addTradeFlags(RecipeDB,3942,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3942,1,1676,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,1,19576,
	1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Flame Deflector -- 3944
	AddRecipe(3944,125,4376,2,GAME_ORIG,125,125,150,175)
	self:addTradeFlags(RecipeDB,3944,1,2,5,36,40)
	self:addTradeAcquire(RecipeDB,3944,3,7800)

	-- Heavy Blasting Powder -- 3945
	AddRecipe(3945,125,4377,1,GAME_ORIG,125,125,135,145)
	self:addTradeFlags(RecipeDB,3945,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3945,1,1676,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,1,19576,
	1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Heavy Dynamite -- 3946
	AddRecipe(3946,125,4378,1,GAME_ORIG,125,125,135,145)
	self:addTradeFlags(RecipeDB,3946,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3946,1,1676,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,1,19576,
	1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Crafted Solid Shot -- 3947
	AddRecipe(3947,125,8069,1,GAME_ORIG,125,125,135,145)
	self:addTradeFlags(RecipeDB,3947,1,2,3,36,41,78)
	self:addTradeAcquire(RecipeDB,3947,1,1676,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,1,19576,
	1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Silver-plated Shotgun -- 3949
	AddRecipe(3949,130,4379,1,GAME_ORIG,130,155,167,180)
	self:addTradeFlags(RecipeDB,3949,1,2,3,36,41,80)
	self:addTradeAcquire(RecipeDB,3949,1,1676,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,1,19576,
	1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Big Bronze Bomb -- 3950
	AddRecipe(3950,140,4380,1,GAME_ORIG,140,140,165,190)
	self:addTradeFlags(RecipeDB,3950,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3950,1,1676,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,1,19576,
	1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Minor Recombobulator -- 3952
	AddRecipe(3952,140,4381,1,GAME_ORIG,140,165,177,190)
	self:addTradeFlags(RecipeDB,3952,1,2,4,36,40,61)
	self:addTradeAcquire(RecipeDB,3952,2,2682,2,3495,2,2683)

	-- Bronze Framework -- 3953
	AddRecipe(3953,145,4382,1,GAME_ORIG,145,145,170,195)
	self:addTradeFlags(RecipeDB,3953,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3953,1,1676,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,1,19576,
	1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Moonsight Rifle -- 3954
	AddRecipe(3954,145,4383,2,GAME_ORIG,145,170,182,195)
	self:addTradeFlags(RecipeDB,3954,1,2,10,36,40,80)
	self:addTradeAcquire(RecipeDB,3954,7,2)

	-- Explosive Sheep -- 3955
	AddRecipe(3955,150,4384,1,GAME_ORIG,150,175,187,200)
	self:addTradeFlags(RecipeDB,3955,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3955,1,1676,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,1,19576,
	1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Green Tinted Goggles -- 3956
	AddRecipe(3956,150,4385,1,GAME_ORIG,150,175,187,200)
	self:addTradeFlags(RecipeDB,3956,1,2,3,36,41,53,54,56)
	self:addTradeAcquire(RecipeDB,3956,1,1676,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,1,19576,
	1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Ice Deflector -- 3957
	AddRecipe(3957,155,4386,1,GAME_ORIG,155,175,185,195)
	self:addTradeFlags(RecipeDB,3957,1,2,4,36,41)
	self:addTradeAcquire(RecipeDB,3957,2,2684)

	-- Iron Strut -- 3958
	AddRecipe(3958,160,4387,1,GAME_ORIG,160,160,170,180)
	self:addTradeFlags(RecipeDB,3958,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3958,1,5174,1,8736,1,11017,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,33586,
	1,3494,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Discombobulator Ray -- 3959
	AddRecipe(3959,160,4388,2,GAME_ORIG,160,180,190,200)
	self:addTradeFlags(RecipeDB,3959,1,2,5,36,40)
	self:addTradeAcquire(RecipeDB,3959,3,7800)

	-- Portable Bronze Mortar -- 3960
	AddRecipe(3960,165,4403,2,GAME_ORIG,165,185,195,210)
	self:addTradeFlags(RecipeDB,3960,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,3960,7,2)

	-- Gyrochronatom -- 3961
	AddRecipe(3961,170,4389,1,GAME_ORIG,170,170,190,210)
	self:addTradeFlags(RecipeDB,3961,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3961,1,5174,1,8736,1,11017,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,
	1,33586,1,3494,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Iron Grenade -- 3962
	AddRecipe(3962,175,4390,1,GAME_ORIG,175,175,195,215)
	self:addTradeFlags(RecipeDB,3962,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3962,1,5174,1,8736,1,11017,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,
	1,33586,1,3494,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Compact Harvest Reaper Kit -- 3963
	AddRecipe(3963,175,4391,1,GAME_ORIG,175,175,195,215)
	self:addTradeFlags(RecipeDB,3963,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3963,1,5174,1,8736,1,11017,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,
	1,33586,1,3494,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Advanced Target Dummy -- 3965
	AddRecipe(3965,185,4392,1,GAME_ORIG,185,185,205,225)
	self:addTradeFlags(RecipeDB,3965,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3965,1,5174,1,8736,1,11017,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,
	1,33586,1,3494,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Craftsman's Monocle -- 3966
	AddRecipe(3966,185,4393,3,GAME_ORIG,185,205,215,225)
	self:addTradeFlags(RecipeDB,3966,1,2,10,36,40,56)
	self:addTradeAcquire(RecipeDB,3966,7,3)

	-- Big Iron Bomb -- 3967
	AddRecipe(3967,190,4394,1,GAME_ORIG,190,190,210,230)
	self:addTradeFlags(RecipeDB,3967,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3967,1,5174,1,8736,1,11017,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,33586,1,3494,
	1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Goblin Land Mine -- 3968
	AddRecipe(3968,195,4395,2,GAME_ORIG,195,215,225,235)
	self:addTradeFlags(RecipeDB,3968,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,3968,7,2)

	-- Mechanical Dragonling -- 3969
	AddRecipe(3969,200,4396,1,GAME_ORIG,200,220,230,240)
	self:addTradeFlags(RecipeDB,3969,1,2,4,36,40,61)
	self:addTradeAcquire(RecipeDB,3969,2,2687)

	-- Gnomish Cloaking Device -- 3971
	AddRecipe(3971,200,4397,1,GAME_ORIG,20,220,230,240)
	self:addTradeFlags(RecipeDB,3971,1,2,4,5,36,40,61)
	self:addTradeAcquire(RecipeDB,3971,3,7800,2,6777)

	-- Large Seaforium Charge -- 3972
	AddRecipe(3972,200,4398,2,GAME_ORIG,200,200,220,240)
	self:addTradeFlags(RecipeDB,3972,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,3972,7,2)

	-- Silver Contact -- 3973
	AddRecipe(3973,90,4404,1,GAME_ORIG,90,110,125,140)
	self:addTradeFlags(RecipeDB,3973,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3973,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,
	1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Crude Scope -- 3977
	AddRecipe(3977,60,4405,1,GAME_ORIG,60,90,105,120)
	self:addTradeFlags(RecipeDB,3977,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3977,1,1702,1,3290,1,3494,1,5174,1,5518,1,8736,1,11017,1,11025,
	1,11031,1,11037,1,16726,1,17222,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,
	1,33586,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,26955)

	-- Standard Scope -- 3978
	AddRecipe(3978,110,4406,1,GAME_ORIG,110,135,147,160)
	self:addTradeFlags(RecipeDB,3978,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3978,1,1676,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,
	1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Accurate Scope -- 3979
	AddRecipe(3979,180,4407,1,GAME_ORIG,180,200,210,220)
	self:addTradeFlags(RecipeDB,3979,1,2,4,36,40)
	self:addTradeAcquire(RecipeDB,3979,2,2685)

	-- Ornate Spyglass -- 6458
	AddRecipe(6458,135,5507,1,GAME_ORIG,135,160,172,185)
	self:addTradeFlags(RecipeDB,6458,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,6458,1,1676,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,
	1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Arclight Spanner -- 7430
	AddRecipe(7430,50,6219,1,GAME_ORIG,50,70,80,90)
	self:addTradeFlags(RecipeDB,7430,1,2,3,36,41,66)
	self:addTradeAcquire(RecipeDB,7430,1,1702,1,3290,1,3494,1,5174,1,5518,1,8736,1,11017,1,11025,
	1,11031,1,11037,1,16726,1,17222,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,
	1,33586,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,26955)

	-- Flash Bomb -- 8243
	AddRecipe(8243,185,4852,2,GAME_ORIG,185,185,205,225)
	self:addTradeFlags(RecipeDB,8243,1,2,5,8,36,40)
	self:addTradeAcquire(RecipeDB,8243,3,7800,4,1559)

	-- Practice Lock -- 8334
	AddRecipe(8334,100,6712,1,GAME_ORIG,100,115,122,130)
	self:addTradeFlags(RecipeDB,8334,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,8334,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,1,19576,
	1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- EZ-Thro Dynamite -- 8339
	AddRecipe(8339,100,6714,2,GAME_ORIG,100,115,122,130)
	self:addTradeFlags(RecipeDB,8339,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,8339,7,2)

	-- Goblin Rocket Boots -- 8895
	AddRecipe(8895,225,7189,1,GAME_ORIG,225,245,255,265,20222)
	self:addTradeFlags(RecipeDB,8895,1,2,3,36,41,56)
	self:addTradeAcquire(RecipeDB,8895,1,8126,1,29513)

	-- Gnomish Universal Remote -- 9269
	AddRecipe(9269,125,7506,1,GAME_ORIG,125,150,162,175)
	self:addTradeFlags(RecipeDB,9269,1,2,4,5,36,40,61)
	self:addTradeAcquire(RecipeDB,9269,3,7800,2,5175,2,6730)

	-- Aquadynamic Fish Attractor -- 9271
	AddRecipe(9271,150,6533,1,GAME_ORIG,150,150,160,170)
	self:addTradeFlags(RecipeDB,9271,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,9271,1,1676,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,
	1,19576,1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Goblin Jumper Cables -- 9273
	AddRecipe(9273,165,7148,1,GAME_ORIG,165,165,180,200)
	self:addTradeFlags(RecipeDB,9273,1,2,4,5,36,40)
	self:addTradeAcquire(RecipeDB,9273,3,7800,2,3537,2,4086,2,3134)

	-- Gold Power Core -- 12584
	AddRecipe(12584,150,10558,1,GAME_ORIG,150,150,170,190)
	self:addTradeFlags(RecipeDB,12584,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,12584,1,1676,1,5174,1,5518,1,8736,1,11017,1,11031,1,16726,1,17634,1,17637,1,18752,1,18775,
	1,19576,1,16667,1,28697,1,1702,1,33586,1,3494,1,3290,1,26991,1,33611,1,33634,1,25277,1,26907,1,11025,1,26955,1,11037,1,17222)

	-- Solid Blasting Powder -- 12585
	AddRecipe(12585,175,10505,1,GAME_ORIG,175,175,185,195)
	self:addTradeFlags(RecipeDB,12585,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,12585,1,5174,1,8736,1,11017,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,33586,1,3494,1,3290,
	1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Solid Dynamite -- 12586
	AddRecipe(12586,175,10507,1,GAME_ORIG,175,175,185,195)
	self:addTradeFlags(RecipeDB,12586,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,12586,1,5174,1,8736,1,11017,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,33586,
	1,3494,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Bright-Eye Goggles -- 12587
	AddRecipe(12587,175,10499,2,GAME_ORIG,175,195,205,215)
	self:addTradeFlags(RecipeDB,12587,1,2,10,36,40,53,54,56)
	self:addTradeAcquire(RecipeDB,12587,7,2)

	-- Mithril Tube -- 12589
	AddRecipe(12589,195,10559,1,GAME_ORIG,195,195,215,235)
	self:addTradeFlags(RecipeDB,12589,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,12589,1,5174,1,8736,1,11017,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,33586,
	1,3494,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Gyromatic Micro-Adjustor -- 12590
	AddRecipe(12590,175,10498,1,GAME_ORIG,175,175,195,215)
	self:addTradeFlags(RecipeDB,12590,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,12590,1,5174,1,8736,1,11017,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,33586,
	1,3494,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Unstable Trigger -- 12591
	AddRecipe(12591,200,10560,1,GAME_ORIG,200,200,220,240)
	self:addTradeFlags(RecipeDB,12591,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,12591,1,5174,1,8736,1,11017,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,33586,
	1,3494,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Fire Goggles -- 12594
	AddRecipe(12594,205,10500,1,GAME_ORIG,205,225,235,245)
	self:addTradeFlags(RecipeDB,12594,1,2,3,36,41,56)
	self:addTradeAcquire(RecipeDB,12594,1,5174,1,8736,1,11017,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,33586,
	1,3494,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Mithril Blunderbuss -- 12595
	AddRecipe(12595,205,10508,1,GAME_ORIG,205,225,235,245)
	self:addTradeFlags(RecipeDB,12595,1,2,3,36,41,51,80)
	self:addTradeAcquire(RecipeDB,12595,1,5174,1,8736,1,11017,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,33586,
	1,3494,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Hi-Impact Mithril Slugs -- 12596
	AddRecipe(12596,210,10512,1,GAME_ORIG,210,210,230,250)
	self:addTradeFlags(RecipeDB,12596,1,2,3,36,41,78)
	self:addTradeAcquire(RecipeDB,12596,1,5174,1,8736,1,11017,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,33586,
	1,3494,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Deadly Scope -- 12597
	AddRecipe(12597,210,10546,1,GAME_ORIG,210,230,240,250)
	self:addTradeFlags(RecipeDB,12597,1,2,4,36,40)
	self:addTradeAcquire(RecipeDB,12597,2,8679,2,9544)

	-- Mithril Casing -- 12599
	AddRecipe(12599,215,10561,1,GAME_ORIG,215,215,235,255)
	self:addTradeFlags(RecipeDB,12599,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,12599,1,5174,1,8736,1,11017,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,33586,
	1,3494,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Mithril Frag Bomb -- 12603
	AddRecipe(12603,215,10514,1,GAME_ORIG,215,215,235,255)
	self:addTradeFlags(RecipeDB,12603,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,12603,1,5174,1,8736,1,11017,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,33586,
	1,3494,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Catseye Ultra Goggles -- 12607
	AddRecipe(12607,220,10501,2,GAME_ORIG,220,240,250,260)
	self:addTradeFlags(RecipeDB,12607,1,2,10,36,40,56)
	self:addTradeAcquire(RecipeDB,12607,7,2)

	-- Mithril Heavy-bore Rifle -- 12614
	AddRecipe(12614,220,10510,2,GAME_ORIG,220,240,250,260)
	self:addTradeFlags(RecipeDB,12614,1,2,10,36,40,51,80)
	self:addTradeAcquire(RecipeDB,12614,7,2)

	-- Spellpower Goggles Xtreme -- 12615
	AddRecipe(12615,225,10502,3,GAME_ORIG,225,245,255,265)
	self:addTradeFlags(RecipeDB,12615,1,2,3,36,40,53,54,56)
	self:addTradeAcquire(RecipeDB,12615,1,8736,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,11017,1,33586,1,3494,
	1,5174,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Parachute Cloak -- 12616
	AddRecipe(12616,225,10518,2,GAME_ORIG,225,245,255,265)
	self:addTradeFlags(RecipeDB,12616,1,2,10,36,40,51,60)
	self:addTradeAcquire(RecipeDB,12616,7,2)

	-- Deepdive Helmet -- 12617
	AddRecipe(12617,230,10506,1,GAME_ORIG,230,250,260,270)
	self:addTradeFlags(RecipeDB,12617,1,2,4,36,40,56)
	self:addTradeAcquire(RecipeDB,12617,2,8678)

	-- Rose Colored Goggles -- 12618
	AddRecipe(12618,230,10503,1,GAME_ORIG,230,250,260,270)
	self:addTradeFlags(RecipeDB,12618,1,2,3,36,41,53,54,56)
	self:addTradeAcquire(RecipeDB,12618,1,8736,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,11017,1,33586,1,3494,
	1,5174,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Hi-Explosive Bomb -- 12619
	AddRecipe(12619,235,10562,1,GAME_ORIG,235,235,255,275)
	self:addTradeFlags(RecipeDB,12619,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,12619,1,8736,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,11017,1,33586,1,3494,
	1,5174,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Sniper Scope -- 12620
	AddRecipe(12620,240,10548,3,GAME_ORIG,240,260,270,280)
	self:addTradeFlags(RecipeDB,12620,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,12620,7,3)

	-- Mithril Gyro-Shot -- 12621
	AddRecipe(12621,245,10513,1,GAME_ORIG,245,245,265,285)
	self:addTradeFlags(RecipeDB,12621,1,2,3,36,41,78)
	self:addTradeAcquire(RecipeDB,12621,1,8736,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,11017,1,33586,1,3494,
	1,5174,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Green Lens -- 12622
	AddRecipe(12622,245,10504,1,GAME_ORIG,245,265,275,285)
	self:addTradeFlags(RecipeDB,12622,1,2,3,36,41,56)
	self:addTradeAcquire(RecipeDB,12622,1,8736,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,11017,1,33586,1,3494,
	1,5174,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Mithril Mechanical Dragonling -- 12624
	AddRecipe(12624,250,10576,1,GAME_ORIG,250,270,280,290)
	self:addTradeFlags(RecipeDB,12624,1,2,4,36,41,61)
	self:addTradeAcquire(RecipeDB,12624,2,2688)

	-- Goblin Rocket Fuel Recipe -- 12715
	AddRecipe(12715,205,10644,1,GAME_ORIG,205,205,205,205,20222)
	self:addTradeFlags(RecipeDB,12715,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,12715,1,8126,1,29513)

	-- Goblin Mortar -- 12716
	AddRecipe(12716,205,10577,1,GAME_ORIG,205,225,235,245,20222)
	self:addTradeFlags(RecipeDB,12716,1,2,3,36,41,61)
	self:addTradeAcquire(RecipeDB,12716,1,8126,1,8738,1,29513)

	-- Goblin Mining Helmet -- 12717
	AddRecipe(12717,205,10542,1,GAME_ORIG,205,225,235,245,20222)
	self:addTradeFlags(RecipeDB,12717,1,2,3,37,41,58)
	self:addTradeAcquire(RecipeDB,12717,1,8126,1,8738,1,29513)

	-- Goblin Construction Helmet -- 12718
	AddRecipe(12718,205,10543,1,GAME_ORIG,205,225,235,245,20222)
	self:addTradeFlags(RecipeDB,12718,1,2,3,37,41,56)
	self:addTradeAcquire(RecipeDB,12718,1,8126,1,8738,1,29513)

	-- The Big One -- 12754
	AddRecipe(12754,235,10586,1,GAME_ORIG,235,235,255,275,20222)
	self:addTradeFlags(RecipeDB,12754,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,12754,1,8126,1,8738,1,29513)

	-- Goblin Bomb Dispenser -- 12755
	AddRecipe(12755,230,10587,1,GAME_ORIG,230,230,250,270,20222)
	self:addTradeFlags(RecipeDB,12755,1,2,3,37,41,61)
	self:addTradeAcquire(RecipeDB,12755,1,8126,1,8738,1,29513)

	-- Goblin Rocket Helmet -- 12758
	AddRecipe(12758,245,10588,1,GAME_ORIG,245,265,275,285,20222)
	self:addTradeFlags(RecipeDB,12758,1,2,3,36,41,56)
	self:addTradeAcquire(RecipeDB,12758,1,8126,1,8738,1,29513)

	-- Gnomish Death Ray -- 12759
	AddRecipe(12759,240,10645,1,GAME_ORIG,240,260,270,280,20219)
	self:addTradeFlags(RecipeDB,12759,1,2,3,37,41,61)
	self:addTradeAcquire(RecipeDB,12759,1,7406,1,7944,1,29514)

	-- Goblin Sapper Charge -- 12760
	AddRecipe(12760,205,10646,1,GAME_ORIG,205,205,225,245,20222)
	self:addTradeFlags(RecipeDB,12760,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,12760,1,8126,1,29513)

	-- Inlaid Mithril Cylinder Plans -- 12895
	AddRecipe(12895,205,10713,1,GAME_ORIG,205,205,205,205,20219)
	self:addTradeFlags(RecipeDB,12895,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,12895,1,7406,1,7944,1,29514)

	-- Gnomish Goggles -- 12897
	AddRecipe(12897,210,10545,1,GAME_ORIG,210,230,240,250,20219)
	self:addTradeFlags(RecipeDB,12897,1,2,3,37,41,53,54,56)
	self:addTradeAcquire(RecipeDB,12897,1,7406,1,7944,1,29514)

	-- Gnomish Shrink Ray -- 12899
	AddRecipe(12899,205,10716,1,GAME_ORIG,205,225,235,245,20219)
	self:addTradeFlags(RecipeDB,12899,1,2,3,36,41,51,61)
	self:addTradeAcquire(RecipeDB,12899,1,7406,1,7944,1,29514)

	-- Gnomish Net-o-Matic Projector -- 12902
	AddRecipe(12902,210,10720,1,GAME_ORIG,210,230,240,250,20219)
	self:addTradeFlags(RecipeDB,12902,1,2,3,36,41,61)
	self:addTradeAcquire(RecipeDB,12902,1,7406,1,7944,1,29514)

	-- Gnomish Harm Prevention Belt -- 12903
	AddRecipe(12903,215,10721,1,GAME_ORIG,215,235,245,255,20219)
	self:addTradeFlags(RecipeDB,12903,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,12903,1,7406,1,7944,1,29514)

	-- Gnomish Rocket Boots -- 12905
	AddRecipe(12905,225,10724,1,GAME_ORIG,225,245,255,265,20219)
	self:addTradeFlags(RecipeDB,12905,1,2,3,36,41,56)
	self:addTradeAcquire(RecipeDB,12905,1,7406,1,7944,1,29514)

	-- Gnomish Battle Chicken -- 12906
	AddRecipe(12906,230,10725,1,GAME_ORIG,230,250,260,270,20219)
	self:addTradeFlags(RecipeDB,12906,1,2,3,37,41,61)
	self:addTradeAcquire(RecipeDB,12906,1,7406,1,7944,1,29514)

	-- Gnomish Mind Control Cap -- 12907
	AddRecipe(12907,235,10726,1,GAME_ORIG,235,255,265,275,20219)
	self:addTradeFlags(RecipeDB,12907,1,2,3,36,41,53,54,56)
	self:addTradeAcquire(RecipeDB,12907,1,7406,1,7944,1,29514)

	-- Goblin Dragon Gun -- 12908
	AddRecipe(12908,240,10727,1,GAME_ORIG,240,260,270,280,20222)
	self:addTradeFlags(RecipeDB,12908,1,2,3,37,41,61)
	self:addTradeAcquire(RecipeDB,12908,1,8126,1,8738,1,29513)

	-- The Mortar: Reloaded -- 13240
	AddRecipe(13240,205,10577,1,GAME_ORIG,205,205,205,205,20222)
	self:addTradeFlags(RecipeDB,13240,F_ALLIANCE, F_HORDE,3,36,41,61)
	self:addTradeAcquire(RecipeDB,13240,1,8126,1,8738)

	-- Mechanical Repair Kit -- 15255
	AddRecipe(15255,200,11590,1,GAME_ORIG,200,200,220,240)
	self:addTradeFlags(RecipeDB,15255,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,15255,1,5174,1,8736,1,11017,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,33586,
	1,3494,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Pet Bombling -- 15628
	AddRecipe(15628,205,11825,2,GAME_ORIG,205,205,205,205)
	self:addTradeFlags(RecipeDB,15628,1,2,5,37,41)
	self:addTradeAcquire(RecipeDB,15628,8,16)

	-- Lil' Smoky -- 15633
	AddRecipe(15633,205,11826,2,GAME_ORIG,205,205,205,205)
	self:addTradeFlags(RecipeDB,15633,1,2,5,37,41)
	self:addTradeAcquire(RecipeDB,15633,8,16)

	-- Salt Shaker -- 19567
	AddRecipe(19567,250,15846,1,GAME_ORIG,250,270,280,290)
	self:addTradeFlags(RecipeDB,19567,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,19567,1,8736,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,11017,1,33586,1,3494,
	1,5174,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Dense Blasting Powder -- 19788
	AddRecipe(19788,250,15992,1,GAME_ORIG,250,250,255,260)
	self:addTradeFlags(RecipeDB,19788,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,19788,1,8736,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,11017,1,33586,1,3494,
	1,5174,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Thorium Grenade -- 19790
	AddRecipe(19790,260,15993,1,GAME_ORIG,260,280,290,300)
	self:addTradeFlags(RecipeDB,19790,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,19790,1,8736,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,11017,1,33586,1,3494,
	1,5174,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Thorium Widget -- 19791
	AddRecipe(19791,260,15994,1,GAME_ORIG,260,280,290,300)
	self:addTradeFlags(RecipeDB,19791,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,19791,1,8736,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,11017,1,33586,1,3494,
	1,5174,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Thorium Rifle -- 19792
	AddRecipe(19792,260,15995,2,GAME_ORIG,260,280,290,300)
	self:addTradeFlags(RecipeDB,19792,1,2,3,11,36,40,51,80)
	self:addTradeAcquire(RecipeDB,19792,1,8736,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,11017,1,33586,
	1,3494,1,5174,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Lifelike Mechanical Toad -- 19793
	AddRecipe(19793,265,15996,2,GAME_ORIG,265,285,295,305)
	self:addTradeFlags(RecipeDB,19793,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,19793,7,2)

	-- Spellpower Goggles Xtreme Plus -- 19794
	AddRecipe(19794,270,15999,2,GAME_ORIG,270,290,300,310)
	self:addTradeFlags(RecipeDB,19794,1,2,3,36,40,53,54,56)
	self:addTradeAcquire(RecipeDB,19794,1,8736,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,11017,1,33586,1,3494,
	1,5174,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Thorium Tube -- 19795
	AddRecipe(19795,275,16000,1,GAME_ORIG,275,295,305,315)
	self:addTradeFlags(RecipeDB,19795,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,19795,1,8736,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,11017,1,33586,1,3494,
	1,5174,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Dark Iron Rifle -- 19796
	AddRecipe(19796,275,16004,2,GAME_ORIG,275,295,305,315)
	self:addTradeFlags(RecipeDB,19796,1,2,5,36,40,80)
	self:addTradeAcquire(RecipeDB,19796,3,8897)

	-- Dark Iron Bomb -- 19799
	AddRecipe(19799,285,16005,2,GAME_ORIG,285,305,315,325)
	self:addTradeFlags(RecipeDB,19799,1,2,5,11,36,40)
	self:addTradeAcquire(RecipeDB,19799,3,8920)

	-- Thorium Shells -- 19800
	AddRecipe(19800,285,15997,2,GAME_ORIG,285,295,300,305)
	self:addTradeFlags(RecipeDB,19800,1,2,3,36,40,78)
	self:addTradeAcquire(RecipeDB,19800,1,8736,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,11017,1,33586,1,3494,
	1,5174,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Masterwork Target Dummy -- 19814
	AddRecipe(19814,275,16023,1,GAME_ORIG,275,295,305,315)
	self:addTradeFlags(RecipeDB,19814,1,2,4,36,40)
	self:addTradeAcquire(RecipeDB,19814,2,11185)

	-- Delicate Arcanite Converter -- 19815
	AddRecipe(19815,285,16006,1,GAME_ORIG,285,305,315,325)
	self:addTradeFlags(RecipeDB,19815,1,2,4,36,40)
	self:addTradeAcquire(RecipeDB,19815,2,11185)

	-- Voice Amplification Modulator -- 19819
	AddRecipe(19819,290,16009,2,GAME_ORIG,290,310,320,330)
	self:addTradeFlags(RecipeDB,19819,1,2,5,36,40,63)
	self:addTradeAcquire(RecipeDB,19819,3,10426)

	-- Master Engineer's Goggles -- 19825
	AddRecipe(19825,290,16008,2,GAME_ORIG,290,310,320,330)
	self:addTradeFlags(RecipeDB,19825,1,2,3,36,40,53,54,56)
	self:addTradeAcquire(RecipeDB,19825,1,8736,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,11017,1,33586,1,3494,
	1,5174,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Arcanite Dragonling -- 19830
	AddRecipe(19830,300,16022,2,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,19830,1,2,11,36,40,61)
	self:addTradeAcquire(RecipeDB,19830,3,7437)

	-- Arcane Bomb -- 19831
	AddRecipe(19831,300,16040,2,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,19831,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,19831,7,2)

	-- Flawless Arcanite Rifle -- 19833
	AddRecipe(19833,300,16007,2,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,19833,1,2,11,36,40,51,80)
	self:addTradeAcquire(RecipeDB,19833,3,8561)

	-- SnowMaster 9000 -- 21940
	AddRecipe(21940,190,17716,2,GAME_ORIG,190,190,210,230)
	self:addTradeFlags(RecipeDB,21940,1,2,7,11,36,40)
	self:addTradeAcquire(RecipeDB,21940,5,1)

	-- Field Repair Bot 74A -- 22704
	AddRecipe(22704,300,18232,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,22704,1,2,5,36,41)
	self:addTradeAcquire(RecipeDB,22704,8,17)

	-- Biznicks 247x128 Accurascope -- 22793
	AddRecipe(22793,300,18283,3,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,22793,1,2,6,36,41,51)
	self:addTradeAcquire(RecipeDB,22793,8,26)

	-- Core Marksman Rifle -- 22795
	AddRecipe(22795,300,18282,3,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,22795,1,2,6,36,41,51,80)
	self:addTradeAcquire(RecipeDB,22795,8,26)

	-- Force Reactive Disk -- 22797
	AddRecipe(22797,300,18168,3,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,22797,1,2,6,36,41,52,64,66)
	self:addTradeAcquire(RecipeDB,22797,8,26)

	-- Red Firework -- 23066
	AddRecipe(23066,150,9318,1,GAME_ORIG,150,150,162,175)
	self:addTradeFlags(RecipeDB,23066,2,4,36,40)
	self:addTradeAcquire(RecipeDB,23066,2,3413)

	-- Blue Firework -- 23067
	AddRecipe(23067,150,9312,1,GAME_ORIG,150,150,162,175)
	self:addTradeFlags(RecipeDB,23067,1,4,36,40)
	self:addTradeAcquire(RecipeDB,23067,2,5175)

	-- Green Firework -- 23068
	AddRecipe(23068,150,9313,1,GAME_ORIG,150,150,162,175)
	self:addTradeFlags(RecipeDB,23068,1,2,4,36,41)
	self:addTradeAcquire(RecipeDB,23068,2,2838,2,3495)

	-- EZ-Thro Dynamite II -- 23069
	AddRecipe(23069,200,18588,1,GAME_ORIG,200,200,210,220)
	self:addTradeFlags(RecipeDB,23069,1,2,4,36,40)
	self:addTradeAcquire(RecipeDB,23069,2,8131)

	-- Dense Dynamite -- 23070
	AddRecipe(23070,250,18641,1,GAME_ORIG,250,250,260,270)
	self:addTradeFlags(RecipeDB,23070,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,23070,1,8736,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,11017,1,33586,1,3494,
	1,5174,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Truesilver Transformer -- 23071
	AddRecipe(23071,260,18631,1,GAME_ORIG,260,270,275,280)
	self:addTradeFlags(RecipeDB,23071,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,23071,1,8736,1,17634,1,17637,1,18752,1,18775,1,19576,1,16667,1,28697,1,1702,1,16726,1,11017,1,33586,1,3494,
	1,5174,1,3290,1,5518,1,26991,1,33611,1,33634,1,1676,1,25277,1,26907,1,11031,1,11025,1,26955,1,11037,1,17222)

	-- Gyrofreeze Ice Reflector -- 23077
	AddRecipe(23077,260,18634,1,GAME_ORIG,260,280,290,300)
	self:addTradeFlags(RecipeDB,23077,1,2,4,36,40,61)
	self:addTradeAcquire(RecipeDB,23077,2,11185)

	-- Goblin Jumper Cables XL -- 23078
	AddRecipe(23078,265,18587,2,GAME_ORIG,265,285,295,305,20222)
	self:addTradeFlags(RecipeDB,23078,1,2,5,36,40)
	self:addTradeAcquire(RecipeDB,23078,3,9499)

	-- Major Recombobulator -- 23079
	AddRecipe(23079,275,18637,2,GAME_ORIG,275,285,290,295)
	self:addTradeFlags(RecipeDB,23079,1,2,5,36,40,61)
	self:addTradeAcquire(RecipeDB,23079,8,32)

	-- Powerful Seaforium Charge -- 23080
	AddRecipe(23080,275,18594,1,GAME_ORIG,275,275,285,295)
	self:addTradeFlags(RecipeDB,23080,1,2,4,36,40)
	self:addTradeAcquire(RecipeDB,23080,2,11185)

	-- Hyper-Radiant Flame Reflector -- 23081
	AddRecipe(23081,290,18638,2,GAME_ORIG,290,310,320,330)
	self:addTradeFlags(RecipeDB,23081,1,2,5,36,40,61)
	self:addTradeAcquire(RecipeDB,23081,3,10264)

	-- Ultra-Flash Shadow Reflector -- 23082
	AddRecipe(23082,300,18639,2,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,23082,1,2,5,36,40,61)
	self:addTradeAcquire(RecipeDB,23082,3,10426)

	-- Alarm-O-Bot -- 23096
	AddRecipe(23096,265,18645,2,GAME_ORIG,265,275,280,285,20219)
	self:addTradeFlags(RecipeDB,23096,1,2,5,11,36,40)
	self:addTradeAcquire(RecipeDB,23096,3,8920)

	-- World Enlarger -- 23129
	AddRecipe(23129,260,18660,2,GAME_ORIG,260,260,265,270,20219)
	self:addTradeFlags(RecipeDB,23129,1,2,5,11,36,40)
	self:addTradeAcquire(RecipeDB,23129,3,8920)

	-- Dimensional Ripper - Everlook -- 23486
	AddRecipe(23486,260,18984,2,GAME_ORIG,260,285,295,305,20222)
	self:addTradeFlags(RecipeDB,23486,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,23486,8,20)

	-- Ultrasafe Transporter - Gadgetzan -- 23489
	AddRecipe(23489,260,18986,2,GAME_ORIG,260,285,295,305,20219)
	self:addTradeFlags(RecipeDB,23489,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,23489,8,20)

	-- Snake Burst Firework -- 23507
	AddRecipe(23507,250,19026,1,GAME_ORIG,250,250,260,270)
	self:addTradeFlags(RecipeDB,23507,1,2,4,36,41)
	self:addTradeAcquire(RecipeDB,23507,2,14637)

	-- Bloodvine Goggles -- 24356
	AddRecipe(24356,300,19999,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,24356,1,2,4,36,41,56,100)
	self:addTradeAcquire(RecipeDB,24356,6,270,2,14921)

	-- Bloodvine Lens -- 24357
	AddRecipe(24357,300,19998,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,24357,1,2,4,36,41,57,100)
	self:addTradeAcquire(RecipeDB,24357,6,270,1,14921)

	-- Tranquil Mechanical Yeti -- 26011
	AddRecipe(26011,250,21277,1,GAME_ORIG,250,320,330,340)
	self:addTradeFlags(RecipeDB,26011,1,2,8,36,41)
	self:addTradeAcquire(RecipeDB,26011,4,8798)

	-- Small Blue Rocket -- 26416
	AddRecipe(26416,125,21558,2,GAME_ORIG,125,125,137,150)
	self:addTradeFlags(RecipeDB,26416,1,2,4,7,36,41)
	self:addTradeAcquire(RecipeDB,26416,5,2,2,15909)

	-- Small Green Rocket -- 26417
	AddRecipe(26417,125,21559,2,GAME_ORIG,125,125,137,150)
	self:addTradeFlags(RecipeDB,26417,1,2,4,7,36,41)
	self:addTradeAcquire(RecipeDB,26417,5,2,2,15909)

	-- Small Red Rocket -- 26418
	AddRecipe(26418,125,21557,2,GAME_ORIG,125,125,137,150)
	self:addTradeFlags(RecipeDB,26418,1,2,4,7,36,41)
	self:addTradeAcquire(RecipeDB,26418,5,2,2,15909)

	-- Large Blue Rocket -- 26420
	AddRecipe(26420,175,21589,2,GAME_ORIG,175,175,187,200)
	self:addTradeFlags(RecipeDB,26420,1,2,4,7,36,41)
	self:addTradeAcquire(RecipeDB,26420,5,2,2,15909)

	-- Large Green Rocket -- 26421
	AddRecipe(26421,175,21590,2,GAME_ORIG,175,175,187,200)
	self:addTradeFlags(RecipeDB,26421,1,2,4,7,36,41)
	self:addTradeAcquire(RecipeDB,26421,5,2,2,15909)

	-- Large Red Rocket -- 26422
	AddRecipe(26422,175,21592,2,GAME_ORIG,175,175,187,200)
	self:addTradeFlags(RecipeDB,26422,1,2,4,7,36,41)
	self:addTradeAcquire(RecipeDB,26422,5,2,2,15909)

	-- Blue Rocket Cluster -- 26423
	AddRecipe(26423,225,21571,2,GAME_ORIG,225,225,237,250)
	self:addTradeFlags(RecipeDB,26423,1,2,4,7,36,41)
	self:addTradeAcquire(RecipeDB,26423,5,2,2,15909)

	-- Green Rocket Cluster -- 26424
	AddRecipe(26424,225,21574,2,GAME_ORIG,225,225,237,250)
	self:addTradeFlags(RecipeDB,26424,1,2,4,7,36,41)
	self:addTradeAcquire(RecipeDB,26424,5,2,2,15909)

	-- Red Rocket Cluster -- 26425
	AddRecipe(26425,225,21576,2,GAME_ORIG,225,225,237,250)
	self:addTradeFlags(RecipeDB,26425,1,2,4,7,36,41)
	self:addTradeAcquire(RecipeDB,26425,5,2,2,15909)

	-- Large Blue Rocket Cluster -- 26426
	AddRecipe(26426,275,21714,2,GAME_ORIG,275,275,280,285)
	self:addTradeFlags(RecipeDB,26426,1,2,4,7,36,41)
	self:addTradeAcquire(RecipeDB,26426,5,2,2,15909)

	-- Large Green Rocket Cluster -- 26427
	AddRecipe(26427,275,21716,2,GAME_ORIG,275,275,280,285)
	self:addTradeFlags(RecipeDB,26427,1,2,4,7,36,41)
	self:addTradeAcquire(RecipeDB,26427,5,2,2,15909)

	-- Large Red Rocket Cluster -- 26428
	AddRecipe(26428,275,21718,2,GAME_ORIG,275,275,280,285)
	self:addTradeFlags(RecipeDB,26428,1,2,4,7,36,41)
	self:addTradeAcquire(RecipeDB,26428,5,2,2,15909)

	-- Firework Launcher -- 26442
	AddRecipe(26442,225,21569,2,GAME_ORIG,225,245,255,265)
	self:addTradeFlags(RecipeDB,26442,1,2,4,7,36,41)
	self:addTradeAcquire(RecipeDB,26442,5,2,2,15909)

	-- Firework Cluster Launcher -- 26443
	AddRecipe(26443,275,21570,2,GAME_ORIG,275,295,305,315)
	self:addTradeFlags(RecipeDB,26443,1,2,4,7,36,41)
	self:addTradeAcquire(RecipeDB,26443,5,2,2,15909)

	-- Steam Tonk Controller -- 28327
	AddRecipe(28327,275,22728,1,GAME_ORIG,325,325,330,335)
	self:addTradeFlags(RecipeDB,28327,1,2,4,8,36,41)
	self:addTradeAcquire(RecipeDB,28327,4,9249,2,3413,2,5175)

	-- Elemental Blasting Powder -- 30303
	AddRecipe(30303,300,23781,1,1,300,300,310,320)
	self:addTradeFlags(RecipeDB,30303,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,30303,1,17634,1,17637,1,18752,1,18775,1,19576,1,28697,1,33586,1,26991,1,33611,1,33634,1,25277,1,26907,1,26955)

	-- Fel Iron Casing -- 30304
	AddRecipe(30304,300,23782,1,1,300,300,310,320)
	self:addTradeFlags(RecipeDB,30304,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,30304,1,17634,1,17637,1,18752,1,18775,1,19576,1,28697,1,33586,1,26991,1,33611,1,33634,1,25277,1,26907,1,26955)

	-- Handful of Fel Iron Bolts -- 30305
	AddRecipe(30305,300,23783,1,1,300,300,305,310)
	self:addTradeFlags(RecipeDB,30305,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,30305,1,17634,1,17637,1,18752,1,18775,1,19576,1,28697,1,33586,1,26991,1,33611,1,33634,1,25277,1,26907,1,26955)

	-- Adamantite Frame -- 30306
	AddRecipe(30306,325,23784,1,1,325,325,330,335)
	self:addTradeFlags(RecipeDB,30306,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,30306,1,17634,1,17637,1,18752,1,18775,1,19576,1,28697,1,33586,1,26991,1,33611,1,33634,1,25277,1,26907,1,26955)

	-- Hardened Adamantite Tube -- 30307
	AddRecipe(30307,340,23785,1,1,340,350,360,370)
	self:addTradeFlags(RecipeDB,30307,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,30307,1,17634,1,17637,1,18752,1,18775,1,19576,1,28697,1,33586,1,26991,1,33611,1,33634,1,25277,1,26907,1,26955)

	-- Khorium Power Core -- 30308
	AddRecipe(30308,340,23786,1,1,340,350,360,370)
	self:addTradeFlags(RecipeDB,30308,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,30308,1,17634,1,17637,1,18752,1,18775,1,19576,1,28697,1,33586,1,26991,1,33611,1,33634,1,25277,1,26907,1,26955)

	-- Felsteel Stabilizer -- 30309
	AddRecipe(30309,340,23787,1,1,340,350,360,370)
	self:addTradeFlags(RecipeDB,30309,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,30309,1,17634,1,17637,1,18752,1,18775,1,19576,1,28697,1,33586,1,26991,1,33611,1,33634,1,25277,1,26907,1,26955)

	-- Fel Iron Bomb -- 30310
	AddRecipe(30310,300,23736,1,1,300,320,330,340)
	self:addTradeFlags(RecipeDB,30310,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,30310,1,17634,1,17637,1,18752,1,18775,1,19576,1,28697,1,33586,1,26991,1,33611,1,33634,1,25277,1,26907,1,26955)

	-- Adamantite Grenade -- 30311
	AddRecipe(30311,325,23737,1,1,325,335,345,355)
	self:addTradeFlags(RecipeDB,30311,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,30311,1,17634,1,17637,1,18752,1,18775,1,19576,1,28697,1,33586,1,26991,1,33611,1,33634,1,25277,1,26907,1,26955)

	-- Fel Iron Musket -- 30312
	AddRecipe(30312,320,23742,1,1,320,330,340,350)
	self:addTradeFlags(RecipeDB,30312,1,2,3,36,41,80)
	self:addTradeAcquire(RecipeDB,30312,1,17634,1,17637,1,18752,1,18775,1,19576,1,28697,1,33586,1,26991,1,33611,1,33634,1,25277,1,26907,1,26955)

	-- Adamantite Rifle -- 30313
	AddRecipe(30313,350,23746,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,30313,1,2,4,36,40,51,80)
	self:addTradeAcquire(RecipeDB,30313,2,16657,2,16782,2,19661)

	-- Felsteel Boomstick -- 30314
	AddRecipe(30314,360,23747,3,1,360,370,380,390)
	self:addTradeFlags(RecipeDB,30314,1,2,11,36,41,80)
	self:addTradeAcquire(RecipeDB,30314,3,19960)

	-- Ornate Khorium Rifle -- 30315
	AddRecipe(30315,375,23748,3,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,30315,1,2,10,36,40,51,80)
	self:addTradeAcquire(RecipeDB,30315,7,3)

	-- Cogspinner Goggles -- 30316
	AddRecipe(30316,340,23758,1,1,340,350,360,370)
	self:addTradeFlags(RecipeDB,30316,1,2,4,36,40,57)
	self:addTradeAcquire(RecipeDB,30316,2,18775,2,19836)

	-- Power Amplification Goggles -- 30317
	AddRecipe(30317,340,23761,3,1,340,350,360,370)
	self:addTradeFlags(RecipeDB,30317,1,2,10,36,40,53,54,56)
	self:addTradeAcquire(RecipeDB,30317,7,3)

	-- Ultra-Spectropic Detection Goggles -- 30318
	AddRecipe(30318,350,23762,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,30318,1,2,4,36,40,56)
	self:addTradeAcquire(RecipeDB,30318,2,18775,2,19383)

	-- Hyper-Vision Goggles -- 30325
	AddRecipe(30325,360,23763,3,1,360,370,380,390)
	self:addTradeFlags(RecipeDB,30325,1,2,11,36,41,51,57)
	self:addTradeAcquire(RecipeDB,30325,3,19755)

	-- Adamantite Scope -- 30329
	AddRecipe(30329,335,23764,1,1,335,345,355,365)
	self:addTradeFlags(RecipeDB,30329,1,2,4,36,40)
	self:addTradeAcquire(RecipeDB,30329,2,19351,2,19836)

	-- Khorium Scope -- 30332
	AddRecipe(30332,360,23765,3,1,360,370,380,390)
	self:addTradeFlags(RecipeDB,30332,1,2,11,36,41)
	self:addTradeAcquire(RecipeDB,30332,3,20207)

	-- Stabilized Eternium Scope -- 30334
	AddRecipe(30334,375,23766,3,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,30334,1,2,6,11,36,41)
	self:addTradeAcquire(RecipeDB,30334,3,16152)

	-- Crashin' Thrashin' Robot -- 30337
	AddRecipe(30337,325,23767,2,1,325,335,345,355)
	self:addTradeFlags(RecipeDB,30337,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,30337,7,2)

	-- White Smoke Flare -- 30341
	AddRecipe(30341,335,23768,1,1,335,335,345,355)
	self:addTradeFlags(RecipeDB,30341,1,2,4,36,40)
	self:addTradeAcquire(RecipeDB,30341,2,16657,2,16782,2,18484,2,19383)

	-- Green Smoke Flare -- 30344
	AddRecipe(30344,335,23771,1,1,335,335,345,355)
	self:addTradeFlags(RecipeDB,30344,1,2,4,36,41,103)
	self:addTradeAcquire(RecipeDB,30344,6,942,1,17904)

	-- Fel Iron Shells -- 30346
	AddRecipe(30346,310,23772,1,1,310,310,320,330)
	self:addTradeFlags(RecipeDB,30346,1,2,3,36,41,78)
	self:addTradeAcquire(RecipeDB,30346,1,17634,1,17637,1,18752,1,18775,1,19576,1,28697,1,33586,1,26991,1,33611,1,33634,1,25277,1,26907,1,26955)

	-- Adamantite Shell Machine -- 30347
	AddRecipe(30347,335,34504,1,1,335,335,345,355)
	self:addTradeFlags(RecipeDB,30347,1,2,4,36,40,78)
	self:addTradeAcquire(RecipeDB,30347,2,16657,2,16782,2,18484)

	-- Fel Iron Toolbox -- 30348
	AddRecipe(30348,325,23774,1,1,325,325,335,345)
	self:addTradeFlags(RecipeDB,30348,1,2,4,36,40)
	self:addTradeAcquire(RecipeDB,30348,2,16657,2,16782,2,18484)
	
	-- Titanium Toolbox -- 30349
	AddRecipe(30349,440,23775,3,2,405,425,435,440)
	self:addTradeFlags(RecipeDB,30349,1,2,4,36,41)
	self:addTradeAcquire(RecipeDB,30349,2,28722)

	-- Elemental Seaforium Charge -- 30547
	AddRecipe(30547,350,23819,1,1,350,350,355,360)
	self:addTradeFlags(RecipeDB,30547,1,2,4,36,41,105)
	self:addTradeAcquire(RecipeDB,30547,6,933,3,20242,6,933,3,23007)

	-- Zapthrottle Mote Extractor -- 30548
	AddRecipe(30548,305,23821,1,1,305,305,315,325)
	self:addTradeFlags(RecipeDB,30548,1,2,8,36,41)
	self:addTradeAcquire(RecipeDB,30548,4,9635,4,9636)

	-- Healing Potion Injector -- 30551
	AddRecipe(30551,330,33092,3,1,330,330,340,350)
	self:addTradeFlags(RecipeDB,30551,1,2,11,36,41)
	self:addTradeAcquire(RecipeDB,30551,3,24664)

	-- Mana Potion Injector -- 30552
	AddRecipe(30552,345,33093,3,1,345,345,355,365)
	self:addTradeFlags(RecipeDB,30552,1,2,11,36,41)
	self:addTradeAcquire(RecipeDB,30552,3,24664)

	-- Rocket Boots Xtreme -- 30556
	AddRecipe(30556,355,23824,3,1,355,365,375,385)
	self:addTradeFlags(RecipeDB,30556,1,2,5,36,41,51,57)
	self:addTradeAcquire(RecipeDB,30556,3,17796)

	-- The Bigger One -- 30558
	AddRecipe(30558,325,23826,1,1,325,325,335,345,20222)
	self:addTradeFlags(RecipeDB,30558,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,30558,1,8126,1,8738,1,29513)

	-- Super Sapper Charge -- 30560
	AddRecipe(30560,340,23827,1,1,340,340,350,360,20222)
	self:addTradeFlags(RecipeDB,30560,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,30560,1,8126,1,8738,1,29513)

	-- Goblin Rocket Launcher -- 30563
	AddRecipe(30563,350,23836,1,1,350,360,370,380,20222)
	self:addTradeFlags(RecipeDB,30563,1,2,3,36,41,61)
	self:addTradeAcquire(RecipeDB,30563,1,8126,1,8738,1,29513)

	-- Foreman's Enchanted Helmet -- 30565
	AddRecipe(30565,375,23838,1,1,375,375,385,395,20222)
	self:addTradeFlags(RecipeDB,30565,1,2,3,37,41,53,54,56)
	self:addTradeAcquire(RecipeDB,30565,1,8126,1,8738,1,29513)

	-- Foreman's Reinforced Helmet -- 30566
	AddRecipe(30566,375,23839,1,1,375,375,385,395,20222)
	self:addTradeFlags(RecipeDB,30566,1,2,3,37,41,51,58)
	self:addTradeAcquire(RecipeDB,30566,1,8126,1,8738,1,29513)

	-- Gnomish Flame Turret -- 30568
	AddRecipe(30568,325,23841,1,1,325,335,345,355,20219)
	self:addTradeFlags(RecipeDB,30568,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,30568,1,7406,1,7944,1,29514)

	-- Gnomish Poultryizer -- 30569
	AddRecipe(30569,340,23835,1,1,340,360,370,380,20219)
	self:addTradeFlags(RecipeDB,30569,1,2,3,36,41,61)
	self:addTradeAcquire(RecipeDB,30569,1,7406,1,7944,1,29514)

	-- Nigh-Invulnerability Belt -- 30570
	AddRecipe(30570,350,23825,1,1,350,360,370,380,20219)
	self:addTradeFlags(RecipeDB,30570,1,2,3,36,41,56)
	self:addTradeAcquire(RecipeDB,30570,1,7406,1,7944,1,29514)

	-- Gnomish Power Goggles -- 30574
	AddRecipe(30574,375,23828,1,1,375,375,385,395,20219)
	self:addTradeFlags(RecipeDB,30574,1,2,3,37,41,53,54,56)
	self:addTradeAcquire(RecipeDB,30574,1,7406,1,7944,1,29514)

	-- Gnomish Battle Goggles -- 30575
	AddRecipe(30575,375,23829,1,1,375,375,385,395,20219)
	self:addTradeFlags(RecipeDB,30575,1,2,3,37,41,51,57)
	self:addTradeAcquire(RecipeDB,30575,1,7406,1,7944,1,29514)

	-- Purple Smoke Flare -- 32814
	AddRecipe(32814,335,25886,2,1,335,335,345,355)
	self:addTradeFlags(RecipeDB,32814,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,32814,7,2)

	-- Dimensional Ripper - Area 52 -- 36954
	AddRecipe(36954,350,30542,2,1,350,350,360,370,20222)
	self:addTradeFlags(RecipeDB,36954,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,36954,8,20)

	-- Ultrasafe Transporter - Toshley's Station -- 36955
	AddRecipe(36955,350,30544,2,1,350,350,360,370,20219)
	self:addTradeFlags(RecipeDB,36955,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,36955,8,21)

	-- Fused Wiring -- 39895
	AddRecipe(39895,275,7191,1,1,275,275,280,285)
	self:addTradeFlags(RecipeDB,39895,1,2,4,36,40)
	self:addTradeAcquire(RecipeDB,39895,2,11185,2,19661)

	-- Icy Blasting Primers -- 39971
	AddRecipe(39971,335,32423,1,1,335,335,340,345)
	self:addTradeFlags(RecipeDB,39971,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,39971,1,17634,1,17637,1,18752,1,18775,1,19576,1,28697,1,33586,1,26991,1,33611,1,33634,1,25277,1,26907,1,26955)

	-- Frost Grenades -- 39973
	AddRecipe(39973,335,32413,1,1,335,345,355,365)
	self:addTradeFlags(RecipeDB,39973,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,39973,1,17634,1,17637,1,18752,1,18775,1,19576,1,28697,1,33586,1,26991,1,33611,1,33634,1,25277,1,26907,1,26955)

	-- Furious Gizmatic Goggles -- 40274
	AddRecipe(40274,350,32461,1,1,350,370,380,390)
	self:addTradeFlags(RecipeDB,40274,1,2,3, F_PALADIN, F_WARRIOR,37,41,51,59)
	self:addTradeAcquire(RecipeDB,40274,1,17634,1,17637,1,18752,1,18775,1,19576,1,33586,1,28697,1,25277,1,26955)

	-- Gyro-balanced Khorium Destroyer -- 41307
	AddRecipe(41307,375,32756,1,1,375,375,392,410)
	self:addTradeFlags(RecipeDB,41307,1,2,3,36,41,80)
	self:addTradeAcquire(RecipeDB,41307,1,17634,1,17637,1,18752,1,18775,1,19576,1,28697,1,33586,1,26991,1,33611,1,33634,1,25277,1,26907,1,26955)

	-- Justicebringer 2000 Specs -- 41311
	AddRecipe(41311,350,32472,1,1,350,370,380,390)
	self:addTradeFlags(RecipeDB,41311,1,2,3, F_PALADIN,37,41,59)

	-- Tankatronic Goggles -- 41312
	AddRecipe(41312,350,32473,1,1,350,370,380,390)
	self:addTradeFlags(RecipeDB,41312,1,2,3, F_PALADIN, F_WARRIOR,37,41,52,59)

	-- Surestrike Goggles v2.0 -- 41314
	AddRecipe(41314,350,32474,1,1,350,370,380,390)
	self:addTradeFlags(RecipeDB,41314,1,2,3, F_HUNTER, F_SHAMAN,37,41,58)

	-- Gadgetstorm Goggles -- 41315
	AddRecipe(41315,350,32476,4,1,350,370,380,390)
	self:addTradeFlags(RecipeDB,41315,1,2,3, F_SHAMAN,37,41,58)

	-- Living Replicator Specs -- 41316
	AddRecipe(41316,350,32475,4,1,350,370,380,390)
	self:addTradeFlags(RecipeDB,41316,1,2,3, F_SHAMAN,37,41,58)

	-- Deathblow X11 Goggles -- 41317
	AddRecipe(41317,350,32478,1,1,350,370,380,390)
	self:addTradeFlags(RecipeDB,41317,1,2,3, F_DRUID, F_ROGUE,37,41,57)

	-- Wonderheal XT40 Shades -- 41318
	AddRecipe(41318,350,32479,4,1,350,370,380,390)
	self:addTradeFlags(RecipeDB,41318,1,2,3, F_DRUID,37,41,57)

	-- Magnified Moon Specs -- 41319
	AddRecipe(41319,350,32480,4,1,350,370,380,390)
	self:addTradeFlags(RecipeDB,41319,1,2,3, F_DRUID,37,41,57)

	-- Destruction Holo-gogs -- 41320
	AddRecipe(41320,350,32494,1,1,350,370,380,390)
	self:addTradeFlags(RecipeDB,41320,1,2,3, F_MAGE, F_PRIEST, F_WARLOCK,37,41,56)

	-- Powerheal 4000 Lens -- 41321
	AddRecipe(41321,350,32495,4,1,350,370,380,390)
	self:addTradeFlags(RecipeDB,41321,1,2,3, F_PRIEST,37,41,56)

	-- Level 70 Goggles
	-- All are listed here because they all share the same trainers but can only be seen by specific classes
	self:addTradeAcquire(RecipeDB,41311,1,17634,1,17637,1,18752,1,18775,1,19576,1,25277,1,26907,1,26955,1,26991,1,33586,1,28697)
	self:addTradeAcquire(RecipeDB,41312,1,17634,1,17637,1,18752,1,18775,1,19576,1,25277,1,26907,1,26955,1,26991,1,33586,1,28697)
	self:addTradeAcquire(RecipeDB,41314,1,17634,1,17637,1,18752,1,18775,1,19576,1,25277,1,26907,1,26955,1,26991,1,33586,1,28697)
	self:addTradeAcquire(RecipeDB,41315,1,17634,1,17637,1,18752,1,18775,1,19576,1,25277,1,26907,1,26955,1,26991,1,33586,1,28697)
	self:addTradeAcquire(RecipeDB,41316,1,17634,1,17637,1,18752,1,18775,1,19576,1,25277,1,26907,1,26955,1,26991,1,33586,1,28697)
	self:addTradeAcquire(RecipeDB,41317,1,17634,1,17637,1,18752,1,18775,1,19576,1,25277,1,26907,1,26955,1,26991,1,33586,1,28697)
	self:addTradeAcquire(RecipeDB,41318,1,17634,1,17637,1,18752,1,18775,1,19576,1,25277,1,26907,1,26955,1,26991,1,33586,1,28697)
	self:addTradeAcquire(RecipeDB,41319,1,17634,1,17637,1,18752,1,18775,1,19576,1,25277,1,26907,1,26955,1,26991,1,33586,1,28697)
	self:addTradeAcquire(RecipeDB,41320,1,17634,1,17637,1,18752,1,18775,1,19576,1,25277,1,26907,1,26955,1,26991,1,33586,1,28697)
	self:addTradeAcquire(RecipeDB,41321,1,17634,1,17637,1,18752,1,18775,1,19576,1,25277,1,26907,1,26955,1,26991,1,33586,1,28697)

	-- Adamantite Arrow Maker -- 43676
	AddRecipe(43676,335,20475,2,1,335,335,345,355)
	self:addTradeFlags(RecipeDB,43676,1,2,11,36,41)
	self:addTradeAcquire(RecipeDB,43676,3,19707)

	-- Flying Machine -- 44155
	AddRecipe(44155,300,34060,3,1,300,330,340,350)
	self:addTradeFlags(RecipeDB,44155,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,44155,1,24868,1,25099,1,25277,1,28697,1,26955,1,33586)

	-- Turbo-Charged Flying Machine -- 44157
	AddRecipe(44157,375,34061,4,1,375,385,390,395)
	self:addTradeFlags(RecipeDB,44157,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,44157,1,24868,1,25099)

	-- Field Repair Bot 110G -- 44391
	AddRecipe(44391,360,34113,2,1,360,370,380,390)
	self:addTradeFlags(RecipeDB,44391,1,2,11,36,41)
	self:addTradeAcquire(RecipeDB,44391,3,23385,3,23386)

	-- Wonderheal XT68 Shades -- 46106
	AddRecipe(46106,375,35183,4,1,375,390,410,430)
	self:addTradeFlags(RecipeDB,46106,1,2,6, F_DRUID,37,41,57)
	self:addTradeAcquire(RecipeDB,46106,8,33)

	-- Justicebringer 3000 Specs -- 46107
	AddRecipe(46107,375,35185,4,1,375,390,410,430)
	self:addTradeFlags(RecipeDB,46107,1,2,6, F_PALADIN,37,41,59)
	self:addTradeAcquire(RecipeDB,46107,8,24)

	-- Powerheal 9000 Lens -- 46108
	AddRecipe(46108,375,35181,4,1,375,390,410,430)
	self:addTradeFlags(RecipeDB,46108,1,2,6, F_PRIEST,37,41,56)
	self:addTradeAcquire(RecipeDB,46108,8,24)

	-- Hyper-Magnified Moon Specs -- 46109
	AddRecipe(46109,375,35182,4,1,375,390,410,430)
	self:addTradeFlags(RecipeDB,46109,1,2,6, F_DRUID,37,41,57)
	self:addTradeAcquire(RecipeDB,46109,8,24)

	-- Primal-Attuned Goggles -- 46110
	AddRecipe(46110,375,35184,4,1,375,390,410,430)
	self:addTradeFlags(RecipeDB,46110,1,2,6, F_SHAMAN,37,41,58)
	self:addTradeAcquire(RecipeDB,46110,8,24)

	-- Annihilator Holo-Gogs -- 46111
	AddRecipe(46111,375,34847,4,1,375,390,410,430)
	self:addTradeFlags(RecipeDB,46111,1,2,6, F_MAGE, F_PRIEST, F_WARLOCK,37,41,56)
	self:addTradeAcquire(RecipeDB,46111,8,24)

	-- Lightning Etched Specs -- 46112
	AddRecipe(46112,375,34355,4,1,375,390,410,430)
	self:addTradeFlags(RecipeDB,46112,1,2,6, F_SHAMAN,37,41,58)
	self:addTradeAcquire(RecipeDB,46112,8,24)

	-- Surestrike Goggles v3.0 -- 46113
	AddRecipe(46113,375,34356,4,1,375,390,410,430)
	self:addTradeFlags(RecipeDB,46113,1,2,6, F_HUNTER, F_SHAMAN,37,41,58)
	self:addTradeAcquire(RecipeDB,46113,8,24)

	-- Mayhem Projection Goggles -- 46114
	AddRecipe(46114,375,34354,4,1,375,390,410,430)
	self:addTradeFlags(RecipeDB,46114,1,2,6, F_DK,F_PALADIN, F_WARRIOR,37,41,51,59)
	self:addTradeAcquire(RecipeDB,46114,8,24)

	-- Hard Khorium Goggles -- 46115
	AddRecipe(46115,375,34357,4,1,375,390,410,430)
	self:addTradeFlags(RecipeDB,46115,1,2,6, F_PALADIN, F_WARRIOR,37,41,52,59)
	self:addTradeAcquire(RecipeDB,46115,8,24)

	-- Quad Deathblow X44 Goggles -- 46116
	AddRecipe(46116,375,34353,4,1,375,390,410,430)
	self:addTradeFlags(RecipeDB,46116,1,2,6, F_DRUID, F_ROGUE,37,41,57)
	self:addTradeAcquire(RecipeDB,46116,8,24)

	-- Rocket Boots Xtreme Lite -- 46697
	AddRecipe(46697,355,35581,3,1,355,365,375,385)
	self:addTradeFlags(RecipeDB,46697,1,2,5,36,41,53,54,56)
	self:addTradeAcquire(RecipeDB,46697,3,19219)

	-- Volatile Blasting Trigger -- 53281
	AddRecipe(53281,350,39690,1,1,350,366,375,385)
	self:addTradeFlags(RecipeDB,53281,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,53281,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Mark "S" Boomstick -- 54353
	AddRecipe(54353,400,39688,3,2,400,405,410,415)
	self:addTradeFlags(RecipeDB,54353,1,2,3,37,41,51,80)
	self:addTradeAcquire(RecipeDB,54353,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Personal Electromagnetic Pulse Generator -- 54736
	AddRecipe(54736,390,nil,1,2,390,390,392,395)
	self:addTradeFlags(RecipeDB,54736,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,54736,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Belt-Clipped Spynoculars (Frag Belt) -- 54793
	AddRecipe(54793,380,nil,1,2,380,380,382,385)
	self:addTradeFlags(RecipeDB,54793,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,54793,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Hand-Mounted Pyro Rocket -- 54998
	AddRecipe(54998,400,nil,1,2,400,400,402,405)
	self:addTradeFlags(RecipeDB,54998,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,54998,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Hyperspeed Accelerators -- 54999
	AddRecipe(54999,400,nil,1,2,400,400,402,405)
	self:addTradeFlags(RecipeDB,54999,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,54999,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Flexweave Underlay -- 55002
	AddRecipe(55002,380,nil,1,2,380,380,382,385)
	self:addTradeFlags(RecipeDB,55002,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,55002,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Nitro Boosts -- 55016
	AddRecipe(55016,405,nil,1,2,405,405,405,410)
	self:addTradeFlags(RecipeDB,55016,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,55016,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Scrapbot Construction Kit -- 55252
	AddRecipe(55252,415,40769,1,2,415,415,417,420)
	self:addTradeFlags(RecipeDB,55252,1,2,8,36,41)
	self:addTradeAcquire(RecipeDB,55252,4,12889)

	-- Handful of Cobalt Bolts -- 56349
	AddRecipe(56349,350,39681,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,56349,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,56349,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Hammer Pick -- 56459
	AddRecipe(56459,375,40892,1,1,375,380,385,390)
	self:addTradeFlags(RecipeDB,56459,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,56459,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Cobalt Frag Bomb -- 56460
	AddRecipe(56460,350,40771,1,1,350,375,382,390)
	self:addTradeFlags(RecipeDB,56460,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,56460,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Bladed Pickaxe -- 56461
	AddRecipe(56461,375,40893,1,2,375,380,385,390)
	self:addTradeFlags(RecipeDB,56461,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,56461,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Gnomish Army Knife -- 56462
	AddRecipe(56462,435,40772,1,2,435,440,445,450)
	self:addTradeFlags(RecipeDB,56462,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,56462,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Explosive Decoy -- 56463
	AddRecipe(56463,375,40536,1,2,375,385,390,395)
	self:addTradeFlags(RecipeDB,56463,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,56463,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Overcharged Capacitor -- 56464
	AddRecipe(56464,375,39682,1,2,375,380,385,390)
	self:addTradeFlags(RecipeDB,56464,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,56464,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Sonic Booster -- 56466
	AddRecipe(56466,420,40767,3,2,420,435,440,445)
	self:addTradeFlags(RecipeDB,56466,1,2,3,36,41,51,61)
	self:addTradeAcquire(RecipeDB,56466,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Noise Machine -- 56467
	AddRecipe(56467,420,40865,3,2,420,435,440,445)
	self:addTradeFlags(RecipeDB,56467,1,2,3,36,41,53,54,61)
	self:addTradeAcquire(RecipeDB,56467,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Saronite Bomb -- 56468
	AddRecipe(56468,405,41119,1,2,405,410,415,420)
	self:addTradeFlags(RecipeDB,56468,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,56468,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Gnomish Lightning Generator -- 56469
	AddRecipe(56469,425,41121,3,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,56469,1,2,3,37,41,61)
	self:addTradeAcquire(RecipeDB,56469,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Sun Scope -- 56470
	AddRecipe(56470,425,41146,3,2,425,430,432,435)
	self:addTradeFlags(RecipeDB,56470,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,56470,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Froststeel Tube -- 56471
	AddRecipe(56471,390,39683,1,2,390,395,400,405)
	self:addTradeFlags(RecipeDB,56471,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,56471,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- MOLL-E -- 56472
	AddRecipe(56472,425,40768,1,2,425,430,432,435)
	self:addTradeFlags(RecipeDB,56472,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,56472,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Gnomish X-Ray Specs -- 56473
	AddRecipe(56473,425,40895,3,2,425,430,435,440,20219)
	self:addTradeFlags(RecipeDB,56473,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,56473,1,26907,1,26955,1,29514)

	-- Ultrasafe Bullet Machine -- 56474
	AddRecipe(56474,410,44507,1,2,410,410,415,420)
	self:addTradeFlags(RecipeDB,56474,1,2,3,36,41,78)
	self:addTradeAcquire(RecipeDB,56474,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Saronite Arrow Maker -- 56475
	AddRecipe(56475,415,44506,1,2,415,415,417,425)
	self:addTradeFlags(RecipeDB,56475,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,56475,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Healing Injector Kit -- 56476
	AddRecipe(56476,410,37567,1,2,410,415,420,425)
	self:addTradeFlags(RecipeDB,56476,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,56476,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Mana Injector Kit -- 56477
	AddRecipe(56477,415,42546,1,2,415,420,425,430)
	self:addTradeFlags(RecipeDB,56477,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,56477,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Heartseeker Scope -- 56478
	AddRecipe(56478,430,41167,3,2,430,435,445,455)
	self:addTradeFlags(RecipeDB,56478,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,56478,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Armor Plated Combat Shotgun -- 56479
	AddRecipe(56479,450,41168,4,2,450,455,460,465)
	self:addTradeFlags(RecipeDB,56479,1,2,3,36,41,52,80)
	self:addTradeAcquire(RecipeDB,56479,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Armored Titanium Goggles -- 56480
	AddRecipe(56480,440,42549,3,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,56480,1,2,3, F_DK, F_PALADIN, F_WARRIOR,37,41,51,52,59)

	-- Weakness Spectralizers -- 56481
	AddRecipe(56481,440,42550,3,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,56481,1,2,3, F_DRUID,37,41,57)

	-- Charged Titanium Specs -- 56483
	AddRecipe(56483,440,42552,3,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,56483,1,2,3, F_DK, F_PALADIN, F_WARRIOR,37,41,51,59)

	-- Visage Liquification Goggles -- 56484
	AddRecipe(56484,440,42553,3,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,56484,1,2,3, F_MAGE, F_PRIEST, F_WARLOCK,37,41,53,54,56)

	-- Greensight Gogs -- 56486
	AddRecipe(56486,440,42554,3,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,56486,1,2,3, F_DRUID,37,41,57)

	-- Electroflux Sight Enhancers -- 56487
	AddRecipe(56487,440,42555,3,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,56487,1,2,3, F_SHAMAN,37,41,58)

	-- Global Thermal Sapper Charge -- 56514
	AddRecipe(56514,425,42641,1,2,425,425,430,435,20222)
	self:addTradeFlags(RecipeDB,56514,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,56514,1,25277,1,29513)

	-- Truesight Ice Blinders -- 56574
	AddRecipe(56574,440,42551,1,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,56574,1,2,3, F_HUNTER, F_SHAMAN,37,41,58)

	-- Nesingwary 4000 -- 60874
	AddRecipe(60874,450,44504,4,2,450,455,460,465)
	self:addTradeFlags(RecipeDB,60874,1,2,3,36,41,51,80)
	self:addTradeAcquire(RecipeDB,60874,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Diamond-cut Refractor Scope -- 61471
	AddRecipe(61471,390,44739,1,2,390,400,407,415)
	self:addTradeFlags(RecipeDB,61471,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,61471,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Mechanized Snow Goggles (Cloth) -- 56465
	AddRecipe(56465,420,41112,3,2,420,425,432,440)
	self:addTradeFlags(RecipeDB,56465,1,2,3, F_MAGE, F_PRIEST, F_WARLOCK,36,41,56)
	self:addTradeAcquire(RecipeDB,56465,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Mechanized Snow Goggles (Leather) -- 61481
	AddRecipe(61481,420,44742,3,2,420,425,432,440)
	self:addTradeFlags(RecipeDB,61481,1,2,3, F_DRUID, F_ROGUE,36,41,57)
	self:addTradeAcquire(RecipeDB,61481,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Mechanized Snow Goggles (Mail) -- 61482
	AddRecipe(61482,420,44742,3,2,420,425,432,440)
	self:addTradeFlags(RecipeDB,61482,1,2,3, F_HUNTER, F_SHAMAN,36,41,58)
	self:addTradeAcquire(RecipeDB,61482,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)	

	-- Mechanized Snow Goggles (Plate) -- 61483
	AddRecipe(61483,420,44742,3,2,420,425,432,440)
	self:addTradeFlags(RecipeDB,61483,1,2,3, F_DK, F_PALADIN, F_WARRIOR,36,41,59)
	self:addTradeAcquire(RecipeDB,61483,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Unbreakable Healing Amplifiers -- 62271
	AddRecipe(62271,440,44949,3,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,62271,1,2,3, F_PALADIN,37,41,53,59)
	self:addTradeAcquire(RecipeDB,62271,1,25277,1,26907,1,26955)

	-- Level 80 Goggles
	self:addTradeAcquire(RecipeDB,56484,1,25277,1,26907,1,26955,1,26991,1,33586,1,28697)
	self:addTradeAcquire(RecipeDB,56483,1,25277,1,26907,1,26955,1,26991,1,33586,1,28697)
	self:addTradeAcquire(RecipeDB,56481,1,25277,1,26907,1,26955,1,26991,1,33586,1,28697)
	self:addTradeAcquire(RecipeDB,56480,1,25277,1,26907,1,26955,1,26991,1,33586,1,28697)
	self:addTradeAcquire(RecipeDB,56486,1,25277,1,26907,1,26955,1,26991,1,33586,1,28697)
	self:addTradeAcquire(RecipeDB,56487,1,25277,1,26907,1,26955,1,26991,1,33586,1,28697)
	self:addTradeAcquire(RecipeDB,56574,1,25277,1,26907,1,26955,1,26991,1,33586,1,28697)

	-- Reticulated Armor Webbing -- 63770
	AddRecipe(63770,400,nil,1,2,400,400,402,405)
	self:addTradeFlags(RecipeDB,63770,1,2,3,37,41,52)
	self:addTradeAcquire(RecipeDB,63770,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- Springy Arachnoweave -- 63765
	AddRecipe(63765,380,nil,1,2,380,380,382,385)
	self:addTradeFlags(RecipeDB,63765,1,2,3,37,41,53,54)
	self:addTradeAcquire(RecipeDB,63765,1,25277,1,26907,1,26955,1,26991,1,28697,1,33586)

	-- High-powered Flashlight -- 63750
	AddRecipe(63750,250,45631,1,2,250,270,280,290)
	self:addTradeFlags(RecipeDB,63750,1,2,3,36,41,61)
	self:addTradeAcquire(RecipeDB,63750,1,25277,1,26907,1,26955,1,26991,1,28697,1,16667,1,1702,1,16726,1,11017,1,33586,1,3494,
	1,5174,1,3290,1,5518,1,33611,1,33634,1,1676,1,8736,1,17637,1,17634,1,11031,1,11025,1,11037,1,17222)

	-- Goblin Beam Welder -- 67326
	AddRecipe(67326,450,47828,1,2,415,415,420,425)
	self:addTradeFlags(RecipeDB,67326,1,2,3,37,41)
	self:addTradeAcquire(RecipeDB,67326,1,25277,1,28697,1,26955,1,33586)
	
	-- Jeeves -- 68067
	AddRecipe(68067,450,49050,1,2,450,480,485,490)
	self:addTradeFlags(RecipeDB,68067,1,2,10,37,41)
	self:addTradeAcquire(RecipeDB,68067,7,2)

	-- 67920 Northrend Port
	AddRecipe(67920,435,48933,1,2,435,450,455,460)
	self:addTradeFlags(RecipeDB,67920,1,2,3,37,41)
	self:addTradeAcquire(RecipeDB,67920,1,25277,1,28697,1,26955,1,33586)

	--Mind Amplification Dish -- 67839
	AddRecipe(67839,410,nil,1,2,410,410,415,420)
	self:addTradeFlags(RecipeDB,67839,1,2,3,37,41)
	self:addTradeAcquire(RecipeDB,67839,1,25277,1,28697,1,26955,1,33586)

	 -- Iceblade Arrow -- 72953
	 AddRecipe(72953, 450, 52021, F_EPIC, GAME_WOTLK, 450, 450, 450, 460, 20219)
	 self:addTradeFlags(RecipeDB,72953,F_ALLIANCE,F_HORDE,F_VENDOR,F_ASHEN_VERDICT)
	 self:addTradeAcquire(RecipeDB, 72953, A_REPUTATION, 1156, HONORED, 37687)
	 
	 -- Shatter Rounds -- 72952
	 AddRecipe(72952, 450, 52020, F_EPIC, GAME_WOTLK, 450, 450, 450, 460, 20222)
	 self:addTradeFlags(RecipeDB,72952,F_ALLIANCE,F_HORDE,F_VENDOR,F_ASHEN_VERDICT)
	 self:addTradeAcquire(RecipeDB, 72952, A_REPUTATION, 1156, HONORED, 37687)

	-- Some recipes are only availible to specific factions.
	-- We only add the faction specific recipes if the user is part of that faction
	local BFAC = LibStub("LibBabble-Faction-3.0"):GetLookupTable()
	local _,faction = UnitFactionGroup("player")

	if (faction == BFAC["Alliance"]) then

		-- Mekgineer's Chopper -- 60867
		AddRecipe(60867,450,44413,4,2,450,480,485,490)
		self:addTradeFlags(RecipeDB,60867,1,4,36,41,130)
		self:addTradeAcquire(RecipeDB,60867,6,1037,4,32564,6,1037,4,32773)

	elseif (faction == BFAC["Horde"]) then

		-- Mechano-hog -- 60866
		AddRecipe(60866,450,41508,4,2,450,480,485,490)
		self:addTradeFlags(RecipeDB,60866,2,4,36,41,130)
		self:addTradeAcquire(RecipeDB,60866,6,1052,4,32565,6,1052,4,32774)

	end

	return num_recipes

end
