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
-- VERSION FRANCAISE DES FONCTIONS --
------------------------------------------------

if ( GetLocale() == "frFR" ) then

-- Types d'unité des PnJ utilisés par Necrosis
Necrosis.Unit = {
	["Undead"] ="Mort-vivant",
	["Demon"] = "D\195\169mon",
	["Elemental"] = "El\195\169mentaire"
}

-- Traduction du nom des procs utilisés par Necrosis
Necrosis.Translation.Proc = {
	["Backlash"] = "Contrecoup",
	["ShadowTrance"] = "Transe de l'ombre"
}

-- Traduction des noms des démons invocables
Necrosis.Translation.DemonName = {
	[1] = "Diablotin",
	[2] = "Marcheur du Vide",
	[3] = "Succube",
	[4] = "Chasseur corrompu",
	[5] = "Gangregarde",
	[6] = "Infernal",
	[7] = "Garde funeste"
}

-- Traduction du nom des objets utilisés par Necrosis
Necrosis.Translation.Item = {
	["Soulshard"] = "Fragment d'\195\162me",
	["Soulstone"] = "Pierre d'\195\162me",
	["Healthstone"] = "Pierre de soins",
	["Spellstone"] = "Pierre de sort",
	["Firestone"] = "Pierre de feu",
	["InfernalStone"] = "Pierre infernale",
	["DemoniacStone"] = "Figurine d\195\169moniaque",
	["Hearthstone"] = "Pierre de foyer",
	["SoulPouch"] = {"Bourse d'\195\162me", "Bourse d'\195\162me", "Bo\195\174te d'\192\162mes", "Sac en gangr\195\169toffe", "Sac en gangr\195\169toffe du Magma", "Sac abyssal", "Ombresac d'\195\169b\195\168ne"}
}

-- Traductions diverses
Necrosis.Translation.Misc = {
	["Cooldown"] = "Temps",
	["Rank"] = "Rang",
	["Create"] = "Cr\195\169ation"
}

-- Gestion de la détection des cibles protégées contre la peur
Necrosis.AntiFear = {
	-- Buffs donnant une immunité temporaire au Fear
	["Buff"] = {
		"Gardien de peur",								-- Capacité raciale des prêtres nains
		"Volont\195\169 des r\195\169prouv\195\169",	-- Capacité raciale réprouvée
		"Sans peur",									-- Trinket
		"Furie Berzerker",								-- Talent Guerrier (Branche Fury)
		"T\195\169m\195\169rit\195\169",				-- Talent Guerrier (Branche Fury)
		"Souhait mortel",								-- Talent Guerrier (Branche Fury)
		"Courroux bestial",								-- Talent Chasseur (Branche Beast)
		"Carapace de glace",							-- Talent Mage (Branche Ice)
		"Protection divine",							-- Buff sacré Paladin
		"Bouclier divin",								-- Buff sacré Paladin
		"Totem de s\195\169isme",						-- Totem
		"Abolir la magie"								-- Sort de Majordomo (PnJ)
	},
	-- Debuffs donnant une immunité temporaire au Fear
	["Debuff"] = {
	}
}

end
