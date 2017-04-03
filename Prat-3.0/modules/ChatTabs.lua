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
Name: PratChatTabs
Revision: $Revision: 80499 $
Author(s): Sylvanaar (sylvanaar@mindspring.com)
Website: http://www.wowace.com/files/index.php?path=Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#Tabs
Subversion: http://svn.wowace.com/wowace/trunk/Prat/
Discussions: http://groups.google.com/group/wow-prat
Issues and feature requests: http://code.google.com/p/prat/issues/list
Description: Module for Prat that adds chat window tab options (default = hidden).
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("ChatTabs")

local dbg = function() end
--[===[@debug@
dbg = Prat.PrintLiteral
--@end-debug@]===]

if PRAT_MODULE == nil then 
    return 
end

local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
    ["Tabs"] = true,
    ["Chat window tab options."] = true,
    ["Set Display Mode"] = true,
    ["Set tab display mode for each chat window."] = "Set tab display mode for each chat window. Checked (on), Unchecked (off), Greyed Check (default)",
    ["Set ChatFrame%d Display Mode"] = true,
    ["Set tab display to always, hidden or the Blizzard default."] = true,
    ["Active Alpha"] = true,
    ["Sets alpha of chat tab for active chat frame."] = true,
    ["Not Active Alpha"] = true,
    ["Sets alpha of chat tab for not active chat frame."] = true,
    ["All"] = true,
    ["Individual"] = true,
    ["Always"] = true,
    ["Hidden"] = true,
    ["Default"] = true,
    ["disableflash_name"] =  "Disable Flashing",
    ["disableflash_desc"] =  "Disable flashing of the chat tabs.",
    ["preventdrag_name"] =  "Prevent Dragging",
    ["preventdrag_desc"] =  "Prevent dragging chat tabs with mouse",
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	["Active Alpha"] = true,
	All = true,
	Always = true,
	["Chat window tab options."] = true,
	Default = true,
	disableflash_desc = "Disable flashing of the chat tabs.",
	disableflash_name = "Disable Flashing",
	Hidden = true,
	Individual = true,
	["Not Active Alpha"] = true,
	preventdrag_desc = "Prevent dragging chat tabs with mouse",
	preventdrag_name = "Prevent Dragging",
	["Set ChatFrame%d Display Mode"] = true,
	["Set Display Mode"] = true,
	["Sets alpha of chat tab for active chat frame."] = true,
	["Sets alpha of chat tab for not active chat frame."] = true,
	["Set tab display mode for each chat window."] = "Set tab display mode for each chat window. Checked (on), Unchecked (off), Greyed Check (default)",
	["Set tab display to always, hidden or the Blizzard default."] = true,
	Tabs = true,
}

)
L:AddLocale("frFR",  
{
	["Active Alpha"] = "Activer l'alpha",
	All = "Tout",
	Always = "Toujours",
	["Chat window tab options."] = "Options des onglets de la fenêtre de chat",
	Default = "Défaut",
	disableflash_desc = "Désactiver le clignotement des onglets.",
	disableflash_name = "Désactiver le clignotement",
	Hidden = "Caché",
	Individual = "Individuel",
	["Not Active Alpha"] = "Alpha non-actif",
	preventdrag_desc = "Empêcher le déplacement des onglets avec la souris",
	-- preventdrag_name = "",
	["Set ChatFrame%d Display Mode"] = "Définir le mode d'affichage de la ChatFrame%d",
	["Set Display Mode"] = "Définir le mode d'affichage",
	["Sets alpha of chat tab for active chat frame."] = "Définit l'alpha de l'onglet pour les cadres de chat actif",
	["Sets alpha of chat tab for not active chat frame."] = "Définit l'alpha de l'onglet pour les cadres de chat inactif",
	["Set tab display mode for each chat window."] = "Définir le mode d'affichage des onglets pour chaque fenêtre de chat. Coché (On), Décoché (Off) Coché en gris (Défaut)",
	["Set tab display to always, hidden or the Blizzard default."] = "Définir l'affichage des onglets sur toujours, caché ou par défaut Blizzard",
	Tabs = "Onglets",
}

)
L:AddLocale("deDE", 
{
	["Active Alpha"] = "Aktive Transparenz",
	All = "Alle",
	Always = "Immer",
	["Chat window tab options."] = "Optionen für Tabs der Chat-Fenster",
	Default = "Standard",
	disableflash_desc = "Das Blinken der Chat-Tabs ausschalten.",
	disableflash_name = "Blinken ausschalten",
	Hidden = "Verborgen",
	Individual = "Individuell",
	["Not Active Alpha"] = "Inaktive Transparenz",
	preventdrag_desc = "Das Ziehen der Tabs von Chat-Fenstern mit der Maus verhindern.",
	preventdrag_name = "Ziehen verhindern",
	["Set ChatFrame%d Display Mode"] = "Chat-Rahmen%d Darstellungsmodus einstellen",
	["Set Display Mode"] = "Darstellungsmodus einstellen",
	["Sets alpha of chat tab for active chat frame."] = "Transparenz der Chat-Tabs von aktiven Chat-Rahmen einstellen.",
	["Sets alpha of chat tab for not active chat frame."] = "Transparenz der Chat-Tabs von inaktiven Chat-Rahmen einstellen.",
	["Set tab display mode for each chat window."] = "Tabdarstellungsmodus für jedes Chat-Fenster einstellen: markiert (an), nicht markiert (aus), grau markiert (standard)",
	["Set tab display to always, hidden or the Blizzard default."] = "Tabdarstellung einstellen: immer, verbergen oder Blizzards Standard",
	Tabs = "Tabs (Reiter der Chat-Fenster)",
}

)
L:AddLocale("koKR",  
{
	["Active Alpha"] = "활성탭 투명도",
	All = "모두",
	Always = "항상",
	["Chat window tab options."] = "대화창 탭 옵션",
	Default = "기본값",
	disableflash_desc = "대화창 탭의 반짝임을 끕니다.",
	disableflash_name = "반짝임 끄기",
	Hidden = "숨김",
	Individual = "개인별",
	["Not Active Alpha"] = "비활성탭 투명도",
	preventdrag_desc = "마우스로 대화창 탭 이동하지 못하게 합니다.",
	preventdrag_name = "탭 이동방지",
	["Set ChatFrame%d Display Mode"] = "ChatFrame%d 표시모드 설정",
	["Set Display Mode"] = "표시모드 설정",
	["Sets alpha of chat tab for active chat frame."] = "활성화된 대화창 탭의 투명도를 설정합니다.",
	["Sets alpha of chat tab for not active chat frame."] = "비활성화된 대화창 탭의 투명도를 설정합니다.",
	["Set tab display mode for each chat window."] = "각각의 대화창에 대한 표시모드 설정",
	["Set tab display to always, hidden or the Blizzard default."] = "탭표시 설정(항상, 숨김, 와우기본값)",
	Tabs = "대화창탭",
}

)
L:AddLocale("esMX",  
{
	-- ["Active Alpha"] = "",
	-- All = "",
	-- Always = "",
	-- ["Chat window tab options."] = "",
	-- Default = "",
	-- disableflash_desc = "",
	-- disableflash_name = "",
	-- Hidden = "",
	-- Individual = "",
	-- ["Not Active Alpha"] = "",
	-- preventdrag_desc = "",
	-- preventdrag_name = "",
	-- ["Set ChatFrame%d Display Mode"] = "",
	-- ["Set Display Mode"] = "",
	-- ["Sets alpha of chat tab for active chat frame."] = "",
	-- ["Sets alpha of chat tab for not active chat frame."] = "",
	-- ["Set tab display mode for each chat window."] = "",
	-- ["Set tab display to always, hidden or the Blizzard default."] = "",
	-- Tabs = "",
}

)
L:AddLocale("ruRU",  
{
	["Active Alpha"] = "Прозрачность активной",
	All = "Все",
	Always = "Всегда",
	["Chat window tab options."] = "Настройки закладок чата.",
	Default = "По умолчанию",
	disableflash_desc = "Отключить мигание закладок чата.",
	disableflash_name = "Отключить мигание",
	Hidden = "Скрывать",
	Individual = "Индивидуально",
	["Not Active Alpha"] = "Прозрачность неактивных",
	preventdrag_desc = "Запретить перетаскивание закладок чата с помощью мыши",
	preventdrag_name = "Запретить перетаскивание",
	["Set ChatFrame%d Display Mode"] = "Установить режим отображения %d закладки",
	["Set Display Mode"] = "Режим отображения",
	["Sets alpha of chat tab for active chat frame."] = "Прозрачность активной закладки чата.",
	["Sets alpha of chat tab for not active chat frame."] = "Прозрачность неактивных закладок чата.",
	["Set tab display mode for each chat window."] = "Установить режим отображения каждой закладки окна чата. Отмеченно (вкл), Не отмеченно (выкл), Отмеченно серым (по умолчанию)",
	["Set tab display to always, hidden or the Blizzard default."] = "Установить режим отображения закладки на 'всегда показывать', 'скрывать' или 'поведение по умолчанию, как у Blizzard'.",
	Tabs = "Закладки",
}

)
L:AddLocale("zhCN",  
{
	["Active Alpha"] = "活跃的透明度",
	All = "全部",
	Always = "总是",
	["Chat window tab options."] = "聊天窗口页签选项",
	Default = "预设",
	disableflash_desc = "禁用聊天页签闪动",
	disableflash_name = "禁用闪动",
	Hidden = "隐藏",
	Individual = "个别",
	["Not Active Alpha"] = "非活跃的透明度",
	preventdrag_desc = "阻止聊天页签随鼠标拖动",
	preventdrag_name = "拖动阻止",
	["Set ChatFrame%d Display Mode"] = "设置聊天框%d显示模式",
	["Set Display Mode"] = "设置显示模式",
	["Sets alpha of chat tab for active chat frame."] = "设置活跃聊天框页签透明度",
	["Sets alpha of chat tab for not active chat frame."] = "设置非活跃聊天框页签透明度",
	["Set tab display mode for each chat window."] = "设置每个聊天窗口的页签显示模式.检查(开),不检查(关),暂停检查(预设)",
	["Set tab display to always, hidden or the Blizzard default."] = "设置页签永久显示,隐藏或暴雪预设",
	Tabs = "页签",
}

)
L:AddLocale("esES",  
{
	["Active Alpha"] = "Activar Transparencia",
	All = "Todo/s",
	Always = "Siempre",
	["Chat window tab options."] = "Opciones de la pestaña de la ventana de chat.",
	Default = "Predeterminado",
	disableflash_desc = "Deshabilitar destello de las pestañas del chat.",
	disableflash_name = "Desactivar Destello",
	Hidden = "Oculto",
	Individual = true,
	["Not Active Alpha"] = "No Activar Transparencia",
	preventdrag_desc = "Evitar arrastrar pestañas de chat con el ratón",
	preventdrag_name = "Evitar arrastrar",
	["Set ChatFrame%d Display Mode"] = "Establecer Modo de Visualización del Marco de Chat %d",
	["Set Display Mode"] = "Establecer Modo Visualización",
	["Sets alpha of chat tab for active chat frame."] = "Establece la transparencia de la pestaña de chat para el marco activo.",
	["Sets alpha of chat tab for not active chat frame."] = "Establece la transparencia de la pestaña de chat para el marco no activo.",
	["Set tab display mode for each chat window."] = "Establecer modo de pantalla de la pestaña para cada ventana de chat. Marcado (encendido), Desmarcado (apagado), Deshabilitado (predeterminado)",
	["Set tab display to always, hidden or the Blizzard default."] = "Establecer mostrar pestaña a siempre, oculta o por defecto (Blizzard).",
	Tabs = "Pestañas",
}

)
L:AddLocale("zhTW",  
{
	["Active Alpha"] = "使用中透明度",
	All = "所有",
	Always = "總是",
	["Chat window tab options."] = "聊天視窗標籤選單",
	Default = "預設值",
	disableflash_desc = "停用聊天標籤閃爍",
	disableflash_name = "停用閃爍",
	Hidden = "隱藏",
	Individual = "個人",
	["Not Active Alpha"] = "非使用中透明度",
	preventdrag_desc = "預防以滑鼠拖曳聊天標籤",
	preventdrag_name = "防止拖曳",
	["Set ChatFrame%d Display Mode"] = "設定聊天框架 %d 的顯示模式",
	["Set Display Mode"] = "設定顯示模式",
	["Sets alpha of chat tab for active chat frame."] = "設定使用中聊天視窗標籤透明度",
	["Sets alpha of chat tab for not active chat frame."] = "設定非使用中聊天視窗標籤透明度",
	["Set tab display mode for each chat window."] = "為個別聊天標籤顯示模式設定. 核選（啟用），取消（停用），灰階（預設值）",
	["Set tab display to always, hidden or the Blizzard default."] = "設定是否顯示聊天標籤或者是 Blizzard預設值",
	Tabs = "標籤",
}

)
--@end-non-debug@


local module = Prat:NewModule(PRAT_MODULE, "AceHook-3.0")

Prat:SetModuleDefaults(module.name, {
	profile = {
        on = true,
        displaymode = { },
        disableflash = false,
        notactivealpha = 0,
        activealpha = 0,
		preventdrag = false,
	}
} )

--module.toggleOptions = { sep115_sep = 115, disableflash = 120, preventdrag = 125 }

Prat:SetModuleOptions(module.name, {
        name = L["Tabs"],
        desc = L["Chat window tab options."],
        type = "group",
        args = {
            displaymode = {
                name = L["Set Display Mode"],
                desc = L["Set tab display mode for each chat window."],
                type = "multiselect",
				tristate = true,
                order = 110,
				values = Prat.FrameList,
				get = "GetSubValue",
				set = "SetSubValue",
			},
			disableflash = {
				name = L["disableflash_name"],
				desc = L["disableflash_desc"],
				type = "toggle",
				order = 120
			},
			preventdrag = {
				name = L["preventdrag_name"],
				desc = L["preventdrag_desc"],
				type = "toggle",
				order = 120
			},
            activealpha = {
                name = L["Active Alpha"],
                desc = L["Sets alpha of chat tab for active chat frame."],
                type = "range",
                order = 130,
                min = 0.0,
                max = 1,
                step = 0.1,
            },
            notactivealpha = {
                name = L["Not Active Alpha"],
                desc = L["Sets alpha of chat tab for not active chat frame."],
                type = "range",
                order = 140,
                min = 0.0,
                max = 1,
                step = 0.1,
            },
        }
    }
)

--local tabmode = { ["true"] = "ALWAYS", ["false"] = "HIDDEN", ["nil"] = "DEFAULT" }

--[[------------------------------------------------
    Module Event Functions
------------------------------------------------]]--

-- things to do when the module is enabled
function module:OnModuleEnable()
    self:SecureHook("FCF_StartAlertFlash")

    self:HookedMode(true)

    self:UpdateAllTabs()
    
    


end

-- things to do when the module is enabled
function module:OnModuleDisable()
    self:RemoveHooks()
end

--[[------------------------------------------------
    Core Functions
------------------------------------------------]]--


function module:HookedMode(hooked)
    if hooked then
        self:RawHook("FCF_Close", true)
        self:InstallHooks()
        Prat.UnregisterChatEvent(self, Prat.Events.POST_ADDMESSAGE) 
    else
        self:RemoveHooks()
        Prat.RegisterChatEvent(self, Prat.Events.POST_ADDMESSAGE)   
    end
end


local needToHook = {}

function module:InstallHooks()
    for k, v in pairs(Prat.Frames) do
        local cftab = _G[k.."Tab"]
        self:HookScript(cftab, "OnShow", "OnTabShow")
        if cftab:IsShown() then
            self:HookScript(cftab, "OnHide", "OnTabHide")
            needToHook[cftab] = nil
        else
            needToHook[cftab] = true
        end
		self:HookScript(cftab,"OnDragStart", "OnTabDragStart")
    end
end

function module:RemoveHooks()
	for k, v in pairs(Prat.Frames) do
        local cftab = getglobal(k.."Tab")
        cftab:SetScript("OnShow", function() return end)
        cftab:SetScript("OnHide", function() return end)
    end
    -- unhook functions
    self:UnhookAll()
end

function module:OnValueChanged(info, b)
--	if info[#info]:find("alpha") then
--		
--		return
--	end
	
	self:UpdateAllTabs()
end

function module:OnSubValueChanged(info, b)
	self:UpdateAllTabs()
end

function module:Prat_PostAddMessage(info, message, frame, event, text, r, g, b, id)
    frame.tellTimer = GetTime() + CHAT_TELL_ALERT_TIME;
    FCF_FlashTab(frame)
end

function module:UpdateAllTabs()
    CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = self.db.profile.activealpha;
    CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = self.db.profile.notactivealpha; 
    
    for k,v in pairs(Prat.Frames) do 
        if FCF_IsValidChatFrame(v) then
            
            local chatTab = _G[k.."Tab"]
            chatTab:Show()
            chatTab:Hide()
            FloatingChatFrame_Update(v:GetID()) 
            
            chatTab.mouseOverAlpha = CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA;            
	        chatTab.noMouseAlpha = CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA;
            
            -- Prevent an error in FloatingChatFrame FCF_FadeOutChatFrame() (blizz bug)
            chatTab:SetAlpha(chatTab:GetAlpha() or 0)
            v:SetAlpha(v:GetAlpha() or 0)

            FCF_FadeOutChatFrame(v)
        end
    end
end

function module:OnTabShow(tab, ...)
    if needToHook[tab] then
        self:HookScript(tab, "OnHide", "OnTabHide")
        needToHook[tab] = nil
    end

    if self.db.profile.displaymode["ChatFrame"..tab:GetID()] == false then
       tab:Hide()
    end  
end

function module:OnTabHide(tab, ...)    
    local p = self.db.profile
    local i = tab:GetID()   
    
	if self.db.profile.displaymode["ChatFrame"..tab:GetID()] == true then
        tab:Show()
        if SELECTED_CHAT_FRAME:GetID() == i then
            tab:SetAlpha(p.activealpha)
        else
            tab:SetAlpha(p.notactivealpha)
        end
    end      
end

function module:OnTabDragStart(this, ...)  
    local p = self.db.profile
    
    if p.preventdrag and p.on then return end
    
    self.hooks[this].OnDragStart(this, ...)
end



function module:FCF_StartAlertFlash(this)
    if self.db.profile.disableflash  then 
        FCF_StopAlertFlash(this)        
    end
end

function module:FCF_Close(frame, fallback)
    local tab = _G[frame:GetName().."Tab"]

   -- print(frame, fallback, tab)
    if tab then
        self:Unhook(tab, "OnHide")
        needToHook[tab] = true
    end

    self.hooks.FCF_Close(frame, fallback)
end


  return
end ) -- Prat:AddModuleToLoad