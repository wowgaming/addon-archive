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
Revision: $Revision: 80703 $
Author(s): Curney (asml8ed@gmail.com)
           Krtek (krtek4@gmail.com)
Inspired by: idChat2_TellTarget by Industrial
             ChatFrameExtender by Satrina
Website: http://www.wowace.com/files/index.php?path=Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#TellTarget
SVN: http://svn.wowace.com/wowace/trunk/Prat/
Description: Module for Prat that adds a slash command (/tt) to send a message to your target (default=on).
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("TellTarget")

if PRAT_MODULE == nil then 
    return 
end

local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
    ["TellTarget"] = true,
    ["Adds telltarget slash command (/tt)."] = true,
    ["Target does not exist."] = true,
    ["Target is not a player."] = true,
    ["No target selected."] = true,
    ["NoTarget"] = true,
	["/tt"] = true,
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	["Adds telltarget slash command (/tt)."] = true,
	NoTarget = true,
	["No target selected."] = true,
	["Target does not exist."] = true,
	["Target is not a player."] = true,
	TellTarget = true,
	["/tt"] = true,
}

)
L:AddLocale("frFR",  
{
	-- ["Adds telltarget slash command (/tt)."] = "",
	NoTarget = "PasDeCible",
	["No target selected."] = "Pas de cible sélectionnée.",
	["Target does not exist."] = "La cible n'existe pas.",
	["Target is not a player."] = "La cible n'est pas un joueur.",
	TellTarget = true,
	["/tt"] = true,
}

)
L:AddLocale("deDE", 
{
	["Adds telltarget slash command (/tt)."] = "Fügt das Slash-Kommando TellTarget (/tt) hinzu",
	NoTarget = "KeinZiel",
	["No target selected."] = "Kein Ziel ausgewählt.",
	["Target does not exist."] = "Ziel existiert nicht.",
	["Target is not a player."] = "Ziel ist kein Spieler.",
	TellTarget = true,
	["/tt"] = true,
}

)
L:AddLocale("koKR",  
{
	["Adds telltarget slash command (/tt)."] = "대상에게 말하기 슬래쉬 명령어를 추가합니다 (/tt).",
	NoTarget = "대상없음",
	["No target selected."] = "대상이 선택되지 않았습니다.",
	["Target does not exist."] = "대상이 존재하지 않습니다.",
	["Target is not a player."] = "대상이 플레이어가 아닙니다.",
	TellTarget = "대상에게말하기",
	["/tt"] = true,
}

)
L:AddLocale("esMX",  
{
	-- ["Adds telltarget slash command (/tt)."] = "",
	-- NoTarget = "",
	-- ["No target selected."] = "",
	-- ["Target does not exist."] = "",
	-- ["Target is not a player."] = "",
	-- TellTarget = "",
	-- ["/tt"] = "",
}

)
L:AddLocale("ruRU",  
{
	["Adds telltarget slash command (/tt)."] = "Добавляет слеш-команду 'сказать о цели' (/tt).",
	NoTarget = "Нет цели",
	["No target selected."] = "Нет выбранной цели.",
	["Target does not exist."] = "Цель не существует.",
	["Target is not a player."] = "Выбранная цель не является игроком.",
	TellTarget = "Сказать цели",
	["/tt"] = true,
}

)
L:AddLocale("zhCN",  
{
	["Adds telltarget slash command (/tt)."] = "添加目标告知斜杠命令(/tt).",
	NoTarget = "无目标",
	["No target selected."] = "无目标被选取",
	["Target does not exist."] = "目标不存在",
	["Target is not a player."] = "目标不是一个玩家",
	TellTarget = "告知目标",
	["/tt"] = true,
}

)
L:AddLocale("esES",  
{
	["Adds telltarget slash command (/tt)."] = "Añade comando decir a objetivo (/tt).",
	NoTarget = "SinObjetivo",
	["No target selected."] = "Sin objetivo seleccionado.",
	["Target does not exist."] = "El Objetivo no existe.",
	["Target is not a player."] = "El Objetivo no es un jugador.",
	TellTarget = "DecirObjetivo",
	["/tt"] = true,
}

)
L:AddLocale("zhTW",  
{
	["Adds telltarget slash command (/tt)."] = "新增 telltarget 快捷命令（/tt）",
	NoTarget = "沒有目標",
	["No target selected."] = "未選取目標",
	["Target does not exist."] = "目標並不存在",
	["Target is not a player."] = "目標並不是玩家",
	TellTarget = true,
	-- ["/tt"] = "",
}

)
--@end-non-debug@




----[[
--	Chinese Local : CWDG Translation Team 昏睡墨鱼 (Thomas Mo)
--	CWDG site: http://Cwowaddon.com
--	$Rev: 80703 $
--]]
--

--

--

--

--

--




-- create prat module
local module = Prat:NewModule(PRAT_MODULE, "AceHook-3.0")

Prat:SetModuleDefaults(module.name, {
	profile = {
	    on = true,
	}
} )

Prat:SetModuleOptions(module.name, {
        name = L["TellTarget"],
        desc = L["Adds telltarget slash command (/tt)."],
        type = "group",
        args = {
			info = {
				name = L["Adds telltarget slash command (/tt)."],
				type = "description",
			}
        }
    }
)

--[[------------------------------------------------
    Module Event Functions
------------------------------------------------]]--
function module:OnModuleEnable()
    self:HookScript(ChatFrame1EditBox, "OnTextChanged")
end

function module:OnModuleDisable()
	self:UnhookAll()
end

--[[------------------------------------------------
	Core Functions
------------------------------------------------]]--
function module:OnTextChanged(editBox, ...)
    local command, msg = editBox:GetText():match("^(/%S+)%s(.*)$")
    if command == "/tt" or command == L["/tt"] then
        self:SendTellToTarget(editBox.chatFrame, msg, editBox)
    end
    self.hooks[editBox].OnTextChanged(editBox, ...)
end

function module:SendTellToTarget(frame, text, editBox)
	if frame == nil then frame = DEFAULT_CHAT_FRAME end

	local unitname, realm, fullname
    if UnitIsPlayer("target") then
        unitname, realm = UnitName("target")
        if unitname then 
            if realm and not UnitIsSameServer("player", "target") then
                fullname = unitname.."-"..realm
            else
                fullname = unitname
            end
        end
    end
    
    local target = fullname and fullname:gsub(" ", "") or L["NoTarget"]
    
    if editBox then
    	editBox:SetAttribute("chatType", "WHISPER");
    	editBox:SetAttribute("tellTarget", target);
    	editBox:SetText(text)
    	ChatEdit_UpdateHeader(editBox);
    else
    	ChatFrame_SendTell(target, frame)
    end
end

local function TellTarget(msg)
	module:SendTellToTarget(SELECTED_CHAT_FRAME, msg)
end


-- TODO: set slash command
--SlashCmdList["module"] = TellTarget
--SLASH_module1 = "/tt"
--SLASH_module2 = L["/tt"]


  return
end ) -- Prat:AddModuleToLoad