--[[
	BeanCounter Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: BeanCounterLocale.lua 3583 2008-10-11 16:50:02Z Norganna $
	URL: http://auctioneeraddon.com/

	BeanCounterLocale
	Functions for localizing BeanCounter
	Thanks to Telo for the LootLink code from which this was based.

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
LibStub("LibRevision"):Set("$URL: http://svn.norganna.org/auctioneer/branches/5.8/BeanCounter/BeanCounterLocale.lua $","$Rev: 3583 $","5.1.DEV.", 'auctioneer', 'libs')

local libName = "BeanCounter"
local libType = "Util"
local lib = BeanCounter
local private = lib.Private
local print =  BeanCounter.Print

local Babylonian = LibStub("Babylonian")
assert(Babylonian, "Babylonian is not installed")

local babylonian = Babylonian(BeanCounterLocalizations)

local BeanCounter_CustomLocalizations = {
	['MailAllianceAuctionHouse'] = GetLocale(),
	['MailAuctionCancelledSubject'] = GetLocale(),
	['MailAuctionExpiredSubject'] = GetLocale(),
	['MailAuctionSuccessfulSubject'] = GetLocale(),
	['MailAuctionWonSubject'] = GetLocale(),
	['MailHordeAuctionHouse'] = GetLocale(),
	['MailOutbidOnSubject'] = GetLocale(),
}

function private.localizations(stringKey, locale)
--locale = "deDE"
	if (locale) then
		if (type(locale) == "string") then
			return babylonian(locale, stringKey) or stringKey
		else
			return babylonian(GetLocale(), stringKey)
		end
	elseif (BeanCounter_CustomLocalizations[stringKey]) then
		return babylonian(BeanCounter_CustomLocalizations[stringKey], stringKey)
	else
		return babylonian[stringKey] or stringKey
	end
end
