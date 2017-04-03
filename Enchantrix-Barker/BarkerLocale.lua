--[[
	Enchantrix:Barker Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: BarkerLocale.lua 3581 2008-10-11 12:36:19Z Norganna $
	URL: http://enchantrix.org/

	Localization routines

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
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]
EnchantrixBarker_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Enchantrix-Barker/BarkerLocale.lua $", "$Rev: 3581 $")

local Babylonian = LibStub("Babylonian")
assert(Babylonian, "Babylonian is not installed")

local babylonian = Babylonian(EnchantrixBarkerLocalizations)

-- Global functions
local addonLoaded			-- Barker.Locale.AddonLoaded()
local delocalizeFilterVal	-- Barker.Locale.DelocalizeFilterVal()
local localizeFilterVal		-- Barker.Locale.LocalizeFilterVal()
local getLocalizedFilterVal	-- Barker.Locale.GetLocalizedFilterVal()
local delocalizeCommand		-- Barker.Locale.DelocalizeCommand()
local localizeCommand		-- Barker.Locale.LocalizeCommand()

-- Local functions
local buildCommandMap
local getLocalizedCmdString

local customLocalizations = {
	['TextGeneral'] = GetLocale(),
	['TextCombat'] = GetLocale(),
	['ArgSpellname'] = GetLocale(),
	['PatReagents'] = GetLocale(),
}

Barker.State.Locale_Changed = true --This needs to be initialy set to true so that the following tables get built at startup.
local commandMap, commandMapRev;

function addonLoaded()
	buildCommandMap()
end

function _BARKLOC(stringKey, locale)
	if locale then
		if type(locale) == "string" then
			return babylonian(locale, stringKey)
		else
			return babylonian(GetLocale(), stringKey)
		end
	elseif (customLocalizations[stringKey]) then
		return babylonian(customLocalizations[stringKey], stringKey)
	else
		return babylonian[stringKey]
	end
end

function buildCommandMap()
	commandMap = {}
	commandMapRev = {}

	commandMap = {
		[_BARKLOC('CmdOn')] = 'on',
		[_BARKLOC('CmdOff')] = 'off',
		[_BARKLOC('CmdBarker')] = 'barker',
		[_BARKLOC('CmdHelp')] = 'help',
		[_BARKLOC('CmdToggle')] = 'toggle',
		[_BARKLOC('CmdDisable')] = 'disable',
		[_BARKLOC('CmdClear')] = 'clear',
		[_BARKLOC('CmdLocale')] = 'locale',
		[_BARKLOC('CmdDefault')] = 'default',
		[_BARKLOC('CmdPrintin')] = 'print-in',
		[_BARKLOC('ShowEmbed')] = 'embed',
		[_BARKLOC('ShowValue')] = 'valuate',
		[_BARKLOC('ShowGuessAuctioneerHsp')] = 'valuate-hsp',
		[_BARKLOC('ShowGuessAuctioneerMed')] = 'valuate-median',
		[_BARKLOC('ShowGuessBaseline')] = 'valuate-baseline',
	}

	for k, v in pairs(commandMap) do
		commandMapRev[v] = k
	end
end

function getLocalizedCmdString(value)
	return _BARKLOC('Cmd'..value:sub(1,1):upper()..value:sub(2))
end

function delocalizeFilterVal(value)
	if value == _BARKLOC('CmdOn') then
		return 'on'
	elseif value == _BARKLOC('CmdOff') then
		return 'off'
	elseif value == _BARKLOC('CmdDefault') then
		return 'default'
	elseif value == _BARKLOC('CmdToggle') then
		return 'toggle'
	else
		return value
	end
end

function localizeFilterVal(value)
	if (value == 'on') or (value == true) then
		return _BARKLOC("CmdOn")
	elseif (value == 'off') or (value == false) then
		return _BARKLOC("CmdOff")
	elseif (value == 'default') or (value == nil) then
		return _BARKLOC("CmdDefault")
	else
		return value
	end
end

function getLocalizedFilterVal(key)
	return localizeFilterVal(Barker.Config.GetFilter(key))
end

-- Turns a localized slash command into the generic English version of the command
function delocalizeCommand(cmd)
	if Barker.State.Locale_Changed then
		buildCommandMap()
		Barker.State.Locale_Changed = nil
	end
	return commandMap[cmd] or cmd
end

-- Translate a generic English slash command to the localized version, if available
function localizeCommand(cmd)
	if Barker.State.Locale_Changed then
		buildCommandMap()
		Barker.State.Locale_Changed = nil
	end
	return commandMapRev[cmd] or cmd
end

Barker.Locale = {
	Revision = "$Revision: 3581 $",

	AddonLoaded				= addonLoaded,

	DelocalizeFilterVal		= delocalizeFilterVal,
	LocalizeFilterVal		= localizeFilterVal,
	GetLocalizedFilterVal	= getLocalizedFilterVal,
	DelocalizeCommand		= delocalizeCommand,
	LocalizeCommand			= localizeCommand,
}
