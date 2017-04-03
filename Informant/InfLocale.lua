--[[
	Informant - An addon for World of Warcraft that shows pertinent information about
	an item in a tooltip when you hover over the item in the game.
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: InfLocale.lua 4021 2009-01-27 23:01:05Z anaral $
	URL: http://auctioneeraddon.com/dl/Informant/

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
Informant_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Informant/InfLocale.lua $", "$Rev: 4021 $")

local Babylonian = LibStub("Babylonian")
assert(Babylonian, "Babylonian is not installed")

local babylonian = Babylonian(InformantLocalizations)

Informant_CustomLocalizations = {
}

function _TRANS(stringKey, locale)
	if (locale) then
		if (type(locale) == "string") then
			return babylonian(locale, stringKey);
		else
			return babylonian(GetLocale(), stringKey);
		end
	elseif (Informant_CustomLocalizations[stringKey]) then
		return babylonian(Informant_CustomLocalizations[stringKey], stringKey)
	else
		return babylonian[stringKey] or stringKey
	end
end
