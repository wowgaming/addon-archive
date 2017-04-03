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
-- $LastChangedDate: 2008-10-18 19:51:42 +1100 (Sat, 18 Oct 2008) $
------------------------------------------------------------------------------------------------------

-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)


------------------------------------------------------------------------------------------------------
-- CREATION DE LA FRAME DES OPTIONS
------------------------------------------------------------------------------------------------------

function Necrosis:SetTimersConfig()

	local frame = _G["NecrosisTimersConfig"]
	if not frame then
		-- Création de la fenêtre
		frame = CreateFrame("Frame", "NecrosisTimersConfig", NecrosisGeneralFrame)
		frame:SetFrameStrata("DIALOG")
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetWidth(350)
		frame:SetHeight(452)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT")

		-- Choix du timer graphique
		frame = CreateFrame("Frame", "NecrosisTimerSelection", NecrosisTimersConfig, "UIDropDownMenuTemplate")
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisTimersConfig, "BOTTOMRIGHT", 40, 400)

		local FontString = frame:CreateFontString("NecrosisTimerSelectionT", "OVERLAY", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", NecrosisTimersConfig, "BOTTOMLEFT", 35, 403)
		FontString:SetTextColor(1, 1, 1)

		UIDropDownMenu_SetWidth(frame, 125)

		-- Affiche ou masque le bouton des timers
		frame = CreateFrame("CheckButton", "NecrosisShowSpellTimerButton", NecrosisTimersConfig, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisTimersConfig, "BOTTOMLEFT", 25, 325)

		frame:SetScript("OnClick", function()
			NecrosisConfig.ShowSpellTimers = this:GetChecked()
			if NecrosisConfig.ShowSpellTimers then
				NecrosisSpellTimerButton:Show()
			else
				NecrosisSpellTimerButton:Hide()
			end
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		FontString:SetTextColor(1, 1, 1)
		frame:SetFontString(FontString)
		-- frame:SetDisabledTextColor(0.75, 0.75, 0.75)

		-- Affiche les timers sur la gauche du bouton
		frame = CreateFrame("CheckButton", "NecrosisTimerOnLeft", NecrosisTimersConfig, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisTimersConfig, "BOTTOMLEFT", 25, 300)

		frame:SetScript("OnClick", function()
			Necrosis:SymetrieTimer(this:GetChecked())
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		FontString:SetTextColor(1, 1, 1)
		frame:SetFontString(FontString)
		-- frame:SetDisabledTextColor(0.75, 0.75, 0.75)

		-- Affiche les timers de bas en haut
		frame = CreateFrame("CheckButton", "NecrosisTimerUpward", NecrosisTimersConfig, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisTimersConfig, "BOTTOMLEFT", 25, 275)

		frame:SetScript("OnClick", function()
			if (this:GetChecked()) then
				NecrosisConfig.SensListe = -1
			else
				NecrosisConfig.SensListe = 1
			end
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		FontString:SetTextColor(1, 1, 1)
		frame:SetFontString(FontString)
		-- frame:SetDisabledTextColor(0.75, 0.75, 0.75)
	end

	UIDropDownMenu_Initialize(NecrosisTimerSelection, Necrosis.Timer_Init)

	NecrosisTimerSelectionT:SetText(self.Config.Timers["Type de timers"])
	NecrosisShowSpellTimerButton:SetText(self.Config.Timers["Afficher le bouton des timers"])
	NecrosisTimerOnLeft:SetText(self.Config.Timers["Afficher les timers sur la gauche du bouton"])
	NecrosisTimerUpward:SetText(self.Config.Timers["Afficher les timers de bas en haut"])

	UIDropDownMenu_SetSelectedID(NecrosisTimerSelection, (NecrosisConfig.TimerType + 1))
	UIDropDownMenu_SetText(NecrosisTimerSelection, Necrosis.Config.Timers.Type[NecrosisConfig.TimerType + 1])

	NecrosisShowSpellTimerButton:SetChecked(NecrosisConfig.ShowSpellTimers)
	NecrosisTimerOnLeft:SetChecked(NecrosisConfig.SpellTimerPos == -1)
	NecrosisTimerUpward:SetChecked(NecrosisConfig.SensListe == -1)

	if NecrosisConfig.TimerType == 0 then
		NecrosisTimerUpward:Disable()
		NecrosisTimerOnLeft:Disable()

	elseif NecrosisConfig.TimerType == 2 then
		NecrosisTimerUpward:Disable()
		NecrosisTimerOnLeft:Enable()
	else
		NecrosisTimerOnLeft:Enable()
		NecrosisTimerUpward:Enable()
	end

	frame:Show()

end


------------------------------------------------------------------------------------------------------
-- FONCTIONS NECESSAIRES AUX DROPDOWNS
------------------------------------------------------------------------------------------------------

-- Fonctions du Dropdown des timers
function Necrosis.Timer_Init()
	local element = {}

	for i in ipairs(Necrosis.Config.Timers.Type) do
		element.text = Necrosis.Config.Timers.Type[i]
		element.checked = false
		element.func = Necrosis.Timer_Click
		UIDropDownMenu_AddButton(element)
	end
end

function Necrosis.Timer_Click()
	local ID = this:GetID()
	UIDropDownMenu_SetSelectedID(NecrosisTimerSelection, ID)
	NecrosisConfig.TimerType = ID - 1
	if not (ID == 1) then Necrosis:CreateTimerAnchor() end
	if ID == 1 then
		NecrosisTimerUpward:Disable()
		NecrosisTimerOnLeft:Disable()
		if _G["NecrosisListSpells"] then NecrosisListSpells:SetText("") end
		local index = 1
		while _G["NecrosisTimerFrame"..index] do
			_G["NecrosisTimerFrame"..index]:Hide()
			index = index + 1
		end
	elseif ID == 3 then
		NecrosisTimerUpward:Disable()
		NecrosisTimerOnLeft:Enable()
		local index = 1
		while _G["NecrosisTimerFrame"..index] do
			_G["NecrosisTimerFrame"..index]:Hide()
			index = index + 1
		end
	else
		NecrosisTimerUpward:Enable()
		NecrosisTimerOnLeft:Enable()
		if _G["NecrosisListSpells"] then NecrosisListSpells:SetText("") end
	end
end
