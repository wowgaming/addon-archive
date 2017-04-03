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
-- Version Russe par Komsomolka:Navigator (Азурегос/Пиратская Бухта) (http://koms.ruguild.ru)
--
-- Version $LastChangedDate: 2008-10-26 18:56:51 +1100 (Sun, 26 Oct 2008) $
------------------------------------------------------------------------------------------------------

------------------------------------------------
-- RUSSIAN VERSION FUNCTIONS --
------------------------------------------------

if ( GetLocale() == "ruRU" ) then

-- Types d'unité des PnJ utilisés par Necrosis
Necrosis.Unit = {
	["Undead"] = "Нежить",
	["Demon"] = "Демон",
	["Elemental"] = "Дух стихии"
}

-- Traduction du nom des procs utilisés par Necrosis
Necrosis.Translation.Proc = {
	["Backlash"] = "Ответный удар",
	["ShadowTrance"] = "Теневой транс"
}

-- Traduction des noms des démons invocables
Necrosis.Translation.DemonName = {
	[1] = "Бес",
	[2] = "Демон Бездны",
	[3] = "Суккуба",
	[4] = "Охотник Скверны",
	[5] = "Страж Скверны",
	[6] = "Инферно",
	[7] = "Привратник Скверны"
}

-- Traduction du nom des objets utilisés par Necrosis
Necrosis.Translation.Item = {
	["Soulshard"] = "Осколок души",
	["Soulstone"] = "камень души",
	["Healthstone"] = "камень здоровья",
	["Spellstone"] = "камень чар",
	["Firestone"] = "камень огня",
	["InfernalStone"] = "Камень инфернала",
	["DemoniacStone"] = "Демоническая статуэтка",
	["Hearthstone"] = "Камень возвращения",
	["SoulPouch"] = {"Мешок душ", "Сума душ", "Коробка душ", "Сумка из ткани Скверны", "Черная сумка теней", "Сумка Бездны", "Черная сумка теней"}
}

-- Traductions diverses
Necrosis.Translation.Misc = {
	["Cooldown"] = "Восстановление",
	["Rank"] = "Уровень",
	["Create"] = "Создание"
}

-- Gestion de la détection des cibles protégées contre la peur
Necrosis.AntiFear = {
	-- Buffs giving temporary immunity to fear effects
	["Buff"] = {
		"Защита от страха",		-- Dwarf priest racial trait
		"Воля отрекшихся",		-- Forsaken racial trait
		"Бесстрашие",			-- Trinket (Fearless)
		"Ярость берсерка",		-- Warrior Fury talent
		"Безрассудство",		-- Warrior Fury talent
		"Жажда смерти",			-- Warrior Fury talent
		"Звериный гнев",		-- Hunter Beast Mastery talent
		"Ледяная преграда",		-- Mage Ice talent
		"Божественная защита",	-- Paladin Holy buff
		"Божественный щит",		-- Paladin Holy buff
		"Тотем трепета",		-- Shaman totem
		"Abolish Magic"			-- Majordomo (NPC) spell
	},
	-- Debuffs and curses giving temporary immunity to fear effects
	["Debuff"] = {
	}
}

end