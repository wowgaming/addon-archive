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
Name: PratPlayerNames
Author(s): Curney (asml8ed@gmail.com)
           Krtek (krtek4@gmail.com)
		   Sylvanaar (sylvanaar@mindspring.com)
Inspired by: idChat2_PlayerNames by Industrial
Description: Module for Prat that adds player name options.
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("PlayerNames")

if PRAT_MODULE == nil then 
    return 
end

-- define localized strings
local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
    ["PlayerNames"] = true,
    ["Player name formating options."] = true,
    ["Brackets"] = true,
    ["Square"] = true,
    ["Angled"] = true,
    ["None"] = true,
    ["Class"] = true,
    ["Random"] = true,
	["Reset Settings"] = true,
	["No additional coloring"] = true,
	["Restore default settings, and delete stored character data."] = true,
    ["Sets style of brackets to use around player names."] = true,
    ["Unknown Use Common Color"] = true,
    ["Toggle using a common color for unknown player names."] = true,
    ["Unknown Common Color"] = true,
    ["Set common color of unknown player names."] = true,
    ["Enable TabComplete"] = true,
    ["Toggle tab completion of player names."] = true,
	["Show Level"] = true,
    ["Toggle level showing."] = true,
    ["Level Color Mode"] = true,
    ["Use Player Color"] = true, 
    ["Use Channel Color"]  = true, 
    ["Color by Level Difference"] = true,
    ["How to color other player's level."] = true,
	["Show Group"] = true,
    ["Toggle raid group showing."] = true,
	["Show Raid Target Icon"] = true,
	["Toggle showing the raid target icon which is currently on the player."] = true,

	-- In the high-cpu pullout
	["coloreverywhere_name"] = "Color Names Everywhere",
	["coloreverywhere_desc"] = "Color player names if they appear in the text of the chat message",

    ["hoverhilight_name"] = "Hover Hilighting",
	["hoverhilight_desc"] = "Hilight chat lines from a specific player when hovering over thier playerlink",

    ["realidcolor_name"] = "RealID Coloring",
    ["realidcolor_desc"] = "RealID Name Coloring",

    ["Keep Info"] = true,
    ["Keep Lots Of Info"] = true,
    ["Keep player information between session for all players except cross-server players"] = true,
    ["Keep player information between session, but limit it to friends and guild members."] = true,
    ["Player Color Mode"] = true,
    ["How to color player's name."] = true,
	["Unknown Common Color From TasteTheNaimbow"] = true,
    ["Let TasteTheNaimbow set the common color for unknown player names."] = true,   
	["Enable Alt-Invite"] = true,
    ["Toggle group invites by alt-clicking on player name."] = true,
    ["Enable Invite Links"] = true,
	["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = true,
    ["Brackets Common Color"] = true,
    ["Sets common color of brackets to use around player names."] = true,
    ["Brackets Use Common Color"] = true,
    ["Toggle using a common color for brackets around player names."] = true,
    ["linkifycommon_name"] = "Linkify Common Messages",
    ["linkifycommon_desc"] = "Linkify Common Messages",
    ["Prat_Playernames: Stored Player Data Cleared"] = true,

	["tabcomplete_name"] = "Possible Names",
    ["Tab completion : "] = true,
    ["Too many matches (%d possible)"] = true,
    ["Actively Query Player Info"] = true,
    ["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = true,    
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	["Actively Query Player Info"] = true,
	Angled = true,
	Brackets = true,
	["Brackets Common Color"] = true,
	["Brackets Use Common Color"] = true,
	Class = true,
	["Color by Level Difference"] = true,
	coloreverywhere_desc = "Color player names if they appear in the text of the chat message",
	coloreverywhere_name = "Color Names Everywhere",
	["Enable Alt-Invite"] = true,
	["Enable Invite Links"] = true,
	["Enable TabComplete"] = true,
	hoverhilight_desc = "Hilight chat lines from a specific player when hovering over thier playerlink",
	hoverhilight_name = "Hover Hilighting",
	["How to color other player's level."] = true,
	["How to color player's name."] = true,
	["Keep Info"] = true,
	["Keep Lots Of Info"] = true,
	["Keep player information between session, but limit it to friends and guild members."] = true,
	["Keep player information between session for all players except cross-server players"] = true,
	["Let TasteTheNaimbow set the common color for unknown player names."] = true,
	["Level Color Mode"] = true,
	linkifycommon_desc = "Linkify Common Messages",
	linkifycommon_name = "Linkify Common Messages",
	["No additional coloring"] = true,
	None = true,
	["Player Color Mode"] = true,
	["Player name formating options."] = true,
	PlayerNames = true,
	["Prat_Playernames: Stored Player Data Cleared"] = true,
	["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = true,
	Random = true,
	realidcolor_desc = "RealID Name Coloring",
	realidcolor_name = "RealID Coloring",
	["Reset Settings"] = true,
	["Restore default settings, and delete stored character data."] = true,
	["Set common color of unknown player names."] = true,
	["Sets common color of brackets to use around player names."] = true,
	["Sets style of brackets to use around player names."] = true,
	["Show Group"] = true,
	["Show Level"] = true,
	["Show Raid Target Icon"] = true,
	Square = true,
	tabcomplete_name = "Possible Names",
	["Tab completion : "] = true,
	["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = true,
	["Toggle group invites by alt-clicking on player name."] = true,
	["Toggle level showing."] = true,
	["Toggle raid group showing."] = true,
	["Toggle showing the raid target icon which is currently on the player."] = true,
	["Toggle tab completion of player names."] = true,
	["Toggle using a common color for brackets around player names."] = true,
	["Toggle using a common color for unknown player names."] = true,
	["Too many matches (%d possible)"] = true,
	["Unknown Common Color"] = true,
	["Unknown Common Color From TasteTheNaimbow"] = true,
	["Unknown Use Common Color"] = true,
	["Use Channel Color"] = true,
	["Use Player Color"] = true,
}

)
L:AddLocale("frFR",  
{
	-- ["Actively Query Player Info"] = "",
	-- Angled = "",
	-- Brackets = "",
	-- ["Brackets Common Color"] = "",
	-- ["Brackets Use Common Color"] = "",
	-- Class = "",
	-- ["Color by Level Difference"] = "",
	-- coloreverywhere_desc = "",
	-- coloreverywhere_name = "",
	-- ["Enable Alt-Invite"] = "",
	-- ["Enable Invite Links"] = "",
	-- ["Enable TabComplete"] = "",
	-- hoverhilight_desc = "",
	-- hoverhilight_name = "",
	-- ["How to color other player's level."] = "",
	-- ["How to color player's name."] = "",
	-- ["Keep Info"] = "",
	-- ["Keep Lots Of Info"] = "",
	-- ["Keep player information between session, but limit it to friends and guild members."] = "",
	-- ["Keep player information between session for all players except cross-server players"] = "",
	-- ["Let TasteTheNaimbow set the common color for unknown player names."] = "",
	-- ["Level Color Mode"] = "",
	-- linkifycommon_desc = "",
	-- linkifycommon_name = "",
	-- ["No additional coloring"] = "",
	-- None = "",
	-- ["Player Color Mode"] = "",
	-- ["Player name formating options."] = "",
	-- PlayerNames = "",
	-- ["Prat_Playernames: Stored Player Data Cleared"] = "",
	-- ["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = "",
	-- Random = "",
	-- realidcolor_desc = "",
	-- realidcolor_name = "",
	-- ["Reset Settings"] = "",
	-- ["Restore default settings, and delete stored character data."] = "",
	-- ["Set common color of unknown player names."] = "",
	-- ["Sets common color of brackets to use around player names."] = "",
	-- ["Sets style of brackets to use around player names."] = "",
	-- ["Show Group"] = "",
	-- ["Show Level"] = "",
	-- ["Show Raid Target Icon"] = "",
	-- Square = "",
	-- tabcomplete_name = "",
	-- ["Tab completion : "] = "",
	-- ["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = "",
	-- ["Toggle group invites by alt-clicking on player name."] = "",
	-- ["Toggle level showing."] = "",
	-- ["Toggle raid group showing."] = "",
	-- ["Toggle showing the raid target icon which is currently on the player."] = "",
	-- ["Toggle tab completion of player names."] = "",
	-- ["Toggle using a common color for brackets around player names."] = "",
	-- ["Toggle using a common color for unknown player names."] = "",
	-- ["Too many matches (%d possible)"] = "",
	-- ["Unknown Common Color"] = "",
	-- ["Unknown Common Color From TasteTheNaimbow"] = "",
	-- ["Unknown Use Common Color"] = "",
	-- ["Use Channel Color"] = "",
	-- ["Use Player Color"] = "",
}

)
L:AddLocale("deDE", 
{
	["Actively Query Player Info"] = "Spielerinformationen aktiv abfragen",
	Angled = "Abgewinkelt",
	Brackets = "Klammern",
	["Brackets Common Color"] = "Standardfarbe der Klammern",
	["Brackets Use Common Color"] = "Klammern verwende die Standardfarbe",
	Class = "Klasse",
	["Color by Level Difference"] = "Entsprechend des Stufenunterschieds einfärben",
	coloreverywhere_desc = "Spielernamen einfärben, wenn diese im Text einer Chat-Mitteilung auftreten.",
	coloreverywhere_name = "Namen überall einfärben",
	["Enable Alt-Invite"] = "Alt-Einladungen aktivieren",
	["Enable Invite Links"] = "Einladungs-Links aktivieren",
	["Enable TabComplete"] = "TabComplete aktivieren",
	hoverhilight_desc = "Chat-Zeilen eines bestimmten Spielers hervorheben, wenn die Maus über den Spielerlink gelegt wird.",
	hoverhilight_name = "Schwebendes Hervorheben",
	["How to color other player's level."] = "Wie die Stufen anderer Spieler eingefärbt werden sollen.",
	["How to color player's name."] = "Wie die Namen der Spieler eingefärbt werden sollen.",
	["Keep Info"] = "Informationen merken",
	["Keep Lots Of Info"] = "Viele Informationen speichern",
	["Keep player information between session, but limit it to friends and guild members."] = "Spielerinformationen zwischen Sitzungen speichern, aber schränke dies ein auf Freunde und Gildenmitglieder.",
	["Keep player information between session for all players except cross-server players"] = "Spielerinformationen aller Spieler außer Spielern anderer Server zwischen Sitzungen merken.",
	["Let TasteTheNaimbow set the common color for unknown player names."] = "Lasse TasteTheNaimbow die übliche Farbe für unbekannte Spielernamen einstellen.",
	["Level Color Mode"] = "Stufenfarbe-Modus",
	linkifycommon_desc = "Allgemeine Mitteilungen in Links umwandeln",
	linkifycommon_name = "Allgemeine Mitteilungen in Links umwandeln",
	["No additional coloring"] = "Keine zusätzliche Einfärbung",
	None = "Keine",
	["Player Color Mode"] = "Spielerfarbe-Modus",
	["Player name formating options."] = "Formatierungsoptionen für Spielernamen",
	PlayerNames = true,
	["Prat_Playernames: Stored Player Data Cleared"] = "Prat_Playernames: Gespeicherte Spielerdaten gelöscht",
	["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = "Alle uns unbekannten Spielernamen beim Server abfragen. Merke: dies passiert ziemlich langsam und diese Daten sind nicht gespeichert.",
	Random = "Zufällig",
	-- realidcolor_desc = "",
	-- realidcolor_name = "",
	["Reset Settings"] = "Einstellungen zurücksetzen",
	["Restore default settings, and delete stored character data."] = "Standardeinstellungen wiederherstellen und gespeicherte Charakterdaten löschen.",
	["Set common color of unknown player names."] = "Allgemein übliche Farbe bei unbekannten Spielernamen einstellen.",
	["Sets common color of brackets to use around player names."] = "Allgemein übliche Farbe der Klammern bei Spielernamen einstellen.",
	["Sets style of brackets to use around player names."] = "Stil der Klammern bei Spielernamen einstellen.",
	["Show Group"] = "Gruppe anzeigen",
	["Show Level"] = "Stufe anzeigen",
	["Show Raid Target Icon"] = "Schlachtzugsziel-Symbol anzeigen",
	Square = "Quadrat",
	tabcomplete_name = "Mögliche Namen",
	["Tab completion : "] = "Tab-Ergänzung:",
	["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = "Gruppeneinladungen umschalten, indem Hyperlinks von Stichworten wie \"invite\" bei gleichzeitigem Drücken der Alt-Taste angeklickt werden.",
	["Toggle group invites by alt-clicking on player name."] = "Gruppeneinladungen umschalten, indem Spielernamen bei gleichzeitigem Drücken der Alt-Taste angeklickt werden.",
	["Toggle level showing."] = "Stufenanzeige umschalten.",
	["Toggle raid group showing."] = "Schlachtzugsgruppenanzeige umschalten.",
	["Toggle showing the raid target icon which is currently on the player."] = "Anzeige von Schlachtzugsziel-Symbol, welches gegenwärtig dem Spieler zugewiesen ist, umschalten.",
	["Toggle tab completion of player names."] = "Tag-Ergänzung von Spielernamen umschalten.",
	["Toggle using a common color for brackets around player names."] = "Die Verwendung der allgemein üblichen Farbe für Klammern bei Spielernamen umschalten.",
	["Toggle using a common color for unknown player names."] = "Die Verwendung der allgemein üblichen Farbe für unbekannte Spielernamen umschalten.",
	["Too many matches (%d possible)"] = "Zu viele Entsprechungen (%d möglich)",
	["Unknown Common Color"] = "Unbekannte übliche Farbe",
	["Unknown Common Color From TasteTheNaimbow"] = "Unbekannte übliche Farbe von TasteTheNaimbow",
	["Unknown Use Common Color"] = "Unbekannt - übliche Farbe verwenden",
	["Use Channel Color"] = "Kanalfarbe verwenden",
	["Use Player Color"] = "Spielerfarbe verwenden",
}

)
L:AddLocale("koKR",  
{
	["Actively Query Player Info"] = "플레이어 정보 적극적 수집",
	Angled = "<플레이어>",
	Brackets = "괄호 선택",
	["Brackets Common Color"] = "괄호 색깔",
	["Brackets Use Common Color"] = "괄호에 색깔 사용",
	Class = "직업",
	["Color by Level Difference"] = "레벨 차이에 의한 색깔",
	coloreverywhere_desc = "채팅 메시지에 나타나는 플레이어 이름에 색상 적용",
	coloreverywhere_name = "모든 곳에서 이름에 색상 사용",
	["Enable Alt-Invite"] = "Alt 초대 켜기",
	["Enable Invite Links"] = "초대 링크 켜기",
	["Enable TabComplete"] = "탭완성 켜기",
	hoverhilight_desc = "플레이어 이름 위에 마우스 오버 시 채팅 내용을 강조합니다",
	hoverhilight_name = "마우스 오버 강조",
	["How to color other player's level."] = "다른 플레이어들의 레벨 색깔 방법",
	["How to color player's name."] = "플레이어 이름 색깔 방법",
	["Keep Info"] = "길드유저 정보 저장",
	["Keep Lots Of Info"] = "모든유저 정보 저장",
	["Keep player information between session, but limit it to friends and guild members."] = "친구와 길드유저에 대한 정보를 저장합니다.",
	["Keep player information between session for all players except cross-server players"] = "모든유저에 대한 정보를 저장합니다. (다른 서버는 제외)",
	["Let TasteTheNaimbow set the common color for unknown player names."] = "모르는 유저에 대한 색깔로 TasteTheNaimBow 애드온의 설정을 사용한다.",
	["Level Color Mode"] = "레벨 색깔 설정",
	-- linkifycommon_desc = "",
	-- linkifycommon_name = "",
	["No additional coloring"] = "색깔사용하지 않음",
	None = "없음",
	["Player Color Mode"] = "플레이어 색상 모드",
	["Player name formating options."] = "플레이어 이름 형식 설정",
	PlayerNames = "플레이어 이름",
	-- ["Prat_Playernames: Stored Player Data Cleared"] = "",
	["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = "알 수 없는 모든 플레이어 이름 정보를 서버에 요청합니다. 주의: 작동 시 느려질 수 있으며, 수집된 정보들은 저장되지 않습니다.",
	Random = "무작위",
	-- realidcolor_desc = "",
	-- realidcolor_name = "",
	["Reset Settings"] = "설정 초기화",
	["Restore default settings, and delete stored character data."] = "기본 설정을 복구하고 저장된 케릭터 설정을 지웁니다.",
	["Set common color of unknown player names."] = "알 수 없는 플레이어 이름 색상 설정",
	["Sets common color of brackets to use around player names."] = "플레이어 이름 괄호의 일반 색상 설정",
	["Sets style of brackets to use around player names."] = "플레이어 이름 주변 괄호 설정",
	["Show Group"] = "그룹 보이기",
	["Show Level"] = "레벨 보이기",
	["Show Raid Target Icon"] = "전술 아이콘 보이기",
	Square = "사각형",
	-- tabcomplete_name = "",
	["Tab completion : "] = "탭 완성 :",
	["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = "'초대'같은 단어를 Alt-클릭으로 초대하기",
	["Toggle group invites by alt-clicking on player name."] = "플레이어 이름 Alt-클릭으로 초대하기",
	["Toggle level showing."] = "레벨 보이기",
	["Toggle raid group showing."] = "공격대 파티 보이기",
	["Toggle showing the raid target icon which is currently on the player."] = "플레이어에게 지정된 전술 아이콘 보이기",
	["Toggle tab completion of player names."] = "플레이어 이름 탭 완성 켜기",
	["Toggle using a common color for brackets around player names."] = "플레이어 이름 주변 괄호 색상 사용",
	["Toggle using a common color for unknown player names."] = "알 수 없는 플레이어 이름에 일반 색상 사용하기",
	-- ["Too many matches (%d possible)"] = "",
	["Unknown Common Color"] = "알 수 없는 일반 색상",
	-- ["Unknown Common Color From TasteTheNaimbow"] = "",
	["Unknown Use Common Color"] = "알 수 없는 이름에 색상 사용",
	["Use Channel Color"] = "채널 색상 사용",
	["Use Player Color"] = "플레이어 색상 사용",
}

)
L:AddLocale("esMX",  
{
	-- ["Actively Query Player Info"] = "",
	-- Angled = "",
	-- Brackets = "",
	-- ["Brackets Common Color"] = "",
	-- ["Brackets Use Common Color"] = "",
	-- Class = "",
	-- ["Color by Level Difference"] = "",
	-- coloreverywhere_desc = "",
	-- coloreverywhere_name = "",
	-- ["Enable Alt-Invite"] = "",
	-- ["Enable Invite Links"] = "",
	-- ["Enable TabComplete"] = "",
	-- hoverhilight_desc = "",
	-- hoverhilight_name = "",
	-- ["How to color other player's level."] = "",
	-- ["How to color player's name."] = "",
	-- ["Keep Info"] = "",
	-- ["Keep Lots Of Info"] = "",
	-- ["Keep player information between session, but limit it to friends and guild members."] = "",
	-- ["Keep player information between session for all players except cross-server players"] = "",
	-- ["Let TasteTheNaimbow set the common color for unknown player names."] = "",
	-- ["Level Color Mode"] = "",
	-- linkifycommon_desc = "",
	-- linkifycommon_name = "",
	-- ["No additional coloring"] = "",
	-- None = "",
	-- ["Player Color Mode"] = "",
	-- ["Player name formating options."] = "",
	-- PlayerNames = "",
	-- ["Prat_Playernames: Stored Player Data Cleared"] = "",
	-- ["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = "",
	-- Random = "",
	-- realidcolor_desc = "",
	-- realidcolor_name = "",
	-- ["Reset Settings"] = "",
	-- ["Restore default settings, and delete stored character data."] = "",
	-- ["Set common color of unknown player names."] = "",
	-- ["Sets common color of brackets to use around player names."] = "",
	-- ["Sets style of brackets to use around player names."] = "",
	-- ["Show Group"] = "",
	-- ["Show Level"] = "",
	-- ["Show Raid Target Icon"] = "",
	-- Square = "",
	-- tabcomplete_name = "",
	-- ["Tab completion : "] = "",
	-- ["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = "",
	-- ["Toggle group invites by alt-clicking on player name."] = "",
	-- ["Toggle level showing."] = "",
	-- ["Toggle raid group showing."] = "",
	-- ["Toggle showing the raid target icon which is currently on the player."] = "",
	-- ["Toggle tab completion of player names."] = "",
	-- ["Toggle using a common color for brackets around player names."] = "",
	-- ["Toggle using a common color for unknown player names."] = "",
	-- ["Too many matches (%d possible)"] = "",
	-- ["Unknown Common Color"] = "",
	-- ["Unknown Common Color From TasteTheNaimbow"] = "",
	-- ["Unknown Use Common Color"] = "",
	-- ["Use Channel Color"] = "",
	-- ["Use Player Color"] = "",
}

)
L:AddLocale("ruRU",  
{
	["Actively Query Player Info"] = "Активный запрос инфы о игроке",
	Angled = "Треугольные",
	Brackets = "Скобки",
	["Brackets Common Color"] = "Основной цвет скобок",
	["Brackets Use Common Color"] = "Скобки общего цвета",
	Class = "Класс",
	["Color by Level Difference"] = "Окрашивание по отличию в уровне",
	coloreverywhere_desc = "Окраска текст сообщения в цвет имени игрока, если цвет задан",
	coloreverywhere_name = "Цвет имени везде",
	["Enable Alt-Invite"] = "Включить приглашение с кнопкой Alt",
	["Enable Invite Links"] = "Включить приглашение по ссылкам",
	["Enable TabComplete"] = "Включить TabComplete",
	hoverhilight_desc = "Подсвечивает строки чата от определенных игроков при наведении мышкой на их никнейм.",
	hoverhilight_name = "Подсветка при наведении мышкой",
	["How to color other player's level."] = "Как окрашивать уповень игрока.",
	["How to color player's name."] = "Как окрашивать имя игрока.",
	["Keep Info"] = "Хранить информацию",
	["Keep Lots Of Info"] = "Хранить большое количество информации",
	["Keep player information between session, but limit it to friends and guild members."] = "Хранить информацию о собеседниках между сессиями, но ограничить этот список только друзьями и членами гильдии.",
	["Keep player information between session for all players except cross-server players"] = "Хранить информацию о всех собеседниках между сессиями за исключением игроков с других серверов",
	["Let TasteTheNaimbow set the common color for unknown player names."] = "Позволить TasteTheNaimbow установить общий цветдля неизвестных играков.",
	["Level Color Mode"] = "Режим окрашивания уровня",
	linkifycommon_desc = "Общие сообщения с сылками",
	linkifycommon_name = "Общие сообщения с сылками",
	["No additional coloring"] = "Отключить дополнительное цвето-выделение",
	None = "Нет",
	["Player Color Mode"] = "Режим цвета игрока",
	["Player name formating options."] = "Настройки форматирования имени собеседника.",
	PlayerNames = "Имя игрока",
	["Prat_Playernames: Stored Player Data Cleared"] = "Prat_Playernames: Информация о собеседниках очищена",
	["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = "Запрос сервера для всех неизвестных играков. Заметка: Это происходит дастаточно медленно, и их данные не сохраняются.",
	Random = "Случайно",
	-- realidcolor_desc = "",
	-- realidcolor_name = "",
	["Reset Settings"] = "Сброс настроек",
	["Restore default settings, and delete stored character data."] = "Восстановить настройки по умолчанию и удалить сохраненную информацию о собеседниках.",
	["Set common color of unknown player names."] = "Выбор цвета, которым будут окрашены неизвестные игроки.",
	["Sets common color of brackets to use around player names."] = "Установить цвет скобок, окружающих имя игрока.",
	["Sets style of brackets to use around player names."] = "Установить стиль скобок вокруг имени собеседника.",
	["Show Group"] = "Показывать группу",
	["Show Level"] = "Показывать уровень",
	["Show Raid Target Icon"] = "Показать иконку цели рейда",
	Square = "Квадратные",
	tabcomplete_name = "Возможные имена",
	["Tab completion : "] = "Завершение закладки : ",
	["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = "Вкл/выкл приглашение в группу с помощью alt+клик по ключевому слову типа: 'инвайт'.",
	["Toggle group invites by alt-clicking on player name."] = "Включить режим, в котором можно пригласить игрока в группу щелкнув по его имени  с нажатой клавишей Alt.",
	["Toggle level showing."] = "Вкл/выкл отображения уровня собеседника.",
	["Toggle raid group showing."] = "Вкл/выкл отображения рейдовой группы.",
	["Toggle showing the raid target icon which is currently on the player."] = "Вкл/Выкл отображение иконки цели рейда которой помечен игрок.",
	["Toggle tab completion of player names."] = "Вкл/выкл завершение закладки именами играка.",
	["Toggle using a common color for brackets around player names."] = "Включить окрашивание скобок вокруг имени игрока общим, выбранным цветом.",
	["Toggle using a common color for unknown player names."] = "Включить окрашивание имен всех неизвестных собеседников в общий цвет.",
	["Too many matches (%d possible)"] = "За много совпадение (%d возможных)",
	["Unknown Common Color"] = "Общий цвет неизвестных",
	["Unknown Common Color From TasteTheNaimbow"] = "Общая окраска неизвестных из TasteTheNaimbow",
	["Unknown Use Common Color"] = "Общий цвет для неизвестных",
	["Use Channel Color"] = "Использовать цвет канала",
	["Use Player Color"] = "Использовать цвет игрока",
}

)
L:AddLocale("zhCN",  
{
	["Actively Query Player Info"] = "活跃的查询玩家信息",
	Angled = "折角",
	Brackets = "括号",
	["Brackets Common Color"] = "同一颜色括号",
	["Brackets Use Common Color"] = "使用同一颜色括号",
	Class = "职业",
	["Color by Level Difference"] = "彩色的等级差别",
	coloreverywhere_desc = "彩色显示聊天信息中出现的玩家姓名",
	coloreverywhere_name = "彩色显示姓名在所有地方",
	["Enable Alt-Invite"] = "启用Alt-邀请",
	["Enable Invite Links"] = "启用邀请链接",
	["Enable TabComplete"] = "启用Tab键补全",
	hoverhilight_desc = "当悬停在玩家链接上时高亮该玩家的聊天语句",
	hoverhilight_name = "悬停高亮",
	["How to color other player's level."] = "如何着色其他玩家的等级",
	["How to color player's name."] = "如何着色玩家的名称",
	["Keep Info"] = "保持信息",
	["Keep Lots Of Info"] = "保持大量的信息",
	["Keep player information between session, but limit it to friends and guild members."] = "在会话间保持玩家信息,但仅限于朋友和公会成员",
	["Keep player information between session for all players except cross-server players"] = "为除跨服玩家外的所有玩家在会话间保持玩家信息",
	["Let TasteTheNaimbow set the common color for unknown player names."] = "让TasteTheNaimbow(插件)为未知玩家名称设置公共颜色",
	["Level Color Mode"] = "等级着色模式",
	linkifycommon_desc = "自助链接公共信息",
	linkifycommon_name = "自助链接公共信息",
	["No additional coloring"] = "无额外着色",
	None = "无",
	["Player Color Mode"] = "玩家着色模式",
	["Player name formating options."] = "玩家名称格式选项",
	PlayerNames = "玩家名称",
	["Prat_Playernames: Stored Player Data Cleared"] = "Prat_玩家名称: 玩家数据存储已清除",
	["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = "为所有未知玩家查询服务器,注意:这将非常缓慢,并且数据不会被存储",
	Random = "随机",
	-- realidcolor_desc = "",
	-- realidcolor_name = "",
	["Reset Settings"] = "重置设置",
	["Restore default settings, and delete stored character data."] = "恢复默认设置并删除已存角色数据",
	["Set common color of unknown player names."] = "设置未知玩家名称共有颜色",
	["Sets common color of brackets to use around player names."] = "设置用来围绕玩家名称的括号颜色",
	["Sets style of brackets to use around player names."] = "设置用来围绕玩家名称的括号类型",
	["Show Group"] = "显示团队",
	["Show Level"] = "显示等级",
	["Show Raid Target Icon"] = "显示团队目标图标",
	Square = "直角",
	tabcomplete_name = "可能的名称",
	["Tab completion : "] = "Tab键补全",
	["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = "组队邀请用alt-点击超链接的关键词如'邀请'",
	["Toggle group invites by alt-clicking on player name."] = "组队邀请用alt-点击玩家名称",
	["Toggle level showing."] = "等级显示",
	["Toggle raid group showing."] = "团队分组显示",
	["Toggle showing the raid target icon which is currently on the player."] = "显示当前玩家的团队目标图标",
	["Toggle tab completion of player names."] = "Tab键补全玩家姓名",
	["Toggle using a common color for brackets around player names."] = "为括号内玩家姓名使用公共颜色",
	["Toggle using a common color for unknown player names."] = "为位置未知玩家名称使用公共颜色",
	["Too many matches (%d possible)"] = "太多的匹配 (%d可能的)",
	["Unknown Common Color"] = "未知公共颜色",
	["Unknown Common Color From TasteTheNaimbow"] = "未知公共颜色自TasteTheNaimbow",
	["Unknown Use Common Color"] = "未知使用公共颜色",
	["Use Channel Color"] = "使用频道颜色",
	["Use Player Color"] = "使用玩家颜色",
}

)
L:AddLocale("esES",  
{
	["Actively Query Player Info"] = "Pedir Información de Jugador Activamente",
	Angled = "Angulo",
	Brackets = "Corchetes",
	["Brackets Common Color"] = "Color Común Corchetes",
	["Brackets Use Common Color"] = "Utilizar Color Común Corchetes",
	Class = "Clase",
	["Color by Level Difference"] = "Color por Diferencia de Nivel",
	coloreverywhere_desc = "Colorear nombres de jugadores si ellos aparecen en el texto de los mensajes del chat.",
	coloreverywhere_name = "Colorear Nombres Siempre",
	["Enable Alt-Invite"] = "Habilitar Alt-Invitar",
	["Enable Invite Links"] = "Habilitar Enlaces Invitar",
	["Enable TabComplete"] = "Habilitar Ficha completa",
	hoverhilight_desc = "Resaltar líneas de chat de un jugador al situarse sobre su enlace de jugador",
	-- hoverhilight_name = "",
	["How to color other player's level."] = "Cómo el color de otro jugador de nivel.",
	["How to color player's name."] = "Cómo el color de nombre del jugador.",
	["Keep Info"] = "Mantener Información",
	["Keep Lots Of Info"] = "Mantener Mucha Información",
	["Keep player information between session, but limit it to friends and guild members."] = "Mantiene información de jugadores entre sesiones, pero lo limita a amigos y miembros de la hermandad.",
	["Keep player information between session for all players except cross-server players"] = "Mantiene información de jugadores entre sesiones para todos los jugadores excepto entre servidores",
	["Let TasteTheNaimbow set the common color for unknown player names."] = "Deje a TasteTheNaimbow establecer el color común para nombres de jugador desconocidos.",
	["Level Color Mode"] = "Modo Color por Nivel",
	linkifycommon_desc = "Linkify Common Messages",
	linkifycommon_name = "Enlazar Mensajes Comunes",
	["No additional coloring"] = "Sin color adicional",
	None = "Ninguno",
	["Player Color Mode"] = "Modo Color del Jugador",
	["Player name formating options."] = "Opciones de formato del nombre de jugador.",
	PlayerNames = "Nombre del Jugador",
	["Prat_Playernames: Stored Player Data Cleared"] = "Prat_Playernames: Limpiados los Datos de Jugador Guardados",
	["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = "Consulta el servidor para todos los nombres de jugador que desconocemos. Nota: esto sucede muy lentamente, y estos datos no se guardan.",
	Random = "Aleatorio",
	-- realidcolor_desc = "",
	-- realidcolor_name = "",
	["Reset Settings"] = "Restablecer Ajustes",
	["Restore default settings, and delete stored character data."] = "Restablece ajustes por defecto, y eliminar información del jugador guardada.",
	["Set common color of unknown player names."] = "Establece el color común para los nombres de jugadores desconocidos.",
	["Sets common color of brackets to use around player names."] = "Establece el color común de los corchetes a utilizar en torno a los nombres de jugador.",
	["Sets style of brackets to use around player names."] = "Establece el estilo de los corchetes a utilizar en torno a los nombres de jugador.",
	["Show Group"] = "Mostrar Grupo",
	["Show Level"] = "Mostrar Nivel",
	["Show Raid Target Icon"] = "Mostrar Icono Objetivo Banda",
	Square = "Cuadrado",
	tabcomplete_name = "Nombres Posibles",
	["Tab completion : "] = "Finalización de Pestaña : ",
	-- ["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = "",
	["Toggle group invites by alt-clicking on player name."] = "Activa invitar a grupo al hacer alt-click en el nombre del jugador.",
	["Toggle level showing."] = "Alterna mostrar nivel.",
	["Toggle raid group showing."] = "Alterna mostrar grupo de raid.",
	["Toggle showing the raid target icon which is currently on the player."] = "Altterna mostrar el icono de objetivo de banda que está en el jugador.",
	["Toggle tab completion of player names."] = "Alterna la finalización de la pestaña de nombres de jugador.",
	["Toggle using a common color for brackets around player names."] = "Alterna utilizar un color común de corchetes en torno a los nombres de jugador.",
	["Toggle using a common color for unknown player names."] = "Alterna el utilizar un color común para los nombres de jugadores desconocidos.",
	["Too many matches (%d possible)"] = "Demasiadas coincidencias (%d posibles)",
	["Unknown Common Color"] = "Color Común Desconocido",
	["Unknown Common Color From TasteTheNaimbow"] = "Desconocido Color Común de TasteTheNaimbow", -- Needs review
	["Unknown Use Common Color"] = "Desconocido Color de Uso Común",
	["Use Channel Color"] = "Utilizar Color Canal",
	["Use Player Color"] = "Utilizar Color Jugador",
}

)
L:AddLocale("zhTW",  
{
	["Actively Query Player Info"] = "主動查詢玩家資訊",
	-- Angled = "",
	Brackets = "括號",
	["Brackets Common Color"] = "括號通用色彩",
	["Brackets Use Common Color"] = "括號使用的通用色彩",
	Class = "職業",
	["Color by Level Difference"] = "等級差異色彩",
	-- coloreverywhere_desc = "",
	-- coloreverywhere_name = "",
	["Enable Alt-Invite"] = "啟用 Alt 按鍵邀請",
	["Enable Invite Links"] = "啟用邀請連結",
	["Enable TabComplete"] = "啟用 TabComplete",
	-- hoverhilight_desc = "",
	hoverhilight_name = "滑鼠懸停高亮",
	["How to color other player's level."] = "如何為玩家等級著色",
	["How to color player's name."] = "如何為玩家名稱著色",
	["Keep Info"] = "保存資訊",
	["Keep Lots Of Info"] = "保存大量資訊",
	["Keep player information between session, but limit it to friends and guild members."] = "保存此階段玩家資訊，但限制為好友以及公會成員。",
	["Keep player information between session for all players except cross-server players"] = "保存此階段所有玩家資訊，除了跨伺服器人物。",
	-- ["Let TasteTheNaimbow set the common color for unknown player names."] = "",
	["Level Color Mode"] = "等級色彩模式",
	-- linkifycommon_desc = "",
	-- linkifycommon_name = "",
	["No additional coloring"] = "無額外著色",
	None = "無",
	["Player Color Mode"] = "玩家色彩模式",
	["Player name formating options."] = "玩家名稱格式化選項。",
	PlayerNames = "玩家名稱",
	["Prat_Playernames: Stored Player Data Cleared"] = "Prat_Playernames：已清除儲存的玩家資料",
	["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = "查詢所有此伺服器我們不知道的角色名稱。備註：這個程序相當緩慢且並不會儲存此資料。",
	Random = "隨機",
	-- realidcolor_desc = "",
	-- realidcolor_name = "",
	["Reset Settings"] = "重置設定",
	["Restore default settings, and delete stored character data."] = "恢復至預設值且刪除儲存的角色資料。",
	["Set common color of unknown player names."] = "設定未知角色的顯示色彩",
	-- ["Sets common color of brackets to use around player names."] = "",
	-- ["Sets style of brackets to use around player names."] = "",
	["Show Group"] = "顯示隊伍編號",
	["Show Level"] = "顯示等級",
	["Show Raid Target Icon"] = "顯示團隊標記",
	Square = "方框",
	-- tabcomplete_name = "",
	-- ["Tab completion : "] = "",
	-- ["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = "",
	-- ["Toggle group invites by alt-clicking on player name."] = "",
	-- ["Toggle level showing."] = "",
	-- ["Toggle raid group showing."] = "",
	-- ["Toggle showing the raid target icon which is currently on the player."] = "",
	-- ["Toggle tab completion of player names."] = "",
	-- ["Toggle using a common color for brackets around player names."] = "",
	["Toggle using a common color for unknown player names."] = "切換未知玩家以一般色彩顯示",
	-- ["Too many matches (%d possible)"] = "",
	["Unknown Common Color"] = "未知的文字通用顏色",
	["Unknown Common Color From TasteTheNaimbow"] = "來自TasteTheNaimbow 的未知的文字通用顏色",
	["Unknown Use Common Color"] = "未知的文字使用通用顏色",
	["Use Channel Color"] = "使用頻道文字顏色",
	["Use Player Color"] = "使用腳色名稱文字色彩",
}

)
--@end-non-debug@

local module = Prat:NewModule(PRAT_MODULE, "AceEvent-3.0", "AceTimer-3.0")
module.L = L


module.Classes = {}
module.Levels = {}
module.Subgroups = {}

local NOP = function(self) return end

module.OnPlayerDataChanged = NOP


Prat:SetModuleDefaults(module.name, {
	realm = {
		classes = {},
	    levels = {}
	},
	profile = {
	    on = true,
	    brackets = "Square",
	    tabcomplete = true,
	    tabcompletelimit = 20,
	    level = true,
	    levelcolor = "DIFFICULTY",
	    subgroup = true,
		showtargeticon = false,
	    keep = false,
	    keeplots = false,
	    colormode = "CLASS",
	    realidcolor = "RANDOM",
		coloreverywhere = true,
	    usecommoncolor = true,
	    altinvite = false,
	    linkinvite = false,
	    bracketscommoncolor = true,
	    linkifycommon = true,
	    bracketscolor = {
	        r = 0.85,
	        g = 0.85,
	        b = 0.85,
			a = 1.0
	    },
	    useTTN = true,
	    usewho = false,
	    color = {
	        r = 0.65,
	        g = 0.65,
	        b = 0.65,
			a = 1.0
	    },
	}
})


Prat:SetModuleInit(module, 
	function(self)
        -- Right click - who
        
        UnitPopupButtons["WHOIS"]    = { text ="Who Is?", dist = 0 , func = function()
        	local dropdownFrame = UIDROPDOWNMENU_INIT_MENU
        	local name = dropdownFrame.name

            if name then 
            	SendWho(name)
            end
        end}
        tinsert(UnitPopupMenus["FRIEND"],#UnitPopupMenus["FRIEND"]-1,"WHOIS");

        Prat:RegisterDropdownButton("WHOIS")

--        function module:UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData, ...)
--        	for i=1, UIDROPDOWNMENU_MAXBUTTONS do
--        		button = getglobal("DropDownList"..UIDROPDOWNMENU_MENU_LEVEL.."Button"..i);
--        
--        		-- Patch our handler function back in
--        		if  button.value == "WHOIS" then
--        		    button.func = UnitPopupButtons["WHOIS"].func
--        		end
--        	end
--        end

   --     self:SecureHook("UnitPopup_ShowMenu")

        -- ends here gonna make a control for it
	end
)





module.pluginopts = {}

Prat:SetModuleOptions(module, {
        name = L["PlayerNames"],
        desc = L["Player name formating options."],
        type = "group",
		plugins = module.pluginopts,
        args = {
            brackets = {
                name = L["Brackets"],
                desc = L["Sets style of brackets to use around player names."],
                type = "select",
                order = 110,
                values = {["Square"] = L["Square"], ["Angled"] = L["Angled"], ["None"] = L["None"]}
            },
            bracketscommoncolor = {
                name = L["Brackets Use Common Color"],
                desc = L["Toggle using a common color for brackets around player names."],
                type = "toggle",
                order = 111,
            },
            bracketscolor = {
                name = L["Brackets Common Color"],
                desc = L["Sets common color of brackets to use around player names."],
                type = "color",
                order = 112,
                get = "GetColorValue",
                set = "SetColorValue",
                disabled = function(info) return not info.handler.db.profile.bracketscommoncolor end,
            },
            usecommoncolor = {
                name = L["Unknown Use Common Color"],
                desc = L["Toggle using a common color for unknown player names."],
                type = "toggle",
                order = 120,
            },
            color = {
                name = L["Unknown Common Color"],
                desc = L["Set common color of unknown player names."],
                type = "color",
                order = 121,
                get = "GetColorValue",
                set = "SetColorValue",
                disabled = function(info) if not info.handler.db.profile.usecommoncolor then return true else return false end end,
            },
            useTTN = {
                name = L["Unknown Common Color From TasteTheNaimbow"],
                desc = L["Let TasteTheNaimbow set the common color for unknown player names."],
                type = "toggle",
                order = 122,
                hidden = function(info) if TasteTheNaimbow_Loaded then return false else return true end end,
                disabled = function(info) if not info.handler.db.profile.usecommoncolor then return true else return false end end,
            },
            colormode = {
                name = L["Player Color Mode"],
                desc = L["How to color player's name."],
                type = "select",
                order = 130,
                values = {["RANDOM"] = L["Random"], ["CLASS"] = L["Class"], ["NONE"] = L["None"]}
            },
            realidcolor = {
                name = L["realidcolor_name"],
                desc = L["realidcolor_desc"],
                type = "select",
                order = 135,
                values = {["RANDOM"] = L["Random"], ["NONE"] = L["None"]}
            },
            levelcolor = {
                name = L["Level Color Mode"],
                desc = L["How to color other player's level."],
                type = "select",
                order = 131,
                values = {["PLAYER"] = L["Use Player Color"], ["CHANNEL"] = L["Use Channel Color"], ["DIFFICULTY"] = L["Color by Level Difference"], ["NONE"] = L["No additional coloring"]}
            },            
            level = {
                name = L["Show Level"],
                desc = L["Toggle level showing."],
                type = "toggle",
                order = 140,
            },
            subgroup = {
                name = L["Show Group"],
                desc = L["Toggle raid group showing."],
                type = "toggle",
                order = 141,
            },
            showtargeticon = {
                name = L["Show Raid Target Icon"],
                desc = L["Toggle showing the raid target icon which is currently on the player."],
                type = "toggle",
                order = 142,
            },

            tabcomplete = {
                name = L["Enable TabComplete"],
                desc = L["Toggle tab completion of player names."],
                type = "toggle",
                order = 150,
                get = function(info) return info.handler.db.profile.tabcomplete end,
                set = function(info, v) info.handler.db.profile.tabcomplete = v; info.handler:TabComplete(v) end
            },
            altinvite = {
                name = L["Enable Alt-Invite"],
                desc = L["Toggle group invites by alt-clicking on player name."],
                type = "toggle",
                order = 151,
            },            
            linkinvite = {
                name = L["Enable Invite Links"],
                desc = L["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."],
                type = "toggle",
                order = 152,
            },             
            keep = {
                name = L["Keep Info"],
                desc = L["Keep player information between session, but limit it to friends and guild members."],
                type = "toggle",
                order = 200,
            },
            keeplots = {
                name = L["Keep Lots Of Info"],
                desc = L["Keep player information between session for all players except cross-server players"],
                type = "toggle",
                order = 201,
                disabled = function(info) return not info.handler.db.profile.keep end,
            },
            
            usewho = {
                name = L["Actively Query Player Info"],
                desc = L["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."],
                type = "toggle",
                order = 202,
                hidden = function(info) if LibStub:GetLibrary("LibWho-2.0", true) then return false end return true end
            },
			reset = {
				name = L["Reset Settings"],
				desc = L["Restore default settings, and delete stored character data."],
				type = "execute",
				order = 250,
				func = "resetStoredData"
			},              
        }
    }
)
    
function module:OnValueChanged(info, b)
	local field = info[#info]
	if field == "altinvite" or field == "linkinvite" then
		self:SetAltInvite()
	elseif field == "usewho" then
		self.wholib = b and LibStub:GetLibrary("LibWho-2.0", true)
		self:updateAll()
	elseif field == "coloreverywhere" then
		self:OnPlayerDataChanged(b and UnitName("player") or nil)
	end
end

local mt_GuildClass = {}

 
function module:OnModuleEnable()
	Prat.RegisterChatEvent(self, "Prat_FrameMessage")
	Prat.RegisterChatEvent(self, "Prat_Ready")
    
	self:SetAltInvite()

	Prat.RegisterMessageItem("PREPLAYERDELIM", "PLAYER", "before")
	Prat.RegisterMessageItem("POSTPLAYERDELIM", "Ss", "after")

	Prat.RegisterMessageItem("PLAYERTARGETICON", "Ss", "after")

	Prat.EnableProcessingForEvent("CHAT_MSG_GUILD_ACHIEVEMENT")

	Prat.RegisterMessageItem("PLAYERLEVEL", "PREPLAYERDELIM", "before")
	Prat.RegisterMessageItem("PLAYERGROUP", "POSTPLAYERDELIM", "after")

    self:RegisterEvent("FRIENDLIST_UPDATE", "updateFriends")
    self:RegisterEvent("GUILD_ROSTER_UPDATE", "updateGuild")
    self:RegisterEvent("RAID_ROSTER_UPDATE", "updateRaid") 
    self:RegisterEvent("PLAYER_LEVEL_UP", "updatePlayerLevel")
    self:RegisterEvent("PARTY_MEMBERS_CHANGED", "updateParty")
    self:RegisterEvent("PLAYER_TARGET_CHANGED", "updateTarget")
    self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "updateMouseOver")
    self:RegisterEvent("WHO_LIST_UPDATE", "updateWho") 
	self:RegisterEvent("CHAT_MSG_SYSTEM", "updateWho") -- for short /who command

    self:RegisterEvent("PLAYER_LEAVING_WORLD", "EmptyDataCache")

	if self.db.profile.usewho then 
		self.wholib = LibStub:GetLibrary("LibWho-2.0", true)
	end

    self:updatePlayer()   
    self.NEEDS_INIT = true

    if IsInGuild() == 1 then
        GuildRoster()
    end

    self:TabComplete(self.db.profile.tabcomplete)   
    
    Prat.RegisterLinkType(  { linkid="invplr", linkfunc=self.Invite_Link, handler=self }, self.name)    
    Prat.RegisterLinkType(  { linkid="player", linkfunc=self.Player_Link, handler=self }, self.name)    
end

function module:OnModuleDisable()
    self:TabComplete(false)
	self:UnregisterAllEvents()
	Prat.UnregisterAllChatEvents(self)
end


function module:Prat_Ready()
    self:updateAll()
end

local cache = { module.Levels,
                module.Classes,
                module.Subgroups }


function module:EmptyDataCache(force)  
    for k,v in pairs(cache) do
        wipe(v)
    end 

    self:updatePlayer()   
    self.NEEDS_INIT = true
	self:OnPlayerDataChanged()
end


--[[------------------------------------------------
	Core Functions
------------------------------------------------]]--
function module:updateAll()
    self:updatePlayer()
	self:updateParty()
	
    if MiniMapBattlefieldFrame.status == "active" then
        self:updateBG()
    else
    	self:updateRaid()
    end
    	
	self:updateFriends()

    self.NEEDS_INIT = nil

	self:updateGuild(self.db.profile.keeplots)
end


function module:updateGF()
	if IsInGuild() == 1 then GuildRoster() end
    self:updateFriends()
    if MiniMapBattlefieldFrame.status == "active" then 
        self:updateBG()
    end
	self:updateWho()
    self:updateGuild()
end

function module:updatePlayer()
 	local PlayerClass = select(2, UnitClass("player"))
    local Name, Server = UnitName("player")
    self:addName(Name, Server, PlayerClass, UnitLevel("player"), nil, "PLAYER")
end

function module:updatePlayerLevel(event, level, hp, mp, talentPoints, str, agi, sta, int, spi)
 	local PlayerClass = select(2, UnitClass("player"))
    local Name, Server = UnitName("player")
    self:addName(Name, Server, PlayerClass, level, nil, "PLAYER")
end


function module:updateFriends()
    local Name, Class, Level
    for i = 1, GetNumFriends() do
        Name, Level, Class = GetFriendInfo(i)  -- name, level, class, area, connected, status 
        self:addName(Name, nil, Class, Level, nil, "FRIEND")
    end
end



function module:updateGuild()
    if IsInGuild() == 1 then
        GuildRoster()
        
        local Name, Class, Level, _
        for i = 1, GetNumGuildMembers(true) do
            Name, _, _, Level, _, _, _, _, _, _, Class  = GetGuildRosterInfo(i)
            self:addName(Name, nil, Class, Level, nil,"GUILD")
        end
    end
end

function module:updateRaid()
  --  self:Debug("updateRaid -->")
    local Name, Class, SubGroup, Level, Server
	local _, zone, online, isDead, role, isML
	for k,v in pairs(self.Subgroups) do
	    self.Subgroups[k] = nil
	end
    for i = 1, GetNumRaidMembers() do
		_, rank, SubGroup, Level, _, Class, zone, online, isDead, role, isML = GetRaidRosterInfo(i)
        Name, Server = UnitName("raid" .. i)
        self:addName(Name, Server, Class, Level, SubGroup, "RAID")
    end
end

function module:updateParty()
    local Class, Unit, Name, Server, _
    for i = 1, GetNumPartyMembers() do
        Unit = "party" .. i
        _, Class = UnitClass(Unit)
        Name, Server = UnitName(Unit)
        self:addName(Name, Server, Class, UnitLevel(Unit), nil, "PARTY")
    end
end

function module:updateTarget()
    local Class, Name, Server
    if not UnitIsPlayer("target") or not UnitIsFriend("player", "target") then
        return
    end
    Class = select(2, UnitClass("target"))
    Name, Server = UnitName("target")
    self:addName(Name, Server, Class, UnitLevel("target"), nil,  "TARGET")
end

function module:updateMouseOver(event)
    local Class, Name, Server
    if not UnitIsPlayer("mouseover") or not UnitIsFriend("player", "mouseover") then
        return
    end
    Class = select(2, UnitClass("mouseover"))
    Name, Server = UnitName("mouseover")
    self:addName(Name, Server, Class, UnitLevel("mouseover"), nil,  "MOUSE")
end

function module:updateWho()
    if self.wholib then return end
    
    local Name, Class, Level, Server, _
    for i = 1, GetNumWhoResults() do
        Name, _, Level, _, _, _, Class = GetWhoInfo(i)
        self:addName(Name, Server, Class, Level, nil, "WHO")
    end
end

function module:updateBG()
	for i = 1, GetNumBattlefieldScores() do
	    local name, killingBlows, honorKills, deaths, honorGained, faction, rank, race, class, filename, damageDone, healingDone = GetBattlefieldScore(i);

        if name then
            local plr, svr = name:match("([^%-]+)%-?(.*)")
            self:addName(plr, svr, class, nil, nil, "BATTLEFIELD")
            self:addName(plr, nil, class, nil, nil, "BATTLEFIELD")
        end
	end    
    self:updateRaid()  
end


function module:resetStoredData()
    self.db.realm.classes = {}
    self.db.realm.levels = {}

    self:EmptyDataCache(true)
    
    Prat:Print(L["Prat_Playernames: Stored Player Data Cleared"])
end

--
-- Coloring Functions
--
local CLR = Prat.CLR
function CLR:Bracket(text) return self:Colorize(module:GetBracketCLR(), text) end
function CLR:Common(text) return self:Colorize(module:GetCommonCLR(), text) end
function CLR:Random(text, seed) return self:Colorize(module:GetRandomCLR(seed), text) end
function CLR:Class(text, class) return self:Colorize(self:GetClassColor(class), text) end

local colorFunc = GetQuestDifficultyColor or GetDifficultyColor
function CLR:Level(text, level, name, class) 
    local mode = module.db.profile.levelcolor
    if mode and type(level) == "number" and level > 0 then
        if mode == "DIFFICULTY" then 
            local diff = colorFunc(level)
            return self:Colorize(CLR:GetHexColor(CLR:Desaturate(diff)), text)
        elseif mode == "PLAYER" then
            return self:Player(text, name, class)
        end
    end 
    
    return text
end
function CLR:Player(text, name, class) 
    return self:Colorize(module:GetPlayerCLR(name, class), text)
end    

local servernames

function module:addName(Name, Server, Class, Level, SubGroup, Source)
  if Name then
    local nosave
    Source = Source or "UNKNOWN"
    
    -- Messy negations, but this says dont save data from 
    -- sources other than guild or friends unless you enable
    -- the keeplots option
    if Source ~= "GUILD" and Source ~= "FRIEND" and Source ~= "PLAYER" then
        nosave = not self.db.profile.keeplots
    end

    if Server and Server:len() > 0 then 
        nosave = true
        servernames = servernames or Prat.Addon:GetModule("ServerNames", true)

        if servernames then 
            servernames:GetServerKey(Server) 
        end
    end
   

    Name = Name..(Server and Server:len()>0 and ("-"..Server) or "")

	local changed
	if Level and Level > 0 then
		self.Levels[Name:lower()] = Level
        if ((not nosave) and  self.db.profile.keep) then	
            self.db.realm.levels[Name:lower()] = Level 
        else -- Update it if it exists
            if self.db.realm.levels[Name:lower()] then 
                self.db.realm.levels[Name:lower()] = Level
            end
        end

		changed = true
	end
    if Class and Class ~= UNKNOWN then
        self.Classes[Name:lower()] = Class
        if ((not nosave) and   self.db.profile.keep ) then self.db.realm.classes[Name:lower()] = Class end

		changed = true
    end
	if SubGroup then
		module.Subgroups[Name:lower()] = SubGroup

		changed = true
	end

	if changed then
		self:OnPlayerDataChanged(Name)
	end
  end
end

function module:getClass(player)
    return self.Classes[player:lower()] or self.db.realm.classes[player:lower()] or self.db.realm.classes[player]
end

function module:getLevel(player)
    return self.Levels[player:lower()] or self.db.realm.levels[player:lower()] or self.db.realm.levels[player]
end

function module:getSubgroup(player)
    return self.Subgroups[player:lower()]
end

function module:GetData(player, frame)
    local class = self:getClass(player)
    local level = self:getLevel(player)

    if level == 0 then level = nil end
    if class == UNKNOWN then class = nil end

    if self.wholib and not(class and level) then
        local user, cachetime = self.wholib:UserInfo(player, { timeout = 20 }) 

        if user then
            level = user.Level or level
            class = user.NoLocaleClass or user.Class or class
        end
    end
    return class, level, self:getSubgroup(player)
end

function module:GetClassColor(class)
	 return CLR:GetHexColor(Prat.GetClassGetColor(class))
end

function module:addInfo(Name, Server)
	return 
end



function module:FormatPlayer(message, Name, frame, class)
    if not Name or Name:len() == 0 then return end
    

    
    local storedclass, level, subgroup = self:GetData(Name, frame)
	if class == nil then 
		class = storedclass
	end

    -- Add level information if needed
    if level and self.db.profile.level then
		message.PLAYERLEVEL = CLR:Level(tostring(level), level, Name, class)
    	message.PREPLAYERDELIM = ":"
    end

    -- Add raid subgroup information if needed
    if subgroup and self.db.profile.subgroup and (GetNumRaidMembers() > 0) then
		message.POSTPLAYERDELIM = ":"
		message.PLAYERGROUP = subgroup
    end

	-- Add raid target icon
	if self.db.profile.showtargeticon then 
		local icon = UnitExists(Name) and GetRaidTargetIndex(Name)
		if icon then
            icon = ICON_LIST[icon]

            if icon and icon:len() > 0 then
				-- since you cant have icons in links end the link before the icon
                message.PLAYERTARGETICON = "|h" .. icon .."0|t"
				message.Ll = ""
            end
		end
	end

    if message.PLAYERLINKDATA and (message.PLAYERLINKDATA:find("BN_") and message.PLAYER ~= UnitName("player")) then
        if self.db.profile.realidcolor == "RANDOM" then
            message.PLAYER = CLR:Random(message.PLAYER, message.PLAYER:lower())
        end
    else
        -- Add the player name in the proper color
        message.PLAYER = CLR:Player(message.PLAYER, Name, class)
    end

    -- Add the correct bracket style and color
    local prof_brackets = self.db.profile.brackets
    if prof_brackets == "Angled" then
        message.pP = CLR:Bracket("<")..message.pP
        message.Pp  = message.Pp..CLR:Bracket(">")
    elseif prof_brackets == "None" then
    else
        message.pP = CLR:Bracket("[")..message.pP
        message.Pp  = message.Pp..CLR:Bracket("]")
    end
end


--
-- Prat Event Implementation
--
local EVENTS_FOR_RECHECK = {
 ["CHAT_MSG_GUILD"] = module.updateGF,
-- ["CHAT_MSG_OFFICER"] = module.updateGuild,
-- ["CHAT_MSG_PARTY"] = module.updateParty,
-- ["CHAT_MSG_PARTY_LEADER"] = module.updateParty,
-- ["CHAT_MSG_PARTY_GUIDE"] = module.updateParty,
-- ["CHAT_MSG_RAID"] = module.updateRaid,
-- ["CHAT_MSG_RAID_LEADER"] = module.updateRaid,
-- ["CHAT_MSG_RAID_WARNING"] = module.updateRaid,
 ["CHAT_MSG_BATTLEGROUND"] = module.updateBG,
 ["CHAT_MSG_BATTLEGROUND_LEADER"] = module.updateBG,
 ["CHAT_MSG_SYSTEM"] = module.updateGF,
}

local EVENTS_FOR_CACHE_GUID_DATA = {
    CHAT_MSG_PARTY = true,
    CHAT_MSG_PARTY_LEADER = true,
    CHAT_MSG_PARTY_GUIDE = true,
    CHAT_MSG_RAID = true,
    CHAT_MSG_RAID_WARNING = true,
    CHAT_MSG_RAID_LEADER = true,
    CHAT_MSG_BATTLEGROUND = true,
    CHAT_MSG_BATTLEGROUND_LEADER = true,
}


function module:MakePlayer(message, name)
    if type(name) == "string" then
        local plr, svr = name:match("([^%-]+)%-?(.*)")
   --     self:Debug("MakePlayer", name, plr, svr)
    
        message.lL = "|Hplayer:"
        message.PLAYERLINK = name
        message.LL = "|h"
        message.PLAYER = plr
        message.Ll = "|h"
        
        if svr and strlen(svr) > 0 then
            message.sS = "-"
            message.SERVER = svr
        end        
    end
end


function module:Prat_FrameMessage(info, message, frame, event)
    if self.NEEDS_INIT then
        self:updateAll()
    end
        
	local Name = message.PLAYERLINK or ""
	message.Pp = ""
	message.pP = ""

    -- If there is no playerlink, then we have nothing to do
    if Name:len() == 0 then 
        return
    end

    local class, level, subgroup = self:GetData(Name)

	if (class == nil) and message and message.ORG and message.ORG.GUID and message.ORG.GUID:len() > 0 then 		
		_, class = GetPlayerInfoByGUID(message.ORG.GUID)

        if class ~= nil and EVENTS_FOR_CACHE_GUID_DATA[event] then
            self:addName(Name, message.SERVER, class, level, subgroup, "GUID")
        end
	end
    local fx = EVENTS_FOR_RECHECK[event]
    if fx~=nil and (level==nil or level==0) then        
        fx(self)
    end
    
    self:FormatPlayer(message, Name, frame, class)
end

function module:GetPlayerCLR(name, class, mode)
    if not mode then mode = module.db.profile.colormode end
    
    if name and strlen(name) > 0 then
        if class and mode == "CLASS" then
            return self:GetClassColor(class)
        elseif mode == "RANDOM" then
            return self:GetRandomCLR(name)
    	else
    		return self:GetCommonCLR()
    	end
    end
end

function module:GetBracketCLR()
	if not self.db.profile.bracketscommoncolor then
		return CLR.COLOR_NONE
	else
		local color = self.db.profile.bracketscolor
		return CLR:GetHexColor(color)
	end
end
function module:GetCommonCLR()
	local color = CLR.COLOR_NONE
    if self.db.profile.usecommoncolor then
    	if self.db.profile.useTTN and TasteTheNaimbow_Loaded then
    		color = TasteTheNaimbowExternalColor(name)
    	else
    		color = CLR:GetHexColor(self.db.profile.color)
    	end
    end
    return color
end
function module:GetRandomCLR(Name)
	local hash = 17
	for i=1,string.len(Name) do
		hash = hash * 37 * string.byte(Name, i);
	end

	local r = math.floor(math.fmod(hash / 97, 255));
	local g = math.floor(math.fmod(hash / 17, 255));
	local b = math.floor(math.fmod(hash / 227, 255));

    if ((r * 299 + g * 587 + b * 114) / 1000) < 105 then
    	r = math.abs(r - 255);
        g = math.abs(g - 255);
        b = math.abs(b - 255);
    end

	return string.format("%02x%02x%02x", r, g, b)
end


function module:TabComplete(enabled)
	local AceTab = LibStub("AceTab-3.0")

    if enabled then
        servernames = servernames or Prat.Addon:GetModule("ServerNames", true)
    
        if not AceTab:IsTabCompletionRegistered(L["tabcomplete_name"]) then
            local foundCache = {}
            AceTab:RegisterTabCompletion(L["tabcomplete_name"], nil,
                function(t, text, pos)
                    for name in pairs(self.Classes) do
                        table.insert(t, name)
                    end
                end,
                function(u, cands, ...)
                	local candcount = #cands
                	if candcount <= self.db.profile.tabcompletelimit then
						local text
	                    for key, cand in pairs(cands) do
							if servernames then
                                local plr,svr = key:match("([^%-]+)%-?(.*)")
                            
                                cand = CLR:Player(cand, plr, self:getClass(key))

                                if svr then
                                    svr = servernames:FormatServer(nil, servernames:GetServerKey(svr))
                                    cand = cand .. (svr and ("-" .. svr) or "")
                                end
                            else
                                cand = CLR:Player(cand, cand, self:getClass(cand))
                            end        
                            								

							text = text and (text .. ", " .. cand) or cand
	                    end
	                    return "   "..text
	                else
	                	return "   "..L["Too many matches (%d possible)"]:format(candcount)
	                end
                end,
				nil,
				function(name)
                    return name:gsub(Prat.MULTIBYTE_FIRST_CHAR, string.upper, 1):match("^[^%-]+")
				end
            )
        end
    else
        if AceTab:IsTabCompletionRegistered(L["tabcomplete_name"]) then
            AceTab:UnregisterTabCompletion(L["tabcomplete_name"])
        end
    end
end

function module:SetAltInvite()
	local enabled = self.db.profile.linkinvite or self.db.profile.altinvite

	if enabled then
        for _,v in pairs(Prat.GetModulePatterns(self)) do
            Prat:RegisterPattern(v, self.name)
        end
	else
        Prat:UnregisterAllPatterns(self.name)
	end
end

local EVENTS_FOR_INVITE = {
 ["CHAT_MSG_GUILD"] = true,
 ["CHAT_MSG_OFFICER"] = true,
 ["CHAT_MSG_PARTY"] = true,
 ["CHAT_MSG_RAID"] = true,
 ["CHAT_MSG_RAID_LEADER"] = true,
 ["CHAT_MSG_RAID_WARNING"] = true,
 ["CHAT_MSG_SAY"] = true,
 ["CHAT_MSG_YELL"] = true,
 ["CHAT_MSG_WHISPER"] = true,
 ["CHAT_MSG_CHANNEL"] = true,
}

local function Invite(text, ...)
	if module.db.profile.linkinvite then
    	return module:ScanForLinks(text, Prat.SplitMessage.PLAYERLINK)
	end
end

local INVALID_NAMES = {
    ["meh"] = true,
    ["now"] = true,
    ["plz"] = true,
    ["pls"] = true,
    ["please"] = true,
    ["when"] = true,
    ["group"] = true,    
    ["raid"] = true,    
    ["grp"] = true,    
}

local INVALID_NAME_REFERENCE = {
    ["him"] = true,
    ["her"] = true,
    ["them"] = true,
    ["someone"] = true,    
}

local function InviteSomone(text, name)
	if module.db.profile.linkinvite and name then
        name = name:lower()  -- TODO Use UTF8Lib
        if name:len()>2 and not INVALID_NAMES[name] then 
            if INVALID_NAME_REFERENCE[name] then
                return Prat:RegisterMatch(text)
            else
                return module:ScanForLinks(text, name)
            end
        end
	end
end


Prat:SetModulePatterns(module, {
    { pattern = "(send%s+invite%s+to%s+"..Prat.AnyNamePattern..")", matchfunc=InviteSomone },
    { pattern = "(invi?t?e?%s+"..Prat.AnyNamePattern..")", matchfunc=InviteSomone },
    { pattern = "("..Prat.GetNamePattern("invites?%??")..")", matchfunc=Invite },
    { pattern = "("..Prat.GetNamePattern("inv%??")..")", matchfunc=Invite },
    { pattern = "(초대)", matchfunc=Invite },
    { pattern = "(組%??)$", matchfunc=Invite },
    { pattern = "(組我%??)$", matchfunc=Invite },
})

function module:Invite_Link(link, text, button, ...)
    if self.db.profile.linkinvite then
		local name = strsub(link, 8);
		if ( name and (strlen(name) > 0) ) then
			local begin = string.find(name, "%s[^%s]+$");
			if ( begin ) then
				name = strsub(name, begin+1);
			end
			if ( button == "LeftButton" ) then
				InviteUnit(name);
			end
		end
		
    end

    return false
end

function module:Player_Link(link, text, button, ...)
    if self.db.profile.altinvite then
		local name = strsub(link, 8);
		if ( name and (strlen(name) > 0) ) then
		    local begin, nend = string.find(name, "%s*[^%s:]+");
			if ( begin ) then
			name = strsub(name, begin, nend);
			end
			if ( IsAltKeyDown() ) then
				InviteUnit(name);
				ChatEdit_OnEscapePressed(this.editBox)
				return false;
			end
		end
    end
    
    return true
end

function module:ScanForLinks(text, name)
    if text == nil then 
        return ""
    end

	local enabled = self.db.profile.linkinvite

    	if enabled and CanGroupInvite() then

		if EVENTS_FOR_INVITE[event] then
       			return  self:InviteLink(text, name)
    		end
	end

	return text
end



function module:InviteLink(link, name)
    return Prat:RegisterMatch( ("|cff%s|Hinvplr:%s|h[%s]|h|r"):format("ffff00", name, link) )
end



  return
end ) -- Prat:AddModuleToLoad
