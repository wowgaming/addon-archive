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
Name: module
Revision: $Revision: 80392 $
Author(s): Krtek (krtek4@gmail.com); Fin (fin@instinct.org)
Website: http://files.wowace.com/Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#History
Subversion: http://svn.wowace.com/wowace/trunk/Prat/
Discussions: http://groups.google.com/group/wow-prat
Issues and feature requests: http://code.google.com/p/prat/issues/list
Description: Module for Prat that adds chat history options.
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

--[[
	2007-06-24: added option to save cmd history - fin
]]

local PRAT_MODULE = Prat:RequestModuleName("History")

if PRAT_MODULE == nil then 
    return 
end

local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
	["History"] = true,
	["Chat history options."] = true,
	["Set Chat Lines"] = true,
	["Set the number of lines of chat history for each window."] = true,
	["Set Command History"] = true,
	["Maximum number of lines of command history to save."] = true,
	["Save Command History"] = true,
	["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = true,
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	["Chat history options."] = true,
	History = true,
	["Maximum number of lines of command history to save."] = true,
	["Save Command History"] = true,
	["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = true,
	["Set Chat Lines"] = true,
	["Set Command History"] = true,
	["Set the number of lines of chat history for each window."] = true,
}

)
L:AddLocale("frFR",  
{
	-- ["Chat history options."] = "",
	History = "Historique",
	["Maximum number of lines of command history to save."] = "Nombre maximum de ligne de commande à sauvegarder dans l'historique.",
	["Save Command History"] = "Sauvegarder l'historique des commandes.",
	["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "Sauvegarde l'historique des commandes entre les sessions (à utiliser avec alt+haut ou juste haut)",
	-- ["Set Chat Lines"] = "",
	-- ["Set Command History"] = "",
	-- ["Set the number of lines of chat history for each window."] = "",
}

)
L:AddLocale("deDE", 
{
	["Chat history options."] = "Optionen zu Chat-Verlauf.",
	History = "Verlauf",
	["Maximum number of lines of command history to save."] = "Maximal zu speichernde Zeilenanzahl des Befehlverlaufs.",
	["Save Command History"] = "Befehlsverlauf speichern",
	["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "Speichert Befehlsverlauf zwischen Sitzungen (um mit Alt + \"Pfeil nach oben\" oder nur \"Pfeil nach oben\" verwendet zu werden).",
	["Set Chat Lines"] = "Chat-Zeilen einstellen",
	["Set Command History"] = "Befehlsverlauf einstellen",
	["Set the number of lines of chat history for each window."] = "Die Zeilenanzahl des Chat-Verlaufs für jedes Fenster einstellen.",
}

)
L:AddLocale("koKR",  
{
	["Chat history options."] = "히스토리 설정",
	History = "히스토리",
	["Maximum number of lines of command history to save."] = "기억할 명령어 히스토리 갯수를 설정합니다.",
	["Save Command History"] = "명령어 히스토리 저장",
	["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "명령어 히스토리를 저장합니다. (Alt+위화살표나 위화살표를 사용하는 명령어)",
	["Set Chat Lines"] = "대화 히스토리 설정",
	["Set Command History"] = "명령어 히스토리 설정",
	["Set the number of lines of chat history for each window."] = "각각의 대화창에 대해 최대 히스토리 라인수를 설정합니다.",
}

)
L:AddLocale("esMX",  
{
	-- ["Chat history options."] = "",
	-- History = "",
	-- ["Maximum number of lines of command history to save."] = "",
	-- ["Save Command History"] = "",
	-- ["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "",
	-- ["Set Chat Lines"] = "",
	-- ["Set Command History"] = "",
	-- ["Set the number of lines of chat history for each window."] = "",
}

)
L:AddLocale("ruRU",  
{
	["Chat history options."] = "Настройки истории чата.",
	History = true,
	["Maximum number of lines of command history to save."] = "Максимальное число строк сохранённых в истории команд.",
	["Save Command History"] = "Сохранять историю команд",
	["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "Сохранять историю команд между сеансами (для использования используйте alt+ стрелка вверх или просто стрелку вверх)",
	["Set Chat Lines"] = "Задать число строк чата",
	["Set Command History"] = "История команд",
	["Set the number of lines of chat history for each window."] = "Установите число строк истории чата для всех окон чата.",
}

)
L:AddLocale("zhCN",  
{
	["Chat history options."] = "历史聊天记录选项",
	History = "历史记录",
	["Maximum number of lines of command history to save."] = "存储命令记录最大行数",
	["Save Command History"] = "命令记录存储",
	["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "存储会话之间命令的历史记录(使用alt+上箭头键或仅上箭头键)",
	["Set Chat Lines"] = "聊天行设置",
	["Set Command History"] = "命令历史记录",
	["Set the number of lines of chat history for each window."] = "为每个聊天窗口设置聊天历史记录行数",
}

)
L:AddLocale("esES",  
{
	["Chat history options."] = "Opciones del historial del chat.",
	History = "Historial",
	["Maximum number of lines of command history to save."] = "Máximo número de líneas a guardar por el comando historial.",
	["Save Command History"] = "Comando Guardar Historial",
	["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "Guarda el historial de comandos entre sesiones (para utilizar con alt+flecha arriba o sólo la flecha arriba)",
	["Set Chat Lines"] = "Establecer Líneas de Chat",
	["Set Command History"] = "Establecer Historial de Comandos",
	["Set the number of lines of chat history for each window."] = "Establece el número de líneas del historial de chat para cada ventana.",
}

)
L:AddLocale("zhTW",  
{
	["Chat history options."] = "歷史訊息選項。",
	History = "歷史訊息",
	-- ["Maximum number of lines of command history to save."] = "",
	-- ["Save Command History"] = "",
	-- ["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "",
	["Set Chat Lines"] = "設定聊天行數",
	-- ["Set Command History"] = "",
	-- ["Set the number of lines of chat history for each window."] = "",
}

)
--@end-non-debug@

-- create prat module
local module = Prat:NewModule(PRAT_MODULE, "AceHook-3.0")

Prat:SetModuleDefaults(module.name, {
	profile = {
		on = true,
		chatlinesframes = {} ,
		chatlines = 384,
		maxlines = 50,
		savehistory = false,
		cmdhistory = {},
	}
})


Prat:SetModuleOptions(module.name, {
	name = L["History"],
	desc = L["Chat history options."],
	type = "group",
	args = {
		chatlinesframes = {
			name = L["Set Chat Lines"],
			desc = L["Set the number of lines of chat history for each window."],
			type = "multiselect",
			values = Prat.HookedFrameList,
			get = "GetSubValue",
			set = "SetSubValue"
        },
		chatlines = {
			name	= L["Set Chat Lines"],
			desc	= L["Set the number of lines of chat history for each window."],
			type	= "range",
			order	= 120,			min	= 300,
			max	= 5000,
			step	= 10,
			bigStep	= 50,
        },
		maxlines = {
			name	= L["Set Command History"],
			desc	= L["Maximum number of lines of command history to save."],
			type	= "range",
			order	= 120,			
			min	= 10,
			max	= 500,
			step	= 10,
			bigStep	= 50,
        },
		savehistory = {
			name	= L["Save Command History"],
			desc	= L["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"],
			type	= "toggle",
			order	= 130,
			
		},
	}
})

--[[------------------------------------------------
    Module Event Functions
------------------------------------------------]]--

-- things to do when the module is enabled
function module:OnModuleEnable()
	self:ConfigureAllChatFrames()

	if self.db.profile.savehistory then
		if not self.db.profile.cmdhistory then
			self.db.profile.cmdhistory = {}
		end

		self:SecureHook(ChatFrame1EditBox, "AddHistoryLine")
		self:addSavedHistory()
	end
end

-- things to do when the module is enabled
function module:OnModuleDisable()
	self:ConfigureAllChatFrames(384)

	self.db.profile.cmdhistory = {}
end

function module:ConfigureAllChatFrames(lines)
	local lines = lines or self.db.profile.chatlines

	for k,v in pairs(self.db.profile.chatlinesframes) do
		self:SetHistory(_G[k], lines)
	end
end

function module:OnSubvalueChanged()
	self:ConfigureAllChatFrames()
end
function module:OnValueChanged()
	self:ConfigureAllChatFrames()
end


--[[------------------------------------------------
	Core Functions
------------------------------------------------]]--
local aquire, reclaim
do
	local cache = setmetatable({}, {__mode='k'})
	acquire = function()
		local t = next(cache) or {}
		cache[t] = nil
		return t
	end
	reclaim = function (t)
		for k in pairs(t) do
			t[k] = nil
		end
		cache[t] = true
	end
end


function module:SetHistory(f, lines)   
	if f:GetMaxLines() ~= lines then
	    local chatlines = acquire()
        for i=f:GetNumRegions(),1,-1 do
            local x = select(i, f:GetRegions())
            if x:GetObjectType() == "FontString" then
                table.insert(chatlines, { x:GetText(), x:GetTextColor() })
            end
        end
	
		f:SetMaxLines(lines)

        Prat.loading = true
	    for i,v in ipairs(chatlines) do
            f:AddMessage(unpack(v))
        end	        
        Prat.loading = false
        
        reclaim(chatlines)
	end
end

function module:addSavedHistory(cmdhistory)
	local cmdhistory	= self.db.profile.cmdhistory
	local cmdindex		= #cmdhistory

	-- where there"s a while, there"s a way
	while cmdindex > 0 do
		ChatFrame1EditBox:AddHistoryLine(cmdhistory[cmdindex])
		cmdindex = cmdindex - 1
		-- way
	end
end

function module:saveLine(text)
	if not text or (text == "") then
		return false
	end

	local maxlines		= self.db.profile.maxlines
	local cmdhistory	= self.db.profile.cmdhistory or {}

	table.insert(cmdhistory, 1, text)

	if #cmdhistory > maxlines then
		for x = 1, (#cmdhistory - maxlines) do
			table.remove(cmdhistory)
		end
	end

	self.db.profile.cmdhistory = cmdhistory
end

function module:AddHistoryLine(editBox)
	editBox = editBox or {}

	-- following code mostly ripped off from Blizzard, but at least I understand it now
    local text	= ""
    local type	= editBox:GetAttribute("chatType")
    local header	= getglobal("SLASH_" .. type .. "1")

	if (header) then
		text = header
	end

    if (type == "WHISPER") then
            text = text .. " " .. editBox:GetAttribute("tellTarget")
    elseif (type == "CHANNEL") then
            text = "/" .. editBox:GetAttribute("channelTarget")
    end

    local editBoxText = editBox:GetText();
    if (strlen(editBoxText) > 0) then
            text = text.." "..editBox:GetText();
    self:saveLine(text)
    end
end


  return
end ) -- Prat:AddModuleToLoad