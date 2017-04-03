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
Name: PratChannelNames
Revision: $Revision: 80975 $
Author(s): Curney (asml8ed@gmail.com)
           Krtek (krtek4@gmail.com)
           Sylvanaar (sylvanaar@mindspring.com)
Inspired by: idChat2_ChannelNames by Industrial
Website: http://www.wowace.com/files/index.php?path=Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#ChannelNames
Subversion: http://svn.wowace.com/wowace/trunk/Prat/
Discussions: http://groups.google.com/group/wow-prat
Issues and feature requests: http://code.google.com/p/prat/issues/list
Description: Module for Prat that options for replacing channel names with abbreviations.
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("ChannelNames")

if PRAT_MODULE == nil then 
    return 
end

-- define localized strings
local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
    ["ChannelNames"] = true,
    ["Channel name abbreviation options."] = true,
    ["Replace"] = true,
    ["Toggle replacing this channel."] = true,
    ["Blank"] = true,
    ["Dont display the channel/chat type name"] = true,
    ["Set"] = true,
    ["Channel %d"] = true,
    ["%s settings."] = true,
    ["Use a custom replacement for the chat %s text."] = true,
    
	["channelnick_name"] = "Channel Abbreviations",
	["channelnick_desc"] = "Channel Abbreviations",

    ["Add Channel Abbreviation"] = true,
    ["addnick_desc"] = "Adds an abbreviated channel name. Prefix the name with '#' to include the channel number. (e.g. '#Trade').",
    ["Remove Channel Abbreviation"] = true,
    ["Removes an an abbreviated channel name."] = true,    
    ["Clear Channel Abbreviation"] = true,
    ["Clears an abbreviated channel name."] = true,

	["otheropts_name"] = "Other Options",
	["otheropts_desc"] = "Additional channel formating options, and channel link controls.",

    ["space_name"] = "Show Space",
    ["space_desc"] = "Toggle adding space after channel replacement.",
    ["colon_name"] = "Show Colon",
    ["colon_desc"] = "Toggle adding colon after channel replacement.",

    ["chanlink_name"] = "Create Channel Link",
    ["chanlink_desc"] = "Make the channel a clickable link which opens chat to that channel.",
	
    ["<string>"] = true,
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	["Add Channel Abbreviation"] = true,
	addnick_desc = "Adds an abbreviated channel name. Prefix the name with '#' to include the channel number. (e.g. '#Trade').",
	Blank = true,
	chanlink_desc = "Make the channel a clickable link which opens chat to that channel.",
	chanlink_name = "Create Channel Link",
	["Channel %d"] = true,
	["Channel name abbreviation options."] = true,
	ChannelNames = true,
	channelnick_desc = "Channel Abbreviations",
	channelnick_name = "Channel Abbreviations",
	["Clear Channel Abbreviation"] = true,
	["Clears an abbreviated channel name."] = true,
	colon_desc = "Toggle adding colon after channel replacement.",
	colon_name = "Show Colon",
	["Dont display the channel/chat type name"] = true,
	otheropts_desc = "Additional channel formating options, and channel link controls.",
	otheropts_name = "Other Options",
	["Remove Channel Abbreviation"] = true,
	["Removes an an abbreviated channel name."] = true,
	Replace = true,
	Set = true,
	space_desc = "Toggle adding space after channel replacement.",
	space_name = "Show Space",
	["%s settings."] = true,
	["<string>"] = true,
	["Toggle replacing this channel."] = true,
	["Use a custom replacement for the chat %s text."] = true,
}

)
L:AddLocale("frFR",  
{
	-- ["Add Channel Abbreviation"] = "",
	-- addnick_desc = "",
	-- Blank = "",
	-- chanlink_desc = "",
	-- chanlink_name = "",
	-- ["Channel %d"] = "",
	-- ["Channel name abbreviation options."] = "",
	-- ChannelNames = "",
	-- channelnick_desc = "",
	-- channelnick_name = "",
	-- ["Clear Channel Abbreviation"] = "",
	-- ["Clears an abbreviated channel name."] = "",
	-- colon_desc = "",
	-- colon_name = "",
	-- ["Dont display the channel/chat type name"] = "",
	-- otheropts_desc = "",
	-- otheropts_name = "",
	-- ["Remove Channel Abbreviation"] = "",
	-- ["Removes an an abbreviated channel name."] = "",
	-- Replace = "",
	-- Set = "",
	-- space_desc = "",
	-- space_name = "",
	-- ["%s settings."] = "",
	-- ["<string>"] = "",
	-- ["Toggle replacing this channel."] = "",
	-- ["Use a custom replacement for the chat %s text."] = "",
}

)
L:AddLocale("deDE", 
{
	["Add Channel Abbreviation"] = "Hinzufügen einer Kanal-Abkürzung",
	addnick_desc = "Fügt einen abgekürzten Kanalnamen hinzu. Füge den Vorsatz '#' dem Namen hinzu, um die Nummer des Kanals mit anzuzeigen (z.B. '#Handel')",
	Blank = "Leer",
	chanlink_desc = "Den Kanal zu einem anklickbaren Link machen, der den Chat zu diesem Kanal öffnet.",
	chanlink_name = "Kanal-Link erstellen",
	["Channel %d"] = "Kanal %d",
	["Channel name abbreviation options."] = "Optionen zu Kanalnamen-Abkürzungen.",
	ChannelNames = "Channel-Namen",
	channelnick_desc = "Kanalabkürzungen",
	channelnick_name = "Kanalabkürzungen",
	["Clear Channel Abbreviation"] = "Channel-Abkürzung löschen",
	["Clears an abbreviated channel name."] = "Löscht die Abkürzung eines Kanals",
	colon_desc = "Hinzufügen eines Doppelpunkts nach dem Ersetzen des Kanals ein-/ausschalten.",
	colon_name = "Doppelpunkt anzeigen",
	["Dont display the channel/chat type name"] = "Name des Kanal-/Chat-Typs nicht anzeigen",
	otheropts_desc = "Weitere Formatierungsoptionen für die Kanäle, sowie Steuerung der Kanal-Links.",
	otheropts_name = "Weitere Optionen",
	["Remove Channel Abbreviation"] = "Kanal-Abkürzung entfernen",
	["Removes an an abbreviated channel name."] = "Entfernt einen abgekürzten Kanalnamen.",
	Replace = "Ersetzen",
	Set = "Setzen",
	space_desc = [=[Hinzufügen eines Leerzeichens nach dem Ersetzen des Kanals ein-/ausschalten.
]=],
	space_name = "Leerzeichen anzeigen",
	["%s settings."] = "%s -Einstellungen.",
	["<string>"] = true,
	["Toggle replacing this channel."] = "Ersetzen für diesen Kanal ein-/ausschalten.",
	["Use a custom replacement for the chat %s text."] = "Benutze einen allgemein üblichen Ersatz für den Text des Chats %s.",
}

)
L:AddLocale("koKR",  
{
	["Add Channel Abbreviation"] = "채널 이름 줄임 추가",
	addnick_desc = "채널 이름 줄이기 추가. 채널 이름에 #을 붙이면 채널 번호를 포함합니다. (예. '#거래').",
	Blank = "공백",
	-- chanlink_desc = "",
	chanlink_name = "채널 링크 만들기",
	["Channel %d"] = "채널 %d",
	["Channel name abbreviation options."] = "채널 이름 줄이기 옵션.",
	ChannelNames = "채널 이름",
	channelnick_desc = "채널 이름 줄여쓰기",
	channelnick_name = "채널 이름 줄여쓰기",
	-- ["Clear Channel Abbreviation"] = "",
	-- ["Clears an abbreviated channel name."] = "",
	colon_desc = "대체 채널 이름 뒤에 콜론 추가",
	colon_name = "콜론 보이기",
	-- ["Dont display the channel/chat type name"] = "",
	-- otheropts_desc = "",
	otheropts_name = "기타 옵션",
	-- ["Remove Channel Abbreviation"] = "",
	-- ["Removes an an abbreviated channel name."] = "",
	Replace = "교체",
	-- Set = "",
	-- space_desc = "",
	space_name = "공간 보이기",
	["%s settings."] = "%s 설정.",
	["<string>"] = "<내용>",
	["Toggle replacing this channel."] = "이 채널 이름 대체하기",
	-- ["Use a custom replacement for the chat %s text."] = "",
}

)
L:AddLocale("esMX",  
{
	-- ["Add Channel Abbreviation"] = "",
	-- addnick_desc = "",
	-- Blank = "",
	-- chanlink_desc = "",
	-- chanlink_name = "",
	-- ["Channel %d"] = "",
	-- ["Channel name abbreviation options."] = "",
	-- ChannelNames = "",
	-- channelnick_desc = "",
	-- channelnick_name = "",
	-- ["Clear Channel Abbreviation"] = "",
	-- ["Clears an abbreviated channel name."] = "",
	-- colon_desc = "",
	-- colon_name = "",
	-- ["Dont display the channel/chat type name"] = "",
	-- otheropts_desc = "",
	-- otheropts_name = "",
	-- ["Remove Channel Abbreviation"] = "",
	-- ["Removes an an abbreviated channel name."] = "",
	-- Replace = "",
	-- Set = "",
	-- space_desc = "",
	-- space_name = "",
	-- ["%s settings."] = "",
	-- ["<string>"] = "",
	-- ["Toggle replacing this channel."] = "",
	-- ["Use a custom replacement for the chat %s text."] = "",
}

)
L:AddLocale("ruRU",  
{
	["Add Channel Abbreviation"] = "Добавить сокращение канала",
	addnick_desc = "Добавляет сокращение названий каналов. Префикс названия с '#' включает номер канала. (например '#Торговля').",
	Blank = "Пустой",
	chanlink_desc = "Сделать название канала ссылкой, щелчок по которой открывает окно чата этого канала.",
	chanlink_name = "Создать ссылку на канал",
	["Channel %d"] = "Канал %d",
	["Channel name abbreviation options."] = "Настройки сокращений названий каналов.",
	ChannelNames = "Название канала",
	channelnick_desc = "Сокращение канала",
	channelnick_name = "Сокращение канала",
	["Clear Channel Abbreviation"] = "Очистить сокращение канала",
	["Clears an abbreviated channel name."] = "Очищает сокращение названий каналов.",
	colon_desc = "Вкл/Выкл добавление двоеточия после замены канала.",
	colon_name = "Показывать двоеточие",
	["Dont display the channel/chat type name"] = "Не показывать название канала/тип чата",
	otheropts_desc = "Дополнительные настройки форматирования канала, и управление ссылками канала.",
	otheropts_name = "Другие настройки",
	["Remove Channel Abbreviation"] = "Удалить сокращение канала",
	["Removes an an abbreviated channel name."] = "Удаляет сокращение названий каналов.",
	Replace = "Заменить",
	Set = "Задать",
	space_desc = "Вкл/Выкл добавление пробела после замены канала.",
	space_name = "Показывать пробел",
	["%s settings."] = "Настройки %s.",
	["<string>"] = true,
	["Toggle replacing this channel."] = "Включить замену данного канала.",
	["Use a custom replacement for the chat %s text."] = "Использовать заданную замену текста %s канала.",
}

)
L:AddLocale("zhCN",  
{
	["Add Channel Abbreviation"] = "添加频道缩写",
	addnick_desc = "添加一个缩写的频道名称.名称前缀为 '#' 来包含频道数字(例如'#贸易')",
	Blank = "空白",
	chanlink_desc = "使频道可以点击链接打开频道聊天",
	chanlink_name = "创建频道链接",
	["Channel %d"] = "频道 %d",
	["Channel name abbreviation options."] = "频道名称缩写选项",
	ChannelNames = "频道名称",
	channelnick_desc = "频道缩写",
	channelnick_name = "频道缩写",
	["Clear Channel Abbreviation"] = "清除频道缩写",
	["Clears an abbreviated channel name."] = "清除一个频道名称缩写",
	colon_desc = "频道后添加冒号",
	colon_name = "显示冒号",
	["Dont display the channel/chat type name"] = "不要显示频道/聊天分类名称",
	otheropts_desc = "额外的频道格式选项，以及频道链接控制",
	otheropts_name = "其他选项",
	["Remove Channel Abbreviation"] = "移除频道缩写",
	["Removes an an abbreviated channel name."] = "移除一个频道名称缩写",
	Replace = "替换",
	Set = "设置",
	space_desc = "频道后添加空格",
	space_name = "显示空格",
	["%s settings."] = "%s 设置.",
	["<string>"] = "<字符串>",
	["Toggle replacing this channel."] = "替换频道",
	["Use a custom replacement for the chat %s text."] = "使用自定义替换此聊天 %s 文本",
}

)
L:AddLocale("esES",  
{
	["Add Channel Abbreviation"] = "Añadir Abreviatura del Canal",
	addnick_desc = "Agrega un nombre abreviado del canal. El nombre con '#' para incluir el número de canal. (por ejemplo, '#Comercio').",
	Blank = "Blanco",
	chanlink_desc = "Hacer del canal un vínculo clickable que abre el chat para ese canal.",
	chanlink_name = "Crear Enlace del Canal",
	["Channel %d"] = "Canal %d",
	["Channel name abbreviation options."] = "Opciones de abreviatura del nombre del canal.",
	ChannelNames = "NombresCanales",
	channelnick_desc = "Abreviaturas de Canal",
	channelnick_name = "Abreviaturas de Canal",
	["Clear Channel Abbreviation"] = "Limpiar Abreviatura de Canal",
	["Clears an abbreviated channel name."] = "Limpia un nombre de canal abreviado.",
	colon_desc = "Añade dos puntos después del canal reemplazado.",
	colon_name = "Mostrar dos puntos",
	["Dont display the channel/chat type name"] = "No mostrar el nombre del tipo de canal/chat",
	otheropts_desc = "Opciones de formato de canal adicionales y controles de enlace del canal.",
	otheropts_name = "Otras Opciones",
	["Remove Channel Abbreviation"] = "Eliminar Abreviatura de Canal",
	["Removes an an abbreviated channel name."] = "Elimina un nombre de canal abreviado.",
	Replace = "Sustituir",
	Set = "Establecer",
	space_desc = "Alternar añadir un espacio después del canal reemplazado.",
	space_name = "Mostrar Espacio",
	["%s settings."] = "opciones %s.",
	["<string>"] = "<cadena>",
	["Toggle replacing this channel."] = "Alterna reemplazar este canal.",
	["Use a custom replacement for the chat %s text."] = "Utilizarr un reemplazo personalizado para el texto del chat %s.",
}

)
L:AddLocale("zhTW",  
{
	["Add Channel Abbreviation"] = "新增頻道縮寫",
	-- addnick_desc = "",
	Blank = "空白",
	-- chanlink_desc = "",
	chanlink_name = "建立聊天連結",
	["Channel %d"] = "頻道 %d",
	["Channel name abbreviation options."] = "頻道名稱縮寫選項",
	ChannelNames = "頻道名稱",
	channelnick_desc = "頻道簡稱",
	channelnick_name = "頻道簡稱",
	["Clear Channel Abbreviation"] = "清除頻道名稱縮寫",
	-- ["Clears an abbreviated channel name."] = "",
	-- colon_desc = "",
	-- colon_name = "",
	-- ["Dont display the channel/chat type name"] = "",
	-- otheropts_desc = "",
	otheropts_name = "其他選項",
	["Remove Channel Abbreviation"] = "移除頻道縮寫",
	-- ["Removes an an abbreviated channel name."] = "",
	Replace = "替換",
	-- Set = "",
	-- space_desc = "",
	-- space_name = "",
	-- ["%s settings."] = "",
	-- ["<string>"] = "",
	-- ["Toggle replacing this channel."] = "",
	-- ["Use a custom replacement for the chat %s text."] = "",
}

)
--@end-non-debug@

-- order to show channels
local orderMap = {
        "say",
        "whisper",
        "whisperincome",
        "yell",
        "party",
        "partyleader",
        "partyguide",
        "guild",
        "officer",
        "raid",
        "raidleader",
        "raidwarning",
        "battleground",
        "battlegroundleader",
        "bnwhisper",
        "bnwhisperincome",
        "bnconversation",
}

if not CHAT_MSG_BN_WHISPER_INFORM then 
    CHAT_MSG_BN_WHISPER_INFORM = "Outgoing Real ID Whisper";
end

-- Look Up Our Settings Key event..message.CHANNUM
local eventMap = {
    CHAT_MSG_CHANNEL1 = "channel1",
    CHAT_MSG_CHANNEL2 = "channel2",
    CHAT_MSG_CHANNEL3 = "channel3",
    CHAT_MSG_CHANNEL4 = "channel4",
    CHAT_MSG_CHANNEL5 = "channel5",
    CHAT_MSG_CHANNEL6 = "channel6",
    CHAT_MSG_CHANNEL7 = "channel7",
    CHAT_MSG_CHANNEL8 = "channel8",
    CHAT_MSG_CHANNEL9 = "channel9",
--    CHAT_MSG_CHANNEL10 = "channel10",
    CHAT_MSG_SAY = "say",
    CHAT_MSG_GUILD = "guild",
    CHAT_MSG_WHISPER = "whisperincome",
    CHAT_MSG_WHISPER_INFORM = "whisper",
    CHAT_MSG_BN_WHISPER = "bnwhisperincome",
    CHAT_MSG_BN_WHISPER_INFORM = "bnwhisper",
    CHAT_MSG_YELL = "yell",
    CHAT_MSG_PARTY = "party",
    CHAT_MSG_PARTY_LEADER = "partyleader",
    CHAT_MSG_PARTY_GUIDE = "partyguide",
    CHAT_MSG_OFFICER = "officer",
    CHAT_MSG_RAID = "raid",
    CHAT_MSG_RAID_LEADER = "raidleader",
    CHAT_MSG_RAID_WARNING = "raidwarning",
    CHAT_MSG_BATTLEGROUND = "battleground",
    CHAT_MSG_BATTLEGROUND_LEADER = "battlegroundleader",
    CHAT_MSG_BN_CONVERSATION = "bnconversation"
}

local module = Prat:NewModule(PRAT_MODULE, "AceEvent-3.0", "AceTimer-3.0", "AceHook-3.0")

local CLR = Prat.CLR

Prat:SetModuleDefaults(module.name, {
	profile = {
    on = true,
    space = true,
    colon = true,
	chanlink = true,
    replace = {
        say = true,
        whisper = true,
        whisperincome = true,
        bnwhisper = true,
        bnwhisperincome = true,
        yell = true,
        party = true,
        partyleader = true,
        partyguide = true,
        guild = true,
        officer = true,
        raid = true,
        raidleader = true,
        raidwarning = true,
        battleground = true,
        battlegroundleader = true,
        channel1 = true,
        channel2 = true,
        channel3 = true,
        channel4 = true,
        channel5 = true,
        channel6 = true,
        channel7 = true,
        channel8 = true,
        channel9 = true,
        channel10 = true,
    },
    chanSave = {},
    shortnames = 
		-- zhCN
		PratCNlocal == "zhCN" and {
        say = "[说]",
        whisper = "[密]",
        whisperincome = "[收]",
        yell = "[喊]",
        party = "[队]",
        guild = "[会]",
        officer = "[管]",
        raid = "[团]",
        raidleader = "[酱]",
        raidwarning = "[警]",
        battleground = "[战]",
        battlegroundleader = "[蟀]",
        channel1 = "[1]",
        channel2 = "[2]",
        channel3 = "[3]",
        channel4 = "[4]",
        channel5 = "[5]",
        channel6 = "[6]",
        channel7 = "[7]",
        channel8 = "[8]",
        channel9 = "[9]",
        channel10 = "[10]",
    }
		--zhTW
		or PratCNlocal == "zhTW" and {
        say = "[說]",
        whisper = "[密]",
        whisperincome = "[聽]",
        yell = "[喊]",
        party = "[隊]",
        guild = "[會]",
        officer = "[官]",
        raid = "[團]",
        raidleader = "[團長]",
        raidwarning = "[警]",
        battleground = "[戰]",
        battlegroundleader = "[戰領]",
        channel1 = "[1]",
        channel2 = "[2]",
        channel3 = "[3]",
        channel4 = "[4]",
        channel5 = "[5]",
        channel6 = "[6]",
        channel7 = "[7]",
        channel8 = "[8]",
        channel9 = "[9]",
        channel10 = "[10]",
    }
		--koKR
		or PratCNlocal == "koKR" and {
        say = "[대화]",
        whisper = "[귓말]",
        whisperincome = "[받은귓말]",
        yell = "[외침]",
        party = "[파티]",
        guild = "[길드]",
        officer = "[오피서]",
        raid = "[공대]",
        raidleader = "[공대장]",
        raidwarning = "[공대경보]",
        battleground = "[전장]",
        battlegroundleader = "[전투대장]",
        channel1 = "[1]",
        channel2 = "[2]",
        channel3 = "[3]",
        channel4 = "[4]",
        channel5 = "[5]",
        channel6 = "[6]",
        channel7 = "[7]",
        channel8 = "[8]",
        channel9 = "[9]",
        channel10 = "[10]",
    	}
		--Other
		or {
        say = "[S]",
        whisper = "[W To]",
        whisperincome = "[W From]",
        bnwhisper = "[W To]",
        bnwhisperincome = "[W From]",
        yell = "[Y]",
        party = "[P]",
        partyleader = "[PL]",
        partyguide = "[DG]",
        guild = "[G]",
        officer = "[O]",
        raid = "[R]",
        raidleader = "[RL]",
        raidwarning = "[RW]",
        battleground = "[B]",
        battlegroundleader = "[BL]",
        channel1 = "[1]",
        channel2 = "[2]",
        channel3 = "[3]",
        channel4 = "[4]",
        channel5 = "[5]",
        channel6 = "[6]",
        channel7 = "[7]",
        channel8 = "[8]",
        channel9 = "[9]",
        channel10 = "[10]",
    },
    
    nickname = {}
	}
})



local eventPlugins = { types={}, channels={} }
local nickPlugins = { 	nicks={} }

---module.toggleOptions = { optsep227_sep = 227, optsep_sep = 229, space = 230, colon = 240, sep241_sep = 241, chanlink = 242 }
Prat:SetModuleOptions(module.name, {
    name = L["ChannelNames"],
    desc = L["Channel name abbreviation options."],
    type = "group",
	childGroups = "tab",
	args = {
		etypes = {
		    name = L["ChannelNames"],
		    desc = L["Channel name abbreviation options."],
		    type = "group",
--			inline = true,
		 	order = 1,
		    plugins= eventPlugins,
			args = {}
		},
		ntypes = {
		    name = L["channelnick_name"],
		    desc = L["channelnick_desc"],
		    order = 2,
--			inline = true,
		    type = "group",
			plugins = nickPlugins,
			args = {}
		},
		ctypes = {
		    name = L["otheropts_name"],
		    desc = L["otheropts_desc"],
		 	order = 3,
		    type = "group",
			args = {
--				chanlink = {
--					name = L["chanlink_name"],
--					desc = L["chanlink_desc"],
--					type = "toggle",				},
				space = {
					name = L["space_name"],
					desc = L["space_desc"],
					type = "toggle",				},
				colon = {
					name = L["colon_name"],
					desc = L["colon_desc"],
					type = "toggle",				},
			}
		},
	}
})

--[[------------------------------------------------
    Module Event Functions
------------------------------------------------]]--



function module:OnModuleEnable()
	self:BuildChannelOptions()
    self:RegisterEvent("UPDATE_CHAT_COLOR", "RefreshOptions")
	self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE") 

	Prat.RegisterChatEvent(self, "Prat_FrameMessage")

--  Possible fix for channel messages not getting formatted
	Prat.EnableProcessingForEvent("CHAT_MSG_CHANNEL_NOTICE")
	Prat.EnableProcessingForEvent("CHAT_MSG_CHANNEL_NOTICE_USER")
	Prat.EnableProcessingForEvent("CHAT_MSG_CHANNEL_LEAVE")
	Prat.EnableProcessingForEvent("CHAT_MSG_CHANNEL_JOIN")

    --self:AddOutboundWhisperColoring()

    --self:RawHook("ChatEdit_UpdateHeader", true)
end

function module:OnModuleDisable()
    self:UnregisterAllEvents()
	Prat.UnregisterAllChatEvents(self)
end



--function module:ChatEdit_UpdateHeader(editBox, ...)
--    self.hooks["ChatEdit_UpdateHeader"](...)
--	
--    local type = editBox:GetAttribute("chatType");
--	if ( not type ) then
--		return;
--	end
--
--	local info = ChatTypeInfo[type];
--	local header = _G[editBox:GetName().."Header"];
--	if ( not header ) then
--		return;
--	end    
--
--    if ( type == "CHANNEL" ) then
--		local channel, channelName, instanceID = GetChannelName(editBox:GetAttribute("channelTarget"));
--		if ( channelName ) then
--			if ( instanceID > 0 ) then
--				channelName = channelName.." "..instanceID;
--			end
--			info = ChatTypeInfo["CHANNEL"..channel];
--			editBox:SetAttribute("channelTarget", channel);
--			header:SetFormattedText(CHAT_CHANNEL_SEND, channel, channelName);
--		end
--    end
--end

--[[------------------------------------------------
    Core Functions
------------------------------------------------]]--

-- rebuild menu if chat colors change
function module:CHAT_MSG_CHANNEL_NOTICE()
	self:BuildChannelOptions()
	self:RefreshOptions()
end
function module:RefreshOptions()
	LibStub("AceConfigRegistry-3.0"):NotifyChange("Prat")
end

--function module:AddOutboundWhisperColoring()
--    if not CHAT_CONFIG_CHAT_RIGHT then return end
--
--	CHAT_CONFIG_CHAT_RIGHT[7] = {
--		text = CHAT_MSG_WHISPER_INFORM,
--		type = "WHISPER_INFORM",
--		checked = function () return IsListeningForMessageType("WHISPER"); end;
--		func = function (checked) ToggleChatMessageGroup(checked, "WHISPER"); end;
--	}
--
--	CHAT_CONFIG_CHAT_LEFT[#CHAT_CONFIG_CHAT_LEFT].text = CHAT_MSG_WHISPER
--end

function module:AddNickname(info, name)
    self.db.profile.nickname[info[#info-1]] = name
end

function module:RemoveNickname(info, name)
    if self.db.profile.nickname[info[#info-1]] then
        self.db.profile.nickname[info[#info-1]] = nil
    end
end
function module:GetNickname(info)
	return self.db.profile.nickname[info[#info-1]]
end
function module:NotGetNickname(info)
	return (self:GetNickname(info) == nil) and true or false
end

-- replace text using prat event implementation
function module:Prat_FrameMessage(arg, message, frame, event)
--    if message.TYPEPREFIX:len()>0 and message.TYPEPOSTFIX:len()>0 then

        if event == "CHAT_MSG_CHANNEL_JOIN" or event == "CHAT_MSG_CHANNEL_LEAVE" then
            message.MESSAGE = message.ORG.TYPEPOSTFIX:trim()
            message.ORG.TYPEPOSTFIX = " "
        end

        if event == "CHAT_MSG_CHANNEL_NOTICE" or event == "CHAT_MSG_CHANNEL_NOTICE_USER" or event == "CHAT_MSG_CHANNEL_JOIN" or event == "CHAT_MSG_CHANNEL_LEAVE" then
            event = "CHAT_MSG_CHANNEL"
        end

        local cfg
        
        if event == "CHAT_MSG_BN_CONVERSATION" then
         cfg = eventMap[event]
        else
         cfg = eventMap[event..(message.CHANNELNUM or "")]
        end

        if self.db.profile.nickname[message.CHANNEL] then
            message.CHANNEL = self.db.profile.nickname[message.CHANNEL]
			if message.CHANNEL:sub(1,1) == "#" then
				message.CHANNEL=message.CHANNEL:sub(2)
			else
				message.CHANNELNUM, message.CC = "", ""
			end
        elseif self.db.profile.replace[cfg] then
            message.cC , message.CHANNELNUM, message.CC, message.CHANNEL, message.Cc = "","","","",""
            local space = self.db.profile.space and self.db.profile.shortnames[cfg] and self.db.profile.shortnames[cfg] ~= "" and " " or ""
            local colon = self.db.profile.colon and (message.PLAYERLINK:len() > 0 and message.MESSAGE:len() > 0) and ":" or ""
            message.TYPEPREFIX = self.db.profile.shortnames[cfg] or ""

			if message.TYPEPREFIX:len() == 0 then 
                message.nN, message.NN, message.Nn, message.CHANLINK = "", "", "", ""
			end

            message.TYPEPREFIX = message.TYPEPREFIX..space
            
            if (message.PLAYERLINK:len() > 0) or (message.TYPEPREFIX:len() > 0)  then 
                message.TYPEPOSTFIX = colon.."\32"
            else
                message.TYPEPOSTFIX = ""
            end	
        end
--    end
end

--[[------------------------------------------------
    Menu Builder Functions
------------------------------------------------]]--

function module:BuildChannelOptions()
    for _, v in ipairs(orderMap) do
        self:CreateTypeOption(eventPlugins["types"], v)
    end
    for i=1,9 do
        self:CreateChannelOption(eventPlugins["channels"], "channel"..i, i)
    end
    
    local t = Prat.GetChannelTable()
    for k, v in pairs(t) do
        if type(v) == "string" then
            self:CreateChanNickOption(nickPlugins["nicks"], v)
        end
    end    
end

function module:CreateChanNickOption(args, keyname)
    local text = keyname
    local name = keyname
    args[name] = args[name] or {
        name = text,
        desc = string.format(L["%s settings."], text),
        type = "group",
        order = 228,
        args = {
            addnick = {
                name = L["Add Channel Abbreviation"],
                desc = L["addnick_desc"],
                type = "input",
                order = 140,
                usage = "<string>",
                get = "GetNickname",
				set = "AddNickname",
            },
            removenick = {
                name = L["Remove Channel Abbreviation"],
                desc = L["Removes an an abbreviated channel name."],
                type = "execute",
                order = 150,
				func = "RemoveNickname",
                disabled = "NotGetNickname";
            },  
        }
    }        
end

function module:GetChanOptValue(info, ...)
	return self.db.profile[info[#info]][info[#info-1]]
end

function module:SetChanOptValue(info, val, ...)
	self.db.profile[info[#info]][info[#info-1]] = val
end

do 
	local function revLookup(keyname)
	    for k,v in pairs(eventMap) do
	        if keyname == v then
	            return k
	        end
	    end
	end

	local function GetChatCLR(name)
	    local type = strsub(name, 10);
	    local info = ChatTypeInfo[type];
	    if not info then
	        return CLR.COLOR_NONE
	    end
	    return CLR:GetHexColor(info)
	end
	
	local function ChatType(text, type) return CLR:Colorize(GetChatCLR(type), text) end


	 local optionGroup = {
		    type = "group",
			name = function(info) return ChatType(_G[revLookup(info[#info])], revLookup(info[#info])) end,
			desc = function(info) return (L["%s settings."]):format(_G[revLookup(info[#info])]) end,
			get = "GetChanOptValue",
			set = "SetChanOptValue",
		    args = {
		        shortnames = {
					name = function(info) return ChatType(_G[revLookup(info[#info-1])], revLookup(info[#info-1])) end,
					desc = function(info) return (L["Use a custom replacement for the chat %s text."]):format(ChatType(_G[revLookup(info[#info-1])], revLookup(info[#info-1]))) end, 
		            order = 1,
		            type = "input",
		            usage = L["<string>"],
		        },
		        replace = {
		            name = L["Replace"],
		            desc = L["Toggle replacing this channel."],
		            type = "toggle",
		            order = 3,
		        },
		    }
		}

	 local optionGroupChan = {
		    type = "group",
			name = function(info) return ChatType((L["Channel %d"]):format(info[#info]:sub(-1)), revLookup(info[#info])) end,
			desc = function(info) return (L["%s settings."]):format(ChatType((L["Channel %d"]):format(info[#info]:sub(-1)), revLookup(info[#info]))) end,
			get = "GetChanOptValue",
			set = "SetChanOptValue",
			order = function(info)  return 200+tonumber(info[#info]:sub(-1)) end,
		    args = {
		        shortnames = {
					name = function(info) return ChatType((L["Channel %d"]):format(info[#info-1]:sub(-1)), revLookup(info[#info-1])) end,
					desc = function(info) return (L["Use a custom replacement for the chat %s text."]):format(ChatType((L["Channel %d"]):format(info[#info-1]:sub(-1)), revLookup(info[#info-1]))) end, 
		            order = 1,
		            type = "input",
		            usage = L["<string>"],
		        },
		        replace = {
		            name = L["Replace"],
		            desc = L["Toggle replacing this channel."],
		            type = "toggle",
		            order = 3,
		        },
		    }
		}
		
	function module:CreateTypeOption(args, keyname)
		if not args[keyname] then
	    	args[keyname] = optionGroup
		end
	end
	
	function module:CreateChannelOption(args, keyname, keynum)
		if not args[keyname] then
	    	args[keyname] = optionGroupChan
		end
	end
end




  return
end ) -- Prat:AddModuleToLoad
