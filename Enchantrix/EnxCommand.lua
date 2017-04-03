--[[
	Enchantrix Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: EnxCommand.lua 4051 2009-02-08 04:17:50Z ccox $
	URL: http://enchantrix.org/

	Slash command and GUI functions.

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
]]
Enchantrix_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Enchantrix/EnxCommand.lua $", "$Rev: 4051 $")

-- Global functions
local addonLoaded				-- Enchantrix.Command.AddonLoaded()
local auctioneerLoaded			-- Enchantrix.Command.AuctioneerLoaded()
local handleCommand				-- Enchantrix.Command.HandleCommand()

-- Local functions
local chatPrintHelp
local onOff
local clear
local default
local genVarSet

local tooltip = LibStub("nTipHelper:1")

-- GUI Init Variables (Added by MentalPower)
Enchantrix.State.GUI_Registered = nil


function addonLoaded()
end

function auctioneerLoaded()

	-- Make sure we have a usable version of Auctioneer loaded (3.4 or higher)

	if AucAdvanced and AucAdvanced.Version then
		local major,minor,patch,revision = strsplit('.', AucAdvanced.Version, 4)
		local major = tonumber(major) or 0
		local minor = tonumber(minor) or 0
		if patch == "DEV" then
			minor = minor + 1
			patch = 0
			revision = 0
		end

		if major >= 5 then
			Enchantrix.State.Auctioneer_Loaded = true
			Enchantrix.State.Auctioneer_Five = true
		end

	elseif Auctioneer and Auctioneer.Version then
		local major,minor,patch,revision = strsplit('.', Auctioneer.Version, 4)
		local major = tonumber(major) or 0
		local minor = tonumber(minor) or 0
		if patch == "DEV" then
			minor = minor + 1
			patch = 0
			revision = 0
		end

		if major >= 5 then
			Enchantrix.State.Auctioneer_Loaded = true
			Enchantrix.State.Auctioneer_Five = true
		elseif major > 3 or (major == 3 and minor >= 4) then
			Enchantrix.State.Auctioneer_Loaded = true
		end
	end

	if not Enchantrix.State.Auctioneer_Loaded then

		-- Don't complain if we are still waiting for Auctioneer to load
		local aucLoadPending =    (not Auctioneer and Stubby.GetConfig("Auctioneer", "LoadType") == "always")
		                       or (not AucAdvanced and Stubby.GetConfig("Auc-Advanced", "LoadType") == "always")

		if not aucLoadPending then
			-- Old version of Auctioneer
			if not EnchantConfig.displayedAuctioneerWarning then
				-- Yell at the user, but only once
				message(_ENCH('MesgAuctVersion'))
				EnchantConfig.displayedAuctioneerWarning = true
			else
				Enchantrix.Util.ChatPrint(_ENCH('MesgAuctVersion'))
			end
		end

		return
	end

-- ccox - with this enabled, we'll warn the user every single time they log in
-- that's very, very annoying
--	EnchantConfig.displayedAuctioneerWarning = nil

end


-- TODO - ccox - merge this somewhere sane
-- we have too many locations for these commands
-- can we use commandmap for this?

local commandToSettingLookup = {
--	['terse'] = 'ToolTipTerseFormat',
	['embed'] = 'ToolTipEmbedInGameTip',
	['valuate'] = 'TooltipShowValues',
	['valuate-hsp'] = 'TooltipShowAuctValueHSP',
	['valuate-median'] = 'TooltipShowAuctValueMedian',
	['valuate-baseline'] = 'TooltipShowBaselineValue',
	['levels'] = 'TooltipShowDisenchantLevel',
	['materials'] = 'TooltipShowDisenchantMats',
}

-- Cleaner Command Handling Functions (added by MentalPower)
function handleCommand(command, source)

	-- To print or not to print, that is the question...
	local chatprint = nil;
	if (source == "GUI") then
		chatprint = false;
	else
		chatprint = true;
	end;

	-- Divide the large command into smaller logical sections (Shameless copy from the original function)
	local cmd, param, param2 = command:match("^([%w%-]+)%s*([^%s]*)%s*(.*)$");

	cmd = cmd or command or ""
	param = param or ""
	param2 = param2 or ""

	--delocalize the command so we can work on it in English in here
	cmd = Enchantrix.Locale.DelocalizeCommand(cmd);

	if ((cmd == "") or (cmd == "help")) then
		-- /enchantrix help
		chatPrintHelp();
		return;

	elseif ((cmd == "on") or (cmd == "off") or (cmd == "toggle")) then
		-- /enchantrix on|off|toggle
		onOff(cmd, chatprint);

	elseif (cmd == 'disable') then
		-- /enchantrix disable
		Enchantrix.Util.ChatPrint(_ENCH('MesgDisable'));
		Stubby.SetConfig("Enchantrix", "LoadType", "never");

	elseif (cmd == 'load') then
		-- /enchantrix load always|never
		if (param == "always") or (param == "never") then
			Stubby.SetConfig("Enchantrix", "LoadType", param);
			if (chatprint) then
				Enchantrix.Util.ChatPrint("Setting Enchantrix to "..param.." load for this toon");
			end
		end

	elseif (cmd == 'show' or cmd == 'config') then
		-- show or hide our settings UI
		Enchantrix.Settings.MakeGuiConfig()
		local gui = Enchantrix.Settings.Gui
		if (gui:IsVisible()) then
			gui:Hide()
		else
			gui:Show()
		end

	elseif (cmd == 'clear') then
		-- /enchantrix clear
		clear(param, chatprint);

	elseif (cmd == 'locale') then
		-- /enchantrix locale
		Enchantrix.Config.SetLocale(param, chatprint);

	elseif (cmd == 'default') then
		-- /enchantrix default
		default(param, chatprint);

	elseif (cmd == 'print-in') then
		-- /enchantrix print-in
		Enchantrix.Config.SetFrame(param, chatprint)

	else

		-- lookup conversion to internal variable names
		if (commandToSettingLookup[cmd]) then
			cmd = commandToSettingLookup[cmd];
		end

		-- try direct access
		if (Enchantrix.Settings.GetDefault(cmd) ~= nil) then
			genVarSet(cmd, param, chatprint);

		elseif (chatprint) then
			Enchantrix.Util.ChatPrint(_ENCH('FrmtActUnknown'):format(cmd));
		end
	end
end

-- Help ME!! (The Handler) (Another shameless copy from the original function)
function chatPrintHelp()
	Enchantrix.Util.ChatPrint(_ENCH('FrmtUsage'));
	local onOffToggle = " (".._ENCH('CmdOn').."||".._ENCH('CmdOff').."||".._ENCH('CmdToggle')..")"
	local lineFormat = "  |cffffffff/enchantrix %s "..onOffToggle.."|r |cff2040ff[%s]|r - %s"

	Enchantrix.Util.ChatPrint("  |cffffffff/enchantrix "..onOffToggle.."|r |cff2040ff["..Enchantrix.Locale.GetLocalizedFilterVal('all').."]|r - " .. _ENCH('HelpOnoff'));
	Enchantrix.Util.ChatPrint("  |cffffffff/enchantrix ".._ENCH('CmdDisable').."|r - " .. _ENCH('HelpDisable'));
	Enchantrix.Util.ChatPrint("  |cffffffff/enchantrix ".._ENCH('ConfigUI').."|r - " .. _ENCH('HelpShowUI'));

	Enchantrix.Util.ChatPrint(lineFormat:format(_ENCH('ShowEmbed'), Enchantrix.Locale.GetLocalizedFilterVal('embed'), _ENCH('HelpEmbed')));
	Enchantrix.Util.ChatPrint(lineFormat:format(_ENCH('ShowDELevels'), Enchantrix.Locale.GetLocalizedFilterVal('levels'), _ENCH('HelpShowDELevels')));
	Enchantrix.Util.ChatPrint(lineFormat:format(_ENCH('ShowDEMaterials'), Enchantrix.Locale.GetLocalizedFilterVal('materials'), _ENCH('HelpShowDEMaterials')));

	Enchantrix.Util.ChatPrint(lineFormat:format(_ENCH('ShowValue'), Enchantrix.Locale.GetLocalizedFilterVal('valuate'), _ENCH('HelpValue')));
	if AucAdvanced then
		Enchantrix.Util.ChatPrint(lineFormat:format(_ENCH('ShowGuessAuctioneerVal'), Enchantrix.Locale.GetLocalizedFilterVal('valuate-val'), _ENCH('HelpGuessAuctioneer5Val')));
	end
	if Auctioneer and Enchantrix.State.Auctioneer_Loaded then
		Enchantrix.Util.ChatPrint(lineFormat:format(_ENCH('ShowGuessAuctioneerHsp'), Enchantrix.Locale.GetLocalizedFilterVal('valuate-hsp'), _ENCH('HelpGuessAuctioneerHsp')));
		Enchantrix.Util.ChatPrint(lineFormat:format(_ENCH('ShowGuessAuctioneerMed'), Enchantrix.Locale.GetLocalizedFilterVal('valuate-median'), _ENCH('HelpGuessAuctioneerMedian')));
	end
	if not AucAdvanced and not (Auctioneer and Enchantrix.State.Auctioneer_Loaded) then
		Enchantrix.Util.ChatPrint(_ENCH('HelpGuessNoauctioneer'));
	end
	Enchantrix.Util.ChatPrint(lineFormat:format(_ENCH('ShowGuessBaseline'), Enchantrix.Locale.GetLocalizedFilterVal('valuate-baseline'), _ENCH('HelpGuessBaseline')));

	lineFormat = "  |cffffffff/enchantrix %s %s|r - %s";
	Enchantrix.Util.ChatPrint(lineFormat:format(_ENCH('CmdLocale'), _ENCH('OptLocale'), _ENCH('HelpLocale')));
	Enchantrix.Util.ChatPrint(lineFormat:format(_ENCH('CmdClear'), _ENCH('OptClear'), _ENCH('HelpClear')));

	Enchantrix.Util.ChatPrint(lineFormat:format(_ENCH('CmdDefault'), _ENCH('OptDefault'), _ENCH('HelpDefault')));
	Enchantrix.Util.ChatPrint(lineFormat:format(_ENCH('CmdPrintin'), _ENCH('OptPrintin'), _ENCH('HelpPrintin')));
end


--[[
	The onOff(state, chatprint) function handles the state of the Enchantrix AddOn (whether it is currently on or off)
	If "on" or "off" is specified in the "state" variable then Enchantrix's state is changed to that value,
	If "toggle" is specified then it will toggle Enchantrix's state (if currently on then it will be turned off and vice-versa)

	If a boolean (or nil) value is passed as the first argument the conversion is as follows:
	"true" is the same as "on"
	"false" is the same as "off"
	"nil" is the same as "toggle"

	If chatprint is "true" then the state will also be printed to the user.
]]
function onOff(state, chatprint)
	if (type(state) == "string") then
		state = Enchantrix.Locale.DelocalizeFilterVal(state)

	elseif (state == true) then
		state = 'on'

	elseif (state == false) then
		state = 'off'

	elseif (state == nil) then
		state = 'toggle'
	end

	if (state == 'on') or (state == 'off') then
		Enchantrix.Settings.SetSetting('all', state);
	elseif (state == "toggle") then
		Enchantrix.Settings.SetSetting('all', not Enchantrix.Settings.GetSetting('all'))
	end

	-- Print the change and alert the GUI if the command came from slash commands. Do nothing if they came from the GUI.
	if (chatprint) then
		state = Enchantrix.Settings.GetSetting('all')

		if (state) then
			Enchantrix.Util.ChatPrint(_ENCH('StatOn'));

		else
			Enchantrix.Util.ChatPrint(_ENCH('StatOff'));
		end
	end

	return state;
end

-- The following functions are almost verbatim copies of the original functions but modified in order to make them compatible with direct GUI access.
function clear(param, chatprint)
	if (param == _ENCH('CmdClearAll')) or (param == "all") then
		DisenchantList = {}
		EnchantedLocal = {}
		EnchantedBaseItems = {}

		if (chatprint) then
			Enchantrix.Util.ChatPrint(_ENCH('FrmtActClearall'));
		end

	else
		local items = Enchantrix.Util.GetItemHyperlinks(param);

		if (items) then
			for pos, itemKey in ipairs(items) do
				local sig = Enchantrix.Util.GetSigFromLink(itemKey)
				local itemID = Enchantrix.Util.GetItemIdFromSig(sig)
				EnchantedLocal[sig] = nil
				EnchantedBaseItems[itemID] = nil

				if (chatprint) then
					Enchantrix.Util.ChatPrint(_ENCH('FrmtActClearOk'):format(itemKey))
				end
			end
		end
	end
end

-- This function was added by MentalPower to implement the /enx default command
function default(param, chatprint)
	local paramLocalized

	if  ( (param == nil) or (param == "") ) then
		return
	elseif (param == _ENCH('CmdClearAll')) or (param == "all") then
		param = "all"
	else
		paramLocalized = param
		param = Enchantrix.Locale.DelocalizeCommand(param)
		Enchantrix.Settings.SetSetting(param, nil)
	end

	if (chatprint) then
		if (param == "all") then
			Enchantrix.Util.ChatPrint(_ENCH('FrmtActDefaultAll'));
			Enchantrix.Settings.SetSetting('profile.default', true );
		else
			Enchantrix.Util.ChatPrint(_ENCH('FrmtActDefault'):format(paramLocalized));
		end
	end
end

function genVarSet(variable, param, chatprint)

	param = Enchantrix.Locale.DelocalizeFilterVal(param);

	if (param == 'on' or param == 'off' or param == true or param == false) then
		Enchantrix.Settings.SetSetting(variable, param);

	elseif (param == 'toggle' or param == nil or param == "") then
		Enchantrix.Settings.SetSetting(variable, not Enchantrix.Settings.GetSetting(variable))
	end

	if (chatprint) then
		if (Enchantrix.Settings.GetSetting(variable)) then
			Enchantrix.Util.ChatPrint(_ENCH('FrmtActEnable'):format(Enchantrix.Locale.LocalizeCommand(variable)));
		else
			Enchantrix.Util.ChatPrint(_ENCH('FrmtActDisable'):format(Enchantrix.Locale.LocalizeCommand(variable)));
		end
	end
end


Enchantrix.Command = {
	Revision				= "$Revision: 4051 $",

	AddonLoaded				= addonLoaded,
	AuctioneerLoaded		= auctioneerLoaded,

	HandleCommand			= handleCommand,
	ChatPrintHelp			= chatPrintHelp,
}
