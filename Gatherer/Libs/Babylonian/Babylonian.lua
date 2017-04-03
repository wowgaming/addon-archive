--[[
	Babylonian - A sub-addon that manages the locales for other addons.
	Version: 3.1.14 (<%codename%>)
	Revision: $Id: Babylonian.lua 130 2008-10-11 12:38:07Z Norganna $
	URL: http://auctioneeraddon.com/dl/

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

local LIBRARY_VERSION_MAJOR = "Babylonian"
local LIBRARY_VERSION_MINOR = 2


--[[-----------------------------------------------------------------

LibStub is a simple versioning stub meant for use in Libraries.
See <http://www.wowwiki.com/LibStub> for more info.
LibStub is hereby placed in the Public Domain.
Credits:
    Kaelten, Cladhaire, ckknight, Mikk, Ammo, Nevcairiel, joshborke

--]]-----------------------------------------------------------------
do
	local LIBSTUB_MAJOR, LIBSTUB_MINOR = "LibStub", 2
	local LibStub = _G[LIBSTUB_MAJOR]

	if not LibStub or LibStub.minor < LIBSTUB_MINOR then
		LibStub = LibStub or {libs = {}, minors = {} }
		_G[LIBSTUB_MAJOR] = LibStub
		LibStub.minor = LIBSTUB_MINOR

		function LibStub:NewLibrary(major, minor)
			assert(type(major) == "string", "Bad argument #2 to `NewLibrary' (string expected)")
			minor = assert(tonumber(strmatch(minor, "%d+")), "Minor version must either be a number or contain a number.")

			local oldminor = self.minors[major]
			if oldminor and oldminor >= minor then return nil end
			self.minors[major], self.libs[major] = minor, self.libs[major] or {}
			return self.libs[major], oldminor
		end

		function LibStub:GetLibrary(major, silent)
			if not self.libs[major] and not silent then
				error(("Cannot find a library instance of %q."):format(tostring(major)), 2)
			end
			return self.libs[major], self.minors[major]
		end

		function LibStub:IterateLibraries() return pairs(self.libs) end
		setmetatable(LibStub, { __call = LibStub.GetLibrary })
	end
end
--[End of LibStub]---------------------------------------------------

local lib = LibStub:NewLibrary(LIBRARY_VERSION_MAJOR, LIBRARY_VERSION_MINOR)
if not lib then return end

LibStub("LibRevision"):Set("$URL: http://svn.norganna.org/libs/trunk/Babylonian/Babylonian.lua $","$Rev: 130 $","5.1.DEV.", 'auctioneer', 'libs')

if not lib.private then
	lib.private = {}
end
local private = lib.private
local tinsert = table.insert

function lib:SetOrder(order)
	if (not order) then
		private.order = {}
	else
		private.order = { strsplit(",", order) }
	end

	tinsert(private.order, GetLocale())
	tinsert(private.order, "enUS")

	local curOrder = SetCVar("BabylonianOrder", order)

	if lib.notifyList then
		for _, func in pairs(lib.notifyList) do
			func()
		end
	end

	return curOrder
end

function lib:GetOrder()
	return GetCVar("BabylonianOrder")
end

function lib:FetchString(stringTable, locale, stringKey)
	if ((type(stringTable) == "table") and (type(stringTable[locale]) == "table") and (stringTable[locale][stringKey])) then
		return stringTable[locale][stringKey]
	end
end

function lib:GetString(stringTable, stringKey, default)
	local val
	for i = 1, #private.order do
		val = lib:FetchString(stringTable, private.order[i], stringKey)
		if (val) then
			return val
		end
	end
	return default
end

lib.notifyList = {}
function lib:AddNotify(func)
	table.insert(lib.notifyList, func)
end

local kit = {
	GetOrder = lib.GetOrder,
	SetOrder = lib.SetOrder,
}

function kit:GetString(stringKey, default)
	return (lib:GetString(self.stringTable, stringKey, default))
end

function kit:FetchString(locale, stringKey)
	return (lib:FetchString(self.stringTable, locale, stringKey))
end

local function noKey(t, key)
	error("Localization for "..tostring(key).." is unavailable")
end

function lib:New(stringTable)
	assert(stringTable, "Usage: Babylonian(stringTable) -- Must supply a stringTable")
	assert(type(stringTable)=="table", "Usage: Babylonian(stringTable) -- Supplied stringTable must be a table")

	local new = {
		stringTable = stringTable
	}
	for k,v in pairs(kit) do
		new[k] = v
	end
	setmetatable(new, { __call = new.FetchString, __index = new.GetString, __newindex = noKey })
	return new
end
setmetatable(lib, { __call = lib.New })

if not private.order then
	RegisterCVar("BabylonianOrder", "")
	lib:SetOrder(lib:GetOrder())
end
