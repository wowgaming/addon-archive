--[[
************************************************************************
Enchanting.lua
Enchanting data for all of Ackis Recipe List
************************************************************************
File date: 2009-12-30T10:16:20Z 
File revision: 2785 
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

function addon:InitEnchanting(RecipeDB)

	if initialized then
		return num_recipes
	end

	initialized = true

	--------------------------------------------------------------------------------------------------------------------
	-- Counter and wrapper function
	--------------------------------------------------------------------------------------------------------------------
	local function AddRecipe(SpellID, Skill, ItemID, Rarity, Game, Orange, Yellow, Green, Gray)
		num_recipes = num_recipes + 1
		self:addTradeSkill(RecipeDB, SpellID, Skill, ItemID, Rarity, 7411, nil, Game, Orange, Yellow, Green, Gray)
	end

	-- Enchant Bracer - Minor Health -- 7418
	AddRecipe(7418,1,nil,1,GAME_ORIG,1,70,90,110)
	self:addTradeFlags(RecipeDB,7418,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,7418,8,8)

	-- Enchant Chest - Minor Health -- 7420
	AddRecipe(7420,15,nil,1,GAME_ORIG,15,70,90,110)
	self:addTradeFlags(RecipeDB,7420,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,7420,1,1317,1,3011,1,3345,1,3606,1,4213,1,4616,1,5157,1,5695,
	1,11072,1,11073,1,11074,1,16160,1,16633,1,16725,1,19251,1,19252,1,33610,1,33676,1,18773,1,7949,1,19540,1,18753)

	-- Runed Copper Rod -- 7421
	AddRecipe(7421,1,6218,1,GAME_ORIG,1,5,7,10)
	self:addTradeFlags(RecipeDB,7421,1,2,3,37,41)
	self:addTradeAcquire(RecipeDB,7421,8,8)

	-- Enchant Chest - Minor Absorption -- 7426
	AddRecipe(7426,40,nil,1,GAME_ORIG,40,90,110,130)
	self:addTradeFlags(RecipeDB,7426,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,7426,1,1317,1,3011,1,3345,1,3606,1,4213,1,4616,1,5157,1,5695,
	1,11072,1,11073,1,11074,1,16160,1,16633,1,16725,1,19251,1,19252,1,33610,1,33676,1,18773,1,7949,1,19540,1,18753)

	-- Enchant Bracer - Minor Deflection -- 7428
	AddRecipe(7428,1,nil,1,GAME_ORIG,1,80,100,120)
	self:addTradeFlags(RecipeDB,7428,1,2,3,36,41,52)
	self:addTradeAcquire(RecipeDB,7428,8,8)

	-- Enchant Chest - Minor Mana -- 7443
	AddRecipe(7443,20,nil,1,GAME_ORIG,20,80,100,120)
	self:addTradeFlags(RecipeDB,7443,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,7443,7,1)

	-- Enchant Cloak - Minor Resistance -- 7454
	AddRecipe(7454,45,nil,1,GAME_ORIG,45,95,115,135)
	self:addTradeFlags(RecipeDB,7454,1,2,3,36,40,60)
	self:addTradeAcquire(RecipeDB,7454,1,1317,1,3011,1,3345,1,3606,1,4213,1,4616,1,5157,1,5695,
	1,11072,1,11073,1,11074,1,16160,1,16633,1,16725,1,19251,1,19252,1,33610,1,33676,1,18773,1,7949,1,19540,1,18753)

	-- Enchant Bracer - Minor Stamina -- 7457
	AddRecipe(7457,50,nil,1,GAME_ORIG,50,100,120,140)
	self:addTradeFlags(RecipeDB,7457,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,7457,1,1317,1,3011,1,3345,1,3606,1,4213,1,4616,1,5157,1,5695,
	1,11072,1,11073,1,11074,1,16160,1,16633,1,16725,1,19251,1,19252,1,33610,1,33676,1,18773,1,7949,1,19540,1,18753)

	-- Enchant 2H Weapon - Minor Impact -- 7745
	AddRecipe(7745,100,nil,1,GAME_ORIG,100,130,150,170)
	self:addTradeFlags(RecipeDB,7745,1,2,3,36,40,67)
	self:addTradeAcquire(RecipeDB,7745,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,11072,1,11073,1,11074,1,16633,1,16725,
	1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,5695,1,7949,1,19540,1,18753,1,16160)

	-- Enchant Chest - Lesser Health -- 7748
	AddRecipe(7748,60,nil,1,GAME_ORIG,60,105,125,145)
	self:addTradeFlags(RecipeDB,7748,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,7748,1,1317,1,3011,1,3345,1,3606,1,4213,1,4616,1,5157,1,5695,
	1,11072,1,11073,1,11074,1,16160,1,16633,1,16725,1,19251,1,19252,1,33610,1,33676,1,18773,1,7949,1,19540,1,18753)

	-- Enchant Bracer - Minor Spirit -- 7766
	AddRecipe(7766,60,nil,1,GAME_ORIG,60,105,125,145)
	self:addTradeFlags(RecipeDB,7766,1,2,10,36,40,53,54)
	self:addTradeAcquire(RecipeDB,7766,7,1)

	-- Enchant Cloak - Minor Protection -- 7771
	AddRecipe(7771,70,nil,1,GAME_ORIG,70,110,130,150)
	self:addTradeFlags(RecipeDB,7771,1,2,3,36,40,60)
	self:addTradeAcquire(RecipeDB,7771,1,1317,1,3011,1,3345,1,3606,1,4213,1,4616,1,5157,1,5695,
	1,11072,1,11073,1,11074,1,16160,1,16633,1,16725,1,19251,1,19252,1,33610,1,33676,1,18773,1,7949,1,19540,1,18753)

	-- Enchant Chest - Lesser Mana -- 7776
	AddRecipe(7776,80,nil,1,GAME_ORIG,80,115,135,155)
	self:addTradeFlags(RecipeDB,7776,2,4,36,40)
	self:addTradeAcquire(RecipeDB,7776,2,3346,2,5757)

	-- Enchant Bracer - Minor Agility -- 7779
	AddRecipe(7779,80,nil,1,GAME_ORIG,80,115,135,155)
	self:addTradeFlags(RecipeDB,7779,1,2,3,36,40,51)
	self:addTradeAcquire(RecipeDB,7779,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,11072,1,11073,1,11074,1,16633,1,16725,1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,5695,1,7949,1,19540,1,18753,1,16160)

	-- Enchant Bracer - Minor Strength -- 7782
	AddRecipe(7782,80,nil,1,GAME_ORIG,80,115,135,155)
	self:addTradeFlags(RecipeDB,7782,1,2,10,36,40,51)
	self:addTradeAcquire(RecipeDB,7782,7,1)

	-- Enchant Weapon - Minor Beastslayer -- 7786
	AddRecipe(7786,90,nil,1,GAME_ORIG,90,120,140,160)
	self:addTradeFlags(RecipeDB,7786,1,2,10,36,40,66,67)
	self:addTradeAcquire(RecipeDB,7786,7,1)

	-- Enchant Weapon - Minor Striking -- 7788
	AddRecipe(7788,90,nil,1,GAME_ORIG,90,120,140,160)
	self:addTradeFlags(RecipeDB,7788,1,2,3,36,40,66,67)
	self:addTradeAcquire(RecipeDB,7788,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,11072,1,11073,1,11074,1,16633,1,16725,1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,5695,1,7949,1,19540,1,18753,1,16160)

	-- Enchant 2H Weapon - Lesser Intellect -- 7793
	AddRecipe(7793,100,nil,1,GAME_ORIG,100,130,150,170)
	self:addTradeFlags(RecipeDB,7793,1,2,4,36,40,67)
	self:addTradeAcquire(RecipeDB,7793,2,3012,2,3346,2,5158,2,5758)

	-- Runed Silver Rod -- 7795
	AddRecipe(7795,100,6339,1,GAME_ORIG,100,130,150,170)
	self:addTradeFlags(RecipeDB,7795,1,2,3,37,41)
	self:addTradeAcquire(RecipeDB,7795,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,11072,1,11073,1,11074,1,16633,1,16725,1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,5695,1,7949,1,19540,1,18753,1,16160)

	-- Enchant Chest - Health -- 7857
	AddRecipe(7857,120,nil,1,GAME_ORIG,120,145,165,185)
	self:addTradeFlags(RecipeDB,7857,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,7857,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,7949,1,11072,1,11073,1,11074,1,16633,1,16725,1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,5695,1,19540,1,18753,1,16160)

	-- Enchant Bracer - Lesser Spirit -- 7859
	AddRecipe(7859,120,nil,1,GAME_ORIG,120,145,165,185)
	self:addTradeFlags(RecipeDB,7859,1,2,10,36,40,53,54)
	self:addTradeAcquire(RecipeDB,7859,7,1)

	-- Enchant Cloak - Lesser Fire Resistance -- 7861
	AddRecipe(7861,125,nil,1,GAME_ORIG,125,150,170,190)
	self:addTradeFlags(RecipeDB,7861,1,2,3,36,40,60)
	self:addTradeAcquire(RecipeDB,7861,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,7949,1,11072,1,11073,1,11074,1,16633,1,16725,1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,5695,1,19540,1,18753,1,16160)

	-- Enchant Boots - Minor Stamina -- 7863
	AddRecipe(7863,125,nil,1,GAME_ORIG,125,150,170,190)
	self:addTradeFlags(RecipeDB,7863,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,7863,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,7949,1,11072,1,11073,1,11074,1,16633,1,16725,1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,5695,1,19540,1,18753,1,16160)

	-- Enchant Boots - Minor Agility -- 7867
	AddRecipe(7867,125,nil,1,GAME_ORIG,125,150,170,190)
	self:addTradeFlags(RecipeDB,7867,1,2,4,36,40,51)
	self:addTradeAcquire(RecipeDB,7867,2,3012,2,3537)

	-- Enchant Shield - Minor Stamina -- 13378
	AddRecipe(13378,105,nil,1,GAME_ORIG,105,130,150,170)
	self:addTradeFlags(RecipeDB,13378,1,2,3,36,40,64)
	self:addTradeAcquire(RecipeDB,13378,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,7949,1,11072,1,11073,1,11074,1,16633,1,16725,1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,19540,1,18753,1,16160)

	-- Enchant 2H Weapon - Lesser Spirit -- 13380
	AddRecipe(13380,110,nil,1,GAME_ORIG,110,135,155,175)
	self:addTradeFlags(RecipeDB,13380,1,2,10,36,40,53,54,67)
	self:addTradeAcquire(RecipeDB,13380,7,1)

	-- Enchant Cloak - Minor Agility -- 13419
	AddRecipe(13419,110,nil,1,GAME_ORIG,110,135,155,175)
	self:addTradeFlags(RecipeDB,13419,1,2,4,10,36,40,51,60)
	self:addTradeAcquire(RecipeDB,13419,7,1,2,3954,2,12043)

	-- Enchant Cloak - Lesser Protection -- 13421
	AddRecipe(13421,115,nil,1,GAME_ORIG,115,140,160,180)
	self:addTradeFlags(RecipeDB,13421,1,2,3,36,40,60)
	self:addTradeAcquire(RecipeDB,13421,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,7949,1,11072,1,11073,1,11074,1,16633,1,16725,1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,5695,1,19540,1,18753,1,16160)

	-- Enchant Shield - Lesser Protection -- 13464
	AddRecipe(13464,115,nil,1,GAME_ORIG,115,140,160,180)
	self:addTradeFlags(RecipeDB,13464,1,2,10,36,40,64)
	self:addTradeAcquire(RecipeDB,13464,7,1)

	-- Enchant Shield - Lesser Spirit -- 13485
	AddRecipe(13485,130,nil,1,GAME_ORIG,130,155,175,195)
	self:addTradeFlags(RecipeDB,13485,1,2,3,36,40,53,54,64)
	self:addTradeAcquire(RecipeDB,13485,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,7949,1,11072,1,11073,1,11074,1,16633,1,16725,1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,5695,1,19540,1,18753,1,16160)

	-- Enchant Bracer - Lesser Stamina -- 13501
	AddRecipe(13501,130,nil,1,GAME_ORIG,130,155,175,195)
	self:addTradeFlags(RecipeDB,13501,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,13501,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,7949,1,11072,1,11073,1,11074,1,16633,1,16725,1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,5695,1,19540,1,18753,1,16160)

	-- Enchant Weapon - Lesser Striking -- 13503
	AddRecipe(13503,140,nil,1,GAME_ORIG,140,165,185,205)
	self:addTradeFlags(RecipeDB,13503,1,2,3,36,40,66,67)
	self:addTradeAcquire(RecipeDB,13503,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,7949,1,11072,1,11073,1,11074,1,16633,1,16725,1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,5695,1,19540,1,18753,1,16160)

	-- Enchant Cloak - Lesser Shadow Resistance -- 13522
	AddRecipe(13522,135,nil,1,GAME_ORIG,135,160,180,200)
	self:addTradeFlags(RecipeDB,13522,1,2,10,36,40,60)
	self:addTradeAcquire(RecipeDB,13522,7,1)

	-- Enchant 2H Weapon - Lesser Impact -- 13529
	AddRecipe(13529,145,nil,1,GAME_ORIG,145,170,190,210)
	self:addTradeFlags(RecipeDB,13529,1,2,3,36,40,67)
	self:addTradeAcquire(RecipeDB,13529,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,7949,1,11072,1,11073,1,11074,1,16633,1,16725,1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,5695,1,19540,1,18753,1,16160)

	-- Enchant Bracer - Lesser Strength -- 13536
	AddRecipe(13536,140,nil,1,GAME_ORIG,140,165,185,205)
	self:addTradeFlags(RecipeDB,13536,1,2,4,36,40,51)
	self:addTradeAcquire(RecipeDB,13536,2,3954,2,12043)

	-- Enchant Chest - Lesser Absorption -- 13538
	AddRecipe(13538,140,nil,1,GAME_ORIG,140,165,185,205)
	self:addTradeFlags(RecipeDB,13538,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,13538,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,7949,1,11072,1,11073,1,11074,1,16633,1,16725,1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,5695,1,19540,1,18753,1,16160)

	-- Enchant Chest - Mana -- 13607
	AddRecipe(13607,145,nil,1,GAME_ORIG,145,170,190,210)
	self:addTradeFlags(RecipeDB,13607,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,13607,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,7949,1,11072,1,11073,1,11074,1,16633,1,16725,1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,5695,1,19540,1,18753,1,16160)

	-- Enchant Gloves - Mining -- 13612
	AddRecipe(13612,145,nil,1,GAME_ORIG,145,170,190,210)
	self:addTradeFlags(RecipeDB,13612,1,2,11,36,40)
	self:addTradeAcquire(RecipeDB,13612,3,1054,3,1051,3,1052,3,1053,3,1364)

	-- Enchant Gloves - Herbalism -- 13617
	AddRecipe(13617,145,nil,1,GAME_ORIG,145,170,190,210)
	self:addTradeFlags(RecipeDB,13617,1,2,11,36,40)
	self:addTradeAcquire(RecipeDB,13617,3,4030,3,4029,3,3834,3,3919,3,4028)

	-- Enchant Gloves - Fishing -- 13620
	AddRecipe(13620,145,nil,1,GAME_ORIG,145,170,190,210)
	self:addTradeFlags(RecipeDB,13620,1,2,11,36,40)
	self:addTradeAcquire(RecipeDB,13620,3,2375,3,2377,3,2376,3,2374,3,14276)

	-- Enchant Bracer - Lesser Intellect -- 13622
	AddRecipe(13622,150,nil,1,GAME_ORIG,150,175,195,215)
	self:addTradeFlags(RecipeDB,13622,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,13622,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,7949,1,11072,1,11073,1,11074,1,16633,1,16725,1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,5695,1,19540,1,18753,1,16160)

	-- Enchant Chest - Minor Stats -- 13626
	AddRecipe(13626,150,nil,1,GAME_ORIG,150,175,195,215)
	self:addTradeFlags(RecipeDB,13626,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,13626,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,7949,1,11072,1,11073,1,11074,1,16633,1,16725,1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,5695,1,19540,1,18753,1,16160)

	-- Runed Golden Rod -- 13628
	AddRecipe(13628,150,11130,1,GAME_ORIG,150,175,195,215)
	self:addTradeFlags(RecipeDB,13628,1,2,3,37,41)
	self:addTradeAcquire(RecipeDB,13628,1,1317,1,3011,1,3345,1,4213,1,4616,1,5157,1,7949,1,11072,1,11073,1,11074,1,16633,1,16725,1,19251,1,19252,1,33610,1,3606,1,33676,1,18773,1,5695,1,19540,1,18753,1,16160)

	-- Enchant Shield - Lesser Stamina -- 13631
	AddRecipe(13631,155,nil,1,GAME_ORIG,155,175,195,215)
	self:addTradeFlags(RecipeDB,13631,1,2,3,36,40,64)
	self:addTradeAcquire(RecipeDB,13631,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Cloak - Defense -- 13635
	AddRecipe(13635,155,nil,1,GAME_ORIG,155,175,195,215)
	self:addTradeFlags(RecipeDB,13635,1,2,3,36,40,52,60)
	self:addTradeAcquire(RecipeDB,13635,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Boots - Lesser Agility -- 13637
	AddRecipe(13637,160,nil,1,GAME_ORIG,160,180,200,220)
	self:addTradeFlags(RecipeDB,13637,1,2,3,36,40,51)
	self:addTradeAcquire(RecipeDB,13637,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Chest - Greater Health -- 13640
	AddRecipe(13640,160,nil,1,GAME_ORIG,160,180,200,220)
	self:addTradeFlags(RecipeDB,13640,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,13640,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Bracer - Spirit -- 13642
	AddRecipe(13642,165,nil,1,GAME_ORIG,165,185,205,225)
	self:addTradeFlags(RecipeDB,13642,1,2,3,36,40,53,54)
	self:addTradeAcquire(RecipeDB,13642,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Boots - Lesser Stamina -- 13644
	AddRecipe(13644,170,nil,1,GAME_ORIG,170,190,210,230)
	self:addTradeFlags(RecipeDB,13644,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,13644,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Bracer - Lesser Deflection -- 13646
	AddRecipe(13646,170,nil,1,GAME_ORIG,170,190,210,230)
	self:addTradeFlags(RecipeDB,13646,1,2,4,36,40,52)
	self:addTradeAcquire(RecipeDB,13646,2,2381,2,2821)

	-- Enchant Bracer - Stamina -- 13648
	AddRecipe(13648,170,nil,1,GAME_ORIG,170,190,210,230)
	self:addTradeFlags(RecipeDB,13648,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,13648,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Weapon - Lesser Beastslayer -- 13653
	AddRecipe(13653,175,nil,1,GAME_ORIG,175,195,215,235)
	self:addTradeFlags(RecipeDB,13653,1,2,10,36,40,66,67)
	self:addTradeAcquire(RecipeDB,13653,7,1)

	-- Enchant Weapon - Lesser Elemental Slayer -- 13655
	AddRecipe(13655,175,nil,1,GAME_ORIG,175,195,215,235)
	self:addTradeFlags(RecipeDB,13655,1,2,10,36,40,66,67)
	self:addTradeAcquire(RecipeDB,13655,7,1)

	-- Enchant Cloak - Fire Resistance -- 13657
	AddRecipe(13657,175,nil,1,GAME_ORIG,175,195,215,235)
	self:addTradeFlags(RecipeDB,13657,1,2,3,36,40,60)
	self:addTradeAcquire(RecipeDB,13657,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Shield - Spirit -- 13659
	AddRecipe(13659,180,nil,1,GAME_ORIG,180,200,220,240)
	self:addTradeFlags(RecipeDB,13659,1,2,3,36,40,53,54,64)
	self:addTradeAcquire(RecipeDB,13659,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Bracer - Strength -- 13661
	AddRecipe(13661,180,nil,1,GAME_ORIG,180,200,220,240)
	self:addTradeFlags(RecipeDB,13661,1,2,3,36,40,51)
	self:addTradeAcquire(RecipeDB,13661,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Chest - Greater Mana -- 13663
	AddRecipe(13663,185,nil,1,GAME_ORIG,185,205,225,245)
	self:addTradeFlags(RecipeDB,13663,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,13663,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Boots - Lesser Spirit -- 13687
	AddRecipe(13687,190,nil,1,GAME_ORIG,190,210,230,250)
	self:addTradeFlags(RecipeDB,13687,1,2,10,36,40,53,54)
	self:addTradeAcquire(RecipeDB,13687,7,1)

	-- Enchant Shield - Lesser Block -- 13689
	AddRecipe(13689,195,nil,1,GAME_ORIG,195,215,235,255)
	self:addTradeFlags(RecipeDB,13689,1,2,5,10,36,40,52,64)
	self:addTradeAcquire(RecipeDB,13689,7,2)

	-- Enchant Weapon - Striking -- 13693
	AddRecipe(13693,195,nil,1,GAME_ORIG,195,215,235,255)
	self:addTradeFlags(RecipeDB,13693,1,2,3,36,40,66,67)
	self:addTradeAcquire(RecipeDB,13693,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant 2H Weapon - Impact -- 13695
	AddRecipe(13695,200,nil,1,GAME_ORIG,200,220,240,260)
	self:addTradeFlags(RecipeDB,13695,1,2,3,36,40,67)
	self:addTradeAcquire(RecipeDB,13695,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Gloves - Skinning -- 13698
	AddRecipe(13698,200,nil,1,GAME_ORIG,195,215,235,255)
	self:addTradeFlags(RecipeDB,13698,1,2,11,36,40)
	self:addTradeAcquire(RecipeDB,13698,3,2556,3,2557,3,2558,3,2606)

	-- Enchant Chest - Lesser Stats -- 13700
	AddRecipe(13700,200,nil,1,GAME_ORIG,200,220,240,260)
	self:addTradeFlags(RecipeDB,13700,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,13700,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Runed Truesilver Rod -- 13702
	AddRecipe(13702,200,11145,1,GAME_ORIG,200,220,240,260)
	self:addTradeFlags(RecipeDB,13702,1,2,3,37,41)
	self:addTradeAcquire(RecipeDB,13702,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Cloak - Greater Defense -- 13746
	AddRecipe(13746,205,nil,1,GAME_ORIG,205,225,245,265)
	self:addTradeFlags(RecipeDB,13746,1,2,3,36,40,52,60)
	self:addTradeAcquire(RecipeDB,13746,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Cloak - Resistance -- 13794
	AddRecipe(13794,205,nil,1,GAME_ORIG,205,225,245,265)
	self:addTradeFlags(RecipeDB,13794,1,2,3,36,40,60)
	self:addTradeAcquire(RecipeDB,13794,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Gloves - Agility -- 13815
	AddRecipe(13815,210,nil,1,GAME_ORIG,210,230,250,270)
	self:addTradeFlags(RecipeDB,13815,1,2,3,36,40,51)
	self:addTradeAcquire(RecipeDB,13815,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Shield - Stamina -- 13817
	AddRecipe(13817,210,nil,1,GAME_ORIG,210,230,250,270)
	self:addTradeFlags(RecipeDB,13817,1,2,10,36,40,64)
	self:addTradeAcquire(RecipeDB,13817,7,1)

	-- Enchant Bracer - Intellect -- 13822
	AddRecipe(13822,210,nil,1,GAME_ORIG,210,230,250,270)
	self:addTradeFlags(RecipeDB,13822,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,13822,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Boots - Stamina -- 13836
	AddRecipe(13836,215,nil,1,GAME_ORIG,215,235,255,275)
	self:addTradeFlags(RecipeDB,13836,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,13836,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Gloves - Advanced Mining -- 13841
	AddRecipe(13841,215,nil,1,GAME_ORIG,215,235,255,275)
	self:addTradeFlags(RecipeDB,13841,1,2,11,36,40)
	self:addTradeAcquire(RecipeDB,13841,3,674)

	-- Enchant Bracer - Greater Spirit -- 13846
	AddRecipe(13846,220,nil,1,GAME_ORIG,220,240,260,280)
	self:addTradeFlags(RecipeDB,13846,1,2,10,36,40,53,54)
	self:addTradeAcquire(RecipeDB,13846,7,1)

	-- Enchant Chest - Superior Health -- 13858
	AddRecipe(13858,220,nil,1,GAME_ORIG,220,240,260,280)
	self:addTradeFlags(RecipeDB,13858,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,13858,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Gloves - Advanced Herbalism -- 13868
	AddRecipe(13868,225,nil,1,GAME_ORIG,225,245,265,285)
	self:addTradeFlags(RecipeDB,13868,1,2,11,36,40)
	self:addTradeAcquire(RecipeDB,13868,3,764,3,765,3,766,3,1081,3,14448)

	-- Enchant Cloak - Lesser Agility -- 13882
	AddRecipe(13882,225,nil,1,GAME_ORIG,225,245,265,285)
	self:addTradeFlags(RecipeDB,13882,1,2,11,36,40,51,60)
	self:addTradeAcquire(RecipeDB,13882,3,2246,3,5623,3,7805)

	-- Enchant Gloves - Strength -- 13887
	AddRecipe(13887,225,nil,1,GAME_ORIG,225,245,265,285)
	self:addTradeFlags(RecipeDB,13887,1,2,3,36,40,51)
	self:addTradeAcquire(RecipeDB,13887,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Boots - Minor Speed -- 13890
	AddRecipe(13890,225,nil,1,GAME_ORIG,225,245,265,285)
	self:addTradeFlags(RecipeDB,13890,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,13890,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Weapon - Fiery Weapon -- 13898
	AddRecipe(13898,265,nil,1,GAME_ORIG,265,285,305,325)
	self:addTradeFlags(RecipeDB,13898,1,2,5,36,40,66,67)
	self:addTradeAcquire(RecipeDB,13898,3,9024)

	-- Enchant Shield - Greater Spirit -- 13905
	AddRecipe(13905,230,nil,1,GAME_ORIG,230,250,270,290)
	self:addTradeFlags(RecipeDB,13905,1,2,3,36,40,53,54,64)
	self:addTradeAcquire(RecipeDB,13905,1,11073,1,19251,1,19252,1,33610,1,16633,1,11072,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,11074,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Weapon - Demonslaying -- 13915
	AddRecipe(13915,230,nil,1,GAME_ORIG,230,250,270,290)
	self:addTradeFlags(RecipeDB,13915,1,2,10,36,40,66,67)
	self:addTradeAcquire(RecipeDB,13915,7,1)

	-- Enchant Chest - Superior Mana -- 13917
	AddRecipe(13917,230,nil,1,GAME_ORIG,230,250,270,290)
	self:addTradeFlags(RecipeDB,13917,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,13917,1,11073,1,19251,1,19252,1,33610,1,16633,1,11072,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,11074,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Bracer - Deflection -- 13931
	AddRecipe(13931,235,nil,1,GAME_ORIG,235,255,275,295)
	self:addTradeFlags(RecipeDB,13931,1,2,4,36,40,52)
	self:addTradeAcquire(RecipeDB,13931,2,989,2,4229)

	-- Enchant Shield - Frost Resistance -- 13933
	AddRecipe(13933,235,nil,1,GAME_ORIG,235,255,275,295)
	self:addTradeFlags(RecipeDB,13933,1,2,5,6,11,36,40,64)
	self:addTradeAcquire(RecipeDB,13933,7,2,8,33)

	-- Enchant Boots - Agility -- 13935
	AddRecipe(13935,235,nil,1,GAME_ORIG,235,255,275,295)
	self:addTradeFlags(RecipeDB,13935,1,2,3,36,40,51)
	self:addTradeAcquire(RecipeDB,13935,1,11073,1,19251,1,19252,1,33610,1,16633,1,11072,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,11074,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant 2H Weapon - Greater Impact -- 13937
	AddRecipe(13937,240,nil,1,GAME_ORIG,240,260,280,300)
	self:addTradeFlags(RecipeDB,13937,1,2,3,36,40,67)
	self:addTradeAcquire(RecipeDB,13937,1,1317,1,3011,1,3345,1,3606,1,4213,1,4616,1,5157,1,5695,
	1,11072,1,11073,1,11074,1,16160,1,16633,1,16725,1,19251,1,19252,1,33610,1,33676,1,18773,1,7949,1,19540,1,18753)

	-- Enchant Bracer - Greater Strength -- 13939
	AddRecipe(13939,240,nil,1,GAME_ORIG,240,260,280,300)
	self:addTradeFlags(RecipeDB,13939,1,2,3,36,40,51)
	self:addTradeAcquire(RecipeDB,13939,1,11073,1,19251,1,19252,1,33610,1,16633,1,11072,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,11074,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Chest - Stats -- 13941
	AddRecipe(13941,245,nil,1,GAME_ORIG,245,265,285,305)
	self:addTradeFlags(RecipeDB,13941,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,13941,1,11073,1,19251,1,19252,1,33610,1,16633,1,11072,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,11074,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Weapon - Greater Striking -- 13943
	AddRecipe(13943,245,nil,1,GAME_ORIG,245,265,285,305)
	self:addTradeFlags(RecipeDB,13943,1,2,3,36,40,66,67)
	self:addTradeAcquire(RecipeDB,13943,1,11073,1,19251,1,19252,1,33610,1,16633,1,11072,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,11074,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Bracer - Greater Stamina -- 13945
	AddRecipe(13945,245,nil,1,GAME_ORIG,245,265,285,305)
	self:addTradeFlags(RecipeDB,13945,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,13945,7,1)

	-- Enchant Gloves - Riding Skill -- 13947
	AddRecipe(13947,250,nil,1,GAME_ORIG,250,270,290,310)
	self:addTradeFlags(RecipeDB,13947,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,13947,7,2)

	-- Enchant Gloves - Minor Haste -- 13948
	AddRecipe(13948,250,nil,1,GAME_ORIG,250,270,290,310)
	self:addTradeFlags(RecipeDB,13948,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,13948,1,11073,1,19251,1,19252,1,33610,1,16633,1,11072,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,11074,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Lesser Magic Wand -- 14293
	AddRecipe(14293,10,11287,1,GAME_ORIG,10,75,95,115)
	self:addTradeFlags(RecipeDB,14293,1,2,3,36,41,74)
	self:addTradeAcquire(RecipeDB,14293,1,1317,1,3011,1,3345,1,3606,1,4213,1,4616,1,5157,1,5695,
	1,11072,1,11073,1,11074,1,16160,1,16633,1,16725,1,19251,1,19252,1,33610,1,33676,1,18773,1,7949,1,19540,1,18753)

	-- Greater Magic Wand -- 14807
	AddRecipe(14807,70,11288,1,GAME_ORIG,70,110,130,150)
	self:addTradeFlags(RecipeDB,14807,1,2,3,36,41,74)
	self:addTradeAcquire(RecipeDB,14807,1,1317,1,3011,1,3345,1,3606,1,4213,1,4616,1,5157,1,5695,
	1,11072,1,11073,1,11074,1,16160,1,16633,1,16725,1,19251,1,19252,1,33610,1,33676,1,18773,1,7949,1,19540,1,18753)

	-- Lesser Mystic Wand -- 14809
	AddRecipe(14809,155,11289,1,GAME_ORIG,155,175,195,215)
	self:addTradeFlags(RecipeDB,14809,1,2,3,36,41,74)
	self:addTradeAcquire(RecipeDB,14809,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Greater Mystic Wand -- 14810
	AddRecipe(14810,175,11290,1,GAME_ORIG,175,195,215,235)
	self:addTradeFlags(RecipeDB,14810,1,2,3,36,41,74)
	self:addTradeAcquire(RecipeDB,14810,1,11072,1,11073,1,11074,1,19251,1,19252,1,33610,1,16633,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchanted Thorium -- 17180
	AddRecipe(17180,250,12655,1,GAME_ORIG,250,250,255,260)
	self:addTradeFlags(RecipeDB,17180,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,17180,1,11073,1,19251,1,19252,1,33610,1,16633,1,11072,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,11074,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchanted Leather -- 17181
	AddRecipe(17181,250,12810,1,GAME_ORIG,250,250,255,260)
	self:addTradeFlags(RecipeDB,17181,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,17181,1,11073,1,19251,1,19252,1,33610,1,16633,1,11072,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,11074,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Bracer - Greater Intellect -- 20008
	AddRecipe(20008,255,nil,1,GAME_ORIG,255,275,295,315)
	self:addTradeFlags(RecipeDB,20008,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,20008,1,11073,1,19251,1,19252,1,33610,1,16633,1,11072,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,11074,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Bracer - Superior Spirit -- 20009
	AddRecipe(20009,270,nil,1,GAME_ORIG,270,290,310,330)
	self:addTradeFlags(RecipeDB,20009,1,2,10,36,40,53,54)
	self:addTradeAcquire(RecipeDB,20009,7,1)

	-- Enchant Bracer - Superior Strength -- 20010
	AddRecipe(20010,295,nil,1,GAME_ORIG,295,310,325,340)
	self:addTradeFlags(RecipeDB,20010,1,2,11,36,40,51)
	self:addTradeAcquire(RecipeDB,20010,3,7372)

	-- Enchant Bracer - Superior Stamina -- 20011
	AddRecipe(20011,300,nil,1,GAME_ORIG,300,310,325,340)
	self:addTradeFlags(RecipeDB,20011,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,20011,7,1)

	-- Enchant Gloves - Greater Agility -- 20012
	AddRecipe(20012,270,nil,1,GAME_ORIG,270,290,310,330)
	self:addTradeFlags(RecipeDB,20012,1,2,3,36,40,51)
	self:addTradeAcquire(RecipeDB,20012,1,11073,1,19251,1,19252,1,33610,1,16633,1,11072,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,11074,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Gloves - Greater Strength -- 20013
	AddRecipe(20013,295,nil,1,GAME_ORIG,295,310,325,340)
	self:addTradeFlags(RecipeDB,20013,1,2,3,36,40,51)
	self:addTradeAcquire(RecipeDB,20013,1,11073,1,19251,1,19252,1,33610,1,16633,1,11072,1,1317,1,4213,1,16725,1,3345,1,3011,1,3606,1,11074,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Cloak - Greater Resistance -- 20014
	AddRecipe(20014,265,nil,1,GAME_ORIG,265,285,305,325)
	self:addTradeFlags(RecipeDB,20014,1,2,3,36,40,60)
	self:addTradeAcquire(RecipeDB,20014,1,11073,1,19251,1,19252,1,33610,1,16633,1,11072,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,11074,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Cloak - Superior Defense -- 20015
	AddRecipe(20015,285,nil,1,GAME_ORIG,285,300,317,335)
	self:addTradeFlags(RecipeDB,20015,1,2,4,36,41,52,60)
	self:addTradeAcquire(RecipeDB,20015,2,12022)

	-- Enchant Shield - Vitality -- 20016
	AddRecipe(20016,280,nil,1,GAME_ORIG,280,300,320,340)
	self:addTradeFlags(RecipeDB,20016,1,2,3,36,40,53,54,64)
	self:addTradeAcquire(RecipeDB,20016,1,11073,1,19251,1,19252,1,33610,1,16633,1,11072,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,11074,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Shield - Greater Stamina -- 20017
	AddRecipe(20017,265,nil,1,GAME_ORIG,265,285,305,325)
	self:addTradeFlags(RecipeDB,20017,1,2,4,36,41,64)
	self:addTradeAcquire(RecipeDB,20017,2,4229,2,4561)

	-- Enchant Boots - Greater Stamina -- 20020
	AddRecipe(20020,260,nil,1,GAME_ORIG,260,280,300,320)
	self:addTradeFlags(RecipeDB,20020,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,20020,7,1)

	-- Enchant Boots - Greater Agility -- 20023
	AddRecipe(20023,295,nil,1,GAME_ORIG,295,310,325,340)
	self:addTradeFlags(RecipeDB,20023,1,2,3,11,36,40,51)
	self:addTradeAcquire(RecipeDB,20023,1,11073,1,19251,1,19252,1,33610,1,16633,1,11072,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,11074,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Boots - Spirit -- 20024
	AddRecipe(20024,275,nil,1,0,275,295,315,335)
	self:addTradeFlags(RecipeDB,20024,1,2,10,36,40,53,54)
	self:addTradeAcquire(RecipeDB,20024,7,1)

	-- Enchant Chest - Greater Stats -- 20025
	AddRecipe(20025,300,nil,1,0,300,310,325,340)
	self:addTradeFlags(RecipeDB,20025,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,20025,7,1)

	-- Enchant Chest - Major Health -- 20026
	AddRecipe(20026,275,nil,1,0,275,295,315,335)
	self:addTradeFlags(RecipeDB,20026,1,2,4,36,41)
	self:addTradeAcquire(RecipeDB,20026,2,11189)

	-- Enchant Chest - Major Mana -- 20028
	AddRecipe(20028,290,nil,1,GAME_ORIG,290,305,322,340)
	self:addTradeFlags(RecipeDB,20028,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,20028,1,11073,1,19251,1,19252,1,33610,1,16633,1,11072,1,1317,1,3606,1,4213,1,16725,1,3345,1,3011,1,11074,1,33676,1,18773,1,5695,1,4616,1,7949,1,5157,1,19540,1,18753,1,16160)

	-- Enchant Weapon - Icy Chill -- 20029
	AddRecipe(20029,285,nil,1,GAME_ORIG,285,300,317,335)
	self:addTradeFlags(RecipeDB,20029,1,2,11,36,40,66,67)
	self:addTradeAcquire(RecipeDB,20029,3,7524)

	-- Enchant 2H Weapon - Superior Impact -- 20030
	AddRecipe(20030,295,nil,1,GAME_ORIG,295,310,325,340)
	self:addTradeFlags(RecipeDB,20030,1,2,5,36,40,67)
	self:addTradeAcquire(RecipeDB,20030,3,10317)

	-- Enchant Weapon - Superior Striking -- 20031
	AddRecipe(20031,300,nil,1,GAME_ORIG,300,310,325,340)
	self:addTradeFlags(RecipeDB,20031,1,2,5,36,40,66,67)
	self:addTradeAcquire(RecipeDB,20031,3,9216)

	-- Enchant Weapon - Lifestealing -- 20032
	AddRecipe(20032,300,nil,1,GAME_ORIG,300,310,325,340)
	self:addTradeFlags(RecipeDB,20032,1,2,5,36,40,66,67)
	self:addTradeAcquire(RecipeDB,20032,3,10499)

	-- Enchant Weapon - Unholy Weapon -- 20033
	AddRecipe(20033,295,nil,1,GAME_ORIG,295,310,325,340)
	self:addTradeFlags(RecipeDB,20033,1,2,5,11,36,40,66,67)
	self:addTradeAcquire(RecipeDB,20033,3,10398,3,16810)

	-- Enchant Weapon - Crusader -- 20034
	AddRecipe(20034,300,nil,1,GAME_ORIG,300,310,325,340)
	self:addTradeFlags(RecipeDB,20034,1,2,11,36,40,51,66,67)
	self:addTradeAcquire(RecipeDB,20034,3,4494,3,9451)

	-- Enchant 2H Weapon - Major Spirit -- 20035
	AddRecipe(20035,300,nil,1,GAME_ORIG,300,310,325,340)
	self:addTradeFlags(RecipeDB,20035,1,2,5,36,40,53,54,67)
	self:addTradeAcquire(RecipeDB,20035,3,10469)

	-- Enchant 2H Weapon - Major Intellect -- 20036
	AddRecipe(20036,300,nil,1,GAME_ORIG,300,310,325,340)
	self:addTradeFlags(RecipeDB,20036,1,2,5,36,40,67)
	self:addTradeAcquire(RecipeDB,20036,3,10422)

	-- Runed Arcanite Rod -- 20051
	AddRecipe(20051,290,16207,1,GAME_ORIG,290,305,322,340)
	self:addTradeFlags(RecipeDB,20051,1,2,4,37,41)
	self:addTradeAcquire(RecipeDB,20051,2,12022)

	-- Enchant Weapon - Winter's Might -- 21931
	AddRecipe(21931,190,nil,1,GAME_ORIG,190,210,230,250)
	self:addTradeFlags(RecipeDB,21931,1,2,7,11,36,40,53,54,66,67)
	self:addTradeAcquire(RecipeDB,21931,5,1)

	-- Enchant Weapon - Spellpower -- 22749
	AddRecipe(22749,300,nil,1,GAME_ORIG,300,310,325,340)
	self:addTradeFlags(RecipeDB,22749,1,2,6,36,40,53,54,66,67)
	self:addTradeAcquire(RecipeDB,22749,8,26)

	-- Enchant Weapon - Healing Power -- 22750
	AddRecipe(22750,300,nil,1,GAME_ORIG,300,310,325,340)
	self:addTradeFlags(RecipeDB,22750,1,2,6,36,40,53,54,66,67)
	self:addTradeAcquire(RecipeDB,22750,8,26)

	-- Enchant Weapon - Strength -- 23799
	AddRecipe(23799,290,nil,1,GAME_ORIG,290,305,322,340)
	self:addTradeFlags(RecipeDB,23799,1,2,4,36,40,51,66,67,98)
	self:addTradeAcquire(RecipeDB,23799,6,59,1,12944)

	-- Enchant Weapon - Agility -- 23800
	AddRecipe(23800,290,nil,1,GAME_ORIG,290,305,322,340)
	self:addTradeFlags(RecipeDB,23800,2,4,36,40,51,66,67,99)
	self:addTradeAcquire(RecipeDB,23800,6,576,2,11557)

	-- Enchant Bracer - Mana Regeneration -- 23801
	AddRecipe(23801,290,nil,1,GAME_ORIG,290,305,322,340)
	self:addTradeFlags(RecipeDB,23801,1,2,4,36,40,53,54,96)
	self:addTradeAcquire(RecipeDB,23801,6,529,2,10856,6,529,2,10857,6,529,2,11536)

	-- Enchant Bracer - Healing Power -- 23802
	AddRecipe(23802,300,nil,1,GAME_ORIG,300,310,325,340)
	self:addTradeFlags(RecipeDB,23802,1,2,4,36,40,53,54,96)
	self:addTradeAcquire(RecipeDB,23802,6,529,3,10856,6,529,3,10857,6,529,3,11536)

	-- Enchant Weapon - Mighty Spirit -- 23803
	AddRecipe(23803,300,nil,1,GAME_ORIG,300,310,325,340)
	self:addTradeFlags(RecipeDB,23803,1,2,4,36,41,53,54,66,67,98)
	self:addTradeAcquire(RecipeDB,23803,6,59,2,12944)

	-- Enchant Weapon - Mighty Intellect -- 23804
	AddRecipe(23804,300,nil,1,GAME_ORIG,300,310,325,340)
	self:addTradeFlags(RecipeDB,23804,1,2,4,36,41,66,67,98)
	self:addTradeAcquire(RecipeDB,23804,6,59,3,12944)

	-- Enchant Gloves - Threat -- 25072
	AddRecipe(25072, 300, nil, R_RARE, GAME_ORIG, 300, 310, 325, 340)
	self:addTradeFlags(RecipeDB,25072,1,2,4,6,11,36,40,111, F_TANK)
	self:addTradeAcquire(RecipeDB,25072,3,15275,6,935,4,21432)

	-- Enchant Gloves - Shadow Power -- 25073
	AddRecipe(25073,300,nil,1,GAME_ORIG,300,310,325,340)
	self:addTradeFlags(RecipeDB,25073,1,2,6,36,40,53,54)
	self:addTradeAcquire(RecipeDB,25073,8,22)

	-- Enchant Gloves - Frost Power -- 25074
	AddRecipe(25074,300,nil,1,GAME_ORIG,300,310,325,340)
	self:addTradeFlags(RecipeDB,25074,1,2,6,36,40,53,54)
	self:addTradeAcquire(RecipeDB,25074,8,22)

	-- Enchant Gloves - Fire Power -- 25078
	AddRecipe(25078,300,nil,1,GAME_ORIG,300,310,325,340)
	self:addTradeFlags(RecipeDB,25078,1,2,6,36,40,53,54)
	self:addTradeAcquire(RecipeDB,25078,8,22)

	-- Enchant Gloves - Healing Power -- 25079
	AddRecipe(25079,300,nil,1,GAME_ORIG,300,310,325,340)
	self:addTradeFlags(RecipeDB,25079,1,2,6,36,40,53,54)
	self:addTradeAcquire(RecipeDB,25079,8,22)

	-- Enchant Gloves - Superior Agility -- 25080
	AddRecipe(25080,300,nil,1,1,300,310,325,340)
	self:addTradeFlags(RecipeDB,25080,1,2,4,6,36,40,51,106)
	self:addTradeAcquire(RecipeDB,25080,8,22,6,989,4,21643)

	-- Enchant Cloak - Greater Fire Resistance -- 25081
	AddRecipe(25081,300,nil,1,GAME_ORIG,300,310,325,340)
	self:addTradeFlags(RecipeDB,25081,1,2,4,36,40,60,97)
	self:addTradeAcquire(RecipeDB,25081,6,609,1,15419)

	-- Enchant Cloak - Greater Nature Resistance -- 25082
	AddRecipe(25082,300,nil,1,GAME_ORIG,300,310,325,340)
	self:addTradeFlags(RecipeDB,25082,1,2,4,36,40,60,97)
	self:addTradeAcquire(RecipeDB,25082,6,609,2,15419)

	-- Enchant Cloak - Stealth -- 25083
	AddRecipe(25083,300,nil,1,1,300,310,325,340)
	self:addTradeFlags(RecipeDB,25083,1,2,4,6,10,36,40,60)
	self:addTradeAcquire(RecipeDB,25083,8,22,6,942,4,17904)

	-- Enchant Cloak - Subtlety -- 25084
	AddRecipe(25084,300,nil,1,1,300,310,325,340)
	self:addTradeFlags(RecipeDB,25084,1,2,4,6,36,40,60,104)
	self:addTradeAcquire(RecipeDB,25084,3,15276,6,946,4,17657,6,947,4,17585)

	-- Enchant Cloak - Dodge -- 25086
	AddRecipe(25086,300,nil,1,1,300,310,325,340)
	self:addTradeFlags(RecipeDB,25086,1,2,4,6,10,36,40,52,60,107)
	self:addTradeAcquire(RecipeDB,25086,8,22,6,1011,4,21655)

	-- Minor Wizard Oil -- 25124
	AddRecipe(25124,45,20744,1,GAME_ORIG,45,55,65,75)
	self:addTradeFlags(RecipeDB,25124,1,2,4,36,40,53,54)
	self:addTradeAcquire(RecipeDB,25124,2,1318,2,3012,2,3346,2,4228,2,4617,2,5158,2,5757,2,5758,2,15419,2,16635,2,16722,2,18753,2,18773,2,18951,2,19234,2,19537,2,19540,2,19663,2,26569,2,27030,2,27054,2,27147,2,28714)

	-- Minor Mana Oil -- 25125
	AddRecipe(25125,150,20745,1,GAME_ORIG,150,160,170,180)
	self:addTradeFlags(RecipeDB,25125,1,2,4,36,40)
	self:addTradeAcquire(RecipeDB,25125,2,1318,2,3012,2,3346,2,4228,2,4617,2,5158,2,5757,2,5758,2,15419,2,16635,2,16722,2,18753,2,18773,2,18951,2,19234,2,19537,2,19540,2,19663,2,26569,2,27030,2,27054,2,27147,2,28714)

	-- Lesser Wizard Oil -- 25126
	AddRecipe(25126,200,20746,1,GAME_ORIG,200,210,220,230)
	self:addTradeFlags(RecipeDB,25126,1,2,4,36,40,53,54)
	self:addTradeAcquire(RecipeDB,25126,2,1318,2,3012,2,3346,2,4228,2,4617,2,5158,2,5757,2,5758,2,15419,2,16635,2,16722,2,18753,2,18773,2,18951,2,19234,2,19537,2,19540,2,19663,2,26569,2,27030,2,27054,2,27147,2,28714)

	-- Lesser Mana Oil -- 25127
	AddRecipe(25127,250,20747,1,GAME_ORIG,250,260,270,280)
	self:addTradeFlags(RecipeDB,25127,1,2,4,36,40)
	self:addTradeAcquire(RecipeDB,25127,2,15419)

	-- Wizard Oil -- 25128
	AddRecipe(25128,275,20750,1,GAME_ORIG,275,285,295,305)
	self:addTradeFlags(RecipeDB,25128,1,2,4,36,40,53,54)
	self:addTradeAcquire(RecipeDB,25128,2,15419)

	-- Brilliant Wizard Oil -- 25129
	AddRecipe(25129,300,20749,1,GAME_ORIG,300,310,320,330)
	self:addTradeFlags(RecipeDB,25129,1,2,4,36,41,53,54,100)
	self:addTradeAcquire(RecipeDB,25129,6,270,2,14921)

	-- Brilliant Mana Oil -- 25130
	AddRecipe(25130,300,20748,1,GAME_ORIG,300,310,320,330)
	self:addTradeFlags(RecipeDB,25130,1,2,4,36,41,53,54,100)
	self:addTradeAcquire(RecipeDB,25130,6,270,1,14921)

	-- Enchant 2H Weapon - Agility -- 27837
	AddRecipe(27837,290,nil,1,GAME_ORIG,290,305,322,340)
	self:addTradeFlags(RecipeDB,27837,1,2,4,36,40,51,67,99)
	self:addTradeAcquire(RecipeDB,27837,6,576,1,11557)

	-- Enchant Bracer - Brawn -- 27899
	AddRecipe(27899,305,nil,1,1,305,315,330,345)
	self:addTradeFlags(RecipeDB,27899,1,2,3,36,40,51)
	self:addTradeAcquire(RecipeDB,27899,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Enchant Bracer - Stats -- 27905
	AddRecipe(27905,315,nil,1,1,315,325,340,355)
	self:addTradeFlags(RecipeDB,27905,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,27905,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Enchant Bracer - Major Defense -- 27906
	AddRecipe(27906,320,nil,1,1,320,330,345,360)
	self:addTradeFlags(RecipeDB,27906,1,2,11,36,40,52)
	self:addTradeAcquire(RecipeDB,27906,3,22822,3,23008)

	-- Enchant Bracer - Superior Healing -- 27911
	AddRecipe(27911,325,nil,1,1,325,335,350,365)
	self:addTradeFlags(RecipeDB,27911,2,4,36,40,53,54,104)
	self:addTradeAcquire(RecipeDB,27911,6,946,1,17657,6,947,1,17585)

	-- Enchant Bracer - Restore Mana Prime -- 27913
	AddRecipe(27913,335,nil,1,1,335,345,360,375)
	self:addTradeFlags(RecipeDB,27913,1,2,10,36,40,53,54)
	self:addTradeAcquire(RecipeDB,27913,7,1)

	-- Enchant Bracer - Fortitude -- 27914
	AddRecipe(27914,350,nil,1,1,320,330,345,360)
	self:addTradeFlags(RecipeDB,27914,1,2,5,36,40)
	self:addTradeAcquire(RecipeDB,27914,3,17803)

	-- Enchant Bracer - Spellpower -- 27917
	AddRecipe(27917,360,nil,1,1,360,370,385,400)
	self:addTradeFlags(RecipeDB,27917,1,2,11,36,40,53,54)
	self:addTradeAcquire(RecipeDB,27917,3,19952)

	-- Enchant Ring - Striking -- 27920
	AddRecipe(27920,360,nil,1,1,360,370,377,385)
	self:addTradeFlags(RecipeDB,27920,1,2,4,36,41,62,105)
	self:addTradeAcquire(RecipeDB,27920,6,933,3,17518)

	-- Enchant Ring - Spellpower -- 27924
	AddRecipe(27924,360,nil,1,1,360,370,377,385)
	self:addTradeFlags(RecipeDB,27924,1,2,4,36,41,53,54,62,106)
	self:addTradeAcquire(RecipeDB,27924,6,989,2,21643)

	-- Enchant Ring - Healing Power -- 27926
	AddRecipe(27926,370,nil,1,1,370,380,385,390)
	self:addTradeFlags(RecipeDB,27926,1,2,4,37,41,53,54,62,111)
	self:addTradeAcquire(RecipeDB,27926,6,935,3,21432)

	-- Enchant Ring - Stats -- 27927
	AddRecipe(27927,375,nil,1,1,375,380,385,390)
	self:addTradeFlags(RecipeDB,27927,1,2,4,36,41,62,107)
	self:addTradeAcquire(RecipeDB,27927,6,1011,2,21655)

	-- Enchant Shield - Tough Shield -- 27944
	AddRecipe(27944,310,nil,1,1,310,320,335,350)
	self:addTradeFlags(RecipeDB,27944,1,2,3,36,40,52,64)
	self:addTradeAcquire(RecipeDB,27944,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Enchant Shield - Intellect -- 27945
	AddRecipe(27945,325,nil,1,1,325,335,350,365)
	self:addTradeFlags(RecipeDB,27945,1,2,4,36,40,64)
	self:addTradeAcquire(RecipeDB,27945,2,18664)

	-- Enchant Shield - Shield Block -- 27946
	AddRecipe(27946,340,nil,1,1,340,350,365,380)
	self:addTradeFlags(RecipeDB,27946,1,2,10,36,40,52,64)
	self:addTradeAcquire(RecipeDB,27946,7,1)

	-- Enchant Shield - Resistance -- 27947
	AddRecipe(27947,360,nil,1,1)
	self:addTradeFlags(RecipeDB,27947,1,2,10,36,40,64)
	self:addTradeAcquire(RecipeDB,27947,7,1)

	-- Enchant Boots - Vitality -- 27948
	AddRecipe(27948,305,nil,1,1,305,315,330,345)
	self:addTradeFlags(RecipeDB,27948,1,2,11,36,40,53,54)
	self:addTradeAcquire(RecipeDB,27948,3,24664)

	-- Enchant Boots - Fortitude -- 27950
	AddRecipe(27950,320,nil,1,1,320,330,345,360)
	self:addTradeFlags(RecipeDB,27950,1,2,5,11,36,40)
	self:addTradeAcquire(RecipeDB,27950,3,18317)

	-- Enchant Boots - Dexterity -- 27951
	AddRecipe(27951,340,nil,1,1,340,350,365,380)
	self:addTradeFlags(RecipeDB,27951,1,2,5,36,40,51)
	self:addTradeAcquire(RecipeDB,27951,3,18521)

	-- Enchant Boots - Surefooted -- 27954
	AddRecipe(27954,370,nil,1,1,370,380,385,390)
	self:addTradeFlags(RecipeDB,27954,1,2,6,36,41,51,54)
	self:addTradeAcquire(RecipeDB,27954,3,16472)

	-- Enchant Chest - Exceptional Health -- 27957
	AddRecipe(27957,315,nil,1,1,315,325,340,355)
	self:addTradeFlags(RecipeDB,27957,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,27957,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Enchant Chest - Exceptional Mana -- 27958
	AddRecipe(27958,350,nil,1,2,350,360,370,380)
	self:addTradeFlags(RecipeDB,27958,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,27958,1,28693,1,33583,1,26990,1,26980,1,26954,1,26906)

	-- Enchant Chest - Exceptional Stats -- 27960
	AddRecipe(27960,345,nil,1,1,345,355,367,380)
	self:addTradeFlags(RecipeDB,27960,1,2,4,36,40,104)
	self:addTradeAcquire(RecipeDB,27960,6,946,3,17657,6,947,3,17585)

	-- Enchant Cloak - Major Armor -- 27961
	AddRecipe(27961,310,nil,1,1,310,320,335,350)
	self:addTradeFlags(RecipeDB,27961,1,2,3,36,40,60)
	self:addTradeAcquire(RecipeDB,27961,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Enchant Cloak - Major Resistance -- 27962
	AddRecipe(27962,330,nil,1,1,330,340,355,370)
	self:addTradeFlags(RecipeDB,27962,1,2,10,36,40,60)
	self:addTradeAcquire(RecipeDB,27962,7,1)

	-- Enchant Weapon - Major Striking -- 27967
	AddRecipe(27967,340,nil,1,1,340,350,365,380)
	self:addTradeFlags(RecipeDB,27967,1,2,4,36,40,66,67,105)
	self:addTradeAcquire(RecipeDB,27967,6,933,2,20242,6,933,2,23007)

	-- Enchant Weapon - Major Intellect -- 27968
	AddRecipe(27968,340,nil,1,1,340,350,365,380)
	self:addTradeFlags(RecipeDB,27968,1,2,11,36,40,66,67)
	self:addTradeAcquire(RecipeDB,27968,3,20136)

	-- Enchant 2H Weapon - Savagery -- 27971
	AddRecipe(27971,350,nil,1,1,350,370,375,380)
	self:addTradeFlags(RecipeDB,27971,1,2,5,36,40,51,67)
	self:addTradeAcquire(RecipeDB,27971,3,17465)

	-- Enchant Weapon - Potency -- 27972
	AddRecipe(27972,350,nil,1,1,350,370,375,380)
	self:addTradeFlags(RecipeDB,27972,1,2,10,36,40,51,66,67)
	self:addTradeAcquire(RecipeDB,27972,7,1)

	-- Enchant Weapon - Major Spellpower -- 27975
	AddRecipe(27975,350,nil,1,1,350,370,375,380)
	self:addTradeFlags(RecipeDB,27975,1,2,11,36,40,53,54,66,67)
	self:addTradeAcquire(RecipeDB,27975,3,22242)

	-- Enchant 2H Weapon - Major Agility -- 27977
	AddRecipe(27977,360,nil,1,1,360,370,377,385)
	self:addTradeFlags(RecipeDB,27977,1,2,5,36,40,51,67)
	self:addTradeAcquire(RecipeDB,27977,3,20880)

	-- Enchant Weapon - Sunfire -- 27981
	AddRecipe(27981,375,nil,1,1,375,375,375,390)
	self:addTradeFlags(RecipeDB,27981,1,2,6,11,36,40,53,54,66,67)
	self:addTradeAcquire(RecipeDB,27981,3,16524)

	-- Enchant Weapon - Soulfrost -- 27982
	AddRecipe(27982,375,nil,1,1,375,380,385,390)
	self:addTradeFlags(RecipeDB,27982,1,2,6,36,40,53,54,66,67)
	self:addTradeAcquire(RecipeDB,27982,3,15688)

	-- Enchant Weapon - Mongoose -- 27984
	AddRecipe(27984,375,nil,3,1,375,380,385,390)
	self:addTradeFlags(RecipeDB,27984,1,2,6,11,36,40,51,66,67)
	self:addTradeAcquire(RecipeDB,27984,3,15687)

	-- Enchant Weapon - Spellsurge -- 28003
	AddRecipe(28003,360,nil,1,1,360,370,377,385)
	self:addTradeFlags(RecipeDB,28003,1,2,5,6,11,36,40,66,67)
	self:addTradeAcquire(RecipeDB,28003,7,2)

	-- Enchant Weapon - Battlemaster -- 28004
	AddRecipe(28004,360,nil,1,1,360,370,377,385)
	self:addTradeFlags(RecipeDB,28004,1,2,5,6,11,36,40,66,67)
	self:addTradeAcquire(RecipeDB,28004,7,2)

	-- Superior Mana Oil -- 28016
	AddRecipe(28016,310,22521,1,1,310,310,320,330)
	self:addTradeFlags(RecipeDB,28016,1,2,4,36,40)
	self:addTradeAcquire(RecipeDB,28016,2,16635,2,16722,2,19663)

	-- Superior Wizard Oil -- 28019
	AddRecipe(28019,340,22522,1,1,340,340,350,360)
	self:addTradeFlags(RecipeDB,28019,1,2,4,36,40,53,54)
	self:addTradeAcquire(RecipeDB,28019,2,16635,2,16722,2,19663)

	-- Large Prismatic Shard -- 28022
	AddRecipe(28022,335,22449,1,1,335,335,335,335)
	self:addTradeFlags(RecipeDB,28022,1,2,4,36,40)
	self:addTradeAcquire(RecipeDB,28022,2,16635,2,16722,2,19663)

	-- Prismatic Sphere -- 28027
	AddRecipe(28027,325,22460,1,1,325,325,330,335)
	self:addTradeFlags(RecipeDB,28027,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,28027,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Void Sphere -- 28028
	AddRecipe(28028,350,22459,1,1,350,370,375,380)
	self:addTradeFlags(RecipeDB,28028,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,28028,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Runed Fel Iron Rod -- 32664
	AddRecipe(32664,300,22461,1,1,300,310,325,340)
	self:addTradeFlags(RecipeDB,32664,1,2,3,37,41)
	self:addTradeAcquire(RecipeDB,32664,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Runed Adamantite Rod -- 32665
	AddRecipe(32665,350,22462,1,1,350,370,375,380)
	self:addTradeFlags(RecipeDB,32665,1,2,4,37,41)
	self:addTradeAcquire(RecipeDB,32665,2,18960,2,19004)

	-- Runed Eternium Rod -- 32667
	AddRecipe(32667,375,22463,1,1,375,375,377,385)
	self:addTradeFlags(RecipeDB,32667,1,2,3,4,37,41)
	self:addTradeAcquire(RecipeDB,32667,2,19663,1,28693,1,33583,1,26990,1,26980,1,26954,1,26906)

	-- Enchant Chest - Major Spirit -- 33990
	AddRecipe(33990,320,nil,1,1,320,330,345,360)
	self:addTradeFlags(RecipeDB,33990,1,2,3,36,40,53,54)
	self:addTradeAcquire(RecipeDB,33990,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Enchant Chest - Restore Mana Prime -- 33991
	AddRecipe(33991,300,nil,1,1,300,310,325,340)
	self:addTradeFlags(RecipeDB,33991,1,2,3,36,40,53,54)
	self:addTradeAcquire(RecipeDB,33991,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Enchant Chest - Major Resilience -- 33992
	AddRecipe(33992,345,nil,1,1,345,355,367,380)
	self:addTradeFlags(RecipeDB,33992,1,2,10,36,40)
	self:addTradeAcquire(RecipeDB,33992,7,1)

	-- Enchant Gloves - Blasting -- 33993
	AddRecipe(33993,305,nil,1,1,305,315,330,345)
	self:addTradeFlags(RecipeDB,33993,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,33993,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Enchant Gloves - Precise Strikes -- 33994
	AddRecipe(33994,360,nil,1,1,360,370,377,385)
	self:addTradeFlags(RecipeDB,33994,1,2,4,36,40,103)
	self:addTradeAcquire(RecipeDB,33994,6,942,3,17904)

	-- Enchant Gloves - Major Strength -- 33995
	AddRecipe(33995,340,nil,1,1,340,350,365,380)
	self:addTradeFlags(RecipeDB,33995,1,2,3,36,40,51)
	self:addTradeAcquire(RecipeDB,33995,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Enchant Gloves - Assault -- 33996
	AddRecipe(33996,310,nil,1,1,310,320,335,350)
	self:addTradeFlags(RecipeDB,33996,1,2,3,36,40,51)
	self:addTradeAcquire(RecipeDB,33996,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Enchant Gloves - Major Spellpower -- 33997
	AddRecipe(33997,360,nil,1,1,360,370,377,385)
	self:addTradeFlags(RecipeDB,33997,1,2,4,36,40,53,54,106)
	self:addTradeAcquire(RecipeDB,33997,6,989,2,21643)

	-- Enchant Gloves - Major Healing -- 33999
	AddRecipe(33999,350,nil,1,1,350,370,375,380)
	self:addTradeFlags(RecipeDB,33999,1,2,4,36,40,53,54,111)
	self:addTradeAcquire(RecipeDB,33999,6,935,2,21432)

	-- Enchant Bracer - Major Intellect -- 34001
	AddRecipe(34001,305,nil,1,1,305,315,330,345)
	self:addTradeFlags(RecipeDB,34001,1,2,3,36,40)
	self:addTradeAcquire(RecipeDB,34001,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Enchant Bracer - Assault -- 34002
	AddRecipe(34002,300,nil,1,1,300,310,325,340)
	self:addTradeFlags(RecipeDB,34002,1,2,3,36,40,51)
	self:addTradeAcquire(RecipeDB,34002,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Enchant Cloak - Spell Penetration -- 34003
	AddRecipe(34003,325,nil,1,1,325,335,350,365)
	self:addTradeFlags(RecipeDB,34003,1,2,4,36,40,54,60,105)
	self:addTradeAcquire(RecipeDB,34003,6,933,1,20242,6,933,1,23007)

	-- Enchant Cloak - Greater Agility -- 34004
	AddRecipe(34004,310,nil,1,1,310,320,335,350)
	self:addTradeFlags(RecipeDB,34004,1,2,3,36,40,51,60)
	self:addTradeAcquire(RecipeDB,34004,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Enchant Cloak - Greater Arcane Resistance -- 34005
	AddRecipe(34005,350,nil,1,1,350,370,375,380)
	self:addTradeFlags(RecipeDB,34005,1,2,11,36,40,60)
	self:addTradeAcquire(RecipeDB,34005,3,19796)

	-- Enchant Cloak - Greater Shadow Resistance -- 34006
	AddRecipe(34006,350,nil,1,1,350,370,375,380)
	self:addTradeFlags(RecipeDB,34006,1,2,11,36,40,60)
	self:addTradeAcquire(RecipeDB,34006,3,18870)

	-- Enchant Boots - Cat's Swiftness -- 34007
	AddRecipe(34007,360,nil,1,1,360,370,377,385)
	self:addTradeFlags(RecipeDB,34007,1,2,11,36,40,51)
	self:addTradeAcquire(RecipeDB,34007,3,24664)

	-- Enchant Boots - Boar's Speed -- 34008
	AddRecipe(34008,360,nil,1,1,360,370,377,385)
	self:addTradeFlags(RecipeDB,34008,1,2,11,36,40)
	self:addTradeAcquire(RecipeDB,34008,3,24664)

	-- Enchant Shield - Major Stamina -- 34009
	AddRecipe(34009,325,nil,1,1,325,335,350,365)
	self:addTradeFlags(RecipeDB,34009,1,2,4,36,40,64)
	self:addTradeAcquire(RecipeDB,34009,2,19663)

	-- Enchant Weapon - Major Healing -- 34010
	AddRecipe(34010,350,nil,1,1,350,370,375,380)
	self:addTradeFlags(RecipeDB,34010,1,2,4,36,40,53,54,66,67,111)
	self:addTradeAcquire(RecipeDB,34010,6,935,3,21432)

	-- Nexus Transformation -- 42613
	AddRecipe(42613,300,22448,1,1,300,300,300,305)
	self:addTradeFlags(RecipeDB,42613,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,42613,1,18753,1,18773,1,19252,1,33610,1,33676,1,19540)

	-- Small Prismatic Shard -- 42615
	AddRecipe(42615,335,22448,1,1,335,335,335,335)
	self:addTradeFlags(RecipeDB,42615,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,42615,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Enchant Weapon - Greater Agility -- 42620
	AddRecipe(42620,350,nil,1,1,350,360,367,375)
	self:addTradeFlags(RecipeDB,42620,1,2,4,36,40,51,66,67,114)
	self:addTradeAcquire(RecipeDB,42620,6,967,4,18255)

	-- Enchant Weapon - Executioner -- 42974
	AddRecipe(42974,375,nil,1,1,375,380,385,390)
	self:addTradeFlags(RecipeDB,42974,1,2,6,36,40,51,66,67)
	self:addTradeAcquire(RecipeDB,42974,8,29)

	-- Enchant Shield - Resilience -- 44383
	AddRecipe(44383,330,nil,1,1,330,340,355,370)
	self:addTradeFlags(RecipeDB,44383,1,2,3,36,41,64)
	self:addTradeAcquire(RecipeDB,44383,1,18753,1,18773,1,19252,1,19540,1,33610,1,33676)

	-- Enchant Cloak - Superior Frost Resistance -- 44483
	AddRecipe(44483,400,nil,1,2,400,415,425,435)
	self:addTradeFlags(RecipeDB,44483,1,2,11,36,40,60)
	self:addTradeAcquire(RecipeDB,44483,3,32289)

	-- Enchant Gloves - Expertise -- 44484
	AddRecipe(44484,405,nil,1,2,405,415,425,435)
	self:addTradeFlags(RecipeDB,44484,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,44484,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Gloves - Precision -- 44488
	AddRecipe(44488,410,nil,1,2,410,420,430,440)
	self:addTradeFlags(RecipeDB,44488,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,44488,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Shield - Defense -- 44489
	AddRecipe(44489,420,nil,1,2,420,430,440,450)
	self:addTradeFlags(RecipeDB,44489,1,2,3,36,41,52,64)
	self:addTradeAcquire(RecipeDB,44489,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Chest - Mighty Health -- 44492
	AddRecipe(44492,395,nil,1,2,395,405,415,425)
	self:addTradeFlags(RecipeDB,44492,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,44492,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Cloak - Superior Nature Resistance -- 44494
	AddRecipe(44494,400,nil,1,2,400,415,425,435)
	self:addTradeFlags(RecipeDB,44494,1,2,11,36,40,60)
	self:addTradeAcquire(RecipeDB,44494,3,32290)

	-- Enchant Cloak - Superior Agility -- 44500
	AddRecipe(44500,395,nil,1,2,395,405,415,425)
	self:addTradeFlags(RecipeDB,44500,1,2,3,36,41,51,60)
	self:addTradeAcquire(RecipeDB,44500,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Gloves - Gatherer -- 44506
	AddRecipe(44506,375,nil,1,2,375,375,380,390)
	self:addTradeFlags(RecipeDB,44506,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,44506,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Boots - Greater Spirit -- 44508
	AddRecipe(44508,410,nil,1,2,410,420,430,440)
	self:addTradeFlags(RecipeDB,44508,1,2,3,36,41,53,54)
	self:addTradeAcquire(RecipeDB,44508,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Chest - Greater Mana Restoration -- 44509
	AddRecipe(44509,420,nil,1,2,420,430,440,450)
	self:addTradeFlags(RecipeDB,44509,1,2,3,36,41,53,54)
	self:addTradeAcquire(RecipeDB,44509,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Weapon - Exceptional Spirit -- 44510
	AddRecipe(44510,410,nil,1,2,410,420,430,440)
	self:addTradeFlags(RecipeDB,44510,1,2,3,36,41,53,54,66,67)
	self:addTradeAcquire(RecipeDB,44510,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Gloves - Greater Assault -- 44513
	AddRecipe(44513,395,nil,1,2,395,405,415,425)
	self:addTradeFlags(RecipeDB,44513,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,44513,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Weapon - Icebreaker -- 44524
	AddRecipe(44524,425,nil,1,2,425,435,445,455)
	self:addTradeFlags(RecipeDB,44524,1,2,4,36,40,66,67)
	self:addTradeAcquire(RecipeDB,44524,2,32514)

	-- Enchant Boots - Greater Fortitude -- 44528
	AddRecipe(44528,385,nil,1,2,385,385,390,400)
	self:addTradeFlags(RecipeDB,44528,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,44528,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Gloves - Major Agility -- 44529
	AddRecipe(44529,415,nil,1,2,415,425,435,445)
	self:addTradeFlags(RecipeDB,44529,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,44529,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Bracers - Exceptional Intellect -- 44555
	AddRecipe(44555,375,nil,1,2,375,385,392,400)
	self:addTradeFlags(RecipeDB,44555,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,44555,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Cloak - Superior Fire Resistance -- 44556
	AddRecipe(44556,400,nil,1,2,400,415,425,435)
	self:addTradeFlags(RecipeDB,44556,1,2,11,36,40,60)
	self:addTradeAcquire(RecipeDB,44556,3,30921)

	-- Enchant Bracers - Greater Assault -- 44575
	AddRecipe(44575,430,nil,1,2,430,440,450,460)
	self:addTradeFlags(RecipeDB,44575,1,2,4,36,40,51)
	self:addTradeAcquire(RecipeDB,44575,2,32514)

	-- Enchant Weapon - Lifeward -- 44576
	AddRecipe(44576,440,nil,3,2,425,435,445,455)
	self:addTradeFlags(RecipeDB,44576,1,2,4,36,41,66,67)
	self:addTradeAcquire(RecipeDB,44576,2,32514)

	-- Enchant Cloak - Spell Piercing -- 44582
	AddRecipe(44582,395,nil,1,2,395,395,402,410)
	self:addTradeFlags(RecipeDB,44582,1,2,3,36,41,54,60)
	self:addTradeAcquire(RecipeDB,44582,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Boots - Greater Vitality -- 44584
	AddRecipe(44584,405,nil,1,2,405,415,425,435)
	self:addTradeFlags(RecipeDB,44584,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,44584,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Boots - Superior Agility -- 44589
	AddRecipe(44589,415,nil,1,2,415,425,435,445)
	self:addTradeFlags(RecipeDB,44589,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,44589,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Cloak - Superior Shadow Resistance -- 44590
	AddRecipe(44590,400,nil,1,2,400,415,425,435)
	self:addTradeFlags(RecipeDB,44590,1,2,11,36,40,60)
	self:addTradeAcquire(RecipeDB,44590,3,32349)

	-- Enchant Cloak - Titanweave -- 44591
	AddRecipe(44591,435,nil,1,2,435,445,455,465)
	self:addTradeFlags(RecipeDB,44591,1,2,4,36,40,52,60)
	self:addTradeAcquire(RecipeDB,44591,2,32514)

	-- Enchant Gloves - Exceptional Spellpower -- 44592
	AddRecipe(44592,360,nil,1,2,360,370,380,390)
	self:addTradeFlags(RecipeDB,44592,1,2,3,36,41,53,54)
	self:addTradeAcquire(RecipeDB,44592,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Bracers - Major Spirit -- 44593
	AddRecipe(44593,420,nil,1,2,420,430,440,450)
	self:addTradeFlags(RecipeDB,44593,1,2,3,36,41,53,54)
	self:addTradeAcquire(RecipeDB,44593,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant 2H Weapon - Scourgebane -- 44595
	AddRecipe(44595,430,nil,3,2,430,440,450,460)
	self:addTradeFlags(RecipeDB,44595,1,2,4,36,41,51,66,67)
	self:addTradeAcquire(RecipeDB,44595,2,32514)

	-- Enchant Cloak - Superior Arcane Resistance -- 44596
	AddRecipe(44596,400,nil,1,2,400,415,425,435)
	self:addTradeFlags(RecipeDB,44596,1,2,11,36,40,60)
	self:addTradeAcquire(RecipeDB,44596,3,31702,3,32297)

	-- Enchant Bracers - Expertise -- 44598
	AddRecipe(44598,415,nil,1,2,415,425,435,445)
	self:addTradeFlags(RecipeDB,44598,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,44598,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Bracers - Greater Stats -- 44616
	AddRecipe(44616,400,nil,1,2,400,410,420,430)
	self:addTradeFlags(RecipeDB,44616,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,44616,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Weapon - Giant Slayer -- 44621
	AddRecipe(44621,430,nil,1,2,430,440,450,460)
	self:addTradeFlags(RecipeDB,44621,1,2,4,36,40,66,67)
	self:addTradeAcquire(RecipeDB,44621,2,32514)

	-- Enchant Chest - Super Stats -- 44623
	AddRecipe(44623,370,nil,1,2,370,380,390,400)
	self:addTradeFlags(RecipeDB,44623,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,44623,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Gloves - Armsman -- 44625
	AddRecipe(44625,435,nil,2,2,435,445,455,465)
	self:addTradeFlags(RecipeDB,44625,1,2,4,36,41,52)
	self:addTradeAcquire(RecipeDB,44625,2,32514)

	-- Enchant Weapon - Exceptional Spellpower -- 44629
	AddRecipe(44629,395,nil,1,2,395,405,415,425)
	self:addTradeFlags(RecipeDB,44629,1,2,3,36,41,53,54,66,67)
	self:addTradeAcquire(RecipeDB,44629,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant 2H Weapon - Greater Savagery -- 44630
	AddRecipe(44630,390,nil,1,2,390,400,410,420)
	self:addTradeFlags(RecipeDB,44630,1,2,3,36,41,51,67)
	self:addTradeAcquire(RecipeDB,44630,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Cloak - Shadow Armor -- 44631
	AddRecipe(44631,440,nil,1,2,440,450,460,470)
	self:addTradeFlags(RecipeDB,44631,1,2,4,36,40,51,60)
	self:addTradeAcquire(RecipeDB,44631,2,32514)

	-- Enchant Weapon - Exceptional Agility -- 44633
	AddRecipe(44633,410,nil,1,2,410,420,430,440)
	self:addTradeFlags(RecipeDB,44633,1,2,3,36,41,51,66,67)
	self:addTradeAcquire(RecipeDB,44633,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Bracers - Greater Spellpower -- 44635
	AddRecipe(44635,395,nil,1,2,395,405,415,425)
	self:addTradeFlags(RecipeDB,44635,1,2,3,36,41,53,54)
	self:addTradeAcquire(RecipeDB,44635,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Ring - Greater Spellpower -- 44636
	AddRecipe(44636,400,nil,1,2,400,400,407,415)
	self:addTradeFlags(RecipeDB,44636,1,2,3,36,41,53,54,62)
	self:addTradeAcquire(RecipeDB,44636,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Ring - Assault -- 44645
	AddRecipe(44645,400,nil,1,2,400,400,407,415)
	self:addTradeFlags(RecipeDB,44645,1,2,3,36,41,51,62)
	self:addTradeAcquire(RecipeDB,44645,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Void Shatter -- 45765
	AddRecipe(45765,375,22449,1,1,375,375,375,375)
	self:addTradeFlags(RecipeDB,45765,1,2,4,36,41,112)
	self:addTradeAcquire(RecipeDB,45765,6,1077,2,25032)

	-- Enchant Weapon - Deathfrost -- 46578
	AddRecipe(46578,350,nil,1,1,350,350,357,365)
	self:addTradeFlags(RecipeDB,46578,1,2,7,36,40,66,67)
	self:addTradeAcquire(RecipeDB,46578,5,4)

	-- Enchant Chest - Defense -- 46594
	AddRecipe(46594,360,nil,1,2,360,370,385,400)
	self:addTradeFlags(RecipeDB,46594,1,2,4,36,40,52,112)
	self:addTradeAcquire(RecipeDB,46594,6,1077,2,25032)

	-- Enchant Cloak - Steelweave -- 47051
	AddRecipe(47051,375,nil,1,2,375,380,385,390)
	self:addTradeFlags(RecipeDB,47051,1,2,5,36,40,52,60)
	self:addTradeAcquire(RecipeDB,47051,3,24560)

	-- Enchant Cloak - Mighty Armor -- 47672
	AddRecipe(47672,430,nil,2,2,430,440,450,460)
	self:addTradeFlags(RecipeDB,47672,1,2,4,36,41,60)
	self:addTradeAcquire(RecipeDB,47672,2,32514)

	-- Enchant Chest - Greater Defense -- 47766
	AddRecipe(47766,400,nil,1,2,400,410,420,430)
	self:addTradeFlags(RecipeDB,47766,1,2,3,36,41,52)
	self:addTradeAcquire(RecipeDB,47766,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Cloak - Greater Speed -- 47898
	AddRecipe(47898,430,nil,2,2,430,440,450,460)
	self:addTradeFlags(RecipeDB,47898,1,2,4,36,41,60)
	self:addTradeAcquire(RecipeDB,47898,2,32514)

	-- Enchant Cloak - Wisdom -- 47899
	AddRecipe(47899,440,nil,2,2,440,450,460,470)
	self:addTradeFlags(RecipeDB,47899,1,2,4,36,41,53,54,60)
	self:addTradeAcquire(RecipeDB,47899,2,32514)

	-- Enchant Chest - Super Health -- 47900
	AddRecipe(47900,425,nil,1,2,425,435,445,455)
	self:addTradeFlags(RecipeDB,47900,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,47900,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Boots - Tuskarr's Vitality -- 47901
	AddRecipe(47901,440,nil,2,2,440,450,460,470)
	self:addTradeFlags(RecipeDB,47901,1,2,4,36,41)
	self:addTradeAcquire(RecipeDB,47901,2,32514)

	-- Enchant Weapon - Accuracy -- 59619
	AddRecipe(59619,440,nil,1,2,440,450,460,470)
	self:addTradeFlags(RecipeDB,59619,1,2,4,36,40,66,67)
	self:addTradeAcquire(RecipeDB,59619,2,32514)

	-- Enchant Weapon - Berserking -- 59621
	AddRecipe(59621,440,nil,1,2,440,450,460,470)
	self:addTradeFlags(RecipeDB,59621,1,2,4,36,40,51,66,67)
	self:addTradeAcquire(RecipeDB,59621,2,32514)

	-- Enchant Weapon - Black Magic -- 59625
	AddRecipe(59625,440,nil,3,2,440,450,460,470)
	self:addTradeFlags(RecipeDB,59625,1,2,4,36,41,66,67)
	self:addTradeAcquire(RecipeDB,59625,2,32514)

	-- Enchant Ring - Stamina -- 59636
	AddRecipe(59636,400,nil,1,2,400,400,407,415)
	self:addTradeFlags(RecipeDB,59636,1,2,3,36,41,62)
	self:addTradeAcquire(RecipeDB,59636,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Boots - Assault -- 60606
	AddRecipe(60606,375,nil,1,2,375,385,395,405)
	self:addTradeFlags(RecipeDB,60606,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,60606,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Cloak - Speed -- 60609
	AddRecipe(60609,350,nil,1,2,350,360,370,380)
	self:addTradeFlags(RecipeDB,60609,1,2,3,36,41,60)
	self:addTradeAcquire(RecipeDB,60609,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Bracers - Striking -- 60616
	AddRecipe(60616,360,nil,1,2,360,370,380,390)
	self:addTradeFlags(RecipeDB,60616,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,60616,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Runed Titanium Rod -- 60619
	AddRecipe(60619,425,44452,3,2,425,435,445,455)
	self:addTradeFlags(RecipeDB,60619,1,2,3,37,41)
	self:addTradeAcquire(RecipeDB,60619,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Weapon - Greater Potency -- 60621
	AddRecipe(60621,380,nil,1,2,380,390,400,410)
	self:addTradeFlags(RecipeDB,60621,1,2,3,36,41,51,66,67)
	self:addTradeAcquire(RecipeDB,60621,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Boots - Icewalker -- 60623
	AddRecipe(60623,385,nil,1,2,385,395,405,415)
	self:addTradeFlags(RecipeDB,60623,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,60623,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Shield - Greater Intellect -- 60653
	AddRecipe(60653,395,nil,1,2,395,405,415,425)
	self:addTradeFlags(RecipeDB,60653,1,2,3,36,41,64)
	self:addTradeAcquire(RecipeDB,60653,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Cloak - Major Agility -- 60663
	AddRecipe(60663,420,nil,1,2,420,430,440,450)
	self:addTradeFlags(RecipeDB,60663,1,2,3,36,41,51,60)
	self:addTradeAcquire(RecipeDB,60663,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Gloves - Crusher -- 60668
	AddRecipe(60668,425,nil,1,2,425,435,445,455)
	self:addTradeFlags(RecipeDB,60668,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,60668,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant 2H Weapon - Massacre -- 60691
	AddRecipe(60691,430,nil,3,2,430,440,450,460)
	self:addTradeFlags(RecipeDB,60691,1,2,4,36,41,51,67)
	self:addTradeAcquire(RecipeDB,60691,2,32514)

	-- Enchant Chest - Powerful Stats -- 60692
	AddRecipe(60692,440,nil,2,2,440,450,460,470)
	self:addTradeFlags(RecipeDB,60692,1,2,4,36,41)
	self:addTradeAcquire(RecipeDB,60692,2,32514)

	-- Enchant Weapon - Superior Potency -- 60707
	AddRecipe(60707,435,nil,3,2,435,445,455,465)
	self:addTradeFlags(RecipeDB,60707,1,2,4,36,41,51,66,67)
	self:addTradeAcquire(RecipeDB,60707,2,32514)

	-- Enchant Weapon - Mighty Spellpower -- 60714
	AddRecipe(60714,435,nil,3,2,435,445,455,465)
	self:addTradeFlags(RecipeDB,60714,1,2,4,36,41,53,54,66,67)
	self:addTradeAcquire(RecipeDB,60714,2,32514)

	-- Enchant Boots - Greater Assault -- 60763
	AddRecipe(60763,440,nil,2,2,440,450,460,470)
	self:addTradeFlags(RecipeDB,60763,1,2,4,36,41,51)
	self:addTradeAcquire(RecipeDB,60763,2,32514)

	-- Enchant Bracers - Superior Spellpower -- 60767
	AddRecipe(60767,440,nil,2,2,440,450,460,470)
	self:addTradeFlags(RecipeDB,60767,1,2,4,36,41,53,54)
	self:addTradeAcquire(RecipeDB,60767,2,32514)

	-- Enchant Bracer - Major Stamina -- 62256
	AddRecipe(62256,450,nil,2,2,450,460,470,480)
	self:addTradeFlags(RecipeDB,62256,1,2,4,36,41)
	self:addTradeAcquire(RecipeDB,62256,2,32514)

	-- Enchant Chest - Exceptional Resilience -- 44588
	AddRecipe(44588,410,nil,2,2,410,435,445,455)
	self:addTradeFlags(RecipeDB,44588,1,2,4,36,41)
	self:addTradeAcquire(RecipeDB,44588,2,32514)
	
	-- Enchant Weapon - Titanguard -- 62257
	--AddRecipe(62257,440,nil,2,2,450,460,470,480)
	--self:addTradeFlags(RecipeDB,62257,1,2,4,36,41)
	--self:addTradeAcquire(RecipeDB,62257,2,32514)

	-- Enchant Boots - Lesser Accuracy -- 63746
	AddRecipe(63746,225,nil,2,2,225,245,265,285)
	self:addTradeFlags(RecipeDB,63746,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,63746,1,1317,1,3011,1,3345,1,3606,1,4213,1,4616,1,5157,1,5695,
	1,11072,1,11073,1,11074,1,16160,1,16633,1,16725,1,19251,1,19252,1,33610,1,33676,1,18773,1,7949,1,19540,1,18753)

	-- Smoking Heart of the Mountain -- 15596
	AddRecipe(15596,265,45050,2,GAME_ORIG,265,285,305,325)
	self:addTradeFlags(RecipeDB,15596,1,2,5,11,37,41,61)
	self:addTradeAcquire(RecipeDB,15596,3,9025)

	-- Enchant Staff - Spellpower -- 62959
	AddRecipe(62959,385,nil,1,2,385,395,405,415)
	self:addTradeFlags(RecipeDB,62959,1,2,3,36,41,53,54,73)
	self:addTradeAcquire(RecipeDB,62959,1,26906,1,26954,1,26980,1,26990,1,28693,1,33583)

	-- Enchant Staff - Greater Spellpower -- 62948
	AddRecipe(62948,450,nil,3,2,450,455,460,465)
	self:addTradeFlags(RecipeDB,62948,1,2,4,36,41,53,54,73)
	self:addTradeAcquire(RecipeDB,62948,2,32514)

	-- Enchant Weapon - Blade Ward -- 64441
	AddRecipe(64441,450,nil,3,2,450,455,460,465)
	self:addTradeFlags(RecipeDB,64441,1,2,6,11,36,41,52,66,67)
	self:addTradeAcquire(RecipeDB,64441,8,39)

	-- Enchant Weapon - Blood Draining -- 64579
	AddRecipe(64579,450,nil,3,2,450,455,460,465)
	self:addTradeFlags(RecipeDB,64579,1,2,6,11,36,41,66,67)
	self:addTradeAcquire(RecipeDB,64579,8,39)

	-- Abyssal Shatter - 69412
	AddRecipe(69412, 445, 49640, R_COMMON, GAME_WOTLK, 445, 445, 447, 450)
	self:addTradeFlags(RecipeDB,69412,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,69412,1,28693,1,26990,1,26906,1,26954,1,26980,1,33583)

	-- Enchant Gloves - Angler - 71692
	AddRecipe(71692, 375, nil, R_UNCOMMON, GAME_WOTLK, 375, 385, 392, 400)
	self:addTradeFlags(RecipeDB, 71692, F_ALLIANCE, F_HORDE, F_IBOP, F_RBOP, F_MOB_DROP)
	self:addTradeAcquire(RecipeDB, 71692, A_MOB, 26343)

	return num_recipes

end
