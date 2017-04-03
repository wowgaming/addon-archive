--[[
	Enchantrix Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: EnxLocale.lua 3576 2008-10-10 03:07:13Z aesir $
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
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]
Enchantrix_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Enchantrix/EnxLocale.lua $", "$Rev: 3576 $")

local Babylonian = LibStub("Babylonian")
assert(Babylonian, "Babylonian is not installed")

local babylonian = Babylonian(EnchantrixLocalizations)

-- Global functions
local addonLoaded			-- Enchantrix.Locale.AddonLoaded()
local delocalizeFilterVal	-- Enchantrix.Locale.DelocalizeFilterVal()
local localizeFilterVal		-- Enchantrix.Locale.LocalizeFilterVal()
local getLocalizedFilterVal	-- Enchantrix.Locale.GetLocalizedFilterVal()
local delocalizeCommand		-- Enchantrix.Locale.DelocalizeCommand()
local localizeCommand		-- Enchantrix.Locale.LocalizeCommand()

-- Local functions
local buildCommandMap

local customLocalizations = {
	['TextGeneral'] = GetLocale(),
	['TextCombat'] = GetLocale(),
	['ArgSpellname'] = GetLocale(),
	['PatReagents'] = GetLocale(),
}

Enchantrix.State.Locale_Changed = true --This needs to be initialy set to true so that the following tables get built at startup.
local commandMap, commandMapRev;

function addonLoaded()
	buildCommandMap()
end

function _ENCH(stringKey, locale)
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
		[_ENCH('CmdOn')] = 'on',
		[_ENCH('CmdOff')] = 'off',
		[_ENCH('CmdHelp')] = 'help',
		[_ENCH('CmdToggle')] = 'toggle',
		[_ENCH('CmdDisable')] = 'disable',
		[_ENCH('CmdClear')] = 'clear',
		[_ENCH('CmdLocale')] = 'locale',
		[_ENCH('CmdDefault')] = 'default',
		[_ENCH('CmdPrintin')] = 'print-in',
		[_ENCH('CmdFindBidauct')] = 'bidbroker',
		[_ENCH('CmdFindBidauctShort')] = 'bidbroker',
		[_ENCH('CmdFindBuyauct')] = 'percentless',
		[_ENCH('CmdFindBuyauctShort')] = 'percentless',
		[_ENCH('ShowEmbed')] = 'embed',
		[_ENCH('ShowTerse')] = 'terse',
		[_ENCH('ShowValue')] = 'valuate',
		[_ENCH('ShowGuessAuctioneerHsp')] = 'valuate-hsp',
		[_ENCH('ShowGuessAuctioneerMed')] = 'valuate-median',
		[_ENCH('ShowGuessBaseline')] = 'valuate-baseline',

		[_ENCH('ShowUI')] = 'show',
		[_ENCH('ConfigUI')] = 'config',
		[_ENCH('ShowDELevels')] = 'levels',
		[_ENCH('ShowDEMaterials')] = 'materials',
	}

	for k, v in pairs(commandMap) do
		commandMapRev[v] = k
	end
end

function delocalizeFilterVal(value)
	if value == _ENCH('CmdOn') then
		return 'on'
	elseif value == _ENCH('CmdOff') then
		return 'off'
	elseif value == _ENCH('CmdDefault') then
		return 'default'
	elseif value == _ENCH('CmdToggle') then
		return 'toggle'
	else
		return value
	end
end

function localizeFilterVal(value)
	if (value == 'on') or (value == true) then
		return _ENCH("CmdOn")
	elseif (value == 'off') or (value == false) then
		return _ENCH("CmdOff")
	elseif (value == 'default') or (value == nil) then
		return _ENCH("CmdDefault")
	else
		return value
	end
end

function getLocalizedFilterVal(key)
	return localizeFilterVal(Enchantrix.Settings.GetSetting(key))
end

-- Turns a localized slash command into the generic English version of the command
function delocalizeCommand(cmd)
	if Enchantrix.State.Locale_Changed then
		buildCommandMap()
		Enchantrix.State.Locale_Changed = nil
	end
	return commandMap[cmd] or cmd
end

-- Translate a generic English slash command to the localized version, if available
function localizeCommand(cmd)
	if Enchantrix.State.Locale_Changed then
		buildCommandMap()
		Enchantrix.State.Locale_Changed = nil
	end
	return commandMapRev[cmd] or cmd
end

Enchantrix.Locale = {
	Revision = "$Revision: 3576 $",

	AddonLoaded				= addonLoaded,

	DelocalizeFilterVal		= delocalizeFilterVal,
	LocalizeFilterVal		= localizeFilterVal,
	GetLocalizedFilterVal	= getLocalizedFilterVal,
	DelocalizeCommand		= delocalizeCommand,
	LocalizeCommand			= localizeCommand,
}
