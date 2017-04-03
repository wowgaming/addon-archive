--[[-
LibMoneyFrame

LibMoneyFrame is a small helper library to create view-only money frame as minimalistically as is currently possible.

Copyright (C) 2008, by the respecive below authors.

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
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

@author Tem
@author Ken Allan <ken@norganna.org>
@libname LibMoneyFrame
@version 1.0
--]]

local MAJOR,MINOR,REVISION = "LibMoneyFrame", 1, "$Revision: 144 $"

-- A string unique to this version to prevent frame name conflicts.
local LIBSTRING = MAJOR.."_"..MINOR.."_"..REVISION
local lib = LibStub:NewLibrary(MAJOR.."-"..MINOR, REVISION)
if not lib then return end

-- Call function to deactivate any outdated version of the library.
-- (calls the OLD version of this function, NOT the one defined in this
-- file's scope)
if lib.Deactivate then lib:Deactivate() end

local methods = {}
local numMoneys = 0

local function createCoin(frame, pos, width, height)
	if not width then width = 200 end
	if not height then height = 16 end
	frame:SetWidth(width)
	frame:SetHeight(height)
	frame.label = frame:CreateFontString()
	frame.label:SetFontObject(GameTooltipTextSmall)
	local font = frame.label:GetFont()
	frame.label:SetHeight(height)
	frame.label:SetWidth(width-height)
	frame.label:SetFont(font, height)
	frame.label:SetPoint("TOPLEFT", frame, "TOPLEFT", 0,0)
	frame.label:SetJustifyH("RIGHT")
	frame.label:SetJustifyV("CENTER")
	frame.label:Show()
	frame.texture = frame:CreateTexture()
	frame.texture:SetWidth(height)
	frame.texture:SetHeight(height)
	frame.texture:SetPoint("TOPLEFT", frame.label, "TOPRIGHT", 2,0)
	frame.texture:SetPoint("BOTTOM", frame.label, "BOTTOM", 0,0)
	frame.texture:SetTexture("Interface\\MoneyFrame\\UI-MoneyIcons")
	frame.texture:SetTexCoord(pos,pos+0.25, 0,1)
	frame.texture:Show()
end

local function refresh(self)
	self:NeedsRefresh(false)
	self:UpdateWidth()
end

function methods:UpdateWidth()
	local curWidth = ceil(self:GetWidth())
	local width = 0
	if self.gold:IsShown() then
		width = self.gold.label:GetStringWidth()
		self.gold.label:SetWidth(width)
		width = width + self.gold.texture:GetWidth() + 2 -- Add 2 for the uncounted right side buffer
		self.gold:SetWidth(width)
	end
	if self.silver:IsShown() then
		width = width + self.silver:GetWidth() -- self.silver already has a right side buffer
	end
	width = width + self.copper:GetWidth() + 2 -- Add 2 extra for a left side buffer

	width = ceil(width)
	if curWidth ~= width then self:NeedsRefresh(true) end
	self:RealSetWidth(width)

end

function methods:NeedsRefresh(flag)
	if flag then
		self:SetScript("OnUpdate", refresh)
	else
		self:SetScript("OnUpdate", nil)
	end
end

function methods:SetValue(money, red,green,blue)
	money = math.floor(tonumber(money) or 0)
	local g = math.floor(money / 10000)
	local s = math.floor(money % 10000 / 100)
	local c = math.floor(money % 100)

	if not (red and green and blue) then
		red, green, blue = unpack(self.color)
	end

	local height = self.height
	if g > 0 then
		self.gold.label:SetWidth(strlen(tostring(g)) * height * 2) -- Guess at the size so it doesn't truncate the
		-- string and return a bogus width when we try and get the string length.
		self.gold.label:SetFormattedText("%d", g)
		self.gold.label:SetTextColor(red,green,blue)
		self.gold:Show()
		self:NeedsRefresh(true)
	else
		self.gold:Hide()
	end
	if g + s > 0 then
		if (g > 0) then
			self.silver.label:SetFormattedText("%02d", s)
		else
			self.silver.label:SetFormattedText("%d",  s)
		end
		self.silver.label:SetTextColor(red,green,blue)
		self.silver:Show()
	else
		self.silver:Hide()
	end

	if g + s > 0 then
		self.copper.label:SetFormattedText("%02d", c)
	else
		self.copper.label:SetFormattedText("%d", c)
	end
	self.copper.label:SetTextColor(red,green,blue)
	self.copper:Show()
	self:UpdateWidth()

	self:Show()
end

function methods:SetColor(red, green, blue)
	self.color = {red, green, blue}
	self.copper.label:SetTextColor(red, green, blue)
	self.silver.label:SetTextColor(red, green, blue)
	self.gold.label:SetTextColor(red, green, blue)
end	

function methods:SetHeight()
end

function methods:SetWidth(width)
end

function methods:SetDrawLayer(layer)
	self.gold.texture:SetDrawLayer(layer)
	self.silver.texture:SetDrawLayer(layer)
	self.copper.texture:SetDrawLayer(layer)
end

function lib:new(height, red, green, blue)
	local n = numMoneys + 1
	numMoneys = n

	if not height then height = 10 end
	if not (red and green and blue) then
		red, green, blue = 0.9, 0.9, 0.9
	end

	local width = height*15

	local name = LIBSTRING.."MoneyView"..n
	local o = CreateFrame("Frame",name)
	o:UnregisterAllEvents()
	o:SetWidth(width)
	o:SetHeight(height)
	
	o.width = width
	o.height = height

	o.copper = CreateFrame("Frame", name.."Copper", o)
	o.copper:SetPoint("TOPRIGHT", o, "TOPRIGHT", 0,0)
	createCoin(o.copper, 0.5, height*2.8,height)

	o.silver = CreateFrame("Frame", name.."Silver", o)
	o.silver:SetPoint("TOPRIGHT", o.copper, "TOPLEFT", 0,0)
	createCoin(o.silver, 0.25, height*2.8,height)

	o.gold = CreateFrame("Frame", name.."Gold", o)
	o.gold:SetPoint("TOPRIGHT", o.silver, "TOPLEFT", 0,0)
	createCoin(o.gold, 0, width-(height*2.8),height)

-- Debugging code to see the extents:
--		o.texture = o:CreateTexture()
--		o.texture:SetTexture(0,1,0,1)
--		o.texture:SetPoint("TOPLEFT")
--		o.texture:SetPoint("BOTTOMRIGHT")
--		o.texture:SetDrawLayer("BACKGROUND")

	for method,func in pairs(methods) do
		if o[method] then o["Real"..method] = o[method] end
		o[method] = func
	end

	o:SetColor(red, green, blue)
	o:Hide()
	
	return o
end

--[[ INTERNAL USE ONLY
	Deactivates this version of the library, rendering it inert.
	Needed to run before an upgrade of the library takes place.
	@since 1.0
]]
function lib:Deactivate()
end

--[[ INTERNAL USE ONLY
	Activates this version of the library.
	Configures this library for use by setting up its variables and reregistering any previously registered tooltips.
	@since 1.0
]]
function lib:Activate()
end


lib:Activate()
