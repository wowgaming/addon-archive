--[[
************************************************************************
Leatherworking.lua
Leatherworking data for all of Ackis Recipe List
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
local F_DRUID, F_HUNTER, F_MAGE, F_PALADIN, F_PRIEST, F_SHAMAN, F_ROGUE, F_WARLOCK, F_WARRIOR = 22, 23, 24, 25, 26, 27, 28, 29, 30
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

-------------------------------------------------------------------------------
-- Reputation Levels
-------------------------------------------------------------------------------
local FRIENDLY = 1
local HONORED = 2
local REVERED = 3
local EXALTED = 4

local initialized = false
local num_recipes = 0

function addon:InitLeatherworking(RecipeDB)

	if initialized then
		return num_recipes
	end

	initialized = true

	--------------------------------------------------------------------------------------------------------------------
	-- Counter and wrapper function
	--------------------------------------------------------------------------------------------------------------------
	local function AddRecipe(SpellID, Skill, ItemID, Rarity, Game, Orange, Yellow, Green, Gray, Speciality)
		num_recipes = num_recipes + 1
		self:addTradeSkill(RecipeDB, SpellID, Skill, ItemID, Rarity, 2108, Speciality, Game, Orange, Yellow, Green, Gray)
	end

	-- Handstitched Leather Boots -- 2149
	AddRecipe(2149,10,2302,1,GAME_ORIG,1,40,55,70)
	self:addTradeFlags(RecipeDB,2149,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,2149,8,8)

	-- Light Armor Kit -- 2152
	AddRecipe(2152,1,2304,1,GAME_ORIG,1,30,45,60)
	self:addTradeFlags(RecipeDB,2152,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,2152,8,8)

	-- Handstitched Leather Pants -- 2153
	AddRecipe(2153,15,2303,1,GAME_ORIG,15,45,60,75)
	self:addTradeFlags(RecipeDB,2153,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,2153,1,1632,1,3007,1,3069,1,3365,1,3549,
	1,3605,1,3703,1,4212,1,4588,1,5127,1,5564,1,5784,1,
	11097,1,11098,1,16278,1,16688,1,16728,1,17442,1,18754,1,18771,1,19187,1,21087,
	1,1385,1,3967,1,33612,1,33635,1,33681,1,8153)

	-- Fine Leather Boots -- 2158
	AddRecipe(2158,90,2307,2,GAME_ORIG,90,120,135,150)
	self:addTradeFlags(RecipeDB,2158,1,2,10,36,40,51,57)
	self:addTradeAcquire(RecipeDB,2158,7,2)

	-- Fine Leather Cloak -- 2159
	AddRecipe(2159,85,2308,1,GAME_ORIG,85,105,120,135)
	self:addTradeFlags(RecipeDB,2159,1,2,3,36,41,60)
	self:addTradeAcquire(RecipeDB,2159,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087,1
	,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,8153,1,17442,1,16278,1,3605)

	-- Embossed Leather Vest -- 2160
	AddRecipe(2160,40,2300,1,GAME_ORIG,40,70,85,100)
	self:addTradeFlags(RecipeDB,2160,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,2160,1,1632,1,3007,1,3069,1,3365,1,3549
	,1,3605,1,3703,1,4212,1,4588,1,5127,1,5564,1,5784,1,
	11097,1,11098,1,16278,1,16688,1,16728,1,17442,1,18754,1,18771,1,19187,1,21087
	,1,1385,1,3967,1,33612,1,33635,1,33681,1,8153)

	-- Embossed Leather Boots -- 2161
	AddRecipe(2161,55,2309,1,GAME_ORIG,55,85,100,115)
	self:addTradeFlags(RecipeDB,2161,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,2161,1,1632,1,3007,1,3069,1,3365,1,3549
	,1,3605,1,3703,1,3967,1,4212,1,4588,1,5127,1,5564,1,5784,1,
	11097,1,11098,1,16278,1,16688,1,16728,1,17442,1,18754,1,18771,1,19187
	,1,21087,1,1385,1,33612,1,33635,1,33681,1,8153)

	-- Embossed Leather Cloak -- 2162
	AddRecipe(2162,60,2310,1,GAME_ORIG,60,90,105,120)
	self:addTradeFlags(RecipeDB,2162,1,2,3,36,41,51,60)
	self:addTradeAcquire(RecipeDB,2162,1,1632,1,3007,1,3069,1,3365,1,3549
	,1,3605,1,3703,1,3967,1,4212,1,4588,1,5127,1,5564,1,5784,1,
	11097,1,11098,1,16278,1,16688,1,16728,1,17442,1,18754,1,18771,1,19187
	,1,21087,1,1385,1,33612,1,33635,1,33681,1,8153)

	-- White Leather Jerkin -- 2163
	AddRecipe(2163,60,2311,2,GAME_ORIG,60,90,105,120)
	self:addTradeFlags(RecipeDB,2163,1,2,10,36,40,51,57)
	self:addTradeAcquire(RecipeDB,2163,7,2)

	-- Fine Leather Gloves -- 2164
	AddRecipe(2164,75,2312,2,GAME_ORIG,75,105,120,135)
	self:addTradeFlags(RecipeDB,2164,1,2,10,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,2164,7,2)

	-- Medium Armor Kit -- 2165
	AddRecipe(2165,100,2313,1,GAME_ORIG,100,115,122,130)
	self:addTradeFlags(RecipeDB,2165,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,2165,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,5127,1,
	5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087,1,1632,1
	,5784,1,1385,1,3549,1,33612,1,33635,1,33681,1,8153,1,17442,1,16278,1,3605)

	-- Toughened Leather Armor -- 2166
	AddRecipe(2166,120,2314,1,GAME_ORIG,120,145,157,170)
	self:addTradeFlags(RecipeDB,2166,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,2166,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,8153,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,
	21087,1,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,17442,1,16278,1,3605)

	-- Dark Leather Boots -- 2167
	AddRecipe(2167,100,2315,1,GAME_ORIG,100,125,137,150)
	self:addTradeFlags(RecipeDB,2167,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,2167,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087,1
	,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,8153,1,17442,1,16278,1,3605)

	-- Dark Leather Cloak -- 2168
	AddRecipe(2168,110,2316,1,GAME_ORIG,110,135,147,160)
	self:addTradeFlags(RecipeDB,2168,1,2,3,36,41,51,60)
	self:addTradeAcquire(RecipeDB,2168,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087,1
	,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,8153,1,17442,1,16278,1,3605)

	-- Dark Leather Tunic -- 2169
	AddRecipe(2169,100,2317,2,GAME_ORIG,100,125,137,150)
	self:addTradeFlags(RecipeDB,2169,1,2,10,36,40,51,57)
	self:addTradeAcquire(RecipeDB,2169,7,2)

	-- Light Leather -- 2881
	AddRecipe(2881,1,2318,1,GAME_ORIG,1,20,30,40)
	self:addTradeFlags(RecipeDB,2881,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,2881,8,8)

	-- Handstitched Leather Belt -- 3753
	AddRecipe(3753,25,4237,1,GAME_ORIG,25,55,70,85)
	self:addTradeFlags(RecipeDB,3753,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,3753,1,1385,1,1632,1,3007,1,3069,1,3365
	,1,3549,1,3605,1,3703,1,4212,1,4588,1,5127,1,5564,1,5784,1,
	11097,1,11098,1,16278,1,16688,1,16728,1,17442,1,18754,1,18771,1,19187
	,1,21087,1,3967,1,33612,1,33635,1,33681,1,8153)

	-- Embossed Leather Gloves -- 3756
	AddRecipe(3756,55,4239,1,GAME_ORIG,55,85,100,115)
	self:addTradeFlags(RecipeDB,3756,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,3756,1,1632,1,3007,1,3069,1,3365,1,3549
	,1,3605,1,3703,1,3967,1,4212,1,4588,1,5127,1,5564,1,5784,1,
	11097,1,11098,1,16278,1,16688,1,16728,1,17442,1,18754,1,18771,1,19187
	,1,21087,1,1385,1,33635,1,33612,1,33681,1,8153)

	-- Embossed Leather Pants -- 3759
	AddRecipe(3759,75,4242,1,GAME_ORIG,75,105,120,135)
	self:addTradeFlags(RecipeDB,3759,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,3759,1,1385,1,1632,1,3007,1,3069,1,3365
	,1,3549,1,3605,1,3703,1,3967,1,4212,1,4588,1,5127,1,5564,1,5784,1,
	11097,1,11098,1,16278,1,16688,1,16728,1,17442,1,18754,1,18771
	,1,19187,1,21087,1,33635,1,33612,1,33681,1,8153)

	-- Hillman's Cloak -- 3760
	AddRecipe(3760,150,3719,1,GAME_ORIG,150,170,180,190)
	self:addTradeFlags(RecipeDB,3760,1,2,3,36,41,53,54,60)
	self:addTradeAcquire(RecipeDB,3760,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,8153,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,
	21087,1,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,17442,1,16278,1,3605)

	-- Fine Leather Tunic -- 3761
	AddRecipe(3761,85,4243,1,GAME_ORIG,85,115,130,145)
	self:addTradeFlags(RecipeDB,3761,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,3761,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,5127,1,
	5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087,1,1632,1
	,5784,1,1385,1,3549,1,33635,1,33612,1,33681,1,8153,1,17442,1,16278,1,3605)

	-- Hillman's Leather Vest -- 3762
	AddRecipe(3762,100,4244,2,GAME_ORIG,100,125,137,150)
	self:addTradeFlags(RecipeDB,3762,1,2,10,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,3762,7,2)

	-- Fine Leather Belt -- 3763
	AddRecipe(3763,80,4246,1,GAME_ORIG,80,110,125,140)
	self:addTradeFlags(RecipeDB,3763,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,3763,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,5127,1,
	5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087,1,1632,1
	,5784,1,1385,1,3549,1,33635,1,33612,1,33681,1,8153,1,17442,1,16278,1,3605)

	-- Hillman's Leather Gloves -- 3764
	AddRecipe(3764,145,4247,1,GAME_ORIG,145,170,182,195)
	self:addTradeFlags(RecipeDB,3764,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,3764,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,8153,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,
	21087,1,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,17442,1,16278,1,3605)

	-- Dark Leather Gloves -- 3765
	AddRecipe(3765,120,4248,2,GAME_ORIG,120,155,167,180)
	self:addTradeFlags(RecipeDB,3765,1,2,10,36,40,57)
	self:addTradeAcquire(RecipeDB,3765,7,2)

	-- Dark Leather Belt -- 3766
	AddRecipe(3766,125,4249,1,GAME_ORIG,125,150,162,175)
	self:addTradeFlags(RecipeDB,3766,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,3766,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,8153,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,
	21087,1,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,16278,1,3605)

	-- Hillman's Belt -- 3767
	AddRecipe(3767,120,4250,2,GAME_ORIG,120,145,157,170)
	self:addTradeFlags(RecipeDB,3767,1,2,10,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,3767,7,2)

	-- Hillman's Shoulders -- 3768
	AddRecipe(3768,130,4251,1,GAME_ORIG,130,155,167,180)
	self:addTradeFlags(RecipeDB,3768,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,3768,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,8153,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,
	21087,1,1632,1,5784,1,3549,1,33612,1,33635,1,17442,1,16278,1,3605)

	-- Dark Leather Shoulders -- 3769
	AddRecipe(3769,140,4252,2,GAME_ORIG,140,165,177,190)
	self:addTradeFlags(RecipeDB,3769,1,2,10,36,40,51,57)
	self:addTradeAcquire(RecipeDB,3769,7,2)

	-- Toughened Leather Gloves -- 3770
	AddRecipe(3770,135,4253,1,GAME_ORIG,135,160,172,185)
	self:addTradeFlags(RecipeDB,3770,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,3770,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,8153,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,
	21087,1,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,17442,1,16278,1,3605)

	-- Barbaric Gloves -- 3771
	AddRecipe(3771,150,4254,2,GAME_ORIG,150,170,180,190)
	self:addTradeFlags(RecipeDB,3771,1,2,10,36,40,51,57)
	self:addTradeAcquire(RecipeDB,3771,7,2)

	-- Green Leather Armor -- 3772
	AddRecipe(3772,155,4255,1,GAME_ORIG,155,175,185,195)
	self:addTradeFlags(RecipeDB,3772,1,2,4,36,40,52,57)
	self:addTradeAcquire(RecipeDB,3772,2,2679,2,2698)

	-- Guardian Armor -- 3773
	AddRecipe(3773,175,4256,2,GAME_ORIG,175,195,205,215)
	self:addTradeFlags(RecipeDB,3773,1,2,10,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,3773,7,2)

	-- Green Leather Belt -- 3774
	AddRecipe(3774,160,4257,1,GAME_ORIG,160,180,190,200)
	self:addTradeFlags(RecipeDB,3774,1,2,3,36,41,52,57)
	self:addTradeAcquire(RecipeDB,3774,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187,
	1,21087,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688,1,
	33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Guardian Belt -- 3775
	AddRecipe(3775,170,4258,3,GAME_ORIG,170,190,200,210)
	self:addTradeFlags(RecipeDB,3775,1,2,5,11,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,3775,7,3)

	-- Green Leather Bracers -- 3776
	AddRecipe(3776,180,4259,1,GAME_ORIG,180,200,210,220)
	self:addTradeFlags(RecipeDB,3776,1,2,3,36,41,52,57)
	self:addTradeAcquire(RecipeDB,3776,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187,
	1,21087,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688,1,
	33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Guardian Leather Bracers -- 3777
	AddRecipe(3777,195,4260,2,GAME_ORIG,195,215,225,235)
	self:addTradeFlags(RecipeDB,3777,1,2,10,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,3777,7,2)

	-- Gem-studded Leather Belt -- 3778
	AddRecipe(3778,185,4262,1,GAME_ORIG,185,205,215,225)
	self:addTradeFlags(RecipeDB,3778,1,2,4,36,40,57)
	self:addTradeAcquire(RecipeDB,3778,2,2699)

	-- Barbaric Belt -- 3779
	AddRecipe(3779,200,4264,3,GAME_ORIG,200,220,230,240)
	self:addTradeFlags(RecipeDB,3779,1,2,5,11,36,40,51,57)
	self:addTradeAcquire(RecipeDB,3779,7,2)

	-- Heavy Armor Kit -- 3780
	AddRecipe(3780,150,4265,1,GAME_ORIG,150,170,180,190)
	self:addTradeFlags(RecipeDB,3780,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3780,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,8153,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,
	21087,1,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,17442,1,16278,1,3605)

	-- Cured Light Hide -- 3816
	AddRecipe(3816,35,4231,1,GAME_ORIG,35,55,65,75)
	self:addTradeFlags(RecipeDB,3816,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3816,1,1632,1,3007,1,3069,1,3365,1,3549
	,1,3605,1,3703,1,4212,1,4588,1,5127,1,5564,1,5784,1,
	11097,1,11098,1,16278,1,16688,1,16728,1,17442,1,18754,1,18771,1,19187,1,21087
	,1,1385,1,3967,1,33612,1,33635,1,33681,1,8153)

	-- Cured Medium Hide -- 3817
	AddRecipe(3817,100,4233,1,GAME_ORIG,100,115,122,130)
	self:addTradeFlags(RecipeDB,3817,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3817,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,5127,1,
	5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087,1,1632,1
	,5784,1,1385,1,3549,1,33612,1,33635,1,33681,1,8153,1,17442,1,16278,1,3605)

	-- Cured Heavy Hide -- 3818
	AddRecipe(3818,150,4236,1,GAME_ORIG,150,160,165,170)
	self:addTradeFlags(RecipeDB,3818,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,3818,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,8153,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,
	21087,1,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,17442,1,16278,1,3605)

	-- Raptor Hide Belt -- 4097
	AddRecipe(4097,165,4456,2,GAME_ORIG,165,185,195,205)
	self:addTradeFlags(RecipeDB,4097,1,4,36,40,51,57)
	self:addTradeAcquire(RecipeDB,4097,2,2816)

	-- Kodo Hide Bag -- 5244
	AddRecipe(5244,40,5081,2,GAME_ORIG,40,70,85,100)
	self:addTradeFlags(RecipeDB,5244,2,8,36,40)
	self:addTradeAcquire(RecipeDB,5244,4,769)

	-- Barbaric Harness -- 6661
	AddRecipe(6661,190,5739,1,GAME_ORIG,190,210,220,230)
	self:addTradeFlags(RecipeDB,6661,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,6661,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187,
	1,21087,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688,1,
	33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Murloc Scale Belt -- 6702
	AddRecipe(6702,90,5780,1,GAME_ORIG,90,120,135,150)
	self:addTradeFlags(RecipeDB,6702,1,2,4,5,11,36,40,51,57)
	self:addTradeAcquire(RecipeDB,6702,3,1732,3,3385,2,843,2,3556,2,4186)

	-- Murloc Scale Breastplate -- 6703
	AddRecipe(6703,95,5781,1,GAME_ORIG,95,125,140,155)
	self:addTradeFlags(RecipeDB,6703,1,2,4,5,11,36,40,51,57)
	self:addTradeAcquire(RecipeDB,6703,3,657,3,3386,2,843,2,3556,2,4186)

	-- Thick Murloc Armor -- 6704
	AddRecipe(6704,170,5782,2,GAME_ORIG,170,190,200,210)
	self:addTradeFlags(RecipeDB,6704,1,2,4,11,36,40,51,57)
	self:addTradeAcquire(RecipeDB,6704,3,938,3,1160,2,2381,2,2393)

	-- Murloc Scale Bracers -- 6705
	AddRecipe(6705,190,5783,2,GAME_ORIG,190,210,220,230)
	self:addTradeFlags(RecipeDB,6705,1,2,11,36,40,51,57)
	self:addTradeAcquire(RecipeDB,6705,3,2636,3,1561,2,4897)

	-- Handstitched Leather Vest -- 7126
	AddRecipe(7126,10,5957,1,GAME_ORIG,1,40,55,70)
	self:addTradeFlags(RecipeDB,7126,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,7126,8,8)

	-- Fine Leather Pants -- 7133
	AddRecipe(7133,105,5958,2,GAME_ORIG,105,130,142,155)
	self:addTradeFlags(RecipeDB,7133,1,2,10,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,7133,7,2)

	-- Dark Leather Pants -- 7135
	AddRecipe(7135,115,5961,1,GAME_ORIG,115,140,152,165)
	self:addTradeFlags(RecipeDB,7135,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,7135,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087,1
	,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,8153,1,17442,1,16278,1,3605)

	-- Guardian Pants -- 7147
	AddRecipe(7147,160,5962,1,GAME_ORIG,160,180,190,200)
	self:addTradeFlags(RecipeDB,7147,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,7147,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187,
	1,21087,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688,1,
	33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Barbaric Leggings -- 7149
	AddRecipe(7149,170,5963,1,GAME_ORIG,170,190,200,210)
	self:addTradeFlags(RecipeDB,7149,1,2,4,36,40,51,57)
	self:addTradeAcquire(RecipeDB,7149,2,2810,2,2821,2,3958,2,4877)

	-- Barbaric Shoulders -- 7151
	AddRecipe(7151,175,5964,1,GAME_ORIG,175,195,205,215)
	self:addTradeFlags(RecipeDB,7151,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,7151,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187,
	1,21087,1,1632,1,5784,1,16728,1,1385,1,3549,1,3365,1,3967,1,3703,1,33612,1,33635,1,16688,1,
	33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Guardian Cloak -- 7153
	AddRecipe(7153,185,5965,2,GAME_ORIG,185,205,215,225)
	self:addTradeFlags(RecipeDB,7153,1,2,10,36,40,53,54,60)
	self:addTradeAcquire(RecipeDB,7153,7,2)

	-- Guardian Gloves -- 7156
	AddRecipe(7156,190,5966,1,GAME_ORIG,190,210,220,230)
	self:addTradeFlags(RecipeDB,7156,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,7156,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187,
	1,21087,1,1632,1,5784,1,16728,1,1385,1,3549,1,3365,1,3967,1,3703,1,33612,1,33635,1,16688,1,
	33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Deviate Scale Cloak -- 7953
	AddRecipe(7953,90,6466,1,GAME_ORIG,90,120,135,150)
	self:addTradeFlags(RecipeDB,7953,1,2,4,36,40,51,60)
	self:addTradeAcquire(RecipeDB,7953,2,5783)

	-- Deviate Scale Gloves -- 7954
	AddRecipe(7954,105,6467,1,GAME_ORIG,105,130,142,155)
	self:addTradeFlags(RecipeDB,7954,1,2,4,36,40,51,57)
	self:addTradeAcquire(RecipeDB,7954,2,5783)

	-- Deviate Scale Belt -- 7955
	AddRecipe(7955,115,6468,2,GAME_ORIG,115,140,152,165)
	self:addTradeFlags(RecipeDB,7955,1,2,8,36,40,51,57)
	self:addTradeAcquire(RecipeDB,7955,4,1487)

	-- Moonglow Vest -- 8322
	AddRecipe(8322,90,6709,2,GAME_ORIG,90,115,130,145)
	self:addTradeFlags(RecipeDB,8322,1,8,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,8322,4,1582)

	-- Handstitched Leather Cloak -- 9058
	AddRecipe(9058,10,7276,1,GAME_ORIG,1,40,55,70)
	self:addTradeFlags(RecipeDB,9058,1,2,3,36,41,60)
	self:addTradeAcquire(RecipeDB,9058,8,8)

	-- Handstitched Leather Bracers -- 9059
	AddRecipe(9059,10,7277,1,GAME_ORIG,1,40,55,70)
	self:addTradeFlags(RecipeDB,9059,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,9059,8,8)

	-- Light Leather Quiver -- 9060
	AddRecipe(9060,30,7278,1,GAME_ORIG,30,60,75,90)
	self:addTradeFlags(RecipeDB,9060,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,9060,1,1632,1,3007,1,3069,1,3365,1,3549
	,1,3605,1,3703,1,4212,1,4588,1,5127,1,5564,1,5784,1,
	11097,1,11098,1,16278,1,16688,1,16728,1,17442,1,18754,1,18771,1,19187,1,21087
	,1,1385,1,3967,1,33612,1,33635,1,33681,1,8153)

	-- Small Leather Ammo Pouch -- 9062
	AddRecipe(9062,30,7279,1,GAME_ORIG,30,60,75,90)
	self:addTradeFlags(RecipeDB,9062,1,2,3,36,41,78)
	self:addTradeAcquire(RecipeDB,9062,1,1385,1,1632,1,3007,1,3069,1,3365
	,1,3549,1,3605,1,3703,1,3967,1,4212,1,4588,1,5127,1,5564,1,5784,1,
	11097,1,11098,1,16278,1,16688,1,16728,1,17442,1,18754,1,18771
	,1,19187,1,21087,1,33635,1,33612,1,33681,1,8153)

	-- Rugged Leather Pants -- 9064
	AddRecipe(9064,35,7280,2,GAME_ORIG,35,65,80,95)
	self:addTradeFlags(RecipeDB,9064,1,2,10,36,40,57)
	self:addTradeAcquire(RecipeDB,9064,7,2)

	-- Light Leather Bracers -- 9065
	AddRecipe(9065,70,7281,1,GAME_ORIG,70,100,115,130)
	self:addTradeFlags(RecipeDB,9065,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,9065,1,1385,1,1632,1,3007,1,3069,1,3365
	,1,3549,1,3605,1,3703,1,3967,1,4212,1,4588,1,5127,1,5564,1,5784,1,
	11097,1,11098,1,16278,1,16688,1,16728,1,17442,1,18754,1,18771
	,1,19187,1,21087,1,33635,1,33612,1,33681,1,8153)

	-- Light Leather Pants -- 9068
	AddRecipe(9068,95,7282,1,GAME_ORIG,95,125,140,155)
	self:addTradeFlags(RecipeDB,9068,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,9068,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087,1
	,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,8153,1,17442,1,16278,1,3605)

	-- Black Whelp Cloak -- 9070
	AddRecipe(9070,100,7283,1,GAME_ORIG,100,125,137,150)
	self:addTradeFlags(RecipeDB,9070,1,4,36,40,60)
	self:addTradeAcquire(RecipeDB,9070,2,2697)

	-- Red Whelp Gloves -- 9072
	AddRecipe(9072,120,7284,1,GAME_ORIG,120,145,157,170)
	self:addTradeFlags(RecipeDB,9072,1,4,36,40,57)
	self:addTradeAcquire(RecipeDB,9072,2,2679)

	-- Nimble Leather Gloves -- 9074
	AddRecipe(9074,120,7285,1,GAME_ORIG,120,145,157,170)
	self:addTradeFlags(RecipeDB,9074,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,9074,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,8153,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,
	21087,1,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,17442,1,16278,1,3605)

	-- Fletcher's Gloves -- 9145
	AddRecipe(9145,125,7348,1,GAME_ORIG,125,150,162,175)
	self:addTradeFlags(RecipeDB,9145,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,9145,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,8153,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,
	21087,1,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,17442,1,16278,1,3605)

	-- Herbalist's Gloves -- 9146
	AddRecipe(9146,135,7349,2,GAME_ORIG,135,160,172,185)
	self:addTradeFlags(RecipeDB,9146,1,4,36,41,57)
	self:addTradeAcquire(RecipeDB,9146,2,6731)

	-- Earthen Leather Shoulders -- 9147
	AddRecipe(9147,135,7352,1,GAME_ORIG,135,160,172,185)
	self:addTradeFlags(RecipeDB,9147,1,2,4,36,40,57)
	self:addTradeAcquire(RecipeDB,9147,2,3537)

	-- Pilferer's Gloves -- 9148
	AddRecipe(9148,140,7358,2,GAME_ORIG,140,165,177,190)
	self:addTradeFlags(RecipeDB,9148,1,2,10,36,40,51,57)
	self:addTradeAcquire(RecipeDB,9148,7,2)

	-- Heavy Earthen Gloves -- 9149
	AddRecipe(9149,145,7359,2,GAME_ORIG,145,170,182,195)
	self:addTradeFlags(RecipeDB,9149,1,2,10,36,40,51,57)
	self:addTradeAcquire(RecipeDB,9149,7,2)

	-- Heavy Quiver -- 9193
	AddRecipe(9193,150,7371,1,GAME_ORIG,150,170,180,190)
	self:addTradeFlags(RecipeDB,9193,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,9193,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,8153,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,
	21087,1,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,17442,1,16278,1,3605)

	-- Heavy Leather Ammo Pouch -- 9194
	AddRecipe(9194,150,7372,1,GAME_ORIG,150,170,180,190)
	self:addTradeFlags(RecipeDB,9194,1,2,3,36,41,78)
	self:addTradeAcquire(RecipeDB,9194,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,8153,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,
	21087,1,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,17442,1,16278,1,3605)

	-- Dusky Leather Leggings -- 9195
	AddRecipe(9195,165,7373,2,GAME_ORIG,165,185,195,205)
	self:addTradeFlags(RecipeDB,9195,1,2,10,36,40,51,57)
	self:addTradeAcquire(RecipeDB,9195,7,2)

	-- Dusky Leather Armor -- 9196
	AddRecipe(9196,175,7374,1,GAME_ORIG,175,195,205,215)
	self:addTradeFlags(RecipeDB,9196,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,9196,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187,
	1,21087,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Green Whelp Armor -- 9197
	AddRecipe(9197,175,7375,2,GAME_ORIG,175,195,205,215)
	self:addTradeFlags(RecipeDB,9197,1,2,10,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,9197,7,2)

	-- Frost Leather Cloak -- 9198
	AddRecipe(9198,180,7377,1,GAME_ORIG,180,200,210,220)
	self:addTradeFlags(RecipeDB,9198,1,2,3,36,41,53,54,60)
	self:addTradeAcquire(RecipeDB,9198,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187,
	1,21087,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Dusky Bracers -- 9201
	AddRecipe(9201,185,7378,1,GAME_ORIG,185,205,215,225)
	self:addTradeFlags(RecipeDB,9201,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,9201,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187,
	1,21087,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Green Whelp Bracers -- 9202
	AddRecipe(9202,190,7386,2,GAME_ORIG,190,210,220,230)
	self:addTradeFlags(RecipeDB,9202,1,2,4,36,41,57)
	self:addTradeAcquire(RecipeDB,9202,2,7854,2,4589,2,7852,2,4225)

	-- Dusky Belt -- 9206
	AddRecipe(9206,195,7387,1,GAME_ORIG,195,215,225,235)
	self:addTradeFlags(RecipeDB,9206,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,9206,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187,
	1,21087,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Dusky Boots -- 9207
	AddRecipe(9207,200,7390,3,GAME_ORIG,200,220,230,240)
	self:addTradeFlags(RecipeDB,9207,1,2,5,11,36,40,51,57)
	self:addTradeAcquire(RecipeDB,9207,7,2)

	-- Swift Boots -- 9208
	AddRecipe(9208,200,7391,2,GAME_ORIG,200,220,230,240)
	self:addTradeFlags(RecipeDB,9208,1,2,10,36,40,57)
	self:addTradeAcquire(RecipeDB,9208,7,2)

	-- Cured Thick Hide -- 10482
	AddRecipe(10482,200,8172,1,GAME_ORIG,200,200,200,200)
	self:addTradeFlags(RecipeDB,10482,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,10482,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187
	,1,21087,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Thick Armor Kit -- 10487
	AddRecipe(10487,200,8173,1,GAME_ORIG,200,220,230,240)
	self:addTradeFlags(RecipeDB,10487,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,10487,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187
	,1,21087,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Comfortable Leather Hat -- 10490
	AddRecipe(10490,200,8174,3,GAME_ORIG,200,220,230,240)
	self:addTradeFlags(RecipeDB,10490,1,2,5,11,36,40,57)
	self:addTradeAcquire(RecipeDB,10490,7,2)

	-- Nightscape Tunic -- 10499
	AddRecipe(10499,205,8175,1,GAME_ORIG,205,225,235,245)
	self:addTradeFlags(RecipeDB,10499,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,10499,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187
	,1,21087,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Nightscape Headband -- 10507
	AddRecipe(10507,205,8176,1,GAME_ORIG,205,225,235,245)
	self:addTradeFlags(RecipeDB,10507,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,10507,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187
	,1,21087,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Turtle Scale Gloves -- 10509
	AddRecipe(10509,205,8187,1,GAME_ORIG,205,225,235,245)
	self:addTradeFlags(RecipeDB,10509,1,2,4,36,40,53,54,58)
	self:addTradeAcquire(RecipeDB,10509,2,7852,2,7854)

	-- Turtle Scale Breastplate -- 10511
	AddRecipe(10511,210,8189,1,GAME_ORIG,210,230,240,250)
	self:addTradeFlags(RecipeDB,10511,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,10511,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187
	,1,21087,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Nightscape Shoulders -- 10516
	AddRecipe(10516,210,8192,2,GAME_ORIG,210,230,240,250)
	self:addTradeFlags(RecipeDB,10516,1,2,4,36,41,51,57)
	self:addTradeAcquire(RecipeDB,10516,2,7854,2,8160)

	-- Turtle Scale Bracers -- 10518
	AddRecipe(10518,210,8198,1,GAME_ORIG,210,230,240,250)
	self:addTradeFlags(RecipeDB,10518,1,2,3,36,41,58)
	self:addTradeAcquire(RecipeDB,10518,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187
	,1,21087,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,33681
	,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Big Voodoo Robe -- 10520
	AddRecipe(10520,215,8200,2,GAME_ORIG,215,235,245,255)
	self:addTradeFlags(RecipeDB,10520,1,2,10,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,10520,7,2)

	-- Tough Scorpid Breastplate -- 10525
	AddRecipe(10525,220,8203,2,GAME_ORIG,220,240,250,260)
	self:addTradeFlags(RecipeDB,10525,1,2,11,36,40,51,58)
	self:addTradeAcquire(RecipeDB,10525,3,5618)

	-- Wild Leather Shoulders -- 10529
	AddRecipe(10529,220,8210,2,GAME_ORIG,220,240,250,260)
	self:addTradeFlags(RecipeDB,10529,1,2,8,36,41,57)
	self:addTradeAcquire(RecipeDB,10529,4,2848,4,2855)

	-- Big Voodoo Mask -- 10531
	AddRecipe(10531,220,8201,2,GAME_ORIG,220,240,250,260)
	self:addTradeFlags(RecipeDB,10531,1,2,10,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,10531,7,2)

	-- Tough Scorpid Bracers -- 10533
	AddRecipe(10533,220,8205,2,GAME_ORIG,220,240,250,260)
	self:addTradeFlags(RecipeDB,10533,1,2,11,36,40,51,58)
	self:addTradeAcquire(RecipeDB,10533,3,5617)

	-- Tough Scorpid Gloves -- 10542
	AddRecipe(10542,225,8204,2,GAME_ORIG,225,245,255,265)
	self:addTradeFlags(RecipeDB,10542,1,2,11,36,40,51,58)
	self:addTradeAcquire(RecipeDB,10542,3,5616)

	-- Wild Leather Vest -- 10544
	AddRecipe(10544,225,8211,2,GAME_ORIG,225,245,255,265)
	self:addTradeFlags(RecipeDB,10544,1,2,8,36,41,57)
	self:addTradeAcquire(RecipeDB,10544,4,2849,4,2856)

	-- Wild Leather Helmet -- 10546
	AddRecipe(10546,225,8214,2,GAME_ORIG,225,245,255,265)
	self:addTradeFlags(RecipeDB,10546,1,2,8,36,41,57)
	self:addTradeAcquire(RecipeDB,10546,4,2850,4,2857)

	-- Nightscape Pants -- 10548
	AddRecipe(10548,230,8193,1,GAME_ORIG,230,250,260,270)
	self:addTradeFlags(RecipeDB,10548,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,10548,1,11097,1,11098,1,18754,1,18771,1,19187,1,21087,1,
	4212,1,3007,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Turtle Scale Helm -- 10552
	AddRecipe(10552,230,8191,1,GAME_ORIG,230,250,260,270)
	self:addTradeFlags(RecipeDB,10552,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,10552,1,11097,1,11098,1,18754,1,18771,1,19187,1,21087,1,
	4212,1,3007,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Tough Scorpid Boots -- 10554
	AddRecipe(10554,235,8209,2,GAME_ORIG,235,255,265,275)
	self:addTradeFlags(RecipeDB,10554,1,2,11,36,40,51,58)
	self:addTradeAcquire(RecipeDB,10554,3,5615)

	-- Turtle Scale Leggings -- 10556
	AddRecipe(10556,235,8185,1,GAME_ORIG,235,255,265,275)
	self:addTradeFlags(RecipeDB,10556,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,10556,1,11097,1,11098,1,18754,1,18771,1,19187,1,21087,1,
	4212,1,3007,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,5564,1,5127,1,4588)

	-- Nightscape Boots -- 10558
	AddRecipe(10558,235,8197,1,GAME_ORIG,235,255,265,275)
	self:addTradeFlags(RecipeDB,10558,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,10558,1,11097,1,11098,1,18754,1,18771,1,19187,1,21087,1,
	4212,1,3007,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Big Voodoo Pants -- 10560
	AddRecipe(10560,240,8202,2,GAME_ORIG,240,260,270,280)
	self:addTradeFlags(RecipeDB,10560,1,2,10,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,10560,7,2)

	-- Big Voodoo Cloak -- 10562
	AddRecipe(10562,240,8216,2,GAME_ORIG,240,260,270,280)
	self:addTradeFlags(RecipeDB,10562,1,2,10,36,40,53,54,60)
	self:addTradeAcquire(RecipeDB,10562,7,2)

	-- Tough Scorpid Shoulders -- 10564
	AddRecipe(10564,240,8207,2,GAME_ORIG,240,260,270,280)
	self:addTradeFlags(RecipeDB,10564,1,2,11,36,40,51,58)
	self:addTradeAcquire(RecipeDB,10564,3,5623,3,7805,3,7883)

	-- Wild Leather Boots -- 10566
	AddRecipe(10566,245,8213,2,GAME_ORIG,245,265,275,285)
	self:addTradeFlags(RecipeDB,10566,1,2,8,36,41,57)
	self:addTradeAcquire(RecipeDB,10566,4,2851,4,2858)

	-- Tough Scorpid Leggings -- 10568
	AddRecipe(10568,245,8206,2,GAME_ORIG,245,265,275,285)
	self:addTradeFlags(RecipeDB,10568,1,2,11,36,40,51,58)
	self:addTradeAcquire(RecipeDB,10568,3,5615)

	-- Tough Scorpid Helm -- 10570
	AddRecipe(10570,250,8208,2,GAME_ORIG,250,270,280,290)
	self:addTradeFlags(RecipeDB,10570,1,2,11,36,40,51,58)
	self:addTradeAcquire(RecipeDB,10570,3,5623,3,7805,3,7883)

	-- Wild Leather Leggings -- 10572
	AddRecipe(10572,250,8212,2,GAME_ORIG,250,270,280,290)
	self:addTradeFlags(RecipeDB,10572,1,2,8,36,41,57)
	self:addTradeAcquire(RecipeDB,10572,4,2852,4,2859)

	-- Wild Leather Cloak -- 10574
	AddRecipe(10574,250,8215,2,GAME_ORIG,250,270,280,290)
	self:addTradeFlags(RecipeDB,10574,1,2,8,36,41,60)
	self:addTradeAcquire(RecipeDB,10574,4,2853,4,2860)

	-- Dragonscale Gauntlets -- 10619
	AddRecipe(10619,225,8347,1,GAME_ORIG,225,245,255,265)
	self:addTradeFlags(RecipeDB,10619,1,2,3,36,41,58)
	self:addTradeAcquire(RecipeDB,10619,1,7866,1,7867,1,29508)

	-- Wolfshead Helm -- 10621
	AddRecipe(10621,225,8345,1,GAME_ORIG,225,245,255,265)
	self:addTradeFlags(RecipeDB,10621,1,2,3,F_DRUID,36,41,51,57)
	self:addTradeAcquire(RecipeDB,10621,1,7870,1,7871,1,29509)

	-- Gauntlets of the Sea -- 10630
	AddRecipe(10630,230,8346,1,GAME_ORIG,230,250,260,270)
	self:addTradeFlags(RecipeDB,10630,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,10630,1,7868,1,7869,1,29507)

	-- Helm of Fire -- 10632
	AddRecipe(10632,250,8348,1,GAME_ORIG,250,270,280,290)
	self:addTradeFlags(RecipeDB,10632,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,10632,1,7868,1,7869,1,29507)

	-- Feathered Breastplate -- 10647
	AddRecipe(10647,250,8349,1,GAME_ORIG,250,270,280,290)
	self:addTradeFlags(RecipeDB,10647,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,10647,1,7870,1,7871,1,29509)

	-- Dragonscale Breastplate -- 10650
	AddRecipe(10650,255,8367,1,GAME_ORIG,255,275,285,295)
	self:addTradeFlags(RecipeDB,10650,1,2,3,36,41,58)
	self:addTradeAcquire(RecipeDB,10650,1,7866,1,7867,1,29508)

	-- Quickdraw Quiver -- 14930
	AddRecipe(14930,225,8217,1,GAME_ORIG,225,245,255,265)
	self:addTradeFlags(RecipeDB,14930,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,14930,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187
	,1,21087,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Thick Leather Ammo Pouch -- 14932
	AddRecipe(14932,225,8218,1,GAME_ORIG,225,245,255,265)
	self:addTradeFlags(RecipeDB,14932,1,2,3,36,41,78)
	self:addTradeAcquire(RecipeDB,14932,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187
	,1,21087,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Cured Rugged Hide -- 19047
	AddRecipe(19047,250,15407,1,GAME_ORIG,250,250,255,260)
	self:addTradeFlags(RecipeDB,19047,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,19047,1,11097,1,11098,1,18754,1,18771,1,19187,1,21087,1,
	4212,1,3007,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Heavy Scorpid Bracers -- 19048
	AddRecipe(19048,255,15077,1,GAME_ORIG,255,275,285,295)
	self:addTradeFlags(RecipeDB,19048,1,2,4,36,41,51,58)
	self:addTradeAcquire(RecipeDB,19048,2,12956)

	-- Wicked Leather Gauntlets -- 19049
	AddRecipe(19049,260,15083,1,GAME_ORIG,260,280,290,300)
	self:addTradeFlags(RecipeDB,19049,1,2,4,36,40,51,57)
	self:addTradeAcquire(RecipeDB,19049,2,12942,2,12943)

	-- Green Dragonscale Breastplate -- 19050
	AddRecipe(19050,260,15045,1,GAME_ORIG,260,280,290,300)
	self:addTradeFlags(RecipeDB,19050,1,2,4,36,40,53,54,58)
	self:addTradeAcquire(RecipeDB,19050,2,11874)

	-- Heavy Scorpid Vest -- 19051
	AddRecipe(19051,265,15076,2,GAME_ORIG,265,285,295,305)
	self:addTradeFlags(RecipeDB,19051,1,2,11,36,40,51,58)
	self:addTradeAcquire(RecipeDB,19051,3,5981,3,6005)

	-- Wicked Leather Bracers -- 19052
	AddRecipe(19052,265,15084,2,GAME_ORIG,265,285,295,305)
	self:addTradeFlags(RecipeDB,19052,1,2,3,36,40,51,57)
	self:addTradeAcquire(RecipeDB,19052,1,11097,1,11098,1,18754,1,18771,1,19187,1,21087,1,
	4212,1,3007,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Chimeric Gloves -- 19053
	AddRecipe(19053,265,15074,1,GAME_ORIG,265,285,295,305)
	self:addTradeFlags(RecipeDB,19053,1,2,4,36,41,57)
	self:addTradeAcquire(RecipeDB,19053,2,12957)

	-- Red Dragonscale Breastplate -- 19054
	AddRecipe(19054,300,15047,3,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,19054,1,2,5,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,19054,3,10363)

	-- Runic Leather Gauntlets -- 19055
	AddRecipe(19055,270,15091,2,GAME_ORIG,270,290,300,310)
	self:addTradeFlags(RecipeDB,19055,1,2,3,10,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,19055,7,2,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,
	1,5127,1,5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087
	,1,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,8153,1,17442,1,16278,1,3605)

	-- Rugged Armor Kit -- 19058
	AddRecipe(19058,250,15564,1,GAME_ORIG,250,255,265,275)
	self:addTradeFlags(RecipeDB,19058,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,19058,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087,1
	,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,8153,1,17442,1,3605)

	-- Volcanic Leggings -- 19059
	AddRecipe(19059,270,15054,2,GAME_ORIG,270,290,300,310)
	self:addTradeFlags(RecipeDB,19059,1,2,11,36,40,57)
	self:addTradeAcquire(RecipeDB,19059,3,7035)

	-- Green Dragonscale Leggings -- 19060
	AddRecipe(19060,270,15046,3,GAME_ORIG,270,290,300,310)
	self:addTradeFlags(RecipeDB,19060,1,2,5,36,40,53,54,58)
	self:addTradeAcquire(RecipeDB,19060,3,5226)

	-- Living Shoulders -- 19061
	AddRecipe(19061,270,15061,1,GAME_ORIG,270,290,300,310)
	self:addTradeFlags(RecipeDB,19061,1,2,4,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,19061,2,7852,2,7854)

	-- Ironfeather Shoulders -- 19062
	AddRecipe(19062,270,15067,1,GAME_ORIG,270,290,300,310)
	self:addTradeFlags(RecipeDB,19062,1,2,4,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,19062,2,12958)

	-- Chimeric Boots -- 19063
	AddRecipe(19063,275,15073,2,GAME_ORIG,275,295,305,315)
	self:addTradeFlags(RecipeDB,19063,1,2,10,36,40,57)
	self:addTradeAcquire(RecipeDB,19063,7,2)

	-- Heavy Scorpid Gauntlets -- 19064
	AddRecipe(19064,275,15078,2,GAME_ORIG,275,295,305,315)
	self:addTradeFlags(RecipeDB,19064,1,2,11,36,40,51,58)
	self:addTradeAcquire(RecipeDB,19064,3,7025)

	-- Runic Leather Bracers -- 19065
	AddRecipe(19065,275,15092,2,GAME_ORIG,275,295,305,315)
	self:addTradeFlags(RecipeDB,19065,1,2,3,36,40,57)
	self:addTradeAcquire(RecipeDB,19065,1,11097,1,11098,1,18754,1,18771,1,19187,1,21087,1,
	4212,1,3007,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,3605,1,5564,1,5127,1,4588)

	-- Frostsaber Boots -- 19066
	AddRecipe(19066,275,15071,1,GAME_ORIG,275,295,305,315)
	self:addTradeFlags(RecipeDB,19066,1,2,4,36,41,57)
	self:addTradeAcquire(RecipeDB,19066,2,11189)

	-- Stormshroud Pants -- 19067
	AddRecipe(19067,275,15057,1,GAME_ORIG,275,295,305,315)
	self:addTradeFlags(RecipeDB,19067,1,2,4,36,40,51,52,57)
	self:addTradeAcquire(RecipeDB,19067,2,12942,2,12943)

	-- Warbear Harness -- 19068
	AddRecipe(19068,275,15064,1,GAME_ORIG,275,295,305,315)
	self:addTradeFlags(RecipeDB,19068,1,2,4,6,11,36,41,51,57,99)
	self:addTradeAcquire(RecipeDB,19068,6,576,1,11557)

	-- Heavy Scorpid Belt -- 19070
	AddRecipe(19070,280,15082,2,GAME_ORIG,280,300,310,320)
	self:addTradeFlags(RecipeDB,19070,1,2,10,36,40,51,58)
	self:addTradeAcquire(RecipeDB,19070,7,2)

	-- Wicked Leather Headband -- 19071
	AddRecipe(19071,280,15086,2,GAME_ORIG,280,300,310,320)
	self:addTradeFlags(RecipeDB,19071,1,2,3,36,40,51,57)
	self:addTradeAcquire(RecipeDB,19071,1,11097,1,11098,1,18754,1,18771,1,19187,1,21087,1,
	4212,1,3007,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Runic Leather Belt -- 19072
	AddRecipe(19072,280,15093,2,GAME_ORIG,280,300,310,320)
	self:addTradeFlags(RecipeDB,19072,1,2,3,36,40,57)
	self:addTradeAcquire(RecipeDB,19072,1,11097,1,11098,1,18754,1,18771,1,19187,1,21087,1,
	4212,1,1632,1,5784,1,16728,1,3007,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Chimeric Leggings -- 19073
	AddRecipe(19073,280,15072,2,GAME_ORIG,280,300,310,320)
	self:addTradeFlags(RecipeDB,19073,1,2,10,36,40,57)
	self:addTradeAcquire(RecipeDB,19073,7,2)

	-- Frostsaber Leggings -- 19074
	AddRecipe(19074,285,15069,2,GAME_ORIG,285,305,315,325)
	self:addTradeFlags(RecipeDB,19074,1,2,11,36,40,57)
	self:addTradeAcquire(RecipeDB,19074,3,7440)

	-- Heavy Scorpid Leggings -- 19075
	AddRecipe(19075,285,15079,2,GAME_ORIG,285,305,315,325)
	self:addTradeFlags(RecipeDB,19075,1,2,11,36,40,51,58)
	self:addTradeAcquire(RecipeDB,19075,3,7027)

	-- Volcanic Breastplate -- 19076
	AddRecipe(19076,285,15053,2,GAME_ORIG,285,305,315,325)
	self:addTradeFlags(RecipeDB,19076,1,2,5,36,40,57)
	self:addTradeAcquire(RecipeDB,19076,3,9259)

	-- Blue Dragonscale Breastplate -- 19077
	AddRecipe(19077,285,15048,1,GAME_ORIG,285,305,315,325)
	self:addTradeFlags(RecipeDB,19077,1,2,4,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,19077,2,12957)

	-- Living Leggings -- 19078
	AddRecipe(19078,285,15060,3,GAME_ORIG,285,305,315,325)
	self:addTradeFlags(RecipeDB,19078,1,2,11,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,19078,3,7158)

	-- Stormshroud Armor -- 19079
	AddRecipe(19079,285,15056,3,GAME_ORIG,285,305,315,325)
	self:addTradeFlags(RecipeDB,19079,1,2,11,36,40,51,52,57)
	self:addTradeAcquire(RecipeDB,19079,3,6138)

	-- Warbear Woolies -- 19080
	AddRecipe(19080,285,15065,1,GAME_ORIG,285,305,315,325)
	self:addTradeFlags(RecipeDB,19080,1,2,4,36,41,51,57,99)
	self:addTradeAcquire(RecipeDB,19080,6,576,1,11557)

	-- Chimeric Vest -- 19081
	AddRecipe(19081,290,15075,2,GAME_ORIG,280,300,310,320)
	self:addTradeFlags(RecipeDB,19081,1,2,10,36,40,57)
	self:addTradeAcquire(RecipeDB,19081,7,2)

	-- Runic Leather Headband -- 19082
	AddRecipe(19082,290,15094,1,GAME_ORIG,290,310,320,330)
	self:addTradeFlags(RecipeDB,19082,1,2,3,36,40,57)
	self:addTradeAcquire(RecipeDB,19082,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087,1
	,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,8153,1,17442,1,16278,1,3605)

	-- Wicked Leather Pants -- 19083
	AddRecipe(19083,290,15087,2,GAME_ORIG,290,315,325,335)
	self:addTradeFlags(RecipeDB,19083,1,2,3,36,40,51,57)
	self:addTradeAcquire(RecipeDB,19083,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087,1
	,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,8153,1,17442,1,16278,1,3605)

	-- Devilsaur Gauntlets -- 19084
	AddRecipe(19084,290,15063,1,GAME_ORIG,290,310,320,330)
	self:addTradeFlags(RecipeDB,19084,1,2,4,36,40,51,57)
	self:addTradeAcquire(RecipeDB,19084,2,12959)

	-- Black Dragonscale Breastplate -- 19085
	AddRecipe(19085,290,15050,1,GAME_ORIG,290,310,320,330)
	self:addTradeFlags(RecipeDB,19085,1,2,4,5,36,41,51,58)
	self:addTradeAcquire(RecipeDB,19085,2,9499)

	-- Ironfeather Breastplate -- 19086
	AddRecipe(19086,290,15066,3,GAME_ORIG,290,310,320,330)
	self:addTradeFlags(RecipeDB,19086,1,2,11,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,19086,3,2644)

	-- Frostsaber Gloves -- 19087
	AddRecipe(19087,295,15070,2,GAME_ORIG,295,315,325,335)
	self:addTradeFlags(RecipeDB,19087,1,2,11,36,40,57)
	self:addTradeAcquire(RecipeDB,19087,3,7441)

	-- Heavy Scorpid Helm -- 19088
	AddRecipe(19088,295,15080,1,GAME_ORIG,295,315,325,335)
	self:addTradeFlags(RecipeDB,19088,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,19088,2,12956)

	-- Blue Dragonscale Shoulders -- 19089
	AddRecipe(19089,295,15049,3,GAME_ORIG,295,315,325,335)
	self:addTradeFlags(RecipeDB,19089,1,2,11,36,40,53,54,58)
	self:addTradeAcquire(RecipeDB,19089,3,6146)

	-- Stormshroud Shoulders -- 19090
	AddRecipe(19090,295,15058,3,GAME_ORIG,295,315,325,335)
	self:addTradeFlags(RecipeDB,19090,1,2,11,36,40,51,52,57)
	self:addTradeAcquire(RecipeDB,19090,3,6144)

	-- Runic Leather Pants -- 19091
	AddRecipe(19091,300,15095,2,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,19091,1,2,3,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,19091,1,11097,1,11098,1,18754,1,18771,1,19187,1,21087,1,
	4212,1,3007,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,4588)

	-- Wicked Leather Belt -- 19092
	AddRecipe(19092,300,15088,2,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,19092,1,2,3,36,40,51,57)
	self:addTradeAcquire(RecipeDB,19092,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087,1
	,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,8153,1,17442,1,16278,1,3605)

	-- Onyxia Scale Cloak -- 19093
	AddRecipe(19093,300,15138,3,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,19093,1,2,6,8,36,41,60)
	self:addTradeAcquire(RecipeDB,19093,4,7493,4,7497,8,10)

	-- Black Dragonscale Shoulders -- 19094
	AddRecipe(19094,300,15051,3,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,19094,1,2,5,36,40,51,58)
	self:addTradeAcquire(RecipeDB,19094,3,8898)

	-- Living Breastplate -- 19095
	AddRecipe(19095,300,15059,3,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,19095,1,2,11,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,19095,3,1813)

	-- Devilsaur Leggings -- 19097
	AddRecipe(19097,300,15062,3,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,19097,1,2,11,36,40,51,57)
	self:addTradeAcquire(RecipeDB,19097,3,6556,3,6557,3,6559,3,9477)

	-- Wicked Leather Armor -- 19098
	AddRecipe(19098,300,15085,2,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,19098,1,2,3,36,40,51,57)
	self:addTradeAcquire(RecipeDB,19098,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087,1
	,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,8153,1,17442,1,16278)

	-- Heavy Scorpid Shoulders -- 19100
	AddRecipe(19100,300,15081,2,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,19100,1,2,11,36,40,51,58)
	self:addTradeAcquire(RecipeDB,19100,3,7029)

	-- Volcanic Shoulders -- 19101
	AddRecipe(19101,300,15055,2,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,19101,1,2,5,36,40,57)
	self:addTradeAcquire(RecipeDB,19101,3,9260)

	-- Runic Leather Armor -- 19102
	AddRecipe(19102,300,15090,2,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,19102,1,2,3,36,40,57)
	self:addTradeAcquire(RecipeDB,19102,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087,1
	,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,8153,1,17442,1,16278,1,3605)

	-- Runic Leather Shoulders -- 19103
	AddRecipe(19103,300,15096,2,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,19103,1,2,3,36,40,57)
	self:addTradeAcquire(RecipeDB,19103,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087,1
	,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,8153,1,17442,1,16278,1,3605)

	-- Frostsaber Tunic -- 19104
	AddRecipe(19104,300,15068,2,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,19104,1,2,11,36,40,57)
	self:addTradeAcquire(RecipeDB,19104,3,7438)

	-- Black Dragonscale Leggings -- 19107
	AddRecipe(19107,300,15052,3,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,19107,1,2,5,36,40,51,58)
	self:addTradeAcquire(RecipeDB,19107,3,8903)

	-- Medium Leather -- 20648
	AddRecipe(20648,100,2319,1,GAME_ORIG,100,100,105,110)
	self:addTradeFlags(RecipeDB,20648,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,20648,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,5127,1,
	5564,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,21087,1,1632,1
	,5784,1,1385,1,3549,1,33635,1,33612,1,33681,1,8153,1,17442,1,16278,1,3605)

	-- Heavy Leather -- 20649
	AddRecipe(20649,150,4234,1,GAME_ORIG,150,150,155,160)
	self:addTradeFlags(RecipeDB,20649,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,20649,1,1385,1,3007,1,3365,1,3703,1,3967,1,4212,1,4588,1,
	5127,1,5564,1,8153,1,11097,1,11098,1,16688,1,16728,1,18754,1,18771,1,19187,1,
	21087,1,1632,1,5784,1,3549,1,33612,1,33635,1,33681,1,17442,1,16278,1,3605)

	-- Thick Leather -- 20650
	AddRecipe(20650,200,4304,1,GAME_ORIG,200,200,202,205)
	self:addTradeFlags(RecipeDB,20650,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,20650,1,3007,1,4212,1,11097,1,11098,1,18754,1,18771,1,19187
	,1,21087,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Corehound Boots -- 20853
	AddRecipe(20853,295,16982,1,GAME_ORIG,295,315,325,335)
	self:addTradeFlags(RecipeDB,20853,1,2,4,36,41,51,57)
	self:addTradeAcquire(RecipeDB,20853,2,12944)

	-- Molten Helm -- 20854
	AddRecipe(20854,300,16983,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,20854,1,2,4,36,41,52,57)
	self:addTradeAcquire(RecipeDB,20854,2,12944)

	-- Black Dragonscale Boots -- 20855
	AddRecipe(20855,300,16984,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,20855,1,2,4,36,41,51,58,98)
	self:addTradeAcquire(RecipeDB,20855,6,59,2,12944)

	-- Gloves of the Greatfather -- 21943
	AddRecipe(21943,190,17721,2,GAME_ORIG,190,210,220,230)
	self:addTradeFlags(RecipeDB,21943,1,2,7,11,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,21943,5,1)

	-- Rugged Leather -- 22331
	AddRecipe(22331,250,8170,1,GAME_ORIG,250,250,250,250)
	self:addTradeFlags(RecipeDB,22331,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,22331,1,11097,1,11098,1,18754,1,18771,1,19187,1,21087,1,
	4212,1,3007,1,1632,1,5784,1,16728,1,3703,1,1385,1,3549,1,3365,1,3967,1,33612,1,33635,1,16688
	,1,33681,1,8153,1,17442,1,16278,1,3605,1,5564,1,5127,1,4588)

	-- Shadowskin Gloves -- 22711
	AddRecipe(22711,200,18238,1,GAME_ORIG,200,210,220,230)
	self:addTradeFlags(RecipeDB,22711,1,2,4,36,41,57)
	self:addTradeAcquire(RecipeDB,22711,2,2699)

	-- Core Armor Kit -- 22727
	AddRecipe(22727,300,18251,3,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,22727,1,2,6,36,41,52)
	self:addTradeAcquire(RecipeDB,22727,8,26)

	-- Gordok Ogre Suit -- 22815
	AddRecipe(22815,275,18258,2,GAME_ORIG,275,285,290,385)
	self:addTradeFlags(RecipeDB,22815,1,2,5,8,36,41)
	self:addTradeAcquire(RecipeDB,22815,4,5518)

	-- Girdle of Insight -- 22921
	AddRecipe(22921,300,18504,3,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,22921,1,2,5,36,41,57)
	self:addTradeAcquire(RecipeDB,22921,8,23)

	-- Mongoose Boots -- 22922
	AddRecipe(22922,300,18506,3,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,22922,1,2,5,36,41,51,57)
	self:addTradeAcquire(RecipeDB,22922,8,23)

	-- Swift Flight Bracers -- 22923
	AddRecipe(22923,300,18508,3,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,22923,1,2,5,36,41,51,58)
	self:addTradeAcquire(RecipeDB,22923,8,23)

	-- Chromatic Cloak -- 22926
	AddRecipe(22926,300,18509,4,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,22926,1,2,5,36,40,60)
	self:addTradeAcquire(RecipeDB,22926,8,23)

	-- Hide of the Wild -- 22927
	AddRecipe(22927,300,18510,4,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,22927,1,2,5,36,40,53,54,60)
	self:addTradeAcquire(RecipeDB,22927,8,23)

	-- Shifting Cloak -- 22928
	AddRecipe(22928,300,18511,4,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,22928,1,2,5,36,40,52,60)
	self:addTradeAcquire(RecipeDB,22928,8,23)

	-- Heavy Leather Ball -- 23190
	AddRecipe(23190,150,18662,1,GAME_ORIG,150,150,155,160)
	self:addTradeFlags(RecipeDB,23190,1,2,4,36,40)
	self:addTradeAcquire(RecipeDB,23190,2,5128,2,3366)

	-- Barbaric Bracers -- 23399
	AddRecipe(23399,155,18948,1,GAME_ORIG,155,175,185,195)
	self:addTradeFlags(RecipeDB,23399,1,2,4,36,40,51,57)
	self:addTradeAcquire(RecipeDB,23399,2,4225,2,4589)

	-- Might of the Timbermaw -- 23703
	AddRecipe(23703,290,19044,1,GAME_ORIG,290,310,320,330)
	self:addTradeFlags(RecipeDB,23703,1,2,4,36,41,51,57,99)
	self:addTradeAcquire(RecipeDB,23703,6,576,2,11557)

	-- Timbermaw Brawlers -- 23704
	AddRecipe(23704,300,19049,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,23704,1,2,4,36,41,51,57,99)
	self:addTradeAcquire(RecipeDB,23704,6,576,3,11557)

	-- Dawn Treaders -- 23705
	AddRecipe(23705,290,19052,1,GAME_ORIG,290,310,320,330)
	self:addTradeFlags(RecipeDB,23705,1,2,4,36,41,51,57,96)
	self:addTradeAcquire(RecipeDB,23705,6,529,2,10856,6,529,2,10857,6,529,2,11536)

	-- Golden Mantle of the Dawn -- 23706
	AddRecipe(23706,300,19058,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,23706,1,2,4,36,41,52,57,96)
	self:addTradeAcquire(RecipeDB,23706,6,529,3,10856,6,529,3,10857,6,529,3,11536)

	-- Lava Belt -- 23707
	AddRecipe(23707,300,19149,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,23707,1,2,4,36,41,57,98)
	self:addTradeAcquire(RecipeDB,23707,6,59,2,12944)

	-- Chromatic Gauntlets -- 23708
	AddRecipe(23708,300,19157,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,23708,1,2,4,36,41,51,58,98)
	self:addTradeAcquire(RecipeDB,23708,6,59,3,12944)

	-- Corehound Belt -- 23709
	AddRecipe(23709,300,19162,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,23709,1,2,4,36,41,53,54,57,98)
	self:addTradeAcquire(RecipeDB,23709,6,59,3,12944)

	-- Molten Belt -- 23710
	AddRecipe(23710,300,19163,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,23710,1,2,4,36,41,51,57,98)
	self:addTradeAcquire(RecipeDB,23710,6,59,3,12944)

	-- Primal Batskin Jerkin -- 24121
	AddRecipe(24121,300,19685,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,24121,1,2,4,36,41,51,57,100)
	self:addTradeAcquire(RecipeDB,24121,6,270,3,14921)

	-- Primal Batskin Gloves -- 24122
	AddRecipe(24122,300,19686,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,24122,1,2,4,36,41,51,57,100)
	self:addTradeAcquire(RecipeDB,24122,6,270,2,14921)

	-- Primal Batskin Bracers -- 24123
	AddRecipe(24123,300,19687,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,24123,1,2,4,36,41,51,57,100)
	self:addTradeAcquire(RecipeDB,24123,6,270,1,14921)

	-- Blood Tiger Breastplate -- 24124
	AddRecipe(24124,300,19688,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,24124,1,2,4,36,41,53,54,57,100)
	self:addTradeAcquire(RecipeDB,24124,6,270,3,14921)

	-- Blood Tiger Shoulders -- 24125
	AddRecipe(24125,300,19689,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,24125,1,2,4,36,41,53,54,57,100)
	self:addTradeAcquire(RecipeDB,24125,6,270,2,14921)

	-- Blue Dragonscale Leggings -- 24654
	AddRecipe(24654,300,20295,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,24654,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,24654,1,7866,1,7867,1,29508)

	-- Green Dragonscale Gauntlets -- 24655
	AddRecipe(24655,260,20296,1,GAME_ORIG,260,280,290,300)
	self:addTradeFlags(RecipeDB,24655,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,24655,1,7866,1,7867,1,29508)

	-- Dreamscale Breastplate -- 24703
	AddRecipe(24703,300,20380,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,24703,1,2,4,36,41,51,58,97)
	self:addTradeAcquire(RecipeDB,24703,6,609,4,15293)

	-- Spitfire Bracers -- 24846
	AddRecipe(24846,300,20481,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,24846,1,2,4,36,41,53,54,58,97)
	self:addTradeAcquire(RecipeDB,24846,6,609,1,15293)

	-- Spitfire Gauntlets -- 24847
	AddRecipe(24847,300,20480,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,24847,1,2,4,36,41,53,54,58,97)
	self:addTradeAcquire(RecipeDB,24847,6,609,2,15293)

	-- Spitfire Breastplate -- 24848
	AddRecipe(24848,300,20479,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,24848,1,2,4,36,41,53,54,58,97)
	self:addTradeAcquire(RecipeDB,24848,6,609,3,15293)

	-- Sandstalker Bracers -- 24849
	AddRecipe(24849,300,20476,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,24849,1,2,4,36,41,58,97)
	self:addTradeAcquire(RecipeDB,24849,6,609,1,15293)

	-- Sandstalker Gauntlets -- 24850
	AddRecipe(24850,300,20477,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,24850,1,2,4,36,41,58,97)
	self:addTradeAcquire(RecipeDB,24850,6,609,2,15293)

	-- Sandstalker Breastplate -- 24851
	AddRecipe(24851,300,20478,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,24851,1,2,4,36,41,58,97)
	self:addTradeAcquire(RecipeDB,24851,6,609,3,15293)

	-- Black Whelp Tunic -- 24940
	AddRecipe(24940,100,20575,1,GAME_ORIG,100,125,137,150)
	self:addTradeFlags(RecipeDB,24940,1,4,36,40,51,57)
	self:addTradeAcquire(RecipeDB,24940,2,777)

	-- Stormshroud Gloves -- 26279
	AddRecipe(26279,300,21278,3,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,26279,1,2,11,36,40,51,57)
	self:addTradeAcquire(RecipeDB,26279,3,14454,3,14457)

	-- Polar Tunic -- 28219
	AddRecipe(28219,300,22661,4,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,28219,1,2,4,6,36,41,51,57)
	self:addTradeAcquire(RecipeDB,28219,6,529,4,16365,8,41)

	-- Polar Gloves -- 28220
	AddRecipe(28220,300,22662,4,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,28220,1,2,4,6,36,41,51,57)
	self:addTradeAcquire(RecipeDB,28220,6,529,3,16365,8,41)

	-- Polar Bracers -- 28221
	AddRecipe(28221,300,22663,4,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,28221,1,2,4,6,36,41,51,57)
	self:addTradeAcquire(RecipeDB,28221,6,529,3,16365,8,41)

	-- Icy Scale Breastplate -- 28222
	AddRecipe(28222,300,22664,4,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,28222,1,2,4,6,36,41,51,58)
	self:addTradeAcquire(RecipeDB,28222,6,529,4,16365,8,41)

	-- Icy Scale Gauntlets -- 28223
	AddRecipe(28223,300,22666,4,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,28223,1,2,4,6,36,41,51,58)
	self:addTradeAcquire(RecipeDB,28223,6,529,3,16365,8,41)

	-- Icy Scale Bracers -- 28224
	AddRecipe(28224,300,22665,4,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,28224,1,2,4,6,36,41,51,58)
	self:addTradeAcquire(RecipeDB,28224,6,529,3,16365,8,41)

	-- Bramblewood Helm -- 28472
	AddRecipe(28472,300,22759,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,28472,1,2,4,36,41,57,97)
	self:addTradeAcquire(RecipeDB,28472,6,609,3,15293)

	-- Bramblewood Boots -- 28473
	AddRecipe(28473,300,22760,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,28473,1,2,4,36,41,57,97)
	self:addTradeAcquire(RecipeDB,28473,6,609,2,15293)

	-- Bramblewood Belt -- 28474
	AddRecipe(28474,300,22761,1,GAME_ORIG,300,320,330,340)
	self:addTradeFlags(RecipeDB,28474,1,2,4,36,41,57,97)
	self:addTradeAcquire(RecipeDB,28474,6,609,1,15293)

	-- Knothide Leather -- 32454
	AddRecipe(32454,300,21887,1,1,300,300,305,310)
	self:addTradeFlags(RecipeDB,32454,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,32454,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Heavy Knothide Leather -- 32455
	AddRecipe(32455,325,23793,1,1,325,325,330,335)
	self:addTradeFlags(RecipeDB,32455,1,2,4,36,40,57)
	self:addTradeAcquire(RecipeDB,32455,2,16689,2,16748,2,19196)

	-- Knothide Armor Kit -- 32456
	AddRecipe(32456,300,25650,1,1,300,310,325,340)
	self:addTradeFlags(RecipeDB,32456,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,32456,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Vindicator's Armor Kit -- 32457
	AddRecipe(32457,325,25651,1,1,325,335,340,345)
	self:addTradeFlags(RecipeDB,32457,1,4,36,41,52,101)
	self:addTradeAcquire(RecipeDB,32457,6,932,3,19321)

	-- Magister's Armor Kit -- 32458
	AddRecipe(32458,325,25652,1,1,325,335,340,345)
	self:addTradeFlags(RecipeDB,32458,1,2,4,36,41,53,54,110)
	self:addTradeAcquire(RecipeDB,32458,6,934,3,19331)

	-- Riding Crop -- 32461
	AddRecipe(32461,350,25653,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,32461,1,2,4,36,40,61)
	self:addTradeAcquire(RecipeDB,32461,2,18672)

	-- Felscale Gloves -- 32462
	AddRecipe(32462,300,25654,1,1,300,310,320,330)
	self:addTradeFlags(RecipeDB,32462,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,32462,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Felscale Boots -- 32463
	AddRecipe(32463,310,25655,1,1,310,320,330,340)
	self:addTradeFlags(RecipeDB,32463,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,32463,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Felscale Pants -- 32464
	AddRecipe(32464,320,25656,1,1,320,330,340,350)
	self:addTradeFlags(RecipeDB,32464,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,32464,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Felscale Breastplate -- 32465
	AddRecipe(32465,335,25657,1,1,335,345,355,365)
	self:addTradeFlags(RecipeDB,32465,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,32465,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Scaled Draenic Pants -- 32466
	AddRecipe(32466,300,25662,1,1,300,310,320,330)
	self:addTradeFlags(RecipeDB,32466,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,32466,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Scaled Draenic Gloves -- 32467
	AddRecipe(32467,310,25661,1,1,310,320,330,340)
	self:addTradeFlags(RecipeDB,32467,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,32467,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Scaled Draenic Vest -- 32468
	AddRecipe(32468,325,25660,1,1,325,335,345,355)
	self:addTradeFlags(RecipeDB,32468,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,32468,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Scaled Draenic Boots -- 32469
	AddRecipe(32469,335,25659,1,1,335,345,355,365)
	self:addTradeFlags(RecipeDB,32469,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,32469,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Thick Draenic Gloves -- 32470
	AddRecipe(32470,300,25669,1,1,300,310,320,330)
	self:addTradeFlags(RecipeDB,32470,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,32470,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Thick Draenic Pants -- 32471
	AddRecipe(32471,315,25670,1,1,315,325,335,345)
	self:addTradeFlags(RecipeDB,32471,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,32471,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Thick Draenic Boots -- 32472
	AddRecipe(32472,320,25668,1,1,320,330,340,350)
	self:addTradeFlags(RecipeDB,32472,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,32472,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Thick Draenic Vest -- 32473
	AddRecipe(32473,330,25671,1,1,330,340,350,360)
	self:addTradeFlags(RecipeDB,32473,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,32473,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Wild Draenish Boots -- 32478
	AddRecipe(32478,300,25673,1,1,300,310,320,330)
	self:addTradeFlags(RecipeDB,32478,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,32478,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Wild Draenish Gloves -- 32479
	AddRecipe(32479,310,25674,1,1,310,320,330,340)
	self:addTradeFlags(RecipeDB,32479,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,32479,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Wild Draenish Leggings -- 32480
	AddRecipe(32480,320,25675,1,1,320,330,340,350)
	self:addTradeFlags(RecipeDB,32480,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,32480,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Wild Draenish Vest -- 32481
	AddRecipe(32481,330,25676,1,1,330,340,350,360)
	self:addTradeFlags(RecipeDB,32481,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,32481,1,18754,1,18771,1,19187,1,21087,1,33635,1,33612
	,1,33681)

	-- Comfortable Insoles -- 32482
	AddRecipe(32482,300,25679,1,1,300,300,305,310)
	self:addTradeFlags(RecipeDB,32482,1,2,4,36,40)
	self:addTradeAcquire(RecipeDB,32482,2,16689,2,16748)

	-- Stylin' Purple Hat -- 32485
	AddRecipe(32485,350,25680,3,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,32485,1,2,5,36,41,51,57)
	self:addTradeAcquire(RecipeDB,32485,3,18667)

	-- Stylin' Adventure Hat -- 32487
	AddRecipe(32487,350,25681,3,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,32487,1,2,5,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,32487,3,17820,3,28132)

	-- Stylin' Crimson Hat -- 32488
	AddRecipe(32488,350,25683,3,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,32488,1,2,5,36,41,51,58)
	self:addTradeAcquire(RecipeDB,32488,3,18322)

	-- Stylin' Jungle Hat -- 32489
	AddRecipe(32489,350,25682,3,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,32489,1,2,5,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,32489,3,17839,3,21104)

	-- Fel Leather Gloves -- 32490
	AddRecipe(32490,340,25685,3,1,340,350,360,370)
	self:addTradeFlags(RecipeDB,32490,1,2,4,36,41,51,57,105)
	self:addTradeAcquire(RecipeDB,32490,6,933,1,20242,6,933,1,23007)

	-- Fel Leather Boots -- 32493
	AddRecipe(32493,350,25686,3,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,32493,1,2,4,36,41,51,57,105)
	self:addTradeAcquire(RecipeDB,32493,6,933,2,20242,6,933,2,23007)

	-- Fel Leather Leggings -- 32494
	AddRecipe(32494,350,25687,3,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,32494,1,2,4,36,41,51,57,105)
	self:addTradeAcquire(RecipeDB,32494,6,933,3,20242,6,933,3,23007)

	-- Heavy Clefthoof Vest -- 32495
	AddRecipe(32495,360,25689,3,1,360,370,380,390)
	self:addTradeFlags(RecipeDB,32495,1,2,4,36,41,52,57,103)
	self:addTradeAcquire(RecipeDB,32495,6,942,2,17904)

	-- Heavy Clefthoof Leggings -- 32496
	AddRecipe(32496,355,25690,3,1,355,365,37,385)
	self:addTradeFlags(RecipeDB,32496,1,2,4,36,41,52,57,103)
	self:addTradeAcquire(RecipeDB,32496,6,942,2,17904)

	-- Heavy Clefthoof Boots -- 32497
	AddRecipe(32497,355,25691,3,1,355,365,375,385)
	self:addTradeFlags(RecipeDB,32497,1,2,4,36,41,52,57,103)
	self:addTradeAcquire(RecipeDB,32497,6,942,1,17904)

	-- Felstalker Belt -- 32498
	AddRecipe(32498,350,25695,3,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,32498,1,4,36,41,51,58,104)
	self:addTradeAcquire(RecipeDB,32498,6,946,1,17657,6,947,1,17585)

	-- Felstalker Bracers -- 32499
	AddRecipe(32499,360,25697,3,1,360,370,380,390)
	self:addTradeFlags(RecipeDB,32499,1,4,36,41,51,58,104)
	self:addTradeAcquire(RecipeDB,32499,6,946,2,17657,6,947,2,17585)

	-- Felstalker Breastplate -- 32500
	AddRecipe(32500,360,25696,3,1,360,370,380,390)
	self:addTradeFlags(RecipeDB,32500,1,4,36,41,51,58,104)
	self:addTradeAcquire(RecipeDB,32500,6,946,2,17657,6,947,2,17585)

	-- Netherfury Belt -- 32501
	AddRecipe(32501,340,25694,3,1,340,350,360,370)
	self:addTradeFlags(RecipeDB,32501,1,4,36,41,53,54,58,108)
	self:addTradeAcquire(RecipeDB,32501,6,978,1,20240)

	-- Netherfury Leggings -- 32502
	AddRecipe(32502,340,25692,3,1,340,350,360,370)
	self:addTradeFlags(RecipeDB,32502,1,4,36,41,53,54,58,108)
	self:addTradeAcquire(RecipeDB,32502,6,978,2,20240)

	-- Netherfury Boots -- 32503
	AddRecipe(32503,350,25693,3,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,32503,1,4,36,41,53,54,58,108)
	self:addTradeAcquire(RecipeDB,32503,6,978,3,20240)

	-- Shadow Armor Kit -- 35520
	AddRecipe(35520,340,29483,2,1,340,350,355,360)
	self:addTradeFlags(RecipeDB,35520,1,2,5,11,36,41)
	self:addTradeAcquire(RecipeDB,35520,3,18320)

	-- Flame Armor Kit -- 35521
	AddRecipe(35521,340,29485,2,1,340,350,355,360)
	self:addTradeFlags(RecipeDB,35521,1,2,5,36,41)
	self:addTradeAcquire(RecipeDB,35521,3,20898)

	-- Frost Armor Kit -- 35522
	AddRecipe(35522,340,29486,2,1,340,350,355,360)
	self:addTradeFlags(RecipeDB,35522,1,2,5,36,41)
	self:addTradeAcquire(RecipeDB,35522,3,17797)

	-- Nature Armor Kit -- 35523
	AddRecipe(35523,340,29487,2,1,340,350,355,360)
	self:addTradeFlags(RecipeDB,35523,1,2,5,36,41)
	self:addTradeAcquire(RecipeDB,35523,3,17941)

	-- Arcane Armor Kit -- 35524
	AddRecipe(35524,340,29488,2,1,340,350,355,360)
	self:addTradeFlags(RecipeDB,35524,1,2,5,36,41)
	self:addTradeAcquire(RecipeDB,35524,3,17879)

	-- Enchanted Felscale Leggings -- 35525
	AddRecipe(35525,350,29489,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,35525,1,2,4,36,41,51,58,110)
	self:addTradeAcquire(RecipeDB,35525,6,934,4,19331)

	-- Enchanted Felscale Gloves -- 35526
	AddRecipe(35526,350,29490,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,35526,1,2,4,36,41,51,58,110)
	self:addTradeAcquire(RecipeDB,35526,6,934,2,19331)

	-- Enchanted Felscale Boots -- 35527
	AddRecipe(35527,350,29491,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,35527,1,2,4,36,41,51,58,110)
	self:addTradeAcquire(RecipeDB,35527,6,934,3,19331)

	-- Flamescale Boots -- 35528
	AddRecipe(35528,350,29493,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,35528,1,4,36,41,51,58,101)
	self:addTradeAcquire(RecipeDB,35528,6,932,3,19321)

	-- Flamescale Leggings -- 35529
	AddRecipe(35529,350,29492,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,35529,1,4,36,41,51,58,101)
	self:addTradeAcquire(RecipeDB,35529,6,932,4,19321)

	-- Reinforced Mining Bag -- 35530
	AddRecipe(35530,325,29540,1,1,325,335,340,345)
	self:addTradeFlags(RecipeDB,35530,1,4,36,41,108)
	self:addTradeAcquire(RecipeDB,35530,6,978,2,20240)

	-- Flamescale Belt -- 35531
	AddRecipe(35531,350,29494,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,35531,1,4,36,41,51,58,101)
	self:addTradeAcquire(RecipeDB,35531,6,932,2,19321)

	-- Enchanted Clefthoof Leggings -- 35532
	AddRecipe(35532,350,29495,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,35532,1,2,4,36,41,51,57,110)
	self:addTradeAcquire(RecipeDB,35532,6,934,4,19331)

	-- Enchanted Clefthoof Gloves -- 35533
	AddRecipe(35533,350,29496,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,35533,1,2,4,36,41,51,57,110)
	self:addTradeAcquire(RecipeDB,35533,6,934,3,19331)

	-- Enchanted Clefthoof Boots -- 35534
	AddRecipe(35534,350,29497,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,35534,1,2,4,36,41,51,57,110)
	self:addTradeAcquire(RecipeDB,35534,6,934,2,19331)

	-- Blastguard Pants -- 35535
	AddRecipe(35535,350,29498,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,35535,1,4,36,41,51,57,101)
	self:addTradeAcquire(RecipeDB,35535,6,932,4,19321)

	-- Blastguard Boots -- 35536
	AddRecipe(35536,350,29499,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,35536,1,4,36,41,51,57,101)
	self:addTradeAcquire(RecipeDB,35536,6,932,3,19321)

	-- Blastguard Belt -- 35537
	AddRecipe(35537,350,29500,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,35537,1,4,36,41,51,57,101)
	self:addTradeAcquire(RecipeDB,35537,6,932,2,19321)

	-- Drums of Panic -- 35538
	AddRecipe(35538,370,29532,1,1,370,370,377,385)
	self:addTradeFlags(RecipeDB,35538,1,2,4,36,41,106)
	self:addTradeAcquire(RecipeDB,35538,6,989,2,21643)

	-- Drums of Restoration -- 35539
	AddRecipe(35539,350,29531,1,1,350,350,357,365)
	self:addTradeFlags(RecipeDB,35539,1,4,36,41,108)
	self:addTradeAcquire(RecipeDB,35539,6,978,2,20240)

	-- Drums of War -- 35540
	AddRecipe(35540,340,29528,1,1,340,340,347,355)
	self:addTradeFlags(RecipeDB,35540,1,2,3,36,41,53,54)
	self:addTradeAcquire(RecipeDB,35540,1,18754,1,18771,1,19187,1,21087,1,33681,1,33612,1,
33635)

	-- Drums of Battle -- 35543
	AddRecipe(35543,365,29529,1,1,365,365,372,380)
	self:addTradeFlags(RecipeDB,35543,1,2,4,36,41,111, F_DPS)
	self:addTradeAcquire(RecipeDB,35543,6,935,2,21432)

	-- Drums of Speed -- 35544
	AddRecipe(35544,345,29530,1,1,345,345,352,360)
	self:addTradeFlags(RecipeDB,35544,1,2,4,5,36,41,108)
	self:addTradeAcquire(RecipeDB,35544,6,941,2,20241,6,978,2,20240)

	-- Cobrahide Leg Armor -- 35549
	AddRecipe(35549,335,29533,1,1,335,335,345,355)
	self:addTradeFlags(RecipeDB,35549,1,2,4,36,41,51,104)
	self:addTradeAcquire(RecipeDB,35549,6,946,2,17657,6,947,2,17585)

	-- Nethercobra Leg Armor -- 35554
	AddRecipe(35554,365,29535,1,1,365,365,375,385)
	self:addTradeFlags(RecipeDB,35554,1,2,4,36,41,51,104)
	self:addTradeAcquire(RecipeDB,35554,6,946,4,17657,6,947,4,17585)

	-- Clefthide Leg Armor -- 35555
	AddRecipe(35555,335,29534,1,1,335,335,345,355)
	self:addTradeFlags(RecipeDB,35555,1,2,4,36,41,51,52,103)
	self:addTradeAcquire(RecipeDB,35555,6,942,2,17904)

	-- Nethercleft Leg Armor -- 35557
	AddRecipe(35557,365,29536,1,1,365,365,375,385)
	self:addTradeFlags(RecipeDB,35557,1,2,4,36,41,51,52,103)
	self:addTradeAcquire(RecipeDB,35557,6,942,4,17904)

	-- Cobrascale Hood -- 35558
	AddRecipe(35558,365,29502,4,1,365,375,385,395)
	self:addTradeFlags(RecipeDB,35558,1,2,10,36,40,51,57)
	self:addTradeAcquire(RecipeDB,35558,7,4)

	-- Cobrascale Gloves -- 35559
	AddRecipe(35559,365,29503,4,1,365,375,385,395)
	self:addTradeFlags(RecipeDB,35559,1,2,10,36,41,51,57)
	self:addTradeAcquire(RecipeDB,35559,3,24664,7,4)

	-- Windscale Hood -- 35560
	AddRecipe(35560,365,29504,4,1,365,375,385,395)
	self:addTradeFlags(RecipeDB,35560,1,2,10,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,35560,7,4)

	-- Hood of Primal Life -- 35561
	AddRecipe(35561,365,29505,4,1,365,375,385,395)
	self:addTradeFlags(RecipeDB,35561,1,2,10,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,35561,7,4)

	-- Gloves of the Living Touch -- 35562
	AddRecipe(35562,365,29506,4,1,365,375,385,395)
	self:addTradeFlags(RecipeDB,35562,1,2,11,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,35562,3,24664)

	-- Windslayer Wraps -- 35563
	AddRecipe(35563,365,29507,4,1,365,375,385,395)
	self:addTradeFlags(RecipeDB,35563,1,2,5,6,11,36,40,51,57)
	self:addTradeAcquire(RecipeDB,35563,7,4)

	-- Living Dragonscale Helm -- 35564
	AddRecipe(35564,365,29508,4,1,365,375,385,395)
	self:addTradeFlags(RecipeDB,35564,1,2,5,6,11,36,40,53,54,58)
	self:addTradeAcquire(RecipeDB,35564,7,4)

	-- Earthen Netherscale Boots -- 35567
	AddRecipe(35567,365,29512,4,1,365,375,385,395)
	self:addTradeFlags(RecipeDB,35567,1,2,6,11,36,40,51,58)
	self:addTradeAcquire(RecipeDB,35567,7,4)

	-- Windstrike Gloves -- 35568
	AddRecipe(35568,365,29509,4,1,365,375,385,395)
	self:addTradeFlags(RecipeDB,35568,1,2,11,36,41,51,58)
	self:addTradeAcquire(RecipeDB,35568,3,24664)

	-- Netherdrake Helm -- 35572
	AddRecipe(35572,365,29510,4,1,365,375,385,395)
	self:addTradeFlags(RecipeDB,35572,1,2,10,36,40,51,58)
	self:addTradeAcquire(RecipeDB,35572,7,4)

	-- Netherdrake Gloves -- 35573
	AddRecipe(35573,365,29511,4,1,365,375,385,395)
	self:addTradeFlags(RecipeDB,35573,1,2,11,36,41,51,58)
	self:addTradeAcquire(RecipeDB,35573,3,24664)

	-- Thick Netherscale Breastplate -- 35574
	AddRecipe(35574,365,29514,4,1,365,375,385,395)
	self:addTradeFlags(RecipeDB,35574,1,2,5,6,11,36,40,51,58)
	self:addTradeAcquire(RecipeDB,35574,7,4)

	-- Ebon Netherscale Breastplate -- 35575
	AddRecipe(35575,375,29515,1,1,375,385,395,405,10657)
	self:addTradeFlags(RecipeDB,35575,1,2,3,37,41,51,58)
	self:addTradeAcquire(RecipeDB,35575,1,7866,1,7867,1,29508)

	-- Ebon Netherscale Belt -- 35576
	AddRecipe(35576,375,29516,1,1,375,385,395,405,10657)
	self:addTradeFlags(RecipeDB,35576,1,2,3,37,41,51,58)
	self:addTradeAcquire(RecipeDB,35576,1,7866,1,7867,1,29508)

	-- Ebon Netherscale Bracers -- 35577
	AddRecipe(35577,375,29517,1,1,375,385,395,405,10657)
	self:addTradeFlags(RecipeDB,35577,1,2,3,37,41,51,58)
	self:addTradeAcquire(RecipeDB,35577,1,7866,1,7867,1,29508)

	-- Netherstrike Breastplate -- 35580
	AddRecipe(35580,375,29519,1,1,375,385,395,405,10657)
	self:addTradeFlags(RecipeDB,35580,1,2,3,37,41,53,54,58)
	self:addTradeAcquire(RecipeDB,35580,1,7866,1,7867,1,29508)

	-- Netherstrike Belt -- 35582
	AddRecipe(35582,375,29520,1,1,375,385,395,405,10657)
	self:addTradeFlags(RecipeDB,35582,1,2,3,37,41,53,54,58)
	self:addTradeAcquire(RecipeDB,35582,1,7866,1,7867,1,29508)

	-- Netherstrike Bracers -- 35584
	AddRecipe(35584,375,29521,1,1,375,385,395,405,10657)
	self:addTradeFlags(RecipeDB,35584,1,2,3,37,41,53,54,58)
	self:addTradeAcquire(RecipeDB,35584,1,7866,1,7867,1,29508)

	-- Windhawk Hauberk -- 35585
	AddRecipe(35585,375,29522,1,1,375,385,395,405,10661)
	self:addTradeFlags(RecipeDB,35585,1,2,3,37,41,53,54,57)
	self:addTradeAcquire(RecipeDB,35585,1,7870,1,7871,1,29509)

	-- Windhawk Belt -- 35587
	AddRecipe(35587,375,29524,1,1,375,385,395,405,10661)
	self:addTradeFlags(RecipeDB,35587,1,2,3,37,41,53,54,57)
	self:addTradeAcquire(RecipeDB,35587,1,7870,1,7871,1,29509)

	-- Windhawk Bracers -- 35588
	AddRecipe(35588,375,29523,1,1,375,385,395,405,10661)
	self:addTradeFlags(RecipeDB,35588,1,2,3,37,41,53,54,57)
	self:addTradeAcquire(RecipeDB,35588,1,7870,1,7871,1,29509)

	-- Primalstrike Vest -- 35589
	AddRecipe(35589,375,29525,1,1,375,385,395,405,10659)
	self:addTradeFlags(RecipeDB,35589,1,2,3,37,41,51,57)
	self:addTradeAcquire(RecipeDB,35589,1,7868,1,7869,1,29507)

	-- Primalstrike Belt -- 35590
	AddRecipe(35590,375,29526,1,1,375,385,395,405,10659)
	self:addTradeFlags(RecipeDB,35590,1,2,3,37,41,51,57)
	self:addTradeAcquire(RecipeDB,35590,1,7868,1,7869,1,29507)

	-- Primalstrike Bracers -- 35591
	AddRecipe(35591,375,29527,1,1,375,385,395,405,10659)
	self:addTradeFlags(RecipeDB,35591,1,2,3,37,41,51,57)
	self:addTradeAcquire(RecipeDB,35591,1,7868,1,7869,1,29507)

	-- Blackstorm Leggings -- 36074
	AddRecipe(36074,260,29964,1,1,260,280,290,300,10659)
	self:addTradeFlags(RecipeDB,36074,1,2,3,37,41,51,57)
	self:addTradeAcquire(RecipeDB,36074,1,7868,1,7869,1,29507)

	-- Wildfeather Leggings -- 36075
	AddRecipe(36075,260,29970,1,2108,10661,1,260,280,290,300)
	self:addTradeFlags(RecipeDB,36075,1,2,3,37,41,53,54,57)
	self:addTradeAcquire(RecipeDB,36075,1,7870,1,7871,1,29509)

	-- Dragonstrike Leggings -- 36076
	AddRecipe(36076,260,29971,1,1,260,280,290,300,10657)
	self:addTradeFlags(RecipeDB,36076,1,2,3,37,41,51,58)
	self:addTradeAcquire(RecipeDB,36076,1,7866,1,7867,1,29508)

	-- Primalstorm Breastplate -- 36077
	AddRecipe(36077,330,29973,1,1,330,350,360,370,10659)
	self:addTradeFlags(RecipeDB,36077,1,2,3,37,41,51,57)
	self:addTradeAcquire(RecipeDB,36077,1,7868,1,7869,1,29507)

	-- Living Crystal Breastplate -- 36078
	AddRecipe(36078,330,29974,1,1,330,350,360,370,10661)
	self:addTradeFlags(RecipeDB,36078,1,2,3,37,41,53,54,57)
	self:addTradeAcquire(RecipeDB,36078,1,7870,1,7871,1,29509)

	-- Golden Dragonstrike Breastplate -- 36079
	AddRecipe(36079,330,29975,1,1,330,350,360,370,10657)
	self:addTradeFlags(RecipeDB,36079,1,2,3,37,41,51,58)
	self:addTradeAcquire(RecipeDB,36079,1,7866,1,7867,1,29508)

	-- Belt of Natural Power -- 36349
	AddRecipe(36349,375,30042,4,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,36349,1,2,6,36,41,51,57)
	self:addTradeAcquire(RecipeDB,36349,8,37,8,43)

	-- Belt of Deep Shadow -- 36351
	AddRecipe(36351,375,30040,4,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,36351,1,2,6,36,41,51,57)
	self:addTradeAcquire(RecipeDB,36351,8,37,8,43)

	-- Belt of the Black Eagle -- 36352
	AddRecipe(36352,375,30046,4,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,36352,1,2,6,36,41,51,58)
	self:addTradeAcquire(RecipeDB,36352,8,37,8,43)

	-- Monsoon Belt -- 36353
	AddRecipe(36353,375,30044,4,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,36353,1,2,6,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,36353,8,37,8,43)

	-- Boots of Natural Grace -- 36355
	AddRecipe(36355,375,30041,4,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,36355,1,2,6,37,41,51,57)
	self:addTradeAcquire(RecipeDB,36355,8,37,8,43)

	-- Boots of Utter Darkness -- 36357
	AddRecipe(36357,375,30039,4,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,36357,1,2,6,37,41,51,57)
	self:addTradeAcquire(RecipeDB,36357,8,37,8,43)

	-- Boots of the Crimson Hawk -- 36358
	AddRecipe(36358,375,30045,4,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,36358,1,2,6,37,41,51,58)
	self:addTradeAcquire(RecipeDB,36358,8,37,8,43)

	-- Hurricane Boots -- 36359
	AddRecipe(36359,375,30043,4,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,36359,1,2,6,37,41,53,54,58)
	self:addTradeAcquire(RecipeDB,36359,8,37,8,43)

	-- Boots of Shackled Souls -- 39997
	AddRecipe(39997,375,32398,1,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,39997,1,2,4,36,41,58,102)
	self:addTradeAcquire(RecipeDB,39997,6,1012,1,23159)

	-- Greaves of Shackled Souls -- 40001
	AddRecipe(40001,375,32400,1,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,40001,1,2,4,36,41,58,102)
	self:addTradeAcquire(RecipeDB,40001,6,1012,2,23159)

	-- Waistguard of Shackled Souls -- 40002
	AddRecipe(40002,375,32397,1,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,40002,1,2,4,36,41,58,102)
	self:addTradeAcquire(RecipeDB,40002,6,1012,2,23159)

	-- Redeemed Soul Moccasins -- 40003
	AddRecipe(40003,375,32394,1,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,40003,1,2,4,36,41,57,102)
	self:addTradeAcquire(RecipeDB,40003,6,1012,2,23159)

	-- Redeemed Soul Wristguards -- 40004
	AddRecipe(40004,375,32395,1,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,40004,1,2,4,36,41,57,102)
	self:addTradeAcquire(RecipeDB,40004,6,1012,2,23159)

	-- Redeemed Soul Legguards -- 40005
	AddRecipe(40005,375,32396,1,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,40005,1,2,4,36,41,57,102)
	self:addTradeAcquire(RecipeDB,40005,6,1012,1,23159)

	-- Redeemed Soul Cinch -- 40006
	AddRecipe(40006,375,32393,1,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,40006,1,2,4,36,41,57,102)
	self:addTradeAcquire(RecipeDB,40006,6,1012,1,23159)

	-- Bracers of Renewed Life -- 41156
	AddRecipe(41156,375,32582,4,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,41156,1,2,10,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,41156,7,4)

	-- Shoulderpads of Renewed Life -- 41157
	AddRecipe(41157,375,32583,4,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,41157,1,2,6,37,40,53,54,57)
	self:addTradeAcquire(RecipeDB,41157,8,27,8,34)

	-- Swiftstrike Bracers -- 41158
	AddRecipe(41158,375,32580,4,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,41158,1,2,6,36,40,51,57)
	self:addTradeAcquire(RecipeDB,41158,8,27,8,34)

	-- Swiftstrike Shoulders -- 41160
	AddRecipe(41160,375,32581,4,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,41160,1,2,10,37,40,51,57)
	self:addTradeAcquire(RecipeDB,41160,7,4)

	-- Bindings of Lightning Reflexes -- 41161
	AddRecipe(41161,375,32574,4,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,41161,1,2,6,36,40,51,58)
	self:addTradeAcquire(RecipeDB,41161,8,27,8,34)

	-- Shoulders of Lightning Reflexes -- 41162
	AddRecipe(41162,375,32575,4,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,41162,1,2,10,37,40,51,58)
	self:addTradeAcquire(RecipeDB,41162,7,4)

	-- Living Earth Bindings -- 41163
	AddRecipe(41163,375,32577,4,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,41163,1,2,10,36,40,53,54,58)
	self:addTradeAcquire(RecipeDB,41163,7,4)

	-- Living Earth Shoulders -- 41164
	AddRecipe(41164,375,32579,4,1,375,385,395,405)
	self:addTradeFlags(RecipeDB,41164,1,2,6,37,40,53,54,58)
	self:addTradeAcquire(RecipeDB,41164,8,27,8,34)

	-- Cloak of Darkness -- 42546
	AddRecipe(42546,360,33122,3,1,360,370,380,390)
	self:addTradeFlags(RecipeDB,42546,1,2,4,36,41,51,60,114)
	self:addTradeAcquire(RecipeDB,42546,6,967,4,18255)

	-- Shadowprowler's Chestguard -- 42731
	AddRecipe(42731,365,33204,4,1,365,375,385,395)
	self:addTradeFlags(RecipeDB,42731,1,2,4,36,41,51,57,114)
	self:addTradeAcquire(RecipeDB,42731,6,967,3,18255)

	-- Knothide Ammo Pouch -- 44343
	AddRecipe(44343,315,34099,2,1,315,325,335,345)
	self:addTradeFlags(RecipeDB,44343,1,2,3,36,41,78)
	self:addTradeAcquire(RecipeDB,44343,1,18754,1,18771,1,19187,1,21087,1,33681,1,33612,1,
33635)

	-- Knothide Quiver -- 44344
	AddRecipe(44344,315,34100,2,1,315,325,335,345)
	self:addTradeFlags(RecipeDB,44344,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,44344,1,18754,1,18771,1,19187,1,21087,1,33681,1,33612,1,
33635)

	-- Quiver of a Thousand Feathers -- 44359
	AddRecipe(44359,350,34105,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,44359,1,2,4,36,41,107)
	self:addTradeAcquire(RecipeDB,44359,6,1011,3,21655)

	-- Netherscale Ammo Pouch -- 44768
	AddRecipe(44768,350,34106,1,1,350,360,370,380)
	self:addTradeFlags(RecipeDB,44768,1,2,4,36,41,78,104)
	self:addTradeAcquire(RecipeDB,44768,6,947,3,17585,6,946,3,17657)

	-- Glove Reinforcements -- 44770
	AddRecipe(44770,350,34207,2,1,350,355,360,365)
	self:addTradeFlags(RecipeDB,44770,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,44770,1,18754,1,18771,1,19187,1,21087,1,33681,1,33612,1,
33635)

	-- Winter Boots -- 44953
	AddRecipe(44953,285,34086,2,1,285,285,285,285)
	self:addTradeFlags(RecipeDB,44953,1,2,4,7,36,41,56)
	self:addTradeAcquire(RecipeDB,44953,5,1,2,13420,2,13433)

	-- Heavy Knothide Armor Kit -- 44970
	AddRecipe(44970,350,34330,1,1,350,355,360,365)
	self:addTradeFlags(RecipeDB,44970,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,44970,1,18754,1,18771,1,19187,1,21087,1,33681,1,33612,1,
33635)

	-- Leatherworker's Satchel -- 45100
	AddRecipe(45100,300,34482,2,1,300,310,320,330)
	self:addTradeFlags(RecipeDB,45100,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,45100,1,18754,1,18771,1,19187,1,21087,1,33681,1,33612,1,
33635)

	-- Bag of Many Hides -- 45117
	AddRecipe(45117,360,34490,2,1,360,370,380,390)
	self:addTradeFlags(RecipeDB,45117,1,2,11,36,41)
	self:addTradeAcquire(RecipeDB,45117,3,22143,3,22144,3,22148,3,23022)

	-- Leather Gauntlets of the Sun -- 46132
	AddRecipe(46132,365,34372,4,1,365,375,392,410)
	self:addTradeFlags(RecipeDB,46132,1,2,6,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,46132,8,24)

	-- Fletcher's Gloves of the Phoenix -- 46133
	AddRecipe(46133,365,34374,4,1,365,375,392,410)
	self:addTradeFlags(RecipeDB,46133,1,2,6,36,40,51,58)
	self:addTradeAcquire(RecipeDB,46133,8,24)

	-- Gloves of Immortal Dusk -- 46134
	AddRecipe(46134,365,34370,4,1,365,375,392,410)
	self:addTradeFlags(RecipeDB,46134,1,2,6,36,41,51,57)
	self:addTradeAcquire(RecipeDB,46134,8,24)

	-- Sun-Drenched Scale Gloves -- 46135
	AddRecipe(46135,365,34376,4,1,365,375,392,410)
	self:addTradeFlags(RecipeDB,46135,1,2,6,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,46135,8,24)

	-- Leather Chestguard of the Sun -- 46136
	AddRecipe(46136,365,34371,4,1,365,375,392,410)
	self:addTradeFlags(RecipeDB,46136,1,2,6,37,40,53,54,57)
	self:addTradeAcquire(RecipeDB,46136,8,24)

	-- Embrace of the Phoenix -- 46137
	AddRecipe(46137,365,34373,4,1,365,375,392,410)
	self:addTradeFlags(RecipeDB,46137,1,2,6,37,40,51,58)
	self:addTradeAcquire(RecipeDB,46137,8,24)

	-- Carapace of Sun and Shadow -- 46138
	AddRecipe(46138,365,34369,4,1,365,375,392,410)
	self:addTradeFlags(RecipeDB,46138,1,2,6,37,40,51,57)
	self:addTradeAcquire(RecipeDB,46138,8,24)

	-- Sun-Drenched Scale Chestguard -- 46139
	AddRecipe(46139,365,34375,4,1,365,375,392,410)
	self:addTradeFlags(RecipeDB,46139,1,2,6,37,40,53,54,58)
	self:addTradeAcquire(RecipeDB,46139,8,24)

	-- Heavy Borean Leather -- 50936
	AddRecipe(50936,390,38425,1,2,390,390,395,405)
	self:addTradeFlags(RecipeDB,50936,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,50936,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Iceborne Chestguard -- 50938
	AddRecipe(50938,375,38408,1,2,375,390,400,410)
	self:addTradeFlags(RecipeDB,50938,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,50938,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Iceborne Leggings -- 50939
	AddRecipe(50939,370,38410,1,2,370,385,395,405)
	self:addTradeFlags(RecipeDB,50939,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,50939,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Iceborne Shoulderpads -- 50940
	AddRecipe(50940,380,38411,1,2,380,395,405,415)
	self:addTradeFlags(RecipeDB,50940,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,50940,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Iceborne Gloves -- 50941
	AddRecipe(50941,370,38409,1,2,370,385,395,405)
	self:addTradeFlags(RecipeDB,50941,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,50941,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Iceborne Boots -- 50942
	AddRecipe(50942,375,38407,1,2,375,390,400,410)
	self:addTradeFlags(RecipeDB,50942,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,50942,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Iceborne Belt -- 50943
	AddRecipe(50943,380,38406,1,2,380,380,387,395)
	self:addTradeFlags(RecipeDB,50943,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,50943,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Arctic Chestpiece -- 50944
	AddRecipe(50944,370,38400,2,2,370,385,395,405)
	self:addTradeFlags(RecipeDB,50944,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,50944,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Arctic Leggings -- 50945
	AddRecipe(50945,375,38401,2,2,375,390,400,410)
	self:addTradeFlags(RecipeDB,50945,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,50945,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Arctic Shoulderpads -- 50946
	AddRecipe(50946,380,38402,2,2,380,395,405,415)
	self:addTradeFlags(RecipeDB,50946,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,50946,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Arctic Gloves -- 50947
	AddRecipe(50947,375,38403,2,2,375,390,400,410)
	self:addTradeFlags(RecipeDB,50947,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,50947,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Arctic Boots -- 50948
	AddRecipe(50948,370,38404,2,2,370,385,395,405)
	self:addTradeFlags(RecipeDB,50948,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,50948,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Arctic Belt -- 50949
	AddRecipe(50949,380,38405,2,2,380,395,405,415)
	self:addTradeFlags(RecipeDB,50949,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,50949,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Frostscale Chestguard -- 50950
	AddRecipe(50950,375,38414,1,2,375,390,400,410)
	self:addTradeFlags(RecipeDB,50950,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,50950,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Frostscale Leggings -- 50951
	AddRecipe(50951,370,38416,1,2,370,385,395,405)
	self:addTradeFlags(RecipeDB,50951,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,50951,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Frostscale Shoulders -- 50952
	AddRecipe(50952,375,38424,1,2,375,390,400,410)
	self:addTradeFlags(RecipeDB,50952,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,50952,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Frostscale Gloves -- 50953
	AddRecipe(50953,380,38415,1,2,380,395,405,415)
	self:addTradeFlags(RecipeDB,50953,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,50953,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Frostscale Boots -- 50954
	AddRecipe(50954,380,38413,1,2,380,395,405,415)
	self:addTradeFlags(RecipeDB,50954,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,50954,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Frostscale Belt -- 50955
	AddRecipe(50955,370,38412,1,2,370,385,395,405)
	self:addTradeFlags(RecipeDB,50955,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,50955,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Nerubian Chestguard -- 50956
	AddRecipe(50956,375,38420,1,2,375,390,400,410)
	self:addTradeFlags(RecipeDB,50956,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,50956,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Nerubian Legguards -- 50957
	AddRecipe(50957,370,38422,2,2,370,385,395,405)
	self:addTradeFlags(RecipeDB,50957,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,50957,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Nerubian Shoulders -- 50958
	AddRecipe(50958,380,38417,1,2,380,395,405,415)
	self:addTradeFlags(RecipeDB,50958,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,50958,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Nerubian Gloves -- 50959
	AddRecipe(50959,370,38421,1,2,370,385,395,405)
	self:addTradeFlags(RecipeDB,50959,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,50959,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Nerubian Boots -- 50960
	AddRecipe(50960,380,38419,1,2,380,395,405,415)
	self:addTradeFlags(RecipeDB,50960,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,50960,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Nerubian Belt -- 50961
	AddRecipe(50961,375,38418,1,2,375,390,400,410)
	self:addTradeFlags(RecipeDB,50961,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,50961,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Borean Armor Kit -- 50962
	AddRecipe(50962,350,38375,1,2,350,375,380,385)
	self:addTradeFlags(RecipeDB,50962,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,50962,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Heavy Borean Armor Kit -- 50963
	AddRecipe(50963,395,38376,2,2,395,400,402,405)
	self:addTradeFlags(RecipeDB,50963,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,50963,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Jormungar Leg Armor -- 50964
	AddRecipe(50964,405,38371,1,2,405,410,415,420)
	self:addTradeFlags(RecipeDB,50964,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,50964,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Frosthide Leg Armor -- 50965
	AddRecipe(50965,425,38373,4,2,425,435,440,445)
	self:addTradeFlags(RecipeDB,50965,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,50965,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Nerubian Leg Armor -- 50966
	AddRecipe(50966,400,38372,1,2,400,405,410,415)
	self:addTradeFlags(RecipeDB,50966,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,50966,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Icescale Leg Armor -- 50967
	AddRecipe(50967,425,38374,4,2,425,435,440,445)
	self:addTradeFlags(RecipeDB,50967,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,50967,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Trapper's Traveling Pack -- 50970
	AddRecipe(50970,415,38399,3,2,415,420,422,425)
	self:addTradeFlags(RecipeDB,50970,1,2,4,36,41,120)
	self:addTradeAcquire(RecipeDB,50970,6,1073,3,31916,6,1073,3,32763)

	-- Mammoth Mining Bag -- 50971
	AddRecipe(50971,415,38347,3,2,415,420,422,425)
	self:addTradeFlags(RecipeDB,50971,1,2,4,36,41,119)
	self:addTradeAcquire(RecipeDB,50971,6,1119,2,32540)

	-- Black Chitinguard Boots -- 51568
	AddRecipe(51568,400,38590,1,2,400,415,425,435)
	self:addTradeFlags(RecipeDB,51568,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,51568,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Dark Arctic Leggings -- 51569
	AddRecipe(51569,395,38591,1,2,395,410,420,430)
	self:addTradeFlags(RecipeDB,51569,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,51569,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Dark Arctic Chestpiece -- 51570
	AddRecipe(51570,395,38592,1,2,395,410,420,430)
	self:addTradeFlags(RecipeDB,51570,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,51570,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Arctic Wristguards -- 51571
	AddRecipe(51571,385,38433,1,2,385,400,410,420)
	self:addTradeFlags(RecipeDB,51571,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,51571,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Arctic Helm -- 51572
	AddRecipe(51572,385,38437,1,2,385,400,410,420)
	self:addTradeFlags(RecipeDB,51572,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,51572,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Bracers of Shackled Souls -- 52733
	AddRecipe(52733,375,32399,1,2,375,385,395,405)
	self:addTradeFlags(RecipeDB,52733,1,2,4,36,41,58,102)
	self:addTradeAcquire(RecipeDB,52733,6,1012,1,23159)

	-- Cloak of Tormented Skies -- 55199
	AddRecipe(55199,395,41238,1,2,395,405,415,425)
	self:addTradeFlags(RecipeDB,55199,1,2,3,36,41,52,60)
	self:addTradeAcquire(RecipeDB,55199,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Fur Lining - Attack Power -- 57683
	AddRecipe(57683,400,nil,1,2,400,425,430,435)
	self:addTradeFlags(RecipeDB,57683,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,57683,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Fur Lining - Stamina -- 57690
	AddRecipe(57690,400,nil,1,2,400,425,430,435)
	self:addTradeFlags(RecipeDB,57690,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,57690,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Fur Lining - Spell Power -- 57691
	AddRecipe(57691,400,nil,1,2,400,425,430,435)
	self:addTradeFlags(RecipeDB,57691,1,2,3,36,41,53,54)
	self:addTradeAcquire(RecipeDB,57691,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Fur Lining - Fire Resist -- 57692
	AddRecipe(57692,400,nil,3,2,400,425,430,435)
	self:addTradeFlags(RecipeDB,57692,1,2,11,36,41)
	self:addTradeAcquire(RecipeDB,57692,3,30921)

	-- Fur Lining - Frost Resist -- 57694
	AddRecipe(57694,400,nil,3,2,400,425,430,435)
	self:addTradeFlags(RecipeDB,57694,1,2,11,36,41)
	self:addTradeAcquire(RecipeDB,57694,3,32289)

	-- Fur Lining - Shadow Resist -- 57696
	AddRecipe(57696,400,nil,3,2,400,425,430,435)
	self:addTradeFlags(RecipeDB,57696,1,2,11,36,41)
	self:addTradeAcquire(RecipeDB,57696,3,32349)

	-- Fur Lining - Nature Resist -- 57699
	AddRecipe(57699,400,nil,3,2,400,425,430,435)
	self:addTradeFlags(RecipeDB,57699,1,2,11,36,41)
	self:addTradeAcquire(RecipeDB,57699,3,32290)

	-- Fur Lining - Arcane Resist -- 57701
	AddRecipe(57701,400,nil,3,2,400,425,430,435)
	self:addTradeFlags(RecipeDB,57701,1,2,11,36,41)
	self:addTradeAcquire(RecipeDB,57701,3,31702,3,32297)

	-- Jormungar Leg Reinforcements -- 60583
	AddRecipe(60583,405,nil,1,2,405,405,405,410)
	self:addTradeFlags(RecipeDB,60583,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,60583,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Nerubian Leg Reinforcements -- 60584
	AddRecipe(60584,400,nil,1,2,400,400,400,405)
	self:addTradeFlags(RecipeDB,60584,1,2,3,36,41,51)
	self:addTradeAcquire(RecipeDB,60584,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Frostscale Bracers -- 60599
	AddRecipe(60599,385,38436,1,2,385,400,410,420)
	self:addTradeFlags(RecipeDB,60599,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60599,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Frostscale Helm -- 60600
	AddRecipe(60600,385,38440,1,2,385,400,410,420)
	self:addTradeFlags(RecipeDB,60600,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60600,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Dark Frostscale Leggings -- 60601
	AddRecipe(60601,395,44436,1,2,395,410,420,430)
	self:addTradeFlags(RecipeDB,60601,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60601,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Dark Frostscale Breastplate -- 60604
	AddRecipe(60604,395,44437,1,2,395,410,420,430)
	self:addTradeFlags(RecipeDB,60604,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60604,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Dragonstompers -- 60605
	AddRecipe(60605,400,44438,1,2,400,415,425,435)
	self:addTradeFlags(RecipeDB,60605,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60605,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Iceborne Wristguards -- 60607
	AddRecipe(60607,385,38434,1,2,385,400,410,420)
	self:addTradeFlags(RecipeDB,60607,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,60607,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Iceborne Helm -- 60608
	AddRecipe(60608,385,38438,1,2,385,400,410,420)
	self:addTradeFlags(RecipeDB,60608,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,60608,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Dark Iceborne Leggings -- 60611
	AddRecipe(60611,395,44440,1,2,395,410,420,430)
	self:addTradeFlags(RecipeDB,60611,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,60611,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Dark Iceborne Chestguard -- 60613
	AddRecipe(60613,395,44441,1,2,395,410,420,430)
	self:addTradeFlags(RecipeDB,60613,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,60613,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Bugsquashers -- 60620
	AddRecipe(60620,400,44442,1,2,400,415,425,435)
	self:addTradeFlags(RecipeDB,60620,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,60620,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Nerubian Bracers -- 60622
	AddRecipe(60622,385,38435,1,2,385,400,410,420)
	self:addTradeFlags(RecipeDB,60622,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,60622,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Nerubian Helm -- 60624
	AddRecipe(60624,385,38439,1,2,385,400,410,420)
	self:addTradeFlags(RecipeDB,60624,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,60624,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Dark Nerubian Leggings -- 60627
	AddRecipe(60627,395,44443,1,2,395,410,420,430)
	self:addTradeFlags(RecipeDB,60627,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,60627,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Dark Nerubian Chestpiece -- 60629
	AddRecipe(60629,395,44444,1,2,395,410,420,430)
	self:addTradeFlags(RecipeDB,60629,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,60629,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Scaled Icewalkers -- 60630
	AddRecipe(60630,400,44445,1,2,400,415,425,435)
	self:addTradeFlags(RecipeDB,60630,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,60630,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Cloak of Harsh Winds -- 60631
	AddRecipe(60631,380,38441,1,2,380,390,400,410)
	self:addTradeFlags(RecipeDB,60631,1,2,3,36,41,51,60)
	self:addTradeAcquire(RecipeDB,60631,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Ice Striker's Cloak -- 60637
	AddRecipe(60637,440,43566,1,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,60637,1,2,3,36,41,51,60)
	self:addTradeAcquire(RecipeDB,60637,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Durable Nerubhide Cape -- 60640
	AddRecipe(60640,440,43565,1,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,60640,1,2,3,36,41,51,52,60)
	self:addTradeAcquire(RecipeDB,60640,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Pack of Endless Pockets -- 60643
	AddRecipe(60643,415,44446,3,2,415,420,422,425)
	self:addTradeFlags(RecipeDB,60643,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,60643,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Dragonscale Ammo Pouch -- 60645
	AddRecipe(60645,415,44447,3,2,415,420,422,425)
	self:addTradeFlags(RecipeDB,60645,1,2,4,36,41,78,120)
	self:addTradeAcquire(RecipeDB,60645,6,1073,2,31916,6,1073,2,32763)

	-- Nerubian Reinforced Quiver -- 60647
	AddRecipe(60647,415,44448,3,2,415,420,422,425)
	self:addTradeFlags(RecipeDB,60647,1,2,4,36,41,117)
	self:addTradeAcquire(RecipeDB,60647,6,1098,2,32538)

	-- Razorstrike Breastplate -- 60649
	AddRecipe(60649,425,43129,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60649,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60649,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Virulent Spaulders -- 60651
	AddRecipe(60651,420,43130,1,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60651,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60651,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Eaglebane Bracers -- 60652
	AddRecipe(60652,420,43131,1,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60652,1,2,3,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60652,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Nightshock Hood -- 60655
	AddRecipe(60655,425,43132,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60655,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,60655,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Nightshock Girdle -- 60658
	AddRecipe(60658,420,43133,1,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60658,1,2,3,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,60658,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Leggings of Visceral Strikes -- 60660
	AddRecipe(60660,425,42731,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60660,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,60660,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Seafoam Gauntlets -- 60665
	AddRecipe(60665,420,43255,1,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60665,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,60665,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Jormscale Footpads -- 60666
	AddRecipe(60666,420,43256,1,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60666,1,2,3,36,41,51,57)
	self:addTradeAcquire(RecipeDB,60666,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Wildscale Breastplate -- 60669
	AddRecipe(60669,425,43257,1,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60669,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,60669,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Purehorn Spaulders -- 60671
	AddRecipe(60671,420,43258,1,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60671,1,2,3,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,60671,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Eviscerator's Facemask -- 60697
	AddRecipe(60697,420,43260,3,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60697,1,2,4,36,41,51,57)
	self:addTradeAcquire(RecipeDB,60697,2,32515)

	-- Eviscerator's Shoulderpads -- 60702
	AddRecipe(60702,420,43433,3,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60702,1,2,4,36,41,51,57)
	self:addTradeAcquire(RecipeDB,60702,2,32515)

	-- Eviscerator's Chestguard -- 60703
	AddRecipe(60703,420,43434,3,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60703,1,2,4,36,41,51,57)
	self:addTradeAcquire(RecipeDB,60703,2,32515)

	-- Eviscerator's Bindings -- 60704
	AddRecipe(60704,420,43435,3,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60704,1,2,4,36,41,51,57)
	self:addTradeAcquire(RecipeDB,60704,2,32515)

	-- Eviscerator's Gauntlets -- 60705
	AddRecipe(60705,425,43436,3,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60705,1,2,4,36,41,51,57)
	self:addTradeAcquire(RecipeDB,60705,2,32515)

	-- Eviscerator's Waistguard -- 60706
	AddRecipe(60706,425,43437,3,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60706,1,2,4,36,41,51,57)
	self:addTradeAcquire(RecipeDB,60706,2,32515)

	-- Eviscerator's Legguards -- 60711
	AddRecipe(60711,425,43438,3,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60711,1,2,4,36,41,51,57)
	self:addTradeAcquire(RecipeDB,60711,2,32515)

	-- Eviscerator's Treads -- 60712
	AddRecipe(60712,425,43439,3,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60712,1,2,4,36,41,51,57)
	self:addTradeAcquire(RecipeDB,60712,2,32515)

	-- Overcast Headguard -- 60715
	AddRecipe(60715,420,43261,3,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60715,1,2,4,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,60715,2,32515)

	-- Overcast Spaulders -- 60716
	AddRecipe(60716,420,43262,3,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60716,1,2,4,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,60716,2,32515)

	-- Overcast Chestguard -- 60718
	AddRecipe(60718,420,43263,3,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60718,1,2,4,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,60718,2,32515)

	-- Overcast Bracers -- 60720
	AddRecipe(60720,420,43264,3,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60720,1,2,4,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,60720,2,32515)

	-- Overcast Handwraps -- 60721
	AddRecipe(60721,425,43265,3,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60721,1,2,4,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,60721,2,32515)

	-- Overcast Belt -- 60723
	AddRecipe(60723,425,43266,3,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60723,1,2,4,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,60723,2,32515)

	-- Overcast Leggings -- 60725
	AddRecipe(60725,425,43271,3,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60725,1,2,4,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,60725,2,32515)

	-- Overcast Boots -- 60727
	AddRecipe(60727,425,43273,3,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60727,1,2,4,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,60727,2,32515)

	-- Swiftarrow Helm -- 60728
	AddRecipe(60728,420,43447,3,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60728,1,2,4,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60728,2,32515)

	-- Swiftarrow Shoulderguards -- 60729
	AddRecipe(60729,420,43449,3,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60729,1,2,4,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60729,2,32515)

	-- Swiftarrow Hauberk -- 60730
	AddRecipe(60730,420,43445,3,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60730,1,2,4,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60730,2,32515)

	-- Swiftarrow Bracers -- 60731
	AddRecipe(60731,420,43444,3,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60731,1,2,4,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60731,2,32515)

	-- Swiftarrow Gauntlets -- 60732
	AddRecipe(60732,425,43446,3,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60732,1,2,4,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60732,2,32515)

	-- Swiftarrow Belt -- 60734
	AddRecipe(60734,425,43442,3,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60734,1,2,4,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60734,2,32515)

	-- Swiftarrow Leggings -- 60735
	AddRecipe(60735,425,43448,3,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60735,1,2,4,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60735,2,32515)

	-- Swiftarrow Boots -- 60737
	AddRecipe(60737,425,43443,3,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60737,1,2,4,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60737,2,32515)

	-- Stormhide Crown -- 60743
	AddRecipe(60743,420,43455,3,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60743,1,2,4,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,60743,2,32515)

	-- Stormhide Shoulders -- 60746
	AddRecipe(60746,420,43457,3,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60746,1,2,4,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,60746,2,32515)

	-- Stormhide Hauberk -- 60747
	AddRecipe(60747,420,43453,3,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60747,1,2,4,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,60747,2,32515)

	-- Stormhide Wristguards -- 60748
	AddRecipe(60748,420,43452,3,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60748,1,2,4,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,60748,2,32515)

	-- Stormhide Grips -- 60749
	AddRecipe(60749,425,43454,3,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60749,1,2,4,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,60749,2,32515)

	-- Stormhide Belt -- 60750
	AddRecipe(60750,425,43450,3,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60750,1,2,4,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,60750,2,32515)

	-- Stormhide Legguards -- 60751
	AddRecipe(60751,425,43456,3,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60751,1,2,4,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,60751,2,32515)

	-- Stormhide Stompers -- 60752
	AddRecipe(60752,425,43451,3,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60752,1,2,4,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,60752,2,32515)

	-- Giantmaim Legguards -- 60754
	AddRecipe(60754,440,43458,4,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,60754,1,2,4,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60754,2,32515)

	-- Giantmaim Bracers -- 60755
	AddRecipe(60755,440,43459,4,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,60755,1,2,4,36,41,51,58)
	self:addTradeAcquire(RecipeDB,60755,2,32515)

	-- Revenant's Breastplate -- 60756
	AddRecipe(60756,440,43461,4,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,60756,1,2,4,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,60756,2,32515)

	-- Revenant's Treads -- 60757
	AddRecipe(60757,440,43469,4,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,60757,1,2,4,36,41,53,54,58)
	self:addTradeAcquire(RecipeDB,60757,2,32515)

	-- Trollwoven Spaulders -- 60758
	AddRecipe(60758,440,43481,4,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,60758,1,2,4,36,41,51,57)
	self:addTradeAcquire(RecipeDB,60758,2,32515)

	-- Trollwoven Girdle -- 60759
	AddRecipe(60759,440,43484,4,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,60759,1,2,4,36,41,51,57)
	self:addTradeAcquire(RecipeDB,60759,2,32515)

	-- Earthgiving Legguards -- 60760
	AddRecipe(60760,440,43495,4,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,60760,1,2,4,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,60760,2,32515)

	-- Earthgiving Boots -- 60761
	AddRecipe(60761,440,43502,4,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,60761,1,2,4,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,60761,2,32515)

	-- Polar Vest -- 60996
	AddRecipe(60996,425,43590,4,2,425,435,445,455)
	self:addTradeFlags(RecipeDB,60996,1,2,4,36,41,57)
	self:addTradeAcquire(RecipeDB,60996,2,32515)

	-- Polar Cord -- 60997
	AddRecipe(60997,420,43591,4,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60997,1,2,4,36,41,57)
	self:addTradeAcquire(RecipeDB,60997,2,32515)

	-- Polar Boots -- 60998
	AddRecipe(60998,420,43592,4,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,60998,1,2,4,36,41,57)
	self:addTradeAcquire(RecipeDB,60998,2,32515)

	-- Icy Scale Chestguard -- 60999
	AddRecipe(60999,425,43593,4,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,60999,1,2,4,36,41,58)
	self:addTradeAcquire(RecipeDB,60999,2,32515)

	-- Icy Scale Belt -- 61000
	AddRecipe(61000,420,43594,4,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,61000,1,2,4,36,41,58)
	self:addTradeAcquire(RecipeDB,61000,2,32515)

	-- Icy Scale Boots -- 61002
	AddRecipe(61002,420,43595,4,2,420,425,430,435)
	self:addTradeFlags(RecipeDB,61002,1,2,4,36,41,58)
	self:addTradeAcquire(RecipeDB,61002,2,32515)

	-- Raptor Hide Harness -- 4096
	AddRecipe(4096,165,4455,2,2,165,185,195,205)
	self:addTradeFlags(RecipeDB,4096,2,4,36,41,51,57)
	self:addTradeAcquire(RecipeDB,4096,2,2819)

	-- Windripper Boots -- 62176
	AddRecipe(62176,440,44930,4,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,62176,1,2,4,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,62176,2,32515)

	-- Windripper Leggings -- 62177
	AddRecipe(62177,440,44931,4,2,440,450,455,460)
	self:addTradeFlags(RecipeDB,62177,1,2,4,36,41,53,54,57)
	self:addTradeAcquire(RecipeDB,62177,2,32515)

	-- Earthen Leg Armor -- 62448
	AddRecipe(62448,425,44963,4,2,425,430,435,440)
	self:addTradeFlags(RecipeDB,62448,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,62448,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Borean Leather -- 64661
	AddRecipe(64661,350,33568,1,2,350,350,362,375)
	self:addTradeFlags(RecipeDB,64661,1,2,3,36,41,57)
	self:addTradeAcquire(RecipeDB,64661,1,26911,1,26961,1,26996,1,26998,1,28700,1,33581)

	-- Lightning Grounded Boots -- 63197
	AddRecipe(63197,450,45097,4,2,450,455,465,475)
	self:addTradeFlags(RecipeDB,63197,1,2,6,36,40,53,54,58)
	self:addTradeAcquire(RecipeDB,63197,8,39)

	-- Footpads of Silence -- 63199
	AddRecipe(63199,450,45099,4,2,450,455,465,475)
	self:addTradeFlags(RecipeDB,63199,1,2,6,36,40,51,57)
	self:addTradeAcquire(RecipeDB,63199,8,39)

	-- Death-warmed Belt -- 63198
	AddRecipe(63198,450,45098,4,2,450,455,465,475)
	self:addTradeFlags(RecipeDB,63198,1,2,6,36,40,51,57)
	self:addTradeAcquire(RecipeDB,63198,8,39)

	-- Boots of Wintry Endurance -- 63201
	AddRecipe(63201,450,45101,4,2,450,455,465,475)
	self:addTradeFlags(RecipeDB,63201,1,2,6,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,63201,8,39)

	-- Boots of Living Scale -- 63195
	AddRecipe(63195,450,45095,4,2,450,455,465,475)
	self:addTradeFlags(RecipeDB,63195,1,2,6,36,40,51,58)
	self:addTradeAcquire(RecipeDB,63195,8,39)

	-- Blue Belt of Chaos -- 63196
	AddRecipe(63196,450,45096,4,2,450,455,465,475)
	self:addTradeFlags(RecipeDB,63196,1,2,6,36,40,53,54,58)
	self:addTradeAcquire(RecipeDB,63196,8,39)

	-- Belt of Dragons -- 63194
	AddRecipe(63194,450,45553,4,2,450,455,465,475)
	self:addTradeFlags(RecipeDB,63194,1,2,6,36,40,51,58)
	self:addTradeAcquire(RecipeDB,63194,8,39)

	-- Belt of Arctic Life -- 63200
	AddRecipe(63200,450,45100,4,2,450,455,465,475)
	self:addTradeFlags(RecipeDB,63200,1,2,6,36,40,53,54,57)
	self:addTradeAcquire(RecipeDB,63200,8,39)

	-- Drums of Forgotten Kings -- 69386
	AddRecipe(69386,450,49633,1,2,450,450,455,470)
	self:addTradeFlags(RecipeDB,69386,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,69386,1,28700,1,26996,1,26911,1,26961,1,33581,1,26998)

	-- Drums of the Wild -- 69388
	AddRecipe(69388,450,49634,1,2,450,450,455,470)
	self:addTradeFlags(RecipeDB,69388,1,2,3,36,41)
	self:addTradeAcquire(RecipeDB,69388,1,28700,1,26996,1,26911,1,26961,1,33581,1,26998)

	-- Legwraps of Unleashed Nature - 70554
	 AddRecipe(70554, 450, 49898, R_EPIC, GAME_WOTLK)
	self:addTradeFlags(RecipeDB, 70554, F_ALLIANCE, F_HORDE, F_VENDOR, F_ASHEN_VERDICT)
	self:addTradeAcquire(RecipeDB, 70554, A_REPUTATION, 1156, REVERED, 37687)

	-- Blessed Cenarion Boots - 70555
	AddRecipe(70555, 450, 49894, R_EPIC, GAME_WOTLK)
	self:addTradeFlags(RecipeDB, 70555, F_ALLIANCE, F_HORDE, F_VENDOR, F_ASHEN_VERDICT)
	self:addTradeAcquire(RecipeDB, 70555, A_REPUTATION, 1156, HONORED, 37687)

	-- Bladeborn Leggings - 70556
	AddRecipe(70556, 450, 49899, R_EPIC, GAME_WOTLK)
	self:addTradeFlags(RecipeDB, 70556, F_ALLIANCE, F_HORDE, F_VENDOR, F_ASHEN_VERDICT)
	self:addTradeAcquire(RecipeDB, 70556, A_REPUTATION, 1156, REVERED, 37687)

	-- Footpads of Impending Doom - 70557
	AddRecipe(70557, 450, 49895, R_EPIC, GAME_WOTLK)
	self:addTradeFlags(RecipeDB, 70557, F_ALLIANCE, F_HORDE, F_VENDOR, F_ASHEN_VERDICT)
	self:addTradeAcquire(RecipeDB, 70557, A_REPUTATION, 1156, HONORED, 37687)

	-- Lightning-infused Leggings - 70558
	AddRecipe(70558, 450, 49900, R_EPIC, GAME_WOTLK)
	self:addTradeFlags(RecipeDB, 70558, F_ALLIANCE, F_HORDE, F_VENDOR, F_ASHEN_VERDICT)
	self:addTradeAcquire(RecipeDB, 70558, A_REPUTATION, 1156, REVERED, 37687)

	-- Earthsoul Boots - 70559
	AddRecipe(70559, 450, 49896, R_EPIC, GAME_WOTLK)
	self:addTradeFlags(RecipeDB, 70559, F_ALLIANCE, F_HORDE, F_VENDOR, F_ASHEN_VERDICT)
	self:addTradeAcquire(RecipeDB, 70559, A_REPUTATION, 1156, HONORED, 37687)

	-- Draconic Bonesplinter Legguards - 70560
	AddRecipe(70560, 450, 49901, R_EPIC, GAME_WOTLK)
	self:addTradeFlags(RecipeDB, 70560, F_ALLIANCE, F_HORDE, F_VENDOR, F_ASHEN_VERDICT)
	self:addTradeAcquire(RecipeDB, 70560, A_REPUTATION, 1156, REVERED, 37687)

	-- Rock-Steady Treads - 70561
	AddRecipe(70561, 450, 49897, R_EPIC, GAME_WOTLK)
	self:addTradeFlags(RecipeDB, 70561, F_ALLIANCE, F_HORDE, F_VENDOR, F_ASHEN_VERDICT)
	self:addTradeAcquire(RecipeDB, 70561, A_REPUTATION, 1156, HONORED, 37687)
 
	-- Some recipes are only availible to specific factions.
	-- We only add the faction specific recipes if the user is part of that faction
	local BFAC = LibStub("LibBabble-Faction-3.0"):GetLookupTable()
	local _,faction = UnitFactionGroup("player")

	if (faction == BFAC["Alliance"]) then

		-- Black Chitin Bracers -- 67081
		AddRecipe(67081,450,47579,4,2,450,460,467,475)
		self:addTradeFlags(RecipeDB,67081,1,6,11)
		self:addTradeAcquire(RecipeDB,67081,8,42)

		-- Bracers of Swift Death -- 67087
		AddRecipe(67087,450,47581,4,2,450,460,467,475)
		self:addTradeFlags(RecipeDB,67087,1,6,11)
		self:addTradeAcquire(RecipeDB,67087,8,42)

		-- Crusader's Dragonscale Bracers -- 67083
		AddRecipe(67083,450,47576,4,2,450,460,467,475)
		self:addTradeFlags(RecipeDB,67083,1,6,11,36,40,51,58)
		self:addTradeAcquire(RecipeDB,67083,8,42)

		-- Crusader's Dragonscale Breastplate -- 67082
		AddRecipe(67082,450,47595,4,2,450,460,467,475)
		self:addTradeFlags(RecipeDB,67082,1,6,11)
		self:addTradeAcquire(RecipeDB,67082,8,42)

		-- Ensorcelled Nerubian Breastplate -- 67080
		AddRecipe(67080,450,47597,4,2,450,460,467,475)
		self:addTradeFlags(RecipeDB,67080,1,6,11,36,40,53,54,58)
		self:addTradeAcquire(RecipeDB,67080,8,42)

		-- Knightbane Carapace -- 67086
		AddRecipe(67086,450,47599,4,2,450,460,467,475)
		self:addTradeFlags(RecipeDB,67086,1,6,11)
		self:addTradeAcquire(RecipeDB,67086,8,42)

		-- Lunar Eclipse Chestguard -- 67084
		AddRecipe(67084,450,47602,4,2,450,460,467,475)
		self:addTradeFlags(RecipeDB,67084,1,6,11)
		self:addTradeAcquire(RecipeDB,67084,8,42)

		-- Moonshadow Armguards -- 67085
		AddRecipe(67085,450,47583,4,2,450,460,467,475)
		self:addTradeFlags(RecipeDB,67085,1,6,11)
		self:addTradeAcquire(RecipeDB,67085,8,42)

	elseif (faction == BFAC["Horde"]) then

		-- Black Chitin Bracers -- 67137
		AddRecipe(67137,450,47580,4,2,450,460,467,475)
		self:addTradeFlags(RecipeDB,67137,2,6,11,36,40,53,54,58)
		self:addTradeAcquire(RecipeDB,67137,8,42)

		-- Bracers of Swift Death -- 67139
		AddRecipe(67139,450,47582,4,2,450,460,467,475)
		self:addTradeFlags(RecipeDB,67139,2,6,11,36,40,51,57)
		self:addTradeAcquire(RecipeDB,67139,8,42)

		-- Crusader's Dragonscale Bracers -- 67143
		AddRecipe(67143,450,47577,4,2,450,460,467,475)
		self:addTradeFlags(RecipeDB,67143,2,6,11,36,40,51,58)
		self:addTradeAcquire(RecipeDB,67143,8,42)
		
		-- Crusader's Dragonscale Breastplate -- 67138
		AddRecipe(67138,450,47596,4,2,450,460,467,475)
		self:addTradeFlags(RecipeDB,67138,2,6,11,36,40,51,58)
		self:addTradeAcquire(RecipeDB,67138,8,42)
	
		-- Ensorcelled Nerubian Breastplate -- 67136
		AddRecipe(67136,450,47598,4,2,450,460,467,475)
		self:addTradeFlags(RecipeDB,67136,2,6,11,36,40,53,54,58)
		self:addTradeAcquire(RecipeDB,67136,8,42)

		-- Knightbane Carapace -- 67142
		AddRecipe(67142,450,47600,4,2,450,460,467,475)
		self:addTradeFlags(RecipeDB,67142,2,6,11,36,40,51,57)
		self:addTradeAcquire(RecipeDB,67142,8,42)

		-- Lunar Eclipse Chestguard -- 67140
		AddRecipe(67140,450,47601,4,2,450,460,467,475)
		self:addTradeFlags(RecipeDB,67140,2,6,11,36,40,53,54,57)
		self:addTradeAcquire(RecipeDB,67140,8,42)

		-- Moonshadow Armguards -- 67141
		AddRecipe(67141,450,47584,4,2,450,460,467,475)
		self:addTradeFlags(RecipeDB,67141,2,6,11,36,40,53,54,57)
		self:addTradeAcquire(RecipeDB,67141,8,42)

	end

	return num_recipes

end
