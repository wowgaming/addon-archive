--[[
	Auctioneer
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: CoreSettings.lua 4640 2010-01-26 02:18:04Z Nechckn $
	URL: http://auctioneeraddon.com/

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
		AucAdvancedConfig = {

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
	def = AucAdvanced.Settings.GetDefault('ToolTipShowCounts')
	val = AucAdvanced.Settings.GetSetting('ToolTipShowCounts')
	AucAdvanced.Settings.SetSetting('ToolTipShowCounts', true );

]]
if not AucAdvanced then return end

AucAdvanced.Settings = {}
local lib = AucAdvanced.Settings
local private = {}
local gui
local Matcherdropdown

local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill, _TRANS = AucAdvanced.GetModuleLocals()

local function getUserSig()
	local userSig = string.format("users.%s.%s", GetRealmName(), UnitName("player"))
	return userSig
end

local function getUserProfileName()
	if (not AucAdvancedConfig) then AucAdvancedConfig = {} end
	local userSig = getUserSig()
	return AucAdvancedConfig[userSig] or "Default"
end

local function getUserProfile()
	if (not AucAdvancedConfig) then AucAdvancedConfig = {} end
	local profileName = getUserProfileName()
	if (not AucAdvancedConfig["profile."..profileName]) then
		if profileName ~= "Default" then
			profileName = "Default"
			AucAdvancedConfig[getUserSig()] = "Default"
		end
		if not AucAdvancedConfig["profile.Default"] then
			AucAdvancedConfig["profile.Default"] = {}
		end
	end
	return AucAdvancedConfig["profile."..profileName]
end

-- Default setting values
local settingDefaults = {
	['all'] = true,
	['locale'] = 'default',
	['scandata.tooltip.display'] = false,
	['scandata.tooltip.modifier'] = true,
	["tooltip.marketprice.show"] = true,
	["tooltip.marketprice.stacksize"] = true,
	['scandata.force'] = false,
	['scandata.summaryonfull'] = true,
	['scandata.summaryonmicro'] = false,
	['scandata.summaryonpartial'] = true,
	['clickhook.enable'] = true,
	['scancommit.speed'] = 50,
	['scancommit.progressbar'] = true,
	['alwaysHomeFaction'] = true,
	['printwindow'] = 1,
	['marketvalue.accuracy'] = .08,
	["ShowPurchaseDebug"] = true,
	["SelectedLocale"] = GetLocale(),
	["ModTTShow"] = false,
	["post.clearonclose"] = true,
	["post.confirmonclose"] = true,
}

local function getDefault(setting)
	local a,b,c = strsplit(".", setting)

	-- basic settings
	if (a == "show") then return true end
	if (b == "enable") then return true end

	--If settings is a function reference, call it.
	-- This was added to enable Protect Window to update its
	-- status without a UI reload by calling a function rather
	-- than a setting in the Control definition.
	if (type(setting) == "function") then
		return setting("getdefault")
	end

	-- lookup the simple settings
	local result = settingDefaults[setting];

	return result
end

function lib.GetDefault(setting)
	local val = getDefault(setting);
	return val;
end

function lib.SetDefault(setting, default)
	settingDefaults[setting] = default
end

local function setter(setting, value)
	if (not AucAdvancedConfig) then AucAdvancedConfig = {} end

	-- turn value into a canonical true or false
	if value == 'on' then
		value = true
	elseif value == 'off' then
		value = false
	end

	-- is the setting actually a function ref? if so call it.
	-- This was added to enable Protect Window to update its
	-- status without a UI reload by calling a function rather
	-- than a setting in the Control definition.
	if type(setting)=="function" then
		return setting("set", value)
	end

	--Store the value before we nil it to be used in callback
	local callbackValue = value
	-- for defaults, just remove the value and it'll fall through
	if (value == 'default') or (value == getDefault(setting)) then
		-- Don't save default values
		value = nil
	end

	local a,b,c = strsplit(".", setting)
	if (a == "profile") then
		if setting == "profile.save" or setting == "profile.duplicate" then
			-- User clicked either the New Profile or Copy Profile button
			value = gui.elements["profile.name"]:GetText()

			if value and value ~= "" then
				-- Create the new profile
				local newProfile
				if setting == "profile.duplicate" then
					local curName = gui.elements["profile"].value
					local curProfile = AucAdvancedConfig["profile."..curName]
					if curProfile then
						newProfile = replicate(curProfile)
					end
				end
				AucAdvancedConfig["profile."..value] = newProfile or {}

				-- Set the user profile to the new profile
				AucAdvancedConfig[getUserSig()] = value

				-- Add the new profile to the profiles list:-

				-- Check/create the profiles list
				local profiles = AucAdvancedConfig["profiles"]
				if (not profiles) then
					profiles = { "Default" }
					AucAdvancedConfig["profiles"] = profiles
				end

				-- Check to see if the new profile's name already exists
				local found = false
				for pos, name in ipairs(profiles) do
					if (name == value) then found = true break end
				end

				-- If not, add it and then sort it
				if (not found) then
					table.insert(profiles, value)
					table.sort(profiles)
				end
			else
				message(_TRANS("ADV_Help_InvalidProfileName")) --"Cannot create new profile: please enter a new profile name first"
				return
			end
		elseif (setting == "profile.delete") then
			-- User clicked the Delete button, see what the select box's value is.
			value = gui.elements["profile"].value

			-- If there's a profile name supplied
			if value and value ~= "Default" then -- don't let the user delete the Default profile!

				-- Delete its profile container
				AucAdvancedConfig["profile."..value] = nil

				-- Find its entry in the profiles list
				local profiles = AucAdvancedConfig["profiles"]
				if (profiles) then
					for pos, name in ipairs(profiles) do
						-- If this is it, then extract it
						if name == value then
							table.remove(profiles, pos)
						end
					end
				end

				-- If the user was using this one, then move them to Default
				if (getUserProfileName() == value) then
					AucAdvancedConfig[getUserSig()] = 'Default'
				end
			else
				message(_TRANS("ADV_Help_CannotDeleteProfile")) --"The selected profile cannot be deleted"
				return
			end
		elseif (setting == "profile.default") then
			-- User clicked the reset settings button

			-- Get the current profile from the select box
			value = gui.elements["profile"].value

			-- Overwrite with an empty profile
			AucAdvancedConfig["profile."..value] = {}

		elseif (setting == "profile") then
			-- User selected a different value in the select box, get it
			value = gui.elements["profile"].value

			-- Change the user's current profile to this new one
			AucAdvancedConfig[getUserSig()] = value

		end

		-- Refresh all values to reflect current data
		gui:Refresh()
	elseif (a == "matcher") then
		local matchers = AucAdvanced.Settings.GetSetting("matcherlist")
		local i = AucAdvanced.Settings.GetSetting("matcherdynamiclist")
		if i then
			i = strsplit(":", i)
			i = tonumber(i)
			if b == "up" and i > 1 then
				matchers[i], matchers[i-1] = matchers[i-1], matchers[i]
			elseif b == "down" and i < #matchers then
				matchers[i], matchers[i+1] = matchers[i+1], matchers[i]
			end
			AucAdvanced.Settings.SetSetting("matcherlist", matchers)
			for j = 1, #matchers do
				gui.elements["matcherdynamiclist"].list()[j] = AucAdvanced.API.GetMatcherDropdownList()[j]
			end
			AucAdvanced.Settings.SetSetting("matcherdynamiclist", 1)
			gui:Refresh()
		end
	else
		-- Set the value for this setting in the current profile
		local db = getUserProfile()
		if db[setting] == value then return end
		db[setting] = value
	end
	if setting == "uselocale" then--Stores the last user choosen locale so it can be used next time
		lib.SetSetting("SelectedLocale", value)
	end

	AucAdvanced.SendProcessorMessage("configchanged", setting, callbackValue)
end

function lib.SetSetting(...)
	setter(...)
	if (gui) then
		gui:Refresh()
	end
end


local function getter(setting)
	if (not AucAdvancedConfig) then AucAdvancedConfig = {} end
	if not setting then return end

	--Is the setting actually a function reference? If so, call it.
	-- This was added to enable Protect Window to update its
	-- status without a UI reload by calling a function rather
	-- than a setting in the Control definition.
	if type(setting)=="function" then
		return setting("getsetting")
	end

	local a,b,c = strsplit(".", setting)
	if (a == 'profile') then
		if (b == 'profiles') then
			local pList = AucAdvancedConfig["profiles"]
			if (not pList) then
				pList = { "Default" }
			end
			return pList
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

function lib.Show()
	lib.MakeGuiConfig()
	gui:Show()
end

function lib.Hide()
	if (gui) then
		gui:Hide()
	end
end

--[[ disabled function: currently broken and must not be called
function lib.UpdateGuiConfig()
	if gui then
		if gui:IsVisible() then
			gui:Hide()
		end
		gui = nil -- note: the old gui cannot be garbage collected
		lib.MakeGuiConfig()
	end
end
--]]

function lib.Toggle()
	if (gui and gui:IsShown()) then
		lib.Hide()
	else
		lib.Show()
	end
end

function lib.MakeGuiConfig()
	if gui then return end

	local id, last, cont
	local Configator = LibStub:GetLibrary("Configator")
	gui = Configator:Create(setter, getter)
	lib.Gui = gui
	gui:AddCat("Core Options")

	id = gui:AddTab("Profiles")

	gui:AddControl(id, "Header",     0,    _TRANS('ADV_Interface_SetupProfile')) --"Setup, Configure and Edit Profiles"
	gui:AddControl(id, "Subhead",    0,    _TRANS('ADV_Interface_ActivateProfile')) --"Activate a current profile"
	gui:AddControl(id, "Selectbox",  0, 1, "profile.profiles", "profile", "Switch to the given profile")
	gui:AddTip(id, _TRANS('ADV_Help_ActivateProfile')) --"Select the profile that you wish to use for this character"

	gui:AddControl(id, "Button",     0, 1, "profile.delete", _TRANS('ADV_Interface_Delete')) --"Delete"
	gui:AddTip(id, _TRANS('ADV_Help_DeleteProfile')) --"Deletes the currently selected profile"
	gui:AddControl(id, "Button",     0, 1, "profile.default", _TRANS("ADV_Interface_ResetProfile")) --"Reset"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_ResetProfile')) --"Reset all settings in the current profile to the default values"

	gui:AddControl(id, "Subhead",    0,    _TRANS('ADV_Interface_CreateProfile')) --"Create or replace a profile"
	gui:AddControl(id, "Text",       0, 1, "profile.name", _TRANS('ADV_Interface_ProfileName')) --"New profile name:"
	gui:AddTip(id, _TRANS('ADV_Help_ProfileName')) --"Enter the name of the profile that you wish to create"

	gui:AddControl(id, "Button",     0, 1, "profile.save", _TRANS('ADV_Interface_NewProfile')) --"New"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_NewProfile')) --"Create or overwrite a profile with the specified profile name. All settings will be reset to the default values."
	gui:AddControl(id, "Button",     0, 1, "profile.duplicate", _TRANS("ADV_Interface_CopyProfile")) --"Copy"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_CopyProfile')) --"Create or overwrite a profile with the specified profile name. All settings will be copied from the current profile.")

--localize AddHelp for Profiles
	gui:AddHelp(id, "what is",
		"What is a profile?",
		"A profile is used to contain a group of settings, you can use different profiles for different characters, or switch between profiles for the same character when doing different tasks."
	)
	gui:AddHelp(id, "how create",
		"How do I create a new profile?",
		"You enter the name of the new profile that you wish to create into the text box labelled \"New profile name\", and then click the \"New\" or \"Copy\" button. A profile may be called whatever you wish, but it should reflect the purpose of the profile so that you may more easily recall that purpose at a later date."
	)
	gui:AddHelp(id, "how delete",
		"How do I delete a profile?",
		"To delete a profile, simply select the profile you wish to delete with the drop-down selection box and then click the Delete button. You cannot delete the \"Default\" profile."
	)
	gui:AddHelp(id, "why delete",
		"Why would I want to delete a profile?",
		"You can delete a profile when you don't want to use it anymore. Deleting a profile will also affect any other characters who are using the profile."
	)

	id = gui:AddTab("General")
	gui:MakeScrollable(id)
	gui:AddControl(id, "Header",     0,    _TRANS('ADV_Interface_AucOptions')) --"Main Auctioneer Options"

	gui:AddControl(id, "Checkbox",   0, 1, "scandata.force", _TRANS('ADV_Interface_ScanDataForce')) --"Force load scan data"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_ScanDataForce')) --"Forces the scan data to load when Auctioneer is first loaded rather than on demand when first needed"

	gui:AddControl(id, "Checkbox",   0, 1, "scandata.summaryonfull", _TRANS('ADV_Interface_ScanDataSummaryFull')) --"Enables the display of the post scan summary"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_ScanDataSummaryFull')) --"Display the summation of an Auction House scan"
	gui:AddControl(id, "Checkbox",   0, 1, "scandata.summaryonpartial", _TRANS('ADV_Interface_ScanDataSummaryPartial')) --"Enables the display of the post scan summary"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_ScanDataSummaryPartial')) --"Display the summation of an Auction House scan"
	gui:AddControl(id, "Checkbox",   0, 1, "scandata.summaryonmicro", _TRANS('ADV_Interface_ScanDataSummaryMicro')) --"Enables the display of the post scan summary"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_ScanDataSummaryMicro')) --"Display the summation of an Auction House scan"

	gui:AddControl(id, "Checkbox",   0, 1, "clickhook.enable", _TRANS('ADV_Interface_SearchingClickHooks')) --"Enable searching click-hooks"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_SearchClickHooks')) --"Enables the click-hooks for searching"

	gui:AddControl(id, "Slider",     0, 1, "scancommit.speed", 1, 100, 1, _TRANS('ADV_Interface_ProcessingPriority')) --"Processing priority: %d"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_ProcessPriority')) --"Sets the processing priority of the scan data. Higher values take less time, but cause more lag"
	
	gui:AddControl(id, "Checkbox",   0, 1, "scancommit.progressbar", _TRANS('ADV_Interface_ProgressBar')) --"Enable processing progress bar"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_ProgressBar')) --"Displays a progress bar while Auctioneer is processing data"

	gui:AddControl(id, "Subhead",     0,    _TRANS('ADV_Interface_MatchOrder')) --"Matcher Order"
	last = gui:GetLast(id)
	Matcherdropdown = gui:AddControl(id, "Selectbox",  0, 1, AucAdvanced.API.GetMatcherDropdownList(), "matcherdynamiclist")
	gui:SetLast(id, last)
	gui:AddControl(id, "Button",     0.3,1, "matcher.up", _TRANS('ADV_Interface_Up')) --"Up"
	gui:SetLast(id, last)
	gui:AddControl(id, "Button",     0.45, 1, "matcher.down", _TRANS('ADV_Interface_Down')) --"Down"
	gui:AddControl(id, "Subhead",     0,	_TRANS('ADV_Interface_PreferredOutputFrame')) --"Preferred Output Frame"
	gui:AddControl(id, "Selectbox", 0, 1, AucAdvanced.configFramesList, "printwindow")
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_ChatOutputFrame')) --"This allows you to select which chat window Auctioneer prints its output to."

	gui:AddControl(id, "Subhead",     0,	_TRANS('ADV_Interface_PreferredLanguage')) --"Preferred Language"
	gui:AddControl(id, "Selectbox", 0, 1, AucAdvanced.changeLocale(), "uselocale")
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_PreferredLanguage')) --"Chooses the language used by Auctioneer. This will require a /console reloadui or restart to take full effect"

	gui:AddControl(id, "Subhead",     0,     _TRANS('ADV_Interface_PurchasingOptions')) --"Purchasing Options"
	gui:AddControl(id, "Checkbox",    0, 1,  "ShowPurchaseDebug", _TRANS('ADV_Interface_ShowPurchaseDebug')) --"Show purchase queue info"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_ShowPurchaseDebug')) --"Shows what is added to the purchase queue, and what is being purchased"
	
	gui:AddControl(id, "Subhead",     0,     _TRANS('ADV_Interface_PostingOptions')) --"Posting Options"
	gui:AddControl(id, "Checkbox",    0, 1,  "post.clearonclose", _TRANS('ADV_Interface_PostClearOnClose')) --"Clear the posting queue when the Auctionhouse is closed"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_PostClearOnClose')) --"When the Auctionhouse closes, cancels any auction requests queued up to be posted"
	gui:AddControl(id, "Checkbox",    0, 2,  "post.confirmonclose", _TRANS('ADV_Interface_PostConfirmOnClose')) --"Ask before clearing the posting queue"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_PostConfirmOnClose')) --"When the Auctionhouse closes, presents a popup dialog asking if you really want to clear the posting queue"

	gui:AddHelp(id, "what is scandata",
		_TRANS('ADV_Help_WhatIsScanData'), --"What is the scan data tooltip?"
		_TRANS('ADV_Help_WhatIsScanDataAnswer')) --"The scan data tooltip is a line that appears in your tooltip that informs you how many of the current item have been seen in the auction house image."
	gui:AddHelp(id, "what is image",
		_TRANS('ADV_Help_WhatIsImage'), --"What is an auction house image?"
		_TRANS('ADV_Help_WhatIsImageAnswer')) --"As you scan the auction house, Auctioneer builds up an image of what is at the auction. This is the image. It represents Auctioneer's best guess at what is currently being auctioned. If your scan is fresh, this will be reasonably accurate, if it is not a recent scan, then the info will not."
	gui:AddHelp(id, "what is exact",
		_TRANS('ADV_Help_WhatExactMatch'), --"What is an exact match?"
		_TRANS('ADV_Help_WhatExactMatchAnswer')) --"Some items can vary slightly by suffix (for example: of the Bear/Eagle/Ferret etc), or exact stats (eg.: two items both of the Bear, but have differing statistics). An exact match will not match anything that is not 100% the same."
	gui:AddHelp(id, "why force load",
		_TRANS('ADV_Help_WhyForceLoad'), --"Why would you want to force load the scan data?"
		_TRANS('ADV_Help_WhyForceLoadAnswer')) --"If you are going to be using the image data in the game, some people would prefer to wait longer for the game to start, rather than the game lagging for a couple of seconds when the data is demand loaded."
	gui:AddHelp(id, "why show summation",
		_TRANS('ADV_Help_WhyShowSummation'), --"What is the post scan summary?",
		_TRANS('ADV_Help_WhyShowSummationAnswer')) --"It displays the number of new, updated, or unchanged auctions gathered from a scan of the auction house."
	gui:AddHelp(id, "what is clickhook",
		_TRANS('ADV_Help_WhatClickHooks'), --"What are the click-hooks?",
		_TRANS('ADV_Help_WhatClickHooksAnswer')) --"The click-hooks let you perform a search for an item either by Alt-right-clicking the item in your bags, or by Alt-clicking an item link in the chat pane.")
	gui:AddHelp(id, "what is priority",
		_TRANS('ADV_Help_WhatPriority'), --"What is the Processing Priority?",
		_TRANS('ADV_Help_WhatPriorityAnswer')) --"The Processing Priority sets the speed to process the data at the end of the scan. Lower values will take longer, but will let you move around more easily.  Higher values will take less time, but may cause jitter.  Updated data will not be available until processing is complete."
	gui:AddHelp(id, "what is preferred output frame",
		_TRANS('ADV_Help_WhatPreferredChatFrame'), --"What is the Preferred Output Frame?",
		_TRANS('ADV_Help_WhatPreferredChatFrameAnswer')) --"The Preferred Output Frame allows you to designate which of your chat windows Auctioneer prints its output to.  Select one of the frames listed in the drop down menu and Auctioneer will print all subsequent output to that window."
	gui:AddHelp(id, "what is preferred language",
		_TRANS('ADV_Help_WhatPreferredLanguage'), --"What is the Preferred Language?",
		_TRANS('ADV_Help_WhatPreferredLanguageAnswer')) --"The Preferred Language allows you to designate which of the supported translations you want Auctioneer to use. This can be handy if you prefer auctioneer to use a diffrent locale than the game client. This requires a restart or /console reloadui"

	gui:AddHelp(id, "what is accuracy",
        _TRANS('ADV_Help_WhatAccuracy'), --"What is Market Pricing error?",
        _TRANS('ADV_Help_WhatAccuracyAnswer')) --"Market Pricing Error allows you to set the amount of error that will be tolerated while computing market prices. Because the algorithm is extremely complex, only an estimate can be made. Lowering this number will make the estimate more accurate, but will require more processing power (and may be slower for older computers)."

	--Tooltip category for all modules to add tooltip related settings too
	id = gui:AddTab("Tooltip")
	gui:MakeScrollable(id)
	lib.Gui.tooltipID = id
	gui:AddHelp(id, "what is the tooltip tab",
		_TRANS('ADV_Help_WhatTooltipTab'), --What is the tooltip tab?
		_TRANS('ADV_Help_WhatTooltipTabAnswer')) --This tab allows you to adjust what data gets displayed in the tooltips added by auctioneer. It provides a single point for any module to add settings that are related to tooltip functionality.
	
	gui:AddControl(id, "Header",   0,    _TRANS('ADV_Interface_TooltipDisplayOptionsOptions') ) --Tooltip Display Options
	gui:AddControl(id, "Subhead",    0,    _TRANS('ADV_Interface_ControlsShowHideTooltip') ) --Controls to show or hide tooltip information.
	gui:AddControl(id, "Note",       0, 1, nil, nil, " ")
	
	gui:AddControl(id, "Header",     0,    _TRANS('ADV_Interface_AucOptions')) --"Main Auctioneer Options"
	gui:AddControl(id, "Checkbox",   0, 1, "scandata.tooltip.display", _TRANS('ADV_Interface_ScanDataDisplay')) --"Display scan data tooltip"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_ScanDataDisplay')) --"Enable the display of how many items in the current scan image match this item"
	gui:AddControl(id, "Checkbox",   0, 3, "scandata.tooltip.modifier", _TRANS('ADV_Interface_ScanDataModifier')) --"Only show exact match unless SHIFT is held"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_ScanDataModifier')) --"Makes the scan data only display exact matches unless the shift key is held down"
	gui:AddControl(id, "Checkbox",		0, 1, 	"alwaysHomeFaction", _TRANS('ADV_Interface_AlwaysHomeFaction')) --"See home faction data everywhere unless at a neutral AH"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_AlwaysHomeFaction')) --"This allows the ability to see home data everywhere, however it disables itself while a neutral AH window is open to allow you to see the neutral AH data."
	gui:AddControl(id, "Checkbox", 0, 1, "ModTTShow", _TRANS('ADV_Interface_ModTTShow'))--"Only show Auctioneer's extra tooltip if Alt is pressed."
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_ModTTShow')) --"This option will hide Auctioneer's extra tooltip unless the Alt key is pressed"
	gui:AddControl(id, "Note",       0, 1, nil, nil, " ")
	
	gui:AddControl(id, "Header",     0,    _TRANS('ADV_Interface_MktPriceOptions')) --"Market Price Options"
	gui:AddControl(id, "Checkbox",   0, 1, "tooltip.marketprice.show", _TRANS('ADV_Interface_MktPriceShow')) --"Display Market Price in the tooltip"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_MktPrice')) --"Enables the display of Marketprice in the tooltip.  Holding down Shift will also show the prices that went into marketprice"
	gui:AddControl(id, "Checkbox",   0, 2, "tooltip.marketprice.stacksize", _TRANS('ADV_Interface_MultiplyStack')) --"Multiply by Stack Size"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_MultiplyStack')) --"Multiplies by current stack size if enabled"
	gui:AddControl(id, "Slider", 0, 1, "marketvalue.accuracy", 0.001, 1, 0.001, _TRANS('ADV_Interface_MarketValueAccuracy')) --"Market Pricing Error: %5.3f%%"
	gui:AddTip(id, _TRANS('ADV_HelpTooltip_MarketValueAccuracy')) --"Sets the accuracy of computations for market pricing. This indicates the maximum error that will be tolerated. Higher numbers reduce the amount of processing required by your computer (improving frame rate while calculating) at the cost of some accuracy."
	gui:AddControl(id, "Note",       0, 1, nil, nil, " ")

	gui:AddCat("Stat Modules")
  	gui:AddCat("Filter Modules")
  	gui:AddCat("Match Modules")
  	gui:AddCat("Util Modules")

	-- Alert all modules that the config screen is being built, so that they
	-- may place their own configuration should they desire it.
	AucAdvanced.SendProcessorMessage("config", gui)
end

local sideIcon
if LibStub then
	local SlideBar = LibStub:GetLibrary("SlideBar", true)
	if SlideBar then
		sideIcon = SlideBar.AddButton("AucAdvanced", "Interface\\AddOns\\Auc-Advanced\\Textures\\AucAdvIcon")
		sideIcon:RegisterForClicks("LeftButtonUp","RightButtonUp")
		sideIcon:SetScript("OnClick", lib.Toggle)
		sideIcon.tip = {
			"Auctioneer",
			"Auctioneer allows you to scan the auction house and collect statistics about prices.",
			"It also provides a framework for creating auction related addons.",
			"{{Click}} to edit the configuration.",
		}
	end
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Advanced/CoreSettings.lua $", "$Rev: 4640 $")
