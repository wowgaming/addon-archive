--[[
************************************************************************
Runeforging.lua
Runeforging data for all of Ackis Recipe List
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
local F_DK  = 21
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

function addon:InitRuneforging(RecipeDB)

	if initialized then
		return num_recipes
	end

	initialized = true

	--------------------------------------------------------------------------------------------------------------------
	-- Counter and wrapper function
	--------------------------------------------------------------------------------------------------------------------
	local function AddRecipe(SpellID)
		num_recipes = num_recipes + 1
		self:addTradeSkill(RecipeDB, SpellID, 1, nil, R_COMMON, 53428, nil, GAME_WOTLK, 1, 1, 1, 1)
	end

	-- Rune of the Fallen Crusader - 53344
	AddRecipe(53344)
	self:addTradeFlags(RecipeDB,53344, F_ALLIANCE, F_HORDE, F_TRAINER, F_DK, F_2H, F_RBOP, F_IBOP)
	self:addTradeAcquire(RecipeDB,53344, A_TRAINER, 29194, A_TRAINER, 29196, A_TRAINER, 29195, A_TRAINER, 31084)

	-- Rune of Swordshattering - 53323
	AddRecipe(53323)
	self:addTradeFlags(RecipeDB,53323, F_ALLIANCE, F_HORDE, F_TRAINER, F_DK, F_2H, F_RBOP, F_IBOP)
	self:addTradeAcquire(RecipeDB,53323, A_TRAINER, 29194, A_TRAINER, 29196, A_TRAINER, 29195, A_TRAINER, 31084)

	-- Rune of Swordbreaking - 54446
	AddRecipe(54446)
	self:addTradeFlags(RecipeDB,54446, F_ALLIANCE, F_HORDE, F_TRAINER, F_DK, F_2H, F_RBOP, F_IBOP)
	self:addTradeAcquire(RecipeDB,54446, A_TRAINER, 29194, A_TRAINER, 29196, A_TRAINER, 29195, A_TRAINER, 31084)

	-- Rune of Spellshattering - 53342
	AddRecipe(53342)
	self:addTradeFlags(RecipeDB,53342, F_ALLIANCE, F_HORDE, F_TRAINER, F_DK, F_2H, F_RBOP, F_IBOP)
	self:addTradeAcquire(RecipeDB,53342, A_TRAINER, 29194, A_TRAINER, 29196, A_TRAINER, 29195, A_TRAINER, 31084)

	-- Rune of Spellbreaking - 54447
	AddRecipe(54447)
	self:addTradeFlags(RecipeDB,54447, F_ALLIANCE, F_HORDE, F_TRAINER, F_DK, F_2H, F_RBOP, F_IBOP)
	self:addTradeAcquire(RecipeDB,54447, A_TRAINER, 29194, A_TRAINER, 29196, A_TRAINER, 29195, A_TRAINER, 31084)

	-- Rune of Razorice - 53343
	AddRecipe(53343)
	self:addTradeFlags(RecipeDB,53343, F_ALLIANCE, F_HORDE, F_TRAINER, F_DK, F_2H, F_RBOP, F_IBOP)
	self:addTradeAcquire(RecipeDB,53343, A_TRAINER, 29194, A_TRAINER, 29196, A_TRAINER, 29195, A_TRAINER, 31084)

	-- Rune of Lichbane - 53331
	AddRecipe(53331)
	self:addTradeFlags(RecipeDB,53331, F_ALLIANCE, F_HORDE, F_TRAINER, F_DK, F_2H, F_RBOP, F_IBOP)
	self:addTradeAcquire(RecipeDB,53331, A_TRAINER, 29194, A_TRAINER, 29196, A_TRAINER, 29195, A_TRAINER, 31084)

	-- Rune of Cinderglacier - 53341
	AddRecipe(53341)
	self:addTradeFlags(RecipeDB,53341, F_ALLIANCE, F_HORDE, F_TRAINER, F_DK, F_2H, F_RBOP, F_IBOP)
	self:addTradeAcquire(RecipeDB,53341, A_TRAINER, 29194, A_TRAINER, 29196, A_TRAINER, 29195, A_TRAINER, 31084)

	-- Rune of the Stoneskin Gargoyle - 62158
	AddRecipe(62158)
	self:addTradeFlags(RecipeDB,62158, F_ALLIANCE, F_HORDE, F_TRAINER, F_DK, F_2H, F_RBOP, F_IBOP)
	self:addTradeAcquire(RecipeDB,62158, A_TRAINER, 29194, A_TRAINER, 29196, A_TRAINER, 29195, A_TRAINER, 31084)

	-- Rune of the Nerubian Carapace - 70164
	AddRecipe(70164)
	self:addTradeFlags(RecipeDB,70164, F_ALLIANCE, F_HORDE, F_TRAINER, F_DK, F_2H, F_RBOP, F_IBOP)
	self:addTradeAcquire(RecipeDB,70164, A_TRAINER, 29194, A_TRAINER, 29196, A_TRAINER, 29195, A_TRAINER, 31084)
	
	return num_recipes

end
