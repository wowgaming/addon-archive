--[[
************************************************************************
Jewelcrafting.lua
Jewelcrafting data for all of Ackis Recipe List
************************************************************************
File date: 2010-01-30T02:09:09Z 
File revision: 2814 
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
local R_COMMON, R_UNCOMMON, R_RARE, R_EPIC, R_LEGENDARY, R_ARTIFACT = F_ALLIANCE, F_HORDE, 3, 4, 5, 6

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
local A_TRAINER, A_VENDOR, A_MOB, A_QUEST, A_SEASONAL, A_REPUTATION, A_WORLD_DROP, A_CUSTOM = F_ALLIANCE, F_HORDE, 3, 4, 5, 6, 7, 8


local initialized = false
local num_recipes = 0

function addon:InitJewelcrafting(RecipeDB)

	if initialized then
		return num_recipes
	end

	initialized = true

	--------------------------------------------------------------------------------------------------------------------
	-- Counter and wrapper function
	--------------------------------------------------------------------------------------------------------------------
	local function AddRecipe(SpellID, Skill, ItemID, Rarity, Game, Orange, Yellow, Green, Gray)
		num_recipes = num_recipes + 1
		self:addTradeSkill(RecipeDB, SpellID, Skill, ItemID, Rarity, 25229, nil, Game, Orange, Yellow, Green, Gray)
	end

	-- Delicate Copper Wire -- 25255
	AddRecipe(25255, 1, 20816, 1, 1, 1, 20, 35, 50)
	self:addTradeFlags(RecipeDB, 25255, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 25255, 8, 8)

	-- Bronze Setting -- 25278
	AddRecipe(25278, 50, 20817, 1, 1, 50, 70, 80, 90)
	self:addTradeFlags(RecipeDB, 25278, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 25278, 1, 15501, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Elegant Silver Ring -- 25280
	AddRecipe(25280, 50, 20818, 1, 1, 50, 80, 95, 110)
	self:addTradeFlags(RecipeDB, 25280, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 25280, 1, 15501, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Inlaid Malachite Ring -- 25283
	AddRecipe(25283, 30, 20821, 1, 1, 30, 60, 75, 90)
	self:addTradeFlags(RecipeDB, 25283, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 62)
	self:addTradeAcquire(RecipeDB, 25283, 1, 15501, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Simple Pearl Ring -- 25284
	AddRecipe(25284, 60, 20820, 1, 1, 60, 90, 105, 120)
	self:addTradeFlags(RecipeDB, 25284, F_ALLIANCE, F_HORDE, 3, 36, 41, 62)
	self:addTradeAcquire(RecipeDB, 25284, 1, 15501, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Gloom Band -- 25287
	AddRecipe(25287, 70, 20823, 1, 1, 70, 100, 115, 130)
	self:addTradeFlags(RecipeDB, 25287, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 25287, 1, 15501, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Heavy Silver Ring -- 25305
	AddRecipe(25305, 90, 20826, 1, 1, 90, 120, 135, 150)
	self:addTradeFlags(RecipeDB, 25305, F_ALLIANCE, F_HORDE, 3, 36, 41, 62)
	self:addTradeAcquire(RecipeDB, 25305, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Ring of Silver Might -- 25317
	AddRecipe(25317, 80, 20827, 1, 1, 80, 110, 125, 140)
	self:addTradeFlags(RecipeDB, 25317, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 62)
	self:addTradeAcquire(RecipeDB, 25317, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Ring of Twilight Shadows -- 25318
	AddRecipe(25318, 100, 20828, 1, 1, 100, 130, 145, 160)
	self:addTradeFlags(RecipeDB, 25318, F_ALLIANCE, F_HORDE, 3, 36, 41, 62)
	self:addTradeAcquire(RecipeDB, 25318, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26960, 1, 33680)

	-- Heavy Golden Necklace of Battle -- 25320
	AddRecipe(25320, 150, 20856, 1, 1, 150, 180, 195, 210)
	self:addTradeFlags(RecipeDB, 25320, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 40, 51, 63)
	self:addTradeAcquire(RecipeDB, 25320, 2, 1286, 2, 3367, 2, 16624, 2, 17512)

	-- Moonsoul Crown -- 25321
	AddRecipe(25321, 120, 20832, 1, 1, 120, 150, 165, 180)
	self:addTradeFlags(RecipeDB, 25321, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 56)
	self:addTradeAcquire(RecipeDB, 25321, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Wicked Moonstone Ring -- 25323
	AddRecipe(25323, 125, 20833, 1, 1, 125, 155, 170, 185)
	self:addTradeFlags(RecipeDB, 25323, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 40, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 25323, 2, 3499, 2, 3954)

	-- Amulet of the Moon -- 25339
	AddRecipe(25339, 110, 20830, 1, 1, 110, 140, 155, 170)
	self:addTradeFlags(RecipeDB, 25339, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 40, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 25339, 2, 4229, 2, 4561, 2, 16624, 2, 17512)

	-- Solid Bronze Ring -- 25490
	AddRecipe(25490, 50, 20907, 1, 1,50, 80, 95, 110)
	self:addTradeFlags(RecipeDB, 25490, F_ALLIANCE, F_HORDE, 3, 36, 41, 62)
	self:addTradeAcquire(RecipeDB, 25490, 1, 15501, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Braided Copper Ring -- 25493
	AddRecipe(25493, 1, 20906, 2, 1, 1, 30, 45, 60)
	self:addTradeFlags(RecipeDB, 25493, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 25493, 8, 8)

	-- Barbaric Iron Collar -- 25498
	AddRecipe(25498, 110, 20909, 1, 1, 110, 140, 155, 170)
	self:addTradeFlags(RecipeDB, 25498, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 63)
	self:addTradeAcquire(RecipeDB, 25498, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Pendant of the Agate Shield -- 25610
	AddRecipe(25610, 120, 20950, 1, 1, 120, 150, 165, 180)
	self:addTradeFlags(RecipeDB, 25610, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 40, 52, 63)
	self:addTradeAcquire(RecipeDB, 25610, 2, 1448, 2, 4877)

	-- Heavy Iron Knuckles -- 25612
	AddRecipe(25612, 125, 20954, 1, 1, 125, 155, 170, 185)
	self:addTradeFlags(RecipeDB, 25612, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 40, 51, 66, 79)
	self:addTradeAcquire(RecipeDB, 25612, 2, 2381, 2, 2393)

	-- Golden Dragon Ring -- 25613
	AddRecipe(25613, 135, 20955, 1, 1, 135, 165, 180, 195)
	self:addTradeFlags(RecipeDB, 25613, F_ALLIANCE, F_HORDE, 3, 36, 41, 52, 62)
	self:addTradeAcquire(RecipeDB, 25613, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Mithril Filigree -- 25615
	AddRecipe(25615, 150, 20963, 1, 1, 150, 170, 180, 190)
	self:addTradeFlags(RecipeDB, 25615, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 25615, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Blazing Citrine Ring -- 25617
	AddRecipe(25617, 150, 20958, 1, 1, 150, 180, 195, 210)
	self:addTradeFlags(RecipeDB, 25617, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 40, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 25617, 2, 2381, 2, 9636)

	-- Jade Pendant of Blasting -- 25618
	AddRecipe(25618, 160, 20966, 2, 1, 160, 190, 205, 220)
	self:addTradeFlags(RecipeDB, 25618, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 25618, 7, 2)

	-- The Jade Eye -- 25619
	AddRecipe(25619, 170, 20959, 1, 1, 170, 200, 215, 230)
	self:addTradeFlags(RecipeDB, 25619, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 40, 52, 62)
	self:addTradeAcquire(RecipeDB, 25619, 2, 4775, 2, 5163, 2, 16624, 2, 17512)

	-- Engraved Truesilver Ring -- 25620
	AddRecipe(25620, 170, 20960, 1, 1, 170, 200, 215, 230)
	self:addTradeFlags(RecipeDB, 25620, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 25620, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Citrine Ring of Rapid Healing -- 25621
	AddRecipe(25621, 180, 20961, 1, 1, 180, 210, 225, 240)
	self:addTradeFlags(RecipeDB, 25621, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 25621, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Citrine Pendant of Golden Healing -- 25622
	AddRecipe(25622, 190, 20967, 2, 1, 190, 220, 235, 250)
	self:addTradeFlags(RecipeDB, 25622, F_ALLIANCE, F_HORDE, 10, 36, 41, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 25622, 7, 2)

	-- Figurine - Jade Owl -- 26872
	AddRecipe(26872, 200, 21748, 1, 1, 200, 225, 240, 255)
	self:addTradeFlags(RecipeDB, 26872, F_ALLIANCE, F_HORDE, 3, 37, 41, 53, 54, 61)
	self:addTradeAcquire(RecipeDB, 26872, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Figurine - Golden Hare -- 26873
	AddRecipe(26873, 200, 21756, 2, 1, 200, 225, 240, 255)
	self:addTradeFlags(RecipeDB, 26873, F_ALLIANCE, F_HORDE, 10, 37, 40, 61)
	self:addTradeAcquire(RecipeDB, 26873, 7, 2)

	-- Aquamarine Signet -- 26874
	AddRecipe(26874, 210, 20964, 1, 1, 210, 235, 250, 265)
	self:addTradeFlags(RecipeDB, 26874, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 62)
	self:addTradeAcquire(RecipeDB, 26874, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Figurine - Black Pearl Panther -- 26875
	AddRecipe(26875, 215, 21758, 1, 1, 215, 240, 255, 270)
	self:addTradeFlags(RecipeDB, 26875, F_ALLIANCE, F_HORDE, F_VENDOR, 37, 40, 51, 61)
	self:addTradeAcquire(RecipeDB, 26875, 2, 989, 2, 4897)

	-- Aquamarine Pendant of the Warrior -- 26876
	AddRecipe(26876, 220, 21755, 1, 1, 220, 245, 260, 275)
	self:addTradeFlags(RecipeDB, 26876, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 63)
	self:addTradeAcquire(RecipeDB, 26876, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Ruby Crown of Restoration -- 26878
	AddRecipe(26878, 225, 20969, 1, 1, 225, 250, 265, 280)
	self:addTradeFlags(RecipeDB, 26878, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 40, 53, 54, 56)
	self:addTradeAcquire(RecipeDB, 26878, 2, 2810, 2, 2821)

	-- Thorium Setting -- 26880
	AddRecipe(26880, 225, 21752, 1, 1, 225, 235, 245, 255)
	self:addTradeFlags(RecipeDB, 26880, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 26880, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Figurine - Truesilver Crab -- 26881
	AddRecipe(26881, 225, 21760, 1, 1, 225, 250, 265, 280)
	self:addTradeFlags(RecipeDB, 26881, F_ALLIANCE, F_HORDE, F_VENDOR, 37, 40, 52, 61)
	self:addTradeAcquire(RecipeDB, 26881, 2, 1148, 2, 4897)

	-- Figurine - Truesilver Boar -- 26882
	AddRecipe(26882, 235, 21763, 2, 1, 235, 260, 275, 290)
	self:addTradeFlags(RecipeDB, 26882, F_ALLIANCE, F_HORDE, 10, 37, 40, 51, 61)
	self:addTradeAcquire(RecipeDB, 26882, 7, 2)

	-- Ruby Pendant of Fire -- 26883
	AddRecipe(26883, 235, 21764, 1, 1, 235, 260, 275, 290)
	self:addTradeFlags(RecipeDB, 26883, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 26883, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Truesilver Healing Ring -- 26885
	AddRecipe(26885, 240, 21765, 1, 1, 240, 265, 280, 295)
	self:addTradeFlags(RecipeDB, 26885, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 26885, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- The Aquamarine Ward -- 26887
	AddRecipe(26887, 245, 21754, 2, 1, 245, 270, 285, 300)
	self:addTradeFlags(RecipeDB, 26887, F_ALLIANCE, F_HORDE, 10, 36, 40, 52, 62)
	self:addTradeAcquire(RecipeDB, 26887, 7, 2)

	-- Gem Studded Band -- 26896
	AddRecipe(26896, 250, 21753, 2, 1, 250, 275, 290, 305)
	self:addTradeFlags(RecipeDB, 26896, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 26896, 7, 2)

	-- Opal Necklace of Impact -- 26897
	AddRecipe(26897, 250, 21766, 1, 1, 250, 275, 290, 305)
	self:addTradeFlags(RecipeDB, 26897, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 40, 51, 63)
	self:addTradeAcquire(RecipeDB, 26897, 2, 5163, 2, 8363, 2, 16624, 2, 17512)

	-- Figurine - Ruby Serpent -- 26900
	AddRecipe(26900, 260, 21769, 2, 1, 260, 280, 290, 300)
	self:addTradeFlags(RecipeDB, 26900, F_ALLIANCE, F_HORDE, 10, 37, 40, 53, 54, 61)
	self:addTradeAcquire(RecipeDB, 26900, 7, 2)

	-- Simple Opal Ring -- 26902
	AddRecipe(26902, 260, 21767, 1, 1, 260, 280, 290, 300)
	self:addTradeFlags(RecipeDB, 26902, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 62)
	self:addTradeAcquire(RecipeDB, 26902, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Sapphire Signet -- 26903
	AddRecipe(26903, 275, 21768, 1, 1, 275, 285, 295, 305)
	self:addTradeFlags(RecipeDB, 26903, F_ALLIANCE, F_HORDE, 3, 36, 41, 62)
	self:addTradeAcquire(RecipeDB, 26903, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Emerald Crown of Destruction -- 26906
	AddRecipe(26906, 275, 21774, 1, 1, 275, 285, 295, 305)
	self:addTradeFlags(RecipeDB, 26906, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 40, 53, 54, 56)
	self:addTradeAcquire(RecipeDB, 26906, 2, 15179)

	-- Onslaught Ring -- 26907
	AddRecipe(26907, 280, 21775, 1, 1, 280, 290, 300, 310)
	self:addTradeFlags(RecipeDB, 26907, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 62)
	self:addTradeAcquire(RecipeDB, 26907, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Sapphire Pendant of Winter Night -- 26908
	AddRecipe(26908, 280, 21790, 1, 1, 280, 290, 300, 310)
	self:addTradeFlags(RecipeDB, 26908, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 26908, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Figurine - Emerald Owl -- 26909
	AddRecipe(26909, 285, 21777, 2, 1, 285, 295, 305, 315)
	self:addTradeFlags(RecipeDB, 26909, F_ALLIANCE, F_HORDE, 10, 37, 40, 53, 54, 61)
	self:addTradeAcquire(RecipeDB, 26909, 7, 2)

	-- Ring of Bitter Shadows -- 26910
	AddRecipe(26910, 285, 21778, 1, 1, 285, 295, 305, 315)
	self:addTradeFlags(RecipeDB, 26910, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 40, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 26910, 2, 12941)

	-- Living Emerald Pendant -- 26911
	AddRecipe(26911, 290, 21791, 1, 1, 290, 300, 310, 320)
	self:addTradeFlags(RecipeDB, 26911, F_ALLIANCE, F_HORDE, 3, 37, 41, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 26911, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Figurine - Black Diamond Crab -- 26912
	AddRecipe(26912, 300, 21784, 2, 1, 300, 310, 320, 330)
	self:addTradeFlags(RecipeDB, 26912, F_ALLIANCE, F_HORDE, 5, 11, 37, 41, 52, 61)
	self:addTradeAcquire(RecipeDB, 26912, 3, 9736)

	-- Figurine - Dark Iron Scorpid -- 26914
	AddRecipe(26914, 300, 21789, 2, 1, 300, 310, 320, 330)
	self:addTradeFlags(RecipeDB, 26914, F_ALLIANCE, F_HORDE, 5, 37, 41, 51, 61)
	self:addTradeAcquire(RecipeDB, 26914, 3, 8983)

	-- Necklace of the Diamond Tower -- 26915
	AddRecipe(26915, 305, 21792, 1, 1, 305, 315, 325, 335)
	self:addTradeFlags(RecipeDB, 26915, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 40, 52, 63)
	self:addTradeAcquire(RecipeDB, 26915, 2, 11189)

	-- Band of Natural Fire -- 26916
	AddRecipe(26916, 310, 21779, 1, 1, 310, 320, 330, 340)
	self:addTradeFlags(RecipeDB, 26916, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 26916, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Woven Copper Ring -- 26925
	AddRecipe(26925, 1, 21931, 2, 1, 1, 30, 45, 60)
	self:addTradeFlags(RecipeDB, 26925, F_ALLIANCE, F_HORDE, 3, 36, 41, 62)
	self:addTradeAcquire(RecipeDB, 26925, 8, 8)

	-- Heavy Copper Ring -- 26926
	AddRecipe(26926, 5, 21932, 1, 1, 5, 35, 50, 65)
	self:addTradeFlags(RecipeDB, 26926, F_ALLIANCE, F_HORDE, 3, 36, 41, 62)
	self:addTradeAcquire(RecipeDB, 26926, 1, 15501, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Thick Bronze Necklace -- 26927
	AddRecipe(26927, 50, 21933, 1, 1, 50, 80, 95, 110)
	self:addTradeFlags(RecipeDB, 26927, F_ALLIANCE, F_HORDE, 3, 36, 41, 63)
	self:addTradeAcquire(RecipeDB, 26927, 1, 15501, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Ornate Tigerseye Necklace -- 26928
	AddRecipe(26928, 30, 21934, 1, 1, 30, 60, 75, 90)
	self:addTradeFlags(RecipeDB, 26928, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 26928, 1, 15501, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Teardrop Blood Garnet -- 28903
	AddRecipe(28903, 300, 23094, 1, 1, 300, 300, 320, 340)
	self:addTradeFlags(RecipeDB, 28903, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 28903, 1, 26997, 1, 26960, 1, 26982, 1, 19063, 1, 19539, 1, 18751, 1, 26915, 1, 18774, 1, 28701, 1, 33590, 1, 33614, 1, 33680)

	-- Bold Blood Garnet -- 28905
	AddRecipe(28905, 305, 23095, 1, 1, 305, 305, 325, 345)
	self:addTradeFlags(RecipeDB, 28905, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 28905, 1, 26997, 1, 26960, 1, 26982, 1, 19063, 1, 19539, 1, 18751, 1, 26915, 1, 18774, 1, 28701, 1, 33590, 1, 33614, 1, 33680)

	-- Runed Blood Garnet -- 28906
	AddRecipe(28906, 315, 23096, 2, 1, 315, 315, 335, 355)
	self:addTradeFlags(RecipeDB, 28906, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 53, 54, 110)
	self:addTradeAcquire(RecipeDB, 28906, 6, 934, 1, 19331)

	-- Delicate Blood Garnet -- 28907
	AddRecipe(28907, 325, 23097, 2, 1, 325, 325, 340, 355)
	self:addTradeFlags(RecipeDB, 28907, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 51, 105)
	self:addTradeAcquire(RecipeDB, 28907, 6, 933, 2, 20242, 6, 933, 2, 23007)

	-- Inscribed Flame Spessarite -- 28910
	AddRecipe(28910, 300, 23098, 1, 1, 300, 300, 320, 340)
	self:addTradeFlags(RecipeDB, 28910, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 28910, 1, 26997, 1, 26960, 1, 26982, 1, 19063, 1, 19539, 1, 18751, 1, 26915, 1, 18774, 1, 28701, 1, 33590, 1, 33614, 1, 33680)

	-- Luminous Flame Spessarite -- 28912
	AddRecipe(28912, 305, 23099, 2, 1, 305, 305, 325, 345)
	self:addTradeFlags(RecipeDB, 28912, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 53, 54, 105)
	self:addTradeAcquire(RecipeDB, 28912, 6, 933, 1, 20242, 6, 933, 1, 23007)

	-- Glinting Flame Spessarite -- 28914
	AddRecipe(28914, 315, 23100, 1, 1, 315, 315, 335, 355)
	self:addTradeFlags(RecipeDB, 28914, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 28914, 1, 26997, 1, 26960, 1, 26982, 1, 19063, 1, 19539, 1, 18751, 1, 26915, 1, 18774, 1, 28701, 1, 33590, 1, 33614, 1, 33680)

	-- Potent Flame Spessarite -- 28915
	AddRecipe(28915, 325, 23101, 2, 1, 325, 325, 340, 355)
	self:addTradeFlags(RecipeDB, 28915, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 53, 54, 107)
	self:addTradeAcquire(RecipeDB, 28915, 6, 1011, 1, 21655)

	-- Radiant Deep Peridot -- 28916
	AddRecipe(28916, 300, 23103, 1, 1, 300, 300, 320, 340)
	self:addTradeFlags(RecipeDB, 28916, F_ALLIANCE, F_HORDE, 3, 36, 41, 54)
	self:addTradeAcquire(RecipeDB, 28916, 1, 26997, 1, 26960, 1, 26982, 1, 19063, 1, 19539, 1, 18751, 1, 26915, 1, 18774, 1, 28701, 1, 33590, 1, 33614, 1, 33680)

	-- Jagged Deep Peridot -- 28917
	AddRecipe(28917, 305, 23104, 1, 1, 305, 305, 325, 345)
	self:addTradeFlags(RecipeDB, 28917, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 28917, 1, 26997, 1, 26960, 1, 26982, 1, 19063, 1, 19539, 1, 18751, 1, 26915, 1, 18774, 1, 28701, 1, 33590, 1, 33614, 1, 33680)

	-- Enduring Deep Peridot -- 28918
	AddRecipe(28918, 315, 23105, 2, 1, 315, 315, 335, 355)
	self:addTradeFlags(RecipeDB, 28918, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 52, 104)
	self:addTradeAcquire(RecipeDB, 28918, 6, 946, 1, 17657, 6, 947, 1, 17585)

	-- Dazzling Deep Peridot -- 28924
	AddRecipe(28924, 325, 23106, 2, 1, 325, 325, 340, 355)
	self:addTradeFlags(RecipeDB, 28924, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 110)
	self:addTradeAcquire(RecipeDB, 28924, 6, 934, 2, 19331)

	-- Glowing Shadow Draenite -- 28925
	AddRecipe(28925, 300, 23108, 1, 1, 300, 300, 320, 340)
	self:addTradeFlags(RecipeDB, 28925, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 28925, 1, 26997, 1, 26960, 1, 26982, 1, 19063, 1, 19539, 1, 18751, 1, 26915, 1, 18774, 1, 28701, 1, 33590, 1, 33614, 1, 33680)

	-- Royal Shadow Draenite -- 28927
	AddRecipe(28927, 305, 23109, 2, 1, 305, 305, 325, 345)
	self:addTradeFlags(RecipeDB, 28927, F_ALLIANCE, F_VENDOR, 36, 41, 53, 54, 101)
	self:addTradeAcquire(RecipeDB, 28927, 6, 932, 2, 19321)

	-- Shifting Shadow Draenite -- 28933
	AddRecipe(28933, 315, 23110, 2, 1, 315, 315, 335, 355)
	self:addTradeFlags(RecipeDB, 28933, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 51, 105)
	self:addTradeAcquire(RecipeDB, 28933, 6, 933, 1, 20242, 6, 933, 1, 23007)

	-- Sovereign Shadow Draenite -- 28936
	AddRecipe(28936, 325, 23111, 2, 1, 325, 325, 340, 355)
	self:addTradeFlags(RecipeDB, 28936, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 28936, 1, 26997, 1, 26960, 1, 26982, 1, 19063, 1, 19539, 1, 18751, 1, 26915, 1, 18774, 1, 28701, 1, 33590, 1, 33614, 1, 33680)

	-- Brilliant Golden Draenite -- 28938
	AddRecipe(28938, 300, 23113, 1, 1, 300, 300, 320, 340)
	self:addTradeFlags(RecipeDB, 28938, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 28938, 1, 26997, 1, 26960, 1, 26982, 1, 19063, 1, 19539, 1, 18751, 1, 26915, 1, 18774, 1, 28701, 1, 33590, 1, 33614, 1, 33680)

	-- Gleaming Golden Draenite -- 28944
	AddRecipe(28944, 305, 23114, 2, 1, 305, 305, 325, 345)
	self:addTradeFlags(RecipeDB, 28944, F_ALLIANCE, F_VENDOR, 36, 41, 101)
	self:addTradeAcquire(RecipeDB, 28944, 6, 932, 1, 19321)

	-- Thick Golden Draenite -- 28947
	AddRecipe(28947, 315, 23115, 2, 1, 315, 315, 335, 355)
	self:addTradeFlags(RecipeDB, 28947, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 52, 105)
	self:addTradeAcquire(RecipeDB, 28947, 6, 933, 2, 20242, 6, 933, 2, 23007)

	-- Rigid Golden Draenite -- 28948
	AddRecipe(28948, 325, 23116, 2, 1, 325, 325, 340, 355)
	self:addTradeFlags(RecipeDB, 28948, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 28948, 1, 26997, 1, 26960, 1, 26982, 1, 19063, 1, 19539, 1, 18751, 1, 26915, 1, 18774, 1, 28701, 1, 33590, 1, 33614, 1, 33680)

	-- Solid Azure Moonstone -- 28950
	AddRecipe(28950, 300, 23118, 1, 1, 300, 300, 320, 340)
	self:addTradeFlags(RecipeDB, 28950, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 28950, 1, 26997, 1, 26960, 1, 26982, 1, 19063, 1, 19539, 1, 18751, 1, 26915, 1, 18774, 1, 28701, 1, 33590, 1, 33614, 1, 33680)

	-- Sparkling Azure Moonstone -- 28953
	AddRecipe(28953, 305, 23119, 2, 1, 305, 305, 325, 345)
	self:addTradeFlags(RecipeDB, 28953, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 28953, 1, 26997, 1, 26960, 1, 26982, 1, 19063, 1, 19539, 1, 18751, 1, 26915, 1, 18774, 1, 28701, 1, 33590, 1, 33614, 1, 33680)

	-- Stormy Azure Moonstone -- 28955 
	AddRecipe(28955, 315, 23120, 2, 1, 315, 315, 335, 355)
	self:addTradeFlags(RecipeDB, 28955, F_ALLIANCE, F_HORDE, 10, 36, 40, 54)
	self:addTradeAcquire(RecipeDB, 28955, 7, 2)

	-- Lustrous Azure Moonstone -- 28957
	AddRecipe(28957, 325, 23121, 2, 1, 325, 325, 340, 355)
	self:addTradeFlags(RecipeDB, 28957, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 53, 54, 105)
	self:addTradeAcquire(RecipeDB, 28957, 6, 933, 2, 20242, 6, 933, 2, 23007)

	-- Fel Iron Blood Ring -- 31048
	AddRecipe(31048, 310, 24074, 1, 1, 310, 320, 330, 340)
	self:addTradeFlags(RecipeDB, 31048, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 62)
	self:addTradeAcquire(RecipeDB, 31048, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Golden Draenite Ring -- 31049
	AddRecipe(31049, 310, 24075, 1, 1, 310, 320, 335, 350)
	self:addTradeFlags(RecipeDB, 31049, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 31049, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Azure Moonstone Ring -- 31050
	AddRecipe(31050, 320, 24076, 1, 1, 320, 330, 340, 350)
	self:addTradeFlags(RecipeDB, 31050, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 31050, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Thick Adamantite Necklace -- 31051
	AddRecipe(31051, 335, 24077, 1, 1, 335, 345, 355, 365)
	self:addTradeFlags(RecipeDB, 31051, F_ALLIANCE, F_HORDE, 3, 36, 41, 63)
	self:addTradeAcquire(RecipeDB, 31051, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Heavy Adamantite Ring -- 31052
	AddRecipe(31052, 335, 24078, 1, 1, 335, 345, 355, 365)
	self:addTradeFlags(RecipeDB, 31052, F_ALLIANCE, F_HORDE, 3, 36, 41, 62)
	self:addTradeAcquire(RecipeDB, 31052, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Khorium Band of Shadows -- 31053
	AddRecipe(31053, 350, 24079, 3, 1, 350, 360, 370, 380)
	self:addTradeFlags(RecipeDB, 31053, F_ALLIANCE, F_HORDE, 11, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 31053, 3, 19826)

	-- Khorium Band of Frost -- 31054
	AddRecipe(31054, 355, 24080, 3, 1, 355, 365, 372, 380)
	self:addTradeFlags(RecipeDB, 31054, F_ALLIANCE, F_HORDE, 5, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 31054, 3, 17722)

	-- Khorium Inferno Band -- 31055
	AddRecipe(31055, 355, 24082, 3, 1, 355, 365, 372, 380)
	self:addTradeFlags(RecipeDB, 31055, F_ALLIANCE, F_HORDE, 5, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 31055, 3, 18472)

	-- Khorium Band of Leaves -- 31056
	AddRecipe(31056, 360, 24085, 3, 1, 360, 370, 375, 380)
	self:addTradeFlags(RecipeDB, 31056, F_ALLIANCE, F_HORDE, 11, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 31056, 3, 19984)

	-- Arcane Khorium Band -- 31057
	AddRecipe(31057, 365, 24086, 3, 1, 365, 370, 375, 380)
	self:addTradeFlags(RecipeDB, 31057, F_ALLIANCE, F_HORDE, 11, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 31057, 3, 18866)

	-- Heavy Felsteel Ring -- 31058
	AddRecipe(31058, 345, 24087, 3, 1, 345, 355, 365, 375)
	self:addTradeFlags(RecipeDB, 31058, F_ALLIANCE, F_HORDE, 10, 36, 40, 51, 62)
	self:addTradeAcquire(RecipeDB, 31058, 7, 3)

	-- Delicate Eternium Ring -- 31060
	AddRecipe(31060, 355, 24088, 3, 1, 355, 365, 375, 385)
	self:addTradeFlags(RecipeDB, 31060, F_ALLIANCE, F_HORDE, 10, 36, 40, 52, 62)
	self:addTradeAcquire(RecipeDB, 31060, 7, 3)

	-- Blazing Eternium Band -- 31061
	AddRecipe(31061, 365, 24089, 3, 1, 365, 375, 377, 380)
	self:addTradeFlags(RecipeDB, 31061, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 31061, 7, 3)

	-- Pendant of Frozen Flame -- 31062
	AddRecipe(31062, 360, 24092, 3, 1, 360, 370, 375, 380)
	self:addTradeFlags(RecipeDB, 31062, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 63, 106)
	self:addTradeAcquire(RecipeDB, 31062, 6, 989, 3, 21643)

	-- Pendant of Thawing -- 31063
	AddRecipe(31063, 360, 24093, 3, 1, 360, 370, 375, 380)
	self:addTradeFlags(RecipeDB, 31063, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 63, 107)
	self:addTradeAcquire(RecipeDB, 31063, 6, 1011, 3, 21655)

	-- Pendant of Withering -- 31064
	AddRecipe(31064, 360, 24095, 3, 1, 360, 370, 375, 380)
	self:addTradeFlags(RecipeDB, 31064, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 63, 110)
	self:addTradeAcquire(RecipeDB, 31064, 6, 934, 3, 19331)

	-- Pendant of Shadow's End -- 31065
	AddRecipe(31065, 360, 24097, 3, 1, 360, 370, 375, 380)
	self:addTradeFlags(RecipeDB, 31065, 1, F_VENDOR, 36, 41, 63, 101)
	self:addTradeAcquire(RecipeDB, 31065, 6, 932, 3, 19321)

	-- Pendant of the Null Rune -- 31066
	AddRecipe(31066, 360, 24098, 3, 1, 360, 370, 375, 380)
	self:addTradeFlags(RecipeDB, 31066, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 63, 105)
	self:addTradeAcquire(RecipeDB, 31066, 6, 933, 3, 20242, 6, 933, 3, 23007)

	-- Thick Felsteel Necklace -- 31067
	AddRecipe(31067, 355, 24106, 3, 1, 355, 365, 375, 385)
	self:addTradeFlags(RecipeDB, 31067, F_ALLIANCE, F_HORDE, 10, 36, 40, 63)
	self:addTradeAcquire(RecipeDB, 31067, 7, 3)

	-- Living Ruby Pendant -- 31068
	AddRecipe(31068, 355, 24110, 3, 1, 355, 365, 375, 385)
	self:addTradeFlags(RecipeDB, 31068, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 31068, 7, 3)

	-- Braided Eternium Chain -- 31070
	AddRecipe(31070, 360, 24114, 3, 1, 360, 370, 377, 385)
	self:addTradeFlags(RecipeDB, 31070, F_ALLIANCE, F_HORDE, 10, 36, 40, 51, 63)
	self:addTradeAcquire(RecipeDB, 31070, 7, 3)

	-- Eye of the Night -- 31071 
	AddRecipe(31071, 360, 24116, 3, 1, 360, 370, 375, 380)
	self:addTradeFlags(RecipeDB, 31071, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 31071, 7, 3)

	-- Embrace of the Dawn -- 31072
	AddRecipe(31072, 365, 24117, 3, 1, 365, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 31072, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 31072, 7, 3)

	-- Chain of the Twilight Owl -- 31076
	AddRecipe(31076, 365, 24121, 3, 1, 365, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 31076, F_ALLIANCE, F_HORDE, 10, 36, 40, 52, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 31076, 7, 3)

	-- Coronet of Verdant Flame -- 31077
	AddRecipe(31077, 370, 24122, 4, 1, 370, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 31077, F_ALLIANCE, F_HORDE, 5, 11, 36, 41, 56)
	self:addTradeAcquire(RecipeDB, 31077, 3, 18422)

	-- Circlet of Arcane Might -- 31078
	AddRecipe(31078, 370, 24123, 4, 1, 370, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 31078, F_ALLIANCE, F_HORDE, 5, 36, 41, 53, 54, 56)
	self:addTradeAcquire(RecipeDB, 31078, 3, 18096)

	-- Figurine - Felsteel Boar -- 31079
	AddRecipe(31079, 370, 24124, 3, 1, 370, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 31079, F_ALLIANCE, F_HORDE, F_VENDOR, 37, 41, 51, 61, 107)
	self:addTradeAcquire(RecipeDB, 31079, 6, 1011, 3, 21655)

	-- Figurine - Dawnstone Crab -- 31080
	AddRecipe(31080, 370, 24125, 3, 1, 370, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 31080, F_ALLIANCE, F_HORDE, F_VENDOR, 37, 41, 52, 61, 104)
	self:addTradeAcquire(RecipeDB, 31080, 6, 946, 3, 17657, 6, 947, 3, 17585)

	-- Figurine - Living Ruby Serpent -- 31081
	AddRecipe(31081, 370, 24126, 3, 1, 370, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 31081, F_ALLIANCE, F_HORDE, F_VENDOR, 37, 41, 53, 54, 61, 106)
	self:addTradeAcquire(RecipeDB, 31081, 6, 989, 3, 21643)

	-- Figurine - Talasite Owl -- 31082
	AddRecipe(31082, 370, 24127, 3, 1, 370, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 31082, F_ALLIANCE, F_HORDE, F_VENDOR, 37, 41, 53, 54, 61, 111)
	self:addTradeAcquire(RecipeDB, 31082, 6, 935, 3, 21432)

	-- Figurine - Nightseye Panther -- 31083
	AddRecipe(31083, 370, 24128, 3, 1, 370, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 31083, F_ALLIANCE, F_HORDE, F_VENDOR, 37, 41, 51, 61, 103)
	self:addTradeAcquire(RecipeDB, 31083, 6, 942, 3, 17904)

	-- Bold Living Ruby -- 31084
	AddRecipe(31084, 350, 24027, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31084, F_ALLIANCE, F_HORDE, 10, 36, 40, 51)
	self:addTradeAcquire(RecipeDB, 31084, 7, 3)

	-- Delicate Living Ruby -- 31085
	AddRecipe(31085, 350, 24028, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31085, F_ALLIANCE, F_HORDE, 10, 36, 40, 51)
	self:addTradeAcquire(RecipeDB, 31085, 7, 3)

	-- Teardrop Living Ruby -- 31087
	AddRecipe(31087, 350, 24029, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31087, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54)
	self:addTradeAcquire(RecipeDB, 31087, 7, 3)

	-- Runed Living Ruby -- 31088
	AddRecipe(31088, 350, 24030, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31088, F_ALLIANCE, F_HORDE, 10, 11, 36, 40, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 31088, 3, 24664, 7, 3)

	-- Bright Living Ruby -- 31089
	AddRecipe(31089, 350, 24031, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31089, F_ALLIANCE, F_HORDE, 10, 11, 36, 40, 41, 51)
	self:addTradeAcquire(RecipeDB, 31089, 3, 24664, 7, 3)

	-- Subtle Living Ruby -- 31090
	AddRecipe(31090, 350, 24032, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31090, F_ALLIANCE, F_HORDE, 10, 36, 40, 52)
	self:addTradeAcquire(RecipeDB, 31090, 7, 3)

	-- Flashing Living Ruby -- 31091
	AddRecipe(31091, 350, 24036, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31091, F_ALLIANCE, F_HORDE, 10, 36, 40, 52)
	self:addTradeAcquire(RecipeDB, 31091, 7, 3)

	-- Solid Star of Elune -- 31092
	AddRecipe(31092, 350, 24033, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31092, F_ALLIANCE, F_HORDE, 10, 11, 36, 40, 41)
	self:addTradeAcquire(RecipeDB, 31092, 3, 24664, 7, 3)

	-- Lustrous Star of Elune -- 31094
	AddRecipe(31094, 350, 24037, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31094, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54)
	self:addTradeAcquire(RecipeDB, 31094, 7, 3)

	-- Stormy Star of Elune -- 31095
	AddRecipe(31095, 350, 24039, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31095, F_ALLIANCE, F_HORDE, 10, 36, 40, 54)
	self:addTradeAcquire(RecipeDB, 31095, 7, 3)

	-- Brilliant Dawnstone -- 31096
	AddRecipe(31096, 350, 24047, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31096, F_ALLIANCE, F_HORDE, 10, 36, 40)
	self:addTradeAcquire(RecipeDB, 31096, 7, 3)

	-- Smooth Dawnstone -- 31097
	AddRecipe(31097, 350, 24048, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31097, F_ALLIANCE, F_HORDE, 10, 36, 40)
	self:addTradeAcquire(RecipeDB, 31097, 7, 3)

	-- Rigid Dawnstone -- 31098
	AddRecipe(31098, 350, 24051, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31098, F_ALLIANCE, F_HORDE, 10, 11, 36, 40, 41)
	self:addTradeAcquire(RecipeDB, 31098, 3, 24664, 7, 3)

	-- Gleaming Dawnstone -- 31099
	AddRecipe(31099, 350, 24050, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31099, F_ALLIANCE, F_HORDE, 10, 36, 40)
	self:addTradeAcquire(RecipeDB, 31099, 7, 3)

	-- Thick Dawnstone -- 31100
	AddRecipe(31100, 350, 24052, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31100, F_ALLIANCE, F_HORDE, 10, 36, 40, 52)
	self:addTradeAcquire(RecipeDB, 31100, 7, 3)

	-- Mystic Dawnstone -- 31101
	AddRecipe(31101, 350, 24053, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31101, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41)
	self:addTradeAcquire(RecipeDB, 31101, 2, 21474, 2, 21485)

	-- Sovereign Nightseye -- 31102
	AddRecipe(31102, 350, 24054, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31102, F_ALLIANCE, F_HORDE, 10, 36, 40, 51)
	self:addTradeAcquire(RecipeDB, 31102, 7, 3)

	-- Shifting Nightseye -- 31103
	AddRecipe(31103, 350, 24055, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31103, F_ALLIANCE, F_HORDE, 10, 36, 40, 51)
	self:addTradeAcquire(RecipeDB, 31103, 7, 3)

	-- Glowing Nightseye -- 31104
	AddRecipe(31104, 350, 24056, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31104, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54)
	self:addTradeAcquire(RecipeDB, 31104, 7, 3)

	-- Royal Nightseye -- 31105
	AddRecipe(31105, 350, 24057, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31105, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54)
	self:addTradeAcquire(RecipeDB, 31105, 7, 3)

	-- Inscribed Noble Topaz -- 31106
	AddRecipe(31106, 350, 24058, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31106, F_ALLIANCE, F_HORDE, 10, 36, 40, 51)
	self:addTradeAcquire(RecipeDB, 31106, 7, 3)

	-- Potent Noble Topaz -- 31107
	AddRecipe(31107, 350, 24059, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31107, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54)
	self:addTradeAcquire(RecipeDB, 31107, 7, 3)

	-- Luminous Noble Topaz -- 31108
	AddRecipe(31108, 350, 24060, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31108, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54)
	self:addTradeAcquire(RecipeDB, 31108, 7, 3)

	-- Glinting Noble Topaz -- 31109
	AddRecipe(31109, 350, 24061, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31109, F_ALLIANCE, F_HORDE, 10, 36, 40, 51)
	self:addTradeAcquire(RecipeDB, 31109, 7, 3)

	-- Enduring Talasite -- 31110
	AddRecipe(31110, 350, 24062, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31110, F_ALLIANCE, F_HORDE, 10, 36, 40, 52)
	self:addTradeAcquire(RecipeDB, 31110, 7, 3)

	-- Radiant Talasite -- 31111
	AddRecipe(31111, 350, 24066, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31111, F_ALLIANCE, F_HORDE, 10, 36, 40, 54)
	self:addTradeAcquire(RecipeDB, 31111, 7, 3)

	-- Dazzling Talasite -- 31112
	AddRecipe(31112, 350, 24065, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31112, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54)
	self:addTradeAcquire(RecipeDB, 31112, 7, 3)

	-- Jagged Talasite -- 31113
	AddRecipe(31113, 350, 24067, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31113, F_ALLIANCE, F_HORDE, 10, 36, 40)
	self:addTradeAcquire(RecipeDB, 31113, 7, 3)

	-- Sparkling Star of Elune -- 31149
	AddRecipe(31149, 350, 24035, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 31149, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54)
	self:addTradeAcquire(RecipeDB, 31149, 7, 3)

	-- Malachite Pendant -- 32178
	AddRecipe(32178, 20, 25438, 1, 1, 20, 50, 65, 80)
	self:addTradeFlags(RecipeDB, 32178, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 63)
	self:addTradeAcquire(RecipeDB, 32178, 1, 15501, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Tigerseye Band -- 32179
	AddRecipe(32179, 20, 25439, 1, 1, 20, 50, 65, 80)
	self:addTradeFlags(RecipeDB, 32179, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 62)
	self:addTradeAcquire(RecipeDB, 32179, 1, 15501, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Rough Stone Statue -- 32259
	AddRecipe(32259, 1, 25498, 1, 1, 1, 30, 40, 50)
	self:addTradeFlags(RecipeDB, 32259, F_ALLIANCE, F_HORDE, 3, 37, 41)
	self:addTradeAcquire(RecipeDB, 32259, 8, 8)

	-- Coarse Stone Statue -- 32801
	AddRecipe(32801, 50, 25880, 1, 1, 50, 70, 80, 90)
	self:addTradeFlags(RecipeDB, 32801, F_ALLIANCE, F_HORDE, 3, 37, 41)
	self:addTradeAcquire(RecipeDB, 32801, 1, 15501, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Heavy Stone Statue -- 32807
	AddRecipe(32807, 110, 25881, 1, 1, 110, 120, 130, 140)
	self:addTradeFlags(RecipeDB, 32807, F_ALLIANCE, F_HORDE, 3, 37, 41)
	self:addTradeAcquire(RecipeDB, 32807, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Solid Stone Statue -- 32808
	AddRecipe(32808, 175, 25882, 1, 1, 175, 175, 185, 195)
	self:addTradeFlags(RecipeDB, 32808, F_ALLIANCE, F_HORDE, 3, 37, 41)
	self:addTradeAcquire(RecipeDB, 32808, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Dense Stone Statue -- 32809
	AddRecipe(32809, 225, 25883, 1, 1, 225, 225, 235, 245)
	self:addTradeFlags(RecipeDB, 32809, F_ALLIANCE, F_HORDE, 3, 37, 41)
	self:addTradeAcquire(RecipeDB, 32809, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Powerful Earthstorm Diamond -- 32866
	AddRecipe(32866, 365, 25896, 1, 1, 365, 375, 377, 380)
	self:addTradeFlags(RecipeDB, 32866, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 105)
	self:addTradeAcquire(RecipeDB, 32866, 6, 933, 2, 17518)

	-- Bracing Earthstorm Diamond -- 32867
	AddRecipe(32867, 365, 25897, 1, 1, 365, 375, 377, 380)
	self:addTradeFlags(RecipeDB, 32867, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 53, 54, 105)
	self:addTradeAcquire(RecipeDB, 32867, 6, 933, 3, 17518)

	-- Tenacious Earthstorm Diamond -- 32868
	AddRecipe(32868, 365, 25898, 3, 1, 365, 375, 377, 380)
	self:addTradeFlags(RecipeDB, 32868, F_ALLIANCE, F_HORDE, 10, 36, 40, 52)
	self:addTradeAcquire(RecipeDB, 32868, 7, 3)

	-- Brutal Earthstorm Diamond -- 32869
	AddRecipe(32869, 365, 25899, 3, 1, 365, 375, 377, 380)
	self:addTradeFlags(RecipeDB, 32869, F_ALLIANCE, F_HORDE, 10, 36, 40)
	self:addTradeAcquire(RecipeDB, 32869, 7, 3)

	-- Insightful Earthstorm Diamond -- 32870
	AddRecipe(32870, 365, 25901, 1, 1, 365, 375, 377, 380)
	self:addTradeFlags(RecipeDB, 32870, F_ALLIANCE, F_HORDE, F_VENDOR, F_IBOE, F_RBOP, F_CASTER, F_HEALER, 111)
	self:addTradeAcquire(RecipeDB, 32870, 6, 935, 1, 21432)

	-- Destructive Skyfire Diamond -- 32871
	AddRecipe(32871, 365, 25890, 3, 1, 365, 375, 377, 380)
	self:addTradeFlags(RecipeDB, 32871, F_ALLIANCE, F_HORDE, 10, 36, 40)
	self:addTradeAcquire(RecipeDB, 32871, 7, 3)

	-- Mystical Skyfire Diamond -- 32872
	AddRecipe(32872, 365, 25893, 3, 1, 365, 375, 377, 380)
	self:addTradeFlags(RecipeDB, 32872, F_ALLIANCE, F_HORDE, 10, 36, 40)
	self:addTradeAcquire(RecipeDB, 32872, 7, 3)

	-- Swift Skyfire Diamond -- 32873
	AddRecipe(32873, 365, 25894, 1, 1, 365, 375, 377, 380)
	self:addTradeFlags(RecipeDB, 32873, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 51, 105)
	self:addTradeAcquire(RecipeDB, 32873, 6, 933, 2, 20242, 6, 933, 2, 23007)

	-- Enigmatic Skyfire Diamond -- 32874
	AddRecipe(32874, 365, 25895, 1, 1, 365, 375, 377, 380)
	self:addTradeFlags(RecipeDB, 32874, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 106)
	self:addTradeAcquire(RecipeDB, 32874, 6, 989, 2, 21643)

	-- Smooth Golden Draenite -- 34069
	AddRecipe(34069, 325, 28290, 2, 1, 325, 325, 340, 355)
	self:addTradeFlags(RecipeDB, 34069, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 34069, 1, 26997, 1, 26960, 1, 26982, 1, 19063, 1, 19539, 1, 18751, 1, 26915, 1, 18774, 1, 28701, 1, 33590, 1, 33614, 1, 33680)

	-- Bright Blood Garnet -- 34590
	AddRecipe(34590, 305, 28595, 1, 1, 305, 305, 325, 345)
	self:addTradeFlags(RecipeDB, 34590, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 34590, 1, 26997, 1, 26960, 1, 26982, 1, 19063, 1, 19539, 1, 18751, 1, 26915, 1, 18774, 1, 28701, 1, 33590, 1, 33614, 1, 33680)

	-- Golden Ring of Power -- 34955
	AddRecipe(34955, 180, 29157, 1, 1, 180, 190, 200, 210)
	self:addTradeFlags(RecipeDB, 34955, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 34955, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Truesilver Commander's Ring -- 34959
	AddRecipe(34959, 200, 29158, 1, 1, 200, 210, 220, 230)
	self:addTradeFlags(RecipeDB, 34959, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 62)
	self:addTradeAcquire(RecipeDB, 34959, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Glowing Thorium Band -- 34960
	AddRecipe(34960, 280, 29159, 1, 1, 280, 290, 300, 310)
	self:addTradeFlags(RecipeDB, 34960, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 34960, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Emerald Lion Ring -- 34961
	AddRecipe(34961, 290, 29160, 1, 1, 290, 300, 310, 320)
	self:addTradeFlags(RecipeDB, 34961, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 34961, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Brilliant Necklace -- 36523
	AddRecipe(36523, 75, 30419, 1, 1, 75, 105, 120, 135)
	self:addTradeFlags(RecipeDB, 36523, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 36523, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Heavy Jade Ring -- 36524
	AddRecipe(36524, 105, 30420, 1, 1, 105, 135, 150, 165)
	self:addTradeFlags(RecipeDB, 36524, F_ALLIANCE, F_HORDE, 3, 36, 41, 62)
	self:addTradeAcquire(RecipeDB, 36524, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Red Ring of Destruction -- 36525
	AddRecipe(36525, 230, 30421, 1, 1, 230, 255, 270, 285)
	self:addTradeFlags(RecipeDB, 36525, F_ALLIANCE, F_HORDE, 3, 36, 41, 62)
	self:addTradeAcquire(RecipeDB, 36525, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Diamond Focus Ring -- 36526
	AddRecipe(36526, 265, 30422, 1, 1, 265, 285, 295, 305)
	self:addTradeFlags(RecipeDB, 36526, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 36526, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Bronze Band of Force -- 37818
	AddRecipe(37818, 65, 30804, 1, 1, 65, 95, 110, 125)
	self:addTradeFlags(RecipeDB, 37818, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 37818, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Ring of Arcane Shielding -- 37855
	AddRecipe(37855, 360, 30825, 3, 1, 360, 370, 375, 380)
	self:addTradeFlags(RecipeDB, 37855, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 62, 111)
	self:addTradeAcquire(RecipeDB, 37855, 6, 935, 2, 21432)

	-- Mercurial Adamantite -- 38068
	AddRecipe(38068, 325, 31079, 1, 1, 325, 325, 335, 345)
	self:addTradeFlags(RecipeDB, 38068, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 38068, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Bronze Torc -- 38175
	AddRecipe(38175, 80, 31154, 1, 1, 80, 110, 125, 140)
	self:addTradeFlags(RecipeDB, 38175, F_ALLIANCE, F_HORDE, 3, 36, 41, 63)
	self:addTradeAcquire(RecipeDB, 38175, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 19775, 1, 19778, 1, 28701, 1, 15501, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- The Frozen Eye -- 38503
	AddRecipe(38503, 375, 31398, 4, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 38503, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 62, 114)
	self:addTradeAcquire(RecipeDB, 38503, 6, 967, 2, 18255)

	-- The Natural Ward -- 38504
	AddRecipe(38504, 375, 31399, 4, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 38504, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 62, 103)
	self:addTradeAcquire(RecipeDB, 38504, 6, 942, 4, 17904)

	-- Great Golden Draenite -- 39451
	AddRecipe(39451, 325, 31860, 2, 1, 325, 325, 340, 355)
	self:addTradeFlags(RecipeDB, 39451, F_ALLIANCE, F_HORDE, 11, 36, 40)
	self:addTradeAcquire(RecipeDB, 39451, 8, 35)

	-- Great Dawnstone -- 39452
	AddRecipe(39452, 350, 31861, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 39452, F_ALLIANCE, F_HORDE, 10, 36, 40)
	self:addTradeAcquire(RecipeDB, 39452, 7, 3)

	-- Balanced Shadow Draenite -- 39455
	AddRecipe(39455, 325, 31862, 2, 1, 325, 325, 340, 355)
	self:addTradeFlags(RecipeDB, 39455, F_ALLIANCE, F_HORDE, 11, 36, 40, 51)
	self:addTradeAcquire(RecipeDB, 39455, 8, 35)

	-- Infused Shadow Draenite -- 39458
	AddRecipe(39458, 325, 31864, 2, 1, 325, 325, 340, 355)
	self:addTradeFlags(RecipeDB, 39458, F_ALLIANCE, F_HORDE, 11, 36, 40, 51, 53, 54)
	self:addTradeAcquire(RecipeDB, 39458, 8, 35)

	-- Infused Nightseye -- 39462
	AddRecipe(39462, 350, 31865, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 39462, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54)
	self:addTradeAcquire(RecipeDB, 39462, 7, 3)

	-- Balanced Nightseye -- 39463
	AddRecipe(39463, 350, 31863, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 39463, F_ALLIANCE, F_HORDE, 10, 36, 40, 51)
	self:addTradeAcquire(RecipeDB, 39463, 7, 3)

	-- Veiled Flame Spessarite -- 39466
	AddRecipe(39466, 325, 31866, 2, 1, 325, 325, 340, 355)
	self:addTradeFlags(RecipeDB, 39466, F_ALLIANCE, F_HORDE, 11, 36, 40, 53, 54)
	self:addTradeAcquire(RecipeDB, 39466, 8, 35)

	-- Wicked Flame Spessarite -- 39467
	AddRecipe(39467, 325, 31869, 2, 1, 325, 325, 340, 355)
	self:addTradeFlags(RecipeDB, 39467, F_ALLIANCE, F_HORDE, 11, 36, 40, 51)
	self:addTradeAcquire(RecipeDB, 39467, 8, 35)

	-- Veiled Noble Topaz -- 39470
	AddRecipe(39470, 350, 31867, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 39470, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54)
	self:addTradeAcquire(RecipeDB, 39470, 7, 3)

	-- Wicked Noble Topaz -- 39471
	AddRecipe(39471, 350, 31868, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 39471, F_ALLIANCE, F_HORDE, 10, 36, 40, 51)
	self:addTradeAcquire(RecipeDB, 39471, 7, 3)

	-- Bold Crimson Spinel -- 39705
	AddRecipe(39705, 375, 32193, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39705, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 51, 109, 112)
	self:addTradeAcquire(RecipeDB, 39705, 6, 1077, 1, 25950, 6, 1077, 1, 27666, 6, 990, 1, 23437)

	-- Delicate Crimson Spinel -- 39706
	AddRecipe(39706, 375, 32194, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39706, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 51, 109, 112)
	self:addTradeAcquire(RecipeDB, 39706, 6, 1077, 1, 25950, 6, 990, 1, 23437, 6, 1077, 1, 27666)

	-- Teardrop Crimson Spinel -- 39710
	AddRecipe(39710, 375, 32195, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39710, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 53, 54, 109, 112)
	self:addTradeAcquire(RecipeDB, 39710, 6, 1077, 1, 25950, 6, 1077, 1, 27666, 6, 990, 1, 23437)

	-- Runed Crimson Spinel -- 39711
	AddRecipe(39711, 375, 32196, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39711, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 53, 54, 109, 112)
	self:addTradeAcquire(RecipeDB, 39711, 6, 1077, 1, 25950, 6, 1077, 1, 27666, 6, 990, 1, 23437)

	-- Bright Crimson Spinel -- 39712
	AddRecipe(39712, 375, 32197, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39712, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 51, 109, 112)
	self:addTradeAcquire(RecipeDB, 39712, 6, 1077, 1, 25950, 6, 1077, 1, 27666, 6, 990, 1, 23437)

	-- Subtle Crimson Spinel -- 39713
	AddRecipe(39713, 375, 32198, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39713, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 52, 109, 112)
	self:addTradeAcquire(RecipeDB, 39713, 6, 1077, 1, 25950, 6, 1077, 1, 27666, 6, 990, 1, 23437)

	-- Flashing Crimson Spinel -- 39714
	AddRecipe(39714, 375, 32199, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39714, F_ALLIANCE, F_HORDE, F_VENDOR, 6, 36, 41, 52, 112)
	self:addTradeAcquire(RecipeDB, 39714, 8, 27, 8, 34, 6, 1077, 4, 27666, 6, 1077, 4, 25950)

	-- Solid Empyrean Sapphire -- 39715
	AddRecipe(39715, 375, 32200, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39715, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 109, 112)
	self:addTradeAcquire(RecipeDB, 39715, 6, 1077, 1, 25950, 6, 1077, 1, 27666, 6, 990, 1, 23437)

	-- Sparkling Empyrean Sapphire -- 39716
	AddRecipe(39716, 375, 32201, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39716, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 53, 54, 109, 112)
	self:addTradeAcquire(RecipeDB, 39716, 6, 1077, 1, 25950, 6, 1077, 1, 27666, 6, 990, 1, 23437)

	-- Lustrous Empyrean Sapphire -- 39717
	AddRecipe(39717, 375, 32202, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39717, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 53, 54, 109, 112)
	self:addTradeAcquire(RecipeDB, 39717, 6, 1077, 1, 25950, 6, 1077, 1, 27666, 6, 990, 1, 23437)

	-- Stormy Empyrean Sapphire -- 39718
	AddRecipe(39718, 375, 32203, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39718, F_ALLIANCE, F_HORDE, F_VENDOR, 6, 36, 41, 54, 112)
	self:addTradeAcquire(RecipeDB, 39718, 8, 27, 8, 34, 6, 1077, 4, 27666, 6, 1077, 4, 25950)

	-- Brilliant Lionseye -- 39719
	AddRecipe(39719, 375, 32204, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39719, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 109, 112)
	self:addTradeAcquire(RecipeDB, 39719, 6, 1077, 1, 25950, 6, 990, 1, 23437, 6, 1077, 1, 27666)

	-- Smooth Lionseye -- 39720
	AddRecipe(39720, 375, 32205, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39720, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 109, 112)
	self:addTradeAcquire(RecipeDB, 39720, 6, 1077, 1, 25950, 6, 1077, 1, 27666, 6, 990, 1, 23437)

	-- Rigid Lionseye -- 39721
	AddRecipe(39721, 375, 32206, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39721, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 109, 112)
	self:addTradeAcquire(RecipeDB, 39721, 6, 1077, 3, 25950, 6, 990, 3, 23437, 6, 1077, 3, 27666)

	-- Gleaming Lionseye -- 39722
	AddRecipe(39722, 375, 32207, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39722, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 109, 112)
	self:addTradeAcquire(RecipeDB, 39722, 6, 1077, 1, 25950, 6, 1077, 1, 27666, 6, 990, 1, 23437)

	-- Thick Lionseye -- 39723
	AddRecipe(39723, 375, 32208, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39723, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 52, 109, 112)
	self:addTradeAcquire(RecipeDB, 39723, 6, 1077, 1, 25950, 6, 1077, 1, 27666, 6, 990, 1, 23437)

	-- Mystic Lionseye -- 39724
	AddRecipe(39724, 375, 32209, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39724, F_ALLIANCE, F_HORDE, F_VENDOR, 6, 36, 41, 112)
	self:addTradeAcquire(RecipeDB, 39724, 8, 27, 8, 34, 6, 1077, 4, 27666, 6, 1077, 4, 25950)

	-- Great Lionseye -- 39725
	AddRecipe(39725, 375, 32210, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39725, F_ALLIANCE, F_HORDE, F_VENDOR, 6, 36, 41, 112)
	self:addTradeAcquire(RecipeDB, 39725, 8, 27, 8, 34, 6, 1077, 4, 27666, 6, 1077, 4, 25950)

	-- Sovereign Shadowsong Amethyst -- 39727
	AddRecipe(39727, 375, 32211, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39727, F_ALLIANCE, F_HORDE, F_VENDOR, 6, 36, 41, 51, 112)
	self:addTradeAcquire(RecipeDB, 39727, 8, 27, 8, 34, 6, 1077, 4, 27666, 6, 1077, 4, 25950)

	-- Shifting Shadowsong Amethyst -- 39728
	AddRecipe(39728, 375, 32212, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39728, F_ALLIANCE, F_HORDE, F_VENDOR, 6, 36, 41, 51, 112)
	self:addTradeAcquire(RecipeDB, 39728, 8, 27, 8, 34, 6, 1077, 4, 27666, 6, 1077, 4, 25950)

	-- Balanced Shadowsong Amethyst -- 39729
	AddRecipe(39729, 375, 32213, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39729, F_ALLIANCE, F_HORDE, F_VENDOR, 36, 41, 51, 109, 112)
	self:addTradeAcquire(RecipeDB, 39729, 6, 1077, 2, 25950, 6, 990, 2, 23437, 6, 1077, 2, 27666)

	-- Infused Shadowsong Amethyst -- 39730
	AddRecipe(39730, 375, 32214, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39730, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 109, 112)
	self:addTradeAcquire(RecipeDB, 39730, 6, 1077, 2, 25950, 6, 990, 2, 23437, 6, 1077, 2, 27666)

	-- Glowing Shadowsong Amethyst -- 39731
	AddRecipe(39731, 375, 32215, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39731, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 109, 112)
	self:addTradeAcquire(RecipeDB, 39731, 6, 1077, 2, 25950, 6, 990, 2, 23437, 6, 1077, 2, 27666)

	-- Royal Shadowsong Amethyst -- 39732
	AddRecipe(39732, 375, 32216, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39732, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 109, 112)
	self:addTradeAcquire(RecipeDB, 39732, 6, 1077, 3, 25950, 6, 990, 3, 23437, 6, 1077, 3, 27666)

	-- Inscribed Pyrestone -- 39733
	AddRecipe(39733, 375, 32217, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39733, F_ALLIANCE, F_HORDE, 4, 6, 36, 41, 51, 112)
	self:addTradeAcquire(RecipeDB, 39733, 8, 27, 8, 34, 6, 1077, 4, 27666, 6, 1077, 4, 25950)

	-- Potent Pyrestone -- 39734
	AddRecipe(39734, 375, 32218, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39734, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 109, 112)
	self:addTradeAcquire(RecipeDB, 39734, 6, 1077, 2, 25950, 6, 990, 2, 23437, 6, 1077, 2, 27666)

	-- Luminous Pyrestone -- 39735
	AddRecipe(39735, 375, 32219, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39735, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 109, 112)
	self:addTradeAcquire(RecipeDB, 39735, 6, 1077, 2, 25950, 6, 990, 2, 23437, 6, 1077, 2, 27666)

	-- Glinting Pyrestone -- 39736
	AddRecipe(39736, 375, 32220, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39736, F_ALLIANCE, F_HORDE, 4, 36, 41, 51, 109, 112)
	self:addTradeAcquire(RecipeDB, 39736, 6, 1077, 2, 25950, 6, 990, 2, 23437, 6, 1077, 2, 27666)

	-- Veiled Pyrestone -- 39737
	AddRecipe(39737, 375, 32221, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39737, F_ALLIANCE, F_HORDE, 4, 6, 36, 41, 53, 54, 112)
	self:addTradeAcquire(RecipeDB, 39737, 8, 27, 8, 34, 6, 1077, 4, 27666, 6, 1077, 4, 25950)

	-- Wicked Pyrestone -- 39738
	AddRecipe(39738, 375, 32222, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39738, F_ALLIANCE, F_HORDE, 4, 36, 41, 51, 109, 112)
	self:addTradeAcquire(RecipeDB, 39738, 6, 1077, 3, 25950, 6, 990, 3, 23437, 6, 1077, 3, 27666)

	-- Enduring Seaspray Emerald -- 39739
	AddRecipe(39739, 375, 32223, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39739, F_ALLIANCE, F_HORDE, 4, 36, 41, 52, 109, 112)
	self:addTradeAcquire(RecipeDB, 39739, 6, 1077, 3, 25950, 6, 990, 3, 23437, 6, 1077, 3, 27666)

	-- Radiant Seaspray Emerald -- 39740 
	AddRecipe(39740, 375, 32224, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39740, F_ALLIANCE, F_HORDE, 4, 36, 41, 54, 109, 112)
	self:addTradeAcquire(RecipeDB, 39740, 6, 1077, 2, 25950, 6, 990, 2, 23437, 6, 1077, 2, 27666)

	-- Dazzling Seaspray Emerald -- 39741
	AddRecipe(39741, 375, 32225, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39741, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 109, 112)
	self:addTradeAcquire(RecipeDB, 39741, 6, 1077, 2, 25950, 6, 990, 2, 23437, 6, 1077, 2, 27666)

	-- Jagged Seaspray Emerald -- 39742
	AddRecipe(39742, 375, 32226, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 39742, F_ALLIANCE, F_HORDE, 4, 36, 41, 109, 112)
	self:addTradeAcquire(RecipeDB, 39742, 6, 1077, 2, 25950, 6, 990, 2, 23437, 6, 1077, 2, 27666)

	-- Relentless Earthstorm Diamond -- 39961
	AddRecipe(39961, 365, 32409, 3, 1, 365, 375, 377, 380)
	self:addTradeFlags(RecipeDB, 39961, F_ALLIANCE, F_HORDE, 4, 36, 41, 51, 105)
	self:addTradeAcquire(RecipeDB, 39961, 6, 933, 4, 20242, 6, 933, 4, 23007)

	-- Thundering Skyfire Diamond -- 39963
	AddRecipe(39963, 365, 32410, 3, 1, 365, 375, 377, 380)
	self:addTradeFlags(RecipeDB, 39963, F_ALLIANCE, F_HORDE, 10, 36, 40)
	self:addTradeAcquire(RecipeDB, 39963, 7, 3)

	-- Necklace of the Deep -- 40514
	AddRecipe(40514, 340, 32508, 1, 1, 340, 340, 355, 370)
	self:addTradeFlags(RecipeDB, 40514, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 63)
	self:addTradeAcquire(RecipeDB, 40514, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Brilliant Pearl Band -- 41414
	AddRecipe(41414, 325, 32772, 1, 1, 325, 335, 345, 355)
	self:addTradeFlags(RecipeDB, 41414, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 41414, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- The Black Pearl -- 41415
	AddRecipe(41415, 330, 32774, 1, 1, 330, 340, 350, 360)
	self:addTradeFlags(RecipeDB, 41415, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 41415, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Crown of the Sea Witch -- 41418
	AddRecipe(41418, 365, 32776, 1, 1, 365, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 41418, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 56)
	self:addTradeAcquire(RecipeDB, 41418, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Purified Jaggal Pearl -- 41420
	AddRecipe(41420, 325, 32833, 1, 1, 325, 325, 332, 340)
	self:addTradeFlags(RecipeDB, 41420, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 41420, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Purified Shadow Pearl -- 41429
	AddRecipe(41429, 350, 32836, 1, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 41429, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 41429, 1, 18751, 1, 18774, 1, 19063, 1, 19539, 1, 28701, 1, 33590, 1, 26997, 1, 26982, 1, 33614, 1, 26915, 1, 26960, 1, 33680)

	-- Don Julio's Heart -- 42558
	AddRecipe(42558, 360, 33133, 1, 1, 360, 365, 370, 375)
	self:addTradeFlags(RecipeDB, 42558, F_ALLIANCE, F_HORDE, 4, 37, 41, 53, 54, 105)
	self:addTradeAcquire(RecipeDB, 42558, 6, 933, 3, 20242, 6, 933, 3, 23007)

	-- Kailee's Rose -- 42588
	AddRecipe(42588, 360, 33134, 1, 1, 360, 365, 370, 375)
	self:addTradeFlags(RecipeDB, 42588, F_ALLIANCE, F_HORDE, 4, 37, 41, 53, 54, 111)
	self:addTradeAcquire(RecipeDB, 42588, 6, 935, 2, 21432)

	-- Crimson Sun -- 42589
	AddRecipe(42589, 360, 33131, 1, 1, 360, 365, 370, 375)
	self:addTradeFlags(RecipeDB, 42589, F_ALLIANCE, F_HORDE, 4, 37, 41, 51, 105)
	self:addTradeAcquire(RecipeDB, 42589, 6, 933, 3, 20242, 6, 933, 3, 23007)

	-- Falling Star -- 42590
	AddRecipe(42590, 360, 33135, 1, 1, 360, 365, 370, 375)
	self:addTradeFlags(RecipeDB, 42590, F_ALLIANCE, F_HORDE, 4, 37, 41, 107)
	self:addTradeAcquire(RecipeDB, 42590, 6, 1011, 3, 21655)

	-- Stone of Blades -- 42591
	AddRecipe(42591, 360, 33143, 1, 1, 360, 365, 370, 375)
	self:addTradeFlags(RecipeDB, 42591, F_ALLIANCE, F_HORDE, 4, 37, 41, 106)
	self:addTradeAcquire(RecipeDB, 42591, 6, 989, 3, 21643)

	-- Blood of Amber -- 42592
	AddRecipe(42592, 360, 33140, 1, 1, 360, 365, 370, 375)
	self:addTradeFlags(RecipeDB, 42592, F_ALLIANCE, F_HORDE, 4, 37, 41, 111, F_DPS)
	self:addTradeAcquire(RecipeDB, 42592, 6, 935, 3, 21432)

	-- Facet of Eternity -- 42593
	AddRecipe(42593, 360, 33144, 1, 1, 360, 365, 370, 375)
	self:addTradeFlags(RecipeDB, 42593, F_ALLIANCE, F_HORDE, 4, 37, 41, 52, 106)
	self:addTradeAcquire(RecipeDB, 42593, 6, 989, 2, 21643)

	-- Steady Talasite -- 43493
	AddRecipe(43493, 350, 33782, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 43493, F_ALLIANCE, F_HORDE, 4, 9, 36, 41)
	self:addTradeAcquire(RecipeDB, 43493, 2, 18821, 2, 18822)

	-- Chaotic Skyfire Diamond -- 44794
	AddRecipe(44794, 365, 34220, 3, 1, 365, 375, 377, 380)
	self:addTradeFlags(RecipeDB, 44794, F_ALLIANCE, F_HORDE, 11, 36, 41)
	self:addTradeAcquire(RecipeDB, 44794, 3, 19768)

	-- Loop of Forged Power -- 46122
	AddRecipe(46122, 365, 34362, 4, 1, 365, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 46122, F_ALLIANCE, F_HORDE, 6, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 46122, 8, 24)

	-- Ring of Flowing Life -- 46123
	AddRecipe(46123, 365, 34363, 4, 1, 365, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 46123, F_ALLIANCE, F_HORDE, 6, 36, 40, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 46123, 8, 24)

	-- Hard Khorium Band -- 46124
	AddRecipe(46124, 365, 34361, 4, 1, 365, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 46124, F_ALLIANCE, F_HORDE, 6, 36, 41, 51, 62)
	self:addTradeAcquire(RecipeDB, 46124, 8, 24)

	-- Pendant of Sunfire -- 46125
	AddRecipe(46125, 365, 34359, 4, 1, 365, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 46125, F_ALLIANCE, F_HORDE, 6, 37, 41, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 46125, 8, 24)

	-- Amulet of Flowing Life -- 46126
	AddRecipe(46126, 365, 34360, 4, 1, 365, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 46126, F_ALLIANCE, F_HORDE, 6, 37, 41, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 46126, 8, 24)

	-- Hard Khorium Choker -- 46127
	AddRecipe(46127, 365, 34358, 4, 1, 365, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 46127, F_ALLIANCE, F_HORDE, 6, 11, 37, 41, 51, 63)
	self:addTradeAcquire(RecipeDB, 46127, 8, 24)

	-- Quick Dawnstone -- 46403
	AddRecipe(46403, 350, 35315, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 46403, F_ALLIANCE, F_HORDE, 4, 36, 41, 112)
	self:addTradeAcquire(RecipeDB, 46403, 6, 1077, 4, 25950, 6, 1077, 4, 27666)

	-- Reckless Noble Topaz -- 46404
	AddRecipe(46404, 350, 35316, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 46404, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 112)
	self:addTradeAcquire(RecipeDB, 46404, 6, 1077, 4, 25950, 6, 1077, 4, 27666)

	-- Forceful Talasite -- 46405
	AddRecipe(46405, 350, 35318, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 46405, F_ALLIANCE, F_HORDE, 4, 36, 41, 112)
	self:addTradeAcquire(RecipeDB, 46405, 6, 1077, 4, 25950, 6, 1077, 4, 27666)

	-- Eternal Earthstorm Diamond -- 46597
	AddRecipe(46597, 370, 35501, 1, 1, 370, 375, 377, 380)
	self:addTradeFlags(RecipeDB, 46597, F_ALLIANCE, F_HORDE, 4, 36, 41, 52, 112)
	self:addTradeAcquire(RecipeDB, 46597, 6, 1077, 3, 25032)

	-- Ember Skyfire Diamond -- 46601
	AddRecipe(46601, 370, 35503, 1, 1, 370, 375, 377, 380)
	self:addTradeFlags(RecipeDB, 46601, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 112)
	self:addTradeAcquire(RecipeDB, 46601, 6, 1077, 3, 25032)

	-- Figurine - Empyrean Tortoise -- 46775
	AddRecipe(46775, 375, 35693, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 46775, F_ALLIANCE, F_HORDE, 4, 37, 41, 52, 61, 112)
	self:addTradeAcquire(RecipeDB, 46775, 6, 1077, 3, 25032)

	-- Figurine - Khorium Boar -- 46776
	AddRecipe(46776, 375, 35694, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 46776, F_ALLIANCE, F_HORDE, 4, 37, 41, 51, 61, 112)
	self:addTradeAcquire(RecipeDB, 46776, 6, 1077, 3, 25032)

	-- Figurine - Crimson Serpent -- 46777
	AddRecipe(46777, 375, 35700, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 46777, F_ALLIANCE, F_HORDE, 4, 37, 41, 53, 54, 61, 112)
	self:addTradeAcquire(RecipeDB, 46777, 6, 1077, 3, 25032)

	-- Figurine - Shadowsong Panther -- 46778
	AddRecipe(46778, 375, 35702, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 46778, F_ALLIANCE, F_HORDE, 4, 37, 41, 51, 61, 112)
	self:addTradeAcquire(RecipeDB, 46778, 6, 1077, 3, 25032)

	-- Figurine - Seaspray Albatross -- 46779
	AddRecipe(46779, 375, 35703, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 46779, F_ALLIANCE, F_HORDE, 4, 37, 41, 53, 54, 61, 112)
	self:addTradeAcquire(RecipeDB, 46779, 6, 1077, 3, 25032)

	-- Regal Nightseye -- 46803
	AddRecipe(46803, 350, 35707, 1, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 46803, F_ALLIANCE, F_HORDE, 4, 36, 41, 52, 112)
	self:addTradeAcquire(RecipeDB, 46803, 6, 1077, 3, 25032)

	-- Forceful Seaspray Emerald -- 47053
	AddRecipe(47053, 375, 35759, 4, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 47053, F_ALLIANCE, F_HORDE, 4, 36, 41, 109, 112)
	self:addTradeAcquire(RecipeDB, 47053, 6, 1077, 3, 25032, 6, 1077, 3, 25950, 6, 990, 2, 23437, 6, 1077, 3, 27666)

	-- Steady Seaspray Emerald -- 47054
	AddRecipe(47054, 375, 35758, 4, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 47054, F_ALLIANCE, F_HORDE, 4, 36, 41, 109, 112)
	self:addTradeAcquire(RecipeDB, 47054, 6, 990, 2, 23437, 6, 1077, 3, 25032, 6, 1077, 3, 25950, 6, 1077, 3, 27666)

	-- Reckless Pyrestone -- 47055
	AddRecipe(47055, 375, 35760, 4, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 47055, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 109, 112)
	self:addTradeAcquire(RecipeDB, 47055, 6, 1077, 3, 25032, 6, 1077, 3, 25950, 6, 990, 2, 23437, 6, 1077, 3, 27666)

	-- Quick Lionseye -- 47056
	AddRecipe(47056, 375, 35761, 4, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 47056, F_ALLIANCE, F_HORDE, 4, 36, 41, 109, 112)
	self:addTradeAcquire(RecipeDB, 47056, 6, 1077, 3, 25032, 6, 1077, 3, 25950, 6, 990, 2, 23437, 6, 1077, 3, 27666)

	-- Brilliant Glass -- 47280
	AddRecipe(47280, 350, 35945, 3, 1, 350, 350, 365, 380)
	self:addTradeFlags(RecipeDB, 47280, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 47280, 1, 26997, 1, 26960, 1, 26982, 1, 19063, 1, 19539, 1, 18751, 1, 26915, 1, 18774, 1, 28701, 1, 33590, 1, 33614, 1, 33680)

	-- Purified Shadowsong Amethyst -- 48789
	AddRecipe(48789, 375, 37503, 1, 1, 375, 375, 380, 385)
	self:addTradeFlags(RecipeDB, 48789, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 112)
	self:addTradeAcquire(RecipeDB, 48789, 6, 1077, 4, 25950, 6, 1077, 4, 27666)

	-- Bold Scarlet Ruby -- 53830
	AddRecipe(53830, 390, 39996, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53830, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53830, 2, 28721, 2, 33602)

	-- Bold Bloodstone -- 53831
	AddRecipe(53831, 350, 39900, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53831, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53831, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Delicate Bloodstone -- 53832
	AddRecipe(53832, 350, 39905, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53832, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53832, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Runed Bloodstone -- 53834
	AddRecipe(53834, 350, 39911, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53834, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53834, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Bright Bloodstone -- 53835
	AddRecipe(53835, 350, 39906, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53835, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53835, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Subtle Bloodstone -- 53843
	AddRecipe(53843, 360, 39907, 2, 2, 360, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53843, F_ALLIANCE, F_HORDE, 3, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 53843, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Flashing Bloodstone -- 53844
	AddRecipe(53844, 350, 39908, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53844, F_ALLIANCE, F_HORDE, 3, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 53844, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Fractured Bloodstone -- 53845
	AddRecipe(53845, 350, 39909, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53845, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53845, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Brilliant Sun Crystal -- 53852
	AddRecipe(53852, 350, 39912, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53852, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 53852, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Smooth Sun Crystal -- 53853
	AddRecipe(53853, 350, 39914, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53853, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 53853, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Rigid Sun Crystal -- 53854
	AddRecipe(53854, 350, 39915, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53854, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 53854, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Thick Sun Crystal -- 53855
	AddRecipe(53855, 350, 39916, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53855, F_ALLIANCE, F_HORDE, 3, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 53855, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Quick Sun Crystal -- 53856
	AddRecipe(53856, 350, 39918, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53856, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 53856, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Mystic Sun Crystal -- 53857
	AddRecipe(53857, 350, 39917, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53857, F_ALLIANCE, F_HORDE, 4, 9, 36, 41)
	self:addTradeAcquire(RecipeDB, 53857, 2, 34079, 2, 34039)

	-- Sovereign Shadow Crystal -- 53859
	AddRecipe(53859, 350, 39934, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53859, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53859, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Shifting Shadow Crystal -- 53860
	AddRecipe(53860, 350, 39935, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53860, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53860, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Tenuous Shadow Crystal -- 53861
	AddRecipe(53861, 350, 39942, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53861, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53861, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Glowing Shadow Crystal -- 53862
	AddRecipe(53862, 350, 39936, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53862, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53862, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Purified Shadow Crystal -- 53863
	AddRecipe(53863, 350, 39941, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53863, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53863, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Royal Shadow Crystal -- 53864
	AddRecipe(53864, 350, 39943, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53864, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53864, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Mysterious Shadow Crystal -- 53865 
	AddRecipe(53865, 350, 39945, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53865, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53865, 2, 34079, 2, 34039)

	-- Balanced Shadow Crystal -- 53866
	AddRecipe(53866, 350, 39937, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53866, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53866, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Infused Shadow Crystal -- 53867
	AddRecipe(53867, 350, 39944, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53867, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53867, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Regal Shadow Crystal -- 53868
	AddRecipe(53868, 360, 39938, 2, 2, 360, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53868, F_ALLIANCE, F_HORDE, 3, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 53868, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Defender's Shadow Crystal -- 53869
	AddRecipe(53869, 350, 39939, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53869, F_ALLIANCE, F_HORDE, 4, 36, 41, 52, 120)
	self:addTradeAcquire(RecipeDB, 53869, 6, 1073, 2, 31916, 6, 1073, 2, 32763)

	-- Puissant Shadow Crystal -- 53870
	AddRecipe(53870, 350, 39933, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53870, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53870, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Guardian's Shadow Crystal -- 53871
	AddRecipe(53871, 350, 39940, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53871, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 52)
	self:addTradeAcquire(RecipeDB, 53871, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Inscribed Huge Citrine -- 53872
	AddRecipe(53872, 350, 39947, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53872, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53872, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Etched Huge Citrine -- 53873
	AddRecipe(53873, 350, 39948, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53873, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53873, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Champion's Huge Citrine -- 53874
	AddRecipe(53874, 350, 39949, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53874, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 52)
	self:addTradeAcquire(RecipeDB, 53874, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Resplendent Huge Citrine -- 53875
	AddRecipe(53875, 350, 39950, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53875, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53875, 2, 34079, 2, 34039)

	-- Fierce Huge Citrine -- 53876
	AddRecipe(53876, 350, 39951, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53876, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53876, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Deadly Huge Citrine -- 53877
	AddRecipe(53877, 350, 39952, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53877, F_ALLIANCE, F_HORDE, 4, 36, 41, 51, 117)
	self:addTradeAcquire(RecipeDB, 53877, 6, 1098, 1, 32538)

	-- Glinting Huge Citrine -- 53878
	AddRecipe(53878, 350, 39953, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53878, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53878, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Lucent Huge Citrine -- 53879
	AddRecipe(53879, 350, 39954, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53879, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53879, 2, 34079, 2, 34039)

	-- Deft Huge Citrine -- 53880
	AddRecipe(53880, 350, 39955, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53880, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53880, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Luminous Huge Citrine -- 53881
	AddRecipe(53881, 350, 39946, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53881, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53881, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Potent Huge Citrine -- 53882
	AddRecipe(53882, 350, 39956, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53882, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53882, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Veiled Huge Citrine -- 53883
	AddRecipe(53883, 350, 39957, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53883, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53883, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Durable Huge Citrine -- 53884
	AddRecipe(53884, 350, 39958, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53884, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53884, 2, 34079, 2, 34039)

	-- Reckless Huge Citrine -- 53885
	AddRecipe(53885, 350, 39959, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53885, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 116)
	self:addTradeAcquire(RecipeDB, 53885, 6, 1104, 1, 31911)

	-- Wicked Huge Citrine -- 53886
	AddRecipe(53886, 350, 39960, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53886, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53886, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Pristine Huge Citrine -- 53887
	AddRecipe(53887, 350, 39961, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53887, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53887, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Empowered Huge Citrine -- 53888
	AddRecipe(53888, 350, 39962, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53888, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53888, 2, 34079, 2, 34039)

	-- Stark Huge Citrine -- 53889
	AddRecipe(53889, 350, 39963, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53889, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53889, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Stalwart Huge Citrine -- 53890
	AddRecipe(53890, 350, 39964, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53890, F_ALLIANCE, F_HORDE, 3, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 53890, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Glimmering Huge Citrine -- 53891
	AddRecipe(53891, 360, 39965, 2, 2, 360, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53891, F_ALLIANCE, F_HORDE, 3, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 53891, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Accurate Huge Citrine -- 53892
	AddRecipe(53892, 350, 39966, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53892, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 52)
	self:addTradeAcquire(RecipeDB, 53892, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Resolute Huge Citrine -- 53893
	AddRecipe(53893, 350, 39967, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53893, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 52)
	self:addTradeAcquire(RecipeDB, 53893, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Timeless Dark Jade -- 53894
	AddRecipe(53894, 350, 39968, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53894, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 53894, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Jagged Dark Jade -- 53916
	AddRecipe(53916, 350, 39974, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53916, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 53916, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Vivid Dark Jade -- 53917
	AddRecipe(53917, 350, 39975, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53917, F_ALLIANCE, F_HORDE, 4, 36, 41, 121)
	self:addTradeAcquire(RecipeDB, 53917, 6, 1105, 1, 31910)

	-- Enduring Dark Jade -- 53918
	AddRecipe(53918, 350, 39976, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53918, F_ALLIANCE, F_HORDE, 3, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 53918, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Steady Dark Jade -- 53919
	AddRecipe(53919, 350, 39977, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53919, F_ALLIANCE, F_HORDE, 4, 9, 36, 41)
	self:addTradeAcquire(RecipeDB, 53919, 2, 34079, 2, 34039)

	-- Forceful Dark Jade -- 53920
	AddRecipe(53920, 350, 39978, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53920, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 53920, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Seer's Dark Jade -- 53921
	AddRecipe(53921, 350, 39979, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53921, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 120)
	self:addTradeAcquire(RecipeDB, 53921, 6, 1073, 1, 31916, 6, 1073, 1, 32763)

	-- Misty Dark Jade -- 53922
	AddRecipe(53922, 350, 39980, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53922, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53922, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Shining Dark Jade -- 53923
	AddRecipe(53923, 350, 39981, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53923, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53923, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Turbid Dark Jade -- 53924
	AddRecipe(53924, 350, 39982, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53924, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53924, 2, 34079, 2, 34039)

	-- Intricate Dark Jade -- 53925
	AddRecipe(53925, 350, 39983, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53925, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53925, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Dazzling Dark Jade -- 53926
	AddRecipe(53926, 350, 39984, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53926, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53926, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Sundered Dark Jade -- 53927
	AddRecipe(53927, 350, 39985, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53927, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53927, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Lambent Dark Jade -- 53928
	AddRecipe(53928, 350, 39986, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53928, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53928, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Opaque Dark Jade -- 53929
	AddRecipe(53929, 350, 39988, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53929, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53929, 2, 34079, 2, 34039)

	-- Energized Dark Jade -- 53930
	AddRecipe(53930, 350, 39989, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53930, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53930, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Radiant Dark Jade -- 53931 
	AddRecipe(53931, 350, 39990, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53931, F_ALLIANCE, F_HORDE, 3, 36, 41, 54)
	self:addTradeAcquire(RecipeDB, 53931, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Tense Dark Jade -- 53932 
	AddRecipe(53932, 350, 39991, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53932, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 54)
	self:addTradeAcquire(RecipeDB, 53932, 2, 34079, 2, 34039)

	-- Shattered Dark Jade -- 53933 
	AddRecipe(53933, 350, 39992, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53933, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 54)
	self:addTradeAcquire(RecipeDB, 53933, 2, 34079, 2, 34039)

	-- Solid Chalcedony -- 53934
	AddRecipe(53934, 350, 39919, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53934, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 53934, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Sparkling Chalcedony -- 53940
	AddRecipe(53940, 350, 39920, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53940, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53940, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Lustrous Chalcedony -- 53941
	AddRecipe(53941, 350, 39927, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53941, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53941, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Stormy Chalcedony -- 53943
	AddRecipe(53943, 350, 39927, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 53943, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 54)
	self:addTradeAcquire(RecipeDB, 53943, 2, 34079, 2, 34039)

	-- Delicate Scarlet Ruby -- 53945
	AddRecipe(53945, 390, 39997, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53945, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53945, 2, 28721, 2, 33602)

	-- Runed Scarlet Ruby -- 53946
	AddRecipe(53946, 390, 39998, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53946, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 118)
	self:addTradeAcquire(RecipeDB, 53946, 6, 1090, 4, 32287)

	-- Bright Scarlet Ruby -- 53947
	AddRecipe(53947, 390, 39999, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53947, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53947, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Flashing Scarlet Ruby -- 53949
	AddRecipe(53949, 390, 40001, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53949, F_ALLIANCE, F_HORDE, 4, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 53949, 2, 28721, 2, 33602)

	-- Fractured Scarlet Ruby -- 53950
	AddRecipe(53950, 390, 40002, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53950, F_ALLIANCE, F_HORDE, 11, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53950, 3, 29570)

	-- Precise Scarlet Ruby -- 53951
	AddRecipe(53951, 390, 40003, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53951, F_ALLIANCE, F_HORDE, 5, 11, 36, 41, 51, 52)
	self:addTradeAcquire(RecipeDB, 53951, 3, 29311)

	-- Solid Sky Sapphire -- 53952
	AddRecipe(53952, 390, 40008, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53952, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 53952, 2, 28721, 2, 33602)

	-- Sparkling Sky Sapphire -- 53953
	AddRecipe(53953, 390, 40009, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53953, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53953, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Lustrous Sky Sapphire -- 53954
	AddRecipe(53954, 390, 40010, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53954, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53954, 2, 28721, 2, 33602)

	-- Stormy Sky Sapphire -- 53955 
	AddRecipe(53955, 390, 40011, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53955, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 54)
	self:addTradeAcquire(RecipeDB, 53955, 2, 30489, 2, 32294, 2, 32296)

	-- Brilliant Autumn's Glow -- 53956
	AddRecipe(53956, 390, 40012, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53956, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 53956, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Smooth Autumn's Glow -- 53957
	AddRecipe(53957, 390, 40013, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53957, F_ALLIANCE, F_HORDE, 4, 36, 41, 119)
	self:addTradeAcquire(RecipeDB, 53957, 6, 1119, 4, 32540)

	-- Rigid Autumn's Glow -- 53958
	AddRecipe(53958, 390, 40014, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53958, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 53958, 2, 28721, 2, 33602)

	-- Thick Autumn's Glow -- 53959
	AddRecipe(53959, 390, 40015, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53959, F_ALLIANCE, F_HORDE, 5, 11, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 53959, 3, 31134)

	-- Mystic Autumn's Glow -- 53960
	AddRecipe(53960, 390, 40016, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53960, F_ALLIANCE, F_HORDE, 4, 9, 36, 41)
	self:addTradeAcquire(RecipeDB, 53960, 2, 30489, 2, 32294, 2, 32296)

	-- Quick Autumn's Glow -- 53961
	AddRecipe(53961, 390, 40017, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53961, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 53961, 2, 28721, 2, 33602)

	-- Sovereign Twilight Opal -- 53962
	AddRecipe(53962, 390, 40022, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53962, F_ALLIANCE, F_HORDE, 10, 36, 40, 51)
	self:addTradeAcquire(RecipeDB, 53962, 7, 3)

	-- Tenuous Twilight Opal -- 53964
	AddRecipe(53964, 390, 40024, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53964, F_ALLIANCE, F_HORDE, 10, 36, 40, 51)
	self:addTradeAcquire(RecipeDB, 53964, 7, 3)

	-- Glowing Twilight Opal -- 53965
	AddRecipe(53965, 390, 40025, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53965, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 117)
	self:addTradeAcquire(RecipeDB, 53965, 6, 1098, 4, 32538)

	-- Purified Twilight Opal -- 53966
	AddRecipe(53966, 390, 40026, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53966, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54)
	self:addTradeAcquire(RecipeDB, 53966, 7, 3)

	-- Royal Twilight Opal -- 53967
	AddRecipe(53967, 390, 40027, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53967, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53967, 2, 28721, 2, 33602)

	-- Mysterious Twilight Opal
	AddRecipe(53968, 390, 40028, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53968, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53968, 2, 30489, 2, 32294, 2, 32296)

	-- Balanced Twilight Opal -- 53969
	AddRecipe(53969, 390, 40029, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53969, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53969, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Infused Twilight Opal -- 53970
	AddRecipe(53970, 390, 40030, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53970, F_ALLIANCE, F_HORDE, 5, 11, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53970, 3, 29120)

	-- Regal Twilight Opal -- 53971
	AddRecipe(53971, 390, 40031, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53971, F_ALLIANCE, F_HORDE, 4, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 53971, 2, 28721, 2, 33602)

	-- Defender's Twilight Opal -- 53972
	AddRecipe(53972, 390, 40032, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53972, F_ALLIANCE, F_HORDE, 11, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 53972, 3, 29370, 3, 29376, 3, 30208, 3, 30222)

	-- Puissant Twilight Opal -- 53973
	AddRecipe(53973, 390, 40033, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53973, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53973, 2, 28721, 2, 33602)

	-- Guardian's Twilight Opal -- 53974
	AddRecipe(53974, 390, 40034, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53974, F_ALLIANCE, F_HORDE, 4, 36, 41, 51, 52, 115)
	self:addTradeAcquire(RecipeDB, 53974, 6, 1106, 3, 30431)

	-- Inscribed Monarch Topaz -- 53975
	AddRecipe(53975, 390, 40037, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53975, F_ALLIANCE, F_HORDE, 10, 36, 40, 51)
	self:addTradeAcquire(RecipeDB, 53975, 7, 3)

	-- Etched Monarch Topaz -- 53976
	AddRecipe(53976, 390, 40038, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53976, F_ALLIANCE, F_HORDE, 10, 36, 40, 51)
	self:addTradeAcquire(RecipeDB, 53976, 7, 3)

	-- Champion's Monarch Topaz -- 53977
	AddRecipe(53977, 390, 40039, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53977, F_ALLIANCE, F_HORDE, 10, 36, 40, 51, 52)
	self:addTradeAcquire(RecipeDB, 53977, 7, 3)

	-- Resplendent Monarch Topaz -- 53978
	AddRecipe(53978, 390, 40040, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53978, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53978, 2, 30489, 2, 32294, 2, 32296)

	-- Deadly Monarch Topaz -- 53979
	AddRecipe(53979, 390, 40043, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53979, F_ALLIANCE, F_HORDE, 5, 11, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53979, 3, 26723)

	-- Glinting Monarch Topaz -- 53980
	AddRecipe(53980, 390, 40044, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53980, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53980, 2, 28721, 2, 33602)

	-- Lucent Monarch Topaz -- 53981
	AddRecipe(53981, 390, 40045, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53981, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53981, 2, 30489, 2, 32294, 2, 32296)

	-- Deft Monarch Topaz -- 53982
	AddRecipe(53982, 390, 40046, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53982, F_ALLIANCE, F_HORDE, 5, 11, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53982, 3, 27978)

	-- Luminous Monarch Topaz -- 53983
	AddRecipe(53983, 390, 40047, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53983, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53983, 2, 28721, 2, 33602)

	-- Potent Monarch Topaz -- 53984
	AddRecipe(53984, 390, 40048, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53984, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53984, 2, 28721, 2, 33602)

	-- Veiled Monarch Topaz -- 53985
	AddRecipe(53985, 390, 40049, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53985, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53985, 2, 28721, 2, 33602)

	-- Durable Monarch Topaz -- 53986
	AddRecipe(53986, 390, 40050, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53986, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53986, 2, 30489, 2, 32294, 2, 32296)

	-- Reckless Monarch Topaz -- 53987
	AddRecipe(53987, 390, 40051, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53987, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 53987, 2, 28721, 2, 33602)

	-- Wicked Monarch Topaz -- 53988
	AddRecipe(53988, 390, 40052, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53988, F_ALLIANCE, F_HORDE, 4, 36, 41, 51, 117)
	self:addTradeAcquire(RecipeDB, 53988, 6, 1098, 3, 32538)

	-- Pristine Monarch Topaz -- 53989
	AddRecipe(53989, 390, 40053, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53989, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53989, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Empowered Monarch Topaz -- 53990
	AddRecipe(53990, 390, 40054, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53990, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53990, 2, 30489, 2, 32294, 2, 32296)

	-- Stark Monarch Topaz -- 53991
	AddRecipe(53991, 390, 40055, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53991, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53991, 2, 28721, 2, 33602)

	-- Stalwart Monarch Topaz -- 53992
	AddRecipe(53992, 390, 40056, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53992, F_ALLIANCE, F_HORDE, 10, 36, 40, 52)
	self:addTradeAcquire(RecipeDB, 53992, 7, 3)

	-- Glimmering Monarch Topaz -- 53993
	AddRecipe(53993, 390, 40057, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53993, F_ALLIANCE, F_HORDE, 4, 36, 41, 52, 122)
	self:addTradeAcquire(RecipeDB, 53993, 6, 1091, 4, 32533)

	-- Accurate Monarch Topaz -- 53994
	AddRecipe(53994, 390, 40058, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53994, F_ALLIANCE, F_HORDE, 11, 36, 41, 51, 52)
	self:addTradeAcquire(RecipeDB, 53994, 3, 28379, 3, 28851, 3, 29402, 3, 30260, 3, 30448)

	-- Timeless Forest Emerald -- 53995
	AddRecipe(53995, 390, 40085, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53995, F_ALLIANCE, F_HORDE, 5, 11, 36, 41)
	self:addTradeAcquire(RecipeDB, 53995, 3, 26632)

	-- Jagged Forest Emerald -- 53996
	AddRecipe(53996, 390, 40086, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53996, F_ALLIANCE, F_HORDE, 4, 36, 41, 116)
	self:addTradeAcquire(RecipeDB, 53996, 6, 1104, 3, 31911)

	-- Vivid Forest Emerald -- 53997
	AddRecipe(53997, 390, 40088, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53997, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 53997, 2, 28721, 2, 33602)

	-- Enduring Forest Emerald -- 53998
	AddRecipe(53998, 390, 40089, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53998, F_ALLIANCE, F_HORDE, 4, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 53998, 2, 28721, 2, 33602)

	-- Steady Forest Emerald -- 54000
	AddRecipe(54000, 390, 40090, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 54000, F_ALLIANCE, F_HORDE, 4, 9, 36, 41)
	self:addTradeAcquire(RecipeDB, 54000, 2, 30489, 2, 32294, 2, 32296)

	-- Forceful Forest Emerald -- 54001
	AddRecipe(54001, 390, 40091, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 54001, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 54001, 2, 28721, 2, 33602)

	-- Seer's Forest Emerald -- 54002
	AddRecipe(54002, 390, 40092, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 54002, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 54002, 2, 28721, 2, 33602)

	-- Misty Forest Emerald -- 54003
	AddRecipe(54003, 390, 40095, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 54003, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54)
	self:addTradeAcquire(RecipeDB, 54003, 7, 3)

	-- Shining Forest Emerald -- 54004
	AddRecipe(54004, 390, 40099, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 54004, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54)
	self:addTradeAcquire(RecipeDB, 54004, 7, 3)

	-- Turbid Forest Emerald -- 54005
	AddRecipe(54005, 390, 40102, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 54005, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 54005, 2, 30489, 2, 32294, 2, 32296)

	-- Intricate Forest Emerald -- 54006
	AddRecipe(54006, 390, 40104, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 54006, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 54006, 2, 28721, 2, 33602)

	-- Dazzling Forest Emerald -- 54007
	AddRecipe(54007, 390, 40094, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 54007, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 54007, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Sundered Forest Emerald -- 54008
	AddRecipe(54008, 390, 40096, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 54008, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 121)
	self:addTradeAcquire(RecipeDB, 54008, 6, 1105, 3, 31910)

	-- Lambent Forest Emerald -- 54009
	AddRecipe(54009, 390, 40100, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 54009, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 54009, 2, 28721, 2, 33602)

	-- Opaque Forest Emerald -- 54010
	AddRecipe(54010, 390, 40103, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 54010, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 54010, 2, 30489, 2, 32294, 2, 32296)

	-- Energized Forest Emerald -- 54011
	AddRecipe(54011, 390, 40105, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 54011, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 54011, 2, 28721, 2, 33602)

	-- Radiant Forest Emerald -- 54012 
	AddRecipe(54012, 390, 40098, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 54012, F_ALLIANCE, F_HORDE, 11, 36, 41, 54)
	self:addTradeAcquire(RecipeDB, 54012, 3, 29792, 3, 29793)

	-- Tense Forest Emerald -- 54013 
	AddRecipe(54013, 390, 40101, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 54013, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 54)
	self:addTradeAcquire(RecipeDB, 54013, 2, 30489, 2, 32294, 2, 32296)

	-- Shattered Forest Emerald -- 54014 
	AddRecipe(54014, 390, 40106, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 54014, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 54)
	self:addTradeAcquire(RecipeDB, 54014, 2, 30489, 2, 32294, 2, 32296)

	-- Precise Bloodstone -- 54017
	AddRecipe(54017, 350, 39910, 2, 2, 350, 375, 395, 415)
	self:addTradeFlags(RecipeDB, 54017, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 52)
	self:addTradeAcquire(RecipeDB, 54017, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Fierce Monarch Topaz -- 54019
	AddRecipe(54019, 390, 40041, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 54019, F_ALLIANCE, F_HORDE, 5, 11, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 54019, 3, 23954)

	-- Resolute Monarch Topaz -- 54023
	AddRecipe(54023, 390, 40059, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 54023, F_ALLIANCE, F_HORDE, 10, 36, 40, 51, 52)
	self:addTradeAcquire(RecipeDB, 54023, 7, 3)

	-- Effulgent Skyflare Diamond -- 55384
	AddRecipe(55384, 420, 41377, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55384, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 55384, 2, 28721, 2, 33602)

	-- Tireless Skyflare Diamond -- 55386
	AddRecipe(55386, 420, 41375, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55386, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 55386, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Forlorn Skyflare Diamond -- 55387
	AddRecipe(55387, 420, 41378, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55387, F_ALLIANCE, F_HORDE, 4, 9, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 55387, 2, 30489, 2, 32294, 2, 32296)

	-- Impassive Skyflare Diamond -- 55388
	AddRecipe(55388, 420, 41379, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55388, F_ALLIANCE, F_HORDE, 4, 9, 36, 41)
	self:addTradeAcquire(RecipeDB, 55388, 2, 30489, 2, 32294, 2, 32296)

	-- Chaotic Skyflare Diamond -- 55389
	AddRecipe(55389, 420, 41285, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55389, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 55389, 2, 28721, 2, 33602)

	-- Destructive Skyflare Diamond -- 55390
	AddRecipe(55390, 420, 41307, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55390, F_ALLIANCE, F_HORDE, 10, 36, 41)
	self:addTradeAcquire(RecipeDB, 55390, 7, 3)

	-- Ember Skyflare Diamond -- 55392
	AddRecipe(55392, 420, 41333, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55392, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 55392, 2, 28721, 2, 33602)

	-- Enigmatic Skyflare Diamond -- 55393
	AddRecipe(55393, 420, 41335, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55393, F_ALLIANCE, F_HORDE, 4, 9, 36, 41)
	self:addTradeAcquire(RecipeDB, 55393, 2, 30489, 2, 32294, 2, 32296)

	-- Swift Skyflare Diamond -- 55394
	AddRecipe(55394, 420, 41339, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55394, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 55394, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Thundering Skyflare Diamond -- 55395
	AddRecipe(55395, 420, 41400, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55395, F_ALLIANCE, F_HORDE, 10, 36, 40)
	self:addTradeAcquire(RecipeDB, 55395, 7, 3)

	-- Insightful Earthsiege Diamond -- 55396
	AddRecipe(55396, 420, 41401, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55396, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 55396, 2, 28721, 2, 33602)

	-- Bracing Earthsiege Diamond -- 55397
	AddRecipe(55397, 420, 41395, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55397, F_ALLIANCE, F_HORDE, 5, 11, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 55397, 3, 27656)

	-- Eternal Earthsiege Diamond -- 55398
	AddRecipe(55398, 420, 41396, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55398, F_ALLIANCE, F_HORDE, 5, 11, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 55398, 3, 28923)

	-- Powerful Earthsiege Diamond -- 55399
	AddRecipe(55399, 420, 41397, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55399, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 55399, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Relentless Earthsiege Diamond -- 55400
	AddRecipe(55400, 420, 41398, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55400, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 55400, 2, 28721, 2, 33602)

	-- Austere Earthsiege Diamond -- 55401
	AddRecipe(55401, 420, 41380, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55401, F_ALLIANCE, F_HORDE, 5, 11, 36, 41)
	self:addTradeAcquire(RecipeDB, 55401, 3, 26861)

	-- Persistent Earthsiege Diamond -- 55402
	AddRecipe(55402, 420, 41381, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55402, F_ALLIANCE, F_HORDE, 3, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 55402, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Trenchant Earthsiege Diamond -- 55403
	AddRecipe(55403, 420, 41382, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55403, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 55403, 2, 28721, 2, 33602)

	-- Invigorating Earthsiege Diamond -- 55404
	AddRecipe(55404, 420, 41385, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55404, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 55404, 2, 28721, 2, 33602)

	-- Beaming Earthsiege Diamond -- 55405
	AddRecipe(55405, 420, 41389, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55405, F_ALLIANCE, F_HORDE, 10, 36, 40, 53, 54)
	self:addTradeAcquire(RecipeDB, 55405, 7, 3)

	-- Revitalizing Skyflare Diamond -- 55407
	AddRecipe(55407, 420, 41376, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 55407, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 55407, 2, 28721, 2, 33602)

	-- Bold Dragon's Eye -- 56049
	AddRecipe(56049, 370, 42142, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56049, F_ALLIANCE, F_HORDE, 4, 37, 41, 51)
	self:addTradeAcquire(RecipeDB, 56049, 2, 28721, 2, 33602)

	-- Delicate Dragon's Eye -- 56052
	AddRecipe(56052, 370, 42143, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56052, F_ALLIANCE, F_HORDE, 4, 37, 41, 51)
	self:addTradeAcquire(RecipeDB, 56052, 2, 28721, 2, 33602)

	-- Runed Dragon's Eye -- 56053
	AddRecipe(56053, 370, 42144, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56053, F_ALLIANCE, F_HORDE, 4, 37, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 56053, 2, 28721, 2, 33602)

	-- Bright Dragon's Eye -- 56054
	AddRecipe(56054, 370, 36766, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56054, F_ALLIANCE, F_HORDE, 4, 37, 41, 51)
	self:addTradeAcquire(RecipeDB, 56054, 2, 28721, 2, 33602)

	-- Subtle Dragon's Eye -- 56055
	AddRecipe(56055, 370, 42151, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56055, F_ALLIANCE, F_HORDE, 4, 37, 41, 52)
	self:addTradeAcquire(RecipeDB, 56055, 2, 28721, 2, 33602)

	-- Flashing Dragon's Eye -- 56056
	AddRecipe(56056, 370, 42152, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56056, F_ALLIANCE, F_HORDE, 4, 37, 41, 52)
	self:addTradeAcquire(RecipeDB, 56056, 2, 28721, 2, 33602)

	-- Brilliant Dragon's Eye -- 56074
	AddRecipe(56074, 370, 42148, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56074, F_ALLIANCE, F_HORDE, 4, 37, 41)
	self:addTradeAcquire(RecipeDB, 56074, 2, 28721, 2, 33602)

	-- Fractured Dragon's Eye -- 56076
	AddRecipe(56076, 370, 42153, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56076, F_ALLIANCE, F_HORDE, 4, 37, 41, 51)
	self:addTradeAcquire(RecipeDB, 56076, 2, 28721, 2, 33602)

	-- Lustrous Dragon's Eye -- 56077
	AddRecipe(56077, 370, 42146, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56077, F_ALLIANCE, F_HORDE, 4, 37, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 56077, 2, 28721, 2, 33602)

	-- Mystic Dragon's Eye -- 56079
	AddRecipe(56079, 370, 42158, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56079, F_ALLIANCE, F_HORDE, 4, 37, 41)
	self:addTradeAcquire(RecipeDB, 56079, 2, 28721, 2, 33602)

	-- Precise Dragon's Eye -- 56081
	AddRecipe(56081, 370, 42154, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56081, F_ALLIANCE, F_HORDE, 4, 37, 41, 51, 52)
	self:addTradeAcquire(RecipeDB, 56081, 2, 28721, 2, 33602)

	-- Quick Dragon's Eye -- 56083
	AddRecipe(56083, 370, 42150, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56083, F_ALLIANCE, F_HORDE, 4, 37, 41)
	self:addTradeAcquire(RecipeDB, 56083, 2, 28721, 2, 33602)

	-- Rigid Dragon's Eye -- 56084
	AddRecipe(56084, 370, 42156, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56084, F_ALLIANCE, F_HORDE, 4, 37, 41)
	self:addTradeAcquire(RecipeDB, 56084, 2, 28721, 2, 33602)

	-- Smooth Dragon's Eye -- 56085
	AddRecipe(56085, 370, 42149, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56085, F_ALLIANCE, F_HORDE, 4, 37, 41)
	self:addTradeAcquire(RecipeDB, 56085, 2, 28721, 2, 33602)

	-- Solid Dragon's Eye -- 56086
	AddRecipe(56086, 370, 36767, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56086, F_ALLIANCE, F_HORDE, 4, 37, 41)
	self:addTradeAcquire(RecipeDB, 56086, 2, 28721, 2, 33602)

	-- Sparkling Dragon's Eye -- 56087
	AddRecipe(56087, 370, 42145, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56087, F_ALLIANCE, F_HORDE, 4, 37, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 56087, 2, 28721, 2, 33602)

	-- Stormy Dragon's Eye -- 56088 
	AddRecipe(56088, 370, 42155, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56088, F_ALLIANCE, F_HORDE, 4, 37, 41, 54)
	self:addTradeAcquire(RecipeDB, 56088, 2, 28721, 2, 33602)

	-- Thick Dragon's Eye -- 56089
	AddRecipe(56089, 370, 42157, 3, 2, 370, 390, 415, 440)
	self:addTradeFlags(RecipeDB, 56089, F_ALLIANCE, F_HORDE, 4, 37, 41, 52)
	self:addTradeAcquire(RecipeDB, 56089, 2, 28721, 2, 33602)

	-- Bloodstone Band -- 56193
	AddRecipe(56193, 350, 42336, 1, 2, 350, 380, 400, 420)
	self:addTradeFlags(RecipeDB, 56193, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 62)
	self:addTradeAcquire(RecipeDB, 56193, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Sun Rock Ring -- 56194
	AddRecipe(56194, 350, 42337, 1, 2, 350, 380, 400, 420)
	self:addTradeFlags(RecipeDB, 56194, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 56194, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Jade Dagger Pendant -- 56195
	AddRecipe(56195, 390, 42338, 1, 2, 380, 400, 410, 420)
	self:addTradeFlags(RecipeDB, 56195, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 63)
	self:addTradeAcquire(RecipeDB, 56195, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Blood Sun Necklace -- 56196
	AddRecipe(56196, 390, 42339, 3, 2, 380, 400, 410, 420)
	self:addTradeFlags(RecipeDB, 56196, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 56196, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Dream Signet -- 56197
	AddRecipe(56197, 420, 42340, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 56197, F_ALLIANCE, F_HORDE, 3, 36, 41, 62)
	self:addTradeAcquire(RecipeDB, 56197, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Ruby Hare -- 56199
	AddRecipe(56199, 400, 42341, 3, 2, 400, 430, 440, 450)
	self:addTradeFlags(RecipeDB, 56199, F_ALLIANCE, F_HORDE, 3, 37, 41, 61)
	self:addTradeAcquire(RecipeDB, 56199, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Twilight Serpent -- 56201
	AddRecipe(56201, 400, 42395, 3, 2, 400, 430, 440, 450)
	self:addTradeFlags(RecipeDB, 56201, F_ALLIANCE, F_HORDE, 3, 37, 41, 53, 54, 61)
	self:addTradeAcquire(RecipeDB, 56201, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Sapphire Owl -- 56202
	AddRecipe(56202, 400, 42413, 3, 2, 400, 430, 440, 450)
	self:addTradeFlags(RecipeDB, 56202, F_ALLIANCE, F_HORDE, 3, 37, 41, 53, 54, 61)
	self:addTradeAcquire(RecipeDB, 56202, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Emerald Boar -- 56203
	AddRecipe(56203, 400, 42418, 3, 2, 400, 430, 440, 450)
	self:addTradeFlags(RecipeDB, 56203, F_ALLIANCE, F_HORDE, 3, 37, 41, 51, 61)
	self:addTradeAcquire(RecipeDB, 56203, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Dark Jade Focusing Lens -- 56205
	AddRecipe(56205, 350, 41367, 2, 2, 350, 360, 370, 380)
	self:addTradeFlags(RecipeDB, 56205, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 56205, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Shadow Crystal Focusing Lens -- 56206
	AddRecipe(56206, 360, 42420, 2, 2, 360, 370, 380, 390)
	self:addTradeFlags(RecipeDB, 56206, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 56206, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Shadow Jade Focusing Lens -- 56208
	AddRecipe(56208, 370, 42421, 1, 2, 370, 380, 390, 400)
	self:addTradeFlags(RecipeDB, 56208, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 56208, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Titanium Impact Band -- 56496
	AddRecipe(56496, 430, 42642, 4, 2, 430, 450, 455, 460)
	self:addTradeFlags(RecipeDB, 56496, F_ALLIANCE, F_HORDE, 4, 36, 41, 51, 62)
	self:addTradeAcquire(RecipeDB, 56496, 2, 28721, 2, 33602)

	-- Titanium Earthguard Ring -- 56497
	AddRecipe(56497, 430, 42643, 4, 2, 430, 450, 455, 460)
	self:addTradeFlags(RecipeDB, 56497, F_ALLIANCE, F_HORDE, 4, 36, 41, 52, 62)
	self:addTradeAcquire(RecipeDB, 56497, 2, 28721, 2, 33602)

	-- Titanium Spellshock Ring -- 56498
	AddRecipe(56498, 430, 42644, 4, 2, 430, 450, 455, 460)
	self:addTradeFlags(RecipeDB, 56498, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 56498, 2, 28721, 2, 33602)

	-- Titanium Impact Choker -- 56499
	AddRecipe(56499, 440, 42645, 4, 2, 440, 450, 455, 460)
	self:addTradeFlags(RecipeDB, 56499, F_ALLIANCE, F_HORDE, 4, 36, 41, 51, 63)
	self:addTradeAcquire(RecipeDB, 56499, 2, 28721, 2, 33602)

	-- Titanium Earthguard Chain -- 56500
	AddRecipe(56500, 440, 42646, 4, 2, 440, 450, 455, 460)
	self:addTradeFlags(RecipeDB, 56500, F_ALLIANCE, F_HORDE, 4, 36, 41, 52, 63)
	self:addTradeAcquire(RecipeDB, 56500, 2, 28721, 2, 33602)

	-- Titanium Spellshock Necklace -- 56501
	AddRecipe(56501, 440, 42647, 4, 2, 440, 450, 455, 460)
	self:addTradeFlags(RecipeDB, 56501, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 56501, 2, 28721, 2, 33602)

	-- Enchanted Pearl -- 56530
	AddRecipe(56530, 360, 42701, 1, 2, 360, 380, 400, 420)
	self:addTradeFlags(RecipeDB, 56530, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 56530, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Enchanted Tear -- 56531
	AddRecipe(56531, 390, 42702, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 56531, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 56531, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Crystal Citrine Necklace -- 58141
	AddRecipe(58141, 350, 43244, 1, 2, 350, 380, 400, 420)
	self:addTradeFlags(RecipeDB, 58141, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 58141, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Crystal Chalcedony Amulet -- 58142
	AddRecipe(58142, 350, 43245, 1, 2, 350, 380, 400, 420)
	self:addTradeFlags(RecipeDB, 58142, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 63)
	self:addTradeAcquire(RecipeDB, 58142, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Earthshadow Ring -- 58143
	AddRecipe(58143, 370, 43246, 1, 2, 370, 390, 405, 420)
	self:addTradeFlags(RecipeDB, 58143, F_ALLIANCE, F_HORDE, 3, 37, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 58143, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Jade Ring of Slaying -- 58144
	AddRecipe(58144, 370, 43247, 1, 2, 370, 390, 405, 420)
	self:addTradeFlags(RecipeDB, 58144, F_ALLIANCE, F_HORDE, 3, 37, 41, 51, 52, 62)
	self:addTradeAcquire(RecipeDB, 58144, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Stoneguard Band -- 58145
	AddRecipe(58145, 390, 43248, 1, 2, 390, 410, 420, 430)
	self:addTradeFlags(RecipeDB, 58145, F_ALLIANCE, F_HORDE, 3, 36, 41, 52, 62)
	self:addTradeAcquire(RecipeDB, 58145, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Shadowmight Ring -- 58146
	AddRecipe(58146, 390, 43249, 1, 2, 390, 410, 420, 430)
	self:addTradeFlags(RecipeDB, 58146, F_ALLIANCE, F_HORDE, 3, 36, 41, 62)
	self:addTradeAcquire(RecipeDB, 58146, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Ring of Earthen Might -- 58147
	AddRecipe(58147, 420, 43250, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 58147, F_ALLIANCE, F_HORDE, 4, 36, 41, 52, 62)
	self:addTradeAcquire(RecipeDB, 58147, 2, 28721, 2, 33602)

	-- Ring of Scarlet Shadows -- 58148
	AddRecipe(58148, 420, 43251, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 58148, F_ALLIANCE, F_HORDE, 4, 36, 41, 51, 62)
	self:addTradeAcquire(RecipeDB, 58148, 2, 28721, 2, 33602)

	-- Windfire Band -- 58149
	AddRecipe(58149, 420, 43252, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 58149, F_ALLIANCE, F_HORDE, 4, 36, 41, 62)
	self:addTradeAcquire(RecipeDB, 58149, 2, 28721, 2, 33602)

	-- Ring of Northern Tears -- 58150
	AddRecipe(58150, 420, 43253, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 58150, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 58150, 2, 28721, 2, 33602)

	-- Savage Titanium Ring -- 58492
	AddRecipe(58492, 420, 43482, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 58492, F_ALLIANCE, F_HORDE, 4, 36, 41, 51, 62)
	self:addTradeAcquire(RecipeDB, 58492, 2, 28721, 2, 33602)

	-- Savage Titanium Band -- 58507
	AddRecipe(58507, 420, 43498, 3, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 58507, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 58507, 2, 28721, 2, 33602)

	-- Titanium Frostguard Ring -- 58954
	AddRecipe(58954, 420, 43582, 4, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 58954, F_ALLIANCE, F_HORDE, 4, 36, 41, 62)
	self:addTradeAcquire(RecipeDB, 58954, 2, 28721, 2, 33602)

	-- Monarch Crab -- 59759
	AddRecipe(59759, 400, 44063, 1, 2, 400, 430, 440, 450)
	self:addTradeFlags(RecipeDB, 59759, F_ALLIANCE, F_HORDE, 3, 37, 41, 52, 61)
	self:addTradeAcquire(RecipeDB, 59759, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Icy Prism -- 62242
	AddRecipe(62242, 425, 44943, 1, 2, 425, 445, 457, 470)
	self:addTradeFlags(RecipeDB, 62242, F_ALLIANCE, F_HORDE, 3, 37, 41)
	self:addTradeAcquire(RecipeDB, 62242, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Shifting Twilight Opal -- 53963
	AddRecipe(53963, 390, 40023, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53963, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 53963, 2, 28721, 2, 33602)

	-- Subtle Scarlet Ruby -- 53948
	AddRecipe(53948, 390, 40000, 3, 2, 390, 410, 425, 440)
	self:addTradeFlags(RecipeDB, 53948, F_ALLIANCE, F_HORDE, 4, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 53948, 2, 28721, 2, 33602)

	-- Emerald Choker -- 64725
	AddRecipe(64725, 420, 45812, 1, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 64725, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 63)
	self:addTradeAcquire(RecipeDB, 64725, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Runed Mana Band -- 64727
	AddRecipe(64727, 420, 45808, 1, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 64727, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 62)
	self:addTradeAcquire(RecipeDB, 64727, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Scarlet Signet -- 64728
	AddRecipe(64728, 420, 45809, 1, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 64728, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 62)
	self:addTradeAcquire(RecipeDB, 64728, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Sky Sapphire Amulet -- 64726
	AddRecipe(64726, 420, 45813, 1, 2, 420, 440, 450, 460)
	self:addTradeFlags(RecipeDB, 64726, F_ALLIANCE, F_HORDE, 3, 36, 41, 53, 54, 63)
	self:addTradeAcquire(RecipeDB, 64726, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 33590)

	-- Prismatic Black Diamond -- 62941
	AddRecipe(62941, 300, 45054, 1, 2, 300, 310, 315, 320)
	self:addTradeFlags(RecipeDB, 62941, F_ALLIANCE, F_HORDE, 3, 36, 41)
	self:addTradeAcquire(RecipeDB, 62941, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 18751, 1, 33590, 1, 33614, 1, 19063, 1, 19539, 1, 18774, 1, 33680)

	-- Amulet of Truesight -- 63743
	AddRecipe(63743, 200, 45627, 1, 2, 200, 210, 220, 230)
	self:addTradeFlags(RecipeDB, 63743, F_ALLIANCE, F_HORDE, 3, 36, 41, 51, 63)
	self:addTradeAcquire(RecipeDB, 63743, 1, 26915, 1, 26960, 1, 26982, 1, 26997, 1, 28701, 1, 19778, 1, 15501, 1, 18751, 1, 33590, 1, 19775, 1, 33614, 1, 19063, 1, 19539, 1, 18774, 1, 33680)

	-- Precise Cardinal Ruby -- 66450
	AddRecipe(66450, 450, 40118, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66450, F_ALLIANCE, F_HORDE, 4, 36, 41, 51, 52)
	self:addTradeAcquire(RecipeDB, 66450, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Runed Cardinal Ruby -- 66446
	AddRecipe(66446, 450, 40113, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66446, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66446, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Bright Cardinal Ruby -- 66449
	AddRecipe(66449, 450, 40114, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66449, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66449, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Flashing Cardinal Ruby -- 66453
	AddRecipe(66453, 450, 40116, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66453, F_ALLIANCE, F_HORDE, 4, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 66453, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Fractured Cardinal Ruby -- 66451
	AddRecipe(66451, 450, 40117, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66451, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66451, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Bold Cardinal Ruby -- 66447
	AddRecipe(66447, 450, 40111, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66447, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66447, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Delicate Cardinal Ruby -- 66448
	AddRecipe(66448, 450, 40112, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66448, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66448, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Subtle Cardinal Ruby -- 66452
	AddRecipe(66452, 450, 40115, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66452, F_ALLIANCE, F_HORDE, 4, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 66452, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Sparkling Majestic Zircon -- 66498
	AddRecipe(66498, 450, 40120, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66498, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66498, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Lustrous Majestic Zircon -- 66500
	AddRecipe(66500, 450, 40121, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66500, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66500, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Stormy Majestic Zircon -- 66499
	AddRecipe(66499, 450, 40122, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66499, F_ALLIANCE, F_HORDE, 4, 36, 41, 54)
	self:addTradeAcquire(RecipeDB, 66499, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Solid Majestic Zircon -- 66497
	AddRecipe(66497, 450, 40119, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66497, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 66497, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Brilliant King's Amber -- 66503
	AddRecipe(66503, 450, 40123, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66503, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 66503, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Rigid King's Amber -- 66501
	AddRecipe(66501, 450, 40125, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66501, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 66501, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Thick King's Amber -- 66504
	AddRecipe(66504, 450, 40126, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66504, F_ALLIANCE, F_HORDE, 4, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 66504, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Mystic King's Amber -- 66505
	AddRecipe(66505, 450, 40127, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66505, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 66505, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Smooth King's Amber -- 66502
	AddRecipe(66502, 450, 40124, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66502, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 66502, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Quick King's Amber -- 66506
	AddRecipe(66506, 450, 40128, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66506, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 66506, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Sovereign Dreadstone -- 66554
	AddRecipe(66554, 450, 40129, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66554, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66554, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Shifting Dreadstone -- 66557
	AddRecipe(66557, 450, 40130, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66557, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66557, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Glowing Dreadstone -- 66555
	AddRecipe(66555, 450, 40132, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66555, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66555, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Purified Dreadstone -- 66556
	AddRecipe(66556, 450, 40133, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66556, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66556, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Guardian's Dreadstone -- 66561
	AddRecipe(66561, 450, 40141, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66561, F_ALLIANCE, F_HORDE, 4, 36, 41, 51, 52)
	self:addTradeAcquire(RecipeDB, 66561, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Puissant Dreadstone -- 66563
	AddRecipe(66563, 450, 40140, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66563, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66563, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Regal Dreadstone -- 66559
	AddRecipe(66559, 450, 40138, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66559, F_ALLIANCE, F_HORDE, 4, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 66559, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Balanced Dreadstone -- 66553
	AddRecipe(66553, 450, 40136, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66553, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66553, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Infused Dreadstone -- 66564
	AddRecipe(66564, 450, 40137, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66564, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66564, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Royal Dreadstone -- 66558
	AddRecipe(66558, 450, 40134, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66558, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66558, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Tenuous Dreadstone -- 66565
	AddRecipe(66565, 450, 40131, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66565, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66565, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Mysterious Dreadstone -- 66562
	AddRecipe(66562, 450, 40135, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66562, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66562, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Defender's Dreadstone -- 66560
	AddRecipe(66560, 450, 40139, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66560, F_ALLIANCE, F_HORDE, 4, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 66560, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Etched Ametrine -- 66572
	AddRecipe(66572, 450, 40143, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66572, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66572, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Champion's Ametrine -- 66579
	AddRecipe(66579, 450, 40144, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66579, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66579, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Fierce Ametrine -- 66583
	AddRecipe(66583, 450, 40146, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66583, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66583, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Deadly Ametrine -- 66568
	AddRecipe(66568, 450, 40147, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66568, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66568, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Luminous Ametrine -- 66566
	AddRecipe(66566, 450, 40151, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66566, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66566, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Reckless Ametrine -- 66574
	AddRecipe(66574, 450, 40155, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66574, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66574, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Wicked Ametrine -- 66577
	AddRecipe(66577, 450, 40156, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66577, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66577, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Empowered Ametrine -- 66580
	AddRecipe(66580, 450, 40158, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66580, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66580, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Glinting Ametrine -- 66575
	AddRecipe(66575, 450, 40148, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66575, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66575, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Deft Ametrine -- 66584
	AddRecipe(66584, 450, 40150, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66584, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66584, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Potent Ametrine -- 66569
	AddRecipe(66569, 450, 40152, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66569, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66569, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Durable Ametrine -- 66571
	AddRecipe(66571, 450, 40154, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66571, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66571, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Stark Ametrine -- 66587
	AddRecipe(66587, 450, 40159, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66587, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66587, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Stalwart Ametrine -- 66581
	AddRecipe(66581, 450, 40160, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66581, F_ALLIANCE, F_HORDE, 4, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 66581, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Accurate Ametrine -- 66576
	AddRecipe(66576, 450, 40162, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66576, F_ALLIANCE, F_HORDE, 4, 36, 41, 51, 52)
	self:addTradeAcquire(RecipeDB, 66576, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Resolute Ametrine -- 66586
	AddRecipe(66586, 450, 40163, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66586, F_ALLIANCE, F_HORDE, 4, 36, 41, 51, 52)
	self:addTradeAcquire(RecipeDB, 66586, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Inscribed Ametrine -- 66567
	AddRecipe(66567, 450, 40142, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66567, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66567, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Resplendent Ametrine -- 66582
	AddRecipe(66582, 450, 40145, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66582, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66582, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Lucent Ametrine -- 66585
	AddRecipe(66585, 450, 40149, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66585, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66585, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Veiled Ametrine -- 66570
	AddRecipe(66570, 450, 40153, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66570, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66570, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Pristine Ametrine -- 66573
	AddRecipe(66573, 450, 40157, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66573, F_ALLIANCE, F_HORDE, 4, 36, 41, 51)
	self:addTradeAcquire(RecipeDB, 66573, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Glimmering Ametrine -- 66578
	AddRecipe(66578, 450, 40161, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66578, F_ALLIANCE, F_HORDE, 4, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 66578, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Misty Eye of Zul -- 66435
	AddRecipe(66435, 450, 40171, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66435, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66435, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Shining Eye of Zul -- 66437
	AddRecipe(66437, 450, 40172, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66437, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66437, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Turbid Eye of Zul -- 66445
	AddRecipe(66445, 450, 40173, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66445, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66445, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Intricate Eye of Zul -- 66440
	AddRecipe(66440, 450, 40174, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66440, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66440, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Sundered Eye of Zul -- 66436
	AddRecipe(66436, 450, 40176, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66436, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66436, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Lambent Eye of Zul -- 66439
	AddRecipe(66439, 450, 40177, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66439, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66439, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Opaque Eye of Zul -- 66444
	AddRecipe(66444, 450, 40178, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66444, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66444, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Radiant Eye of Zul -- 66441
	AddRecipe(66441, 450, 40180, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66441, F_ALLIANCE, F_HORDE, 4, 36, 41, 54)
	self:addTradeAcquire(RecipeDB, 66441, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Tense Eye of Zul -- 66438
	AddRecipe(66438, 450, 40181, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66438, F_ALLIANCE, F_HORDE, 4, 36, 41, 54)
	self:addTradeAcquire(RecipeDB, 66438, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Shattered Eye of Zul -- 66443
	AddRecipe(66443, 450, 40182, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66443, F_ALLIANCE, F_HORDE, 4, 36, 41, 54)
	self:addTradeAcquire(RecipeDB, 66443, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Vivid Eye of Zul -- 66429
	AddRecipe(66429, 450, 40166, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66429, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 66429, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Enduring Eye of Zul -- 66338
	AddRecipe(66338, 450, 40167, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66338, F_ALLIANCE, F_HORDE, 4, 36, 41, 52)
	self:addTradeAcquire(RecipeDB, 66338, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Steady Eye of Zul -- 66428
	AddRecipe(66428, 450, 40168, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66428, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 66428, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Forceful Eye of Zul -- 66434
	AddRecipe(66434, 450, 40169, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66434, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 66434, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Energized Eye of Zul -- 66442
	AddRecipe(66442, 450, 40179, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66442, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66442, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Timeless Eye of Zul -- 66432
	AddRecipe(66432, 450, 40164, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66432, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 66432, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Dazzling Eye of Zul -- 66430
	AddRecipe(66430, 450, 40175, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66430, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66430, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Jagged Eye of Zul -- 66431
	AddRecipe(66431, 450, 40165, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66431, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 66431, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Seer's Eye of Zul -- 66433
	AddRecipe(66433, 450, 40170, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 66433, F_ALLIANCE, F_HORDE, 4, 36, 41, 53, 54)
	self:addTradeAcquire(RecipeDB, 66433, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	-- Nightmare Tear -- 68253
	AddRecipe(68253, 450, 49110, 2, 2, 450, 450, 452, 465)
	self:addTradeFlags(RecipeDB, 68253, F_ALLIANCE, F_HORDE, 4, 36, 41)
	self:addTradeAcquire(RecipeDB, 68253, 2, 19065, 2, 33637, 2, 33680, 2, 28701)

	return num_recipes

end
