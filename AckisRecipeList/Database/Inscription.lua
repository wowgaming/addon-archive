--[[
************************************************************************
Inscription.lua
Inscription data for all of Ackis Recipe List
************************************************************************
File date: 2009-12-30T10:16:20Z 
File revision: 2785 
Project revision: 2817
Project version: v1.0-r2818
************************************************************************
Format:

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

function addon:InitInscription(RecipeDB)

	if initialized then
		return num_recipes
	end

	initialized = true

	--------------------------------------------------------------------------------------------------------------------
	-- Counter and wrapper function
	--------------------------------------------------------------------------------------------------------------------
	local function AddRecipe(SpellID, Skill, ItemID, Rarity, Game, Orange, Yellow, Green, Gray)
		num_recipes = num_recipes + 1
		self:addTradeSkill(RecipeDB, SpellID, Skill, ItemID, Rarity, 45357, nil, Game, Orange, Yellow, Green, Gray)
	end

	-- Scroll of Stamina -- 45382
	AddRecipe(45382,25,1180,1,2,1,35,40,45)
	self:addTradeFlags(RecipeDB,45382,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,45382,8,8)

	-- Scroll of Intellect -- 48114
	AddRecipe(48114,25,955,1,2,25,35,40,45)
	self:addTradeFlags(RecipeDB,48114,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,48114,8,8)

	-- Scroll of Spirit -- 48116
	AddRecipe(48116,25,1181,1,2,35,35,40,45)
	self:addTradeFlags(RecipeDB,48116,1,2,3,36,41,53,54)
	self:addTradeAcquire(RecipeDB,48116,8,8)

	-- Glyph of Entangling Roots -- 48121
	AddRecipe(48121,100,40924,1,2,100,105,110,115)
	self:addTradeFlags(RecipeDB,48121,1,2,3,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,48121,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Mysterious Tarot -- 48247
	AddRecipe(48247,110,37168,1,2,110,125,137,150)
	self:addTradeFlags(RecipeDB,48247,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,48247,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Recall -- 48248
	AddRecipe(48248,35,37118,1,2,35,60,67,75)
	self:addTradeFlags(RecipeDB,48248,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,48248,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Intellect II -- 50598
	AddRecipe(50598,75,2290,1,2,75,75,80,85)
	self:addTradeFlags(RecipeDB,50598,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,50598,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Intellect III -- 50599
	AddRecipe(50599,165,4419,1,2,165,170,175,180)
	self:addTradeFlags(RecipeDB,50599,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,50599,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Intellect IV -- 50600
	AddRecipe(50600,215,10308,1,2,215,220,225,230)
	self:addTradeFlags(RecipeDB,50600,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,50600,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Intellect V -- 50601
	AddRecipe(50601,260,27499,1,2,260,265,270,275)
	self:addTradeFlags(RecipeDB,50601,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,50601,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Intellect VI -- 50602
	AddRecipe(50602,310,33458,1,2,310,310,315,320)
	self:addTradeFlags(RecipeDB,50602,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,50602,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Intellect VII -- 50603
	AddRecipe(50603,360,37091,1,2,360,365,370,375)
	self:addTradeFlags(RecipeDB,50603,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,50603,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Scroll of Intellect VIII -- 50604
	AddRecipe(50604,410,37092,1,2,410,415,420,425)
	self:addTradeFlags(RecipeDB,50604,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,50604,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Scroll of Spirit II -- 50605
	AddRecipe(50605,75,1712,1,2,75,75,80,85)
	self:addTradeFlags(RecipeDB,50605,1,2,3,36,41,53,54)
	self:addTradeAcquire(RecipeDB,50605,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Spirit III -- 50606
	AddRecipe(50606,160,4424,1,2,160,165,170,175)
	self:addTradeFlags(RecipeDB,50606,1,2,3,36,41,53,54)
	self:addTradeAcquire(RecipeDB,50606,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Spirit IV -- 50607
	AddRecipe(50607,210,10306,1,2,210,215,220,225)
	self:addTradeFlags(RecipeDB,50607,1,2,3,36,41,53,54)
	self:addTradeAcquire(RecipeDB,50607,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Spirit V -- 50608
	AddRecipe(50608,255,27501,1,2,255,260,265,270)
	self:addTradeFlags(RecipeDB,50608,1,2,3,36,41,53,54)
	self:addTradeAcquire(RecipeDB,50608,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Spirit VI -- 50609
	AddRecipe(50609,295,33460,1,2,295,305,310,315)
	self:addTradeFlags(RecipeDB,50609,1,2,3,36,41,53,54)
	self:addTradeAcquire(RecipeDB,50609,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Spirit VII -- 50610
	AddRecipe(50610,355,37097,1,2,355,360,365,370)
	self:addTradeFlags(RecipeDB,50610,1,2,3,36,41,53,54)
	self:addTradeAcquire(RecipeDB,50610,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Scroll of Spirit VIII -- 50611
	AddRecipe(50611,405,37098,1,2,405,410,415,420)
	self:addTradeFlags(RecipeDB,50611,1,2,3,36,41,53,54)
	self:addTradeAcquire(RecipeDB,50611,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Scroll of Stamina II -- 50612
	AddRecipe(50612,75,1711,1,2,75,75,80,85)
	self:addTradeFlags(RecipeDB,50612,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,50612,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Stamina III -- 50614
	AddRecipe(50614,155,4422,1,2,155,160,165,170)
	self:addTradeFlags(RecipeDB,50614,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,50614,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Stamina IV -- 50616
	AddRecipe(50616,205,10307,1,2,205,210,215,220)
	self:addTradeFlags(RecipeDB,50616,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,50616,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Stamina V -- 50617
	AddRecipe(50617,250,27502,1,2,250,255,260,265)
	self:addTradeFlags(RecipeDB,50617,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,50617,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Stamina VI -- 50618
	AddRecipe(50618,290,33461,1,2,290,300,305,310)
	self:addTradeFlags(RecipeDB,50618,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,50618,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Stamina VII -- 50619
	AddRecipe(50619,350,37093,1,2,350,355,360,365)
	self:addTradeFlags(RecipeDB,50619,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,50619,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Scroll of Stamina VIII -- 50620
	AddRecipe(50620,400,37094,1,2,400,405,410,415)
	self:addTradeFlags(RecipeDB,50620,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,50620,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Ivory Ink -- 52738
	AddRecipe(52738,1,37101,1,2,1,15,22,30)
	self:addTradeFlags(RecipeDB,52738,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,52738,8,8)

	-- Armor Vellum -- 52739
	AddRecipe(52739,35,38682,1,2,35,75,87,100)
	self:addTradeFlags(RecipeDB,52739,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,52739,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Weapon Vellum -- 52840
	AddRecipe(52840,75,39349,1,2,75,100,112,125)
	self:addTradeFlags(RecipeDB,52840,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,52840,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Moonglow Ink -- 52843
	AddRecipe(52843,35,39469,1,2,35,45,60,75)
	self:addTradeFlags(RecipeDB,52843,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,52843,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Midnight Ink -- 53462
	AddRecipe(53462,75,39774,1,2,75,75,77,80)
	self:addTradeFlags(RecipeDB,53462,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,53462,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Frenzied Regeneration -- 56943
	AddRecipe(56943,350,40896,1,2,350,355,360,365)
	self:addTradeFlags(RecipeDB,56943,1,2,3,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,56943,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Growl -- 56944
	AddRecipe(56944,385,40899,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,56944,1,2,12,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,56944,8,15)

	-- Glyph of Healing Touch -- 56945
	AddRecipe(56945,115,40914,1,2,115,120,125,130)
	self:addTradeFlags(RecipeDB,56945,1,2,3,F_DRUID,36,41,53)
	self:addTradeAcquire(RecipeDB,56945,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Hurricane -- 56946
	AddRecipe(56946,385,40920,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,56946,1,2,12,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,56946,8,15)

	-- Glyph of Innervate -- 56947
	AddRecipe(56947,385,40908,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,56947,1,2,12,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,56947,8,15)

	-- Glyph of Insect Swarm -- 56948
	AddRecipe(56948,150,40919,1,2,150,155,160,165)
	self:addTradeFlags(RecipeDB,56948,1,2,3,F_DRUID,36,41,54)
	self:addTradeAcquire(RecipeDB,56948,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Lifebloom -- 56949
	AddRecipe(56949,385,40915,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,56949,1,2,12,F_DRUID,36,41,53)
	self:addTradeAcquire(RecipeDB,56949,8,15)

	-- Glyph of Mangle -- 56950
	AddRecipe(56950,385,40900,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,56950,1,2,12,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,56950,8,15)

	-- Glyph of Moonfire -- 56951
	AddRecipe(56951,130,40923,1,2,130,135,140,145)
	self:addTradeFlags(RecipeDB,56951,1,2,3,F_DRUID,36,41,54)
	self:addTradeAcquire(RecipeDB,56951,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Rake -- 56952
	AddRecipe(56952,310,40903,1,2,310,315,320,325)
	self:addTradeFlags(RecipeDB,56952,1,2,3,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,56952,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Rebirth -- 56953
	AddRecipe(56953,170,40909,1,2,170,175,180,185)
	self:addTradeFlags(RecipeDB,56953,1,2,3,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,56953,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Regrowth -- 56954
	AddRecipe(56954,385,40912,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,56954,1,2,12,F_DRUID,36,41,53)
	self:addTradeAcquire(RecipeDB,56954,8,15)

	-- Glyph of Rejuvenation -- 56955
	AddRecipe(56955,80,40913,1,2,80,90,100,110)
	self:addTradeFlags(RecipeDB,56955,1,2,3,F_DRUID,36,41,53)
	self:addTradeAcquire(RecipeDB,56955,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Rip -- 56956
	AddRecipe(56956,200,40902,1,2,200,205,210,215)
	self:addTradeFlags(RecipeDB,56956,1,2,3,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,56956,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Shred -- 56957
	AddRecipe(56957,260,40901,1,2,260,265,270,275)
	self:addTradeFlags(RecipeDB,56957,1,2,3,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,56957,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Starfall -- 56958
	AddRecipe(56958,385,40921,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,56958,1,2,12,F_DRUID,36,41,54)
	self:addTradeAcquire(RecipeDB,56958,8,15)

	-- Glyph of Starfire -- 56959
	AddRecipe(56959,220,40916,1,2,220,225,230,235)
	self:addTradeFlags(RecipeDB,56959,1,2,3,F_DRUID,36,41,54)
	self:addTradeAcquire(RecipeDB,56959,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Swiftmend -- 56960
	AddRecipe(56960,385,40906,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,56960,1,2,12,F_DRUID,36,41,53)
	self:addTradeAcquire(RecipeDB,56960,8,15)

	-- Glyph of Maul -- 56961
	AddRecipe(56961,90,40897,1,2,90,100,110,120)
	self:addTradeFlags(RecipeDB,56961,1,2,3,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,56961,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Wrath -- 56963
	AddRecipe(56963,85,40922,1,2,85,95,105,115)
	self:addTradeFlags(RecipeDB,56963,1,2,3,F_DRUID,36,41,54)
	self:addTradeAcquire(RecipeDB,56963,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Arcane Explosion -- 56968
	AddRecipe(56968,100,42734,1,2,100,105,110,115)
	self:addTradeFlags(RecipeDB,56968,1,2,3,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56968,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Arcane Missiles -- 56971
	AddRecipe(56971,115,42735,1,2,115,120,125,130)
	self:addTradeFlags(RecipeDB,56971,1,2,3,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56971,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Arcane Power -- 56972
	AddRecipe(56972,335,42736,1,2,335,340,345,350)
	self:addTradeFlags(RecipeDB,56972,1,2,3,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56972,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Blink -- 56973
	AddRecipe(56973,130,42737,1,2,130,135,140,145)
	self:addTradeFlags(RecipeDB,56973,1,2,3,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56973,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,1,30710,1,30711,
	1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Evocation -- 56974
	AddRecipe(56974,155,42738,1,2,155,160,165,170)
	self:addTradeFlags(RecipeDB,56974,1,2,3,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56974,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,1,30710,1,30711,
	1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Fireball -- 56975
	AddRecipe(56975,385,42739,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,56975,1,2,12,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56975,8,15)

	-- Glyph of Frost Nova -- 56976
	AddRecipe(56976,80,42741,1,2,80,90,100,110)
	self:addTradeFlags(RecipeDB,56976,1,2,3,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56976,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Frostbolt -- 56977
	AddRecipe(56977,385,42742,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,56977,1,2,12,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56977,8,15)

	-- Glyph of Ice Armor -- 56978
	AddRecipe(56978,90,42743,1,2,90,100,110,120)
	self:addTradeFlags(RecipeDB,56978,1,2,3,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56978,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Ice Block -- 56979
	AddRecipe(56979,225,42744,1,2,225,230,235,240)
	self:addTradeFlags(RecipeDB,56979,1,2,3,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56979,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,30709,
	1,30706,1,30713,1,30715,1,30716,1,33603,1,33615,1,30710,1,30717,1,30711,1,33679)

	-- Glyph of Ice Lance -- 56980
	AddRecipe(56980,375,42745,1,2,375,380,385,390)
	self:addTradeFlags(RecipeDB,56980,1,2,3,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56980,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Glyph of Icy Veins -- 56981
	AddRecipe(56981,175,42746,1,2,175,180,185,190)
	self:addTradeFlags(RecipeDB,56981,1,2,3,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56981,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Improved Scorch -- 56982
	AddRecipe(56982,205,42747,1,2,205,210,215,220)
	self:addTradeFlags(RecipeDB,56982,1,2,3,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56982,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Invisibility -- 56983
	AddRecipe(56983,385,42748,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,56983,1,2,12,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56983,8,15)

	-- Glyph of Mage Armor -- 56984
	AddRecipe(56984,325,42749,1,2,325,330,335,340)
	self:addTradeFlags(RecipeDB,56984,1,2,3,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56984,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Mana Gem -- 56985
	AddRecipe(56985,280,42750,1,2,280,285,290,295)
	self:addTradeFlags(RecipeDB,56985,1,2,3,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56985,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Molten Armor -- 56986
	AddRecipe(56986,385,42751,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,56986,1,2,12,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56986,8,15)

	-- Glyph of Polymorph -- 56987
	AddRecipe(56987,400,42752,1,2,400,400,400,405)
	self:addTradeFlags(RecipeDB,56987,1,2,3,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56987,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Glyph of Remove Curse -- 56988
	AddRecipe(56988,385,42753,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,56988,1,2,12,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56988,8,15)

	-- Glyph of Water Elemental -- 56989
	AddRecipe(56989,385,42754,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,56989,1,2,12,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,56989,8,15)

	-- Glyph of Aimed Shot -- 56994
	AddRecipe(56994,175,42897,1,2,175,180,185,190)
	self:addTradeFlags(RecipeDB,56994,1,2,3,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,56994,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,1,30709,
	1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Arcane Shot -- 56995
	AddRecipe(56995,100,42898,1,2,100,105,110,115)
	self:addTradeFlags(RecipeDB,56995,1,2,3,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,56995,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Aspect the Beast -- 56996
	AddRecipe(56996,385,42899,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,56996,1,2,12,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,56996,8,15)

	-- Glyph of Mending -- 56997
	AddRecipe(56997,115,42900,1,2,115,120,125,130)
	self:addTradeFlags(RecipeDB,56997,1,2,3,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,56997,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Aspect of the Viper -- 56998
	AddRecipe(56998,385,42901,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,56998,1,2,12,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,56998,8,15)

	-- Glyph of Bestial Wrath -- 56999
	AddRecipe(56999,385,42902,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,56999,1,2,12,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,56999,8,15)

	-- Glyph of Deterrence -- 57000
	AddRecipe(57000,200,42903,1,2,200,205,210,215)
	self:addTradeFlags(RecipeDB,57000,1,2,3,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,57000,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Disengage -- 57001
	AddRecipe(57001,225,42904,1,2,225,230,235,240)
	self:addTradeFlags(RecipeDB,57001,1,2,3,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,57001,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Freezing Trap -- 57002
	AddRecipe(57002,260,42905,1,2,260,265,270,275)
	self:addTradeFlags(RecipeDB,57002,1,2,3,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,57002,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Frost Trap -- 57003
	AddRecipe(57003,350,42906,1,2,350,355,360,365)
	self:addTradeFlags(RecipeDB,57003,1,2,3,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,57003,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Hunter's Mark -- 57004
	AddRecipe(57004,80,42907,1,2,80,90,100,110)
	self:addTradeFlags(RecipeDB,57004,1,2,3,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,57004,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Immolation Trap -- 57005
	AddRecipe(57005,130,42908,1,2,130,135,140,145)
	self:addTradeFlags(RecipeDB,57005,1,2,3,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,57005,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of the Hawk -- 57006
	AddRecipe(57006,375,42909,1,2,375,380,385,390)
	self:addTradeFlags(RecipeDB,57006,1,2,3,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,57006,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Glyph of Multi-Shot -- 57007
	AddRecipe(57007,150,42910,1,2,150,155,160,165)
	self:addTradeFlags(RecipeDB,57007,1,2,3,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,57007,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,
	1,30709,1,30706,1,30713,1,30715,1,30716,1,33603,1,33615,1,30710,1,30717,1,30711,1,33679)

	-- Glyph of Rapid Fire -- 57008
	AddRecipe(57008,315,42911,1,2,315,320,325,330)
	self:addTradeFlags(RecipeDB,57008,1,2,3,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,57008,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Serpent Sting -- 57009
	AddRecipe(57009,90,42912,1,2,90,100,110,120)
	self:addTradeFlags(RecipeDB,57009,1,2,3,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,57009,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Snake Trap -- 57010
	AddRecipe(57010,385,42913,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57010,1,2,12,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,57010,8,15)

	-- Glyph of Steady Shot -- 57011
	AddRecipe(57011,385,42914,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57011,1,2,12,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,57011,8,15)

	-- Glyph of Trueshot Aura -- 57012
	AddRecipe(57012,385,42915,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57012,1,2,12,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,57012,8,15)

	-- Glyph of Volley -- 57013
	AddRecipe(57013,385,42916,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57013,1,2,12,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,57013,8,15)

	-- Glyph of Wyvern Sting -- 57014
	AddRecipe(57014,385,42917,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57014,1,2,12,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,57014,8,15)

	-- Glyph of Avenger's Shield -- 57019
	AddRecipe(57019,385,41101,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57019,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,57019,8,15)

	-- Glyph of Cleansing -- 57020
	AddRecipe(57020,180,41104,1,2,180,185,190,195)
	self:addTradeFlags(RecipeDB,57020,1,2,3,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,57020,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Avenging Wrath -- 57021
	AddRecipe(57021,385,41107,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57021,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,57021,8,15)

	-- Glyph of Spiritual Attunement -- 57022
	AddRecipe(57022,80,41096,1,2,80,90,100,110)
	self:addTradeFlags(RecipeDB,57022,1,2,3,F_PALADIN,36,41,53,54)
	self:addTradeAcquire(RecipeDB,57022,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Consecration -- 57023
	AddRecipe(57023,205,41099,1,2,205,210,215,220)
	self:addTradeFlags(RecipeDB,57023,1,2,3,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,57023,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Crusader Strike -- 57024
	AddRecipe(57024,230,41098,1,2,230,235,240,245)
	self:addTradeFlags(RecipeDB,57024,1,2,3,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,57024,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Exorcism -- 57025
	AddRecipe(57025,265,41103,1,2,265,270,275,280)
	self:addTradeFlags(RecipeDB,57025,1,2,3,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,57025,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Flash of Light -- 57026
	AddRecipe(57026,300,41105,1,2,300,305,310,315)
	self:addTradeFlags(RecipeDB,57026,1,2,3,F_PALADIN,36,41,53)
	self:addTradeAcquire(RecipeDB,57026,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Hammer of Justice -- 57027
	AddRecipe(57027,90,41095,1,2,90,100,110,120)
	self:addTradeFlags(RecipeDB,57027,1,2,3,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,57027,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Hammer of Wrath -- 57028
	AddRecipe(57028,385,41097,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57028,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,57028,8,15)

	-- Glyph of Holy Light -- 57029
	AddRecipe(57029,105,41106,1,2,105,110,115,120)
	self:addTradeFlags(RecipeDB,57029,1,2,3,F_PALADIN,36,41,53)
	self:addTradeAcquire(RecipeDB,57029,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Judgement -- 57030
	AddRecipe(57030,120,41092,1,2,120,125,130,135)
	self:addTradeFlags(RecipeDB,57030,1,2,3,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,57030,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Divinity -- 57031
	AddRecipe(57031,135,41108,1,2,135,140,145,150)
	self:addTradeFlags(RecipeDB,57031,1,2,3,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,57031,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Righteous Defense -- 57032
	AddRecipe(57032,155,41100,1,2,155,160,165,170)
	self:addTradeFlags(RecipeDB,57032,1,2,3,F_PALADIN,36,41,52)
	self:addTradeAcquire(RecipeDB,57032,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Seal of Command -- 57033
	AddRecipe(57033,335,41094,1,2,335,340,345,350)
	self:addTradeFlags(RecipeDB,57033,1,2,3,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,57033,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Seal of Light -- 57034
	AddRecipe(57034,385,41110,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57034,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,57034,8,15)

	-- Glyph of Seal of Wisdom -- 57035
	AddRecipe(57035,385,41109,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57035,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,57035,8,15)

	-- Glyph of Turn Evil -- 57036
	AddRecipe(57036,375,41102,1,2,375,380,385,390)
	self:addTradeFlags(RecipeDB,57036,1,2,3,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,57036,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Glyph of Adrenaline Rush -- 57112
	AddRecipe(57112,385,42954,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57112,1,2,12,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57112,8,15)

	-- Glyph of Ambush -- 57113
	AddRecipe(57113,340,42955,1,2,340,345,350,355)
	self:addTradeFlags(RecipeDB,57113,1,2,3,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57113,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Backstab -- 57114
	AddRecipe(57114,80,42956,1,2,80,90,100,110)
	self:addTradeFlags(RecipeDB,57114,1,2,3,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57114,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Blade Flurry -- 57115
	AddRecipe(57115,385,42957,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57115,1,2,12,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57115,8,15)

	-- Glyph of Crippling Poison -- 57116
	AddRecipe(57116,385,42958,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57116,1,2,12,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57116,8,15)

	-- Glyph of Deadly Throw -- 57117
	AddRecipe(57117,385,42959,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57117,1,2,12,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57117,8,15)

	-- Glyph of Evasion -- 57119
	AddRecipe(57119,95,42960,1,2,95,105,115,125)
	self:addTradeFlags(RecipeDB,57119,1,2,3,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57119,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Eviscerate -- 57120
	AddRecipe(57120,105,42961,1,2,105,110,115,120)
	self:addTradeFlags(RecipeDB,57120,1,2,3,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57120,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Expose Armor -- 57121
	AddRecipe(57121,120,42962,1,2,120,125,130,135)
	self:addTradeFlags(RecipeDB,57121,1,2,3,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57121,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Feint -- 57122
	AddRecipe(57122,305,42963,1,2,305,310,315,320)
	self:addTradeFlags(RecipeDB,57122,1,2,3,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57122,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Garrote -- 57123
	AddRecipe(57123,135,42964,1,2,135,140,145,150)
	self:addTradeFlags(RecipeDB,57123,1,2,3,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57123,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Ghostly Strike -- 57124
	AddRecipe(57124,385,42965,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57124,1,2,12,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57124,8,15)

	-- Glyph of Gouge -- 57125
	AddRecipe(57125,160,42966,1,2,160,165,170,175)
	self:addTradeFlags(RecipeDB,57125,1,2,3,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57125,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Hemorrhage -- 57126
	AddRecipe(57126,385,42967,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57126,1,2,12,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57126,8,15)

	-- Glyph of Preparation -- 57127
	AddRecipe(57127,385,42968,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57127,1,2,12,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57127,8,15)

	-- Glyph of Rupture -- 57128
	AddRecipe(57128,385,42969,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57128,1,2,12,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57128,8,15)

	-- Glyph of Sap -- 57129
	AddRecipe(57129,185,42970,1,2,185,190,195,200)
	self:addTradeFlags(RecipeDB,57129,1,2,3,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57129,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Vigor -- 57130
	AddRecipe(57130,385,42971,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57130,1,2,12,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57130,8,15)

	-- Glyph of Sinister Strike -- 57131
	AddRecipe(57131,210,42972,1,2,210,215,220,225)
	self:addTradeFlags(RecipeDB,57131,1,2,3,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57131,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Slice and Dice -- 57132
	AddRecipe(57132,235,42973,1,2,235,240,245,250)
	self:addTradeFlags(RecipeDB,57132,1,2,3,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57132,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Sprint -- 57133
	AddRecipe(57133,285,42974,1,2,285,290,295,300)
	self:addTradeFlags(RecipeDB,57133,1,2,3,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,57133,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Barbaric Insults -- 57151
	AddRecipe(57151,220,43420,1,2,220,225,230,235)
	self:addTradeFlags(RecipeDB,57151,1,2,3,F_WARRIOR,36,41,51)
	self:addTradeAcquire(RecipeDB,57151,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Blocking -- 57152
	AddRecipe(57152,385,43425,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57152,1,2,12,F_WARRIOR,36,41,52)
	self:addTradeAcquire(RecipeDB,57152,8,15)

	-- Glyph of Bloodthirst -- 57153
	AddRecipe(57153,385,43412,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57153,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,57153,8,15)

	-- Glyph of Cleaving -- 57154
	AddRecipe(57154,240,43414,1,2,240,245,250,255)
	self:addTradeFlags(RecipeDB,57154,1,2,3,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,57154,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Devastate -- 57155
	AddRecipe(57155,385,43415,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57155,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,57155,8,15)

	-- Glyph of Execution -- 57156
	AddRecipe(57156,285,43416,1,2,285,290,295,300)
	self:addTradeFlags(RecipeDB,57156,1,2,3,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,57156,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Hamstring -- 57157
	AddRecipe(57157,125,43417,1,2,125,130,135,140)
	self:addTradeFlags(RecipeDB,57157,1,2,3,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,57157,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Heroic Strike -- 57158
	AddRecipe(57158,95,43418,1,2,95,105,115,125)
	self:addTradeFlags(RecipeDB,57158,1,2,3,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,57158,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Intervene -- 57159
	AddRecipe(57159,385,43419,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57159,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,57159,8,15)

	-- Glyph of Mortal Strike -- 57160
	AddRecipe(57160,385,43421,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57160,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,57160,8,15)

	-- Glyph of Overpower -- 57161
	AddRecipe(57161,170,43422,1,2,170,175,180,185)
	self:addTradeFlags(RecipeDB,57161,1,2,3,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,57161,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Rapid Charge -- 57162
	AddRecipe(57162,85,43413,1,2,85,95,105,115)
	self:addTradeFlags(RecipeDB,57162,1,2,3,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,57162,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Rending -- 57163
	AddRecipe(57163,110,43423,1,2,110,115,120,125)
	self:addTradeFlags(RecipeDB,57163,1,2,3,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,57163,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Resonating Power -- 57164
	AddRecipe(57164,385,43430,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57164,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,57164,8,15)

	-- Glyph of Revenge -- 57165
	AddRecipe(57165,190,43424,1,2,190,195,200,205)
	self:addTradeFlags(RecipeDB,57165,1,2,3,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,57165,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Last Stand -- 57166
	AddRecipe(57166,385,43426,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57166,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,57166,8,15)

	-- Glyph of Sunder Armor -- 57167
	AddRecipe(57167,140,43427,1,2,140,145,150,155)
	self:addTradeFlags(RecipeDB,57167,1,2,3,F_WARRIOR,36,41,52)
	self:addTradeAcquire(RecipeDB,57167,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Sweeping Strikes -- 57168
	AddRecipe(57168,320,43428,1,2,320,325,330,335)
	self:addTradeFlags(RecipeDB,57168,1,2,3,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,57168,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Taunt -- 57169
	AddRecipe(57169,385,43429,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57169,1,2,12,F_WARRIOR,36,41,52)
	self:addTradeAcquire(RecipeDB,57169,8,15)

	-- Glyph of Victory Rush -- 57170
	AddRecipe(57170,385,43431,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57170,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,57170,8,15)

	-- Glyph of Whirlwind -- 57172
	AddRecipe(57172,345,43432,1,2,345,350,355,360)
	self:addTradeFlags(RecipeDB,57172,1,2,3,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,57172,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Circle of Healing -- 57181
	AddRecipe(57181,385,42396,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57181,1,2,12,F_PRIEST,36,41,53)
	self:addTradeAcquire(RecipeDB,57181,8,15)

	-- Glyph of Dispel Magic -- 57183
	AddRecipe(57183,230,42397,1,2,230,235,240,245)
	self:addTradeFlags(RecipeDB,57183,1,2,3,F_PRIEST,36,41,53,54)
	self:addTradeAcquire(RecipeDB,57183,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Fade -- 57184
	AddRecipe(57184,105,42398,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,57184,1,2,3,F_PRIEST,36,41,53,54)
	self:addTradeAcquire(RecipeDB,57184,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Fear Ward -- 57185
	AddRecipe(57185,270,42399,1,2,270,275,280,285)
	self:addTradeFlags(RecipeDB,57185,1,2,3,F_PRIEST,36,41,53,54)
	self:addTradeAcquire(RecipeDB,57185,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Flash Heal -- 57186
	AddRecipe(57186,120,42400,1,2,120,125,130,135)
	self:addTradeFlags(RecipeDB,57186,1,2,3,F_PRIEST,36,41,53)
	self:addTradeAcquire(RecipeDB,57186,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Holy Nova -- 57187
	AddRecipe(57187,315,42401,1,2,315,320,325,330)
	self:addTradeFlags(RecipeDB,57187,1,2,3,F_PRIEST,36,41,53)
	self:addTradeAcquire(RecipeDB,57187,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Inner Fire -- 57188
	AddRecipe(57188,135,42402,1,2,135,140,145,150)
	self:addTradeFlags(RecipeDB,57188,1,2,3,F_PRIEST,36,41,53,54)
	self:addTradeAcquire(RecipeDB,57188,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Lightwell -- 57189
	AddRecipe(57189,385,42403,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57189,1,2,12,F_PRIEST,36,41,53)
	self:addTradeAcquire(RecipeDB,57189,8,15)

	-- Glyph of Mass Dispel -- 57190
	AddRecipe(57190,385,42404,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57190,1,2,12,F_PRIEST,36,41,53,54)
	self:addTradeAcquire(RecipeDB,57190,8,15)

	-- Glyph of Mind Control -- 57191
	AddRecipe(57191,385,42405,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57191,1,2,12,F_PRIEST,36,41,53,54)
	self:addTradeAcquire(RecipeDB,57191,8,15)

	-- Glyph of Mind Flay -- 57192
	AddRecipe(57192,350,42406,1,2,350,355,360,365)
	self:addTradeFlags(RecipeDB,57192,1,2,3,F_PRIEST,36,41,54)
	self:addTradeAcquire(RecipeDB,57192,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Mind Soothe -- 57193
	AddRecipe(57193,385,42407,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57193,1,2,12,F_PRIEST,36,41,53,54)
	self:addTradeAcquire(RecipeDB,57193,8,15)

	-- Glyph of Power Word: Shield -- 57194
	AddRecipe(57194,80,42408,1,2,80,90,100,110)
	self:addTradeFlags(RecipeDB,57194,1,2,3,F_PRIEST,36,41,53)
	self:addTradeAcquire(RecipeDB,57194,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Prayer of Healing -- 57195
	AddRecipe(57195,385,42409,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57195,1,2,12,F_PRIEST,36,41,53)
	self:addTradeAcquire(RecipeDB,57195,8,15)

	-- Glyph of Psychic Scream -- 57196
	AddRecipe(57196,95,42410,1,2,95,105,115,125)
	self:addTradeFlags(RecipeDB,57196,1,2,3,F_PRIEST,36,41,53,54)
	self:addTradeAcquire(RecipeDB,57196,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,
	1,30709,1,30706,1,30713,1,30715,1,30716,1,33603,1,33615,1,30710,1,30717,1,30711,1,33679)

	-- Glyph of Renew -- 57197
	AddRecipe(57197,160,42411,1,2,160,165,170,175)
	self:addTradeFlags(RecipeDB,57197,1,2,3,F_PRIEST,36,41,53)
	self:addTradeAcquire(RecipeDB,57197,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Scourge Imprisonment -- 57198
	AddRecipe(57198,375,42412,1,2,375,380,385,390)
	self:addTradeFlags(RecipeDB,57198,1,2,3,F_PRIEST,36,41,53,54)
	self:addTradeAcquire(RecipeDB,57198,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Glyph of Shadow Word: Death -- 57199
	AddRecipe(57199,385,42414,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57199,1,2,12,F_PRIEST,36,41,54)
	self:addTradeAcquire(RecipeDB,57199,8,15)

	-- Glyph of Shadow Word: Pain -- 57200
	AddRecipe(57200,180,42415,1,2,180,185,190,195)
	self:addTradeFlags(RecipeDB,57200,1,2,3,F_PRIEST,36,41,54)
	self:addTradeAcquire(RecipeDB,57200,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Smite -- 57201
	AddRecipe(57201,210,42416,1,2,210,215,220,225)
	self:addTradeFlags(RecipeDB,57201,1,2,3,F_PRIEST,36,41,54)
	self:addTradeAcquire(RecipeDB,57201,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Spirit of Redemption -- 57202
	AddRecipe(57202,385,42417,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57202,1,2,12,F_PRIEST,36,41,53)
	self:addTradeAcquire(RecipeDB,57202,8,15)

	-- Glyph of Anti-Magic Shell -- 57207
	AddRecipe(57207,385,43533,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57207,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57207,8,15)

	-- Glyph of Blood Boil -- 57208
	AddRecipe(57208,385,43534,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57208,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57208,8,15)

	-- Glyph of Blood Tap -- 57209
	AddRecipe(57209,320,43535,1,2,320,330,335,340)
	self:addTradeFlags(RecipeDB,57209,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57209,8,14)

	-- Glyph of Bone Shield -- 57210
	AddRecipe(57210,265,43536,1,2,265,270,275,280)
	self:addTradeFlags(RecipeDB,57210,1,2,3,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57210,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Chains of Ice -- 57211
	AddRecipe(57211,385,43537,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57211,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57211,8,15)

	-- Glyph of Dark Command -- 57212
	AddRecipe(57212,385,43538,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57212,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57212,8,15)

	-- Glyph of Death Grip -- 57213
	AddRecipe(57213,285,43541,1,2,285,290,295,300)
	self:addTradeFlags(RecipeDB,57213,1,2,3,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57213,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Death and Decay -- 57214
	AddRecipe(57214,385,43542,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57214,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57214,8,15)

	-- Glyph of Death's Embrace -- 57215
	AddRecipe(57215,295,43539,1,2,295,305,310,315)
	self:addTradeFlags(RecipeDB,57215,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57215,8,14)

	-- Glyph of Frost Strike -- 57216
	AddRecipe(57216,270,43543,1,2,270,275,280,285)
	self:addTradeFlags(RecipeDB,57216,1,2,3,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57216,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Horn of Winter -- 57217
	AddRecipe(57217,320,43544,1,2,320,330,335,340)
	self:addTradeFlags(RecipeDB,57217,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57217,8,14)

	-- Glyph of Icebound Fortitude -- 57218
	AddRecipe(57218,385,43545,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57218,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57218,8,15)

	-- Glyph of Icy Touch -- 57219
	AddRecipe(57219,280,43546,1,2,280,285,290,295)
	self:addTradeFlags(RecipeDB,57219,1,2,3,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57219,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,
	1,30709,1,30706,1,30713,1,30715,1,30716,1,33603,1,33615,1,30710,1,30717,1,30711,1,33679)

	-- Glyph of Obliterate -- 57220
	AddRecipe(57220,385,43547,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57220,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57220,8,15)

	-- Glyph of Plague Strike -- 57221
	AddRecipe(57221,300,43548,1,2,300,305,310,315)
	self:addTradeFlags(RecipeDB,57221,1,2,3,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57221,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of the Ghoul -- 57222
	AddRecipe(57222,350,43549,1,2,350,355,360,365)
	self:addTradeFlags(RecipeDB,57222,1,2,3,F_DK,36,41,51)
	self:addTradeAcquire(RecipeDB,57222,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Rune Strike -- 57223
	AddRecipe(57223,385,43550,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57223,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57223,8,15)

	-- Glyph of Scourge Strike -- 57224
	AddRecipe(57224,330,43551,1,2,330,335,340,345)
	self:addTradeFlags(RecipeDB,57224,1,2,3,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57224,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Strangulate -- 57225
	AddRecipe(57225,375,43552,1,2,375,380,385,390)
	self:addTradeFlags(RecipeDB,57225,1,2,3,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57225,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Glyph of Unbreakable Armor -- 57226
	AddRecipe(57226,305,43553,1,2,305,310,315,320)
	self:addTradeFlags(RecipeDB,57226,1,2,3,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57226,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Vampiric Blood -- 57227
	AddRecipe(57227,345,43554,1,2,345,350,355,360)
	self:addTradeFlags(RecipeDB,57227,1,2,3,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57227,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Raise Dead -- 57228
	AddRecipe(57228,295,43673,1,2,295,305,310,315)
	self:addTradeFlags(RecipeDB,57228,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57228,8,15)

	-- Glyph of Corpse Explosion -- 57229
	AddRecipe(57229,295,43671,1,2,295,305,310,315)
	self:addTradeFlags(RecipeDB,57229,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57229,8,14)

	-- Glyph of Pestilence -- 57230
	AddRecipe(57230,295,43672,1,2,295,305,310,315)
	self:addTradeFlags(RecipeDB,57230,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,57230,8,14)

	-- Glyph of Chain Heal -- 57232
	AddRecipe(57232,385,41517,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57232,1,2,12,F_SHAMAN,36,41,53)
	self:addTradeAcquire(RecipeDB,57232,8,15)

	-- Glyph of Chain Lightning -- 57233
	AddRecipe(57233,385,41518,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57233,1,2,12,F_SHAMAN,36,41,54)
	self:addTradeAcquire(RecipeDB,57233,8,15)

	-- Glyph of Lava -- 57234
	AddRecipe(57234,385,41524,1,2,385,390,395,400)
	self:addTradeFlags(RecipeDB,57234,1,2,12,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,57234,8,15)

	-- Glyph of Earth Shock -- 57235
	AddRecipe(57235,385,41526,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57235,1,2,12,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,57235,8,15)

	-- Glyph of Earthliving Weapon -- 57236
	AddRecipe(57236,300,41527,1,2,300,305,310,315)
	self:addTradeFlags(RecipeDB,57236,1,2,3,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,57236,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Fire Elemental Totem -- 57237
	AddRecipe(57237,385,41529,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57237,1,2,12,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,57237,8,15)

	-- Glyph of Fire Nova Totem -- 57238
	AddRecipe(57238,110,41530,1,2,110,115,120,125)
	self:addTradeFlags(RecipeDB,57238,1,2,3,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,57238,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Flame Shock -- 57239
	AddRecipe(57239,85,41531,1,2,85,95,105,115)
	self:addTradeFlags(RecipeDB,57239,1,2,3,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,57239,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Flametongue Weapon -- 57240
	AddRecipe(57240,125,41532,1,2,125,130,135,140)
	self:addTradeFlags(RecipeDB,57240,1,2,3,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,57240,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Frost Shock -- 57241
	AddRecipe(57241,185,41547,1,2,185,190,195,200)
	self:addTradeFlags(RecipeDB,57241,1,2,3,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,57241,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Healing Stream Totem -- 57242
	AddRecipe(57242,215,41533,1,2,215,220,225,230)
	self:addTradeFlags(RecipeDB,57242,1,2,3,F_SHAMAN,36,41,53)
	self:addTradeAcquire(RecipeDB,57242,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Healing Wave -- 57243
	AddRecipe(57243,385,41534,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57243,1,2,12,F_SHAMAN,36,41,53)
	self:addTradeAcquire(RecipeDB,57243,8,15)

	-- Glyph of Lesser Healing Wave -- 57244
	AddRecipe(57244,235,41535,1,2,235,240,245,250)
	self:addTradeFlags(RecipeDB,57244,1,2,3,F_SHAMAN,36,41,53)
	self:addTradeAcquire(RecipeDB,57244,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Lightning Bolt -- 57245
	AddRecipe(57245,140,41536,1,2,140,145,150,155)
	self:addTradeFlags(RecipeDB,57245,1,2,3,F_SHAMAN,36,41,54)
	self:addTradeAcquire(RecipeDB,57245,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Lightning Shield -- 57246
	AddRecipe(57246,95,41537,1,2,95,105,115,125)
	self:addTradeFlags(RecipeDB,57246,1,2,3,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,57246,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Mana Tide Totem -- 57247
	AddRecipe(57247,385,41538,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57247,1,2,12,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,57247,8,15)

	-- Glyph of Stormstrike -- 57248
	AddRecipe(57248,375,41539,1,2,375,380,385,390)
	self:addTradeFlags(RecipeDB,57248,1,2,3,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,57248,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Glyph of Lava Lash -- 57249
	AddRecipe(57249,165,41540,1,2,165,170,175,180)
	self:addTradeFlags(RecipeDB,57249,1,2,3,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,57249,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Elemental Mastery -- 57250
	AddRecipe(57250,385,41552,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57250,1,2,12,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,57250,8,15)

	-- Glyph of Water Mastery -- 57251
	AddRecipe(57251,275,41541,1,2,275,280,285,290)
	self:addTradeFlags(RecipeDB,57251,1,2,3,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,57251,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Windfury Weapon -- 57252
	AddRecipe(57252,330,41542,1,2,330,335,340,345)
	self:addTradeFlags(RecipeDB,57252,1,2,3,F_SHAMAN,36,41,51)
	self:addTradeAcquire(RecipeDB,57252,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Incinerate -- 57257
	AddRecipe(57257,350,42453,1,2,350,355,360,365)
	self:addTradeFlags(RecipeDB,57257,1,2,3,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57257,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Conflagrate -- 57258
	AddRecipe(57258,385,42454,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57258,1,2,12,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57258,8,15)

	-- Glyph of Corruption -- 57259
	AddRecipe(57259,85,42455,1,2,85,95,105,115)
	self:addTradeFlags(RecipeDB,57259,1,2,3,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57259,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Curse of Agony -- 57260
	AddRecipe(57260,385,42456,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57260,1,2,12,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57260,8,15)

	-- Glyph of Death Coil -- 57261
	AddRecipe(57261,385,42457,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57261,1,2,12,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57261,8,15)

	-- Glyph of Fear -- 57262
	AddRecipe(57262,125,42458,1,2,125,130,135,140)
	self:addTradeFlags(RecipeDB,57262,1,2,3,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57262,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Felguard -- 57263
	AddRecipe(57263,385,42459,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57263,1,2,12,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57263,8,15)

	-- Glyph of Felhunter -- 57264
	AddRecipe(57264,385,42460,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57264,1,2,12,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57264,8,15)

	-- Glyph of Health Funnel -- 57265
	AddRecipe(57265,110,42461,1,2,110,115,120,125)
	self:addTradeFlags(RecipeDB,57265,1,2,3,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57265,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Healthstone -- 57266
	AddRecipe(57266,95,42462,1,2,95,105,115,125)
	self:addTradeFlags(RecipeDB,57266,1,2,3,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57266,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Howl of Terror -- 57267
	AddRecipe(57267,385,42463,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57267,1,2,12,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57267,8,15)

	-- Glyph of Immolate -- 57268
	AddRecipe(57268,385,42464,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57268,1,2,12,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57268,8,15)

	-- Glyph of Imp -- 57269
	AddRecipe(57269,140,42465,1,2,140,145,150,155)
	self:addTradeFlags(RecipeDB,57269,1,2,3,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57269,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,
	1,30709,1,30706,1,30713,1,30715,1,30716,1,33603,1,33615,1,30710,1,30717,1,30711,1,33679)

	-- Glyph of Searing Pain -- 57270
	AddRecipe(57270,215,42466,1,2,215,220,225,230)
	self:addTradeFlags(RecipeDB,57270,1,2,3,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57270,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,
	1,30709,1,30706,1,30713,1,30715,1,30716,1,33603,1,33615,1,30710,1,30717,1,30711,1,33679)

	-- Glyph of Shadow Bolt -- 57271
	AddRecipe(57271,165,42467,1,2,165,170,175,180)
	self:addTradeFlags(RecipeDB,57271,1,2,3,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57271,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Shadowburn -- 57272
	AddRecipe(57272,275,42468,1,2,275,280,285,290)
	self:addTradeFlags(RecipeDB,57272,1,2,3,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57272,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Siphon Life -- 57273
	AddRecipe(57273,385,42469,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57273,1,2,12,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57273,8,15)

	-- Glyph of Soulstone -- 57274
	AddRecipe(57274,240,42470,1,2,240,245,250,255)
	self:addTradeFlags(RecipeDB,57274,1,2,3,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57274,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Succubus -- 57275
	AddRecipe(57275,325,42471,1,2,325,330,335,340)
	self:addTradeFlags(RecipeDB,57275,1,2,3,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57275,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Unstable Affliction -- 57276
	AddRecipe(57276,385,42472,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57276,1,2,12,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57276,8,15)

	-- Glyph of Voidwalker -- 57277
	AddRecipe(57277,190,42473,1,2,190,195,200,205)
	self:addTradeFlags(RecipeDB,57277,1,2,3,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,57277,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Hunter's Ink -- 57703
	AddRecipe(57703,85,43115,2,2,85,85,90,95)
	self:addTradeFlags(RecipeDB,57703,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,57703,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Lion's Ink -- 57704
	AddRecipe(57704,100,43116,1,2,100,100,100,105)
	self:addTradeFlags(RecipeDB,57704,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,57704,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Dawnstar Ink -- 57706
	AddRecipe(57706,125,43117,2,2,125,125,130,135)
	self:addTradeFlags(RecipeDB,57706,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,57706,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Jadefire Ink -- 57707
	AddRecipe(57707,150,43118,1,2,150,150,150,155)
	self:addTradeFlags(RecipeDB,57707,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,57707,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Royal Ink -- 57708
	AddRecipe(57708,175,43119,2,2,175,175,175,180)
	self:addTradeFlags(RecipeDB,57708,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,57708,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Celestial Ink -- 57709
	AddRecipe(57709,200,43120,1,2,200,200,200,205)
	self:addTradeFlags(RecipeDB,57709,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,57709,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,
	1,30709,1,30706,1,30713,1,30715,1,30716,1,33603,1,33615,1,30710,1,30717,1,30711,1,33679)

	-- Fiery Ink -- 57710
	AddRecipe(57710,225,43121,2,2,225,225,225,230)
	self:addTradeFlags(RecipeDB,57710,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,57710,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Shimmering Ink -- 57711
	AddRecipe(57711,250,43122,1,2,250,250,250,255)
	self:addTradeFlags(RecipeDB,57711,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,57711,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Ink of the Sky -- 57712
	AddRecipe(57712,275,43123,2,2,275,290,295,300)
	self:addTradeFlags(RecipeDB,57712,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,57712,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Ethereal Ink -- 57713
	AddRecipe(57713,290,43124,1,2,290,295,300,305)
	self:addTradeFlags(RecipeDB,57713,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,57713,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Darkflame Ink -- 57714
	AddRecipe(57714,325,43125,2,2,325,325,325,330)
	self:addTradeFlags(RecipeDB,57714,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,57714,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603,1,33615,1,30722,1,30721,1,33679)

	-- Ink of the Sea -- 57715
	AddRecipe(57715,350,43126,1,2,350,350,350,355)
	self:addTradeFlags(RecipeDB,57715,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,57715,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Snowfall Ink -- 57716
	AddRecipe(57716,375,43127,2,2,375,375,375,380)
	self:addTradeFlags(RecipeDB,57716,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,57716,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Glyph of Fire Blast -- 57719
	AddRecipe(57719,385,42740,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,57719,1,2,12,F_MAGE,36,41)
	self:addTradeAcquire(RecipeDB,57719,8,15)

	-- Glyph of Aquatic Form -- 58286
	AddRecipe(58286,95,43316,1,2,85,105,110,115)
	self:addTradeFlags(RecipeDB,58286,1,2,12,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,58286,8,14)

	-- Glyph of Challenging Roar -- 58287
	AddRecipe(58287,150,43334,1,2,150,155,160,165)
	self:addTradeFlags(RecipeDB,58287,1,2,12,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,58287,8,14)

	-- Glyph of Unburdened Rebirth -- 58288
	AddRecipe(58288,95,43331,1,2,95,105,110,115)
	self:addTradeFlags(RecipeDB,58288,1,2,12,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,58288,8,14)

	-- Glyph of Thorns -- 58289
	AddRecipe(58289,75,43332,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58289,1,2,12,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,58289,8,14)

	-- Glyph of the Wild -- 58296
	AddRecipe(58296,75,43335,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58296,1,2,12,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,58296,8,14)

	-- Glyph of the Pack -- 58297
	AddRecipe(58297,195,43355,1,2,195,205,210,215)
	self:addTradeFlags(RecipeDB,58297,1,2,12,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,58297,8,14)

	-- Glyph of Scare Beast -- 58298
	AddRecipe(58298,75,43356,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58298,1,2,12,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,58298,8,14)

	-- Glyph of Revive Pet -- 58299
	AddRecipe(58299,75,43338,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58299,1,2,12,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,58299,8,14)

	-- Glyph of Possessed Strength -- 58300
	AddRecipe(58300,75,43354,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58300,1,2,12,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,58300,8,14)

	-- Glyph of Mend Pet -- 58301
	AddRecipe(58301,75,43350,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58301,1,2,12,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,58301,8,14)

	-- Glyph of Feign Death -- 58302
	AddRecipe(58302,150,43351,1,2,150,155,160,165)
	self:addTradeFlags(RecipeDB,58302,1,2,12,F_HUNTER,36,41,51)
	self:addTradeAcquire(RecipeDB,58302,8,14)

	-- Glyph of Arcane Intellect -- 58303
	AddRecipe(58303,75,43339,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58303,1,2,12,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,58303,8,14)

	-- Glyph of Fire Ward -- 58305
	AddRecipe(58305,95,43357,1,2,95,105,110,115)
	self:addTradeFlags(RecipeDB,58305,1,2,12,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,58305,8,14)

	-- Glyph of Frost Armor -- 58306
	AddRecipe(58306,75,43359,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58306,1,2,12,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,58306,8,14)

	-- Glyph of Frost Ward -- 58307
	AddRecipe(58307,120,43360,1,2,120,130,135,140)
	self:addTradeFlags(RecipeDB,58307,1,2,12,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,58307,8,14)

	-- Glyph of Slow Fall -- 58308
	AddRecipe(58308,75,43364,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58308,1,2,12,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,58308,8,14)

	-- Glyph of the Penguin -- 58310
	AddRecipe(58310,75,43361,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58310,1,2,12,F_MAGE,36,41,54)
	self:addTradeAcquire(RecipeDB,58310,8,14)

	-- Glyph of Blessing of Kings -- 58311
	AddRecipe(58311,95,43365,1,2,95,105,110,115)
	self:addTradeFlags(RecipeDB,58311,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,58311,8,14)

	-- Glyph of Blessing of Wisdom -- 58312
	AddRecipe(58312,75,43366,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58312,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,58312,8,14)

	-- Glyph of Lay on Hands -- 58313
	AddRecipe(58313,75,43367,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58313,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,58313,8,14)

	-- Glyph of Blessing of Might -- 58314
	AddRecipe(58314,75,43340,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58314,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,58314,8,14)

	-- Glyph of Sense Undead -- 58315
	AddRecipe(58315,95,43368,1,2,95,105,110,115)
	self:addTradeFlags(RecipeDB,58315,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,58315,8,14)

	-- Glyph of the Wise -- 58316
	AddRecipe(58316,150,43369,1,2,150,155,160,165)
	self:addTradeFlags(RecipeDB,58316,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,58316,8,14)

	-- Glyph of Fading -- 58317
	AddRecipe(58317,75,43342,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58317,1,2,12,F_PRIEST,36,41,53,54)
	self:addTradeAcquire(RecipeDB,58317,8,14)

	-- Glyph of Fortitude -- 58318
	AddRecipe(58318,75,43371,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58318,1,2,12,F_PRIEST,36,41,53,54)
	self:addTradeAcquire(RecipeDB,58318,8,14)

	-- Glyph of Levitate -- 58319
	AddRecipe(58319,170,43370,1,2,170,180,185,190)
	self:addTradeFlags(RecipeDB,58319,1,2,12,F_PRIEST,36,41,53,54)
	self:addTradeAcquire(RecipeDB,58319,8,14)

	-- Glyph of Shackle Undead -- 58320
	AddRecipe(58320,95,43373,1,2,95,105,110,115)
	self:addTradeFlags(RecipeDB,58320,1,2,12,F_PRIEST,36,41,53,54)
	self:addTradeAcquire(RecipeDB,58320,8,14)

	-- Glyph of Shadow Protection -- 58321
	AddRecipe(58321,150,43372,1,2,150,155,160,165)
	self:addTradeFlags(RecipeDB,58321,1,2,12,F_PRIEST,36,41,53,54)
	self:addTradeAcquire(RecipeDB,58321,8,14)

	-- Glyph of Shadowfiend -- 58322
	AddRecipe(58322,345,43374,1,2,345,355,360,365)
	self:addTradeFlags(RecipeDB,58322,1,2,12,F_PRIEST,36,41,53,54)
	self:addTradeAcquire(RecipeDB,58322,8,14)

	-- Glyph of Blurred Speed -- 58323
	AddRecipe(58323,75,43379,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58323,1,2,12,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,58323,8,14)

	-- Glyph of Distract -- 58324
	AddRecipe(58324,120,43376,1,2,120,130,135,140)
	self:addTradeFlags(RecipeDB,58324,1,2,12,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,58324,8,14)

	-- Glyph of Pick Lock -- 58325
	AddRecipe(58325,95,43377,1,2,95,105,110,115)
	self:addTradeFlags(RecipeDB,58325,1,2,12,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,58325,8,14)

	-- Glyph of Pick Pocket -- 58326
	AddRecipe(58326,75,43343,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58326,1,2,12,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,58326,8,14)

	-- Glyph of Safe Fall -- 58327
	AddRecipe(58327,195,43378,1,2,195,205,210,215)
	self:addTradeFlags(RecipeDB,58327,1,2,12,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,58327,8,14)

	-- Glyph of Vanish -- 58328
	AddRecipe(58328,120,43380,1,2,120,130,135,140)
	self:addTradeFlags(RecipeDB,58328,1,2,12,F_ROGUE,36,41,51)
	self:addTradeAcquire(RecipeDB,58328,8,14)

	-- Glyph of Astral Recall -- 58329
	AddRecipe(58329,150,43381,1,2,150,155,160,165)
	self:addTradeFlags(RecipeDB,58329,1,2,12,F_SHAMAN,36,41,51,53,54)
	self:addTradeAcquire(RecipeDB,58329,8,14)

	-- Glyph of Renewed Life -- 58330
	AddRecipe(58330,150,43385,1,2,150,155,160,165)
	self:addTradeFlags(RecipeDB,58330,1,2,12,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,58330,8,14)

	-- Glyph of Water Breathing -- 58331
	AddRecipe(58331,120,43344,1,2,120,130,135,140)
	self:addTradeFlags(RecipeDB,58331,1,2,12,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,58331,8,14)

	-- Glyph of Water Shield -- 58332
	AddRecipe(58332,95,43386,1,2,95,105,110,115)
	self:addTradeFlags(RecipeDB,58332,1,2,12,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,58332,8,14)

	-- Glyph of Water Walking -- 58333
	AddRecipe(58333,150,43388,1,2,150,155,160,165)
	self:addTradeFlags(RecipeDB,58333,1,2,12,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,58333,8,14)

	-- Glyph of Unending Breath -- 58336
	AddRecipe(58336,95,43389,1,2,95,105,110,115)
	self:addTradeFlags(RecipeDB,58336,1,2,12,F_WARLOCK,36,41)
	self:addTradeAcquire(RecipeDB,58336,8,14)

	-- Glyph of Drain Soul -- 58337
	AddRecipe(58337,75,43390,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58337,1,2,12,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,58337,8,14)

	-- Glyph of Curse of Exhaustion -- 58338
	AddRecipe(58338,150,43392,1,2,150,155,160,165)
	self:addTradeFlags(RecipeDB,58338,1,2,12,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,58338,8,14)

	-- Glyph of Enslave Demon -- 58339
	AddRecipe(58339,150,43393,1,2,150,155,160,165)
	self:addTradeFlags(RecipeDB,58339,1,2,12,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,58339,8,14)

	-- Glyph of Kilrogg -- 58340
	AddRecipe(58340,120,43391,1,2,120,130,135,140)
	self:addTradeFlags(RecipeDB,58340,1,2,12,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,58340,8,14)

	-- Glyph of Souls -- 58341
	AddRecipe(58341,345,43394,1,2,345,355,360,365)
	self:addTradeFlags(RecipeDB,58341,1,2,12,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,58341,8,14)

	-- Glyph of Battle -- 58342
	AddRecipe(58342,75,43395,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58342,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,58342,8,14)

	-- Glyph of Bloodrage -- 58343
	AddRecipe(58343,75,43396,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58343,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,58343,8,14)

	-- Glyph of Charge -- 58344
	AddRecipe(58344,75,43397,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58344,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,58344,8,14)

	-- Glyph of Mocking Blow -- 58345
	AddRecipe(58345,95,43398,1,2,95,105,110,115)
	self:addTradeFlags(RecipeDB,58345,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,58345,8,14)

	-- Glyph of Thunder Clap -- 58346
	AddRecipe(58346,75,43399,1,2,75,80,85,90)
	self:addTradeFlags(RecipeDB,58346,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,58346,8,14)

	-- Glyph of Enduring Victory -- 58347
	AddRecipe(58347,320,43400,1,2,320,330,335,340)
	self:addTradeFlags(RecipeDB,58347,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,58347,8,14)

	-- Scroll of Agility -- 58472
	AddRecipe(58472,15,3012,1,2,15,35,40,45)
	self:addTradeFlags(RecipeDB,58472,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,58472,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Agility II -- 58473
	AddRecipe(58473,85,1477,1,2,85,85,90,95)
	self:addTradeFlags(RecipeDB,58473,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,58473,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Agility III -- 58476
	AddRecipe(58476,175,4425,1,2,175,180,185,190)
	self:addTradeFlags(RecipeDB,58476,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,58476,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Agility IV -- 58478
	AddRecipe(58478,225,10309,1,2,225,230,235,240)
	self:addTradeFlags(RecipeDB,58478,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,58478,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Agility V -- 58480
	AddRecipe(58480,270,27498,1,2,270,275,280,285)
	self:addTradeFlags(RecipeDB,58480,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,58480,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Agility VI -- 58481
	AddRecipe(58481,310,33457,1,2,310,320,325,330)
	self:addTradeFlags(RecipeDB,58481,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,58481,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Agility VII -- 58482
	AddRecipe(58482,370,43463,1,2,370,375,380,385)
	self:addTradeFlags(RecipeDB,58482,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,58482,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Scroll of Agility VIII -- 58483
	AddRecipe(58483,420,43464,1,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,58483,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,58483,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Scroll of Strength -- 58484
	AddRecipe(58484,15,954,1,2,15,35,40,45)
	self:addTradeFlags(RecipeDB,58484,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,58484,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Strength II -- 58485
	AddRecipe(58485,80,2289,1,2,80,80,85,90)
	self:addTradeFlags(RecipeDB,58485,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,58485,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Strength III -- 58486
	AddRecipe(58486,170,4426,1,2,170,175,180,185)
	self:addTradeFlags(RecipeDB,58486,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,58486,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Strength IV -- 58487
	AddRecipe(58487,220,10310,1,2,220,225,230,235)
	self:addTradeFlags(RecipeDB,58487,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,58487,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Strength V -- 58488
	AddRecipe(58488,265,27503,1,2,265,270,275,280)
	self:addTradeFlags(RecipeDB,58488,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,58488,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Strength VI -- 58489
	AddRecipe(58489,305,33462,1,2,305,315,320,325)
	self:addTradeFlags(RecipeDB,58489,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,58489,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Strength VII -- 58490
	AddRecipe(58490,365,43465,1,2,365,370,375,380)
	self:addTradeFlags(RecipeDB,58490,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,58490,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Scroll of Strength VIII -- 58491
	AddRecipe(58491,415,43466,1,2,415,420,425,430)
	self:addTradeFlags(RecipeDB,58491,1,2,3,36,41,51,52)
	self:addTradeAcquire(RecipeDB,58491,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Mystic Tome -- 58565
	AddRecipe(58565,110,43515,3,2,110,125,137,150)
	self:addTradeFlags(RecipeDB,58565,1,2,3,36,41,66)
	self:addTradeAcquire(RecipeDB,58565,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Dash -- 59315
	AddRecipe(59315,150,43674,1,2,150,155,160,165)
	self:addTradeFlags(RecipeDB,59315,1,2,12,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,59315,8,14)

	-- Glyph of Ghost Wolf -- 59326
	AddRecipe(59326,95,43725,1,2,95,105,110,115)
	self:addTradeFlags(RecipeDB,59326,1,2,12,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,59326,8,14)

	-- Glyph of Rune Tap -- 59338
	AddRecipe(59338,310,43825,1,2,310,315,320,325)
	self:addTradeFlags(RecipeDB,59338,1,2,3,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,59338,1,28702,1,33603,1,26977,1,33615,1,30722,1,26959,1,26995,1,30721,1,26916,1,33679)

	-- Glyph of Blood Strike -- 59339
	AddRecipe(59339,320,43826,1,2,320,325,330,335)
	self:addTradeFlags(RecipeDB,59339,1,2,3,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,59339,1,28702,1,33603,1,26977,1,33615,1,30722,1,26959,1,26995,1,30721,1,26916,1,33679)

	-- Glyph of Death Strike -- 59340
	AddRecipe(59340,340,43827,1,2,340,345,350,355)
	self:addTradeFlags(RecipeDB,59340,1,2,3,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,59340,1,28702,1,33603,1,26977,1,33615,1,30722,1,26959,1,26995,1,30721,1,26916,1,33679)

	-- Certificate of Ownership -- 59387
	AddRecipe(59387,200,43850,1,2,200,205,210,215)
	self:addTradeFlags(RecipeDB,59387,1,2,3,F_HUNTER,36,41)
	self:addTradeAcquire(RecipeDB,59387,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,
	1,30709,1,30706,1,30713,1,30715,1,30716,1,33603,1,33615,1,30710,1,30717,1,30711,1,33679)

	-- Tome of the Dawn -- 59475
	AddRecipe(59475,125,43654,3,2,125,150,162,175)
	self:addTradeFlags(RecipeDB,59475,1,2,3,36,41,66)
	self:addTradeAcquire(RecipeDB,59475,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Book of Survival -- 59478
	AddRecipe(59478,125,43655,3,2,125,150,162,175)
	self:addTradeFlags(RecipeDB,59478,1,2,3,36,41,66)
	self:addTradeAcquire(RecipeDB,59478,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Strange Tarot -- 59480
	AddRecipe(59480,125,nil,1,2,125,150,162,175)
	self:addTradeFlags(RecipeDB,59480,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,59480,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Tome of Kings -- 59484
	AddRecipe(59484,175,43656,3,2,175,200,205,210)
	self:addTradeFlags(RecipeDB,59484,1,2,3,36,41,66)
	self:addTradeAcquire(RecipeDB,59484,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Royal Guide of Escape Routes -- 59486
	AddRecipe(59486,175,43657,3,2,175,200,205,210)
	self:addTradeFlags(RecipeDB,59486,1,2,3,36,41,66)
	self:addTradeAcquire(RecipeDB,59486,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Arcane Tarot -- 59487
	AddRecipe(59487,175,nil,1,2,175,200,205,210)
	self:addTradeFlags(RecipeDB,59487,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,59487,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Weapon Vellum II -- 59488
	AddRecipe(59488,235,39350,1,2,235,250,255,260)
	self:addTradeFlags(RecipeDB,59488,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,59488,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Fire Eater's Guide -- 59489
	AddRecipe(59489,225,43660,3,2,225,240,245,250)
	self:addTradeFlags(RecipeDB,59489,1,2,3,36,41,66)
	self:addTradeAcquire(RecipeDB,59489,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Book of Stars -- 59490
	AddRecipe(59490,225,43661,3,2,225,240,245,250)
	self:addTradeFlags(RecipeDB,59490,1,2,3,36,41,66)
	self:addTradeAcquire(RecipeDB,59490,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Shadowy Tarot -- 59491
	AddRecipe(59491,225,nil,1,2,225,240,245,250)
	self:addTradeFlags(RecipeDB,59491,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,59491,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Stormbound Tome -- 59493
	AddRecipe(59493,275,43663,3,2,275,290,295,300)
	self:addTradeFlags(RecipeDB,59493,1,2,3,36,41,53,54,66)
	self:addTradeAcquire(RecipeDB,59493,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Manual of Clouds -- 59494
	AddRecipe(59494,275,43664,3,2,275,290,295,300)
	self:addTradeFlags(RecipeDB,59494,1,2,3,36,41,53,54,66)
	self:addTradeAcquire(RecipeDB,59494,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Hellfire Tome -- 59495
	AddRecipe(59495,325,43666,3,2,325,340,345,350)
	self:addTradeFlags(RecipeDB,59495,1,2,3,36,41,53,54,66)
	self:addTradeAcquire(RecipeDB,59495,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Book of Clever Tricks -- 59496
	AddRecipe(59496,325,43667,3,2,325,340,345,350)
	self:addTradeFlags(RecipeDB,59496,1,2,3,36,41,66)
	self:addTradeAcquire(RecipeDB,59496,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603,1,33615,1,30722,1,30721,1,33679)

	-- Iron-bound Tome -- 59497
	AddRecipe(59497,400,38322,4,2,400,425,437,450)
	self:addTradeFlags(RecipeDB,59497,1,2,3,36,41,53,54,66)
	self:addTradeAcquire(RecipeDB,59497,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Faces of Doom -- 59498
	AddRecipe(59498,400,44210,4,2,400,425,437,450)
	self:addTradeFlags(RecipeDB,59498,1,2,3,36,41,53,54,66)
	self:addTradeAcquire(RecipeDB,59498,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Armor Vellum II -- 59499
	AddRecipe(59499,200,37602,1,2,200,210,215,220)
	self:addTradeFlags(RecipeDB,59499,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,59499,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Armor Vellum III -- 59500
	AddRecipe(59500,350,43145,1,2,350,355,370,385)
	self:addTradeFlags(RecipeDB,59500,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,59500,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Weapon Vellum III -- 59501
	AddRecipe(59501,400,43146,1,2,400,405,410,415)
	self:addTradeFlags(RecipeDB,59501,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,59501,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Darkmoon Card -- 59502
	AddRecipe(59502,275,nil,1,2,275,290,295,300)
	self:addTradeFlags(RecipeDB,59502,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,59502,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Greater Darkmoon Card -- 59503
	AddRecipe(59503,325,nil,1,2,325,340,345,350)
	self:addTradeFlags(RecipeDB,59503,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,59503,1,26916,1,26959,1,26977,1,26995,1,28702,1,30721,1,30722,1,33615,1,33603,1,33679)

	-- Darkmoon Card of the North -- 59504
	AddRecipe(59504,400,nil,1,2,400,425,450,475)
	self:addTradeFlags(RecipeDB,59504,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,59504,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Glyph of Seal of Blood -- 59559
	AddRecipe(59559,385,43867,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,59559,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,59559,8,15)

	-- Glyph of Seal of Righteousness -- 59560
	AddRecipe(59560,385,43868,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,59560,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,59560,8,15)

	-- Glyph of Seal of Vengeance -- 59561
	AddRecipe(59561,385,43869,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,59561,1,2,12,F_PALADIN,36,41,51)
	self:addTradeAcquire(RecipeDB,59561,8,15)

	-- Scroll of Recall II -- 60336
	AddRecipe(60336,200,44314,1,2,200,215,220,225)
	self:addTradeFlags(RecipeDB,60336,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,60336,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Scroll of Recall III -- 60337
	AddRecipe(60337,350,44315,1,2,350,350,350,355)
	self:addTradeFlags(RecipeDB,60337,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,60337,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Master's Inscription of the Axe -- 61117
	AddRecipe(61117,400,nil,1,2,400,400,400,405)
	self:addTradeFlags(RecipeDB,61117,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,61117,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Master's Inscription of the Crag -- 61118
	AddRecipe(61118,400,nil,1,2,400,400,400,405)
	self:addTradeFlags(RecipeDB,61118,1,2,3,36,41,53,54)
	self:addTradeAcquire(RecipeDB,61118,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Master's Inscription of the Pinnacle -- 61119
	AddRecipe(61119,400,nil,1,2,400,400,400,405)
	self:addTradeFlags(RecipeDB,61119,1,2,3,36,41,52)
	self:addTradeAcquire(RecipeDB,61119,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Master's Inscription of the Storm -- 61120
	AddRecipe(61120,400,nil,1,2,400,400,400,405)
	self:addTradeFlags(RecipeDB,61120,1,2,3,36,41,53,54)
	self:addTradeAcquire(RecipeDB,61120,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Northrend Inscription Research -- 61177
	AddRecipe(61177,385,nil,1,2,385,425,437,450)
	self:addTradeFlags(RecipeDB,61177,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,61177,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603,1,33679)

	-- Minor Inscription Research -- 61288
	AddRecipe(61288,75,nil,1,2,75,125,137,150)
	self:addTradeFlags(RecipeDB,61288,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,61288,1,26916,1,26959,1,26977,1,26995,1,28702,1,30706,
	1,30709,1,30710,1,30711,1,30713,1,30715,1,30716,1,30717,1,30721,1,30722,1,33603,1,33615,1,33679)

	-- Glyph of Frostfire -- 61677
	AddRecipe(61677,385,44684,1,2,385,390,397,405)
	self:addTradeFlags(RecipeDB,61677,1,2,12,F_MAGE,36,41)
	self:addTradeAcquire(RecipeDB,61677,8,15)

	-- Glyph of Blast Wave -- 56990
	AddRecipe(56990,310,44920,1,2,310,355,360,365)
	self:addTradeFlags(RecipeDB,56990,1,2,12,F_MAGE,36,41)
	self:addTradeAcquire(RecipeDB,56990,8,14)

	-- Glyph of Arcane Blast -- 56991
	AddRecipe(56991,315,44955,1,2,310,320,325,330)
	self:addTradeFlags(RecipeDB,56991,1,2,3,F_MAGE,36,41)
	self:addTradeAcquire(RecipeDB,56991,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603,1,33615,1,30722,1,30721,1,33679)

	-- Glyph of Typhoon -- 56965
	AddRecipe(56965,310,44955,1,2)
	self:addTradeFlags(RecipeDB,56965,1,2,12,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,56965,8,14)

	-- Glyph of Focus -- 62162
	AddRecipe(62162,375,44928,1,2,375,380,385,390)
	self:addTradeFlags(RecipeDB,62162,1,2,3,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,62162,1,26916,1,26959,1,26977,1,26995,1,28702,1,33603)

	-- Glyph of Thunderstorm -- 57253
	AddRecipe(57253,355,44923,1,2,355,355,360,365)
	self:addTradeFlags(RecipeDB,57253,1,2,12,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,57253,8,14)

	-- Rituals of the New Moon -- 64051
	AddRecipe(64051,350,46108,2,2,350,375,387,400)
	self:addTradeFlags(RecipeDB,64051,1,2,11,36,41,54,66)
	self:addTradeAcquire(RecipeDB,64051,3,26679,3,26708,3,27546,3,27676)

	-- Glyph of Dancing Rune Weapon -- 64297
	AddRecipe(64297,425,45799,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64297,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,64297,8,40)

	-- Glyph of Dark Death -- 64266
	AddRecipe(64266,275,45804,1,2,275,280,287,295)
	self:addTradeFlags(RecipeDB,64266,1,2,3,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,64266,1,30709,1,30706,1,28702,1,30713,1,30715,1,30716,
	1,33603,1,26977,1,33615,1,30710,1,30722,1,30717,1,26959,1,26995,1,30721,1,26916,1,30711,1,33679)

	-- Glyph of Disease -- 64267
	AddRecipe(64267,280,45805,1,2,280,285,290,295)
	self:addTradeFlags(RecipeDB,64267,1,2,3,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,64267,1,30709,1,30706,1,28702,1,30713,1,30715,1,30716,
	1,33603,1,26977,1,33615,1,30710,1,30722,1,30717,1,26959,1,26995,1,30721,1,26916,1,30711,1,33679)

	-- Glyph of Howling Blast -- 64300
	AddRecipe(64300,425,45806,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64300,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,64300,8,40)

	-- Glyph of Hungering Cold -- 64298
	AddRecipe(64298,425,45800,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64298,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,64298,8,40)
	
	-- Glyph of Unholy Blight -- 64299
	AddRecipe(64299,425,45803,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64299,1,2,12,F_DK,36,41)
	self:addTradeAcquire(RecipeDB,64299,8,40)

	--Glyph of Arcane Barrage -- 64276
	AddRecipe(64276,425,45738,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64276,1,2,12,F_MAGE,36,41)
	self:addTradeAcquire(RecipeDB,64276,8,40)

	--Glyph of Barkskin  -- 64256
	AddRecipe(64256,425,45623,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64256,1,2,12,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,64256,8,40)

	--Glyph of Beacon of Light -- 64277
	AddRecipe(64277,425,45741,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64277,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,64277,8,40)

	--Glyph of Berserk  -- 64268
	AddRecipe(64268,425,45601,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64268,1,2,12,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,64268,8,40)

	--Glyph of Bladestorm  -- 64295
	AddRecipe(64295,425,45790,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64295,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,64295,8,40)

	--Glyph of Chaos Bolt  -- 64294
	AddRecipe(64294,425,45781,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64294,1,2,12,F_WARLOCK,36,41)
	self:addTradeAcquire(RecipeDB,64294,8,40)

	--Glyph of Chimera Shot -- 64271
	AddRecipe(64271,425,45625,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64271,1,2,12,F_HUNTER,36,41)
	self:addTradeAcquire(RecipeDB,64271,8,40)

	--Glyph of Cloak of Shadows -- 64303
	AddRecipe(64303,425,45769,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64303,1,2,12,F_ROGUE,36,41)
	self:addTradeAcquire(RecipeDB,64303,8,40)

	--Glyph of Deep Freeze  - 64274
	AddRecipe(64274,425,45736,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64274,1,2,12,F_MAGE,36,41)
	self:addTradeAcquire(RecipeDB,64274,8,40)

	--Glyph of Demonic Circle  -- 64317
	AddRecipe(64317,425,45782,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64317,1,2,12,F_WARLOCK,36,41)
	self:addTradeAcquire(RecipeDB,64317,8,40)
	
	--Glyph of Dispersion  -- 64280
	AddRecipe(64280,425,45753,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64280,1,2,12,F_PRIEST,36,41)
	self:addTradeAcquire(RecipeDB,64280,8,40)

	--Glyph of Divine Plea -- 64305
	AddRecipe(64305,425,45745,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64305,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,64305,8,40)

	--Glyph of Divine Storm  -- 64279
	AddRecipe(64279,425,45743,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64279,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,64279,8,40)

	--Glyph of Earth Shield -- 64261
	AddRecipe(64261,250,45775,1,2,250,255,262,270)
	self:addTradeFlags(RecipeDB,64261,1,2,3,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,64261,1,30709,1,30706,1,28702,1,30713,1,30715,
	1,30716,1,33603,1,26977,1,33615,1,30710,1,30722,1,30717,1,26959,1,26995,1,30721,1,26916,1,30711,1,33679)

	--Glyph of Enraged Regeneration  -- 64312
	AddRecipe(64312,425,45794,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64312,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,64312,8,40)

	--Glyph of Explosive Shot  -- 64273
	AddRecipe(64273,425,45731,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64273,1,2,12,F_HUNTER,36,41)
	self:addTradeAcquire(RecipeDB,64273,8,40)

	--Glyph of Explosive Trap -- 64253
	AddRecipe(64253,425,45733,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64253,1,2,12,F_HUNTER,36,41)
	self:addTradeAcquire(RecipeDB,64253,8,40)

	--Glyph of Fan of Knives -- 64315
	AddRecipe(64315,425,45766,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64315,1,2,12,F_ROGUE,36,41)
	self:addTradeAcquire(RecipeDB,64315,8,40)

	--Glyph of Feral Spirit  -- 64288
	AddRecipe(64288,425,45771,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64288,1,2,12,F_SHAMAN,36,41,53,54)
	self:addTradeAcquire(RecipeDB,64288,8,40)

	--Glyph of Guardian Spirit  -- 64281
	AddRecipe(64281,425,45755,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64281,1,2,12,F_PRIEST,36,41,53,54)
	self:addTradeAcquire(RecipeDB,64281,8,40)

	--Glyph of Hammer of the Righteous  -- 64278
	AddRecipe(64278,425,45742,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64278,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,64278,8,40)

	--Glyph of Haunt  -- 64291
	AddRecipe(64291,425,45779,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64291,1,2,12,F_WARLOCK,36,41)
	self:addTradeAcquire(RecipeDB,64291,8,40)

	--Glyph of Hex -- 64316
	AddRecipe(64316,425,45777,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64316,1,2,12,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,64316,8,40)

	--Glyph of Holy Shock  -- 64254
	AddRecipe(64254,425,45746,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64254,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,64254,8,40)

	--Glyph of Hunger for Blood  -- 64284
	AddRecipe(64284,425,45761,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64284,1,2,12,F_ROGUE,36,41)
	self:addTradeAcquire(RecipeDB,64284,8,40)

	--Glyph of Hymn of Hope -- 64283
	AddRecipe(64283,425,45758,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64283,1,2,12,F_PRIEST,36,41)
	self:addTradeAcquire(RecipeDB,64283,8,40)

	--Glyph of Ice Barrier -- 64257
	AddRecipe(64257,425,45740,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64257,1,2,12,F_MAGE,36,41)
	self:addTradeAcquire(RecipeDB,64257,8,40)

	--Glyph of Kill Shot -- 64304
	AddRecipe(64304,425,45732,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64304,1,2,12,F_HUNTER,36,41)
	self:addTradeAcquire(RecipeDB,64304,8,40)

	--Glyph of Killing Spree -- 64285
	AddRecipe(64285,425,45762,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64285,1,2,12,F_ROGUE,36,41)
	self:addTradeAcquire(RecipeDB,64285,8,40)

	--Glyph of Life Tap -- 64248
	AddRecipe(64248,425,45785,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64248,1,2,12,F_WARLOCK,36,41,54)
	self:addTradeAcquire(RecipeDB,64248,8,40)
	
	--Glyph of Living Bomb -- 64275
	AddRecipe(64275,425,45737,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64275,1,2,12,F_MAGE,36,41)
	self:addTradeAcquire(RecipeDB,64275,8,40)

	--Glyph of Metamorphosis  -- 64318
	AddRecipe(64318,425,45780,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64318,1,2,12,F_WARLOCK,36,41)
	self:addTradeAcquire(RecipeDB,64318,8,40)

	--Glyph of Mind Sear -- 64309
	AddRecipe(64309,425,45757,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64309,1,2,12,F_PRIEST,36,41)
	self:addTradeAcquire(RecipeDB,64309,8,40)

	--Glyph of Mirror Image -- 64314
	AddRecipe(64314,425,45739,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64314,1,2,12,F_MAGE,36,41)
	self:addTradeAcquire(RecipeDB,64314,8,40)

	--Glyph of Monsoon -- 64258
	AddRecipe(64258,250,45622,1,2,250,255,262,270)
	self:addTradeFlags(RecipeDB,64258,1,2,3,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,64258,1,30709,1,30706,1,28702,1,30713,1,30715,1,30716,
	1,33603,1,26977,1,33615,1,30710,1,30722,1,30717,1,26959,1,26995,1,30721,1,26916,1,30711,1,33679)

	--Glyph of Mutilate -- 64260
	AddRecipe(64260,255,45768,1,2,255,255,262,270)
	self:addTradeFlags(RecipeDB,64260,1,2,3,F_ROGUE,36,41)
	self:addTradeAcquire(RecipeDB,64260,1,30709,1,30706,1,28702,1,30713,1,30715,1,30716,
	1,33603,1,26977,1,33615,1,30710,1,30722,1,30717,1,26959,1,26995,1,30721,1,26916,1,30711,1,33679)

	--Glyph of Nourish -- 64313
	AddRecipe(64313,425,45603,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64313,1,2,12,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,64313,8,40)

	--Glyph of Pain Suppression -- 64259
	AddRecipe(64259,255,45760,1,2,255,255,262,270)
	self:addTradeFlags(RecipeDB,64259,1,2,3,F_PRIEST,36,41)
	self:addTradeAcquire(RecipeDB,64259,1,30709,1,30706,1,28702,1,30713,1,30715,1,30716,
	1,33603,1,26977,1,33615,1,30710,1,30722,1,30717,1,26959,1,30721,1,26916,1,30711,1,33679)

	--Glyph of Penance -- 64282
	AddRecipe(64282,425,45756,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64282,1,2,12,F_PRIEST,36,41)
	self:addTradeAcquire(RecipeDB,64282,8,40)

	--Glyph of Raptor Strike -- 64246
	AddRecipe(64246,425,45735,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64246,1,2,12,F_HUNTER,36,41)
	self:addTradeAcquire(RecipeDB,64246,8,40)

	--Glyph of Riptide -- 64289
	AddRecipe(64289,425,45772,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64289,1,2,12,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,64289,8,40)

	--Glyph of Salvation -- 64251
	AddRecipe(64251,425,45747,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64251,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,64251,8,40)

	--Glyph of Savage Roar -- 64307
	AddRecipe(64307,425,45604,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64307,1,2,12,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,64307,8,40)

	--Glyph of Scatter Shot -- 64249
	AddRecipe(64249,425,45734,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64249,1,2,12,F_HUNTER,36,41)
	self:addTradeAcquire(RecipeDB,64249,8,40)

	--Glyph of Shadow Dance -- 64286
	AddRecipe(64286,425,45764,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64286,1,2,12,F_ROGUE,36,41)
	self:addTradeAcquire(RecipeDB,64286,8,40)

	--Glyph of Shadowflame -- 64311
	AddRecipe(64311,425,45783,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64311,1,2,12,F_WARLOCK,36,41)
	self:addTradeAcquire(RecipeDB,64311,8,40)

	--Glyph of Shield of Righteousness -- 64308
	AddRecipe(64308,425,45744,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64308,1,2,12,F_PALADIN,36,41)
	self:addTradeAcquire(RecipeDB,64308,8,40)

	--Glyph of Shield Wall -- 64252
	AddRecipe(64252,425,45797,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64252,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,64252,8,40)

	--Glyph of Shockwave -- 64296
	AddRecipe(64296,425,45792,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64296,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,64296,8,40)

	--Glyph of Soul Link -- 64250
	AddRecipe(64250,425,45789,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64250,1,2,12,F_WARLOCK,36,41)
	self:addTradeAcquire(RecipeDB,64250,8,40)

	--Glyph of Spell Reflection -- 64302
	AddRecipe(64302,425,45795,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64302,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,64302,8,40)

	--Glyph of Stoneclaw Totem -- 64247
	AddRecipe(64247,425,45778,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64247,1,2,12,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,64247,8,40)

	--Glyph of Survival Instincts  -- 65245
	AddRecipe(65245,425,46372,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,65245,1,2,12,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,65245,8,40)

	--Glyph of Thunder -- 64287
	AddRecipe(64287,425,45770,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64287,1,2,12,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,64287,8,40)

	--Glyph of Totem of Wrath -- 64262
	AddRecipe(64262,255,45776,1,2,255,255,262,270)
	self:addTradeFlags(RecipeDB,64262,1,2,3,F_SHAMAN,36,41)
	self:addTradeAcquire(RecipeDB,64262,1,30709,1,30706,1,28702,1,30713,1,30715,1,30716,
	1,33603,1,26977,1,33615,1,30710,1,30722,1,30717,1,26959,1,26995,1,30721,1,26916,1,30711,1,33679)

	--Glyph of Tricks of the Trade -- 64310
	AddRecipe(64310,425,45767,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64310,1,2,12,F_ROGUE,36,41)
	self:addTradeAcquire(RecipeDB,64310,8,40)

	--Glyph of Vigilance -- 64255
	AddRecipe(64255,425,45793,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64255,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,64255,8,40)

	--Glyph of Wild Growth -- 64270
	AddRecipe(64270,425,45602,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,64270,1,2,12,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,64270,8,40)

	--Twilight Tome -- 64053
	AddRecipe(64053,350,45849,1,2,350,375,387,400)
	self:addTradeFlags(RecipeDB,64053,1,2,3,36,41,53,54,66)
	self:addTradeAcquire(RecipeDB,64053,1,33603,1,28702,1,26977,1,26959,1,26995,1,26916)
	
	--Glyph of Claw -- 67600
	AddRecipe(67600,100,48720,1,2,100,105,110,115)
	self:addTradeFlags(RecipeDB,67600,1,2,3,F_DRUID,36,41)
	self:addTradeAcquire(RecipeDB,67600,1,33603,1,33679,1,28702,1,30722,1,30710,1,26959)
	
	--Glyph of Command -- 68166
	AddRecipe(68166,355,49084,1,2,355,355,360,365)
	self:addTradeFlags(RecipeDB,68166,1,2,12,F_WARRIOR,36,41)
	self:addTradeAcquire(RecipeDB,68166,8,14)

	-- Runescroll of Fortitude -- 69385
	AddRecipe(69385,440,49632,1,2,440,440,442,460)
	self:addTradeFlags(RecipeDB,69385,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,69385,1,28702,1,26977,1,33603,1,26959,1,26916,1,26995)

	-- Glyph of Quick Decay - 71102
	AddRecipe(71102, 375, 50077, R_COMMON, GAME_WOTLK, 375, 380, 382, 385)
	self:addTradeFlags(RecipeDB, 71102, F_ALLIANCE, F_HORDE, F_VENDOR, F_IBOE, F_RBOE, F_WARLOCK)
	self:addTradeAcquire(RecipeDB, 71102, A_VENDOR, 28723)

	-- Glyph of Rapid Rejuvination - 71015
	AddRecipe(71015, 375, 50125, R_COMMON, GAME_WOTLK, 375, 380, 382, 385)
	self:addTradeFlags(RecipeDB, 71015, F_ALLIANCE, F_HORDE, F_VENDOR, F_IBOE, F_RBOE, F_DRUID)
	self:addTradeAcquire(RecipeDB, 71015, A_VENDOR, 28723)

	-- Glyph of Eternal Water - 71101
	AddRecipe(71101, 375, 50045, R_COMMON, GAME_WOTLK, 375, 380, 382, 385)
	self:addTradeFlags(RecipeDB, 71101, F_ALLIANCE, F_HORDE, F_VENDOR, F_IBOE, F_RBOE, F_MAGE)
	self:addTradeAcquire(RecipeDB, 71101, A_VENDOR, 28723)

	return num_recipes

end
