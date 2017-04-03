---------------------------------------------------------------------------------
--
-- Prat - A framework for World of Warcraft chat mods
--
-- Copyright (C) 2006-2008  Prat Development Team
--
-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to:
--
-- Free Software Foundation, Inc.,
-- 51 Franklin Street, Fifth Floor,
-- Boston, MA  02110-1301, USA.
--
--
-------------------------------------------------------------------------------
--[[
Name: Prat 3.0 (textcolor.lua)
Revision: $Revision: 79446 $
Author(s): Sylvaanar (sylvanaar@mindspring.com)
Inspired By: Prat 2.0, Prat, and idChat2 by Industrial
Website: http://files.wowace.com/Prat/
Documentation: http://www.wowace.com/wiki/Prat
Forum: http://www.wowace.com/forums/index.php?topic=6243.0
SVN: http://svn.wowace.com/wowace/trunk/Prat/
Description: Text coloring functions (similar to crayon)
]]

--[[ BEGIN STANDARD HEADER ]]--

-- Imports
local _G = _G
local tostring = tostring
local select = select
local type = type
local table = table
local math = math
local string = string

-- Isolate the environment
setfenv(1, SVC_NAMESPACE)

--[[ END STANDARD HEADER ]]--


CLR = {}

CLR.DEFAULT = "ffffff" -- default to white
CLR.LINK = { "|cff", CLR.DEFAULT, "", "|r" }

CLR.COLOR_NONE = nil

local function get_default_color()
    return 1.0, 1.0, 1.0, 1.0
end

local function get_color(c)
    if type(c.r) == "number" and type(c.g) == "number" and type(c.b) == "number" and type(c.a) == "number" then
        return c.r, c.g, c.b, c.a
    end
    if type(c.r) == "number" and type(c.g) == "number" and type(c.b) == "number" then
        return c.r, c.g, c.b, 1.0
    end
    return get_default_color()
end

local function get_var_color(a1, a2, a3, a4)
    local r, g, b, a

    if type(a1) == "table" then
        r, g, b, a = get_color(a1)
    elseif type(a1) == "number" and type(a2) == "number" and type(a3) == "number" and type(a4) == "number" then
        r, g, b, a = a1, a2, a3, a4
    elseif type(a1) == "number" and type(a2) == "number" and type(a3) == "number" and type(a4) == "nil" then
        r, g, b, a = a1, a2, a3, 1.0
    else
        r, g, b, a = get_default_color()
    end

    return r, g, b, a
end

-- CLR:GetHexColor(color or cr, cg, cb)
local function mult_255(r,g,b,a)
    return r*255, g*255, b*255, a
end

function CLR:GetHexColor(a1, a2, a3, a4)
    return string.format("%02x%02x%02x", mult_255(get_var_color(a1, a2, a3, a4)))
end


function CLR:GetHashColor(text)
	local hash = 17

	for i=1, text:len() do
		hash = hash * 37 * text:byte(i)
	end

	local r = math.floor(math.fmod(hash / 97, 255));
	local g = math.floor(math.fmod(hash / 17, 255));
	local b = math.floor(math.fmod(hash / 227, 255));

    if ((r * 299 + g * 587 + b * 114) / 1000) < 105 then
    	r = math.abs(r - 255);
        g = math.abs(g - 255);
        b = math.abs(b - 255);
    end

	return ("%02x%02x%02x"):format(r, g, b)
end

function CLR:Random(text)
	return CLR:Colorize(self:GetHashColor(text), text)
end

function CLR:Colorize(hexColor, text)
    if text == nil or text == "" then
        return ""
    end

    local color = hexColor
    if type(hexColor) == "table" then
        color = self:GetHexColor(hexColor)
    end

    if color == CLR.COLOR_NONE then
        return text
    end

    local link = CLR.LINK

    link[2] = tostring(color or 'ffffff')
    link[3] = text

    return table.concat(link, "")
end

local function desat_chan(c) return ((c or 1.0)*192*0.8+63) / 255 end

function CLR:Desaturate(a1, a2, a3, a4)
    local r, g, b, a = get_var_color(a1, a2, a3, a4)

    r = desat_chan(r)
    g = desat_chan(g)
    b = desat_chan(b)

    return r, g, b, a
end


-- Not sure if the follow are used, i got them from either rock or crayon.

function CLR:RGBtoHSL(red, green, blue)
	local hue, saturation, luminance
	local minimum = math.min( red, green, blue )
	local maximum = math.max( red, green, blue )
	local difference = maximum - minimum
	
	luminance = ( maximum + minimum ) / 2
	
	if difference == 0 then --Greyscale
		hue = 0
		saturation = 0
	else              --Colour
		if luminance < 0.5 then 
			saturation = difference / ( maximum + minimum )
		else 
			saturation = difference / ( 2 - maximum- minimum ) 
		end
		
		local tmpRed   = ( ( ( maximum - red   ) / 6 ) + ( difference / 2 ) ) / difference
		local tmpGreen = ( ( ( maximum - green ) / 6 ) + ( difference / 2 ) ) / difference
		local tmpBlue  = ( ( ( maximum - blue  ) / 6 ) + ( difference / 2 ) ) / difference
		
		if red == maximum then 
			hue = tmpBlue - tmpGreen
		elseif green == maximum then 
			hue = ( 1 / 3 ) + tmpRed - tmpBlue
		elseif blue == maximum then 
			hue = ( 2 / 3 ) + tmpGreen - tmpRed
		end
		
		hue = hue % 1
		if hue < 0 then hue = hue + 1 end
	end
	
	return hue, saturation, luminance
end

function CLR:HSLtoRGB(hue, saturation, luminance)
	local red, green, blue
	
	if ( S == 0 ) then
		red, green, blue = luminance, luminance, luminance
	else
		if luminance < 0.5 then 
			var2 = luminance * ( 1 + saturation )
		else 
			var2 = ( luminance + saturation ) - ( saturation * luminance ) 
		end
		
		var1 = 2 * luminance - var2
		
		red   = self:HueToColor( var1, var2, hue + ( 1 / 3 ) )
		green = self:HueToColor( var1, var2, hue )
		blue  = self:HueToColor( var1, var2, hue - ( 1 / 3 ) )
	end
	
	return red, green, blue
end

function CLR:HueToColor(var1, var2, hue)
	hue = hue % 1
	if hue < 0 then hue = hue + 1 end

	if ( 6 * hue ) < 1 then 
		return hue + ( var2 - var1 ) * 6 * hue  
	elseif ( 2 * hue ) < 1 then 
		return var2 
	elseif ( 3 * hue ) < 2 then 
		return var1 + ( var2 - var1 ) * ( ( 2 / 3 ) - hue ) * 6 
	else 
		return var1 
	end
end

