--[[
--        LibRevision.lua
--           Finds the revisions of a given addon and works out the version.
--           Written by Ken Allan <ken@norganna.org>
--           This code is hereby released into the Public Domain without warranty.
--
--        Usage:
--           local libRevision = LibStub("LibRevision")
--
--           libRevision:Set("svnUrl", "svnRev", "5.1.DEV.", ...)
--           libRevision:Get("addon")
--]]

local LIBRARY_VERSION_MAJOR = "LibRevision"
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

if not lib.versions then
	lib.versions = {}
end

function lib:Get(addon)
	return lib.versions[addon:lower()]
end

function lib:Set(url, revision, dev, ...)
	local repo,file
	if (not url and revision) then return end

	local n = select("#", ...)
	for i=1, n do
		local sub = select(i, ...)
		repo, file = url:match("%$URL: .*/("..sub..")/([^%$]+) %$")
		if repo then break end
	end
	local rev = tonumber(revision:match("(%d+)")) or 0

	if repo then
		local branch,name = file:match("^(trunk)/([^/]+)/")
		if not branch then
			branch,name = file:match("^branches/([^/]+)/([^/]+)/")
		end

		if branch then
			local embed, addit = false, branch
			local addon = name:lower()

			if not lib.versions[addon] then
				lib.versions[addon] = {}
			end

			local vaddon = lib.versions[addon]
			local vrev = max(vaddon['x-revision'] or 0, rev)
			vaddon['x-revision'] = vrev
			
			if not IsAddOnLoaded(addon) then
				embed = true
				addit = addit.."/embedded"
			end

			local ver = GetAddOnMetadata(addon, "Version")
			if not ver or ver:sub(0,2) == "<%" then ver = dev..rev end

			if not vaddon["x-revisions"] then
				vaddon["x-revisions"] = {}
			end

			vaddon.name = name
			vaddon.version = ver
			vaddon["x-branch"] = branch
			vaddon["x-revision"] = vrev
			vaddon["x-revisions"][file] = rev
			vaddon["x-embedded"] = embed
			vaddon["x-swatter-extra"] = addition

			if SetAddOnDetail then
				SetAddOnDetail(name, vaddon)
			end

			return vaddon, file, rev
		end
	end
end
