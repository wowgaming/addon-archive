-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

----------------------------
-- UI
----------------------------

function TRP2_InitUICreation()
	TRP2_OutilBouton1Qte.defaut = 1;
	TRP2_OutilBouton2Qte.defaut = 1;
	TRP2_OutilBouton3Qte.defaut = 1;
	TRP2_OutilBouton4Qte.defaut = 1;
	TRP2_OutilBouton5Qte.defaut = 1;
	TRP2_OutilBouton1Qte.noZero = true;
	TRP2_OutilBouton2Qte.noZero = true;
	TRP2_OutilBouton3Qte.noZero = true;
	TRP2_OutilBouton4Qte.noZero = true;
	TRP2_OutilBouton5Qte.noZero = true;
	TRP2_ComposantBouton1Qte.defaut = 1;
	TRP2_ComposantBouton2Qte.defaut = 1;
	TRP2_ComposantBouton3Qte.defaut = 1;
	TRP2_ComposantBouton4Qte.defaut = 1;
	TRP2_ComposantBouton5Qte.defaut = 1;
	TRP2_ComposantBouton6Qte.defaut = 1;
	TRP2_ComposantBouton7Qte.defaut = 1;
	TRP2_ComposantBouton8Qte.defaut = 1;
	TRP2_ComposantBouton9Qte.defaut = 1;
	TRP2_ComposantBouton10Qte.defaut = 1;
	TRP2_ComposantBouton1Qte.noZero = true;
	TRP2_ComposantBouton2Qte.noZero = true;
	TRP2_ComposantBouton3Qte.noZero = true;
	TRP2_ComposantBouton4Qte.noZero = true;
	TRP2_ComposantBouton5Qte.noZero = true;
	TRP2_ComposantBouton6Qte.noZero = true;
	TRP2_ComposantBouton7Qte.noZero = true;
	TRP2_ComposantBouton8Qte.noZero = true;
	TRP2_ComposantBouton9Qte.noZero = true;
	TRP2_ComposantBouton10Qte.noZero = true;
	TRP2_CreationFrameObjetFrameGeneralUnique.defaut = 0;
	TRP2_CreationFrameObjetFrameGeneralPoids.defaut = 0;
	TRP2_CreationFrameObjetFrameGeneralLifetime.defaut = 0;
	TRP2_CreationFrameObjetFrameGeneralValeur.defaut = 0;
	TRP2_CreationFrameObjetFrameGeneralStack.defaut = 1;
	TRP2_CreationFrameObjetFrameGeneralStack.noZero = true;
	TRP2_CreationFrameObjetFrameUtilisationCharge.defaut = 0;
	TRP2_CreationFrameObjetFrameUtilisationCooldown.defaut = 0;
	TRP2_CreationFrameObjetFrameUtilisationDuree.defaut = 0;
	TRP2_CreationFrameObjetFrameUtilisationAnim.defaut = 0;
	TRP2_CreationFrameDocumentFrameImageLevel.defaut = 1;
	TRP2_CreationFrameDocumentFrameImageLevel.noZero = true;
	TRP2_CreationFrameDocumentFrameStringLevel.defaut = 1;
	TRP2_CreationFrameDocumentFrameStringLevel.noZero = true;
	TRP2_CreationFrameDocumentFrameImageDimX.defaut = 100;
	TRP2_CreationFrameDocumentFrameImageDimY.defaut = 100;
	TRP2_CreationFrameDocumentFrameImageDimX.noZero = true;
	TRP2_CreationFrameDocumentFrameImageDimY.noZero = true;
	TRP2_CreationFrameDocumentFrameImagePosX.defaut = 0;
	TRP2_CreationFrameDocumentFrameImagePosY.defaut = 0;
	TRP2_CreationFrameDocumentFrameStringDimX.defaut = 0;
	TRP2_CreationFrameDocumentFrameStringDimY.defaut = 0;
	TRP2_CreationFrameDocumentFrameStringPosX.defaut = 0;
	TRP2_CreationFrameDocumentFrameStringPosY.defaut = 0;
	TRP2_CreationFrameDocumentFrameImageRognerLeft.defaut = 0;
	TRP2_CreationFrameDocumentFrameImageRognerRight.defaut = 100;
	TRP2_CreationFrameDocumentFrameImageRognerUp.defaut = 0;
	TRP2_CreationFrameDocumentFrameImageRognerDown.defaut = 100;
	TRP2_CreationFrameDocumentFrameStringTaille.defaut = 12;
	TRP2_CreationFrameDocumentFrameStringTaille.noZero = true;
	TRP2_CreationFrameDocumentFrameStringSpacing.defaut = 0;
	TRP2_CreationFrameDocumentFrameStringShadowX.defaut = 1;
	TRP2_CreationFrameDocumentFrameStringShadowY.defaut = -1;
	TRP2_CreationFrameDocumentFrameImageColorStart:RegisterForClicks("LeftButtonUp","RightButtonUp");
	TRP2_CreationFrameDocumentFrameImageColorEnd:RegisterForClicks("LeftButtonUp","RightButtonUp");
	TRP2_CreationFrameDocumentFrameStringColor:RegisterForClicks("LeftButtonUp","RightButtonUp");
	TRP2_CreationFrameDocumentFrameStringShadowColor:RegisterForClicks("LeftButtonUp","RightButtonUp");
	TRP2_CreationFrameDataBaseCheck:SetChecked(TRP2_GetConfigValueFor("CheckDataBase",true));
	TRP2_ListeSmallCheckDatabase:SetChecked(TRP2_GetConfigValueFor("CheckDataBase",true));
	TRP2_CreationFrameDataBaseCheck:SetScript("OnClick",function(self)
		 TRP2_CreationPanel();
		 TRP2_SetConfigValueFor("CheckDataBase",self:GetChecked());
	end);
	TRP2_CreationFrameOthersCheck:SetChecked(TRP2_GetConfigValueFor("CheckOther"));
	TRP2_ListeSmallCheckOther:SetChecked(TRP2_GetConfigValueFor("CheckOther"));
	TRP2_CreationFrameOthersCheck:SetScript("OnClick",function(self)
		 TRP2_CreationPanel();
		 TRP2_SetConfigValueFor("CheckOther",self:GetChecked());
	end);
	TRP2_CreationFrameQuestFrameEtapeDescriptionApercu.apercu = true;
	TRP2_EffetTexteFrameTexteApercu.apercu = true;
	TRP2_EffetDialogFrameTexteApercu.apercu = true;

	TRP2_CreationFrameBaseListeLangage:Hide();
end

function TRP2_CreationPanel(panel,onglet,arg1,arg2,arg3,arg4)
	TRP2_CreationFrame:Show();
	TRP2_CreationFrameBase:Hide();
	TRP2_CreationFrameObjet:Hide();
	TRP2_CreationFrameAura:Hide();
	TRP2_CreationFrameQuest:Hide();
	TRP2_CreationFrameDocument:Hide();
	
	if not panel or panel == "Base" then
		TRP2_CreationFrameHeaderTitle:SetText(TRP2_LOC_CREATION);
		TRP2_CreationFrameBase:Show();
		TRP2_CreationFrameDataBaseCheckText:SetText(TRP2_CTS("{o}"..TRP2_LOC_DATABASECHECK));
		TRP2_ListerObjet();
		TRP2_ListerAura();
		TRP2_ListerEvent();
		TRP2_ListerDocument();
		TRP2_ListerPackages();
	elseif panel == "Objet" then
		TRP2_ChargerCreaObjetPanel(arg1,arg2,arg3,arg4);
	elseif panel == "Aura" then
		TRP2_ChargerCreaAuraPanel(arg1,arg2,arg3,arg4);
	elseif panel == "Quest" then
		TRP2_ChargerCreaQuestPanel(arg1,arg2,arg3,arg4);
	elseif panel == "Document" then
		TRP2_ChargerCreaDocumentPanel(arg1,arg2,arg3,arg4);
	end
end

------------------------
-- EXPORT
------------------------
TRP2_ExportTab = {};
function TRP2_Export()
	if TRP2_Module_ImpExport then
		wipe(TRP2_Module_ImpExport);
	else
		TRP2_Module_ImpExport = {};
	end
	for k,ID in pairs(TRP2_ExportTab) do
		local creaTab = TRP2_GetTabInfo(ID);
		if creaTab then
			TRP2_Module_ImpExport[ID] = {};
			TRP2_tcopy(TRP2_Module_ImpExport[ID],creaTab);
		end
	end
	TRP2_Module_ImpExport["Packeur"] = TRP2_Joueur;
	TRP2_Module_ImpExport["Date"] = date("%d/%m/%y, %H:%M:%S");
	TRP2_Module_Interface["bHasExport"] = true;
	
	ReloadUI();
end

function TRP2_UpdateExport()
	TRP2_ListeExportImportTitre:SetText(TRP2_CTS("{w}"..TRP2_LOC_PackCreation));
	TRP2_ListeExportImportSlider:Hide();
	TRP2_ListeExportImportSave:SetText("Exporter");
	TRP2_ListeExportImportSave:SetScript("OnClick",function()
		StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_EXPORTALERT);
		TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
			TRP2_Export();
		end);
	end);
	local j = TRP2_GetIndexedTabSize(TRP2_ExportTab);
	if j > 0 then
		TRP2_ListeExportImportEmpty:SetText("");
		if j == 1 then
			TRP2_ListeExportImportSousTitre:SetText(TRP2_CTS(TRP2_LOC_PackOneCrea));
		else
			TRP2_ListeExportImportSousTitre:SetText(TRP2_CTS(TRP2_FT(TRP2_LOC_PackMultiCrea,j)));
		end
	elseif j == 0 then
		TRP2_ListeExportImportEmpty:SetText(TRP2_LOC_PackEmpty);
		TRP2_ListeExportImportSousTitre:SetText("");
	end
	
	if j > 49 then
		TRP2_ListeExportImportSlider:Show();
		local total = floor((j-1)/49);
		TRP2_ListeExportImportSlider:SetMinMaxValues(0,total);
	end
	TRP2_ListeExportImportSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_UpdateExportPage(self:GetValue());
		end
	end)
	TRP2_ListeExportImportRecherche:Hide();
	TRP2_UpdateExportPage(0);
end

function TRP2_UpdateExportPage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_ListeExportImportSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	for k,ID in pairs(TRP2_ExportTab) do
		if i > num*49 and i <= (num+1)*49 then
			local creationTab = TRP2_GetTabInfo(ID);
			_G["TRP2_ListeExportImportSlot"..j]:Show();
			_G["TRP2_ListeExportImportSlot"..j.."Icon"]:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(creationTab,"Icone","Temp"));
			_G["TRP2_ListeExportImportSlot"..j]:SetScript("OnClick", function(self,button)
				tremove(TRP2_ExportTab,k);
				TRP2_UpdateExport();
			end);
			-- Calcul du tooltip
			local Titre,Message = TRP2_ExportImportTooltip(ID,creationTab);
			
			TRP2_SetTooltipForFrame(
				_G["TRP2_ListeExportImportSlot"..j],
				_G["TRP2_ListeExportImportSlot"..j],"TOPLEFT",0,0,
				Titre,
				Message.."\n{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_PackRemoveFrom
			);
			j = j + 1;
		end
		i = i + 1;
	end
end

function TRP2_ExportImportTooltip(ID,creationTab)
	local Titre,Message;
	Message = "{o}ID : {w}"..ID.."\n";
	if string.sub(ID,1,3) == "ITE" then
		Titre = "{w}{icone:"..TRP2_GetWithDefaut(creationTab,"Icone","Temp")..":30} "..TRP2_GetWithDefaut(creationTab,"Nom",UNKNOWN);
		Message = Message.."{o}"..TRP2_LOC_CreationType.." : {w}"..TRP2_LOC_CreationTypeObjet.."\n";
	elseif string.sub(ID,1,3) == "AUR" then
		Titre = "{w}{icone:"..TRP2_GetWithDefaut(creationTab,"Icone","Temp")..":30} "..TRP2_GetWithDefaut(creationTab,"Nom",UNKNOWN);
		Message = Message.."{o}"..TRP2_LOC_CreationType.." : {w}"..TRP2_LOC_CreationTypeEtat.."\n";
	elseif string.sub(ID,1,3) == "DOC" then
		Titre = "{w}{icone:"..TRP2_GetWithDefaut(creationTab,"Icone","Temp")..":30} "..TRP2_GetWithDefaut(creationTab,"Nom",UNKNOWN);
		Message = Message.."{o}"..TRP2_LOC_CreationType.." : {w}"..TRP2_LOC_CreationTypeDoc.."\n";
	elseif string.sub(ID,1,3) == "QUE" then
		Titre = "{w}{icone:"..TRP2_GetWithDefaut(creationTab,"Icone","Temp")..":30} "..TRP2_GetWithDefaut(creationTab,"Nom",UNKNOWN);
		Message = Message.."{o}"..TRP2_LOC_CreationType.." : {w}"..TRP2_LOC_CreationTypeQuest.."\n";
	elseif string.sub(ID,1,3) == "LAN" then
		Titre = "{w}{icone:"..TRP2_GetWithDefaut(creationTab,"Icone","Temp")..":30} "..TRP2_GetWithDefaut(creationTab,"Entete",UNKNOWN);
		Message = Message.."{o}"..TRP2_LOC_CreationType.." : {w}"..TRP2_LOC_CreationTypeLang.."\n";
	else
		return "Error";
	end
	Message = Message.."{o}"..TRP2_LOC_CREATOR.." : {w}"..TRP2_GetWithDefaut(creationTab,"Createur",UNKNOWN).."\n";
	Message = Message.."{o}"..TRP2_LOC_CREAVERNHELP.." : {w}"..TRP2_GetWithDefaut(creationTab,"VerNum",UNKNOWN).."\n";
	Message = Message.."{o}"..TRP2_LOC_LASTDATE.." : {w}"..TRP2_GetWithDefaut(creationTab,"Date",UNKNOWN).."\n";
	if creationTab == nil then
		Message = Message.."\n"..TRP2_LOC_PackageWarning1;
	end
	return Titre,Message;
end

function TRP2_ExportAdd(ID)
	if string.len(ID) ~= TRP2_IDSIZE then
		TRP2_Error(TRP2_LOC_ExporteError1);
		return;
	end
	TRP2_ListeExportImport:Show();
	if string.sub(ID,1,3) == "PAK" then
		local package = TRP2_GetPlayerPackages()[ID];
		for creaID,_ in pairs(package["Objects"]) do
			if not tContains(TRP2_ExportTab,creaID) then
				tinsert(TRP2_ExportTab,creaID);
			end
		end
		TRP2_UpdateExport();
	else
		if not tContains(TRP2_ExportTab,ID) then
			tinsert(TRP2_ExportTab,ID);
			TRP2_UpdateExport();
		else
			TRP2_Error(TRP2_LOC_ExporteError2);
		end
	end
end

------------------------
-- IMPORT
------------------------

function TRP2_ImportOne(ID,creaTab)
	if TRP2_GetWithDefaut(creaTab,"VerNum",0) > TRP2_GetWithDefaut(TRP2_GetTabInfo(ID),"VerNum",0) then
		if string.sub(ID,1,3) == "ITE" then
			if TRP2_Module_ObjetsPerso[ID] then
				wipe(TRP2_Module_ObjetsPerso[ID])
			else
				TRP2_Module_ObjetsPerso[ID] = {};
			end
			TRP2_tcopy(TRP2_Module_ObjetsPerso[ID],creaTab);
		elseif string.sub(ID,1,3) == "AUR" then
			if TRP2_Module_Auras[ID] then
				wipe(TRP2_Module_Auras[ID])
			else
				TRP2_Module_Auras[ID] = {};
			end
			TRP2_tcopy(TRP2_Module_Auras[ID],creaTab);
		elseif string.sub(ID,1,3) == "DOC" then
			if TRP2_Module_Documents[ID] then
				wipe(TRP2_Module_Documents[ID])
			else
				TRP2_Module_Documents[ID] = {};
			end
			TRP2_tcopy(TRP2_Module_Documents[ID],creaTab);
		elseif string.sub(ID,1,3) == "QUE" then
			if TRP2_Module_Quests[ID] then
				wipe(TRP2_Module_Quests[ID])
			else
				TRP2_Module_Quests[ID] = {};
			end
			TRP2_tcopy(TRP2_Module_Quests[ID],creaTab);
		elseif string.sub(ID,1,3) == "LAN" then
			if TRP2_Module_Language[ID] then
				wipe(TRP2_Module_Language[ID])
			else
				TRP2_Module_Language[ID] = {};
			end
			TRP2_tcopy(TRP2_Module_Language[ID],creaTab);
		end
		TRP2_Afficher(TRP2_FT(TRP2_LOC_ImportMess1,ID));
		return true;
	end
	return false;
end

TRP2_ImportTab = {};
function TRP2_Import()
	local count = 0;
	for ID,creaTab in pairs(TRP2_Module_ImpExport) do
		if TRP2_ImportOne(ID,creaTab) then
			count = count + 1;
		end
	end
	if TRP2_CreationFrameBase:IsVisible() then
		TRP2_CreationPanel();
	end
	StaticPopupDialogs["TRP2_JUST_TEXT"].text = TRP2_CTS(TRP2_ENTETE..TRP2_FT(TRP2_LOC_ImportMess2,count));
	TRP2_ShowStaticPopup("TRP2_JUST_TEXT");
	TRP2_ListeExportImport:Hide();
end

function TRP2_UpdateImport()
	wipe(TRP2_ExportTab);
	TRP2_ListeExportImportTitre:SetText(TRP2_CTS("{w}"..TRP2_LOC_ImportMess3));
	TRP2_ListeExportImportSlider:Hide();
	TRP2_ListeExportImport:Show();
	TRP2_ListeExportImportSave:SetText(TRP2_LOC_Import);
	TRP2_ListeExportImportSave:SetScript("OnClick",function()
		StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_IMPORTALERT);
		TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
			TRP2_Import();
		end);
	end);
	local j = TRP2_GetIndexedTabSize(TRP2_Module_ImpExport) - 2;
	if j > 0 then
		TRP2_ListeExportImportEmpty:SetText("");
		if j == 1 then
			TRP2_ListeExportImportSousTitre:SetText(TRP2_CTS(TRP2_LOC_PackOneCrea));
		else
			TRP2_ListeExportImportSousTitre:SetText(TRP2_CTS(TRP2_FT(TRP2_LOC_PackMultiCrea,j)));
		end
	elseif j == 0 then
		TRP2_ListeExportImportEmpty:SetText(TRP2_LOC_PackEmpty);
		TRP2_ListeExportImportSousTitre:SetText("");
	end
	
	if j > 49 then
		TRP2_ListeExportImportSlider:Show();
		local total = floor((j-1)/49);
		TRP2_ListeExportImportSlider:SetMinMaxValues(0,total);
	end
	TRP2_ListeExportImportSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_UpdateImportPage(self:GetValue());
		end
	end)
	TRP2_ListeExportImportRecherche:Hide();
	TRP2_UpdateImportPage(0);
end

function TRP2_UpdateImportPage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_ListeExportImportSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	for ID,creationTab in pairs(TRP2_Module_ImpExport) do
		if ID ~= "Packeur" and ID ~= "Date" and i > num*49 and i <= (num+1)*49 then
			_G["TRP2_ListeExportImportSlot"..j]:Show();
			_G["TRP2_ListeExportImportSlot"..j.."Icon"]:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(creationTab,"Icone","Temp"));
			_G["TRP2_ListeExportImportSlot"..j]:SetScript("OnClick", function(self,button)
				if TRP2_ImportOne(ID,creationTab) then
					TRP2_CreationPanel();
				else
					TRP2_Error(TRP2_LOC_ImportMess4);
				end
			end);
			-- Calcul du tooltip
			local Titre,Message = TRP2_ExportImportTooltip(ID,creationTab);
			
			TRP2_SetTooltipForFrame(
				_G["TRP2_ListeExportImportSlot"..j],
				_G["TRP2_ListeExportImportSlot"..j],"TOPLEFT",0,0,
				Titre,
				Message.."\n{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_ImportMess5
			);
			j = j + 1;
		end
		i = i + 1;
	end
end

----------------------------
-- LISTES
----------------------------

TRP2_CreaListTabIStates = {}
function TRP2_ListerImportStates()
	local i = 0; -- Nombre total
	local j = 0; -- Nombre pris
	local search = TRP2_EmptyToNil(TRP2_StateImportListRecherche:GetText());
	TRP2_StateImportListSlider:Hide();
	TRP2_StateImportListSlider:SetValue(0);
	wipe(TRP2_CreaListTabIStates);
	
	for ID,state in pairs(TRP2_Module_AurasTemp) do
		i = i+1;
		if not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(state,"Nom",""),search) or TRP2_ApplyPattern(TRP2_GetWithDefaut(state,"Createur",""),search) then
			j = j + 1;
			tinsert(TRP2_CreaListTabIStates,ID);
		end
	end

	table.sort(TRP2_CreaListTabIStates);

	if j > 0 then
		TRP2_StateImportListEmpty:SetText("");
	elseif i == 0 then
		TRP2_StateImportListEmpty:SetText(TRP2_LOC_UI_NoEtat);
	else
		TRP2_StateImportListEmpty:SetText(TRP2_LOC_SelectVide);
	end
	if j > 49 then
		TRP2_StateImportListSlider:Show();
		local total = floor((j-1)/49);
		TRP2_StateImportListSlider:SetMinMaxValues(0,total);
	end
	TRP2_StateImportListSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerImportStatesPage(self:GetValue());
		end
	end)
	TRP2_StateImportListRecherche:SetScript("OnTextChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerImportStates();
		end
	end)
	TRP2_ListerImportStatesPage(0);
end

function TRP2_ListerImportStatesPage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_StateImportListSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	
	for _,ID in pairs(TRP2_CreaListTabIStates) do
		if i > num*49 and i <= (num+1)*49 then
			local AuraTab = TRP2_Module_AurasTemp[ID];
			_G["TRP2_StateImportListSlot"..j]:Show();
			_G["TRP2_StateImportListSlot"..j.."Icon"]:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(AuraTab,"Icone","Temp"));
			_G["TRP2_StateImportListSlot"..j]:SetScript("OnClick", function(self,button)
				if button == "LeftButton" then
					StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_IMPORT_STATE,TRP2_GetWithDefaut(AuraTab,"Nom","")));
					TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
						if not TRP2_Module_Auras[ID] then
							TRP2_Module_Auras[ID] = {};
						else
							wipe(TRP2_Module_Auras[ID]);
						end
						TRP2_tcopy(TRP2_Module_Auras[ID],TRP2_Module_AurasTemp[ID]);
						wipe(TRP2_Module_AurasTemp[ID]);
						TRP2_Module_AurasTemp[ID] = nil;
						TRP2_Afficher();
						TRP2_ListerImportStates("{v}"..TRP2_LOC_IMPORTED_STATE);
						TRP2_ListerAura(0);
					end);
				elseif button == "RightButton" then
					StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_IMPORT_STATE_DEL,TRP2_GetWithDefaut(AuraTab,"Nom","")));
					TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
						wipe(TRP2_Module_AurasTemp[ID]);
						TRP2_Module_AurasTemp[ID] = nil;
						TRP2_ListerImportStates();
					end);
				end
			end);
			
			-- Calcul du tooltip
			local Message="ID n° "..ID;
			Message = Message.."\n{v}< "..TRP2_LOC_CREATOR.." : {o}"..TRP2_GetWithDefaut(AuraTab,"Createur",UNKNOWN).."{v} >";
			Message = Message.."\n{v}< "..GAME_VERSION_LABEL.." : {o}"..TRP2_GetWithDefaut(AuraTab,"VerNum",1).."{v} >";
			Message = Message.."\n{v}< "..TRP2_LOC_LASTDATE.." : {o}"..TRP2_GetWithDefaut(AuraTab,"Date",date("%d/%m/%y à %H:%M:%S")).."{v} >";
			if TRP2_GetWithDefaut(AuraTab,"bWriteLock",true) then
				Message = Message.."\n{o}< "..TRP2_LOC_WRITELOCK.." >";
			end

			Message = Message.."\n\n{w}"..TRP2_LOC_Description.." :\n{o}\""..TRP2_GetWithDefaut(AuraTab,"Description","").."\"";
			
			Message = Message.."\n\n{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_IMPORTSTATE;
			Message = Message.."\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_DELETEINFO;
			TRP2_SetTooltipForFrame(
				getglobal("TRP2_StateImportListSlot"..j),
				getglobal("TRP2_StateImportListSlot"..j),"TOPLEFT",0,0,
				"{w}|TInterface\\ICONS\\"..TRP2_GetWithDefaut(AuraTab,"Icone","Temp")..":30:30|t "..TRP2_GetWithDefaut(AuraTab,"Nom",""),
				Message
			);
			j = j + 1;
		end
		i = i + 1;
	end
end

function TRP2_ListerObjet()
	local i = 0; -- Nombre total
	local j = 0; -- Nombre pris
	local search = TRP2_EmptyToNil(TRP2_CreationFrameBaseListeObjetRecherche:GetText());
	TRP2_CreationFrameBaseListeObjetSlider:Hide();
	TRP2_CreationFrameBaseListeObjetSlider:SetValue(0);
	wipe(TRP2_CreaListTabObjet);
	
	table.foreach(TRP2_Module_ObjetsPerso,function(ID)
		i = i+1;
		if not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_ObjetsPerso[ID],"Nom",""),search)
			or 	TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_ObjetsPerso[ID],"Categorie",""),search) 
			or 	TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_ObjetsPerso[ID],"Createur",""),search) 
			then
			if TRP2_GetWithDefaut(TRP2_Module_ObjetsPerso[ID],"Createur") == TRP2_Joueur or TRP2_CreationFrameOthersCheck:GetChecked() then
				j = j + 1;
				TRP2_CreaListTabObjet[j] = ID;
			end
		end
	end);
	if TRP2_CreationFrameDataBaseCheck:GetChecked() and TRP2_DB_Objects then
		table.foreach(TRP2_DB_Objects,function(ID)
			i = i+1;
			if not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_DB_Objects[ID],"Nom",""),search) 
				or 	TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_DB_Objects[ID],"Categorie",""),search) then
				j = j + 1;
				TRP2_CreaListTabObjet[j] = ID;
			end
		end);
	end
	
	table.sort(TRP2_CreaListTabObjet);

	if j > 0 then
		TRP2_CreationFrameBaseListeObjetEmpty:SetText("");
	elseif i == 0 then
		TRP2_CreationFrameBaseListeObjetEmpty:SetText(TRP2_LOC_UI_NoObjet);
	else
		TRP2_CreationFrameBaseListeObjetEmpty:SetText(TRP2_LOC_SelectVide);
	end
	if j > 49 then
		TRP2_CreationFrameBaseListeObjetSlider:Show();
		local total = floor((j-1)/49);
		TRP2_CreationFrameBaseListeObjetSlider:SetMinMaxValues(0,total);
	end
	TRP2_CreationFrameBaseListeObjetSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerObjetPage(self:GetValue());
		end
	end)
	TRP2_CreationFrameBaseListeObjetRecherche:SetScript("OnTextChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerObjet();
		end
	end)
	TRP2_ListerObjetPage(0);
end

function TRP2_ListerAura(num)
	local i = 0; -- Nombre total
	local j = 0; -- Nombre pris
	local search = TRP2_EmptyToNil(TRP2_CreationFrameBaseListeAuraRecherche:GetText());
	TRP2_CreationFrameBaseListeAuraSlider:Hide();
	if num then
		TRP2_CreationFrameBaseListeAuraSlider:SetValue(num);
	else
		TRP2_CreationFrameBaseListeAuraSlider:SetValue(0);
	end
	wipe(TRP2_CreaListTabAura);
	
	table.foreach(TRP2_Module_Auras,function(ID)
		i = i+1;
		if not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_Auras[ID],"Nom",""),search) 
		or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_Auras[ID],"Createur",""),search) then
			if TRP2_GetWithDefaut(TRP2_Module_Auras[ID],"Createur") == TRP2_Joueur or TRP2_CreationFrameOthersCheck:GetChecked() then
				j = j + 1;
				TRP2_CreaListTabAura[j] = ID;
			end
		end
	end);
	if TRP2_CreationFrameDataBaseCheck:GetChecked() and TRP2_DB_Auras then
		table.foreach(TRP2_DB_Auras,function(ID)
			i = i+1;
			if not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_DB_Auras[ID],"Nom",""),search) then
				j = j + 1;
				TRP2_CreaListTabAura[j] = ID;
			end
		end);
	end
	
	table.sort(TRP2_CreaListTabAura);

	if j > 0 then
		TRP2_CreationFrameBaseListeAuraEmpty:SetText("");
	elseif i == 0 then
		TRP2_CreationFrameBaseListeAuraEmpty:SetText(TRP2_LOC_UI_NoEtat);
	else
		TRP2_CreationFrameBaseListeAuraEmpty:SetText(TRP2_LOC_SelectVide);
	end
	if j > 49 then
		TRP2_CreationFrameBaseListeAuraSlider:Show();
		local total = floor((j-1)/49);
		TRP2_CreationFrameBaseListeAuraSlider:SetMinMaxValues(0,total);
	end
	TRP2_CreationFrameBaseListeAuraSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerAuraPage(self:GetValue());
		end
	end)
	TRP2_CreationFrameBaseListeAuraRecherche:SetScript("OnTextChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerAura();
		end
	end)
	if num then
		TRP2_ListerAuraPage(num);
	else
		TRP2_ListerAuraPage(0);
	end
end

function TRP2_ListerEvent()
	local i = 0; -- Nombre total
	local j = 0; -- Nombre pris
	local search = TRP2_EmptyToNil(TRP2_CreationFrameBaseListeEventRecherche:GetText());
	TRP2_CreationFrameBaseListeEventSlider:Hide();
	TRP2_CreationFrameBaseListeEventSlider:SetValue(0);
	wipe(TRP2_CreaListTabEvent);
	
	table.foreach(TRP2_Module_Quests,function(ID)
		i = i+1;
		if not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_Quests[ID],"Nom",""),search) 
		or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_Quests[ID],"Createur",""),search) then
			if TRP2_GetWithDefaut(TRP2_Module_Quests[ID],"Createur") == TRP2_Joueur or TRP2_CreationFrameOthersCheck:GetChecked() then
				j = j + 1;
				TRP2_CreaListTabEvent[j] = ID;
			end
		end
	end);
	if TRP2_CreationFrameDataBaseCheck:GetChecked() and TRP2_DB_Quests then
		table.foreach(TRP2_DB_Quests,function(ID)
			i = i+1;
			if not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_DB_Quests[ID],"Nom",""),search) then
				j = j + 1;
				TRP2_CreaListTabEvent[j] = ID;
			end
		end);
	end
	
	table.sort(TRP2_CreaListTabEvent);

	if j > 0 then
		TRP2_CreationFrameBaseListeEventEmpty:SetText("");
	elseif i == 0 then
		TRP2_CreationFrameBaseListeEventEmpty:SetText(TRP2_LOC_NoQuest);
	else
		TRP2_CreationFrameBaseListeEventEmpty:SetText(TRP2_LOC_SelectVide);
	end
	if j > 49 then
		TRP2_CreationFrameBaseListeEventSlider:Show();
		local total = floor((j-1)/49);
		TRP2_CreationFrameBaseListeEventSlider:SetMinMaxValues(0,total);
	end
	TRP2_CreationFrameBaseListeEventSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerEventPage(self:GetValue());
		end
	end)
	TRP2_CreationFrameBaseListeEventRecherche:SetScript("OnTextChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerEvent();
		end
	end)
	TRP2_ListerEventPage(0);
end

function TRP2_ListerDocument()
	local i = 0; -- Nombre total
	local j = 0; -- Nombre pris
	local search = TRP2_EmptyToNil(TRP2_CreationFrameBaseListeDocumentRecherche:GetText());
	TRP2_CreationFrameBaseListeDocumentSlider:Hide();
	TRP2_CreationFrameBaseListeDocumentSlider:SetValue(0);
	wipe(TRP2_CreaListTabDocument);
	
	table.foreach(TRP2_Module_Documents,function(ID)
		i = i+1;
		if not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_Documents[ID],"Nom",""),search)
			or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_Documents[ID],"Createur",""),search) then
			if TRP2_GetWithDefaut(TRP2_Module_Documents[ID],"Createur") == TRP2_Joueur or TRP2_CreationFrameOthersCheck:GetChecked() then
				j = j + 1;
				TRP2_CreaListTabDocument[j] = ID;
			end
		end
	end);
	if TRP2_CreationFrameDataBaseCheck:GetChecked() and TRP2_DB_Documents then
		table.foreach(TRP2_DB_Documents,function(ID)
			i = i+1;
			if not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_DB_Documents[ID],"Nom",""),search) then
				j = j + 1;
				TRP2_CreaListTabDocument[j] = ID;
			end
		end);
	end
	
	table.sort(TRP2_CreaListTabDocument);

	if j > 0 then
		TRP2_CreationFrameBaseListeDocumentEmpty:SetText("");
	elseif i == 0 then
		TRP2_CreationFrameBaseListeDocumentEmpty:SetText(TRP2_LOC_NoDoc);
	else
		TRP2_CreationFrameBaseListeDocumentEmpty:SetText(TRP2_LOC_SelectVide);
	end
	if j > 49 then
		TRP2_CreationFrameBaseListeDocumentSlider:Show();
		local total = floor((j-1)/49);
		TRP2_CreationFrameBaseListeDocumentSlider:SetMinMaxValues(0,total);
	end
	TRP2_CreationFrameBaseListeDocumentSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerDocumentPage(self:GetValue());
		end
	end)
	TRP2_CreationFrameBaseListeDocumentRecherche:SetScript("OnTextChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerDocument();
		end
	end)
	TRP2_ListerDocumentPage(0);
end

function TRP2_ListerDocumentPage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_CreationFrameBaseListeDocumentSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	table.foreach(TRP2_CreaListTabDocument,
	function(TabIndex)
		if i > num*49 and i <= (num+1)*49 then
			local ID = TRP2_CreaListTabDocument[TabIndex];
			local DocumentTab = TRP2_GetDocumentInfo(ID);
			getglobal("TRP2_CreationFrameBaseListeDocumentSlot"..j):Show();
			getglobal("TRP2_CreationFrameBaseListeDocumentSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(DocumentTab,"Icone","Temp"));
			_G["TRP2_CreationFrameBaseListeDocumentSlot"..j]:SetScript("OnDragStart", function()
				SetCursor("Interface\\ICONS\\"..TRP2_GetWithDefaut(DocumentTab,"Icone","Temp"));
			end);
			_G["TRP2_CreationFrameBaseListeDocumentSlot"..j]:SetScript("OnDragStop", function()
				if MouseIsOver(TRP2_OpenedPackage) and TRP2_OpenedPackage:IsVisible() then
					TRP2_AddObjectToPackage(ID);
				end
			end);
			getglobal("TRP2_CreationFrameBaseListeDocumentSlot"..j):SetScript("OnClick", function(self,button)
				if button == "LeftButton" then
					if IsAltKeyDown() then
						StaticPopupDialogs["TRP2_GET_TEXT_NS"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_SHOWID);
						TRP2_ShowStaticPopup("TRP2_GET_TEXT_NS",nil,nil,nil,nil,nil,nil,ID);
						return;
					end
					if IsControlKeyDown() and string.len(ID) == TRP2_IDSIZE then
						if UnitName("target") and UnitName("target") ~= TRP2_Joueur and UnitIsPlayer("target") and UnitFactionGroup("target") == UnitFactionGroup("player") then
							TRP2_GetCreaInfo(UnitName("target"),ID,TRP2_GetWithDefaut(DocumentTab,"VerNum",1));
						else
							StaticPopupDialogs["TRP2_GET_TEXT_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_SendInfoTT,TRP2_GetWithDefaut(DocumentTab,"Nom",UNKNOWN)));
							TRP2_ShowStaticPopup("TRP2_GET_TEXT_NS",nil,TRP2_GetCreaInfo,ID,TRP2_GetWithDefaut(DocumentTab,"VerNum",1));
						end
					elseif TRP2_CanRead(DocumentTab) then
						TRP2_CreationPanel("Document",nil,ID);
					else
						TRP2_Error(TRP2_LOC_VerrError);
					end
				elseif button == "RightButton" then
					if IsControlKeyDown() then
						TRP2_CalculerDependance(DocumentTab,ID);
					elseif IsShiftKeyDown() then
						TRP2_ExportAdd(ID);
					elseif string.len(ID) == TRP2_IDSIZE then
						StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_DEL_REF_OBJ,TRP2_GetWithDefaut(DocumentTab,"Nom",TRP2_LOC_NEWDOCU)));
						TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
							wipe(TRP2_Module_Documents[ID]);
							TRP2_Module_Documents[ID] = nil;
							TRP2_ListerDocument();
						end);
					end
				end
			end);
			-- Calcul du tooltip
			local Message="ID n° "..ID;
			if string.len(ID) == 8 then
				Message = Message.."\n{v}< Total RP 2 : DataBase >";
			else
				Message = Message.."\n{v}< "..TRP2_LOC_CREATOR.." : {o}"..TRP2_GetWithDefaut(DocumentTab,"Createur",UNKNOWN).."{v} >";
				Message = Message.."\n{v}< "..GAME_VERSION_LABEL.." : {o}"..TRP2_GetWithDefaut(DocumentTab,"VerNum",1).."{v} >";
				Message = Message.."\n{v}< "..TRP2_LOC_LASTDATE.." : {o}"..TRP2_GetWithDefaut(DocumentTab,"Date",date("%d/%m/%y à %H:%M:%S")).."{v} >";
			end
			if TRP2_GetWithDefaut(DocumentTab,"bWriteLock",true) or string.len(ID) == 5 then
				Message = Message.."\n{o}< "..TRP2_LOC_WRITELOCK.." >";
			end
			Message = Message.."\n";
			Message = Message.."\n{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_SEEINFOEDIT;
			if string.len(ID) == TRP2_IDSIZE then
				Message = Message.."\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_DELETEINFO;
				Message = Message.."\n{j}"..TRP2_LOC_CLICCTRL.." {w}: "..TRP2_LOC_SendInfo;
			end
			Message = Message.."\n{j}"..TRP2_LOC_CLICDROITCTRL.." {w}: "..TRP2_LOC_AFFICHERSTAT;
			if string.len(ID) == TRP2_IDSIZE then
				Message = Message.."\n{j}"..TRP2_LOC_CLICDROITMAJ.." {w}: "..TRP2_LOC_EXPORT;
			end
			Message = Message.."\n{j}"..TRP2_LOC_CLICALT.." {w}: "..TRP2_LOC_SHOWIDTT;
			TRP2_SetTooltipForFrame(
				getglobal("TRP2_CreationFrameBaseListeDocumentSlot"..j),
				TRP2_CreationFrameBase,"TOPLEFT",262,-515,
				"{w}{icone:"..TRP2_GetWithDefaut(DocumentTab,"Icone","Temp")..":30} "..TRP2_GetWithDefaut(DocumentTab,"Nom",TRP2_LOC_NEWDOCU),
				Message
			);
			j = j + 1;
		end
		i = i + 1;
	end);
end

function TRP2_ListerEventPage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_CreationFrameBaseListeEventSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	table.foreach(TRP2_CreaListTabEvent,
	function(TabIndex)
		if i > num*49 and i <= (num+1)*49 then
			local ID = TRP2_CreaListTabEvent[TabIndex];
			local EventTab = TRP2_GetQuestsInfo(ID);
			getglobal("TRP2_CreationFrameBaseListeEventSlot"..j):Show();
			getglobal("TRP2_CreationFrameBaseListeEventSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(EventTab,"Icone","Temp.blp"));
			_G["TRP2_CreationFrameBaseListeEventSlot"..j]:SetScript("OnDragStart", function()
				SetCursor("Interface\\ICONS\\"..TRP2_GetWithDefaut(EventTab,"Icone","Temp"));
			end);
			_G["TRP2_CreationFrameBaseListeEventSlot"..j]:SetScript("OnDragStop", function()
				if MouseIsOver(TRP2_OpenedPackage) and TRP2_OpenedPackage:IsVisible() then
					TRP2_AddObjectToPackage(ID);
				end
			end);
			getglobal("TRP2_CreationFrameBaseListeEventSlot"..j):SetScript("OnClick", function(self,button)
				if button == "LeftButton" then
					if IsAltKeyDown() then
						StaticPopupDialogs["TRP2_GET_TEXT_NS"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_SHOWID);
						TRP2_ShowStaticPopup("TRP2_GET_TEXT_NS",nil,nil,nil,nil,nil,nil,ID);
						return;
					end
					if IsControlKeyDown() and string.len(ID) == TRP2_IDSIZE then
						if UnitName("target") and UnitName("target") ~= TRP2_Joueur and UnitIsPlayer("target") and UnitFactionGroup("target") == UnitFactionGroup("player") then
							TRP2_GetCreaInfo(UnitName("target"),ID,TRP2_GetWithDefaut(EventTab,"VerNum",1));
						else
							StaticPopupDialogs["TRP2_GET_TEXT_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_SendInfoTT,TRP2_GetWithDefaut(EventTab,"Nom",UNKNOWN)));
							TRP2_ShowStaticPopup("TRP2_GET_TEXT_NS",nil,TRP2_GetCreaInfo,ID,TRP2_GetWithDefaut(EventTab,"VerNum",1));
						end
					elseif TRP2_CanRead(EventTab) then
						TRP2_CreationPanel("Quest",nil,ID);
					else
						TRP2_Error(TRP2_LOC_VerrError);
					end
				elseif button == "RightButton" then
					if IsControlKeyDown() then
						TRP2_CalculerDependance(EventTab,ID);
					elseif IsShiftKeyDown() then
						TRP2_ExportAdd(ID);
					elseif string.len(ID) == TRP2_IDSIZE then
						StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_DEL_REF_OBJ,TRP2_GetWithDefaut(EventTab,"Nom","Temp.blp")));
						TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
							wipe(TRP2_Module_Quests[ID]);
							TRP2_Module_Quests[ID] = nil;
							TRP2_ListerEvent();
						end);
					end
				end
			end);
			
			-- Calcul du tooltip
			local Message="ID n° "..ID;
			if string.len(ID) == 8 then
				Message = Message.."\n{v}< Total RP 2 : DataBase >";
			else
				Message = Message.."\n{v}< "..TRP2_LOC_CREATOR.." : {o}"..TRP2_GetWithDefaut(EventTab,"Createur",UNKNOWN).."{v} >";
				Message = Message.."\n{v}< "..GAME_VERSION_LABEL.." : {o}"..TRP2_GetWithDefaut(EventTab,"VerNum",1).."{v} >";
				Message = Message.."\n{v}< "..TRP2_LOC_LASTDATE.." : {o}"..TRP2_GetWithDefaut(EventTab,"Date",date("%d/%m/%y à %H:%M:%S")).."{v} >";
			end
			if TRP2_GetWithDefaut(EventTab,"bWriteLock",true) or string.len(ID) == 5 then
				Message = Message.."\n{o}< "..TRP2_LOC_WRITELOCK.." >";
			end
			Message = Message.."\n";
			Message = Message.."\n{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_SEEINFOEDIT;
			if string.len(ID) == TRP2_IDSIZE then
				Message = Message.."\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_DELETEINFO;
				Message = Message.."\n{j}"..TRP2_LOC_CLICCTRL.." {w}: "..TRP2_LOC_SendInfo;
			end
			Message = Message.."\n{j}"..TRP2_LOC_CLICDROITCTRL.." {w}: "..TRP2_LOC_AFFICHERSTAT;
			if string.len(ID) == TRP2_IDSIZE then
				Message = Message.."\n{j}"..TRP2_LOC_CLICDROITMAJ.." {w}: "..TRP2_LOC_EXPORT;
			end
			Message = Message.."\n{j}"..TRP2_LOC_CLICALT.." {w}: "..TRP2_LOC_SHOWIDTT;
			TRP2_SetTooltipForFrame(
				getglobal("TRP2_CreationFrameBaseListeEventSlot"..j),
				TRP2_CreationFrameBase,"TOPLEFT",262,-515,
				"{w}|TInterface\\ICONS\\"..TRP2_GetWithDefaut(EventTab,"Icone","Temp.blp")..":30:30|t "..TRP2_GetWithDefaut(EventTab,"Nom",""),
				Message
			);
			j = j + 1;
		end
		i = i + 1;
	end);
end

function TRP2_ListerObjetPage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_CreationFrameBaseListeObjetSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	table.foreach(TRP2_CreaListTabObjet,
	function(TabIndex)
		if i > num*49 and i <= (num+1)*49 then
			local ID = TRP2_CreaListTabObjet[TabIndex];
			local ObjetTab = TRP2_GetObjectTab(ID);
			getglobal("TRP2_CreationFrameBaseListeObjetSlot"..j):Show();
			getglobal("TRP2_CreationFrameBaseListeObjetSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(ObjetTab,"Icone","Temp.blp"));
			getglobal("TRP2_CreationFrameBaseListeObjetSlot"..j):SetScript("OnClick", function(self,button)
				if button == "LeftButton" then
					if IsAltKeyDown() then
						StaticPopupDialogs["TRP2_GET_TEXT_NS"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_SHOWID);
						TRP2_ShowStaticPopup("TRP2_GET_TEXT_NS",nil,nil,nil,nil,nil,nil,ID);
						return;
					end
					if IsShiftKeyDown() then
						if (TRP2_GetWithDefaut(ObjetTab,"bManual",1) or TRP2_GetWithDefaut(ObjetTab,"Createur","nil") == TRP2_Joueur) then
							StaticPopupDialogs["TRP2_ADD_OBJET_AMOUNT"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_ADD_OBJ,TRP2_GetNameWithQuality(ObjetTab)));
							TRP2_ShowStaticPopup("TRP2_ADD_OBJET_AMOUNT",nil,ID);
						else
							TRP2_Error(TRP2_LOC_NOMANUALAJOUT);
						end
					elseif IsControlKeyDown() and string.len(ID) == TRP2_IDSIZE then
						if UnitName("target") and UnitName("target") ~= TRP2_Joueur and UnitIsPlayer("target") and UnitFactionGroup("target") == UnitFactionGroup("player") then
							TRP2_GetCreaInfo(UnitName("target"),ID,TRP2_GetWithDefaut(ObjetTab,"VerNum",1));
						else
							StaticPopupDialogs["TRP2_GET_TEXT_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_SendInfoTT,TRP2_GetWithDefaut(ObjetTab,"Nom",UNKNOWN)));
							TRP2_ShowStaticPopup("TRP2_GET_TEXT_NS",nil,TRP2_GetCreaInfo,ID,TRP2_GetWithDefaut(ObjetTab,"VerNum",1));
						end
					else
						if not TRP2_CanRead(ObjetTab) then
							TRP2_Error(TRP2_LOC_VerrError);
						else
							TRP2_CreationPanel("Objet",nil,ID);
						end
					end
				elseif button == "RightButton" then
					if IsControlKeyDown() then
						TRP2_CalculerDependance(ObjetTab,ID);
					elseif IsShiftKeyDown() then
						TRP2_ExportAdd(ID);
					elseif string.len(ID) == TRP2_IDSIZE then
						StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_DEL_REF_OBJ,TRP2_GetNameWithQuality(ObjetTab)));
						TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
							wipe(TRP2_Module_ObjetsPerso[ID]);
							TRP2_Module_ObjetsPerso[ID] = nil;
							TRP2_ListerObjet();
						end);
					end
				end
			end);
			getglobal("TRP2_CreationFrameBaseListeObjetSlot"..j):SetScript("OnDragStart", function()
				SetCursor("Interface\\ICONS\\"..TRP2_GetWithDefaut(ObjetTab,"Icone","Temp"));
			end);
			getglobal("TRP2_CreationFrameBaseListeObjetSlot"..j):SetScript("OnDragStop", function()
				if MouseIsOver(TRP2_OpenedPackage) and TRP2_OpenedPackage:IsVisible() then
					TRP2_AddObjectToPackage(ID);
				elseif TRP2_GetWithDefaut(ObjetTab,"bManual",1) or TRP2_GetWithDefaut(ObjetTab,"Createur") == TRP2_Joueur then
					ResetCursor();
					local focus = "";
					if GetMouseFocus() then
						focus = GetMouseFocus():GetName();
					end
					if MouseIsOver(TRP2InventaireFrameSac) and TRP2InventaireFrameSac:IsVisible() then
						local ok = false;
						if string.find(focus,"TRP2SacFrameSlot") then
							local SlotID = string.sub(focus,string.len("TRP2SacFrameSlot")+1);
							if SlotID and not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][SlotID] then
								TRP2_InvAddObjet(ID,"Sac",nil,1,nil,nil,true,nil,SlotID);
								ok = true;
							end
						end
						if not ok then
							TRP2_InvAddObjet(ID,"Sac",nil,1);
						end
					elseif MouseIsOver(TRP2InventaireFrameCoffre) and TRP2InventaireFrameCoffre:IsVisible() then
						local ok = false;
						if string.find(focus,"TRP2CoffreFrameSlot") then
							local SlotID = string.sub(focus,string.len("TRP2CoffreFrameSlot")+1);
							if SlotID and not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Slot"][SlotID] then
								TRP2_InvAddObjet(ID,"Coffre",nil,1,nil,nil,true,nil,SlotID);
								ok = true;
							end
						end
						if not ok then
							TRP2_InvAddObjet(ID,"Coffre",nil,1);
						end
					elseif MouseIsOver(TRP2InventaireFramePlanque) and TRP2InventaireFramePlanque:IsVisible() and TRP2InventaireFramePlanque.planqueNom == TRP2_Joueur then
						TRP2_debug("là");
						if string.find(focus,"TRP2PlanqueFrameSlot") then
							TRP2_debug("ici");
							local SlotID = string.sub(focus,string.len("TRP2PlanqueFrameSlot")+1);
							local planqueID = TRP2_GetPlanqueID(true);
							if SlotID and not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][planqueID]["Slot"][SlotID] then
								TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][planqueID]["Slot"][SlotID] = {};
								TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][planqueID]["Slot"][SlotID]["ID"] = ID;
								TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][planqueID]["Slot"][SlotID]["Qte"] = 1;
							end
						end
					end
				else
					TRP2_Error(TRP2_LOC_NOMANUALAJOUT);
				end
			end);
			
			-- Calcul du tooltip
			local Message="ID n° "..ID;
			if string.len(ID) == 8 then
				Message = Message.."\n{v}< Total RP 2 : DataBase >";
			else
				Message = Message.."\n{v}< "..TRP2_LOC_CREATOR.." : {o}"..TRP2_GetWithDefaut(ObjetTab,"Createur",UNKNOWN).."{v} >";
				Message = Message.."\n{v}< "..GAME_VERSION_LABEL.." : {o}"..TRP2_GetWithDefaut(ObjetTab,"VerNum",1).."{v} >";
				Message = Message.."\n{v}< "..TRP2_LOC_LASTDATE.." : {o}"..TRP2_GetWithDefaut(ObjetTab,"Date",date("%d/%m/%y à %H:%M:%S")).."{v} >";
			end
			if TRP2_GetWithDefaut(ObjetTab,"bWriteLock",true) or string.len(ID) == 5 then
				Message = Message.."\n{o}< "..TRP2_LOC_WRITELOCK.." >";
			end
			if TRP2_GetWithDefaut(ObjetTab,"bManual", 1) then
				Message = Message.."\n{w}"..TRP2_LOC_MANUALTEXT;
			end
			Message = Message.."\n";
			Message = Message.."\n{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_SEEINFOEDIT;
			if string.len(ID) == TRP2_IDSIZE then
				Message = Message.."\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_DELETEINFO;
				Message = Message.."\n{j}"..TRP2_LOC_CLICCTRL.." {w}: "..TRP2_LOC_SendInfo;
			end
			Message = Message.."\n{j}"..TRP2_LOC_CLICDROITCTRL.." {w}: "..TRP2_LOC_AFFICHERSTAT;
			if TRP2_GetWithDefaut(ObjetTab,"bManual", 1) or TRP2_GetWithDefaut(ObjetTab,"Createur","nil") == TRP2_Joueur then
				Message = Message.."\n{j}"..TRP2_LOC_CLICMAJ.." {w}: "..TRP2_LOC_Objet_Add;
			end
			if string.len(ID) == TRP2_IDSIZE then
				Message = Message.."\n{j}"..TRP2_LOC_CLICDROITMAJ.." {w}: "..TRP2_LOC_EXPORT;
			end
			Message = Message.."\n{j}"..TRP2_LOC_CLICALT.." {w}: "..TRP2_LOC_SHOWIDTT;
			TRP2_SetTooltipForFrame(
				getglobal("TRP2_CreationFrameBaseListeObjetSlot"..j),
				TRP2_CreationFrameBase,"TOPLEFT",262,-515,
				"{w}|TInterface\\ICONS\\"..TRP2_GetWithDefaut(ObjetTab,"Icone","Temp.blp")..":30:30|t "..TRP2_GetNameWithQuality(ObjetTab),
				Message
			);
			j = j + 1;
		end
		i = i + 1;
	end);
end

function TRP2_ListerAuraPage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_CreationFrameBaseListeAuraSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	table.foreach(TRP2_CreaListTabAura,
	function(TabIndex)
		if i > num*49 and i <= (num+1)*49 then
			local ID = TRP2_CreaListTabAura[TabIndex];
			local AuraTab = TRP2_GetAuraInfo(ID);
			_G["TRP2_CreationFrameBaseListeAuraSlot"..j]:Show();
			_G["TRP2_CreationFrameBaseListeAuraSlot"..j.."Icon"]:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(AuraTab,"Icone","Temp"));
			if TRP2_Module_Interface["BannedID"][ID] then
				_G["TRP2_CreationFrameBaseListeAuraSlot"..j.."Icon"]:SetDesaturated(true);
			else
				_G["TRP2_CreationFrameBaseListeAuraSlot"..j.."Icon"]:SetDesaturated(false);
			end
			_G["TRP2_CreationFrameBaseListeAuraSlot"..j]:SetScript("OnDragStart", function()
				SetCursor("Interface\\ICONS\\"..TRP2_GetWithDefaut(AuraTab,"Icone","Temp"));
			end);
			_G["TRP2_CreationFrameBaseListeAuraSlot"..j]:SetScript("OnDragStop", function()
				if MouseIsOver(TRP2_OpenedPackage) and TRP2_OpenedPackage:IsVisible() then
					TRP2_AddObjectToPackage(ID);
				end
			end);
			_G["TRP2_CreationFrameBaseListeAuraSlot"..j]:SetScript("OnClick", function(self,button)
				if IsAltKeyDown() and button == "LeftButton" then
					StaticPopupDialogs["TRP2_GET_TEXT_NS"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_SHOWID);
					TRP2_ShowStaticPopup("TRP2_GET_TEXT_NS",nil,nil,nil,nil,nil,nil,ID);
					return;
				elseif IsAltKeyDown() and button == "RightButton" and string.len(ID) == TRP2_IDSIZE then
					if TRP2_Module_Interface["BannedID"][ID] then
						TRP2_Module_Interface["BannedID"][ID] = nil;
						TRP2_Afficher(TRP2_FT(TRP2_LOC_DeBanirCrea,TRP2_GetWithDefaut(AuraTab,"Nom",UNKNOWN)));
					else
						TRP2_Module_Interface["BannedID"][ID] = true;
						TRP2_Afficher(TRP2_FT(TRP2_LOC_BanirCrea,TRP2_GetWithDefaut(AuraTab,"Nom",UNKNOWN)));
					end
					TRP2_ListerAura(num);
					return;
				end
				if button == "LeftButton" then
					if IsControlKeyDown() and string.len(ID) == TRP2_IDSIZE then
						if UnitName("target") and UnitName("target") ~= TRP2_Joueur and UnitIsPlayer("target") and UnitFactionGroup("target") == UnitFactionGroup("player") then
							TRP2_GetCreaInfo(UnitName("target"),ID,TRP2_GetWithDefaut(AuraTab,"VerNum",1));
						else
							StaticPopupDialogs["TRP2_GET_TEXT_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_SendInfoTT,TRP2_GetWithDefaut(AuraTab,"Nom",UNKNOWN)));
							TRP2_ShowStaticPopup("TRP2_GET_TEXT_NS",nil,TRP2_GetCreaInfo,ID,TRP2_GetWithDefaut(AuraTab,"VerNum",1));
						end
					else
						if TRP2_CanRead(AuraTab) then
							TRP2_CreationPanel("Aura",nil,ID);
						else
							TRP2_Error(TRP2_LOC_VerrError);
						end
					end
				elseif button == "RightButton" then
					if IsControlKeyDown() then
						TRP2_CalculerDependance(AuraTab,ID);
					elseif IsShiftKeyDown() then
						TRP2_ExportAdd(ID);
					elseif string.len(ID) == TRP2_IDSIZE then
						StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_DEL_REF_OBJ,TRP2_GetNameWithMode(AuraTab)));
						TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
							wipe(TRP2_Module_Auras[ID]);
							TRP2_Module_Auras[ID] = nil;
							TRP2_ListerAura();
						end);
					end
				end
			end);
			
			-- Calcul du tooltip
			local Message="ID n° "..ID;
			if string.len(ID) == 8 then
				Message = Message.."\n{v}< Total RP 2 : DataBase >";
			else
				Message = Message.."\n{v}< "..TRP2_LOC_CREATOR.." : {o}"..TRP2_GetWithDefaut(AuraTab,"Createur",UNKNOWN).."{v} >";
				Message = Message.."\n{v}< "..GAME_VERSION_LABEL.." : {o}"..TRP2_GetWithDefaut(AuraTab,"VerNum",1).."{v} >";
				Message = Message.."\n{v}< "..TRP2_LOC_LASTDATE.." : {o}"..TRP2_GetWithDefaut(AuraTab,"Date",date("%d/%m/%y à %H:%M:%S")).."{v} >";
			end
			if TRP2_Module_Interface["BannedID"][ID] then
				Message = Message.."\n\n{r}".."! Création bannie !";
			else
				if TRP2_GetWithDefaut(AuraTab,"bWriteLock",true) or string.len(ID) == 5 then
					Message = Message.."\n{o}< "..TRP2_LOC_WRITELOCK.." >";
				end
			end
			Message = Message.."\n";
			Message = Message.."\n{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_SEEINFOEDIT;
			if string.len(ID) == TRP2_IDSIZE then
				Message = Message.."\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_DELETEINFO;
				Message = Message.."\n{j}"..TRP2_LOC_CLICCTRL.." {w}: "..TRP2_LOC_SendInfo;
			end
			Message = Message.."\n{j}"..TRP2_LOC_CLICDROITCTRL.." {w}: "..TRP2_LOC_AFFICHERSTAT;
			if string.len(ID) == TRP2_IDSIZE then
				Message = Message.."\n{j}"..TRP2_LOC_CLICDROITMAJ.." {w}: "..TRP2_LOC_EXPORT;
				Message = Message.."\n{j}"..TRP2_LOC_CLICDROITALT.." {w}: "..TRP2_LOC_BANID;
			end
			Message = Message.."\n{j}"..TRP2_LOC_CLICALT.." {w}: "..TRP2_LOC_SHOWIDTT;
			TRP2_SetTooltipForFrame(
				getglobal("TRP2_CreationFrameBaseListeAuraSlot"..j),
				TRP2_CreationFrameBase,"TOPLEFT",262,-515,
				"{w}|TInterface\\ICONS\\"..TRP2_GetWithDefaut(AuraTab,"Icone","Temp.blp")..":30:30|t "..TRP2_GetWithDefaut(AuraTab,"Nom",""),
				Message
			);
			j = j + 1;
		end
		i = i + 1;
	end);
end

function TRP2_CalculerDependance(tableau,ID)
	local stream = TRP2_Libs:Serialize(tableau);
	local message = TRP2_FT(TRP2_LOC_CREATIONSTAT,ID,TRP2_OctetstoString(strlen(stream)),math.ceil((strlen(stream)/221)));
	local IDList = TRP2_FindIDInStream(stream);
	
	for key,value in pairs(IDList) do
		if key == ID then
			IDList[key] = nil;
		end
	end
	
	if TRP2_GetIndexedTabSize(IDList) > 0 then
		message = message.."\n\n{w}"..TRP2_LOC_CREATIONREF.." :"
		local total = strlen(stream);
		for key,value in pairs(IDList) do
			message = message.."\n"..TRP2_FT(TRP2_LOC_CREATIONREF2,key,value);
			total = total + strlen(TRP2_Libs:Serialize(TRP2_GetTabInfo(key)));
		end
		message = message.."\n"..TRP2_FT(TRP2_LOC_CREATIONREF3,TRP2_OctetstoString(total),math.ceil((total/221)));
	end
	
	StaticPopupDialogs["TRP2_JUST_TEXT"].text = TRP2_CTS(TRP2_ENTETE..message);
	TRP2_ShowStaticPopup("TRP2_JUST_TEXT");
end

function TRP2_GetTabInfo(ID)
	if string.sub(ID,1,3) == "ITE" then
		return TRP2_GetObjectTab(ID);
	elseif string.sub(ID,1,3) == "AUR" then
		return TRP2_GetAuraInfo(ID);
	elseif string.sub(ID,1,3) == "DOC" then
		return TRP2_GetDocumentInfo(ID);
	elseif string.sub(ID,1,3) == "QUE" then
		return TRP2_GetQuestsInfo(ID);
	elseif TRP2_EmptyToNil(ID) then
		return TRP2_GetLangageInfo(ID);
	end
	return nil;
end

----------------------------
-- DIVERS
----------------------------

function TRP2_CanWrite(Tab,ID)
	return ((TRP2_GetWithDefaut(Tab,"Createur",TRP2_Joueur) == TRP2_Joueur or not TRP2_GetWithDefaut(Tab,"bWriteLock",true)) and string.len(ID) ~= 8);
end

function TRP2_CanRead(Tab)
	return true;
end

function TRP2_CreateNewEmpty(oType)
	if oType == "Item" then
		return TRP2_CreateID("ITE");
	elseif oType == "Aura" then
		return TRP2_CreateID("AUR");
	elseif oType == "Quest" then
		return TRP2_CreateID("QUE");
	elseif oType == "Document" then
		return TRP2_CreateID("DOC");
	end
end

function TRP2_DebugRefreshSynchronizedString()
	local message=""
	--message = message.."Souffle : "..tostring(TRP2_PlayerSouffle).."\n";
	message = message.."{c}[TRP2-DEBUG] : {o}Tableau de query :\n";
	if TRP2_SynchronisedTab and TRP2_GetIndexedTabSize(TRP2_SynchronisedTab) > 0 then
		table.foreach(TRP2_SynchronisedTab, function(joueur)
			message = message.."{o}Joueur : {v}"..joueur.."\n";
			table.foreach(TRP2_SynchronisedTab[joueur], function(ID)
				message = message.."    {o}Données : {j}"..ID.."\n";
				local taille = TRP2_GetIndexedTabSize(TRP2_SynchronisedTab[joueur][ID]);
				message = message.."        {o}Taille tab : {c}"..taille.."\n";
			end)
		end)
	else
		message = message.."{v}Aucun échange d'information";
	end
	
	return message;
end

----------------------------
-- EFFETS ET CONDITIONS
----------------------------

-- Effet Document : Load
function TRP2_EffetDocumentLoad(id,index)
	TRP2_EffetDocumentFrameDocument.Arg = id;
	TRP2_EffetDocumentFrameDocumentIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetDocumentInfo(id),"Icone","Temp"));
	TRP2_EffetDocumentFrameSave:SetScript("OnClick", function()
		TRP2_TriggerEditFrameEffet.effetTab[index] = "docu$"..TRP2_EffetDocumentFrameDocument.Arg;
		TRP2_debug(TRP2_TriggerEditFrameEffet.effetTab[index]);
		TRP2_EffetDocumentFrame:Hide();
		TRP_CalculerListeEffets();
	end);
	TRP2_EffetDocumentFrame:Show();
end

-- Effet Durabilite : Load
function TRP2_EffetDurabiliteLoad(quantite, mode, myType,bRand, index)
	TRP2_EffetDurabiliteFrameSaisieQte:SetText(quantite);
	TRP2_EffetDurabiliteFrameSaisieQteCheck:SetChecked(bRand == "1");
	TRP2_EffetDurabiliteFrameMode.Choix = tonumber(mode);
	TRP2_EffetDurabiliteFrameType.Choix = tonumber(myType);
	if TRP2_EffetDurabiliteFrameMode.Choix == 1 then
		TRP2_EffetDurabiliteFrameModeValeur:SetText(TRP2_CTS(ADD));
	else
		TRP2_EffetDurabiliteFrameModeValeur:SetText(TRP2_CTS(REMOVE));
	end
	if TRP2_EffetDurabiliteFrameType.Choix == 1 then
		TRP2_EffetDurabiliteFrameTypeValeur:SetText(TRP2_CTS(TRP2_LOC_SAC));
	else
		TRP2_EffetDurabiliteFrameTypeValeur:SetText(TRP2_CTS(TRP2_LOC_COFFRE));
	end
	TRP2_EffetDurabiliteFrameSave:SetScript("OnClick", function()
		if not TRP2_EmptyToNil(tostring(TRP2_EffetDurabiliteFrameSaisieQte:GetText())) then
			TRP2_EffetDurabiliteFrameSaisieQte:SetText(quantite);
		end
		TRP2_TriggerEditFrameEffet.effetTab[index] = "durabilite$"..tostring(TRP2_EffetDurabiliteFrameSaisieQte:GetText()).."$"..tostring(TRP2_EffetDurabiliteFrameMode.Choix).."$"..tostring(TRP2_EffetDurabiliteFrameType.Choix.."$"..tostring(TRP2_EffetDurabiliteFrameSaisieQteCheck:GetChecked()));
		TRP2_debug(TRP2_TriggerEditFrameEffet.effetTab[index]);
		TRP2_EffetDurabiliteFrame:Hide();
		TRP_CalculerListeEffets();
		
	end);
	TRP2_EffetDurabiliteFrame:Show();
end
-- Effet Durabilite : DropDown Type
function TRP2_DD_EffetDurabiliteType(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = BAGSLOTTEXT;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	local statut = TRP2_EffetDurabiliteFrameType.Choix;

	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS(TRP2_LOC_SAC);
	if TRP2_EffetDurabiliteFrameType.Choix == 1 then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_EffetDurabiliteFrameType.Choix = 1;
		TRP2_EffetDurabiliteFrameTypeValeur:SetText(TRP2_CTS(TRP2_LOC_SAC));
	end;
	UIDropDownMenu_AddButton(info,level);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS(TRP2_LOC_COFFRE);
	if TRP2_EffetDurabiliteFrameType.Choix == 2 then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_EffetDurabiliteFrameType.Choix = 2;
		TRP2_EffetDurabiliteFrameTypeValeur:SetText(TRP2_CTS(TRP2_LOC_COFFRE));
	end;
	UIDropDownMenu_AddButton(info,level);

	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end
-- Effet Durabilite : DropDown Mode
function TRP2_DD_EffetDurabiliteMode(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = MODE;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	local statut = TRP2_EffetDurabiliteFrameMode.Choix;

	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS(ADD);
	if TRP2_EffetDurabiliteFrameMode.Choix == 1 then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_EffetDurabiliteFrameMode.Choix = 1;
		TRP2_EffetDurabiliteFrameModeValeur:SetText(TRP2_CTS(ADD));
	end;
	UIDropDownMenu_AddButton(info,level);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS(REMOVE);
	if TRP2_EffetDurabiliteFrameMode.Choix == 2 then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_EffetDurabiliteFrameMode.Choix = 2;
		TRP2_EffetDurabiliteFrameModeValeur:SetText(TRP2_CTS(REMOVE));
	end;
	UIDropDownMenu_AddButton(info,level);

	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

-- Effet Language : Load
function TRP2_EffetLangLoad(id, maitrise, mode, index)
	TRP2_EffetLangFrameSaisieEtape:SetText(maitrise);
	TRP2_EffetLangFrameLang.Arg = id;
	TRP2_EffetLangFrameLangIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetLangageInfo(id),"Icone","Temp"));
	TRP2_EffetLangFrameMode.Choix = tonumber(mode);
	TRP2_EffetLangFrameModeValeur:SetText(TRP2_CTS(TRP2_LOC_MODEETAPE[tonumber(mode)]));
	TRP2_EffetLangFrameSave:SetScript("OnClick", function()
		local fluency = tonumber(TRP2_EmptyToNil(TRP2_EffetLangFrameSaisieEtape:GetText()));
		if fluency == nil then
			fluency = maitrise;
		end
		TRP2_TriggerEditFrameEffet.effetTab[index] = "lang$"..TRP2_EffetLangFrameLang.Arg.."$"..fluency.."$"..tostring(TRP2_EffetLangFrameMode.Choix);
		TRP2_debug(TRP2_TriggerEditFrameEffet.effetTab[index]);
		TRP2_EffetLangFrame:Hide();
		TRP_CalculerListeEffets();
		
	end);
	TRP2_EffetLangFrame:Show();
end

-- Effet Lang : DropDown Mode
function TRP2_DD_EffetLangMode(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = MODE;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	local i;
	for i=1,3,1 do
		info = TRP2_CreateSimpleDDButton();
		if TRP2_EffetLangFrameMode.Choix == i then
			info.text = TRP2_CTS(TRP2_LOC_MODEETAPE[i]);
			info.checked = true;
			info.disabled = true;
		else
			info.text = TRP2_CTS(TRP2_LOC_MODEETAPE[i]);
		end
		info.func = function()
			TRP2_EffetLangFrameMode.Choix = i;
			TRP2_EffetLangFrameModeValeur:SetText(TRP2_CTS(TRP2_LOC_MODEETAPE[i]));
		end;
		UIDropDownMenu_AddButton(info,level);
	end

	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end


-- Effet Quest : Load
function TRP2_EffetQuestLoad(id, etape, mode, index)
	TRP2_EffetQuestFrameSaisieEtape:SetText(etape);
	TRP2_EffetQuestFrameQuest.Arg = id;
	TRP2_EffetQuestFrameQuestIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetQuestsInfo(id),"Icone","Temp"));
	TRP2_EffetQuestFrameMode.Choix = tonumber(mode);
	TRP2_EffetQuestFrameModeValeur:SetText(TRP2_CTS(TRP2_LOC_MODEETAPE[tonumber(mode)]));
	TRP2_EffetQuestFrameSave:SetScript("OnClick", function()
		local questStep = TRP2_EmptyToNil(TRP2_EffetQuestFrameSaisieEtape:GetText());
		if not questStep then
			questStep = etape;
		end
		questStep = string.gsub(questStep,"[%$%;]","");
		TRP2_TriggerEditFrameEffet.effetTab[index] = "quest$"..TRP2_EffetQuestFrameQuest.Arg.."$"..questStep.."$"..tostring(TRP2_EffetQuestFrameMode.Choix);
		TRP2_debug(TRP2_TriggerEditFrameEffet.effetTab[index]);
		TRP2_EffetQuestFrame:Hide();
		TRP_CalculerListeEffets();
		
	end);
	TRP2_EffetQuestFrame:Show();
end
-- Effet Quest : DropDown Mode
function TRP2_DD_EffetQuestMode(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = MODE;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	local i;
	for i=1,3,1 do
		info = TRP2_CreateSimpleDDButton();
		if TRP2_EffetQuestFrameMode.Choix == i then
			info.text = TRP2_CTS(TRP2_LOC_MODEETAPE[i]);
			info.checked = true;
			info.disabled = true;
		else
			info.text = TRP2_CTS(TRP2_LOC_MODEETAPE[i]);
		end
		info.func = function()
			TRP2_EffetQuestFrameMode.Choix = i;
			TRP2_EffetQuestFrameModeValeur:SetText(TRP2_CTS(TRP2_LOC_MODEETAPE[i]));
		end;
		UIDropDownMenu_AddButton(info,level);
	end

	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

-- Effet Lifetime : Load
function TRP2_EffetLifetimeLoad(temps,bRand, index)
	TRP2_EffetLifetimeFrameSaisieTime:SetText(temps);
	TRP2_EffetLifetimeFrameSaisieTimeCheck:SetChecked(bRand=="1");
	TRP2_EffetLifetimeFrameSave:SetScript("OnClick", function()
		if not TRP2_EmptyToNil(tostring(TRP2_EffetLifetimeFrameSaisieTime:GetText())) then
			TRP2_EffetLifetimeFrameSaisieTime:SetText(temps);
		end
		TRP2_TriggerEditFrameEffet.effetTab[index] = "lifetime$"..tostring(TRP2_EffetLifetimeFrameSaisieTime:GetText()).."$"..tostring(TRP2_EffetLifetimeFrameSaisieTimeCheck:GetChecked());
		TRP2_debug(TRP2_TriggerEditFrameEffet.effetTab[index]);
		TRP2_EffetLifetimeFrame:Hide();
		TRP_CalculerListeEffets();
		
	end);
	TRP2_EffetLifetimeFrame:Show();
end

-- Effet Cooldown : Load
function TRP2_EffetCoolLoad(id, temps,bRand, index)
	TRP2_EffetCoolFrameSaisieTime:SetText(temps);
	TRP2_EffetCoolFrameSaisieTimeCheck:SetChecked(bRand=="1");
	TRP2_EffetCoolFrameObjet.Arg = id;
	TRP2_EffetCoolFrameObjetIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetObjectTab(id),"Icone","Temp"));
	TRP2_EffetCoolFrameSave:SetScript("OnClick", function()
		if not TRP2_EmptyToNil(tostring(TRP2_EffetCoolFrameSaisieTime:GetText())) then
			TRP2_EffetCoolFrameSaisieTime:SetText(temps);
		end
		TRP2_TriggerEditFrameEffet.effetTab[index] = "cool$"..TRP2_EffetCoolFrameObjet.Arg.."$"..tostring(TRP2_EffetCoolFrameSaisieTime:GetText()).."$"..tostring(TRP2_EffetCoolFrameSaisieTimeCheck:GetChecked());
		TRP2_debug(TRP2_TriggerEditFrameEffet.effetTab[index]);
		TRP2_EffetCoolFrame:Hide();
		TRP_CalculerListeEffets();
		
	end);
	TRP2_EffetCoolFrame:Show();
end

-- Effet Mascotte : Load
function TRP2_EffetMascotteLoad(nom, index)
	TRP2_EffetMascotteFrameNom:SetText(nom);
	TRP2_EffetMascotteFrameSave:SetScript("OnClick", function()
		local mascotte = TRP2_EmptyToNil(TRP2_EffetMascotteFrameNom:GetText());
		if not mascotte then
			mascotte = nom;
		end
		mascotte = string.gsub(mascotte,"[%$%;]","");
		TRP2_TriggerEditFrameEffet.effetTab[index] = "mascotte$"..mascotte;
		TRP2_debug(TRP2_TriggerEditFrameEffet.effetTab[index]);
		TRP2_EffetMascotteFrame:Hide();
		TRP_CalculerListeEffets();
		
	end);
	TRP2_EffetMascotteFrame:Show();
end

-- Effet Objet : Load
function TRP2_EffetObjetLoad(id, qte, mode,bRand, index)
	TRP2_EffetObjetFrameSaisieQte:SetText(qte);
	TRP2_EffetObjetFrameSaisieQteCheck:SetChecked(bRand == "1");
	TRP2_EffetObjetFrameMode.Choix = tonumber(mode);
	TRP2_EffetObjetFrameObjet.Arg = id;
	TRP2_EffetObjetFrameObjetIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetObjectTab(id),"Icone","Temp"));
	if TRP2_EffetObjetFrameMode.Choix == 1 then
		TRP2_EffetObjetFrameModeValeur:SetText(TRP2_CTS(ADD));
	else
		TRP2_EffetObjetFrameModeValeur:SetText(TRP2_CTS(REMOVE));
	end
	TRP2_EffetObjetFrameSave:SetScript("OnClick", function()
		if not TRP2_EmptyToNil(tostring(TRP2_EffetObjetFrameSaisieQte:GetText())) then
			TRP2_EffetObjetFrameSaisieQte:SetText(qte);
		end
		TRP2_TriggerEditFrameEffet.effetTab[index] = "objet$"..TRP2_EffetObjetFrameObjet.Arg.."$"..tostring(TRP2_EffetObjetFrameSaisieQte:GetText()).."$"..tostring(TRP2_EffetObjetFrameMode.Choix).."$"..tostring(TRP2_EffetObjetFrameSaisieQteCheck:GetChecked());
		TRP2_debug(TRP2_TriggerEditFrameEffet.effetTab[index]);
		TRP2_EffetObjetFrame:Hide();
		TRP_CalculerListeEffets();
		
	end);
	TRP2_EffetObjetFrame:Show();
end
-- Effet Objet : DropDown Mode
function TRP2_DD_EffetObjetMode(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = MODE;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	local statut = TRP2_EffetObjetFrameMode.Choix;

	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS(ADD);
	if TRP2_EffetObjetFrameMode.Choix == 1 then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_EffetObjetFrameMode.Choix = 1;
		TRP2_EffetObjetFrameModeValeur:SetText(TRP2_CTS(ADD));
	end;
	UIDropDownMenu_AddButton(info,level);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS(REMOVE);
	if TRP2_EffetObjetFrameMode.Choix == 2 then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_EffetObjetFrameMode.Choix = 2;
		TRP2_EffetObjetFrameModeValeur:SetText(TRP2_CTS(REMOVE));
	end;
	UIDropDownMenu_AddButton(info,level);

	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

-- Effet Son : Load
function TRP2_EffetSonLoad(url, mode, porte, index)
	TRP2_EffetSonFrameSaisieSonScrollEditBox:SetText(url);
	TRP2_EffetSonFrameSaisiePorte:SetText(porte);
	TRP2_EffetSonFrameMode.Choix = tonumber(mode);
	TRP2_EffetSonFrameModeValeur:SetText(TRP2_CTS(TRP2_LOC_MODESON[tonumber(mode)]));

	TRP2_EffetSonFrameSave:SetScript("OnClick", function()
		local soundList = TRP2_EmptyToNil(TRP2_EffetSonFrameSaisieSonScrollEditBox:GetText());
		if not soundList then
			soundList = url;
		end
		soundList = string.gsub(soundList,"[%$%;]","");
		if not TRP2_EmptyToNil(TRP2_EffetSonFrameSaisiePorte:GetText()) then
			TRP2_EffetSonFrameSaisiePorte:SetText(porte);
		end
		TRP2_TriggerEditFrameEffet.effetTab[index] = "son$"..soundList.."$"..tostring(TRP2_EffetSonFrameMode.Choix).."$"..TRP2_EffetSonFrameSaisiePorte:GetText();
		TRP2_debug(TRP2_TriggerEditFrameEffet.effetTab[index]);
		TRP2_EffetSonFrame:Hide();
		TRP_CalculerListeEffets();
		
	end);
	TRP2_EffetSonFrame:Show();
end
-- Effet Son : DropDown Mode
function TRP2_DD_EffetSonMode(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = MODE;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	local i;
	for i=1,3,1 do
		info = TRP2_CreateSimpleDDButton();
		if TRP2_EffetSonFrameMode.Choix == i then
			info.text = TRP2_CTS(TRP2_LOC_MODESON[i]);
			info.checked = true;
			info.disabled = true;
		else
			info.text = TRP2_CTS(TRP2_LOC_MODESON[i]);
		end
		info.func = function()
			TRP2_EffetSonFrameMode.Choix = i;
			TRP2_EffetSonFrameModeValeur:SetText(TRP2_CTS(TRP2_LOC_MODESON[i]));
		end;
		UIDropDownMenu_AddButton(info,level);
	end

	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

-- Effet Aura : Load
function TRP2_EffetAuraLoad(id, temps, mode, cible,bRand, index)
	TRP2_EffetAuraFrameSaisieTime:SetText(temps);
	TRP2_EffetAuraFrameSaisieTimeCheck:SetChecked(bRand == "1");
	TRP2_EffetAuraFrameMode.Choix = tonumber(mode);
	TRP2_EffetAuraFrameCible.Choix = tonumber(cible);
	TRP2_EffetAuraFrameCibleValeur:SetText(TRP2_CTS(TRP2_LOC_AuraCibleTab[tonumber(cible)]));
	TRP2_EffetAuraFrameAura.Arg = id;
	TRP2_EffetAuraFrameAuraIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetAuraInfo(id),"Icone","Temp"));
	if TRP2_EffetAuraFrameMode.Choix == 1 then
		TRP2_EffetAuraFrameModeValeur:SetText(TRP2_CTS(ADD));
	else
		TRP2_EffetAuraFrameModeValeur:SetText(TRP2_CTS(REMOVE));
	end
	TRP2_EffetAuraFrameSave:SetScript("OnClick", function()
		if not TRP2_EmptyToNil(tostring(TRP2_EffetAuraFrameSaisieTime:GetText())) then
			TRP2_EffetAuraFrameSaisieTime:SetText(temps);
		end
		TRP2_TriggerEditFrameEffet.effetTab[index] = "aura$"..TRP2_EffetAuraFrameAura.Arg.."$"..tostring(TRP2_EffetAuraFrameSaisieTime:GetText()).."$"..tostring(TRP2_EffetAuraFrameMode.Choix).."$"..tostring(TRP2_EffetAuraFrameCible.Choix).."$"..tostring(TRP2_EffetAuraFrameSaisieTimeCheck:GetChecked());
		TRP2_debug(TRP2_TriggerEditFrameEffet.effetTab[index]);
		TRP2_EffetAuraFrame:Hide();
		TRP_CalculerListeEffets();
		
	end);
	TRP2_EffetAuraFrame:Show();
end
-- Effet Aura : DropDown Mode
function TRP2_DD_EffetAuraMode(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = MODE;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	local statut = TRP2_EffetAuraFrameMode.Choix;

	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS(ADD);
	if TRP2_EffetAuraFrameMode.Choix == 1 then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_EffetAuraFrameMode.Choix = 1;
		TRP2_EffetAuraFrameModeValeur:SetText(TRP2_CTS(ADD));
	end;
	UIDropDownMenu_AddButton(info,level);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS(REMOVE);
	if TRP2_EffetAuraFrameMode.Choix == 2 then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_EffetAuraFrameMode.Choix = 2;
		TRP2_EffetAuraFrameModeValeur:SetText(TRP2_CTS(REMOVE));
	end;
	UIDropDownMenu_AddButton(info,level);

	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end
-- Effet Aura : DropDown Cible
function TRP2_DD_EffetAuraCible(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TARGET;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	local i;
	for i=1,4,1 do
		info = TRP2_CreateSimpleDDButton();
		if TRP2_EffetAuraFrameCible.Choix == i then
			info.text = TRP2_CTS(TRP2_LOC_AuraCibleTab[i]);
			info.checked = true;
			info.disabled = true;
		else
			info.text = TRP2_CTS(TRP2_LOC_AuraCibleTab[i]);
		end
		info.func = function()
			TRP2_EffetAuraFrameCible.Choix = i;
			TRP2_EffetAuraFrameCibleValeur:SetText(TRP2_CTS(TRP2_LOC_AuraCibleTab[i]));
		end;
		UIDropDownMenu_AddButton(info,level);
	end

	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

-- Effet Or : Load
function TRP2_EffetOrLoad(quantite, mode, bAlea, index)
	TRP2_EffetOrFrameSaisieQte:SetText(quantite);
	TRP2_EffetOrFrameSaisieQteCheck:SetChecked(bAlea == "1");
	TRP2_EffetOrFrameMode.Choix = tonumber(mode);
	if TRP2_EffetOrFrameMode.Choix == 1 then
		TRP2_EffetOrFrameModeValeur:SetText(TRP2_CTS(ADD));
	else
		TRP2_EffetOrFrameModeValeur:SetText(TRP2_CTS(REMOVE));
	end
	TRP2_EffetOrFrameSave:SetScript("OnClick", function()
		if not TRP2_EmptyToNil(tostring(TRP2_EffetOrFrameSaisieQte:GetText())) then
			TRP2_EffetOrFrameSaisieQte:SetText(quantite);
		end
		TRP2_TriggerEditFrameEffet.effetTab[index] = "or$"..tostring(TRP2_EffetOrFrameSaisieQte:GetText()).."$"..tostring(TRP2_EffetOrFrameMode.Choix).."$"..tostring(TRP2_EffetOrFrameSaisieQteCheck:GetChecked());
		TRP2_debug(TRP2_TriggerEditFrameEffet.effetTab[index]);
		TRP2_EffetOrFrame:Hide();
		TRP_CalculerListeEffets();
		
	end);
	TRP2_EffetOrFrame:Show();
end
-- Effet Or : DropDown Mode
function TRP2_DD_EffetOrMode(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = MODE;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	local statut = TRP2_EffetOrFrameMode.Choix;

	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS(ADD);
	if TRP2_EffetOrFrameMode.Choix == 1 then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_EffetOrFrameMode.Choix = 1;
		TRP2_EffetOrFrameModeValeur:SetText(TRP2_CTS(ADD));
	end;
	UIDropDownMenu_AddButton(info,level);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS(REMOVE);
	if TRP2_EffetOrFrameMode.Choix == 2 then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_EffetOrFrameMode.Choix = 2;
		TRP2_EffetOrFrameModeValeur:SetText(TRP2_CTS(REMOVE));
	end;
	UIDropDownMenu_AddButton(info,level);

	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

-- Effet Parole : Load
function TRP2_EffetParoleLoad(texte, Channel, index)
	TRP2_EffetDialogFrameTexteScrollEditBox:SetText(TRP2_STCinverse(texte));
	TRP2_EffetDialogFrameChannelDropDown.Choix = tonumber(Channel);
	TRP2_EffetDialogFrameChannelDropDownValeur:SetText(TRP2_CTS(getglobal("CHAT_MSG_"..TRP2_EFFETCHATTAB[tonumber(Channel)])));
	TRP2_EffetDialogFrameSave:SetScript("OnClick", function()
		TRP2_TriggerEditFrameEffet.effetTab[index] = "parole$"..tostring(TRP2_STC(TRP2_EffetDialogFrameTexteScrollEditBox:GetText())).."$"..tostring(TRP2_EffetDialogFrameChannelDropDown.Choix);
		--TRP2_debug(TRP2_TriggerEditFrameEffet.effetTab[index]);
		TRP2_EffetDialogFrame:Hide();
		TRP_CalculerListeEffets();
		
	end);
	TRP2_EffetDialogFrame:Show();
end
-- Effet Parole : DropDown Channel
function TRP2_DD_EffetParoleChannel(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = CHANNEL;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	local statut = TRP2_EffetDialogFrameChannelDropDown.Choix;
	local i;
	for i=1,#TRP2_EFFETCHATTAB,1 do
		info = TRP2_CreateSimpleDDButton();
		if statut == i then
			info.checked = true;
			info.disabled = true;
		end
		info.text = TRP2_CTS(getglobal("CHAT_MSG_"..TRP2_EFFETCHATTAB[i]));
		info.func = function()
			TRP2_EffetDialogFrameChannelDropDown.Choix = i;
			TRP2_EffetDialogFrameChannelDropDownValeur:SetText(TRP2_CTS(getglobal("CHAT_MSG_"..TRP2_EFFETCHATTAB[i])));
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

-- Effet Texte : Load
function TRP2_EffetTexteLoad(texte, iType, index)
	TRP2_EffetTexteFrameTexteScrollEditBox:SetText(TRP2_STCinverse(texte));
	TRP2_EffetTexteFrameTypeDropDown.Choix = tonumber(iType);
	TRP2_EffetTexteFrameTypeDropDownValeur:SetText(TRP2_CTS(TRP2_LOC_TEXTETYPE[tonumber(iType)]));
	TRP2_EffetTexteFrameSave:SetScript("OnClick", function()
		TRP2_TriggerEditFrameEffet.effetTab[index] = "texte$"..tostring(TRP2_STC(TRP2_EffetTexteFrameTexteScrollEditBox:GetText())).."$"..tostring(TRP2_EffetTexteFrameTypeDropDown.Choix);
		--TRP2_debug(TRP2_TriggerEditFrameEffet.effetTab[index]);
		TRP2_EffetTexteFrame:Hide();
		TRP_CalculerListeEffets();
		
	end);
	TRP2_EffetTexteFrame:Show();
end
-- Effet Texte : DropDown Type
function TRP2_DD_EffetTexteType(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = DISPLAY;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	local statut = TRP2_EffetTexteFrameTypeDropDown.Choix;
	local i;
	for i=1,4,1 do
		info = TRP2_CreateSimpleDDButton();
		if statut == i then
			info.text = TRP2_CTS(TRP2_LOC_TEXTETYPE[i]);
			info.checked = true;
			info.disabled = true;
		else
			info.text = TRP2_CTS(TRP2_LOC_TEXTETYPE[i]);
		end
		info.func = function()
			TRP2_EffetTexteFrameTypeDropDown.Choix = i;
			TRP2_EffetTexteFrameTypeDropDownValeur:SetText(TRP2_CTS(TRP2_LOC_TEXTETYPE[i]));
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_CloseCondiEffetsFrames()
	TRP2_TriggerEditFrame:Hide();
	TRP2_CondiConstructorFrame:Hide();
	TRP2_EffetTexteFrame:Hide();
	TRP2_EffetDialogFrame:Hide();
	TRP2_EffetOrFrame:Hide();
	TRP2_EffetAuraFrame:Hide();
	TRP2_EffetSonFrame:Hide();
	TRP2_EffetObjetFrame:Hide();
	TRP2_EffetCoolFrame:Hide();
	TRP2_EffetDocumentFrame:Hide();
	TRP2_EffetLangFrame:Hide();
	TRP2_EffetMascotteFrame:Hide();
	TRP2_EffetLifetimeFrame:Hide();
	TRP2_EffetDurabiliteFrame:Hide();
	TRP2_EffetQuestFrame:Hide();
	TRP2_EffetScriptFrame:Hide();
end

TRP2_LISTE_VALEURS = {
	["guildnamec"] = {
		["Titre"] = "Perso : Nom de la guilde (Cible)";
		["Explication"] = "Le nom la guilde de la cible ";
		["Icone"] = "INV_Shirt_GuildTabard_01";
		["ExpliDetails"] = "Vaut le nom de la guilde de la cible du personnage.";
	},
	["guildname"] = {
		["Titre"] = "Perso : Nom de la guilde";
		["Explication"] = "Le nom la guilde ";
		["Icone"] = "INV_Shirt_GuildTabard_01";
		["ExpliDetails"] = "Vaut le nom de la guilde du personnage.";
	},
	["queststep"] = {
		["Titre"] = "Quête : étape actuelle";
		["Explication"] = "L'étape actuelle d'une quête";
		["Icone"] = "Achievement_Quests_Completed_05";
		["ExpliDetails"] = "Vaut l'identifiant actuel d'une quête. Vaut 0 si le personnage n'a pas la quête dans son journal.";
		["Argument"] = "Quête calculé";
		["ListeArg"] = "questsID";
	},
	["masconame"] = {
		["Titre"] = "Mascotte : Nom de la mascotte";
		["Explication"] = "Le nom de la mascotte ";
		["Icone"] = "INV_Box_PetCarrier_01";
		["ExpliDetails"] = "Vaut le nom de la mascotte actuellement invoquée.";
	},
	["petname"] = {
		["Titre"] = "Familier : Nom du familier";
		["Explication"] = "Le nom du familier ";
		["Icone"] = "INV_Box_PetCarrier_01";
		["ExpliDetails"] = "Vaut le nom familier actuellement invoqué.";
	},
	["mountname"] = {
		["Titre"] = "Monture : Nom de la monture";
		["Explication"] = "Le nom de la monture ";
		["Icone"] = "Ability_Mount_Charger";
		["ExpliDetails"] = "Vaut le nom de la monture actuellement invoquée.";
	},
	["dist28yard"] = {
		["Titre"] = "Perso : Portée de la cible (Inspection)";
		["Explication"] = "Le personnage se trouve à portée d'inspection de la cible";
		["Icone"] = "Achievement_WorldEvent_ChildrensWeek";
		["ExpliDetails"] = "Calcule si le personnage se trouve à portée d'inspection de la cible (~25.6 mètres). Vaut 1 si c'est le cas.";
	},
	["dist10yard"] = {
		["Titre"] = "Perso : Portée de la cible (Duel)";
		["Explication"] = "Le personnage se trouve à portée de duel de la cible";
		["Icone"] = "Achievement_WorldEvent_ChildrensWeek";
		["ExpliDetails"] = "Calcule si le personnage se trouve à portée de duel de la cible (~9 mètres). Vaut 1 si c'est le cas.";
	},
	["coffre"] = {
		["Titre"] = "Coffre : Durabilité actuelle";
		["Explication"] = "La durabilité actuelle du coffre";
		["Icone"] = "INV_Box_01";
		["ExpliDetails"] = "Vaut la valeur de la durabilité du coffre.";
		["bNumeric"] = true;
	},
	["coffremax"] = {
		["Titre"] = "Coffre : Durabilité maximum";
		["Explication"] = "La durabilité maximum du coffre";
		["Icone"] = "INV_Box_01";
		["ExpliDetails"] = "Vaut la valeur de la durabilité maximum du coffre.";
		["bNumeric"] = true;
	},
	["sacados"] = {
		["Titre"] = "Sac à dos : Durabilité actuelle";
		["Explication"] = "La durabilité actuelle du sac à dos";
		["Icone"] = "INV_Misc_Bag_CenarionHerbBag";
		["ExpliDetails"] = "Vaut la valeur de la durabilité du sac à dos.";
		["bNumeric"] = true;
	},
	["sacadosmax"] = {
		["Titre"] = "Sac à dos : Durabilité maximum";
		["Explication"] = "La durabilité maximum du sac à dos";
		["Icone"] = "INV_Misc_Bag_CenarionHerbBag";
		["ExpliDetails"] = "Vaut la valeur de la durabilité maximum du sac à dos.";
		["bNumeric"] = true;
	},
	["cible"] = {
		["Titre"] = "Perso : A une cible";
		["Explication"] = "Le personnage cible actuellement quelque chose";
		["Icone"] = "Ability_Hunter_MasterMarksman";
		["ExpliDetails"] = "Détermine si le personnage possède une cible. Vaut 1 si il possède une cible.";
	},
	["isdead"] = {
		["Titre"] = "Perso : Mort";
		["Explication"] = "Le personnage est mort";
		["Icone"] = "Ability_Rogue_FeignDeath";
		["ExpliDetails"] = "Détermine si le personnage est mort (qu'il ai libéré son âme ou non). Vaut 1 si c'est le cas.";
	},
	["ismount"] = {
		["Titre"] = "Perso : Monture";
		["Explication"] = "Le personnage est sur une monture";
		["Icone"] = "Ability_Mount_Charger";
		["ExpliDetails"] = "Détermine si le personnage est actuellement sur une monture terrestre (ou une monture volante/forme de vol, mais au sol). Vaut 1 si c'est le cas.";
	},
	["isflying"] = {
		["Titre"] = "Perso : Vol";
		["Explication"] = "Le personnage est en vol";
		["Icone"] = "Ability_Mount_FlyingCarpet";
		["ExpliDetails"] = "Détermine si le personnage est actuellement en vol (Monture volante, forme de vol ...ect). Vaut 1 si c'est le cas.";
	},
	["istaxi"] = {
		["Titre"] = "Perso : Voyage";
		["Explication"] = "Le personnage est en vol payant";
		["Icone"] = "Ability_Mount_WarHippogryph";
		["ExpliDetails"] = "Détermine si le personnage est actuellement en vol payant (Griffon, Hyppogryphe, ...etc). Vaut 1 si c'est le cas.";
	},
	["isfalling"] = {
		["Titre"] = "Perso : Chute";
		["Explication"] = "Le personnage est en chute";
		["Icone"] = "Spell_Magic_FeatherFall";
		["ExpliDetails"] = "Détermine si le personnage est actuellement en train de tomber. Vaut 1 si c'est le cas.";
	},
	["isstealthed"] = {
		["Titre"] = "Perso : Camouflé";
		["Explication"] = "Le personnage est camouflé";
		["Icone"] = "Ability_Stealth";
		["ExpliDetails"] = "Détermine si le personnage est actuellement camouflé (Voleur, druide félin ..etc). Vaut 1 si c'est le cas.";
	},
	["isswimming"] = {
		["Titre"] = "Perso : Nage";
		["Explication"] = "Le personnage est en train de nager";
		["Icone"] = "Spell_Frost_SummonWaterElemental";
		["ExpliDetails"] = "Détermine si le personnage est actuellement en train de nager. Vaut 1 si c'est le cas.";
	},
	["isflyablearea"] = {
		["Titre"] = "Perso : Peut voler";
		["Explication"] = "Le personnage peut voler";
		["Icone"] = "INV_Feather_13";
		["ExpliDetails"] = "Détermine si le personnage est actuellement dans une zone permettant de voler. Vaut 1 si c'est le cas.";
	},
	["ispet"] = {
		["Titre"] = "Perso : Familier";
		["Explication"] = "Le personnage a invoqué un familier";
		["Icone"] = "INV_Box_PetCarrier_01";
		["ExpliDetails"] = "Détermine si le personnage a invoqué un familier. Vaut 1 si c'est le cas.";
	},
	["isminion"] = {
		["Titre"] = "Perso : Mascotte";
		["Explication"] = "Le personnage a invoqué une mascotte";
		["Icone"] = "INV_Box_PetCarrier_01";
		["ExpliDetails"] = "Détermine si le personnage a invoqué une mascotte. Vaut 1 si c'est le cas.";
	},
	["isdeadc"] = {
		["Titre"] = "Perso : Mort (Cible)";
		["Explication"] = "La cible du personnage est morte";
		["Icone"] = "Ability_Rogue_FeignDeath";
		["ExpliDetails"] = "Détermine si la cible du personnage est morte (qu'elle ai libéré son âme ou non). Vaut 1 si c'est le cas.";
	},
	["typec"] = {
		["Titre"] = "Perso : Type (Cible)";
		["Explication"] = "Le type de la cible du personnage";
		["Icone"] = "INV_Misc_Bone_HumanSkull_01";
		["ExpliDetails"] = "Détermine le type de la cible du personnage. Les valeurs possibles sont : Beast, Dragonkin, Demon, Elemental, Giant, Undead, Humanoid, Critter, Mechanical, Not specified, Totem, Non-combat Pet, Gas Cloud.";
	},
	["familyc"] = {
		["Titre"] = "Perso : Classification (Cible)";
		["Explication"] = "La classification de la cible du personnage";
		["Icone"] = "Ability_Mount_GyrocoptorElite";
		["ExpliDetails"] = "Détermine le type de la cible du personnage. Les valeurs possibles sont : worldboss, rareelite, elite, rare, normal ou trivial.";
	},
	["sex"] = {
		["Titre"] = "Perso : Sexe";
		["Explication"] = "Le sexe du personnage";
		["Icone"] = "Achievement_Character_Human_Female";
		["ExpliDetails"] = "Détermine le sexe du personnage. Les valeurs possibles sont : 1 pour neutre (ou inconnu), 2 pour mâle, 3 pour femelle.";
	},
	["sexc"] = {
		["Titre"] = "Perso : Sexe (Cible)";
		["Explication"] = "Le sexe de la cible du personnage";
		["Icone"] = "Achievement_Character_Human_Female";
		["ExpliDetails"] = "Détermine le sexe de la cible du personnage. Les valeurs possibles sont : 1 pour neutre (ou inconnu), 2 pour mâle, 3 pour femelle.";
	},
	["name"] = {
		["Titre"] = "Perso : Nom";
		["Explication"] = "Le nom du personnage";
		["Icone"] = "INV_Misc_Book_10";
		["ExpliDetails"] = "C'est le nom du personnage.";
	},
	["namec"] = {
		["Titre"] = "Perso : Nom (Cible)";
		["Explication"] = "Le nom de la cible du personnage";
		["Icone"] = "INV_Misc_Book_10";
		["ExpliDetails"] = "C'est le nom de la cible du personnage.";
	},
	["nametrpc"] = {
		["Titre"] = "Perso : Nom TRP2 (Cible)";
		["Explication"] = "Le nom TRP2 de la cible du personnage";
		["Icone"] = "INV_Misc_Book_10";
		["ExpliDetails"] = "C'est le nom de la cible du personnage, le nom personnalisé propre à TRP2.";
	},
	["class"] = {
		["Titre"] = "Perso : Classe";
		["Explication"] = "La classe du personnage";
		["Icone"] = "Spell_Magic_MageArmor";
		["ExpliDetails"] = "C'est la classe du personnage. Elle doit être indiquée en anglais et sans espaces : \"mage\", \"warrior\", \"deathknight\", etc.";
	},
	["classc"] = {
		["Titre"] = "Perso : Classe (Cible)";
		["Explication"] = "La classe de la cible du personnage";
		["Icone"] = "Spell_Magic_MageArmor";
		["ExpliDetails"] = "C'est la classe de la cible du personnage. Elle doit être indiquée en anglais et sans espaces : \"mage\", \"warrior\", \"deathknight\", etc.";
	},
	["race"] = {
		["Titre"] = "Perso : Race";
		["Explication"] = "La race du personnage";
		["Icone"] = "Achievement_Character_Human_Male";
		["ExpliDetails"] = "C'est la race du personnage. Elle doit être indiquée en anglais, sans espaces, et notez que les Réprouvés sont traduit \"Scourge\".";
	},
	["racec"] = {
		["Titre"] = "Perso : Race (Cible)";
		["Explication"] = "La race de la cible du personnage";
		["Icone"] = "Achievement_Character_Human_Male";
		["ExpliDetails"] = "C'est la race de la cible du personnage. Elle doit être indiquée en anglais, sans espaces, et notez que les Réprouvés sont traduit \"Scourge\".";
	},
	["coord"] = {
		["Titre"] = "Perso : Carte : Coordonnée complète";
		["Explication"] = "La coordonnée de la position du personnages";
		["Icone"] = "INV_Misc_Map02";
		["ExpliDetails"] = "Vaut la coordonnée complète actuelle du personnage. Elle est de la forme :\nn°zone x y\nAttention, elle vaut 0 si la carte du monde est affichée !\n(plus d'info dans le guide)";
	},
	["souszone"] = {
		["Titre"] = "Perso : Carte : Sous-zone";
		["Explication"] = "Le nom de la sous-zone où se trouve le personnage";
		["Icone"] = "INV_Misc_Map02";
		["ExpliDetails"] = "C'est le nom de la sous-zone où se trouve votre personnage, c'est le nom qui se trouve au dessus de votre minimap. Il est disponible en instance.\nPar exemple : Port de Hurlevent, Cabestan ...";
	},
	["zone"] = {
		["Titre"] = "Perso : Carte : Zone";
		["Explication"] = "Le nom de la zone où se trouve le personnage";
		["Icone"] = "INV_Misc_Map02";
		["ExpliDetails"] = "C'est le nom de la zone où se trouve votre personnage, généralement le nom de la carte de la zone.\nPar exemple : Hurlevent, Mulgore ...";
	},
	-- NUMERIC
	["objplace"] = {
		["Titre"] = "Sac : Places restantes";
		["Explication"] = "Le nombre de places restantes dans le sac";
		["ExpliDetails"] = "Indique le nombre d'emplacements disponibles pour le sac à dos.";
		["Icone"] = "INV_Misc_Bag_17";
		["bNumeric"] = true;
	},
	["langnum"] = {
		["Titre"] = "Dialecte : Le nombre de dialectes";
		["Explication"] = "Le nombre de dialectes du personnage";
		["ExpliDetails"] = "Indique le nombre de dialectes que connait le personnage.";
		["Icone"] = "Spell_Holy_Silence";
		["bNumeric"] = true;
	},
	["langmaitrise"] = {
		["Titre"] = "Dialecte : Niveau de maîtrise";
		["Explication"] = "Le niveau de maîtrise d'un dialecte";
		["Icone"] = "Spell_Holy_Silence";
		["bNumeric"] = true;
		["ExpliDetails"] = "Vaut le niveau de maîtrise d'un certain dialecte (0-100). Vaut -1 si le personnage ne maîtrise pas du tout le dialecte.";
		["Argument"] = "Dialecte calculé";
		["ListeArg"] = "langID";
	},
	["coolnum"] = {
		["Titre"] = "Objet : Temps de recharge";
		["Explication"] = "Le temps de recharge restant d'un objet";
		["Icone"] = "INV_Fabric_Wool_02";
		["bNumeric"] = true;
		["ExpliDetails"] = "Vaut le temps de recharge restant d'un certain type d'objet. Vaut 0 si il n'y a pas de temps de recharge pour cet objet.";
		["Argument"] = "Objet calculé";
		["ListeArg"] = "objetID";
	},
	["rotation"] = {
		["Titre"] = "Perso : Direction";
		["Explication"] = "La direction (en radian) du personnage";
		["Icone"] = "Ability_EyeOfTheOwl";
		["bNumeric"] = true;
		["ExpliDetails"] = "Retourne, en radian, la direction vers laquelle est tourné le personnage. 0 = Nord, ensuite le nombre augmente selon le sens anti-horloger.\nPour rappel : 180° = Sud = Pi = 3,14. ;-)";
	},
	["rand"] = {
		["Titre"] = "Math : Aléatoire 100";
		["Explication"] = "Un nombre aléatoire entre 1 et 100";
		["Icone"] = "INV_Misc_Dice_01";
		["bNumeric"] = true;
		["ExpliDetails"] = "Tire un nombre aléatoire entre 1 et 100.";
	},
	["randmille"] = {
		["Titre"] = "Math : Aléatoire 1000";
		["Explication"] = "Un nombre aléatoire entre 1 et 1000";
		["Icone"] = "INV_Misc_Dice_01";
		["bNumeric"] = true;
		["ExpliDetails"] = "Tire un nombre aléatoire entre 1 et 1000.";
	},
	["randdixmille"] = {
		["Titre"] = "Math : Aléatoire 10000";
		["Explication"] = "Un nombre aléatoire entre 1 et 10000";
		["Icone"] = "INV_Misc_Dice_01";
		["bNumeric"] = true;
		["ExpliDetails"] = "Tire un nombre aléatoire entre 1 et 10000.";
	},
	["pv"] = {
		["Titre"] = "Perso : Points de Vie";
		["Explication"] = "Les points de vie actuel du personnage";
		["Icone"] = "INV_Crystallized_Life";
		["ExpliDetails"] = "Correspond au nombre de points de vie actuel du personnage.";
		["bNumeric"] = true;
	},
	["pvc"] = {
		["Titre"] = "Perso : Points de Vie de la cible";
		["Explication"] = "Les points de vie actuel de la cible du personnage";
		["ExpliDetails"] = "Correspond au nombre de points de vie actuel de la cible du personnage.";
		["Icone"] = "INV_Crystallized_Life";
		["bNumeric"] = true;
	},
	["objcnt"] = {
		["Titre"] = "Objet : Nombre d'unités d'un objet (Sac + Coffre)";
		["Explication"] = "Le nombre d'unités d'un objet dans les sacs";
		["ExpliDetails"] = "Correspond au nombre d'unités possédés (sac à dos et coffre) d'un certain objet.";
		["Argument"] = "Objet calculé";
		["Icone"] = "INV_Fabric_Wool_02";
		["bNumeric"] = true;
		["ListeArg"] = "objetID";
	},
	["auranum"] = {
		["Titre"] = "État : Nombre d'états (Perso)";
		["Explication"] = "Le nombre actuel d'états sur le personnage";
		["ExpliDetails"] = "Indique le nombre actuel d'états différents sur le personnage.";
		["Icone"] = "Spell_Holy_ImprovedResistanceAuras";
		["bNumeric"] = true;
	},
	["auranummount"] = {
		["Titre"] = "État : Nombre d'états (Monture)";
		["Explication"] = "Le nombre actuel d'états sur la monture";
		["ExpliDetails"] = "Indique le nombre actuel d'états différents sur la monture.";
		["Icone"] = "Spell_Holy_ImprovedResistanceAuras";
		["bNumeric"] = true;
	},
	["auranumpet"] = {
		["Titre"] = "État : Nombre d'états (Familier)";
		["Explication"] = "Le nombre actuel d'états sur le familier";
		["ExpliDetails"] = "Indique le nombre actuel d'états différents sur le familier.";
		["Icone"] = "Spell_Holy_ImprovedResistanceAuras";
		["bNumeric"] = true;
	},
	["auranumminion"] = {
		["Titre"] = "État : Nombre d'états (Mascotte)";
		["Explication"] = "Le nombre actuel d'états sur la mascotte";
		["ExpliDetails"] = "Indique le nombre actuel d'états différents sur la mascotte.";
		["Icone"] = "Spell_Holy_ImprovedResistanceAuras";
		["bNumeric"] = true;
	},
	["aurat"] = {
		["Titre"] = "État : Temps restant (Perso)";
		["Explication"] = "Le temps restant (en secondes) d'un état sur le personnage";
		["ExpliDetails"] = "Indique le temps restant d'un état sur le personnage. {j}Est égal à -1 si le personnage ne possède pas l'état.";
		["Argument"] = "État calculé";
		["Icone"] = "Spell_Holy_ImprovedResistanceAuras";
		["bNumeric"] = true;
		["ListeArg"] = "aurasID";
	},
	["auratmount"] = {
		["Titre"] = "État : Monture";
		["Explication"] = "La monture actuelle possède l'état voulu";
		["ExpliDetails"] = "Détermine si la monture actuelle possède l'état voulu. {j}Vaut -1 si la monture ne possède pas l'état, ou si aucune monture n'est invoquée.";
		["Argument"] = "État calculé";
		["Icone"] = "Spell_Holy_ImprovedResistanceAuras";
		["bNumeric"] = true;
		["ListeArg"] = "aurasID";
	},
	["auratpet"] = {
		["Titre"] = "État : Familier";
		["Explication"] = "Le familier actuel possède l'état voulu";
		["ExpliDetails"] = "Détermine si le familier actuel possède l'état voulu. {j}Vaut -1 si le familier ne possède pas l'état, ou si aucun familier n'est invoquée.";
		["Argument"] = "État calculé";
		["Icone"] = "Spell_Holy_ImprovedResistanceAuras";
		["bNumeric"] = true;
		["ListeArg"] = "aurasID";
	},
	["auratminion"] = {
		["Titre"] = "État : Mascotte";
		["Explication"] = "La mascotte actuelle possède l'état voulu";
		["ExpliDetails"] = "Détermine si la macotte actuelle possède l'état voulu. {j}Vaut -1 si la mascotte ne possède pas l'état, ou si aucune mascotte n'est invoquée.";
		["Argument"] = "État calculé";
		["Icone"] = "Spell_Holy_ImprovedResistanceAuras";
		["bNumeric"] = true;
		["ListeArg"] = "aurasID";
	},
	["aurattarget"] = {
		["Titre"] = "État : Cible";
		["Explication"] = "La cible possède l'état voulu";
		["ExpliDetails"] = "Détermine si la cible actuelle, un personnage joueur, possède l'état voulu. {j}Vaut -1 si la cible ne possède pas l'état, ou si le personnage n'a pas de cible.";
		["Argument"] = "État calculé";
		["Icone"] = "Spell_Holy_ImprovedResistanceAuras";
		["bNumeric"] = true;
		["ListeArg"] = "aurasID";
	},
	["speed"] = {
		["Titre"] = "Perso : Vitesse";
		["Explication"] = "La vitesse de déplacement du personnage";
		["Icone"] = "Spell_Fire_BurningSpeed";
		["bNumeric"] = true;
		["ExpliDetails"] = "Retourne la vitesse de déplacement actuelle du personnage.\nPour info :\nDéplacement normal à 100% = 7.";
	},
	["persotaille"] = {
		["Titre"] = "Perso : Taille";
		["Explication"] = "La taille du personnage";
		["Icone"] = "Spell_Shadow_TwistedFaith";
		["bNumeric"] = true;
		["ExpliDetails"] = "Vaut la taille du personnage. Voici les valeurs possibles :\n{j}1 = Très petite taille\n{j}2 = Petite taille\n{j}3 = Taille moyenne\n{j}4 = Grande taille\n{j}5 = Très grande taille\n";
	},
	["persosil"] = {
		["Titre"] = "Perso : Musculature";
		["Explication"] = "La musculature du personnage";
		["Icone"] = "Ability_Warrior_StrengthOfArms";
		["bNumeric"] = true;
		["ExpliDetails"] = "Vaut la musculature du personnage. Voici les valeurs possibles :\n{j}1 = Silhouette obèse\n{j}2 = Silhouette svelte\n{j}3 = Silhouette musclée";
	},
	["persotaillec"] = {
		["Titre"] = "Perso : Taille (Cible)";
		["Explication"] = "La taille de la cible du personnage";
		["Icone"] = "Spell_Shadow_TwistedFaith";
		["bNumeric"] = true;
		["ExpliDetails"] = "Vaut la taille de la cible du personnage. Voici les valeurs possibles :\n{j}0 = Pas de cible\n1 = Très petite taille\n2 = Petite taille\n3 = Taille moyenne\n4 = Grande taille\n5 = Très grande taille\n";
	},
	["persosilc"] = {
		["Titre"] = "Perso : Musculature (Cible)";
		["Explication"] = "La musculature de la cible du personnage";
		["Icone"] = "Ability_Warrior_StrengthOfArms";
		["bNumeric"] = true;
		["ExpliDetails"] = "Vaut la musculature de la cible du personnage. Voici les valeurs possibles :\n{j}0 = Pas de cible\n1 = Silhouette obèse\n2 = Silhouette svelte\n3 = Silhouette musclée";
	},
}

TRP2_LISTE_COMPA = {
	["=="] = {
		["Titre"] = "égal à";
		["Explication"] = "{w}Vérifie si la première valeur est égale à la seconde.\n{v}Ce comparateur est utilisable autant pour les valeurs numériques que textuelles.";
		["Icone"] = "INV_Gizmo_06.blp";
	},
	["~="] = {
		["Titre"] = "différent de";
		["Explication"] = "{w}Vérifie si la première valeur est différente de la seconde.\n{v}Ce comparateur est utilisable autant pour les valeurs numériques que textuelles.";
		["Icone"] = "INV_Gizmo_07.blp";
	},
	[">"] = {
		["Titre"] = "plus grand que";
		["Explication"] = "{w}Vérifie si la première valeur est strictement plus grande que la seconde.\n{o}Ce comparateur n'est utilisable que pour les valeurs numériques.";
		["Icone"] = "Spell_ChargePositive.blp";
		["bNumeric"] = true;
	},
	["<"] = {
		["Titre"] = "plus petit que";
		["Explication"] = "{w}Vérifie si la première valeur est strictement plus petite que la seconde.\n{o}Ce comparateur n'est utilisable que pour les valeurs numériques.";
		["Icone"] = "Spell_ChargeNegative.blp";
		["bNumeric"] = true;
	},
	[">="] = {
		["Titre"] = "plus grand ou égal à";
		["Explication"] = "{w}Vérifie si la première valeur est plus grande ou égale à la seconde.\n{o}Ce comparateur n'est utilisable que pour les valeurs numériques.";
		["Icone"] = "Spell_ChargePositive.blp";
		["bNumeric"] = true;
	},
	["<="] = {
		["Titre"] = "plus petit ou égal à";
		["Explication"] = "{w}Vérifie si la première valeur est plus petite ou égale à la seconde.\n{o}Ce comparateur n'est utilisable que pour les valeurs numériques.";
		["Icone"] = "Spell_ChargeNegative.blp";
		["bNumeric"] = true;
	},
}

TRP2_LISTE_EFFETS = {
	["mascotte"] = {
		["Titre"] = "Invoquer une mascotte/monture";
		["Explication"] = "Cela permet d'invoquer une certaine mascotte/monture.";
		["Icone"] = "Ability_Mount_Dreadsteed";
	},
	["lang"] = {
		["Titre"] = "Maîtrise d'un dialecte";
		["Explication"] = "Cela permet de changer la maîtrise d'un dialecte.";
		["Icone"] = "Spell_Holy_Silence";
	},
	["docu"] = {
		["Titre"] = "Afficher un document";
		["Explication"] = "Cela permet d'afficher un document.";
		["Icone"] = "INV_Inscription_Papyrus";
	},
	["durabilite"] = {
		["Titre"] = "Modifier la durabilité";
		["Explication"] = "Cela permet de réparer ou d'infliger des dégats au sac à dos ou au coffre du personnage.";
		["Icone"] = "INV_Misc_Bag_CenarionHerbBag";
	},
	["texte"] = {
		["Titre"] = "Afficher un texte";
		["Explication"] = "Cela affichera un texte. C'est un texte personnel qui ne sera vu que par le joueur.";
		["Icone"] = "INV_Misc_Book_05";
	},
	["discotte"] = {
		["Titre"] = "Désinvoquer";
		["Explication"] = "Renvoie la mascotte actuellement invoquée.";
		["Icone"] = "INV_Box_PetCarrier_01";
	},
	["dismount"] = {
		["Titre"] = "Démonter";
		["Explication"] = "Force le joueur à mettre pied à terre si il se trouve sur une monture.\nAttention, fonctionne aussi pour les montures volantes en plein vol !";
		["Icone"] = "Ability_Mount_Charger";
	},
	["critter"] = {
		["Titre"] = "Invoquer une mascotte";
		["Explication"] = "Invoque une mascotte aléatoire.";
		["Icone"] = "INV_Box_PetCarrier_01";
	},
	["sheath"] = {
		["Titre"] = "Sortir/ranger ses armes";
		["Explication"] = "Le joueur sortira ses armes si elles sont rangées, ou les rangera dans le cas contraire.";
		["Icone"] = "Ability_Warrior_Challange";
	},
	["parole"] = {
		["Titre"] = "Parole/emote";
		["Explication"] = "Le personnage dira la phrase ou jouera l'émote. Vous pouvez choisir le channel (Dire, guilde ...etc).";
		["Icone"] = "INV_Misc_Book_04";
	},
	["or"] = {
		["Titre"] = "Ajouter/retirer de l'or";
		["Explication"] = "Ajoute ou retire une certaine quantité d'or du sac à dos.";
		["Icone"] = "INV_Misc_Coin_01";
	},
	["aura"] = {
		["Titre"] = "Ajouter/retirer un état";
		["Explication"] = "Ajoute (ou retire) un certain état du personnage indiqué (si un emplacement d'état est disponible) pour une certaine durée (0 = infini).";
		["Icone"] = "Spell_Holy_ImprovedResistanceAuras";
	},
	["son"] = {
		["Titre"] = "Jouer un effet sonore";
		["Explication"] = "Joue un effet sonore. Celui-ci peut être entendu uniquement par le joueur ou par son entourage.";
		["Icone"] = "INV_Misc_Ear_Human_01";
	},
	["objet"] = {
		["Titre"] = "Inventaire : Ajouter/Retirer";
		["Explication"] = "Ajoute ou retire une certaine quantité d'un objet de votre sac à dos.";
		["Icone"] = "INV_Misc_Bag_12";
	},
	["cool"] = {
		["Titre"] = "Inventaire : Rechargement";
		["Explication"] = "Déclenche le rechargement (cooldown) pour tout les objet de votre inventaire du type donné pour une durée déterminée.";
		["Icone"] = "INV_Misc_Bag_12";
	},
	["lifetime"] = {
		["Titre"] = "Inventaire : Durée de vie";
		["Explication"] = "Active une certaine durée de vie pour l'objet utilisé.\n{r}Valable uniquement pour les déclencheurs d'objets suivant :\n"
						.."{o}- Utilisation(début et fin)\n- Utilisation ratée(début et fin)";
		["Icone"] = "INV_Misc_Bag_12";
	},
	["quest"] = {
		["Titre"] = "Quête : Changer d'Étape";
		["Explication"] = "Change l'étape d'une quête.";
		["Icone"] = "Achievement_Quests_Completed_04";
	},
}

TRP2_FunctionReplaceTAB = {

	-- Effets prefixe
	["texte"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		TRP2_TexteScript(arg1,arg2,tonumber(arg3));
	end,
	["parole"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		SendChatMessage(arg2,TRP2_EFFETCHATTAB[tonumber(arg3)]);
	end,
	["or"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		TRP2_InvOr(tonumber(arg2),tonumber(arg3),tonumber(arg4));
	end,
	["durabilite"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		TRP2_InvDurabilite(tonumber(arg2),tonumber(arg3),tonumber(arg4),tonumber(arg5));
	end,
	["aura"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		TRP2_EffetAuraScript(arg2,tonumber(arg3),tonumber(arg4),tonumber(arg5),tonumber(arg6));
	end,
	["son"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		arg2 = string.gsub(arg2,"\\\\","\\");
		TRP2_PlaySoundScript(arg2,tonumber(arg3),tonumber(arg4));
	end,
	["objet"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		TRP2_ObjetScript(arg2,tonumber(arg3),tonumber(arg4),tonumber(arg5));
	end,
	["cool"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		TRP2_SetCooldown(arg2,tonumber(arg3),tonumber(arg4));
	end,
	["lifetime"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		TRP2_SetLifetime(arg7,arg8,tonumber(arg2),tonumber(arg3));
	end,
	["quest"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		TRP2_QuestsGoToStep(arg3,arg2,tonumber(arg4));
	end,
	["dismount"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		DismissCompanion("MOUNT");
	end,
	["discotte"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		DismissCompanion("CRITTER");
	end,
	["mascotte"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		TRP2_MascotteScript(arg2);
	end,
	["sheath"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		ToggleSheath();
	end,
	["critter"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		SummonRandomCritter();
	end,
	["docu"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		TRP2_ChargerDocument(TRP2_GetDocumentInfo(arg2),1,arg2);
	end,
	["lang"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		TRP2_LangScript(arg2,arg3,tonumber(arg4));
	end,
	["script"] = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
		print("Total RP 2 creation : |cffff0000Warning ! the old Script effect is now forbiden. Please correct your creation.");
	end,

	-- Tests d'état-valeur:
	["masconame"] = "string.lower(TRP2_GetActualMinionName(\"\"))",
	["mountname"] = "string.lower(TRP2_GetActualMountName(\"\"))",
	["petname"] = "string.lower(tostring(UnitName(\"pet\")))",
	["nametrpc"] = "string.lower(TRP2_GetTargetTRPName())",
	["name"] = "string.lower(tostring(UnitName(\"player\")))",
	["class"] = "string.lower(tostring(TRP2_GetEnglishClass(\"player\")))";
	["race"] = "string.lower(tostring(TRP2_GetEnglishRace(\"player\")))";
	["sex"] = "string.lower(tostring(UnitSex(\"player\")))";
	["isdead"] = "string.lower(tostring(UnitIsDeadOrGhost(\"player\")))";
	["ismount"] = "string.gsub(string.lower(tostring(IsMounted() and not UnitOnTaxi(\"player\"))),\"true\",\"1\")";
	["isflying"] = "string.gsub(string.lower(tostring(IsFlying() and not UnitOnTaxi(\"player\"))),\"true\",\"1\")";
	["istaxi"] = "string.lower(string.sub(tostring(UnitOnTaxi(\"player\")),\"true\",1)";
	["isfalling"] = "string.lower(tostring(IsFalling()))";
	["isswimming"] = "string.lower(tostring(IsSwimming()))";
	["isflyablearea"] = "string.lower(tostring(IsFlyableArea()))";
	["isstealthed"] = "string.lower(tostring(IsStealthed()))";
	["ispet"] = "string.gsub(string.lower(tostring(UnitName(\"pet\")~=nil)),\"true\",\"1\")";
	["isminion"] = "string.gsub(string.lower(tostring(TRP2_GetActualMinionName()~=nil)),\"true\",\"1\")";
	["dist28yard"] = "string.gsub(string.lower(tostring(CheckInteractDistance(\"target\", 1))),\"true\",\"1\")";
	["dist10yard"] = "string.gsub(string.lower(tostring(CheckInteractDistance(\"target\", 3))),\"true\",\"1\")";
	["coord"] = "string.lower(tostring(TRP2_GetPlanqueID(false)))";
	["souszone"] = "string.lower(tostring(GetSubZoneText()))";
	["zone"] = "string.lower(tostring(GetZoneText()))";
	["queststep"] = "string.lower(tostring(TRP2_QuestEtapeScript(\"%1\")))";
	["guildname"] = "TRP2_GetGuildScript(\"player\")";
	["guildnamec"] = "TRP2_GetGuildScript(\"target\")";
	
	["namec"] = "string.lower(tostring(UnitName(\"target\")))",
	["classc"] = "string.lower(tostring(TRP2_GetEnglishClass(\"target\")))";
	["racec"] = "string.lower(tostring(TRP2_GetEnglishRace(\"target\")))";
	["sexc"] = "string.lower(tostring(UnitSex(\"target\")))";
	["isdeadc"] = "string.lower(tostring(UnitIsDeadOrGhost(\"target\")))";
	["familyc"] = "string.lower(tostring(UnitClassification(\"target\")))";
	["typec"] = "string.lower(tostring(UnitCreatureType(\"target\")))";
	["cible"] = "string.lower(tostring(UnitExists(\"target\")))";
	
	-- Test numerique :
	["langnum"] = "TRP2_GetIndexedTabSize(TRP2_GetInfo(TRP2_Joueur,\"Langues\",{}))";
	["auranum"] = "TRP2_AuraNumScript(1)";
	["auranummount"] = "TRP2_AuraNumScript(2)";
	["auranumpet"] = "TRP2_AuraNumScript(3)";
	["auranumminion"] = "TRP2_AuraNumScript(4)";
	["persosilc"] = "TRP2_GetWithDefaut(TRP2_GetInfo(tostring(UnitName(\"target\")),\"Registre\"),\"Silhouette\",2)";
	["persotaillec"] = "TRP2_GetWithDefaut(TRP2_GetInfo(tostring(UnitName(\"target\")),\"Registre\"),\"Taille\",3)";
	["persosil"] = "TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,\"Registre\"),\"Silhouette\",2)";
	["persotaille"] = "TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,\"Registre\"),\"Taille\",3)";
	["sacados"] = "TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][\"Sac\"][\"Durabilite\"]";
	["sacadosmax"] = "TRP2_GetWithDefaut(TRP2_SacsADos[TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][\"Sac\"][\"Id\"]],\"Resistance\",0)";
	["coffre"] = "TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][\"Coffre\"][\"Durabilite\"]";
	["coffremax"] = "TRP2_GetWithDefaut(TRP2_CoffreMonture[TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][\"Coffre\"][\"Id\"]],\"Resistance\",0)";
	["rand"] = "math.random(1,100)";
	["randmille"] = "math.random(1,1000)";
	["randdixmille"] = "math.random(1,10000)";
	["rotation"] = "GetPlayerFacing()";
	["speed"] = "GetUnitSpeed(\"player\")",
	["aurattarget"] = "TRP2_AuraGetTimeScript(string.upper(\"%1\"),5)";
	["aurat"] = "TRP2_AuraGetTimeScript(string.upper(\"%1\"),1)";
	["auratmount"] = "TRP2_AuraGetTimeScript(string.upper(\"%1\"),2)";
	["auratpet"] = "TRP2_AuraGetTimeScript(string.upper(\"%1\"),3)";
	["auratminion"] = "TRP2_AuraGetTimeScript(string.upper(\"%1\"),4)";
	["pv"] = "UnitHealth(\"player\")";
	["pvc"] = "UnitHealth(\"target\")";
	["coolnum"] = "TRP2_GetCooldownScript(string.upper(\"%1\"))";
	["objcnt"] = "(TRP2_CountIDInBag(string.upper(\"%1\"),\"Sac\")+TRP2_CountIDInBag(string.upper(\"%1\"),\"Coffre\"))";
	["langmaitrise"] = "TRP2_GetDialectComp(\"%1\")";
	["objplace"] = "200 - TRP2_GetIndexedTabSize(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][\"Sac\"][\"Slot\"])";
}

function TRP2_GetEffetTooltipArg(EffetTab)
	local tooltip;
	if EffetTab[1] == "texte" then
		return "{v}"..TRP2_LOC_AFFICHTEXTEB.." :\n   {w}"..EffetTab[2].."\n{v}"..DISPLAY.." :\n   {w}"..TRP2_LOC_TEXTETYPE[tonumber(EffetTab[3])];
	elseif EffetTab[1] == "mascotte" then
		return "{v}"..PET.." :\n   {w}"..EffetTab[2];
	elseif EffetTab[1] == "parole" then
		return "{v}"..TRP2_LOC_AFFICHTEXTEB.." :\n   {w}"..EffetTab[2].."\n{v}"..CHANNEL.." :\n   {w}"..getglobal("CHAT_MSG_"..TRP2_EFFETCHATTAB[tonumber(EffetTab[3])]);
	elseif EffetTab[1] == "or" then
		local alea = "";
		if EffetTab[4] == "1" then
			alea = " {j}("..TRP2_LOC_RANDOM..")";
		end
		if EffetTab[3] == "1" then
			return "{v}"..TRP2_LOC_MONTANT.." :\n   {w}"..TRP2_GoldToText(EffetTab[2])..alea.."\n{v}"..MODE.." :\n   {w}"..ADD;
		else
			return "{v}"..TRP2_LOC_MONTANT.." :\n   {w}"..TRP2_GoldToText(EffetTab[2])..alea.."\n{v}"..MODE.." :\n   {w}"..REMOVE;
		end
	elseif EffetTab[1] == "durabilite" then
		local alea = "";
		if EffetTab[5] == "1" then
			alea = " {j}("..TRP2_LOC_RANDOM..")";
		end
		if EffetTab[3] == "1" then
			return "{v}"..DURABILITY.." :\n   {w}"..EffetTab[2]..alea.."\n{v}"..MODE.." :\n   {w}"..ADD.."\n{v}"..BAGSLOTTEXT.." :\n   {w}"..TRP2_LOC_EFFETDURATAB[EffetTab[4]];
		else
			return "{v}"..DURABILITY.." :\n   {w}"..EffetTab[2]..alea.."\n{v}"..MODE.." :\n   {w}"..REMOVE.."\n{v}"..BAGSLOTTEXT.." :\n   {w}"..TRP2_LOC_EFFETDURATAB[EffetTab[4]];
		end
	elseif EffetTab[1] == "aura" then
		local alea = "";
		if EffetTab[6] == "1" then
			alea = " {j}("..TRP2_LOC_RANDOM..")";
		end
		if EffetTab[4] == "1" then
			return "{v}"..TRP2_LOC_CreationTypeEtat.." :\n   {w}"..TRP2_GetWithDefaut(TRP2_GetAuraInfo(EffetTab[2]),"Nom","{r}"..UNKNOWN).."\n{v}"..TRP2_LOC_DUREE.." :\n   {w}"..EffetTab[3].." s"..alea.."\n{v}"..MODE.." :\n   {w}"..ADD.."\n{v}"..TARGET.." :\n   {w}"..TRP2_LOC_AuraCibleTab[tonumber(EffetTab[5])];
		else
			return "{v}"..TRP2_LOC_CreationTypeEtat.." :\n   {w}"..TRP2_GetWithDefaut(TRP2_GetAuraInfo(EffetTab[2]),"Nom","{r}"..UNKNOWN).."\n{v}"..TRP2_LOC_DUREE.." :\n   {w}"..EffetTab[3].." s"..alea.."\n{v}"..MODE.." :\n   {w}"..REMOVE.."\n{v}"..TARGET.." :\n   {w}"..TRP2_LOC_AuraCibleTab[tonumber(EffetTab[5])];
		end
	elseif EffetTab[1] == "son" then
		return "{v}Url :\n{w}"..TRP2_GetLastRep(string.gsub(EffetTab[2],"\\\\","\\")).."\n{v}"..MODE.." : {w}"..TRP2_LOC_MODESON[tonumber(EffetTab[3])];
	elseif EffetTab[1] == "objet" then
		local alea = "";
		if EffetTab[5] == "1" then
			alea = " {j}("..TRP2_LOC_RANDOM..")";
		end
		if EffetTab[4] == "1" then
			return "{v}"..TRP2_LOC_CreationTypeObjet.." :\n   {w}"..TRP2_GetWithDefaut(TRP2_GetObjectTab(EffetTab[2]),"Nom","{r}"..UNKNOWN).."\n{v}"..TRP2_LOC_QUANTITE.." :\n   {w}"..EffetTab[3]..alea
			.."\n{v}"..MODE.." :\n   {w}"..ADD;
		else
			return "{v}"..TRP2_LOC_CreationTypeObjet.." :\n   {w}"..TRP2_GetWithDefaut(TRP2_GetObjectTab(EffetTab[2]),"Nom","{r}"..UNKNOWN).."\n{v}"..TRP2_LOC_QUANTITE.." :\n   {w}"..EffetTab[3]..alea
			.."\n{v}"..MODE.." :\n   {w}"..REMOVE;
		end
	elseif EffetTab[1] == "cool" then
		local alea = "";
		if EffetTab[4] == "1" then
			alea = " {j}("..TRP2_LOC_RANDOM..")";
		end
		return "{v}"..TRP2_LOC_CreationTypeObjet.." :\n   {w}"..TRP2_GetWithDefaut(TRP2_GetObjectTab(EffetTab[2]),"Nom","{r}"..UNKNOWN).."\n{v}"..TRP2_LOC_DUREE.." :\n   {w}"..EffetTab[3].." s"..alea;
	elseif EffetTab[1] == "lifetime" then
		local alea = "";
		if EffetTab[3] == "1" then
			alea = " {j}("..TRP2_LOC_RANDOM..")";
		end
		return "{v}"..TRP2_LOC_DUREE.." :\n   {w}"..EffetTab[2].." s"..alea;
	elseif EffetTab[1] == "quest" then
		return "{v}"..TRP2_LOC_CreationTypeQuest.." :\n   {w}"..TRP2_GetWithDefaut(TRP2_GetQuestsInfo(EffetTab[2]),"Nom","{r}"..UNKNOWN).."\n{v}"..TRP2_LOC_ETAPESID.." :\n   {w}"..EffetTab[3].."\n{v}"..MODE.." :\n   {w}"..TRP2_LOC_MODEETAPE[tonumber(EffetTab[4])];
	elseif EffetTab[1] == "lang" then
		return "{v}"..TRP2_LOC_CreationTypeLang.." :\n   {w}"..TRP2_GetWithDefaut(TRP2_GetLangageInfo(EffetTab[2]),"Entete","{r}"..UNKNOWN).."\n{v}"..TRP2_LOC_MAITRISE.." :\n   {w}"..EffetTab[3].."\n{v}"..MODE.." :\n   {w}"..TRP2_LOC_MODEETAPE[tonumber(EffetTab[4])];
	elseif EffetTab[1] == "docu" then
		return "{v}"..TRP2_LOC_CreationTypeDoc.." :\n   {w}"..TRP2_GetWithDefaut(TRP2_GetDocumentInfo(EffetTab[2]),"Nom","{r}"..UNKNOWN);
	end
	return "{v}"..TRP2_LOC_NOARG;
end

function TRP2_TooltipTrigger(conditions, effets, scripts)
	local tooltip = "";
	local nombre = 1;
	local EffetTab = {};
	
	if TRP2_EmptyToNil(conditions) then
		local _, FNCTab = TRP2_ConstructFNC(TRP2_FetchToTabWithSeparator(string.gsub(conditions,"\n",""),";"));
		tooltip = tooltip..FNCTab;
		tooltip = string.gsub(tooltip,"%$"," ");
	end
	if TRP2_EmptyToNil(effets) then
		EffetTab = TRP2_FetchToTabWithSeparator(string.gsub(effets,"\n",""),";")
		nombre = #EffetTab;
	end
	tooltip = tooltip.."{o}"..TRP2_LOC_EFFETNUM.." : {w}"..(nombre-1);
	local i = 1;
	table.foreach(EffetTab,function(effet)
		if TRP2_EmptyToNil(EffetTab[effet]) then
			local prefix = string.match(EffetTab[effet],"(%w+)%$*");
			if prefix and TRP2_LISTE_EFFETS[prefix] then
				tooltip = tooltip.."\n{o}"..i.."){w} "..TRP2_LISTE_EFFETS[prefix]["Titre"];
				i = i + 1;
			end
		end
	end);
	if scripts then
		tooltip = tooltip.."\n\n"..TRP2_LOC_EFFETHASSCRIPT;
	else
		tooltip = tooltip.."\n\n"..TRP2_LOC_EFFETNOSCRIPT;
	end
	tooltip = tooltip.."\n\n{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_EVENTEDIT.."\n{j}"..TRP2_LOC_CLICDROIT.." : {w}"..TRP2_LOC_EVENTREINIT;
	return tooltip;
end

function TRP2_TooltipApercuTrigger()
	local tooltip = "";
	local nombre = 1;
	local EffetTab = {};
	local effets = "";
	local conditions = "";
	table.foreach(TRP2_TriggerEditFrameEffet.effetTab,function(effet)
		if TRP2_EmptyToNil(TRP2_TriggerEditFrameEffet.effetTab[effet]) then
			effets = effets..TRP2_TriggerEditFrameEffet.effetTab[effet]..";";
		end
	end);
	table.foreach(TRP2_TriggerEditFrameCondition.condiTab,function(condi)
		if TRP2_EmptyToNil(TRP2_TriggerEditFrameCondition.condiTab[condi]) then
			conditions = conditions..TRP2_TriggerEditFrameCondition.condiTab[condi]..";";
		end
	end);
	if TRP2_EmptyToNil(conditions) then
		local _, FNCTab = TRP2_ConstructFNC(TRP2_FetchToTabWithSeparator(string.gsub(conditions,"\n",""),";"));
		tooltip = tooltip..FNCTab;
		tooltip = string.gsub(tooltip,"%$"," ");
	end
	if TRP2_EmptyToNil(effets) then
		EffetTab = TRP2_FetchToTabWithSeparator(string.gsub(effets,"\n",""),";")
		nombre = #EffetTab;
	end
	tooltip = tooltip.."{o}"..TRP2_LOC_EFFETNUM.." : {w}"..(nombre-1);
	local i = 1;
	table.foreach(EffetTab,function(effet)
		if TRP2_EmptyToNil(EffetTab[effet]) then
			local prefix = string.match(EffetTab[effet],"(%w+)%$*");
			if prefix and TRP2_LISTE_EFFETS[prefix] then
				tooltip = tooltip.."\n{o}"..i.."){w} "..TRP2_LISTE_EFFETS[prefix]["Titre"];
				i = i + 1;
			end
		end
	end);
	return tooltip;
end

function TRP2_TooltipScriptButton()
	if TRP2_EmptyToNil(TRP2_TriggerEditFrameEffet.scripts) then
		TRP2_SetTooltipForFrame(TRP2_TriggerEditFrameEffetScript,TRP2_TriggerEditFrameEffetScript,"TOP",0,0,TRP2_LOC_EFFETSCRIPT,TRP2_LOC_EFFETSCRIPTTT.."\n\n"..TRP2_LOC_EFFETHASSCRIPT);
	else
		TRP2_SetTooltipForFrame(TRP2_TriggerEditFrameEffetScript,TRP2_TriggerEditFrameEffetScript,"TOP",0,0,TRP2_LOC_EFFETSCRIPT,TRP2_LOC_EFFETSCRIPTTT.."\n\n"..TRP2_LOC_EFFETNOSCRIPT);
	end
end

function TRP2_ChargerEffetCondi(self,effets,conditions,titre,scripts)
	TRP2_TriggerEditFrame:Hide();
	local effetTab = {};
	local condiTab = {};
	TRP2_TriggerEditFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_EFFETCONDIEDIT.." : {o}"..tostring(titre)));
	-- New script frame
	TRP2_EffetScriptFrameTitle:SetText(TRP2_CTS("{w}".."Script".." : {o}"..tostring(titre)));
	TRP2_TriggerEditFrameEffet.scripts = scripts;
	TRP2_EffetScriptFrameScriptScrollEditBox:SetText(TRP2_NilToEmpty(TRP2_TriggerEditFrameEffet.scripts));
	TRP2_EffetScriptFrameSave:SetScript("OnClick",function()
		
		TRP2_TriggerEditFrameEffet.scripts = TRP2_EmptyToNil(TRP2_EffetScriptFrameScriptScrollEditBox:GetText());
		TRP2_EffetScriptFrame:Hide();
	end);
	---------------
	if TRP2_EmptyToNil(effets) then
		effetTab = TRP2_FetchToTabWithSeparator(effets,";");
		if effetTab[#effetTab] == "" then
			effetTab[#effetTab] = nil;
		end
	end
	if TRP2_EmptyToNil(conditions) then
		condiTab = TRP2_FetchToTabWithSeparator(conditions,";");
		if condiTab[#condiTab] == "" then
			condiTab[#condiTab] = nil;
		end
	end
	TRP2_TriggerEditFrameEffet.effetTab = effetTab;
	TRP2_TriggerEditFrameCondition.condiTab = condiTab;
	TRP_CalculerListeEffets();
	TRP_CalculerListeConditions();
	TRP2_TriggerEditFrameSave:SetScript("OnClick",function()
		local effets = "";
		local conditions = "";
		table.foreach(TRP2_TriggerEditFrameEffet.effetTab,function(effet)
			if TRP2_EmptyToNil(TRP2_TriggerEditFrameEffet.effetTab[effet]) then
				effets = effets..TRP2_TriggerEditFrameEffet.effetTab[effet]..";";
			end
		end);
		table.foreach(TRP2_TriggerEditFrameCondition.condiTab,function(condi)
			if TRP2_EmptyToNil(TRP2_TriggerEditFrameCondition.condiTab[condi]) then
				conditions = conditions..TRP2_TriggerEditFrameCondition.condiTab[condi]..";";
			end
		end);
		self.Scripts = TRP2_TriggerEditFrameEffet.scripts;
		self.Effets = effets;
		self.Conditions = conditions;
		getglobal(self:GetName().."Cooldown"):SetCooldown(0,0);
	end);
	TRP2_TriggerEditFrame.from = self;
	TRP2_TriggerEditFrame:Show();
end

function TRP_CalculerListeEffets()
	local j = #TRP2_TriggerEditFrameEffet.effetTab;
	TRP2_TriggerEditFrameEffetSlider:Hide();
	
	if j == 0 then
		TRP2_TriggerEditFrameEffetEmpty:SetText(TRP2_LOC_NOEFFET);
	else
		TRP2_TriggerEditFrameEffetEmpty:SetText("");
	end
	if j > 5 then
		TRP2_TriggerEditFrameEffetSlider:Show();
		local total = floor((j-1)/5);
		TRP2_TriggerEditFrameEffetSlider:SetMinMaxValues(0,total);
		TRP2_TriggerEditFrameEffetSlider:SetValue(0);
	end
	TRP2_TriggerEditFrameEffetSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerEffets(self:GetValue());
		end
	end)
	TRP2_ListerEffets(0);
end

function TRP_CalculerListeConditions()
	local j = #TRP2_TriggerEditFrameCondition.condiTab;
	TRP2_TriggerEditFrameConditionSlider:Hide();
	
	if j == 0 then
		TRP2_TriggerEditFrameConditionEmpty:SetText(TRP2_LOC_NOCONDI);
	else
		TRP2_TriggerEditFrameConditionEmpty:SetText("");
	end
	if j > 5 then
		TRP2_TriggerEditFrameConditionSlider:Show();
		local total = floor((j-1)/5);
		TRP2_TriggerEditFrameConditionSlider:SetMinMaxValues(0,total);
		TRP2_TriggerEditFrameConditionSlider:SetValue(0);
	end
	TRP2_TriggerEditFrameConditionSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerConditions(self:GetValue());
		end
	end)
	TRP2_ListerConditions(0);
end

function TRP2_FoundFreePlace(tab,prefix,num)
	local nombre = 1;
	while true do
		local retour = ""..nombre;
		local left = num - string.len(retour);
		for i=1,left,1 do
			retour = "0"..retour;
		end
		if not tab[TRP2_NilToDefaut(prefix,"")..retour] then
			return retour;
		end
		nombre = nombre + 1;
	end
end

function TRP2_NewEffet(Effet)
	if Effet == "texte" then
		TRP2_EffetTexteLoad("", "1", #TRP2_TriggerEditFrameEffet.effetTab + 1);
	elseif Effet == "parole" then
		TRP2_EffetParoleLoad("", "1", #TRP2_TriggerEditFrameEffet.effetTab + 1);
	elseif Effet == "or" then
		TRP2_EffetOrLoad("1", "1","nil", #TRP2_TriggerEditFrameEffet.effetTab + 1);
	elseif Effet == "aura" then
		TRP2_EffetAuraLoad("AUR00001", "0", "1", "1","nil", #TRP2_TriggerEditFrameEffet.effetTab + 1);
	elseif Effet == "son" then
		TRP2_EffetSonLoad("", "1", "0", #TRP2_TriggerEditFrameEffet.effetTab + 1);
	elseif Effet == "objet" then
		TRP2_EffetObjetLoad("ITE00001","1","1","nil", #TRP2_TriggerEditFrameEffet.effetTab + 1);
	elseif Effet == "cool" then
		TRP2_EffetCoolLoad("ITE00001","1","nil", #TRP2_TriggerEditFrameEffet.effetTab + 1);
	elseif Effet == "lifetime" then
		TRP2_EffetLifetimeLoad("1","nil", #TRP2_TriggerEditFrameEffet.effetTab + 1);
	elseif Effet == "quest" then
		TRP2_EffetQuestLoad("QUE00001","001","1", #TRP2_TriggerEditFrameEffet.effetTab + 1);
	elseif Effet == "lang" then
		TRP2_EffetLangLoad("LAN00001","100","1", #TRP2_TriggerEditFrameEffet.effetTab + 1);
	elseif Effet == "durabilite" then
		TRP2_EffetDurabiliteLoad("0","1","1","nil", #TRP2_TriggerEditFrameEffet.effetTab + 1);
	elseif Effet == "dismount" then
		TRP2_TriggerEditFrameEffet.effetTab[#TRP2_TriggerEditFrameEffet.effetTab + 1] = "dismount";
		TRP_CalculerListeEffets();
	elseif Effet == "discotte" then
		TRP2_TriggerEditFrameEffet.effetTab[#TRP2_TriggerEditFrameEffet.effetTab + 1] = "discotte";
		TRP_CalculerListeEffets();
	elseif Effet == "sheath" then
		TRP2_TriggerEditFrameEffet.effetTab[#TRP2_TriggerEditFrameEffet.effetTab + 1] = "sheath";
		TRP_CalculerListeEffets();
	elseif Effet == "critter" then
		TRP2_TriggerEditFrameEffet.effetTab[#TRP2_TriggerEditFrameEffet.effetTab + 1] = "critter";
		TRP_CalculerListeEffets();
	elseif Effet == "docu" then
		TRP2_EffetDocumentLoad("DOC00001",#TRP2_TriggerEditFrameEffet.effetTab + 1);
	elseif Effet == "mascotte" then
		TRP2_EffetMascotteLoad("",#TRP2_TriggerEditFrameEffet.effetTab + 1);
	elseif Effet == "script" then
		TRP2_EffetScriptLoad("",#TRP2_TriggerEditFrameEffet.effetTab + 1);
	end
end

function TRP2_TableSwap(tab,pos,i)
	if tab and pos and i then
		local save = tab[pos];
		tremove(tab,pos);
		tinsert(tab,pos+i,save);
	end
end

function TRP2_ListerEffets(num)
	for k=1,5,1 do --Initialisation
		getglobal("TRP2_TriggerEditFrameEffetBouton"..k):Hide();
	end
	local i = 1;
	local j = 1;
	table.foreach(TRP2_TriggerEditFrameEffet.effetTab,
	function(TabIndex)
		if i > num*5 and i <= (num+1)*5 then
			local Effet = TRP2_TriggerEditFrameEffet.effetTab[TabIndex];
			local EffetTab = TRP2_FetchToTabWithSeparator(Effet,"$");
			if TRP2_EmptyToNil(Effet) then
				getglobal("TRP2_TriggerEditFrameEffetBouton"..j):Show();
				getglobal("TRP2_TriggerEditFrameEffetBouton"..j.."BoutonIcon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_LISTE_EFFETS[EffetTab[1]],"Icone","Temp.blp"));
				getglobal("TRP2_TriggerEditFrameEffetBouton"..j.."Nom"):SetText(TabIndex..") "..TRP2_GetWithDefaut(TRP2_LISTE_EFFETS[EffetTab[1]],"Titre",UNKNOWN));
				getglobal("TRP2_TriggerEditFrameEffetBouton"..j.."Bouton"):SetScript("OnClick", function(self,button)
					if IsShiftKeyDown() then
						if button == "LeftButton" and TabIndex ~= #TRP2_TriggerEditFrameEffet.effetTab then
							TRP2_TableSwap(TRP2_TriggerEditFrameEffet.effetTab,TabIndex,1);
							
						elseif button == "RightButton" and TabIndex ~= 1 then
							TRP2_TableSwap(TRP2_TriggerEditFrameEffet.effetTab,TabIndex,-1);
							
						end
						TRP_CalculerListeEffets();
					elseif button == "LeftButton" then
						if EffetTab[1] == "texte" then
							TRP2_EffetTexteLoad(EffetTab[2], EffetTab[3], TabIndex);
						elseif EffetTab[1] == "parole" then
							TRP2_EffetParoleLoad(EffetTab[2], EffetTab[3], TabIndex);
						elseif EffetTab[1] == "or" then
							TRP2_EffetOrLoad(EffetTab[2], EffetTab[3], EffetTab[4], TabIndex);
						elseif EffetTab[1] == "aura" then
							TRP2_EffetAuraLoad(EffetTab[2], EffetTab[3], EffetTab[4], EffetTab[5],EffetTab[6], TabIndex);
						elseif EffetTab[1] == "son" then
							TRP2_EffetSonLoad(EffetTab[2], EffetTab[3], EffetTab[4], TabIndex);
						elseif EffetTab[1] == "objet" then
							TRP2_EffetObjetLoad(EffetTab[2], EffetTab[3], EffetTab[4],EffetTab[5], TabIndex);
						elseif EffetTab[1] == "cool" then
							TRP2_EffetCoolLoad(EffetTab[2], EffetTab[3],EffetTab[4], TabIndex);
						elseif EffetTab[1] == "lifetime" then
							TRP2_EffetLifetimeLoad(EffetTab[2],EffetTab[3], TabIndex);
						elseif EffetTab[1] == "quest" then
							TRP2_EffetQuestLoad(EffetTab[2], EffetTab[3], EffetTab[4], TabIndex);
						elseif EffetTab[1] == "lang" then
							TRP2_EffetLangLoad(EffetTab[2], EffetTab[3], EffetTab[4], TabIndex);
						elseif EffetTab[1] == "durabilite" then
							TRP2_EffetDurabiliteLoad(EffetTab[2], EffetTab[3], EffetTab[4],EffetTab[5], TabIndex);
						elseif EffetTab[1] == "docu" then
							TRP2_EffetDocumentLoad(EffetTab[2], TabIndex);
						elseif EffetTab[1] == "mascotte" then
							TRP2_EffetMascotteLoad(EffetTab[2], TabIndex);
						elseif EffetTab[1] == "script" then
							StaticPopupDialogs["TRP2_GET_TEXT_NS"].text = TRP2_CTS(TRP2_ENTETE.."Here you can get your script back in order to copy it in the new script system.");
							TRP2_ShowStaticPopup("TRP2_GET_TEXT_NS",nil,nil,nil,nil,nil,nil,EffetTab[2]);
						else
							TRP2_Error(TRP2_LOC_NOEDITEFFET);
						end
					else
						StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_DELETEEFFET,TRP2_GetWithDefaut(TRP2_LISTE_EFFETS[EffetTab[1]],"Titre",UNKNOWN)));
						TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
							tremove(TRP2_TriggerEditFrameEffet.effetTab,TabIndex);
							
							TRP_CalculerListeEffets();
						end);
					end
				end);
				-- Calcul du tooltip
				local Message=TRP2_GetWithDefaut(TRP2_LISTE_EFFETS[EffetTab[1]],"Titre",UNKNOWN);
				local sousMessage="";
				if TRP2_LISTE_EFFETS[EffetTab[1]] then
					sousMessage = TRP2_LISTE_EFFETS[EffetTab[1]]["Explication"].."\n\n";
					sousMessage = sousMessage..TRP2_GetEffetTooltipArg(EffetTab);
					sousMessage = sousMessage.."\n\n{j}"..TRP2_LOC_CLIC.." {o}: "..TRP2_LOC_EDITEFFET.."\n{j}"..TRP2_LOC_CLICDROIT.." {o}: "..TRP2_LOC_DELETEEFFET;
					if TabIndex ~= #TRP2_TriggerEditFrameEffet.effetTab then
						sousMessage = sousMessage.."\n{j}"..TRP2_LOC_CLICMAJ.." {o}: "..TRP2_LOC_MoveDown;
					end
					if TabIndex ~= 1 then
						sousMessage = sousMessage.."\n{j}"..TRP2_LOC_CLICDROITMAJ.." {o}: "..TRP2_LOC_MoveUp;
					end
				end
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_TriggerEditFrameEffetBouton"..j.."Bouton"),
					getglobal("TRP2_TriggerEditFrameEffetBouton"..j.."Bouton"),
					"TOPLEFT",0,0,
					Message,
					sousMessage
				);
				j = j + 1;
			end
		end
		i = i + 1;
	end);
end

function TRP2_ListerConditions(num)
	for k=1,5,1 do --Initialisation
		getglobal("TRP2_TriggerEditFrameConditionBouton"..k):Hide();
	end
	local i = 1;
	local j = 1;
	table.foreach(TRP2_TriggerEditFrameCondition.condiTab,
	function(TabIndex)
		if i > num*5 and i <= (num+1)*5 then
			local Condition = TRP2_TriggerEditFrameCondition.condiTab[TabIndex];
			if TRP2_EmptyToNil(Condition) then
				local nom = TRP2_GetConditionName(Condition);
				getglobal("TRP2_TriggerEditFrameConditionBouton"..j):Show();
				getglobal("TRP2_TriggerEditFrameConditionBouton"..j.."BoutonIcon"):SetTexture("Interface\\ICONS\\"..TRP2_GetConditionIcone(Condition));
				if string.sub(Condition,1,1) == "-" then
					getglobal("TRP2_TriggerEditFrameConditionBouton"..j.."Nom"):SetText(TRP2_CTS(TabIndex..") {o}*{w}"..nom));
				else
					getglobal("TRP2_TriggerEditFrameConditionBouton"..j.."Nom"):SetText(TRP2_CTS(TabIndex..") {v}+{w}"..nom));
				end
				getglobal("TRP2_TriggerEditFrameConditionBouton"..j.."Bouton"):SetScript("OnClick", function(self,button)
					if IsShiftKeyDown() then
						if button == "LeftButton" and TabIndex ~= #TRP2_TriggerEditFrameCondition.condiTab then
							TRP2_TableSwap(TRP2_TriggerEditFrameCondition.condiTab,TabIndex,1);
							
						elseif button == "RightButton" and TabIndex ~= 1 then
							TRP2_TableSwap(TRP2_TriggerEditFrameCondition.condiTab,TabIndex,-1);
							
						end
						TRP_CalculerListeConditions();
					elseif IsControlKeyDown() then
						if string.sub(Condition,1,1) == "-" then
							TRP2_TriggerEditFrameCondition.condiTab[TabIndex] = string.sub(Condition,2);
						else
							TRP2_TriggerEditFrameCondition.condiTab[TabIndex] = "-"..Condition;
						end
						
						TRP_CalculerListeConditions();
					elseif button == "LeftButton" then
						TRP2_OpenCondiConstructor(Condition,TabIndex);
					else
						StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_DELETECONDI,nom));
						TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
							tremove(TRP2_TriggerEditFrameCondition.condiTab,TabIndex);
							TRP_CalculerListeConditions();
							
						end);
					end
				end);
				-- Calcul du tooltip
				local Message=nom;
				local sousMessage="";
				sousMessage = "\n{v}"..TRP2_LOC_CONDITESTE.." :\n{w}";
				sousMessage = sousMessage..TRP2_GetConditionString(Condition);
				sousMessage = sousMessage.."\n\n{j}"..TRP2_LOC_CLIC.." {o}: "..TRP2_LOC_CONDIEDIT.."\n{j}"..TRP2_LOC_CLICDROIT.." {o}: "..TRP2_LOC_CONDIDELETE;
				if string.sub(Condition,1,1) == "-" then
					sousMessage = sousMessage.."\n{j}"..TRP2_LOC_CLICCTRL.." {o}: "..TRP2_LOC_GOTOAND;
				else
					sousMessage = sousMessage.."\n{j}"..TRP2_LOC_CLICCTRL.." {o}: "..TRP2_LOC_GOTOOR;
				end
				if TabIndex ~= #TRP2_TriggerEditFrameCondition.condiTab then
					sousMessage = sousMessage.."\n{j}"..TRP2_LOC_CLICMAJ.." {o}: "..TRP2_LOC_MoveDown;
				end
				if TabIndex ~= 1 then
					sousMessage = sousMessage.."\n{j}"..TRP2_LOC_CLICDROITMAJ.." {o}: "..TRP2_LOC_MoveUp;
				end
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_TriggerEditFrameConditionBouton"..j.."Bouton"),
					getglobal("TRP2_TriggerEditFrameConditionBouton"..j.."Bouton"),
					"TOPLEFT",0,0,
					Message,
					sousMessage
				);
				j = j + 1;
			end
		end
		i = i + 1;
	end);
end

function TRP2_UpdateCondiBouton(bouton)
	local Titre;
	local SousTitre;
	Titre = "|TInterface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_LISTE_VALEURS[bouton.Condi],"Icone","Temp")..":35:35|t "..TRP2_GetWithDefaut(TRP2_LISTE_VALEURS[bouton.Condi],"Titre",UNKNOWN);
	SousTitre = TRP2_GetWithDefaut(TRP2_LISTE_VALEURS[bouton.Condi],"ExpliDetails",TRP2_LOC_ANOTHERCREAERROR);
	if TRP2_EmptyToNil(bouton.Arg) then
		local tab = TRP2_GetTabInfo(bouton.Arg);
		getglobal(bouton:GetName().."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(tab,"Icone","Temp"));
		SousTitre = SousTitre.."\n\n{o}"..TRP2_GetWithDefaut(TRP2_LISTE_VALEURS[bouton.Condi],"Argument","Argument").." :\n{w}".."|TInterface\\ICONS\\"..TRP2_GetWithDefaut(tab,"Icone","Temp")..":20:20|t "..TRP2_GetWithDefaut(tab,"Nom","{r}"..UNKNOWN);
	else
		getglobal(bouton:GetName().."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_LISTE_VALEURS[bouton.Condi],"Icone","Temp"));
	end
	TRP2_SetTooltipForFrame(bouton,bouton,"TOPLEFT",0,0,Titre,SousTitre);
end

function TRP2_UpdateCompaBouton(bouton)
	local Titre;
	local SousTitre;
	Titre = TRP2_GetWithDefaut(TRP2_LISTE_COMPA[bouton.Compa],"Titre",UNKNOWN);
	SousTitre = TRP2_GetWithDefaut(TRP2_LISTE_COMPA[bouton.Compa],"Explication",TRP2_LOC_ANOTHERCREAERROR2);
	getglobal(bouton:GetName().."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_LISTE_COMPA[bouton.Compa],"Icone","Temp.blp"));
	TRP2_SetTooltipForFrame(bouton,bouton,"TOPLEFT",0,0,Titre,SousTitre);
end

function TRP2_CondiConstructorUpdate()
	local numeric;

	if TRP2_LISTE_VALEURS[TRP2_CondiConstructorFrameArgGauche.Condi] and TRP2_LISTE_VALEURS[TRP2_CondiConstructorFrameArgGauche.Condi]["bNumeric"] then
		numeric = true;
	else
		numeric = false;
	end
	
	TRP2_CondiConstructorFrame.Numeric = numeric;
	
	if numeric then
		if TRP2_LISTE_VALEURS[TRP2_CondiConstructorFrameArgGauche.Condi] and not TRP2_LISTE_VALEURS[TRP2_CondiConstructorFrameArgGauche.Condi]["bNumeric"] then
			TRP2_CondiConstructorFrameArgGauche.Condi = "pv";
			TRP2_CondiConstructorFrameArgGauche.Arg = "";
		end
		if TRP2_LISTE_VALEURS[TRP2_CondiConstructorFrameArgDroite.Condi] and not TRP2_LISTE_VALEURS[TRP2_CondiConstructorFrameArgDroite.Condi]["bNumeric"] then
			TRP2_CondiConstructorFrameArgDroite.Condi = "pv";
			TRP2_CondiConstructorFrameArgDroite.Arg = "";
		end
		TRP2_CondiConstructorFrameNumeric:Show();
		TRP2_CondiConstructorFrameTextuelle:Hide();
	else
		if TRP2_LISTE_COMPA[TRP2_CondiConstructorFrameArgCompa.Compa]["bNumeric"] then
			TRP2_CondiConstructorFrameArgCompa.Compa = "==";
		end
		TRP2_CondiConstructorFrameNumeric:Hide();
		TRP2_CondiConstructorFrameTextuelle:Show();
	end
	
	local condiTemp = TRP2_GetConditionString(TRP2_CalculNewCondition());
	
	if numeric then
		condiTemp = "{v}"..TRP2_LOC_NUMCONDI.." :\n"..condiTemp;
	else
		condiTemp = "{v}"..TRP2_LOC_CONDI.." :\n"..condiTemp;
	end
	
	TRP2_CondiConstructorFrameApercu:SetText(TRP2_CTS(condiTemp));
end

function TRP2_CalculNewCondition()
	local numeric;
	if TRP2_LISTE_VALEURS[TRP2_CondiConstructorFrameArgGauche.Condi] and TRP2_LISTE_VALEURS[TRP2_CondiConstructorFrameArgGauche.Condi]["bNumeric"] then
		numeric = true;
	else
		numeric = false;
	end
	local condiTemp = TRP2_CondiConstructorFrameArgGauche.Condi;
	if TRP2_EmptyToNil(TRP2_CondiConstructorFrameArgGauche.Arg) then
		condiTemp = condiTemp.."("..TRP2_CondiConstructorFrameArgGauche.Arg..")";
	end
	condiTemp = condiTemp.."$"..TRP2_CondiConstructorFrameArgCompa.Compa.."$";
	if numeric then
		if TRP2_EmptyToNil(TRP2_CondiConstructorFrameNumeric:GetText()) then
			condiTemp = condiTemp..tonumber(TRP2_CondiConstructorFrameNumeric:GetText());
		else
			condiTemp = condiTemp..TRP2_CondiConstructorFrameArgDroite.Condi;
			if TRP2_EmptyToNil(TRP2_CondiConstructorFrameArgDroite.Arg) then
				condiTemp = condiTemp.."("..TRP2_CondiConstructorFrameArgDroite.Arg..")";
			end
		end
	elseif TRP2_EmptyToNil(TRP2_CondiConstructorFrameTextuelle:GetText()) then
		condiTemp = condiTemp.."\""..TRP2_CondiConstructorFrameTextuelle:GetText().."\"";
	else
		condiTemp = condiTemp..TRP2_CondiConstructorFrameArgDroite.Condi;
		if TRP2_EmptyToNil(TRP2_CondiConstructorFrameArgDroite.Arg) then
			condiTemp = condiTemp.."("..TRP2_CondiConstructorFrameArgDroite.Arg..")";
		end
	end
	return condiTemp;
end

function TRP2_OpenCondiConstructor(condition,index)
	
	TRP2_ListeSmall:Hide();
	
	local bOr = string.sub(condition,1,1) == "-";
	
	TRP2_CondiConstructorFrameArgCompa.Compa = "==";
	TRP2_CondiConstructorFrameNumeric:SetText("");
	TRP2_CondiConstructorFrameTextuelle:SetText("");
	TRP2_CondiConstructorFrameArgGauche.Condi = "name";
	TRP2_CondiConstructorFrameArgDroite.Condi = "namec";
	TRP2_CondiConstructorFrameArgGauche.Arg = "";
	TRP2_CondiConstructorFrameArgDroite.Arg = "";

	if string.match(condition,"%-?.+%$.+%$.+") then
		local membreGauche = string.match(condition,"%-?(.+)%$.+%$.+");
		local membreDroite = string.match(condition,"%-?.+%$.+%$(.+)");
		local comparator = string.match(condition,"%-?.+%$(.+)%$.+");
		
		TRP2_CondiConstructorFrameArgGauche.Condi = string.gsub(membreGauche,"(%(.*%))","");
		TRP2_CondiConstructorFrameArgGauche.Arg = string.match(membreGauche,"%((.*)%)");
		TRP2_CondiConstructorFrameArgCompa.Compa = comparator;
		
		--TRP2_debug("membreGauche : "..membreGauche);
		--TRP2_debug("membreDroite : "..membreDroite);
		--TRP2_debug("comparator : "..comparator);
		
		if string.match(membreDroite,"(%d+)") == membreDroite then
			TRP2_CondiConstructorFrameNumeric:SetText(membreDroite);
		elseif string.match(membreDroite,"(\".*\")") == membreDroite then
			TRP2_CondiConstructorFrameTextuelle:SetText(string.gsub(membreDroite,"\"",""));
		else
			TRP2_CondiConstructorFrameArgDroite.Condi = string.gsub(membreDroite,"(%(.*%))","");
			TRP2_CondiConstructorFrameArgDroite.Arg = string.match(membreDroite,"%((.*)%)");
		end
	end
	
	TRP2_CondiConstructorFrameSave:SetScript("OnClick", function()
		TRP2_TriggerEditFrameCondition.condiTab[index] = TRP2_CalculNewCondition();
		if bOr then
			TRP2_TriggerEditFrameCondition.condiTab[index] = "-"..TRP2_TriggerEditFrameCondition.condiTab[index];
		end
		TRP2_CondiConstructorFrame:Hide();
		TRP_CalculerListeConditions();
		
	end);

	TRP2_CondiConstructorUpdate();
	TRP2_CondiConstructorFrame:Show();
end

function TRP2_DD_MenuCompa(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = "Liste des comparaisons";
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	
	local i;
	table.foreach(TRP2_LISTE_COMPA, function(compa)
		info = TRP2_CreateSimpleDDButton();
		if TRP2_LISTE_COMPA[compa]["bNumeric"] then
			info.text = TRP2_CTS(TRP2_LISTE_COMPA[compa]["Titre"].." {o}("..TRP2_LOC_NUMERIC..")");
		else
			info.text = TRP2_LISTE_COMPA[compa]["Titre"]
		end
		if not TRP2_CondiConstructorFrame.Numeric and TRP2_LISTE_COMPA[compa]["bNumeric"] then
			info.disabled = true;
		end
		info.func = function() 
			TRP2_CondiConstructorFrameArgCompa.Compa = compa;
		end;
		UIDropDownMenu_AddButton(info,level);
	end)
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_GetConditionName(condition)
	if string.match(condition,"%-?.+%$.+%$.+") then
		local membreGauche = string.match(condition,"%-?(.+)%$.+%$.+");
		membreGauche = string.gsub(membreGauche,"(%(.*%))","");
		if TRP2_LISTE_VALEURS[membreGauche] then
			return TRP2_LISTE_VALEURS[membreGauche]["Titre"];
		end
		return UNKNOWN;
	else
		return "Syntax error";
	end
end

function TRP2_GetConditionIcone(condition)
	if string.match(condition,"%-?.+%$.+%$.+") then
		local membreGauche = string.match(condition,"%-?(.+)%$.+%$.+");
		membreGauche = string.gsub(membreGauche,"(%(.*%))","");
		if TRP2_LISTE_VALEURS[membreGauche] then
			return TRP2_LISTE_VALEURS[membreGauche]["Icone"];
		end
	end
	return "Temp";
end

function TRP2_GetConditionString(condition)
	if string.match(condition,"%-?.+%$.+%$.+") then
		local message = "";
		local membreGauche = string.match(condition,"%-?(.+)%$.+%$.+");
		local membreDroite = string.match(condition,"%-?.+%$.+%$(.+)");
		local comparator = string.match(condition,"%-?.+%$(.+)%$.+");
		
		local argGauche = string.match(membreGauche,"%((.*)%)");
		local argDroite = string.match(membreDroite,"%((.*)%)");
		
		membreGauche = string.gsub(membreGauche,"(%(.*%))","");
		membreDroite = string.gsub(membreDroite,"(%(.*%))","");
		
		
		if TRP2_LISTE_VALEURS[membreGauche] then
			message = "{o}"..TRP2_LISTE_VALEURS[membreGauche]["Explication"];
		else
			message = "{o}"..UNKNOWN.." : "..membreGauche.."'";
		end
		
		if TRP2_EmptyToNil(argGauche) then
			local tab = TRP2_GetTabInfo(argGauche);
			message = message.." {o}(".."|TInterface\\ICONS\\"..TRP2_GetWithDefaut(tab,"Icone","Temp")..":20:20|t ".." {j}"..TRP2_GetWithDefaut(tab,"Nom","{r}"..UNKNOWN).."{o} )";
		end
		
		if TRP2_LISTE_COMPA[comparator] then
			message = message.." {w}"..TRP2_LISTE_COMPA[comparator]["Titre"];
		else
			message = message.." {w}"..UNKNOWN.." : '"..comparator.."'";
		end
		
		if string.match(membreDroite,"%d+") == membreDroite then
			message = message.." {v}"..membreDroite;
		elseif string.match(membreDroite,"\".+\"") == membreDroite then
			message = message.." {c}"..membreDroite;
		elseif TRP2_LISTE_VALEURS[membreDroite] then
			message = message.." {o}"..TRP2_LISTE_VALEURS[membreDroite]["Explication"];
		else
			message = message.." {r}"..UNKNOWN.." : '"..membreDroite.."'";
		end
		
		if TRP2_EmptyToNil(argDroite) then
			local tab = TRP2_GetTabInfo(argDroite);
			message = message.." {o}(".."|TInterface\\ICONS\\"..TRP2_GetWithDefaut(tab,"Icone","Temp")..":20:20|t ".." {j}"..TRP2_GetWithDefaut(tab,"Nom","{r}"..UNKNOWN).."{o} )";
		end
		
		return message;
	else
		return "Erreur synthaxe !";
	end
end
