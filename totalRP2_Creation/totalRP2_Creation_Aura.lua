-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

function TRP2_ChargerCreaAuraPanel(AuraID)
	local AuraTab = TRP2_GetAuraInfo(AuraID);
	local titre = TRP2_LOC_CREA_AURA.." : "..TRP2_GetWithDefaut(AuraTab,"Nom",TRP2_LOC_NewAura);
	if TRP2_CanWrite(AuraTab,AuraID) then
		titre = titre.." {j}("..TRP2_LOC_Edition..")";
		TRP2_CreationFrameAuraFrameMenuSave:Enable();
		TRP2_CreationFrameAuraFrameFlagsWriteLock:Enable();
		TRP2_CreationFrameAuraFrameFlagsWriteLock.disabled = nil;
	else
		titre = titre.." {v}("..TRP2_LOC_Consulte..")";
		TRP2_CreationFrameAuraFrameMenuSave:Disable();
		TRP2_CreationFrameAuraFrameFlagsWriteLock:Disable();
		TRP2_CreationFrameAuraFrameFlagsWriteLock.disabled = 1;
	end
	TRP2_CreationFrameHeaderTitle:SetText(TRP2_CTS(titre));
	TRP2_CreationFrameAuraFrameTriggerOnReceive.Effets = TRP2_GetWithDefaut(AuraTab,"OnReceiveEffet","");
	TRP2_CreationFrameAuraFrameTriggerOnReceive.Conditions = TRP2_GetWithDefaut(AuraTab,"OnReceiveCondi","");
	TRP2_CreationFrameAuraFrameTriggerOnReceive.Scripts = TRP2_GetWithDefaut(AuraTab,"OnReceiveScripts");
	
	TRP2_CreationFrameAuraFrameTriggerOnDestroy.Effets = TRP2_GetWithDefaut(AuraTab,"OnDestroyEffet","");
	TRP2_CreationFrameAuraFrameTriggerOnDestroy.Conditions = TRP2_GetWithDefaut(AuraTab,"OnDestroyCondi","");
	TRP2_CreationFrameAuraFrameTriggerOnDestroy.Scripts = TRP2_GetWithDefaut(AuraTab,"OnDestroyScripts");
	
	TRP2_CreationFrameAuraFrameTriggerOnLifeTime.Effets = TRP2_GetWithDefaut(AuraTab,"OnLifeTimeEffet","");
	TRP2_CreationFrameAuraFrameTriggerOnLifeTime.Conditions = TRP2_GetWithDefaut(AuraTab,"OnLifeTimeCondi","");
	TRP2_CreationFrameAuraFrameTriggerOnLifeTime.Scripts = TRP2_GetWithDefaut(AuraTab,"OnLifeTimeScripts");
	
	TRP2_CreationFrameAuraFrameTriggerOnUpdate.Effets = TRP2_GetWithDefaut(AuraTab,"OnUpdateEffet","");
	TRP2_CreationFrameAuraFrameTriggerOnUpdate.Conditions = TRP2_GetWithDefaut(AuraTab,"OnUpdateCondi","");
	TRP2_CreationFrameAuraFrameTriggerOnUpdate.Scripts = TRP2_GetWithDefaut(AuraTab,"OnUpdateScripts");
	
	TRP2_CreationFrameAuraFrameGeneralNom:SetText(TRP2_GetWithDefaut(AuraTab,"Nom",TRP2_LOC_NewAura));
	TRP2_CreationFrameAuraFrameGeneralDureeDefaut:SetText(TRP2_GetWithDefaut(AuraTab,"DureeDefaut",0));
	TRP2_CreationFrameAuraFrameGeneralDescriptionScrollEditBox:SetText(TRP2_GetWithDefaut(AuraTab,"Description",""));
	TRP2_CreationFrameAuraFrameGeneralType:SetValue(TRP2_GetInt(TRP2_GetWithDefaut(AuraTab,"Type",2)));
	TRP2_CreationFrameAuraFrameGeneralIconeIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(AuraTab,"Icone","Temp.blp"));
	TRP2_CreationFrameAuraFrameGeneralIcone.icone = TRP2_GetWithDefaut(AuraTab,"Icone","Temp.blp");
	TRP2_CreationFrameAuraFrameFlagsWriteLock:SetChecked(TRP2_GetWithDefaut(AuraTab,"bWriteLock",1));
	TRP2_CreationFrameAuraFrameFlagsDeletable:SetChecked(TRP2_GetWithDefaut(AuraTab,"bDeletable",1));
	TRP2_CreationFrameAuraFrameFlagsTimeSet:SetChecked(TRP2_GetWithDefaut(AuraTab,"TimeSet"));
	TRP2_CreationFrameAuraFrameFlagsAjoutable:SetChecked(TRP2_GetWithDefaut(AuraTab,"bAjout",1));
	TRP2_CreationFrameAuraFrameGeneralCategorie:SetValue(TRP2_GetInt(tonumber(TRP2_GetWithDefaut(AuraTab,"EtatCat",2))));
	TRP2_CreationFrameAuraFrameInfoID:SetText(TRP2_CTS("{o}ID : {w}"..AuraID));
	TRP2_CreationFrameAuraFrameInfoCreateur:SetText(TRP2_CTS("{o}"..TRP2_LOC_CREATOR.." : {w}"..TRP2_GetWithDefaut(AuraTab,"Createur",TRP2_Joueur)));
	TRP2_CreationFrameAuraFrameInfoVernum:SetText(TRP2_CTS("{o}"..GAME_VERSION_LABEL.." : {w}"..TRP2_GetWithDefaut(AuraTab,"VerNum",1)));
	TRP2_CreationFrameAuraFrameInfoDate:SetText(TRP2_CTS("{o}"..TRP2_LOC_LASTDATE.." : {w}"..TRP2_GetWithDefaut(AuraTab,"Date",date("%d/%m/%y, %H:%M:%S"))));
	TRP2_CreationFrameAura.ID = AuraID;
	TRP2_PanelCreationAuraOnUpdate();
	TRP2_CreationFrameAura:Show();
end

function TRP2_PanelCreationAuraOnUpdate()
	local TestTab = {};
	
	TestTab["OnUpdate"] = true;
	TestTab["OnReceive"] = true;
	TestTab["OnLifeTime"] = true;
	TestTab["OnDestroy"] = true;
	
	table.foreach(TestTab,function(trigger)
		getglobal("TRP2_CreationFrameAuraFrameTrigger"..trigger.."Icon"):SetDesaturated(false);
		getglobal("TRP2_CreationFrameAuraFrameTrigger"..trigger):Enable();
		if TRP2_EmptyToNil(getglobal("TRP2_CreationFrameAuraFrameTrigger"..trigger).Effets) then
			getglobal("TRP2_CreationFrameAuraFrameTrigger"..trigger.."Texte"):SetTextColor(0,1,0);
			getglobal("TRP2_CreationFrameAuraFrameTrigger"..trigger.."Icon"):SetTexture("Interface\\ICONS\\INV_Torch_Thrown.blp");
		else
			getglobal("TRP2_CreationFrameAuraFrameTrigger"..trigger.."Texte"):SetTextColor(1,0.75,0);
			getglobal("TRP2_CreationFrameAuraFrameTrigger"..trigger.."Icon"):SetTexture("Interface\\ICONS\\INV_Torch_Lit.blp");
		end
	end);
	
	local AuraTab = TRP2_CreateAuraTabCreation();
	
	if TRP2_GetWithDefaut(AuraTab,"bAjout",true) then
		TRP2_CreationFrameAuraFrameFlagsTimeSet.disabled = nil;
		TRP2_CreationFrameAuraFrameFlagsTimeSet:Enable();
		if TRP2_GetWithDefaut(AuraTab,"TimeSet",false) then
			TRP2_CreationFrameAuraFrameGeneralDureeDefaut.disabled = true;
		else
			TRP2_CreationFrameAuraFrameGeneralDureeDefaut.disabled = nil;
		end
	else
		TRP2_CreationFrameAuraFrameFlagsTimeSet.disabled = 1;
		TRP2_CreationFrameAuraFrameFlagsTimeSet:Disable();
		TRP2_CreationFrameAuraFrameFlagsTimeSet:SetChecked(false);
		TRP2_CreationFrameAuraFrameGeneralDureeDefaut.disabled = true;
	end
	_G["TRP2_CreationFrameAuraFrameMenuApercuIcon"]:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(AuraTab,"Icone","Temp"));
end

TRP2_Auras_Categorie = {
	"Tous", -- 1
	"Personnel", -- 2
	"Quête", -- 3
	"Odeur", -- 4
	"Comportement", -- 5
	"Humeur/émotion", -- 6
	"Blessure/handicap", -- 7
	"Maladie", -- 8
	"Malédiction", -- 9
	"Magie", -- 10
	"Apparence", -- 11
	"Équipement", -- 12
	"Action", -- 13
	"Aura", -- 14
	"Poison", -- 15
	"Symptôme", -- 16
}

function TRP2_SetAuraApercuTooltip(bouton,ID)
	local objet = TRP2_CreateAuraTabCreation();
	local Titre;
	local Message = "{v}< "..TRP2_Auras_Categorie[TRP2_GetInt(tonumber(TRP2_GetWithDefaut(objet,"EtatCat",2)))].." >\n";
	if TRP2_EmptyToNil(TRP2_GetWithDefaut(objet,"Description","")) then
		Message = Message.."{w}\"{o}"..TRP2_GetWithDefaut(objet,"Description","").."{w}\"";
	end
	if TRP2_GetWithDefaut(objet,"DureeDefaut",0) ~= 0 then
		Message = Message.."\n{w}"..TIME_REMAINING.." {o}"..TRP2_TimeToString(TRP2_GetWithDefaut(objet,"DureeDefaut",0));
	end
	Titre = TRP2_Auras_Color[TRP2_GetInt(TRP2_GetWithDefaut(objet,"Type",2))].."|TInterface\\ICONS\\"..TRP2_GetWithDefaut(objet,"Icone","Temp")..":30:30|t "..TRP2_GetWithDefaut(objet,"Nom",TRP2_LOC_NewAura);
	TRP2_SetTooltipForFrame(bouton,bouton,"RIGHT",-5,-5,
		Titre,
		Message
	);
	TRP2_RefreshTooltipForFrame(bouton);
end

function TRP2_CreateAuraTabCreation()
	local objet = {};
	-- Enregistrement des triggers/conditions
	objet["OnDestroyEffet"] = TRP2_EmptyToNil(TRP2_CreationFrameAuraFrameTriggerOnDestroy.Effets);
	objet["OnDestroyCondi"] = TRP2_EmptyToNil(TRP2_CreationFrameAuraFrameTriggerOnDestroy.Conditions);
	objet["OnDestroyScripts"] = TRP2_EmptyToNil(TRP2_CreationFrameAuraFrameTriggerOnDestroy.Scripts);
	objet["OnUpdateEffet"] = TRP2_EmptyToNil(TRP2_CreationFrameAuraFrameTriggerOnUpdate.Effets);
	objet["OnUpdateCondi"] = TRP2_EmptyToNil(TRP2_CreationFrameAuraFrameTriggerOnUpdate.Conditions);
	objet["OnUpdateScripts"] = TRP2_EmptyToNil(TRP2_CreationFrameAuraFrameTriggerOnUpdate.Scripts);
	objet["OnReceiveEffet"] = TRP2_EmptyToNil(TRP2_CreationFrameAuraFrameTriggerOnReceive.Effets);
	objet["OnReceiveCondi"] = TRP2_EmptyToNil(TRP2_CreationFrameAuraFrameTriggerOnReceive.Conditions);
	objet["OnReceiveScripts"] = TRP2_EmptyToNil(TRP2_CreationFrameAuraFrameTriggerOnReceive.Scripts);
	objet["OnLifeTimeEffet"] = TRP2_EmptyToNil(TRP2_CreationFrameAuraFrameTriggerOnLifeTime.Effets);
	objet["OnLifeTimeCondi"] = TRP2_EmptyToNil(TRP2_CreationFrameAuraFrameTriggerOnLifeTime.Conditions);
	objet["OnLifeTimeScripts"] = TRP2_EmptyToNil(TRP2_CreationFrameAuraFrameTriggerOnLifeTime.Scripts);
	-- Enregistrement des flags
	objet["bWriteLock"] = TRP2_DefautToNil(TRP2_CreationFrameAuraFrameFlagsWriteLock:GetChecked() == 1,true);
	objet["bDeletable"] = TRP2_DefautToNil(TRP2_CreationFrameAuraFrameFlagsDeletable:GetChecked() == 1,true);
	objet["TimeSet"] = TRP2_DefautToNil(TRP2_CreationFrameAuraFrameFlagsTimeSet:GetChecked() == 1,false);
	objet["bAjout"] = TRP2_DefautToNil(TRP2_CreationFrameAuraFrameFlagsAjoutable:GetChecked() == 1,true);
	-- Enregistrement General
	objet["Type"] = TRP2_DefautToNil(TRP2_CreationFrameAuraFrameGeneralType:GetValue()),2;
	objet["Nom"] = TRP2_CTS(TRP2_EmptyToNil(TRP2_CreationFrameAuraFrameGeneralNom:GetText()),true);
	objet["Description"] = TRP2_EmptyToNil(TRP2_CreationFrameAuraFrameGeneralDescriptionScrollEditBox:GetText());
	objet["DureeDefaut"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameAuraFrameGeneralDureeDefaut:GetText()),0);
	objet["Icone"] = TRP2_DefautToNil(TRP2_EmptyToNil(TRP2_CreationFrameAuraFrameGeneralIcone.icone),"Temp");
	objet["EtatCat"] = TRP2_GetInt(TRP2_DefautToNil(TRP2_CreationFrameAuraFrameGeneralCategorie:GetValue(),2));
	
	return objet;
end

function TRP2_AuraSave(ID)
	local objet = TRP2_CreateAuraTabCreation();
	-- Ici t'aura un check
	objet["Createur"] = TRP2_GetWithDefaut(TRP2_Module_Auras[ID],"Createur",TRP2_Joueur);
	objet["Date"] = date("%d/%m/%y, %H:%M:%S").." "..TRP2_LOC_By.." "..TRP2_Joueur;
	if TRP2_GetWithDefaut(TRP2_Module_Auras[ID],"VerNum",1) < 10000 then
		objet["VerNum"] = TRP2_GetWithDefaut(TRP2_Module_Auras[ID],"VerNum",1) + 1;
	end
	if TRP2_Module_Auras[ID] then
		wipe(TRP2_Module_Auras[ID]);
	else
		TRP2_Module_Auras[ID] = {};
	end
	TRP2_tcopy(TRP2_Module_Auras[ID], objet);
	TRP2_Afficher(TRP2_FT(TRP2_LOC_CREA_AURA_SAVE,TRP2_GetWithDefaut(TRP2_Module_Auras[ID],"Nom",TRP2_LOC_NewAura)));
	TRP2_ChargerCreaAuraPanel(ID);
	if TRP2_GetInfo(TRP2_Joueur,"AurasTab",{})[ID] then -- Si on a actuellement cet aura
		TRP2_IncreaseVerNumAura();
	end
end

function TRP2_AuraSaveAs()
	local IDnew = TRP2_CreateNewEmpty("Aura");
	TRP2_AuraSave(IDnew);
	TRP2_ChargerCreaAuraPanel(IDnew);
end

function TRP2_EpurerAuraList()
	StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_ENTETE.."{v}"..TRP2_LOC_EPURETATPre.."\n\n{w}"..TRP2_LOC_EPURETAT);
	TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
		local num=0;
		for k,_ in pairs(TRP2_Module_Interface["BannedID"]) do
			if string.sub(k,1,3) == "AUR" and TRP2_Module_Auras[k] then
				wipe(TRP2_Module_Auras[k]);
				TRP2_Module_Auras[k] = nil;
				num = num + 1;
			end
		end
		TRP2_ListerAura();
		if num > 0 then
			TRP2_Afficher(TRP2_FT(TRP2_LOC_EPURETAT2,num));
		else
			TRP2_Afficher(TRP2_LOC_EPURETAT3);
		end
	end);
end
