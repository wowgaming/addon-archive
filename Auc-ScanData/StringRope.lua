--[[
	StringRope Lib for World of Warcraft (tm)
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: StringRope.lua 3938 2008-12-27 09:35:32Z norganna $
	URL: http://norganna.org

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
		This source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit license to use this AddOn with these facilities
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]

local LIBRARY_VERSION_MAJOR = "StringRope"
local LIBRARY_VERSION_MINOR = 5

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

--Local references of used functions
local pairs = pairs
local tconcat = table.concat
local tinsert = table.insert

-- Create a new StringRope instance
function lib:New(size)
	if not size then size = 512 end
	if size < 0 then size = 65500 end
	if size > 65500 then size = 65500 end
	if size < 25 then size = 25 end
	local new = { strings = {}, size = size, len = 0 }
	for k,v in pairs(self.kit) do
		new[k] = v
	end
	return new
end

-- Holds the functions to be copied to new StringRope instances
lib.kit = {}

-- Clears the StringRope instance
function lib.kit:Clear()
	local size = #self.strings
	for i = size, 1, -1 do self.strings[i] = nil end
	self.len = 0
end
-- Checks to see if the rope is empty
function lib.kit:IsEmpty()
	return (#self.strings == 0)
end
-- Gets the current StringRope instance
function lib.kit:Get()
	return tconcat(self.strings)
end
-- Adds a substring to the StringRope instance
function lib.kit:Add(text)
	if #self.strings >= self.size then
		local text = self:Get()
		self:Clear()
		self:Add(text)
	end
	self.len = self.len + tostring(text):len()
	return tinsert(self.strings, text)
end
-- Adds a number of substrings to the StringRope instance
function lib.kit:AddMultiple(...)
	local v
	local n = select("#", ...)
	for i = 1, n do
		v = select(i, ...)
		self:Add(v)
	end
end
-- Adds a number of substrings to the StringRope instance,
-- all delimited by a given character.
function lib.kit:AddDelimited(delimiter, ...)
	local v
	local n = select("#", ...)
	for i = 1, n do
		v = select(i, ...)
		if i > 1 then self:Add(delimiter) end
		self:Add(v)
	end
end
