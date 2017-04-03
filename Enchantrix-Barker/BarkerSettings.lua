--[[
	Enchantrix:Barker Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: BarkerSettings.lua 3767 2008-11-05 17:57:29Z Norganna $
	URL: http://enchantrix.org/

	Settings GUI

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit license to use this AddOn with these facilities
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat


data layout:
		EnchantrixBarkerConfig = {

			["profile.test4"] = {
				["miniicon.distance"] = 56,
				["miniicon.angle"] = 189,
				["show"] = true,
				["enable"] = true,
			},

			["profiles"] = {
				"Default", -- [1]
				"test4", -- [2]
			},

			["users.Balnazzar.Picksell"] = "test4",

			["profile.Default"] = {
				["miniicon.angle"] = 187,
				["miniicon.distance"] = 15,
			},

		}

if user does not have a set profile name, they get the default profile


Usage:
	def = Barker.Settings.GetDefault('counts')
	val = Barker.Settings.GetSetting('counts')
	Barker.Settings.SetSetting('counts', true );

]]
EnchantrixBarker_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Enchantrix-Barker/BarkerSettings.lua $", "$Rev: 3767 $")

local lib = {}
Barker.Settings = lib
local gui

local tooltip = LibStub("nTipHelper:1")

local function getUserSig()
	local userSig = string.format("users.%s.%s", GetRealmName(), UnitName("player"))
	return userSig
end

local function getUserProfileName()
	if (not EnchantrixBarkerConfig) then EnchantrixBarkerConfig = {} end
	local userSig = getUserSig()
	return EnchantrixBarkerConfig[userSig] or "Default"
end

local function getUserProfile()
	if (not EnchantrixBarkerConfig) then EnchantrixBarkerConfig = {} end
	local profileName = getUserProfileName()
	if (not EnchantrixBarkerConfig["profile."..profileName]) then
		if profileName ~= "Default" then
			profileName = "Default"
			EnchantrixBarkerConfig[getUserSig()] = "Default"
		end
		if profileName == "Default" then
			EnchantrixBarkerConfig["profile."..profileName] = {}
		end
	end
	return EnchantrixBarkerConfig["profile."..profileName]
end

local function cleanse( profile )
	if (profile) then
		profile = {}
	end
end

-- Default setting values
local settingDefaults = {
	['all'] = true,
	['locale'] = 'default',
	['embed'] = 'false',

	['printframe'] = 1,

	['profile.name'] = '',		-- not sure why this gets hit so often, might be a bug

	['barker'] = true,
	['barker.profit_margin'] = 10,		-- percent
	['barker.lowest_price'] = 5000,		-- GSC
	['barker.randomise'] = 10,
	['barker.sweet_price'] = 50000,		-- GSC
	['barker.high_price'] = 500000,		-- GSC
	['barker.highest_profit'] = 100000,	-- GSC
	['barker.factor_price'] = 20,

	['barker.factor_item'] = 40,
	['barker.factor_item.2hweap'] = 90,
	['barker.factor_item.weapon'] = 100,
	['barker.factor_item.bracer'] = 70,
	['barker.factor_item.gloves'] = 70,
	['barker.factor_item.boots'] = 70,
	['barker.factor_item.chest'] = 70,
	['barker.factor_item.cloak'] = 70,
	['barker.factor_item.shield'] = 70,
	['barker.factor_item.ring'] = 70,
	['barker.factor_stat'] = 40,
	['barker.factor_stat.intellect'] = 90,
	['barker.factor_stat.stamina'] = 70,
	['barker.factor_stat.agility'] = 70,
	['barker.factor_stat.strength'] = 70,
	['barker.factor_stat.spirit'] = 45,
	['barker.factor_stat.all'] = 75,
	['barker.factor_stat.armor'] = 65,
	['barker.factor_stat.fireRes'] = 85,
	['barker.factor_stat.frostRes'] = 85,
	['barker.factor_stat.natureRes'] = 85,
	['barker.factor_stat.shadowRes'] = 85,
	['barker.factor_stat.allRes'] = 55,
	['barker.factor_stat.mana'] = 35,
	['barker.factor_stat.health'] = 40,
	['barker.factor_stat.damageAbsorb'] = 90,
	['barker.factor_stat.damage'] = 90,
	['barker.factor_stat.defense'] = 60,
	['barker.factor_stat.other'] = 70,

--[[ EnxBarker.lua
-- categories
-- attributes
-- short_attributes, needs mapping to factor_stat settings

	['barker.INT'] = 90,
	['barker.STA'] = 70,
	['barker.AGI'] = 70,
	['barker.STR'] = 70,
	['barker.SPI'] = 45,
	["barker.all stats"] = 75,
	["barker.all res"] = 55,
	['barker.armour'] = 65,
	["barker.fire res"] = 85,
	["barker.frost res"] = 85,
	["barker.nature res"] = 85,
	["barker.shadow res"] = 85,
	['barker.mana'] = 35,
	['barker.health'] = 40,
	['barker.DMG absorb'] = 90,
	['barker.DEF'] = 60,
	['barker.DMG'] = 90,
	['barker.other'] = 70,
]]

}


local function getDefault(setting)
	local a,b,c = strsplit(".", setting)

	-- basic settings
	if (a == "show") then return true end
	if (b == "enable") then return true end

	-- reagent prices
	if (a == "value") then
		return Barker.Constants.StaticPrices[tonumber(b) or 0]
	end

	-- lookup the simple settings
	local result = settingDefaults[setting];

	-- no idea what this setting is, so log it for debugging purposes
	if (result == nil) then
		Barker.Util.DebugPrint("GetDefault", ENX_INFO, "Unknown key", "default requested for unknown key:" .. setting)
	end

	return result
end

function lib.GetDefault(setting)
	local val = getDefault(setting);
	return val;
end

local function setter(setting, value)
	if (not EnchantrixBarkerConfig) then EnchantrixBarkerConfig = {} end

	-- turn value into a canonical true or false
	if value == 'on' then
		value = true
	elseif value == 'off' then
		value = false
	end

	-- for defaults, just remove the value and it'll fall through
	if (value == 'default') or (value == getDefault(setting)) then
		-- Don't save default values
		value = nil
	end

	local a,b,c = strsplit(".", setting)
	if (a == "profile") then
		if (setting == "profile.save") then
			value = gui.elements["profile.name"]:GetText()

			-- Create the new profile
			EnchantrixBarkerConfig["profile."..value] = {}

			-- Set the current profile to the new profile
			EnchantrixBarkerConfig[getUserSig()] = value

			-- Get the new current profile
			local newProfile = getUserProfile()

			-- Clean it out and then resave all data
			cleanse(newProfile)
			gui.Resave()

			-- Add the new profile to the profiles list
			local profiles = EnchantrixBarkerConfig["profiles"]
			if (not profiles) then
				profiles = { "Default" }
				EnchantrixBarkerConfig["profiles"] = profiles
			end

			-- Check to see if it already exists
			local found = false
			for pos, name in ipairs(profiles) do
				if (name == value) then found = true end
			end

			-- If not, add it and then sort it
			if (not found) then
				table.insert(profiles, value)
				table.sort(profiles)
			end

-- TODO - localize string
			DEFAULT_CHAT_FRAME:AddMessage("Saved profile: "..value)

		elseif (setting == "profile.delete") then
			-- User clicked the Delete button, see what the select box's value is.
			value = gui.elements["profile"].value

			-- If there's a profile name supplied
			if (value) then
				-- Clean it's profile container of values
				cleanse(EnchantrixBarkerConfig["profile."..value])

				-- Delete it's profile container
				EnchantrixBarkerConfig["profile."..value] = nil

				-- Find it's entry in the profiles list
				local profiles = EnchantrixBarkerConfig["profiles"]
				if (profiles) then
					for pos, name in ipairs(profiles) do
						-- If this is it, then extract it
						if (name == value and name ~= "Default") then
							table.remove(profiles, pos)
						end
					end
				end

				-- If the user was using this one, then move them to Default
				if (getUserProfileName() == value) then
					EnchantrixBarkerConfig[getUserSig()] = 'Default'
				end

-- TODO - localize string
				DEFAULT_CHAT_FRAME:AddMessage("Deleted profile: "..value)

			end

		elseif (setting == "profile.default") then
			-- User clicked the reset settings button

			-- Get the current profile from the select box
			value = gui.elements["profile"].value

			-- Clean it's profile container of values
			EnchantrixBarkerConfig["profile."..value] = {}

-- TODO - localize string
			DEFAULT_CHAT_FRAME:AddMessage("Reset all settings for:"..value)

		elseif (setting == "profile") then
			-- User selected a different value in the select box, get it
			value = gui.elements["profile"].value

			-- Change the user's current profile to this new one
			EnchantrixBarkerConfig[getUserSig()] = value

-- TODO - localize string
			DEFAULT_CHAT_FRAME:AddMessage("Changing profile: "..value)

		end

		-- Refresh all values to reflect current data
		gui.Refresh()
	elseif (a == "barker" and b == "reset_all") then
		-- reset the current profile, by brute force
		local name = getUserProfileName()
		EnchantrixBarkerConfig["profile."..name] = {}
	else
		-- Set the value for this setting in the current profile
		local db = getUserProfile()
		db[setting] = value
	end

	if (a == "miniicon") then
		Barker.MiniIcon.Reposition()
	elseif (a == "barker") then
		Enchantrix_BarkerOptions_Refresh()
	end

end

function lib.SetSetting(...)
	setter(...)
	if (gui) then
		gui.Refresh()
	end
end


local function getter(setting)
	if (not EnchantrixBarkerConfig) then EnchantrixBarkerConfig = {} end
	if not setting then return end

	local a,b,c = strsplit(".", setting)
	if (a == 'profile') then
		if (b == 'profiles') then
			local pList = EnchantrixBarkerConfig["profiles"]
			if (not pList) then
				pList = { "Default" }
			end
			return pList
		end
	end

	if (setting == 'profile') then
		return getUserProfileName()
	end

	if (setting == 'track.styles') then
		return {
			"Black",
			"Blue",
			"Cyan",
			"Green",
			"Magenta",
			"Red",
			"Test",
			"White",
			"Yellow",
		}
	end

	local db = getUserProfile()
	if ( db[setting] ~= nil ) then
		return db[setting]
	else
		return getDefault(setting)
	end
end

function lib.GetSetting(setting, default)
	local option = getter(setting)
	if ( option ~= nil ) then
		return option
	else
		return default
	end
end

local function gsc(value)
	return tooltip:Coins(value)
end

function lib.MakeGuiConfig()
	if gui then return end

	local id, last, cont
	gui = Configator.NewConfigator(setter, getter)
	lib.Gui = gui

  	gui.AddCat("Enchantrix")
	id = gui.AddTab("Profiles")
	gui.AddControl(id, "Header",     0,    "Setup, configure and edit profiles")
	gui.AddControl(id, "Subhead",    0,    "Activate a current profile")
	gui.AddControl(id, "Selectbox",  0, 1, "profile.profiles", "profile", "Switch to given profile")
	gui.AddControl(id, "Button",     0, 1, "profile.delete", "Delete")
	gui.AddControl(id, "Subhead",    0,    "Create or replace a profile")
	gui.AddControl(id, "Text",       0, 1, "profile.name", "New profile name:")
	gui.AddControl(id, "Button",     0, 1, "profile.save", "Save")

	id = gui.AddTab("General")
	gui.AddControl(id, "Header",         0,    "General Enchantrix options")
	gui.AddControl(id, "Subhead",        0,    "Minimap display options")
	gui.AddControl(id, "Checkbox",       0, 1, "miniicon.enable", "Display Minimap button")
	gui.AddControl(id, "Slider",         0, 2, "miniicon.angle", 0, 360, 1, "Button angle: %d")
	gui.AddControl(id, "Slider",         0, 2, "miniicon.distance", -80, 80, 1, "Distance: %d")

  	gui.AddCat("Barker")
	id = gui.AddTab("General")
	gui.AddControl(id, "Header",         0,    "Enchantrix Barker options")
	gui.AddControl(id, "Subhead",        0,    "Profit settings")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.profit_margin", -20, 120, 1, "Profit margin: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.highest_profit", 0, 250000, 5000, "Highest profit: %s", gsc)
	gui.AddControl(id, "WideSlider",     0, 1, "barker.lowest_price", 0, 50000, 500, "Lowest price: %s", gsc)

	gui.AddControl(id, "Subhead",        0,    "Priority settings")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_price", 0, 100, 1, "Price priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.sweet_price", 0, 500000, 5000, "Sweet spot: %s", gsc)
	gui.AddControl(id, "WideSlider",     0, 1, "barker.high_price", 0, 5000000, 50000, "High tide: %s", gsc)
	gui.AddControl(id, "WideSlider",     0, 1, "barker.randomise", 0, 100, 1, "Randomise amount: %d%%")

	id = gui.AddTab("Items, Stats")
	gui.AddControl(id, "Header",         0,    "Barker options (continued)")
	gui.AddControl(id, "Subhead",        0,    "Item type priority")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_item", 0, 100, 1, "Overall type priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_item.2hweap", 0, 100, 1, "2H weapon priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_item.weapon", 0, 100, 1, "Any weapon priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_item.bracer", 0, 100, 1, "Bracer priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_item.gloves", 0, 100, 1, "Gloves priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_item.boots", 0, 100, 1, "Boots priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_item.chest", 0, 100, 1, "Chest priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_item.cloak", 0, 100, 1, "Cloak priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_item.shield", 0, 100, 1, "Shield priority: %d%%")
--	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_item.ring", 0, 100, 1, "Ring priority: %d%%")

	gui.AddControl(id, "Subhead",        0,    "Statistics priorities")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat", 0, 100, 1, "Overall stats priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat.intellect", 0, 100, 1, "Intellect priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat.strength", 0, 100, 1, "Strength priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat.agility", 0, 100, 1, "Agility priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat.stamina", 0, 100, 1, "Stamina priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat.spirit", 0, 100, 1, "Spirit priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat.armor", 0, 100, 1, "Armor priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat.all", 0, 100, 1, "All Stats priority: %d%%")

	id = gui.AddTab("Resist, Enhance")
	gui.AddControl(id, "Header",         0,    "Barker options (continued)")
	gui.AddControl(id, "Subhead",        0,    "Resistances priorities")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat.fireRes", 0, 100, 1, "Fire Resist priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat.frostRes", 0, 100, 1, "Frost Resist priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat.natureRes", 0, 100, 1, "Nature Resist priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat.shadowRes", 0, 100, 1, "Shadow Resist priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat.allRes", 0, 100, 1, "All Resists priority: %d%%")
	gui.AddControl(id, "Subhead",        0,    "Enhancements priorities")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat.mana", 0, 100, 1, "Mana priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat.health", 0, 100, 1, "Health priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat.damage", 0, 100, 1, "Damage priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat.defense", 0, 100, 1, "Defense priority: %d%%")
	gui.AddControl(id, "WideSlider",     0, 1, "barker.factor_stat.other", 0, 100, 1, "Other priority: %d%%")
end


