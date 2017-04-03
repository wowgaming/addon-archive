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
-- Version $LastChangedDate: 2009-03-17 15:00:27 +1100 (Tue, 17 Mar 2009) $
------------------------------------------------------------------------------------------------------

------------------------------------------------
-- SPANISH  VERSION FUNCTIONS --
------------------------------------------------

if ( GetLocale() == "esES" ) or ( GetLocale() == "esMX" ) then

Necrosis.Unit = {
	["Undead"] = "No-muerto",
	["Demon"] = "Demonio",
	["Elemental"] = "Elemental",
}

-- Traduction du nom des procs utilisés par Necrosis
Necrosis.Translation.Proc = {
	["Backlash"] = "Contragolpe",
	["ShadowTrance"] = "Trance de las Sombras"
}

-- Traduction des noms des démons invocables
Necrosis.Translation.DemonName = {
	[1] = "Diablillo",
	[2] = "Abisario",
	[3] = "S\195\186cubo",
	[4] = "Man\195\161fago",
	[5] = "Guardia maldito",
	[6] = "Inferno",
	[7] = "Guardia apocal\195\173ptico"
}

-- Traduction du nom des objets utilisés par Necrosis
Necrosis.Translation.Item = {
	["Soulshard"] = "Fragmento de Alma",
	["Soulstone"] = "Piedra de alma",
	["Healthstone"] = "Piedra de salud",
	["Spellstone"] = "Piedra de hechizo",
	["Firestone"] = "Piedra de fuego",
	["InfernalStone"] = "Piedra infernal",
	["DemoniacStone"] = "Figura demon\195\173aca",
	["Hearthstone"] = "Piedra de hogar",
	["SoulPouch"] = {"Faltriquera de almas", "Faltriquera de almas", "Caja de almas", "Bolsa de tela vil", "Bolsa de tela vil del N\195\186cleo", "Bolsa abisal", "Bolsa de las Sombras de \195\169bano"}
}

-- Traductions diverses
Necrosis.Translation.Misc = {
	["Cooldown"] = "Tiempo de reutilizaci\195\179n restante",
	["Rank"] = "Rango",
	["Create"] = "Crear"
}

-- Gestion de la détection des cibles protégées contre la peur
Necrosis.AntiFear = {
	-- Bufos que dan inmunidad temporal a los efectos de miedo
	["Buff"] = {
		"Custodia de miedo",			-- Dwarf priest racial trait
		"Voluntad de los Renegados.",	-- Forsaken racial trait
		"Audacia",						-- Trinket
		"Ira rabiosa",					-- Warrior Fury talent
		"Temeridad",					-- Warrior Fury talent
		"Deseo de la muerte",			-- Warrior Fury talent
		"C\195\179lera de las bestias",	-- Hunter Beast Mastery talent (pet only)
		"Bloqueo de hielo",				-- Mage Ice talent
		"Protecci\195\179n divina",		-- Paladin Holy buff
		"Escudo divino",				-- Paladin Holy buff
		"T\195\179tem de tremor",		-- Shaman totem
		"Suprimir magia"				-- Majordomo (NPC) spell
	},
	-- Debufos y maldiciones que dan inmunidad temporal a los efectos de miedo
	["Debuff"] = {
	}
}

end
