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
-- $LastChangedDate: 2009-12-10 17:09:53 +1100 (Thu, 10 Dec 2009) $
------------------------------------------------------------------------------------------------------

-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)

NUM_COMPANIONS_PER_PAGE = 12;
MERCHANT_PAGE_NUMBER = "Page %s of %s";

------------------------------------------------------------------------------------------------------
-- CREATION DE LA FRAME DES OPTIONS
------------------------------------------------------------------------------------------------------

-- On crée ou on affiche le panneau de configuration de la sphere
function Necrosis:SetButtonsConfig()

	local frame = _G["NecrosisButtonsConfig"]
	if not frame then
		-- Création de la fenêtre
		frame = CreateFrame("Frame", "NecrosisButtonsConfig", NecrosisGeneralFrame)
		frame:SetFrameStrata("DIALOG")
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetWidth(350)
		frame:SetHeight(452)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT")

		-- Création de la sous-fenêtre 1
		frame = CreateFrame("Frame", "NecrosisButtonsConfig1", NecrosisButtonsConfig)
		frame:SetFrameStrata("DIALOG")
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetWidth(350)
		frame:SetHeight(452)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetAllPoints(NecrosisButtonsConfig)
		
		local FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("BOTTOM", frame, "BOTTOM", 50, 130)
		FontString:SetText("1 / 2")

		FontString = frame:CreateFontString("NecrosisButtonsConfig1Text", nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("BOTTOM", frame, "BOTTOM", 50, 420)
		
		-- Boutons
		frame = CreateFrame("Button", nil, NecrosisButtonsConfig1, "OptionsButtonTemplate")
		frame:SetText(">>>")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisButtonsConfig1, "BOTTOMRIGHT", 40, 135)

		frame:SetScript("OnClick", function()
			NecrosisButtonsConfig2:Show()
			NecrosisButtonsConfig1:Hide()
		end)

		frame = CreateFrame("Button", nil, NecrosisButtonsConfig1, "OptionsButtonTemplate")
		frame:SetText("<<<")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisButtonsConfig1, "BOTTOMLEFT", 40, 135)

		frame:SetScript("OnClick", function()
			NecrosisButtonsConfig2:Show()
			NecrosisButtonsConfig1:Hide()
		end)
		
		-- Création de la sous-fenêtre 2
		frame = CreateFrame("Frame", "NecrosisButtonsConfig2", NecrosisButtonsConfig)
		frame:SetFrameStrata("DIALOG")
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetWidth(350)
		frame:SetHeight(452)
		frame:Hide()
		frame:ClearAllPoints()
		frame:SetAllPoints(NecrosisButtonsConfig)
		
		local FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("BOTTOM", frame, "BOTTOM", 50, 130)
		FontString:SetText("2 / 2")

		FontString = frame:CreateFontString("NecrosisButtonsConfig2Text", nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("BOTTOM", frame, "BOTTOM", 50, 420)
		
		-- Boutons
		frame = CreateFrame("Button", nil, NecrosisButtonsConfig2, "OptionsButtonTemplate")
		frame:SetText(">>>")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisButtonsConfig2, "BOTTOMRIGHT", 40, 135)

		frame:SetScript("OnClick", function()
			NecrosisButtonsConfig1:Show()
			NecrosisButtonsConfig2:Hide()
		end)

		frame = CreateFrame("Button", nil, NecrosisButtonsConfig2, "OptionsButtonTemplate")
		frame:SetText("<<<")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisButtonsConfig2, "BOTTOMLEFT", 40, 135)

		frame:SetScript("OnClick", function()
			NecrosisButtonsConfig1:Show()
			NecrosisButtonsConfig2:Hide()
		end)
		
		-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		-- Sub Menu 1
		-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		-- Attach or detach the necrosis buttons || Attache ou détache les boutons de Necrosis
		frame = CreateFrame("CheckButton", "NecrosisLockButtons", NecrosisButtonsConfig1, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisButtonsConfig1, "BOTTOMLEFT", 25, 395)

		frame:SetScript("OnClick", function()
			if (this:GetChecked()) then
				NecrosisConfig.NecrosisLockServ = true
				Necrosis:ClearAllPoints()
				Necrosis:ButtonSetup()
				Necrosis:NoDrag()
				if not NecrosisConfig.NoDragAll then
					NecrosisButton:RegisterForDrag("LeftButton")
					NecrosisSpellTimerButton:RegisterForDrag("LeftButton")
				end
			else
				NecrosisConfig.NecrosisLockServ = false
				Necrosis:ClearAllPoints()
				local ButtonName = {
					"NecrosisFirestoneButton",
					"NecrosisSpellstoneButton",
					"NecrosisHealthstoneButton",
					"NecrosisSoulstoneButton",
					"NecrosisBuffMenuButton",
					"NecrosisMountButton",
					"NecrosisPetMenuButton",
					"NecrosisCurseMenuButton",
					"NecrosisMetamorphosisButton"
				}
				local loc = {-121, -87, -53, -17, 17, 53, 87, 121}
				for i in ipairs(ButtonName) do
					if _G[ButtonName[i]] then
						_G[ButtonName[i]]:SetPoint("CENTER", "UIParent", "CENTER", loc[i], -100)
						NecrosisConfig.FramePosition[ButtonName[i]] = {
							"CENTER",
							"UIParent",
							"CENTER",
							loc[i],
							-100
						}
					end
				end
				Necrosis:Drag()
				NecrosisConfig.NoDragAll = false
				NecrosisButton:RegisterForDrag("LeftButton")
				NecrosisSpellTimerButton:RegisterForDrag("LeftButton")
			end
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		FontString:SetTextColor(1, 1, 1)
		frame:SetFontString(FontString)

		-- Affiche ou cache les boutons autour de Necrosis
		local boutons = {"Firestone", "Spellstone", "HealthStone", "Soulstone", "BuffMenu", "Mount", "PetMenu", "CurseMenu", "Metamorphosis"}
		local initY = 380
		for i in ipairs(boutons) do
			frame = CreateFrame("CheckButton", "NecrosisShow"..boutons[i], NecrosisButtonsConfig1, "UICheckButtonTemplate")
			frame:EnableMouse(true)
			frame:SetWidth(24)
			frame:SetHeight(24)
			frame:Show()
			frame:ClearAllPoints()
			frame:SetPoint("LEFT", NecrosisButtonsConfig1, "BOTTOMLEFT", 25, initY - (25 * i))

			frame:SetScript("OnClick", function()
				if (this:GetChecked()) then
					NecrosisConfig.StonePosition[i] = math.abs(NecrosisConfig.StonePosition[i])
				else
					NecrosisConfig.StonePosition[i] = - math.abs(NecrosisConfig.StonePosition[i])
				end
				Necrosis:ButtonSetup()
			end)

			FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
			FontString:Show()
			FontString:ClearAllPoints()
			FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
			FontString:SetTextColor(1, 1, 1)
			frame:SetFontString(FontString)
		end

		-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		-- Sub Menu 2
		-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		-- Create a slider control for rotating the buttons around the sphere || Création du slider de rotation de Necrosis
		frame = CreateFrame("Slider", "NecrosisRotation", NecrosisButtonsConfig2, "OptionsSliderTemplate")
		frame:SetMinMaxValues(0, 360)
		frame:SetValueStep(9)
		frame:SetWidth(150)
		frame:SetHeight(15)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("CENTER", NecrosisButtonsConfig2, "BOTTOMLEFT", 225, 380)

		frame:SetScript("OnEnter", function()
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			GameTooltip:SetText(this:GetValue())
		end)
		frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
		frame:SetScript("OnValueChanged", function()
			NecrosisConfig.NecrosisAngle = this:GetValue()
			GameTooltip:SetText(this:GetValue())
			Necrosis:ButtonSetup()
		end)

		NecrosisRotationLow:SetText("0")
		NecrosisRotationHigh:SetText("360")

		-- lets create a hidden frame container for the mount selection buttons
		frame = CreateFrame("Frame", "NecrosisMountsSelectionFrame", NecrosisButtonsConfig2)
		frame:SetWidth(222);
		frame:SetHeight(75);
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("CENTER", NecrosisGeneralFrame, "CENTER", 0, -25)

		frame:SetBackdrop({	bgFile 		= "Interface/Tooltips/UI-Tooltip-Background", 
	                      edgeFile 	= "Interface/Tooltips/UI-Tooltip-Border", 
	                      tile 			= true, tileSize = 16, edgeSize = 16, 
	                      insets 		= { left = 4, right = 4, top = 4, bottom = 4 }});
		frame:SetBackdropColor(0,0,0,1);

		-- create the navbar page info text
		local NecrosisCompanionPageNumber = frame:CreateFontString("NecrosisCompanionPageNumber", "OVERLAY", "GameFontNormalSmall")
		NecrosisCompanionPageNumber:Show()
		NecrosisCompanionPageNumber:ClearAllPoints()
		NecrosisCompanionPageNumber:SetPoint("TOP", NecrosisMountsSelectionFrame, "BOTTOM", 0, -10)
		NecrosisCompanionPageNumber:SetTextColor(1, 1, 1)
		NecrosisCompanionPageNumber:SetText("Page 1 of n")
		
		-- prev button
		frame = CreateFrame("Button", "NecrosisCompanionPrevButton", NecrosisButtonsConfig2)
		frame:SetWidth(32);
		frame:SetHeight(32);
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisCompanionPageNumber, "LEFT", -10, 0)
		frame:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
		frame:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down")
		frame:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled")
		frame:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
		frame:GetHighlightTexture():SetBlendMode("ADD")
		frame:SetScript("OnClick", function()
			 Necrosis:SetCompanionPage(NecrosisMountsSelectionFrame.pageMount - 1);
		end);
		
		-- next button
		frame = CreateFrame("Button", "NecrosisCompanionNextButton", NecrosisButtonsConfig2)
		frame:SetWidth(32);
		frame:SetHeight(32);
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisCompanionPageNumber, "RIGHT", 10, 0)
		frame:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
		frame:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
		frame:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled")
		frame:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
		frame:GetHighlightTexture():SetBlendMode("ADD")
		frame:SetScript("OnClick", function()
			 Necrosis:SetCompanionPage((NecrosisMountsSelectionFrame.pageMount or 0)+1);
		end);
		
		-- now create 12 mount selection buttons in 2 rows of 6 buttons each (similar to the layout in the companion's frame)
		frame = CreateFrame("CheckButton", "NecrosisCompanionButton1", NecrosisButtonsConfig2, "CompanionButtonTemplate")
		frame:SetID("1")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", NecrosisMountsSelectionFrame)
		frame:SetScript("OnEnter", NecrosisCompanionButton_OnEnter)
		frame:SetScript("OnClick", nil)
		frame:SetScript("OnDragStart", NecrosisCompanionButton_OnDrag)
		frame:SetScript("OnReceiveDrag", nil)

		frame = CreateFrame("CheckButton", "NecrosisCompanionButton2", NecrosisButtonsConfig2, "CompanionButtonTemplate")
		frame:SetID("2")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisCompanionButton1, "RIGHT")
		frame:SetScript("OnEnter", NecrosisCompanionButton_OnEnter)
		frame:SetScript("OnClick", nil)
		frame:SetScript("OnDragStart", NecrosisCompanionButton_OnDrag)
		frame:SetScript("OnReceiveDrag", nil)

		frame = CreateFrame("CheckButton", "NecrosisCompanionButton3", NecrosisButtonsConfig2, "CompanionButtonTemplate")
		frame:SetID("3")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisCompanionButton2, "RIGHT")
		frame:SetScript("OnEnter", NecrosisCompanionButton_OnEnter)
		frame:SetScript("OnClick", nil)
		frame:SetScript("OnDragStart", NecrosisCompanionButton_OnDrag)
		frame:SetScript("OnReceiveDrag", nil)

		frame = CreateFrame("CheckButton", "NecrosisCompanionButton4", NecrosisButtonsConfig2, "CompanionButtonTemplate")
		frame:SetID("4")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisCompanionButton3, "RIGHT")
		frame:SetScript("OnEnter", NecrosisCompanionButton_OnEnter)
		frame:SetScript("OnClick", nil)
		frame:SetScript("OnDragStart", NecrosisCompanionButton_OnDrag)
		frame:SetScript("OnReceiveDrag", nil)

		frame = CreateFrame("CheckButton", "NecrosisCompanionButton5", NecrosisButtonsConfig2, "CompanionButtonTemplate")
		frame:SetID("5")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisCompanionButton4, "RIGHT")
		frame:SetScript("OnEnter", NecrosisCompanionButton_OnEnter)
		frame:SetScript("OnClick", nil)
		frame:SetScript("OnDragStart", NecrosisCompanionButton_OnDrag)
		frame:SetScript("OnReceiveDrag", nil)

		frame = CreateFrame("CheckButton", "NecrosisCompanionButton6", NecrosisButtonsConfig2, "CompanionButtonTemplate")
		frame:SetID("6")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisCompanionButton5, "RIGHT")
		frame:SetScript("OnEnter", NecrosisCompanionButton_OnEnter)
		frame:SetScript("OnClick", nil)
		frame:SetScript("OnDragStart", NecrosisCompanionButton_OnDrag)
		frame:SetScript("OnReceiveDrag", nil)

		frame = CreateFrame("CheckButton", "NecrosisCompanionButton7", NecrosisButtonsConfig2, "CompanionButtonTemplate")
		frame:SetID("7")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT", NecrosisMountsSelectionFrame)
		frame:SetScript("OnEnter", NecrosisCompanionButton_OnEnter)
		frame:SetScript("OnClick", nil)
		frame:SetScript("OnDragStart", NecrosisCompanionButton_OnDrag)
		frame:SetScript("OnReceiveDrag", nil)

		frame = CreateFrame("CheckButton", "NecrosisCompanionButton8", NecrosisButtonsConfig2, "CompanionButtonTemplate")
		frame:SetID("8")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisCompanionButton7, "RIGHT")
		frame:SetScript("OnEnter", NecrosisCompanionButton_OnEnter)
		frame:SetScript("OnClick", nil)
		frame:SetScript("OnDragStart", NecrosisCompanionButton_OnDrag)
		frame:SetScript("OnReceiveDrag", nil)

		frame = CreateFrame("CheckButton", "NecrosisCompanionButton9", NecrosisButtonsConfig2, "CompanionButtonTemplate")
		frame:SetID("9")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisCompanionButton8, "RIGHT")
		frame:SetScript("OnEnter", NecrosisCompanionButton_OnEnter)
		frame:SetScript("OnClick", nil)
		frame:SetScript("OnDragStart", NecrosisCompanionButton_OnDrag)
		frame:SetScript("OnReceiveDrag", nil)

		frame = CreateFrame("CheckButton", "NecrosisCompanionButton10", NecrosisButtonsConfig2, "CompanionButtonTemplate")
		frame:SetID("10")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisCompanionButton9, "RIGHT")
		frame:SetScript("OnEnter", NecrosisCompanionButton_OnEnter)
		frame:SetScript("OnClick", nil)
		frame:SetScript("OnDragStart", NecrosisCompanionButton_OnDrag)
		frame:SetScript("OnReceiveDrag", nil)

		frame = CreateFrame("CheckButton", "NecrosisCompanionButton11", NecrosisButtonsConfig2, "CompanionButtonTemplate")
		frame:SetID("11")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisCompanionButton10, "RIGHT")
		frame:SetScript("OnEnter", NecrosisCompanionButton_OnEnter)
		frame:SetScript("OnClick", nil)
		frame:SetScript("OnDragStart", NecrosisCompanionButton_OnDrag)
		frame:SetScript("OnReceiveDrag", nil)

		frame = CreateFrame("CheckButton", "NecrosisCompanionButton12", NecrosisButtonsConfig2, "CompanionButtonTemplate")
		frame:SetID("12")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisCompanionButton11, "RIGHT")
		frame:SetScript("OnEnter", NecrosisCompanionButton_OnEnter)
		frame:SetScript("OnClick", nil)
		frame:SetScript("OnDragStart", NecrosisCompanionButton_OnDrag)
		frame:SetScript("OnReceiveDrag", nil)
		
		-- create the left/right mount containers which will hold the selected mounts
		frame = CreateFrame("CheckButton", "NecrosisSelectedMountLeft", NecrosisMountsSelectionFrame, "CompanionButtonTemplate")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOM", NecrosisMountsSelectionFrame, "TOP", -25, 25)
		frame:SetScript("OnEnter", NecrosisCompanionButton_OnEnter)
		frame:SetScript("OnClick", nil)
		frame:SetScript("OnDragStart", nil)
		frame:SetScript("OnReceiveDrag", NecrosisSelectedMountButton_OnReceiveDrag)
		
		frame = CreateFrame("CheckButton", "NecrosisSelectedMountRight", NecrosisMountsSelectionFrame, "CompanionButtonTemplate")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOM", NecrosisMountsSelectionFrame, "TOP", 25, 25)
		frame:SetScript("OnEnter", NecrosisCompanionButton_OnEnter)
		frame:SetScript("OnClick", nil)
		frame:SetScript("OnDragStart", nil)
		frame:SetScript("OnReceiveDrag", NecrosisSelectedMountButton_OnReceiveDrag)

		local FontString = frame:CreateFontString("NecrosisChooseMountsText", "OVERLAY", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("BOTTOM", NecrosisMountsSelectionFrame, "TOP", 0, 70)
		FontString:SetTextColor(1, 1, 1)
		--TODO: translate this
		FontString:SetText("Select your mounts:");
		
		local FontString = frame:CreateFontString("NecrosisLeftMountText", "OVERLAY", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("RIGHT", NecrosisSelectedMountLeft, "LEFT", -10, 0)
		FontString:SetTextColor(1, 1, 1)
		FontString:SetText(self.Config.Buttons["Monture - Clic gauche"])

		local FontString = frame:CreateFontString("NecrosisRightMountText", "OVERLAY", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", NecrosisSelectedMountRight, "RIGHT", 10, 0)
		FontString:SetTextColor(1, 1, 1)
		FontString:SetText(self.Config.Buttons["Monture - Clic droit"])
		
	end
	
	-- the frame is created, so set some defaults
	NecrosisMountsSelectionFrame.idMount = GetCompanionInfo("MOUNT", 1);
	
	-- set to 1st page
	Necrosis:SetCompanionPage(0)

	-- make sure our mount buttons are updated
	Necrosis:UpdateMountButtons()
	
	-- the spellID's (not creatureID's) for the selected left & right mounts are stored in savedvariables
	-- if nothing is specified (empty / reset config) then use felsteed (5784) and dreadsteed (23161) as the default spellids
	if (NecrosisConfig.LeftMount) then
		NecrosisInitSelectedMountButton(NecrosisSelectedMountLeft, NecrosisConfig.LeftMount);
	else
		NecrosisInitSelectedMountButton(NecrosisSelectedMountLeft, 5784);
	end
	
	if (NecrosisConfig.RightMount) then
		NecrosisInitSelectedMountButton(NecrosisSelectedMountRight, NecrosisConfig.RightMount);
	else
		NecrosisInitSelectedMountButton(NecrosisSelectedMountRight, 23161);
	end

	NecrosisRotation:SetValue(NecrosisConfig.NecrosisAngle)
	NecrosisLockButtons:SetChecked(NecrosisConfig.NecrosisLockServ)

	local boutons = {"Firestone", "Spellstone", "HealthStone", "Soulstone", "BuffMenu", "Mount", "PetMenu", "CurseMenu", "Metamorphosis"}
	for i in ipairs(boutons) do
		_G["NecrosisShow"..boutons[i]]:SetChecked(NecrosisConfig.StonePosition[i] > 0)
		_G["NecrosisShow"..boutons[i]]:SetText(self.Config.Buttons.Name[i])
	end
	
	NecrosisButtonsConfig1Text:SetText(self.Config.Buttons["Choix des boutons a afficher"])
	NecrosisButtonsConfig2Text:SetText(self.Config.Menus["Options Generales"])
	NecrosisRotationText:SetText(self.Config.Buttons["Rotation des boutons"])
	NecrosisLockButtons:SetText(self.Config.Buttons["Fixer les boutons autour de la sphere"])

	local frame = _G["NecrosisButtonsConfig"]
	frame:Show()
end

------------------------------------------------------------------------------------------------------
-- MOUNT FUNCTIONS
------------------------------------------------------------------------------------------------------
function Necrosis:SetCompanionPage(num)
	NecrosisMountsSelectionFrame.pageMount = num;
	
	num = num + 1;	--For easier usage
	local maxpage = ceil(GetNumCompanions("MOUNT")/NUM_COMPANIONS_PER_PAGE);
	NecrosisCompanionPageNumber:SetFormattedText(MERCHANT_PAGE_NUMBER, num, maxpage);
	
	if ( num <= 1 ) then
		NecrosisCompanionPrevButton:Disable();
	else
		NecrosisCompanionPrevButton:Enable();
	end
	
	if ( num >= maxpage ) then
		NecrosisCompanionNextButton:Disable();
	else
		NecrosisCompanionNextButton:Enable();
	end
	
	Necrosis:UpdateMountButtons();
	--PetPaperDollFrame_UpdateCompanionCooldowns();
end

function Necrosis:UpdateMountButtons()
	local button, iconTexture, id;
	local creatureID, creatureName, spellID, icon, active;
	local offset, selected;

	offset = (NecrosisMountsSelectionFrame.pageMount or 0)*NUM_COMPANIONS_PER_PAGE;
	--offset = 0;
	selected = FindCompanionIndex(NecrosisMountsSelectionFrame.idMount);
	--selected = 0;

	for i = 1, NUM_COMPANIONS_PER_PAGE do
		button = _G["NecrosisCompanionButton"..i];
		id = i + (offset or 0);
		creatureID, creatureName, spellID, icon, active = GetCompanionInfo("MOUNT", id);
		button.creatureID = creatureID;
		button.spellID = spellID;
		button.active = active;
		if ( creatureID ) then
			button:SetNormalTexture(icon);
			button:Enable();
		else
			button:Disable();
		end
		if ( (id == selected) and creatureID ) then
			button:SetChecked(true);
		else
			button:SetChecked(false);
		end
		
		if ( active ) then
			_G["NecrosisCompanionButton"..i.."ActiveTexture"]:Show();
		else
			_G["NecrosisCompanionButton"..i.."ActiveTexture"]:Hide();
		end
	end
	
	if ( selected > 0 ) then
		creatureID, creatureName, spellID, icon, active = GetCompanionInfo("MOUNT", selected);
--		if ( active and creatureID ) then
--			CompanionSummonButton:SetText(PetPaperDollFrameCompanionFrame.mode == "MOUNT" and BINDING_NAME_DISMOUNT or PET_DISMISS);
--		else
--			CompanionSummonButton:SetText(PetPaperDollFrameCompanionFrame.mode == "MOUNT" and MOUNT or SUMMON);
--		end
	end
end

function FindCompanionIndex(creatureID, mode)
--[[
	if ( not mode ) then
		mode = NecrosisMountsSelectionFrame.mode;
	end
	if (not creatureID ) then
		creatureID = (NecrosisMountsSelectionFrame.mode=="MOUNT") and NecrosisMountsSelectionFrame.idMount or NecrosisMountsSelectionFrame.idCritter;
	end
--]]
	for i=1,GetNumCompanions("MOUNT") do
		if ( GetCompanionInfo("MOUNT", i) == creatureID ) then
			return i;
		end
	end
	return 0
end


function NecrosisCompanionButton_OnDrag(self)
	local offset = (NecrosisMountsSelectionFrame.pageMount or 0) * NUM_COMPANIONS_PER_PAGE;
	local dragged = self:GetID() + offset;
	PickupCompanion("MOUNT", dragged );
end

function NecrosisCompanionButton_OnEnter(self)
	if ( GetCVar("UberTooltips") == "1" ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, self);
	else
		GameTooltip:SetOwner(self, "ANCHOR_LEFT");
	end

	if (self.spellID) then
		if ( GameTooltip:SetHyperlink("spell:"..self.spellID) ) then
			self.UpdateTooltip = NecrosisCompanionButton_OnEnter;
		else
			self.UpdateTooltip = nil;
		end
	end
	GameTooltip:Show()
end

function NecrosisSelectedMountButton_OnReceiveDrag(self)
	local infoType, info1, info2 = GetCursorInfo();
	if (infoType == "companion") then
		-- info1 contains the mount index 
		-- info2 contains the companion type, e.g. "MOUNT" or "CRITTER"
	  local creatureID, creatureName, spellID, icon, active = GetCompanionInfo("MOUNT", info1);
		local button = _G[self:GetName()];
		
		-- a mount was dragged to the left/right selected mount button boxes, so save the spellID to savedvariables
		-- note: 
		--   using spellID because the API GetSpellInfo() will always return the correctly localised creature name.
		--   The creatureID cannot be used because the API GetCompanionInfo() does not always return the correctly localised creature name.
		if (button == NecrosisSelectedMountLeft) then
			NecrosisConfig.LeftMount = spellID;
		end
		if (button == NecrosisSelectedMountRight) then
			NecrosisConfig.RightMount = spellID;
		end
		
		button.creatureID = creatureID;
		button.creatureName = creatureName;
		button.spellID = spellID;
		button.active = active;
		
		if ( creatureID ) then
			button:SetNormalTexture(icon);
			button:Enable();
		else
			button:Disable();
		end
		
		if ( active ) then
			_G[self:GetName().."ActiveTexture"]:Show();
		else
			_G[self:GetName().."ActiveTexture"]:Hide();
		end
		
		--update mount button (on the sphere) and also the keybindings
		Necrosis:StoneAttribute("Own");
		Necrosis:BindName();
		
	end
	ClearCursor();
end

function NecrosisInitSelectedMountButton(button, id)
	if ( id ) then
		local mounts = GetNumCompanions("MOUNT");
		
		if (mounts > 0) then
			for index = 1, mounts do
				local creatureID, creatureName, spellID, icon, active = GetCompanionInfo("MOUNT", index);
				
				if ( spellID == id ) then
					button.creatureID = creatureID;
					button.creatureName = creatureName;
					button.spellID = spellID;
					button.active = active;
					
					if ( creatureID ) then
						button:SetNormalTexture(icon);
						button:Enable();
					else
						button:Disable();
					end
					
					if ( active ) then
						_G[button:GetName().."ActiveTexture"]:Show();
					else
						_G[button:GetName().."ActiveTexture"]:Hide();
					end		
					
					break;
				end
			end
		end
	end
end