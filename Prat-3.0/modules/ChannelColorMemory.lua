---------------------------------------------------------------------------------
--
-- Prat - A framework for World of Warcraft chat modules
--
-- Copyright (C) 2006-2007  Prat Development Team
--
-- This program is free software; you can redistribute it and/or
-- moduleify it under the terms of the GNU General Public License
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
Name: PratChannelColorMemory
Revision: $Revision: 82095 $
Author(s): Sylvanaar (sylvanaar@mindspring.com)
Inspired by: ConsisTint By Karl Isenberg (AnduinLothar)
Website: http://www.wowace.com/files/index.php?path=Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Moduleules#ChannelColorMemory
Subversion: http://svn.wowace.com/wowace/trunk/Prat/
Discussions: http://groups.google.com/group/wow-prat
Issues and feature requests: http://code.google.com/p/prat/issues/list
Description: Moduleule for Prat that remembers the colors of channels by channel name (default=on).
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("ChannelColorMemory")

if PRAT_MODULE == nil then 
    return 
end

local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
    ["ChannelColorMemory"] = true,
    ["Remembers the colors of each channel name."] = true,
    ["(%w+)%s?(.*)"] = "([^%s]+)%s?(.*)",
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	ChannelColorMemory = true,
	["Remembers the colors of each channel name."] = true,
	["(%w+)%s?(.*)"] = "(%S+)%s?(.*)",
}

)
L:AddLocale("frFR",  
{
	ChannelColorMemory = "MémoriserCouleurCanal",
	["Remembers the colors of each channel name."] = "Mémoriser la couleur de chaque nom de canal.",
	-- ["(%w+)%s?(.*)"] = "",
}

)
L:AddLocale("deDE", 
{
	ChannelColorMemory = true,
	["Remembers the colors of each channel name."] = "Speichert die Farbe jedes Kanalnamens.",
	["(%w+)%s?(.*)"] = true,
}

)
L:AddLocale("koKR",  
{
	ChannelColorMemory = "채널색깔기억",
	["Remembers the colors of each channel name."] = "각 채널이름의 색깔을 기억합니다.",
	["(%w+)%s?(.*)"] = "(%S+)%s?(.*)", -- Needs review
}

)
L:AddLocale("esMX",  
{
	-- ChannelColorMemory = "",
	-- ["Remembers the colors of each channel name."] = "",
	-- ["(%w+)%s?(.*)"] = "",
}

)
L:AddLocale("ruRU",  
{
	ChannelColorMemory = "Сохранение цветов каналов",
	["Remembers the colors of each channel name."] = "Запоминает цвета названия каждого канала.",
	["(%w+)%s?(.*)"] = true, -- Needs review
}

)
L:AddLocale("zhCN",  
{
	ChannelColorMemory = "频道颜色存储",
	["Remembers the colors of each channel name."] = "记住每个频道名称的颜色",
	["(%w+)%s?(.*)"] = true, -- Needs review
}

)
L:AddLocale("esES",  
{
	ChannelColorMemory = "MemoriaColorCanal",
	["Remembers the colors of each channel name."] = "Recordar los colores de cada nombre de canal.",
	["(%w+)%s?(.*)"] = true, -- Needs review
}

)
L:AddLocale("zhTW",  
{
	ChannelColorMemory = "頻道顏色記憶",
	-- ["Remembers the colors of each channel name."] = "",
	["(%w+)%s?(.*)"] = "(%S+)%s?(.*)",
}

)
--@end-non-debug@


local module = Prat:NewModule(PRAT_MODULE, "AceEvent-3.0")

Prat:SetModuleDefaults(module.name, {
	profile = {
	    on = true,
	    colors = {},
	}
} )

Prat:SetModuleOptions(module.name, {
        name = L["ChannelColorMemory"],
        desc = L["Remembers the colors of each channel name."],
        type = "group",
        args = {
			info = {
				name = "This module remembers what color you give to a channel with a particular name, so that if you rejoin the channel, no matter what number it is, it will always have the same color.",
				type = "description",
			}
        }
    }
)

--[[------------------------------------------------
    Moduleule Event Functions
------------------------------------------------]]--

-- things to do when the moduleule is enabled
function module:OnModuleEnable()
    self:RegisterEvent("UPDATE_CHAT_COLOR")
    self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE")
	self.zoneChanIdx = {}

	-- upgrade saved channel names to lowercase only
	for k,v in pairs(self.db.profile.colors) do
		if k ~= k:lower() then
			self.db.profile.colors[k:lower()] = v
		end
	end
	self:RestoreAllChatColors()
--	self:RememberAllCurrentChannels()
end

local function dbg(...)
   --  Prat:PrintLiteral(...)
end

function module:IndexServerChannels()
	for k,v in pairs(Prat.HookedFrames) do
		local t = {GetChatWindowChannels(v:GetID())}
		for i=1,#t,2 do
			local chan, num = t[i], t[i+1]
			if tonumber(num) and tonumber(num) > 0 then
				self.zoneChanIdx[tostring(num)] = tostring(chan) 
			end
		end
	end
end

function module:RememberAllCurrentChannels()
	for k,v in pairs(Prat.HookedFrames) do
		local t = {GetChatWindowChannels(v:GetID())}
		for i=1,#t,2 do
			local chan, num = t[i], t[i+1]

			if chan and chan:len()>0 then
                local color = self.db.profile.colors[chan:lower()];
                if (not color) then
                    self.db.profile.colors[chan:lower()] = {r=cr, g=cg, b=cb};
                else
                    color.r=cr
                    color.g=cg
                    color.b=cb
                end
			end
		end		
	end
end

function module:RestoreAllChatColors()
	for k,v in pairs(Prat.HookedFrames) do
		local t = {GetChatWindowChannels(v:GetID())}
		for i=1,#t,2 do
			local chan, num = t[i], t[i+1]
			if tonumber(num) and tonumber(num) > 0 then
				self.zoneChanIdx[tostring(num)] = tostring(chan) 
			end
			if chan and chan:len()>0 then
                local color = self.db.profile.colors[chan:lower()];
                if  color then                
					local number = GetChannelName(chan);
					if number then
						--Prat.Print(tostring(number).." "..tostring(chan))
						ChangeChatColor("CHANNEL"..number, color.r, color.g, color.b);
					end
                end
			end
		end		
	end
end		

--[[------------------------------------------------
    Core Functions
------------------------------------------------]]--


local function getServerChan(name)
    local t = {EnumerateServerChannels()}
	for _, channame in pairs(t) do
		if channame:lower() == name:lower() then
			return channame
		end
	end
end
		

function module:UPDATE_CHAT_COLOR(evt, ChatType, cr,cg,cb)
	dbg(evt, ChatType, cr,cg,cb)
    if (ChatType) then
        local number = ChatType:match("CHANNEL(%d+)")
        if ( number ) then
            local _, name = GetChannelName(number);
            if ( name ) then
                local name, zoneSuffix = name:match(L["(%w+)%s?(.*)"]);
				if zoneSuffix and zoneSuffix:len() > 0 then
				local cname = name

					name = getServerChan(name)
					--Prat.Print("Server Chan @"..tostring(number)..": "..tostring(cname).. " -> "..tostring(name))
				end

				if not name then return end

                local color = self.db.profile.colors[name:lower()];
                if (not color) then
                    self.db.profile.colors[name:lower()] = {r=cr, g=cg, b=cb};
                else
                    color.r=cr
                    color.g=cg
                    color.b=cb
                end
            end
        end
    end
end

function module:CHAT_MSG_CHANNEL_NOTICE(evt, NoticeType, Sender, Language, LongName, Target, Flags, ServChanID, number, cname, unknown, counter)
	dbg(evt, NoticeType, Sender, Language, LongName, Target, Flags, ServChanID, number, cname, unknown, counter)
	if tonumber(ServChanID) > 0 then 
		--Prat.Print("Server Chan @"..tostring(number)..": "..ServChanID.."  "..tostring(cname).. " -> "..tostring(self.zoneChanIdx[tostring(ServChanID)]))
		cname = self.zoneChanIdx[tostring(ServChanID)]

		if not cname then 
			self:IndexServerChannels()
		
			cname = self.zoneChanIdx[tostring(ServChanID)]
		--Prat.Print("Server Chan2: "..ServChanID.."  "..tostring(cname).. " -> "..tostring(self.zoneChanIdx[tostring(ServChanID)]))
		end
	end

	if number == nil or cname == nil then 
		return
    elseif (NoticeType == "YOU_JOINED") then
        local color = self.db.profile.colors[cname:lower()];
        if (color) then
            ChangeChatColor("CHANNEL"..number, color.r, color.g, color.b);
        end
	elseif (NoticeType == "YOU_LEFT") then
        local color = self.db.profile.colors[cname:lower()];
        if (color) then
            ChangeChatColor("CHANNEL"..number, 1.0, 0.75, 0.75);
        else
            color = ChatTypeInfo["CHANNEL"..number];
            self.db.profile.colors[cname:lower()] = {r=color.r, g=color.g, b=color.b};
		end
    end
end

  return
end ) -- Prat:AddModuleToLoad