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
-- Version $LastChangedDate: 2008-11-07 05:22:46 +1100 (Fri, 07 Nov 2008) $
------------------------------------------------------------------------------------------------------

------------------------------------------------
-- Chinese Traditional VERSION FUNCTIONS      --
--  2007/01/02
--  艾娜羅沙@奧妮克希亞
------------------------------------------------

if ( GetLocale() == "zhTW" ) then

-- Types d'unité des PnJ utilisés par Necrosis
Necrosis.Unit = {
	["Undead"] = "不死族",
	["Demon"] = "惡魔",
	["Elemental"] = "元素"
}

-- Traduction du nom des procs utilisés par Necrosis
Necrosis.Translation.Proc = {
	["Backlash"] = "反衝",
	["ShadowTrance"] = "暗影冥思"
}

-- Traduction des noms des démons invocables
Necrosis.Translation.DemonName = {
	[1] = "小鬼",
	[2] = "虛無行者",
	[3] = "魅魔",
	[4] = "惡魔獵犬",
	[5] = "惡魔守衛",
	[6] = "地獄火",
	[7] = "末日守衛"
}

-- Traduction du nom des objets utilisés par Necrosis
Necrosis.Translation.Item = {
	["Soulshard"] = "靈魂裂片",
	["Soulstone"] = "靈魂石",
	["Healthstone"] = "治療石",
	["Spellstone"] = "法術石",
	["Firestone"] = "火焰石",
	["InfernalStone"] = "地獄火石",
	["DemoniacStone"] = "惡魔雕像",
	["Hearthstone"] = "爐石",
	["SoulPouch"] = {"靈魂袋", "惡魔布包", "熔火惡魔布包"}
}

-- Traductions diverses
Necrosis.Translation.Misc = {
	["Cooldown"] = "冷卻時間",
	["Rank"] = "等級",
	["Create"] = "製造"
}

-- Gestion de la détection des cibles protégées contre la peur
Necrosis.AntiFear = {
	-- Buffs donnant une immunité temporaire au Fear
	["Buff"] = {
		"防護恐懼結界",	-- Dwarf priest racial trait
		"亡靈意志",		-- Forsaken racial trait
		"無畏",			-- Trinket
		"狂怒",			-- Warrior Fury talent
		"魯莽",			-- Warrior Fury talent
		"死亡之願",		-- Warrior Fury talent
		"狂野怒火",		-- Hunter Beast Mastery talent
		"寒冰屏障",		-- Mage Ice talent
		"聖佑術",		-- Paladin Holy buff
		"聖盾術",		-- Paladin Holy buff
		"戰慄圖騰",		-- Shaman totem
		"廢除魔法"		-- Majordomo (NPC) spell
	},
	-- Debuffs donnant une immunité temporaire au Fear
	["Debuff"] = {
	}
}

end
