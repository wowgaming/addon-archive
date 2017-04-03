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

-- Isolate the environment
setfenv(1, SVC_NAMESPACE)

--[[ END STANDARD HEADER ]]--

local eventMap = {
    CHAT_MSG_CHANNEL = true,
    CHAT_MSG_SAY = true,
    CHAT_MSG_GUILD = true,
    CHAT_MSG_WHISPER = true,
    CHAT_MSG_WHISPER_INFORM = true,
    CHAT_MSG_YELL = true,
    CHAT_MSG_PARTY = true,
    CHAT_MSG_PARTY_LEADER = true,
    CHAT_MSG_PARTY_GUIDE = true,
    CHAT_MSG_OFFICER = true,
    CHAT_MSG_RAID = true,
    CHAT_MSG_RAID_LEADER = true,
    CHAT_MSG_RAID_WARNING = true,
    CHAT_MSG_BATTLEGROUND = true,
    CHAT_MSG_BATTLEGROUND_LEADER = true,
    CHAT_MSG_SYSTEM = true,
    CHAT_MSG_DND = true,
    CHAT_MSG_AFK = true,
    CHAT_MSG_BN_WHISPER = true,
    CHAT_MSG_BN_WHISPER_INFORM = true,
    CHAT_MSG_BN_CONVERSATION = true,
}

function EnableProcessingForEvent(event, flag)
    if flag == nil or flag == true then 
        eventMap[event] = true
    else
        eventMap[event] = nil
    end
end

function EventIsProcessed(event)
    return eventMap[event] or false
end

EVENT_ID = 0

local frame = _G.CreateFrame("Frame", "Prat30EventUIDFrame")
frame:RegisterAllEvents()
frame:SetScript("OnEvent", 
	function(self, event, ...)
	     -- for CHAT_MSG we will wrap the hook chain to provide a unique EVENT_ID
	     if eventMap[event] or (event ~= "CHAT_MSG_ADDON" and strsub(event, 1, 8) == "CHAT_MSG") then
	         EVENT_ID = EVENT_ID + 1  
		 else
			 self:UnregisterEvent(event)
	     end
	end
)
frame:Show()

