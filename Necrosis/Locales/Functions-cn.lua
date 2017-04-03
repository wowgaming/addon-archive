--[[
    Necrosis LdC
    Copyright (C) 2005-2008  Lom Enfroy

    This file is part of Necrosis LdC.

    Necrosis LdC is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Necrosis LdC is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Necrosis LdC; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
--]]


------------------------------------------------------------------------------------------------------
-- Necrosis LdC
-- Par Lomig (Kael'Thas EU/FR) & Tarcalion (Nagrand US/Oceanic) 
-- Contributions deLiadora et Nyx (Kael'Thas et Elune EU/FR)
--
-- Skins et voix Françaises : Eliah, Ner'zhul
--
-- Version Allemande par Geschan
-- Version Espagnole par DosS (Zul’jin)
-- Version Russe par Komsomolka
--
-- Version $LastChangedDate: 2008-10-26 18:56:51 +1100 (Sun, 26 Oct 2008) $
------------------------------------------------------------------------------------------------------

------------------------------------------------
-- Chinese Simplified VERSION FUNCTIONS--
--  2006/01/02
--  艾娜羅沙@奧妮克希亞/TW
------------------------------------------------

if ( GetLocale() == "zhCN" ) then

-- Types d'unité des PnJ utilisés par Necrosis
Necrosis.Unit = {
	["Undead"] = "亡灵",
	["Demon"] = "恶魔",
	["Elemental"] = "元素"
}

-- Traduction du nom des procs utilisés par Necrosis
Necrosis.Translation.Proc = {
	["Backlash"] = "反冲",
	["ShadowTrance"] = "暗影冥思"
}

-- Traduction des noms des démons invocables
Necrosis.Translation.DemonName = {
	[1] = "小鬼",
	[2] = "虚空行者",
	[3] = "魅魔",
	[4] = "地狱猎犬",
	[5] = "地狱火",
	[6] = "末日守卫",
	[7] = "厄运守卫"
}

-- Traduction du nom des objets utilisés par Necrosis
Necrosis.Translation.Item = {
	["Soulshard"] = "灵魂碎片",
	["Soulstone"] = "灵魂石",
	["Healthstone"] = "治疗石",
	["Spellstone"] = "法术石",
	["Firestone"] = "火焰石",
	["InfernalStone"] = "地狱火石",
	["DemoniacStone"] = "恶魔雕像",
	["Hearthstone"] = "炉石",
	["SoulPouch"] = {"灵魂袋", "恶魔布包", "熔火恶魔布包"}
}

-- Traductions diverses
Necrosis.Translation.Misc = {
	["Cooldown"] = "冷却时间",
	["Rank"] = "等级",
	["Create"] = ""
}

-- Gestion de la détection des cibles protégées contre la peur
Necrosis.AntiFear = {
	-- Buffs giving temporary immunity to fear effects
	["Buff"] = {
		"恐惧防护结界",	-- Dwarf priest racial trait
		"亡灵意志",	-- Forsaken racial trait
		"反恐惧",	-- Trinket
		"狂怒",		-- Warrior Fury talent
		"鲁莽",		-- Warrior Fury talent
		"死亡之愿",	-- Warrior Fury talent
		"狂野怒火",	-- Hunter Beast Mastery talent (pet only)
		"寒冰屏障",	-- Mage Ice talent
		"圣佑术",	-- Paladin Holy buff
		"圣盾术",	-- Paladin Holy buff
		"战栗图腾",	-- Shaman totem
		"废除魔法"	-- Majordomo (NPC) spell
	},
	-- Debuffs and curses giving temporary immunity to fear effects
	["Debuff"] = {
	}
}

end
