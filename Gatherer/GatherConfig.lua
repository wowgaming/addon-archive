--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 3.1.14 (<%codename%>)
	Revision: $Id: GatherConfig.lua 754 2008-10-14 04:43:39Z Esamynn $

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
		You have an implicit licence to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

	Saved Variables Configuration and management code
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/release/Gatherer/GatherConfig.lua $", "$Rev: 754 $")

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

Gatherer.Settings = {}

local metatable = { __index = getfenv(0) }
setmetatable( Gatherer.Config, metatable )
setfenv(1, Gatherer.Config)

-- increment this number by 1 to wipe all of the user's current
-- settings when they upgrade
local SETTINGS_VERSION = 2

-- place any variables that the settings table should be
-- initialised with here
Default_Settings = {
}

local function getDefault(setting)
	if (setting == "inspect.enable")    then return false   end
	local a,b,c,d = strsplit(".", setting)
	if (a == "show") then 
		if (c == "all" or d == "all") then return false end
		if (d == "onlyiftracked") then return false end
		return true
	end
	if (a == "plugin" and c == "enable") then return false end
	if (b == "enable") then return true end
	if (b == "tooltip" and c == "rate" and d == "num") then return 5 end
	if (b == "tooltip") then return true end
	if (setting == "mainmap.count")     then return 600     end
	if (setting == "mainmap.opacity")   then return 80      end
	if (setting == "mainmap.iconsize")  then return 12      end
	if (setting == "minimap.count")     then return 20      end
	if (setting == "minimap.opacity")   then return 80      end
	if (setting == "minimap.iconsize")  then return 12      end
	if (setting == "minimap.distance")  then return 800     end
	if (setting == "miniicon.angle")    then return 270     end
	if (setting == "miniicon.distance") then return 12      end
	if (setting == "fade.distance")     then return 500     end
	if (setting == "fade.percent")      then return 20      end
	if (setting == "track.circle")      then return true    end
	if (setting == "track.style")       then return "White" end
	if (setting == "track.current")     then return true    end
	if (setting == "track.distance")    then return 110     end
	if (setting == "track.opacity")     then return 80      end
	if (setting == "inspect.tint")      then return true    end
	if (setting == "inspect.distance")  then return 25      end
	if (setting == "inspect.percent")   then return 80      end
	if (setting == "inspect.time")      then return 120     end
	if (setting == "anon.tint")         then return true    end
	if (setting == "anon.opacity")      then return 60      end
	if (setting == "guild.receive")     then return true    end
	if (setting == "guild.print.send")  then return false   end
	if (setting == "guild.print.recv")  then return true    end
	if (setting == "raid.receive")      then return true    end
	if (setting == "raid.print.send")   then return false   end
	if (setting == "raid.print.recv")   then return true    end
	if (setting == "personal.print")    then return false   end
	if (setting == "about.loaded")      then return false   end

	-- check for a plugin default
	for _, data in pairs(Gatherer.Plugins.Registrations) do
		local func = data.defaults
		if ( func and func(setting) ) then
			return func(setting)
		end
	end
end

--defines keys which are saved in the PerCharacter settings
PerCharacter = {
}

-- Note: This function WILL NOT handle self referencing table
-- structures correctly (ie. it will never terminate)
local function deepCopy( source, dest )
	for k, v in pairs(source) do
		if ( type(v) == "table" ) then
			if not ( type(dest[k]) == "table" ) then
				dest[k] = {}
			end
			deepCopy(v, dest[k])
		else
			dest[k] = v
		end
	end
end

function ConvertOldSettings( conversions )
	local Settings = Gatherer.Settings
	for pat, repl in pairs(conversions) do
		for name, profileData in pairs(Settings) do
			if ( name:sub(1, 8) == "profile." ) then
				local newSettings = {}
				for setting, value in pairs(profileData) do
					local new, count = setting:gsub(pat, repl)
					if ( count >= 1 ) then
						newSettings[new] = value
						profileData[setting] = nil
					end
				end
				for setting, value in pairs(newSettings) do
					profileData[setting] = value
				end
			end
		end
	end
end

local oldSettingsConversions = {
	["^hud%.(.*)$"] = "plugin.gatherer_hud.%1", -- convert old non-plugin HUD settings
}

--Load settings from the SavedVariables tables
function Load()
	local Settings = Gatherer.Settings
	deepCopy(Default_Settings, Settings)
	
	if ( Gatherer_SavedSettings_AccountWide and 
	     Gatherer_SavedSettings_AccountWide.SETTINGS_VERSION == SETTINGS_VERSION ) then
		deepCopy(Gatherer_SavedSettings_AccountWide, Settings)
	end

	if ( Gatherer_SavedSettings_PerCharacter and 
	     Gatherer_SavedSettings_PerCharacter.SETTINGS_VERSION == SETTINGS_VERSION ) then
		deepCopy(Gatherer_SavedSettings_PerCharacter, Settings)
	end

	ConvertOldSettings(oldSettingsConversions)

	-- Sharing Blacklist
	SharingBlacklist_Load()
end

--Save settings to the SavedVariables tables
-- Call this when the PLAYER_LOGOUT event fires or saved settings
-- will not be updated
function Save()
	local data = Gatherer.Settings

	local accountSettings = { SETTINGS_VERSION = SETTINGS_VERSION }
	for key in pairs(data) do
		accountSettings[key] = data[key]
	end
	_G.Gatherer_SavedSettings_AccountWide = accountSettings

	local characterSettings = { SETTINGS_VERSION = SETTINGS_VERSION }
	for _, key in pairs(PerCharacter) do
		characterSettings[key] = data[key]
	end
	_G.Gatherer_SavedSettings_PerCharacter = characterSettings

	SharingBlacklist_Save()
end

--*****************************************************************************
-- Settings Manipulation Functions
--*****************************************************************************

local function getUserSig()
	local userSig = string.format("users.%s.%s", GetRealmName(), UnitName("player"))
	return userSig
end

local function getUserProfileName()
	local SETTINGS = Gatherer.Settings
	local userSig = getUserSig()
	return SETTINGS[userSig] or "Default"
end

local itc = 0
local function getUserProfile()
	local SETTINGS = Gatherer.Settings
	local profileName = getUserProfileName()
	if (not SETTINGS["profile."..profileName]) then
		if profileName ~= "Default" then
			profileName = "Default"
			SETTINGS[getUserSig()] = "Default"
		end
		if profileName == "Default" then
			SETTINGS["profile."..profileName] = {}
		end
	end
	return SETTINGS["profile."..profileName]
end

local function cleanse( source )
	for k in pairs(source) do
		source[k] = nil
	end
end

local updateTracker = {}
local function setUpdated()
	for k in pairs(updateTracker) do
		updateTracker[k] = nil
	end
end

function Gatherer.Command.IsUpdated(what)
	if not updateTracker[what] then
		updateTracker[what] = true
		return true
	end
	return false
end

local function setter(setting, value)
	local SETTINGS = Gatherer.Settings
	local a,b,c = strsplit(".", setting)
	if (a == "profile") then
		local gui = Gatherer.Config.Gui
		if (setting == "profile.save") then
			value = gui.elements["profile.name"]:GetText()

			-- Create the new profile
			SETTINGS["profile."..value] = {}

			-- Set the current profile to the new profile
			SETTINGS[getUserSig()] = value
			-- Get the new current profile
			local newProfile = getUserProfile()
			-- Clean it out and then resave all data
			cleanse(newProfile)
			gui:Resave()

			-- Add the new profile to the profiles list
			local profiles = SETTINGS["profiles"]
			if (not profiles) then
				profiles = { "Default" }
				SETTINGS["profiles"] = profiles
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
			DEFAULT_CHAT_FRAME:AddMessage("Saved profile: "..value)
		elseif (setting == "profile.copy") then
			value = gui.elements["profile.name"]:GetText()

			local curprofile = getUserProfileName()
			-- Create the new profile
			SETTINGS["profile."..value] = SETTINGS["profile."..curprofile]

			-- Set the current profile to the new profile
			SETTINGS[getUserSig()] = value
			-- Get the new current profile
			local newProfile = getUserProfile()
			--[[-- Clean it out and then resave all data
			cleanse(newProfile)
			gui:Resave()
			--]]

			-- Add the new profile to the profiles list
			local profiles = SETTINGS["profiles"]
			if (not profiles) then
				profiles = { "Default" }
				SETTINGS["profiles"] = profiles
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
			DEFAULT_CHAT_FRAME:AddMessage("Saved profile: "..value)
		elseif (setting == "profile.delete") then
			-- User clicked the Delete button, see what the select box's value is.
			value = gui.elements["profile"].value

			-- If there's a profile name supplied
			if (value) then
				-- Clean it's profile container of values
				cleanse(SETTINGS["profile."..value])
				-- Delete it's profile container
				SETTINGS["profile."..value] = nil
				-- Find it's entry in the profiles list
				local profiles = SETTINGS["profiles"]
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
					SETTINGS[getUserSig()] = 'Default'
				end
				DEFAULT_CHAT_FRAME:AddMessage("Deleted profile: "..value)
			end
		elseif (setting == "profile") then
			-- User selected a different value in the select box, get it
			value = gui.elements["profile"].value

			-- Change the user's current profile to this new one
			SETTINGS[getUserSig()] = value
			DEFAULT_CHAT_FRAME:AddMessage("Changing profile: "..value)
		end

		-- Refresh all values to reflect current data
		gui:Refresh()
	
	else
		-- Set the value for this setting in the current profile
		local db = getUserProfile()
		db[setting] = value
		setUpdated()
		Gatherer.MiniNotes.Show()
		Gatherer.MapNotes.Update()
	end

	if ( a == "plugin" ) then
		if ( (c == "enable") and value ) then
			Gatherer.Plugins.LoadPlugin(b:lower())
		end
		local func = Gatherer.Plugins.ConfigUpdateFunctions[b]
		if ( func ) then
			func(setting, value)
		end
	end

	if (a == "miniicon") then
		Gatherer.MiniIcon.Reposition()
	end
	if (a == "minimap") then
		Gatherer.MiniIcon.Update()
	end
end
function SetSetting(...)
	local gui = Gatherer.Config.Gui
	setter(...)
	if (gui) then
		gui:Refresh()
	end
end
	

local function getter(setting)
	local SETTINGS = Gatherer.Settings
	if not setting then return end

	local a,b,c = strsplit(".", setting)
	if (a == 'profile') then
		if (b == 'profiles') then
			local pList = SETTINGS["profiles"]
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
function GetSetting(setting, default)
	local option = getter(setting)
	if ( option ~= nil ) then
		return option
	else
		return default
	end
end

function DisplayFilter_MainMap( nodeId )
	local nodeType = Gatherer.Nodes.Objects[nodeId]
	if not ( nodeType ) then
		return false
	end
	local skill = Gatherer.Var.Skills[nodeType]
	nodeType = nodeType:lower()
	local showType = "show.mainmap."..nodeType
	local showAll = showType..".all"
	local showObject = "show."..nodeType.."."..nodeId
	local isTracked = Gatherer.Util.IsNodeTracked
	local onlyIfTracked = getter("show.mainmap."..nodeType..".onlyiftracked")
	local onlyIfSkilled = getter("show.mainmap."..nodeType..".onlyifskilled")
	return (
		getter(showType) and
		(getter(showAll) or getter(showObject)) and
		((not onlyIfTracked) or isTracked(nodeId)) and
		((not onlyIfSkilled) or skill)
	)
end

function DisplayFilter_MiniMap( nodeId )
	local nodeType = Gatherer.Nodes.Objects[nodeId]
	if not ( nodeType ) then
		return false
	end
	local skill = Gatherer.Var.Skills[nodeType]
	nodeType = nodeType:lower()
	local showType = "show.minimap."..nodeType
	local showAll = showType..".all"
	local showObject = "show."..nodeType.."."..nodeId
	local isTracked = Gatherer.Util.IsNodeTracked
	local onlyIfTracked = getter("show.minimap."..nodeType..".onlyiftracked")
	local onlyIfSkilled = getter("show.minimap."..nodeType..".onlyifskilled")
	return (
		getter(showType) and
		(getter(showAll) or getter(showObject)) and
		((not onlyIfTracked) or isTracked(nodeId)) and
		((not onlyIfSkilled) or skill)
	)
end

function ShowOptions()
	MakeGuiConfig()
	Gatherer.Report.Hide()
	Gui:Show()
end

function HideOptions()
	if ( Gui ) then
		Gui:Hide()
	end
end

function ToggleOptions()
	if ( Gui and Gui:IsShown() ) then
		HideOptions()
	else
		ShowOptions()
	end
end

function MakeGuiConfig()
	if ( Gui ) then return end

	local id, last, cont
	local Configator = LibStub:GetLibrary("Configator")
	local gui = Configator:Create(setter, getter)
	Gui = gui

	gui:AddCat( _trL("Core Options"), nil, false, true)
	
	id = gui:AddTab( _trL("Profiles"))
	gui:AddControl(id, "Header",     0,    _trL("Setup, configure and edit profiles"))
	gui:AddControl(id, "Subhead",    0,    _trL("Activate a current profile"))
	gui:AddControl(id, "Selectbox",  0, 1, "profile.profiles", "profile", _trL("Switch to given profile"))
	gui:AddControl(id, "Button",     0, 1, "profile.delete", _trL("Delete"))
	gui:AddControl(id, "Subhead",    0,    _trL("Create or replace a profile"))
	gui:AddControl(id, "Text",       0, 1, "profile.name", _trL("New profile name:"))
	gui:AddControl(id, "Button",     0, 1, "profile.save", _trL("Create new"))
	gui:AddControl(id, "Button",     0, 1, "profile.copy", _trL("Create copy"))
	
	id = gui:AddTab(_trL("General"))
	gui:AddControl(id, "Header",     0,    _trL("Main Gatherer options"))
	last = gui:GetLast(id) -- Get the current position so we can return here for the second column

	gui:AddControl(id, "Subhead",    0,    _trL("WorldMap options"))
	gui:AddControl(id, "Checkbox",   0, 1, "mainmap.enable", _trL("Display nodes on WorldMap"))
	gui:AddControl(id, "Slider",     0, 2, "mainmap.count", 10, 1000, 10, _trL("Display: %d nodes"))
	gui:AddControl(id, "Slider",     0, 2, "mainmap.opacity", 10, 100, 2, _trL("Opacity: %d%%"))
	gui:AddControl(id, "Slider",     0, 2, "mainmap.iconsize", 4, 64, 1, _trL("Icon size: %d"))
	gui:AddControl(id, "Checkbox",   0, 1, "mainmap.tooltip.enable", _trL("Display tooltips"))
	gui:AddControl(id, "Checkbox",   0, 2, "mainmap.tooltip.count", _trL("Display harvest counts"))
	gui:AddControl(id, "Checkbox",   0, 2, "mainmap.tooltip.source", _trL("Display note source"))
	gui:AddControl(id, "Checkbox",   0, 2, "mainmap.tooltip.seen", _trL("Display last seen time"))
	gui:AddControl(id, "Checkbox",   0, 2, "mainmap.tooltip.rate", _trL("Display drop rates"))

	gui:AddControl(id, "Subhead",  0,    _trL("Note:"))
	gui:AddControl(id, "Note",     0, 1, 290, 60, _trL("The \"All\" options cause the current filters to be ignored and force all nodes in that category to be shown."))

	gui:SetLast(id, last) -- Return to the saved position
	gui:AddControl(id, "Subhead",  0.5,    _trL("Minimap tracking options"))
	local curpos = gui:GetLast(id)
	gui:AddControl(id, "Checkbox", 0.5, 1, "show.minimap.mine", _trL("Show mining nodes"))
	gui:SetLast(id, curpos)
	gui:AddControl(id, "Checkbox", 0.85, 1, "show.minimap.mine.all", _trL("All"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.minimap.mine.onlyifskilled", _trL("Miners Only"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.minimap.mine.onlyiftracked", _trL("Only if tracking"))
	curpos = gui:GetLast(id)
	gui:AddControl(id, "Checkbox", 0.5, 1, "show.minimap.herb", _trL("Show herbalism nodes"))
	gui:SetLast(id, curpos)
	gui:AddControl(id, "Checkbox", 0.85, 1, "show.minimap.herb.all", _trL("All"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.minimap.herb.onlyifskilled", _trL("Herbalists Only"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.minimap.herb.onlyiftracked", _trL("Only if tracking"))
	curpos = gui:GetLast(id)
	gui:AddControl(id, "Checkbox", 0.5, 1, "show.minimap.open", _trL("Show treasure nodes"))
	gui:SetLast(id, curpos)
	gui:AddControl(id, "Checkbox", 0.85, 1, "show.minimap.open.all", _trL("All"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.minimap.open.onlyiftracked", _trL("Only if tracking"))

	gui:AddControl(id, "Subhead",  0.5,    _trL("WorldMap tracking options"))
	curpos = gui:GetLast(id)
	gui:AddControl(id, "Checkbox", 0.5, 1, "show.mainmap.mine", _trL("Show mining nodes"))
	gui:SetLast(id, curpos)
	gui:AddControl(id, "Checkbox", 0.85, 1, "show.mainmap.mine.all", _trL("All"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.mainmap.mine.onlyifskilled", _trL("Miners Only"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.mainmap.mine.onlyiftracked", _trL("Only if tracking"))
	curpos = gui:GetLast(id)
	gui:AddControl(id, "Checkbox", 0.5, 1, "show.mainmap.herb", _trL("Show herbalism nodes"))
	gui:SetLast(id, curpos)
	gui:AddControl(id, "Checkbox", 0.85, 1, "show.mainmap.herb.all", _trL("All"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.mainmap.herb.onlyifskilled", _trL("Herbalists Only"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.mainmap.herb.onlyiftracked", _trL("Only if tracking"))
	curpos = gui:GetLast(id)
	gui:AddControl(id, "Checkbox", 0.5, 1, "show.mainmap.open", _trL("Show treasure nodes"))
	gui:SetLast(id, curpos)
	gui:AddControl(id, "Checkbox", 0.85, 1, "show.mainmap.open.all", _trL("All"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.mainmap.open.onlyiftracked", _trL("Only if tracking"))

	id = gui:AddTab(_trL("Minimap"))
	gui:AddControl(id, "Header",     0,    _trL("Minimap Gatherer options"))
	last = gui:GetLast(id) -- Get the current position so we can return here for the second column

	gui:AddControl(id, "Subhead",    0,    _trL("Minimap options"))
	gui:AddControl(id, "Checkbox",   0, 1, "minimap.enable", _trL("Display nodes on Minimap"))
	gui:AddControl(id, "Slider",     0, 2, "minimap.count", 1, 50, 1, _trL("Display: %d closest"))
	gui:AddControl(id, "Slider",     0, 2, "minimap.opacity", 0, 100, 1, _trL("Default opacity: %d%%"))
	gui:AddControl(id, "Slider",     0, 2, "minimap.iconsize", 4, 64, 1, _trL("Icon size: %d"))
	gui:AddControl(id, "Slider",     0, 2, "minimap.distance", 100, 5000, 50, _trL("Distance: %d yards"))
	gui:AddControl(id, "Checkbox",   0, 1, "miniicon.enable", _trL("Display Minimap button"))
	gui:AddControl(id, "Slider",     0, 2, "miniicon.angle", 0, 360, 1, _trL("Button angle: %d"))
	gui:AddControl(id, "Slider",     0, 2, "miniicon.distance", -80, 80, 1, _trL("Distance: %d"))
	gui:AddControl(id, "Checkbox",   0, 1, "minimap.tooltip.enable", _trL("Display tooltips"))
	gui:AddControl(id, "Checkbox",   0, 2, "minimap.tooltip.count", _trL("Display harvest counts"))
	gui:AddControl(id, "Checkbox",   0, 2, "minimap.tooltip.source", _trL("Display note source"))
	gui:AddControl(id, "Checkbox",   0, 2, "minimap.tooltip.seen", _trL("Display last seen time"))
	gui:AddControl(id, "Checkbox",   0, 2, "minimap.tooltip.distance", _trL("Display node distance"))
	gui:AddControl(id, "Checkbox",   0, 2, "minimap.tooltip.rate", _trL("Display drop rates"))

	gui:SetLast(id, last) -- Return to the saved position
	gui:AddControl(id, "Subhead",   0.5,    _trL("Minimap additional"))
	gui:AddControl(id, "Checkbox",  0.5, 1, "fade.enable", _trL("Fade out mininotes"));
	gui:AddControl(id, "Slider",    0.5, 2, "fade.distance", 10, 1000, 10, _trL("Fade at: %d yards"))
	gui:AddControl(id, "Slider",    0.5, 2, "fade.percent", 0, 100, 1, _trL("Distance fading: %d%%"))
	gui:AddControl(id, "Checkbox",  0.5, 1, "track.enable", _trL("Enable tracking skill feature"));
	gui:AddControl(id, "Checkbox",  0.5, 2, "track.circle", _trL("Convert to tracking icon when close"));
	gui:AddControl(id, "Selectbox", 0.5, 3, "track.styles", "track.style", _trL("Tracking icon"));
	gui:AddControl(id, "Checkbox",  0.5, 2, "track.current", _trL("Only for active tracking skill"));
	gui:AddControl(id, "Slider",    0.5, 2, "track.distance", 50, 150, 1, _trL("Track at: %d yards"))
	gui:AddControl(id, "Slider",    0.5, 2, "track.opacity", 0, 100, 1, _trL("Icon opacity: %d%%"))
	gui:AddControl(id, "Checkbox",  0.5, 1, "inspect.enable", _trL("Mark nodes as inspected"));
	gui:AddControl(id, "Checkbox",  0.5, 2, "inspect.tint", _trL("Tint green while inspecting"));
	gui:AddControl(id, "Slider",    0.5, 2, "inspect.distance", 1, 100, 1, _trL("Inspect at: %d yards"))
	gui:AddControl(id, "Slider",    0.5, 2, "inspect.percent", 0, 100, 1, _trL("Inspected fading: %d%%"))
	gui:AddControl(id, "Slider",    0.5, 2, "inspect.time", 10, 900, 10, _trL("Reinspect: %d seconds"))
	gui:AddControl(id, "Checkbox",  0.5, 1, "anon.enable", _trL("Display anonymous nodes"));
	gui:AddControl(id, "Checkbox",  0.5, 2, "anon.tint", _trL("Tint anonymous nodes red"));
	gui:AddControl(id, "Slider",    0.5, 2, "anon.opacity", 0, 100, 1, _trL("Anon opacity: %d%%"));

	id = gui:AddTab(_trL("Sharing"))
	gui:AddControl(id, "Header",     0,    _trL("Synchronization options"))
	last = gui:GetLast(id) -- Get the current position so we can return here for the second column

	gui:AddControl(id, "Subhead",    0,    _trL("Guild sharing"))
	gui:AddControl(id, "Checkbox",   0, 1, "guild.enable", _trL("Enable guild synchronization"))
	gui:AddControl(id, "Checkbox",   0, 2, "guild.receive", _trL("Add received guild gathers to my database"))
	gui:AddControl(id, "Checkbox",   0, 2, "guild.print.send", _trL("Print a message when sending a guild gather"))
	gui:AddControl(id, "Checkbox",   0, 2, "guild.print.recv", _trL("Print a message when receiving a guild gather"))

	gui:AddControl(id, "Subhead",    0,    _trL("Raid/Party sharing"))
	gui:AddControl(id, "Checkbox",   0, 1, "raid.enable", _trL("Enable raid synchronization"))
	gui:AddControl(id, "Checkbox",   0, 2, "raid.receive", _trL("Add received raid gathers to my database"))
	gui:AddControl(id, "Checkbox",   0, 2, "raid.print.send", _trL("Print a message when sending a raid gather"))
	gui:AddControl(id, "Checkbox",   0, 2, "raid.print.recv", _trL("Print a message when receiving a raid gather"))
	
	gui:AddControl(id, "Subhead",    0,    _trL("Personal Alert"))
	gui:AddControl(id, "Checkbox",   0, 1, "personal.print", _trL("Print a message when adding own gather to DB"))

	gui:SetLast(id, last) -- Return to the saved position
	gui:AddControl(id, "Subhead", 0.55,    _trL("Sharing Blacklist"))
	gui:AddControl(id, "Custom",  0.55, 0, Gatherer_SharingBlacklistFrame); Gatherer_SharingBlacklistFrame:SetParent(gui.tabs[id][3])

	-- Get all objects and insert them into the appropriate subtable
	local itemLists = {}
	local namesSeen = {}
	for name, objid in pairs(Gatherer.Nodes.Names) do
		name = Gatherer.Util.GetNodeName(objid)
		local gtype = Gatherer.Nodes.Objects[objid]:lower()
		if not ( namesSeen[gtype..name] ) then
			namesSeen[gtype..name] = true
			if (not itemLists[gtype]) then itemLists[gtype] = {} end
			local entry = { objid, name }
			local cat = Gatherer.Categories.ObjectCategories[objid]
			if (cat) then
				local skill = Gatherer.Constants.SkillLevel[cat]
				if (skill) then
					table.insert(entry, skill)
				end
			end
			table.insert(itemLists[gtype], entry)
		end
	end

	function entrySort(a, b)
		if (b == nil) then return nil end

		local aName = a[2]
		local bName = b[2]
		local aLevel = a[3]
		local bLevel = b[3]

		if bLevel then
			if aLevel then
				if aLevel < bLevel then return true end
				if bLevel < aLevel then return false end
			else
				return true
			end
		elseif aLevel then
			return false
		end
		local comp = aName < bName
		return comp
	end

	-- Print out tabs and checkboxes for the above list
	id = gui:AddTab(_trL("Mining"))
	gui:MakeScrollable(id)
	gui:AddControl(id, "Header",     0,    _trL("Mining filter options"))
	gui:AddControl(id, "Subhead",    0,    _trL("Mineral nodes to track"))
	local options = {}
	local list = itemLists.mine
	table.sort(list, entrySort)
	for pos, mine in pairs(list) do
		table.insert(options, { "show.mine."..mine[1], mine[2] })
	end
	gui:ColumnCheckboxes(id, 1, options)


	id = gui:AddTab(_trL("Herbalism"))
	gui:MakeScrollable(id)
	gui:AddControl(id, "Header",     0,    _trL("Herbalism filter options"))
	gui:AddControl(id, "Subhead",    0,    _trL("Herbal nodes to track"))
	local options = {}
	local list = itemLists.herb
	table.sort(list, entrySort)
	for pos, herb in pairs(list) do
		table.insert(options, { "show.herb."..herb[1], herb[2] })
	end
	gui:ColumnCheckboxes(id, 1, options)

	id = gui:AddTab(_trL("Treasure"))
	gui:MakeScrollable(id)
	gui:AddControl(id, "Header",     0,    _trL("Treasure filter options"))
	last = gui:AddControl(id, "Subhead",    0,    _trL("Treasure nodes to track"))
	local options = {}
	local list = itemLists.open
	table.sort(list, entrySort)
	for pos, open in pairs(list) do
		table.insert(options, { "show.open."..open[1], open[2] })
	end
	gui:ColumnCheckboxes(id, 1, options)

	id = gui:AddTab(_trL("About"))
	gui:AddControl(id, "Header",   0,           _trL("About Gatherer"))
	gui:AddControl(id, "Checkbox", 0, 0, "about.loaded", _trL("Show Loaded Message"))
	gui:AddControl(id, "Subhead",  0,            _tr("This is Gatherer v%1.", Gatherer.Var.Version))
	gui:AddControl(id, "Note", 0,  1, 600, nil, _trL("Gatherer is open source software and is licensed under the GNU General Public License v2.  Please see gpl.txt, included with this AddOn, for the full license."))

	-- Create Plugins Section
	gui:AddCat("PLUGINS", _trL("Plugins"), true, true)
	for name, data in pairs(Gatherer.Plugins.Data) do
		local id = gui:AddTab(data.tabName)
		name = name:lower()
		gui:AddControl(id, "Checkbox",   0, 1, "plugin."..name..".enable", _trL("Enable"))
		gui:AddControl(id, "Header",     0,    data.title)
		gui:AddControl(id, "Note",       0, 1, 580, nil, data.notes)
		if ( Gatherer.Plugins.Registrations[name] ) then
			Gatherer.Plugins.Registrations[name].makeConfig(gui)
		end
	end

	-- Any callbacks?
	for name, callback in pairs(GuiHook) do
		callback(gui)
	end
end

GuiHook = {}

function AddCallback(name, callback)
	if (Gui) then 
		callback(Gui)
		return
	end
	
	GuiHook[name] = callback
end

--**************************************
-- Blacklist Frame Functionality
--**************************************

local numIgnoreButtons = 18
SharingBlacklist = {}
SelectedIgnore = 1
LastIgnoredPlayer = nil

function SharingBlacklist_IsPlayerIgnored( name )
	if ( SharingBlacklist[name] ) then
		return true
	else
		return false
	end
end

function SharingBlacklist_Update()
	local numIgnores = #SharingBlacklist
	local nameText;
	local name;
	local ignoreButton;
	if ( numIgnores > 0 ) then
		if ( SelectedIgnore == 0 ) then
			SelectedIgnore = 1
		end
		Gatherer_SharingBlacklist_StopIgnoreButton:Enable();
	else
		Gatherer_SharingBlacklist_StopIgnoreButton:Disable();
	end

	local ignoreOffset = FauxScrollFrame_GetOffset(Gatherer_SharingBlacklist_ScrollFrame);
	local ignoreIndex;
	for i=1, numIgnoreButtons, 1 do
		ignoreIndex = i + ignoreOffset;
		ignoreButton = getglobal("Gatherer_SharingBlacklist_IgnoreButton"..i);
		ignoreButton:SetText(SharingBlacklist[ignoreIndex] or "");
		ignoreButton:SetID(ignoreIndex);
		-- Update the highlight
		if ( ignoreIndex == SelectedIgnore ) then
			ignoreButton:LockHighlight();
		else
			ignoreButton:UnlockHighlight();
		end
		
		if ( ignoreIndex > numIgnores ) then
			ignoreButton:Hide();
		else
			ignoreButton:Show();
		end
	end
	
	-- ScrollFrame stuff
	FauxScrollFrame_Update(Gatherer_SharingBlacklist_ScrollFrame, numIgnores, numIgnoreButtons, 16);
end

function Blacklist_IgnoreButton_OnClick( button )
	SelectedIgnore = button:GetID()
	SharingBlacklist_Update()
end

function Blacklist_UnignoreButton_OnClick( button )
	local name = SharingBlacklist[SelectedIgnore]
	SharingBlacklist_Remove(name)
end

function SharingBlacklist_Load()
	if ( Gatherer_SharingBlacklist ) then
		SharingBlacklist = Gatherer_SharingBlacklist
	end
	for i, name in ipairs(SharingBlacklist) do
		SharingBlacklist[name] = i
	end
	SharingBlacklist_Update()
end

function SharingBlacklist_Save()
	for key in pairs(SharingBlacklist) do
		if not ( type(key) == "number" ) then
			SharingBlacklist[key] = nil
		end
	end
	_G.Gatherer_SharingBlacklist = SharingBlacklist
end

function SharingBlacklist_Add( name )
	-- name validity checks
	if ( (not name) or name == "" ) then return end
	if ( #name < 2 ) then return end
	name = name:sub(1,1):upper()..name:sub(2)
	local currentSelection = SharingBlacklist[SelectedIgnore]

	if not ( SharingBlacklist[name] ) then
		table.insert(SharingBlacklist, name)
		LastIgnoredPlayer = name
		StaticPopup_Show("GATHERER_REMOVE_BLACKLISTED_NODES")
	end
	table.sort(SharingBlacklist)
	for i, name in ipairs(SharingBlacklist) do
		SharingBlacklist[name] = i
	end
	SelectedIgnore = SharingBlacklist[currentSelection] or 1
	SharingBlacklist_Update()
end

function SharingBlacklist_Remove( name )
	if ( SharingBlacklist[name] ) then
		SharingBlacklist[name] = nil
		for i, ignoreName in ipairs(SharingBlacklist) do
			if ( ignoreName == name ) then
				table.remove(SharingBlacklist, i)
			end
		end
		SelectedIgnore = 1
	end
	table.sort(SharingBlacklist)
	for i, name in ipairs(SharingBlacklist) do
		SharingBlacklist[name] = i
	end
	SharingBlacklist_Update()
end

function SharingBlacklist_RemoveBlacklistedNodes()
	if ( LastIgnoredPlayer ) then
		local numRemoved = 0
		for i, continent in Gatherer.Storage.GetAreaIndices() do
			for i, zone in Gatherer.Storage.GetAreaIndices(continent) do
				for gatherId in Gatherer.Storage.ZoneGatherNames(continent, zone) do
					local result, count = Gatherer.Storage.RemoveGather(continent, zone, gatherId, LastIgnoredPlayer)
					numRemoved = numRemoved + count
				end
			end
		end
		if ( numRemoved > 0 ) then
			PlaySound("igQuestLogAbandonQuest");
			Gatherer.MiniNotes.ForceUpdate()
			StaticPopup_Show("GATHERER_REMOVED_NODE_COUNT", numRemoved)
		end
	end
	LastIgnoredPlayer = nil
end

function SharingBlacklist_CountBlacklistedNodes()
	local count = 0
	if ( LastIgnoredPlayer ) then
		local storage = Gatherer.Storage
		for i, continent in storage.GetAreaIndices() do
			for i, zone in storage.GetAreaIndices(continent) do
				for gatherId in storage.ZoneGatherNames(continent, zone) do
					for _, _, _, _, _, _, source in storage.ZoneGatherNodes( continent, zone, gatherId ) do
						if ( source == LastIgnoredPlayer ) then
							count = count + 1
						end
					end
				end
			end
		end
	end
	return count
end

StaticPopupDialogs["GATHERER_ADD_SHARING_IGNORE"] = {
	text = _trL("ADD_IGNORE_LABEL"),
	button1 = _trL("ACCEPT"),
	button2 = _trL("CANCEL"),
	hasEditBox = 1,
	maxLetters = 12,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		SharingBlacklist_Add(editBox:GetText());
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsShown() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local name = getglobal(this:GetParent():GetName().."EditBox"):GetText();
		this:GetParent():Hide();
		SharingBlacklist_Add(name);
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["GATHERER_REMOVE_BLACKLISTED_NODES"] = {
	text = _trL("Do you wish to remove all nodes that have been shared by this player?"),
	button1 = _trL("YES"),
	button2 = _trL("NO"),
	OnAccept = function()
		StaticPopup_Show("GATHERER_CONFIRM_REMOVE_BLACKLISTED_NODES", SharingBlacklist_CountBlacklistedNodes())
	end,
	timeout = 0,
	whileDead = 1,
	exclusive = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["GATHERER_CONFIRM_REMOVE_BLACKLISTED_NODES"] = {
	text = _trL("Are you sure you wish to purge all shares from this player from your database?  This operation CANNOT be undone and will remove %d node(s) from your Gatherer database."),
	button1 = _trL("YES"),
	button2 = _trL("NO"),
	OnAccept = function()
		SharingBlacklist_RemoveBlacklistedNodes()
	end,
	timeout = 0,
	whileDead = 1,
	exclusive = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["GATHERER_REMOVED_NODE_COUNT"] = {
	text = _trL("%d node(s) have been permenently removed from your Gatherer database."),
	button1 = _trL("ACCEPT"),
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};
