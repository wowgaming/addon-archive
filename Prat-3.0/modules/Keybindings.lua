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
Name: PratKeyBindings
Revision: $Revision: 80432 $
Author(s): Curney (asml8ed@gmail.com)
           Krtek (krtek4@gmail.com)
Website: http://www.wowace.com/files/index.php?path=Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#KeyBindings
SVN: http://svn.wowace.com/wowace/trunk/Prat/
Description: Module for Prat that adds keybindings for modules.
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

-- Get Utility Libraries
local PRAT_MODULE = Prat:RequestModuleName("KeyBindings")

if PRAT_MODULE == nil then 
    return 
end

local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
    ["Prat Keybindings"] = true,
    ["Officer Channel"] = true,
	["Guild Channel"] = true,
	["Party Channel"] = true,
	["Raid Channel"] = true,
    ["Raid Warning Channel"] = true,
    ["Battleground Channel"] = true,
    ["Say"] = true,
    ["Yell"] = true,
    ["Whisper"] = true,
    ["Channel %d"] = true,
	["Prat TellTarget"] = true,
    ["TellTarget"] = true,
    ["Prat CopyChat"] = true,
    ["Copy Selected Chat Frame"] = true,
    ["Smart Group Channel"] = true,
    ["Next Chat Tab"] = true
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	["Battleground Channel"] = true,
	["Channel %d"] = true,
	["Copy Selected Chat Frame"] = true,
	["Guild Channel"] = true,
	["Next Chat Tab"] = true,
	["Officer Channel"] = true,
	["Party Channel"] = true,
	["Prat CopyChat"] = true,
	["Prat Keybindings"] = true,
	["Prat TellTarget"] = true,
	["Raid Channel"] = true,
	["Raid Warning Channel"] = true,
	Say = true,
	["Smart Group Channel"] = true,
	TellTarget = true,
	Whisper = true,
	Yell = true,
}

)
L:AddLocale("frFR",  
{
	["Battleground Channel"] = "Canal Champ de bataille",
	["Channel %d"] = "Canal %d",
	["Copy Selected Chat Frame"] = "Copier la fenêtre de Chat sélectionné",
	["Guild Channel"] = "Canal de Guilde",
	-- ["Next Chat Tab"] = "",
	["Officer Channel"] = "Canal Officier",
	["Party Channel"] = "Canal de Groupe",
	["Prat CopyChat"] = "Prat Copier-le-Chat",
	["Prat Keybindings"] = "Prat Association-de-touche",
	["Prat TellTarget"] = "Prat Dire-à-la-cible",
	["Raid Channel"] = "Canal Raid",
	["Raid Warning Channel"] = "Canal Avertissement",
	Say = "Dire",
	-- ["Smart Group Channel"] = "",
	-- TellTarget = "",
	Whisper = "Chuchoter",
	-- Yell = "",
}

)
L:AddLocale("deDE", 
{
	["Battleground Channel"] = "Schlachtfeld-Kanal",
	["Channel %d"] = "Kanal %d",
	["Copy Selected Chat Frame"] = "Kopiere ausgewählte Chat-Rahmen",
	["Guild Channel"] = "Gildenkanal",
	["Next Chat Tab"] = "Nächster Chat-Tab",
	["Officer Channel"] = "Offizierskanal",
	["Party Channel"] = "Gruppenkanal",
	["Prat CopyChat"] = true,
	["Prat Keybindings"] = true,
	["Prat TellTarget"] = true,
	["Raid Channel"] = "Schlachtzugskanal",
	["Raid Warning Channel"] = "Schlachtzugswarnkanal",
	Say = true,
	["Smart Group Channel"] = "Intelligenter Gruppenkanal",
	TellTarget = true,
	Whisper = true,
	Yell = true,
}

)
L:AddLocale("koKR",  
{
	["Battleground Channel"] = "전장",
	["Channel %d"] = "채널 %d",
	["Copy Selected Chat Frame"] = "선택한 대화창 복사",
	["Guild Channel"] = "길드",
	["Next Chat Tab"] = "다음 채팅 탭",
	["Officer Channel"] = "관리자",
	["Party Channel"] = "파티",
	["Prat CopyChat"] = "Prat 대화창복사",
	["Prat Keybindings"] = "Prat 단축키",
	["Prat TellTarget"] = "Prat 대상대화",
	["Raid Channel"] = "공격대",
	["Raid Warning Channel"] = "공격대 경보",
	Say = "대화",
	["Smart Group Channel"] = "스마트 파티",
	TellTarget = "대상대화",
	Whisper = "귓속말",
	Yell = "외치기",
}

)
L:AddLocale("esMX",  
{
	-- ["Battleground Channel"] = "",
	-- ["Channel %d"] = "",
	-- ["Copy Selected Chat Frame"] = "",
	-- ["Guild Channel"] = "",
	-- ["Next Chat Tab"] = "",
	-- ["Officer Channel"] = "",
	-- ["Party Channel"] = "",
	-- ["Prat CopyChat"] = "",
	-- ["Prat Keybindings"] = "",
	-- ["Prat TellTarget"] = "",
	-- ["Raid Channel"] = "",
	-- ["Raid Warning Channel"] = "",
	-- Say = "",
	-- ["Smart Group Channel"] = "",
	-- TellTarget = "",
	-- Whisper = "",
	-- Yell = "",
}

)
L:AddLocale("ruRU",  
{
	["Battleground Channel"] = "Канал полей сражений",
	["Channel %d"] = "Канал %d",
	["Copy Selected Chat Frame"] = "Копирование выбранного окна чата",
	["Guild Channel"] = "Канал Гильдии",
	["Next Chat Tab"] = "Следующее окно чата",
	["Officer Channel"] = "Офицерский Канал",
	["Party Channel"] = "Канал Группы",
	["Prat CopyChat"] = "Копирование чата Prat",
	["Prat Keybindings"] = true,
	["Prat TellTarget"] = "Prat Сказать обьекту",
	["Raid Channel"] = "Канал Рейда",
	["Raid Warning Channel"] = "Канал объявлений рейду",
	Say = "Сказать",
	["Smart Group Channel"] = "Групирование каналов",
	TellTarget = "Сказать обьекту",
	Whisper = "Шепнуть",
	Yell = "Крикнуть",
}

)
L:AddLocale("zhCN",  
{
	["Battleground Channel"] = "战场频道",
	["Channel %d"] = "频道 %d",
	["Copy Selected Chat Frame"] = "复制选定的聊天框体",
	["Guild Channel"] = "公会频道",
	-- ["Next Chat Tab"] = "",
	["Officer Channel"] = "官员频道",
	["Party Channel"] = "小队频道",
	["Prat CopyChat"] = "Prat聊天复制",
	["Prat Keybindings"] = "Prat键位绑定",
	["Prat TellTarget"] = "Prat目标告知",
	["Raid Channel"] = "团队频道",
	["Raid Warning Channel"] = "团队警告频道",
	Say = "说",
	["Smart Group Channel"] = "频道智能分组",
	TellTarget = "目标告知",
	Whisper = "密语",
	Yell = "喊话",
}

)
L:AddLocale("esES",  
{
	["Battleground Channel"] = "Canal Campo de Batalla",
	["Channel %d"] = "Canal %d",
	["Copy Selected Chat Frame"] = "Copiar el Marco de Chat Seleccionado",
	["Guild Channel"] = "Canal de Hermandad",
	["Next Chat Tab"] = "Siguiente Pestaña de Chat",
	["Officer Channel"] = "Canal Oficial",
	["Party Channel"] = "Canal del Grupo",
	["Prat CopyChat"] = "Prat ChatCopiar",
	["Prat Keybindings"] = "Combinaciones de teclas Prat",
	["Prat TellTarget"] = "Prat DecirObjetivo",
	["Raid Channel"] = "Canal de Banda",
	["Raid Warning Channel"] = "Canal Aviso de Banda",
	Say = "Decir",
	["Smart Group Channel"] = "Canal de Grupo Inteligente",
	TellTarget = "DecirObjetivo",
	Whisper = "Susurrar",
	Yell = "Gritar",
}

)
L:AddLocale("zhTW",  
{
	["Battleground Channel"] = "戰場頻道",
	["Channel %d"] = "頻道 %d",
	["Copy Selected Chat Frame"] = "複製選取的聊天視窗",
	["Guild Channel"] = "公會頻道",
	["Next Chat Tab"] = "次個聊天標籤",
	["Officer Channel"] = "幹部頻道",
	["Party Channel"] = "小隊頻道",
	["Prat CopyChat"] = "Prat 聊天複製",
	["Prat Keybindings"] = "Prat按鍵綁定",
	["Prat TellTarget"] = true,
	["Raid Channel"] = "團隊頻道",
	["Raid Warning Channel"] = "團隊警告頻道",
	Say = "說",
	["Smart Group Channel"] = "按鍵綁定",
	TellTarget = true,
	Whisper = "密語",
	Yell = "大喊",
}

)
--@end-non-debug@




----[[
--	Chinese Local : CWDG Translation Team 昏睡墨鱼 (Thomas Mo)
--	CWDG site: http://Cwowaddon.com
--	$Rev: 80432 $
--]]
--

--

--

--

--

--


local module = Prat:NewModule(PRAT_MODULE)

Prat:SetModuleInit(module, 
	function(self)
		BINDING_HEADER_Prat = L["Prat Keybindings"]
		BINDING_NAME_officer = L["Officer Channel"]
		BINDING_NAME_guild = L["Guild Channel"]
		BINDING_NAME_party = L["Party Channel"]
		BINDING_NAME_raid = L["Raid Channel"]
		BINDING_NAME_raidwarn = L["Raid Warning Channel"]
		BINDING_NAME_battleground = L["Battleground Channel"]
		BINDING_NAME_say = L["Say"]
		BINDING_NAME_yell = L["Yell"]
		BINDING_NAME_whisper = L["Whisper"]
		BINDING_NAME_one = (L["Channel %d"]):format(1)
		BINDING_NAME_two = (L["Channel %d"]):format(2)
		BINDING_NAME_three = (L["Channel %d"]):format(3)
		BINDING_NAME_four = (L["Channel %d"]):format(4)
		BINDING_NAME_five = (L["Channel %d"]):format(5)
		BINDING_NAME_six = (L["Channel %d"]):format(6)
		BINDING_NAME_seven = (L["Channel %d"]):format(7)
		BINDING_NAME_eight = (L["Channel %d"]):format(8)
		BINDING_NAME_nine = (L["Channel %d"]):format(9)
		BINDING_NAME_SmartGroup = L["Smart Group Channel"]
--	    BINDING_HEADER_Prat_TellTarget = L["Prat TellTarget"]
--	    BINDING_HEADER_Prat_CopyChat = L["Prat CopyChat"]
        BINDING_NAME_NextTab = L["Next Chat Tab"]
	    BINDING_NAME_CopySelected = L["Copy Selected Chat Frame"]
	end
)

-- /script keybindings:CycleChatTabs()
function module:CycleChatTabs()
    local current = SELECTED_DOCK_FRAME
    local idx
    for i, v in ipairs(DOCKED_CHAT_FRAMES) do
        if v == current then
            idx = i
        end
    end

    if idx == nil then return end

    idx = idx + 1
    if DOCKED_CHAT_FRAMES[idx] == nil then
        idx = 1
    end

    FCF_SelectDockFrame(DOCKED_CHAT_FRAMES[idx])
end

  return
end ) -- Prat:AddModuleToLoad