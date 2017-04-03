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
Revision: $Revision: 82149 $
Author(s): Curney (asml8ed@gmail.com)
           Krtek (krtek4@gmail.com)
Inspired by: idChat2_PlayerNames by Industrial
Website: http://www.wowace.com/files/index.php?path=Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#Scroll
SVN: http://svn.wowace.com/wowace/trunk/Prat/
Description: Module for Prat that enables mousewheel scrolling and TheDownLow for chat windows (default=on).
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("Scroll")

if PRAT_MODULE == nil then 
    return 
end

local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
    ["Scroll"] = true,
    ["Chat window scrolling options."] = true,
    ["mousewheel_name"] = "Enable MouseWheel",
    ["mousewheel_desc"] = "Toggle mousewheel support for each chat window.",
    ["Set MouseWheel Speed"] = true,
    ["Set number of lines mousewheel will scroll."] = true,
    ["Set Ctrl+MouseWheel Speed"] = "Set Shift+MouseWheel Speed",
    ["Set number of lines mousewheel will scroll when ctrl is pressed."] = "Set number of lines mousewheel will scroll when shift is pressed.",
    ["lowdown_name"] = "Enable TheLowDown",
    ["lowdown_desc"] = "Toggle auto jumping to the bottom for each chat window.",
    ["Set TheLowDown Delay"] = true,
    ["Set time to wait before jumping to the bottom of chat windows."] = true,
	["Text scroll direction"] = true,
	["Control whether text is added to the frame at the top or the bottom."] = true,
	["Top"] = "Top to bottom",
	["Bottom"] = "Bottom to top",
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	Bottom = "Bottom to top",
	["Chat window scrolling options."] = true,
	["Control whether text is added to the frame at the top or the bottom."] = true,
	lowdown_desc = "Toggle auto jumping to the bottom for each chat window.",
	lowdown_name = "Enable TheLowDown",
	mousewheel_desc = "Toggle mousewheel support for each chat window.",
	mousewheel_name = "Enable MouseWheel",
	Scroll = true,
	["Set Ctrl+MouseWheel Speed"] = true,
	["Set MouseWheel Speed"] = true,
	["Set number of lines mousewheel will scroll."] = true,
	["Set number of lines mousewheel will scroll when ctrl is pressed."] = true,
	["Set TheLowDown Delay"] = true,
	["Set time to wait before jumping to the bottom of chat windows."] = true,
	["Text scroll direction"] = true,
	Top = "Top to bottom",
}

)
L:AddLocale("frFR",  
{
	-- Bottom = "",
	-- ["Chat window scrolling options."] = "",
	-- ["Control whether text is added to the frame at the top or the bottom."] = "",
	-- lowdown_desc = "",
	-- lowdown_name = "",
	-- mousewheel_desc = "",
	-- mousewheel_name = "",
	-- Scroll = "",
	-- ["Set Ctrl+MouseWheel Speed"] = "",
	-- ["Set MouseWheel Speed"] = "",
	-- ["Set number of lines mousewheel will scroll."] = "",
	-- ["Set number of lines mousewheel will scroll when ctrl is pressed."] = "",
	-- ["Set TheLowDown Delay"] = "",
	-- ["Set time to wait before jumping to the bottom of chat windows."] = "",
	-- ["Text scroll direction"] = "",
	-- Top = "",
}

)
L:AddLocale("deDE", 
{
	Bottom = "Von unten nach oben",
	["Chat window scrolling options."] = "Optionen zum Scrollen in Chat-Fenstern.",
	["Control whether text is added to the frame at the top or the bottom."] = "Steuerung, ob der Text oben oder unten im Chat-Rahmen hinzugefügt wird.",
	lowdown_desc = "Automatisches Springen zum unteren Ende eines Chat-Fensters ein-/ausschalten.",
	lowdown_name = "TheLowDown aktivieren",
	mousewheel_desc = "Mausradunterstützung für jedes Chat-Fenster ein-/ausschalten.",
	mousewheel_name = "Mausrad aktivieren",
	Scroll = "Scrollen",
	["Set Ctrl+MouseWheel Speed"] = "Geschwindigkeit für <Strg>-Mausrad einstellen",
	["Set MouseWheel Speed"] = "Geschwindigkeit des Mausrads einstellen",
	["Set number of lines mousewheel will scroll."] = "Zeilenanzahl einstellen, die das Mausrad weiterscrollt.",
	["Set number of lines mousewheel will scroll when ctrl is pressed."] = "Anzahl der Zeilen, die per Mausrad weitergescrollt werden, während <Strg> gedrückt wird, einstellen.",
	["Set TheLowDown Delay"] = "TheLowDown-Verzögerung einstellen",
	["Set time to wait before jumping to the bottom of chat windows."] = "Wartezeit einstellen, ehe zum Ende von Chat-Fenstern gesprungen wird.",
	["Text scroll direction"] = "Scroll-Richtung im Text",
	Top = "Von oben nach unten",
}

)
L:AddLocale("koKR",  
{
	Bottom = "밑에서 위로",
	["Chat window scrolling options."] = "채팅창 스크롤 옵션.",
	-- ["Control whether text is added to the frame at the top or the bottom."] = "",
	lowdown_desc = "채팅창별 최하단 이동버튼 보이기",
	-- lowdown_name = "",
	mousewheel_desc = "채팅창별 마우스 휠 지원 토글",
	mousewheel_name = "마우스 휠 사용",
	Scroll = "스크롤",
	["Set Ctrl+MouseWheel Speed"] = "Ctrl+마우스 휠 속도 설정",
	["Set MouseWheel Speed"] = "마우스 휠 속도 설정",
	["Set number of lines mousewheel will scroll."] = "마우스 휠로 스크롤할 줄의 수 설정",
	["Set number of lines mousewheel will scroll when ctrl is pressed."] = "Ctrl 키를 누르고 마우스 휠을 사용할 때 스크롤할 줄의 수 설정",
	-- ["Set TheLowDown Delay"] = "",
	-- ["Set time to wait before jumping to the bottom of chat windows."] = "",
	["Text scroll direction"] = "텍스트 스크롤 방향",
	Top = "위에서 아래로",
}

)
L:AddLocale("esMX",  
{
	-- Bottom = "",
	-- ["Chat window scrolling options."] = "",
	-- ["Control whether text is added to the frame at the top or the bottom."] = "",
	-- lowdown_desc = "",
	-- lowdown_name = "",
	-- mousewheel_desc = "",
	-- mousewheel_name = "",
	-- Scroll = "",
	-- ["Set Ctrl+MouseWheel Speed"] = "",
	-- ["Set MouseWheel Speed"] = "",
	-- ["Set number of lines mousewheel will scroll."] = "",
	-- ["Set number of lines mousewheel will scroll when ctrl is pressed."] = "",
	-- ["Set TheLowDown Delay"] = "",
	-- ["Set time to wait before jumping to the bottom of chat windows."] = "",
	-- ["Text scroll direction"] = "",
	-- Top = "",
}

)
L:AddLocale("ruRU",  
{
	Bottom = "Снизу вверх",
	["Chat window scrolling options."] = "Настройки прокрутки окна чата.",
	["Control whether text is added to the frame at the top or the bottom."] = "Регулировка текста добавленного в окно в вверх или низ.",
	lowdown_desc = "Вкл/Выкл авто прокрутку в низ для во всех окнах чата.",
	lowdown_name = "Включить спад в низ",
	mousewheel_desc = "Вкл/Выкл поддержку колесика мыши во всех оконах чата.",
	mousewheel_name = "Включить КолесоМыши",
	Scroll = "Прокрутка",
	["Set Ctrl+MouseWheel Speed"] = "Задать скорость Ctrl+КолесоМыши",
	["Set MouseWheel Speed"] = "Скорость КолесаМыши",
	["Set number of lines mousewheel will scroll."] = "Устанавите число строк прокручиваемых колёсиком мыши за раз.",
	["Set number of lines mousewheel will scroll when ctrl is pressed."] = "Установите число строк прокручиваемых колёсиком мыши при удерживании ctrl.",
	["Set TheLowDown Delay"] = "Задержка спада в низ",
	["Set time to wait before jumping to the bottom of chat windows."] = "Установите время ожидания перед прокруткой в низ окна чата.",
	["Text scroll direction"] = "Направление текста прокрутки",
	Top = "С верху вниз",
}

)
L:AddLocale("zhCN",  
{
	Bottom = "从下到上",
	["Chat window scrolling options."] = "聊天窗口滚动选项",
	["Control whether text is added to the frame at the top or the bottom."] = "控制文本被添加到框体顶端还是底端",
	lowdown_desc = "为每个聊天窗口自动跳至底端",
	lowdown_name = "启用回到底端",
	mousewheel_desc = "为每个聊天窗口选取鼠标滚轮支持",
	mousewheel_name = "启用鼠标滚轮",
	Scroll = "滚动",
	["Set Ctrl+MouseWheel Speed"] = "设置Ctrl+鼠标滚轮速度",
	["Set MouseWheel Speed"] = "设置鼠标滚轮速度",
	["Set number of lines mousewheel will scroll."] = "设置鼠标滚轮滚动行数",
	["Set number of lines mousewheel will scroll when ctrl is pressed."] = "设置按下ctrl时鼠标滚轮滚动行数",
	["Set TheLowDown Delay"] = "设置回到底端延迟",
	["Set time to wait before jumping to the bottom of chat windows."] = "设置聊天窗口跳至底部前等待时间",
	["Text scroll direction"] = "文本滚动方向",
	Top = "从上到下",
}

)
L:AddLocale("esES",  
{
	Bottom = "De Abajo a Arriba",
	["Chat window scrolling options."] = "Opciones de desplazamiento de la ventana de chat.",
	["Control whether text is added to the frame at the top or the bottom."] = "Controla si el texto se añade al marco en la parte superior o inferior.",
	lowdown_desc = "Alternar saltar automáticamente a la parte inferior de cada ventana de chat.",
	lowdown_name = "Activar TheLowDown", -- Needs review
	mousewheel_desc = "Alterna soporte para rueda de ratón para cada ventana de chat.",
	mousewheel_name = "Activar Rueda del Ratón",
	Scroll = "Desplazamiento",
	["Set Ctrl+MouseWheel Speed"] = "Establecer Velocidad Ctrl+Rueda Ratón",
	["Set MouseWheel Speed"] = "Establecer Velocidad de la Rueda del Ratón",
	["Set number of lines mousewheel will scroll."] = "Establece el número de lineas que la rueda del ratón desplazará.",
	["Set number of lines mousewheel will scroll when ctrl is pressed."] = "Establece el número de líneas que la rueda del ratón desplazará cuando ctrl está pulsada.",
	["Set TheLowDown Delay"] = "Establecer Retraso TheLowDown", -- Needs review
	["Set time to wait before jumping to the bottom of chat windows."] = "Estable el tiempo de espera antes de saltar a la parte inferior de las ventanas de chat.",
	["Text scroll direction"] = "Dirección de desplazamiento del texto",
	Top = "De arriba a abajo",
}

)
L:AddLocale("zhTW",  
{
	Bottom = "由下而上",
	["Chat window scrolling options."] = "聊天視窗滾動選項",
	-- ["Control whether text is added to the frame at the top or the bottom."] = "",
	lowdown_desc = "切換是否於個別聊天視窗自動跳轉至最新訊息",
	lowdown_name = "啟用 TheLowDown",
	mousewheel_desc = "切換是否於個別聊天視窗支援滑鼠滾輪",
	mousewheel_name = "啟用滑鼠滾輪",
	-- Scroll = "",
	["Set Ctrl+MouseWheel Speed"] = "設定 Ctrl 及滑鼠滾輪速度",
	["Set MouseWheel Speed"] = "設定滑鼠滾輪速度",
	["Set number of lines mousewheel will scroll."] = "設定滑鼠滾輪將滾動行數數字",
	["Set number of lines mousewheel will scroll when ctrl is pressed."] = "設定當按下 Ctrl時滑鼠滾輪滾動的行數",
	["Set TheLowDown Delay"] = "設定上下延遲",
	-- ["Set time to wait before jumping to the bottom of chat windows."] = "",
	["Text scroll direction"] = "文字滾動方向",
	Top = "由上而下",
}

)
--@end-non-debug@




----[[
--	Chinese Local : CWDG Translation Team 昏睡墨鱼 (Thomas Mo)
--	CWDG site: http://Cwowaddon.com
--	$Rev: 82149 $
--]]
--

--

--

--

-- 

--



local module = Prat:NewModule(PRAT_MODULE, "AceHook-3.0")


Prat:SetModuleDefaults(module.name, {
	profile = {
        on = true,
        mousewheel = { ["*"] = true },
        normscrollspeed = 1,
        ctrlscrollspeed = 3,
        lowdown = { ["*"] = true },
        lowdowndelay = 20,
		scrolldirection = "BOTTOM"     
	}
} )


---- build the options menu using prat templates
--module.toggleOptions = {
--    mousewheel_handler = {},
--    sep135_sep = 135,
--    lowdown_handler = {}
--}


Prat:SetModuleOptions(module.name, {
    name = L["Scroll"],
    desc = L["Chat window scrolling options."],
    type = "group",
    args = {
		 mousewheel = {
			name = L["mousewheel_name"],
			desc = L["mousewheel_desc"],
			type = "multiselect",
			order = 110,
			values = Prat.HookedFrameList,
			get = "GetSubValue",
			set = "SetSubValue"
		 },
         normscrollspeed = {
            name = L["Set MouseWheel Speed"],
            desc = L["Set number of lines mousewheel will scroll."],
            type = "range",
            order = 120,
            min = 1,
            max = 21,
            step = 1,
        },
		scrolldirection = {
			type = "select", 
            name = L["Text scroll direction"],
            desc = L["Control whether text is added to the frame at the top or the bottom."],
			values = { ["TOP"] = L["Top"], ["BOTTOM"] = L["Bottom"] },
		},
        ctrlscrollspeed = {
            name = L["Set Ctrl+MouseWheel Speed"],
            desc = L["Set number of lines mousewheel will scroll when ctrl is pressed."],
            type = "range",
            order = 130,
            min = 3,
            max = 21,
            step = 3,
        },
--		lowdown = {
--			name = L["lowdown_name"],
--			desc = L["lowdown_desc"],
--			type = "multiselect",
--			order = 110,
--			values = Prat.HookedFrameList,
--			get = "GetSubValue",
--			set = "SetSubValue"
--		},		
--        lowdowndelay = {
--            name = L["Set TheLowDown Delay"],
--            desc = L["Set time to wait before jumping to the bottom of chat windows."],
--            type = "range",
--            order = 220,
--            min = 1,
--            max = 60,
--            step = 1,
--        },
    }
})

module.OnSubValueChanged = module.ConfigureAllFrames


--[[------------------------------------------------
    Module Event Functions
------------------------------------------------]]--

-- things to do when the module is enabled
function module:OnModuleEnable()
	self:ConfigureAllFrames()	
end



-- things to do when the module is disabled
function module:OnModuleDisable()
    for k, v in pairs(Prat.Frames) do
        self:MouseWheel(v,false)
--       	self:LowDown(v,false)
    end

	self:SetScrollDirection("BOTTOM")
end

--[[------------------------------------------------
    Core Functions
------------------------------------------------]]--

function module:ConfigureAllFrames()
    for k, v in pairs(Prat.Frames) do
        self:MouseWheel(v, self.db.profile.mousewheel[k])
--       	self:LowDown(v, self.db.profile.lowdown[k])
    end

	self:SetScrollDirection(self.db.profile.scrolldirection)
end

do
	local function scrollFrame(cf, up)
		if IsControlKeyDown() then
	        if up then cf:ScrollToTop() else cf:ScrollToBottom() end
		else
		    if IsShiftKeyDown() then
		        for i = 1,module.db.profile.ctrlscrollspeed do
		            if up then cf:ScrollUp() else cf:ScrollDown() end
		        end
		    else
		        for i = 1,module.db.profile.normscrollspeed do
		            if up then cf:ScrollUp() else cf:ScrollDown() end
		        end
		    end
		end
	end
	
	function module:MouseWheel(cf, enabled)
	    if enabled then
	        cf:SetScript("OnMouseWheel", function(cf, arg1) scrollFrame(cf, arg1 > 0) end)
	        cf:EnableMouseWheel(true)
	    else
	        cf:SetScript("OnMouseWheel", nil)
	        cf:EnableMouseWheel(false)
	    end
	end
end

--function module:LowDown(cf, enabled)
--	local name = cf:GetName()
--	local funcs = {"ScrollUp", "ScrollDown", "ScrollToTop", "PageUp", "PageDown"}
--
--    if enabled then
--		for _,func in ipairs(funcs) do
--			local f = function(cf)
--				if self:IsEventScheduled(name.."DownTimeout") then self:CancelScheduledEvent(name.."DownTimeout") end
--				self:ScheduleEvent(name.."DownTimeout", self.ResetFrame, self.db.profile.lowdowndelay, self, cf)
--			end
--			self:SecureHook(cf, func, f)
--		end
--	else
--		for _,func in ipairs(funcs) do
--			if self:IsHooked(cf, func) then self:Unhook(cf, func) end
--		end
--	end
--end

function module:ResetFrame(cf)
	if not cf:AtBottom() then
		cf:ScrollToBottom()
	end
end

function module:SetScrollDirection(direction)
    for k, v in pairs(Prat.HookedFrames) do
		self:ScrollDirection(v, direction)
    end

	self.db.profile.scrolldirection = direction
end

function module:ScrollDirection(cf, direction)
	if cf:GetInsertMode() ~= direction then 
		cf:SetMaxLines(cf:GetMaxLines())
		cf:SetInsertMode(direction)
	end
end



  return
end ) -- Prat:AddModuleToLoad