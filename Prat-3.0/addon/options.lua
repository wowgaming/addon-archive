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
Name: Prat 3.0 (options.lua)
Revision: $Revision: 80963 $
Author(s): Sylvaanar (sylvanaar@mindspring.com)
Inspired By: Prat 2.0, Prat, and idChat2 by Industrial
Website: http://files.wowace.com/Prat/
Documentation: http://www.wowace.com/wiki/Prat
Forum: http://www.wowace.com/forums/index.php?topic=6243.0
SVN: http://svn.wowace.com/wowace/trunk/Prat/
Description: The implementation of addon-wide options
]]


--[[ BEGIN STANDARD HEADER ]]--

-- Imports
local _G = _G
local LibStub = LibStub
local tonumber = tonumber
local tostring = tostring
local pairs = pairs
local type = type
local Prat = Prat
local setmetatable = setmetatable
local tinsert = tinsert

-- Isolate the environment
setfenv(1, Prat)

--[[ END STANDARD HEADER ]]--

local L = Prat.Localizations


--[===[@debug@
L:AddLocale("enUS", { 
    prat = "Prat",
	["display_name"] = "Display Settings",
    ["display_desc"] = "Chat Frame Control and Look",
	["formatting_name"] = "Chat Formatting",
    ["formatting_desc"] = "Change the way the lines look and feel",
	["extras_name"] = "Extra Stuff",
    ["extras_desc"] = "Msc. Modules",
	["modulecontrol_name"] = "Module Control",
    ["modulecontrol_desc"] = "Control the loading and enabling of Prat's modules.",
    ["reload_required"] = "This option change may not take full effect until you %s your UI.",
    load_no = "Don't Load", 
    load_disabled = "Disabled", 
    load_enabled = "Enabled",
    load_desc = "Control the load behavior for this module.",
    load_disabledonrestart = "Disabled (reload)",
    load_enabledonrestart = "Enabled (reload)",    
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	display_desc = "Chat Frame Control and Look",
	display_name = "Display Settings",
	extras_desc = "Msc. Modules",
	extras_name = "Extra Stuff",
	formatting_desc = "Change the way the lines look and feel",
	formatting_name = "Chat Formatting",
	load_desc = "Control the load behavior for this module.",
	load_disabled = "Disabled",
	load_disabledonrestart = "Disabled (reload)",
	load_enabled = "Enabled",
	load_enabledonrestart = "Enabled (reload)",
	load_no = "Don't Load",
	modulecontrol_desc = "Control the loading and enabling of Prat's modules.",
	modulecontrol_name = "Module Control",
	prat = "Prat",
	reload_required = "This option change may not take full effect until you %s your UI.",
}

)
L:AddLocale("frFR",  
{
	display_desc = "Contrôle et apparence du cadre de chat",
	display_name = "Afficher les options",
	extras_desc = "Modules divers",
	extras_name = "Suppléments",
	formatting_desc = "Changer l'apparence des lignes",
	formatting_name = "Formatage du chat",
	load_desc = "Contrôle le comportement de chargement de ce module.",
	load_disabled = "Désactivé",
	-- load_disabledonrestart = "",
	load_enabled = "Activé",
	-- load_enabledonrestart = "",
	load_no = "Ne pas charger",
	modulecontrol_desc = "Contrôler le chargement et l'activation des modules de Prat",
	modulecontrol_name = "Contrôle des modules",
	prat = "Prat",
	reload_required = "Le nouveau paramètre de cette option ne prendra pas effet intégralement que vous n'aurez pas %s votre interface.",
}

)
L:AddLocale("deDE", 
{
	display_desc = "Steuerung und Darstellung des Chat-Rahmens",
	display_name = "Anzeigeeinstellungen",
	extras_desc = "Verschiedene Module",
	extras_name = "Sonstiges",
	formatting_desc = "Darstellung der Zeilen im Chat ändern (Look&Feel)",
	formatting_name = "Chat formatieren",
	load_desc = "Ladeverhalten für dieses Modul steuern.",
	load_disabled = "Deaktiviert",
	load_disabledonrestart = "Deaktiviert (neu laden)",
	load_enabled = "Aktiviert",
	load_enabledonrestart = "Aktiviert (neu laden)",
	load_no = "Nicht laden",
	modulecontrol_desc = "Das Laden und Aktivieren von Prat-Modulen steuern.",
	modulecontrol_name = "Modulsteuerung",
	prat = "Prat",
	reload_required = "Diese Änderung wird erst nach dem Neustart vollständig wirksam.",
}

)
L:AddLocale("koKR",  
{
	display_desc = "대화창 기능 및 외형 설정",
	display_name = "표시 설정",
	extras_desc = "기타 모듈",
	extras_name = "기타 기능",
	formatting_desc = "대화창 글의 외형 변경합니다.",
	formatting_name = "대화글 형식",
	load_desc = "이 모듈의 로드 방식을 설정",
	load_disabled = "사용 안함",
	load_disabledonrestart = "비활성 (reload)",
	load_enabled = "사용",
	load_enabledonrestart = "활성 (reload)",
	load_no = "로드 안함",
	modulecontrol_desc = "Prat 모듈의 로드와 활성화를 제어합니다.",
	modulecontrol_name = "모듈 제어",
	prat = "Prat",
	reload_required = "이 설정은 애드온을 %s 해야 변경된 사항이 적용됩니다.",
}

)
L:AddLocale("esMX",  
{
	-- display_desc = "",
	-- display_name = "",
	-- extras_desc = "",
	-- extras_name = "",
	-- formatting_desc = "",
	-- formatting_name = "",
	-- load_desc = "",
	-- load_disabled = "",
	-- load_disabledonrestart = "",
	-- load_enabled = "",
	-- load_enabledonrestart = "",
	-- load_no = "",
	-- modulecontrol_desc = "",
	-- modulecontrol_name = "",
	-- prat = "",
	-- reload_required = "",
}

)
L:AddLocale("ruRU",  
{
	display_desc = "Настройка отображения чата",
	display_name = "Настройка отображения",
	extras_desc = "Различные дополнительные модули",
	extras_name = "Другие модули",
	formatting_desc = "Изменение отображения строк чата",
	formatting_name = "Форматирование чата",
	load_desc = "Настройка поведения этого модуля.",
	load_disabled = "Отключено",
	load_disabledonrestart = "Отключен (перезагрузка)",
	load_enabled = "Включено",
	load_enabledonrestart = "Включен (перезагрузка)",
	load_no = "Не загружать",
	modulecontrol_desc = "Настройка загрузки модулей Prat'а",
	modulecontrol_name = "Настройка модулей",
	prat = "Prat",
	reload_required = "Эта опция вступит в силу только после %s вашего интерфейса.",
}

)
L:AddLocale("zhCN",  
{
	display_desc = "聊天框管理与插件",
	display_name = "显示设置",
	extras_desc = "杂项模块",
	extras_name = "扩展选项",
	formatting_desc = "改变行的感观",
	formatting_name = "聊天格式",
	load_desc = "控制这个模块的载入状态",
	load_disabled = "禁用",
	-- load_disabledonrestart = "",
	load_enabled = "启用",
	-- load_enabledonrestart = "",
	load_no = "不加载",
	modulecontrol_desc = "控制Prat模块的读取和启用",
	modulecontrol_name = "模块控制",
	prat = "Prat",
	reload_required = "在%s您的插件以前,此选项不会完全生效",
}

)
L:AddLocale("esES",  
{
	display_desc = "Control y Aspecto del Marco del Chat",
	display_name = "Mostrar Ajustes",
	extras_desc = "Módulos Extra",
	extras_name = "Material adicional",
	formatting_desc = "Cambiar la forma del aspecto de las líneas",
	formatting_name = "Formato del Chat",
	load_desc = "Controla el comportamiento de carga de este módulo.",
	load_disabled = "Desactivado",
	-- load_disabledonrestart = "",
	load_enabled = "Activado",
	-- load_enabledonrestart = "",
	load_no = "No cargar",
	modulecontrol_desc = "Control de las cargas y activaciones de los módulos de Prat",
	modulecontrol_name = "Control de módulos",
	prat = "Prat",
	reload_required = "Esta opción requiere que reinicies la IU para que entre en funcionamiento",
}

)
L:AddLocale("zhTW",  
{
	display_desc = "控制及檢視聊天視窗",
	display_name = "顯示設定",
	extras_desc = "Msc. 模組",
	extras_name = "附加擴充",
	formatting_desc = "改變行的外觀以及感覺",
	formatting_name = "聊天格式化",
	load_desc = "控制此模組載入狀態。",
	load_disabled = "已停用",
	-- load_disabledonrestart = "",
	load_enabled = "已啟用",
	-- load_enabledonrestart = "",
	load_no = "不會載入",
	modulecontrol_desc = "控制載入以及啟用的 Prat 模組。",
	modulecontrol_name = "模組控制",
	prat = "Prat",
	reload_required = "變更此選項後仍無法發揮完整功能，除非你%s你的插件。",
}

)
--@end-non-debug@


local AceConfig = LibStub("AceConfig-3.0")
--local AceConfigDialog = LibStub("AceConfigDialog-3.0")
--local AceConfigCmd = LibStub("AceConfigCmd-3.0")

local moduleControlArgs = {}

Options = {
	type = "group",
	childGroups = "tab",
	get = "GetValue",
	set = "SetValue",
	args = {
		display = {
			type = "group",name = L["display_name"],
			desc = L["display_desc"],
			hidden = function(info) end,
			get = "GetValue",
			set = "SetValue",			
			args = {},
			order = 1,
		},
		formatting = {
			type = "group",name = L["formatting_name"],
			desc = L["formatting_desc"],
			hidden = function(info) end,
			get = "GetValue",
			set = "SetValue",			
			args = {},
			order = 2,
		},
		extras = {
			type = "group",name = L["extras_name"],
			desc = L["extras_desc"],
			hidden = function(info) end,
			get = "GetValue",
			set = "SetValue",			
			args = {},
			order = 3,
		},
		modulecontrol = {
			type = "group",
			name = L["modulecontrol_name"],
			desc = L["modulecontrol_desc"],
			get = "GetValue",
			set = "SetValue",			
			args = moduleControlArgs,
			order = 4,
		}
	}
}

--[[ WitchHunt: [Ammo] ]]--
tinsert(EnableTasks, function(self) 

	local acreg = LibStub("AceConfigRegistry-3.0")
	acreg:RegisterOptionsTable(L.prat, Options)
	acreg:RegisterOptionsTable(L.prat..": "..Options.args.display.name, Options.args.display)
	acreg:RegisterOptionsTable(L.prat..": "..Options.args.formatting.name, Options.args.formatting)
	acreg:RegisterOptionsTable(L.prat..": "..Options.args.extras.name, Options.args.extras)
	acreg:RegisterOptionsTable(L.prat..": "..Options.args.modulecontrol.name, Options.args.modulecontrol)
	acreg:RegisterOptionsTable("Prat: "..Options.args.profiles.name, Options.args.profiles)

	local acdia = LibStub("AceConfigDialog-3.0")
	acdia:AddToBlizOptions(L.prat, L.prat)
	acdia:AddToBlizOptions(L.prat..": "..Options.args.display.name, Options.args.display.name, L.prat)
	acdia:AddToBlizOptions(L.prat..": "..Options.args.formatting.name, Options.args.formatting.name, L.prat)
	acdia:AddToBlizOptions(L.prat..": "..Options.args.extras.name, Options.args.extras.name, L.prat)
	acdia:AddToBlizOptions(L.prat..": "..Options.args.modulecontrol.name, Options.args.modulecontrol.name, L.prat)
	acdia:AddToBlizOptions(L.prat..": "..Options.args.profiles.name, Options.args.profiles.name, L.prat)

	self:RegisterChatCommand(L.prat, function() ToggleOptionsWindow() end)
end)


do
	local function getModuleFromShortName(shortname)
		for k, v in Addon:IterateModules() do
			if v.moduleName == shortname then
				return v
			end
		end
	end

	local lastReloadMessage = 0
	local function PrintReloadMessage()
		local tm = _G.GetTime()
		if tm - lastReloadMessage > 60 then
			Prat.Print(L.reload_required:format(GetReloadUILink()))
			lastReloadMessage = tm
		end
	end

	local function setValue(info, b)
		local old = Prat.db.profile.modules[info[#info]]
		Prat.db.profile.modules[info[#info]] = b

		if old == 1 or b ==1 then 
			PrintReloadMessage()
		end

		local m = getModuleFromShortName(info[#info])
		if not m then 
--            Prat.db.profile.modules[info[#info]] = b
            return 
        end
		
		if b == 2 or b == 1 then 
		   m.db.profile.on = false
		   m:Disable()
		elseif b == 3 then
		   m.db.profile.on = true
		   m:Enable()
		end
	end

	local function getValue(info)
 		local v,m
		v = Prat.db.profile.modules[info[#info]]
			
--		if v ~= 1 then
--			m = getModuleFromShortName(info[#info])
--			if m then 
--                -- Allow us to set enabled/disabled while the moduel is "dont load"
--                if v > 3 then 
--                    v = v - 2
----                    m.db.profile.on = v
--                else
--    				v = m.db.profile.on and 3 or 2
--                end
--			end
--		end

		return v
	end


	do
		local moduleControlOption = {
			name = function(info) return info[#info] end,
			desc = L.load_desc,
			type = "select",
			style = "radio",
			values = function(info) local v =  Prat.db.profile.modules[info[#info]] if v == 1 or v > 3 then 
						return { [1] = "|cffA0A0A0"..L.load_no.."|r",  [4] = "|cffffff80"..L.load_disabledonrestart.."|r", [5] = "|cff80ffff"..L.load_enabledonrestart.."|r" }
						else
							return { "|cffA0A0A0"..L.load_no.."|r", "|cffff8080"..L.load_disabled.."|r", "|cff80ff80"..L.load_enabled.."|r" } 
						end end,
			get = getValue,
			set = setValue
		}
	
		function CreateModuleControlOption(name)
			moduleControlArgs[name] = moduleControlOption
		end
	end
end

FrameList = {}
HookedFrameList = {}


local function updateFrameNames()
	for k,v in pairs(HookedFrames) do
		if (v.isDocked == 1) or v:IsShown() then
			HookedFrameList[k] = (v.name)
		else
			HookedFrameList[k] = nil
		end
	end
	for k,v in pairs(Frames) do
		if (v.isDocked == 1) or v:IsShown() then
			FrameList[k] = (v.name)
		else
			FrameList[k] = nil
		end
	end
	LibStub("AceConfigRegistry-3.0"):NotifyChange(L.prat)
end

tinsert(EnableTasks, function(self) 
    self:SecureHook("FCF_SetWindowName", updateFrameNames)

	_G.FCF_SetWindowName(_G.ChatFrame1, (_G.GetChatWindowInfo(1)), 1)
end)
       
function ToggleOptionsWindow()
    local acd = LibStub("AceConfigDialog-3.0")
    if acd.OpenFrames[L.prat] then
        acd:Close(L.prat)
    else
        acd:Open(L.prat)
    end
end

	
