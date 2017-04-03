--[[
Name: Window-1.0
Revision: $Rev: 34 $
Author(s): Mikk (dpsgnome@mail.com)
Website: http://www.wowace.com/wiki/WindowLib
Documentation: http://www.wowace.com/wiki/WindowLib
SVN: http://svn.wowace.com/root/trunk/WindowLib/Window-1.0
Description: A library that handles the basics of "window" style frames
Dependencies: none
License: Public Domain
]]

local MAJOR_VERSION = "Window-1.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 34 $"):match("(%d+)"))

assert(AceLibrary, MAJOR_VERSION .. "requires AceLibrary")
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then 
	return
end

local print = AceLibrary:HasInstance("AceConsole-2.0") and AceLibrary("AceConsole-2.0").Print or function()end;

local lib = {}

---------------------------------------------------------
-- UTILITIES
---------------------------------------------------------


local function getStorageName(frame, name)
  local names = frame.windowlibData.names
  if names then
		if names[name] then
			return names[name]
		end
		if names.prefix then
			return names.prefix .. name;
		end
	end
	return name;
end

local function setStorage(frame, name, value)
	frame.windowlibData.storage[getStorageName(frame, name)] = value
end

local function getStorage(frame, name)
	return frame.windowlibData.storage[getStorageName(frame, name)]
end


local function utilFrame_OnUpdate(this)
	this:Hide()
	for k,_ in pairs(lib.delayedSavePosition) do
		lib.delayedSavePosition[k] = nil
		lib:SavePosition(k)
	end
end

local function queueSavePosition(frame)
	lib.delayedSavePosition[frame] = true
	lib.utilFrame:Show()
end



---------------------------------------------------------
-- IMPORTANT APIS
---------------------------------------------------------


function lib:RegisterConfig(frame, storage, names)
	if not frame.windowlibData then
		frame.windowlibData = {}
	end
	frame.windowlibData.names = names
	frame.windowlibData.storage = storage
	
	--[[ debug
	frame.tx = frame:CreateTexture()
	frame.tx:SetTexture(0,0,0, 0.4)
	frame.tx:SetAllPoints(frame)
	frame.tx:Show()
	]]
end




---------------------------------------------------------
-- POSITIONING AND SCALING
---------------------------------------------------------


function lib:SavePosition(frame)
	local parent = assert(frame:GetParent())
	local s = frame:GetScale()
	local left,top = frame:GetLeft()*s, frame:GetTop()*s
	local right,bottom = frame:GetRight()*s, frame:GetBottom()*s
	local pwidth, pheight = parent:GetWidth(), parent:GetHeight()

	local x,y,point;
	if left < (pwidth-right) and left < abs((left+right)/2 - pwidth/2) then
		x = left;
		point="LEFT";
	elseif (pwidth-right) < abs((left+right)/2 - pwidth/2) then
		x = right-pwidth;
		point="RIGHT";
	else
		x = (left+right)/2 - pwidth/2;
		point="";
	end
	
	if bottom < (pheight-top) and bottom < abs((bottom+top)/2 - pheight/2) then
		y = bottom;
		point="BOTTOM"..point;
	elseif (pheight-top) < abs((bottom+top)/2 - pheight/2) then
		y = top-pheight;
		point="TOP"..point;
	else
		y = (bottom+top)/2 - pheight/2;
		-- point=""..point;
	end
	
	if point=="" then
		point = "CENTER"
	end
	
	setStorage(frame, "x", x)
	setStorage(frame, "y", y)
	setStorage(frame, "point", point)
	setStorage(frame, "scale", scale)
	
	-- The frame will be "TOPLEFT"->"BOTTOMLEFT" anchored after drag, so fix the live positioning 
	frame:ClearAllPoints()
	frame:SetPoint(point, frame:GetParent(), point, x/s, y/s);
end

function lib:RestorePosition(frame)
	local x = getStorage(frame, "x")
	local y = getStorage(frame, "y")
	local point = getStorage(frame, "point")
	
	local s = getStorage(frame, "scale")
	if s then
		frame:SetScale(s)
	else
		s = frame:GetScale()
	end
	
	if not x or not y then
		x=0; y=0; point="CENTER"
	end

	x,y = x/s,y/s

	frame:ClearAllPoints()
	if not point and y==0 then
		point="CENTER"
	end
		
	if not point then
		frame:SetPoint("TOPLEFT", frame:GetParent(), "BOTTOMLEFT", x, y)
		-- make it compute a better attachpoint (on next update)
		queueSavePosition(frame)
	else
		frame:SetPoint(point, frame:GetParent(), point, x, y)
	end
end

function lib:SetScale(frame, scale)
	setStorage(frame, "scale", scale)
	frame:SetScale(scale)
	self:RestorePosition(frame)
end



---------------------------------------------------------
-- DRAG SUPPORT
---------------------------------------------------------


local function windowOnDragStart(this)
	this.isDragging = true
	this:StartMoving()
end


local function windowOnDragStop(this)
	this:StopMovingOrSizing()
	lib:SavePosition(this)
	this.isDragging = false
	if this.windowlibData.altEnable and not IsAltKeyDown() then
		this:EnableMouse(false)
	end
end


function lib:MakeDraggable(frame)
	assert(frame.windowlibData)
	frame:SetMovable(true)
	frame:SetScript("OnDragStart", windowOnDragStart)
	frame:SetScript("OnDragStop", windowOnDragStop)
	frame:RegisterForDrag("LeftButton")
end


---------------------------------------------------------
-- ENABLEMOUSE-ON-ALT
---------------------------------------------------------

local function utilFrame_OnEvent(this, event, key, state)
	if event=="MODIFIER_STATE_CHANGED" then
		if key == "LALT" or key == "RALT" then
			for frame,_ in pairs(lib.altEnabledFrames) do
				if not frame.isDragging then		-- if it's already dragging, it'll disable mouse on DragStop
					frame:EnableMouse(state == 1)
				end
			end
		end
	end
end

function lib:EnableMouseOnAlt(frame)
	assert(frame.windowlibData)
	frame.windowlibData.altEnable = true
	frame:EnableMouse(not not IsAltKeyDown())
	if not lib.altEnabledFrames then
		lib.altEnabledFrames = {}
		lib.utilFrame:SetScript("OnEvent", utilFrame_OnEvent)
		lib.utilFrame:RegisterEvent("MODIFIER_STATE_CHANGED")
	end
	lib.altEnabledFrames[frame] = true
end


---------------------------------------------------------
-- CREATE SIMPLE FRAME
---------------------------------------------------------



---------------------------------------------------------
-- Register & Activate!
---------------------------------------------------------


local function activate(self, oldLib, oldDeactivate)
	lib = self

	lib.utilFrame = (oldLib and oldLib.utilFrame) or CreateFrame("Frame")
	lib.utilFrame:SetScript("OnUpdate", utilFrame_OnUpdate)
	lib.delayedSavePosition = (oldLib and oldLib.delayedSavePosition) or {}

	if oldDeactivate then
		oldDeactivate(oldLib)
	end
end

AceLibrary:Register(lib, MAJOR_VERSION, MINOR_VERSION, activate)
