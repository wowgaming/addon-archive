-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

-- Calcul du tooltip du Sac
function TRP2_SetSacPortraitTooltip()
	local sacId = tostring(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Id"]);
	local Titre = "{w}|TInterface\\ICONS\\"..TRP2_SacsADos[sacId]["Icone"]..".blp:35:35|t "..TRP2_SacsADos[sacId]["Nom"];
	local Suite = "{v}< "..TRP2_LOC_SAC.." >{w}\n\n\"{o}"..TRP2_SacsADos[sacId]["Description"].."{w}\"\n\n{v}"..TRP2_LOC_POIDSBASE
					.." "..(TRP2_SacsADos[sacId]["Poids"]/1000).." kg\n\n{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_SHOWCREALIST;
	TRP2SacFramePortraitBouton.tooltipTexte = Titre;
	TRP2SacFramePortraitBouton.tooltipTexteSuite = Suite;
	TRP2_RefreshTooltipForFrame(TRP2SacFramePortraitBouton);
end

-- Calcul du tooltip du Coffre
function TRP2_SetCoffrePortraitTooltip()
	local sacId = tostring(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Id"]);
	local Titre = "{w}|TInterface\\ICONS\\"..TRP2_CoffreMonture[sacId]["Icone"]..".blp:35:35|t "..TRP2_CoffreMonture[sacId]["Nom"];
	local Suite = "{v}< "..TRP2_LOC_COFFRE.." >{w}\n\n\"{o}"..TRP2_CoffreMonture[sacId]["Description"].."{w}\"\n\n{v}"..TRP2_LOC_POIDSBASE
					.." "..(TRP2_CoffreMonture[sacId]["Poids"]/1000).." kg\n\n{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_SHOWCREALIST;
	TRP2CoffreFramePortraitBouton.tooltipTexte = Titre;
	TRP2CoffreFramePortraitBouton.tooltipTexteSuite = Suite;
	TRP2_RefreshTooltipForFrame(TRP2CoffreFramePortraitBouton);
end

----------------------------------------
-- CHECKED IHM
----------------------------------------

function TRP2_RefreshInventaire()
	if TRP2InventaireFrameSac:IsVisible() then
		TRP2_ShowSac(TRP2InventaireFrameSac.page);
	end
	if TRP2InventaireFrameCoffre:IsVisible() then
		TRP2_ShowCoffre(TRP2InventaireFrameCoffre.page);
	end
	if TRP2InventaireFramePlanque:IsVisible() then
		TRP2_ShowPlanque(TRP2InventaireFramePlanque.planqueNom,TRP2InventaireFramePlanque.planqueID);
	end
end

function TRP2_GenerateSmallTooltipObject(tab)
	local Titre,Message;
	
	Titre = "{icone:"..TRP2_GetWithDefaut(tab,"Icone","Temp")..":35} "..TRP2_GetNameWithQuality(tab);
	Message = "{w}\"{o}"..TRP2_GetWithDefaut(tab,"Description","").."{w}\"";
	Message = Message.."\n{v}"..TRP2_LOC_CREATOR.." : {o}"..TRP2_GetWithDefaut(tab,"Createur",UNKNOWN);
	Message = Message.."\n{v}"..ITEM_UNIQUE.." : {o}"..TRP2_GetWithDefaut(tab,"Unique",0);
	if TRP2_GetWithDefaut(tab,"bUtilisable") then
		if TRP2_GetWithDefaut(tab,"Charges",0) == 0 then
			Message = Message.."\n{v}"..TRP2_LOC_CHARGES.." : {o}"..UNLIMITED;
		else
			Message = Message.."\n{v}"..TRP2_LOC_CHARGES.." : {o}"..TRP2_GetWithDefaut(tab,"Charges",0);
		end
	end
	return Titre,Message;
end

-- Affiche la page du Sac à dos
function TRP2_ShowSac(page)
	local sacId = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Id"];
	SetPortraitToTexture(TRP2InventaireFrameSacPortrait,"Interface\\Icons\\"..TRP2_SacsADos[sacId]["Icone"]);
	TRP2InventaireFrameSacNomText:SetText(TRP2_CTS("{w}"..TRP2_SacsADos[sacId]["Nom"]));
	-- Si pas de page : première page
	if not page then page = 1 end
	page = tonumber(page);
	TRP2InventaireFrameSac.page = page;
	-- Initialisation des slots
	local poidsTotal = TRP2_GetSacPoids(TRP2_SacsADos[sacId]["Poids"]);
	local slot = ((page-1)*20)+1;
	while slot <= (page*20) do
		local slotFrame = getglobal("TRP2SacFrameSlot"..(slot-((page-1)*20)));
		if not slotFrame then TRP2_debug("FOIRAGE") break end
		local slotFrameIcon = getglobal(slotFrame:GetName().."Icon");
		local slotFrameQuest = getglobal(slotFrame:GetName().."Quest");
		local slotFrameQte = getglobal(slotFrame:GetName().."Qte");
		local slotFrameCooldown = getglobal(slotFrame:GetName().."Cooldown");
		
		--Auto reparation :
		if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][tostring(slot)] and not 
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][tostring(slot)]["ID"] then
			TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][tostring(slot)] = nil;
		end
		
		if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][tostring(slot)] then -- On charge le slot
			local slotTab = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][tostring(slot)];
			local objetInfo = TRP2_GetObjectTab(slotTab["ID"]);
			slotFrameIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(objetInfo,"Icone","Temp"));
			if slotTab["Qte"] > 1 then
				slotFrameQte:SetText(slotTab["Qte"]);
			else
				slotFrameQte:SetText("");
			end
			if TRP2_GetWithDefaut(objetInfo,"bQuest",false) then
				slotFrameQuest:Show();
			else
				slotFrameQuest:Hide();
			end
			slotFrame.ObjetID = slotTab["ID"];
			slotFrame.SlotID = tostring(slot);
			slotFrame.Slot = slotTab;
			slotFrame.page = TRP2InventaireFrameSac.page;
			slotFrame.TRPtype = "Sac";
		else -- Réinitialisation du slot
			slotFrameIcon:SetTexture("");
			slotFrameQte:SetText("");
			slotFrameQuest:Hide();
			slotFrame.ObjetID = nil;
			slotFrame.SlotID = tostring(slot);
			slotFrame.Slot = nil;
			slotFrame.page = TRP2InventaireFrameSac.page;
			slotFrame.TRPtype = "Sac";
		end
		slot = slot + 1;
	end
	TRP2_SacPoidsTextRight:SetText("|cffffffff"..TRP2_GetStringPoids(poidsTotal));
	local etat = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Durabilite"] / TRP2_SacsADos[sacId]["Resistance"];
	local color = "|cffffffff";
	if etat <= 0.1 then
		color = "|cffff0000";
	elseif etat <= 0.33 then
		color = "|cffffff00";
	end
	TRP2_SacDurabTextRight:SetText(color..TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Durabilite"].." / "..TRP2_SacsADos[sacId]["Resistance"])
	TRP2InventaireFrameSac:Show();
end

--Affichage d'une page du coffre
function TRP2_ShowCoffre(page)
	local sacId = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Id"];
	SetPortraitToTexture(TRP2InventaireFrameCoffrePortrait,"Interface\\Icons\\"..TRP2_CoffreMonture[sacId]["Icone"]);
	TRP2InventaireFrameCoffreNomText:SetText(TRP2_CTS("{w}"..TRP2_CoffreMonture[sacId]["Nom"]));
	-- Si pas de page : première page
	if not page then page = 1 end
	page = tonumber(page);
	TRP2InventaireFrameCoffre.page = page;
	-- Initialisation des slots
	local poidsTotal = TRP2_GetCoffrePoids(TRP2_CoffreMonture[sacId]["Poids"]);
	local slot = ((page-1)*20)+1;
	while slot <= (page*20) do
		local slotFrame = getglobal("TRP2CoffreFrameSlot"..(slot-((page-1)*20)));
		if not slotFrame then TRP2_debug("FOIRAGE") break end
		local slotFrameIcon = getglobal(slotFrame:GetName().."Icon");
		local slotFrameQuest = getglobal(slotFrame:GetName().."Quest");
		local slotFrameQte = getglobal(slotFrame:GetName().."Qte");
		
		--Auto reparation :
		if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Slot"][tostring(slot)] and not 
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Slot"][tostring(slot)]["ID"] then
			TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Slot"][tostring(slot)] = nil;
		end
		
		if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Slot"][tostring(slot)] then -- On charge le slot
			local slotTab = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Slot"][tostring(slot)];
			local objetInfo = TRP2_GetObjectTab(slotTab["ID"]);
			slotFrameIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(objetInfo,"Icone","Temp.blp"));
			if slotTab["Qte"] > 1 then
				slotFrameQte:SetText(slotTab["Qte"]);
			else
				slotFrameQte:SetText("");
			end
			if TRP2_GetWithDefaut(objetInfo,"bQuest",false) then
				slotFrameQuest:Show();
			else
				slotFrameQuest:Hide();
			end
			slotFrame.ObjetID = slotTab["ID"];
			slotFrame.SlotID = tostring(slot);
			slotFrame.Slot = slotTab;
			slotFrame.page = TRP2InventaireFrameCoffre.page;
			slotFrame.TRPtype = "Coffre";
		else -- Réinitialisation du slot
			slotFrameIcon:SetTexture("");
			slotFrameQuest:Hide();
			slotFrameQte:SetText("");
			slotFrame.ObjetID = nil;
			slotFrame.SlotID = tostring(slot);
			slotFrame.Slot = nil;
			slotFrame.page = TRP2InventaireFrameCoffre.page;
			slotFrame.TRPtype = "Coffre";
		end
		slot = slot + 1;
	end
	TRP2_CoffrePoidsTextRight:SetText("|cffffffff"..TRP2_GetStringPoids(poidsTotal));
	local etat = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Durabilite"] / TRP2_CoffreMonture[sacId]["Resistance"];
	local color = "|cffffffff";
	if etat <= 0.1 then
		color = "|cffff0000";
	elseif etat <= 0.33 then
		color = "|cffffff00";
	end
	TRP2_CoffreDurabTextRight:SetText(color..TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Durabilite"].." / "..TRP2_CoffreMonture[sacId]["Resistance"])
	TRP2InventaireFrameCoffre:Show();
end

-- Calcule le poids total du sac à dos, sur base du poid du sac
function TRP2_GetSacPoids(poids)
	table.foreach(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"],function(slot)
		local objetInfo = TRP2_GetObjectTab(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][slot]["ID"]);
		if objetInfo and objetInfo["Poids"] then
			poids = poids + objetInfo["Poids"]*TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][slot]["Qte"];
		end
	end)
	return poids;
end

-- Calcule le poids total du coffre, sur base du poid du coffre
function TRP2_GetCoffrePoids(poids)
	table.foreach(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Slot"],function(slot)
		local objetInfo = TRP2_GetObjectTab(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Slot"][slot]["ID"]);
		if objetInfo and objetInfo["Poids"] then
			poids = poids + objetInfo["Poids"]*TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Slot"][slot]["Qte"];
		end
	end)
	return poids;
end