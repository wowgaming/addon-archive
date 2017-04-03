--[[
	SelectBox
	Version: 3.1.14 (<%codename%>)
	Revision: $Id: SelectBox.lua 135 2008-10-13 05:52:44Z Norganna $
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

local LIBRARY_VERSION_MAJOR = "SelectBox"
local LIBRARY_VERSION_MINOR = 4

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

LibStub("LibRevision"):Set("$URL: http://svn.norganna.org/libs/trunk/Configator/SelectBox.lua $","$Rev: 135 $","5.1.DEV.", 'auctioneer', 'libs')

local NUM_MENU_ITEMS = 15

local kit = {}
local buttonKit = {}

local keys = {}
local values = {}

function kit:GetItems()
	for pos in pairs(keys) do keys[pos] = nil end
	for pos in pairs(values) do values[pos] = nil end

	local curpos
	local current = self.value

	local items
	if type(self.items) == "function" then
		items = self.items()
	else
		items = self.items
	end

	if (not items) then items = {} end

	local key, value
	for pos, item in ipairs(items) do
		if type(item) == "table" then
			key = item[1]
			value = item[2]
		else
			key = item
			value = item
		end
		if (key) then
			table.insert(keys, key)
			table.insert(values, value)
			if (not curpos and type(key)==type(current) and key==current) then
				curpos = table.getn(keys)
			end
		end
	end

	return curpos or 1
end

function kit:SetWidth(width)
	local fname = self:GetName()
	self:origSetWidth(width + 50)
	self.curWidth = width
	getglobal(fname.."Middle"):SetWidth(width)
	getglobal(fname.."Text"):SetWidth(width - 25)
	self:UpdateInset()
end

function kit:UpdateInset()
	local leftInset = -2
	if not self.hiddenInput then
		leftInset = 5-self.curWidth
	end
	local fname = self:GetName()
	getglobal(fname.."Button"):SetHitRectInsets(leftInset, -2,-2,-2)
end

function kit:SetInputHidden(hide)
	local fname = self:GetName()
	if hide then
		self.hiddenInput = true
		getglobal(fname.."Left"):Hide()
		getglobal(fname.."Middle"):Hide()
		getglobal(fname.."Right"):Hide()
		getglobal(fname.."Text"):Hide()
	else
		self.hiddenInput = nil
		getglobal(fname.."Left"):Show()
		getglobal(fname.."Middle"):Show()
		getglobal(fname.."Right"):Show()
		getglobal(fname.."Text"):Show()
	end
	self:UpdateInset()
end

function kit:GetHeight()
	local minx,miny,width,height = self:GetBoundsRect()
	return height
end

function kit:GetWidth()
	local minx,miny,width,height = self:GetBoundsRect()
	return width
end

function kit:SetText(text)
	local fname = self:GetName()
	getglobal(fname.."Text"):SetText(text)
end

function kit:UpdateValue()
	local pos = self:GetItems()
	self:SetText(values[pos])
end

function kit:OnClose()
	if (lib.menu.currentBox == self) then
		lib:DoHide()
	end
end


function buttonKit:Open()
	local box = self
	if not box.items then box = self:GetParent() end
	if not box.items then box = this:GetParent() end
	if not box.items then error("Unable to open menu") end

	PlaySound("igMainMenuOptionCheckBoxOn")
	lib.menu:ClearAllPoints()
	lib.menu:SetPoint("TOPLEFT", box, "TOPLEFT", 0, 0)
	lib.menu:SetWidth(box:GetWidth())

	lib.menu.currentBox = box
	lib.menu.cp = nil
	lib.menu.ts = nil
	lib.menu.position = box:GetItems()
	lib:DoUpdate()
	lib:DoShow()
end

function lib:Create(name, parent, width, callback, list, current)
	local frame = CreateFrame("Frame", name, parent, "SelectBoxTemplate_v1")
	if (not width) then width = 100 end
	frame.items = list
	frame.value = current
	frame.onsel = callback
	frame.origSetWidth = frame.SetWidth
	frame.button = _G[name.."Button"]

	for k,v in pairs(kit) do
		frame[k] = v
	end
	for k,v in pairs(buttonKit) do
		_G[name.."Button"][k] = v
	end

	frame:SetWidth(width)
	return frame
end

function lib:DoUpdate()
	local key, value, pos, j

	local ts, cp
	if (lib.menu.cp) then
		cp = lib.menu.cp
		ts = lib.menu.ts
	else
		ts = table.getn(keys)
		cp = lib.menu.position
		cp = math.max(1, math.min(cp-7, ts-10))
		lib.menu.cp = cp
		lib.menu.ts = ts
	end

	j = 0
	for i = 1, NUM_MENU_ITEMS do
		pos = cp + i - 1
		if (i==1 and pos > 1) then
			j = j + 1
			lib.menu.buttons[j].index = "prev"
			lib.menu.buttons[j]:SetText("...")
			lib.menu.buttons[j]:Show()
		elseif (i == NUM_MENU_ITEMS and pos < ts) then
			j = j + 1
			lib.menu.buttons[j].index = "next"
			lib.menu.buttons[j]:SetText("...")
			lib.menu.buttons[j]:Show()
		else
			key = keys[pos]
			value = values[pos]
			if (key) then
				j = j + 1
				lib.menu.buttons[j].index = pos
				lib.menu.buttons[j]:SetText(value)
				lib.menu.buttons[j]:Show()
			end
		end
	end
	local total = j
	for i = j+1, NUM_MENU_ITEMS do
		lib.menu.buttons[i]:SetText("")
		lib.menu.buttons[i]:Hide()
	end

	local height = 50
	height = max(height, 42 + (total * 12))

	lib.menu:SetHeight(height)
end

function lib:DoShow()
	lib.menu:SetAlpha(0)
	lib.menu:Show()
	UIFrameFadeIn(lib.menu, 0.15, 0, 1)
end
function lib:DoHide()
	lib.menu:Hide()
end
function lib:DoFade()
	UIFrameFadeOut(lib.menu, 0.25, 1, 0)
	lib.menu.fadeInfo.finishedFunc = lib.DoHide
end

local scrollTime = 0.2
function lib:MouseIn()
	if (self.index == 'prev') then
		lib.menu.scrollTimer = scrollTime
		lib.menu.scrollDir = -1
	elseif (self.index == 'next') then
		lib.menu.scrollTimer = scrollTime
		lib.menu.scrollDir = 1
	end
	lib.menu.outTimer = nil
end
function lib:MouseOut()
	lib.menu.scrollTimer = nil
	lib.menu.outTimer = 0.5
end
function lib:OnUpdate(delay)
	if (not delay) then return end
	if (lib.menu.scrollTimer ~= nil) then
		lib.menu.scrollTimer = lib.menu.scrollTimer - delay
		if lib.menu.scrollTimer <= 0 then
			lib.menu.scrollTimer = lib.menu.scrollTimer + scrollTime
			lib.menu.cp = math.max(1, math.min(lib.menu.ts-9, lib.menu.cp + lib.menu.scrollDir))
			lib:DoUpdate()
		end
	end

	if (not lib.menu.outTimer) then return end
	lib.menu.outTimer = lib.menu.outTimer - delay
	if (lib.menu.outTimer <= 0) then
		lib.menu.outTimer = nil
		lib:DoFade()
	end
end

function lib:OnClick()
	local pos = self.index
	if (type(pos) == 'string') then return end
	lib.menu.currentBox.value = keys[pos]			-- the value for setter callback
	lib.menu.currentBox:SetText(values[pos])		-- the string shown in the UI
	lib.menu.currentBox:onsel(pos, keys[pos], values[pos])
	lib:DoHide()
end

if not lib.menu then
	lib.menu = CreateFrame("Frame", "SelectBoxMenu", UIParent)
	lib.menu:Hide()
	lib.menu:SetWidth(120)
	lib.menu:SetHeight(16 * NUM_MENU_ITEMS + 5)
	lib.menu:EnableMouse(true)
	lib.menu:SetFrameStrata("TOOLTIP")
	lib.menu:SetScript("OnEnter", lib.MouseIn)
	lib.menu:SetScript("OnLeave", lib.MouseOut)
	lib.menu:SetScript("OnMouseDown", lib.DoHide)
	lib.menu:SetScript("OnUpdate", lib.OnUpdate)

	lib.menu.back = CreateFrame("Frame", "", lib.menu)
	lib.menu.back:SetPoint("TOPLEFT", lib.menu, "TOPLEFT", 15, -20)
	lib.menu.back:SetPoint("BOTTOMRIGHT", lib.menu, "BOTTOMRIGHT", -15, 10)
	lib.menu.back:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 32, edgeSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	lib.menu.back:SetBackdropColor(0,0,0, 0.8)
	lib.menu.buttons = {}
	for i=1, NUM_MENU_ITEMS do
		local l = CreateFrame("Button", "SelectBoxMenuButton"..i, lib.menu.back)
		lib.menu.buttons[i] = l
		if (i == 1) then
			l:SetPoint("TOPLEFT", lib.menu.back, "TOPLEFT", 0,-5)
		else
			l:SetPoint("TOPLEFT", lib.menu.buttons[i-1], "BOTTOMLEFT", 0,0)
		end
		l:SetPoint("RIGHT", lib.menu.back, "RIGHT", 0,0)
		if ( l.SetTextFontObject ) then l.SetNormalFontObject = l.SetTextFontObject end -- WotLK Hack
		l:SetNormalFontObject (GameFontHighlightSmall)
		l:SetHighlightFontObject(GameFontNormalSmall)
		l:SetHeight(12)
		l:SetText("Line "..i)
		l:SetScript("OnEnter", lib.MouseIn)
		l:SetScript("OnLeave", lib.MouseOut)
		l:SetScript("OnClick", lib.OnClick)
	--	getglobal("SelectBoxMenuButton"..i.."Text"):SetJustifyH("LEFT")
		l:Show()
	end

	cmenu = lib.menu
end
