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
Name: PratChatLog
Revision: $Revision: 80298 $
Author(s): Sylvanaar (sylvanaar@mindspring.com)
Website: http://www.wowace.com/files/index.php?path=Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#ChatLog
Subversion: http://svn.wowace.com/wowace/trunk/Prat/
Discussions: http://groups.google.com/group/wow-prat
Issues and feature requests: http://code.google.com/p/prat/issues/list
Description: Module for Prat that controls toggling the chat and combat logs on and off (default=off).
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("ChatLog")

if PRAT_MODULE == nil then 
    return 
end

local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
    ["ChatLog"] = true,
    ["A module to automaticaly enable chat and combat logging."] = true,
    ["Toggle Chat Log"] = true,
    ["Toggle chat log on and off."] = true,
    ["Toggle Combat Log"] = true,
    ["Toggle combat log on and off."] = true,
    ["Combat Log: Enabled"] = true,
    ["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = true,
    ["Combat Log: Disabled"] = true,
    ["Chat Log: Enabled"] = true,
    ["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = true,
    ["Chat Log: Disabled"] = true,
    ["quiet_name"] = "Suppress Feedback Messages",
    ["quiet_desc"] = "Dont display any messages when this mod is enabled, or when it changes the log settings.",
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	["A module to automaticaly enable chat and combat logging."] = true,
	ChatLog = true,
	["Chat Log: Disabled"] = true,
	["Chat Log: Enabled"] = true,
	["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = true,
	["Combat Log: Disabled"] = true,
	["Combat Log: Enabled"] = true,
	["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = true,
	quiet_desc = "Dont display any messages when this mod is enabled, or when it changes the log settings.",
	quiet_name = "Suppress Feedback Messages",
	["Toggle Chat Log"] = true,
	["Toggle chat log on and off."] = true,
	["Toggle Combat Log"] = true,
	["Toggle combat log on and off."] = true,
}

)
L:AddLocale("frFR",  
{
	["A module to automaticaly enable chat and combat logging."] = "Un module pour activer automatiquement la journalisation du chat et des combats",
	ChatLog = true,
	["Chat Log: Disabled"] = "Journalisation Chat : Désactivé",
	["Chat Log: Enabled"] = "Journalisation Chat : Activé",
	["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "Journalisation du chat enregistré dans <WoW Installation>\\Logs\\WoWChatLog.txt jusqu'à la prochaine déconnexion",
	["Combat Log: Disabled"] = "Journalisation des combats : Désactivé",
	["Combat Log: Enabled"] = "Journalisation des combats : Activé",
	["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "Journalisation des combats enregistré dans <WoW Installation>\\Logs\\WoWChatLog.txt jusqu'à la prochaine déconnexion",
	quiet_desc = "N'afficher aucun messages quand ce mod est activé ou quand il change les paramètres de journalisation",
	quiet_name = "Supprimer les messages de feedback",
	["Toggle Chat Log"] = "Activer la journalisation du chat",
	["Toggle chat log on and off."] = "Activer/Désactiver la journalisation du chat",
	["Toggle Combat Log"] = "Activer la journalisation des combat",
	["Toggle combat log on and off."] = "Activer/Désactiver la journalisation des combats",
}

)
L:AddLocale("deDE", 
{
	["A module to automaticaly enable chat and combat logging."] = "Ein Modul, das automatisch das Speichern des Chat- und Kampflogs aktiviert.",
	ChatLog = true,
	["Chat Log: Disabled"] = "Chat-Log: Inaktiv",
	["Chat Log: Enabled"] = "Chat-Log: Aktiv",
	["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "Speicherung des Chat-Logs in <WoW Installation>\\Logs\\WoWChatLog.txt nur während des Ausloggens.",
	["Combat Log: Disabled"] = "Kampflog: Inaktiv",
	["Combat Log: Enabled"] = "Kampflog: Aktiv",
	["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "Speicherung des Kampflogs in <WoW Installation>\\Logs\\WoWCombatLog.txt nur während des Ausloggens.",
	quiet_desc = "Keinerlei Mitteilungen anzeigen, wenn dieser Modus aktiv ist, oder wenn es die Log-Einstellungen verändert.",
	quiet_name = "Feedback-Mitteilungen unterdrücken",
	["Toggle Chat Log"] = "Chat-Log umschalten",
	["Toggle chat log on and off."] = "Chat-Log ein- und ausschalten.",
	["Toggle Combat Log"] = "Kampflog umschalten",
	["Toggle combat log on and off."] = "Kampflog ein- und ausschalten.",
}

)
L:AddLocale("koKR",  
{
	["A module to automaticaly enable chat and combat logging."] = "대화기록과 전투기록을 자동으로 켜는 모듈",
	ChatLog = "대화기록",
	["Chat Log: Disabled"] = "대화기록: 꺼짐",
	["Chat Log: Enabled"] = "대화기록: 켜짐",
	["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "대화기록은 접속종료 후, <와우폴더>\\Logs\\WoWChatLog.txt 에 저장됩니다.",
	["Combat Log: Disabled"] = "전투기록: 꺼짐",
	["Combat Log: Enabled"] = "전투기록: 켜짐",
	["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "대화기록은 접속종료 후, <와우폴더>\\Logs\\WoWCombatLog.txt 에 저장됩니다.",
	quiet_desc = "이 모드가 켜지거나 설정이 변경될 때, 알림 메시지를 표시하지 않습니다.",
	quiet_name = "알림 메시지 끄기",
	["Toggle Chat Log"] = "대화기록 끄고켜기",
	["Toggle chat log on and off."] = "대화기록을 끄거나 켭니다.",
	["Toggle Combat Log"] = "전투기록 끄고켜기",
	["Toggle combat log on and off."] = "전투기록을 끄거나 켭니다.",
}

)
L:AddLocale("esMX",  
{
	-- ["A module to automaticaly enable chat and combat logging."] = "",
	-- ChatLog = "",
	-- ["Chat Log: Disabled"] = "",
	-- ["Chat Log: Enabled"] = "",
	-- ["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "",
	-- ["Combat Log: Disabled"] = "",
	-- ["Combat Log: Enabled"] = "",
	-- ["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "",
	-- quiet_desc = "",
	-- quiet_name = "",
	-- ["Toggle Chat Log"] = "",
	-- ["Toggle chat log on and off."] = "",
	-- ["Toggle Combat Log"] = "",
	-- ["Toggle combat log on and off."] = "",
}

)
L:AddLocale("ruRU",  
{
	["A module to automaticaly enable chat and combat logging."] = "Модуль автоматического включения записи чата и журнала боя.",
	ChatLog = true,
	["Chat Log: Disabled"] = "Запись чатa: выключена",
	["Chat Log: Enabled"] = "Запись чатa: включена",
	["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "Запись чата, записано в <директория инсталляции WoW>\\Logs\\WoWChatLog.txt  (только после выхода из игры).",
	["Combat Log: Disabled"] = "Запись журнала боя: выключена",
	["Combat Log: Enabled"] = "Запись журнала боя: включена",
	["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "Журнал боя записывается в <директория инсталляции WoW>\\Logs\\WoWCombatLog.txt только до выхода из игры.",
	quiet_desc = "Не отображать никаких сообщений, если данный модуль включен, или при изменении им настроек записи.",
	quiet_name = "Подавлять инфо сообщения",
	["Toggle Chat Log"] = "Запись чата",
	["Toggle chat log on and off."] = "Вкл/Выкл запись чата.",
	["Toggle Combat Log"] = "Запись журнала боя",
	["Toggle combat log on and off."] = "Вкл/Выкл запись журнала боя.",
}

)
L:AddLocale("zhCN",  
{
	["A module to automaticaly enable chat and combat logging."] = "自动启用聊天和战斗记录的模块",
	ChatLog = "聊天记录",
	["Chat Log: Disabled"] = "聊天记录：禁用",
	["Chat Log: Enabled"] = "聊天记录：启用",
	["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "退出游戏时保存聊天记录在<魔兽世界安装目录>\\Logs\\WoWChatLog.txt",
	["Combat Log: Disabled"] = "战斗记录：禁用",
	["Combat Log: Enabled"] = "战斗记录：启用",
	["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "退出游戏后保存战斗记录在<魔兽世界安装目录>\\Logs\\WoWCombatLog.txt",
	quiet_desc = "模块启用或改变记录设置时不显示任何信息",
	quiet_name = "禁止反馈信息",
	["Toggle Chat Log"] = "聊天记录",
	["Toggle chat log on and off."] = "切换聊天记录开关",
	["Toggle Combat Log"] = "战斗记录",
	["Toggle combat log on and off."] = "切换战斗记录开关",
}

)
L:AddLocale("esES",  
{
	["A module to automaticaly enable chat and combat logging."] = "Un módulo que automáticamente activa el chat y el registro de combate.",
	ChatLog = "Registro del Chat",
	["Chat Log: Disabled"] = "Registro del Chat: Desactivado",
	["Chat Log: Enabled"] = "Registro del Chat: Activado",
	["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "Registro del chat guardado en <Instalación WoW>\\Logs\\WoWChatLog.txt sólo al cierre de la sesión.",
	["Combat Log: Disabled"] = "Registro de Combate: Desactivado",
	["Combat Log: Enabled"] = "Registro de Combate: Activado",
	["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "Registro del combate guardado en <Instalación WoW>\\Logs\\WoWCombatLog.txt sólo al cierre de la sesión.",
	quiet_desc = "No mostrar algún mensaje cuando este mod esté activdo, o cuando cambie la configuración del registro.",
	quiet_name = "Suprimir Mensaje de Respuesta",
	["Toggle Chat Log"] = "Alternar Registro del Chat",
	["Toggle chat log on and off."] = "Alterna la activación del registro del chat.",
	["Toggle Combat Log"] = "Alternar Registro de Combate",
	["Toggle combat log on and off."] = "Alterna la activación del registro de combate.",
}

)
L:AddLocale("zhTW",  
{
	["A module to automaticaly enable chat and combat logging."] = "模組：自動啟用聊天以及戰鬥紀錄。",
	ChatLog = "聊天記錄",
	["Chat Log: Disabled"] = "聊天記錄：已停用",
	["Chat Log: Enabled"] = "聊天記錄：已啟用",
	["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "聊天紀錄至 <WoW Installation>\\Logs\\WoWChatLog.txt 僅於遊戲登出時。",
	["Combat Log: Disabled"] = "戰鬥記錄：已停用",
	["Combat Log: Enabled"] = "戰鬥記錄：已啟用",
	["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "戰鬥紀錄至 <WoW Installation>\\Logs\\WoWChatLog.txt 僅於遊戲登出時。",
	quiet_desc = "禁止顯示任何訊息當插件啟用時的訊息或者插件改變紀錄設定時。",
	quiet_name = "禁止回饋訊息",
	["Toggle Chat Log"] = "切換聊天記錄",
	["Toggle chat log on and off."] = "切換聊天記錄啟用",
	["Toggle Combat Log"] = "切換戰鬥記錄",
	["Toggle combat log on and off."] = "切換戰鬥記錄啟用",
}

)
--@end-non-debug@


local module = Prat:NewModule(PRAT_MODULE)


Prat:SetModuleDefaults(module.name, {
	profile = {
        on = false,
        chat = false,
        combat = false,
        quiet = true,
	}
} )

Prat:SetModuleOptions(module.name, {
        name = L["ChatLog"],
        desc = L["A module to automaticaly enable chat and combat logging."],
        type = "group",
        args = {
            chat = {
                name = L["Toggle Chat Log"],
                desc = L["Toggle chat log on and off."],
                type = "toggle",
                set = "SetChatLog",
            },
            combat = {
                name = L["Toggle Combat Log"],
                desc = L["Toggle combat log on and off."],
                type = "toggle",
                set = "SetCombatLog",
            },
            quiet = {
                name = L["quiet_name"],
                desc = L["quiet_desc"],
                type = "toggle",
            }
        }
    })


--[[------------------------------------------------
    Module Event Functions
------------------------------------------------]]--

-- things to do when the module is enabled
function module:OnModuleEnable()
    self:SetChatLog(nil, self.db.profile.chat)
    self:SetCombatLog(nil, self.db.profile.combat)
end

--[[------------------------------------------------
    Core Functions
------------------------------------------------]]--

-- enable or disable the chat log
function module:SetChatLog(info, val)
    self.db.profile.chat = val
    if self.db.profile.chat then
        self:Print(L["Chat Log: Enabled"])
        self:Print(L["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."])
        LoggingChat(1)
    else
        LoggingChat(0)
        self:Print(L["Chat Log: Disabled"])
    end
end

-- enable or disable the combat log
function module:SetCombatLog(info, val)
    self.db.profile.combat = val
    if self.db.profile.combat then
        self:Print(L["Combat Log: Enabled"])
        self:Print(L["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."])
        LoggingCombat(1)
    else
        LoggingCombat(0)
        self:Print(L["Combat Log: Disabled"])
    end
end

function module:Print(str)
    if self.db.profile.quiet then return end
    
    Prat:Print(str)
end



  return
end ) -- Prat:AddModuleToLoad