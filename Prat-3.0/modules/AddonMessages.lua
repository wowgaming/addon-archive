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
Name: PratAddonMsgs
Revision: $Revision: 80330 $
Author(s): Sylvanaar (sylvanaar@mindspring.com)
Website: http://www.wowace.com/files/index.php?path=Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#AddonMsgs
Subversion: http://svn.wowace.com/wowace/trunk/Prat/
Discussions: http://groups.google.com/group/wow-prat
Issues and feature requests: http://code.google.com/p/prat/issues/list
Description: Module for Prat that toggles showing hidden addon messages on and off (default=off).
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("AddonMsgs")

if PRAT_MODULE == nil then 
    return 
end

-- define localized strings
local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
    ["AddonMsgs"] = true,
    ["Addon message options."] = true,
    ["show_name"] = "Show Addon Messages",
    ["show_desc"] = "Toggle showing hidden addon messages in each chat window.",
    ["show_perframename"] = "ChatFrame%d AddonMsgsShow",
    ["show_perframedesc"] = "Toggle showing hidden addon messages on and off.",
} )
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	["Addon message options."] = true,
	AddonMsgs = true,
	show_desc = "Toggle showing hidden addon messages in each chat window.",
	show_name = "Show Addon Messages",
	show_perframedesc = "Toggle showing hidden addon messages on and off.",
	show_perframename = "ChatFrame%d AddonMsgsShow",
}

)
L:AddLocale("frFR",  
{
	-- ["Addon message options."] = "",
	-- AddonMsgs = "",
	-- show_desc = "",
	-- show_name = "",
	-- show_perframedesc = "",
	-- show_perframename = "",
}

)
L:AddLocale("deDE", 
{
	["Addon message options."] = "Optionen für AddOn-Meldungen",
	AddonMsgs = "AddOn-Meldungen",
	show_desc = "Anzeige versteckter AddOn-Meldungen in jedem Chatfenster ein-/ausschalten.",
	show_name = "AddOn-Meldungen anzeigen",
	show_perframedesc = "Anzeige versteckter AddOn-Meldungen ein-/ausschalten.",
	show_perframename = "Chatfenster %d Addon Meldungen anzeigen",
}

)
L:AddLocale("koKR",  
{
	["Addon message options."] = "애드온 메시지 옵션.",
	AddonMsgs = "애드온 메시지",
	-- show_desc = "",
	show_name = "애드온 메시지 보기",
	-- show_perframedesc = "",
	show_perframename = "대화창%d 애드온메시지 보이기",
}

)
L:AddLocale("esMX",  
{
	-- ["Addon message options."] = "",
	-- AddonMsgs = "",
	-- show_desc = "",
	-- show_name = "",
	-- show_perframedesc = "",
	-- show_perframename = "",
}

)
L:AddLocale("ruRU",  
{
	["Addon message options."] = "Настройки сообщений модификаций.",
	AddonMsgs = "Сообщения аддонов",
	show_desc = "Включить отображение сообщений аддонов в каждой закладке чата.",
	show_name = "Показывать сообщения аддонов",
	show_perframedesc = "Вкл/Выкл отображение сообщений аддонов.",
	show_perframename = "ChatFrame%d AddonMsgsShow", -- Needs review
}

)
L:AddLocale("zhCN",  
{
	["Addon message options."] = "插件信息选项",
	AddonMsgs = "插件信息",
	show_desc = "在各自聊天窗口中显示隐藏的插件消息",
	show_name = "显示插件信息",
	show_perframedesc = "显示隐藏的插件消息",
	show_perframename = "聊天框体%d插件消息显示",
}

)
L:AddLocale("esES",  
{
	["Addon message options."] = "Opciones de mensaje del Addon.",
	AddonMsgs = "MensajesAddon",
	show_desc = "Alterna el mostrar mensajes ocultos del addon en cada ventana de chat.",
	show_name = "Mostrar Mensajes de Addons",
	show_perframedesc = "Alterna la activación de mostrar mensajes ocultos del addon.",
	show_perframename = "MarchoChat %d AddonMsgsShow",
}

)
L:AddLocale("zhTW",  
{
	["Addon message options."] = "插件訊息選項",
	AddonMsgs = "插件訊息",
	show_desc = "切換是否在每個聊天視窗顯示隱藏的插件訊息。",
	show_name = "顯示插件訊息",
	show_perframedesc = "切換是否顯示隱藏的插件訊息",
	show_perframename = "聊天框架%d 插件訊息顯示",
}

)
--@end-non-debug@


local mod = Prat:NewModule(PRAT_MODULE, "AceEvent-3.0")

Prat:SetModuleDefaults(mod.name, {
	profile = {
	    on = false,
	    show = {},
	}
} )

Prat:SetModuleOptions(mod.name, {
        name = L["AddonMsgs"],
        desc = L["Addon message options."],
        type = "group",
        args = {
			show = {
		        name = L["show_name"],
		        desc = L["show_desc"],
		        type = "multiselect",
				values = Prat.HookedFrameList,
				get = "GetSubValue",
				set = "SetSubValue"
			}
        }
    }
)

--[[------------------------------------------------
    Module Event Functions
------------------------------------------------]]--
function mod:OnModuleEnable()
	self:RegisterEvent("CHAT_MSG_ADDON")
end
function mod:OnModuleDisable()
	self:UnregisterEvent("CHAT_MSG_ADDON")
end

--[[------------------------------------------------
    Core Functions
------------------------------------------------]]--

local CLR = Prat.CLR

-- add a splash of color to text
local function c1(text) return CLR:Colorize("ffff40", text) end
local function c2(text) return CLR:Colorize("a0a0a0", text) end
local function c3(text) return CLR:Colorize("40ff40", text) end
local function c4(text) return CLR:Colorize("4040ff", text) end

-- show hidden addon channel messages
function mod:CHAT_MSG_ADDON(arg1, arg2, arg3, arg4)
    for k,v in pairs(Prat.HookedFrames) do
        if self.db.profile.show[k] then
            v:AddMessage("["..c1(arg1).."]["..c2(arg2).."]["..c3(arg3).."]["..c4(arg4).."]")
        end
    end
end

  return
end ) -- Prat:AddModuleToLoad