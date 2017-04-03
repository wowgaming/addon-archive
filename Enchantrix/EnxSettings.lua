--[[
	Enchantrix Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: EnxSettings.lua 4587 2009-12-17 22:00:31Z Nechckn $
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
		EnchantConfig = {

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

			["users.Foobar.Picksell"] = "test4",

			["profile.Default"] = {
				["miniicon.angle"] = 187,
				["miniicon.distance"] = 15,
			},

		}

if user does not have a set profile name, they get the default profile


Usage:
	def = Enchantrix.Settings.GetDefault('TooltipShowValues')
	val = Enchantrix.Settings.GetSetting('TooltipShowValues')
	Enchantrix.Settings.SetSetting('TooltipShowValues', true );

]]

Enchantrix_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Enchantrix/EnxSettings.lua $", "$Rev: 4587 $")

local lib = {}
Enchantrix.Settings = lib
local private = {}
local gui

local function getUserSig()
	local userSig = string.format("users.%s.%s", GetRealmName(), UnitName("player"))
	return userSig
end

local function getUserProfileName()
	if (not EnchantConfig) then EnchantConfig = {} end
	local userSig = getUserSig()
	return EnchantConfig[userSig] or "Default"
end

local function getUserProfile()
	if (not EnchantConfig) then EnchantConfig = {} end
	local profileName = getUserProfileName()
	if (not EnchantConfig["profile."..profileName]) then
		if profileName ~= "Default" then
			profileName = "Default"
			EnchantConfig[getUserSig()] = "Default"
		end
		if profileName == "Default" then
			EnchantConfig["profile."..profileName] = {}
		end
	end
	return EnchantConfig["profile."..profileName]
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
	['printframe'] = 1,

	['chatShowFindings'] = true,

	['ToolTipEmbedInGameTip'] = false,
	['TooltipShowValues'] = true,
	['TooltipShowAuctValueHSP'] = true,
	['TooltipShowAuctValueMedian'] = true,
	['TooltipShowBaselineValue'] = true,
	['TooltipShowAuctAdvValue'] = true,
	['TooltipShowDisenchantLevel'] = true,	-- should the item tooltip show the enchanting level needed to disenchant
	['TooltipShowDisenchantMats'] = true,	-- should the item tooltip show what it disenchants into? (for those who are just greedy)
	['TooltipShowMatSources'] = true,		-- should we show the source for enchant mats, gems, and inks?

	['TooltipShowProspecting'] = true,		-- should the tooltip show any prospecting data?
	['TooltipProspectLevels'] = true,		-- should the tooltip show skill level needed to prospect?
	['TooltipProspectValues'] = true,		-- should the tooltip show prospecting values
	['TooltipProspectMats'] = true,			-- should the item tooltip show what it prospects into? (for those who are just greedy)
	['TooltipProspectShowAuctValueHSP'] = true,
	['TooltipProspectShowAuctValueMedian'] = true,
	['TooltipProspectShowBaselineValue'] = true,
	['TooltipProspectShowAuctAdvValue'] = true,

	['TooltipShowMilling'] = true,		-- should the tooltip show any Milling data?
	['TooltipMillingLevels'] = true,		-- should the tooltip show skill level needed to Milling?
	['TooltipMillingValues'] = true,		-- should the tooltip show Millinging values
	['TooltipMillingMats'] = true,			-- should the item tooltip show what it Millings into? (for those who are just greedy)
	['TooltipMillingShowAuctValueHSP'] = true,
	['TooltipMillingShowAuctValueMedian'] = true,
	['TooltipMillingShowBaselineValue'] = true,
	['TooltipMillingShowAuctAdvValue'] = true,
	
	['TooltipShowReagents'] = true,		-- show reagents for enchant/spell tooltips

	['ShowAllCraftReagents'] = false,		-- ccox - just an idea I'm testing, doesn't work that well yet

	['profile.name'] = '',		-- not sure why this gets hit so often, might be a bug

	['ScanValueType'] = "average",		-- what value to use for auction scans

	['AuctionBalanceEssencePrices'] = false,	-- should we balance the price of essences before doing auction scans?
	['AuctionBalanceEssenceStyle'] = "avg",		-- how do we balance the price of essences

	['AutoDisenchantEnable'] = false,	-- off by default - potentially dangerous if you're not expecting it :)
	['AutoDeRareItems'] = true,			-- on by default for backwards compatibility
	['AutoDeEpicItems'] = true, 		-- on by default for backwards compatibility
	['AutoDeOnlyIfBoughtForDE'] = false, 	-- off by default for backwards compatibility, checks with BeanCounter for purchase reason
	['autoLootDE'] = false,				-- off by default for backwards compatibility

	['export.aucadv'] = true, -- Send our price values to Auctioneer as stats
	['ModTTShow'] = false,
}

local function getDefault(setting)
	local a,b,c = strsplit(".", setting)

	-- basic settings
	if (a == "show") then return true end
	if (b == "enable") then return true end

	-- reagent prices
	if (a == "value") then
		return Enchantrix.Constants.StaticPrices[tonumber(b) or 0]
	end

	-- Weights default to 100%
	if (a == "weight") then return 100 end
	if (a == "fixed") then
		if (c == "value") then
			local reagId = tonumber(b)
			if (reagId) then
				return Enchantrix.Constants.StaticPrices[reagId]
			end
		else
			return false
		end
	end

	-- miniicon settings
	if (setting == "miniicon.angle")          then return 118     end
	if (setting == "miniicon.distance")       then return 12      end

	-- lookup the simple settings
	local result = settingDefaults[setting];

	-- no idea what this setting is, so log it for debugging purposes
	if (result == nil) then
--		Enchantrix.Util.DebugPrint("GetDefault", ENX_INFO, "Unknown key", "default requested for unknown key:" .. setting)
	end

	return result

end

function lib.GetDefault(setting)
	local val = getDefault(setting);
	return val;
end

local function setter(setting, value)
	if (not EnchantConfig) then EnchantConfig = {} end

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
			EnchantConfig["profile."..value] = {}

			-- Set the current profile to the new profile
			EnchantConfig[getUserSig()] = value
			-- Get the new current profile
			local newProfile = getUserProfile()

			-- Clean it out and then resave all data
			cleanse(newProfile)
			gui:Resave()

			-- Add the new profile to the profiles list
			local profiles = EnchantConfig["profiles"]
			if (not profiles) then
				profiles = { "Default" }
				EnchantConfig["profiles"] = profiles
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

			DEFAULT_CHAT_FRAME:AddMessage(_ENCH("ChatSavedProfile")..value)

		elseif (setting == "profile.duplicate") then
			-- User clicked the Duplicate button, copy the current profile using the new name
			value = gui.elements["profile"].value

			-- If there's a profile name supplied
			if (value) then
				local existingProfile = EnchantConfig["profile."..value]
				
				local newName = gui.elements["profile.name"]:GetText()

				if (newName and newName ~= "") then
					-- copy it under the new name
					EnchantConfig["profile."..newName] = existingProfile
					
					-- Set the current profile to the new profile
					EnchantConfig[getUserSig()] = newName

					-- Add the new profile to the profiles list
					local profiles = EnchantConfig["profiles"]
					if (not profiles) then
						profiles = { "Default" }
						EnchantConfig["profiles"] = profiles
					end

					-- Check to see if it already exists
					local found = false
					for pos, name in ipairs(profiles) do
						if (name == newName) then found = true end
					end

					-- If not, add it and then sort it
					if (not found) then
						table.insert(profiles, newName)
						table.sort(profiles)
					end

					DEFAULT_CHAT_FRAME:AddMessage(_ENCH("ChatDuplicatedProfile")..newName)
				end
			end

		elseif (setting == "profile.delete") then
			-- User clicked the Delete button, see what the select box's value is.
			value = gui.elements["profile"].value

			-- If there's a profile name supplied
			if (value) then
				-- Clean it's profile container of values
				cleanse(EnchantConfig["profile."..value])

				-- Delete it's profile container
				EnchantConfig["profile."..value] = nil

				-- Find it's entry in the profiles list
				local profiles = EnchantConfig["profiles"]
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
					EnchantConfig[getUserSig()] = 'Default'
				end

				DEFAULT_CHAT_FRAME:AddMessage(_ENCH("ChatDeletedProfile")..value)

			end

		elseif (setting == "profile.default") then
			-- User clicked the reset settings button

			-- Get the current profile from the select box
			value = gui.elements["profile"].value

			-- Clean it's profile container of values
			EnchantConfig["profile."..value] = {}

			DEFAULT_CHAT_FRAME:AddMessage(_ENCH("ChatResetProfile")..value)

		elseif (setting == "profile") then
			-- User selected a different value in the select box, get it
			value = gui.elements["profile"].value

			-- Change the user's current profile to this new one
			EnchantConfig[getUserSig()] = value

			DEFAULT_CHAT_FRAME:AddMessage(_ENCH("ChatUsingProfile")..value)

		end

		-- Refresh all values to reflect current data
		gui:Refresh()


	elseif (a == "autode") then

		if (setting == "autode.deleteItem") then

			-- User clicked the Delete button, see what the select box's value is.
			value = gui.elements["autode.selectitem"].value

			-- If there's an item name supplied
			if (value) then
				if (AutoDisenchantIgnoreList) then
					for info,_ in pairs(AutoDisenchantIgnoreList) do
						-- deserialize and compare the name
						local thisName = Enchantrix.AutoDisenchant.NameFromIgnoreListItem(info)
						if (value == thisName) then
							AutoDisenchantIgnoreList[info] = nil
							break
						end
					end
				end

			end

		elseif (setting == "autode.reset") then
			-- User clicked the reset settings button
			AutoDisenchantIgnoreList = {}
		elseif (setting == "autode.selectitem") then
			-- save off the item they selected
			lib.autoDEListItem = value;
		end

		-- Refresh all values to reflect current data
		gui:Refresh()

	else
		-- Set the value for this setting in the current profile
		local db = getUserProfile()
		db[setting] = value
		--setUpdated()
	end

	if (a == "miniicon") then
		Enchantrix.MiniIcon.Reposition()
	end

	if (a == "sideIcon") and Enchantrix.SideIcon then
		Enchantrix.SideIcon.Update()
	end

end

function lib.SetSetting(...)
	setter(...)
	if (gui) then
		gui:Refresh()
	end
end


local function getter(setting)
	if (not EnchantConfig) then EnchantConfig = {} end
	if not setting then return end

	local a,b,c = strsplit(".", setting)
	if (a == 'profile') then
		if (b == 'profiles') then
			local pList = EnchantConfig["profiles"]
			if (not pList) then
				pList = { "Default" }
			end
			return pList
		end

	elseif (a == 'autode') then
		if (b == 'items') then
			local deiList = {}
			if (AutoDisenchantIgnoreList) then
				for info,_ in pairs(AutoDisenchantIgnoreList) do
					local name = Enchantrix.AutoDisenchant.NameFromIgnoreListItem(info)
					table.insert( deiList, name )
				end
			end
			if (deiList[1]) then
				lib.autoDEListItem = deiList[1];
			else
				lib.autoDEListItem = nil;
			end
			return deiList
		elseif (b == 'selectitem') then
			return lib.autoDEListItem
		end
	end

	if (a == 'scanvalue') then
		if (b == 'list') then
			if not private.scanValueNames then private.scanValueNames = {} end

			for i = 1, #private.scanValueNames do
				private.scanValueNames[i] = nil
			end

			table.insert(private.scanValueNames,{"average", _ENCH("GuiItemValueAverage") })
			table.insert(private.scanValueNames,{"baseline", _ENCH("GuiItemValueBaseline") })
			if AucAdvanced then
				table.insert(private.scanValueNames,{"adv:market", _ENCH("GuiItemValueAuc5Market") })
				local algoList = AucAdvanced.API.GetAlgorithms()
				for pos, name in ipairs(algoList) do
					table.insert(private.scanValueNames,{"adv:stat:"..name, "AucAdv Stat:"..name})
				end
			end
			if Auctioneer then
				table.insert(private.scanValueNames,{"auc4:hsp", _ENCH("GuiItemValueAuc4HSP") })
				table.insert(private.scanValueNames,{"auc4:med", _ENCH("GuiItemValueAuc4Median") })
			end

			return private.scanValueNames
		end
	end

	if (setting == 'profile') then
		return getUserProfileName()
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

function lib.UpdateGuiConfig()
	if gui then
		if gui:IsVisible() then
			gui:Hide()
		end
		gui = nil
		lib.MakeGuiConfig()
	end
end

function lib.MakeGuiConfig()
	if gui then return end

	local id, last, cont
	local Configator = LibStub:GetLibrary("Configator")
	gui = Configator:Create(setter, getter)
	lib.Gui = gui

  	gui:AddCat("Enchantrix")


	id = gui:AddTab(_ENCH("GuiTabProfiles"))
	gui:AddControl(id, "Header",     0,    _ENCH("GuiConfigProfiles"))

	gui:AddControl(id, "Subhead",    0,    _ENCH("GuiActivateProfile"))
	gui:AddControl(id, "Selectbox",  0, 1, "profile.profiles", "profile", "this string isn't shown")
	gui:AddControl(id, "Button",     0, 1, "profile.delete", _ENCH("GuiDeleteProfileButton"))
	gui:AddControl(id, "Button",     0, 1, "profile.default", _ENCH("GuiResetProfileButton"))

	gui:AddControl(id, "Subhead",    0,    _ENCH("GuiCreateReplaceProfile"))
	gui:AddControl(id, "Text",       0, 1, "profile.name", _ENCH("GuiNewProfileName"))
	gui:AddControl(id, "Button",     0, 1, "profile.save", _ENCH("GuiSaveProfileButton"))
	gui:AddControl(id, "Button",     0, 1, "profile.duplicate", _ENCH("GuiDuplicateProfileButton"))

	id = gui:AddTab(_ENCH("GuiTabGeneral"))
	gui:AddControl(id, "Header",     0,    _ENCH("GuiGeneralOptions"))
	gui:AddControl(id, "Checkbox", 0, 1, "ModTTShow", _ENCH("ModTTShow"))--Only display our extra tooltip data if Alt is pressed.
	gui:AddTip(id, _ENCH("ModTTShow_Help"))--Show Enchantrix's extra tooltip only if Alt is pressed.
	gui:AddControl(id, "Checkbox",   0, 1, "TooltipShowDisenchantLevel", _ENCH("GuiDELevels") )
	gui:AddControl(id, "Checkbox",   0, 1, "ToolTipEmbedInGameTip", _ENCH("HelpEmbed") )
	gui:AddControl(id, "Checkbox",   0, 1, "TooltipShowDisenchantMats", _ENCH("GuiDEMaterials") )
	gui:AddControl(id, "Checkbox",   0, 1, "export.aucadv", _ENCH("ExportPriceAucAdv"))
	gui:AddControl(id, "Checkbox",   0, 1, "chatShowFindings", _ENCH("GuiPrintYieldsInChat") )
	gui:AddControl(id, "Checkbox",   0, 1, "TooltipShowReagents", _ENCH("GuiShowCraftReagents") )	
	gui:AddControl(id, "Checkbox",   0, 1, "TooltipShowMatSources", _ENCH("GuiShowMatSources") )

	gui:AddControl(id, "Subhead",    0,    _ENCH("GuiItemValueCalc"))
	gui:AddControl(id, "Selectbox",  0, 1, "scanvalue.list", "ScanValueType", "this string isn't shown")

-- TODO: locale -- what are the allowed values?
-- TODO: printframe  -- what are the allowed values?  Configurator really needs a restricted value number box (without a slider)

	gui:AddControl(id, "Subhead",    0,    _ENCH("GuiValueOptions"))
	gui:AddControl(id, "Checkbox",   0, 1, "TooltipShowValues", _ENCH("GuiValueShowDEValues"))
	if (Enchantrix.State.Auctioneer_Loaded) then
		if (Auctioneer) then
			gui:AddControl(id, "Checkbox",       0, 2, "TooltipShowAuctValueHSP", _ENCH("GuiValueShowAuc4HSP"))
			gui:AddControl(id, "Checkbox",       0, 2, "TooltipShowAuctValueMedian", _ENCH("GuiValueShowAuc4Median"))
		end
		if (AucAdvanced) then
			gui:AddControl(id, "Checkbox",       0, 2, "TooltipShowAuctAdvValue", _ENCH("GuiValueShowAuc5Market"))
		end
	end
	gui:AddControl(id, "Checkbox",   0, 2, "TooltipShowBaselineValue", _ENCH("GuiValueShowBaseline"))

	gui:AddControl(id, "Subhead",    0,    _ENCH("GuiMinimapOptions"))
	gui:AddControl(id, "Checkbox",   0, 1, "miniicon.enable", _ENCH("GuiMinimapShowButton"))
	gui:AddControl(id, "Slider",     0, 2, "miniicon.angle", 0, 360, 1, _ENCH("GuiMinimapButtonAngle"))
	gui:AddControl(id, "Slider",     0, 2, "miniicon.distance", -80, 80, 1, _ENCH("GuiMinimapButtonDist"))
	gui:AddControl(id, "Checkbox",   0, 1, "sideIcon.enable", "Display the sidebar button")

	id = gui:AddTab(_ENCH("GuiAutoDeOptions"))
	gui:AddControl(id, "Checkbox",   0, 1, "AutoDisenchantEnable", _ENCH("GuiAutoDeEnable"))
	gui:AddControl(id, "Checkbox",   0, 2, "AutoDeRareItems", _ENCH("GuiAutoDeRareItems"))
	gui:AddControl(id, "Checkbox",   0, 2, "AutoDeEpicItems", _ENCH("GuiAutoDeEpicItems"))
	gui:AddControl(id, "Checkbox",   0, 2, "AutoDeOnlyIfBoughtForDE", _ENCH("GuiAutoDeBoughtForDE"))
	gui:AddControl(id, "Checkbox",   0, 2, "autoLootDE", _ENCH("GuiAutoLootDE"))
	
	gui:AddControl(id, "Subhead",    0,    "AutoDisenchant: Permanently Ignored Items")
	gui:AddControl(id, "Selectbox",  0, 1, "autode.items", "autode.selectitem", "this string isn't shown but needs to be long for layout")
	gui:AddControl(id, "Button",     0, 1, "autode.deleteItem", "remove item")
	gui:AddControl(id, "Button",     0, 1, "autode.reset", "reset all items")

	id = gui:AddTab(_ENCH("GuiTabProspecting"))
	gui:AddControl(id, "Header",     0,    _ENCH("GuiProspectingOptions"))
	gui:AddControl(id, "Checkbox",   0, 1, "TooltipShowProspecting", _ENCH("GuiShowProspecting") )
	gui:AddControl(id, "Checkbox",   0, 2, "TooltipProspectLevels", _ENCH("GuiProspectingLevels") )
	gui:AddControl(id, "Checkbox",   0, 2, "TooltipProspectMats", _ENCH("GuiProspectingMaterials") )

	gui:AddControl(id, "Subhead",    0,    _ENCH("GuiValueOptions"))
	gui:AddControl(id, "Checkbox",   0, 1, "TooltipProspectValues",  _ENCH("GuiProspectingValues"))
	if (Enchantrix.State.Auctioneer_Loaded) then
		if (Auctioneer) then
			gui:AddControl(id, "Checkbox",       0, 2, "TooltipProspectShowAuctValueHSP", _ENCH("GuiValueShowAuc4HSP"))
			gui:AddControl(id, "Checkbox",       0, 2, "TooltipProspectShowAuctValueMedian", _ENCH("GuiValueShowAuc4Median"))
		end
		if (AucAdvanced) then
			gui:AddControl(id, "Checkbox",       0, 2, "TooltipProspectShowAuctAdvValue", _ENCH("GuiValueShowAuc5Market"))
		end
	end
	gui:AddControl(id, "Checkbox",   0, 2, "TooltipProspectShowBaselineValue", _ENCH("GuiValueShowBaseline"))

	id = gui:AddTab(_ENCH("GuiTabMilling"))
	gui:AddControl(id, "Header",     0,    _ENCH("GuiMillingOptions"))
	gui:AddControl(id, "Checkbox",   0, 1, "TooltipShowMilling", _ENCH("GuiShowMilling") )
	gui:AddControl(id, "Checkbox",   0, 2, "TooltipMillingLevels", _ENCH("GuiMillingLevels") )
	gui:AddControl(id, "Checkbox",   0, 2, "TooltipMillingMats", _ENCH("GuiMillingMaterials") )

	gui:AddControl(id, "Subhead",    0,    _ENCH("GuiValueOptions"))
	gui:AddControl(id, "Checkbox",   0, 1, "TooltipMillingValues",  _ENCH("GuiMillingingValues"))
	if (Enchantrix.State.Auctioneer_Loaded) then
		if (Auctioneer) then
			gui:AddControl(id, "Checkbox",       0, 2, "TooltipMillingShowAuctValueHSP", _ENCH("GuiValueShowAuc4HSP"))
			gui:AddControl(id, "Checkbox",       0, 2, "TooltipMillingShowAuctValueMedian", _ENCH("GuiValueShowAuc4Median"))
		end
		if (AucAdvanced) then
			gui:AddControl(id, "Checkbox",       0, 2, "TooltipMillingShowAuctAdvValue", _ENCH("GuiValueShowAuc5Market"))
		end
	end
	gui:AddControl(id, "Checkbox",   0, 2, "TooltipMillingShowBaselineValue", _ENCH("GuiValueShowBaseline"))

	id = gui:AddTab(_ENCH("GuiTabWeights"))
	gui:MakeScrollable(id)
	gui:AddControl(id, "Header",     0,    _ENCH("GuiWeightSettings"))
	gui:AddControl(id, "Note",     0, 1, 600, 60, _ENCH("GuiWeighSettingsNote"))
	local numReag = #Enchantrix.Constants.DisenchantReagentList
	local colPos = 0
	for i=1, numReag do
		local reagId = Enchantrix.Constants.DisenchantReagentList[i]
		local reagName = Enchantrix.Util.GetReagentInfo(reagId)
		if (not reagName) then reagName = "item:"..reagId end
		gui:AddControl(id, "WideSlider", 0, 1, "weight."..reagId, 0, 250, 5, reagName..": %s%%")
		local reagLink = Enchantrix.Util.GetLinkFromName(reagName)
		gui:AddLinkTip(id, reagLink)
	end

	id = gui:AddTab(_ENCH("GuiTabFixed"))
	gui:MakeScrollable(id)
	gui:AddControl(id, "Header",     0,  _ENCH("GuiFixedSettings"))
	gui:AddControl(id, "Note",     0, 1, 600, 90, _ENCH("GuiFixedSettingsNote"))
	local numReag = #Enchantrix.Constants.DisenchantReagentList
	local colPos = 0
	for i=1, numReag do
		local reagId = Enchantrix.Constants.DisenchantReagentList[i]
		local reagName = Enchantrix.Util.GetReagentInfo(reagId)
		if (not reagName) then reagName = "item:"..reagId end
		last = gui:GetLast(id)
		gui:AddControl(id, "Checkbox", 0, 1, "fixed."..reagId, ("%s:"):format(reagName))
		local reagLink = Enchantrix.Util.GetLinkFromName(reagName)
		gui:AddLinkTip(id, reagLink)
		gui:SetLast(id, last)
		gui:AddControl(id, "MoneyFramePinned", 0.6, 1, "fixed."..reagId..".value", 0, 99999999)
	end

end
