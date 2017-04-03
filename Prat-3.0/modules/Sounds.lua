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
Name: PratSounds
Revision: $Revision: 80553 $
Author(s): Sylvanaar - Copy/Pasted from ChatSounds hy TotalPackage
Website: http://www.wowace.com/files/index.php?path=Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#Filtering
Subversion: http://svn.wowace.com/wowace/trunk/Prat/
Discussions: http://groups.google.com/group/wow-prat
Issues and feature requests: http://code.google.com/p/prat/issues/list
Description: A port of the Chatsounds addon to the Prat framework. (default=off).
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("Sounds")

if PRAT_MODULE == nil then 
    return 
end

local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
	["Sounds"] = true,
	["A module to play sounds on certain chat messages."] = true,
	["Add a custom channel"] = true,
	["Play a sound for a certain channel name (can be a substring)"] = true,
	["Remove a custom channel"] = true,
	["Reset settings"] = true,
	["Restore default settings and resets custom channel list"] = true,
	["Incoming Sounds"] = true,
	["Sound selection for incoming chat messages"] = true,
	["party_name"] = "Party",
	["party_desc"] = "Sound for %s party messages",
	["raid_name"] = "Raid",
	["raid_desc"] = "Sound for %s raid or battleground group/leader messages",
	["guild_name"] = "Guild",
	["guild_desc"] = "Sound for %s guild messages",
	["officer_name"] = "Officer",
	["officer_desc"] = "Sound for %s officer channel messages",
	["whisper_name"] = "Whisper",
	["whisper_desc"] = "Sound for %s whisper messages",
	["bn_whisper_name"] = "Battle.Net Whisper",
	["bn_whisper_desc"] = "Sound for %s Battle.Net whisper messages",	
	["group_lead_name"] = "Group Leader",
	["group_lead_desc"] = "Sound for %s raid leader, party leader or dungeon guide messages",	
    ["incoming"] = true,
	["outgoing"] = true,
	["Outgoing Sounds"] = true,
	["Sound selection for outgoing (from you) chat messages"] = true,
	["Custom Channels"] = true,
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	["Add a custom channel"] = true,
	["A module to play sounds on certain chat messages."] = true,
	bn_whisper_desc = "Sound for %s Battle.Net whisper messages",
	bn_whisper_name = "Battle.Net Whisper",
	["Custom Channels"] = true,
	group_lead_desc = "Sound for %s raid leader, party leader or dungeon guide messages",
	group_lead_name = "Group Leader",
	guild_desc = "Sound for %s guild messages",
	guild_name = "Guild",
	incoming = true,
	["Incoming Sounds"] = true,
	officer_desc = "Sound for %s officer channel messages",
	officer_name = "Officer",
	outgoing = true,
	["Outgoing Sounds"] = true,
	party_desc = "Sound for %s party messages",
	party_name = "Party",
	["Play a sound for a certain channel name (can be a substring)"] = true,
	raid_desc = "Sound for %s raid or battleground group/leader messages",
	raid_name = "Raid",
	["Remove a custom channel"] = true,
	["Reset settings"] = true,
	["Restore default settings and resets custom channel list"] = true,
	Sounds = true,
	["Sound selection for incoming chat messages"] = true,
	["Sound selection for outgoing (from you) chat messages"] = true,
	whisper_desc = "Sound for %s whisper messages",
	whisper_name = "Whisper",
}

)
L:AddLocale("frFR",  
{
	-- ["Add a custom channel"] = "",
	-- ["A module to play sounds on certain chat messages."] = "",
	-- bn_whisper_desc = "",
	-- bn_whisper_name = "",
	-- ["Custom Channels"] = "",
	-- group_lead_desc = "",
	group_lead_name = "Chef de groupe",
	-- guild_desc = "",
	guild_name = "Guilde",
	-- incoming = "",
	-- ["Incoming Sounds"] = "",
	-- officer_desc = "",
	-- officer_name = "",
	-- outgoing = "",
	-- ["Outgoing Sounds"] = "",
	-- party_desc = "",
	party_name = "Groupe",
	-- ["Play a sound for a certain channel name (can be a substring)"] = "",
	-- raid_desc = "",
	-- raid_name = "",
	-- ["Remove a custom channel"] = "",
	-- ["Reset settings"] = "",
	-- ["Restore default settings and resets custom channel list"] = "",
	-- Sounds = "",
	-- ["Sound selection for incoming chat messages"] = "",
	-- ["Sound selection for outgoing (from you) chat messages"] = "",
	-- whisper_desc = "",
	whisper_name = "Chuchoter",
}

)
L:AddLocale("deDE", 
{
	["Add a custom channel"] = "Einen allgemeinen Kanal hinzufügen.",
	["A module to play sounds on certain chat messages."] = "Ein Modul, um bei bestimmten Mitteilungen, Töne abzuspielen.",
	-- bn_whisper_desc = "",
	-- bn_whisper_name = "",
	["Custom Channels"] = "Allgemeine Kanäle",
	group_lead_desc = "Klang für %s Schlachtzugsleiter, Gruppenführer oder Anleitungsmitteilungen für Instanzen.",
	group_lead_name = "Gruppenführer",
	guild_desc = "Klang für %s Gildenmitteilungen",
	guild_name = "Gilde",
	incoming = "eingehend",
	["Incoming Sounds"] = "Eingehende Klänge",
	officer_desc = "Klang für %s Mitteilungen im Offizierskanal",
	officer_name = "Offizier",
	outgoing = "ausgehend",
	["Outgoing Sounds"] = "Ausgehende Töne",
	party_desc = "Klang für %s Gruppenmitteilungen",
	party_name = "Gruppe",
	["Play a sound for a certain channel name (can be a substring)"] = "Einen Klang für einen bestimmten Kanalnamen abspielen (kann ein Substring sein).",
	raid_desc = "Klang für %s Gruppen- und Führermitteilungen in Schlachtzügen oder Schlachtfeldern",
	raid_name = "Schlachtzug",
	["Remove a custom channel"] = "Einen allgemeinen Kanal entfernen",
	["Reset settings"] = "Einstellungen zurücksetzen",
	["Restore default settings and resets custom channel list"] = "Standardeinstellungen wiederherstellen und allgemein übliche Kanalliste zurücksetzen.",
	Sounds = "Klänge",
	["Sound selection for incoming chat messages"] = "Klangauswahl für eingehende Chat-Mitteilungen",
	["Sound selection for outgoing (from you) chat messages"] = "Klangauswahl für ausgehende (von dir) Chat-Mitteilungen",
	whisper_desc = "Klang für %s Flüstermitteilungen",
	whisper_name = "Flüstern",
}

)
L:AddLocale("koKR",  
{
	["Add a custom channel"] = "사설 채널 추가",
	-- ["A module to play sounds on certain chat messages."] = "",
	-- bn_whisper_desc = "",
	-- bn_whisper_name = "",
	["Custom Channels"] = "사설 채널",
	group_lead_desc = "%s 공격대장, 파티장 또는 던전 길잡이 메시지의 소리",
	group_lead_name = "공대장",
	guild_desc = "%s 길드 메시지 소리",
	guild_name = "길드",
	-- incoming = "",
	-- ["Incoming Sounds"] = "",
	officer_desc = "%s 관리자 채널 메시지 소리",
	officer_name = "관리자",
	-- outgoing = "",
	-- ["Outgoing Sounds"] = "",
	party_desc = "%s 파티 메시지 소리",
	party_name = "파티",
	-- ["Play a sound for a certain channel name (can be a substring)"] = "",
	raid_desc = "%s 공격대 또는 전장 파티/장 메시지 소리",
	raid_name = "공격대",
	["Remove a custom channel"] = "사설 채널 제거",
	["Reset settings"] = "설정 리셋",
	-- ["Restore default settings and resets custom channel list"] = "",
	Sounds = "소리",
	-- ["Sound selection for incoming chat messages"] = "",
	-- ["Sound selection for outgoing (from you) chat messages"] = "",
	whisper_desc = "%s 귓속말 메시지 소리",
	whisper_name = "귓속말",
}

)
L:AddLocale("esMX",  
{
	-- ["Add a custom channel"] = "",
	-- ["A module to play sounds on certain chat messages."] = "",
	-- bn_whisper_desc = "",
	-- bn_whisper_name = "",
	-- ["Custom Channels"] = "",
	-- group_lead_desc = "",
	-- group_lead_name = "",
	-- guild_desc = "",
	-- guild_name = "",
	-- incoming = "",
	-- ["Incoming Sounds"] = "",
	-- officer_desc = "",
	-- officer_name = "",
	-- outgoing = "",
	-- ["Outgoing Sounds"] = "",
	-- party_desc = "",
	-- party_name = "",
	-- ["Play a sound for a certain channel name (can be a substring)"] = "",
	-- raid_desc = "",
	-- raid_name = "",
	-- ["Remove a custom channel"] = "",
	-- ["Reset settings"] = "",
	-- ["Restore default settings and resets custom channel list"] = "",
	-- Sounds = "",
	-- ["Sound selection for incoming chat messages"] = "",
	-- ["Sound selection for outgoing (from you) chat messages"] = "",
	-- whisper_desc = "",
	-- whisper_name = "",
}

)
L:AddLocale("ruRU",  
{
	["Add a custom channel"] = "Добавить свой канал",
	["A module to play sounds on certain chat messages."] = "Модуль проигрывает зуки для определённых сообщений в чате.",
	-- bn_whisper_desc = "",
	-- bn_whisper_name = "",
	["Custom Channels"] = "Личные каналы",
	group_lead_desc = "Звук для сообщений %s лидера рейда, лидера группы или проводника подземелья",
	group_lead_name = "Лидер группы",
	guild_desc = "Звук %s для сообщений гильдии",
	guild_name = "Гильдия",
	incoming = "Входящие",
	["Incoming Sounds"] = "Звук входящих",
	officer_desc = "Звук %s для сообщений офицеров или личного канала",
	officer_name = "Офицеры",
	outgoing = "Исходящие",
	["Outgoing Sounds"] = "Звуки исходящего",
	party_desc = "Звук %s для сообщений группы",
	party_name = "Группа",
	["Play a sound for a certain channel name (can be a substring)"] = "Проигрывает зук для определённого канала чата (can be a substring)",
	raid_desc = "Звук %s для сообщений группы/лидера рейда или поля сражений",
	raid_name = "Рейд",
	["Remove a custom channel"] = "Удалить свой канал",
	["Reset settings"] = "Сброс настроек",
	["Restore default settings and resets custom channel list"] = "Восстановление стандартных настроек и сброс списка своих каналов чата.",
	Sounds = "Звуки",
	["Sound selection for incoming chat messages"] = "Выбор звука для входящих сообщений в чате",
	["Sound selection for outgoing (from you) chat messages"] = "Выбор звука для исходящих (от вас) сообщений в чате",
	whisper_desc = "Звук  %s для личных сообщений",
	whisper_name = "Шепот",
}

)
L:AddLocale("zhCN",  
{
	["Add a custom channel"] = "添加自定义频道",
	["A module to play sounds on certain chat messages."] = "在某些聊天信息播放声音的模块",
	-- bn_whisper_desc = "",
	-- bn_whisper_name = "",
	["Custom Channels"] = "自定义频道",
	-- group_lead_desc = "",
	-- group_lead_name = "",
	guild_desc = "公会信息声音",
	guild_name = "公会",
	incoming = "收到",
	["Incoming Sounds"] = "收入声音",
	officer_desc = "官员或自定义频道信息声音",
	officer_name = "官员",
	outgoing = "送出",
	["Outgoing Sounds"] = "送出声音",
	party_desc = " %s 小队信息声音",
	party_name = "小队",
	["Play a sound for a certain channel name (can be a substring)"] = "为特定频道名(可以是子字符串)播放声音",
	raid_desc = " %s 团队或战场分组/领袖信息声音",
	raid_name = "团队",
	["Remove a custom channel"] = "移除自定义频道",
	["Reset settings"] = "重制设置",
	["Restore default settings and resets custom channel list"] = "恢复默认设置并且重制自定义频道列表",
	Sounds = "声音",
	["Sound selection for incoming chat messages"] = "收到聊天信息声音设置",
	["Sound selection for outgoing (from you) chat messages"] = "送出(由你)聊天信息音乐设置",
	whisper_desc = "密语信息 %s 声音",
	whisper_name = "密语",
}

)
L:AddLocale("esES",  
{
	["Add a custom channel"] = "Añadir un canal personalizado",
	["A module to play sounds on certain chat messages."] = "Un módulo que reproduce sonidos con ciertos mensajes del chat.",
	-- bn_whisper_desc = "",
	-- bn_whisper_name = "",
	["Custom Channels"] = "Canales Personalizados",
	-- group_lead_desc = "",
	-- group_lead_name = "",
	guild_desc = "Sonido para mensajes de hermandad %s",
	guild_name = "Hermandad",
	incoming = "Recibido",
	["Incoming Sounds"] = "Sonidos Entrantes",
	officer_desc = "Sonido para mensajes del canal oficial o personalizado %s",
	officer_name = "Oficial",
	outgoing = "Saliente",
	["Outgoing Sounds"] = "Sonidos Salientes",
	party_desc = "Sonido para mensajes del grupo %s",
	party_name = "Grupo",
	["Play a sound for a certain channel name (can be a substring)"] = "Reproduce un sonido para un cierto nombre de canal (puede ser una subcadena)",
	raid_desc = "Sonido para mensajes de banda %s o líder/grupo de campo de batalla",
	raid_name = "Banda",
	["Remove a custom channel"] = "Eliminar un canal personalizado.",
	["Reset settings"] = "Restablecer ajustes",
	["Restore default settings and resets custom channel list"] = "Reestable ajustes por defecto y reestablece la lista de canales personalizados",
	Sounds = "Sonidos",
	["Sound selection for incoming chat messages"] = "Selección de sonido para mensajes de chat entrantes",
	["Sound selection for outgoing (from you) chat messages"] = "Selección de sonido para mensajes de chat salientes (de ti)",
	whisper_desc = "Sonido para susurros %s",
	whisper_name = "Susurrar",
}

)
L:AddLocale("zhTW",  
{
	["Add a custom channel"] = "加入自訂頻道",
	["A module to play sounds on certain chat messages."] = "模組：於特定聊天訊息播放音效。",
	-- bn_whisper_desc = "",
	-- bn_whisper_name = "",
	["Custom Channels"] = "自訂頻道",
	-- group_lead_desc = "",
	group_lead_name = "隊長",
	guild_desc = "公會訊息音效：%s",
	guild_name = "公會",
	-- incoming = "",
	-- ["Incoming Sounds"] = "",
	officer_desc = "幹部頻道音效：%s",
	officer_name = "幹部",
	-- outgoing = "",
	-- ["Outgoing Sounds"] = "",
	party_desc = "小隊訊息音效：%s",
	party_name = "小隊",
	["Play a sound for a certain channel name (can be a substring)"] = "於此頻道播放音效（可為字串）",
	raid_desc = "戰場以及戰場領導訊息音效：%s",
	raid_name = "團隊",
	["Remove a custom channel"] = "移除自訂頻道",
	["Reset settings"] = "重置設定",
	["Restore default settings and resets custom channel list"] = "恢復預設設定以及重置自訂聊天列表",
	Sounds = "音效",
	-- ["Sound selection for incoming chat messages"] = "",
	-- ["Sound selection for outgoing (from you) chat messages"] = "",
	whisper_desc = "密語訊息音效：%s",
	whisper_name = "密語",
}

)
--@end-non-debug@




----[[
--	Chinese Local : CWDG Translation Team 昏睡墨鱼 (Thomas Mo)
--	CWDG site: http://Cwowaddon.com
--	$Rev: 80553 $
--]]
--

--
 
--

--

--




-- create prat module
local module = Prat:NewModule(PRAT_MODULE, "AceEvent-3.0")


Prat:SetModuleDefaults(module.name, {
	profile = {
		on	= false,
		["incoming"] = {
			["GUILD"] = "Kachink",
			["OFFICER"] = "Link",
			["PARTY"] = "Text1",
			["RAID"] = "Text1",
			["WHISPER"] = "Heart",
			["BN_WHISPER"] = "Heart",
			["GROUP_LEAD"] = "Text2",
		},
		["outgoing"] = {
			["GUILD"] = "None",
			["OFFICER"] = "None",
			["PARTY"] = "None",
			["RAID"] = "None",
			["WHISPER"] = "None",
			["BN_WHISPER"] = "None",
			["GROUP_LEAD"] = "None",
		},
		["customlist"] = GetLocale() == "zhTW" and {
		}
		or { ["*"] = "None" },
	}
})



local media, SOUND

--[[------------------------------------------------
    Module Event Functions
------------------------------------------------]]--
-- things to do when the module is enabled
function module:OnModuleEnable()
	media = Prat.Media    
	SOUND = media.MediaType.SOUND
	self:BuildSoundList()
	self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE", "RefreshOptions")
    self:RefreshOptions()

    -- Remove older options
	for cname,value in pairs(self.db.profile.customlist) do
        if type(cname) == "number" then -- bad data
            self.db.profile.customlist[cname] = nil
        end
    end

	Prat.RegisterChatEvent(self, Prat.Events.POST_ADDMESSAGE)

	media.RegisterCallback(self, "LibSharedMedia_Registered", "SharedMedia_Registered")
	media.RegisterCallback(self, "LibSharedMedia_SetGlobal", "SharedMedia_Registered")
end



-- things to do when the module is disabled
function module:OnModuleDisable()
    self:UnregisterAllEvents()
	Prat.UnregisterAllChatEvents(self)
	media.UnregisterAllCallbacks(self)
end

local soundslist = {}


function module:BuildSoundList()
	if not media then return end

    for i,v in ipairs(soundslist) do
        soundslist[i] = nil
    end
    
    for k,v in pairs(media.MediaTable[SOUND]) do
        soundslist[k]=k
    end
end

function module:SharedMedia_Registered(mediatype, name)
    if mediatype == SOUND then
        self:BuildSoundList()
    end
end

do
	local optionGroup_mt = {
			type = "select",
			get = "GetChanOptValue",
			set = "SetChanOptValue",
			dialogControl = 'LSM30_Sound',
			values = AceGUIWidgetLSMlists.sound,
		}

	local optionGroup_mt = { __index = optionGroup_mt }
	
	local function newOptionGroup(text, incoming)
		local t= setmetatable({}, optionGroup_mt)
		t.name = L[text.."_name"]
		t.desc = (L[text.."_desc"]):format(incoming and L["incoming"] or L["outgoing"])
		return t
	end

    local customchans = {}

    function module:RefreshOptions()   
        local o = customchans
        local t = Prat.GetChannelTable()
        for _, n in pairs(t) do
            if type(n) == "string" then
                if not o[n] then
                    o[n] = 	setmetatable({ name = n, desc = n }, optionGroup_mt)
                end
            end
        end    
    end
	
	Prat:SetModuleOptions(module.name, {
	        name = L["Sounds"],
	        desc = L["A module to play sounds on certain chat messages."],
	        type = "group",
			childGroups  = "tab",
			args = {
				customlist = {
					type = "group",
					order = 40,
					name = L["Custom Channels"],
					desc = L["Custom Channels"],
					args = customchans
				},
				incoming = {
					type = "group",
					name = L["Incoming Sounds"],
					desc = L["Sound selection for incoming chat messages"],
					order = 20,
					args = {
						party = newOptionGroup("party", true),
						raid = newOptionGroup("raid", true),
						guild = newOptionGroup("guild", true),
						officer = newOptionGroup("officer", true),
						whisper = newOptionGroup("whisper", true),
						bn_whisper = newOptionGroup("bn_whisper", true),						
						group_lead = newOptionGroup("group_lead", true),
					},
				},
				outgoing = {
					type = "group",
					name = L["Outgoing Sounds"],
					desc = L["Sound selection for outgoing (from you) chat messages"],
					order = 30,
					args = {
						party = newOptionGroup("party"),
						raid = newOptionGroup("raid"),
						guild = newOptionGroup("guild"),
						officer = newOptionGroup("officer"),
						whisper = newOptionGroup("whisper"),
						bn_whisper = newOptionGroup("bn_whisper"),
						group_lead = newOptionGroup("group_lead", true),
					},
				},
			},
		}
	)	
end

function module:GetChanOptValue(info, ...)
	return self.db.profile[info[#info-1]][info[#info]:upper()]
end

function module:SetChanOptValue(info, val, ...)
	Prat:PlaySound(val)
	self.db.profile[info[#info-1]][info[#info]:upper()] = val
end

function module:GetCChanOptValue(info, ...)
	return self.db.profile.customlist[info[#info]]
end

function module:SetCChanOptValue(info, val, ...)
	self.db.profile.customlist[info[#info]] = val
end




--[[------------------------------------------------
	Core Functions
------------------------------------------------]]--
function module:Prat_PostAddMessage(info, message, frame, event, text, r, g, b, id)
    if Prat.EVENT_ID and Prat.EVENT_ID == self.lastevent and self.lasteventtype == event then return end
    
	local msgtype = string.sub(event, 10)
	local plr, svr = message.PLAYERLINK:match("([^%-]+)%-?(.*)")
	local outgoing = (plr == UnitName("player")) and true or false
	local sndprof = outgoing and self.db.profile.outgoing or self.db.profile.incoming
    
    if msgtype == "CHANNEL" then 
	    local chan = string.lower(message.ORG.CHANNEL)
		for cname,value in pairs(self.db.profile.customlist) do
			if strlen(cname) > 0 and chan == cname:lower() then
                self:PlaySound(value)
			end
		end
    else 
		if msgtype == "WHISPER_INFORM" then
		    msgtype = "WHISPER"
		    sndprof = self.db.profile.outgoing
		elseif msgtype == "WHISPER" then
		    sndprof = self.db.profile.incoming
		end
		if msgtype == "BN_WHISPER_INFORM" then
		    msgtype = "BN_WHISPER"
		    sndprof = self.db.profile.outgoing
		elseif msgtype == "BN_WHISPER" then
		    sndprof = self.db.profile.incoming
		end
		
		if msgtype == "PARTY_LEADER" or msgtype == "RAID_LEADER" or msgtype == "PARTY_GUIDE" then
			msgtype = "GROUP_LEAD"
        end
		
		if msgtype == "BATTLEGROUND" or msgtype == "BATTLEGROUND_LEADER" then
			msgtype = "RAID"
		end
 
		self:PlaySound(sndprof[msgtype], event)
    end
end


function module:PlaySound(sound, event)
    self.lasteventtype = event
    self.lastevent = Prat.EVENT_ID
    Prat:PlaySound(sound)
end

  return
end ) -- Prat:AddModuleToLoad