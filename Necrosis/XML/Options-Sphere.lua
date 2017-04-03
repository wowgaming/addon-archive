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
-- $LastChangedDate: 2008-10-20 08:29:32 +1100 (Mon, 20 Oct 2008) $
------------------------------------------------------------------------------------------------------

-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)


------------------------------------------------------------------------------------------------------
-- CREATION DE LA FRAME DES OPTIONS
------------------------------------------------------------------------------------------------------

-- On crée ou on affiche le panneau de configuration de la sphere
function Necrosis:SetSphereConfig()

	local frame = _G["NecrosisSphereConfig"]
	if not frame then
		-- Création de la fenêtre
		frame = CreateFrame("Frame", "NecrosisSphereConfig", NecrosisGeneralFrame)
		frame:SetFrameStrata("DIALOG")
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetWidth(350)
		frame:SetHeight(452)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT")

		-- Création du slider de scale de Necrosis
		frame = CreateFrame("Slider", "NecrosisSphereSize", NecrosisSphereConfig, "OptionsSliderTemplate")
		frame:SetMinMaxValues(50, 200)
		frame:SetValueStep(5)
		frame:SetWidth(150)
		frame:SetHeight(15)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("CENTER", NecrosisSphereConfig, "BOTTOMLEFT", 225, 400)

		local NBx, NBy
		frame:SetScript("OnEnter", function()
			NBx, NBy = NecrosisButton:GetCenter()
			NBx = NBx * (NecrosisConfig.NecrosisButtonScale / 100)
			NBy = NBy * (NecrosisConfig.NecrosisButtonScale / 100)
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			GameTooltip:SetText(this:GetValue().." %")
		end)
		frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
		frame:SetScript("OnValueChanged", function()
			if not (this:GetValue() == NecrosisConfig.NecrosisButtonScale) then
				NecrosisButton:ClearAllPoints()
				GameTooltip:SetText(this:GetValue().." %")
				NecrosisConfig.NecrosisButtonScale = this:GetValue()
				NecrosisButton:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", NBx / (NecrosisConfig.NecrosisButtonScale / 100), NBy / (NecrosisConfig.NecrosisButtonScale / 100))
				NecrosisButton:SetScale(NecrosisConfig.NecrosisButtonScale / 100)
				Necrosis:ButtonSetup()
			end
		end)

		NecrosisSphereSizeLow:SetText("50 %")
		NecrosisSphereSizeHigh:SetText("200 %")

		-- Skin de la sphère
		frame = CreateFrame("Frame", "NecrosisSkinSelection", NecrosisSphereConfig, "UIDropDownMenuTemplate")
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisSphereConfig, "BOTTOMRIGHT", 40, 325)

		local FontString = frame:CreateFontString("NecrosisSkinSelectionT", "OVERLAY", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", NecrosisSphereConfig, "BOTTOMLEFT", 35, 328)
		FontString:SetTextColor(1, 1, 1)

		UIDropDownMenu_SetWidth(frame, 125)

		-- Evenement montré par la sphère
		frame = CreateFrame("Frame", "NecrosisEventSelection", NecrosisSphereConfig, "UIDropDownMenuTemplate")
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisSphereConfig, "BOTTOMRIGHT", 40, 300)

		FontString = frame:CreateFontString("NecrosisEventSelectionT", "OVERLAY", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", NecrosisSphereConfig, "BOTTOMLEFT", 35, 303)
		FontString:SetTextColor(1, 1, 1)

		UIDropDownMenu_SetWidth(frame, 125)

		-- Sort associé à la sphère
		frame = CreateFrame("Frame", "NecrosisSpellSelection", NecrosisSphereConfig, "UIDropDownMenuTemplate")
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisSphereConfig, "BOTTOMRIGHT", 40, 275)

		FontString = frame:CreateFontString("NecrosisSpellSelectionT", "OVERLAY", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", NecrosisSphereConfig, "BOTTOMLEFT", 35, 278)
		FontString:SetTextColor(1, 1, 1)

		UIDropDownMenu_SetWidth(frame, 125)

		-- Affiche ou masque le compteur numérique
		frame = CreateFrame("CheckButton", "NecrosisShowCount", NecrosisSphereConfig, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisSphereConfig, "BOTTOMLEFT", 25, 200)

		frame:SetScript("OnClick", function()
			NecrosisConfig.ShowCount = this:GetChecked()
			Necrosis:BagExplore()
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		FontString:SetTextColor(1, 1, 1)
		frame:SetFontString(FontString)

		-- Evenement montré par le compteur
		frame = CreateFrame("Frame", "NecrosisCountSelection", NecrosisSphereConfig, "UIDropDownMenuTemplate")
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisSphereConfig, "BOTTOMRIGHT", 40, 175)

		FontString = frame:CreateFontString("NecrosisCountSelectionT", "OVERLAY", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", NecrosisSphereConfig, "BOTTOMLEFT", 35, 178)
		FontString:SetTextColor(1, 1, 1)

		UIDropDownMenu_SetWidth(frame, 125)

	end

	UIDropDownMenu_Initialize(NecrosisSkinSelection, Necrosis.Skin_Init)
	UIDropDownMenu_Initialize(NecrosisEventSelection, Necrosis.Event_Init)
	UIDropDownMenu_Initialize(NecrosisSpellSelection, Necrosis.Spell_Init)
	UIDropDownMenu_Initialize(NecrosisCountSelection, Necrosis.Count_Init)

	NecrosisSphereSizeText:SetText(self.Config.Sphere["Taille de la sphere"])
	NecrosisSkinSelectionT:SetText(self.Config.Sphere["Skin de la pierre Necrosis"])
	NecrosisEventSelectionT:SetText(self.Config.Sphere["Evenement montre par la sphere"])
	NecrosisSpellSelectionT:SetText(self.Config.Sphere["Sort caste par la sphere"])
	NecrosisShowCount:SetText(self.Config.Sphere["Afficher le compteur numerique"])
	NecrosisCountSelectionT:SetText(self.Config.Sphere["Type de compteur numerique"])

	NecrosisSphereSize:SetValue(NecrosisConfig.NecrosisButtonScale)
	NecrosisShowCount:SetChecked(NecrosisConfig.ShowCount)

	local couleur = {"Rose", "Bleu", "Orange", "Turquoise", "Violet", "666", "X"}
	for i in ipairs(couleur) do
		if couleur[i] == NecrosisConfig.NecrosisColor then
			UIDropDownMenu_SetSelectedID(NecrosisSkinSelection, i)
			UIDropDownMenu_SetText(NecrosisSkinSelection, self.Config.Sphere.Colour[i])
			break
		end
	end

	UIDropDownMenu_SetSelectedID(NecrosisEventSelection, NecrosisConfig.Circle)
	if NecrosisConfig.Circle == 1 then
		UIDropDownMenu_SetText(NecrosisEventSelection, self.Config.Sphere.Count[NecrosisConfig.Circle])
	else
		UIDropDownMenu_SetText(NecrosisEventSelection, self.Config.Sphere.Count[NecrosisConfig.Circle + 1])
	end

	local spell = {19, 27, 31, 37, 41, 43, 44, 47, 49, 55}
	for i in ipairs(spell) do
		if spell[i] == NecrosisConfig.MainSpell then
			UIDropDownMenu_SetSelectedID(NecrosisSpellSelection, i)
			UIDropDownMenu_SetText(NecrosisSpellSelection, self.Spell[spell[i]].Name)
			break
		end
	end

	UIDropDownMenu_SetSelectedID(NecrosisCountSelection, NecrosisConfig.CountType)
	UIDropDownMenu_SetText(NecrosisCountSelection, self.Config.Sphere.Count[NecrosisConfig.CountType])

	frame:Show()
end


------------------------------------------------------------------------------------------------------
-- FONCTIONS NECESSAIRES AUX DROPDOWNS
------------------------------------------------------------------------------------------------------

-- Fonctions du Dropdown des skins
function Necrosis.Skin_Init()
	local element = {}

	for i in ipairs(Necrosis.Config.Sphere.Colour) do
		element.text = Necrosis.Config.Sphere.Colour[i]
		element.checked = false
		element.func = Necrosis.Skin_Click
		UIDropDownMenu_AddButton(element)
	end
end

function Necrosis.Skin_Click()
	local ID = this:GetID()
	local couleur = {"Rose", "Bleu", "Orange", "Turquoise", "Violet", "666", "X"}
	UIDropDownMenu_SetSelectedID(NecrosisSkinSelection, ID)
	NecrosisConfig.NecrosisColor = couleur[ID]
	NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..couleur[ID].."\\Shard16")
end

-- Fonctions du Dropdown des Events de la sphère
function Necrosis.Event_Init()
	local element = {}
	for i in ipairs(Necrosis.Config.Sphere.Count) do
		if not (i == 2) then
			element.text = Necrosis.Config.Sphere.Count[i]
			element.checked = false
			element.func = Necrosis.Event_Click
			UIDropDownMenu_AddButton(element)
		end
	end
end

function Necrosis.Event_Click()
	local ID = this:GetID()
	UIDropDownMenu_SetSelectedID(NecrosisEventSelection, ID)
	NecrosisConfig.Circle = ID
	Necrosis:UpdateHealth()
	Necrosis:UpdateMana()
	Necrosis:BagExplore()
end

-- Fonctions du Dropdown des sorts de la sphère
function Necrosis.Spell_Init()
	local spell = {19, 27, 31, 37, 41, 43, 44, 47, 49, 55}
	local element = {}
	for i in ipairs(spell) do
		element.text = Necrosis.Spell[spell[i]].Name
		element.checked = false
		element.func = Necrosis.Spell_Click
		UIDropDownMenu_AddButton(element)
	end
end

function Necrosis.Spell_Click()
	local ID = this:GetID()
	local spell = {19, 27, 31, 37, 41, 43, 44, 47, 49, 55}
	UIDropDownMenu_SetSelectedID(NecrosisSpellSelection, ID)
	NecrosisConfig.MainSpell = spell[ID]
	Necrosis.MainButtonAttribute()
end

-- Fonctions du Dropdown des Events du compteur
function Necrosis.Count_Init()
	local element = {}
	for i in ipairs(Necrosis.Config.Sphere.Count) do
		element.text = Necrosis.Config.Sphere.Count[i]
		element.checked = false
		element.func = Necrosis.Count_Click
		UIDropDownMenu_AddButton(element)
	end
end

function Necrosis.Count_Click()
	local ID = this:GetID()
	UIDropDownMenu_SetSelectedID(NecrosisCountSelection, ID)
	NecrosisConfig.CountType = ID
	NecrosisShardCount:SetText("")
	Necrosis:UpdateHealth()
	Necrosis:UpdateMana()
	Necrosis:BagExplore()
end