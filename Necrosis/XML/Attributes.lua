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

-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)



------------------------------------------------------------------------------------------------------
-- DEFINITION OF INITIAL MENU ATTRIBUTES || DEFINITION INITIALE DES ATTRIBUTS DES MENUS
------------------------------------------------------------------------------------------------------

-- On crée les menus sécurisés pour les différents sorts Buff / Démon / Malédictions
function Necrosis:MenuAttribute(menu)
	if InCombatLockdown() then
		return
	end

	local menuButton = _G[menu]
	
	if not menuButton:GetAttribute("state") then 
		menuButton:SetAttribute("state", "Ferme")
	end
	
	if not menuButton:GetAttribute("lastClick") then 
		menuButton:SetAttribute("lastClick", "LeftButton")
	end
	
	if not menuButton:GetAttribute("close") then 
		menuButton:SetAttribute("close", 0)
	end
	
	menuButton:Execute([[
		ButtonList = table.new(self:GetChildren())
		if self:GetAttribute("state") == "Bloque" then
			for i, button in ipairs(ButtonList) do
				button:Show()
			end
		else
			for i, button in ipairs(ButtonList) do
				button:Hide()
			end
		end
	]])

	menuButton:SetAttribute("_onclick", [[
		self:SetAttribute("lastClick", button)
		local Etat = self:GetAttribute("state")
		if  Etat == "Ferme" then
			if button == "RightButton" then
				self:SetAttribute("state", "ClicDroit")
			else
				self:SetAttribute("state", "Ouvert")
			end
		elseif Etat == "Ouvert" then
			if button == "RightButton" then
				self:SetAttribute("state", "ClicDroit")
			else
				self:SetAttribute("state", "Ferme")
			end
		elseif Etat == "Combat" then
			for i, button in ipairs(ButtonList) do
				if button:IsShown() then
					--button:Hide()
				else
					--button:Show()
				end
			end
		elseif Etat == "ClicDroit" and button == "LeftButton" then
			self:SetAttribute("state", "Ferme")
		end
	]])
	
	menuButton:SetAttribute("_onattributechanged", [[
		if name == "state" then
			if value == "Ferme" then
				for i, button in ipairs(ButtonList) do
					button:Hide()
				end
			elseif value == "Ouvert" then
				for i, button in ipairs(ButtonList) do
					button:Show()
				end
				
				self:SetAttribute("close", self:GetAttribute("close") + 1)
				-- control:SetTimer(6, self:GetAttribute("close"))
			elseif value == "Combat" or value == "Bloque" then
				for i, button in ipairs(ButtonList) do
					button:Show()
				end
			elseif value == "Refresh" then
				self:SetAttribute("state", "Ouvert")
			elseif value == "ClicDroit" then
				for i, button in ipairs(ButtonList) do
					button:Show()
				end
			end
		end
	]])
	
	menuButton:SetAttribute("_ontimer", [[
		if self:GetAttribute("close") <= message and not self:GetAttribute("mousehere") then
			self:SetAttribute("state", "Ferme")
		end
	]])
end

function Necrosis:MetamorphosisAttribute()

	NecrosisMetamorphosisButton:Execute([[
		ButtonList = table.new(self:GetChildren())
	]])
	
	NecrosisMetamorphosisButton:SetAttribute("_onstate-stance", [[
		newstate = tonumber(newstate)
		if newstate == 2 then
			for i, button in ipairs(ButtonList) do
				button:Show()
			end
		else
			for i, button in ipairs(ButtonList) do
				button:Hide()
			end
		end
	]])
	
	RegisterStateDriver(NecrosisMetamorphosisButton, "stance", "[stance:2] 2;0")
end

------------------------------------------------------------------------------------------------------
-- DEFINITION INITIALE DES ATTRIBUTS DES SORTS
------------------------------------------------------------------------------------------------------

-- On associe les buffs au clic sur le bouton concerné
function Necrosis:BuffSpellAttribute()
	if InCombatLockdown() then
		return
	end

	-- Association de l'armure demoniaque si le sort est disponible
	if _G["NecrosisBuffMenu1"] then
		NecrosisBuffMenu1:SetAttribute("type", "spell")
		if not self.Spell[31].ID then
			NecrosisBuffMenu1:SetAttribute("spell",
				self.Spell[36].Name.."("..self.Spell[36].Rank..")"
			)
		else
			NecrosisBuffMenu1:SetAttribute("spell",
				self.Spell[31].Name.."("..self.Spell[31].Rank..")"
			)
		end
	end

	-- Buff menu buttons || Association des autres buffs aux boutons
	-- 31=Demon Armor | 47=Fel Armor | 32=Unending Breath | 33=Detect Invis | 34=Eye of Kilrogg | 37=Ritual of Summoning | 38=Soul Link | 43=Shadow Ward | 35=Enslave Demon | 59=Demonic Empowerment | 9=Banish
	local buffID = {31, 47, 32, 33, 34, 37, 38, 43, 59, 9}
	for i = 2, #buffID - 1, 1 do
		local f = _G["NecrosisBuffMenu"..i]
		if f then
			f:SetAttribute("type", "spell")
			-- Si le sort nécessite une cible, on lui en associe une
			if not (i == 2 or i == 5 or i == 7 or i == 8 or i == 9 or i == 10) then
				f:SetAttribute("unit", "target")
			end
			local SpellName_Rank = self.Spell[ buffID[i] ].Name
			if self.Spell[ buffID[i] ].Rank and not (self.Spell[ buffID[i] ].Rank == " ") then
				SpellName_Rank = SpellName_Rank.."("..self.Spell[ buffID[i] ].Rank..")"
			end
			f:SetAttribute("spell", SpellName_Rank)
		end
	end


	-- Cas particulier : Bouton de Banish
	if _G["NecrosisBuffMenu10"] then
		local SpellName_Rank = self.Spell[9].Name.."("..self.Spell[9].Rank..")"

		NecrosisBuffMenu10:SetAttribute("unit*", "target")				-- associate left & right clicks with target
		NecrosisBuffMenu10:SetAttribute("ctrl-unit*", "focus") 		-- associate CTRL+left or right clicks with focus

		if self.Spell[9].Rank:find("1") then	-- the warlock can only do Banish(Rank 1) 
			-- left & right click will perform the same macro
			NecrosisBuffMenu10:SetAttribute("type*", "macro")
			NecrosisBuffMenu10:SetAttribute("macrotext*", "/focus\n/cast "..SpellName_Rank)

			-- Si le démoniste control + click le bouton de banish || if the warlock uses ctrl-click then
			-- On rebanish la dernière cible bannie || rebanish the previously banished target
			NecrosisBuffMenu10:SetAttribute("ctrl-type*", "spell")
			NecrosisBuffMenu10:SetAttribute("ctrl-spell*", SpellName_Rank)
		end 

		if self.Spell[9].Rank:find("2") then -- the warlock has Banish(rank 2)
			local Rank1 = SpellName_Rank:gsub("2", "1")
			
			-- so lets use the "harmbutton" special attribute!
			-- assign Banish(rank 2) to LEFT click 
			NecrosisBuffMenu10:SetAttribute("harmbutton1", "banishrank2")
			NecrosisBuffMenu10:SetAttribute("type-banishrank2", "macro")
			NecrosisBuffMenu10:SetAttribute("macrotext-banishrank2", "/focus\n/cast "..SpellName_Rank)
			
			-- assign Banish(rank 1) to RIGHT click 
			NecrosisBuffMenu10:SetAttribute("harmbutton2", "banishrank1")
			NecrosisBuffMenu10:SetAttribute("type-banishrank1", "macro")
			NecrosisBuffMenu10:SetAttribute("macrotext-banishrank1", "/focus\n/cast "..Rank1)

			-- allow focused target to be rebanished with CTRL+LEFT or RIGHT click
			NecrosisBuffMenu10:SetAttribute("ctrl-type1", "spell")
			NecrosisBuffMenu10:SetAttribute("ctrl-spell1", SpellName_Rank)
			NecrosisBuffMenu10:SetAttribute("ctrl-type2", "spell")
			NecrosisBuffMenu10:SetAttribute("ctrl-spell2", Rank1)
		end

	end
end

-- On associe les démons au clic sur le bouton concerné
function Necrosis:PetSpellAttribute()
	if InCombatLockdown() then
		return
	end

	-- Démons maitrisés
	for i = 2, 6, 1 do
		local f = _G["NecrosisPetMenu"..i]
		if f then
			local SpellName_Rank = self.Spell[i+1].Name
			if self.Spell[i+1].Rank and not (self.Spell[i+1].Rank == " ") then
				SpellName_Rank = SpellName_Rank.."("..self.Spell[i+1].Rank..")"
			end
			f:SetAttribute("type1", "spell")
			f:SetAttribute("type2", "macro")
			f:SetAttribute("spell", SpellName_Rank)
			f:SetAttribute("macrotext",
				"/cast "..self.Spell[15].Name.."\n/stopcasting\n/cast "..SpellName_Rank
			)
		end
	end

	-- Autres sorts démoniaques
	local buttonID = {1, 7, 8, 9, 10, 11}
	local BuffID = {15, 8, 30, 35, 44, 59}
	for i = 1, #buttonID, 1 do
		local f = _G["NecrosisPetMenu"..buttonID[i]]
		if f then
			local SpellName_Rank = self.Spell[ BuffID[i] ].Name
			if self.Spell[ BuffID[i] ].Rank and not (self.Spell[ BuffID[i] ].Rank == " ") then
				SpellName_Rank = SpellName_Rank.."("..self.Spell[ BuffID[i] ].Rank..")"
			end
			f:SetAttribute("type", "spell")
			f:SetAttribute("spell", SpellName_Rank)
		end
	end
end

-- On associe les malédictions au clic sur le bouton concerné
function Necrosis:CurseSpellAttribute()
	if InCombatLockdown() then
		return
	end

	local buffID = {23, 22, 24, 25, 40, 26, 16, 14}
	for i = 1, #buffID, 1 do
		local f = _G["NecrosisCurseMenu"..i]
		if f then
			local SpellName_Rank = self.Spell[ buffID[i] ].Name
			if self.Spell[ buffID[i] ].Rank and not (self.Spell[ buffID[i] ].Rank == " ") then
				SpellName_Rank = SpellName_Rank.."("..self.Spell[ buffID[i] ].Rank..")"
			end
			f:SetAttribute("harmbutton", "debuff")
			f:SetAttribute("type-debuff", "spell")
			f:SetAttribute("unit", "target")
			f:SetAttribute("spell-debuff", SpellName_Rank)
		end
	end
end

-- Associating the frames to buttons, and creating stones on right-click.
-- Association de la monture au bouton, et de la création des pierres sur un clic droit
function Necrosis:StoneAttribute(Steed)
	if InCombatLockdown() then
		return
	end

	-- stones || Pour les pierres
	local itemName = {"Soulstone", "Healthstone", "Spellstone", "Firestone" }
	local buffID = {51,52,53,54}
	for i = 1, #itemName, 1 do
		local f = _G["Necrosis"..itemName[i].."Button"]
		if f then
			f:SetAttribute("type2", "spell")
			f:SetAttribute("spell2", self.Spell[ buffID[i] ].Name.."("..self.Spell[ buffID[i] ].Rank..")")
		end
	end

	-- mounts || Pour la monture
	if Steed and  _G["NecrosisMountButton"] then
		NecrosisMountButton:SetAttribute("type1", "spell")
		NecrosisMountButton:SetAttribute("type2", "spell")
		
		if (NecrosisConfig.LeftMount) then
			local leftMountName = GetSpellInfo(NecrosisConfig.LeftMount)
			NecrosisMountButton:SetAttribute("spell1", leftMountName)
		else
			if (self.Spell[2].ID) then
				NecrosisMountButton:SetAttribute("spell1", self.Spell[2].Name)
				NecrosisMountButton:SetAttribute("spell2", self.Spell[1].Name)
			else
				NecrosisMountButton:SetAttribute("spell*", self.Spell[1].Name)
			end			
		end
		
		if (NecrosisConfig.RightMount) then
			local rightMountName = GetSpellInfo(NecrosisConfig.RightMount)
			NecrosisMountButton:SetAttribute("spell2", rightMountName)
		end
	end

	-- hearthstone || Pour la pierre de foyer
	NecrosisSpellTimerButton:SetAttribute("unit1", "target")
	NecrosisSpellTimerButton:SetAttribute("type1", "macro")
	NecrosisSpellTimerButton:SetAttribute("macrotext", "/focus")
	NecrosisSpellTimerButton:SetAttribute("type2", "item")
	NecrosisSpellTimerButton:SetAttribute("item", self.Translation.Item.Hearthstone)
	
	-- metamorphosis menu || Pour le menu Métamorphose
	if _G["NecrosisMetamorphosisButton"] then
		NecrosisMetamorphosisButton:SetAttribute("type", "spell")
		NecrosisMetamorphosisButton:SetAttribute("spell", self.Spell[27].Name)
	end

	-- if the 'Ritual of Souls' spell is known, then associate it to the hearthstone shift-click.
	-- Cas particulier : Si le sort du Rituel des âmes existe, on l'associe au shift+clic healthstone.
	if _G["NecrosisHealthstoneButton"] and self.Spell[50].ID then
		NecrosisHealthstoneButton:SetAttribute("shift-type*", "spell")
		NecrosisHealthstoneButton:SetAttribute("shift-spell*", self.Spell[50].Name)
	end
	
	-- if the 'Ritual of Summoning' spell is known, then associate it to the soulstone shift-click.
	if _G["NecrosisSoulstoneButton"] and self.Spell[37].ID then
		NecrosisSoulstoneButton:SetAttribute("shift-type*", "spell")
		NecrosisSoulstoneButton:SetAttribute("shift-spell*", self.Spell[37].Name)
	end
	
	
end

-- Association de la Connexion au bouton central si le sort est disponible
function Necrosis:MainButtonAttribute()
	-- Le clic droit ouvre le Menu des options
	NecrosisButton:SetAttribute("type2", "Open")
	NecrosisButton.Open = function()
		if not InCombatLockdown() then
			Necrosis:OpenConfigPanel()
		end
	end

	if Necrosis.Spell[NecrosisConfig.MainSpell].ID then
		NecrosisButton:SetAttribute("type1", "spell")
		NecrosisButton:SetAttribute("spell", Necrosis.Spell[NecrosisConfig.MainSpell].Name)
	end
end


------------------------------------------------------------------------------------------------------
-- DEFINITION DES ATTRIBUTS DES SORTS EN FONCTION DU COMBAT / REGEN
------------------------------------------------------------------------------------------------------

function Necrosis:NoCombatAttribute(SoulstoneMode, FirestoneMode, SpellstoneMode, Pet, Buff, Curse)

	-- Si on veut que le menu s'engage automatiquement en combat
	-- Et se désengage à la fin
	if NecrosisConfig.AutomaticMenu and not NecrosisConfig.BlockedMenu then
		if _G["NecrosisPetMenuButton"] then
			if NecrosisPetMenuButton:GetAttribute("lastClick") == "RightButton" then
				NecrosisPetMenuButton:SetAttribute("state", "ClicDroit")
			else
				NecrosisPetMenuButton:SetAttribute("state", "Ferme")
			end
			if NecrosisConfig.ClosingMenu then
				for i = 1, #Pet, 1 do
					NecrosisPetMenuButton:WrapScript(Pet[i], "OnClick", [[
						if self:GetParent():GetAttribute("state") == "Ouvert" then
							self:GetParent():SetAttribute("state", "Ferme")
						end
					]])
				end
			end
		end
		if _G["NecrosisBuffMenuButton"] then
			if NecrosisBuffMenuButton:GetAttribute("lastClick") == "RightButton" then
				NecrosisBuffMenuButton:SetAttribute("state", "ClicDroit")
			else
				NecrosisBuffMenuButton:SetAttribute("state", "Ferme")
			end
			if NecrosisConfig.ClosingMenu then
				for i = 1, #Buff, 1 do
					NecrosisBuffMenuButton:WrapScript(Buff[i], "OnClick", [[
						if self:GetParent():GetAttribute("state") == "Ouvert" then
							self:GetParent():SetAttribute("state", "Ferme")
						end
					]])
				end
			end
		end
		if _G["NecrosisCurseMenuButton"] then
			if NecrosisCurseMenuButton:GetAttribute("lastClick") == "RightButton" then
				NecrosisCurseMenuButton:SetAttribute("state", "ClicDroit")
			else
				NecrosisCurseMenuButton:SetAttribute("state", "Ferme")
			end
			if NecrosisConfig.ClosingMenu then
				for i = 1, #Curse, 1 do
					NecrosisCurseMenuButton:WrapScript(Curse[i], "OnClick", [[
						if self:GetParent():GetAttribute("state") == "Ouvert" then
							self:GetParent():SetAttribute("state", "Ferme")
						end
					]])
				end
			end
		end
	end


	-- Si on connait l'emplacement de la pierre de sort,
	-- Alors cliquer sur le bouton de pierre de sort l'équipe.
	if NecrosisConfig.ItemSwitchCombat[1] and _G["NecrosisSpellstoneButton"] then
		NecrosisSpellstoneButton:SetAttribute("type1", "macro")
		NecrosisSpellstoneButton:SetAttribute("macrotext*","/cast "..NecrosisConfig.ItemSwitchCombat[1].."\n/use 16")
	end
	-- Si on connait l'emplacement de la pierre de feu,
	-- Alors cliquer sur le bouton de pierre de feu l'équipe.
	if NecrosisConfig.ItemSwitchCombat[2] and _G["NecrosisFirestoneButton"] then
		NecrosisFirestoneButton:SetAttribute("type1", "macro")
		NecrosisFirestoneButton:SetAttribute("macrotext*", "/cast "..NecrosisConfig.ItemSwitchCombat[2].."\n/use 16")
	end
end

function Necrosis:InCombatAttribute(Pet, Buff, Curse)

	-- Si on veut que le menu s'engage automatiquement en combat
	if NecrosisConfig.AutomaticMenu and not NecrosisConfig.BlockedMenu then
		if _G["NecrosisPetMenuButton"] and NecrosisConfig.StonePosition[7] then
			NecrosisPetMenuButton:SetAttribute("state", "Combat")
			if NecrosisConfig.ClosingMenu then
				for i = 1, #Pet, 1 do
					NecrosisPetMenuButton:UnwrapScript(Pet[i], "OnClick")
				end
			end
		end
		if _G["NecrosisBuffMenuButton"] and NecrosisConfig.StonePosition[5] then
			NecrosisBuffMenuButton:SetAttribute("state", "Combat")
			if NecrosisConfig.ClosingMenu then
				for i = 1, #Buff, 1 do
					NecrosisBuffMenuButton:UnwrapScript(Buff[i], "OnClick")
				end
			end
		end
		if _G["NecrosisCurseMenuButton"] and NecrosisConfig.StonePosition[8] then
			NecrosisCurseMenuButton:SetAttribute("state", "Combat")
			if NecrosisConfig.ClosingMenu then
				for i = 1, #Curse, 1 do
					NecrosisCurseMenuButton:UnwrapScript(Curse[i], "OnClick")
				end
			end
		end
	end

	-- Si on connait le nom de la pierre de sort,
	-- Alors le clic gauche utiliser la pierre
	if NecrosisConfig.ItemSwitchCombat[1] and _G["NecrosisSpellstoneButton"] then
		NecrosisSpellstoneButton:SetAttribute("type1", "macro")
		NecrosisSpellstoneButton:SetAttribute("macrotext*", "/cast "..NecrosisConfig.ItemSwitchCombat[1].."\n/use 16")
	end

	-- Si on connait le nom de la pierre de feu,
	-- Alors le clic sur le bouton équipera la pierre
	if NecrosisConfig.ItemSwitchCombat[2] and _G["NecrosisFirestoneButton"] then
		NecrosisFirestoneButton:SetAttribute("type1", "macro")
		NecrosisFirestoneButton:SetAttribute("macrotext*", "/cast "..NecrosisConfig.ItemSwitchCombat[2].."\n/use 16")
	end

	-- Si on connait le nom de la pierre de soin,
	-- Alors le clic gauche sur le bouton utilisera la pierre
	if NecrosisConfig.ItemSwitchCombat[3] and _G["NecrosisHealthstoneButton"] then
		NecrosisHealthstoneButton:SetAttribute("type1", "macro")
		NecrosisHealthstoneButton:SetAttribute("macrotext1", "/stopcasting \n/use "..NecrosisConfig.ItemSwitchCombat[3])
	end

	-- Si on connait le nom de la pierre d'âme,
	-- Alors le clic gauche sur le bouton utilisera la pierre
	if NecrosisConfig.ItemSwitchCombat[4] and _G["NecrosisSoulstoneButton"] then
		NecrosisSoulstoneButton:SetAttribute("type1", "item")
		NecrosisSoulstoneButton:SetAttribute("unit", "target")
		NecrosisSoulstoneButton:SetAttribute("item1", NecrosisConfig.ItemSwitchCombat[4])
	end
end

------------------------------------------------------------------------------------------------------
-- DEFINITION SITUATIONNELLE DES ATTRIBUTS DES SORTS
------------------------------------------------------------------------------------------------------

function Necrosis:SoulstoneUpdateAttribute(nostone)
	-- Si le démoniste est en combat, on ne fait rien :)
	if InCombatLockdown() or not _G["NecrosisSoulstoneButton"] then
		return
	end

	-- Si le démoniste n'a pas de pierre dans son inventaire,
	-- Un clic gauche crée la pierre
	if nostone then
		NecrosisSoulstoneButton:SetAttribute("type1", "spell")
		NecrosisSoulstoneButton:SetAttribute("spell1", self.Spell[51].Name.."("..self.Spell[51].Rank..")")
		return
	end

	NecrosisSoulstoneButton:SetAttribute("type1", "item")
	NecrosisSoulstoneButton:SetAttribute("type3", "item")
	NecrosisSoulstoneButton:SetAttribute("unit", "target")
	NecrosisSoulstoneButton:SetAttribute("item1", NecrosisConfig.ItemSwitchCombat[4])
	NecrosisSoulstoneButton:SetAttribute("item3", NecrosisConfig.ItemSwitchCombat[4])
end

function Necrosis:HealthstoneUpdateAttribute(nostone)
	-- Si le démoniste est en combat, on ne fait rien :)
	if InCombatLockdown() or not _G["NecrosisHealthstoneButton"] then
		return
	end

	-- Si le démoniste n'a pas de pierre dans son inventaire,
	-- Un clic gauche crée la pierre
	if nostone then
		NecrosisHealthstoneButton:SetAttribute("type1", "spell")
		NecrosisHealthstoneButton:SetAttribute("spell1", self.Spell[52].Name.."("..self.Spell[52].Rank..")")
		return
	end

	NecrosisHealthstoneButton:SetAttribute("type1", "macro")
	NecrosisHealthstoneButton:SetAttribute("macrotext1", "/stopcasting \n/use "..NecrosisConfig.ItemSwitchCombat[3])
	NecrosisHealthstoneButton:SetAttribute("type3", "Trade")
	NecrosisHealthstoneButton:SetAttribute("ctrl-type1", "Trade")
	NecrosisHealthstoneButton.Trade = function () self:TradeStone() end
end

function Necrosis:SpellstoneUpdateAttribute(nostone)
	-- Si le démoniste est en combat, on ne fait rien :)
	if InCombatLockdown() or not _G["NecrosisSpellstoneButton"] then
		return
	end

	-- Si le démoniste n'a pas de pierre dans son inventaire,
	-- Un clic gauche crée la pierre
	if nostone then
		NecrosisSpellstoneButton:SetAttribute("type1", "spell")
		NecrosisSpellstoneButton:SetAttribute("spell*", self.Spell[53].Name.."("..self.Spell[53].Rank..")")
		return
	end

	NecrosisSpellstoneButton:SetAttribute("type1", "macro")
	NecrosisSpellstoneButton:SetAttribute("macrotext*", "/cast "..NecrosisConfig.ItemSwitchCombat[1].."\n/use 16")
end

function Necrosis:FirestoneUpdateAttribute(nostone)
	-- Si le démoniste est en combat, on ne fait rien :)
	if InCombatLockdown() or not _G["NecrosisFirestoneButton"] then
		return
	end

	-- Si le démoniste n'a pas de pierre dans son inventaire,
	-- Un clic gauche crée la pierre
	if nostone then
		NecrosisFirestoneButton:SetAttribute("type1", "spell")
		NecrosisFirestoneButton:SetAttribute("spell*", self.Spell[54].Name.."("..self.Spell[54].Rank..")")
		return
	end

	NecrosisFirestoneButton:SetAttribute("type1", "macro")
	NecrosisFirestoneButton:SetAttribute("macrotext*", "/cast "..NecrosisConfig.ItemSwitchCombat[2].."\n/use 16")
end
