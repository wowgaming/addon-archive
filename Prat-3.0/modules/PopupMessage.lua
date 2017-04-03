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
Name: PratPopupMessage
Revision: $Revision: 80460 $
Author(s): Sylvanaar
Inspired by: CleanChat
Website: http://www.wowace.com/files/index.php?path=Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#PopupMessage
SVN: http://svn.wowace.com/wowace/trunk/Prat/
Description: Module for Prat that displays chat with your name in a pop up window
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("PopupMessage")

if PRAT_MODULE == nil then 
    return 
end

local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
    ["PopupMessage"] = true,
    ["Shows messages with your name in a popup."] = true,
    ["Set Separately"] = true,
    ["Toggle setting options separately for each chat window."] = true,
    ["show_name"] = "Show Popups",
    ["show_desc"] = "Show Popups for each window.",
    ["Show Popups"] = true,
    ["Show Popups for each window."] = true,
    ["show_perframename"] = "Show ChatFrame%d Popups",
    ["show_perframedesc"] = "Toggles showing popups on and off.",
    ["showall_name"] = "Show All Popups",
    ["showall_desc"] = "Show Popups for all chat windows.",
    ["Show All Popups"] = true,
    ["Show Popups for all chat windows."] = true,
    ["Add Nickname"] = true,
    ["Adds an alternate name to show in popups."] = true,
    ["Remove Nickname"] = true,
    ["Removes an alternate name to show in popups."] = true,
    ["Clear Nickname"] = true,
    ["Clears alternate name to show in popups."] = true,
    ["framealpha_name"] = "Popup Frame Alpha",
    ["framealpha_desc"] = "Set the alpha value of the popup frame when fully faded in.",
    ["Popup"] = true, 
    ["Shows messages in a popup window."] = true,
-- 	["Use SCT Message"] = true,
--	["Show the text as an SCT message instead of in its own frame"] = true,
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	["Add Nickname"] = true,
	["Adds an alternate name to show in popups."] = true,
	["Clear Nickname"] = true,
	["Clears alternate name to show in popups."] = true,
	framealpha_desc = "Set the alpha value of the popup frame when fully faded in.",
	framealpha_name = "Popup Frame Alpha",
	Popup = true,
	PopupMessage = true,
	["Remove Nickname"] = true,
	["Removes an alternate name to show in popups."] = true,
	["Set Separately"] = true,
	showall_desc = "Show Popups for all chat windows.",
	showall_name = "Show All Popups",
	["Show All Popups"] = true,
	show_desc = "Show Popups for each window.",
	show_name = "Show Popups",
	show_perframedesc = "Toggles showing popups on and off.",
	show_perframename = "Show ChatFrame%d Popups",
	["Show Popups"] = true,
	["Show Popups for all chat windows."] = true,
	["Show Popups for each window."] = true,
	["Shows messages in a popup window."] = true,
	["Shows messages with your name in a popup."] = true,
	["Toggle setting options separately for each chat window."] = true,
}

)
L:AddLocale("frFR",  
{
	-- ["Add Nickname"] = "",
	-- ["Adds an alternate name to show in popups."] = "",
	-- ["Clear Nickname"] = "",
	-- ["Clears alternate name to show in popups."] = "",
	-- framealpha_desc = "",
	-- framealpha_name = "",
	-- Popup = "",
	-- PopupMessage = "",
	-- ["Remove Nickname"] = "",
	-- ["Removes an alternate name to show in popups."] = "",
	-- ["Set Separately"] = "",
	-- showall_desc = "",
	-- showall_name = "",
	-- ["Show All Popups"] = "",
	-- show_desc = "",
	-- show_name = "",
	-- show_perframedesc = "",
	-- show_perframename = "",
	-- ["Show Popups"] = "",
	-- ["Show Popups for all chat windows."] = "",
	-- ["Show Popups for each window."] = "",
	-- ["Shows messages in a popup window."] = "",
	-- ["Shows messages with your name in a popup."] = "",
	-- ["Toggle setting options separately for each chat window."] = "",
}

)
L:AddLocale("deDE", 
{
	["Add Nickname"] = "Spitzname hinzufügen",
	["Adds an alternate name to show in popups."] = "Einen anderen (alternierenden) Namen hinzufügen, der in Popups angezeigt werden soll.",
	["Clear Nickname"] = "Spitznamen löschen",
	["Clears alternate name to show in popups."] = "Einen anderen (alternierenden) Namen löschen, der in Popups angezeigt werden soll.",
	framealpha_desc = "Den Transparenzwert des Popup-Rahmens bei voller Darstellung einstellen.",
	framealpha_name = "Transparenz der Popup-Rahmens",
	Popup = true,
	PopupMessage = true,
	["Remove Nickname"] = "Spitznamen entfernen",
	["Removes an alternate name to show in popups."] = "Einen anderen (alternierenden) Namen entfernen, der in Popups angezeigt werden soll.",
	["Set Separately"] = "Einzeln einstellen",
	showall_desc = "Popups für alle Chat-Fenster anzeigen.",
	showall_name = "Alle Popups anzeigen",
	["Show All Popups"] = "Alle Popups anzeigen",
	show_desc = "Popups für jedes Fenster anzeigen.",
	show_name = "Popups anzeigen",
	show_perframedesc = "Anzeige der Popups ein- und ausschalten.",
	show_perframename = "ChatFrame%d Popups anzeigen",
	["Show Popups"] = "Popups anzeigen",
	["Show Popups for all chat windows."] = "Popups für alle Chat-Fenster anzeigen.",
	["Show Popups for each window."] = "Popups für jedes Fenster anzeigen.",
	["Shows messages in a popup window."] = "Mitteilungen in einem Popup-Fenster anzeigen.",
	["Shows messages with your name in a popup."] = "Mitteilungen in einem Popup-Fenster mit deinem Namen anzeigen.",
	["Toggle setting options separately for each chat window."] = "Optionseinstellungen einzeln für jedes Chat-Fenster umschalten.",
}

)
L:AddLocale("koKR",  
{
	["Add Nickname"] = "별명 추가",
	["Adds an alternate name to show in popups."] = "팝업으로 표시될 별명을 추가합니다.",
	["Clear Nickname"] = "별명 청소",
	["Clears alternate name to show in popups."] = "팝업으로 표시될 별명을 청소합니다.",
	framealpha_desc = "가장 밝아졌을때 팝업 프레임의 투명도를 설정합니다.",
	framealpha_name = "팝업 프레임 투명도",
	Popup = "팝업",
	PopupMessage = "팝업메시지",
	["Remove Nickname"] = "별명 제거",
	["Removes an alternate name to show in popups."] = "팝업에 표시될 별명을 제거합니다.",
	["Set Separately"] = "분리 설정",
	showall_desc = "모든 채팅창에 팝업을 표시합니다.",
	showall_name = "팝업 모두 표시",
	["Show All Popups"] = "팝업 모두 표시",
	show_desc = "채팅창 마다 팝업을 표시합니다.",
	show_name = "팝업 표시",
	show_perframedesc = "팝업 표시 여부를 토글합니다.",
	show_perframename = "%d번 채팅창 팝업 표시",
	["Show Popups"] = "팝업 표시",
	["Show Popups for all chat windows."] = "모든 채팅창에 팝업을 표시합니다.",
	["Show Popups for each window."] = "채팅창 마다 팝업 표시.",
	["Shows messages in a popup window."] = "팝업창 안에 메시지를 보여줍니다.",
	["Shows messages with your name in a popup."] = "팝업 안에 당신의 이름과 메시지를 같이 보여줍니다.",
	["Toggle setting options separately for each chat window."] = "각 채팅창 별 설정 옵션을 토글합니다.",
}

)
L:AddLocale("esMX",  
{
	-- ["Add Nickname"] = "",
	-- ["Adds an alternate name to show in popups."] = "",
	-- ["Clear Nickname"] = "",
	-- ["Clears alternate name to show in popups."] = "",
	-- framealpha_desc = "",
	-- framealpha_name = "",
	-- Popup = "",
	-- PopupMessage = "",
	-- ["Remove Nickname"] = "",
	-- ["Removes an alternate name to show in popups."] = "",
	-- ["Set Separately"] = "",
	-- showall_desc = "",
	-- showall_name = "",
	-- ["Show All Popups"] = "",
	-- show_desc = "",
	-- show_name = "",
	-- show_perframedesc = "",
	-- show_perframename = "",
	-- ["Show Popups"] = "",
	-- ["Show Popups for all chat windows."] = "",
	-- ["Show Popups for each window."] = "",
	-- ["Shows messages in a popup window."] = "",
	-- ["Shows messages with your name in a popup."] = "",
	-- ["Toggle setting options separately for each chat window."] = "",
}

)
L:AddLocale("ruRU",  
{
	["Add Nickname"] = "Добавить ник",
	["Adds an alternate name to show in popups."] = "Добавить альтернативное имя для отображения при всплывании.",
	["Clear Nickname"] = "Очистить ники",
	["Clears alternate name to show in popups."] = "Очистить альтернативные имена для отображения при всплывании.",
	framealpha_desc = "Установка прозрачности всплывающего окна при полном затухании.",
	framealpha_name = "Прозрачность окна всплывания",
	Popup = "Всплывающий",
	PopupMessage = true,
	["Remove Nickname"] = "Удалить ник",
	["Removes an alternate name to show in popups."] = "Удалить альтернативное имя для отображения при всплывании.",
	["Set Separately"] = "Разделение",
	showall_desc = "Показывать всплывающие окна для всего чата.",
	showall_name = "Все всплывающие",
	["Show All Popups"] = "Все всплывающие",
	show_desc = "Отображать всплывние для всех окон чата.",
	show_name = "Показывать всплывание",
	show_perframedesc = "Вкл/Выкл отображение всплывания.",
	show_perframename = "Показать всплывание окна %d",
	["Show Popups"] = "Показывать всплывания",
	["Show Popups for all chat windows."] = "Показывать всплывающие окна для всего чата.",
	["Show Popups for each window."] = "Отображать всплывния для всех окон чата.",
	["Shows messages in a popup window."] = "Отображать сообщение в всплввающем окне.",
	["Shows messages with your name in a popup."] = "Отображать сообщение с вашим именем в всплывающем окне.",
	["Toggle setting options separately for each chat window."] = "Вкл/Выкл настройки разделения для всех окон чата.",
}

)
L:AddLocale("zhCN",  
{
	["Add Nickname"] = "添加昵称",
	["Adds an alternate name to show in popups."] = "添加一个显示在弹出中的替换名",
	["Clear Nickname"] = "清除昵称",
	["Clears alternate name to show in popups."] = "弹出显示清除候补名称",
	framealpha_desc = "设置完全消失时弹出框体透明度值",
	framealpha_name = "弹出框体透明度",
	Popup = "弹出",
	PopupMessage = "弹出信息",
	["Remove Nickname"] = "移除昵称",
	["Removes an alternate name to show in popups."] = "移除在弹出里显示的候补名称",
	["Set Separately"] = "个别设置",
	showall_desc = "在所有聊天窗口显示弹出",
	showall_name = "显示所有弹出",
	["Show All Popups"] = "显示所有弹出",
	show_desc = "在每个窗口显示弹出",
	show_name = "显示弹出",
	show_perframedesc = "弹出开关",
	show_perframename = "显示聊天框体%d弹出",
	["Show Popups"] = "显示弹出",
	["Show Popups for all chat windows."] = "为所有聊天窗后显示弹出",
	["Show Popups for each window."] = "为每个窗口显示弹出",
	["Shows messages in a popup window."] = "在弹出窗口显示信息",
	["Shows messages with your name in a popup."] = "在弹出中显示含有你名字的信息",
	["Toggle setting options separately for each chat window."] = "分别为每个聊天窗口设置选项",
}

)
L:AddLocale("esES",  
{
	["Add Nickname"] = "Añadir un Apodo",
	["Adds an alternate name to show in popups."] = "Añade un nombre alternativo para mostrar en las ventanas emergentes.",
	["Clear Nickname"] = "Limpiar Apodo",
	["Clears alternate name to show in popups."] = "Limpia el nombre alternativo a mostrar en las ventanas emergentes.",
	framealpha_desc = "Establece el valor de transparencia del marco emergente al desaparecer completamente.",
	framealpha_name = "Transparencia Marco Emergente",
	Popup = "Emergente",
	PopupMessage = "Mensaje Emergente",
	["Remove Nickname"] = "Eliminar Apodo",
	["Removes an alternate name to show in popups."] = "Quita un nombre alternativo para mostrar en las ventanas emergentes.",
	["Set Separately"] = "Establecer por Separado",
	showall_desc = "Mostrar Ventanas Emergentes para todas las ventanas de chat.",
	showall_name = "Mostrar Todas las Emergentes",
	["Show All Popups"] = "Mostrar Todas las Emergentes",
	show_desc = "Muestra Emergentes para cada ventana.",
	show_name = "Mostar Emergentes",
	show_perframedesc = "Alterna activación de mostrar ventanas emergentes.",
	show_perframename = "Mostrar Marcos Emergentes de Chat %d",
	["Show Popups"] = "Mostrar Emergentes",
	["Show Popups for all chat windows."] = "Mostrar Emergentes para todas las ventanas de chat.",
	["Show Popups for each window."] = "Mostrar Emergentes para cada ventana.",
	["Shows messages in a popup window."] = "Muestra mensajes en una ventana emergente.",
	["Shows messages with your name in a popup."] = "Muestra mensajes con tu nombre en una ventana emergente.",
	["Toggle setting options separately for each chat window."] = "Cambiar opciones de configuración por separado para cada ventana de chat.",
}

)
L:AddLocale("zhTW",  
{
	["Add Nickname"] = "新增暱稱",
	-- ["Adds an alternate name to show in popups."] = "",
	["Clear Nickname"] = "清除暱稱",
	-- ["Clears alternate name to show in popups."] = "",
	framealpha_desc = "設定彈出視窗完全淡入時的透明度值",
	framealpha_name = "彈出視窗透明度",
	Popup = "彈出",
	PopupMessage = "彈出訊息",
	["Remove Nickname"] = "移除暱稱",
	-- ["Removes an alternate name to show in popups."] = "",
	["Set Separately"] = "單獨設定",
	-- showall_desc = "",
	-- showall_name = "",
	["Show All Popups"] = "顯示所有彈出視窗",
	-- show_desc = "",
	-- show_name = "",
	-- show_perframedesc = "",
	-- show_perframename = "",
	["Show Popups"] = "顯示彈出視窗",
	-- ["Show Popups for all chat windows."] = "",
	-- ["Show Popups for each window."] = "",
	-- ["Shows messages in a popup window."] = "",
	-- ["Shows messages with your name in a popup."] = "",
	-- ["Toggle setting options separately for each chat window."] = "",
}

)
--@end-non-debug@



--

--

--
----[[
--	Chinese Local : CWDG Translation Team 昏睡墨鱼 (Thomas Mo)
--	CWDG site: http://Cwowaddon.com
--	$Rev: 80460 $
--]]
--

--

--

--


local EVENTS_EMOTES = {
  ["CHAT_MSG_BG_SYSTEM_ALLIANCE"] = true,
  ["CHAT_MSG_BG_SYSTEM_HORDE"] = true,
  ["CHAT_MSG_BG_SYSTEM_NEUTRAL"] = true,
  ["CHAT_MSG_EMOTE"] = true,
  ["CHAT_MSG_TEXT_EMOTE"] = true,
  ["CHAT_MSG_MONSTER_EMOTE"] = true,
  ["CHAT_MSG_MONSTER_SAY"] = true,
  ["CHAT_MSG_MONSTER_WHISPER"] = true,
  ["CHAT_MSG_MONSTER_YELL"] = true,
  ["CHAT_MSG_RAID_BOSS_EMOTE"] = true
};

local EVENTS_IGNORE = {
 ["CHAT_MSG_CHANNEL_NOTICE_USER"] = true,
 ["CHAT_MSG_SYSTEM"] = true,
}

-- create prat module
local module = Prat:NewModule(PRAT_MODULE, "LibSink-2.0")

Prat:SetModuleDefaults(module.name, {
	profile = {
	    on = false,
	    separate = true,
	    show = { ChatFrame1 = true },
	    framealpha = 1.0,
	    nickname = {},
		sinkoptions = { ["sink20OutputSink"] = "Popup" },
	}
} )

local pluginOptions =  { sink = {} }

Prat:SetModuleOptions(module, {
    name = L["PopupMessage"],
    desc = L["Shows messages with your name in a popup."],
    type = "group",
	plugins = pluginOptions,
    args = {
		helpheader = {
			name = "Settings",
			type = "header",
			order = 105,
		},
        show = {
            name = L["Show Popups"],
            desc = L["Show Popups for each window."],
	        type = "multiselect",
            order = 110,
			values = Prat.HookedFrameList,
			get = "GetSubValue",
			set = "SetSubValue"
        },
        addnick = {
            name = L["Add Nickname"],
            desc = L["Adds an alternate name to show in popups."],
            type = "input",
            order = 140,
            usage = "<string>",
            get = false,
			set = function(info, name) info.handler:AddNickname(name) end
        },
        removenick = {
            name = L["Remove Nickname"],
            desc = L["Removes an alternate name to show in popups."],
            type = "select",
            order = 150,
			get = function(info) return "" end,
			values = function(info) return info.handler.db.profile.nickname end,
            disabled = function(info) return #info.handler.db.profile.nickname == 0 end,
			set = function(info, value) info.handler:RemoveNickname(value) end
        },
        clearnick = {
            name = L["Clear Nickname"],
            desc = L["Clears alternate name to show in popups."],
			type = "execute",
            order = 160,
            disabled = function(info) return (#info.handler.db.profile.nickname == 0) end,
			func = "ClearNickname",
        },
    },
})

--[[------------------------------------------------
    Module Event Functions
------------------------------------------------]]--
Prat:SetModuleInit(module, 
	function(self)
    	self:RegisterSink(
    	    L["Popup"], 
    	    L["PopupMessage"], 
    	    L["Shows messages in a popup window."],
    	    "Popup"
    	)		
		self:SetSinkStorage(self.db.profile.sinkoptions)
		
		pluginOptions.sink["output"] = self:GetSinkAce3OptionsDataTable()
		pluginOptions.sink["output"].inline = true
		
		self.db.profile.show = self.db.profile.show or {}
	end
)

function module:OnModuleEnable()
	Prat.RegisterChatEvent(self, Prat.Events.POST_ADDMESSAGE)      	    

    self.nickpat = {}
	for _, v in ipairs(self.db.profile.nickname) do
        self.nickpat[v] = Prat.GetNamePattern(v)
	end

    self.playerName = Prat.GetNamePattern(UnitName("player"))
end

--[[------------------------------------------------
	Core Functions
------------------------------------------------]]--

-- /dump module.moduleOptions.args.output.get():find("Default")
-- /script module.moduleOptions.args.output.set("PopupMessage")
-- /dump module.db.profile
-- /script module.db.profile.sink10OutputSink = nil
function module:Popup(source, text, r,g,b, ...)   
    if UIFrameIsFlashing(Prat_PopupFrame) then  
        UIFrameFlashRemoveFrame(Prat_PopupFrame)
    end
    
	Prat_PopupFrame.fadeOut = 5;
	Prat_PopupFrame:SetAlpha(module.db.profile.framealpha or 1.0);
	Prat_PopupFrameText:SetTextColor(r,g,b)
	Prat_PopupFrameText:SetText(text);
	
	local font, _, style = ChatFrame1:GetFont()
	local _, fontsize = GameFontNormal:GetFont()
	Prat_PopupFrameText:SetFont( font, fontsize, style )   
    Prat_PopupFrameText:SetNonSpaceWrap(false)
	Prat_PopupFrame:SetWidth(math.min(math.max(64, Prat_PopupFrameText:GetStringWidth()+20), 520))
    Prat_PopupFrame:SetHeight(64)
	Prat_PopupFrame:SetBackdropBorderColor(r,g,b) 	

    Prat_PopupFrameText:ClearAllPoints()
    Prat_PopupFrameText:SetPoint("TOPLEFT", Prat_PopupFrame, "TOPLEFT", 10, 10)
    Prat_PopupFrameText:SetPoint("BOTTOMRIGHT", Prat_PopupFrame, "BOTTOMRIGHT", -10, -10)
	Prat_PopupFrameText:Show()
	
	local inTime, outTime, holdTime = 1, Prat_PopupFrame.fadeOut, 4   
	    
	local fadeInfo = {}
	local fadeInfoOut = {}
	fadeInfo.timeToFade = inTime
	fadeInfo.mode = "IN"
	fadeInfo.fadeHoldTime = holdTime
	fadeInfo.startAlpha = 0
	fadeInfo.endAlpha = module.db.profile.framealpha or 1.0

	fadeInfo.finishedFunc = UIFrameFade
	fadeInfo.finishedArg1 = Prat_PopupFrame
	fadeInfo.finishedArg2 = fadeInfoOut
	fadeInfoOut.startAlpha = module.db.profile.framealpha or 1.0
	fadeInfoOut.endAlpha = 0
	fadeInfoOut.timeToFade = outTime
	fadeInfoOut.mode = "OUT"
	fadeInfoOut.finishedFunc = function() Prat_PopupFrameText:Hide() end
	UIFrameFade(Prat_PopupFrame, fadeInfo)	    	    
end

local DEBUG 
--[===[@debug@ 
DEBUG = true
--@end-debug@]===]

function module:Prat_PostAddMessage(info, message, frame, event, text, r, g, b, id)
    if self.pouring then return end
    if Prat.EVENT_ID and 
       Prat.EVENT_ID == self.lastevent and 
       self.lasteventtype == event then 
       return 
    end
    
	if not (EVENTS_EMOTES[event] or EVENTS_IGNORE[event]) then
		if self.db.profile.showall or self.db.profile.show[frame:GetName()] then
			if DEBUG or not (message.ORG.PLAYER and self.playerName and message.ORG.PLAYER:match(self.playerName)) then
				self:CheckText(message.ORG.MESSAGE, message.OUTPUT, event, r, g, b)
			end
		end
	end
end

function module:AddNickname(name)
	for _, v in ipairs(self.db.profile.nickname) do
		if v:lower() == name:lower() then
			return
		end
	end
	tinsert(self.db.profile.nickname, name)

    self.nickpat[name] = Prat.GetNamePattern(name)
end

function module:RemoveNickname(idx)
    self.nickpat[self.db.profile.nickname[idx]] = nil
	tremove(self.db.profile.nickname, idx)
end

function module:ClearNickname()
    local n = self.db.profile.nickname
	while #n > 0 do
        self.nickpat[n[#n]] = nil
        n[#n] = nil
--		tremove(self.db.profile.nickname)
	end
end

local tmp_color = {}
local function safestr(s) return s or "" end
function module:CheckText(text, display_text, event, r, g, b)
--	local textL = safestr(text):lower()

    local show = false
    
    if text:match(self.playerName) then	
        show = true;
    else
    	for i, v in pairs(self.nickpat) do
            if v:len() > 0 and text:match(v) then
                show = true
            end
    	end
	end
	
	if show then 
        self.lasteventtype = event
        self.lastevent = Prat.EVENT_ID
        self.pouring = true
		self:Pour(display_text or text, r,g,b)
		Prat:PlaySound("popup");
        self.pouring = nil
	end	
end




  return
end ) -- Prat:AddModuleToLoad