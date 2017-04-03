-------------------------------------------------------------------------------
-- Player.lua
-- Player functions and data for AckisRecipeList.
-------------------------------------------------------------------------------
-- File date: 2009-12-30T10:16:20Z
-- File revision: 2785
-- Project revision: 2817
-- Project version: v1.0-r2818
-------------------------------------------------------------------------------
-- Please see http://www.wowace.com/addons/arl/ for more information.
-------------------------------------------------------------------------------
-- This source code is released under All Rights Reserved.
-------------------------------------------------------------------------------
--- **AckisRecipeList** provides an interface for scanning professions for missing recipes.
-- There are a set of functions which allow you make use of the ARL database outside of ARL.
-- ARL supports all professions currently in World of Warcraft 3.2
-- @class file
-- @name Player.lua
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

local table = _G.table
local twipe = table.wipe

local pairs = _G.pairs

-------------------------------------------------------------------------------
-- Localized Blizzard API.
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local LibStub = LibStub

local MODNAME		= "Ackis Recipe List"
local addon		= LibStub("AceAddon-3.0"):GetAddon(MODNAME)

local BFAC		= LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local L			= LibStub("AceLocale-3.0"):GetLocale(MODNAME)

local Player		= addon.Player

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------
local F_ALLIANCE, F_HORDE = 1, 2
local A_TRAINER, A_VENDOR, A_MOB, A_QUEST, A_SEASONAL, A_REPUTATION, A_WORLD_DROP, A_CUSTOM, A_PVP, A_MAX = 1, 2, 3, 4, 5, 6, 7, 8, 9, 9

-------------------------------------------------------------------------------
-- Variables
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------
-- Marks all exclusions in the recipe database to not be displayed, updating the
-- player's known and unknown counts.
function Player:MarkExclusions()
	local exclusion_list = addon.db.profile.exclusionlist
	local ignored = not addon.db.profile.ignoreexclusionlist
	local recipe_list = addon.recipe_list
	local profession = self["Profession"]
	local known_count = 0
	local unknown_count = 0

	for i in pairs(exclusion_list) do
		local recipe = recipe_list[i]

		-- We may have an item in the exclusion list that has not been scanned yet
		-- check if the entry exists in DB first
		if recipe then
			if ignored then
				recipe["Display"] = false
			end

			local tmp_prof = GetSpellInfo(recipe["Profession"])

			if not recipe["Known"] and tmp_prof == profession then
				known_count = known_count + 1
			elseif tmp_prof == profession then
				unknown_count = unknown_count + 1
			end
		end
	end
	self.excluded_recipes_known = known_count
	self.excluded_recipes_unknown = unknown_count
end


-- Determines if the player has an appropiate level in any applicable faction
-- to learn the recipe.
function Player:HasProperRepLevel(recipe_index)
	-- Reputation constants for special cases.
	local REP_MAGHAR	= 941
	local REP_HONOR_HOLD	= 946
	local REP_THRALLMAR	= 947
	local REP_KURENI	= 978

	local has_faction = true
	local is_alliance = self["Faction"] == BFAC["Alliance"]
	local player_rep = self["Reputation"]
	local acquire_info = addon.recipe_list[recipe_index]["Acquire"]
	local reputations = addon.reputation_list

	for index in pairs(acquire_info) do
		if acquire_info[index]["Type"] == A_REPUTATION then
			local rep_id = acquire_info[index]["ID"]

			if rep_id == REP_HONOR_HOLD or rep_id == REP_THRALLMAR then
				rep_id = is_alliance and REP_HONOR_HOLD or REP_THRALLMAR
			elseif rep_id == REP_MAGHAR or rep_id == REP_KURENI then
				rep_id = is_alliance and REP_KURENI or REP_MAGHAR
			end
			local rep_name = reputations[rep_id]["Name"]

			if not player_rep[rep_name] or player_rep[rep_name] < acquire_info[index]["RepLevel"] then
				has_faction = false
			else
				-- The player's faction level is high enough to learn the recipe. Set to true and break out.
				has_faction = true
				break
			end
		end
	end
	return has_faction
end

function Player:IsCorrectFaction(recipe_flags)
	if self["Faction"] == BFAC["Alliance"] and recipe_flags[F_HORDE] and not recipe_flags[F_ALLIANCE] then
		return false
	elseif self["Faction"] == BFAC["Horde"] and recipe_flags[F_ALLIANCE] and not recipe_flags[F_HORDE] then
		return false
	end
	return true
end

-- Sets the player's professions. Used when the AddOn initializes and when a profession has been learned or unlearned.
-- TODO: Make the AddOn actually detect when a profession is learned/unlearned, then call this function. -Torhal
function Player:SetProfessions()
	local profession_list = self["Professions"]

	for i in pairs(profession_list) do
		profession_list[i] = false
	end
	local smelting_spell = GetSpellInfo(2656)
	local mining_spell = GetSpellInfo(32606)

	for index = 1, 25, 1 do
		local spell_name = GetSpellName(index, BOOKTYPE_SPELL)

		if not spell_name or index == 25 then
			break
		end

		-- Check for false in the profession_list - a nil entry means we don't care about the spell.
		if profession_list[spell_name] == false or spell_name == smelting_spell then
			-- If the player has smelting, then mining is also known.
			if spell_name == smelting_spell then
				profession_list[mining_spell] = true
			else
				profession_list[spell_name] = true
			end
		end
	end
end

do
	local GetNumFactions = GetNumFactions
	local GetFactionInfo = GetFactionInfo
	local CollapseFactionHeader = CollapseFactionHeader
	local ExpandFactionHeader = ExpandFactionHeader
	local rep_list = {}

	-- Determines if the player can learn a reputation recipe.
	-- TODO: This is currently only used in addon:OnEnable(), which means that reputation gains are NOT tracked. This function should be used to do so. -Torhal
	function Player:SetReputationLevels()
		twipe(rep_list)

		-- Number of factions before we expand
		local num_factions = GetNumFactions()

		-- Lets expand all the headers
		for i = num_factions, 1, -1 do
			local name, _, _, _, _, _, _, _, _, isCollapsed = GetFactionInfo(i)

			if isCollapsed then
				ExpandFactionHeader(i)
				rep_list[name] = true
			end
		end

		-- Number of factions with everything expanded
		num_factions = GetNumFactions()

		-- Get the rep levels
		for i = 1, num_factions, 1 do
			local name, _, replevel = GetFactionInfo(i)

			-- If the rep is greater than neutral
			if replevel > 4 then
				-- We use levels of 0, 1, 2, 3, 4 internally for reputation levels, make it correspond here
				self["Reputation"][name] = replevel - 4
			end
		end

		-- Collapse the headers again
		for i = num_factions, 1, -1 do
			local name = GetFactionInfo(i)

			if rep_list[name] then
				CollapseFactionHeader(i)
			end
		end
	end
end	-- do block
