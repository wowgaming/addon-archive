-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

-- Fonction qui change la place d'un objet entre les slots
function TRP2_SacObjetSwap(SlotDepart,SlotArrive,InvDepart,InvArrive)
	if not SlotDepart or not SlotArrive or not InvArrive or not InvDepart then
		return;
	end
	-- Adaptation du slot d'arrivé
	--TRP2_debug("--------------------------------");
	if not SlotArrive or not InvArrive then return end
	if InvArrive ~= "Sac" and InvArrive ~= "Coffre" and InvArrive ~= "Planque" then return end
	if InvDepart ~= "Sac" and InvDepart ~= "Coffre" and InvDepart ~= "Planque" then return end
	if InvDepart == InvArrive and SlotDepart == SlotArrive then return end
	
	TRP2_InterruptObjet(SlotArrive,InvArrive);
	TRP2_InterruptObjet(SlotDepart,InvDepart);
	
	local planqueID = TRP2InventaireFramePlanque.planqueID;
	
	--Swaping dans l'inventaire
	if InvArrive ~= "Planque" and InvDepart ~= "Planque" then
		if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive]["Slot"][SlotArrive] then
			local Slot1 = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart];
			local Slot2 = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive]["Slot"][SlotArrive];

			if Slot2["ID"] == Slot1["ID"] and (TRP2_GetWithDefaut(TRP2_GetObjectTab(Slot1["ID"]),"MaxStack",1) - Slot2["Qte"]) > 0 then
				local MaxStack = TRP2_GetWithDefaut(TRP2_GetObjectTab(Slot1["ID"]),"MaxStack",1);
				local restantArrive = MaxStack - Slot2["Qte"];
				if Slot1["Qte"] <= restantArrive then
					TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive]["Slot"][SlotArrive]["Qte"] = Slot2["Qte"] + Slot1["Qte"];
					wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart]);
					TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart] = nil;
				else
					TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive]["Slot"][SlotArrive]["Qte"] = MaxStack;
					TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart]["Qte"] = Slot1["Qte"] - restantArrive;
				end
			else
				local temp = {};
				TRP2_tcopy(temp,TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive]["Slot"][SlotArrive]);
				TRP2_tcopy(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive]["Slot"][SlotArrive],TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart]);
				TRP2_tcopy(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart],temp);
			end
		else -- Si ya rien sur le slot d'arrivée
			TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive]["Slot"][SlotArrive] = {};
			TRP2_tcopy(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive]["Slot"][SlotArrive],TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart])
			wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart]);
			TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart] = nil;
		end
		TRP2_PlaySound("Sound\\Interface\\PickUp\\PutDownWoodSmall.wav");
	elseif InvArrive == "Planque" and InvDepart == "Sac" then -- Sac vers Planque
		if planqueID ~= TRP2_GetPlanqueID(true) then return end -- C'est qu'on a bougé !
		if TRP2InventaireFramePlanque.planqueNom == TRP2_Joueur then
			if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive][planqueID]["Slot"][SlotArrive] then
				local temp = {};
				TRP2_tcopy(temp,TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive][planqueID]["Slot"][SlotArrive]);
				TRP2_tcopy(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive][planqueID]["Slot"][SlotArrive],TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart]);
				wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart]);
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart] = nil;
				
				TRP2_InvAddObjet(temp["ID"],"Sac",temp["Charges"],temp["Qte"],temp["Lifetime"],nil,false,nil,SlotDepart);
				
			else
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive][planqueID]["Slot"][SlotArrive] = {};
				TRP2_tcopy(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive][planqueID]["Slot"][SlotArrive],TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart])
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart] = nil;
			end
			TRP2_PlaySound("Sound\\Interface\\PickUp\\PutDownWoodSmall.wav");
		else
			local funct = function()
				local logMess1;
				local logMess2;
				local objet = TRP2_GetObjectTab(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart]["ID"]);
				if TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotArrive] then -- Si il y a quelque chose dans le slot d'arrivée
					local temp = {};
					TRP2_tcopy(temp,TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotArrive]);
					TRP2_tcopy(TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotArrive],TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart]);
					wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart]);
					TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart] = nil;
					logMess1 = TRP2_FT(TRP2_LOC_INV_PLANQLOG1,TRP2_Joueur,temp["Qte"],TRP2_GetNameWithQuality(TRP2_GetObjectTab(temp["ID"])));
					
					TRP2_InvAddObjet(temp["ID"],"Sac",temp["Charges"],temp["Qte"],temp["Lifetime"],nil,false,nil,SlotDepart);
					
				else
					TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotArrive] = {};
					TRP2_tcopy(TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotArrive],TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart])
					TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart]["Slot"][SlotDepart] = nil;
				end
				TRP2_SendUpdateToPlanque(TRP2InventaireFramePlanque.planqueNom);
				
				logMess2 = TRP2_FT(TRP2_LOC_INV_PLANQLOG2,TRP2_Joueur,TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotArrive]["Qte"],TRP2_GetNameWithQuality(objet));
				
				TRP2_SendUpdateLogPlanque(TRP2InventaireFramePlanque.planqueNom,logMess1,TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["ID"]);
				TRP2_SendUpdateLogPlanque(TRP2InventaireFramePlanque.planqueNom,logMess2,TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["ID"]);
				TRP2_ShowPlanque(TRP2InventaireFramePlanque.planqueNom,TRP2InventaireFramePlanque.planqueID);
				TRP2_PlaySound("Sound\\Interface\\PickUp\\PutDownWoodSmall.wav");
			end
			TRP2_PlanqueAskFunc(funct,TRP2InventaireFramePlanque.planqueNom,TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["ID"]);
		end
	elseif InvDepart == "Planque" and InvArrive == "Sac" then -- Planque vers Sac
		if planqueID ~= TRP2_GetPlanqueID(true) then return end -- C'est qu'on a bougé !
		if TRP2InventaireFramePlanque.planqueNom == TRP2_Joueur then
			local Objet = TRP2_GetObjectTab(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart][planqueID]["Slot"][SlotDepart]["ID"]);
			--Check unique
			if Objet["Unique"] and Objet["Unique"] > 0 then
				if TRP2_GetCountOfAll(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart][planqueID]["Slot"][SlotDepart]["ID"]) + TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart][planqueID]["Slot"][SlotDepart]["Qte"] > Objet["Unique"] then
					TRP2_Error(SPELL_FAILED_LIMIT_CATEGORY_EXCEEDED);
					return;
				end
			end
			
			if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive]["Slot"][SlotArrive] then
				local temp = {};
				TRP2_tcopy(temp,TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart][planqueID]["Slot"][SlotDepart]);
				TRP2_tcopy(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart][planqueID]["Slot"][SlotDepart],TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive]["Slot"][SlotArrive]);
				TRP2_InvAddObjet(temp["ID"],"Sac",temp["Charges"],temp["Qte"],temp["Lifetime"],nil,false,nil,SlotArrive);
			else
				TRP2_InvAddObjet(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart][planqueID]["Slot"][SlotDepart]["ID"],
				"Sac",TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart][planqueID]["Slot"][SlotDepart]["Charges"],
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart][planqueID]["Slot"][SlotDepart]["Qte"],
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart][planqueID]["Slot"][SlotDepart]["Lifetime"],nil,false,nil,SlotArrive);
				
				wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart][planqueID]["Slot"][SlotDepart]);
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart][planqueID]["Slot"][SlotDepart] = nil;
			end
			TRP2_PlaySound("Sound\\Interface\\PickUp\\PutDownWoodSmall.wav");
		else
			local funct = function()
				local logMess1;
				local logMess2;
				local objet = TRP2_GetObjectTab(TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotDepart]["ID"]);
				--Check unique
				if objet["Unique"] and objet["Unique"] > 0 then
					if TRP2_GetCountOfAll(TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotDepart]["ID"]) + TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotDepart]["Qte"] > objet["Unique"] then
						TRP2_Error(SPELL_FAILED_LIMIT_CATEGORY_EXCEEDED);
						return;
					end
				end
				if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive]["Slot"][SlotArrive] then
					local temp = {};
					TRP2_tcopy(temp,TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotDepart]);
					TRP2_tcopy(TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotDepart],TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive]["Slot"][SlotArrive]);
					TRP2_InvAddObjet(temp["ID"],"Sac",temp["Charges"],temp["Qte"],temp["Lifetime"],nil,false,nil,SlotArrive);
					logMess1 = TRP2_FT(TRP2_LOC_INV_PLANQLOG2,TRP2_Joueur,TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotDepart]["Qte"],TRP2_GetNameWithQuality(TRP2_GetObjectTab(TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotDepart]["ID"])));
				else
					TRP2_InvAddObjet(TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotDepart]["ID"],
					"Sac",TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotDepart]["Charges"],
					TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotDepart]["Qte"],
					TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotDepart]["Lifetime"],nil,false,nil,SlotArrive);
					
					wipe(TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotDepart]);
					TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotDepart] = nil;
				end
				logMess2 = TRP2_FT(TRP2_LOC_INV_PLANQLOG1,TRP2_Joueur,TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive]["Slot"][SlotArrive]["Qte"],TRP2_GetNameWithQuality(objet));
				TRP2_SendUpdateToPlanque(TRP2InventaireFramePlanque.planqueNom);
				TRP2_SendUpdateLogPlanque(TRP2InventaireFramePlanque.planqueNom,logMess1,TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["ID"]);
				TRP2_SendUpdateLogPlanque(TRP2InventaireFramePlanque.planqueNom,logMess2,TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["ID"]);
				TRP2_ShowPlanque(TRP2InventaireFramePlanque.planqueNom,TRP2InventaireFramePlanque.planqueID);
				TRP2_PlaySound("Sound\\Interface\\PickUp\\PutDownWoodSmall.wav");
			end
			TRP2_PlanqueAskFunc(funct,TRP2InventaireFramePlanque.planqueNom,TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["ID"]);
		end
	elseif InvDepart == "Planque" and InvArrive == "Planque" then -- Planque vers planque
		if planqueID ~= TRP2_GetPlanqueID(true) then return end -- C'est qu'on a bougé !
		if TRP2InventaireFramePlanque.planqueNom == TRP2_Joueur then
			if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive][planqueID]["Slot"][SlotArrive] then
				local temp = {};
				TRP2_tcopy(temp,TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive][planqueID]["Slot"][SlotArrive]);
				TRP2_tcopy(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive][planqueID]["Slot"][SlotArrive],TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart][planqueID]["Slot"][SlotDepart]);
				TRP2_tcopy(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart][planqueID]["Slot"][SlotDepart],temp);
			else
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive][planqueID]["Slot"][SlotArrive] = {};
				TRP2_tcopy(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvArrive][planqueID]["Slot"][SlotArrive],TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart][planqueID]["Slot"][SlotDepart])
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][InvDepart][planqueID]["Slot"][SlotDepart] = nil;
			end
			TRP2_PlaySound("Sound\\Interface\\PickUp\\PutDownWoodSmall.wav");
		else
			local funct = function()
				if TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotArrive] then
					local temp = {};
					TRP2_tcopy(temp,TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotArrive]);
					TRP2_tcopy(TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotArrive],TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotDepart]);
					TRP2_tcopy(TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotDepart],temp);
				else
					TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotArrive] = {};
					TRP2_tcopy(TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotArrive],TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotDepart])
					TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["Slot"][SlotDepart] = nil;
				end
				TRP2_SendUpdateToPlanque(TRP2InventaireFramePlanque.planqueNom);
				TRP2_ShowPlanque(TRP2InventaireFramePlanque.planqueNom,TRP2InventaireFramePlanque.planqueID);
				TRP2_PlaySound("Sound\\Interface\\PickUp\\PutDownWoodSmall.wav");
			end
			TRP2_PlanqueAskFunc(funct,TRP2InventaireFramePlanque.planqueNom,TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["ID"]);
		end
	else
		TRP2_Error(TRP2_LOC_INVERROR1);
	end
	TRP2_RefreshHudButton();
	TRP2_RefreshInventaire();
end

function TRP2_GetItemTooltipLines(tableauInventaire,iMode,prix,augment, itemTab)
	local objet;
	if itemTab then
		objet = itemTab
	else
		objet = TRP2_GetObjectTab(tableauInventaire["ID"]);
	end 
	local Titre = "";
	local Message1 = "";
	local Message2 = "";
	local Message3 = "";
	local Message4 = "";
	local first = true;
	
	if not objet then
		Titre = TRP2_FT(TRP2_LOC_Objet_Num,TRP2_GetWithDefaut(tableauInventaire,"ID","00000"));
		if string.len(TRP2_GetWithDefaut(tableauInventaire,"ID","00000")) ~= TRP2_IDSIZE then
			Message1 = TRP2_LOC_Objet_Error_2;
		else
			Message1 = TRP2_LOC_Objet_Error_3;
		end
	else
		Titre = Titre..TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(objet,"Qualite",1))]..TRP2_GetWithDefaut(objet,"Nom",TRP2_LOC_NEW_Objet);
		if TRP2_GetWithDefaut(objet,"bQuest",false) then
			if first then first=false else Message1=Message1.."\n" end
			Message1 = Message1.."{w}"..ITEM_BIND_QUEST;
		end
		if not TRP2_GetWithDefaut(objet,"bGivable",true) then
			if first then first=false else Message1=Message1.."\n" end
			Message1 = Message1.."{w}"..ITEM_SOULBOUND;
		end
		if TRP2_GetWithDefaut(objet,"Categorie",MISCELLANEOUS) then
			if first then first=false else Message1=Message1.."\n" end
			Message1 = Message1.."{w}"..TRP2_GetWithDefaut(objet,"Categorie",MISCELLANEOUS);
		end
		if TRP2_GetWithDefaut(objet,"Unique") then
			if first then first=false else Message1=Message1.."\n" end
			Message1 = Message1.."{w}"..ITEM_UNIQUE.."("..TRP2_GetWithDefaut(objet,"Unique")..")";
		end
		if TRP2_GetWithDefaut(tableauInventaire,"Lifetime") then
			if first then first=false else Message1=Message1.."\n" end
			local temps = TRP2_GetWithDefaut(tableauInventaire,"Lifetime") - time();
			if temps >= 0 then
				Message1 = Message1.."{w}"..TRP2_LOC_DUREE.." : "..TRP2_TimeToString(temps);
			else
				Message1 = Message1.."{w}"..TRP2_LOC_DUREE.." : ".."{r}"..TRP2_LOC_TRIGOBJ_TIMEOUT;
			end
		end
		if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"][TRP2_GetWithDefaut(tableauInventaire,"ID","00000")] then
			local temps = TRP2_TimeToString(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"][TRP2_GetWithDefaut(tableauInventaire,"ID","00000")]-time());
			if first then first=false else Message1=Message1.."\n" end
			Message1 = Message1.."{r}"..TRP2_LOC_RECHARGE.." : "..temps;
		end
		first=true;
		if TRP2_GetWithDefaut(objet,"Description") then
			if first then first=false else Message2=Message2.."\n" end
			Message2 = Message2.."{w}\"{o}"..TRP2_GetWithDefaut(objet,"Description").."{w}\"";
		end
		first=true;
		if TRP2_GetWithDefaut(objet,"bUtilisable") and TRP2_GetWithDefaut(objet,"TooltipUse") then
			if first then first=false else Message3=Message3.."\n" end
			Message3 = Message3.."{v}"..USE.." : "..TRP2_GetWithDefaut(objet,"TooltipUse");
		end
		if TRP2_GetWithDefaut(objet,"bUtilisable") and TRP2_GetWithDefaut(objet,"Charges",0) > 1 then
			if first then first=false else Message3=Message3.."\n" end
			Message3 = Message3.."{w}"..TRP2_FT(TRP2_LOC_Objet_ChargesCount,TRP2_GetWithDefaut(tableauInventaire,"Charges",TRP2_GetWithDefaut(objet,"Charges",0)));
		end
		if TRP2_GetConfigValueFor("TTObjetsCompoValeur",true) and iMode ~= 4 and TRP2_GetWithDefaut(objet,"Valeur",0) > 0 then
			local valeurSlot = TRP2_GetWithDefaut(objet,"Valeur",0)*TRP2_GetWithDefaut(tableauInventaire,"Qte",1);
			if first then first=false else Message3=Message3.."\n" end
			Message3 = Message3.."{o}"..TRP2_LOC_Objet_VALEUR.." : {w}"..TRP2_GoldToText(valeurSlot);
		end
		if TRP2_GetConfigValueFor("TTObjetsCompoPoids",true) and TRP2_GetWithDefaut(objet,"Poids",0) > 0 then
			local poidsSlot = TRP2_GetWithDefaut(objet,"Poids",0)*TRP2_GetWithDefaut(tableauInventaire,"Qte",1);
			if first then first=false else Message3=Message3.."\n" end
			Message3 = Message3.."{o}"..TRP2_LOC_Objet_POIDS.." : {w}"..TRP2_GetStringPoids(poidsSlot);
		end
		if iMode == 4 and prix then
			if first then first=false else Message3=Message3.."\n" end
			if augment and augment > 0 then
				Message3 = Message3.."{o}"..AUCTION_PRICE.." : {w}"..TRP2_GoldToText(prix).." {r}(+"..augment.."%)";
			elseif augment and augment < 0 then
				Message3 = Message3.."{o}"..AUCTION_PRICE.." : {w}"..TRP2_GoldToText(prix).." {v}("..augment.."%)";
			else
				Message3 = Message3.."{o}"..AUCTION_PRICE.." : {w}"..TRP2_GoldToText(prix);
			end
		end
		if TRP2_GetConfigValueFor("TTObjetsCompoScripted",true) and TRP2_ItemHasScript(objet) then
			local createur = TRP2_GetWithDefaut(objet,"Createur","");
			if string.len(tableauInventaire["ID"]) ~= 8 and not TRP2_IsMine(createur) and TRP2_GetAccess(createur) ~= TRP2_GetConfigValueFor("MinimumForScript",4) then
				if first then first=false else Message4=Message4.."\n" end
				Message4 = Message4.."{r}"..TRP2_LOC_BLOCKEDSCRIPTS.." ("..createur..")";
			end
		end
		if TRP2_GetConfigValueFor("TTObjetsCompoHelp",true) and TRP2_GetWithDefaut(objet,"bUtilisable") and not iMode and not TRP2_ExchangeFrame:IsVisible() then
			if first then first=false else Message4=Message4.."\n" end
			Message4 = Message4.."{j}"..TRP2_LOC_CLICDROIT.." : {v}"..USE;
		end
		if TRP2_GetConfigValueFor("TTObjetsCompoHelp",true) and iMode == 1 then
			if first then first=false else Message4=Message4.."\n" end
			Message4 = Message4.."{j}"..TRP2_LOC_CLIC.." : {v}"..TRP2_LOC_INV_EXDel;
		end
		if TRP2_GetConfigValueFor("TTObjetsCompoHelp",true) and TRP2_GetWithDefaut(tableauInventaire,"Qte",1) > 1 and not iMode and not TRP2_ExchangeFrame:IsVisible() then
			if first then first=false else Message4=Message4.."\n" end
			Message4 = Message4.."{j}"..TRP2_LOC_CLICMAJ.." : {o}"..TRP2_LOC_INV_CreatePile;
		end
		if TRP2_GetConfigValueFor("TTObjetsCompoHelp",true) and not iMode and not TRP2_ExchangeFrame:IsVisible() and TRP2_GetWithDefaut(objet,"bGivable",true) then
			if first then first=false else Message4=Message4.."\n" end
			Message4 = Message4.."{j}"..TRP2_LOC_CLICCTRL.." : {o}"..TRP2_LOC_CREACOLIS;
		end
		if TRP2_GetConfigValueFor("TTObjetsCompoHelp",true) and iMode == 4 then
			if first then first=false else Message4=Message4.."\n" end
			Message4 = Message4.."{j}"..TRP2_LOC_CLICDROIT.." : {v}"..TRP2_LOC_INV_BuyOne;
			Message4 = Message4.."\n{j}"..TRP2_LOC_CLICDROITMAJ.." : {v}"..TRP2_LOC_INV_BuyMany;
		end
		if TRP2_GetConfigValueFor("TTObjetsCompoHelp",true) and iMode == 7 then
			if first then first=false else Message4=Message4.."\n" end
			Message4 = Message4.."{j}"..TRP2_LOC_GLISSERCTRL.." : {v}"..PET_ACTION_MOVE_TO;
			Message4 = Message4.."\n{j}"..TRP2_LOC_CLICDROITCTRL.." : {v}"..TRP2_LOC_INV_HIDERACC;
		end
	end
	
	return Titre,Message1,Message2,Message3,Message4
end

function TRP2_ItemHasScript(objet)
	return TRP2_GetWithDefaut(objet,"OnUseStartScripts") or TRP2_GetWithDefaut(objet,"OnUseStartFailScripts") or TRP2_GetWithDefaut(objet,"OnUseEndScripts")
		or TRP2_GetWithDefaut(objet,"OnUseEndFailScripts") or TRP2_GetWithDefaut(objet,"OnUsedScripts") or TRP2_GetWithDefaut(objet,"OnDestroyScripts")
		or TRP2_GetWithDefaut(objet,"OnReceiveScripts") or TRP2_GetWithDefaut(objet,"OnTimeoutScripts") or TRP2_GetWithDefaut(objet,"OnCooldownScripts");
end

function TRP2_SetObjetTooltip(tableauInventaire,bouton,iMode,prix, augment)
	local Titre,Message1,Message2,Message3,Message4;
	
	if tableauInventaire and tableauInventaire["ID"] then
		Titre,Message1,Message2,Message3,Message4 = TRP2_GetItemTooltipLines(tableauInventaire,iMode,prix, augment);
	else
		return;
	end

	TRP2_SetTooltipForFrame(bouton,bouton,"LEFT",0,0,Titre);
	bouton.tooltipTexte1 = Message1;
	bouton.tooltipTexte2 = Message2;
	bouton.tooltipTexte3 = Message3;
	bouton.tooltipTexte4 = Message4;
	TRP2_RefreshTooltipForObjet(bouton);
end

function TRP2_GetStringPoids(poids)
	if poids >= 1000 then
		return tostring(poids/1000).." kg";
	end
	return poids.." g";
end

function TRP2_RefreshTooltipForObjet(Frame)
	if Frame.tooltipTexte and Frame.GenFrame and Frame.GenFrameX and Frame.GenFrameY and Frame.GenFrameAnch then
		TRP2_ObjetTooltip:Hide();
		TRP2_ObjetTooltip:SetOwner(Frame.GenFrame, Frame.GenFrameAnch,Frame.GenFrameX,Frame.GenFrameY);
		
		local i=1;
		if TRP2_EmptyToNil(TRP2_CTS(Frame.tooltipTexte)) then
			TRP2_ObjetTooltip:AddLine(TRP2_CTS(Frame.tooltipTexte), 1, 1, 1,true);
			_G["TRP2_ObjetTooltipTextLeft"..i]:SetFontObject(GameFontNormalLarge);
			_G["TRP2_ObjetTooltipTextLeft"..i]:SetNonSpaceWrap(true);
			i = i + 1;
		end
		
		if TRP2_EmptyToNil(TRP2_CTS(Frame.tooltipTexte1)) then
			TRP2_ObjetTooltip:AddLine(TRP2_CTS(Frame.tooltipTexte1), 1, 1, 1,true);
			_G["TRP2_ObjetTooltipTextLeft"..i]:SetFontObject(GameFontNormal);
			_G["TRP2_ObjetTooltipTextLeft"..i]:SetSpacing(2);
			_G["TRP2_ObjetTooltipTextLeft"..i]:SetNonSpaceWrap(true);
			i = i + 1;
		end
		if TRP2_EmptyToNil(TRP2_CTS(Frame.tooltipTexte2)) then
			TRP2_ObjetTooltip:AddLine(TRP2_CTS(Frame.tooltipTexte2), 1, 1, 1,true);
			_G["TRP2_ObjetTooltipTextLeft"..i]:SetFontObject(GameFontNormalSmall);
			_G["TRP2_ObjetTooltipTextLeft"..i]:SetSpacing(2);
			_G["TRP2_ObjetTooltipTextLeft"..i]:SetNonSpaceWrap(true);
			i = i + 1;
		end
		if TRP2_EmptyToNil(TRP2_CTS(Frame.tooltipTexte3)) then
			TRP2_ObjetTooltip:AddLine(TRP2_CTS(Frame.tooltipTexte3), 1, 1, 1,true);
			_G["TRP2_ObjetTooltipTextLeft"..i]:SetFontObject(GameFontNormal);
			_G["TRP2_ObjetTooltipTextLeft"..i]:SetSpacing(2);
			_G["TRP2_ObjetTooltipTextLeft"..i]:SetNonSpaceWrap(true);
			i = i + 1;
		end
		if TRP2_EmptyToNil(TRP2_CTS(Frame.tooltipTexte4)) then
			TRP2_ObjetTooltip:AddLine(TRP2_CTS(Frame.tooltipTexte4), 1, 1, 1,true);
			_G["TRP2_ObjetTooltipTextLeft"..i]:SetFontObject(GameFontNormalSmall);
			_G["TRP2_ObjetTooltipTextLeft"..i]:SetSpacing(2);
			_G["TRP2_ObjetTooltipTextLeft"..i]:SetNonSpaceWrap(true);
			i = i + 1;
		end
		TRP2_ObjetTooltip:Show();
	end
end

function TRP2_SlotOnUpdate(button)
	getglobal(button:GetName().."CooldownText"):SetText("");
	if button.ObjetID then
		getglobal(button:GetName().."Icon"):SetVertexColor(1, 1, 1);
		if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"][button.ObjetID] then
			if time() >= TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"][button.ObjetID] then
				getglobal(button:GetName().."Cooldown"):SetCooldown(0,0);
			else
				getglobal(button:GetName().."Icon"):SetVertexColor(1, 0, 0);
				getglobal(button:GetName().."CooldownText"):SetText(TRP2_TimeToString(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"][button.ObjetID] - time()));
			end
		end
	end
	if GetMouseFocus() == button then
		if button.ObjetID then
			if string.find(button:GetName(),"TRP2SacFrameSlot") then
				TRP2_SetObjetTooltip(button.Slot,button);
			elseif string.find(button:GetName(),"TRP2_HUDButton") then
				TRP2_SetObjetTooltip(button.Slot,button,7);
			else
				TRP2_SetObjetTooltip(button.Slot,button,3);
			end
		else
			TRP2_ObjetTooltip:Hide();
		end
	end
end

TRP2_LastHuDButton = nil;
TRP2_HudButton = {};

function TRP2_RefreshHudButton()
	for _,v in pairs(TRP2_HudButton) do
		-- On refresh
		if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][v.SlotID] then
			v.ObjetID = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][v.SlotID]["ID"];
			v.Slot = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][v.SlotID];
		else
			v.ObjetID = nil;
			v.Slot = nil;
		end
		
		-- On affiche
		if v.ObjetID then
			local objet = TRP2_GetObjectTab(v.ObjetID);
			_G[v:GetName().."Icon"]:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(objet,"Icone","Temp"));
			if v.Slot["Qte"] > 1 then
				_G[v:GetName().."Qte"]:SetText(v.Slot["Qte"]);
			else
				_G[v:GetName().."Qte"]:SetText("");
			end
			if TRP2_GetWithDefaut(objet,"bQuest",false) then
				_G[v:GetName().."Quest"]:Show();
			else
				_G[v:GetName().."Quest"]:Hide();
			end
		else
			_G[v:GetName().."Icon"]:SetTexture("Interface\\PaperDoll\\UI-Backpack-EmptySlot");
			_G[v:GetName().."Quest"]:Hide();
			_G[v:GetName().."Qte"]:SetText("");
		end
	end
end

function TRP2_CreateHudButton(button)
	if button.TRPtype == "Sac" and string.find(button:GetName(),"TRP2SacFrameSlot") then
		TRP2_debug("Start");
		local newSlot;
		-- Si le bouton existe déjà on le replae bêtement au milieu
		for _,v in pairs(TRP2_HudButton) do
			if v:IsVisible() and v.SlotID == button.SlotID then
				v:ClearAllPoints();
				v:SetPoint("Center",UIParent,"Center");
				return;
			end
		end
		-- On essaye d'abord de trouver un boutton inutilisé :
		for _,v in pairs(TRP2_HudButton) do
			if not v:IsVisible() then
				newSlot = v;
				break;
			end
		end
		if not newSlot then
			newSlot = CreateFrame("Button","TRP2_HUDButton"..(#TRP2_HudButton+1),UIParent,"TRP2HUDInventaireSlotTemplate");
			tinsert(TRP2_HudButton,1,newSlot);
			newSlot:SetClampedToScreen(true);
		end
		
		newSlot.TRPtype = "Sac";
		newSlot.SlotID = button.SlotID;
		
		newSlot:Show();
		newSlot:ClearAllPoints();
		newSlot:SetPoint("Center",UIParent,"Center");
		
		TRP2_EnregistrerHudButton(newSlot);
		
		TRP2_RefreshHudButton();
	end
end

function TRP2_InitHudButton()
	for k,v in pairs(TRP2_Module_Interface["HudButton"]) do
		if v.SlotID then
			local newSlot = CreateFrame("Button","TRP2_HUDButton"..(#TRP2_HudButton+1),UIParent,"TRP2HUDInventaireSlotTemplate");
			newSlot.SlotID = v.SlotID;
			tinsert(TRP2_HudButton,1,newSlot);
			newSlot:SetClampedToScreen(true);
			newSlot.TRPtype = "Sac";
			newSlot:SetPoint(TRP2_GetWithDefaut(v,"point","CENTER"),
							_G[TRP2_GetWithDefaut(v,"relativeto","UIParent")],
							TRP2_GetWithDefaut(v,"relativepoint","CENTER"),
							TRP2_GetWithDefaut(v,"X",0),TRP2_GetWithDefaut(v,"Y",0));
		end
	end
end

function TRP2_DeleteHudButton(button)
	for k,v in pairs(TRP2_Module_Interface["HudButton"]) do
		if v.SlotID == button.SlotID then
			wipe(TRP2_Module_Interface["HudButton"][k]);
			TRP2_Module_Interface["HudButton"][k] = nil;
			return;
		end
	end
end

function TRP2_EnregistrerHudButton(button)
	-- Est ce qu'il existe déjà ? Si oui : juste position
	for k,v in pairs(TRP2_Module_Interface["HudButton"]) do
		if v.SlotID == button.SlotID then
			local point, relativeTo, relativePoint, xOfs, yOfs = button:GetPoint(1);
			wipe(TRP2_Module_Interface["HudButton"][k]);
			TRP2_Module_Interface["HudButton"][k]["point"] = point;
			if relativeTo then
				TRP2_Module_Interface["HudButton"][k]["relativeTo"] = relativeTo:GetName();
			end
			TRP2_Module_Interface["HudButton"][k]["relativepoint"] = relativePoint;
			TRP2_Module_Interface["HudButton"][k]["X"] = xOfs;
			TRP2_Module_Interface["HudButton"][k]["Y"] = yOfs;
			TRP2_Module_Interface["HudButton"][k]["SlotID"] = button.SlotID;
			return;
		end
	end
	-- Sinon on le créer : SlotID + position
	local place = #TRP2_Module_Interface["HudButton"]+1;
	TRP2_Module_Interface["HudButton"][place] = {};
	TRP2_Module_Interface["HudButton"][place]["SlotID"] = button.SlotID;
	local point, relativeTo, relativePoint, xOfs, yOfs = button:GetPoint(1);
	TRP2_Module_Interface["HudButton"][place]["point"] = point;
	TRP2_Module_Interface["HudButton"][place]["relativeTo"] = relativeTo:GetName();
	TRP2_Module_Interface["HudButton"][place]["relativepoint"] = relativePoint;
	TRP2_Module_Interface["HudButton"][place]["X"] = xOfs;
	TRP2_Module_Interface["HudButton"][place]["Y"] = yOfs;
end

function TRP2_SlotOnDragStart(button,mouse)
	if string.find(button:GetName(),"TRP2_HUDButton") and IsControlKeyDown() then
		TRP2_LastHuDButton = button;
		button:StartMoving();
	elseif button.ObjetID then
		if mouse == "LeftButton" and not string.find(button:GetName(),"TRP2_HUDButton") then
			getglobal(button:GetName().."Icon"):SetDesaturated(true);
			if button.TRPtype == "Planque" then
				button.PlanqueID = TRP2_GetPlanqueID(true);
			end
			TRP2_PlaySound("Sound\\Interface\\PickUp\\PutDownFoodGeneric.wav");
			SetCursor("Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetObjectTab(button.ObjetID),"Icone","Temp"));
		end
	end
end

function TRP2_SlotOnDragStop(button,mouse)
	if mouse ~= "LeftButton" and TRP2_LastHuDButton then
		TRP2_LastHuDButton:StopMovingOrSizing();
		TRP2_EnregistrerHudButton(TRP2_LastHuDButton);
		TRP2_LastHuDButton = nil;
		return;
	elseif string.find(button:GetName(),"TRP2_HUDButton") then
		return;
	end
	if not button.SlotID or not button.TRPtype or not button.ObjetID then
		return;
	end
	local ObjetTab = TRP2_GetObjectTab(button.ObjetID)
	getglobal(button:GetName().."Icon"):SetDesaturated(false);
	if GetMouseFocus() then
		local focus = GetMouseFocus():GetName();
		if string.find(focus,"TRP2SacFrameSlot") or string.find(focus,"TRP2CoffreFrameSlot") or string.find(focus,"TRP2PlanqueFrameSlot") then
			if not TRP2_ExchangeFrame:IsVisible() then
				TRP2_SacObjetSwap(button.SlotID,GetMouseFocus().SlotID,button.TRPtype,GetMouseFocus().TRPtype,button.PlanqueID);
			else
				TRP2_Error(TRP2_LOC_INVERROR3);
			end
		elseif focus == "WorldFrame" and button.TRPtype ~= "Planque" then
			local name, royaume = UnitName("mouseover");
			if royaume then
				name = name.."-"..royaume;
			end
			if not TRP2_ExchangeFrame:IsVisible() then
				if name and UnitIsPlayer("mouseover") and UnitFactionGroup("mouseover") == UnitFactionGroup("player") then
					if CheckInteractDistance("mouseover",3) then
						if TRP2_EstDansLeReg(name) then
							if not TRP2_EstIgnore(name) then
								if TRP2_GetWithDefaut(ObjetTab,"bGivable",true) then
									if button.TRPtype == "Sac" then
										TRP2_StartExchange(name,button.SlotID);
									else
										TRP2_StartExchange(name);
									end
								else
									TRP2_Error(ERR_TRADE_BOUND_ITEM);
								end
							else
								TRP2_Error(TRP2_LOC_IGN_ERROR);
							end
						else
							TRP2_Error(TRP2_LOC_NOTINREG);
						end
					else
						TRP2_Error(ERR_TOO_FAR_TO_INTERACT);
					end
				elseif button.ObjetID then
					local ObjetTab = TRP2_GetObjectTab(button.ObjetID);
					if TRP2_GetWithDefaut(ObjetTab,"bDestroyable",true) then
						StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_ObjetDeleteConfirm,
								TRP2_GetWithDefaut(TRP2_GetObjectTab(button.ObjetID),"Nom",TRP2_LOC_NEW_Objet)));
						TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,TRP2_InvDelObjet,button.TRPtype,button.SlotID,true);
					else
						TRP2_Error(TRP2_LOC_Objet_NODELETE);
					end
				end
			else
				if name and TRP2_ExchangeMonTab and TRP2_ExchangeMonTab["Cible"] == name then
					if TRP2_GetWithDefaut(ObjetTab,"bGivable",true) then
						TRP2_ExchangeSetSlot(button.SlotID, nil);
					else
						TRP2_Error(ERR_TRADE_BOUND_ITEM);
					end
				else
					TRP2_Error(TRP2_LOC_NOTDELEX);
				end
			end
		elseif button.TRPtype == "Sac" and string.find(focus,"TRP2_ExchangeFrameLeftFrameObjet") then
			if TRP2_GetWithDefaut(ObjetTab,"bGivable",true) then
				local Slot = string.gsub(focus,"TRP2_ExchangeFrameLeftFrameObjet","");
				TRP2_ExchangeSetSlot(button.SlotID,Slot);
			else
				TRP2_Error(ERR_TRADE_BOUND_ITEM);
			end
		end
		ResetCursor();
	end
end

function TRP2_GoldOnDragStop(button)
	ResetCursor();
	TRP2_PlaySound("Sound\\Interface\\iMoneyDialogClose.wav");
	if GetMouseFocus() then
		local focus = GetMouseFocus():GetName();
		if focus == "WorldFrame" then
			local name, realm = UnitName("mouseover");
			if realm then
				name = name.."-"..realm;
			end
			if not TRP2_ExchangeFrame:IsVisible() and name and UnitIsPlayer("mouseover") and UnitFactionGroup("mouseover") == UnitFactionGroup("player") then
				if CheckInteractDistance("mouseover",3) then
					if TRP2_EstDansLeReg(name) then
						if not TRP2_EstIgnore(name) then
							TRP2_StartExchange(name);
						else
							TRP2_Error(TRP2_LOC_IGN_ERROR);
						end
					else
						TRP2_Error(TRP2_LOC_NOTINREG);
					end
				else
					TRP2_Error(ERR_TOO_FAR_TO_INTERACT);
				end
			else
				StaticPopupDialogs["TRP2_GET_MONTANT_NS"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_GoldDelete);
				TRP2_ShowStaticPopup("TRP2_GET_MONTANT_NS",nil,function(montant)
					if montant > TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Or"] then
						montant = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Or"];
					end
					if montant > 0 then
						TRP2_InvDelGold("Sac",montant,true);
					end
				end,nil,nil,nil,true,0);
			end
		else
			if MouseIsOver(TRP2InventaireFrameCoffre) and TRP2InventaireFrameCoffre:IsVisible()  then
				StaticPopupDialogs["TRP2_GET_MONTANT_NS"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_GoldToCoffre);
				TRP2_ShowStaticPopup("TRP2_GET_MONTANT_NS",nil,TRP2_TransfertOr,"Sac","Coffre",nil,true,0);
			elseif MouseIsOver(TRP2InventaireFramePlanque) and TRP2InventaireFramePlanque:IsVisible() then
				StaticPopupDialogs["TRP2_GET_MONTANT_NS"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_GoldToPlanque);
				TRP2_ShowStaticPopup("TRP2_GET_MONTANT_NS",nil,TRP2_TransfertOr,"Sac","Planque",nil,true,0);
			end
		end
	end
end