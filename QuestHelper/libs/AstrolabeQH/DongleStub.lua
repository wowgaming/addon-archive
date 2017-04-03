--[[------------------------------------------------------------------
--  $Id: DongleStub.lua 466 2007-06-23 19:17:46Z jnwhiteh $
--
--  DongleStub is a simple versioning stub that allows different
--  major versions of a library to exist alongside each other, while
--  providing a mechanism for library upgrades through minor version
--  differences.
--
--  The implementation of DongleStub, including the source code, 
--  documentation and related data, is placed into the public domain.
--
--  The original author is James N. Whitehead II
--
--  THIS SOFTWARE IS PROVIDED AS-IS WITHOUT WARRANTY OF ANY KIND, NOT
--  EVEN THE IMPLIED WARRANTY OF MERCHANTABILITY. THE AUTHOR OF THIS
--  SOFTWARE, ASSUMES _NO_ RESPONSIBILITY FOR ANY CONSEQUENCE RESULTING
--  FROM THE USE, MODIFICATION, OR REDISTRIBUTION OF THIS SOFTWARE.
------------------------------------------------------------------]]--

local major = "DongleStub"
local minor = tonumber(string.match("$Revision: 466 $", "(%d+)") or 1)

local g = getfenv(0)

if not g.DongleStub or g.DongleStub:IsNewerVersion(major, minor) then
	local lib = setmetatable({}, {
		__call = function(t,k) 
			if type(t.versions) == "table" and t.versions[k] then 
				return t.versions[k].instance
			else
				error("Cannot find a library with name '"..tostring(k).."'", 2)
			end
		end
	})

	function lib:HasVersion(major)
		if type(major) ~= "string" then
			error("bad argument #2 to 'HasVersion' (string expected, got " .. type(major) .. ")", 2)
		end

		local instance = self.versions and self.versions[major]
		return instance ~= nil
	end

	function lib:IsNewerVersion(major, minor)
		local versionData = self.versions and self.versions[major]
		if not versionData then return true end
		local oldmajor,oldminor = versionData.instance:GetVersion()
		return minor > oldminor
	end
	
	local function NilCopyTable(src, dest)
		for k,v in pairs(dest) do dest[k] = nil end
		for k,v in pairs(src) do dest[k] = v end
	end

	function lib:Register(newInstance, activate, deactivate)
		if type(newInstance) ~= "table" then
			error("bad argument #2 to 'Register' (table expected, got " .. type(newInstance) .. ")", 2)
		end

		if type(newInstance.GetVersion) ~= "function" then
			error("Attempt to register a library with DongleStub that does not have a 'GetVersion' method.", 2)
		end

		local major,minor = newInstance:GetVersion()
		if type(major) ~= "string" then
			error("Attempt to register a library with DongleStub that does not have a proper major version.", 2)
		end

		if type(minor) ~= "number" then
			error("Attempt to register a library with DongleStub that does not have a proper minor version.", 2)
		end

		-- Generate a log of all library registrations
		if not self.log then self.log = {} end
		table.insert(self.log, string.format("Register: %s, %s", major, minor))

		if not self:IsNewerVersion(major, minor) then return false end
		if not self.versions then self.versions = {} end

		local versionData = self.versions[major]
		if not versionData then
			-- New major version
			versionData = {
				["instance"] = newInstance,
				["deactivate"] = deactivate,
			}
			
			self.versions[major] = versionData
			if type(activate) == "function" then
				table.insert(self.log, string.format("Activate: %s, %s", major, minor))
				activate(newInstance)
			end
			return newInstance
		end
		
		local oldDeactivate = versionData.deactivate
		local oldInstance = versionData.instance
		
		versionData.deactivate = deactivate
		
		local skipCopy
		if type(activate) == "function" then
			table.insert(self.log, string.format("Activate: %s, %s", major, minor))
			skipCopy = activate(newInstance, oldInstance)
		end

		-- Deactivate the old libary if necessary
		if type(oldDeactivate) == "function" then
			local major, minor = oldInstance:GetVersion()
			table.insert(self.log, string.format("Deactivate: %s, %s", major, minor))
			oldDeactivate(oldInstance, newInstance)
		end

		-- Re-use the old table, and discard the new one
		if not skipCopy then
			NilCopyTable(newInstance, oldInstance)
		end
		return oldInstance
	end

	function lib:GetVersion() return major,minor end

	local function Activate(new, old)
		-- This code ensures that we'll move the versions table even
		-- if the major version names are different, in the case of 
		-- DongleStub
		if not old then old = g.DongleStub end

		if old then
			new.versions = old.versions
			new.log = old.log
		end
		g.DongleStub = new
	end
	
	-- Actually trigger libary activation here
	local stub = g.DongleStub or lib
	lib = stub:Register(lib, Activate)
end
