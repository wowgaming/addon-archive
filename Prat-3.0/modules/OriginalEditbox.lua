if Prat.BN_CHAT then return end -- Removed in 3.3.5 
----------------------------------------------------------------------------------
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
Name: PratEditbox
Revision: $Revision: 80463 $
Author(s): Curney (asml8ed@gmail.com)
           Krtek (krtek4@gmail.com)
Inspired by: idChat2_Editbox by Industrial
Website: http://files.wowace.com/Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#Editbox
Issues and feature requests: http://code.google.com/p/prat/issues/list
SVN: http://svn.wowace.com/wowace/trunk/Prat/
Description: Module for Prat that adds editbox options.
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("OriginalEditbox")

if PRAT_MODULE == nil then 
    return 
end

local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
    ["OriginalEditbox"] = true,
    ["Editbox options."] = true,
    ["Set Alpha"] = true,
    ["Set the alpha of the editbox."] = true,
    ["Set Position"] = true,
    ["Set the position of the editbox."] = true,
    ["Hide Border"] = true,
    ["Hide the border around the edit box."] = true,
    ["Set Width (NB: only enabled if the editbox is undocked)"] = true,
    ["Set the width of the editbox."] = true,
    ["Lock Position"] = true,
    ["Lock editbox position if undocked."] = true,
    ["Enable Arrowkeys"] = true,
    ["Enable using arrowkeys in editbox without the alt key."] = true,
    ["Autohide"] = true,
    ["Hide the edit box after you have pressed enter."] = true,
    ["Clickable"] = true,
    ["Click the edit box to open it up for editing. Only available if Autohide is disabled."] = true,
	["Top"] = true,
	["Bottom"] = true,
	["Undocked"] = true,
	['Set the frame strata of the editbox.'] = true,
	['Set Strata'] = true,
	['DIALOG'] = true,
	['HIGH'] = true,
	['MEDIUM'] = true,
	['LOW'] = true,
	['BACKGROUND'] = true,
	['Texture'] = true,
	['Set the texture of the chat edit box'] = true,
	['Bar colour'] = true,
	['Set the edit box background colour'] = true,
	['Border width'] = true,
	["Set the width of the edit box's border"] = true,
	['Border colour'] = true,
	['Set the edit box border colour'] = true,
	['Padding'] = true,
	["Set the amount of padding inside the edit box"] = true,
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	Autohide = true,
	BACKGROUND = true,
	["Bar colour"] = true,
	["Border colour"] = true,
	["Border width"] = true,
	Bottom = true,
	Clickable = true,
	["Click the edit box to open it up for editing. Only available if Autohide is disabled."] = true,
	DIALOG = true,
	["Editbox options."] = true,
	["Enable Arrowkeys"] = true,
	["Enable using arrowkeys in editbox without the alt key."] = true,
	["Hide Border"] = true,
	["Hide the border around the edit box."] = true,
	["Hide the edit box after you have pressed enter."] = true,
	HIGH = true,
	["Lock editbox position if undocked."] = true,
	["Lock Position"] = true,
	LOW = true,
	MEDIUM = true,
	OriginalEditbox = true,
	Padding = true,
	["Set Alpha"] = true,
	["Set Position"] = true,
	["Set Strata"] = true,
	["Set the alpha of the editbox."] = true,
	["Set the amount of padding inside the edit box"] = true,
	["Set the edit box background colour"] = true,
	["Set the edit box border colour"] = true,
	["Set the frame strata of the editbox."] = true,
	["Set the position of the editbox."] = true,
	["Set the texture of the chat edit box"] = true,
	["Set the width of the editbox."] = true,
	["Set the width of the edit box's border"] = true,
	["Set Width (NB: only enabled if the editbox is undocked)"] = true,
	Texture = true,
	Top = true,
	Undocked = true,
}

)
L:AddLocale("frFR",  
{
	-- Autohide = "",
	-- BACKGROUND = "",
	-- ["Bar colour"] = "",
	-- ["Border colour"] = "",
	-- ["Border width"] = "",
	-- Bottom = "",
	-- Clickable = "",
	-- ["Click the edit box to open it up for editing. Only available if Autohide is disabled."] = "",
	-- DIALOG = "",
	-- ["Editbox options."] = "",
	-- ["Enable Arrowkeys"] = "",
	-- ["Enable using arrowkeys in editbox without the alt key."] = "",
	["Hide Border"] = "Cacher la bordure",
	["Hide the border around the edit box."] = "Cacher la bordure autour de l'invite de discussion.",
	["Hide the edit box after you have pressed enter."] = "Cacher l'invite de discussion après avoir fait Entrée.",
	HIGH = "HAUT",
	-- ["Lock editbox position if undocked."] = "",
	["Lock Position"] = "Verrouiller la position",
	LOW = "BAS",
	MEDIUM = "MILIEU",
	-- OriginalEditbox = "",
	-- Padding = "",
	["Set Alpha"] = "Définir la transparance",
	["Set Position"] = "Définir la position",
	["Set Strata"] = "Définir la couche",
	["Set the alpha of the editbox."] = "Définit la transparence de la boite d'édition",
	["Set the amount of padding inside the edit box"] = "Définir la quantité d'espacement à l'intérieur de la boite d'édition",
	["Set the edit box background colour"] = "Définir la couleur de fond de la boite d'édition",
	["Set the edit box border colour"] = "Définir la couleur de la bordure de la boite d'édition",
	-- ["Set the frame strata of the editbox."] = "",
	["Set the position of the editbox."] = "Définir la position de l'invite de discussion.",
	["Set the texture of the chat edit box"] = "Définir la texture de l'invite de discussion",
	["Set the width of the editbox."] = "Définir la largeur de l'invite de discussion.",
	["Set the width of the edit box's border"] = "Définir la largeur de la bordure de l'invite de discussion",
	-- ["Set Width (NB: only enabled if the editbox is undocked)"] = "",
	Texture = true,
	Top = "Haut",
	-- Undocked = "",
}

)
L:AddLocale("deDE", 
{
	Autohide = "Automatisch verbergen",
	BACKGROUND = true,
	["Bar colour"] = "Leistenfarbe",
	["Border colour"] = "Randfarbe",
	["Border width"] = "Randbreite",
	Bottom = "Unten",
	Clickable = "Anklickbar",
	["Click the edit box to open it up for editing. Only available if Autohide is disabled."] = "Das Eingabefeld anklicken, um es für die Eingabe zu Öffnen. Nur verfügbar, wenn \"Autohide\" (automatisch verbergen) deaktiviert ist.",
	DIALOG = true,
	["Editbox options."] = "Eingabefeld-Optionen",
	["Enable Arrowkeys"] = "Pfeiltasten aktivieren",
	["Enable using arrowkeys in editbox without the alt key."] = "Die Benutzung der Pfeiltasten im Eingabefeld ohne die Alt-Taste aktivieren.",
	["Hide Border"] = "Rand verbergen",
	["Hide the border around the edit box."] = "Rand um das Eingabefeld verbergen.",
	["Hide the edit box after you have pressed enter."] = "Das Eingabefeld nach dem Drücken von \"Eingabe\" verbergen.",
	HIGH = true,
	["Lock editbox position if undocked."] = "Position des Eingabefelds festsetzen, falls es freigesetzt sein sollte.",
	["Lock Position"] = "Position festsetzen",
	LOW = true,
	MEDIUM = true,
	OriginalEditbox = true,
	Padding = "Einlage",
	["Set Alpha"] = "Transparenz einstellen",
	["Set Position"] = "Position einstellen",
	["Set Strata"] = "Ebenen einstellen",
	["Set the alpha of the editbox."] = "Die Transparenz des Eingabefelds einstellen.",
	["Set the amount of padding inside the edit box"] = "Die Füllmenge innerhalb des Eingabefelds einstellen.",
	["Set the edit box background colour"] = "Die Hintergrundfarbe des Eingabefelds einstellen.",
	["Set the edit box border colour"] = "Die Randfarbe des Eingabefelds einstellen.",
	["Set the frame strata of the editbox."] = "Die Rahmenebene des Eingabefelds einstellen.",
	["Set the position of the editbox."] = "Die Position des Eingabefelds einstellen.",
	["Set the texture of the chat edit box"] = "Die Textur des Chat-Eingabefelds einstellen.",
	["Set the width of the editbox."] = "Die Breite des Eingabefelds einstellen.",
	["Set the width of the edit box's border"] = "Die Randbreite des Eingabefelds einstellen.",
	["Set Width (NB: only enabled if the editbox is undocked)"] = "Breite einstellen (NB: Nur aktiv, wenn das Eingabefeld freigesetzt ist)",
	Texture = "Textur",
	Top = "Oben",
	Undocked = "Abgekoppelt",
}

)
L:AddLocale("koKR",  
{
	Autohide = "자동숨김",
	BACKGROUND = "배경",
	["Bar colour"] = "바 색상",
	["Border colour"] = "테두리 색상",
	["Border width"] = "테두리 폭",
	Bottom = "최하단",
	-- Clickable = "",
	-- ["Click the edit box to open it up for editing. Only available if Autohide is disabled."] = "",
	DIALOG = "대화",
	["Editbox options."] = "입력창 설정",
	["Enable Arrowkeys"] = "방향키 활성화",
	["Enable using arrowkeys in editbox without the alt key."] = "입력창에서 alt키 없이 방향키 사용이 가능합니다.",
	["Hide Border"] = "테두리 숨기기",
	["Hide the border around the edit box."] = "입력창의 테두리를 숨깁니다.",
	-- ["Hide the edit box after you have pressed enter."] = "",
	HIGH = "높음",
	["Lock editbox position if undocked."] = "대화 입력창 위치 잠금",
	["Lock Position"] = "위치 잠금",
	LOW = "낮음",
	MEDIUM = "중간",
	-- OriginalEditbox = "",
	-- Padding = "",
	["Set Alpha"] = "투명도 설정",
	["Set Position"] = "위치 설정",
	-- ["Set Strata"] = "",
	["Set the alpha of the editbox."] = "입력창의 투명도를 설정합니다.",
	-- ["Set the amount of padding inside the edit box"] = "",
	["Set the edit box background colour"] = "입력창의 배경색을 설정합니다.",
	["Set the edit box border colour"] = "입력창의 테두리 색을 설정합니다.",
	["Set the frame strata of the editbox."] = "입력창의 프레임 레벨을 설정합니다.",
	["Set the position of the editbox."] = "입력창의 위치를 설정합니다.",
	["Set the texture of the chat edit box"] = "대화 입력창의 텍스쳐 설정",
	["Set the width of the editbox."] = "입력창의 폭 설정",
	["Set the width of the edit box's border"] = "대화 입력창의 테두리 폭 설정",
	["Set Width (NB: only enabled if the editbox is undocked)"] = "폭 설정(주의: 입력창이 고정되있지 않아야 가능합니다.)",
	Texture = "무늬",
	Top = "위",
	Undocked = "고정안함",
}

)
L:AddLocale("esMX",  
{
	-- Autohide = "",
	-- BACKGROUND = "",
	-- ["Bar colour"] = "",
	-- ["Border colour"] = "",
	-- ["Border width"] = "",
	-- Bottom = "",
	-- Clickable = "",
	-- ["Click the edit box to open it up for editing. Only available if Autohide is disabled."] = "",
	-- DIALOG = "",
	-- ["Editbox options."] = "",
	-- ["Enable Arrowkeys"] = "",
	-- ["Enable using arrowkeys in editbox without the alt key."] = "",
	-- ["Hide Border"] = "",
	-- ["Hide the border around the edit box."] = "",
	-- ["Hide the edit box after you have pressed enter."] = "",
	-- HIGH = "",
	-- ["Lock editbox position if undocked."] = "",
	-- ["Lock Position"] = "",
	-- LOW = "",
	-- MEDIUM = "",
	-- OriginalEditbox = "",
	-- Padding = "",
	-- ["Set Alpha"] = "",
	-- ["Set Position"] = "",
	-- ["Set Strata"] = "",
	-- ["Set the alpha of the editbox."] = "",
	-- ["Set the amount of padding inside the edit box"] = "",
	-- ["Set the edit box background colour"] = "",
	-- ["Set the edit box border colour"] = "",
	-- ["Set the frame strata of the editbox."] = "",
	-- ["Set the position of the editbox."] = "",
	-- ["Set the texture of the chat edit box"] = "",
	-- ["Set the width of the editbox."] = "",
	-- ["Set the width of the edit box's border"] = "",
	-- ["Set Width (NB: only enabled if the editbox is undocked)"] = "",
	-- Texture = "",
	-- Top = "",
	-- Undocked = "",
}

)
L:AddLocale("ruRU",  
{
	Autohide = "Авто-сокрытие",
	BACKGROUND = "ФОН", -- Needs review
	["Bar colour"] = "Цвет панели",
	["Border colour"] = "Цвет границ",
	["Border width"] = "Ширина границ",
	Bottom = "Внизу",
	Clickable = "Реагировать на щелчки мыши", -- Needs review
	["Click the edit box to open it up for editing. Only available if Autohide is disabled."] = "Нажмите на поле ввода, чтобы открыть его для редактирования. Доступно только если авто-сокрытие отключено.",
	DIALOG = "ДИАЛОГ", -- Needs review
	["Editbox options."] = "Настройки поле ввода.",
	["Enable Arrowkeys"] = "Включить стрелки",
	["Enable using arrowkeys in editbox without the alt key."] = "Включить использование стрелок напровления в поле ввода без клавиши alt.",
	["Hide Border"] = "Скрыть границы",
	["Hide the border around the edit box."] = "Скрыть границы в окружности поле ввода.",
	["Hide the edit box after you have pressed enter."] = "Скрыть поле ввода после того как вы нажали enter.",
	HIGH = "ВЫСОКИЙ", -- Needs review
	["Lock editbox position if undocked."] = "Закрепить позицию поле ввода если разблокировано.",
	["Lock Position"] = "Закрепить пазицию",
	LOW = "НИЗКИЙ", -- Needs review
	MEDIUM = "СРЕДНИЙ", -- Needs review
	-- OriginalEditbox = "",
	Padding = "Выравнивание",
	["Set Alpha"] = "Установить прозрачность",
	["Set Position"] = "Установить позицию",
	["Set Strata"] = "Установить слой",
	["Set the alpha of the editbox."] = "Установка прозрачности поле ввода.",
	["Set the amount of padding inside the edit box"] = "Установка значения отступа в поле ввода",
	["Set the edit box background colour"] = "Установка цвета фона поля ввода",
	["Set the edit box border colour"] = "Установка цвета границ поля ввода",
	["Set the frame strata of the editbox."] = "Установить рамку слоёв окна редактирования",
	["Set the position of the editbox."] = "Задать позицию окна редактирования",
	["Set the texture of the chat edit box"] = "Задать текстуру в окне редактирования для чата",
	["Set the width of the editbox."] = "Задать ширину окна редактирования",
	["Set the width of the edit box's border"] = "Задать ширину границы окна редактирования",
	["Set Width (NB: only enabled if the editbox is undocked)"] = "Уст. ширину (Пометка: включено только если поле ввода разблокировано)", -- Needs review
	Texture = "Текстура",
	Top = "Верх",
	Undocked = "Отстыкован",
}

)
L:AddLocale("zhCN",  
{
	-- Autohide = "",
	-- BACKGROUND = "",
	-- ["Bar colour"] = "",
	-- ["Border colour"] = "",
	-- ["Border width"] = "",
	-- Bottom = "",
	-- Clickable = "",
	-- ["Click the edit box to open it up for editing. Only available if Autohide is disabled."] = "",
	-- DIALOG = "",
	-- ["Editbox options."] = "",
	-- ["Enable Arrowkeys"] = "",
	-- ["Enable using arrowkeys in editbox without the alt key."] = "",
	-- ["Hide Border"] = "",
	-- ["Hide the border around the edit box."] = "",
	-- ["Hide the edit box after you have pressed enter."] = "",
	-- HIGH = "",
	-- ["Lock editbox position if undocked."] = "",
	-- ["Lock Position"] = "",
	-- LOW = "",
	-- MEDIUM = "",
	-- OriginalEditbox = "",
	-- Padding = "",
	-- ["Set Alpha"] = "",
	-- ["Set Position"] = "",
	-- ["Set Strata"] = "",
	-- ["Set the alpha of the editbox."] = "",
	-- ["Set the amount of padding inside the edit box"] = "",
	-- ["Set the edit box background colour"] = "",
	-- ["Set the edit box border colour"] = "",
	-- ["Set the frame strata of the editbox."] = "",
	-- ["Set the position of the editbox."] = "",
	-- ["Set the texture of the chat edit box"] = "",
	-- ["Set the width of the editbox."] = "",
	-- ["Set the width of the edit box's border"] = "",
	-- ["Set Width (NB: only enabled if the editbox is undocked)"] = "",
	-- Texture = "",
	-- Top = "",
	-- Undocked = "",
}

)
L:AddLocale("esES",  
{
	-- Autohide = "",
	-- BACKGROUND = "",
	-- ["Bar colour"] = "",
	-- ["Border colour"] = "",
	-- ["Border width"] = "",
	-- Bottom = "",
	-- Clickable = "",
	-- ["Click the edit box to open it up for editing. Only available if Autohide is disabled."] = "",
	-- DIALOG = "",
	-- ["Editbox options."] = "",
	-- ["Enable Arrowkeys"] = "",
	-- ["Enable using arrowkeys in editbox without the alt key."] = "",
	["Hide Border"] = "Ocultar Borde",
	["Hide the border around the edit box."] = "Ocultar el borde alrededor de la caja de edición.",
	-- ["Hide the edit box after you have pressed enter."] = "",
	-- HIGH = "",
	-- ["Lock editbox position if undocked."] = "",
	-- ["Lock Position"] = "",
	-- LOW = "",
	-- MEDIUM = "",
	-- OriginalEditbox = "",
	-- Padding = "",
	-- ["Set Alpha"] = "",
	-- ["Set Position"] = "",
	-- ["Set Strata"] = "",
	-- ["Set the alpha of the editbox."] = "",
	-- ["Set the amount of padding inside the edit box"] = "",
	-- ["Set the edit box background colour"] = "",
	-- ["Set the edit box border colour"] = "",
	-- ["Set the frame strata of the editbox."] = "",
	-- ["Set the position of the editbox."] = "",
	-- ["Set the texture of the chat edit box"] = "",
	-- ["Set the width of the editbox."] = "",
	-- ["Set the width of the edit box's border"] = "",
	-- ["Set Width (NB: only enabled if the editbox is undocked)"] = "",
	-- Texture = "",
	-- Top = "",
	-- Undocked = "",
}

)
L:AddLocale("zhTW",  
{
	-- Autohide = "",
	-- BACKGROUND = "",
	-- ["Bar colour"] = "",
	-- ["Border colour"] = "",
	-- ["Border width"] = "",
	-- Bottom = "",
	-- Clickable = "",
	-- ["Click the edit box to open it up for editing. Only available if Autohide is disabled."] = "",
	-- DIALOG = "",
	-- ["Editbox options."] = "",
	-- ["Enable Arrowkeys"] = "",
	-- ["Enable using arrowkeys in editbox without the alt key."] = "",
	-- ["Hide Border"] = "",
	-- ["Hide the border around the edit box."] = "",
	-- ["Hide the edit box after you have pressed enter."] = "",
	-- HIGH = "",
	-- ["Lock editbox position if undocked."] = "",
	-- ["Lock Position"] = "",
	-- LOW = "",
	-- MEDIUM = "",
	-- OriginalEditbox = "",
	-- Padding = "",
	-- ["Set Alpha"] = "",
	-- ["Set Position"] = "",
	-- ["Set Strata"] = "",
	["Set the alpha of the editbox."] = "設定輸入框透明度",
	-- ["Set the amount of padding inside the edit box"] = "",
	["Set the edit box background colour"] = "設定輸入框背景色彩",
	["Set the edit box border colour"] = "設定輸入框邊緣色彩",
	["Set the frame strata of the editbox."] = "設定輸入框的顯示層級",
	["Set the position of the editbox."] = "設定輸入框位置",
	["Set the texture of the chat edit box"] = "設定輸入框材質",
	["Set the width of the editbox."] = "設定輸入框寬度",
	["Set the width of the edit box's border"] = "設定輸入框邊緣寬度",
	-- ["Set Width (NB: only enabled if the editbox is undocked)"] = "",
	Texture = "材質",
	-- Top = "",
	-- Undocked = "",
}

)
--@end-non-debug@

local module = Prat:NewModule(PRAT_MODULE, "AceHook-3.0")

Prat:SetModuleDefaults(module.name, {
	profile = {
        on = true,
        alpha = 1,
        position = "TOP",
        hideborder = false,
        width = 400,
        undocked = {point = "CENTER", relativeTo="UIParent", relativePoint = "CENTER", xoff = 0, yoff = 0},
        locked = false,
        arrowkeys = true,
        autohide = true,
        clickable = false,
		strata	= nil,
		texture = nil,
		texturebg = nil,
		backdropcolour	= { 0, 0, 0, 1 },
		bordercolour	= { 0, 0, 0, 1 },
		borderwidth	= 0,
		padding		= 4,
	}
} )


module.defaultRegions = nil
module.using = false
module.parent = nil

Prat:SetModuleOptions(module, {
        name = L["OriginalEditbox"],
        desc = L["Editbox options."],
        type = "group",
        args = {
            position = {
                name = L["Set Position"],
                desc = L["Set the position of the editbox."],
                type = "select",
                order = 110,
                values = {["TOP"] = L["Top"], ["BOTTOM"] = L["Bottom"], ["UNDOCKED"] = L["Undocked"]},
            },
            width = {
                name = L["Set Width (NB: only enabled if the editbox is undocked)"],
                desc = L["Set the width of the editbox."],
                type = "range",
                order = 120,
                min = 267,
                max = 800,
                step = 1,
                disabled = function(info) if info.handler.db.profile.position == "UNDOCKED" then return false else return true end end,
            },
            locked = {
                name = L["Lock Position"],
                desc = L["Lock editbox position if undocked."],
                type = "toggle",
                order = 130,                
				disabled = function(info) if info.handler.db.profile.position == "UNDOCKED" then return false else return true end end,
            },
            alpha = {
                name = L["Set Alpha"],
                desc = L["Set the alpha of the editbox."],
                type = "range",
                order = 140,
                min = 0,
                max = 1,
                step = 0.05,
            },
            strata = {
                name = L['Set Strata'],
                desc = L['Set the frame strata of the editbox.'],
                type = 'select',
                order = 150,
                values = {
                    ['DIALOG'] = L['DIALOG'],
                    ['HIGH'] = L['HIGH'],
                    ['MEDIUM'] = L['MEDIUM'],
                    ['LOW'] = L['LOW'],
                    ['BACKGROUND'] = L['BACKGROUND'],
                },
            },
            hideborder = {
                name = L["Hide Border"],
                desc = L["Hide the border around the edit box."],
                type = "toggle",
                order = 160,
            },
            arrowkeys = {
                name = L["Enable Arrowkeys"],
                desc = L["Enable using arrowkeys in editbox without the alt key."],
                type = "toggle",
                order = 170,
            },
            autohide = {
                name = L["Autohide"],
                desc = L["Hide the edit box after you have pressed enter."],
                type = "toggle",
                order = 180,
            },
            clickable = {
                name = L["Clickable"],
                desc = L["Click the edit box to open it up for editing. Only available if Autohide is disabled."],
                type = "toggle",
                order = 190,
                disabled = function (info) return info.handler.db.profile.autohide end,
            },
            texture = {
                name = L['Texture'],
				order = 200,
                desc = L['Set the texture of the chat edit box'],
                type = 'select',
				dialogControl = 'LSM30_Background',
                values = AceGUIWidgetLSMlists.background,
                get = function(info) return info.handler.db.profile.texture end,
                set = function(info, texture)
                        info.handler.db.profile.texture = texture
                        info.handler:SetBackdrop(info.handler.db.profile.texture)
                    end,
            },
            bordertexture = {
                name = 'Border Texture',
				order = 200,
                desc = 'Border Texture',
                type = 'select',
				dialogControl = 'LSM30_Border',
                values = AceGUIWidgetLSMlists.border,
                get = function(info) return info.handler.db.profile.bordertexture end,
                set = function(info, bordertexture)
                        info.handler.db.profile.bordertexture = bordertexture
                        info.handler:SetBackdrop()
                    end,
            },
	    backdropcolour = {
			name = L['Bar colour'],
			order = 205,
			desc = L['Set the edit box background colour'],
			type = 'color',
			set = function(info, r, g, b, a)
				info.handler.db.profile.backdropcolour = { r, g, b, a }
				return info.handler:SetBackdropColourTo(unpack(info.handler.db.profile.backdropcolour))
			end,
			get = function(info)
				return unpack(info.handler.db.profile.backdropcolour)
			end,
			hasAlpha = true,
	    },
	    borderwidth = {
			name = L['Border width'],
			order = 210,
			type = 'range',
			min = 1,
			max = 30,
			step = 1,
			desc = L["Set the width of the edit box's border"],
			set = function(info, width)
				info.handler.db.profile.borderwidth = width
				info.handler:SetBackdrop(info.handler.db.profile.texture)
				info.handler:SetBackdropColourTo(unpack(info.handler.db.profile.backdropcolour))
			end,
			get = function(info) return info.handler.db.profile.borderwidth or 0 end,
			--disabled = function(info) return info.handler.db.profile.hideborder end,
	    },
	    bordercolour = {
			name = L['Border colour'],
			order = 220,
			desc = L['Set the edit box border colour'],
			type = 'color',
			set = function(info, r, g, b, a)
				info.handler.db.profile.bordercolour = { r, g, b, a }
				return info.handler:SetBackdropBorderColorTo(unpack(info.handler.db.profile.bordercolour))
			end,
			get = function(info)
				return unpack(info.handler.db.profile.bordercolour)
			end,
			hasAlpha = true,
		--	disabled = function(info) return info.handler.db.profile.hideborder end,
	    },
	    padding = {
			name = L['Padding'],
			order = 230,
			type = 'range',
			min = 1,
			max = 30,
			step = 1,
			desc = L["Set the amount of padding inside the edit box"],
			set = function(info, padding)
				info.handler.db.profile.padding = padding
				info.handler:SetBackdrop(info.handler.db.profile.texture)
				info.handler:SetBackdropColourTo(unpack(info.handler.db.profile.backdropcolour))
			end,
			get = function(info) return info.handler.db.profile.padding or 4 end,
		--disabled = function(info) return info.handler.db.profile.hideborder end,
	    },
        }
    }
)

function module:OnValueChanged(info, b)
	local field = info[#info]
	if field == "position" or field == "width" or field == "locked" then
		self:Position(self.db.profile.position)
	elseif field == "arrowkeys" then
		self:ArrowKeys(b)
	elseif field == "hideborder" then
		self:HideBorder(b)
	elseif field == "strata" then
		self:SetStrata(b)
	elseif field == "autohide" then
		self:AutoHide(b)
	elseif field == "clickable" then
		self:Clickable(b)
	elseif field == "alpha" then
		self:Alpha(b)
	end
end


--[[------------------------------------------------
    Module Event Functions
------------------------------------------------]]--

local SharedMedia = Prat.Media
-- things to do when the module is enabled
function module:OnModuleEnable()
    self.parent = ChatFrameEditBox:GetParent()
    self:Position(self.db.profile.position)
    self:Alpha(self.db.profile.alpha)
    self:ArrowKeys(self.db.profile.arrowkeys)
    

    self:HideBorder(self.db.profile.hideborder)
    self:AutoHide(self.db.profile.autohide)
    self:Clickable(self.db.profile.clickable)

    if self.db.profile.strata then
		self:SetStrata(strata)
    end

    if self.db.profile.texture then
		self:SetBackdrop(self.db.profile.texture)
		self:SetBackdropColourTo(unpack(self.db.profile.backdropcolour))
    end
end

-- things to do when the module is disabled
function module:OnModuleDisable()
    self:Position("BOTTOM")
    self:Alpha(1)
    self:HideBorder(false)
    self:ArrowKeys(false)
    self:AutoHide(true)
    self:Clickable(false)
end

--[[------------------------------------------------
	Core Functions
------------------------------------------------]]--

function module:Alpha(value)
    local eb = VisorEditbox or ChatFrameEditBox
    for i,v in ipairs({eb:GetRegions()}) do
        if i==6 or i==7 or i==8 then
            v:SetAlpha(value)
        end
    end
end

function module:ArrowKeys(enabled)
    local eb = VisorEditBox or ChatFrameEditBox
    if enabled then eb:SetAltArrowKeyMode(false) else eb:SetAltArrowKeyMode(true) end
end

function module:Position(option)
    local eb = VisorEditBox or ChatFrameEditBox
    eb:ClearAllPoints()
    if option == "TOP" then
        eb:SetPoint("BOTTOMLEFT",  "ChatFrame1", "TOPLEFT",  -5, 0)
        eb:SetPoint("BOTTOMRIGHT", "ChatFrame1", "TOPRIGHT", 5, 0)
    end
    if option == "BOTTOM" then
        eb:SetPoint("TOPLEFT",  "ChatFrame1", "BOTTOMLEFT",  -5, 0)
        eb:SetPoint("TOPRIGHT", "ChatFrame1", "BOTTOMRIGHT", 5, 0)
    end
    if option == "UNDOCKED" then
        eb:SetMovable(true)
        eb:EnableMouse(true)
        eb:RegisterForDrag("LeftButton")
        eb:SetScript("OnDragStart", function(eb) if not self.db.profile.locked then eb:StartMoving() end end)
        eb:SetScript("OnDragStop", function(eb)
            eb:StopMovingOrSizing()
            local point, relativeTo, relativePoint, xoff, yoff = eb:GetPoint()
            self.db.profile.undocked.point = point
            -- self.db.profile.undocked.relativeTo = relativeTo:GetName() -- this causes game crash, keep commented out
            self.db.profile.undocked.relativePoint = relativePoint
            self.db.profile.undocked.xoff = xoff
            self.db.profile.undocked.yoff = yoff
        end)
        eb:SetPoint(self.db.profile.undocked.point, self.db.profile.undocked.relativeTo, self.db.profile.undocked.relativePoint, self.db.profile.undocked.xoff, self.db.profile.undocked.yoff)
        eb:SetWidth(self.db.profile.width)
    end
end

function module:HideBorder(hide)
    local eb = VisorEditbox or ChatFrameEditBox
    local regions = { eb:GetRegions() }
    local editBoxLeft = regions[6]
    local editBoxRight = regions[7]
    local editBoxMiddle = regions[8]

    if (not self.defaultRegions) then
        self.defaultRegions = {
            left = {
                width = editBoxLeft:GetWidth(),
                height = editBoxLeft:GetHeight(),
                texCoord = { editBoxLeft:GetTexCoord() },
                texture = editBoxLeft:GetTexture(),
            },
            middle = {
                width = editBoxMiddle:GetWidth(),
                height = editBoxMiddle:GetHeight(),
                texCoord = { editBoxMiddle:GetTexCoord() },
                texture = editBoxMiddle:GetTexture(),
            },
            right = {
                width = editBoxRight:GetWidth(),
                height = editBoxRight:GetHeight(),
                texCoord = { editBoxRight:GetTexCoord() },
                texture = editBoxRight:GetTexture(),
            },
        }
    end

    if (hide) then

        editBoxLeft:SetWidth(16)
        editBoxLeft:SetHeight(32)
        editBoxLeft:SetTexCoord(0, 0.0625, 0, 1.0)
        editBoxLeft:SetTexture("Interface\\AddOns\\"..Prat.FolderLocation.."\\textures\\prat-editnotexture")

        editBoxMiddle:SetWidth(1)
        editBoxMiddle:SetHeight(32)
        editBoxMiddle:SetTexCoord(0.0625, 0.9375, 0, 1.0)
        editBoxMiddle:SetTexture("Interface\\AddOns\\"..Prat.FolderLocation.."\\textures\\prat-editnotexture")

        editBoxRight:SetWidth(16)
        editBoxRight:SetHeight(32)
        editBoxRight:SetTexCoord(0.9375, 1.0, 0, 1.0)
        editBoxRight:SetTexture("Interface\\AddOns\\"..Prat.FolderLocation.."\\textures\\prat-editnotexture")

    else

        editBoxLeft:SetWidth(self.defaultRegions.left.width)
        editBoxLeft:SetHeight(self.defaultRegions.left.height)
        editBoxLeft:SetTexCoord(self.defaultRegions.left.texCoord[1], self.defaultRegions.left.texCoord[2],
                                self.defaultRegions.left.texCoord[3], self.defaultRegions.left.texCoord[4],
                                self.defaultRegions.left.texCoord[5], self.defaultRegions.left.texCoord[6],
                                self.defaultRegions.left.texCoord[7], self.defaultRegions.left.texCoord[8])
        editBoxLeft:SetTexture(self.defaultRegions.left.texture)

        editBoxMiddle:SetWidth(self.defaultRegions.middle.width)
        editBoxMiddle:SetHeight(self.defaultRegions.middle.height)
        editBoxMiddle:SetTexCoord(self.defaultRegions.middle.texCoord[1], self.defaultRegions.middle.texCoord[2],
                                  self.defaultRegions.middle.texCoord[3], self.defaultRegions.middle.texCoord[4],
                                  self.defaultRegions.middle.texCoord[5], self.defaultRegions.middle.texCoord[6],
                                  self.defaultRegions.middle.texCoord[7], self.defaultRegions.middle.texCoord[8])
        editBoxMiddle:SetTexture(self.defaultRegions.middle.texture)

        editBoxRight:SetWidth(self.defaultRegions.right.width)
        editBoxRight:SetHeight(self.defaultRegions.right.height)
        editBoxRight:SetTexCoord(self.defaultRegions.right.texCoord[1], self.defaultRegions.right.texCoord[2],
                                 self.defaultRegions.right.texCoord[3], self.defaultRegions.right.texCoord[4],
                                 self.defaultRegions.right.texCoord[5], self.defaultRegions.right.texCoord[6],
                                 self.defaultRegions.right.texCoord[7], self.defaultRegions.right.texCoord[8])
        editBoxRight:SetTexture(self.defaultRegions.right.texture)

    end
end

function module:AutoHide(enabled)
    if (enabled) then

        if (self:IsHooked("ChatFrame_OpenChat")) then
            self:Unhook("ChatFrame_OpenChat")
        end
        if (self:IsHooked(ChatFrameEditBox, "Hide")) then
            self:Unhook(ChatFrameEditBox, "Hide")
        end
        if (self:IsHooked(ChatFrameEditBox, "IsVisible")) then
            self:Unhook(ChatFrameEditBox, "IsVisible")
        end
        if (self:IsHooked(ChatFrameEditBox, "IsShown")) then
            self:Unhook(ChatFrameEditBox, "IsShown")
        end
        if (self.parent and self:IsHooked(self.parent, "Show")) then
            self:Unhook(self.parent, "Show")
        end
        self:ResetToAutoHide()

    else

		self:RawHook("ChatFrame_OpenChat", "OpenChat", true)
		self:RawHook(ChatFrameEditBox, "Hide", true)
		self:RawHook(ChatFrameEditBox, "IsVisible", "IsUsing", true)
		self:RawHook(ChatFrameEditBox, "IsShown", "IsUsing", true)
		if self.parent then
		    self:SecureHook(self.parent, "Show", "parentShow")
		end 

        self:OpenChat("", nil)
        self:Hide()
    end
end

function module:OpenChat(this, text, chatFrame)
    self.using = true

    ChatFrameEditBox:EnableKeyboard(true)

    ChatEdit_UpdateHeader(this)

    if self.hooks['ChatFrame_OpenChat'] then
		self.hooks["ChatFrame_OpenChat"](this, text, chatFrame)
    end
end

function module:Hide(this)
    self.using = false

    ChatFrameEditBoxHeader:SetTextColor(0, 0, 0, 0)
    ChatFrameEditBox:SetTextColor(0, 0, 0, 0)
    ChatFrameEditBox:EnableKeyboard(false)
end

function module:parentShow(this)
    self:OpenChat("", nil)
    self:Hide()
end

function module:IsUsing(this)
    return self.using
end

function module:ResetToAutoHide()

    self.using = false

    ChatFrameEditBox:EnableKeyboard(true)
    ChatFrameEditBox:Hide()

end

function module:Clickable(enabled)

    if (enabled) then

        self:HookScript(ChatFrameEditBox, "OnMouseDown")

    elseif (self:IsHooked(ChatFrameEditBox, "OnMouseDown")) then

        self:Unhook(ChatFrameEditBox, "OnMouseDown")

    end

end

function module:OnMouseDown(this, ...)
    if (not self.using) then
        self:OpenChat("", nil)
    else
        self.hooks[ChatFrameEditBox]["OnMouseDown"](this, ...)
    end

end

function module:SetStrata(strata)
	strata = strata or ChatFrameEditBox:GetFrameStrata()
	ChatFrameEditBox:SetFrameStrata(strata)
end

function module:GetBackdropTexture()
    return SharedMedia:Fetch('background', self.db.profile.texture)
end


function module:SetBackdrop(texture)
	local texture = SharedMedia:Fetch('background', self.db.profile.texture)
	local border = SharedMedia:Fetch('border', self.db.profile.bordertexture)
    local borderwidth	= self.db.profile.borderwidth or 0
    local padding	= self.db.profile.padding or 4

    local backdrop = {
	tileSize	= 16,
	tile		= true,
        bgFile		= texture,
        insets = {
            top     = padding,
            bottom  = padding,
            left    = padding,
            right   = padding,
            }
        }

    if not self.db.profile.hideborder then
		backdrop.edgeFile	= border --SharedMedia:Fetch('border', 'Blizzard Dialog')
		backdrop.edgeSize	= borderwidth
    end

    ChatFrameEditBox:SetBackdrop(backdrop)

    if not self.db.profile.hideborder then
		self:SetBackdropBorderColorTo(unpack(self.db.profile.bordercolour))
	end

    self:SetBackdropColourTo(unpack(self.db.profile.backdropcolour))
end



function module:SetBackdropColourTo(r, g, b, a)
	ChatFrameEditBox:SetBackdropColor(r, g, b, a)
end

function module:SetBackdropBorderColorTo(r, g, b, a)
	ChatFrameEditBox:SetBackdropBorderColor(r, g, b, a)
end


  return
end ) -- Prat:AddModuleToLoad