--[[
	Configator - A library to help you create a gui config
	Version: 3.1.14 (<%codename%>)
	Revision: $Id: Configator.lua 190 2009-02-08 22:03:37Z ccox $
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

--------------------------------------------------------------------------

USAGE:

	Stub   Configator = LibStub:GetLibrary("Configator")
	Call   myCfg = Configator:Create(setterFunc, getterFunc)
	Call   tabId = myCfg:AddTab(TabName)
	Call   myCfg:AddControl(tabId, controlType, leftPct, ...)
	Wait   for callbacks on your getters and setters

	Your setter will be called with (variableName, value) for you to set
	Your getter will be called with (variableName) for your to return the current value

	The AddControl function's ... varies depending on the controlType:
	"Header" == text
	"Subhead" == text
	"Checkbox" == level, setting, label
	"Slider", "TinySlider", "WideSlider", "NumeriSlider", "NumeriTiny", "NumeriWide"
	   == level, setting, min, max, step, label, fmtfunc
	"Text" = level, setting, label
	"NumberBox", "TinyNumber"
	   == level, setting, minVal, maxVal, label
	"MoneyFrame", "PinnedMoney" = level, setting, label
	"ColorSelect", "ColorSelectAlpha" == level, setting, label


	Settings and configuration system.
]]

local LIBRARY_VERSION_MAJOR = "Configator"
local LIBRARY_VERSION_MINOR = 25

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

LibStub("LibRevision"):Set("$URL: http://svn.norganna.org/libs/trunk/Configator/Configator.lua $","$Rev: 190 $","5.1.DEV.", 'auctioneer', 'libs')

local kit = {}

if not lib.frames then lib.frames = {} end
if not lib.tmpId then lib.tmpId = 0 end

-- Table management functions:
local function replicate(source, depth, history)
	if type(source) ~= "table" then return source end
	assert(depth==nil or tonumber(depth), "Unknown depth: " .. tostring(depth))
	if not depth then depth = 0 history = {} end
	assert(history, "Have depth but without history")
	assert(depth < 100, "Structure is too deep")
	local dest = {} history[source] = dest
	for k, v in pairs(source) do
		if type(v) == "table" then
			if history[v] then dest[k] = history[v]
			else dest[k] = replicate(v, depth+1, history) end
		else dest[k] = v end
	end
	return dest
end
local function empty(item)
	if type(item) ~= 'table' then return end
	for k,v in pairs(item) do item[k] = nil end
end
local function fill(item, ...)
	if type(item) ~= 'table' then return end
	if (#item > 0) then empty(item) end
	local n = select('#', ...)
	for i = 1,n do item[i] = select(i, ...) end
end
-- End table management functions

function lib:CreateAnonName()
	lib.tmpId = lib.tmpId + 1
	return "ConfigatorAnon"..lib.tmpId
end

local function setFocus(focusType, object, focus)
	if focusType == "NEXT" then
		object.nextFocus = focus
		if (object.isMoneyFrame) then
			MoneyInputFrame_SetNextFocus(object, focus)
		end
	elseif focusType == "PREV" then
		object.previousFocus = focus
		if (object.isMoneyFrame) then
			MoneyInputFrame_SetPreviousFocus(object, focus)
		end
	end
end

function lib:TabLink(frame, el, noHook)
	if not frame.firstFocus then
		frame.firstFocus = el
		setFocus("NEXT", el, el)
		setFocus("PREV", el, el)
	else
		local curLast = frame.lastFocus
		local first = frame.firstFocus

		setFocus("NEXT", curLast, el)
		setFocus("PREV", first, el)
		setFocus("NEXT", el, first)
		setFocus("PREV", el, curLast)
	end
	frame.lastFocus = el

	if not noHook and not el.isMoneyFrame then
		el:SetScript("OnTabPressed", kit.FocusShift)
	end
end

local function proxyHide(self)
	self.gui:Hide()	
end

local function proxyIsShown(self)
	return self.gui.Backdrop:IsVisible()
end


function lib:Create(setter, getter, dialogWidth, dialogHeight, gapWidth, gapHeight, topOffset, leftOffset)
	local id = #(lib.frames) + 1
	local name = "ConfigatorDialog_"..id

	if not dialogWidth then dialogWidth = 800 end
	if not dialogHeight then dialogHeight = 450 end
	if not gapWidth then gapWidth = 0 end
	if not gapHeight then gapHeight = 0 end

	local gui = CreateFrame("Frame", name, UIParent)
	table.insert(lib.frames, gui)
	gui.setter = setter
	gui.getter = getter
	gui.dialogWidth  = dialogWidth
	gui.dialogHeight = dialogHeight
	gui.gapWidth     = gapWidth
	gui.gapHeight    = gapHeight
	gui.topOffset    = topOffset
	gui.leftOffset   = leftOffset
	gui.heightDelta  = 0
	gui.buttonTop    = 0

	local top = getter("configator.top")
	local left = getter("configator.left")
	if (top and left) then
		gui:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", left, top)
	else
		gui:SetPoint("CENTER", "UIParent", "CENTER")
	end
	gui:Hide()
	gui:SetFrameStrata("HIGH")
	gui:SetToplevel(true)
	gui:SetMovable(true)
	gui:SetWidth(dialogWidth)
	gui:SetHeight(dialogHeight)
	gui:EnableMouse(true)

	gui.Backdrop = CreateFrame("Frame", name.."Backdrop", gui)
	gui.Backdrop:SetAllPoints(gui)
	gui.Backdrop:SetBackdrop({
		bgFile = "Interface/Tooltips/ChatBubble-Background",
		edgeFile = "Interface/Tooltips/ChatBubble-BackDrop",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 32, right = 32, top = 32, bottom = 32 }
	})
	gui.Backdrop:SetBackdropColor(0, 0, 0, 1)

	-- Create a proxy to see if we should react to global CloseWindow() calls
	gui.Proxy = CreateFrame("Frame", name.."Proxy", gui)
	gui.Proxy.gui = gui
	table.insert(UISpecialFrames, name.."Proxy") -- make frames Esc Sensitive by default
	gui.Proxy.Hide = proxyHide
	gui.Proxy.IsShown = proxyIsShown

	gui.Done = CreateFrame("Button", nil, gui.Backdrop, "OptionsButtonTemplate")
	gui.Done:SetPoint("BOTTOMRIGHT", gui, "BOTTOMRIGHT", -10, 10)
	gui.Done:SetScript("OnClick", function() gui:Hide() end)
	gui.Done:SetText(DONE)

	gui.DragTop = CreateFrame("Button", nil, gui.Backdrop)
	gui.DragTop:SetPoint("TOPLEFT", gui.Backdrop, "TOPLEFT", 10,-5)
	gui.DragTop:SetPoint("TOPRIGHT", gui.Backdrop, "TOPRIGHT", -10,-5)
	gui.DragTop:SetHeight(6)
	gui.DragTop:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")

	gui.DragTop:SetScript("OnMouseDown", function() gui:StartMoving() end)
	gui.DragTop:SetScript("OnMouseUp", function() gui:StopMovingOrSizing() setter("configator.left", gui:GetLeft()) setter("configator.top", gui:GetTop()) end)

	gui.DragBottom = CreateFrame("Button", nil, gui.Backdrop)
	gui.DragBottom:SetPoint("BOTTOMLEFT", gui.Backdrop, "BOTTOMLEFT", 10,5)
	gui.DragBottom:SetPoint("BOTTOMRIGHT", gui.Backdrop, "BOTTOMRIGHT", -10,5)
	gui.DragBottom:SetHeight(6)
	gui.DragBottom:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")

	gui.DragBottom:SetScript("OnMouseDown", function() gui:StartMoving() end)
	gui.DragBottom:SetScript("OnMouseUp", function() gui:StopMovingOrSizing() setter("configator.left", gui:GetLeft()) setter("configator.top", gui:GetTop()) end)

	gui:RegisterEvent("PLAYER_LOGOUT")
	gui:SetScript("OnEvent", function() gui:SetClampedToScreen(1) setter("configator.left", gui:GetLeft()) setter("configator.top", gui:GetTop()) end)

	gui.config = {
		current = "",
		order = { "" },
		tabs = { [""] = {}, },
		cats = { [""] = {}, },
	}
	gui.tabs = {}
	gui.elements = {}

	for k,v in pairs(kit) do
		gui[k] = v
	end

	return gui
end


-- this shows the game toolip for a specified link
function lib:SetLinkTip(frame, link)
	if not frame or link == nil then
		GameTooltip:Hide()
		return
	end
	GameTooltip:SetOwner(frame, "ANCHOR_NONE")
	GameTooltip:SetHyperlink(link)
	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("TOPRIGHT", frame, "TOPLEFT", -10, -20)
	GameTooltip:Show()
end

-- Create a special tooltip just for us
if not lib.tooltip then
	lib.tooltip = CreateFrame("GameTooltip", "ConfigatorTipTooltip", UIParent, "GameTooltipTemplate")
	local function hide_tip()
		lib.tooltip:Hide()
	end
	lib.tooltip.fadeInfo = {}
	function lib:SetTip(frame, ...)
		local n = select("#", ...)
		if n == 1 then
			-- Allow passing of tip lines as a single table
			local tip = select(1, ...)
			if type(tip) == "table" then
				lib:SetTip(frame, unpack(tip))
				return
			end
		end

		if not frame or n == 0 then
			lib.tooltip.fadeInfo.finishedFunc = hide_tip
			local curAlpha = lib.tooltip:GetAlpha()
			UIFrameFadeOut(lib.tooltip, 0.25, curAlpha, 0)
			lib.tooltip:SetAlpha(curAlpha)
			lib.tooltip.schedule = nil
			return
		end

		if lib.tooltip:GetAlpha() > 0 then
			-- Speed up this fade
			UIFrameFadeOut(lib.tooltip, 0.01, 0, 0)
			lib.tooltip:SetAlpha(0)
		end

		lib.tooltip:SetOwner(frame, "ANCHOR_NONE")
		lib.tooltip:ClearLines()

		local tip
		for i=1, n do
			tip = select(i, ...)
			lib.tooltip:AddLine(tostring(tip) or "", 1,1,0.5, 1)
		end
		lib.tooltip:Show()
		lib.tooltip:SetAlpha(0)
		lib.tooltip:SetBackdropColor(0,0,0, 1)
		lib.tooltip:SetPoint("TOP", frame, "BOTTOM", 10, -5)
		lib.tooltip.schedule = GetTime() + 1
	end
	lib.tooltip:SetScript("OnUpdate", function()
		if lib.tooltip.schedule and GetTime() > lib.tooltip.schedule then
			local curAlpha = lib.tooltip:GetAlpha()
			UIFrameFadeIn(lib.tooltip, 0.33, curAlpha, 1)
			lib.tooltip:SetAlpha(curAlpha) -- Tooltips set alpha when they are shown, and UIFrameFadeIn does a :Show()
			lib.tooltip.schedule = nil
		end
	end)
	lib.tooltip:SetBackdrop({
		bgFile = "Interface/Tooltips/ChatBubble-Background",
		edgeFile = "Interface/Tooltips/ChatBubble-BackDrop",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 32, right = 32, top = 32, bottom = 32 }
	})
	lib.tooltip:SetBackdropColor(0,0,0.3, 1)
	lib.tooltip:SetClampedToScreen(true)
end

-- Create our help window
if not lib.help then
	lib.help = CreateFrame("Frame", "ConfigatorHelpFrame", UIParent)
	lib.help:SetBackdrop({
		bgFile = "Interface/Stationery/StationeryTest1",
		edgeFile = "Interface/TUTORIALFRAME/TUTORIALFRAMEBORDER",
		tile = false, tileSize = 32, edgeSize = 32,
		insets = { left = 4, right = 4, top = 22, bottom = 4 }
	})
	lib.help:SetBackdropColor(0.15,0.15,0.15, 0.98)
	lib.help:SetToplevel(true)
	lib.help:SetPoint("CENTER")
	lib.help:SetWidth(450)
	lib.help:SetHeight(500)
	lib.help:SetMovable(true)
	lib.help:EnableMouse(true)
	lib.help:SetScript("OnUpdate", function() if lib.help.refresh then lib.help.Update() end end)
	lib.help:SetScript("OnEvent", function() if lib.help:IsVisible() then lib.help.Update() end end)
	lib.help:RegisterEvent("UPDATE_FLOATING_CHAT_WINDOWS")
	lib.help:Hide()

	lib.help.title = CreateFrame("Button", nil, lib.help)
	lib.help.title:SetScript("OnMouseDown", function() lib.help:StartMoving() end)
	lib.help.title:SetScript("OnMouseUp", function() lib.help:StopMovingOrSizing() end)
	lib.help.title:SetPoint("TOPLEFT", lib.help, "TOPLEFT", 3,-3)
	lib.help.title:SetPoint("BOTTOMRIGHT", lib.help, "TOPRIGHT", -28,-20)
	lib.help.title:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")
	if ( lib.help.title.SetTextFontObject ) then lib.help.title.SetNormalFontObject = lib.help.title.SetTextFontObject end -- WotLK Hack
	lib.help.title:SetNormalFontObject("GameFontNormal")
	lib.help.title:SetText("Help Window")

	lib.help.close = CreateFrame("Button", nil, lib.help, "UIPanelCloseButton")
	lib.help.close:SetPoint("TOPRIGHT", lib.help, "TOPRIGHT", 3, 5)
	lib.help.close:SetHeight(32)
	lib.help.close:SetWidth(32)
	lib.help.close:SetScript("OnClick", function () lib.help:Hide() end)

	lib.help.content = CreateFrame("Frame", "ConfigatorHelpContent", lib.help)
	lib.help.content:SetWidth(420)
	lib.help.content:SetHeight(100)
	lib.help.content.totalHeight = 0

	lib.help.rows = {}
	lib.help.fontcache = {}
	function lib.help:AddHelp(question, answer)
		lib.help:AddRow(question, 14, 1,0.9,0, 8)
		lib.help:AddRow(answer, 12, 1,1,1)
	end
	function lib.help:AddRow(text, size, r,g,b, pad)
		if not size then size = 12 end
		if not (r and g and b) then r,g,b = 1,1,1 end
		if not pad then pad = 0 end

		local font
		local remain = #lib.help.fontcache
		if remain > 0 then
			font = lib.help.fontcache[remain]
			table.remove(lib.help.fontcache)
		else
			font = lib.help.content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		end
		local file = font:GetFont()

		font:SetFont(file, size)
		font:SetTextColor(r,g,b,1)
		font:SetText(text)
		font.pad = pad

		table.insert(lib.help.rows, font)

		font:SetPoint("TOPLEFT", lib.help.content, "TOPLEFT", 5, -5)
		font:SetPoint("TOPRIGHT", lib.help.content, "TOPRIGHT", -5, -5)
		font:SetWidth(lib.help.content:GetWidth()-10)

		font:SetJustifyV("TOP")
		font:SetJustifyH("LEFT")

		font:Show()

		lib.help.refresh = true
		return n, font, height
	end
	function lib.help:ClearAllLines()
		lib.help.content.totalHeight = 0
		for i=#lib.help.rows, 1, -1 do
			lib.help.rows[i]:Hide()
			lib.help.rows[i]:ClearAllPoints()
			table.insert(lib.help.fontcache, lib.help.rows[i])
			table.remove(lib.help.rows, i)
		end
		lib.help.refresh = true
	end
	function lib.help:Update()
		local height, top = 0, 0

		for i = 1, #lib.help.rows do
			local font = lib.help.rows[i]
			if i == 1 then
				top = -5
				height = height + 5
			else
				top = -height - 2
				height = height + 2
			end

			top = top - font.pad
			height = height + font.pad

			font:SetPoint("TOPLEFT", lib.help.content, "TOPLEFT", 5, top)
			font:SetPoint("TOPRIGHT", lib.help.content, "TOPRIGHT", -5, top)
			font:SetWidth(lib.help.content:GetWidth()-10)

			height = height + font:GetHeight()
		end
		lib.help.content:SetHeight(height+10)
		lib.help.scroll:Update()
		lib.help.refresh = nil
	end

	function lib.help:Activate()
		local qlist = self.qlist
		local faq = self.faq
		local faa = self.faa
		local qid

		lib.help:ClearAllLines()
		for i = 1, #qlist do
			qid = qlist[i]
			lib.help:AddHelp(faq[qid], faa[qid])
		end
		lib.help:SetFrameStrata(self:GetFrameStrata())
		lib.help.refresh = true
		lib.help:Show()
	end

	local PanelScroller = LibStub:GetLibrary("PanelScroller")
	lib.help.scroll = PanelScroller:Create(lib.CreateAnonName(), lib.help)
	lib.help.scroll:SetPoint("TOPLEFT", lib.help, "TOPLEFT", 10,-25)
	lib.help.scroll:SetPoint("BOTTOMRIGHT", lib.help, "BOTTOMRIGHT", -25,5)
	lib.help.scroll:SetScrollChild(lib.help.content:GetName())
	lib.help.scroll:SetScrollBarVisible("HORIZONTAL", "NO")
end

nConf = lib

-- Local function to get the UI object type
local function isGuiObject(obj)
	if not obj then return false end
	if type(obj) ~= "table" then return false end
	if not obj[0] or type(obj[0]) ~= "userdata" then return false end
	if not obj.GetObjectType then return false end
	return obj:GetObjectType()
end

function kit:ClickButton(pos)
	local button = self:GetButton(pos)
	local tabName = button.tabName
	local catId = button.catId
	if button.tabName then
		self:SelectTab(catId, tabName)
	elseif button.catId then
		self:SelectCat(catId)
	end
end

function kit:SelectTab(catId, tabName)
	if self.config.tabs[catId] then
		local id = self.config.tabs[catId][tabName]
		if id then
			self:ActivateTab(id)
		end
	end
end

function kit:SelectCat(catId)
	if self.config.cats[catId] then
		self.config.cats[catId].isOpen = not self.config.cats[catId].isOpen
		self:RegenTabs()
	end
end

local buttonKit = {}
function buttonKit:SetText(text, active)
	self.text:SetText(text)
	if active then
		self.text:SetTextColor(1,0.8,0.1)
	else
		self.text:SetTextColor(0.9,0.9,0.9)
	end
end
function buttonKit:SetArrowDirection(direction)
--	self.text:ClearAllPoints()
	local file = self.text:GetFont()
	if direction == "RIGHT" then
		self.text:SetPoint("LEFT", self, "LEFT", 25,0)
		self.text:SetFont(file, 12)
		self.expand:SetTexCoord(1,1, 0,1, 1,0, 0,0)
		self.expand:Show()
	elseif direction == "DOWN" then
		self.text:SetPoint("LEFT", self, "LEFT", 25,0)
		self.text:SetFont(file, 12)
		self.expand:SetTexCoord(0,1, 0,0, 1,1, 1,0)
		self.expand:Show()
	else
		self.text:SetPoint("LEFT", self, "LEFT", 18,0)
		self.text:SetFont(file, 11)
		self.expand:Hide()
	end
end

function kit:GetButton(pos)
	if not self.buttons then
		self.buttons = {}
	end

	if self.buttons[pos] then return self.buttons[pos] end

	-- Create a button for this tab
	button = CreateFrame("Button", myName, self)
	button:SetWidth(150)
	button:SetHeight(13)
	button:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")

	button.text = button:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	button.text:SetPoint("LEFT", button, "LEFT", 25,0)

	button.expand = button:CreateTexture(nil, "ARTWORK");
	button.expand:SetTexture("Interface\\Minimap\\ROTATING-MINIMAPGUIDEARROW")
	button.expand:SetPoint("LEFT", button, "LEFT", 0,0)
	button.expand:SetWidth(32)
	button.expand:SetHeight(32)
	button.expand:Hide()

	for k,v in pairs(buttonKit) do
		button[k] = v
	end

	button:SetScript("OnClick", function() self:ClickButton(pos) end)
	self.buttons[pos] = button

	if pos == 1 then
		button:SetPoint("TOPLEFT", self, "TOPLEFT", 5, self.buttonTop-15)
	else
		button:SetPoint("TOPLEFT", self:GetButton(pos-1), "BOTTOMLEFT", 0, 0)
	end
	return button
end

function kit:RenderTabs()
	assert(isGuiObject(self), "Must be called on a valid object")
	if (self.config.isZero) then return end

	if not self.render then self:RegenTabs() end

	local offset = 0
	local total = #self.render
	local count = math.floor((self.dialogHeight - 40) / 13)
	for i=1, count do
		local pos = i + offset
		local button = self:GetButton(i)

		if pos <= total then
			local isCat, catId, tabName = unpack(self.render[pos])

			if isCat then
				local isOpen = self.config.cats[catId].isOpen
				if isOpen then
					button:SetArrowDirection("DOWN")
				else
					button:SetArrowDirection("RIGHT")
				end
				button:SetText(self.config.cats[catId].name or catId)
				button.catId = catId
				button.tabName = nil
			else
				button:SetArrowDirection("NONE")
				if catId == self.config.selectedCat
				and tabName == self.config.selectedTab then
					button:SetText(tabName, true)
				else
					button:SetText(tabName)
				end
				button.catId = catId
				button.tabName = tabName
			end
			button:Show()
		else
			button:SetText("")
			button:SetArrowDirection("NONE")
			button.catId = nil
			button.tabName = nil
			button:Hide()
		end
	end
end

function kit:RegenTabs()
	if not self.render then self.render = {} end
	local render = self.render
	empty(render)

	for pos, catId in ipairs(self.config.order) do
		if self.config.cats[catId].hasTabs then
			table.insert(render, {true, catId})
			if self.config.cats[catId].isOpen then
				local list = {}
				for tabName in pairs(self.config.tabs[catId]) do
					table.insert(list, tabName)
				end
				local sortFunction = nil
				if not ( self.config.cats[catId].isSorted ) then
					local tabs = self.config.tabs[catId]
					sortFunction = function(a, b)
						if ( tabs[a] < tabs[b] ) then
							return true
						end
					end
				end
				table.sort(list, sortFunction)
				for pos, tabName in ipairs(list) do
					table.insert(render, {false, catId, tabName})
				end
			end
		end
	end
	self:RenderTabs()
end

function kit:ZeroFrame()
	assert(isGuiObject(self), "Must be called on a valid object")
	assert(self.config.isZero == false, "Cannot zero a frame with tabs")

	local id = 0
	local frame, content

	local myName = lib.CreateAnonName()
	frame = CreateFrame("Frame", myName.."Frame", self)
	content = CreateFrame("Frame", myName.."Content", frame)

	frame.id = id
	frame:SetPoint("TOPLEFT", self, "TOPLEFT", 10, -10)
	frame:SetPoint("BOTTOMRIGHT", self.Done, "TOPRIGHT", 0, 5)
	frame:SetBackdrop({
		bgFile = "Interface/Tooltips/ChatBubble-Background",
		edgeFile = "Interface/Tooltips/ChatBubble-BackDrop",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 32, right = 32, top = 32, bottom = 32 }
	})
	frame:SetBackdropColor(0,0,0, 1)

	content:SetPoint("TOPLEFT", frame, "TOPLEFT", 5,-5)
	content:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5,5)

	self.config = {}
	self.config.current = "zero"
	self.config.tabs = {}
	self.config.tabs.zero = {}
	self.config.tabs.zero.zero = 0
	self.config.cats = {}
	self.config.cats.zero = {}
	self.config.isZero = true

	self.tabs[0] = {
		nil, frame, content, -- For backwards compatability
		catId = catId,
		tabName = tabName,
		gapWidth = 0,
		gapHeight = 0,
		expandGap = 0,
		leftOffset = 0,
		topOffset = 0,
		frame = frame,
		content = content,
		scroll = nil,
		buttonTop = 0,
	}
	self.tabs.active = 0
	self.config.selectedCat = "zero"
	self.config.selectedTab = "zero"

	return 0
end

function kit:SetPosition(parent, width, height, left, top)
	assert(isGuiObject(self), "Must be called on a valid object")

	parent = parent or UIParent
	top = top or self.getter("configator.top")
	left = left or self.getter("configator.left")
	width = width or self.dialogWidth
	height = height or self.dialogHeight
	self.heightDelta = self.dialogHeight - height

	self:SetParent(parent)
	self:ClearAllPoints()
	if (top and left) then
		self:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", left, top)
	else
		self:SetPoint("CENTER", parent, "CENTER")
	end
	self:SetWidth(width)
	self:SetHeight(height)

	for id, tab in ipairs(self.tabs) do
		if tab and tab.scroll then
			local frame = tab.frame
			local lOfs = frame.leftOffset or 0
			local gWidth = frame.gapWidth or 0
			local cWidth = width - lOfs - gWidth - 210
			tab.content:SetWidth(cWidth)
		end
	end
	local button = self.buttons[1]
	if button then
		button:SetPoint("TOPLEFT", self, "TOPLEFT", 5, self.buttonTop-15)
	end

	local id = self.tabs.active
	if id and self.tabs[id] then
		local tab = self.tabs[id]
		if tab.expanded then
			self:ExpandFrame(id)
		else
			self:ContractFrame(id)
		end
	end
end

function kit:ShowBackdrop()
	assert(isGuiObject(self), "Must be called on a valid object")
	self.Backdrop:Show()
end

function kit:HideBackdrop()
	assert(isGuiObject(self), "Must be called on a valid object")
	self.Backdrop:Hide()
end

function kit:ToggleExpand(id)
	assert(isGuiObject(self), "Must be called on a valid object")
	local tab = self.tabs[id]
	if not tab.expanded then
		self:ExpandFrame(id)
	else
		self:ContractFrame(id)
	end
end
function kit:ExpandFrame(id)
	assert(isGuiObject(self), "Must be called on a valid object")
	local tab = self.tabs[id]
	if tab.gapHeight == 0 then return end
	tab.frame.fullsize:SetNormalTexture("Interface\\Minimap\\UI-Minimap-ZoomOutButton-Up")
	tab.frame.fullsize:SetPushedTexture("Interface\\Minimap\\UI-Minimap-ZoomOutButton-Down")
	tab.frame:SetPoint("BOTTOMRIGHT", self.Done, "TOPRIGHT", 0-tab.gapWidth, 5+tab.expandGap)
	tab.expanded = true
end
function kit:ContractFrame(id)
	assert(isGuiObject(self), "Must be called on a valid object")
	local tab = self.tabs[id]
	if tab.gapHeight == 0 then return end
	tab.frame.fullsize:SetNormalTexture("Interface\\Minimap\\UI-Minimap-ZoomInButton-Up")
	tab.frame.fullsize:SetPushedTexture("Interface\\Minimap\\UI-Minimap-ZoomInButton-Down")
	tab.frame:SetPoint("BOTTOMRIGHT", self.Done, "TOPRIGHT", 0-tab.gapWidth, 5+tab.gapHeight-self.heightDelta)
	tab.expanded = nil
end
function kit:SetExpandGap(id, gap)
	assert(isGuiObject(self), "Must be called on a valid object")
	local tab = self.tabs[id]
	if tab.gapHeight == 0 then return end
	tab.expandGap = gap
end

function kit:AddTab(tabName, catId, gapWidth, gapHeight, topOffset, leftOffset)
	assert(isGuiObject(self), "Must be called on a valid object")
	assert(not self.config.isZero, "Cannot add tabs to a zeroed frame")

	if not catId then catId = self.config.current end

	if not self.config.tabs[catId] then
		self:AddCat(catId)
	end

	local exists, id = self:GetTabByName(tabName, catId)
	if exists then return id end

	local frame, content
	self.config.isZero = false

	local myName = lib.CreateAnonName()
	frame = CreateFrame("Frame", myName.."Frame", self)
	content = CreateFrame("Frame", myName.."Content", frame)

	if not gapWidth then gapWidth = self.gapWidth or 0 end
	if not gapHeight then gapHeight = self.gapHeight or 0 end
	if not topOffset then topOffset = self.topOffset or 0 end
	if not leftOffset then leftOffset = self.leftOffset or 0 end

	local expandGap = 0
	if self.expandGap then expandGap = self.expandGap end

	local tab = {
		nil, frame, content, -- For backwards compatability
		catId = catId,
		tabName = tabName,
		gapWidth = gapWidth,
		gapHeight = gapHeight,
		expandGap = expandGap,
		topOffset = topOffset,
		leftOffset = leftOffset,
		frame = frame,
		content = content,
		scroll = nil,
		expanded = nil,
	}
	table.insert(self.tabs, tab)
	id = table.getn(self.tabs)

	self.config.tabs[catId][tabName] = id
	tab.id = id
	frame.id = id
	content.id = id

	self.config.cats[catId].hasTabs = true

	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", self, "TOPLEFT", 160+leftOffset, -10-topOffset)
	frame:SetPoint("BOTTOMRIGHT", self.Done, "TOPRIGHT", 0-gapWidth, 5+gapHeight)
	frame:SetBackdrop({
		bgFile = "Interface/Tooltips/ChatBubble-Background",
		edgeFile = "Interface/Tooltips/ChatBubble-BackDrop",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 32, right = 32, top = 32, bottom = 32 }
	})
	frame:SetBackdropColor(0,0,0, 1)
	frame:SetFrameLevel(10)

	frame.fullsize = CreateFrame("Button", nil, frame)
	frame.fullsize:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -3, -3)
	frame.fullsize:SetWidth(22)
	frame.fullsize:SetHeight(22)
	frame.fullsize:SetNormalTexture("Interface\\Minimap\\UI-Minimap-ZoomInButton-Up")
	frame.fullsize:SetPushedTexture("Interface\\Minimap\\UI-Minimap-ZoomInButton-Down")
	frame.fullsize:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
	frame.fullsize:SetScript("OnClick", function()
		self:ToggleExpand(id)
	end)

	if gapHeight > 0 then
		frame.fullsize:Show()
	else
		frame.fullsize:Hide()
	end

	content:SetPoint("TOPLEFT", frame, "TOPLEFT", 5,-5)
	content:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5,5)
	content.gapWidth = gapWidth
	content.gapHeight = gapHeight

	self:RegenTabs()

	if (not self.config.selectedTab) then
		self:ActivateTab(id)
	else
		frame:Hide()
	end

	if (self.autoScrollTabs) then
		self:MakeScrollable(id)
	end

	return id
end

function kit:AddCat(catId, catName, sortedTabs, isOpen)
	assert(isGuiObject(self), "Must be called on a valid object")
	assert(not self.config.isZero, "Cannot add categories to a zeroed frame")
	if self.config.tabs[catId] then return end

	if sortedTabs == nil then sortedTabs = true end

	self.config.isZero = false

	table.insert(self.config.order, catId)
	self.config.tabs[catId] = { }
	self.config.cats[catId] = {
		name = catName,
		isOpen = isOpen,
		isSorted = sortedTabs,
	}
	self.config.current = catId
	if not self.config.selectedCat then self.config.selectedCat = catId end

	self:RegenTabs()
end

local function anchorPoint(frame, el, last, indent, width, height, yofs)
	local clearance = 0
	if (last and last.clearance) then clearance = last.clearance end

	el:SetPoint("LEFT", frame, "LEFT", indent or 15, 0)
	if (width == nil) then
		el:SetPoint("RIGHT", frame, "RIGHT", -5, 0)
	elseif (type(width) == "number") then
		el:SetWidth(width)
	end
	if (type(height) == "number") then
		el:SetHeight(height)
	end
	if (last) then
		el:SetPoint("TOP", last, "BOTTOM", 0, -5 + (yofs or 0) - clearance)
	else
		el:SetPoint("TOP", frame, "TOP", 0, -5 - clearance)
	end
end

function kit:Unfocus()
	assert(isGuiObject(self), "Must be called on a valid object")
	self:Hide()
	self:ClearFocus()
	self:Show()
end

function kit:MouseScroll(direction)
	assert(isGuiObject(self), "Must be called on a valid object")
	local step = 1
	if self:GetObjectType() == "Slider" then
		step = self:GetValueStep()
	end
	self:SetValue(self:GetValue() - direction*step)
end

function kit:CaptureKeys()
	self:EnableKeyboard(true)
end

function kit:ReleaseKeys()
	self:EnableKeyboard(false)
end

function kit:KeyPress(key, ...)
	local dir = 0
	if key == "UP" or key == "RIGHT" then
		dir = 1
	elseif key == "DOWN" or key == "LEFT" then
		dir = -1
	end

	if dir ~= 0 then
		local size = 1
		if IsShiftKeyDown() then
			if IsControlKeyDown() then
				size = 25
			else
				size = 5
			end
		elseif IsControlKeyDown() then
			size = 10
		end

		if self.GetValue then
			local myVal = self:GetValue()
			self:SetValue(myVal + size * dir)
			return
		elseif self.GetNumber then
			local myVal = self:GetNumber()
			self:SetNumber(myVal + size * dir)
			return
		elseif self.GetText then
			local myVal = tonumber(self:GetText())
			if myVal then
				self:SetText(myVal + size * dir)
			end
			return
		end
	end

	if self.slave and self.slave.hasFocus then
		local script = self.slave:GetScript("OnKeyUp")
		if script then
			script(key, ...)
		end
	end
end

function kit:FocusShift(...)
	assert(isGuiObject(self), "Must be called on a valid object")

	if (IsShiftKeyDown()) then
		direction = "previousFocus"
	else
		direction = "nextFocus"
	end
	local nextobj = self[direction]
	if nextobj.SetFocus then
		nextobj:SetFocus()
	end
end

function kit:SetControlWidth(width)
	assert(isGuiObject(self), "Must be called on a valid object")
	self.scalewidth = width
end

function kit:MakeScrollable(id)
	assert(isGuiObject(self), "Must be called on a valid object")
	if (self.tabs[id].scroll) then return end
	local frame = self.tabs[id].frame
	local content = self.tabs[id].content
	local oldwidth = content:GetWidth()
	content:ClearAllPoints()
	content:SetWidth(oldwidth)
	content:SetHeight(250)
	local PanelScroller = LibStub:GetLibrary("PanelScroller")
	local scroll = PanelScroller:Create(lib.CreateAnonName(), frame)
	scroll:SetPoint("TOPLEFT", frame, "TOPLEFT", 5,-7)
	scroll:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -25,9)
	scroll:SetScrollChild(content:GetName())
	scroll:UpdateScrollChildRect()
	self.tabs[id].scroll = scroll
	self.tabs[id][4] = scroll
	GSC = scroll
end

-- this is a text only tool tip
function kit:AddTip(id, tip)
	assert(isGuiObject(self), "Must be called on a valid object")
	local control
	local idType = type(id)
	if idType == "number" and self.tabs then
		control = self:GetLast(id)
	elseif idType == "string" then
		control = _G[id]
	elseif idType == "table" and type(id[0]) == "userdata" then
		control = id
	end
	assert(isGuiObject(control), "Usage: ConfigatorGui:AddTip(tabId|controlName|control, tip)")
	if control.button and isGuiObject(control.button) then
		control = control.button
	elseif control.control and isGuiObject(control.control) then
		control = control.control
	end

	local old_enter = control:GetScript("OnEnter")
	local old_leave = control:GetScript("OnLeave")
	local function help_enter(self, ...)
		if old_enter then old_enter(self, ...) end
		if tip then lib:SetTip(self, tip) end
	end
	local function help_leave(self, ...)
		if old_enter then old_leave(self, ...) end
		if tip then lib:SetTip() end
	end
	control:SetScript("OnEnter", help_enter)
	control:SetScript("OnLeave", help_leave)
end

-- this will show the game tooltip for the link
function kit:AddLinkTip(id, link)
	assert(isGuiObject(self), "Must be called on a valid object")
	local control
	local idType = type(id)
	if idType == "number" and self.tabs then
		control = self:GetLast(id)
	elseif idType == "string" then
		control = _G[id]
	elseif idType == "table" and type(id[0]) == "userdata" then
		control = id
	end
	assert(isGuiObject(control), "Usage: ConfigatorGui:AddLinkTip(tabId|controlName|control, link)")

	-- we would really prefer the text labels over the controls themselves (esp. for sliders)
	-- ccox - Feb 8, 2009 - but I can't make that work correctly
	if control.button and isGuiObject(control.button) then
		control = control.button
	elseif control.control and isGuiObject(control.control) then
		control = control.control
	end

	local old_enter = control:GetScript("OnEnter")
	local old_leave = control:GetScript("OnLeave")
	local function help_enter(self, ...)
		if old_enter then old_enter(self, ...) end
		lib:SetLinkTip(self, link)
	end
	local function help_leave(self, ...)
		if old_enter then old_leave(self, ...) end
		lib:SetLinkTip()
	end
	control:SetScript("OnEnter", help_enter)
	control:SetScript("OnLeave", help_leave)
end

function kit:AddHelp(id, qid, question, answer)
	assert(isGuiObject(self), "Must be called on a valid object")
	local content
	local idType = type(id)
	if idType == "number" and self.tabs then
		content = self.tabs[id][2]
	elseif idType == "string" then
		content = _G[id]
	elseif idType == "table" and type(id[0]) == "userdata" then
		content = id
	end
	assert(isGuiObject(content), "Usage: ConfigatorGui:AddHelp(tabId|controlName|control, question, answer)")
	assert(question and answer, "Usage: ConfigatorGui:AddHelp(tabId|controlName|control, question, answer)")

	if question and answer then
		if content and not content.HelpButton then
			content.HelpButton = CreateFrame("BUTTON", content:GetName().."HelpButton", content)
			content.HelpButton:SetPoint("TOPRIGHT", content, "TOPRIGHT", -20,0)
			content.HelpButton:SetWidth(42)
			content.HelpButton:SetHeight(42)
			content.HelpButton:SetNormalTexture("Interface\\TUTORIALFRAME\\TutorialFrame-QuestionMark")
			content.HelpButton:SetHighlightTexture("Interface\\TUTORIALFRAME\\TutorialFrame-QuestionMark")
			content.HelpButton:SetScript("OnClick", lib.help.Activate)
			content.HelpButton.text = content.HelpButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
			content.HelpButton.text:SetText("Help")
			content.HelpButton.text:SetPoint("TOP", content.HelpButton, "BOTTOM", 0,5)
			content.HelpButton.qlist = {}
			content.HelpButton.faq = {}
			content.HelpButton.faa = {}
		end
		content.HelpButton.faq[qid] = question
		content.HelpButton.faa[qid] = answer

		for i = 1, #content.HelpButton.qlist do
			if content.HelpButton.qlist[i] == qid then
				return
			end
		end
		table.insert(content.HelpButton.qlist, qid)
	end
end

function kit:GetControl( tabId, controlId )
	if ( controlId ) then
		return self.tabs[tabId].frame.ctrls[controlId]
	else
		local ctrls = self.tabs[tabId].frame.ctrls
		return ctrls.last, ctrls.pos
	end
end

function kit:AddControl(id, cType, column, ...)
	assert(isGuiObject(self), "Must be called on a valid object")
	local frame = self.tabs[id].frame
	if (not frame.ctrls) then
		frame.ctrls = { pos = 0 }
	end
	local cpos = frame.ctrls.pos + 1
	frame.ctrls.pos = cpos
	local ctrl = { kids = {} }
	frame.ctrls[cpos] = ctrl

	local last = frame.ctrls.last
	local control

	local kids = ctrl.kids
	local kpos = 0

	local framewidth = frame:GetWidth() - 20
	column = (column or 0) * framewidth
	local colwidth = nil
	if (self.scalewidth) then
		colwidth = math.min(framewidth-column, (self.scalewidth or 1) * framewidth)
		self.scalewidth = nil
	end

	local content = self.tabs[id].content

	local el
	if (cType == "Header") then
		el = content:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
		local fontFile = el:GetFont()
		el:SetFont(fontFile, 15)
		kpos = kpos+1 kids[kpos] = el
		anchorPoint(content, el, last)
		local text = ...
		el:SetText(text)
		last = el
	elseif (cType == "Subhead") then
		el = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
		local fontFile = el:GetFont()
		el:SetFont(fontFile, 13)
		el:SetJustifyH("LEFT")
		kpos = kpos+1 kids[kpos] = el
		anchorPoint(content, el, last, column+15, colwidth, nil, -10)
		local text = ...
		el:SetText(text)
		last = el
	elseif (cType == "Note") then
		local level, width, height, text = ...
		local indent = 10 * (level or 1)
		el = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		local fontFile = el:GetFont()
		el:SetFont(fontFile, 10)
		el:SetJustifyH("LEFT")
		el:SetJustifyV("TOP")
		kpos = kpos+1 kids[kpos] = el
		anchorPoint(content, el, last, column+indent+15, width, height, nil)
		el:SetText(text)
		control = el
		last = el
	elseif (cType == "Label") then
		local level, setting, text = ...
		local indent = 10 * (level or 1)
		el = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		el:SetJustifyH("LEFT")
		kpos = kpos+1 kids[kpos] = el
		anchorPoint(content, el, last, column+indent+15, colwidth)
		el:SetText(text)
		if (setting) then
			el.hit = CreateFrame("Button", nil, content)
			el.hit.parent = el
			el.hit:SetAlpha(0.3)
			el.hit:SetPoint("TOPLEFT", el, "TOPLEFT", -2, 2)
			el.hit:SetPoint("BOTTOMRIGHT", el, "BOTTOMRIGHT", 2, -2)
			--el.hit:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
			el.hit:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")
			el.hit.setting = setting
			el.hit.stype = "Button";
			el.hit:SetScript("OnClick", function(...) self:ChangeSetting(...) end)
			el.hit:Show()
		end
		control = el
		last = el
	elseif (cType == "Custom") then
		local level, el = ...
		local indent = 10 * (level or 1)
		kpos = kpos+1 kids[kpos] = el
		anchorPoint(content, el, last, column + indent + 15, colwidth)
		control = el
		last = el
	elseif (cType == "Text") then
		local level, setting, label = ...
		local indent = 10 * (level or 1)
		-- FontString
		el = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		el:SetJustifyH("LEFT")
		kpos = kpos+1 kids[kpos] = el
		anchorPoint(content, el, last, 10 + column + indent)
		el:SetText(label)
		last = el
		-- Editbox
		el = CreateFrame("EditBox", lib.CreateAnonName(), content, "InputBoxTemplate")
		lib:TabLink(frame, el)

		kpos = kpos+1 kids[kpos] = el
		anchorPoint(content, el, last, 20 + column + indent, colwidth or 160, 32, 4)
		el.setting = setting
		el.stype = "EditBox"
		el:SetAutoFocus(false)
		self:GetSetting(el)
		el:SetScript("OnEditFocusGained", function(...)
			self.curFocus = el
		end)
		el:SetScript("OnEditFocusLost", function(...)
			self.curFocus = nil
			self:ChangeSetting(...)
		end)
		el:SetScript("OnEscapePressed", kit.Unfocus)
		el:SetScript("OnEnterPressed", kit.Unfocus)
		self.elements[setting] = el
		el.textEl = last

		control = el
		last = el
	elseif (cType == "Selectbox") then
		local level, list, setting, text = ...
		local indent = 10 * (level or 1)
		-- Selectbox
		local tmpName = lib.CreateAnonName()

		if (type(list) ~= "function") then
			local listVar = list
			if (type(list) == "table") then
				list = function() return listVar end
			else
				list = function() return self.getter(listVar) end
			end
		end

		local SelectBox = LibStub:GetLibrary("SelectBox")
		el = SelectBox:Create(tmpName, content, 140, function(...) self:ChangeSetting(...) end, list, "Default")
		kpos = kpos+1 kids[kpos] = el
		anchorPoint(content, el, last, column+indent - 5, colwidth or 140, 22, 4)
		el.list = list
		el.setting = setting
		el.stype = "SelectBox";
		el.clearance = 10
		self.elements[setting] = el
		self:GetSetting(el)
		control = el
		last = el

	elseif (cType == "Button") then
		local level, setting, text = ...
		local indent = 10 * (level or 1)
		-- Button
		el = CreateFrame("Button", nil, content, "OptionsButtonTemplate")
		kpos = kpos+1 kids[kpos] = el
		anchorPoint(content, el, last, 10 + column + indent, colwidth or 80, 22, 4)
		el.setting = setting
		el.stype = "Button";
		el:SetScript("OnClick", function(...) self:ChangeSetting(...) end)
		el:SetText(text)
		el:SetWidth(math.max(el:GetWidth(), el:GetFontString():GetStringWidth() + 16))
		control = el
		last = el
	elseif (cType == "Checkbox") then
		local level, setting, text, singleLine, maxLabelLength = ...
		if ( maxLabelLength and maxLabelLength <= 1 ) then
			maxLabelLength = maxLabelLength * framewidth - 25
		end
		local indent = 10 * (level or 1)
		-- CheckButton
		el = CreateFrame("CheckButton", nil, content, "OptionsCheckButtonTemplate")
		kpos = kpos+1 kids[kpos] = el
		anchorPoint(content, el, last, 10 + column + indent, 22, 22, 4)
		el.setting = setting
		el.stype = "CheckButton"
		self:GetSetting(el)
		el:SetScript("OnClick", function(...) self:ChangeSetting(...) end)
		self.elements[setting] = el
		control = el
		-- FontString
		el = control:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		el:SetJustifyH("LEFT")
		kpos = kpos+1 kids[kpos] = el
		if (colwidth) then colwidth = colwidth - 15 end
		anchorPoint(content, el, last, 35+column+indent, (colwidth or maxLabelLength), (singleLine and 14))
		el:SetText(text)
		local textWidth = el:GetStringWidth()+25
		control:SetHitRectInsets(-2,-textWidth, -2,-2)
		control.textEl = el
		last = el
	elseif (cType == "Slider" or cType == "WideSlider" or cType == "TinySlider"
	or cType == "NumeriSlider" or cType == "NumeriWide" or cType == "NumeriTiny") then
		local swidth = colwidth or 140
		if (cType == "WideSlider" or cType == "NumeriWide") then swidth = 260 end
		if (cType == "TinySlider" or cType == "NumeriTiny") then swidth = 80 end
		local hasNumber = false
		local nwidth = 0
		if (cType == "NumeriSlider" or cType == "NumeriWide" or cType == "NumeriTiny") then
			hasNumber = true
			nwidth = 40
		end

		local level, setting, min, max, step, text, fmtfunc = ...
		local indent = 10 * (level or 1)
		-- FontString
		el = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		el:SetJustifyH("LEFT")
		kpos = kpos+1 kids[kpos] = el
		anchorPoint(content, el, last, swidth+nwidth + 20 + column+indent)
		el:SetText(text)
		local textElement = el
		-- Slider
		local tmpName = lib.CreateAnonName()
		el = CreateFrame("Slider", tmpName, content, "OptionsSliderTemplate")
		kpos = kpos+1 kids[kpos] = el
		anchorPoint(content, el, last, 13 + column + indent, swidth, 20, 4)
		getglobal(tmpName.."Low"):SetText("")
		getglobal(tmpName.."High"):SetText("")
		el.setting = setting
		el.textFmt = text
		el.fmtFunc = fmtfunc
		el.textEl = textElement
		el.stype = "Slider"
		el.step = step * 100
		el:SetMinMaxValues(min * 100, max * 100)
		el:SetValueStep(step*100)
		el:SetHitRectInsets(0,0,0,0)
		local slave
		el:EnableMouseWheel(true)
		el:SetScript("OnEnter", kit.CaptureKeys)
		el:SetScript("OnLeave", kit.ReleaseKeys)
		el:SetScript("OnKeyUp", kit.KeyPress)
		el:SetScript("OnMouseWheel", kit.MouseScroll)
		self:GetSetting(el) -- We need to have set or the hasNumber part will always start at 0
		if hasNumber then
			local slaveName = lib.CreateAnonName()
			slave = CreateFrame("EditBox", slaveName, el, "InputBoxTemplate")
			lib:TabLink(frame, slave)

			slave:SetPoint("LEFT", el, "RIGHT", 8,0)
			slave:SetWidth(40)
			slave:SetHeight(32)
			slave:SetScale(0.8)
			slave:SetScript("OnEditFocusGained", function(...)
				self.curFocus = slave
				slave.hasFocus = true
			end)
			slave:SetScript("OnEditFocusLost", function(...)
				local myMin, myMax = slave.minValue, slave.maxValue
				local myVal = math.min(myMax, math.max(myMin, tonumber(slave:GetNumber()) or 0))
				if (el:GetValue() ~= myVal*100) then
					el:SetValue(myVal*100)
				end
				slave:SetNumber((el:GetValue())/100)
				slave.hasFocus = false
				self.curFocus = nil
			end)
			slave:SetScript("OnEscapePressed", kit.Unfocus)
			slave:SetScript("OnEnterPressed", kit.Unfocus)
			slave:SetAutoFocus(false)
			slave:Show()
			slave.minValue = min
			slave.maxValue = max
			slave.element = el
			slave:SetNumber((el:GetValue())/100)
			el.slave = slave
		end
		el:SetScript("OnValueChanged", function(...)
			self:ChangeSetting(...)
			if (slave) then
				local myVal = el:GetValue()
				if slave:GetNumber() ~= myVal/100 then
					slave:SetNumber(myVal/100)
				end
			end
		end)
		self.elements[setting] = el
		control = el
		last = textElement
	elseif (cType == "NumberBox" or cType == "TinyNumber") then
		local level, setting, minVal, maxVal, label = ...
		local indent = 10 * (level or 1)

		local defWidth = 80
		if (cType == "TinyNumber") then defWidth = 40 end

		-- FontString
		el = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		el:SetJustifyH("LEFT")
		kpos = kpos+1 kids[kpos] = el
		anchorPoint(content, el, last, 10+column+indent)
		el:SetText(label)
		last = el
		-- Editbox
		el = CreateFrame("EditBox", lib.CreateAnonName(), content, "InputBoxTemplate")
		lib:TabLink(frame, el)
		kpos = kpos+1 kids[kpos] = el
		anchorPoint(content, el, last, 20+column+indent, colwidth or defWidth, 32, 4)
		el.setting = setting
		el.stype = "EditBox"
		el:SetAutoFocus(false)
		el:SetNumeric(true);
		el.minValue = minVal;
		el.maxValue = maxVal;
		el.Numeric = true;
		self:GetSetting(el)
		el:SetScript("OnEditFocusGained", function(...)
			self.curFocus = el
		end)
		el:SetScript("OnEditFocusLost", function(...)
			self.curFocus = nil
			self:ChangeSetting(...)
		end)
		el:SetScript("OnEscapePressed", kit.Unfocus)
		el:SetScript("OnEnterPressed", kit.Unfocus)
		self.elements[setting] = el
		el.textEl = last
		control = el
		last = el
	elseif (cType == "MoneyFrame" or cType == "PinnedMoney" or cType == "MoneyFramePinned") then
		local level, setting, minVal, maxVal, label  = ...
		if (cType == "MoneyFrame") then
			label, minVal, maxVal = minVal, nil, nil
		end
		local indent = 10 * (level or 1)
		-- FontString
		if label then
			el = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
			el:SetJustifyH("LEFT")
			kpos = kpos+1 kids[kpos] = el
			anchorPoint(content, el, last, 10+column+indent)
			el:SetText(label)
			last = el
		end
		-- MoneyFrame
		frameName = lib.CreateAnonName();
		el = CreateFrame("Frame", frameName, content, "MoneyInputFrameTemplate")
		el.isMoneyFrame = true

-- NOTE - ccox - 2007-11-18
-- TabLink is not working correctly, causes an error when tabbing out of copper field in money input frame
--		lib:TabLink(frame, el)

-- for the time being, set to cycle around the fields of the current money frame
		MoneyInputFrame_SetPreviousFocus(el, getglobal(frameName.."Copper"))
		MoneyInputFrame_SetNextFocus(el, getglobal(frameName.."Gold"))

		local cur = el
		local MoneyInputFrame_SetOnValueChangedFunc = MoneyInputFrame_SetOnvalueChangedFunc or MoneyInputFrame_SetOnValueChangedFunc -- WotLK Hack
		MoneyInputFrame_SetOnValueChangedFunc(el, function() self:ChangeSetting(cur) end);
		kpos = kpos+1 kids[kpos] = el
		anchorPoint(content, el, last, 20+column+indent, colwidth or 160, 32, 4)
		el.frameName = frameName;
		el.setting = setting;
		el.stype = cType
		el.clearance = -10
		el.minValue = minVal;
		el.maxValue = maxVal;
		self:GetSetting(el)
		self.elements[setting] = el
		el.textEl = last
		control = el
		last = el
	elseif (cType == "ColorSelect" or cType == "ColorSelectAlpha") then
		local level, setting, text = ...
		local indent = 10 * (level or 1)
		-- ColorSelect
		el = CreateFrame("Button", nil, content)
		kpos = kpos+1 kids[kpos] = el
		anchorPoint(content, el, last, 10 + column + indent, 26, 22, -2)
		el.setting = setting
		el.stype = cType
		el:SetWidth(24)
		el:SetHeight(16)
		el.r, el.g, el.b, el.a = 0,0,0,1
		el.bg = el:CreateTexture(nil, "BORDER");
		el.bg:SetAllPoints(el)
		el.bg:SetTexture("Interface\\TargetingFrame\\BarFill2")
		el.bg:SetAlpha(0.7)
		el.tex = el:CreateTexture(nil, "ARTWORK");
		el.tex:SetAllPoints(el)
		el.tex:SetTexture(r,g,b,a)
		self:GetSetting(el)
		el:SetScript("OnClick", function(obj, ...)
			local f = ColorPickerFrame
			f:SetColorRGB(obj.r, obj.g, obj.b);
			if obj.stype == "ColorSelectAlpha" then
				f.hasOpacity = true
				f.opacity = obj.a
			else
				f.hasOpacity = false
			end
			f.func = function()
				self:ChangeSetting(obj)
			end
			f.opacityFunc = f.func
			f:SetFrameStrata("TOOLTIP")
			f:SetToplevel("TRUE")
			f:Show()
		end)
		self.elements[setting] = el
		control = el
		-- FontString
		el = control:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		el:SetJustifyH("LEFT")
		kpos = kpos+1 kids[kpos] = el
		if (colwidth) then colwidth = colwidth - 15 end
		anchorPoint(content, el, last, 35+column+indent, maxLabelLength, 16, -2)
		el:SetText(text)
		local textWidth = el:GetStringWidth()+25
		control:SetHitRectInsets(-2,-textWidth, -2,-2)
		control.textEl = el
		last = el
	end

	if last ~= control then
		last.control = control
	end

	self:SetLast(id, last)
	return control
end

function kit:GetLast(id)
	assert(isGuiObject(self), "Must be called on a valid object")
	if (self.tabs[id] and self.tabs[id].frame.ctrls) then
		return self.tabs[id].frame.ctrls.last
	end
end

function kit:SetLast(id, last)
	assert(isGuiObject(self), "Must be called on a valid object")
	if (self.tabs[id] and self.tabs[id].frame.ctrls) then
		self.tabs[id].frame.ctrls.last = last
	end
end

function kit:ActivateTab(id)
	assert(isGuiObject(self), "Must be called on a valid object")
	id = tonumber(id)
	if not id then id = self.id end

	if not self.tabs then self = self:GetParent() end
	if not self.tabs then
		return error("Must call ActivateTab from a valid Configator object")
	end

	if (self.tabs.active) then
		self.tabs[self.tabs.active].frame:Hide()
	end
	local tab = self.tabs[id]
	tab.frame:Show()
	self.tabs.active = id
	self.config.selectedCat = tab.catId
	self.config.selectedTab = tab.tabName

	if not self.config.cats[tab.catId].isOpen then
		self.config.cats[tab.catId].isOpen = true
		self:RegenTabs()
	else
		self:RenderTabs()
	end

	if self.expandOnActivate then
		self:ExpandFrame(id)
	end
end

function kit:GetTabByName(tabName, catId)
	if not catId then
		catId = self.config.current or ""
	end
	if self.config.tabs[catId] then
		local id = self.config.tabs[catId][tabName]
		if id then
			return self.tabs[id], id
		end
	end
end

function kit:GetTabById(id)
	if id then
		return self.tabs[id]
	end
end

function kit:Refresh()
	assert(isGuiObject(self), "Must be called on a valid object")
	for name, el in pairs(self.elements) do
		self:GetSetting(el)
	end
end

function kit:Resave()
	assert(isGuiObject(self), "Must be called on a valid object")
	for name, el in pairs(self.elements) do
		self:ChangeSetting(el)
	end
end

function kit:ClearFocus()
	if self.curFocus then
		self.curFocus:ClearFocus()
	end
end

function kit:GetSetting(element)
	assert(isGuiObject(self), "Must be called on a valid object")
	assert(isGuiObject(element), "You must pass a valid element")
	local setting = element.setting
	local value = self.getter(setting)
	if (element.stype == "CheckButton") then
		element:SetChecked(value or false)
	elseif (element.stype == "EditBox") then
		if (element.Numeric) then
			oldvalue = value or 0;
			value = oldvalue;
			if (element.minValue) then
				value = math.max( value, element.minValue );
			end
			if (element.maxValue) then
				value = math.min( value, element.maxValue );
			end
			element:SetNumber(value);
			-- notify that we have pinned the value
			if (value ~= oldvalue) then
				self.setter(setting, value);
			end
		else
			element:SetText(value or "")
		end
	elseif (element.stype == "SelectBox") then
		element.value = value
		element:UpdateValue()
	elseif (element.stype == "Button") then
	elseif (element.stype == "Slider") then
		value = tonumber(value) or 0
		element:SetValue(value*100)
		if (element.fmtFunc) then
			element.textEl:SetText(string.format(element.textFmt, element.fmtFunc(value)))
		else
			element.textEl:SetText(string.format(element.textFmt, value))
		end
	elseif (element.stype == "MoneyFrame") then
		MoneyInputFrame_ResetMoney(element)
		MoneyInputFrame_SetCopper(element, tonumber(value) or 0);
	elseif (element.stype == "MoneyFramePinned") then
		oldvalue = tonumber(value) or 0;
		value = oldvalue;
		if (element.minValue) then
			value = math.max( value, element.minValue );
		end
		if (element.maxValue) then
			value = math.min( value, element.maxValue );
		end
		MoneyInputFrame_ResetMoney(element)
		MoneyInputFrame_SetCopper( element, value );
		-- update with pinned value
		if (oldvalue ~= value) then
			self.setter(setting, value);
		end
	elseif (element.stype == "ColorSelect" or element.stype == "ColorSelectAlpha") then
		local r, g, b, a = strsplit(",", tostring(value) or "0,0,0,1")
		element.r = tonumber(r) or 0
		element.g = tonumber(g) or 0
		element.b = tonumber(b) or 0
		element.a = tonumber(a) or 1
		if element.tex then
			element.tex:SetTexture(element.r,element.g,element.b,element.a)
		end
	else
		value = element:GetValue()
	end
end

function kit:ChangeSetting(element, ...)
	assert(isGuiObject(self), "Must be called on a valid object")
	assert(isGuiObject(element), "You must pass a valid element")
	assert(element.stype, "You must pass a valid Configator settings object")
	local setting = element.setting
	local value
	if (element.stype == "CheckButton") then
		value = element:GetChecked()
		if (value) then value = true else value = false end
	elseif (element.stype == "EditBox") then
		if (element.Numeric) then
			oldvalue = element:GetNumber() or 0;
			value = oldvalue;
			if (element.minValue) then
				value = math.max( value, element.minValue );
			end
			if (element.maxValue) then
				value = math.min( value, element.maxValue );
			end
			-- update the text field with pinned value
			if (oldvalue ~= value) then
				element:SetNumber(value);
			end
		else
			value = element:GetText() or ""
		end
	elseif (element.stype == "SelectBox") then
		value = select(2, ...)
	elseif (element.stype == "Button") then
		value = true
	elseif (element.stype == "Slider") then
		value = (element:GetValue())/100 or 0
		if (element.fmtFunc) then
			element.textEl:SetText(string.format(element.textFmt, element.fmtFunc(value)))
		else
			element.textEl:SetText(string.format(element.textFmt, value))
		end
	elseif (element.stype == "MoneyFrame") then
		value = MoneyInputFrame_GetCopper( element );
	elseif (element.stype == "MoneyFramePinned") then
		oldvalue = MoneyInputFrame_GetCopper( element );
		value = oldvalue;
		if (element.minValue) then
			value = math.max( value, element.minValue );
		end
		if (element.maxValue) then
			value = math.min( value, element.maxValue );
		end
		-- update with pinned value
		if (oldvalue ~= value) then
			MoneyInputFrame_SetCopper( element, value );
		end
	elseif (element.stype == "ColorSelect" or element.stype == "ColorSelectAlpha") then
		if (ColorPickerFrame:IsVisible()) then
			local r,g,b = ColorPickerFrame:GetColorRGB()
			local a = 1
			if element.stype == "ColorSelectAlpha" then
				a = OpacitySliderFrame:GetValue()
			end
			element.r = tonumber(r) or 0
			element.g = tonumber(g) or 0
			element.b = tonumber(b) or 0
			element.a = tonumber(a) or 1
		end
		value = ("%0.3f,%0.3f,%0.3f,%0.3f"):format(element.r,element.g,element.b,element.a)
		if element.tex then
			element.tex:SetTexture(element.r,element.g,element.b,element.a)
		end
	elseif element.GetValue then
		value = element:GetValue()
	else
		return
	end
	self.setter(setting, value)
end

function kit:ColumnCheckboxes(id, cols, options)
	assert(isGuiObject(self), "Must be called on a valid object")
	local last, cont, el, setting, text
	last = self:GetLast(id)
	local optc = table.getn(options)
	local rows = math.ceil(optc / cols)
	local row, col = 0, 0
	cont = nil
	for pos, option in ipairs(options) do
		setting, text = unpack(option)
		col = math.floor(row / rows)
		el = self:AddControl(id, "Checkbox", col/cols, 1, setting, text, true, 1/cols)
		row = row + 1
		if (row % rows == 0) then
			if (col == 0) then
				cont = el
			end
			self:SetLast(id, last)
		end
	end
	self:SetLast(id, cont)
end

function kit:SetEscSensitive(setting)
	assert(isGuiObject(self), "Must be called on a valid object")
	local name = self:GetName()
	for i = #UISpecialFrames, 1, -1 do
		if (name == UISpecialFrames[i]) then
			table.remove(UISpecialFrames, i)
		end
	end
	if (setting) then
		table.insert(UISpecialFrames[i], name)
	end
end

SlashCmdList["LIB_CONFIGATOR"] = function( msg )
	msg = msg:trim():lower()
	if ( msg == "reset" ) then
		for _, dialog in pairs(lib.frames) do
			dialog:ClearAllPoints()
			dialog:SetPoint("CENTER", "UIParent", "CENTER")
		end
	end
end

SLASH_LIB_CONFIGATOR1 = "/configator";
