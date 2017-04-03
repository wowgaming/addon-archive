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
-- Version $LastChangedDate: 2009-12-10 17:09:53 +1100 (Thu, 10 Dec 2009) $
------------------------------------------------------------------------------------------------------

local new, del
do
	local cache = setmetatable({}, {__mode='k'})
	function new(populate, ...)
		local tbl
		local t = next(cache)
		if ( t ) then
			cache[t] = nil
			tbl = t
		else
			tbl = {}
		end
		if ( populate ) then
			local num = select("#", ...)
			if ( populate == "hash" ) then
				assert(math.fmod(num, 2) == 0)
				local key
				for i = 1, num do
					local v = select(i, ...)
					if not ( math.fmod(i, 2) == 0 ) then
						key = v
					else
						tbl[key] = v
						key = nil
					end
				end
			elseif ( populate == "array" ) then
				for i = 1, num do
					local v = select(i, ...)
					table.insert(tbl, i, v)
				end
			end
		end
		return tbl
	end
	function del(t)
		for k in next, t do
			t[k] = nil
		end
		cache[t] = true
	end
end


-- Fonction pour relocaliser  automatiquemlent des éléments en fonction du client
function Necrosis:SpellLocalize(tooltip) 

	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Relocalisation des Sorts
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	if not tooltip then
		self.Spell = {
			[1] = {Name = GetSpellInfo(5784), 				Length = 0,		Type = 0}, -- Felsteed
			[2] = {Name = GetSpellInfo(23161), 			 	Length = 0,		Type = 0}, -- Dreadsteed
			[3] = {Name = GetSpellInfo(688), 				Length = 0,		Type = 0}, -- Imp || Diablotin 
			[4] = {Name = GetSpellInfo(697),				Length = 0,		Type = 0}, -- Voidwalker || Marcheur
			[5] = {Name = GetSpellInfo(712),				Length = 0,		Type = 0}, -- Succubus || Succube
			[6] = {Name = GetSpellInfo(691),				Length = 0,		Type = 0}, -- Fellhunter
			[7] = {Name = GetSpellInfo(30146),				Length = 0,		Type = 0}, -- Felguard
			[8] = {Name = GetSpellInfo(1122),				Length = 600,	Type = 3}, -- Infernal
			[9] = {Name = GetSpellInfo(18647),				Length = 30,	Type = 2}, -- Banish
			[10] = {Name = GetSpellInfo(1098),				Length = 300,	Type = 2}, -- Enslave
			[11] = {Name = GetSpellInfo(27239),				Length = 900,	Type = 1}, -- Soulstone Resurrection || Résurrection de pierre d'ame
			[12] = {Name = GetSpellInfo(47811),				Length = 15,	Type = 6}, -- Immolate
			[13] = {Name = GetSpellInfo(6215),				Length = 15,	Type = 6}, -- Fear
			[14] = {Name = GetSpellInfo(47813),				Length = 18,	Type = 5}, -- Corruption
			[15] = {Name = GetSpellInfo(18708),				Length = 180,	Type = 3}, -- Fel Domination || Domination corrompue
			[16] = {Name = GetSpellInfo(47867),				Length = 60,	Type = 3}, -- Curse of Doom || Malédiction funeste
			[17] = {Name = GetSpellInfo(47847),				Length = 20,	Type = 3}, -- Shadowfury || Furie de l'ombre
			[18] = {Name = GetSpellInfo(47825),				Length = 60,	Type = 3}, -- Soul Fire || Feu de l'âme
			[19] = {Name = GetSpellInfo(47860),				Length = 120,	Type = 3}, -- Death Coil || Voile mortel
			[20] = {Name = GetSpellInfo(47827),				Length = 15,	Type = 3}, -- Shadowburn || Brûlure de l'ombre
			[21] = {Name = GetSpellInfo(17962),				Length = 10,	Type = 3}, -- Conflagration
			[22] = {Name = GetSpellInfo(47864),				Length = 24,	Type = 4}, -- Curse of Agony || Malédiction Agonie
			[23] = {Name = GetSpellInfo(50511),				Length = 120,	Type = 4}, -- Curse of Weakness || Malédiction Faiblesse
			[24] = {Name = nil,				Length = 0,	Type = 0}, -- Curse of Recklessness - removed in patch 3.1 || Malédiction Témérité || 
			[25] = {Name = GetSpellInfo(11719),				Length = 30,	Type = 4}, -- Curse of Tongues || Malédiction Langage
			[26] = {Name = GetSpellInfo(47865),				Length = 300,	Type = 4}, -- Curse of the Elements || Malédiction Eléments
			[27] = {Name = GetSpellInfo(59673),				Length = 180,	Type = 3}, -- Metamorphosis || Metamorphose
			[28] = {Name = GetSpellInfo(47862),				Length = 30,	Type = 6}, -- Siphon Life || Syphon de vie
			[29] = {Name = GetSpellInfo(17928),				Length = 40,	Type = 3}, -- Howl of Terror || Hurlement de terreur
			[30] = {Name = GetSpellInfo(18540),				Length = 1800,	Type = 3}, -- Ritual of Doom || Rituel funeste
			[31] = {Name = GetSpellInfo(47889),				Length = 0,		Type = 0}, -- Demon Armor || Armure démoniaque
			[32] = {Name = GetSpellInfo(5697),				Length = 600,		Type = 2}, -- Unending Breath || Respiration interminable
			[33] = {Name = GetSpellInfo(132),				Length = 0,		Type = 0}, -- Detect Invisibility || Détection de l'invisibilité
			[34] = {Name = GetSpellInfo(126),				Length = 0,		Type = 0}, -- Eye of Kilrogg
			[35] = {Name = GetSpellInfo(1098),				Length = 0,		Type = 0}, -- Enslave Demon
			[36] = {Name = GetSpellInfo(696),				Length = 0,		Type = 0}, -- Demon Skin || Peau de démon 
			[37] = {Name = GetSpellInfo(698),				Length = 120,		Type = 3}, -- Ritual of Summoning || Rituel d'invocation
			[38] = {Name = GetSpellInfo(19028),				Length = 0,		Type = 0}, -- Soul Link || Lien spirituel
			[39] = {Name = GetSpellInfo(54785),				Length = 45,		Type = 3}, -- Demon Charge || Charge démoniaque
			[40] = {Name = GetSpellInfo(18223),				Length = 12,	Type = 4}, -- Curse of Exhaustion || Malédiction de fatigue
			[41] = {Name = GetSpellInfo(57946),				Length = 40,	Type = 2}, -- Life Tap || Connexion
			[42] = {Name = GetSpellInfo(59164),				Length = 12,	Type = 2}, -- Haunt || Hanter
			[43] = {Name = GetSpellInfo(47891),				Length = 30,	Type = 3}, -- Shadow Ward || Gardien de l'ombre
			[44] = {Name = GetSpellInfo(18788),				Length = 0,		Type = 0}, -- Demonic Sacrifice || Sacrifice démoniaque 
			[45] = {Name = GetSpellInfo(47809),				Length = 0,		Type = 0}, -- Shadow Bolt
			[46] = {Name = GetSpellInfo(47843),				Length = 18,	Type = 6}, -- Unstable Affliction || Affliction instable
			[47] = {Name = GetSpellInfo(47893),				Length = 0,		Type = 0}, -- Fel Armor || Gangrarmure
			[48] = {Name = GetSpellInfo(47836),				Length = 18,	Type = 5}, -- Seed of Corruption || Graine de Corruption
			[49] = {Name = GetSpellInfo(29858),				Length = 180,	Type = 3}, -- SoulShatter || Brise âme
			[50] = {Name = GetSpellInfo(58887),				Length = 300,	Type = 3}, -- Ritual of Souls || Rituel des âmes
			[51] = {Name = GetSpellInfo(47884),				Length = 0,		Type = 0}, -- Create Soulstone || Création pierre d'âme
			[52] = {Name = GetSpellInfo(47878),				Length = 0,		Type = 0}, -- Create Healthstone || Création pierre de soin
			[53] = {Name = GetSpellInfo(47888),				Length = 0,		Type = 0}, -- Create Spellstone || Création pierre de sort
			[54] = {Name = GetSpellInfo(60220),				Length = 0,		Type = 0}, -- Create Firestone || Création pierre de feu
			[55] = {Name = GetSpellInfo(59092),				Length = 0,		Type = 0}, -- Dark Pact || Pacte noir
			[56] = {Name = GetSpellInfo(50581),				Length = 0,		Type = 0}, -- Shadow Cleave || Enchainement d'ombre
			[57] = {Name = GetSpellInfo(50589),				Length = 30,	Type = 3}, -- Immolation Aura || Aura d'immolation
			[58] = {Name = GetSpellInfo(59671),				Length = 15,	Type = 3}, -- Challenging Howl || Hurlement de défi
			[59] = {Name = GetSpellInfo(47193),				Length = 60,	Type = 3}, -- Demonic Empowerment || Renforcement démoniaque
		}
		-- Type 0 = Pas de Timer || no timer
		-- Type 1 = Timer permanent principal || Standing main timer
		-- Type 2 = Timer permanent || main timer
		-- Type 3 = Timer de cooldown || cooldown timer
		-- Type 4 = Timer de malédiction || curse timer
		-- Type 5 = Timer de corruption || corruption timer
		-- Type 6 = Timer de combat || combat timer

		for i in ipairs(self.Spell) do
			self.Spell[i].Rank = " "
		end
	end
	
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Relocalisation des Tooltips
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- stones || Pierres
	local buttonTooltip = new("array",
		"Soulstone",
		"Healthstone",
		"Spellstone",
		"Firestone"
	)
	local colorCode = new("array",
		"|c00FF99FF", "|c0066FF33", "|c0099CCFF", "|c00FF4444"
	)
	for i, button in ipairs(buttonTooltip) do
		if not self.TooltipData[button] then
			self.TooltipData[button] = {}
		end
		self.TooltipData[button].Label = colorCode[i]..self.Translation.Item[button].."|r"
	end
	del(buttonTooltip)
	del(colorCode)
	
	-- Buffs
	local buttonTooltip = new("array",
		"Domination",
		"Enslave",
		"Armor",
		"FelArmor",
		"Invisible",
		"Aqua",
		"Kilrogg",
		"Banish",
		"TP",
		"RoS",
		"SoulLink",
		"ShadowProtection",
		"Renforcement"
	)
	local buttonName = new("array",
		15, 35, 31, 47, 33, 32, 34, 9, 37, 50, 38, 43, 59
	)
	for i, button in ipairs(buttonTooltip) do
		if not self.TooltipData[button] then
			self.TooltipData[button] = {}
		end
		self.TooltipData[button].Label = "|c00FFFFFF"..self.Spell[buttonName[i]].Name.."|r"
	end
	del(buttonTooltip)
	del(colorCode)
	del(buttonName)
	
	-- Demons
	local buttonTooltip = new("array",
		"Sacrifice",
		"Metamorphosis",
		"Charge",
		"Enchainement",
		"Immolation",
		"Defi",
		"Renforcement",
		"Enslave"
	)
	local buttonName = new("array",
		44, 27, 39, 56, 57, 58, 59, 35
	)
	for i, button in ipairs(buttonTooltip) do
		if not self.TooltipData[button] then
			self.TooltipData[button] = {}
		end
		self.TooltipData[button].Label = "|c00FFFFFF"..self.Spell[buttonName[i]].Name.."|r"
	end
	del(buttonTooltip)
	del(colorCode)
	del(buttonName)
	
	-- Curses || Malédiction
	local buttonTooltip = new("array",
		"Weakness",
		"Agony",
		"Tongues",
		"Exhaust",
		"Elements",
		"Doom",
		"Corruption"
	)
	local buttonName = new("array",
		23, 22, 25, 40, 26, 16, 14
	)
	for i, button in ipairs(buttonTooltip) do
		if not self.TooltipData[button] then
			self.TooltipData[button] = {}
		end
		self.TooltipData[button].Label = "|c00FFFFFF"..self.Spell[buttonName[i]].Name.."|r"
	end
	del(buttonTooltip)
	del(colorCode)
	del(buttonName)
end