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
Name: PratChatFrames
Revision: $Revision: 80703 $
Author(s): Curney (asml8ed@gmail.com)
           Sylvanaar (sylvanaar@mindspring.com)
Website: http://www.wowace.com/files/index.php?path=Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#ChatFrames
Subversion: http://svn.wowace.com/wowace/trunk/Prat/
Discussions: http://groups.google.com/group/wow-prat
Issues and feature requests: http://code.google.com/p/prat/issues/list
Description: Module for Prat that adds options for changing chat window parameters.
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

local Prat = Prat

local PRAT_MODULE = Prat:RequestModuleName("Frames")

if PRAT_MODULE == nil then 
    return 
end

local L = Prat.GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
    ["Frames"] = true,
    ["Chat window frame parameter options"] = true,
    ["removeclamp_name"] = "Zero Clamp Size",
    ["removeclamp_desc"] = "Allow the chatframe to be moved flush with the edge of the screen",
    ["minchatwidth_name"] = "Set Minimum Width",
    ["minchatwidth_desc"] = "Sets the minimum width for all chat windows.",
    ["maxchatwidth_name"] = "Set Maximum Width",
    ["maxchatwidth_desc"] = "Sets the maximum width for all chat windows.",
    ["minchatheight_name"] = "Set Minimum Height",
    ["minchatheight_desc"] = "Sets the minimum height for all chat windows.",
    ["maxchatheight_name"] = "Set Maximum Height",
    ["maxchatheight_desc"] = "Sets the maximum height for all chat windows.",
    ["mainchatonload_name"] = "Force Main Chat Frame On Load",
    ["mainchatonload_desc"] = "Automatically select the first chat frame and make it active on load.",
	["framealpha_name"] = "Set Chatframe Alpha",
	["framealpha_desc"] = "Conrols the transparency of the chatframe when you hover over it with your mouse.",
} )
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/

--@non-debug@
L:AddLocale("enUS", 
{
	["Chat window frame parameter options"] = true,
	framealpha_desc = "Conrols the transparency of the chatframe when you hover over it with your mouse.",
	framealpha_name = "Set Chatframe Alpha",
	Frames = true,
	mainchatonload_desc = "Automatically select the first chat frame and make it active on load.",
	mainchatonload_name = "Force Main Chat Frame On Load",
	maxchatheight_desc = "Sets the maximum height for all chat windows.",
	maxchatheight_name = "Set Maximum Height",
	maxchatwidth_desc = "Sets the maximum width for all chat windows.",
	maxchatwidth_name = "Set Maximum Width",
	minchatheight_desc = "Sets the minimum height for all chat windows.",
	minchatheight_name = "Set Minimum Height",
	minchatwidth_desc = "Sets the minimum width for all chat windows.",
	minchatwidth_name = "Set Minimum Width",
	removeclamp_desc = "Allow the chatframe to be moved flush with the edge of the screen",
	removeclamp_name = "Zero Clamp Size",
}

)
L:AddLocale("frFR",  
{
	-- ["Chat window frame parameter options"] = "",
	-- framealpha_desc = "",
	-- framealpha_name = "",
	-- Frames = "",
	-- mainchatonload_desc = "",
	-- mainchatonload_name = "",
	maxchatheight_desc = "Définir la hauteur maximale pour toutes les fenêtres de discussion.",
	maxchatheight_name = "Définir la hauteur maximale",
	maxchatwidth_desc = "Définir la largeur maximale pour toutes les fenêtres de discussion.",
	maxchatwidth_name = "Définir la largeur maximale",
	minchatheight_desc = "Définir la hauteur minimum pour toutes les fenêtres de discussion.",
	minchatheight_name = "Définir la hauteur minimum",
	minchatwidth_desc = "Définir la largeur minimum pour toutes les fenêtres de discussion.",
	minchatwidth_name = "Définir la largeur minimum",
	-- removeclamp_desc = "",
	-- removeclamp_name = "",
}

)
L:AddLocale("deDE", 
{
	["Chat window frame parameter options"] = "Optionen für Parameter des Chat-Fenster-Rahmens",
	framealpha_desc = "Steuert die Transparenz des Chat-Rahmens, wenn du die Maus darüberlegst.",
	framealpha_name = "Transparenz für Chatrahmen einstellen",
	Frames = "Rahmen",
	mainchatonload_desc = "Automatisch den ersten Chat-Rahmen auswählen und beim Laden aktivieren.",
	mainchatonload_name = "Erzwinge Haupt-Chat-Rahmen beim Laden",
	maxchatheight_desc = "Stellt die maximale Höhe für alle alle Chat-Fenster ein.",
	maxchatheight_name = "Maximale Höhe einstellen",
	maxchatwidth_desc = "Die maximale Breite für alle Chat-Fenster einstellen.",
	maxchatwidth_name = "Maximale Breite einstellen.",
	minchatheight_desc = "Die minimale Höhe für alle Chat-Fenster einstellen.",
	minchatheight_name = "Minimale Höhe einstellen",
	minchatwidth_desc = "Die minimale Breite für alle Chat-Fenster einstellen.",
	minchatwidth_name = "Minimale Breite einstellen.",
	-- removeclamp_desc = "",
	-- removeclamp_name = "",
}

)
L:AddLocale("koKR",  
{
	-- ["Chat window frame parameter options"] = "",
	-- framealpha_desc = "",
	framealpha_name = "대화창 투명도 설정",
	Frames = "대화창",
	-- mainchatonload_desc = "",
	-- mainchatonload_name = "",
	maxchatheight_desc = "모든 대화창의 최대 높이 설정",
	maxchatheight_name = "최대 높이 설정",
	maxchatwidth_desc = "모든 대화창의 최대 폭 설정",
	maxchatwidth_name = "최대 폭 설정",
	minchatheight_desc = "모든 대화창의 최소 높이 설정",
	minchatheight_name = "최소 높이 설정",
	minchatwidth_desc = "모든 대화창의 최소 폭 설정",
	minchatwidth_name = "최소 폭 설정",
	-- removeclamp_desc = "",
	-- removeclamp_name = "",
}

)
L:AddLocale("esMX",  
{
	-- ["Chat window frame parameter options"] = "",
	-- framealpha_desc = "",
	-- framealpha_name = "",
	-- Frames = "",
	-- mainchatonload_desc = "",
	-- mainchatonload_name = "",
	-- maxchatheight_desc = "",
	-- maxchatheight_name = "",
	-- maxchatwidth_desc = "",
	-- maxchatwidth_name = "",
	-- minchatheight_desc = "",
	-- minchatheight_name = "",
	-- minchatwidth_desc = "",
	-- minchatwidth_name = "",
	-- removeclamp_desc = "",
	-- removeclamp_name = "",
}

)
L:AddLocale("ruRU",  
{
	["Chat window frame parameter options"] = "Параметры окна чата",
	framealpha_desc = "Настройка прозрачности окна чата при наведении на него курсора мыши.",
	framealpha_name = "Прозрачность окна чата",
	-- Frames = "",
	mainchatonload_desc = "Автоматически выбирает первое окно чата, и делает его активным при загрузке.",
	mainchatonload_name = "Задействовать главное окно чата при загрузке", -- Needs review
	maxchatheight_desc = "Устанавливает максимальную высоту для всех окон чата.",
	maxchatheight_name = "Максимальная высоты",
	maxchatwidth_desc = "Устанавливает максимальную ширину для всех окон чата.",
	maxchatwidth_name = "Максимальная ширина",
	minchatheight_desc = "Устанавливает минимальную высоту для всех окон чата.",
	minchatheight_name = "Минимальная высоты",
	minchatwidth_desc = "Устанавливает минимальную ширину для всех окон чата.",
	minchatwidth_name = "Минимальная ширина",
	-- removeclamp_desc = "",
	-- removeclamp_name = "",
}

)
L:AddLocale("zhCN",  
{
	-- ["Chat window frame parameter options"] = "",
	-- framealpha_desc = "",
	-- framealpha_name = "",
	-- Frames = "",
	-- mainchatonload_desc = "",
	-- mainchatonload_name = "",
	-- maxchatheight_desc = "",
	-- maxchatheight_name = "",
	-- maxchatwidth_desc = "",
	-- maxchatwidth_name = "",
	-- minchatheight_desc = "",
	-- minchatheight_name = "",
	-- minchatwidth_desc = "",
	-- minchatwidth_name = "",
	-- removeclamp_desc = "",
	-- removeclamp_name = "",
}

)
L:AddLocale("esES",  
{
	-- ["Chat window frame parameter options"] = "",
	-- framealpha_desc = "",
	-- framealpha_name = "",
	-- Frames = "",
	-- mainchatonload_desc = "",
	-- mainchatonload_name = "",
	-- maxchatheight_desc = "",
	-- maxchatheight_name = "",
	-- maxchatwidth_desc = "",
	-- maxchatwidth_name = "",
	-- minchatheight_desc = "",
	-- minchatheight_name = "",
	-- minchatwidth_desc = "",
	-- minchatwidth_name = "",
	-- removeclamp_desc = "",
	-- removeclamp_name = "",
}

)
L:AddLocale("zhTW",  
{
	-- ["Chat window frame parameter options"] = "",
	-- framealpha_desc = "",
	-- framealpha_name = "",
	-- Frames = "",
	-- mainchatonload_desc = "",
	-- mainchatonload_name = "",
	-- maxchatheight_desc = "",
	-- maxchatheight_name = "",
	-- maxchatwidth_desc = "",
	maxchatwidth_name = "設定最大寬度",
	minchatheight_desc = "設定對話視窗最小高度",
	minchatheight_name = "設定最小高度",
	minchatwidth_desc = "設定對話視窗最小寬度",
	minchatwidth_name = "設定最小寬度",
	-- removeclamp_desc = "",
	-- removeclamp_name = "",
}

)
--@end-non-debug@


local mod = Prat:NewModule(PRAT_MODULE, "AceHook-3.0")

-- We have to set the insets here before blizzard has a chance to move them
for i = 1, NUM_CHAT_WINDOWS do
	local f = _G["ChatFrame" .. i]
	f:SetClampRectInsets(0, 0, 0, 0)
end


Prat:SetModuleDefaults(mod.name, {
	profile = {
        on = true,
        minchatwidth = 160,
        minchatwidthdefault = 160,
        maxchatwidth = 800,
        maxchatwidthdefault = 800,
        minchatheight = 120,
        minchatheightdefault = 120,
        maxchatheight = 600,
        maxchatheightdefault = 600,
        mainchatonload = true,
        framealpha = DEFAULT_CHATFRAME_ALPHA,
        removeclamp = true,
	}
})

do
	local frameoption = {
		name = function(info) return L[info[#info].."_name"] end,
		desc = function(info) return L[info[#info].."_desc"] end,
		type="range", min=25, max=1024, step=1
	}
	
	Prat:SetModuleOptions(mod.name, {
	        name = L["Frames"],
	        desc = L["Chat window frame parameter options"],
	        type = "group",
	        args = {
	    		minchatwidth = frameoption,
			    maxchatwidth = frameoption,
			    minchatheight = frameoption,
			    maxchatheight = frameoption,
			    removeclamp = {
                type = "toggle", 
                    order = 110, 
                	name = L["removeclamp_name"],
                	desc = L["removeclamp_desc"],    
                },
			    framealpha = {
					name = L["framealpha_name"],
					desc = L["framealpha_desc"],
					type="range", min=0.0, max=1.0, step=.01, order=190,
				},
	--		    mainchatonload = 200,
	        }
	    }
	)
end


--[[------------------------------------------------
    Module Event Functions
------------------------------------------------]]--

Prat:SetModuleInit(mod, function(self) mod:GetDefaults() end)

function mod:OnModuleEnable()
    CHAT_FRAME_BUTTON_FRAME_MIN_ALPHA = 0
    self:ConfigureAllChatFrames(true)
    self:RawHook("FCF_DockFrame", true)
end

function mod:OnModuleDisable()
    CHAT_FRAME_BUTTON_FRAME_MIN_ALPHA = 0.2
    self:ConfigureAllChatFrames(false)
end
function mod:FCF_DockFrame(frame, ...)
    if self.db.profile.removeclamp then
        frame:SetClampRectInsets(0,0,0,0)
    end
   Prat.Frames[frame:GetName()] = frame
   local m = Prat.Addon:GetModule("Font", true)
   if m then m:ConfigureAllChatFrames() end
   return self.hooks["FCF_DockFrame"](frame, ...)
end

--[[------------------------------------------------
    Core Functions
------------------------------------------------]]--

-- make ChatFrame1 the selected chat frame
function mod:AceEvent_FullyInitialized()
    if self.db.profile.mainchatonload then
        FCF_SelectDockFrame(ChatFrame1)
    end
end

-- set parameters for each chatframe
function mod:ConfigureAllChatFrames(enabled)
    for _,v in pairs(Prat.Frames) do
        self:SetParameters(v, enabled)
    end
    
    DEFAULT_CHATFRAME_ALPHA = self.db.profile.framealpha
end

-- get the defaults for chat frame1 max/min width/height for use when disabling the module
function mod:GetDefaults()
    local cf = _G["ChatFrame1"]
	local prof = self.db.profile

    local minwidthdefault, minheightdefault = cf:GetMinResize()
    local maxwidthdefault, maxheightdefault = cf:GetMaxResize()

    prof.minchatwidthdefault = minwidthdefault
    prof.maxchatwidthdefault = maxwidthdefault
    prof.minchatheightdefault = minheightdefault
    prof.maxchatheightdefault = maxheightdefault

    prof.initialized = true
end

-- set the max/min width/height for a chatframe
function mod:SetParameters(cf, enabled)
	local prof = self.db.profile
    if enabled then
        cf:SetMinResize(prof.minchatwidth, prof.minchatheight)
        cf:SetMaxResize(prof.maxchatwidth, prof.maxchatheight)
    
        if prof.removeclamp then
            cf:SetClampRectInsets(0,0,0,0)
        end
    else
        cf:SetMinResize(prof.minchatwidthdefault, prof.minchatheightdefault)
        cf:SetMaxResize(prof.maxchatwidthdefault, prof.maxchatheightdefault)
    end
    
    
end


function mod:OnValueChanged()
	self:ConfigureAllChatFrames(true)
end

  return
end ) -- Prat:AddModuleToLoad