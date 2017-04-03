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
Name: PratFont
Revision: $Revision: 80703 $
Author(s): Curney (asml8ed@gmail.com)
Inspired by: ChatFrameExtender by Satrina
Website: http://www.wowace.com/files/index.php?path=Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#Font
SVN: http://svn.wowace.com/wowace/trunk/Prat/
Description: Module for Prat that allows you to set the font face and size for chat windows (default=blizz default font face at size 12).
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("Font")

if PRAT_MODULE == nil then 
    return 
end

local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
    ["Font"] = true,
    ["Chat window font options."] = true,
    ["Set Separately"] = true,
    ["Toggle setting options separately for each chat window."] = true,
    ["Set Font Face"] = true,
    ["Set the text font face for all chat windows."] = true,
    ["rememberfont_name"] = "Remember Font",
    ["rememberfont_desc"] = "Remember your font choice and restore it at startup.",    
    ["Set Font Size"] = true,
    ["Set text font size for each chat window."] = true,
    ["Set ChatFrame%d Font Size"] = true,
    ["Set text font size."] = true,
    ["Auto Restore Font Size"] = true,
    ["Workaround a Blizzard bug which changes the font size when you open a system menu."] = true,
    ["outlinemode_name"] = "Set Outline Mode",
    ["outlinemode_desc"] = "Sets mode for the outline around the font.",
    ["None"] = true, 
    ["Outline"] = true, 
    ["Thick Outline"] = true,
    ["monochrome_name"] = "Toggle Monochrome",
    ["monochrome_desc"] = "Toggles monochrome coloring of the font.",
    ["shadowcolor_name"] = "Set Shadow Color",
    ["shadowcolor_desc"] = "Set the color of the shadow effect.", 
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	["Auto Restore Font Size"] = true,
	["Chat window font options."] = true,
	Font = true,
	monochrome_desc = "Toggles monochrome coloring of the font.",
	monochrome_name = "Toggle Monochrome",
	None = true,
	Outline = true,
	outlinemode_desc = "Sets mode for the outline around the font.",
	outlinemode_name = "Set Outline Mode",
	rememberfont_desc = "Remember your font choice and restore it at startup.",
	rememberfont_name = "Remember Font",
	["Set ChatFrame%d Font Size"] = true,
	["Set Font Face"] = true,
	["Set Font Size"] = true,
	["Set Separately"] = true,
	["Set text font size."] = true,
	["Set text font size for each chat window."] = true,
	["Set the text font face for all chat windows."] = true,
	shadowcolor_desc = "Set the color of the shadow effect.",
	shadowcolor_name = "Set Shadow Color",
	["Thick Outline"] = true,
	["Toggle setting options separately for each chat window."] = true,
	["Workaround a Blizzard bug which changes the font size when you open a system menu."] = true,
}

)
L:AddLocale("frFR",  
{
	["Auto Restore Font Size"] = "Restauration automatique de la taille du texte",
	["Chat window font options."] = "Options de formattage du texte",
	Font = "Police",
	monochrome_desc = "Activer/Désactiver la monochromie de la police",
	monochrome_name = "Activer/Désactiver la monochromie",
	None = "Rien",
	Outline = "Surlignage",
	-- outlinemode_desc = "",
	-- outlinemode_name = "",
	-- rememberfont_desc = "",
	-- rememberfont_name = "",
	["Set ChatFrame%d Font Size"] = "Définir la taille de la police de la fenêtre de chat %d",
	["Set Font Face"] = "Configurer la police du texte",
	["Set Font Size"] = "Définir la taille de la police",
	["Set Separately"] = "Configurer séparément",
	["Set text font size."] = "Définir la taille du texte.",
	["Set text font size for each chat window."] = "Définir la taille du texte de chaque fenêtre.",
	-- ["Set the text font face for all chat windows."] = "",
	-- shadowcolor_desc = "",
	shadowcolor_name = "Définit la couleur de l'ombre",
	["Thick Outline"] = "Epaisseur du surlignage",
	["Toggle setting options separately for each chat window."] = "Activer/Désactiver les options séparées pour chaque fenêtre.",
	["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "Contourner un bug de Blizzard qui change la taille de la police quand on ouvre un menu système.",
}

)
L:AddLocale("deDE", 
{
	["Auto Restore Font Size"] = "Schriftgröße automatisch wiederherstellen",
	["Chat window font options."] = "Optionen für Schrifttyp in Chat-Fenstern.",
	Font = "Schrifttyp",
	monochrome_desc = "Einfarbige Einfärbung der Schrift umschalten.",
	monochrome_name = "Einfarbigkeit ein- und ausschalten",
	None = "Keiner",
	Outline = "Umrandung",
	outlinemode_desc = "Stellt Modus für die Umrandung des Schrifttyps ein.",
	outlinemode_name = "Umrandungsmodus einstellen",
	rememberfont_desc = "Deine Wahl des Schrifttyps merken und beim Starten wiederherstellen.",
	rememberfont_name = "Schrifttyp merken",
	["Set ChatFrame%d Font Size"] = "Schriftgröße im Chat-Rahmen %d einstellen",
	["Set Font Face"] = "Schrifttyp einstellen",
	["Set Font Size"] = "Schriftgröße einstellen",
	["Set Separately"] = "Einzeln einstellen",
	["Set text font size."] = "Schriftgröße von Text einstellen.",
	["Set text font size for each chat window."] = "Schriftgröße von Text für jedes Chat-Fenster einstellen.",
	["Set the text font face for all chat windows."] = "Schriftart von Text für alle Chat-Fenster einstellen.",
	shadowcolor_desc = "Farbe des Schatteneffekts einstellen.",
	shadowcolor_name = "Schattenfarbe einstellen",
	["Thick Outline"] = "Dicke Umrandung",
	["Toggle setting options separately for each chat window."] = "Optionen einzeln für jedes Chat-Fenster einstellen umschalten.",
	["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "Einen Bug von Blizzard umgehen, welcher die Schriftgröße ändert sobald du ein Systemmenü öffnest.",
}

)
L:AddLocale("koKR",  
{
	["Auto Restore Font Size"] = "폰트크기 자동복귀",
	["Chat window font options."] = "채팅창 폰트 설정",
	Font = "폰트",
	monochrome_desc = "폰트 그림자색을 끄고켭니다.",
	monochrome_name = "그림자 토클",
	None = "없음",
	Outline = "외곽선",
	outlinemode_desc = "폰트의 외곽선을 설정합니다.",
	outlinemode_name = "외곽선 설정",
	rememberfont_desc = "선택한 폰트를 기억하고, 시작할 때 적용합니다.",
	rememberfont_name = "폰트 기억",
	["Set ChatFrame%d Font Size"] = "ChatFrame%1 폰트 크기를 설정합니다.",
	["Set Font Face"] = "폰트 설정",
	["Set Font Size"] = "폰트 크기 설정",
	["Set Separately"] = "개별 설정",
	["Set text font size."] = "폰트 크기 설정",
	["Set text font size for each chat window."] = "각각의 채팅창에 대하여 폰트 크기를 설정합니다.",
	["Set the text font face for all chat windows."] = "모든 채팅창의 폰트를 설정합니다.",
	shadowcolor_desc = "그림자 색깔을 설정합니다.",
	shadowcolor_name = "그림자 색깔 설정",
	["Thick Outline"] = "두꺼운 외곽선",
	["Toggle setting options separately for each chat window."] = "각각의 채팅창에 대한 옵션 설정을 끄고켭니다.",
	["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "시스템 메뉴를 열었을 때 폰트크기가 변경되는 문제를 수정합니다.",
}

)
L:AddLocale("esMX",  
{
	-- ["Auto Restore Font Size"] = "",
	-- ["Chat window font options."] = "",
	-- Font = "",
	-- monochrome_desc = "",
	-- monochrome_name = "",
	-- None = "",
	-- Outline = "",
	-- outlinemode_desc = "",
	-- outlinemode_name = "",
	-- rememberfont_desc = "",
	-- rememberfont_name = "",
	-- ["Set ChatFrame%d Font Size"] = "",
	-- ["Set Font Face"] = "",
	-- ["Set Font Size"] = "",
	-- ["Set Separately"] = "",
	-- ["Set text font size."] = "",
	-- ["Set text font size for each chat window."] = "",
	-- ["Set the text font face for all chat windows."] = "",
	-- shadowcolor_desc = "",
	-- shadowcolor_name = "",
	-- ["Thick Outline"] = "",
	-- ["Toggle setting options separately for each chat window."] = "",
	-- ["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "",
}

)
L:AddLocale("ruRU",  
{
	["Auto Restore Font Size"] = "Авто-востоновление размера",
	["Chat window font options."] = "Настройки шрифта окна чата.",
	Font = true,
	monochrome_desc = "Вкл/Выкл чёрно-белое окрашивание шрифта.",
	monochrome_name = "Чёрно-белое",
	None = "Нет",
	Outline = "Обычная обводка",
	outlinemode_desc = "Выбор типа обводки вокруг символов.",
	outlinemode_name = "Обводка",
	rememberfont_desc = "Запомнить ваш выбранный шрифт и загрузить его при следующей загрузке.",
	rememberfont_name = "Запомнить шрифт",
	["Set ChatFrame%d Font Size"] = "Размер шрифта окна %d",
	["Set Font Face"] = "Заглавный шрифт",
	["Set Font Size"] = "Размер шрифта",
	["Set Separately"] = "Разделение",
	["Set text font size."] = "Размер шрифта.",
	["Set text font size for each chat window."] = "Установка размера шрифта во всех окнах чата.",
	["Set the text font face for all chat windows."] = "Установка главного шрифта для всех окон чата.",
	shadowcolor_desc = "Установка цвета эффекта тени.",
	shadowcolor_name = "Цвет тени",
	["Thick Outline"] = "Жирная обводка",
	["Toggle setting options separately for each chat window."] = "Вкл/Выкл настройки разделения для всех окон чата.",
	["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "Метод обхода близзардской ошибки, изменяющей размер шрифта при открытии системного меню.",
}

)
L:AddLocale("zhCN",  
{
	["Auto Restore Font Size"] = "自动还原字体尺寸",
	["Chat window font options."] = "聊天窗口字体选项",
	Font = "字体",
	monochrome_desc = "单色字体",
	monochrome_name = "单色",
	None = "无",
	Outline = "轮廓",
	outlinemode_desc = "字体轮廓样式设置",
	outlinemode_name = "轮廓样式",
	rememberfont_desc = "记住您的字体选择并在启动时恢复",
	rememberfont_name = "记住字体",
	["Set ChatFrame%d Font Size"] = "聊天框%d字体尺寸",
	["Set Font Face"] = "字体设置",
	["Set Font Size"] = "设置字体大小",
	["Set Separately"] = "个别设置",
	["Set text font size."] = "文本字体尺寸",
	["Set text font size for each chat window."] = "每个聊天窗口的文本字体尺寸",
	["Set the text font face for all chat windows."] = "所有聊天窗口的文本字体",
	shadowcolor_desc = "阴影效果的颜色",
	shadowcolor_name = "阴影色彩",
	["Thick Outline"] = "厚轮廓",
	["Toggle setting options separately for each chat window."] = "每个聊天窗口的个别选项设置",
	["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "当你打开系统菜单时改变暴雪错误提示字体尺寸",
}

)
L:AddLocale("esES",  
{
	["Auto Restore Font Size"] = "Restaurar Tamaño Fuentes Automáticamente",
	["Chat window font options."] = "Opciones de la fuente de la ventana del chat.",
	Font = "Fuente",
	monochrome_desc = "Alterna el color monocromo de la fuente.",
	monochrome_name = "Alternar Monocromo",
	None = "Ninguna",
	Outline = "Contorno",
	outlinemode_desc = "Estable el modo para el contorno alrededor de la fuente.",
	outlinemode_name = "Establecer Modo de Cotorno",
	rememberfont_desc = "Recordar la elección de la fuente y restaurarla al reiniciar.",
	rememberfont_name = "Recordar Fuente",
	["Set ChatFrame%d Font Size"] = "Establecer Tamaño Fuente de Chat %d",
	["Set Font Face"] = "Establecer Tipo de Fuente",
	["Set Font Size"] = "Establecer Tamaño de Fuente",
	["Set Separately"] = "Establecer por separado",
	["Set text font size."] = "Establece el tamaño de la fuente del texto.",
	["Set text font size for each chat window."] = "Establece el tamaño de la fuente del texto de cada ventana de chat.",
	["Set the text font face for all chat windows."] = "Establece el tipo de fuente de texto para todas las ventanas de chat.",
	shadowcolor_desc = "Establece el color del efecto de sombra.",
	shadowcolor_name = "Establecer Color de la Sombra",
	["Thick Outline"] = "Contorno Grueso",
	["Toggle setting options separately for each chat window."] = "Cambiar opciones de configuración por separado para cada ventana de chat.",
	["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "Solución a un error de Blizzard que cambia el tamaño de la fuente cuando se abre un menú de sistema.",
}

)
L:AddLocale("zhTW",  
{
	["Auto Restore Font Size"] = "自動還原字型大小",
	["Chat window font options."] = "聊天視窗字型選項。",
	Font = "字型",
	monochrome_desc = "切換字型的灰階色彩。",
	monochrome_name = "切換灰階",
	None = "無",
	Outline = "輪廓",
	outlinemode_desc = "設定字體是否加粗輪廓",
	outlinemode_name = "設定輪廓模式",
	rememberfont_desc = "記住字型設定",
	rememberfont_name = "記憶字型",
	["Set ChatFrame%d Font Size"] = "設定聊天視窗 %d 之字型大小",
	["Set Font Face"] = "設定字體",
	["Set Font Size"] = "設定字型大小",
	["Set Separately"] = "個別設定",
	["Set text font size."] = "設定文字字型大小",
	["Set text font size for each chat window."] = "設定個別聊天視窗字型大小",
	["Set the text font face for all chat windows."] = "設定所有聊天視窗字體",
	shadowcolor_desc = "設定陰影效果色彩",
	shadowcolor_name = "設定陰影色彩",
	["Thick Outline"] = "粗邊",
	-- ["Toggle setting options separately for each chat window."] = "",
	["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "開啟系統選單時變更Blizzard錯誤訊息的字型大小。",
}

)
--@end-non-debug@

local module = Prat:NewModule(PRAT_MODULE, "AceHook-3.0", "AceEvent-3.0")

Prat:SetModuleDefaults(module, {
	profile = {
	    on = true,
	    fontface = "",
	    rememberfont = false,
	    size = {["*"]=12},
	    autorestore = false, 
	    outlinemode = "",
	    monochrome = false,
	    shadowcolor = {
	        r = 0,
	        g = 0,
	        b = 0,
	        a = 1,
	    },
	}
})

--Prat:SetModuleInit(module, function(self)
--	local _
--	for name,frame in pairs(Prat.Frames) do
--		_, defaults.profile.size[name], _ = frame:GetFont()
--	end
--
--	self.db:RegisterDefaults(defaults)
--end )



---- Fix the defaults that are being used for the chatframe text font size.
--for i=1,NUM_CHAT_WINDOWS do
--    local cf = getglobal("ChatFrame"..i)
--    local _, s, _ = cf:GetFont()    
--    module.defaultDB.size[i]  = s
--end
--
---- build the options menu using prat templates
--module.toggleOptions = { 
--    rememberfont = 120,
--    sep125_sep = 125,
--    sep145_sep = 145,
--    outlinemode = {
--        type = "text",
--        order = 150,
--        get = function() return module.db.profile.outlinemode end,
--        set = function(v) module.db.profile.outlinemode = v; module:ConfigureAllChatFrames() end,
--        validate = {[""] = L["None"], ["OUTLINE"] = L["Outline"], ["THICKOUTLINE"] = L["Thick Outline"]},
--    },
--    monochrome = {
--        type = "toggle",
--        order = 160,
--        get = function() return module.db.profile.monochrome end,
--        set = function(v) module.db.profile.monochrome = v; module:ConfigureAllChatFrames() end,
--    },
--    shadowcolor = { 
--        type = "color", 
--        order = 170, 
--        get = "GetShadowClr", 
--        set = "SetShadowClr",
--    },
--}

--local fontslist = {}
--local media 
--local cf, i, v, k
--
--function module:BuildFontList()
--    for i,v in ipairs(fontslist) do
--        fontslist[i] = nil
--    end
--    
--    for k,v in pairs(media:List(media.MediaType.FONT)) do
--        table.insert(fontslist, v)
--    end
--end
--
--function module:SharedMedia_Registered(mediatype, name)
--	self:Debug("SharedMedia_Registered", mediatype, name)
--    if mediatype == media.MediaType.FONT then
--        self:BuildFontList()
--    end
--end

local frameOption = 
{
--  name = string.format(L["Set ChatFrame%d Font Size"], num),
	name = function(info) return Prat.FrameList[info[#info]] or "" end,
    desc = L["Set text font size."], 
    type = "range",
	get = "GetSubValue",
	set = "SetSubValue",
    min = 4,
    max = 40,
    step = 1,
	hidden = function(info) return Prat.FrameList[info[#info]] == nil end,
}


Prat:SetModuleOptions(module, {
        name = L["Font"],
        desc = L["Chat window font options."],
        type = "group",
        args = {
            fontface = {
                name = L["Set Font Face"],
                desc = L["Set the text font face for all chat windows."],
                type = "select",
				dialogControl = 'LSM30_Font',
				values = AceGUIWidgetLSMlists.font,
                order = 110,
            },
            size = {
                name = L["Set Font Size"],
                desc = L["Set text font size for each chat window."],
                type = "group",
				inline = true,
                order = 130,
                args = {
                    ChatFrame1 = frameOption,
                    ChatFrame2 = frameOption,
                    ChatFrame3 = frameOption,
                    ChatFrame4 = frameOption,
                    ChatFrame5 = frameOption,
                    ChatFrame6 = frameOption,
                    ChatFrame7 = frameOption,
                }
            },
		
--			sep130 = { name="", order = 130, type = "header"},

		    outlinemode = {
				name = L["outlinemode_name"],
				desc = L["outlinemode_desc"],
		        type = "select",
		        order = 150,
		        values = {[""] = L["None"], ["OUTLINE"] = L["Outline"], ["THICKOUTLINE"] = L["Thick Outline"]},
		    },
		    monochrome = {
		        type = "toggle",
				name = L["monochrome_name"],
				desc = L["monochrome_desc"],
		        order = 160,
		    },
		    shadowcolor = { 
				name = L["shadowcolor_name"],
				desc = L["shadowcolor_desc"],
		        type = "color", 
		        order = 170, 
		        get = "GetColorValue", 
		        set = "SetColorValue",
		    },
			rememberfont = {
		        type = "toggle",
		        order = 120,
				name = L["rememberfont_name"],
				desc = L["rememberfont_desc"],
			},
--            autorestore = { 
--                name = L["Auto Restore Font Size"],
--                desc = L["Workaround a Blizzard bug which changes the font size when you open a system menu."],
--                type = "toggle",
--                order = 140,
--                get = function() return self.db.profile.autorestore end,
--                set = function(v) self.db.profile.autorestore = v; self:SetAutoRestore(v) end
--            },
        }
    }
)

--[[------------------------------------------------
    Module Event Functions
------------------------------------------------]]--

function module:OnModuleEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

    self.oldsize = {}

    for k, cf in pairs(Prat.Frames) do
        local _, s, _ = cf:GetFont()    
        self.oldsize[k]  = s
    end

    if not self.db.profile.rememberfont then
        self.db.profile.fontface = nil
    end

    self:ConfigureAllChatFrames()
--    -- This will resolve the issue where, when font sizes are set smaller than 12,
--    -- the size resets to 12 when closing UIOptionsFrame.
--    self:SetAutoRestore(self.db.profile.autorestore)
    self:SecureHook("FCF_SetChatWindowFontSize")
end

function module:PLAYER_ENTERING_WORLD()
	self:ConfigureAllChatFrames()
	self:UnregisterAllEvents()
end

function module:OnModuleDisable()
    self:UnhookAll()
    for k, cf in pairs(Prat.Frames) do
        self:SetFontSize(cf,self.oldsize[k] or 12)
    end
    self:SetFontMode("")
end

function module:GetSubValue(info)
		return self.db.profile[info[#info-1]][info[#info]]
end
function module:SetSubValue(info, b)
	self.db.profile[info[#info-1]][info[#info]] = b
	self:OnValueChanged(info, b)
end


--[[------------------------------------------------
	Core Functions
------------------------------------------------]]--

function module:ConfigureAllChatFrames()
	local db = self.db.profile

    if db.fontface then
        self:SetFont(db.fontface)
    end


    -- apply font size settings
    for k,v in pairs(Prat.Frames) do
        self:SetFontSize(v, db.size[k])
    end
    -- apply font flag settings
    if not db.monochrome then
        self:SetFontMode(db.outlinemode)
    else
        self:SetFontMode(db.outlinemode..", MONOCHROME")
    end
end

function module:SetFontSize(cf, size)
    FCF_SetChatWindowFontSize(nil, cf, size)
end



function module:SetFont(font)
    fontfile = Prat.Media:Fetch(Prat.Media.MediaType.FONT, font)
    for k, cf in pairs(Prat.Frames) do
        local f, s, m = cf:GetFont()    
        cf:SetFont(fontfile, s, m)
    end
end

function module:SetFontMode(mode, monochrome)
    for k, cf in pairs(Prat.Frames) do
        local f, s, m = cf:GetFont()    
        cf:SetFont(f, s, mode)
	
		if monochrome then
	        local c = self.db.profile.shadowcolor
	        cf:SetShadowColor(c.r, c.g, c.b, c.a)
		end
    end
end

function module:GetShadowClr()
    local h = self.db.profile.shadowcolor or {}
    return h.r or 1.0, h.g or 1.0, h.b or 1.0
end

function module:SetShadowClr(r,g,b)
	local db = self.db.profile
    db.shadowcolor = db.shadowcolor or {}
    local h = db.shadowcolor
    h.r, h.g, h.b = r, g, b
    self:ConfigureAllChatFrames()
end

function module:FCF_SetChatWindowFontSize(fcfself, chatFrame, fontSize)
	if ( not chatFrame ) then
		chatFrame = FCF_GetCurrentChatFrame();
	end
	if ( not fontSize ) then
		fontSize = fcfself.value;
	end    
    if self.db and self.db.profile.on then
       self.db.profile.size[chatFrame:GetName()] = fontSize
    end
end

--function module:SetAutoRestore(val)
--    self.db.profile.autorestore = val
--    if self.db.profile.autorestore then
--    	if not self:IsHooked("UpdateMicroButtons") then self:SecureHook("UpdateMicroButtons", "ConfigureAllChatFrames") end
--    else
--    	if self:IsHooked("UpdateMicroButtons") then self:Unhook("UpdateMicroButtons") end
--    end
--end    


module.OnValueChanged = module.ConfigureAllChatFrames
module.OnSubValueChanged = module.ConfigureAllChatFrames
module.OnColorValueChanged = module.ConfigureAllChatFrames

  return
end ) -- Prat:AddModuleToLoad