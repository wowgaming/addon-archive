-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

-- Génère un identifiant de planque sur base de coordonnée TRP2.
function TRP2_GetPlanqueID(force)
	-- Sécurité : indisponible si Carte ouverte !!!
	if TRP2_GetConfigValueFor("bDontUseCoord",false) or (TRP2_GetWorldMap():IsVisible() and not force) then
		return nil;
	end
	SetMapToCurrentZone();
	local zoneNum = TRP2_GetCurrentMapZone();
	if zoneNum ~= -1 then
		local x,y = GetPlayerMapPosition("player");
		x = math.floor(x * TRP2_PrecisionPlanque);
		y = math.floor(y * TRP2_PrecisionPlanque);
		local zoneNum = TRP2_GetCurrentMapZone();
		return tostring(zoneNum).." "..tostring(x).." "..tostring(y);
	end
	return nil;
end

function TRP2_CanPlanqueHere(force)
	-- Sécurité : indisponible si Carte ouverte !!!
	if TRP2_GetConfigValueFor("bDontUseCoord",false) or (TRP2_GetWorldMap():IsVisible() and not force) then
		return nil;
	end
	-- Si l'icone n'est pas prévue, c'est qu'on peut pas ! Et toc.
	return TRP2_GetZoneIcon(TRP2_GetCurrentMapZone()) ~= "Temp";
end

-- Détection d'une planque
function TRP2_DetectPlanque(force)
	-- Sécurité : indisponible si Carte ouverte !!!
	if TRP2_GetConfigValueFor("bDontUseCoord",false) or (TRP2_GetWorldMap():IsVisible() and not force) or not TRP2_CanPlanqueHere(force) then
		return nil;
	end
	if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][TRP2_GetPlanqueID(force)] then
		return true;
	else
		return false;
	end
end

-- Détection d'une planque
function TRP2_DetectAndGetPlanque(force)
	-- Sécurité : indisponible si Carte ouverte !!!
	if not TRP2_CanPlanqueHere(force) then
		return nil;
	end
	return TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][TRP2_GetPlanqueID(force)];
end

--Delete planque
function TRP2_DeletePlanque(fonction)
	if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][TRP2InventaireFramePlanque.planqueID] then
		StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_DELPLANQUETT);
		TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
			TRP2_Afficher("{j}"..TRP2_FT(TRP2_LOC_DELETE_PLANQUE,"{o}"..TRP2_GetWithDefaut(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][TRP2InventaireFramePlanque.planqueID],"Nom",TRP2_LOC_NEWPLANQUE).."{j}"));
			wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][TRP2InventaireFramePlanque.planqueID]);
			TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][TRP2InventaireFramePlanque.planqueID] = nil;
			if fonction then
				fonction();
			end
		end);
	end
end

--Edit planque
function TRP2_EditPlanque(fonction)
	local planqueTab = {};
	TRP2InventaireFramePlanque:Hide();
	TRP2_CreationPlanqueFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_MODIFPLANQUE));
	TRP2_tcopy(planqueTab,TRP2InventaireFramePlanque.planqueTab);
	TRP2_CreationPlanqueFrame:Show();
	TRP2_CreationPlanqueFramePublic:SetChecked(TRP2_GetWithDefaut(planqueTab,"bPublic",false));
	--TRP2_CreationPlanqueFrameReadOnly:SetChecked(TRP2_GetWithDefaut(planqueTab,"bReadOnly",false));
	TRP2_CreationPlanqueFrameNom:SetText(TRP2_GetWithDefaut(planqueTab,"Nom",TRP2_LOC_NEWPLANQUE));
	TRP2_CreationPlanqueFrameAccessNomsScrollEditBox:SetText(TRP2_GetWithDefaut(planqueTab,"AccessNom",""));
	TRP2_CreationPlanqueFrameAccessLevel.Value = TRP2_GetWithDefaut(planqueTab,"Access",3);
	TRP2_CreationPlanqueFrameAccessLevelValeur:SetText(TRP2_LOC_AccessTab[TRP2_GetWithDefaut(planqueTab,"Access",3)]);
	TRP2_CreationPlanqueFrameIconeIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(planqueTab,"Icone","Temp"));
	TRP2_CreationPlanqueFrameIcone.icone = TRP2_GetWithDefaut(planqueTab,"Icone","Temp");
	TRP2_CreationPlanqueFrameSave:SetScript("OnClick",function()
		--planqueTab["bReadOnly"] = TRP2_EmptyToNil(TRP2_CreationPlanqueFrameReadOnly:GetChecked());
		planqueTab["bPublic"] = TRP2_NilToDefaut(TRP2_CreationPlanqueFramePublic:GetChecked() == 1, false);
		planqueTab["Nom"] = TRP2_EmptyToNil(TRP2_CreationPlanqueFrameNom:GetText());
		planqueTab["AccessNom"] = TRP2_EmptyToNil(TRP2_CreationPlanqueFrameAccessNomsScrollEditBox:GetText());
		planqueTab["Icone"] = TRP2_DefautToNil(TRP2_EmptyToNil(TRP2_CreationPlanqueFrameIcone.icone),"Temp");
		planqueTab["Access"] = TRP2_DefautToNil(TRP2_CreationPlanqueFrameAccessLevel.Value,3);
		TRP2_CreerPlanque(TRP2_GetWithDefaut(planqueTab,"Nom",TRP2_LOC_NEWPLANQUE),planqueTab,TRP2InventaireFramePlanque.planqueID,true);
		TRP2_CreationPlanqueFrame:Hide();
		if fonction then
			fonction();
		end
	end);
end

-- Création d'une planque
function TRP2_ConstructPlanque()
	TRP2_SearchPlanqueListe:Hide();
	SetMapToCurrentZone();
	local zoneNum = TRP2_GetCurrentMapZone();
	local x,y = GetPlayerMapPosition("player");
	x = math.floor(x * TRP2_PrecisionPlanque);
	y = math.floor(y * TRP2_PrecisionPlanque);
	local ID = tostring(zoneNum).." "..tostring(x).." "..tostring(y);
	
	if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][ID] then
		TRP2_Error(TRP2_LOC_ALREADY_PLANQUE);
	elseif not TRP2_CanPlanqueHere(true) then
		TRP2_Error(TRP2_LOC_CANTPLANQUEHERE);
	else
		local planqueTab = {};
		TRP2_CreationPlanqueFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_CREATEPLANQUE));
		planqueTab["Zone"] = GetZoneText();
		planqueTab["SousZone"] = GetSubZoneText();
		planqueTab["ZoneNum"] = zoneNum;
		planqueTab["Or"] = 0;
		planqueTab["CoordX"] = x;
		planqueTab["CoordY"] = y;
		planqueTab["Slot"] = {};
		planqueTab["Icone"] = TRP2_GetZoneIcon(zoneNum);
		TRP2_CreationPlanqueFrame:Show();
		--TRP2_CreationPlanqueFrameReadOnly:SetChecked(false);
		TRP2_CreationPlanqueFramePublic:SetChecked(false);
		TRP2_CreationPlanqueFrameNom:SetText(TRP2_LOC_NEWPLANQUE);
		TRP2_CreationPlanqueFrameAccessNomsScrollEditBox:SetText("");
		TRP2_CreationPlanqueFrameAccessLevel.Value = 3;
		TRP2_CreationPlanqueFrameAccessLevelValeur:SetText(TRP2_LOC_AccessTab[3]);
		TRP2_CreationPlanqueFrameIconeIcon:SetTexture("Interface\\ICONS\\"..planqueTab["Icone"]);
		TRP2_CreationPlanqueFrameIcone.icone = planqueTab["Icone"];
		TRP2_CreationPlanqueFrameSave:SetScript("OnClick",function()
			--planqueTab["bReadOnly"] = TRP2_EmptyToNil(TRP2_CreationPlanqueFrameReadOnly:GetChecked());
			planqueTab["bPublic"] = TRP2_NilToDefaut(TRP2_CreationPlanqueFramePublic:GetChecked() == 1, false);
			planqueTab["Nom"] = TRP2_EmptyToNil(TRP2_CreationPlanqueFrameNom:GetText());
			planqueTab["AccessNom"] = TRP2_EmptyToNil(TRP2_CreationPlanqueFrameAccessNomsScrollEditBox:GetText());
			planqueTab["Icone"] = TRP2_DefautToNil(TRP2_EmptyToNil(TRP2_CreationPlanqueFrameIcone.icone),"Temp");
			planqueTab["Access"] = TRP2_DefautToNil(TRP2_CreationPlanqueFrameAccessLevel.Value,3);
			TRP2_CreerPlanque(TRP2_GetWithDefaut(planqueTab,"Nom",TRP2_LOC_NEWPLANQUE),planqueTab,ID);
			TRP2_CreationPlanqueFrame:Hide();
		end);
	end
end

-- Dropdown access
function TRP2_DD_PlanqueAccess(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_AccessLevel;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	
	local access = TRP2_CreationPlanqueFrameAccessLevel.Value;
	
	local i;
	for i=1,5,1 do
		info = TRP2_CreateSimpleDDButton();
		if access == i then
			info.text = TRP2_LOC_AccessTab[i];
			info.checked = true;
			info.disabled = true;
		else
			info.text = TRP2_LOC_AccessTab[i];
		end
		info.func = function() 
			TRP2_CreationPlanqueFrameAccessLevel.Value = i;
			TRP2_CreationPlanqueFrameAccessLevelValeur:SetText(TRP2_LOC_AccessTab[i]);
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

-- Création d'un planque : étape 2, finition
function TRP2_CreerPlanque(Nom,planqueTab,ID,bEdit)
	if planqueTab then
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][ID] = {};
		TRP2_tcopy(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][ID],planqueTab);
		if bEdit then
			TRP2_Afficher("{j}"..TRP2_FT(TRP2_LOC_MODIF_PLANQUE,"{o}"..TRP2_GetWithDefaut(planqueTab,"Nom",TRP2_LOC_NEWPLANQUE).."{j}"));
		else
			TRP2_Afficher("{j}"..TRP2_FT(TRP2_LOC_CREATE_PLANQUE,"{o}"..TRP2_GetWithDefaut(planqueTab,"Nom",TRP2_LOC_NEWPLANQUE).."{j}"));
		end
		if TRP2_GetPlanqueID(true) == ID then
			TRP2_ShowPlanque(TRP2_Joueur,ID);
		end
	end
end

-- Montre planque
function TRP2_ShowPlanque(Nom,planqueID)
	if not Nom or not planqueID or TRP2_GetPlanqueID(true) ~= planqueID then
		TRP2InventaireFramePlanque:Hide();
		return;
	end
	
	local planque;
	if Nom == TRP2_Joueur then
		planque = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][planqueID];
		TRP2PlanqueFrameEdit:Show();
	elseif TRP2_Planques[Nom] and TRP2_Planques[Nom]["ID"] == planqueID then
		planque = TRP2_Planques[Nom];
		TRP2PlanqueFrameEdit:Hide();
	else
		return;
	end
	if not planque then 
		TRP2InventaireFramePlanque:Hide();
		return;
	end
	if TRP2_PlanquesLocks[planqueID] then
		TRP2_SecureSendAddonMessage("PLST",planqueID,TRP2_PlanquesLocks[planqueID]);
		TRP2_PlanquesLocks[planqueID] = nil;
	end
	TRP2_SearchPlanqueListe:Hide();
	TRP2_CreationPlanqueFrame:Hide();
	-- Icone, Nom et Or
	SetPortraitToTexture(TRP2InventaireFramePlanquePortrait,"Interface\\ICONS\\"..TRP2_GetWithDefaut(planque,"Icone","Temp"));
	TRP2InventaireFramePlanqueNomText:SetText(TRP2_CTS("{w}"..TRP2_GetWithDefaut(planque,"Nom",TRP2_LOC_NEWPLANQUE)));
	TRP2_PlanqueGoldText:SetText(TRP2_CTS("{w}"..TRP2_GoldToText(TRP2_GetWithDefaut(planque,"Or",0))));
	-- Initialisation des slots
	for slot=1,4,1 do
		local slotFrame = getglobal("TRP2PlanqueFrameSlot"..slot);
		local slotFrameIcon = getglobal(slotFrame:GetName().."Icon");
		local slotFrameQte = getglobal(slotFrame:GetName().."Qte");
		local slotFrameQuest = getglobal(slotFrame:GetName().."Quest");
		
		if planque["Slot"][tostring(slot)] then -- On charge le slot
			local slotTab = planque["Slot"][tostring(slot)];
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
			slotFrame.TRPtype = "Planque";
			slotFrame.PlanqueID = planqueID;
		else -- Réinitialisation du slot
			slotFrameIcon:SetTexture("");
			slotFrameQte:SetText("");
			slotFrameQuest:Hide();
			slotFrame.ObjetID = nil;
			slotFrame.SlotID = tostring(slot);
			slotFrame.Slot = nil;
			slotFrame.TRPtype = "Planque";
			slotFrame.PlanqueID = nil;
		end
	end
	TRP2InventaireFramePlanque.planqueTab = planque;
	TRP2InventaireFramePlanque.planqueID = planqueID;
	TRP2InventaireFramePlanque.planqueNom = Nom;
	TRP2InventaireFramePlanque:SetScript("OnHide",function()
		if Nom ~= TRP2_Joueur then
			-- Release du lock
			TRP2_SecureSendAddonMessage("PLRL",planqueID,Nom);
		end
	end);
	TRP2InventaireFramePlanque:Show();
end

-- Calcul du tooltip de l'icone de planque
function TRP2_SetPlanquePortraitTooltip(planque,planqueNom)
	if planque then
		local Titre = "{w}|TInterface\\ICONS\\"..TRP2_GetWithDefaut(planque,"Icone","Temp")..".blp:35:35|t "..TRP2_GetWithDefaut(planque,"Nom",TRP2_LOC_NEWPLANQUE);
		local Suite = "{o}"..TRP2_LOC_OWNER.." : "..planqueNom.."\n{v}< "..TRP2_GetWithDefaut(planque,"Zone","").." >\n";
		if TRP2_EmptyToNil(TRP2_GetWithDefaut(planque,"bPublic")) then
			Suite = Suite.."{j}< "..TRP2_LOC_PLANQUEPUBLIC.." >\n";
		end
		if TRP2_EmptyToNil(TRP2_GetWithDefaut(planque,"bReadOnly", false)) then
			Suite = Suite.."{j}< "..TRP2_LOC_PLANQUEREADONLY.." >\n";
		end
		if TRP2_EmptyToNil(TRP2_GetWithDefaut(planque,"SousZone")) then
			Suite = Suite.."{o}< "..TRP2_GetWithDefaut(planque,"SousZone").." >\n";
		end
		if TRP2_EmptyToNil(TRP2_GetWithDefaut(planque,"NbrSlot")) then
			Suite = Suite.."{o}"..TRP2_LOC_SLOTSUSED.." : "..TRP2_GetWithDefaut(planque,"NbrSlot").."/4\n";
		end
		if TRP2_GetIndexedTabSize(TRP2_GetWithDefaut(planque,"Log",{})) > 0 then
			Suite = Suite.."\n{o}"..GUILD_BANK_LOG.." :\n";
			for _,val in pairs(TRP2_GetWithDefaut(planque,"Log",{})) do
				Suite = Suite.."{w}"..val.."\n";
			end
		end
		if TRP2_EmptyToNil(TRP2_GetWithDefaut(planque,"Lock")) then
			Suite = Suite..TRP2_FT(TRP2_LOC_USEDBY,TRP2_GetWithDefaut(planque,"Lock"));
		end
		Suite = Suite.."\n{w}";
		Suite = Suite..TRP2_LOC_COORD.." :\n< "..TRP2_GetWithDefaut(planque,"CoordX",0).." - "..TRP2_GetWithDefaut(planque,"CoordY",0).." >";
		
		return Titre,Suite;
	end
end

function TRP2_LoadPlanqueList()
	local i = 0; -- Nombre total
	local j = 0; -- Nombre pris
	TRP2_PlanqueListeSlider:Hide();
	TRP2_PlanqueListeSlider:SetValue(0);
	wipe(TRP2_PlanqueList);
	
	for k,v in pairs(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"]) do
		i = i + 1;
		j = j + 1;
		TRP2_PlanqueList[j] = k;
	end
	
	table.sort(TRP2_PlanqueList);

	if j > 0 then
		TRP2_PlanqueListeEmpty:SetText("");
	elseif i == 0 then
		TRP2_PlanqueListeEmpty:SetText(TRP2_LOC_NOPLANQUE);
	else
		TRP2_PlanqueListeEmpty:SetText(TRP2_LOC_SelectVide);
	end
	if j > 42 then
		TRP2_PlanqueListeSlider:Show();
		local total = floor((j-1)/49);
		TRP2_PlanqueListeSlider:SetMinMaxValues(0,total);
	end
	TRP2_PlanqueListeSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_LoadPlanqueListPage(self:GetValue());
		end
	end)
	TRP2_LoadPlanqueListPage(0);
end

function TRP2_LoadPlanqueListPage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_PlanqueListeSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	table.foreach(TRP2_PlanqueList,
	function(TabIndex)
		if i > num*49 and i <= (num+1)*49 then
			local ID = TRP2_PlanqueList[TabIndex];
			local planqueTab = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][ID];
			getglobal("TRP2_PlanqueListeSlot"..j):Show();
			getglobal("TRP2_PlanqueListeSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(planqueTab,"Icone","Temp"));
			getglobal("TRP2_PlanqueListeSlot"..j):SetScript("OnClick", function(self,button)
				TRP2InventaireFramePlanque:Hide();
				TRP2InventaireFramePlanque.planqueTab = planqueTab;
				TRP2InventaireFramePlanque.planqueID = ID;
				if button == "LeftButton" then
					TRP2_EditPlanque(function() TRP2_PlanqueListe:Show() end);
					TRP2_PlanqueListe:Hide();
				else
					TRP2_DeletePlanque(function() TRP2_PlanqueListe:Show() end);
					TRP2_PlanqueListe:Hide();
				end
			end);
			local titre,suite = TRP2_SetPlanquePortraitTooltip(planqueTab,TRP2_Joueur);
			TRP2_SetTooltipForFrame(
				getglobal("TRP2_PlanqueListeSlot"..j),
				getglobal("TRP2_PlanqueListeSlot"..j),"RIGHT",0,0,
				titre,suite.."\n\n{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_MODIFPLANQUE.."\n{j}"..TRP2_LOC_CLICDROIT.." : {w}"..TRP2_LOC_DELETEPLANQUE
			);
			j = j + 1;
		end
		i = i + 1;
	end);
end

--**--**--**--**--**--**--**--
-- Planques
--**--**--**--**--**--**--**--

TRP2_Planques = {};
TRP2_PlanquesLocks = {};
TRP2_ACTIONPLANQUE = nil;

function TRP2_PlanqueAskFunc(func,nom,ID)
	TRP2_ACTIONPLANQUE = func;
	TRP2_SecureSendAddonMessage("PLAS",ID,nom);
end

function TRP2_PlanqueAsk(sender,message)
	if message and TRP2_PlanquesLocks[message] == sender then -- Il faut que le sender aie actuellement le lock
		TRP2_SecureSendAddonMessage("PLOK","",sender);
	else
		TRP2_SecureSendAddonMessage("PLST",message,sender); -- Sinon on le stop
	end
end

function TRP2_PlanqueAskOk(sender)
	if TRP2_ACTIONPLANQUE and sender == TRP2InventaireFramePlanque.planqueNom then
		TRP2_ACTIONPLANQUE();
	end
	TRP2_ACTIONPLANQUE = nil;
end

function TRP2_StartSearchPlanque()
	wipe(TRP2_Planques);
	TRP2InventaireFramePlanque:Hide();
	TRP2_CreationPlanqueFrame:Hide();
	TRP2_SearchPlanqueListe:Show();
	TRP2_LoadSearchPlanqueList();
	local ID = TRP2_GetPlanqueID(true);
	TRP2_SendContentToChannel({ID},"GetPlanque");
end

function TRP2_PlanqueStop(sender,ID)
	if TRP2InventaireFramePlanque:IsVisible() and TRP2InventaireFramePlanque.planqueID == ID then
		TRP2InventaireFramePlanque:Hide();
		TRP2_Error(TRP2_CTS(TRP2_FT(TRP2_LOC_ERRORPLANQUE1,sender)));
	end
end

function TRP2_SendUpdateLogPlanque(nom,message,ID)
	if TRP2_EmptyToNil(message) then
		TRP2_SecureSendAddonMessage("PLLO",ID..TRP2_ReservedChar..message,nom);
	end
end

function TRP2_GetPlanqueLog(sender,tab)
	if tab[1] and TRP2_PlanquesLocks[tab[1]] == sender then -- Il faut que le sender aie actuellement le lock
		if not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][tab[1]]["Log"] then
			TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][tab[1]]["Log"] = {};
		end
		tinsert(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][tab[1]]["Log"],1,tab[2]);
		if #TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][tab[1]]["Log"] > 10 then
			tremove(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][tab[1]]["Log"],11);
		end
		TRP2_debug(tab[2]);
	end
end

--Check access
function TRP2_CheckPlanqueAccess(planqueTab,sender)
	local okAccess = false;
	if not TRP2_GetWithDefaut(planqueTab,"AccessNom") or TRP2_matchInTableString(TRP2_FetchToTabWithSeparator(TRP2_GetWithDefaut(planqueTab,"AccessNom",""),","),sender) then
		--TRP2_debug("Ok AccessNom");
		okAccess = true;
	end
	if okAccess and (TRP2_GetAccess(sender) >= TRP2_GetWithDefaut(planqueTab,"Access",3) or TRP2_GetWithDefaut(planqueTab,"Access",3) == 5)then
		--TRP2_debug("Ok Access");
		okAccess = true;
	end
	return okAccess;
end

-- On recois une demande de planque par le channel, et on regarde si on a une planque à cet endroit.
function TRP2_ChanGetPlanque(sender,planqueID)
	-- Est ce que j'ai une planque ici ?
	local planqueTab = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][planqueID];
	if planqueTab then
		
		if TRP2_CheckPlanqueAccess(planqueTab,sender) then
			local Message = planqueID..TRP2_ReservedChar;
			Message = Message..tostring(TRP2_GetWithDefaut(planqueTab,"bReadOnly",false))..TRP2_ReservedChar;
			Message = Message..TRP2_GetWithDefaut(planqueTab,"Or","0")..TRP2_ReservedChar;
			Message = Message..TRP2_GetWithDefaut(planqueTab,"Icone","Temp")..TRP2_ReservedChar;
			Message = Message..TRP2_GetIndexedTabSize(TRP2_GetWithDefaut(planqueTab,"Slot",{}))..TRP2_ReservedChar;
			Message = Message..TRP2_GetWithDefaut(planqueTab,"Nom",TRP2_LOC_NEWPLANQUE);
			if TRP2_PlanquesLocks[planqueID] then
				Message = Message..TRP2_ReservedChar..TRP2_PlanquesLocks[planqueID];
			elseif TRP2InventaireFramePlanque:IsVisible() and TRP2InventaireFramePlanque.planqueID == planqueID then
				Message = Message..TRP2_ReservedChar..TRP2_Joueur;
			end
			TRP2_SecureSendAddonMessage("PLSI",Message,sender);
			return;
		end
		TRP2_debug("Pas access !");
	end
end

function TRP2_PlanqueReceiveInfo(sender,planqueTab)
	-- 1 : ID
	-- 2 : Planque read only
	-- 3 : Or
	-- 4 : Icone
	-- 5 : Nbr Slot
	-- 6 : Nom
	-- 7 : Lock by
	SetMapToCurrentZone();
	local zoneNum = TRP2_GetCurrentMapZone();
	local x,y = GetPlayerMapPosition("player");
	x = math.floor(x * TRP2_PrecisionPlanque);
	y = math.floor(y * TRP2_PrecisionPlanque);
	local ID = tostring(zoneNum).." "..tostring(x).." "..tostring(y);
	if TRP2_SearchPlanqueListe:IsVisible() and ID == planqueTab[1] then -- Si on a pas bougé
		if TRP2_Planques[sender] then
			wipe(TRP2_Planques[sender]);
		else
			TRP2_Planques[sender] = {};
		end
		TRP2_Planques[sender] = {};
		TRP2_Planques[sender]["Zone"] = GetZoneText();
		TRP2_Planques[sender]["SousZone"] = GetSubZoneText();
		TRP2_Planques[sender]["ZoneNum"] = zoneNum;
		TRP2_Planques[sender]["bReadOnly"] = planqueTab[2] == "1";
		TRP2_Planques[sender]["Or"] = tonumber(planqueTab[3]);
		TRP2_Planques[sender]["CoordX"] = x;
		TRP2_Planques[sender]["CoordY"] = y;
		TRP2_Planques[sender]["Icone"] = planqueTab[4];
		TRP2_Planques[sender]["NbrSlot"] = tonumber(planqueTab[5]);
		TRP2_Planques[sender]["Slot"] = {};
		TRP2_Planques[sender]["Nom"] = planqueTab[6];
		TRP2_Planques[sender]["ID"] = ID;
		TRP2_Planques[sender]["Lock"] = planqueTab[7];
		TRP2_LoadSearchPlanqueList();
	end
end

function TRP2_PlanqueInitVisit(sender,ID)
	local planqueTab = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][ID];
	if planqueTab then
		if (not TRP2InventaireFramePlanque:IsVisible() or TRP2InventaireFramePlanque.planqueID ~= ID) and (not TRP2_PlanquesLocks[ID] or TRP2_PlanquesLocks[ID] == sender) then
			TRP2_PlanquesLocks[ID] = sender;
			TRP2_SecureSendAddonMessage("PLSU",ID..TRP2_ReservedChar..TRP2_PlanqueToString(planqueTab),sender);
		else
			TRP2_SecureSendAddonMessage("MESS","TRP2_LOC_ERRORPLANQUE1"..TRP2_ReservedChar..TRP2_Joueur,sender);
		end
	end
end

function TRP2_PlanqueReleaseLock(sender,ID)
	if TRP2_PlanquesLocks[ID] == sender then
		TRP2_PlanquesLocks[ID] = nil;
	end
end

function TRP2_GetUpdateFromPlanque(sender,tab)
	TRP2_debug("Recu : "..tab[1]);
	
	if TRP2_Planques[sender] and TRP2_Planques[sender]["ID"] == tab[1] then
		TRP2_Planques[sender]["Or"] = tonumber(tab[2]);
		TRP2_Planques[sender]["Slot"] = {};
		for i=1,4,1 do
			local ID = TRP2_EmptyToNil(tab[(5*(i-1))+3]);
			if ID then
				TRP2_Planques[sender]["Slot"][tostring(i)] = {};
				TRP2_Planques[sender]["Slot"][tostring(i)]["ID"] = ID;
				TRP2_Planques[sender]["Slot"][tostring(i)]["VerNum"] = tonumber(tab[(5*(i-1))+4]);
				TRP2_Planques[sender]["Slot"][tostring(i)]["Qte"] = tonumber(tab[(5*(i-1))+5]);
				TRP2_Planques[sender]["Slot"][tostring(i)]["Charges"] = tonumber(tab[(5*(i-1))+6]);
				TRP2_Planques[sender]["Slot"][tostring(i)]["LifeTime"] = tonumber(tab[(5*(i-1))+7]);
				TRP2_CheckDoIHaveInfo({ID,TRP2_Planques[sender]["Slot"][tostring(i)]["VerNum"]},sender);
			end
		end
		TRP2_ShowPlanque(sender,tab[1]);
	end
end

function TRP2_SendUpdateToPlanque(sender)
	if sender and TRP2_Planques[sender] then
		TRP2_SecureSendAddonMessage("PLUL",TRP2_Planques[sender]["ID"]..TRP2_ReservedChar..TRP2_PlanqueToString(TRP2_Planques[sender]),sender);
	end
end

function TRP2_GetUpdateFromVisitor(sender,tab)
	TRP2_debug("Recu du visiteur : "..tab[1]);
	if tab[1] and TRP2_PlanquesLocks[tab[1]] == sender then -- Il faut que le sender aie actuellement le lock
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][tab[1]]["Or"] = tonumber(tab[2]);
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][tab[1]]["Slot"] = {};
		for i=1,4,1 do
			local ID = TRP2_EmptyToNil(tab[(5*(i-1))+3]);
			if ID then
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][tab[1]]["Slot"][tostring(i)] = {};
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][tab[1]]["Slot"][tostring(i)]["ID"] = ID;
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][tab[1]]["Slot"][tostring(i)]["VerNum"] = tonumber(tab[(5*(i-1))+4]);
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][tab[1]]["Slot"][tostring(i)]["Qte"] = tonumber(tab[(5*(i-1))+5]);
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][tab[1]]["Slot"][tostring(i)]["Charges"] = tonumber(tab[(5*(i-1))+6]);
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][tab[1]]["Slot"][tostring(i)]["LifeTime"] = tonumber(tab[(5*(i-1))+7]);
				TRP2_CheckDoIHaveInfo({ID,TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"][tab[1]]["Slot"][tostring(i)]["VerNum"]},sender);
			end
		end
	else
		TRP2_SecureSendAddonMessage("PLST",tab[1],sender);
	end
end

-- Transforme un tableau de planque en un string (info des objet + or seulement)
function TRP2_PlanqueToString(planqueTab)
	local message = "";
	message = message..TRP2_GetWithDefaut(planqueTab,"Or",0)..TRP2_ReservedChar;
	local i;
	for i=1,4,1 do
		local Slot = planqueTab["Slot"][tostring(i)];
		if Slot then
			local ID = Slot["ID"];
			local VerNum = TRP2_GetWithDefaut(TRP2_GetObjectTab(ID),"VerNum",1);
			local Qte = Slot["Qte"];
			local Charges = TRP2_NilToEmpty(Slot["Charges"]);
			local LifeTime = TRP2_NilToEmpty(Slot["Lifetime"]);
			message = message..ID..TRP2_ReservedChar..VerNum..TRP2_ReservedChar..Qte..TRP2_ReservedChar..Charges..TRP2_ReservedChar..LifeTime..TRP2_ReservedChar;
		else
			message = message..TRP2_ReservedChar..TRP2_ReservedChar..TRP2_ReservedChar..TRP2_ReservedChar..TRP2_ReservedChar;
		end
	end
	return message;
end

-- Liste des planques aux autres
function TRP2_LoadSearchPlanqueList()
	local i = 0; -- Nombre total
	TRP2_SearchPlanqueListeSlider:Hide();
	TRP2_SearchPlanqueListeSlider:SetValue(0);
	wipe(TRP2_PlanqueList);
	
	for k,v in pairs(TRP2_Planques) do
		i = i + 1;
		TRP2_PlanqueList[i] = k;
	end
	
	table.sort(TRP2_PlanqueList);

	if i > 0 then
		TRP2_SearchPlanqueListeEmpty:SetText("");
	elseif i == 0 then
		TRP2_SearchPlanqueListeEmpty:SetText(TRP2_LOC_NOPLANQUEHERE);
	end
	if i > 42 then
		TRP2_SearchPlanqueListeSlider:Show();
		local total = floor((i-1)/49);
		TRP2_SearchPlanqueListeSlider:SetMinMaxValues(0,total);
	end
	TRP2_SearchPlanqueListeSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_LoadSearchPlanqueListPage(self:GetValue());
		end
	end)
	TRP2_LoadSearchPlanqueListPage(0);
end

function TRP2_LoadSearchPlanqueListPage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_SearchPlanqueListeSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	table.foreach(TRP2_PlanqueList,
	function(TabIndex)
		if i > num*49 and i <= (num+1)*49 then
			local ID = TRP2_PlanqueList[TabIndex]; -- ID = Nom du joueur qui possède la planque
			local planqueTab = TRP2_Planques[ID];
			getglobal("TRP2_SearchPlanqueListeSlot"..j):Show();
			getglobal("TRP2_SearchPlanqueListeSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(planqueTab,"Icone","Temp"));
			getglobal("TRP2_SearchPlanqueListeSlot"..j):SetScript("OnClick", function()
				TRP2InventaireFramePlanque:Hide();
				TRP2_SearchPlanqueListe:Hide();
				TRP2_SecureSendAddonMessage("PLIN",planqueTab["ID"],ID);
			end);
			local titre,suite = TRP2_SetPlanquePortraitTooltip(planqueTab,ID);
			TRP2_SetTooltipForFrame(
				getglobal("TRP2_SearchPlanqueListeSlot"..j),
				getglobal("TRP2_SearchPlanqueListeSlot"..j),"RIGHT",0,0,
				titre,suite.."\n\n{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_OPENPLANQUE
			);
			j = j + 1;
		end
		i = i + 1;
	end);
end

------------------------------
-- 1013 : Planques publiques
------------------------------

TRP2_PlanquesPositions = {};

-- Demande des coordonnées des planques sur la carte
function TRP2_GetLocalPlanques()
	if TRP2_GetCurrentMapZone() < 1 then
		TRP2_Error(ERR_CLIENT_LOCKED_OUT);
		return;
	end
	
	local infoTab = {};
	infoTab[1] = TRP2_GetCurrentMapZone();
	TRP2_GetWorldMap().TRP2_Zone = infoTab[1];
	wipe(TRP2_PlanquesPositions);
	TRP2_SendContentToChannel(infoTab,"GetLocalPlanquesCoord");
	TRP2_MapPlanqueUpdate();
end

-- Envoie des données de nos planques
function TRP2_SendCoordonneesPlanque(sender,ZoneID)
	if sender and ZoneID then
		-- Pour chaque planque
		for planqueID,planqueTab in pairs(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"]) do
			-- Si la zone correspond
			if planqueTab["ZoneNum"] == tonumber(ZoneID) then
				-- Si elle est publique
				if TRP2_GetWithDefaut(planqueTab,"bPublic",false) then
					-- Si access
					if TRP2_CheckPlanqueAccess(planqueTab,sender) then
						local Message = planqueID..TRP2_ReservedChar;
						Message = Message..TRP2_GetWithDefaut(planqueTab,"CoordX","0")..TRP2_ReservedChar;
						Message = Message..TRP2_GetWithDefaut(planqueTab,"CoordY","0")..TRP2_ReservedChar;
						Message = Message..TRP2_GetWithDefaut(planqueTab,"Icone","Temp")..TRP2_ReservedChar;
						Message = Message..TRP2_GetWithDefaut(planqueTab,"Nom",TRP2_LOC_NEWPLANQUE);
						TRP2_SecureSendAddonMessage("SNPL",Message,sender);
					end
				end
			end
		end
	end
end

-- Ajout d'une planque dans la liste
function TRP2_AddPlanqueToMapTab(personnage,tab)
	if not TRP2_PlanquesPositions[personnage] then
		TRP2_PlanquesPositions[personnage] = {};
	end
	if not TRP2_PlanquesPositions[personnage][tab[1]] then
		TRP2_PlanquesPositions[personnage][tab[1]] = {};
	end
	TRP2_PlanquesPositions[personnage][tab[1]]["x"] = tonumber(tab[2]);
	TRP2_PlanquesPositions[personnage][tab[1]]["y"] = tonumber(tab[3]);
	TRP2_PlanquesPositions[personnage][tab[1]]["icon"] = tab[4];
	TRP2_PlanquesPositions[personnage][tab[1]]["name"] = tab[5];
	TRP2_MapPlanqueUpdate();
end

--[[
	0, 0.125 : bleu foncé
	0.125, 0.25 : bleu clair
	0.25, 0.375 : rouge
	0.375, 0.5 : jaune
	0.5, 0.625 : vert
	0.625, 0.750 : rouge entouré doré
	0.75, 0.875 : jaune entouré doré
	0.875, 1 : vert entouré doré
]]

-- Update de la map quand on recois une nouvelle planque
function TRP2_MapPlanqueUpdate()
	if not TRP2_GetWorldMap():IsVisible() then
		return;
	end
	-- On cache tout !
	local i = 1;
	while(getglobal("TRP2_WordMapPlayer"..i)) do
		getglobal("TRP2_WordMapPlayer"..i):Hide();
		i = i+1;
	end
	i = 0;
	
	for personame, planques in pairs(TRP2_PlanquesPositions) do
		for planqueID, planqueTab in pairs(planques) do
			i = i+1; -- Compteur de planque totale sur la carte
			-- Création du bouton si il n'existe pas
			local planqueButton = _G["TRP2_WordMapPlayer"..i];
			if not planqueButton then
				planqueButton = CreateFrame("Frame","TRP2_WordMapPlayer"..i,WorldMapButton,"WorldMapRaidUnitTemplate")
			end
			-- On adapte selon la taille de la carte
			local partyX = (planqueTab["x"]/TRP2_PrecisionPlanque) * WorldMapDetailFrame:GetWidth();
			local partyY = ((-planqueTab["y"])/TRP2_PrecisionPlanque) * WorldMapDetailFrame:GetHeight();
			-- Visuel du point
			_G["TRP2_WordMapPlayer"..i.."Icon"]:SetTexture("Interface\\Minimap\\OBJECTICONS");
			_G["TRP2_WordMapPlayer"..i.."Icon"]:SetTexCoord(0.5, 0.625, 0, 0.125);
			-- On place les info dans le bouton
			planqueButton.info = planqueTab;
			-- Tooltip
			planqueButton:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", partyX, partyY);
			planqueButton:SetScript("OnEnter", function(self)
				WorldMapPOIFrame.allowBlobTooltip = false;
				local j=1;
				WorldMapTooltip:Hide();
				WorldMapTooltip:SetOwner(self, "ANCHOR_RIGHT",0,0);
				WorldMapTooltip:AddLine(TRP2_CTS("|TInterface\\ICONS\\ACHIEVEMENT_GUILDPERK_MOBILEBANKING:18:18|t "..TRP2_LOC_PLANQUES.." :"), 1, 1, 1,true);
				while(_G["TRP2_WordMapPlayer"..j]) do
					if _G["TRP2_WordMapPlayer"..j]:IsVisible() and _G["TRP2_WordMapPlayer"..j]:IsMouseOver() then
						local info = _G["TRP2_WordMapPlayer"..j].info;
						if info then
							local icone = " |TInterface\\ICONS\\"..info["icon"]..":18:18|t";
							WorldMapTooltip:AddLine(TRP2_CTS("- "..info["name"]..icone.." ("..planqueTab["x"]..","..planqueTab["y"]..")"), 1, 1, 1,true);
						end
					end
					j = j+1;
				end
				WorldMapTooltip:Show();
			end);
			planqueButton:SetScript("OnLeave", function()
				WorldMapPOIFrame.allowBlobTooltip = true;
				WorldMapTooltip:Hide();
			end);
			planqueButton:Show();
			tinsert(TRP2_MINIMAPBUTTON,1,planqueButton);
		end
	end
end

-- Affichage de NOS planques
function TRP2_ShowMinimapPlanque()
	TRP2_GetWorldMap().TRP2_Zone = TRP2_GetCurrentMapZone();
	local ID = TRP2_GetWorldMap().TRP2_Zone;
	-- On cache tout !
	local i = 1;
	while(getglobal("TRP2_WordMapPlayer"..i)) do
		getglobal("TRP2_WordMapPlayer"..i):Hide();
		i = i+1;
	end
	i = 0;
	for planqueID,planqueTab in pairs(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"]) do
		if string.find(planqueID,"^"..ID) then
			i = i+1;
			local planqueButton = _G["TRP2_WordMapPlayer"..i];
			local partyX = TRP2_GetWithDefaut(planqueTab,"CoordX",0)/TRP2_PrecisionPlanque;
			local partyY = TRP2_GetWithDefaut(planqueTab,"CoordY",0)/TRP2_PrecisionPlanque;
			if not planqueButton then
				planqueButton = CreateFrame("Frame","TRP2_WordMapPlayer"..i,WorldMapButton,"WorldMapRaidUnitTemplate")
			end
			partyX = partyX * WorldMapDetailFrame:GetWidth();
			partyY = -partyY * WorldMapDetailFrame:GetHeight();
			_G["TRP2_WordMapPlayer"..i.."Icon"]:SetTexture("Interface\\Minimap\\OBJECTICONS");
			_G["TRP2_WordMapPlayer"..i.."Icon"]:SetTexCoord(0.875, 1, 0, 0.125);
			-- Info
			local titre, suite = TRP2_SetPlanquePortraitTooltip(planqueTab,TRP2_Joueur);
			planqueButton.titre = titre;
			planqueButton.suite = suite;
			-- Tooltip
			planqueButton:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", partyX, partyY);
			planqueButton:SetScript("OnEnter", function(self)
				WorldMapPOIFrame.allowBlobTooltip = false;
				local j=1;
				WorldMapTooltip:Hide();
				WorldMapTooltip:SetOwner(self, "ANCHOR_RIGHT",0,0);
				while(_G["TRP2_WordMapPlayer"..j]) do
					if _G["TRP2_WordMapPlayer"..j]:IsVisible() and _G["TRP2_WordMapPlayer"..j]:IsMouseOver() then
						WorldMapTooltip:AddLine(TRP2_CTS(_G["TRP2_WordMapPlayer"..j].titre), 1, 1, 1,true);
						WorldMapTooltip:AddLine(TRP2_CTS(_G["TRP2_WordMapPlayer"..j].suite), 1, 1, 1,true);
					end
					j = j+1;
				end
				WorldMapTooltip:Show();
			end);
			planqueButton:Show();
			tinsert(TRP2_MINIMAPBUTTON,1,planqueButton);
			planqueButton:SetScript("OnLeave", function()
				WorldMapPOIFrame.allowBlobTooltip = true;
				WorldMapTooltip:Hide();
			end);
		end
	end
end

function TRP2_DD_PlanqueAndPanneau(frame,level,menuList)
-- General
	UIDropDownMenu_SetWidth(frame, 20);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
-- Planques title
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_PLANQUESMANAGE;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	local planqueTab = TRP2_DetectAndGetPlanque(true);
	-- Créer une planque
	if not planqueTab and TRP2_CanPlanqueHere(true) then
		info = TRP2_CreateSimpleDDButton();
		info.text = TRP2_LOC_CREATEPLANQUE;
		info.func = function()
			TRP2_ConstructPlanque();
		end;
		UIDropDownMenu_AddButton(info);
	-- Ouvrir planque
	elseif planqueTab then
		info = TRP2_CreateSimpleDDButton();
		info.text = TRP2_LOC_OPENLANQUE;
		info.func = function()
			TRP2_ShowPlanque(TRP2_Joueur,TRP2_GetPlanqueID(true));
		end;
		UIDropDownMenu_AddButton(info);
	end
	-- Lister mes planques
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_ListeVosPlanque;
	info.func = function()
		TRP2_PlanqueListe:Show();
	end;
	UIDropDownMenu_AddButton(info);
	-- Lister planques des autres
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_SEARCHLANQUE;
	info.func = function()
		TRP2_StartSearchPlanque();
	end;
	UIDropDownMenu_AddButton(info);
	
-- Panneau title
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_PANNEAUXMANAGE;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	local panneauTab = TRP2_DetectAndGetPanneau(true);
	-- Créer un panneau
	if not panneauTab and TRP2_CanPlanqueHere(true) then
		info = TRP2_CreateSimpleDDButton();
		info.text = TRP2_LOC_CREATEPANNEAU;
		info.func = function()
			TRP2_ConstructPanneau();
		end;
		UIDropDownMenu_AddButton(info);
	-- Ouvrir panneau
	elseif panneauTab then
		info = TRP2_CreateSimpleDDButton();
		info.text = TRP2_LOC_OPENPANNEAU;
		info.func = function()
			TRP2_ShowPanneau(TRP2_Joueur,TRP2_GetPlanqueID(true));
		end;
		UIDropDownMenu_AddButton(info);
	end
	-- Lister mes panneaux
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_ListeVosPanneau;
	info.func = function()
		TRP2_PanneauListe:Show();
	end;
	UIDropDownMenu_AddButton(info);
	-- Lister panneaux des autres
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_SEARCHPANNEAU;
	info.func = function()
		TRP2_StartSearchPanneau();
	end;
	UIDropDownMenu_AddButton(info);
end