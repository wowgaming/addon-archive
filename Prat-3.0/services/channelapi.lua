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
Name: Prat 3.0 (events.lua)
Revision: $Revision: 80213 $
Author(s): Sylvaanar (sylvanaar@mindspring.com)
Inspired By: Prat 2.0, Prat, and idChat2 by Industrial
Website: http://files.wowace.com/Prat/
Documentation: http://www.wowace.com/wiki/Prat
Forum: http://www.wowace.com/forums/index.php?topic=6243.0
SVN: http://svn.wowace.com/wowace/trunk/Prat/
Description: The chat event service
]]

--[[ BEGIN STANDARD HEADER ]]--

-- Imports
local _G = _G
local type = type
local strsub = strsub
local wipe = table.wipe
local pairs = pairs
local tostring = tostring

-- Isolate the environment
setfenv(1, SVC_NAMESPACE)

--[[ END STANDARD HEADER ]]--

do
    local chanTable = {}
    local function buildChanTable(t, name, num, ...)
        if name and num then
            t[num] = name
            t[name] = num
            return buildChanTable(t, ...)
        end
    
        return t
    end
    
    function GetChannelTable(t)
        if not t then 
            t = chanTable 
        end
        
        wipe(t)
    
        buildChanTable(t, _G.GetChannelList())

        if not t["LookingForGroup"] then
            local lfgnum = _G.GetChannelName("LookingForGroup")
            if lfgnum and lfgnum > 0 then
                t["LookingForGroup"] = lfgnum
                t[lfgnum] = "LookingForGroup"
            end
        end

		for k,v in pairs(t) do
			if type(k) == "string" then
				t[k:lower()] = v
			end
		end
        return t 
    end
end

function GetChannelNumber(channel)
    if not channel then return end

    local num = _G.GetChannelName(channel)

    if num and num > 0 then return num end

    local t = GetChannelTable()
    
    num = t[channel] or t[channel:lower()]

    if num == nil then
        local trynum = tonumber(channel)

        if trynum ~= nil and t[trynum] then
            channel = trynum
            num = t[trynum]
        end
    end

    if type(num) == "string" then
        return channel
    end


    return num
end

-- "CHANNEL_CATEGORY_CUSTOM", "CHANNEL_CATEGORY_WORLD", "CHANNEL_CATEGORY_GROUP"
local name, header, collapsed, channelNumber, active, count, category, voiceEnabled, voiceActive;
function GetChannelCategory(num)
    num = GetChannelNumber(num)
    for i=1, _G.GetNumDisplayChannels(), 1 do
        name, header, collapsed, channelNumber, count, active, category, voiceEnabled, voiceActive = _G.GetChannelDisplayInfo(i)

        if channelNumber == num then
            return category
        end
    end
end

local name, t
function IsPrivateChannel(num)
      return tostring(GetChannelCategory(num)) == "CHANNEL_CATEGORY_CUSTOM"
end

