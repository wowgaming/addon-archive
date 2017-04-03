---------------------------------------------------------------------------------
--
-- Prat - A framework for World of Warcraft chat mods
--
-- Copyright (C) 2006-2007  Prat Development Team
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
Name: PratFiltering
Revision: $Revision: 81859 $
Author(s): Sylvanaar
Website: http://www.wowace.com/files/index.php?path=Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#Filtering
Subversion: http://svn.wowace.com/wowace/trunk/Prat/
Discussions: http://groups.google.com/group/wow-prat
Issues and feature requests: http://code.google.com/p/prat/issues/list
Description: A module to provide basic chat filtering. (default=off).
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("Filtering")

if PRAT_MODULE == nil then 
    return 
end

local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
	["Filtering"] = true,
	["A module to provide basic chat filtering."] = true,
    ["leavejoin_name"] = "Filter Channel Leave/Join",
    ["leavejoin_desc"] = "Filter out channel leave/join spam",
    ["notices_name"] = "Filter Channel Notices",
    ["notices_desc"] = "Filter out other custom channel notification messages, e.g. moderator changes.",
    ["bgjoin_name"] = "Filter BG Leave/Join",
    ["bgjoin_desc"] = "Filter out channel Battleground leave/join spam",
    ["tradespam_name"] = "Throttle Spam",
    ["tradespam_desc"] = "Throttle messages to prevent the same message from being repeated multiple times",
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	["A module to provide basic chat filtering."] = true,
	bgjoin_desc = "Filter out channel Battleground leave/join spam",
	bgjoin_name = "Filter BG Leave/Join",
	Filtering = true,
	leavejoin_desc = "Filter out channel leave/join spam",
	leavejoin_name = "Filter Channel Leave/Join",
	notices_desc = "Filter out other custom channel notification messages, e.g. moderator changes.",
	notices_name = "Filter Channel Notices",
	tradespam_desc = "Throttle messages to prevent the same message from being repeated multiple times",
	tradespam_name = "Throttle Spam",
}

)
L:AddLocale("frFR",  
{
	["A module to provide basic chat filtering."] = "Un module pour fournir un filtrage basique",
	bgjoin_desc = "Filtrer les messages du canal Champ de bataille: \"quitte/rejoint\"",
	bgjoin_name = "Filtrer BG quitte/rejoint",
	Filtering = "Filtrage",
	leavejoin_desc = "Filtrer les messages: \"quitte/rejoint le canal\"",
	leavejoin_name = "Filtre Rejoindre/Quitte",
	-- notices_desc = "",
	notices_name = "Notifications de filtrage",
	-- tradespam_desc = "",
	-- tradespam_name = "",
}

)
L:AddLocale("deDE", 
{
	["A module to provide basic chat filtering."] = "Ein Modul, welches das elementare Filtern von Chat ermöglicht.",
	bgjoin_desc = "Den Spam zum Verlassen und Betreten eines Schlachtfelds verhindern.",
	bgjoin_name = "Filter BG Verlassen/Betreten",
	Filtering = "Filtert",
	leavejoin_desc = "Den Spam zum Verlassen und Beitreten eines Kanals verhindern.",
	leavejoin_name = "Filter Kanal Verlassen/Beitreten",
	notices_desc = "Die allgemein üblichen Benachrichtigungen in Kanälen verhindern, z.B. Moderatorenwechsel.",
	notices_name = "Kanal-Meldungen filtern",
	-- tradespam_desc = "",
	-- tradespam_name = "",
}

)
L:AddLocale("koKR",  
{
	["A module to provide basic chat filtering."] = "대화내용 필터링 모듈",
	bgjoin_desc = "전장채널 입장/퇴장 메시지를 숨깁니다.",
	bgjoin_name = "전장 입장/퇴장 필터링",
	Filtering = "필터링",
	leavejoin_desc = "채널 입장/퇴장 메시지를 숨깁니다.",
	leavejoin_name = "채널 입장/퇴장 필터링",
	notices_desc = "사용자 채널의 알림메시지를 숨깁니다, ex. 관리자 변경.",
	notices_name = "채널 알림메시지 필터링",
	-- tradespam_desc = "",
	-- tradespam_name = "",
}

)
L:AddLocale("esMX",  
{
	-- ["A module to provide basic chat filtering."] = "",
	-- bgjoin_desc = "",
	-- bgjoin_name = "",
	-- Filtering = "",
	-- leavejoin_desc = "",
	-- leavejoin_name = "",
	-- notices_desc = "",
	-- notices_name = "",
	-- tradespam_desc = "",
	-- tradespam_name = "",
}

)
L:AddLocale("ruRU",  
{
	["A module to provide basic chat filtering."] = "Модуль для обеспечения базовый фильтрации чата.",
	bgjoin_desc = "Отфильтровывать сообщения входа и выхода на/из Поля Сражения (БГ)",
	bgjoin_name = "Отфильтровывать вход/выход на ПС",
	Filtering = true,
	leavejoin_desc = "Отфильтровывать сообщения входа и выхода из/в канал.",
	leavejoin_name = "Вход/выход в/из канала",
	notices_desc = "Отфильтровывать извещения в каналах (такие как смета модератора и т.п.).",
	notices_name = "Извещения в канале",
	-- tradespam_desc = "",
	-- tradespam_name = "",
}

)
L:AddLocale("zhCN",  
{
	["A module to provide basic chat filtering."] = "提供基础的聊天过滤的模块",
	bgjoin_desc = "过滤战场频道离开/加入信息",
	bgjoin_name = "过滤战场出/入",
	Filtering = "过滤",
	leavejoin_desc = "滤掉频道离开/加入信息",
	leavejoin_name = "过滤频道离开/加入",
	notices_desc = "滤掉其他自定义频道通知信息,例如改变频道所有者",
	notices_name = "频道通知过滤",
	-- tradespam_desc = "",
	-- tradespam_name = "",
}

)
L:AddLocale("esES",  
{
	["A module to provide basic chat filtering."] = "Un módulo que proporciona el filtrado básico del chat.",
	bgjoin_desc = "Filtrar en canal Campo de Batlla spam ha abandonado/se ha unido",
	bgjoin_name = "Filtrar mensajes de unión/dejadas de Campos de Batalla",
	Filtering = "Filtrado",
	leavejoin_desc = "Filtrar en canal spam ha abandonado/se ha unido",
	leavejoin_name = "Filtro de Canal  Ha abandonado / Se ha unido",
	notices_desc = "Filtrar otros mensajes de notificación de canal personalizado, por ejemplo, los cambios de moderador.",
	notices_name = "Filtrar Noticias del Canal",
	-- tradespam_desc = "",
	-- tradespam_name = "",
}

)
L:AddLocale("zhTW",  
{
	["A module to provide basic chat filtering."] = "模組：提供基本聊天過濾。",
	bgjoin_desc = "濾除戰場頻道離開/加入訊息",
	bgjoin_name = "過濾戰場離開/參加",
	Filtering = "過濾",
	leavejoin_desc = "濾除頻道離開/加入訊息",
	leavejoin_name = "過濾頻道離開/加入",
	notices_desc = "濾除自訂頻道通知訊息，像是主持人變動",
	notices_name = "過濾頻道通知",
	-- tradespam_desc = "",
	-- tradespam_name = "",
}

)
--@end-non-debug@


local module = Prat:NewModule(PRAT_MODULE, "AceEvent-3.0")

Prat:SetModuleDefaults(module, {
	profile = {
		on	= false,
	    leavejoin = true,
	    notices = true,
		tradespam = false,
	}
} )

Prat:SetModuleOptions(module, {
        name = L["Filtering"] ,
        desc = L["A module to provide basic chat filtering."],
        type = "group",
        args = {
--		    leavejoin = { 
--				name = L["leavejoin_name"],
--				desc = L["leavejoin_desc"],
--				type = "toggle",
--				order = 100 
--			},
		    notices = { 
				name = L["notices_name"],
				desc = L["notices_desc"],
				type = "toggle",
				order = 110 
			},
		    tradespam = { 
				name = L["tradespam_name"],
				desc = L["tradespam_desc"],
				type = "toggle",
				order = 115 
			},


--		    bgjoin = { 
--				name = L["bgjoin_name"],
--				desc = L["bgjoin_desc"],
--				type = "toggle",
--				order = 111 
--			},	
        }
    }
)

local THROTTLE_TIME = 120
 
MessageTime = {}

local function cleanText(msg, author)
	local cleanmsg = msg:gsub("...hic!",""):gsub("%d",""):gsub("%c",""):gsub("%p",""):gsub("%s",""):upper():gsub("SH","S");
	return (author and author:upper() or "") .. cleanmsg;
end

--function tradeSpamFilter(frame, event, ...)
--    local arg1, arg2 = ...
--	local block = false;
--	local msg = cleanText(arg1, arg2);
--	
--	if arg2 == UnitName("player") then 
--		return false, ...
--	end
--
--	if MessageTime[msg] then
--		if difftime(time(), MessageTime[msg]) <= THROTTLE_TIME then
--			block = true;
--		else 
--		    MessageTime[msg] = nil 
--		end
--	else
--    	MessageTime[msg] = time();
--	end
--
--	if block then
--	    print("Filtered: "..msg)
--		return true
--	end
--
--    
--
--	return false, ...
--end

--[[------------------------------------------------
    Module Event Functions
------------------------------------------------]]--
function module:OnModuleEnable()
    self.throttleFrame = self.throttleFrame or CreateFrame("FRAME");
    
    self.throttle = THROTTLE_TIME
    
    self.throttleFrame:SetScript("OnUpdate", 
        function(frame, elapsed) 
            self.throttle = self.throttle - elapsed
            if frame:IsShown() and self.throttle < 0 then
                self.throttle = THROTTLE_TIME
                self:PruneMessages()
            end
        end)
    
--    ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", tradeSpamFilter)
--    ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", tradeSpamFilter)
       
	Prat.RegisterChatEvent(self, "Prat_FrameMessage")
end

-- things to do when the module is disabled
function module:OnModuleDisable()
--    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL", tradeSpamFilter)
--    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_YELL", tradeSpamFilter)


	Prat.UnregisterAllChatEvents(self)
end

--[[------------------------------------------------
    Core Functions
------------------------------------------------]]--



function module:PruneMessages()
    for k,v in pairs(MessageTime) do
        if difftime(time(), v) > THROTTLE_TIME then
            MessageTime[k] = nil
        end
    end
end




function module:Prat_FrameMessage(arg, message, frame, event)
    local newEvent = true
    if Prat.EVENT_ID and 
       Prat.EVENT_ID == self.lastevent and 
       self.lasteventtype == event then 
       newEvent = false
    end
     
    if self.db.profile.tradespam then
        if event == "CHAT_MSG_CHANNEL" or event == "CHAT_MSG_YELL" then
        	local msg = cleanText(message.ORG.MESSAGE, message.ORG.PLAYER)

        	if message.ORG.PLAYER ~= UnitName("player") then     
            	if newEvent and MessageTime[msg] then
            		if difftime(time(), MessageTime[msg]) <= THROTTLE_TIME then            		  
            			message.DONOTPROCESS = true
            		else 
            		    MessageTime[msg] = nil 
            		end
            	else
      	            self.lasteventtype = event
                    self.lastevent = Prat.EVENT_ID
                	MessageTime[msg] = time();
            	end    
            end
        end
    end
    
    if self.db.profile.notices then 
    	if  event == "CHAT_MSG_CHANNEL_NOTICE_USER" or event == "CHAT_MSG_CHANNEL_NOTICE"  then
    		message.DONOTPROCESS = true
    	end
    end
     
end

  return
end ) -- Prat:AddModuleToLoad