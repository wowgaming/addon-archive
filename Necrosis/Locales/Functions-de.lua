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
-- GERMAN  VERSION FUNCTIONS --
------------------------------------------------

if ( GetLocale() == "deDE" ) then

-- Types d'unité des PnJ utilisés par Necrosis
Necrosis.Unit = {
	["Undead"] = "Untoter",
	["Demon"] = "D\195\164mon",
	["Elemental"] = "Elementar",
}

-- Traduction du nom des procs utilisés par Necrosis
Necrosis.Translation.Proc = {
	["Backlash"] = "Heimzahlen",
	["ShadowTrance"] = "Schattentrance"
}

-- Traduction des noms des démons invocables
Necrosis.Translation.DemonName = {
	[1] = "Wichtel",
	[2] = "Leerwandler",
	[3] = "Sukkubus",
	[4] = "Teufelsj\195\164ger",
	[5] = "Teufelswache",
	[6] = "H\195\182llenbestie",
	[7] = "Verdammniswache"
}

-- Traduction du nom des objets utilisés par Necrosis
Necrosis.Translation.Item = {
	["Soulshard"] = "Seelensplitter",
	["Soulstone"] = "Seelenstein",
	["Healthstone"] = "Gesundheitsstein",
	["Spellstone"] = "Zauberstein",
	["Firestone"] = "Feuerstein",
	["InfernalStone"] = "H\195\182llenstein",
	["DemoniacStone"] = "D\195\164monenstatuette",
	["Hearthstone"] = "Ruhestein",
	["SoulPouch"] = {"Kleiner Seelenbeutel", "Seelenkasten", "Seelenbeutel", "Teufelsstofftasche", "Abgr\195\188ndige Tasche", "Kernteufelsstofftasche", "Schwarzschattentasche"}
}

-- Traductions diverses
Necrosis.Translation.Misc = {
	["Cooldown"] = "Cooldown",
	["Rank"] = "Rang",
	["Create"] = "herstellen"
}

-- Gestion de la détection des cibles protégées contre la peur
Necrosis.AntiFear = {
	-- Buffs donnant une immunité temporaire au Fear
	["Buff"] = {
		"Furchtzauberschutz",			-- Dwarf priest racial trait
		"Wille der Verlassenen",		-- Forsaken racial trait
		"Furchtlos",					-- Trinket
		"Berserkerwut",					-- Warrior Fury talent
		"Tollk\195\188hnheit",			-- Warrior Fury talent
		"Todeswunsch",					-- Warrior Fury talent
		"Zorn des Wildtieres",			-- Hunter Beast Mastery talent (pet only)
		"Eisblock",						-- Mage Ice talent
		"G\195\182ttlicher Schutz",		-- Paladin Holy buff
		"Gottesschild",					-- Paladin Holy buff
		"Totem des Erdsto\195\159es",	-- Shaman totem
		"Abolish Magic"					-- Majordomo (NPC) spell
	},
	-- Debuffs donnant une immunité temporaire au Fear
	["Debuff"] = {
	}
}

end
