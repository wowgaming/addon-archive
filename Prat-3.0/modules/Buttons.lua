--if Prat.BN_CHAT then return end -- Removed in 3.3.5 

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
Revision: $Revision: r24999 $
Author(s): Fin (fin@instinct.org)
Website: http://files.wowace.com/Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#Clear
Subversion: http://svn.wowace.com/wowace/trunk/Prat/
Discussions: http://groups.google.com/group/wow-prat
Issues and feature requests: http://code.google.com/p/prat/issues/list
Description: Adds /clear (or /cls) and /clearall (or /clsall) commands for clearing chat frames (default=off).
Dependencies: Prat
Credits: Code taken almost entirely from Chatter by Antiarc
]]

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("Buttons")

if PRAT_MODULE == nil then 
    return 
end


local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
    ["Buttons"] = true,
    ["Chat window button options."] = true,
    ["chatmenu_name"] = "Show Chat Menu",
    ["chatmenu_desc"] = "Toggles chat menu on and off.",
    ["Show Arrows"] = true,
    ["Toggle showing chat arrows for each chat window."] = true, 
    ["Show Chat%d Arrows"] = true,
    ["Toggles navigation arrows on and off."] = true,
    ["scrollReminder_name"] = "Show ScrollDown Reminder",
    ["scrollReminder_desc"] = "Show reminder button when not at the bottom of a chat window.",
    ["Set Position"] = true,
    ["Sets position of chat menu and arrows for all chat windows."] = true,
    ["Default"] = true,
    ["Right, Inside Frame"] = true,
    ["Right, Outside Frame"] = true,
    ["alpha_name"] = "Set Alpha",
    ["alpha_desc"] = "Sets alpha of chat menu and arrows for all chat windows.",
    ["showmenu_name"] = "Show Menu",
    ["showmenu_desc"] = "Show Chat Menu",
    ["showbnet_name"] = "Show Social Menu",
    ["showbnet_desc"] = "Show Social Menu",
    ["showminimize_name"] = "Show Minimize Button",
    ["showminimize_desc"] = "Show Minimize Button",
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	alpha_desc = "Sets alpha of chat menu and arrows for all chat windows.",
	alpha_name = "Set Alpha",
	Buttons = true,
	chatmenu_desc = "Toggles chat menu on and off.",
	chatmenu_name = "Show Chat Menu",
	["Chat window button options."] = true,
	Default = true,
	["Right, Inside Frame"] = true,
	["Right, Outside Frame"] = true,
	scrollReminder_desc = "Show reminder button when not at the bottom of a chat window.",
	scrollReminder_name = "Show ScrollDown Reminder",
	["Set Position"] = true,
	["Sets position of chat menu and arrows for all chat windows."] = true,
	["Show Arrows"] = true,
	showbnet_desc = "Show Social Menu",
	showbnet_name = "Show Social Menu",
	["Show Chat%d Arrows"] = true,
	showmenu_desc = "Show Chat Menu",
	showmenu_name = "Show Menu",
	showminimize_desc = "Show Minimize Button",
	showminimize_name = "Show Minimize Button",
	["Toggle showing chat arrows for each chat window."] = true,
	["Toggles navigation arrows on and off."] = true,
}

)
L:AddLocale("frFR",  
{
	alpha_desc = "Définir l'alpha du menu du chat et des flèches pour toutes les fenêtres.",
	alpha_name = "Définir l'alpha",
	Buttons = "Boutons",
	chatmenu_desc = "Activer et désactiver le menu du tchat",
	chatmenu_name = "Montrer le menu du chat",
	["Chat window button options."] = "Options des boutons de la fenêtre de discusstion.",
	Default = "Défaut",
	["Right, Inside Frame"] = "Droite, dans le cadre",
	["Right, Outside Frame"] = "Droite, en dehors du cadre",
	scrollReminder_desc = "Montrer le bouton rappel lorsque vous n'êtes pas à la fin de la fenêtre de chat",
	-- scrollReminder_name = "",
	["Set Position"] = "Définir la position",
	["Sets position of chat menu and arrows for all chat windows."] = "Définir la position du menu et des flêches de toutes les fenêtres de tchat",
	["Show Arrows"] = "Montrer les flêches",
	showbnet_desc = "Montrer le menu Social",
	showbnet_name = "Montrer le menu Social",
	-- ["Show Chat%d Arrows"] = "",
	showmenu_desc = "Montrer le menu du Chat",
	showmenu_name = "Montrer le menu",
	-- showminimize_desc = "",
	-- showminimize_name = "",
	["Toggle showing chat arrows for each chat window."] = "Activer l'affichage des flêches pour chaque fenêtre de tchat",
	["Toggles navigation arrows on and off."] = "Activer et désactiver les flêches de navigations",
}

)
L:AddLocale("deDE", 
{
	alpha_desc = "Transparenz der Chat-Menüs und Navigationspfeile für alle Chat-Fenster einstellen.",
	alpha_name = "Transparenz einstellen",
	Buttons = "Schaltflächen",
	chatmenu_desc = "Chat-Menü ein- und ausschalten.",
	chatmenu_name = "Chat-Menü anzeigen",
	["Chat window button options."] = "Optionen für die die Schaltflächen der Chat-Fenster",
	Default = "Standard",
	["Right, Inside Frame"] = "Rechts, innerhalb des Rahmens",
	["Right, Outside Frame"] = "Rechts, außerhalb des Rahmens",
	scrollReminder_desc = "Erinnerungsschaltfläche anzeigen, wenn nicht am unteren Ende des Chat-Fensters.",
	scrollReminder_name = "ScrollDown-Erinnerung anzeigen",
	["Set Position"] = "Position einstellen",
	["Sets position of chat menu and arrows for all chat windows."] = "Stellt die Position des Chat-Menüs und der Navigationspfeile für alle Chat-Fenster ein.",
	["Show Arrows"] = "Zeige die Navigationspfeile",
	-- showbnet_desc = "",
	-- showbnet_name = "",
	["Show Chat%d Arrows"] = "Navigationspfeile im Chat%d anzeigen",
	showmenu_desc = "Chat-Menü anzeigen",
	showmenu_name = "Menü anzeigen",
	-- showminimize_desc = "",
	-- showminimize_name = "",
	["Toggle showing chat arrows for each chat window."] = "Anzeige der Navigationspfeile für jedes Chat-Fenster ein- und ausschalten.",
	["Toggles navigation arrows on and off."] = "Schaltet die Anzeige der Navigationspfeile an und aus",
}

)
L:AddLocale("koKR",  
{
	alpha_desc = "모든 채팅창의 대화창 메뉴와 화살표의 투명도를 설정합니다.",
	alpha_name = "투명도 설정",
	Buttons = "버튼",
	chatmenu_desc = "대화창 메뉴를 끄고 켭니다.",
	chatmenu_name = "대화창 메뉴 보이기",
	["Chat window button options."] = "대화창 버튼 옵션",
	Default = "기본값",
	["Right, Inside Frame"] = "우측, 프레임 안쪽",
	["Right, Outside Frame"] = "우측, 프레임 바깥쪽",
	scrollReminder_desc = "대화창을 위로 올렸을 때, 맨아래로 버튼을 보인다.",
	scrollReminder_name = "맨아래로버튼 보이기",
	["Set Position"] = "위치 설정",
	["Sets position of chat menu and arrows for all chat windows."] = "대화창의 메뉴와 화살표의 위치를 설정합니다.",
	["Show Arrows"] = "화살표 보이기",
	-- showbnet_desc = "",
	-- showbnet_name = "",
	["Show Chat%d Arrows"] = "대화창%d의 화살표 보이기",
	showmenu_desc = "채팅 메뉴 보이기",
	showmenu_name = "메뉴 보이기",
	-- showminimize_desc = "",
	-- showminimize_name = "",
	["Toggle showing chat arrows for each chat window."] = "각 채팅창에 대해 화살표 보이기를 끄고 켭니다.",
	["Toggles navigation arrows on and off."] = "상하 화살표를 끄고켭니다.",
}

)
L:AddLocale("esMX",  
{
	-- alpha_desc = "",
	-- alpha_name = "",
	-- Buttons = "",
	-- chatmenu_desc = "",
	-- chatmenu_name = "",
	-- ["Chat window button options."] = "",
	-- Default = "",
	-- ["Right, Inside Frame"] = "",
	-- ["Right, Outside Frame"] = "",
	-- scrollReminder_desc = "",
	-- scrollReminder_name = "",
	-- ["Set Position"] = "",
	-- ["Sets position of chat menu and arrows for all chat windows."] = "",
	-- ["Show Arrows"] = "",
	-- showbnet_desc = "",
	-- showbnet_name = "",
	-- ["Show Chat%d Arrows"] = "",
	-- showmenu_desc = "",
	-- showmenu_name = "",
	-- showminimize_desc = "",
	-- showminimize_name = "",
	-- ["Toggle showing chat arrows for each chat window."] = "",
	-- ["Toggles navigation arrows on and off."] = "",
}

)
L:AddLocale("ruRU",  
{
	alpha_desc = "Настройка прозрачности кнопки чата и всех цтрелок.",
	alpha_name = "Прозрачность",
	Buttons = true,
	chatmenu_desc = "Вкл/выкл кнопки чата.",
	chatmenu_name = "Показать кнопку чата",
	["Chat window button options."] = "Настройки кнопок окна чата.",
	Default = "По умолчанию",
	["Right, Inside Frame"] = "Справа, внутри окна",
	["Right, Outside Frame"] = "Справа, вне окна",
	scrollReminder_desc = "Вкл/выкл указателя, сигнализирующего о том, что окно чата можно прокручивать вниз.",
	scrollReminder_name = "Указатель прокрутки вниз",
	["Set Position"] = "Положение",
	["Sets position of chat menu and arrows for all chat windows."] = "Установить положение стрелок и кнопок чата для всех окон.",
	["Show Arrows"] = "Показывать стрелки",
	-- showbnet_desc = "",
	-- showbnet_name = "",
	["Show Chat%d Arrows"] = "Показывать стрелки %d чата",
	showmenu_desc = "Отображать меню команд",
	showmenu_name = "Отображать меню", -- Needs review
	-- showminimize_desc = "",
	-- showminimize_name = "",
	["Toggle showing chat arrows for each chat window."] = "Показывать стрелки для каждого окна чата.",
	["Toggles navigation arrows on and off."] = "Вкл/выкл навигационных стрелок.",
}

)
L:AddLocale("zhCN",  
{
	alpha_desc = "设置所有聊天窗口的聊天目录及箭头透明度",
	alpha_name = "设置透明度",
	Buttons = "按钮",
	chatmenu_desc = "聊天菜单开与关",
	chatmenu_name = "聊天菜单_名称",
	["Chat window button options."] = "聊天窗口按钮选项",
	Default = "默认",
	["Right, Inside Frame"] = "框体内右侧",
	["Right, Outside Frame"] = "框体外右侧",
	scrollReminder_desc = "当聊天信息不在底部时显示提醒按钮",
	scrollReminder_name = "显示向下滚动提醒",
	["Set Position"] = "设置位置",
	["Sets position of chat menu and arrows for all chat windows."] = "设置所有聊天窗口的聊天目录及箭头位置",
	["Show Arrows"] = "显示箭头",
	-- showbnet_desc = "",
	-- showbnet_name = "",
	["Show Chat%d Arrows"] = "显示聊天%d箭头",
	-- showmenu_desc = "",
	-- showmenu_name = "",
	-- showminimize_desc = "",
	-- showminimize_name = "",
	["Toggle showing chat arrows for each chat window."] = "为各个聊天窗口显示上下翻页箭头",
	["Toggles navigation arrows on and off."] = "切换导航箭头开与关",
}

)
L:AddLocale("esES",  
{
	alpha_desc = "Establece la transparencia del menu del chat y de las flechas para todas las ventanas.",
	alpha_name = "Establecer Transparencia",
	Buttons = "Botones",
	chatmenu_desc = "Alterna la activación del menú del chat.",
	chatmenu_name = "Mostrar Menú del Chat",
	["Chat window button options."] = "Opciones de los botones de la ventana del chat",
	Default = "Predeterminado",
	["Right, Inside Frame"] = "Derecha, Dentro del Marco",
	["Right, Outside Frame"] = "Derecha, Fuera del Marco",
	scrollReminder_desc = "Muestra el botón recordatorio cuando no se está en la parte inferior de la ventana de chat.",
	scrollReminder_name = "Mostrar Recordatorio de Desplazamiento Abajo",
	["Set Position"] = "Establecer Posición",
	["Sets position of chat menu and arrows for all chat windows."] = "Establece la posición del menú y de las flechas de todas las ventanas de chat.",
	["Show Arrows"] = "Mostar Flechas",
	-- showbnet_desc = "",
	-- showbnet_name = "",
	["Show Chat%d Arrows"] = "Mostar Flechas del Chat %d",
	-- showmenu_desc = "",
	-- showmenu_name = "",
	-- showminimize_desc = "",
	-- showminimize_name = "",
	["Toggle showing chat arrows for each chat window."] = "Alterna el mostrar las flechas para cada ventana de chat.",
	["Toggles navigation arrows on and off."] = "Alterna la activación de las flechas de navegación.",
}

)
L:AddLocale("zhTW",  
{
	alpha_desc = "設定所有聊天視窗的聊天選單以及箭頭。",
	alpha_name = "設定透明度",
	Buttons = "按鈕",
	chatmenu_desc = "切換聊天選單的開和關。",
	chatmenu_name = "顯示聊天選單",
	["Chat window button options."] = "聊天視窗按鈕選單。",
	Default = "預設值",
	["Right, Inside Frame"] = "右側，內部框架",
	["Right, Outside Frame"] = "右側，外部框架",
	-- scrollReminder_desc = "",
	-- scrollReminder_name = "",
	["Set Position"] = "設定位置",
	-- ["Sets position of chat menu and arrows for all chat windows."] = "",
	["Show Arrows"] = "顯示箭頭",
	-- showbnet_desc = "",
	-- showbnet_name = "",
	["Show Chat%d Arrows"] = "顯示聊天 %d 的箭頭",
	-- showmenu_desc = "",
	-- showmenu_name = "",
	-- showminimize_desc = "",
	-- showminimize_name = "",
	-- ["Toggle showing chat arrows for each chat window."] = "",
	-- ["Toggles navigation arrows on and off."] = "",
}

)
--@end-non-debug@


local module = Prat:NewModule(PRAT_MODULE, "AceHook-3.0")

Prat:SetModuleDefaults(module.name, {
	profile = {
	    on = true,
		scrollReminder = true,
		showButtons = true,
		showBnet = true,
		showMenu = true,
		showminimize = true,
	}
} )

Prat:SetModuleOptions(module.name, {
        name = L["Buttons"],
        desc = L["Chat window button options."],
        type = "group",
        args = {
		    showButtons = { 
				name = L["Show Arrows"],
				desc = L["Toggle showing chat arrows for each chat window."],
				type = "toggle",
				order = 100
			},
		    scrollReminder = { 
				name = L["scrollReminder_name"],
				desc = L["scrollReminder_desc"],
				type = "toggle",
				order = 110 
			},
		    showBnet = { 
				name = L["showbnet_name"],
				desc = L["showbnet_desc"],
				type = "toggle",
				order = 120 
			},
		    showMenu = { 
				name = L["showmenu_name"],
				desc = L["showmenu_desc"],
				type = "toggle",
				order = 130 
			},	
		    showminimize = { 
				name = L["showminimize_name"],
				desc = L["showminimize_desc"],
				type = "toggle",
				order = 140 
			},									
        }
    }
)

--[[------------------------------------------------
	Module Event Functions
------------------------------------------------]]--
local fmt = _G.string.format


local function hide(self)
	if not self.override then
		self:Hide()
	end
	self.override = nil
end

function module:OnModuleEnable()
    local buttons3 = Prat.Addon:GetModule("OriginalButtons", true)
    if buttons3 and buttons3:IsEnabled() then
        self.disabledB3 = true
        buttons3.db.profile.on = false
        buttons3:Disable()
        LibStub("AceConfigRegistry-3.0"):NotifyChange("Prat")
    end

    self:ApplyAllSettings()
	
	Prat.RegisterChatEvent(self, Prat.Events.POST_ADDMESSAGE)

	--self:SecureHook("FCF_SetButtonSide")

end

function module:ApplyAllSettings()
	if not self.db.profile.showButtons then
		self:HideButtons()
	else
	    self:ShowButtons()
	end

	self:UpdateMenuButtons()
	
	self:AdjustMinimizeButtons()
	
	self:AdjustButtonFrames(self.db.profile.showButtons)
	
    self:UpdateReminder()
end

function module:OnModuleDisable()
	self:DisableBottomButton()
	self:ShowButtons()
	
	Prat.UnregisterAllChatEvents(self)
end

function module:UpdateReminder()
	local v = self.db.profile.scrollReminder
	if v then
		module:EnableBottomButton()
	elseif self.buttonsEnabled then
		module:DisableBottomButton()
	end
end

function module:OnValueChanged(info, b)
    self:ApplyAllSettings()
end

function module:UpdateMenuButtons()
    if self.db.profile.showBnet then
        FriendsMicroButton:Show()
    else
        FriendsMicroButton:Hide()
    end

    if self.db.profile.showMenu then
    	ChatFrameMenuButton:SetScript("OnShow", nil)
	    ChatFrameMenuButton:Show()
	else
    	ChatFrameMenuButton:SetScript("OnShow", hide)
        ChatFrameMenuButton:Hide()	
    end
end
function module:HideButtons()
    self:UpdateMenuButtons()
    
	local upButton, downButton, bottomButton, min

	for name, frame in pairs(Prat.Frames) do
		upButton = _G[name.."ButtonFrameUpButton"]
		upButton:SetScript("OnShow", hide)
		upButton:Hide()
		downButton = _G[name.."ButtonFrameDownButton"]
		downButton:SetScript("OnShow", hide)
		downButton:Hide()
		bottomButton = _G[name.."ButtonFrameBottomButton"]
		bottomButton:SetScript("OnShow", hide)
		bottomButton:Hide()
		bottomButton:SetParent(frame)
		
		bottomButton:SetScript("OnClick", function() frame:ScrollToBottom() end)

		self:FCF_SetButtonSide(frame)
	end
	
	self:AdjustMinimizeButtons()
end

function module:AdjustButtonFrames(visible)
    for name, frame in pairs(Prat.Frames) do
        local f = _G[name.."ButtonFrame"]
        
        if visible then
            f:SetScript("OnShow", nil)
            f:Show()
            f:SetWidth(29)
        else
            f:SetScript("OnShow", hide)    
            f:Hide()    
            f:SetWidth(0.1)
        end
    end
end

function module:AdjustMinimizeButtons()
    for name, frame in pairs(Prat.Frames) do
		local min = _G[name.."ButtonFrameMinimizeButton"]
		
		if min then 
		
		    if self.db.profile.showminimize then
    		    min:ClearAllPoints()
    		    
    		    min:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 2, 2)
    		    --min:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -32, -4);
    		    
        		min:SetParent(_G[frame:GetName().."Tab"])
        
                min:SetScript("OnShow", 
                                    function(self)
                                        if frame.isDocked then
                                            self:Hide()
                                        end
                                    end )
                                    
                min:SetScript("OnClick", 
                                    function(self) 
        								FCF_MinimizeFrame(frame, strupper(frame.buttonSide))
        							end )
        							
        		min:Show()
        	else
        	    min:SetScript("OnShow", hide)
        	    min:Hide()
        	end
    	end
	end    
end

function module:ShowButtons()
	self:Unhook("FCF_SetButtonSide")
    self:UpdateMenuButtons()
	local upButton, downButton, bottomButton

	for name, frame in pairs(Prat.Frames) do
		upButton = _G[name.."ButtonFrameUpButton"]
		upButton:SetScript("OnShow", nil)
		upButton:Show()
		downButton = _G[name.."ButtonFrameDownButton"]
		downButton:SetScript("OnShow", nil)
		downButton:Show()
		bottomButton = _G[name.."ButtonFrameBottomButton"]
		bottomButton:SetScript("OnShow", nil)
		bottomButton:Show()
		bottomButton:SetParent(_G[name.."ButtonFrame"])
		
--		frame.buttonSide = nil
--		bottomButton:ClearAllPoints()
--		bottomButton:SetPoint("BOTTOMRIGHT", _G[name.."ButtonFrame"], "BOTTOMLEFT", 2, 2)
--		bottomButton:SetPoint("BOTTOMLEFT", _G[name.."ButtonFrame"], "BOTTOMLEFT", -32, -4);
		--FCF_UpdateButtonSide(frame)
		
		--bottomButton:SetScript("OnClick", function() frame:ScrollToBottom() end)
		
		self:FCF_SetButtonSide(frame)
	end
	
	self:AdjustMinimizeButtons()	
end

--[[ - - ------------------------------------------------
	Core Functions
--------------------------------------------- - ]]--

function module:FCF_SetButtonSide(chatFrame, buttonSide)
	local f = _G[chatFrame:GetName().."ButtonFrameBottomButton"]
	local bf = _G[chatFrame:GetName().."ButtonFrame"]
	
	if self.db.profile.showButtons then
    	f:ClearAllPoints()
        f:SetPoint("BOTTOM", bf, "BOTTOM", 0, 0)
	else
    	f:ClearAllPoints()
        f:SetPoint("BOTTOMRIGHT", chatFrame, "BOTTOMRIGHT", 2, 2)
    end
end


function module:EnableBottomButton()
	if self.buttonsEnabled then return end
	self.buttonsEnabled = true
	for name, f in pairs(Prat.Frames) do
		self:SecureHook(f, "ScrollUp")
		self:SecureHook(f, "ScrollToTop", "ScrollUp")
		self:SecureHook(f, "PageUp", "ScrollUp")
					
		self:SecureHook(f, "ScrollDown")
		self:SecureHook(f, "ScrollToBottom", "ScrollDownForce")
		self:SecureHook(f, "PageDown", "ScrollDown")

		local button = _G[name .. "ButtonFrameBottomButton"]
		
		if button then
    		if f:GetCurrentScroll() ~= 0 then
    			button.override = true
    			button:Show()	
    		else
    			button:Hide()
    		end
        end
	end
end

function module:DisableBottomButton()
	if not self.buttonsEnabled then return end
	self.buttonsEnabled = false
	for name, f in pairs(Prat.Frames) do
		if f then
			self:Unhook(f, "ScrollUp")
			self:Unhook(f, "ScrollToTop")
			self:Unhook(f, "PageUp")					
			self:Unhook(f, "ScrollDown")
			self:Unhook(f, "ScrollToBottom")
			self:Unhook(f, "PageDown")
			local button = _G[name.. "ButtonFrameBottomButton"]
			button:Hide()
		end
	end
end

function module:ScrollUp(frame)
	local button = _G[frame:GetName() .. "ButtonFrameBottomButton"]
	button.override = true
	button:Show()
end

function module:ScrollDown(frame)
	if frame:GetCurrentScroll() == 0 then
		local button = _G[frame:GetName() .. "ButtonFrameBottomButton"]
		button:Hide()	
	end
end

function module:ScrollDownForce(frame)
	local button = _G[frame:GetName() .. "ButtonFrameBottomButton"]
	button:Hide()	
end

--function module:AddMessage(frame, text, ...)
function module:Prat_PostAddMessage(info, message, frame, event, text, r, g, b, id)
	local button = _G[frame:GetName() .. "ButtonFrameBottomButton"]

	if not button then return end
	if frame:GetCurrentScroll() > 0 then
		button.override = true
		button:Show()
	else
		button:Hide()	
	end
end


  return
end ) -- Prat:AddModuleToLoad