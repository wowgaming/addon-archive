-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

function TRP2_ChargerCreaObjetPanel(ObjetID)
	TRP2_NPCAnimSelectFrame:Hide();
	local ObjetTab = TRP2_GetObjectTab(ObjetID);
	local titre = TRP2_LOC_CREA_OBJET.." : "..TRP2_GetNameWithQuality(ObjetTab);
	if TRP2_CanWrite(ObjetTab,ObjetID) then
		titre = titre.." {j}("..TRP2_LOC_Edition..")";
		TRP2_CreationFrameObjetFrameMenuSave:Enable();
		TRP2_CreationFrameObjetFrameFlagsWriteLock:Enable();
		TRP2_CreationFrameObjetFrameFlagsWriteLock.disabled = nil;
	else
		titre = titre.." {v}("..TRP2_LOC_Consulte..")";
		TRP2_CreationFrameObjetFrameMenuSave:Disable();
		TRP2_CreationFrameObjetFrameFlagsWriteLock:Disable();
		TRP2_CreationFrameObjetFrameFlagsWriteLock.disabled = 1;
	end
	TRP2_CreationFrameHeaderTitle:SetText(TRP2_CTS(titre));
	
	TRP2_CreationFrameObjetFrameTriggerOnCooldown.Effets = TRP2_GetWithDefaut(ObjetTab,"OnCooldownEffet","");
	TRP2_CreationFrameObjetFrameTriggerOnCooldown.Conditions = TRP2_GetWithDefaut(ObjetTab,"OnCooldownCondi","");
	TRP2_CreationFrameObjetFrameTriggerOnCooldown.Scripts = TRP2_GetWithDefaut(ObjetTab,"OnCooldownScripts");
	
	TRP2_CreationFrameObjetFrameTriggerOnTimeout.Effets = TRP2_GetWithDefaut(ObjetTab,"OnTimeoutEffet","");
	TRP2_CreationFrameObjetFrameTriggerOnTimeout.Conditions = TRP2_GetWithDefaut(ObjetTab,"OnTimeoutCondi","");
	TRP2_CreationFrameObjetFrameTriggerOnTimeout.Scripts = TRP2_GetWithDefaut(ObjetTab,"OnTimeoutScripts");
	
	TRP2_CreationFrameObjetFrameTriggerOnUsed.Effets = TRP2_GetWithDefaut(ObjetTab,"OnUsedEffet","");
	TRP2_CreationFrameObjetFrameTriggerOnUsed.Conditions = TRP2_GetWithDefaut(ObjetTab,"OnUsedCondi","");
	TRP2_CreationFrameObjetFrameTriggerOnUsed.Scripts = TRP2_GetWithDefaut(ObjetTab,"OnUsedScripts");
	
	TRP2_CreationFrameObjetFrameTriggerOnUseEndFail.Effets = TRP2_GetWithDefaut(ObjetTab,"OnUseEndFailEffet","");
	TRP2_CreationFrameObjetFrameTriggerOnUseEndFail.Conditions = TRP2_GetWithDefaut(ObjetTab,"OnUseEndFailCondi","");
	TRP2_CreationFrameObjetFrameTriggerOnUseEndFail.Scripts = TRP2_GetWithDefaut(ObjetTab,"OnUseEndFailScripts");
	
	TRP2_CreationFrameObjetFrameTriggerOnUseEnd.Effets = TRP2_GetWithDefaut(ObjetTab,"OnUseEndEffet","");
	TRP2_CreationFrameObjetFrameTriggerOnUseEnd.Conditions = TRP2_GetWithDefaut(ObjetTab,"OnUseEndCondi","");
	TRP2_CreationFrameObjetFrameTriggerOnUseEnd.Scripts = TRP2_GetWithDefaut(ObjetTab,"OnUseEndScripts");
	
	TRP2_CreationFrameObjetFrameTriggerOnUseStartFail.Effets = TRP2_GetWithDefaut(ObjetTab,"OnUseStartFailEffet","");
	TRP2_CreationFrameObjetFrameTriggerOnUseStartFail.Conditions = TRP2_GetWithDefaut(ObjetTab,"OnUseStartFailCondi","");
	TRP2_CreationFrameObjetFrameTriggerOnUseStartFail.Scripts = TRP2_GetWithDefaut(ObjetTab,"OnUseStartFailScripts");
	
	TRP2_CreationFrameObjetFrameTriggerOnReceive.Effets = TRP2_GetWithDefaut(ObjetTab,"OnReceiveEffet","");
	TRP2_CreationFrameObjetFrameTriggerOnReceive.Conditions = TRP2_GetWithDefaut(ObjetTab,"OnReceiveCondi","");
	TRP2_CreationFrameObjetFrameTriggerOnReceive.Scripts = TRP2_GetWithDefaut(ObjetTab,"OnReceiveScripts");
	
	TRP2_CreationFrameObjetFrameTriggerOnDestroy.Effets = TRP2_GetWithDefaut(ObjetTab,"OnDestroyEffet","");
	TRP2_CreationFrameObjetFrameTriggerOnDestroy.Conditions = TRP2_GetWithDefaut(ObjetTab,"OnDestroyCondi","");
	TRP2_CreationFrameObjetFrameTriggerOnDestroy.Scripts = TRP2_GetWithDefaut(ObjetTab,"OnDestroyScripts");
	
	TRP2_CreationFrameObjetFrameTriggerOnUseStart.Effets = TRP2_GetWithDefaut(ObjetTab,"OnUseStartEffet","");
	TRP2_CreationFrameObjetFrameTriggerOnUseStart.Conditions = TRP2_GetWithDefaut(ObjetTab,"OnUseStartCondi","");
	TRP2_CreationFrameObjetFrameTriggerOnUseStart.Scripts = TRP2_GetWithDefaut(ObjetTab,"OnUseStartScripts");
	
	TRP2_CreationFrameObjetFrameGeneralNom:SetText(TRP2_GetWithDefaut(ObjetTab,"Nom",TRP2_LOC_NEW_Objet));
	TRP2_CreationFrameObjetFrameGeneralCategorie:SetText(TRP2_GetWithDefaut(ObjetTab,"Categorie",""));
	TRP2_CreationFrameObjetFrameGeneralDescriptionScrollEditBox:SetText(TRP2_GetWithDefaut(ObjetTab,"Description",""));
	TRP2_CreationFrameObjetFrameGeneralUnique:SetText(TRP2_GetWithDefaut(ObjetTab,"Unique",0));
	TRP2_CreationFrameObjetFrameGeneralPoids:SetText(TRP2_GetWithDefaut(ObjetTab,"Poids",0));
	TRP2_CreationFrameObjetFrameGeneralLifetime:SetText(TRP2_GetWithDefaut(ObjetTab,"Lifetime",0));
	TRP2_CreationFrameObjetFrameGeneralValeur:SetText(TRP2_GetWithDefaut(ObjetTab,"Valeur",0));
	TRP2_CreationFrameObjetFrameGeneralQualite:SetValue(TRP2_GetWithDefaut(ObjetTab,"Qualite",1));
	TRP2_CreationFrameObjetFrameGeneralIconeIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(ObjetTab,"Icone","Temp"));
	TRP2_CreationFrameObjetFrameGeneralIcone.icone = TRP2_GetWithDefaut(ObjetTab,"Icone","Temp");
	TRP2_CreationFrameObjetFrameGeneralStack:SetText(TRP2_GetWithDefaut(ObjetTab,"MaxStack",1));
	TRP2_CreationFrameObjetFrameUtilisationCharge:SetText(TRP2_GetWithDefaut(ObjetTab,"Charges",0));
	TRP2_CreationFrameObjetFrameUtilisationTooltip:SetText(TRP2_GetWithDefaut(ObjetTab,"TooltipUse",""));
	TRP2_CreationFrameObjetFrameUtilisationCooldown:SetText(TRP2_GetWithDefaut(ObjetTab,"Cooldown",0));
	TRP2_CreationFrameObjetFrameUtilisationDuree:SetText(TRP2_GetWithDefaut(ObjetTab,"DureeAnim",0));
	TRP2_CreationFrameObjetFrameUtilisationAnim:SetText(TRP2_GetWithDefaut(ObjetTab,"Anim",0));
	TRP2_CreationFrameObjetFrameUtilisationAction:SetText(TRP2_GetWithDefaut(ObjetTab,"TexteAnim",""));
	TRP2_CreationFrameObjetFrameFlagsWriteLock:SetChecked(TRP2_GetWithDefaut(ObjetTab,"bWriteLock",1));
	TRP2_CreationFrameObjetFrameFlagsStealable:SetChecked(TRP2_GetWithDefaut(ObjetTab,"bImmobile"));
	TRP2_CreationFrameObjetFrameFlagsUsable:SetChecked(TRP2_GetWithDefaut(ObjetTab,"bUtilisable"));
	TRP2_CreationFrameObjetFrameFlagsGivable:SetChecked(TRP2_GetWithDefaut(ObjetTab,"bGivable",1));
	TRP2_CreationFrameObjetFrameFlagsDestroyable:SetChecked(TRP2_GetWithDefaut(ObjetTab,"bDestroyable",1));
	TRP2_CreationFrameObjetFrameFlagsManual:SetChecked(TRP2_GetWithDefaut(ObjetTab,"bManual",1));
	TRP2_CreationFrameObjetFrameFlagsQuest:SetChecked(TRP2_GetWithDefaut(ObjetTab,"bQuest",0));
	TRP2_CreationFrameObjetFrameInfoID:SetText(TRP2_CTS("{o}ID : {w}"..ObjetID));
	TRP2_CreationFrameObjetFrameInfoCreateur:SetText(TRP2_CTS("{o}"..TRP2_LOC_CREATOR.." : {w}"..TRP2_GetWithDefaut(ObjetTab,"Createur",TRP2_Joueur)));
	TRP2_CreationFrameObjetFrameInfoVernum:SetText(TRP2_CTS("{o}"..GAME_VERSION_LABEL.." : {w}"..TRP2_GetWithDefaut(ObjetTab,"VerNum",1)));
	TRP2_CreationFrameObjetFrameInfoDate:SetText(TRP2_CTS("{o}"..TRP2_LOC_LASTDATE.." : {w}"..TRP2_GetWithDefaut(ObjetTab,"Date",date("%d/%m/%y, %H:%M:%S"))));
	
	local Composants = TRP2_GetCompoTab(TRP2_GetWithDefaut(ObjetTab,"Composants",""));
	local Outils = TRP2_GetCompoTab(TRP2_GetWithDefaut(ObjetTab,"Outils",""));
	
	for i=1,10,1 do
		if TRP2_EmptyToNil(Composants[(i*2)-1]) then
			local ObjTab = TRP2_GetObjectTab(Composants[(i*2)-1]);
			_G["TRP2_ComposantBouton"..i].Arg = Composants[(i*2)-1];
			_G["TRP2_ComposantBouton"..i.."Icon"]:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(ObjTab,"Icone","Temp"));
			_G["TRP2_ComposantBouton"..i.."Icon"]:SetDesaturated(false);
			_G["TRP2_ComposantBouton"..i.."Qte"]:SetText(TRP2_NilToDefaut(TRP2_EmptyToNil(Composants[(i*2)]),1));
		else
			_G["TRP2_ComposantBouton"..i].Arg = nil;
			_G["TRP2_ComposantBouton"..i.."Icon"]:SetTexture("Interface\\ICONS\\Temp");
			_G["TRP2_ComposantBouton"..i.."Icon"]:SetDesaturated(true);
			_G["TRP2_ComposantBouton"..i.."Qte"]:SetText(1);
		end
	end
	for i=1,5,1 do
		if TRP2_EmptyToNil(Outils[(i*2)-1]) then
			local ObjTab = TRP2_GetObjectTab(Outils[(i*2)-1]);
			_G["TRP2_OutilBouton"..i].Arg = Outils[(i*2)-1];
			_G["TRP2_OutilBouton"..i.."Icon"]:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(ObjTab,"Icone","Temp"));
			_G["TRP2_OutilBouton"..i.."Icon"]:SetDesaturated(false);
			_G["TRP2_OutilBouton"..i.."Qte"]:SetText(TRP2_NilToDefaut(TRP2_EmptyToNil(Outils[(i*2)]),1));
		else
			_G["TRP2_OutilBouton"..i].Arg = nil
			_G["TRP2_OutilBouton"..i.."Icon"]:SetTexture("Interface\\ICONS\\Temp");
			_G["TRP2_OutilBouton"..i.."Icon"]:SetDesaturated(true);
			_G["TRP2_OutilBouton"..i.."Qte"]:SetText(1);
		end
	end
	
	TRP2_CreationFrameObjet.ID = ObjetID;
	TRP2_PanelCreationOnUpdate();
	TRP2_CreationFrameObjet:Show();
end

function TRP2_GetCompoTab(myString)
	return TRP2_FetchToTabWithSeparator(myString," ");
end

function TRP2_PanelCreationOnUpdate()
	local TestTab = {};
	local ObjetTab = TRP2_CreateObjetTabCreation();

	if TRP2_GetWithDefaut(ObjetTab,"Lifetime",0) > 0 or (TRP2_GetWithDefaut(ObjetTab,"bUtilisable",false) and TRP2_GetWithDefaut(ObjetTab,"Charges",0) > 1) then
		TRP2_CreationFrameObjetFrameGeneralStack.disabled = 1;
	else
		TRP2_CreationFrameObjetFrameGeneralStack.disabled = nil;
	end
	
	for i=1,10,1 do
		if TRP2_GetWithDefaut(ObjetTab,"bUtilisable",false) then
			getglobal("TRP2_ComposantBouton"..i):Enable();
			getglobal("TRP2_ComposantBouton"..i.."Qte").disabled = nil;
		else
			getglobal("TRP2_ComposantBouton"..i):Disable();
			getglobal("TRP2_ComposantBouton"..i.."Qte").disabled = true;
		end
	end
	for i=1,5,1 do
		if TRP2_GetWithDefaut(ObjetTab,"bUtilisable",false) then
			getglobal("TRP2_OutilBouton"..i):Enable();
			getglobal("TRP2_OutilBouton"..i.."Qte").disabled = nil;
		else
			getglobal("TRP2_OutilBouton"..i.."Qte").disabled = true;
			getglobal("TRP2_OutilBouton"..i):Disable();
		end
	end
	
	if TRP2_GetWithDefaut(ObjetTab,"bUtilisable",false) then
		TRP2_CreationFrameObjetFrameUtilisationDuree.disabled = nil;
		TRP2_CreationFrameObjetFrameUtilisationCooldown.disabled = nil;
		TRP2_CreationFrameObjetFrameUtilisationTooltip.disabled = nil;
		TRP2_CreationFrameObjetFrameUtilisationCharge.disabled = nil;
		TRP2_CreationFrameObjetFrameUtilisationAnim.disabled = nil;
		TRP2_CreationFrameObjetFrameUtilisationAction.disabled = nil;
		if TRP2_GetWithDefaut(ObjetTab,"DureeAnim",0) > 0 then
			TRP2_CreationFrameObjetFrameUtilisationAnim.disabled = nil;
			TRP2_CreationFrameObjetFrameUtilisationAction.disabled = nil;
		else
			TRP2_CreationFrameObjetFrameUtilisationAnim.disabled = 1;
			TRP2_CreationFrameObjetFrameUtilisationAction.disabled = 1;
		end
	else
		TRP2_CreationFrameObjetFrameUtilisationAnim.disabled = 1;
		TRP2_CreationFrameObjetFrameUtilisationAction.disabled = 1;
		TRP2_CreationFrameObjetFrameUtilisationDuree.disabled = 1;
		TRP2_CreationFrameObjetFrameUtilisationCooldown.disabled = 1;
		TRP2_CreationFrameObjetFrameUtilisationTooltip.disabled = 1;
		TRP2_CreationFrameObjetFrameUtilisationCharge.disabled = 1;
	end
	getglobal("TRP2_CreationFrameObjetFrameMenuApercuIcon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(ObjetTab,"Icone","Temp"));
	
	TestTab["OnUseStart"] = TRP2_GetWithDefaut(ObjetTab,"bUtilisable",false) and TRP2_GetWithDefaut(ObjetTab,"DureeAnim",0) > 0;
	TestTab["OnUseStartFail"] = TRP2_GetWithDefaut(ObjetTab,"bUtilisable",false) and TRP2_GetWithDefaut(ObjetTab,"DureeAnim",0) > 0 
								and TRP2_GetWithDefaut(ObjetTab,"OnUseStartCondi",false);
	TestTab["OnUseEndFail"] = TRP2_GetWithDefaut(ObjetTab,"bUtilisable",false) and TRP2_GetWithDefaut(ObjetTab,"OnUseEndCondi",false);
	TestTab["OnUseEnd"] = TRP2_GetWithDefaut(ObjetTab,"bUtilisable",false);
	TestTab["OnUsed"] =  TRP2_GetWithDefaut(ObjetTab,"bUtilisable",false) and  TRP2_GetWithDefaut(ObjetTab,"Charges",0) > 1;
	TestTab["OnDestroy"] = true;
	TestTab["OnReceive"] = true;
	TestTab["OnTimeout"] = true;
	TestTab["OnCooldown"] = true;
	
	table.foreach(TestTab,function(trigger)
		if TestTab[trigger] then
			getglobal("TRP2_CreationFrameObjetFrameTrigger"..trigger.."Icon"):SetDesaturated(false);
			getglobal("TRP2_CreationFrameObjetFrameTrigger"..trigger):Enable();
			if TRP2_EmptyToNil(getglobal("TRP2_CreationFrameObjetFrameTrigger"..trigger).Effets) then
				getglobal("TRP2_CreationFrameObjetFrameTrigger"..trigger.."Texte"):SetTextColor(0,1,0);
				getglobal("TRP2_CreationFrameObjetFrameTrigger"..trigger.."Icon"):SetTexture("Interface\\ICONS\\INV_Torch_Thrown.blp");
			else
				getglobal("TRP2_CreationFrameObjetFrameTrigger"..trigger.."Texte"):SetTextColor(1,0.75,0);
				getglobal("TRP2_CreationFrameObjetFrameTrigger"..trigger.."Icon"):SetTexture("Interface\\ICONS\\INV_Torch_Lit.blp");
			end
		else
			getglobal("TRP2_CreationFrameObjetFrameTrigger"..trigger.."Texte"):SetTextColor(0.4,0.4,0.4);
			getglobal("TRP2_CreationFrameObjetFrameTrigger"..trigger.."Icon"):SetDesaturated(true);
			getglobal("TRP2_CreationFrameObjetFrameTrigger"..trigger):Disable();
			getglobal("TRP2_CreationFrameObjetFrameTrigger"..trigger.."Icon"):SetTexture("Interface\\ICONS\\INV_Torch_Unlit.blp");
		end
	end);
end

function TRP2_SetObjetApercuTooltip(bouton,ID)
	local objet = TRP2_CreateObjetTabCreation();
	local tableauInventaire = {};
	local Titre = "";
	local Message1 = "";
	local Message2 = "";
	local Message3 = "";
	local Message4 = "";
	local first = true;
	
	tableauInventaire["ID"] = ID;
	tableauInventaire["Qte"] = 1;
	tableauInventaire["Charges"] = objet["Charges"];
	if objet["Lifetime"] then
		tableauInventaire["Lifetime"] = time()+objet["Lifetime"];
	end
	
	Titre,Message1,Message2,Message3,Message4 = TRP2_GetItemTooltipLines(tableauInventaire,17,nil,nil,objet);
	
	TRP2_SetTooltipForFrame(bouton,bouton,"RIGHT",0,0,Titre);
	bouton.tooltipTexte1 = Message1;
	bouton.tooltipTexte2 = Message2;
	bouton.tooltipTexte3 = Message3;
	bouton.tooltipTexte4 = Message4;
	TRP2_RefreshTooltipForObjet(bouton);
end

function TRP2_CreateObjetTabCreation()
	local objet = {};
	-- Enregistrement des triggers/conditions
	objet["OnUseStartEffet"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnUseStart.Effets);
	objet["OnUseStartCondi"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnUseStart.Conditions);
	objet["OnUseStartScripts"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnUseStart.Scripts);
	
	objet["OnUseStartFailEffet"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnUseStartFail.Effets);
	objet["OnUseStartFailCondi"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnUseStartFail.Conditions);
	objet["OnUseStartFailScripts"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnUseStartFail.Scripts);
	
	objet["OnUseEndEffet"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnUseEnd.Effets);
	objet["OnUseEndCondi"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnUseEnd.Conditions);
	objet["OnUseEndScripts"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnUseEnd.Scripts);
	
	objet["OnUseEndFailEffet"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnUseEndFail.Effets);
	objet["OnUseEndFailCondi"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnUseEndFail.Conditions);
	objet["OnUseEndFailScripts"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnUseEndFail.Scripts);
	
	objet["OnUsedEffet"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnUsed.Effets);
	objet["OnUsedCondi"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnUsed.Conditions);
	objet["OnUsedScripts"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnUsed.Scripts);
	
	objet["OnDestroyEffet"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnDestroy.Effets);
	objet["OnDestroyCondi"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnDestroy.Conditions);
	objet["OnDestroyScripts"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnDestroy.Scripts);
	
	objet["OnReceiveEffet"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnReceive.Effets);
	objet["OnReceiveCondi"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnReceive.Conditions);
	objet["OnReceiveScripts"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnReceive.Scripts);
	
	objet["OnTimeoutEffet"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnTimeout.Effets);
	objet["OnTimeoutCondi"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnTimeout.Conditions);
	objet["OnTimeoutScripts"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnTimeout.Scripts);
	
	objet["OnCooldownEffet"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnCooldown.Effets);
	objet["OnCooldownCondi"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnCooldown.Conditions);
	objet["OnCooldownScripts"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameTriggerOnCooldown.Scripts);
	-- Enregistrement des flags
	objet["bWriteLock"] = TRP2_DefautToNil(TRP2_CreationFrameObjetFrameFlagsWriteLock:GetChecked() == 1,true);
	objet["bImmobile"] = TRP2_DefautToNil(TRP2_CreationFrameObjetFrameFlagsStealable:GetChecked() == 1,false);
	objet["bUtilisable"] = TRP2_DefautToNil(TRP2_CreationFrameObjetFrameFlagsUsable:GetChecked() == 1,false);
	objet["bGivable"] = TRP2_DefautToNil(TRP2_CreationFrameObjetFrameFlagsGivable:GetChecked() == 1,true);
	objet["bDestroyable"] = TRP2_DefautToNil(TRP2_CreationFrameObjetFrameFlagsDestroyable:GetChecked() == 1,true);
	objet["bManual"] = TRP2_DefautToNil(TRP2_CreationFrameObjetFrameFlagsManual:GetChecked() == 1,true);
	objet["bQuest"] = TRP2_DefautToNil(TRP2_CreationFrameObjetFrameFlagsQuest:GetChecked() == 1,false);
	-- Enregistrement des Composants : seulement si Utilisable
	if objet["bUtilisable"] then
		local String = "";
		String = String..TRP2_NilToEmpty(TRP2_ComposantBouton1.Arg).." ";
		String = String..TRP2_NilToDefaut(TRP2_EmptyToNil(TRP2_ComposantBouton1Qte:GetText()),"1").." ";
		String = String..TRP2_NilToEmpty(TRP2_ComposantBouton2.Arg).." ";
		String = String..TRP2_NilToDefaut(TRP2_EmptyToNil(TRP2_ComposantBouton2Qte:GetText()),"1").." ";
		String = String..TRP2_NilToEmpty(TRP2_ComposantBouton3.Arg).." ";
		String = String..TRP2_NilToDefaut(TRP2_EmptyToNil(TRP2_ComposantBouton3Qte:GetText()),"1").." ";
		String = String..TRP2_NilToEmpty(TRP2_ComposantBouton4.Arg).." ";
		String = String..TRP2_NilToDefaut(TRP2_EmptyToNil(TRP2_ComposantBouton4Qte:GetText()),"1").." ";
		String = String..TRP2_NilToEmpty(TRP2_ComposantBouton5.Arg).." ";
		String = String..TRP2_NilToDefaut(TRP2_EmptyToNil(TRP2_ComposantBouton5Qte:GetText()),"1").." ";
		String = String..TRP2_NilToEmpty(TRP2_ComposantBouton6.Arg).." ";
		String = String..TRP2_NilToDefaut(TRP2_EmptyToNil(TRP2_ComposantBouton6Qte:GetText()),"1").." ";
		String = String..TRP2_NilToEmpty(TRP2_ComposantBouton7.Arg).." ";
		String = String..TRP2_NilToDefaut(TRP2_EmptyToNil(TRP2_ComposantBouton7Qte:GetText()),"1").." ";
		String = String..TRP2_NilToEmpty(TRP2_ComposantBouton8.Arg).." ";
		String = String..TRP2_NilToDefaut(TRP2_EmptyToNil(TRP2_ComposantBouton8Qte:GetText()),"1").." ";
		String = String..TRP2_NilToEmpty(TRP2_ComposantBouton9.Arg).." ";
		String = String..TRP2_NilToDefaut(TRP2_EmptyToNil(TRP2_ComposantBouton9Qte:GetText()),"1").." ";
		String = String..TRP2_NilToEmpty(TRP2_ComposantBouton10.Arg).." ";
		String = String..TRP2_NilToDefaut(TRP2_EmptyToNil(TRP2_ComposantBouton10Qte:GetText()),"1").." ";
		objet["Composants"] = String;
		String = "";
		String = String..TRP2_NilToEmpty(TRP2_OutilBouton1.Arg).." ";
		String = String..TRP2_NilToDefaut(TRP2_EmptyToNil(TRP2_OutilBouton1Qte:GetText()),"1").." ";
		String = String..TRP2_NilToEmpty(TRP2_OutilBouton2.Arg).." ";
		String = String..TRP2_NilToDefaut(TRP2_EmptyToNil(TRP2_OutilBouton2Qte:GetText()),"1").." ";
		String = String..TRP2_NilToEmpty(TRP2_OutilBouton3.Arg).." ";
		String = String..TRP2_NilToDefaut(TRP2_EmptyToNil(TRP2_OutilBouton3Qte:GetText()),"1").." ";
		String = String..TRP2_NilToEmpty(TRP2_OutilBouton4.Arg).." ";
		String = String..TRP2_NilToDefaut(TRP2_EmptyToNil(TRP2_OutilBouton4Qte:GetText()),"1").." ";
		String = String..TRP2_NilToEmpty(TRP2_OutilBouton5.Arg).." ";
		String = String..TRP2_NilToDefaut(TRP2_EmptyToNil(TRP2_OutilBouton5Qte:GetText()),"1");
		objet["Outils"] = String;
	end
	-- Enregistrement Utilisation
	objet["Charges"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameObjetFrameUtilisationCharge:GetText()),0);
	objet["TooltipUse"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameUtilisationTooltip:GetText());
	objet["Cooldown"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameObjetFrameUtilisationCooldown:GetText()),0);
	objet["DureeAnim"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameObjetFrameUtilisationDuree:GetText()),0);
	objet["Anim"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameObjetFrameUtilisationAnim:GetText()),0);
	objet["TexteAnim"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameUtilisationAction:GetText());
	-- Enregistrement General
	objet["Nom"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameGeneralNom:GetText());
	objet["Categorie"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameGeneralCategorie:GetText());
	objet["Description"] = TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameGeneralDescriptionScrollEditBox:GetText());
	objet["Unique"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameObjetFrameGeneralUnique:GetText()),0);
	objet["Poids"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameObjetFrameGeneralPoids:GetText()),0);
	objet["Lifetime"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameObjetFrameGeneralLifetime:GetText()),0);
	objet["Valeur"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameObjetFrameGeneralValeur:GetText()),0);
	objet["Qualite"] = TRP2_DefautToNil(TRP2_GetInt(TRP2_CreationFrameObjetFrameGeneralQualite:GetValue()),1);
	objet["Icone"] = TRP2_DefautToNil(TRP2_EmptyToNil(TRP2_CreationFrameObjetFrameGeneralIcone.icone),"Temp");
	objet["MaxStack"] =  TRP2_DefautToNil(tonumber(TRP2_CreationFrameObjetFrameGeneralStack:GetText()),1);
	return objet;
end

function TRP2_ObjetSave(ID)
	local objet = TRP2_CreateObjetTabCreation();
	-- Ici t'aura un check
	objet["Createur"] = TRP2_GetWithDefaut(TRP2_Module_ObjetsPerso[ID],"Createur",TRP2_Joueur);
	objet["Date"] = date("%d/%m/%y, %H:%M:%S").." "..TRP2_LOC_By.." "..TRP2_Joueur;
	if TRP2_GetWithDefaut(TRP2_Module_ObjetsPerso[ID],"VerNum",1) < 10000 then
		objet["VerNum"] = TRP2_GetWithDefaut(TRP2_Module_ObjetsPerso[ID],"VerNum",1) + 1;
	end
	if TRP2_Module_ObjetsPerso[ID] then
		wipe(TRP2_Module_ObjetsPerso[ID]);
	else
		TRP2_Module_ObjetsPerso[ID] = {};
	end
	TRP2_tcopy(TRP2_Module_ObjetsPerso[ID], objet);
	TRP2_Afficher(TRP2_FT(TRP2_LOC_CREA_AURA_SAVE,TRP2_GetWithDefaut(TRP2_Module_ObjetsPerso[ID],"Nom",TRP2_LOC_NEW_Objet)));
	TRP2_ChargerCreaObjetPanel(ID);
end

function TRP2_ObjetSaveAs()
	local IDnew = TRP2_CreateNewEmpty("Item");
	TRP2_ObjetSave(IDnew);
	TRP2_ChargerCreaObjetPanel(IDnew);
end