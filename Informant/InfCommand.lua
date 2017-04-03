--[[
	Informant - An addon for World of Warcraft that shows pertinent information about
	an item in a tooltip when you hover over the item in the game.
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: InfCommand.lua 4047 2009-02-02 19:29:55Z anaral $
	URL: http://auctioneeraddon.com/dl/Informant/

	Command handler. Assumes responsibility for allowing the user to set the
	options via slash command, MyAddon etc.

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
Informant_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Informant/InfCommand.lua $", "$Rev: 4047 $")

-- function prototypes
local commandHandler, cmdHelp, onOff, genVarSet, chatPrint, restoreDefault, cmdLocale, setLocale, isValidLocale
local debugPrint

-- Localization function prototypes
local delocalizeFilterVal, localizeFilterVal, getLocalizedFilterVal, delocalizeCommand, localizeCommand, buildCommandMap

local commandMap = nil
local commandMapRev = nil

Informant.InitCommands = function()
	SLASH_INFORMANT1 = "/informant"
	SLASH_INFORMANT2 = "/inform"
	SLASH_INFORMANT3 = "/info"
	SLASH_INFORMANT4 = "/inf"
	SlashCmdList["INFORMANT"] = commandHandler

	chatPrint(_TRANS('INF_Help_Welcome'):format(INFORMANT_VERSION))
end


function buildCommandMap()
	commandMap = {
		[_TRANS('INF_Help_On')]			=	'on',
		[_TRANS('INF_Help_Off')]			=	'off',
		[_TRANS('INF_Help_CmdHelp')]			=	'help',
		[_TRANS('INF_Help_Toggle')]		=	'toggle',
		[_TRANS('INF_Help_CmdDisable')]		=	'disable',
		[_TRANS('INF_Help_CmdLocale')]		=	'locale',
		[_TRANS('INF_Help_CmdDefault')]		=	'default',
		[_TRANS('INF_Help_CmdEmbed')]			=	'embed',
		[_TRANS('INF_Help_CmdShowILevel')]		=	'show-ilevel',
		[_TRANS('INF_Help_CmdShowLink')]			=	'show-link',
		[_TRANS('INF_Help_CmdShowStack')]		=	'show-stack',
		[_TRANS('INF_Help_CmdShowUsage')]		=	'show-usage',
		[_TRANS('INF_Help_CmdShowQuest')]		=	'show-quest',
		[_TRANS('INF_Help_CmdShowMerchant')]		=	'show-merchant',
		[_TRANS('INF_Help_CmdShowZeroMerchants')] =	'show-zero-merchants',
		[_TRANS('INF_Help_CmdShowVendor')]		=	'show-vendor',
		[_TRANS('INF_Help_CmdShowVendorBuy')]	=	'show-vendor-buy',
		[_TRANS('INF_Help_CmdShowVendorSell')]	=	'show-vendor-sell',
	}

	commandMapRev = {}
	for k,v in pairs(commandMap) do
		commandMapRev[v] = k
	end
end

--Cleaner Command Handling Functions (added by MentalPower)
function commandHandler(command, source)
	--To print or not to print, that is the question...
	local chatprint
	if (source == "GUI") then
		chatprint = false
	else
		chatprint = true
	end

	--Divide the large command into smaller logical sections (Shameless copy from the original function)
	local cmd, param = command:match("^([%w%-]+)%s*(.*)$")

	cmd = cmd or command or ""
	param = param or ""
	cmd = delocalizeCommand(cmd)

	--Now for the real Command handling
	if ((cmd == "") or (cmd == "help")) then
		cmdHelp()
		return

	elseif (cmd == 'show' or cmd == 'config') then
		-- show or hide our settings UI
		Informant.Settings.MakeGuiConfig()
		local gui = Informant.Settings.Gui
		if (gui:IsVisible()) then
			gui:Hide()
		else
			gui:Show()
		end

	elseif (cmd == "on" or cmd == "off" or cmd == "toggle") then
		onOff(cmd, chatprint)
	elseif (cmd == "disable") then
		Stubby.SetConfig("Informant", "LoadType", "never")
	elseif (cmd == "load") then
		if (param == "always") or (param == "never") then
			chatPrint("Setting Informant to "..param.." load for this toon")
			Stubby.SetConfig("Informant", "LoadType", param)
		end
	elseif (cmd == "locale") then
		setLocale(param, chatprint)
	elseif (cmd == "default") then
		restoreDefault(param, chatprint)
	elseif (
		cmd == "embed" or cmd == "show-stack" or cmd == "show-usage" or
		cmd == "show-quest" or cmd == "show-merchant" or cmd == "show-vendor" or
		cmd == "show-vendor-buy" or cmd == "show-vendor-sell" or cmd == "show-ilevel" or 
		cmd == "show-link" or cmd == "show-zero-merchants"
	) then
		genVarSet(cmd, param, chatprint)
	elseif (cmd == "about") then
		chatPrint(_TRANS('about'))
	else
		if (chatprint) then
			chatPrint(_TRANS('INF_Help_CmdUnknown'):format(cmd))
		end
	end
end

--Help ME!! (The Handler) (Another shameless copy from the original function)
function cmdHelp()

	local onOffToggle = " (".._TRANS('INF_Help_On').."|".._TRANS('INF_Help_Off').."|".._TRANS('INF_Help_Toggle')..")"
	local lineFormat = "  |cffffffff/informant %s "..onOffToggle.."|r |cffff4020[%s]|r - %s"

	chatPrint(_TRANS('INF_Help_CmdHeader'))
	chatPrint("  |cffffffff/informant "..onOffToggle.."|r |cffff4020["..getLocalizedFilterVal('all').."]|r - " .. _TRANS('INF_HelpTooltip_EnableInformant'))

	chatPrint("  |cffffffff/informant ".._TRANS('INF_Help_CmdDisable').."|r - " .. _TRANS('INF_Help_CmdHelpDisable'))

	chatPrint(lineFormat:format(_TRANS('INF_Help_CmdShowVendor'), getLocalizedFilterVal('show-vendor'), _TRANS('INF_HelpTooltip_VendorToggle')))
	chatPrint(lineFormat:format(_TRANS('INF_Help_CmdShowVendorSell'), getLocalizedFilterVal('show-vendor-sell'), _TRANS('INF_HelpTooltip_ShowVendorSell')))
	chatPrint(lineFormat:format(_TRANS('INF_Help_CmdShowVendorBuy'), getLocalizedFilterVal('show-vendor-buy'), _TRANS('INF_HelpTooltip_ShowVendorBuy')))
	chatPrint(lineFormat:format(_TRANS('INF_Help_CmdShowUsage'), getLocalizedFilterVal('show-usage'), _TRANS('INF_HelpTooltip_ShowUsage')))
	chatPrint(lineFormat:format(_TRANS('INF_Help_CmdQuest'), getLocalizedFilterVal('show-quest'), _TRANS('INF_HelpTooltip_ShowQuest')))
	chatPrint(lineFormat:format(_TRANS('INF_Help_CmdMerchant'), getLocalizedFilterVal('show-merchant'), _TRANS('INF_HelpTooltip_ShowMerchant')))
	chatPrint(lineFormat:format(_TRANS('INF_Help_CmdShowZeroMerchant'), getLocalizedFilterVal('show-zero-merchants'), _TRANS('INF_HelpTooltip_ShowZeroMerchants')))
	chatPrint(lineFormat:format(_TRANS('INF_Help_CmdShowStack'), getLocalizedFilterVal('show-stack'), _TRANS('INF_HelpTooltip_ShowStack')))
	chatPrint(lineFormat:format(_TRANS('INF_Help_CmdShowILevel'), getLocalizedFilterVal('show-ilevel'), _TRANS('INF_HelpTooltip_ShowIlevel')))
	chatPrint(lineFormat:format(_TRANS('INF_Help_CmdShowLink'), getLocalizedFilterVal('show-link'), _TRANS('INF_HelpTooltip_ShowLink')))
	chatPrint(lineFormat:format(_TRANS('INF_Help_CmdEmbed'), getLocalizedFilterVal('embed'), _TRANS('INF_HelpTooltip_Embed')))

	lineFormat = "  |cffffffff/informant %s %s|r |cffff4020[%s]|r - %s"
	chatPrint(lineFormat:format(_TRANS('INF_Help_CmdLocale'), _TRANS('INF_Help_OptLocale'), getLocalizedFilterVal('locale'), _TRANS('INF_Help_Locale')))

	lineFormat = "  |cffffffff/informant %s %s|r - %s"
	chatPrint(lineFormat:format(_TRANS('INF_Help_CmdDefault'), "", _TRANS('INF_Helptooltip_DefaultProfile')))
end


--[[
	The onOff(state, chatprint) function handles the state of the Informant AddOn (whether it is currently on or off)
	If "on" or "off" is specified in the first argument then Informant's state is changed to that value,
	If "toggle" is specified then it will toggle Informant's state (if currently on then it will be turned off and vice-versa)

	If a boolean (or nil) value is passed as the first argument the conversion is as follows:
	"true" is the same as "on"
	"false" is the same as "off"
	"nil" is the same as "toggle"

	If chatprint is "true" then the state will also be printed to the user.
--]]
function onOff(state, chatprint)
	if (type(state) == "string") then
		state = delocalizeFilterVal(state)

	elseif (state == nil) then
		state = 'toggle'
	end

	if (state == 'on' or state == 'off' or type(param) == "boolean") then
		Informant.Settings.SetSetting('all', state)

	elseif (state == 'toggle') then
		Informant.Settings.SetSetting('all', not Informant.Settings.GetSetting('all'))
	end

	--Print the change and alert the GUI if the command came from slash commands. Do nothing if they came from the GUI.
	if (chatprint) then
		state = Informant.Settings.GetSetting('all')

		if (state) then
			chatPrint(_TRANS('INF_Help_InfOn'))
		else
			chatPrint(_TRANS('INF_Help_InfOff'))
		end
	end
end

function restoreDefault(param, chatprint)
	local paramLocalized

	if ( (param == nil) or (param == "") ) then
		return
	elseif ((param == _TRANS('INF_Help_CmdClearAll')) or (param == "all")) then
		param = "all"
		Informant.Settings.RestoreDefaults()
	else
		paramLocalized = param
		param = delocalizeCommand(param)
		Informant.Settings.SetSetting(param, nil)
	end

	if (chatprint) then
		if (param == "all") then
			chatPrint(_TRANS('INF_Help_CmdDefaultAll'))
		else
			chatPrint(_TRANS('INF_Help_CmdDefaultSingle'):format(paramLocalized))
		end
	end
end

function genVarSet(variable, param, chatprint)
	if (type(param) == "string") then
		param = delocalizeFilterVal(param)
	end

	if (param == "on" or param == "off" or type(param) == "boolean") then
		Informant.Settings.SetSetting(variable, param)
	elseif (param == "toggle" or param == nil or param == "") then
		param = Informant.Settings.SetSetting(variable, not Informant.Settings.GetSetting(variable))
	end

	if (chatprint) then
		if (Informant.Settings.GetSetting(variable)) then
			chatPrint(_TRANS('INF_Interface_EnableInformant'):format(localizeCommand(variable)))
		else
			chatPrint(_TRANS('INF_Help_Disable'):format(localizeCommand(variable)))
		end
	end
end

function isValidLocale(param)
	return (InformantLocalizations and InformantLocalizations[param])
end

function setLocale(param, chatprint)
	param = delocalizeFilterVal(param)
	local validLocale

	if (param == 'default') or (param == 'off') then
		Babylonian.SetOrder('')
		validLocale = true

	elseif (isValidLocale(param)) then
		Babylonian.SetOrder(param)
		validLocale = true

	else
		validLocale = false
	end

	BINDING_HEADER_INFORMANT_HEADER = _TRANS('INF_Help_CmdInformant')
	BINDING_NAME_INFORMANT_POPUPDOWN = _TRANS('INF_Help_CmdLoadMsg')

	if (chatprint) then
		if (validLocale) then
			chatPrint(_TRANS('INF_Help_CmdSetLocale'):format(_TRANS('INF_Help_CmdLocale'), param))

		else
			chatPrint(_TRANS("INF_Help_LocaleUnknown"):format(param))
			local locales = "    "
			for locale, data in pairs(InformantLocalizations) do
				locales = locales .. " '" .. locale .. "' "
			end
			chatPrint(locales)
		end
	end

	commandMap = nil
	commandMapRev = nil
end

function chatPrint(msg)
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, 0.25, 0.55, 1.0)
	end
end

--------------------------------------
--		Localization functions		--
--------------------------------------

function delocalizeFilterVal(value)
	if (value == _TRANS('INF_Help_On')) then
		return true

	elseif (value == _TRANS('INF_Help_Off')) then
		return false

	elseif (value == _TRANS('INF_Help_CmdDefault')) then
		return 'default'

	elseif (value == _TRANS('INF_Help_Toggle')) then
		return 'toggle'

	else
		return value
	end
end

function localizeFilterVal(value)
	local result

	if (value == 'on' or (type(value) == "boolean" and value == true)) then
		result = _TRANS('INF_Help_On')

	elseif (value == 'off' or (type(value) == "boolean" and value == false)) then
		result = _TRANS('INF_Help_Off')

	elseif (value == 'default') then
		result = _TRANS('INF_Help_CmdDefault')

	elseif (value == 'toggle') then
		result = _TRANS('INF_Help_Toggle')
	end

	return result or value
end

function getLocalizedFilterVal(key)
	return localizeFilterVal(Informant.Settings.GetSetting(key))
end

-- Turns a localized slash command into the generic English version of the command
function delocalizeCommand(cmd)
	if (not commandMap) then
		buildCommandMap()
	end

	return commandMap[cmd] or cmd
end

-- Translate a generic English slash command to the localized version, if available
function localizeCommand(cmd)
	if (not commandMapRev) then
		buildCommandMap()
	end

	return commandMapRev[cmd] or cmd
end

-------------------------------------------------------------------------------
-- Prints the specified message to nLog.
--
-- syntax:
--    errorCode, message = debugPrint([message][, title][, errorCode][, level])
--
-- parameters:
--    message   - (string) the error message
--                nil, no error message specified
--    title     - (string) the title for the debug message
--                nil, no title specified
--    errorCode - (number) the error code
--                nil, no error code specified
--    level     - (string) nLog message level
--                         Any nLog.levels string is valid.
--                nil, no level specified
--
-- returns:
--    errorCode - (number) errorCode, if one is specified
--                nil, otherwise
--    message   - (string) message, if one is specified
--                nil, otherwise
-------------------------------------------------------------------------------
function debugPrint(message, title, errorCode, level)
	return Informant.DebugPrint(message, "InfCommand", title, errorCode, level)
end

-- Globally accessible functions
Informant.SetLocale = setLocale



