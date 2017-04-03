--[[
	PanelScroller
	Version: 3.1.14 (<%codename%>)
	Revision: $Id: PanelScroller.lua 130 2008-10-11 12:38:07Z Norganna $
	URL: http://auctioneeraddon.com/dl/

	License:
		This library is free software; you can redistribute it and/or
		modify it under the terms of the GNU Lesser General Public
		License as published by the Free Software Foundation; either
		version 2.1 of the License, or (at your option) any later version.

		This library is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
		Lesser General Public License for more details.

		You should have received a copy of the GNU Lesser General Public
		License along with this library; if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor,
		Boston, MA  02110-1301  USA

	Additional:
		Regardless of any other conditions, you may freely use this code
		within the World of Warcraft game client.
--]]

local LIBRARY_VERSION_MAJOR = "PanelScroller"
local LIBRARY_VERSION_MINOR = 2

do -- LibStub
	-- LibStub is a simple versioning stub meant for use in Libraries.  http://www.wowace.com/wiki/LibStub for more info
	-- LibStub is hereby placed in the Public Domain
	-- Credits: Kaelten, Cladhaire, ckknight, Mikk, Ammo, Nevcairiel, joshborke
	local LIBSTUB_MAJOR, LIBSTUB_MINOR = "LibStub", 2  -- NEVER MAKE THIS AN SVN REVISION! IT NEEDS TO BE USABLE IN ALL REPOS!
	local LibStub = _G[LIBSTUB_MAJOR]

	-- Check to see is this version of the stub is obsolete
	if not LibStub or LibStub.minor < LIBSTUB_MINOR then
		LibStub = LibStub or {libs = {}, minors = {} }
		_G[LIBSTUB_MAJOR] = LibStub
		LibStub.minor = LIBSTUB_MINOR

		-- LibStub:NewLibrary(major, minor)
		-- major (string) - the major version of the library
		-- minor (string or number ) - the minor version of the library
		--
		-- returns nil if a newer or same version of the lib is already present
		-- returns empty library object or old library object if upgrade is needed
		function LibStub:NewLibrary(major, minor)
			assert(type(major) == "string", "Bad argument #2 to `NewLibrary' (string expected)")
			minor = assert(tonumber(strmatch(minor, "%d+")), "Minor version must either be a number or contain a number.")

			local oldminor = self.minors[major]
			if oldminor and oldminor >= minor then return nil end
			self.minors[major], self.libs[major] = minor, self.libs[major] or {}
			return self.libs[major], oldminor
		end

		-- LibStub:GetLibrary(major, [silent])
		-- major (string) - the major version of the library
		-- silent (boolean) - if true, library is optional, silently return nil if its not found
		--
		-- throws an error if the library can not be found (except silent is set)
		-- returns the library object if found
		function LibStub:GetLibrary(major, silent)
			if not self.libs[major] and not silent then
				error(("Cannot find a library instance of %q."):format(tostring(major)), 2)
			end
			return self.libs[major], self.minors[major]
		end

		-- LibStub:IterateLibraries()
		--
		-- Returns an iterator for the currently registered libraries
		function LibStub:IterateLibraries()
			return pairs(self.libs)
		end

		setmetatable(LibStub, { __call = LibStub.GetLibrary })
	end
end -- LibStub

local lib = LibStub:NewLibrary(LIBRARY_VERSION_MAJOR, LIBRARY_VERSION_MINOR)
if not lib then return end

LibStub("LibRevision"):Set("$URL: http://svn.norganna.org/libs/trunk/Configator/PanelScroller.lua $","$Rev: 130 $","5.1.DEV.", 'auctioneer', 'libs')

local kit = {
	hPos = 0, hSize = 0, hWin = 0, hType = "AUTO",
	vPos = 0, vSize = 0, vWin = 0, vType = "YES",
}

-- Set whether to allow horizontal scrolling ("YES", "NO" or "AUTO")
function kit:SetScrollBarVisible(axis, visibility)
	if not (visibility == "YES"
		or visibility == "NO"
		or visibility == "AUTO"
		or visibility == "FAUX"
	) then
		return error("Invalid visibility, must be one of YES, NO or AUTO")
	end
	if axis == "HORIZONTAL" then
		self.hType = visibility
	elseif axis == "VERTICAL" then
		self.vType = visibility
	else
		return error("Invalid axis type, must be one of HORIZONTAL or VERTICAL")
	end

	self:Update()
end

function kit:MouseScroll(direction)
	if self.vType == "NO" then
		if self.hType == "FAUX" then
			self:ScrollByPixels("HORIZONTAL", -1 * direction)
		elseif self.hType ~= "NO" then
			self:ScrollByPercent("HORIZONTAL", -0.1 * direction)
		end
	elseif self.vType == "FAUX" then
		self:ScrollByPixels("VERTICAL", -1 * direction)
	else
		self:ScrollByPercent("VERTICAL", -0.1 * direction)
	end
end

-- Performs a scroll along the specified axis by a given percentage of the window size
--This % will always be 1 page of datain the vertical direction
function kit:ScrollByPercent(axis, percent)
	local scrollbar, curpos, winsize, scrollrange
	if axis == "HORIZONTAL" then
		scrollbar = self.hScroll
		scrollrange = self.hSize
		winsize = self.hWin
		curpos = self.hPos
		--horizontal will be % of  total size
		percent = (winsize*percent)
	elseif axis == "VERTICAL" then
		scrollbar = self.vScroll
		scrollrange = self.vSize
		winsize = self.vWin
		curpos = self.vPos
		--vertical is 1 page of data varies by # of  data rows in that scrollframe or (winsize*percent)
		if self:GetParent().sheet and self:GetParent().sheet.rows then
			if percent > 0 then
				percent = #self:GetParent().sheet.rows
			else
				percent = -#self:GetParent().sheet.rows
			end
		else
			percent = (winsize*percent)
		end
	else
		return error("Unknown axis for scrolling, must be one of HORIZONTAL or VERTICAL")
	end
	local dest = math.max(0, math.min(curpos + (percent), scrollrange))
	if (abs(dest - curpos) > 0.01) then
		scrollbar:SetValue(dest)
	end
	self:ScrollSync()
end

-- Performs a scroll along the specified axis by a given number of pixels
function kit:ScrollByPixels(axis, pixels)
	local scrollbar, curpos, scrollrange
	if axis == "HORIZONTAL" then
		scrollbar = self.hScroll
		scrollrange = self.hSize
		curpos = self.hPos
	elseif axis == "VERTICAL" then
		scrollbar = self.vScroll
		scrollrange = self.vSize
		curpos = self.vPos
	else
		return error("Unknown axis for scrolling, must be one of HORIZONTAL or VERTICAL")
	end
	local dest = math.max(0, math.min(curpos + pixels, scrollrange))
	if (abs(dest - curpos) > 0.01) then
		scrollbar:SetValue(dest)
	end
	self:ScrollSync()
end

function kit:ScrollToCoords(x, y)
	if x then
		local dest = math.max(0, math.min(x, self.hSize))
		if (abs(dest - x) > 0.01) then
			self.hScroll:SetValue(dest)
		end
	end
	if y then
		local dest = math.max(0, math.min(y, self.vSize))
		if (abs(dest - y) > 0.01) then
			self.vScroll:SetValue(dest)
		end
	end
	self:ScrollSync()
end

function kit:ScrollSync()
	if (self.hType ~= "FAUX") then
		self:SetHorizontalScroll(self.hScroll:GetValue() * -1)
	end
	if (self.vType ~= "FAUX") then
		self:SetVerticalScroll(self.vScroll:GetValue())
	end
	self:Update()
end

-- This function updates the entire scrollable unit, hidin
function kit:Update()
	self:UpdateScrollChildRect()

	if self.hType ~= "FAUX" then
		self.hSize = self:GetHorizontalScrollRange();
	end
	if self.vType ~= "FAUX" then
		self.vSize = self:GetVerticalScrollRange();
	end

	self.hPos = self.hScroll:GetValue()
	self.vPos = self.vScroll:GetValue()

	self.hWin = self:GetWidth()
	self.vWin = self:GetHeight()

	if (self.hPos > self.hSize) then self.hPos = self.hSize end
	if (self.vPos > self.vSize) then self.vPos = self.vSize end

	local hMin, hMax = self.hScroll:GetMinMaxValues()
	local vMin, vMax = self.vScroll:GetMinMaxValues()
	if abs(hMin) > 0.01 or abs(vMin) > 0.01 or
	abs(hMax-self.hSize) > 0.01 or
	abs(vMax-self.vSize) > 0.01 then
		self.hScroll:SetMinMaxValues(0, self.hSize)
		self.vScroll:SetMinMaxValues(0, self.vSize)

		self.hScroll:SetValue(self.hPos)
		self.vScroll:SetValue(self.vPos)
	end

	if self.hType == "NO" then
		self.hScroll:Hide()
	elseif self.hType == "FAUX" then
		self.hScroll:Show()
		self.hScroll.incrButton:Enable()
		self.hScroll.decrButton:Enable()
	elseif math.floor(self.hSize-30) <= 0 then
		if self.hType == "YES" then
			self.hScroll:Show()
			self.hScroll.incrButton:Disable()
			self.hScroll.decrButton:Disable()
		else
			self.hScroll:Hide()
		end
	else
		self.hScroll:Show()
		self.hScroll.incrButton:Enable()
		self.hScroll.decrButton:Enable()
	end

	if self.vType == "NO" then
		self.vScroll:Hide()
	elseif self.vType == "FAUX" then
		self.vScroll:Show()
		self.vScroll.incrButton:Enable()
		self.vScroll.decrButton:Enable()
	elseif math.floor(self.vSize) <= 0 then
		if self.vType == "YES" then
			self.vScroll:Show()
			self.vScroll.incrButton:Disable()
			self.vScroll.decrButton:Disable()
		else
			self.vScroll:Hide()
		end
	else
		self.vScroll:Show()
		self.vScroll.incrButton:Enable()
		self.vScroll.decrButton:Enable()
	end

	if self.callback then
		self.callback()
	end
end

function lib:Create(name, parent)
	local scroller = CreateFrame("ScrollFrame", name, parent, "PanelScrollerTemplate_v1")
	scroller.hScroll = getglobal(name.."HorizontalScrollBar");
	scroller.vScroll = getglobal(name.."VerticalScrollBar");
	for k,v in pairs(kit) do
		scroller[k] = v
	end
	return scroller
end
