--[[
--        LibTickTock.lua
--           Timer functionality
--           Written by Ken Allan <ken@norganna.org>
--           This code is hereby released into the Public Domain without warranty.
--
--        Usage:
--           local LibTickTock = LibStub("LibTickTock")
--           local timer = LibTickTock:New()
--
--           timer.func = myFunction
--           timer:RegisterEvent("EVENT_NAME")
--           timer:Wait()
--           timer:CountDown(1.5)
--           -- The timer will start when event fires or in 1.5 seconds
--           -- If function is not set, or returns false, the timer will stop
--           timer:Start() -- Manually start the timer
--           timer:Stop() -- Manually stop the timer/countdown/waits
--]]

local LIBRARY_VERSION_MAJOR = "LibTickTock"
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

lib.kit={}

function lib:New()
	local timer = CreateFrame("Frame", nil, UIParent)
	for k,v in pairs(self.kit) do
		timer[k] = v
	end
	return timer
end

function lib.kit:OnUpdate(delay)
	-- Check if we're counting down
	if self.countdown and self.countdown > 0 then
		self.countdown = self.countdown - delay
	-- Check if we've just finished counting down
	elseif self.countdown then
		self.countdown = nil
		self:Start()
	-- Process the function
	elseif (self.func and self.func()) then
		return
	-- Otherwise stop the timer
	else
		self:Stop()
	end
end

function lib.kit:Start()
	-- Clear the auction list update event waiting and begin ticking
	self:SetScript("OnEvent", nil)
	self:SetScript("OnUpdate", self.OnUpdate)
	if self.feedback then self.feedback("Started timer") end
end

function lib.kit:Stop()
	-- Stop ticking and waiting for auction list update
	self:SetScript("OnEvent", nil)
	self:SetScript("OnUpdate", nil)
	if self.feedback then self.feedback("Stopped timer") end
end

function lib.kit:CountDown(n)
	self.countdown = n
	self:SetScript("OnUpdate", self.OnUpdate)
	if self.feedback then self.feedback("Beginning countdown of", n, "seconds") end
end

function lib.kit:Wait()
	-- Wait for the auction list to update then start the timer
	self:SetScript("OnEvent", self.Start)
	if self.feedback then self.feedback("Timer is waiting for event") end
end

