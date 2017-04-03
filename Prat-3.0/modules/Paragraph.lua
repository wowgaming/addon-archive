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
Name: PratParagraph
Revision: $Revision: 80705 $
Author(s): Curney (asml8ed@gmail.com)
Thanks to: Wubin for helping me understand variables better
Website: http://www.wowace.com/files/index.php?path=Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#Paragraph
SVN: http://svn.wowace.com/wowace/trunk/Prat/
Description: Module for Prat that gives options for paragraphs in chat windows (defaults=left-aligned text, linespacing=0).
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

-- Get Utility Libraries
local PRAT_MODULE = Prat:RequestModuleName("Paragraph")

if PRAT_MODULE == nil then 
    return 
end

local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
    ["Paragraph"] = true,
    ["Chat window paragraph options."] = true,
    ["justification_name"] = "Set Alignment",
    ["justification_desc"] = "Set horizontal alignment for each chat window",
    ["Line Spacing"] = true,
    ["Set the line spacing for all chat windows."] = true,
    ["adjustlinks_name"] = "Fix placement of player/item links",
    ["adjustlinks_desc"] = "Adjust links to restore clickability on centered or right-aligned text.",    
	["Center"] = true,
	["Right"] = true,
	["Left"] = true,
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	adjustlinks_desc = "Adjust links to restore clickability on centered or right-aligned text.",
	adjustlinks_name = "Fix placement of player/item links",
	Center = true,
	["Chat window paragraph options."] = true,
	justification_desc = "Set horizontal alignment for each chat window",
	justification_name = "Set Alignment",
	Left = true,
	["Line Spacing"] = true,
	Paragraph = true,
	Right = true,
	["Set the line spacing for all chat windows."] = true,
}

)
L:AddLocale("frFR",  
{
	-- adjustlinks_desc = "",
	-- adjustlinks_name = "",
	-- Center = "",
	-- ["Chat window paragraph options."] = "",
	-- justification_desc = "",
	-- justification_name = "",
	-- Left = "",
	-- ["Line Spacing"] = "",
	-- Paragraph = "",
	Right = "Droite",
	-- ["Set the line spacing for all chat windows."] = "",
}

)
L:AddLocale("deDE", 
{
	adjustlinks_desc = "Links anpassen, um die Fähigkeit des Anklickens wiederherzustellen, wenn Text zentriert oder rechtsbündig ist.",
	adjustlinks_name = "Platzierung von Spieler-/Gegenstands-Links reparieren.",
	Center = "Mitte",
	["Chat window paragraph options."] = "Paragraphoptionen in Chat-Fenstern.",
	justification_desc = "Horizontale Ausrichtung für jedes Chat-Fenster einstellen.",
	justification_name = "Ausrichtung einstellen",
	Left = "Links",
	["Line Spacing"] = "Zeilenabstand",
	Paragraph = true,
	Right = "Rechts",
	["Set the line spacing for all chat windows."] = "Den Zeilenabstand für alls Chat-Fenster einstellen.",
}

)
L:AddLocale("koKR",  
{
	adjustlinks_desc = "중앙/우측 정렬인 경우, 링크위치를 조절합니다.",
	adjustlinks_name = "플레이어/아이템 링크 위치 수정",
	Center = "중앙",
	["Chat window paragraph options."] = "대화창의 정렬옵션.",
	justification_desc = "각각의 대화창의 정렬을 설정합니다.",
	justification_name = "정렬 설정",
	Left = "왼쪽",
	["Line Spacing"] = "라인 간격",
	Paragraph = "정렬",
	Right = "오른쪽",
	["Set the line spacing for all chat windows."] = "모든 대화창의 라인 간격을 설정합니다.",
}

)
L:AddLocale("esMX",  
{
	-- adjustlinks_desc = "",
	-- adjustlinks_name = "",
	-- Center = "",
	-- ["Chat window paragraph options."] = "",
	-- justification_desc = "",
	-- justification_name = "",
	-- Left = "",
	-- ["Line Spacing"] = "",
	-- Paragraph = "",
	-- Right = "",
	-- ["Set the line spacing for all chat windows."] = "",
}

)
L:AddLocale("ruRU",  
{
	adjustlinks_desc = "Регулировка текста кликабельных сссылок способностей по центру или в право/лево.",
	adjustlinks_name = "Размещение ссылок игроков/предметов",
	Center = "Центр",
	["Chat window paragraph options."] = "Настройки абзаца окна чата.",
	justification_desc = "Горизонтальное выравнивание всех окон чата.",
	justification_name = "Выравнивание",
	Left = "Влево",
	["Line Spacing"] = "Промежуток строк",
	Paragraph = true,
	Right = "Вправо",
	["Set the line spacing for all chat windows."] = "Установка промежутка строк во всех окнах чата.",
}

)
L:AddLocale("zhCN",  
{
	adjustlinks_desc = "调整链接以恢复在中心或右对齐文本上的可点击性",
	adjustlinks_name = "修复玩家/物品位置链接",
	Center = "中心",
	["Chat window paragraph options."] = "聊天窗口段落选项",
	justification_desc = "为每个聊天窗口设置水平对齐",
	justification_name = "设置对齐",
	Left = "左",
	["Line Spacing"] = "行距",
	Paragraph = "段落",
	Right = "右",
	["Set the line spacing for all chat windows."] = "为所有聊天窗口设置行间距",
}

)
L:AddLocale("esES",  
{
	adjustlinks_desc = "Ajustar los vínculos para restaurar la capacidad de hacer click en texto centrado o alineado a la derecha.",
	adjustlinks_name = "Corregir la colocación de enlaces de jugador/objeto",
	Center = "Centro",
	["Chat window paragraph options."] = "Opciones de párrafo en ventanas de chat.",
	justification_desc = "Establecer alineación horizontal para cada ventana de chat",
	justification_name = "Establecer Alineación",
	Left = "Izquierda",
	["Line Spacing"] = "Espaciado de Linea",
	Paragraph = "Párrafo",
	Right = "Derecha",
	["Set the line spacing for all chat windows."] = "Establece el espaciado de línea para todas las ventanas de chat.",
}

)
L:AddLocale("zhTW",  
{
	-- adjustlinks_desc = "",
	adjustlinks_name = "修正玩家或物品連結",
	Center = "中央",
	["Chat window paragraph options."] = "聊天視窗段落設定",
	justification_desc = "設定所有聊天視窗水平對齊",
	justification_name = "設定對齊",
	Left = "左方",
	["Line Spacing"] = "行間距",
	Paragraph = "段落",
	-- Right = "",
	["Set the line spacing for all chat windows."] = "設定聊天視窗段落間隔",
}

)
--@end-non-debug@




----[[
--	Chinese Local : CWDG Translation Team 昏睡墨鱼 (Thomas Mo)
--	CWDG site: http://Cwowaddon.com
--	$Rev: 80705 $
--]]
--

--

--

--

--

-- 

--

-- create prat module
local module = Prat:NewModule(PRAT_MODULE)

Prat:SetModuleDefaults(module, {
	profile = {
	    on = false,
	    justification = { ["*"] = "LEFT" },
	}
} )

do
	local justifyoption = {
			name = function(info) return Prat.FrameList[info[#info]] or "" end,
			desc = L["justification_name"],
			type="select",
			get = function(info) return info.handler.db.profile.justification[info[#info]] end,
			set = function(info, v) info.handler.db.profile.justification[info[#info]] = v info.handler:OnValueChanged(info, v) end,
			values = { ["RIGHT"] = L["Right"], ["CENTER"] = L["Center"], ["LEFT"] =  L["Left"]},
			hidden = function(info) return Prat.FrameList[info[#info]] == nil end,
		}
	
	Prat:SetModuleOptions(module, {
	        name = L["Paragraph"],
	        desc = L["Chat window paragraph options."],
	        type = "group",
	        args = {
	            justification = {
	                name = L["justification_name"],
	                desc = L["justification_desc"],
	                type = "group",
					inline = true,
					args = {
						ChatFrame1 = justifyoption,
						ChatFrame2 = justifyoption,
						ChatFrame3 = justifyoption,
						ChatFrame4 = justifyoption,
						ChatFrame5 = justifyoption,
						ChatFrame6 = justifyoption,
						ChatFrame7 = justifyoption,
					}
				},

				info = {
					name = "Note: Playerlinks, itemlinks, and any other link type will not work when justification is set to anything other than 'Left'",
					type = "description",
					order = 110
				}
	        }
	    }
	)
end

--[[------------------------------------------------
    Module Event Functions
------------------------------------------------]]--

function module:OnModuleEnable()
    self:ConfigureAllChatFrames(true)
end

function module:OnModuleDisable()
    self:ConfigureAllChatFrames(false)
end

function module:OnValueChanged()
	self:ConfigureAllChatFrames(true)
end

--[[------------------------------------------------
	Core Functions
------------------------------------------------]]--
function module:ConfigureAllChatFrames(enable)
	local prof = self.db.profile
	for k,v in pairs(Prat.Frames) do
        v:SetJustifyH(enable and prof.justification[k] or "LEFT")
	end
end

  return
end ) -- Prat:AddModuleToLoad