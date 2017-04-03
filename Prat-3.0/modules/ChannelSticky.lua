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
Name: PratChannelSticky
Revision: $Revision: 80710 $
Author(s): Curney (asml8ed@gmail.com)
           Krtek (krtek4@gmail.com)
           Sylvanaar (sylvanaar@mindspring.com)
Inspired by: idChat2_StickyChannels by Industrial
Website: http://www.wowace.com/files/index.php?path=Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#ChannelSticky
Subversion: http://svn.wowace.com/wowace/trunk/Prat/
Discussions: http://groups.google.com/group/wow-prat
Issues and feature requests: http://code.google.com/p/prat/issues/list
Description: Module for Prat that toggles sticky of different chat channel types on and off (default=on).
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("ChannelSticky")

if PRAT_MODULE == nil then 
    return 
end

local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
    ["ChannelSticky"] = true,
    ["Chat channel sticky options."] = true,
    ["ChatType"] = true,
    ["Per chat type options."] = true,
    ["Channel"] = true,
    ["Sticky %s"] = true,
    ["Toggles sticky on and off for %s."] = true,
    ["smartgroup_name"] = "Smart Groups",
    ["smartgroup_desc"] = "Adds a /gr command which automatically picks the correct type of chat, RAID, PARTY, or BATTLEGROUND",
    ["Sticky Per Chat Frame"] = true,
    ["Toggle remembering the chat type last used per chat frame."] = true,
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	Channel = true,
	ChannelSticky = true,
	["Chat channel sticky options."] = true,
	ChatType = true,
	["Per chat type options."] = true,
	smartgroup_desc = "Adds a /gr command which automatically picks the correct type of chat, RAID, PARTY, or BATTLEGROUND",
	smartgroup_name = "Smart Groups",
	["Sticky Per Chat Frame"] = true,
	["Sticky %s"] = true,
	["Toggle remembering the chat type last used per chat frame."] = true,
	["Toggles sticky on and off for %s."] = true,
}

)
L:AddLocale("frFR",  
{
	-- Channel = "",
	-- ChannelSticky = "",
	-- ["Chat channel sticky options."] = "",
	-- ChatType = "",
	-- ["Per chat type options."] = "",
	smartgroup_desc = "Ajouter une commande /gr qui sélectionne automatiquement le bon type de chat : raid, groupe, champ de bataille",
	smartgroup_name = "Groupes intelligents",
	-- ["Sticky Per Chat Frame"] = "",
	-- ["Sticky %s"] = "",
	-- ["Toggle remembering the chat type last used per chat frame."] = "",
	-- ["Toggles sticky on and off for %s."] = "",
}

)
L:AddLocale("deDE", 
{
	Channel = "Kanal",
	ChannelSticky = true,
	["Chat channel sticky options."] = "\"Sticky\"-Optionen für Chat-Kanal.",
	ChatType = true,
	["Per chat type options."] = "Optionen nach Chat-Type.",
	smartgroup_desc = "Fügt einen Befehl /gr hinzu, der automatisch den richtigen Chat-Typ aufnimmt - RAID, PARTY, oder BATTLEGROUND",
	smartgroup_name = "Intelligente Gruppen",
	["Sticky Per Chat Frame"] = "\"Sticky\" nach Chat-Rahmen",
	["Sticky %s"] = "\"Sticky\" %s",
	["Toggle remembering the chat type last used per chat frame."] = "Das Merken des Chat-Typs, der zuletzt im Chat-Rahmen aktiviert war, umschalten.",
	["Toggles sticky on and off for %s."] = "\"Sticky\" ein- und ausschalten für %s.",
}

)
L:AddLocale("koKR",  
{
	Channel = "채널",
	ChannelSticky = "채널고정",
	["Chat channel sticky options."] = "채팅 채널 고정 옵션.",
	-- ChatType = "",
	-- ["Per chat type options."] = "",
	smartgroup_desc = "자동으로 유효한 채팅 타입을 선택하도록 /gr 명령어를 추가합니다. (공격대, 파티 또는 전장)",
	smartgroup_name = "스마트 그룹",
	["Sticky Per Chat Frame"] = "채팅창 별 고정",
	["Sticky %s"] = "%s 고정",
	-- ["Toggle remembering the chat type last used per chat frame."] = "",
	["Toggles sticky on and off for %s."] = "입력고정 켜거나 끄기 %s.",
}

)
L:AddLocale("esMX",  
{
	-- Channel = "",
	-- ChannelSticky = "",
	-- ["Chat channel sticky options."] = "",
	-- ChatType = "",
	-- ["Per chat type options."] = "",
	-- smartgroup_desc = "",
	-- smartgroup_name = "",
	-- ["Sticky Per Chat Frame"] = "",
	-- ["Sticky %s"] = "",
	-- ["Toggle remembering the chat type last used per chat frame."] = "",
	-- ["Toggles sticky on and off for %s."] = "",
}

)
L:AddLocale("ruRU",  
{
	Channel = "Канал",
	ChannelSticky = "Совмещение каналов",
	["Chat channel sticky options."] = "Настройки прилипания каналов чата.",
	ChatType = "Тип чата",
	["Per chat type options."] = "Настройки по типу чата.",
	smartgroup_desc = "Добавляет команду /gr , автоматически выбирающую корректный тип чата, РЕЙД, ГРУППА, или ПОЛЕ БОЯ",
	smartgroup_name = "Быстрая сортировка",
	["Sticky Per Chat Frame"] = "Прилипать к окнам чата",
	["Sticky %s"] = "Прилепить к %s",
	["Toggle remembering the chat type last used per chat frame."] = "Вкл/Выкл запоминание тип чата при последнем использовании чата.",
	["Toggles sticky on and off for %s."] = "Вкл/Выкл прилепание для %s.",
}

)
L:AddLocale("zhCN",  
{
	Channel = "频道",
	ChannelSticky = "频道粘连",
	["Chat channel sticky options."] = "聊天频道粘连选项",
	ChatType = "聊天分类",
	["Per chat type options."] = "每个聊天分类选项",
	smartgroup_desc = "添加一个/gr命令用来自动选择正确的聊天分类,比如团队,小队或战场",
	smartgroup_name = "智能分组",
	["Sticky Per Chat Frame"] = "粘连每个聊天框",
	["Sticky %s"] = "粘连 %s",
	["Toggle remembering the chat type last used per chat frame."] = "记住每个聊天框上一次使用的聊天分类",
	["Toggles sticky on and off for %s."] = "切换%s的粘连开关",
}

)
L:AddLocale("esES",  
{
	Channel = "Canal",
	ChannelSticky = "CanalAdhesivo",
	["Chat channel sticky options."] = "Opciones de canal adhesivo de chat.",
	ChatType = "TipoChat",
	["Per chat type options."] = "Opciones por tipo de chat.",
	smartgroup_desc = "Agrega un comando /gr que escoge automáticamente el tipo correcto de chat, BANDA, GRUPO, o CAMPO DE BATALLA",
	smartgroup_name = "Grupos Inteligentes",
	["Sticky Per Chat Frame"] = "Adhesivo Por Marco de Chat",
	["Sticky %s"] = "Adhesivo %s",
	["Toggle remembering the chat type last used per chat frame."] = "Alternar recordar el último tipo de chat utilizado por el marco de chat.",
	["Toggles sticky on and off for %s."] = "Alterna activar adhesivo para %s.",
}

)
L:AddLocale("zhTW",  
{
	Channel = "頻道",
	ChannelSticky = "固定頻道",
	["Chat channel sticky options."] = "聊天頻道固定選項",
	ChatType = "聊天類型",
	-- ["Per chat type options."] = "",
	-- smartgroup_desc = "",
	smartgroup_name = "智慧化群組",
	["Sticky Per Chat Frame"] = "個別聊天視窗固定",
	["Sticky %s"] = "固定 %s",
	-- ["Toggle remembering the chat type last used per chat frame."] = "",
	-- ["Toggles sticky on and off for %s."] = "",
}

)
--@end-non-debug@


-- chat channel list
local chatList = {
    "SAY",
    "WHISPER",
    "YELL",
    "PARTY",
    "GUILD",
    "OFFICER",
    "RAID",
    "RAID_WARNING",
    "BATTLEGROUND",
    "CHANNEL",
    "EMOTE",
    "BN_WHISPER",
    "BN_CONVERSATION",
}

local module = Prat:NewModule(PRAT_MODULE, "AceEvent-3.0", "AceTimer-3.0", "AceHook-3.0")

Prat:SetModuleDefaults(module, {
	profile = {
	    on = true,
	    say = true,
	    whisper = true,
	    yell = true,
	    party = true,
	    guild = true,
	    officer = true,
	    raid = true,
	    raid_warning = true,
	    battleground = true,
	    channel = true,
	    emote = true,
	    perframe = false,
	    smartgroup = false,
	    bn_whisper = true,
	    bn_conversation=true,
	}
} )

local chatTypePlugins = { ctype = {} }

Prat:SetModuleOptions(module, {
        name = L["ChannelSticky"],
        desc = L["Chat channel sticky options."],
        type = "group",
		plugins = chatTypePlugins,
        args = {
--            perframe = {
--                name = L["Sticky Per Chat Frame"],
--                desc = L["Toggle remembering the chat type last used per chat frame."],
--                type = "toggle",
--            },
			smartgroup = {
				name = L["smartgroup_name"],
				desc = L["smartgroup_desc"],
				type = "toggle",
			}
        }
    }
)

--[[------------------------------------------------
    Module Event Functions
------------------------------------------------]]--

function module:OnModuleEnable()
    self:BuildChannelList()

    self:RegisterEvent("UPDATE_CHAT_COLOR")

	local prof = self.db.profile

    -- sticky each channel based on db settings
    self:Stickum("SAY",prof.say)
    self:Stickum("WHISPER",prof.whisper)
    self:Stickum("YELL",prof.yell)
    self:Stickum("PARTY",prof.party)
    self:Stickum("GUILD",prof.guild)
    self:Stickum("OFFICER",prof.officer)
    self:Stickum("RAID",prof.raid)
    self:Stickum("RAID_WARNING",prof.raid_warning)
    self:Stickum("BATTLEGROUND",prof.battleground)
    self:Stickum("CHANNEL",prof.channel)
    self:Stickum("EMOTE",prof.emote)

    self:Stickum("BN_WHISPER",prof.bn_whisper)
    self:Stickum("BN_CONVERSATION",prof.bn_conversation)
    
    --self:StickyFrameChan(prof.perframe)
    
    Prat.RegisterChatEvent(self, "Prat_OutboundChat")
    
    if prof.smartgroup then 
        self:RegisterSmartGroup()
    end
end

function module:OnModuleDisable()
    -- dont sticky no mo!
    self:Stickum("SAY",false)
    self:Stickum("WHISPER",false)
    self:Stickum("YELL",false)
    self:Stickum("PARTY",false)
    self:Stickum("GUILD",false)
    self:Stickum("OFFICER",false)
    self:Stickum("RAID",false)
    self:Stickum("RAID_WARNING",false)
    self:Stickum("BATTLEGROUND",false)
    self:Stickum("CHANNEL",false)
    self:Stickum("EMOTE",false)
    -- forget about per chat frame stickying
    self:StickyFrameChan(false)
    -- unregister events
    self:UnregisterAllEvents()

	Prat.UnregisterAllChatEvents(self)
end

--[[------------------------------------------------
    Core Functions
------------------------------------------------]]--

-- rebuild options menu is chat colors change
function module:UPDATE_CHAT_COLOR()
	self:ScheduleTimer("BuildChannelList", 1)
end

function module:StickyFrameChan(enabled)
--    if not enabled then
--        self:UnhookAll()
--    else
--        self.perframe = {}
--        self.perframechannum = {}
--        self:RawHook("ChatFrame_OpenChat", true)
--        self:SecureHook("ChatEdit_OnEscapePressed")
--        self:SecureHook("SendChatMessage")
--        self:SecureHook("ChatEdit_OnEnterPressed")
--    end
end

--function module:ChatFrame_OpenChat(text, chatFrame)
--    if ( not chatFrame ) then
--        chatFrame = SELECTED_CHAT_FRAME
--    end
--
--	local eb = chatFrame.editBox
--
--    if eb == nil then
--        return self.hooks["ChatFrame_OpenChat"](text, chatFrame)
--    end
--    
--    local chatFrameN = chatFrame:GetName()
--
	--Prat.Print(eb:GetAttribute("chatType"))
--
--    if eb:GetAttribute("chatType") == "WHISPER" then
	----	 NADA
--    elseif eb:GetAttribute("chatType") == "GROUPSAY" then
--        eb:SetAttribute("origchatType", "GROUPSAY");
--    elseif self.perframe[chatFrameN] then
--        eb:SetAttribute("channelTarget", self.perframechannum[chatFrameN]);
--        eb:SetAttribute("chatType", self.perframe[chatFrameN]);
--        eb:SetAttribute("stickyType", self.perframe[chatFrameN]);
--    end
--
--    self.hooks["ChatFrame_OpenChat"](text, chatFrame)
--end
--
--function module:SendChatMessage(msg, chatType, language, channel)
--    if self.memoNext then
--        self.perframe[self.memoNext] = chatType
--        self.perframechannum[self.memoNext] = channel
--    end
--end
--
--function module:ChatEdit_OnEscapePressed(this)
--    self.memoNext = nil
--end
--
--function module:ChatEdit_OnEnterPressed(this)
--	this = this or _G.this
--    local chatFrameN = SELECTED_CHAT_FRAME:GetName()
--    local chatType = this:GetAttribute("chatType")
--    
--    local channel = this:GetAttribute("channelTarget")
--    self.perframe[chatFrameN] = chatType
--    self.perframechannum[chatFrameN] = channel
--    self.memoNext = nil
--end

function module:Stickum(channel, stickied)
	ChatTypeInfo[channel:upper()].sticky = stickied and 1 or 0
end

--[[------------------------------------------------
    Menu Builder Functions
------------------------------------------------]]--

local CLR = Prat.CLR
local function StkyChatType(text, type) return CLR:Colorize(module:GetChatCLR(type), text) end

function module:BuildChannelList()
	local o = chatTypePlugins["ctype"]

    for _,va in ipairs(chatList) do
        local val = va:lower()
        local chan
        if va ~= "CHANNEL" then
            chan = TEXT(getglobal("CHAT_MSG_"..va))
        else
            chan = L["Channel"]
        end
		
        o[val] = o[val] or {
            type = "toggle",
        }

		o[val].name = (L["Sticky %s"]):format(StkyChatType(chan:gsub(" ", ""), va))
		o[val].desc = (L["Toggles sticky on and off for %s."]):format(chan)
    end
end

function module:OnValueChanged(info, b)
	local o = info[#info] 
	
	if o == "smartgroup" then
		if b then self:RegisterSmartGroup() end
	elseif o == "perframe" then 
	    self:StickyFrameChan(b)		
	else
		self:Stickum(o, b)
	end
end

function module:GetChatCLR(name)
    local info = ChatTypeInfo[name];
    if not info then
        return CLR.COLOR_NONE
    end
    return CLR:GetHexColor(info)
end



function module:RegisterSmartGroup()
    if not self.smart_group then
    	self:SecureHook("ChatEdit_SendText", function(this) if self.groupsay then this:SetAttribute("chatType", "GROUPSAY") self.groupsay=nil end end)

	    self.smart_group = true

		SlashCmdList["SLASH_GROUPSAY"] = function(text)   
                 if text:trim():len() > 0 then   
                     local _,pvp = IsInInstance()   
                     if pvp == "pvp" then   
                         SendChatMessage(text, "BATTLEGROUND")   
                     elseif GetNumRaidMembers() > 0 then   
                         SendChatMessage(text, "RAID")   
                     elseif GetNumPartyMembers() > 0 then   
                         SendChatMessage(text, "PARTY")   
                     end   
                 end   
             end

		SLASH_GROUPSAY1 = "/gr"
		SLASH_GROUPSAY2 = "/group"
		ChatTypeInfo["GROUPSAY"] = { r=0.5, g=0.9, b=0.9, sticky = 1 }
		CHAT_GROUPSAY_SEND = "SmartGroup:\32 "
		CHAT_GROUPSAY_GET = "SmartGroup: %1\32 "
    end
end


function module:SmartGroupChatType()
     local _,pvp = IsInInstance()   

     if pvp == "pvp" then   
        return "BATTLEGROUND"  
     elseif GetNumRaidMembers() > 0 then   
         return "RAID"
     elseif GetNumPartyMembers() > 0 then   
         return "PARTY"
     end 
     
    return "SAY"
end  

function module:Prat_OutboundChat(arg, m)
	if m.CTYPE == "GROUPSAY" then
		self.groupsay = true
		m.CTYPE = self:SmartGroupChatType()
	end
end

  return
end ) -- Prat:AddModuleToLoad