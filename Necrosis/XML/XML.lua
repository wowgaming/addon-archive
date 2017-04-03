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
-- $LastChangedDate: 2009-08-16 18:38:07 +1000 (Sun, 16 Aug 2009) $
------------------------------------------------------------------------------------------------------

-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)

------------------------------------------------------------------------------------------------------
-- ANCHOR FOR THE GRAPHICS/TEXT TIMER || ANCRES DES TIMERS GRAPHIQUES ET TEXTUELS
------------------------------------------------------------------------------------------------------

function Necrosis:CreateTimerAnchor()

	if NecrosisConfig.TimerType == 1 then
		-- Create the graphical timer frame || Création de l'ancre invisible des timers graphiques
		local f = _G["NecrosisTimerFrame0"]
		if not f then
			f = CreateFrame("Frame", "NecrosisTimerFrame0", UIParent)
			f:SetWidth(150)
			f:SetHeight(10)
			f:Show()
			f:ClearAllPoints()
			f:SetPoint("LEFT", NecrosisSpellTimerButton, "CENTER", 50, 0)
		end
	elseif NecrosisConfig.TimerType == 2 then
		-- Create the text timer || Création de la liste des Timers Textes
		local FontString = _G["NecrosisListSpells"]
		if not FontString then
			FontString = NecrosisSpellTimerButton:CreateFontString(
				"NecrosisListSpells", nil, "GameFontNormalSmall"
			)
		end

		-- Define the attributes || Définition de ses attributs
		FontString:SetJustifyH("LEFT")
		FontString:SetPoint("LEFT", "NecrosisSpellTimerButton", "LEFT", 23, 0)
		FontString:SetTextColor(1, 1, 1)
	end
end

function Necrosis:CreateWarlockUI()

------------------------------------------------------------------------------------------------------
-- TIMER BUTTON || BOUTON DU TIMER DES SORTS
------------------------------------------------------------------------------------------------------

	-- Create the timer button || Création du bouton de Timer des sorts
	local frame = nil
	frame = _G["NecrosisSpellTimerButton"]
	if not frame then
		frame = CreateFrame("Button", "NecrosisSpellTimerButton", UIParent, "SecureActionButtonTemplate")
	end

	-- Define its attributes || Définition de ses attributs
	frame:SetFrameStrata("MEDIUM")
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetWidth(34)
	frame:SetHeight(34)
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\SpellTimerButton-Normal")
	frame:SetPushedTexture("Interface\\AddOns\\Necrosis\\UI\\SpellTimerButton-Pushed")
	frame:SetHighlightTexture("Interface\\AddOns\\Necrosis\\UI\\SpellTimerButton-Highlight")
	frame:RegisterForClicks("AnyUp")
	frame:Show()

	-- Create the timer anchor || Création des ancres des timers
	self:CreateTimerAnchor()

	-- Edit the scripts associated with the button || Edition des scripts associés au bouton
	frame:SetScript("OnLoad", function()
		this:RegisterForDrag("LeftButton")
		this:RegisterForClicks("RightButtonUp")
	end)
	frame:SetScript("OnEnter", function() Necrosis:BuildTooltip(this, "SpellTimer", "ANCHOR_RIGHT", "Timer") end)
	frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
	frame:SetScript("OnMouseUp", function() Necrosis:OnDragStop(this) end)
	frame:SetScript("OnDragStart", function() Necrosis:OnDragStart(this) end)
	frame:SetScript("OnDragStop", function() Necrosis:OnDragStop(this) end)

	-- Place the button window at its saved location || Placement de la fenêtre à l'endroit sauvegardé ou à l'emplacement par défaut
	frame:ClearAllPoints()
	frame:SetPoint(
		NecrosisConfig.FramePosition["NecrosisSpellTimerButton"][1],
		NecrosisConfig.FramePosition["NecrosisSpellTimerButton"][2],
		NecrosisConfig.FramePosition["NecrosisSpellTimerButton"][3],
		NecrosisConfig.FramePosition["NecrosisSpellTimerButton"][4],
		NecrosisConfig.FramePosition["NecrosisSpellTimerButton"][5]
	)


------------------------------------------------------------------------------------------------------
-- SPHERE NECROSIS
------------------------------------------------------------------------------------------------------

	-- Create the main Necrosis button  || Création du bouton principal de Necrosis
	frame = nil
	frame = _G["NecrosisButton"]
	if not frame then
		frame = CreateFrame("Button", "NecrosisButton", UIParent, "SecureActionButtonTemplate")
		frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Shard")
	end

	-- Define its attributes || Définition de ses attributs
	frame:SetFrameLevel(1)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetWidth(58)
	frame:SetHeight(58)
	frame:RegisterForDrag("LeftButton")
	frame:RegisterForClicks("AnyUp")
	frame:Show()

	-- Edit the scripts associated with the button || Edition des scripts associés au bouton
	frame:SetScript("OnEvent", function() Necrosis:OnEvent(event) end)
	frame:SetScript("OnUpdate", function() Necrosis:OnUpdate(arg1) end)
	frame:SetScript("OnEnter", function() Necrosis:BuildTooltip(this, "Main", "ANCHOR_LEFT") end)
	frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
	frame:SetScript("OnMouseUp", function() Necrosis:OnDragStop(this) end)
	frame:SetScript("OnDragStart", function() Necrosis:OnDragStart(this) end)
	frame:SetScript("OnDragStop", function() Necrosis:OnDragStop(this) end)

	-- Place the button window at its saved location || Placement de la fenêtre à l'endroit sauvegardé ou à l'emplacement par défaut
	frame:ClearAllPoints()
	frame:SetPoint(
		NecrosisConfig.FramePosition["NecrosisButton"][1],
		NecrosisConfig.FramePosition["NecrosisButton"][2],
		NecrosisConfig.FramePosition["NecrosisButton"][3],
		NecrosisConfig.FramePosition["NecrosisButton"][4],
		NecrosisConfig.FramePosition["NecrosisButton"][5]
	)
	
	-- Create the soulshard counter || Création du compteur de fragments d'âme
	local FontString = _G["NecrosisShardCount"]
	if not FontString then
		FontString = frame:CreateFontString("NecrosisShardCount", nil, "GameFontNormal")
	end

	-- Define its attributes || Définition de ses attributs
	FontString:SetText("00")
	FontString:SetPoint("CENTER")
	FontString:SetTextColor(1, 1, 1)
end


------------------------------------------------------------------------------------------------------
-- METAMORPHOSIS MENU BUTTON || BOUTON DU MENU DE METAMORPHOSE
------------------------------------------------------------------------------------------------------

local function CreateMetamorphosisSpell()
	local DemonicSpell = {"Charge", "Defi", "Enchainement", "Immolation"}
	local buffID = {39, 58, 56, 57}

	for i = 1, #DemonicSpell, 1 do
		-- Create the button || Creaton du bouton
		local frame = _G["NecrosisMetamorphosisMenu"..i]
		if not frame then
			frame = CreateFrame("Button", "NecrosisMetamorphosisMenu"..i, NecrosisMetamorphosisButton, "SecureActionButtonTemplate")

			-- define its attributes || Définition de ses attributs
			frame:SetMovable(true)
			frame:EnableMouse(true)
			frame:SetWidth(40)
			frame:SetHeight(40)
			frame:SetHighlightTexture("Interface\\AddOns\\Necrosis\\UI\\"..DemonicSpell[i].."-02")
			frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		end

		frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..DemonicSpell[i].."-01")
		frame:Show()

		-- Edit the scripts associated with the button || Edition des scripts associés au bouton
		frame:SetScript("OnEnter", function() Necrosis:BuildTooltip(this, DemonicSpell[i], "ANCHOR_RIGHT", "Curse") end)
		frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
		frame:SetParent(NecrosisMetamorphosisButton)
		
		if i == 1 then
			frame:ClearAllPoints()
			frame:SetPoint(
				"CENTER", "NecrosisMetamorphosisButton", "CENTER",
				NecrosisConfig.MetamorphosisMenuPos.direction * NecrosisConfig.MetamorphosisMenuPos.x * 32 + NecrosisConfig.MetamorphosisMenuDecalage.x,
				NecrosisConfig.MetamorphosisMenuPos.y * 32 + NecrosisConfig.MetamorphosisMenuDecalage.y
			)
		else
			frame:ClearAllPoints()
			frame:SetPoint(
				"CENTER", "NecrosisMetamorphosisMenu"..i - 1, "CENTER",
				NecrosisConfig.CurseMenuPos.direction * NecrosisConfig.CurseMenuPos.x * 32,
				NecrosisConfig.CurseMenuPos.y * 32
			)
		end
		
		-- special attributes || Attribution des sorts au bouton
		frame:SetAttribute("type", "spell")
		if i == 1 or i == 3 then
			frame:SetAttribute("unit", "target")
		end
		frame:SetAttribute("spell", Necrosis.Spell[ buffID[i] ].Name)
	end
end

------------------------------------------------------------------------------------------------------
-- BUTTONS for stones (health / spell / Fire), Metamorphosis & the Mount || BOUTON DES PIERRES, DE LA METAMORPHOSE ET DE LA MONTURE
------------------------------------------------------------------------------------------------------

local function CreateStoneButton(stone)
	-- Create the stone button || Création du bouton de la pierre
	-- if its the metamorphosis button, make it sensitive to position || Si c'est le bouton de métamorphose, on le rend sensible au changement de posture
	local frame
	if stone == "Metamorphosis" then
		frame = CreateFrame("Button", "Necrosis"..stone.."Button", UIParent, "SecureActionButtonTemplate SecureHandlerStateTemplate")
	else
		frame = CreateFrame("Button", "Necrosis"..stone.."Button", UIParent, "SecureActionButtonTemplate")
	end

	-- Define its attributes || Définition de ses attributs
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetWidth(34)
	frame:SetHeight(34)
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..stone.."Button-01")
	local num = 3
	if stone == "Soulstone" then
		num = 4
	elseif stone == "Mount" or stone == "Metamorphosis" then
		num = 2
	end
	frame:SetHighlightTexture("Interface\\AddOns\\Necrosis\\UI\\"..stone.."Button-0"..num)
	frame:RegisterForDrag("LeftButton")
	frame:RegisterForClicks("AnyUp")
	frame:Show()

	-- Edit the scripts associated with the buttons || Edition des scripts associés au bouton
	frame:SetScript("OnEnter", function() Necrosis:BuildTooltip(this, stone, "ANCHOR_LEFT") end)
	frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
	frame:SetScript("OnMouseUp", function() Necrosis:OnDragStop(this) end)
	frame:SetScript("OnDragStart", function()
		if not NecrosisConfig.NecrosisLockServ then
			Necrosis:OnDragStart(this)
		end
	end)
	frame:SetScript("OnDragStop", function() Necrosis:OnDragStop(this) end)

	-- Attributes specific to the soulstone button || Attributs spécifiques à la pierre d'âme
	-- if there are no restrictions while in combat, then allow the stone to be cast || Ils permettent de caster la pierre sur soi si pas de cible et hors combat
	if stone == "Soulstone" then
		frame:SetScript("PreClick", function()
			if not (InCombatLockdown() or UnitIsFriend("player","target")) then
				this:SetAttribute("unit", "player")
			end
		end)
		frame:SetScript("PostClick", function()
			if not InCombatLockdown() then
				this:SetAttribute("unit", "target")
			end
		end)
	end

	-- Place the button window at its saved location || Placement de la fenêtre à l'endroit sauvegardé ou à l'emplacement par défaut
	if not NecrosisConfig.NecrosisLockServ then
		frame:ClearAllPoints()
		frame:SetPoint(
			NecrosisConfig.FramePosition[frame:GetName()][1],
			NecrosisConfig.FramePosition[frame:GetName()][2],
			NecrosisConfig.FramePosition[frame:GetName()][3],
			NecrosisConfig.FramePosition[frame:GetName()][4],
			NecrosisConfig.FramePosition[frame:GetName()][5]
		)
	end
	
	if stone == "Metamorphosis" then
		CreateMetamorphosisSpell()
		Necrosis:MetamorphosisAttribute()
	end

	return frame
end


------------------------------------------------------------------------------------------------------
-- MENU BUTTONS || BOUTONS DES MENUS
------------------------------------------------------------------------------------------------------

local function CreateMenuButton(button)
	-- Create a Menu (Open/Close) button || Creaton du bouton d'ouverture du menu
	local frame = CreateFrame("Button", "Necrosis"..button.."Button", UIParent, "SecureHandlerAttributeTemplate SecureHandlerClickTemplate SecureHandlerEnterLeaveTemplate")

	-- Define its attributes || Définition de ses attributs
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetWidth(34)
	frame:SetHeight(34)
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..button.."Button-01")
	frame:SetHighlightTexture("Interface\\AddOns\\Necrosis\\UI\\"..button.."Button-02")
	frame:RegisterForDrag("LeftButton")
	frame:RegisterForClicks("AnyUp")
	frame:Show()

	-- Edit the scripts associated with the button || Edition des scripts associés au bouton
	frame:SetScript("OnEnter", function() Necrosis:BuildTooltip(this, button, "ANCHOR_RIGHT") end)
	frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
	frame:SetScript("OnMouseUp", function() Necrosis:OnDragStop(this) end)
	frame:SetScript("OnDragStart", function()
		--if not NecrosisConfig.NecrosisLockServ then
			Necrosis:OnDragStart(this)
		--end
	end)
	frame:SetScript("OnDragStop", function() Necrosis:OnDragStop(this) end)

	-- Place the button window at its saved location || Placement de la fenêtre à l'endroit sauvegardé ou à l'emplacement par défaut
	if not NecrosisConfig.NecrosisLockServ then
		frame:ClearAllPoints()
		frame:SetPoint(
			NecrosisConfig.FramePosition[frame:GetName()][1],
			NecrosisConfig.FramePosition[frame:GetName()][2],
			NecrosisConfig.FramePosition[frame:GetName()][3],
			NecrosisConfig.FramePosition[frame:GetName()][4],
			NecrosisConfig.FramePosition[frame:GetName()][5]
		)
	end

	return frame
end


------------------------------------------------------------------------------------------------------
-- BUFF MENU || MENU DES BUFFS
------------------------------------------------------------------------------------------------------

-- Buttons for the Buffs menu || Boutons du menu des buffs
function Necrosis:CreateMenuBuff(i)
	local BuffName = {"Armor", "FelArmor", "Aqua", "Invisible", "Kilrogg", "TP", "SoulLink", "ShadowProtection", "Renforcement", "Banish"}

	-- Create the button || Creaton du bouton
	local frame = _G["NecrosisBuffMenu"..i]
	if not frame then
		frame = CreateFrame("Button", "NecrosisBuffMenu"..i, UIParent, "SecureActionButtonTemplate")

		-- Définition de ses attributs
		frame:SetMovable(true)
		frame:EnableMouse(true)
		frame:SetWidth(40)
		frame:SetHeight(40)
		frame:SetHighlightTexture("Interface\\AddOns\\Necrosis\\UI\\"..BuffName[i].."-02")
		frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	end

	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..BuffName[i].."-01")
	frame:Hide()

	-- Edit the scripts associated with the button || Edition des scripts associés au bouton
	frame:SetScript("OnEnter", function() Necrosis:BuildTooltip(this, BuffName[i], "ANCHOR_RIGHT", "Buff") end)
	frame:SetScript("OnLeave", function() GameTooltip:Hide() end)

	-- Special attributes for casting certain buffs || Attributs spéciaux pour les buffs castables sur les autres joueurs
	if i == 3 or i == 4 then
		frame:SetScript("PreClick", function()
			if not (InCombatLockdown() or UnitIsFriend("player","target")) then
				this:SetAttribute("unit", "player")
			end
		end)
		frame:SetScript("PostClick", function()
			if not InCombatLockdown() then
				this:SetAttribute("unit", "target")
			end
		end)
	end

	-- Special attribute for the Banish button || Attributes spéciaux pour notre ami le sort de Bannissement
	if i == 10 then
		frame:SetScale(NecrosisConfig.BanishScale/100)
	end

	return frame
end


------------------------------------------------------------------------------------------------------
-- DEMON MENU || MENU DES DEMONS
------------------------------------------------------------------------------------------------------

-- Buttons for the Demons menu || Boutons du menu des démons
function Necrosis:CreateMenuPet(i)
	local PetName = {"Domination", "Imp", "Voidwalker", "Succubus", "Felhunter", "Felguard", "Infernal", "Doomguard", "Enslave", "Sacrifice", "Renforcement"}

	-- Create the button || Creaton du bouton
	local frame = _G["NecrosisPetMenu"..i]
	if not frame then
		frame = CreateFrame("Button", "NecrosisPetMenu"..i, UIParent, "SecureActionButtonTemplate")

		-- Définition de ses attributs
		frame:SetMovable(true)
		frame:EnableMouse(true)
		frame:SetWidth(40)
		frame:SetHeight(40)
		frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		frame:SetHighlightTexture("Interface\\AddOns\\Necrosis\\UI\\"..PetName[i].."-02")
	end

	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..PetName[i].."-01")
	frame:Hide()

	-- Edit the scripts associated with the button || Edition des scripts associés au bouton
	frame:SetScript("OnEnter", function() Necrosis:BuildTooltip(this, PetName[i], "ANCHOR_RIGHT", "Pet") end)
	frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
	return frame
end


------------------------------------------------------------------------------------------------------
-- CURSES MENU || MENU DES MALEDICTIONS
------------------------------------------------------------------------------------------------------

-- Buttons for the Curse menu || Boutons du menu des malédictions
function Necrosis:CreateMenuCurse(i)
	local CurseName = {"Weakness", "Agony", "Reckless", "Tongues", "Exhaust", "Elements", "Doom", "Corruption"}

	-- Create the button || Creaton du bouton
	local frame = _G["NecrosisCurseMenu"..i]
	if not frame then
		frame = CreateFrame("Button", "NecrosisCurseMenu"..i, UIParent, "SecureActionButtonTemplate")

		-- Définition de ses attributs
		frame:SetMovable(true)
		frame:EnableMouse(true)
		frame:SetWidth(40)
		frame:SetHeight(40)
		frame:SetHighlightTexture("Interface\\AddOns\\Necrosis\\UI\\"..CurseName[i].."-02")
		frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	end

	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..CurseName[i].."-01")
	frame:Hide()

	-- Edit the scripts associated with the button || Edition des scripts associés au bouton
	frame:SetScript("OnEnter", function() Necrosis:BuildTooltip(this, CurseName[i], "ANCHOR_RIGHT", "Curse") end)
	frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
	return frame
end


------------------------------------------------------------------------------------------------------
-- SPECIAL POPUP BUTTONS || BOUTONS SPECIAUX POPUP
------------------------------------------------------------------------------------------------------

function Necrosis:CreateWarlockPopup()

	-- Create the ShadowTrance button || Creation du bouton de ShadowTrance
	local frame = nil
	frame = _G["NecrosisShadowTranceButton"]
	if not frame then
		frame = CreateFrame("Button", "NecrosisShadowTranceButton", UIParent)
	end

	-- Define its attributes || Définition de ses attributs
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetFrameStrata("HIGH")
	frame:SetWidth(40)
	frame:SetHeight(40)
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\ShadowTrance-Icon")
	frame:RegisterForDrag("LeftButton")
	frame:RegisterForClicks("AnyUp")
	frame:Hide()

	-- Edit scripts associated with the button || Edition des scripts associés au bouton
	frame:SetScript("OnEnter", function() Necrosis:BuildTooltip(this, "ShadowTrance", "ANCHOR_RIGHT") end)
	frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
	frame:SetScript("OnMouseUp", function() Necrosis:OnDragStop(this) end)
	frame:SetScript("OnDragStart", function() Necrosis:OnDragStart(this) end)
	frame:SetScript("OnDragStop", function() Necrosis:OnDragStop(this) end)

	-- Place the button window at its saved location || Placement de la fenêtre à l'endroit sauvegardé ou à l'emplacement par défaut
	frame:ClearAllPoints()
	frame:SetPoint(
		NecrosisConfig.FramePosition["NecrosisShadowTranceButton"][1],
		NecrosisConfig.FramePosition["NecrosisShadowTranceButton"][2],
		NecrosisConfig.FramePosition["NecrosisShadowTranceButton"][3],
		NecrosisConfig.FramePosition["NecrosisShadowTranceButton"][4],
		NecrosisConfig.FramePosition["NecrosisShadowTranceButton"][5]
	)

	-- Create the Backlash button || Creation du bouton de BackLash
	local frame = _G["NecrosisBacklashButton"]
	if not frame then
		frame = CreateFrame("Button", "NecrosisBacklashButton", UIParent)
	end

	-- Definte its attributes || Définition de ses attributs
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetFrameStrata("HIGH")
	frame:SetWidth(40)
	frame:SetHeight(40)
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Backlash-Icon")
	frame:RegisterForDrag("LeftButton")
	frame:Hide()

	-- Edit the scripts associated with the button || Edition des scripts associés au bouton
	frame:SetScript("OnEnter", function() Necrosis:BuildTooltip(this, "Backlash", "ANCHOR_RIGHT") end)
	frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
	frame:SetScript("OnMouseUp", function() Necrosis:OnDragStop(this) end)
	frame:SetScript("OnDragStart", function() Necrosis:OnDragStart(this) end)
	frame:SetScript("OnDragStop", function() Necrosis:OnDragStop(this) end)

	-- Place the button window at its saved location || Placement de la fenêtre à l'endroit sauvegardé ou à l'emplacement par défaut
	frame:ClearAllPoints()
	frame:SetPoint(
		NecrosisConfig.FramePosition["NecrosisBacklashButton"][1],
		NecrosisConfig.FramePosition["NecrosisBacklashButton"][2],
		NecrosisConfig.FramePosition["NecrosisBacklashButton"][3],
		NecrosisConfig.FramePosition["NecrosisBacklashButton"][4],
		NecrosisConfig.FramePosition["NecrosisBacklashButton"][5]
	)

	-- Create the Elemental alert button || Creation du bouton de détection des cibles banissables / asservissables
	frame = nil
	frame = _G["NecrosisCreatureAlertButton"]
	if not frame then
		frame = CreateFrame("Button", "NecrosisCreatureAlertButton", UIParent)
	end

	-- Define its attributes || Définition de ses attributs
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetFrameStrata("HIGH")
	frame:SetWidth(40)
	frame:SetHeight(40)
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\ElemAlert")
	frame:RegisterForDrag("LeftButton")
	frame:Hide()

	-- Edit the scripts associated with the button || Edition des scripts associés au bouton
	frame:SetScript("OnMouseUp", function() Necrosis:OnDragStop(this) end)
	frame:SetScript("OnDragStart", function() Necrosis:OnDragStart(this) end)
	frame:SetScript("OnDragStop", function() Necrosis:OnDragStop(this) end)

	-- Place the button window at its saved location || Placement de la fenêtre à l'endroit sauvegardé ou à l'emplacement par défaut
	if NecrosisConfig.FramePosition then
		if NecrosisConfig.FramePosition["NecrosisCreatureAlertButton"] then
			frame:ClearAllPoints()
			frame:SetPoint(
				NecrosisConfig.FramePosition["NecrosisCreatureAlertButton"][1],
				NecrosisConfig.FramePosition["NecrosisCreatureAlertButton"][2],
				NecrosisConfig.FramePosition["NecrosisCreatureAlertButton"][3],
				NecrosisConfig.FramePosition["NecrosisCreatureAlertButton"][4],
				NecrosisConfig.FramePosition["NecrosisCreatureAlertButton"][5]
			)
		end
	else
		frame:ClearAllPoints()
		frame:SetPoint("CENTER", UIParent, "CENTER", -50, 0)
	end

	-- Create the AntiFear button || Creation du bouton de détection des cibles protégées contre la peur
	local frame = _G["NecrosisAntiFearButton"]
	if not frame then
		frame = CreateFrame("Button", "NecrosisAntiFearButton", UIParent)
	end

	-- Define its attributes || Définition de ses attributs
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetFrameStrata("HIGH")
	frame:SetWidth(40)
	frame:SetHeight(40)
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\AntiFear-01")
	frame:RegisterForDrag("LeftButton")
	frame:Hide()

	-- Edit the scripts associated with the button || Edition des scripts associés au bouton
	frame:SetScript("OnMouseUp", function() Necrosis:OnDragStop(this) end)
	frame:SetScript("OnDragStart", function() Necrosis:OnDragStart(this) end)
	frame:SetScript("OnDragStop", function() Necrosis:OnDragStop(this) end)

	-- Place the button window at its saved location || Placement de la fenêtre à l'endroit sauvegardé ou à l'emplacement par défaut
	if NecrosisConfig.FramePosition then
		if NecrosisConfig.FramePosition["NecrosisAntiFearButton"] then
			frame:ClearAllPoints()
			frame:SetPoint(
				NecrosisConfig.FramePosition["NecrosisAntiFearButton"][1],
				NecrosisConfig.FramePosition["NecrosisAntiFearButton"][2],
				NecrosisConfig.FramePosition["NecrosisAntiFearButton"][3],
				NecrosisConfig.FramePosition["NecrosisAntiFearButton"][4],
				NecrosisConfig.FramePosition["NecrosisAntiFearButton"][5]
			)
		end
	else
		frame:ClearAllPoints()
		frame:SetPoint("CENTER", UIParent, "CENTER", 50, 0)
	end
end


------------------------------------------------------------------------------------------------------
-- CREATE BUTTONS ON DEMAND || CREATION DES BOUTONS A LA DEMANDE
------------------------------------------------------------------------------------------------------

function Necrosis:CreateSphereButtons(ButtonName)
	local ShortButtonName = string.gsub(string.gsub(ButtonName, "Necrosis", ""), "Button", "")
	if ShortButtonName == "BuffMenu" or ShortButtonName == "PetMenu" or ShortButtonName == "CurseMenu" then
		return CreateMenuButton(ShortButtonName)
	else
		return CreateStoneButton(ShortButtonName)
	end
	
end
