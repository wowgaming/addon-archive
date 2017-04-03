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
-- ENGLISH  VERSION FUNCTIONS --
------------------------------------------------

if ( GetLocale() == "enUS" ) or ( GetLocale() == "enGB" ) then

-- Types d'unité des PnJ utilisés par Necrosis
Necrosis.Unit = {
	["Undead"] = "Undead",
	["Demon"] = "Demon",
	["Elemental"] = "Elemental"
}

-- Traduction du nom des procs utilisés par Necrosis
Necrosis.Translation.Proc = {
	["Backlash"] = "Backlash",
	["ShadowTrance"] = "Shadow Trance"
}

-- Traduction des noms des démons invocables
Necrosis.Translation.DemonName = {
	[1] = "Imp",
	[2] = "Voidwalker",
	[3] = "Succubus",
	[4] = "Felhunter",
	[5] = "Felguard",
	[6] = "Inferno",
	[7] = "Doomguard"
}

-- Traduction du nom des objets utilisés par Necrosis
Necrosis.Translation.Item = {
	["Soulshard"] = "Soul Shard",
	["Soulstone"] = "Soulstone",
	["Healthstone"] = "Healthstone",
	["Spellstone"] = "Spellstone",
	["Firestone"] = "Firestone",
	["InfernalStone"] = "Infernal Stone",
	["DemoniacStone"] = "Demonic Figurine",
	["Hearthstone"] = "Hearthstone",
	["SoulPouch"] = {"Soul Pouch", "Small Soul Pouch", "Box of Souls", "Felcloth Bag", "Ebon Shadowbag", "Core Felcloth Bag", "Abyssal Bag"}
}

-- Traductions diverses
Necrosis.Translation.Misc = {
	["Cooldown"] = "Cooldown",
	["Rank"] = "Rank",
	["Create"] = "Create"
}

-- Gestion de la détection des cibles protégées contre la peur
Necrosis.AntiFear = {
	-- Buffs giving temporary immunity to fear effects
	["Buff"] = {
		"Fear Ward",			-- Dwarf priest racial trait
		"Will of the Forsaken",	-- Forsaken racial trait
		"Fearless",				-- Trinket
		"Berserker Rage",		-- Warrior Fury talent
		"Recklessness",			-- Warrior Fury talent
		"Death Wish",			-- Warrior Fury talent
		"Bestial Wrath",		-- Hunter Beast Mastery talent
		"Ice Block",			-- Mage Ice talent
		"Divine Protection",	-- Paladin Holy buff
		"Divine Shield",		-- Paladin Holy buff
		"Tremor Totem",			-- Shaman totem
		"Abolish Magic"			-- Majordomo (NPC) spell
	},
	-- Debuffs and curses giving temporary immunity to fear effects
	["Debuff"] = {
	}
}

end
