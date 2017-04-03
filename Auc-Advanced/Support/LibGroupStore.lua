--[[
--        LibGroupStorage.lua
--           Group data storage
--           A storage array for variable sized groups of data
--           Written by Ken Allan <ken@norganna.org>
--           This code is hereby released into the Public Domain without warranty.
--
--        Basic Usage:
--           local GroupStore = LibStub("LibGroupStore")
--           local storage = GroupStore()
--
--           local id = storage:InsertGroup(122, 233, 344, 411)
--           local a, b, c, d = storage:GetGroup(id)
--
--        Advanced Usage:
--           storage:Clear()             -- Remove all groups from the storage
--           storage:RemoveGroup(7)      -- Removes group 7 from the array, shifting later groups down.
--           base = storage:GetBase()    -- Returns the base array (so you can save it, etc)
--           storage = GroupStore(base)  -- Resurrect a saved storage array
--
--        Shortcuts:
--           storage(nil, 1,2,3)  = storage:InsertGroup(1,2,3)
--           storage - 3          = storage:RemoveGroup(3)
--           storage(1)           = storage:GetGroup(1)
--           #storage             = storage:GetNumGroups()
--]]

local LIBRARY_VERSION_MAJOR = "LibGroupStore"
local LIBRARY_VERSION_MINOR = 1


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

local kit={}

lib.data = {}

local function findFunction(self, index)
	return kit[index]
end

-- Create a new storage instance
function lib:New(base)
	-- Init it's variables
	if base then
		assert(base.index or #base == 0, "Cannot specify a non-group base")
	else
		base = {}
		base.index = {}
	end

	local proxy = newproxy(true)
	local mt = getmetatable(proxy)

	mt.__len = kit.GetNumGroups
	mt.__sub = kit.RemoveGroup
	mt.__call = kit.GetGroup
	mt.__index = findFunction

	lib.data[proxy] = base

	-- Return the data
	return proxy
end
setmetatable(lib, { __call = lib.New })

-- Insert the items on the stack as a group into the storage
function kit:InsertGroup(...)
	local base = lib.data[self]
	local pos = #base
	local len = select('#', ...)
	table.insert(base.index, pos)
	table.insert(base.index, len)
	for i = 1, len do
		base[pos+i] = select(i, ...)
	end
	-- Return the group id
	return (#base.index / 2)
end

-- Remove specified group from the storage, shifting all higher groups down
function kit:RemoveGroup(group)
	local base = lib.data[self]
	local max = #base.index / 2
	group = tonumber(group)
	assert(group, "Must specify a group number")
	assert(group > 0, "Attempt to get group range <= 0")
	assert(group <= max, "Attempt to get group range > max")
	local index = group * 2 - 1
	local pos = table.remove(base.index, index)
	local len = table.remove(base.index, index)
	for i = 1, len do
		table.remove(base, pos+1)
	end
	for i = group, max-1 do
		index = i * 2 - 1
		base.index[index] = base.index[index]-len
	end
	return self
end

-- Fetch the start, end and length of a specified group (for direct access)
function kit:GetGroupRange(group)
	local base = lib.data[self]
	local max = #base.index / 2
	group = tonumber(group)
	assert(group, "Must specify a group number")
	assert(group > 0, "Attempt to get group range <= 0")
	assert(group <= max, "Attempt to get group range > max")
	local index = group * 2 - 1
	local pos = base.index[index]
	local len = base.index[index]
	-- Return start, end, length
	return pos+1, pos+len, len
end

-- Return the specified group on the stack
function kit:GetGroup(group, ...)
	if not group or group <= 0 then return kit.InsertGroup(self, ...) end
	local base = lib.data[self]
	local max = #base.index / 2
	group = tonumber(group)
	assert(group, "Must specify a group number")
	assert(group > 0, "Attempt to get group range <= 0")
	assert(group <= max, "Attempt to get group range > max")
	local index = group * 2 - 1
	local pos = base.index[index]
	local len = base.index[index+1]
	return unpack(base, pos+1, pos+len)
end

-- Return the number of groups
function kit:GetNumGroups()
	local base = lib.data[self]
	return #base.index / 2
end

-- Return a reference to the base object (for saves)
function kit:GetBase()
	return lib.data[self]
end

-- Clear all groups from the entire storage array
function kit:Clear()
	local base = lib.data[self]
	while #base.index > 0 do table.remove(base.index) end
	while #base > 0 do table.remove(base) end

	return self
end


