-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- TOTAL RP 2
---- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- ---

function TRP2_Set_Module_Registre()
	if not TRP2_Module_Registre then
		TRP2_Module_Registre = {};
	end
	if not TRP2_Module_Registre[TRP2_Royaume] then
		TRP2_Module_Registre[TRP2_Royaume] = {};
	end
	if not TRP2_Module_Registre_Access then
		TRP2_Module_Registre_Access = {};
	end
	if not TRP2_Module_Registre_Access[TRP2_Royaume] then
		TRP2_Module_Registre_Access[TRP2_Royaume] = {};
	end
end

function TRP2_OpenPanelFiche(panel, onglet, sousonglet, mode, nom, arg1, arg2)
	if not onglet then
		onglet = "Registre";
	end
	if not mode then
		mode = "Consulte";
	end
	if nom ~= TRP2_Joueur then
		TRP2MainFrameFicheJoueurMenuOngletOngletRetourListe:Show();
	end
	TRP2_PetsListAllCheck:Hide();
	if nom == TRP2_Joueur then
		TRP2_PetsListAllCheck:Show();
	end
	TRP2_ButtonSwitchSound:Hide();
	if onglet == "Registre" then
		TRP2MainFrameFicheJoueurOngletRegistreOngletHistoire:Enable();
		if not sousonglet then
			sousonglet = "Actu";
		end
		TRP2MainFrameFicheJoueurOngletRegistre:Show();
		if nom ~= TRP2_Joueur then
			local relation = TRP2_GetRelation(nom,TRP2_Joueur);
			local acces = TRP2_GetAccess(nom);
			
			TRP2_ButtonSwitchSound:Show();
			TRP2_RegistreCaractPanel:Hide();
			
			if TRP2_GetInfo(nom,"bMute",false) then
				TRP2_ButtonSwitchSoundSwitch:Show();
			else
				TRP2_ButtonSwitchSoundSwitch:Hide();
			end
			TRP2_RegistreAurasPanelBoutonForce:Show();
			
			TRP2MainFrameFicheJoueurMenuOngletOngletRelation:Show();
			TRP2MainFrameFicheJoueurMenuOngletOngletDelete:Show();
			TRP2_SetTooltipForFrame(TRP2MainFrameFicheJoueurMenuOngletOngletDelete,TRP2MainFrameFicheJoueurMenuOngletOngletDelete,"Bottom",0,0,TRP2_FT(TRP2_LOC_DeletePerso,nom));
			TRP2_SetTooltipForFrame(TRP2MainFrameFicheJoueurMenuOngletOngletRelation,TRP2MainFrame,"RIGHT",-10,-415,
			"{w}"..TRP2_LOC_Relation.." : "..TRP2_relation_color[relation]..TRP2_LOC_RelationTab[relation],
			"{o}"..TRP2_LOC_AccessLevel.." : {w}"..TRP2_LOC_AccessTab[acces]..TRP2_LOC_RELACCES_TT.."\n{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_RelationChange.."\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_AccessChange);
			TRP2MainFrameFicheJoueurMenuOngletOngletRelationIcon:SetTexture(TRP2_relation_texture[relation]);
			TRP2MainFrameFicheJoueurMenuOngletOngletRelationAccess:SetText(acces);
			if acces ~= 1 then
				TRP2MainFrameFicheJoueurMenuOngletOngletRelationIcon:SetDesaturated(false);
			else
				TRP2MainFrameFicheJoueurMenuOngletOngletRelationIcon:SetDesaturated(true);
			end
			if TRP2_GetWithDefaut(TRP2_GetInfo(nom,"Actu",{}),"PlayerIcon") then
				SetPortraitToTexture(TRP2_PanelPortrait,"Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetInfo(nom,"Actu",{}),"PlayerIcon"));
			elseif UnitName("target") ==  nom then
				SetPortraitTexture(TRP2_PanelPortrait,"target");
			elseif TRP2_GetInfo(nom,"Sex") and TRP2_GetInfo(nom,"Race") then
				SetPortraitToTexture(TRP2_PanelPortrait,"Interface\\ICONS\\"..TRP2_textureRace[TRP2_enRace][TRP2_textureSex[UnitSex("player")]]);
			else
				SetPortraitToTexture(TRP2_PanelPortrait,"Interface\\ICONS\\Achievement_Boss_Nexus_Prince_Shaffar");
			end
			TRP2_FicheJoueurActuPlayerIcon:Disable();
			TRP2_FicheJoueurActuActuScrollEditBox.disabled = true;
			TRP2_FicheJoueurActuStatutRPButton:Disable();
			TRP2_FicheJoueurActuStatutXPButton:Disable();
			TRP2_FicheJoueurActuActuButton:Disable();
			TRP2_FicheJoueurActuNotesScrollEditBox.disabled = true;
			TRP2_getConnectedUser();
			if TRP2_ConnectedUser[nom] then
				if TRP2_UPDATERTAB[nom] ~= time() then -- Optimisation
					TRP2_UPDATERTAB[nom] = time();
					TRP2_SecureSendAddonMessage("GTVN",TRP2_SendVernNum(),nom); -- Send VerNumTab avec request des VerNum adverses
				end
			end
		else
			TRP2_RegistreAurasPanelBoutonForce:Hide();
			TRP2_FicheJoueurActuPlayerIcon:Enable();
			TRP2_FicheJoueurActuActuButton:Enable();
			TRP2_FicheJoueurActuStatutRPButton:Enable();
			TRP2_FicheJoueurActuStatutXPButton:Enable();
			TRP2_FicheJoueurActuActuScrollEditBox.disabled = true;
			TRP2_FicheJoueurActuNotesScrollEditBox.disabled = true;
			TRP2_RegistreOngletMenuAura:Show();
			--TRP2_RegistreCaractPanel:Show();
			if mode == "Consulte" then
				TRP2MainFrameFicheJoueurMenuOngletOngletEdition:Show();
			end
		end
		if sousonglet == "Actu" then
			TRP2_SetFicheActuConsulte(nom);
			TRP2_FicheJoueurActuNotes:Hide();
			if nom ~= TRP2_Joueur then
				TRP2_FicheJoueurActuNotes:Show();
			end
		elseif sousonglet == "General" then
			if mode == "Consulte" then
				TRP2_SetFicheGeneralConsulte(nom);
			elseif mode == "Edition" then
				TRP2_SetFicheGeneralEdit();
			end
		elseif sousonglet == "Physique" then
			if mode == "Consulte" then
				TRP2_SetFichePhysiqueConsulte(nom);
			elseif mode == "Edition" then
				TRP2_SetFichePhysiqueEdit();
			end
		elseif sousonglet == "Histoire" then
			if mode == "Consulte" then
				TRP2_SetFicheHistoireConsulte(nom);
			elseif mode == "Edition" then
				TRP2_SetFicheHistoireEdit();
			end
		elseif sousonglet == "Psycho" then
			if mode == "Consulte" then
				TRP2_SetFichePsychoConsulte(nom);
			elseif mode == "Edition" then
				TRP2_SetFichePsychoEdit();
			end
		elseif sousonglet == "Caracteristiques" then
			mode = "Consulte";
			TRP2_SetFicheCaractConsulte(nom);
			TRP2MainFrameFicheJoueurCaracteristiques:Show();
		end
	elseif onglet == "Pets" then
		if not sousonglet then
			sousonglet = "Pets_Liste";
		end
		if sousonglet == "Pets_Liste" then
			TRP2MainFrameFicheJoueurPetsListe:Show();
			TRP2_ChargerListePets(nom);
		elseif sousonglet == "ConsultePet" then
			TRP2MainFrameFicheJoueurPetsFrameConsulte:Show();
			TRP2_PetFrameOngletEdition:Show();
			TRP2_AfficherPetFrame(mode,nom);
		elseif sousonglet == "EditePet" then
			TRP2MainFrameFicheJoueurPetsFrameEdite:Show();
			TRP2_PetFrameOngletConsulte:Show();
			TRP2_EditerPetFrame(mode,nom);
		end
	end
	if _G["TRP2_LOC_"..sousonglet] then
		TRP2_PanelTitle:SetText(nom.." : ".._G["TRP2_LOC_"..sousonglet]);
	end
	
	TRP2MainFrameFicheJoueur:Show();
	return onglet, sousonglet, mode, nom, arg1, arg2;
end

function TRP2_SaveInfoPet()
	local petName = TRP2MainFrame.Mode;
	local petsTab = TRP2_GetInfo(TRP2_Joueur,"Pets",{});
	if not petsTab[petName] then
		petsTab[petName] = {};
	end
	if not petsTab[petName]["VerNum"] then
		petsTab[petName]["VerNum"] = 0;
	end
	petsTab[petName]["Nom"] = TRP2_EmptyToNil(TRP2_PetFrameEditionNom:GetText());
	petsTab[petName]["Description"] = TRP2_EmptyToNil(TRP2_PetFrameEditionFrameDescriScrollEditBox:GetText());
	petsTab[petName]["Histoire"] = TRP2_EmptyToNil(TRP2_PetFrameEditionFrameHistoireScrollEditBox:GetText());
	petsTab[petName]["Icone"] = TRP2_DefautToNil(TRP2_PetFrameEditionIconChoix.icone,"INV_Box_PetCarrier_01");
	petsTab[petName]["VerNum"] = petsTab[petName]["VerNum"] + 1;
	if petsTab[petName]["VerNum"] > 999 then
		petsTab[petName]["VerNum"] = 1;
	end
	TRP2_SetInfo(TRP2_Joueur,"Pets",petsTab);
	TRP2_OpenPanel("Fiche","Pets","ConsultePet",petName,TRP2_Joueur);
end

function TRP2_EditerPetFrame(petName,maitreName)
	-- On peut se permettre car déjà checké pleeeein de fois :
	local petsTab = TRP2_GetInfo(maitreName,"Pets",{})[petName];
	if not petsTab then petsTab = {}; end
	if UnitName("target") == petName then
		SetPortraitTexture(TRP2_PanelPortrait,"target");
	else
		SetPortraitToTexture(TRP2_PanelPortrait,"Interface\\ICONS\\"..string.gsub(TRP2_GetWithDefaut(petsTab,"Icone","INV_Box_PetCarrier_01"),"%.blp",""));
	end
	TRP2_PetFrameEditionNom:SetText(TRP2_GetWithDefaut(petsTab,"Nom",""));
	TRP2_PetFrameEditionFrameDescriScrollEditBox:SetText(TRP2_GetWithDefaut(petsTab,"Description",""));
	TRP2_PetFrameEditionFrameHistoireScrollEditBox:SetText(TRP2_GetWithDefaut(petsTab,"Histoire",""));
	TRP2_PetFrameEditionIconChoixIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(petsTab,"Icone","INV_Box_PetCarrier_01"));
	TRP2_PetFrameEditionIconChoix.icone = TRP2_GetWithDefaut(petsTab,"Icone","INV_Box_PetCarrier_01");
	TRP2_PanelTitle:SetText(TRP2_CTS(TRP2_FT(TRP2_LOC_EDITPETFRAME,maitreName)));
end

function TRP2_AfficherPetFrame(petName,maitreName)
	-- On peut se permettre car déjà checké pleeeein de fois :
	local petsTab = TRP2_GetInfo(maitreName,"Pets",{})[petName];
	if not petsTab then petsTab = {}; end
	if maitreName == TRP2_Joueur then
		TRP2_PetFrameOngletEdition:Show();
		TRP2_PetOngletMenuAura:Show();
	else
		TRP2_PetFrameOngletEdition:Hide();
		TRP2_PetOngletMenuAura:Hide();
	end
	
	if UnitName("target") == petName then
		SetPortraitTexture(TRP2_PanelPortrait,"target");
	else
		SetPortraitToTexture(TRP2_PanelPortrait,"Interface\\ICONS\\"..string.gsub(TRP2_GetWithDefaut(petsTab,"Icone","INV_Box_PetCarrier_01"),"%.blp",""));
	end
	TRP2_PanelTitle:SetText(TRP2_CTS(TRP2_FT(TRP2_LOC_PEtMaster,maitreName)));
	TRP2_PetsConsulteTitre:SetText(TRP2_CTS("{w}|TInterface\\ICONS\\"..TRP2_GetWithDefaut(petsTab,"Icone","INV_Box_PetCarrier_01")..":35:35|t "..TRP2_GetWithDefaut(petsTab,"Nom",petName)));
	TRP2_PetsConsulteDate:SetText(TRP2_CTS("{o}"..PET_TYPE_PET.." : {w}"..petName));
	local texte = "";
	if TRP2_GetWithDefaut(petsTab,"Description") then
		texte = "{o}"..TRP2_LOC_Description.." :\n\"{w}"..TRP2_GetWithDefaut(petsTab,"Description").."{o}\"\n\n";
	end
	if TRP2_GetWithDefaut(petsTab,"Histoire") then
		texte = texte.."{o}"..TRP2_LOC_Histoire.." :\n\"{w}"..TRP2_GetWithDefaut(petsTab,"Histoire").."{o}\"";
	end
	TRP2_AfficherAurasPourPet(petName,maitreName);
	TRP2_PetsDescription:SetText(TRP2_CTS(texte));
end

-- TODO : UPDATE FOR 5.4
function TRP2_ChargerListePets(Nom)
	local i = 0;
	local j = 0;
	local k = 0;
	local search = TRP2_EmptyToNil(TRP2_PetsListeRechercheSaisie:GetText());

	wipe(TRP2_PetsListeTab);

	TRP2MainFrameFicheJoueurPetsListeCadreListeButtonSlider:Hide();
	TRP2MainFrameFicheJoueurPetsListeCadreListeButtonSlider:SetValue(0);
	
	TRP2MainFrameFicheJoueurPetsListeCadreListeButtonSlider.Nom = Nom;
	
	local petsTab = TRP2_GetInfo(Nom,"Pets",{});
	
	if petsTab then
		table.foreach(petsTab,
			function(PetName)
				i = i + 1;
				if not search or TRP2_ApplyPattern(PetName,search) or TRP2_ApplyPattern(TRP2_GetWithDefaut(petsTab[PetName],"Nom",PetName),search) then
					j = j + 1;
					TRP2_PetsListeTab[PetName] = true;
				end
			end);
	end
	if Nom == TRP2_Joueur and TRP2_PetsListAllCheck:GetChecked() then
		for k=1,GetNumCompanions("MOUNT") do
			local creatureID, creatureName, creatureSpellID, icon, issummoned = GetCompanionInfo("MOUNT", k);
			local petTab = TRP2_GetInfo(TRP2_Joueur,"Pets",{})[creatureName];
			if not TRP2_PetsListeTab[creatureName] then
				i = i + 1;
				if not search or TRP2_ApplyPattern(creatureName,search) then
					j = j + 1;
					TRP2_PetsListeTab[creatureName] = icon;
				end
			end
		end
                --numPets, numOwned = C_PetJournal.GetNumPets(true);
                --TRP2_debug("Number of pets: " ..numPets);
                --for k=1,numPets do
		--for k=1,GetNumCompanions("CRITTER") do
			--local creatureID, creatureName, creatureSpellID, icon, issummoned = GetCompanionInfo("CRITTER", k);
                k=1;
                while C_PetJournal.GetPetInfoByIndex(k) do
                        local petID, speciesID, owned, customName, level, favorite, isRevoked, creatureName, icon, petType, companionID, tooltip, description, isWild, canBattle, isTradeable, isUnique = C_PetJournal.GetPetInfoByIndex(k);
                        --TRP2_debug("??:" ..creatureName);
                        if owned then
                            --TRP2_debug("Owned: " ..creatureName);
                            local petTab = TRP2_GetInfo(TRP2_Joueur,"Pets",{})[creatureName];
                            if not TRP2_PetsListeTab[creatureName] then
                                    i = i + 1;
                                    if not search or TRP2_ApplyPattern(creatureName,search) then
                                            j = j + 1;
                                            TRP2_PetsListeTab[creatureName] = icon;
                                    end
                            end
                        end
                        k=k+1;
		end
	end
	TRP2_PanelTitle:SetText(Nom.." : "..TRP2_LOC_PETLISTE);
	
	if j > 0 then
		TRP2_PetsListeVide:SetText("");
	elseif i == 0 then
		TRP2_PetsListeVide:SetText(TRP2_LOC_NoPet);
	else
		TRP2_PetsListeVide:SetText(TRP2_LOC_SelectVide);
	end
	if i > 0 then
		TRP2_PetsListeTitre1:SetText(PETS.." : "..j.."/"..i);
	else
		TRP2_PetsListeTitre1:SetText(TRP2_LOC_NOPETCHANGED);
	end

	if j > 8 then
		TRP2MainFrameFicheJoueurPetsListeCadreListeButtonSlider:Show();
		local total = floor((j-1)/8);
		TRP2MainFrameFicheJoueurPetsListeCadreListeButtonSlider:SetMinMaxValues(0,total);
		TRP2MainFrameFicheJoueurPetsListeCadreListeButtonSlider:SetScript("OnValueChanged",function(self)
			TRP2_ChargerListePetsPage(self:GetValue());
		end);
	end
	TRP2_ChargerListePetsPage(0);
end

function TRP2_ChargerListePetsPage(num)
	for k=1,8,1 do --Initialisation
		getglobal("TRP2MainFrameFicheJoueurPetsListeCadreListeBouton"..k):Hide();
	end

	local i = 1;
	local j = 1;
	table.foreach(TRP2_PetsListeTab,
	function(Entree)
		if i > num*8 and i <= (num+1)*8 then
			local nom = TRP2MainFrameFicheJoueurPetsListeCadreListeButtonSlider.Nom;
			local petsTab = TRP2_GetInfo(nom,"Pets",{})[Entree];
			getglobal("TRP2MainFrameFicheJoueurPetsListeCadreListeBouton"..j):Show();
			getglobal("TRP2MainFrameFicheJoueurPetsListeCadreListeBouton"..j.."Nom"):SetText(TRP2_CTS(TRP2_GetWithDefaut(petsTab,"Nom",Entree)));
			if TRP2_PetsListeTab[Entree] == true then
				getglobal("TRP2MainFrameFicheJoueurPetsListeCadreListeBouton"..j.."BoutonIcon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(petsTab,"Icone","INV_Box_PetCarrier_01"));
			else
				getglobal("TRP2MainFrameFicheJoueurPetsListeCadreListeBouton"..j.."BoutonIcon"):SetTexture(TRP2_PetsListeTab[Entree]);
			end
			getglobal("TRP2MainFrameFicheJoueurPetsListeCadreListeBouton"..j.."Bouton"):SetScript("OnClick", function(self,button)
				if button == "LeftButton" then
					TRP2_OpenPanel("Fiche","Pets","ConsultePet",Entree,nom);
				else
					if nom == TRP2_Joueur then
						StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_DELETEPETS,Entree));
						TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
							wipe(TRP2_GetInfo(nom,"Pets")[Entree]);
							TRP2_GetInfo(nom,"Pets")[Entree] = nil;
							TRP2_ChargerListePets(nom);
						end);
					end
				end
			end );
			local message;
			--if TRP2_PetsListeTab[Entree] == true then
				message = "{w}|TInterface\\ICONS\\"..TRP2_GetWithDefaut(petsTab,"Icone","INV_Box_PetCarrier_01")..":35:35|t "..TRP2_GetWithDefaut(petsTab,"Nom",Entree);
			--else
			--	message = "{w}|TInterface\\ICONS\\"..TRP2_GetWithDefaut(petsTab,"Icone",TRP2_PetsListeTab[Entree])..":35:35|t "..TRP2_GetWithDefaut(petsTab,"Nom",Entree);
			--end
			getglobal("TRP2MainFrameFicheJoueurPetsListeCadreListeBouton"..j.."Bouton"):SetScript("OnEnter", function(self) 
				TRP2_SetTooltipForFrame(self,self,"RIGHT",0,0,
				message,
				"{v}< "..TRP2_FT(TRP2_LOC_PEtMaster,nom).."{v} >".."\n{w}"..PET.." : {o}"..Entree.."\n{j}"..TRP2_LOC_CLIC.." {w}: "..
				TRP2_LOC_ConsulterFiche.."\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..CALENDAR_DELETE_EVENT);
				TRP2_RefreshTooltipForFrame(self);
			end );
			j = j + 1;
		end
		i = i + 1;
	end);
	
end

function TRP2_nomComplet(nom,bNoTitre, royaume)

	if not nom or nom == "" then
		return "";
	end


	local Prenom = nom;
	if royaume then
		Prenom = string.gsub(nom,"-"..royaume,"");
	end
	local NomFamille = "";
	local Titre = "";
	
	local registreTab = TRP2_GetInfo(nom,"Registre",{});

	if not bNoTitre and TRP2_GetWithDefaut(registreTab,"Titre") then
		Titre = TRP2_GetWithDefaut(registreTab,"Titre").." ";
	end
	if TRP2_GetWithDefaut(registreTab,"Prenom") then
		Prenom = TRP2_GetWithDefaut(registreTab,"Prenom");
	end
	if TRP2_GetWithDefaut(registreTab,"Nom") then
		NomFamille = " "..TRP2_GetWithDefaut(registreTab,"Nom");
	end

	
	return tostring(Titre..Prenom..NomFamille);
end

function TRP2_EstDansLeReg(nom)
	if TRP2_Module_Registre[TRP2_Royaume][nom] ~= nil then
		-- TRP2_debug("Le personnage est dans le registre.");
		return true;
	else
		-- TRP2_debug("Le personnage n'est pas dans le registre");
		return false;
	end
end

function TRP2_EstIgnore(nom)
	if TRP2_Module_Registre_Access[TRP2_Royaume][nom] then
		return TRP2_Module_Registre_Access[TRP2_Royaume][nom] == 1;
	else
		return false;
	end
end

function TRP2_GetAccess(nom)
	if not nom then
		return 1;
	elseif TRP2_Module_Registre_Access[TRP2_Royaume][nom] then
		return TRP2_Module_Registre_Access[TRP2_Royaume][nom];
	else
		return 3;
	end
end

function TRP2_SetAccess(nom,access)
	TRP2_Module_Registre_Access[TRP2_Royaume][nom] = TRP2_DefautToNil(access,3);
	if TRP2_EstDansLeReg(nom) then
		TRP2_SetInfo(nom,"AuraVerNum",0);
	end
end

function TRP2_UpdateRegistre()
	local nom, royaume = UnitName("mouseover");
	if royaume then
		nom = nom.."-"..royaume;
	end
	if TRP2_EstDansLeReg(nom) then
		local race, raceEn = UnitRace("mouseover");
		local class, classEn = UnitClass("mouseover");
		TRP2_Module_Registre[TRP2_Royaume][nom]["Race"] = raceEn;
		TRP2_Module_Registre[TRP2_Royaume][nom]["RaceLoc"] = race;
		TRP2_Module_Registre[TRP2_Royaume][nom]["ClassLoc"] = class;
		TRP2_Module_Registre[TRP2_Royaume][nom]["Sex"] = UnitSex("mouseover");
		TRP2_Module_Registre[TRP2_Royaume][nom]["Faction"] = UnitFactionGroup("mouseover");
		TRP2_Module_Registre[TRP2_Royaume][nom]["Seen"] = true;
	end
end

function TRP2_EpurerRegistre()
	local count = 0;
	for _,v in pairs(TRP2_Module_Registre[TRP2_Royaume]) do
		if not v["Seen"] then
			count = count + 1;
		end
	end
	if count == 0 then
		StaticPopupDialogs["TRP2_JUST_TEXT"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_EpurerRegVide);
		TRP2_ShowStaticPopup("TRP2_JUST_TEXT",TRP2MainFrame);
	else
		StaticPopupDialogs["TRP2_CONFIRM_ACTION"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_EpurerRegCount,count));
		TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION",TRP2MainFrame,function()
			for k,v in pairs(TRP2_Module_Registre[TRP2_Royaume]) do
				if not v["Seen"] then
					wipe(TRP2_Module_Registre[TRP2_Royaume][k]);
					TRP2_Module_Registre[TRP2_Royaume][k] = nil;
				end
			end
			TRP2_ChargerListeRegistre();
		end);
	end
end

function TRP2_AjouterAuRegistre(nom, selected)
	TRP2_Module_Registre[TRP2_Royaume][nom] = {};
	TRP2_Module_Registre[TRP2_Royaume][nom]["Faction"] = UnitFactionGroup("player");
	if selected then
		local race, raceEn = UnitRace("target");
		TRP2_Module_Registre[TRP2_Royaume][nom]["Race"] = raceEn;
		TRP2_Module_Registre[TRP2_Royaume][nom]["Sex"] = UnitSex("target");
		TRP2_Module_Registre[TRP2_Royaume][nom]["Seen"] = true;
		TRP2_Module_Registre[TRP2_Royaume][nom]["Faction"] = UnitFactionGroup("target");
	end
	TRP2_Module_Registre[TRP2_Royaume][nom]["DateAjout"] = date("%d/%m/%y");
	if TRP2_GetConfigValueFor("NotifyNew",false) then
		TRP2_Afficher(TRP2_FT(TRP2_LOC_RegAdd,"{j}".."|Hplayer:"..nom.."|h[|cffaaaaff"..nom.."{j}]|h"));
	end
	if TRP2MainFrame:IsVisible() and TRP2MainFrame.Panel == "Registre" and TRP2MainFrame.Onglet == "ListeRegistre" then
		TRP2_OpenPanel("Registre", "ListeRegistre");
	end
end

function TRP2_ReceiveVerNumList(tableau,sender)
	-- 1 : VerNum de TRP : 5
	-- 2 : VerNum : Actuellement : 4
	-- 3 : VerNum : InfoBase : 4
	-- 4 : VerNum : Physique : 4
	-- 5 : VerNum : Psycho : 4
	-- 6 : VerNum : Histoire : 4
	-- 7 : VerNum : Caract : 4
	-- 8 : Nom du mini-pet actuel : 51
	-- 9 : Vernum du mini-pet actuel : 4
	-- 10 : Nom de la monture actuelle : 51
	-- 11 : Vernum de la monture actuelle : 4
	-- 12 : Nom du pet actuelle : 51
	-- 13 : Vernum du pet actuelle : 4
	-- 14 : VerNum Aura : 4
	-- 15 : FREE : 3
	-- 16 : VernumAura Minion : 4
	-- 17 : VernumAura Mount : 4
	-- 18 : VernumAura Pet : 4
	-- Total : 213/246 ouf !
	if TRP2_CheckVerNumList(tableau) then -- On vérifie la structure des vernums
		if not TRP2_bAlreadyTell and (tonumber(tableau[1]) > tonumber(TRP2_version)) and TRP2_GetConfigValueFor("NotifyOnNew",true) then
			TRP2_bAlreadyTell = true;
			TRP2_NewVersionDispo(tonumber(tableau[1]));
		end
		if not TRP2_EstDansLeReg(sender) then
			if TRP2_GetConfigValueFor("AutoNew",true) then
				TRP2_AjouterAuRegistre(sender, UnitName("target") == sender);
			else
				return;
			end
		end
		-- Enregistrer le client
		TRP2_SetInfo(sender,"Client","TotalRP2 v"..tableau[1]);
		-- Requete des informations actuelle
		if TRP2_GetWithDefaut(TRP2_GetInfo(sender,"Actu",{}),"VerNum",0) ~= tonumber(tableau[2]) then
			TRP2_OpenRequestForObject("Actu",sender);
		end
		-- Requete des informations de base
		if TRP2_GetWithDefaut(TRP2_GetInfo(sender,"Registre",{}),"VerNum",0) ~= tonumber(tableau[3]) then
			TRP2_OpenRequestForObject("Registre",sender);
		end
		-- Requete des informations physique
		if TRP2_GetWithDefaut(TRP2_GetInfo(sender,"Physique",{}),"VerNum",0) ~= tonumber(tableau[4]) then
			TRP2_OpenRequestForObject("Physique",sender);
		end
		-- Requete des informations psycho
		if TRP2_GetWithDefaut(TRP2_GetInfo(sender,"Psycho",{}),"VerNum",0) ~= tonumber(tableau[5]) then
			TRP2_OpenRequestForObject("Psycho",sender);
		end
		-- Requete des informations actuelle
		if TRP2_GetWithDefaut(TRP2_GetInfo(sender,"Histoire",{}),"VerNum",0) ~= tonumber(tableau[6]) then
			TRP2_OpenRequestForObject("Histoire",sender);
		end
		-- Requete des informations Caracteristique
		if TRP2_GetWithDefaut(TRP2_GetInfo(sender,"Caract",{}),"VerNum",0) ~= tonumber(tableau[7]) then
			-- TODO : caract
		end
		-- Requete des info minion
		if TRP2_EmptyToNil(tableau[8]) then
			if tableau[9] == "-1" then
				if TRP2_GetInfo(sender,"Pets",{})[tableau[8]] then
					wipe(TRP2_GetInfo(sender,"Pets",{})[tableau[8]])
					TRP2_GetInfo(sender,"Pets",{})[tableau[8]] = nil;
				end
			else
				if not TRP2_GetInfo(sender,"Pets",{})[tableau[8]] or TRP2_GetInfo(sender,"Pets",{})[tableau[8]]["VerNum"] ~= tonumber(tableau[9]) then
					TRP2_OpenRequestForObject("PET"..tableau[8],sender);
				elseif TRP2_GetInfo(sender,"Pets",{})[tableau[8]]["AurasVerNum"] ~= tonumber(tableau[16]) then
					-- Request juste des auras
					TRP2_OpenRequestForObject("APET"..tableau[8],sender);
					local tab = TRP2_GetInfo(sender,"Pets",{});
					tab[tableau[8]]["AurasVerNum"] = tonumber(tableau[16]);
					TRP2_SetInfo(sender,"Pets",tab);
				end
			end
		end
		-- Requete des info mount
		if TRP2_EmptyToNil(tableau[10]) then
			if tableau[11] == "-1" then
				if TRP2_GetInfo(sender,"Pets",{})[tableau[10]] then
					wipe(TRP2_GetInfo(sender,"Pets",{})[tableau[10]])
					TRP2_GetInfo(sender,"Pets",{})[tableau[10]] = nil;
				end
			else
				if not TRP2_GetInfo(sender,"Pets",{})[tableau[10]] or TRP2_GetInfo(sender,"Pets",{})[tableau[10]]["VerNum"] ~= tonumber(tableau[11]) then
					TRP2_OpenRequestForObject("PET"..tableau[10],sender);
				elseif TRP2_GetInfo(sender,"Pets",{})[tableau[10]]["AurasVerNum"] ~= tonumber(tableau[17]) then
					-- Request juste des auras
					TRP2_OpenRequestForObject("APET"..tableau[10],sender);
					local tab = TRP2_GetInfo(sender,"Pets",{});
					tab[tableau[10]]["AurasVerNum"] = tonumber(tableau[17]);
					TRP2_SetInfo(sender,"Pets",tab);
				end	
			end
		end
		-- Requete info pet
		if TRP2_EmptyToNil(tableau[12]) then
			if tableau[13] == "-1" then
				if TRP2_GetInfo(sender,"Pets",{})[tableau[12]] then
					wipe(TRP2_GetInfo(sender,"Pets",{})[tableau[12]])
					TRP2_GetInfo(sender,"Pets",{})[tableau[12]] = nil;
				end
			else
				if not TRP2_GetInfo(sender,"Pets",{})[tableau[12]] or TRP2_GetInfo(sender,"Pets",{})[tableau[12]]["VerNum"] ~= tonumber(tableau[13]) then
					TRP2_OpenRequestForObject("PET"..tableau[12],sender);
				elseif TRP2_GetInfo(sender,"Pets",{})[tableau[12]]["AurasVerNum"] ~= tonumber(tableau[18]) then
					-- Request juste des auras
					TRP2_OpenRequestForObject("APET"..tableau[12],sender);
					local tab = TRP2_GetInfo(sender,"Pets",{});
					tab[tableau[12]]["AurasVerNum"] = tonumber(tableau[18]);
					TRP2_SetInfo(sender,"Pets",tab);
				end	
			end
		end
		-- Requete auras
		if TRP2_GetInfo(sender,"AuraVerNum",0) ~= tonumber(tableau[14]) then
			TRP2_OpenRequestForObject("Auras",sender);
		end
		if UnitName("mouseover") == sender then
			TRP2_MouseOverTooltip("mouseover");
		end
	else
		TRP2_debug("TRP2_CheckVerNumList false");
	end
end

---------------------------------------
-- CHECK INFO
---------------------------------------

function TRP2_CheckVerNumList(tableau)
	local ok = true;
	if not tableau[1] or not string.match(tableau[1],"%d%d%d%d") then
		ok = false;
	end
	for i=2,7,1 do
		if not tableau[i] or not string.match(tableau[i],"%d+") then
			ok = false;
		end
	end
	return ok;
end

function TRP2_RecupTTInfo()
	GameTooltip:Hide();
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	GameTooltip:SetUnit("target");
	GameTooltip:Show();
	local infoTab = {};
	local i = GameTooltip:NumLines();
	for j = 1, GameTooltip:NumLines() do
		infoTab[j] = getglobal("GameTooltipTextLeft" ..  j):GetText();
	end
	GameTooltip:Hide();
	if infoTab[2] and TRP2_foundInTableString2(TRP2_compagnonPrefixe,infoTab[2]) then
		local nomMaitre = infoTab[2];
		local nomPet = infoTab[1];
		nomMaitre = TRP2_IsolerNomMaitre(nomMaitre)
		return nomPet, nomMaitre;
	end
        --Added by Lixxel (I know, copypasta)
        if infoTab[3] and TRP2_foundInTableString2(TRP2_compagnonPrefixe,infoTab[3]) then
		local nomMaitre = infoTab[3];
		local nomPet = infoTab[2];
		nomMaitre = TRP2_IsolerNomMaitre(nomMaitre)
		return nomPet, nomMaitre;
	end
end

function TRP2_IsolerNomMaitre(nomMaitre)
	nomMaitre = string.gsub(nomMaitre,"Serviteur de ","");
	nomMaitre = string.gsub(nomMaitre,"Serviteur d'","");
	nomMaitre = string.gsub(nomMaitre,"Familier de ",""); -- 's Pet
	nomMaitre = string.gsub(nomMaitre,"Familier d'","");
	nomMaitre = string.gsub(nomMaitre,"Mascotte de ",""); -- 's Companion
	nomMaitre = string.gsub(nomMaitre,"Mascotte d'","");
	nomMaitre = string.gsub(nomMaitre,"Gardien de ",""); -- 's Minion
	nomMaitre = string.gsub(nomMaitre,"Gardien d'","");
	nomMaitre = string.gsub(nomMaitre,"'s Guardian","");
	nomMaitre = string.gsub(nomMaitre,"'s Companion","");
	nomMaitre = string.gsub(nomMaitre,"'s Minion","");
	nomMaitre = string.gsub(nomMaitre,"'s Pet","");
	nomMaitre = string.gsub(nomMaitre,"Esbirro de ","");
	nomMaitre = string.gsub(nomMaitre,"Compañero de ","");
	nomMaitre = string.gsub(nomMaitre,"Guardián de ","");
	nomMaitre = string.gsub(nomMaitre,"Begleiter von ","");
	nomMaitre = string.gsub(nomMaitre,"Gefährte von ","");
	nomMaitre = string.gsub(nomMaitre,"Diener von ","");
	nomMaitre = string.gsub(nomMaitre,"Wächter von ","");
	return nomMaitre;
end

function TRP2_getConnectedUser()
	if not TRP2_GetConfigValueFor("UseBroadcast",true) then
		return
	end
	local name;
	wipe(TRP2_ConnectedUser);
	for i=1, MAX_CHANNEL_BUTTONS, 1 do
		name = GetChannelDisplayInfo(i);
		if name == TRP2_GetConfigValueFor("ChannelToUse","xtensionxtooltip2") then
			local j=1;
			while GetChannelRosterInfo(i, j) and j < 350 do
				name = GetChannelRosterInfo(i, j);
				TRP2_ConnectedUser[name] = 1;
				j = j + 1;
			end
			break;
		end
	end
end

function TRP2_RegDeleteAll()
	StaticPopupDialogs["TRP2_CONFIRM_ACTION"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_DeleteRegAll,Nom));
	TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION",TRP2MainFrame,function()
		wipe(TRP2_Module_Registre[TRP2_Royaume]);
		TRP2_ChargerListeRegistre();
	end);
end

function TRP2_ChargerListeRegistre()
	local i = 0;
	local j = 0;
	local numLevel = TRP2_RegistreListeLevelSlider.Valeur;
	local numRelation = TRP2_RegistreListeRelationSlider.Valeur;
	
	wipe(TRP2_RegistreListeTab);
	TRP2_getConnectedUser();
	TRP2MainFrameRegistreListeCadreListeButtonSlider:Hide();
	TRP2MainFrameRegistreListeCadreListeButtonSlider:SetValue(0);
	TRP2_RegistreListeLevelSliderValeur:SetText(TRP2_LOC_AccessTab[TRP2_RegistreListeLevelSlider.Valeur]);
	TRP2_RegistreListeRelationSliderValeur:SetText(TRP2_LOC_RelationTab[TRP2_RegistreListeRelationSlider.Valeur]);
	local matching = TRP2_RegistreListeRechercheSaisie:GetText();
	table.foreach(TRP2_Module_Registre[TRP2_Royaume],
		function(personnage)
			if personnage then
				i = i + 1;
				local matchingB = TRP2_nomComplet(personnage);
				if TRP2_ApplyPattern(matchingB,matching) or TRP2_ApplyPattern(personnage,matching) then
					if numLevel == 5 or TRP2_GetAccess(personnage) == numLevel then -- Check lvl
						if numRelation == 8 or numRelation == TRP2_GetRelation(personnage,TRP2_Joueur) then -- Check relation
							if TRP2_ConnectedUser[personnage] or not TRP2_RegistreListeConnectedCheck:GetChecked() then
								j = j + 1;
								TRP2_RegistreListeTab[j] = personnage;
							end
						end
					end
				end
			end;
		end);
	TRP2_PanelTitle:SetText(TRP2_LOC_REGISTRE.." : "..TRP2_LOC_ListeRegistre);
	if i ~= 0 then
		TRP2_RegistreListeTitre1:SetText(CHARACTER.." : "..j.." / "..i);
	else
		TRP2_RegistreListeTitre1:SetText(TRP2_LOC_RegVide);
	end
	
	if j > 0 then
		TRP2_RegistreListeVide:SetText("");
	elseif i == 0 then
		TRP2_RegistreListeVide:SetText(TRP2_LOC_RegVide);
	else
		TRP2_RegistreListeVide:SetText(TRP2_LOC_SelectVide);
	end

	if j > 8 then
		TRP2MainFrameRegistreListeCadreListeButtonSlider:Show();
		local total = floor((j-1)/8);
		TRP2MainFrameRegistreListeCadreListeButtonSlider:SetMinMaxValues(0,total);
	end
	
	-- Tri de TRP2_RegistreListeTab
	table.sort(TRP2_RegistreListeTab);
	
	TRP2_ChargerListeRegistrePage(0);
end

function TRP2_DeleteFromRegistre(nom)
	if TRP2_Module_Registre[TRP2_Royaume] and TRP2_Module_Registre[TRP2_Royaume][nom] then
		wipe(TRP2_Module_Registre[TRP2_Royaume][nom]);
		TRP2_Module_Registre[TRP2_Royaume][nom] = nil;
		--TRP2_Afficher(nom.." a correctement été supprimé du Registre.");
		if TRP2MainFrame:IsVisible() then
			TRP2_OpenPanel(TRP2MainFrame.Panel, TRP2MainFrame.Onglet,TRP2MainFrame.SousOnglet);
		end
		if nom == UnitName("target") then -- Si la cible est la personne delete
			TRP2_PlacerIconeCible(nom);
		end
	end
end

function TRP2_ChargerListeRegistrePage(num)
	for k=1,8,1 do --Initialisation
		getglobal("TRP2MainFrameRegistreListeCadreListeBouton"..k):Hide();
	end

	local i = 1;
	local j = 1;
	table.foreach(TRP2_RegistreListeTab,
	function(PersonnageButton)
		if i > num*8 and i <= (num+1)*8 then
			local Nom = TRP2_RegistreListeTab[PersonnageButton];
			getglobal("TRP2MainFrameRegistreListeCadreListeBouton"..j):Show();
			getglobal("TRP2MainFrameRegistreListeCadreListeBouton"..j.."BoutonIcon"):SetTexture(TRP2_relation_texture[TRP2_GetRelation(Nom,TRP2_Joueur)]);
			if TRP2_EstIgnore(Nom) then
				getglobal("TRP2MainFrameRegistreListeCadreListeBouton"..j.."BoutonIcon"):SetDesaturated(true);
			else
				getglobal("TRP2MainFrameRegistreListeCadreListeBouton"..j.."BoutonIcon"):SetDesaturated(false);
			end
			local NomComplet = TRP2_nomComplet(Nom,true);
			if TRP2_Module_Registre[TRP2_Royaume][Nom]["Faction"] == "Alliance" then
				NomComplet = "|TInterface\\BattlefieldFrame\\Battleground-Alliance.blp:25:25|t "..NomComplet;
			elseif TRP2_Module_Registre[TRP2_Royaume][Nom]["Faction"] == "Horde" then
				NomComplet = "|TInterface\\BattlefieldFrame\\Battleground-Horde.blp:25:25|t "..NomComplet;
			end
			getglobal("TRP2MainFrameRegistreListeCadreListeBouton"..j.."Nom"):SetText(TRP2_CTS(NomComplet));
			getglobal("TRP2MainFrameRegistreListeCadreListeBouton"..j.."Bouton"):SetScript("OnClick", function(self,button) 
				if button == "LeftButton" then
					TRP2_OpenPanel("Fiche","Registre","Actu","Consulte",Nom);
				else
					StaticPopupDialogs["TRP2_CONFIRM_ACTION"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_DeleteRegConfirm,Nom));
					TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION",TRP2MainFrame,TRP2_DeleteFromRegistre,Nom);
				end
			end );
			
			local Titre = TRP2_nomComplet(Nom);
			local message = "{w}"..Nom;
			if TRP2_GetInfo(Nom,"Sex") and TRP2_GetInfo(Nom,"Race") then
				Titre = "|TInterface\\ICONS\\"..TRP2_textureRace[TRP2_enRace][TRP2_textureSex[UnitSex("player")]]..":25:25|t "..Titre;
			end
			if TRP2_ConnectedUser[Nom] then
				message = message.."\n{v}< "..TRP2_LOC_ConnectNow.." >";
			end
			if TRP2_GetInfo(Nom,"DateAjout") then
				message = message.."\n{w}"..TRP2_LOC_DateAjout.." : {o}"..TRP2_GetInfo(Nom,"DateAjout");
			end
			message = message.."\n{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_ConsulterFiche.."\n{j}"..TRP2_LOC_CLICDROIT.." : {w}"..TRP2_FT(TRP2_LOC_DeletePerso,Nom);
			TRP2_SetTooltipForFrame(getglobal("TRP2MainFrameRegistreListeCadreListeBouton"..j.."Bouton"),
			getglobal("TRP2MainFrameRegistreListeCadreListeBouton"..j.."Bouton"),
			"TOPLEFT",0,0,Titre,message);
			j = j + 1;
		end
		i = i + 1;
	end);
	
end

function TRP2_GetRelation(personnage,joueur)
	local relTab = TRP2_GetInfo(personnage,"RelationTab",{});
	return TRP2_GetWithDefaut(relTab,TRP2_Joueur,2);
end

function TRP2_SetRelation(personnage,joueur,relation)
	local relTab = TRP2_GetInfo(personnage,"RelationTab",{});
	relTab[joueur] = TRP2_DefautToNil(relation,2);
	TRP2_SetInfo(personnage,"RelationTab",relTab);
end

function TRP2_ForceEtatGet(nom)
	TRP2_getConnectedUser();
	if TRP2_ConnectedUser[nom] then
		TRP2_EtatGetName = nom;
		TRP2_SecureSendAddonMessage("GTVN",TRP2_SendVernNum(),nom); -- Send VerNumTab avec request des VerNum adverses
		TRP2_SetInfo(nom,"AuraVerNum",0);
	end
end

---------------------------------------
-- MarySue Protocol support
---------------------------------------

function TRP2_MSP_OnInformationReceived(sender)
	if msptrp.char[sender].field['VA'] ~= "" and string.sub(msptrp.char[sender].field['VA'],1,8) ~= "TotalRP2" then

		-- Add to the register
		if not TRP2_EstDansLeReg(sender) then
			if TRP2_GetConfigValueFor("AutoNew",true) then
				TRP2_AjouterAuRegistre(sender, UnitName("target") == sender);
			else
				return;
			end
		end
		TRP2_debug("Saving MSP info");
		-- Variables
		if TRP2_Module_Registre[TRP2_Royaume][sender]["Registre"] ~= nil then
			wipe(TRP2_Module_Registre[TRP2_Royaume][sender]["Registre"]);
		else
			TRP2_Module_Registre[TRP2_Royaume][sender]["Registre"] = {};
		end
		if TRP2_Module_Registre[TRP2_Royaume][sender]["Physique"] ~= nil then
			wipe(TRP2_Module_Registre[TRP2_Royaume][sender]["Physique"]);
		else
			TRP2_Module_Registre[TRP2_Royaume][sender]["Physique"] = {};
		end
		if TRP2_Module_Registre[TRP2_Royaume][sender]["Histoire"] ~= nil then
			wipe(TRP2_Module_Registre[TRP2_Royaume][sender]["Histoire"]);
		else
			TRP2_Module_Registre[TRP2_Royaume][sender]["Histoire"] = {};
		end
		if TRP2_Module_Registre[TRP2_Royaume][sender]["Actu"] ~= nil then
			wipe(TRP2_Module_Registre[TRP2_Royaume][sender]["Actu"]);
		else
			TRP2_Module_Registre[TRP2_Royaume][sender]["Actu"] = {};
		end
		
		for field,value in pairs(msptrp.char[sender].field) do
			--TRP2_debug(tostring(sender).." sent : "..tostring(field).." : "..tostring(value));
			if field == "VA" then
				TRP2_Module_Registre[TRP2_Royaume][sender]["Client"] = TRP2_EmptyToNil(value);
			elseif field == "NA" then
				TRP2_Module_Registre[TRP2_Royaume][sender]["Registre"]["Nom"] = nil;
				TRP2_Module_Registre[TRP2_Royaume][sender]["Registre"]["Titre"] = nil;
				TRP2_Module_Registre[TRP2_Royaume][sender]["Registre"]["Prenom"] = TRP2_EmptyToNil(value);
			elseif field == "NT" then
				TRP2_Module_Registre[TRP2_Royaume][sender]["Registre"]["TitreComplet"] = TRP2_EmptyToNil(value);
			elseif field == "HH" then
				TRP2_Module_Registre[TRP2_Royaume][sender]["Registre"]["Habitation"] = TRP2_EmptyToNil(value);
			elseif field == "RA" then
				TRP2_Module_Registre[TRP2_Royaume][sender]["Registre"]["RacePerso"] = TRP2_EmptyToNil(value);
			elseif field == "AG" then
				TRP2_Module_Registre[TRP2_Royaume][sender]["Registre"]["Age"] = TRP2_EmptyToNil(value);
			elseif field == "AE" then
				TRP2_Module_Registre[TRP2_Royaume][sender]["Registre"]["YeuxVisage"] = TRP2_EmptyToNil(value);
			elseif field == "HB" then
				TRP2_Module_Registre[TRP2_Royaume][sender]["Registre"]["Origine"] = TRP2_EmptyToNil(value);
			elseif field == "DE" then
				TRP2_Module_Registre[TRP2_Royaume][sender]["Physique"]["PhysiqueTexte"] = TRP2_EmptyToNil(value);
			elseif field == "HI" then
				TRP2_Module_Registre[TRP2_Royaume][sender]["Histoire"]["HistoireTexte"] = TRP2_EmptyToNil(value);
			elseif field == "FC" then
				if value == "1" then
					TRP2_Module_Registre[TRP2_Royaume][sender]["Actu"]["StatutRP"] = 1;
				else
					TRP2_Module_Registre[TRP2_Royaume][sender]["Actu"]["StatutRP"] = 2;
				end
			elseif field == "FR" then
				if value == "4" then
					TRP2_Module_Registre[TRP2_Royaume][sender]["Actu"]["StatutXP"] = 1;
				end
			elseif field == "CU" then
				TRP2_Module_Registre[TRP2_Royaume][sender]["Actu"]["ActuTexte"] = TRP2_EmptyToNil(value);
			end
		end
		-- Refresh
		if sender == UnitName("mouseover") then
			TRP2_MouseOverTooltip("mouseover");
		end
		TRP2_RefreshRegistre(sender);
	else
		TRP2_debug("IT'S A TRP2 USER");
	end
end

function TRP2_MSP_Request(nom)
	--MSP requesting
	if not TRP2_EstIgnore(nom) and msptrp.char[ nom ].supported ~= false and string.sub(msptrp.char[nom].field['VA'],1,8) ~= "TotalRP2" then
		-- To do : AH
			local requested = msptrp:Request( nom, {"VA","NA","HH","NT","RA","FR","FC","AG","AE","HB","DE","HI","CU"} );
			TRP2_debug("Requested : "..nom);
		
	end
end

function TRP2_MSP_InitialLoad()

	if not (_G.msp_RPAddOn or _G.mrp) then
		_G.msp_RPAddOn = "Total RP 2";
	else
		-- ERROR PART
		local addonName = _G.msp_RPAddOn or "MyRolePlay";
		StaticPopupDialogs["TRP2_JUST_TEXT"].text = TRP2_CTS(TRP2_ENTETE..TRP2_FT(TRP2_LOC_MSPConcurrency,addonName));
		TRP2_ShowStaticPopup("TRP2_JUST_TEXT");
	end

	tinsert( msptrp.callback.received, TRP2_MSP_OnInformationReceived);
	msptrp.my['VA'] = "TotalRP2/"..TRP2_version;
	msptrp.myver = TRP2_GetInfo(TRP2_Joueur,"MSP_Vernum",{});
	TRP2_MSP_RegistreUpdate(TRP2_GetInfo(TRP2_Joueur,"Registre",{}),TRP2_GetIndexedTabSize(msptrp.myver) ~= 0);
	TRP2_MSP_ActuUpdate(TRP2_GetInfo(TRP2_Joueur,"Actu",{}),TRP2_GetIndexedTabSize(msptrp.myver) ~= 0);
	TRP2_MSP_DescriUpdate(TRP2_GetInfo(TRP2_Joueur,"Physique",{}),TRP2_GetIndexedTabSize(msptrp.myver) ~= 0);
end

function TRP2_MSP_HistoryUpdate(histoireTab,noUpdate)
	msptrp.my['HI'] = TRP2_DeleteColorCode(TRP2_GetWithDefaut(histoireTab,"HistoireTexte",""));
	msptrp.my['HI'] = TRP2_EraseTags(msptrp.my['HI']);
	TRP2_MSP_Update(noUpdate);
end

function TRP2_MSP_DescriUpdate(physiqueTab,noUpdate)
	msptrp.my['DE'] = TRP2_DeleteColorCode(TRP2_GetWithDefaut(physiqueTab,"PhysiqueTexte",""));
	msptrp.my['DE'] = TRP2_DeleteColorCode(TRP2_EraseTags(msptrp.my['DE']));
	TRP2_MSP_Update(noUpdate);
end

function TRP2_MSP_ActuUpdate(actuTab,noUpdate)
	-- RP status
	if TRP2_GetWithDefaut(actuTab,"StatutRP",2) == 1 then
		msptrp.my['FC'] = "1";
	else
		msptrp.my['FC'] = "2";
	end
	if TRP2_GetWithDefaut(actuTab,"StatutXP",2) == 1 then
		msptrp.my['FR'] = "4";
	end
	-- Currently
	msptrp.my['CU'] = TRP2_DeleteColorCode(TRP2_GetWithDefaut(actuTab,"ActuTexte",""));
	TRP2_MSP_Update(noUpdate);
end

function TRP2_MSP_RegistreUpdate(registreTab,noUpdate)
	-- Name
	msptrp.my['NA'] = TRP2_DeleteColorCode(TRP2_nomComplet(TRP2_Joueur));
	-- Title
	msptrp.my['NT'] = TRP2_DeleteColorCode(TRP2_GetWithDefaut(registreTab,"TitreComplet",""));
	-- Race
	msptrp.my['RA'] = TRP2_CTS(TRP2_GetWithDefaut(registreTab,"RacePerso",TRP2_locRace));
	-- Age
	msptrp.my['AG'] = TRP2_CTS(TRP2_GetWithDefaut(registreTab,"Age",""));
	-- Eyes color
	msptrp.my['AE'] = TRP2_CTS(TRP2_GetWithDefaut(registreTab,"YeuxVisage",""));
	-- Height
	msptrp.my['AH'] = TRP2_LOC_TAILLE_TEXTE[TRP2_GetWithDefaut(registreTab,"Taille",3)];
	-- Home
	msptrp.my['HH'] = TRP2_CTS(TRP2_GetWithDefaut(registreTab,"Habitation",""));
	-- Birthplace
	msptrp.my['HB'] = TRP2_CTS(TRP2_GetWithDefaut(registreTab,"Origine",""));
	TRP2_MSP_Update(noUpdate);
end

function TRP2_MSP_Update(noUpdate)
	if not noUpdate then
		TRP2_debug("TRP2_MSP_Update");
		msptrp:Update();
		TRP2_SetInfo(TRP2_Joueur,"MSP_Vernum",msptrp.myver);
	end
end
